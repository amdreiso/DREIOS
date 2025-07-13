
if (keyboard_check_pressed(ord("C"))) {
	update();
}

if (keyboard_check(ord("B"))) {
	setBlock(irandom(ds_grid_width(map)), irandom_range(0, 10), irandom(ds_grid_height(map)), BLOCK_ID.Error, true);
}

if (keyboard_check_pressed(ord("G"))) {
	Seed = irandom_range(10000, 10000000);
	
	for (var i=0; i<ds_grid_width(map); i++) {
		for (var j=0; j<ds_grid_height(map); j++) {
			var slot = new WorldSlot();
			var count = get_perlin_noise_2D(i, j, 5, true);
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
	update();
}

if (keyboard_check_pressed(ord("D"))) {
	displayMode ++;
	if (displayMode > 1) displayMode = 0;
	update();
}
