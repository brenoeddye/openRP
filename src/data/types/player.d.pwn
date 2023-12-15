enum playerData {
    ID,
    Password[24],
    Admin,
    Money,
    Level,
    Exp,
    Skin,

    Float:PosX,
    Float:PosY,
    Float:PosZ,
    Float:PosA,

    JobID,
    JobXP,
    JobLVL,

    bool:isLogged
}

new Player[MAX_PLAYERS][playerData];