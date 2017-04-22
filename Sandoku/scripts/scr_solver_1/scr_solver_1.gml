/// @desc scr_solver_1()
/// HIDDEN SINGLES

var returnvalue="No"


// HIDDEN SINGLES IN ROW/BOX/COLUMN (or pinned) in GREEN

for(var a=0;a<ARRAYS;a++) { //////////// 200us
	var array=_arrays[| a];
	var memory=0;
	var singles=0;
	for(var e=0;e<ELEMENTS;e++) {
		var values=inventory[| array[| e]];
		if(pop_state(values)==2) {
			singles=(memory^~singles)&(memory^values);
			memory|=values;
		}
	}
	if(singles>0) {
		for(var e=0;e<ELEMENTS;e++) {
			var element=array[| e];
			if(pop_state(inventory[| element])==2 && pop_state(inventory[| element]&singles)==1) {
				ds_list_replace(coloring[| element],log2(inventory[| element]&singles),c_green);
				returnvalue="Yes";
			}
		}
	}
}

/*
for(var i=0;i<18;i++) {  ////////////// 600us
	var array=_arrays[| i];
	var bucket=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
	var square=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
	for(var j=0;j<16;j++) {
		var values=inventory[| array[| j]];
		while(values>0) {
			bucket[log2(values&-values)]++;
			square[log2(values&-values)]=array[| j];
			values&=values-1;
		}
	}
	for(var j=0;j<16;j++) {
		if(bucket[j]==1) {
			if(scr_count_binary_ones(inventory[| square[j]])>1) {
				ds_list_replace(coloring[| square[j]],j,c_green);
				returnvalue="Yes";
			}
		}
	}
}
*/



//THE LAST POSSIBLE NUMBER in ORANGE
for(var i=0;i<96;i++) {
	if(solvedsquare[| i]<0) {
		var peers=_peers[| i];
		var bucket=$FFFF;
		for(var j=0;j<38;j++) {
			if(scr_count_binary_ones(inventory[| peers[| j]])==1) {
				bucket&=~inventory[| peers[| j]];
			}
		}
		if(scr_count_binary_ones(bucket)==1) {
			ds_list_replace(coloring[| i],log2(bucket),c_green);
			returnvalue="Yes";
			show_message("GOT A LAST POSSIBLE NUMBER!! (save and remove this line)");
		}
	}
}
		

return returnvalue;