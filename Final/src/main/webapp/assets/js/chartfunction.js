$(document).ready(function() {
    // Hide the second and third charts and their corresponding label containers in the initial state
    $('#secondLabelsContainer').hide();
    $('#thirdLabelsContainer').hide();

    // Function to display the chart corresponding to the given index
    function showChart(index) {
        console.log(`Display the chart at index ${index}.`);
        $('canvas').hide(); // Hide all charts
        $('canvas').eq(index).show(); // Display chart at given index
    }

    // Function to display the label container corresponding to the given index
    function showLabelsContainer(index) {
        console.log(`Display the label container at index ${index}.`);
        $('.showLabelsContainer').hide(); // Hide all label containers
        $('.showLabelsContainer').eq(index).show(); // Display label container at given index
    }

    // Pagination control
    $('#prevChart').click(function() {
        // Index of currently visible chart and label container
        let currentIndex = $('canvas:visible').index('canvas');
        console.log(`Current index before prev: ${currentIndex}`);
        
        // Calculate the index of the previous chart and label container
        let prevIndex = (currentIndex - 1 + 3) % 3;
        console.log(`Previous index: ${prevIndex}`);
        
        // Show previous chart and label container
        showChart(prevIndex);
        showLabelsContainer(prevIndex);
    });

    $('#nextChart').click(function() {
        // Index of currently visible chart and label container
        let currentIndex = $('canvas:visible').index('canvas');
        console.log(`Current index before next: ${currentIndex}`);
        
        // Calculate the index of the next chart and label container
        let nextIndex = (currentIndex + 1) % 3;
        console.log(`Next index: ${nextIndex}`);
        
        // Display next chart and label container
        showChart(nextIndex);
        showLabelsContainer(nextIndex);
    });

    // Display first chart and corresponding label container in initial state
    showChart(0);
    showLabelsContainer(0);
});
