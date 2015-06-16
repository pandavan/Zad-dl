# Zad-dl
A simple DIY audio/video downlader script for ubuntu distro's. The purpose of Zad-dl is not to replace any existing downloader but helping novice programmers to create their own. This script can be used as a teaching or studying tool for early programmers. Zad-dl uses several third party programms such as [YAD](http://sourceforge.net/projects/yad-dialog/), [Youtube-dl](https://rg3.github.io/youtube-dl/) and [Xcel](https://github.com/kfish/xsel) for its functions, in a sense **Youtube-dl** is the heart of this programme. For creating its Interface two GUI makers were used one is the Zenity a default programm available in ubuntu distros and YAD. The name Zad-dl is born from the component programms used

                              Zentiy + Yad + Youtube-dl = Zad-dl
                        
Zad-dl is a single bash script file when executed will automaticlly downloads necessary programms and creates a shortcut in unity launcher for current user. It can be used to download audio's (mp3, m4a etc) and videos (mp4,3gp..etc) in different qualities. It also helps you to download playlist from youtue with different video and audio format.  Other supported website can be seen [here](https://rg3.github.io/youtube-dl/supportedsites.html)

## How to use Zad-dl

#Package Installation  (Initial step)

* Download the **Zad-dl.sh** script

* Make it executable **chmod u+x Zad-dl.sh**
* And Run it

* If programms are needed it will ask for your permission to download those packages.

* Initially try executing **Zad-dl.sh** for two more times till a GUI window is open 

* Once GUI window is open, you are ready for downloading files

* Reboot your system.

#Creating Laucher shortcut

* After the reboot

* Open Dash and type **Zad-dl** 

* You will see a red download icon.

* click open and launch

* In the launcher using third mouse open the menu and Lock the **Zad-dl** on the launcher

#Downloading files

* Copy a audio,video html link from a hosting website (ex: youtube,vimeo,daily motion etc)

* Click the **Zad-dl** icon in launcher

* A GUI Window will open with URL box and a file selection box

* Select the directory in which you want to save the file

* Click Ok and a list window will open showing the different file formats available

* Select the format you need (mp3, flv etc)

* Click start and a progress window will open showing the progress of the file downloaded


#Using Proxy
* During installation [proxychains](http://proxychains.sourceforge.net/) is installed
* While using **Zad-dl** choose **proxychain** option
* Down side of using proxy is download speed is slower
