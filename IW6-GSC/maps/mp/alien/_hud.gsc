/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_hud.gsc
*****************************************************/

#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\alien\_persistence;
#include maps\mp\alien\_perk_utility;

CREDIT_GAIN_DEFAULT_FONT_SIZE = 1.38;
SPLITSCREEN_CREDIT_GAIN_DEFAULT_FONT_SIZE = 1.2;

init() {
  register_end_game_string_index();
}

playPainOverlay(attacker, weapon_name, direction) {
  if(isUsingRemote() && maps\mp\alien\_utility::is_true(self.vanguard_num)) {
    return;
  }
  damage_direction = get_damage_direction(direction);

  if(is_spitter_spit(weapon_name)) {
    self play_spitter_pain_overlay(damage_direction);
  } else if(is_spitter_gas(weapon_name)) {
    self play_spitter_pain_overlay("center");
  } else if(is_elite_attack(attacker)) {
    PlayFXOnTagForClients(level._effect["vfx_melee_blood_spray"], self, "tag_eye", self);
  } else {
    self play_basic_pain_overlay(damage_direction);
  }
}

get_damage_direction(direction) {
  COS_15 = 0.965;

  possible_directions = ["left", "center", "right"];

  if(!isDefined(direction)) {
    return possible_directions[randomInt(possible_directions.size)];
  }

  direction *= -1;

  self_forward = anglesToForward(self.angles);
  forward_dot_product = VectorDot(direction, self_forward);

  if(forward_dot_product > COS_15) {
    return "center";
  }

  self_right = anglesToRight(self.angles);
  right_dot_product = VectorDot(direction, self_right);

  if(right_dot_product > 0) {
    return "right";
  } else {
    return "left";
  }
}

play_basic_pain_overlay(damage_direction) {
  if(damage_direction == "left") {
    PlayFXOnTagForClients(level._effect["vfx_blood_hit_left"], self, "tag_eye", self);
  } else if(damage_direction == "center") {
    PlayFXOnTagForClients(level._effect["vfx_melee_blood_spray"], self, "tag_eye", self);
  } else if(damage_direction == "right") {
    PlayFXOnTagForClients(level._effect["vfx_blood_hit_right"], self, "tag_eye", self);
  } else {
    AssertMsg("Unknown damage_direction: " + damage_direction);
  }
}

play_spitter_pain_overlay(damage_direction) {
  if(damage_direction == "left") {
    PlayFXOnTagForClients(level._effect["vfx_alien_spitter_hit_left"], self, "tag_eye", self);
  } else if(damage_direction == "center") {
    PlayFXOnTagForClients(level._effect["vfx_alien_spitter_hit_center"], self, "tag_eye", self);
  } else if(damage_direction == "right") {
    PlayFXOnTagForClients(level._effect["vfx_alien_spitter_hit_right"], self, "tag_eye", self);
  } else {
    AssertMsg("Unknown damage_direction: " + damage_direction);
  }
}

play_slash_pain_overlay(damage_direction) {
  if(damage_direction == "center") {
    damage_direction = random_pick_R_or_L();
  }

  if(damage_direction == "left") {
    PlayFXOnTagForClients(level._effect["vfx_blood_hit_left"], self, "tag_eye", self);
  } else if(damage_direction == "right") {
    PlayFXOnTagForClients(level._effect["vfx_blood_hit_right"], self, "tag_eye", self);
  } else {
    AssertMsg("Unknown damage_direction: " + damage_direction);
  }
}

play_goo_pain_overlay(damage_direction) {
  if(damage_direction == "left") {
    PlayFXOnTagForClients(level._effect["vfx_alien_spitter_hit_left"], self, "tag_eye", self);
  } else if(damage_direction == "center") {
    PlayFXOnTagForClients(level._effect["vfx_alien_spitter_hit_center"], self, "tag_eye", self);
  } else if(damage_direction == "right") {
    PlayFXOnTagForClients(level._effect["vfx_alien_spitter_hit_right"], self, "tag_eye", self);
  } else {
    AssertMsg("Unknown damage_direction: " + damage_direction);
  }
}

random_pick_R_or_L() {
  if(cointoss()) {
    return "right";
  } else {
    return "left";
  }
}

is_spitter_spit(weapon_name) {
  if(!isDefined(weapon_name)) {
    return false;
  }

  return (weapon_name == "alienspit_mp");
}

is_spitter_gas(weapon_name) {
  if(!isDefined(weapon_name)) {
    return false;
  }

  return (weapon_name == "alienspit_gas_mp");
}

