namespace Poleg.Poleg;

using Microsoft.Purchases.Vendor;

page 50354 "Vendor Posting Group API PLG"
{
    APIGroup = 'bi';
    APIPublisher = 'poleg';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'vendorPostingGroupAPIPLG';
    DelayedInsert = true;
    EntityName = 'vendorPostingGroup';
    EntitySetName = 'vendorPostingGroups';
    PageType = API;
    SourceTable = "Vendor Posting Group";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(payablesAccount; Rec."Payables Account")
                {
                    Caption = 'Payables Account';
                }
                field(serviceChargeAcc; Rec."Service Charge Acc.")
                {
                    Caption = 'Service Charge Acc.';
                }
                field(paymentDiscDebitAcc; Rec."Payment Disc. Debit Acc.")
                {
                    Caption = 'Payment Disc. Debit Acc.';
                }
                field(invoiceRoundingAccount; Rec."Invoice Rounding Account")
                {
                    Caption = 'Invoice Rounding Account';
                }
                field(debitCurrApplnRndgAcc; Rec."Debit Curr. Appln. Rndg. Acc.")
                {
                    Caption = 'Debit Curr. Appln. Rndg. Acc.';
                }
                field(creditCurrApplnRndgAcc; Rec."Credit Curr. Appln. Rndg. Acc.")
                {
                    Caption = 'Credit Curr. Appln. Rndg. Acc.';
                }
                field(debitRoundingAccount; Rec."Debit Rounding Account")
                {
                    Caption = 'Debit Rounding Account';
                }
                field(creditRoundingAccount; Rec."Credit Rounding Account")
                {
                    Caption = 'Credit Rounding Account';
                }
                field(paymentDiscCreditAcc; Rec."Payment Disc. Credit Acc.")
                {
                    Caption = 'Payment Disc. Credit Acc.';
                }
                field(paymentToleranceDebitAcc; Rec."Payment Tolerance Debit Acc.")
                {
                    Caption = 'Payment Tolerance Debit Acc.';
                }
                field(paymentToleranceCreditAcc; Rec."Payment Tolerance Credit Acc.")
                {
                    Caption = 'Payment Tolerance Credit Acc.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(viewAllAccountsOnLookup; Rec."View All Accounts on Lookup")
                {
                    Caption = 'View All Accounts on Lookup';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
            }
        }
    }
}
