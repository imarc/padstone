import { watch } from 'vue'

export default function useStorage (ref, key, defaultValue, storage = localStorage) {
    if (Object.prototype.hasOwnProperty.call(storage, key)) {
        const value = storage.getItem(key)
        ref.value = value === 'undefined' ? undefined : JSON.parse(value)
    }

    watch(ref, value => storage.setItem(key, JSON.stringify(value)))
}
