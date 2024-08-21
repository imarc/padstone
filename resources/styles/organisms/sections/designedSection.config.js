module.exports = {
    label: 'Designed Section',
    variants: [
        ...['-primary', '-secondary', '-lightGray']
            .map(name => ({ name, label: name, context: { class: name } })),
    ],
}
