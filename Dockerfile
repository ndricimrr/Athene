FROM python:3.7.3
LABEL author="Jan Philip Bernius <janphilip.bernius@tum.de>"

COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -qr /tmp/requirements.txt

WORKDIR /usr/src/app
COPY src/ src/
RUN make -C src/resources

# Run the image as a non-root user
RUN groupadd -r textsim && useradd --no-log-init -r -g textsim textsim
USER textsim

CMD gunicorn src.app
EXPOSE 8000
