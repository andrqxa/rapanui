module(..., package.seeall)

----------------------------------------------------------------
-- RapaNui Framework
--
-- https://github.com/eljeko/rapanui/
--
----------------------------------------------------------------

function RNInputManager:new(o)

    o = o or {
        name = "RNInputManager",
        listeners = {},
        size = 0;
    }

    setmetatable(o, self)
    self.__index = self

    return o
end

innerInputManager = RNInputManager:new()


function init()
    MOAIInputMgr.device.touch:setCallback(onEvent)
end

function addListener(listener)
    innerInputManager:addListenerToList(listener)
end

function RNInputManager:addListenerToList(listener)
    self.listeners[self.size] = listener
    self.size = self.size + 1
end

function RNInputManager:getListeners()
    return self.listeners
end

-- types of touches:

-- TOUCH_DOWN
-- TOUCH_MOVE
-- TOUCH_UP
-- TOUCH_CANCEL

function onEvent(eventType, idx, x, y, tapCount)
    for key, value in pairs(innerInputManager:getListeners())
    do

        if (eventType == MOAITouchSensor.TOUCH_DOWN) then
            value:onTouchDown(x, y, value)
        end

        if (eventType == MOAITouchSensor.TOUCH_MOVE) then
            value:onTouchMove(x, y, value)
        end

        if (eventType == MOAITouchSensor.TOUCH_UP) then
            value:onTouchUp(x, y, value)
        end

        if (eventType == MOAITouchSensor.TOUCH_CANCEL) then
            value:onTouchCancel(x, y, value)
        end
    end
end

RNInputManager.init()