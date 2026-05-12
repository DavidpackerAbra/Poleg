namespace Poleg.API;

using Microsoft.Inventory.Item;
using Microsoft.Inventory.Ledger;

query 50301 "Items By Location API"
{
    QueryType = API;
    APIPublisher = 'poleg';
    APIGroup = 'bi';
    APIVersion = 'v2.0';
    EntityName = 'itemByLocation';
    EntitySetName = 'itemsByLocation';
    Caption = 'Items By Location';

    elements
    {
        dataitem(Item; Item)
        {
            column(itemNo; "No.")
            {
            }
            column(description; Description)
            {
            }
            dataitem(ItemLedgerEntry; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = Item."No.";
                SqlJoinType = InnerJoin;

                column(locationCode; "Location Code")
                {
                }
                column(quantity; Quantity)
                {
                    Method = Sum;
                }
            }
        }
    }
}