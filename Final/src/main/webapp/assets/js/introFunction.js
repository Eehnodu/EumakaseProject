
// Function to show a specific chart by index
function showChart(index) {
    // Hide all chart and label containers with the class 'plzShow'
    $('.plzShow').hide();
    
    // Display chart and label container at given index
    $('.plzShow').eq(index).show();
}

// Click event handler for previous button
$('#prevChart').click(function() {
    // Index of currently visible chart and label container
    let currentIndex = $('.plzShow:visible').index();
    
    // Calculate the index of the previous chart and label container
    let prevIndex = (currentIndex - 1 + $('.plzShow').length) % $('.plzShow').length;
    
    // Show the chart at the calculated previous index
    showChart(prevIndex);
});

// Click event handler for next button
$('#nextChart').click(function() {
    // Index of currently visible chart and label container
    let currentIndex = $('.plzShow:visible').index();
    
    // Calculate the index of the next chart and label container
    let nextIndex = (currentIndex + 1) % $('.plzShow').length;
    
    // Show the chart at the calculated next index
    showChart(nextIndex);
});

// Initially show the chart at index 0
showChart(0);

