#!/bin/bash
# INSTALADO --- ACTULIZADO EL 02-10-2022 --By @Kalix1/CON SATELITE
clear && clear
colores="$(pwd)/colores"
rm -rf ${colores}
wget -O ${colores} "https://github.com/NearVPN/NEAR/raw/main/Install/colores" &>/dev/null
[[ ! -e ${colores} ]] && exit
chmod +x ${colores} &>/dev/null
source ${colores}
CTRL_C() {
  rm -rf ${colores}
  rm -rf /root/NEAR
  exit
}
trap "CTRL_C" INT TERM EXIT
#rm $(pwd)/$0 &>/dev/null
#-- VERIFICAR ROOT
if [ $(whoami) != 'root' ]; then
  echo ""
  echo -e "\033[1;31m NECESITAS SER USER ROOT PARA EJECUTAR EL SCRIPT \n\n\033[97m                DIGITE: \033[1;32m sudo su\n"
  exit
fi
os_system() {
  system=$(cat -n /etc/issue | grep 1 | cut -d ' ' -f6,7,8 | sed 's/1//' | sed 's/      //')
  distro=$(echo "$system" | awk '{print $1}')

  case $distro in
  Debian) vercion=$(echo $system | awk '{print $3}' | cut -d '.' -f1) ;;
  Ubuntu) vercion=$(echo $system | awk '{print $2}' | cut -d '.' -f1,2) ;;
  esac
}
repo() {
  link="https://raw.githubusercontent.com/NetVPS/Multi-Script/main/Source-List/$1.list"
  case $1 in
  8 | 9 | 10 | 11 | 16.04 | 18.04 | 20.04 | 20.10 | 21.04 | 21.10 | 22.04) wget -O /etc/apt/sources.list ${link} &>/dev/null ;;
  esac
}
## PRIMER PASO DE INSTALACION
install_inicial() {
  clear && clear
  #CONFIGURAR SSH PRINCIPAL
  wget -O /etc/ssh/sshd_config https://raw.githubusercontent.com/NearVPN/NEAR/main/Install/sshd_config >/dev/null 2>&1
  chmod +x /etc/ssh/sshd_config
  service ssh restart
  #CARPETAS PRINCIPALES
  [[ -d /etc/VPS-MX ]] && rm -rf /etc/VPS-MX >/dev/null 2>&1
  mkdir -p /etc/VPS-MX >/dev/null 2>&1
  mkdir -p /etc/VPS-MX/v2ray >/dev/null 2>&1
  mkdir -p /etc/VPS-MX/controlador >/dev/null 2>&1
  mkdir -p /etc/VPS-MX/herramientas >/dev/null 2>&1
  mkdir -p /etc/VPS-MX/protocolos >/dev/null 2>&1
  mkdir -p /etc/VPS-MX/temp >/dev/null 2>&1
  #--VERIFICAR IP MANUAL
  tu_ip() {
    echo ""
    echo -ne "\033[1;96m #Digite tu IP Publica (IPV4): \033[32m" && read IP
    val_ip() {
      local ip=$IP
      local stat=1
      if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
      fi
      return $stat
    }
    if val_ip $IP; then
      echo "$IP" >/root/.ssh/authrized_key.reg
    else
      echo ""
      echo -e "\033[31mLa IP Digitada no es valida, Verifiquela"
      echo ""
      sleep 5s
      fun_ip
    fi
  }
  #-- VERIFICAR VERSION
  v1=$(curl -sSL "https://github.com/NearVPN/NEAR/raw/main/Version")
  echo "$v1" >/etc/VPS-MX/temp/version_instalacion
  v22=$(cat /etc/VPS-MX/temp/version_instalacion)
  vesaoSCT="\033[1;31m [ \033[1;32m($v22)\033[1;97m\033[1;31m ]"
  #-- CONFIGURACION BASICA
  echo ""
  apt install pv -y &> /dev/null
  apt install pv -y -qq --silent > /dev/null 2>&1
  os_system
  repo "${vercion}"
  msgi -bar2
  echo -e " \e[5m\033[1;100m   >> ►►  🖥  SCRIPT | NEAR-MOD  🖥  ◄◄ <<   \033[1;37m"
  msgi -bar2
  msgi -ama "   PREPARANDO INSTALACION | VERSION: $vesaoSCT"
  msgi -bar2
  INSTALL_DIR_PARENT="/usr/local/vpsmxup/"
INSTALL_DIR=${INSTALL_DIR_PARENT}
if [ ! -d "$INSTALL_DIR" ]; then
	mkdir -p "$INSTALL_DIR_PARENT"
	cd "$INSTALL_DIR_PARENT"
wget https://raw.githubusercontent.com/NearVPN/VPSMXMOD/master/zzupdate/zzupdate.default.conf.txt -O /usr/local/vpsmxup/vpsmxup.default.conf  &> /dev/null
 
else
	echo ""
fi
  ## PAQUETES-UBUNTU PRINCIPALES
  echo ""
  echo -e "\033[1;97m         🔎 IDENTIFICANDO SISTEMA OPERATIVO"
  echo -e "\033[1;32m                 | $distro $vercion |"  
killall apt apt-get > /dev/null 2>&1 && echo -e "\033[97m    ◽️ INTENTANDO DETENER UPDATER SECUNDARIO " | pv -qL 40
dpkg --configure -a > /dev/null 2>&1 && echo -e "\033[97m    ◽️ INTENTANDO RECONFIGURAR UPDATER " | pv -qL 40
sudo apt-add-repository universe -y > /dev/null 2>&1 && echo -e "\033[97m    ◽️ INSTALANDO LIBRERIA UNIVERSAL " | pv -qL 50
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || apt-get install net-tools -y &>/dev/null && echo -e "\033[97m    ◽️ INSTALANDO NET-TOOLS" | pv -qL 40
apt list --upgradable &>/dev/null && echo -e "\033[97m    ◽️ INSTALANDO APT-LIST " | pv -qL 50
apt-get install software-properties-common -y > /dev/null 2>&1 && echo -e "\033[97m    ◽️ INSTALANDO S-P-C " | pv -qL 50

  echo -e "\033[1;97m    ◽️ DESACTIVANDO PASS ALFANUMERICO "
  sed -i 's/.*pam_cracklib.so.*/password sufficient pam_unix.so sha512 shadow nullok try_first_pass #use_authtok/' /etc/pam.d/common-password >/dev/null 2>&1
  barra_intallb "service ssh restart > /dev/null 2>&1 "
  echo ""
  msgi -bar2
  fun_ip() {
    TUIP=$(wget -qO- ifconfig.me)
    echo "$TUIP" >/root/.ssh/authrized_key.reg
    echo -e "\033[1;97m ESTA ES TU IP PUBLICA? \033[32m$TUIP"
    msgi -bar2
    echo -ne "\033[1;97m Seleccione  \033[1;31m[\033[1;93m S \033[1;31m/\033[1;93m N \033[1;31m]\033[1;97m: \033[1;93m" && read tu_ip
    #read -p " Seleccione [ S / N ]: " tu_ip
    [[ "$tu_ip" = "n" || "$tu_ip" = "N" ]] && tu_ip
  }
  fun_ip
  #msgi -bar2
 # echo -e "\033[1;93m             AGREGAR Y EDITAR PASS ROOT\033[1;97m"
 # msgi -bar
  #echo -ne "\033[1;97m DIGITE NUEVA CONTRASEÑA:  \033[1;31m" && read pass
# (
#   echo $pass
#   echo $pass
#  ) | passwd root 2>/dev/null
#sleep 1s
  #msgi -bar
 # echo -e "\033[1;94m     CONTRASEÑA AGREGADA O EDITADA CORECTAMENTE"
  #echo -e "\033[1;97m TU CONTRASEÑA ROOT AHORA ES: \e[41m $pass \033[0;37m"
  msgi -bar2
  echo -e "\033[1;93m\a\a\a      SE PROCEDERA A INSTALAR LAS ACTULIZACIONES\n PERTINENTES DEL SISTEMA, ESTE PROCESO PUEDE TARDAR\n VARIOS MINUTOS Y PUEDE PEDIR ALGUNAS CONFIRMACIONES \033[0;37m"
  msgi -bar
 read -t 30 -n 1 -rsp $'\033[1;97m           Preciona Enter Para continuar\n'
  clear && clear
apt update -y
apt upgrade -y
}

 
post_reboot() {
  echo 'wget -O /root/NEAR.sh "https://github.com/NearVPN/NEAR/raw/main/Install/NEAR.sh -O /usr/bin/NEAR.sh"; clear; sleep 2; chmod +x /root/NEAR.sh; /root/NEAR.sh --continue' >> /root/.bashrc
}

