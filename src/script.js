/*!@license
  MIT License

  Copyright (c) 2025 Daniel McLarty

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
*/

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
