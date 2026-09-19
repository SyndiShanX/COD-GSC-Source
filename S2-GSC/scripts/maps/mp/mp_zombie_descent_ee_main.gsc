/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_descent_ee_main.gsc
*********************************************************/

init() {
  var_0 = common_scripts\utility::_id_46B7("zone_lost_spawners_death", "targetname");

  foreach(var_2 in var_0)
  var_2._id_8C95 = 1;

  level.shouldignoreplayerzombiecallback = ::zombies_trials_should_ignore_player;
  level.extra_upgrade_func = ::add_pap_time;
  init_blood_lock_quest();
  init_deathraven_quest();
  init_moonraven_quest();
  init_boss_fight_quest();
  _id_0557::_id_7846("quest_firstdoor", _id_0557::_id_30D8, [], _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_firstdoor", "quest_firstdoor_bloodpool", ::quest_step_blood_lock, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_7848("quest_firstdoor");
  _id_0557::_id_7846("quest_pap", _id_0557::_id_30D8, [], _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_pap", "quest_pap_1", ::quest_step_unlock_pap, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_7848("quest_pap");
  _id_0557::_id_7846("quest_bloodraven", _id_0557::_id_30D8, [], _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_bloodraven", "quest_bloodraven_drain_fill", ::quest_step_bloodraven_fill_drains, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_bloodraven", "quest_bloodraven_acquire_sheild", ::quest_step_bloodraven_aquire_sheild, ::descent_give_small_reward, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_bloodraven", "quest_bloodraven_acquire_code", ::quest_step_bloodraven_reveal_code, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_bloodraven", "quest_bloodraven_radio_find", ::quest_step_bloodraven_acquire_radio, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_bloodraven", "quest_bloodraven_enter_code", ::quest_step_bloodraven_enter_code, ::descent_give_mid_reward, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_bloodraven", "quest_bloodraven_enter_trial", ::quest_step_bloodraven_enter_trial, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_bloodraven", "quest_bloodraven_complete_trial", ::quest_step_bloodraven_complete_trial, ::descent_give_large_reward, _id_0557::removed_quest_hint());
  _id_0557::_id_7848("quest_bloodraven");
  init_quest_step_bloodraven_reveal_code();
  _id_0557::_id_7846("quest_deathraven", _id_0557::_id_30D8, [], _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_deathraven", "quest_deathraven_activate_rush", ::quest_step_deathraven_push_stone, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_deathraven", "quest_deathraven_survive_rush", ::quest_step_deathraven_survive_rush, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_deathraven", "quest_deathraven_pickup_weap", ::quest_step_deathraven_pickup_weapon, ::descent_give_small_reward, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_deathraven", "quest_deathraven_acquire_weapon", ::quest_step_deathraven_acquire_spine, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_deathraven", "quest_deathraven_assemble_weap", ::quest_step_deathraven_assemble_weapon, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_deathraven", "quest_deathraven_fuse_weap", ::quest_step_deathraven_fuse, ::descent_give_mid_reward, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_deathraven", "quest_deathraven_transport_weap", ::quest_step_deathraven_transport, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_deathraven", "quest_deathraven_enter_trial", ::quest_step_deathraven_enter_trial, ::descent_give_mid_reward, _id_0557::removed_quest_hint());
  _id_0557::_id_7848("quest_deathraven");
  _id_0557::_id_7846("quest_moonraven", _id_0557::_id_30D8, [], _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_moonraven", "quest_moonraven_reveal_chart", ::quest_step_moonraven_chart, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_moonraven", "quest_moonraven_fix_machine", ::quest_step_moonraven_machine, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_moonraven", "quest_moonraven_power_orrery", ::quest_step_moonraven_orrery_power, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_moonraven", "quest_moonraven_acquire_scepter", ::quest_step_moonraven_acquire_weapon, ::descent_give_mid_reward, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_moonraven", "quest_moonraven_scan", ::quest_step_moonraven_scan, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_moonraven", "quest_moonraven_alcove", ::quest_step_moonraven_alcove, ::descent_give_mid_reward, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_moonraven", "quest_moonraven_unlock_trial", ::quest_step_moonraven_unlock_trial, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_moonraven", "quest_moonraven_enter_trial", ::quest_step_moonraven_enter_trial, ::descent_give_large_reward, _id_0557::removed_quest_hint());
  _id_0557::_id_7848("quest_moonraven");
  _id_0557::_id_7846("quest_stormraven", _id_0557::_id_30D8, [], _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_stormraven", "step_stormraven_chase_hammer", ::stormraven_summon_hammer_main, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_stormraven", "step_stormraven_capture_hammer", ::stormraven_capture_hammer_main, ::descent_give_small_reward, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_stormraven", "step_stormraven_call_lightning", ::stormraven_call_lightning_main, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_stormraven", "step_stormraven_charge_puzzle", ::stormraven_charge_puzzle_main, ::descent_give_mid_reward, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_stormraven", "step_stormraven_trial", ::stormraven_find_trial_main, ::descent_give_large_reward, _id_0557::removed_quest_hint());
  _id_0557::_id_7848("quest_stormraven");
  stormraven_init_quest();
  register_a_raven_trial("zom_dlc4_scythe_zm", "scythe_emp", ::run_deathraven_trial, ::deathraven_hitch_a_ride_back);
  register_a_raven_trial("zom_dlc4_hammer_zm", "hammer_emp", ::run_stormraven_trial, ::stormraven_trial_teleport_from_trial);
  register_a_raven_trial("zom_dlc4_spike_zm", "spike_emp", ::run_moonraven_trial, ::moonraven_trial_teleport_from_trial);
  register_a_raven_trial("zom_dlc4_shield_zm", "shield_emp", ::run_bloodraven_trial, ::bloodraven_exit_from_trial);
  register_a_raven_trial("zom_pap_trial_destination", undefined, ::run_pack_a_punch_visit, ::deathraven_hitch_a_ride_back);
  register_a_raven_trial("zom_bonus_trial_destination", undefined, maps\mp\mp_zombie_descent_ee_side::run_sewers_visit, maps\mp\mp_zombie_descent_ee_side::sewers_hitch_a_ride_back);
  register_a_raven_trial("zom_shelf_trial_destination", undefined, maps\mp\mp_zombie_descent_ee_side::run_shelf_visit, maps\mp\mp_zombie_descent_ee_side::sewers_shelf_force_orb_teleport_return);
  _id_0547::_id_7BD0("ce_taunt", ::ce_taunt, ::ce_taunt_interrupt, 104);
  var_4 = getEntArray("raven_trial_fall_trigger", "targetname");

  foreach(var_6 in var_4)
  var_6 thread raven_trial_teleport_on_fall();

  _id_0557::_id_7846("quest_bossfight", _id_0557::_id_30D8, [], _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_bossfight", "quest_bossfight_open", ::quest_step_boss_open, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_bossfight", "quest_bossfight_start", ::_id_784C, ::descent_completion_rewards, _id_0557::removed_quest_hint());
  _id_0557::_id_7848("quest_bossfight");
}

descent_completion_rewards() {
  _id_0547::markmapcompleteforleaderboards();
  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("mp_zombie_berlin_final_boss");
  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("any_boss_completed");
  _id_054D::giveplayersexp("dlc4_exp_ref_1");
  maps\mp\zquests\dlc4_trophies_mp_zombie_descent::complete_descent_trophy_event_10();
  level._id_400E[level._id_400E.size] = ["wicht_set 4 1", "all"];
}

descent_give_small_reward() {
  _id_054D::giveplayersexp("dlc4_exp_ref_2");
}

descent_give_mid_reward() {
  _id_054D::giveplayersexp("dlc4_exp_ref_3");
}

descent_give_large_reward() {
  _id_054D::giveplayersexp("dlc4_exp_ref_4");
}

quest_step_unlock_pap() {
  var_0 = _getent("zmb_pack_a_punch_descent", "targetname");
  var_0.destination_origin = var_0.origin;
  var_1 = var_0 common_scripts\utility::_id_8FFC();
  var_1 show();
  var_2 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_pack_a_punch_blood_reveal"), var_0, "lathe_01");
  _triggerfx(var_2);
  var_3 = common_scripts\utility::_id_46B5(var_0.target, "targetname");
  var_0.origin = var_3.origin;
  var_0._id_6C4E = var_0.origin;
  common_scripts\utility::flag_init("pap_raise_1");
  common_scripts\utility::flag_init("pap_raise_2");
  common_scripts\utility::flag_init("pap_raise_3");
  common_scripts\utility::_id_3C9F("pap_raise_1");
  _triggerfx(var_2);
  var_0 move_to_position(1);
  common_scripts\utility::_id_3C9F("pap_raise_2");
  var_0 move_to_position(2);
  common_scripts\utility::_id_3C9F("pap_raise_3");
  var_0 move_to_position(3);
  level notify("aud_pap_machine_blood_lp_starts");
  common_scripts\utility::flag_set("flag_descent_pap");
  var_0 ghost();
  _id_0557::_id_782D("quest_pap", "quest_pap_1");
}

raise_machine_to_unlock_pack_a_punch() {
  var_0 = _getent("pack_a_punch_weapon_display", "targetname");
  var_0 ghost();
  var_1 = _getscriptablearray("zmb_upgrade_machine", "targetname");

  foreach(var_3 in var_1)
  var_3 hide();

  common_scripts\utility::flag_init("flag_descent_pap");
  common_scripts\utility::_id_3C9F("flag_descent_pap");
}

move_to_position(var_0) {
  var_1 = 0.8;
  var_2 = self.destination_origin;
  var_3 = self._id_6C4E;
  _id_0378::_id_8D74("aud_pap_rise");
  self moveto(_vectorlerp(var_3, var_2, var_0 / 3), var_1, var_1 / 4, var_1 / 4);
  wait(var_1);
}

register_a_raven_trial(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.raven_weapon_upgrade_trials))
    level.raven_weapon_upgrade_trials = [];

  if(!isDefined(level.raven_trials_completed))
    level.raven_trials_completed = 0;

  var_4 = spawnStruct();
  var_4.origin = common_scripts\utility::_id_46B5(var_0, "script_noteworthy").origin;
  var_4._id_502A = var_0;
  var_4.weap_upgrade = var_1;

  if(isDefined(var_4.weap_upgrade))
    var_4.weap = _func_337(var_4.weap_upgrade, "_emp");

  var_4._id_3F02 = var_2;
  var_4.return_func = var_3;
  var_5 = common_scripts\utility::_id_46B7("zmb_trials_dest", "targetname");

  foreach(var_7 in var_5) {
    if(var_7._id_0165 == var_0)
      var_4.weapon_spawn = var_7;
  }

  level.raven_weapon_upgrade_trials[var_4._id_502A] = var_4;
}

raven_trial_teleport_on_fall() {
  for(;;) {
    self waittill("trigger", var_0);

    if(isPlayer(var_0) && isalive(var_0)) {
      var_0 setOrigin(common_scripts\utility::_id_46B5(self.target, "targetname").origin);
      var_0 thread raven_trial_fall_damage();
    }
  }
}

raven_trial_fall_damage() {
  while(!self isonground())
    waitframe();

  down_player();
}

down_player() {
  _id_0547::_id_73AC(3);
  _id_0547::_id_7442(3);
  self dodamage(self.health, self.origin);
}

zombies_trials_should_ignore_player(var_0, var_1) {
  if(!isDefined(var_0.isintrial) && !isDefined(var_1.isintrial))
    return 0;

  if(_id_0547::_id_5565(var_0.isintrial, var_1.isintrial))
    return 0;

  if(!isDefined(var_1.isintrial) && isDefined(var_0.isintrial) && !_id_0547::_id_5565(var_0.isintrial, "quest_deathraven"))
    return 1;

  if(!var_1 is_there_another_player_in_trial(var_0))
    return 0;

  return 1;
}

is_there_another_player_in_trial(var_0) {
  var_1 = self;

  if(isDefined(var_1.isintrial)) {
    foreach(var_3 in level.players) {
      if(var_0 == var_3) {
        continue;
      }
      if(_id_0547::_id_5565(var_1.isintrial, var_3.isintrial)) {
        var_4 = 1;
        return 1;
      }
    }
  }

  return 0;
}

someone_at_deathraven_event() {
  foreach(var_1 in level.players) {
    if(common_scripts\utility::_id_562E(var_1.isindeathravenevent))
      return 1;
  }

  return 0;
}

someone_at_stormraven_event() {
  foreach(var_1 in level.players) {
    if(common_scripts\utility::_id_562E(var_1.isinstormravenevent))
      return 1;
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
  _id_0557::_id_782D("quest_firstdoor", "quest_firstdoor_bloodpool");
}

first_door_adjust_max() {
  wait 1;
  maps\mp\mp_zombie_descent::blood_plate_empty_first_door();
}

deactivate_first_door_trigs() {
  while(!isDefined(_id_053F::_id_44A6("flag_limbo_to_cave_intro")))
    wait 1;

  var_0 = _id_053F::_id_44A6("flag_limbo_to_cave_intro");

  while(!isDefined(var_0._id_9DC2))
    waitframe();

  foreach(var_2 in var_0._id_9DC2)
  var_2 common_scripts\utility::_id_9D9F();
}

wait_for_door_objective_complete() {
  self waittill("blood_plate_full");
}

__________________bloodraven__________________() {}

init_blood_lock_quest() {
  level.zmb_possible_blood_code_values = [1, 3, 5, 7, 8, 9, 11];
  blood_plate_init();
  common_scripts\utility::flag_init("stopper_in_place");
  common_scripts\utility::flag_init("limbo_debris_exploded");
  common_scripts\utility::flag_init("stopper_collected");
  var_0 = common_scripts\utility::_id_46B7("struct_blooddrain_main", "targetname");

  foreach(var_3, var_2 in var_0) {
    var_2.getnegotiationnextnode = "blood_collect_" + var_3;
    common_scripts\utility::flag_init(var_2.getnegotiationnextnode);
  }
}

blood_plate_init() {
  var_0 = common_scripts\utility::_id_46B7("blood_plate_struct", "targetname");
  var_1 = getEntArray("blood_plate_pool", "targetname");
}

_____obj_blood_weapon____() {}

quest_step_bloodraven_fill_drains() {
  var_0 = common_scripts\utility::_id_46B7("struct_blooddrain_main", "targetname");
  level thread run_stopper();
  level thread run_bomber_debris_puzzle();
  level thread acquire_radio();
  level thread acquire_speakers();

  foreach(var_3, var_2 in var_0) {
    var_2.getnegotiationnextnode = "blood_collect_" + var_3;
    common_scripts\utility::flag_init(var_2.getnegotiationnextnode);
    var_2 childthread run_blood_drain_collection();
  }

  level thread track_drain_completion(var_0);
  var_4 = [233, 234, 235];

  for(var_3 = 0; var_3 < var_0.size; var_3++)
    level thread reveal_blood_fx("blood_collect_" + var_3, var_4[var_3]);

  for(var_3 = 0; var_3 < var_0.size; var_3++)
    common_scripts\utility::_id_3C9F("blood_collect_" + var_3);

  _id_0557::_id_782D("quest_bloodraven", "quest_bloodraven_drain_fill");
}

track_drain_completion(var_0) {
  for(level.bloodraven_drains_filled = 0; level.bloodraven_drains_filled <= 2; level.bloodraven_drains_filled++) {
    level common_scripts\utility::_id_A70A(var_0[0].getnegotiationnextnode, var_0[1].getnegotiationnextnode, var_0[2].getnegotiationnextnode);
    common_scripts\utility::flag_set("flag_blood_pool_" + level.bloodraven_drains_filled);
  }
}

reveal_blood_fx(var_0, var_1) {
  common_scripts\utility::_id_3C9F(var_0);
  common_scripts\_exploder::_id_0891(var_1);
}

run_stopper() {
  var_0 = _getent("zmf_bloodraven_plug_find", "targetname");
  var_1 = _getent("zmf_bloodraven_plug_trig_find", "targetname");
  var_2 = _getent("zmf_bloodraven_plug_trig", "targetname");
  var_3 = _getent("zmf_bloodraven_plug", "targetname");
  var_3 hide();
  var_1 waittill("trigger", var_4);
  var_0 hide();
  var_0 _id_0378::_id_8D74("aud_bloodraven_bloodstopper_pickup");
  common_scripts\utility::flag_set("stopper_collected");
  var_2 waittill("trigger", var_4);
  var_3 show();
  var_3 _id_0378::_id_8D74("aud_bloodraven_bloodstopper_place");
  common_scripts\utility::flag_set("stopper_in_place");
}

quest_step_bloodraven_acquire_radio() {
  common_scripts\utility::_id_3C9F("radio_collected");
  _id_0557::_id_782D("quest_bloodraven", "quest_bloodraven_radio_find");
}

run_bomber_debris_puzzle() {
  var_0 = _getent("zmf_bloodraven_radio_blocker", "targetname");
  var_1 = _getent(var_0.target, "targetname");
  var_2 = (0, 0, 0);
  var_3 = 0;

  while(distance(var_0.origin, var_2) > var_3)
    level waittill("objective_zombie_exploder_detonation", var_2, var_3);

  var_0 hide();
  var_1 connectpaths();
  var_1 notsolid();
  common_scripts\utility::flag_set("limbo_debris_exploded");
}

acquire_radio() {
  common_scripts\utility::flag_init("radio_collected");
  var_0 = _getent("zmf_bloodraven_radio_find", "targetname");
  var_1 = _getent("zmf_bloodraven_radio_find_trig", "targetname");
  var_2 = _getent("zmf_bloodraven_radio_place", "targetname");
  var_3 = _getent("zmf_bloodraven_radio_place_trig", "targetname");
  var_0 hide();
  var_2 hide();
  wait 1;
  var_0 show();
  common_scripts\utility::_id_3C9F("limbo_debris_exploded");
  var_1 waittill("trigger", var_4);
  var_0 hide();
  var_0 _id_0378::_id_8D74("aud_bloodraven_radio_pickup");
  common_scripts\utility::flag_set("flag_radio_picked_up");
  var_3 waittill("trigger", var_4);
  radio_set();
}

acquire_speakers() {
  common_scripts\utility::flag_init("speakers_collected");
  var_0 = _getent("zmf_bloodraven_speakers_find_trig", "targetname");
  var_1 = _getent("zmf_bloodraven_speakers_find", "targetname");
  var_2 = _getent("zmf_bloodraven_speakers_place_trig", "targetname");
  var_3 = _getent("zmf_bloodraven_speakers_place", "targetname");
  var_1 hide();
  var_3 hide();
  wait 1;
  var_1 show();
  common_scripts\utility::_id_3C9F("limbo_debris_exploded");
  var_0 waittill("trigger", var_4);
  var_1 hide();
  var_1 _id_0378::_id_8D74("aud_bloodraven_speaker_pickup");
  var_2 waittill("trigger", var_4);
  speakers_set();
}

radio_set() {
  var_0 = _getent("zmf_bloodraven_radio_place", "targetname");
  var_0 show();
  var_0 _id_0378::_id_8D74("aud_bloodraven_radio_place");
  common_scripts\utility::flag_set("radio_collected");
  var_0 thread turn_on_vfx();
}

turn_on_vfx() {
  wait 5;
  self.radiofx = _id_0547::_id_8FBA(self, "zmb_desc_radio_fixed");
  _triggerfx(self.radiofx);
}

speakers_set() {
  var_0 = _getent("zmf_bloodraven_speakers_place", "targetname");
  var_0 show();
  var_0 _id_0378::_id_8D74("aud_bloodraven_speaker_place");
  common_scripts\utility::flag_set("speakers_collected");
}

quest_step_bloodraven_aquire_sheild() {
  _id_0547::_id_7BA9(::dropplayershield);
  var_0 = common_scripts\utility::_id_46B5("ee_follower_rise", "targetname");
  var_0 maps\mp\mp_zombie_descent_utils::wait_for_player_close(280);
  var_1 = _id_054D::_id_90BA("zombie_heavy", var_0, "ee_follower", 1, 1, 0);
  var_1 _id_0378::_id_8D74("aud_bloodraven_wustling_spawn");
  var_2 = var_1 common_scripts\utility::_id_8FFC();
  var_2 setModel("npc_zom_bloodraven_shield");
  var_2 show();
  var_2.origin = var_1 gettagorigin("J_SpineUpper");
  var_2.angles = var_1 gettagangles("J_SpineUpper");
  var_3 = 7;
  var_4 = 2;
  var_5 = 8;
  var_2 linktosynchronizedparent(var_1, "J_SpineUpper", (var_5, var_4, var_3), (0, 90, 90));
  var_1.hasplayershield = 1;
  var_1.sheild_attach = var_2;
  var_1.playershieldsafespawnpos = undefined;
  var_1 thread shield_track_safe_drop_position();
}

shield_track_safe_drop_position() {
  var_0 = self;
  var_0 endon("death");

  while(common_scripts\utility::_id_562E(var_0.hasplayershield)) {
    if(!var_0 isonground()) {
      waitframe();
      continue;
    }

    if(_func_2E6(var_0.origin))
      var_0.playershieldsafespawnpos = var_0.origin;

    wait 1;
  }
}

init_quest_step_bloodraven_reveal_code() {
  var_0 = common_scripts\utility::_id_46B7("struct_blooddrain_main", "targetname");

  foreach(var_2 in var_0)
  var_2.symbols = level.zmb_possible_blood_code_values;
}

quest_step_bloodraven_reveal_code() {
  var_0 = common_scripts\utility::_id_46B7("zmf_ee_blood_message_struct", "targetname");
  level thread maps\mp\_utility::_id_6F74(::notify_blood_code_change);

  foreach(var_2 in var_0) {
    if(var_2 is_blood_input())
      var_2 thread handle_code_set();
  }

  var_4 = common_scripts\utility::_id_46B7("struct_blooddrain_main", "targetname");
  var_4 thread handle_code_reveal();
}

quest_step_bloodraven_enter_code() {
  var_0 = common_scripts\utility::_id_46B5("zmb_bloodraven_code_display", "targetname");
  var_0 handle_code_entry();
  _id_0557::_id_782D("quest_bloodraven", "quest_bloodraven_enter_code");
}

handle_code_entry() {
  var_0 = spawnStruct();
  level.bloodraven_code_handler = var_0;
  var_1 = level.zmb_possible_blood_code_values;
  var_2 = 3;
  var_3 = var_1.size;
  var_0.row = 0;
  var_0.column = 0;
  var_4 = _getent("zmf_bloodraven_radio_place_trig", "targetname");
  common_scripts\utility::_id_3C9F("radio_collected");
  common_scripts\utility::_id_3C9F("speakers_collected");
  self.onzombiesacrificedfunc = ::radio_soul_collect_response;
  self.optionaldisablearclightning = 1;
  thread maps\mp\mp_zombies_soul_collection::beginazombiesoulcollectionobjectiveonstruct(-1, 300, 64, "bloodraven_collect_soul_set", undefined, "tag_origin", undefined, "tag_origin", undefined, self, (0, 0, 8), undefined, 1, 1);
  var_5 = level.reveal_structs_in_order;
  wait_for_structs_revealed(var_5);
  var_6 = common_scripts\utility::_id_46B5("zmb_bloodraven_code_display", "targetname");
  level.blood_raven_input = [0, 0, 0];
  var_6 set_blood_fx(var_0.column);

  for(;;) {
    var_4 waittill("trigger", var_7);
    var_4 _id_0378::_id_8D74("aud_bloodraven_tune_radio");

    if(isDefined(var_7)) {
      var_0.column++;

      if(var_0.column >= var_3)
        var_0.column = 0;
    } else {
      level.blood_raven_input[var_0.row] = var_1[var_0.column];
      var_0.row++;

      if(var_0.row >= var_2)
        var_0.row = 0;
    }

    if(!code_correct(level.blood_raven_input, var_5)) {
      if(!isDefined(var_7) && var_0.row == 0) {
        var_6 set_blood_fx(var_0.column, "fail");
        var_0.column = 0;
      } else if(isDefined(var_7))
        var_6 set_blood_fx(var_0.column);

      continue;
    }

    var_6 set_blood_fx(var_0.column, "zmb_desc_chladni_success");
    break;
  }

  if(isDefined(self.collector)) {
    self.collector._id_AC2C = 0;
    self.collector._id_AC2D = self.collector._id_AC2C;
    level notify(self.collector._id_695B);
  }

  _id_0557::_id_782D("quest_bloodraven", "quest_bloodraven_enter_code");
}

set_blood_fx(var_0, var_1) {
  var_2 = 2.5;

  if(var_0 == 0) {
    var_3 = level.zmb_possible_blood_code_values[level.zmb_possible_blood_code_values.size - 1];
    var_4 = level.zmb_possible_blood_code_values[0];
  } else {
    var_3 = level.zmb_possible_blood_code_values[var_0 - 1];
    var_4 = level.zmb_possible_blood_code_values[var_0];
  }

  if(!isDefined(var_1))
    var_5 = "zmb_desc_chladni_" + var_3 + "_to_" + var_4;
  else if(var_1 == "fail") {
    var_2 = 1.5;
    var_5 = "zmb_desc_chladni_" + var_4 + "_to_0";
    var_4 = level.zmb_possible_blood_code_values[0];
    set_fx_blood_generic(var_5);
    wait(var_2);
    var_5 = "zmb_desc_chladni_0_to_1";
    var_1 = undefined;
  } else
    var_5 = var_1;

  set_fx_blood_generic(var_5);

  if(isDefined(var_1)) {
    return;
  }
  wait(var_2);
  set_fx_blood_generic("zmb_desc_chladni_" + var_4 + "_lp");
}

set_fx_blood_generic(var_0) {
  if(isDefined(self.blood_fx_index))
    self.blood_fx_index delete();

  self.blood_fx_index = _id_0547::_id_8FBA(self, var_0);
  _triggerfx(self.blood_fx_index);
  _id_0378::_id_8D74("aud_bloodraven_bloodcode_final", self, var_0);
}

code_correct(var_0, var_1) {
  foreach(var_4, var_3 in var_0) {
    if(var_3 != var_1[var_4].blood_fx_index)
      return 0;
  }

  return 1;
}

wait_for_structs_revealed(var_0) {
  var_1 = 0;

  while(!var_1) {
    var_1 = 1;

    foreach(var_3 in var_0) {
      if(!isDefined(var_3.blood_fx_index))
        var_1 = 0;
    }

    waitframe();
  }
}

radio_soul_collect_response(var_0) {
  var_1 = _getent("zmf_bloodraven_radio_place_trig", "targetname");
  thread maps\mp\mp_zombie_descent::on_zombie_soul_collected_func(var_0);
  var_1 notify("trigger");
}

quest_step_bloodraven_enter_trial() {
  var_0 = wait_for_sheild_owner_sacrifice();
  var_0 _id_0378::_id_8D74("aud_bloodraven_enter_trial");
  _id_0557::_id_782D("quest_bloodraven", "quest_bloodraven_enter_trial");
}

quest_step_bloodraven_complete_trial() {
  var_0 = get_blood_shield_owner();
  var_1 = common_scripts\utility::_id_46B7("zom_dlc4_shield_zm_spawns", "targetname");
  var_2 = common_scripts\utility::random(var_1);
  var_3 = spawnStruct();
  var_3.origin = var_0.origin;
  var_3.angles = var_0.angles;

  for(var_4 = 0; !var_4; var_0 = wait_for_sheild_owner_sacrifice()) {
    var_0.old_destination = var_3;
    var_0 setOrigin(var_2.origin, 1);

    if(common_scripts\utility::_id_562E(var_0 run_weapon_ritual("zom_dlc4_shield_zm"))) {
      break;
    }
  }

  var_0 _id_0378::_id_8D74("aud_bloodraven_exit_trial");
}

wait_for_sheild_owner_sacrifice() {
  var_0 = common_scripts\utility::_id_46B5("ee_follower_rise", "targetname");
  level.zmb_player_last_stand_protection = ::is_player_sacrificing_to_bloodraven_quest;
  level waittill("zmb_enter_last_stand_bloodraven", var_1);
  level.zmb_player_last_stand_protection = undefined;
  return var_1;
}

is_player_sacrificing_to_bloodraven_quest(var_0) {
  var_1 = common_scripts\utility::_id_46B5("ee_follower_rise", "targetname");

  if(_distance2d(var_0.origin, var_1.origin) > 190)
    return 0;

  if(!var_0 hasweapon("zom_dlc4_shield_zm"))
    return 0;

  level notify("zmb_enter_last_stand_bloodraven", var_0);
  return 1;
}

is_code_entry(var_0) {
  var_1 = self;
  return issubstr(var_1._id_0165, var_0);
}

notify_blood_code_change() {
  var_0 = self;

  for(;;) {
    var_0 waittill("melee_fired");
    level notify("blood_change", var_0);
  }
}

handle_code_set() {
  var_0 = self;
  common_scripts\utility::_id_3C9F(_id_0557::_id_7838("quest_bloodraven", "quest_bloodraven_radio_find"));
  var_0 set_blood_code(common_scripts\utility::random(var_0.symbols));

  for(;;) {
    level waittill("blood_change", var_1);

    if(distance(var_1.origin, var_0.origin) < 52)
      var_0 set_next_symbol(var_1);
  }
}

set_next_symbol(var_0) {
  var_1 = self;
  var_2 = var_1.curindex;
  var_2++;

  if(var_2 >= var_1.symbols.size)
    var_2 = 0;

  var_1 set_blood_code(var_2, var_0);
}

set_blood_code(var_0, var_1) {
  var_2 = self;

  if(isDefined(var_2.fx))
    var_2.fx delete();

  if(var_0 == -1) {
    return;
  }
  var_2.fx = _id_0547::_id_8FBA(var_2, "zmb_desc_chladni_fig_" + var_0 + "_sml_lp", var_1);
  var_2.blood_fx_index = var_0;
  _triggerfx(var_2.fx);
}

turn_off_blood_code() {
  set_blood_code(-1);
}

handle_code_reveal() {
  var_0 = self;
  var_0 = common_scripts\utility::array_randomize(var_0);
  level.reveal_structs_in_order = var_0;

  foreach(var_2 in var_0) {
    var_3 = get_blood_shield_owner();
    var_2.wisp = 1;
    var_2.fx = _id_0547::_id_8FBA(var_2, "zmf_descent_vision_blood_ready", var_3);
    _triggerfx(var_2.fx);
    var_2.fx _id_0378::_id_8D74("aud_bloodraven_bloodpool_ready");
    var_2 thread wait_for_reveal();

    while(!common_scripts\utility::_id_562E(var_2.isrevealed))
      waitframe();

    var_2.wisp = undefined;
    var_3 = get_blood_shield_owner();
    var_2 set_blood_code(common_scripts\utility::random(var_2.symbols), var_3);
    _id_0378::_id_8D74("aud_bloodraven_reveal_bloodpool_code", var_2);
  }

  _id_0557::_id_782D("quest_bloodraven", "quest_bloodraven_acquire_code");
}

wait_for_reveal() {
  var_0 = self;
  var_1 = (0, 0, 0);

  for(;;) {
    level waittill("ce_explosion", var_1);

    if(distance(var_1, var_0.origin) < 52) {
      break;
    }
  }

  var_0.isrevealed = 1;
}

get_blood_shield_owner() {
  for(;;) {
    foreach(var_1 in level.players) {
      if(var_1 hasweapon("zom_dlc4_shield_zm"))
        return var_1;
    }

    waitframe();
  }
}

is_blood_input() {
  var_0 = self;
  return issubstr(var_0._id_0165, "set");
}

dropplayershield(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!common_scripts\utility::_id_562E(self.hasplayershield)) {
    return;
  }
  var_9 = self.sheild_attach;

  if(isDefined(self.playershieldsafespawnpos) && (!self isonground() || !_func_2E6(self.origin)))
    var_10 = self.playershieldsafespawnpos;
  else
    var_10 = var_9.origin;

  var_11 = var_9.angles;
  var_9 unlink();
  var_9 delete();
  maps\mp\zombies\weapons\_zombie_dlc4_melee::spawn_raven_weapon("shield", var_10, var_11);
  _id_0557::_id_782D("quest_bloodraven", "quest_bloodraven_acquire_sheild");
}

run_blood_drain_collection() {
  var_0 = (0, 0, 16);
  thread display_progress_in_blood();

  if(_id_0547::_id_5565(self._id_0165, "message_reveal_c"))
    common_scripts\utility::_id_3C9F("stopper_in_place");

  self.onzombiesacrificedfunc = ::drain_soul_collect_response;
  self.optionaldisablearclightning = 1;
  maps\mp\mp_zombies_soul_collection::beginazombiesoulcollectionobjectiveonstruct(5, 300, 64, self.getnegotiationnextnode + "_soul", undefined, "tag_origin", undefined, "tag_origin", undefined, self, var_0, undefined, 1, 1);
  common_scripts\utility::flag_set(self.getnegotiationnextnode);
}

drain_soul_collect_response(var_0) {
  thread maps\mp\mp_zombie_descent::on_zombie_soul_collected_func(var_0);
}

display_progress_in_blood() {
  var_0 = self;
  var_1 = _getent(var_0.target, "targetname");
  var_1.full_origin = var_1.origin;
  var_1.empty_origin = var_1.origin - (0, 0, 16);
  var_1.origin = var_1.empty_origin;

  while(!isDefined(var_0.collector))
    waitframe();

  var_0 thread end_blood_progress_updates();
  var_0 endon("stop_blood_progress_update");

  for(;;) {
    if(isDefined(var_0.collector))
      var_2 = var_0.collector._id_AC2C / var_0.collector._id_AC2D;
    else
      var_2 = 1;

    if(var_2 > 1)
      var_2 = 1;

    var_1 moveto(_vectorlerp(var_1.empty_origin, var_1.full_origin, var_2), 0.5);
    wait 0.5;
  }
}

end_blood_progress_updates() {
  var_0 = self;
  var_0.collector waittill("entitydeleted");

  while(isDefined(var_0.collector))
    waitframe();

  wait 0.55;
  var_0 notify("stop_blood_progress_update");
}

__________________deathraven__________________() {}

quest_step_deathraven_push_stone() {
  level thread handle_wire_pickup();
  var_0 = _getent("zmb_deathraven_stone", "targetname");
  var_0.dest = common_scripts\utility::_id_46B5(var_0.target, "targetname");
  var_1 = _getent("zmb_deathraven_trigger", "targetname");
  var_1 waittill("trigger", var_2);
  _id_0378::_id_8D74("aud_deathraven_button", var_0);
  _id_0557::_id_782D("quest_deathraven", "quest_deathraven_activate_rush");
}

handle_wire_pickup() {
  var_0 = common_scripts\utility::_id_46B5("zmf_deathraven_wire_struct", "targetname");
  var_1 = common_scripts\utility::_id_44BE(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    switch (var_3._id_0165) {
      case "zmf_deathraven_wire_trig":
        var_0._id_9D5E = var_3;
        break;
      case "zmf_deathraven_wire_model":
        var_0.ent_model = var_3;
        break;
    }
  }

  var_0._id_9D5E waittill("trigger", var_5);
  var_0.ent_model hide();
  common_scripts\utility::flag_set("deathraven_metal_collected");
}

quest_step_deathraven_survive_rush() {
  var_0 = _getent("zmb_deathraven_stone", "targetname");
  var_0 moveto(var_0.dest.origin, 1, 0, 0.2);

  foreach(var_2 in level.players) {
    if(distance(var_2.origin, var_0.origin) > 1000) {
      continue;
    }
    var_3 = 2.8;
    var_2 thread maps\mp\mp_zombie_descent_utils::start_screenshake(var_3);
    var_2 _id_0378::_id_8D74("aud_deathraven_earthquake", var_3);
  }

  enable_firewalls(1);
  maps\mp\gametypes\zombies::_id_08B2(var_0.origin, 1);
  level.maxed_zombies_sprint = 1;
  level.zmb_locked_spawn_zones = ["zone_gallery"];
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8606();
  level.overridespawndelay = 0.08;
  var_5 = _getent("deathraven_blood_raise", "targetname");

  if(isDefined(var_5))
    var_5 movez(7, 35);

  level thread mark_death_event_goers();
  var_6 = 35;

  if(_id_0547::is_solo())
    var_6 = 26;

  wait(var_6);
  _activateclientexploder(225);
  var_5 _id_0378::_id_8D74("aud_deathraven_scythe_appear");
  _id_0557::_id_782D("quest_deathraven", "quest_deathraven_survive_rush");
}

quest_step_deathraven_acquire_spine() {
  level thread maps\mp\_utility::_id_6F74(::show_marked_eater_to_scythe_holders);
  _id_0547::_id_7BA9(::give_corpse_eater_spine);

  for(;;) {
    var_0 = _id_0547::_id_4090("zombie_dlc4");
    var_1 = 0;

    foreach(var_3 in var_0) {
      if(common_scripts\utility::_id_562E(var_3.ismarkedeater)) {
        var_4 = var_3;
        var_1 = 1;
        break;
      }
    }

    if(!var_1 && var_0.size > 0) {
      var_4 = common_scripts\utility::random(var_0);
      var_4.ismarkedeater = 1;
    }

    waitframe();
  }
}

give_corpse_eater_spine(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!common_scripts\utility::_id_562E(self.ismarkedeater)) {
    return;
  }
  if(!isDefined(var_1) || !isPlayer(var_1)) {
    return;
  }
  if(!isDefined(var_4)) {
    return;
  }
  if(!issubstr(var_4, "scythe")) {
    return;
  }
  var_1 give_player_the_corpse_eater_spine();
}

give_player_the_corpse_eater_spine() {
  var_0 = self;

  if(common_scripts\utility::_id_3C77(_id_0557::_id_7838("quest_deathraven", "quest_deathraven_acquire_weapon"))) {
    return;
  }
  _id_0547::_id_2D8C(::give_corpse_eater_spine);
  _id_0557::_id_782D("quest_deathraven", "quest_deathraven_acquire_weapon");
  var_0 maps\mp\mp_zombie_descent_utils::spine_pickup_anim("spine_inspect_c_eater_zm");
  common_scripts\utility::flag_set("deathraven_spine_collected");
}

show_marked_eater_to_scythe_holders() {
  var_0 = self;
  var_0 endon("disconnect");

  for(;;) {
    foreach(var_2 in _id_0547::_id_4090("zombie_dlc4")) {
      if(common_scripts\utility::_id_562E(var_2.ismarkedeater)) {
        if(!isDefined(var_2.markedviewers))
          var_2.markedviewers = [];

        if(var_0 is_deathraven_holder() && !common_scripts\utility::_id_0F79(var_2.markedviewers, var_0)) {
          var_2.markedviewers = common_scripts\utility::_id_0F6F(var_2.markedviewers, var_0);
          _playfxontagforclients(level._effect["zmb_scythe_zmb_blind"], var_2, "J_Head", var_0);
          continue;
        }

        if(!var_0 is_deathraven_holder() && common_scripts\utility::_id_0F79(var_2.markedviewers, var_0)) {
          var_2.markedviewers = common_scripts\utility::_id_0F93(var_2.markedviewers, var_0);
          _stopfxontagforclient(level._effect["zmb_scythe_zmb_blind"], var_2, "J_Head", var_0);
        }
      }
    }

    waitframe();
  }
}

mark_death_event_goers() {
  level notify("mark_event_goers");
  level endon("mark_event_goers");
  var_0 = _getent("zone_gallery_deathravent_event", "targetname");

  while(!common_scripts\utility::_id_3C77(_id_0557::_id_7838("quest_deathraven", "quest_deathraven_survive_rush"))) {
    foreach(var_2 in level.players) {
      if(var_2 istouching(var_0) && !_id_0547::_id_577E(var_2)) {
        var_2.isintrial = "quest_deathraven";
        continue;
      }

      if(!var_2 is_in_other_event())
        var_2.isintrial = undefined;
    }

    foreach(var_5 in _id_0547::_id_408F()) {
      if(!var_5 is_in_other_event())
        var_5.isintrial = "quest_deathraven";
    }

    waitframe();
  }

  foreach(var_2 in level.players) {
    if(var_2 is_in_deathraven_event())
      var_2.isintrial = undefined;
  }
}

is_in_other_event() {
  var_0 = self;
  return isDefined(var_0.isintrial) && var_0.isintrial != "quest_deathraven";
}

is_in_deathraven_event() {
  var_0 = self;
  return _id_0547::_id_5565(var_0.isintrial, "quest_deathraven");
}

quest_step_deathraven_pickup_weapon() {
  var_0 = common_scripts\utility::_id_46B5("zmb_scythe_pickup", "targetname");
  level thread cleanup_deathraven_combat_event(var_0.origin);
  var_1 = maps\mp\zombies\weapons\_zombie_dlc4_melee::spawn_raven_weapon("scythe", var_0.origin);
  _stopclientexploder(225);
  _id_0378::_id_8D74("aud_deathraven_scythe_obtain");
  _id_0557::_id_782D("quest_deathraven", "quest_deathraven_pickup_weap");
}

quest_step_deathraven_assemble_weapon() {
  var_0 = _getent("zmb_deathraven_assembly_trigger", "targetname");
  var_1 = _getent("zmb_deathraven_assembly_spine", "targetname");
  var_2 = _getent("zmb_deathraven_assembly_metal", "targetname");
  var_3 = _getent("zmb_deathraven_assembly_scythe", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_4);

    if(common_scripts\utility::_id_3C77("deathraven_spine_collected")) {
      var_1 show();
      common_scripts\utility::flag_set("deathraven_spine_placed");
      var_1 _id_0378::_id_8D74("aud_deathraven_place_spine");
    }

    if(common_scripts\utility::_id_3C77("deathraven_metal_collected")) {
      var_2 show();
      common_scripts\utility::flag_set("deathraven_metal_placed");
      var_2 _id_0378::_id_8D74("aud_deathraven_place_scythe");
    }

    if(!common_scripts\utility::_id_3C77("deathraven_spine_collected") || !common_scripts\utility::_id_3C77("deathraven_metal_collected")) {
      continue;
    }
    var_5 = var_4 getcurrentweapon();

    if(common_scripts\utility::_id_3C77("deathraven_scythe_placed") || _id_0547::_id_5565(var_5, "zom_dlc4_scythe_zm")) {
      var_4 _id_0586::_id_0790("zom_dlc4_scythe_zm");
      var_6 = _id_0548::_id_454B(var_4, "shovel_zm");
      var_4 _id_0586::_id_078C(var_6);
      var_4 _id_0586::_id_078E(var_6);
      var_3 show();
      common_scripts\utility::flag_set("deathraven_scythe_placed");
    }

    if(common_scripts\utility::_id_3C77("deathraven_spine_placed") && common_scripts\utility::_id_3C77("deathraven_metal_placed") && common_scripts\utility::_id_3C77("deathraven_scythe_placed")) {
      var_0.assembled = 1;
      break;
    }
  }

  _id_0557::_id_782D("quest_deathraven", "quest_deathraven_assemble_weap");
}

