FROM ubuntu:latest
# Step 2
# Essential tools and xvfb
RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
RUN apt-get install -y \
    software-properties-common \
    unzip \
    curl \
    xvfb \
    wget \
    libfontconfig \
    gnupg \
    --no-install-recommends apt-utils \
    python3-pip \
    default-jre-headless \
    libxml2-dev \
    libxslt-dev \
    zlib1g-dev \
    net-tools \
    default-jre \
    default-jdk \
    zip \
    unzip \
    build-essential \
    autoconf \
    libtool \
    pkg-config \
    python3-dev \
    libglib2.0-0 \
    apt-utils \
    libgl1-mesa-dev \
    libaspell-dev aspell \
    python3-setuptools
# Install Chrome / Puppeteer dependencies
RUN apt-get install -y libpangocairo-1.0-0 \
    libx11-xcb1 libxcomposite1 libxdamage1 \
    libxi6 libxtst6 libnss3 libcups2 libxss1 \
    libxrandr2 libasound2 libatk1.0-0 libgtk-3-0
# Step 3 - Setup Browsers
# Install PhantomJS
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 
RUN tar xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2 -C /usr/local/share/ 
RUN ln -sf /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin 
# Install Selenium driver dependency: Chrome
RUN echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google-chrome.list &&\
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - &&\
apt-get update &&\
apt-get -y install google-chrome-stable
# Install Selenium Chromedriver
RUN apt-get -y install unzip &&\
wget -q https://chromedriver.storage.googleapis.com/85.0.4183.87/chromedriver_linux64.zip &&\
unzip chromedriver_linux64.zip &&\
mv chromedriver /usr/bin/chromedriver &&\
chown root:root /usr/bin/chromedriver &&\
chmod +x /usr/bin/chromedriver &&\
rm chromedriver_linux64.zip
# Install Chromium-browser
RUN apt-get -y install chromium-browser
