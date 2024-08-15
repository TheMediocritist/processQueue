# `pdqueue` Documentation

The `processQueue` module provides a simple and efficient queue implementation for managing and processing items in a First-In-First-Out (FIFO) manner. This module is designed for use with Playdate but can be adapted for other Lua environments.

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

### `queue:push(item)`

**Description**:  
Adds an item to the end of the queue.

**Parameters**:
- `item (any)`: The item to be added to the queue.

**Returns**:  
None.

**Example**:
```lua
myQueue:push(42)
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

### `queue:processNumber(n)`

**Description**:  
Processes up to `n` items in the queue by applying the custom operation to each item.

**Parameters**:
- `n (number)`: The maximum number of items to process.

**Returns**:  
None.

**Example**:
```lua
myQueue:processNumber(3)
```

### `queue:processUntil(timeLimit)`

**Description**:  
Processes items in the queue until a specified time limit is reached. The time limit is measured in milliseconds.

**Parameters**:
- `timeLimit (number)`: The maximum time (in milliseconds) to process items.

**Returns**:  
None.

**Example**:
```lua
myQueue:processUntil(5000)  -- Process for up to 5 seconds
```

---

## **Usage Example**

```lua
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
    
    -- Process additional items for 5 milliseconds
    testQueue:processUntil(5)
    
    -- Check remaining items
    print("Items left in queue:", testQueue:count())

end
```
