module source_new_mod
    use kind_module   
    implicit none
    real(wp) :: rsou(102),sou(102)
    integer  :: npta
    !!common /asou/ rsou(102),sou(102),npta
    !! РёСЃРїРѕР»СЊР·СѓРµС‚СЃСЏ РІ source_new Рё ourlhcd2017

contains

    subroutine source_new(r,out)
        use lock_module
        implicit real*8 (a-h,o-z)
        integer klo, khi, ierr
        !common /asou/ rsou(102),sou(102),npta
        call lock2(rsou,npta,r,klo,khi,ierr)
        if(ierr.ne.0) then
            write(*,*)'lock2 error in source_new'
            write(*,*)'ierr=',ierr,' rho=',r
            stop
        else
            call linf(rsou,sou,r,fout,klo,khi)
            out=dabs(fout)
        end if
    end     

end module source_new_mod