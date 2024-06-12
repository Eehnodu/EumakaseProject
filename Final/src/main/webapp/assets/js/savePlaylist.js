document.addEventListener("DOMContentLoaded", function() {
    const saveLink = document.getElementById("savePlaylistLink");
    if (saveLink) {
        saveLink.addEventListener("click", function(event) {
            event.preventDefault(); // 기본 동작 방지

            const videoUrlInput = document.getElementById("video-url");
            const videoUrlValue = videoUrlInput.value;

            // 폼을 생성하고 제출
            const form = document.createElement("form");
            form.method = "post";
            form.action = `${cpath}/savePlaylist`;

            const hiddenField = document.createElement("input");
            hiddenField.type = "hidden";
            hiddenField.name = "video-url";
            hiddenField.value = videoUrlValue;
            
            form.appendChild(hiddenField);
            document.body.appendChild(form);
            form.submit();
        });
    }
});
