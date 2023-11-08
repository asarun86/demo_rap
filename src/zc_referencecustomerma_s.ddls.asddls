@EndUserText.label: 'Maintain Reference Customer Master Singl'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_ReferenceCustomerMa_S
  provider contract transactional_query
  as projection on ZI_ReferenceCustomerMa_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _ReferenceCustomerMa : redirected to composition child ZC_ReferenceCustomerMa
  
}
