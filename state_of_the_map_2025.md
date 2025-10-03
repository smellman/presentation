---
marp: true
theme: default
footer: 'State of the Map 2025 Manila'
paginate: true
backgroundColor: #fff
backgroundImage: url('https://marp.app/assets/hero-background.svg')
---

# OpenStreetMap Sound Demo

## Taro Matsuzawa ([@smellman](https://x.com/smellman))

### State of the Map 2025 Manila

---

## Self introduction

- GIS Engineer at Geolonia
- Director, OSGeo.JP
- Director, OpenStreetMap Foundation Japan
  - Maintainer of tile.openstreetmap.jp
- Lead Engineer for the United Nations OpenGIS/7 Core
- Breakcore cluster
- Newbie with StreetComplete

![bg right 80%](https://avatars.githubusercontent.com/u/135112?v=4)

---

## What is OpenStreetMap Sound Demo?

- Demonstration website: Buildings that dance with OpenStreetMap building data and music
  - Original demo from Mapbox
    - Ref: https://docs.mapbox.com/mapbox-gl-js/example/dancing-buildings/
- Using the Web Audio API to play music and calculate building heights
- All music by OthermanRecords

---

## Demo

![QR Code](https://smellman.github.io/osm-sound-demo/qr.png)

https://smellman.github.io/osm-sound-demo/

---

## Tech Stack
### https://github.com/smellman/osm-sound-demo/blob/main/src/main.ts

- [Vite](https://vite.dev/) + [TypeScript](https://www.typescriptlang.org/)
- [MapLibre](https://maplibre.org/)
  - Using building data from tile.openstreetmap.jp
  - Using Location API to get current location
  - Using PMTiles to reduce load
- User interface built with [Bootstrap](https://getbootstrap.com/)
- Web Audio API for audio processing

---

## OthermanRecords
### https://www.otherman-records.com/

- OthermanRecords is an independent online label run by Othermoon, who has been involved in breakcore for over 20 years.
- This label releases all music under a CC-BY license and distributes it via archive.org

---

## Scraping OthermanRecords
### https://github.com/smellman/osm-sound-demo/blob/main/src/otherman-records.ts

- OthermanRecords exposes a JSON API.
  - The JSON API is used to build a website with Nuxt.js
- I analyzed it **on my own without permission**.

---

## Supports CORS
### https://github.com/smellman/archive-org-proxy

- Most music on archive.org has CORS disabled.
- I developed a proxy server with Python to bypass CORS.

---

## VJ mode

- VJ mode reacts to any music.
  - macOS: use Loopback.app
    - Music.app(or other audio source) -> Loopback.app -> Browser
  - Linux: use Pipewire
- Moves to a random location every 60 seconds.

---

## Want to try it?

![QR Code](https://smellman.github.io/osm-sound-demo/qr.png)

https://smellman.github.io/osm-sound-demo/

## Thank you!
