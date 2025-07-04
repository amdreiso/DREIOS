
map = ds_grid_create(64, 64);

for (var i=0; i<ds_grid_width(map); i++) {
	for (var j=0; j<ds_grid_height(map); j++) {
		var slot = new WorldSlot();
		var count = get_perlin_noise_2D(i, j, 20, true);
		count = clamp(count, 1, 100);
		
		for (var height=0; height<count; height++) {
			var color = make_color_hsv(irandom(255), 0, 40);
			if (height == count-1) {
				color = c_green;
			}
			slot.add( new SlotBlock(0, height, color) );
		}
		ds_grid_set(map, i, j, slot);
	}
}

surface = surface_create(room_width, room_height);
skyColor = $181818;

updateWorld = function() {
	
	show_debug_message("Redrawing world");
	
	surface_set_target(surface);
	draw_clear(skyColor);
	
	for (var i=0; i<ds_grid_height(map); i++) {
		for (var j=0; j<ds_grid_width(map); j++) {
			var offsetX = 0;
			if (i % 2 == true) offsetX = sprite_get_width(sBlock_Default) / 2;
			
			var xx = j * sprite_get_width(sBlock_Default) + offsetX;
			var yy = i * 8;
			
			var stack = ds_grid_get(map, j, i);
			var color = c_white;
			
			for (var block=0; block<array_length(stack.blockList); block++) {
				var b = stack.blockList[block];
				color = stack.blockList[block].color;
				var blockHeight = -b.y * (sprite_get_height(sBlock_Default) / 2);
				
				draw_sprite_ext(
					sBlock_Default, 0, xx + 200, (yy + blockHeight) + 200,
					1, 1, 0, color, 1
				);
			}
			
		}
	}
	
	surface_reset_target();
	
}

updateWorld();

draw = function() {
	
	draw_surface(surface, 0, 0);
	
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


