/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\so_assault_oilrig.gsc
********************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#include maps\_vehicle;
#include maps\_specialops;
#include maps\_slowmo_breach;

main() {
  level.so_compass_zoom = "close";

  remove_triggers = getEntArray("redshirt_trigger", "targetname");
  foreach(trigger in remove_triggers)
  trigger Delete();

  add_start("start_map", ::start_map);
  maps\oilrig::main();
  default_start(::start_map);
  thread maps\oilrig::above_water_art_and_ambient_setup();
  thread maps\oilrig::killtrigger_ocean_on();

  if(issplitscreen())
    level._effect["_attack_heli_spotlight"] = LoadFX("misc/spotlight_large");
}

start_map() {
  level endon("special_op_terminated");

  level.hostagemanhandle = false;
  thread fade_challenge_in();
  thread enable_challenge_timer("breaching_on", "barracks_cleared");
  thread music_to_first_breach();
  thread music_to_top_deck();

  thread breach_flags();
  thread maps\oilrig::c4_barrels();
  assert(isDefined(level.gameskill));
  switch (level.gameSkill) {
    case 0:
    case 1:
      gameskill_Regular();
      break;
    case 2:
      gameskill_hardened();
      break;
    case 3:
      gameskill_veteran();
      break;
  }
  thread obj_main();

  maps\_compass::setupMiniMap("compass_map_oilrig_lvl_1");
  array_thread(getEntArray("compassTriggers", "targetname"), maps\oilrig::compass_triggers_think);

  array_call(level.players, ::SetMoveSpeedScale, 1);
  level.playerspeed = undefined;

  battlechatter_on("axis");

  flag_wait("upper_room_cleared");

  level.hostageNodes = getnodearray("node_hostage_scaffolding", "targetname");
  volume_ambush_room = getent("volume_ambush_room", "script_noteworthy");
  thread hostage_evac(volume_ambush_room);
  thread alarm();

  wait 10;
  thread maps\oilrig::open_gate(undefined, true);
  thread maps\oilrig::spawn_trigger_dummy("dummy_spawner_ballsout_intro");
  thread maps\oilrig::spawn_trigger_dummy("dummy_spawner_ballsout");

  flag_wait("player_at_deck1_midpoint");

  aSpawners = getEntArray("hostiles_rappel_deck2", "targetname");
  flag_wait("rappel_dudes_failsafe");
  aHostiles = maps\oilrig::spawn_group_staggered(aSpawners);

  heli_enters_and_attacks();

  flag_wait("player_at_stairs_to_top_deck");
  thread maps\oilrig::deck3_firefight();

  flag_wait("smoke_firefight");
  thread dialogue_thermal_hint();

  flag_wait("player_approaching_topdeck_building");

  radio_dialogue("oilrig_sbc_hostconfirmed");

  flag_wait("top_deck_room_breached");

  flag_wait("barracks_cleared");

  wait(2);

  thread fade_challenge_out();
}

dialogue_thermal_hint() {
  wait 2;

  dialogue_array[0] = "oilrig_use_thermal_00";

  dialogue_array[1] = "oilrig_find_thermal_00";

  iRand = randomint(dialogue_array.size);
  radio_dialogue(dialogue_array[iRand]);
}

heli_enters_and_attacks() {
  heliSpawner = getent("heli_deck2", "targetname");
  heliSpawner.origin = heliSpawner.origin + (0, 0, -250);
  eHeli = spawn_vehicle_from_targetname_and_drive("heli_deck2");

  eHeli endon("death");

  foreach(eTurret in eHeli.mgturret) {
    eTurret turret_set_default_on_mode("manual");
    eTurret setMode("manual");
  }
  eHeli.dontWaitForPathEnd = true;
  thread maps\oilrig::heli_ramp_up_damage(eHeli);
  eHeli thread heli_intimidates_player();
  eHeli delaythread(3, maps\_attack_heli::heli_spotlight_on, "tag_barrel", true);
  thread track_if_player_is_shooting_at_intimidating_heli(eHeli);
  thread maps\oilrig::heli_kill_failsafe(eHeli);

  flag_wait_either("player_shoots_or_aims_rocket_at_intimidating_heli", "deck_2_heli_is_finished_intimidating");
  eHeli = maps\_attack_heli::begin_attack_heli_behavior(eHeli);
}

heli_intimidates_player() {
  wait(5);
  flag_set("deck_2_heli_is_finished_intimidating");
}

track_if_player_is_shooting_at_intimidating_heli(eHeli) {
  level endon("deck_2_heli_is_finished_intimidating");
  level endon("player_shoots_or_aims_rocket_at_intimidating_heli");
  for(;;) {
    eHeli waittill("damage", damage, attacker, direction_vec, P, type);

    if(!isDefined(attacker) || !isPlayer(attacker))
      continue;
    else {
      flag_set("player_shoots_or_aims_rocket_at_intimidating_heli");
      break;
    }
  }
}