is_elite_attack(attacker) {
  if(!isDefined(attacker) || !attacker maps\mp\alien\_utility::is_alien_agent()) {
    return false;
  }

  return (attacker maps\mp\alien\_utility::get_alien_type() == "elite");
}

lastStandUpdateReviveIconColorAlien(bleedOutTime) {
  self endon("death");
  level endon("game_ended");

  wait bleedOutTime / 3;
  self.color = (1.0, 0.64, 0.0);

  wait bleedOutTime / 3;
  self.color = (1.0, 0.0, 0.0);
}

makeReviveIcon(owner, color, bleedOutTime) {
  reviveIcon = newTeamHudElem(owner.team);
  reviveIcon setShader("waypoint_alien_revive", 8, 8);
  reviveIcon setWaypoint(true, true);
  reviveIcon SetTargetEnt(self);
  reviveIcon.color = color;

  reviveIcon thread deleteReviveIcon(owner);

  if(isDefined(bleedOutTime)) {
    reviveIcon thread lastStandUpdateReviveIconColorAlien(bleedOutTime);
  }

  return reviveIcon;
}

deleteReviveIcon(owner) {
  self endon("death");

  owner waittill_any("disconnect", "revive", "death");
  self destroy();
}

hideHudElementOnGameEnd(hudElement) {
  level waittill("game_ended");
  if(isDefined(hudElement)) {
    hudElement.alpha = 0;
  }
}

blocker_hive_hp_bar() {
  submitted_health = 100000;
  while(isDefined(self) && self.health > 0) {
    self waittill_notify_or_timeout("damage", 2);

    if(!isDefined(self) || self.health <= 0) {
      break;
    }

    hp_ratio = max(0.005, self.health / self.maxhealth);
    inverse_health = 100 - hp_ratio * 100;

    throttle = 0.5;
    if(abs(abs(submitted_health) - abs(inverse_health)) > throttle) {
      SetOmnvar("ui_alien_boss_progression", inverse_health);
      submitted_health = inverse_health;
    }
  }
  SetOmnvar("ui_alien_boss_status", 0);
}

blocker_hive_chopper_hp_bar() {
  while(isDefined(self) && self.health > 0) {
    self waittill_notify_or_timeout("damage", 2);

    if(!isDefined(self) || self.health <= 0) {
      break;
    }

    hp_ratio = self.health / self.maxhealth;
    health_remaining = hp_ratio * 100;
  }
}

init_player_hud_onconnect() {
  VisionSetPain("near_death_mp");

  self.hud_laststand_count = self create_hud_laststand_count(0, -20, 1.0);
}

create_hud_laststand_count(xpos, ypos, scale) {
  self.hud_laststand_counter = 0;

  hud_score = self maps\mp\gametypes\_hud_util::createFontString("objective", scale);
  hud_score maps\mp\gametypes\_hud_util::setPoint("BOTTOM LEFT", "BOTTOM LEFT", xpos, ypos);
  hud_score.color = (1, 1, 0);
  hud_score.glowAlpha = 1;
  hud_score.sort = 1;
  hud_score.hideWhenInMenu = true;
  hud_score.archived = true;
  hud_score.label = &"";
  hud_score setValue(0);

  if(getDvarInt("debug_alien_laststand_hud", 0) == 1) {
    hud_score.alpha = 1;
  } else {
    hud_score.alpha = 0;
  }

  return hud_score;
}

update_hud_laststand_count() {
  self.hud_laststand_counter++;
  self.hud_laststand_count setValue(self.hud_laststand_counter);
}

createSpendHintHUD(resource, rank, message) {
  if(!isDefined(message)) {
    self setLowerMessage("spend_hint", &"ALIEN_COLLECTIBLES_PULL_TO_SPEND");
  } else {
    self setLowerMessage("spend_hint", message);
  }
  self thread hideSpendHintIcon();
}

hideSpendHintIcon() {
  self endon("death");
  self endon("disconnect");
  self waittill_any_timeout(3, "action_finish_used", "player_action_slot_restart", "kill_spendhint");
  self clearLowerMessage("spend_hint");
}

