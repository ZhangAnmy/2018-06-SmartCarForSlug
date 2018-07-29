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
<title>实时监控</title>
     <meta charset="UTF-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1.0" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" >
    <meta name="renderer" content="webkit">
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico">
    <link href="css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css?v=4.1.0" rel="stylesheet">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<link href="css/plugins/dataTables/dataTables.bootstrap.css"
	rel="stylesheet">
<link href="css/plugins/chosen/chosen.css" rel="stylesheet">
<style>
.body {
	height: 100%;
}

.search-content {
	margin-top: 2%;
	height: 36px;
}

.search-right {
	width: 50%;
	float: right;
}

.search-left {
	width: 50%;
	float: left;
}

.add-site-btn {
	padding: 1 1;
	float: left;
}

.query-site-btn {
	padding: 1px;
	float: right;
}

.col-sm-12 {
	top: auto;
}

.td {
	width: 400px;
}

.form-group {
	bottom: 5px;
}

.box2 {
	width: 100px;
	float: center;
	display: inline;
	border: inherit 1px solid;
}

.box3 {
	width: 100px;
	float: center;
	display: inline;
	border: inherit 1px solid;
}
</style>
</head>

<body>
    <!-- 人员列表 -->
	<!-- Example Pagination -->
	<div class="row" id="videoList">
		<c:forEach items="${requestScope.videoList }" var="video">
			<div class="col-sm-4" style="height:220px">
				<div class="contact-box" id="${video.id }">
					<div id="videoList">
						<video class="box5" id="myPlayer" poster="" controls playsInline webkit-playsinline autoplay>
					    <source src="${video.video_RTMPid}" type="" />
						<source src="${video.video_HLSid}" type="application/x-mpegURL" />
						</video>
					</div>
					<div class="divlicense">
						<img class="box5" alt="140x140" src="img/littercar.png" width="10%" height="10%" />
						<p class="box6" style="text-align:center;">${video.car.license}</p>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>		
</body>

<!-- 全局js -->
    <script src="js/jquery.min.js?v=2.1.4"></script>
    <script src="js/bootstrap.min.js?v=3.3.6"></script>
    <script src="js/plugins/metisMenu/jquery.metisMenu.js"></script>
    <script src="js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
    <script src="js/plugins/layer/layer.min.js"></script>

    <!-- 自定义js -->
    <script src="js/hAdmin.js?v=4.1.0"></script>
    <script type="text/javascript" src="js/index.js"></script>

    <!-- 第三方插件 -->
    <script src="js/plugins/pace/pace.min.js"></script>
    
    <script>
    var player = new EZUIPlayer('myPlayer');
    player.on('error', function(){
        console.log('error');
    });
    player.on('play', function(){
        console.log('play');
    });
    player.on('pause', function(){
        console.log('pause');
    });
    
     </script>
</html>
