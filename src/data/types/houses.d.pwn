/* House Data

    ID          -> HouseID
    type        -> 0 = house / 1 = apartment
    interiorID  -> samp interior id. 0 = none interior

 */

enum houseData {
    ID,
    type,
    interiorID,
}

new House[MAX_HOUSES][houseData]