/*********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zquests\dlc1_secrets_mp_zombie_island.gsc
*********************************************************************/

init_dlc1_secrets_mp_zombie_island() {
  level.zmb_hc_subpens_kills = 0;
  init_zombie_killed_responses();
  level thread minute_notifier();
  level thread solo_challenge_safety();
  level.frontline_assassin_buff_count = 0;
  level.callbackplayerdamagesecondaryhandling = ::secret_challenges_get_player_damage_response;
  level.callbackzombiesdamagesecondaryhandling = ::secret_challenges_get_zombie_damage_response;
  _id_0547::_id_7BA9(::secret_challenges_get_zombie_killed_feedback);
  level thread maps\mp\_utility::_id_6F74(::challenges_notify_weapon_usage);
  level.zmb_on_any_trap_activated = ::hidden_challenges_on_trap_activated;
  _id_0565::zombiegearchallengeregister("hunter_blood_set", [::hunter_blood_0, ::hunter_blood_1, ::hunter_blood_2]);
  _id_0565::zombiegearchallengeregister("survivalist_blood_set", [::survivalist_blood_0_type_2, ::survivalist_blood_1_type_2, ::survivalist_blood_2_type_2]);
  _id_0565::zombiegearchallengeregister("assassin_blood_set", [::assassin_blood_0_type_2, ::assassin_blood_1_type_2, ::assassin_blood_2_type_2]);
  _id_0565::zombiegearchallengeregister("assassin_origin_set", [::slayer_origin_0_type_2, ::slayer_origin_1_type_2, ::slayer_origin_2_type_2]);
  _id_0565::zombiegearchallengeregister("survivalist_origin_set", [::survivalist_origin_0_type_2, ::survivalist_origin_1_type_2, ::survivalist_origin_2_type_2]);
  _id_0565::zombiegearchallengeregister("hunter_origin_set", [::hunter_origin_0_type_2, ::hunter_origin_1_type_2, ::hunter_origin_2_type_2]);
  _id_0565::zombiegearchallengeregister("mountain_man_origin_set", [::mountain_origin_0_type_2, ::mountain_origin_1_type_2, ::mountain_origin_2_type_2]);
  _id_0565::zombiegearchallengeregister("hunter_bat_set", [::hunter_bat_0_type_2, ::hunter_bat_1_type_2, ::hunter_bat_2_type_2]);
  _id_0565::zombiegearchallengeregister("mountain_man_bat_set", [::mountain_bat_0_type_2, ::mountain_bat_1_type_2, ::mountain_bat_2_type_2]);
  _id_0565::zombiegearchallengeregister("assassin_bat_set", [::slayer_bat_0_type_2, ::slayer_bat_1_type_2, ::slayer_bat_2_type_2]);
  _id_0565::zombiegearchallengeregister("survivalist_bat_set", [::survivalist_bat_0_type_2, ::survivalist_bat_1_type_2, ::survivalist_bat_2_type_2], "another_player_joined");
}

assassin_blood_0_type_2() {
  level endon("assassin_blood_0_type_2_failed");

  while(!isDefined(level.artillery_power_source_model))
    waitframe();

  return 1;
}

assassin_blood_1_type_2() {
  level endon("artillery_miss");

  while(!isDefined(level.artillery_ee_ships))
    wait 10;

  while(level.artillery_ee_ships.size)
    level waittill("ship_sank");

  return 1;
}

assassin_blood_2_type_2() {
  var_0 = 10;

  if(!isDefined(level.assassin_blood_2_type_2))
    level.assassin_blood_2_type_2 = 0;

  while(level.assassin_blood_2_type_2 < var_0)
    waitframe();

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
  common_scripts\utility::_id_3C9F("final boss wrapped up");
  return 1;
}

survivalist_blood_1_type_2() {
  common_scripts\utility::_id_3C9F("final boss wrapped up");
  return level.frontline_assassin_buff_count < 10;
}

survivalist_blood_2_type_2() {
  level endon("survivalist_blood_2_type_2_failed");
  common_scripts\utility::_id_3C9F("final boss wrapped up");
  return 1;
}

slayer_bat_0_type_2() {
  var_0 = "slayer_bat_0_type_2";
  self waittill("magicBoxUse1", var_1);
  childthread wait_for_consecutive_waves_with_weapons(25, var_0, ::player_using_valid_weapons, [_id_0547::_id_AAF9(var_1)], 0, 0, "_16. SLAYER BAT 1");
  level waittill(var_0);
  return 1;
}

