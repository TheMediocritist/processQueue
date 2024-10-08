# `processQueue` Documentation

The `processQueue` module provides a simple and efficient queue implementation for managing and processing items on a First-In-First-Out basis. This module is designed for use with Playdate but can be adapted for other Lua environments.

Items are processed from oldest to newest. Inefficient table operations are avoided (except iteration for :exists...).

## **Example Implementation**

```lua
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
```

## **Creating a Queue**

### `processQueue:new(customOperation)`

**Description**:  
Creates a new queue instance.

**Parameters**:
- `customOperation (function, optional)`: A function that defines a custom operation to be applied to each item in the queue when processed. If not provided, a no-op function is used.

**Returns**:  
A new queue instance with the specified custom operation.

**Example**:
```lua
local function customOperation(item)
    print("Processing item:", item)
end

local myQueue = processQueue:new(customOperation)
```

## **Queue Methods**

### `queue:setOperation(customOperation)`

**Description**:  
Sets or updates the custom operation to be applied to each item during processing.

**Parameters**:
- `customOperation (function)`: The new operation function to be used.

**Returns**:  
None.

**Example**:
```lua
local function customOperation(item)
    print("Processing item:", item)
end

myQueue:setOperation(customOperation)
```

### `queue:push(item or table)`

**Description**:  
Adds an item or table of items to the end of the queue.

**Parameters**:
- `item (any)`: The item to be added to the queue.
- Or `table`: The table of items (any) to be added to the queue.

**Returns**:  
None.

**Examples**:
```lua
myQueue:push(42)
myQueue:push({42, 60, 12})
```

### `queue:pop()`

**Description**:  
Removes and returns the item at the front of the queue. If the queue is empty, returns `nil`.

**Parameters**:  
None.

**Returns**:  
The item at the front of the queue, or `nil` if the queue is empty.

**Example**:
```lua
local item = myQueue:pop()
```

### `queue:count()`

**Description**:  
Returns the number of items currently in the queue.

**Parameters**:  
None.

**Returns**:  
`number`: The number of items in the queue.

**Example**:
```lua
local count = myQueue:count()
```

### `queue:empty()`

**Description**:  
Checks if the queue is empty.

**Parameters**:  
None.

**Returns**:  
`boolean`: `true` if the queue is empty, `false` otherwise.

**Example**:
```lua
if myQueue:empty() then
    print("Queue is empty")
end
```

### `queue:contains(item)`

**Description**:  
Checks if the queue contains the item

**Parameters**:  
- `item (any)`: The item to search for in the queue.

**Returns**:  
`boolean`: `true` if the item exists in the queue, `false` otherwise.

**Example**:
```lua
if myQueue:contains('rabbit') then
    print('We do not need another rabbit!')
else
    myQueue:push('rabbit')
end
```

### `queue:contents()`

**Description**:  
Returns a table containing all items in the queue, in order.

**Parameters**:  
None.

**Returns**:  
`table`: A table of all items in the queue.

**Example**:
```lua
local items = myQueue:contents()
for _, item in ipairs(items) do
    print(item)
end
```

### `queue:processAll()`

**Description**:  
Processes all items in the queue by applying the custom operation to each item.

**Parameters**:  
None.

**Returns**:  
None.

**Example**:
```lua
myQueue:processAll()
```

### `queue:processItems(n)`

**Description**:  
Processes up to `n` items in the queue from oldest to newest by applying the custom operation to each item.

**Parameters**:
- `n (number)`: The maximum number of items to process.

**Returns**:  
None.

**Example**:
```lua
myQueue:processItems(3)  -- Process up to 3 items
```

### `queue:processUntil(timeLimit)`

**Description**:  
Processes items in the queue from oldest to newest until a specified time limit is reached. The time limit is measured in milliseconds.

**Parameters**:
- `timeLimit (number)`: The maximum time (in milliseconds) to process items.

**Returns**:  
None.

**Example**:
```lua
myQueue:processUntil(5)  -- Process for up to 5 milliseconds
```

---
