# SmartMetric CRM Case

> Mini CRM uygulaması – [Flutter](https://flutter.dev) ile hazırlanmış.  

---

## 📌 Özet

Bu proje, müşteri yönetimi senaryolu bir **CRM uygulaması**dır.  
Giriş, listeleme, arama, filtreleme, detay gösterme gibi temel akışlarda UI/UX ve kod kalitesini öne çıkaracak şekilde tasarlandı.

Kullanılan teknolojiler:
- **Flutter / Dart**
- **Bloc / Cubit** state management
- **Auto Route** (navigasyon)
- **Dio** (HTTP client)
- **Light / Dark tema desteği**
- **Mock veri** (assets/mocks)
- **Localization (easy_localization)** → Çoklu dil desteği

---

## 🚀 Özellikler

- **Login / Signup** (mock)
- **Müşteri Listesi** (scroll + pagination)
- **Arama & Filtreleme**
- **Müşteri Detay** (bilgiler, aktiviteler, notlar)
- **Not Ekleme & Aktivite Planlama**
- **Tema Desteği (Light/Dark)**
- **Hata / Yükleniyor / Boş Durum yönetimi**

---

## 📸 Ekran Görüntüleri

### Auth & Home
| Login | Signup | Home (Light) |
|-------|--------|--------------|
| <img src="https://github.com/user-attachments/assets/5f152531-b618-4281-b6d2-ca92b0d0e3d5" width="250"/> | <img src="https://github.com/user-attachments/assets/45a52a34-22f6-4b01-a033-e1b4c3dd776b" width="250"/> | <img src="https://github.com/user-attachments/assets/e54750bb-5f70-48a1-94e4-5864b62f9690" width="250"/> |

### Arama & Detay
| Search | Company Search | Detail |
|--------|----------------|--------|
| <img src="https://github.com/user-attachments/assets/76474a95-38e4-4241-a5d6-b58bb0d0c6b7" width="250"/> | <img src="https://github.com/user-attachments/assets/50603bbf-6835-4e12-bc1f-b2f1c12b3787" width="250"/> | <img src="https://github.com/user-attachments/assets/35398ff5-7097-4cc1-b93e-63dc6878db1e" width="250"/> |

| General | Active |
|---------|--------|
| <img src="https://github.com/user-attachments/assets/2ac7a5f3-e86a-421b-ad37-e82a2286e56e" width="250"/> | <img src="https://github.com/user-attachments/assets/732f5165-1872-487b-8a9e-43a29eb0da73" width="250"/> | |

---

## ⚙️ Kurulum & Çalıştırma

```bash
git clone https://github.com/yukseelalkis/smartmetric_case.git
cd smartmetric_case
flutter pub get
flutter run
