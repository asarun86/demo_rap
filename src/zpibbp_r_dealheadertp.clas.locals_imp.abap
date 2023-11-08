*CLASS lsc_zpibr_dealheadertp DEFINITION INHERITING FROM cl_abap_behavior_saver.
*
*  PROTECTED SECTION.
*
*    METHODS adjust_numbers REDEFINITION.
*
*ENDCLASS.
*
*CLASS lsc_zpibr_dealheadertp IMPLEMENTATION.
*
*  METHOD adjust_numbers.
*  ENDMETHOD.
*
*ENDCLASS.

CLASS lhc_dealheader DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR DealHeader
        RESULT result,
      calculatedealid FOR DETERMINE ON SAVE
        IMPORTING
          keys FOR DealHeader~CalculateDealID,
      CalculateContractDuration FOR DETERMINE ON MODIFY
        IMPORTING keys FOR DealHeader~CalculateContractDuration,
      UpdateSalesRepWithUserData FOR DETERMINE ON MODIFY
        IMPORTING keys FOR DealHeader~UpdateSalesRepWithUserData,
      Submit FOR MODIFY
            IMPORTING keys FOR ACTION DealHeader~Submit.
*      GetNumebrForDealId FOR MODIFY
*        IMPORTING keys FOR ACTION DealHeader~GetNumebrForDealId.

ENDCLASS.

CLASS lhc_dealheader IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD calculatedealid.
    DATA: object   TYPE if_numberrange_buffer=>nr_object,
          interval TYPE if_numberrange_buffer=>nr_interval,
          quantity TYPE if_numberrange_buffer=>nr_quantity.

    "Read the DealHeader entity and check if the DealId is NULL
    READ ENTITIES OF ZPIBR_DealHeaderTP IN LOCAL MODE
        ENTITY DealHeader
        FIELDS ( DealId )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_deal_header).

    "Work-around in trial to get next number
    SELECT MAX( dealid ) FROM ZPIBR_DealHeaderTP INTO @DATA(ls_header).

    "Filter the entries which has Deal ID as NULL and delete the rest
    DELETE lt_deal_header WHERE DealID IS NOT INITIAL.

    LOOP AT lt_deal_header ASSIGNING FIELD-SYMBOL(<fs_deal_header>).
*      object = 'ZDEAL_NR'.
*      interval = '01'.
*      quantity = 1.
*      TRY.
*          DATA(lo_get_number) = cl_numberrange_buffer=>get_instance( ).
*          lo_get_number->if_numberrange_buffer~number_get_no_buffer(
*          EXPORTING
*              iv_object            = object
*              iv_interval          = interval
*              iv_quantity          = quantity
*              iv_ignore_buffer     = abap_true
*          IMPORTING
*              ev_number            = DATA(deal_id)
*              ev_returned_quantity = DATA(returned_qunatity) ).
*        CATCH cx_number_ranges INTO DATA(lr_error).
*      ENDTRY.
      ls_header = ls_header + 1.
      <fs_deal_header>-DealID = ls_header.
    ENDLOOP.
