forward createHouse(playerid, type, ownerid, interiorid, price, posx, posy, posz);
forward deleteHouse(houseid);
forward loadHouses();

public createHouse(playerid, type, ownerid, interiorid, price, posx, posy, posz) {
    new Query[250], PlayerText3D:houseText3D, houseid, houseText[64];
    
    mysql_format(ConnectSQL, Query, sizeof(Query), "INSERT INTO `houses` (`Type`, `OwnerID`, `InteriorID`, `Price`, `PosX`, `PosY`, `PosZ`) VALUES (%d, %d, %d, %d, %f, %f, %f)", type, ownerid, interiorid, price, posx, posy, posz);
    mysql_query(ConnectSQL, Query);

    cache_insert_id(ConnectSQL, houseid);

    //Add pickup
    AddStaticPickup(1273, 23, posx, posy, posz, 0);

    //Add radar local
    SetPlayerMapIcon(playerid, 1, posx, posy, posz, 31, 0, MAPICON_LOCAL);

    //Add 3D Text
    format(houseText, sizeof(houseText), "Casa {#aefa97}%d\n{#5fda3a}$%d{#008080}\n", houseid, price);
    houseText3D = CreatePlayer3DTextLabel(playerid, houseText, 0x008080FF, posx, posy, posz, 40.0);
    return true;
}

public deleteHouse(houseid) {
    return true;
}

public loadHouses() {
    return true;
}
