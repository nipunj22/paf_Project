<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<title>title</title>
	
    
    <script src="assets/js/croppie.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.js"></script>
	
</head>
<body>
	
    <div class="container">
		
<br>
<p></p>
	                    <div>User List</div>
	                    <div>
	                        <div id="usersDiv">
	                    	
	            			</div>
	                    </div>
	                    
	                   
<div id="hideDiv" style="display: none">
    <form id="userRegister">
    <input type="hidden" id="edit_id" name="edit_id">
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
                  Edit
              </button>
          </div>
  	</form>
</div> 
	                    
</div>
	
</body>
</html>

<script>

    function deletes(id) {
    	if (confirm("Delete ?") == true) {
        	$.ajax({
                type: "DELETE",
                url: "rest/user",
                data: JSON.stringify({ 'id' : id}),
                dataType: "json",
    			contentType : 'application/json',
                success: function(data){
                	if(data['success']=="1"){
                		alert("Delete Successfull!");
    					reload();
    				}else if(data['success']=="0"){
    					alert("Delete Unsuccessful!");
    				}
                },
                failure: function(errMsg) {
                    alert('Error');
                }
            });
    	}
    }

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
            		"id" : $('#edit_id').val(),
                    "name" : $('#name').val(),
                    "email" : $('#email').val(),                                        
                    "address" : $('#address').val(),                   
                });
            	
            	console.log(fromData);

                $.ajax({
                    type: "PUT",
                    url: 'rest/user',
                    dataType : 'json',
    				contentType : 'application/json',
    				data: fromData,
                    success: function(data){
                    	if(data['success']=="1"){
                    		alert("Edit Successfull!");
                        	document.getElementById("hideDiv").style.display = "none";
                            $("#userRegister")[0].reset();
    						reload();
    					}else{
    						alert("Unsuccessful!");
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

    function reload(){
    	$.ajax({
            type: "GET",
            url: "rest/user",
            success: function(data){
            	$("#usersDiv").html(data);
            },
            failure: function(errMsg) {
                alert('Error');
            }
        });
    }

    reload();
    
    function edit(id) {
    	document.getElementById("hideDiv").style.display = "block";
    	$.ajax({
            type: "POST",
            url: "rest/user/get",
            data: JSON.stringify({ 'id' : id}),
            dataType: "json",
			contentType : 'application/json',
            success: function(data){
            	console.log(data),
                $('#edit_id').val(data['id']),
                $('#name').val(data['name']),
                $('#email').val(data['email']),                           
                $('#address').val(data['address'])                
            },
            failure: function(errMsg) {
                alert('Error');
            }
        });
    }
    
    
</script>