module.exports = {
    context: {
        controls: `
            <button class="button -outline" onclick="localStorage.setItem('example-alert', false); location.reload()">reset</button>
        `,
    },
}
