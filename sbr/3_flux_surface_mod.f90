module FluxSurface_mod
    !! РІСЃРµ С‡С‚Рѕ СЃРІСЏР·Р°РЅРЅРѕ СЃ РјР°РіРЅРёС‚РЅС‹РјРё РїРѕРІРµСЂС…РЅРѕСЃС‚СЏРјРё
    use kind_module
    type FluxSurface 
    !! РєР»Р°СЃСЃ РјР°РіРЅРёС‚РЅРѕР№ РїРѕРІРµСЂС…РЅРѕСЃС‚Рё
        integer       :: index
        !! РЅРѕРјРµСЂ РјР°РіРЅРёС‚РЅРѕР№ РїРѕРІРµСЂС…РЅРѕСЃС‚Рё
        real(wp) :: r
        !! СЂР°РґРёСѓСЃ
        real(wp) :: vmax
        !! vmax=cltn/vto
        real(wp) :: vt
        !! РЅР°РІРµСЂРЅРѕ С‚РµРїР»РѕРІР°СЏ СЃРєРѕСЂРѕСЃС‚СЊ СЌР»РµРєС‚СЂРѕРЅРѕРІ????? vt=fvt(r)
        integer       :: ipt
        !! СЂР°Р·РјРµСЂ vgrid
        real(wp), allocatable :: vgrid(:)
        !! 
        real(wp), allocatable :: vr_grid(:)
        !! Р±С‹РІР°С€РёР№ vrj
        real(wp), allocatable :: diffusion(:)
        !! Р±С‹РІС€РёР№ dijk(i,j,k) РёР»Рё dj(i)
        !   complex         :: inst_field1
        contains
        !procedure :: set   => set_e
        !procedure :: print => e_print

    end type FluxSurface  

end module FluxSurface_mod