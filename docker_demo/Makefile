all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   1. make build            - build all images"
	@echo "   1. make pull             - pull all images"
	@echo "   1. make clean            - remove all images"
	@echo ""

build:
	@docker build --tag=tmc/ros:indigo-tmc-desktop-full tmc-desktop-full/

clean:
	@docker rmi -f tmc/ros:indigo-tmc-desktop-full
