namespace Poleg;

using Poleg.API;
using abraIT.Poleg.API;
using Poleg.Poleg;

permissionset 50300 "Poleg BI Management"
{
    Assignable = true;
    Permissions = page "Archive Sales Order Line API"=X,
        page "Complaints API PLG"=X,
        page "Cost Share Buffer API PLG"=X,
        page "Cost Share Summary API PLG"=X,
        page "Customer API PLG"=X,
        page "Customer Entries API PLG"=X,
        page "Customer Posting Group API PLG"=X,
        page "G/L Account API PLG"=X,
        page "GL Budget API PLG"=X,
        page "GL Entries API PLG"=X,
        page "Items API PLG"=X,
        page "Prod Order Lines API PLG"=X,
        page "Prod. Order Comp. API PLG"=X,
        page "Prod. Tracking API PLG"=X,
        page "Production Orders API PLG"=X,
        page "Purch. Invoice Lines API PLG"=X,
        page "Qlty. Insp. Header API PLG"=X,
        page "Qlty. Inspection Line API PLG"=X,
        page "Sales Budget API PLG"=X,
        page "Sales Cr.Memo Lines API PLG"=X,
        page "Sales Invoice Lines API PLG"=X,
        page "Sales Order Lines API PLG"=X,
        page "Sales Shipment Line API PLG"=X,
        page "Value Entries API PLG"=X,
        page "VAT Entries API PLG"=X,
        page "Vendor API PLG"=X,
        page "Vendor Entries API PLG"=X,
        page "Vendor Posting Group API PLG"=X,
        query "Items By Location API"=X;
}