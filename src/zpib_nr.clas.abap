CLASS zpib_nr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zpib_nr IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA: lv_norange    TYPE REF TO cl_numberrange_objects,
          lv_interval   TYPE REF TO cl_numberrange_intervals,
          lv_runtime    TYPE REF TO cl_numberrange_runtime,
          nr_attribute  TYPE cl_numberrange_objects=>nr_attribute,
          obj_text      TYPE cl_numberrange_objects=>nr_obj_text,
          lv_returncode TYPE cl_numberrange_objects=>nr_returncode,
          lv_errors     TYPE cl_numberrange_objects=>nr_errors,
          nr_interval   TYPE cl_numberrange_intervals=>nr_interval,
          st_interval   LIKE LINE OF nr_interval,
          error         TYPE cl_numberrange_intervals=>nr_error,
          error_inf     TYPE cl_numberrange_intervals=>nr_error_inf,
          error_iv      TYPE cl_numberrange_intervals=>nr_error_iv,
          warning       TYPE cl_numberrange_intervals=>nr_warning.

    DATA: lx_number_range TYPE REF TO cx_number_ranges,
          lx_no_obj_found TYPE REF TO cx_nr_object_not_found.

**    nr_attribute-buffer = ' '.
**    nr_attribute-object = 'ZDEAL_NR'.  " Object name
**    nr_attribute-domlen = 'ZPIB_DEAL_ID'.  " Domain to be used (e.g., CHAR 10)
**    nr_attribute-percentage = 10.
**    nr_attribute-devclass = 'ZPIB_NR'. " Class where number range is created
**
**    obj_text-langu = 'E'.
**    obj_text-object = 'Z_NUM_RANGE'.  " Object name
**    obj_text-txt = 'Testing Num Range'.  " Long description
**    obj_text-txtshort = 'Test'.  " Short description

    st_interval-subobject = ''.
    st_interval-nrrangenr = '01'.  " Number range interval
    st_interval-fromnumber  = '000000001'.  " Starting number
    st_interval-tonumber    = '999999999'.  " Ending number
    st_interval-procind     = 'I'.
    APPEND st_interval TO nr_interval.

**    TRY.
**        cl_numberrange_objects=>create(
**          EXPORTING
**            attributes                = nr_attribute
**            obj_text                  = obj_text
**          IMPORTING
**            errors = lv_errors
**            returncode = lv_returncode )
**          .
**      CATCH cx_number_ranges INTO lx_number_range.
**        " Handle the exception
**    ENDTRY.

    DATA: lv_object TYPE zobject.
    lv_object = 'ZDEAL_NR'.

    TRY.
        cl_numberrange_intervals=>create(
          EXPORTING
            interval  = nr_interval
            object    = lv_object  " Object name
            subobject = ''
          IMPORTING
            error     = error
            error_inf = error_inf
            error_iv  = error_iv ).
      CATCH cx_nr_object_not_found INTO lx_no_obj_found.
        " Handle the exception
      CATCH cx_number_ranges INTO lx_number_range.
        " Handle the exception
    ENDTRY.
    lv_returncode = '01'.
    out->write( lv_returncode ).
  ENDMETHOD.
ENDCLASS.
