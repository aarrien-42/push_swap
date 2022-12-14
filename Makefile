# Normbre del ejecutable
NAME = push_swap

# Directorios
SRC_DIR = srcs/
OBJ_DIR = objs/
OBJF = objs
INC = incs

# Ficheros
SRC_FILES = ft_push_swap ft_push_swap_utils ft_movements ft_doubles \
			ft_checks ft_mark ft_algorithm ft_free
SRC = $(addprefix $(SRC_DIR), $(addsuffix .c, $(SRC_FILES)))
OBJ = $(addprefix $(OBJ_DIR), $(addsuffix .o, $(SRC_FILES)))

# Comandos
CC = gcc
CFLAGS = -Wall -Werror -Wextra -g #-fsanitize=address -g3
RM = rm -f
AR = ar rcs

# REGLAS #
all: $(NAME)

# Compilar conjuntamente
$(NAME): $(OBJ)
	@$(MAKE) -C ./libft
	@mv ./libft/libft.a .
	@echo "libft compiled!"
	@$(CC) $(CFLAGS) $(OBJ) libft.a -o $(NAME)
	@echo "push swap compiled!"

# Compilar objetos individualmente y meterlos al directorio correspodiente mediante una pipe
$(OBJ_DIR)%.o: $(SRC_DIR)%.c | $(OBJF)
	@echo "Compiling: $<"
	@$(CC) $(CFLAGS) -I $(INC) -c $< -o $@

# Crear directorio temporal para los obj
$(OBJF):
	@mkdir -p $(OBJ_DIR)

# Eliminar temporales
clean:
	@$(MAKE) -C ./libft clean
	@$(RM) -r $(OBJ_DIR)
	@echo "Objects and directory cleaned!"

# Eliminar temporales y ejecutable
fclean: clean
	@$(MAKE) -C ./libft fclean
	@$(RM) $(NAME) libft.a
	@echo "Executable cleaned!"

re: fclean all

norm:
	@norminette $(SRC) $(INC)

.PHONY: all clean fclean re
