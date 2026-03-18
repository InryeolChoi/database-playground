# database-playground
SQL 연습 및 DB 공부용 레포

## PostgreSQL with Docker

### 1. 이미지 빌드

```bash
docker build -t db-playground-postgres .
```

### 2. 컨테이너 실행

아래 예시는 데이터를 볼륨 `pgdata`에 저장하므로 컨테이너를 지워도 DB 파일은 유지됩니다.

```bash
docker run --name db-playground-postgres \
  -p 5432:5432 \
  -v pgdata:/var/lib/postgresql/data \
  -e POSTGRES_DB=practice_db \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -d db-playground-postgres
```

기본 설정은 다음과 같습니다.

- DB 이름: `practice_db`
- 사용자: `postgres`
- 비밀번호: `postgres`
- 포트: `5432`

### 3. 접속 확인

컨테이너 로그 확인:

```bash
docker logs db-playground-postgres
```

컨테이너 안에서 `psql` 실행:

```bash
docker exec -it db-playground-postgres psql -U postgres -d practice_db
```

예시 SQL:

```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

INSERT INTO users (name) VALUES ('alice'), ('bob');

SELECT * FROM users;
```

### 4. 자주 쓰는 명령어

중지:

```bash
docker stop db-playground-postgres
```

재시작:

```bash
docker start db-playground-postgres
```

삭제:

```bash
docker rm -f db-playground-postgres
```

볼륨까지 완전히 삭제:

```bash
docker volume rm pgdata
```

### 5. 환경변수 바꾸기

다른 DB 이름이나 비밀번호를 쓰고 싶다면 `docker run`의 `-e` 값을 바꾸면 됩니다.

```bash
docker run --name db-playground-postgres \
  -p 5432:5432 \
  -v pgdata:/var/lib/postgresql/data \
  -e POSTGRES_DB=my_db \
  -e POSTGRES_USER=my_user \
  -e POSTGRES_PASSWORD=my_password \
  -d db-playground-postgres
```

이미 같은 이름의 볼륨 `pgdata`를 사용 중이었다면, 기존 데이터가 남아 있어 새 환경변수가 바로 반영되지 않을 수 있습니다. 그 경우 컨테이너와 볼륨을 함께 지우고 다시 시작해야 합니다.
