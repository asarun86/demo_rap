@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forDealPosition'
@ObjectModel.semanticKey: [ 'ArticleNo' ]
@Search.searchable: true
define view entity ZPIBC_DealPosition01TP
  as projection on ZPIBR_DealPosition01TP
{
  key ArticleUUID,
  DealUUID,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  ArticleNo,
  DeliveryPlant,
  ProposedVolume,
  ActualVolume,
  @Semantics.amount.currencyCode: 'Currency'
  Deviation,
  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: 'I_Currency', 
      element: 'Currency'
    }, 
    useForValidation: true
  } ]
  Currency,
  CreatedAt,
  CreatedBy,
  LastChangedBy,
  LastChangedAt,
  LocalLastChangedAt,
  _DealPrice : redirected to composition child ZPIBC_DealPriceTP,
  _DealHeader : redirected to parent ZPIBC_DealHeaderTP
  
}
