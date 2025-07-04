
randomize();

globalvar Game;
Game = {
	name: "dreios",
	author: "amdreiSO",
	version: "1.0",
	release: "indev",
};

globalvar Seed; Seed = irandom_range(1000, 10000000);

// data loaders
block_data();


instance_create_depth(0, 0, depth, World);
