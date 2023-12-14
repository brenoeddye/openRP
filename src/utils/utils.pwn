stock GetPlayerNameEx(playerid) {
    static pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    return pname;
}