 ///squashAndStretch(Object)
function squashAndStretch(argument0, argument1, argument2) {

	  _object = argument0;  // incoming object
	  _targetxscale = argument1; 
	  _targetyscale = argument2;
  
	  dx = abs(_targetxscale - _object.sprite_width);
	  dy = abs(_targetyscale - _object.sprite_height);

	    with(_object){  draw_xscale = lerp(draw_xscale,_targetxscale,.1);} 
		with(_object){ draw_yscale = lerp(draw_yscale, _targetyscale,.1);}



}
