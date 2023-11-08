@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forDealPrice'
@ObjectModel.semanticKey: [ 'PriceLevel' ]
@Search.searchable: true
define view entity ZPIBC_DealPriceTP
  as projection on ZPIBR_DealPriceTP
{
  key PriceUUID,
  ArticleUUID,
  DealUUID,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  PriceLevel,
  ToPitch,
  @Semantics.amount.currencyCode: 'Currency'
  Valorisation,
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
  _DealPosition : redirected to parent ZPIBC_DealPosition01TP,
  _DealHeader : redirected to ZPIBC_DealHeaderTP
  
}
