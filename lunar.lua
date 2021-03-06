--
-- Update: Corners collisions implemented
--

local function checkAABB(hitbox, tile)
	return hitbox.x < tile.x + tile.s and
		   hitbox.y < tile.y + tile.s and
		   tile.x < hitbox.x + hitbox.w and
		   tile.y < hitbox.y + hitbox.h
end

-- Finds the bottom-left and top-right coordinates of the overlap rectangle between the hitbox and the tile,
-- and returning the square pixels of it

local max, min = math.max, math.min
local function findOverlap (hitbox, tile)
	local bottom = min(hitbox.y+hitbox.h, tile.y+tile.s)
	local left 	 = max(hitbox.x, tile.x)
	local top 	 = max(hitbox.y, tile.y)
	local right  = min(hitbox.x+hitbox.w, tile.x+tile.s)
	local squarePixels = 0
	
	if left < right and top < bottom then
		-- Overlaps
		squarePixels = (right-left)*(bottom-top)
		return squarePixels
	else
		-- Doesn't overlaps
		return 0
	end
end

-- Invisible hitboxes are instantiated at each side of player's hitbox

local function createGhostHitboxes(player)
	local ghostHitbox = {
		top 	= {x = player.x, y = player.y-player.h, w = player.w, h = player.h},
		bottom 	= {x = player.x, y = player.y+player.h, w = player.w, h = player.h},
		left 	= {x = player.x-player.w, y = player.y, w = player.w, h = player.h},
		right 	= {x = player.x+player.w, y = player.y, w = player.w, h = player.h}
	}
	return ghostHitbox
end

--

local function solveTopCollision(tileY, tileS)
	local solvedY = tileY + tileS
	return solvedY
end

local function solveBottomCollision(tileY, playerH)
	local solvedY = tileY - playerH
	return solvedY
end

local function solveLeftCollision(tileX, tileS)
	local solvedX = tileX + tileS
	return solvedX
end

local function solveRightCollision(tileX, playerW)
	local solvedX = tileX - playerW
	return solvedX
end

-- All collisions are detected here

local function solveCollision(player, tile)
	local solvedX, solvedY = player.x, player.y
	local is_colliding = checkAABB(player, tile)
	local collision = {
		top=false, bottom=false, left=false, right=false,
		topLeft=false, topRight=false, bottomLeft=false, bottomRight=false
	}
	
	if is_colliding then
		local ghostHitbox = createGhostHitboxes(player)
		local topOverlap 	= findOverlap(ghostHitbox.top, tile)
		local bottomOverlap = findOverlap(ghostHitbox.bottom, tile)
		local leftOverlap 	= findOverlap(ghostHitbox.left, tile)
		local rightOverlap 	= findOverlap(ghostHitbox.right, tile)
		
		if topOverlap > leftOverlap and topOverlap > rightOverlap then
			collision.top = true
			solvedY = solveTopCollision(tile.y, tile.s)
		end
		
		if bottomOverlap > leftOverlap and bottomOverlap > rightOverlap then
			collision.bottom = true
			solvedY = solveBottomCollision(tile.y, player.h)
		end
		
		if leftOverlap > topOverlap and leftOverlap > bottomOverlap then
			collision.left = true
			solvedX = solveLeftCollision(tile.x, tile.s)
		end
		
		if rightOverlap > topOverlap and rightOverlap > bottomOverlap then
			collision.right = true
			solvedX = solveRightCollision(tile.x, player.w)
		end
		
		if topOverlap == leftOverlap and topOverlap ~= 0 and leftOverlap ~= 0  then
			-- Top-left corner collision: resolves like a top collision
			collision.topLeft = true
			solvedY = solveTopCollision(tile.y, tile.s)
		end
		
		if topOverlap == rightOverlap and topOverlap ~= 0 and rightOverlap ~= 0 then
			-- Top-right corner collision: resolves like a top collision
			collision.topRight = true
			solvedY = solveTopCollision(tile.y, tile.s)
		end
		
		if bottomOverlap == leftOverlap and bottomOverlap ~= 0 and leftOverlap ~= 0 then
			-- Bottom-left corner collision: resolves like a bottom collision
			collision.bottomLeft = true
			solvedY = solveBottomCollision(tile.y, player.h)
		end
		
		if bottomOverlap == rightOverlap and bottomOverlap ~= 0 and rightOverlap ~= 0 then
			-- Bottom-right corner collision: resolves like a bottom collision
			collision.bottomRight = true
			solvedY = solveBottomCollision(tile.y, player.h)
		end
	end
	
	return solvedX, solvedY, collision
end

-- 'Tile' class

local Tile = {}
function Tile:new(x, y, s)
	local object = {
		x = x,
		y = y,
		s = s
	}
	setmetatable(object, {__index = Tile})
	return object
end

-- 'Player Hitbox' class

local PlayerHitbox = {}
function PlayerHitbox:new(x, y, w, h)
	local object = {
		x = x,
		y = y,
		w = w,
		h = h
	}
	setmetatable(object, {__index = PlayerHitbox})
	return object
end

function PlayerHitbox:solveCollision(tile)
	local collision = {}
	self.x, self.y, collision = solveCollision(self, tile)
	return collision
end

return {hitbox = PlayerHitbox, tile = Tile}