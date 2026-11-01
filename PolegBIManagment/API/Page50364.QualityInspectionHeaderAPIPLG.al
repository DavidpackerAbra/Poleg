namespace Poleg.API;

using Microsoft.QualityManagement.Document;
using abraIT.Poleg.MainApp;

page 50364 "Qlty. Insp. Header API PLG"
{
    APIGroup = 'poleg';
    APIPublisher = 'abraIT';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'qualityInspectionHeadersAPIPLG';
    DelayedInsert = false;
    EntityName = 'qualityInspectionHeader';
    EntitySetName = 'qualityInspectionHeaders';
    PageType = API;
    SourceTable = "Qlty. Inspection Header";
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
                field(no; Rec."No.") { Caption = 'No.'; }
                field(reInspectionNo; Rec."Re-inspection No.") { Caption = 'Re-inspection No.'; }
                field(mostRecentReInspection; Rec."Most Recent Re-inspection") { Caption = 'Most Recent Re-inspection'; }
                field(templateCode; Rec."Template Code") { Caption = 'Template Code'; }
                field(description; Rec.Description) { Caption = 'Description'; }
                field(status; Rec.Status) { Caption = 'Status'; }
                field(sourceQuantityBase; Rec."Source Quantity (Base)") { Caption = 'Source Quantity (Base)'; }
                field(passQuantity; Rec."Pass Quantity") { Caption = 'Pass Quantity'; }
                field(failQuantity; Rec."Fail Quantity") { Caption = 'Fail Quantity'; }
                field(sampleSize; Rec."Sample Size") { Caption = 'Sample Size'; }
                field(assignedUserId; Rec."Assigned User ID") { Caption = 'Assigned User ID'; }
                field(plannedStartDate; Rec."Planned Start Date") { Caption = 'Planned Start Date'; }
                field(finishedDate; Rec."Finished Date") { Caption = 'Finished Date'; }
                field(finishedByUserId; Rec."Finished By User ID") { Caption = 'Finished By User ID'; }
                field(resultCode; Rec."Result Code") { Caption = 'Result Code'; }
                field(resultDescription; Rec."Result Description") { Caption = 'Result Description'; }
                field(evaluationSequence; Rec."Evaluation Sequence") { Caption = 'Evaluation Sequence'; }
                field(locationCode; Rec."Location Code") { Caption = 'Location Code'; }
                field(mostRecentPicture; Rec."Most Recent Picture") { Caption = 'Most Recent Picture'; }
                field(existingInspectionsThisRec; Rec."Existing Inspections This Rec.") { Caption = 'Existing Inspections This Rec.'; }
                field(existingInspectionsThisItem; Rec."Existing Inspections This Item") { Caption = 'Existing Inspections This Item'; }
                field(sourceTableNo; Rec."Source Table No.") { Caption = 'Source Table No.'; }
                field(sourceTableName; Rec."Source Table Name") { Caption = 'Source Table Name'; }
                field(sourceType; Rec."Source Type") { Caption = 'Source Type'; }
                field(sourceSubType; Rec."Source Sub Type") { Caption = 'Source Sub Type'; }
                field(sourceDocumentNo; Rec."Source Document No.") { Caption = 'Source Document No.'; }
                field(sourceDocumentLineNo; Rec."Source Document Line No.") { Caption = 'Source Document Line No.'; }
                field(sourceTaskNo; Rec."Source Task No.") { Caption = 'Source Task No.'; }
                field(sourceItemNo; Rec."Source Item No.") { Caption = 'Source Item No.'; }
                field(sourceVariantCode; Rec."Source Variant Code") { Caption = 'Source Variant Code'; }
                field(sourceSerialNo; Rec."Source Serial No.") { Caption = 'Source Serial No.'; }
                field(sourceLotNo; Rec."Source Lot No.") { Caption = 'Source Lot No.'; }
                field(sourcePackageNo; Rec."Source Package No.") { Caption = 'Source Package No.'; }
                field(triggerRecordTableNo; Rec."Trigger Record Table No.") { Caption = 'Trigger Record Table No.'; }
                field(triggerRecordId; Rec."Trigger RecordId") { Caption = 'Trigger RecordId'; }
                field(sourceRecordTableNo; Rec."Source Record Table No.") { Caption = 'Source Record Table No.'; }
                field(sourceRecordId; Rec."Source RecordId") { Caption = 'Source RecordId'; }
                field(sourceRecordId2; Rec."Source RecordId 2") { Caption = 'Source RecordId 2'; }
                field(sourceRecordId3; Rec."Source RecordId 3") { Caption = 'Source RecordId 3'; }
                field(sourceRecordId4; Rec."Source RecordId 4") { Caption = 'Source RecordId 4'; }
                field(sourceCustom1; Rec."Source Custom 1") { Caption = 'Source Custom 1'; }
                field(sourceCustom2; Rec."Source Custom 2") { Caption = 'Source Custom 2'; }
                field(sourceCustom3; Rec."Source Custom 3") { Caption = 'Source Custom 3'; }
                field(sourceCustom4; Rec."Source Custom 4") { Caption = 'Source Custom 4'; }
                field(sourceCustom5; Rec."Source Custom 5") { Caption = 'Source Custom 5'; }
                field(sourceCustom6; Rec."Source Custom 6") { Caption = 'Source Custom 6'; }
                field(sourceCustom7; Rec."Source Custom 7") { Caption = 'Source Custom 7'; }
                field(sourceCustom8; Rec."Source Custom 8") { Caption = 'Source Custom 8'; }
                field(sourceCustom9; Rec."Source Custom 9") { Caption = 'Source Custom 9'; }
                field(sourceCustom10; Rec."Source Custom 10") { Caption = 'Source Custom 10'; }
                field(itemDescriptionPLG; Rec."Item Description PLG") { Caption = 'Item Description'; }
                field(salesOrderNoPLG; Rec."Sales Order No. PLG") { Caption = 'Sales Order No.'; }
                field(sellToCustomerNoPLG; Rec."Sell-to Customer No. PLG") { Caption = 'Sell-to Customer No.'; }
                field(sellToCustomerNamePLG; Rec."Sell-to Customer Name PLG") { Caption = 'Sell-to Customer Name'; }
                field(operatorName; Rec."Operator Name") { Caption = 'Operator Name'; }
                field(checkerName; Rec."Checker Name") { Caption = 'Checker Name'; }
                field(systemId; Rec.SystemId) { Caption = 'SystemId'; }
                field(systemCreatedAt; Rec.SystemCreatedAt) { Caption = 'SystemCreatedAt'; }
                field(systemCreatedBy; Rec.SystemCreatedBy) { Caption = 'SystemCreatedBy'; }
                field(systemModifiedAt; Rec.SystemModifiedAt) { Caption = 'SystemModifiedAt'; }
                field(systemModifiedBy; Rec.SystemModifiedBy) { Caption = 'SystemModifiedBy'; }
                field(systemRowVersion; Rec.SystemRowVersion) { Caption = 'SystemRowVersion'; }
            }
        }
    }
}
