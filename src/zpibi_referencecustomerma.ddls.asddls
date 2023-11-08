@EndUserText.label: 'Projection View for customer master'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity ZPIBI_Referencecustomerma as projection on ZI_ReferenceCustomerMa
{
    key Customer,
    key PartnerFunction,
    CustomerName,
    CustomerRole,
    CreatedAt,
    CreatedBy,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    SingletonID,
    /* Associations */
    _ReferenceCustomeAll
}
