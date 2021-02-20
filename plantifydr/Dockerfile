FROM python:3.8.7-buster 
WORKDIR /app
ADD . /app
RUN pip install -r requirements.txt
ENTRYPOINT ["sh", "/app/entrypoint.sh"]