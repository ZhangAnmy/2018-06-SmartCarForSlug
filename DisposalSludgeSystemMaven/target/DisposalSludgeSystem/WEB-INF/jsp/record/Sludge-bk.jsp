<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<base href="<%=basePath%>">

	<title>污泥块去向记录</title>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="shortcut icon" href="favicon.ico">
	<link href="css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
	<link href="css/font-awesome.css?v=4.4.0" rel="stylesheet">
	<link href="css/plugins/footable/footable.core.css" rel="stylesheet">
	<!-- <link href="css/animate.css" rel="stylesheet"> -->
	<link href="css/style.css?v=4.1.0" rel="stylesheet">
	<link href="css/data/bootstrap-datetimepicker.min.css" rel="stylesheet" />



</head>

<body class="gray-bg">
<!-- 用来存id -->
<input id="sludgeId" type="hidden" />
<input id="trIndex" type="hidden" />
<!-- Modal -->


<!-- ***********************************删除污泥块记录信息模态框 ******************************-->

<div class="modal fade" id="delSludgeModel" tabindex="-1" role="dialog"
	 aria-labelledby="editSludgeModelLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h2 style="text-align: center;">确认删除?</h2>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-l" data-dismiss="modal">取消</button>
				<button id="deleteButton" type="button" class="btn btn-primary">删除</button>
			</div>
		</div>
	</div>
</div>

<!-- ***********************************修改污泥块记录信息模态框 ******************************-->
<div class="modal inmodal" id="editSludgeModel" tabindex="-1"
	 role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content animated bounceInRight">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
				</button>
				<img alt="140x140" src="img/littercar.png" width="10%" height="10%" />
				<h4 class="modal-title">污泥块信息</h4>
			</div>
			<div class="modal-body">
				<div class="container" style="width: 540px">
					<div class="form-group">
						<div>
							<label for="Groupname" class="col-sm-3 control-label">RFID：</label>
							<input type="hidden" id="editCarId">
							<div class="col-sm-9">
								<input type="text" class="form-control m-b control-label"
									   id="editSludgeRFID" placeholder="请输入RFID">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div>
							<label for="Groupname" class="col-sm-3 control-label">目的地：</label>
							<div class="col-sm-9">
								<input type="text" class="form-control m-b"
									   id="editSludgeDesAddr" placeholder="请输入目的地">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div>
							<label for="Groupname" class="col-sm-3 control-label">用途：</label>
							<div class="col-sm-9">
								<select class="form-control m-b" name="account"
										id="editSludgeFuncId">
									<option value="-1">--请选择--</option>
									<c:forEach items="${requestScope.sludgeFunctions }"
											   var="slugeFunc">
										<option id="func${slugeFunc.id }" value="${slugeFunc.id }">${slugeFunc.function }</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-white" data-dismiss="modal">取消</button>
				<button id="saveEditButton" type="button" class="btn btn-primary">保存</button>
			</div>
		</div>
	</div>
</div>


