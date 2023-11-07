---
marp: true
theme: default
footer: 'FOSS4G Asia 2023'
paginate: true
---

# RGeo: Handling Geospatial Data for Ruby and Ruby on Rails

Taro Matsuzawa
Georepublic Japan

---

# My works

- Georepublic Japan GIS Engineer
- Sub-President, Japan UNIX Society
- Director, OSGeo.JP
- Director, OpenStreetMap Foundation Japan
- Lead of United Nation OpenGIS/7 core

---

# My hobbies

- Breakcore music
- Playing video games
  - JRPGs, 2D shooting games, etc.
- Reading novels
  - Fantasy

---

# My skills

- Ruby / Ruby on Rails
- Python
- PostgreSQL / PostGIS
- JavaScript / TypeScript
  - React Native
  - MapLibre GL JS
  - AWS CDK with TypeScript
- UNIX / Linux

---

# My community works

- Maintainer of [tile.openstreetmap.jp](https://tile.openstreetmap.jp/)
    - A worldwide tile server for OpenStreetMap Japan community.
- Maintainer of [charites](https://github.com/unvt/charites)
    - A set of tools for building Mapbox/MapLibre style.
- Maintainer of [redmine-gtt](https://github.com/gtt-project/redmine_gtt)
    - A plugin for Redmine to add spatial features.
- Contributor of [types-ol-ext](https://github.com/Siedlerchr/types-ol-ext), [redux-persist](https://github.com/rt2zz/redux-persist) and more.

---

# Main topics

## Ruby language is very powerful and simple, and friendly with Geo Data using RGeo.

---

# Today's talk

1. Core concepts and data models of RGeo
2. Basics of manipulating and querying geospatial data
3. Integration with Ruby on Rails and real-world application examples using RGeo

---

# 1. Core concepts and data models of RGeo

---

# What is RGeo?

- RGeo is a geospatial data library for Ruby.
- RGeo provides a set of data classes for representing geospatial data.
- RGeo provides a set of spatial analysis operations and predicates.

---

# RGeo's implementation

- RGeo is a pure Ruby library if GEOS is not available.
- RGeo is a Ruby wrapper of GEOS if GEOS is available.
    - GEOS is a C++ library for manipulating and querying geospatial data.
    - GEOS is a part of OSGeo Foundation.
    - GEOS is used by many geospatial software, such as PostGIS, QGIS, etc.

---

# RGeo's features

- RGeo suppports many geospatial data formats.
    - WKT, WKB, GeoJSON, Shapefile, etc.
- RGeo supports Proj4.
- RGeo supports many spatial analysis operations and predicates.
    - Buffer, Convex Hull, Intersection, Union, etc.

---

# RGeo requirements

- MRI Ruby 2.6.0 or later.
- Partial support for JRuby 9.0 or later. The FFI implementation of GEOS is available (ffi-geos gem required) but CAPI is not.

---

# How to install

```sh
$ apt install libgeos-dev libproj-dev proj-data
```

Then

```sh
$ gem install rgeo
```

or insert the following line into your Gemfile.

```ruby
gem 'rgeo'
```

---

# RGeo extensions

- rgeo-geojson
  - GeoJSON format support
- rgeo-shapefile
  - Shapefile format support
- rgeo-proj4
  - Proj4 support

---


# Ruby on Rails support

- RGeo provides ActiveRecord extensions for Ruby on Rails with PostGIS.
  - https://github.com/rgeo/activerecord-postgis-adapter
  - Mysql / Spatialite ActiveRecord adapter is archived or not maintained.

---

# RGeo's data models

- RGeo supports OGC Simple Features Specification.
- RGeo provides a set of data classes for representing geospatial data.
  - Coordinates, Point, LineString, Polygon, MultiPoint, MultiLineString, MultiPolygon, GeometryCollection, etc.

---

# Coordinates basis

- Coordinates is a set of X, Y(, Z and M) values.

```ruby
require 'rgeo'
factory = RGeo::Cartesian.factory
point = factory.point(1, 2)
point.x # => 1.0
point.y # => 2.0
```

---

# factories

- RGeo implements a lot of factories.
    - Cartesian, Geographic, Geographic Projected, Spherical, etc.
- Cartesian factory is the default factory.

---

# Cartesian factory

```ruby
require 'rgeo'
factory = RGeo::Cartesian.factory
point = factory.point(1, 2)
point.x # => 1.0
point.y # => 2.0
```

implementation will be GEOS::CAPIFactory if GEOS is available.

---

# Ruby Cartesian factory

```ruby
require 'rgeo'
factory = RGeo::Cartesian.simple_factory
point = factory.point(1, 2)
point.x # => 1.0
point.y # => 2.0
```

Create a 2D Cartesian factory using a Ruby implementation.

---

# Spherical Factory

```ruby
require 'rgeo'
factory = RGeo::Geographic.spherical_factory
point = factory.point(1, 2)
point.x # => 1.0
point.y # => 2.0
```

Create a factory that uses a spherical model of Earth when creating and analyzing geometries.

---

# 3D factory

```ruby
require 'rgeo'
factory = RGeo::Geos.factory(has_z_coordinate: true)
point = factory.point(1, 2, 3)
point.x # => 1.0
point.y # => 2.0
point.z # => 3.0
```

Create a 3D factory using GEOS.

---

# 3D Factory (With M-Coordinate)

```ruby
require 'rgeo'
factory = RGeo::Geos.factory(has_z_coordinate: true, has_m_coordinate: true)
```

Create a 3D factory with M-Coordinate using GEOS.

---

# Specify an SRID

```ruby
require 'rgeo'
factory = RGeo::Geos.factory(srid: 4326)
point = factory.point(139.766865, 35.680760) # Tokyo station
```

Create a factory with SRID 4326 using GEOS.

---

# Point

```ruby
require 'rgeo'
factory = RGeo::Geos.factory(srid: 4326)
point = factory.point(139.766865, 35.680760) # Tokyo station
point.x # => 139.766865
point.y # => 35.68076
```

Create a point from coordinates.

---

# working with WKT

```ruby
require 'rgeo'
factory = RGeo::Geos.factory(srid: 4326)
wkt = 'POINT(139.766865 35.680760)'
point = factory.parse_wkt(wkt)
```

Create a point from WKT.

---

# LineString

```ruby
require 'rgeo'
factory = RGeo::Geos.factory
line_string = factory.line_string([
  factory.point(1, 2),
  factory.point(3, 4),
  factory.point(5, 6),
])
```

Create a LineString from points.

