@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forDealPrice'
define view entity ZPIBI_DealPriceTP
  as projection on ZPIBR_DealPriceTP
{
  key PriceUUID,
  ArticleUUID,
  DealUUID,
  PriceLevel,
  ToPitch,
  Valorisation,
  Currency,
  CreatedAt,
  CreatedBy,
  LastChangedBy,
  LastChangedAt,
  LocalLastChangedAt,
  _DealPosition : redirected to parent ZPIBI_DealPositionTP,
  _DealHeader : redirected to ZPIBI_DealHeaderTP
  
}
