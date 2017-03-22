/// @desc solver(list)
/// @arg list	argument0



var solver_inventory=ds_list_create();

for(var i=0;i<81;i++) {
	solver_inventory[| i]=ds_list_create();
	ds_list_copy(solver_inventory[| i],argument0[| i]);
}

var solved=true;
var solving=true;

while(solving) {
	solving=false;
	for(var i=0;i<81;i++) {
		var size=ds_list_size(solver_inventory[| i]);
		if(size>1) { // ? SO MUCH FASTER!! LIKE 10 x FASTER THAN SOLVER_FIND_SINGLES
			
			//Return each connected single
			solving=solver_return_singles(solver_inventory,i);
			
		} else if (size==0) {
			solving=false;
			break;
		}
	}
}


for(var i=0;i<81;i++) {
	if(ds_list_size(solver_inventory[| i])==0) {
		solved=false;
	}
	ds_list_destroy(solver_inventory[| i]);
}

ds_list_destroy(solver_inventory);

return solved;
