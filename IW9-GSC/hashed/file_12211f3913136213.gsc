/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_12211f3913136213.gsc
***********************************************/

setup_functions() {
  if(!scripts\engine\utility::flag_exist("checkpoints_initialized"))
    scripts\engine\utility::flag_init("checkpoints_initialized");

  scripts\cp\cp_checkpoint::checkpoint_register("trap_platforms", ::_id_CC4D2417A80FA985);
  scripts\cp\cp_checkpoint::checkpoint_register("trap_rappel", ::_id_90E44396DD153CC2);
  scripts\cp\cp_checkpoint::checkpoint_register("trap_doubleback", ::_id_AE06026CB02520C8);
  scripts\cp\cp_checkpoint::checkpoint_register("trap_oldrooms", ::_id_F9363CB99DB5F06D);
  scripts\cp\cp_checkpoint::checkpoint_register("trap_room", ::_id_67308E617CD5266D);
  scripts\cp\cp_checkpoint::checkpoint_register("trap_room_final_wave", ::_id_CBB9DC248656C928);
  scripts\cp\cp_checkpoint::checkpoint_register("trap_room_escape", ::_id_D6CAF915544A0E03);
  level.checkpoint_player_spawns_func = ::checkpoint_player_spawns;
  level.checkpoint_carepkg_spawns_func = ::checkpoint_carepkg_spawns;
  scripts\cp\cp_checkpoint::checkpoints_init();
  scripts\engine\utility::flag_set("checkpoints_initialized");
}

_id_3EA3DD41E55B1C07() {
  _id_CB385B838E10F79E = getDvar("start", "trap_platforms");

  switch (_id_CB385B838E10F79E) {
    case "trap_platforms":
    default:
      level.default_player_spawns = "platform_player_start";
      level thread _id_CC4D2417A80FA985();
      break;
    case "trap_platforms_puzzle":
      level.default_player_spawns = "platform_console_spawners";
      level thread _id_CC4D2417A80FA985();
      break;
    case "trap_rappel":
      level.default_player_spawns = "trap_rappel_spawners";
      level thread _id_CC4D2417A80FA985();
      level waittill("trap_platforms_objective_started");
      _id_16591A48F7D6F223::_id_75DAA35A5A19AA29();
      break;
    case "trap_rappel_top":
      level.default_player_spawns = "rappel_top_spawners";
      level thread _id_CC4D2417A80FA985();
      level waittill("trap_platforms_objective_started");
      _id_16591A48F7D6F223::_id_75DAA35A5A19AA29();
      break;
    case "trap_doubleback":
      level.default_player_spawns = "trap_doubleback_spawners";
      level thread _id_CC4D2417A80FA985();
      level waittill("trap_platforms_objective_started");
      _id_16591A48F7D6F223::_id_83E9ACC14FAA3B6B();
      break;
    case "trap_oldrooms":
      level.default_player_spawns = "dropdown_rooms_spawners";
      level thread _id_CC4D2417A80FA985();
      level waittill("trap_platforms_objective_started");
      _id_16591A48F7D6F223::_id_75DAA35A5A19AA29();
      break;
    case "trap_room":
      level.default_player_spawns = "trap_room_spawners";
      level thread _id_67308E617CD5266D();
      break;
    case "trap_room_puzzle":
      level.default_player_spawns = "trap_consoles_spawners";
      level thread _id_67308E617CD5266D("trap_consoles_spawners");
      break;
    case "trap_room_final_wave":
      level.default_player_spawns = "trap_final_wave_spawners";
      level thread _id_CBB9DC248656C928();
      break;
    case "trap_room_escape":
      level.default_player_spawns = "trap_escape_spawners";
      level thread _id_D6CAF915544A0E03();
      break;
    case "trap_escape_airlock":
      level.default_player_spawns = "platform_final_airlock_spawners";
      level thread _id_86276328C2FE69A6();
      break;
  }
}

_id_CC4D2417A80FA985() {
  level.skip_nav_check_on_spectate_respawn = 1;
  wait 2;
  scripts\engine\utility::flag_set("cp_raid_complex_cs_trap_room");
  scripts\engine\utility::flag_wait("cp_raid_complex_cs_trap_room_completed");
  level thread scripts\cp\cp_objectives::run_objective("trap_platforms");
}

_id_67308E617CD5266D(spawners) {
  level.skip_nav_check_on_spectate_respawn = 1;
  level.default_player_spawns = scripts\engine\utility::_id_53C4C53197386572(spawners, "trap_room_spawners");
  wait 3;
  scripts\engine\utility::flag_set("cp_raid_complex_cs_trap_room");
  scripts\engine\utility::flag_wait("cp_raid_complex_cs_trap_room_completed");
  level thread scripts\cp\cp_objectives::run_objective("trap_room");
}

_id_CBB9DC248656C928(spawners) {
  level._id_81D95BA69322AEA5 = 1;
  level.skip_nav_check_on_spectate_respawn = 1;
  level.default_player_spawns = scripts\engine\utility::_id_53C4C53197386572(spawners, "trap_final_wave_spawners");
  wait 3;
  scripts\engine\utility::flag_set("cp_raid_complex_cs_trap_room");
  scripts\engine\utility::flag_wait("cp_raid_complex_cs_trap_room_completed");
  level thread scripts\cp\cp_objectives::run_objective("trap_room_final_wave");
}

