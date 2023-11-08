@EndUserText.label: 'Maintain Reference User Master'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_ReferenceUserMaster
  as projection on ZI_ReferenceUserMaster
{
  key UserId,
  UserName,
  Bu,
  CreatedAt,
  CreatedBy,
  LastChangedBy,
  LastChangedAt,
  @Consumption.hidden: true
  LocalLastChangedAt,
  @Consumption.hidden: true
  SingletonID,
  _ReferenceUserMasAll : redirected to parent ZC_ReferenceUserMaster_S
  
}