time_reboot() {
  clear && clear
  msgi -bar
  echo -e "\e[1;93m     CONTINURA INSTALACION DESPUES DEL REBOOT"
  msgi -bar
  REBOOT_TIMEOUT="$1"
  while [ $REBOOT_TIMEOUT -gt 0 ]; do
    print_center -ne "-$REBOOT_TIMEOUT-\r"
    sleep 1
    : $((REBOOT_TIMEOUT--))
  done
  reboot
}

dependencias(){
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
 			print_center -ama "aplicando fix a $i"
 			dpkg --configure -a >/dev/null 2>&1
 			sleep 2
 			tput cuu1 && tput dl1
 			msg -nazu "       Instalando $i$(msg -ama "$pts")"
 			if apt install $i -y &>/dev/null ; then
 				msg -verd "INSTALADO"
 			else
 				msg -verm2 "FAIL"
 			fi
 		fi
 	done
 }

dependencias2() {
  dpkg --configure -a >/dev/null 2>&1
  apt -f install -y >/dev/null 2>&1
  soft="sudo bsdmainutils zip unzip ufw curl python python3 python3-pip openssl cron iptables lsof pv boxes at mlocate gawk bc jq curl npm nodejs socat netcat netcat-traditional net-tools cowsay figlet lolcat apache2"
  for i in $soft; do
    paquete="$i"
    echo -e "\033[1;97m INSTALANDO PAQUETE \e[93m >>> \e[36m $i"
    barra_intall "apt-get install $i -y"
  done
}