quest_step_deathraven_fuse() {
  show_scythe_assembly();
  var_0 = _getent("zmb_deathraven_assembly_scythe", "targetname");
  var_1 = var_0 common_scripts\utility::_id_8FFC();
  var_1 show();
  var_1.onzombiesacrificedfunc = ::onscythezombiecollected;
  var_1 maps\mp\mp_zombies_soul_collection::_id_170B(15, 300, 64, "scythe_soul_collect", undefined, "tag_origin", undefined, "tag_origin", undefined, self, (0, 0, 16), undefined, 1);
  level.zmb_scythe_collector = var_1;
  _id_0557::_id_782D("quest_deathraven", "quest_deathraven_fuse_weap");
}

onscythezombiecollected(var_0) {
  var_1 = _getent("zmb_deathraven_assembly_scythe", "targetname");

  if(var_0._id_AC2C == 5) {
    _playfxontag(common_scripts\utility::_id_44F5("zmb_death_scythe_forge"), var_1, "tag_fx");
    var_1 _id_0378::_id_8D74("aud_deathraven_scythe_heat_stage_1");
  }
}

quest_step_deathraven_transport() {
  var_0 = _getent("zmb_deathraven_assembly_scythe", "targetname");
  _stopfxontag(common_scripts\utility::_id_44F5("zmb_death_scythe_forge"), var_0, "tag_fx");
  _playfxontag(common_scripts\utility::_id_44F5("zmb_death_scythe_forge_stage2"), var_0, "tag_fx");
  var_0 _id_0378::_id_8D74("aud_deathraven_scythe_heat_stage_2");
  var_1 = level._id_A980;

  while(var_1 + 1 >= level._id_A980)
    waitframe();

  _stopfxontag(common_scripts\utility::_id_44F5("zmb_death_scythe_forge_stage2"), var_0, "tag_fx");
  _playfxontag(common_scripts\utility::_id_44F5("zmb_death_scythe_forge_endstage"), var_0, "tag_fx");

  if(!isDefined(level.zmb_scythe_collector)) {
    level.zmb_scythe_collector = var_0 common_scripts\utility::_id_8FFC();
    level.zmb_scythe_collector show();
  }

  level.zmb_scythe_collector _id_0378::_id_8D74("aud_deathraven_scythe_heated");
  wait 3;
  var_2 = wait_for_deathraven_spine_pickup();

  if(isDefined(level.zmb_scythe_collector))
    level.zmb_scythe_collector delete();

  _id_0557::_id_782D("quest_deathraven", "quest_deathraven_transport_weap");
}

wait_for_deathraven_spine_pickup() {
  var_0 = _getent("zmb_deathraven_assembly_trigger", "targetname");
  var_1 = undefined;
  var_0 common_scripts\utility::_id_9DA3();

  while(!isDefined(var_1) || !common_scripts\utility::_id_562E(var_0.assembled))
    var_0 waittill("trigger", var_1);

  var_0 common_scripts\utility::_id_9D9F();
  var_1 maps\mp\zombies\weapons\_zombie_dlc4_melee::try_drop_old_weapon(var_1 maps\mp\zombies\weapons\_zombie_dlc4_melee::getcurrentdlc4meleeweapon(), 0, 1);
  hide_scythe_assembly();
  var_0 _id_0378::_id_8D74("aud_deathraven_pickup_scythe");
  var_1.holdingdeathravenmaterials = 1;
  return var_1;
}

quest_step_deathraven_enter_trial() {
  level endon(_id_0557::_id_7838("quest_deathraven", "quest_deathraven_enter_trial"));

  for(;;) {
    var_0 = get_deathraven_holder();
    var_0 set_weapon_upgrade_blood_tube_route("zom_dlc4_scythe_zm");
    var_0 thread raven_trial_set_retry_on_death();
    var_0 common_scripts\utility::_id_A70A("disconnect", "return_faked_scythe", "fake_disconnect");

    foreach(var_2 in level.players)
    var_2.holdingdeathravenmaterials = 0;

    show_scythe_assembly();
    var_0 = wait_for_deathraven_spine_pickup();
  }
}

raven_trial_set_retry_on_death() {
  self endon("disconnect");
  self endon("return_faked_scythe");
  level endon(_id_0557::_id_7838("quest_deathraven", "quest_deathraven_enter_trial"));

  for(;;) {
    self waittill("zombie_player_spawn_finished");
    set_weapon_upgrade_blood_tube_route("zom_dlc4_scythe_zm");
  }
}

is_deathraven_holder() {
  return common_scripts\utility::_id_562E(self.holdingdeathravenmaterials) || common_scripts\utility::_id_562E(self hasweapon("zom_dlc4_scythe_zm"));
}

get_deathraven_holder() {
  for(;;) {
    foreach(var_1 in level.players) {
      if(var_1 is_deathraven_holder())
        return var_1;
    }

    waitframe();
  }
}

set_weapon_upgrade_blood_tube_route(var_0) {
  var_1 = self;
  var_1.forcedblooddest = var_0;
}

cleanup_deathraven_combat_event(var_0) {
  level notify("cleanup_deathraven_combat_event");
  level endon("cleanup_deathraven_combat_event");
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8608();
  maps\mp\gametypes\zombies::_id_08B2(var_0, 1);
  var_1 = _getent("deathraven_weapon_cover", "targetname");
  var_1 hide();
  level.overridespawndelay = undefined;
  level.zmb_locked_spawn_zones = undefined;
  enable_firewalls(0);
  level.maxed_zombies_sprint = 0;
  level.deathraven_event_happening = 0;
  wait 6;
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8607();
}

init_deathraven_quest() {
  enable_firewalls(0);
  var_0 = _getent("deathraven_blood_raise", "targetname");
  var_0 movez(-7, 0.1);
  common_scripts\utility::flag_init("deathraven_spine_collected");
  common_scripts\utility::flag_init("deathraven_metal_collected");
  common_scripts\utility::flag_init("deathraven_spine_placed");
  common_scripts\utility::flag_init("deathraven_metal_placed");
  common_scripts\utility::flag_init("deathraven_scythe_placed");
  hide_scythe_assembly();
}

hide_scythe_assembly() {
  var_0 = _getent("zmb_deathraven_assembly_spine", "targetname");
  var_1 = _getent("zmb_deathraven_assembly_metal", "targetname");
  var_2 = _getent("zmb_deathraven_assembly_scythe", "targetname");
  var_0 hide();
  var_1 hide();
  var_2 hide();
}

show_scythe_assembly() {
  level.zmb_scythe_no_spawn = 1;
  var_0 = _getent("zmb_deathraven_assembly_spine", "targetname");
  var_1 = _getent("zmb_deathraven_assembly_metal", "targetname");
  var_2 = _getent("zmb_deathraven_assembly_scythe", "targetname");
  var_0 show();
  var_1 show();
  var_2 show();
}

enable_firewalls(var_0) {
  var_1 = getEntArray("zmb_firewall_collision", "script_noteworthy");

  foreach(var_3 in var_1) {
    if(var_0) {
      var_3 solid();
      continue;
    }

    var_3 notsolid();
  }

  enable_bumpers(var_0);
}

enable_bumpers(var_0) {
  level notify("new_enable_bumpers");
  level endon("new_enable_bumpers");

  if(var_0) {
    var_1 = getEntArray("zmb_firewall_collision_bumpers", "script_noteworthy");

    foreach(var_3 in var_1)
    var_3 childthread push_players();
  }

  var_5 = common_scripts\utility::_id_46B7("zmb_firewall_fx", "script_noteworthy");

  foreach(var_7 in var_5) {
    if(isDefined(var_7.my_fire_fx))
      var_7.my_fire_fx delete();

    if(!var_0) {
      continue;
    }
    var_7.my_fire_fx = _id_0547::_id_8FBA(var_7, "zmf_descent_firewall");
    _triggerfx(var_7.my_fire_fx);
    var_7.my_fire_fx _id_0378::_id_8D74("aud_deathraven_firewall", var_0);
  }
}

push_players() {
  for(;;) {
    waitframe();

    foreach(var_1 in level.players) {
      if(!common_scripts\utility::_id_562E(var_1.isonpushcooldown) && var_1 istouching(self)) {
        self.isfireinflictor = 1;
        thread push_off_wall(var_1);
      }
    }
  }
}

push_off_wall(var_0) {
  var_0 endon("disconnect");
  var_1 = var_0.origin - self.origin;
  var_1 = (var_1[0], var_1[1], 0);
  var_2 = vectorNormalize(var_1);
  var_0 setvelocity(300 * var_2 + (0, 0, 100));
  var_0.isonpushcooldown = 1;
  _playfxontagforclients(level._effect["player_screen_burn"], var_0, "TAG_ORIGIN", var_0);
  var_0 dodamage(35, var_0 getEye(), undefined, self.fireattacker, "MOD_ENERGY");
  wait 0.8;
  var_0.isonpushcooldown = 0;
}

run_weapon_ritual(var_0, var_1) {
  var_2 = self;

  if(!isPlayer(var_2)) {
    return;
  }
  var_2 endon("disconnect");
  var_2 endon("death");
  var_2._id_480F = 0;
  var_3 = level.raven_weapon_upgrade_trials[var_0];
  var_2.isintrial = var_0;
  var_3._id_08BE = 1;

  if(isDefined(var_0) && (var_0 != "zom_pap_trial_destination" && var_0 != "zom_bonus_trial_destination" && var_0 != "zom_shelf_trial_destination")) {
    var_2 disableweapons();
    var_2 allowmelee(0);
    var_2 setclientomnvar("ui_hide_hud", 1);
    var_2 childthread weapon_ritual_weapon_picked_up();

    if(_id_0547::_id_5565(var_0, "zom_dlc4_scythe_zm"))
      thread maps\mp\zombies\weapons\_zombie_dlc4_melee::spawn_raven_weapon(var_3.weap_upgrade, var_3.weapon_spawn.origin, undefined, undefined, 1);
    else
      thread maps\mp\zombies\weapons\_zombie_dlc4_melee::spawn_raven_weapon(var_3.weap_upgrade, var_3.weapon_spawn.origin);
  } else
    var_2 enableweapons();

  var_3 childthread mark_zombies_in_trial(var_3.origin, var_0);

  if(isDefined(var_0) && (var_0 != "zom_pap_trial_destination" && var_0 != "zom_bonus_trial_destination" && var_0 != "zom_shelf_trial_destination"))
    var_2 thread run_weapon_trial_vision();

  var_4 = [[var_3._id_3F02]]();
  var_3._id_08BE = 0;

  if(common_scripts\utility::_id_562E(var_4))
    level.raven_trials_completed++;

  if(isDefined(var_3.return_func))
    var_2[[var_3.return_func]]();
  else {
    if(isDefined(var_2.old_destination.origin))
      var_2 setOrigin(var_2.old_destination.origin);

    if(isDefined(var_2.old_destination.angles))
      var_2 setplayerangles(var_2.old_destination.angles);
  }

  var_2.old_destination = undefined;
  var_2.isintrial = undefined;
  return common_scripts\utility::_id_562E(var_4);
}

weapon_ritual_weapon_picked_up() {
  self waittill("picked_up_raven_weapon");
  self allowmelee(1);
  self enableweapons();
  self setclientomnvar("ui_hide_hud", 0);
}

run_weapon_trial_vision() {
  var_0 = self;
  var_0 notify("set_trial_vision");
  var_0 endon("set_trial_vision");
  var_0 altered_state_fade();
  var_1 = "dlc_zmb_dig02_hallucination_02";
  var_0.altered_state_fx = _spawnlinkedfxforclient(common_scripts\utility::_id_44F5(var_1), var_0, "tag_origin", var_0);
  _triggerfx(var_0.altered_state_fx);
  var_0 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_0.altered_state_fx);
  var_0 _meth_866F(3.0, 1, 0.5);

  while(isDefined(var_0.isintrial))
    waitframe();

  var_0 altered_state_end_overlay(var_1, 1);
}

altered_state_fade() {
  var_0 = self;
  var_0 endon("disconnect");

  if(!isDefined(var_0.altered_state_overlay_fade))
    var_0.altered_state_overlay_fade = altered_state_create_client_overlay("white", 1, var_0);

  var_1 = 1;
  var_2 = 0.25;
  var_0.altered_state_overlay_fade.alpha = 0;
  var_0.altered_state_overlay_fade fadeovertime(var_1);
  var_0.altered_state_overlay_fade.alpha = 1;
  var_0 _id_0378::_id_8D74("dlc3_altered_state_fade");
  wait(var_1);
  var_0.altered_state_overlay_fade.alpha = 1;
  var_0.altered_state_overlay_fade fadeovertime(var_2);
  var_0.altered_state_overlay_fade.alpha = 0;
}

altered_state_create_client_overlay(var_0, var_1, var_2, var_3) {
  var_4 = 1;

  if(isDefined(var_3))
    var_4 = var_3;

  if(isDefined(var_2))
    var_5 = _newclienthudelem(var_2);
  else
    var_5 = newhudelem();

  var_5.x = 0;
  var_5.y = 0;
  var_5 setshader(var_0, 640, 480);
  var_5.alignx = "left";
  var_5.aligny = "top";
  var_5.sort = 1;
  var_5._id_00C6 = "fullscreen";
  var_5._id_01CA = "fullscreen";
  var_5.alpha = var_1;
  var_5.foreground = var_4;
  return var_5;
}

altered_state_end_overlay(var_0, var_1) {
  var_2 = self;
  var_2 endon("disconnect");

  if(isDefined(var_2.altered_state_fx))
    var_2.altered_state_fx delete();

  var_2 _meth_866F(1, 0, 1);
  var_2.in_altered_state = 0;
  var_2 lerpfovscale(1, 1.5);
}

mark_zombies_in_trial(var_0, var_1) {
  var_2 = 256;

  if(var_1 == "zom_bonus_trial_destination")
    var_2 = 850;

  while(common_scripts\utility::_id_562E(self._id_08BE)) {
    foreach(var_4 in _id_0547::_id_408F()) {
      if(_distance2d(var_4.origin, var_0) > var_2) {
        continue;
      }
      if(_abs(var_4.origin[2] - var_0[2]) > var_2) {
        continue;
      }
      var_4.isintrial = var_1;
      var_4._id_6734 = 1;
    }

    waitframe();
  }
}

get_all_zombies_for_trial(var_0) {
  var_1 = [];

  foreach(var_3 in _id_0547::_id_408F()) {
    if(_id_0547::_id_5565(var_3.isintrial, var_0))
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

run_deathraven_trial() {
  var_0 = self;
  var_1 = common_scripts\utility::_id_46B7("zone_lost_spawners_death_ce", "targetname");

  foreach(var_5, var_3 in var_1) {
    var_4 = _id_054D::_id_90BA("zombie_dlc4", var_3, "bloodraven zombies", 0, 1, 0);
    var_4.isdeathravenwustling = 1;
    var_4._id_56E1 = 1;
    var_4.tauntindex = var_5;
    var_4 _id_0547::disableoffhandsecondaryweapons();
    var_4 thread _id_0547::_id_7D1A("ce_taunt");
  }

  var_0 waittill("picked_up_raven_weapon");
  level notify("free_the_CEs");

  foreach(var_4 in _id_0547::_id_408F()) {
    if(common_scripts\utility::_id_562E(var_4.isdeathravenwustling))
      var_4 maps\mp\zombies\zombie_corpse_eater::set_corpse_eater_full();
  }

  wait_for_trial_zombies_clear();
  var_8 = common_scripts\utility::_id_46B7("zone_lost_spawners_death", "targetname");

  foreach(var_3 in var_8) {
    var_4 = _id_054D::_id_90BA("zombie_heavy", var_3, "bloodraven zombies", 0, 1, 0);
    playFX(level._effect["zmb_deathscythe_proj_exp"], var_4.origin + (0, 0, 32));
    var_4 _id_0378::_id_8D74("amooud_zmb_scythe_proj_impact");
    var_4.isdeathravenwustling = 1;
    wait 0.4;
  }

  wait_for_trial_zombies_clear();
  maps\mp\zquests\dlc4_trophies_mp_zombie_descent::complete_descent_trophy_event_7(var_0);
  wait 3;
  var_0 _id_0378::_id_8D74("aud_deathraven_exit_trail");
  _id_0557::_id_782D("quest_deathraven", "quest_deathraven_enter_trial");
  level.zmb_scythe_no_spawn = 0;
  return 1;
}

ce_taunt(var_0) {
  self endon("death");
  var_1 = "board_taunt";
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_1, undefined, 1);
  var_3 = self.tauntindex;

  if(isDefined(var_2)) {
    maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, var_1);
    self scragentsetanimmode("anim deltas");
    self scragentsetorientmode("face angle abs", self.angles);
    self scragentsetscripted(1);
    loop_my_taunt(var_2, var_3, 1.0, "taunt_anim");
  }
}

