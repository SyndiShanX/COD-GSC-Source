/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_descent_ee_main.gsc
*************************************************/

func_00D5() {
  var_00 = common_scripts\utility::func_46B7("zone_lost_spawners_death", "targetname");
  foreach(var_02 in var_00) {
    var_02.var_8C95 = 1;
  }

  level.shouldignoreplayerzombiecallback = ::zombies_trials_should_ignore_player;
  level.extra_upgrade_func = ::add_pap_time;
  init_blood_lock_quest();
  init_deathraven_quest();
  init_moonraven_quest();
  init_boss_fight_quest();
  lib_0557::func_7846("quest_firstdoor", ::lib_0557::func_30D8, [], lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_firstdoor", "quest_firstdoor_bloodpool", ::quest_step_blood_lock, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_7848("quest_firstdoor");
  lib_0557::func_7846("quest_pap", ::lib_0557::func_30D8, [], lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_pap", "quest_pap_1", ::quest_step_unlock_pap, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_7848("quest_pap");
  lib_0557::func_7846("quest_bloodraven", ::lib_0557::func_30D8, [], lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_bloodraven", "quest_bloodraven_drain_fill", ::quest_step_bloodraven_fill_drains, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_bloodraven", "quest_bloodraven_acquire_sheild", ::quest_step_bloodraven_aquire_sheild, ::descent_give_small_reward, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_bloodraven", "quest_bloodraven_acquire_code", ::quest_step_bloodraven_reveal_code, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_bloodraven", "quest_bloodraven_radio_find", ::quest_step_bloodraven_acquire_radio, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_bloodraven", "quest_bloodraven_enter_code", ::quest_step_bloodraven_enter_code, ::descent_give_mid_reward, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_bloodraven", "quest_bloodraven_enter_trial", ::quest_step_bloodraven_enter_trial, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_bloodraven", "quest_bloodraven_complete_trial", ::quest_step_bloodraven_complete_trial, ::descent_give_large_reward, lib_0557::removed_quest_hint());
  lib_0557::func_7848("quest_bloodraven");
  init_quest_step_bloodraven_reveal_code();
  lib_0557::func_7846("quest_deathraven", ::lib_0557::func_30D8, [], lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_deathraven", "quest_deathraven_activate_rush", ::quest_step_deathraven_push_stone, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_deathraven", "quest_deathraven_survive_rush", ::quest_step_deathraven_survive_rush, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_deathraven", "quest_deathraven_pickup_weap", ::quest_step_deathraven_pickup_weapon, ::descent_give_small_reward, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_deathraven", "quest_deathraven_acquire_weapon", ::quest_step_deathraven_acquire_spine, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_deathraven", "quest_deathraven_assemble_weap", ::quest_step_deathraven_assemble_weapon, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_deathraven", "quest_deathraven_fuse_weap", ::quest_step_deathraven_fuse, ::descent_give_mid_reward, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_deathraven", "quest_deathraven_transport_weap", ::quest_step_deathraven_transport, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_deathraven", "quest_deathraven_enter_trial", ::quest_step_deathraven_enter_trial, ::descent_give_mid_reward, lib_0557::removed_quest_hint());
  lib_0557::func_7848("quest_deathraven");
  lib_0557::func_7846("quest_moonraven", ::lib_0557::func_30D8, [], lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_moonraven", "quest_moonraven_reveal_chart", ::quest_step_moonraven_chart, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_moonraven", "quest_moonraven_fix_machine", ::quest_step_moonraven_machine, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_moonraven", "quest_moonraven_power_orrery", ::quest_step_moonraven_orrery_power, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_moonraven", "quest_moonraven_acquire_scepter", ::quest_step_moonraven_acquire_weapon, ::descent_give_mid_reward, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_moonraven", "quest_moonraven_scan", ::quest_step_moonraven_scan, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_moonraven", "quest_moonraven_alcove", ::quest_step_moonraven_alcove, ::descent_give_mid_reward, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_moonraven", "quest_moonraven_unlock_trial", ::quest_step_moonraven_unlock_trial, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_moonraven", "quest_moonraven_enter_trial", ::quest_step_moonraven_enter_trial, ::descent_give_large_reward, lib_0557::removed_quest_hint());
  lib_0557::func_7848("quest_moonraven");
  lib_0557::func_7846("quest_stormraven", ::lib_0557::func_30D8, [], lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_stormraven", "step_stormraven_chase_hammer", ::stormraven_summon_hammer_main, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_stormraven", "step_stormraven_capture_hammer", ::stormraven_capture_hammer_main, ::descent_give_small_reward, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_stormraven", "step_stormraven_call_lightning", ::stormraven_call_lightning_main, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_stormraven", "step_stormraven_charge_puzzle", ::stormraven_charge_puzzle_main, ::descent_give_mid_reward, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_stormraven", "step_stormraven_trial", ::stormraven_find_trial_main, ::descent_give_large_reward, lib_0557::removed_quest_hint());
  lib_0557::func_7848("quest_stormraven");
  stormraven_init_quest();
  register_a_raven_trial("zom_dlc4_scythe_zm", "scythe_emp", ::run_deathraven_trial, ::deathraven_hitch_a_ride_back);
  register_a_raven_trial("zom_dlc4_hammer_zm", "hammer_emp", ::run_stormraven_trial, ::stormraven_trial_teleport_from_trial);
  register_a_raven_trial("zom_dlc4_spike_zm", "spike_emp", ::run_moonraven_trial, ::moonraven_trial_teleport_from_trial);
  register_a_raven_trial("zom_dlc4_shield_zm", "shield_emp", ::run_bloodraven_trial, ::bloodraven_exit_from_trial);
  register_a_raven_trial("zom_pap_trial_destination", undefined, ::run_pack_a_punch_visit, ::deathraven_hitch_a_ride_back);
  register_a_raven_trial("zom_bonus_trial_destination", undefined, ::maps\mp\mp_zombie_descent_ee_side::run_sewers_visit, ::maps\mp\mp_zombie_descent_ee_side::sewers_hitch_a_ride_back);
  register_a_raven_trial("zom_shelf_trial_destination", undefined, ::maps\mp\mp_zombie_descent_ee_side::run_shelf_visit, ::maps\mp\mp_zombie_descent_ee_side::sewers_shelf_force_orb_teleport_return);
  lib_0547::func_7BD0("ce_taunt", ::ce_taunt, ::ce_taunt_interrupt, 104);
  var_04 = getEntArray("raven_trial_fall_trigger", "targetname");
  foreach(var_06 in var_04) {
    var_06 thread raven_trial_teleport_on_fall();
  }

  lib_0557::func_7846("quest_bossfight", ::lib_0557::func_30D8, [], lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_bossfight", "quest_bossfight_open", ::quest_step_boss_open, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_bossfight", "quest_bossfight_start", ::get_available_players, ::descent_completion_rewards, lib_0557::removed_quest_hint());
  lib_0557::func_7848("quest_bossfight");
}

descent_completion_rewards() {
  lib_0547::markmapcompleteforleaderboards();
  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("mp_zombie_berlin_final_boss");
  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("any_boss_completed");
  lib_054D::giveplayersexp("dlc4_exp_ref_1");
  maps\mp\zquests\dlc4_trophies_mp_zombie_descent::complete_descent_trophy_event_10();
  level.var_400E[level.var_400E.size] = ["wicht_set 4 1", "all"];
}

descent_give_small_reward() {
  lib_054D::giveplayersexp("dlc4_exp_ref_2");
}

descent_give_mid_reward() {
  lib_054D::giveplayersexp("dlc4_exp_ref_3");
}

descent_give_large_reward() {
  lib_054D::giveplayersexp("dlc4_exp_ref_4");
}

quest_step_unlock_pap() {
  var_00 = getent("zmb_pack_a_punch_descent", "targetname");
  var_00.destination_origin = var_00.var_116;
  var_01 = var_00 common_scripts\utility::func_8FFC();
  var_01 method_805B();
  var_02 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_pack_a_punch_blood_reveal"), var_00, "lathe_01");
  triggerfx(var_02);
  var_03 = common_scripts\utility::func_46B5(var_00.var_1A2, "targetname");
  var_00.var_116 = var_03.var_116;
  var_00.var_6C4E = var_00.var_116;
  common_scripts\utility::func_3C87("pap_raise_1");
  common_scripts\utility::func_3C87("pap_raise_2");
  common_scripts\utility::func_3C87("pap_raise_3");
  common_scripts\utility::func_3C9F("pap_raise_1");
  triggerfx(var_02);
  var_00 move_to_position(1);
  common_scripts\utility::func_3C9F("pap_raise_2");
  var_00 move_to_position(2);
  common_scripts\utility::func_3C9F("pap_raise_3");
  var_00 move_to_position(3);
  level notify("aud_pap_machine_blood_lp_starts");
  common_scripts\utility::func_3C8F("flag_descent_pap");
  var_00 method_8511();
  lib_0557::func_782D("quest_pap", "quest_pap_1");
}

raise_machine_to_unlock_pack_a_punch() {
  var_00 = getent("pack_a_punch_weapon_display", "targetname");
  var_00 method_8511();
  var_01 = function_021F("zmb_upgrade_machine", "targetname");
  foreach(var_03 in var_01) {
    var_03 method_805C();
  }

  common_scripts\utility::func_3C87("flag_descent_pap");
  common_scripts\utility::func_3C9F("flag_descent_pap");
}

move_to_position(param_00) {
  var_01 = 0.8;
  var_02 = self.destination_origin;
  var_03 = self.var_6C4E;
  lib_0378::func_8D74("aud_pap_rise");
  self moveto(vectorlerp(var_03, var_02, param_00 / 3), var_01, var_01 / 4, var_01 / 4);
  wait(var_01);
}

register_a_raven_trial(param_00, param_01, param_02, param_03) {
  if(!isDefined(level.raven_weapon_upgrade_trials)) {
    level.raven_weapon_upgrade_trials = [];
  }

  if(!isDefined(level.raven_trials_completed)) {
    level.raven_trials_completed = 0;
  }

  var_04 = spawnStruct();
  var_04.var_116 = common_scripts\utility::func_46B5(param_00, "script_noteworthy").var_116;
  var_04.var_502A = param_00;
  var_04.weap_upgrade = param_01;
  if(isDefined(var_04.weap_upgrade)) {
    var_04.weap = function_0337(var_04.weap_upgrade, "_emp");
  }

  var_04.var_3F02 = param_02;
  var_04.return_func = param_03;
  var_05 = common_scripts\utility::func_46B7("zmb_trials_dest", "targetname");
  foreach(var_07 in var_05) {
    if(var_07.var_165 == param_00) {
      var_04.weapon_spawn = var_07;
    }
  }

  level.raven_weapon_upgrade_trials[var_04.var_502A] = var_04;
}

raven_trial_teleport_on_fall() {
  for(;;) {
    self waittill("trigger", var_00);
    if(isPlayer(var_00) && isalive(var_00)) {
      var_00 setorigin(common_scripts\utility::func_46B5(self.var_1A2, "targetname").var_116);
      var_00 thread raven_trial_fall_damage();
    }
  }
}

raven_trial_fall_damage() {
  while(!self isonground()) {
    wait 0.05;
  }

  down_player();
}

down_player() {
  lib_0547::func_73AC(3);
  lib_0547::func_7442(3);
  self dodamage(self.var_BC, self.var_116);
}

zombies_trials_should_ignore_player(param_00, param_01) {
  if(!isDefined(param_00.isintrial) && !isDefined(param_01.isintrial)) {
    return 0;
  }

  if(lib_0547::func_5565(param_00.isintrial, param_01.isintrial)) {
    return 0;
  }

  if(!isDefined(param_01.isintrial) && isDefined(param_00.isintrial) && !lib_0547::func_5565(param_00.isintrial, "quest_deathraven")) {
    return 1;
  }

  if(!param_01 is_there_another_player_in_trial(param_00)) {
    return 0;
  }

  return 1;
}

is_there_another_player_in_trial(param_00) {
  var_01 = self;
  if(isDefined(var_01.isintrial)) {
    foreach(var_03 in level.var_744A) {
      if(param_00 == var_03) {
        continue;
      }

      if(lib_0547::func_5565(var_01.isintrial, var_03.isintrial)) {
        var_04 = 1;
        return 1;
      }
    }
  }

  return 0;
}

someone_at_deathraven_event() {
  foreach(var_01 in level.var_744A) {
    if(common_scripts\utility::func_562E(var_01.isindeathravenevent)) {
      return 1;
    }
  }

  return 0;
}

someone_at_stormraven_event() {
  foreach(var_01 in level.var_744A) {
    if(common_scripts\utility::func_562E(var_01.isinstormravenevent)) {
      return 1;
    }
  }

  return 0;
}

quest_step_blood_lock() {
  level thread reveal_first_door();
}

reveal_first_door() {
  thread deactivate_first_door_trigs();
  level.blood_plates["first_door"] wait_for_door_objective_complete();
  level.blood_plates["first_door"] thread first_door_adjust_max();
  maps\mp\mp_zombie_descent_utils::reveal_first_room_door();
  lib_0557::func_782D("quest_firstdoor", "quest_firstdoor_bloodpool");
}

first_door_adjust_max() {
  wait(1);
  maps\mp\mp_zombie_descent::blood_plate_empty_first_door();
}

deactivate_first_door_trigs() {
  while(!isDefined(lib_053F::func_44A6("flag_limbo_to_cave_intro"))) {
    wait(1);
  }

  var_00 = lib_053F::func_44A6("flag_limbo_to_cave_intro");
  while(!isDefined(var_00.var_9DC2)) {
    wait 0.05;
  }

  foreach(var_02 in var_00.var_9DC2) {
    var_02 common_scripts\utility::func_9D9F();
  }
}

wait_for_door_objective_complete() {
  self waittill("blood_plate_full");
}

__________________bloodraven__________________() {}

init_blood_lock_quest() {
  level.zmb_possible_blood_code_values = [1, 3, 5, 7, 8, 9, 11];
  blood_plate_init();
  common_scripts\utility::func_3C87("stopper_in_place");
  common_scripts\utility::func_3C87("limbo_debris_exploded");
  common_scripts\utility::func_3C87("stopper_collected");
  var_00 = common_scripts\utility::func_46B7("struct_blooddrain_main", "targetname");
  foreach(var_03, var_02 in var_00) {
    var_02.var_819A = "blood_collect_" + var_03;
    common_scripts\utility::func_3C87(var_02.var_819A);
  }
}

blood_plate_init() {
  var_00 = common_scripts\utility::func_46B7("blood_plate_struct", "targetname");
  var_01 = getEntArray("blood_plate_pool", "targetname");
}

_____obj_blood_weapon____() {}

quest_step_bloodraven_fill_drains() {
  var_00 = common_scripts\utility::func_46B7("struct_blooddrain_main", "targetname");
  level thread run_stopper();
  level thread run_bomber_debris_puzzle();
  level thread acquire_radio();
  level thread acquire_speakers();
  foreach(var_03, var_02 in var_00) {
    var_02.var_819A = "blood_collect_" + var_03;
    common_scripts\utility::func_3C87(var_02.var_819A);
    var_02 childthread run_blood_drain_collection();
  }

  level thread track_drain_completion(var_00);
  var_04 = [233, 234, 235];
  for(var_03 = 0; var_03 < var_00.size; var_03++) {
    level thread reveal_blood_fx("blood_collect_" + var_03, var_04[var_03]);
  }

  for(var_03 = 0; var_03 < var_00.size; var_03++) {
    common_scripts\utility::func_3C9F("blood_collect_" + var_03);
  }

  lib_0557::func_782D("quest_bloodraven", "quest_bloodraven_drain_fill");
}

track_drain_completion(param_00) {
  level.bloodraven_drains_filled = 0;
  while(level.bloodraven_drains_filled <= 2) {
    level common_scripts\utility::knock_off_battery(param_00[0].var_819A, param_00[1].var_819A, param_00[2].var_819A);
    common_scripts\utility::func_3C8F("flag_blood_pool_" + level.bloodraven_drains_filled);
    level.bloodraven_drains_filled++;
  }
}

reveal_blood_fx(param_00, param_01) {
  common_scripts\utility::func_3C9F(param_00);
  common_scripts\_exploder::func_891(param_01);
}

run_stopper() {
  var_00 = getent("zmf_bloodraven_plug_find", "targetname");
  var_01 = getent("zmf_bloodraven_plug_trig_find", "targetname");
  var_02 = getent("zmf_bloodraven_plug_trig", "targetname");
  var_03 = getent("zmf_bloodraven_plug", "targetname");
  var_03 method_805C();
  var_01 waittill("trigger", var_04);
  var_00 method_805C();
  var_00 lib_0378::func_8D74("aud_bloodraven_bloodstopper_pickup");
  common_scripts\utility::func_3C8F("stopper_collected");
  var_02 waittill("trigger", var_04);
  var_03 method_805B();
  var_03 lib_0378::func_8D74("aud_bloodraven_bloodstopper_place");
  common_scripts\utility::func_3C8F("stopper_in_place");
}

quest_step_bloodraven_acquire_radio() {
  common_scripts\utility::func_3C9F("radio_collected");
  lib_0557::func_782D("quest_bloodraven", "quest_bloodraven_radio_find");
}

run_bomber_debris_puzzle() {
  var_00 = getent("zmf_bloodraven_radio_blocker", "targetname");
  var_01 = getent(var_00.var_1A2, "targetname");
  var_02 = (0, 0, 0);
  var_03 = 0;
  while(distance(var_00.var_116, var_02) > var_03) {
    level waittill("objective_zombie_exploder_detonation", var_02, var_03);
  }

  var_00 method_805C();
  var_01 method_8060();
  var_01 notsolid();
  common_scripts\utility::func_3C8F("limbo_debris_exploded");
}

acquire_radio() {
  common_scripts\utility::func_3C87("radio_collected");
  var_00 = getent("zmf_bloodraven_radio_find", "targetname");
  var_01 = getent("zmf_bloodraven_radio_find_trig", "targetname");
  var_02 = getent("zmf_bloodraven_radio_place", "targetname");
  var_03 = getent("zmf_bloodraven_radio_place_trig", "targetname");
  var_00 method_805C();
  var_02 method_805C();
  wait(1);
  var_00 method_805B();
  common_scripts\utility::func_3C9F("limbo_debris_exploded");
  var_01 waittill("trigger", var_04);
  var_00 method_805C();
  var_00 lib_0378::func_8D74("aud_bloodraven_radio_pickup");
  common_scripts\utility::func_3C8F("flag_radio_picked_up");
  var_03 waittill("trigger", var_04);
  radio_set();
}

acquire_speakers() {
  common_scripts\utility::func_3C87("speakers_collected");
  var_00 = getent("zmf_bloodraven_speakers_find_trig", "targetname");
  var_01 = getent("zmf_bloodraven_speakers_find", "targetname");
  var_02 = getent("zmf_bloodraven_speakers_place_trig", "targetname");
  var_03 = getent("zmf_bloodraven_speakers_place", "targetname");
  var_01 method_805C();
  var_03 method_805C();
  wait(1);
  var_01 method_805B();
  common_scripts\utility::func_3C9F("limbo_debris_exploded");
  var_00 waittill("trigger", var_04);
  var_01 method_805C();
  var_01 lib_0378::func_8D74("aud_bloodraven_speaker_pickup");
  var_02 waittill("trigger", var_04);
  speakers_set();
}

radio_set() {
  var_00 = getent("zmf_bloodraven_radio_place", "targetname");
  var_00 method_805B();
  var_00 lib_0378::func_8D74("aud_bloodraven_radio_place");
  common_scripts\utility::func_3C8F("radio_collected");
  var_00 thread turn_on_vfx();
}

turn_on_vfx() {
  wait(5);
  self.radiofx = lib_0547::func_8FBA(self, "zmb_desc_radio_fixed");
  triggerfx(self.radiofx);
}

speakers_set() {
  var_00 = getent("zmf_bloodraven_speakers_place", "targetname");
  var_00 method_805B();
  var_00 lib_0378::func_8D74("aud_bloodraven_speaker_place");
  common_scripts\utility::func_3C8F("speakers_collected");
}

quest_step_bloodraven_aquire_sheild() {
  lib_0547::func_7BA9(::dropplayershield);
  var_00 = common_scripts\utility::func_46B5("ee_follower_rise", "targetname");
  var_00 maps\mp\mp_zombie_descent_utils::wait_for_player_close(280);
  var_01 = lib_054D::func_90BA("zombie_heavy", var_00, "ee_follower", 1, 1, 0);
  var_01 lib_0378::func_8D74("aud_bloodraven_wustling_spawn");
  var_02 = var_01 common_scripts\utility::func_8FFC();
  var_02 setModel("npc_zom_bloodraven_shield");
  var_02 method_805B();
  var_02.var_116 = var_01 gettagorigin("J_SpineUpper");
  var_02.var_1D = var_01 gettagangles("J_SpineUpper");
  var_03 = 7;
  var_04 = 2;
  var_05 = 8;
  var_02 method_8449(var_01, "J_SpineUpper", (var_05, var_04, var_03), (0, 90, 90));
  var_01.hasplayershield = 1;
  var_01.sheild_attach = var_02;
  var_01.playershieldsafespawnpos = undefined;
  var_01 thread shield_track_safe_drop_position();
}

shield_track_safe_drop_position() {
  var_00 = self;
  var_00 endon("death");
  while(common_scripts\utility::func_562E(var_00.hasplayershield)) {
    if(!var_00 isonground()) {
      wait 0.05;
      continue;
    }

    if(function_02E6(var_00.var_116)) {
      var_00.playershieldsafespawnpos = var_00.var_116;
    }

    wait(1);
  }
}

init_quest_step_bloodraven_reveal_code() {
  var_00 = common_scripts\utility::func_46B7("struct_blooddrain_main", "targetname");
  foreach(var_02 in var_00) {
    var_02.symbols = level.zmb_possible_blood_code_values;
  }
}

quest_step_bloodraven_reveal_code() {
  var_00 = common_scripts\utility::func_46B7("zmf_ee_blood_message_struct", "targetname");
  level thread maps\mp\_utility::func_6F74(::notify_blood_code_change);
  foreach(var_02 in var_00) {
    if(var_02 is_blood_input()) {
      var_02 thread handle_code_set();
    }
  }

  var_04 = common_scripts\utility::func_46B7("struct_blooddrain_main", "targetname");
  var_04 thread handle_code_reveal();
}

quest_step_bloodraven_enter_code() {
  var_00 = common_scripts\utility::func_46B5("zmb_bloodraven_code_display", "targetname");
  var_00 handle_code_entry();
  lib_0557::func_782D("quest_bloodraven", "quest_bloodraven_enter_code");
}

handle_code_entry() {
  var_00 = spawnStruct();
  level.bloodraven_code_handler = var_00;
  var_01 = level.zmb_possible_blood_code_values;
  var_02 = 3;
  var_03 = var_01.size;
  var_00.row = 0;
  var_00.column = 0;
  var_04 = getent("zmf_bloodraven_radio_place_trig", "targetname");
  common_scripts\utility::func_3C9F("radio_collected");
  common_scripts\utility::func_3C9F("speakers_collected");
  self.onzombiesacrificedfunc = ::radio_soul_collect_response;
  self.optionaldisablearclightning = 1;
  thread maps\mp\mp_zombies_soul_collection::beginazombiesoulcollectionobjectiveonstruct(-1, 300, 64, "bloodraven_collect_soul_set", undefined, "tag_origin", undefined, "tag_origin", undefined, self, (0, 0, 8), undefined, 1, 1);
  var_05 = level.reveal_structs_in_order;
  wait_for_structs_revealed(var_05);
  var_06 = common_scripts\utility::func_46B5("zmb_bloodraven_code_display", "targetname");
  level.blood_raven_input = [0, 0, 0];
  var_06 set_blood_fx(var_00.column);
  for(;;) {
    var_04 waittill("trigger", var_07);
    var_04 lib_0378::func_8D74("aud_bloodraven_tune_radio");
    if(isDefined(var_07)) {
      var_00.column++;
      if(var_00.column >= var_03) {
        var_00.column = 0;
      }
    } else {
      level.blood_raven_input[var_00.row] = var_01[var_00.column];
      var_00.row++;
      if(var_00.row >= var_02) {
        var_00.row = 0;
      }
    }

    if(!code_correct(level.blood_raven_input, var_05)) {
      if(!isDefined(var_07) && var_00.row == 0) {
        var_06 set_blood_fx(var_00.column, "fail");
        var_00.column = 0;
      } else if(isDefined(var_07)) {
        var_06 set_blood_fx(var_00.column);
      }

      continue;
    }

    var_06 set_blood_fx(var_00.column, "zmb_desc_chladni_success");
    break;
  }

  if(isDefined(self.collector)) {
    self.collector.var_AC2C = 0;
    self.collector.var_AC2D = self.collector.var_AC2C;
    level notify(self.collector.var_695B);
  }

  lib_0557::func_782D("quest_bloodraven", "quest_bloodraven_enter_code");
}

set_blood_fx(param_00, param_01) {
  var_02 = 2.5;
  if(param_00 == 0) {
    var_03 = level.zmb_possible_blood_code_values[level.zmb_possible_blood_code_values.size - 1];
    var_04 = level.zmb_possible_blood_code_values[0];
  } else {
    var_03 = level.zmb_possible_blood_code_values[var_02 - 1];
    var_04 = level.zmb_possible_blood_code_values[param_01];
  }

  if(!isDefined(param_01)) {
    var_05 = "zmb_desc_chladni_" + var_03 + "_to_" + var_04;
  } else if(var_02 == "fail") {
    var_03 = 1.5;
    var_05 = "zmb_desc_chladni_" + var_05 + "_to_0";
    var_04 = level.zmb_possible_blood_code_values[0];
    set_fx_blood_generic(var_05);
    wait(var_02);
    var_05 = "zmb_desc_chladni_0_to_1";
    param_01 = undefined;
  } else {
    var_05 = var_02;
  }

  set_fx_blood_generic(var_05);
  if(isDefined(param_01)) {
    return;
  }

  wait(var_02);
  set_fx_blood_generic("zmb_desc_chladni_" + var_04 + "_lp");
}

set_fx_blood_generic(param_00) {
  if(isDefined(self.blood_fx_index)) {
    self.blood_fx_index delete();
  }

  self.blood_fx_index = lib_0547::func_8FBA(self, param_00);
  triggerfx(self.blood_fx_index);
  lib_0378::func_8D74("aud_bloodraven_bloodcode_final", self, param_00);
}

code_correct(param_00, param_01) {
  foreach(var_04, var_03 in param_00) {
    if(var_03 != param_01[var_04].blood_fx_index) {
      return 0;
    }
  }

  return 1;
}

wait_for_structs_revealed(param_00) {
  var_01 = 0;
  while(!var_01) {
    var_01 = 1;
    foreach(var_03 in param_00) {
      if(!isDefined(var_03.blood_fx_index)) {
        var_01 = 0;
      }
    }

    wait 0.05;
  }
}

radio_soul_collect_response(param_00) {
  var_01 = getent("zmf_bloodraven_radio_place_trig", "targetname");
  thread maps\mp\mp_zombie_descent::on_zombie_soul_collected_func(param_00);
  var_01 notify("trigger");
}

quest_step_bloodraven_enter_trial() {
  var_00 = wait_for_sheild_owner_sacrifice();
  var_00 lib_0378::func_8D74("aud_bloodraven_enter_trial");
  lib_0557::func_782D("quest_bloodraven", "quest_bloodraven_enter_trial");
}

quest_step_bloodraven_complete_trial() {
  var_00 = get_blood_shield_owner();
  var_01 = common_scripts\utility::func_46B7("zom_dlc4_shield_zm_spawns", "targetname");
  var_02 = common_scripts\utility::func_7A33(var_01);
  var_03 = spawnStruct();
  var_03.var_116 = var_00.var_116;
  var_03.var_1D = var_00.var_1D;
  var_04 = 0;
  while(!var_04) {
    var_00.old_destination = var_03;
    var_00 setorigin(var_02.var_116, 1);
    if(common_scripts\utility::func_562E(var_00 run_weapon_ritual("zom_dlc4_shield_zm"))) {
      break;
    }

    var_00 = wait_for_sheild_owner_sacrifice();
  }

  var_00 lib_0378::func_8D74("aud_bloodraven_exit_trial");
}

wait_for_sheild_owner_sacrifice() {
  var_00 = common_scripts\utility::func_46B5("ee_follower_rise", "targetname");
  level.zmb_player_last_stand_protection = ::is_player_sacrificing_to_bloodraven_quest;
  level waittill("zmb_enter_last_stand_bloodraven", var_01);
  level.zmb_player_last_stand_protection = undefined;
  return var_01;
}

is_player_sacrificing_to_bloodraven_quest(param_00) {
  var_01 = common_scripts\utility::func_46B5("ee_follower_rise", "targetname");
  if(distance2d(param_00.var_116, var_01.var_116) > 190) {
    return 0;
  }

  if(!param_00 hasweapon("zom_dlc4_shield_zm")) {
    return 0;
  }

  level notify("zmb_enter_last_stand_bloodraven", param_00);
  return 1;
}

is_code_entry(param_00) {
  var_01 = self;
  return issubstr(var_01.var_165, param_00);
}

notify_blood_code_change() {
  var_00 = self;
  for(;;) {
    var_00 waittill("melee_fired");
    level notify("blood_change", var_00);
  }
}

handle_code_set() {
  var_00 = self;
  common_scripts\utility::func_3C9F(lib_0557::func_7838("quest_bloodraven", "quest_bloodraven_radio_find"));
  var_00 set_blood_code(common_scripts\utility::func_7A33(var_00.symbols));
  for(;;) {
    level waittill("blood_change", var_01);
    if(distance(var_01.var_116, var_00.var_116) < 52) {
      var_00 set_next_symbol(var_01);
    }
  }
}

set_next_symbol(param_00) {
  var_01 = self;
  var_02 = var_01.curindex;
  var_02++;
  if(var_02 >= var_01.symbols.size) {
    var_02 = 0;
  }

  var_01 set_blood_code(var_02, param_00);
}

set_blood_code(param_00, param_01) {
  var_02 = self;
  if(isDefined(var_02.var_3F2F)) {
    var_02.var_3F2F delete();
  }

  if(param_00 == -1) {
    return;
  }

  var_02.var_3F2F = lib_0547::func_8FBA(var_02, "zmb_desc_chladni_fig_" + param_00 + "_sml_lp", param_01);
  var_02.blood_fx_index = param_00;
  triggerfx(var_02.var_3F2F);
}

turn_off_blood_code() {
  set_blood_code(-1);
}

handle_code_reveal() {
  var_00 = self;
  var_00 = common_scripts\utility::func_F92(var_00);
  level.reveal_structs_in_order = var_00;
  foreach(var_02 in var_00) {
    var_03 = get_blood_shield_owner();
    var_02.wisp = 1;
    var_02.var_3F2F = lib_0547::func_8FBA(var_02, "zmf_descent_vision_blood_ready", var_03);
    triggerfx(var_02.var_3F2F);
    var_02.var_3F2F lib_0378::func_8D74("aud_bloodraven_bloodpool_ready");
    var_02 thread wait_for_reveal();
    while(!common_scripts\utility::func_562E(var_02.isrevealed)) {
      wait 0.05;
    }

    var_02.wisp = undefined;
    var_03 = get_blood_shield_owner();
    var_02 set_blood_code(common_scripts\utility::func_7A33(var_02.symbols), var_03);
    lib_0378::func_8D74("aud_bloodraven_reveal_bloodpool_code", var_02);
  }

  lib_0557::func_782D("quest_bloodraven", "quest_bloodraven_acquire_code");
}

wait_for_reveal() {
  var_00 = self;
  var_01 = (0, 0, 0);
  for(;;) {
    level waittill("ce_explosion", var_01);
    if(distance(var_01, var_00.var_116) < 52) {
      break;
    }
  }

  var_00.isrevealed = 1;
}

get_blood_shield_owner() {
  for(;;) {
    foreach(var_01 in level.var_744A) {
      if(var_01 hasweapon("zom_dlc4_shield_zm")) {
        return var_01;
      }
    }

    wait 0.05;
  }
}

is_blood_input() {
  var_00 = self;
  return issubstr(var_00.var_165, "set");
}

dropplayershield(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!common_scripts\utility::func_562E(self.hasplayershield)) {
    return;
  }

  var_09 = self.sheild_attach;
  if(isDefined(self.playershieldsafespawnpos) && !self isonground() || !function_02E6(self.var_116)) {
    var_0A = self.playershieldsafespawnpos;
  } else {
    var_0A = var_0A.var_116;
  }

  var_0B = var_09.var_1D;
  var_09 unlink();
  var_09 delete();
  maps\mp\zombies\weapons\_zombie_dlc4_melee::spawn_raven_weapon("shield", var_0A, var_0B);
  lib_0557::func_782D("quest_bloodraven", "quest_bloodraven_acquire_sheild");
}

run_blood_drain_collection() {
  var_00 = (0, 0, 16);
  thread display_progress_in_blood();
  if(lib_0547::func_5565(self.var_165, "message_reveal_c")) {
    common_scripts\utility::func_3C9F("stopper_in_place");
  }

  self.onzombiesacrificedfunc = ::drain_soul_collect_response;
  self.optionaldisablearclightning = 1;
  maps\mp\mp_zombies_soul_collection::beginazombiesoulcollectionobjectiveonstruct(5, 300, 64, self.var_819A + "_soul", undefined, "tag_origin", undefined, "tag_origin", undefined, self, var_00, undefined, 1, 1);
  common_scripts\utility::func_3C8F(self.var_819A);
}

drain_soul_collect_response(param_00) {
  thread maps\mp\mp_zombie_descent::on_zombie_soul_collected_func(param_00);
}

display_progress_in_blood() {
  var_00 = self;
  var_01 = getent(var_00.var_1A2, "targetname");
  var_01.full_origin = var_01.var_116;
  var_01.empty_origin = var_01.var_116 - (0, 0, 16);
  var_01.var_116 = var_01.empty_origin;
  while(!isDefined(var_00.collector)) {
    wait 0.05;
  }

  var_00 thread end_blood_progress_updates();
  var_00 endon("stop_blood_progress_update");
  for(;;) {
    if(isDefined(var_00.collector)) {
      var_02 = var_00.collector.var_AC2C / var_00.collector.var_AC2D;
    } else {
      var_02 = 1;
    }

    if(var_02 > 1) {
      var_02 = 1;
    }

    var_01 moveto(vectorlerp(var_01.empty_origin, var_01.full_origin, var_02), 0.5);
    wait(0.5);
  }
}

end_blood_progress_updates() {
  var_00 = self;
  var_00.collector waittill("entitydeleted");
  while(isDefined(var_00.collector)) {
    wait 0.05;
  }

  wait(0.55);
  var_00 notify("stop_blood_progress_update");
}

__________________deathraven__________________() {}

quest_step_deathraven_push_stone() {
  level thread handle_wire_pickup();
  var_00 = getent("zmb_deathraven_stone", "targetname");
  var_00.dest = common_scripts\utility::func_46B5(var_00.var_1A2, "targetname");
  var_01 = getent("zmb_deathraven_trigger", "targetname");
  var_01 waittill("trigger", var_02);
  lib_0378::func_8D74("aud_deathraven_button", var_00);
  lib_0557::func_782D("quest_deathraven", "quest_deathraven_activate_rush");
}

handle_wire_pickup() {
  var_00 = common_scripts\utility::func_46B5("zmf_deathraven_wire_struct", "targetname");
  var_01 = common_scripts\utility::func_44BE(var_00.var_1A2, "targetname");
  foreach(var_03 in var_01) {
    switch (var_03.var_165) {
      case "zmf_deathraven_wire_trig":
        var_00.var_9D5E = var_03;
        break;

      case "zmf_deathraven_wire_model":
        var_00.ent_model = var_03;
        break;
    }
  }

  var_00.var_9D5E waittill("trigger", var_05);
  var_00.ent_model method_805C();
  common_scripts\utility::func_3C8F("deathraven_metal_collected");
}

quest_step_deathraven_survive_rush() {
  var_00 = getent("zmb_deathraven_stone", "targetname");
  var_00 moveto(var_00.dest.var_116, 1, 0, 0.2);
  foreach(var_02 in level.var_744A) {
    if(distance(var_02.var_116, var_00.var_116) > 1000) {
      continue;
    }

    var_03 = 2.8;
    var_02 thread maps\mp\mp_zombie_descent_utils::start_screenshake(var_03);
    var_02 lib_0378::func_8D74("aud_deathraven_earthquake", var_03);
  }

  enable_firewalls(1);
  maps\mp\gametypes\zombies::func_8B2(var_00.var_116, 1);
  level.maxed_zombies_sprint = 1;
  level.zmb_locked_spawn_zones = ["zone_gallery"];
  maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8606();
  level.overridespawndelay = 0.08;
  var_05 = getent("deathraven_blood_raise", "targetname");
  if(isDefined(var_05)) {
    var_05 movez(7, 35);
  }

  level thread mark_death_event_goers();
  var_06 = 35;
  if(lib_0547::is_solo()) {
    var_06 = 26;
  }

  wait(var_06);
  activateclientexploder(225);
  var_05 lib_0378::func_8D74("aud_deathraven_scythe_appear");
  lib_0557::func_782D("quest_deathraven", "quest_deathraven_survive_rush");
}

quest_step_deathraven_acquire_spine() {
  level thread maps\mp\_utility::func_6F74(::show_marked_eater_to_scythe_holders);
  lib_0547::func_7BA9(::give_corpse_eater_spine);
  for(;;) {
    var_00 = lib_0547::func_4090("zombie_dlc4");
    var_01 = 0;
    foreach(var_03 in var_00) {
      if(common_scripts\utility::func_562E(var_03.ismarkedeater)) {
        var_04 = var_03;
        var_01 = 1;
        break;
      }
    }

    if(!var_01 && var_00.size > 0) {
      var_04 = common_scripts\utility::func_7A33(var_00);
      var_04.ismarkedeater = 1;
    }

    wait 0.05;
  }
}

give_corpse_eater_spine(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!common_scripts\utility::func_562E(self.ismarkedeater)) {
    return;
  }

  if(!isDefined(param_01) || !isPlayer(param_01)) {
    return;
  }

  if(!isDefined(param_04)) {
    return;
  }

  if(!issubstr(param_04, "scythe")) {
    return;
  }

  param_01 give_player_the_corpse_eater_spine();
}

give_player_the_corpse_eater_spine() {
  var_00 = self;
  if(common_scripts\utility::func_3C77(lib_0557::func_7838("quest_deathraven", "quest_deathraven_acquire_weapon"))) {
    return;
  }

  lib_0547::func_2D8C(::give_corpse_eater_spine);
  lib_0557::func_782D("quest_deathraven", "quest_deathraven_acquire_weapon");
  var_00 maps\mp\mp_zombie_descent_utils::spine_pickup_anim("spine_inspect_c_eater_zm");
  common_scripts\utility::func_3C8F("deathraven_spine_collected");
}

show_marked_eater_to_scythe_holders() {
  var_00 = self;
  var_00 endon("disconnect");
  for(;;) {
    foreach(var_02 in lib_0547::func_4090("zombie_dlc4")) {
      if(common_scripts\utility::func_562E(var_02.ismarkedeater)) {
        if(!isDefined(var_02.markedviewers)) {
          var_02.markedviewers = [];
        }

        if(var_00 is_deathraven_holder() && !common_scripts\utility::func_F79(var_02.markedviewers, var_00)) {
          var_02.markedviewers = common_scripts\utility::func_F6F(var_02.markedviewers, var_00);
          playfxontagforclients(level.var_611["zmb_scythe_zmb_blind"], var_02, "J_Head", var_00);
          continue;
        }

        if(!var_00 is_deathraven_holder() && common_scripts\utility::func_F79(var_02.markedviewers, var_00)) {
          var_02.markedviewers = common_scripts\utility::func_F93(var_02.markedviewers, var_00);
          function_0294(level.var_611["zmb_scythe_zmb_blind"], var_02, "J_Head", var_00);
        }
      }
    }

    wait 0.05;
  }
}

mark_death_event_goers() {
  level notify("mark_event_goers");
  level endon("mark_event_goers");
  var_00 = getent("zone_gallery_deathravent_event", "targetname");
  while(!common_scripts\utility::func_3C77(lib_0557::func_7838("quest_deathraven", "quest_deathraven_survive_rush"))) {
    foreach(var_02 in level.var_744A) {
      if(var_02 istouching(var_00) && !lib_0547::func_577E(var_02)) {
        var_02.isintrial = "quest_deathraven";
        continue;
      }

      if(!var_02 is_in_other_event()) {
        var_02.isintrial = undefined;
      }
    }

    foreach(var_05 in lib_0547::func_408F()) {
      if(!var_05 is_in_other_event()) {
        var_05.isintrial = "quest_deathraven";
      }
    }

    wait 0.05;
  }

  foreach(var_02 in level.var_744A) {
    if(var_02 is_in_deathraven_event()) {
      var_02.isintrial = undefined;
    }
  }
}

is_in_other_event() {
  var_00 = self;
  return isDefined(var_00.isintrial) && var_00.isintrial != "quest_deathraven";
}

is_in_deathraven_event() {
  var_00 = self;
  return lib_0547::func_5565(var_00.isintrial, "quest_deathraven");
}

quest_step_deathraven_pickup_weapon() {
  var_00 = common_scripts\utility::func_46B5("zmb_scythe_pickup", "targetname");
  level thread cleanup_deathraven_combat_event(var_00.var_116);
  var_01 = maps\mp\zombies\weapons\_zombie_dlc4_melee::spawn_raven_weapon("scythe", var_00.var_116);
  stopclientexploder(225);
  lib_0378::func_8D74("aud_deathraven_scythe_obtain");
  lib_0557::func_782D("quest_deathraven", "quest_deathraven_pickup_weap");
}

quest_step_deathraven_assemble_weapon() {
  var_00 = getent("zmb_deathraven_assembly_trigger", "targetname");
  var_01 = getent("zmb_deathraven_assembly_spine", "targetname");
  var_02 = getent("zmb_deathraven_assembly_metal", "targetname");
  var_03 = getent("zmb_deathraven_assembly_scythe", "targetname");
  for(;;) {
    var_00 waittill("trigger", var_04);
    if(common_scripts\utility::func_3C77("deathraven_spine_collected")) {
      var_01 method_805B();
      common_scripts\utility::func_3C8F("deathraven_spine_placed");
      var_01 lib_0378::func_8D74("aud_deathraven_place_spine");
    }

    if(common_scripts\utility::func_3C77("deathraven_metal_collected")) {
      var_02 method_805B();
      common_scripts\utility::func_3C8F("deathraven_metal_placed");
      var_02 lib_0378::func_8D74("aud_deathraven_place_scythe");
    }

    if(!common_scripts\utility::func_3C77("deathraven_spine_collected") || !common_scripts\utility::func_3C77("deathraven_metal_collected")) {
      continue;
    }

    var_05 = var_04 getcurrentweapon();
    if(common_scripts\utility::func_3C77("deathraven_scythe_placed") || lib_0547::func_5565(var_05, "zom_dlc4_scythe_zm")) {
      var_04 lib_0586::func_790("zom_dlc4_scythe_zm");
      var_06 = maps\mp\zombies\_zombies_magicbox::func_454B(var_04, "shovel_zm");
      var_04 lib_0586::func_78C(var_06);
      var_04 lib_0586::func_78E(var_06);
      var_03 method_805B();
      common_scripts\utility::func_3C8F("deathraven_scythe_placed");
    }

    if(common_scripts\utility::func_3C77("deathraven_spine_placed") && common_scripts\utility::func_3C77("deathraven_metal_placed") && common_scripts\utility::func_3C77("deathraven_scythe_placed")) {
      var_00.assembled = 1;
      break;
    }
  }

  lib_0557::func_782D("quest_deathraven", "quest_deathraven_assemble_weap");
}

quest_step_deathraven_fuse() {
  show_scythe_assembly();
  var_00 = getent("zmb_deathraven_assembly_scythe", "targetname");
  var_01 = var_00 common_scripts\utility::func_8FFC();
  var_01 method_805B();
  var_01.onzombiesacrificedfunc = ::onscythezombiecollected;
  var_01 maps\mp\mp_zombies_soul_collection::func_170B(15, 300, 64, "scythe_soul_collect", undefined, "tag_origin", undefined, "tag_origin", undefined, self, (0, 0, 16), undefined, 1);
  level.zmb_scythe_collector = var_01;
  lib_0557::func_782D("quest_deathraven", "quest_deathraven_fuse_weap");
}

onscythezombiecollected(param_00) {
  var_01 = getent("zmb_deathraven_assembly_scythe", "targetname");
  if(param_00.var_AC2C == 5) {
    playFXOnTag(common_scripts\utility::func_44F5("zmb_death_scythe_forge"), var_01, "tag_fx");
    var_01 lib_0378::func_8D74("aud_deathraven_scythe_heat_stage_1");
  }
}

quest_step_deathraven_transport() {
  var_00 = getent("zmb_deathraven_assembly_scythe", "targetname");
  stopFXOnTag(common_scripts\utility::func_44F5("zmb_death_scythe_forge"), var_00, "tag_fx");
  playFXOnTag(common_scripts\utility::func_44F5("zmb_death_scythe_forge_stage2"), var_00, "tag_fx");
  var_00 lib_0378::func_8D74("aud_deathraven_scythe_heat_stage_2");
  var_01 = level.var_A980;
  while(var_01 + 1 >= level.var_A980) {
    wait 0.05;
  }

  stopFXOnTag(common_scripts\utility::func_44F5("zmb_death_scythe_forge_stage2"), var_00, "tag_fx");
  playFXOnTag(common_scripts\utility::func_44F5("zmb_death_scythe_forge_endstage"), var_00, "tag_fx");
  if(!isDefined(level.zmb_scythe_collector)) {
    level.zmb_scythe_collector = var_00 common_scripts\utility::func_8FFC();
    level.zmb_scythe_collector method_805B();
  }

  level.zmb_scythe_collector lib_0378::func_8D74("aud_deathraven_scythe_heated");
  wait(3);
  var_02 = wait_for_deathraven_spine_pickup();
  if(isDefined(level.zmb_scythe_collector)) {
    level.zmb_scythe_collector delete();
  }

  lib_0557::func_782D("quest_deathraven", "quest_deathraven_transport_weap");
}

wait_for_deathraven_spine_pickup() {
  var_00 = getent("zmb_deathraven_assembly_trigger", "targetname");
  var_01 = undefined;
  var_00 common_scripts\utility::func_9DA3();
  while(!isDefined(var_01) || !common_scripts\utility::func_562E(var_00.assembled)) {
    var_00 waittill("trigger", var_01);
  }

  var_00 common_scripts\utility::func_9D9F();
  var_01 maps\mp\zombies\weapons\_zombie_dlc4_melee::try_drop_old_weapon(var_01 maps\mp\zombies\weapons\_zombie_dlc4_melee::getcurrentdlc4meleeweapon(), 0, 1);
  hide_scythe_assembly();
  var_00 lib_0378::func_8D74("aud_deathraven_pickup_scythe");
  var_01.holdingdeathravenmaterials = 1;
  return var_01;
}

quest_step_deathraven_enter_trial() {
  level endon(lib_0557::func_7838("quest_deathraven", "quest_deathraven_enter_trial"));
  for(;;) {
    var_00 = get_deathraven_holder();
    var_00 set_weapon_upgrade_blood_tube_route("zom_dlc4_scythe_zm");
    var_00 thread raven_trial_set_retry_on_death();
    var_00 common_scripts\utility::knock_off_battery("disconnect", "return_faked_scythe", "fake_disconnect");
    foreach(var_02 in level.var_744A) {
      var_02.holdingdeathravenmaterials = 0;
    }

    show_scythe_assembly();
    var_00 = wait_for_deathraven_spine_pickup();
  }
}

raven_trial_set_retry_on_death() {
  self endon("disconnect");
  self endon("return_faked_scythe");
  level endon(lib_0557::func_7838("quest_deathraven", "quest_deathraven_enter_trial"));
  for(;;) {
    self waittill("zombie_player_spawn_finished");
    set_weapon_upgrade_blood_tube_route("zom_dlc4_scythe_zm");
  }
}

is_deathraven_holder() {
  return common_scripts\utility::func_562E(self.holdingdeathravenmaterials) || common_scripts\utility::func_562E(self hasweapon("zom_dlc4_scythe_zm"));
}

get_deathraven_holder() {
  for(;;) {
    foreach(var_01 in level.var_744A) {
      if(var_01 is_deathraven_holder()) {
        return var_01;
      }
    }

    wait 0.05;
  }
}

set_weapon_upgrade_blood_tube_route(param_00) {
  var_01 = self;
  var_01.forcedblooddest = param_00;
}

cleanup_deathraven_combat_event(param_00) {
  level notify("cleanup_deathraven_combat_event");
  level endon("cleanup_deathraven_combat_event");
  maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8608();
  maps\mp\gametypes\zombies::func_8B2(param_00, 1);
  var_01 = getent("deathraven_weapon_cover", "targetname");
  var_01 method_805C();
  level.overridespawndelay = undefined;
  level.zmb_locked_spawn_zones = undefined;
  enable_firewalls(0);
  level.maxed_zombies_sprint = 0;
  level.deathraven_event_happening = 0;
  wait(6);
  maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8607();
}

init_deathraven_quest() {
  enable_firewalls(0);
  var_00 = getent("deathraven_blood_raise", "targetname");
  var_00 movez(-7, 0.1);
  common_scripts\utility::func_3C87("deathraven_spine_collected");
  common_scripts\utility::func_3C87("deathraven_metal_collected");
  common_scripts\utility::func_3C87("deathraven_spine_placed");
  common_scripts\utility::func_3C87("deathraven_metal_placed");
  common_scripts\utility::func_3C87("deathraven_scythe_placed");
  hide_scythe_assembly();
}

hide_scythe_assembly() {
  var_00 = getent("zmb_deathraven_assembly_spine", "targetname");
  var_01 = getent("zmb_deathraven_assembly_metal", "targetname");
  var_02 = getent("zmb_deathraven_assembly_scythe", "targetname");
  var_00 method_805C();
  var_01 method_805C();
  var_02 method_805C();
}

show_scythe_assembly() {
  level.zmb_scythe_no_spawn = 1;
  var_00 = getent("zmb_deathraven_assembly_spine", "targetname");
  var_01 = getent("zmb_deathraven_assembly_metal", "targetname");
  var_02 = getent("zmb_deathraven_assembly_scythe", "targetname");
  var_00 method_805B();
  var_01 method_805B();
  var_02 method_805B();
}

enable_firewalls(param_00) {
  var_01 = getEntArray("zmb_firewall_collision", "script_noteworthy");
  foreach(var_03 in var_01) {
    if(param_00) {
      var_03 solid();
      continue;
    }

    var_03 notsolid();
  }

  enable_bumpers(param_00);
}

enable_bumpers(param_00) {
  level notify("new_enable_bumpers");
  level endon("new_enable_bumpers");
  if(param_00) {
    var_01 = getEntArray("zmb_firewall_collision_bumpers", "script_noteworthy");
    foreach(var_03 in var_01) {
      var_03 childthread push_players();
    }
  }

  var_05 = common_scripts\utility::func_46B7("zmb_firewall_fx", "script_noteworthy");
  foreach(var_07 in var_05) {
    if(isDefined(var_07.my_fire_fx)) {
      var_07.my_fire_fx delete();
    }

    if(!param_00) {
      continue;
    }

    var_07.my_fire_fx = lib_0547::func_8FBA(var_07, "zmf_descent_firewall");
    triggerfx(var_07.my_fire_fx);
    var_07.my_fire_fx lib_0378::func_8D74("aud_deathraven_firewall", param_00);
  }
}

push_players() {
  for(;;) {
    wait 0.05;
    foreach(var_01 in level.var_744A) {
      if(!common_scripts\utility::func_562E(var_01.isonpushcooldown) && var_01 istouching(self)) {
        self.isfireinflictor = 1;
        thread push_off_wall(var_01);
      }
    }
  }
}

push_off_wall(param_00) {
  param_00 endon("disconnect");
  var_01 = param_00.var_116 - self.var_116;
  var_01 = (var_01[0], var_01[1], 0);
  var_02 = vectornormalize(var_01);
  param_00 setvelocity(300 * var_02 + (0, 0, 100));
  param_00.isonpushcooldown = 1;
  playfxontagforclients(level.var_611["player_screen_burn"], param_00, "TAG_ORIGIN", param_00);
  param_00 dodamage(35, param_00 getEye(), undefined, self.fireattacker, "MOD_ENERGY");
  wait(0.8);
  param_00.isonpushcooldown = 0;
}

run_weapon_ritual(param_00, param_01) {
  var_02 = self;
  if(!isPlayer(var_02)) {
    return;
  }

  var_02 endon("disconnect");
  var_02 endon("death");
  var_02.var_480F = 0;
  var_03 = level.raven_weapon_upgrade_trials[param_00];
  var_02.isintrial = param_00;
  var_03.var_8BE = 1;
  if(isDefined(param_00) && param_00 != "zom_pap_trial_destination" && param_00 != "zom_bonus_trial_destination" && param_00 != "zom_shelf_trial_destination") {
    var_02 method_8322();
    var_02 method_812A(0);
    var_02 setclientomnvar("ui_hide_hud", 1);
    var_02 childthread weapon_ritual_weapon_picked_up();
    if(lib_0547::func_5565(param_00, "zom_dlc4_scythe_zm")) {
      thread maps\mp\zombies\weapons\_zombie_dlc4_melee::spawn_raven_weapon(var_03.weap_upgrade, var_03.weapon_spawn.var_116, undefined, undefined, 1);
    } else {
      thread maps\mp\zombies\weapons\_zombie_dlc4_melee::spawn_raven_weapon(var_03.weap_upgrade, var_03.weapon_spawn.var_116);
    }
  } else {
    var_02 method_8323();
  }

  var_03 childthread mark_zombies_in_trial(var_03.var_116, param_00);
  if(isDefined(param_00) && param_00 != "zom_pap_trial_destination" && param_00 != "zom_bonus_trial_destination" && param_00 != "zom_shelf_trial_destination") {
    var_02 thread run_weapon_trial_vision();
  }

  var_04 = [[var_03.var_3F02]]();
  var_03.var_8BE = 0;
  if(common_scripts\utility::func_562E(var_04)) {
    level.raven_trials_completed++;
  }

  if(isDefined(var_03.return_func)) {
    var_02[[var_03.return_func]]();
  } else {
    if(isDefined(var_02.old_destination.var_116)) {
      var_02 setorigin(var_02.old_destination.var_116);
    }

    if(isDefined(var_02.old_destination.var_1D)) {
      var_02 setangles(var_02.old_destination.var_1D);
    }
  }

  var_02.old_destination = undefined;
  var_02.isintrial = undefined;
  return common_scripts\utility::func_562E(var_04);
}

weapon_ritual_weapon_picked_up() {
  self waittill("picked_up_raven_weapon");
  self method_812A(1);
  self method_8323();
  self setclientomnvar("ui_hide_hud", 0);
}

run_weapon_trial_vision() {
  var_00 = self;
  var_00 notify("set_trial_vision");
  var_00 endon("set_trial_vision");
  var_00 altered_state_fade();
  var_01 = "dlc_zmb_dig02_hallucination_02";
  var_00.altered_state_fx = spawnlinkedfxforclient(common_scripts\utility::func_44F5(var_01), var_00, "tag_origin", var_00);
  triggerfx(var_00.altered_state_fx);
  var_00 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_00.altered_state_fx);
  var_00 setscriptmotionblurparams(3, 1, 0.5);
  while(isDefined(var_00.isintrial)) {
    wait 0.05;
  }

  var_00 altered_state_end_overlay(var_01, 1);
}

altered_state_fade() {
  var_00 = self;
  var_00 endon("disconnect");
  if(!isDefined(var_00.altered_state_overlay_fade)) {
    var_00.altered_state_overlay_fade = altered_state_create_client_overlay("white", 1, var_00);
  }

  var_01 = 1;
  var_02 = 0.25;
  var_00.altered_state_overlay_fade.var_18 = 0;
  var_00.altered_state_overlay_fade fadeovertime(var_01);
  var_00.altered_state_overlay_fade.var_18 = 1;
  var_00 lib_0378::func_8D74("dlc3_altered_state_fade");
  wait(var_01);
  var_00.altered_state_overlay_fade.var_18 = 1;
  var_00.altered_state_overlay_fade fadeovertime(var_02);
  var_00.altered_state_overlay_fade.var_18 = 0;
}

altered_state_create_client_overlay(param_00, param_01, param_02, param_03) {
  var_04 = 1;
  if(isDefined(param_03)) {
    var_04 = param_03;
  }

  if(isDefined(param_02)) {
    var_05 = newclienthudelem(param_02);
  } else {
    var_05 = newhudelem();
  }

  var_05.maxsightdistsqrd = 0;
  var_05.var_1D7 = 0;
  var_05 setshader(param_00, 640, 480);
  var_05.accuracy = "left";
  var_05.var_11 = "top";
  var_05.ignoreme = 1;
  var_05.var_C6 = "fullscreen";
  var_05.var_1CA = "fullscreen";
  var_05.var_18 = param_01;
  var_05.var_A0 = var_04;
  return var_05;
}

altered_state_end_overlay(param_00, param_01) {
  var_02 = self;
  var_02 endon("disconnect");
  if(isDefined(var_02.altered_state_fx)) {
    var_02.altered_state_fx delete();
  }

  var_02 setscriptmotionblurparams(1, 0, 1);
  var_02.in_altered_state = 0;
  var_02 method_8036(1, 1.5);
}

mark_zombies_in_trial(param_00, param_01) {
  var_02 = 256;
  if(param_01 == "zom_bonus_trial_destination") {
    var_02 = 850;
  }

  while(common_scripts\utility::func_562E(self.var_8BE)) {
    foreach(var_04 in lib_0547::func_408F()) {
      if(distance2d(var_04.var_116, param_00) > var_02) {
        continue;
      }

      if(abs(var_04.var_116[2] - param_00[2]) > var_02) {
        continue;
      }

      var_04.isintrial = param_01;
      var_04.var_6734 = 1;
    }

    wait 0.05;
  }
}

get_all_zombies_for_trial(param_00) {
  var_01 = [];
  foreach(var_03 in lib_0547::func_408F()) {
    if(lib_0547::func_5565(var_03.isintrial, param_00)) {
      var_01[var_01.size] = var_03;
    }
  }

  return var_01;
}

run_deathraven_trial() {
  var_00 = self;
  var_01 = common_scripts\utility::func_46B7("zone_lost_spawners_death_ce", "targetname");
  foreach(var_05, var_03 in var_01) {
    var_04 = lib_054D::func_90BA("zombie_dlc4", var_03, "bloodraven zombies", 0, 1, 0);
    var_04.isdeathravenwustling = 1;
    var_04.var_56E1 = 1;
    var_04.tauntindex = var_05;
    var_04 lib_0547::func_84CB();
    var_04 thread lib_0547::func_7D1A("ce_taunt");
  }

  var_00 waittill("picked_up_raven_weapon");
  level notify("free_the_CEs");
  foreach(var_04 in lib_0547::func_408F()) {
    if(common_scripts\utility::func_562E(var_04.isdeathravenwustling)) {
      var_04 maps\mp\zombies\zombie_corpse_eater::set_corpse_eater_full();
    }
  }

  wait_for_trial_zombies_clear();
  var_08 = common_scripts\utility::func_46B7("zone_lost_spawners_death", "targetname");
  foreach(var_03 in var_08) {
    var_04 = lib_054D::func_90BA("zombie_heavy", var_03, "bloodraven zombies", 0, 1, 0);
    playFX(level.var_611["zmb_deathscythe_proj_exp"], var_04.var_116 + (0, 0, 32));
    var_04 lib_0378::func_8D74("amooud_zmb_scythe_proj_impact");
    var_04.isdeathravenwustling = 1;
    wait(0.4);
  }

  wait_for_trial_zombies_clear();
  maps\mp\zquests\dlc4_trophies_mp_zombie_descent::complete_descent_trophy_event_7(var_00);
  wait(3);
  var_00 lib_0378::func_8D74("aud_deathraven_exit_trail");
  lib_0557::func_782D("quest_deathraven", "quest_deathraven_enter_trial");
  level.zmb_scythe_no_spawn = 0;
  return 1;
}

ce_taunt(param_00) {
  self endon("death");
  var_01 = "board_taunt";
  var_02 = maps\mp\agents\_scripted_agent_anim_util::func_434D(var_01, undefined, 1);
  var_03 = self.tauntindex;
  if(isDefined(var_02)) {
    maps\mp\agents\_scripted_agent_anim_util::func_8732(1, var_01);
    self method_839C("anim deltas");
    self scragentsetorientmode("face angle abs", self.var_1D);
    self scragentsetscripted(1);
    loop_my_taunt(var_02, var_03, 1, "taunt_anim");
  }
}

loop_my_taunt(param_00, param_01, param_02, param_03) {
  self endon("death");
  maps\mp\agents\_scripted_agent_anim_util::func_71FA(param_00, param_01, param_02, param_03);
}

ce_taunt_interrupt(param_00) {
  var_01 = "board_taunt";
  self scragentsetscripted(0);
  maps\mp\agents\_scripted_agent_anim_util::func_8732(0, var_01);
}

wait_for_trial_zombies_clear() {
  for(;;) {
    var_00 = 1;
    foreach(var_02 in lib_0547::func_4090("zombie_heavy")) {
      if(common_scripts\utility::func_562E(var_02.isdeathravenwustling)) {
        var_00 = 0;
      }
    }

    if(var_00) {
      break;
    }

    wait 0.05;
  }
}

run_moonraven_trial() {
  var_00 = self;
  var_01 = common_scripts\utility::func_46B5("moonraven_trial_flamewave", "targetname");
  var_00 waittill("picked_up_raven_weapon");
  wait(2);
  moonraven_trial_spawns();
  if(!common_scripts\utility::func_562E(self.has_shown_moon_trial_hint)) {
    self.has_shown_moon_trial_hint = 1;
    lib_0555::func_83DD("dlc4_trial_hint_moon", var_00);
  }

  moonraven_trial_star_warning();
  moonraven_trial_flamewave(var_01, 0);
  wait(2);
  moonraven_trial_spawns();
  moonraven_trial_star_warning();
  moonraven_trial_flamewave(var_01, 0);
  wait(2);
  common_scripts\utility::func_3C8F("moon_trial_complete");
  maps\mp\zquests\dlc4_trophies_mp_zombie_descent::complete_descent_trophy_event_5(var_00);
  var_00 lib_0378::func_8D74("aud_moonraven_exit_trail");
  stopclientexploder(236);
  lib_0557::func_782D("quest_moonraven", "quest_moonraven_enter_trial");
  return 1;
}

moonraven_trial_spawns() {
  var_00 = common_scripts\utility::func_46B7("zone_lost_spawners_moon", "targetname");
  foreach(var_02 in var_00) {
    var_03 = lib_054D::func_90BA("zombie_generic", var_02, "moonraven zombies", 0, 1, 1);
    var_03.ismoonravenwustling = 1;
    playFX(level.var_611["zmb_moonorb_tel_appear"], var_03.var_116 + (0, 0, 48));
    var_03 lib_0378::func_8D74("aud_moonorb_teleport");
    wait(0.4);
  }

  for(;;) {
    var_05 = 1;
    foreach(var_03 in lib_0547::func_4090("zombie_generic")) {
      if(common_scripts\utility::func_562E(var_03.ismoonravenwustling)) {
        var_05 = 0;
      }
    }

    if(var_05) {
      break;
    }

    wait 0.05;
  }
}

moonraven_trial_flamewave(param_00, param_01) {
  if(isDefined(param_01)) {
    wait(param_01);
  }

  if(isDefined(level.moon_orb_manager["moonscepter_owner"])) {
    level.moon_orb_manager["moonscepter_owner"] notify("moonorb_force_cooldown_reset");
  }

  var_02 = maps\mp\zombies\zombie_king::attack_flame_wave_spawn(param_00.var_116, undefined, 1);
  var_02 thread common_scripts\utility::func_2CB4(8, ::maps\mp\zombies\zombie_king::attack_flame_wave_stop);
  var_02 maps\mp\zombies\zombie_king::attack_flame_wave_wait_till_stopped();
  level notify("trial_stars_reset");
}

moonraven_trial_star_warning() {
  var_00 = getent("moonraven_trail_star_center", "targetname");
  var_01 = getEntArray("moonraven_trail_star_outer", "targetname");
  var_02 = 3;
  foreach(var_04 in var_01) {
    var_04.old_position = var_04.var_116;
    var_04 moveto(var_00.var_116, var_02, 0.2, 0.2);
  }

  wait(var_02);
  var_00 method_805C();
  foreach(var_04 in var_01) {
    var_04 method_805C();
  }

  var_08 = spawnfx(common_scripts\utility::func_44F5("zmb_desc_flame_wave_fireball"), var_00.var_116);
  triggerfx(var_08);
  var_08 lib_0378::func_8D74("aud_moonraven_trial_fire_strt");
  wait(1);
  thread stars_reset(var_08, var_01, var_00);
}

stars_reset(param_00, param_01, param_02) {
  level waittill("trial_stars_reset");
  param_00 delete();
  foreach(var_04 in param_01) {
    var_04 thread star_reset_and_show();
  }

  wait(0.6);
  param_02 method_805B();
}

star_reset_and_show() {
  var_00 = self;
  var_00 moveto(var_00.old_position, 0.5);
  wait(0.6);
  var_00 method_805B();
}

moonraven_trial_teleport_from_trial() {
  wait(2);
  var_00 = common_scripts\utility::func_46B5("struct_moon_orb_teleport_exit", "targetname");
  var_01 = self;
  var_01 endon("disconnect");
  playFX(level.var_611["zmb_moonorb_tel_disappear"], var_01.var_116 + (0, 0, 48));
  playFX(level.var_611["zmb_moonorb_suck"], var_00.var_116);
  var_01 lib_0378::func_8D74("aud_moonorb_teleport");
  var_01 maps\mp\zombies\weapons\_zombie_dlc4_melee::moon_orb_play_screen_fx();
  wait(0.25);
  if(isDefined(level.moon_orb_manager["moonscepter_orb_active"])) {
    level.moon_orb_manager["moonscepter_orb_active"] notify("moonorb_trial_end_stagnate");
  }

  waittillframeend;
  var_01 setorigin(var_00.var_116);
  var_01 setangles(var_00.var_1D);
  if(isDefined(self.wing_fx)) {
    thread maps\mp\zombies\zombie_king::spawn_wings();
  }

  playFX(level.var_611["zmb_moonorb_tel_appear"], var_01.var_116 + (0, 0, 48));
  var_01 childthread maps\mp\zombies\weapons\_zombie_dlc4_melee::record_landing_zone();
}

run_bloodraven_trial() {
  var_00 = self;
  var_00 endon("disconnect");
  var_00 endon("death");
  var_01 = common_scripts\utility::func_46B7("zone_lost_spawners_blood", "targetname");
  var_00 waittill("picked_up_raven_weapon");
  var_00 laststandrevive();
  var_00 lib_056A::cp_zmb_escape_init();
  var_00 do_blood_trial_phase(var_01);
  wait(1);
  var_00 do_blood_trial_phase(var_01);
  if(!lib_0557::func_783E("quest_bloodraven", "quest_bloodraven_enter_trial")) {
    lib_0557::func_782D("quest_bloodraven", "quest_bloodraven_enter_trial");
  }

  lib_0557::func_782D("quest_bloodraven", "quest_bloodraven_complete_trial");
  wait(2);
  return 1;
}

do_blood_trial_phase(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  var_01 endon("death");
  var_02 = 3;
  while(!level.blood_plates["trial"].isbloodfull) {
    var_03 = get_all_zombies_for_trial("zom_dlc4_shield_zm");
    if(isDefined(var_03) && var_03.size >= var_02) {
      wait(0.5);
      continue;
    }

    var_04 = lib_054D::func_90BA("zombie_generic", common_scripts\utility::func_7A33(param_00), "bloodraven zombies", 0, 1, 1);
    var_04.var_6816 = 1;
    playFX(level.var_611["gib_full_body"], var_04.var_116);
    playclientsound(level.var_2FDE["full"][lib_0547::func_4495()], undefined, var_04.var_116);
    wait(2);
  }

  wait(2);
  var_05 = common_scripts\utility::func_46B7("sun_attack_spawn", "targetname");
  var_05 = common_scripts\utility::func_F92(var_05);
  var_06 = var_05[0] common_scripts\utility::func_8FFC();
  var_06 method_805B();
  var_06 thread func_67F1("notify_sun_kill", 4);
  var_06 maps\mp\zombies\zombie_king::sun_attack_run();
  var_06 delete();
  level.blood_plates["trial"] maps\mp\mp_zombie_descent::blood_plate_empty();
}

bloodraven_exit_from_trial() {
  thread maps\mp\zombies\_zombies_blood_tubes::do_transport_rumble(5, 0);
  thread maps\mp\zombies\_zombies_blood_tubes::run_blood_intro(self getEye(), self getEye());
  wait(2);
  var_00 = common_scripts\utility::func_46B5("struct_bloodraven_trial_exit", "targetname");
  self setorigin(var_00.var_116, 1);
  self setangles(var_00.var_1D);
  playFX(level.var_611["gib_full_body"], self.var_116);
  wait(4);
  maps\mp\zquests\dlc4_trophies_mp_zombie_descent::complete_descent_trophy_event_6(self);
}

add_pap_time(param_00) {
  if(!isDefined(level.pap_timeout)) {
    level.pap_timeout = 0;
  }

  level.pap_timeout = level.pap_timeout + 25;
}

run_pack_a_punch_visit() {
  var_00 = self;
  if(!isDefined(level.pap_timeout) || isDefined(level.pap_timeout) && level.pap_timeout < 0) {
    level.pap_timeout = 0;
  }

  var_00.inasneakyplace = 1;
  var_00 childthread spawn_pap_zombies();
  if(level.pap_timeout < 10) {
    level.pap_timeout = 10;
  }

  level thread pap_timer();
  var_01 = common_scripts\utility::func_A70E(level, "pap_timeout", var_00, "death", var_00, "disconnect");
  var_02 = var_01[0];
  var_03 = var_01[1];
  if(lib_0547::func_5565(var_02, "pap_timeout")) {
    var_00.tryingtoleavepap = 1;
    foreach(var_05 in level.var_744A) {
      if(common_scripts\utility::func_562E(var_05.tryingtoleavepap) && lib_0547::func_5565(var_05 lib_055A::func_462D(), "zone_lost")) {
        if(!isDefined(var_05.hitchingaride) || isDefined(var_05.hitchingaride) && !var_05.hitchingaride) {
          var_05.hitchingaride = 1;
        }
      }
    }
  } else if(lib_0547::func_5565(var_02, "death")) {
    var_00.tryingtoleavepap = 0;
    var_00.hitchingaride = 0;
  }

  var_00.inasneakyplace = 0;
  return 1;
}

pap_timer() {
  level notify("pap_timer_start");
  level endon("pap_timer_start");
  while(level.pap_timeout > 0) {
    wait(1);
    level.pap_timeout--;
  }

  level notify("pap_timeout");
}

spawn_pap_zombies() {
  if(!isDefined(level.pap_zombies)) {
    level.pap_zombies = [];
  }

  pap_register_killed_func();
  var_00 = common_scripts\utility::func_46B7("zone_lost_spawners", "targetname");
  foreach(var_02 in var_00) {
    var_02.var_8C95 = 1;
    var_02.ignorehidingskyspawner = 1;
  }

  wait(0.5);
  for(var_04 = level.pap_zombies.size; var_04 < 4; var_04++) {
    wait(randomfloatrange(0.05, 0.25));
    var_05 = spawn_pap_zombie(var_00);
  }
}

pap_register_killed_func() {
  var_00 = ::clear_pap_zombie_on_death;
  if(!isDefined(level.pap_zombie)) {
    foreach(var_02 in level.var_376B) {
      if(var_02 == var_00) {
        return;
      }
    }
  }

  lib_0547::func_7BA9(var_00);
}

spawn_pap_zombie(param_00) {
  var_01 = lib_054D::func_90BA("zombie_generic", common_scripts\utility::func_7A33(param_00), "pap zpmbies", 0, 1, 1);
  if(!isDefined(var_01)) {
    return undefined;
  }

  var_01.ispapzombie = 1;
  level.pap_zombies[level.pap_zombies.size] = var_01;
  var_01 thread track_pap_zone();
  var_01 lib_0547::func_84CB();
  return var_01;
}

track_pap_zone() {
  self endon("death");
  var_00 = getent("zone_lost", "targetname");
  self waittill("zombie_fall_impact");
  while(self istouching(var_00) || !common_scripts\utility::func_562E(self.var_4BA0)) {
    wait 0.05;
  }

  self.ispapzombie = 0;
  level.pap_zombies = common_scripts\utility::func_F93(level.pap_zombies, self);
}

clear_pap_zombie_on_death(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(lib_0547::func_5565(self.ispapzombie, 1)) {
    level.pap_zombies = common_scripts\utility::func_F93(level.pap_zombies, self);
  }

  if(!isDefined(level.pap_zombies) || level.pap_zombies.size < 0) {
    lib_0547::func_2D8C(::clear_pap_zombie_on_death);
  }
}

__________________stormraven__________________() {}

stormraven_init_quest() {
  thread stormraven_init_flags();
  thread stormraven_init_debug();
  thread stormraven_uber_init();
  thread stormraven_lightning_rod_init();
  thread stormraven_find_trial_init();
  thread stormraven_charge_puzzle_blocks_init();
}

stormraven_init_flags() {
  common_scripts\utility::func_3C87("flag_stormraven_stopper_1_collected");
  common_scripts\utility::func_3C87("flag_stormraven_stopper_2_collected");
  common_scripts\utility::func_3C87("flag_stormraven_stopper_3_collected");
  common_scripts\utility::func_3C87("flag_stormraven_stopper_4_collected");
  common_scripts\utility::func_3C87("flag_stormraven_stoppers_placed");
  common_scripts\utility::func_3C87("flag_stormraven_runes_charged");
  common_scripts\utility::func_3C87("flag_stormraven_uber_charged");
  common_scripts\utility::func_3C87("flag_stormraven_hammer_sneaking_complete");
  common_scripts\utility::func_3C87("flag_stormraven_hammer_tethered");
  common_scripts\utility::func_3C87("flag_stormraven_hammer_rod_one_complete");
  common_scripts\utility::func_3C87("flag_stormraven_hammer_rod_two_complete");
  common_scripts\utility::func_3C87("flag_stormraven_hammer_rod_three_complete");
  common_scripts\utility::func_3C87("flag_stormraven_hammer_rod_four_complete");
  common_scripts\utility::func_3C87("flag_stormraven_hammer_picked_up");
  common_scripts\utility::func_3C87("flag_stormraven_charge_puzzle_activated");
  common_scripts\utility::func_3C87("flag_stormraven_special_rune_charged");
  common_scripts\utility::func_3C87("flag_stormraven_charge_puzzle_stage_one_complete");
  common_scripts\utility::func_3C87("flag_stormraven_charge_puzzle_stage_two_complete");
  common_scripts\utility::func_3C87("flag_stormraven_charge_puzzle_stage_three_complete");
  common_scripts\utility::func_3C87("flag_stormraven_trial_ascension_complete");
  common_scripts\utility::func_3C87("flag_stormraven_trial_completed");
}

stormraven_init_debug() {}

_____summon_hammer_____() {}

stormraven_summon_hammer_main() {
  thread stormraven_summon_hammer_init();
  common_scripts\utility::func_3C9F("flag_stormraven_stoppers_placed");
  thread stormraven_charge_rune_soulbucket_init();
  common_scripts\utility::func_3C9F("flag_stormraven_runes_charged");
  thread stormraven_hammer_summon();
  iprintlnbold("Summon Hammer - Step Complete!");
  lib_0557::func_782D("quest_stormraven", "step_stormraven_chase_hammer");
}

stormraven_summon_hammer_init() {
  var_00 = common_scripts\utility::func_46B7("stormraven_bloodstopper_object", "targetname");
  level.bloodstoppersininventory = 0;
  level.bloodstopperscollected = 0;
  stormraven_bloodstopper_choose(var_00);
  foreach(var_02 in var_00) {
    var_02 thread stormraven_bloodstopper_init();
  }

  var_04 = getEntArray("stormraven_bloodfall_trigger", "targetname");
  foreach(var_06 in var_04) {
    var_06 thread stormraven_bloodfall_init();
  }

  var_08 = getEntArray("stormraven_charge_rune", "targetname");
  foreach(var_0A in var_08) {
    var_0A thread stormraven_charge_rune_init();
  }
}

stormraven_bloodstopper_choose(param_00) {
  var_01 = 0;
  while(var_01 < 4) {
    var_02 = common_scripts\utility::func_7A33(param_00);
    var_02.ischosen = 1;
    var_01++;
    param_00 = common_scripts\utility::func_F93(param_00, var_02);
    wait 0.05;
  }
}

stormraven_bloodstopper_init() {
  var_00 = getEntArray(self.var_1A2, "targetname");
  foreach(var_02 in var_00) {
    switch (var_02.var_165) {
      case "stormraven_bloodstopper_trigger":
        self.usetrigger = var_02;
        break;

      case "stormraven_bloodstopper_model":
        self.stoppermodel = var_02;
        self.stoppermodel method_805C();
        break;
    }
  }

  if(common_scripts\utility::func_562E(self.ischosen)) {
    self.stoppermodel method_805B();
    thread stormraven_bloodstopper_pickup();
  }
}

stormraven_bloodstopper_pickup() {
  for(;;) {
    self.usetrigger waittill("trigger", var_00);
    if(bullettracepassed(var_00 getEye(), self.var_116, 0, self.stoppermodel)) {
      self.usetrigger lib_0378::func_8D74("aud_stormraven_bloodstopper_pickup");
      level.bloodstoppersininventory++;
      level.bloodstopperscollected++;
      common_scripts\utility::func_3C8F("flag_stormraven_stopper_" + common_scripts\utility::func_9AAD(level.bloodstopperscollected) + "_collected");
      self.usetrigger delete();
      self.stoppermodel delete();
      break;
    }
  }
}

stormraven_bloodstopper_place() {
  level.stoppersplaced = 0;
  while(level.stoppersplaced < 4) {
    self waittill("trigger");
    if(level.bloodstoppersininventory > 0) {
      level.bloodstoppersininventory--;
      self.stoppermodel lib_0378::func_8D74("aud_stormraven_bloodstopper_place");
      lib_0378::func_8D74("aud_stop_stormraven_bloodfall");
      self.stoppermodel method_805B();
      wait(0.5);
      self.stoppermodel movez(-8, 1, 0.25, 0.75);
      wait(1);
      self.bfall_fx delete();
      self.var_3F76 delete();
      level.stoppersplaced++;
      break;
    }
  }

  if(level.stoppersplaced >= 4) {
    common_scripts\utility::func_3C8F("flag_stormraven_stoppers_placed");
  }
}

stormraven_bloodfall_init() {
  self.stoppermodel = getent(self.var_1A2, "targetname");
  self.stoppermodel method_805C();
  self.stoppermodel notsolid();
  var_00 = common_scripts\utility::func_46B7(self.var_1A2, "targetname");
  foreach(var_02 in var_00) {
    switch (var_02.var_165) {
      case "stormraven_bloodfall_rune":
        self.rune = var_02;
        self.runeid = randomintrange(0, 4);
        self.runemagnitude = randomintrange(1, 2);
        break;

      case "stormraven_bloodfall_fx_org":
        self.var_3F76 = spawn("script_model", var_02.var_116);
        self.var_3F76 setModel("tag_origin");
        self.bfall_fx = spawnfx(common_scripts\utility::func_44F5("zmb_desc_blood_wfall_bridge_s"), self.var_3F76.var_116, anglesToForward(self.var_1D));
        lib_0378::func_8D74("aud_stormraven_bloodfall");
        triggerfx(self.bfall_fx);
        break;
    }
  }

  thread stormraven_bloodstopper_place();
  thread stormraven_bloodfall_rune_spawn();
  thread stormraven_charge_rune_determine_order();
  thread debug_draw_rune_order_run();
}

stormraven_bloodfall_rune_spawn() {
  self.runemodel = spawn("script_model", self.rune.var_116);
  self.runemodel.var_1D = self.rune.var_1D;
  switch (self.runeid) {
    case 0:
      self.runemodel setModel("zmd_runes_objects_04c");
      break;

    case 1:
      self.runemodel setModel("zmd_runes_objects_05c");
      break;

    case 2:
      self.runemodel setModel("zmd_runes_objects_13c");
      break;

    case 3:
      self.runemodel setModel("zmd_runes_objects_20c");
      break;
  }
}

stormraven_charge_rune_init() {
  level endon("stormraven_hammer_summoned");
  switch (self.var_165) {
    case "rune_a":
      self.runeid = 0;
      break;

    case "rune_b":
      self.runeid = 1;
      break;

    case "rune_c":
      self.runeid = 2;
      break;

    case "rune_d":
      self.runeid = 3;
      break;
  }
}

stormraven_charge_rune_determine_order() {
  switch (self.rune.var_8260) {
    case "rune_a":
      level.bloodfallrune[0] = spawnStruct();
      level.bloodfallrune[0].runeid = self.runeid;
      level.bloodfallrune[0].runemagnitude = self.runemagnitude;
      break;

    case "rune_b":
      level.bloodfallrune[1] = spawnStruct();
      level.bloodfallrune[1].runeid = self.runeid;
      level.bloodfallrune[1].runemagnitude = self.runemagnitude;
      break;

    case "rune_c":
      level.bloodfallrune[2] = spawnStruct();
      level.bloodfallrune[2].runeid = self.runeid;
      level.bloodfallrune[2].runemagnitude = self.runemagnitude;
      break;

    case "rune_d":
      level.bloodfallrune[3] = spawnStruct();
      level.bloodfallrune[3].runeid = self.runeid;
      level.bloodfallrune[3].runemagnitude = self.runemagnitude;
      break;
  }

  if(level.bloodfallrune.size >= 4) {
    iprintlnbold(level.bloodfallrune[0].runeid + level.bloodfallrune[1].runeid + level.bloodfallrune[2].runeid + level.bloodfallrune[3].runeid);
  }
}

stormraven_charge_rune_soulbucket_init() {
  var_00 = getEntArray("stormraven_charge_rune", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread stormraven_make_rune_glow();
    var_02 thread stormraven_charge_rune_cleanup();
    var_02 thread stormraven_charge_rune_soulbucket();
  }

  thread stormraven_charge_rune_soulbucket_check_order();
}

stormraven_charge_rune_soulbucket() {
  level endon("stormraven_runes_charged");
  self.disable_end_sound = 1;
  var_00 = undefined;
  for(;;) {
    switch (self.runeid) {
      case 0:
        var_00 = "stormraven_charge_rune_a";
        childthread maps\mp\mp_zombies_soul_collection::func_170B(1, 75, 50, var_00, undefined, "tag_origin", undefined, undefined, undefined, undefined, (0, 0, 32), undefined, undefined, undefined, 1);
        break;

      case 1:
        var_00 = "stormraven_charge_rune_b";
        childthread maps\mp\mp_zombies_soul_collection::func_170B(1, 75, 50, var_00, undefined, "tag_origin", undefined, undefined, undefined, undefined, (0, 0, 32), undefined, undefined, undefined, 1);
        break;

      case 2:
        var_00 = "stormraven_charge_rune_c";
        childthread maps\mp\mp_zombies_soul_collection::func_170B(1, 75, 50, var_00, undefined, "tag_origin", undefined, undefined, undefined, undefined, (0, 0, 32), undefined, undefined, undefined, 1);
        break;

      case 3:
        var_00 = "stormraven_charge_rune_d";
        childthread maps\mp\mp_zombies_soul_collection::func_170B(1, 75, 50, var_00, undefined, "tag_origin", undefined, undefined, undefined, undefined, (0, 0, 32), undefined, undefined, undefined, 1);
        break;
    }

    level waittill(var_00);
  }
}

stormraven_charge_rune_soulbucket_check_order() {
  var_00 = 0;
  var_01 = 0;
  var_02 = 0;
  for(;;) {
    var_03 = level common_scripts\utility::func_A715("stormraven_charge_rune_a", "stormraven_charge_rune_b", "stormraven_charge_rune_c", "stormraven_charge_rune_d");
    switch (var_03) {
      case "stormraven_charge_rune_a":
        var_02 = 0;
        break;

      case "stormraven_charge_rune_b":
        var_02 = 1;
        break;

      case "stormraven_charge_rune_c":
        var_02 = 2;
        break;

      case "stormraven_charge_rune_d":
        var_02 = 3;
        break;
    }

    if(var_02 == level.bloodfallrune[var_00].runeid) {
      var_01++;
    } else {
      var_00 = 0;
      var_01 = 0;
      continue;
    }

    if(var_01 > level.bloodfallrune[var_00].runemagnitude) {
      var_00 = 0;
      var_01 = 0;
      continue;
    }

    if(var_01 == level.bloodfallrune[var_00].runemagnitude) {
      var_00++;
      var_01 = 0;
    }

    if(var_00 >= 4) {
      break;
    }

    wait 0.05;
  }

  level notify("stormraven_runes_charged");
  var_04 = common_scripts\utility::func_46B5("stormraven_summon_hammer_strike_position", "targetname");
  var_05 = 0;
  var_06 = 2;
  while(var_05 < 15) {
    var_07 = randomfloatrange(var_04.var_116[0] - 20, var_04.var_116[0] + 20);
    var_08 = randomfloatrange(var_04.var_116[1] - 20, var_04.var_116[1] + 20);
    var_09 = var_04.var_116[2];
    var_0A = (var_07, var_08, var_09);
    thread stormraven_lightning_strike(var_0A);
    var_05++;
    if(var_06 > 0.25) {
      var_06 = var_06 - 0.25;
    }

    wait(var_06);
  }

  thread stormraven_lightning_strike(var_04.var_116);
  thread stormraven_lightning_strike(var_04.var_116);
  thread stormraven_lightning_strike(var_04.var_116);
  thread stormraven_lightning_strike(var_04.var_116);
  var_0B = lib_0547::func_408F();
  if(isDefined(var_0B) && var_0B.size > 0) {
    foreach(var_0D in var_0B) {
      if(distancesquared(var_04.var_116, var_0D.var_116) < 10000) {
        var_0D lib_0547::func_5A85(var_0D.var_116, var_04.var_116 - var_0D.var_116);
      }
    }

    physicsexplosionsphere(var_04.var_116, 250, 150, 4);
  }

  common_scripts\utility::func_3C8F("flag_stormraven_runes_charged");
}

stormraven_charge_rune_cleanup() {
  level waittill("stormraven_runes_charged");
  level.var_8E3 = common_scripts\utility::func_F93(level.var_8E3, self);
}

stormraven_hammer_summon() {
  var_00 = common_scripts\utility::func_46B5("stormraven_hammer_spawn_location", "targetname");
  level.stormhammer = spawn("script_model", var_00.var_116);
  level.stormhammer setModel("npc_gen_sledgehammer_zom");
  level.stormhammer.var_3F76 = spawn("script_model", var_00.var_116);
  level.stormhammer.var_3F76 setModel("tag_origin");
  level.stormhammer.var_3F76 method_8449(level.stormhammer);
  playFXOnTag(common_scripts\utility::func_44F5("zmb_storm_hammer_charge"), level.stormhammer.var_3F76, "tag_origin");
  var_01 = getent("hammer_tether_location", "targetname");
  level.hammerlocation = var_01;
  level.stormhammer lib_0378::func_8D74("aud_stormraven_warhammer_spawn");
  level notify("stormraven_hammer_summoned");
}

debug_give_bloodstoppers() {
  level.bloodstoppersininventory = 4;
}

debug_draw_rune_order() {
  level notify("debug_stormraven_draw_rune_order");
}

debug_draw_rune_order_run() {
  level waittill("debug_stormraven_draw_rune_order");
  for(;;) {
    switch (self.runeid) {
      case 0:
        break;

      case 1:
        break;

      case 2:
        break;

      case 3:
        break;
    }

    wait 0.05;
  }
}

warp_summon_hammer() {
  common_scripts\utility::func_3C8F("flag_stormraven_stoppers_placed");
  common_scripts\utility::func_3C8F("flag_stormraven_runes_charged");
}

_____capture_hammer_____() {}

stormraven_capture_hammer_main() {
  thread stormraven_sneaking_init();
  common_scripts\utility::func_3C9F("flag_stormraven_hammer_sneaking_complete");
  thread stormraven_flee_init();
  common_scripts\utility::func_3C9F("flag_stormraven_hammer_tethered");
  thread stormraven_hammer_pickup();
  common_scripts\utility::func_3C9F("flag_stormraven_hammer_picked_up");
  iprintlnbold("Capture Hammer - Step Complete!");
  lib_0557::func_782D("quest_stormraven", "step_stormraven_capture_hammer");
}

stormraven_sneaking_init() {
  if(common_scripts\utility::func_3C77("flag_stormraven_hammer_tethered")) {
    return;
  }

  var_00 = getent("stormhammer_sneak_trigger", "targetname");
  var_00 enablelinkto();
  if(isDefined(level.stormhammer)) {
    var_00 method_8449(level.stormhammer);
  }

  var_00 thread stormraven_sneaking_start_sneak_check();
  var_01 = getent("stormhammer_disable_tp_trigger", "targetname");
  var_01 enablelinkto();
  if(isDefined(level.stormhammer)) {
    var_01 method_8449(level.stormhammer);
  }

  var_01 thread stormraven_sneaking_hammer_teleport_disable();
  thread stormraven_sneaking_hammer_teleport();
}

stormraven_sneaking_start_sneak_check() {
  level endon("stormraven_hammer_teleport_disabled");
  for(;;) {
    self waittill("trigger", var_00);
    if(!isPlayer(var_00)) {
      continue;
    }

    var_00 thread stormraven_sneaking_check_sneak_success(self);
  }
}

stormraven_sneaking_check_sneak_success(param_00) {
  level endon("stormraven_sneaking_failed");
  level endon("stormraven_hammer_teleport_disabled");
  for(;;) {
    var_01 = stormraven_sneaking_check_sneaking_radius(param_00);
    if(!common_scripts\utility::func_562E(var_01)) {
      break;
    }

    var_02 = stormraven_sneaking_check_sneaking_status();
    if(!common_scripts\utility::func_562E(var_02)) {
      self.sneaky = 0;
      level notify("stormraven_sneaking_failed");
    }

    self.sneaky = 1;
    wait 0.05;
  }

  self.issneaking = 0;
}

stormraven_sneaking_check_sneaking_radius(param_00) {
  if(self istouching(param_00)) {
    return 1;
  }

  return 0;
}

stormraven_sneaking_check_sneaking_status() {
  var_00 = self getstance();
  if(var_00 == "stand") {
    return 0;
  }

  var_01 = self method_8127();
  if(var_01) {
    return 0;
  }

  var_02 = self getvelocity();
  var_03 = 60;
  var_04 = squared(var_03);
  var_05 = vectordot(var_02, var_02);
  if(var_05 > var_04) {
    return 0;
  }

  return 1;
}

stormraven_sneaking_hammer_teleport() {
  level.hammerlocation = common_scripts\utility::func_46B5("stormraven_hammer_spawn_location", "targetname");
  var_00 = common_scripts\utility::func_46B5("stormraven_hammer_spawn_location", "targetname");
  for(;;) {
    level waittill("stormraven_sneaking_failed");
    var_01 = common_scripts\utility::func_46B7("stormraven_hammer_tp_location", "targetname");
    while(level.hammerlocation == var_00) {
      var_00 = common_scripts\utility::func_7A33(var_01);
    }

    playFX(common_scripts\utility::func_44F5("zmb_storm_hammer_teleport_flash"), level.stormhammer.var_116);
    lib_0378::func_8D74("aud_stormraven_warhammer_tp_out", level.stormhammer.var_116);
    level.stormhammer.var_116 = var_00.var_116;
    playFX(common_scripts\utility::func_44F5("zmb_storm_hammer_teleport_flash"), level.stormhammer.var_116);
    lib_0378::func_8D74("aud_stormraven_warhammer_tp_in", level.stormhammer.var_116);
    level.hammerlocation = var_00;
    physicsexplosionsphere(level.stormhammer.var_116, 150, 50, 2);
    wait 0.05;
  }
}

stormraven_sneaking_hammer_teleport_disable() {
  for(;;) {
    self waittill("trigger", var_00);
    if(common_scripts\utility::func_562E(var_00.sneaky)) {
      break;
    }
  }

  level notify("stormraven_hammer_teleport_disabled");
  common_scripts\utility::func_3C8F("flag_stormraven_hammer_sneaking_complete");
}

stormraven_flee_init() {
  if(common_scripts\utility::func_3C77("flag_stormraven_hammer_tethered")) {
    return;
  }

  var_00 = common_scripts\utility::func_46B7("hammer_flee_location", "script_noteworthy");
  var_01 = common_scripts\utility::func_4461(level.stormhammer.var_116, var_00, 200);
  level.hammerlocation = var_01;
  var_02 = getent("stormraven_hammer_impact_trigger", "targetname");
  var_02 enablelinkto();
  var_02 method_8449(level.stormhammer);
  var_02 thread stormraven_flee_knockback();
  var_03 = getent("stormhammer_sneak_trigger", "targetname");
  var_03 thread stormraven_flee_detect_player();
  level.stormhammer thread lib_0378::func_8D74("aud_stormraven_warhammer_steady_mvmt");
}

stormraven_flee_detect_player() {
  level endon("stormraven_hammer_tethered");
  for(;;) {
    self waittill("trigger", var_00);
    if(!isPlayer(var_00)) {
      continue;
    }

    var_00 stormraven_flee_go_to_destination();
  }
}

stormraven_flee_go_to_destination() {
  var_00 = stormraven_flee_get_destination();
  level.stormhammer lib_0378::func_8D74("aud_stormraven_warhammer_burst_mvmt");
  while(isDefined(var_00.var_8260) && var_00.var_8260 == "transition_point") {
    stormraven_flee_orient_and_move(var_00);
    var_00 = stormraven_flee_get_destination(1);
    wait 0.05;
  }

  stormraven_flee_orient_and_move(var_00);
  if(!isDefined(level.stormhammerhasmoved)) {
    level.stormhammerhasmoved = 1;
  }
}

stormraven_flee_get_destination(param_00) {
  var_01 = common_scripts\utility::func_46B7("hammer_flee_location", "script_noteworthy");
  var_02 = [];
  if(isDefined(level.hammerlocation.var_1A2)) {
    if(level.hammerlocation.var_1A2.size > 2) {
      var_02 = common_scripts\utility::func_46B7(level.hammerlocation.var_1A2, "targetname");
    }
  } else {
    var_03 = [];
    foreach(var_05 in var_01) {
      var_06 = sighttracepassed(level.hammerlocation.var_116, var_05.var_116, 0, level.stormhammer);
      if(var_06) {
        var_03 = common_scripts\utility::func_F6F(var_03, var_05);
      }
    }

    if(common_scripts\utility::func_F79(var_03, level.hammerlocation)) {
      var_03 = common_scripts\utility::func_F93(var_03, level.hammerlocation);
    }

    while(var_02.size < 2) {
      var_08 = 500000;
      var_09 = undefined;
      foreach(var_05 in var_03) {
        var_0B = distance(level.hammerlocation.var_116, var_05.var_116);
        if(var_0B >= var_08) {
          continue;
        }

        var_08 = var_0B;
        var_09 = var_05;
      }

      if(isDefined(var_09)) {
        var_02 = common_scripts\utility::func_F6F(var_02, var_09);
        var_03 = common_scripts\utility::func_F93(var_03, var_09);
      }
    }
  }

  if(common_scripts\utility::func_562E(param_00)) {
    if(isDefined(level.previoushammerposition)) {
      if(common_scripts\utility::func_F79(var_02, level.previoushammerposition)) {
        var_02 = common_scripts\utility::func_F93(var_02, level.previoushammerposition);
      }
    }
  }

  var_0D = level.hammerlocation.var_116 - self.var_116;
  if(!isDefined(level.previoushammerposition)) {
    level.previoushammerposition = level.hammerlocation;
  }

  var_0E = 10000000;
  var_0F = undefined;
  foreach(var_05 in var_02) {
    var_11 = var_05.var_116 - level.hammerlocation.var_116;
    common_scripts\utility::func_33BA(level.hammerlocation.var_116, var_05.var_116, 1, 0, 0, 6);
    if(common_scripts\utility::func_562E(param_00)) {
      common_scripts\utility::func_33BA(level.previoushammerposition.var_116, level.hammerlocation.var_116, 0, 0, 1, 6);
      var_12 = level.hammerlocation.var_116 - level.previoushammerposition.var_116;
      var_13 = var_11 - var_12;
    } else {
      common_scripts\utility::func_33BA(self.var_116, level.hammerlocation.var_116, 0, 0, 1, 6);
      var_13 = var_11 - var_0D;
    }

    var_14 = vectordot(var_13, var_13);
    if(var_14 >= var_0E) {
      continue;
    }

    var_0E = var_14;
    var_0F = var_05;
  }

  level.previoushammerposition = level.hammerlocation;
  return var_0F;
}

stormraven_flee_orient_and_move(param_00) {
  var_01 = 325;
  var_02 = 0;
  if(isDefined(level.hammerlocation.var_1A5) && level.hammerlocation.var_1A5 == "hammer_tether_location" && common_scripts\utility::func_562E(level.stormhammerhasmoved)) {
    if(common_scripts\utility::func_3C77("flag_stormraven_hammer_rod_one_complete")) {
      var_02++;
    }

    if(common_scripts\utility::func_3C77("flag_stormraven_hammer_rod_two_complete")) {
      var_02++;
    }

    if(common_scripts\utility::func_3C77("flag_stormraven_hammer_rod_three_complete")) {
      var_02++;
    }

    if(common_scripts\utility::func_3C77("flag_stormraven_hammer_rod_four_complete")) {
      var_02++;
    }

    level notify("stormraven_hammer_in_tether_position");
    if(var_02 > 0) {
      var_01 = var_01 / var_02 * 4;
    }
  }

  var_03 = distance(param_00.var_116, level.hammerlocation.var_116) / var_01;
  if(var_03 <= 0) {
    return;
  }

  var_04 = param_00.var_116 - level.stormhammer.var_116;
  var_05 = vectortoangles(var_04);
  common_scripts\utility::func_33BA(level.stormhammer.var_116, param_00.var_116, 0, 1, 1, 6);
  level.stormhammer.var_1D = var_05 + (90, 0, 0);
  level.stormhammer moveto(param_00.var_116, var_03);
  wait(var_03);
  if(var_02 >= 4) {
    level.stormhammer moveto(level.hammerlocation.var_116, 0.25);
    wait(0.25);
    level.stormhammer rotateto((0, 0, 0), 0.25);
    wait(0.25);
    return;
  }

  level.previoushammerposition = level.hammerlocation;
  level.hammerlocation = param_00;
}

stormraven_flee_knockback() {
  level endon("stormraven_hammer_tethered");
  for(;;) {
    self waittill("trigger", var_00);
    if(isPlayer(var_00)) {
      var_00 lib_0547::func_7419(level.stormhammer.var_116, 100);
      continue;
    }

    if(function_01EF(var_00)) {
      var_01 = level.stormhammer.var_116;
      var_00 lib_0547::func_5A85(var_00.var_116 + (0, 0, 16), level.stormhammer.var_116 - var_00.var_116 + (0, 0, 16));
      waittillframeend;
      physicsexplosionsphere(var_01, 100, 50, 1);
    }
  }
}

stormraven_uber_init() {
  var_00 = common_scripts\utility::func_46B5("stormraven_wreckage_uber", "targetname");
  var_01 = spawn("script_model", var_00.var_116);
  var_01 setModel("npc_zom_uber_01");
  var_01.var_9D65 = getent("stormraven_wreckage_uber_trigger", "targetname");
  var_01.var_9D65 waittill("trigger", var_02);
  var_02 thread lib_0585::func_8555("stormraven_uber");
  level notify("player grabbed uber battery");
  var_02 thread lib_0585::func_3481("stormraven_uber");
  var_01 delete();
  stormraven_uber_place();
}

stormraven_uber_place() {
  var_00 = getent("stormraven_uber_place_trigger", "targetname");
  for(;;) {
    var_00 waittill("trigger", var_01);
    var_00 lib_0378::func_8D74("aud_stormraven_uberschnell_place");
    if(common_scripts\utility::func_562E(var_01.var_56A5)) {
      var_01 notify("uber_deposited");
      var_02 = common_scripts\utility::func_46B5("stormraven_uber_place_spawner", "targetname");
      var_03 = spawn("script_model", var_02.var_116);
      var_03 setModel("zmb_gp_uber_01");
      var_04 = common_scripts\utility::func_8FFC();
      var_04.var_116 = var_03.var_116 + (0, 0, 17);
      var_04 maps\mp\mp_zombies_soul_collection::beginazombiesoulcollectionobjectiveonstruct(15, 200, 100, "stormraven_uber", undefined, "tag_origin", "zmb_desc_storm_uber_charge_tip", undefined, undefined, undefined, (0, 0, 32));
      common_scripts\utility::func_3C8F("flag_stormraven_uber_charged");
      var_04 delete();
      var_05 = spawnfx(level.var_611["zmb_desc_storm_uber_charge"], var_03.var_116, anglesToForward(var_03.var_1D));
      triggerfx(var_05);
      break;
    }
  }
}

stormraven_lightning_rod_init() {
  var_00 = getEntArray("stormraven_lightning_rod", "script_noteworthy");
  var_00 = common_scripts\utility::func_F73(var_00, getEntArray("stormraven_lightning_rod_top", "script_noteworthy"));
  var_00 = common_scripts\utility::func_F73(var_00, getEntArray("stormraven_lightning_rod_middle_top", "script_noteworthy"));
  var_00 = common_scripts\utility::func_F73(var_00, getEntArray("stormraven_lightning_rod_middle_bottom", "script_noteworthy"));
  var_00 = common_scripts\utility::func_F73(var_00, getEntArray("stormraven_lightning_rod_bottom", "script_noteworthy"));
  foreach(var_02 in var_00) {
    var_02 movez(-300, 0.05);
  }

  common_scripts\utility::func_3CA0("flag_stormraven_runes_charged", "flag_stormraven_uber_charged");
  var_04 = 6;
  foreach(var_02 in var_00) {
    var_02 movez(300, var_04, 0, 1);
    var_02 lib_0378::func_8D74("aud_stormraven_lightning_rod_ascend", var_04, var_02.var_116);
  }

  var_07 = getEntArray("stormraven_lightning_rod", "script_noteworthy");
  foreach(var_09 in var_07) {
    thread play_earthquake(0.2, var_04 * 1.25, var_09.var_116, 500);
  }

  wait(var_04);
  foreach(var_09 in var_07) {
    thread play_earthquake(0.3, 0.5, var_09.var_116, 500);
    var_09 thread rumble_nearby_players(0.5, 500);
  }

  maps\mp\mp_zombie_descent_lighting::lightningrodlights();
  var_0D = getEntArray("stormraven_lighting_rod_object", "script_noteworthy");
  for(var_0E = 0; var_0E < var_0D.size; var_0E++) {
    var_0D[var_0E].rodid = var_0E;
    switch (var_0E) {
      case 0:
        var_0D[var_0E].completeflag = "flag_stormraven_hammer_rod_one_complete";
        break;

      case 1:
        var_0D[var_0E].completeflag = "flag_stormraven_hammer_rod_two_complete";
        break;

      case 2:
        var_0D[var_0E].completeflag = "flag_stormraven_hammer_rod_three_complete";
        break;

      case 3:
        var_0D[var_0E].completeflag = "flag_stormraven_hammer_rod_four_complete";
        break;
    }

    var_0D[var_0E] thread stormraven_lightning_rod_puzzle_init();
  }

  thread stormraven_lightning_rod_tether_hammer(var_0D);
  thread stormraven_lightning_rod_completion();
}

stormraven_lightning_rod_puzzle_init() {
  var_00 = getEntArray(self.var_1A2, "targetname");
  foreach(var_02 in var_00) {
    if(var_02.var_165 == "stormraven_lightning_rod") {
      continue;
    }

    switch (var_02.var_165) {
      case "stormraven_lightning_rod_top":
        self.topblock = var_02;
        break;

      case "stormraven_lightning_rod_middle_top":
        self.middletopblock = var_02;
        break;

      case "stormraven_lightning_rod_middle_bottom":
        self.middlebottomblock = var_02;
        break;

      case "stormraven_lightning_rod_bottom":
        self.bottomblock = var_02;
        break;
    }

    if(isDefined(var_02.var_8260) && var_02.var_8260 == "shuffled") {
      var_02.rotatestate = randomintrange(1, 4);
      if(var_02.rotatestate == 1) {
        var_02 rotateyaw(90, 0.05);
      }

      if(var_02.rotatestate == 2) {
        var_02 rotateyaw(180, 0.05);
      }

      if(var_02.rotatestate == 3) {
        var_02 rotateyaw(270, 0.05);
      }
    } else {
      var_02.rotatestate = 0;
    }

    var_02 thread stormraven_lightning_rod_block_rotation(self);
  }

  if(self.topblock.rotatestate == 0 && self.middletopblock.rotatestate == 0 && self.middlebottomblock.rotatestate == 0 && self.bottomblock.rotatestate == 0) {
    common_scripts\utility::func_3C8F(self.completeflag);
  }

  thread stormraven_lightning_rod_glow_state(var_00);
}

stormraven_lightning_rod_block_rotation(param_00) {
  level endon("stormraven_hammer_tethered");
  level.stormravenblockisrotating = 0;
  self setCanDamage(1);
  level.stormravenblockrotatetime = 1;
  for(;;) {
    self waittill("damage", var_01, var_02);
    if(!isPlayer(var_02)) {
      continue;
    }

    if(level.stormravenblockisrotating) {
      continue;
    }

    level.stormravenblockisrotating = 1;
    for(var_03 = 0; var_03 < 2; var_03++) {
      stormraven_lightning_rod_rotate_block(self, 180);
      lib_0378::func_8D74("aud_stormraven_lightning_rod_rotate");
    }

    switch (self.var_165) {
      case "stormraven_lightning_rod_top":
        stormraven_lightning_rod_rotate_block(param_00.middletopblock, 90);
        break;

      case "stormraven_lightning_rod_middle_top":
        stormraven_lightning_rod_rotate_block(param_00.topblock, 90);
        stormraven_lightning_rod_rotate_block(param_00.middlebottomblock, 90);
        break;

      case "stormraven_lightning_rod_middle_bottom":
        stormraven_lightning_rod_rotate_block(param_00.middletopblock, 90);
        stormraven_lightning_rod_rotate_block(param_00.bottomblock, 90);
        break;

      case "stormraven_lightning_rod_bottom":
        stormraven_lightning_rod_rotate_block(param_00.middlebottomblock, 90);
        break;
    }

    wait(level.stormravenblockrotatetime);
    if(param_00.topblock.rotatestate == 0 && param_00.middletopblock.rotatestate == 0 && param_00.middlebottomblock.rotatestate == 0 && param_00.bottomblock.rotatestate == 0) {
      common_scripts\utility::func_3C8F(param_00.completeflag);
    } else {
      common_scripts\utility::func_3C7B(param_00.completeflag);
    }

    level notify("stormraven_lightning_rod_rotate");
    level.stormravenblockisrotating = 0;
  }
}

stormraven_lightning_rod_rotate_block(param_00, param_01) {
  param_00.rotatestate++;
  if(param_00.rotatestate > 3) {
    param_00.rotatestate = 0;
  }

  param_00 rotateyaw(param_01, level.stormravenblockrotatetime);
}

stormraven_lightning_rod_completion() {
  level endon("stormraven_hammer_tethered");
  level.allrodsinposition = 0;
  for(;;) {
    common_scripts\utility::func_3CA0("flag_stormraven_hammer_rod_one_complete", "flag_stormraven_hammer_rod_two_complete", "flag_stormraven_hammer_rod_three_complete", "flag_stormraven_hammer_rod_four_complete");
    level.allrodsinposition = 1;
    level waittill("stormraven_lightning_rod_rotate");
    level.allrodsinposition = 0;
  }
}

stormraven_lightning_rod_glow_state(param_00) {
  foreach(var_02 in param_00) {
    var_02.originalmodel = var_02.var_106;
  }

  for(;;) {
    common_scripts\utility::func_3C9F(self.completeflag);
    self.middletopblock setModel(self.middletopblock.var_106 + "a");
    wait 0.05;
    self.topblock setModel(self.topblock.var_106 + "a");
    wait 0.05;
    self.middlebottomblock setModel(self.middlebottomblock.var_106 + "a");
    wait 0.05;
    self.bottomblock setModel(self.bottomblock.var_106 + "a");
    common_scripts\utility::func_3CA9(self.completeflag);
    foreach(var_02 in param_00) {
      var_02 setModel(var_02.originalmodel);
    }
  }
}

stormraven_lightning_rod_tether_hammer(param_00) {
  for(;;) {
    level waittill("stormraven_hammer_in_tether_position");
    if(!common_scripts\utility::func_562E(level.stormhammerhasmoved)) {
      continue;
    }

    foreach(var_02 in param_00) {
      if(common_scripts\utility::func_3C77(var_02.completeflag)) {
        var_03 = spawn("script_model", var_02.var_116);
        var_03 setModel("tag_origin");
        var_03.var_1D = var_02.var_1D;
        var_04 = launchbeam("zmb_desc_hammer_tether_beam", var_03, "tag_origin", level.stormhammer.var_3F76, "tag_origin");
        level.stormhammer.var_3F76 lib_0378::func_8D74("aud_stormraven_warhammer_tether");
        var_04 common_scripts\utility::func_2CBE(3, ::delete);
        var_03 common_scripts\utility::func_2CBE(3, ::delete);
      }
    }

    if(level.allrodsinposition) {
      common_scripts\utility::func_3C8F("flag_stormraven_hammer_tethered");
      level notify("stormraven_hammer_tethered");
      level.stormhammer delete();
      level.stormhammer.var_3F76 common_scripts\utility::func_2CBE(3, ::delete);
    }
  }
}

stormraven_hammer_pickup() {
  maps\mp\zombies\weapons\_zombie_dlc4_melee::spawn_raven_weapon("hammer", common_scripts\utility::func_46B5("hammer_tether_location", "targetname").var_116);
  var_00 = common_scripts\utility::func_46B5("hammer_tether_location", "targetname").var_116;
  lib_0378::func_8D74("aud_stormraven_warhammer_pickup", var_00);
  common_scripts\utility::func_3C8F("flag_stormraven_hammer_picked_up");
}

warp_activate_lightning_rods() {
  stormraven_hammer_summon();
  common_scripts\utility::func_3C8F("flag_stormraven_hammer_sneaking_complete");
  wait(1);
  common_scripts\utility::func_3C8F("flag_stormraven_uber_charged");
  level notify("stormraven_hammer_teleport_disabled");
}

warp_complete_lightning_rods() {
  stormraven_hammer_summon();
  common_scripts\utility::func_3C8F("flag_stormraven_hammer_sneaking_complete");
  common_scripts\utility::func_3C8F("flag_stormraven_hammer_rod_one_complete");
  common_scripts\utility::func_3C8F("flag_stormraven_hammer_rod_two_complete");
  common_scripts\utility::func_3C8F("flag_stormraven_hammer_rod_three_complete");
  common_scripts\utility::func_3C8F("flag_stormraven_hammer_rod_four_complete");
  wait(1);
  common_scripts\utility::func_3C8F("flag_stormraven_uber_charged");
  level notify("stormraven_hammer_teleport_disabled");
}

warp_tether_stormhammer() {
  stormraven_hammer_summon();
  common_scripts\utility::func_3C8F("flag_stormraven_hammer_sneaking_complete");
  common_scripts\utility::func_3C8F("flag_stormraven_hammer_tethered");
  wait(1);
  level.stormhammer delete();
}

warp_stormhammer_acquired() {
  stormraven_hammer_summon();
  common_scripts\utility::func_3C8F("flag_stormraven_hammer_sneaking_complete");
  common_scripts\utility::func_3C8F("flag_stormraven_hammer_tethered");
  common_scripts\utility::func_3C8F("flag_stormraven_hammer_picked_up");
  level.var_744A[0] maps\mp\zombies\weapons\_zombie_dlc4_melee::give_hammer_weapon();
  wait(1);
  level.stormhammer delete();
}

_____call_lightning_____() {}

stormraven_call_lightning_main() {
  thread stormraven_call_lightning_init();
  common_scripts\utility::func_3C9F("flag_stormraven_special_rune_charged");
  level.specialrune thread stormraven_special_lighting_rune_discharge();
  common_scripts\utility::func_3C9F("flag_stormraven_charge_puzzle_activated");
  thread stormraven_call_lightning_cleanup();
  iprintlnbold("CALL LIGHTNING - Step Complete!");
  lib_0557::func_782D("quest_stormraven", "step_stormraven_call_lightning");
}

stormraven_call_lightning_init() {
  var_00 = getEntArray("stormraven_lightning_rune", "targetname");
  foreach(var_02 in var_00) {
    var_02 setCanDamage(1);
    var_02.ischarged = 0;
    var_02.damagetrigger = getent(var_02.var_1A2, "targetname");
    var_02 thread stormraven_lightning_rune_charge_state();
    var_02 thread stormraven_lightning_rune_damage();
  }

  level.specialrune = getent("stormraven_special_lightning_rune", "targetname");
  var_04 = getent("stormraven_special_lightning_rune_discharge_zone", "targetname");
  level.specialrune.dischargezone = var_04;
  level.specialrune.ischarged = 0;
  level.specialrune thread stormraven_special_lightning_rune_soulbucket_activate();
  level.specialrune thread stormraven_lightning_rune_charge_state();
  var_05 = getent("stormraven_charge_puzzle_rune", "targetname");
  var_05.var_9D65 = getent("stormraven_charge_puzzle_activate_trigger", "targetname");
  var_05 thread stormraven_activate_charge_puzzle();
  lib_0547::func_7BA9(::stormraven_hammer_kill_check);
}

stormraven_call_lightning_cleanup() {
  lib_0547::func_2D8C(::stormraven_hammer_kill_check);
}

stormraven_lightning_rune_charge_state() {
  level endon("stormraven_charge_puzzle_activated");
  self.chargedfx = undefined;
  if(isDefined(self.var_165) && self.var_165 == "stormraven_lightning_rune_initial") {
    stormraven_make_rune_glow();
    self.ischarged = 1;
    self.chargedfx = spawnfx(common_scripts\utility::func_44F5("zmb_desc_storm_rune_charge"), self.var_116, anglesToForward(self.var_1D));
    lib_0378::func_8D74("aud_stormraven_warhammer_run_charged");
    triggerfx(self.chargedfx);
  }

  for(;;) {
    level waittill("lightning_rune_charge_transfer");
    if(!isDefined(self.chargedfx)) {
      if(self.ischarged) {
        stormraven_make_rune_glow();
        self.chargedfx = spawnfx(common_scripts\utility::func_44F5("zmb_desc_storm_rune_charge"), self.var_116, anglesToForward(self.var_1D));
        lib_0378::func_8D74("aud_stormraven_warhammer_run_charged");
        triggerfx(self.chargedfx);
      }

      continue;
    }

    if(isDefined(self.chargedfx)) {
      stormraven_stop_rune_glow();
      self notify("aud_rune_charge_transferred");
      self.chargedfx delete();
    }
  }
}

stormraven_lightning_rune_damage() {
  level endon("stormraven_charge_puzzle_activated");
  for(;;) {
    self.damagetrigger waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    if(!isPlayer(var_01)) {
      continue;
    }

    if(var_09 != "zom_dlc4_hammer_zm") {
      continue;
    }

    if(!isDefined(var_01.stormhammerischarged)) {
      var_01.stormhammerischarged = 0;
    }

    var_01 lib_0378::func_8D74("aud_stormraven_warhammer_rune_strike");
    stormraven_lightning_rune_transfer_charge(var_01);
    var_01 thread stormraven_hammer_switch_weapons();
  }
}

stormraven_lightning_rune_transfer_charge(param_00) {
  if(param_00.stormhammerischarged) {
    level notify("lightning_rune_charge_transfer");
    self.ischarged = 1;
    param_00.stormhammerischarged = 0;
    param_00 stormraven_hammer_charge_off();
    return;
  }

  if(!param_00.stormhammerischarged && self.ischarged) {
    level notify("lightning_rune_charge_transfer");
    self.ischarged = 0;
    param_00.stormhammerischarged = 1;
    param_00 stormraven_hammer_charge_on();
    param_00 thread stormraven_hammer_charge_timer(self);
  }
}

stormraven_hammer_charge_timer(param_00) {
  level endon("lightning_rune_charge_transfer");
  level endon("stormraven_charge_puzzle_activated");
  var_01 = self;
  var_01 endon("disconnect");
  var_02 = 9;
  wait(var_02);
  var_01 notify("aud_stop_charged_warhammer");
  var_01.stormhammerischarged = 0;
  param_00.ischarged = 1;
  var_01 stormraven_hammer_charge_off();
  level notify("lightning_rune_charge_transfer");
}

stormraven_hammer_switch_weapons() {
  level endon("stormraven_charge_puzzle_activated");
  self endon("disconnect");
  self notify("stormraven_hammer_switch_weapons");
  self endon("stormraven_hammer_switch_weapons");
  for(;;) {
    common_scripts\utility::knock_off_battery("weapon_switch_started", "enter_last_stand");
    if(isDefined(self.stormhammerchargedfx)) {
      stormraven_hammer_charge_off();
    }

    if(self.stormhammerischarged) {
      self waittill("weapon_change");
      if(self.stormhammerischarged && self getcurrentweapon() == "zom_dlc4_hammer_zm") {
        stormraven_hammer_charge_on();
      }
    }

    if(lib_0547::func_577E(self)) {
      stormraven_hammer_charge_off();
    }
  }
}

stormraven_hammer_charge_on() {
  level notify("hammer_charge_on");
  var_00 = self;
  var_00 lib_0378::func_8D74("aud_stormraven_warhammer_timed_charge");
  if(!isDefined(var_00.stormhammerchargedfx)) {
    var_00.stormhammerchargedfx = spawnlinkedfxforclient(common_scripts\utility::func_44F5("zmb_storm_hammer_charge_vm"), var_00, "TAG_FX", var_00, 1);
    var_00 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_00.stormhammerchargedfx);
  }

  triggerfx(var_00.stormhammerchargedfx);
}

