# iTunes Music Player
A simple music player app that uses iTunes API to search for songs, albums, artists and play them.

## Basic Setup
```bash
# generate localizations files
flutter gen-l10n

# run pub runner build_runner 
# - to generate injectable files
flutter packages pub run build_runner build --delete-conflicting-outputs  
```
## Features 
- [x] Search for songs, albums, artists
- [x] play/pause/seek/10s forward/10s backward
- [x] Dark mode
- [x] Localizations
- [x] Dependency injection

## Resources
### API
[iTunes API](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/Searching.html)

### APK
[Download](resources/app-release.apk)

### Demo
<img src="resources/demo.gif" style="display: block; margin-left: auto; margin-right: auto; width: 30%;"/>

### Light mode
<div style="display: grid; grid-template-columns: repeat(2, 1fr); grid-gap: 20px;">
  <img src="resources/light1.jpg" alt="light1"/>
  <img src="resources/light2.jpg" alt="light2"/>
  <img src="resources/light3.jpg" alt="light3"/>
  <img src="resources/light4.jpg" alt="light4"/>
</div>

### Dark mode
<div style="display: grid; grid-template-columns: repeat(2, 1fr); grid-gap: 20px;">
  <img src="resources/dark1.jpg"  alt="dark1"/>
  <img src="resources/dark2.jpg"  alt="dark2"/>
  <img src="resources/dark3.jpg"  alt="dark3"/>
  <img src="resources/dark4.jpg"  alt="dark4"/>
</div>




