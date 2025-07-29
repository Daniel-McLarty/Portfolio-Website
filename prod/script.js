/*
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
  SOFTWARE.*/
document.getElementById("contact-form").addEventListener("submit",async function(e){e.preventDefault();const t=e.target,n=document.getElementById("form-status"),s=t.querySelector('button[type="submit"]');s.disabled=!0,s.textContent="Sending…";const o=new FormData(t);try{const e=await fetch("https://formsubmit.co/ajax/c743fe687f0a129fd73d56f9f8673d07",{method:"POST",headers:{Accept:"application/json"},body:o}),a=await e.json();e.ok&&"true"===a.success?(t.reset(),n.style.display="block",n.textContent="✅ Message sent! I will respond as quick as I can.",n.style.color="#66ff66",n.tabIndex=-1,n.focus(),s.textContent="Send",s.disabled=!1,setTimeout(()=>n.style.display="none",6e3)):(n.style.display="block",n.textContent="❌ Submission failed: "+(a.message||"Unknown error"),n.style.color="#ff6666",n.tabIndex=-1,n.focus(),s.textContent="Send",s.disabled=!1,setTimeout(()=>n.style.display="none",6e3))}catch(e){n.style.display="block",n.textContent="❌ Submission failed. Check your connection or email manually.",n.style.color="#ff6666",n.tabIndex=-1,n.focus(),s.textContent="Send",s.disabled=!1,setTimeout(()=>n.style.display="none",6e3)}});