stormraven_hammer_charge_off() {
  level notify("hammer_charge_off");
  self notify("aud_stop_charged_warhammer");
  if(isDefined(self.stormhammerchargedfx)) {
    self.stormhammerchargedfx delete();
  }
}

stormraven_special_lightning_rune_soulbucket_activate() {
  for(;;) {
    level waittill("hammer_charge_on");
    stormraven_special_lighting_rune_soulbucket();
    if(common_scripts\utility::func_562E(self.ischarged)) {
      break;
    }
  }
}

stormraven_special_lighting_rune_soulbucket() {
  self endon("not_charged_in_time");
  self.disable_end_sound = 1;
  childthread maps\mp\mp_zombies_soul_collection::func_170B(1, 300, 300, "stormraven_special_rune_charge", undefined, "tag_origin", undefined, undefined, "zom_dlc4_hammer_zm");
  var_00 = level common_scripts\utility::func_A715("stormraven_special_rune_charge", "hammer_charge_off");
  if(var_00 == "hammer_charge_off") {
    self notify("not_charged_in_time");
    return;
  }

  if(var_00 == "stormraven_special_rune_charge") {
    foreach(var_02 in level.var_744A) {
      var_02 thread stormraven_hammer_charge_off();
    }

    self.ischarged = 1;
    level notify("lightning_rune_charge_transfer");
    wait(3);
    common_scripts\utility::func_3C8F("flag_stormraven_special_rune_charged");
  }
}

