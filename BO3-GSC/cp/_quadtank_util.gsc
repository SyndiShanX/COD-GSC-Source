/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_quadtank_util.gsc
*************************************************/

#using scripts\cp\_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicles\_quadtank;
#namespace namespace_855113f3;

function function_35209d64() {
  self thread function_ea61aedc();
  callback::on_vehicle_damage(&function_610493ff, self);
}

function function_ea61aedc() {
  self endon("death");
  self endon("hash_f1e417ec");
  var_fae93870 = 0;
  var_c1df3693 = 2;
  var_9a15ea97 = getweapon("launcher_standard");
  while(true) {
    self notify("hash_82f5563d");
    self waittill("projectile_applyattractor", missile);
    if(missile.weapon === var_9a15ea97) {
      var_fae93870++;
      if(var_fae93870 >= var_c1df3693) {
        var_fae93870 = 0;
        foreach(player in level.activeplayers) {
          player thread util::show_hint_text(&"OBJECTIVES_QUAD_TANK_HINT_TROPHY", 0, "quad_tank_trophy_hint_disable");
          player thread function_82f5563d(self);
        }
        var_c1df3693 = var_c1df3693 * 2;
      }
      wait(2);
    }
  }
}

function function_82f5563d(var_ac4390f) {
  var_ac4390f endon("hash_82f5563d");
  var_ac4390f endon("death");
  self endon("death");
  var_ac4390f util::waittill_any("trophy_system_disabled", "trophy_system_destroyed");
  self notify("hash_82f5563d");
  var_ac4390f notify("hash_82f5563d");
}

function function_610493ff(obj, params) {
  if(isPlayer(params.eattacker) && self quadtank::trophy_disabled() && issubstr(params.smeansofdeath, "BULLET")) {
    player = params.eattacker;
    if(isDefined(player.var_d4b7c617)) {
      player.var_d4b7c617 = player.var_d4b7c617 + params.idamage;
    } else {
      player.var_d4b7c617 = params.idamage;
    }
    if(player.var_d4b7c617 >= 999) {
      player.var_d4b7c617 = 0;
      player notify("hash_d9337df");
      player thread util::show_hint_text(&"OBJECTIVES_QUAD_TANK_HINT_ROCKET", 0, "quad_tank_rocket_hint_disable");
      player thread function_d9337df(self);
    }
  }
}

function function_d9337df(var_ac4390f) {
  var_ac4390f endon("death");
  self endon("death");
  self endon("hash_d9337df");
  while(true) {
    var_ac4390f waittill("damage", n_damage, e_attacker, direction_vec, v_impact_point, damagetype, modelname, tagname, partname, weapon, idflags);
    if(weapon.weapclass === "rocketlauncher" && isPlayer(e_attacker)) {
      var_ac4390f notify("hash_d9337df");
      self notify("hash_d9337df");
    }
  }
}