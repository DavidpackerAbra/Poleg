namespace abraIT.Poleg.API;

using abraIT.Poleg.MainApp;

page 50355 "Complaints API PLG"
{
    APIGroup = 'poleg';
    APIPublisher = 'abraIT';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'complaintsAPIPLG';
    DelayedInsert = true;
    EntityName = 'complaint';
    EntitySetName = 'complaints';
    PageType = API;
    SourceTable = "Complaint Header PLG";
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
                // Part A – General Details
                field(no; Rec."No.")
                {
                    Caption = 'Complaint No.';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(department; Rec.Department)
                {
                    Caption = 'Department';
                }
                field(receivedDate; Rec."Received Date")
                {
                    Caption = 'Received Date';
                }
                field(createdBy; Rec."Created By")
                {
                    Caption = 'Created By';
                }
                field(customerNo; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                }
                field(customerName; Rec."Customer Name")
                {
                    Caption = 'Customer Name';
                }
                field(customerOrderNo; Rec."Customer Order No.")
                {
                    Caption = 'Customer Order Number';
                }
                field(complaintQuantity; Rec."Complaint Quantity")
                {
                    Caption = 'Complaint Quantity';
                }
                field(productionOrderNo; Rec."Production Order No.")
                {
                    Caption = 'Production Order No.';
                }
                field(productionOrder1; Rec."Production Order 1")
                {
                    Caption = 'Production Order 1';
                }
                field(productionOrder2; Rec."Production Order 2")
                {
                    Caption = 'Production Order 2';
                }
                field(genProdPostingGroupPLG; Rec."Gen. Prod. Posting Group PLG")
                {
                    Caption = 'Product Type';
                }
                field(productTypeDescriptionPLG; Rec."Product Type Description PLG")
                {
                    Caption = 'Product Type Description';
                }
                field(itemCategoryCodePLG; Rec."Item Category Code PLG")
                {
                    Caption = 'Item Category';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(itemDescription; Rec."Item Description")
                {
                    Caption = 'Item Description';
                }
                field(itemTypePLG; Rec."Item Type PLG")
                {
                    Caption = 'Item Type';
                }
                field(thicknessPLG; Rec."Thickness PLG")
                {
                    Caption = 'Thickness (microns)';
                }
                field(widthPLG; Rec."Width PLG")
                {
                    Caption = 'Width (mm)';
                }
                field(lengthPLG; Rec."Length PLG")
                {
                    Caption = 'Length (m)';
                }
                field(colorCodePLG; Rec."Color Code PLG")
                {
                    Caption = 'Color';
                }
                field(productionDatePLG; Rec."Production Date PLG")
                {
                    Caption = 'Production Date';
                }
                field(salesOrderNo; Rec."Sales Order No.")
                {
                    Caption = 'Sales Order No.';
                }
                field(complaintSubject; Rec."Complaint Subject")
                {
                    Caption = 'Complaint Subject';
                }
                field(detailedDescription; DetailedDescriptionTxt)
                {
                    Caption = 'Detailed Description';
                }

                // Part B – Investigation
                field(handlerName; Rec."Handler Name")
                {
                    Caption = 'Handler Name';
                }
                field(treatmentStartDate; Rec."Treatment Start Date")
                {
                    Caption = 'Treatment Start Date';
                }
                field(treatmentEndDate; Rec."Treatment End Date")
                {
                    Caption = 'Treatment End Date';
                }
                field(conclusion; Rec.Conclusion)
                {
                    Caption = 'Conclusion';
                }
                field(findings; FindingsTxt)
                {
                    Caption = 'Findings';
                }
                field(decision; Rec.Decision)
                {
                    Caption = 'Decision';
                }
                field(defectCategoryCode; Rec."Defect Category Code")
                {
                    Caption = 'Defect Category Code';
                }
                field(defectCategoryDescription; Rec."Defect Category Description")
                {
                    Caption = 'Defect Category Description';
                }
                field(correctiveAction; Rec."Corrective Action")
                {
                    Caption = 'Corrective Action';
                }
                field(reportDate; Rec."Report Date")
                {
                    Caption = 'Report Date';
                }

                // Part C – Closure
                field(creditMemoNo; Rec."Credit Memo No.")
                {
                    Caption = 'Credit Memo';
                }
                field(creditMemoAmountPLG; Rec."Credit Memo Amount PLG")
                {
                    Caption = 'Credit Memo Amount';
                }
                field(closureNotes; ClosureNotesTxt)
                {
                    Caption = 'Closure Notes';
                }
                field(closeDate; Rec."Close Date")
                {
                    Caption = 'Close Date';
                }
                field(closedBy; Rec."Closed By")
                {
                    Caption = 'Closed By';
                }
                field(customerNotifiedDate; Rec."Customer Notified Date")
                {
                    Caption = 'Customer Notified Date';
                }
                field(customerNotifiedDetails; Rec."Customer Notified Details")
                {
                    Caption = 'Customer Notified Details';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ReadMemoFields();
    end;

    local procedure ReadMemoFields()
    var
        InStr: InStream;
    begin
        Rec.CalcFields("Detailed Description", Findings, "Closure Notes");

        Clear(DetailedDescriptionTxt);
        Rec."Detailed Description".CreateInStream(InStr, TextEncoding::UTF8);
        InStr.ReadText(DetailedDescriptionTxt);

        Clear(FindingsTxt);
        Clear(InStr);
        Rec.Findings.CreateInStream(InStr, TextEncoding::UTF8);
        InStr.ReadText(FindingsTxt);

        Clear(ClosureNotesTxt);
        Clear(InStr);
        Rec."Closure Notes".CreateInStream(InStr, TextEncoding::UTF8);
        InStr.ReadText(ClosureNotesTxt);
    end;

    var
        DetailedDescriptionTxt: Text;
        FindingsTxt: Text;
        ClosureNotesTxt: Text;
}
