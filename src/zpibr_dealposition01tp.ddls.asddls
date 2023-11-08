@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forDealPosition'
define view entity ZPIBR_DealPosition01TP
  as select from ZPIB_DEAL_ITEMS
  association to parent ZPIBR_DealHeaderTP as _DealHeader on $projection.DealUUID = _DealHeader.DealUUID
  composition [0..*] of ZPIBR_DealPriceTP as _DealPrice
{
  key ARTICLE_UUID as ArticleUUID,
  DEAL_UUID as DealUUID,
  ARTICLE_NO as ArticleNo,
  DELIVERY_PLANT as DeliveryPlant,
  PROPOSED_VOLUME as ProposedVolume,
  ACTUAL_VOLUME as ActualVolume,
  @Semantics.amount.currencyCode: 'Currency'
  DEVIATION as Deviation,
  CURRENCY as Currency,
  CREATED_AT as CreatedAt,
  CREATED_BY as CreatedBy,
  LAST_CHANGED_BY as LastChangedBy,
  LAST_CHANGED_AT as LastChangedAt,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  _DealPrice,
  _DealHeader
  
}
