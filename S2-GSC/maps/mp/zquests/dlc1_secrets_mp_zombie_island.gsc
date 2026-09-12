/*************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zquests\dlc1_secrets_mp_zombie_island.gsc
*************************************************************/

init_dlc1_secrets_mp_zombie_island() {
  level.zmb_hc_subpens_kills = 0;
  init_zombie_killed_responses();
  level thread minute_notifier();
  level thread solo_challenge_safety();
  level.frontline_assassin_buff_count = 0;
  level.callbackplayerdamagesecondaryhandling = ::secret_challenges_get_player_damage_response;
  level.callbackzombiesdamagesecondaryhandling = ::secret_challenges_get_zombie_damage_response;
  lib_0547::func_7BA9(::secret_challenges_get_zombie_killed_feedback);
  level thread maps\mp\_utility::func_6F74(::challenges_notify_weapon_usage);
  level.zmb_on_any_trap_activated = ::hidden_challenges_on_trap_activated;
  lib_0565::zombiegearchallengeregister("hunter_blood_set", [::hunter_blood_0, ::hunter_blood_1, ::hunter_blood_2]);
  lib_0565::zombiegearchallengeregister("survivalist_blood_set", [::survivalist_blood_0_type_2, ::survivalist_blood_1_type_2, ::survivalist_blood_2_type_2]);
  lib_0565::zombiegearchallengeregister("assassin_blood_set", [::assassin_blood_0_type_2, ::assassin_blood_1_type_2, ::assassin_blood_2_type_2]);
  lib_0565::zombiegearchallengeregister("assassin_origin_set", [::slayer_origin_0_type_2, ::slayer_origin_1_type_2, ::slayer_origin_2_type_2]);
  lib_0565::zombiegearchallengeregister("survivalist_origin_set", [::survivalist_origin_0_type_2, ::survivalist_origin_1_type_2, ::survivalist_origin_2_type_2]);
  lib_0565::zombiegearchallengeregister("hunter_origin_set", [::hunter_origin_0_type_2, ::hunter_origin_1_type_2, ::hunter_origin_2_type_2]);
  lib_0565::zombiegearchallengeregister("mountain_man_origin_set", [::mountain_origin_0_type_2, ::mountain_origin_1_type_2, ::mountain_origin_2_type_2]);
  lib_0565::zombiegearchallengeregister("hunter_bat_set", [::hunter_bat_0_type_2, ::hunter_bat_1_type_2, ::hunter_bat_2_type_2]);
  lib_0565::zombiegearchallengeregister("mountain_man_bat_set", [::mountain_bat_0_type_2, ::mountain_bat_1_type_2, ::mountain_bat_2_type_2]);
  lib_0565::zombiegearchallengeregister("assassin_bat_set", [::slayer_bat_0_type_2, ::slayer_bat_1_type_2, ::slayer_bat_2_type_2]);
  lib_0565::zombiegearchallengeregister("survivalist_bat_set", [::survivalist_bat_0_type_2, ::survivalist_bat_1_type_2, ::survivalist_bat_2_type_2], "another_player_joined");
}

assassin_blood_0_type_2() {
  level endon("assassin_blood_0_type_2_failed");
  while(!isDefined(level.artillery_power_source_model)) {
    wait 0.05;
  }

  return 1;
}

assassin_blood_1_type_2() {
  level endon("artillery_miss");
  while(!isDefined(level.artillery_ee_ships)) {
    wait(10);
  }

  while(level.artillery_ee_ships.size) {
    level waittill("ship_sank");
  }

  return 1;
}

assassin_blood_2_type_2() {
  var_00 = 10;
  if(!isDefined(level.assassin_blood_2_type_2)) {
    level.assassin_blood_2_type_2 = 0;
  }

  while(level.assassin_blood_2_type_2 < var_00) {
    wait 0.05;
  }

  return 1;
}

hunter_blood_0() {
  level waittill("hunter_treasure_dlc1_0");
  return 1;
}

hunter_blood_1() {
  level waittill("hunter_treasure_dlc1_1");
  return 1;
}