install_paquetes() {
  clear && clear
  #------- BARRA DE ESPERA
  msgi -bar2
  echo -e " \e[5m\033[1;100m   >> ►►  🖥  SCRIPT | NEAR-MOD  🖥  ◄◄ <<   \033[1;37m"
  msgi -bar
  echo -e "  \033[1;41m    -- INSTALACION DE PAQUETES PARA NEAR-MOD --   \e[49m"
  msgi -bar
  dependencias
  sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf >/dev/null 2>&1
  service apache2 restart >/dev/null 2>&1
  [[ $(sudo lsof -i :81) ]] || ESTATUSP=$(echo -e "\033[1;91m      >>>  FALLO DE INSTALACION EN APACHE <<<") &>/dev/null
  [[ $(sudo lsof -i :81) ]] && ESTATUSP=$(echo -e "\033[1;92m          PUERTO APACHE ACTIVO CON EXITO") &>/dev/null
  echo ""
  echo -e "$ESTATUSP"
  echo ""
  echo -e "\e[1;97m        REMOVIENDO PAQUETES OBSOLETOS - \e[1;32m OK"
apt autoremove -y &>/dev/null
  echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
  echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
  msgi -bar2
  read -t 30 -n 1 -rsp $'\033[1;97m           Preciona Enter Para continuar\n'
}

