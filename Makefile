all:
	lb config
	sudo lb build

config:
	lb config

clean:
	lb clean

cleanall:
	lb clean
	sudo rm -rf chroot
	sudo rm -rf cache
	sudo rm -rf local
	sudo rm -rf *.log
	sudo rm -rf .build
	sudo rm -rf .stage
	
