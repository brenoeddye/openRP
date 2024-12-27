forward loadDynamicHouses();

stock createHouse(playerid, type, ownerid, interiorid, price, posx, posy, posz) {
    new Query[250], houseid, houseText[64];
    
    mysql_format(ConnectSQL, Query, sizeof(Query), "INSERT INTO `houses` (`Type`, `OwnerID`, `InteriorID`, `Price`, `PosX`, `PosY`, `PosZ`) VALUES (%d, %d, %d, %d, %f, %f, %f)", type, ownerid, interiorid, price, posx, posy, posz);
    mysql_query(ConnectSQL, Query);

    houseid = cache_insert_id();

    if (houseid < MAX_HOUSES) {
        //Add 3D Text
        format(houseText, sizeof(houseText), "Casa {#aefa97}%d\n{#5fda3a}$%d{#008080}\n", houseid, price);
        CreateDynamic3DTextLabel(houseText, 0x008080FF, posx, posy, posz, 40.0);

        SendClientMessage(playerid, PRIMARY_COLOR, "Casa criada com sucesso!");

        printf("[Server] New house created! id: %d, price: %d", houseid, price);

        House[houseid][MapIcon] = CreateDynamicMapIcon(posx, posy, posz, 32, 0x0000FFFF, -1, -1, -1, 300.0);
	    House[houseid][Enter_HousePickup] = CreateDynamicPickup(1273, 1, posx, posy, posz, houseid);
    } else {
        printf("Erro: houseid excede o limite máximo (%d).", MAX_HOUSES);
    }

    return true;
}

stock deleteHouse(houseid) {
    return true;
}

public loadDynamicHouses() {
    new rows = cache_num_rows();

    if (rows > 0) {
        for (new i = 0; i < rows; i++) {
            new houseid, houseText[64];

            cache_get_value_int(0,      "ID",           houseid);
            cache_get_value_int(0,      "Type",         House[houseid][Type]);
            cache_get_value_int(0,      "OwnerID",      House[houseid][OwnerID]);
            cache_get_value_int(0,      "Price",        House[houseid][Price]);
            cache_get_value_int(0,      "InteriorID",   House[houseid][InteriorID]);
            cache_get_value_float(0,    "PosX",         House[houseid][Enter_PosX]);
            cache_get_value_float(0,    "PosY",         House[houseid][Enter_PosX]);
            cache_get_value_float(0,    "PosZ",         House[houseid][Enter_PosX]);

            if (houseid < MAX_HOUSES) {
                House[houseid][MapIcon] = CreateDynamicMapIcon(House[houseid][Enter_PosX], House[houseid][Enter_PosY], House[houseid][Enter_PosZ], 32, 0x0000FFFF, -1, -1, -1, 300.0);
                House[houseid][Enter_HousePickup] = CreateDynamicPickup(1273, 1, House[houseid][Enter_PosX], House[houseid][Enter_PosY], House[houseid][Enter_PosZ], houseid);

                format(houseText, sizeof(houseText), "Casa {#aefa97}%d\n{#5fda3a}$%d{#008080}\n", houseid, House[houseid][Price]);
                Create3DTextLabel(houseText, 0x008080FF, House[houseid][Enter_PosX], House[houseid][Enter_PosY], House[houseid][Enter_PosZ], 40.0, 0);
            } else {
                printf("Erro: houseid excede o limite máximo (%d).", MAX_HOUSES);
            }
        }
        printf("[Server] Number of houses loaded: %d", rows);
    } else {
        printf("Nenhuma casa encontrada no banco de dados.");
    }

    return true;
}

hook OnGameModeInit() {
    new Query[64];
    mysql_format(ConnectSQL, Query, sizeof(Query), "SELECT * FROM `houses`");
	mysql_tquery(ConnectSQL, Query, "loadDynamicHouses");

    return true;
}