stormraven_special_lighting_rune_discharge() {
  for(;;) {
    wait(1);
    if(!self.ischarged) {
      continue;
    }

    var_00 = lib_0547::func_408F();
    var_01 = [];
    var_02 = 0;
    var_03 = undefined;
    foreach(var_05 in var_00) {
      if(!var_05 istouching(self.dischargezone)) {
        continue;
      }

      if(!bullettracepassed(self.var_116, var_05.var_116 + (0, 0, 64), 0)) {
        continue;
      }

      var_01 = common_scripts\utility::func_F6F(var_01, var_05);
    }

    if(var_01.size < 1) {
      continue;
    }

    foreach(var_05 in var_01) {
      if(var_05.var_A4B == "zombie_heavy" || var_05.var_A4B == "zombie_dlc4") {
        var_03 = var_05;
        var_05.bigboy = 1;
      }
    }

    if(!isDefined(var_03)) {
      var_03 = common_scripts\utility::func_7A33(var_01);
      var_03.bigboy = 0;
    }

    var_09 = spawn("script_model", self.var_116);
    var_09 setModel("tag_origin");
    var_0A = launchbeam("zmb_desc_hammer_tether_beam", var_09, "tag_origin", var_03, "j_neck");
    lib_0378::func_8D74("zombie_soul_suck", var_09.var_116, var_03.var_116);
    var_0A common_scripts\utility::func_2CBE(2, ::delete);
    var_09 common_scripts\utility::func_2CBE(2, ::delete);
    self.ischarged = 0;
    level notify("lightning_rune_charge_transfer");
    var_03 stormraven_charged_zombie_handler(self);
    wait(5);
    if(common_scripts\utility::func_3C77("flag_stormraven_charge_puzzle_activated")) {
      break;
    }
  }
}

