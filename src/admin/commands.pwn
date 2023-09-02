#include "../../src/utils/skins.pwn"
#include "../../src/utils/vehicles.pwn"

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

CMD:kick(playerid, params[]) {
    new targetid;
    if (sscanf(params, "u", targetid)) {
        if (IsPlayerConnected(targetid)) {
            if (IsAdmin(playerid))
                Kick(targetid);
            else
                SendClientMessage(playerid, COLOR_RED, "Você não tem permissão para expulsar jogadores.");
        }   else
                SendClientMessage(playerid, COLOR_RED, "O jogador alvo não está online.");
            else
                SendClientMessage(playerid, COLOR_RED, "Uso correto: /kick [ID do jogador]");
    return true;
}