playCutscene = true;
local canSkipDialogue = false
local letter = 0
local dialoguePosition = 0
local canEnter = false
local canX = false

dialog = ""
dialogSound = ""

local defaultBFy = getProperty('boyfriend.y')

function onCreate()
	if isStoryMode and not seenCutscene then
	end
end

function onStartCountdown()
	if isStoryMode and not seenCutscene then
		if playCutscene then
			playCutscene = false
			setProperty('vocals.volume', 0)
			setProperty('healthBar.visible', false);
			setProperty('iconP1.visible', false);
			setProperty('iconP2.visible', false);
			setProperty('scoreTxt.visible', false);
			playMusic('city', 1, true);

			makeLuaSprite('whiteBG', 'empty', 0, 0);
			makeGraphic('whiteBG', screenWidth, screenHeight, 'FFFFFF');
			setObjectCamera('whiteBG', 'other');
			setProperty('whiteBG.alpha', 0.5);
				
			makeAnimatedLuaSprite('whittyPort', 'whittyPort', 200, 190);
			addAnimationByPrefix('whittyPort', 'whittyPort', 'Whitty Portrait Agitated instance 1', 24, false);
			setObjectCamera('whittyPort', 'other');
			setProperty('whittyPort.visible', false);
			scaleObject('whittyPort', 0.8, 0.8);
			playAnim('whittyPort', 'whittyPort')
				
			makeLuaSprite('boyfriendPort', 'boyfriendPort', 820, 222);
			setObjectCamera('boyfriendPort', 'other');
			setProperty('boyfriendPort.visible', false);
			scaleObject('boyfriendPort', 0.8, 0.8);
				
			makeAnimatedLuaSprite('speech_bubble', 'speech_bubble_talking', 10, 320);
			addAnimationByPrefix('speech_bubble', 'idle', 'speech bubble normal', 24, true);
			addAnimationByPrefix('speech_bubble', 'open', 'Speech Bubble Normal Open', 24, false);
			setObjectCamera('speech_bubble', 'other');
			playAnim('speech_bubble', 'open')

			makeLuaText('textLineBack', '', 770, 252, 462);
			setObjectCamera('textLineBack', 'other');
			setTextAlignment('textLineBack', 'left');
			setTextSize('textLineBack', 32);
			setTextFont('textLineBack', 'vcr.ttf');
			setTextBorder('textLineBack', 0, FFFFFF);
			setTextColor('textLineBack', 'FF0000');
			
			makeLuaText('textLine', '', 770, 250, 460);
			setObjectCamera('textLine', 'other');
			setTextAlignment('textLine', 'left');
			setTextSize('textLine', 32);
			setTextFont('textLine', 'vcr.ttf');
			setTextBorder('textLine', 0, FFFFFF);
			setTextColor('textLine', '000000');

			addLuaSprite('whiteBG', false);
			addLuaSprite('whittyPort', false);
			addLuaSprite('boyfriendPort', false);
			addLuaSprite('speech_bubble', false);
			addLuaText('textLineBack');
			addLuaText('textLine');

			runTimer('speech bubble idle', 0.3);
			return Function_Stop;
		end
	end
	if not playCutscene then
		if getProperty('cpuControlled', true) then
			setProperty('botplayTxt.visible', true);
		end
		setProperty('vocals.volume', 1)
		return Function_Continue;
	end
end

