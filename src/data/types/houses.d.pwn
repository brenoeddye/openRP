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

    Float:PosX,
    Float:PosY,
    Float:PosZ,
}

new House[MAX_HOUSES][houseData];