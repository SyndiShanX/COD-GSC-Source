/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_45f0e1dc4ce9eccb.gsc
***********************************************/

setup_functions() {
  if(!scripts\engine\utility::flag_exist("checkpoints_initialized"))
    scripts\engine\utility::flag_init("checkpoints_initialized");

  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_captured_blind", ::_id_989F834A7B2FAD26);
  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_rescue_warehouse", ::_id_7545C0A807BDBF85);
  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_stealth_section", ::_id_EF769F72F1D0CE93);
  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_mine_section", ::_id_17DD07C93A594717);
  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_mine_postlasers", ::_id_1131B2B86A2D10BE);
  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_jugg_maze", ::_id_2553ABB1C853755B);
  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_jugg_maze_section_postvent", ::_id_E2F13A9E4BEBFE45);
  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_jugg_maze_section_postcard", ::_id_C9B72BA20CAF35D4);
  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_jugg_maze_section_postcore", ::_id_FC72C2A1756D1379);
  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_elevator_section", ::_id_C808A106B1C73E31);
  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_elevator_section_downstairs", ::_id_14C8089C207D6675);
  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_elevator_defend_start", ::_id_268132AFCDFD38DC);
  level.checkpoint_player_spawns_func = ::checkpoint_player_spawns;
  level thread _id_374034F9E067FF5F();
  scripts\cp\cp_checkpoint::checkpoints_init();
  scripts\engine\utility::flag_set("checkpoints_initialized");
}

checkpoint_player_spawns() {
  spawnpoints = [];
  scripts\engine\utility::flag_wait("create_script_initialized");

  foreach(struct in scripts\engine\utility::getStructArray("checkpoint_captured_blind", "targetname"))
  spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_captured_blind", struct.origin, struct.angles);

  foreach(struct in scripts\engine\utility::getStructArray("checkpoint_rescue_warehouse", "targetname"))
  spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_rescue_warehouse", struct.origin, struct.angles);

  foreach(struct in scripts\engine\utility::getStructArray("checkpoint_stealth_section", "targetname")) {
    spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_stealth_section", struct.origin, struct.angles);
    spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_stealth_section_section_a", struct.origin, struct.angles);
    spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_stealth_section_section_b", struct.origin, struct.angles);
    spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_stealth_section_section_c", struct.origin, struct.angles);
  }

  foreach(struct in scripts\engine\utility::getStructArray("checkpoint_mine_section", "targetname"))
  spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_mine_section", struct.origin, struct.angles);

  foreach(struct in scripts\engine\utility::getStructArray("checkpoint_mine_postlasers", "targetname"))
  spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_mine_postlasers", struct.origin, struct.angles);

  foreach(struct in scripts\engine\utility::getStructArray("checkpoint_jugg_maze", "targetname"))
  spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_jugg_maze", struct.origin, struct.angles);

  foreach(struct in scripts\engine\utility::getStructArray("checkpoint_jugg_maze_postvent", "targetname"))
  spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_jugg_maze_section_postvent", struct.origin, struct.angles);

  foreach(struct in scripts\engine\utility::getStructArray("checkpoint_jugg_maze_postvent", "targetname"))
  spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_jugg_maze_section_postcard", struct.origin, struct.angles);

  foreach(struct in scripts\engine\utility::getStructArray("checkpoint_jugg_maze_postcore", "targetname"))
  spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_jugg_maze_section_postcore", struct.origin, struct.angles);

  spawnpoints = _id_E2AA894AE0CF3455(spawnpoints, "checkpoint_elevator_defend_start", "hadir_elevator_defend_spawner");
  spawnpoints = _id_E2AA894AE0CF3455(spawnpoints, "checkpoint_elevator_section", "hadir_elevator_spawner");
  spawnpoints = _id_E2AA894AE0CF3455(spawnpoints, "checkpoint_elevator_section_downstairs", "hadir_elevator_spawner");
  return spawnpoints;
}

_id_E2AA894AE0CF3455(spawnpoints, checkpoint, targetname) {
  if(!isDefined(spawnpoints))
    spawnpoints = [];

  foreach(struct in scripts\engine\utility::getStructArray(targetname, "targetname"))
  spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint(checkpoint, struct.origin, struct.angles);

  return spawnpoints;
}

_id_285F6CC4C95E7B36() {}

_id_989F834A7B2FAD26() {
  level.skip_nav_check_on_spectate_respawn = 1;

  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(scripts\engine\utility::flag_exist("objectives_registered"))
    scripts\engine\utility::flag_wait("objectives_registered");

  _id_285F6CC4C95E7B36();
  thread _id_11811C954BBA79E3::_id_C1F55F1B5A7BED96();
}

