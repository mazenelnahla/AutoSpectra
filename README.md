# Auto Spectra
![Auto Spectra](https://github.com/mazenelnahla/AutoSpectra/blob/main/Preview/1.engine-not-running.png)
![Auto Spectra](https://github.com/mazenelnahla/AutoSpectra/blob/main/Preview/2.no-alert.png)
![Auto Spectra](https://github.com/mazenelnahla/AutoSpectra/blob/main/Preview/3.engine-not-running-spotify-on.png)
![Auto Spectra](https://github.com/mazenelnahla/AutoSpectra/blob/main/Preview/4.autopilot-on.png)
![Auto Spectra](https://github.com/mazenelnahla/AutoSpectra/blob/main/Preview/5.dynamic-speed-color.png)
![Auto Spectra](https://github.com/mazenelnahla/AutoSpectra/blob/main/Preview/6.fota.png)
## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Dependencies](#dependencies)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgements](#acknowledgements)

## Introduction

The Auto Spectra Instrument Cluster is a Qt Quick application designed for automotive use. It provides a modern, interactive interface for displaying various vehicle parameters and diagnostics. This project leverages the power of Qt Quick to deliver a responsive and visually appealing user experience.

## Features

- Real-time display of vehicle metrics and diagnostics.
- Customizable widgets and layouts.
- Smooth animations and transitions.
- Support for different screen resolutions.
- Integration with Python for advanced data processing and control.
- UDP communication for JSON data exchange.
- Support for displaying and controlling Spotify playback.
- Bluetooth device connected to the vehicle.

## Installation

### Prerequisites

Ensure you have the following installed:

- Qt 5.15
- C++ compiler
- Python 3.8 (for additional scripting)
- Raspberry Pi 3 and up (or any DevBoard), this project tested on pi 4 and pi 5

### Steps

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/autospectra-instrument-cluster.git

2. Navigate to the project directory:
   ```bash
    cd autospectra-instrument-cluster

uncomment dist in source
   ```bash
    sudo nano /etc/apt/sources.list
```
3. Install dependencies:
    ```bash
    sudo apt-get update
    sudo apt-get dist-upgrade
    sudo reboot -h now
    sudo apt-get build-dep -y qt5-qmake libqt5gui5 libqt5webengine-data libqt5webkit5
    sudo apt-get install libudev-dev libinput-dev libts-dev libxcb-xinerama0-dev libxcb-xinerama0 gdbserver
    sudo apt-get install libasound2-dev libpulse-dev gstreamer1.0-omx libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev  gstreamer1.0-alsa
    sudo apt-get install libgeoclue-2-dev libdbus-glib-1-dev libgudev-1.0-dev libbluetooth-dev
    sudo apt-get install libudev-dev libinput-dev libts-dev libmtdev-dev libjpeg-dev libfontconfig1-dev libssl-dev libdbus-1-dev libglib2.0-dev libxkbcommon-dev libegl1-mesa-dev libgbm-dev libgles2-mesa-dev mesa-common-dev xcb libxcb-xkb-dev x11-xkb-utils libx11-xcb-dev libxkbcommon-x11-dev libwayland-dev
    sudo apt install build-essential cmake unzip pkg-config gfortran
    sudo apt build-dep qt5-qmake libqt5gui5 libqt5webengine-data libqt5webkit5 libudev-dev libinput-dev libts-dev libxcb-xinerama0-dev libxcb-xinerama0 gdbserver
    sudo apt install libxcb-randr0-dev libxcb-xtest0-dev libxcb-shape0-dev libxcb-xkb-dev
    sudo apt install libjpeg-dev libpng-dev libtiff-dev
    sudo apt install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
    sudo apt install libxvidcore-dev libx264-dev
    sudo apt install libopenal-data libsndio7.0 libopenal1 libopenal-dev pulseaudio
    sudo apt install bluez-tools
    sudo apt install libbluetooth-dev
    sudo apt install libgstreamer1.0-0 gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio
    sudo apt install libgstreamer1.0-dev  libgstreamer-plugins-base1.0-dev
    sudo apt install qtbase5-dev qtdeclarative5-dev qtmultimedia5-dev qtconnectivity5-dev
    sudo apt-get install qt5-qmake qtbase5-dev qtdeclarative5-dev libqt5gui5 libqt5quick5 qml-module-qtquick2 qtvirtualkeyboard-plugin
    sudo apt-get install qtbase5-dev qtdeclarative5-dev libqt5quick5 qtquickcontrols2-5-dev qtvirtualkeyboard-plugin
    sudo apt install qtcreator
    sudo apt install build-essential libgl1-mesa-dev libpulse-dev
    sudo apt-get install libqt5serialport5-dev
    sudo apt-get install libqt5multimedia5-plugins qml-module-qtmultimedia
    sudo apt-get install qtdeclarative5-* qml-module-qtquick* qtquickcontrols5-* qml-module-qtquick2
    sudo apt-get install -y qml-module-qtquick-extras
    sudo apt-get install libudev-dev libinput-dev libts-dev libmtdev-dev libjpeg-dev libfontconfig1-dev libssl-dev libdbus-1-dev libglib2.0-dev libxkbcommon-dev libegl1-mesa-dev libgbm-dev libgles2-mesa-dev mesa-common-dev xcb libxcb-xkb-dev x11-xkb-utils libx11-xcb-dev libxkbcommon-x11-dev libwayland-dev

    sudo apt install build-essential cmake unzip pkg-config gfortran
    sudo apt build-dep qt5-qmake libqt5gui5 libqt5webengine-data libqt5webkit5 libudev-dev libinput-dev libts-dev libxcb-xinerama0-dev libxcb-xinerama0 gdbserver
    sudo apt install libxcb-randr0-dev libxcb-xtest0-dev libxcb-shape0-dev libxcb-xkb-dev
    sudo apt install libjpeg-dev libpng-dev libtiff-dev
    sudo apt install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
    sudo apt install libxvidcore-dev libx264-dev openjdk-8-jre-headless
    sudo apt install libopenal-data libsndio7.0 libopenal1 libopenal-dev pulseaudio
    sudo apt install bluez-tools
    sudo apt install libbluetooth-dev
    sudo apt install libgstreamer1.0-0 gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio
    sudo apt install libgstreamer1.0-dev  libgstreamer-plugins-base1.0-dev

    sudo apt install qtbase5-dev qtdeclarative5-dev qtmultimedia5-dev qtconnectivity5-dev

    sudo apt-get install qt5-qmake qtbase5-dev qtdeclarative5-dev libqt5gui5 libqt5quick5 qml-module-qtquick2 qtvirtualkeyboard-plugin

    sudo apt-get install qtbase5-dev qtdeclarative5-dev libqt5quick5 qtquickcontrols2-5-dev qtvirtualkeyboard-plugin
    sudo apt install qtcreator
    sudo apt install build-essential libgl1-mesa-dev libpulse-dev
    sudo apt-get install libqt5serialport5-dev
    sudo apt-get install libqt5multimedia5-plugins qml-module-qtmultimedia
    sudo apt-get install qtdeclarative5-* qml-module-qtquick* qtquickcontrols5-* qml-module-qtquick2
    sudo apt-get install -y qml-module-qtquick-extras

    sudo apt-get install build-essential libgl1-mesa-dev libglu1-mesa-dev \
    libxcb-xinerama0-dev libfontconfig1-dev libdbus-1-dev libicu-dev \
    libsqlite3-dev libxslt1-dev libxml2-dev libssl-dev libpng-dev \
    libjpeg-dev libglib2.0-dev libxrender-dev libxi-dev \
    libx11-dev libxext-dev libxrandr-dev libxcursor-dev \
    libxcomposite-dev libxdamage-dev libxfixes-dev \
    libxss-dev libxft-dev libxkbcommon-dev \
    libinput-dev libmtdev-dev libudev-dev \
    libasound2-dev pulseaudio libpulse-dev \
    gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav gstreamer1.0-alsa \
    gstreamer1.0-pulseaudio gstreamer1.0-tools \
    bison flex gperf libevent-dev libnss3-dev libnss3 \
    libxss-dev libxtst-dev libx11-xcb-dev \

    sudo apt-get install qml-module-qt-labs-folderlistmodel
    sudo apt-get install qml-module-qtquick-controls

    sudo apt install build-essential
    sudo apt install libnss3-dev libfontconfig1-dev libdbus-1-dev libx11-xcb-dev libxcomposite-dev libxcursor-dev libxi-dev libxtst-dev libxrandr-dev libxss-dev

    sudo apt install qml-module-qtlocation
    sudo apt install qtpositioning5-dev qml-module-qtpositioning


4. Build the project:
    ```bash
    qmake
    make
5. Run the application:
    ```bash
    ./autospectra
6. Usage
    Once the application is running, you can interact with the instrument cluster using the touchscreen (if available) or a mouse/keyboard. The interface is designed to be intuitive, with various widgets displaying different vehicle parameters.

7. Starting the Application
    To start the application, run the following command:

    ```bash
    ./autospectra

## Dependencies
- Qt 5.15: The main framework for the application.
- Python: For scripting and advanced data processing.
- QProcess: For handling external processes and scripts.
- JSON: For configuration and data communication.
- Spotipy: For Spotify integration. (not needed in Auto Spectra v2.1)

## Contributing
Contributions are welcome! Please follow these steps to contribute:

Fork the repository.
Create a new branch (git checkout -b feature-branch).
Commit your changes (git commit -am 'Add new feature').
Push to the branch (git push origin feature-branch).
Create a new Pull Request.

## License
This project is licensed under the MIT License. See the LICENSE file for details.

## Acknowledgements
Qt community for providing extensive documentation and support.
Spotipy library contributors for making Spotify integration easier.
Raspberry Pi Foundation for providing a versatile development platform.
All contributors to the open-source libraries and tools used in this project.

Feel free to modify any sections as needed to better fit your project specifics. Let me know if you need any further adjustments!
