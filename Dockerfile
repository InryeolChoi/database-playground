FROM postgres:16

# Default values are convenient for local SQL practice and can be overridden
# with `docker run -e ...` or a compose file later.
ENV POSTGRES_DB=practice_db
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres

EXPOSE 5432