hunter_blood_2() {
  level waittill("hunter_treasure_dlc1_2");
  return 1;
}

survivalist_blood_0_type_2() {
  level endon("survivalist_blood_0_type_2_failed");
  childthread watch_for_player_downs("survivalist_blood_0_type_2_failed", 0, ::boss_fight_active, "_25. SURVIVALIST BLOOD 1");
  common_scripts\utility::func_3C9F("final boss wrapped up");
  return 1;
}

survivalist_blood_1_type_2() {
  common_scripts\utility::func_3C9F("final boss wrapped up");
  return level.frontline_assassin_buff_count < 10;
}

survivalist_blood_2_type_2() {
  level endon("survivalist_blood_2_type_2_failed");
  common_scripts\utility::func_3C9F("final boss wrapped up");
  return 1;
}

slayer_bat_0_type_2() {
  var_00 = "slayer_bat_0_type_2";
  self waittill("magicBoxUse1", var_01);
  childthread wait_for_consecutive_waves_with_weapons(25, var_00, ::player_using_valid_weapons, [lib_0547::func_AAF9(var_01)], 0, 0, "_16. SLAYER BAT 1");
  level waittill(var_00);
  return 1;
}

slayer_bat_1_type_2() {
  var_00 = "slayer_bat_1_type_2";
  childthread wait_for_consecutive_waves_with_weapons(25, var_00, ::player_using_valid_weapons, ["g43_zm", "sten_zm", "breda30_zm"], 0, 0, "_17. SLAYER BAT 2");
  level waittill(var_00);
  return 1;
}

slayer_bat_2_type_2() {
  var_00 = "slayer_bat_2_type_2";
  childthread wait_for_consecutive_waves_with_weapons(5, var_00, ::player_using_valid_weapons, ["island_grenade_hc_zm"], 1, 0, "_18. SLAYER BAT 3");
  level waittill(var_00);
  return 1;
}

hunter_bat_0_type_2() {
  level endon("start_to_right_climb");
  level waittill(maps / mp / gametypes / zombies::get_round_complete_notify(25));
  return !common_scripts\utility::func_3C77("start_to_right_climb");
}

hunter_bat_1_type_2() {
  level endon("vista_beach_to_sub_pens_1");
  level endon("right_climb_to_sub_pens_1");
  level waittill(maps / mp / gametypes / zombies::get_round_complete_notify(20));
  return !common_scripts\utility::func_3C77("vista_beach_to_sub_pens_1") && !common_scripts\utility::func_3C77("right_climb_to_sub_pens_1");
}

hunter_bat_2_type_2() {
  level endon("hunter_bat_2_type_2_failure");
  childthread watch_player_sprint("hunter_bat_2_type_2_failure");
  level waittill(maps / mp / gametypes / zombies::get_round_complete_notify(20));
  return 1;
}

mountain_bat_0_type_2() {
  level endon("fireman_defeated");
  var_00 = "mountain_bat_0_type_2_success";
  childthread wait_for_consecutive_waves_in_event(5, var_00, ::is_in_subpens_battle, "_22. MOUNTAINEER BAT 1");
  level waittill(var_00);
  return 1;
}

mountain_bat_1_type_2() {
  level endon("fireman_defeated");
  if(!isDefined(level.mountain_bat_1_type_2)) {
    level.mountain_bat_1_type_2 = 0;
  }

  while(level.mountain_bat_1_type_2 < 100) {
    wait(0.5);
  }

  return 1;
}

mountain_bat_2_type_2() {
  level endon("fireman_defeated");
  if(!isDefined(level.mountain_bat_2_type_2)) {
    level.mountain_bat_2_type_2 = 0;
  }

  while(level.mountain_bat_2_type_2 < 10) {
    wait(0.5);
  }

  return 1;
}

