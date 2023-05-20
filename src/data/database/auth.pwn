//------------------------------------------------------------------------------
// SQL Config
#define HOST    "localhost"
#define USER    "root"
#define DB      "legacy-nfs"
#define PASS    ""

new MySQL:ConnectSQL;

#include <YSI\YSI_coding\y_hooks>
#include "../../src/data/types/dialogs.d.pwn"
#include "../../src/data/types/player.d.pwn"

// Forwards
forward checkAccount(playerid);
forward loadAccount(playerid);
forward registerAccount(playerid);
forward saveAccount(playerid);

public checkAccount(playerid) {
    if(cache_num_rows() > 0) {
        cache_get_value_name(0, "Password", Player[playerid][Password], 24);
        ShowPlayerDialog(playerid, D_LOGIN, DIALOG_STYLE_PASSWORD, "Login", "Digite sua senha para entrar em nosso servidor.", "Confirmar", "Sair");
    } else
        ShowPlayerDialog(playerid, D_REGISTER, DIALOG_STYLE_INPUT, "Registro", "Digite uma senha para se registrar em nosso servidor", "Registrar", "Sair");
}

public registerAccount(playerid) {
    new Query[90];
    Player[playerid][ID] = cache_insert_id();
    printf("[MYSQL] Jogador %s registrado como ID %d", GetPlayerNameEx(playerid), Player[playerid][ID]);

    mysql_format(ConnectSQL, Query, sizeof(Query), "SELECT * FROM users WHERE ID='%i'", Player[playerid][ID]);
    mysql_query(ConnectSQL,Query);

    loadAccount(playerid);
    return true;
} 

public loadAccount(playerid) {
    Player[playerid][isLogged] = true;

    cache_get_value_int(0,      "ID",       Player[playerid][ID]);
    cache_get_value_int(0,      "Money",    Player[playerid][Money]);
    cache_get_value_int(0,      "Admin",    Player[playerid][Level]);
    cache_get_value_int(0,      "Level",    Player[playerid][Level]);
	cache_get_value_int(0,      "Exp",      Player[playerid][Exp]); 
    cache_get_value_int(0,      "Skin",     Player[playerid][Skin]);
    cache_get_value_float(0,    "PosX",     Player[playerid][PosX]);
    cache_get_value_float(0,    "PosY",     Player[playerid][PosY]);
    cache_get_value_float(0,    "PosZ",     Player[playerid][PosZ]);
    cache_get_value_float(0,    "PosA",     Player[playerid][PosA]);

    SetPlayerScore(playerid,                Player[playerid][Level]);
    GivePlayerMoney(playerid,               Player[playerid][Money]);

    SetSpawnInfo(playerid, 0, Player[playerid][Skin], Player[playerid][PosX], Player[playerid][PosY], Player[playerid][PosZ], Player[playerid][PosA], 0, 0, 0, 0 ,0, 0);
    SpawnPlayer(playerid);

    SetPlayerSkin(playerid, Player[playerid][Skin]);

    return true;
} 

public saveAccount(playerid) {
    if(Player[playerid][isLogged] == false)
        return false;

    new Query[250];
    Player[playerid][Money] = GetPlayerMoney(playerid); 
    Player[playerid][Level] = GetPlayerScore(playerid);
    Player[playerid][Skin] = GetPlayerSkin(playerid);
    GetPlayerPos(playerid, Player[playerid][PosX], Player[playerid][PosY], Player[playerid][PosZ]);
    GetPlayerFacingAngle(playerid, Player[playerid][PosA]);

    mysql_format(ConnectSQL, Query, sizeof(Query), "UPDATE `users` SET \
    `Money`='%i', \
    `Admin`='%i', \
    `Level`='%i', \
    `Exp`='%i', \
    `Skin`='%i', \
    `PosX`='%f', \
    `PosY`='%f', \
    `PosZ`='%f', \
    `PosA`='%f' WHERE `ID`='%i'", 	Player[playerid][Money],
                                    Player[playerid][Admin],
									Player[playerid][Level],
									Player[playerid][Exp],
									Player[playerid][Skin],
									Player[playerid][PosX],
									Player[playerid][PosY],
									Player[playerid][PosZ],
									Player[playerid][PosA],
									Player[playerid][ID]);
    mysql_query(ConnectSQL, Query);

    printf("[MYSQL] Dados do Jogador %s ID %d salvo com sucesso", GetPlayerNameEx(playerid), Player[playerid][ID]); // Apenas um debug

    return true;
}

