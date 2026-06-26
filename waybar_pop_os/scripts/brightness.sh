#!/bin/bash

BRIGHT=$(brightnessctl -m | cut -d, -f4 | tr -d '%')

echo "{\"text\":\"󱄄 $BRIGHT%\",\"tooltip\":\"Controles:\nBotão esquerdo -> aumenta\nBotão direito -> diminui\"}"