survivalist_bat_0_type_2() {
  level endon("zmb_solo_hc_challenges_invalid");
  level endon("survivalist_bat_0_type_2_failed");
  level endon("another_player_joined0");
  level childthread fail_on_player_joined(self, "another_player_joined", 0);
  common_scripts\utility::func_3C9F(lib_0557::func_7838("Explore the Beach", "Survive the Beach"));
  wait(1);
  return level.players.size == 1;
}

survivalist_bat_1_type_2() {
  level endon("zmb_solo_hc_challenges_invalid");
  level endon("survivalist_bat_1_type_2_failed");
  level endon("another_player_joined1");
  level childthread fail_on_player_joined(self, "another_player_joined", 1);
  childthread wait_for_consecutive_waves_with_weapons(1, "survivalist_bat_1_type_2_failed", ::player_using_valid_weapons_no_mercy, ["shovel_zm"], 0, 1, "_14. SURVIVALIST BAT 2");
  common_scripts\utility::func_3C9F(lib_0557::func_7838("Explore the Beach", "Survive the Beach"));
  wait(1);
  return level.players.size == 1;
}

survivalist_bat_2_type_2() {
  level endon("zmb_solo_hc_challenges_invalid");
  level endon("survivalist_bat_2_type_2_failed");
  level endon("another_player_joined2");
  level childthread fail_on_player_joined(self, "another_player_joined", 2);
  childthread watch_for_crouch(2, "survivalist_bat_2_type_2_failed");
  common_scripts\utility::func_3C9F(lib_0557::func_7838("Explore the Beach", "Survive the Beach"));
  wait(1);
  return level.players.size == 1;
}

slayer_origin_0_type_2() {
  level endon("assassin_origin_0_type_2_failed");
  childthread watch_player_spending("assassin_origin_0_type_2_failed", 9000, " 4.SLAYER ORIGIN 1");
  common_scripts\utility::func_3C9F("final boss wrapped up");
  return 1;
}

slayer_origin_1_type_2() {
  level endon("assassin_origin_1_type_2_failed");
  childthread watch_player_spending("assassin_origin_1_type_2_failed", 7500, " 5.SLAYER ORIGIN 2");
  common_scripts\utility::func_3C9F("flag_pommel_given");
  return 1;
}

slayer_origin_2_type_2() {
  level endon("assassin_origin_2_type_2_failed");
  childthread watch_player_spending("assassin_origin_2_type_2_failed", 10000, " 6.SLAYER ORIGIN 3");
  level waittill(maps / mp / gametypes / zombies::get_round_complete_notify(40));
  return 1;
}

hunter_origin_0_type_2() {
  level endon(minute_get_notify_name(30));
  childthread wait_for_points_required(25000, "hunter_origin_0_type_2_success", " 7.HUNTER ORIGIN 1");
  level waittill("hunter_origin_0_type_2_success");
  return 1;
}

hunter_origin_1_type_2() {
  level endon(maps / mp / gametypes / zombies::get_round_complete_notify(14));
  childthread wait_for_points_required(30000, "hunter_origin_1_type_2_success", " 8.HUNTER ORIGIN 2");
  level waittill("hunter_origin_1_type_2_success");
  return 1;
}

hunter_origin_2_type_2() {
  common_scripts\utility::func_3C9F("final boss wrapped up");
  foreach(var_01 in level.players) {
    if(isDefined(var_01.var_62D6) && var_01.var_62D6 >= 15000) {
      return 1;
    }
  }

  return 0;
}

mountain_origin_0_type_2() {
  level endon("mountain_origin_0_type_2_failed");
  common_scripts\utility::func_3C9F("flag_pommel_given");
  return 1;
}

mountain_origin_1_type_2() {
  level endon("special_ability_used");
  common_scripts\utility::func_3C9F("flag_pommel_given");
  return 1;
}

mountain_origin_2_type_2() {
  level endon("zombie_took_projectile_damage_from_razergun_zm");
  level endon("zombie_took_projectile_damage_from_razergun_pap_zm");
  common_scripts\utility::func_3C9F("flag_pommel_given");
  return 1;
}

survivalist_origin_0_type_2() {
  level endon("survivalist_origin_0_type_2_failed");
  common_scripts\utility::func_3C9F("final boss wrapped up");
  return 1;
}

