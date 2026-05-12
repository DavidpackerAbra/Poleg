namespace Poleg.API;

using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Sales.Receivables;
using Microsoft.Purchases.Payables;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Purchases.History;
using Microsoft.Sales.History;
using Microsoft.Finance.Dimension;
using Microsoft.Finance.VAT.Setup;
using Microsoft.Purchases.Vendor;
using Microsoft.Sales.Customer;
using Microsoft.Foundation.Enums;

page 50335 "GL Entries API PLG"
{
    APIGroup = 'bi';
    APIPublisher = 'poleg';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'GL Entries API PLG';
    DelayedInsert = false;
    EntityName = 'glEntry';
    EntitySetName = 'glEntries';
    PageType = API;
    SourceTable = "G/L Entry";
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
                field(companyName; CompanyNameTxt)
                {
                    Caption = 'Company';
                }

                // Dates
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date (AccDate)';
                }
                field(documentDate; Rec."Document Date")
                {
                    Caption = 'Document Date';
                }
                field(vatDate; Rec."VAT Reporting Date")
                {
                    Caption = 'VAT Date';
                }
                field(paymentDate; PaymentDate)
                {
                    Caption = 'Payment Date';
                }

                // Account Information
                field(glAccountNo; Rec."G/L Account No.")
                {
                    Caption = 'Account Code (EGAIT1)';
                }
                field(accountName; AccountName)
                {
                    Caption = 'Account Name (EATX40)';
                }
                field(accountGroup; AccountGroup)
                {
                    Caption = 'Account Group (EAAICL)';
                }
                field(accountGroupName; AccountGroupName)
                {
                    Caption = 'Account Group Name';
                }
                field(accountIndex2; AccountIndex2)
                {
                    Caption = 'Account No.2 - Polyfilm Index';
                }
                field(accountIndex2Name; AccountIndex2Name)
                {
                    Caption = 'Account No.2 Description';
                }
                field(accountSubCategory; AccountSubCategory)
                {
                    Caption = 'Account Subcategory Description';
                }
                // Document Information
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Voucher ID (EGVONO)';
                }
                field(documentType; GetTextedDocType(Rec."Document Type"))
                {
                    Caption = 'Voucher Type (EGVDSC)';
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Details (EGVTXT)';
                }

                // Dimensions
                field(costCenter; CostCenter)
                {
                    Caption = 'Cost Center Code (EGAIT2)';
                }
                field(costCenterName; CostCenterName)
                {
                    Caption = 'Cost Center Name (EATX40)';
                }
                field(itemClass; ItemClass)
                {
                    Caption = 'Item Class Code (EGAIT3)';
                }
                field(itemClassName; ItemClassName)
                {
                    Caption = 'Item Class Name (EATX40)';
                }
                field(costType; CostType)
                {
                    Caption = 'Cost Type (EGAIT4)';
                }
                field(costTypeName; CostTypeName)
                {
                    Caption = 'Cost Type Name (EATX40)';
                }
                field(statistics; Statistics)
                {
                    Caption = 'Statistics Code (EGAIT5)';
                }
                field(statisticsName; StatisticsName)
                {
                    Caption = 'Statistics Name (EATX40)';
                }
                field(thirdPartyGroup; ThirdPartyGroup)
                {
                    Caption = 'Third Party Group';
                }
                field(thirdPartyName; ThirdPartyName)
                {
                    Caption = 'Third Party Name';
                }
                field(project; Project)
                {
                    Caption = 'Project Code';
                }
                field(projectName; ProjectName)
                {
                    Caption = 'Project Name';
                }
                field(accExpenses; AccExpenses)
                {
                    Caption = 'Acc Expenses Code';
                }
                field(accExpensesName; AccExpensesName)
                {
                    Caption = 'Acc Expenses Name';
                }
                field(country; Country)
                {
                    Caption = 'Country Code';
                }
                field(countryName; CountryName)
                {
                    Caption = 'Country Name';
                }
                field(customerSupplier; CustomerSupplier)
                {
                    Caption = 'Customer/Supplier (EGAIT6)';
                }

                // Financial Information
                field(AmountILS; Rec.Amount)
                {
                    Caption = 'Amount ILS (EGACAM)';
                }
                field(Currency; 'ILS')
                {
                    Caption = 'Currency Code';
                }

                field(additionalCurrencyAmount; Rec."Additional-Currency Amount")
                {
                    Caption = 'Amount Foreign Curr (EGCUAM)';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity (EGACQT)';
                }
                field(vatAmount; Rec."VAT Amount")
                {
                    Caption = 'VAT Amount';
                }
                field(vatCode; VATCode)
                {
                    Caption = 'VAT Code (EGVTCD)';
                }
                field(debitAmount; Rec."Debit Amount")
                {
                    Caption = 'Debit Amount';
                }
                field(creditAmount; Rec."Credit Amount")
                {
                    Caption = 'Credit Amount';
                }
                field(balAccountType; GetTextedBalAccountType(Rec."Bal. Account Type"))
                {
                    Caption = 'Bal. Account Type';
                }
                field(balAccountNo; Rec."Bal. Account No.")
                {
                    Caption = 'Bal. Account No.';
                }

                // Source Information
                field(sourceCode; Rec."Source Code")
                {
                    Caption = 'Source Code';
                }
                field(sourceType; GetTextedSourceType(Rec."Source Type"))
                {
                    Caption = 'Source Type';
                }
                field(sourceNo; Rec."Source No.")
                {
                    Caption = 'Source No.';
                }

                // Posting Groups
                field(genPostingType; GetTextedGenPostingType(Rec."Gen. Posting Type"))
                {
                    Caption = 'Gen. Posting Type';
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                    Caption = 'Gen. Bus. Posting Group';
                }
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                    Caption = 'Gen. Prod. Posting Group';
                }

                // Additional Information
                field(userID; Rec."User ID")
                {
                    Caption = 'User ID';
                }
                field(journalBatchName; Rec."Journal Batch Name")
                {
                    Caption = 'Journal Batch Name';
                }
                field(reasonCode; Rec."Reason Code")
                {
                    Caption = 'Reason Code';
                }

                // field(globalDimension1Code; Rec."Global Dimension 1 Code")
                // {
                //     Caption = 'Global Dimension 1 Code';
                // }
                // field(globalDimension2Code; Rec."Global Dimension 2 Code")
                // {
                //     Caption = 'Global Dimension 2 Code';
                // }
                // field(shortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                // {
                //     Caption = 'Shortcut Dimension 3 Code';
                // }
                // field(shortcutDimension4Code; Rec."Shortcut Dimension 4 Code")
                // {
                //     Caption = 'Shortcut Dimension 4 Code';
                // }
                // field(shortcutDimension5Code; Rec."Shortcut Dimension 5 Code")
                // {
                //     Caption = 'Shortcut Dimension 5 Code';
                // }
                // field(shortcutDimension6Code; Rec."Shortcut Dimension 6 Code")
                // {
                //     Caption = 'Shortcut Dimension 6 Code';
                // }
                // field(shortcutDimension7Code; Rec."Shortcut Dimension 7 Code")
                // {
                //     Caption = 'Shortcut Dimension 7 Code';
                // }
                // field(shortcutDimension8Code; Rec."Shortcut Dimension 8 Code")
                // {
                //     Caption = 'Shortcut Dimension 8 Code';
                // }
                field(dueDate; DueDate)
                {
                    Caption = 'Due Date';
                }
            }
        }
    }
    var
        CompanyNameTxt: Text[100];
        AccountName: Text[100];
        AccountGroup: Code[20];
        AccountGroupName: Text[100];
        AccountIndex2: Code[20];
        AccountIndex2Name: Text[100];
        AccountSubCategory: Text[100];
        CostCenter: Code[20];
        CostCenterName: Text[100];
        ItemClass: Code[20];
        ItemClassName: Text[100];
        CostType: Code[20];
        CostTypeName: Text[100];
        Statistics: Code[20];
        StatisticsName: Text[100];
        ThirdPartyGroup: Code[20];
        ThirdPartyName: Text[100];
        Project: Code[20];
        ProjectName: Text[100];
        AccExpenses: Code[20];
        AccExpensesName: Text[100];
        Country: Code[20];
        CountryName: Text[100];
        CustomerSupplier: Code[20];
        CustomerSupplierName: Text[100];
        VATCode: Code[20];
        PaymentDate: Date;
        DueDate: Date;

    trigger OnOpenPage()
    begin
        CompanyNameTxt := CompanyName();
    end;

    trigger OnAfterGetRecord()
    begin
        GetAccountInformation();
        GetDimensionInformation();
        GetVATInformation();
        RemoveRightToLeftMarks();
        GetDueDate();
    end;

    local procedure GetAccountInformation()
    var
        GLAccount: Record "G/L Account";
        ParentGLAccount: Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        Clear(AccountName);
        Clear(AccountGroup);
        Clear(AccountGroupName);
        Clear(AccountIndex2);
        Clear(AccountIndex2Name);
        Clear(AccountSubCategory);
        Clear(PaymentDate);
        GLAccount.SetAutoCalcFields("Account Subcategory Descript.");
        GLAccount.SetLoadFields(Name, "No. 2", "Account Subcategory Descript.");
        if GLAccount.Get(Rec."G/L Account No.") then begin
            AccountName := GLAccount.Name;

            ParentGLAccount.SetFilter("No.", '<=%1', Rec."G/L Account No.");
            ParentGLAccount.SetRange("Account Type", ParentGLAccount."Account Type"::"Begin-Total");
            if ParentGLAccount.FindLast() then begin
                AccountGroup := ParentGLAccount."No.";
                AccountGroupName := ParentGLAccount.Name;
            end;

            AccountIndex2 := GLAccount."No. 2";
            AccountIndex2Name := GLAccount.Name;
            AccountSubCategory := GLAccount."Account Subcategory Descript.";
        end;
        case Rec."Source Type" of
            Enum::"Gen. Journal Account Type"::Customer:
                begin
                    Customer.Get(Rec."Source No.");
                    CustomerSupplier := Rec."Source No.";
                    CustomerSupplierName := Customer.Name;
                    if CustLedgerEntry.Get(rec."Entry No.") then
                        PaymentDate := CustLedgerEntry."Due Date";
                end;
            Enum::"Gen. Journal Account Type"::Vendor:
                begin
                    Vendor.Get(Rec."Source No.");
                    CustomerSupplier := Rec."Source No.";
                    CustomerSupplierName := Vendor.Name;
                    if VendorLedgerEntry.Get(Rec."Entry No.") then
                        PaymentDate := VendorLedgerEntry."Due Date";
                end;
            else begin
                Clear(CustomerSupplier);
                Clear(CustomerSupplierName);
            end;
        end;
    end;

    local procedure GetDimensionInformation()
    var
        DimensionSetEntry: Record "Dimension Set Entry";
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        Clear(CostCenter);
        Clear(CostCenterName);
        Clear(ItemClass);
        Clear(ItemClassName);
        Clear(CostType);
        Clear(CostTypeName);
        Clear(Statistics);
        Clear(StatisticsName);
        Clear(ThirdPartyGroup);
        Clear(ThirdPartyName);
        Clear(Project);
        Clear(ProjectName);
        Clear(AccExpenses);
        Clear(AccExpensesName);
        Clear(Country);
        Clear(CountryName);
        if Rec."Dimension Set ID" = 0 then
            exit;

        if not GeneralLedgerSetup.Get() then
            exit;

        DimensionSetEntry.SetRange("Dimension Set ID", Rec."Dimension Set ID");
        if DimensionSetEntry.FindSet() then
            repeat
                DimensionSetEntry.CalcFields("Dimension Name", "Dimension Value Name");

                case DimensionSetEntry."Global Dimension No." of
                    1:
                        begin
                            ItemClass := DimensionSetEntry."Dimension Value Code";
                            ItemClassName := DimensionSetEntry."Dimension Value Name";

                        end;
                    2:
                        begin//TODO ???
                            ThirdPartyGroup := DimensionSetEntry."Dimension Value Code";
                            ThirdPartyName := DimensionSetEntry."Dimension Value Name";
                        end;
                    3:
                        begin
                            CostCenter := DimensionSetEntry."Dimension Value Code";
                            CostCenterName := DimensionSetEntry."Dimension Value Name";
                        end;
                    4:
                        begin
                            Project := DimensionSetEntry."Dimension Value Code";
                            ProjectName := DimensionSetEntry."Dimension Value Name";
                        end;
                    5:
                        begin
                            CostType := DimensionSetEntry."Dimension Value Code";
                            CostTypeName := DimensionSetEntry."Dimension Value Name";
                        end;
                    6:
                        begin
                            AccExpenses := DimensionSetEntry."Dimension Value Code";
                            AccExpensesName := DimensionSetEntry."Dimension Value Name";
                        end;
                    7:
                        begin
                            Country := DimensionSetEntry."Dimension Value Code";
                            CountryName := DimensionSetEntry."Dimension Value Name";
                        end;
                    8:
                        begin
                            Statistics := DimensionSetEntry."Dimension Value Code";
                            StatisticsName := DimensionSetEntry."Dimension Value Name";
                        end;
                end;
            until DimensionSetEntry.Next() = 0;
    end;

    local procedure GetVATInformation()
    var
        VATPostingSetup: Record "VAT Posting Setup";
    begin
        Clear(VATCode);

        if VATPostingSetup.Get(Rec."VAT Bus. Posting Group", Rec."VAT Prod. Posting Group") then
            VATCode := VATPostingSetup."VAT Identifier";
    end;

    local procedure RemoveRightToLeftMarks()
    var
        RightToLeftMark: Char;
    begin
        // U+200F is the Right-to-Left Mark character
        RightToLeftMark := 8207;

        // Remove RTL marks from all text fields
        AccountName := DelChr(AccountName, '=', RightToLeftMark);
        AccountGroupName := DelChr(AccountGroupName, '=', RightToLeftMark);
        AccountIndex2Name := DelChr(AccountIndex2Name, '=', RightToLeftMark);
        CostCenterName := DelChr(CostCenterName, '=', RightToLeftMark);
        ItemClassName := DelChr(ItemClassName, '=', RightToLeftMark);
        CostTypeName := DelChr(CostTypeName, '=', RightToLeftMark);
        StatisticsName := DelChr(StatisticsName, '=', RightToLeftMark);
        ThirdPartyName := DelChr(ThirdPartyName, '=', RightToLeftMark);
        ProjectName := DelChr(ProjectName, '=', RightToLeftMark);
        AccExpensesName := DelChr(AccExpensesName, '=', RightToLeftMark);
        CountryName := DelChr(CountryName, '=', RightToLeftMark);
        AccountIndex2 := DelChr(AccountIndex2, '=', RightToLeftMark);
    end;

    local procedure GetTextedDocType(DocumentType: Enum "Gen. Journal Document Type"): Text
    begin
        exit(Format(DocumentType));
    end;

    local procedure GetTextedGenPostingType(GenPostingType: Enum "General Posting Type"): Text
    begin
        exit(Format(GenPostingType));
    end;

    local procedure GetDueDate(): Date
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        if Rec."Document Type" <> Rec."Document Type"::Invoice then
            exit;
        case Rec."Source Type" of
            Rec."Source Type"::Customer:
                begin
                    if SalesInvoiceHeader.Get(Rec."Document No.") then
                        DueDate := SalesInvoiceHeader."Due Date";
                end;
            Rec."Source Type"::Vendor:
                begin
                    if PurchInvHeader.Get(Rec."Document No.") then
                        DueDate := PurchInvHeader."Due Date";
                end;
        end;
    end;

    local procedure GetTextedSourceType(SourceType: Enum "Gen. Journal Source Type"): Text
    begin
        exit(Format(SourceType));
    end;

    local procedure GetTextedBalAccountType(BalAccountType: Enum "Gen. Journal Account Type"): Text
    begin
        exit(Format(BalAccountType));
    end;


}

