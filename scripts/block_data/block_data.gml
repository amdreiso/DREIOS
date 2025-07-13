function block_data(){
	globalvar BlockData; BlockData = ds_map_create();
	globalvar BLOCK;
}

function block_init() {
	BLOCK = {
		Register: function(blockID, name, sprite) {
			var block = {};
			block.name = name;
			block.sprite = sprite;
			BlockData[? blockID] = block;
		},
		
		Get: function(blockID) {
			if (ds_map_exists(BlockData, blockID)) {
				return BlockData[? blockID];
			}
			return BlockData[? BLOCK_ID.Error];
		}
	};
	
	BLOCK.Register( BLOCK_ID.Default, "default", sBlock_Default );
	BLOCK.Register( BLOCK_ID.Error, "error", sBlock_Error );
	BLOCK.Register( BLOCK_ID.Grass, "grass", sBlock_Grass );
	BLOCK.Register( BLOCK_ID.Stone, "stone", sBlock_Stone );
}

function SlotBlock(blockID, y, color=c_white) constructor {
	self.blockID = blockID;
	self.color = color;
	self.y = y;
}

function WorldSlot() constructor {
	self.blockList = [];
	
	self.set = function(y, block, debug=false) {
		for (var i = 0; i < array_length(self.blockList); i++) {
			if (self.blockList[i].y == y) array_delete(self.blockList, i, 1);
		}
		
		array_push(self.blockList, block);
		if debug then show_debug_message($"World map slot set {y}y position to {block}"); 
	}
}
