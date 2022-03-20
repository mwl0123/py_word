import webbrowser
import pyautogui
from threading import Timer
from pynput.mouse import Button, Controller
from selenium import webdriver
import time
import os

#(1258,100)

def nArgs():
    try:
        webbrowser.open("https://quizlet.com/latest", new=2)
        pyautogui.hotkey('ctrl', 'option', 'o')
        pyautogui.hotkey('command', 'n')
        time.sleep(2)
        webbrowser.open("https://www.youtube.com/", new=1)
        pyautogui.hotkey('ctrl', 'option', 'k')
        pyautogui.hotkey('command', 'n')
        time.sleep(2)
        webbrowser.open("https://www.sigure.tw/", new=1)
        pyautogui.hotkey('ctrl', 'option', 'p')
        time.sleep(2)
        #path = '/System/Applications/App Store.app'
        path = '/Applications/MarginNote 3.app'
        os.system(f'open "' +path + '"')
        pyautogui.hotkey('ctrl', 'option', 'l')
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
