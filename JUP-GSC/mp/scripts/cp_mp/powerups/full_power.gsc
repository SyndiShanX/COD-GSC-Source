/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\powerups\full_power.gsc
****************************************************/

#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\cp_mp\powerups\powerups;
#using scripts\engine\utility;
#using scripts\mp\supers;
#using scripts\mp\utility\perk;
#namespace full_power;

function autoexec main() {
  function_e7a47b85d23dfd4f();
}

function function_e7a47b85d23dfd4f() {
  register_powerup("full_power", &function_96a1ada875ea9db3, &function_986227ff88aed0d1);

  function_6e7290c8ee4f558b("<dev string:x1c>");
  function_b23a59dfb4ca49a1("<dev string:x2f>", "<dev string:x4f>", &function_e2b8eeccc951133f);
  function_b23a59dfb4ca49a1("<dev string:x73>", "<dev string:x93>", &function_e2b8eeccc951133f);
  function_fe953f000498048f();
}

function function_986227ff88aed0d1() {
  if(istrue(level.var_44c84134585ab85b)) {
    return true;
  }

  return false;
}

function function_96a1ada875ea9db3(str_powerup, ent_powerup) {
  a_players = function_a56a8b17eae57b09(str_powerup);

  foreach(player in a_players) {
    player give_power();
    player thread function_676437737684783f(str_powerup);
  }

  level notify("zmb_full_power_level");
}

function give_power() {
  s_super = getcurrentsuper();

  if(!isalive(self) || !isDefined(s_super)) {
    return;
  }

  superinfo = getcurrentsuper();

  if(isDefined(s_super) && s_super.isinuse) {
    callback::add("on_super_use_finished", &on_super_use_finished);
    return;
  }

  points_needed = 0;
  var_955d46d1430e96e1 = issuperready();

  if(!var_955d46d1430e96e1) {
    points_needed = getsuperpointsneeded() - getcurrentsuperpoints();
  }

  if(scripts\mp\utility\perk::_hasperk("specialty_overcharge_field_upgrade")) {
    var_5155bc50f8bd32c2 = function_6c06220f8b5b7079();

    if(var_955d46d1430e96e1 && !var_5155bc50f8bd32c2) {
      points_needed = getsuperpointsneeded() - self.overclockcharge;
    }
  }

  if(points_needed != 0) {
    givesuperpoints(points_needed);
  }
}

function private on_super_use_finished(params) {
  if(isalive(self)) {
    give_power();
    callback::remove("on_super_use_finished", &on_super_use_finished);
  }
}