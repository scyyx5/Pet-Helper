FROM python:3.9-buster

WORKDIR /app

RUN mkdir -p /app
COPY . /app/

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN pip install --upgrade pip 
RUN pip install -r requirements.txt

EXPOSE 4444
CMD ["python", "catvsdog.py"]