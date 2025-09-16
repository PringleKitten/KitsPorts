local doZoom = true
function onEvent(n,a,b)
    if n == 'Set_Cam_Zoom' or n == 'Set_Cam_Zoom_cI' then
        doZoom = false
        cancelTimer('wait')
        runTimer('wait', b)
    end
    if n == 'Add Camera Zoom' then
        local cZ = getProperty('defaultCamZoom')
        if doZoom then
            setProperty('camGame.zoom', getProperty('camGame.zoom')+0.05)
            doTweenZoom('bruh', 'game', cZ, 0.15, 'sineOut')
        end
        setProperty('camHUD.zoom', 1.05)
        setProperty('camZoomsHud', false)
        doTweenZoom('bruh1', 'hud', 1, 0.15, 'sineOut')
    end
end
function onUpdate()
    setProperty('defaultCamZoom', getProperty('camGame.zoom'))
end
function onTimerCompleted(t)
    if t == 'wait' then
        doZoom = true
    end
end
function onTweenCompleted(t)
    if t == 'bruh1' then
        setProperty('camZoomsHud', true)
    end
end