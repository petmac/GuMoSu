
//loop through rows
for(var j=0;j<9;j++) {
	//loop through columns
	for(var i=0;i<9;i++) {
		if(ds_map_find_value(sudoku_grid[# i,j],"solvable")==1) {
			
			yt_solve_Square(sudoku_grid[# i,j]);
			yt_update_Sudoku(sudoku_grid,i,j);
			yt_update_Boxes(sudoku_grid,i,j);
			
			// https://www.youtube.com/watch?v=oUtxBYHrHFY 3:11
			return 1;
		}
	}
}

if(yt_box_Singles(sudoku_grid,sudoku_box)) {
	return 1;	
}
return yt_check_Rows(sudoku_grid,sudoku_box);


/// @desc yt_box_Singles(puzzle,boxes)
/// @arg puzzle
/// @arg boxes

var temp=0;

//loop through boxes
for(var i=0;i<9;i++) {
	//loop through possible array
	for(var j=0;j<9;j++) {
		var count=0;
		//loop through squares
		for(var xx=0;xx<0;xx++) {
			if(ds_map_find_value(ds_list_find_value(ds_map_find_value(boxes[| i],"squares"),xx),"number")!=0) {
				// https://www.youtube.com/watch?v=28lzkKBmyi4 14:06
				continue;
			}
			if(ds_list_find_value(ds_map_find_value(ds_list_find_value(ds_map_find_value(boxes[| i],"squares"),xx),"possible"),j)==0) {
				// https://www.youtube.com/watch?v=28lzkKBmyi4 14:57
				count++;
				temp=xx;
			}
			if(count==2) {
				break;	
			}
		}
		if(count==1) {
			//it's solvable https://www.youtube.com/watch?v=28lzkKBmyi4 18:34
			ds_map_replace(ds_list_find_value(ds_map_find_value(boxes[| i],"squares"),temp),"number",j+1);
			unsolved--;
			ds_map_replace(ds_list_find_value(ds_map_find_value(boxes[| i],"squares"),temp),"solvable",0);
			
			// https://www.youtube.com/watch?v=28lzkKBmyi4 19:52
			yt_update_Sudoku(puzzle,ds_map_find_value(ds_list_find_value(ds_map_find_value(boxes[| i],"squares"),temp),"column"),ds_map_find_value(ds_list_find_value(ds_map_find_value(boxes[| i],"squares"),temp),"row"));
			
			return 1;
		}
	}
}
// https://www.youtube.com/watch?v=oUtxBYHrHFY 5:03
return 0;



/// @desc yt_check_Rows(square,boxes)
/// @arg square
/// @arg boxes
// https://www.youtube.com/watch?v=Nc7eCcTkzxg 2:59

display_debug_messate("We got here!");

var sum=ds_list_create();
var place=ds_list_create();

//loop through rows
for(var i=0;i<9;i++) {
	
	//initialize sum and palce to 0 (9 times)
	ds_list_clear(sum);
	ds_list_add(sum,0,0,0,0,0,0,0,0,0);
	ds_list_clear(place);
	ds_list_add(place,0,0,0,0,0,0,0,0,0);
	
	//loop through each square in the row
	for(var j=0;j<9;j++) {
		// https://www.youtube.com/watch?v=Nc7eCcTkzxg 5:49
		if(ds_map_find_value(sudoku_grid[# j,i],"number") != 0) {
			continue;	
		}
	    	
		//loop through all possibles
		for(var k=0;k<9;k++) {
			// https://www.youtube.com/watch?v=Nc7eCcTkzxg 6:44
			// check if number k is possible
			if(ds_list_find_value(ds_map_find_value(sudoku_grid[# j,i],"possible"),k) == 0) {
				sum[| k]++;
				place[| k]=j;
			}
		}
	}
	    
	// https://www.youtube.com/watch?v=Nc7eCcTkzxg 9:24
	for (var k=0;k<9;k++) {
		if(sum[| k]==1) {
			// https://www.youtube.com/watch?v=Nc7eCcTkzxg 13:37
			ds_map_replace(sudoku_grid[# place[| k],i],"number",k+1);
			// https://www.youtube.com/watch?v=Nc7eCcTkzxg 15:55
			ds_map_replace(sudoku_grid[# place[| k],i],"solvable",0);
			unsolved--;
			
			// https://www.youtube.com/watch?v=Nc7eCcTkzxg 16:37
			yt_update_Sudoku(sudoku_grid,place[|k],i);
			yt_update_Boxes(sudoku_grid,place[|k],i);
			
			ds_list_destroy(sum);
			ds_list_destroy(place);
			return 1;
		}
	}
}


ds_list_destroy(sum);
ds_list_destroy(place);
return 0;
