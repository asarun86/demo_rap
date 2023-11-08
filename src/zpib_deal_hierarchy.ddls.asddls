@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity zpib_deal_hierarchy
  as select from zpib_deal_items
  association [1..1] to zpib_deal_hierarchy as _tree  
    on $projection.parent = _tree.article_uuid
{
      _tree,
      key article_uuid,
      deal_uuid as parent,
      article_no
}

//define hierarchy zpib_deal_hierarchy
//  with parameters
//    p_id : abap.int4
//  as parent child hierarchy(
//    source
//      DEMO_CDS_SIMPLE_TREE_SOURCE
//      child to parent association _tree
//      start where
//        id = :p_id
//      siblings order by
//        id ascending
//    )
//    {
//      id,
//      parent,
//      name
//    }
