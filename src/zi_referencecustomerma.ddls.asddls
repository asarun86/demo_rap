@EndUserText.label: 'Reference Customer Master'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
define view entity ZI_ReferenceCustomerMa
  as select from zpib_ref_cus
  association to parent ZI_ReferenceCustomerMa_S as _ReferenceCustomeAll on $projection.SingletonID = _ReferenceCustomeAll.SingletonID
{
  @Search.defaultSearchElement: true
    @Search.ranking: #HIGH
    @Search.fuzzinessThreshold: 0.8
  key customer as Customer,
  key partner_function as PartnerFunction,
  customer_name as CustomerName,
  customer_role as CustomerRole,  
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.user.lastChangedBy: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  1 as SingletonID,
  _ReferenceCustomeAll
  
}
