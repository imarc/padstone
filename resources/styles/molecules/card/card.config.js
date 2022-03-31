module.exports = {
    collated: true,
    collator: (markup, item) =>
        `<div style="margin: 0 3rem 3rem">
            <div style="margin-bottom: 1.5rem">${item.label}</div>
            ${markup}
         </div>`,
}
