document.getElementById('contact-form').addEventListener('submit', async function (e) {
  e.preventDefault();

  const form = e.target;
  const status = document.getElementById('form-status');

  const submitBtn = form.querySelector('button[type="submit"]');
  submitBtn.disabled = true;
  submitBtn.textContent = 'Sending…';

  const data = new FormData(form);

  try {
    const response = await fetch("https://formsubmit.co/ajax/c743fe687f0a129fd73d56f9f8673d07", {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: data
    });

    const result = await response.json();

    if (response.ok && result.success === "true") {
      // Message accepted AND marked successful
      form.reset();
      status.style.display = "block";
      status.textContent = "✅ Message sent! I will respond as quick as I can.";
      status.style.color = '#66ff66';
      status.tabIndex = -1;
      status.focus();
      submitBtn.textContent = 'Send';
      submitBtn.disabled = false;
      setTimeout(() => status.style.display = "none", 6000);
    } else {
      // FormSubmit responded but something's wrong
      status.style.display = "block";
      status.textContent = "❌ Submission failed: " + (result.message || "Unknown error");
      status.style.color = "#ff6666";
      status.tabIndex = -1;
      status.focus();
      submitBtn.textContent = 'Send';
      submitBtn.disabled = false;
      setTimeout(() => status.style.display = "none", 6000);
    }
  } catch (error) {
    status.style.display = "block";
    status.textContent = "❌ Submission failed. Check your connection or email manually.";
    status.style.color = "#ff6666";
    status.tabIndex = -1;
    status.focus();
    submitBtn.textContent = 'Send';
    submitBtn.disabled = false;
    setTimeout(() => status.style.display = "none", 6000);
  }
});
