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
        webDisplay("https://www.youtube.com/",'k')
        newWebWindow()
        webDisplay("https://www.sigure.tw/",'p')
        appDisplay('/Applications/MarginNote 3.app','l')
        #path = '/System/Applications/App Store.app'
       ####
        #mouse = Controller()
        #print('The current pointer position is {0}'.formatmouse.position))
        #pyautogui.moveTo(1177,97)
        #pyautogui.click()
        #driver = webdriver.Chrome()
        #driver.get('http://www.google.com/')
        #time.sleep(5)
        print(pyautogui.position())
        #pyautogui.hotkey('ctrl', 'option', 'm')
        #webbrowser.open("https://quizlet.com/latest", new=2)
        #pyautogui.hotkey('ctrl', 'option', 'p')
    except:
        print("An exception occurred")



s = Timer(2.0, nArgs, ())
s.start()
