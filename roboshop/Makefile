help:           ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
common:
	@sh component/common.sh
frontend: common ## Install frontend
	@sh component/frontend.sh
cart: common  ## Install cart
	@sh component/cart.sh
mongodb: common ## Install mongodb
	@sh component/mongodb.sh
cart: common ## Install cart
	@sh component/cart.sh