<div class="wrapper wrapper-content animated fadeInRight">

	<div class="row">
		<div class="col-sm-12">
			<div class="ibox float-e-margins">
				<div class="ibox-title">
					<h1 class="text-info"
						style="text-align: center;font-family:KaiTi; margin-top:-1%">污泥块去向记录</h1>

					<div class="ibox-tools">
						<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
						</a> <a class="dropdown-toggle" data-toggle="dropdown" href="#">
						<i class="fa fa-wrench"></i>
					</a>
						<ul class="dropdown-menu dropdown-user">
							<li><a href="#">选项 01</a></li>
							<li><a href="#">选项 02</a></li>
						</ul>
						<a class="close-link"> <i class="fa fa-times"></i>
						</a>
					</div>
				</div>
				<div class="ibox-content project-list">

					<div class="col-lg-offset-2">

						<div class="form-inline">
							<div class="form-group">
								<label class="sr-only" for="search">搜索方式</label>
								<div class="input-group">
									<div class="btn-group">
										<button class="btn btn-default" disabled="disabled">搜索方式</button>
										<button class="btn btn-primary dropdown-toggle"
												data-toggle="dropdown">
											<span class="fa fa-caret-down"></span>
										</button>
										<ul class="dropdown-menu">
											<li><a class="btn btn-primary"
												   href="javascript:void(0)" id="all_search">全部</a></li>
											<li><a class="btn btn-primary"
												   href="javascript:void(0)" id="factory_search">工厂</a></li>
											<li><a class="btn btn-primary"
												   href="javascript:void(0)" id="driver_search">负责人</a></li>
											<li><a class="btn btn-primary"
												   href="javascript:void(0)" id="date-search">日期</a></li>
										</ul>
									</div>
								</div>
							</div>

							<div class="form-group col-lg-offset-1" id="siteList"
								 style="margin-top:4px ;">
								<label class="sr-only" for="工厂">工厂</label>
								<div class="input-group">
									<div class="btn-group">
										<button class="btn btn-default" disabled="disabled">选择工厂</button>
										<button class="btn btn-primary dropdown-toggle"
												data-toggle="dropdown">
											<span class="fa fa-caret-down"></span>
										</button>
										<ul class="dropdown-menu">

											<c:forEach items="${requestScope.siteList }" var="site">
												<li><a class="btn btn-primary site" name="${site.id }"
													   href="javascript:void(0)">${site.siteName }</a></li>

											</c:forEach>



										</ul>
									</div>
								</div>
							</div>

							<div class="form-group col-lg-offset-1" id="driverList"
								 style="margin-top: 4px;">
								<label class="sr-only" for="司机">负责人</label>
								<div class="btn-group">
									<button class="btn btn-default" disabled="disabled">选择负责人</button>
									<button class="btn btn-primary dropdown-toggle"
											data-toggle="dropdown">
										<span class="fa fa-caret-down"></span>
									</button>
									<ul class="dropdown-menu">

										<c:forEach items="${requestScope.driverList }" var="driver">
											<li><a class="btn btn-success driver"
												   name="${driver.id }" href="javascript:void(0)">${driver.realname }</a></li>
										</c:forEach>
									</ul>
								</div>
							</div>

							<div class="form-group" id="start_date">
								<label class="sr-only" for="time">起始时间</label>
								<div class="input-group date form_date">
										<span class="input-group-addon">起始时间&nbsp;<i
												class="fa fa-calendar-o"></i></span> <input id="start_date_text"
																							type="text" class="form-control" readonly /> <span
										class="input-group-addon"><span
										class="glyphicon glyphicon-remove"></span></span> <span
										class="input-group-addon"><span
										class="glyphicon glyphicon-calendar"></span></span>
								</div>
							</div>

							<div class="form-group" id="end_date">
								<label class="sr-only" for="time">截止时间</label>
								<div class="input-group date form_date">
										<span class="input-group-addon">截止时间&nbsp;<i
												class="fa fa-calendar-o"></i></span> <input id="end_date_text"
																							type="text" class="form-control" readonly /> <span
										class="input-group-addon"><span
										class="glyphicon glyphicon-remove"></span></span> <span
										class="input-group-addon"><span
										class="glyphicon glyphicon-calendar"></span></span>
								</div>
							</div>
							<button class="btn btn-primary" id="submit"
									style="margin-top:3px">查询</button>

						</div>

						<!--<input type="text" class="form-control input-sm m-b-xs" id="filter" placeholder="搜索表格...">-->
					</div>

					<div id="tableDiv"></div>



				</div>
			</div>
		</div>
	</div>
</div>
<!-- 全局js -->
<script src="js/jquery.min.js?v=2.1.4"></script>
<script src="js/bootstrap.min.js?v=3.3.6"></script>
<script src="js/plugins/data/bootstrap-datetimepicker.min.js"></script>
<script src="js/plugins/data/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="js/plugins/footable/footable.all.min.js"></script>



