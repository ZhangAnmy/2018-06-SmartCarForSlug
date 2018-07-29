<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'site.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="shortcut icon" href="favicon.ico">
<link href="css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="css/font-awesome.css?v=4.4.0" rel="stylesheet">
<link href="css/plugins/footable/footable.bootstrap.css" rel="stylesheet">
<link href="css/plugins/footable/footable.core.css" rel="stylesheet">
<link href="css/style.css?v=4.1.0" rel="stylesheet">
</head>

<body>

<div class="example">
			<table id="editing-example" class="table" data-paging="true" data-filtering="true" data-sorting="true">
				<thead>
				<tr>
					<th data-name="id" data-breakpoints="xs" data-type="number">编号</th>
					<th data-name="siteName">厂名</th>
					<th data-name="address">地址</th>
					<th data-name="manager">负责人</th>
					<th data-name="telephone">Tel.</th>
					<th data-name="status">状态</th>
					<th data-name="langtitude" style="display:none">经度</th>
					<th data-name="latitude" style="display:none">纬度</th>
					<th data-name="depth">状态</th>
				</tr>
				</thead>
				<tbody>
				<tr data-expanded="true">
					<td>1</td>
					<td>Dennise</td>
					<td>Fuhrman</td>
					<td>High School History Teacher</td>
					<td>Fuhrman</td>
					<td>High School History Teacher</td>
					<td>Fuhrman</td>
					<td>High School History Teacher</td>
				</tr>
				<tr>
					<td>1</td>
					<td>Dennise</td>
					<td>Fuhrman</td>
					<td>High School History Teacher</td>
					<td>Fuhrman</td>
					<td>High School History Teacher</td>
					<td>Fuhrman</td>
					<td>High School History Teacher</td>
				</tr>
				<tr>
					<td>1</td>
					<td>Dennise</td>
					<td>Fuhrman</td>
					<td>High School History Teacher</td>
					<td>Fuhrman</td>
					<td>High School History Teacher</td>
					<td>Fuhrman</td>
					<td>High School History Teacher</td>
				</tr>
				<tr>
					<td>1</td>
					<td>Dennise</td>
					<td>Fuhrman</td>
					<td>High School History Teacher</td>
					<td>Fuhrman</td>
					<td>High School History Teacher</td>
					<td>Fuhrman</td>
					<td>High School History Teacher</td>
				</tr>
				<tr>
					<td>1</td>
					<td>Dennise</td>
					<td>Fuhrman</td>
					<td>High School History Teacher</td>
					<td>Fuhrman</td>
					<td>High School History Teacher</td>
					<td>Fuhrman</td>
					<td>High School History Teacher</td>
				</tr>
				<tr>
					<td>1</td>
					<td>Dennise</td>
					<td>Fuhrman</td>
					<td>High School History Teacher</td>
					<td>Fuhrman</td>
					<td>High School History Teacher</td>
					<td>Fuhrman</td>
					<td>High School History Teacher</td>
				</tr>
				<tr>
					<td>1</td>
					<td>Dennise</td>
					<td>Fuhrman</td>
					<td>High School History Teacher</td>
					<td>Fuhrman</td>
					<td>High School History Teacher</td>
					<td>Fuhrman</td>
					<td>High School History Teacher</td>
				</tr>
				<tr>
					<td>1</td>
					<td>Dennise</td>
					<td>Fuhrman</td>
					<td>High School History Teacher</td>
					<td>Fuhrman</td>
					<td>High School History Teacher</td>
					<td>Fuhrman</td>
					<td>High School History Teacher</td>
				</tr>
				<tr>
					<td>1</td>
					<td>Dennise</td>
					<td>Fuhrman</td>
					<td>High School History Teacher</td>
					<td>Fuhrman</td>
					<td>High School History Teacher</td>
					<td>Fuhrman</td>
					<td>High School History Teacher</td>
				</tr>
				</tbody>
			</table>
<!-- Modal -->
			<div class="modal fade" id="editor-modal" tabindex="-1" role="dialog" aria-labelledby="editor-title">
				<style scoped>
					/* provides a red astrix to denote required fields */
					.form-group.required .control-label:after {
						content:"*";
						color:red;
						margin-left: 4px;
					}
				</style>
				<div class="modal-dialog" role="document">
					<form class="modal-content form-horizontal" id="editor">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							<h4 class="modal-title" id="editor-title">Add Row</h4>
						</div>
						<div class="modal-body">
							<input type="number" id="id" name="id" class="hidden"/>
							<div class="form-group required">
								<label for="firstName" class="col-sm-3 control-label">First Name</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="firstName" name="firstName" placeholder="First Name" required>
								</div>
							</div>
							<div class="form-group required">
								<label for="lastName" class="col-sm-3 control-label">Last Name</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="lastName" name="lastName" placeholder="Last Name" required>
								</div>
							</div>
							<div class="form-group">
								<label for="jobTitle" class="col-sm-3 control-label">Job Title</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="jobTitle" name="jobTitle" placeholder="Job Title">
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary">Save changes</button>
							<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
						</div>
					</form>
				</div>
			</div>

		</div>

	<!-- 全局js -->
	<script src="js/jquery.min.js?v=2.1.4"></script>
	<script src="js/bootstrap.min.js?v=3.3.6"></script>
	<script src="js/plugins/footable/footable.js"></script>


	<!-- 自定义js -->
	<script src="js/content.js?v=1.0.0"></script>

<script>
	jQuery(function($){
		var $modal = $('#editor-modal'),
			$editor = $('#editor'),
			$editorTitle = $('#editor-title'),
			ft = FooTable.init('#editing-example', {
				editing: {
					enabled: true,
					addRow: function(){
						$modal.removeData('row');
						$editor[0].reset();
						$editorTitle.text('Add a new row');
						$modal.modal('show');
					},
					editRow: function(row){
						var values = row.val();
						$editor.find('#id').val(values.id);
						$editor.find('#firstName').val(values.firstName);
						$editor.find('#lastName').val(values.lastName);
						$editor.find('#jobTitle').val(values.jobTitle);

						$modal.data('row', row);
						$editorTitle.text('Edit row #' + values.id);
						$modal.modal('show');
					},
					deleteRow: function(row){
						if (confirm('Are you sure you want to delete the row?')){
							alert("delete");
						}
					}
				}
			}),
			uid = 10;

		$editor.on('submit', function(e){
			if (this.checkValidity && !this.checkValidity()) return;
			e.preventDefault();
			var row = $modal.data('row'),
				values = {
					id: $editor.find('#id').val(),
					firstName: $editor.find('#firstName').val(),
					lastName: $editor.find('#lastName').val(),
					jobTitle: $editor.find('#jobTitle').val()
				};

			if (row instanceof FooTable.Row){
				row.val(values);
			} else {
				values.id = uid++;
				ft.rows.add(values);
			}
			$modal.modal('hide');
		});
	});
</script>

</body>
</html>