loop_my_taunt(var_0, var_1, var_2, var_3) {
  self endon("death");

  for(;;)
    maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_0, var_1, var_2, var_3);
}

ce_taunt_interrupt(var_0) {
  var_1 = "board_taunt";
  self scragentsetscripted(0);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, var_1);
}

wait_for_trial_zombies_clear() {
  for(;;) {
    var_0 = 1;

    foreach(var_2 in _id_0547::_id_4090("zombie_heavy")) {
      if(common_scripts\utility::_id_562E(var_2.isdeathravenwustling))
        var_0 = 0;
    }

    if(var_0) {
      break;
    }

    waitframe();
  }
}

run_moonraven_trial() {
  var_0 = self;
  var_1 = common_scripts\utility::_id_46B5("moonraven_trial_flamewave", "targetname");
  var_0 waittill("picked_up_raven_weapon");
  wait 2;
  moonraven_trial_spawns();

  if(!common_scripts\utility::_id_562E(self.has_shown_moon_trial_hint)) {
    self.has_shown_moon_trial_hint = 1;
    _id_0555::issprinting("dlc4_trial_hint_moon", var_0);
  }

  moonraven_trial_star_warning();
  moonraven_trial_flamewave(var_1, 0);
  wait 2;
  moonraven_trial_spawns();
  moonraven_trial_star_warning();
  moonraven_trial_flamewave(var_1, 0);
  wait 2;
  common_scripts\utility::flag_set("moon_trial_complete");
  maps\mp\zquests\dlc4_trophies_mp_zombie_descent::complete_descent_trophy_event_5(var_0);
  var_0 _id_0378::_id_8D74("aud_moonraven_exit_trail");
  _stopclientexploder(236);
  _id_0557::_id_782D("quest_moonraven", "quest_moonraven_enter_trial");
  return 1;
}

moonraven_trial_spawns() {
  var_0 = common_scripts\utility::_id_46B7("zone_lost_spawners_moon", "targetname");

  foreach(var_2 in var_0) {
    var_3 = _id_054D::_id_90BA("zombie_generic", var_2, "moonraven zombies", 0, 1, 1);
    var_3.ismoonravenwustling = 1;
    playFX(level._effect["zmb_moonorb_tel_appear"], var_3.origin + (0, 0, 48));
    var_3 _id_0378::_id_8D74("aud_moonorb_teleport");
    wait 0.4;
  }

  for(;;) {
    var_5 = 1;

    foreach(var_3 in _id_0547::_id_4090("zombie_generic")) {
      if(common_scripts\utility::_id_562E(var_3.ismoonravenwustling))
        var_5 = 0;
    }

    if(var_5) {
      break;
    }

    waitframe();
  }
}

moonraven_trial_flamewave(var_0, var_1) {
  if(isDefined(var_1))
    wait(var_1);

  if(isDefined(level.moon_orb_manager["moonscepter_owner"]))
    level.moon_orb_manager["moonscepter_owner"] notify("moonorb_force_cooldown_reset");

  var_2 = maps\mp\zombies\zombie_king::attack_flame_wave_spawn(var_0.origin, undefined, 1);
  var_2 thread common_scripts\utility::_id_2CB4(8, maps\mp\zombies\zombie_king::attack_flame_wave_stop);
  var_2 maps\mp\zombies\zombie_king::attack_flame_wave_wait_till_stopped();
  level notify("trial_stars_reset");
}

moonraven_trial_star_warning() {
  var_0 = _getent("moonraven_trail_star_center", "targetname");
  var_1 = getEntArray("moonraven_trail_star_outer", "targetname");
  var_2 = 3;

  foreach(var_4 in var_1) {
    var_4.old_position = var_4.origin;
    var_4 moveto(var_0.origin, var_2, 0.2, 0.2);
  }

  wait(var_2);
  var_0 hide();

  foreach(var_4 in var_1)
  var_4 hide();

  var_8 = _spawnfx(common_scripts\utility::_id_44F5("zmb_desc_flame_wave_fireball"), var_0.origin);
  _triggerfx(var_8);
  var_8 _id_0378::_id_8D74("aud_moonraven_trial_fire_strt");
  wait 1;
  thread stars_reset(var_8, var_1, var_0);
}

stars_reset(var_0, var_1, var_2) {
  level waittill("trial_stars_reset");
  var_0 delete();

  foreach(var_4 in var_1)
  var_4 thread star_reset_and_show();

  wait 0.6;
  var_2 show();
}

star_reset_and_show() {
  var_0 = self;
  var_0 moveto(var_0.old_position, 0.5);
  wait 0.6;
  var_0 show();
}

moonraven_trial_teleport_from_trial() {
  wait 2;
  var_0 = common_scripts\utility::_id_46B5("struct_moon_orb_teleport_exit", "targetname");
  var_1 = self;
  var_1 endon("disconnect");
  playFX(level._effect["zmb_moonorb_tel_disappear"], var_1.origin + (0, 0, 48));
  playFX(level._effect["zmb_moonorb_suck"], var_0.origin);
  var_1 _id_0378::_id_8D74("aud_moonorb_teleport");
  var_1 maps\mp\zombies\weapons\_zombie_dlc4_melee::moon_orb_play_screen_fx();
  wait 0.25;

  if(isDefined(level.moon_orb_manager["moonscepter_orb_active"]))
    level.moon_orb_manager["moonscepter_orb_active"] notify("moonorb_trial_end_stagnate");

  waittillframeend;
  var_1 setOrigin(var_0.origin);
  var_1 setplayerangles(var_0.angles);

  if(isDefined(self.wing_fx))
    thread maps\mp\zombies\zombie_king::spawn_wings();

  playFX(level._effect["zmb_moonorb_tel_appear"], var_1.origin + (0, 0, 48));
  var_1 childthread maps\mp\zombies\weapons\_zombie_dlc4_melee::record_landing_zone();
}

run_bloodraven_trial() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0 endon("death");
  var_1 = common_scripts\utility::_id_46B7("zone_lost_spawners_blood", "targetname");
  var_0 waittill("picked_up_raven_weapon");
  var_0 laststandrevive();
  var_0 _id_056A::_id_4775();
  var_0 do_blood_trial_phase(var_1);
  wait 1;
  var_0 do_blood_trial_phase(var_1);

  if(!_id_0557::_id_783E("quest_bloodraven", "quest_bloodraven_enter_trial"))
    _id_0557::_id_782D("quest_bloodraven", "quest_bloodraven_enter_trial");

  _id_0557::_id_782D("quest_bloodraven", "quest_bloodraven_complete_trial");
  wait 2;
  return 1;
}

do_blood_trial_phase(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_1 endon("death");
  var_2 = 3;

  while(!level.blood_plates["trial"].isbloodfull) {
    var_3 = get_all_zombies_for_trial("zom_dlc4_shield_zm");

    if(isDefined(var_3) && var_3.size >= var_2) {
      wait 0.5;
      continue;
    }

    var_4 = _id_054D::_id_90BA("zombie_generic", common_scripts\utility::random(var_0), "bloodraven zombies", 0, 1, 1);
    var_4._id_6816 = 1;
    playFX(level._effect["gib_full_body"], var_4.origin);
    _func_351(level._id_2FDE["full"][_id_0547::_id_4495()], undefined, var_4.origin);
    wait 2;
  }

  wait 2;
  var_5 = common_scripts\utility::_id_46B7("sun_attack_spawn", "targetname");
  var_5 = common_scripts\utility::array_randomize(var_5);
  var_6 = var_5[0] common_scripts\utility::_id_8FFC();
  var_6 show();
  var_6 thread _id_67F1("notify_sun_kill", 4.0);
  var_6 maps\mp\zombies\zombie_king::sun_attack_run();
  var_6 delete();
  level.blood_plates["trial"] maps\mp\mp_zombie_descent::blood_plate_empty();
}

bloodraven_exit_from_trial() {
  thread maps\mp\zombies\_zombies_blood_tubes::do_transport_rumble(5, 0);
  thread maps\mp\zombies\_zombies_blood_tubes::run_blood_intro(self getEye(), self getEye());
  wait 2;
  var_0 = common_scripts\utility::_id_46B5("struct_bloodraven_trial_exit", "targetname");
  self setOrigin(var_0.origin, 1);
  self setplayerangles(var_0.angles);
  playFX(level._effect["gib_full_body"], self.origin);
  wait 4;
  maps\mp\zquests\dlc4_trophies_mp_zombie_descent::complete_descent_trophy_event_6(self);
}

add_pap_time(var_0) {
  if(!isDefined(level.pap_timeout))
    level.pap_timeout = 0;

  level.pap_timeout = level.pap_timeout + 25;
}

run_pack_a_punch_visit() {
  var_0 = self;

  if(!isDefined(level.pap_timeout) || isDefined(level.pap_timeout) && level.pap_timeout < 0)
    level.pap_timeout = 0;

  var_0.inasneakyplace = 1;
  var_0 childthread spawn_pap_zombies();

  if(level.pap_timeout < 10)
    level.pap_timeout = 10;

  level thread pap_timer();
  [var_2, var_3] = common_scripts\utility::_id_A70E(level, "pap_timeout", var_0, "death", var_0, "disconnect");

  if(_id_0547::_id_5565(var_2, "pap_timeout")) {
    var_0.tryingtoleavepap = 1;

    foreach(var_5 in level.players) {
      if(common_scripts\utility::_id_562E(var_5.tryingtoleavepap) && _id_0547::_id_5565(var_5 _id_055A::_id_462D(), "zone_lost")) {
        if(!isDefined(var_5.hitchingaride) || isDefined(var_5.hitchingaride) && !var_5.hitchingaride)
          var_5.hitchingaride = 1;
      }
    }
  } else if(_id_0547::_id_5565(var_2, "death")) {
    var_0.tryingtoleavepap = 0;
    var_0.hitchingaride = 0;
  }

  var_0.inasneakyplace = 0;
  return 1;
}

pap_timer() {
  level notify("pap_timer_start");
  level endon("pap_timer_start");

  while(level.pap_timeout > 0) {
    wait 1;
    level.pap_timeout--;
  }

  level notify("pap_timeout");
}

spawn_pap_zombies() {
  if(!isDefined(level.pap_zombies))
    level.pap_zombies = [];

  pap_register_killed_func();
  var_0 = common_scripts\utility::_id_46B7("zone_lost_spawners", "targetname");

  foreach(var_2 in var_0) {
    var_2._id_8C95 = 1;
    var_2.ignorehidingskyspawner = 1;
  }

  wait 0.5;

  for(var_4 = level.pap_zombies.size; var_4 < 4; var_4++) {
    wait(_randomfloatrange(0.05, 0.25));
    var_5 = spawn_pap_zombie(var_0);
  }
}

pap_register_killed_func() {
  var_0 = ::clear_pap_zombie_on_death;

  if(!isDefined(level.pap_zombie)) {
    foreach(var_2 in level._id_376B) {
      if(var_2 == var_0)
        return;
    }
  }

  _id_0547::_id_7BA9(var_0);
}

spawn_pap_zombie(var_0) {
  var_1 = _id_054D::_id_90BA("zombie_generic", common_scripts\utility::random(var_0), "pap zpmbies", 0, 1, 1);

  if(!isDefined(var_1))
    return undefined;

  var_1.ispapzombie = 1;
  level.pap_zombies[level.pap_zombies.size] = var_1;
  var_1 thread track_pap_zone();
  var_1 _id_0547::disableoffhandsecondaryweapons();
  return var_1;
}

track_pap_zone() {
  self endon("death");
  var_0 = _getent("zone_lost", "targetname");
  self waittill("zombie_fall_impact");

  while(self istouching(var_0) || !common_scripts\utility::_id_562E(self._id_4BA0))
    waitframe();

  self.ispapzombie = 0;
  level.pap_zombies = common_scripts\utility::_id_0F93(level.pap_zombies, self);
}

clear_pap_zombie_on_death(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(_id_0547::_id_5565(self.ispapzombie, 1))
    level.pap_zombies = common_scripts\utility::_id_0F93(level.pap_zombies, self);

  if(!isDefined(level.pap_zombies) || level.pap_zombies.size < 0)
    _id_0547::_id_2D8C(::clear_pap_zombie_on_death);
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
  common_scripts\utility::flag_init("flag_stormraven_stopper_1_collected");
  common_scripts\utility::flag_init("flag_stormraven_stopper_2_collected");
  common_scripts\utility::flag_init("flag_stormraven_stopper_3_collected");
  common_scripts\utility::flag_init("flag_stormraven_stopper_4_collected");
  common_scripts\utility::flag_init("flag_stormraven_stoppers_placed");
  common_scripts\utility::flag_init("flag_stormraven_runes_charged");
  common_scripts\utility::flag_init("flag_stormraven_uber_charged");
  common_scripts\utility::flag_init("flag_stormraven_hammer_sneaking_complete");
  common_scripts\utility::flag_init("flag_stormraven_hammer_tethered");
  common_scripts\utility::flag_init("flag_stormraven_hammer_rod_one_complete");
  common_scripts\utility::flag_init("flag_stormraven_hammer_rod_two_complete");
  common_scripts\utility::flag_init("flag_stormraven_hammer_rod_three_complete");
  common_scripts\utility::flag_init("flag_stormraven_hammer_rod_four_complete");
  common_scripts\utility::flag_init("flag_stormraven_hammer_picked_up");
  common_scripts\utility::flag_init("flag_stormraven_charge_puzzle_activated");
  common_scripts\utility::flag_init("flag_stormraven_special_rune_charged");
  common_scripts\utility::flag_init("flag_stormraven_charge_puzzle_stage_one_complete");
  common_scripts\utility::flag_init("flag_stormraven_charge_puzzle_stage_two_complete");
  common_scripts\utility::flag_init("flag_stormraven_charge_puzzle_stage_three_complete");
  common_scripts\utility::flag_init("flag_stormraven_trial_ascension_complete");
  common_scripts\utility::flag_init("flag_stormraven_trial_completed");
}

stormraven_init_debug() {}

_____summon_hammer_____() {}

stormraven_summon_hammer_main() {
  thread stormraven_summon_hammer_init();
  common_scripts\utility::_id_3C9F("flag_stormraven_stoppers_placed");
  thread stormraven_charge_rune_soulbucket_init();
  common_scripts\utility::_id_3C9F("flag_stormraven_runes_charged");
  thread stormraven_hammer_summon();
  _iprintlnbold("Summon Hammer - Step Complete!");
  _id_0557::_id_782D("quest_stormraven", "step_stormraven_chase_hammer");
}

stormraven_summon_hammer_init() {
  var_0 = common_scripts\utility::_id_46B7("stormraven_bloodstopper_object", "targetname");
  level.bloodstoppersininventory = 0;
  level.bloodstopperscollected = 0;
  stormraven_bloodstopper_choose(var_0);

  foreach(var_2 in var_0)
  var_2 thread stormraven_bloodstopper_init();

  var_4 = getEntArray("stormraven_bloodfall_trigger", "targetname");

  foreach(var_6 in var_4)
  var_6 thread stormraven_bloodfall_init();

  var_8 = getEntArray("stormraven_charge_rune", "targetname");

  foreach(var_10 in var_8)
  var_10 thread stormraven_charge_rune_init();
}

stormraven_bloodstopper_choose(var_0) {
  var_1 = 0;

  while(var_1 < 4) {
    var_2 = common_scripts\utility::random(var_0);
    var_2.ischosen = 1;
    var_1++;
    var_0 = common_scripts\utility::_id_0F93(var_0, var_2);
    waitframe();
  }
}

stormraven_bloodstopper_init() {
  var_0 = getEntArray(self.target, "targetname");

  foreach(var_2 in var_0) {
    switch (var_2._id_0165) {
      case "stormraven_bloodstopper_trigger":
        self.usetrigger = var_2;
        break;
      case "stormraven_bloodstopper_model":
        self.stoppermodel = var_2;
        self.stoppermodel hide();
        break;
    }
  }

  if(common_scripts\utility::_id_562E(self.ischosen)) {
    self.stoppermodel show();
    thread stormraven_bloodstopper_pickup();
  }
}

stormraven_bloodstopper_pickup() {
  for(;;) {
    self.usetrigger waittill("trigger", var_0);

    if(_bullettracepassed(var_0 getEye(), self.origin, 0, self.stoppermodel)) {
      self.usetrigger _id_0378::_id_8D74("aud_stormraven_bloodstopper_pickup");
      level.bloodstoppersininventory++;
      level.bloodstopperscollected++;
      common_scripts\utility::flag_set("flag_stormraven_stopper_" + common_scripts\utility::_id_9AAD(level.bloodstopperscollected) + "_collected");
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
      self.stoppermodel _id_0378::_id_8D74("aud_stormraven_bloodstopper_place");
      _id_0378::_id_8D74("aud_stop_stormraven_bloodfall");
      self.stoppermodel show();
      wait 0.5;
      self.stoppermodel movez(-8, 1, 0.25, 0.75);
      wait 1;
      self.bfall_fx delete();
      self._id_3F76 delete();
      level.stoppersplaced++;
      break;
    }
  }

  if(level.stoppersplaced >= 4)
    common_scripts\utility::flag_set("flag_stormraven_stoppers_placed");
}

stormraven_bloodfall_init() {
  self.stoppermodel = _getent(self.target, "targetname");
  self.stoppermodel hide();
  self.stoppermodel notsolid();
  var_0 = common_scripts\utility::_id_46B7(self.target, "targetname");

  foreach(var_2 in var_0) {
    switch (var_2._id_0165) {
      case "stormraven_bloodfall_rune":
        self.rune = var_2;
        self.runeid = _randomintrange(0, 4);
        self.runemagnitude = _randomintrange(1, 2);
        break;
      case "stormraven_bloodfall_fx_org":
        self._id_3F76 = spawn("script_model", var_2.origin);
        self._id_3F76 setModel("tag_origin");
        self.bfall_fx = _spawnfx(common_scripts\utility::_id_44F5("zmb_desc_blood_wfall_bridge_s"), self._id_3F76.origin, anglesToForward(self.angles));
        _id_0378::_id_8D74("aud_stormraven_bloodfall");
        _triggerfx(self.bfall_fx);
        break;
    }
  }

  thread stormraven_bloodstopper_place();
  thread stormraven_bloodfall_rune_spawn();
  thread stormraven_charge_rune_determine_order();
  thread debug_draw_rune_order_run();
}

stormraven_bloodfall_rune_spawn() {
  self.runemodel = spawn("script_model", self.rune.origin);
  self.runemodel.angles = self.rune.angles;

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

  switch (self._id_0165) {
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
  switch (self.rune.setlookatent) {
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

  if(level.bloodfallrune.size >= 4)
    _iprintlnbold(level.bloodfallrune[0].runeid + level.bloodfallrune[1].runeid + level.bloodfallrune[2].runeid + level.bloodfallrune[3].runeid);
}

stormraven_charge_rune_soulbucket_init() {
  var_0 = getEntArray("stormraven_charge_rune", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread stormraven_make_rune_glow();
    var_2 thread stormraven_charge_rune_cleanup();
    var_2 thread stormraven_charge_rune_soulbucket();
  }

  thread stormraven_charge_rune_soulbucket_check_order();
}

stormraven_charge_rune_soulbucket() {
  level endon("stormraven_runes_charged");
  self.disable_end_sound = 1;
  var_0 = undefined;

  for(;;) {
    switch (self.runeid) {
      case 0:
        var_0 = "stormraven_charge_rune_a";
        childthread maps\mp\mp_zombies_soul_collection::_id_170B(1, 75, 50, var_0, undefined, "tag_origin", undefined, undefined, undefined, undefined, (0, 0, 32), undefined, undefined, undefined, 1);
        break;
      case 1:
        var_0 = "stormraven_charge_rune_b";
        childthread maps\mp\mp_zombies_soul_collection::_id_170B(1, 75, 50, var_0, undefined, "tag_origin", undefined, undefined, undefined, undefined, (0, 0, 32), undefined, undefined, undefined, 1);
        break;
      case 2:
        var_0 = "stormraven_charge_rune_c";
        childthread maps\mp\mp_zombies_soul_collection::_id_170B(1, 75, 50, var_0, undefined, "tag_origin", undefined, undefined, undefined, undefined, (0, 0, 32), undefined, undefined, undefined, 1);
        break;
      case 3:
        var_0 = "stormraven_charge_rune_d";
        childthread maps\mp\mp_zombies_soul_collection::_id_170B(1, 75, 50, var_0, undefined, "tag_origin", undefined, undefined, undefined, undefined, (0, 0, 32), undefined, undefined, undefined, 1);
        break;
    }

    level waittill(var_0);
  }
}

stormraven_charge_rune_soulbucket_check_order() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;

  for(;;) {
    var_3 = level common_scripts\utility::waittill_any_return("stormraven_charge_rune_a", "stormraven_charge_rune_b", "stormraven_charge_rune_c", "stormraven_charge_rune_d");

    switch (var_3) {
      case "stormraven_charge_rune_a":
        var_2 = 0;
        break;
      case "stormraven_charge_rune_b":
        var_2 = 1;
        break;
      case "stormraven_charge_rune_c":
        var_2 = 2;
        break;
      case "stormraven_charge_rune_d":
        var_2 = 3;
        break;
    }

    if(var_2 == level.bloodfallrune[var_0].runeid)
      var_1++;
    else {
      var_0 = 0;
      var_1 = 0;
      continue;
    }

    if(var_1 > level.bloodfallrune[var_0].runemagnitude) {
      var_0 = 0;
      var_1 = 0;
      continue;
    }

    if(var_1 == level.bloodfallrune[var_0].runemagnitude) {
      var_0++;
      var_1 = 0;
    }

    if(var_0 >= 4) {
      break;
    }

    waitframe();
  }

  level notify("stormraven_runes_charged");
  var_4 = common_scripts\utility::_id_46B5("stormraven_summon_hammer_strike_position", "targetname");
  var_5 = 0;
  var_6 = 2;

  while(var_5 < 15) {
    var_7 = _randomfloatrange(var_4.origin[0] - 20, var_4.origin[0] + 20);
    var_8 = _randomfloatrange(var_4.origin[1] - 20, var_4.origin[1] + 20);
    var_9 = var_4.origin[2];
    var_10 = (var_7, var_8, var_9);
    thread stormraven_lightning_strike(var_10);
    var_5++;

    if(var_6 > 0.25)
      var_6 = var_6 - 0.25;

    wait(var_6);
  }

  thread stormraven_lightning_strike(var_4.origin);
  thread stormraven_lightning_strike(var_4.origin);
  thread stormraven_lightning_strike(var_4.origin);
  thread stormraven_lightning_strike(var_4.origin);
  var_11 = _id_0547::_id_408F();

  if(isDefined(var_11) && var_11.size > 0) {
    foreach(var_13 in var_11) {
      if(distancesquared(var_4.origin, var_13.origin) < 10000)
        var_13 _id_0547::_id_5A85(var_13.origin, var_4.origin - var_13.origin);
    }

    _physicsexplosionsphere(var_4.origin, 250, 150, 4);
  }

  common_scripts\utility::flag_set("flag_stormraven_runes_charged");
}

stormraven_charge_rune_cleanup() {
  level waittill("stormraven_runes_charged");
  level._id_08E3 = common_scripts\utility::_id_0F93(level._id_08E3, self);
}

stormraven_hammer_summon() {
  var_0 = common_scripts\utility::_id_46B5("stormraven_hammer_spawn_location", "targetname");
  level.stormhammer = spawn("script_model", var_0.origin);
  level.stormhammer setModel("npc_gen_sledgehammer_zom");
  level.stormhammer._id_3F76 = spawn("script_model", var_0.origin);
  level.stormhammer._id_3F76 setModel("tag_origin");
  level.stormhammer._id_3F76 linktosynchronizedparent(level.stormhammer);
  _playfxontag(common_scripts\utility::_id_44F5("zmb_storm_hammer_charge"), level.stormhammer._id_3F76, "tag_origin");
  var_1 = _getent("hammer_tether_location", "targetname");
  level.hammerlocation = var_1;
  level.stormhammer _id_0378::_id_8D74("aud_stormraven_warhammer_spawn");
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

    waitframe();
  }
}

warp_summon_hammer() {
  common_scripts\utility::flag_set("flag_stormraven_stoppers_placed");
  common_scripts\utility::flag_set("flag_stormraven_runes_charged");
}

_____capture_hammer_____() {}

stormraven_capture_hammer_main() {
  thread stormraven_sneaking_init();
  common_scripts\utility::_id_3C9F("flag_stormraven_hammer_sneaking_complete");
  thread stormraven_flee_init();
  common_scripts\utility::_id_3C9F("flag_stormraven_hammer_tethered");
  thread stormraven_hammer_pickup();
  common_scripts\utility::_id_3C9F("flag_stormraven_hammer_picked_up");
  _iprintlnbold("Capture Hammer - Step Complete!");
  _id_0557::_id_782D("quest_stormraven", "step_stormraven_capture_hammer");
}

stormraven_sneaking_init() {
  if(common_scripts\utility::_id_3C77("flag_stormraven_hammer_tethered")) {
    return;
  }
  var_0 = _getent("stormhammer_sneak_trigger", "targetname");
  var_0 enablelinkto();

  if(isDefined(level.stormhammer))
    var_0 linktosynchronizedparent(level.stormhammer);

  var_0 thread stormraven_sneaking_start_sneak_check();
  var_1 = _getent("stormhammer_disable_tp_trigger", "targetname");
  var_1 enablelinkto();

  if(isDefined(level.stormhammer))
    var_1 linktosynchronizedparent(level.stormhammer);

  var_1 thread stormraven_sneaking_hammer_teleport_disable();
  thread stormraven_sneaking_hammer_teleport();
}

stormraven_sneaking_start_sneak_check() {
  level endon("stormraven_hammer_teleport_disabled");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    var_0 thread stormraven_sneaking_check_sneak_success(self);
  }
}

stormraven_sneaking_check_sneak_success(var_0) {
  level endon("stormraven_sneaking_failed");
  level endon("stormraven_hammer_teleport_disabled");

  for(;;) {
    var_1 = stormraven_sneaking_check_sneaking_radius(var_0);

    if(!common_scripts\utility::_id_562E(var_1)) {
      break;
    }

    var_2 = stormraven_sneaking_check_sneaking_status();

    if(!common_scripts\utility::_id_562E(var_2)) {
      self.sneaky = 0;
      level notify("stormraven_sneaking_failed");
    }

    self.sneaky = 1;
    waitframe();
  }

  self.issneaking = 0;
}

stormraven_sneaking_check_sneaking_radius(var_0) {
  if(self istouching(var_0))
    return 1;
  else
    return 0;
}

stormraven_sneaking_check_sneaking_status() {
  var_0 = self getstance();

  if(var_0 == "stand")
    return 0;

  var_1 = self isfiring();

  if(var_1)
    return 0;

  var_2 = self getvelocity();
  var_3 = 60;
  var_4 = _squared(var_3);
  var_5 = vectordot(var_2, var_2);

  if(var_5 > var_4)
    return 0;

  return 1;
}

stormraven_sneaking_hammer_teleport() {
  level.hammerlocation = common_scripts\utility::_id_46B5("stormraven_hammer_spawn_location", "targetname");
  var_0 = common_scripts\utility::_id_46B5("stormraven_hammer_spawn_location", "targetname");

  for(;;) {
    level waittill("stormraven_sneaking_failed");

    for(var_1 = common_scripts\utility::_id_46B7("stormraven_hammer_tp_location", "targetname"); level.hammerlocation == var_0; var_0 = common_scripts\utility::random(var_1)) {}

    playFX(common_scripts\utility::_id_44F5("zmb_storm_hammer_teleport_flash"), level.stormhammer.origin);
    _id_0378::_id_8D74("aud_stormraven_warhammer_tp_out", level.stormhammer.origin);
    level.stormhammer.origin = var_0.origin;
    playFX(common_scripts\utility::_id_44F5("zmb_storm_hammer_teleport_flash"), level.stormhammer.origin);
    _id_0378::_id_8D74("aud_stormraven_warhammer_tp_in", level.stormhammer.origin);
    level.hammerlocation = var_0;
    _physicsexplosionsphere(level.stormhammer.origin, 150, 50, 2);
    waitframe();
  }
}

