

map = ds_grid_create(10, 10);

for (var i=0; i<10; i++) {
	for (var j=0; j<10; j++) {
		var slot = new WorldSlot();
		for (var height=0; height<irandom_range(1, 4); height++) {
			slot.add( new SlotBlock(0, height, choose(c_white, c_ltgray, c_gray)) );
		}
		ds_grid_set(map, i, j, slot);
	}
}



drawBlocks = function() {
	
	for (var i=0; i<10; i++) {
		for (var j=0; j<10; j++) {
			var offsetX = 0;
			if (i % 2 == true) offsetX = sprite_get_width(sBlock_Default) / 2;
			
			var xx = j * sprite_get_width(sBlock_Default) + offsetX;
			var yy = i * 8;
			
			var stack = ds_grid_get(map, j, i);
			var color = c_white;
			
			show_debug_message(stack);
			
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
	
}



/*

drawBlocks = function() {
	var cam_x = camera_get_view_x(view_camera[0]);
	var cam_y = camera_get_view_y(view_camera[0]);
	var cam_w = camera_get_view_width(view_camera[0]);
	var cam_h = camera_get_view_height(view_camera[0]);

	for (var i = 0; i < 10; i++) {
		for (var j = 0; j < 10; j++) {
			var offsetX = (i % 2 == 1) ? sprite_get_width(sBlock_Default) / 2 : 0;
			var xx = j * sprite_get_width(sBlock_Default) + offsetX;
			var yy = i * 8;

			var stack = ds_grid_get(map, j, i);
			var blocks = stack.blockList;

			for (var b = 0; b < array_length(blocks); b++) {
				var block = blocks[b];
				var block_z = block.y; // height
				var isBlocked = false;

				// Check neighbors: (i+1, j) and (i, j+1)
				var neighbor_stacks = [
					[i + 1, j],
					[i, j + 1]
				];

				for (var n = 0; n < array_length(neighbor_stacks); n++) {
					var ni = neighbor_stacks[n][0];
					var nj = neighbor_stacks[n][1];

					if (ni >= 0 && ni < 10 && nj >= 0 && nj < 10) {
						var neighbor = ds_grid_get(map, nj, ni);
						if (neighbor != undefined) {
							var neighborBlocks = neighbor.blockList;
							for (var nb = 0; nb < array_length(neighborBlocks); nb++) {
								if (neighborBlocks[nb].y >= block_z) {
									isBlocked = true;
									break;
								}
							}
						}
					}

					if (isBlocked) break;
				}

				if (isBlocked) continue;

				// Culling off-screen
				var draw_x = xx + 200;
				var draw_y = yy - block.y * (sprite_get_height(sBlock_Default) / 2) + 200;

				if (draw_x + sprite_get_width(sBlock_Default) < cam_x) continue;
				if (draw_x > cam_x + cam_w) continue;
				if (draw_y + sprite_get_height(sBlock_Default) < cam_y) continue;
				if (draw_y > cam_y + cam_h) continue;

				draw_sprite_ext(
					sBlock_Default, 0, draw_x, draw_y,
					1, 1, 0, block.color, 1
				);
			}
		}
	}
};


