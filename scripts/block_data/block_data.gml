function block_data(){

}

function SlotBlock(blockID, y, color=c_white) constructor {
	self.blockID = blockID;
	self.color = color;
	self.y = y;
}

function WorldSlot() constructor {
	self.blockList = [];
	
	for (var i=0; i<argument_count; i++) {
		array_push(self.blockList, argument[i]);
	}
	
	self.add = function(value) {
		array_push(self.blockList, value);
	}
}
