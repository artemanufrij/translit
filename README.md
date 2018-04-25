<div>
  <h1 align="center">Translit</h1>
  <h3 align="center"><img src="data/icons/com.github.artemanufrij.translit.svg"/><br>Translit is a method of encoding Cyrillic letters with Latin ones</h3>
  <p align="center">Designed for <a href="https://elementary.io"> elementary OS</p>
</div>

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

Clone repository and change directory
```
git clone https://github.com/artemanufrij/translit.git
cd translit
```

Compile, install and start Translit on your system
```
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr ..
sudo make install
com.github.artemanufrij.translit
```
