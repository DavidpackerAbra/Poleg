namespace Poleg.API;

using abraIT.Poleg.MainApp;

page 50367 "Cost Share Summary API PLG"
{
    APIGroup = 'poleg';
    APIPublisher = 'abraIT';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'costShareSummaryAPIPLG';
    DeleteAllowed = false;
    EntityName = 'costShareSummary';
    EntitySetName = 'costShareSummaries';
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = API;
    SourceTable = "Cost Share Summary PLG";

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
                field(bomCostPerUM; Rec."BOM Cost per U/M")
                {
                    Caption = 'BOM Cost per U/M';
                }
            }
        }
    }
}
