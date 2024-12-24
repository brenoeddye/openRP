forward createHouse(playerid, type, ownerid, interiorid, price, posx, posy, posz);
forward deleteHouse(houseid);
forward loadHouses();

public createHouse(playerid, type, ownerid, interiorid, price, posx, posy, posz) {
    new Query[250], houseid, houseText[64];
    
    mysql_format(ConnectSQL, Query, sizeof(Query), "INSERT INTO `houses` (`Type`, `OwnerID`, `InteriorID`, `Price`, `PosX`, `PosY`, `PosZ`) VALUES (%d, %d, %d, %d, %f, %f, %f)", type, ownerid, interiorid, price, posx, posy, posz);
    mysql_query(ConnectSQL, Query);

    houseid = cache_insert_id();

    if (houseid < MAX_HOUSES) {
        House[houseid][MapIcon] = CreateDynamicMapIcon(posx, posy, posz, 32, 0x0000FFFF, -1, -1, -1, 300.0);
	    House[houseid][Enter_HousePickup] = CreateDynamicPickup(1273, 1, posx, posy, posz, houseid);

        //Add 3D Text
        format(houseText, sizeof(houseText), "Casa {#aefa97}%d\n{#5fda3a}$%d{#008080}\n", houseid, price);
        CreatePlayer3DTextLabel(playerid, houseText, 0x008080FF, posx, posy, posz, 40.0);

        SendClientMessage(playerid, PRIMARY_COLOR, "Casa criada com sucesso!");

        printf("[Server] New house created! id: %d, price: %d", houseid, price);
    } else {
        printf("Erro: houseid excede o limite máximo (%d).", MAX_HOUSES);
    }

    return true;
}

public deleteHouse(houseid) {
    return true;
}

public loadHouses() {
    return true;
}
