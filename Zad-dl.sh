#!/bin/bash
#https://github.com/pandavan/Zad-dl
#Zad-dl; Download videos, audios or playlist using this code



function YouDown {
	
# Copying and validation of url from clipbord using xsel
regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]';
clpy=$(xsel -b);
if [[ $clpy =~ $regex ]]
then 
 clpy=$clpy;
    
else
    clpy="http://"
fi

OUTPUT="$(yad --width="500" --title="Zad-dl" --text="Download audio and video files" --form --field="URL" --field="Directory:MDIR" --field="Proxychains:CHK" "$clpy" "$HOME/Desktop/" FALSE --button="gtk-ok:0" --button="gtk-cancel:1")"
  
accepted=$?
if ((accepted != 0)); then
    echo "something went wrong"
    exit 1
fi
URLy=$(awk -F'|' '{print $1}' <<<$OUTPUT)
DIRE=$(awk -F '|' '{print $2}' <<<$OUTPUT)
CHKy=$(awk -F '|' '{print $3}' <<<$OUTPUT)

#URL validation\
if [[ $(echo ${#URLy}) -lt 14 ]] ; then
zenity --info --width=300 --title="Zad-dl" --timeout=3 --text="Wrong Url input"
YouDown;
fi

# DIrectory Location
cd $DIRE;

#validating proxy option
prox="";
if [ "$CHKy" = "TRUE" ]; then
prox="proxychains"
msg="\nINFO: You are using a proxy and can cause slower download speed"
fi


#Selecting a format to download, added addition line 'mp3'

FRMT=$($prox youtube-dl -F $URLy |grep -vE '^\[(youtube|info|download|youtube:playlist)\] |^format |^ProxyChains'| sed '1imp3' |zenity  --list --width=500 --height=400 --title="Zad-dl" --text "Fetching audio, video format... $msg" --ok-label="Start" --column "File Format"); 

if [[ $? -eq 1 ]]; then
zenity --info --width=300 --title="Zad-dl" --timeout=2 --text="Task Quit"
exit
elif [[ -z $FRMT ]]; then
zenity --info --width=300 --title="Zad-dl" --timeout=3  --text="No Format Selected.\n Allow time to fetch file format details"
exit
else
#Selecting ID number from FRMT
strg="$(awk '{print $1}' <<<"$FRMT")"; 
#Download files using youtube-dl
if [ "$strg" = "mp3" ]; then
#Download Mp3 audios and Playlist
$prox youtube-dl --extract-audio --audio-quality 0 --newline --audio-format mp3 \
           $URLy |
 grep --line-buffered -oP '^\[download\].*?\K([0-9.]+\%|#\d+ of \d)' | 
    zenity --progress \
  --title="Zad-dl" \
   --width="350" \
  --text="Directory Path: $DIRE \nDownloading mp3, Please Wait..." \
  --ok-label="Directory" \
  --percentage=0 ;  
 if [[ $? -eq 0 ]]; then
 #Open directory in a GUI
 xdg-open $DIRE;
 sleep 2

fi

elif [[ $strg != "mp3" ]];then
#Download Other types of files and Playlist
$prox youtube-dl --newline -f $strg $URLy\
           $URLy |
 grep --line-buffered -oP '^\[download\].*?\K([0-9.]+\%|#\d+ of \d)' | 
    zenity --progress \
  --title="Zad-dl" \
   --width="350" \
  --text="Directory Path: $DIRE \nDownloading, Please Wait..." \
  --ok-label="Directory" \
  --percentage=0 ;  
if [[ $? -eq 0 ]]; then
 xdg-open $DIRE;
 sleep 2
fi
fi
fi
}

echo -e "#If this is your first time using zad-dl it will automatically check and install programms and packages required for running this app.\n\nPlease provide necessary password when asked.\n\nIt may take few minutes to download all packages"

#checking necessary programms installed or not
if [ ! -x "$(command -v youtube-dl)" ] ||  [ ! -x "$(command -v xsel)" ] || [ ! -x "$(command -v proxychains)" ] \
    [ ! -x "$(command -v yad)" ] || [[ ! -f $HOME/.local/share/applications/Zad-dl.desktop ]] \
   || [[ ! -d $HOME/.zad-dl ]] ; then

if ! [ -x "$(command -v youtube-dl)" ]; then
echo -e "\nInstalling youtube-dl\n"
sudo add-apt-repository ppa:nilarimogard/webupd8 
sudo apt-get update 
sudo apt-get install youtube-dl
fi
if ! [ -x "$(command -v xsel)" ]; then
echo -e "\nInstalling xsel\n"
sudo apt-get install xsel 
fi
if ! [ -x "$(command -v proxychains)" ]; then
echo -e "\nInstalling proxychains\n"
sudo apt-get install proxychains tor obfsproxy
fi
if ! [ -x "$(command -v yad)" ]; then
echo -e "\nInstalling yad\n"
sudo add-apt-repository ppa:webupd8team/y-ppa-manager 
sudo apt-get update
sudo apt-get install yad
fi
if [[ ! -f $HOME/.local/share/applications/Zad-dl.desktop ]]; then
echo -e "\nCreating a Launcher file details and icon for current user\n"
cat >$HOME/.local/share/applications/Zad-dl.desktop<<EOL
[Desktop Entry]
Name=Zad-dl
Comment=Zad-dl Downloader
Exec=$HOME/.zad-dl/Zad-dl.sh
Icon=$HOME/.zad-dl/gtao4rj.png
Terminal=false
Type=Application
StartupNotify=true
EOL
fi
if [[ ! -d $HOME/.zad-dl || ! -f $HOME/.zad-dl/gtao4rj.png ]]; then
echo -e "\nDownloading Icon for Launcher\n"
mkdir -p $HOME/.zad-dl/
cp $(readlink -f $0) $HOME/.zad-dl
wget -P $HOME/.zad-dl/ http://i.imgur.com/gtao4rj.png
#icon courtsey https://www.iconfinder.com/icons/406708/download_icon#size=128
fi

else
echo -e "\nAll programms and packages installed"

YouDown;
fi


