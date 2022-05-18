import webbrowser
import pyautogui
from threading import Timer
from pynput.mouse import Button, Controller
from selenium import webdriver
import time
import os

#(1258,100)
def webDisplay(web_url,key_value):
    webbrowser.open(web_url, new=2)
    pyautogui.hotkey('ctrl', 'option', key_value)
    time.sleep(1)

def appDisplay(path_dir,key_value):
    os.system(f'open "' +path_dir + '"')
    pyautogui.hotkey('ctrl', 'option', key_value)

def newWebWindow():
    pyautogui.hotkey('command', 'n')
    
def nArgs():
    try:
        webDisplay("https://quizlet.com/latest",'o')
        newWebWindow()
        webDisplay("https://www.youtube.com/watch?v=vqx3K2nfIpU",'k')
        newWebWindow()
        webDisplay("https://www.udemy.com/course/ielts-band-7-preparation-course/learn/lecture/5537768#overview",'p')
        appDisplay('/Applications/MarginNote 3.app','l')
    except:
        print("An exception occurred")



s = Timer(2.0, nArgs, ())
s.start()
