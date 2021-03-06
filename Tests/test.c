/*
** EPITECH PROJECT, 2019
** test.c
** File description:
** a
*/

#include <stdio.h> 
#include <sys/socket.h> 
#include <arpa/inet.h> 
#include <unistd.h> 
#include <string.h> 
#include "Common/protocol.h"

int send_ping(int s) {
    struct {
        request_header_t hdr;
        client_ping_t payload;
    } request = {
        {
            .id = CLIENT_PING,
            .request_len = CLIENT_PING_SIZE
        },
        {
            .stamp = time(NULL)
        }
    };

    write(s, &request, sizeof(request));

    request_header_t hdr = {0};

    read(s, &hdr, sizeof(hdr));

    if (hdr.id != SERVER_PING_RESPONSE) {
        printf("Error !!\n");
        return 1;
    }

    server_ping_response_t server = {0};

    read(s, &server, sizeof(server));

    printf("Server stamp is: %ld\n", server.stamp);
    return 0;
}

int send_hello(int s, char *name, char *password) {
    struct {
        request_header_t hdr;
        client_hello_t payload;
    } request = {
        {
            .id = CLIENT_HELLO,
            .request_len = CLIENT_HELLO_SIZE
        },
        {
            .username = {0},
            .password = {0}
        }
    };

    memcpy(&request.payload.username, name, strlen(name));
    memcpy(&request.payload.password, password, strlen(password));

    write(s, &request, sizeof(request));

    request_header_t hdr = {0};

    read(s, &hdr, sizeof(hdr));

    if (hdr.id != SERVER_HELLO_RESPONSE) {
        printf("Error header = %c\n", hdr.id);
        return 1;
    }

    server_hello_response_t server = {0};

    read(s, &server, sizeof(server));

    printf("Connexion to server: %s\n", server.result == OK ? "Succeed" : "Failed");
    return 0;
}

int send_register(int s)
{
    struct {
        request_header_t hdr;
        client_register_t payload;
    } request = {
        {
            .id = CLIENT_REGISTER,
            .request_len = CLIENT_REGISTER_SIZE
        },
        {
            .username = {0},
            .password = {0}
        }
    };

    memcpy(&request.payload.username, "AttJkJb", 7);
    memcpy(&request.payload.password, "123", 3);

    write(s, &request, sizeof(request));

    request_header_t hdr = {0};

    read(s, &hdr, sizeof(hdr));

    if (hdr.id != SERVER_REGISTER_RESPONSE) {
        printf("Error hdr = %c\n", hdr.id);
        return 1;
    }

    server_register_response_t server = {0};

    read(s, &server, sizeof(server));

    printf("Registering: %s\n", server.result == OK ? "Succeed" : "Failed");
    return 0;
}

int send_call(int s)
{
    struct {
        request_header_t hdr;
        client_call_t payload;
    } request = {
        {
            .id = CLIENT_CALL,
            .request_len = CLIENT_CALL_SIZE
        },
        {
            .usernames = { {0} },
            .number = 1
        }
    };

    memcpy(&request.payload.usernames[0], "Thomas", 6);

    write(s, &request, sizeof(request));

    request_header_t hdr = {0};

    read(s, &hdr, sizeof(hdr));

    if (hdr.id != SERVER_CALL_RESPONSE) {
        printf("Error hdr = %c\n", hdr.id);
        return 1;
    }

    server_call_response_t server = {0};

    read(s, &server, sizeof(server));

    printf("Call: %s\n", server.result == OK ? "Succeed" : "Failed");
    return 0;
}

int send_accept_call(int s, char *username, short port, char *ip)
{
    struct {
        request_header_t hdr;
        client_accept_call_t payload;
    } request = {
       {
           .id = CLIENT_ACCEPT_CALL,
           .request_len = CLIENT_ACCEPT_CALL_SIZE
       },
       {
            .username = {{0}},
            .port = port,
            .ip = {{0}}
       }
    };

    memcpy(&request.payload.username, username, USERNAME_LEN);
    memcpy(&request.payload.ip, ip, 16);
    write(s, &request, sizeof(request));
    
    request_header_t hdr = {0};

    read(s, &hdr, sizeof(hdr));

    if (hdr.id != SERVER_ACCEPT_CALL_RESPONSE) {
        printf("Error hdr = %d\n", hdr.id);
    }
    printf("Receive header in %d\n", hdr.id);

    server_accept_call_response_t srv = {0};

    read(s, &srv, sizeof(srv));

    printf("Call %s\n", srv.result == OK ? "Succeed" : "Failed");
    return (0);
}

int setup_socket(short port) {
    int s = socket(AF_INET, SOCK_STREAM, 0);

    if (s == -1) {
        perror("socket");
        return -1;
    }

    struct sockaddr_in infos;

    infos.sin_family = AF_INET;
    inet_aton("10.109.252.166", &infos.sin_addr);
    infos.sin_port = htons(port);

    if (connect(s, (const struct sockaddr *) &infos, sizeof(infos)) < 0) {
        perror("connect");
        return -1;
    }

    return s;
}

int main(int argc, char *argv[])
{
    char *name;
    char *password;

    if (argc < 3) {
        name = "Antoine";
        password = "OuiOuiOui";
    } else {
        name = argv[1];
        password = argv[2];
    }

    int s = setup_socket(8080);

//    printf("Sending Ping!\n");
//    if (send_ping(s))
//        return 1;
    
    //printf("Sending Hello!\n");
    //if (send_hello(s, name, password))
    //    return 1;

    printf("Sending Register!\n");
    send_register(s);

    printf("Sending Accept Call!\n");
    if (send_accept_call(s, "Thomas", 8080, "10.109.252.138"))
        return 1;
}
