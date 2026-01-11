/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_shipment_ns.gsc
**************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

main() {
  maps\mp\mp_shipment_ns_precache::main();
  maps\createart\mp_shipment_ns_art::main();
  maps\mp\mp_shipment_ns_fx::main();

  setdvar_cg_ng("r_specularColorScale", 3.5, 7.5);

  level.mapCustomCrateFunc = ::CustomCrateFunc;
  level.mapCustomKillstreakFunc = ::CustomKillstreakFunc;
  level.mapCustomBotKillstreakFunc = ::CustomBotKillstreakFunc;

  precache();

  maps\mp\_load::main();

  level.nukeDeathVisionFunc = ::nukeDeathVision;

  thread manage_gates();

  maps\mp\_compass::setupMiniMap("compass_map_mp_shipment_ns");

  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);

  setdvar_cg_ng("r_specularColorScale", 3.0, 9.5);

  if(level.ps3) {
    SetDvar("sm_sunShadowScale", "0.45");
    SetDvar("sm_sunsamplesizenear", ".15");
  } else if(level.xenon) {
    SetDvar("sm_sunShadowScale", "0.55" + "");
    SetDvar("sm_sunsamplesizenear", ".3");
  } else {
    SetDvar("sm_sunShadowScale", "1.0");
    SetDvar("sm_sunsamplesizenear", ".42");
  }

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";

  sort_spawn_points();
  thread trap_init();
  thread display_team_scores();
  thread check_for_player_connect();

  thread box_kill_counter();

  thread select_random_prize();
  thread set_up_announcer();
  thread set_up_multi_turret();
  thread nuke_custom_visionset();
  thread box_kill_numbers();
  thread match_end_event();
  thread rotate_turntable();
  thread get_prize_room_curtains_n_fx();

  thread get_elevators();

  thread maps\mp\_dlcalienegg::setupEggForMap("alienEasterEgg");
  level.helipilotsettings["heli_pilot"].modelbase = "vehicle_aas_72x_killstreak_shns";

  maps\mp\bots\_bots_ks::blockKillstreakForBots("vanguard");
}

precache() {
  PrecacheMpAnim("mp_stand_idle");
  PrecacheMpAnim("hunted_celebrate_v2");
  PrecacheMpAnim("hunted_celebrate_v3");

  PreCacheModel("shns_score_num_0_small");
  PreCacheModel("shns_score_num_1_small");
  PreCacheModel("shns_score_num_2_small");
  PreCacheModel("shns_score_num_3_small");
  PreCacheModel("shns_score_num_4_small");
  PreCacheModel("shns_score_num_5_small");
  PreCacheModel("shns_score_num_6_small");
  PreCacheModel("shns_score_num_7_small");
  PreCacheModel("shns_score_num_8_small");
  PreCacheModel("shns_score_num_9_small");
}

manage_gates() {
  level endon("game_ended");
  level endon("start_custom_ending");

  gates_main = getEntArray("doors", "targetname");
  gates_side = getEntArray("doors_b", "targetname");
  gates_all = array_combine(gates_main, gates_side);

  while(!isDefined(level.gametype)) {
    wait 0.01;
  }

  move_gate_array(gates_all, "open", 0);

  if(level.gametype == "sd" || level.gametype == "sr" || level.gametype == "siege" || level.gametype == "horde" || level.gameType == "infect" || level.gametype == "grnd") {
    remove_armored_shutters();
    return;
  }

  thread manage_expanded_area_spawns();

  botAutoConnectValue = BotAutoConnectEnabled();

  if(botAutoConnectValue == 0) {
    if(level.gametype == "dom" || level.gametype == "infect" || level.gametype == "grnd") {
      while(!isDefined(level.bot_gametype_precaching_done)) {
        wait(0.05);
      }
    }

    move_gate_array(gates_all, "close", 1, true);
  } else {
    if(level.gametype != "dom" && level.gametype != "infect" && level.gametype != "grnd" && level.gameType != "blitz") {
      move_gate_array(gates_all, "close", 1, true);
    } else {
      while(!isDefined(level.bot_gametype_precaching_done)) {
        wait(0.05);
      }

      move_gate_array(gates_all, "close", 1, true);
    }
  }

  OPEN_DELAY = 45;
  gates = gates_all;
  armory_windows = false;

  bots = GetMatchData("hasBots");

  switch (level.gametype) {
    case "dm":
    case "war":
    case "conf":
    case "cranked":
      gates = gates_main;
      OPEN_DELAY = 60;
      break;
    case "dom":

      armory_windows = true;
      if(GetMatchData("hasBots") == 1) {
        OPEN_DELAY = 0;
      }
      else {
        OPEN_DELAY = 45;
      }
      break;

    case "infect":
    case "grind":

      armory_windows = true;
      OPEN_DELAY = 1;
      break;
    case "blitz":
    case "sr":
    case "sd":
      gates = gates_main;
      OPEN_DELAY = 1;
      break;

    default:
      armory_windows = true;
      OPEN_DELAY = 1;
      break;
  }

  if(isDefined(OPEN_DELAY)) {
    thread sfx_gate_alarm(OPEN_DELAY);

    thread play_warning_light_fx(OPEN_DELAY);

    wait OPEN_DELAY;

    if(armory_windows) {
      remove_armored_shutters();
    }

    thread sfx_gates_open();
    move_gate_array(gates, "open", 1, true);

    level notify("announcement", "doors_opened", undefined, undefined, true);

    level notify("gates_open");

  }
}

debug_loop(message) {
  while(1) {
    IPrintLnBold(message);

    wait 1.0;
  }
}

play_red_light_fx() {}

play_warning_light_fx(OPEN_DELAY) {
  if(OPEN_DELAY > 4) {
    wait OPEN_DELAY - 4;
    exploder(11);
    for(i = 0; i < 4; i++) {
      thread sfx_lights_red();
      exploder(42);
      wait 1.1;
    }
  }

  thread sfx_lights_green();
  exploder(40);
}

move_gate_array(gates, direction, time, dynamic_path) {
  foreach(gate in gates) {
    thread move_gate(gate, direction, time, dynamic_path);
  }

  wait time;
}

move_gate(gate, direction, time, dynamic_path) {
  model = GetEnt(gate.target, "targetname");

  if(isDefined(dynamic_path)) {
    if(direction == "close") {
      if(isDefined(model)) {
        if(time >= 1) {
          model MoveTo(model.origin + (0, 0, 104), time, time / 8, time / 4);
        }
        else {
          model.origin = model.origin + (0, 0, 104);
        }
      }
      gate MoveTo(gate.origin + (0, 0, 96), .1);
      wait .1;
      gate Solid();
      gate DisConnectPaths();
      gate Show();
      gate SetAISightLineVisible(false);
    } else {
      if(isDefined(model)) {
        if(time >= 1) {
          model MoveTo(model.origin - (0, 0, 104), time, time / 8, time / 4);
        }
        else {
          model.origin = model.origin - (0, 0, 104);
        }
      }
      gate ConnectPaths();
      gate NotSolid();
      gate Hide();
      gate SetAISightLineVisible(true);
      gate MoveTo(gate.origin - (0, 0, 96), .1);
      wait .1;
    }
  } else {
    if(direction == "close") {
      if(isDefined(model)) {
        if(time >= 1) {
          model MoveTo(model.origin + (0, 0, 104), time, time / 8, time / 4);
        }
        else {
          model.origin = model.origin + (0, 0, 104);
        }
      }
    } else {
      if(isDefined(model)) {
        if(time >= 1) {
          model MoveTo(model.origin - (0, 0, 104), time, time / 8, time / 4);
        }
        else {
          model.origin = model.origin - (0, 0, 104);
        }
      }
    }
  }
}

move_shutter_array(shutters, direction, time) {
  foreach(shutter in shutters) {
    thread move_shutter(shutter, direction, time);
  }

  wait time;
}

move_shutter(shutter, direction, time) {
  if(direction == "close") {
    shutter MoveTo(shutter.origin + (0, 0, 96), time, time / 8, time / 4);
  } else {
    shutter MoveTo(shutter.origin - (0, 0, 96), time, time / 8, time / 4);
  }
}

remove_armored_shutters() {
  shutters = getEntArray("armory_rollups", "targetname");

  if(isDefined(shutters)) {
    foreach(shutter in shutters) {
      shutter Delete();
    }
  }
}

manage_expanded_area_spawns() {
  level.dynamicSpawns = ::filter_expanded_area_spawn_points;
  level waittill("gates_open");
  level.dynamicSpawns = undefined;
}

manage_trap_1_area_spawns() {
  level.dynamicSpawns = ::filter_trap_1_area_spawn_points;
  flag_waitopen("trap_1_active");
  level.dynamicSpawns = undefined;
}

filter_expanded_area_spawn_points(spawnpoints) {
  valid_spawns = [];
  foreach(spawnPoint in spawnpoints) {
    if(is_in_array(level.expanded_area_spawns, spawnPoint)) {
      continue;
    }
    valid_spawns[valid_spawns.size] = spawnPoint;
  }

  return valid_spawns;
}

filter_trap_1_area_spawn_points(spawnpoints) {
  valid_spawns = [];
  foreach(spawnPoint in spawnpoints) {
    if(is_in_array(level.trap_1_area_spawns, spawnPoint)) {
      continue;
    }
    valid_spawns[valid_spawns.size] = spawnPoint;
  }

  return valid_spawns;
}

sort_spawn_points() {
  level.expanded_area_spawns = [];
  level.trap_1_area_spawns = [];

  while(!isDefined(level.gametypestarted)) {
    wait(0.05);
  }

  if(!isDefined(level.spawnpoints)) {
    return;
  }
  foreach(spawnpoint in level.spawnpoints) {
    parameters = spawnpoint.script_noteworthy;

    if(!isDefined(parameters)) {
      continue;
    }
    params = StrTok(parameters, ";");
    foreach(param in params) {
      if(param == "expanded_area_spawn") {
        level.expanded_area_spawns[level.expanded_area_spawns.size] = spawnpoint;
      }

      if(param == "trap_1_area_spawn") {
        level.trap_1_area_spawns[level.trap_1_area_spawns.size] = spawnpoint;
      }
    }
  }
}

is_in_array(aeCollection, eFindee) {
  for(i = 0; i < aeCollection.size; i++) {
    if(aeCollection[i] == eFindee) {
      return (true);
    }
  }

  return (false);
}

