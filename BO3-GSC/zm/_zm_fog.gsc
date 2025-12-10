/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_fog.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_utility;
#namespace zm_fog;

function autoexec __init__sytem__() {
  system::register("zm_fog", &__init__, &__main__, undefined);
}

function __init__() {
  clientfield::register("world", "globalfog_bank", 15000, 2, "int");
  clientfield::register("world", "litfog_scriptid_to_edit", 15000, 4, "int");
  clientfield::register("world", "litfog_bank", 15000, 2, "int");
}

function __main__() {
  setdvar("fogtest_litfog_scriptid", 0);
  level.var_f87fe25d = [];
  level.var_9814fc19 = 0;
  level thread function_fb5e0a7e();
}

function function_b8a83a11(var_1cafad33) {
  assert(isDefined(level.var_f87fe25d[var_1cafad33]), ("" + var_1cafad33) + "");
  var_f832704f = level.var_f87fe25d[var_1cafad33];
  if(isDefined(var_f832704f.var_400d18c9)) {
    function_facb5f71(var_f832704f.var_400d18c9);
  }
  if(isDefined(var_f832704f.var_67098efc)) {
    for(i = 0; i < var_f832704f.var_67098efc.size; i++) {
      if(isDefined(var_f832704f.var_67098efc[i])) {
        function_bd594680(i, var_f832704f.var_67098efc[i]);
      }
    }
  }
}

function function_848b74be(var_1cafad33, var_400d18c9) {
  if(!isDefined(level.var_f87fe25d[var_1cafad33])) {
    level.var_f87fe25d[var_1cafad33] = spawnStruct();
  }
  level.var_f87fe25d[var_1cafad33].var_400d18c9 = var_400d18c9;
}

function function_e920efc6(var_1cafad33, var_965632d6, var_ab3af963) {
  if(!isDefined(level.var_f87fe25d[var_1cafad33])) {
    level.var_f87fe25d[var_1cafad33] = spawnStruct();
  }
  if(!isDefined(level.var_f87fe25d[var_1cafad33].var_67098efc)) {
    level.var_f87fe25d[var_1cafad33].var_67098efc = [];
  }
  level.var_f87fe25d[var_1cafad33].var_67098efc[var_965632d6] = var_ab3af963;
}

function function_facb5f71(var_400d18c9) {
  clientfield::set("globalfog_bank", var_400d18c9);
}

function function_bd594680(var_965632d6, n_bank) {
  clientfield::set("litfog_scriptid_to_edit", var_965632d6);
  util::wait_network_frame();
  clientfield::set("litfog_bank", n_bank);
}

function setup_devgui_func(str_devgui_path, str_dvar, n_value, func, n_base_value = -1) {
  setdvar(str_dvar, n_base_value);
  adddebugcommand(((((("devgui_cmd \"" + str_devgui_path) + "\" \"") + str_dvar) + " ") + n_value) + "\"\n");
  while(true) {
    n_dvar = getdvarint(str_dvar);
    if(n_dvar > n_base_value) {
      [
        [func]
      ](n_dvar);
      setdvar(str_dvar, n_base_value);
    }
    util::wait_network_frame();
  }
}

function function_fb5e0a7e() {
  for(i = 0; i < 4; i++) {
    level thread setup_devgui_func("" + i, "", i, &function_3dec91b9);
  }
  for(i = 0; i < 16; i++) {
    level thread setup_devgui_func("" + i, "", i, &function_49720b6e);
  }
  for(i = 1; i <= 4; i++) {
    level thread setup_devgui_func("" + i, "", i, &function_124286f7);
  }
}

function function_3dec91b9(n_val) {
  iprintlnbold("" + n_val);
  function_facb5f71(n_val);
}

function function_49720b6e(n_val) {
  level.var_9814fc19 = n_val;
  iprintlnbold("" + n_val);
}

function function_124286f7(n_val) {
  iprintlnbold((("" + level.var_9814fc19) + "") + n_val);
  function_bd594680(level.var_9814fc19, n_val - 1);
}