draw_self();

for(var i=0;i<16;i++) {
	for(var j=0;j<12;j++) {
		draw_set_color(c_black);
		if((i>=8 && j>=4) || j>=8) {
			draw_set_color(c_white);
		}
		draw_text(20*j+x+10,20*i+y+1,string(solution[_order_xy[12*i+j]]));
	}
}
draw_set_color(c_gray);
for(var i=0;i<12;i++) {
	if(i<4) {
		draw_text(20*i+x+10,y-16,"Z"+string(i+1));
	} else if (i<8) {
		draw_text(20*i+x+10,y-16,"Y"+string(i-3));
	} else {
		draw_text(20*i+x+10,y-16,"X"+string(i-7));
	}
}
for(var i=0;i<16;i++) {
	draw_text(x-8,20*i+y+1,string(i+1));
}

draw_set_halign(fa_left);
if(valid) {
	draw_set_color(c_green);
	draw_text(x,bbox_bottom,"Valid Solution");
} else {
	draw_set_color(c_red);
	draw_text(x,bbox_bottom,"Invalid Solution!");
}

draw_set_halign(fa_right);
draw_text(bbox_right,bbox_bottom,"["+string(scr_thousand_seperator(step))+" steps - "+string(scr_thousand_seperator(round(time/1000)))+"ms]");

/*
button=[	"Solution:",noone, //0 1
			"Create",0, //2 3
			"Log",0, //4 5
			"Clipboard:",noone, //6 7
			"Export",0, //8 9
	   		"Import",0, //10 11
	   		"Puzzle:",noone, //12 13
	   		"Solver",0, //14 15
	   		"Brute",0]; //16 17
*/
draw_set_halign(fa_left);
var xx=bbox_left;
var yy=bbox_bottom;
for(var i=0;i<array_length_1d(button);i+=2) {
	if(button[i+1]==noone) {
		xx=bbox_left;
		yy+=20;
		draw_set_color(c_white);
		draw_text(xx,yy,button[i]);
	} else {
		if(mouse_check_button_pressed(mb_left)) {
			if(point_in_rectangle(mouse_x,mouse_y,xx,yy,xx+string_width(button[i]),yy+string_height(button[i]))) {
				button[i+1]=1;
			}
		} else if (mouse_check_button_pressed(mb_right)) {
			if(point_in_rectangle(mouse_x,mouse_y,xx,yy,xx+string_width(button[i]),yy+string_height(button[i]))) {
				button[i+1]=2;
			}	
		}
		draw_set_color(c_red);
		if(button[i+1]==1 || button[i+1]==2) {
			draw_set_color(c_blue);
		}
		draw_rectangle(xx,yy,xx+string_width(button[i]),yy+string_height(button[i]),false);
		draw_set_color(c_blue);
		draw_rectangle(xx,yy,xx+string_width(button[i]),yy+string_height(button[i]),true);
		draw_set_color(c_white);
		draw_text(xx,yy,button[i]);
	}
	xx+=string_width(button[i])+20;
}



draw_set_halign(fa_center);
draw_set_color(c_black);
