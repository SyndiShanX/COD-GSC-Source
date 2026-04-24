/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_customgame.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#namespace zm_custom;

function autoexec function_d776b402() {}

function private function_ecc5a0b9(local_client_num, player, damage) {
  if(int(damage) == 5) {
    return true;
  }

  return false;
}

function function_901b751c(str_setting) {
  if(str_setting === "") {
    return undefined;
  }

  setting = getgametypesetting(str_setting);
  assert(isDefined(setting), "<dev string:x38>" + str_setting + "<dev string:x51>");
  return setting;
}