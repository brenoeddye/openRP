#define HOST    "localhost"
#define USER    "root"
#define DB      "open-rp"
#define PASS    ""

new MySQL:ConnectSQL;

#include <YSI\YSI_coding\y_hooks>

hook OnGameModeInit() {
    ConnectSQL = mysql_connect(HOST, USER, PASS, DB);

    if(mysql_errno(ConnectSQL) != 0) {
        print("[MySQL] Falha ao tentar estabelecer conexão com o banco de dados.");
    } else {
        print("[MySQL] Sucesso ao conectar com o banco de dados.");
    }
    return true;
}

hook OnGameModeExit() {
    mysql_close(ConnectSQL);
    return true;
}