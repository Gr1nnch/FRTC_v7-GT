module trajectory_data
    use kind_module
    implicit none

    type TrajectoryPoint
        !! С‚РёРї РґР»СЏ С…СЂР°РЅРµРЅРёСЏ С‚РѕС‡РєРё С‚СЂРµРєС‚РѕСЂРёРё
        real(wp)    :: dland, dcoll, perpn, dalf
        real(wp)    :: vel, tetai
        real(wp)    :: xnpar
        real(wp)    :: rho
        real(wp)    :: vthc, poloidn
        integer     :: izz, iww, jrad
        integer     :: driver 
        !! value = 2 or 4, РіРґРµ Р±С‹Р»Р° СЃРѕР·РґР°РЅР° С‚РѕС‡РєР° РІ driver2 РёР»Рё driver4 
        integer     :: ipow
    end type TrajectoryPoint

    integer, parameter :: max_size = 50000

    type Trajectory
        integer size
        !! size of Trajectory
        real(wp) :: tetin  ! tetzap(itr)
        real(wp) :: xmin   ! xmzap(itr)
        real(wp) :: rin    ! rzap(itr)
        real(wp) :: yn3    ! yn3zap(itr)
        real(wp) :: pow    ! powexit
        integer  :: irs    ! irszap(itr)
        integer  :: iw     ! iwzap(itr)
        integer  :: izn    ! iznzap(itr)

        real(wp) :: znakstart
        
        integer  :: spectrum_point_index
        integer  :: mbad
        integer  :: nrefj 

        real(wp) :: tetzap   ! tetzap(itr)
        real(wp) :: xmzap    ! xmzap(itr)
        real(wp) :: rzap     ! rzap(itr)
        real(wp) :: yn3zap   ! yn3zap(itr)
        real(wp) :: powexit  ! powexit
        integer  :: irszap   ! irszap(itr)
        integer  :: iwzap    ! iwzap(itr)
        integer  :: iznzap   ! iznzap(itr)

        type(TrajectoryPoint), allocatable ::  points(:)
        !! 
    contains
        procedure :: init  => init_method
        procedure :: reset => reset_method
        procedure :: add_point => add_point_method
        procedure :: write_info => write_info_method
    end type Trajectory    

    type(Trajectory), pointer :: current_trajectory
contains
    subroutine init_method(this, theta, index)
        !! РёРЅРёС†РёР°Р»РёР·Р°С†РёСЏ С‚СЂР°РµС‚РѕСЂРёРё
        implicit none
        class(Trajectory), intent(inout) :: this
        real(wp),          intent(in)    :: theta
        integer,           intent(in)    :: index
        !print *,'РёРЅРёС‚ РјР°СЃСЃРёРІР° С‚РѕС‡РµРє:', size(this%points)
        if (allocated(this%points)) deallocate(this%points)
        this%tetin = theta
        this%spectrum_point_index = index
        this%size = 0
        this%nrefj = 0
        this%mbad = 0 
        allocate(this%points(max_size))
    end subroutine

    subroutine reset_method(this, index)
        !! СЃР±СЂРѕСЃ СЃС‡РµС‚С‡РёРєР°
        implicit none
        class(Trajectory), intent(inout) :: this
        integer, intent(in) :: index
        this%size = index
    end subroutine

    subroutine add_point_method(this, tpoint)
        !! РґРѕР±Р°РІР»СЏРµРЅРёРµ РЅРѕРІРѕР№ С‚РѕС‡РЅРєРё С‚СЂР°РµРєС‚РѕСЂРёРё
        implicit none
        class(Trajectory), intent(inout) :: this
        class(TrajectoryPoint), intent(in) :: tpoint  
        this%size = this%size + 1
        if (this%size > max_size) then
            print *, 'СЃР»РёС€РєРѕРј РјРЅРѕРіРѕ С‚РѕС‡РµРє'
            stop
        end if
        this%points(this%size) = tpoint
    end subroutine

    subroutine write_info_method(this, iu)
        !! СЃРѕС…СЂР°РЅРµРЅРёРµ РІ С„Р°Р№Р» РёРЅС„РѕСЂРјР°С†РёРё Рѕ С‚СЂР°РµРєС‚РѕСЂРёРё
        implicit none
        class(Trajectory), intent(inout) :: this
        integer, intent(in) :: iu
        write (iu,'(3(A,10x))') 'theta',  'index', 'mbad'
        write (iu,'(f8.5,1x,i5,2x,i5,2x)') this%tetin, this%spectrum_point_index, this%mbad
        write (iu,*)

    end subroutine


end module trajectory_data