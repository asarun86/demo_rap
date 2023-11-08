CLASS LHC_RAP_TDAT_CTS DEFINITION FINAL.
  PUBLIC SECTION.
    CLASS-METHODS:
      GET
        RETURNING
          VALUE(RESULT) TYPE REF TO IF_MBC_CP_RAP_TABLE_CTS.

ENDCLASS.

CLASS LHC_RAP_TDAT_CTS IMPLEMENTATION.
  METHOD GET.
    result = mbc_cp_api=>rap_table_cts( table_entity_relations = VALUE #(
                                         ( entity = 'ReferenceCustomerMa' table = 'ZPIB_REF_CUS' )
                                       ) ) ##NO_TEXT.
  ENDMETHOD.
ENDCLASS.
CLASS LHC_ZI_REFERENCECUSTOMERMA_S DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_INSTANCE_FEATURES FOR INSTANCE FEATURES
        IMPORTING
          KEYS REQUEST requested_features FOR ReferenceCustomeAll
        RESULT result,
      SELECTCUSTOMIZINGTRANSPTREQ FOR MODIFY
        IMPORTING
          KEYS FOR ACTION ReferenceCustomeAll~SelectCustomizingTransptReq
        RESULT result,
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ReferenceCustomeAll
        RESULT result.
ENDCLASS.

CLASS LHC_ZI_REFERENCECUSTOMERMA_S IMPLEMENTATION.
  METHOD GET_INSTANCE_FEATURES.
    DATA: selecttransport_flag TYPE abp_behv_flag VALUE if_abap_behv=>fc-o-enabled,
          edit_flag            TYPE abp_behv_flag VALUE if_abap_behv=>fc-o-enabled.

    IF cl_bcfg_cd_reuse_api_factory=>get_cust_obj_service_instance(
        iv_objectname = 'ZPIB_REF_CUS'
        iv_objecttype = cl_bcfg_cd_reuse_api_factory=>simple_table )->is_editable( ) = abap_false.
      edit_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    DATA(transport_service) = cl_bcfg_cd_reuse_api_factory=>get_transport_service_instance(
                                iv_objectname = 'ZPIB_REF_CUS'
                                iv_objecttype = cl_bcfg_cd_reuse_api_factory=>simple_table ).
    IF transport_service->is_transport_allowed( ) = abap_false.
      selecttransport_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    READ ENTITIES OF ZI_ReferenceCustomerMa_S IN LOCAL MODE
    ENTITY ReferenceCustomeAll
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(all).
    IF all[ 1 ]-%IS_DRAFT = if_abap_behv=>mk-off.
      selecttransport_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    result = VALUE #( (
               %TKY = all[ 1 ]-%TKY
               %ACTION-edit = edit_flag
               %ASSOC-_ReferenceCustomerMa = edit_flag
               %ACTION-SelectCustomizingTransptReq = selecttransport_flag ) ).
  ENDMETHOD.
  METHOD SELECTCUSTOMIZINGTRANSPTREQ.
    MODIFY ENTITIES OF ZI_ReferenceCustomerMa_S IN LOCAL MODE
      ENTITY ReferenceCustomeAll
        UPDATE FIELDS ( TransportRequestID HideTransport )
        WITH VALUE #( FOR key IN keys
                        ( %TKY               = key-%TKY
                          TransportRequestID = key-%PARAM-transportrequestid
                          HideTransport      = abap_false ) ).

    READ ENTITIES OF ZI_ReferenceCustomerMa_S IN LOCAL MODE
      ENTITY ReferenceCustomeAll
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(entities).
    result = VALUE #( FOR entity IN entities
                        ( %TKY   = entity-%TKY
                          %PARAM = entity ) ).
  ENDMETHOD.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
