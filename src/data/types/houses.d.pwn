/* House Data

    ID          -> HouseID
    type        -> 0 = house / 1 = apartment
    ownerId     -> userId
    interiorID  -> samp interior id. 0 = none interior

 */

enum houseData {
    ID,
    Type,
    OwnerID,
    Price,
    InteriorID,

    Float:Enter_PosX,
    Float:Enter_PosY,
    Float:Enter_PosZ,

    Float:Exit_PosX,
    Float:Exit_PosY,
    Float:Exit_PosZ,

    MapIcon,

    Enter_HousePickup,
    Exit_HousePickup
}

new House[MAX_HOUSES][houseData];