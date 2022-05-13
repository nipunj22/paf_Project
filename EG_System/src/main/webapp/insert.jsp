<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<title>Title</title>
	
    <script src="assets/js/croppie.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.js"></script>
	
</head>
<body>
	
    <div class="container">
		
<br>
<p></p>

	                    <div>User Register</div>
	                        <form id="userRegister">
	                            <div>
	                                <label>Name</label>
	                                <div>
	                                    <input type="text" id="name" class="form-control" name="name">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Email</label>
	                                <div>
	                                    <input type="email" id="email" class="form-control" name="email">
	                                </div>
	                            </div>
	                            
	                           
	                            
	                            
	                            
	                            <div>
	                                <label>Address</label>
	                                <div>
	                                    <input type="text" id="address" class="form-control" name="address">
	                                </div>
	                            </div>
	                            
	                            
	                            
	                            
	                            
	                            <div>
	                                <button type="submit" class="btn btn-success">
	                                    Add
	                                </button>
	                                <a href="edit_n_delete.jsp" class="btn btn-success">
	                                    List
	                                </a>
	                            </div>
	                    	</form>
	                    </div>

</body>
</html>
<script>

$(document).ready(function () {

    $("#userRegister").validate({
        rules: {
        	name: "required",
        	email: {
                email: true,
                required: true
            },
        	address: "required",       	
        },
        messages: {
        	name: "Name Required!",
        	email: {
                email: "format",
                required: "Email required"
            },        
            address: "Address Required!",
        },
        submitHandler: function () {
        	var fromData = JSON.stringify({
                "name" : $('#name').val(),
                "email" : $('#email').val(),
                "address" : $('#address').val(),
            });
        	
        	console.log(fromData);

            $.ajax({
                type: "POST",
                url: 'rest/user',
                dataType : 'json',
				contentType : 'application/json',
				data: fromData,
                success: function(data){
                	console.log(data);
                	if(data['success']=="1"){
                		alert("Added Successfull!");
                        $("#userRegister")[0].reset();
					}else{
						alert("Unsuccessfull!");
					}
                },
                failure: function(errMsg) {
                	alert("Connection Error!");
                }
            });
        }
    });

    $("#userRegister").submit(function(e) {
        e.preventDefault();
    });

});

</script>