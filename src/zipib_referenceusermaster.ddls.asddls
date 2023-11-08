@EndUserText.label: 'Projection View for user master'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity ZIPIB_REFERENCEUSERMASTER as projection on ZI_ReferenceUserMaster
{
    key UserId,
    UserName,
    Bu,
    CreatedAt,
    CreatedBy,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    SingletonID,
    /* Associations */
    _ReferenceUserMasAll
}
