<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script> 
<script src="/spring/resources/common/js/paging.js"></script>
<script src="/spring/resources/common/js/Chart.min.js"></script>

</head>
<body>
	<br>
	<p>기본차트</p>
	<div style="width:60%;">
		<canvas id="popChart"  style="display: block; margin-left:100px; width: 514px; height: 257px;"></canvas>
	</div>
	<br>
	<p>라인차트</p>
	
	<div style="width:60%;">
		<canvas id="canvas" class="chartjs-render-monitor" style="display: block; margin-left:100px; width: 514px; height: 257px;"></canvas>
	</div>
	<br>
	<p>원형차트</p>
	
	<div style="width:60%">
		<canvas id="oilChart" style="display: block; margin-left:100px; width: 514px; height: 257px;"></canvas>
	</div>
	<br>
</body>
<script>

/*
 * basic chart sample 
 */
var barChart = new Chart($("#popChart"), {
	  type: 'bar',
	  data: {
	    labels: ["China", "India", "United States", "Indonesia", "Brazil", "Pakistan", "Nigeria", "Bangladesh", "Russia", "Japan"],
	    datasets: [{
	      label: 'Population',
	      data: [1379302771, 1281935911, 326625791, 260580739, 207353391, 204924861, 190632261, 157826578, 142257519, 126451398],
	      backgroundColor: [
	        'rgba(255, 99, 132, 0.6)',
	        'rgba(54, 162, 235, 0.6)',
	        'rgba(255, 206, 86, 0.6)',
	        'rgba(75, 192, 192, 0.6)',
	        'rgba(153, 102, 255, 0.6)',
	        'rgba(255, 159, 64, 0.6)',
	        'rgba(255, 99, 132, 0.6)',
	        'rgba(54, 162, 235, 0.6)',
	        'rgba(255, 206, 86, 0.6)',
	        'rgba(75, 192, 192, 0.6)',
	        'rgba(153, 102, 255, 0.6)'
	      ]
	    }]
	  },
	
	});
	
/* 
font  option
Chart.defaults.global.defaultFontFamily = "Lato"; 
Chart.defaults.global.defaultFontSize = 18;
Chart.defaults.global.defaultFontColor = 'blue';
*/


/* line chart sample 
 * 
 */
	window.chartColors = {
			red: 'rgb(255, 99, 132)',
			orange: 'rgb(255, 159, 64)',
			yellow: 'rgb(255, 205, 86)',
			green: 'rgb(75, 192, 192)',
			blue: 'rgb(54, 162, 235)',
			purple: 'rgb(153, 102, 255)',
			grey: 'rgb(201, 203, 207)'
		};
	

	
	var MONTHS = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
	var config = {
		type: 'line',
		data: {
			labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
			datasets: [{
				label: 'My First dataset',
				backgroundColor: window.chartColors.red,
				borderColor: window.chartColors.red,
				data: [
					1379302771, 1281935911, 326625791, 260580739, 207353391, 204924861, 190632261, 157826578, 142257519, 126451398
				],
				fill: false,
			}, {
				label: 'My Second dataset',
				fill: false,
				backgroundColor: window.chartColors.blue,
				borderColor: window.chartColors.blue,
				data: [
					 126451398,1281935911, 326625791, 260580739,1379302771,204924861, 190632261, 157826578, 142257519, 207353391
				],
			}]
		},
		options: {
			responsive: true,
			title: {
				display: true,
				text: 'Chart.js Line Chart'
			},
			tooltips: {
				mode: 'index',
				intersect: false,
			},
			hover: {
				mode: 'nearest',
				intersect: true
			},
			scales: {
				xAxes: [{
					display: true,
					scaleLabel: {
						display: true,
						labelString: 'Month'
					}
				}],
				yAxes: [{
					display: true,
					scaleLabel: {
						display: true,
						labelString: 'Value'
					}
				}]
			}
		}
	};
	
	var lineChart = new Chart("canvas",config);

/* pie chart sample
 * 
 */
	var oilCanvas = document.getElementById("oilChart");
	
	Chart.defaults.global.defaultFontFamily = "Lato";
	Chart.defaults.global.defaultFontSize = 18;
	
	var oilData = {
	    labels: [
	        "Saudi Arabia",
	        "Russia",
	        "Iraq",
	        "United Arab Emirates",
	        "Canada"
	    ],
	    datasets: [
	        {
	            data: [133.3, 86.2, 52.2, 51.2, 50.2],
	            backgroundColor: [
	                "#FF6384",
	                "#63FF84",
	                "#84FF63",
	                "#8463FF",
	                "#6384FF"
	            ]
	        }]
	};
	 
	var pieChart = new Chart(oilCanvas, {
	  type: 'pie',
	  data: oilData
	}); 
	

</script>
</html>