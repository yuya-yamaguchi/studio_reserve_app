window.draw_graph = -> 
    ctx = document.getElementById("myChart").getContext('2d')
    myChart = new Chart(ctx, {
        type: "doughnut",
        data: {
            labels:  ["Vo", "Cho", "Gt", "Ba", "Dr", "Key"],
            datasets: [
                {
                    label: "",
                    data: gon.data,
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.8)',
                        'rgba(54, 162, 235, 0.8)',
                        'rgba(255, 206, 86, 0.8)',
                        'rgba(75, 192, 192, 0.8)',
                        'rgba(153, 102, 255, 0.8)',
                        'rgba(255, 159, 64, 0.8)'
                    ],
                    borderColor: [
                        'rgba(255,99,132,1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 0
                }
            ]
        },
        options: {
            responsive: false,
            cutoutPercentage: 70,
            title: {
                display: true,
                fontSize: 20,
                text: "セッション演奏回数"
            },
            legend: {
                position: 'bottom'
            }
        }
    });
# }