_id_7545C0A807BDBF85() {
  level.skip_nav_check_on_spectate_respawn = 1;

  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(scripts\engine\utility::flag_exist("objectives_registered"))
    scripts\engine\utility::flag_wait("objectives_registered");

  _id_285F6CC4C95E7B36();
  _id_11811C954BBA79E3::_id_6F02AF154BFEE3DB();
  thread _id_11811C954BBA79E3::_id_742712ADA9D7A002();
}

_id_EF769F72F1D0CE93() {
  level.skip_nav_check_on_spectate_respawn = 1;

  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(scripts\engine\utility::flag_exist("objectives_registered"))
    scripts\engine\utility::flag_wait("objectives_registered");

  _id_285F6CC4C95E7B36();
  thread _id_11811C954BBA79E3::_id_0738A0CBC30B510B();
}

_id_17DD07C93A594717() {
  level.skip_nav_check_on_spectate_respawn = 1;

  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(scripts\engine\utility::flag_exist("objectives_registered"))
    scripts\engine\utility::flag_wait("objectives_registered");

  _id_285F6CC4C95E7B36();
  thread _id_11811C954BBA79E3::_id_BE1D62385C255B4F();
}

_id_BD3357A2E9D0417A() {
  level.skip_nav_check_on_spectate_respawn = 1;

  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(scripts\engine\utility::flag_exist("objectives_registered"))
    scripts\engine\utility::flag_wait("objectives_registered");

  _id_285F6CC4C95E7B36();
  thread _id_11811C954BBA79E3::_id_F4B722CD2A5A8AB2();
}

_id_BD3358A2E9D043AD() {
  level.skip_nav_check_on_spectate_respawn = 1;

  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(scripts\engine\utility::flag_exist("objectives_registered"))
    scripts\engine\utility::flag_wait("objectives_registered");

  _id_285F6CC4C95E7B36();
  thread _id_11811C954BBA79E3::_id_F4B723CD2A5A8CE5();
}

_id_1131B2B86A2D10BE() {
  level.skip_nav_check_on_spectate_respawn = 1;

  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(scripts\engine\utility::flag_exist("objectives_registered"))
    scripts\engine\utility::flag_wait("objectives_registered");

  _id_285F6CC4C95E7B36();
  thread _id_11811C954BBA79E3::_id_36E8F31EC609DB6E();
}

_id_2553ABB1C853755B() {
  level.skip_nav_check_on_spectate_respawn = 1;

  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(scripts\engine\utility::flag_exist("objectives_registered"))
    scripts\engine\utility::flag_wait("objectives_registered");

  _id_285F6CC4C95E7B36();
  thread _id_11811C954BBA79E3::_id_98264BCEC5C5BBC5();
}

_id_E2F13A9E4BEBFE45() {
  level.skip_nav_check_on_spectate_respawn = 1;

  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(scripts\engine\utility::flag_exist("objectives_registered"))
    scripts\engine\utility::flag_wait("objectives_registered");

  _id_285F6CC4C95E7B36();
  thread _id_11811C954BBA79E3::_id_98264BCEC5C5BBC5();
}

_id_C9B72BA20CAF35D4() {
  level.skip_nav_check_on_spectate_respawn = 1;

  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(scripts\engine\utility::flag_exist("objectives_registered"))
    scripts\engine\utility::flag_wait("objectives_registered");

  _id_285F6CC4C95E7B36();
  thread _id_11811C954BBA79E3::_id_D1C1792955EE912F();
  wait 1;
  thread _id_11811C954BBA79E3::_id_98264BCEC5C5BBC5();
}

_id_FC72C2A1756D1379() {
  level.skip_nav_check_on_spectate_respawn = 1;
  _id_F3D78F030CA77940();
  _id_285F6CC4C95E7B36();
  _id_11811C954BBA79E3::_id_52107F2E92914747();
  thread _id_11811C954BBA79E3::_id_A96679D1A7DC6AF4();
}

_id_C808A106B1C73E31() {
  level.skip_nav_check_on_spectate_respawn = 1;
  _id_F3D78F030CA77940();
  _id_285F6CC4C95E7B36();
  thread _id_11811C954BBA79E3::_id_FF4F7DBC45EB0223();
}

_id_14C8089C207D6675() {
  level.skip_nav_check_on_spectate_respawn = 1;
  _id_F3D78F030CA77940();
  _id_285F6CC4C95E7B36();
  thread _id_11811C954BBA79E3::_id_FF4F7DBC45EB0223();
}