stormraven_charged_zombie_handler(param_00) {
  level endon("stormraven_charge_puzzle_activated");
  self.ischarged = 1;
  self.chargedfx = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_desc_storm_hmr_zmb_transfer"), self, "j_spine4");
  triggerfx(self.chargedfx);
  thread maps\mp\agents\_agent_utility::deleteentonagentdeath(self.chargedfx);
  if(!common_scripts\utility::func_562E(self.bigboy)) {
    maps\mp\mp_zombies_soul_collection::func_865C("scripted_soul_eat", 0);
    wait(0.5);
    param_00.ischarged = 1;
    if(isalive(self)) {
      var_01 = spawn("script_model", self.var_116);
      var_01 setModel("tag_origin");
      var_01 common_scripts\utility::func_2CBE(2, ::delete);
      var_02 = launchbeam("zmb_desc_hammer_tether_beam", self, "j_neck", param_00, "tag_origin");
      var_02 common_scripts\utility::func_2CBE(2, ::delete);
      self dodamage(self.var_FB * 2, self.var_116);
    }

    level notify("lightning_rune_charge_transfer");
    return;
  }

  self waittill("death");
}

stormraven_hammer_kill_check(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!common_scripts\utility::func_562E(self.ischarged)) {
    return;
  }

  if(!common_scripts\utility::func_562E(self.bigboy)) {
    return;
  }

  if(common_scripts\utility::func_562E(self.detonating)) {
    param_04 = self.my_killer_weapon;
    param_01 = self.my_killer;
    param_03 = self.my_killer_smod;
  }

  if(isDefined(param_04) && param_04 == "zom_dlc4_hammer_zm" && isDefined(param_03) && param_03 == "MOD_MELEE") {
    param_01.stormhammerischarged = 1;
    param_01 stormraven_hammer_charge_on();
    param_01 stormraven_hammer_charge_timer(level.specialrune);
    return;
  }

  level.specialrune.ischarged = 1;
  level notify("lightning_rune_charge_transfer");
}

