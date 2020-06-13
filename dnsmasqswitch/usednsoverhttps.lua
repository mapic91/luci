module("luci.controller.dnsmasqswitch.usednsoverhttps", package.seeall)

function index()
    local e = entry({"admin", "network", "usednsoverhttps"}, call("do_action"), "Use Dns Over Https", 100)
    e.dependent = false
end

function do_action()
    luci.sys.call("sed -i s/#no-resolv/no-resolv/g /etc/dnsmasq.conf")
    luci.sys.call("sed -i s/#proxy-dnssec/proxy-dnssec/g /etc/dnsmasq.conf")
    luci.sys.call("sed -i s/#server=127.0.0.1#5453/server=127.0.0.1#5453/g /etc/dnsmasq.conf")
    luci.http.prepare_content("text/plain")
    luci.http.write(luci.sys.exec("/etc/init.d/dnsmasq restart"))
    luci.http.write("Dns over https enabled")
end