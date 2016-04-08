var rs;
rs = function() {
	wrapper = $(".list-box-reservation");
	$(wrapper).on("click", ".btn-approve-reservation", function(e) { 
	// $(".btn-approve-reservation").click(function(e){
		e.preventDefault();
		var btn_default = '<button class="btn btn-xs btn-info btn-approve-reservation"><i class="fa fa-check-square-o"></i> Approve</button> <button class="btn btn-xs btn-danger btn-approve"><i class="fa fa-minus-square-o"></i> Delete</button>';
		var btn_success = '<button class="btn btn-xs btn-success btn-approved" disabled><i class="fa fa-check-square-o"></i> Approved</button> <button class="btn btn-xs btn-danger btn-cancel-reservation"><i class="fa fa-times-circle"></i> Cancel</button> <button class="btn btn-xs btn-danger btn-approve"><i class="fa fa-minus-square-o"></i> Delete</button>';
		var the_id = $(this).parents().eq(2).attr('data-id');
		var data_p = $(this).parents().eq(2).attr('data-p');
		var gsub_id = the_id.replace(/\W/g, '');
		$("#"+gsub_id+" .detail-reservation-box .the-btn-reservation").html(btn_success);
		// alert(window.location.href);
		$.ajax({
            type: "POST",
            url: data_p,
            timeout: 10000,
            datatype: "text",
            data: {id: the_id, act: "add"},
            success: function(msg) {
            	// alert(msg);
                $("#"+gsub_id+" .detail-reservation-box .the-btn-reservation").html(btn_success);
                $("#"+gsub_id).addClass("opacity-half");
            },
            error: function(x, t, m) {
		        if (t != "parsererror") {
		        	$("#"+gsub_id+" .detail-reservation-box .the-btn-reservation").html(btn_default);
		        	$("#"+gsub_id).addClass("opacity-full");
		        }
       
    		}	
        });
	});

	$(wrapper).on("click", ".btn-cancel-reservation", function(e) { 
		e.preventDefault();
		var btn_default = '<button class="btn btn-xs btn-info btn-approve-reservation"><i class="fa fa-check-square-o"></i> Approve</button> <button class="btn btn-xs btn-danger btn-approve"><i class="fa fa-minus-square-o"></i> Delete</button>';
		var btn_success = '<button class="btn btn-xs btn-success btn-approved" disabled><i class="fa fa-check-square-o"></i> Approved</button> <button class="btn btn-xs btn-danger btn-approved"><i class="fa fa-times-circle"></i> Cancel</button> <button class="btn btn-xs btn-danger btn-approve"><i class="fa fa-minus-square-o"></i> Delete</button>';
		var the_id = $(this).parents().eq(2).attr('data-id');
		var data_p = $(this).parents().eq(2).attr('data-p');
		var gsub_id = the_id.replace(/\W/g, '');
		$("#"+gsub_id+" .detail-reservation-box .the-btn-reservation").html(btn_default);
		// alert(window.location.href);
		$.ajax({
            type: "POST",
            url: data_p,
            timeout: 10000,
            datatype: "text",
            data: {id: the_id, act: "cancel"},
            success: function(msg) {
            	// alert(msg);
                $("#"+gsub_id+" .detail-reservation-box .the-btn-reservation").html(btn_default);
            },
            error: function(x, t, m) {
		        if (t != "parsererror") {
		        	$("#"+gsub_id+" .detail-reservation-box .the-btn-reservation").html(btn_success);
		        }
       
    		}	
        });
	});

}
$(document).ready(rs);
$(document).on('page:load', rs);