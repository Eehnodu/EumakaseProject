$(document).ready(function() {
    // Initially hide the second chart
    $('#myChart1').hide();
    
    // Show the first chart by default
    $('#myChart').show();
    
    // Set current chart index
    var currentChartIndex = 0;
    
    // Function to show the chart at a given index
    function showChart(index) {
        $('canvas').hide(); // Hide all charts
        $('canvas').eq(index).show(); // Show the chart at the specified index
    }
    
    // Pagination controls
    $('#prevChart').click(function() {
        currentChartIndex = (currentChartIndex - 1 + 2) % 2; // Modulo 2 to handle wrapping around
        showChart(currentChartIndex);
    });
    
    $('#nextChart').click(function() {
        currentChartIndex = (currentChartIndex + 1) % 2; // Modulo 2 to handle wrapping around
        showChart(currentChartIndex);
    });
});
