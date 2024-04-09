FROM python:3.9.15

# By default it will use Aliyun for pip package
# For people don't want to use Aliyun `docker build --build-arg="INSTALL_PIP_WITH_MIRROR=false" -t <some-image-tag> .`
ARG INSTALL_PIP_WITH_MIRROR=true

WORKDIR /app
COPY requirements.txt /app

RUN if [ ${INSTALL_PIP_WITH_MIRROR} = true ]; then \
    mkdir -p ~/.pip/ && \
    echo "[global]" > ~/.pip/pip.conf && \
    echo "index-url = https://mirrors.aliyun.com/pypi/simple/" >> ~/.pip/pip.conf && \
    echo "trusted-host = mirrors.aliyun.com" >> ~/.pip/pip.conf; \
fi

RUN pip3 install -r requirements.txt --no-cache-dir

COPY . /app
EXPOSE 8000
ENTRYPOINT ["python3"]
CMD ["server.py"]
