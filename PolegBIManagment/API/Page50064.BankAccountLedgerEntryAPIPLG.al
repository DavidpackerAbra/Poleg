namespace Poleg.API;

using Microsoft.Bank.Ledger;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Foundation.Enums;

page 50364 "Bank Acc .Ledger Entry API PLG"
{
    APIGroup = 'bi';
    APIPublisher = 'poleg';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'bankAccountLedgerEntryAPIPLG';
    DelayedInsert = true;
    EntityName = 'bankAccountLedgerEntry';
    EntitySetName = 'bankAccountLedgerEntry';
    PageType = API;
    SourceTable = "Bank Account Ledger Entry";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    ODataKeyFields = "Entry No.";

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
                field(bankAccountNo; Rec."Bank Account No.")
                {
                    Caption = 'Bank Account No.';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(remainingAmount; Rec."Remaining Amount")
                {
                    Caption = 'Remaining Amount';
                }
                field(transactionNo; Rec."Transaction No.")
                {
                    Caption = 'Transaction No.';
                }
                field(statementNo; Rec."Statement No.")
                {
                    Caption = 'Statement No.';
                }
                field(statementLineNo; Rec."Statement Line No.")
                {
                    Caption = 'Statement Line No.';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID';
                }
                field(ourContactCode; Rec."Our Contact Code")
                {
                    Caption = 'Our Contact Code';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(amountLCY; Rec."Amount (LCY)")
                {
                    Caption = 'Amount (LCY)';
                }
                field(bankAccPostingGroup; Rec."Bank Acc. Posting Group")
                {
                    Caption = 'Bank Acc. Posting Group';
                }
                field(userID; Rec."User ID")
                {
                    Caption = 'User ID';
                }
                field(sourceCode; Rec."Source Code")
                {
                    Caption = 'Source Code';
                }
                field(reasonCode; Rec."Reason Code")
                {
                    Caption = 'Reason Code';
                }
                field(balAccountType; Rec."Bal. Account Type")
                {
                    Caption = 'Bal. Account Type';
                }
                field(balAccountNo; Rec."Bal. Account No.")
                {
                    Caption = 'Bal. Account No.';
                }
                field(checkLedgerEntries; Rec."Check Ledger Entries")
                {
                    Caption = 'Check Ledger Entries';
                }
                field(open; Rec.Open)
                {
                    Caption = 'Open';
                }
                field(positive; Rec.Positive)
                {
                    Caption = 'Positive';
                }
                field(closedByEntryNo; Rec."Closed by Entry No.")
                {
                    Caption = 'Closed by Entry No.';
                }
                field(closedAtDate; Rec."Closed at Date")
                {
                    Caption = 'Closed at Date';
                }

                field(debitAmount; Rec."Debit Amount")
                {
                    Caption = 'Debit Amount';
                }
                field(creditAmount; Rec."Credit Amount")
                {
                    Caption = 'Credit Amount';
                }
                field(debitAmountLCY; Rec."Debit Amount (LCY)")
                {
                    Caption = 'Debit Amount (LCY)';
                }
                field(creditAmountLCY; Rec."Credit Amount (LCY)")
                {
                    Caption = 'Credit Amount (LCY)';
                }
                field(documentDate; Rec."Document Date")
                {
                    Caption = 'Document Date';
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }
                field(reversed; Rec.Reversed)
                {
                    Caption = 'Reversed';
                }
                field(reversedByEntryNo; Rec."Reversed by Entry No.")
                {
                    Caption = 'Reversed by Entry No.';
                }
                field(reversedEntryNo; Rec."Reversed Entry No.")
                {
                    Caption = 'Reversed Entry No.';
                }
                field(journalBatchName; Rec."Journal Batch Name")
                {
                    Caption = 'Journal Batch Name';

                }
                field(SystemId; Rec.SystemId)
                {
                    Caption = 'System-Created Entry';
                }
                field(systemCreatedAt; Rec."SystemCreatedat")
                {
                    Caption = 'System-Created at';
                }
                field(systemCreatedBy; Rec."SystemCreatedby")
                {
                    Caption = 'System-Created by';
                }
                field(lastModifiedDateTime; Rec.SystemModifiedAt)
                {
                    Caption = 'Last Modified DateTime';
                }
        }
    }
}