stormraven_sneaking_hammer_teleport_disable() {
  for(;;) {
    self waittill("trigger", var_0);

    if(common_scripts\utility::_id_562E(var_0.sneaky)) {
      break;
    }
  }

  level notify("stormraven_hammer_teleport_disabled");
  common_scripts\utility::flag_set("flag_stormraven_hammer_sneaking_complete");
}

stormraven_flee_init() {
  if(common_scripts\utility::_id_3C77("flag_stormraven_hammer_tethered")) {
    return;
  }
  var_0 = common_scripts\utility::_id_46B7("hammer_flee_location", "script_noteworthy");
  var_1 = common_scripts\utility::_id_4461(level.stormhammer.origin, var_0, 200);
  level.hammerlocation = var_1;
  var_2 = _getent("stormraven_hammer_impact_trigger", "targetname");
  var_2 enablelinkto();
  var_2 linktosynchronizedparent(level.stormhammer);
  var_2 thread stormraven_flee_knockback();
  var_3 = _getent("stormhammer_sneak_trigger", "targetname");
  var_3 thread stormraven_flee_detect_player();
  level.stormhammer thread _id_0378::_id_8D74("aud_stormraven_warhammer_steady_mvmt");
}

stormraven_flee_detect_player() {
  level endon("stormraven_hammer_tethered");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    var_0 stormraven_flee_go_to_destination();
  }
}

stormraven_flee_go_to_destination() {
  var_0 = stormraven_flee_get_destination();
  level.stormhammer _id_0378::_id_8D74("aud_stormraven_warhammer_burst_mvmt");

  while(isDefined(var_0.setlookatent) && var_0.setlookatent == "transition_point") {
    stormraven_flee_orient_and_move(var_0);
    var_0 = stormraven_flee_get_destination(1);
    waitframe();
  }

  stormraven_flee_orient_and_move(var_0);

  if(!isDefined(level.stormhammerhasmoved))
    level.stormhammerhasmoved = 1;
}

stormraven_flee_get_destination(var_0) {
  var_1 = common_scripts\utility::_id_46B7("hammer_flee_location", "script_noteworthy");
  var_2 = [];

  if(isDefined(level.hammerlocation.target)) {
    if(level.hammerlocation.target.size > 2)
      var_2 = common_scripts\utility::_id_46B7(level.hammerlocation.target, "targetname");
  } else {
    var_3 = [];

    foreach(var_5 in var_1) {
      var_6 = _sighttracepassed(level.hammerlocation.origin, var_5.origin, 0, level.stormhammer);

      if(var_6)
        var_3 = common_scripts\utility::_id_0F6F(var_3, var_5);
    }

    if(common_scripts\utility::_id_0F79(var_3, level.hammerlocation))
      var_3 = common_scripts\utility::_id_0F93(var_3, level.hammerlocation);

    while(var_2.size < 2) {
      var_8 = 500000;
      var_9 = undefined;

      foreach(var_5 in var_3) {
        var_11 = distance(level.hammerlocation.origin, var_5.origin);

        if(var_11 >= var_8) {
          continue;
        }
        var_8 = var_11;
        var_9 = var_5;
      }

      if(isDefined(var_9)) {
        var_2 = common_scripts\utility::_id_0F6F(var_2, var_9);
        var_3 = common_scripts\utility::_id_0F93(var_3, var_9);
      }
    }
  }

  if(common_scripts\utility::_id_562E(var_0)) {
    if(isDefined(level.previoushammerposition)) {
      if(common_scripts\utility::_id_0F79(var_2, level.previoushammerposition))
        var_2 = common_scripts\utility::_id_0F93(var_2, level.previoushammerposition);
    }
  }

  var_13 = level.hammerlocation.origin - self.origin;

  if(!isDefined(level.previoushammerposition))
    level.previoushammerposition = level.hammerlocation;

  var_14 = 10000000;
  var_15 = undefined;

  foreach(var_5 in var_2) {
    var_17 = var_5.origin - level.hammerlocation.origin;
    common_scripts\utility::_id_33BA(level.hammerlocation.origin, var_5.origin, 1, 0, 0, 6);

    if(common_scripts\utility::_id_562E(var_0)) {
      common_scripts\utility::_id_33BA(level.previoushammerposition.origin, level.hammerlocation.origin, 0, 0, 1, 6);
      var_18 = level.hammerlocation.origin - level.previoushammerposition.origin;
      var_19 = var_17 - var_18;
    } else {
      common_scripts\utility::_id_33BA(self.origin, level.hammerlocation.origin, 0, 0, 1, 6);
      var_19 = var_17 - var_13;
    }

    var_20 = vectordot(var_19, var_19);

    if(var_20 >= var_14) {
      continue;
    }
    var_14 = var_20;
    var_15 = var_5;
  }

  level.previoushammerposition = level.hammerlocation;
  return var_15;
}

stormraven_flee_orient_and_move(var_0) {
  var_1 = 325;
  var_2 = 0;

  if(isDefined(level.hammerlocation.targetname) && level.hammerlocation.targetname == "hammer_tether_location" && common_scripts\utility::_id_562E(level.stormhammerhasmoved)) {
    if(common_scripts\utility::_id_3C77("flag_stormraven_hammer_rod_one_complete"))
      var_2++;

    if(common_scripts\utility::_id_3C77("flag_stormraven_hammer_rod_two_complete"))
      var_2++;

    if(common_scripts\utility::_id_3C77("flag_stormraven_hammer_rod_three_complete"))
      var_2++;

    if(common_scripts\utility::_id_3C77("flag_stormraven_hammer_rod_four_complete"))
      var_2++;

    level notify("stormraven_hammer_in_tether_position");

    if(var_2 > 0)
      var_1 = var_1 / (var_2 * 4);
  }

  var_3 = distance(var_0.origin, level.hammerlocation.origin) / var_1;

  if(var_3 <= 0) {
    return;
  }
  var_4 = var_0.origin - level.stormhammer.origin;
  var_5 = vectortoangles(var_4);
  common_scripts\utility::_id_33BA(level.stormhammer.origin, var_0.origin, 0, 1, 1, 6);
  level.stormhammer.angles = var_5 + (90, 0, 0);
  level.stormhammer moveto(var_0.origin, var_3);
  wait(var_3);

  if(var_2 >= 4) {
    level.stormhammer moveto(level.hammerlocation.origin, 0.25);
    wait 0.25;
    level.stormhammer rotateto((0, 0, 0), 0.25);
    wait 0.25;
    return;
  }

  level.previoushammerposition = level.hammerlocation;
  level.hammerlocation = var_0;
}

stormraven_flee_knockback() {
  level endon("stormraven_hammer_tethered");

  for(;;) {
    self waittill("trigger", var_0);

    if(isPlayer(var_0)) {
      var_0 _id_0547::_id_7419(level.stormhammer.origin, 100);
      continue;
    }

    if(_isagent(var_0)) {
      var_1 = level.stormhammer.origin;
      var_0 _id_0547::_id_5A85(var_0.origin + (0, 0, 16), level.stormhammer.origin - var_0.origin + (0, 0, 16));
      waittillframeend;
      _physicsexplosionsphere(var_1, 100, 50, 1);
    }
  }
}

stormraven_uber_init() {
  var_0 = common_scripts\utility::_id_46B5("stormraven_wreckage_uber", "targetname");
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("npc_zom_uber_01");
  var_1._id_9D65 = _getent("stormraven_wreckage_uber_trigger", "targetname");
  var_1._id_9D65 waittill("trigger", var_2);
  var_2 thread _id_0585::_id_8555("stormraven_uber");
  level notify("player grabbed uber battery");
  var_2 thread _id_0585::_id_3481("stormraven_uber");
  var_1 delete();
  stormraven_uber_place();
}

stormraven_uber_place() {
  var_0 = _getent("stormraven_uber_place_trigger", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);
    var_0 _id_0378::_id_8D74("aud_stormraven_uberschnell_place");

    if(common_scripts\utility::_id_562E(var_1._id_56A5)) {
      var_1 notify("uber_deposited");
      var_2 = common_scripts\utility::_id_46B5("stormraven_uber_place_spawner", "targetname");
      var_3 = spawn("script_model", var_2.origin);
      var_3 setModel("zmb_gp_uber_01");
      var_4 = common_scripts\utility::_id_8FFC();
      var_4.origin = var_3.origin + (0, 0, 17);
      var_4 maps\mp\mp_zombies_soul_collection::beginazombiesoulcollectionobjectiveonstruct(15, 200, 100, "stormraven_uber", undefined, "tag_origin", "zmb_desc_storm_uber_charge_tip", undefined, undefined, undefined, (0, 0, 32));
      common_scripts\utility::flag_set("flag_stormraven_uber_charged");
      var_4 delete();
      var_5 = _spawnfx(level._effect["zmb_desc_storm_uber_charge"], var_3.origin, anglesToForward(var_3.angles));
      _triggerfx(var_5);
      break;
    }
  }
}

stormraven_lightning_rod_init() {
  var_0 = getEntArray("stormraven_lightning_rod", "script_noteworthy");
  var_0 = common_scripts\utility::_id_0F73(var_0, getEntArray("stormraven_lightning_rod_top", "script_noteworthy"));
  var_0 = common_scripts\utility::_id_0F73(var_0, getEntArray("stormraven_lightning_rod_middle_top", "script_noteworthy"));
  var_0 = common_scripts\utility::_id_0F73(var_0, getEntArray("stormraven_lightning_rod_middle_bottom", "script_noteworthy"));
  var_0 = common_scripts\utility::_id_0F73(var_0, getEntArray("stormraven_lightning_rod_bottom", "script_noteworthy"));

  foreach(var_2 in var_0)
  var_2 movez(-300, 0.05);

  common_scripts\utility::_id_3CA0("flag_stormraven_runes_charged", "flag_stormraven_uber_charged");
  var_4 = 6;

  foreach(var_2 in var_0) {
    var_2 movez(300, var_4, 0, 1);
    var_2 _id_0378::_id_8D74("aud_stormraven_lightning_rod_ascend", var_4, var_2.origin);
  }

  var_7 = getEntArray("stormraven_lightning_rod", "script_noteworthy");

  foreach(var_9 in var_7)
  thread play_earthquake(0.2, var_4 * 1.25, var_9.origin, 500);

  wait(var_4);

  foreach(var_9 in var_7) {
    thread play_earthquake(0.3, 0.5, var_9.origin, 500);
    var_9 thread rumble_nearby_players(0.5, 500);
  }

  maps\mp\mp_zombie_descent_lighting::lightningrodlights();
  var_13 = getEntArray("stormraven_lighting_rod_object", "script_noteworthy");

  for(var_14 = 0; var_14 < var_13.size; var_14++) {
    var_13[var_14].rodid = var_14;

    switch (var_14) {
      case 0:
        var_13[var_14].completeflag = "flag_stormraven_hammer_rod_one_complete";
        break;
      case 1:
        var_13[var_14].completeflag = "flag_stormraven_hammer_rod_two_complete";
        break;
      case 2:
        var_13[var_14].completeflag = "flag_stormraven_hammer_rod_three_complete";
        break;
      case 3:
        var_13[var_14].completeflag = "flag_stormraven_hammer_rod_four_complete";
        break;
    }

    var_13[var_14] thread stormraven_lightning_rod_puzzle_init();
  }

  thread stormraven_lightning_rod_tether_hammer(var_13);
  thread stormraven_lightning_rod_completion();
}

stormraven_lightning_rod_puzzle_init() {
  var_0 = getEntArray(self.target, "targetname");

  foreach(var_2 in var_0) {
    if(var_2._id_0165 == "stormraven_lightning_rod") {
      continue;
    }
    switch (var_2._id_0165) {
      case "stormraven_lightning_rod_top":
        self.topblock = var_2;
        break;
      case "stormraven_lightning_rod_middle_top":
        self.middletopblock = var_2;
        break;
      case "stormraven_lightning_rod_middle_bottom":
        self.middlebottomblock = var_2;
        break;
      case "stormraven_lightning_rod_bottom":
        self.bottomblock = var_2;
        break;
    }

    if(isDefined(var_2.setlookatent) && var_2.setlookatent == "shuffled") {
      var_2.rotatestate = _randomintrange(1, 4);

      if(var_2.rotatestate == 1)
        var_2 rotateyaw(90, 0.05);

      if(var_2.rotatestate == 2)
        var_2 rotateyaw(180, 0.05);

      if(var_2.rotatestate == 3)
        var_2 rotateyaw(270, 0.05);
    } else
      var_2.rotatestate = 0;

    var_2 thread stormraven_lightning_rod_block_rotation(self);
  }

  if(self.topblock.rotatestate == 0 && self.middletopblock.rotatestate == 0 && self.middlebottomblock.rotatestate == 0 && self.bottomblock.rotatestate == 0)
    common_scripts\utility::flag_set(self.completeflag);

  thread stormraven_lightning_rod_glow_state(var_0);
}

stormraven_lightning_rod_block_rotation(var_0) {
  level endon("stormraven_hammer_tethered");
  level.stormravenblockisrotating = 0;
  self setcandamage(1);
  level.stormravenblockrotatetime = 1;

  for(;;) {
    self waittill("damage", var_1, var_2);

    if(!isPlayer(var_2)) {
      continue;
    }
    if(level.stormravenblockisrotating) {
      continue;
    }
    level.stormravenblockisrotating = 1;

    for(var_3 = 0; var_3 < 2; var_3++) {
      stormraven_lightning_rod_rotate_block(self, 180);
      _id_0378::_id_8D74("aud_stormraven_lightning_rod_rotate");
    }

    switch (self._id_0165) {
      case "stormraven_lightning_rod_top":
        stormraven_lightning_rod_rotate_block(var_0.middletopblock, 90);
        break;
      case "stormraven_lightning_rod_middle_top":
        stormraven_lightning_rod_rotate_block(var_0.topblock, 90);
        stormraven_lightning_rod_rotate_block(var_0.middlebottomblock, 90);
        break;
      case "stormraven_lightning_rod_middle_bottom":
        stormraven_lightning_rod_rotate_block(var_0.middletopblock, 90);
        stormraven_lightning_rod_rotate_block(var_0.bottomblock, 90);
        break;
      case "stormraven_lightning_rod_bottom":
        stormraven_lightning_rod_rotate_block(var_0.middlebottomblock, 90);
        break;
    }

    wait(level.stormravenblockrotatetime);

    if(var_0.topblock.rotatestate == 0 && var_0.middletopblock.rotatestate == 0 && var_0.middlebottomblock.rotatestate == 0 && var_0.bottomblock.rotatestate == 0)
      common_scripts\utility::flag_set(var_0.completeflag);
    else
      common_scripts\utility::_id_3C7B(var_0.completeflag);

    level notify("stormraven_lightning_rod_rotate");
    level.stormravenblockisrotating = 0;
  }
}

stormraven_lightning_rod_rotate_block(var_0, var_1) {
  var_0.rotatestate++;

  if(var_0.rotatestate > 3)
    var_0.rotatestate = 0;

  var_0 rotateyaw(var_1, level.stormravenblockrotatetime);
}

stormraven_lightning_rod_completion() {
  level endon("stormraven_hammer_tethered");
  level.allrodsinposition = 0;

  for(;;) {
    common_scripts\utility::_id_3CA0("flag_stormraven_hammer_rod_one_complete", "flag_stormraven_hammer_rod_two_complete", "flag_stormraven_hammer_rod_three_complete", "flag_stormraven_hammer_rod_four_complete");
    level.allrodsinposition = 1;
    level waittill("stormraven_lightning_rod_rotate");
    level.allrodsinposition = 0;
  }
}

stormraven_lightning_rod_glow_state(var_0) {
  foreach(var_2 in var_0)
  var_2.originalmodel = var_2.model;

  for(;;) {
    common_scripts\utility::_id_3C9F(self.completeflag);
    self.middletopblock setModel(self.middletopblock.model + "a");
    waitframe();
    self.topblock setModel(self.topblock.model + "a");
    waitframe();
    self.middlebottomblock setModel(self.middlebottomblock.model + "a");
    waitframe();
    self.bottomblock setModel(self.bottomblock.model + "a");
    common_scripts\utility::flag_waitopen(self.completeflag);

    foreach(var_2 in var_0)
    var_2 setModel(var_2.originalmodel);
  }
}

stormraven_lightning_rod_tether_hammer(var_0) {
  for(;;) {
    level waittill("stormraven_hammer_in_tether_position");

    if(!common_scripts\utility::_id_562E(level.stormhammerhasmoved)) {
      continue;
    }
    foreach(var_2 in var_0) {
      if(common_scripts\utility::_id_3C77(var_2.completeflag)) {
        var_3 = spawn("script_model", var_2.origin);
        var_3 setModel("tag_origin");
        var_3.angles = var_2.angles;
        var_4 = _func_382("zmb_desc_hammer_tether_beam", var_3, "tag_origin", level.stormhammer._id_3F76, "tag_origin");
        level.stormhammer._id_3F76 _id_0378::_id_8D74("aud_stormraven_warhammer_tether");
        var_4 common_scripts\utility::_id_2CBE(3, ::delete);
        var_3 common_scripts\utility::_id_2CBE(3, ::delete);
      }
    }

    if(level.allrodsinposition) {
      common_scripts\utility::flag_set("flag_stormraven_hammer_tethered");
      level notify("stormraven_hammer_tethered");
      level.stormhammer delete();
      level.stormhammer._id_3F76 common_scripts\utility::_id_2CBE(3, ::delete);
    }
  }
}

stormraven_hammer_pickup() {
  maps\mp\zombies\weapons\_zombie_dlc4_melee::spawn_raven_weapon("hammer", common_scripts\utility::_id_46B5("hammer_tether_location", "targetname").origin);
  var_0 = common_scripts\utility::_id_46B5("hammer_tether_location", "targetname").origin;
  _id_0378::_id_8D74("aud_stormraven_warhammer_pickup", var_0);
  common_scripts\utility::flag_set("flag_stormraven_hammer_picked_up");
}

warp_activate_lightning_rods() {
  stormraven_hammer_summon();
  common_scripts\utility::flag_set("flag_stormraven_hammer_sneaking_complete");
  wait 1;
  common_scripts\utility::flag_set("flag_stormraven_uber_charged");
  level notify("stormraven_hammer_teleport_disabled");
}

warp_complete_lightning_rods() {
  stormraven_hammer_summon();
  common_scripts\utility::flag_set("flag_stormraven_hammer_sneaking_complete");
  common_scripts\utility::flag_set("flag_stormraven_hammer_rod_one_complete");
  common_scripts\utility::flag_set("flag_stormraven_hammer_rod_two_complete");
  common_scripts\utility::flag_set("flag_stormraven_hammer_rod_three_complete");
  common_scripts\utility::flag_set("flag_stormraven_hammer_rod_four_complete");
  wait 1;
  common_scripts\utility::flag_set("flag_stormraven_uber_charged");
  level notify("stormraven_hammer_teleport_disabled");
}

warp_tether_stormhammer() {
  stormraven_hammer_summon();
  common_scripts\utility::flag_set("flag_stormraven_hammer_sneaking_complete");
  common_scripts\utility::flag_set("flag_stormraven_hammer_tethered");
  wait 1;
  level.stormhammer delete();
}

warp_stormhammer_acquired() {
  stormraven_hammer_summon();
  common_scripts\utility::flag_set("flag_stormraven_hammer_sneaking_complete");
  common_scripts\utility::flag_set("flag_stormraven_hammer_tethered");
  common_scripts\utility::flag_set("flag_stormraven_hammer_picked_up");
  level.players[0] maps\mp\zombies\weapons\_zombie_dlc4_melee::give_hammer_weapon();
  wait 1;
  level.stormhammer delete();
}

_____call_lightning_____() {}

stormraven_call_lightning_main() {
  thread stormraven_call_lightning_init();
  common_scripts\utility::_id_3C9F("flag_stormraven_special_rune_charged");
  level.specialrune thread stormraven_special_lighting_rune_discharge();
  common_scripts\utility::_id_3C9F("flag_stormraven_charge_puzzle_activated");
  thread stormraven_call_lightning_cleanup();
  _iprintlnbold("CALL LIGHTNING - Step Complete!");
  _id_0557::_id_782D("quest_stormraven", "step_stormraven_call_lightning");
}

stormraven_call_lightning_init() {
  var_0 = getEntArray("stormraven_lightning_rune", "targetname");

  foreach(var_2 in var_0) {
    var_2 setcandamage(1);
    var_2.ischarged = 0;
    var_2.damagetrigger = _getent(var_2.target, "targetname");
    var_2 thread stormraven_lightning_rune_charge_state();
    var_2 thread stormraven_lightning_rune_damage();
  }

  level.specialrune = _getent("stormraven_special_lightning_rune", "targetname");
  var_4 = _getent("stormraven_special_lightning_rune_discharge_zone", "targetname");
  level.specialrune.dischargezone = var_4;
  level.specialrune.ischarged = 0;
  level.specialrune thread stormraven_special_lightning_rune_soulbucket_activate();
  level.specialrune thread stormraven_lightning_rune_charge_state();
  var_5 = _getent("stormraven_charge_puzzle_rune", "targetname");
  var_5._id_9D65 = _getent("stormraven_charge_puzzle_activate_trigger", "targetname");
  var_5 thread stormraven_activate_charge_puzzle();
  _id_0547::_id_7BA9(::stormraven_hammer_kill_check);
}

stormraven_call_lightning_cleanup() {
  _id_0547::_id_2D8C(::stormraven_hammer_kill_check);
}

stormraven_lightning_rune_charge_state() {
  level endon("stormraven_charge_puzzle_activated");
  self.chargedfx = undefined;

  if(isDefined(self._id_0165) && self._id_0165 == "stormraven_lightning_rune_initial") {
    stormraven_make_rune_glow();
    self.ischarged = 1;
    self.chargedfx = _spawnfx(common_scripts\utility::_id_44F5("zmb_desc_storm_rune_charge"), self.origin, anglesToForward(self.angles));
    _id_0378::_id_8D74("aud_stormraven_warhammer_run_charged");
    _triggerfx(self.chargedfx);
  }

  for(;;) {
    level waittill("lightning_rune_charge_transfer");

    if(!isDefined(self.chargedfx)) {
      if(self.ischarged) {
        stormraven_make_rune_glow();
        self.chargedfx = _spawnfx(common_scripts\utility::_id_44F5("zmb_desc_storm_rune_charge"), self.origin, anglesToForward(self.angles));
        _id_0378::_id_8D74("aud_stormraven_warhammer_run_charged");
        _triggerfx(self.chargedfx);
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
    self.damagetrigger waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(var_9 != "zom_dlc4_hammer_zm") {
      continue;
    }
    if(!isDefined(var_1.stormhammerischarged))
      var_1.stormhammerischarged = 0;

    var_1 _id_0378::_id_8D74("aud_stormraven_warhammer_rune_strike");
    stormraven_lightning_rune_transfer_charge(var_1);
    var_1 thread stormraven_hammer_switch_weapons();
  }
}

stormraven_lightning_rune_transfer_charge(var_0) {
  if(var_0.stormhammerischarged) {
    level notify("lightning_rune_charge_transfer");
    self.ischarged = 1;
    var_0.stormhammerischarged = 0;
    var_0 stormraven_hammer_charge_off();
  } else if(!var_0.stormhammerischarged && self.ischarged) {
    level notify("lightning_rune_charge_transfer");
    self.ischarged = 0;
    var_0.stormhammerischarged = 1;
    var_0 stormraven_hammer_charge_on();
    var_0 thread stormraven_hammer_charge_timer(self);
  }
}

stormraven_hammer_charge_timer(var_0) {
  level endon("lightning_rune_charge_transfer");
  level endon("stormraven_charge_puzzle_activated");
  var_1 = self;
  var_1 endon("disconnect");
  var_2 = 9;
  wait(var_2);
  var_1 notify("aud_stop_charged_warhammer");
  var_1.stormhammerischarged = 0;
  var_0.ischarged = 1;
  var_1 stormraven_hammer_charge_off();
  level notify("lightning_rune_charge_transfer");
}

stormraven_hammer_switch_weapons() {
  level endon("stormraven_charge_puzzle_activated");
  self endon("disconnect");
  self notify("stormraven_hammer_switch_weapons");
  self endon("stormraven_hammer_switch_weapons");

  for(;;) {
    common_scripts\utility::_id_A70A("weapon_switch_started", "enter_last_stand");

    if(isDefined(self.stormhammerchargedfx))
      stormraven_hammer_charge_off();

    if(self.stormhammerischarged) {
      self waittill("weapon_change");

      if(self.stormhammerischarged && self getcurrentweapon() == "zom_dlc4_hammer_zm")
        stormraven_hammer_charge_on();
    }

    if(_id_0547::_id_577E(self))
      stormraven_hammer_charge_off();
  }
}

stormraven_hammer_charge_on() {
  level notify("hammer_charge_on");
  var_0 = self;
  var_0 _id_0378::_id_8D74("aud_stormraven_warhammer_timed_charge");

  if(!isDefined(var_0.stormhammerchargedfx)) {
    var_0.stormhammerchargedfx = _spawnlinkedfxforclient(common_scripts\utility::_id_44F5("zmb_storm_hammer_charge_vm"), var_0, "TAG_FX", var_0, 1);
    var_0 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_0.stormhammerchargedfx);
  }

  _triggerfx(var_0.stormhammerchargedfx);
}

stormraven_hammer_charge_off() {
  level notify("hammer_charge_off");
  self notify("aud_stop_charged_warhammer");

  if(isDefined(self.stormhammerchargedfx))
    self.stormhammerchargedfx delete();
}

stormraven_special_lightning_rune_soulbucket_activate() {
  for(;;) {
    level waittill("hammer_charge_on");
    stormraven_special_lighting_rune_soulbucket();

    if(common_scripts\utility::_id_562E(self.ischarged)) {
      break;
    }
  }
}

stormraven_special_lighting_rune_soulbucket() {
  self endon("not_charged_in_time");
  self.disable_end_sound = 1;
  childthread maps\mp\mp_zombies_soul_collection::_id_170B(1, 300, 300, "stormraven_special_rune_charge", undefined, "tag_origin", undefined, undefined, "zom_dlc4_hammer_zm");
  var_0 = level common_scripts\utility::waittill_any_return("stormraven_special_rune_charge", "hammer_charge_off");

  if(var_0 == "hammer_charge_off") {
    self notify("not_charged_in_time");
    return;
  } else if(var_0 == "stormraven_special_rune_charge") {
    foreach(var_2 in level.players)
    var_2 thread stormraven_hammer_charge_off();

    self.ischarged = 1;
    level notify("lightning_rune_charge_transfer");
    wait 3;
    common_scripts\utility::flag_set("flag_stormraven_special_rune_charged");
  }
}

stormraven_special_lighting_rune_discharge() {
  for(;;) {
    wait 1;

    if(!self.ischarged) {
      continue;
    }
    var_0 = _id_0547::_id_408F();
    var_1 = [];
    var_2 = 0;
    var_3 = undefined;

    foreach(var_5 in var_0) {
      if(!var_5 istouching(self.dischargezone)) {
        continue;
      }
      if(!_bullettracepassed(self.origin, var_5.origin + (0, 0, 64), 0)) {
        continue;
      }
      var_1 = common_scripts\utility::_id_0F6F(var_1, var_5);
    }

    if(var_1.size < 1) {
      continue;
    }
    foreach(var_5 in var_1) {
      if(var_5._id_0A4B == "zombie_heavy" || var_5._id_0A4B == "zombie_dlc4") {
        var_3 = var_5;
        var_5.bigboy = 1;
      }
    }

    if(!isDefined(var_3)) {
      var_3 = common_scripts\utility::random(var_1);
      var_3.bigboy = 0;
    }

    var_9 = spawn("script_model", self.origin);
    var_9 setModel("tag_origin");
    var_10 = _func_382("zmb_desc_hammer_tether_beam", var_9, "tag_origin", var_3, "j_neck");
    _id_0378::_id_8D74("zombie_soul_suck", var_9.origin, var_3.origin);
    var_10 common_scripts\utility::_id_2CBE(2, ::delete);
    var_9 common_scripts\utility::_id_2CBE(2, ::delete);
    self.ischarged = 0;
    level notify("lightning_rune_charge_transfer");
    var_3 stormraven_charged_zombie_handler(self);
    wait 5;

    if(common_scripts\utility::_id_3C77("flag_stormraven_charge_puzzle_activated")) {
      break;
    }
  }
}

stormraven_charged_zombie_handler(var_0) {
  level endon("stormraven_charge_puzzle_activated");
  self.ischarged = 1;
  self.chargedfx = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_desc_storm_hmr_zmb_transfer"), self, "j_spine4");
  _triggerfx(self.chargedfx);
  thread maps\mp\agents\_agent_utility::deleteentonagentdeath(self.chargedfx);

  if(!common_scripts\utility::_id_562E(self.bigboy)) {
    maps\mp\mp_zombies_soul_collection::_id_865C("scripted_soul_eat", 0);
    wait 0.5;
    var_0.ischarged = 1;

    if(isalive(self)) {
      var_1 = spawn("script_model", self.origin);
      var_1 setModel("tag_origin");
      var_1 common_scripts\utility::_id_2CBE(2, ::delete);
      var_2 = _func_382("zmb_desc_hammer_tether_beam", self, "j_neck", var_0, "tag_origin");
      var_2 common_scripts\utility::_id_2CBE(2, ::delete);
      self dodamage(self.maxhealth * 2, self.origin);
    }

    level notify("lightning_rune_charge_transfer");
  } else
    self waittill("death");
}

stormraven_hammer_kill_check(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!common_scripts\utility::_id_562E(self.ischarged)) {
    return;
  }
  if(!common_scripts\utility::_id_562E(self.bigboy)) {
    return;
  }
  if(common_scripts\utility::_id_562E(self.detonating)) {
    var_4 = self.my_killer_weapon;
    var_1 = self.my_killer;
    var_3 = self.my_killer_smod;
  }

  if(isDefined(var_4) && var_4 == "zom_dlc4_hammer_zm" && isDefined(var_3) && var_3 == "MOD_MELEE") {
    var_1.stormhammerischarged = 1;
    var_1 stormraven_hammer_charge_on();
    var_1 stormraven_hammer_charge_timer(level.specialrune);
  } else {
    level.specialrune.ischarged = 1;
    level notify("lightning_rune_charge_transfer");
  }
}

