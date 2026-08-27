# Masjid Jami' Al Khoir — Website V2

Versi ini diperbaiki menjadi **multi-page**, bukan satu halaman yang hanya melakukan scroll.

## Halaman publik
- `index.html` — Beranda + jadwal shalat + quotes harian
- `profil.html`
- `sejarah.html`
- `kegiatan.html`
- `galeri.html`
- `idul-fitri.html`
- `idul-adha.html`
- `virtual-tour.html`
- `donasi.html`
- `kontak.html`
- `lokasi.html`
- `ai.html` — halaman khusus Al Khoir AI
- `admin.html` — dashboard pengurus

Setiap menu berpindah ke halaman sendiri. URL pendek seperti `/donasi`, `/ai`, `/admin`, `/profil`, dan lainnya juga disiapkan di `netlify.toml`.

## Al Khoir AI
UI chat sudah benar-benar ada. Backend berada di `netlify/functions/ai.js`.

Di Netlify tambahkan environment variable:
- `OPENAI_API_KEY`
- opsional `OPENAI_MODEL`

Tanpa `OPENAI_API_KEY`, UI tetap tampil tetapi AI akan memberi pesan bahwa layanan belum diaktifkan.

## Admin
Admin yang diizinkan:
- masjidalkhoirgandu@gmail.com
- rizkiku255@gmail.com

Untuk sinkronisasi lintas perangkat:
1. Buat project Supabase.
2. Jalankan `supabase.sql`.
3. Aktifkan Email/Password di Supabase Auth.
4. Buat akun untuk kedua email.
5. Isi `assets/config.js` dengan Supabase URL dan anon/public key.
6. Deploy ulang ke Netlify.

Admin dapat:
- login
- menambah kegiatan
- mengunggah banyak foto per kegiatan
- menghapus kegiatan
- mengubah sejarah
- mengubah kontak
- mengubah informasi donasi
- mengubah URL virtual tour

## Media sosial
YouTube: https://www.youtube.com/channel/UCeHeaqIW7b83CpAAXQmpbfw
Instagram: https://instagram.com/masjidalkhoirgandu
Facebook: https://m.facebook.com/Masjid%20Al%20Khoir%20Dadapan/
TikTok: https://www.tiktok.com/@masjid.alkhoir

## Catatan desain
Latar tidak lagi satu warna. V2 memakai beberapa layer gradient, ornamen geometris, image frame, glass navigation, cards, shadow, typography serif/display, responsive layout, floating AI button, dan animasi halus.
