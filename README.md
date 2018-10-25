<div>
  <h1 align="center">Translit</h1>
  <h3 align="center"><img src="data/icons/64/com.github.artemanufrij.translit.svg"/><br>Translit is a method of encoding Cyrillic letters with Latin ones</h3>
  <p align="center">Designed for <a href="https://elementary.io"> elementary OS</p>
</div>

[![Build Status](https://travis-ci.org/artemanufrij/translit.svg?branch=master)](https://travis-ci.org/artemanufrij/translit)

### Donate
<a href="https://www.paypal.me/ArtemAnufrij">PayPal</a> | <a href="https://liberapay.com/Artem/donate">LiberaPay</a> | <a href="https://www.patreon.com/ArtemAnufrij">Patreon</a>

<p align="center">
  <a href="https://appcenter.elementary.io/com.github.artemanufrij.translit">
    <img src="https://appcenter.elementary.io/badge.svg" alt="Get it on AppCenter">
  </a>
</p>
<p align="center">
  <img src="screenshots/Screenshot.png"/>
</p>

## Install from Github.

As first you need elementary SDK
```
sudo apt install elementary-sdk
```

Install dependencies
```
sudo apt install libgtkspell3-3-dev
```

Clone repository and change directory
```
git clone https://github.com/artemanufrij/translit.git
cd translit
```

Compile, install and start Translit on your system
```
meson build --prefix=/usr
cd build
sudo ninja install
com.github.artemanufrij.translit
```
