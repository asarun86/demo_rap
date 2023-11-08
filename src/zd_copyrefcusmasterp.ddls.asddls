@EndUserText.label: 'Copy Reference Customer Master'
define abstract entity ZD_CopyRefCusMasterP
{
  @EndUserText.label: 'New Customer'
  Customer : abap.char( 10 );
  Partner_function : abap.char(2);
}
