/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\zm\remotemissile.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\remotemissile_shared;
#using scripts\killstreaks\zm\killstreakrules;
#using scripts\killstreaks\zm\killstreaks;
#namespace remotemissile;

function private autoexec __init__system__() {
  system::register(#"remotemissile", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  clientfield::register("world", "" + # "hash_59ec82b1a72deb72", 1, 1, "int");
  clientfield::register("toplayer", "" + # "remotemissile_fov", 6000, 1, "int");
  clientfield::register("toplayer", "" + # "hash_4241f7b51f8c144", 8000, 1, "int");
  init_shared("killstreak_remote_missile" + "_zm", &function_ea3ce28b);

  if(isDefined(level.killstreakrules[#"hero_weapons"])) {
    killstreakrules::addkillstreaktorule("remote_missile", "hero_weapons", 0, 0);
  }

  killstreaks::function_7b6102ed("remote_missile");
  killstreaks::function_7b6102ed("inventory_remote_missile");
}

function function_ea3ce28b(killstreaktype) {
  if(!self killstreakrules::function_71e94a3b()) {
    self.var_baf4657c = 1;
    self killstreakrules::function_65739e7b("remote_missile");
    return 0;
  }

  self callback::function_d8abfc3d(#"hash_247d67dbf83dbc1a", &function_903cf6aa);
  self callback::function_d8abfc3d(#"hash_72a7670db71677f", &function_3e6a41b7);
  return tryusepredatormissile(killstreaktype);
}

function function_903cf6aa() {
  self thread killstreakrules::function_24241971();
  level function_f7599440(1);
  self clientfield::set_to_player("" + # "hash_4241f7b51f8c144", 1);
  self val::set(#"remote_missile", "ignoreme", 1);
  self val::set(#"remote_missile", "takedamage", 0);
}

function function_3e6a41b7() {
  level function_f7599440(0);
  self clientfield::set_to_player("" + # "hash_4241f7b51f8c144", 0);
  wait 2;

  if(isPlayer(self)) {
    self val::reset(#"remote_missile", "ignoreme");
    self val::reset(#"remote_missile", "takedamage");
  }
}

function function_f7599440(on) {
  if(!isDefined(level.var_15ebb842)) {
    level.var_15ebb842 = 0;
  }

  if(on) {
    clientfield::set("" + # "hash_59ec82b1a72deb72", 1);
    level.var_15ebb842++;
    return;
  }

  level.var_15ebb842--;

  if(level.var_15ebb842 <= 0) {
    clientfield::set("" + # "hash_59ec82b1a72deb72", 0);
    level.var_15ebb842 = undefined;
  }
}