display_team_scores() {
  while(1) {
    if(isDefined(level.players)) {
      break;
    }
    wait 1;
  }

  digits = getEntArray("scoreboard_number", "target");
  foreach(digit in digits) {
    digit hide();
  }

  if(!level.teamBased) {
    return;
  }
  ghosts_ones_digit = GetEnt("ghosts_1_0", "targetname");
  ghosts_tens_digit = GetEnt("ghosts_2_0", "targetname");
  ghosts_hundreds_digit = GetEnt("ghosts_3_0", "targetname");
  ghosts_thousands_digit = GetEnt("ghosts_4_0", "targetname");

  federation_ones_digit = GetEnt("federation_1_0", "targetname");
  federation_tens_digit = GetEnt("federation_2_0", "targetname");
  federation_hundreds_digit = GetEnt("federation_3_0", "targetname");
  federation_thousands_digit = GetEnt("federation_4_0", "targetname");

  while(1) {
    if(level.gameType == "sd" || level.gameType == "sr" || level.gameType == "siege") {
      ghosts_score = game["roundsWon"]["allies"];
      federation_score = game["roundsWon"]["axis"];
    } else {
      ghosts_score = game["teamScores"]["allies"];
      federation_score = game["teamScores"]["axis"];
    }

    if(ghosts_score > 9999) {
      ghosts_score = 10000;
      ghosts_ones_digit setModel("shns_score_num_feds_r");
      ghosts_tens_digit setModel("shns_score_num_feds_r");
      ghosts_hundreds_digit setModel("shns_score_num_feds_e");
      ghosts_thousands_digit setModel("tag_origin");
    }
    if(federation_score > 9999) {
      federation_score = 10000;
      federation_ones_digit setModel("shns_score_num_feds_r");
      federation_tens_digit setModel("shns_score_num_feds_r");
      federation_hundreds_digit setModel("shns_score_num_feds_e");
      federation_thousands_digit setModel("tag_origin");
    }

    if(ghosts_score < 10) {
      ghosts_ones = GetSubStr(ghosts_score, 0, 1);
      ghosts_ones_digit setModel("shns_score_num_ghosts_" + ghosts_ones);
    }
    if(ghosts_score > 9 && ghosts_score < 99) {
      ghosts_ones = GetSubStr(ghosts_score, 1, 2);
      ghosts_tens = GetSubStr(ghosts_score, 0, 1);
      ghosts_ones_digit setModel("shns_score_num_ghosts_" + ghosts_ones);
      ghosts_tens_digit setModel("shns_score_num_ghosts_" + ghosts_tens);
    }
    if(ghosts_score > 99 && ghosts_score < 999) {
      ghosts_ones = GetSubStr(ghosts_score, 2, 3);
      ghosts_tens = GetSubStr(ghosts_score, 1, 2);
      ghosts_hundreds = GetSubStr(ghosts_score, 0, 1);
      ghosts_ones_digit setModel("shns_score_num_ghosts_" + ghosts_ones);
      ghosts_tens_digit setModel("shns_score_num_ghosts_" + ghosts_tens);
      ghosts_hundreds_digit setModel("shns_score_num_ghosts_" + ghosts_hundreds);
    }
    if(ghosts_score > 999 && ghosts_score <= 9999) {
      ghosts_ones = GetSubStr(ghosts_score, 3, 4);
      ghosts_tens = GetSubStr(ghosts_score, 2, 3);
      ghosts_hundreds = GetSubStr(ghosts_score, 1, 2);
      ghosts_thousands = GetSubStr(ghosts_score, 0, 1);
      ghosts_ones_digit setModel("shns_score_num_ghosts_" + ghosts_ones);
      ghosts_tens_digit setModel("shns_score_num_ghosts_" + ghosts_tens);
      ghosts_hundreds_digit setModel("shns_score_num_ghosts_" + ghosts_hundreds);
      ghosts_thousands_digit setModel("shns_score_num_ghosts_" + ghosts_thousands);
    }

    if(federation_score < 10) {
      federation_ones = GetSubStr(federation_score, 0, 1);
      federation_ones_digit setModel("shns_score_num_feds_" + federation_ones);
    }
    if(federation_score > 9 && federation_score < 99) {
      federation_ones = GetSubStr(federation_score, 1, 2);
      federation_tens = GetSubStr(federation_score, 0, 1);
      federation_ones_digit setModel("shns_score_num_feds_" + federation_ones);
      federation_tens_digit setModel("shns_score_num_feds_" + federation_tens);
    }
    if(federation_score > 99 && federation_score < 999) {
      federation_ones = GetSubStr(federation_score, 2, 3);
      federation_tens = GetSubStr(federation_score, 1, 2);
      federation_hundreds = GetSubStr(federation_score, 0, 1);
      federation_ones_digit setModel("shns_score_num_feds_" + federation_ones);
      federation_tens_digit setModel("shns_score_num_feds_" + federation_tens);
      federation_hundreds_digit setModel("shns_score_num_feds_" + federation_hundreds);
    }
    if(federation_score > 999 && federation_score <= 9999) {
      federation_ones = GetSubStr(federation_score, 3, 4);
      federation_tens = GetSubStr(federation_score, 2, 3);
      federation_hundreds = GetSubStr(federation_score, 1, 2);
      federation_thousands = GetSubStr(federation_score, 0, 1);
      federation_ones_digit setModel("shns_score_num_feds_" + federation_ones);
      federation_tens_digit setModel("shns_score_num_feds_" + federation_tens);
      federation_hundreds_digit setModel("shns_score_num_feds_" + federation_hundreds);
      federation_thousands_digit setModel("shns_score_num_feds_" + federation_thousands);
    }

    wait 0.5;
  }
}

check_for_player_connect() {
  while(1) {
    level waittill("connected", player);
    player thread run_func_after_spawn(::kill_watcher);

  }
}

run_func_after_spawn(func) {
  self endon("disconnect");
  self endon("death");

  self waittill("spawned_player");

  self thread[[func]]();
}

set_up_announcer() {
  level.announcements = [];
  level.announcer_temperature = 0;

  level.announcements["big_spread"] = create_announcement_entry(6, 0, "shipment_com_ghosts_lead", "shipment_com_feds_lead");
  level.announcements["big_spread_noteam"] = create_announcement_entry(6, 0, "shipment_com_none_lead");
  level.announcements["score_unchanged"] = create_announcement_entry(6, 30, "shipment_com_score_same");
  level.announcements["close_match"] = create_announcement_entry(1, 0, "shipment_com_close_match");

  level.announcements["ks_first"] = create_announcement_entry(1, 0, "shipment_com_ghosts_spin_1st", "shipment_com_feds_spin_1st");
  level.announcements["ks_additional"] = create_announcement_entry(0, 0, "shipment_com_ghosts_spin_addtl", "shipment_com_feds_spin_addtl");
  level.announcements["ks_first_noteam"] = create_announcement_entry(1, 0, "shipment_com_none_spin_1st");
  level.announcements["ks_additional_noteam"] = create_announcement_entry(0, 0, "shipment_com_none_spin_addtl");
  level.announcements["trap_1"] = create_announcement_entry(0, 0, "shipment_com_ghosts_gas", "shipment_com_feds_gas");
  level.announcements["trap_1_noteam"] = create_announcement_entry(0, 0, "shipment_com_none_gas");
  level.announcements["all_traps"] = create_announcement_entry(0, 0, "shipment_com_ghosts_traps", "shipment_com_feds_traps");
  level.announcements["all_traps_noteam"] = create_announcement_entry(0, 0, "shipment_com_none_traps");
  level.announcements["turrets"] = create_announcement_entry(0, 0, "shipment_com_ghosts_cleanse", "shipment_com_feds_cleanse");
  level.announcements["turrets_noteam"] = create_announcement_entry(0, 0, "shipment_com_none_cleanse");
  level.announcements["care_strike"] = create_announcement_entry(0, 0, "shipment_com_ghosts_jackpot", "shipment_com_feds_jackpot");
  level.announcements["care_strike_noteam"] = create_announcement_entry(0, 0, "shipment_com_none_jackpot");
  level.announcements["kem_strike"] = create_announcement_entry(0, 0, "shipment_com_ghosts_kem", "shipment_com_feds_kem");

  level.announcements["multikill"] = create_announcement_entry(3, 30, "shipment_com_multikill_female", "shipment_com_multikill_male");
  level.announcements["killstreak"] = create_announcement_entry(10, 60, "shipment_com_killstreak_female", "shipment_com_killstreak_male");

  level.announcements["back_shot_noteam"] = create_announcement_entry(0, 15, "shipment_com_none_intheback");
  level.announcements["pistol_kill_noteam"] = create_announcement_entry(0, 15, "shipment_com_none_pistol_kill");

  level.announcements["generic_kill"] = create_announcement_entry(0, 15, "shipment_com_generic");

  level.announcements["melee_kill"] = create_announcement_entry(0, 20, "shipment_com_ghosts_melee", "shipment_com_feds_melee");
  level.announcements["melee_kill_noteam"] = create_announcement_entry(0, 20, "shipment_com_none_melee");
  level.announcements["headshot"] = create_announcement_entry(0, 20, "shipment_com_ghosts_headshot", "shipment_com_feds_headshot");
  level.announcements["headshot_noteam"] = create_announcement_entry(0, 20, "shipment_com_none_headshot");
  level.announcements["dog_kill"] = create_announcement_entry(0, 10, "shipment_com_ghosts_dogkill", "shipment_com_feds_dogkill");
  level.announcements["dog_kill_noteam"] = create_announcement_entry(0, 10, "shipment_com_none_dogkill");
  level.announcements["long_shot"] = create_announcement_entry(0, 20, "shipment_com_ghosts_longshot", "shipment_com_feds_longshot");
  level.announcements["long_shot_noteam"] = create_announcement_entry(0, 20, "shipment_com_none_longshot");
  level.announcements["double_kill"] = create_announcement_entry(0, 15, "shipment_com_ghosts_doublekill", "shipment_com_feds_doublekill");
  level.announcements["double_kill_noteam"] = create_announcement_entry(0, 15, "shipment_com_none_doublekill");
  level.announcements["triple_kill"] = create_announcement_entry(6, 40, "shipment_com_ghosts_triplekill", "shipment_com_feds_triplekill");
  level.announcements["triple_kill_noteam"] = create_announcement_entry(6, 40, "shipment_com_none_triplekill");

  level.announcements["savior"] = create_announcement_entry(10, 20, "shipment_com_ghosts_savior", "shipment_com_feds_savior");
  level.announcements["savior_noteam"] = create_announcement_entry(10, 20, "shipment_com_none_savior");
  level.announcements["avenger"] = create_announcement_entry(10, 20, "shipment_com_ghosts_avenger", "shipment_com_feds_avenger");
  level.announcements["avenger_noteam"] = create_announcement_entry(10, 20, "shipment_com_none_avenger");

  level.announcements["doors_opened"] = create_announcement_entry(1, 0, "shipment_com_doors_opened");
  level.announcements["intro"] = create_announcement_entry(1, 0, "shipment_com_intro");
  level.announcements["outro"] = create_announcement_entry(1, 0, "shipment_com_outro");
  level.announcements["outro_rare"] = create_announcement_entry(1, 0, "shipment_com_outro_rare");
  level.announcements["puzzle_box"] = create_announcement_entry(3, 60, "shipment_com_puzzlebox");
  level.announcements["puzzle_box_max"] = create_announcement_entry(1, 0, "shipment_com_100_puzzlebox");

  if(level.teambased && level.gametype != "siege" && level.gametype != "sr" && level.gametype != "sd") {
    thread determine_score_big_lead();
  }
  if(!level.teamBased) {
    thread determine_score_big_lead_noteam();
  }
  thread determine_close_match();
  thread manage_announcements();
  thread announcement_time_incrementer();
  thread intro_announcements();

  flag_init("ready_to_announce");
  flag_set("ready_to_announce");
}

