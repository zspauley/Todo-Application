FROM python:3.9-slim-buster

WORKDIR /app

COPY . /app

RUN pip install Flask
RUN pip install Flask-SQLAlchemy

ENV FLASK_APP=app.py
ENV FLASK_DEBUG=0

EXPOSE 5000

CMD ["flask", "run", "--host=0.0.0.0"]