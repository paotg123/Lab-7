%{
#include <stdio.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);
%}

%token HELLO GOODBYE TIME NAME WEATHER HOWAREYOU

%%

chatbot : greeting
        | farewell
        | query
        | name_query
        | weather_query
        | howareyou_query
        ;

greeting : HELLO { printf("Chatbot: ¡Hola! ¿Cómo puedo ayudarte hoy?\n"); }
         ;

farewell : GOODBYE { printf("Chatbot: ¡Adiós! ¡Que tengas un gran día!\n"); }
         ;

query : TIME { 
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Chatbot: La hora actual es %02d:%02d.\n", local->tm_hour, local->tm_min);
         }
       ;

name_query : NAME { printf("Chatbot: Mi nombre es Chatbot.\n"); }
           ;

weather_query : WEATHER { printf("Chatbot: No puedo verificar el clima actualmente.\n"); }
              ;

howareyou_query : HOWAREYOU { printf("Chatbot: ¡Estoy bien, gracias por preguntar!\n"); }
                ;

%%

int main() {
    printf("Chatbot: ¡Hola! Puedes saludarme, preguntar la hora, mi nombre, el clima, o despedirte.\n");
    while (yyparse() == 0) {
        // Bucle hasta el final de la entrada
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: No entendí eso.\n");
}
