TARGETS=ghostsim

all:			${TARGETS}

ghostsim:		main.c action.c evidence.c house.c room.c init.c logger.c utils.c
				gcc -Wall -Wextra -Werror -g -o ghostsim main.c action.c evidence.c house.c room.c init.c logger.c utils.c

clean:
				rm -f ${TARGETS}