create_announcement_entry(max_reps, cooldown, lines_0, lines_1, lines_2, lines_3) {
  entry = spawnStruct();
  entry.reps = 0;
  entry.max_reps = max_reps;
  entry.temperature = 0;
  entry.cooldown = cooldown;

  entry.lines = [];
  entry.lines[entry.lines.size] = lines_0;
  entry.lines[entry.lines.size] = lines_1;
  entry.lines[entry.lines.size] = lines_2;
  entry.lines[entry.lines.size] = lines_3;

  return entry;
}

manage_announcements() {
  speakers = getEntArray("announcer_speaker", "targetname");
  ANNOUNCER_COOLDOWN = 6;
  level.last_announcement_type = "default";

  while(1) {
    if(isDefined(level.players)) {
      break;
    }
    wait 1;
  }

  while(1) {
    level waittill("announcement", type, team, gender, override);

    if(!isDefined(level.announcements)) {
      continue;
    }
    if(level.last_announcement_type == type && type != "generic_kill") {
      continue;
    }
    if(level.showingFinalKillcam == true) {
      continue;
    }
    if((level.announcements[type].reps >= level.announcements[type].max_reps && level.announcements[type].max_reps != 0) || (level.announcements[type].temperature > 0 && level.announcements[type].cooldown != 0)) {
      continue;
    }
    if(!flag("ready_to_announce")) {
      if(!isDefined(override)) {
        continue;
      }
      else {
        level waittill_notify_or_timeout("allow_override", 5);
      }
    }

    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

    if(isDefined(gender)) {
      if(isDefined(team)) {
        if(gender == true) {
          if(team == "axis") {
            lines = level.announcements[type].lines[2];
          }

          else {
            lines = level.announcements[type].lines[0];
          }
        } else {
          if(team == "axis") {
            lines = level.announcements[type].lines[3];
          }

          else {
            lines = level.announcements[type].lines[1];
          }
        }
      } else {
        if(gender == true) {
          lines = level.announcements[type].lines[0];
        } else {
          lines = level.announcements[type].lines[1];
        }
      }
    } else {
      if(isDefined(team) && level.gameType != "dm") {
        if(team == "axis") {
          lines = level.announcements[type].lines[1];
        } else {
          lines = level.announcements[type].lines[0];
        }
      } else {
        lines = level.announcements[type].lines[0];
      }
    }

    foreach(speaker in speakers) {
      speaker playSound(lines);
      level.announcements[type].reps++;
      level.time_since_last_announcement = 0;
    }

    if(type != "outro" && type != "outro_rare") {
      level.last_announcement_type = type;
      flag_clear("ready_to_announce");

      thread allow_announcement_override(lines);
      if(type == "generic_kill") {
        thread announcer_cooldown_manager(2);
      }
      else {
        thread announcer_cooldown_manager(ANNOUNCER_COOLDOWN);
      }
      level.announcements[type] thread announcement_cooldown();
    } else
      level endon("game_ended");
  }
}

announcement_time_incrementer() {
  level.time_since_last_announcement = 0;
  while(1) {
    wait 1;
    level.time_since_last_announcement++;
  }
}

allow_announcement_override(lines) {
  vo_time = LookupSoundLength(lines);
  wait(vo_time / 1000) + 0.1;
  level notify("allow_override");
}

announcement_cooldown() {
  self.temperature = self.cooldown;

  while(self.temperature > 0) {
    self.temperature--;
    wait 1;
  }
}

announcer_cooldown_manager(cooldown) {
  if(level.announcer_temperature > cooldown) {
    return;
  }
  level.announcer_temperature = cooldown;

  level notify("announcer_time_reset");
  level endon("announcer_time_reset");

  while(1) {
    if(level.announcer_temperature <= 0) {
      wait RandomFloatRange(0, 3);
      flag_set("ready_to_announce");
      return;
    }
    level.announcer_temperature--;
    wait 1;
  }
}

intro_announcements() {
  while(!isDefined(level.gametypestarted)) {
    wait(0.05);
  }
  wait 18;
  level notify("announcement", "intro", undefined, undefined, true);
}

kill_watcher() {
  self endon("disconnect");
  level endon("game_ended");

  level.last_announcer_line = "default";

  isfemale = self hasFemaleCustomizationModel();

  while(1) {
    if(level.gametype != "horde") {
      self waittill("got_a_kill", victim, weapon, meansOfDeath);
    }
    else {
      self waittill("horde_kill", victim, weapon, meansOfDeath);
    }

    if(level.time_since_last_announcement > 18) {
      level notify("announcement", "generic_kill", undefined, undefined);
    } else {
      curTime = getTime();

      if(weaponClass(weapon) == "pistol" && meansOfDeath != "MOD_MELEE" && level.last_announcer_line != "pistol") {
        level notify("announcement", "pistol_kill_noteam", undefined, undefined);

        level.last_announcer_line = "pistol";

        continue;
      }
      if(meansOfDeath == "MOD_MELEE" && level.last_announcer_line != "mod_melee") {
        if(level.teamBased) {
          if(cointoss()) {
            level notify("announcement", "melee_kill", self.team, undefined);
          }
          else {
            level notify("announcement", "melee_kill_noteam", undefined, undefined);
          }
        } else
          level notify("announcement", "melee_kill_noteam", undefined, undefined);

        level.last_announcer_line = "mod_melee";

        continue;
      }
      if(meansOfDeath == "MOD_HEAD_SHOT" && level.last_announcer_line != "mod_head_shot") {
        if(level.teamBased) {
          level notify("announcement", "headshot", self.team, undefined);
        }
        else {
          level notify("announcement", "headshot_noteam", undefined, undefined);
        }

        level.last_announcer_line = "mod_head_shot";

        continue;
      }
      if(weapon == "guard_dog_mp" && level.last_announcer_line != "guard_dog_mp") {
        if(level.teamBased) {
          level notify("announcement", "dog_kill", self.team, undefined);
        }
        else {
          level notify("announcement", "dog_kill_noteam", undefined, undefined);
        }

        level.last_announcer_line = "guard_dog_mp";

        continue;
      }
      if(maps\mp\_events::isLongShot(self, weapon, meansOfDeath, self.origin, victim) && level.last_announcer_line != "long_shot") {
        if(level.teamBased) {
          level notify("announcement", "long_shot", self.team, undefined);
        }
        else {
          level notify("announcement", "long_shot_noteam", undefined, undefined);
        }

        level.last_announcer_line = "long_shot";

        continue;
      }
      if(self.recentKillCount == 2) {
        if(level.teamBased) {
          level notify("announcement", "double_kill", self.team, undefined);
        }
        else {
          level notify("announcement", "double_kill_noteam", undefined, undefined);
        }
      }
      if(level.gameType != "horde") {
        if(self isBackShot(victim) && level.last_announcer_line != "back_shot") {
          level notify("announcement", "back_shot_noteam", undefined, undefined);

          level.last_announcer_line = "back_shot";
        }
        if(self isSavior(victim, curTime) && level.last_announcer_line != "savior") {
          if(level.teamBased) {
            level notify("announcement", "savior", self.team, undefined);
          }
          else {
            level notify("announcement", "savior_noteam", undefined, undefined);
          }

          level.last_announcer_line = "savior";
        }
        if(level.teamBased && curTime - victim.lastKillTime < 500 && level.last_announcer_line != "avenger") {
          if(victim.lastkilledplayer != self) {
            if(level.teamBased) {
              level notify("announcement", "avenger", self.team, undefined);
            }
            else {
              level notify("announcement", "avenger_noteam", undefined, undefined);
            }

            level.last_announcer_line = "avenger";
          }
        }
      }
      if(self.recentKillCount == 3) {
        if(level.teamBased) {
          level notify("announcement", "triple_kill", self.team, undefined);
        }
        else {
          level notify("announcement", "triple_kill_noteam", undefined, undefined);
        }
      }
      if(self.recentKillCount >= 4) {
        level notify("announcement", "multikill", undefined, undefined);
      }
      if(self.adrenaline >= 5) {
        level notify("announcement", "killstreak", undefined, undefined);
      }
    }

    wait 0.1;
  }
}

isBackShot(victim) {
  vAngles = victim.anglesOnDeath[1];
  pAngles = self.anglesOnKill[1];
  angleDiff = AngleClamp180(vAngles - pAngles);
  if(abs(angleDiff) < 65) {
    return true;
  } else {
    return false;
  }
}

isSavior(victim, curTime) {
  foreach(guid, damageTime in victim.damagedPlayers) {
    if(guid == self.guid) {
      continue;
    }
    if(level.teamBased && curTime - damageTime < 500) {
      return true;
    }
  }

  return false;
}

