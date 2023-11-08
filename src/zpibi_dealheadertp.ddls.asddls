@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forDealHeader'
define root view entity ZPIBI_DealHeaderTP
  provider contract transactional_interface
  as projection on ZPIBR_DealHeaderTP
{
  key DealUUID,
  DealID,
  Creator,
  SrSameAsCreator,
  SalesRep,
  NewCustomer,
  SoldToParty,
  ShipToParty,  
  VolumeDigestion,
  OfferDate,
  ContractStartDate,
  ContractEndDate,
  ContractDuration,
  TargetMilkPricegoal,
  Currency,
  CreatedAt,
  CreatedBy,
  LastChangedBy,
  LastChangedAt,
  LocalLastChangedAt,
  _DealPosition : redirected to composition child ZPIBI_DealPositionTP,
  _SoldToParty : redirected to ZPIBI_Referencecustomerma,
  _ShipToParty : redirected to ZPIBI_Referencecustomerma,
  _User : redirected to ZIPIB_REFERENCEUSERMASTER,
  _SalesRep : redirected to ZIPIB_REFERENCEUSERMASTER
}
