
randomize();

globalvar Game;
Game = {
	name: "dreios",
	author: "amdreiSO",
	version: "1.0",
	release: "indev",
};

globalvar Seed; Seed = irandom_range(1000, 10000000);
globalvar Style; Style = {
	background: $303030,
};

// data loaders
block_data();
block_init();


instance_create_depth(0, 0, depth, World);

