import 'processQueue'

local function customOperation(item)
    print("Processing item:", item)
    
    -- For demonstration purposes only - this delays for 1ms to demonstrate testQueue:processUntil(timeLimit)
    local wait = 1
    local t = playdate.getCurrentTimeMilliseconds()
    while playdate.getCurrentTimeMilliseconds() < (t + wait) do
        -- do absolutely nothing
    end
end

local testQueue = processQueue:new(customOperation)

-- Add items to the queue
for i = 1, 50 do
    testQueue:push(i)
end

function playdate.update()

    -- Process 2 items
    testQueue:processNumber(5)
    
    -- Process additional items for 2 milliseconds
    testQueue:processUntil(5)
    
    -- Check remaining items
    print("Items left in queue:", testQueue:count())

end