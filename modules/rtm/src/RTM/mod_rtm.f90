module mod_rtm
    use mod_types
    use mod_dataspec_wavelength
    use mod_combine
    contains
        subroutine prospect5b_inv(params, np, indp, &
                constants, nc, indc, Refl)
            implicit none
            ! Inputs
            integer(kind=i1), intent(in) :: np, nc, indp(np), indc(nc)
            real(kind=r2), intent(in) :: params(np), constants(nc)

            ! Outputs
            real(kind=r2), intent(out) :: Refl(nw)

            ! Internals
            real(kind=r2) :: RT(nw,2), allparams(np+nc)

            call combine_params(params, np, indp, constants, nc, indc, &
                        allparams)
            call prospect_5b(allparams(1), allparams(2), allparams(3), &
                        allparams(4), allparams(5), allparams(6), RT)
            Refl = RT(:,1)
            return
        end subroutine
end module
