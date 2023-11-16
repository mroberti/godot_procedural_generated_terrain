/// @description GUI key inputs


if (keyboard_check_pressed(vk_space)) {
	if(global.rain<3)
		global.rain++;
	else
		global.rain = 0;
}

if (keyboard_check_pressed(vk_tab)) {
	global.debugmode = !global.debugmode;
}

