function onCreate()
    
    --BackGround Image
    makeLuaSprite('bg', 'Pool', -600, -200);
    scaleObject('bg', 1.2, 1.2);

    addLuaSprite('bg', false); -- ones ontop are on lower layers
    close(true);
end