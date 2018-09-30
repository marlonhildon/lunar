# Lunar

A **Lua** library for **AABB** collisions resolutions (alpha version).

## Example (using LÖVE)

```lua
local lunar = require 'lunar'

function love.load()
	player = lunar.hitbox:new(0, 0, 32, 64)	--x, y, width, height
	tile = lunar.tile:new(150, 150, 32)	--x, y, tile size
	speed = 0
end

function love.update(dt)
	speed = 150 * dt
	if love.keyboard.isDown("up") 	 then player.y = player.y - speed end
	if love.keyboard.isDown("down")  then player.y = player.y + speed end
	if love.keyboard.isDown("left")  then player.x = player.x - speed end
	if love.keyboard.isDown("right") then player.x = player.x + speed end
    --Solving all collisions between 'player' and 'tile'
	player:solveCollision(tile)
end

function love.draw()
	love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)
	love.graphics.rectangle('line', tile.x, tile.y, tile.s, tile.s)
end
```

## Classes

### Hitbox
* **`lunar.hitbox:new(x, y, width, height)`**

**Arguments**
* `x: number`
* `y: number`
* `width: number`
* `height: number`

**Returns**
* `hitbox: instance`

**Instance attributes**
* `hitbox.x: number`
* `hitbox.y: number`
* `hitbox.width: number`
* `hitbox.height: number`

Instantiates a **hitbox**. Use it for bodies who need **collision resolution**.

**Example (using LÖVE):**
```lua
local lunar = require 'lunar'

function love.load()
	player = lunar.hitbox:new(0, 12, 32, 64)	--x, y, width, height
end

function love.draw()
	love.graphics.print("Player x: "..player.x.."\nPlayer y: "..player.y)
	love.graphics.print("\n\nPlayer width: "..player.w.."\nPlayer height: "..player.h)
end
```

#### Methods
* **`hitbox:solveCollisions(tile)`**

**Arguments**
* `tile: instance`

**Returns**
* `collisions: table`

**Collisions entries:**
* `collisions.top: boolean`
* `collisions.bottom: boolean`
* `collisions.left: boolean`
* `collisions.right boolean`
* `collisions.topLeft: boolean`
* `collisions.topRight: boolean`
* `collisions.bottomLeft: boolean`
* `collisions.bottomRight: boolean`

**Solves all collisions** between ``hitbox`` and ``tile``.

A collision entry will be ``true`` when a **collision** between ``hitbox`` and ``tile`` occur. When it **resolutes**, it will be ``false``.

>**Note:** **top-left** and **top-right** collisions are treated like **top collisions** by default. **Bottom-left** and **bottom-right** collisions are processed like **bottom collisions**.

###Tile
* **`lunar.tile:new(x, y, size)`**

**Arguments:**
* `x: number`
* `y: number`
* `size: number`

**Returns:**
* `tile: instance`

**Instance attributes:**
* `tile.x: number`
* `tile.y: number`
* `tile.s: number`

Instantiates a **tile**. Use it for scenario things and as argument in `hitbox:solveCollision(tile)`.

**Example (using LÖVE):**
```lua
local lunar = require 'lunar'

function love.load()
	player = lunar.hitbox:new(0, 0, 32, 64)	--x, y, width, height
	tile = lunar.tile:new(150, 150, 32)	--x, y, tile size
	speed = 0
	collision = {}
end

function love.update(dt)
	speed = 150 * dt
	if love.keyboard.isDown("up") 	 then player.y = player.y - speed end
	if love.keyboard.isDown("down")  then player.y = player.y + speed end
	if love.keyboard.isDown("left")  then player.x = player.x - speed end
	if love.keyboard.isDown("right") then player.x = player.x + speed end
    --Solving all collisions between 'player' and 'tile', and checking the collision entries
	collision = player:solveCollision(tile)
end

function love.draw()
	love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)
	love.graphics.rectangle('line', tile.x, tile.y, tile.s, tile.s)
	-- When a collision occur, a entry below will be true
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