<!-- 自定义js -->
<script src="js/content.js?v=1.0.0"></script>
<script>
	$(document).ready(function() {
		var table_start = '<table id="table" class="footable table-hover table table-stripped toggle-arrow-tiny" data-page-size="7">' +
				'<thead>' +
				'<tr>' +
				'<th data-toggle="true">状态</th>' +
				'<th>RFID</th>' +
				'<th>产地</th>' +
				'<th>目的地</th>' +
				'<th>处理人</th>' +
				'<th>产生污泥块量</th>' +
				'<th>操作</th>' +
				'<th data-hide="all">污泥产出时间</th>' +
				'<th data-hide="all">污泥到达时间</th>' +
				'<th data-hide="all">污泥功能</th>' +
				'<th data-hide="all">处理人号码</th>' +
				'<th data-hide="all">处理污泥车车牌号</th>' +
				'</tr>' +
				'</thead>' +
				'<tbody>'
		var table_end = '</tbody>' +
				'<tfoot>' +
				'<tr>' +
				'<td colspan="5">' +
				'<ul class="pagination pull-right"></ul>' +
				'</td>' +
				'</tr>' +
				'</tfoot>' +
				'</table>'


		$(".form_date").datetimepicker({
			format : "yyyy-mm-dd hh:00",
			language : 'zh-CN',
			weekStart : 1,
			todayBtn : true,
			autoClose : 1,
			startView : 2,
			todayHighlight : 1,
			minView : 1
		});

		$("#driverList").hide()
		$(".form_date").hide()
		$("#submit").hide()

		$("#factory_search").click(function() {
			$("#siteList").show()
			$("#driverList").hide()
			$(".form_date").hide()
			$("#submit").hide()
		})

		$("#driver_search").click(function() {
			$("#siteList").hide()
			$("#driverList").show()
			$(".form_date").hide()
			$("#submit").hide()
		})

		$("#date-search").click(function() {
			$("#siteList").hide()
			$("#driverList").hide()
			$(".form_date").show()
			$("#submit").show()
		})

		$.ajax({
			type : "POST",
			url : "sludge/queryAllSludge",
			success : function(sludgeList) {
				$("#tableDiv").empty()
				var table = table_start
				$.each(sludgeList, function(i, sludge) {
					table += '<tr id="' + sludge.id + '">'
					if (sludge.status == 0) {
						table += '<td class="project-status"><span class="label label-inverse">未到达</td>'
					} else if (sludge.status == 1) {
						table += '<td class="project-status"><span class="label label-primary">已到达</td>'
					} else {
						table += '<td></td>'
					}
					if (sludge.rfidString != null) {
						table += '<td>' + sludge.rfidString + '</td>'
					} else {
						table += '<td class="project-status"><span class="label label-danger">未绑定RFID</td>'
					}
					table += '<td>' + sludge.record.site.siteName + '</td>'
					table += '<td>' + sludge.destinationAddress + '</td>'
					table += '<td class="project-manage">' + sludge.record.car.driver.realname + '</td>'
					table += '<td>' + sludge.weight + '</td>'
					table += '<td class="project-actions">' +
							'<button onclick="javascript:deleteSludge(' + sludge.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delSludgeModel"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
							'<button onclick="javascript:editSludge(' + sludge.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#editSludgeModel"><i class="fa fa-pencil"></i> 编辑 </button>' +
							'</td>'
					table += '<td>' + sludge.produceTime + '</td>'
					table += '<td class="project-manager">' + sludge.arrivalTime + '</td>'
					if (sludge.functionId != 0) {
						table += '<td>' + sludge.sludgeFunction.function + '</td>'
					} else {
						table += '<td></td>'
					}
					table += '<td>' + sludge.record.car.driver.telephone + '</td>'
					table += '<td>' + sludge.record.car.license + '</td>'
					table += '</tr>'

				})
				table += table_end
				$('#tableDiv').append(table)
				$('.footable').footable();

			}
		})


		/*----------------------------------- 搜索全部按钮 ------------------------------------------*/
		$("#all_search").click(function() {
			$.ajax({
				type : "POST",
				url : "sludge/queryAllSludge",
				success : function(sludgeList) {
					$("#tableDiv").empty()
					var table = table_start
					$.each(sludgeList, function(i, sludge) {
						table += '<tr id="' + sludge.id + '">'
						if (sludge.status == 0) {
							table += '<td class="project-status"><span class="label label-inverse">未到达</td>'
						} else if (sludge.status == 1) {
							table += '<td class="project-status"><span class="label label-primary">已到达</td>'
						} else {
							table += '<td></td>'
						}
						if (sludge.rfidString != null) {
							table += '<td>' + sludge.rfidString + '</td>'
						} else {
							table += '<td class="project-status"><span class="label label-danger">未绑定RFID</td>'
						}
						table += '<td>' + sludge.record.site.siteName + '</td>'
						table += '<td>' + sludge.destinationAddress + '</td>'
						table += '<td class="project-manage">' + sludge.record.car.driver.realname + '</td>'
						table += '<td>' + sludge.weight + '</td>'
						table += '<td class="project-actions">' +
								'<button onclick="javascript:deleteSludge(' + sludge.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delSludgeModel"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
								'<button onclick="javascript:editSludge(' + sludge.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#editSludgeModel"><i class="fa fa-pencil"></i> 编辑 </button>' +
								'</td>'
						table += '<td>' + sludge.produceTime + '</td>'
						table += '<td class="project-manager">' + sludge.arrivalTime + '</td>'
						if (sludge.functionId != 0) {
							table += '<td>' + sludge.sludgeFunction.function + '</td>'
						} else {
							table += '<td></td>'
						}
						table += '<td>' + sludge.record.car.driver.telephone + '</td>'
						table += '<td>' + sludge.record.car.license + '</td>'
						table += '</tr>'

					})
					table += table_end
					$('#tableDiv').append(table)
					$('.footable').footable();

				}
			})

		})

		/*----------------------------------- 按工厂搜索按钮 ------------------------------------------*/
		$(".site").click(function() {
			var siteId = this.getAttribute("name")
			$.ajax({
				type : "POST",
				url : "sludge/querySludgeBySiteId?siteId=" + parseInt(siteId),
				dataType : "json",
				contentType : "application/json",
				success : function(sludgeList) {
					$("#tableDiv").empty()
					var table = table_start
					$.each(sludgeList, function(i, sludge) {
						table += '<tr id="' + sludge.id + '">'
						if (sludge.status == 0) {
							table += '<td class="project-status"><span class="label label-inverse">未到达</td>'
						} else if (sludge.status == 1) {
							table += '<td class="project-status"><span class="label label-primary">已到达</td>'
						} else {
							table += '<td></td>'
						}
						if (sludge.rfidString != null) {
							table += '<td>' + sludge.rfidString + '</td>'
						} else {
							table += '<td class="project-status"><span class="label label-danger">未绑定RFID</td>'
						}
						table += '<td>' + sludge.record.site.siteName + '</td>'
						table += '<td>' + sludge.destinationAddress + '</td>'
						table += '<td class="project-manage">' + sludge.record.car.driver.realname + '</td>'
						table += '<td>' + sludge.weight + '</td>'
						table += '<td class="project-actions">' +
								'<button onclick="javascript:deleteSludge(' + sludge.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delSludgeModel"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
								'<button onclick="javascript:editSludge(' + sludge.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#editSludgeModel"><i class="fa fa-pencil"></i> 编辑 </button>' +
								'</td>'
						table += '<td>' + sludge.produceTime + '</td>'
						table += '<td class="project-manager">' + sludge.arrivalTime + '</td>'
						if (sludge.functionId != 0) {
							table += '<td>' + sludge.sludgeFunction.function + '</td>'
						} else {
							table += '<td></td>'
						}
						table += '<td>' + sludge.record.car.driver.telephone + '</td>'
						table += '<td>' + sludge.record.car.license + '</td>'
						table += '</tr>'

					})
					table += table_end
					$('#tableDiv').append(table)
					$('.footable').footable();

				}
			})
		})
		/*----------------------------------- 按司机搜索按钮 ------------------------------------------*/
		$(".driver").click(function() {
			var driverId = this.getAttribute("name")
			$.ajax({
				type : "POST",
				url : "sludge/querySludgeByDriverId?driverId=" + parseInt(driverId),
				success : function(sludgeList) {
					$("#tableDiv").empty()
					var table = table_start
					$.each(sludgeList, function(i, sludge) {
						table += '<tr id="' + sludge.id + '">'
						if (sludge.status == 0) {
							table += '<td class="project-status"><span class="label label-inverse">未到达</td>'
						} else if (sludge.status == 1) {
							table += '<td class="project-status"><span class="label label-primary">已到达</td>'
						} else {
							table += '<td></td>'
						}
						if (sludge.rfidString != null) {
							table += '<td>' + sludge.rfidString + '</td>'
						} else {
							table += '<td class="project-status"><span class="label label-danger">未绑定RFID</td>'
						}
						table += '<td>' + sludge.record.site.siteName + '</td>'
						table += '<td>' + sludge.destinationAddress + '</td>'
						table += '<td class="project-manage">' + sludge.record.car.driver.realname + '</td>'
						table += '<td>' + sludge.weight + '</td>'
						table += '<td class="project-actions">' +
								'<button onclick="javascript:deleteSludge(' + sludge.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delSludgeModel"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
								'<button onclick="javascript:editSludge(' + sludge.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#editSludgeModel"><i class="fa fa-pencil"></i> 编辑 </button>' +
								'</td>'
						table += '<td>' + sludge.produceTime + '</td>'
						table += '<td class="project-manager">' + sludge.arrivalTime + '</td>'
						if (sludge.functionId != 0) {
							table += '<td>' + sludge.sludgeFunction.function + '</td>'
						} else {
							table += '<td></td>'
						}
						table += '<td>' + sludge.record.car.driver.telephone + '</td>'
						table += '<td>' + sludge.record.car.license + '</td>'
						table += '</tr>'

					})
					table += table_end
					$('#tableDiv').append(table)
					$('.footable').footable();

				}
			})
		})
		/*----------------------------------- 按日期搜索按钮 ------------------------------------------*/
		$("#submit").click(function() {
			var startDate = $("#start_date_text").val()
			var endDate = $("#end_date_text").val()
			$.ajax({
				type : "POST",
				url : "sludge/querySludgeByDate?startDate=" + startDate + "&endDate=" + endDate,
				success : function(sludgeList) {
					$("#tableDiv").empty()
					var table = table_start
					$.each(sludgeList, function(i, sludge) {
						table += '<tr id="' + sludge.id + '">'
						if (sludge.status == 0) {
							table += '<td class="project-status"><span class="label label-inverse">未到达</td>'
						} else if (sludge.status == 1) {
							table += '<td class="project-status"><span class="label label-primary">已到达</td>'
						} else {
							table += '<td></td>'
						}
						if (sludge.rfidString != null) {
							table += '<td>' + sludge.rfidString + '</td>'
						} else {
							table += '<td class="project-status"><span class="label label-danger">未绑定RFID</td>'
						}
						table += '<td>' + sludge.record.site.siteName + '</td>'
						table += '<td>' + sludge.destinationAddress + '</td>'
						table += '<td class="project-manage">' + sludge.record.car.driver.realname + '</td>'
						table += '<td>' + sludge.weight + '</td>'
						table += '<td class="project-actions">' +
								'<button onclick="javascript:deleteSludge(' + sludge.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#delSludgeModel"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除 </button>' +
								'<button onclick="javascript:editSludge(' + sludge.id + ');" class="btn btn-white btn-sm" data-toggle="modal" data-target="#editSludgeModel"><i class="fa fa-pencil"></i> 编辑 </button>' +
								'</td>'
						table += '<td>' + sludge.produceTime + '</td>'
						table += '<td class="project-manager">' + sludge.arrivalTime + '</td>'
						if (sludge.functionId != 0) {
							table += '<td>' + sludge.sludgeFunction.function + '</td>'
						} else {
							table += '<td></td>'
						}
						table += '<td>' + sludge.record.car.driver.telephone + '</td>'
						table += '<td>' + sludge.record.car.license + '</td>'
						table += '</tr>'

					})
					table += table_end
					$('#tableDiv').append(table)
					$('.footable').footable();

				}
			})
		})

		/*----------------------------------- 确认修改 ------------------------------------------*/
		$("#saveEditButton").click(function() {
			var sludgeId = $("#sludgeId").val()
			var RFID = $("#editSludgeRFID").val()
			var oriRfid = RFID
			var desAddr = $("#editSludgeDesAddr").val()
			var oriDes = desAddr
			var funcId = parseInt($("#editSludgeFuncId").val())
			if (RFID == '' || RFID == null) {
				RFID = 'none'
			}
			if (desAddr == '' || desAddr == null) {
				desAddr = 'none'
			}
			$.ajax({
				type : "POST",
				url : "sludge/editSludge",
				data : JSON.stringify({
					id : sludgeId,
					rfidString : RFID,
					destinationAddress : desAddr,
					functionId : funcId
				}),
				dataType : "json",
				contentType : "application/json",
				success : function(data) {
					var editSludgeTr = $("#" + sludgeId.toString())
					editSludgeTr.children("td").eq(1).text(oriRfid)
					editSludgeTr.children("td").eq(3).text(oriDes)
					if (funcId == -1) {
						editSludgeTr.children("td").eq(9).text('')
					} else {
						var editFunc = $("#func" + funcId.toString()).text()
						editSludgeTr.children("td").eq(4).text(editFunc)
					}
					alert("修改成功")
					$("#editSludgeModel").modal('hide')

				},
				error : function(data) {
					alert("修改失败")
				}
			})
		})
		/*----------------------------------- 确认删除 ------------------------------------------*/
		$("#deleteButton").click(function() {
			var sludgeId = $("#sludgeId").val()
			var driverName = $("#driverSelect").val()
			var index = parseInt($("#trIndex").val())
			$.ajax({
				type : "POST",
				url : "sludge/deleteSludge?sludgeId=" + parseInt(sludgeId),
				success : function(data) {
					$("#" + sludgeId.toString()).remove()
					$('#delSludgeModel').modal('hide')
				}
			})

		})

	});

	/*----------------------------------- 编辑 ------------------------------------------*/
	function editSludge(sludgeId) {
		var RFID = $("#" + sludgeId.toString()).children("td").eq(1).text()
		var desAddr = $("#" + sludgeId.toString()).children("td").eq(3).text()
		$("#sludgeId").val(sludgeId)
		$("#editSludgeDesAddr").val(desAddr)
		if (RFID != '未绑定RFID') {
			$("#editSludgeRFID").val(RFID)
		} else {
			$("#editSludgeRFID").val('')
		}
	}
	/*----------------------------------- 删除------------------------------------------*/
	function deleteSludge(sludgeId) {
		$("#sludgeId").val(sludgeId)
	}
</script>

</body>

</html>
