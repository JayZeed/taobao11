<%@ page language="java" import="dbtaobao.connDb,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
ArrayList<String[]> list = connDb.index_4();
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ECharts 可视化分析淘宝双11</title>
<link href="./css/style.css" type='text/css' rel="stylesheet"/>
<script src="./js/echarts.min.js"></script>
<script type="text/javascript" src="js/china.js" ></script>
</head>
<body>
	<div class='header'>
        <p>ECharts 可视化分析淘宝双11</p>
    </div>
    <div class="content">
        <div class="nav">
            <ul>
                <li><a href="./index.jsp">所有买家各消费行为对比</a></li>
                <li><a href="./index1.jsp">男女买家交易对比</a></li>
                <li><a href="./index2.jsp">男女买家各个年龄段交易对比</a></li>
                <li><a href="./index3.jsp">商品类别交易额对比</a></li>
                <li class="current"><a href="#">各省份的总成交量对比</a></li>
                <li><a href="./index5.jsp">各年龄段交易比例</a></li>
            </ul>
        </div>
        <div class="container">
            <div class="title">各省份的总成交量对比</div>
            <div class="show">
                <div class='chart-type'>地图</div>
                <div id="main"></div>
            </div>
        </div>
    </div>
<script>
</script>
</body>
</html>
<script >
		function randomData() {
			return Math.round(Math.random()*500);
		}
		
	     var mydata = [];
		<%
		int min=99999, max=0;   //记录器，记载最大值和最小值
		for(String[] a:list){
			%>
			var obj =new Object();
			obj.name = "<%=a[0]%>";
		 	<% if (a[0].substring(a[0].length()-1).equals("市"))  //判断是否是直辖市，如上海市/重庆市等
			{
		 	%>
		 		obj.name = "<%=a[0].substring(0,a[0].length()-1)%>";    //把最后的“市”字去掉，方便和地图数据对接
		 	<%
			}
		 	%>
		 	<%
		 	if (Integer.parseInt(a[1]) >  max)  //更新最大值
			     max = Integer.parseInt(a[1]);		
		 	if (Integer.parseInt(a[1]) <  min)  //更新最小值
			     min = Integer.parseInt(a[1]);
			%> 
			obj.value = "<%=a[1]%>";
			mydata.push(obj); 
		<%
		}
		%> 

		var option = {
				backgroundColor: '#FFFFF0',
				color:['#191970'],
				title: {
					text: '全国各省份的总成交量对比',
					x:'center'
				},
				tooltip : {
					trigger: 'item'
				},
				
					visualMap: {
						type: 'continuous', // 连续型
						min: <%=min%>,       		// 值域最小值，必须参数
						max: <%=max%>,			// 值域最大值，必须参数
						calculable: true,	// 是否启用值域漫游
						inRange: {
				             	color: ['#B0C4DE','#191970']
				                             // 指定数值从低到高时的颜色变化
				          },
				        text:['High', 'Low'],
						textStyle: {
							color: '#50a3ba'	// 值域控件的文本颜色
						}
				 },
			 /*  legend: {
				   show:false,
			        x: 'left',
			        data:['成交量']
			    }, */
				series: [{
					name: '成交量',
					type: 'map',
					mapType: 'china', 
					roam: true,
					label: {
						normal: {
							show: false,  //显示省份标签
							textStyle:{color:"#c71585"} //省份标签字体颜色
						},
						emphasis: {
							show: false
						}
					},
					 itemStyle: {
	                        normal: {
	                            borderWidth: .8,//区域边框宽度
	                            borderColor: '#009fe8',//区域边框颜色
	                            areaColor:"#ffefd5",//区域颜色
	                        },
	                        emphasis: {
	                            borderWidth: .5,
	                            borderColor: '#4b0082',
	                            areaColor:"#ffdead",
	                        }
					 }, 
					data:mydata
				}]
			};
			var chart = echarts.init(document.getElementById('main'));
		    chart.setOption(option);
</script>

