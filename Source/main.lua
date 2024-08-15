import "Corelibs/object"
import 'processQueue'

-- Define the function to be performed on queue items
local function customOperation(item)
    print("Processing item:", item)
    
    -- For demonstration purposes only, delay for 1ms to demonstrate testQueue:processUntil(timeLimit)
    local wait = 1
    local t = playdate.getCurrentTimeMilliseconds()
    while playdate.getCurrentTimeMilliseconds() < (t + wait) do
        -- do absolutely nothing
    end
end

-- Create the queue
local myQueue = processQueue:new(customOperation)

-- Add 25 items to the queue (individually)
for i = 1, 25 do
    myQueue:push(i)
end

-- Add another 25 items to the queue (as a list)
local myList = {}
for i = 51, 75 do
    myList[#myList+1] = i
end
myQueue:push(myList)

function playdate.update()
    
    -- Add a new item to the queue if it doesn't already exist
    if myQueue:contains('rabbit') then
        print('We do not need another rabbit!')
    else
        print('Adding rabbit to the queue')
        myQueue:push('rabbit')
    end
    
    -- Process 5 items
    myQueue:processItems(5)
    
    -- Process additional items for 5 milliseconds
    myQueue:processUntil(5)
    
    -- Check how many items remain in the queue
    print("Items left in queue:", myQueue:count())

end