stormraven_activate_charge_puzzle() {
  for(;;) {
    self.var_9D65 waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    if(var_09 != "zom_dlc4_hammer_zm") {
      continue;
    }

    if(!var_01.stormhammerischarged) {
      continue;
    }

    var_01 stormraven_hammer_charge_off();
    stormraven_make_rune_glow();
    level notify("lightning_rune_charge_transfer");
    level notify("stormraven_charge_puzzle_activated");
    common_scripts\utility::func_3C8F("flag_stormraven_charge_puzzle_activated");
  }
}

debug_stormraven_hammer_charge_timer_countdown(param_00) {
  level endon("lightning_rune_charge_transfer");
  var_01 = param_00;
  while(var_01 > 0) {
    iprintlnbold(var_01);
    var_01--;
    wait(1);
  }
}

warp_special_rune_charged() {
  stormraven_hammer_summon();
  level.specialrune = getent("stormraven_special_lightning_rune", "targetname");
  common_scripts\utility::func_3C8F("flag_stormraven_hammer_sneaking_complete");
  common_scripts\utility::func_3C8F("flag_stormraven_hammer_tethered");
  common_scripts\utility::func_3C8F("flag_stormraven_hammer_picked_up");
  common_scripts\utility::func_3C8F("flag_stormraven_special_rune_charged");
  level.var_744A[0] maps\mp\zombies\weapons\_zombie_dlc4_melee::give_hammer_weapon();
  wait(1);
  level notify("stormraven_hammer_tethered");
  level.stormhammer delete();
  level.specialrune.ischarged = 1;
}

_____charge_puzzle_____() {}

stormraven_charge_puzzle_main() {
  thread stormraven_charge_puzzle_completion_runes();
  var_00 = randomintrange(0, 2);
  switch (var_00) {
    case 0:
      thread stormraven_charge_puzzle_setup_puzzle([2, 6], [0, 1, 7, 13], [], "flag_stormraven_charge_puzzle_stage_one_complete");
      break;

    case 1:
      thread stormraven_charge_puzzle_setup_puzzle([7, 13], [1, 6, 8, 12], [], "flag_stormraven_charge_puzzle_stage_one_complete");
      break;

    default:
      thread stormraven_charge_puzzle_setup_puzzle([2, 6], [0, 1, 7, 13], [], "flag_stormraven_charge_puzzle_stage_one_complete");
      break;
  }

  common_scripts\utility::func_3C9F("flag_stormraven_charge_puzzle_stage_one_complete");
  thread stormraven_charge_puzzle_setup_puzzle([2, 4, 6], [3, 7, 8, 9, 12, 13], [15], "flag_stormraven_charge_puzzle_stage_two_complete");
  common_scripts\utility::func_3C9F("flag_stormraven_charge_puzzle_stage_two_complete");
  thread stormraven_charge_puzzle_setup_puzzle([0, 5, 9, 14], [6, 7, 8, 10, 11, 13, 16, 17], [2], "flag_stormraven_charge_puzzle_stage_three_complete");
  common_scripts\utility::func_3C9F("flag_stormraven_charge_puzzle_stage_three_complete");
  lib_0557::func_782D("quest_stormraven", "step_stormraven_charge_puzzle");
}

stormraven_charge_puzzle_blocks_init() {
  var_00 = getEntArray("stormraven_charge_puzzle_block", "targetname");
  foreach(var_02 in var_00) {
    var_02.unchargedpos = (0, 345, 0);
    var_02.chargedpos = (0, 255, 0);
    var_02.hazardpos = (0, 165, 0);
    var_02.blankpos = (0, 75, 0);
    var_02.var_1D = var_02.blankpos;
    var_02.puzzlestate = "blank";
    var_02.blockid = int(var_02.var_8260);
    var_02 setCanDamage(1);
    var_02 thread stormraven_charge_puzzle_blocks_adjacent_init(var_00);
  }

  level notify("stormraven_charge_puzzle_init_complete");
}

stormraven_charge_puzzle_blocks_adjacent_init(param_00) {
  level waittill("stormraven_charge_puzzle_init_complete");
  foreach(var_02 in param_00) {
    if(var_02.blockid == self.blockid + 1) {
      self.rightblock = var_02;
      continue;
    }

    if(var_02.blockid == self.blockid - 1) {
      self.leftblock = var_02;
      continue;
    }

    if(var_02.blockid == self.blockid + 6) {
      self.upblock = var_02;
      continue;
    }

    if(var_02.blockid == self.blockid - 6) {
      self.downblock = var_02;
    }
  }

  if(self.blockid == 6 || self.blockid == 12) {
    self.leftblock = undefined;
  }

  if(self.blockid == 5 || self.blockid == 11) {
    self.rightblock = undefined;
  }
}

stormraven_charge_puzzle_block_damage() {
  level endon("stormraven_charge_puzzle_complete");
  level endon("stormraven_charge_puzzle_hazard_triggered");
  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    if(!self.var_565F) {
      continue;
    }

    if(level.chargepuzzlerotating) {
      continue;
    }

    lib_0378::func_8D74("aud_stormraven_charge_puzzle_rotate");
    level.chargepuzzlerotating = 1;
    level.chargepuzzlehazard = 0;
    var_0A = 1;
    thread stormraven_charge_puzzle_block_rotate(var_0A);
    if(isDefined(self.rightblock) && self.var_565F) {
      self.rightblock thread stormraven_charge_puzzle_block_rotate(var_0A);
    }

    if(isDefined(self.leftblock) && self.var_565F) {
      self.leftblock thread stormraven_charge_puzzle_block_rotate(var_0A);
    }

    if(isDefined(self.upblock) && self.var_565F) {
      self.upblock thread stormraven_charge_puzzle_block_rotate(var_0A);
    }

    if(isDefined(self.downblock) && self.var_565F) {
      self.downblock thread stormraven_charge_puzzle_block_rotate(var_0A);
    }

    if(level.chargepuzzlehazard) {
      level waittill("stormraven_charge_puzzle_hazard_triggered");
    } else if(!level.chargepuzzlehazard) {
      level notify("charge_puzzle_rotate");
      wait(var_0A + 0.25);
    }

    level notify("charge_puzzle_state_change");
    level.chargepuzzlerotating = 0;
  }
}

stormraven_charge_puzzle_block_rotate(param_00) {
  level endon("stormraven_charge_puzzle_hazard_triggered");
  if(self.puzzlestate == "blank") {
    return;
  }

  if(self.puzzlestate == "hazard") {
    level.chargepuzzlehazard = 1;
    var_01 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_desc_storm_p_block_reset"), self, "Tag_Origin");
    triggerfx(var_01);
    self rotateyaw(1080, 3);
    wait(3);
    var_01 delete();
    wait 0.05;
    level notify("stormraven_charge_puzzle_hazard_triggered");
    return;
  }

  if(self.puzzlestate == "charged") {
    level waittill("charge_puzzle_rotate");
    self rotateto(self.unchargedpos, param_00);
    wait(param_00);
    self.puzzlestate = "uncharged";
    return;
  }

  if(self.puzzlestate == "uncharged") {
    level waittill("charge_puzzle_rotate");
    self rotateto(self.chargedpos, param_00);
    wait(param_00);
    self.puzzlestate = "charged";
    return;
  }
}

stormraven_charge_puzzle_setup_puzzle(param_00, param_01, param_02, param_03) {
  level.chargepuzzlerotating = 0;
  var_04 = getEntArray("stormraven_charge_puzzle_block", "targetname");
  var_05 = (-2659, 47, 1420);
  lib_0378::func_8D74("aud_stormraven_charge_puzzle_spin", var_05);
  var_06 = [];
  var_07 = [];
  var_08 = [];
  var_09 = [];
  foreach(var_0B in var_04) {
    if(common_scripts\utility::func_F79(param_00, var_0B.blockid)) {
      var_06 = common_scripts\utility::func_F6F(var_06, var_0B);
    } else if(common_scripts\utility::func_F79(param_01, var_0B.blockid)) {
      var_07 = common_scripts\utility::func_F6F(var_07, var_0B);
    } else if(common_scripts\utility::func_F79(param_02, var_0B.blockid)) {
      var_08 = common_scripts\utility::func_F6F(var_08, var_0B);
    } else {
      var_09 = common_scripts\utility::func_F6F(var_09, var_0B);
    }

    var_0B.var_565F = 0;
    var_0B thread stormraven_charge_puzzle_block_damage();
  }

  foreach(var_0B in var_06) {
    var_0B thread stormraven_charge_puzzle_spin("charged");
    var_0E = randomfloatrange(3, 6);
    var_0B maps\mp\_utility::func_2CED(var_0E, ::stormraven_charge_puzzle_stop_spin);
  }

  foreach(var_0B in var_07) {
    var_0B thread stormraven_charge_puzzle_spin("uncharged");
    var_0E = randomfloatrange(3, 6);
    var_0B maps\mp\_utility::func_2CED(var_0E, ::stormraven_charge_puzzle_stop_spin);
  }

  if(var_08.size > 0) {
    foreach(var_0B in var_08) {
      var_0B thread stormraven_charge_puzzle_spin("hazard");
      var_0E = randomfloatrange(3, 6);
      var_0B maps\mp\_utility::func_2CED(var_0E, ::stormraven_charge_puzzle_stop_spin);
    }
  }

  if(var_09.size > 0) {
    foreach(var_0B in var_09) {
      var_0B thread stormraven_charge_puzzle_spin("blank");
      var_0E = randomfloatrange(8, 11);
      var_0B maps\mp\_utility::func_2CED(var_0E, ::stormraven_charge_puzzle_stop_spin);
    }
  }

  var_16 = common_scripts\utility::func_F73(var_06, var_07);
  thread stormraven_charge_puzzle_completion(var_16);
  var_17 = level common_scripts\utility::func_A715("stormraven_charge_puzzle_complete", "stormraven_charge_puzzle_hazard_triggered");
  if(var_17 == "stormraven_charge_puzzle_hazard_triggered") {
    thread stormraven_charge_puzzle_setup_puzzle(param_00, param_01, param_02, param_03);
    return;
  }

  if(var_17 == "stormraven_charge_puzzle_complete") {
    common_scripts\utility::func_3C8F(param_03);
  }
}

stormraven_charge_puzzle_spin(param_00) {
  var_01 = randomfloatrange(0.2, 0.3);
  var_02 = var_01;
  for(;;) {
    if(common_scripts\utility::func_562E(self.stopspinning)) {
      var_02 = var_02 + var_01 * 2;
    }

    if(var_02 >= var_01 * 8) {
      thread stormraven_charge_puzzle_spin_to_start_pos(param_00, var_02);
      break;
    }

    self rotateyaw(360, var_02);
    wait(var_02);
  }
}

stormraven_charge_puzzle_spin_to_start_pos(param_00, param_01) {
  for(;;) {
    self rotateyaw(5, param_01 / 72);
    wait(param_01 / 72);
    var_02 = self.var_1D[1] % 360;
    if(param_00 == "charged") {
      if(abs(var_02 - self.chargedpos[1]) <= 5) {
        break;
      }
    }

    if(param_00 == "uncharged") {
      if(abs(var_02 - self.unchargedpos[1]) <= 5) {
        break;
      }
    }

    if(param_00 == "hazard") {
      if(abs(var_02 - self.hazardpos[1]) <= 5) {
        break;
      }
    }

    if(param_00 == "blank") {
      if(abs(var_02 - self.blankpos[1]) <= 5) {
        break;
      }
    }
  }

  if(param_00 == "charged") {
    self rotateto(self.chargedpos, param_01, param_01 * 0.2, param_01 * 0.8);
    wait(param_01);
    self.puzzlestate = "charged";
    self.var_565F = 1;
  } else if(param_00 == "uncharged") {
    self rotateto(self.unchargedpos, param_01, param_01 * 0.2, param_01 * 0.8);
    wait(param_01);
    self.puzzlestate = "uncharged";
    self.var_565F = 1;
  } else if(param_00 == "hazard") {
    self rotateto(self.hazardpos, param_01, param_01 * 0.2, param_01 * 0.8);
    wait(param_01);
    self.puzzlestate = "hazard";
    self.var_565F = 1;
  } else if(param_00 == "blank" || !isDefined(param_00)) {
    self rotateto(self.blankpos, param_01, param_01 * 0.2, param_01 * 0.8);
    wait(param_01);
    self.puzzlestate = "blank";
    self.var_565F = 0;
  }

  self.stopspinning = 0;
}

stormraven_charge_puzzle_stop_spin() {
  self.stopspinning = 1;
}

stormraven_charge_puzzle_completion(param_00) {
  level endon("stormraven_charge_puzzle_complete");
  level endon("stormraven_charge_puzzle_hazard_triggered");
  for(;;) {
    level waittill("charge_puzzle_state_change");
    var_01 = 0;
    foreach(var_03 in param_00) {
      if(var_03.puzzlestate == "charged") {
        var_01++;
      }
    }

    if(var_01 >= param_00.size) {
      level notify("stormraven_charge_puzzle_complete");
    }
  }
}

stormraven_charge_puzzle_completion_runes() {
  var_00 = getEntArray("stormraven_charge_puzzle_progress_rune", "targetname");
  var_01 = [];
  foreach(var_03 in var_00) {
    if(var_03.var_8260 == "1") {
      var_01[0] = var_03;
    }

    if(var_03.var_8260 == "2") {
      var_01[1] = var_03;
    }

    if(var_03.var_8260 == "3") {
      var_01[2] = var_03;
    }
  }

  common_scripts\utility::func_3C9F("flag_stormraven_charge_puzzle_stage_one_complete");
  var_01[0] stormraven_make_rune_glow();
  common_scripts\utility::func_3C9F("flag_stormraven_charge_puzzle_stage_two_complete");
  var_01[1] stormraven_make_rune_glow();
  common_scripts\utility::func_3C9F("flag_stormraven_charge_puzzle_stage_three_complete");
  var_01[2] stormraven_make_rune_glow();
  var_01[0].chargedfx = spawnfx(common_scripts\utility::func_44F5("zmb_desc_storm_p_rune_charge"), var_01[0].var_116, anglesToForward(var_01[0].var_1D));
  triggerfx(var_01[0].chargedfx);
  var_01[0] lib_0378::func_8D74("aud_stormraven_warhammer_puz_run_ch");
  var_01[1].chargedfx = spawnfx(common_scripts\utility::func_44F5("zmb_desc_storm_p_rune_charge"), var_01[1].var_116, anglesToForward(var_01[1].var_1D));
  triggerfx(var_01[1].chargedfx);
  var_01[1] lib_0378::func_8D74("aud_stormraven_warhammer_puz_run_ch");
  var_01[2].chargedfx = spawnfx(common_scripts\utility::func_44F5("zmb_desc_storm_p_rune_charge"), var_01[2].var_116, anglesToForward(var_01[2].var_1D));
  triggerfx(var_01[2].chargedfx);
  var_01[2] lib_0378::func_8D74("aud_stormraven_warhammer_puz_run_ch");
}

debug_cycle_block_positions() {
  for(;;) {
    iprintlnbold("Uncharged");
    self rotateto(self.unchargedpos, 0.5);
    wait(1.5);
    iprintlnbold("Charged");
    self rotateto(self.chargedpos, 0.5);
    wait(1.5);
    iprintlnbold("Blank");
    self rotateto(self.blankpos, 0.5);
    wait(1.5);
    iprintlnbold("Hazard");
    self rotateto(self.hazardpos, 0.5);
    wait(1.5);
  }
}

debug_complete_charge_puzzle() {
  common_scripts\utility::func_3C8F("flag_stormraven_charge_puzzle_stage_one_complete");
  common_scripts\utility::func_3C8F("flag_stormraven_charge_puzzle_stage_two_complete");
  common_scripts\utility::func_3C8F("flag_stormraven_charge_puzzle_stage_three_complete");
}

debug_sneak_fail_spam() {
  if(!common_scripts\utility::func_562E(level.debug_sneak_fail_force)) {
    level.debug_sneak_fail_force = 1;
    return;
  }

  level.debug_sneak_fail_force = 0;
}

warp_start_charge_puzzle() {
  stormraven_hammer_summon();
  common_scripts\utility::func_3C8F("flag_stormraven_hammer_sneaking_complete");
  common_scripts\utility::func_3C8F("flag_stormraven_hammer_tethered");
  common_scripts\utility::func_3C8F("flag_stormraven_hammer_picked_up");
  common_scripts\utility::func_3C8F("flag_stormraven_special_rune_charged");
  level.var_744A[0] maps\mp\zombies\weapons\_zombie_dlc4_melee::give_hammer_weapon();
  wait(1);
  level notify("stormraven_hammer_tethered");
}

_____find_trial_____() {}

stormraven_find_trial_main() {
  thread stormraven_path_activate();
}

stormraven_find_trial_init() {
  var_00 = getEntArray("stormraven_platform", "targetname");
  foreach(var_02 in var_00) {
    var_02 method_8511();
    var_02 notsolid();
  }
}

stormraven_path_activate() {
  var_00 = getEntArray("stormraven_platform", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread stormraven_path_make_visible();
  }

  var_04 = getent("stormraven_platform_trigger", "targetname");
  var_05 = getent("stormraven_platform_trigger_final", "targetname");
  foreach(var_07 in level.var_744A) {
    var_07 thread stormraven_player_on_path(var_04);
    var_07 thread stormraven_path_slow(var_04);
    var_07 thread stormraven_path_damage(var_04);
    var_07 thread stormraven_path_lightning_fx(var_05);
  }

  thread stormraven_path_delete_after_trial(var_00);
  thread stormraven_path_enter_trial();
}

stormraven_path_make_visible() {
  self solid();
  var_00 = undefined;
  while(!common_scripts\utility::func_3C77(lib_0557::func_7838("quest_stormraven", "step_stormraven_trial"))) {
    var_00 = spawnfx(common_scripts\utility::func_44F5("zmb_desc_stormraven_plat_1"), self.var_116);
    triggerfx(var_00);
    wait(1);
    var_00 delete();
    wait(randomfloatrange(0.1, 0.2));
  }

  if(isDefined(var_00)) {
    var_00 delete();
  }
}

stormraven_path_delete_after_trial(param_00) {
  common_scripts\utility::func_3C9F(lib_0557::func_7838("quest_stormraven", "step_stormraven_trial"));
  foreach(var_02 in param_00) {
    var_02 delete();
  }
}

stormraven_player_on_path(param_00) {
  level endon("stormraven_combat_trial_complete");
  for(;;) {
    if(param_00 method_858B(self.var_116 + (0, 0, 16))) {
      self.touchingstormravenpath = 1;
    } else {
      self.touchingstormravenpath = 0;
    }

    wait 0.05;
  }
}

stormraven_path_damage(param_00) {
  level endon("stormraven_combat_trial_complete");
  for(;;) {
    wait 0.05;
    if(!self.touchingstormravenpath) {
      continue;
    }

    if(!stormraven_player_has_stormhammer()) {
      self dodamage(self.var_FB * 0.2, self.var_116);
      wait(1);
    }
  }
}

stormraven_path_slow(param_00) {
  level endon("stormraven_combat_trial_complete");
  var_01 = common_scripts\utility::func_46B5("stormraven_path_startpoint", "targetname");
  var_02 = distancesquared(var_01.var_116, param_00.var_116);
  for(;;) {
    wait 0.05;
    if(!self.touchingstormravenpath) {
      self method_81E1(1);
      self allowjump(1);
      self method_8308(1);
      continue;
    }

    var_03 = distancesquared(self.var_116, param_00.var_116);
    var_04 = 0.4;
    if(var_03 < var_02 * 0.75) {
      var_04 = var_04 - 0.075;
    }

    if(var_03 < var_02 * 0.5) {
      var_04 = var_04 - 0.075;
    }

    if(var_03 < var_02 * 0.25) {
      var_04 = var_04 - 0.075;
    }

    self method_8308(0);
    self allowjump(0);
    self method_81E1(var_04);
  }
}

stormraven_path_lightning_fx(param_00) {
  level endon("stormraven_combat_trial_complete");
  var_01 = common_scripts\utility::func_46B5("stormraven_path_startpoint", "targetname");
  var_02 = distancesquared(var_01.var_116, param_00.var_116);
  var_03 = common_scripts\utility::func_46B7("stormraven_platform_lightning_marker", "targetname");
  for(;;) {
    wait 0.05;
    if(!self.touchingstormravenpath) {
      continue;
    }

    if(!stormraven_player_has_stormhammer()) {
      continue;
    }

    level.playerwalkingstormpath = self;
    var_04 = 2.5;
    var_05 = distance(self.var_116, param_00.var_116);
    if(var_05 < var_02 * 0.75) {
      var_04 = var_04 - 0.5;
    }

    if(var_05 < var_02 * 0.5) {
      var_04 = var_04 - 0.5;
    }

    if(var_05 < var_02 * 0.25) {
      var_04 = var_04 - 0.5;
    }

    var_06 = randomfloatrange(param_00.var_116[0] - 100, param_00.var_116[0] + 100);
    if(param_00.var_116[1] >= self.var_116[1]) {
      var_07 = randomfloatrange(self.var_116[1] + 50, param_00.var_116[1] + 50);
    } else {
      var_07 = randomfloatrange(param_00.var_116[1] - 50, self.var_116[1] - 50);
    }

    var_08 = param_00.var_116[2];
    var_09 = (var_06, var_07, var_08);
    playFX(common_scripts\utility::func_44F5("zmb_desc_storm_plat_strike"), var_09);
    lib_0378::func_8D74("aud_stormraven_warhammer_trial_strikes", var_09);
    wait(randomfloatrange(0.25, var_04));
  }
}

stormraven_path_enter_trial() {
  level endon("stormraven_combat_trial_complete");
  var_00 = getent("stormraven_platform_trigger_final", "targetname");
  for(;;) {
    var_00 waittill("trigger", var_01);
    if(!var_01 stormraven_player_has_stormhammer()) {
      continue;
    }

    var_02 = common_scripts\utility::func_46B5("stormraven_platform_ascend_point", "targetname");
    var_01 method_81E1(0);
    var_03 = spawn("script_model", var_01.var_116);
    var_01 playerlinkto(var_03);
    var_03 moveto(var_02.var_116, 3, 1, 1);
    var_04 = common_scripts\utility::func_46B7("stormraven_platform_ascend_lightning", "targetname");
    var_05 = 0;
    while(var_05 < 20) {
      var_06 = common_scripts\utility::func_7A33(var_04);
      thread stormraven_lightning_strike(var_06.var_116);
      var_05++;
      wait(0.25);
    }

    lib_0378::func_8D74("aud_stormraven_warhammer_ascend_strike", var_01.var_116);
    thread stormraven_lightning_strike(var_01.var_116);
    var_01 thread run_weapon_ritual("zom_dlc4_hammer_zm");
    var_01 stormraven_path_trial_transition_fade();
    var_03 delete();
  }
}

stormraven_path_trial_transition_fade() {
  if(lib_0547::func_577E(self) || !isalive(self)) {
    return;
  }

  self setdemigod(1);
  if(!isDefined(self.entertrialoverlayfade)) {
    self.entertrialoverlayfade = stormraven_trial_create_client_overlay("white", 0, self);
  }

  var_00 = 3;
  var_01 = 1;
  self.entertrialoverlayfade.var_18 = 0;
  self.entertrialoverlayfade fadeovertime(var_00);
  self.entertrialoverlayfade.var_18 = 1;
  wait(var_00);
  self unlink();
  level notify("stormraven_trial_fade_peak");
  self setdemigod(0);
  self.entertrialoverlayfade.var_18 = 1;
  self.entertrialoverlayfade fadeovertime(var_01);
  self.entertrialoverlayfade.var_18 = 0;
}

warp_find_trial() {
  stormraven_hammer_summon();
  common_scripts\utility::func_3C8F("flag_stormraven_hammer_sneaking_complete");
  common_scripts\utility::func_3C8F("flag_stormraven_hammer_tethered");
  common_scripts\utility::func_3C8F("flag_stormraven_hammer_picked_up");
  common_scripts\utility::func_3C8F("flag_stormraven_special_rune_charged");
  common_scripts\utility::func_3C8F("flag_stormraven_charge_puzzle_stage_one_complete");
  common_scripts\utility::func_3C8F("flag_stormraven_charge_puzzle_stage_two_complete");
  common_scripts\utility::func_3C8F("flag_stormraven_charge_puzzle_stage_three_complete");
  level.var_744A[0] maps\mp\zombies\weapons\_zombie_dlc4_melee::give_hammer_weapon();
  wait(1);
  level notify("stormraven_hammer_tethered");
}

_____run_trial_____() {}

run_stormraven_trial() {
  self.isinstormravenevent = 1;
  thread stormraven_trial_check_for_death();
  level waittill("stormraven_trial_fade_peak");
  stormraven_trial_teleport_to_trial();
  self waittill("picked_up_raven_weapon");
  stormraven_trial_zombie_playtime();
  wait(3);
  stormraven_trial_shield_zombies();
  lib_0557::func_782D("quest_stormraven", "step_stormraven_trial");
  thread stormraven_show_splash();
  return 1;
}

stormraven_show_splash() {
  common_scripts\utility::func_3C9F("flag_stormraven_trial_completed");
  wait(3);
  maps\mp\zquests\dlc4_trophies_mp_zombie_descent::complete_descent_trophy_event_8(self);
}

stormraven_trial_check_for_death() {
  self waittill("death");
  if(stormraven_player_has_stormhammer_emp()) {
    maps\mp\zombies\weapons\_zombie_dlc4_melee::take_raven_weapon("hammer_emp");
    maps\mp\zombies\weapons\_zombie_dlc4_melee::give_hammer_weapon();
    lib_0586::func_78E("zom_dlc4_hammer_zm");
  }

  self.isinstormravenevent = 0;
}

stormraven_trial_teleport_to_trial() {
  var_00 = common_scripts\utility::func_46B5("stormraven_trial_player_spawner", "script_noteworthy");
  self setorigin(var_00.var_116);
  self setangles(var_00.var_1D);
  var_01 = spawn("script_model", var_00.var_116);
  self playerlinkto(var_01);
  wait(2);
  var_02 = common_scripts\utility::func_46B5("stormraven_trial_player_spawner_down", "script_noteworthy");
  var_01 moveto(var_02.var_116, 3, 1, 2);
  var_01 thread common_scripts\utility::func_2CBE(2, ::delete);
  self unlink();
  self method_81E1(1);
  self allowjump(1);
  self method_8308(1);
}

stormraven_trial_zombie_playtime() {
  var_00 = 0;
  var_01 = 9;
  var_02 = common_scripts\utility::func_46B7("zone_spawners_storm", "targetname");
  for(var_03 = 0; var_03 < var_01; var_03++) {
    var_04 = spawn_zombie_with_lightning(common_scripts\utility::func_7A33(var_02));
    var_04.playtimezombie = 1;
    var_05 = randomfloatrange(1, 2);
    var_00++;
    wait(var_05);
  }

  while(var_00 < var_01) {
    wait 0.05;
  }

  wait(3);
  var_00 = undefined;
}

