@EndUserText.label: 'Reference Customer Master Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_ReferenceCustomerMa_S
  as select from I_Language
    left outer join ZPIB_REF_CUS on 0 = 0
  composition [0..*] of ZI_ReferenceCustomerMa as _ReferenceCustomerMa
{
  key 1 as SingletonID,
  _ReferenceCustomerMa,
  max( ZPIB_REF_CUS.LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
