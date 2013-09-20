# SVG Map - Tile Map Without Javascript
## Taro Matsuzawa @smellman
## Georepublic Japan

---

## Topic
- Introducing myself
- Current Tile Maps
- SVG Map
- Implementation
- Demo

---

## Introducing myself
- Programmer at Georepublic Japan
- Electro Music Lover :-)
- Also *Otaku*

![smellman](./images/smellman.jpg)
![smellman2](./images/smellman_2.jpg)

---

## Community

- Member of Mozilla Community in Japan. Author of two Japanese books about Firefox (Firefox 3 Hacks, Firefox Hacks Rebooted)
- Member of Japan Unix Society
- OpenStreetMap mapper

---

## Georepublic
- [pgRouting](http://pgrouting.org/) Project
- [Geofuse](http://geofuse.georepublic.net/geofuse/) and [Geothematics](http://beta.geothematics.com/)
- Support of FOSS4G, OpenStreetMap and others

---

## Maptember
I enjoy Maptember too much!

![maptember](./images/maptember.jpg)

---

## Notice...
This presentation describes some *proposals* to W3C.

Be careful about it! They are not *standards* yet.

---

# Current Tile Maps

---


## Current Tile Maps
Current Tile Maps on the Web are implemented using Javascript.

- Google Maps
- Leaflet.js
- OpenLayers
- others

---

## Problems with Javascript
Implementations with Javascript have some problems.

- Difference between Javascript engines
- Mobile implementation
- Big Javascript files

---

## Javascript Engines
Sometimes Javascript programmers need to fight with small differences between each engine :-(

- OdinMonkey (Firefox)
- v8 (Blink or Google Chrome)
- JavaScriptCore (Webkit or Safari)
- Chakra (Internet Explorer)

Goodbye *Opera*.

---

## Mobile Implementations
Mobile devices don't have powerful CPU.

---

I lied.

![apple](./images/iphone64bit.jpg)

---

But *too many* mobile devices don't have powerful CPU.

![firefoxos](./images/devices.jpg)

---

iOS doesn't support JIT in applications (UIWebView).

Only Mobile Safari supports JIT.

---

## Big JS File

- Google Maps's HTML file (including javascript) > 200kb.
- Openlayers.min.js > 300kb. (but openlayers.mobile.js is small)
- Leaflet.js < 100kb :-)

It's nothing compared to loading map data, but sometimes loading big Javascript files causes memory leaks.

---

Tile Maps with Javascript can cause troubles, but *time heals all wounds*.

However we can try *another approach*.

---

# SVG Map

---

SVG Map is a technology implementation for Tile Maps using SVG.

Lots of specifications have been developed by Satoru Takagi, who is working for KDDI (a famous mobile carrier in Japan).

---

## History
SVG Map has a long history.

- The basic technology of Tile Map goes back to 1996, developed by KDDI.
- They focused on research and development of what was named "JaMaPS", already before SVG technology came up.
- They started Standardization activity at W3C SVG Working Group in 2000.

---

## W3C SVG 1.1

SVG 1.1 includes some results of their acitivity.

- Geographic coordinate systems: [http://www.w3.org/TR/SVG/coords.html#GeographicCoordinates](http://www.w3.org/TR/SVG/coords.html#GeographicCoordinates)

---

## SVG Tiny 1.2

They developed the "Tiling and Layering Module for SVG 1.2 Tiny" specification and submitted it as "W3C Member Submission".

- Tiling and Layering Module for SVG 1.2 Tiny: [http://www.w3.org/Submission/2011/SUBM-SVGTL-20110607/](http://www.w3.org/Submission/2011/SUBM-SVGTL-20110607/)

---

## SVGTL

This module uses an *animation* tag, but it's not useful.

So they now work on some new proposals.

---

## New Proposals

The Tiling and Layering Module was seperated from one into two proposals, and it now uses *iframe* tag instead of *animation* tag.

- IFrame Like Syntax: [http://www.w3.org/Graphics/SVG/WG/wiki/Proposals/IFrame\_Like\_Syntax](http://www.w3.org/Graphics/SVG/WG/wiki/Proposals/IFrame_Like_Syntax)
- Global Coordinate System: [http://www.w3.org/Graphics/SVG/WG/wiki/Proposals/Global\_Coordinate\_Systems](http://www.w3.org/Graphics/SVG/WG/wiki/Proposals/Global_Coordinate_Systems)

The basic concept is in large parts similar to the SVG 1.2 Tiny version.

---

## IFrame Like Syntax

IFrame Like Syntax supports 

- *Tiling* function and 
- *Layering* function.

---

## Tiling

A Root SVG Document contains tiled SVG Documents with IFrame, and each tiled SVG Document also contains tiled SVG Documents again, and so on ... (cascading documents).

![tiling](./images/700px-PIFLS_tiling.png)

---

## Layering

The contained layers of each SVG document are displayed depending on viewbox and zoom level.

![layering](./images/550px-PIFLS_layering.png)

The zooming function uses an extended CSS3 Media Query, defined in this proposal.

---

## Tiling and Layering example

Root.svg

	&lt;iframe x="0" y="0" width="200" height="200"
	        media="(min-zoom: 0.5) and (max-zoom: 5)"
	        src="L1.svg" /&gt;
	&lt;iframe x="0" y="0" width="200" height="200"
	        media="(min-zoom: 5) and (max-zoom: 15)"
	        src="L2.svg" /&gt;

The zooming function works with extended CSS3 Media Queries.

This example will display either L1.svg or L2.svg depending on zoom level.

When no media attribute is declared, the layer will be always shown.

---

L1.svg

	&lt;iframe x="0" y="0" width="100" height="100"
	        src="L1_01.svg" /&gt;
	&lt;iframe x="100" y="0" width="100" height="100"
	        src="L1_02.svg" /&gt;
	&lt;iframe x="0" y="100" width="100" height="100"
	        src="L1_11.svg" /&gt;
	&lt;iframe x="100" y="100" width="100" height="100"
	        src="L1_12.svg" /&gt;

L1_01.svg

	&lt;image xlink:href="L1_01.png" /&gt;

L1.svg contains 4 IFrames, tiled and ordered.

---

L2.svg

	&lt;iframe x="0" y="0" width="100" height="100"
	        src="L2_01.svg" /&gt;
	&lt;iframe x="100" y="0" width="100" height="100"
	        src="L2_02.svg" /&gt;
	&lt;iframe x="0" y="100" width="100" height="100"
	        src="L2_11.svg" /&gt;
	&lt;iframe x="100" y="100" width="100" height="100"
	        src="L2_12.svg" /&gt;

L2.svg looks like L1.svg.

---

L2_01.svg

	&lt;iframe x="0" y="0" width="50" height="50"
	        src="L2_01_01.svg" /&gt;
	&lt;iframe x="50" y="0" width="50" height="50"
	        src="L2_01_02.svg" /&gt;
	&lt;iframe x="0" y="50" width="50" height="50"
	        src="L2_01_11.svg" /&gt;
	&lt;iframe x="50" y="50" width="50" height="50"
	        src="L2_01_12.svg" /&gt;

L2\_01\_01.svg

	&lt;image xlink:href="L2_01_01.png" /&gt;

Layer 2 contains 4 times 4 (= 16) SVG Documents.

---

## Layer1 figure

![layer1](./images/layer1.jpg)

---

## Layer2 figure

![layer2](./images/layer2.jpg)

---

## Dynamic Loading

The browser decides, which documents to load with CSS3 Media Queries and view-port.

A loaded document will be cached in the browser.

![tile](./images/tile.gif)

---

## Global Coordinate System

SVG provides support for geographic coordinates.

However, we need to simplify an implementation, using a specific geographic coordinate system.

---

*Global Coordinate System* provides a function to share a coordinate system by declearing a common coordinate system between plural documents.

![globalcoordinatesystem](./images/globalcoordinatesystem1.jpg)

	&lt;?xml version="1.0"?&gt;
	&lt;svg xmlns="http://www.w3.org/2000/svg"&gt;
	  &lt;GlobalCoordinateSystem id="gcs"
	  transform="matrix(100,0,0,-100,0,0)"
	  href="http://purl.org/crs/84"/&gt;
	 .....The actual content.....
	&lt;/svg&gt;

---

## Attributes

- href="&lt;URL for Global Coordinate System&gt;"

This attribute specifies the global coordinates system of the SVG document. Therefor it is an identifier for a coordinate system. 

- transform = "&lt;transform-list&gt;" | "none"

This transform attribute specifies the conversion parameters from global coordinate system to user coordinate system of the document. 

---

## Transform

![globalcoordinatesystem2](./images/matrix_0.jpg)

- Xs: X coordinate of SVG user coordinate system
- Ys: Y coordinate of SVG user coordinate system
- Xg: X coordinate of global coordinate system
- Yg: Y coordinate of global coordinate system
- a , b , c , d , e , f: The applicable values of parameters (SVG transform(a,b,c,d,e,f) ) 

When transform is not declared, use transform(1,0,0,1,0,0) as a default.

---

## Calculate Coordinate Example

	&lt;globalCoordinateSystem
	  id="gcs"
	  href="http://purl.org/crs/84"
	  transform="matrix(3555.5555555555557,0.0,0.0,
	  -3555.5555555555557,-490000.0,130125.82802869406)" /&gt;
	 &lt;g &gt;
	  &lt;image xlink:href="http://ecn.t0.tiles.virtualearth.net/
	    tiles/r133002100000.jpeg?g=849&amp;mkt=ja-JP&amp;shading=hill"
	    preserveAspectRatio="none" x="0" y="0"
	    width="312.5" height="251.002021"/&gt;

---

- a: 3555.5555555555557
- b: 0.0
- c: 0.0
- d: -3555.5555555555557
- e: -490000.0
- f: 130125.82802869406
- Xs: 0
- Ys: 0

![matrix_1](./images/matrix_1.jpg)

---

## script

	def parse(args)
	  a = args[0]
	  b = args[1]
	  c = args[2]
	  d = args[3]
	  e = args[4]
	  f = args[5]
	  xs = args[6]
	  ys = args[7]
	  ma = Matrix[[a, c],
	              [b, d]]
	  v = Vector[xs - e,
	             ys - f]
	  ret = ma.inv*v
  	  p ret
  	  p "#{ret[1]},#{ret[0]}"
	end


---

## Result

	$ ruby convert_matrix.rb 3555.5555555555557 \
	0.0 0.0 -3555.5555555555557 -490000.0 \
	130125.82802869406 0 0
	Vector[137.8125, 36.597889133070204]
	"36.597889133070204,137.8125"

---

## Browser Behavior

No browser behavior, such as drag scrolling and zooming with mouse wheel, is defined in this specification.

Browsers may provide basic behavior and other controls, such as zoom bars, that appear on a web page.

---

## Summary

- Tile Map's basic function is provided by SVG Iframe.
- Coordinate system is provided by GlobalCoordinateSystem.
- Browser behavior is not defined.

---

# Implementation

---

Both, SVG Tiny 1.2 and Iframe proposal, have been implemented on many browsers.

- Internet Explorer SVG Plugin
- AJAX
- Chrominum
- Firefox add-on
- Firefox Native

---

## Internet Explorer SVG Plugin

It's called *svgmaptoolkit*.

Supports Windows Vista (32bit), Windows XP, Windows 2000.

You can download from [SVG MAP Lab](http://blog.svg-map.com/2007/09/svgmaptoolkit.html).

---

# AJAX

Animation tag version (SVG Tiny 1.2 SVGTL) is available.

Basic functions are implemented using Javascript.

It supports many *modern* browsers.

You can access from [SVG Map developer information](http://svg2.mbsrv.net/devinfo/).

---

## Chrominum version

Developed by KDDI partner.

It supports the IFrame proposal and GlobalCoordinateSystem.

We don't know the current status and where the patches are on internet :-(

---

## Firefox add-on

Animation tag version (SVG Tiny 1.2 SVGTL) available.

It is based on AJAX implementation.

All code is available on Github: [https://github.com/Georepublic/svgmap_addon](https://github.com/Georepublic/svgmap_addon).

---

## Firefox Native

Iframe implementation is difficult in Firefox add-on, because Iframe in SVG is not avaliable and can't access the DOM tree. Also Firefox OS dosen't support add-on/extension.

We tried an implementation, but it currently doesn't work.

All code is also available on Github: [https://github.com/Georepublic/mozilla-central](https://github.com/Georepublic/mozilla-central).

---

![firefox1](./images/firefox_1.jpg)

---

# Demo

---

- [AJAX Version National Park + Bing (http://svg2.mbsrv.net/devinfo/devkddi/lvl0/test8b.html)](http://svg2.mbsrv.net/devinfo/devkddi/lvl0/test8b.html)
- [Bing Maps SVG Version (http://svg2.mbsrv.net/extmaps/BingMap/ContainerBing.svg)](http://svg2.mbsrv.net/extmaps/BingMap/ContainerBing.svg)

---

# Plan

---

I will continue the native implmentation for Firefox.

I will submit an issue in bugzilla.

---

## Thank you

Please contact me:

- Taro Matsuzawa: *taro@georepublic.co.jp*

Link:

- This presentation: [http://smellman.github.io/presentation/svgmap/index.html](http://smellman.github.io/presentation/svgmap/index.html)
- SVG Map developer information: ([http://svg2.mbsrv.net/devinfo/](http://svg2.mbsrv.net/devinfo/)

