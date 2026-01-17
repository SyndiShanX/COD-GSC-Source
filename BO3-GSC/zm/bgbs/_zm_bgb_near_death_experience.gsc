/*****************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_near_death_experience.gsc
*****************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_near_death_experience;

function autoexec __init__sytem__() {
  system::register("zm_bgb_near_death_experience", &__init__, undefined, "bgb");
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  clientfield::register("allplayers", "zm_bgb_near_death_experience_3p_fx", 15000, 1, "int");
  clientfield::register("toplayer", "zm_bgb_near_death_experience_1p_fx", 15000, 1, "int");
  bgb::register("zm_bgb_near_death_experience", "rounds", 3, &enable, &disable, undefined, undefined);
  bgb::register_lost_perk_override("zm_bgb_near_death_experience", &lost_perk_override, 1);
}

function enable() {
  self endon("disconnect");
  self endon("bled_out");
  self endon("bgb_update");
  if(!isDefined(level.var_81ca70ba)) {
    level.var_81ca70ba = 0;
  }
  self thread bgb::function_4ed517b9(240, &function_ff41ae2d, &function_3c1690be);
  self thread function_1a31df5b();
  self thread function_d1a43fc9();
}

function disable() {}

function function_1a31df5b() {
  self endon("disconnect");
  self clientfield::set("zm_bgb_near_death_experience_3p_fx", 1);
  self util::waittill_either("bled_out", "bgb_update");
  self clientfield::set("zm_bgb_near_death_experience_3p_fx", 0);
  self notify("zm_bgb_near_death_experience_complete");
}

function function_d1a43fc9() {
  foreach(e_player in level.players) {
    e_player function_8b5fe69();
  }
  if(level.var_81ca70ba == 0) {
    callback::on_connect(&on_connect);
  }
  level.var_81ca70ba++;
  self util::waittill_any("disconnect", "bled_out", "bgb_update");
  level.var_81ca70ba--;
  if(level.var_81ca70ba == 0) {
    callback::remove_on_connect(&on_connect);
  }
  foreach(e_player in level.players) {
    e_player zm_laststand::deregister_revive_override(e_player.var_e82a0595[0]);
    arrayremoveindex(e_player.var_e82a0595, 0);
  }
}

function on_connect() {
  self function_8b5fe69();
}

function function_8b5fe69() {
  if(!isDefined(self.var_e82a0595)) {
    self.var_e82a0595 = [];
  }
  s_revive_override = self zm_laststand::register_revive_override(&function_73277c01);
  if(!isDefined(self.var_e82a0595)) {
    self.var_e82a0595 = [];
  } else if(!isarray(self.var_e82a0595)) {
    self.var_e82a0595 = array(self.var_e82a0595);
  }
  self.var_e82a0595[self.var_e82a0595.size] = s_revive_override;
}

function function_73277c01(e_revivee) {
  if(!isDefined(e_revivee.revivetrigger)) {
    return false;
  }
  if(!isalive(self)) {
    return false;
  }
  if(self laststand::player_is_in_laststand()) {
    return false;
  }
  if(self.team != e_revivee.team) {
    return false;
  }
  if(isDefined(self.is_zombie) && self.is_zombie) {
    return false;
  }
  if(isDefined(level.can_revive_use_depthinwater_test) && level.can_revive_use_depthinwater_test && e_revivee depthinwater() > 10) {
    return true;
  }
  if(isDefined(level.can_revive) && ![[level.can_revive]](e_revivee)) {
    return false;
  }
  if(isDefined(level.can_revive_game_module) && ![[level.can_revive_game_module]](e_revivee)) {
    return false;
  }
  if(e_revivee zm::in_kill_brush() || !e_revivee zm::in_enabled_playable_area()) {
    return false;
  }
  if(self bgb::is_enabled("zm_bgb_near_death_experience") && isDefined(self.var_6638f10b) && array::contains(self.var_6638f10b, e_revivee)) {
    return true;
  }
  if(e_revivee bgb::is_enabled("zm_bgb_near_death_experience") && isDefined(e_revivee.var_6638f10b) && array::contains(e_revivee.var_6638f10b, self)) {
    return true;
  }
  return false;
}

function lost_perk_override(perk, var_2488e46a = undefined, var_24df4040 = undefined) {
  self thread bgb::revive_and_return_perk_on_bgb_activation(perk);
  return false;
}

function function_ff41ae2d(e_player) {
  var_5b3c4fd2 = "zm_bgb_near_death_experience_proximity_end_" + self getentitynumber();
  e_player endon(var_5b3c4fd2);
  e_player endon("disconnect");
  self endon("disconnect");
  self endon("zm_bgb_near_death_experience_complete");
  while(true) {
    if(!e_player laststand::player_is_in_laststand() && !self laststand::player_is_in_laststand()) {
      util::waittill_any_ents_two(e_player, "player_downed", self, "player_downed");
    }
    self thread function_1863dac5(e_player, var_5b3c4fd2);
    var_c888b99d = "zm_bgb_near_death_experience_1p_fx_stop_" + self getentitynumber();
    e_player waittill(var_c888b99d);
  }
}

function function_1863dac5(e_player, str_notify) {
  var_ac3e3041 = self function_52d6b4dc(e_player, str_notify);
  if(!(isDefined(var_ac3e3041) && var_ac3e3041)) {
    return;
  }
  self function_d1d595b5();
  e_player function_d1d595b5();
  self function_c8cee225(e_player, str_notify);
  if(isDefined(self)) {
    self function_c0b35f9d();
  }
  if(isDefined(e_player)) {
    e_player function_c0b35f9d();
    e_player notify("zm_bgb_near_death_experience_1p_fx_stop_" + self getentitynumber());
  }
}

function function_52d6b4dc(e_player, str_notify) {
  e_player endon(str_notify);
  e_player endon("disconnect");
  self endon("disconnect");
  self endon("zm_bgb_near_death_experience_complete");
  while(!self function_73277c01(e_player) && !e_player function_73277c01(self)) {
    wait(0.1);
  }
  return true;
}

function function_c8cee225(e_player, str_notify) {
  e_player endon(str_notify);
  e_player endon("disconnect");
  self endon("disconnect");
  self endon("zm_bgb_near_death_experience_complete");
  while(self function_73277c01(e_player) || e_player function_73277c01(self)) {
    wait(0.1);
  }
}

function function_3c1690be(e_player) {
  str_notify = "zm_bgb_near_death_experience_proximity_end_" + self getentitynumber();
  e_player notify(str_notify);
}

function function_d1d595b5() {
  if(!isDefined(self.var_62125e4d) || self.var_62125e4d == 0) {
    self.var_62125e4d = 1;
    self clientfield::set_to_player("zm_bgb_near_death_experience_1p_fx", 1);
  } else {
    self.var_62125e4d++;
  }
}

function function_c0b35f9d() {
  self.var_62125e4d--;
  if(self.var_62125e4d == 0) {
    self clientfield::set_to_player("zm_bgb_near_death_experience_1p_fx", 0);
  }
}