stormraven_activate_charge_puzzle() {
  for(;;) {
    self._id_9D65 waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(var_9 != "zom_dlc4_hammer_zm") {
      continue;
    }
    if(!var_1.stormhammerischarged) {
      continue;
    }
    var_1 stormraven_hammer_charge_off();
    stormraven_make_rune_glow();
    level notify("lightning_rune_charge_transfer");
    level notify("stormraven_charge_puzzle_activated");
    common_scripts\utility::flag_set("flag_stormraven_charge_puzzle_activated");
  }
}

debug_stormraven_hammer_charge_timer_countdown(var_0) {
  level endon("lightning_rune_charge_transfer");
  var_1 = var_0;

  while(var_1 > 0) {
    _iprintlnbold(var_1);
    var_1--;
    wait 1;
  }
}

warp_special_rune_charged() {
  stormraven_hammer_summon();
  level.specialrune = _getent("stormraven_special_lightning_rune", "targetname");
  common_scripts\utility::flag_set("flag_stormraven_hammer_sneaking_complete");
  common_scripts\utility::flag_set("flag_stormraven_hammer_tethered");
  common_scripts\utility::flag_set("flag_stormraven_hammer_picked_up");
  common_scripts\utility::flag_set("flag_stormraven_special_rune_charged");
  level.players[0] maps\mp\zombies\weapons\_zombie_dlc4_melee::give_hammer_weapon();
  wait 1;
  level notify("stormraven_hammer_tethered");
  level.stormhammer delete();
  level.specialrune.ischarged = 1;
}

_____charge_puzzle_____() {}

stormraven_charge_puzzle_main() {
  thread stormraven_charge_puzzle_completion_runes();
  var_0 = _randomintrange(0, 2);

  switch (var_0) {
    case 0:
      thread stormraven_charge_puzzle_setup_puzzle([2, 6], [0, 1, 7, 13], [], "flag_stormraven_charge_puzzle_stage_one_complete");
      break;
    case 1:
      thread stormraven_charge_puzzle_setup_puzzle([7, 13], [1, 6, 8, 12], [], "flag_stormraven_charge_puzzle_stage_one_complete");
      break;
    default:
      thread stormraven_charge_puzzle_setup_puzzle([2, 6], [0, 1, 7, 13], [], "flag_stormraven_charge_puzzle_stage_one_complete");
  }

  common_scripts\utility::_id_3C9F("flag_stormraven_charge_puzzle_stage_one_complete");
  thread stormraven_charge_puzzle_setup_puzzle([2, 4, 6], [3, 7, 8, 9, 12, 13], [15], "flag_stormraven_charge_puzzle_stage_two_complete");
  common_scripts\utility::_id_3C9F("flag_stormraven_charge_puzzle_stage_two_complete");
  thread stormraven_charge_puzzle_setup_puzzle([0, 5, 9, 14], [6, 7, 8, 10, 11, 13, 16, 17], [2], "flag_stormraven_charge_puzzle_stage_three_complete");
  common_scripts\utility::_id_3C9F("flag_stormraven_charge_puzzle_stage_three_complete");
  _id_0557::_id_782D("quest_stormraven", "step_stormraven_charge_puzzle");
}

stormraven_charge_puzzle_blocks_init() {
  var_0 = getEntArray("stormraven_charge_puzzle_block", "targetname");

  foreach(var_2 in var_0) {
    var_2.unchargedpos = (0, 345, 0);
    var_2.chargedpos = (0, 255, 0);
    var_2.hazardpos = (0, 165, 0);
    var_2.blankpos = (0, 75, 0);
    var_2.angles = var_2.blankpos;
    var_2.puzzlestate = "blank";
    var_2.blockid = int(var_2.setlookatent);
    var_2 setcandamage(1);
    var_2 thread stormraven_charge_puzzle_blocks_adjacent_init(var_0);
  }

  level notify("stormraven_charge_puzzle_init_complete");
}

stormraven_charge_puzzle_blocks_adjacent_init(var_0) {
  level waittill("stormraven_charge_puzzle_init_complete");

  foreach(var_2 in var_0) {
    if(var_2.blockid == self.blockid + 1) {
      self.rightblock = var_2;
      continue;
    }

    if(var_2.blockid == self.blockid - 1) {
      self.leftblock = var_2;
      continue;
    }

    if(var_2.blockid == self.blockid + 6) {
      self.upblock = var_2;
      continue;
    }

    if(var_2.blockid == self.blockid - 6)
      self.downblock = var_2;
  }

  if(self.blockid == 6 || self.blockid == 12)
    self.leftblock = undefined;

  if(self.blockid == 5 || self.blockid == 11)
    self.rightblock = undefined;
}

stormraven_charge_puzzle_block_damage() {
  level endon("stormraven_charge_puzzle_complete");
  level endon("stormraven_charge_puzzle_hazard_triggered");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(!self._id_565F) {
      continue;
    }
    if(level.chargepuzzlerotating) {
      continue;
    }
    _id_0378::_id_8D74("aud_stormraven_charge_puzzle_rotate");
    level.chargepuzzlerotating = 1;
    level.chargepuzzlehazard = 0;
    var_10 = 1;
    thread stormraven_charge_puzzle_block_rotate(var_10);

    if(isDefined(self.rightblock) && self._id_565F)
      self.rightblock thread stormraven_charge_puzzle_block_rotate(var_10);

    if(isDefined(self.leftblock) && self._id_565F)
      self.leftblock thread stormraven_charge_puzzle_block_rotate(var_10);

    if(isDefined(self.upblock) && self._id_565F)
      self.upblock thread stormraven_charge_puzzle_block_rotate(var_10);

    if(isDefined(self.downblock) && self._id_565F)
      self.downblock thread stormraven_charge_puzzle_block_rotate(var_10);

    if(level.chargepuzzlehazard)
      level waittill("stormraven_charge_puzzle_hazard_triggered");
    else if(!level.chargepuzzlehazard) {
      level notify("charge_puzzle_rotate");
      wait(var_10 + 0.25);
    }

    level notify("charge_puzzle_state_change");
    level.chargepuzzlerotating = 0;
  }
}

stormraven_charge_puzzle_block_rotate(var_0) {
  level endon("stormraven_charge_puzzle_hazard_triggered");

  if(self.puzzlestate == "blank")
    return;
  else if(self.puzzlestate == "hazard") {
    level.chargepuzzlehazard = 1;
    var_1 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_desc_storm_p_block_reset"), self, "Tag_Origin");
    _triggerfx(var_1);
    self rotateyaw(1080, 3);
    wait 3;
    var_1 delete();
    waitframe();
    level notify("stormraven_charge_puzzle_hazard_triggered");
  } else if(self.puzzlestate == "charged") {
    level waittill("charge_puzzle_rotate");
    self rotateto(self.unchargedpos, var_0);
    wait(var_0);
    self.puzzlestate = "uncharged";
  } else if(self.puzzlestate == "uncharged") {
    level waittill("charge_puzzle_rotate");
    self rotateto(self.chargedpos, var_0);
    wait(var_0);
    self.puzzlestate = "charged";
  }
}

stormraven_charge_puzzle_setup_puzzle(var_0, var_1, var_2, var_3) {
  level.chargepuzzlerotating = 0;
  var_4 = getEntArray("stormraven_charge_puzzle_block", "targetname");
  var_5 = (-2659, 47, 1420);
  _id_0378::_id_8D74("aud_stormraven_charge_puzzle_spin", var_5);
  var_6 = [];
  var_7 = [];
  var_8 = [];
  var_9 = [];

  foreach(var_11 in var_4) {
    if(common_scripts\utility::_id_0F79(var_0, var_11.blockid))
      var_6 = common_scripts\utility::_id_0F6F(var_6, var_11);
    else if(common_scripts\utility::_id_0F79(var_1, var_11.blockid))
      var_7 = common_scripts\utility::_id_0F6F(var_7, var_11);
    else if(common_scripts\utility::_id_0F79(var_2, var_11.blockid))
      var_8 = common_scripts\utility::_id_0F6F(var_8, var_11);
    else
      var_9 = common_scripts\utility::_id_0F6F(var_9, var_11);

    var_11._id_565F = 0;
    var_11 thread stormraven_charge_puzzle_block_damage();
  }

  foreach(var_11 in var_6) {
    var_11 thread stormraven_charge_puzzle_spin("charged");
    var_14 = _randomfloatrange(3, 6);
    var_11 maps\mp\_utility::_id_2CED(var_14, ::stormraven_charge_puzzle_stop_spin);
  }

  foreach(var_11 in var_7) {
    var_11 thread stormraven_charge_puzzle_spin("uncharged");
    var_14 = _randomfloatrange(3, 6);
    var_11 maps\mp\_utility::_id_2CED(var_14, ::stormraven_charge_puzzle_stop_spin);
  }

  if(var_8.size > 0) {
    foreach(var_11 in var_8) {
      var_11 thread stormraven_charge_puzzle_spin("hazard");
      var_14 = _randomfloatrange(3, 6);
      var_11 maps\mp\_utility::_id_2CED(var_14, ::stormraven_charge_puzzle_stop_spin);
    }
  }

  if(var_9.size > 0) {
    foreach(var_11 in var_9) {
      var_11 thread stormraven_charge_puzzle_spin("blank");
      var_14 = _randomfloatrange(8, 11);
      var_11 maps\mp\_utility::_id_2CED(var_14, ::stormraven_charge_puzzle_stop_spin);
    }
  }

  var_22 = common_scripts\utility::_id_0F73(var_6, var_7);
  thread stormraven_charge_puzzle_completion(var_22);
  var_23 = level common_scripts\utility::waittill_any_return("stormraven_charge_puzzle_complete", "stormraven_charge_puzzle_hazard_triggered");

  if(var_23 == "stormraven_charge_puzzle_hazard_triggered")
    thread stormraven_charge_puzzle_setup_puzzle(var_0, var_1, var_2, var_3);
  else if(var_23 == "stormraven_charge_puzzle_complete")
    common_scripts\utility::flag_set(var_3);
}

stormraven_charge_puzzle_spin(var_0) {
  var_1 = _randomfloatrange(0.2, 0.3);
  var_2 = var_1;

  for(;;) {
    if(common_scripts\utility::_id_562E(self.stopspinning))
      var_2 = var_2 + var_1 * 2;

    if(var_2 >= var_1 * 8) {
      thread stormraven_charge_puzzle_spin_to_start_pos(var_0, var_2);
      break;
    }

    self rotateyaw(360, var_2);
    wait(var_2);
  }
}

stormraven_charge_puzzle_spin_to_start_pos(var_0, var_1) {
  for(;;) {
    self rotateyaw(5, var_1 / 72);
    wait(var_1 / 72);
    var_2 = self.angles[1] % 360;

    if(var_0 == "charged") {
      if(_abs(var_2 - self.chargedpos[1]) <= 5) {
        break;
      }
    }

    if(var_0 == "uncharged") {
      if(_abs(var_2 - self.unchargedpos[1]) <= 5) {
        break;
      }
    }

    if(var_0 == "hazard") {
      if(_abs(var_2 - self.hazardpos[1]) <= 5) {
        break;
      }
    }

    if(var_0 == "blank") {
      if(_abs(var_2 - self.blankpos[1]) <= 5) {
        break;
      }
    }
  }

  if(var_0 == "charged") {
    self rotateto(self.chargedpos, var_1, var_1 * 0.2, var_1 * 0.8);
    wait(var_1);
    self.puzzlestate = "charged";
    self._id_565F = 1;
  } else if(var_0 == "uncharged") {
    self rotateto(self.unchargedpos, var_1, var_1 * 0.2, var_1 * 0.8);
    wait(var_1);
    self.puzzlestate = "uncharged";
    self._id_565F = 1;
  } else if(var_0 == "hazard") {
    self rotateto(self.hazardpos, var_1, var_1 * 0.2, var_1 * 0.8);
    wait(var_1);
    self.puzzlestate = "hazard";
    self._id_565F = 1;
  } else if(var_0 == "blank" || !isDefined(var_0)) {
    self rotateto(self.blankpos, var_1, var_1 * 0.2, var_1 * 0.8);
    wait(var_1);
    self.puzzlestate = "blank";
    self._id_565F = 0;
  }

  self.stopspinning = 0;
}

stormraven_charge_puzzle_stop_spin() {
  self.stopspinning = 1;
}

stormraven_charge_puzzle_completion(var_0) {
  level endon("stormraven_charge_puzzle_complete");
  level endon("stormraven_charge_puzzle_hazard_triggered");

  for(;;) {
    level waittill("charge_puzzle_state_change");
    var_1 = 0;

    foreach(var_3 in var_0) {
      if(var_3.puzzlestate == "charged")
        var_1++;
    }

    if(var_1 >= var_0.size)
      level notify("stormraven_charge_puzzle_complete");
  }
}

stormraven_charge_puzzle_completion_runes() {
  var_0 = getEntArray("stormraven_charge_puzzle_progress_rune", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.setlookatent == "1")
      var_1[0] = var_3;

    if(var_3.setlookatent == "2")
      var_1[1] = var_3;

    if(var_3.setlookatent == "3")
      var_1[2] = var_3;
  }

  common_scripts\utility::_id_3C9F("flag_stormraven_charge_puzzle_stage_one_complete");
  var_1[0] stormraven_make_rune_glow();
  common_scripts\utility::_id_3C9F("flag_stormraven_charge_puzzle_stage_two_complete");
  var_1[1] stormraven_make_rune_glow();
  common_scripts\utility::_id_3C9F("flag_stormraven_charge_puzzle_stage_three_complete");
  var_1[2] stormraven_make_rune_glow();
  var_1[0].chargedfx = _spawnfx(common_scripts\utility::_id_44F5("zmb_desc_storm_p_rune_charge"), var_1[0].origin, anglesToForward(var_1[0].angles));
  _triggerfx(var_1[0].chargedfx);
  var_1[0] _id_0378::_id_8D74("aud_stormraven_warhammer_puz_run_ch");
  var_1[1].chargedfx = _spawnfx(common_scripts\utility::_id_44F5("zmb_desc_storm_p_rune_charge"), var_1[1].origin, anglesToForward(var_1[1].angles));
  _triggerfx(var_1[1].chargedfx);
  var_1[1] _id_0378::_id_8D74("aud_stormraven_warhammer_puz_run_ch");
  var_1[2].chargedfx = _spawnfx(common_scripts\utility::_id_44F5("zmb_desc_storm_p_rune_charge"), var_1[2].origin, anglesToForward(var_1[2].angles));
  _triggerfx(var_1[2].chargedfx);
  var_1[2] _id_0378::_id_8D74("aud_stormraven_warhammer_puz_run_ch");
}

debug_cycle_block_positions() {
  for(;;) {
    _iprintlnbold("Uncharged");
    self rotateto(self.unchargedpos, 0.5);
    wait 1.5;
    _iprintlnbold("Charged");
    self rotateto(self.chargedpos, 0.5);
    wait 1.5;
    _iprintlnbold("Blank");
    self rotateto(self.blankpos, 0.5);
    wait 1.5;
    _iprintlnbold("Hazard");
    self rotateto(self.hazardpos, 0.5);
    wait 1.5;
  }
}

debug_complete_charge_puzzle() {
  common_scripts\utility::flag_set("flag_stormraven_charge_puzzle_stage_one_complete");
  common_scripts\utility::flag_set("flag_stormraven_charge_puzzle_stage_two_complete");
  common_scripts\utility::flag_set("flag_stormraven_charge_puzzle_stage_three_complete");
}

debug_sneak_fail_spam() {
  if(!common_scripts\utility::_id_562E(level.debug_sneak_fail_force))
    level.debug_sneak_fail_force = 1;
  else
    level.debug_sneak_fail_force = 0;
}

warp_start_charge_puzzle() {
  stormraven_hammer_summon();
  common_scripts\utility::flag_set("flag_stormraven_hammer_sneaking_complete");
  common_scripts\utility::flag_set("flag_stormraven_hammer_tethered");
  common_scripts\utility::flag_set("flag_stormraven_hammer_picked_up");
  common_scripts\utility::flag_set("flag_stormraven_special_rune_charged");
  level.players[0] maps\mp\zombies\weapons\_zombie_dlc4_melee::give_hammer_weapon();
  wait 1;
  level notify("stormraven_hammer_tethered");
}

_____find_trial_____() {}

stormraven_find_trial_main() {
  thread stormraven_path_activate();
}

stormraven_find_trial_init() {
  var_0 = getEntArray("stormraven_platform", "targetname");

  foreach(var_2 in var_0) {
    var_2 ghost();
    var_2 notsolid();
  }
}

stormraven_path_activate() {
  var_0 = getEntArray("stormraven_platform", "targetname");

  foreach(var_2 in var_0)
  var_2 thread stormraven_path_make_visible();

  var_4 = _getent("stormraven_platform_trigger", "targetname");
  var_5 = _getent("stormraven_platform_trigger_final", "targetname");

  foreach(var_7 in level.players) {
    var_7 thread stormraven_player_on_path(var_4);
    var_7 thread stormraven_path_slow(var_4);
    var_7 thread stormraven_path_damage(var_4);
    var_7 thread stormraven_path_lightning_fx(var_5);
  }

  thread stormraven_path_delete_after_trial(var_0);
  thread stormraven_path_enter_trial();
}

stormraven_path_make_visible() {
  self solid();
  var_0 = undefined;

  while(!common_scripts\utility::_id_3C77(_id_0557::_id_7838("quest_stormraven", "step_stormraven_trial"))) {
    var_0 = _spawnfx(common_scripts\utility::_id_44F5("zmb_desc_stormraven_plat_1"), self.origin);
    _triggerfx(var_0);
    wait 1;
    var_0 delete();
    wait(_randomfloatrange(0.1, 0.2));
  }

  if(isDefined(var_0))
    var_0 delete();
}

stormraven_path_delete_after_trial(var_0) {
  common_scripts\utility::_id_3C9F(_id_0557::_id_7838("quest_stormraven", "step_stormraven_trial"));

  foreach(var_2 in var_0)
  var_2 delete();
}

stormraven_player_on_path(var_0) {
  level endon("stormraven_combat_trial_complete");

  for(;;) {
    if(var_0 _meth_858B(self.origin + (0, 0, 16)))
      self.touchingstormravenpath = 1;
    else
      self.touchingstormravenpath = 0;

    waitframe();
  }
}

stormraven_path_damage(var_0) {
  level endon("stormraven_combat_trial_complete");

  for(;;) {
    waitframe();

    if(!self.touchingstormravenpath) {
      continue;
    }
    if(!stormraven_player_has_stormhammer()) {
      self dodamage(self.maxhealth * 0.2, self.origin);
      wait 1;
    }
  }
}

stormraven_path_slow(var_0) {
  level endon("stormraven_combat_trial_complete");
  var_1 = common_scripts\utility::_id_46B5("stormraven_path_startpoint", "targetname");
  var_2 = distancesquared(var_1.origin, var_0.origin);

  for(;;) {
    waitframe();

    if(!self.touchingstormravenpath) {
      self setmovespeedscale(1);
      self allowjump(1);
      self allowsprint(1);
      continue;
    }

    var_3 = distancesquared(self.origin, var_0.origin);
    var_4 = 0.4;

    if(var_3 < var_2 * 0.75)
      var_4 = var_4 - 0.075;

    if(var_3 < var_2 * 0.5)
      var_4 = var_4 - 0.075;

    if(var_3 < var_2 * 0.25)
      var_4 = var_4 - 0.075;

    self allowsprint(0);
    self allowjump(0);
    self setmovespeedscale(var_4);
  }
}

stormraven_path_lightning_fx(var_0) {
  level endon("stormraven_combat_trial_complete");
  var_1 = common_scripts\utility::_id_46B5("stormraven_path_startpoint", "targetname");
  var_2 = distancesquared(var_1.origin, var_0.origin);
  var_3 = common_scripts\utility::_id_46B7("stormraven_platform_lightning_marker", "targetname");

  for(;;) {
    waitframe();

    if(!self.touchingstormravenpath) {
      continue;
    }
    if(!stormraven_player_has_stormhammer()) {
      continue;
    }
    level.playerwalkingstormpath = self;
    var_4 = 2.5;
    var_5 = distance(self.origin, var_0.origin);

    if(var_5 < var_2 * 0.75)
      var_4 = var_4 - 0.5;

    if(var_5 < var_2 * 0.5)
      var_4 = var_4 - 0.5;

    if(var_5 < var_2 * 0.25)
      var_4 = var_4 - 0.5;

    var_6 = _randomfloatrange(var_0.origin[0] - 100, var_0.origin[0] + 100);

    if(var_0.origin[1] >= self.origin[1])
      var_7 = _randomfloatrange(self.origin[1] + 50, var_0.origin[1] + 50);
    else
      var_7 = _randomfloatrange(var_0.origin[1] - 50, self.origin[1] - 50);

    var_8 = var_0.origin[2];
    var_9 = (var_6, var_7, var_8);
    playFX(common_scripts\utility::_id_44F5("zmb_desc_storm_plat_strike"), var_9);
    _id_0378::_id_8D74("aud_stormraven_warhammer_trial_strikes", var_9);
    wait(_randomfloatrange(0.25, var_4));
  }
}

stormraven_path_enter_trial() {
  level endon("stormraven_combat_trial_complete");
  var_0 = _getent("stormraven_platform_trigger_final", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!var_1 stormraven_player_has_stormhammer()) {
      continue;
    }
    var_2 = common_scripts\utility::_id_46B5("stormraven_platform_ascend_point", "targetname");
    var_1 setmovespeedscale(0);
    var_3 = spawn("script_model", var_1.origin);
    var_1 playerlinkto(var_3);
    var_3 moveto(var_2.origin, 3, 1, 1);
    var_4 = common_scripts\utility::_id_46B7("stormraven_platform_ascend_lightning", "targetname");
    var_5 = 0;

    while(var_5 < 20) {
      var_6 = common_scripts\utility::random(var_4);
      thread stormraven_lightning_strike(var_6.origin);
      var_5++;
      wait 0.25;
    }

    _id_0378::_id_8D74("aud_stormraven_warhammer_ascend_strike", var_1.origin);
    thread stormraven_lightning_strike(var_1.origin);
    var_1 thread run_weapon_ritual("zom_dlc4_hammer_zm");
    var_1 stormraven_path_trial_transition_fade();
    var_3 delete();
  }
}

stormraven_path_trial_transition_fade() {
  if(_id_0547::_id_577E(self) || !isalive(self)) {
    return;
  }
  self setdemigod(1);

  if(!isDefined(self.entertrialoverlayfade))
    self.entertrialoverlayfade = stormraven_trial_create_client_overlay("white", 0, self);

  var_0 = 3;
  var_1 = 1;
  self.entertrialoverlayfade.alpha = 0;
  self.entertrialoverlayfade fadeovertime(var_0);
  self.entertrialoverlayfade.alpha = 1;
  wait(var_0);
  self unlink();
  level notify("stormraven_trial_fade_peak");
  self setdemigod(0);
  self.entertrialoverlayfade.alpha = 1;
  self.entertrialoverlayfade fadeovertime(var_1);
  self.entertrialoverlayfade.alpha = 0;
}

warp_find_trial() {
  stormraven_hammer_summon();
  common_scripts\utility::flag_set("flag_stormraven_hammer_sneaking_complete");
  common_scripts\utility::flag_set("flag_stormraven_hammer_tethered");
  common_scripts\utility::flag_set("flag_stormraven_hammer_picked_up");
  common_scripts\utility::flag_set("flag_stormraven_special_rune_charged");
  common_scripts\utility::flag_set("flag_stormraven_charge_puzzle_stage_one_complete");
  common_scripts\utility::flag_set("flag_stormraven_charge_puzzle_stage_two_complete");
  common_scripts\utility::flag_set("flag_stormraven_charge_puzzle_stage_three_complete");
  level.players[0] maps\mp\zombies\weapons\_zombie_dlc4_melee::give_hammer_weapon();
  wait 1;
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
  wait 3;
  stormraven_trial_shield_zombies();
  _id_0557::_id_782D("quest_stormraven", "step_stormraven_trial");
  thread stormraven_show_splash();
  return 1;
}

stormraven_show_splash() {
  common_scripts\utility::_id_3C9F("flag_stormraven_trial_completed");
  wait 3;
  maps\mp\zquests\dlc4_trophies_mp_zombie_descent::complete_descent_trophy_event_8(self);
}

stormraven_trial_check_for_death() {
  self waittill("death");

  if(stormraven_player_has_stormhammer_emp()) {
    maps\mp\zombies\weapons\_zombie_dlc4_melee::take_raven_weapon("hammer_emp");
    maps\mp\zombies\weapons\_zombie_dlc4_melee::give_hammer_weapon();
    _id_0586::_id_078E("zom_dlc4_hammer_zm");
  }

  self.isinstormravenevent = 0;
}

stormraven_trial_teleport_to_trial() {
  var_0 = common_scripts\utility::_id_46B5("stormraven_trial_player_spawner", "script_noteworthy");
  self setOrigin(var_0.origin);
  self setplayerangles(var_0.angles);
  var_1 = spawn("script_model", var_0.origin);
  self playerlinkto(var_1);
  wait 2;
  var_2 = common_scripts\utility::_id_46B5("stormraven_trial_player_spawner_down", "script_noteworthy");
  var_1 moveto(var_2.origin, 3, 1, 2);
  var_1 thread common_scripts\utility::_id_2CBE(2, ::delete);
  self unlink();
  self setmovespeedscale(1);
  self allowjump(1);
  self allowsprint(1);
}

stormraven_trial_zombie_playtime() {
  var_0 = 0;
  var_1 = 9;
  var_2 = common_scripts\utility::_id_46B7("zone_spawners_storm", "targetname");

  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_4 = spawn_zombie_with_lightning(common_scripts\utility::random(var_2));
    var_4.playtimezombie = 1;
    var_5 = _randomfloatrange(1.0, 2.0);
    var_0++;
    wait(var_5);
  }

  while(var_0 < var_1)
    waitframe();

  wait 3;
  var_0 = undefined;
}

stormraven_trial_shield_zombies() {
  self endon("death");
  self endon("disconnect");
  var_0 = common_scripts\utility::_id_46B5("stormraven_trial_spawner_shield_single", "targetname");
  var_1 = 0;
  var_2 = 2;

  while(var_1 < 20) {
    var_3 = _randomfloatrange(var_0.origin[0] - 20, var_0.origin[0] + 20);
    var_4 = _randomfloatrange(var_0.origin[1] - 20, var_0.origin[1] + 20);
    var_5 = var_0.origin[2];
    var_6 = (var_3, var_4, var_5);
    thread stormraven_lightning_strike(var_6);
    var_1++;

    if(var_2 > 0.25)
      var_2 = var_2 - 0.25;

    wait(var_2);
  }

  thread stormraven_lightning_strike(var_0.origin);
  thread stormraven_lightning_strike(var_0.origin);
  thread stormraven_lightning_strike(var_0.origin);
  thread stormraven_trial_shield_zombies_check_for_completion();
  _id_0547::_id_7BA9(::stormraven_trial_shield_zombie_death_func);
  level.storm_trial_shieldzombies = [];
  level.storm_trial_shieldzombies[0] = spawn_zombie_with_lightning(var_0);
  var_7 = spawnStruct();
  var_7.origin = var_0.origin + (0, 64, 0);
  level.storm_trial_shieldzombies[1] = spawn_zombie_with_lightning(var_7);
  var_8 = spawnStruct();
  var_8.origin = var_0.origin - (0, 64, 0);
  level.storm_trial_shieldzombies[2] = spawn_zombie_with_lightning(var_8);

  if(!common_scripts\utility::_id_562E(self.has_shown_storm_trial_hint)) {
    self.has_shown_storm_trial_hint = 1;
    _id_0555::issprinting("dlc4_trial_hint_storm", self);
  }

  foreach(var_10 in level.storm_trial_shieldzombies) {
    var_10.isshieldzombie = 1;
    var_10 maps\mp\zombies\zombie_king::enable_force_shield();
  }

  level notify("shield_zombies_spawned");
  thread stormraven_trial_shield_zombie_hint_timer();
  level waittill("shield_zombies_complete");
  _id_0547::_id_2D8C(::stormraven_trial_shield_zombie_death_func);
}

