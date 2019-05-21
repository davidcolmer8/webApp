PYTHON=python3
PKG_NAME=app

ROOT_DIR:=$(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
VENV=$(ROOT_DIR)/venv
flake8=$(VENV)/bin/flake8
pip=$(VENV)/bin/pip3
pytest=$(VENV)/bin/pytest
bandit=$(VENV)/bin/bandit
black=$(VENV)/bin/black
python=$(VENV)/bin/$(PYTHON)
coverage=$(VENV)/bin/coverage

$(VENV):
	cp scripts/pre-commit.sh .git/hooks/
	$(PYTHON) -m venv $(VENV)

$(VENV)/bin/$(PKG_NAME): $(VENV)
	$(pip) install .

venv: $(VENV)

install: $(VENV)/bin/$(PKG_NAME)

dev-install: $(pytest)

$(pytest): $(VENV)
	$(pip) install -e .[dev]

lint: $(pytest)
	$(black) $(PKG_NAME)
	$(flake8) $(PKG_NAME)

test: $(pytest)
	$(pytest) -v --cov-branch --cov=tests/unit --cov-report=term
	$(coverage) report -m --fail-under=50

scan:
	$(bandit) -r app/

run:
	$(VENV)/bin/$(PKG_NAME) run

clean:
	rm -rf $(VENV)
	rm -rf dist
	rm -rf $(PKG_NAME).egg-info

docker-start-dev-env:
	docker build -t website-app .
	docker run --entrypoint /bin/sh -v $(CURDIR):/src --name website-app-dev-env -itd website-app
	docker exec website-app-dev-env pip3 install -e .[dev]
	docker attach website-app-dev-env

docker-stop-dev-env:
	docker stop website-app-dev-env
	docker rm website-app-dev-env

docker-build:
	docker build -t website-app .

docker-run:
	docker run -p 5000:5000 --name website-app -td website-app 
	docker ps -l

docker-stop:
	docker stop website-app

docker-remove:
	docker rmi -f website-app
