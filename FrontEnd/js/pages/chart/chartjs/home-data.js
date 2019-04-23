/**
 *  Document   : home-data.js
 *  Author     : redstar
 *  Description: Script for chartjs data for deshboard 1
 *
 **/
"use strict";
$(document).ready(function() {
    var MONTHS=["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    var config= {
        type:'line', data: {
            labels:["January", "February", "March", "April", "May", "June", "July"], datasets:[ {
                label: "New Patients", backgroundColor: window.chartColors.red, borderColor: window.chartColors.red, data: [randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor()], fill: false,
            }
            , {
                label: "Old Patients", fill: false, backgroundColor: window.chartColors.blue, borderColor: window.chartColors.blue, data: [randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor()],
            }
            ]
        }
        , options: {
            responsive:true, title: {
                display: true, text: 'HOSPITAL SURVEY'
            }
            , tooltips: {
                mode: 'index', intersect: false,
            }
            , hover: {
                mode: 'nearest', intersect: true
            }
            , scales: {
                xAxes:[ {
                    display:true, scaleLabel: {
                        display: true, labelString: 'Month'
                    }
                }
                ], yAxes:[ {
                    display:true, scaleLabel: {
                        display: true, labelString: 'Patients'
                    }
                }
                ]
            }
        }
    }
    ;
    var ctx=document.getElementById("chartjs_line").getContext("2d");
    window.myLine=new Chart(ctx, config);
}

);
$(document).ready(function() {
	var randomScalingFactor = function() {
        return Math.round(Math.random() * 100);
    };

    var config = {
        type: 'doughnut',
        data: {
            datasets: [{
                data: [
                    randomScalingFactor(),
                    randomScalingFactor(),
                    randomScalingFactor(),
                    randomScalingFactor(),
                    randomScalingFactor(),
                ],
                backgroundColor: [
                    window.chartColors.red,
                    window.chartColors.orange,
                    window.chartColors.yellow,
                    window.chartColors.green,
                    window.chartColors.blue,
                ],
                label: 'Dataset 1'
            }],
            labels: [
                "Red",
                "Orange",
                "Yellow",
                "Green",
                "Blue"
            ]
        },
        options: {
            responsive: true,
            legend: {
                position: 'top',
            },
            title: {
                display: true,
                text: 'Doughnut Chart'
            },
            animation: {
                animateScale: true,
                animateRotate: true
            }
        }
    };

        var ctx = document.getElementById("chartjs_doughnut").getContext("2d");
        window.myDoughnut = new Chart(ctx, config);
    
	});