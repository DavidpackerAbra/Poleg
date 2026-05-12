namespace Poleg.API;

using Microsoft.Sales.Document;
using Microsoft.Sales.History;
using Microsoft.Sales.Customer;
using Microsoft.Inventory.Item;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Finance.Currency;

page 50339 "Sales Order Lines API PLG"
{
    APIGroup = 'bi';
    APIPublisher = 'poleg';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'salesOrderLinesAPI';
    DelayedInsert = true;
    EntityName = 'salesOrderLine';
    EntitySetName = 'salesOrderLines';
    PageType = API;
    SourceTable = "Sales Line";
    SourceTableView = where("Document Type" = const(Order));
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(company; CompanyName())
                {
                    Caption = 'Company';
                }
                field(customerOrderNo; Rec."Document No.")
                {
                    Caption = 'Customer Order No.';
                }
                field(deliveryNo; DeliveryNoTxt)
                {
                    Caption = 'Delivery No.';
                }
                field(invoiceNumber; InvoiceNumberTxt)
                {
                    Caption = 'Invoice Number';
                }
                field(invoiceDate; InvoiceDateTxt)
                {
                    Caption = 'Invoice Date';
                }
                field(currency; CurrencyTxt)
                {
                    Caption = 'Currency';
                }
                field(lineAmountLocalCurrency; LineAmountLocal)
                {
                    Caption = 'Line Amount Local Currency';
                }
                field(lineAmountForeignCurrency; LineAmountForeign)
                {
                    Caption = 'Line Amount Foreign Currency';
                }
                field(orderDate; OrderDateTxt)
                {
                    Caption = 'Order Date';
                }
                field(orderType; '')
                {
                    Caption = 'Order Type';
                }
                field(customerNumber; CustomerNoTxt)
                {
                    Caption = 'Customer Number';
                }
                field(customerName; CustomerNameTxt)
                {
                    Caption = 'Customer Name';
                }
                field(itemNo; Rec."No.")
                {
                    Caption = 'Item No.';
                }
                field(itemDescription; Rec.Description)
                {
                    Caption = 'Item Description';
                }
                field(unit; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(quantityBase; Rec."Quantity (Base)")
                {
                    Caption = 'Quantity (Base)';
                }
                field(quantitySQM; QuantitySQM)
                {
                    Caption = 'Quantity (SQM)';
                }
                field(adjustQty; rec."Adjusted Quantity PLG")
                {
                    Caption = 'Adjusted Quantity (SQM)';
                }
                field(quantityKG; QuantityKG)
                {
                    Caption = 'Quantity (KG)';
                }
                field(accountCode; AccountCodeTxt)
                {
                    Caption = 'Account Code';
                }
                field(accountName; AccountNameTxt)
                {
                    Caption = 'Account Name';
                }
                field(materialsCost; 0)
                {
                    Caption = 'Materials Cost';
                }
                field(productionEndDate; Rec."Production End Date PLG")
                {
                    Caption = 'Production End Date';
                }
            }
        }
    }

    var
        DeliveryNoTxt: Code[20];
        CurrencyTxt: Code[10];
        LineAmountLocal: Decimal;
        LineAmountForeign: Decimal;
        OrderDateTxt: Date;
        CustomerNoTxt: Code[20];
        CustomerNameTxt: Text[100];
        AccountCodeTxt: Code[20];
        AccountNameTxt: Text[100];
        QuantitySQM: Decimal;
        QuantityKG: Decimal;
        InvoiceNumberTxt: Code[20];
        InvoiceDateTxt: Date;

    trigger OnAfterGetRecord()
    var
        SalesHeader: Record "Sales Header";
        Customer: Record Customer;
        Item: Record Item;
        GLAccount: Record "G/L Account";
        GenProdPostingGroup: Record "Gen. Product Posting Group";
        GeneralPostingSetup: Record "General Posting Setup";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
    begin
        // Get Sales Header information
        if SalesHeader.Get(Rec."Document Type", Rec."Document No.") then begin
            OrderDateTxt := SalesHeader."Order Date";
            CustomerNoTxt := SalesHeader."Sell-to Customer No.";
            CustomerNameTxt := SalesHeader."Sell-to Customer Name";

            // Currency handling
            if SalesHeader."Currency Code" = '' then
                CurrencyTxt := 'ILS'
            else
                CurrencyTxt := SalesHeader."Currency Code";
        end;

        // Calculate line amounts
        if CurrencyTxt = 'ILS' then begin
            LineAmountLocal := Rec."Line Amount";
            LineAmountForeign := Rec."Line Amount";
        end else begin
            LineAmountLocal := CurrencyExchangeRate.ExchangeAmtFCYToLCY(SalesHeader."Posting Date",
                SalesHeader."Currency Code", Rec."Line Amount", SalesHeader."Currency Factor");  // Would need currency conversion
            LineAmountForeign := Rec."Line Amount";
        end;

        // Delivery No. - empty for non-shipped orders
        DeliveryNoTxt := '';

        // Get Invoice information if exists
        InvoiceNumberTxt := '';
        InvoiceDateTxt := 0D;
        GetInvoiceInfo();

        // Get Account Code and Name from General Posting Setup
        AccountCodeTxt := '';
        AccountNameTxt := '';
        if Rec.Type = Rec.Type::Item then begin
            if Item.Get(Rec."No.") then begin
                // Get sales account from General Posting Setup
                if GeneralPostingSetup.Get(Rec."Gen. Bus. Posting Group", Item."Gen. Prod. Posting Group") then begin
                    AccountCodeTxt := GeneralPostingSetup."Sales Account";
                    if GLAccount.Get(GeneralPostingSetup."Sales Account") then
                        AccountNameTxt := GLAccount.Name;
                end;
            end;
        end;

        // Calculate Quantity in SQM and KG based on UOM
        QuantitySQM := 0;
        QuantityKG := 0;
        if Rec.Type = Rec.Type::Item then begin
            if Item.Get(Rec."No.") then begin
                if Rec."Unit of Measure Code" = 'SQM' then begin
                    // UOM is SQM - Quantity field is in SQM, calculate KG
                    QuantitySQM := Rec.Quantity;
                    if Item."Weight Per SQM (kg) PLG" > 0 then
                        QuantityKG := Rec.Quantity * Item."Weight Per SQM (kg) PLG"
                    else
                        QuantityKG := 0;
                end else if Rec."Unit of Measure Code" = 'KG' then begin
                    // UOM is KG - Quantity field is in KG, SQM is 0
                    QuantityKG := Rec.Quantity;
                    QuantitySQM := 0;
                end else begin
                    // Other UOM - both are 0
                    QuantitySQM := 0;
                    QuantityKG := 0;
                end;
            end;
        end;
    end;

    local procedure GetInvoiceInfo()
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        // Find posted invoice line that links to this order line
        SalesInvoiceLine.SetRange("Order No.", Rec."Document No.");
        SalesInvoiceLine.SetRange("Order Line No.", Rec."Line No.");
        if SalesInvoiceLine.FindFirst() then begin
            InvoiceNumberTxt := SalesInvoiceLine."Document No.";
            // Get the invoice date from the header
            if SalesInvoiceHeader.Get(SalesInvoiceLine."Document No.") then begin
                InvoiceDateTxt := SalesInvoiceHeader."VAT Reporting Date";
                if InvoiceDateTxt = 0D then
                    InvoiceDateTxt := SalesInvoiceHeader."Posting Date";
            end;
        end;
    end;
}
