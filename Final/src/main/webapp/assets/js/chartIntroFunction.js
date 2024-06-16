$(document).ready(function() {
    // Hide all charts and their corresponding label containers in the initial state
    $('.plzShow').hide();

    function showChart(index) {
        console.log(`Display the chart at index ${index}.`);
        $('.plzShow').hide(); // Hide all chart and label containers with the class 'plzShow'
        $('.plzShow').eq(index).show(); // Display chart and label container at given index

        // Additional logic to specifically show emotion chart if index matches
        if (index === 2) { // Assuming emotion chart is at index 2 (adjust as per your structure)
            $('#emotionChart').show();
            $('#topSongsByEmotion').show();
        }
    }

    $('#prevChart').click(function() {
        // Index of currently visible chart and label container
        let currentIndex = $('.plzShow:visible').index();
        console.log(`Current index before prev: ${currentIndex}`);

        // Calculate the index of the previous chart and label container
        let prevIndex = (currentIndex - 1 + $('.plzShow').length) % $('.plzShow').length;

        showChart(prevIndex);
    });

    $('#nextChart').click(function() {
        // Index of currently visible chart and label container
        let currentIndex = $('.plzShow:visible').index();
        console.log(`Current index before next: ${currentIndex}`);

        // Calculate the index of the next chart and label container
        let nextIndex = (currentIndex + 1) % $('.plzShow').length;
        console.log(`Next index: ${nextIndex}`);

        showChart(nextIndex);
    });

    showChart(0); // Initially show the first chart
});