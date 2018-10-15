# Lunar

A **Lua** library for **AABB** collisions resolutions (alpha version).

## Example (using LÖVE)

```lua
local lunar = require 'lunar'

function love.load()
	player = lunar.hitbox:new(0, 0, 32, 64) --x, y, width, height
	tile = lunar.tile:new(150, 150, 32)     --x, y, tile size
	speed = 0
end

function love.update(dt)
	speed = 150 * dt
	if love.keyboard.isDown("up")	then player.y = player.y - speed end
	if love.keyboard.isDown("down")	then player.y = player.y + speed end
	if love.keyboard.isDown("left")	then player.x = player.x - speed end
	if love.keyboard.isDown("right")then player.x = player.x + speed end
	player:solveCollision(tile) --Solving all collisions between 'player' and 'tile'
end

function love.draw()
	love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)
	love.graphics.rectangle('line', tile.x, tile.y, tile.s, tile.s)
end
```
## Installing
Just download and `require` the `lunar.lua` script:
```lua
local lunar = require 'lunar'
```

## How to use

### 1. Create a hitbox
**`lunar.hitbox:new(x, y, width, height)`**

`x: number`<br/>
`y: number`<br/>
`width: number`<br/>
`height: number`<br/>

**Returns**<br/>
`hitbox: instance`

**Instance attributes**<br/>
`hitbox.x: number`<br/>
`hitbox.y: number`<br/>
`hitbox.width: number`<br/>
`hitbox.height: number`

>**Note**: Use it only for bodies who need **collision resolution**.

**Example (using LÖVE):**
```lua
local lunar = require 'lunar'

function love.load()
	player = lunar.hitbox:new(0, 12, 32, 64) --x, y, width, height
end
```

### 2. Create a Tile
**`lunar.tile:new(x, y, size)`**

`x: number`<br/>
`y: number`<br/>
`size: number`<br/>

**Returns:**<br/>
`tile: instance`

**Instance attributes:**<br/>
`tile.x: number`<br/>
`tile.y: number`<br/>
`tile.s: number`

>**Note**: Use it for scenario and other things.

**Example (using LÖVE):**
```lua
local lunar = require 'lunar'

function love.load()
	player = lunar.hitbox:new(0, 0, 32, 64)
	tile = lunar.tile:new(150, 150, 32) --x, y, tile size
end
```

### 3. Solve collisions
**`hitbox:solveCollisions(tile)`**

`tile: instance`

**Returns**<br/>
`collisions: table`

**Table entries:**<br/>
`collisions.top: boolean`<br/>
`collisions.bottom: boolean`<br/>
`collisions.left: boolean`<br/>
`collisions.right boolean`<br/>
`collisions.topLeft: boolean`<br/>
`collisions.topRight: boolean`<br/>
`collisions.bottomLeft: boolean`<br/>
`collisions.bottomRight: boolean`

A collision entry will be ``true`` when a **collision** between ``hitbox`` and ``tile`` is detected. When it **resolutes**, it will be ``false``.

>**Note:** **top-left** and **top-right** collisions are treated like **top collisions** by default. **Bottom-left** and **bottom-right** collisions are processed like **bottom collisions**.

**Example (using LÖVE):**
```lua
local lunar = require 'lunar'

function love.load()
	player = lunar.hitbox:new(0, 0, 32, 64)
	tile = lunar.tile:new(150, 150, 32)
	speed = 0
	collision = {}
end

function love.update(dt)
	speed = 150 * dt
	if love.keyboard.isDown("up")    then player.y = player.y - speed end
	if love.keyboard.isDown("down")  then player.y = player.y + speed end
	if love.keyboard.isDown("left")  then player.x = player.x - speed end
	if love.keyboard.isDown("right") then player.x = player.x + speed end
	--Solving all collisions between 'player' and 'tile', and checking the collision entries
	collision = player:solveCollision(tile)
end

function love.draw()
	love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)
	love.graphics.rectangle('line', tile.x, tile.y, tile.s, tile.s)
	-- When a collision occur, an entry below will be true
	love.graphics.print("Top collision: "..tostring(collision.top), 0, 0)
	love.graphics.print("Bottom collision: "..tostring(collision.bottom), 0, 20)
	love.graphics.print("Left collision: "..tostring(collision.left), 0, 40)
	love.graphics.print("Right collision: "..tostring(collision.right), 0, 60)
	love.graphics.print("Top left collision: "..tostring(collision.topLeft), 0, 80)
	love.graphics.print("Top right collision: "..tostring(collision.topRight), 0, 100)
	love.graphics.print("Bottom left collision: "..tostring(collision.bottomLeft), 0, 120)
	love.graphics.print("Bottom right collision: "..tostring(collision.bottomRight), 0, 140)
end
```

## How it works
Coming soon.