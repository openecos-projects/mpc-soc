(function () {
  const data = window.SOC_DATA;
  const fmtHz = (hz) => hz >= 1000000 ? `${hz / 1000000} MHz` : `${hz / 1000} kHz`;
  const fmt = (value) => value.replace(/^0x([0-9a-f]+)$/i, (_, hex) => `0x${hex.toUpperCase().replace(/([0-9A-F])(?=(?:[0-9A-F]{4})+$)/g, '$1_')}`);
  document.querySelector('#clock').textContent = fmtHz(data.soc.clockHz);
  document.querySelector('#address-width').textContent = `${data.soc.addressWidth} bit`;
  document.querySelector('#data-width').textContent = `${data.soc.dataWidth} bit`;
  document.querySelector('#reset-pc').textContent = fmt(data.soc.resetPc);
  document.querySelector('#region-count').textContent = `${data.regions.length} mapped regions`;

  const ipTable = document.querySelector('#ip-table');
  const renderIps = (query = '') => {
    const q = query.trim().toLowerCase();
    ipTable.innerHTML = data.ips.filter((ip) => !q || Object.values(ip).some((value) => value.toLowerCase().includes(q))).map((ip) => `
      <tr><td>${ip.name}</td><td>${ip.function}</td><td>${ip.address}</td><td>${ip.status}</td><td>${ip.tests}</td><td>${ip.risk}</td></tr>
    `).join('');
  };
  renderIps();
  document.querySelector('#ip-filter').addEventListener('input', (event) => renderIps(event.target.value));

  document.querySelector('#memory-grid').innerHTML = data.regions.map((region) => `
    <article class="memory-card"><span class="kind">${region.kind}</span><small>${region.name}</small><strong>${fmt(region.base)}</strong><p>${region.description || ''} · ${fmt(region.size)}</p></article>
  `).join('');
}());