survivalist_origin_1_type_2() {
  if(!isDefined(level.survivalist_origin_1_type_2)) {
    level.survivalist_origin_1_type_2 = 0;
  }

  while(level.survivalist_origin_1_type_2 < 3) {
    wait(0.5);
  }

  return 1;
}

survivalist_origin_2_type_2() {
  var_00 = "survivalist_origin_2_type_2_success";
  childthread wait_for_consecutive_waves_with_weapons(5, var_00, ::player_using_valid_weapons, ["trap_zm_mp"], 1, 0, " 3.SURVIVALIST ORIGIN 3");
  level waittill(var_00);
  return 1;
}

fail_on_player_joined(param_00, param_01, param_02) {
  var_03 = undefined;
  while(!isDefined(var_03) || lib_0547::func_5565(var_03, param_00)) {
    level waittill("connected", var_03);
  }

  level notify(param_01 + param_02);
}

secret_challenges_get_zombie_killed_feedback(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(common_scripts\utility::func_562E(self.isminecartbomber) && param_03 != "MOD_SUICIDE") {
    if(valid_mine_cart_bomber_kill(param_06)) {
      level.assassin_blood_2_type_2++;
    } else {
      level.assassin_blood_2_type_2 = 0;
    }
  }

  if(common_scripts\utility::func_562E(level.zmb_lockdown_event_active) && common_scripts\utility::func_562E(level.maxed_zombies_sprint) && lib_0547::func_5565(param_04, "trap_zm_mp") && isDefined(param_00) && lib_0547::func_5565(param_00.script_noteworthy, "propeller_damage")) {
    level.mountain_bat_1_type_2++;
  }

  if(lib_0547::func_5565(param_04, "trap_zm_mp") && lib_0547::func_5565(self.var_A4B, "zombie_assassin")) {
    level.survivalist_origin_1_type_2++;
  }

  if(valid_fire_pit_headshot(param_01, param_06, param_03)) {
    level.mountain_bat_2_type_2++;
  }

  if(level.var_A980 == 0 && !lib_0586::func_AB31(param_06)) {
    level notify("survivalist_bat_0_type_2_failed");
  }

  challenge_validate_weapon_used(param_04, param_01);
}

minute_get_notify_name(param_00) {
  return "minute" + param_00;
}

minute_notifier() {
  var_00 = 0;
  for(;;) {
    wait(60);
    var_00++;
    var_01 = minute_get_notify_name(var_00);
    level notify(var_01);
  }
}

watch_for_player_downs(param_00, param_01, param_02, param_03) {
  self endon("disconnect");
  for(;;) {
    var_04 = self;
    if(param_01) {
      var_04 common_scripts\utility::waittill_any("enter_last_stand", "give_armor");
    } else {
      var_04 common_scripts\utility::waittill_any("enter_last_stand");
    }

    if(!isDefined(param_02) || [[param_02]]()) {
      level notify(param_00);
    }
  }
}

is_in_subpens_battle() {
  return common_scripts\utility::func_562E(level.zmb_lockdown_event_active) && common_scripts\utility::func_562E(self.participatinginevent);
}

singleplayer() {
  return level.players.size < 2;
}

valid_fire_pit_headshot(param_00, param_01, param_02) {
  if(!common_scripts\utility::func_562E(level.zmb_lockdown_event_active)) {
    return 0;
  }

  if(!common_scripts\utility::func_562E(level.maxed_zombies_sprint)) {
    return 0;
  }

  if(!isDefined(param_00)) {
    return 0;
  }

  if(!common_scripts\utility::func_562E(param_00.participatinginevent)) {
    return 0;
  }

  if(!lib_0586::func_AB31(param_01)) {
    return 0;
  }

  if(!lib_0547::func_5565(param_02, "MOD_RIFLE_BULLET")) {
    return 0;
  }

  return 1;
}

secret_challenges_get_player_damage_response(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(isDefined(param_01) && common_scripts\utility::func_562E(param_01.is_anointed)) {
    level notify("mountain_origin_0_type_2_failed");
  }
}

