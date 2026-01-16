/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_maldives.gsc
***********************************************/

#include scripts\core_common\compass;
#include scripts\core_common\doors_shared;
#include scripts\mp_common\load;

#namespace mp_maldives;

event_handler[level_init] main(eventstruct) {
  load::main();
  compass::setupminimap("");
  level.var_cddcf1e3 = &function_261b0d99;
  level.var_abaf1ec9 = &function_eda70d10;
  level.var_6e8625fe = 1;
}

function_261b0d99() {
  self.pers[#"mpcommander"] = #"blops_commander_maldives";
}

function_eda70d10() {
  self.pers[#"mpcommander"] = #"cdp_commander_maldives";
}