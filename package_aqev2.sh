#!/bin/bash

ARGC=$#
version=$1

echo "Number of args: $ARGC"

if [ $ARGC -ne 1 ]
then
  echo "version string required."
  exit
fi

rm -rf WildFire-Arduino-Core
rm -rf WildFire
rm -rf WildFire_CC3000_Library
rm -rf WildFire_SPIFlash
rm -rf TinyWatchdog
rm -rf AQEV2FW_PM
rm -rf SHT25
rm -rf pubsubclient
rm -rf CapacitiveSensor
rm -rf Time
rm -rf RTClib
rm package_airqualityegg-$version\_index.json

git clone https://github.com/WickedDevice/WildFire-Arduino-Core.git
git clone https://github.com/WickedDevice/WildFire.git
git clone https://github.com/WickedDevice/WildFire_CC3000_Library.git
git clone https://github.com/WickedDevice/WildFire_SPIFlash.git
git clone https://github.com/WickedDevice/TinyWatchdog.git
git clone https://github.com/WickedDevice/AQEV2FW_PM.git
git clone https://github.com/WickedDevice/SHT25
git clone https://github.com/vicatcu/pubsubclient
git clone https://github.com/PaulStoffregen/CapacitiveSensor
git clone https://github.com/PaulStoffregen/Time
git clone https://github.com/mizraith/RTClib

rm -rf AirQualityEgg_PM
rm -rf libraries

mkdir AirQualityEgg_PM
mkdir AirQualityEgg_PM/libraries
mkdir tmp 

cd WildFire-Arduino-Core
git archive master | tar -x -C ../tmp
cd ../tmp/WickedDevice
mv * ../../AirQualityEgg_PM/
cd ../  

cd ../WildFire
mkdir ../AirQualityEgg_PM/libraries/WildFire
git archive master | tar -x -C ../AirQualityEgg_PM/libraries/WildFire

cd ../WildFire_CC3000_Library
mkdir ../AirQualityEgg_PM/libraries/WildFire_CC3000_Library
git archive master | tar -x -C ../AirQualityEgg_PM/libraries/WildFire_CC3000_Library

cd ../WildFire_SPIFlash
mkdir ../AirQualityEgg_PM/libraries/WildFire_SPIFlash
git archive master | tar -x -C ../AirQualityEgg_PM/libraries/WildFire_SPIFlash

cd ../TinyWatchdog
mkdir ../AirQualityEgg_PM/libraries/TinyWatchdog
git archive master | tar -x -C ../AirQualityEgg_PM/libraries/TinyWatchdog

cd ../AQEV2FW_PM
githash=`git rev-parse HEAD`
mkdir ../AirQualityEgg_PM/libraries/AQEV2FW_PM
mkdir ../AirQualityEgg_PM/libraries/AQEV2FW_PM/examples
mkdir ../AirQualityEgg_PM/libraries/AQEV2FW_PM/examples/AQEV2FW_PM
git archive master | tar -x -C ../AirQualityEgg_PM/libraries/AQEV2FW_PM/examples/AQEV2FW_PM

cd ../SHT25
mkdir ../AirQualityEgg_PM/libraries/SHT25
git archive master | tar -x -C ../AirQualityEgg_PM/libraries/SHT25

cd ../CapacitiveSensor
mkdir ../AirQualityEgg_PM/libraries/CapacitiveSensor
git archive master | tar -x -C ../AirQualityEgg_PM/libraries/CapacitiveSensor

cd ../Time
mkdir ../AirQualityEgg_PM/libraries/Time
git archive master | tar -x -C ../AirQualityEgg_PM/libraries/Time

cd ../RTClib
mkdir ../AirQualityEgg_PM/libraries/RTClib
git archive master | tar -x -C ../AirQualityEgg_PM/libraries/RTClib


cd ../tmp
rm -rf *
cd ../pubsubclient
mkdir ../AirQualityEgg_PM/libraries/PubSubClient
git archive master | tar -x -C ../tmp
cd PubSubClient
sed -i 's/#define MQTT_MAX_PACKET_SIZE 128/#define MQTT_MAX_PACKET_SIZE 512/g' PubSubClient.h
cp -rf * ../../AirQualityEgg_PM/libraries/PubSubClient
cd ../


cd ../

rm AQEV2-PM-$version-Arduino-$githash.zip
zip -r AQEV2-PM-$version-Arduino-$githash.zip AirQualityEgg_PM

filesize=`stat --printf="%s" AQEV2-PM-$version-Arduino-$githash.zip`
sha256=`sha256sum AQEV2-PM-$version-Arduino-$githash.zip | awk '{print $1;}'`

cp package_template.json package_airqualityegg_pm-$version\_index.json
replace_version="s/%version%/$version/g"
replace_githash="s/%githash%/$githash/g"
replace_sha256="s/%sha256%/$sha256/g"
replace_filesize="s/%filesize%/$filesize/g"
sed -i $replace_version package_airqualityegg_pm-$version\_index.json
sed -i $replace_githash package_airqualityegg_pm-$version\_index.json
sed -i $replace_sha256 package_airqualityegg_pm-$version\_index.json
sed -i $replace_filesize package_airqualityegg_pm-$version\_index.json

rm -rf tmp
rm -rf AirQualityEgg_PM
rm -rf WildFire-Arduino-Core
rm -rf WildFire
rm -rf WildFire_CC3000_Library
rm -rf WildFire_SPIFlash
rm -rf TinyWatchdog
rm -rf AQEV2FW_PM
rm -rf SHT25
rm -rf pubsubclient
rm -rf CapacitiveSensor
rm -rf Time
rm -rf RTClib
