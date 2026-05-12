namespace Poleg.API;

using Microsoft.Finance.VAT.Ledger;
using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Finance.GeneralLedger.Account;

page 50363 "VAT Entries API PLG"
{
    APIGroup = 'bi';
    APIPublisher = 'poleg';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'VAT Entries API PLG';
    DelayedInsert = false;
    EntityName = 'vatEntry';
    EntitySetName = 'vatEntries';
    PageType = API;
    SourceTable = "VAT Entry";
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
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(vatRun; Rec."VAT Run")
                {
                    Caption = 'VAT Run';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(vatDate; Rec."VAT Reporting Date")
                {
                    Caption = 'VAT Date';
                }
                field(documentDate; Rec."Document Date")
                {
                    Caption = 'Document Date';
                }
                field(documentType; Format(Rec."Document Type"))
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
                field(type; Format(Rec.Type))
                {
                    Caption = 'Type';
                }
                field(vatCalculationType; Format(Rec."VAT Calculation Type"))
                {
                    Caption = 'VAT Calculation Type';
                }
                field(vatBusPostingGroup; Rec."VAT Bus. Posting Group")
                {
                    Caption = 'VAT Bus. Posting Group';
                }
                field(vatProdPostingGroup; Rec."VAT Prod. Posting Group")
                {
                    Caption = 'VAT Prod. Posting Group';
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                    Caption = 'Gen. Bus. Posting Group';
                }
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                    Caption = 'Gen. Prod. Posting Group';
                }
                field(glAccountNo; GLAccountNoTxt)
                {
                    Caption = 'G/L Account No.';
                }
                field(glAccountName; GLAccountNameTxt)
                {
                    Caption = 'G/L Account Name';
                }
                field(base; Rec.Base)
                {
                    Caption = 'Base';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(additionalCurrencyBase; Rec."Additional-Currency Base")
                {
                    Caption = 'Additional-Currency Base';
                }
                field(additionalCurrencyAmount; Rec."Additional-Currency Amount")
                {
                    Caption = 'Additional-Currency Amount';
                }
                field(billtoPaytoNo; Rec."Bill-to/Pay-to No.")
                {
                    Caption = 'Bill-to/Pay-to No.';
                }
                field(closed; Rec.Closed)
                {
                    Caption = 'Closed';
                }
                field(transactionNo; Rec."Transaction No.")
                {
                    Caption = 'Transaction No.';
                }
                field(sourceCode; Rec."Source Code")
                {
                    Caption = 'Source Code';
                }
                field(reasonCode; Rec."Reason Code")
                {
                    Caption = 'Reason Code';
                }
                field(eu3PartyTrade; Rec."EU 3-Party Trade")
                {
                    Caption = 'EU 3-Party Trade';
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                }
                field(vatRegistrationNo; Rec."VAT Registration No.")
                {
                    Caption = 'VAT Registration No.';
                }
                field(unrealizedAmount; Rec."Unrealized Amount")
                {
                    Caption = 'Unrealized Amount';
                }
                field(unrealizedBase; Rec."Unrealized Base")
                {
                    Caption = 'Unrealized Base';
                }
                field(remainingUnrealizedAmount; Rec."Remaining Unrealized Amount")
                {
                    Caption = 'Remaining Unrealized Amount';
                }
                field(remainingUnrealizedBase; Rec."Remaining Unrealized Base")
                {
                    Caption = 'Remaining Unrealized Base';
                }
                field(userID; Rec."User ID")
                {
                    Caption = 'User ID';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        GLEntry: Record "G/L Entry";
        GLAccount: Record "G/L Account";
    begin
        GLAccountNoTxt := '';
        GLAccountNameTxt := '';
        GLEntry.Reset();
        GLEntry.SetCurrentKey("Transaction No.");
        GLEntry.SetRange("Transaction No.", Rec."Transaction No.");
        GLEntry.SetFilter("Gen. Posting Type", '<>%1', GLEntry."Gen. Posting Type"::" ");
        if GLEntry.FindFirst() then begin
            GLAccountNoTxt := GLEntry."G/L Account No.";
            if GLAccount.Get(GLAccountNoTxt) then
                GLAccountNameTxt := GLAccount.Name;
        end;
    end;

    var
        GLAccountNoTxt: Code[20];
        GLAccountNameTxt: Text[100];
}
