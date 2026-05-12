namespace Poleg.API;

using Microsoft.Inventory.Ledger;

page 50344 "Value Entries API PLG"
{
    APIGroup = 'bi';
    APIPublisher = 'poleg';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'Value Entries API PLG';
    DelayedInsert = false;
    EntityName = 'valueEntry';
    EntitySetName = 'valueEntries';
    PageType = API;
    SourceTable = "Value Entry";
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
                // Entry Identification
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }

                // Dates
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }

                // Entry Types
                field(itemLedgerEntryType; GetTextedItemLedgerEntryType(Rec."Item Ledger Entry Type"))
                {
                    Caption = 'Item Ledger Entry Type';
                }
                field(entryType; GetTextedEntryType(Rec."Entry Type"))
                {
                    Caption = 'Entry Type';
                }
                field(adjustment; Rec.Adjustment)
                {
                    Caption = 'Adjustment';
                }

                // Document Information
                field(documentType; GetTextedDocumentType(Rec."Document Type"))
                {
                    Caption = 'Document Type';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }
                field(itemChargeNo; Rec."Item Charge No.")
                {
                    Caption = 'Item Charge No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }

                // Amounts
                field(salesAmountActual; Rec."Sales Amount (Actual)")
                {
                    Caption = 'Sales Amount (Actual)';
                }
                field(costAmountExpected; Rec."Cost Amount (Expected)")
                {
                    Caption = 'Cost Amount (Expected)';
                }
                field(costAmountActual; Rec."Cost Amount (Actual)")
                {
                    Caption = 'Cost Amount (Actual)';
                }
                field(costPostedToGL; Rec."Cost Posted to G/L")
                {
                    Caption = 'Cost Posted to G/L';
                }

                // Quantities
                field(itemLedgerEntryQuantity; Rec."Item Ledger Entry Quantity")
                {
                    Caption = 'Item Ledger Entry Quantity';
                }
                field(valuedQuantity; Rec."Valued Quantity")
                {
                    Caption = 'Valued Quantity';
                }
                field(invoicedQuantity; Rec."Invoiced Quantity")
                {
                    Caption = 'Invoiced Quantity';
                }
                field(costPerUnit; Rec."Cost per Unit")
                {
                    Caption = 'Cost per Unit';
                }

                // Item Information
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }

                // Posting Groups
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                    Caption = 'Gen. Bus. Posting Group';
                }

                // Source Information
                field(sourceType; GetTextedSourceType(Rec."Source Type"))
                {
                    Caption = 'Source Type';
                }
                field(sourceNo; Rec."Source No.")
                {
                    Caption = 'Source No.';
                }

                // Order Information
                field(orderType; GetTextedOrderType(Rec."Order Type"))
                {
                    Caption = 'Order Type';
                }

                // Related Entry Numbers
                field(itemLedgerEntryNo; Rec."Item Ledger Entry No.")
                {
                    Caption = 'Item Ledger Entry No.';
                }
                field(capacityLedgerEntryNo; Rec."Capacity Ledger Entry No.")
                {
                    Caption = 'Capacity Ledger Entry No.';
                }
            }
        }
    }

    local procedure GetTextedEntryType(EntryType: Enum Microsoft.Inventory.Costing."Cost Entry Type"): Text
    begin
        exit(Format(EntryType));
    end;

    local procedure GetTextedItemLedgerEntryType(ItemLedgerEntryType: Enum Microsoft.Inventory.Ledger."Item Ledger Entry Type"): Text
    begin
        exit(Format(ItemLedgerEntryType));
    end;

    local procedure GetTextedDocumentType(DocumentType: Enum Microsoft.Inventory.Ledger."Item Ledger Document Type"): Text
    begin
        exit(Format(DocumentType));
    end;

    local procedure GetTextedSourceType(SourceType: Enum Microsoft.Foundation.Enums."Analysis Source Type"): Text
    begin
        exit(Format(SourceType));
    end;

    local procedure GetTextedOrderType(OrderType: Enum Microsoft.Foundation.Enums."Inventory Order Type"): Text
    begin
        exit(Format(OrderType));
    end;
}
