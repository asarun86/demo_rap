@EndUserText.label: 'Reference User Master Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_ReferenceUserMaster_S
  as select from I_Language
    left outer join ZPIB_REF_USER on 0 = 0
  composition [0..*] of ZI_ReferenceUserMaster as _ReferenceUserMaster
{
  key 1 as SingletonID,
  _ReferenceUserMaster,
  max( ZPIB_REF_USER.LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
