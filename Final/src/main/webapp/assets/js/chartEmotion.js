var cpath = document.body.getAttribute('data-cpath');

// AJAX request for getmyemotion
$.ajax({
    url: `${cpath}/getMypage`,
    type: 'POST',
    dataType: 'json',
    success: function(data) {
        console.log('차트 2 데이터 로드 성공');
        const emotionData = data.emotion_data;
        const labels = emotionData.map(item => item.surDesc);
        const values = emotionData.map(item => item.count);

		const container = document.getElementById('labelsContainer3');
		const containerData = document.getElementById('labelsContainerData3');
		container.innerHTML = '';
		containerData.innerHTML = '';
		const heading = document.createElement('h4');
		heading.textContent = '내가 자주 느낀 감정';
		container.appendChild(heading);
        labels.forEach((label, index) => {
            const span = document.createElement('span');
            span.textContent = (index + 1) + ". " + label
            containerData.appendChild(span);
            if (index < labels.length - 1) {
                containerData.appendChild(document.createElement('br'));
            }
        });
        let chartStatus = Chart.getChart('myChart3');
			if (chartStatus !== undefined) {
			  chartStatus.destroy();
			}
        const ctx = document.getElementById('myChart3').getContext('2d');
        new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: labels,
                datasets: [{
                    label: '감정',
                    data: values,
                    backgroundColor: [
                       'rgb(231, 188, 222)',
						'rgb(187, 156, 192)',
						'rgb(103, 114, 157)'
                    ],
                    borderColor: [
                       'rgb(231, 188, 222)',
						'rgb(187, 156, 192)',
						'rgb(103, 114, 157)'
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
        console.log('차트 2 데이터 로드 실패');
         console.log(e);
    }
});
