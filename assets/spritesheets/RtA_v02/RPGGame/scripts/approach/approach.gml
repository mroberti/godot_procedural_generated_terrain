function approach(argument0, argument1, argument2) {
		//approach(start, end, shift);
	//increase a value by another value, until it reaches a maximum value

	if(argument0 < argument1){
	    return min(argument0 + argument2, argument1); 
	}else{
	    return max(argument0 - argument2, argument1);
	}


}
