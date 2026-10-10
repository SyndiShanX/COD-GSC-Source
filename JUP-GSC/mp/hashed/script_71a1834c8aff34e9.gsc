/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_71a1834c8aff34e9.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\engine\utility;
#namespace powerup_zombie_legs;

function autoexec main() {
  if(getdvarint(@ "hash_e57295eeedbf41eb", 0)) {
    return;
  }

  init();

  init_debug();
}

function init() {
  powerups::register_powerup("zombie_legs", &powerup_grab, &function_3be4188976ad0fe9);
}

function powerup_grab(str_powerup, ent_powerup) {
  a_players = function_a56a8b17eae57b09(str_powerup);

  foreach(player in a_players) {
    player thread powerup_apply_zombie_legs();
  }
}

function function_3be4188976ad0fe9() {
  return true;
}

function powerup_apply_zombie_legs(n_lifetime) {
  self notify("powerup_apply_zombie_legs");
  self endon("powerup_apply_zombie_legs");
  self endon("disconnect");

  if(!isDefined(n_lifetime)) {
    n_lifetime = powerups::function_e419d148895ea689("zombie_legs");
  }

  thread namespace_2b1145f62aa835b8::function_a93fbc5ac33fc2f2("zombie_legs", n_lifetime);

  if(!istrue(self.var_9ee4330fe38ffc6)) {
    self.var_9ee4330fe38ffc6 = 1;
    namespace_2b1145f62aa835b8::function_5942f6cdbb6cb63b("specialty_zombie_legs");
    thread function_569121dd947653d1();
  }

  waittill_any_timeout_2(n_lifetime, "end_powerup_zombie_legs", "death");
  powerup_remove_zombie_legs();
}

function powerup_remove_zombie_legs() {
  self notify("powerup_remove_zombie_legs");
  namespace_2b1145f62aa835b8::function_edbac3224d97a666("specialty_zombie_legs");
  self.var_9ee4330fe38ffc6 = undefined;
}

function function_569121dd947653d1() {
  self endon("powerup_remove_zombie_legs");
  self endon("death_or_disconnect");

  while(self.var_9ee4330fe38ffc6) {
    self waittill("giveLoadout");
    namespace_2b1145f62aa835b8::function_5942f6cdbb6cb63b("specialty_zombie_legs");
  }
}

function init_debug() {
  function_6e7290c8ee4f558b("<dev string:x1c>");
  function_b23a59dfb4ca49a1("<dev string:x2f>", "<dev string:x50>" + "<dev string:x68>" + "<dev string:x77>", &function_e2b8eeccc951133f);
  function_b23a59dfb4ca49a1("<dev string:x7d>", "<dev string:x50>" + "<dev string:x68>" + "<dev string:x9e>", &function_e2b8eeccc951133f);
  function_fe953f000498048f();
}

# /