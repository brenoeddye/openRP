CMD:v (playerid, params[]) {
    new	Float:x, Float:y, Float:z, Float:a, idx[100], veh;
    if(sscanf(params, "s[100]", idx)) return SendClientMessage(playerid, -1, "[X] Use: /v [Nome do Veículo]");
    if(veh > 0) {
        DestroyVehicle(veh);
    }
	GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);

    new vehicleName = GetVehicleModelIDFromName(idx);
    if(vehicleName < 400 || vehicleName > 611) return SendClientMessage(playerid, -1, "[X] Você deve digitar o nome ou o id do veículo de 400 até 611!");

    veh = CreateVehicle(vehicleName, x, y, z + 2.0, a, 3, 3, 10000, 0);

    LinkVehicleToInterior(veh, GetPlayerInterior(playerid));
    PutPlayerInVehicle(playerid, veh, 0);
	return true;
}

YCMD:kick(playerid, params[], help)
{
    if(GetAdminLevel(playerid) < 1)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    new targetid, reason[128];

    if(sscanf(params, "k<u>s[128]", targetid, reason))
        return SendClientMessage(playerid, COLOR_ERROR, "* /kick [playerid] [motivo]");

    else if(playerid == targetid)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode kickar você mesmo.");

    Kick(targetid);
    return 1;
}

YCMD:ch(playerid, params[]) {
    if(GetAdminLevel(playerid) < 1) return SendClientMessage(playerid, COLOR_ERROR, "Você não tem permissão para criar casas.");

    new price;

    if(sscanf(params, "k<u>", price)) return SendClientMessage(playerid, COLOR_ERROR, "Use: /ch [preço]");

    new Float:x, Float:y, Float:z, Query[250];
    GetPlayerPos(playerid, x, y, z);

    mysql_format(ConnectSQL, Query, sizeof(Query), "INSERT INTO houses (Type, OwnerID, Price, PosX, PosY, PosZ) VALUES (%d, %d, %d, %f, %f, %f)", 0, 0, price, x, y, z);
    mysql_query(ConnectSQL, Query);

    AddStaticPickup(1273, 23, x, y, z, 0);
    
    SendClientMessage(playerid, PRIMARY_COLOR, "Casa criada com sucesso!");

    return true;
}