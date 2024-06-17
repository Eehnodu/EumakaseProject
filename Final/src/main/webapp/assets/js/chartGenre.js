var cpath = document.body.getAttribute('data-cpath');
$.ajax({
    url: `${cpath}/getMypage`,
    type: 'POST',
    dataType: 'json',
    success: function(data) {
        console.log('차트 0 데이터 로드 성공');
        const genreData = data.genre_data;
        const labels = genreData.map(item => item.surDesc);
        const values = genreData.map(item => item.count);

        const container = document.getElementById('labelsContainer1');
        const containerData = document.getElementById('labelsContainerData1');
        container.innerHTML = '';
        containerData.innerHTML = '';

        const heading = document.createElement('h4');
        heading.textContent = '내가 즐겨들은 장르';
        container.appendChild(heading);

        labels.forEach((label, index) => {
            const span = document.createElement('span');
            span.textContent = label;
            containerData.appendChild(span);
            if (index < labels.length - 1) {
                containerData.appendChild(document.createElement('br'));
            }
        });
         let chartStatus = Chart.getChart('myChart1');
			if (chartStatus !== undefined) {
			  chartStatus.destroy();
			}
        const genre = document.getElementById('myChart1').getContext('2d');
        new Chart(genre, {
            type: 'doughnut',
            data: {
                labels: labels,
                datasets: [{
                    label: '장르',
                    data: values,
                    backgroundColor: [
                        'rgb(253, 252, 220)',
                        'rgb(254, 217, 183)',
                        'rgb(240, 113, 103)'
                    ],
                    borderColor: [
                        'rgb(253, 252, 220)',
                        'rgb(254, 217, 183)',
                        'rgb(240, 113, 103)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: false,
                rotation: -90,
                circumference: 180,
                plugins: {
                    legend: false,
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                let label = context.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed !== null) {
                                    label += context.parsed + '개';
                                }
                                return label;
                            }
                        }
                    }
                }
            }
        });
    },
    error: function(e) {
        console.log('차트 0 데이터 로드 실패');
        console.log(e);
        
    }
});