*
    MODIFY ENTITIES OF ZPIBR_DealHeaderTP IN LOCAL MODE
      ENTITY DealHeader
      UPDATE FROM VALUE #( FOR DealHeader IN lt_deal_header
                         (   dealuuid = dealheader-%key-DealUUID
                             dealid   = dealheader-DealID
                    %control-DealID   = if_abap_behv=>mk-on )  ).

  ENDMETHOD.
  METHOD CalculateContractDuration.
    DATA: months TYPE i,
          years  TYPE i.
    "Read the DealHeader entity
    READ ENTITIES OF ZPIBR_DealHeaderTP IN LOCAL MODE
        ENTITY DealHeader
        FIELDS ( DealId )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_deal_header).

    "loop at the entries for which both contract start and end date is not initial
    LOOP AT lt_deal_header ASSIGNING FIELD-SYMBOL(<fs_deal_header>)
        WHERE ContractStartDate IS NOT INITIAL AND ContractEndDate IS NOT INITIAL.
      months = <fs_deal_header>-ContractEndDate+4(2) - <fs_deal_header>-ContractStartDate+4(2).
      years = <fs_deal_header>-ContractEndDate+0(4) - <fs_deal_header>-ContractStartDate+0(4).
      "Check if the months is within a year or not and use the year factor to add 12 months
      "for every year and calculate the total duration
      months = COND #( WHEN years <= 0 THEN months
                          WHEN years >= 1 THEN months + ( years * 12 ) ).
      <fs_deal_header>-ContractDuration = months.

    ENDLOOP.

    "Update the
    MODIFY ENTITIES OF ZPIBR_DealHeaderTP IN LOCAL MODE
      ENTITY DealHeader
      UPDATE FROM VALUE #( FOR DealHeader IN lt_deal_header
                         (   dealuuid           = dealheader-%key-DealUUID
                             ContractDuration   = dealheader-%data-ContractDuration
                    %control-ContractDuration   = if_abap_behv=>mk-on
                    %is_draft                   = if_abap_behv=>mk-on )
                     )
      FAILED DATA(failed_modification)
      REPORTED DATA(reported_modification).
  ENDMETHOD.

  METHOD UpdateSalesRepWithUserData.
    "Read the DealHeader entity
    READ ENTITIES OF ZPIBR_DealHeaderTP IN LOCAL MODE
        ENTITY DealHeader
        FIELDS ( DealId )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_deal_header).

    "loop at the entries for which both contract start and end date is not initial
    LOOP AT lt_deal_header ASSIGNING FIELD-SYMBOL(<fs_deal_header>).
      <fs_deal_header>-SalesRep = COND #( LET null_value = '' IN
                                          WHEN <fs_deal_header>-SrSameAsCreator IS INITIAL
                                           AND <fs_deal_header>-Creator = <fs_deal_header>-SalesRep
                                          THEN null_value
                                          WHEN <fs_deal_header>-SrSameAsCreator IS NOT INITIAL
                                           THEN <fs_deal_header>-Creator ).
    ENDLOOP.

    MODIFY ENTITIES OF ZPIBR_DealHeaderTP IN LOCAL MODE
      ENTITY DealHeader
      UPDATE FROM VALUE #( FOR DealHeader IN lt_deal_header
                         (   dealuuid           = dealheader-%key-DealUUID
                             SalesRep           = dealheader-%data-SalesRep
                    %control-SalesRep           = if_abap_behv=>mk-on
                    %is_draft                   = if_abap_behv=>mk-on )
                     )
      FAILED DATA(failed_modification)
      REPORTED DATA(reported_modification).
    reported-dealheader = CORRESPONDING #( reported_modification-dealheader ).
  ENDMETHOD.

*  METHOD GetNumebrForDealId.
*    DATA: object   TYPE if_numberrange_buffer=>nr_object,
*          interval TYPE if_numberrange_buffer=>nr_interval,
*          quantity TYPE if_numberrange_buffer=>nr_quantity.
*
*    "Read the DealHeader entity and check if the DealId is NULL
*    READ ENTITIES OF ZPIBR_DealHeaderTP IN LOCAL MODE
*        ENTITY DealHeader
*        FIELDS ( DealId )
*        WITH CORRESPONDING #( keys )
*        RESULT DATA(lt_deal_header).
*
*    "Work-around in trial to get next number
*    SELECT MAX( dealid ) FROM ZPIBR_DealHeaderTP INTO @DATA(ls_header).
*
*    "Filter the entries which has Deal ID as NULL and delete the rest
*    DELETE lt_deal_header WHERE DealID IS NOT INITIAL.
*
*    LOOP AT lt_deal_header ASSIGNING FIELD-SYMBOL(<fs_deal_header>).
**      object = 'ZDEAL_NR'.
**      interval = '01'.
**      quantity = 1.
**      TRY.
**          DATA(lo_get_number) = cl_numberrange_buffer=>get_instance( ).
**          lo_get_number->if_numberrange_buffer~number_get_no_buffer(
**          EXPORTING
**              iv_object            = object
**              iv_interval          = interval
**              iv_quantity          = quantity
**              iv_ignore_buffer     = abap_true
**          IMPORTING
**              ev_number            = DATA(deal_id)
**              ev_returned_quantity = DATA(returned_qunatity) ).
**        CATCH cx_number_ranges INTO DATA(lr_error).
**      ENDTRY.
*      ls_header = ls_header + 1.
*      <fs_deal_header>-DealID = ls_header.
*    ENDLOOP.
**
*    MODIFY ENTITIES OF ZPIBR_DealHeaderTP IN LOCAL MODE
*      ENTITY DealHeader
*      UPDATE FROM VALUE #( FOR DealHeader IN lt_deal_header
*                         (   dealuuid = dealheader-%key-DealUUID
*                             dealid   = dealheader-DealID
*                    %control-DealID   = if_abap_behv=>mk-on )  ).
*  ENDMETHOD.

  METHOD Submit.
  ENDMETHOD.

ENDCLASS.
