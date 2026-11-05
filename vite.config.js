import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import vitrine from '@imarc/vitrine'

export default defineConfig({
  // Craft serves web/ directly; copying it into its own dist/ would duplicate the site.
  publicDir: false,
  build: {
    manifest: true,
    outDir: './web/dist',
    emptyOutDir: true,
    rollupOptions: {
      input: [
        './resources/styles/index.scss',
        './resources/js/index.js',
        './web/main-icons-sprite.svg',
      ],
    },
  },
  plugins: [
    vue(),
    vitrine({
      outDir: './web',
      manifestDir: './web/dist/.vite',
      assetBase: '/dist/',
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
        '/resources/styles/index.scss',
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
    allowedHosts: ['.imarc.io', '.imarc.host'],
    cors: {
      origin: [
        /^https?:\/\/(?:(?:[^:]+\.)?localhost|127\.0\.0\.1|\[::1\])(?::\d+)?$/,
        /^https?:\/\/[^.]+\.imarc\.(io|host)$/,
      ],
    },
    origin: 'https://padstone.imarc.io'
  }
})