secret_challenges_get_zombie_damage_response(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(!isDefined(param_02)) {
    return;
  }

  if(lib_0547::func_5565(level.escort_bomber, param_00)) {
    level.assassin_blood_0_type_2_failed = 1;
    level notify("assassin_blood_0_type_2_failed");
  }

  level notify("zombie_took_damage_from_" + param_05);
  if(lib_0547::func_5565(param_04, "MOD_MELEE")) {
    level notify("zombie_took_melee_damage_from_" + param_05);
    return;
  }

  if(isDefined(param_01) && !lib_0547::func_5565(level.hc_pest, param_00)) {
    level notify("zombie_took_projectile_damage_from_" + param_05);
  }
}

challenge_validate_weapon_used(param_00, param_01, param_02) {
  foreach(var_04 in level.zmb_zombie_killed_responses) {
    if(common_scripts\utility::func_562E(param_02) && skip_equipment_check_on_wave_break(var_04)) {
      continue;
    }

    level thread[[var_04.weapon_check_func]](var_04.clear_player_progress_func, var_04.success_notification, var_04.valid_weapons, maps\mp\_utility::getbaseweaponname(param_00), param_01);
  }
}

skip_equipment_check_on_wave_break(param_00) {
  foreach(var_02 in param_00.valid_weapons) {
    if(lib_0547::func_585C(maps\mp\_utility::getbaseweaponname(var_02)) || lib_0547::func_5565(var_02, "trap_zm_mp")) {
      return 1;
    }
  }

  return 0;
}

watch_player_spending(param_00, param_01, param_02) {
  self.gamemoneyspent = 0;
  if(!isDefined(self.challengebudgets)) {
    self.challengebudgets = [];
  }

  self.challengebudgets[param_00] = spawnStruct();
  self.challengebudgets[param_00].budget = param_01;
  self.challengebudgets[param_00].challengeid = param_00;
  self.challengebudgets[param_00].name = param_02;
  while(!isDefined(self.gamemoneyspent) || self.gamemoneyspent <= self.challengebudgets[param_00].budget) {
    self waittill("money_update");
  }

  level notify(param_00);
}

wait_for_points_required(param_00, param_01, param_02) {
  while(!isDefined(self.var_62D6) || self.var_62D6 < param_00) {
    self waittill("money_update");
  }

  level notify(param_01);
}

valid_mine_cart_bomber_shot(param_00, param_01) {
  return lib_0547::func_5565(param_01, "head");
}

valid_mine_cart_bomber_kill(param_00) {
  return lib_0547::func_5565(param_00, "head");
}

challenges_notify_weapon_usage() {
  self endon("disconnect");
  for(;;) {
    self waittill("weapon_fired", var_00);
    level notify("players_fired_" + var_00);
    challenge_validate_weapon_used(var_00, self);
  }
}

solo_challenge_safety() {
  while(!isDefined(level.players)) {
    wait 0.05;
  }

  for(;;) {
    wait(1);
    if(level.players.size == 0) {
      continue;
    }

    if(level.players.size > 1) {
      level notify("zmb_solo_hc_challenges_invalid");
    }
  }
}

boss_fight_active() {
  return common_scripts\utility::func_562E(level.zmb_boss_fight_in_progress);
}

wait_for_consecutive_waves_with_weapons(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = self;
  if(!isDefined(var_07.consecutive_wave_tracking_array)) {
    var_07.consecutive_wave_tracking_array = [];
  }

  level endon(param_01);
  var_08 = register_zombie_killed_response(param_02, ::clear_player_progress, param_01, param_03);
  var_09 = spawnStruct();
  var_09.var_5C = 0;
  var_09.var_4800 = param_00;
  var_09.var_502A = param_01;
  var_09.var_7DB9 = var_08;
  var_09.var_2566 = 0;
  var_09.name = param_06;
  var_07.consecutive_wave_tracking_array[param_01] = var_09;
  while(var_07.consecutive_wave_tracking_array[param_01].var_5C < param_00) {
    level waittill("round complete");
    var_07.consecutive_wave_tracking_array[param_01].var_5C++;
    challenge_validate_weapon_used(var_07 getcurrentweapon(), var_07, 1);
  }

  var_09.var_2566 = 1;
  level.zmb_zombie_killed_responses[param_01].var_2566 = 1;
  level notify(param_01);
}