*    AUTHORITY-CHECK OBJECT 'S_TABU_NAM' ID 'TABLE' FIELD 'ZI_REFERENCECUSTOMERMA' ID 'ACTVT' FIELD '02'.
*    DATA(is_authorized) = COND #( WHEN sy-subrc = 0 THEN if_abap_behv=>auth-allowed
*                                  ELSE if_abap_behv=>auth-unauthorized ).
*    result-%UPDATE      = is_authorized.
*    result-%ACTION-Edit = is_authorized.
*    result-%ACTION-SelectCustomizingTransptReq = is_authorized.
  ENDMETHOD.
ENDCLASS.
CLASS LSC_ZI_REFERENCECUSTOMERMA_S DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_SAVER.
  PROTECTED SECTION.
    METHODS:
      SAVE_MODIFIED REDEFINITION,
      CLEANUP_FINALIZE REDEFINITION.
ENDCLASS.

CLASS LSC_ZI_REFERENCECUSTOMERMA_S IMPLEMENTATION.
  METHOD SAVE_MODIFIED.
*    READ TABLE update-ReferenceCustomeAll INDEX 1 INTO DATA(all).
*    IF all-TransportRequestID IS NOT INITIAL.
*      lhc_rap_tdat_cts=>get( )->record_changes(
*                                  transport_request = all-TransportRequestID
*                                  create            = REF #( create )
*                                  update            = REF #( update )
*                                  delete            = REF #( delete ) ).
*    ENDIF.
  ENDMETHOD.
  METHOD CLEANUP_FINALIZE ##NEEDED.
  ENDMETHOD.
ENDCLASS.
CLASS LHC_ZI_REFERENCECUSTOMERMA DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      VALIDATETRANSPORTREQUEST FOR VALIDATE ON SAVE
        IMPORTING
          KEYS FOR ReferenceCustomerMa~ValidateTransportRequest,
      GET_GLOBAL_FEATURES FOR GLOBAL FEATURES
        IMPORTING
          REQUEST REQUESTED_FEATURES FOR ReferenceCustomerMa
        RESULT result,
      COPYREFERENCECUSTOMERMA FOR MODIFY
        IMPORTING
          KEYS FOR ACTION ReferenceCustomerMa~CopyReferenceCustomerMa,
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ReferenceCustomerMa
        RESULT result,
      GET_INSTANCE_FEATURES FOR INSTANCE FEATURES
        IMPORTING
          KEYS REQUEST requested_features FOR ReferenceCustomerMa
        RESULT result.
ENDCLASS.

CLASS LHC_ZI_REFERENCECUSTOMERMA IMPLEMENTATION.
  METHOD VALIDATETRANSPORTREQUEST.
*    DATA change TYPE REQUEST FOR CHANGE ZI_ReferenceCustomerMa_S.
*    SELECT SINGLE TransportRequestID
*      FROM ZPIB_REF_CUS_D_S
*      WHERE SingletonID = 1
*      INTO @DATA(TransportRequestID).
*    lhc_rap_tdat_cts=>get( )->validate_changes(
*                                transport_request = TransportRequestID
*                                table             = 'ZPIB_REF_CUS'
*                                keys              = REF #( keys )
*                                reported          = REF #( reported )
*                                failed            = REF #( failed )
*                                change            = REF #( change-ReferenceCustomerMa ) ).
  ENDMETHOD.
  METHOD GET_GLOBAL_FEATURES.
    DATA edit_flag TYPE abp_behv_flag VALUE if_abap_behv=>fc-o-enabled.
    IF cl_bcfg_cd_reuse_api_factory=>get_cust_obj_service_instance(
         iv_objectname = 'ZPIB_REF_CUS'
         iv_objecttype = cl_bcfg_cd_reuse_api_factory=>simple_table )->is_editable( ) = abap_false.
      edit_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    result-%UPDATE = edit_flag.
    result-%DELETE = edit_flag.
  ENDMETHOD.
  METHOD COPYREFERENCECUSTOMERMA.
    DATA new_ReferenceCustomerMa TYPE TABLE FOR CREATE ZI_ReferenceCustomerMa_S\_ReferenceCustomerMa.

    IF lines( keys ) > 1.
      INSERT mbc_cp_api=>message( )->get_select_only_one_entry( ) INTO TABLE reported-%other.
      failed-ReferenceCustomerMa = VALUE #( FOR fkey IN keys ( %TKY = fkey-%TKY ) ).
      RETURN.
    ENDIF.

    READ ENTITIES OF ZI_ReferenceCustomerMa_S IN LOCAL MODE
      ENTITY ReferenceCustomerMa
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(ref_ReferenceCustomerMa)
      FAILED DATA(read_failed).

    LOOP AT ref_ReferenceCustomerMa ASSIGNING FIELD-SYMBOL(<ref_ReferenceCustomerMa>).
      DATA(key) = keys[ KEY draft %TKY = <ref_ReferenceCustomerMa>-%TKY ].
      DATA(key_cid) = key-%CID.
      APPEND VALUE #(
        %TKY-SingletonID = 1
        %IS_DRAFT = <ref_ReferenceCustomerMa>-%IS_DRAFT
        %TARGET = VALUE #( (
          %CID = key_cid
          %IS_DRAFT = <ref_ReferenceCustomerMa>-%IS_DRAFT
          %DATA = CORRESPONDING #( <ref_ReferenceCustomerMa> EXCEPT
            CreatedAt
            CreatedBy
            Customer
            LastChangedAt
            LastChangedBy
            LocalLastChangedAt
            SingletonID
        ) ) )
      ) TO new_ReferenceCustomerMa ASSIGNING FIELD-SYMBOL(<new_ReferenceCustomerMa>).
      <new_ReferenceCustomerMa>-%TARGET[ 1 ]-Customer = key-%PARAM-Customer.
    ENDLOOP.

    MODIFY ENTITIES OF ZI_ReferenceCustomerMa_S IN LOCAL MODE
      ENTITY ReferenceCustomeAll CREATE BY \_ReferenceCustomerMa
      FIELDS (
               Customer
               CustomerName
               CustomerRole
               PartnerFunction
             ) WITH new_ReferenceCustomerMa
      MAPPED DATA(mapped_create)
      FAILED failed
      REPORTED reported.

    mapped-ReferenceCustomerMa = mapped_create-ReferenceCustomerMa.
    INSERT LINES OF read_failed-ReferenceCustomerMa INTO TABLE failed-ReferenceCustomerMa.

    IF failed-ReferenceCustomerMa IS INITIAL.
      reported-ReferenceCustomerMa = VALUE #( FOR created IN mapped-ReferenceCustomerMa (
                                                 %CID = created-%CID
                                                 %ACTION-CopyReferenceCustomerMa = if_abap_behv=>mk-on
                                                 %MSG = mbc_cp_api=>message( )->get_item_copied( )
                                                 %PATH-ReferenceCustomeAll-%IS_DRAFT = created-%IS_DRAFT
                                                 %PATH-ReferenceCustomeAll-SingletonID = 1 ) ).
    ENDIF.
  ENDMETHOD.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
*    AUTHORITY-CHECK OBJECT 'S_TABU_NAM' ID 'TABLE' FIELD 'ZI_REFERENCECUSTOMERMA' ID 'ACTVT' FIELD '02'.
*    DATA(is_authorized) = COND #( WHEN sy-subrc = 0 THEN if_abap_behv=>auth-allowed
*                                  ELSE if_abap_behv=>auth-unauthorized ).
*    result-%ACTION-CopyReferenceCustomerMa = is_authorized.
  ENDMETHOD.
  METHOD GET_INSTANCE_FEATURES.
    result = VALUE #( FOR row IN keys ( %TKY = row-%TKY
                                        %ACTION-CopyReferenceCustomerMa = COND #( WHEN row-%IS_DRAFT = if_abap_behv=>mk-off THEN if_abap_behv=>fc-o-disabled ELSE if_abap_behv=>fc-o-enabled )
   ) ).
  ENDMETHOD.
ENDCLASS.
