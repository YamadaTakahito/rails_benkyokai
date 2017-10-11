dev:
	docker-compose up -d
	docker exec rails_benkyokai_app rails db:create
	docker exec rails_benkyokai_app rails db:migrate
	docker exec -it rails_benkyokai_app bash

stop:
	docker-compose stop

clean:
	sh script/clean.sh
