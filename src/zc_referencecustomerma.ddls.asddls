@EndUserText.label: 'Maintain Reference Customer Master'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_ReferenceCustomerMa
  as projection on ZI_ReferenceCustomerMa
{
  key Customer,
  key PartnerFunction,
  CustomerName,
  CustomerRole,  
  CreatedAt,
  CreatedBy,
  LastChangedBy,
  LastChangedAt,
  @Consumption.hidden: true
  LocalLastChangedAt,
  @Consumption.hidden: true
  SingletonID,
  _ReferenceCustomeAll : redirected to parent ZC_ReferenceCustomerMa_S
  
}
