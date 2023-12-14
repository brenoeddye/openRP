#include <open.mp>

//------------------------------------------------------------------------------
// Defines
#if defined MAX_PLAYERS
	#undef MAX_PLAYERS
#endif
#define MAX_PLAYERS	        501
#define MAX_PLAYER_NAME     24
#define MAX_BUSINESS        1
#define MAX_HOUSES          1
//------------------------------------------------------------------------------
// Libraries
#include <a_mysql>
#include <YSI\YSI_coding\y_hooks>
#include <YSI\YSI_coding\y_timers>
#include <YSI\YSI_Visual\y_commands>
#include <sscanf2>
#include <sscanffix>

hook OnGameModeInit() {
    // resets
    UsePlayerPedAnims();
	DisableInteriorEnterExits();
	SetNameTagDrawDistance(40.0);
	EnableStuntBonusForAll(false);

    // gamemode
	SetGameModeText("Roleplay");
    SetWorldTime(0);
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	return true;
}

//------------------------------------------------------------------------------
// Modules
// Database
#include "../../src/data/database/auth.pwn"

// Admin
#include "../../src/admin/commands.pwn"

// Types
#include "../../src/data/types/dialogs.d.pwn"

// Utils
#include "../../src/utils/skins.pwn"
#include "../../src/utils/utils.pwn"

main() {
	print("\n-----------------------------------");
	print("	  Breno Pereira	(Eddye)             ");
	print("		and GitHub Colabs               ");
	print("				                        ");
	print("        Open-RP 0.1                  ");
	print("		An Open Source Gamemode         ");
	print("------------------------------------\n");
}