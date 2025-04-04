function onCreate()
	makeLuaSprite('skibidistage', 'bg/skibidi/skibidibgstage', -175, 120);
	setScrollFactor('skibidibgstage', 0.3, 0.3);
	addLuaSprite('skibidistage', false);

	setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'bf-full-invis');
	setPropertyFromClass('substates.GameOverSubstate', 'deathSoundName', 'nothing');
	setPropertyFromClass('substates.GameOverSubstate', 'loopSoundName', 'nothing');
	setPropertyFromClass('substates.GameOverSubstate', 'endSoundName', 'nothing');
end

function onGameOverStart()
	startVideo('dead')
	runTimer('ded', 6)
end

function onTimerCompleted(n)
	if n == 'ded' then
		restartSong()
	end
end

function onBeatHit()
	if curBeat == 184 then
		startVideo('dead', false)
	end
end