stormraven_trial_shield_zombies_check_for_completion() {
  level waittill("shield_zombies_spawned");

  while(isDefined(level.storm_trial_shieldzombies) && level.storm_trial_shieldzombies.size > 0)
    waitframe();

  level notify("shield_zombies_complete");
}

stormraven_trial_shield_zombie_death_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(self.isshieldzombie) && self.isshieldzombie == 1) {
    level.storm_trial_shieldzombies = common_scripts\utility::_id_0F93(level.storm_trial_shieldzombies, self);
    level notify("stormraven_shield_zombie_killed");
    level notify("shield_zombie_killed");
  }
}

stormraven_trial_shield_zombie_hint_timer() {
  level endon("stormraven_shield_zombie_killed");
  wait 15;
  _id_0555::issprinting("dlc4_weap_hint_hammer_emp", self);
}

stormraven_trial_ascension() {
  var_0 = common_scripts\utility::_id_46B5("stormraven_trial_ascension_rune_spawner", "targetname");
  stormraven_lightning_strike(var_0.origin);
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("zmd_runes_objects_04c");
  var_2 = _getent("stormraven_trial_ascension_trigger", "targetname");
  var_3 = common_scripts\utility::_id_46B5("stormraven_trial_ascension_ground", "targetname");
  var_4 = common_scripts\utility::_id_46B5("stormraven_trial_ascension_sky", "targetname");
  thread stormraven_ascend_logic(var_2, var_3, var_4);
  level waittill("stormhammer_ascension_reached_peak");
  thread stormraven_trial_check_for_ascension_complete();
  var_5 = common_scripts\utility::_id_46B7("zone_spawners_storm", "targetname");

  while(!common_scripts\utility::_id_3C77("flag_stormraven_trial_ascension_complete")) {
    var_6 = spawn_zombie_with_lightning(common_scripts\utility::random(var_5));
    var_6.ascensionzombie = 1;
    wait 0.5;
  }

  for(;;) {
    var_7 = 1;

    foreach(var_6 in _id_0547::_id_408F()) {
      if(common_scripts\utility::_id_562E(var_6.ascensionzombie))
        var_7 = 0;
    }

    if(var_7) {
      break;
    }

    waitframe();
  }
}

stormraven_trial_check_for_ascension_complete() {
  level waittill("stormhammer_ascension_complete");
  common_scripts\utility::flag_set("flag_stormraven_trial_ascension_complete");
}

stormraven_trial_teleport_from_trial() {
  thread stormraven_path_trial_transition_fade();
  level waittill("stormraven_trial_fade_peak");
  var_0 = common_scripts\utility::_id_46B5("stormraven_trial_teleport_exit", "targetname");
  self setOrigin(var_0.origin);
  common_scripts\utility::flag_set("flag_stormraven_trial_completed");
}

deathraven_hitch_a_ride_back() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0 notify("new_hitchhike");
  var_0 endon("new_hitchhike");
  var_0.hitchingaride = 1;

  while(common_scripts\utility::_id_562E(var_0.hitchingaride)) {
    var_1 = var_0 get_random_activated_trigger();
    var_1 notify("trigger", var_0);
    waitframe();
  }
}

get_random_activated_trigger() {
  var_0 = self;

  if(isDefined(var_0.lastdepartdoor))
    return var_0.lastdepartdoor.use_trig;

  foreach(var_2 in common_scripts\utility::array_randomize(level.zmb_blood_tubes)) {
    if(!common_scripts\utility::_id_562E(var_2.transport_inactive))
      return var_2.use_trig;
  }
}

warp_start_trial() {
  level.players[0] thread run_weapon_ritual("zom_dlc4_hammer_zm");
  level.players[0] stormraven_path_trial_transition_fade();
}

_____util_____() {}

stormraven_make_rune_glow() {
  self.normalmodel = self.model;
  var_0 = self.model + "c";
  self setModel(var_0);
}

stormraven_stop_rune_glow() {
  if(isDefined(self.normalmodel)) {
    var_0 = self.normalmodel;
    self setModel(var_0);
  }
}

stormraven_player_has_stormhammer() {
  if(self getcurrentweapon() == "zom_dlc4_hammer_zm")
    return 1;
  else
    return 0;
}

stormraven_player_has_stormhammer_emp() {
  if(self getcurrentweapon() == "zom_dlc4_hammer_emp_zm")
    return 1;
  else
    return 0;
}

stormraven_lightning_strike(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  playFX(common_scripts\utility::_id_44F5("zmb_desc_storm_plat_strike"), var_0);
  _id_0378::_id_8D74("aud_stormraven_warhammer_trial_strikes", var_0);
}

spawn_zombie_with_lightning(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "zombie_generic";

  stormraven_lightning_strike(var_0.origin);
  wait 0.1;
  var_2 = _id_054D::_id_90BA(var_1, var_0, "storm_trial_zombie", 0, 1, 1);
  var_2 _id_0547::disableoffhandsecondaryweapons();
  var_2._id_6816 = 1;
  var_2._id_0C29 = 0;
  var_2._id_562B = 1;
  var_2._id_55AB = 1;
  return var_2;
}

stormraven_trial_create_client_overlay(var_0, var_1, var_2, var_3) {
  var_4 = 1;

  if(isDefined(var_3))
    var_4 = var_3;

  if(isDefined(var_2))
    var_5 = _newclienthudelem(var_2);
  else
    var_5 = newhudelem();

  var_5.x = 0;
  var_5.y = 0;
  var_5 setshader(var_0, 640, 480);
  var_5.alignx = "left";
  var_5.aligny = "top";
  var_5.sort = 1;
  var_5._id_00C6 = "fullscreen";
  var_5._id_01CA = "fullscreen";
  var_5.alpha = var_1;
  var_5.foreground = var_4;
  return var_5;
}

play_earthquake(var_0, var_1, var_2, var_3) {
  _earthquake(var_0, var_1, var_2, var_3);
}

rumble_nearby_players(var_0, var_1) {
  var_2 = 0;
  var_3 = 0.5;

  for(;;) {
    foreach(var_5 in level.players) {
      if(_distance2d(var_5.origin, self.origin) <= var_1)
        var_5 playrumbleonentity("damage_heavy");
    }

    wait(var_3);
    var_2 = var_2 + var_3;

    if(var_2 >= var_0) {
      break;
    }
  }
}

_____ascend_____() {}

stormraven_ascend_logic(var_0, var_1, var_2) {
  level.zombielethalweapon["throwinghammer_lhand_zm"] = 1;
  level.zombielethalweapon["throwinghammer_rhand_zm"] = 1;
  var_0 makeusable();
  var_3 = _id_0552::_id_7BE1(undefined, var_0);
  var_3._id_4028 = _id_0552::_id_44FF("dlc4_ascend");
  var_4 = undefined;

  for(;;) {
    var_0 waittill("trigger", var_4);

    if(!isPlayer(var_4)) {
      continue;
    }
    break;
  }

  var_4 thread stormraven_ascend_handle_weapons();
  var_4 thread stormraven_ascend_ascension(var_1, var_2);
  level waittill("stormhammer_ascension_reached_peak");
  var_4 thread stormraven_ascend_cycle_hands();
  var_4 thread stormraven_ascend_throw_hammer();
  level waittill("stormhammer_ascension_complete");
}

stormraven_ascend_handle_weapons() {
  self.oldlethal = self getlethalweapon();
  self.oldweapons = self getweaponslist("primary");
  _id_0586::_id_078F();
  _id_0586::_id_078C("zom_dlc4_hammer_emp_zm");
  _id_0586::_id_078E("zom_dlc4_hammer_emp_zm");
  level waittill("stormhammer_ascension_complete");

  if(isDefined(self.oldlethal))
    _id_0548::_id_A7D5(self, self.oldlethal);
  else
    _id_0548::_id_A7D5(self, "frag_grenade_zm");

  if(isDefined(self.oldweapons) && self.oldweapons.size > 0) {
    foreach(var_1 in self.oldweapons)
    _id_0586::_id_078C(var_1);

    _id_0586::_id_078E(self.oldweapons[0]);
  }
}

stormraven_ascend_ascension(var_0, var_1) {
  self setmovespeedscale(0);
  var_2 = spawn("script_model", self.origin);
  self playerlinkto(var_2);
  var_2 moveto(var_0.origin, 0.5, 0.25, 0.25);
  wait 0.5;
  var_2 moveto(var_1.origin, 1, 0.5, 0.5);
  wait 1;
  level notify("stormhammer_ascension_reached_peak");
  wait 20;
  var_2 moveto(var_0.origin, 1, 0.5, 0.5);
  wait 1;
  self setmovespeedscale(1);
  self unlink();
  level notify("stormhammer_ascension_complete");
}

stormraven_ascend_cycle_hands() {
  level endon("stormhammer_ascension_complete");

  for(;;) {
    _id_0548::_id_A7D5(self, "throwinghammer_lhand_zm");
    self waittill("grenade_fire");
    waitframe();
    _iprintlnbold("Swap to right hand");
    _id_0548::_id_A7D5(self, "throwinghammer_lhand_zm");
    self waittill("grenade_fire");
    waitframe();
    _iprintlnbold("Swap to left hand");
  }
}

stormraven_ascend_throw_hammer() {
  level endon("stormhammer_ascension_complete");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "throwinghammer_lhand_zm" || var_1 == "throwinghammer_rhand_zm") {
      var_0 stormraven_ascend_impact_check();
      var_0 stormraven_ascend_impact(var_0.origin);
    }
  }
}

stormraven_ascend_impact_check() {
  for(;;) {
    var_0 = _bullettracepassed(self.origin, self.origin - (0, 0, 25), 0, self);

    if(!common_scripts\utility::_id_562E(var_0)) {
      break;
    }

    waitframe();
  }

  _iprintlnbold("Hammer impacted ground");
}

stormraven_ascend_impact(var_0) {
  playFX(common_scripts\utility::_id_44F5("zmb_storm_hammer_lightning"), var_0);
  wait 0.25;
  playFX(common_scripts\utility::_id_44F5("zmb_storm_hammer_impact"), var_0);
  var_1 = maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_generic"), level._id_A980);
  var_2 = _id_0547::_id_408F();

  if(isDefined(var_2) && var_2.size > 0) {
    foreach(var_4 in var_2) {
      if(distancesquared(var_0, var_4.origin) < 10000)
        var_4 _id_0547::_id_5A85(var_4.origin, var_0 - var_4.origin);
    }

    waitframe();
    _physicsexplosionsphere(var_0, 150, 50, 3);
  }

  self delete();
}

__________________moonraven__________________() {}

init_moonraven_quest() {
  common_scripts\utility::flag_init("moonraven_key_collected_01");
  common_scripts\utility::flag_init("moonraven_key_collected_02");
  common_scripts\utility::flag_init("moonraven_key_placed_01");
  common_scripts\utility::flag_init("moonraven_key_placed_02");
  common_scripts\utility::flag_init("moonraven_reveal_chart");
  common_scripts\utility::flag_init("moonraven_all_keys_placed");
  common_scripts\utility::flag_init("moonraven_gear_1_collected");
  common_scripts\utility::flag_init("moonraven_gear_2_collected");
  common_scripts\utility::flag_init("moonraven_gear_3_collected");
  common_scripts\utility::flag_init("flag_gears_collected_1");
  common_scripts\utility::flag_init("flag_gears_collected_2");
  common_scripts\utility::flag_init("flag_gears_collected_3");
  common_scripts\utility::flag_init("moonraven_gear_1_placed");
  common_scripts\utility::flag_init("moonraven_gear_2_placed");
  common_scripts\utility::flag_init("moonraven_gear_3_placed");
  common_scripts\utility::flag_init("moonraven_gears_all_placed");
  common_scripts\utility::flag_init("moonraven_gears_stop_rotation");
  common_scripts\utility::flag_init("moonraven_orrery_collect_complete");
  common_scripts\utility::flag_init("moonraven_orrery_start");
  common_scripts\utility::flag_init("orrery_moon_A_stop");
  common_scripts\utility::flag_init("orrery_moon_B_stop");
  common_scripts\utility::flag_init("orrery_moon_C_stop");
  common_scripts\utility::flag_init("orrery_moon_D_stop");
  common_scripts\utility::flag_init("orrery_moon_A_valid");
  common_scripts\utility::flag_init("orrery_moon_B_valid");
  common_scripts\utility::flag_init("orrery_moon_C_valid");
  common_scripts\utility::flag_init("orrery_moon_D_valid");
  common_scripts\utility::flag_init("moonraven_orrery_solved");
  common_scripts\utility::flag_init("moonraven_orrery_complete");
  common_scripts\utility::flag_init("moonraven_alcove_collect_1_complete");
  common_scripts\utility::flag_init("moonraven_alcove_collect_2_complete");
  common_scripts\utility::flag_init("moonraven_alcove_collect_3_complete");
  common_scripts\utility::flag_init("moon_constellation_1_complete");
  common_scripts\utility::flag_init("moon_constellation_2_complete");
  common_scripts\utility::flag_init("moon_constellation_3_complete");
  common_scripts\utility::flag_init("moon_trial_unlocked");
  common_scripts\utility::flag_init("moon_trial_entered");
  common_scripts\utility::flag_init("moon_trial_complete");
  var_0 = _getent("moonraven_debug_book", "targetname");
  var_0 delete();
  var_1 = _getent("moonraven_debug_gear", "targetname");
  var_1 delete();
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
  var_0 = getEntArray("moonraven_bookshelf_final", "targetname");
  var_1 = _getent("moonraven_bookshelf_link_node", "targetname");
  var_2 = _getent("moonraven_bookshelf_moveStart", "targetname");

  foreach(var_4 in var_0)
  var_4 linktosynchronizedparent(var_1);

  var_1.origin = var_2.origin;
  var_6 = _getent("moonraven_book_key_placed_01", "targetname");
  var_7 = _getent("moonraven_book_key_placed_02", "targetname");
  var_6 hide();
  var_7 hide();
  var_8 = _getent("moonraven_book_key_find_01", "targetname");
  var_9 = _getent("moonraven_book_key_find_01_trigger", "targetname");
  var_10 = common_scripts\utility::_id_46B7("moonraven_book_location", "targetname");
  var_11 = common_scripts\utility::random(var_10);
  var_12 = _getent("moonraven_book_key_find_02", "targetname");
  var_12.origin = var_11.origin;
  var_12.angles = var_11.angles;
  var_13 = _getent(var_11.target, "targetname");
  var_14 = ["moonraven_key_collected_01", "moonraven_key_collected_02"];
  thread moonraven_bookshelf_find_book(var_8, var_9, var_14);
  thread moonraven_bookshelf_find_book(var_12, var_13, var_14);
  var_15 = _getent("moonraven_place_books_trigger_01", "targetname");
  var_16 = _getent("moonraven_place_books_trigger_02", "targetname");
  level.moonraven_books_placed = 0;
  level.moonraven_books_placed_goal = 2;
  thread moonraven_bookshelf_place_book(var_15, "moonraven_key_collected_01", "moonraven_key_collected_02");
  thread moonraven_bookshelf_place_book(var_16, "moonraven_key_collected_01", "moonraven_key_collected_02");

  while(level.moonraven_books_placed < level.moonraven_books_placed_goal)
    waitframe();

  var_17 = _getent("moonraven_bookshelf_moveLoc", "targetname");
  var_18 = 8;
  var_1 moveto(var_17.origin, var_18);
  var_19 = _getent("moonraven_bookshelf_path", "targetname");
  var_19 connectpaths();
  var_19 notsolid();
  enable_bookshelf_zombies(1);
  common_scripts\utility::flag_set("moonraven_reveal_chart");
  common_scripts\utility::flag_set("moonraven_all_keys_placed");
}

enable_bookshelf_zombies(var_0) {
  var_1 = common_scripts\utility::_id_46B7("zone_archives_spawners", "targetname");

  foreach(var_3 in var_1) {
    if(_id_0547::_id_5565(var_3.weaponlocktargettooclose, "zmb_archives_quest_disabled"))
      var_3.is_zombies_spawner_script_disabled = !var_0;
  }
}

moonraven_bookshelf_find_book(var_0, var_1, var_2) {
  var_1 waittill("trigger", var_3);
  var_0 _id_0378::_id_8D74("aud_moonraven_book_pickup");
  var_1 delete();
  var_0 delete();

  foreach(var_5 in var_2) {
    if(!common_scripts\utility::_id_3C77(var_5)) {
      common_scripts\utility::flag_set(var_5);
      return;
    }
  }
}

moonraven_bookshelf_place_book(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = _getent(var_0.target, "targetname");

  while(!var_3) {
    waitframe();
    var_0 waittill("trigger", var_5);

    if(common_scripts\utility::_id_3C77(var_1) && !var_3) {
      var_4 show();
      var_4 _id_0378::_id_8D74("aud_moonraven_book_place");
      level.moonraven_books_placed = level.moonraven_books_placed + 1;
      var_3 = 1;
      common_scripts\utility::_id_3C7B(var_1);
    }

    if(common_scripts\utility::_id_3C77(var_2) && !var_3) {
      var_4 show();
      var_4 _id_0378::_id_8D74("aud_moonraven_book_place");
      level.moonraven_books_placed = level.moonraven_books_placed + 1;
      var_3 = 1;
      common_scripts\utility::_id_3C7B(var_2);
    }
  }
}

quest_step_moonraven_chart() {
  common_scripts\utility::_id_3C9F("moonraven_reveal_chart");
  _activateclientexploder(227);
  _id_0557::_id_782D("quest_moonraven", "quest_moonraven_reveal_chart");
}

moonraven_debug_reveal_chart() {
  var_0 = _getent("moonraven_book_key_placed_01", "targetname");
  var_1 = _getent("moonraven_book_key_placed_02", "targetname");
  var_0 show();
  var_1 show();
  var_2 = _getent("moonraven_book_key_find_01", "targetname");
  var_3 = _getent("moonraven_book_key_find_02", "targetname");
  var_2 hide();
  var_3 hide();
  var_4 = getEntArray("moonraven_bookshelf_final", "targetname");
  var_5 = _getent("moonraven_bookshelf_link_node", "targetname");
  var_6 = _getent("moonraven_bookshelf_moveStart", "targetname");
  var_7 = _getent("moonraven_bookshelf_moveLoc", "targetname");

  foreach(var_9 in var_4)
  var_9 linktosynchronizedparent(var_5);

  var_11 = 1;
  var_5 moveto(var_7.origin, var_11);
  var_12 = _getent("moonraven_bookshelf_path", "targetname");
  var_12 connectpaths();
  var_12 notsolid();
  common_scripts\utility::flag_set("moonraven_reveal_chart");
  common_scripts\utility::flag_set("moonraven_all_keys_placed");
  _id_0557::_id_782D("quest_moonraven", "quest_moonraven_reveal_chart");
}

moonraven_init_gears() {
  var_0 = _getent("moonraven_gear_1_placed", "targetname");
  var_1 = _getent("moonraven_gear_2_placed", "targetname");
  var_2 = _getent("moonraven_gear_3_placed", "targetname");
  var_0 hide();
  var_1 hide();
  var_2 hide();
  var_3 = _getent("moonraven_gear_find_01", "targetname");
  var_4 = _getent("moonraven_gear_find_02", "targetname");
  var_5 = _getent("moonraven_gear_find_03", "targetname");
  var_6 = common_scripts\utility::_id_46B7("moonraven_gear_location", "targetname");

  foreach(var_8 in var_6) {
    if(distance(var_8.origin, (924, 2486, 2127)) < 24)
      var_6 = common_scripts\utility::_id_0F93(var_6, var_8);
  }

  var_10 = common_scripts\utility::random(var_6);
  var_6 = common_scripts\utility::_id_0F93(var_6, var_10);
  var_11 = common_scripts\utility::random(var_6);
  var_6 = common_scripts\utility::_id_0F93(var_6, var_11);
  var_12 = common_scripts\utility::random(var_6);
  var_3.origin = var_10.origin;
  var_3.angles = var_10.angles;
  var_3._id_9D65 = _getent(var_10.target, "targetname");
  var_4.origin = var_11.origin;
  var_4.angles = var_11.angles;
  var_4._id_9D65 = _getent(var_11.target, "targetname");
  var_5.origin = var_12.origin;
  var_5.angles = var_12.angles;
  var_5._id_9D65 = _getent(var_12.target, "targetname");
  level.moonraven_gears_collected = 0;
  thread moonraven_fix_machine_gear_watch(var_3, "moonraven_gear_1_collected");
  thread moonraven_fix_machine_gear_watch(var_4, "moonraven_gear_2_collected");
  thread moonraven_fix_machine_gear_watch(var_5, "moonraven_gear_3_collected");
  level.moonraven_gears_placed = 0;
  var_13 = _getent("moonraven_gear_placed_trigger", "targetname");

  while(level.moonraven_gears_placed < 3) {
    waitframe();
    var_13 waittill("trigger", var_14);

    if(common_scripts\utility::_id_3C77("moonraven_gear_1_collected")) {
      var_0 show();
      var_0 _id_0378::_id_8D74("aud_moonraven_gear_place");
      level.moonraven_gears_placed = level.moonraven_gears_placed + 1;
      common_scripts\utility::_id_3C7B("moonraven_gear_1_collected");
    }

    if(common_scripts\utility::_id_3C77("moonraven_gear_2_collected")) {
      var_1 show();
      var_1 _id_0378::_id_8D74("aud_moonraven_gear_place");
      level.moonraven_gears_placed = level.moonraven_gears_placed + 1;
      common_scripts\utility::_id_3C7B("moonraven_gear_2_collected");
    }

    if(common_scripts\utility::_id_3C77("moonraven_gear_3_collected")) {
      var_2 show();
      var_2 _id_0378::_id_8D74("aud_moonraven_gear_place");
      level.moonraven_gears_placed = level.moonraven_gears_placed + 1;
      common_scripts\utility::_id_3C7B("moonraven_gear_3_collected");
    }
  }

  common_scripts\utility::flag_set("moonraven_gears_all_placed");
  var_15 = 6;
  var_0 = _getent("moonraven_gear_1_placed", "targetname");
  var_1 = _getent("moonraven_gear_2_placed", "targetname");
  var_2 = _getent("moonraven_gear_3_placed", "targetname");
  var_16 = _getent("moonraven_gear_final_1", "targetname");
  var_17 = _getent("moonraven_gear_final_2", "targetname");
  var_18 = _getent("moonraven_gear_final_3", "targetname");
  var_19 = _getent("moonraven_gear_art_horz_1", "targetname");
  var_20 = _getent("moonraven_gear_art_horz_2", "targetname");
  var_21 = _getent("moonraven_gear_art_vert_1", "targetname");
  var_22 = _getent("moonraven_gear_art_vert_2", "targetname");
  var_23 = _getent("moonraven_gear_art_vert_3", "targetname");

  while(!common_scripts\utility::_id_3C77("moonraven_gears_stop_rotation")) {
    var_0 rotateby((0, 180, 0), var_15);
    var_1 rotateby((0, 180, 0), var_15);
    var_2 rotateby((0, 180, 0), var_15);
    var_16 rotateby((0, -180, 0), var_15);
    var_17 rotateby((0, 180, 0), var_15);
    var_18 rotateby((0, 0, 180), var_15);
    var_19 rotateby((180, 0, 0), var_15);
    var_20 rotateby((-180, 0, 0), var_15);
    var_21 rotateby((0, 180, 0), var_15);
    var_22 rotateby((0, -180, 0), var_15);
    var_23 rotateby((0, 180, 0), var_15);
    var_16 _id_0378::_id_8D74("aud_moonraven_orrery_lower_gears_move");
    wait(var_15);
  }
}

quest_step_moonraven_machine() {
  common_scripts\utility::_id_3C9F("moonraven_gears_all_placed");
  _activateclientexploder(222);
  _id_0557::_id_782D("quest_moonraven", "quest_moonraven_fix_machine");
}

moonraven_debug_fix_machine() {
  thread moonraven_debug_reveal_chart();
  var_0 = _getent("moonraven_gear_find_01", "targetname");
  var_1 = _getent("moonraven_gear_find_02", "targetname");
  var_2 = _getent("moonraven_gear_find_03", "targetname");
  var_0 hide();
  var_1 hide();
  var_2 hide();
  common_scripts\utility::flag_set("moonraven_gears_all_placed");
  common_scripts\utility::flag_set("moonraven_all_keys_placed");
  thread moonraven_debug_fix_machine_extra();
  _id_0557::_id_782D("quest_moonraven", "quest_moonraven_fix_machine");
}

moonraven_debug_fix_machine_extra() {
  var_0 = 6;
  var_1 = _getent("moonraven_gear_1_placed", "targetname");
  var_2 = _getent("moonraven_gear_2_placed", "targetname");
  var_3 = _getent("moonraven_gear_3_placed", "targetname");
  var_4 = _getent("moonraven_gear_final_1", "targetname");
  var_5 = _getent("moonraven_gear_final_2", "targetname");
  var_6 = _getent("moonraven_gear_final_3", "targetname");
  var_7 = _getent("moonraven_gear_art_horz_1", "targetname");
  var_8 = _getent("moonraven_gear_art_horz_2", "targetname");
  var_9 = _getent("moonraven_gear_art_vert_1", "targetname");
  var_10 = _getent("moonraven_gear_art_vert_2", "targetname");
  var_11 = _getent("moonraven_gear_art_vert_3", "targetname");
  var_1 show();
  var_2 show();
  var_3 show();

  while(!common_scripts\utility::_id_3C77("moonraven_gears_stop_rotation")) {
    var_1 rotateby((0, 180, 0), var_0);
    var_2 rotateby((0, 180, 0), var_0);
    var_3 rotateby((0, 180, 0), var_0);
    var_4 rotateby((0, -180, 0), var_0);
    var_5 rotateby((0, 180, 0), var_0);
    var_6 rotateby((0, 0, 180), var_0);
    var_7 rotateby((180, 0, 0), var_0);
    var_8 rotateby((-180, 0, 0), var_0);
    var_9 rotateby((0, 180, 0), var_0);
    var_10 rotateby((0, -180, 0), var_0);
    var_11 rotateby((0, 180, 0), var_0);
    var_4 _id_0378::_id_8D74("aud_moonraven_orrery_lower_gears_move");
    wait(var_0);
  }
}

moonraven_fix_machine_gear_watch(var_0, var_1) {
  var_0._id_9D65 waittill("trigger", var_2);
  var_0 _id_0378::_id_8D74("aud_moonraven_gear_pickup");
  var_0._id_9D65 delete();
  var_0 delete();
  common_scripts\utility::flag_set(var_1);
  level.moonraven_gears_collected++;
  common_scripts\utility::flag_set("flag_gears_collected_" + level.moonraven_gears_collected);
}

moonraven_init_orrery_power() {
  common_scripts\utility::_id_3CA0("moonraven_all_keys_placed", "moonraven_gears_all_placed");

  if(!common_scripts\utility::_id_3C77("moonraven_orrery_collect_complete")) {
    var_0 = common_scripts\utility::_id_46B5("moonraven_orrery_collect", "targetname");
    var_1 = 15;
    var_2 = 256;
    var_3 = 256;
    var_0.ignoresighttrace = 1;
    var_0 maps\mp\mp_zombies_soul_collection::beginazombiesoulcollectionobjectiveonstruct(var_1, var_2, var_3, "moonraven_orrery_collect", undefined, "tag_origin", undefined, "tag_origin", undefined, 1, undefined, undefined, 1, undefined, 0);
    common_scripts\utility::flag_set("moonraven_orrery_collect_complete");
  }
}

quest_step_moonraven_orrery_power() {
  common_scripts\utility::_id_3C9F("moonraven_orrery_collect_complete");
  _id_0557::_id_782D("quest_moonraven", "quest_moonraven_power_orrery");
}

moonraven_debug_orrery_power() {
  thread moonraven_debug_fix_machine();
  common_scripts\utility::flag_set("moonraven_orrery_collect_complete");
}