_id_268132AFCDFD38DC() {
  level.skip_nav_check_on_spectate_respawn = 1;

  if(!istrue(level._id_D5D05591ACE78C64)) {
    scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(_id_3C2AAAD486A9AA1D::_id_1B4FABA836C0F200);
    level._id_D5D05591ACE78C64 = 1;
  }

  _id_F3D78F030CA77940();
  _id_285F6CC4C95E7B36();
  thread _id_11811C954BBA79E3::_id_B728FCE6270C27BF();
}

_id_63386CF513A24131() {
  level.skip_nav_check_on_spectate_respawn = 1;
  _id_F3D78F030CA77940();
  _id_285F6CC4C95E7B36();
  thread _id_11811C954BBA79E3::_id_9231439A1A500C1B();
}

_id_D1CF807FE22A3697() {
  level.skip_nav_check_on_spectate_respawn = 1;
  _id_F3D78F030CA77940();
  _id_285F6CC4C95E7B36();
  thread _id_11811C954BBA79E3::_id_8305E6D7D3565C55();
}

_id_8F9EDFFD39DEE153() {
  level.skip_nav_check_on_spectate_respawn = 1;
  _id_F3D78F030CA77940();
  _id_285F6CC4C95E7B36();
  thread _id_11811C954BBA79E3::_id_68C02A3CDFA27817();
}

_id_8DA9763E6F7212C1() {
  level.skip_nav_check_on_spectate_respawn = 1;
  _id_F3D78F030CA77940();
  _id_285F6CC4C95E7B36();
}

_id_F3D78F030CA77940() {
  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(scripts\engine\utility::flag_exist("objectives_registered"))
    scripts\engine\utility::flag_wait("objectives_registered");
}

_id_374034F9E067FF5F() {
  level endon("game_ended");

  for(;;) {
    level waittill("checkpoint_update", _id_B4D8740307232BB1);
    _id_60F8C3142E229A97 = scripts\cp\cp_objectives::get_active_objectives();
    scripts\cp\cp_checkpoint::checkpoint_set(_id_B4D8740307232BB1);

    if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
      thread _id_1E1360248E27AF65(_id_B4D8740307232BB1);
  }
}

_id_1E1360248E27AF65(_id_66F2F485EE79C018) {
  _id_5AFC469A239EC15E = "";

  switch (_id_66F2F485EE79C018) {
    case "checkpoint_stealth_section":
      _id_5AFC469A239EC15E = "stealth_section_spawner";
      break;
    case "checkpoint_mine_section":
      _id_5AFC469A239EC15E = "mine_section_spawner";
      break;
    case "checkpoint_mine_postlasers":
      _id_5AFC469A239EC15E = "checkpoint_mine_postlasers";
      break;
    case "checkpoint_jugg_maze":
      _id_5AFC469A239EC15E = "jugg_maze_spawner";
      break;
    case "checkpoint_elevator_section":
      _id_5AFC469A239EC15E = "hadir_elevator_spawner";
      break;
    case "checkpoint_elevator_defend_start":
      _id_5AFC469A239EC15E = "hadir_elevator_spawner";
      break;
    default:
      break;
  }

  if(_id_5AFC469A239EC15E == "" || !isDefined(_id_5AFC469A239EC15E)) {
    return;
  }
  _id_2E9261330FBCEC80 = scripts\engine\utility::getStructArray(_id_5AFC469A239EC15E, "targetname");
  _id_0AFB7E332AEE4BF2::_id_79DDAC0EF09B8D0F(_id_2E9261330FBCEC80, 0);
}

_id_7EC4BA6F43AE77C9(obj, _id_10211CAA50DDBA2D) {
  level._id_BB07CFB91B5A51E8[obj] = 1;
  game["objectives_completed"] = obj;
  scripts\cp\cp_checkpoint::checkpoint_set(_id_10211CAA50DDBA2D);
}

_id_34025989F3A3308F() {
  level.skip_nav_check_on_spectate_respawn = 1;

  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(scripts\engine\utility::flag_exist("objectives_registered"))
    scripts\engine\utility::flag_wait("objectives_registered");
}

_id_CCC48E4E354C87DF(_id_B4D8740307232BB1) {
  if(!isDefined(_id_B4D8740307232BB1)) {
    return;
  }
  if(!isstring(_id_B4D8740307232BB1)) {
    return;
  }
  if(!isDefined(level.registered_checkpoint_funcs[_id_B4D8740307232BB1])) {
    return;
  }
  level notify("checkpoint_update", _id_B4D8740307232BB1);
  scripts\cp\utility::_id_3069B525E1C98FAF(_id_B4D8740307232BB1);
}