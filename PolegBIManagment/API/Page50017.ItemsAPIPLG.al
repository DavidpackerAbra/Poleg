namespace Poleg.API;

using Microsoft.Inventory.Item;
using abraIT.Poleg.MainApp;
using Microsoft.Foundation.UOM;
using Microsoft.Finance.VAT.Setup;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Inventory.Posting;
using Microsoft.Finance.SalesTax;
using Microsoft.Finance.Dimension;

page 50317 "Items API PLG"
{
    APIGroup = 'bi';
    APIPublisher = 'poleg';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'itemsAPIPLG';
    DelayedInsert = true;
    EntityName = 'items';
    EntitySetName = 'items';
    PageType = API;
    SourceTable = Item;
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
                field(no; Rec."No.")
                {
                    Caption = 'Item No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(itemTypeCode; Rec."Type")
                {
                    Caption = 'Item Type Code';
                }
                field(itemTypeDescription; '')
                {
                    Caption = 'Item Type Description';
                }
                field(itemClassCode; Rec."Item Category Code")
                {
                    Caption = 'Item Class Code';
                }
                field(itemClassDescription; ItemCategoryName)
                {
                    Caption = 'Item Class Description';
                }
                field(itemGroupCode; Rec."Gen. Prod. Posting Group")
                {
                    Caption = 'Item Group Code';
                }
                field(itemGroupDescription; GeneralProductPostingGroupName)
                {
                    Caption = 'Item Group Description';
                }
                field(rollThicknessMicrons; Rec."Roll Thickness (microns) PLG")
                {
                    Caption = 'Roll Thickness (microns)';
                }
                field(rollWidthMm; Rec."Roll Width (mm) PLG")
                {
                    Caption = 'Roll Width (mm)';
                }
                field(maxRollLength; Rec."Max Roll Length PLG")
                {
                    Caption = 'Maximum Roll Length (m)';
                }
                field(colorCode; Rec."Color Code PLG")
                {
                    Caption = 'Color Code';
                }
                field(coreTypeCode; Rec."Core Type Code PLG")
                {
                    Caption = 'Core Type Code';
                }
                field(weightPerSqm; Rec."Weight Per SQM (kg) PLG")
                {
                    Caption = 'Weight Per Square Meter (kg)';
                }
                field(taxGroupCode; TaxGroupCode)
                {
                    Caption = 'Tax Group Code';
                }
                field(taxGroupName; TaxGroupName)
                {
                    Caption = 'Tax Group Name';
                }
                field(baseUnitOfMeasureCode; Rec."Base Unit of Measure")
                {
                    Caption = 'Base Unit of Measure Code';
                }
                field(baseUnitOfMeasureName; BaseUnitOfMeasureName)
                {
                    Caption = 'Base Unit of Measure Name';
                }

                field(inventoryPostingGroupCode; Rec."Inventory Posting Group")
                {
                    Caption = 'Inventory Posting Group Code';
                }
                field(inventoryPostingGroupName; InventoryPostingGroupName)
                {
                    Caption = 'Inventory Posting Group Name';
                }
                field(projectCode; ProjectCode)
                {
                    Caption = 'Project Code';
                }
                field(projectName; ProjectName)
                {
                    Caption = 'Project Name';
                }
            }
        }
    }

    var
        ItemCategoryName: Text[100];
        TaxGroupName: Text[100];
        BaseUnitOfMeasureName: Text[50];
        GeneralProductPostingGroupName: Text[100];
        TaxGroupCode: Code[20];
        InventoryPostingGroupName: Text[100];
        ProjectCode: Code[20];
        ProjectName: Text[100];
        DefaultDimension: Record "Default Dimension";
        ProjectCodeLbl: Label 'פרויקט';

    trigger OnAfterGetRecord()
    var
        ItemCategory: Record "Item Category";
        // TaxGroup: Record "Tax Group";
        TaxGroup: Record "VAT Product Posting Group";
        UnitOfMeasure: Record "Unit of Measure";
        GenProductPostingGroup: Record "Gen. Product Posting Group";
        InventoryPostingGroup: Record "Inventory Posting Group";
    begin
        // Item Category Name
        if Rec."Item Category Code" <> '' then begin
            if ItemCategory.Get(Rec."Item Category Code") then
                ItemCategoryName := ItemCategory.Description
            else
                ItemCategoryName := '';
        end else
            ItemCategoryName := '';

        // Tax Group Name
        if Rec."VAT Prod. Posting Group" <> '' then begin
            if TaxGroup.Get(Rec."VAT Prod. Posting Group") then begin
                TaxGroupCode := Rec."Vat Prod. Posting Group";
                TaxGroupName := TaxGroup.Description
            end else
                TaxGroupName := '';
        end else
            TaxGroupName := '';

        // Base Unit of Measure Name
        if Rec."Base Unit of Measure" <> '' then begin
            if UnitOfMeasure.Get(Rec."Base Unit of Measure") then
                BaseUnitOfMeasureName := UnitOfMeasure.Description
            else
                BaseUnitOfMeasureName := '';
        end else
            BaseUnitOfMeasureName := '';

        // General Product Posting Group Name
        if Rec."Gen. Prod. Posting Group" <> '' then begin
            if GenProductPostingGroup.Get(Rec."Gen. Prod. Posting Group") then
                GeneralProductPostingGroupName := GenProductPostingGroup.Description
            else
                GeneralProductPostingGroupName := '';
        end else
            GeneralProductPostingGroupName := '';

        // Inventory Posting Group Name
        if Rec."Inventory Posting Group" <> '' then begin
            if InventoryPostingGroup.Get(Rec."Inventory Posting Group") then
                InventoryPostingGroupName := InventoryPostingGroup.Description
            else
                InventoryPostingGroupName := '';
        end else
            InventoryPostingGroupName := '';

        DefaultDimension.Reset();
        DefaultDimension.SetRange("Table ID", Database::Item);
        DefaultDimension.SetRange("No.", Rec."No.");
        DefaultDimension.SetRange("Dimension Code", ProjectCodeLbl);
        if DefaultDimension.FindFirst() then begin
            DefaultDimension.CalcFields("Dimension Value Name");
            ProjectCode := DefaultDimension."Dimension Value Code";
            ProjectName := DefaultDimension."Dimension Value Name";
            // Here you can add logic to get Project Name if needed
        end else begin
            ProjectCode := '';
            ProjectName := '';
        end;


    end;
}
