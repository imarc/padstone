import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import fractal from './fractal.config.js'

const path = require('path')

export default defineConfig(async ({ command }) => {
    const config = {
        plugins: [vue()],
        build: {
            manifest: true,
            outDir: 'web/dist',
            assetsDir: '.',
            rollupOptions: {
                input: 'resources/js/main.js',
            },
        },
        resolve: {
            alias: {
                vue: 'vue/dist/vue.esm-bundler.js',
                '@resources': path.resolve(__dirname, 'resources'),
            },
        },
    }

    if (command === 'serve') {
        fractal.set('viteServer', true)
        const server = fractal.web.server({ sync: true })
        await server.start()

        config.server = {
            hmr: {
                protocol: 'ws',
            },
            proxy: {
                '^(?!/(resources|node_modules|@vite|@id|__vite_ping)).*': {
                    target: server.url,
                },
            },
        }
    }

    return config
})
