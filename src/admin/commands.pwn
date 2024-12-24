YCMD:v (playerid, params[]) {
    new	Float:x, Float:y, Float:z, Float:a, idx[100], veh;
    if(sscanf(params, "s[100]", idx)) return SendClientMessage(playerid, -1, "[X] Use: /v [Nome do Veículo]");
    if(veh > 0) {
        DestroyVehicle(veh);
    }
	GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);

    new vehicleName = GetVehicleModelIDFromName(idx);
    if(vehicleName < 400 || vehicleName > 611) return SendClientMessage(playerid, -1, "[X] Você deve digitar o nome ou o id do veículo de 400 até 611!");

    veh = CreateVehicle(vehicleName, x, y, z + 2.0, a, 3, 3, 10000, false);

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
    if(GetAdminLevel(playerid) < 1) 
        return SendClientMessage(playerid, COLOR_ERROR, "Você não tem permissão para criar casas.");

    new price;

    if(sscanf(params, "i", price)) 
        return SendClientMessage(playerid, COLOR_ERROR, "Use: /ch [preço]");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    createHouse(playerid, 0, 0, 3, price, x, y, z);
    return true;
}