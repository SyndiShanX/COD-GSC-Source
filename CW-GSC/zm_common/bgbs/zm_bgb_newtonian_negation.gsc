/********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_newtonian_negation.gsc
********************************************************/

#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;
#namespace zm_bgb_newtonian_negation;

function private autoexec __init__system__() {
  system::register(#"zm_bgb_newtonian_negation", &preinit, undefined, undefined, #"bgb");
}

function private preinit() {
  if(!is_true(level.bgb_in_use) && !is_true(level.var_5470be1c)) {
    return;
  }

  clientfield::register("world", "newtonian_negation", 1, 1, "int");
  bgb::register(#"zm_bgb_newtonian_negation", "time", 1500, &enable, &disable, &validation);
}

function validation() {
  if(is_true(level.var_6bbb45f9)) {
    return false;
  }

  return true;
}

function enable() {
  function_8622e664(1);
  self thread function_4712db36();
}

function function_4712db36() {
  self endon(#"hash_429f79a1bdb91087");
  self waittill(#"disconnect");
  thread disable();
}

function disable() {
  if(isDefined(self)) {
    self notify(#"hash_429f79a1bdb91087");
  }

  foreach(player in level.players) {
    if(player !== self && player bgb::is_enabled(#"zm_bgb_newtonian_negation")) {
      return;
    }
  }

  function_8622e664(0);
}

function function_8622e664(var_b4666218) {
  level clientfield::set("newtonian_negation", var_b4666218);
}