function dialogueFunc(text, sound)
	dialog = text
	dialogSound = sound
	canX = true
	canEnter = false
	runTimer('letter', 0.04, string.len(dialog));
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'letter' and canX then
		setTextString('textLine', string.sub(dialog, 0, (loops - loopsLeft)));
		setTextString('textLineBack', string.sub(dialog, 0, (loops - loopsLeft)));
		playSound(dialogSound, 0.8);
		if loopsLeft == 0 then
			canX = false
			canEnter = true
		end
	end
	if tag == 'speech bubble idle' then
		letter = 0
		canSkipAll = false
		canSkipDialogue = true
		playAnim('speech_bubble', 'idle');
		setProperty('speech_bubble.x', 50);
		setProperty('speech_bubble.y', 400);
		setProperty('whittyPort.visible', true);
		setProperty('boyfriendPort.visible', false);
		runTimer('textBox1timer', 0.05);

		removeLuaSprite('skip');
		makeLuaText('skipText', 'Press BACK/PAUSE to Skip', 770, screenWidth-780, screenHeight-30);
		setObjectCamera('skipText', 'other');
		setTextAlignment('skipText', 'right');
		setTextSize('skipText', 20);
		setTextFont('skipText', 'vcr.ttf');

		addLuaText('skipText');
	end
	if tag == 'textBox1timer' then
		dialogueFunc('I see how it is.', 'whitty')
	end
	if tag == 'textBox2timer' then
		dialogueFunc('brep bappity boop', 'pixelText')
	end
	if tag == 'textBox3timer' then
		dialogueFunc("You're really pushing my limits, dude.", 'whitty')
	end
	if tag == 'textBox4timer' then
		dialogueFunc("bip bep skoo de boop", 'pixelText')
	end
	if tag == 'textBox5timer' then
		dialogueFunc('Well how about you go die in a ditch \ninstead.', 'whitty')
	end
	if tag == 'textBox6timer' then
		dialogueFunc("bepoobee skoop", 'pixelText')
	end
	if tag == 'textBox7timer' then
		dialogueFunc("...Don't make me do this.", 'whitty')
	end
	if tag == 'skippingTimer' then
		if skippingHold < 1 then
			skippingHold = skippingHold + (1/8);
			setProperty('skip.alpha', skippingHold);
			playAnim('skip', 'hold'..skippingHold);
			runTimer('skippingTimer', (1/8));
		elseif skippingHold == 1 then
			cancelTimer('micBreak', 1.9);
			cancelTimer('micThrow', 3.7);
			cancelTimer('micCrack', 4.6);
			cancelTimer('StartupTimer', 0.5);
			cancelTimer('ouchMyToe', 6.5);
			cancelTimer('stopCutscene', 9.7);
			cancelTimer('stopCutscene');
			cancelTimer('textBox1timer');
			cancelTimer('textBox2timer');
			cancelTimer('textBox3timer');
			cancelTimer('textBox4timer');
			cancelTimer('textBox5timer');
			cancelTimer('textBox6timer');
			cancelTimer('textBox7timer');
			cancelTimer('textBox8timer');
			cancelTimer('letter');
			setProperty('blackCutscene.alpha', 1);
			removeLuaSprite('boyfriendCutscene');
			removeLuaSprite('whittyCutscene');
			removeLuaSprite('skip');
			doTweenAlpha('blackCutsceneAlphaSkip', 'blackCutscene', 0, 0.5, 'leaner');
			setProperty('boyfriend.visible', true);
			setProperty('dad.visible', true);
			setProperty('gf.visible', true);
			stopSound('micBreak');
			stopSound('micThrow');
			stopSound('micCrack');
			stopSound('souljaboyCrank');
			playAnim('whittyback', 'Moving');
			setProperty('dad.x', defaultDADx)
			setProperty('dad.y', defaultDADy)
		end
	end
end

