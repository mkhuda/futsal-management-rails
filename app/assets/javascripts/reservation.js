var rs;
rs = function() {
	wrapper = $(".list-box-reservation");
	$(wrapper).on("click", ".btn-approve-reservation", function(e) {
	// $(".btn-approve-reservation").click(function(e){
		e.preventDefault();
		var btn_default = '<button class="btn btn-xs btn-info btn-approve-reservation"><i class="fa fa-check-square-o"></i> Approve</button> <button class="btn btn-xs btn-danger btn-delete-reservation popup-delete"><i class="fa fa-minus-square-o"></i> Delete</button>';
		var btn_success = '<button class="btn btn-xs btn-success btn-approved" disabled><i class="fa fa-check-square-o"></i> Approved</button> <button class="btn btn-xs btn-danger btn-cancel-reservation"><i class="fa fa-times-circle"></i> Cancel</button> <button class="btn btn-xs btn-danger btn-delete-reservation popup-delete"><i class="fa fa-minus-square-o"></i> Delete</button>';
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
            	 if (msg.status == "ok") {
                $("#"+gsub_id+" .detail-reservation-box .the-btn-reservation").html(btn_success);
               } else {
                 $("#"+gsub_id+" .detail-reservation-box .the-btn-reservation").html(btn_default);
               }
            },
            error: function(x, t, m) {
              alert(t);
		        	$("#"+gsub_id+" .detail-reservation-box .the-btn-reservation").html(btn_default);
    		}
        });
	});

	$(wrapper).on("click", ".btn-cancel-reservation", function(e) {
		e.preventDefault();
		var btn_default = '<button class="btn btn-xs btn-info btn-approve-reservation"><i class="fa fa-check-square-o"></i> Approve</button> <button class="btn btn-xs btn-danger btn-delete-reservation popup-delete"><i class="fa fa-minus-square-o"></i> Delete</button>';
		var btn_success = '<button class="btn btn-xs btn-success btn-approved" disabled><i class="fa fa-check-square-o"></i> Approved</button> <button class="btn btn-xs btn-danger btn-approved"><i class="fa fa-times-circle"></i> Cancel</button> <button class="btn btn-xs btn-danger btn-delete-reservation popup-delete"><i class="fa fa-minus-square-o"></i> Delete</button>';
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
              if (msg.status == "ok") {
                  $("#"+gsub_id+" .detail-reservation-box .the-btn-reservation").html(btn_default);
              } else {
                $("#"+gsub_id+" .detail-reservation-box .the-btn-reservation").html(btn_success);
              }

            },
            error: function(x, t, m) {
              alert(t);
		        	$("#"+gsub_id+" .detail-reservation-box .the-btn-reservation").html(btn_success);


    		}
        });
	});

	$(wrapper).on("click", ".btn-delete-reservation", function(e) {
		e.preventDefault();

		var btn_default = '<button class="btn btn-xs btn-info btn-approve-reservation"><i class="fa fa-check-square-o"></i> Approve</button> <button class="btn btn-xs btn-danger btn-delete-reservation popup-delete"><i class="fa fa-minus-square-o"></i> Delete</button>';
		var btn_success = '<button class="btn btn-xs btn-success btn-approved" disabled><i class="fa fa-check-square-o"></i> Approved</button> <button class="btn btn-xs btn-danger btn-approved"><i class="fa fa-times-circle"></i> Cancel</button> <button class="btn btn-xs btn-danger btn-delete-reservation popup-delete"><i class="fa fa-minus-square-o"></i> Delete</button>';
		var the_id = $(this).parents().eq(2).attr('data-id');
		var data_p = $(this).parents().eq(2).attr('data-p');
		var gsub_id = the_id.replace(/\W/g, '');
		var nama = $("#"+gsub_id+" .list-box-reservation-href .nama").text();
		var nama_lapangan = $("#"+gsub_id+" .detail-reservation-box .nama_lapangan").text();

		var popup_delete = '<div class="modal" id="confirmationDialog"><div class="modal-dialog"><div class="modal-content"><div class="modal-header"><a class="close" data-dismiss="modal">×</a><h3>Hapus?</h3></div><div class="modal-body"><p>Yakin data <strong>'+nama+'</strong> ingin dihapus dari reservasi <strong>'+nama_lapangan+'</strong>?</p></div><div class="modal-footer"><a data-dismiss="modal" class="btn">Cancel</a><a data-dismiss="modal" class="btn btn-primary confirm">Ok</a></div></div></div></div>';

		$(popup_delete).modal();

		$('#confirmationDialog .confirm').on('click', function() {
			 $("#"+gsub_id).fadeTo( "slow", 0.33 );
			$.ajax({
	            type: "POST",
	            url: data_p,
	            data: {id: the_id, act: "delete"},
	            success: function(msg) {
                // alert(msg.status);
								if (msg.status == "ok") {
									$("#"+gsub_id).remove();
									$(".alert-reservation-success").fadeIn();
								} else {
									$("#"+gsub_id).fadeTo( "fast", 1 );
									$(".alert-reservation").fadeIn();
								}
	            },
              error: function(x, t, m) {
                  alert(t);
									$("#"+gsub_id).fadeTo( "fast", 1 );
									$(".alert-reservation").fadeIn();
              }
	    });
    });
	});

	$('.close-alert').on('click', function(e) {
    $(this).parent().hide();
});

}
$(document).ready(rs);
$(document).on('page:load', rs);