determine_close_match() {
  timelimit = getTimeLimit() * 60;
  scorelimit = getScoreLimit();

  if(level.gameType == "blitz") {
    scorelimit = getWatchedDvar("scorelimit");
  }

  if(timelimit < 60 || scorelimit == 0) {
    return;
  }
  threshold = max(5, scorelimit / 20);
  thread match_nearly_over(scorelimit);

  waittill_notify_or_timeout("score_limit_almost_reached", timelimit - 25);
  if(abs(GetTeamScore("allies") - GetTeamScore("axis")) < threshold) {
    level notify("announcement", "close_match");
  }
}

match_nearly_over(scorelimit) {
  percentage = .90;

  while(1) {
    ghosts_score = GetTeamScore("allies");
    federation_score = GetTeamScore("axis");

    if(ghosts_score > scorelimit * .90 || federation_score > scorelimit * .90) {
      level notify("score_limit_almost_reached");
      break;
    }
    wait .25;
  }
}

determine_score_big_lead() {
  level endon("game_ended");
  scorelimit = getScoreLimit();

  if(level.gameType == "blitz") {
    scorelimit = getWatchedDvar("scorelimit");
  }

  if(scorelimit == 0) {
    return;
  }
  threshold = scorelimit * .50;
  old_ghosts_score = 0;
  old_federation_score = 0;
  time_since_score_changed = 0;
  unchanged_threshold = 30;

  while(1) {
    ghosts_score = GetTeamScore("allies");
    federation_score = GetTeamScore("axis");

    time = GetTime();

    if(ghosts_score == old_ghosts_score && federation_score == old_federation_score && time > 60000) {
      time_since_score_changed++;
    }

    else {
      time_since_score_changed = 0;
    }

    if(time_since_score_changed > unchanged_threshold) {
      level notify("announcement", "score_unchanged");
      time_since_score_changed = 0;
    }

    spread = abs(ghosts_score - federation_score);
    if(spread > threshold) {
      if(ghosts_score > federation_score) {
        level notify("announcement", "big_spread", "ghosts");
        return;
      } else {
        level notify("announcement", "big_spread", "federation");
        return;
      }
    }
    old_ghosts_score = ghosts_score;
    old_federation_score = federation_score;
    wait 1;
  }
}

determine_score_big_lead_noteam() {
  level endon("game_ended");
  scorelimit = getScoreLimit();

  if(level.gameType == "blitz") {
    scorelimit = getWatchedDvar("scorelimit");
  }

  if(scorelimit == 0) {
    return;
  }
  while(1) {
    if(isDefined(level.players)) {
      players_sorted_by_score = [];

      players_sorted_by_score = array_sort_with_func(level.players, ::is_score_a_greater_than_b);

      if(players_sorted_by_score.size >= 2) {
        if(players_sorted_by_score[0].score - players_sorted_by_score[1].score > scorelimit / 2)
      }

      {
        level notify("announcement", "big_spread_noteam");
        return;
      }
    }
    wait 1;
  }
}

randomizer_create(array) {
  Assert(array.size != 0);
  randomizer = spawnStruct();
  randomizer.array = array;
  return randomizer;
}

randomizer_get_no_repeat() {
  Assert(self.array.size > 0);

  index = undefined;
  if(self.array.size > 1 && isDefined(self.last_index)) {
    index = RandomInt(self.array.size - 1);
    if(index >= self.last_index) {
      index++;
    }
  } else {
    index = RandomInt(self.array.size);
  }
  self.last_index = index;
  return self.array[index];
}

rotate_turntable() {
  turntable = GetEnt("showcase_turntable", "targetname");
  prizes = getEntArray("showcase_prize", "targetname");

  foreach(prize in prizes) {
    prize LinkTo(turntable);
  }

  while(1) {
    turntable RotateYaw(360, 20);
    wait 20;
  }
}

KILLSTREAK_WEIGHT = 2000;

CustomCrateFunc() {
  level.allow_level_killstreak = allowLevelKillstreaks();
  if(!level.allow_level_killstreak) {
    return;
  }
  maps\mp\killstreaks\_airdrop::addCrateType("airdrop_assault", "slot_machine", KILLSTREAK_WEIGHT, maps\mp\killstreaks\_airdrop::killstreakCrateThink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::get_enemy_crate_model(), &"MP_DLC_13_KILLSTREAK_PICKUP");

  level thread killstreak_watch_for_crate();
}

killstreak_watch_for_crate() {
  while(1) {
    level waittill("createAirDropCrate", dropCrate);
    if(isDefined(dropCrate) && isDefined(dropCrate.crateType) && dropCrate.crateType == "slot_machine") {
      killstreak_set_weight(0);
      captured = wait_for_capture(dropCrate);
      if(!isDefined(captured)) {
        killstreak_set_weight(KILLSTREAK_WEIGHT);
      } else {
        game["player_holding_level_killstreak"] = captured;
      }
    }
  }
}

wait_for_capture(dropCrate) {
  result = watch_for_air_drop_death(dropCrate);
  return result;
}

watch_for_air_drop_death(dropCrate) {
  dropCrate endon("death");

  dropCrate waittill("captured", player);
  return player;
}

killstreak_set_weight(WEIGHT) {
  if(isDefined(game["player_holding_level_killstreak"]) && IsAlive(game["player_holding_level_killstreak"])) {
    return false;
  }

  maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", "slot_machine", WEIGHT);
}

CustomKillstreakFunc() {
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Killstreak:5/Care Package/Slot Machine\" \"set scr_devgivecarepackage slot_machine; set scr_devgivecarepackagetype airdrop_assault\"\n");
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Killstreak:5/_Slot Machine/_Slot Machine\" \"set scr_givekillstreak slot_machine\"\n");
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Killstreak:5/_Slot Machine/Gas Trap\" \"set scr_trap_1 1\"\n");
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Killstreak:5/_Slot Machine/All Traps\" \"set scr_all_traps 1\"\n");
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Killstreak:5/_Slot Machine/Multi-Turret\" \"set scr_multiturret 1\"\n");
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Killstreak:5/_Slot Machine/Care Strike\" \"set scr_carestrike 1\"\n");

  level.killstreakWeildWeapons["killstreak_level_event_mp"] = "slot_machine";

  level.killStreakFuncs["slot_machine"] = ::tryUseKillstreak;

  thread debug_prizes();
}

CustomBotKillstreakFunc() {
  AddDebugCommand("devgui_cmd\"MP/Bots(Killstreak)/Level Killstreak:5/Slot Machine\" \"set scr_testclients_givekillstreak slot_machine\"\n");
  maps\mp\bots\_bots_ks::bot_register_killstreak_func("slot_machine", maps\mp\bots\_bots_ks::bot_killstreak_simple_use);
}

tryUseKillstreak(lifeId, streakName) {
  level notify("killstreak_activate", self);

  return true;
}

select_random_prize() {
  prizes = [];
  trap_1_range = 30;
  all_traps_range = trap_1_range + 15;
  turrets_range = all_traps_range + 25;
  care_strike_range = turrets_range + 25;
  kem_strike_range = care_strike_range + 5;

  Assert(kem_strike_range == 100);

  while(1) {
    level waittill("killstreak_activate", player);

    flag_set("ready_to_announce");
    level notify("allow_override");

    if(!flag("killstreak_additional")) {
      if(level.teamBased) {
        level notify("announcement", "ks_first", player.team, undefined, true);
      }
      else {
        level notify("announcement", "ks_first_noteam", undefined, undefined, true);
      }
      flag_set("killstreak_additional");
    } else {
      if(level.teamBased) {
        level notify("announcement", "ks_additional", player.team, undefined, true);
      }
      else {
        level notify("announcement", "ks_additional_noteam", undefined, undefined, true);
      }
    }

    number = RandomIntRange(0, 100);

    result = "null";
    result_name = "null";

    if(number <= trap_1_range) {
      result = "trap_1";
    }
    if(number >= trap_1_range && number <= all_traps_range) {
      result = "all_traps";
    }
    if(number >= all_traps_range && number <= turrets_range) {
      result = "turrets";
    }
    if(number >= turrets_range && number <= care_strike_range) {
      result = "care_strike";
    }
    if(number >= care_strike_range && number <= kem_strike_range) {
      result = "kem_strike";
    }

    if((result == "care_strike" || result == "all_traps") && level.carePackages.size > 0) {
      result = "trap_1";
    }

    if(flag("turrets_active") && (result == "all_traps" || result == "turrets")) {
      result = "trap_1";
    }

    switch (result) {
      case "trap_1":
        flag_set("trap_1_active");
        thread manage_trap_1_area_spawns();
        result_name = "Gas Trap";

        exploder(24);
        thread play_gas_jet_fx();
        thread play_slot_machine_sfx();
        jumbotron_play_slot_machine_bink("mp_shipment_ns_trap_1_prize", 5);

        if(isDefined(player)) {
          player thread trap_activate(level.trap_1, 25, 0, 1, 12, true);
        }
        break;
      case "all_traps":
        result_name = "All Traps";
        flag_set("trap_1_active");
        thread manage_trap_1_area_spawns();

        exploder(26);
        thread play_gas_jet_fx();
        thread play_slot_machine_sfx(true);
        jumbotron_play_slot_machine_bink("mp_shipment_ns_all_traps_prize", 5);

        if(isDefined(player)) {
          player thread trap_activate(level.trap_1, 25, 0, 1, 12, true);
        }
        wait 0.5;
        player thread multi_turret(15);
        wait 1.2;
        player thread carestrike_setup();
        break;
      case "turrets":
        result_name = "Arena Cleanse";

        exploder(22);
        thread play_slot_machine_sfx();
        jumbotron_play_slot_machine_bink("mp_shipment_ns_turret_prize", 5);

        if(isDefined(player)) {
          player thread multi_turret(15);
        }
        break;
      case "care_strike":
        result_name = "Carestrike";

        exploder(23);
        thread play_slot_machine_sfx();
        jumbotron_play_slot_machine_bink("mp_shipment_ns_care_prize", 5);

        if(isDefined(player)) {
          player thread carestrike_setup();
        }
        break;
      case "kem_strike":
        result_name = "K.E.M. Strike";

        exploder(25);
        thread play_slot_machine_sfx();
        jumbotron_play_slot_machine_bink("mp_shipment_ns_kem_prize", 5);

        if(isDefined(player)) {
          player thread maps\mp\killstreaks\_nuke::doNuke();
        }
        break;
    }

    if(!level.teamBased && (result != "kem_strike")) {
      result = result + "_noteam";
    }

    flag_set("ready_to_announce");
    level notify("allow_override");
    waittillframeend;
    level notify("announcement", result, player.team, undefined, true);

    game["player_holding_level_killstreak"] = undefined;
    killstreak_set_weight(KILLSTREAK_WEIGHT);
  }
}

