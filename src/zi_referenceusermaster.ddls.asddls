@EndUserText.label: 'Reference User Master'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_ReferenceUserMaster
  as select from ZPIB_REF_USER
  association to parent ZI_ReferenceUserMaster_S as _ReferenceUserMasAll on $projection.SingletonID = _ReferenceUserMasAll.SingletonID
{
  key USER_ID as UserId,
  USER_NAME as UserName,
  BU as Bu,
  @Semantics.systemDateTime.createdAt: true
  CREATED_AT as CreatedAt,
  @Semantics.user.createdBy: true
  CREATED_BY as CreatedBy,
  @Semantics.user.lastChangedBy: true
  LAST_CHANGED_BY as LastChangedBy,
  @Semantics.systemDateTime.lastChangedAt: true
  LAST_CHANGED_AT as LastChangedAt,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  1 as SingletonID,
  _ReferenceUserMasAll
  
}
