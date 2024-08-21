module.exports = {
    order: 2,
    preview: '@contained',
    collated: true,
    collator: (markup, item) =>
        `<div style="margin-bottom: 3rem">
            <div style="margin-bottom: 1.5rem">
                ${item.label}
                <code style="color: inherit; opacity: .5">
                    ${item.classname || item.isDefault ? '' : `-${item.name}`}
                </code>
            </div>
            ${markup}
         </div>`,
}
