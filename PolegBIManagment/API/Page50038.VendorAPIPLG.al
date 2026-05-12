namespace Poleg.API;

using Microsoft.Purchases.Vendor;
using Microsoft.Foundation.Address;

page 50338 "Vendor API PLG"
{
    APIGroup = 'bi';
    APIPublisher = 'poleg';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'vendorAPIPLG';
    DelayedInsert = true;
    EntityName = 'vendor';
    EntitySetName = 'vendors';
    PageType = API;
    SourceTable = Vendor;
    /*
Company,	not relevant
SuppCode,	Vendor.No
SuppName,	Vendor.Name
SuppMarket,	CASE Vendor.Gen.Bus.Posting Group = "מקומי" THEN "מקומי" ELSE "ייצוא"
SuppGroup,	Vendor.Gen.Bus.Posting Group
SGName,	not relevant
SuppCountry,	Vendor.Country/Region Code
Country	Vendor.Country/Region Code.Name

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
                field(suppCode; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(suppName; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(suppMarket; SuppMarketTxt)
                {
                    Caption = 'Vendor Market';
                }
                field(suppGroup; Rec."Vendor Posting Group")
                {
                    Caption = 'Vendor Posting Group';
                }
                field(suppCountry; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                }
                field(country; SuppCountryName)
                {
                    Caption = 'Country Name';
                }
            }
        }
    }
    var
        SuppMarketTxt: Text[100];
        SuppCountryName: Text;

    trigger OnAfterGetRecord()
    var
        VendorPostingGroup: Record "Vendor Posting Group";
        CountryRegion: Record "Country/Region";
    begin
        //Vendor Market
        if Rec."Gen. Bus. Posting Group" = 'מקומי' then
            SuppMarketTxt := 'מקומי'
        else
            SuppMarketTxt := 'ייצוא';
        //Country Name
        if Rec."Country/Region Code" <> '' then begin
            if CountryRegion.Get(Rec."Country/Region Code") then
                SuppCountryName := CountryRegion.Name
            else
                SuppCountryName := '';
        end else
            SuppCountryName := '';
    end;
}
