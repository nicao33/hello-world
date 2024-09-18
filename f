#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_USERS 10
#define USERNAME_LEN 20
#define PASSWORD_LEN 20
#define MAX_PRODUCTS 50
#define PRODUCT_NAME_LEN 50

typedef struct {
    char username[USERNAME_LEN];
    char password[PASSWORD_LEN];
} User;

typedef struct {
    char name[PRODUCT_NAME_LEN];
    int quantity;
    float price;
} Product;

User users[MAX_USERS];
Product products[MAX_PRODUCTS];
int user_count = 0;
int product_count = 0;

// Funções de gerenciamento de usuários
void add_user(const char *username, const char *password) {
    if (user_count >= MAX_USERS) {
        printf("\nNúmero máximo de usuários atingido.\n");
        return;
    }
    strncpy(users[user_count].username, username, USERNAME_LEN);
    strncpy(users[user_count].password, password, PASSWORD_LEN);
    user_count++;
}

int authenticate(const char *username, const char *password) {
    for (int i = 0; i < user_count; i++) {
        if (strcmp(users[i].username, username) == 0 &&
            strcmp(users[i].password, password) == 0) {
            return 1;
        }
    }
    return 0;
}

void register_user() {
    char username[USERNAME_LEN];
    char password[PASSWORD_LEN];

    printf("\n--- Registro de Usuário ---\n");
    printf("Digite o nome de usuário: ");
    scanf("%s", username);
    printf("Digite a senha: ");
    scanf("%s", password);

    add_user(username, password);
    printf("\nUsuário registrado com sucesso!\n");
}

void login_user() {
    char username[USERNAME_LEN];
    char password[PASSWORD_LEN];

    printf("\n--- Login ---\n");
    printf("Digite o nome de usuário: ");
    scanf("%s", username);
    printf("Digite a senha: ");
    scanf("%s", password);

    if (authenticate(username, password)) {
        printf("\nLogin bem-sucedido! Bem-vindo(a), %s!\n", username);
        // Após login bem-sucedido, mostrar menu de estoque
        stock_menu();
    } else {
        printf("\nNome de usuário ou senha incorretos.\n");
    }
}

// Funções de gerenciamento de estoque
void add_product() {
    if (product_count >= MAX_PRODUCTS) {
        printf("\nEstoque cheio! Não é possível adicionar mais produtos.\n");
        return;
    }

    char name[PRODUCT_NAME_LEN];
    int quantity;
    float price;

    printf("\n--- Adicionar Produto ---\n");
    printf("Nome do produto: ");
    scanf("%s", name);
    printf("Quantidade: ");
    scanf("%d", &quantity);
    printf("Preço: ");
    scanf("%f", &price);

    strncpy(products[product_count].name, name, PRODUCT_NAME_LEN);
    products[product_count].quantity = quantity;
    products[product_count].price = price;
    product_count++;

    printf("\nProduto adicionado com sucesso!\n");
}

void list_products() {
    printf("\n--- Lista de Produtos ---\n");
    if (product_count == 0) {
        printf("Nenhum produto no estoque.\n");
        return;
    }

    for (int i = 0; i < product_count; i++) {
        printf("Produto: %s | Quantidade: %d | Preço: %.2f\n",
               products[i].name, products[i].quantity, products[i].price);
    }
}

void remove_product() {
    char name[PRODUCT_NAME_LEN];

    printf("\n--- Remover Produto ---\n");
    printf("Nome do produto: ");
    scanf("%s", name);

    for (int i = 0; i < product_count; i++) {
        if (strcmp(products[i].name, name) == 0) {
            for (int j = i; j < product_count - 1; j++) {
                products[j] = products[j + 1];
            }
            product_count--;
            printf("\nProduto removido com sucesso!\n");
            return;
        }
    }

    printf("\nProduto não encontrado.\n");
}

void stock_menu() {
    int choice;
    while (1) {
        printf("\n--- Menu de Estoque ---\n");
        printf("1. Adicionar Produto\n");
        printf("2. Listar Produtos\n");
        printf("3. Remover Produto\n");
        printf("4. Voltar ao Menu Principal\n");
        printf("Escolha uma opção: ");
        scanf("%d", &choice);

        switch (choice) {
            case 1:
                add_product();
                break;
            case 2:
                list_products();
                break;
            case 3:
                remove_product();
                break;
            case 4:
                return;
            default:
                printf("\nOpção inválida! Tente novamente.\n");
        }
    }
}

// Tela inicial
void welcome_screen() {
    printf("\n");
    printf("****************************************\n");
    printf("*                                      *\n");
    printf("*          BEM-VINDO AO MERCADO         *\n");
    printf("*                                      *\n");
    printf("****************************************\n");
}

// Menu principal
int main() {
    int choice;

    welcome_screen();

    while (1) {
        printf("\n--- Menu Principal ---\n");
        printf("1. Registrar\n");
        printf("2. Login\n");
        printf("3. Sair\n");
        printf("Escolha uma opção: ");
        scanf("%d", &choice);

        switch (choice) {
            case 1:
                register_user();
                break;
            case 2:
                login_user();
                break;
            case 3:
                printf("\nSaindo...\n");
                exit(0);
            default:
                printf("\nOpção inválida! Tente novamente.\n");
        }
    }

    return 0;
}