wait_for_consecutive_waves_in_event(param_00, param_01, param_02, param_03) {
  var_04 = self;
  if(!isDefined(var_04.event_attendance_array)) {
    var_04.event_attendance_array = [];
  }

  var_05 = spawnStruct();
  var_05.var_5C = 0;
  var_05.var_502A = param_01;
  var_05.player_validation_func = param_02;
  var_05.name = param_03;
  var_05.var_2566 = 0;
  var_05.var_4800 = param_00;
  var_04.event_attendance_array[param_01] = var_05;
  while(var_04.event_attendance_array[param_01].var_5C < param_00) {
    level waittill("round complete");
    if(!var_04[[var_04.event_attendance_array[param_01].player_validation_func]]()) {
      foreach(var_04 in level.players) {
        if(isDefined(var_04.event_attendance_array) && isDefined(var_04.event_attendance_array[param_01])) {
          var_04.event_attendance_array[param_01].var_5C = 0;
        }
      }

      continue;
    }

    var_04.event_attendance_array[param_01].var_5C++;
  }

  var_04.event_attendance_array[param_01].var_2566 = 1;
  level notify(param_01);
}

clear_player_progress(param_00) {
  foreach(var_02 in level.players) {
    if(isDefined(var_02.consecutive_wave_tracking_array[param_00])) {
      var_02.consecutive_wave_tracking_array[param_00].var_5C = 0;
    }
  }
}

player_using_valid_weapons(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(param_04) && isPlayer(param_04) && !isDefined(param_03) || !common_scripts\utility::func_F79(param_02, lib_0547::func_AAF9(param_03))) {
    level thread[[param_00]](param_01);
  }
}

player_using_valid_weapons_no_mercy(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(param_03)) {
    param_03 = lib_0547::func_9469(param_03);
  }

  if(isDefined(param_04) && isPlayer(param_04) && !isDefined(param_03) || !common_scripts\utility::func_F79(param_02, param_03)) {
    level notify(param_01);
  }
}

hidden_challenges_on_trap_activated() {
  level.survivalist_origin_0_type_2_failed = 1;
  level notify("survivalist_origin_0_type_2_failed");
  foreach(var_01 in level.players) {
    var_01.consecutive_wave_tracking_array["slayer_bat_2_type_2"].var_5C = 0;
  }
}

init_zombie_killed_responses() {
  level.zmb_zombie_killed_responses = [];
}

register_zombie_killed_response(param_00, param_01, param_02, param_03) {
  if(!isDefined(level.zmb_zombie_killed_responses)) {
    level.zmb_zombie_killed_responses = [];
  }

  if(isDefined(level.zmb_zombie_killed_responses[param_02])) {
    return;
  }

  foreach(var_05 in param_03) {
    var_06 = lib_0586::func_78B(var_05);
    if(isDefined(var_06)) {
      param_03 = common_scripts\utility::func_F6F(param_03, maps\mp\_utility::getbaseweaponname(var_06));
    }
  }

  var_08 = spawnStruct();
  var_08.weapon_check_func = param_00;
  var_08.clear_player_progress_func = param_01;
  var_08.success_notification = param_02;
  var_08.valid_weapons = param_03;
  level.zmb_zombie_killed_responses[param_02] = var_08;
  return var_08;
}

watch_player_sprint(param_00) {
  while(!self issprinting()) {
    wait 0.05;
  }

  level notify(param_00);
}

watch_for_crouch(param_00, param_01) {
  while(!level.var_3FA6) {
    wait 0.05;
  }

  wait(5);
  while(self getstance() == "crouch") {
    wait 0.05;
  }

  level notify(param_01);
}