slayer_bat_1_type_2() {
  var_0 = "slayer_bat_1_type_2";
  childthread wait_for_consecutive_waves_with_weapons(25, var_0, ::player_using_valid_weapons, ["g43_zm", "sten_zm", "breda30_zm"], 0, 0, "_17. SLAYER BAT 2");
  level waittill(var_0);
  return 1;
}

slayer_bat_2_type_2() {
  var_0 = "slayer_bat_2_type_2";
  childthread wait_for_consecutive_waves_with_weapons(5, var_0, ::player_using_valid_weapons, ["island_grenade_hc_zm"], 1, 0, "_18. SLAYER BAT 3");
  level waittill(var_0);
  return 1;
}

hunter_bat_0_type_2() {
  level endon("start_to_right_climb");
  level waittill(maps\mp\gametypes\zombies::get_round_complete_notify(25));
  return !common_scripts\utility::_id_3C77("start_to_right_climb");
}

hunter_bat_1_type_2() {
  level endon("vista_beach_to_sub_pens_1");
  level endon("right_climb_to_sub_pens_1");
  level waittill(maps\mp\gametypes\zombies::get_round_complete_notify(20));
  return !common_scripts\utility::_id_3C77("vista_beach_to_sub_pens_1") && !common_scripts\utility::_id_3C77("right_climb_to_sub_pens_1");
}

hunter_bat_2_type_2() {
  level endon("hunter_bat_2_type_2_failure");
  childthread watch_player_sprint("hunter_bat_2_type_2_failure");
  level waittill(maps\mp\gametypes\zombies::get_round_complete_notify(20));
  return 1;
}

mountain_bat_0_type_2() {
  level endon("fireman_defeated");
  var_0 = "mountain_bat_0_type_2_success";
  childthread wait_for_consecutive_waves_in_event(5, var_0, ::is_in_subpens_battle, "_22. MOUNTAINEER BAT 1");
  level waittill(var_0);
  return 1;
}

mountain_bat_1_type_2() {
  level endon("fireman_defeated");

  if(!isDefined(level.mountain_bat_1_type_2))
    level.mountain_bat_1_type_2 = 0;

  while(level.mountain_bat_1_type_2 < 100)
    wait 0.5;

  return 1;
}

mountain_bat_2_type_2() {
  level endon("fireman_defeated");

  if(!isDefined(level.mountain_bat_2_type_2))
    level.mountain_bat_2_type_2 = 0;

  while(level.mountain_bat_2_type_2 < 10)
    wait 0.5;

  return 1;
}

survivalist_bat_0_type_2() {
  level endon("zmb_solo_hc_challenges_invalid");
  level endon("survivalist_bat_0_type_2_failed");
  level endon("another_player_joined0");
  level childthread fail_on_player_joined(self, "another_player_joined", 0);
  common_scripts\utility::_id_3C9F(_id_0557::_id_7838("Explore the Beach", "Survive the Beach"));
  wait 1;
  return level.players.size == 1;
}

survivalist_bat_1_type_2() {
  level endon("zmb_solo_hc_challenges_invalid");
  level endon("survivalist_bat_1_type_2_failed");
  level endon("another_player_joined1");
  level childthread fail_on_player_joined(self, "another_player_joined", 1);
  childthread wait_for_consecutive_waves_with_weapons(1, "survivalist_bat_1_type_2_failed", ::player_using_valid_weapons_no_mercy, ["shovel_zm"], 0, 1, "_14. SURVIVALIST BAT 2");
  common_scripts\utility::_id_3C9F(_id_0557::_id_7838("Explore the Beach", "Survive the Beach"));
  wait 1;
  return level.players.size == 1;
}

survivalist_bat_2_type_2() {
  level endon("zmb_solo_hc_challenges_invalid");
  level endon("survivalist_bat_2_type_2_failed");
  level endon("another_player_joined2");
  level childthread fail_on_player_joined(self, "another_player_joined", 2);
  childthread watch_for_crouch(2, "survivalist_bat_2_type_2_failed");
  common_scripts\utility::_id_3C9F(_id_0557::_id_7838("Explore the Beach", "Survive the Beach"));
  wait 1;
  return level.players.size == 1;
}

slayer_origin_0_type_2() {
  level endon("assassin_origin_0_type_2_failed");
  childthread watch_player_spending("assassin_origin_0_type_2_failed", 9000, " 4.SLAYER ORIGIN 1");
  common_scripts\utility::_id_3C9F("final boss wrapped up");
  return 1;
}

