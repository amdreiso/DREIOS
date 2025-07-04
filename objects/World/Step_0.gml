
if (keyboard_check_pressed(ord("C"))) {
	updateWorld();
}

if (keyboard_check_pressed(ord("G"))) {
	for (var i=0; i<ds_grid_width(map); i++) {
		for (var j=0; j<ds_grid_height(map); j++) {
			var slot = new WorldSlot();
			for (var height=0; height<irandom_range(1, 10); height++) {
				var color = make_color_hsv(irandom(255), 255, 255);
				slot.add( new SlotBlock(0, height, color) );
			}
			ds_grid_set(map, i, j, slot);
		}
	}
	
	updateWorld();
}
