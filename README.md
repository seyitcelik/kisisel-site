# Kişisel Web Sitesi

Seyit Zeyni ÇELİK'in tek sayfalık kişisel web sitesi.

- **Teknolojiler:** yalnızca HTML ve CSS
- **Yayın:** GitHub Pages

## Dosyalar

| Dosya | Açıklama |
|-------|----------|
| `index.html` | Sayfanın içeriği |
| `style.css` | Sayfanın görünümü |
| `push.sh` | Projeyi GitHub'a gönderir |
| `deploy.sh` | Projeyi gönderir ve GitHub Pages'te yayınlar |

## Kullanım

Gereksinimler: [Git](https://git-scm.com) ve [GitHub CLI](https://cli.github.com) (`gh auth login` ile giriş yapılmış olmalı).
Windows'ta betikler Git Bash içinde çalıştırılır.

```bash
# Yalnızca GitHub'a göndermek için
./push.sh "commit mesajı"

# Gönderip yayınlamak için
./deploy.sh "commit mesajı"
```

Yayınlanan site adresi: `https://KULLANICI_ADI.github.io/kisisel-site/`
