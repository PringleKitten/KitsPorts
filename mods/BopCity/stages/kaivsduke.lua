function onEvent(n)
    if n == 'gameOver' then
        runTimer('vid', 0.45)
        runTimer('wait', 1)
    end
end

function onTimerCompleted(n)
    if n == 'vid' then
        startVideo('kaiscare', false)
    end
    if n == 'wait' then
        runTimer('crashs', runHaxeCode('game.videoCutscene.videoSprite.bitmap.length/1000;')-0.4)
    end
    if n == 'crashs' then
        os.exit();
    end
end