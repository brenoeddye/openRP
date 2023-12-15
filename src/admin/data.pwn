forward SetAdminLevel(playerid, level);
forward GetAdminLevel(playerid);

public SetAdminLevel(playerid, level) {
    return Player[playerid][Admin] = level;
}

public GetAdminLevel(playerid) {
    return Player[playerid][Admin];
}