moonraven_init_moon_chart() {
  level.chart_index_a = 0;
  level.chart_index_b = 0;
  level.chart_index_c = 0;
  level.chart_index_d = 0;
  var_0 = 8;
  level.moon_chart_orbit_a = [];
  level.moon_chart_orbit_b = [];
  level.moon_chart_orbit_c = [];
  level.moon_chart_orbit_d = [];

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = "moon_chart_A_" + var_1;
    level.moon_chart_orbit_a[var_1] = common_scripts\utility::_id_46B5(var_2, "targetname");
    var_3 = "moon_chart_B_" + var_1;
    level.moon_chart_orbit_b[var_1] = common_scripts\utility::_id_46B5(var_3, "targetname");
    var_4 = "moon_chart_C_" + var_1;
    level.moon_chart_orbit_c[var_1] = common_scripts\utility::_id_46B5(var_4, "targetname");
    var_5 = "moon_chart_D_" + var_1;
    level.moon_chart_orbit_d[var_1] = common_scripts\utility::_id_46B5(var_5, "targetname");
  }

  var_6 = [];

  for(var_1 = 0; var_1 < var_0; var_1++)
    var_6[var_1] = var_1;

  level.chart_index_a = common_scripts\utility::random(var_6);
  var_6 = common_scripts\utility::_id_0F93(var_6, level.chart_index_a);
  level.chart_index_b = common_scripts\utility::random(var_6);
  var_6 = common_scripts\utility::_id_0F93(var_6, level.chart_index_b);
  level.chart_index_c = common_scripts\utility::random(var_6);
  var_6 = common_scripts\utility::_id_0F93(var_6, level.chart_index_c);
  level.chart_index_d = common_scripts\utility::random(var_6);
  var_7 = _getent("chart_moon_A", "targetname");
  var_8 = _getent("chart_moon_B", "targetname");
  var_9 = _getent("chart_moon_C", "targetname");
  var_10 = _getent("chart_moon_D", "targetname");
  level.chart_a_fx = var_7;
  level.chart_b_fx = var_8;
  level.chart_c_fx = var_9;
  level.chart_d_fx = var_10;
  var_7.origin = level.moon_chart_orbit_a[level.chart_index_a].origin;
  var_8.origin = level.moon_chart_orbit_b[level.chart_index_b].origin;
  var_9.origin = level.moon_chart_orbit_c[level.chart_index_c].origin;
  var_10.origin = level.moon_chart_orbit_d[level.chart_index_d].origin;
  wait 1;
  var_11 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_desc_leverglow_storm"), level.chart_a_fx, "tag_origin");
  _triggerfx(var_11);
  var_12 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_desc_leverglow_moon"), level.chart_b_fx, "tag_origin");
  _triggerfx(var_12);
  var_13 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_desc_leverglow_death"), level.chart_c_fx, "tag_origin");
  _triggerfx(var_13);
  var_14 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_desc_leverglow_blood"), level.chart_d_fx, "tag_origin");
  _triggerfx(var_14);
}

quest_step_moonraven_acquire_weapon() {
  common_scripts\utility::_id_3C9F("moonraven_orrery_complete");
  _id_0557::_id_782D("quest_moonraven", "quest_moonraven_acquire_scepter");
}

moonraven_debug_acquire_weapon() {
  thread moonraven_debug_orrery_power();
  common_scripts\utility::flag_set("moonraven_orrery_complete");
  common_scripts\utility::flag_set("moonraven_orrery_solved");
  common_scripts\utility::_id_3C77("orrery_moon_A_valid");
  common_scripts\utility::_id_3C77("orrery_moon_B_valid");
  common_scripts\utility::_id_3C77("orrery_moon_C_valid");
  common_scripts\utility::_id_3C77("orrery_moon_D_valid");
  level.orrery_moon_a_trigger = _getent("orrery_moon_A_trigger", "targetname");
  level.orrery_moon_b_trigger = _getent("orrery_moon_B_trigger", "targetname");
  level.orrery_moon_c_trigger = _getent("orrery_moon_C_trigger", "targetname");
  level.orrery_moon_d_trigger = _getent("orrery_moon_D_trigger", "targetname");
  level.orrery_moon_a_trigger common_scripts\utility::_id_9D9F();
  level.orrery_moon_b_trigger common_scripts\utility::_id_9D9F();
  level.orrery_moon_c_trigger common_scripts\utility::_id_9D9F();
  level.orrery_moon_d_trigger common_scripts\utility::_id_9D9F();
  thread maps\mp\zombies\weapons\_zombie_dlc4_melee::spawn_raven_weapon("spike", common_scripts\utility::_id_46B5("struct_temp_moonscepter", "targetname").origin);
}

moonraven_init_orrery() {
  level.lever_moon_a = _getent("moon_orrery_plinth_A", "targetname");
  level.lever_moon_b = _getent("moon_orrery_plinth_B", "targetname");
  level.lever_moon_c = _getent("moon_orrery_plinth_C", "targetname");
  level.lever_moon_d = _getent("moon_orrery_plinth_D", "targetname");
  level.lever_moon_a hide();
  level.lever_moon_b hide();
  level.lever_moon_c hide();
  level.lever_moon_d hide();
  common_scripts\utility::_id_3C9F("moonraven_orrery_collect_complete");
  level.orrery_moon_a = _getent("orrery_moon_A", "targetname");
  level.orrery_moon_a._id_6C50 = level.orrery_moon_a.angles;
  level.orrery_moon_b = _getent("orrery_moon_B", "targetname");
  level.orrery_moon_b._id_6C50 = level.orrery_moon_b.angles;
  level.orrery_moon_c = _getent("orrery_moon_C", "targetname");
  level.orrery_moon_c._id_6C50 = level.orrery_moon_c.angles;
  level.orrery_moon_d = _getent("orrery_moon_D", "targetname");
  level.orrery_moon_d._id_6C50 = level.orrery_moon_d.angles;
  level.orrery_moon_a._id_00D4 = 1;
  level.orrery_moon_b._id_00D4 = 7;
  level.orrery_moon_c._id_00D4 = 2;
  level.orrery_moon_d._id_00D4 = 0;
  level.orrery_yaw_offset = 150;
  level.orrery_moon_a.yaw_offset = level.orrery_yaw_offset + level.orrery_moon_a._id_00D4 * 45;
  level.orrery_moon_b.yaw_offset = level.orrery_yaw_offset + level.orrery_moon_b._id_00D4 * 45;
  level.orrery_moon_c.yaw_offset = level.orrery_yaw_offset + level.orrery_moon_c._id_00D4 * 45;
  level.orrery_moon_d.yaw_offset = level.orrery_yaw_offset + level.orrery_moon_d._id_00D4 * 45;
  level.orrery_moon_a.orbit_time = 4;
  level.orrery_moon_b.orbit_time = 3;
  level.orrery_moon_c.orbit_time = 2;
  level.orrery_moon_d.orbit_time = 1;
  level.orrery_moon_a_trigger = _getent("orrery_moon_A_trigger", "targetname");
  level.orrery_moon_b_trigger = _getent("orrery_moon_B_trigger", "targetname");
  level.orrery_moon_c_trigger = _getent("orrery_moon_C_trigger", "targetname");
  level.orrery_moon_d_trigger = _getent("orrery_moon_D_trigger", "targetname");
  level.orrery_max_index = 7;
  level.orrery_check_time = 90;
  level.orrery_moons_stopped = 0;
  level.lever_moon_a show();
  level.lever_moon_b show();
  level.lever_moon_c show();
  level.lever_moon_d show();
  level.lever_moon_a thread maps\mp\zombies\weapons\_zombie_dlc4_melee::wep_spin();
  level.lever_moon_a thread maps\mp\zombies\weapons\_zombie_dlc4_melee::wep_bounce();
  level.lever_moon_b thread maps\mp\zombies\weapons\_zombie_dlc4_melee::wep_spin();
  level.lever_moon_b thread maps\mp\zombies\weapons\_zombie_dlc4_melee::wep_bounce();
  level.lever_moon_c thread maps\mp\zombies\weapons\_zombie_dlc4_melee::wep_spin();
  level.lever_moon_c thread maps\mp\zombies\weapons\_zombie_dlc4_melee::wep_bounce();
  level.lever_moon_d thread maps\mp\zombies\weapons\_zombie_dlc4_melee::wep_spin();
  level.lever_moon_d thread maps\mp\zombies\weapons\_zombie_dlc4_melee::wep_bounce();
  thread moonraven_orrery_rotate_moon(level.orrery_moon_a, level.orrery_moon_a.angles[1] - level.orrery_moon_a.yaw_offset, level.chart_index_a, "orrery_moon_A_stop", "orrery_moon_A_valid", level.orrery_moon_a.orbit_time);
  thread moonraven_orrery_rotate_moon(level.orrery_moon_b, level.orrery_moon_b.angles[1] - level.orrery_moon_b.yaw_offset, level.chart_index_b, "orrery_moon_B_stop", "orrery_moon_B_valid", level.orrery_moon_b.orbit_time);
  thread moonraven_orrery_rotate_moon(level.orrery_moon_c, level.orrery_moon_c.angles[1] - level.orrery_moon_c.yaw_offset, level.chart_index_c, "orrery_moon_C_stop", "orrery_moon_C_valid", level.orrery_moon_c.orbit_time);
  thread moonraven_orrery_rotate_moon(level.orrery_moon_d, level.orrery_moon_d.angles[1] - level.orrery_moon_d.yaw_offset, level.chart_index_d, "orrery_moon_D_stop", "orrery_moon_D_valid", level.orrery_moon_d.orbit_time);
  thread moonraven_orrery_stop_moon(level.orrery_moon_a, level.chart_index_a, level.orrery_moon_a_trigger, "orrery_moon_A_stop", "orrery_moon_A_valid");
  thread moonraven_orrery_stop_moon(level.orrery_moon_b, level.chart_index_b, level.orrery_moon_b_trigger, "orrery_moon_B_stop", "orrery_moon_B_valid");
  thread moonraven_orrery_stop_moon(level.orrery_moon_c, level.chart_index_c, level.orrery_moon_c_trigger, "orrery_moon_C_stop", "orrery_moon_C_valid");
  thread moonraven_orrery_stop_moon(level.orrery_moon_d, level.chart_index_d, level.orrery_moon_d_trigger, "orrery_moon_D_stop", "orrery_moon_D_valid");
  thread moonraven_orrery_success_watch();
}

moonraven_orrery_rotate_moon(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_desc_planetglow_storm"), level.orrery_moon_a, "tag_origin");
  _triggerfx(var_6);
  var_7 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_desc_planetglow_moon"), level.orrery_moon_b, "tag_origin");
  _triggerfx(var_7);
  var_8 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_desc_planetglow_death"), level.orrery_moon_c, "tag_origin");
  _triggerfx(var_8);
  var_9 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_desc_planetglow_blood"), level.orrery_moon_d, "tag_origin");
  _triggerfx(var_9);
  var_10 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_desc_leverglow_storm"), level.lever_moon_a, "tag_origin");
  _triggerfx(var_10);
  var_11 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_desc_leverglow_moon"), level.lever_moon_b, "tag_origin");
  _triggerfx(var_11);
  var_12 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_desc_leverglow_death"), level.lever_moon_c, "tag_origin");
  _triggerfx(var_12);
  var_13 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_desc_leverglow_blood"), level.lever_moon_d, "tag_origin");
  _triggerfx(var_13);
  _id_0378::_id_8D74("aud_moonraven_orrery_move", var_0);

  while(!common_scripts\utility::_id_3C77(var_3)) {
    var_1 = var_1 + 45;

    if(var_1 > 359)
      var_1 = 0;

    var_0 rotateto(_combineangles(var_0._id_6C50, (0, var_1, 0)), var_5);
    wait(var_5);
    var_0._id_00D4 = var_0._id_00D4 + 1;

    if(var_0._id_00D4 > level.orrery_max_index)
      var_0._id_00D4 = 0;

    if(var_0._id_00D4 == var_2 && common_scripts\utility::_id_3C77(var_3)) {
      var_0 _id_0378::_id_8D74("aud_moonraven_orrery_lock");
      common_scripts\utility::flag_set(var_4);
      continue;
    }

    if(common_scripts\utility::_id_3C77(var_3))
      _id_0378::_id_8D74("aud_moonraven_orrery_stop", var_0);
  }

  var_6 delete();
  var_6 = undefined;
  var_7 delete();
  var_7 = undefined;
  var_8 delete();
  var_8 = undefined;
  var_9 delete();
  var_9 = undefined;
  var_10 delete();
  var_10 = undefined;
  var_11 delete();
  var_11 = undefined;
  var_12 delete();
  var_12 = undefined;
  var_13 delete();
  var_13 = undefined;
}

moonraven_orrery_stop_moon(var_0, var_1, var_2, var_3, var_4) {
  var_2 waittill("trigger", var_5);
  var_2 common_scripts\utility::_id_9D9F();
  common_scripts\utility::flag_set(var_3);
  moonraven_orrery_validate_moon(var_0, var_1, var_2, var_3, var_4);
}

moonraven_orrery_validate_moon(var_0, var_1, var_2, var_3, var_4) {
  wait 6;
  level.orrery_moons_stopped = level.orrery_moons_stopped + 1;

  while(level.orrery_moons_stopped < 4)
    waitframe();

  wait 3;
  level.orrery_moons_stopped = level.orrery_moons_stopped - 1;

  while(level.orrery_moons_stopped > 0)
    waitframe();

  if(!common_scripts\utility::_id_3C77("moonraven_orrery_solved")) {
    var_2 common_scripts\utility::_id_9DA3();
    common_scripts\utility::_id_3C7B(var_3);
    common_scripts\utility::_id_3C7B(var_4);
    var_5 = var_0.angles[1] - var_0.yaw_offset;
    thread moonraven_orrery_rotate_moon(var_0, var_5, var_1, var_3, var_4, var_0.orbit_time);
    thread moonraven_orrery_stop_moon(var_0, var_1, var_2, var_3, var_4);
  }
}

moonraven_orrery_success_watch() {
  while(!common_scripts\utility::_id_3C77("moonraven_orrery_solved")) {
    if(common_scripts\utility::_id_3C77("orrery_moon_A_valid") && common_scripts\utility::_id_3C77("orrery_moon_B_valid") && common_scripts\utility::_id_3C77("orrery_moon_C_valid") && common_scripts\utility::_id_3C77("orrery_moon_D_valid")) {
      common_scripts\utility::flag_set("moonraven_orrery_solved");
      thread maps\mp\zombies\weapons\_zombie_dlc4_melee::spawn_raven_weapon("spike", common_scripts\utility::_id_46B5("struct_temp_moonscepter", "targetname").origin);
    }

    waitframe();
  }

  common_scripts\utility::flag_set("moonraven_orrery_complete");
  var_0 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_desc_planetglow_storm_cmplt"), level.orrery_moon_a, "tag_origin");
  _triggerfx(var_0);
  var_1 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_desc_planetglow_moon_cmplt"), level.orrery_moon_b, "tag_origin");
  _triggerfx(var_1);
  var_2 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_desc_planetglow_death_cmplt"), level.orrery_moon_c, "tag_origin");
  _triggerfx(var_2);
  var_3 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_desc_planetglow_blood_cmplt"), level.orrery_moon_d, "tag_origin");
  _triggerfx(var_3);
  wait 5;
  var_0 delete();
  var_0 = undefined;
  var_1 delete();
  var_1 = undefined;
  var_2 delete();
  var_2 = undefined;
  var_3 delete();
  var_3 = undefined;
}

moonraven_init_constellations() {
  common_scripts\utility::flag_init("flag_start_test");
  common_scripts\utility::flag_init("flag_stars_complete");
  level.star_models = getEntArray("moonraven_star_model", "targetname");

  foreach(var_1 in level.star_models) {
    var_2 = _getent(var_1.target, "targetname");
    var_1 hide();
    var_2 hide();
    var_1.tagged = 0;
    var_1.solved = 0;
    var_2.tagged = 0;
    var_2.solved = 0;
  }

  var_4 = common_scripts\utility::_id_46B7("moonraven_star_location", "targetname");
  var_5 = getEntArray("moonraven_star_prefab", "targetname");
  var_6 = getEntArray("moonraven_star_rune", "targetname");
  var_7 = ["rune_1", "rune_2", "rune_3", "rune_4", "rune_5", "rune_6", "rune_7", "rune_8"];

  foreach(var_9 in var_6)
  var_9 hide();

  level.star_index_a = common_scripts\utility::random(var_7);
  var_7 = common_scripts\utility::_id_0F93(var_7, level.star_index_a);
  level.star_index_b = common_scripts\utility::random(var_7);
  var_7 = common_scripts\utility::_id_0F93(var_7, level.star_index_b);
  level.star_index_c = common_scripts\utility::random(var_7);
  var_11 = undefined;
  var_12 = undefined;
  var_13 = undefined;

  foreach(var_15 in var_5) {
    if(var_15.setlookatent == level.star_index_a) {
      var_11 = var_15;
      continue;
    }

    if(var_15.setlookatent == level.star_index_b) {
      var_12 = var_15;
      continue;
    }

    if(var_15.setlookatent == level.star_index_c)
      var_13 = var_15;
  }

  var_17 = getEntArray(level.star_index_a, "script_noteworthy");
  var_18 = getEntArray(level.star_index_b, "script_noteworthy");
  var_19 = getEntArray(level.star_index_c, "script_noteworthy");
  level.star_count_a = 0;
  level.star_count_b = 0;
  level.star_count_c = 0;

  foreach(var_21 in var_17) {
    if(var_21.classname != "script_origin") {
      var_21 linktosynchronizedparent(var_11);
      level.star_count_a = level.star_count_a + 1;
    }
  }

  foreach(var_21 in var_18) {
    if(var_21.classname != "script_origin") {
      var_21 linktosynchronizedparent(var_12);
      level.star_count_b = level.star_count_b + 1;
    }
  }

  foreach(var_21 in var_19) {
    if(var_21.classname != "script_origin") {
      var_21 linktosynchronizedparent(var_13);
      level.star_count_c = level.star_count_c + 1;
    }
  }

  level.star_count_a = level.star_count_a / 2;
  level.star_count_b = level.star_count_b / 2;
  level.star_count_c = level.star_count_c / 2;
  var_27 = common_scripts\utility::random(var_4);
  var_4 = common_scripts\utility::_id_0F93(var_4, var_27);
  var_28 = common_scripts\utility::random(var_4);
  var_4 = common_scripts\utility::_id_0F93(var_4, var_28);
  var_29 = common_scripts\utility::random(var_4);
  level.moon_rune_a = undefined;
  level.moon_rune_b = undefined;
  level.moon_rune_c = undefined;

  foreach(var_9 in var_6) {
    if(var_9.setlookatent == level.star_index_a) {
      level.moon_rune_a = var_9;
      continue;
    }

    if(var_9.setlookatent == level.star_index_b) {
      level.moon_rune_b = var_9;
      continue;
    }

    if(var_9.setlookatent == level.star_index_c)
      level.moon_rune_c = var_9;
  }

  var_32 = common_scripts\utility::_id_46B5("moonraven_alcove_rune_A", "targetname");
  var_33 = common_scripts\utility::_id_46B5("moonraven_alcove_rune_B", "targetname");
  var_34 = common_scripts\utility::_id_46B5("moonraven_alcove_rune_C", "targetname");
  level.moon_rune_a.origin = var_32.origin;
  level.moon_rune_a.angles = var_32.angles;
  level.moon_rune_b.origin = var_33.origin;
  level.moon_rune_b.angles = var_33.angles;
  level.moon_rune_c.origin = var_34.origin;
  level.moon_rune_c.angles = var_34.angles;
  level.star_scan_count = 0;
  level.star_scan_complete_a = 0;
  level.star_scan_complete_b = 0;
  level.star_scan_complete_c = 0;
  level.star_scan_current_rune = level.star_index_a;
  common_scripts\utility::_id_3C9F("moonraven_alcove_collect_1_complete");
  var_11.origin = var_27.origin;
  var_11.angles = var_27.angles;
  common_scripts\utility::_id_3C9F("moonraven_alcove_collect_2_complete");
  var_12.origin = var_28.origin;
  var_12.angles = var_28.angles;
  common_scripts\utility::_id_3C9F("moonraven_alcove_collect_3_complete");
  var_13.origin = var_29.origin;
  var_13.angles = var_29.angles;
}

moonraven_contellation_vision() {
  foreach(var_1 in level.star_models) {
    var_2 = _getent(var_1.target, "targetname");

    if(isDefined(var_1.solved) && var_1.solved) {
      level.star_models = common_scripts\utility::_id_0F93(level.star_models, var_1);
      var_1 show();
      var_2 show();
      continue;
    }

    var_1 hide();
    var_2 hide();
  }

  thread moonraven_contellation_vision_toggle();
  thread moonraven_contellation_vision_lost();
}

moonraven_contellation_vision_toggle() {
  level.showstars = 0;
  var_0 = self;
  var_0 endon("disconnect");

  while(!common_scripts\utility::_id_3C77("flag_stars_complete")) {
    if(common_scripts\utility::_id_562E(self.spike_vision_enabled) && !level.showstars) {
      level.showstars = 1;
      var_0 enable_star_view();
    } else if(!common_scripts\utility::_id_562E(self.spike_vision_enabled)) {
      disable_star_view();
      level.showstars = 0;
    }

    waitframe();

    if(!_id_0547::_id_5565(level.ravenweaponmanager["spike"]._id_0117, var_0)) {
      if(common_scripts\utility::_id_562E(level.showstars)) {
        disable_star_view();
        level.showstars = 0;
      }

      return;
    }
  }
}

enable_star_view() {
  var_0 = self;

  foreach(var_2 in level.star_models) {
    if(distancesquared(var_0.origin, var_2.origin) < 4000000) {
      var_2 showtoplayer(self);
      thread moonraven_contellation_vision_scan();
    }
  }
}

disable_star_view() {
  foreach(var_1 in level.star_models) {
    if(!var_1.solved)
      var_1 hide();
  }
}

moonraven_contellation_vision_scan() {
  while(level.showstars) {
    foreach(var_1 in level.star_models) {
      if(maps\mp\_utility::findplayerisfacing(self, var_1, 8) && !var_1.tagged && var_1.setlookatent == level.star_scan_current_rune) {
        var_2 = _getent(var_1.target, "targetname");
        var_2 showtoplayer(self);
        _id_0378::_id_8D74("aud_moonraven_constellation_find");
        var_1 hide();
        var_1.tagged = 1;
        level.star_scan_count = level.star_scan_count + 1;

        if(!level.star_scan_complete_a && level.star_scan_count >= level.star_count_a && !common_scripts\utility::_id_3C77("moon_constellation_1_complete")) {
          level.star_scan_complete_a = 1;
          level.star_scan_count = 0;
          level.star_scan_current_rune = level.star_index_b;
          common_scripts\utility::flag_set("moon_constellation_1_complete");
          _id_0378::_id_8D74("aud_moonraven_constellation_done");
        } else if(!level.star_scan_complete_b && level.star_scan_count >= level.star_count_b && common_scripts\utility::_id_3C77("moon_constellation_1_complete") && !common_scripts\utility::_id_3C77("moon_constellation_2_complete")) {
          level.star_scan_complete_b = 1;
          level.star_scan_count = 0;
          level.star_scan_current_rune = level.star_index_c;
          common_scripts\utility::flag_set("moon_constellation_2_complete");
          _id_0378::_id_8D74("aud_moonraven_constellation_done");
        } else if(!level.star_scan_complete_c && level.star_scan_count >= level.star_count_c && common_scripts\utility::_id_3C77("moon_constellation_2_complete") && !common_scripts\utility::_id_3C77("moon_constellation_3_complete")) {
          level.star_scan_complete_c = 1;
          level.star_scan_count = 0;
          level.star_scan_current_rune = "";
          common_scripts\utility::flag_set("moon_constellation_3_complete");
          _id_0378::_id_8D74("aud_moonraven_constellation_done");
        }
      }
    }

    waitframe();
  }

  level.star_scan_count = 0;

  foreach(var_1 in level.star_models) {
    if(level.star_scan_complete_a && var_1.setlookatent == level.star_index_a || level.star_scan_complete_b && var_1.setlookatent == level.star_index_b || level.star_scan_complete_c && var_1.setlookatent == level.star_index_c) {
      level.star_models = common_scripts\utility::_id_0F93(level.star_models, var_1);
      var_2 = _getent(var_1.target, "targetname");
      var_1.solved = 1;
      var_2.solved = 1;
    }
  }

  foreach(var_1 in level.star_models) {
    if(!var_1.solved) {
      var_1.tagged = 0;
      var_2 = _getent(var_1.target, "targetname");
      var_2 hide();
    }
  }
}

moonraven_contellation_vision_lost() {
  common_scripts\utility::_id_A70A("spike_lost", "disconnect");
  level.showstars = 0;

  foreach(var_1 in level.star_models) {
    var_2 = _getent(var_1.target, "targetname");
    var_1 hide();
    var_2 hide();
  }
}

moonraven_init_alcove() {
  common_scripts\utility::_id_3C9F("moonraven_orrery_complete");
  var_0 = common_scripts\utility::_id_46B5("moonraven_alcove_collect_1_melee", "targetname");
  var_1 = common_scripts\utility::_id_46B5("moonraven_alcove_collect_1_grenade", "targetname");
  var_2 = common_scripts\utility::_id_46B5("moonraven_alcove_collect_2_melee", "targetname");
  var_3 = common_scripts\utility::_id_46B5("moonraven_alcove_collect_2_grenade", "targetname");
  var_4 = common_scripts\utility::_id_46B5("moonraven_alcove_collect_3_melee", "targetname");
  var_5 = common_scripts\utility::_id_46B5("moonraven_alcove_collect_3_grenade", "targetname");
  level.moon_alcove_collect_1_count = 0;
  level.moon_alcove_collect_2_count = 0;
  level.moon_alcove_collect_3_count = 0;
  level.moon_alcove_collect_goal = 3;
  var_0 thread moonraven_alcove_collect_setup("moon_alcove_collect_1_melee_notify", "zom_dlc4_spike_zm", level.moon_alcove_collect_1_count, "moonraven_alcove_collect_1_complete");
  common_scripts\utility::_id_3C9F("moonraven_alcove_collect_1_complete");
  level.moon_rune_a show();
  level.moon_rune_a thread maps\mp\zombies\weapons\_zombie_dlc4_melee::wep_bounce();
  common_scripts\utility::_id_3C9F("moon_constellation_1_complete");
  var_2 thread moonraven_alcove_collect_setup("moon_alcove_collect_2_melee_notify", "zom_dlc4_spike_zm", level.moon_alcove_collect_2_count, "moonraven_alcove_collect_2_complete");
  common_scripts\utility::_id_3C9F("moonraven_alcove_collect_2_complete");
  level.moon_rune_b show();
  level.moon_rune_b thread maps\mp\zombies\weapons\_zombie_dlc4_melee::wep_bounce();
  common_scripts\utility::_id_3C9F("moon_constellation_2_complete");
  var_4 thread moonraven_alcove_collect_setup("moon_alcove_collect_3_melee_notify", "zom_dlc4_spike_zm", level.moon_alcove_collect_3_count, "moonraven_alcove_collect_3_complete");
  common_scripts\utility::_id_3C9F("moonraven_alcove_collect_3_complete");
  level.moon_rune_c show();
  level.moon_rune_c thread maps\mp\zombies\weapons\_zombie_dlc4_melee::wep_bounce();
  common_scripts\utility::_id_3C9F("moon_constellation_3_complete");
}

moonraven_alcove_collect_setup(var_0, var_1, var_2, var_3) {
  level endon(var_3);
  moonraven_alcove_collect(var_0, var_1);
  common_scripts\utility::flag_set(var_3);
}

moonraven_alcove_collect(var_0, var_1) {
  var_2 = level.moon_alcove_collect_goal;
  var_3 = 120;
  var_4 = 120;
  maps\mp\mp_zombies_soul_collection::beginazombiesoulcollectionobjectiveonstruct(var_2, var_3, var_4, var_0, undefined, "tag_origin", undefined, "tag_origin", var_1, undefined, (0, 0, 32));
}

quest_step_moonraven_scan() {
  common_scripts\utility::_id_3CA0("moon_constellation_1_complete", "moon_constellation_2_complete", "moon_constellation_3_complete");
  common_scripts\utility::flag_set("flag_stars_complete");
  _id_0557::_id_782D("quest_moonraven", "quest_moonraven_scan");
}

moonraven_debug_scan() {
  thread moonraven_debug_acquire_weapon();
  common_scripts\utility::flag_set("moon_constellation_1_complete");
  common_scripts\utility::flag_set("moon_constellation_2_complete");
  common_scripts\utility::flag_set("moon_constellation_3_complete");
  _id_0557::_id_782D("quest_moonraven", "quest_moonraven_scan");
}

quest_step_moonraven_alcove() {
  common_scripts\utility::_id_3CA0("moonraven_alcove_collect_1_complete", "moonraven_alcove_collect_2_complete", "moonraven_alcove_collect_3_complete");
  common_scripts\utility::flag_set("moon_trial_unlocked");
  _id_0557::_id_782D("quest_moonraven", "quest_moonraven_alcove");
}

moonraven_debug_alcove() {
  thread moonraven_debug_scan();
  common_scripts\utility::flag_set("moon_constellation_1_complete");
  common_scripts\utility::flag_set("moon_constellation_2_complete");
  common_scripts\utility::flag_set("moon_constellation_3_complete");
  common_scripts\utility::flag_set("moon_trial_unlocked");
  _id_0557::_id_782D("quest_moonraven", "quest_moonraven_alcove");
}

quest_step_moonraven_unlock_trial() {
  common_scripts\utility::_id_3C9F("moon_trial_unlocked");
  _activateclientexploder(236);
  _id_0557::_id_782D("quest_moonraven", "quest_moonraven_unlock_trial");
}

moonraven_debug_unlock_trial() {
  thread moonraven_debug_alcove();
  common_scripts\utility::flag_set("moon_trial_unlocked");
  _activateclientexploder(236);
  _id_0557::_id_782D("quest_moonraven", "quest_moonraven_unlock_trial");
}

quest_step_moonraven_enter_trial() {}

get_scepter_owner() {
  for(;;) {
    var_0 = level.ravenweaponmanager["spike"]._id_0117;

    if(isDefined(var_0))
      return var_0;

    waitframe();
  }
}