stormraven_trial_shield_zombies() {
  self endon("death");
  self endon("disconnect");
  var_00 = common_scripts\utility::func_46B5("stormraven_trial_spawner_shield_single", "targetname");
  var_01 = 0;
  var_02 = 2;
  while(var_01 < 20) {
    var_03 = randomfloatrange(var_00.var_116[0] - 20, var_00.var_116[0] + 20);
    var_04 = randomfloatrange(var_00.var_116[1] - 20, var_00.var_116[1] + 20);
    var_05 = var_00.var_116[2];
    var_06 = (var_03, var_04, var_05);
    thread stormraven_lightning_strike(var_06);
    var_01++;
    if(var_02 > 0.25) {
      var_02 = var_02 - 0.25;
    }

    wait(var_02);
  }

  thread stormraven_lightning_strike(var_00.var_116);
  thread stormraven_lightning_strike(var_00.var_116);
  thread stormraven_lightning_strike(var_00.var_116);
  thread stormraven_trial_shield_zombies_check_for_completion();
  lib_0547::func_7BA9(::stormraven_trial_shield_zombie_death_func);
  level.storm_trial_shieldzombies = [];
  level.storm_trial_shieldzombies[0] = spawn_zombie_with_lightning(var_00);
  var_07 = spawnStruct();
  var_07.var_116 = var_00.var_116 + (0, 64, 0);
  level.storm_trial_shieldzombies[1] = spawn_zombie_with_lightning(var_07);
  var_08 = spawnStruct();
  var_08.var_116 = var_00.var_116 - (0, 64, 0);
  level.storm_trial_shieldzombies[2] = spawn_zombie_with_lightning(var_08);
  if(!common_scripts\utility::func_562E(self.has_shown_storm_trial_hint)) {
    self.has_shown_storm_trial_hint = 1;
    lib_0555::func_83DD("dlc4_trial_hint_storm", self);
  }

  foreach(var_0A in level.storm_trial_shieldzombies) {
    var_0A.isshieldzombie = 1;
    var_0A maps\mp\zombies\zombie_king::enable_force_shield();
  }

  level notify("shield_zombies_spawned");
  thread stormraven_trial_shield_zombie_hint_timer();
  level waittill("shield_zombies_complete");
  lib_0547::func_2D8C(::stormraven_trial_shield_zombie_death_func);
}

stormraven_trial_shield_zombies_check_for_completion() {
  level waittill("shield_zombies_spawned");
  while(isDefined(level.storm_trial_shieldzombies) && level.storm_trial_shieldzombies.size > 0) {
    wait 0.05;
  }

  level notify("shield_zombies_complete");
}

stormraven_trial_shield_zombie_death_func(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(isDefined(self.isshieldzombie) && self.isshieldzombie == 1) {
    level.storm_trial_shieldzombies = common_scripts\utility::func_F93(level.storm_trial_shieldzombies, self);
    level notify("stormraven_shield_zombie_killed");
    level notify("shield_zombie_killed");
  }
}

stormraven_trial_shield_zombie_hint_timer() {
  level endon("stormraven_shield_zombie_killed");
  wait(15);
  lib_0555::func_83DD("dlc4_weap_hint_hammer_emp", self);
}

stormraven_trial_ascension() {
  var_00 = common_scripts\utility::func_46B5("stormraven_trial_ascension_rune_spawner", "targetname");
  stormraven_lightning_strike(var_00.var_116);
  var_01 = spawn("script_model", var_00.var_116);
  var_01 setModel("zmd_runes_objects_04c");
  var_02 = getent("stormraven_trial_ascension_trigger", "targetname");
  var_03 = common_scripts\utility::func_46B5("stormraven_trial_ascension_ground", "targetname");
  var_04 = common_scripts\utility::func_46B5("stormraven_trial_ascension_sky", "targetname");
  thread stormraven_ascend_logic(var_02, var_03, var_04);
  level waittill("stormhammer_ascension_reached_peak");
  thread stormraven_trial_check_for_ascension_complete();
  var_05 = common_scripts\utility::func_46B7("zone_spawners_storm", "targetname");
  while(!common_scripts\utility::func_3C77("flag_stormraven_trial_ascension_complete")) {
    var_06 = spawn_zombie_with_lightning(common_scripts\utility::func_7A33(var_05));
    var_06.ascensionzombie = 1;
    wait(0.5);
  }

  for(;;) {
    var_07 = 1;
    foreach(var_06 in lib_0547::func_408F()) {
      if(common_scripts\utility::func_562E(var_06.ascensionzombie)) {
        var_07 = 0;
      }
    }

    if(var_07) {
      break;
    }

    wait 0.05;
  }
}

stormraven_trial_check_for_ascension_complete() {
  level waittill("stormhammer_ascension_complete");
  common_scripts\utility::func_3C8F("flag_stormraven_trial_ascension_complete");
}

stormraven_trial_teleport_from_trial() {
  thread stormraven_path_trial_transition_fade();
  level waittill("stormraven_trial_fade_peak");
  var_00 = common_scripts\utility::func_46B5("stormraven_trial_teleport_exit", "targetname");
  self setorigin(var_00.var_116);
  common_scripts\utility::func_3C8F("flag_stormraven_trial_completed");
}

deathraven_hitch_a_ride_back() {
  var_00 = self;
  var_00 endon("disconnect");
  var_00 notify("new_hitchhike");
  var_00 endon("new_hitchhike");
  var_00.hitchingaride = 1;
  while(common_scripts\utility::func_562E(var_00.hitchingaride)) {
    var_01 = var_00 get_random_activated_trigger();
    var_01 notify("trigger", var_00);
    wait 0.05;
  }
}

get_random_activated_trigger() {
  var_00 = self;
  if(isDefined(var_00.lastdepartdoor)) {
    return var_00.lastdepartdoor.use_trig;
  }

  foreach(var_02 in common_scripts\utility::func_F92(level.zmb_blood_tubes)) {
    if(!common_scripts\utility::func_562E(var_02.transport_inactive)) {
      return var_02.use_trig;
    }
  }
}

warp_start_trial() {
  level.var_744A[0] thread run_weapon_ritual("zom_dlc4_hammer_zm");
  level.var_744A[0] stormraven_path_trial_transition_fade();
}

_____util_____() {}

stormraven_make_rune_glow() {
  self.normalmodel = self.var_106;
  var_00 = self.var_106 + "c";
  self setModel(var_00);
}

stormraven_stop_rune_glow() {
  if(isDefined(self.normalmodel)) {
    var_00 = self.normalmodel;
    self setModel(var_00);
  }
}

stormraven_player_has_stormhammer() {
  if(self getcurrentweapon() == "zom_dlc4_hammer_zm") {
    return 1;
  }

  return 0;
}

stormraven_player_has_stormhammer_emp() {
  if(self getcurrentweapon() == "zom_dlc4_hammer_emp_zm") {
    return 1;
  }

  return 0;
}

stormraven_lightning_strike(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  playFX(common_scripts\utility::func_44F5("zmb_desc_storm_plat_strike"), param_00);
  lib_0378::func_8D74("aud_stormraven_warhammer_trial_strikes", param_00);
}

spawn_zombie_with_lightning(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = "zombie_generic";
  }

  stormraven_lightning_strike(param_00.var_116);
  wait(0.1);
  var_02 = lib_054D::func_90BA(param_01, param_00, "storm_trial_zombie", 0, 1, 1);
  var_02 lib_0547::func_84CB();
  var_02.var_6816 = 1;
  var_02.var_C29 = 0;
  var_02.var_562B = 1;
  var_02.var_55AB = 1;
  return var_02;
}

stormraven_trial_create_client_overlay(param_00, param_01, param_02, param_03) {
  var_04 = 1;
  if(isDefined(param_03)) {
    var_04 = param_03;
  }

  if(isDefined(param_02)) {
    var_05 = newclienthudelem(param_02);
  } else {
    var_05 = newhudelem();
  }

  var_05.maxsightdistsqrd = 0;
  var_05.var_1D7 = 0;
  var_05 setshader(param_00, 640, 480);
  var_05.accuracy = "left";
  var_05.var_11 = "top";
  var_05.ignoreme = 1;
  var_05.var_C6 = "fullscreen";
  var_05.var_1CA = "fullscreen";
  var_05.var_18 = param_01;
  var_05.var_A0 = var_04;
  return var_05;
}

play_earthquake(param_00, param_01, param_02, param_03) {
  earthquake(param_00, param_01, param_02, param_03);
}

rumble_nearby_players(param_00, param_01) {
  var_02 = 0;
  var_03 = 0.5;
  for(;;) {
    foreach(var_05 in level.var_744A) {
      if(distance2d(var_05.var_116, self.var_116) <= param_01) {
        var_05 playrumbleonentity("damage_heavy");
      }
    }

    wait(var_03);
    var_02 = var_02 + var_03;
    if(var_02 >= param_00) {
      break;
    }
  }
}

_____ascend_____() {}

stormraven_ascend_logic(param_00, param_01, param_02) {
  level.zombielethalweapon["throwinghammer_lhand_zm"] = 1;
  level.zombielethalweapon["throwinghammer_rhand_zm"] = 1;
  param_00 makeusable();
  var_03 = lib_0552::func_7BE1(undefined, param_00);
  var_03.var_4028 = lib_0552::func_44FF("dlc4_ascend");
  var_04 = undefined;
  for(;;) {
    param_00 waittill("trigger", var_04);
    if(!isPlayer(var_04)) {
      continue;
    }

    break;
  }

  var_04 thread stormraven_ascend_handle_weapons();
  var_04 thread stormraven_ascend_ascension(param_01, param_02);
  level waittill("stormhammer_ascension_reached_peak");
  var_04 thread stormraven_ascend_cycle_hands();
  var_04 thread stormraven_ascend_throw_hammer();
  level waittill("stormhammer_ascension_complete");
}

stormraven_ascend_handle_weapons() {
  self.oldlethal = self method_834A();
  self.oldweapons = self getweaponslist("primary");
  lib_0586::func_78F();
  lib_0586::func_78C("zom_dlc4_hammer_emp_zm");
  lib_0586::func_78E("zom_dlc4_hammer_emp_zm");
  level waittill("stormhammer_ascension_complete");
  if(isDefined(self.oldlethal)) {
    maps\mp\zombies\_zombies_magicbox::func_A7D5(self, self.oldlethal);
  } else {
    maps\mp\zombies\_zombies_magicbox::func_A7D5(self, "frag_grenade_zm");
  }

  if(isDefined(self.oldweapons) && self.oldweapons.size > 0) {
    foreach(var_01 in self.oldweapons) {
      lib_0586::func_78C(var_01);
    }

    lib_0586::func_78E(self.oldweapons[0]);
  }
}

stormraven_ascend_ascension(param_00, param_01) {
  self method_81E1(0);
  var_02 = spawn("script_model", self.var_116);
  self playerlinkto(var_02);
  var_02 moveto(param_00.var_116, 0.5, 0.25, 0.25);
  wait(0.5);
  var_02 moveto(param_01.var_116, 1, 0.5, 0.5);
  wait(1);
  level notify("stormhammer_ascension_reached_peak");
  wait(20);
  var_02 moveto(param_00.var_116, 1, 0.5, 0.5);
  wait(1);
  self method_81E1(1);
  self unlink();
  level notify("stormhammer_ascension_complete");
}

stormraven_ascend_cycle_hands() {
  level endon("stormhammer_ascension_complete");
  for(;;) {
    maps\mp\zombies\_zombies_magicbox::func_A7D5(self, "throwinghammer_lhand_zm");
    self waittill("grenade_fire");
    wait 0.05;
    iprintlnbold("Swap to right hand");
    maps\mp\zombies\_zombies_magicbox::func_A7D5(self, "throwinghammer_lhand_zm");
    self waittill("grenade_fire");
    wait 0.05;
    iprintlnbold("Swap to left hand");
  }
}

stormraven_ascend_throw_hammer() {
  level endon("stormhammer_ascension_complete");
  for(;;) {
    self waittill("grenade_fire", var_00, var_01);
    if(var_01 == "throwinghammer_lhand_zm" || var_01 == "throwinghammer_rhand_zm") {
      var_00 stormraven_ascend_impact_check();
      var_00 stormraven_ascend_impact(var_00.var_116);
    }
  }
}

stormraven_ascend_impact_check() {
  for(;;) {
    var_00 = bullettracepassed(self.var_116, self.var_116 - (0, 0, 25), 0, self);
    if(!common_scripts\utility::func_562E(var_00)) {
      break;
    }

    wait 0.05;
  }

  iprintlnbold("Hammer impacted ground");
}

stormraven_ascend_impact(param_00) {
  playFX(common_scripts\utility::func_44F5("zmb_storm_hammer_lightning"), param_00);
  wait(0.25);
  playFX(common_scripts\utility::func_44F5("zmb_storm_hammer_impact"), param_00);
  var_01 = maps\mp\gametypes\zombies::func_1E59(lib_0547::func_A51("zombie_generic"), level.var_A980);
  var_02 = lib_0547::func_408F();
  if(isDefined(var_02) && var_02.size > 0) {
    foreach(var_04 in var_02) {
      if(distancesquared(param_00, var_04.var_116) < 10000) {
        var_04 lib_0547::func_5A85(var_04.var_116, param_00 - var_04.var_116);
      }
    }

    wait 0.05;
    physicsexplosionsphere(param_00, 150, 50, 3);
  }

  self delete();
}

__________________moonraven__________________() {}

init_moonraven_quest() {
  common_scripts\utility::func_3C87("moonraven_key_collected_01");
  common_scripts\utility::func_3C87("moonraven_key_collected_02");
  common_scripts\utility::func_3C87("moonraven_key_placed_01");
  common_scripts\utility::func_3C87("moonraven_key_placed_02");
  common_scripts\utility::func_3C87("moonraven_reveal_chart");
  common_scripts\utility::func_3C87("moonraven_all_keys_placed");
  common_scripts\utility::func_3C87("moonraven_gear_1_collected");
  common_scripts\utility::func_3C87("moonraven_gear_2_collected");
  common_scripts\utility::func_3C87("moonraven_gear_3_collected");
  common_scripts\utility::func_3C87("flag_gears_collected_1");
  common_scripts\utility::func_3C87("flag_gears_collected_2");
  common_scripts\utility::func_3C87("flag_gears_collected_3");
  common_scripts\utility::func_3C87("moonraven_gear_1_placed");
  common_scripts\utility::func_3C87("moonraven_gear_2_placed");
  common_scripts\utility::func_3C87("moonraven_gear_3_placed");
  common_scripts\utility::func_3C87("moonraven_gears_all_placed");
  common_scripts\utility::func_3C87("moonraven_gears_stop_rotation");
  common_scripts\utility::func_3C87("moonraven_orrery_collect_complete");
  common_scripts\utility::func_3C87("moonraven_orrery_start");
  common_scripts\utility::func_3C87("orrery_moon_A_stop");
  common_scripts\utility::func_3C87("orrery_moon_B_stop");
  common_scripts\utility::func_3C87("orrery_moon_C_stop");
  common_scripts\utility::func_3C87("orrery_moon_D_stop");
  common_scripts\utility::func_3C87("orrery_moon_A_valid");
  common_scripts\utility::func_3C87("orrery_moon_B_valid");
  common_scripts\utility::func_3C87("orrery_moon_C_valid");
  common_scripts\utility::func_3C87("orrery_moon_D_valid");
  common_scripts\utility::func_3C87("moonraven_orrery_solved");
  common_scripts\utility::func_3C87("moonraven_orrery_complete");
  common_scripts\utility::func_3C87("moonraven_alcove_collect_1_complete");
  common_scripts\utility::func_3C87("moonraven_alcove_collect_2_complete");
  common_scripts\utility::func_3C87("moonraven_alcove_collect_3_complete");
  common_scripts\utility::func_3C87("moon_constellation_1_complete");
  common_scripts\utility::func_3C87("moon_constellation_2_complete");
  common_scripts\utility::func_3C87("moon_constellation_3_complete");
  common_scripts\utility::func_3C87("moon_trial_unlocked");
  common_scripts\utility::func_3C87("moon_trial_entered");
  common_scripts\utility::func_3C87("moon_trial_complete");
  var_00 = getent("moonraven_debug_book", "targetname");
  var_00 delete();
  var_01 = getent("moonraven_debug_gear", "targetname");
  var_01 delete();
  thread moonraven_init_bookshelf();
  thread moonraven_init_gears();
  thread moonraven_init_moon_chart();
  thread moonraven_init_orrery_power();
  thread moonraven_init_orrery();
  thread moonraven_init_constellations();
  thread moonraven_init_alcove();
}

moonraven_init_bookshelf() {
  enable_bookshelf_zombies(0);
  var_00 = getEntArray("moonraven_bookshelf_final", "targetname");
  var_01 = getent("moonraven_bookshelf_link_node", "targetname");
  var_02 = getent("moonraven_bookshelf_moveStart", "targetname");
  foreach(var_04 in var_00) {
    var_04 method_8449(var_01);
  }

  var_01.var_116 = var_02.var_116;
  var_06 = getent("moonraven_book_key_placed_01", "targetname");
  var_07 = getent("moonraven_book_key_placed_02", "targetname");
  var_06 method_805C();
  var_07 method_805C();
  var_08 = getent("moonraven_book_key_find_01", "targetname");
  var_09 = getent("moonraven_book_key_find_01_trigger", "targetname");
  var_0A = common_scripts\utility::func_46B7("moonraven_book_location", "targetname");
  var_0B = common_scripts\utility::func_7A33(var_0A);
  var_0C = getent("moonraven_book_key_find_02", "targetname");
  var_0C.var_116 = var_0B.var_116;
  var_0C.var_1D = var_0B.var_1D;
  var_0D = getent(var_0B.var_1A2, "targetname");
  var_0E = ["moonraven_key_collected_01", "moonraven_key_collected_02"];
  thread moonraven_bookshelf_find_book(var_08, var_09, var_0E);
  thread moonraven_bookshelf_find_book(var_0C, var_0D, var_0E);
  var_0F = getent("moonraven_place_books_trigger_01", "targetname");
  var_10 = getent("moonraven_place_books_trigger_02", "targetname");
  level.moonraven_books_placed = 0;
  level.moonraven_books_placed_goal = 2;
  thread moonraven_bookshelf_place_book(var_0F, "moonraven_key_collected_01", "moonraven_key_collected_02");
  thread moonraven_bookshelf_place_book(var_10, "moonraven_key_collected_01", "moonraven_key_collected_02");
  while(level.moonraven_books_placed < level.moonraven_books_placed_goal) {
    wait 0.05;
  }

  var_11 = getent("moonraven_bookshelf_moveLoc", "targetname");
  var_12 = 8;
  var_01 moveto(var_11.var_116, var_12);
  var_13 = getent("moonraven_bookshelf_path", "targetname");
  var_13 method_8060();
  var_13 notsolid();
  enable_bookshelf_zombies(1);
  common_scripts\utility::func_3C8F("moonraven_reveal_chart");
  common_scripts\utility::func_3C8F("moonraven_all_keys_placed");
}

enable_bookshelf_zombies(param_00) {
  var_01 = common_scripts\utility::func_46B7("zone_archives_spawners", "targetname");
  foreach(var_03 in var_01) {
    if(lib_0547::func_5565(var_03.var_82EC, "zmb_archives_quest_disabled")) {
      var_03.is_zombies_spawner_script_disabled = !param_00;
    }
  }
}

moonraven_bookshelf_find_book(param_00, param_01, param_02) {
  param_01 waittill("trigger", var_03);
  param_00 lib_0378::func_8D74("aud_moonraven_book_pickup");
  param_01 delete();
  param_00 delete();
  foreach(var_05 in param_02) {
    if(!common_scripts\utility::func_3C77(var_05)) {
      common_scripts\utility::func_3C8F(var_05);
      return;
    }
  }
}

moonraven_bookshelf_place_book(param_00, param_01, param_02) {
  var_03 = 0;
  var_04 = getent(param_00.var_1A2, "targetname");
  while(!var_03) {
    wait 0.05;
    param_00 waittill("trigger", var_05);
    if(common_scripts\utility::func_3C77(param_01) && !var_03) {
      var_04 method_805B();
      var_04 lib_0378::func_8D74("aud_moonraven_book_place");
      level.moonraven_books_placed = level.moonraven_books_placed + 1;
      var_03 = 1;
      common_scripts\utility::func_3C7B(param_01);
    }

    if(common_scripts\utility::func_3C77(param_02) && !var_03) {
      var_04 method_805B();
      var_04 lib_0378::func_8D74("aud_moonraven_book_place");
      level.moonraven_books_placed = level.moonraven_books_placed + 1;
      var_03 = 1;
      common_scripts\utility::func_3C7B(param_02);
    }
  }
}

quest_step_moonraven_chart() {
  common_scripts\utility::func_3C9F("moonraven_reveal_chart");
  activateclientexploder(227);
  lib_0557::func_782D("quest_moonraven", "quest_moonraven_reveal_chart");
}

moonraven_debug_reveal_chart() {
  var_00 = getent("moonraven_book_key_placed_01", "targetname");
  var_01 = getent("moonraven_book_key_placed_02", "targetname");
  var_00 method_805B();
  var_01 method_805B();
  var_02 = getent("moonraven_book_key_find_01", "targetname");
  var_03 = getent("moonraven_book_key_find_02", "targetname");
  var_02 method_805C();
  var_03 method_805C();
  var_04 = getEntArray("moonraven_bookshelf_final", "targetname");
  var_05 = getent("moonraven_bookshelf_link_node", "targetname");
  var_06 = getent("moonraven_bookshelf_moveStart", "targetname");
  var_07 = getent("moonraven_bookshelf_moveLoc", "targetname");
  foreach(var_09 in var_04) {
    var_09 method_8449(var_05);
  }

  var_0B = 1;
  var_05 moveto(var_07.var_116, var_0B);
  var_0C = getent("moonraven_bookshelf_path", "targetname");
  var_0C method_8060();
  var_0C notsolid();
  common_scripts\utility::func_3C8F("moonraven_reveal_chart");
  common_scripts\utility::func_3C8F("moonraven_all_keys_placed");
  lib_0557::func_782D("quest_moonraven", "quest_moonraven_reveal_chart");
}

moonraven_init_gears() {
  var_00 = getent("moonraven_gear_1_placed", "targetname");
  var_01 = getent("moonraven_gear_2_placed", "targetname");
  var_02 = getent("moonraven_gear_3_placed", "targetname");
  var_00 method_805C();
  var_01 method_805C();
  var_02 method_805C();
  var_03 = getent("moonraven_gear_find_01", "targetname");
  var_04 = getent("moonraven_gear_find_02", "targetname");
  var_05 = getent("moonraven_gear_find_03", "targetname");
  var_06 = common_scripts\utility::func_46B7("moonraven_gear_location", "targetname");
  foreach(var_08 in var_06) {
    if(distance(var_08.var_116, (924, 2486, 2127)) < 24) {
      var_06 = common_scripts\utility::func_F93(var_06, var_08);
    }
  }

  var_0A = common_scripts\utility::func_7A33(var_06);
  var_06 = common_scripts\utility::func_F93(var_06, var_0A);
  var_0B = common_scripts\utility::func_7A33(var_06);
  var_06 = common_scripts\utility::func_F93(var_06, var_0B);
  var_0C = common_scripts\utility::func_7A33(var_06);
  var_03.var_116 = var_0A.var_116;
  var_03.var_1D = var_0A.var_1D;
  var_03.var_9D65 = getent(var_0A.var_1A2, "targetname");
  var_04.var_116 = var_0B.var_116;
  var_04.var_1D = var_0B.var_1D;
  var_04.var_9D65 = getent(var_0B.var_1A2, "targetname");
  var_05.var_116 = var_0C.var_116;
  var_05.var_1D = var_0C.var_1D;
  var_05.var_9D65 = getent(var_0C.var_1A2, "targetname");
  level.moonraven_gears_collected = 0;
  thread moonraven_fix_machine_gear_watch(var_03, "moonraven_gear_1_collected");
  thread moonraven_fix_machine_gear_watch(var_04, "moonraven_gear_2_collected");
  thread moonraven_fix_machine_gear_watch(var_05, "moonraven_gear_3_collected");
  level.moonraven_gears_placed = 0;
  var_0D = getent("moonraven_gear_placed_trigger", "targetname");
  while(level.moonraven_gears_placed < 3) {
    wait 0.05;
    var_0D waittill("trigger", var_0E);
    if(common_scripts\utility::func_3C77("moonraven_gear_1_collected")) {
      var_00 method_805B();
      var_00 lib_0378::func_8D74("aud_moonraven_gear_place");
      level.moonraven_gears_placed = level.moonraven_gears_placed + 1;
      common_scripts\utility::func_3C7B("moonraven_gear_1_collected");
    }

    if(common_scripts\utility::func_3C77("moonraven_gear_2_collected")) {
      var_01 method_805B();
      var_01 lib_0378::func_8D74("aud_moonraven_gear_place");
      level.moonraven_gears_placed = level.moonraven_gears_placed + 1;
      common_scripts\utility::func_3C7B("moonraven_gear_2_collected");
    }

    if(common_scripts\utility::func_3C77("moonraven_gear_3_collected")) {
      var_02 method_805B();
      var_02 lib_0378::func_8D74("aud_moonraven_gear_place");
      level.moonraven_gears_placed = level.moonraven_gears_placed + 1;
      common_scripts\utility::func_3C7B("moonraven_gear_3_collected");
    }
  }

  common_scripts\utility::func_3C8F("moonraven_gears_all_placed");
  var_0F = 6;
  var_00 = getent("moonraven_gear_1_placed", "targetname");
  var_01 = getent("moonraven_gear_2_placed", "targetname");
  var_02 = getent("moonraven_gear_3_placed", "targetname");
  var_10 = getent("moonraven_gear_final_1", "targetname");
  var_11 = getent("moonraven_gear_final_2", "targetname");
  var_12 = getent("moonraven_gear_final_3", "targetname");
  var_13 = getent("moonraven_gear_art_horz_1", "targetname");
  var_14 = getent("moonraven_gear_art_horz_2", "targetname");
  var_15 = getent("moonraven_gear_art_vert_1", "targetname");
  var_16 = getent("moonraven_gear_art_vert_2", "targetname");
  var_17 = getent("moonraven_gear_art_vert_3", "targetname");
  while(!common_scripts\utility::func_3C77("moonraven_gears_stop_rotation")) {
    var_00 rotateby((0, 180, 0), var_0F);
    var_01 rotateby((0, 180, 0), var_0F);
    var_02 rotateby((0, 180, 0), var_0F);
    var_10 rotateby((0, -180, 0), var_0F);
    var_11 rotateby((0, 180, 0), var_0F);
    var_12 rotateby((0, 0, 180), var_0F);
    var_13 rotateby((180, 0, 0), var_0F);
    var_14 rotateby((-180, 0, 0), var_0F);
    var_15 rotateby((0, 180, 0), var_0F);
    var_16 rotateby((0, -180, 0), var_0F);
    var_17 rotateby((0, 180, 0), var_0F);
    var_10 lib_0378::func_8D74("aud_moonraven_orrery_lower_gears_move");
    wait(var_0F);
  }
}

quest_step_moonraven_machine() {
  common_scripts\utility::func_3C9F("moonraven_gears_all_placed");
  activateclientexploder(222);
  lib_0557::func_782D("quest_moonraven", "quest_moonraven_fix_machine");
}

moonraven_debug_fix_machine() {
  thread moonraven_debug_reveal_chart();
  var_00 = getent("moonraven_gear_find_01", "targetname");
  var_01 = getent("moonraven_gear_find_02", "targetname");
  var_02 = getent("moonraven_gear_find_03", "targetname");
  var_00 method_805C();
  var_01 method_805C();
  var_02 method_805C();
  common_scripts\utility::func_3C8F("moonraven_gears_all_placed");
  common_scripts\utility::func_3C8F("moonraven_all_keys_placed");
  thread moonraven_debug_fix_machine_extra();
  lib_0557::func_782D("quest_moonraven", "quest_moonraven_fix_machine");
}

moonraven_debug_fix_machine_extra() {
  var_00 = 6;
  var_01 = getent("moonraven_gear_1_placed", "targetname");
  var_02 = getent("moonraven_gear_2_placed", "targetname");
  var_03 = getent("moonraven_gear_3_placed", "targetname");
  var_04 = getent("moonraven_gear_final_1", "targetname");
  var_05 = getent("moonraven_gear_final_2", "targetname");
  var_06 = getent("moonraven_gear_final_3", "targetname");
  var_07 = getent("moonraven_gear_art_horz_1", "targetname");
  var_08 = getent("moonraven_gear_art_horz_2", "targetname");
  var_09 = getent("moonraven_gear_art_vert_1", "targetname");
  var_0A = getent("moonraven_gear_art_vert_2", "targetname");
  var_0B = getent("moonraven_gear_art_vert_3", "targetname");
  var_01 method_805B();
  var_02 method_805B();
  var_03 method_805B();
  while(!common_scripts\utility::func_3C77("moonraven_gears_stop_rotation")) {
    var_01 rotateby((0, 180, 0), var_00);
    var_02 rotateby((0, 180, 0), var_00);
    var_03 rotateby((0, 180, 0), var_00);
    var_04 rotateby((0, -180, 0), var_00);
    var_05 rotateby((0, 180, 0), var_00);
    var_06 rotateby((0, 0, 180), var_00);
    var_07 rotateby((180, 0, 0), var_00);
    var_08 rotateby((-180, 0, 0), var_00);
    var_09 rotateby((0, 180, 0), var_00);
    var_0A rotateby((0, -180, 0), var_00);
    var_0B rotateby((0, 180, 0), var_00);
    var_04 lib_0378::func_8D74("aud_moonraven_orrery_lower_gears_move");
    wait(var_00);
  }
}

moonraven_fix_machine_gear_watch(param_00, param_01) {
  param_00.var_9D65 waittill("trigger", var_02);
  param_00 lib_0378::func_8D74("aud_moonraven_gear_pickup");
  param_00.var_9D65 delete();
  param_00 delete();
  common_scripts\utility::func_3C8F(param_01);
  level.moonraven_gears_collected++;
  common_scripts\utility::func_3C8F("flag_gears_collected_" + level.moonraven_gears_collected);
}

moonraven_init_orrery_power() {
  common_scripts\utility::func_3CA0("moonraven_all_keys_placed", "moonraven_gears_all_placed");
  if(!common_scripts\utility::func_3C77("moonraven_orrery_collect_complete")) {
    var_00 = common_scripts\utility::func_46B5("moonraven_orrery_collect", "targetname");
    var_01 = 15;
    var_02 = 256;
    var_03 = 256;
    var_00.ignoresighttrace = 1;
    var_00 maps\mp\mp_zombies_soul_collection::beginazombiesoulcollectionobjectiveonstruct(var_01, var_02, var_03, "moonraven_orrery_collect", undefined, "tag_origin", undefined, "tag_origin", undefined, 1, undefined, undefined, 1, undefined, 0);
    common_scripts\utility::func_3C8F("moonraven_orrery_collect_complete");
  }
}

quest_step_moonraven_orrery_power() {
  common_scripts\utility::func_3C9F("moonraven_orrery_collect_complete");
  lib_0557::func_782D("quest_moonraven", "quest_moonraven_power_orrery");
}

moonraven_debug_orrery_power() {
  thread moonraven_debug_fix_machine();
  common_scripts\utility::func_3C8F("moonraven_orrery_collect_complete");
}

