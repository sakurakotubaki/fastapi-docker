# PyCharm with Docker

Dockerfile:
```dockerfile
FROM python:3.12-alpine

RUN mkdir /app
WORKDIR /app

COPY main.py main.py
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
```

docker-compose.yml:
```yaml
version: '3'
services:
  web:
    build: .
    ports:
      - "8000:8000"
    volumes:
      - .:/app
```

requirements.txt:
```
fastapi>=0.68.0
uvicorn>=0.15.0
```

main.py:
```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.get("/items/{item_id}")
def read_item(item_id: int):
    return {"item_id": item_id}
```

主な変更点：
1. ベースイメージをPython 3.11-alpineに更新
2. ポートを8000に変更（FastAPIのデフォルト）
3. CMDをuvicornを使用するように変更
4. requirementsをFastAPI用に変更
5. volumesマウントを追加して開発時のホットリロードに対応

使い方：
```bash
# コンテナのビルドと起動
docker-compose up --build

# 確認用URL
http://localhost:8000        # Hello World
http://localhost:8000/docs   # SwaggerUI（API文書）
```

これで、PycharmからFastAPIの開発が可能になります。コードを変更すると自動的にリロードされます。