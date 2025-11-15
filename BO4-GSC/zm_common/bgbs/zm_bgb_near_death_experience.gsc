/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_near_death_experience.gsc
***********************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_laststand;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_player;

#namespace zm_bgb_near_death_experience;

autoexec __init__system__() {
  system::register(#"zm_bgb_near_death_experience", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  clientfield::register("allplayers", "zm_bgb_near_death_experience_3p_fx", 1, 1, "int");
  clientfield::register("toplayer", "zm_bgb_near_death_experience_1p_fx", 1, 1, "int");
  bgb::register(#"zm_bgb_near_death_experience", "time", 600, &enable, &disable, undefined, undefined);
  bgb::register_lost_perk_override(#"zm_bgb_near_death_experience", &lost_perk_override, 1);
}

enable() {
  self endon(#"disconnect", #"bled_out", #"bgb_update");

  if(!isDefined(level.var_67998b2d)) {
    level.var_67998b2d = 0;
  }

  self thread bgb::function_f51e3503(240, &function_db295169, &function_cbaf1f69);
  self thread function_68acd38e();
  self thread revive_override();
}

disable() {}

function_68acd38e() {
  self endon(#"disconnect");
  self clientfield::set("zm_bgb_near_death_experience_3p_fx", 1);
  self waittill(#"bled_out", #"bgb_update");
  self clientfield::set("zm_bgb_near_death_experience_3p_fx", 0);
  self notify(#"zm_bgb_near_death_experience_complete");
}

revive_override() {
  self.var_718eafbc = 0;

  foreach(e_player in level.players) {
    e_player function_fa0a1b19();
  }

  if(level.var_67998b2d == 0) {
    callback::on_connect(&on_connect);
  }

  level.var_67998b2d++;
  self waittill(#"disconnect", #"bled_out", #"bgb_update");
  level.var_67998b2d--;

  if(level.var_67998b2d == 0) {
    callback::remove_on_connect(&on_connect);
  }

  foreach(e_player in level.players) {
    e_player zm_laststand::deregister_revive_override(e_player.var_8597ff2d[0]);
    arrayremoveindex(e_player.var_8597ff2d, 0);
  }
}

on_connect() {
  self function_fa0a1b19();
}

function_fa0a1b19() {
  if(!isDefined(self.var_8597ff2d)) {
    self.var_8597ff2d = [];
  }

  s_revive_override = self zm_laststand::register_revive_override(&function_d5c9a81);

  if(!isDefined(self.var_8597ff2d)) {
    self.var_8597ff2d = [];
  } else if(!isarray(self.var_8597ff2d)) {
    self.var_8597ff2d = array(self.var_8597ff2d);
  }

  self.var_8597ff2d[self.var_8597ff2d.size] = s_revive_override;
}

function_d5c9a81(e_revivee) {
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

  if(isDefined(level.var_1461fd14) && ![[level.var_1461fd14]](e_revivee)) {
    return false;
  }

  if(e_revivee zm_player::in_kill_brush() || !e_revivee zm_player::in_enabled_playable_area()) {
    return false;
  }

  if(self bgb::is_enabled(#"zm_bgb_near_death_experience") && isDefined(self.var_9c42f3fe) && array::contains(self.var_9c42f3fe, e_revivee)) {
    return true;
  }

  if(e_revivee bgb::is_enabled(#"zm_bgb_near_death_experience") && isDefined(e_revivee.var_9c42f3fe) && array::contains(e_revivee.var_9c42f3fe, self)) {
    return true;
  }

  return false;
}

lost_perk_override(perk, var_a83ac70f = undefined, var_6c1b825d = undefined) {
  self thread zm_perks::function_b2dfd295(perk, &bgb::function_bd839f2c);
  return false;
}

function_db295169(e_player) {
  var_4cd31497 = "zm_bgb_near_death_experience_proximity_end_" + self getentitynumber();
  e_player endon(var_4cd31497, #"disconnect");
  self endon(#"disconnect", #"zm_bgb_near_death_experience_complete");

  while(true) {
    if(!e_player laststand::player_is_in_laststand() && !self laststand::player_is_in_laststand()) {
      util::waittill_any_ents_two(e_player, "player_downed", self, "player_downed");
    }

    self thread function_b7269898(e_player, var_4cd31497);
    var_9dd95907 = "zm_bgb_near_death_experience_1p_fx_stop_" + self getentitynumber();
    e_player waittill(var_9dd95907);
  }
}

function_b7269898(e_player, str_notify) {
  var_996880d2 = self function_991be229(e_player, str_notify);

  if(!(isDefined(var_996880d2) && var_996880d2)) {
    return;
  }

  self function_51e0947e();
  e_player function_51e0947e();
  self function_3895d86(e_player, str_notify);

  if(isDefined(self)) {
    self function_68790c5a();
  }

  if(isDefined(e_player)) {
    e_player function_68790c5a();
    e_player notify("zm_bgb_near_death_experience_1p_fx_stop_" + self getentitynumber());

    if(!e_player laststand::player_is_in_laststand()) {
      self thread function_765e5d1c();
    }
  }
}

function_991be229(e_player, str_notify) {
  e_player endon(str_notify, #"disconnect");
  self endon(#"disconnect", #"zm_bgb_near_death_experience_complete");

  while(!self function_d5c9a81(e_player) && !e_player function_d5c9a81(self)) {
    wait 0.1;
  }

  return true;
}

function_3895d86(e_player, str_notify) {
  e_player endon(str_notify, #"disconnect");
  self endon(#"disconnect", #"zm_bgb_near_death_experience_complete");

  while(self function_d5c9a81(e_player) || e_player function_d5c9a81(self)) {
    wait 0.1;
  }
}

function_cbaf1f69(e_player) {
  str_notify = "zm_bgb_near_death_experience_proximity_end_" + self getentitynumber();
  e_player notify(str_notify);
}

function_51e0947e() {
  if(!isDefined(self.var_7a276c72) || self.var_7a276c72 == 0) {
    self.var_7a276c72 = 1;
    self clientfield::set_to_player("zm_bgb_near_death_experience_1p_fx", 1);
    return;
  }

  self.var_7a276c72++;
}

function_68790c5a() {
  self.var_7a276c72--;

  if(self.var_7a276c72 == 0) {
    self clientfield::set_to_player("zm_bgb_near_death_experience_1p_fx", 0);
  }
}

function_765e5d1c() {
  n_step = 120 / 600;
  n_original = self clientfield::get_player_uimodel("zmhud.bgb_timer");
  self.var_718eafbc++;
  var_4bfcf47f = 1 - self.var_718eafbc * n_step;

  if(n_original > var_4bfcf47f) {
    self bgb::set_timer(600 * var_4bfcf47f, 600, 1);
  }
}