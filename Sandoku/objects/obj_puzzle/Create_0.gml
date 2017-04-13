//
draw_set_font(font_small);
draw_set_halign(fa_center);
puzzle_create_mode=0; //1==solver; 2==brute <<==!!
//

// 0,1,..95 => rows/columns
_order_xy=[	0,1,2,3,	 32,33,34,35, 16,17,18,19,
			4,5,6,7,	 36,37,38,39, 20,21,22,23,
			8,9,10,11,	 40,41,42,43, 24,25,26,27,
			12,13,14,15, 44,45,46,47, 28,29,30,31,
		   
			48,49,50,51, 80,81,82,83, 64,65,66,67,
			52,53,54,55, 84,85,86,87, 68,69,70,71,
			56,57,58,59, 88,89,90,91, 72,73,74,75,
			60,61,62,63, 92,93,94,95, 76,77,78,79,
		   
			16,20,24,28, 0,4,8,12,	  32,36,40,44,
			17,21,25,29, 1,5,9,13,	  33,37,41,45,
			18,22,26,30, 2,6,10,14,	  34,38,42,46,
			19,23,27,31, 3,7,11,15,	  35,39,43,47,
		   
			64,68,72,76, 48,52,56,60, 80,84,88,92,
			65,69,73,77, 49,53,57,61, 81,85,89,93,
			66,70,74,78, 50,54,58,62, 82,86,90,94,
			67,71,75,79, 51,55,59,63, 83,87,91,95];

// matrix indexes
_value_x=[	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
			1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,
			1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,
			5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,
			1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,
			1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4];
_value_y=[	1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,
			0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
			1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,
			1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,
			5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,
			1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4];
_value_z=[	1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,
			1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,
			0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
			1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,
			1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,
			5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5];

// peers per square
_peers=ds_list_create(); //
for(var i=0;i<96;i++) {
	_peers[| i]=ds_list_create();
	for(var j=0;j<96;j++) {
		if(i!=j && scr_square_is_peer(i,j)) {
			ds_list_add(_peers[| i],j);	
		}
	}
}

// arrays/vectors x/y/z[0,1..5] (4aislesx3+6faces=18)
_arrays=ds_list_create();
for(var i=0;i<18;i++) {
	_arrays[| i]=ds_list_create(); // 16 values for each array
}
for(var i=0;i<96;i++) {
	ds_list_add(_arrays[| _value_x[i]],i); // x[0,1..5] => _arrays[| 0,1..5]
	ds_list_add(_arrays[| _value_y[i]+6],i); // y[0,1..5] => _arrays[| 6,7..11]
	ds_list_add(_arrays[| _value_z[i]+12],i); // z[0,1..5] => _arrays[| 12,13..17]
}

_values=ds_list_create(); // value list to copy values from
ds_list_add(_values,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16);

//INIT ARRAYS
ds_list_shuffle(_values); //1,2..16
for(var i=0;i<96;i++) {
	solution[i]=0;
	puzzle[i]=0;
} 

//INIT DATASTRUCTURES
inventory=ds_list_create(); //inventory of values for each square
for(var i=0;i<96;i++) { //
	inventory[| i]=solution[i]==0 ? $FFFF : power(2,solution[i]-1);
}

scr_puzzle_create();



/// @desc binary_count(str)
/// @arg str argument0
return string_count("1",string(argument0));


///@desc scr_puzzle_create()
_order=ds_list_create();
for(var i=0;i<96;i++) {
	inventory[| i]=solution[i]==0 ? $FFFF : power(2,solution[i]-1);
	ds_list_add(_order,i);
}
if(ds_list_size(_order)>0) { //work through all squares once
	var i=ds_list_find_value(_order,0); //get random square
	ds_list_delete(_order,0); //prevent duplicate squares
	
    inventory[| i]=$FFFF; //try all values...
	if(puzzle_create_mode==1) {
		if(sudoku_puzzle_solver(i)) { //if solvable then can't remove this square:
			inventory[| i]=solution[i]==0 ? $FFFF : power(2,solution[i]-1); //restore square
		}
	} else if (puzzle_create_mode==2) {
		if(sudoku_puzzle_brute(i)) { //if solvable then can't remove this square:
			inventory[| i]=solution[i]==0 ? $FFFF : power(2,solution[i]-1); //restore square
		}
	}
}
ds_list_destroy(_order);
