module.exports = {
    label: 'Call to Action Section',
    variants: [
        ...['-secondary', '-lightGray']
            .map(name => ({ name, label: name, context: { class: name } })),
    ],
}
