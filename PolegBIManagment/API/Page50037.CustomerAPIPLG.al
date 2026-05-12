namespace Poleg.API;
using Microsoft.Sales.Customer;
using Microsoft.CRM.Team;
using Microsoft.Foundation.Address;

page 50337 "Customer API PLG"
{
    APIGroup = 'bi';
    APIPublisher = 'poleg';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'customerAPIPLG';
    DelayedInsert = true;
    EntityName = 'customer';
    EntitySetName = 'customers';
    PageType = API;
    SourceTable = Customer;
    /*
    Field description	Specification for BC
Company,	not relevant
CustomerNumber,	Customer.No
CustomerName,	Customer.Name
CustomerMarket,	CASE Customer.Gen.Bus.Posting Group = "מקומי" THEN "מקומי" ELSE "ייצוא"
CustomerGroup,	Customer.Gen.Bus.Posting Group 
GroupName,	Customer.Gen.Bus.Posting Group.Description
CustomerCountry,	Customer.Country/Region Code
Country,	Customer.Country/Region Code.Name
CustomerPayer,	Customer.Bill-to Customer No.
PayerName,	Customer.Bill-to Customer No.Name
CustomerDiller,	Customer.SalesPerson
CustomerDillerName	Customer.SalesPerson.Name

    */
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(company; CompanyName())
                {
                    Caption = 'Company';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(CustomerGroup; Rec."Customer Posting Group")
                {
                    Caption = 'Customer Posting Group';
                }
                field(GroupName; GroupName)
                {
                    Caption = 'Customer Group Name';
                }
                field(CustomerMarket; CustomerMarketTxt)
                {
                    Caption = 'Customer Market';
                }
                field(CustomerCountry; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                }
                field(countryName; CustomerCountry)
                {
                    Caption = 'Country Name';
                }
                field(CustomerPayer; Rec."Bill-to Customer No.")
                {
                    Caption = 'Bill-to Customer No.';
                }
                field(CustomerPayerName; CustomerPayerNameTxt)
                {
                    Caption = 'Bill-to Customer Name';
                }
                field(CustomerDiller; Rec."Salesperson Code")
                {
                    Caption = 'Salesperson Code';
                }
                field(CustomerDillerName; CustomerDealerNameTxt)
                {
                    Caption = 'Salesperson Name';
                }
                field(creditLimit; Rec."Credit Limit (LCY)")
                {
                    Caption = 'Credit Limit (LCY)';
                }
                field(vendorNo; Rec."Vendor Account No.")
                {
                    Caption = 'Vendor No.';
                }

            }
        }
    }
    var
        CompanyNameTxt: Text[100];
        CustomerMarketTxt: Text[100];
        CustomerPayerNameTxt: Text[100];
        CustomerDealerNameTxt: Text[100];
        CustomerCountry: Text[100];
        GroupName: Text[100];

    trigger OnOpenPage()
    begin
        CompanyNameTxt := CompanyName();
    end;

    trigger OnAfterGetRecord()
    var
        Customer: Record Customer;
        Salesperson: Record "Salesperson/Purchaser";
        CustomerPostingGroup: Record "Customer Posting Group";
        CountryRegion: Record "Country/Region";
    begin
        //Customer Market
        if Rec."Gen. Bus. Posting Group" = 'מקומי' then
            CustomerMarketTxt := 'מקומי'
        else
            CustomerMarketTxt := 'ייצוא';
        //Customer Payer Name
        if Rec."Bill-to Customer No." <> '' then begin
            CustomerPayerNameTxt := '';
            if Customer.Get(Rec."Bill-to Customer No.") then
                CustomerPayerNameTxt := Customer.Name;
        end else
            CustomerPayerNameTxt := '';
        //Customer Diller Name
        if Rec."Salesperson Code" <> '' then begin
            CustomerDealerNameTxt := '';
            if Salesperson.Get(Rec."Salesperson Code") then
                CustomerDealerNameTxt := Salesperson.Name;
        end else
            CustomerDealerNameTxt := '';
        if CustomerPostingGroup.Get(Rec."Customer Posting Group") then
            GroupName := CustomerPostingGroup.Description
        else
            GroupName := '';

        if Rec."Country/Region Code" <> '' then begin
            if CountryRegion.Get(Rec."Country/Region Code") then
                CustomerCountry := CountryRegion.Name
            else
                CustomerCountry := '';
        end else
            CustomerCountry := '';
    end;

}