moonraven_debug_orrery_capture() {
  _activateclientexploder(236);
  level.orrery_moon_a = _getent("orrery_moon_A", "targetname");
  level.orrery_moon_a._id_6C50 = level.orrery_moon_a.angles;
  level.orrery_moon_b = _getent("orrery_moon_B", "targetname");
  level.orrery_moon_b._id_6C50 = level.orrery_moon_b.angles;
  level.orrery_moon_c = _getent("orrery_moon_C", "targetname");
  level.orrery_moon_c._id_6C50 = level.orrery_moon_c.angles;
  level.orrery_moon_d = _getent("orrery_moon_D", "targetname");
  level.orrery_moon_d._id_6C50 = level.orrery_moon_d.angles;
  level.orrery_moon_a._id_00D4 = 1;
  level.orrery_moon_b._id_00D4 = 7;
  level.orrery_moon_c._id_00D4 = 2;
  level.orrery_moon_d._id_00D4 = 0;
  level.orrery_yaw_offset = 150;
  level.orrery_moon_a.yaw_offset = level.orrery_yaw_offset + level.orrery_moon_a._id_00D4 * 45;
  level.orrery_moon_b.yaw_offset = level.orrery_yaw_offset + level.orrery_moon_b._id_00D4 * 45;
  level.orrery_moon_c.yaw_offset = level.orrery_yaw_offset + level.orrery_moon_c._id_00D4 * 45;
  level.orrery_moon_d.yaw_offset = level.orrery_yaw_offset + level.orrery_moon_d._id_00D4 * 45;
  level.orrery_moon_a.orbit_time = 4;
  level.orrery_moon_b.orbit_time = 3;
  level.orrery_moon_c.orbit_time = 2;
  level.orrery_moon_d.orbit_time = 1;
  level.orrery_moon_a_trigger = _getent("orrery_moon_A_trigger", "targetname");
  level.orrery_moon_b_trigger = _getent("orrery_moon_B_trigger", "targetname");
  level.orrery_moon_c_trigger = _getent("orrery_moon_C_trigger", "targetname");
  level.orrery_moon_d_trigger = _getent("orrery_moon_D_trigger", "targetname");
  level.orrery_max_index = 7;
  level.orrery_check_time = 90;
  level.orrery_moons_stopped = 0;
  thread moonraven_debug_orrery_capture_rotate_moon(level.orrery_moon_a, level.orrery_moon_a.angles[1] - level.orrery_moon_a.yaw_offset, level.chart_index_a, "orrery_moon_A_stop", "orrery_moon_A_valid", level.orrery_moon_a.orbit_time);
  thread moonraven_debug_orrery_capture_rotate_moon(level.orrery_moon_b, level.orrery_moon_b.angles[1] - level.orrery_moon_b.yaw_offset, level.chart_index_b, "orrery_moon_B_stop", "orrery_moon_B_valid", level.orrery_moon_b.orbit_time);
  thread moonraven_debug_orrery_capture_rotate_moon(level.orrery_moon_c, level.orrery_moon_c.angles[1] - level.orrery_moon_c.yaw_offset, level.chart_index_c, "orrery_moon_C_stop", "orrery_moon_C_valid", level.orrery_moon_c.orbit_time);
  thread moonraven_debug_orrery_capture_rotate_moon(level.orrery_moon_d, level.orrery_moon_d.angles[1] - level.orrery_moon_d.yaw_offset, level.chart_index_d, "orrery_moon_D_stop", "orrery_moon_D_valid", level.orrery_moon_d.orbit_time);
}

moonraven_debug_orrery_capture_rotate_moon(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_desc_planetglow_storm"), level.orrery_moon_a, "tag_origin");
  _triggerfx(var_6);
  var_7 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_desc_planetglow_moon"), level.orrery_moon_b, "tag_origin");
  _triggerfx(var_7);
  var_8 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_desc_planetglow_death"), level.orrery_moon_c, "tag_origin");
  _triggerfx(var_8);
  var_9 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_desc_planetglow_blood"), level.orrery_moon_d, "tag_origin");
  _triggerfx(var_9);
  _id_0378::_id_8D74("aud_moonraven_orrery_move", var_0);

  while(!common_scripts\utility::_id_3C77(var_3)) {
    var_1 = var_1 + 45;

    if(var_1 > 359)
      var_1 = 0;

    var_0 rotateto(_combineangles(var_0._id_6C50, (0, var_1, 0)), var_5);
    wait(var_5);
    var_0._id_00D4 = var_0._id_00D4 + 1;

    if(var_0._id_00D4 > level.orrery_max_index)
      var_0._id_00D4 = 0;

    if(var_0._id_00D4 == var_2 && common_scripts\utility::_id_3C77(var_3)) {
      var_0 _id_0378::_id_8D74("aud_moonraven_orrery_lock");
      common_scripts\utility::flag_set(var_4);
      continue;
    }

    if(common_scripts\utility::_id_3C77(var_3))
      _id_0378::_id_8D74("aud_moonraven_orrery_stop", var_0);
  }

  var_6 delete();
  var_6 = undefined;
  var_7 delete();
  var_7 = undefined;
  var_8 delete();
  var_8 = undefined;
  var_9 delete();
  var_9 = undefined;
}

_____obj_boss_fight____() {}

init_boss_fight_quest() {
  boss_flag_inits();
  level.bossfight = spawnStruct();
  level.bossfight.boss_pos = common_scripts\utility::_id_46B7("struct_boss_pos", "targetname");
  level.bossfight.boss_pos_wave0 = [];
  level.bossfight.boss_pos_wave1 = [];
  level.bossfight.boss_pos_wave2 = [];
  level.bossfight.boss_pos_wave3 = [];
  level.bossfight.boss_pos_wave6 = [];

  foreach(var_1 in level.bossfight.boss_pos) {
    if(!isDefined(var_1._id_0165)) {
      continue;
    }
    if(_id_0547::_id_5565(int(var_1._id_0165), 0))
      level.bossfight.boss_pos_wave0[level.bossfight.boss_pos_wave0.size] = var_1;

    if(_id_0547::_id_5565(int(var_1._id_0165), 1))
      level.bossfight.boss_pos_wave1[level.bossfight.boss_pos_wave1.size] = var_1;

    if(_id_0547::_id_5565(int(var_1._id_0165), 2))
      level.bossfight.boss_pos_wave2[level.bossfight.boss_pos_wave2.size] = var_1;

    if(_id_0547::_id_5565(int(var_1._id_0165), 3))
      level.bossfight.boss_pos_wave3[level.bossfight.boss_pos_wave3.size] = var_1;

    if(_id_0547::_id_5565(int(var_1._id_0165), 6))
      level.bossfight.boss_pos_wave6[level.bossfight.boss_pos_wave6.size] = var_1;
  }

  level.bossfight.boss_blood_pos = getEntArray("org_boss_blood_pos", "script_noteworthy");
  level.bossfight.boss_drain_pos = _getent("org_boss_drain_pos", "script_noteworthy");
  level.bossfight.throne_pos = _getent("org_boss_throne_pos", "script_noteworthy");
  level.bossfight.boss_sun_pos = common_scripts\utility::_id_46B7("struct_boss_sun_pos", "targetname");
  level thread maps\mp\_utility::_id_6F74(::handle_player_boss_respawn);
}

handle_player_boss_respawn() {
  var_0 = _getent("player_boss_respawner", "targetname");
  var_1 = self;

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(var_2 != var_1) {
      continue;
    }
    if(!isDefined(level.zmb_temp_moon_orb_ent)) {
      level.zmb_temp_moon_orb_ent = var_1 common_scripts\utility::_id_8FFC();
      level.zmb_temp_moon_orb_ent show();
    }

    var_1 maps\mp\zombies\weapons\_zombie_dlc4_melee::do_moon_orb_teleportation(var_1.bossstartorigin, level.zmb_temp_moon_orb_ent);
    var_1 do_damage_until_last_stand();
  }
}

do_damage_until_last_stand() {
  var_0 = self;
  var_0 endon("revive");
  var_0 endon("death");

  while(!common_scripts\utility::_id_562E(var_0._id_5728)) {
    var_0 dodamage(var_0.health + 1, var_0.origin, level.zmb_temp_moon_orb_ent, level.zmb_temp_moon_orb_ent, "MOD_MELEE");
    waitframe();
  }
}

boss_flag_inits() {
  common_scripts\utility::flag_init("flag_boss_fight_start");
  common_scripts\utility::flag_init("flag_boss_complete");
  common_scripts\utility::flag_init("flag_entered_boss_arena");
  common_scripts\utility::flag_init("flag_boss_arena_teleport_began");
}

sort_by_script_noteworthy() {
  if(!isDefined(self._id_0165))
    return 0;

  return int(self._id_0165);
}

sort_by_script_wtf() {
  if(!isDefined(self.weaponlocktargettooclose))
    return 0;

  return int(self.weaponlocktargettooclose);
}

quest_step_boss_open() {
  common_scripts\utility::_id_3C9F("flag_entered_boss_arena");
  _id_0557::_id_782D("quest_bossfight", "quest_bossfight_open");
}

_id_784C() {
  final_boss_setup();
  final_boss_intro_scene();
  common_scripts\utility::_id_3C9F("flag_boss_fight_start");
  thread maps\mp\_utility::_id_6F74(::prep_player_for_fight);
  spawn_raven_weapons_in_boss_room();
  start_boss_fight();
  clear_boss_fight();
  _id_0557::_id_782D("quest_bossfight", "quest_bossfight_start");
  thread maps\mp\mp_zombie_descent_utils::vo_radio_convo_boss_end();
}

prep_player_for_fight() {
  if(isDefined(self.isintrial))
    self.isintrial = undefined;

  if(isDefined(self.inasneakyplace))
    self.inasneakyplace = 0;

  if(isDefined(self.hitchingaride))
    self.hitchingaride = 0;

  if(isDefined(self.isbloodtubemoonorbblocked))
    self.isbloodtubemoonorbblocked = undefined;

  if(isDefined(self.tryingtoleavepap))
    self.tryingtoleavepap = 0;

  if(isDefined(self.isonpushcooldown))
    self.isonpushcooldown = 0;

  if(isDefined(self._id_480F))
    self._id_480F = 0;
}

#using_animtree("animated_props_zombies_DLC4");

final_boss_intro_scene() {
  level._id_6F1E = 1;
  var_0 = _id_0547::_id_408F();

  foreach(var_2 in var_0)
  var_2 suicide();

  var_4 = common_scripts\utility::_id_46B5("godking_intro_node", "targetname");
  var_5 = spawn("script_model", var_4.origin);
  var_5 setModel("zom_hero_f_bat_wholebody_dlc4");
  var_5.angles = var_4.angles;
  var_6 = spawn("script_model", var_4.origin);
  var_6 setModel("npc_zom_barb_sword_02");
  var_6 linktosynchronizedparent(var_5, "TAG_WEAPON_RIGHT", (0, 0, 0), (0, 0, 0));
  var_7 = spawn("script_model", var_4.origin);
  var_7 setModel("zom_darkone_base");
  var_7.angles = var_4.angles;
  var_8 = spawn("script_model", (0, 0, 0));
  var_8 setModel("player_generic_world_body");
  var_8 ghost();
  var_9 = % s2_zom_gdk_intro_godking;
  var_10 = % s2_zom_gdk_intro_vm;
  var_11 = % s2_zom_gdk_intro_vivian;
  level._id_22F0 = 1;
  setDvar("4712", 2);
  var_12 = "cam_note_notify";
  final_boss_intro_fade(0.25, 1);
  maps\mp\mp_zombie_descent_lighting::bossintrolightson();
  maps\mp\mp_zombie_descent_lighting::bossarenalightsoff();

  foreach(var_14 in level.players) {
    if(_id_0547::_id_577E(var_14))
      var_14 notify("revive_trigger");

    if(var_14 getstance() != "stand") {
      var_15 = var_14 setstance("stand", 0);
      waittillframeend;
      var_16 = var_14 getstance();

      while(var_16 != "stand") {
        var_16 = var_14 getstance();
        waitframe();
      }
    }

    var_14 allowprone(0);
    var_14 allowcrouch(0);
    var_14 allowjump(0);
    var_14 _meth_8546(0);
  }

  wait 0.5;

  foreach(var_14 in level.players) {
    var_14 maps\mp\_utility::freezecontrolswrapper(1);
    var_14._id_324E = 1;
    var_14 digitaldistortsetparams(0.85, 1.0, 1.0, 1.0, 0, 0.1);
    var_14 setclientomnvar("ui_hide_hud", 1);
    var_14 hideviewmodel();
    var_14 playerhide();
    var_14 disableweapons();
    var_14 setOrigin(var_8 gettagorigin("tag_player"));
    var_14 setplayerangles(var_8 gettagangles("tag_player"));
    var_14 playerlinktoabsolute(var_8, "tag_player");
    var_14 _id_0547::_id_8A6D(1);
  }

  wait 0.25;
  _id_0378::_id_8D74("aud_gdk_intro");
  var_8 scriptmodelplayanimdeltamotionfrompos("s2_zom_gdk_intro_vm", var_4.origin, var_4.angles, var_12);
  var_5 scriptmodelplayanimdeltamotionfrompos("s2_zom_gdk_intro_vivian", var_4.origin, var_4.angles);
  var_7 scriptmodelplayanimdeltamotionfrompos("s2_zom_gdk_intro_godking", var_4.origin, var_4.angles);
  var_8 childthread listen_for_notetrack_gdk(var_12);
  waitframe();
  final_boss_intro_fade(0.25, 0);
  var_20 = maps\mp\agents\_scripted_agent_anim_util::getnotetracktimeinsecs(var_9, "detach_sword");
  var_21 = _getanimlength(var_10);
  wait(var_20);
  var_6 unlink();
  var_6 linktosynchronizedparent(var_7, "j_spineupper");
  wait(var_21 - var_20 - 0.5);
  final_boss_intro_fade(0.25, 1);
  maps\mp\mp_zombie_descent_lighting::bossintrolightsoff();
  maps\mp\mp_zombie_descent_lighting::bossarenalightson();
  var_5 delete();
  var_6 delete();
  var_7 delete();
  level._id_22F0 = 0;
  setDvar("4712", 1);
  var_8 scriptmodelclearanim();
  var_8.origin = var_8.origin + (0, 0, 32);

  foreach(var_14 in level.players) {
    var_14 unlink();
    var_14 playershow();
    var_14 showviewmodel();
    var_14 enableweapons();
    var_14 maps\mp\_utility::freezecontrolswrapper(0);
    var_14 allowprone(1);
    var_14 allowcrouch(1);
    var_14 allowjump(1);
    var_14 _meth_8546(1);
    var_14 _id_0547::_id_8A6D(0);
    var_14 setclientomnvar("ui_hide_hud", 0);
    var_14._id_324E = 0;
    var_14 notify("boss_scene_end");
  }

  var_8 delete();
  final_boss_intro_send_players_to_start_positions();
  thread final_boss_intro_fade(0.25, 0);
  common_scripts\utility::flag_set("flag_boss_fight_start");
}

listen_for_notetrack_gdk(var_0) {
  var_1 = 4;

  foreach(var_3 in level.players)
  var_3 enablephysicaldepthoffieldscripting();

  var_5 = 0;

  while(var_1) {
    self waittill(var_0, var_6);

    if(issubstr(var_6, "fov")) {
      var_1--;
      var_7 = get_fov(var_6);
      var_5 = get_time(var_6);

      foreach(var_3 in level.players)
      var_3 setphysicaldepthoffield(8.0, var_7, var_5);
    }
  }

  wait(var_5);

  foreach(var_3 in level.players)
  var_3 disablephysicaldepthoffieldscripting();
}

get_fov(var_0) {
  var_1 = _func_337(var_0, "fov_");
  var_2 = "";
  var_3 = 0;

  for(;;) {
    if(_func_30E(var_1[var_3])) {
      var_2 = var_2 + var_1[var_3];
      var_3++;
      continue;
    }

    break;
  }

  return _id_0547::_id_9470(var_2);
}

get_time(var_0) {
  var_1 = var_0;
  var_2 = "";
  var_3 = var_1.size - 1;

  for(;;) {
    if(_func_30E(var_1[var_3]) || var_1[var_3] == ".") {
      var_2 = var_2 + var_1[var_3];
      var_3--;
      continue;
    }

    break;
  }

  var_4 = "";

  for(var_5 = var_2.size - 1; var_5 >= 0; var_5--)
    var_4 = var_4 + var_2[var_5];

  return common_scripts\utility::stringtofloat(var_4);
}

final_boss_intro_send_players_to_start_positions() {
  level thread maps\mp\_utility::_id_6F74(::final_boss_intro_send_players_to_start_positions_safe);
}

final_boss_intro_send_players_to_start_positions_safe() {
  var_0 = self;
  var_1 = common_scripts\utility::_id_46B7("zmb_boss_spawns", "targetname");
  level.boss_battle_respawns = var_1;
  var_0._id_763C = var_0.origin;
  var_0 setOrigin(var_1[var_0 getentitynumber()].origin);
  var_0 setplayerangles(var_1[var_0 getentitynumber()].angles);
  var_0.bossstartorigin = var_0.origin;
  var_0.bossstartangles = var_0.angles;
  var_0 unlink();
  var_0 enableweapons();
  var_0 freezecontrols(0);
  var_0._id_AC5B = 0;
  var_0 playershow();
}

final_boss_intro_fade(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    var_0 = 1;

  if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(var_2))
    var_2 = "white";

  foreach(var_4 in level.players) {
    if(var_1 >= 1) {
      if(isDefined(var_4._id_1781))
        var_4._id_1781 destroy();

      var_4._id_1781 = _id_0547::zm_util_create_client_overlay("black", 0.0, var_4, (1, 1, 1));
      var_4._id_1781 setshader(var_2, 640, 480);
    }

    if(isDefined(var_4._id_1781)) {
      var_4._id_1781 fadeovertime(var_0);
      var_4._id_1781.alpha = var_1;
    }
  }

  wait(var_0);
}

final_boss_setup() {
  level.zmb_locked_spawn_zones = ["zone_citadel"];
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8608();
  kill_remaining_zombies();
}

kill_remaining_zombies() {
  var_0 = _id_0547::_id_408F();

  foreach(var_2 in var_0)
  var_2 suicide();
}

spawn_raven_weapons_in_boss_room() {
  var_0 = common_scripts\utility::_id_46B7("struct_boss_room_raven_weps", "targetname");
  var_1 = ["shield_emp", "hammer_emp", "spike_emp", "scythe_emp"];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(!isDefined(level.ravenweaponmanager[var_1[var_2]]._id_0117))
      thread maps\mp\zombies\weapons\_zombie_dlc4_melee::spawn_raven_weapon(var_1[var_2], var_0[var_2].origin);
  }
}

start_boss_fight() {
  maps\mp\_events_z::start_boss_battle_tracking();
  var_0 = level.bossfight.throne_pos;
  level.zombie_king = _id_054D::_id_90BA("zombie_king", var_0, "final boss fight", 0, 1, 0);
  level.zombie_king_sword = spawn("script_model", var_0.origin);
  level.zombie_king_sword setModel("npc_zom_barb_sword_02");
  level.zombie_king_sword linktosynchronizedparent(level.zombie_king, "TAG_SWORD", (0, 0, 0), (0, 90, 90));
  level.zombie_king_sword.hitbox = _getent("trig_sword_hitbox", "targetname");
  level.zombie_king_sword.hitbox.origin = var_0.origin;
  level.zombie_king_sword.hitbox linktosynchronizedparent(level.zombie_king, "TAG_SWORD", (0, 0, 0), (0, 90, 90));
  level.zombie_king_sword.hitbox setcandamage(1);
  level.zombie_king_sword.hitbox setdamagecallbackon(1);
  level.zombie_king_sword.hitbox.health = 1000000;
  level.zombie_king_sword.hitbox.maxhealth = 1000000;
  level.zombie_king_sword.hitbox.damagecallback = ::sworddamagecallback;
  level._id_AC80._id_ACB3["zone_citadel"]._id_556E = 1;
  common_scripts\utility::flag_set("zone_citadel");
  player_blood_plate_tuning();
  thread boss_handle_phases();
  _id_0378::_id_8D74("aud_boss_music_start");
  play_outro_bik();
  common_scripts\utility::_id_3C9F("flag_boss_complete");
  maps\mp\_events_z::end_boss_battle_tracking();
}

sworddamagecallback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = self;

  if(isPlayer(var_1)) {
    wait 0;
    var_13 = "weakpoint";

    if(isDefined(level.zombie_king) && common_scripts\utility::_id_3C77("flag_boss_fight_start") && !common_scripts\utility::_id_3C77("flag_boss_complete") && !common_scripts\utility::_id_562E(level.zombie_king.geistbulletshield) && !common_scripts\utility::_id_562E(level.zombie_king.drainshieldacive)) {
      var_1 thread _id_04C7::_id_A102(var_13, level.zombie_king);
      level.zombie_king dodamage(var_2, var_12.origin, var_1, var_0, var_4, var_5, "soft");
    }
  }

  var_12.health = var_12.maxhealth;
}

player_blood_plate_tuning() {
  var_0 = level.players.size;

  foreach(var_2 in level.blood_plates) {
    var_3 = undefined;

    if(_id_0547::_id_5565(var_2.setlookatent, "plate_boss_room")) {
      switch (var_0) {
        case 1:
          var_3 = 8;
          break;
        case 2:
          var_3 = 10;
          break;
        case 3:
          var_3 = 14;
          break;
        case 4:
          var_3 = 18;
          break;
        default:
          break;
      }
    }

    if(isDefined(var_3)) {
      var_2.souls_max = var_3;
      var_2 maps\mp\mp_zombie_descent::blood_plate_empty();
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
  while(!isDefined(level.zombie_king))
    waitframe();

  wait 0.5;
  level.zombie_king thread maps\mp\zombies\zombie_king::vo_play_gdk_ability_line("intro");
}

phase_enrage_timer(var_0, var_1) {
  level notify("phase_enrage_timer_start");
  level endon("phase_enrage_timer_start");
  wait(var_1);

  if(!_id_0547::is_solo())
    level notify(var_0);
}

boss_phase_0() {
  var_0 = 0;
  level.zombie_king thread maps\mp\zombies\zombie_king::king_set_current_phase(var_0);
  var_1 = "phase_0_enrage";
  thread phase_enrage_timer(var_1, 480);
  level endon(var_1);

  while(level.zombie_king.health > level.zombie_king.maxhealth * 0.85)
    waitframe();
}

boss_phase_1() {
  var_0 = 1;
  level.zombie_king thread maps\mp\zombies\zombie_king::king_set_current_phase(var_0);
  var_1 = "phase_1_enrage";
  thread phase_enrage_timer(var_1, 540);
  level endon(var_1);

  while(level.zombie_king.health > level.zombie_king.maxhealth * 0.65)
    waitframe();
}

boss_phase_2() {
  var_0 = 2;
  level.zombie_king thread maps\mp\zombies\zombie_king::king_set_current_phase(var_0);
  var_1 = "phase_2_enrage";
  thread phase_enrage_timer(var_1, 540);
  level endon(var_1);

  while(level.zombie_king.health > level.zombie_king.maxhealth * 0.42)
    waitframe();
}

boss_phase_3() {
  var_0 = 3;
  level.zombie_king thread maps\mp\zombies\zombie_king::king_set_current_phase(var_0);
  var_1 = "phase_3_enrage";
  thread phase_enrage_timer(var_1, 600);
  level endon(var_1);

  while(level.zombie_king.health > level.zombie_king.maxhealth * 0.15)
    waitframe();
}

boss_phase_3_2() {
  if(_id_0547::is_solo()) {
    return;
  }
  var_0 = 6;
  level.zombie_king thread maps\mp\zombies\zombie_king::king_set_current_phase(var_0);

  while(level.zombie_king.health > level.zombie_king.maxhealth * 0.01)
    waitframe();
}

boss_phase_4() {
  level.zombie_king thread maps\mp\zombies\zombie_king::king_set_current_phase(4);
  level waittill("finale_outro_bik_end");
  level.zombie_king notify("transition_scene_done");
}

boss_phase_5() {
  thread finale_setup_players();
  level.zombie_king.health = level.zombie_king.health + int(level.zombie_king.maxhealth * 0.1);
  level.zombie_king thread maps\mp\zombies\zombie_king::king_set_current_phase(5);
}

finale_setup_players() {
  var_0 = common_scripts\utility::_id_46B7("org_finale_phase_player", "targetname");
  var_1 = common_scripts\utility::_id_0FA4(var_0, ::sort_by_script_noteworthy);

  foreach(var_5, var_3 in level.players) {
    var_4 = _getgroundposition(var_1[var_5].origin, 64, 128, 12);
    var_3 setOrigin(var_4, 1);
  }

  thread maps\mp\_utility::_id_6F74(::give_raven_form);
}

give_raven_form() {
  var_0 = self;
  var_0 endon("disconnect");

  while(!isalive(var_0) || _id_0547::_id_577E(var_0))
    waitframe();

  wait 1;
  var_0 thread maps\mp\zombies\zombie_king::set_player_ravenlord_state();
}

clear_boss_fight() {
  level.zmb_locked_spawn_zones = undefined;
  _id_0378::_id_8D74("dlc_handle_boss_killed_music");
  wait 10;
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8607();
  thread delayed_reactivate_treasure_zombies();
}

delayed_reactivate_treasure_zombies() {
  wait 60;
  level._id_6F1E = 0;
}

play_outro_bik() {
  level waittill("finale_bik_outro_begin");
  _id_0547::zm_util_run_outro("mp/mp_zom_dlc4_outro", 36.56, 1.15, 1, 0, "finale_outro_movie");
  level notify("finale_outro_bik_end");
}

outrofadein() {
  self._id_6772 = _newclienthudelem(self);
  self._id_6772 setshader("black", 640, 480);
  self._id_6772.sort = 999;
  self._id_6772._id_00C6 = "fullscreen";
  self._id_6772._id_01CA = "fullscreen";
  self._id_6772.foreground = 0;
  thread animscripts\notetracks_common::do_fade_from_black(0.8);
}

outrofadeout() {
  self._id_6772 = _newclienthudelem(self);
  self._id_6772 setshader("black", 640, 480);
  self._id_6772.sort = 999;
  self._id_6772._id_00C6 = "fullscreen";
  self._id_6772._id_01CA = "fullscreen";
  self._id_6772.foreground = 0;
  thread animscripts\notetracks_common::_id_30B4(1.15);
}

test_ice_block_bullettrace_hit(var_0, var_1) {
  var_2 = bulletTrace(var_0, var_1, 0, undefined, 1);
  var_3 = 0;

  foreach(var_5 in level.ice_blocks) {
    if(isDefined(var_5.damage_trig) && _ispointinvolume(var_2["position"], var_5.damage_trig)) {
      var_5 thread ice_block_take_damage(var_2["position"]);
      var_3 = 1;
    }
  }

  return [var_3, var_2["position"]];
}

test_ice_block_explosion_hit(var_0, var_1) {
  var_2 = undefined;

  foreach(var_4 in level.ice_blocks) {
    if(isDefined(var_4.damage_trig) && _distance2d(var_0, var_4.origin) <= var_1 + var_4._id_8303) {
      var_2 = bulletTrace(var_0, var_4.origin, 0, undefined, 1);

      if(_ispointinvolume(var_2["position"], var_4.damage_trig))
        var_4 thread ice_block_take_damage(var_2["position"]);
    }
  }

  if(isDefined(var_2) && isDefined(var_2["position"]))
    return [1, var_2["position"]];
  else
    return [0];
}

test_ice_block_projectile_hit(var_0) {
  var_1 = self;

  if(!isDefined(var_0)) {
    return;
  }
  var_0 waittill("projectile_impact", var_2, var_3);

  foreach(var_5 in level.ice_blocks) {
    if(isDefined(var_5.damage_trig) && _ispointinvolume(var_3, var_5.damage_trig))
      var_5 thread ice_block_take_damage(var_3);
  }
}

ice_block_take_damage(var_0) {
  self.ice_health = self.ice_health - 8;

  if(self.ice_health <= 0) {
    ice_block_break();
    return;
  }

  if(!isDefined(var_0))
    var_0 = self.origin;

  playFX(common_scripts\utility::_id_44F5("zmb_desc_ice_destruct_chunks"), var_0);
  _id_0378::_id_8D74("aud_damage_ice");
}

get_unbroken_ice_blocks() {
  var_0 = [];

  if(isDefined(level.ice_blocks)) {
    foreach(var_2 in level.ice_blocks) {
      if(var_2 ice_block_is_unbroken())
        var_0[var_0.size] = var_2;
    }
  }

  return var_0;
}

ice_block_is_unbroken() {
  return isDefined(self.damage_trig);
}

ice_block_break() {
  playFX(common_scripts\utility::_id_44F5("zmb_desc_ice_explode"), self.origin + (0, 0, 40));
  _id_0378::_id_8D74("aud_break_ice");

  if(isDefined(self.mdl))
    self.mdl delete();

  if(isDefined(self.mdl_broke))
    self.mdl_broke show();

  if(isDefined(self._id_241F)) {
    self._id_241F connectpaths();
    self._id_241F hide();
    self._id_241F notsolid();
  }

  if(isDefined(self.clip_broke)) {
    self.clip_broke connectpaths();
    self.clip_broke solid();
  }

  if(isDefined(self.damage_trig))
    self.damage_trig delete();
}

_id_67F1(var_0, var_1) {
  self endon("death");

  if(var_1 > 0)
    wait(var_1);

  if(!isDefined(self)) {
    return;
  }
  self notify(var_0);
}