@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forDealHeader'
define root view entity ZPIBR_DealHeaderTP
  as select from zpib_deal_root
  association [1..1] to ZI_ReferenceCustomerMa as _SoldToParty on $projection.SoldToParty = _SoldToParty.Customer 
                    and _SoldToParty.PartnerFunction = 'SP' 
  association [1..1] to ZI_ReferenceCustomerMa as _ShipToParty on $projection.ShipToParty = _ShipToParty.Customer
                    and _ShipToParty.PartnerFunction = 'SH'
  association [1..1] to ZI_ReferenceUserMaster as _User on $projection.Creator = _User.UserId  
  association [1..1] to ZI_ReferenceUserMaster as _SalesRep on $projection.SalesRep = _SalesRep.UserId                  
  composition [0..*] of ZPIBR_DealPosition01TP as _DealPosition
{
  key deal_uuid as DealUUID,
  deal_id as DealID,
  creator as Creator,
  sr_same_as_creator as SrSameAsCreator,
  sales_rep as SalesRep,
  is_new_customer as NewCustomer,
  sold_to_party as SoldToParty,
  ship_to_party as ShipToParty,
  volume_digestion as VolumeDigestion,
  offer_date as OfferDate,
  contract_start_date as ContractStartDate,
  contract_end_date as ContractEndDate,
  contract_duration as ContractDuration,
  @Semantics.amount.currencyCode: 'Currency'
  target_milk_pricegoal as TargetMilkPricegoal,
  currency as Currency,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.user.lastChangedBy: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  _DealPosition,
  _SoldToParty,
  _ShipToParty,
  _User,
  _SalesRep
}
