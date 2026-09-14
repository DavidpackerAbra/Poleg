namespace Poleg.API;

using Microsoft.QualityManagement.Document;

page 50365 "Qlty. Inspection Line API PLG"
{
    APIGroup = 'poleg';
    APIPublisher = 'abraIT';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'qualityInspectionLinesAPIPLG';
    DelayedInsert = false;
    EntityName = 'qualityInspectionLine';
    EntitySetName = 'qualityInspectionLines';
    PageType = API;
    SourceTable = "Qlty. Inspection Line";
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
                field(inspectionNo; Rec."Inspection No.") { Caption = 'Inspection No.'; }
                field(reInspectionNo; Rec."Re-inspection No.") { Caption = 'Re-inspection No.'; }
                field(lineNo; Rec."Line No.") { Caption = 'Line No.'; }
                field(templateCode; Rec."Template Code") { Caption = 'Template Code'; }
                field(templateLineNo; Rec."Template Line No.") { Caption = 'Template Line No.'; }
                field(testCode; Rec."Test Code") { Caption = 'Test Code'; }
                field(description; Rec.Description) { Caption = 'Description'; }
                field(testValueType; Rec."Test Value Type") { Caption = 'Test Value Type'; }
                field(allowableValues; Rec."Allowable Values") { Caption = 'Allowable Values'; }
                field(testValue; Rec."Test Value") { Caption = 'Test Value'; }
                field(testValueBlob; Rec."Test Value Blob") { Caption = 'Test Value Blob'; }
                field(derivedNumericValue; Rec."Derived Numeric Value") { Caption = 'Derived Numeric Value'; }
                field(resultCode; Rec."Result Code") { Caption = 'Result Code'; }
                field(resultDescription; Rec."Result Description") { Caption = 'Result Description'; }
                field(evaluationSequence; Rec."Evaluation Sequence") { Caption = 'Evaluation Sequence'; }
                field(failureState; Rec."Failure State") { Caption = 'Failure State'; }
                field(nonConformanceInspectionNo; Rec."Non-Conformance Inspection No.") { Caption = 'Non-Conformance Inspection No.'; }
                field(unitOfMeasureCode; Rec."Unit of Measure Code") { Caption = 'Unit of Measure Code'; }
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
