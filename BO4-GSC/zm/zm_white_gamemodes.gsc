/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_white_gamemodes.gsc
***********************************************/

#include scripts\core_common\util_shared;
#include scripts\zm\zm_white_zstandard;

#namespace zm_white_gamemodes;

event_handler[level_finalizeinit] main(eventstruct) {
  if(!isDefined(level.flag) || !(isDefined(level.flag[#"load_main_complete"]) && level.flag[#"load_main_complete"])) {
    level waittill(#"load_main_complete");
  }

  gametype = hash(util::get_game_type());

  switch (gametype) {
    case #"zstandard":
      zm_white_zstandard::main();
      break;
  }
}