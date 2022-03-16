module ref_reference_test
  use ref_reference_m, only : ref_reference_t
  use vegetables, only: result_t, test_item_t, describe, it, assert_equals

  implicit none
  private
  public :: test_ref_reference

  type, extends(ref_reference_t) :: resource_t
    integer dummy
  contains
    procedure :: free
  end type

  interface resource_t
    module function construct() result(resource)
      implicit none
      type(resource_t) resource
    end function
  end interface

  enum, bind(C)
    enumerator :: never_referenced, not_freed, freed
  end enum

  integer, parameter :: max_resources=1000, avoid_unused_variable_warning = 0
  integer :: ref_status(max_resources) = never_referenced
  
contains

  module function construct() result(resource)
    type(resource_t) resource
    call resource%start_ref_counter
  end function

  subroutine free(self)
    class(resource_t), intent(inout) :: self
    self%dummy = avoid_unused_variable_warning
  end subroutine

  function test_ref_reference() result(tests)
    type(test_item_t) :: tests

    tests = &
      describe( &
        "A ref_reference", &
        [ it("does not leak when constructed, assigned, and then explicitly freed", check_for_leaks) &
      ])
  end function

  function check_for_leaks() result(result_)
    type(result_t) :: result_
    type(resource_t) resource

    resource = resource_t()
    call resource%free

    associate(num_never_referenced => count( ref_status == never_referenced ), num_freed => count( ref_status == freed ))
     associate(num_leaks => max_resources - (num_never_referenced + num_freed))
        result_ = assert_equals(0, num_leaks)
      end associate
    end associate
  end function

end module ref_reference_test