dialogue_end_chatter() {
  radio_dialogue("oilrig_rmv_goplat");

  radio_dialogue("oilrig_gm1_copies");

  radio_dialogue("oilrig_f15_twof15s");

  radio_dialogue("oilrig_rmv_bluesky");

  radio_dialogue("oilrig_f15_copies");

  radio_dialogue("oilrig_rmv_localairspace");

  radio_dialogue("oilrig_gm1_hunteractual");

  radio_dialogue("oilrig_rmv_samsitesneut");
}

breach_flags() {
  level waittill("breach_explosion");
  flag_set("upper_room_breached");

  wait(2);

  level waittill("breach_explosion");
  flag_set("top_deck_room_breached");
}

alarm() {
  alarm_org = getent("origin_alarm", "targetname");
  alarm_org playLoopSound("emt_oilrig_alarm_alert");
  wait(20);
  alarm_org stopLoopSound("emt_oilrig_alarm_alert");
  alarm_org delete();
}

music_to_first_breach() {
  level endon("upper_room_breached");

  music_alias = "so_assault_oilrig_sneak_music";
  music_time = musicLength(music_alias) + 2;
  while(!flag("upper_room_breached")) {
    MusicPlayWrapper(music_alias);
    wait(music_time);
  }
}

music_to_top_deck() {
  flag_wait("upper_room_breached");
  music_stop();
  flag_wait("upper_room_cleared");

  level endon("top_deck_room_breached");

  music_alias = "so_assault_oilrig_fight_music_01";
  music_time = musicLength(music_alias) + 2;
  while(!flag("top_deck_room_breached")) {
    MusicPlayWrapper("so_assault_oilrig_fight_music_01");
    wait(music_time);
  }
}

music_end() {
  flag_wait("top_deck_room_breached");
  music_stop();

  flag_wait("barracks_cleared");
  musicstop();
  wait(.5);
  MusicPlayWrapper("so_assault_oilrig_victory_music");
}

hostage_evac(eVolume) {
  level endon("mission failed");
  level endon("missionfailed");
  level endon("player_shot_a_hostage");
  aHostages = eVolume get_ai_touching_volume("neutral");
  if(flag("oilrig_mission_failed"))
    return;
  if(flag("missionfailed"))
    return;
  array_thread(aHostages, ::hostage_evac_think);
  thread AI_delete_when_out_of_sight(aHostages, 512);
}

hostage_evac_think() {
  level endon("mission failed");
  self endon("death");

  while(!isDefined(self.breachfinished))
    wait(.1);

  while(self.breachfinished == false)
    wait(.1);

  wait(randomfloatrange(1, 2));
  eNode = level.hostageNodes[0];
  level.hostageNodes = array_remove(level.hostageNodes, eNode);

  if(!isDefined(self)) {
    return;
  }
  self notify("stop_idle");
  self setgoalnode(eNode);
  self.goalradius = 64;
  self.alertlevel = "alert";
  self waittill("goal");
}

gameskill_regular() {
  level.challenge_objective = &"SO_ASSAULT_OILRIG_OBJ_MAIN";
}

gameskill_hardened() {
  level.challenge_objective = &"SO_ASSAULT_OILRIG_OBJ_MAIN";
}

gameskill_veteran() {
  level.challenge_objective = &"SO_ASSAULT_OILRIG_OBJ_MAIN";
}

obj_main() {
  objective_number = 1;
  obj_positions = getEntArray("obj_breach2", "targetname");

  objective_add(objective_number, "current", level.challenge_objective);

  assign_script_breachgroup_to_ents(obj_positions);

  breach_indices = get_breach_indices_from_ents(obj_positions);

  objective_breach(objective_number, breach_indices[0], breach_indices[1], breach_indices[2], breach_indices[3]);

  flag_wait("upper_room_breached");
  objective_clearAdditionalPositions(objective_number);
  Objective_SetPointerTextOverride(objective_number);

  flag_wait("upper_room_cleared");
  obj_position = getent("obj_explosives_locate_01", "targetname");
  Objective_Position(objective_number, obj_position.origin);

  flag_wait("player_at_stairs_to_deck_2");
  obj_position = getent("obj_explosives_locate_01a", "targetname");
  objective_position(objective_number, obj_position.origin);

  flag_wait("player_at_corener_of_deck2");
  obj_position = getent("obj_explosives_locate_02", "targetname");
  objective_position(objective_number, obj_position.origin);

  flag_wait("player_at_stairs_to_top_deck");

  obj_positions = getEntArray("obj_breach3", "targetname");
  assign_script_breachgroup_to_ents(obj_positions);

  breach_indices = get_breach_indices_from_ents(obj_positions);

  objective_breach(objective_number, breach_indices[0], breach_indices[1], breach_indices[2], breach_indices[3]);

  flag_wait("top_deck_room_breached");
  objective_clearAdditionalPositions(objective_number);

  flag_wait("barracks_cleared");

  wait(1);

  objective_state(objective_number, "done");
}