@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forDealPosition'
define view entity ZPIBI_DealPositionTP
  as projection on ZPIBR_DealPosition01TP
{
  key ArticleUUID,
  DealUUID,
  ArticleNo,
  DeliveryPlant,
  ProposedVolume,
  ActualVolume,
  Deviation,
  Currency,
  CreatedAt,
  CreatedBy,
  LastChangedBy,
  LastChangedAt,
  LocalLastChangedAt,
  _DealPrice : redirected to composition child ZPIBI_DealPriceTP,
  _DealHeader : redirected to parent ZPIBI_DealHeaderTP
  
}