slayer_origin_1_type_2() {
  level endon("assassin_origin_1_type_2_failed");
  childthread watch_player_spending("assassin_origin_1_type_2_failed", 7500, " 5.SLAYER ORIGIN 2");
  common_scripts\utility::_id_3C9F("flag_pommel_given");
  return 1;
}

slayer_origin_2_type_2() {
  level endon("assassin_origin_2_type_2_failed");
  childthread watch_player_spending("assassin_origin_2_type_2_failed", 10000, " 6.SLAYER ORIGIN 3");
  level waittill(maps\mp\gametypes\zombies::get_round_complete_notify(40));
  return 1;
}

hunter_origin_0_type_2() {
  level endon(minute_get_notify_name(30));
  childthread wait_for_points_required(25000, "hunter_origin_0_type_2_success", " 7.HUNTER ORIGIN 1");
  level waittill("hunter_origin_0_type_2_success");
  return 1;
}

hunter_origin_1_type_2() {
  level endon(maps\mp\gametypes\zombies::get_round_complete_notify(14));
  childthread wait_for_points_required(30000, "hunter_origin_1_type_2_success", " 8.HUNTER ORIGIN 2");
  level waittill("hunter_origin_1_type_2_success");
  return 1;
}

hunter_origin_2_type_2() {
  common_scripts\utility::_id_3C9F("final boss wrapped up");

  foreach(var_1 in level.players) {
    if(isDefined(var_1._id_62D6) && var_1._id_62D6 >= 15000)
      return 1;
  }

  return 0;
}

mountain_origin_0_type_2() {
  level endon("mountain_origin_0_type_2_failed");
  common_scripts\utility::_id_3C9F("flag_pommel_given");
  return 1;
}

mountain_origin_1_type_2() {
  level endon("special_ability_used");
  common_scripts\utility::_id_3C9F("flag_pommel_given");
  return 1;
}

mountain_origin_2_type_2() {
  level endon("zombie_took_projectile_damage_from_razergun_zm");
  level endon("zombie_took_projectile_damage_from_razergun_pap_zm");
  common_scripts\utility::_id_3C9F("flag_pommel_given");
  return 1;
}

survivalist_origin_0_type_2() {
  level endon("survivalist_origin_0_type_2_failed");
  common_scripts\utility::_id_3C9F("final boss wrapped up");
  return 1;
}

survivalist_origin_1_type_2() {
  if(!isDefined(level.survivalist_origin_1_type_2))
    level.survivalist_origin_1_type_2 = 0;

  while(level.survivalist_origin_1_type_2 < 3)
    wait 0.5;

  return 1;
}

survivalist_origin_2_type_2() {
  var_0 = "survivalist_origin_2_type_2_success";
  childthread wait_for_consecutive_waves_with_weapons(5, var_0, ::player_using_valid_weapons, ["trap_zm_mp"], 1, 0, " 3.SURVIVALIST ORIGIN 3");
  level waittill(var_0);
  return 1;
}

fail_on_player_joined(var_0, var_1, var_2) {
  var_3 = undefined;

  while(!isDefined(var_3) || _id_0547::_id_5565(var_3, var_0))
    level waittill("connected", var_3);

  level notify(var_1 + var_2);
}

secret_challenges_get_zombie_killed_feedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(common_scripts\utility::_id_562E(self.isminecartbomber) && var_3 != "MOD_SUICIDE") {
    if(valid_mine_cart_bomber_kill(var_6))
      level.assassin_blood_2_type_2++;
    else
      level.assassin_blood_2_type_2 = 0;
  }

  if(common_scripts\utility::_id_562E(level.zmb_lockdown_event_active) && common_scripts\utility::_id_562E(level.maxed_zombies_sprint) && _id_0547::_id_5565(var_4, "trap_zm_mp") && isDefined(var_0) && _id_0547::_id_5565(var_0._id_0165, "propeller_damage"))
    level.mountain_bat_1_type_2++;

  if(_id_0547::_id_5565(var_4, "trap_zm_mp") && _id_0547::_id_5565(self._id_0A4B, "zombie_assassin"))
    level.survivalist_origin_1_type_2++;

  if(valid_fire_pit_headshot(var_1, var_6, var_3))
    level.mountain_bat_2_type_2++;

  if(level._id_A980 == 0 && !_id_0586::_id_AB31(var_6))
    level notify("survivalist_bat_0_type_2_failed");

  challenge_validate_weapon_used(var_4, var_1);
}

minute_get_notify_name(var_0) {
  return "minute" + var_0;
}

minute_notifier() {
  var_0 = 0;

  for(;;) {
    wait 60;
    var_0++;
    var_1 = minute_get_notify_name(var_0);
    level notify(var_1);
  }
}

