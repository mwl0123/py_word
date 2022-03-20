import webbrowser
import pyautogui
from threading import Timer
from pynput.mouse import Button, Controller
from selenium import webdriver
from selenium.webdriver.chrome.options import Options    
import os
import time

#(1258,100)

def nArgs():
    try:
        #webbrowser.open("https://quizlet.com/latest", new=1)
        #time.sleep(3)
        #pyautogui.hotkey('ctrl', 'option', 'o')
        #chrome_path = 'open -a /Applications/Google\ Chrome.app %s'
        #webbrowser.get(chrome_path).open("https://quizlet.com/latest")
        #time.sleep(3)
        #pyautogui.hotkey('ctrl', 'option', 'p')
        #driver = webdriver.Chrome('/Applications/Google Chrome.app') 
        #mouse = Controller()
        #print('The current pointer position is {0}'.formatmouse.position))
        #pyautogui.moveTo(1177,97)
        #pyautogui.click()
        #driver = webdriver.Chrome()
        #driver.get('http://www.google.com/')
        #driver = webdriver.Chrome('/usr/local/bin/chromedriver')
        chrome_options = Options()
        chrome_options.add_experimental_option("useAutomationExtension", False)
        chrome_options.add_experimental_option("excludeSwitches", ["enable-automation"])
        # chrome_options.add_argument("--start-fullscreen");
        chrome_options.add_argument("--kiosk")

        driver = webdriver.Chrome('/usr/local/bin/chromedriver',chrome_options=chrome_options)
        driver.get('https://www.google.com')
        driver.close()
    except:
        print("An exception occurred")



s = Timer(2.0, nArgs, ())
s.start()
