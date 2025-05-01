import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import vitrine from '@imarc/vitrine'

export default defineConfig({
  build: {
    manifest: true,
    rollupOptions: {
      input: [
        './resources/styles/index.scss',
        './resources/js/index.js',
        './public/main-icons-sprite.svg',
      ],
    },
  },
  plugins: [
    vue(),
    vitrine({
      basePaths: [

        /**
         * This should be set to the base directory for your front end files.
         */
        'resources',
      ],
      includes: [
        /**
         * These are the entry points to include. These will also need to get
         * included into your project.
         */
        '/resources/js/index.js',
      ],
    }),
  ],
  resolve: {
    alias: {
      'vue': 'vue/dist/vue.esm-bundler.js'
    }
  },
  server: {
    cors: true,
    origin: 'https://padstone.imarc.io'
  }
})