intro_black_screen() {
  self endon("disconnect");
  self endon("stop_intro");

  self.introscreen_overlay = newClientHudElem(self);

  self.introscreen_overlay.x = 0;
  self.introscreen_overlay.y = 0;
  self.introscreen_overlay setshader("black", 640, 480);
  self.introscreen_overlay.alignX = "left";
  self.introscreen_overlay.alignY = "top";
  self.introscreen_overlay.sort = 1;
  self.introscreen_overlay.horzAlign = "fullscreen";
  self.introscreen_overlay.vertAlign = "fullscreen";
  self.introscreen_overlay.alpha = 1;
  self.introscreen_overlay.foreground = true;
  level waittill("introscreen_over");
  self.introscreen_overlay FadeOverTime(3);
  self.introscreen_overlay.alpha = 0;
  wait(3.5);
  self.introscreen_overlay Destroy();
}

introscreen_corner_line(string, index_key) {
  if(!isDefined(level.intro_offset)) {
    level.intro_offset = 0;
  } else {
    level.intro_offset++;
  }

  y = cornerline_height();

  font_scale = 1.6;
  if(level.splitscreen) {
    font_scale = 2;
  }

  hudelem = NewHudElem();
  hudelem.x = 20;
  hudelem.y = y;
  hudelem.alignX = "left";
  hudelem.alignY = "bottom";
  hudelem.horzAlign = "left";
  hudelem.vertAlign = "bottom";
  hudelem.sort = 3;
  hudelem.foreground = true;
  hudelem SetText(string);
  hudelem.alpha = 1;
  hudelem.hidewheninmenu = true;
  hudelem.fontScale = font_scale;
  hudelem.color = (0.8, 1.0, 0.8);
  hudelem.font = "default";
  hudelem.glowColor = (0.3, 0.6, 0.3);
  hudelem.glowAlpha = 1;
  hudelem setPulseFX(35, 4000, 1000);
  return hudelem;
}

cornerline_height() {
  offset = -92;

  if(level.splitscreen) {
    offset = -110;
  }

  return (((level.intro_offset) * 20) - 92);
}

displayAlienGameEnd(winner, endReasonTextIndex) {
  foreach(player in level.players) {
    if(isDefined(player.connectedPostGame) || player.pers["team"] == "spectator") {
      continue;
    }
    player thread alienOutcomeNotify(winner, endReasonTextIndex);
    player thread freezeControlsWrapper(true);
  }

  level notify("game_win", winner);

  maps\mp\gametypes\_gamelogic::roundEndWait(level.postRoundTime, true);
}

alienOutcomeNotify(winner, end_reason_text_index) {
  self endon("disconnect");
  self notify("reset_outcome");

  wait(0.5);

  team = self.pers["team"];
  if(!isDefined(team) || (team != "allies" && team != "axis")) {
    team = "allies";
  }

  while(self maps\mp\gametypes\_hud_message::isDoingSplash()) {
    wait 0.05;
  }

  self endon("reset_outcome");

  if(isDefined(self.pers["team"]) && winner == team) {
    outcome_title_index = get_end_game_string_index("win");
  } else {
    outcome_title_index = get_end_game_string_index("fail");
  }

  self setClientOmnvar("ui_round_end_title", outcome_title_index);
  self setClientOmnvar("ui_round_end_reason", end_reason_text_index);
  self setClientOmnvar("ui_alien_show_eog_score", true);
}

register_end_game_string_index() {
  if(isDefined(level.end_game_string_override)) {
    [[level.end_game_string_override]]();
  } else {
    register_default_end_game_string_index();
  }
}

register_default_end_game_string_index() {
  level.end_game_string_index = [];

  level.end_game_string_index["win"] = 1;
  level.end_game_string_index["fail"] = 2;

  level.end_game_string_index["all_escape"] = 1;
  level.end_game_string_index["some_escape"] = 2;
  level.end_game_string_index["fail_escape"] = 3;
  level.end_game_string_index["drill_destroyed"] = 4;
  level.end_game_string_index["kia"] = 5;
  level.end_game_string_index["host_end"] = 6;
  level.end_game_string_index["gas_fail"] = 7;
  level.end_game_string_index["generator_destroyed"] = 8;
}

get_end_game_string_index(key) {
  return level.end_game_string_index[key];
}

show_encounter_scores() {
  level endon("game_ended ");

  SetOmnvar("ui_alien_show_encounter_score", true);
  wait 1.0;
  SetOmnvar("ui_alien_show_encounter_score", false);
}