nuke_custom_visionset() {
  level waittill("nuke_death");

  wait 1.3;

  level notify("nuke_death");

  thread nuke_custom_visionset();
}

play_slot_machine_sfx(jackpot) {
  if(isDefined(jackpot)) {
    thread play_sound_in_space("emt_slot_machine_dist_jackpot", (-38, -1357, 1261));

    thread play_sound_in_space("emt_slot_machine_jackpot", (-117, -211, 263));
    thread play_sound_in_space("emt_slot_machine_jackpot", (-741, -381, 347));
    thread play_sound_in_space("emt_slot_machine_jackpot", (-323, 179, 258));
    thread play_sound_in_space("emt_slot_machine_jackpot", (-744, 492, 342));
    thread play_sound_in_space("emt_slot_machine_jackpot", (-420, 750, 342));
    thread play_sound_in_space("emt_slot_machine_jackpot", (114, 344, 259));
    thread play_sound_in_space("emt_slot_machine_jackpot", (414, 745, 341));
    thread play_sound_in_space("emt_slot_machine_jackpot", (720, 505, 341));
    thread play_sound_in_space("emt_slot_machine_jackpot", (321, -52, 255));
    thread play_sound_in_space("emt_slot_machine_jackpot", (721, -346, 348));
    thread play_sound_in_space("emt_slot_machine_jackpot", (464, -617, 348));
  } else {
    thread play_sound_in_space("emt_slot_machine_dist", (-38, -1357, 1261));

    thread play_sound_in_space("emt_slot_machine", (-117, -211, 263));
    thread play_sound_in_space("emt_slot_machine", (-741, -381, 347));
    thread play_sound_in_space("emt_slot_machine", (-323, 179, 258));
    thread play_sound_in_space("emt_slot_machine", (-744, 492, 342));
    thread play_sound_in_space("emt_slot_machine", (-420, 750, 342));
    thread play_sound_in_space("emt_slot_machine", (114, 344, 259));
    thread play_sound_in_space("emt_slot_machine", (414, 745, 341));
    thread play_sound_in_space("emt_slot_machine", (720, 505, 341));
    thread play_sound_in_space("emt_slot_machine", (321, -52, 255));
    thread play_sound_in_space("emt_slot_machine", (721, -346, 348));
    thread play_sound_in_space("emt_slot_machine", (464, -617, 348));
  }
}

trap_init() {
  level.trap_1 = spawnStruct();
  level.trap_1.inflictor = GetEnt("trap_1_origin", "targetname");
  level.trap_1.volume = GetEnt("trap_1_volume", "targetname");
  level.trap_1.destructibles = [(481, -74, -100)];
  level.trap_1.player = undefined;
  level.trap_1.team = undefined;
  level.trap_1.exploder = 91;
  level.trap_1.flag = "trap_1_active";

  flag_init("trap_1_active");
  flag_init("jumbotron_available");
  flag_init("killstreak_can_kill");
  flag_init("killstreak_additional");
  flag_init("turrets_active");
  flag_init("played_easter_egg_video");

  thread gas_visionset_cleanup();
}

gas_visionset_cleanup() {
  wait 2.5;
  while(level.players.size == 0) {
    wait .1;
  }

  level.vision_set_stage = 0;

  foreach(player in level.players) {
    player VisionSetStage(level.vision_set_stage, 2);
  }
}

trap_activate(trap, character_damage, equipment_damage, frequency, duration, loop_fx) {
  level notify("gas_trap_activated");
  level endon("gas_trap_activated");
  level endon("game_ended");

  flag_set(trap.flag);

  trap.player = self;
  trap.team = self.pers["team"];

  BadPlace_Brush("badplace_trap", duration, trap.volume, "allies", "axis");

  exploder(trap.exploder);
  if(trap == level.trap_1) {
    thread gas_trap_sfx();
    thread gas_trap_vision();
  }

  for(elapsed = 0; elapsed < duration; elapsed += frequency) {
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

    if(isDefined(loop_fx)) {
      exploder(trap.exploder);
    }

    attacker = trap.player;
    if(!isDefined(trap.player) || !IsPlayer(trap.player)) {
      attacker = undefined;
    }

    thread damage_characters(trap, attacker, character_damage);

    wait frequency;
  }

  trap.player = undefined;
  trap.team = undefined;

  common_scripts\_exploder::stop_exploder_proc(trap.exploder);

  wait 1;

  flag_clear(trap.flag);
}

play_gas_jet_fx() {
  wait 3;
  exploder(92);
}

gas_trap_vision() {
  level.vision_set_stage = 1;

  foreach(player in level.players) {
    player VisionSetStage(level.vision_set_stage, 0.5);
  }

  thread stop_gas_trap_vision();
}

stop_gas_trap_vision() {
  wait 12;

  level.vision_set_stage = 0;

  foreach(player in level.players) {
    player VisionSetStage(level.vision_set_stage, 2);
  }
}

gas_trap_sfx() {
  play_sound_in_space("scn_shp_gas_trap", (-287, 1021, 244));
  play_sound_in_space("scn_shp_gas_trap", (286, 1021, 244));

  play_sound_in_space("scn_shp_gas_trap", (354, -743, 250));
  play_sound_in_space("scn_shp_gas_trap", (-316, -730, 250));
  play_sound_in_space("scn_shp_gas_trap", (-6, -1084, 357));
  play_sound_in_space("scn_shp_gas_trap", (-553, -968, 250));
}

damage_characters(trap, attacker, damage) {
  victims = trap.volume GetIsTouchingEntities(level.characters);

  foreach(victim in victims) {
    if(victim _hasPerk("_specialty_blastshield")) {
      damage *= 1.6;
    }

    if(can_kill_character(trap, victim) && isDefined(attacker)) {
      if(victim.team != trap.team || level.friendlyfire) {
        trap.inflictor RadiusDamage(victim.origin, 10, damage, damage, attacker, "MOD_PROJECTILE_SPLASH", "killstreak_level_event_mp");

      } else if(victim == attacker)
        trap.inflictor RadiusDamage(victim.origin, 10, damage, damage, attacker, "MOD_PROJECTILE_SPLASH", "killstreak_level_event_mp");
    }

    wait(0.05);
  }

}

can_kill_character(trap, victim) {
  if(!isDefined(victim) || !isReallyAlive(victim)) {
    return false;
  }

  if(level.teambased) {
    if(isDefined(trap.player) && victim == trap.player) {
      return true;
    }

    else if(isDefined(trap.player) && isDefined(victim.owner) && victim.owner == trap.player) {
      return true;
    }

    else if(isDefined(trap.team) && victim.team == trap.team && !level.friendlyfire) {
      return false;
    }
  }

  return true;
}

damage_targets(trap, attacker, array_targets, damage) {
  meansOfDeath = "MOD_EXPLOSIVE";
  weapon = "none";
  direction_vec = (0, 0, 0);
  point = (0, 0, 0);
  modelName = "";
  tagName = "";
  partName = "";
  iDFlags = undefined;

  targets = trap.volume GetIsTouchingEntities(array_targets);

  foreach(target in targets) {
    if(!isDefined(target)) {
      continue;
    }
    if(isDefined(target.owner) && target.owner == trap.owner) {
      target notify("damage", damage, attacker, direction_vec, point, meansOfDeath, modelName, tagName, partName, iDFlags, weapon);
    }

    else if(level.teamBased && isDefined(trap.team) && isDefined(target.team) && target.team == trap.team) {
      continue;
    }
    target notify("damage", damage, attacker, direction_vec, point, meansOfDeath, modelName, tagName, partName, iDFlags, weapon);
    wait(0.05);
  }
}

set_up_multi_turret() {
  level.sentryType["multiturret"] = "multiturret";

  level.sentrySettings["multiturret"] = spawnStruct();
  level.sentrySettings["multiturret"].health = 999999;
  level.sentrySettings["multiturret"].maxHealth = 1000;
  level.sentrySettings["multiturret"].burstMin = 20;
  level.sentrySettings["multiturret"].burstMax = 120;
  level.sentrySettings["multiturret"].pauseMin = 0.0;
  level.sentrySettings["multiturret"].pauseMax = 0.01;
  level.sentrySettings["multiturret"].sentryModeOn = "sentry";
  level.sentrySettings["multiturret"].sentryModeOff = "sentry_offline";
  level.sentrySettings["multiturret"].timeOut = 90.0;
  level.sentrySettings["multiturret"].spinupTime = 0.05;
  level.sentrySettings["multiturret"].overheatTime = 15.0;
  level.sentrySettings["multiturret"].cooldownTime = 0.1;
  level.sentrySettings["multiturret"].fxTime = 0.3;
  level.sentrySettings["multiturret"].streakName = "sentry";
  level.sentrySettings["multiturret"].weaponInfo = "sentry_minigun_mp";
  level.sentrySettings["multiturret"].modelBase = "weapon_sentry_chaingun";
  level.sentrySettings["multiturret"].modelPlacement = "weapon_sentry_chaingun_obj";
  level.sentrySettings["multiturret"].modelPlacementFailed = "weapon_sentry_chaingun_obj_red";
  level.sentrySettings["multiturret"].modelBombSquad = "weapon_sentry_chaingun_bombsquad";
  level.sentrySettings["multiturret"].modelDestroyed = "weapon_sentry_chaingun_destroyed";
  level.sentrySettings["multiturret"].hintString = &"";
  level.sentrySettings["multiturret"].headIcon = true;
  level.sentrySettings["multiturret"].teamSplash = "used_sentry";
  level.sentrySettings["multiturret"].shouldSplash = false;
  level.sentrySettings["multiturret"].voDestroyed = undefined;
  level.sentrySettings["multiturret"].xpPopup = "destroyed_sentry";
  level.sentrySettings["multiturret"].lightFXTag = "tag_fx";
}

