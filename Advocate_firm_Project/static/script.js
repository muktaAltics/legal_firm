const showMessageButton = document.getElementById('showMessageButton');
const message = document.getElementById('message');

showMessageButton.addEventListener('click', () => {
    message.classList.toggle('hidden');
});
