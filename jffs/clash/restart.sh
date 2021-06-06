if $(pidof clash) > /dev/null; then
	kill $(pidof clash)
fi
nohup /jffs/clash/clash -d /jffs/clash/ >/dev/null 2>&1 &	
