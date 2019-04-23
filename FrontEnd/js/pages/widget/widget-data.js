/**
 *  Document   : widget-data.js
 *  Author     : redstar
 *  Description: script for all widget components.
 *
 **/

"use strict";
$(function(){
	$('#widgetDoctorList').slimScroll({
		height: '365px'
	});
});
Morris.Area({
	element: "area_line_chart",
	behaveLikeLine: true,
	data: [
	       {w: '2011 Q1', x: 2, y: 0, z: 0},
	       {w: '2011 Q2', x: 50, y: 15, z: 5},
	       {w: '2011 Q3', x: 15, y: 50, z: 23},
	       {w: '2011 Q4', x: 45, y: 12, z: 7},
	       {w: '2011 Q5', x: 20, y: 32, z: 55},
	       {w: '2011 Q6', x: 39, y: 67, z: 20},
	       {w: '2011 Q7', x: 20, y: 9, z: 5}
	       ],
	       xkey: 'w',
	       ykeys: ['x', 'y', 'z'],
	       labels: ['X', 'Y', 'Z'],
	       pointSize: 0,
	       lineWidth: 0,
	       resize: true,
	       fillOpacity: 0.8,
	       behaveLikeLine: true,
	       gridLineColor: '#e0e0e0',
	       hideHover: 'auto',
	       lineColors: ['#222222', '#20B2AA', '#6C96D2']
});

Morris.Bar({
	  element: 'bar-example',
	  data: [
	    { y: '2006', a: 100, b: 90 },
	    { y: '2007', a: 75,  b: 65 },
	    { y: '2008', a: 50,  b: 40 },
	    { y: '2009', a: 75,  b: 65 },
	    { y: '2010', a: 50,  b: 40 },
	    { y: '2011', a: 75,  b: 65 },
	    { y: '2012', a: 100, b: 90 }
	  ],
	  xkey: 'y',
	  ykeys: ['a', 'b'],
	  labels: ['Series A', 'Series B'],
	  barColors: ['#4272B1', '#F37E2B']
	});
