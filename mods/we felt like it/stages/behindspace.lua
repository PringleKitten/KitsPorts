function onCreate()
    setProperty('defaultCamZoom', 0.8)
	makeLuaSprite('room', 'background/thebehindspace/room');
    scaleObject('room', 1.5,1.5);
	screenCenter('room', 'xy')
    addLuaSprite('room', false);

    close(true)
end