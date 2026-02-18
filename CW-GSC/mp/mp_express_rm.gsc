/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_express_rm.gsc
***********************************************/

#using scripts\core_common\compass;
#using scripts\core_common\load_shared;
#using scripts\mp\mp_express_rm_train;
#namespace mp_express_rm;

function event_handler[level_init] main(eventstruct) {
  if(is_true(getgametypesetting(#"allowmapscripting"))) {
    namespace_af0fb818::function_39da2f0();
  }

  level.levelkothdisable = [];
  level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (1248, 1658, -30), 0, 50, 150);
  level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (1296, 1708, -30), 0, 50, 150);
  load::main();
  compass::setupminimap("");

  if(is_true(getgametypesetting(#"allowmapscripting"))) {
    namespace_af0fb818::main();
  }
}