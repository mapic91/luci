module("luci.controller.dnsmasqswitch.usenormaldns", package.seeall)

function index()
    local e = entry({"admin", "network", "usenormaldns"}, call("do_action"), "Use ISP Dns", 101)
    e.dependent = false
end

function do_action()
    luci.sys.call("sed -i s/no-resolv/#no-resolv/g /etc/dnsmasq.conf")
    luci.sys.call("sed -i s/proxy-dnssec/#proxy-dnssec/g /etc/dnsmasq.conf")
    luci.sys.call("sed -i s/server=127.0.0.1#5453/#server=127.0.0.1#5453/g /etc/dnsmasq.conf")
    luci.http.prepare_content("text/plain")
    luci.http.write(luci.sys.exec("/etc/init.d/dnsmasq restart"))
    luci.http.write("Use ISP Dns now")
end