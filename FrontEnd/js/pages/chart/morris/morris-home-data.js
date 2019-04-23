/**
 *  Document   : morris-home-data.js
 *  Author     : redstar
 *  Description: Script for morris chart data for home page
 *
 **/
"use strict";
$(function(){
	$('#homeDoctorList').slimScroll({
		height: '352px'
	});
});
$(function(){
	$('#reviewWindow').slimScroll({
		height: '280px'
	});
});

jQuery(document).ready(function() {
	Morris.Line({
        element: 'line_chart',
        data: [{
            period: '2008',
            iphone: 35,
            ipad: 67,
            itouch: 15
        },{
            period: '2009',
            iphone: 140,
            ipad: 189,
            itouch: 67
        },{
            period: '2010',
            iphone: 50,
            ipad: 80,
            itouch: 22
        },{
            period: '2011',
            iphone: 180,
            ipad: 220,
            itouch: 76
        }, {
            period: '2012',
            iphone: 130,
            ipad: 110,
            itouch: 82
        }, {
            period: '2013',
            iphone: 80,
            ipad: 60,
            itouch: 85
        }, {
            period: '2014',
            iphone: 78,
            ipad: 205,
            itouch: 135
        }, {
            period: '2015',
            iphone: 180,
            ipad: 124,
            itouch: 140
        }, {
            period: '2016',
            iphone: 105,
            ipad: 100,
            itouch: 85
        },
        {
            period: '2017',
            iphone: 210,
            ipad: 180,
            itouch: 120
        }
    ],
    xkey: 'period',
    ykeys: ['iphone', 'ipad', 'itouch'],
    labels: ['iPhone', 'iPad', 'iPod Touch'],
    pointSize: 3,
    fillOpacity: 0,
    pointStrokeColors: ['#222222', '#cccccc', '#f96332'],
    behaveLikeLine: true,
    gridLineColor: '#e0e0e0',
    lineWidth: 2,
    hideHover: 'auto',
    lineColors: ['#222222', '#20B2AA', '#f96332'],
    resize: true
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

