FROM python:3.12-alpine

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# コマンドを明示的に指定
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]