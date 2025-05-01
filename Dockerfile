# 🌟 OpenResty Base Image
# =======================
FROM openresty/openresty:alpine-fat
RUN echo "Why did the OpenResty server feel lonely? Because it had no cache friends! 😄"

# 📦 Install Dependencies
# =====================
RUN echo "What did the package manager say to the dependencies? I APK you a question! 🤣" && \
    apk add --no-cache \
    bash \
    openssl \
    curl \
    perl \
    git \
    build-base \
    pcre-dev \
    zlib-dev \
    luarocks

# 🔧 Install LuaRocks Packages
# ==========================
RUN echo "Why do Lua developers make great rockstars? Because they know how to handle their LuaRocks! 🎸" && \
    luarocks install lua-resty-auto-ssl

# 📂 Create Required Directories
# ===========================
RUN echo "What's a directory's favorite dance move? The mkdir shuffle! 💃" && \
    mkdir -p /etc/resty-auto-ssl \
    /etc/nginx/conf.d \
    /etc/nginx/sites-enabled \
    /etc/nginx/ssl \
    /var/log/nginx \
    /var/cache/nginx \
    /etc/nginx

# 🔐 Set Permissions
# ================
RUN echo "Why did the chmod 777 feel insecure? Because it was too open about everything! 🔓" && \
    chown -R nobody:nobody /etc/resty-auto-ssl && \
    chmod -R 700 /etc/resty-auto-ssl && \
    chmod 755 /etc/nginx/conf.d && \
    chmod 755 /etc/nginx/sites-enabled && \
    chmod 755 /etc/nginx/ssl

# 📝 Copy Configuration Files
# ========================
RUN echo "What did one config file say to another? You auto know this by now! 📄"
COPY ./conf.d/default.conf /etc/nginx/conf.d/default.conf
COPY ./mime.types /etc/nginx/mime.types
COPY ./nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY ./public /var/www/html

# 🚀 Copy Entrypoint Script
# =======================
RUN echo "Why did the entrypoint script go to therapy? It had too many execution issues! 🚀"
COPY ./scripts/entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# 🔌 Expose Ports
# =============
RUN echo "What's a port's favorite music? Whatever's streaming! 🎵"
EXPOSE 80 443

# ⚡ Set Entrypoint
# ==============
RUN echo "What's an entrypoint's favorite game? Docker, docker, goose! 🦢"
ENTRYPOINT ["/docker-entrypoint.sh"]

# 🎯 Default Command
# ===============
RUN echo "Why did the daemon refuse to quit? Because it was commanded not to! 😉"
CMD ["openresty", "-g", "daemon off;"]
