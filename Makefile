# 1. Nome do seu programa final
TARGET = bbb_blink.app

# 2. Compilador (use 'gcc' para compilar no PC ou na BeagleBone diretamente)
#    (use 'arm-linux-gnueabihf-gcc' para compilação cruzada no PC)
CC = arm-linux-gnueabihf-gcc

# 3. Opções de Compilação (Warnings e Caminhos de Include)
#    Adicione um '-I<caminho>' para cada pasta 'include' de biblioteca
CFLAGS = -Wall -Wextra -g \
         -Iinclude \
         -Ilibs/bbb_gpiolib/include \
         -Ilibs/bbb_logger/include

# 4. Bibliotecas do Sistema para Linkar (-l<nome_da_lib>)
#    Ex: -lgpiod para a libgpiod, -lm para a de matemática
LDLIBS = -lgpiod


# --- SEÇÃO AUTOMÁTICA (Geralmente não precisa mexer) ---

# Detecção automática dos seus arquivos fonte .c
SRCS = $(wildcard src/*.c)
LIB_SRCS = $(wildcard libs/bbb_gpiolib/src/*.c) \
           $(wildcard libs/bbb_logger/src/*.c) # Pega fontes de todas as libs

# Conversão de .c para .o (arquivos objeto)
OBJS = $(SRCS:.c=.o)
LIB_OBJS = $(LIB_SRCS:.c=.o)


# --- REGRAS DO MAKE ---

# Regra padrão: compila tudo
all: $(TARGET)

# Regra de Linkagem: junta tudo no executável final
$(TARGET): $(OBJS) $(LIB_OBJS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS) $(LIB_OBJS) $(LDLIBS)
	@echo "Programa '$(TARGET)' criado com sucesso!"

# Regra genérica para compilar .c em .o
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Regra para limpar o projeto
clean:
	@echo "Limpando..."
	rm -f $(TARGET) src/*.o libs/*_*/src/*.o

# Regra para executar (útil na BeagleBone)
run: all
	sudo ./$(TARGET)

# Regras que não geram arquivos
.PHONY: all clean run


