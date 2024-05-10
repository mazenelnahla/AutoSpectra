QT += quick core serialport gui qml
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += main.cpp\
            cardatareceiver.cpp \
            pythonrunner.cpp \
            serialmanager.cpp

RESOURCES += \
    qml.qrc \
    qml.qrc \
    qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    cardatareceiver.h \
    pythonrunner.h \
    serialmanager.h

DISTFILES += \
    .gitignore \
    AV-Cluster.pro.user \
    Gauge.qml \
    Gauge_animation.qml \
    README.md \
    fonts/Exo2-Bold.ttf \
    fonts/Exo2-ExtraBold.ttf \
    fonts/Exo2-Medium.ttf \
    fonts/OpenSans-Bold.ttf \
    fonts/OpenSans-BoldItalic.ttf \
    fonts/OpenSans-ExtraBold.ttf \
    fonts/OpenSans-ExtraBoldItalic.ttf \
    fonts/OpenSans-Italic.ttf \
    fonts/OpenSans-Light.ttf \
    fonts/OpenSans-LightItalic.ttf \
    fonts/OpenSans-Medium.ttf \
    fonts/OpenSans-MediumItalic.ttf \
    fonts/OpenSans-Regular.ttf \
    fonts/OpenSans-SemiBold.ttf \
    fonts/OpenSans-SemiBoldItalic.ttf \
    fonts/fonts.txt \
    images/Adaptive-off.png \
    images/Adaptive-on.png \
    images/Camera-screen.png \
    images/Low-bat.png \
    images/Parking-break.png \
    images/Set 1/01.png \
    images/Set 1/01.png \
    images/Set 1/02.png \
    images/Set 1/02.png \
    images/Set 1/03.png \
    images/Set 1/03.png \
    images/Set 1/04.png \
    images/Set 1/04.png \
    images/Set 1/05.png \
    images/Set 1/05.png \
    images/Set 1/06.png \
    images/Set 1/06.png \
    images/Set 1/07.png \
    images/Set 1/07.png \
    images/Set 1/08.png \
    images/Set 1/08.png \
    images/Set 1/09.png \
    images/Set 1/09.png \
    images/Set 1/10.png \
    images/Set 1/10.png \
    images/Set 1/11.png \
    images/Set 1/11.png \
    images/Set 1/12.png \
    images/Set 1/12.png \
    images/Set 1/13.png \
    images/Set 1/13.png \
    images/Set 1/14.png \
    images/Set 1/14.png \
    images/Set 1/15.png \
    images/Set 1/15.png \
    images/Set 1/16.png \
    images/Set 1/16.png \
    images/Set 1/17.png \
    images/Set 1/17.png \
    images/Set 1/18.png \
    images/Set 1/18.png \
    images/Set 1/19.png \
    images/Set 1/19.png \
    images/Set 1/20.png \
    images/Set 1/20.png \
    images/Set 1/21.png \
    images/Set 1/21.png \
    images/Set 1/22.png \
    images/Set 1/22.png \
    images/Set 1/23.png \
    images/Set 1/23.png \
    images/Set 1/24.png \
    images/Set 1/24.png \
    images/Set 1/25.png \
    images/Set 1/25.png \
    images/Set 1/26.png \
    images/Set 1/26.png \
    images/Set 1/27.png \
    images/Set 1/27.png \
    images/Set 1/28.png \
    images/Set 1/28.png \
    images/Set 1/29.png \
    images/Set 1/29.png \
    images/Set 1/30.png \
    images/Set 1/30.png \
    images/Set 1/31.png \
    images/Set 1/31.png \
    images/Set 1/32.png \
    images/Set 1/32.png \
    images/Set 1/33.png \
    images/Set 1/33.png \
    images/Set 1/34.png \
    images/Set 1/34.png \
    images/Set 1/35.png \
    images/Set 1/35.png \
    images/Set 1/36.png \
    images/Set 1/36.png \
    images/Set 1/37.png \
    images/Set 1/37.png \
    images/Set 1/38.png \
    images/Set 1/38.png \
    images/Set 1/39.png \
    images/Set 1/39.png \
    images/Set 1/40.png \
    images/Set 1/40.png \
    images/adaptive_off.png \
    images/adaptive_on.png \
    images/assist-disable.png \
    images/assist_disable.png \
    images/base_1.png \
    images/color_fill_1.png \
    images/dark-mode.png \
    images/daytime_light.png \
    images/door-open.png \
    images/door_open.png \
    images/group_1.png \
    images/high-beam.png \
    images/high_beam.png \
    images/left.png \
    images/left_side.png \
    images/low-beam.png \
    images/light-mode.png \
    images/low_bat.png \
    images/low_beam.png \
    images/lower_status.png \
    images/parking_break.png \
    images/rectangle_1.png \
    images/right.png \
    images/right_side.png \
    images/seat-belt.png \
    images/seat_belt.png \
    images/speed-limit.png \
    images/speed_limit.png \
    images/steering-error.png \
    images/steering_error.png \
    images/upper_status.png \
    img/background.png \
    img/background.svg \
    img/needle.svg \
    img/tickmark.svg \
    main.qml \
    mscript.py
