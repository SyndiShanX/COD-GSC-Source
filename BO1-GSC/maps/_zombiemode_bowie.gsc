/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_bowie.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;

bowie_init() {
  PrecacheItem("zombie_bowie_flourish");
  if(isDefined(level.bowie_cost)) {
    cost = level.bowie_cost;
  } else {
    cost = 3000;
  }
  bowie_triggers = getEntArray("bowie_upgrade", "targetname");
  for(i = 0; i < bowie_triggers.size; i++) {
    knife_model = getEnt(bowie_triggers[i].target, "targetname");
    knife_model hide();
    bowie_triggers[i] thread bowie_think(cost);
    bowie_triggers[i] SetHintString(&"ZOMBIE_WEAPON_BOWIE_BUY", cost);
    bowie_triggers[i] setCursorHint("HINT_NOICON");
    bowie_triggers[i] UseTriggerRequireLookAt();
  }
}

bowie_think(cost) {
  self.first_time_triggered = false;
  for(;;) {
    self waittill("trigger", player);
    if(!is_player_valid(player)) {
      player thread ignore_triggers(0.5);
      continue;
    }
    if(player in_revive_trigger()) {
      wait(0.1);
      continue;
    }
    if(player isThrowingGrenade()) {
      wait(0.1);
      continue;
    }
    if(player is_drinking()) {
      wait(0.1);
      continue;
    }
    if(player hasWeapon("bowie_knife_zm") || player hasWeapon("minigun_zm")) {
      wait(0.1);
      continue;
    }
    if(player isSwitchingWeapons()) {
      wait(0.1);
      continue;
    }
    current_weapon = player GetCurrentWeapon();
    if(is_placeable_mine(current_weapon) || is_equipment(current_weapon) || current_weapon == "minigun_zm") {
      wait(0.1);
      continue;
    }
    if(player maps\_laststand::player_is_in_laststand() || is_true(player.intermission)) {
      wait(0.1);
      continue;
    }
    player_has_bowie = false;
    if(!player_has_bowie) {
      if(player.score >= cost) {
        if(self.first_time_triggered == false) {
          model = getEnt(self.target, "targetname");
          model thread bowie_show(player);
          self.first_time_triggered = true;
        }
        player maps\_zombiemode_score::minus_to_player_score(cost);
        bbPrint("zombie_uses: playername %s playerscore %d teamscore %d round %d cost %d name %s x %f y %f z %f type weapon",
          player.playername, player.score, level.team_pool[player.team_num].score, level.round_number, cost, "bowie_knife", self.origin);
        player maps\_zombiemode_weapons::check_collector_achievement("bowie_knife_zm");
        player give_bowie();
        if(player maps\_laststand::player_is_in_laststand() || is_true(player.intermission)) {
          continue;
        }
        self SetInvisibleToPlayer(player);
        player._bowie_zm_equipped = 1;
      } else {
        play_sound_on_ent("no_purchase");
        player maps\_zombiemode_audio::create_and_play_dialog("general", "no_money", undefined, 1);
      }
    }
  }
}

give_bowie() {
  gun = self do_bowie_flourish_begin();
  self maps\_zombiemode_audio::create_and_play_dialog("weapon_pickup", "bowie");
  self waittill_any("fake_death", "death", "player_downed", "weapon_change_complete");
  self do_bowie_flourish_end(gun);
}

do_bowie_flourish_begin() {
  self increment_is_drinking();
  self AllowLean(false);
  self AllowAds(false);
  self AllowSprint(false);
  self AllowCrouch(true);
  self AllowProne(false);
  self AllowMelee(false);
  wait(0.05);
  if(self GetStance() == "prone") {
    self SetStance("crouch");
  }
  gun = self GetCurrentWeapon();
  weapon = "zombie_bowie_flourish";
  self GiveWeapon(weapon);
  self SwitchToWeapon(weapon);
  return gun;
}

do_bowie_flourish_end(gun) {
  assert(gun != "zombie_perk_bottle_doubletap");
  assert(gun != "zombie_perk_bottle_revive");
  assert(gun != "zombie_perk_bottle_jugg");
  assert(gun != "zombie_perk_bottle_sleight");
  assert(gun != "zombie_perk_bottle_marathon");
  assert(gun != "zombie_perk_bottle_nuke");
  assert(gun != "zombie_perk_bottle_deadshot");
  assert(gun != "zombie_perk_bottle_additionalprimaryweapon");
  assert(gun != "syrette_sp");
  self AllowLean(true);
  self AllowAds(true);
  self AllowSprint(true);
  self AllowProne(true);
  self AllowMelee(true);
  weapon = "zombie_bowie_flourish";
  if(self maps\_laststand::player_is_in_laststand() || is_true(self.intermission)) {
    self TakeWeapon(weapon);
    self.lastActiveWeapon = "none";
    return;
  }
  if(self hasWeapon("knife_ballistic_zm")) {
    self notify("zmb_lost_knife");
    self TakeWeapon("knife_ballistic_zm");
    self GiveWeapon("knife_ballistic_bowie_zm");
    if(gun == "knife_ballistic_zm") {
      gun = "knife_ballistic_bowie_zm";
    }
  } else if(self hasWeapon("knife_ballistic_upgraded_zm")) {
    self notify("zmb_lost_knife");
    self TakeWeapon("knife_ballistic_upgraded_zm");
    self GiveWeapon("knife_ballistic_bowie_upgraded_zm", 0, self maps\_zombiemode_weapons::get_pack_a_punch_weapon_options("knife_ballistic_bowie_upgraded_zm"));
    if(gun == "knife_ballistic_upgraded_zm") {
      gun = "knife_ballistic_bowie_upgraded_zm";
    }
  }
  self TakeWeapon(weapon);
  self GiveWeapon("bowie_knife_zm");
  self set_player_melee_weapon("bowie_knife_zm");
  if(self hasWeapon("knife_zm")) {
    self TakeWeapon("knife_zm");
  }
  if(self is_multiple_drinking()) {
    self decrement_is_drinking();
    return;
  } else if(gun == "knife_zm") {
    self SwitchToWeapon("bowie_knife_zm");
    self decrement_is_drinking();
    return;
  } else if(gun != "none" && !is_placeable_mine(gun) && !is_equipment(gun)) {
    self SwitchToWeapon(gun);
  } else {
    primaryWeapons = self GetWeaponsListPrimaries();
    if(isDefined(primaryWeapons) && primaryWeapons.size > 0) {
      self SwitchToWeapon(primaryWeapons[0]);
    }
  }
  self waittill("weapon_change_complete");
  if(!self maps\_laststand::player_is_in_laststand() && !is_true(self.intermission)) {
    self decrement_is_drinking();
  }
}

bowie_show(player) {
  player_angles = VectorToAngles(player.origin - self.origin);
  player_yaw = player_angles[1];
  weapon_yaw = self.angles[1];
  yaw_diff = AngleClamp180(player_yaw - weapon_yaw);
  if(yaw_diff > 0) {
    yaw = weapon_yaw - 90;
  } else {
    yaw = weapon_yaw + 90;
  }
  self.og_origin = self.origin;
  self.origin = self.origin + (AnglesToForward((0, yaw, 0)) * 8);
  wait(0.05);
  self Show();
  play_sound_at_pos("weapon_show", self.origin, self);
  time = 1;
  self moveTo(self.og_origin, time);
}