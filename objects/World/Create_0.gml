
map = ds_grid_create(16, 48);

for (var i=0; i<ds_grid_width(map); i++) {
	for (var j=0; j<ds_grid_height(map); j++) {
		var slot = new WorldSlot();
		var count = get_perlin_noise_2D(i, j, 10, true, 8);
		count = clamp(count, 1, 100);
		
		for (var height=0; height<count; height++) {
			var blockID = BLOCK_ID.Stone;
			
			if (height == count - 1) {
				blockID = BLOCK_ID.Grass;
			}
			
			slot.set( height, new SlotBlock(blockID, height) );
		}
		ds_grid_set(map, i, j, slot);
	}
}

surface = surface_create(room_width, room_height);
skyColor = Style.background;

displayMode = 0;

update = function() {
	
	show_debug_message("Redrawing world");
	
	surface_set_target(surface);
	draw_clear(skyColor);
	
	for (var i=0; i<ds_grid_height(map); i++) {
		for (var j=0; j<ds_grid_width(map); j++) {
			var offsetX = 0;
			if (i % 2 == true) offsetX = sprite_get_width(sBlock_Default) / 2;
			
			var xx = j * sprite_get_width(sBlock_Default) + offsetX;
			var yy = i * 8;
			
			var gridx = j * sprite_get_width(sBlock_Default);
			var gridy = i * sprite_get_height(sBlock_Default);
			
			var stack = ds_grid_get(map, j, i);
			var color = c_white;
			
			// How many blocks are on the stack slot
			var blockCount = array_length(stack.blockList);
			
			// Draw every block on y axis
			for (var block=0; block<blockCount; block++) {
				
				var b = stack.blockList[block];	// block
				var blockID = b.blockID;
				color = b.color;
				var blockHeight = -b.y * (sprite_get_height(sBlock_Default) / 2);
				
				var blockx;
				var blocky;
				
				switch (displayMode) {
					case 0:
						blockx = xx;
						blocky = yy;
						break;
						
					case 1:
						blockx = gridx;
						blocky = gridy;
						break;
				}
				
				var isBlocked = false;
				
				
				// Check if block is blocked
				//var neighbor = ds_grid_get(map, j, i + 1);		// stack below
				//if (neighbor != undefined) {
				//	var neighborBlockCount = array_length(neighbor.blockList);
					
				//	// Check if there is a block on the same level as the current stack and the neighboring stack
				//	for (var nb = 0; nb < neighborBlockCount; nb++) {
				//		var nby = neighbor.blockList[nb].y;
				//		if (
							
				//			b.y < nby && 
				//			i < ds_grid_height(map)-2 && 
				//			j > 1 && 
				//			j < ds_grid_width(map) &&
				//			nby != neighborBlockCount-1
							
				//			) {
				//			isBlocked = true;
				//		}
						
				//		if (isBlocked) break;
				//	}
				//}
				
				if (!isBlocked) {
					draw_sprite_ext(
						BLOCK.Get(blockID).sprite, 0, blockx + 200, (blocky + blockHeight) + 200,
						1, 1, 0, color, 1
					);
				}
			}
		}
	}
	
	surface_reset_target();
	
}

update();

draw = function() {
	draw_surface(surface, 0, 0);
}

setBlock = function(x, y, z, blockID) {
	var stack = ds_grid_get(map, x, z);
	if (stack == undefined) return;
	
	stack.set(y, new SlotBlock(blockID, y), true);
	
	array_sort(stack.blockList, function(a, b){return a.y - b.y});

	update();
}



//drawBlocks = function() {
//	var cam_x = camera_get_view_x(view_camera[0]);
//	var cam_y = camera_get_view_y(view_camera[0]);
//	var cam_w = camera_get_view_width(view_camera[0]);
//	var cam_h = camera_get_view_height(view_camera[0]);

//	for (var i = 0; i < 10; i++) {
//		for (var j = 0; j < 10; j++) {
//			var offsetX = (i % 2 == 1) ? sprite_get_width(sBlock_Default) / 2 : 0;
//			var xx = j * sprite_get_width(sBlock_Default) + offsetX;
//			var yy = i * 8;

//			var stack = ds_grid_get(map, j, i);
//			var blocks = stack.blockList;

//			for (var b = 0; b < array_length(blocks); b++) {
//				var block = blocks[b];
//				var block_z = block.y; // height
//				var isBlocked = false;

//				// Check neighbors: (i+1, j) and (i, j+1)
//				var neighbor_stacks = [
//					[i + 1, j],
//					[i, j + 1]
//				];

//				for (var n = 0; n < array_length(neighbor_stacks); n++) {
//					var ni = neighbor_stacks[n][0];
//					var nj = neighbor_stacks[n][1];

//					if (ni >= 0 && ni < 10 && nj >= 0 && nj < 10) {
//						var neighbor = ds_grid_get(map, nj, ni);
//						if (neighbor != undefined) {
//							var neighborBlocks = neighbor.blockList;
//							for (var nb = 0; nb < array_length(neighborBlocks); nb++) {
//								if (neighborBlocks[nb].y >= block_z) {
//									isBlocked = true;
//									break;
//								}
//							}
//						}
//					}

//					if (isBlocked) break;
//				}

//				if (isBlocked) continue;

//				// Culling off-screen
//				var draw_x = xx + 200;
//				var draw_y = yy - block.y * (sprite_get_height(sBlock_Default) / 2) + 200;

//				if (draw_x + sprite_get_width(sBlock_Default) < cam_x) continue;
//				if (draw_x > cam_x + cam_w) continue;
//				if (draw_y + sprite_get_height(sBlock_Default) < cam_y) continue;
//				if (draw_y > cam_y + cam_h) continue;

//				draw_sprite_ext(
//					sBlock_Default, 0, draw_x, draw_y,
//					1, 1, 0, block.color, 1
//				);
//			}
//		}
//	}
//};


