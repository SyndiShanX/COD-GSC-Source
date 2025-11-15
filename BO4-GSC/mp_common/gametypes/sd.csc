/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\sd.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\mp_common\gametypes\ct_tutorial_skirmish;

#namespace sd;

event_handler[gametype_init] main(eventstruct) {
  if(getgametypesetting(#"silentplant") != 0) {
    setsoundcontext("bomb_plant", "silent");
  }

  clientfield::register("worlduimodel", "hudItems.war.attackingTeam", 1, 2, "int", undefined, 0, 1);

  if(util::function_8570168d()) {
    ct_tutorial_skirmish::init();
  }
}