#!/bin/bash
 
 module="$(pwd)/module"
 rm -rf ${module}
 wget -O ${module} "https://raw.githubusercontent.com/NearVPN/Herramientas/main/module/module" &>/dev/null
 [[ ! -e ${module} ]] && exit
 chmod +x ${module} &>/dev/null
 source ${module}
 
 CTRL_C(){
   rm -rf ${module}; exit
 }
 
 trap "CTRL_C" INT TERM EXIT
 
 ADMRufu="/etc/ADMRufu" && [[ ! -d ${ADMRufu} ]] && mkdir ${ADMRufu}
 ADM_inst="${ADMRufu}/install" && [[ ! -d ${ADM_inst} ]] && mkdir ${ADM_inst}
 SCPinstal="$HOME/install"
 Filotros="${ADMRufu}/tmp"
 rm -rf /etc/localtime &>/dev/null
 ln -s /usr/share/zoneinfo/America/Argentina/Tucuman /etc/localtime &>/dev/null
 rm $(pwd)/$0 &> /dev/null
 
 stop_install(){
    msgi -bar2
    msgi -bar2
    echo -e "\033[1;97m          ---- INSTALACION CANCELADA  -----"
    msgi -bar2
    msgi -bar2
  # echo -e "INSTALACIÓN CANCELADA"
    exit
  }
 
 time_reboot() {
  print_center -ama "REINICIANDO VPS EN $1 SEGUNDOS"
   REBOOT_TIMEOUT="$1"
   
   while [ $REBOOT_TIMEOUT -gt 0 ]; do
      print_center -ne "-$REBOOT_TIMEOUT-\r"
      sleep 1
      : $((REBOOT_TIMEOUT--))
   done
   reboot
 }



 fun_idi() {
    clear && clear
    msgi -bar2
    echo -e "\033[1;32m————————————————————————————————————————————————————"
    figlet -w 85 -f smslant "         SCRIPT
   NEAR-MOD  " | lolcat
    msgi -ama "          [ ----- \033[1;97m 🐲 By @Near365 🐲\033[1;33m ----- ]"
    echo -e "\033[1;32m————————————————————————————————————————————————————"
    pv="$(echo es)"
    [[ ${#id} -gt 2 ]] && id="es" || id="$pv"
    byinst="true"
  }
 
 os_system(){
   system=$(cat -n /etc/issue |grep 1 |cut -d' ' -f6,7,8 |sed 's/1//' |sed 's/      //')
   distro=$(echo "$system"|awk '{print $1}')
 
   case $distro in
     Debian)vercion=$(echo $system|awk '{print $3}'|cut -d '.' -f1);;
     Ubuntu)vercion=$(echo $system|awk '{print $2}'|cut -d '.' -f1,2);;
   esac
 }
 
 repo(){
   link="https://raw.githubusercontent.com/NearVPN/ADMRufuMod/main/Repositorios/$1.list"
   case $1 in
     8|9|10|11|16.04|18.04|20.04|20.10|21.04|21.10|22.04)wget -O /etc/apt/sources.list ${link} &>/dev/null;;
   esac
 }
 
 dependencias() {
  soft="sudo bsdmainutils zip unzip ufw curl python python3 python3-pip openssl cron iptables lsof pv boxes at mlocate gawk bc jq curl npm nodejs socat netcat netcat-traditional net-tools cowsay figlet lolcat apache2"
  for i in $soft; do
    leng="${#i}"
    puntos=$(( 21 - $leng))
    pts="."
    for (( a = 0; a < $puntos; a++ )); do
      pts+="."
    done
    msg -nazu "       Instalando $i$(msg -ama "$pts")"
    if apt install $i -y &>/dev/null ; then
      msg -verd "INSTALADO"
    else    
      msg -verm2 "FAIL"
      sleep 2
      tput cuu1 && tput dl1
      #print_center -ama "aplicando fix a $i"
      sistema22
      dpkg --configure -a >/dev/null 2>&1
      sleep 2
      tput cuu1 && tput dl1
      msg -nazu "       Instalando python$(msg -ama "$pts")"
      if apt install python2 -y &>/dev/null ; then
        msg -verd "INSTALADO"
      else
        msg -verm2 "FAIL"
      fi
    fi
  done
  #for i in $soft; do
   # paquete="$i"
  #  echo -e "\033[1;97m INSTALANDO PAQUETE \e[93m >>> \e[36m $i"
   # barra_intall "apt-get install $i -y"
  #done
}

