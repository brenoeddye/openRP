stock GetPlayerNameEx(playerid)
{
    static pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
    return pname;
}