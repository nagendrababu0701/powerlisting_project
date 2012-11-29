function new_user_validations(action_name)

{

	//alert(City_Name)

if(action_name == "business_search" ){
	if(($('#business').val() == "" || $('#city').val() == "") && ($('#business').val() == "" || $('#ph_no').val() == "")){
		if($('#business').val())
		$('#business_search').hide();
		else
		$('#business_search').show();	
		if($('#city').val())
	    $('#city_search').hide();
		else
		$('#city_search').show();	
	    $('#business').focus();
	    $('#city').focus();
	    return false;
	}
    else{
	  $('#business_search').hide();
	  $('#city_search').hide();
    }	
  }



 return true;
	
}

