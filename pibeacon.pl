#!/usr/bin/python3
# ==============================================
#  RASPBERRY PI BEACON FOR PYTHON
#  KW4AP formerly KK4YWN
#  I USED A SERIES RESISTOR OF 220 OHMS BETWEEN
# GRND AND A 4N25 OPTOCOUPLER. PIN 11 ENABLES
# THE OPTCOUPLER. THE OUTPUT OF THE OPTOCOUPLER
# IS CONNECTED TO THE KEY LINE OF MY XMITR.
#  THIS IS NOT ROCKET SURGERY.
#  (tech support = nominal fee)
#
# Tip: send speed is ~ 13wpm. Before you change
# this, reconsider. The timing is a hack: its not
# easy to alter.
# I do think these comments are rather nice,
# (if I do say so myself). Much nicer than those
# licenses you get for your pet fish.
# ==============================================

import os
import RPi.GPIO as GPIO  # needed for GPIO functionality
import time  # needed for sleep

# Use Physical Pin Numbers
GPIO.setmode(GPIO.BOARD)

# Set Physical Pin 11 to be an Output
GPIO.setup(11, GPIO.OUT)
# ==============================================
# DEFINE SOME USEFUL FUNCTIONS
# ==============================================
def dit():  # Send a dot
  GPIO.output(11, GPIO.HIGH)
  time.sleep(0.1)
  GPIO.output(11, GPIO.LOW)
  time.sleep(0.1)

def dah():  # Send a dash
  GPIO.output(11, GPIO.HIGH)
  time.sleep(0.3)
  GPIO.output(11, GPIO.LOW)
  time.sleep(0.1)

def letterSpace():  # Allow three time units pause
  GPIO.output(11, GPIO.LOW)
  time.sleep(0.3)

def wordSpace():  # Allow seven time units pause (two letterspace + this = 7)
  GPIO.output(11, GPIO.LOW)
  time.sleep(0.1)

def carrier():  # Send several seconds of carrier
  time.sleep(0.7)
  GPIO.output(11, GPIO.HIGH)
  time.sleep(15)
  GPIO.output(11, GPIO.LOW)
  time.sleep(0.7)
# ============================
# CLEAR THE SCREEN
# ============================
os.system("clear")
# ============================
# CHANGE THIS OR BE A SILLYPERSON
# ============================
message = "vvv vvv vvv kk4ywn kk4ywn kk4ywn em95lh eirp 66.7w heading 0 rx reports to sillyperson@gmail.com de kk4ywn/b ar"
# ============================
# THERE ARE MOSTLY NO MISTAKES
# ============================
morseDict = {
' ': 'x',
'a': '.-',
'b': '-...',
'c': '-.-.',
'd': '-..',
'e': '.',
'f': '..-.',
'g': '--.',
'h': '....',
'i': '..',
'j': '.---',
'k': '-.-',
'l': '.-..',
'm': '--',
'n': '-.',
'o': '---',
'p': '.--.',
'q': '--.-',
'r': '.-.',
's': '...',
't': '-',
'u': '..-',
'v': '...-',
'w': '.--',
'x': '-..-',
'y': '-.--',
'z': '--..',
'0': '-----',
'1': '.----',
'2': '..---',
'3': '...--',
'4': '....-',
'5': '.....',
'6': '-....',
'7': '--...',
'8': '---..',
'9': '----.',
'.': '.-.-.-',
',': '--..--',
':': '---...',
'?': '..--..',
'/': '-..-.',
'@': '.--.-.',
'=': '-...-'
}
# ============================
# AND NOW FOR SOMETHING COMPLETELY DIFFERENT- SPAM
# ============================
print ("  Beacon enabled. Press Ctrl+C to end.")
print ("  Sending:")
print ("  ", (message))

while True:
  try:
  inp = message
  a = ' '.join([morseDict[c] for c in inp])
  morseStr =  a
  for c in morseStr:
  if c == '-':
  dah()
  elif c == '.':
  dit()
  elif c == 'x':
  wordSpace()
  else:
  letterSpace()
  carrier()
  except KeyboardInterrupt:
  print (" signal caught. Exiting")
  break


GPIO.cleanup()  # Always clean up at the end of programs.
