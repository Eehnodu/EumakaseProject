var path = document.body.getAttribute('data-cpath');

$.ajax({
    url: `${path}/getEmotion`,
    type: 'POST',
    dataType: 'json',
    success: function(data) {
        console.log('차트 2 데이터 로드 성공');
        
        const labels = Object.keys(data);
        const values = Object.values(data);

        const container = document.getElementById('labelsContainer3');
        const containerData = document.getElementById('labelsContainerData3');
        container.innerHTML = '';
        containerData.innerHTML = '';

        const heading = document.createElement('h4');
        heading.textContent = '내가 자주 느낀 감정';
        container.appendChild(heading);

        labels.forEach((label, index) => {
            const span = document.createElement('span');
            span.textContent = label;
            containerData.appendChild(span);
            if (index < labels.length - 1) {
                containerData.appendChild(document.createElement('br'));
            }
        });
        
        const ctx = document.getElementById('myChart3').getContext('2d');
        new Chart(ctx, {
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
                    legend: false, // Hide the legend
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
    error: function() {
        console.log('차트 2 데이터 로드 실패');
    }
});
