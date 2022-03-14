! Generated by make_vegetable_driver. DO NOT EDIT
program main
    implicit none

    call run()
contains
    subroutine run()
        use reference_counted_resource_test, only: &
                reference_counted_resource_reference_counted_resource => &
                    test_reference_counted_resource
        use vegetables, only: test_item_t, test_that, run_tests



        type(test_item_t) :: tests
        type(test_item_t) :: individual_tests(1)

        individual_tests(1) = reference_counted_resource_reference_counted_resource()
        tests = test_that(individual_tests)


        call run_tests(tests)

    end subroutine
end program
