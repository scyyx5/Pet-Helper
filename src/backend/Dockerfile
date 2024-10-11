FROM python:3.9-buster

WORKDIR /app

RUN mkdir -p /app
COPY . /app/

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN pip install --upgrade pip 
RUN pip install -r requirements.txt

EXPOSE 8000
CMD python manage.py runserver_plus --keep-meta-shutdown --cert-file certs/pethelper.bham.team+2.pem --key-file certs/pethelper.bham.team+2-key.pem
# CMD ["python", "manage.py", "runserver_plus 0.0.0.0:8000", "--cert-file certs/pethelper.bham.team+2.pem", "--key-file certs/pethelper.bham.team+2-key.pem"]