stock clearAccount(playerid) {
    Player[playerid][ID]            = 0;
    Player[playerid][Password]      = 0;
    Player[playerid][Admin]         = 0;
    Player[playerid][Money]         = 0;
    Player[playerid][Level]         = 0;
    Player[playerid][Exp]           = 0;
    Player[playerid][Skin]          = 0;

    Player[playerid][PosX]          = 0;
    Player[playerid][PosA]          = 0;
    Player[playerid][PosY]          = 0;
    Player[playerid][PosA]          = 0;

    Player[playerid][isLogged]      = false;
}

hook OnGameModeInit() {
    // sql
    ConnectSQL = mysql_connect(HOST, USER, PASS, DB);
	if(mysql_errno(ConnectSQL) != 0) {
        print("[MySQL] Falha ao tentar estabelecer conexão com o banco de dados.");
    } else {
        print("[MySQL] Sucesso ao conectar com o banco de dados.");
    }

    return true;
}

hook OnPlayerConnect(playerid) {
	new Query[90];
	TogglePlayerSpectating(playerid, 1); // Disable "spawn" menu when start server;

	mysql_format(ConnectSQL, Query, sizeof(Query), "SELECT `Password`, `ID` FROM `Users` WHERE `Name`='%e'", GetPlayerNameEx(playerid));
    mysql_tquery(ConnectSQL, Query, "checkAccount", "i", playerid);
	return true;
}

hook OnPlayerDisconnect(playerid, reason) {
	if(Player[playerid][isLogged] == true && reason >= 0) 
    {
        saveAccount(playerid);
        clearAccount(playerid);
    }
	return true;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    new Query[125];

    switch(dialogid) {
        case D_REGISTER: {
            if(!response)
                return Kick(playerid);

            if(strlen(inputtext) < 4 || strlen(inputtext) > 24) {
                SendClientMessage(playerid, 0xFF0000AA, "[SERVER] Escolha uma senha entre 4 a 24 caracteres.");
                TogglePlayerSpectating(playerid, 1);

                ShowPlayerDialog(playerid, D_REGISTER, DIALOG_STYLE_INPUT, "Registro", "Digite uma senha para se registrar em nosso servidor", "Registrar", "Sair"); // Mostra o dialog para ele tentar de novo.

            } else {
                TogglePlayerSpectating(playerid, 0);
                mysql_format(ConnectSQL, Query, sizeof(Query), "INSERT INTO `users`(`Name`,`Password`) VALUES ('%e', '%e')", GetPlayerNameEx(playerid), inputtext);
                mysql_tquery(ConnectSQL, Query, "registerAccount", "i", playerid);
            }
        }
        case D_LOGIN: {
            if(!response)
                return Kick(playerid);

            if(!strcmp(Player[playerid][Password], inputtext, true, 24)) {
                TogglePlayerSpectating(playerid, 0);
                mysql_format(ConnectSQL, Query, sizeof(Query), "SELECT * FROM users WHERE Name='%e'", GetPlayerNameEx(playerid));
                mysql_tquery(ConnectSQL, Query, "loadAccount", "i", playerid);

                SendClientMessage(playerid, 0x80FF00AA, "[Server] Logado com sucesso.");
            } else {
                TogglePlayerSpectating(playerid, 1);
                SendClientMessage(playerid, 0xFF0000AA, "[SERVER] Senha errada, tente novamente.");
                ShowPlayerDialog(playerid, D_LOGIN, DIALOG_STYLE_PASSWORD, "Login", "Digite sua senha para entrar em nosso servidor.", "Confirmar", "Sair");
            }
        }
    }
    return true;
}