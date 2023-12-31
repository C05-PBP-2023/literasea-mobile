# [Literasea](https://literasea.live)

![Staging badge](https://github.com/C05-PBP-2023/literasea-mobile/actions/workflows/staging.yml/badge.svg)
![Pre-release badge](https://github.com/C05-PBP-2023/literasea-mobile/actions/workflows/pre-release.yml/badge.svg)
![Release badge](https://github.com/C05-PBP-2023/literasea-mobile/actions/workflows/release.yml/badge.svg)
![MS App Center badge](https://build.appcenter.ms/v0.1/apps/ee53c95c-cd4f-4467-bb06-3085334376c9/branches/main/badge)

# Dive into knowledge, sail with Literasea! 📖⛵

## Aplikasi
Aplikasi dapat diunduh melalui bagian [releases](https://github.com/C05-PBP-2023/literasea-mobile/releases) atau melalui [link ini](https://install.appcenter.ms/orgs/C05-Literasea/apps/Literasea/distribution_groups/public) pada Microsoft App Center.

## Anggota Kelompok C05

- [Muhammad Nabil Mu'afa](https://github.com/nabilmuafa) (2206024972)
- [Tsabit Coda Rafisukmawan](https://github.com/codaaa19) (2206081414)
- [Ariana Nurlayla Syabandini](https://github.com/ariananurlayla) (2206081950)
- [Emir Mohamad Fathan](https://github.com/brofathan) (2206081982)
- [Lim Bodhi Wijaya](https://github.com/LimBodhi) (2206082410)

## Filosofi Literasea: Menyelami Lautan Pengetahuan

Nama Literasea berasal dari kata “literasi” yang berarti kemampuan individu dalam mengolah informasi dan pengetahuan untuk kecakapan hidup, serta kata “sea” yang berarti lautan, yang dalam hal ini dianggap sebagai lautan pengetahuan. Literasea bagaikan sebuah kapal yang membawa pengguna berlayar melintasi luasnya lautan pengetahuan yang akan membuka jalan bagi kebijaksanaan dan kecakapan hidup. Dalam setiap halaman yang dibaca, kami mengajak pengguna untuk memulai “petualangan” untuk menjelajahi dalamnya lautan pengetahuan. Literasea diharapkan mampu membantu pengguna untuk meningkatkan minat dan kebiasaan literasinya.

Literasea merupakan aplikasi toko buku digital yang menyediakan berbagai buku berkualitas dengan pengalaman literasi yang menyenangkan. Aplikasi ini dilengkapi dengan berbagai fitur, seperti katalog buku berkualitas, fitur QnA, dan _review_ buku yang memungkinkan pengguna untuk saling berbagi dan berdiskusi mengenai buku-buku yang mereka baca.

Aplikasi ini dilengkapi dengan berbagai fitur yang memudahkan pengguna untuk menemukan buku yang mereka inginkan. Berikut beberapa layanan yang tersedia dalam Literasea:

- Katalog (Explore) menampilkan kumpulan data buku yang tersedia. Pengguna dapat melihat detail buku, seperti judul, nama penulis, _publisher_ buku, ISBN, dan tahun terbit. Pengguna juga dapat melakukan filter terhadap katalog buku berdasarkan penulis, penerbit, dan tahun terbit.
- Keranjang (Cart) memungkinkan pengguna untuk mengumpulkan buku yang ingin dibeli dari katalog. Buku yang telah dibeli dari keranjang akan masuk ke dalam _list_ buku yang dimiliki pengguna tersebut dan pengguna dapat melihat histori pembelian yang pernah dilakukannya.
- QnA (Q & A) memungkinkan pengguna untuk membuat pertanyaan mengenai suatu buku. Pertanyaan tersebut dapat dijawab oleh pengguna yang memiliki _role_ penulis.
- Review (Review) buku memungkinkan pengguna untuk memberikan _review_ buku dan mungkin secara tidak langsung dapat memberikan rekomendasi kepada pengguna lain.
- Book Tracker (Tracker) memungkinkan pengguna untuk menyimpan halaman yang terakhir dari buku yang dibaca olehnya.

Manfaat dari aplikasi ini adalah sebagai berikut:

- Menyediakan koleksi buku yang berkualitas
- Fitur yang memudahkan pengguna untuk menemukan buku yang diminati dan menyimpannya
- Wadah untuk berbagi dan berdiskusi mengenai buku dan literasi, dengan fitur QnA dan Review
- Dapat membantu meningkatkan minat dan kebiasaan literasi

## Daftar Modul

### 📚 Katalog Buku (Explore)

**Dikerjakan oleh Lim Bodhi Wijaya**

Pada fitur ini, pengguna dapat melihat katalog buku yang ada di Literasea. Pengguna dapat melihat detail buku, seperti judul, nama penulis, _publisher_ buku, ISBN, dan tahun terbit. Pengguna dapat melakukan filter terhadap katalog buku berdasarkan tahun terbit dan penerbit. Selain melihat buku yang tersedia, pengguna juga dapat menambahkan buku yang ingin dibeli ke keranjang.

Berikut aksi yang dapat dilakukan masing-masing _role_:
| Pengguna/Pembaca | Penulis |
| ---------------- | ------- |
| Pengguna dapat melihat katalog buku dan mencari buku yang diinginkan berdasarkan filter tahun terbit dan nama penerbit. Selain itu pengguna juga dapat menambahkan buku yang ingin dibeli ke keranjang | Penulis dapat menambahkan bukunya kedalam katalog |

### 🛒 Keranjang Buku (Cart)

**Dikerjakan oleh Emir Mohamad Fathan**

Pada fitur keranjang buku, pengguna dapat memilih buku-buku pada yang tersedia di katalog dan memasukkannya ke keranjang. Pengguna dapat melakukan pembelian atau _checkout_ terhadap buku-buku yang diinginkan. Pengguna juga dapat menghapus suatu buku dari keranjang. Selain itu, pengguna melihat histori pembelian yang berisi informasi-informasi pembelian, seperti nama pembeli, alamat tujuan, tanggal pembelian, dan judul dari buku-buku yang dibeli pada histori pembelian.

| Pengguna/Pembaca                                                              | Penulis              |
| ----------------------------------------------------------------------------- | -------------------- |
| Pengguna dapat melakukan pembelian terhadap buku-buku pilihannya di keranjang | Sama seperti pembaca |

### ❓ QnA/Forum (Q & A)

**Dikerjakan oleh Muhammad Nabil Mu'afa**

Pada fitur ini, pengguna dapat membuat pertanyaan mengenai suatu buku, baik dari segi cerita maupun dari sisi lainnya mengenai buku (misalnya dari sisi pembuatan, dsb). Pertanyaan tersebut dapat dijawab oleh pengguna yang memiliki _role_ penulis. Meskipun penulis tersebut bukanlah penulis dari buku yang ditanyakan, penulis diasumsikan memiliki pengetahuan lebih dalam memahami suatu buku sehingga dapat dipercaya dalam menjawab pertanyaan yang berkaitan dengan buku.

| Pengguna/Pembaca                                                | Penulis                                                                             |
| --------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| Membuat pertanyaan mengenai suatu buku yang terdapat di katalog | Bertanya dan menjawab pertanyaan yang ditanyakan oleh pengguna mengenai buku apapun |

### ⭐ Review (Review)

**Dikerjakan oleh Tsabit Coda Rafisukmawan**

Kami percaya bahwa alasan seseorang untuk membeli buku itu didasari oleh berbagai macam faktor. Faktor-faktor tersebut dapat berupa faktor internal maupun eksternal. Melalui hal tersebut, pengguna dapat melakukan diskusi dan mendapatkan sebuah konklusi bahwa rekomendasi serta _review_ dari orang lain merupakan salah satu faktor eksternal yang sangat berpengaruh dalam pembelian buku. Oleh karena itu, kami menyediakan fasilitas rekomendasi dan _review_ buku untuk para pembaca setia kami.

| Pengguna/Pembaca                                                                                | Penulis              |
| ----------------------------------------------------------------------------------------------- | -------------------- |
| Pembaca dapat memberikan _review_ dengan jumlah bintang serta pesan singkat terhadap suatu buku | Sama seperti pembaca |

### 📖 Book Tracker (Tracker)

**Dikerjakan oleh Ariana Nurlayla Syabandini**

Fitur Book Tracker memungkinkan pengguna untuk melihat kembali bacaan terakhir yang telah dibaca sebelumnya. Dengan fitur ini, pengguna dapat dengan mudah menemukan nama buku dan halaman terakhir yang mereka baca, memudahkan pengguna untuk melanjutkan bacaannya dari halaman yang ditinggalkan sebelumnya.

| Pengguna/Pembaca                                 | Penulis                                              |
| ------------------------------------------------ | ---------------------------------------------------- |
| Pengguna dapat melihat kembali histori bacaannya | Sayangnya, penulis belum bisa memanfaatkan fitur ini |

### Dataset

Literasea akan memanfaatkan dataset [Book Recommendation Dataset](https://www.kaggle.com/datasets/arashnic/book-recommendation-dataset) yang tersedia pada [Kaggle](https://www.kaggle.com/). Selain karena _field_ yang dimiliki dataset ini tidak terlalu banyak, dataset ini dipilih karena memiliki salah satu _field_ berupa gambar buku yang terdapat pada link. Dengan ini, halaman katalog Literasea juga bisa menampilkan foto buku.

### Jenis Pengguna (_Role_)

Pada aplikasi kami, terdapat dua jenis pengguna:

- Pembaca
- Penulis

Penjelasan lebih spesifik mengenai masing-masing jenis pengguna dan wewenangnya pada aplikasi terdapat pada penjelasan masing-masing modul.

### Alur Pengintegrasian dengan Aplikasi Web

Pada proses pengintegrasian antara Django dengan Flutter, kami akan melakukan beberapa hal berikut:

1. Menambahkan package/library `http` kepada proyek agar aplikasi dapat berinteraksi dengan aplikasi web.
2. Menggunakan model autentikasi berupa _login_, _logout_, dan _registrasi_ yang telah dibuat pada TK sebelumnya agar bisa memberikan user otorisasi yang sesuai peran _user_ sebagai _reader_ atau _writer_.
3. Memanfaatkan package/library `pbp_django_auth` untuk mengelola _cookie_ sehingga segala macam _request_ yang dikirimkan ke server merupakan _request_ yang terautentikasi dan terotorisasi.
4. Membuat _class_ Katalog pada Flutter dengan memanfaatkan API _dataset_ buku yang telah dibuat dengan menggunakan `literasea.live/products/get_books/` sebagai _endpoint_-nya, serta memanfaatkan 'https://app.quicktype.io/' untuk mengubah data JSON menjadi objek Dart yang akan digunakan untuk membuat kelas Katalog pada Flutter.

### Berita Acara Kelompok C05

Berita acara kelompok C05 apat diakses pada [link berikut](https://univindonesia-my.sharepoint.com/:x:/g/personal/lim_bodhi_office_ui_ac_id/Eej-FVVSQbBEjB5jrycJdEMBp2A9MC09iIRfUpTur9V2Rg).
