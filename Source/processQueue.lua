-- processQueue.lua

-- Provides a simple and efficient queue implementation for managing and 
-- processing items on a First-In-First-Out basis.
-- Optionally, limit the operations by a number or processing time.

local function setOperation(self, customOperation)
    self.customOperation = customOperation
end

local function push(self, x)
    self[self.last] = x
    self.last += 1
end

local function pop(self)
    if self:empty() then return end
    local item = self[self.first]
    self[self.first] = nil
    self.first += 1
    return item
end

local function count(self)
    return self.last - self.first
end

local function empty(self)
    return self:count() == 0
end

local function contents(self)
    local contents = {}
    for i = self.first, self.last-1 do
        contents[i-self.first+1] = self[i]
    end
    return contents
end

local function processAll(self)
    while not self:empty() do
        local item = self:pop()
        self.customOperation(item)
    end
end

local function processNumber(self, n)  
    while not self:empty() and n > 0 do
        local item = self:pop()
        self.customOperation(item)
        n -= 1
    end
end

local function processUntil(self, timeLimit)
    local endTime = playdate.getCurrentTimeMilliseconds() + timeLimit
    while not self:empty() and playdate.getCurrentTimeMilliseconds() < endTime do
        local item = self:pop()
        self.customOperation(item)
    end
end

local function contains(self, item)
    for i = self.first, self.last do
        if self[i] == item then
            return true
        end
    end
    return false
end

local methods = {
    setOperation = setOperation,
    push = push,
    pop = pop,
    count = count,
    empty = empty,
    contains = contains,
    contents = contents,
    processAll = processAll,
    processNumber = processNumber,
    processUntil = processUntil
}


processQueue = {}

function processQueue:new(customOperation)
    local queue = {}
    queue.first = 1
    queue.last = 1
    queue.customOperation = customOperation or function() return end
    return setmetatable(queue, {__index = methods})
end
