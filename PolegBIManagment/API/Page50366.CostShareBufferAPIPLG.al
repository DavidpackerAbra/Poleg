namespace Poleg.API;

using abraIT.Poleg.MainApp;

page 50366 "Cost Share Buffer API PLG"
{
    APIGroup = 'poleg';
    APIPublisher = 'abraIT';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'costShareBufferAPIPLG';
    DeleteAllowed = false;
    EntityName = 'costShareDetail';
    EntitySetName = 'costShareDetails';
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = API;
    SourceTable = "Cost Share Buffer PLG";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(calculationDate; Rec."Calculation Date")
                {
                    Caption = 'Calculation Date';
                }
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(indentation; Rec.Indentation)
                {
                    Caption = 'Indentation';
                }
                field(type; Rec.Type)
                {
                    Caption = 'Type';
                }
                field(number; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                }
                field(variantCode; Rec."Variant Code")
                {
                    Caption = 'Variant Code';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(replenishmentSystem; Rec."Replenishment System")
                {
                    Caption = 'Replenishment System';
                }
                field(isLeaf; Rec."Is Leaf")
                {
                    Caption = 'Is Leaf';
                }
                field(bottleneck; Rec.Bottleneck)
                {
                    Caption = 'Bottleneck';
                }
                field(lotSize; Rec."Lot Size")
                {
                    Caption = 'Lot Size';
                }
                field(lowLevelCode; Rec."Low-Level Code")
                {
                    Caption = 'Low-Level Code';
                }
                field(roundingPrecision; Rec."Rounding Precision")
                {
                    Caption = 'Rounding Precision';
                }
                field(qtyPerParent; Rec."Qty. per Parent")
                {
                    Caption = 'Qty. per Parent';
                }
                field(qtyPerTopItem; Rec."Qty. per Top Item")
                {
                    Caption = 'Qty. per Top Item';
                }
                field(ableToMakeTopItem; Rec."Able to Make Top Item")
                {
                    Caption = 'Able to Make Top Item';
                }
                field(ableToMakeParent; Rec."Able to Make Parent")
                {
                    Caption = 'Able to Make Parent';
                }
                field(availableQuantity; Rec."Available Quantity")
                {
                    Caption = 'Available Quantity';
                }
                field(grossRequirement; Rec."Gross Requirement")
                {
                    Caption = 'Gross Requirement';
                }
                field(scheduledReceipts; Rec."Scheduled Receipts")
                {
                    Caption = 'Scheduled Receipts';
                }
                field(unusedQuantity; Rec."Unused Quantity")
                {
                    Caption = 'Unused Quantity';
                }
                field(rolledUpLeadTimeOffset; Rec."Rolled-up Lead-Time Offset")
                {
                    Caption = 'Rolled-up Lead-Time Offset';
                }
                field(neededByDate; Rec."Needed by Date")
                {
                    Caption = 'Needed by Date';
                }
                field(unitCost; Rec."Unit Cost")
                {
                    Caption = 'Unit Cost';
                }
                field(indirectCostPct; Rec."Indirect Cost %")
                {
                    Caption = 'Indirect Cost %';
                }
                field(overheadRate; Rec."Overhead Rate")
                {
                    Caption = 'Overhead Rate';
                }
                field(scrapPct; Rec."Scrap %")
                {
                    Caption = 'Scrap %';
                }
                field(scrapQtyPerParent; Rec."Scrap Qty. per Parent")
                {
                    Caption = 'Scrap Qty. per Parent';
                }
                field(scrapQtyPerTopItem; Rec."Scrap Qty. per Top Item")
                {
                    Caption = 'Scrap Qty. per Top Item';
                }
                field(resourceUsageType; Rec."Resource Usage Type")
                {
                    Caption = 'Resource Usage Type';
                }
                field(singleLevelMaterialCost; Rec."Single-Level Material Cost")
                {
                    Caption = 'Single-Level Material Cost';
                }
                field(singleLevelCapacityCost; Rec."Single-Level Capacity Cost")
                {
                    Caption = 'Single-Level Capacity Cost';
                }
                field(singleLevelCapOvhdCost; Rec."Single-Level Cap. Ovhd Cost")
                {
                    Caption = 'Single-Level Cap. Ovhd Cost';
                }
                field(singleLevelSubcontrdCost; Rec."Single-Level Subcontrd. Cost")
                {
                    Caption = 'Single-Level Subcontrd. Cost';
                }
                field(singleLevelMfgOvhdCost; Rec."Single-Level Mfg. Ovhd Cost")
                {
                    Caption = 'Single-Level Mfg. Ovhd Cost';
                }
                field(singleLevelScrapCost; Rec."Single-Level Scrap Cost")
                {
                    Caption = 'Single-Level Scrap Cost';
                }
                field(rolledUpMaterialCost; Rec."Rolled-up Material Cost")
                {
                    Caption = 'Rolled-up Material Cost';
                }
                field(rolledUpCapacityCost; Rec."Rolled-up Capacity Cost")
                {
                    Caption = 'Rolled-up Capacity Cost';
                }
                field(rolledUpSubcontractedCost; Rec."Rolled-up Subcontracted Cost")
                {
                    Caption = 'Rolled-up Subcontracted Cost';
                }
                field(rolledUpCapOvhdCost; Rec."Rolled-up Capacity Ovhd. Cost")
                {
                    Caption = 'Rolled-up Capacity Ovhd. Cost';
                }
                field(rolledUpMfgOvhdCost; Rec."Rolled-up Mfg. Ovhd Cost")
                {
                    Caption = 'Rolled-up Mfg. Ovhd Cost';
                }
                field(rolledUpScrapCost; Rec."Rolled-up Scrap Cost")
                {
                    Caption = 'Rolled-up Scrap Cost';
                }
                field(singleLevelMatNonInvtCost; Rec."Single-Lvl Mat. Non-Invt. Cost")
                {
                    Caption = 'Single-Lvl Mat. Non-Invt. Cost';
                }
                field(rolledUpMatNonInvtCost; Rec."Rolled-up Mat. Non-Invt. Cost")
                {
                    Caption = 'Rolled-up Mat. Non-Invt. Cost';
                }
                field(totalCost; Rec."Total Cost")
                {
                    Caption = 'Total Cost';
                }
                field(bomUnitOfMeasureCode; Rec."BOM Unit of Measure Code")
                {
                    Caption = 'BOM Unit of Measure Code';
                }
                field(qtyPerBOMLine; Rec."Qty. per BOM Line")
                {
                    Caption = 'Qty. per BOM Line';
                }
                field(inventoriable; Rec.Inventoriable)
                {
                    Caption = 'Inventoriable';
                }
                field(calculationFormula; Rec."Calculation Formula")
                {
                    Caption = 'Calculation Formula';
                }
            }
        }
    }
}
