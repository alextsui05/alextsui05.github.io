(async () => {
  const backstageUrl = document.querySelector('meta[name="backstage-url"]')?.getAttribute('content')
  if (!backstageUrl) {
    return;
  }

  const viewCount = document.querySelector("[data-view-count]");
  if (viewCount) {
    let count = '';
    try {
      const response = await fetch(`${backstageUrl}/counters/1`);
      const counter = await response.json();

      count = counter.count ?? 0;
    } catch (err) {
      console.log(err);
    }
    viewCount.innerHTML = count;
  }
})();
