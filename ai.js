exports.handler = async (event) => {
  if (event.httpMethod !== "POST") return { statusCode: 405, body: "Method Not Allowed" };
  try {
    const { question } = JSON.parse(event.body || "{}");
    if (!question || question.length > 1000) return { statusCode: 400, body: JSON.stringify({answer:"Pertanyaan tidak valid."}) };
    const key = process.env.OPENAI_API_KEY;
    if (!key) return { statusCode: 200, body: JSON.stringify({answer:"Layanan Al Khoir AI belum diaktifkan oleh admin. Silakan hubungi pengurus Masjid Jami' Al Khoir."}) };
    const model = process.env.OPENAI_MODEL || "gpt-4.1-mini";
    const instructions = `Kamu adalah Al Khoir AI, asisten resmi website Masjid Jami' Al Khoir, Jetak, Klitik, Geneng, Ngawi, Jawa Timur. Jawab dalam Bahasa Indonesia dengan sopan, ringkas, informatif, dan jangan mengarang fakta khusus masjid. Data yang diketahui: nama Masjid Jami' Al Khoir; alamat HC9R+VHJ, Jetak, Klitik, Kec. Geneng, Kabupaten Ngawi, Jawa Timur 63271; email admin masjidalkhoirgandu@gmail.com dan rizkiku255@gmail.com. Untuk jadwal shalat arahkan ke halaman beranda karena jadwal diperbarui otomatis. Untuk nomor telepon, rekening donasi, jadwal acara, atau data yang belum tersedia, katakan bahwa informasi tersebut perlu diperbarui admin. Jangan memberikan fatwa seolah-olah kamu mufti; untuk pertanyaan agama yang kompleks, sarankan merujuk ustaz/ulama.`;
    const response = await fetch("https://api.openai.com/v1/responses", {
      method:"POST",
      headers:{"Content-Type":"application/json","Authorization":`Bearer ${key}`},
      body:JSON.stringify({model,input:[{role:"developer",content:instructions},{role:"user",content:question}],max_output_tokens:500})
    });
    const data = await response.json();
    if (!response.ok) throw new Error(data.error?.message || "AI error");
    const answer = data.output_text || data.output?.flatMap(x=>x.content||[]).map(x=>x.text||"").join("") || "Maaf, saya belum menemukan jawaban.";
    return {statusCode:200,headers:{"Content-Type":"application/json","Cache-Control":"no-store"},body:JSON.stringify({answer})};
  } catch (e) {
    return {statusCode:500,headers:{"Content-Type":"application/json"},body:JSON.stringify({answer:"Maaf, Al Khoir AI sedang mengalami gangguan. Silakan coba lagi."})};
  }
};
