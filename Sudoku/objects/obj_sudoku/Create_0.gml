draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_black);

solver_check_exists_var=0;
solver_var=0;


counter=0;

time=get_timer()/1000;

sudoku();

timer=get_timer()/1000-time;
file=file_text_open_write("sudokutimes.txt");
file_text_write_string(file,string(timer)+"\n");
file_text_close(file);
counter++;



