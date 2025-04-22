
.PHONY: start deploy clean test
.IGNORE: deploy


comment ?= update


# for push code to git
push-code:
	git add .
	git commit -m "$(comment)"
	git push

# check code before commit
pre-commit:
	npm run lint
	npm run build

# update code
update:
	git fetch
	git pull

# deploy app
deploy:
	docker network create nginx-net
	docker compose -p nginx up -d --build
