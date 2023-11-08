@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forDealPrice'
define view entity ZPIBR_DealPriceTP
  as select from ZPIB_PRICE_VAL
  association to parent ZPIBR_DealPosition01TP as _DealPosition on $projection.ArticleUUID = _DealPosition.ArticleUUID
  association [1] to ZPIBR_DealHeaderTP as _DealHeader on $projection.DealUUID = _DealHeader.DealUUID
{
  key PRICE_UUID as PriceUUID,
  ARTICLE_UUID as ArticleUUID,
  DEAL_UUID as DealUUID,
  PRICE_LEVEL as PriceLevel,
  TO_PITCH as ToPitch,
  @Semantics.amount.currencyCode: 'Currency'
  VALORISATION as Valorisation,
  CURRENCY as Currency,
  CREATED_AT as CreatedAt,
  CREATED_BY as CreatedBy,
  LAST_CHANGED_BY as LastChangedBy,
  LAST_CHANGED_AT as LastChangedAt,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  _DealPosition,
  _DealHeader
  
}