_id_90E44396DD153CC2() {
  level.skip_nav_check_on_spectate_respawn = 1;
  level.default_player_spawns = "trap_rappel_spawners";
  wait 3;
  scripts\engine\utility::flag_set("cp_raid_complex_cs_trap_room");
  scripts\engine\utility::flag_wait("cp_raid_complex_cs_trap_room_completed");
  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("trap_rappel");
  level thread scripts\cp\cp_objectives::run_objective("trap_platforms");
  level waittill("trap_platforms_objective_started");
  _id_16591A48F7D6F223::_id_75DAA35A5A19AA29();
}

_id_AE06026CB02520C8() {
  level.skip_nav_check_on_spectate_respawn = 1;
  level.default_player_spawns = "trap_doubleback_spawners";
  wait 3;
  scripts\engine\utility::flag_set("cp_raid_complex_cs_trap_room");
  scripts\engine\utility::flag_wait("cp_raid_complex_cs_trap_room_completed");
  level thread scripts\cp\cp_objectives::run_objective("trap_platforms");
  level waittill("trap_platforms_objective_started");
  _id_16591A48F7D6F223::_id_83E9ACC14FAA3B6B();
}

_id_F9363CB99DB5F06D() {
  level.skip_nav_check_on_spectate_respawn = 1;
  level.default_player_spawns = "dropdown_rooms_spawners";
  wait 3;
  scripts\engine\utility::flag_set("cp_raid_complex_cs_trap_room");
  scripts\engine\utility::flag_wait("cp_raid_complex_cs_trap_room_completed");
  level thread scripts\cp\cp_objectives::run_objective("trap_platforms");
  level waittill("trap_platforms_objective_started");
  _id_16591A48F7D6F223::_id_75DAA35A5A19AA29();
}

_id_D6CAF915544A0E03() {
  level.skip_nav_check_on_spectate_respawn = 1;
  level.default_player_spawns = "trap_escape_spawners";
  wait 3;
  scripts\engine\utility::flag_set("cp_raid_complex_cs_trap_room");
  scripts\engine\utility::flag_wait("cp_raid_complex_cs_trap_room_completed");
  level thread scripts\cp\cp_objectives::run_objective("trap_room_escape");
}

_id_86276328C2FE69A6() {
  level.skip_nav_check_on_spectate_respawn = 1;
  level.default_player_spawns = "platform_final_airlock_spawners";
  wait 3;
  scripts\engine\utility::flag_set("cp_raid_complex_cs_trap_room");
  scripts\engine\utility::flag_wait("cp_raid_complex_cs_trap_room_completed");
  level thread scripts\cp\cp_objectives::run_objective("trap_room_escape");
}

checkpoint_player_spawns() {
  spawnpoints = [];
  _id_BCA7AE9B319C8C9A = scripts\engine\utility::getStructArray("default_player_start", "targetname");
  _id_FD63D41947ADA6C0 = scripts\engine\utility::getStructArray("trap_rappel_spawners", "targetname");
  _id_BBB53BAA6FC97CDA = scripts\engine\utility::getStructArray("trap_doubleback_spawners", "targetname");
  _id_83E49E7F937BCF81 = scripts\engine\utility::getStructArray("dropdown_rooms_spawners", "targetname");
  _id_23F7F233AA3382BF = scripts\engine\utility::getStructArray("trap_room_spawners", "targetname");
  _id_7483BB50D720907B = scripts\engine\utility::getStructArray("trap_final_wave_spawners", "targetname");
  _id_4FB1DF8D4C95B29B = scripts\engine\utility::getStructArray("trap_escape_spawners", "targetname");

  foreach(struct in _id_BCA7AE9B319C8C9A) {
    og = struct.origin;
    angles = scripts\engine\utility::ter_op(isDefined(struct.angles), struct.angles, (0, 0, 0));
    spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("trap_platforms", og, angles);
  }

  foreach(struct in _id_FD63D41947ADA6C0) {
    og = struct.origin;
    angles = scripts\engine\utility::ter_op(isDefined(struct.angles), struct.angles, (0, 0, 0));
    spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("trap_rappel", og, angles);
  }

  foreach(struct in _id_BBB53BAA6FC97CDA) {
    og = struct.origin;
    angles = scripts\engine\utility::ter_op(isDefined(struct.angles), struct.angles, (0, 0, 0));
    spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("trap_doubleback", og, angles);
  }

  foreach(struct in _id_83E49E7F937BCF81) {
    og = struct.origin;
    angles = scripts\engine\utility::ter_op(isDefined(struct.angles), struct.angles, (0, 0, 0));
    spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("trap_oldrooms", og, angles);
  }

  foreach(struct in _id_23F7F233AA3382BF) {
    og = struct.origin;
    angles = scripts\engine\utility::ter_op(isDefined(struct.angles), struct.angles, (0, 0, 0));
    spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("trap_room", og, angles);
  }

  foreach(struct in _id_7483BB50D720907B) {
    og = struct.origin;
    angles = scripts\engine\utility::ter_op(isDefined(struct.angles), struct.angles, (0, 0, 0));
    spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("trap_room_final_wave", og, angles);
  }

  foreach(struct in _id_4FB1DF8D4C95B29B) {
    og = struct.origin;
    angles = scripts\engine\utility::ter_op(isDefined(struct.angles), struct.angles, (0, 0, 0));
    spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("trap_room_escape", og, angles);
  }

  return spawnpoints;
}

checkpoint_carepkg_spawns() {
  _id_03B819B9C304F403 = scripts\engine\utility::getStruct("test_loadout", "script_noteworthy");
  _id_20C5609F18D45157 = scripts\cp\cp_checkpoint::checkpoint_add_carepackage_munitions("checkpoint_gauntlet_approach", _id_03B819B9C304F403, (0, 0, 0));
  return [_id_20C5609F18D45157];
}