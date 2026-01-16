/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_gamemodes.gsc
***********************************************/

#include scripts\core_common\util_shared;
#include scripts\zm\zm_orange_zstandard;

#namespace zm_orange_gamemodes;

event_handler[level_finalizeinit] main(eventstruct) {
  if(!isDefined(level.flag) || !(isDefined(level.flag[#"load_main_complete"]) && level.flag[#"load_main_complete"])) {
    level waittill(#"load_main_complete");
  }

  gametype = hash(util::get_game_type());

  switch (gametype) {
    case #"zstandard":
      zm_orange_zstandard::main();
      break;
  }
}