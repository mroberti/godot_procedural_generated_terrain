/// @description Insert description here
// You can write your code in this editor
// This just spawns 20 raindrops every step.
/*repeat(20) {
    part_particles_create(global.ps, random_range(-100, room_width+100), random_range(-100, 0), rain, 1);
}

repeat(20) {
    part_particles_create(global.ps, random_range(-100, room_width+100), random_range(-100,room_height+20), splat, 1);
}*/

//Start changing the weather if rain and currently in dry climate


if(global.rain==1)
	rainintensity = 1;
if(global.rain==2)
	rainintensity = 3;
if(global.rain==3)
	rainintensity = 12;


//RAIN
if(global.rain != 0){

//rain particles
	repeat(rainintensity) {
	    part_particles_create(global.ps, random_range(-100, room_width+100), random_range(-100, 0), rainBright, 1);
		part_particles_create(global.ps, random_range(-100, room_width+100), random_range(-100, 0), rainDark, 1);
}
//ground splats
	repeat(rainintensity*2) {
		part_particles_create(global.ps, random_range(-100, room_width+100), random_range(-100,room_height+20), splat, 1);
	}

}

//AIR FLOATIES
if(global.rain ==3){

	repeat(1) {
	    part_particles_create(global.ps, random_range((room_width/2)+1, room_width), random_range(-10,room_height+10), floaties, 1);
	}
}
else{

}