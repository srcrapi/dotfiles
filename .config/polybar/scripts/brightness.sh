#!/bin/sh

max_level=$(brightnessctl m)
current_level=$(brightnessctl g)

echo $((current_level * 100 / max_level))