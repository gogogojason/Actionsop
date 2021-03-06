# cd $WORK_PATH 目录下,先运行的 public.h -> 设备.h -> scripts/feeds install -a
# 定义部分以及需要添加对应APP必须的文件
device_name='JasonRouter'                                                      # 自定义设备名
wifi_name="RMWiFi"                                                          # 自定义Wifi 名字
lan_ip='192.168.2.1'                                                        # 自定义Lan Ip地址
utc_name='Asia\/Shanghai'                                                   # 自定义时区
ver_name='D200709'                                                          # 版本号
delete_bootstrap=false                                                      # 是否删除默认主题 true 、false
default_theme='luci-theme-argon_new'                                        # 默认主题 结合主题文件夹名字
theme_argon='https://github.com/sypopo/luci-theme-argon-mc.git'             # 主题地址
openClash_url='https://github.com/vernesong/OpenClash.git'                  # OpenClash包地址
adguardhome_url='https://github.com/rufengsuixing/luci-app-adguardhome.git' # adguardhome 包地址
lienol_url='https://github.com/Lienol/openwrt-package.git'                  # Lienol 包地址
vssr_url_rely='https://github.com/jerrykuku/lua-maxminddb.git'              # vssr lua-maxminddb依赖
vssr_url='https://github.com/jerrykuku/luci-app-vssr.git'                   # vssr地址
filter_url='https://github.com/destan19/OpenAppFilter.git'                  # AppFilter 地址
smartdns_url='https://github.com/pymumu/openwrt-smartdns'                   # SmartDNS运行程序
smartdnsapp_url='https://github.com/pymumu/luci-app-smartdns.git'           # SmartDNS-App
serverchan_url='https://github.com/tty228/luci-app-serverchan.git'          # serverchan备份包

#下面是执行具体操作

echo "修改机器名称"
sed -i "s/OpenWrt/$device_name/g" package/base-files/files/bin/config_generate

echo "修改wifi名称"
sed -i "s/OpenWrt/$wifi_name/g" package/kernel/mac80211/files/lib/wifi/mac80211.sh

echo "设置lan ip"
sed -i "s/192.168.1.1/$lan_ip/g" package/base-files/files/bin/config_generate

#echo "修改argon主题背景色"
#sed -i "s/#5e72e4/#00C000/g" feeds/otherpackges/luci-theme-argon_new/luasrc/view/themes/argon/header.htm

echo "修改时区"
sed -i "s/'UTC'/'CST-8'\n   set system.@system[-1].zonename='$utc_name'/g" package/base-files/files/bin/config_generate

echo "修改默认主题"
sed -i 's/+luci-theme-bootstrap/+luci-theme-argon_new/g' feeds/luci/collections/luci/Makefile
sed -i "s/bootstrap/argon/g" feeds/luci/modules/luci-base/root/etc/config/luci
#sed -i '/\+luci-theme-bootstrap/d' package/feeds/luci/luci/Makefile
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap

echo "修改版本信息"
sed -i "s/R20.7.7/R20.7.7\/hfy166 Ver.$ver_name/g" package/lean/default-settings/files/zzz-default-settings

#echo '添加serverchan'
#git clone $serverchan_url package/luci-app-serverchan
#echo 'CONFIG_PACKAGE_luci-app-serverchan=y' >> .config

#echo '添加主题argon'
#git clone $theme_argon package/lean/luci-theme-argon-mc
#echo 'CONFIG_PACKAGE_luci-theme-argon-mc=y' >> .config

#echo '添加luci-app-smartdns'
#git clone -b lede $smartdnsapp_url package/lean/luci-app-smartdns
#echo 'CONFIG_PACKAGE_luci-app-smartdns=y' >> .config

#echo '添加smartdns'
#git clone $smartdns_url feeds/packages/net/smartdns/
#echo 'CONFIG_PACKAGE_smartdns=y' >> .config

#echo '添加openclash'
#git clone $openClash_url package/lean/luci-app-openclash
#echo 'CONFIG_PACKAGE_luci-app-openclash=y' >> .config
#echo 'CONFIG_PACKAGE_luci-i18n-openclash-zh-cn=y'  >> .config

#echo '添加Passwall'
#git clone $passwall_url package/passwall
#echo 'CONFIG_PACKAGE_luci-app-passwall=y' >> .config
#echo 'CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks=y' >> .config
#echo 'CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Trojan=y' >> .config
#echo 'CONFIG_PACKAGE_luci-app-passwall_INCLUDE_simple-obfs=y' >> .config
#echo 'CONFIG_PACKAGE_luci-app-passwall_INCLUDE_v2ray-plugin=y' >> .config
#echo 'CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Brook=y' >> .config
#echo 'CONFIG_PACKAGE_luci-app-passwall_INCLUDE_kcptun=y' >> .config
#echo 'CONFIG_PACKAGE_luci-i18n-passwall-zh-cn=y'  >> .config


echo '添加adguardhome'
git clone $adguardhome_url package/lean/luci-app-adguardhome
#echo 'CONFIG_PACKAGE_luci-app-adguardhome=y' >> .config
#echo 'CONFIG_PACKAGE_luci-i18n-adguardhome-zh-cn=y'  >> .config


echo '添加HelloWord,并使用包默认的配置'  # TODO 这个的配置文件和SSP 冲突
git clone $vssr_url_rely package/lean/lua-maxminddb
git clone $vssr_url package/lean/luci-app-vssr
#echo 'CONFIG_PACKAGE_luci-app-vssr=y' >> .config
#echo 'CONFIG_PACKAGE_luci-i18n-vssr-zh-cn=y'  >> .config

echo '添加Lienol包'
git clone $lienol_url package/Lienol

echo '添加filebrowser'
echo 'CONFIG_PACKAGE_luci-app-filebrowser=y' >> .config
echo 'CONFIG_PACKAGE_luci-i18n-filebrowser-zh-cn=y'  >> .config

echo '添加OpenAppFilter过滤器'
git clone $filter_url package/OpenAppFilter
#echo 'CONFIG_PACKAGE_luci-app-oaf=y' >> .config
#echo 'CONFIG_PACKAGE_kmod-oaf=y' >> .config
#echo 'CONFIG_PACKAGE_appfilter=y' >> .config
#echo 'CONFIG_PACKAGE_luci-i18n-oaf-zh-cn=y'  >> .config

 #echo '添加Leo-Jo-My的Hello World,并且使用默认包配置'
 #git clone $vssr_plus_rely package/diy
 #git clone $vvssr_plus package/luci-app-vssr-plus
 #echo 'CONFIG_PACKAGE_luci-app-vssr-plus=y' >> .config
 #echo 'CONFIG_PACKAGE_luci-i18n-vssr-plus-zh-cn=y'  >> .config
