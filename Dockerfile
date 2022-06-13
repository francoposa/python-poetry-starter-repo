FROM python:3.8-bullseye
MAINTAINER francoposa <franco@francoposa.io>

RUN groupadd -r app && \
    useradd -r -m -g app -d /home/app -s /sbin/nologin app
USER app
WORKDIR /home/app

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    POETRY_HOME="/home/app/.local/bin" \
    POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_CREATE=false

ENV PATH="$POETRY_HOME/bin:$PATH"
RUN curl -sSL https://install.python-poetry.org | python3 -

WORKDIR /home/app/src
COPY ./pyproject.toml .
#COPY ./poetry.lock .

RUN poetry install --no-root --no-dev

COPY ./*py ./

CMD ["/usr/bin/env", "bash"]