sistema22(){
if [[ ! -e /etc/ADMRufu/fixer ]]; then
    echo ""
ins(){
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games/
apt-get install python2 -y
apt-get install python -y 
apt install python pip -y
rm -rf /usr/bin/python; ln -s /usr/bin/python2.7 /usr/bin/python
}
ins &>/dev/null
sleep 1.s
[[ ! -e /etc/ADMRufu/fixer ]] && touch /etc/ADMRufu/fixer
else
echo ""
fi
sleep 2
      tput cuu1 && tput dl1
}
 
 ofus () {
unset server
server=$(echo ${txt_ofuscatw}|cut -d':' -f1)
unset txtofus
number=$(expr length $1)
for((i=1; i<$number+1; i++)); do
txt[$i]=$(echo "$1" | cut -b $i)
case ${txt[$i]} in
".")txt[$i]="C";;
"C")txt[$i]=".";;
"3")txt[$i]="@";;
"@")txt[$i]="3";;
"4")txt[$i]="9";;
"9")txt[$i]="4";;
"6")txt[$i]="P";;
"P")txt[$i]="6";;
"L")txt[$i]="K";;
"K")txt[$i]="L";;
esac
txtofus+="${txt[$i]}"
done
echo "$txtofus" | rev
}
 
 function_verify () {
   permited=$(curl -sSL "https://raw.githubusercontent.com/NearVPN/Control/master/Control-IP")
   [[ $(echo $permited|grep "${IP}") = "" ]] && {
     clear
     msg -bar
     print_center -verm2 "¡LA IP $(wget -qO- ipv4.icanhazip.com) NO ESTA AUTORIZADA!"
     print_center -ama "CONTACTE A @Near365"
     msg -bar
    rm ${ADMRufu}
     [[ -e $HOME/lista-arq ]] && rm $HOME/lista-arq
     exit
   } || {
   ### INTALAR VERCION DE SCRIPT
   ver=$(curl -sSL "https://raw.githubusercontent.com/NearVPN/ADMRufuMod/main/vercion")
   echo "$ver" > ${ADMRufu}/vercion
   }
 }
 
 fun_ip(){
     MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
     MEU_IP2=$(wget -qO- ipv4.icanhazip.com)
     [[ "$MEU_IP" != "$MEU_IP2" ]] && IP="$MEU_IP2" || IP="$MEU_IP"
 }
 
 verificar_arq(){
  unset ARQ
  case $1 in
    menu|menu_inst.sh|message.txt|tool_extras.sh|chekup.sh)ARQ="${ADMRufu}";;
    #"message.txt")ARQ="${Filotros}";;
    #*)ARQ="${Filotros}" ;;
    *)ARQ="${ADM_inst}";;        
  esac
  mv -f ${SCPinstal}/$1 ${ARQ}/$1
  chmod +x ${ARQ}/$1
 }
 
 error_fun(){
  msg -bar3
  print_center -verm "ERROR de enlace VPS<-->GENERADOR"
  msg -bar3
  [[ -d ${SCPinstal} ]] && rm -rf ${SCPinstal}
  exit
 }
 
 post_reboot(){
  clear && clear
   echo 'wget -O /root/install.sh "https://raw.githubusercontent.com/NearVPN/ADMRufuMod/main/NearInstall/install.sh"; clear; sleep 2; chmod +x /root/install.sh; /root/install.sh --continue' >> /root/.bashrc
   msgi -bar
  echo -e "\e[1;93m     CONTINURA INSTALACION DESPUES DEL REBOOT"
  msgi -bar
   #title "[----► NEAR SCRIPT•MOD ◄----]"
   #print_center -ama "La instalacion continuara\ndespues del reinicio!!!"
   #msg -bar
 }
 
 install_start(){
  clear && clear
  echo ""
  msgi -bar2
  echo -e "\033[1;93m\a\a\a      SE PROCEDERA A INSTALAR LAS ACTULIZACIONES\n PERTINENTES DEL SISTEMA, ESTE PROCESO PUEDE TARDAR\n VARIOS MINUTOS Y PUEDE PEDIR ALGUNAS CONFIRMACIONES \033[0;37m"
  msgi -bar
  read -p "Desea continuar? [S/N]: " -e -i S opcion
   [[ "$opcion" = "n" || "$opcion" = "N" ]] && stop_install
 # read -t 120 -n 1 -rsp $'\033[1;97m           Preciona Enter Para continuar\n'
  clear && clear
   os_system
   repo "${vercion}"
   apt update -y; apt upgrade -y
 }
 
 install_continue(){
  clear && clear
  apt install pv -y &> /dev/null
   apt install pv -y -qq --silent > /dev/null 2>&1  
  #-- VERIFICAR VERSION
  ### INTALAR VERCION DE SCRIPT
   ver=$(curl -sSL "https://raw.githubusercontent.com/NearVPN/ADMRufuMod/main/vercion")
   echo "$ver" > ${ADMRufu}/vercion
  v22=$(cat ${ADMRufu}/vercion)
  vesaoSCT="\033[1;31m [\033[1;32m($v22)\033[1;97m\033[1;31m]"
  #-- CONFIGURACION BASICA
  os_system
  repo "${vercion}"
  clear
  msgi -bar2
  echo -e " \e[33m\033[1;100m   ===>> ►►  🖥  SCRIPT | NEAR-MOD  🖥  ◄◄ <<===   \033[1;37m"
  msgi -bar2
  msgi -ama "  PREPARANDO INSTALACION | VERSION: $vesaoSCT"
  msgi -bar2
  ## PAQUETES-UBUNTU PRINCIPALES
  echo ""
  echo -e "\033[1;97m         🔎 IDENTIFICANDO SISTEMA OPERATIVO"
  echo -e "\033[1;32m                 | $distro $vercion |"
  echo ""
  echo -e "\033[1;97m    ◽️ DESACTIVANDO PASS ALFANUMERICO "
  sed -i 's/.*pam_cracklib.so.*/password sufficient pam_unix.so sha512 shadow nullok try_first_pass #use_authtok/' /etc/pam.d/common-password >/dev/null 2>&1
  killall apt apt-get > /dev/null 2>&1 && echo -e "\033[97m    ◽️ INTENTANDO DETENER UPDATER SECUNDARIO " | pv -qL 40
dpkg --configure -a > /dev/null 2>&1 && echo -e "\033[97m    ◽️ INTENTANDO RECONFIGURAR UPDATER " | pv -qL 40
apt list --upgradable &>/dev/null && echo -e "\033[97m    ◽️ EXTRAYENDO APT-LIST " | pv -qL 50

apt-get install software-properties-common -y > /dev/null 2>&1 && echo -e "\033[97m    ◽️ EXTRAYENDO S-P-C " | pv -qL 50
apt-get install curl -y &>/dev/null
apt install python -y &>/dev/null && echo -e "\033[97m    ◽️ EXTRAYENDO PY " | pv -qL 50
apt-get install python-pip -y &>/dev/null && echo -e "\033[97m    ◽️ EXTRAYENDO PY-PIP " | pv -qL 50
apt-get install python3 -y &>/dev/null && echo -e "\033[97m    ◽️ EXTRAYENDO PY3 " | pv -qL 50
apt-get install python3-pip -y &>/dev/null && echo -e "\033[97m    ◽️ EXTRAYENDO PY3-PIP " | pv -qL 50

sudo apt-add-repository universe -y > /dev/null 2>&1 && echo -e "\033[97m    ◽️ EXTRAYENDO LIBRERIA UNIVERSAL " | pv -qL 50
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || apt-get install net-tools -y &>/dev/null && echo -e "\033[97m    ◽️ EXTRAYENDO NET-TOOLS" | pv -qL 40
sed -i 's/.*pam_cracklib.so.*/password sufficient pam_unix.so sha512 shadow nullok try_first_pass #use_authtok/' /etc/pam.d/common-password > /dev/null 2>&1 && echo -e "\033[97m    ◽️ DESACTIVANDO PASS ALFANUMERICO " | pv -qL 50
apt-get install lsof -y &>/dev/null && echo -e "\033[97m    ◽️ EXTRAYENDO LSOF" | pv -qL 40
apt-get install sudo -y &>/dev/null && echo -e "\033[97m    ◽️ EXTRAYENDO SUDO" | pv -qL 40
apt-get install bc -y &>/dev/null && echo -e "\033[97m    ◽️ EXTRAYENDO BC" | pv -qL 40
barra_intallb "service ssh restart > /dev/null 2>&1 "
echo ""
enter
#msgi -bar
 # read -p "Desea continuar? [S/N]: " -e -i S opcion
  # [[ "$opcion" = "n" || "$opcion" = "N" ]] && stop_install
 # read -t 120 -n 1 -rsp $'\033[1;97m           Preciona Enter Para continuar\n'
  clear && clear
   clear && clear
  #------- BARRA DE ESPERA
  msgi -bar2
  echo -e " \e[33m\033[1;100m   ===>> ►►  🖥  SCRIPT | NEAR-MOD  🖥  ◄◄ <<===   \033[1;37m"
  msgi -bar
  echo -e "  \033[1;41m   -- INSTALACION DE PAQUETES PARA NEAR-MOD --   \e[49m"
  msgi -bar
  #print_center -ama "$distro $vercion"
  dependencias
  sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf >/dev/null 2>&1
  service apache2 restart >/dev/null 2>&1
  [[ $(sudo lsof -i :81) ]] || ESTATUSP=$(echo -e "\033[1;91m        >>>  FALLO DE INSTALACION EN APACHE <<<") &>/dev/null
  [[ $(sudo lsof -i :81) ]] && ESTATUSP=$(echo -e "\033[1;92m        >>> PUERTO APACHE ACTIVO CON EXITO <<<") &>/dev/null
  echo ""
  echo -e "$ESTATUSP"
  echo ""
  msgi -bar
  echo -e "\e[1;97m        REMOVIENDO PAQUETES OBSOLETOS - \e[1;32m OK"
  apt autoremove -y &>/dev/null
  echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
  echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
  msgi -bar2
  #read -t 30 -n 1 -rsp $'\033[1;97m           Preciona Enter Para continuar\n'
   sleep 2
   tput cuu1 && tput dl1
   msgi -bar
   print_center -ama "si algunas de las dependencias falla!!!\nal terminar, puede intentar instalar\nla misma manualmente usando el siguiente comando\napt install nom_del_paquete"
  # msgi -bar
   enter
 }
 
 while :
 do
   case $1 in
     -s|--start)install_start && post_reboot && time_reboot "15";;
     -c|--continue)rm /root/install.sh &> /dev/null
                   sed -i '/Near/d' /root/.bashrc
                   install_continue
                   break;;
     -u|--update)install_start
                 install_continue
                 break;;
     *)exit;;
   esac
 done
 fun_idi
 #title "[----► NEAR SCRIPT•MOD ◄----]"
 fun_ip
 while [[ ! $Key ]]; do
  echo -e "  $(msg -verm3 "╭╼╼╼╼╼╼╼╼╼╼╼╼╼╼╼╼[")$(msg -azu "INGRESA TU KEY")$(msg -verm3 "]")"
  echo -ne "  $(msg -verm3 "╰╼")\033[37;1m>\e[32m\e[1m "
  read Key
 done
 msg -bar3
 msg -ne " Verificando Key: "
 cd $HOME
 wget -O $HOME/lista-arq $(ofus "$Key")/$IP > /dev/null 2>&1 && msg -verd "Key Completa" || {
    msg -verm2 "Key Invalida"
    msg -bar
    [[ -e $HOME/lista-arq ]] && rm $HOME/lista-arq
    exit
    }
 msg -bar3
 
 IP=$(ofus "$Key" | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}') && echo "$IP" > /usr/bin/vendor_code
 sleep 1s
 function_verify
 
 if [[ -e $HOME/lista-arq ]] && [[ ! $(cat $HOME/lista-arq|grep "KEY INVALIDA!") ]]; then
 
    msg -verd " INSTALANDO NEAR-MOD... $(msg -ama "[Proyect by @Near365")"
    REQUEST=$(ofus "$Key"|cut -d'/' -f2)
    [[ ! -d ${SCPinstal} ]] && mkdir ${SCPinstal}
    msg -nama "Descarga de archivos...  "
    for arqx in $(cat $HOME/lista-arq); do
     wget --no-check-certificate -O ${SCPinstal}/${arqx} ${IP}:81/${REQUEST}/${arqx} > /dev/null 2>&1 && {
     verificar_arq "${arqx}"
    } || {
     msg -verm2 "fallida!!!"
     sleep 2s
     error_fun
    }
    done
    msg -verd "completa!!!"
    sleep 2s
    rm $HOME/lista-arq
    [[ -d ${SCPinstal} ]] && rm -rf ${SCPinstal}
    rm -rf /usr/bin/menu
    rm -rf /usr/bin/MENU
    rm -rf /usr/bin/ADMRufu
    echo "${ADMRufu}/menu" > /usr/bin/menu && chmod +x /usr/bin/menu
    echo "${ADMRufu}/menu" > /usr/bin/MENU && chmod +x /usr/bin/MENU
    echo "${ADMRufu}/menu" > /usr/bin/ADMRufu && chmod +x /usr/bin/ADMRufu
    /bin/cp /etc/skel/.bashrc ~/
echo 'clear' >> .bashrc
echo 'echo ""' >> .bashrc
    sed -i '/Near/d' /root/bash.bashrc
    [[ -z $(echo $PATH|grep "/usr/games") ]] && echo 'if [[ $(echo $PATH|grep "/usr/games") = "" ]]; then PATH=$PATH:/usr/games; fi' >> .bashrc
    echo '[[ $UID = 0 ]] && screen -dmS up /etc/ADMRufu/chekup.sh' >> .bashrc
    echo 'v=$(cat /etc/ADMRufu/vercion)' >> .bashrc
    echo '[[ -e /etc/ADMRufu/new_vercion ]] && up=$(cat /etc/ADMRufu/new_vercion) || up=$v' >> .bashrc
    echo -e "[[ \$(date '+%s' -d \$jhu) -gt \$(date '+%s' -d \$(cat /etc/ADMRufu/vercion)) ]] && v2=\"NUEVA VERSION DISPONIBLE: \$v >>> \$up\" || v2=\"SCRIPT VERSION: \$v\"" >> .bashrc
    echo '[[ -e "/etc/ADMRufu/message.txt" ]] && mess1="$(less /etc/ADMRufu/message.txt)"' >> .bashrc
    echo '[[ -z "$mess1" ]] && mess1="@Near365"' >> .bashrc
echo 'clear' >> .bashrc
    echo 'echo -e "\033[1;31m————————————————————————————————————————————————————" ' >> .bashrc
    echo 'echo -e "\033[1;93m════════════════════════════════════════════════════" ' >> .bashrc
    echo 'sudo figlet -w 85 -f smslant "       SCRIPT
     NEAR-MOD"   | lolcat' >> .bashrc
    echo 'echo -e "\033[1;93m════════════════════════════════════════════════════" ' >> .bashrc
    echo 'echo -e "\033[1;31m————————————————————————————————————————————————————" ' >> .bashrc
    echo 'echo "" ' >>.bashrc
    echo 'echo -e "\033[92m  -->> $v2 "' >> .bashrc
    echo 'echo "" ' >>.bashrc
    echo 'echo -e "\033[92m  -->> SLOGAN:\033[93m $mess1 "' >> .bashrc
    echo 'echo "" ' >>.bashrc
    echo 'echo -e "\033[1;97m ❗️ PARA MOSTRAR PANEL ESCRIBA ❗️\033[92m menu o  MENU"' >> .bashrc
    update-locale LANG=en_US.UTF-8 LANGUAGE=en
    clear
    timeespera="1"
    times="5"
    if [ "$timeespera" = "1" ]; then
      msgi -bar2
      echo -e "\033[1;97m         ❗️ REGISTRANDO IP y KEY EN LA BASE ❗️            "
      msgi -bar2
      while [ $times -gt 0 ]; do
        echo -ne "                         -$times-\033[0K\r"
        sleep 1
        : $((times--))
      done
      msgi -bar
      echo -e " \033[1;92m              LISTO REGISTRO COMPLETO "  
      msgi -bar    
    fi
    #title "-- NEAR SCRIPT•MOD INSTALADO --"
  else
   [[ -e $HOME/lista-arq ]] && rm $HOME/lista-arq
   clear
   msg -bar
   print_center -verm2 "KEY INVALIDA"
   msg -bar
   print_center -ama "Esta key no es valida o ya fue usada"
   print_center -ama "Contacta con @Near365"
   msg -bar
   rm -rf ${module}
   exit
 fi
 mv -f ${module} /etc/ADMRufu/module
 time_reboot "10" 