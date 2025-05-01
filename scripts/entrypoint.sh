#!/bin/bash
set -e

# 🌟 ==========================================
# 🚀 Nginx Entrypoint Script 
# 🔧 Handles SSL, configs and initialization
# 🎭 Warning: Contains dad jokes!
# ==========================================

# 🎯 Function to wait for the app to be ready
# Why did the app take so long to respond? 
# Because it was taking a byte to eat! 🥁
# ------------------------------------------
wait_for_app() {
    echo "🔄 Waiting for app to be ready..."
    while ! curl -s https://app.airley.io/ > /dev/null; do
        sleep 2
    done
    echo "✅ App is ready and accepting connections! (That's what TCP said to UDP!)"
}

# 🔐 Generate fallback SSL certificate if not exists
# Why did the SSL certificate go to therapy?
# It had too many trust issues! 
# -----------------------------------------------
setup_ssl() {
    if [ ! -f /etc/nginx/ssl/resty-auto-ssl-fallback.key ]; then
        echo "🔑 Generating secure fallback SSL certificate... (This is the key to our relationship!)"
        openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 \
            -subj '/CN=sni-support-required-for-valid-ssl' \
            -keyout /etc/nginx/ssl/resty-auto-ssl-fallback.key \
            -out /etc/nginx/ssl/resty-auto-ssl-fallback.crt
        echo "✨ SSL certificate generated successfully! (It's certified to make you smile!)"
    fi
}

# 🔧 Initialize auto-ssl
# Why did the SSL certificate automate itself?
# Because it was tired of manual labor!
# -------------------
init_auto_ssl() {
    echo "🔧 Initializing auto-ssl service... (It's like autopilot for certificates!)"
    if [ ! -f /etc/resty-auto-ssl/resty-auto-ssl-socket ]; then
        mkdir -p /etc/resty-auto-ssl
        chown -R nobody:nobody /etc/resty-auto-ssl
        chmod -R 700 /etc/resty-auto-ssl
        echo "✨ Auto-SSL initialized successfully! (Now it can SSL-eep peacefully!)"
    fi
}

# 🚀 Main Initialization Function
# Why did the main function go to the doctor?
# Because it had too many dependencies!
# ----------------------------
main() {
    echo "🌟 Starting Nginx initialization... (Time to ship some bits!)"
    wait_for_app
    setup_ssl
    init_auto_ssl
    
    echo "✨ All systems go! Starting OpenResty... (Rest-y assured, we're ready!)"
    echo "🎉 Nginx is ready to sail the digital seas! (Water you waiting for?)"
    exec "$@"
}

# 🎬 Execute Main Function
# Why did the function call its executor?
# Because it needed some arguments resolved!
main "$@"