watch_for_player_downs(var_0, var_1, var_2, var_3) {
  self endon("disconnect");

  for(;;) {
    var_4 = self;

    if(var_1)
      var_4 common_scripts\utility::_id_A70A("enter_last_stand", "give_armor");
    else
      var_4 common_scripts\utility::_id_A70A("enter_last_stand");

    if(!isDefined(var_2) || [[var_2]]())
      level notify(var_0);
  }
}

is_in_subpens_battle() {
  return common_scripts\utility::_id_562E(level.zmb_lockdown_event_active) && common_scripts\utility::_id_562E(self.participatinginevent);
}

singleplayer() {
  return level.players.size < 2;
}

valid_fire_pit_headshot(var_0, var_1, var_2) {
  if(!common_scripts\utility::_id_562E(level.zmb_lockdown_event_active))
    return 0;

  if(!common_scripts\utility::_id_562E(level.maxed_zombies_sprint))
    return 0;

  if(!isDefined(var_0))
    return 0;

  if(!common_scripts\utility::_id_562E(var_0.participatinginevent))
    return 0;

  if(!_id_0586::_id_AB31(var_1))
    return 0;

  if(!_id_0547::_id_5565(var_2, "MOD_RIFLE_BULLET"))
    return 0;

  return 1;
}

secret_challenges_get_player_damage_response(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && common_scripts\utility::_id_562E(var_1.is_anointed))
    level notify("mountain_origin_0_type_2_failed");
}

secret_challenges_get_zombie_damage_response(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_2)) {
    return;
  }
  if(_id_0547::_id_5565(level.escort_bomber, var_0)) {
    level.assassin_blood_0_type_2_failed = 1;
    level notify("assassin_blood_0_type_2_failed");
  }

  level notify("zombie_took_damage_from_" + var_5);

  if(_id_0547::_id_5565(var_4, "MOD_MELEE"))
    level notify("zombie_took_melee_damage_from_" + var_5);
  else if(isDefined(var_1) && !_id_0547::_id_5565(level.hc_pest, var_0))
    level notify("zombie_took_projectile_damage_from_" + var_5);
}

challenge_validate_weapon_used(var_0, var_1, var_2) {
  foreach(var_4 in level.zmb_zombie_killed_responses) {
    if(common_scripts\utility::_id_562E(var_2) && skip_equipment_check_on_wave_break(var_4)) {
      continue;
    }
    level thread[[var_4.weapon_check_func]](var_4.clear_player_progress_func, var_4.success_notification, var_4.valid_weapons, maps\mp\_utility::_id_4431(var_0), var_1);
  }
}

skip_equipment_check_on_wave_break(var_0) {
  foreach(var_2 in var_0.valid_weapons) {
    if(_id_0547::_id_585C(maps\mp\_utility::_id_4431(var_2)) || _id_0547::_id_5565(var_2, "trap_zm_mp"))
      return 1;
  }

  return 0;
}

watch_player_spending(var_0, var_1, var_2) {
  self.gamemoneyspent = 0;

  if(!isDefined(self.challengebudgets))
    self.challengebudgets = [];

  self.challengebudgets[var_0] = spawnStruct();
  self.challengebudgets[var_0].budget = var_1;
  self.challengebudgets[var_0].challengeid = var_0;
  self.challengebudgets[var_0].name = var_2;

  while(!isDefined(self.gamemoneyspent) || self.gamemoneyspent <= self.challengebudgets[var_0].budget)
    self waittill("money_update");

  level notify(var_0);
}

wait_for_points_required(var_0, var_1, var_2) {
  while(!isDefined(self._id_62D6) || self._id_62D6 < var_0)
    self waittill("money_update");

  level notify(var_1);
}

valid_mine_cart_bomber_shot(var_0, var_1) {
  return _id_0547::_id_5565(var_1, "head");
}

valid_mine_cart_bomber_kill(var_0) {
  return _id_0547::_id_5565(var_0, "head");
}

challenges_notify_weapon_usage() {
  self endon("disconnect");

  for(;;) {
    self waittill("weapon_fired", var_0);
    level notify("players_fired_" + var_0);
    challenge_validate_weapon_used(var_0, self);
  }
}

solo_challenge_safety() {
  while(!isDefined(level.players))
    waitframe();

  for(;;) {
    wait 1;

    if(level.players.size == 0) {
      continue;
    }
    if(level.players.size > 1)
      level notify("zmb_solo_hc_challenges_invalid");
  }
}

