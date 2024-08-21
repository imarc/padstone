module.exports = {
    order: 1,
    label: 'Base',
    variants: [
        ...['-primary', '-secondary', '-lightGray']
            .map(name => ({ name, label: name, context: { class: name } })),
    ],
}
