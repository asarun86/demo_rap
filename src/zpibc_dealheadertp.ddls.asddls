@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forDealHeader'
@ObjectModel.semanticKey: [ 'DealID' ]
@Search.searchable: true
define root view entity ZPIBC_DealHeaderTP
  provider contract transactional_query
  as projection on ZPIBR_DealHeaderTP
{
  key DealUUID,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  DealID,
  @Consumption.valueHelpDefinition: 
  [ {
    entity: 
    { name: 'ZIPIB_REFERENCEUSERMASTER',
      element: 'UserId'
    },
    useForValidation: true
    }]
  Creator,
  _User.UserName as UserName,
  _User.Bu as UserBU,
  SrSameAsCreator,
  @Consumption.valueHelpDefinition: 
  [ {
    entity: 
    { name: 'ZIPIB_REFERENCEUSERMASTER',
      element: 'UserId'
    },
    useForValidation: true
    }]
  SalesRep,
  _SalesRep.UserName as SaleRepName,
  _SalesRep.Bu as SalesRepBU,
  NewCustomer,
  @Consumption.valueHelpDefinition: 
  [ {
    entity: 
    { name: 'ZPIBI_Referencecustomerma',
      element: 'Customer'
    },
    useForValidation: true
    }]
  SoldToParty,
  _SoldToParty.CustomerName as SoldToCustomerName,
  _SoldToParty.CustomerRole as SoldToCustomerRole,  
  @Consumption.valueHelpDefinition: 
  [ {
    entity: 
    { name: 'ZPIBI_Referencecustomerma',
      element: 'Customer'
    },
    useForValidation: true
    }]  
  ShipToParty,
  _ShipToParty.CustomerName as ShipToCustomerName,
  _ShipToParty.CustomerRole as ShipToCustomerRole,  
  VolumeDigestion,
  OfferDate,
  ContractStartDate,
  ContractEndDate,
  ContractDuration,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZPIB_TRANSIENT_IMPLEMENTATION'
  virtual TotalDuration: abap.int4,
  @Semantics.amount.currencyCode: 'Currency'
  TargetMilkPricegoal,
  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: 'I_Currency', 
      element: 'Currency'
    }, 
    useForValidation: true
  } ]
  Currency,
  CreatedAt,
  CreatedBy,
  LastChangedBy,
  LastChangedAt,
  LocalLastChangedAt,
  _DealPosition : redirected to composition child ZPIBC_DealPosition01TP,
  _SoldToParty : redirected to ZC_ReferenceCustomerMa,
  _ShipToParty : redirected to ZC_ReferenceCustomerMa,
  _User : redirected to ZC_ReferenceUserMaster
}
