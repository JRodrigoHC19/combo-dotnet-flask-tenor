FROM python:alpine

WORKDIR /src

COPY . .

RUN pip install -r requirements.txt

CMD ["flask", "run", "--host", "0.0.0.0"]