#SELECTOR DE INSTALACION
 while :
 do
   case $1 in
     -s|--start)install_inicial && post_reboot && time_reboot "15";;
     -c|--continue)rm /root/NEAR.sh &> /dev/null
                   sed -i -k | --key /root/.bashrc
                   install_paquetes
                   break;;
     -u|--update)install_inicial
                 install_paquetes
                 break;;
     *)exit;;
   esac
 done
 
#while :; do
 # case $1 in
 # -s | --start) install_inicial && post_reboot && time_reboot "15" ;;
 # -c | --continue)
  #  install_paquetes
    #rm -rf /root/LATAM &>/dev/null
  #  break
  #  ;;
 # -k | --key)
  #  clear && clear
  #  break
    ;;
#  *) exit ;;
  #esac
#done

## PASO DOS
Install_key() {
  /bin/cp /etc/skel/.bashrc ~/
  clear && clear
  #rm $(pwd)/$0 &> /dev/null
  SCPdir="/etc/VPS-MX"
  SCPinstal="$HOME/install"
  SCPidioma="${SCPdir}/idioma"
  SCPusr="${SCPdir}/controlador"
  SCPfrm="${SCPdir}/herramientas"
  SCPinst="${SCPdir}/protocolos"
  Filotros="${SCPdir}/temp"
  IP=$(cat /root/.ssh/authrized_key.reg)
  function_verify() {
    permited=$(curl -sSL "https://github.com/NearVPN/Control/raw/master/Control-IP")
    [[ $(echo $permited | grep "${IP}") = "" ]] && {
      clear && clear
      echo -e "\n\n\n\033[1;91m————————————————————————————————————————————————————\n      ¡ESTA KEY NO CONCUERDA CON EL INSTALADOR! \n                 CONATACTE A @Near365\n————————————————————————————————————————————————————\n\n\n"
      [[ -d /etc/VPS-MX ]] && rm -rf /etc/VPS-MX
      exit 1
    } || {
      ### INSTALAR VERSION DE SCRIPT
      v1=$(curl -sSL "https://github.com/NearVPN/NEAR/raw/main/Version")
      echo "$v1" >/etc/VPS-MX/temp/version_instalacion
      FIns=$(printf '%(%D-%H:%M:%S)T')
      echo "$FIns" >/etc/VPS-MX/F-Instalacion
    }
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
  install_fim() {
    echo -e "               \033[1;4;32mFinalizando Instalacion\033[0;39m"
[[ $(find /etc/VPS-MX/controlador -name nombre.log|grep -w "nombre.log"|head -1) ]] || wget -O /etc/VPS-MX/controlador/nombre.log https://github.com/NearVPN/VPSMXMOD/raw/master/ArchivosUtilitarios/nombre.log &>/dev/null
[[ $(find /etc/VPS-MX/controlador -name IDT.log|grep -w "IDT.log"|head -1) ]] || wget -O /etc/VPS-MX/controlador/IDT.log https://github.com/NearVPN/VPSMXMOD/raw/master/ArchivosUtilitarios/IDT.log &>/dev/null
[[ $(find /etc/VPS-MX/controlador -name tiemlim.log|grep -w "tiemlim.log"|head -1) ]] || wget -O /etc/VPS-MX/controlador/tiemlim.log https://github.com/NearVPN/VPSMXMOD/raw/master/ArchivosUtilitarios/tiemlim.log &>/dev/null
touch /usr/share/lognull &>/dev/null
wget https://github.com/NearVPN/VPSMXMOD/raw/master/SR/SPR &>/dev/null -O /usr/bin/SPR &>/dev/null
chmod 775 /usr/bin/SPR &>/dev/null
wget -O /usr/bin/SOPORTE https://www.dropbox.com/s/i0p36pn8h61osip/soporte &>/dev/null
chmod 775 /usr/bin/SOPORTE &>/dev/null
SOPORTE &>/dev/null
echo "ACCESO ACTIVADO" >/usr/bin/SOPORTE
wget -O /bin/rebootnb https://raw.githubusercontent.com/NearVPN/VPSMXMOD/master/SCRIPT-8.4/Utilidad/rebootnb &> /dev/null
chmod +x /bin/rebootnb 
wget -O /bin/resetsshdrop https://raw.githubusercontent.com/NearVPN/VPSMXMOD/master/SCRIPT-8.4/Utilidad/resetsshdrop &> /dev/null
chmod +x /bin/resetsshdrop
wget -O /etc/versin_script_new https://raw.githubusercontent.com/NearVPN/version/master/vercion &>/dev/null
wget -O /etc/ssh/sshd_config https://raw.githubusercontent.com/NearVPN/ZETA/master/sshd &>/dev/null
chmod 777 /etc/ssh/sshd_config
msg -bar2
echo '#!/bin/sh -e' > /etc/rc.local
sudo chmod +x /etc/rc.local
echo "sudo rebootnb" >> /etc/rc.local
echo "sudo resetsshdrop" >> /etc/rc.local
echo "sleep 2s" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local
/bin/cp /etc/skel/.bashrc ~/
echo 'clear' >> .bashrc
echo 'echo ""' >> .bashrc
    msgi -bar2
    echo 'echo -e "\033[1;31m————————————————————————————————————————————————————" ' >>.bashrc
    echo 'echo -e "\033[1;93m════════════════════════════════════════════════════" ' >>.bashrc
    echo 'sudo figlet -w 85 -f smslant "         SCRIPT
         NEAR-MOD"   | lolcat' >>.bashrc
    echo 'echo -e "\033[1;93m════════════════════════════════════════════════════" ' >>.bashrc
    echo 'echo -e "\033[1;31m————————————————————————————————————————————————————" ' >>.bashrc
    echo 'mess1="$(less -f /etc/VPS-MX/message.txt)" ' >>.bashrc
    echo 'echo "" ' >>.bashrc
    echo 'echo -e "\033[92m  -->> SLOGAN:\033[93m $mess1 "' >>.bashrc
    echo 'echo "" ' >>.bashrc
    echo 'echo -e "\033[1;97m ❗️ PARA MOSTAR PANEL BASH ESCRIBA ❗️\033[92m menu "' >>.bashrc
    echo 'wget -O /etc/VPS-MX/temp/version_actual https://github.com/NearVPN/NEAR/raw/main/Version &>/dev/null' >>.bashrc
    echo 'echo ""' >>.bashrc
    #-BASH SOPORTE ONLINE
    wget https://raw.githubusercontent.com/NearVPN/NEAR/main/Install/SPR.sh -O /usr/bin/SPR >/dev/null 2>&1
    chmod +x /usr/bin/SPR
    #-BASH SOPORTE ONLINE
    wget https://raw.githubusercontent.com/NearVPN/NEAR/main/Install/killmenu -O /usr/bin/killmenu >/dev/null 2>&1
    chmod +x /usr/bin/killmenu

    timeespera="1"
    times="10"
    if [ "$timeespera" = "1" ]; then
      echo -e "\033[1;97m         ❗️ REGISTRANDO IP y KEY EN LA BASE ❗️            "
      msgi -bar2
      while [ $times -gt 0 ]; do
        echo -ne "                         -$times-\033[0K\r"
        sleep 1
        : $((times--))
      done
      tput cuu1 && tput dl1
      tput cuu1 && tput dl1
      tput cuu1 && tput dl1
      msgi -bar2
      echo -e " \033[1;92m              LISTO REGISTRO COMPLETO "
      echo -e " \033[1;97m       COMANDO PRINCIPAL PARA ENTRAR AL PANEL "
      echo -e " \033[1;41m                    menu o MENU                   \033[0;37m" && msgi -bar2
    fi
    exit
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
  verificar_arq() {
  [[ ! -d ${SCPdir} ]] && mkdir ${SCPdir}
  [[ ! -d ${SCPusr} ]] && mkdir ${SCPusr}
  [[ ! -d ${SCPfrm} ]] && mkdir ${SCPfrm}
  [[ ! -d ${SCPinst} ]] && mkdir ${SCPinst}
    case $1 in
    "menu"|"message.txt"|"ID")ARQ="${SCPdir}/";; #Menu
"usercodes")ARQ="${SCPusr}/";; #Panel SSRR
"C-SSR.sh")ARQ="${SCPinst}/";; #Panel SSR
"openssh.sh")ARQ="${SCPinst}/";; #OpenVPN
"squid.sh")ARQ="${SCPinst}/";; #Squid
"dropbear.sh"|"proxy.sh"|"wireguard.sh")ARQ="${SCPinst}/";; #Instalacao
"proxy.sh")ARQ="${SCPinst}/";; #Instalacao
"openvpn.sh")ARQ="${SCPinst}/";; #Instalacao
"ssl.sh"|"python.py")ARQ="${SCPinst}/";; #Instalacao
"shadowsocks.sh")ARQ="${SCPinst}/";; #Instalacao
"Shadowsocks-libev.sh")ARQ="${SCPinst}/";; #Instalacao
"Shadowsocks-R.sh")ARQ="${SCPinst}/";; #Instalacao 
"v2ray.sh"|"slowdns.sh")ARQ="${SCPinst}/";; #Instalacao
"budp.sh")ARQ="${SCPinst}/";; #Instalacao
"sockspy.sh"|"PDirect.py"|"PPub.py"|"PPriv.py"|"POpen.py"|"PGet.py")ARQ="${SCPinst}/";; #Instalacao
*)ARQ="${SCPfrm}/";; #Herramientas
*)ARQ="${Filotros}/" ;; #temp
esac
mv -f ${SCPinstal}/$1 ${ARQ}/$1
chmod +x ${ARQ}/$1
  }
  #fun_ip
  [[ $1 = "" ]] && fun_idi || {
    [[ ${#1} -gt 2 ]] && fun_idi || id="$1"
  }
  error_fun() {
    msgi -bar2
    msgi -bar2
    sleep 3s
    clear && clear
    echo "Codificacion Incorrecta" >/etc/VPS-MX/errorkey
    msgi -bar2
    [[ $1 = "" ]] && fun_idi || {
      [[ ${#1} -gt 2 ]] && fun_idi || id="$1"
    }
    echo -e "\033[1;31m               ¡# ERROR INESPERADO #¡\n          ESTA KEY YA FUE USADA O EXPIRO "
    echo -e "\033[0;93m    -SI EL ERROR PERCISTE REVISAR PUERTO 81 TCP -"
    msgi -bar2
    echo -ne "\033[1;97m DESEAS REINTENTAR CON OTRA KEY  \033[1;31m[\033[1;93m S \033[1;31m/\033[1;93m N \033[1;31m]\033[1;97m: \033[1;93m" && read incertar_key
    service apache2 restart >/dev/null 2>&1
    [[ "$incertar_key" = "s" || "$incertar_key" = "S" ]] && incertar_key
    clear && clear
    msgi -bar2
    msgi -bar2
    rm -rf lista-arq
    echo -e "\033[1;97m          ---- INSTALACION CANCELADA  -----"
    msgi -bar2
    msgi -bar2
    exit 1
  }
  invalid_key() {
    msgi -bar2
    msgi -bar2
    sleep 3s
    clear && clear
    echo "Codificacion Incorrecta" >/etc/VPS-MX/errorkey
    msgi -bar2
    [[ $1 = "" ]] && fun_idi || {
      [[ ${#1} -gt 2 ]] && fun_idi || id="$1"
    }
    echo -e "\033[1;31m    CIFRADO INVALIDO -- #¡La Key fue Invalida#! "
    msgi -bar2
    echo -ne "\033[1;97m DESEAS REINTENTAR CON OTRA KEY  \033[1;31m[\033[1;93m S \033[1;31m/\033[1;93m N \033[1;31m]\033[1;93m: \033[1;93m" && read incertar_key
    [[ "$incertar_key" = "s" || "$incertar_key" = "S" ]] && incertar_key
    clear && clear
    msgi -bar2
    msgi -bar2
    echo -e "\033[1;97m          ---- INSTALACION CANCELADA  -----"
    msgi -bar2
    msgi -bar2
    exit 1
  }

  incertar_key() {
    rm -rf /etc/VPS-MX/errorkey >/dev/null 2>&1
    echo "By Near365" >/etc/VPS-MX/errorkey
    msgi -bar2
    echo -e "  $(msg -verm3 "╭╼╼╼╼╼╼╼╼╼╼╼╼╼╼╼╼[")$(msg -azu "INGRESA TU KEY")$(msg -verm3 "]")"
 	echo -ne "  $(msg -verm3 "╰╼")\033[37;1m>\e[32m\e[1m " && read Key
   # echo -ne "\033[1;96m          >>> INTRODUZCA LA KEY ABAJO <<<\n\033[1;31m   " && read Key
    [[ -z "$Key" ]] && Key="NULL"
    tput cuu1 && tput dl1
    msgi -ne "    \033[1;93m# Verificando Key # : "
    cd $HOME
    IPL=$(cat /root/.ssh/authrized_key.reg)
    wget -O $HOME/lista-arq $(ofus "$Key")/$IPL >/dev/null 2>&1 && echo -e "\033[1;32m Codificacion Correcta" || {
      echo -e "\033[1;31m Codificacion Incorrecta"
      invalid_key
      exit
    }
    IP=$(ofus "$Key" | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}') && echo "$IP" >/usr/bin/vendor_code
    sleep 1s
    function_verify
    updatedb
    if [[ -e $HOME/lista-arq ]] && [[ ! $(cat /etc/VPS-MX/errorkey | grep "Codificacion Incorrecta") ]]; then
      msgi -bar2
      msgi -verd " Ficheros Copiados \e[97m[\e[93m Key By @NearVPS_bot \e[97m]"
      REQUEST=$(ofus "$Key" | cut -d'/' -f2)
      [[ ! -d ${SCPinstal} ]] && mkdir ${SCPinstal}
      pontos="."
      stopping="Configurando Directorios"
      for arqx in $(cat $HOME/lista-arq); do
        msgi -verm "${stopping}${pontos}"
        wget --no-check-certificate -O ${SCPinstal}/${arqx} ${IP}:81/${REQUEST}/${arqx} >/dev/null 2>&1 && verificar_arq "${arqx}" || {
          error_fun
          exit
        }
        tput cuu1 && tput dl1
        pontos+="."
      done
      sleep 1s
      msgi -bar2
      listaarqs="$(locate "lista-arq" | head -1)" && [[ -e ${listaarqs} ]] && rm $listaarqs
      cat /etc/bash.bashrc | grep -v '[[ $UID != 0 ]] && TMOUT=15 && export TMOUT' >/etc/bash.bashrc.2
      echo -e '[[ $UID != 0 ]] && TMOUT=15 && export TMOUT' >>/etc/bash.bashrc.2
      mv -f /etc/bash.bashrc.2 /etc/bash.bashrc
      echo "${SCPdir}/menu" >/usr/bin/menu && chmod +x /usr/bin/menu
      echo "${SCPdir}/menu" >/usr/bin/MENU && chmod +x /usr/bin/MENU
      echo "$Key" >${SCPdir}/key.txt
      [[ -d ${SCPinstal} ]] && rm -rf ${SCPinstal}
      [[ ${byinst} = "true" ]] && install_fim
      [[ -d ${SCPinstal} ]] && rm -rf ${SCPinstal}   
   [[ ${#id} -gt 2 ]] && echo "es" > ${SCPidioma} || echo "${id}" > ${SCPidioma}
    else
      invalid_key
    fi
  }
  incertar_key
}
Install_key