function onUpdate()
	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ESCAPE') or ((mobileChoice == 1 or buildTarget == 'android') and getPropertyFromClass('flixel.FlxG', 'android.justPressed.BACK')) and canSkipDialogue or getPropertyFromClass('flixel.FlxG', 'keys.justPressed.BACKSPACE') and canSkipDialogue then
			dialoguePosition = 8
			canEnter = false
			letter = 0
			runTimer('endDialogue', 0.05);
			cancelTimer('textBox1timer');
			cancelTimer('textBox2timer');
			cancelTimer('textBox3timer');
			cancelTimer('textBox4timer');
			cancelTimer('textBox5timer');
			cancelTimer('textBox6timer');
			cancelTimer('textBox7timer');
			cancelTimer('textBox8timer');
			cancelTimer('letter');
			setProperty('whittyPort.visible', false);
			setProperty('boyfriendPort.visible', false);
			setTextString('textLine', '')
			setTextString('textLineBack', '')
			playSound('clickText')
			doTweenAlpha('whiteBGAlpha', 'whiteBG', 0, 1, 'leaner');
			doTweenAlpha('speech_bubbleAlpha', 'speech_bubble', 0, 1, 'leaner');
			soundFadeOut('city', 1, 0)
			removeLuaText('skipText')
			removeLuaText('textLineBack')
			removeLuaText('textLine')
	end
	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ENTER') or ((mobileChoice == 1 or buildTarget == 'android') and mouseClicked("left")) and canX or getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') and canX then
		if dialoguePosition == 0 then
			cancelTimer('textBox1timer')
			letter = 0
			canX = false
			setTextString('textLine', 'I see how it is.')
			setTextString('textLineBack', 'I see how it is.')
			cancelTimer('letter');
			playSound('whitty')
			canEnter = true
		end
		if dialoguePosition == 1 then
			cancelTimer('textBox2timer')
			letter = 0
			canX = false
			setTextString('textLine', 'brep bappity boop')
			setTextString('textLineBack', 'brep bappity boop')
			cancelTimer('letter');
			playSound('pixelText')
			canEnter = true
		end
		if dialoguePosition == 2 then
			cancelTimer('textBox3timer')
			letter = 0
			canX = false
			setTextString('textLine', "You're really pushing my limits, dude.")
			setTextString('textLineBack', "You're really pushing my limits, dude.")
			cancelTimer('letter');
			playSound('whitty')
			canEnter = true
		end
		if dialoguePosition == 3 then
			cancelTimer('textBox4timer')
			letter = 0
			canX = false
			setTextString('textLine', 'bip bep skoo de boop')
			setTextString('textLineBack', 'bip bep skoo de boop')
			cancelTimer('letter');
			playSound('pixelText')
			canEnter = true
		end
		if dialoguePosition == 4 then
			cancelTimer('textBox5timer')
			letter = 0
			canX = false
			setTextString('textLine', "Well how about you go die in a ditch instead.")
			setTextString('textLineBack', "Well how about you go die in a ditch instead.")
			cancelTimer('letter');
			playSound('whitty')
			canEnter = true
		end
		if dialoguePosition == 5 then
			cancelTimer('textBox6timer')
			letter = 0
			canX = false
			setTextString('textLine', 'bepoobee skoop')
			setTextString('textLineBack', 'bepoobee skoop')
			cancelTimer('letter');
			playSound('pixelText')
			canEnter = true
		end
		if dialoguePosition == 6 then
			cancelTimer('textBox7timer')
			letter = 0
			canX = false
			setTextString('textLine', "...Don't make me do this.")
			setTextString('textLineBack', "...Don't make me do this.")
			cancelTimer('letter');
			playSound('whitty')
			canEnter = true
		end
	end
	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ENTER') or ((mobileChoice == 1 or buildTarget == 'android') and mouseClicked("left")) and canEnter or getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') and canX then
		if dialoguePosition == 0 then
			dialoguePosition = 1
			canEnter = false
			canX = false
			letter = 0
			runTimer('textBox2timer', 0.05);
			setProperty('whittyPort.visible', false);
			setProperty('boyfriendPort.visible', true);
			setTextString('textLine', '')
			setTextString('textLineBack', '')
			playSound('clickText')
		elseif  dialoguePosition == 1 then
			dialoguePosition = 2
			canEnter = false
			canX = false
			letter = 0
			runTimer('textBox3timer', 0.05);
			setProperty('whittyPort.visible', true);
			setProperty('boyfriendPort.visible', false);
			setTextString('textLine', '')
			setTextString('textLineBack', '')
			playSound('clickText')
		elseif  dialoguePosition == 2 then
			dialoguePosition = 3
			canEnter = false
			canX = false
			letter = 0
			runTimer('textBox4timer', 0.05);
			setProperty('whittyPort.visible', false);
			setProperty('boyfriendPort.visible', true);
			setTextString('textLine', '')
			setTextString('textLineBack', '')
			playSound('clickText')
		elseif  dialoguePosition == 3 then
			dialoguePosition = 4
			canEnter = false
			canX = false
			letter = 0
			runTimer('textBox5timer', 0.05);
			setProperty('whittyPort.visible', true);
			setProperty('boyfriendPort.visible', false);
			setTextString('textLine', '')
			setTextString('textLineBack', '')
			playSound('clickText')
		elseif  dialoguePosition == 4 then
			dialoguePosition = 5
			canEnter = false
			canX = false
			letter = 0
			runTimer('textBox6timer', 0.05);
			setProperty('whittyPort.visible', false);
			setProperty('boyfriendPort.visible', true);
			setTextString('textLine', '')
			setTextString('textLineBack', '')
			playSound('clickText')
		elseif  dialoguePosition == 5 then
			dialoguePosition = 6
			canEnter = false
			canX = false
			letter = 0
			runTimer('textBox7timer', 0.05);
			setProperty('whittyPort.visible', true);
			setProperty('boyfriendPort.visible', false);
			setTextString('textLine', '')
			setTextString('textLineBack', '')
			playSound('clickText')
		elseif  dialoguePosition == 6 then
			dialoguePosition = 7
			canEnter = false
			letter = 0
			runTimer('endDialogue', 0.05);
			setProperty('whittyPort.visible', false);
			setProperty('boyfriendPort.visible', false);
			setTextString('textLine', '')
			setTextString('textLineBack', '')
			playSound('clickText')
			doTweenAlpha('whiteBGAlpha', 'whiteBG', 0, 1, 'leaner');
			doTweenAlpha('speech_bubbleAlpha', 'speech_bubble', 0, 1, 'leaner');
			soundFadeOut('city', 1, 0)
			removeLuaText('skipText')
		end
	end
end

function onTweenCompleted(tag)
	if tag == 'speech_bubbleAlpha' then
		playCutscene = false
		canSkipDialogue = false
		startCountdown()
		setProperty('healthBar.visible', true);
		setProperty('iconP1.visible', true);
		setProperty('iconP2.visible', true);
		setProperty('scoreTxt.visible', true);
		removeLuaSprite('whiteBG');
		removeLuaSprite('whittyPort');
		removeLuaSprite('boyfriendPort');
		removeLuaSprite('speech_bubble');
		removeLuaText('textLineBack')
		removeLuaText('textLine')
	end
end