multi_turret(duration) {
  flag_set("turrets_active");
  locations = getEntArray("turret_killstreak_location", "targetname");
  foreach(location in locations) {
    thread generate_turret(duration, location);
  }

  shutters = getEntArray("turret_shutter", "targetname");
  foreach(shutter in shutters) {
    shutter NotSolid();
  }

  thread turret_box_light_fx();

  thread sfx_turret_shutters_open();
  move_shutter_array(shutters, "open", .25);

  wait duration - .25;

  thread sfx_turret_shutters_close();
  move_shutter_array(shutters, "close", .25);

  foreach(shutter in shutters) {
    shutter Solid();
  }
  flag_clear("turrets_active");
}

generate_turret(duration, location) {
  sentryGun = maps\mp\killstreaks\_autosentry::createSentryForPlayer("multiturret", self);

  sentryGun.shouldSplash = false;

  sentryGun.carriedBy = self;
  level.turret_team = self.pers["team"];
  sentryGun maps\mp\killstreaks\_autosentry::sentry_setPlaced();

  sentryGun.origin = location.origin;
  sentryGun.angles = location.angles;

  sentryGun.killCamEnt = spawn("script_model", sentryGun.origin + (0, 0, 64));
  sentryGun.killCamEnt LinkTo(sentryGun);

  sentryGun thread multi_turret_timeout(duration);
}

multi_turret_timeout(duration) {
  self endon("death");
  self endon("game_ended");

  wait duration;

  self TurretFireDisable();
  shutters = getEntArray("turret_shutter", "targetname");

  wait .25;

  self delete();
  self notify("death");
}

carestrike_setup() {
  spawn_location_1 = GetEnt("carestrike_spawn_1", "targetname");
  spawn_location_2 = GetEnt("carestrike_spawn_2", "targetname");
  spawn_location_3 = GetEnt("carestrike_spawn_3", "targetname");

  dropsite_1 = GetEnt("carestrike_location_1", "targetname");
  dropsite_2 = GetEnt("carestrike_location_2", "targetname");
  dropsite_3 = GetEnt("carestrike_location_3", "targetname");

  thread play_sound_in_space("mus_carestrike", (33, 92, 741));
  dropsite_1 playSound("scn_shp_carestrike_jets");

  thread jumbotron_play_slot_machine_bink("mp_shipment_ns_carestrike", 7);

  thread careStrike(self, spawn_location_1, dropsite_1, "mp_shipment_carestrike_jet_1");
  thread careStrike(self, spawn_location_2, dropsite_2, "mp_shipment_carestrike_jet_2");
  thread careStrike(self, spawn_location_3, dropsite_3, "mp_shipment_carestrike_jet_3");
}

careStrike(owner, spawn_location, dropSite, animation) {
  direction = dropSite.angles;
  dropSite = dropSite.origin;

  planeHalfDistance = 12000;
  planeFlySpeed = 4000;

  flyHeight = self maps\mp\killstreaks\_airdrop::getFlyHeightOffset(dropSite);

  pathStart = spawn_location.origin;
  pathStart = pathStart * (1, 1, 0) + (0, 0, flyHeight);

  airplane = airplaneSetup(owner, pathStart);

  airplane.angles = spawn_location.angles;
  forward = anglesToForward(direction);

  airplane ScriptModelPlayAnimDeltaMotion(animation);

  minDist = Distance2D(airplane.origin, dropSite);
  boomPlayed = false;

  switch (animation) {
    case "mp_shipment_carestrike_jet_1":
      wait .05;
      playFXOnTag(level._effect["vfx_jet_cheap_contrail_red"], airplane, "tag_body");
      break;
    case "mp_shipment_carestrike_jet_2":
      wait .1;
      airplane PlaySoundOnMovingEnt("scn_shp_carestrike_jets_mover");
      playFXOnTag(level._effect["vfx_jet_cheap_contrail_white"], airplane, "tag_body");
      break;
    case "mp_shipment_carestrike_jet_3":
      wait .15;
      playFXOnTag(level._effect["vfx_jet_cheap_contrail_blue"], airplane, "tag_body");
      break;
  }

  for(;;) {
    dist = Distance2D(airplane.origin, dropSite);

    if(dist < minDist) {
      minDist = dist;
    }
    else if(dist > minDist) {
      break;
    }

    if(dist < 256) {
      break;
    } else if(dist < 768) {
      earthquake(0.15, 1.5, dropSite, 1500);
      if(!boomPlayed) {
        boomPlayed = true;
      }
    }

    wait(.05);
  }

  dropTypes = [];
  dropTypes[0] = "airdrop_assault";
  dropTypes[1] = "airdrop_support";

  dropType = droptypes[cointoss()];
  dropCrate = airplane dropTheCrate(dropSite, dropType, flyHeight, false, undefined, pathStart, forward);

  wait(0.05);
  airplane notify("drop_crate");
  wait(0.05);

  dropType = droptypes[cointoss()];
  dropCrate = airplane dropTheCrate(dropSite, dropType, flyHeight, false, undefined, pathStart, forward);
  wait(0.05);
  airplane notify("drop_crate");

  wait(4);
  Objective_Delete(airplane.friendly_objective_number);
  _objective_delete(airplane.friendly_objective_number);
  Objective_Delete(airplane.enemy_objective_number);
  _objective_delete(airplane.enemy_objective_number);
  airplane delete();
}

dropTheCrate(dropPoint, dropType, lbHeight, dropImmediately, crateOverride, startPos, dropImpulse, previousCrateTypes, tagName, forward) {
  dropCrate = [];
  self.owner endon("disconnect");

  if(!isDefined(crateOverride)) {
    if(isDefined(previousCrateTypes)) {
      foundDupe = undefined;
      crateType = undefined;
      for(i = 0; i < 100; i++) {
        crateType = maps\mp\killstreaks\_airdrop::getCrateTypeForDropType(dropType);
        foundDupe = false;
        for(j = 0; j < previousCrateTypes.size; j++) {
          if(crateType == previousCrateTypes[j]) {
            foundDupe = true;
            break;
          }
        }
        if(foundDupe == false) {
          break;
        }
      }

      if(foundDupe == true) {
        crateType = maps\mp\killstreaks\_airdrop::getCrateTypeForDropType(dropType);
      }
    } else
      crateType = maps\mp\killstreaks\_airdrop::getCrateTypeForDropType(dropType);
  } else
    crateType = crateOverride;

  if(!isDefined(dropImpulse)) {
    dropImpulse = (RandomInt(50), RandomInt(50), RandomInt(50));
  }

  dropCrate = maps\mp\killstreaks\_airdrop::createAirDropCrate(self.owner, dropType, crateType, startPos, dropPoint);

  switch (dropType) {
    case "airdrop_mega":
    case "nuke_drop":
    case "airdrop_juggernaut":
    case "airdrop_juggernaut_recon":
    case "airdrop_juggernaut_maniac":
      dropCrate LinkTo(self, "tag_ground", (64, 32, -128), (0, 0, 0));
      break;
    case "airdrop_escort":
    case "airdrop_osprey_gunner":
      dropCrate LinkTo(self, tagName, (0, 0, 0), (0, 0, 0));
      break;
    default:
      dropCrate LinkTo(self, "tag_ground", (32, 0, 5), (0, 0, 0));
      break;
  }

  dropCrate.angles = (0, 0, 0);
  dropCrate show();
  dropSpeed = self.veh_speed;
  dropImpulse *= 50000;
  dropCrate.carestrike = true;

  self thread maps\mp\killstreaks\_airdrop::waitForDropCrateMsg(dropCrate, dropImpulse, dropType, crateType, 9999999);
  dropCrate.droppingToGround = true;
  dropcrate thread crate_drop_sfx();

  return crateType;
}

crate_drop_sfx() {
  wait 0.1;
  self PlaySoundOnMovingEnt("scn_shp_carestrike_release");
}

airplaneSetup(owner, pathStart, pathGoal) {
  airplane = spawn("script_model", pathStart);

  airplane setModel("vehicle_f15_low_nodetail_mp");

  if(!isDefined(airplane)) {
    return;
  }
  airplane.owner = owner;
  airplane.team = owner.team;

  friendlyObjID = maps\mp\gametypes\_gameobjects::getNextObjID();
  Objective_Add(friendlyObjID, "invisible", (0, 0, 0));
  Objective_Position(friendlyObjID, self.origin);
  Objective_State(friendlyObjID, "active");
  Objective_OnEntityWithRotation(friendlyObjID, airplane);
  Objective_Icon(friendlyObjID, "compass_objpoint_airstrike_friendly");

  enemyObjID = maps\mp\gametypes\_gameobjects::getNextObjID();
  Objective_Add(enemyObjID, "invisible", (0, 0, 0));
  Objective_Position(enemyObjID, self.origin);
  Objective_State(enemyObjID, "active");
  Objective_OnEntityWithRotation(enemyObjID, airplane);
  Objective_Icon(enemyObjID, "compass_objpoint_airstrike_busy");

  if(level.teamBased) {
    Objective_Team(friendlyObjID, owner.team);
    Objective_Team(enemyObjID, getOtherTeam(owner.team));
  } else {
    Objective_Player(friendlyObjID, owner GetEntityNumber());
    Objective_PlayerMask_ShowToAll(enemyObjID);
    Objective_PlayerMask_HideFrom(enemyObjID, owner GetEntityNumber());
  }

  airplane.friendly_objective_number = friendlyObjID;
  airplane.enemy_objective_number = enemyObjID;

  return airplane;
}

debug_prizes() {
  while(1) {
    if(getdvarint("scr_trap_1") == 1) {
      SetDevDvar("scr_trap_1", 0);
      flag_set("trap_1_active");
      thread manage_trap_1_area_spawns();
      jumbotron_play_slot_machine_bink("mp_shipment_ns_trap_1_prize", 5);
      level.players[0] thread trap_activate(level.trap_1, 20, 0, 1, 20, true);
    }
    if(getdvarint("scr_all_traps") == 1) {
      SetDevDvar("scr_all_traps", 0);
      flag_set("trap_1_active");
      thread manage_trap_1_area_spawns();
      jumbotron_play_slot_machine_bink("mp_shipment_ns_all_traps_prize", 5);
      level.players[0] thread trap_activate(level.trap_1, 15, 0, 1, 20, true);
      wait 0.5;
      level.players[0] thread multi_turret(15);
      wait 1.2;
      level.players[0] thread carestrike_setup();
    }
    if(getdvarint("scr_carestrike") == 1) {
      SetDevDvar("scr_carestrike", 0);
      jumbotron_play_slot_machine_bink("mp_shipment_ns_care_prize", 5);
      level.players[0] thread carestrike_setup();
    }
    if(getdvarint("scr_multiturret") == 1) {
      SetDevDvar("scr_multiturret", 0);
      jumbotron_play_slot_machine_bink("mp_shipment_ns_turret_prize", 5);
      level.players[0] thread multi_turret(15);
    }
    wait .25;
  }
}