moonraven_init_moon_chart() {
  level.chart_index_a = 0;
  level.chart_index_b = 0;
  level.chart_index_c = 0;
  level.chart_index_d = 0;
  var_00 = 8;
  level.moon_chart_orbit_a = [];
  level.moon_chart_orbit_b = [];
  level.moon_chart_orbit_c = [];
  level.moon_chart_orbit_d = [];
  for(var_01 = 0; var_01 < var_00; var_01++) {
    var_02 = "moon_chart_A_" + var_01;
    level.moon_chart_orbit_a[var_01] = common_scripts\utility::func_46B5(var_02, "targetname");
    var_03 = "moon_chart_B_" + var_01;
    level.moon_chart_orbit_b[var_01] = common_scripts\utility::func_46B5(var_03, "targetname");
    var_04 = "moon_chart_C_" + var_01;
    level.moon_chart_orbit_c[var_01] = common_scripts\utility::func_46B5(var_04, "targetname");
    var_05 = "moon_chart_D_" + var_01;
    level.moon_chart_orbit_d[var_01] = common_scripts\utility::func_46B5(var_05, "targetname");
  }

  var_06 = [];
  for(var_01 = 0; var_01 < var_00; var_01++) {
    var_06[var_01] = var_01;
  }

  level.chart_index_a = common_scripts\utility::func_7A33(var_06);
  var_06 = common_scripts\utility::func_F93(var_06, level.chart_index_a);
  level.chart_index_b = common_scripts\utility::func_7A33(var_06);
  var_06 = common_scripts\utility::func_F93(var_06, level.chart_index_b);
  level.chart_index_c = common_scripts\utility::func_7A33(var_06);
  var_06 = common_scripts\utility::func_F93(var_06, level.chart_index_c);
  level.chart_index_d = common_scripts\utility::func_7A33(var_06);
  var_07 = getent("chart_moon_A", "targetname");
  var_08 = getent("chart_moon_B", "targetname");
  var_09 = getent("chart_moon_C", "targetname");
  var_0A = getent("chart_moon_D", "targetname");
  level.chart_a_fx = var_07;
  level.chart_b_fx = var_08;
  level.chart_c_fx = var_09;
  level.chart_d_fx = var_0A;
  var_07.var_116 = level.moon_chart_orbit_a[level.chart_index_a].var_116;
  var_08.var_116 = level.moon_chart_orbit_b[level.chart_index_b].var_116;
  var_09.var_116 = level.moon_chart_orbit_c[level.chart_index_c].var_116;
  var_0A.var_116 = level.moon_chart_orbit_d[level.chart_index_d].var_116;
  wait(1);
  var_0B = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_desc_leverglow_storm"), level.chart_a_fx, "tag_origin");
  triggerfx(var_0B);
  var_0C = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_desc_leverglow_moon"), level.chart_b_fx, "tag_origin");
  triggerfx(var_0C);
  var_0D = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_desc_leverglow_death"), level.chart_c_fx, "tag_origin");
  triggerfx(var_0D);
  var_0E = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_desc_leverglow_blood"), level.chart_d_fx, "tag_origin");
  triggerfx(var_0E);
}

quest_step_moonraven_acquire_weapon() {
  common_scripts\utility::func_3C9F("moonraven_orrery_complete");
  lib_0557::func_782D("quest_moonraven", "quest_moonraven_acquire_scepter");
}

moonraven_debug_acquire_weapon() {
  thread moonraven_debug_orrery_power();
  common_scripts\utility::func_3C8F("moonraven_orrery_complete");
  common_scripts\utility::func_3C8F("moonraven_orrery_solved");
  common_scripts\utility::func_3C77("orrery_moon_A_valid");
  common_scripts\utility::func_3C77("orrery_moon_B_valid");
  common_scripts\utility::func_3C77("orrery_moon_C_valid");
  common_scripts\utility::func_3C77("orrery_moon_D_valid");
  level.orrery_moon_a_trigger = getent("orrery_moon_A_trigger", "targetname");
  level.orrery_moon_b_trigger = getent("orrery_moon_B_trigger", "targetname");
  level.orrery_moon_c_trigger = getent("orrery_moon_C_trigger", "targetname");
  level.orrery_moon_d_trigger = getent("orrery_moon_D_trigger", "targetname");
  level.orrery_moon_a_trigger common_scripts\utility::func_9D9F();
  level.orrery_moon_b_trigger common_scripts\utility::func_9D9F();
  level.orrery_moon_c_trigger common_scripts\utility::func_9D9F();
  level.orrery_moon_d_trigger common_scripts\utility::func_9D9F();
  thread maps\mp\zombies\weapons\_zombie_dlc4_melee::spawn_raven_weapon("spike", common_scripts\utility::func_46B5("struct_temp_moonscepter", "targetname").var_116);
}

moonraven_init_orrery() {
  level.lever_moon_a = getent("moon_orrery_plinth_A", "targetname");
  level.lever_moon_b = getent("moon_orrery_plinth_B", "targetname");
  level.lever_moon_c = getent("moon_orrery_plinth_C", "targetname");
  level.lever_moon_d = getent("moon_orrery_plinth_D", "targetname");
  level.lever_moon_a method_805C();
  level.lever_moon_b method_805C();
  level.lever_moon_c method_805C();
  level.lever_moon_d method_805C();
  common_scripts\utility::func_3C9F("moonraven_orrery_collect_complete");
  level.orrery_moon_a = getent("orrery_moon_A", "targetname");
  level.orrery_moon_a.var_6C50 = level.orrery_moon_a.var_1D;
  level.orrery_moon_b = getent("orrery_moon_B", "targetname");
  level.orrery_moon_b.var_6C50 = level.orrery_moon_b.var_1D;
  level.orrery_moon_c = getent("orrery_moon_C", "targetname");
  level.orrery_moon_c.var_6C50 = level.orrery_moon_c.var_1D;
  level.orrery_moon_d = getent("orrery_moon_D", "targetname");
  level.orrery_moon_d.var_6C50 = level.orrery_moon_d.var_1D;
  level.orrery_moon_a.var_D4 = 1;
  level.orrery_moon_b.var_D4 = 7;
  level.orrery_moon_c.var_D4 = 2;
  level.orrery_moon_d.var_D4 = 0;
  level.orrery_yaw_offset = 150;
  level.orrery_moon_a.yaw_offset = level.orrery_yaw_offset + level.orrery_moon_a.var_D4 * 45;
  level.orrery_moon_b.yaw_offset = level.orrery_yaw_offset + level.orrery_moon_b.var_D4 * 45;
  level.orrery_moon_c.yaw_offset = level.orrery_yaw_offset + level.orrery_moon_c.var_D4 * 45;
  level.orrery_moon_d.yaw_offset = level.orrery_yaw_offset + level.orrery_moon_d.var_D4 * 45;
  level.orrery_moon_a.orbit_time = 4;
  level.orrery_moon_b.orbit_time = 3;
  level.orrery_moon_c.orbit_time = 2;
  level.orrery_moon_d.orbit_time = 1;
  level.orrery_moon_a_trigger = getent("orrery_moon_A_trigger", "targetname");
  level.orrery_moon_b_trigger = getent("orrery_moon_B_trigger", "targetname");
  level.orrery_moon_c_trigger = getent("orrery_moon_C_trigger", "targetname");
  level.orrery_moon_d_trigger = getent("orrery_moon_D_trigger", "targetname");
  level.orrery_max_index = 7;
  level.orrery_check_time = 90;
  level.orrery_moons_stopped = 0;
  level.lever_moon_a method_805B();
  level.lever_moon_b method_805B();
  level.lever_moon_c method_805B();
  level.lever_moon_d method_805B();
  level.lever_moon_a thread maps\mp\zombies\weapons\_zombie_dlc4_melee::wep_spin();
  level.lever_moon_a thread maps\mp\zombies\weapons\_zombie_dlc4_melee::wep_bounce();
  level.lever_moon_b thread maps\mp\zombies\weapons\_zombie_dlc4_melee::wep_spin();
  level.lever_moon_b thread maps\mp\zombies\weapons\_zombie_dlc4_melee::wep_bounce();
  level.lever_moon_c thread maps\mp\zombies\weapons\_zombie_dlc4_melee::wep_spin();
  level.lever_moon_c thread maps\mp\zombies\weapons\_zombie_dlc4_melee::wep_bounce();
  level.lever_moon_d thread maps\mp\zombies\weapons\_zombie_dlc4_melee::wep_spin();
  level.lever_moon_d thread maps\mp\zombies\weapons\_zombie_dlc4_melee::wep_bounce();
  thread moonraven_orrery_rotate_moon(level.orrery_moon_a, level.orrery_moon_a.var_1D[1] - level.orrery_moon_a.yaw_offset, level.chart_index_a, "orrery_moon_A_stop", "orrery_moon_A_valid", level.orrery_moon_a.orbit_time);
  thread moonraven_orrery_rotate_moon(level.orrery_moon_b, level.orrery_moon_b.var_1D[1] - level.orrery_moon_b.yaw_offset, level.chart_index_b, "orrery_moon_B_stop", "orrery_moon_B_valid", level.orrery_moon_b.orbit_time);
  thread moonraven_orrery_rotate_moon(level.orrery_moon_c, level.orrery_moon_c.var_1D[1] - level.orrery_moon_c.yaw_offset, level.chart_index_c, "orrery_moon_C_stop", "orrery_moon_C_valid", level.orrery_moon_c.orbit_time);
  thread moonraven_orrery_rotate_moon(level.orrery_moon_d, level.orrery_moon_d.var_1D[1] - level.orrery_moon_d.yaw_offset, level.chart_index_d, "orrery_moon_D_stop", "orrery_moon_D_valid", level.orrery_moon_d.orbit_time);
  thread moonraven_orrery_stop_moon(level.orrery_moon_a, level.chart_index_a, level.orrery_moon_a_trigger, "orrery_moon_A_stop", "orrery_moon_A_valid");
  thread moonraven_orrery_stop_moon(level.orrery_moon_b, level.chart_index_b, level.orrery_moon_b_trigger, "orrery_moon_B_stop", "orrery_moon_B_valid");
  thread moonraven_orrery_stop_moon(level.orrery_moon_c, level.chart_index_c, level.orrery_moon_c_trigger, "orrery_moon_C_stop", "orrery_moon_C_valid");
  thread moonraven_orrery_stop_moon(level.orrery_moon_d, level.chart_index_d, level.orrery_moon_d_trigger, "orrery_moon_D_stop", "orrery_moon_D_valid");
  thread moonraven_orrery_success_watch();
}

moonraven_orrery_rotate_moon(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_desc_planetglow_storm"), level.orrery_moon_a, "tag_origin");
  triggerfx(var_06);
  var_07 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_desc_planetglow_moon"), level.orrery_moon_b, "tag_origin");
  triggerfx(var_07);
  var_08 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_desc_planetglow_death"), level.orrery_moon_c, "tag_origin");
  triggerfx(var_08);
  var_09 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_desc_planetglow_blood"), level.orrery_moon_d, "tag_origin");
  triggerfx(var_09);
  var_0A = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_desc_leverglow_storm"), level.lever_moon_a, "tag_origin");
  triggerfx(var_0A);
  var_0B = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_desc_leverglow_moon"), level.lever_moon_b, "tag_origin");
  triggerfx(var_0B);
  var_0C = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_desc_leverglow_death"), level.lever_moon_c, "tag_origin");
  triggerfx(var_0C);
  var_0D = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_desc_leverglow_blood"), level.lever_moon_d, "tag_origin");
  triggerfx(var_0D);
  lib_0378::func_8D74("aud_moonraven_orrery_move", param_00);
  while(!common_scripts\utility::func_3C77(param_03)) {
    param_01 = param_01 + 45;
    if(param_01 > 359) {
      param_01 = 0;
    }

    param_00 rotateto(combineangles(param_00.var_6C50, (0, param_01, 0)), param_05);
    wait(param_05);
    param_00.var_D4 = param_00.var_D4 + 1;
    if(param_00.var_D4 > level.orrery_max_index) {
      param_00.var_D4 = 0;
    }

    if(param_00.var_D4 == param_02 && common_scripts\utility::func_3C77(param_03)) {
      param_00 lib_0378::func_8D74("aud_moonraven_orrery_lock");
      common_scripts\utility::func_3C8F(param_04);
      continue;
    }

    if(common_scripts\utility::func_3C77(param_03)) {
      lib_0378::func_8D74("aud_moonraven_orrery_stop", param_00);
    }
  }

  var_06 delete();
  var_06 = undefined;
  var_07 delete();
  var_07 = undefined;
  var_08 delete();
  var_08 = undefined;
  var_09 delete();
  var_09 = undefined;
  var_0A delete();
  var_0A = undefined;
  var_0B delete();
  var_0B = undefined;
  var_0C delete();
  var_0C = undefined;
  var_0D delete();
  var_0D = undefined;
}

moonraven_orrery_stop_moon(param_00, param_01, param_02, param_03, param_04) {
  param_02 waittill("trigger", var_05);
  param_02 common_scripts\utility::func_9D9F();
  common_scripts\utility::func_3C8F(param_03);
  moonraven_orrery_validate_moon(param_00, param_01, param_02, param_03, param_04);
}

moonraven_orrery_validate_moon(param_00, param_01, param_02, param_03, param_04) {
  wait(6);
  level.orrery_moons_stopped = level.orrery_moons_stopped + 1;
  while(level.orrery_moons_stopped < 4) {
    wait 0.05;
  }

  wait(3);
  level.orrery_moons_stopped = level.orrery_moons_stopped - 1;
  while(level.orrery_moons_stopped > 0) {
    wait 0.05;
  }

  if(!common_scripts\utility::func_3C77("moonraven_orrery_solved")) {
    param_02 common_scripts\utility::func_9DA3();
    common_scripts\utility::func_3C7B(param_03);
    common_scripts\utility::func_3C7B(param_04);
    var_05 = param_00.var_1D[1] - param_00.yaw_offset;
    thread moonraven_orrery_rotate_moon(param_00, var_05, param_01, param_03, param_04, param_00.orbit_time);
    thread moonraven_orrery_stop_moon(param_00, param_01, param_02, param_03, param_04);
  }
}

moonraven_orrery_success_watch() {
  while(!common_scripts\utility::func_3C77("moonraven_orrery_solved")) {
    if(common_scripts\utility::func_3C77("orrery_moon_A_valid") && common_scripts\utility::func_3C77("orrery_moon_B_valid") && common_scripts\utility::func_3C77("orrery_moon_C_valid") && common_scripts\utility::func_3C77("orrery_moon_D_valid")) {
      common_scripts\utility::func_3C8F("moonraven_orrery_solved");
      thread maps\mp\zombies\weapons\_zombie_dlc4_melee::spawn_raven_weapon("spike", common_scripts\utility::func_46B5("struct_temp_moonscepter", "targetname").var_116);
    }

    wait 0.05;
  }

  common_scripts\utility::func_3C8F("moonraven_orrery_complete");
  var_00 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_desc_planetglow_storm_cmplt"), level.orrery_moon_a, "tag_origin");
  triggerfx(var_00);
  var_01 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_desc_planetglow_moon_cmplt"), level.orrery_moon_b, "tag_origin");
  triggerfx(var_01);
  var_02 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_desc_planetglow_death_cmplt"), level.orrery_moon_c, "tag_origin");
  triggerfx(var_02);
  var_03 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_desc_planetglow_blood_cmplt"), level.orrery_moon_d, "tag_origin");
  triggerfx(var_03);
  wait(5);
  var_00 delete();
  var_00 = undefined;
  var_01 delete();
  var_01 = undefined;
  var_02 delete();
  var_02 = undefined;
  var_03 delete();
  var_03 = undefined;
}

moonraven_init_constellations() {
  common_scripts\utility::func_3C87("flag_start_test");
  common_scripts\utility::func_3C87("flag_stars_complete");
  level.star_models = getEntArray("moonraven_star_model", "targetname");
  foreach(var_01 in level.star_models) {
    var_02 = getent(var_01.var_1A2, "targetname");
    var_01 method_805C();
    var_02 method_805C();
    var_01.tagged = 0;
    var_01.solved = 0;
    var_02.tagged = 0;
    var_02.solved = 0;
  }

  var_04 = common_scripts\utility::func_46B7("moonraven_star_location", "targetname");
  var_05 = getEntArray("moonraven_star_prefab", "targetname");
  var_06 = getEntArray("moonraven_star_rune", "targetname");
  var_07 = ["rune_1", "rune_2", "rune_3", "rune_4", "rune_5", "rune_6", "rune_7", "rune_8"];
  foreach(var_09 in var_06) {
    var_09 method_805C();
  }

  level.star_index_a = common_scripts\utility::func_7A33(var_07);
  var_07 = common_scripts\utility::func_F93(var_07, level.star_index_a);
  level.star_index_b = common_scripts\utility::func_7A33(var_07);
  var_07 = common_scripts\utility::func_F93(var_07, level.star_index_b);
  level.star_index_c = common_scripts\utility::func_7A33(var_07);
  var_0B = undefined;
  var_0C = undefined;
  var_0D = undefined;
  foreach(var_0F in var_05) {
    if(var_0F.var_8260 == level.star_index_a) {
      var_0B = var_0F;
      continue;
    }

    if(var_0F.var_8260 == level.star_index_b) {
      var_0C = var_0F;
      continue;
    }

    if(var_0F.var_8260 == level.star_index_c) {
      var_0D = var_0F;
    }
  }

  var_11 = getEntArray(level.star_index_a, "script_noteworthy");
  var_12 = getEntArray(level.star_index_b, "script_noteworthy");
  var_13 = getEntArray(level.star_index_c, "script_noteworthy");
  level.star_count_a = 0;
  level.star_count_b = 0;
  level.star_count_c = 0;
  foreach(var_15 in var_11) {
    if(var_15.var_3A != "script_origin") {
      var_15 method_8449(var_0B);
      level.star_count_a = level.star_count_a + 1;
    }
  }

  foreach(var_15 in var_12) {
    if(var_15.var_3A != "script_origin") {
      var_15 method_8449(var_0C);
      level.star_count_b = level.star_count_b + 1;
    }
  }

  foreach(var_15 in var_13) {
    if(var_15.var_3A != "script_origin") {
      var_15 method_8449(var_0D);
      level.star_count_c = level.star_count_c + 1;
    }
  }

  level.star_count_a = level.star_count_a / 2;
  level.star_count_b = level.star_count_b / 2;
  level.star_count_c = level.star_count_c / 2;
  var_1B = common_scripts\utility::func_7A33(var_04);
  var_04 = common_scripts\utility::func_F93(var_04, var_1B);
  var_1C = common_scripts\utility::func_7A33(var_04);
  var_04 = common_scripts\utility::func_F93(var_04, var_1C);
  var_1D = common_scripts\utility::func_7A33(var_04);
  level.moon_rune_a = undefined;
  level.moon_rune_b = undefined;
  level.moon_rune_c = undefined;
  foreach(var_09 in var_06) {
    if(var_09.var_8260 == level.star_index_a) {
      level.moon_rune_a = var_09;
      continue;
    }

    if(var_09.var_8260 == level.star_index_b) {
      level.moon_rune_b = var_09;
      continue;
    }

    if(var_09.var_8260 == level.star_index_c) {
      level.moon_rune_c = var_09;
    }
  }

  var_20 = common_scripts\utility::func_46B5("moonraven_alcove_rune_A", "targetname");
  var_21 = common_scripts\utility::func_46B5("moonraven_alcove_rune_B", "targetname");
  var_22 = common_scripts\utility::func_46B5("moonraven_alcove_rune_C", "targetname");
  level.moon_rune_a.var_116 = var_20.var_116;
  level.moon_rune_a.var_1D = var_20.var_1D;
  level.moon_rune_b.var_116 = var_21.var_116;
  level.moon_rune_b.var_1D = var_21.var_1D;
  level.moon_rune_c.var_116 = var_22.var_116;
  level.moon_rune_c.var_1D = var_22.var_1D;
  level.star_scan_count = 0;
  level.star_scan_complete_a = 0;
  level.star_scan_complete_b = 0;
  level.star_scan_complete_c = 0;
  level.star_scan_current_rune = level.star_index_a;
  common_scripts\utility::func_3C9F("moonraven_alcove_collect_1_complete");
  var_0B.var_116 = var_1B.var_116;
  var_0B.var_1D = var_1B.var_1D;
  common_scripts\utility::func_3C9F("moonraven_alcove_collect_2_complete");
  var_0C.var_116 = var_1C.var_116;
  var_0C.var_1D = var_1C.var_1D;
  common_scripts\utility::func_3C9F("moonraven_alcove_collect_3_complete");
  var_0D.var_116 = var_1D.var_116;
  var_0D.var_1D = var_1D.var_1D;
}

moonraven_contellation_vision() {
  foreach(var_01 in level.star_models) {
    var_02 = getent(var_01.var_1A2, "targetname");
    if(isDefined(var_01.solved) && var_01.solved) {
      level.star_models = common_scripts\utility::func_F93(level.star_models, var_01);
      var_01 method_805B();
      var_02 method_805B();
      continue;
    }

    var_01 method_805C();
    var_02 method_805C();
  }

  thread moonraven_contellation_vision_toggle();
  thread moonraven_contellation_vision_lost();
}

moonraven_contellation_vision_toggle() {
  level.showstars = 0;
  var_00 = self;
  var_00 endon("disconnect");
  while(!common_scripts\utility::func_3C77("flag_stars_complete")) {
    if(common_scripts\utility::func_562E(self.spike_vision_enabled) && !level.showstars) {
      level.showstars = 1;
      var_00 enable_star_view();
    } else if(!common_scripts\utility::func_562E(self.spike_vision_enabled)) {
      disable_star_view();
      level.showstars = 0;
    }

    wait 0.05;
    if(!lib_0547::func_5565(level.ravenweaponmanager["spike"].var_117, var_00)) {
      if(common_scripts\utility::func_562E(level.showstars)) {
        disable_star_view();
        level.showstars = 0;
      }

      return;
    }
  }
}

enable_star_view() {
  var_00 = self;
  foreach(var_02 in level.star_models) {
    if(distancesquared(var_00.var_116, var_02.var_116) < 4000000) {
      var_02 showtoclient(self);
      thread moonraven_contellation_vision_scan();
    }
  }
}

disable_star_view() {
  foreach(var_01 in level.star_models) {
    if(!var_01.solved) {
      var_01 method_805C();
    }
  }
}

moonraven_contellation_vision_scan() {
  while(level.showstars) {
    foreach(var_01 in level.star_models) {
      if(maps\mp\_utility::findplayerisfacing(self, var_01, 8) && !var_01.tagged && var_01.var_8260 == level.star_scan_current_rune) {
        var_02 = getent(var_01.var_1A2, "targetname");
        var_02 showtoclient(self);
        lib_0378::func_8D74("aud_moonraven_constellation_find");
        var_01 method_805C();
        var_01.tagged = 1;
        level.star_scan_count = level.star_scan_count + 1;
        if(!level.star_scan_complete_a && level.star_scan_count >= level.star_count_a && !common_scripts\utility::func_3C77("moon_constellation_1_complete")) {
          level.star_scan_complete_a = 1;
          level.star_scan_count = 0;
          level.star_scan_current_rune = level.star_index_b;
          common_scripts\utility::func_3C8F("moon_constellation_1_complete");
          lib_0378::func_8D74("aud_moonraven_constellation_done");
        } else if(!level.star_scan_complete_b && level.star_scan_count >= level.star_count_b && common_scripts\utility::func_3C77("moon_constellation_1_complete") && !common_scripts\utility::func_3C77("moon_constellation_2_complete")) {
          level.star_scan_complete_b = 1;
          level.star_scan_count = 0;
          level.star_scan_current_rune = level.star_index_c;
          common_scripts\utility::func_3C8F("moon_constellation_2_complete");
          lib_0378::func_8D74("aud_moonraven_constellation_done");
        } else if(!level.star_scan_complete_c && level.star_scan_count >= level.star_count_c && common_scripts\utility::func_3C77("moon_constellation_2_complete") && !common_scripts\utility::func_3C77("moon_constellation_3_complete")) {
          level.star_scan_complete_c = 1;
          level.star_scan_count = 0;
          level.star_scan_current_rune = "";
          common_scripts\utility::func_3C8F("moon_constellation_3_complete");
          lib_0378::func_8D74("aud_moonraven_constellation_done");
        }
      }
    }

    wait 0.05;
  }

  level.star_scan_count = 0;
  foreach(var_01 in level.star_models) {
    if((level.star_scan_complete_a && var_01.var_8260 == level.star_index_a) || (level.star_scan_complete_b && var_01.var_8260 == level.star_index_b) || level.star_scan_complete_c && var_01.var_8260 == level.star_index_c) {
      level.star_models = common_scripts\utility::func_F93(level.star_models, var_01);
      var_02 = getent(var_01.var_1A2, "targetname");
      var_01.solved = 1;
      var_02.solved = 1;
    }
  }

  foreach(var_01 in level.star_models) {
    if(!var_01.solved) {
      var_01.tagged = 0;
      var_02 = getent(var_01.var_1A2, "targetname");
      var_02 method_805C();
    }
  }
}

moonraven_contellation_vision_lost() {
  common_scripts\utility::knock_off_battery("spike_lost", "disconnect");
  level.showstars = 0;
  foreach(var_01 in level.star_models) {
    var_02 = getent(var_01.var_1A2, "targetname");
    var_01 method_805C();
    var_02 method_805C();
  }
}

moonraven_init_alcove() {
  common_scripts\utility::func_3C9F("moonraven_orrery_complete");
  var_00 = common_scripts\utility::func_46B5("moonraven_alcove_collect_1_melee", "targetname");
  var_01 = common_scripts\utility::func_46B5("moonraven_alcove_collect_1_grenade", "targetname");
  var_02 = common_scripts\utility::func_46B5("moonraven_alcove_collect_2_melee", "targetname");
  var_03 = common_scripts\utility::func_46B5("moonraven_alcove_collect_2_grenade", "targetname");
  var_04 = common_scripts\utility::func_46B5("moonraven_alcove_collect_3_melee", "targetname");
  var_05 = common_scripts\utility::func_46B5("moonraven_alcove_collect_3_grenade", "targetname");
  level.moon_alcove_collect_1_count = 0;
  level.moon_alcove_collect_2_count = 0;
  level.moon_alcove_collect_3_count = 0;
  level.moon_alcove_collect_goal = 3;
  var_00 thread moonraven_alcove_collect_setup("moon_alcove_collect_1_melee_notify", "zom_dlc4_spike_zm", level.moon_alcove_collect_1_count, "moonraven_alcove_collect_1_complete");
  common_scripts\utility::func_3C9F("moonraven_alcove_collect_1_complete");
  level.moon_rune_a method_805B();
  level.moon_rune_a thread maps\mp\zombies\weapons\_zombie_dlc4_melee::wep_bounce();
  common_scripts\utility::func_3C9F("moon_constellation_1_complete");
  var_02 thread moonraven_alcove_collect_setup("moon_alcove_collect_2_melee_notify", "zom_dlc4_spike_zm", level.moon_alcove_collect_2_count, "moonraven_alcove_collect_2_complete");
  common_scripts\utility::func_3C9F("moonraven_alcove_collect_2_complete");
  level.moon_rune_b method_805B();
  level.moon_rune_b thread maps\mp\zombies\weapons\_zombie_dlc4_melee::wep_bounce();
  common_scripts\utility::func_3C9F("moon_constellation_2_complete");
  var_04 thread moonraven_alcove_collect_setup("moon_alcove_collect_3_melee_notify", "zom_dlc4_spike_zm", level.moon_alcove_collect_3_count, "moonraven_alcove_collect_3_complete");
  common_scripts\utility::func_3C9F("moonraven_alcove_collect_3_complete");
  level.moon_rune_c method_805B();
  level.moon_rune_c thread maps\mp\zombies\weapons\_zombie_dlc4_melee::wep_bounce();
  common_scripts\utility::func_3C9F("moon_constellation_3_complete");
}

moonraven_alcove_collect_setup(param_00, param_01, param_02, param_03) {
  level endon(param_03);
  moonraven_alcove_collect(param_00, param_01);
  common_scripts\utility::func_3C8F(param_03);
}

moonraven_alcove_collect(param_00, param_01) {
  var_02 = level.moon_alcove_collect_goal;
  var_03 = 120;
  var_04 = 120;
  maps\mp\mp_zombies_soul_collection::beginazombiesoulcollectionobjectiveonstruct(var_02, var_03, var_04, param_00, undefined, "tag_origin", undefined, "tag_origin", param_01, undefined, (0, 0, 32));
}

quest_step_moonraven_scan() {
  common_scripts\utility::func_3CA0("moon_constellation_1_complete", "moon_constellation_2_complete", "moon_constellation_3_complete");
  common_scripts\utility::func_3C8F("flag_stars_complete");
  lib_0557::func_782D("quest_moonraven", "quest_moonraven_scan");
}

moonraven_debug_scan() {
  thread moonraven_debug_acquire_weapon();
  common_scripts\utility::func_3C8F("moon_constellation_1_complete");
  common_scripts\utility::func_3C8F("moon_constellation_2_complete");
  common_scripts\utility::func_3C8F("moon_constellation_3_complete");
  lib_0557::func_782D("quest_moonraven", "quest_moonraven_scan");
}

quest_step_moonraven_alcove() {
  common_scripts\utility::func_3CA0("moonraven_alcove_collect_1_complete", "moonraven_alcove_collect_2_complete", "moonraven_alcove_collect_3_complete");
  common_scripts\utility::func_3C8F("moon_trial_unlocked");
  lib_0557::func_782D("quest_moonraven", "quest_moonraven_alcove");
}

moonraven_debug_alcove() {
  thread moonraven_debug_scan();
  common_scripts\utility::func_3C8F("moon_constellation_1_complete");
  common_scripts\utility::func_3C8F("moon_constellation_2_complete");
  common_scripts\utility::func_3C8F("moon_constellation_3_complete");
  common_scripts\utility::func_3C8F("moon_trial_unlocked");
  lib_0557::func_782D("quest_moonraven", "quest_moonraven_alcove");
}

quest_step_moonraven_unlock_trial() {
  common_scripts\utility::func_3C9F("moon_trial_unlocked");
  activateclientexploder(236);
  lib_0557::func_782D("quest_moonraven", "quest_moonraven_unlock_trial");
}

moonraven_debug_unlock_trial() {
  thread moonraven_debug_alcove();
  common_scripts\utility::func_3C8F("moon_trial_unlocked");
  activateclientexploder(236);
  lib_0557::func_782D("quest_moonraven", "quest_moonraven_unlock_trial");
}

