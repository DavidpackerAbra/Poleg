namespace Poleg.API;

using Microsoft.Manufacturing.Document;
using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.Capacity;
using Microsoft.Sales.Document;
using abraIT.Poleg.MainApp;

page 50343 "Production Orders API PLG"
{
    APIGroup = 'bi';
    APIPublisher = 'poleg';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'productionOrdersAPI';
    DelayedInsert = true;
    EntityName = 'productionOrder';
    EntitySetName = 'productionOrders';
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
                field(productionOrderNo; Rec."Prod. Order No.")
                {
                    Caption = 'Production Order No.';
                }
                field(linkedCustomerOrder; CustomerOrderNoTxt)
                {
                    Caption = 'Linked Customer Order';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(itemDescription; Rec.Description)
                {
                    Caption = 'Item Description';
                }
                field(quantityProduced; Rec."Finished Quantity")
                {
                    Caption = 'Quantity Produced';
                }
                field(quantityKG; QuantityKG)
                {
                    Caption = 'Quantity (KG)';
                }
                field(quantityLengthMeters; QuantityLengthMeters)
                {
                    Caption = 'Quantity Length (Meters)';
                }
                field(quantityPlanned; Rec.Quantity)
                {
                    Caption = 'Quantity Planned';
                }
                field(quantityKGPlanned; QuantityKGPlanned)
                {
                    Caption = 'Quantity (KG) Planned';
                }
                field(quantityLengthMetersPlanned; QuantityLengthMetersPlanned)
                {
                    Caption = 'Quantity Length (Meters) Planned';
                }
                field(workCenter; Rec."Work Center Code PLG")
                {
                    Caption = 'Work Center';
                }
                field(startingDate; StartingDateTxt)
                {
                    Caption = 'Starting Date';
                }
                field(endingDate; EndingDateTxt)
                {
                    Caption = 'Ending Date';
                }
                field(costCalculation; CostCalculationTxt)
                {
                    Caption = 'Cost Calculation';
                }
                field(materialsDetails; MaterialsDetailsTxt)
                {
                    Caption = 'Materials Details';
                }
            }
        }
    }

    var
        CustomerOrderNoTxt: Code[20];
        StartingDateTxt: Date;
        EndingDateTxt: Date;
        QuantityKG: Decimal;
        QuantityKGPlanned: Decimal;
        QuantityLengthMeters: Decimal;
        CostCalculationTxt: Decimal;
        MaterialsDetailsTxt: Text[2048];
        QuantityLengthMetersPlanned: Decimal;

    trigger OnAfterGetRecord()
    var
        ProductionOrder: Record "Production Order";
        Item: Record Item;
        ProdOrderComponent: Record "Prod. Order Component";
        ComponentItem: Record Item;
        MaterialsDetailsBuilder: TextBuilder;
        ComponentText: Text;
    begin
        // Initialize variables
        Clear(CustomerOrderNoTxt);
        Clear(StartingDateTxt);
        Clear(EndingDateTxt);
        Clear(QuantityKG);
        Clear(QuantityLengthMeters);
        Clear(QuantityKGPlanned);
        Clear(QuantityLengthMetersPlanned);
        Clear(CostCalculationTxt);
        Clear(MaterialsDetailsTxt);

        // Get Production Order Header information
        if ProductionOrder.Get(Rec.Status, Rec."Prod. Order No.") then begin
            StartingDateTxt := ProductionOrder."Starting Date";
            EndingDateTxt := ProductionOrder."Ending Date";

            // Get linked customer order from Reference No. (custom field)
            CustomerOrderNoTxt := Rec."Reference No. PLG";
        end;

        // Get Item information for calculations
        if Item.Get(Rec."Item No.") then begin
            // Calculate Quantity in KG
            CalculateQuantityKG(Item);

            // Calculate Quantity in Meters (Length)
            CalculateQuantityLengthMeters(Item);
        end;

        // Calculate costs
        CalculateCosts();

        // Build materials details from Prod. Order Components
        BuildMaterialsDetails(MaterialsDetailsBuilder);
        MaterialsDetailsTxt := CopyStr(MaterialsDetailsBuilder.ToText(), 1, MaxStrLen(MaterialsDetailsTxt));
    end;

    local procedure CalculateQuantityKG(var Item: Record Item)
    begin
        QuantityKG := 0;

        if Rec."Unit of Measure Code" = 'SQM' then begin
            // UOM is SQM - calculate KG using weight per SQM
            if Item."Weight Per SQM (kg) PLG" > 0 then begin
                QuantityKG := Rec."Finished Quantity" * Item."Weight Per SQM (kg) PLG";
                QuantityKGPlanned := Rec.Quantity * Item."Weight Per SQM (kg) PLG";
            end
        end else
            if Rec."Unit of Measure Code" = 'KG' then begin
                // UOM is KG - use finished quantity directly
                QuantityKG := Rec."Finished Quantity";
                QuantityKGPlanned := Rec.Quantity;
            end;
    end;

    local procedure CalculateQuantityLengthMeters(var Item: Record Item)
    var
        RollWidthMM: Decimal;
    begin
        QuantityLengthMeters := 0;

        // Only calculate length for rolls (SQM UOM)
        if Rec."Unit of Measure Code" = 'SQM' then begin
            RollWidthMM := Item."Roll Width (mm) PLG";
            if RollWidthMM > 0 then begin
                // Length (m) = Area (sqm) / Width (m)
                // Convert width from mm to m
                QuantityLengthMeters := Rec."Finished Quantity" / (RollWidthMM / 1000);
                QuantityLengthMetersPlanned := Rec.Quantity / (RollWidthMM / 1000);
            end;
        end;
    end;

    local procedure CalculateCosts()
    begin
        CostCalculationTxt := 0;

        // Calculate total cost from production order line
        CostCalculationTxt := Rec."Cost Amount";
    end;

    local procedure BuildMaterialsDetails(var MaterialsDetailsBuilder: TextBuilder)
    var
        ProdOrderComponent: Record "Prod. Order Component";
        ComponentItem: Record Item;
        ComponentText: Text;
        FirstLine: Boolean;
    begin
        FirstLine := true;

        // Get all components for this production order line
        ProdOrderComponent.SetRange(Status, Rec.Status);
        ProdOrderComponent.SetRange("Prod. Order No.", Rec."Prod. Order No.");
        ProdOrderComponent.SetRange("Prod. Order Line No.", Rec."Line No.");

        if ProdOrderComponent.FindSet() then
            repeat
                if not FirstLine then
                    MaterialsDetailsBuilder.Append('; ');

                // Build component detail string: Item No. - Description - Qty - UOM - Cost
                ComponentText := StrSubstNo('%1 - %2: %3 %4 (Cost: %5)',
                    ProdOrderComponent."Item No.",
                    ProdOrderComponent.Description,
                    Format(ProdOrderComponent."Expected Quantity", 0, '<Precision,2:2><Standard Format,0>'),
                    ProdOrderComponent."Unit of Measure Code",
                    Format(ProdOrderComponent."Cost Amount", 0, '<Precision,2:2><Standard Format,0>'));

                MaterialsDetailsBuilder.Append(ComponentText);
                FirstLine := false;
            until ProdOrderComponent.Next() = 0;
    end;
}
