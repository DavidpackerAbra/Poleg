namespace Poleg.API;

using Microsoft.Manufacturing.Document;

page 50359 "Prod. Order Comp. API PLG"
{
    APIGroup = 'bi';
    APIPublisher = 'poleg';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'prodOrderComponentsAPI';
    DelayedInsert = true;
    EntityName = 'productionOrderComponent';
    EntitySetName = 'productionOrderComponents';
    PageType = API;
    SourceTable = "Prod. Order Component";
    ODataKeyFields = SystemId;
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
                field(systemId; Rec.SystemId)
                {
                    Caption = 'System ID';
                    Editable = false;
                }
                field(status; Format(Rec.Status))
                {
                    Caption = 'Status';
                }
                field(prodOrderNo; Rec."Prod. Order No.")
                {
                    Caption = 'Production Order No.';
                }
                field(prodOrderLineNo; Rec."Prod. Order Line No.")
                {
                    Caption = 'Production Order Line No.';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(quantityPer; Rec."Quantity per")
                {
                    Caption = 'Quantity per';
                }
                field(expectedQuantity; Rec."Expected Quantity")
                {
                    Caption = 'Expected Quantity';
                }
                field(remainingQuantity; Rec."Remaining Quantity")
                {
                    Caption = 'Remaining Quantity';
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                }
            }
        }
    }
}
