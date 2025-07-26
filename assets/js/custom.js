(async () => {
  const viewCount = document.querySelector("[data-view-count]");
  if (viewCount) {
    let count = '';
    try {
      const response = await fetch("http://backstage.atsui.click/counters/1");
      const counter = await response.json();

      count = counter.count ?? 0;
    } catch (err) {
      console.log(err);
    }
    viewCount.innerHTML = count;
  }
})();
