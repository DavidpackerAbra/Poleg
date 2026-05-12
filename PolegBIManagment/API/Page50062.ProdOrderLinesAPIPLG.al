namespace Poleg.API;

using Microsoft.Manufacturing.Document;
using abraIT.Poleg.MainApp;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Ledger;

page 50362 "Prod Order Lines API PLG"
{
    APIGroup = 'bi';
    APIPublisher = 'poleg';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'prodOrderLinesAPI';
    DelayedInsert = true;
    EntityName = 'prodOrderLine';
    EntitySetName = 'prodOrderLines';
    PageType = API;
    SourceTable = "Prod. Order Line";
    SourceTableView = where(Status = filter(Released | Finished));
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
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(prodOrderNo; Rec."Prod. Order No.")
                {
                    Caption = 'Production Order No.';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(variantCode; Rec."Variant Code")
                {
                    Caption = 'Variant Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(description2; Rec."Description 2")
                {
                    Caption = 'Description 2';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(binCode; Rec."Bin Code")
                {
                    Caption = 'Bin Code';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(finishedQuantity; Rec."Finished Quantity")
                {
                    Caption = 'Finished Quantity';
                }
                field(remainingQuantity; Rec."Remaining Quantity")
                {
                    Caption = 'Remaining Quantity';
                }
                field(remainingQtyBase; Rec."Remaining Qty. (Base)")
                {
                    Caption = 'Remaining Quantity (Base)';
                }
                field(scrapPercent; Rec."Scrap %")
                {
                    Caption = 'Scrap %';
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }
                field(startingDate; Rec."Starting Date")
                {
                    Caption = 'Starting Date';
                }
                field(startingTime; Rec."Starting Time")
                {
                    Caption = 'Starting Time';
                }
                field(endingDate; Rec."Ending Date")
                {
                    Caption = 'Ending Date';
                }
                field(endingTime; Rec."Ending Time")
                {
                    Caption = 'Ending Time';
                }
                field(planningFlexibility; Rec."Planning Flexibility")
                {
                    Caption = 'Planning Flexibility';
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                }
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                    Caption = 'Quantity per Unit of Measure';
                }
                field(quantityBase; Rec."Quantity (Base)")
                {
                    Caption = 'Quantity (Base)';
                }
                field(finishedQtyBase; Rec."Finished Qty. (Base)")
                {
                    Caption = 'Finished Quantity (Base)';
                }
                field(routingNo; Rec."Routing No.")
                {
                    Caption = 'Routing No.';
                }
                field(routingReferenceNo; Rec."Routing Reference No.")
                {
                    Caption = 'Routing Reference No.';
                }
                field(productionBOMNo; Rec."Production BOM No.")
                {
                    Caption = 'Production BOM No.';
                }
                field(productionBOMVersionCode; Rec."Production BOM Version Code")
                {
                    Caption = 'Production BOM Version Code';
                }
                field(routingVersionCode; Rec."Routing Version Code")
                {
                    Caption = 'Routing Version Code';
                }
                field(unitCost; Rec."Unit Cost")
                {
                    Caption = 'Unit Cost';
                }
                field(costAmount; Rec."Cost Amount")
                {
                    Caption = 'Cost Amount';
                }
                field(expectedOperationCostAmt; Rec."Expected Operation Cost Amt.")
                {
                    Caption = 'Expected Operation Cost Amount';
                }
                field(expectedComponentCostAmt; Rec."Expected Component Cost Amt.")
                {
                    Caption = 'Expected Component Cost Amount';
                }
                field(reservedQtyBase; Rec."Reserved Qty. (Base)")
                {
                    Caption = 'Reserved Quantity (Base)';
                }
                field(referenceNoPLG; Rec."Reference No. PLG")
                {
                    Caption = 'Reference No. (Sales Order No.)';
                }
                field(referenceLineNoPLG; Rec."Reference Line No. PLG")
                {
                    Caption = 'Reference Line No. (Sales Line No.)';
                }
                field(workCenterCodePLG; Rec."Work Center Code PLG")
                {
                    Caption = 'Work Center Code';
                }
                field(workCenterDescriptionPLG; Rec."Work Center Description PLG")
                {
                    Caption = 'Work Center Description';
                }
                field(quantityKG; QuantityKG)
                {
                    Caption = 'Quantity (KG)';
                }
                field(quantityLengthMeters; QuantityLengthMeters)
                {
                    Caption = 'Quantity Length (Meters)';
                }
                field(productionStartDate; ProductionStartDate)
                {
                    Caption = 'Production Start Date';
                }
                field(productionEndDate; ProductionEndDate)
                {
                    Caption = 'Production End Date';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        Item: Record Item;
        ItemLedgerEntry: Record "Item Ledger Entry";
        RollWidthMM: Decimal;
    begin
        // Initialize values
        QuantityKG := 0;
        QuantityLengthMeters := 0;
        Clear(ProductionStartDate);
        Clear(ProductionEndDate);

        // Calculate weight and length from Item master data
        if Item.Get(Rec."Item No.") then begin
            RollWidthMM := Item."Roll Width (mm) PLG";
            if RollWidthMM <> 0 then begin
                QuantityKG := Rec."Finished Quantity" * Item."Weight Per SQM (kg) PLG";
                QuantityLengthMeters := Rec."Finished Quantity" / (RollWidthMM / 1000);
            end;
        end;

        // Get production start date from first output entry
        ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Output);
        ItemLedgerEntry.SetRange("Document No.", Rec."Prod. Order No.");
        ItemLedgerEntry.SetRange("Order Line No.", Rec."Line No.");
        if ItemLedgerEntry.FindFirst() then
            ProductionStartDate := ItemLedgerEntry."Posting Date";

        // Get production end date from last output entry
        if ItemLedgerEntry.FindLast() then
            ProductionEndDate := ItemLedgerEntry."Posting Date";
    end;

    var
        QuantityKG: Decimal;
        QuantityLengthMeters: Decimal;
        ProductionStartDate: Date;
        ProductionEndDate: Date;
}
