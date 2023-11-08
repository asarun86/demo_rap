CLASS zpib_transient_implementation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_calc_element_read.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zpib_transient_implementation IMPLEMENTATION.
  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

*    LOOP AT it_requested_calc_elements ASSIGNING FIELD-SYMBOL(<fs_calc_element>).
*      CASE <fs_calc_element>.
*        WHEN 'TOTALDURATION'.
*          APPEND 'CONTRACTENDDATE' TO et_requested_orig_elements.
*          APPEND 'CONTRACTSTARTDATE' TO et_requested_orig_elements.
*        WHEN OTHERS.
*          "Raise Exception
*      ENDCASE.
*    ENDLOOP.
  ENDMETHOD.
  METHOD if_sadl_exit_calc_element_read~calculate.

    DATA: lt_original_data TYPE STANDARD TABLE OF ZPIBC_DealHeaderTP WITH DEFAULT KEY,
          months TYPE i,
          years TYPE i.

    lt_original_data = CORRESPONDING #( it_original_data ).

    LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<fs_original_data>).
      months = <fs_original_data>-ContractEndDate+4(2) - <fs_original_data>-ContractStartDate+4(2).
      years = <fs_original_data>-ContractEndDate+0(4) - <fs_original_data>-ContractStartDate+0(4).
      "Check if the months is within a year or not and use the year factor to add 12 months
      "for every year and calculate the total duration
      months = COND #( WHEN years <= 0 THEN months
                          WHEN years >= 1 THEN months + ( years * 12 ) ).
      <fs_original_data>-TotalDuration = months.
    ENDLOOP.

    ct_calculated_data = CORRESPONDING #(  lt_original_data ).
  ENDMETHOD.
ENDCLASS.
