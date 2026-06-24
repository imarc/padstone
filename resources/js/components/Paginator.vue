<template>
    <nav v-if="totalPages" class="pagination" aria-label="Pagination">
        <ul class="pagination__list">
            <li v-if="!onFirstPage" class="pagination__item">
                <a class="pagination__link" :href="makeUrl(currentPage - 1)" @click.prevent="previous" aria-label="Previous">
                    <svg class="link__icon" viewBox="0 0 24 24" stroke-width="3" stroke="currentColor" fill="none"><polyline points="15 6 9 12 15 18" /></svg>
                </a>
            </li>

            <li v-for="p in pages" :key="p" class="pagination__item">
                <span v-if="p === parseInt(currentPage)" class="pagination__current" :aria-label="`Page ${p}`" aria-current="page" v-text="p"></span>
                <a v-else-if="p !== '...'" class="pagination__link" :href="makeUrl(p)" @click.prevent="gotoPage(p)" :aria-label="`Page ${p}`" v-text="p"></a>
                <span v-else class="pagination__skip">…</span>
            </li>

            <li v-if="!onLastPage && totalPages > 1" class="pagination__item">
                <a class="pagination__link link"  :href="makeUrl(currentPage.value + 1)" @click.prevent="next" aria-label="Next">
                    <svg class="link__icon" viewBox="0 0 24 24" stroke-width="3" stroke="currentColor" fill="none"><polyline points="9 6 15 12 9 18" /></svg>
                </a>
            </li>
        </ul>
    </nav>
</template>
<script setup>
import { defineModel, defineProps, defineEmits, computed, nextTick } from 'vue';

const currentPage = defineModel({
    default: 1,
    required: true,
});

const props = defineProps({
    totalElements: { 
        type: Number,
        required: true 
    },
    test: {
        required: true 
    },
    perPage: { 
        type: Number,
        required: true 
    },
    radius: {
        type: Number,
        default: 2 
    },
    pageParameter: {
        type: String,
        default: 'page' 
    }
});

const onFirstPage = computed(() => parseInt(currentPage.value) === 1);

const totalPages = computed(() => Math.ceil(props.totalElements / props.perPage));

const onLastPage = computed(() => parseInt(currentPage.value) >= totalPages.value);

const pages = computed(() => {
  const totalPages = Math.ceil(props.totalElements / props.perPage);
  const radius = props.radius;
  
  function generatePages(total, current, radius) {
    const pages = [];
    for (let i = 1; i <= total; i++) {
      if (i === 1 || i === total || (i >= current - radius && i <= current + radius)) {
        pages.push(i);
      } else if (pages[pages.length - 1] !== '...') {
        pages.push('...');
      }
    }
    return pages;
  }

  return generatePages(totalPages, parseInt(currentPage.value), radius);
});

function gotoPage(num) {
  currentPage.value = parseInt(num);
  window.history.replaceState({}, '', makeUrl(num));
  nextTick(() => {
    scrollToTop();
  });
}

function previous() {
  gotoPage(parseInt(currentPage.value) - 1);
}

function next() {
  gotoPage(parseInt(currentPage.value) + 1);
}

function scrollToTop() {
  if ('scrollRestoration' in history) {
    history.scrollRestoration = 'manual';
  }
  window.scrollTo(0, 0);
}

const makeUrl = (num) => {
    let { searchParams } = new URL(location.href);
    if (currentPage.value === 1) {
      searchParams.delete(props.pageParameter);
    } else {
      searchParams.set(props.pageParameter, num);
    }

    const urlStr = searchParams.toString();
    return urlStr.length ? '?' + urlStr : location.pathname;
};
</script>
