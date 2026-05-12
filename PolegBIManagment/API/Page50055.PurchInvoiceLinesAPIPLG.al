namespace Poleg.API;

using Microsoft.Purchases.History;
using Microsoft.Purchases.Vendor;
using Microsoft.Inventory.Item;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Finance.Currency;

page 50357 "Purch. Invoice Lines API PLG"
{
    APIGroup = 'bi';
    APIPublisher = 'poleg';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'purchaseInvoiceLinesAPI';
    DelayedInsert = true;
    EntityName = 'purchaseInvoiceLine';
    EntitySetName = 'purchaseInvoiceLines';
    PageType = API;
    SourceTable = "Purch. Inv. Line";
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
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(type; Rec.Type)
                {
                    Caption = 'Type';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(description2; Rec."Description 2")
                {
                    Caption = 'Description 2';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(quantityBase; Rec."Quantity (Base)")
                {
                    Caption = 'Quantity (Base)';
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                }
                field(directUnitCost; Rec."Direct Unit Cost")
                {
                    Caption = 'Direct Unit Cost';
                }
                field(unitCostLCY; Rec."Unit Cost (LCY)")
                {
                    Caption = 'Unit Cost (LCY)';
                }
                field(lineAmount; Rec."Line Amount")
                {
                    Caption = 'Line Amount';
                }
                field(lineAmountLCY; LineAmountLCY)
                {
                    Caption = 'Line Amount (LCY)';
                }
                field(vendorNo; VendorNoTxt)
                {
                    Caption = 'Vendor No.';
                }
                field(vendorName; VendorNameTxt)
                {
                    Caption = 'Vendor Name';
                }
                field(postingDate; PostingDateTxt)
                {
                    Caption = 'Posting Date';
                }
                field(currencyCode; CurrencyCodeTxt)
                {
                    Caption = 'Currency Code';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(jobNo; Rec."Job No.")
                {
                    Caption = 'Job No.';
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                }
                field(genBusPostingGroup; GenBusPostingGroupTxt)
                {
                    Caption = 'Gen. Bus. Posting Group';
                }
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                    Caption = 'Gen. Prod. Posting Group';
                }
                field(vatPercent; Rec."VAT %")
                {
                    Caption = 'VAT %';
                }
                field(vendorInvoiceNo; VendorInvoiceNoTxt)
                {
                    Caption = 'Vendor Invoice No.';
                }
            }
        }
    }

    var
        VendorNoTxt: Code[20];
        VendorNameTxt: Text[100];
        PostingDateTxt: Date;
        CurrencyCodeTxt: Code[10];
        GenBusPostingGroupTxt: Code[20];
        VendorInvoiceNoTxt: Code[35];
        LineAmountLCY: Decimal;

    trigger OnAfterGetRecord()
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        Vendor: Record Vendor;
        CurrExchRate: Record "Currency Exchange Rate";
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        // Get header information
        if PurchInvHeader.Get(Rec."Document No.") then begin
            VendorNoTxt := PurchInvHeader."Buy-from Vendor No.";
            PostingDateTxt := PurchInvHeader."Posting Date";
            CurrencyCodeTxt := PurchInvHeader."Currency Code";
            GenBusPostingGroupTxt := PurchInvHeader."Gen. Bus. Posting Group";
            VendorInvoiceNoTxt := PurchInvHeader."Vendor Invoice No.";

            // Get Vendor Name
            if Vendor.Get(VendorNoTxt) then
                VendorNameTxt := Vendor.Name
            else
                VendorNameTxt := '';

            // Calculate Line Amount in LCY
            if CurrencyCodeTxt = '' then begin
                // Already in LCY
                LineAmountLCY := Rec."Line Amount";
            end else begin
                // Convert to LCY
                if GeneralLedgerSetup.Get() then;
                LineAmountLCY := CurrExchRate.ExchangeAmtFCYToLCY(
                    PostingDateTxt,
                    CurrencyCodeTxt,
                    Rec."Line Amount",
                    PurchInvHeader."Currency Factor");
            end;
        end else begin
            VendorNoTxt := '';
            VendorNameTxt := '';
            PostingDateTxt := 0D;
            CurrencyCodeTxt := '';
            GenBusPostingGroupTxt := '';
            VendorInvoiceNoTxt := '';
            LineAmountLCY := 0;
        end;
    end;
}
