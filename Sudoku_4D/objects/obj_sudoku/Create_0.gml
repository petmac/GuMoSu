//SETUP
randomize();

//TEXT
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_black);

//OUTPUT
file=file_text_open_write("sudokutimes.txt");
file_text_close(file);

//HARDCODED DATA
_order_xy=[	0,4,8,12,		16,20,24,28,	32,33,34,35,	48,49,50,51,
			1,5,9,13,		17,21,25,29,	36,37,38,39,	52,53,54,55,
			2,6,10,14,		18,22,26,30,	40,41,42,43,	56,57,58,59,
			3,7,11,15,		19,23,27,31,	44,45,46,47,	60,61,62,63,
			64,68,72,76,	80,84,88,92,	0,1,2,3,		16,17,18,19,
			65,69,73,77,	81,85,89,93,	4,5,6,7,		20,21,22,23,
			66,70,74,78,	82,86,90,94,	8,9,10,11,		24,25,26,27,
			67,71,75,79,	83,87,91,95,	12,13,14,15,	28,29,30,31,
			32,36,40,44,	48,52,56,60,	64,65,66,67,	80,81,82,83,
			33,37,41,45,	49,53,57,61,	68,69,70,71,	84,85,86,87,
			34,38,42,46,	50,54,58,62,	72,73,74,75,	88,89,90,91,
			35,39,43,47,	51,55,59,63,	76,77,78,79,	92,93,94,95];
			
_value_x=[	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
			5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,
			1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,
			1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,
			1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,
			1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4];
_value_y=[	1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,
			1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,
			0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
			5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,
			1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,
			1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4];
_value_z=[	1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,
			1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,
			1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,
			1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,
			0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
			5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5];

for(var i=0;i<96;i++) {
	_matrix_position[i]=(((_value_x<<6)&_value_y)<<6)&_value_z;
	show_debug_message(string(_matrix_position[i]));
}

_peers=ds_list_create();
for(var i=16;i<96;i++) {
	_peers[| i]=ds_list_create();
	for(var j=0;j<i;j++) {
		//if(_value_x[i]==_value_x[j] || _value_y[i]==_value_y[j] || _value_z[i]==_value_z[j]) {
		if(_matrix_position[i]^_matrix_position[j]>0) {
			ds_list_add(_peers[| i],j);
		}
	}
}

_values=ds_list_create();
ds_list_add(_values,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16);

//INIT VARIABLES
counter=0;
square=0;
step=0;
time=get_timer()/1000;

for(var i=0;i<96;i++) {
    solution[i]=0;
	puzzle[i]=0;
}
