const cpath = document.body.getAttribute('data-cpath');
$.ajax({
    url: `${cpath}/chartjs`,
    type: 'POST',
    dataType: 'json',
    success: function(data) {
        console.log('성공');

        // Extract keys and values from data object
        const labels = Object.keys(data); // Extracting genre names as labels
        const values = Object.values(data); // Extracting genre counts as values
		 console.log(labels);
		 console.log(values);
        var ctx = document.getElementById('myChart').getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: labels,
                datasets: [{
                    label: '장르',
                    data: values,
                    backgroundColor: [	
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                let label = context.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed !== null) {
                                    label += context.parsed + '개'; // Displaying count instead of percentage
                                }
                                return label;
                            }
                        }
                    }
                }
            }
        });
    },
    error: function() {
        console.log('실패');
    }
});