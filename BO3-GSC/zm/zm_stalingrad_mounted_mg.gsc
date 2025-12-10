/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_stalingrad_mounted_mg.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\turret_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_hero_weapon;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\zm_stalingrad_vo;
#namespace zm_stalingrad_mounted_mg;

function autoexec __init__sytem__() {
  system::register("zm_stalingrad_mounted_mg", &__init__, &__main__, undefined);
}

function __init__() {
  clientfield::register("vehicle", "overheat_fx", 12000, 1, "int");
  var_a7761466 = struct::get("pavlov_mg", "targetname");
  s_unitrigger = var_a7761466 zm_unitrigger::create_unitrigger("", 64, &function_f734357f, &function_be759ad7);
  s_unitrigger.hint_parm1 = 1000;
  s_unitrigger.b_enabled = 1;
  s_unitrigger.b_in_use = 0;
}

function __main__() {
  level.var_ffcc580a = getent("pavlov_turret", "targetname");
  level.var_ffcc580a.turret_index = 0;
  level.var_ffcc580a turret::set_burst_parameters(0.75, 1.5, 0.25, 0.75, level.var_ffcc580a.turret_index);
}

function function_f734357f(e_player) {
  if(e_player zm_hero_weapon::is_hero_weapon_in_use()) {
    self sethintstring("");
    return false;
  }
  if(e_player.is_drinking > 0) {
    self sethintstring("");
    return false;
  }
  if(level flag::get("lockdown_active") && level.var_1dfcc9b2.var_22bf30b7 !== 1) {
    self sethintstring("");
    return false;
  }
  if(self.stub.b_enabled == 1 && self.stub.b_in_use == 0) {
    self sethintstring(&"ZM_STALINGRAD_MOUNTED_MG_ACTIVATE", self.stub.hint_parm1);
    return true;
  }
  if(self.stub.b_enabled == 0 && self.stub.b_in_use == 0) {
    self sethintstring(&"ZM_STALINGRAD_MOUNTED_MG_COOLDOWN");
    return false;
  }
  self sethintstring("");
  return false;
}

function function_be759ad7() {
  self waittill("trigger", e_who);
  if(!e_who zm_score::can_player_purchase(1000) && self.stub.b_enabled) {
    e_who zm_audio::create_and_play_dialog("general", "transport_deny");
  } else if(self.stub.b_enabled && !self.stub.b_in_use) {
    e_who clientfield::increment_to_player("interact_rumble");
    e_who zm_score::minus_to_player_score(1000);
    self thread function_f8b87a4e(e_who);
  }
}

function function_f8b87a4e(e_player) {
  var_8de107a = self.stub;
  var_8de107a.b_in_use = 1;
  e_player thread zm_stalingrad_vo::function_32f35525();
  self.stub thread function_8e896de5(e_player);
  level.var_ffcc580a turret::enable(0, 1);
  level.var_ffcc580a makevehicleusable();
  level.var_ffcc580a usevehicle(e_player, 0);
  level.var_ffcc580a.var_3a61625b = e_player;
  level.var_ffcc580a makevehicleunusable();
  wait(0.5);
  level.var_ffcc580a makevehicleusable();
  e_player waittill("exit_vehicle");
  level.var_ffcc580a makevehicleunusable();
  level.var_ffcc580a clearturrettarget();
  var_8de107a thread function_711e7f22();
  wait(1);
  var_8de107a.b_in_use = 0;
  level.var_ffcc580a.var_3a61625b = undefined;
}

function function_8e896de5(e_player) {
  e_player endon("exit_vehicle");
  e_player endon("death");
  level.var_ffcc580a.n_start_time = gettime();
  wait(30);
  level.var_ffcc580a usevehicle(e_player, 0);
}

function function_711e7f22() {
  self.b_enabled = 0;
  level.var_ffcc580a clientfield::set("overheat_fx", 1);
  var_55acad81 = (gettime() - level.var_ffcc580a.n_start_time) / 30000;
  if(var_55acad81 > 1) {
    var_55acad81 = 1;
  }
  n_cooldown = var_55acad81 * 15;
  wait(n_cooldown);
  self.b_enabled = 1;
  level.var_ffcc580a clientfield::set("overheat_fx", 0);
}