quest_step_moonraven_enter_trial() {}

get_scepter_owner() {
  for(;;) {
    var_00 = level.ravenweaponmanager["spike"].var_117;
    if(isDefined(var_00)) {
      return var_00;
    }

    wait 0.05;
  }
}

moonraven_debug_orrery_capture() {
  activateclientexploder(236);
  level.orrery_moon_a = getent("orrery_moon_A", "targetname");
  level.orrery_moon_a.var_6C50 = level.orrery_moon_a.var_1D;
  level.orrery_moon_b = getent("orrery_moon_B", "targetname");
  level.orrery_moon_b.var_6C50 = level.orrery_moon_b.var_1D;
  level.orrery_moon_c = getent("orrery_moon_C", "targetname");
  level.orrery_moon_c.var_6C50 = level.orrery_moon_c.var_1D;
  level.orrery_moon_d = getent("orrery_moon_D", "targetname");
  level.orrery_moon_d.var_6C50 = level.orrery_moon_d.var_1D;
  level.orrery_moon_a.var_D4 = 1;
  level.orrery_moon_b.var_D4 = 7;
  level.orrery_moon_c.var_D4 = 2;
  level.orrery_moon_d.var_D4 = 0;
  level.orrery_yaw_offset = 150;
  level.orrery_moon_a.yaw_offset = level.orrery_yaw_offset + level.orrery_moon_a.var_D4 * 45;
  level.orrery_moon_b.yaw_offset = level.orrery_yaw_offset + level.orrery_moon_b.var_D4 * 45;
  level.orrery_moon_c.yaw_offset = level.orrery_yaw_offset + level.orrery_moon_c.var_D4 * 45;
  level.orrery_moon_d.yaw_offset = level.orrery_yaw_offset + level.orrery_moon_d.var_D4 * 45;
  level.orrery_moon_a.orbit_time = 4;
  level.orrery_moon_b.orbit_time = 3;
  level.orrery_moon_c.orbit_time = 2;
  level.orrery_moon_d.orbit_time = 1;
  level.orrery_moon_a_trigger = getent("orrery_moon_A_trigger", "targetname");
  level.orrery_moon_b_trigger = getent("orrery_moon_B_trigger", "targetname");
  level.orrery_moon_c_trigger = getent("orrery_moon_C_trigger", "targetname");
  level.orrery_moon_d_trigger = getent("orrery_moon_D_trigger", "targetname");
  level.orrery_max_index = 7;
  level.orrery_check_time = 90;
  level.orrery_moons_stopped = 0;
  thread moonraven_debug_orrery_capture_rotate_moon(level.orrery_moon_a, level.orrery_moon_a.var_1D[1] - level.orrery_moon_a.yaw_offset, level.chart_index_a, "orrery_moon_A_stop", "orrery_moon_A_valid", level.orrery_moon_a.orbit_time);
  thread moonraven_debug_orrery_capture_rotate_moon(level.orrery_moon_b, level.orrery_moon_b.var_1D[1] - level.orrery_moon_b.yaw_offset, level.chart_index_b, "orrery_moon_B_stop", "orrery_moon_B_valid", level.orrery_moon_b.orbit_time);
  thread moonraven_debug_orrery_capture_rotate_moon(level.orrery_moon_c, level.orrery_moon_c.var_1D[1] - level.orrery_moon_c.yaw_offset, level.chart_index_c, "orrery_moon_C_stop", "orrery_moon_C_valid", level.orrery_moon_c.orbit_time);
  thread moonraven_debug_orrery_capture_rotate_moon(level.orrery_moon_d, level.orrery_moon_d.var_1D[1] - level.orrery_moon_d.yaw_offset, level.chart_index_d, "orrery_moon_D_stop", "orrery_moon_D_valid", level.orrery_moon_d.orbit_time);
}

moonraven_debug_orrery_capture_rotate_moon(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_desc_planetglow_storm"), level.orrery_moon_a, "tag_origin");
  triggerfx(var_06);
  var_07 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_desc_planetglow_moon"), level.orrery_moon_b, "tag_origin");
  triggerfx(var_07);
  var_08 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_desc_planetglow_death"), level.orrery_moon_c, "tag_origin");
  triggerfx(var_08);
  var_09 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_desc_planetglow_blood"), level.orrery_moon_d, "tag_origin");
  triggerfx(var_09);
  lib_0378::func_8D74("aud_moonraven_orrery_move", param_00);
  while(!common_scripts\utility::func_3C77(param_03)) {
    param_01 = param_01 + 45;
    if(param_01 > 359) {
      param_01 = 0;
    }

    param_00 rotateto(combineangles(param_00.var_6C50, (0, param_01, 0)), param_05);
    wait(param_05);
    param_00.var_D4 = param_00.var_D4 + 1;
    if(param_00.var_D4 > level.orrery_max_index) {
      param_00.var_D4 = 0;
    }

    if(param_00.var_D4 == param_02 && common_scripts\utility::func_3C77(param_03)) {
      param_00 lib_0378::func_8D74("aud_moonraven_orrery_lock");
      common_scripts\utility::func_3C8F(param_04);
      continue;
    }

    if(common_scripts\utility::func_3C77(param_03)) {
      lib_0378::func_8D74("aud_moonraven_orrery_stop", param_00);
    }
  }

  var_06 delete();
  var_06 = undefined;
  var_07 delete();
  var_07 = undefined;
  var_08 delete();
  var_08 = undefined;
  var_09 delete();
  var_09 = undefined;
}

_____obj_boss_fight____() {}

init_boss_fight_quest() {
  boss_flag_inits();
  level.bossfight = spawnStruct();
  level.bossfight.boss_pos = common_scripts\utility::func_46B7("struct_boss_pos", "targetname");
  level.bossfight.boss_pos_wave0 = [];
  level.bossfight.boss_pos_wave1 = [];
  level.bossfight.boss_pos_wave2 = [];
  level.bossfight.boss_pos_wave3 = [];
  level.bossfight.boss_pos_wave6 = [];
  foreach(var_01 in level.bossfight.boss_pos) {
    if(!isDefined(var_01.var_165)) {
      continue;
    }

    if(lib_0547::func_5565(int(var_01.var_165), 0)) {
      level.bossfight.boss_pos_wave0[level.bossfight.boss_pos_wave0.size] = var_01;
    }

    if(lib_0547::func_5565(int(var_01.var_165), 1)) {
      level.bossfight.boss_pos_wave1[level.bossfight.boss_pos_wave1.size] = var_01;
    }

    if(lib_0547::func_5565(int(var_01.var_165), 2)) {
      level.bossfight.boss_pos_wave2[level.bossfight.boss_pos_wave2.size] = var_01;
    }

    if(lib_0547::func_5565(int(var_01.var_165), 3)) {
      level.bossfight.boss_pos_wave3[level.bossfight.boss_pos_wave3.size] = var_01;
    }

    if(lib_0547::func_5565(int(var_01.var_165), 6)) {
      level.bossfight.boss_pos_wave6[level.bossfight.boss_pos_wave6.size] = var_01;
    }
  }

  level.bossfight.boss_blood_pos = getEntArray("org_boss_blood_pos", "script_noteworthy");
  level.bossfight.boss_drain_pos = getent("org_boss_drain_pos", "script_noteworthy");
  level.bossfight.throne_pos = getent("org_boss_throne_pos", "script_noteworthy");
  level.bossfight.boss_sun_pos = common_scripts\utility::func_46B7("struct_boss_sun_pos", "targetname");
  level thread maps\mp\_utility::func_6F74(::handle_player_boss_respawn);
}

handle_player_boss_respawn() {
  var_00 = getent("player_boss_respawner", "targetname");
  var_01 = self;
  for(;;) {
    var_00 waittill("trigger", var_02);
    if(var_02 != var_01) {
      continue;
    }

    if(!isDefined(level.zmb_temp_moon_orb_ent)) {
      level.zmb_temp_moon_orb_ent = var_01 common_scripts\utility::func_8FFC();
      level.zmb_temp_moon_orb_ent method_805B();
    }

    var_01 maps\mp\zombies\weapons\_zombie_dlc4_melee::do_moon_orb_teleportation(var_01.bossstartorigin, level.zmb_temp_moon_orb_ent);
    var_01 do_damage_until_last_stand();
  }
}

do_damage_until_last_stand() {
  var_00 = self;
  var_00 endon("revive");
  var_00 endon("death");
  while(!common_scripts\utility::func_562E(var_00.var_5728)) {
    var_00 dodamage(var_00.var_BC + 1, var_00.var_116, level.zmb_temp_moon_orb_ent, level.zmb_temp_moon_orb_ent, "MOD_MELEE");
    wait 0.05;
  }
}

boss_flag_inits() {
  common_scripts\utility::func_3C87("flag_boss_fight_start");
  common_scripts\utility::func_3C87("flag_boss_complete");
  common_scripts\utility::func_3C87("flag_entered_boss_arena");
  common_scripts\utility::func_3C87("flag_boss_arena_teleport_began");
}

sort_by_script_noteworthy() {
  if(!isDefined(self.var_165)) {
    return 0;
  }

  return int(self.var_165);
}

sort_by_script_wtf() {
  if(!isDefined(self.var_82EC)) {
    return 0;
  }

  return int(self.var_82EC);
}

quest_step_boss_open() {
  common_scripts\utility::func_3C9F("flag_entered_boss_arena");
  lib_0557::func_782D("quest_bossfight", "quest_bossfight_open");
}

get_available_players() {
  final_boss_setup();
  final_boss_intro_scene();
  common_scripts\utility::func_3C9F("flag_boss_fight_start");
  thread maps\mp\_utility::func_6F74(::prep_player_for_fight);
  spawn_raven_weapons_in_boss_room();
  start_boss_fight();
  clear_boss_fight();
  lib_0557::func_782D("quest_bossfight", "quest_bossfight_start");
  thread maps\mp\mp_zombie_descent_utils::vo_radio_convo_boss_end();
}

prep_player_for_fight() {
  if(isDefined(self.isintrial)) {
    self.isintrial = undefined;
  }

  if(isDefined(self.inasneakyplace)) {
    self.inasneakyplace = 0;
  }

  if(isDefined(self.hitchingaride)) {
    self.hitchingaride = 0;
  }

  if(isDefined(self.isbloodtubemoonorbblocked)) {
    self.isbloodtubemoonorbblocked = undefined;
  }

  if(isDefined(self.tryingtoleavepap)) {
    self.tryingtoleavepap = 0;
  }

  if(isDefined(self.isonpushcooldown)) {
    self.isonpushcooldown = 0;
  }

  if(isDefined(self.var_480F)) {
    self.var_480F = 0;
  }
}

final_boss_intro_scene() {
  level.var_6F1E = 1;
  var_00 = lib_0547::func_408F();
  foreach(var_02 in var_00) {
    var_02 suicide();
  }

  var_04 = common_scripts\utility::func_46B5("godking_intro_node", "targetname");
  var_05 = spawn("script_model", var_04.var_116);
  var_05 setModel("zom_hero_f_bat_wholebody_dlc4");
  var_05.var_1D = var_04.var_1D;
  var_06 = spawn("script_model", var_04.var_116);
  var_06 setModel("npc_zom_barb_sword_02");
  var_06 method_8449(var_05, "TAG_WEAPON_RIGHT", (0, 0, 0), (0, 0, 0));
  var_07 = spawn("script_model", var_04.var_116);
  var_07 setModel("zom_darkone_base");
  var_07.var_1D = var_04.var_1D;
  var_08 = spawn("script_model", (0, 0, 0));
  var_08 setModel("player_generic_world_body");
  var_08 method_8511();
  var_09 = % s2_zom_gdk_intro_godking;
  var_0A = % s2_zom_gdk_intro_vm;
  var_0B = % s2_zom_gdk_intro_vivian;
  level.var_22F0 = 1;
  setDvar("4712", 2);
  var_0C = "cam_note_notify";
  final_boss_intro_fade(0.25, 1);
  maps\mp\mp_zombie_descent_lighting::bossintrolightson();
  maps\mp\mp_zombie_descent_lighting::bossarenalightsoff();
  foreach(var_0E in level.var_744A) {
    if(lib_0547::func_577E(var_0E)) {
      var_0E notify("revive_trigger");
    }

    if(var_0E getstance() != "stand") {
      var_0F = var_0E setstance("stand", 0);
      waittillframeend;
      var_10 = var_0E getstance();
      while(var_10 != "stand") {
        var_10 = var_0E getstance();
        wait 0.05;
      }
    }

    var_0E method_8114(0);
    var_0E method_8113(0);
    var_0E allowjump(0);
    var_0E allowmovement(0);
  }

  wait(0.5);
  foreach(var_0E in level.var_744A) {
    var_0E maps\mp\_utility::func_3E8E(1);
    var_0E.var_324E = 1;
    var_0E vignettesetparams(0.85, 1, 1, 1, 0, 0.1);
    var_0E setclientomnvar("ui_hide_hud", 1);
    var_0E method_848D();
    var_0E method_8003();
    var_0E method_8322();
    var_0E setorigin(var_08 gettagorigin("tag_player"));
    var_0E setangles(var_08 gettagangles("tag_player"));
    var_0E playerlinktoabsolute(var_08, "tag_player");
    var_0E lib_0547::func_8A6D(1);
  }

  wait(0.25);
  lib_0378::func_8D74("aud_gdk_intro");
  var_08 method_8495("s2_zom_gdk_intro_vm", var_04.var_116, var_04.var_1D, var_0C);
  var_05 method_8495("s2_zom_gdk_intro_vivian", var_04.var_116, var_04.var_1D);
  var_07 method_8495("s2_zom_gdk_intro_godking", var_04.var_116, var_04.var_1D);
  var_08 childthread listen_for_notetrack_gdk(var_0C);
  wait 0.05;
  final_boss_intro_fade(0.25, 0);
  var_14 = maps\mp\agents\_scripted_agent_anim_util::getnotetracktimeinsecs(var_09, "detach_sword");
  var_15 = getanimlength(var_0A);
  wait(var_14);
  var_06 unlink();
  var_06 method_8449(var_07, "j_spineupper");
  wait(var_15 - var_14 - 0.5);
  final_boss_intro_fade(0.25, 1);
  maps\mp\mp_zombie_descent_lighting::bossintrolightsoff();
  maps\mp\mp_zombie_descent_lighting::bossarenalightson();
  var_05 delete();
  var_06 delete();
  var_07 delete();
  level.var_22F0 = 0;
  setDvar("4712", 1);
  var_08 scriptmodelclearanim();
  var_08.var_116 = var_08.var_116 + (0, 0, 32);
  foreach(var_0E in level.var_744A) {
    var_0E unlink();
    var_0E method_8004();
    var_0E method_848C();
    var_0E method_8323();
    var_0E maps\mp\_utility::func_3E8E(0);
    var_0E method_8114(1);
    var_0E method_8113(1);
    var_0E allowjump(1);
    var_0E allowmovement(1);
    var_0E lib_0547::func_8A6D(0);
    var_0E setclientomnvar("ui_hide_hud", 0);
    var_0E.var_324E = 0;
    var_0E notify("boss_scene_end");
  }

  var_08 delete();
  final_boss_intro_send_players_to_start_positions();
  thread final_boss_intro_fade(0.25, 0);
  common_scripts\utility::func_3C8F("flag_boss_fight_start");
}

listen_for_notetrack_gdk(param_00) {
  var_01 = 4;
  foreach(var_03 in level.var_744A) {
    var_03 method_84B4();
  }

  var_05 = 0;
  while(var_01) {
    self waittill(param_00, var_06);
    if(issubstr(var_06, "fov")) {
      var_01--;
      var_07 = get_fov(var_06);
      var_05 = get_time(var_06);
      foreach(var_03 in level.var_744A) {
        var_03 method_84B7(8, var_07, var_05);
      }
    }
  }

  wait(var_05);
  foreach(var_03 in level.var_744A) {
    var_03 method_84B5();
  }
}

get_fov(param_00) {
  var_01 = function_0337(param_00, "fov_");
  var_02 = "";
  var_03 = 0;
  for(;;) {
    if(isstringinteger(var_01[var_03])) {
      var_02 = var_02 + var_01[var_03];
      var_03++;
      continue;
    }

    break;
  }

  return lib_0547::func_9470(var_02);
}

get_time(param_00) {
  var_01 = param_00;
  var_02 = "";
  var_03 = var_01.size - 1;
  for(;;) {
    if(isstringinteger(var_01[var_03]) || var_01[var_03] == ".") {
      var_02 = var_02 + var_01[var_03];
      var_03--;
      continue;
    }

    break;
  }

  var_04 = "";
  for(var_05 = var_02.size - 1; var_05 >= 0; var_05--) {
    var_04 = var_04 + var_02[var_05];
  }

  return common_scripts\utility::func_9468(var_04);
}

final_boss_intro_send_players_to_start_positions() {
  level thread maps\mp\_utility::func_6F74(::final_boss_intro_send_players_to_start_positions_safe);
}

final_boss_intro_send_players_to_start_positions_safe() {
  var_00 = self;
  var_01 = common_scripts\utility::func_46B7("zmb_boss_spawns", "targetname");
  level.boss_battle_respawns = var_01;
  var_00.var_763C = var_00.var_116;
  var_00 setorigin(var_01[var_00 getentitynumber()].var_116);
  var_00 setangles(var_01[var_00 getentitynumber()].var_1D);
  var_00.bossstartorigin = var_00.var_116;
  var_00.bossstartangles = var_00.var_1D;
  var_00 unlink();
  var_00 method_8323();
  var_00 freezecontrols(0);
  var_00.var_AC5B = 0;
  var_00 method_8004();
}

final_boss_intro_fade(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  if(!isDefined(param_02)) {
    param_02 = "white";
  }

  foreach(var_04 in level.var_744A) {
    if(param_01 >= 1) {
      if(isDefined(var_04.var_1781)) {
        var_04.var_1781 destroy();
      }

      var_04.var_1781 = lib_0547::zm_util_create_client_overlay("black", 0, var_04, (1, 1, 1));
      var_04.var_1781 setshader(param_02, 640, 480);
    }

    if(isDefined(var_04.var_1781)) {
      var_04.var_1781 fadeovertime(param_00);
      var_04.var_1781.var_18 = param_01;
    }
  }

  wait(param_00);
}

final_boss_setup() {
  level.zmb_locked_spawn_zones = ["zone_citadel"];
  maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8608();
  kill_remaining_zombies();
}

kill_remaining_zombies() {
  var_00 = lib_0547::func_408F();
  foreach(var_02 in var_00) {
    var_02 suicide();
  }
}

spawn_raven_weapons_in_boss_room() {
  var_00 = common_scripts\utility::func_46B7("struct_boss_room_raven_weps", "targetname");
  var_01 = ["shield_emp", "hammer_emp", "spike_emp", "scythe_emp"];
  for(var_02 = 0; var_02 < var_00.size; var_02++) {
    if(!isDefined(level.ravenweaponmanager[var_01[var_02]].var_117)) {
      thread maps\mp\zombies\weapons\_zombie_dlc4_melee::spawn_raven_weapon(var_01[var_02], var_00[var_02].var_116);
    }
  }
}

start_boss_fight() {
  maps\mp\_events_z::start_boss_battle_tracking();
  var_00 = level.bossfight.throne_pos;
  level.zombie_king = lib_054D::func_90BA("zombie_king", var_00, "final boss fight", 0, 1, 0);
  level.zombie_king_sword = spawn("script_model", var_00.var_116);
  level.zombie_king_sword setModel("npc_zom_barb_sword_02");
  level.zombie_king_sword method_8449(level.zombie_king, "TAG_SWORD", (0, 0, 0), (0, 90, 90));
  level.zombie_king_sword.hitbox = getent("trig_sword_hitbox", "targetname");
  level.zombie_king_sword.hitbox.var_116 = var_00.var_116;
  level.zombie_king_sword.hitbox method_8449(level.zombie_king, "TAG_SWORD", (0, 0, 0), (0, 90, 90));
  level.zombie_king_sword.hitbox setCanDamage(1);
  level.zombie_king_sword.hitbox setdamagecallbackon(1);
  level.zombie_king_sword.hitbox.var_BC = 1000000;
  level.zombie_king_sword.hitbox.var_FB = 1000000;
  level.zombie_king_sword.hitbox.var_29B5 = ::sworddamagecallback;
  level.var_AC80.var_ACB3["zone_citadel"].var_556E = 1;
  common_scripts\utility::func_3C8F("zone_citadel");
  player_blood_plate_tuning();
  thread boss_handle_phases();
  lib_0378::func_8D74("aud_boss_music_start");
  play_outro_bik();
  common_scripts\utility::func_3C9F("flag_boss_complete");
  maps\mp\_events_z::end_boss_battle_tracking();
}

sworddamagecallback(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = self;
  if(isPlayer(param_01)) {
    wait(0);
    var_0D = "weakpoint";
    if(isDefined(level.zombie_king) && common_scripts\utility::func_3C77("flag_boss_fight_start") && !common_scripts\utility::func_3C77("flag_boss_complete") && !common_scripts\utility::func_562E(level.zombie_king.geistbulletshield) && !common_scripts\utility::func_562E(level.zombie_king.drainshieldacive)) {
      param_01 thread maps\mp\gametypes\_damagefeedback::func_A102(var_0D, level.zombie_king);
      level.zombie_king dodamage(param_02, var_0C.var_116, param_01, param_00, param_04, param_05, "soft");
    }
  }

  var_0C.var_BC = var_0C.var_FB;
}

player_blood_plate_tuning() {
  var_00 = level.var_744A.size;
  foreach(var_02 in level.blood_plates) {
    var_03 = undefined;
    if(lib_0547::func_5565(var_02.var_8260, "plate_boss_room")) {
      switch (var_00) {
        case 1:
          var_03 = 8;
          break;

        case 2:
          var_03 = 10;
          break;

        case 3:
          var_03 = 14;
          break;

        case 4:
          var_03 = 18;
          break;

        default:
          break;
      }
    }

    if(isDefined(var_03)) {
      var_02.souls_max = var_03;
      var_02 maps\mp\mp_zombie_descent::blood_plate_empty();
    }
  }
}

boss_handle_phases() {
  thread boss_play_intro_line();
  boss_phase_0();
  boss_phase_1();
  boss_phase_2();
  boss_phase_3();
  boss_phase_3_2();
  boss_phase_4();
  boss_phase_5();
}

boss_play_intro_line() {
  while(!isDefined(level.zombie_king)) {
    wait 0.05;
  }

  wait(0.5);
  level.zombie_king thread maps\mp\zombies\zombie_king::vo_play_gdk_ability_line("intro");
}

phase_enrage_timer(param_00, param_01) {
  level notify("phase_enrage_timer_start");
  level endon("phase_enrage_timer_start");
  wait(param_01);
  if(!lib_0547::is_solo()) {
    level notify(param_00);
  }
}

boss_phase_0() {
  var_00 = 0;
  level.zombie_king thread maps\mp\zombies\zombie_king::king_set_current_phase(var_00);
  var_01 = "phase_0_enrage";
  thread phase_enrage_timer(var_01, 480);
  level endon(var_01);
  while(level.zombie_king.var_BC > level.zombie_king.var_FB * 0.85) {
    wait 0.05;
  }
}

boss_phase_1() {
  var_00 = 1;
  level.zombie_king thread maps\mp\zombies\zombie_king::king_set_current_phase(var_00);
  var_01 = "phase_1_enrage";
  thread phase_enrage_timer(var_01, 540);
  level endon(var_01);
  while(level.zombie_king.var_BC > level.zombie_king.var_FB * 0.65) {
    wait 0.05;
  }
}

boss_phase_2() {
  var_00 = 2;
  level.zombie_king thread maps\mp\zombies\zombie_king::king_set_current_phase(var_00);
  var_01 = "phase_2_enrage";
  thread phase_enrage_timer(var_01, 540);
  level endon(var_01);
  while(level.zombie_king.var_BC > level.zombie_king.var_FB * 0.42) {
    wait 0.05;
  }
}

boss_phase_3() {
  var_00 = 3;
  level.zombie_king thread maps\mp\zombies\zombie_king::king_set_current_phase(var_00);
  var_01 = "phase_3_enrage";
  thread phase_enrage_timer(var_01, 600);
  level endon(var_01);
  while(level.zombie_king.var_BC > level.zombie_king.var_FB * 0.15) {
    wait 0.05;
  }
}

boss_phase_3_2() {
  if(lib_0547::is_solo()) {
    return;
  }

  var_00 = 6;
  level.zombie_king thread maps\mp\zombies\zombie_king::king_set_current_phase(var_00);
  while(level.zombie_king.var_BC > level.zombie_king.var_FB * 0.01) {
    wait 0.05;
  }
}

boss_phase_4() {
  level.zombie_king thread maps\mp\zombies\zombie_king::king_set_current_phase(4);
  level waittill("finale_outro_bik_end");
  level.zombie_king notify("transition_scene_done");
}

boss_phase_5() {
  thread finale_setup_players();
  level.zombie_king.var_BC = level.zombie_king.var_BC + int(level.zombie_king.var_FB * 0.1);
  level.zombie_king thread maps\mp\zombies\zombie_king::king_set_current_phase(5);
}

finale_setup_players() {
  var_00 = common_scripts\utility::func_46B7("org_finale_phase_player", "targetname");
  var_01 = common_scripts\utility::func_FA4(var_00, ::sort_by_script_noteworthy);
  foreach(var_05, var_03 in level.var_744A) {
    var_04 = getgroundposition(var_01[var_05].var_116, 64, 128, 12);
    var_03 setorigin(var_04, 1);
  }

  thread maps\mp\_utility::func_6F74(::give_raven_form);
}

give_raven_form() {
  var_00 = self;
  var_00 endon("disconnect");
  while(!isalive(var_00) || lib_0547::func_577E(var_00)) {
    wait 0.05;
  }

  wait(1);
  var_00 thread maps\mp\zombies\zombie_king::set_player_ravenlord_state();
}

clear_boss_fight() {
  level.zmb_locked_spawn_zones = undefined;
  lib_0378::func_8D74("dlc_handle_boss_killed_music");
  wait(10);
  maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8607();
  thread delayed_reactivate_treasure_zombies();
}

delayed_reactivate_treasure_zombies() {
  wait(60);
  level.var_6F1E = 0;
}

play_outro_bik() {
  level waittill("finale_bik_outro_begin");
  lib_0547::zm_util_run_outro("mp/mp_zom_dlc4_outro", 36.56, 1.15, 1, 0, "finale_outro_movie");
  level notify("finale_outro_bik_end");
}

outrofadein() {
  self.var_6772 = newclienthudelem(self);
  self.var_6772 setshader("black", 640, 480);
  self.var_6772.ignoreme = 999;
  self.var_6772.var_C6 = "fullscreen";
  self.var_6772.var_1CA = "fullscreen";
  self.var_6772.var_A0 = 0;
  thread animscripts\notetracks_common::do_fade_from_black(0.8);
}

outrofadeout() {
  self.var_6772 = newclienthudelem(self);
  self.var_6772 setshader("black", 640, 480);
  self.var_6772.ignoreme = 999;
  self.var_6772.var_C6 = "fullscreen";
  self.var_6772.var_1CA = "fullscreen";
  self.var_6772.var_A0 = 0;
  thread animscripts\notetracks_common::func_30B4(1.15);
}

test_ice_block_bullettrace_hit(param_00, param_01) {
  var_02 = bulletTrace(param_00, param_01, 0, undefined, 1);
  var_03 = 0;
  foreach(var_05 in level.ice_blocks) {
    if(isDefined(var_05.damage_trig) && ispointinvolume(var_02["position"], var_05.damage_trig)) {
      var_05 thread ice_block_take_damage(var_02["position"]);
      var_03 = 1;
    }
  }

  return [var_03, var_02["position"]];
}

test_ice_block_explosion_hit(param_00, param_01) {
  var_02 = undefined;
  foreach(var_04 in level.ice_blocks) {
    if(isDefined(var_04.damage_trig) && distance2d(param_00, var_04.var_116) <= param_01 + var_04.var_8303) {
      var_02 = bulletTrace(param_00, var_04.var_116, 0, undefined, 1);
      if(ispointinvolume(var_02["position"], var_04.damage_trig)) {
        var_04 thread ice_block_take_damage(var_02["position"]);
      }
    }
  }

  if(isDefined(var_02) && isDefined(var_02["position"])) {
    return [1, var_02["position"]];
  }

  return [0];
}

test_ice_block_projectile_hit(param_00) {
  var_01 = self;
  if(!isDefined(param_00)) {
    return;
  }

  param_00 waittill("projectile_impact", var_02, var_03);
  foreach(var_05 in level.ice_blocks) {
    if(isDefined(var_05.damage_trig) && ispointinvolume(var_03, var_05.damage_trig)) {
      var_05 thread ice_block_take_damage(var_03);
    }
  }
}

ice_block_take_damage(param_00) {
  self.ice_health = self.ice_health - 8;
  if(self.ice_health <= 0) {
    ice_block_break();
    return;
  }

  if(!isDefined(param_00)) {
    param_00 = self.var_116;
  }

  playFX(common_scripts\utility::func_44F5("zmb_desc_ice_destruct_chunks"), param_00);
  lib_0378::func_8D74("aud_damage_ice");
}

get_unbroken_ice_blocks() {
  var_00 = [];
  if(isDefined(level.ice_blocks)) {
    foreach(var_02 in level.ice_blocks) {
      if(var_02 ice_block_is_unbroken()) {
        var_00[var_00.size] = var_02;
      }
    }
  }

  return var_00;
}

ice_block_is_unbroken() {
  return isDefined(self.damage_trig);
}

ice_block_break() {
  playFX(common_scripts\utility::func_44F5("zmb_desc_ice_explode"), self.var_116 + (0, 0, 40));
  lib_0378::func_8D74("aud_break_ice");
  if(isDefined(self.mdl)) {
    self.mdl delete();
  }

  if(isDefined(self.mdl_broke)) {
    self.mdl_broke method_805B();
  }

  if(isDefined(self.var_241F)) {
    self.var_241F method_8060();
    self.var_241F method_805C();
    self.var_241F notsolid();
  }

  if(isDefined(self.clip_broke)) {
    self.clip_broke method_8060();
    self.clip_broke solid();
  }

  if(isDefined(self.damage_trig)) {
    self.damage_trig delete();
  }
}

func_67F1(param_00, param_01) {
  self endon("death");
  if(param_01 > 0) {
    wait(param_01);
  }

  if(!isDefined(self)) {
    return;
  }

  self notify(param_00);
}