init_cinematics() {
  thread play_random_clip();

  wait 0.05;
  level notify("cinematic_preload");
  wait 1;

  level notify("cinematic_start");
}

watch_cinematic_use(cinematic, preload, start, end) {
  if(!isDefined(cinematic)) {
    return;
  }
  level waittill(preload);
  PreloadCinematicForAll("long_loop");

  PlayCinematicForAll("mp_shipment_ns_trap_1_prize");

  wait 30;

  flag_set("jumbotron_available");

  thread jumbotron_loop_bink("mp_shipment_ns_long_loop", 33);

  static_logo = GetEnt("jumbotron_static_logo", "targetname");
  static_logo Hide();
}

play_random_clip() {
  clips = [];
  clips[clips.size] = "mp_shipment_ns_clip_01";
  clips[clips.size] = "mp_shipment_ns_clip_02";
  clips[clips.size] = "mp_shipment_ns_clip_03";
  clips[clips.size] = "mp_shipment_ns_clip_04";
  clips[clips.size] = "mp_shipment_ns_clip_05";
  clips[clips.size] = "mp_shipment_ns_clip_06";
  clips = randomizer_create(clips);

  flag_set("jumbotron_available");

  static_logo = GetEnt("jumbotron_static_logo", "targetname");
  static_logo Hide();

  while(1) {
    flag_wait("jumbotron_available");
    clip = clips randomizer_get_no_repeat();
    PlayCinematicForAll(clip);
    wait 3;
  }
}

jumbotron_loop_bink(bink, length) {
  level endon("stop_jumbotron_loop");

  while(1) {
    flag_wait("jumbotron_available");
    PlayCinematicForAll(bink);
    wait length;
  }
}

jumbotron_play_slot_machine_bink(bink, length) {
  wait length;
  flag_set("jumbotron_available");
}

box_kill_counter() {
  level endon("game_ended");

  volume = GetEnt("box_kill_volume", "targetname");
  sign_on = GetEnt("puzzle_box_sign_on", "targetname");
  sign_off = GetEnt("puzzle_box_sign_off", "targetname");

  sign_on Hide();

  while(1) {
    agents = maps\mp\agents\_agent_utility::getActiveAgentsOfType("all");
    agents = array_combine(agents, level.players);
    agents = array_combine(agents, level.remote_uav);

    foreach(agent in agents) {
      if(isPlayer(agent) && (agent.sessionstate == "intermission" || agent.sessionstate == "spectator" || !isReallyAlive(agent))) {
        agents = array_remove(agents, agent);
      }
    }

    touchers = volume GetIsTouchingEntities(agents);
    foreach(toucher in touchers) {
      if(isDefined(toucher.is_in_box)) {
        continue;
      }
      toucher.is_in_box = true;
      if(isDefined(toucher.classname) && toucher.classname != "script_vehicle") {
        toucher thread watch_for_box_death(sign_on, sign_off);
        toucher thread watch_for_leaving_box(volume);
      }
    }
    wait 0.05;
  }
}

watch_for_leaving_box(volume) {
  self endon("death");
  self endon("disconnect");
  while(self isTouching(volume)) {
    wait(0.05);
  }
  self notify("left_the_box");
  self.is_in_box = undefined;
}

watch_for_box_death(sign_on, sign_off) {
  self endon("disconnect");
  self endon("left_the_box");
  self waittill("death");
  self.is_in_box = undefined;
  level.box_kill_counter += 1;

  thread box_kill_sign_lights(sign_on, sign_off);
}

box_kill_sign_lights(sign_on, sign_off) {
  exploder(33);

  sign_off Hide();
  sign_on Show();
  sign_on thread puzzle_box_counter_sfx();

  wait 1.5;
  sign_on Hide();
  sign_off Show();
}

puzzle_box_counter_sfx() {
  wait 0.2;
  self playSound("emt_puzzle_box_counter");
}
box_kill_numbers() {
  while(1) {
    if(isDefined(level.players)) {
      break;
    }
    wait 1;
  }

  level.box_kill_counter = 0;
  counter = 0;
  carnage_iterator = 1;

  thread box_kill_counter();

  counter_ones_digit = getEntArray("box_1_0", "targetname");
  counter_tens_digit = getEntArray("box_2_0", "targetname");
  all_numbers = array_combine(counter_ones_digit, counter_tens_digit);

  foreach(number in all_numbers) {
    number Show();

  }

  while(1) {
    if(level.box_kill_counter == 99) {
      level notify("announcement", "puzzle_box_max", undefined, undefined, true);
    }
    else if(level.box_kill_counter > 1 && level.box_kill_counter % 10 == 0) {
      level notify("announcement", "puzzle_box", undefined, undefined, false);
    }

    if(level.box_kill_counter > 99) {
      box_counter = 99;
    }
    else {
      box_counter = level.box_kill_counter;
    }

    if(box_counter < 10) {
      counter_ones = GetSubStr(box_counter, 0, 1);
      foreach(number in counter_ones_digit) {
      number setModel("shns_score_num_" + counter_ones + "_small");
      }
    }

    if(box_counter > 9 && counter < 99) {
      counter_ones = GetSubStr(box_counter, 1, 2);
      foreach(number in counter_ones_digit) {
      number setModel("shns_score_num_" + counter_ones + "_small");
      }

      counter_tens = GetSubStr(box_counter, 0, 1);
      foreach(number in counter_tens_digit) {
      number setModel("shns_score_num_" + counter_tens + "_small");
      }
    }
    if(box_counter >= 50 && !flag("played_easter_egg_video")) {
      flag_set("played_easter_egg_video");

      exploder(86);
      thread play_sound_in_space("emt_jumbotron_ns", (-38, -1357, 1261));
      jumbotron_play_slot_machine_bink("mp_shipment_ns_easter_egg", 23);
    }

    if(level.box_kill_counter >= (carnage_iterator * 20)) {
      carnage_iterator++;

      exploder(8);
    }
    wait 0.05;
  }
}

match_end_event() {
  while(1) {
    level waittill_any("start_custom_ending", "scoreboard_displaying", "final_killcam_done");

    if(wasLastRound()) {
      break;
    } else
      wait 0.1;
  }

  levelFlagSet("post_game_level_event_active");

  result = RandomIntRange(1, 10);
  if(result == 1) {
    level notify("announcement", "outro_rare", undefined, undefined, true);
  }
  else {
    level notify("announcement", "outro", undefined, undefined, true);
  }

  levelFlagClear("post_game_level_event_active");
}

get_highest_scoring_players() {
  top_scorers = [];

  if(!level.teambased) {
    players_sorted_by_score = array_sort_with_func(level.players, ::is_score_a_greater_than_b);
  }
  else {
    ghosts_score = GetTeamScore("allies");
    federation_score = GetTeamScore("axis");

    if(ghosts_score == federation_score) {
      winning_team = undefined;
    }

    else if(ghosts_score > federation_score) {
      winning_team = "allies";
    }

    else {
      winning_team = "axis";
    }

    if(isDefined(winning_team)) {
      players_sorted_by_score = array_sort_with_func(level.teamList[winning_team], ::is_score_a_greater_than_b);
    }

    else {
      players_sorted_by_score = array_sort_with_func(level.players, ::is_score_a_greater_than_b);
    }
  }

  for(i = 0; i < 3; i++) {
    if(isDefined(players_sorted_by_score[i])) {
      top_scorers[top_scorers.size] = players_sorted_by_score[i];
    }
    else {
      break;
    }
  }

  return top_scorers;
}

is_score_a_greater_than_b(a, b) {
  return (a.score > b.score);
}

set_up_winners_podium(top_scorers) {
  camera = GetEnt("mp_global_intermission", "classname");
  camera_loc = spawn("script_model", camera.origin);
  camera_loc setModel("tag_origin");
  camera_loc.angles = camera.angles;

  podium_clip = GetEnt("podium_clip", "targetname");
  podium_clip MoveTo(podium_clip.origin + (0, 0, 300), 0.05);
  podium_clip DisconnectPaths();

  for(i = 0; i < 3; i++) {
    player = top_scorers[i];
    if(!isDefined(player)) {
      return;
    }
    place = i + 1;
    location = GetEnt("podium_place_" + place, "targetname");

    player spawn(location.origin, location.angles);
    player updateSessionState("playing");
    player.primaryWeapon = undefined;
    player.disabledWeapon = 1;
    player.disabledoffhandweapons = 1;

    if(isDefined(player.riotshieldmodel)) {
      player.riotshieldmodel = undefined;
    }

    player CameraLinkTo(camera_loc, "tag_origin");

    player.custom_spawn_loc = location;

    if(isRoundBased()) {
      player thread podium_scoreboard_sequence(location, camera_loc, "playing");
    }
  }
}

set_up_podium_spectator(spectators) {
  camera = GetEnt("mp_global_intermission", "classname");
  camera_loc = spawn("script_model", camera.origin);
  camera_loc setModel("tag_origin");
  camera_loc.angles = camera.angles;

  if(isDefined(spectators)) {
    for(i = 0; i < spectators.size; i++) {
      player = spectators[i];
      if(!isDefined(player)) {
        continue;
      }
      if(!IsBot(player)) {
        player thread spawn_custom_spectator(camera_loc);

        if(isRoundBased()) {
          player thread podium_scoreboard_sequence(camera_loc, camera_loc, undefined);
        }
      }
    }
  }
}

podium_scoreboard_sequence(spawn_location, camera, sessionstate) {
  level waittill("scoreboard_displaying");

  wait 0.01;

  if(isDefined(sessionstate)) {
    self spawn(spawn_location.origin, spawn_location.angles);
    self updateSessionState("playing");

    camera_loc = spawn("script_model", camera.origin);
    camera_loc setModel("tag_origin");
    camera_loc.angles = camera.angles;

    self CameraLinkTo(camera_loc, "tag_origin");

    self.primaryWeapon = undefined;
  } else {
    if(!IsBot(self)) {
      self thread spawn_custom_spectator(spawn_location);
    }
  }

  self setDepthOfField(0, 0, 512, 512, 4, 0);
}