boss_fight_active() {
  return common_scripts\utility::_id_562E(level.zmb_boss_fight_in_progress);
}

wait_for_consecutive_waves_with_weapons(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = self;

  if(!isDefined(var_7.consecutive_wave_tracking_array))
    var_7.consecutive_wave_tracking_array = [];

  level endon(var_1);
  var_8 = register_zombie_killed_response(var_2, ::clear_player_progress, var_1, var_3);
  var_9 = spawnStruct();
  var_9._id_005C = 0;
  var_9._id_4800 = var_0;
  var_9._id_502A = var_1;
  var_9._id_7DB9 = var_8;
  var_9._id_2566 = 0;
  var_9.name = var_6;
  var_7.consecutive_wave_tracking_array[var_1] = var_9;

  while(var_7.consecutive_wave_tracking_array[var_1]._id_005C < var_0) {
    level waittill("round complete");
    var_7.consecutive_wave_tracking_array[var_1]._id_005C++;
    challenge_validate_weapon_used(var_7 getcurrentweapon(), var_7, 1);
  }

  var_9._id_2566 = 1;
  level.zmb_zombie_killed_responses[var_1]._id_2566 = 1;
  level notify(var_1);
}

wait_for_consecutive_waves_in_event(var_0, var_1, var_2, var_3) {
  var_4 = self;

  if(!isDefined(var_4.event_attendance_array))
    var_4.event_attendance_array = [];

  var_5 = spawnStruct();
  var_5._id_005C = 0;
  var_5._id_502A = var_1;
  var_5.player_validation_func = var_2;
  var_5.name = var_3;
  var_5._id_2566 = 0;
  var_5._id_4800 = var_0;
  var_4.event_attendance_array[var_1] = var_5;

  while(var_4.event_attendance_array[var_1]._id_005C < var_0) {
    level waittill("round complete");

    if(!var_4[[var_4.event_attendance_array[var_1].player_validation_func]]()) {
      foreach(var_4 in level.players) {
        if(isDefined(var_4.event_attendance_array) && isDefined(var_4.event_attendance_array[var_1]))
          var_4.event_attendance_array[var_1]._id_005C = 0;
      }

      continue;
    }

    var_4.event_attendance_array[var_1]._id_005C++;
  }

  var_4.event_attendance_array[var_1]._id_2566 = 1;
  level notify(var_1);
}

clear_player_progress(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2.consecutive_wave_tracking_array[var_0]))
      var_2.consecutive_wave_tracking_array[var_0]._id_005C = 0;
  }
}

player_using_valid_weapons(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4) && isPlayer(var_4) && (!isDefined(var_3) || !common_scripts\utility::_id_0F79(var_2, _id_0547::_id_AAF9(var_3))))
    level thread[[var_0]](var_1);
}

player_using_valid_weapons_no_mercy(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3))
    var_3 = _id_0547::_id_9469(var_3);

  if(isDefined(var_4) && isPlayer(var_4) && (!isDefined(var_3) || !common_scripts\utility::_id_0F79(var_2, var_3)))
    level notify(var_1);
}

hidden_challenges_on_trap_activated() {
  level.survivalist_origin_0_type_2_failed = 1;
  level notify("survivalist_origin_0_type_2_failed");

  foreach(var_1 in level.players)
  var_1.consecutive_wave_tracking_array["slayer_bat_2_type_2"]._id_005C = 0;
}

init_zombie_killed_responses() {
  level.zmb_zombie_killed_responses = [];
}

register_zombie_killed_response(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.zmb_zombie_killed_responses))
    level.zmb_zombie_killed_responses = [];

  if(isDefined(level.zmb_zombie_killed_responses[var_2])) {
    return;
  }
  foreach(var_5 in var_3) {
    var_6 = _id_0586::_id_078B(var_5);

    if(isDefined(var_6))
      var_3 = common_scripts\utility::_id_0F6F(var_3, maps\mp\_utility::_id_4431(var_6));
  }

  var_8 = spawnStruct();
  var_8.weapon_check_func = var_0;
  var_8.clear_player_progress_func = var_1;
  var_8.success_notification = var_2;
  var_8.valid_weapons = var_3;
  level.zmb_zombie_killed_responses[var_2] = var_8;
  return var_8;
}

watch_player_sprint(var_0) {
  while(!self issprinting())
    waitframe();

  level notify(var_0);
}

watch_for_crouch(var_0, var_1) {
  while(!level.gamehasstarted)
    waitframe();

  wait 5;

  while(self getstance() == "crouch")
    waitframe();

  level notify(var_1);
}