reset_player_encounter_LUA_omnvars(player) {
  CONST_ENCOUNTER_SCORE_MAX_NUM_ROW = 8;

  for(row_number = 1; row_number <= CONST_ENCOUNTER_SCORE_MAX_NUM_ROW; row_number++) {
    title_omnvar_name = "ui_alien_encounter_title_row_" + row_number;
    score_omnvar_name = "ui_alien_encounter_score_row_" + row_number;
    player setClientOmnvar(title_omnvar_name, 0);
    player setClientOmnvar(score_omnvar_name, 0);
  }
}

set_LUA_encounter_score_row(player, row_number, row_title, row_score) {
  omnvar_title_name = "ui_alien_encounter_title_row_" + row_number;
  omnvar_score_name = "ui_alien_encounter_score_row_" + row_number;
  player setClientOmnvar(omnvar_title_name, row_title);
  player setClientOmnvar(omnvar_score_name, row_score);
}

set_LUA_EoG_score_row(player, row_number, row_title, row_score) {
  omnvar_title_name = "ui_alien_eog_title_row_" + row_number;
  omnvar_score_name = "ui_alien_eog_score_row_" + row_number;
  player setClientOmnvar(omnvar_title_name, row_title);
  player setClientOmnvar(omnvar_score_name, row_score);
}

make_wayPoint(shader, icon_width, icon_height, icon_alpha, location) {
  icon = NewHudElem();
  icon SetShader(shader, icon_width, icon_height);
  icon.alpha = icon_alpha;
  icon SetWayPoint(true, true);
  icon.x = location[0];
  icon.y = location[1];
  icon.z = location[2];
  return icon;
}

chaos_HUD_init() {
  level.last_combo_meter_reset_time = 0;
}

set_combo_counter(value) {
  SetOmnvar("ui_alien_chaos_combo_counter", value);
}

set_score_streak(value) {
  SetOmnvar("ui_alien_chaos_score_streak", value);
}

set_total_score(value) {
  SetOmnvar("ui_alien_chaos_total_score", value);
}

reset_combo_meter(combo_duration) {
  if(is_combo_meter_reset_this_frame()) {
    return;
  }
  foreach(player in level.players) {
    now = gettime();
    player SetClientOmnvar("ui_alien_chaos_combo_meter_start", now);
    player SetClientOmnvar("ui_alien_chaos_combo_meter_end", now + int(combo_duration * 1000));
  }
}

is_combo_meter_reset_this_frame() {
  current_time = getTime();
  previous_time = level.last_combo_meter_reset_time;
  level.last_combo_meter_reset_time = current_time;

  return (current_time == previous_time);
}

set_grace_period_clock(grace_period_end_time) {
  setOmnvar("ui_alien_chaos_grace_period", grace_period_end_time);
}

unset_grace_period_clock() {
  setOmnvar("ui_alien_chaos_grace_period", 0);
}

set_has_combo_freeze(player, has_combo_freeze) {
  player setClientOmnvar("ui_alien_chaos_has_meter_freeze", has_combo_freeze);
}

freeze_combo_meter(duration) {
  current_time = gettime();
  SetOmnvar("ui_alien_chaos_meter_freeze_start", current_time);
  SetOmnvar("ui_alien_chaos_meter_freeze_end", current_time + duration * 1000);
}

unfreeze_combo_meter() {
  SetOmnvar("ui_alien_chaos_meter_freeze_start", 0);
  SetOmnvar("ui_alien_chaos_meter_freeze_end", 0);
}

set_event_count(event_id, event_count) {
  foreach(player in level.players) {
    player SetClientOmnvar("ui_alien_eog_score_row_" + event_id, event_count);
  }
}

set_has_chaos_class_skill_bonus(player, class_index) {
  player setClientOmnvar("ui_alien_chaos_class_skill_bonus", class_index);
}
unset_has_chaos_class_skill_bonus(player) {
  player setClientOmnvar("ui_alien_chaos_class_skill_bonus", 0);
}

set_last_stand_timer(player, duration) {
  player setClientOmnvar("ui_laststand_end_milliseconds", gettime() + (duration * 1000));
}

clear_last_stand_timer(player) {
  player setClientOmnvar("ui_laststand_end_milliseconds", 0);
}

turn_on_drill_meter_HUD(drill_duration_sec) {
  SetOmnvar("ui_alien_drill_state", 1);

  drill_end_time_ms = int(gettime() + drill_duration_sec * 1000);
  SetOmnvar("ui_alien_drill_start_milliseconds", gettime());
  SetOmnvar("ui_alien_drill_end_milliseconds", drill_end_time_ms);
}

update_drill_health(drill_health) {
  SetOmnvar("ui_alien_drill_health_text", drill_health);
}