spawn_custom_spectator(camera_loc) {
  self ClearKillcamState();
  self.friendlydamage = undefined;

  self SetSpectateDefaults(camera_loc.origin, camera_loc.angles);
  self spawn(camera_loc.origin, camera_loc.angles);
  self updateSessionState("playing");
  self freezeControlsWrapper(true);
  self PlayerHide();

  self CameraLinkTo(camera_loc, "tag_origin");
  self setDepthOfField(0, 0, 512, 512, 4, 0);
  self restoreBaseVisionSet(0);
}

clean_up_podium_scene() {
  volume = GetEnt("trap_1_volume", "targetname");

  touching_ents = getEntArray("script_vehicle", "classname");

  foreach(remote in touching_ents) {
    remote Delete();
  }
}

get_prize_room_curtains_n_fx() {
  wait 5;

  foreach(curtain in GetScriptableArray("prize_curtains", "targetname")) {
    curtain thread prize_room_curtains();
  }

  thread prize_room_fx();
}

PRIZE_ROOM_TIME = 40;
PRIZE_ROOM_TIME_OPEN = 15;
prize_room_curtains() {
  clip = GetEnt("prize_display_clip", "targetname");

  while(1) {
    self SetScriptablePartState(0, "curtain_closed");
    wait PRIZE_ROOM_TIME;
    self SetScriptablePartState(0, "curtain_open");
    clip MoveZ(-400, 0.1);
    wait PRIZE_ROOM_TIME_OPEN;
    self SetScriptablePartState(0, "curtain_close");
    clip MoveZ(400, 0.1);
    wait 5;
  }
}

prize_room_fx() {
  while(1) {
    wait PRIZE_ROOM_TIME;

    exploder(60);
    thread red_and_blue_fx_lights();
    thread white_fx_lights();
    thread flashing_neon_sign();
    thread play_sound_in_space("emt_prize_curtains_open", (547, 1035, 305));
    prize_room_bells = play_loopsound_in_space("emt_prize_bells", (547, 1035, 305));
    wait 15;
    thread play_sound_in_space("emt_prize_curtains_close", (547, 1035, 305));
    prize_room_bells StopLoopSound();
    wait 5;
  }
}

red_and_blue_fx_lights() {
  for(i = 0; i < 8; i++) {
    exploder(61);
    wait 1;
    exploder(62);
    wait 1;
  }
}

white_fx_lights() {
  for(i = 0; i < 8; i++) {
    exploder(63);
    wait 0.5;
    exploder(64);
    wait 0.5;
    exploder(65);
    wait 0.5;
    exploder(66);
    wait 0.5;
  }
}

flashing_neon_sign() {
  sign_on = [];
  sign_off = [];
  count = 1;

  sign_on = get_neon_sign("neon_winner_sign_");
  sign_off = get_neon_sign("neon_winner_sign_off_");

  sign_on_right = get_neon_sign("neon_winner_sign_right_");
  sign_off_right = get_neon_sign("neon_winner_sign_right_off_");

  time = GetTime();

  while(GetTime() < time + PRIZE_ROOM_TIME_OPEN * 1000) {
    for(i = 0; i < 4; i++) {
      for(x = 0; x < sign_on.size; x++) {
        sign_on[x] Hide();
        sign_on_right[x] Hide();
        sign_off[x] Show();
        sign_off_right[x] Show();
        wait 0.05;
        sign_off[x] Hide();
        sign_off_right[x] Hide();
        sign_on[x] Show();
        sign_on_right[x] Show();
      }
    }

    for(i = 0; i < 3; i++) {
      for(x = 0; x < sign_on.size; x++) {
        sign_off[x] Hide();
        sign_off_right[x] Hide();
        sign_on[x] Show();
        sign_on_right[x] Show();
      }

      wait 0.4;

      for(x = 0; x < sign_on.size; x++) {
        sign_on[x] Hide();
        sign_on_right[x] Hide();
        sign_off[x] Show();
        sign_off_right[x] Show();
      }

      wait 0.4;
    }

  }

  foreach(letter in sign_on) {
  letter Hide();
  }
  foreach(letter in sign_on_right) {
  letter Hide();
  }
  foreach(letter in sign_off) {
  letter Show();
  }
  foreach(letter in sign_off_right) {
  letter Show();
  }
}

get_neon_sign(name) {
  sign = [];
  count = 1;

  while(1) {
    letter = GetEnt(name + count, "targetname");

    if(isDefined(letter)) {
      sign[count - 1] = letter;
      count++;
    } else {
      break;
    }
  }

  return sign;
}

get_elevators() {
  wait 5;
  elevators = ["periph_elevator_NE", "periph_elevator_NW", "periph_elevator_SE", "periph_elevator_SW"];

  foreach(elevator in elevators) {
    foreach(part in getEntArray(elevator, "targetname")) {
      part thread move_elevators();
    }
  }
}

move_elevators() {
  while(1) {
    self MoveZ(-448, 8, 2, 4);
    wait RandomIntRange(10, 17);
    self MoveZ(448, 8, 3, 3);
    wait RandomIntRange(10, 13);
  }
}

move_podium_camera() {
  self MoveTo((122, 1006, 300), 15, 1, 12);
  self RotateBy((90, 90, 90), 3.0, 0.5, 0.5);
}

create_overlay(shader_name, start_alpha) {
  overlay = newHudElem();
  overlay.x = 0;
  overlay.y = 0;
  overlay setshader(shader_name, 640, 480);
  overlay.alignX = "left";
  overlay.alignY = "top";
  overlay.sort = 1;
  overlay.horzAlign = "fullscreen";
  overlay.vertAlign = "fullscreen";
  overlay.alpha = start_alpha;
  overlay.foreground = true;

  return overlay;
}

fade_over_time(target_alpha, fade_time) {
  assertex(isDefined(target_alpha), "fade_over_time must be passed a target_alpha.");

  if(isDefined(fade_time) && fade_time > 0) {
    self fadeOverTime(fade_time);
  }

  self.alpha = target_alpha;

  if(isDefined(fade_time) && fade_time > 0) {
    wait fade_time;
  }
}

hud_delete(delay) {
  self endon("death");
  wait delay;

  self Destroy();
}

turret_box_light_fx() {
  level endon("game_ended");

  foreach(player in level.players) {
    if(player.pers["team"] == level.turret_team) {
      thread looped_turret_light(15, 16, player);
    } else {
      thread looped_turret_light(16, 15, player);
    }
  }

}

looped_turret_light(ID, ID_enemy, player) {
  time = GetTime() + 15000;

  while(GetTime() < time) {
    if(!player isInKillcam()) {
      ActivateClientExploder(ID, player);
    }
    else {
      ActivateClientExploder(ID_enemy, player);
    }

    wait 1.0;
  }
}

sfx_gate_alarm(OPEN_DELAY) {}

sfx_lights_red() {
  playSoundatPos((-277, 754, 326), "scn_shp_gate_red");
  playSoundatPos((-764, 311, 326), "scn_shp_gate_red");
  playSoundatPos((-769, -255, 326), "scn_shp_gate_red");
  playSoundatPos((-247, -642, 326), "scn_shp_gate_red");
  playSoundatPos((355, -642, 326), "scn_shp_gate_red");
  playSoundatPos((744, -139, 326), "scn_shp_gate_red");
  playSoundatPos((740, 329, 326), "scn_shp_gate_red");
  playSoundatPos((281, 757, 326), "scn_shp_gate_red");

  playSoundatPos((2, 45, 450), "scn_shp_gate_red_wet");
}

sfx_lights_green() {
  playSoundatPos((-277, 754, 326), "scn_shp_gate_green");
  playSoundatPos((-764, 311, 326), "scn_shp_gate_green");
  playSoundatPos((-769, -255, 326), "scn_shp_gate_green");
  playSoundatPos((-247, -642, 326), "scn_shp_gate_green");
  playSoundatPos((355, -642, 326), "scn_shp_gate_green");
  playSoundatPos((744, -139, 326), "scn_shp_gate_green");
  playSoundatPos((740, 329, 326), "scn_shp_gate_green");
  playSoundatPos((281, 757, 326), "scn_shp_gate_green");

  playSoundatPos((2, 45, 450), "scn_shp_gate_green_wet");
}

sfx_gates_open() {
  playSoundatPos((-277, 754, 250), "scn_shp_gate_open_01");
  playSoundatPos((-764, 311, 250), "scn_shp_gate_open_02");
  playSoundatPos((-769, -255, 250), "scn_shp_gate_open_01");
  playSoundatPos((-247, -642, 250), "scn_shp_gate_open_02");
  playSoundatPos((355, -642, 250), "scn_shp_gate_open_01");
  playSoundatPos((744, -139, 250), "scn_shp_gate_open_02");
  playSoundatPos((740, 329, 250), "scn_shp_gate_open_01");
  playSoundatPos((281, 757, 250), "scn_shp_gate_open_02");
}

sfx_turret_shutters_open() {
  playSoundatPos((305, -176, 250), "scn_shp_turret_door_open");
  playSoundatPos((-18, -378, 250), "scn_shp_turret_door_open");
  playSoundatPos((-315, -199, 250), "scn_shp_turret_door_open");
  playSoundatPos((-306, 322, 250), "scn_shp_turret_door_open");
  playSoundatPos((312, 318, 250), "scn_shp_turret_door_open");
  playSoundatPos((524, 87, 250), "scn_shp_turret_door_open");
}

sfx_turret_shutters_close() {
  playSoundatPos((305, -176, 250), "scn_shp_turret_door_close");
  playSoundatPos((-18, -378, 250), "scn_shp_turret_door_close");
  playSoundatPos((-315, -199, 250), "scn_shp_turret_door_close");
  playSoundatPos((-306, 322, 250), "scn_shp_turret_door_close");
  playSoundatPos((312, 318, 250), "scn_shp_turret_door_close");
  playSoundatPos((524, 87, 250), "scn_shp_turret_door_close");
}

nukeDeathVision() {
  level.nukeVisionSet = "aftermath_mp_shipment_ns";
  setExpFog(512, 4097, 0.578828, 0.802656, 1, 0.75, 0.75, 5, 0.382813, 0.350569, 0.293091, 3, (1, -0.109979, 0.267867), 0, 80, 1, 0.179688, 26, 180);
  VisionSetNaked(level.nukeVisionSet, 5);
  VisionSetPain(level.nukeVisionSet);
}