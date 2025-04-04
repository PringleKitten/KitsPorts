function onUpdate()
    if getProperty('health') < 0.4 then
        callMethod('iconP2.changeIcon', { 'bossguy' }) -- Change to the winning icon
    else
        callMethod('iconP2.changeIcon', { 'dad' }) -- Change back to the normal icon
    end
    if getProperty('health') > 1.6 then
        callMethod('iconP1.changeIcon', { 'bossguy' }) -- Change to the winning icon
    else
        callMethod('iconP1.changeIcon', { 'bf' }) -- Change back to the normal icon
    end
end