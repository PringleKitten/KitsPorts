function onCreate()
    setPropertyFromClass('backend.ClientPrefs', 'data.guitarHeroSustains', false)
    if difficultyName == "Hardcore" then
        setPropertyFromClass('backend.ClientPrefs', 'data.middleScroll', true)
        setPropertyFromClass('backend.ClientPrefs', 'data.opponentStrums', false)
    elseif difficultyName == "Hard" then
        setPropertyFromClass('backend.ClientPrefs', 'data.middleScroll', false)
        setPropertyFromClass('backend.ClientPrefs', 'data.opponentStrums', true)
    end
end

function onDestroy()
    setPropertyFromClass('backend.ClientPrefs', 'data.middleScroll', false)
    setPropertyFromClass('backend.ClientPrefs', 'data.opponentStrums', true)
end
function opponentNoteHit(noteData, noteType, isSustainNote)
    if misses > 0 then
        if getProperty("health") > 0.02 then
            setProperty('health', getProperty("health")-0.02)
        end
    end
end
function noteMiss(noteData, noteType, isSustainNote)
    if difficultyName == "Hardcore" then
        --os.exit()
    end
end
function onUpdate()
    if keyboardJustPressed("SPACE") then
        playAnim("boyfriend", "dodge", false)
        setProperty("boyfriend.specialAnim", true)
    end
end
function onSongStart()
    triggerEvent("Screen Shake", "9999, 0.002", "9999, 0.002")
end