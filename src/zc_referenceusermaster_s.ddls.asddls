@EndUserText.label: 'Maintain Reference User Master Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_ReferenceUserMaster_S
  provider contract transactional_query
  as projection on ZI_ReferenceUserMaster_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _ReferenceUserMaster : redirected to composition child ZC_ReferenceUserMaster
  
}
