namespace abraIT.Poleg.API;

using Microsoft.Inventory.Tracking;
using Microsoft.Inventory.Item;
using Microsoft.Sales.Document;
using Microsoft.Inventory.Ledger;
using Microsoft.Manufacturing.Document;
using abraIT.Poleg.MainApp;

page 50356 "Prod. Tracking API PLG"
{
    APIGroup = 'poleg';
    APIPublisher = 'abraIT';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'productionTrackingAPI';
    DelayedInsert = true;
    EntityName = 'productionTrackingEntry';
    EntitySetName = 'productionTrackingEntries';
    PageType = API;
    SourceTable = "Package No. Information";
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
                // --- Direct table fields (OData-filterable) ---
                field(palletNo; Rec."Package No.") { Caption = 'Pallet No.'; }
                field(itemNo; Rec."Item No.") { Caption = 'Item No.'; }
                field(variantCode; Rec."Variant Code") { Caption = 'Variant Code'; }
                field(salesOrderNo; Rec."Sales Order No. PLG") { Caption = 'Sales Order No.'; }
                field(salesOrderLineNo; Rec."Sales Order Line No. PLG") { Caption = 'Sales Order Line No.'; }
                field(productionOrderNo; Rec."Reference No. PLG") { Caption = 'Production Order No.'; }
                field(productionOrderLineNo; Rec."Reference Line No. PLG") { Caption = 'Production Order Line No.'; }
                field(statusPLG; Rec."Status PLG") { Caption = 'Status PLG'; }
                field(overallStatusOption; Rec."Overall Status PLG") { Caption = 'Overall Status'; }
                field(sellToCustomerNo; Rec."Sell-to Customer No. PLG") { Caption = 'Sell-to Customer No.'; }
                field(sellToCustomerName; Rec."Sell-to Customer Name PLG") { Caption = 'Sell-to Customer Name'; }
                field(grossWeightKg; Rec."Gross Weight PLG") { Caption = 'Gross Weight (kg)'; }
                field(totalRolls; Rec."Total Rolls PLG") { Caption = 'Total Rolls'; }
                field(totalSqm; Rec."Total Quantity PLG") { Caption = 'Total SQM'; }
                field(netWeightKg; Rec."Net Weight Total PLG") { Caption = 'Net Weight (kg)'; }
                field(totalPalletLengthM; Rec."Total Pallet Length PLG") { Caption = 'Total Pallet Length (m)'; }
                field(palletSequence; Rec."Package Sequence PLG") { Caption = 'Pallet Sequence'; }

                // --- Computed fields ---
                field(itemDescription; ItemDescriptionTxt) { Caption = 'Item Description'; }
                field(billToCustomerNo; BillToCustomerNoTxt) { Caption = 'Bill-to Customer No.'; }
                field(billToCustomerName; BillToCustomerNameTxt) { Caption = 'Bill-to Customer Name'; }
                field(orderedQty; OrderedQtyDec) { Caption = 'Ordered Qty'; }
                field(producedRolls; ProducedRollsInt) { Caption = 'Produced Rolls'; }
                field(progressPct; ProgressPctDec) { Caption = 'Progress (%)'; }
                field(plannedShipDate; PlannedShipDateVal) { Caption = 'Planned Ship Date'; }
                field(actualShipDate; ActualShipDateVal) { Caption = 'Actual Ship Date'; }
                field(shippedQty; ShippedQtyDec) { Caption = 'Shipped Qty'; }
                field(invoicedQty; InvoicedQtyDec) { Caption = 'Invoiced Qty'; }
                field(productionStatusText; ProductionStatusTxt) { Caption = 'Production Status'; }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ClearComputedVariables();

        Rec.CalcFields("Total Rolls PLG", "Total Quantity PLG", "Net Weight Total PLG", "Total Pallet Length PLG");

        PopulateItemDescription();
        PopulateCustomerInfo();
        PopulateOrderedQty();
        PopulateRollsAndProgress();
        PopulateShipDates();
        PopulateShippedAndInvoiced();
        PopulateProductionStatusText();
    end;

    local procedure ClearComputedVariables()
    begin
        Clear(ItemDescriptionTxt);
        Clear(BillToCustomerNoTxt);
        Clear(BillToCustomerNameTxt);
        Clear(OrderedQtyDec);
        Clear(ProducedRollsInt);
        Clear(ProgressPctDec);
        Clear(PlannedShipDateVal);
        Clear(ActualShipDateVal);
        Clear(ShippedQtyDec);
        Clear(InvoicedQtyDec);
        Clear(ProductionStatusTxt);
    end;

    local procedure PopulateItemDescription()
    var
        Item: Record Item;
    begin
        Item.SetLoadFields(Description);
        if Item.Get(Rec."Item No.") then
            ItemDescriptionTxt := Item.Description;
    end;

    local procedure PopulateCustomerInfo()
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.SetLoadFields("Bill-to Customer No.", "Bill-to Name");
        if not SalesHeader.Get(SalesHeader."Document Type"::Order, Rec."Sales Order No. PLG") then
            exit;

        BillToCustomerNoTxt := SalesHeader."Bill-to Customer No.";
        BillToCustomerNameTxt := SalesHeader."Bill-to Name";
    end;

    local procedure PopulateOrderedQty()
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetLoadFields(Quantity, "Planned Shipment Date");
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange("Document No.", Rec."Sales Order No. PLG");
        SalesLine.SetRange("Line No.", Rec."Sales Order Line No. PLG");
        if SalesLine.FindFirst() then begin
            OrderedQtyDec := SalesLine.Quantity;
            PlannedShipDateVal := SalesLine."Planned Shipment Date";
        end;
    end;

    local procedure PopulateRollsAndProgress()
    var
        LotNoInfo: Record "Lot No. Information";
        TotalRolls: Integer;
    begin
        LotNoInfo.SetRange("Package No. PLG", Rec."Package No.");
        LotNoInfo.SetFilter("Actual Length PLG", '>0');
        ProducedRollsInt := LotNoInfo.Count();

        TotalRolls := Rec."Total Rolls PLG";
        if TotalRolls > 0 then
            ProgressPctDec := Round((ProducedRollsInt / TotalRolls) * 100, 0.01);
    end;

    local procedure PopulateShipDates()
    var
        LotNoInfo: Record "Lot No. Information";
    begin
        LotNoInfo.SetLoadFields("Posted Sales Shipment Date PLG");
        LotNoInfo.SetRange("Package No. PLG", Rec."Package No.");
        LotNoInfo.SetFilter("Posted Sales Shipment Date PLG", '<>%1', 0D);
        if LotNoInfo.FindFirst() then
            ActualShipDateVal := LotNoInfo."Posted Sales Shipment Date PLG";
    end;

    local procedure PopulateShippedAndInvoiced()
    var
        LotNoInfo: Record "Lot No. Information";
        ItemLedgerEntry: Record "Item Ledger Entry";
        LotFilter: Text;
    begin
        LotNoInfo.SetRange("Package No. PLG", Rec."Package No.");
        if LotNoInfo.FindSet() then
            repeat
                if LotFilter <> '' then
                    LotFilter += '|';
                LotFilter += LotNoInfo."Lot No.";
            until LotNoInfo.Next() = 0;

        if LotFilter = '' then
            exit;

        ItemLedgerEntry.SetLoadFields(Quantity);
        ItemLedgerEntry.SetFilter("Lot No.", LotFilter);
        ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Sale);

        // Pass 1: Shipped qty
        ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Sales Shipment");
        if ItemLedgerEntry.FindSet() then
            repeat
                ShippedQtyDec += Abs(ItemLedgerEntry.Quantity);
            until ItemLedgerEntry.Next() = 0;

        // Pass 2: Invoiced qty
        ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Sales Invoice");
        if ItemLedgerEntry.FindSet() then
            repeat
                InvoicedQtyDec += Abs(ItemLedgerEntry.Quantity);
            until ItemLedgerEntry.Next() = 0;
    end;

    local procedure PopulateProductionStatusText()
    var
        ProductionOrder: Record "Production Order";
    begin
        case Rec."Status PLG" of
            Rec."Status PLG"::"Firm Planned Production Order":
                ProductionStatusTxt := 'Firm Planned Production Order';
            Rec."Status PLG"::"Released Production Order":
                begin
                    ProductionOrder.SetLoadFields(Status);
                    ProductionOrder.SetRange("No.", Rec."Reference No. PLG");
                    ProductionOrder.SetRange(Status, ProductionOrder.Status::Released);
                    if ProductionOrder.FindFirst() then
                        ProductionStatusTxt := 'Released Production Order'
                    else
                        ProductionStatusTxt := 'Production Order';
                end;
            Rec."Status PLG"::"Item Ledger Entry":
                ProductionStatusTxt := 'Production Complete';
            else
                ProductionStatusTxt := '';
        end;
    end;

    var
        ItemDescriptionTxt: Text[100];
        BillToCustomerNoTxt: Code[20];
        BillToCustomerNameTxt: Text[100];
        OrderedQtyDec: Decimal;
        ProducedRollsInt: Integer;
        ProgressPctDec: Decimal;
        PlannedShipDateVal: Date;
        ActualShipDateVal: Date;
        ShippedQtyDec: Decimal;
        InvoicedQtyDec: Decimal;
        ProductionStatusTxt: Text[100];
}
