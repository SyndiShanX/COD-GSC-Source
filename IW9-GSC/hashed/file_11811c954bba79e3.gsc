/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_11811c954bba79e3.gsc
***********************************************/

main() {
  _id_711E3D2F1C1BA15A::main();
  _id_58C9213F1DCAB750::main();
  _id_23892113D46E736E::main();
  _id_165F87DC9B28463B::_id_1F763DFECFC35564();
  _id_7F2FD7FC559755E4::_id_674F631414D85D46();
  _id_424D9A66F5FD1677::_id_D986A6B508AAE1E0();
  _id_424D9A66F5FD1677::_id_22E9EAD73D37146C();
  _id_424D9A66F5FD1677::_id_E06158633A435CCC();
  _id_34D2771929BD6022::_id_0BCD7DBE50E5AF96();
  _id_6086303DFF2B506D();

  if(level.createfx_enabled) {
    return;
  }
  scripts\cp_mp\utility\script_utility::registersharedfunc("create_script", "cleanupFuncInit", scripts\cp\utility::_id_C772AC7ADC6A4637);
  _func_EB7F544259415A09("mp_saba_dmz");
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_45B89B729718BD15", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_8E219ED34EE49E43", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_F236AC8AC0B75A18", 0.1, 1);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_2648C1C97BDEDF8C", 0, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("scr_game_forceuav", 6, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("bg_compassShowEnemies", 0, 1);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_565D343F31403893", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_005674A44E0D2658", 2, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("cg_hudMapFriendlyWidth", 10, 15);
  scripts\cp\utility::_id_0C72FF775CD61B11("cg_hudMapFriendlyHeight", 10, 15);
  scripts\cp\utility::_id_0C72FF775CD61B11("cg_hudMapPlayerWidth", 10, 15);
  scripts\cp\utility::_id_0C72FF775CD61B11("cg_hudMapPlayerHeight", 10, 15);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_F5740209893CDF46", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_F8332F8A8CEDCA1C", 1, 0);
  level._id_9BF3C4B5835FA48F = "killstreak_tablet_02_off";
  level._id_0E0D2E656981CB02 = "scn_cp_elevator_button_press";
  level._id_56045906D662B3DB = 250;
  level._id_4C86D225790B50B9 = getEnt("vent_volume", "targetname");
  level._id_A3E60D4FD52EFC95 = 1;
  level._id_09CBA44F21E7EFD6 = 60;
  scripts\common\create_script_utility::set_cs_file_dvar("cp_capture_jugg_create_script");
  scripts\common\create_script_utility::set_cs_file_dvar("cp_hadir_elevator_cs");
  scripts\common\create_script_utility::set_cs_file_dvar("cp_jugg_maze_lasers_create_script");
  scripts\common\create_script_utility::set_cs_file_dvar("cp_jugg_maze_juggmaze_create_script");
  scripts\common\create_script_utility::set_cs_file_dvar("cp_jugg_maze_intel_create_script");
  scripts\cp\utility::add_start("captured", undefined, undefined);
  scripts\cp\utility::add_start("escape_warehouse", undefined, undefined);
  scripts\cp\utility::add_start("stealth_section", undefined, undefined);
  scripts\cp\utility::add_start("mine_section", undefined, undefined);
  scripts\cp\utility::add_start("mine_section_laser_2", undefined, undefined);
  scripts\cp\utility::add_start("mine_section_laser_3", undefined, undefined);
  scripts\cp\utility::add_start("mine_section_postlasers", undefined, undefined);
  scripts\cp\utility::add_start("jugg_maze", undefined, undefined);
  scripts\cp\utility::add_start("jugg_maze_postkeycard", undefined, undefined);
  scripts\cp\utility::add_start("start_airlock_door", undefined, undefined);
  scripts\cp\utility::add_start("start_elevator", undefined, undefined);
  scripts\cp\utility::add_start("elevator_counter_weights", undefined, undefined);
  scripts\cp\utility::add_start("approach_elevator", undefined, undefined);
  scripts\cp\utility::add_start("elevator_defend", undefined, undefined);
  scripts\cp\utility::add_start("open_elevator_door", undefined, undefined);
  scripts\cp\utility::add_start("elevator_testing", undefined, undefined);
  scripts\cp\utility::set_default_start("captured");
  scripts\cp\utility::coop_mode_enable(["sp_stealth"]);
  scripts\cp\utility::coop_mode_enable();
  scripts\cp\raid_utility::setup_lights_in_region("non_alert_mode");
  scripts\cp\raid_utility::setup_lights_in_region("alert_mode");
  _id_4D346DA49A80368C::play_lighting_sequence("alert_mode");
  _id_230C7BB3F08D2D78::_id_C773479E45DC40A8();
  scripts\cp\compass::setupminimap("compass_map_cp_jugg_maze");
  _id_D525F1534752BFC7();
  _id_2CFEF434CE6A1C44();
  _id_279964C2C969DDA3();
  _id_3861EB0A004E0D38();
  _id_C4D555BF9485AC3B();
  level thread scripts\cp\intel\cp_intel::intel_init();
  thread _id_FA191B1C184F006C();
  thread _id_F2A617C816350F5D();
  thread _id_785A97944731F5D4();

  if(getdvarint("dvar_74C4EB895FCCEF41", 1))
    _id_85A766255B6685D3();

  thread _id_055B8229C19C258D::_id_7B6E96193E81C072();
}

_id_85A766255B6685D3() {
  level._id_4A2590C2DFE94983 = ["iw9_sm_aviktor_mp", "iw9_sm_alpha57_mp", "iw9_sm_mpapa5_mp", "iw9_sm_victor_mp", "iw9_sm_apapa_mp"];
  level._id_360370415A0CE15F = ["iw9_ar_golf3_mp", "iw9_ar_kilo53_mp", "iw9_ar_mike16_mp", "iw9_ar_akilo105_mp", "iw9_ar_akilo74_mp", "iw9_ar_schotel_mp", "iw9_ar_augolf_mp", "iw9_ar_mcbravo_mp"];
  level._id_F121B39847BCA5E8 = ["iw9_lm_kilo21_mp", "iw9_lm_slima_mp", "iw9_lm_foxtrot_mp", "iw9_lm_rkilo_mp", "iw9_lm_ahotel_mp"];
  level._id_F0525567BC0FFA6A = ["iw9_sh_mbravo_mp", "iw9_sh_charlie725_mp", "iw9_sh_mviktor_mp"];
  level._id_121443DFD453E6A3 = ["reddot", "laser", "holo", "therm", "hybrid", "comp", "grip", "magazine"];
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_74C4EB895FCCEF41", 1);
}

_id_C1F55F1B5A7BED96() {
  _id_9B2CD2CF9CF3F36C();
  scripts\cp_mp\utility\script_utility::registersharedfunc("player_spawn", "getPlayerSpawnPointOverride", _id_424D9A66F5FD1677::_id_04BFC487778DC703);
  level._id_5966C39CB60075F1 = _id_424D9A66F5FD1677::_id_D78368E4F9DBAAF2;
  level.objectivesfunc = _id_424D9A66F5FD1677::_id_C2A86F682BF1AB71;
  level thread _id_424D9A66F5FD1677::_id_AEACA15C955FE85C();
  scripts\cp\cp_objectives::run_objective("captured");
}

_id_742712ADA9D7A002() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("player_spawn", "getPlayerSpawnPointOverride", _id_424D9A66F5FD1677::_id_04BFC487778DC703);
  level.default_player_spawns = "escape_warehouse_spawner";
  scripts\cp\cp_objectives::run_objective("escapeWarehouse");
  setDvar("dvar_E8512E1508AFEFE8", 1);
  level.pingsystemactive = getdvarint("dvar_E8512E1508AFEFE8", 1);
}

_id_6F02AF154BFEE3DB() {
  level._id_5966C39CB60075F1 = _id_424D9A66F5FD1677::_id_D78368E4F9DBAAF2;
  game["enable_farah_chair_animation"] = 0;
  level thread _id_424D9A66F5FD1677::_id_AEACA15C955FE85C();
}

_id_BE1D62385C255B4F() {
  level.objectivesfunc = ::_id_C2A86F682BF1AB71;
  _id_9B2CD2CF9CF3F36C();
  scripts\cp_mp\utility\script_utility::registersharedfunc("player_spawn", "getPlayerSpawnPointOverride", undefined);
  level.default_player_spawns = "mine_section_spawner";
  scripts\cp\cp_objectives::run_objective("mineSection");
}

_id_F4B722CD2A5A8AB2() {
  level.objectivesfunc = ::_id_C2A86F682BF1AB71;
  _id_9B2CD2CF9CF3F36C();
  scripts\cp_mp\utility\script_utility::registersharedfunc("player_spawn", "getPlayerSpawnPointOverride", undefined);
  level._id_18E49A0C7828BE42 = 2;
  thread _id_407E0F6FC77840B3::_id_89EA2CE2247DA968(2);
  scripts\cp\cp_objectives::run_objective("mineSection");
}

_id_F4B723CD2A5A8CE5() {
  level.objectivesfunc = ::_id_C2A86F682BF1AB71;
  _id_9B2CD2CF9CF3F36C();
  scripts\cp_mp\utility\script_utility::registersharedfunc("player_spawn", "getPlayerSpawnPointOverride", undefined);
  level._id_18E49A0C7828BE42 = 3;
  thread _id_407E0F6FC77840B3::_id_89EA2CE2247DA968(3);
  scripts\cp\cp_objectives::run_objective("mineSection");
}

_id_36E8F31EC609DB6E() {
  level.objectivesfunc = ::_id_C2A86F682BF1AB71;
  _id_9B2CD2CF9CF3F36C();
  scripts\cp_mp\utility\script_utility::registersharedfunc("player_spawn", "getPlayerSpawnPointOverride", undefined);
  level.default_player_spawns = "checkpoint_mine_postlasers";
  level._id_A4265F9F9DEDAB35 = 1;
  scripts\engine\utility::flag_set("checkpoint_activated_mine_section_post_lasers");
  thread _id_407E0F6FC77840B3::_id_4EE58979F91CBB23();
  scripts\cp\cp_objectives::run_objective("mineSection");
}

_id_0738A0CBC30B510B() {
  level.objectivesfunc = ::_id_C2A86F682BF1AB71;
  _id_9B2CD2CF9CF3F36C();
  scripts\cp_mp\utility\script_utility::registersharedfunc("player_spawn", "getPlayerSpawnPointOverride", undefined);
  level.default_player_spawns = "stealth_section_spawner";
  scripts\cp\cp_objectives::run_objective("stealthSection");
}

_id_98264BCEC5C5BBC5() {
  level.objectivesfunc = ::_id_C2A86F682BF1AB71;
  level.default_player_spawns = "jugg_maze_spawner";
  _id_9B2CD2CF9CF3F36C();
  level.getspawnpoint = _id_0598E0C00C8151F7::getspawnpoint;
  level._id_317452953C148027 = undefined;
  scripts\cp\utility::_id_C0D2C91F2688ECE4(0);
  thread _id_242A2441CBD54AF1::_id_2367B56419EC69ED();
  scripts\cp\cp_objectives::run_objective("turnoffGas");
}

_id_A0A40FE61398BF0B() {
  level.objectivesfunc = ::_id_C2A86F682BF1AB71;
  scripts\cp\cp_objectives::run_objective("phase1");
}

_id_AD114DD4408B6070() {
  level.objectivesfunc = ::_id_C2A86F682BF1AB71;
  scripts\cp\cp_objectives::run_objective("phase2");
}

_id_19E817BFC5E2049D() {
  level.objectivesfunc = ::_id_C2A86F682BF1AB71;
  scripts\cp\cp_objectives::run_objective("phase3");
}

_id_7729165B1CA5D892() {
  level.objectivesfunc = ::_id_C2A86F682BF1AB71;
  scripts\cp\cp_objectives::run_objective("phase4");
}

_id_D1C1792955EE912F() {
  level endon("game_ended");
  level._id_A6E002E7FA1DF0C3 = 1;
  scripts\engine\utility::flag_wait("cp_raid_complex_jugg_maze_completed");
  struct = scripts\engine\utility::getStruct("checkpoint_keycard_spawn", "targetname");
  struct _id_4BB23F70102CF6BC::_id_C5979FDECB85AC32(undefined, (0, 0, 64));
}

_id_52107F2E92914747() {
  thread _id_D2630F2DE891DFB2("airlockDoor", 1);
  scripts\engine\utility::flag_set("unlock_exit_door_now");
}

_id_8938F74AFDBE2683() {
  level endon("game_ended");

  while(!isDefined(level.players))
    waitframe();

  while(level.players.size == 0)
    waitframe();

  player = level.players[0];
  player _id_531CB1BE084314F7::br_forcegivecustompickupitem(player, "interactable_note_keycard_raid4_maze", 0, 1, 0, 0);
  level._id_2313A19F59121665 = player;
  player thread _id_4BB23F70102CF6BC::_id_1E337E98B672B9EA("interactable_note_keycard_raid4_maze");
}

_id_A96679D1A7DC6AF4() {
  level.objectivesfunc = ::_id_C2A86F682BF1AB71;
  level.getspawnpoint = _id_0598E0C00C8151F7::getspawnpoint;
  thread _id_242A2441CBD54AF1::_id_2367B56419EC69ED();
  _id_407E0F6FC77840B3::_id_52FABB5C93DEB661();
  level thread _id_7F2FD7FC559755E4::_id_746C1B1EC4F81AC4();
  scripts\cp\cp_objectives::run_objective("airlockDoor");
}

_id_DAA0B98A03FA5A7E(_id_256D0E44EE22C83C) {
  level.getspawnpoint = _id_0598E0C00C8151F7::getspawnpoint;
  level notify("escaped_maze");
  scripts\cp_mp\utility\script_utility::registersharedfunc("player_spawn", "getPlayerSpawnPointOverride", undefined);
  scripts\cp\utility::_id_C0D2C91F2688ECE4(1);
  _id_9B2CD2CF9CF3F36C();
  level._id_EF0F2E9F39B9E2F8 = _id_3C2AAAD486A9AA1D::_id_EF0F2E9F39B9E2F8;
  level thread _id_3C2AAAD486A9AA1D::_id_E38BA6BA9E3DC3E8();
  scripts\engine\utility::flag_set("3man_door_elevator_door_open");
  _id_4F1F43B1ED3AF8F9::registeronplayerspawncallback(::_id_7BABC3AC021A79C1);

  if(isDefined(level.players) && level.players.size > 0) {
    foreach(player in level.players)
    player _id_7BABC3AC021A79C1();
  }

  level.enter_spectator_func = _id_0AFB7E332AEE4BF2::enable_dogtag_revive;

  switch (_id_256D0E44EE22C83C) {
    case "elevator_testing":
      _id_18A73A64992DD07D::run_spawn_module("hadir_spawn");
      level.default_player_spawns = "hadir_elevator_spawner";
      level notify("stop_elevator_startHadirElevator_early");
      scripts\engine\utility::flag_set("hadir_elevator_crashed");
      break;
    case "start_elevator":
      _id_18A73A64992DD07D::run_spawn_module("hadir_spawn");
      _id_BE7D97403790251A();
      level.default_player_spawns = "hadir_elevator_spawner";
      level._id_EF0F2E9F39B9E2F8 = _id_3C2AAAD486A9AA1D::_id_EF0F2E9F39B9E2F8;
      level thread _id_3C2AAAD486A9AA1D::_id_E38BA6BA9E3DC3E8();
      break;
    case "elevator_counter_weights":
      _id_18A73A64992DD07D::run_spawn_module("hadir_spawn");
      level.default_player_spawns = "hadir_elevator_spawner_front";
      level notify("stop_elevator_startHadirElevator_early");
      break;
    case "approach_elevator":
      _id_18A73A64992DD07D::run_spawn_module("hadir_spawn_wounded");
      level.enter_spectator_func = ::_id_84E53AFDA38443EA;
      level.default_player_spawns = "hadir_elevator_defend_spawner";
      level._id_5B03A5AE77E0C13B = 1;
      scripts\cp\utility::_id_C0D2C91F2688ECE4(0);
      level notify("stop_elevator_startHadirElevator_early");
      scripts\engine\utility::flag_set("hadir_elevator_crashed");
      break;
    case "elevator_defend":
      _id_18A73A64992DD07D::run_spawn_module("hadir_spawn_wounded");
      level.enter_spectator_func = _id_0AFB7E332AEE4BF2::enable_dogtag_revive;
      level.default_player_spawns = "hadir_elevator_defend_spawner";
      scripts\cp\utility::_id_C0D2C91F2688ECE4(0);
      thread _id_5BFAE098E412E016();
      level._id_5B03A5AE77E0C13B = 1;
      level notify("stop_elevator_startHadirElevator_early");
      break;
    case "open_elevator_door":
      _id_18A73A64992DD07D::run_spawn_module("hadir_spawn_wounded");
      level.enter_spectator_func = _id_0AFB7E332AEE4BF2::enable_dogtag_revive;
      level.default_player_spawns = "hadir_elevator_spawner";
      scripts\cp\utility::_id_C0D2C91F2688ECE4(0);
      level notify("stop_elevator_startHadirElevator_early");
      scripts\engine\utility::flag_set("hadir_elevator_crashed");
      break;
  }

  scripts\cp\cp_objectives::run_objective(_id_256D0E44EE22C83C);
}

_id_84E53AFDA38443EA(_id_1730C8D8475566CD) {
  if(istrue(level.gameended)) {
    return;
  }
  if(isDefined(_id_1730C8D8475566CD.dogtag)) {
    return;
  }
  _id_E0CBA2B0A5510D09 = _id_1730C8D8475566CD[[level.getspawnpoint]]();
  _id_BBDCC7365DD1C6BA = _id_E0CBA2B0A5510D09.origin;

  if(istrue(level._id_920CBA4B7B32D2A9))
    _id_BBDCC7365DD1C6BA = scripts\engine\utility::drop_to_ground(_id_BBDCC7365DD1C6BA, 64);

  if(istrue(level._id_57640B5729015657))
    _id_BBDCC7365DD1C6BA = getclosestpointonnavmesh(_id_BBDCC7365DD1C6BA);

  dogtag = spawn("script_model", _id_BBDCC7365DD1C6BA + (0, 0, 40));
  dogtag _id_0AFB7E332AEE4BF2::_id_C919AFEBF9FE06C4(_id_1730C8D8475566CD);
  _id_1730C8D8475566CD.respawn_forcespawnorigin = _id_BBDCC7365DD1C6BA + (0, 0, 5);
  _id_1730C8D8475566CD.respawn_forcespawnangles = (0, 0, 0);
  _id_1730C8D8475566CD.dogtag = dogtag;
  _id_1730C8D8475566CD.dogtag.owner = _id_1730C8D8475566CD;
  dogtag.owner = _id_1730C8D8475566CD;
  _id_1730C8D8475566CD._id_F13B2C408FE7BA46 = _id_1730C8D8475566CD _id_7EF95BBA57DC4B82::getequipmentslotammo("health");
  _id_1DAB4A6BAD01C509 = _id_1730C8D8475566CD getentitynumber();
  _id_C9F85AEFA1694334 = dogtag getentitynumber();
  _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "ui_dog_tags_entity_num", _id_C9F85AEFA1694334);

  if(!istrue(_id_1730C8D8475566CD._id_A14C34F117DAF30A))
    _id_0AFB7E332AEE4BF2::_id_0449348B412E6B21(_id_1730C8D8475566CD, dogtag, (0.929, 0.231, 0.141));

  dogtag hudoutlineenable("outline_nodepth_white");
  dogtag thread _id_0AFB7E332AEE4BF2::revivetriggerthink(_id_1730C8D8475566CD.team);
  dogtag thread _id_0AFB7E332AEE4BF2::endreviveonownerdeathordisconnect();
  dogtag thread _id_0AFB7E332AEE4BF2::_id_5C02BCA10D532C9B(_id_1730C8D8475566CD);

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
    dogtag thread _id_0AFB7E332AEE4BF2::_id_AF3BD2E64377CD03();

  level notify("laststand_dogtag_spawned", dogtag);
}

_id_D970475921A5D23C() {}

_id_FF4F7DBC45EB0223() {
  _id_DAA0B98A03FA5A7E("start_elevator");
}

_id_BE7D97403790251A() {}

_id_B728FCE6270C27BF() {
  _id_DAA0B98A03FA5A7E("elevator_defend");
}

_id_5BFAE098E412E016() {}

_id_9231439A1A500C1B() {
  _id_DAA0B98A03FA5A7E("elevator_counter_weights");
}

_id_8305E6D7D3565C55() {
  _id_DAA0B98A03FA5A7E("approach_elevator");
}

_id_68C02A3CDFA27817() {
  _id_DAA0B98A03FA5A7E("open_elevator_door");
}

_id_2CFEF434CE6A1C44() {
  level.custom_onspawnplayer_func = ::onplayerspawned;
  level.custom_onplayerconnect_func = ::onplayerconnect;
  level._id_2184802E7B6495DD = ::_id_E7A64DF827074B05;
}

onplayerconnect(player) {}

_id_9B2CD2CF9CF3F36C() {
  game["override_checkpoint_func"] = undefined;
  game["override_checkpoint_spawn_name"] = undefined;
}

onplayerspawned() {
  _id_7BABC3AC021A79C1();
  thread _id_B7A1D836D257B8BD();

  if(getdvarint("dvar_71205F15C1C7F113", 0))
    _id_12E2FB553EC1605E::_id_E2D370937C694C58("fists", undefined, "knife", undefined);

  _id_12E2FB553EC1605E::_id_EBF2582B122904FC("equip_throwing_knife", "equip_smoke");
  thread setup_player_stealth();
  thread _id_7F2FD7FC559755E4::_id_F544E1F770400812();

  if(getdvarint("dvar_3F889D9E485927CE", 0))
    thread _id_7F2FD7FC559755E4::_id_6D7327642515D1BB();

  thread _id_A43082CF8282E6DB();
  _id_055B8229C19C258D::_id_82E02994003CFFF7(self);
  thread monitor_player_jump();
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(isDefined(checkpoint) && checkpoint != "") {
    switch (checkpoint) {
      case "checkpoint_captured_blind":
        _id_424D9A66F5FD1677::onplayerspawned();
        break;
      case "checkpoint_rescue_warehouse":
        _id_424D9A66F5FD1677::_id_D78368E4F9DBAAF2();
        break;
      case "checkpoint_stealth_section":
        break;
      case "checkpoint_mine_section_postlasers":
      case "checkpoint_mine_section":
        break;
      case "checkpoint_jugg_maze":
        if(isDefined(level._id_6E6C8E9CA9C42A38) && isDefined(level._id_6E6C8E9CA9C42A38.juggobjid))
          scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level._id_6E6C8E9CA9C42A38.juggobjid, self);

        break;
      default:
        break;
    }
  } else {
    start = getDvar("start");

    if(start == "captured" || start == "")
      thread _id_424D9A66F5FD1677::_id_861DCC9779702ADB();
    else if(start == "escape_warehouse")
      _id_424D9A66F5FD1677::_id_D78368E4F9DBAAF2();
    else if(start == "jugg_maze") {
      if(isDefined(level._id_6E6C8E9CA9C42A38) && isDefined(level._id_6E6C8E9CA9C42A38.juggobjid))
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level._id_6E6C8E9CA9C42A38.juggobjid, self);
    }
  }
}

_id_30FEE9B740DBE6F7() {
  self endon("disconnect");
  waitframe();
  _id_5E5507D57BBBB709::_id_79CD95DA38030C14();

  if(getdvarint("dvar_FD0C6683681E1796", 0)) {
    self.perk_data["weapons_have_full_ammo"] = undefined;
    _id_66122A002AFF5D57::br_ammo_player_clear();
    weapons = self.primaryweapons;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < weapons.size; _id_AC0E594AC96AA3A8++) {
      self setweaponammoclip(weapons[_id_AC0E594AC96AA3A8], 0);
      _id_811ABFDB6C33F17F = _id_66122A002AFF5D57::br_ammo_type_for_weapon(weapons[_id_AC0E594AC96AA3A8]);
      _id_66122A002AFF5D57::br_ammo_give_type(self, _id_811ABFDB6C33F17F, 0, 0, 1);
    }
  }
}

_id_A43082CF8282E6DB() {
  self endon("disconnect");

  for(;;) {
    self waittill("used_oxygen_mask");
    _id_7F2FD7FC559755E4::_id_2B2F2B3CC2194C30();
  }
}

setup_player_stealth() {
  self notify("setup_player_stealth");
  self endon("setup_player_stealth");
  self endon("disconnect");
  self waittill("spawned_player");

  if(scripts\cp\coop_stealth::level_should_run_sp_stealth()) {
    scripts\engine\utility::flag_wait("level_stealth_initialized");
    scripts\stealth\player::main();
    thread _id_7C110E744404EE81::_id_9FF225017EF5CE19();
    _func_531194F673A06DE5(0);
    thread scripts\cp\coop_stealth::suspicious_door_monitor();
  }
}

_id_279964C2C969DDA3() {
  thread _id_DD3140C9BEF539AE();
  thread _id_45F0E1DC4CE9ECCB::setup_functions();
}

_id_DD3140C9BEF539AE() {
  if(getdvarint("dvar_E98B722860D5D3BA", 0) != 0)
    scripts\cp\utility::_id_0C72FF775CD61B11("dvar_73621D9D9F54E301", 1, 0);
  else
    scripts\cp\utility::_id_0C72FF775CD61B11("dvar_73621D9D9F54E301", 0, 0);

  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_67B9B5372E348994", 10.0, _id_4D5D872A7BD5C0C3::_id_67939C281EB5C262());
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_1280AC8EF0DD0E07", 1, 0);
}

_id_3861EB0A004E0D38() {
  level.objectivesfunc = ::_id_C2A86F682BF1AB71;
  thread scripts\cp\cp_objectives::objectives_init();
}

_id_C4D555BF9485AC3B() {
  _id_A8509B006BBB4598();
  setup_create_script();
  scripts\cp\utility::_id_BB3E0C926B0667C4("captured,escape_warehouse,stealth_section,mine_section,mine_section_laser_2,mine_section_laser_3,mine_section_postlasers,jugg_maze,jugg_maze_postkeycard,start_airlock_door,start_elevator,elevator_counter_weights,approach_elevator,elevator_defend,open_elevator_door,elevator_testing");
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(isDefined(checkpoint) && checkpoint != "" && isDefined(level.registered_checkpoint_funcs[checkpoint]))
    level thread[[level.registered_checkpoint_funcs[checkpoint]]]();
  else
    level thread _id_E819355654F9E50D();

  level thread _id_FC4803DC319A81D2();
  level._id_29BFEE4A5CE55C20 = scripts\engine\trace::create_contents(1, undefined, undefined, 1, 1, 1, undefined, undefined);
  level._id_95B8B02E43BCA8DB = ::_id_AA38A86A8D57D526;
  thread _id_4D346DA49A80368C::register_jugg_maze_objectives();
  _id_6DFBCC75F3D13DD3::_id_B04F37F19C6631E0();
  level thread _id_424D9A66F5FD1677::main();
  level thread _id_531C536DCD04E20F::main();
  level thread _id_242A2441CBD54AF1::main();
  level thread _id_3C2AAAD486A9AA1D::main();
  _id_266C399FB76E6719::register_aitype_setup("hadir", "enemy_cp_hadir_boss");
  level._id_CEE48B761F8CA747 = 0;
}

_id_A8509B006BBB4598() {
  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    _id_01EC781F5C365546 = getdvarint("dvar_6B92186116FA2C1A", 120);
    _id_3AE8C243F1C86858 = getdvarint("dvar_72523AD696A1466C", 90);
    _id_B02AE2D8D510669A = getdvarint("dvar_F85AFB0CAFB8CEDA", 60);
  } else {
    _id_01EC781F5C365546 = getdvarint("dvar_57825A5CAF4A6BA6", 120);
    _id_3AE8C243F1C86858 = getdvarint("dvar_3C9CD8B3E1743AA8", 90);
    _id_B02AE2D8D510669A = getdvarint("dvar_1E73113AA67EC8A6", 60);
  }

  _id_1E22D314CC16F807::_id_6CCB377E839D87C4(_id_01EC781F5C365546 * 60, _id_3AE8C243F1C86858 * 60, _id_B02AE2D8D510669A * 60);
}

_id_2737CE5F24699A0D() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("objectives_registered");
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(isDefined(checkpoint) && checkpoint != "" && isDefined(level.registered_checkpoint_funcs[checkpoint]))
    level thread[[level.registered_checkpoint_funcs[checkpoint]]]();
}

_id_DAE7BA0B1B96ACF1() {
  scripts\cp\cp_objectives::registerobjective("captured", ::_id_8D2BD4145032E443, ::_id_62146D62846B7503, ::_id_1C5C0BA5B96BEB6A, scripts\cp\cp_objectives::debugbeatobjective, undefined);
  scripts\cp\cp_objectives::registerobjective("escapeWarehouse", ::_id_97CFD9157AB8EB08, ::_id_9B6CE61390AD6DFF, ::_id_C76D6660B125BAF4, scripts\cp\cp_objectives::debugbeatobjective, undefined);
  scripts\cp\cp_objectives::registerobjective("stealthSection", ::_id_B20DA7FFB19EA50A, ::_id_008A553BB6E1B9E2, ::_id_355245BE4BF6521D, scripts\cp\cp_objectives::debugbeatobjective, _id_531C536DCD04E20F::_id_7F77182E4FAA9C0F);
  scripts\cp\cp_objectives::registerobjective("mineSection", ::_id_76A3107C26E2BAFE, ::_id_7092B7C4E5304712, ::_id_554F348D3E25EC5F, scripts\cp\cp_objectives::debugbeatobjective, ::_id_2FF84559B2D5117D);
  scripts\cp\cp_objectives::registerobjective("turnoffGas", ::_id_A9C9D5CF4F4E797E, ::_id_E689F2DF41E0AEFA, ::_id_7450F8109F0984FF, scripts\cp\cp_objectives::debugbeatobjective, undefined);
  scripts\cp\cp_objectives::registerobjective("phase1", ::_id_8D2BD4145032E443, ::_id_907F066E8E3543EE, ::_id_C856A1883C88A9E5, scripts\cp\cp_objectives::debugbeatobjective, undefined);
  scripts\cp\cp_objectives::registerobjective("phase2", ::_id_8D2BD4145032E443, ::_id_907F056E8E3541BB, ::_id_C8569E883C88A34C, scripts\cp\cp_objectives::debugbeatobjective, undefined);
  scripts\cp\cp_objectives::registerobjective("phase3", ::_id_8D2BD4145032E443, ::_id_907F046E8E353F88, ::_id_C8569F883C88A57F, scripts\cp\cp_objectives::debugbeatobjective, undefined);
  scripts\cp\cp_objectives::registerobjective("phase4", ::_id_8D2BD4145032E443, ::_id_907F0B6E8E354EED, ::_id_C8569C883C889EE6, scripts\cp\cp_objectives::debugbeatobjective, undefined);
  scripts\cp\cp_objectives::registerobjective("airlockDoor", ::_id_8D2BD4145032E443, ::_id_DA5E9A1C5E31507F, ::_id_10E152EB55750FBE, scripts\cp\cp_objectives::debugbeatobjective, undefined);
  scripts\cp\cp_objectives::registerobjective("start_elevator", ::_id_8D2BD4145032E443, ::_id_FDE407EAAA732A36, ::_id_A62A3FAD9516B6C9, scripts\cp\cp_objectives::debugbeatobjective, undefined);
  scripts\cp\cp_objectives::registerobjective("elevator_counter_weights", ::_id_8D2BD4145032E443, ::_id_950E61BE6A29A757, ::_id_E58D1C632D4F1710, scripts\cp\cp_objectives::debugbeatobjective, undefined);
  scripts\cp\cp_objectives::registerobjective("approach_elevator", ::_id_04E9EF2D83C324F3, ::_id_630BDB071ADF7D07, ::_id_09E700C9B50B3436, scripts\cp\cp_objectives::debugbeatobjective, undefined);
  scripts\cp\cp_objectives::registerobjective("elevator_defend", ::_id_04E9EF2D83C324F3, ::_id_5A74077943825A37, ::_id_48F8A44BCDADF9EE, scripts\cp\cp_objectives::debugbeatobjective, undefined);
  scripts\cp\cp_objectives::registerobjective("open_elevator_door", ::_id_04E9EF2D83C324F3, ::_id_55D0DBCE8A620C8C, ::_id_BCDBE2493D6017E7, scripts\cp\cp_objectives::debugbeatobjective, undefined);
  scripts\cp\cp_objectives::registerobjective("elevator_testing", ::_id_8D2BD4145032E443, ::_id_1A7E4478AF6821B9, ::_id_17AD10FABD934AFE, scripts\cp\cp_objectives::debugbeatobjective, undefined);
}

_id_62146D62846B7503(objectivestruct) {
  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("Raid: Jugg Maze - Captured");
  wait 1;
  level.stealth.bstayincombatoncealerted = 1;
  level._id_7F7502F7048DBCFE = "captured_cell_doors_button_pressed";
  setDvar("dvar_E8512E1508AFEFE8", 0);
  level.pingsystemactive = getdvarint("dvar_E8512E1508AFEFE8", 0);
  level._id_AD9B99883D277045 = "captured";
  scripts\cp\utility::_id_C0D2C91F2688ECE4(0);
  level waittill("captured_completed");
  scripts\cp\cp_analytics::_id_B6283AC45A607764("Raid: Jugg Maze - Captured");
  _id_45F0E1DC4CE9ECCB::_id_CCC48E4E354C87DF("checkpoint_rescue_warehouse");
  wait 0.5;
}

_id_1C5C0BA5B96BEB6A(objectivestruct) {
  level.stealth.bstayincombatoncealerted = 0;
  scripts\cp\utility::_id_C0D2C91F2688ECE4(1);
  wait 1;
  scripts\cp\cp_analytics::_id_B6283AC45A607764("Raid: Captured - Completed");
  wait 0.5;
}

_id_1210A7F037350857() {
  _id_75FE225EDD7413EF = getEnt("volume_stealth_section_groupa", "targetname");
  _id_FEF959335FC0E20F = [];
  level endon("game_ended");

  while(_id_FEF959335FC0E20F.size < level.players.size) {
    foreach(player in level.players) {
      if(player istouching(_id_75FE225EDD7413EF)) {
        _id_FEF959335FC0E20F = scripts\engine\utility::_id_6D6AF8144A5131F1(_id_FEF959335FC0E20F, player);

        if(_id_FEF959335FC0E20F.size == level.players.size) {
          scripts\cp\cp_create_script_utility::cleanup_cs_file_objects("cp_capture_jugg_create_script");
          scripts\cp\cp_create_script_utility::cleanup_cs_file_objects("prison_cells_surveillance");
        }
      }
    }

    waitframe();
  }
}

_id_97CFD9157AB8EB08(objectivestruct) {
  level.objectivesfunc = ::_id_C2A86F682BF1AB71;
  scripts\cp_mp\utility\script_utility::registersharedfunc("player_spawn", "getPlayerSpawnPointOverride", _id_424D9A66F5FD1677::_id_04BFC487778DC703);

  foreach(player in level.players)
  player _id_424D9A66F5FD1677::_id_27013CA5F99005FE(0);
}

_id_9B6CE61390AD6DFF(objectivestruct) {
  level thread _id_18AF78602B67B70C::_id_92233BCD56EA95C5("seq_captured_exit_door", undefined, 200);
  level._id_D5F8A16ECCBEF93F = 1;
  game["enable_farah_chair_animation"] = 0;
  setDvar("dvar_E8512E1508AFEFE8", 1);
  level.pingsystemactive = getdvarint("dvar_E8512E1508AFEFE8", 1);
  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("Raid: Jugg Maze - Escape the Warehouse");
  wait 1;
  level._id_AD9B99883D277045 = "escape_warehouse";
  game["override_checkpoint_func"] = _id_424D9A66F5FD1677::_id_04BFC487778DC703;
  game["override_checkpoint_spawn_name"] = "checkpoint_rescue_warehouse";
  level waittill("seq_captured_exit_door_door_open");
  scripts\cp\cp_analytics::_id_B6283AC45A607764("Raid: Jugg Maze - Escape the Warehouse");
  _id_45F0E1DC4CE9ECCB::_id_CCC48E4E354C87DF("checkpoint_stealth_section");
  wait 0.5;
}

_id_C76D6660B125BAF4(objectivestruct) {
  level._id_5966C39CB60075F1 = undefined;
  level._id_7F7502F7048DBCFE = undefined;
  level._id_942F39C640EF7CDE = undefined;
  scripts\engine\utility::flag_clear("sounded_alarm");

  foreach(player in level.players)
  player setclientomnvar("ui_earned_streak_visible", 1);

  scripts\cp\cp_analytics::_id_B6283AC45A607764("Raid: Escape Warehouse - Completed");
}

_id_B20DA7FFB19EA50A(objectivestruct) {
  level notify("farah_stop_squad_wipe_monitor");
  level.objectivesfunc = ::_id_C2A86F682BF1AB71;
  scripts\cp_mp\utility\script_utility::registersharedfunc("player_spawn", "getPlayerSpawnPointOverride", undefined);
  level.default_player_spawns = "stealth_section_spawner";
  _id_D5ECF70A4D407B43 = scripts\engine\utility::getStructArray("start_offhand_struct", "targetname");

  if(isDefined(_id_D5ECF70A4D407B43))
    _id_18AF78602B67B70C::level_offhand_spawn(_id_D5ECF70A4D407B43);

  _id_9B2CD2CF9CF3F36C();

  foreach(player in level.players) {
    _id_9985D7DCD9DD0D02 = player _id_5E5507D57BBBB709::_id_CC1CCC9E93B22C24();
    player _id_5E5507D57BBBB709::_id_C3CB4BDAE301D5B4(_id_9985D7DCD9DD0D02, undefined, 1, 1);
    player _id_424D9A66F5FD1677::_id_27013CA5F99005FE(1);
    player _id_531C536DCD04E20F::_id_CDF07F9BE860BF28();
  }

  thread _id_1210A7F037350857();
  level._id_289BE3C21F39E36B = ::_id_BDB149C2835E58DD;
  level._id_94ACA63D774C01F7 = scripts\engine\utility::getStructArray("dogtag_reloc_target_struct", "script_noteworthy");
}

_id_008A553BB6E1B9E2(objectivestruct) {
  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("Raid: Jugg Maze - Stealth Section");
  thread _id_531C536DCD04E20F::_id_383F128FBDC68574();
  level notify("farah_stop_squad_wipe_monitor");
  wait 1;
  level._id_AD9B99883D277045 = "stealth_section";
  level waittill("stealth_section_complete");
  scripts\cp\cp_analytics::_id_B6283AC45A607764("Raid: Jugg Maze - Stealth Section");
  _id_45F0E1DC4CE9ECCB::_id_CCC48E4E354C87DF("checkpoint_mine_section");
}

_id_355245BE4BF6521D(objectivestruct) {}

_id_7FAE653010889982() {
  level endon("game_ended");
  scripts\cp\cp_create_script_utility::cleanup_cs_file_objects("cp_jugg_maze_stealth_create_script");
  scripts\cp\utility::_id_9EE08F0499763465("vehicle_storage");

  if(isDefined(level._id_B6CD3626C14C131E))
    level._id_B6CD3626C14C131E = scripts\engine\utility::array_removeundefined(level._id_B6CD3626C14C131E);

  if(isDefined(level._id_289BE3C21F39E36B))
    level._id_289BE3C21F39E36B = undefined;

  scripts\engine\utility::flag_wait_either("resetting_mine", "minesection_all_players_down");

  if(!isDefined(level._id_5D782F80A85DE595))
    level._id_5D782F80A85DE595 = [];

  level._id_5D782F80A85DE595 = scripts\engine\utility::_id_FDC9D5557C53078E(level._id_5D782F80A85DE595);
  _id_18A73A64992DD07D::stop_all_groups();

  foreach(ai in level._id_5D782F80A85DE595) {
    _id_23E9C2248916F316 = 0;

    if(!isDefined(ai) || !isalive(ai)) {
      continue;
    }
    if(isDefined(ai.group)) {
      if(issubstr(ai.group.group_name, "laser_section"))
        continue;
    }

    if(istrue(_id_23E9C2248916F316)) {
      continue;
    }
    ai _id_18A73A64992DD07D::script_kill_ai();
  }

  level._id_5D782F80A85DE595 = scripts\engine\utility::_id_FDC9D5557C53078E(level._id_5D782F80A85DE595);
  scripts\cp\tripwire_cp::_id_7BDA4E577B34A556();
}

_id_76A3107C26E2BAFE(objectivestruct) {
  thread _id_7FAE653010889982();
  _id_DFF36B127E9E9C23 = scripts\engine\utility::getStruct("keycard_laser_drop", "targetname");
  _id_DFF36B127E9E9C23 _id_4BB23F70102CF6BC::_id_C5979FDECB85AC32("interactable_note_keycard_raid4_ee", undefined, 1, 1, 1, 1);
  level.objectivesfunc = ::_id_C2A86F682BF1AB71;
  scripts\cp_mp\utility\script_utility::registersharedfunc("player_spawn", "getPlayerSpawnPointOverride", undefined);
  level.default_player_spawns = "mine_section_spawner";
  level._id_507FE054D5119EB8 = objectivestruct;
  _id_75CCA5F01448E89D = scripts\engine\utility::getStruct("mine_dogtag_reloc", "script_noteworthy");

  if(!isDefined(level._id_B6CD3626C14C131E))
    level._id_B6CD3626C14C131E = [];

  if(isDefined(_id_75CCA5F01448E89D))
    level._id_B6CD3626C14C131E[level._id_B6CD3626C14C131E.size] = _id_75CCA5F01448E89D;

  if(!istrue(level._id_A4265F9F9DEDAB35)) {
    level._id_B3A61E1FD4CE7D8A = 1;
    scripts\engine\utility::flag_set("mine_laser_section_started");
    _id_407E0F6FC77840B3::_id_0F6E176283800858();
  } else {}
}

_id_7092B7C4E5304712(objectivestruct) {
  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("Raid: Jugg Maze - Mine Section");
  wait 1;
  level._id_AD9B99883D277045 = "mine_section";
  level waittill("mine_section_complete");
  _id_407E0F6FC77840B3::_id_568AA623C33A6726();

  if(getdvarint("dvar_733A1D9498A8DDD4", 1) == 0)
    scripts\cp\cp_objectives::freeworldid(level._id_507FE054D5119EB8._id_0EC9392B7DF7312F);

  scripts\cp\cp_analytics::_id_B6283AC45A607764("Raid: Jugg Maze - Mine Section");
  _id_45F0E1DC4CE9ECCB::_id_CCC48E4E354C87DF("checkpoint_jugg_maze");
  _id_45F0E1DC4CE9ECCB::_id_CCC48E4E354C87DF("checkpoint_jugg_maze_section_postvent");
  _id_4F062757A03920DF();
}

_id_4F062757A03920DF() {
  level._id_7B5771F0D3E048A0 = scripts\engine\utility::array_removeundefined(level._id_7B5771F0D3E048A0);

  foreach(_id_FF03DED389B65A7D in level._id_7B5771F0D3E048A0) {
    foreach(turret in _id_FF03DED389B65A7D.turrets) {
      if(!isDefined(turret)) {
        continue;
      }
      if(!turret._id_779C916529C44B1A _id_3AE866A6DD08DAF9::_id_A0857113D8C32A2A())
        turret _id_3AE866A6DD08DAF9::_id_0D33F98412123374(1);
      else
        turret _id_3AE866A6DD08DAF9::_id_0D33F98412123374();

      _id_3AE866A6DD08DAF9::_id_277B35006FAB38DD(turret);

      if(isDefined(turret.targetent))
        turret.targetent delete();

      if(isDefined(turret._id_4CF58793CC4F1AD6))
        turret._id_4CF58793CC4F1AD6 delete();

      turret delete();
    }

    if(isDefined(_id_FF03DED389B65A7D) && isDefined(_id_FF03DED389B65A7D._id_C1ABC60CE5507E66))
      _id_FF03DED389B65A7D._id_C1ABC60CE5507E66 delete();
  }

  foreach(_id_7F5945B55E97B8B0 in level.explosive_barrels) {
    foreach(_id_DDC4E4BDECFF28CD in _id_7F5945B55E97B8B0) {
      if(isDefined(_id_DDC4E4BDECFF28CD.clip)) {
        foreach(_id_CE1C2A78F56E043E in _id_DDC4E4BDECFF28CD.clip) {
          if(isDefined(_id_CE1C2A78F56E043E))
            _id_CE1C2A78F56E043E delete();
        }
      }

      if(_id_DDC4E4BDECFF28CD getscriptableisreserved())
        _id_DDC4E4BDECFF28CD freescriptable();
    }
  }

  if(isDefined(level._id_2BC9DA10C058E6BC)) {
    level._id_2BC9DA10C058E6BC = scripts\engine\utility::array_removeundefined(level._id_2BC9DA10C058E6BC);

    foreach(_id_53571FEF38A61A0C in level._id_2BC9DA10C058E6BC)
    _id_53571FEF38A61A0C delete();
  }
}

_id_554F348D3E25EC5F(objectivestruct) {}

_id_2FF84559B2D5117D() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("cp_jugg_maze_create_script_completed");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "mine_section_spawner", 1);
}

_id_A9C9D5CF4F4E797E(objectivestruct) {
  level notify("farah_stop_squad_wipe_monitor");
  level.objectivesfunc = ::_id_C2A86F682BF1AB71;
  level.default_player_spawns = "jugg_maze_spawner";
  level.getspawnpoint = _id_0598E0C00C8151F7::getspawnpoint;
  level._id_317452953C148027 = undefined;
  level._id_F107BD5B4C54277E = undefined;
  level._id_238D7505B0146B84 = ::_id_75B8976CF0C4104F;
  level._id_128B1F12D77A7EEB = ::_id_C28066D826277380;
  level._id_59B902EE02E6F52C = ::_id_E3EC5AB573FDB1A7;
  level._id_3F0D398EA9B0E906 = 14;
  level._id_289BE3C21F39E36B = ::_id_C56F95CF7E0C190B;
  level._id_E9DED374A39ECF8E = scripts\engine\utility::getStructArray("dogtag_revive_loc_maze_vent", "script_noteworthy");
  _id_D5ECF70A4D407B43 = scripts\engine\utility::getStructArray("start_offhand_struct", "targetname");

  if(isDefined(_id_D5ECF70A4D407B43))
    _id_18AF78602B67B70C::level_offhand_spawn(_id_D5ECF70A4D407B43);

  scripts\cp\utility::_id_C0D2C91F2688ECE4(0);
  thread _id_D2630F2DE891DFB2("airlockDoor");
}

_id_E689F2DF41E0AEFA(objectivestruct) {
  if(getdvarint("dvar_3C6E27FF56522CC4", 1) != 0)
    level.coop_gameshouldendfunc = ::_id_F8C99FB28FA6A3DB;

  level._id_CEE48B761F8CA747 = 0;
  _id_0598E0C00C8151F7::_id_C47EE3C82EA9FA70();
  scripts\engine\utility::flag_set("jugg_maze_objective_started");
  level thread _id_4D346DA49A80368C::main();
  level thread _id_4D346DA49A80368C::start_timed_event_on_detection(objectivestruct);
  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("Raid: Jugg Maze - Turn off Gas");
  wait 1;
  level._id_AD9B99883D277045 = "turnoff_gas";
  level waittill("stopping_gas");
  scripts\cp\cp_analytics::_id_B6283AC45A607764("Raid: Jugg Maze - Turn off Gas");
  _id_45F0E1DC4CE9ECCB::_id_CCC48E4E354C87DF("checkpoint_jugg_maze_section_postcore");
  scripts\engine\utility::flag_set("unlock_exit_door_now");
  wait 0.5;
}

_id_7450F8109F0984FF(objectivestruct) {
  wait 1;
  waitframe();
  level.coop_gameshouldendfunc = undefined;
  scripts\cp\utility::_id_C0D2C91F2688ECE4(1);
  setomnvar("ui_raid_lua_render_stage", 0);
  level._id_EF0F2E9F39B9E2F8 = _id_3C2AAAD486A9AA1D::_id_EF0F2E9F39B9E2F8;
  level thread _id_3C2AAAD486A9AA1D::_id_E38BA6BA9E3DC3E8();
}

_id_907F066E8E3543EE(objectivestruct) {
  level thread _id_4D346DA49A80368C::start_timed_event_on_detection(objectivestruct);
  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("Raid: Jugg Maze - Phase 1");
  wait 1;
  level._id_AD9B99883D277045 = "phase1";
  level waittill("phase_1_complete");
  scripts\cp\cp_analytics::_id_B6283AC45A607764("Raid: Jugg Maze - Phase 1");
  wait 0.5;
}

_id_C856A1883C88A9E5(objectivestruct) {
  wait 1;
  waitframe();
}

_id_907F056E8E3541BB(objectivestruct) {
  level thread _id_4D346DA49A80368C::start_timed_event_on_detection(objectivestruct);
  level.current_button_counter = 1;
  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("Raid: Jugg Maze - Phase 2");
  wait 1;
  level._id_AD9B99883D277045 = "phase2";
  level waittill("phase_2_complete");
  scripts\cp\cp_analytics::_id_B6283AC45A607764("Raid: Jugg Maze - Phase 2");
  wait 0.5;
}

_id_C8569E883C88A34C(objectivestruct) {
  wait 1;
  waitframe();
}

_id_907F046E8E353F88(objectivestruct) {
  level thread _id_4D346DA49A80368C::start_timed_event_on_detection(objectivestruct);
  level.current_button_counter = 2;
  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("Raid: Jugg Maze - Phase 3");
  wait 1;
  level._id_AD9B99883D277045 = "phase3";
  level waittill("phase_3_complete");
  scripts\cp\cp_analytics::_id_B6283AC45A607764("Raid: Jugg Maze - Phase 3");
  wait 0.5;
}

_id_C8569F883C88A57F(objectivestruct) {
  wait 1;
  waitframe();
}

_id_907F0B6E8E354EED(objectivestruct) {
  level.jugg_objective_struct = objectivestruct;
  level thread _id_4D346DA49A80368C::start_timed_event_on_detection(objectivestruct);
  level.current_button_counter = 3;
  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("Raid: Jugg Maze - Phase 4");
  wait 1;
  level._id_AD9B99883D277045 = "phase4";
  level scripts\engine\utility::waittill_either("phase_5_complete", "escaped_maze");
  scripts\cp\cp_analytics::_id_B6283AC45A607764("Raid: Jugg Maze - Phase 4");
  wait 0.5;
}

_id_C8569C883C889EE6(objectivestruct) {
  wait 1;
  waitframe();
}

_id_DA5E9A1C5E31507F(objectivestruct) {
  level endon("game_ended");
  level._id_289BE3C21F39E36B = ::_id_C56F95CF7E0C190B;
  level._id_E9DED374A39ECF8E = scripts\engine\utility::getStructArray("dogtag_revive_loc_maze_vent", "script_noteworthy");

  if(getdvarint("dvar_DA6B87817DB1CBA0", 0) != 0) {
    level.jugg_objective_struct = objectivestruct;
    level thread _id_4D346DA49A80368C::start_timed_event_on_detection(objectivestruct);
    level.current_button_counter = 5;

    foreach(struct in scripts\engine\utility::getStructArray("seq_button", "script_noteworthy")) {
      if(isDefined(struct.headicon))
        deleteheadicon(struct.headicon);
    }

    objective_setlocation(level.jugg_objective_struct.objectiveindex, 0, scripts\engine\utility::getStruct("escape_maze", "script_noteworthy").origin);
    scripts\cp\cp_interaction::removefrominteractionslistbynoteworthy("seq_button");
    thread _id_4D346DA49A80368C::open_any_random_airlock_door();
  }

  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("Raid: Jugg Maze - Airlock Door");
  wait 1;
  level._id_AD9B99883D277045 = "airlockDoor";
  scripts\engine\utility::flag_wait_either("progress_to_elevator", "phase_4_complete");
  scripts\cp\cp_analytics::_id_B6283AC45A607764("Raid: Jugg Maze - Airlock Door");
  wait 0.5;
}

_id_D2630F2DE891DFB2(_id_74B41E1E59B731F7, _id_8F57EFFB0D56C741) {
  level endon("game_ended");
  level notify("juggMaze_lockAndUnlockExitDoor");
  level endon("juggMaze_lockAndUnlockExitDoor");
  scripts\engine\utility::flag_wait("cp_raid_complex_jugg_maze_completed");
  level._id_0C6C8A6BC57170DB = scripts\engine\utility::getStruct("door_lock", "targetname");
  level._id_E0DF2A93474083CE = scripts\engine\utility::getStruct("door_lock_elevator", "targetname");
  level._id_EE955FA5C3012298 = scripts\engine\utility::getStruct("elevator_obj_breadcrumb", "targetname");
  doors = getentitylessscriptablearray(undefined, undefined, level._id_0C6C8A6BC57170DB.origin, 64, "door");
  _id_3F01056740AE0E4D = getentitylessscriptablearray(undefined, undefined, level._id_E0DF2A93474083CE.origin, 64, "door");

  if(!isDefined(level._id_6266E73962148BD0))
    level._id_6266E73962148BD0 = doors;

  if(!istrue(_id_8F57EFFB0D56C741)) {
    foreach(door in doors)
    _id_531C536DCD04E20F::_id_FBBFE6F05EDA5EB1(door);

    foreach(_id_CE254378F57859E7 in _id_3F01056740AE0E4D)
    _id_531C536DCD04E20F::_id_FBBFE6F05EDA5EB1(_id_CE254378F57859E7);
  }

  scripts\engine\utility::flag_wait("unlock_exit_door_now");
  level thread _id_18AF78602B67B70C::_id_92233BCD56EA95C5("3man_door_elevator", 1);
  level._id_7B2F0E98EBB875E7 = scripts\cp\cp_objectives::getobjectivestructfromref(_id_74B41E1E59B731F7);
  level._id_0C6C8A6BC57170DB.index = 666;
  _id_242A2441CBD54AF1::_id_9399FC86660D5D86(level._id_0C6C8A6BC57170DB, "players_reached_locked_door", 443556);
  objectivestruct = scripts\cp\cp_objectives::getobjectivestructfromref(_id_74B41E1E59B731F7);
  scripts\engine\utility::flag_wait("3man_door_elevator_door_open");
  scripts\engine\utility::flag_set("progress_to_elevator");
  level notify("progress_to_elevator");
  _id_18A73A64992DD07D::stop_module_by_groupname("jugg_spawn_localized_a");
  _id_18A73A64992DD07D::stop_module_by_groupname("jugg_spawn_localized_b");
  _id_18A73A64992DD07D::stop_module_by_groupname("jugg_spawn_localized_c");
  _id_18A73A64992DD07D::stop_module_by_groupname("jugg_spawn_localized_d");
  _id_18A73A64992DD07D::stop_module_by_groupname("jugg_spawn_localized_e");

  if(isDefined(level._id_FD11A870E357A9ED)) {
    foreach(_id_FDB590F4C02A6A0A in level._id_FD11A870E357A9ED) {
      foreach(_id_E21279FA90BDF012 in _id_FDB590F4C02A6A0A) {
        if(scripts\engine\utility::is_dead_or_dying(_id_E21279FA90BDF012)) {
          continue;
        }
        if(isDefined(level.hadir) && level.hadir == _id_E21279FA90BDF012) {
          continue;
        }
        _id_E21279FA90BDF012 _id_18A73A64992DD07D::script_kill_ai();
      }
    }
  }
}

_id_C5B3082A763524BE(objectivestruct, _id_E035FDEF423A5164, _id_74B41E1E59B731F7) {
  objectivestruct._id_D31685C0A626FF37 = scripts\cp\cp_objectives::requestworldid(_id_74B41E1E59B731F7 + objectivestruct.index, 1 + int(objectivestruct.index));
  objective_setplayintro(objectivestruct._id_D31685C0A626FF37, 1);
  objective_setplayoutro(objectivestruct._id_D31685C0A626FF37, 1);
  objective_setlocation(objectivestruct._id_D31685C0A626FF37, 0, _id_E035FDEF423A5164.origin);
  objective_state(objectivestruct._id_D31685C0A626FF37, "current");
  objective_icon(objectivestruct._id_D31685C0A626FF37, "icon_waypoint_objective_general");
  _id_E035FDEF423A5164._id_D31685C0A626FF37 = objectivestruct._id_D31685C0A626FF37;
  return objectivestruct;
}

_id_10E152EB55750FBE(objectivestruct) {
  if(isDefined(level._id_289BE3C21F39E36B))
    level._id_289BE3C21F39E36B = undefined;

  wait 1;
  _id_45F0E1DC4CE9ECCB::_id_CCC48E4E354C87DF("checkpoint_elevator_section");
}

_id_FDE407EAAA732A36(objectivestruct) {
  _id_18A73A64992DD07D::run_spawn_module("hadir_spawn");
  level thread _id_4F6F7F0C74CFA319();
  scripts\engine\utility::flag_set("hadir_elevator_start");
  scripts\engine\utility::flag_wait("hadir_elevator_started");
}

_id_A62A3FAD9516B6C9(objectivestruct) {}

_id_4F6F7F0C74CFA319() {
  level endon("game_ended");

  while(level.players.size == 0)
    wait 1;

  struct = scripts\engine\utility::getStructArray("hadir_elevator_spawner_front", "targetname")[0];
  dist = squared(650);

  while(!scripts\cp\utility::any_player_nearby(struct.origin, dist))
    wait 0.25;

  level.default_player_spawns = "hadir_elevator_spawner_front";
}

_id_04E9EF2D83C324F3(objectivestruct) {
  _id_AC89E0692886C8BC = [];
  _id_998FD6DA743069EE = getEnt("damagable_lever_left", "targetname");
  _id_DC584ECD38C9E263 = getEnt("damagable_lever_right", "targetname");
  _id_26D544CFE802C1C3 = getEnt("melee_cable_left", "script_noteworthy");
  _id_BC06195558104F4C = getEnt("melee_cable_right", "script_noteworthy");

  if(isDefined(_id_998FD6DA743069EE))
    _id_AC89E0692886C8BC[_id_AC89E0692886C8BC.size] = _id_998FD6DA743069EE;

  if(isDefined(_id_DC584ECD38C9E263))
    _id_AC89E0692886C8BC[_id_AC89E0692886C8BC.size] = _id_DC584ECD38C9E263;

  foreach(lever in _id_AC89E0692886C8BC)
  lever delete();

  if(isDefined(_id_26D544CFE802C1C3))
    _id_26D544CFE802C1C3 delete();

  if(isDefined(_id_BC06195558104F4C))
    _id_BC06195558104F4C delete();
}

_id_950E61BE6A29A757(objectivestruct) {
  level thread _id_101ACB9841ABA040();
  scripts\engine\utility::flag_wait_either("hadir_elevator_crashed", "hadir_elevator_escaped");

  if(scripts\engine\utility::flag("hadir_elevator_escaped")) {
    _id_5A67C9D0186C1589 = &"CP_RAID_COMPLEX_JUGG_MAZE/HADIR_ESCAPED_ELEVATOR";

    if(_id_C9A7124430CFB1DC())
      _id_5A67C9D0186C1589 = &"CP_RAID_COMPLEX_JUGG_MAZE/HADIR_ESCAPED_EE";

    scripts\cp\cp_hud_message::teamhudtutorialmessage(_id_5A67C9D0186C1589, "allies", 3);
    _id_0AFB7E332AEE4BF2::_id_8C810A2B49618C0F();
    wait 3;
    level thread[[level.endgame]]("axis", level.end_game_string_index["hadir_escaped"]);
    level waittill("never");
  }
}

_id_E58D1C632D4F1710(objectivestruct) {}

_id_C9A7124430CFB1DC() {
  foreach(player in level.players) {
    tag = player getclantag();

    if(isDefined(tag) && tolower(tag) == "iw")
      return 1;
  }

  return 0;
}

_id_4D844B4D99E860CD() {
  if(!istrue(level._id_D5D05591ACE78C64)) {
    scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(_id_3C2AAAD486A9AA1D::_id_1B4FABA836C0F200);
    level._id_D5D05591ACE78C64 = 1;
  }

  foreach(player in level.players)
  player _id_3C2AAAD486A9AA1D::_id_1B4FABA836C0F200();
}

_id_630BDB071ADF7D07(objectivestruct) {
  _id_3C2AAAD486A9AA1D::_id_E1E9C9BE2AA1C067();
  level.enter_spectator_func = ::_id_84E53AFDA38443EA;
  _id_4D844B4D99E860CD();
  level thread _id_18AF78602B67B70C::_id_92233BCD56EA95C5("3personDoorElevatorDefend", 1);
  scripts\engine\utility::flag_wait("3personDoorElevatorDefend_door_open");
  _id_18A73A64992DD07D::kill_off_enemies(undefined, 100, 1);
}

_id_09E700C9B50B3436(objectivestruct) {}

_id_5A74077943825A37(objectivestruct) {
  _id_3C2AAAD486A9AA1D::_id_E1E9C9BE2AA1C067();
  level notify("farah_stop_squad_wipe_monitor");
  level._id_F57B5DB263860330 = 1;
  scripts\cp\utility::_id_C0D2C91F2688ECE4(0);
  level.enter_spectator_func = _id_0AFB7E332AEE4BF2::enable_dogtag_revive;
  level thread _id_FFF2B3E39917AA34();

  if(!scripts\engine\utility::flag("3personDoorElevatorDefend_door_open")) {
    _id_302C9BA2263554EA = scripts\cp\cp_objectives::requestworldid("elevator_3_person_door", 25);
    scripts\cp\cp_objectives::_add_objective(_id_302C9BA2263554EA, "current", scripts\engine\utility::getStruct("3personDoorElevatorDefend", "script_noteworthy").origin, "icon_waypoint_objective_general");
    level thread _id_18AF78602B67B70C::_id_92233BCD56EA95C5("3personDoorElevatorDefend", 1);
    scripts\engine\utility::flag_wait("3personDoorElevatorDefend_door_open");
    objective_delete(_id_302C9BA2263554EA);
  }

  _id_703FDBB02501D31E::_id_38924FB7672B340D("brloot_powerup_equipment", 30);
  _id_4D844B4D99E860CD();
  _id_18A73A64992DD07D::run_spawn_module("elevator_defend_wave1_trophy");
  wait 1;
  level waittill("elevator_defend_completed");

  foreach(player in level.players)
  player notify("clear_tutorial_messages");
}

_id_FFF2B3E39917AA34() {
  triggers = getEntArray("elevator_defend_smoke_trigger", "targetname");
  _id_CE126B8C53B9993F = scripts\engine\utility::getStructArray("scripted_smoke_grenade", "targetname");

  foreach(trigger in triggers) {
    _id_8C44928B6048E69A = scripts\engine\utility::getclosest(trigger.origin, _id_CE126B8C53B9993F);
    _id_8C44928B6048E69A scripts\engine\utility::ent_flag_init("ready_for_smoke");
    trigger thread _id_C559025ADF7F85DF(_id_8C44928B6048E69A);
  }
}

_id_C559025ADF7F85DF(_id_8C44928B6048E69A) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", _id_FA8D840338038893);

    if(isDefined(_id_FA8D840338038893) && isagent(_id_FA8D840338038893)) {
      _id_8C44928B6048E69A scripts\engine\utility::ent_flag_set("ready_for_smoke");
      wait 30;
      continue;
    }

    wait 1;
  }
}

_id_48F8A44BCDADF9EE(objectivestruct) {}

_id_55D0DBCE8A620C8C(objectivestruct) {
  _id_3C2AAAD486A9AA1D::_id_E1E9C9BE2AA1C067();
  level.enter_spectator_func = _id_0AFB7E332AEE4BF2::enable_dogtag_revive;
  _id_4D844B4D99E860CD();
  _id_C5B3082A763524BE(objectivestruct, scripts\engine\utility::getStruct("3personDoorElevatorDefend", "script_noteworthy"), "ending");
  thread _id_055B8229C19C258D::_id_11D7E6FE7CCB4E27();
  scripts\engine\utility::flag_clear("3personDoorElevatorDefend_door_open");
  scripts\engine\utility::flag_wait("elevatorDefend_vo_compelete");
  timeout = gettime() + 10000;
  _id_E9F1AB5BB3053BE4 = 0;

  while(!istrue(_id_E9F1AB5BB3053BE4)) {
    if(gettime() > timeout) {
      _id_E9F1AB5BB3053BE4 = 1;
      waitframe();
      continue;
    }

    _id_CD207438E3E764E6 = getaiarray("axis");

    if(_id_CD207438E3E764E6.size <= 0) {
      _id_E9F1AB5BB3053BE4 = 1;
      waitframe();
      continue;
    }

    _id_E9F1AB5BB3053BE4 = 1;

    if(!isDefined(level.hadir)) {
      _id_E9F1AB5BB3053BE4 = 1;
      waitframe();
      continue;
    }

    foreach(ai in _id_CD207438E3E764E6) {
      if(ai != level.hadir) {
        _id_E9F1AB5BB3053BE4 = 0;
        break;
      }
    }

    wait 1;
  }

  level thread _id_18AF78602B67B70C::_id_92233BCD56EA95C5("3personDoorElevatorDefend", 1);
  scripts\engine\utility::flag_wait("3personDoorElevatorDefend_door_open");
  setomnvar("ui_hide_game_render_for_round_end_team_hud", 1);
  _id_5D265B4FCA61F070::_id_54D3BD59BFF7E908();
  level notify("endofscripting");
  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

_id_BCDBE2493D6017E7(objectivestruct) {}

_id_1A7E4478AF6821B9(objectivestruct) {
  level waittill("forever");
}

_id_17AD10FABD934AFE(objectivestruct) {}

_id_8D2BD4145032E443(objectivestruct) {}

_id_441C6F583339AA06(objectivestruct) {}

setup_create_script() {
  scripts\common\create_script_utility::register_create_script_arrays(undefined, undefined, level.scripted_spawner_func.size, _id_2D7E3D572783310F::main);
  scripts\common\create_script_utility::register_create_script_arrays("cp_raid_complex_jugg_maze_2", "prefabs/cp/cp_jugg_maze/cp_jugg_maze_juggmaze_create_script", level.scripted_spawner_func.size, _id_38763A923952695B::main);
  scripts\common\create_script_utility::register_create_script_arrays("cp_jugg_maze_create_script", "cp_jugg_maze_create_script", level.scripted_spawner_func.size, _id_40F055DDE0B7109A::main);
  scripts\common\create_script_utility::register_create_script_arrays("cp_capture_jugg_create_script", "cp_capture_jugg_create_script", level.scripted_spawner_func.size, _id_43FE7B44DEFFFE2E::main);
  scripts\common\create_script_utility::register_create_script_arrays("cp_hadir_elevator_cs", "cp_hadir_elevator_cs", level.scripted_spawner_func.size, _id_2E4A08C078A880F6::main);
  scripts\common\create_script_utility::register_create_script_arrays("cp_jugg_maze_stealth_create_script", "cp_jugg_maze_stealth_create_script", level.scripted_spawner_func.size, _id_24337325D1E6A9D6::main);
  scripts\common\create_script_utility::register_create_script_arrays("cp_jugg_maze_lasers_create_script", "cp_jugg_maze_lasers_create_script", level.scripted_spawner_func.size, _id_648A15FEBA8882A3::main);
  scripts\common\create_script_utility::register_create_script_arrays("cp_jugg_maze_intel_create_script", "cp_jugg_maze_intel_create_script", level.scripted_spawner_func.size, _id_4E287A67F6913015::main);
  scripts\common\create_script_utility::register_cs_offsets("cp_capture_jugg_create_script", (559, 1090.5, 0), (0, 0, 0));
}

_id_FC4803DC319A81D2() {
  level thread wait_for_pre_game_period();
  level thread wait_for_strike_init_complete();
  level thread _id_96A92DD02CA90C97();
}

_id_96A92DD02CA90C97() {
  level waittill("level_systems_loaded");
  scripts\cp\cp_gameskill::_id_2B72A5CF9E5597F9(3);
  scripts\cp\cp_gameskill::updategameskill();
  scripts\cp\cp_gameskill::updatealldifficulty();
}

wait_for_pre_game_period() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("bsp_structs_initialized");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  wait 1;
  scripts\cp\intel\cp_intel::_id_4F08AFA61F734625();
}

wait_for_strike_init_complete() {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("strike_init_done"))
    scripts\engine\utility::flag_wait("strike_init_done");
}

_id_C2A86F682BF1AB71() {
  level.objectives_table = "cp/cp_jugg_maze_objectives.csv";
  level.objectivesmatrixtable = "cp/cp_jugg_maze_objectives_matrix.csv";
  level.objectiveregistration = ::_id_77765E5DD4C9DB54;
  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

_id_77765E5DD4C9DB54() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  scripts\engine\utility::flag_wait("objective_table_parsed");
}

_id_D525F1534752BFC7() {
  setDvar("sm_sunSampleSizeNear", 1.25);
  setDvar("r_umbraMinObjectContribution", 4);
  setDvar("r_umbraAccurateOcclusionThreshold", 2048);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
  setDvar("sm_spotUpdateLimit", 8);
  setDvar("dvar_029E7CCE64630243", 1);
  scripts\engine\utility::flag_set("infil_complete");
}

_id_7B8D8675F05A6FC3() {
  scripts\engine\utility::flag_wait("level_ready_for_script");
  _id_96AF355B94EFBC32();
}

_id_96AF355B94EFBC32() {
  level._id_8AC698A44F96B2C3 = [];
  ents = getEntArray("elevator_body", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < ents.size; _id_AC0E594AC96AA3A8++) {
    if(ents[_id_AC0E594AC96AA3A8].classname == "script_model") {
      struct = spawnStruct();
      struct.origin = ents[_id_AC0E594AC96AA3A8].origin;
      struct.angles = ents[_id_AC0E594AC96AA3A8].angles;
      struct.model = ents[_id_AC0E594AC96AA3A8].model;
      struct.targetname = "elevator_body";
      level._id_8AC698A44F96B2C3[level._id_8AC698A44F96B2C3.size] = struct;
      ents[_id_AC0E594AC96AA3A8] delete();
    }
  }

  _id_86135C8F4A9D321E(0);
}

_id_4313B6240AAB102E() {
  if(_id_88F104C86D3BCFCC()) {
    foreach(ent in level._id_8AC698A44F96B2C3) {
      model = spawn("script_model", ent.origin);
      model.angles = ent.angles;
      model setModel(ent.model);
      model.targetname = ent.targetname;
    }

    _id_86135C8F4A9D321E(1);
  }
}

_id_898E4BAA69A9E38E(delay) {
  level endon("game_ended");
  self endon("death");

  if(isDefined(delay))
    wait(delay);

  playFXOnTag(level._effect["vfx_elevator_broken_glass"], self, "tag_origin");
}

_id_88F104C86D3BCFCC() {
  return !istrue(level._id_06870EDF83319B5F);
}

_id_86135C8F4A9D321E(_id_E3108E412AFB3811) {
  level._id_06870EDF83319B5F = _id_E3108E412AFB3811;
}

_id_7177A3AF234302E1(_id_F91E0918144A746E) {
  level._id_06870EDF83319B5F = !level._id_06870EDF83319B5F;

  if(level._id_06870EDF83319B5F) {
    foreach(ent in level._id_8AC698A44F96B2C3) {
      model = spawn("script_model", ent.origin);
      model.angles = ent.angles;
      model setModel(ent.model);
      model.targetname = ent.targetname;
    }
  } else
    _id_96AF355B94EFBC32();
}

_id_7A08D6415A8EB70F() {
  level waittill("player_spawned", player);
  wait 3;
  level._id_6D4F606EC3EBDE8A = scripts\engine\utility::getStruct("radiation_ref_struct", "targetname");
  _id_842D9B72D7F71B55 = 2000;
  _id_29D3B7C0950EE7ED = spawnbrcircle(level._id_6D4F606EC3EBDE8A.origin[0], level._id_6D4F606EC3EBDE8A.origin[1], level._id_6D4F606EC3EBDE8A.radius);
  _id_CFDAF179966BFD5F = [1];
  _id_A8E13A83C64CD67D = 0;
  level waittill("stopping_gas");
  iprintln(" Stopping Gas in the Maze ");

  for(;;) {
    wait 10;
    _id_154EF61B7A7F747A = _id_CFDAF179966BFD5F[_id_A8E13A83C64CD67D % _id_CFDAF179966BFD5F.size];
    _id_A8E13A83C64CD67D++;
    _id_29D3B7C0950EE7ED brcirclemoveTo(_id_29D3B7C0950EE7ED.origin[0], _id_29D3B7C0950EE7ED.origin[1], _id_154EF61B7A7F747A, 6);

    if(_id_A8E13A83C64CD67D == _id_CFDAF179966BFD5F.size)
      return;
  }
}

_id_F2477AE8D8E7DB7E() {
  circle = self;
  circle endon("death");

  for(;;) {
    waitframe();
    center = (circle.origin[0], circle.origin[1], 0);
    radius = circle.origin[2];
  }
}

_id_706C000482606389() {
  scripts\engine\utility::flag_wait("bsp_structs_initialized");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  level._id_B60CF703523C5409 = getEntArray("tacmap_trigger", "script_noteworthy");

  foreach(trigger in level._id_B60CF703523C5409)
  trigger thread _id_49D3B93A951F65FF();
}

_id_49D3B93A951F65FF() {
  if(isDefined(self.entstouching)) {
    return;
  }
  self.entstouching = [];
  thread _id_0078EC90C5117EBF(self);
  thread _id_97792467346CD8EB(self);
}

_id_97792467346CD8EB(trigger) {
  level endon("game_ended");
  trigger notify("trigger_watchtacmapTriggerEnter");
  trigger endon("trigger_watchtacmapTriggerEnter");
  trigger endon("death");

  for(;;) {
    trigger waittill("trigger", ent);

    if(!_id_DC0A66796F616FCE(ent)) {
      continue;
    }
    _id_CD3373F31E8454C4(trigger, ent);
  }
}

_id_0078EC90C5117EBF(trigger) {
  level endon("game_ended");
  trigger notify("trigger_watchtacmapTriggerExit");
  trigger endon("trigger_watchtacmapTriggerExit");
  trigger endon("death");

  for(;;) {
    _id_5C397C9CF7A06802 = trigger.entstouching;

    foreach(id, ent in _id_5C397C9CF7A06802) {
      if(!isDefined(ent)) {
        trigger.entstouching[id] = undefined;
        continue;
      }

      _id_05956C54E54EBF3D = trigger istouching(ent);

      if(isPlayer(ent) && !isalive(ent))
        _id_05956C54E54EBF3D = 0;

      if(isDefined(ent) && !_id_05956C54E54EBF3D)
        _id_6348255C67EA986E(trigger, ent);
    }

    waitframe();
  }
}

_id_DC0A66796F616FCE(ent) {
  if(isDefined(ent)) {
    if(isPlayer(ent)) {
      if(ent scripts\cp_mp\utility\player_utility::_isalive())
        return 1;
    }
  }

  return 0;
}

_id_6348255C67EA986E(trigger, ent) {
  entnum = ent getentitynumber();
  trigger.entstouching[entnum] = undefined;

  if(!_id_6B132FE5445527B1(trigger, ent))
    ent thread _id_4AAD86B29C94AA56(0);
}

_id_CD3373F31E8454C4(trigger, ent) {
  entnum = ent getentitynumber();

  if(isDefined(trigger.entstouching[entnum])) {
    return;
  }
  trigger.entstouching[entnum] = ent;
  ent thread _id_4AAD86B29C94AA56(1);
}

_id_6B132FE5445527B1(trigger, ent) {
  entnum = ent getentitynumber();

  foreach(_id_8DF8A9ED72C2BDAA in level._id_B60CF703523C5409) {
    if(_id_8DF8A9ED72C2BDAA == trigger) {
      continue;
    }
    if(isDefined(_id_8DF8A9ED72C2BDAA.entstouching[entnum]))
      return 1;
  }

  return 0;
}

_id_4AAD86B29C94AA56(enable) {
  if(!isDefined(self) || !isPlayer(self) || !isalive(self)) {
    return;
  }
  if(!isDefined(enable))
    enable = !isDefined(self._id_BB67AB77A5842176);

  if(enable) {
    if(isDefined(self._id_BB67AB77A5842176)) {
      return;
    }
    thread _id_EB34F2C9493616C5();
  } else {
    if(!isDefined(self._id_BB67AB77A5842176)) {
      return;
    }
    thread _id_7BABC3AC021A79C1();
  }
}

_id_4CCFFD88E604D2A2() {
  if(isDefined(self._id_8993BBD0D25E69DD) && self._id_8993BBD0D25E69DD > gettime() - 200)
    return 1;

  self._id_8993BBD0D25E69DD = gettime();
  return 0;
}

_id_EB34F2C9493616C5(ent, tag) {
  level endon("game_ended");
  self endon("disconnect");
  self._id_BB67AB77A5842176 = 1;
  self setclientomnvar("ui_radar_blocked", 0);
  self setclientomnvar("ui_hide_bigmap", 0);
  self.skipuavupdate = undefined;
  wait 0.1;
  level thread scripts\cp_mp\killstreaks\uav::_id_C11936B9C6C3A076(self, 0.05);
  thread _id_08806B680C8BA146();
}

_id_7BABC3AC021A79C1(ent, tag) {
  self._id_BB67AB77A5842176 = undefined;
  self setclientomnvar("ui_radar_blocked", 1);
  self setclientomnvar("ui_hide_bigmap", 1);
  self.skipuavupdate = 1;
}

_id_08806B680C8BA146() {
  self notify("tacmap_off_on_death");
  self endon("tacmap_off_on_death");
  self endon("disconnect");
  self waittill("death");

  if(!isDefined(self._id_BB67AB77A5842176)) {
    return;
  }
  _id_7BABC3AC021A79C1();
  self._id_BB67AB77A5842176 = undefined;
}

_id_F2A617C816350F5D() {
  level endon("game_ended");
  level._id_6BD35FAF933EE479 = 0;

  for(;;) {
    level waittill("easter_egg_switch_flipped", _id_B1444EDC83A99368, player);

    if(!isDefined(game["easter_egg_code"])) {
      return;
    }
    _id_D92CC99E75D0671E = getsubstr(_id_B1444EDC83A99368, 5);
    _id_251683E56DC4BB7B = int(_id_D92CC99E75D0671E);

    if(_id_251683E56DC4BB7B != game["easter_egg_code"][level._id_6BD35FAF933EE479]) {
      level._id_AD458AF8B2278D3F = 1;
      level._id_6BD35FAF933EE479 = undefined;
      return;
    }

    level._id_6BD35FAF933EE479++;

    if(level._id_6BD35FAF933EE479 == 3) {
      if(isDefined(player)) {
        if(isDefined(level.price)) {
          if(player == level.price) {
            player _id_5D265B4FCA61F070::_id_88357F565D1BADF5(0.2, "dx_cp_cpr4_stls_pric_thatunlockedsomethin");
            level._id_378BE3B1BD759734 = 1;
            return;
          }
        }

        if(isDefined(level.farah)) {
          if(player == level.farah) {
            player _id_5D265B4FCA61F070::_id_88357F565D1BADF5(0.2, "dx_cp_cpr4_stls_fara_wejustunlockedsometh");
            level._id_378BE3B1BD759734 = 1;
            return;
          }
        }

        if(isDefined(level.alex)) {
          if(player == level.alex)
            player _id_5D265B4FCA61F070::_id_88357F565D1BADF5(0.2, "dx_cp_cpr4_stls_alex_wejustunlockedsometh");
        }
      }

      level._id_378BE3B1BD759734 = 1;
      return;
    }
  }
}

_id_785A97944731F5D4() {
  level endon("game_ended");
  setDvar("dvar_50DC8700FC9537BC", 0);

  for(;;) {
    if(getdvarint("dvar_50DC8700FC9537BC", 0) <= 0) {
      wait 0.5;
      continue;
    }

    if(isDefined(game["easter_egg_code"])) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < game["easter_egg_code"].size; _id_AC0E594AC96AA3A8++) {
        iprintlnbold("EE code is " + game["easter_egg_code"][0] + " " + game["easter_egg_code"][1] + " " + game["easter_egg_code"][2]);
        wait 2;
      }
    } else {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
        iprintlnbold("random numbers were not generated");
        wait 1;
      }
    }

    setDvar("dvar_50DC8700FC9537BC", 0);
  }
}

_id_FA191B1C184F006C() {
  if(!isDefined(game["easter_egg_code"])) {
    game["easter_egg_code"] = [];
    _id_D551950BA8A056F7 = scripts\engine\utility::create_deck([1, 2, 3, 4], 1, 1);
    _id_E9A2F82A072977F9 = 5;
    _id_E9A2F52A07297160 = _id_D551950BA8A056F7 scripts\engine\utility::deck_draw();
    _id_E9A2F62A07297393 = _id_D551950BA8A056F7 scripts\engine\utility::deck_draw();
    game["easter_egg_code"][game["easter_egg_code"].size] = _id_E9A2F82A072977F9;
    game["easter_egg_code"][game["easter_egg_code"].size] = _id_E9A2F52A07297160;
    game["easter_egg_code"][game["easter_egg_code"].size] = _id_E9A2F62A07297393;
  }

  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Level EE:0 / display ee code\" \"set scr_ee_display 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
}

_id_11176FBF41AC6322() {
  _id_8CC78A9566E14CC6 = getEntArray("intro_fire_valve", "targetname");
  _id_09734A15CD7A3845 = getEnt("ee_fire_valve_a", "targetname");
  _id_09734715CD7A31AC = getEnt("ee_fire_valve_b", "targetname");
  _id_09734815CD7A33DF = getEnt("ee_fire_valve_c", "targetname");
  _id_09734515CD7A2D46 = getEnt("ee_fire_valve_d", "targetname");
  _id_8CC78A9566E14CC6[0]._id_4D7BBD8D57D75E78 = 1;

  if(scripts\engine\utility::array_contains(game["easter_egg_code"], 1))
    _id_09734715CD7A31AC._id_4D7BBD8D57D75E78 = 1;

  if(scripts\engine\utility::array_contains(game["easter_egg_code"], 2))
    _id_09734A15CD7A3845._id_4D7BBD8D57D75E78 = 1;

  if(scripts\engine\utility::array_contains(game["easter_egg_code"], 3))
    _id_09734815CD7A33DF._id_4D7BBD8D57D75E78 = 1;

  if(scripts\engine\utility::array_contains(game["easter_egg_code"], 4))
    _id_09734515CD7A2D46._id_4D7BBD8D57D75E78 = 1;

  _id_8CC78A9566E14CC6[_id_8CC78A9566E14CC6.size] = _id_09734715CD7A31AC;
  _id_8CC78A9566E14CC6[_id_8CC78A9566E14CC6.size] = _id_09734A15CD7A3845;
  _id_8CC78A9566E14CC6[_id_8CC78A9566E14CC6.size] = _id_09734815CD7A33DF;
  _id_8CC78A9566E14CC6[_id_8CC78A9566E14CC6.size] = _id_09734515CD7A2D46;
  level._id_8CC78A9566E14CC6 = _id_8CC78A9566E14CC6;

  foreach(_id_05CE5B54E58D14C5 in _id_8CC78A9566E14CC6) {
    if(isDefined(_id_05CE5B54E58D14C5.target)) {
      _id_05CE5B54E58D14C5 thread _id_2E3C207F7651DDEC::steam_valve_think(2, 160, 90, 80, 80, undefined, 1, undefined, 1);

      if(istrue(level._id_378BE3B1BD759734) || istrue(getdvarint("dvar_2DAC56226184B9A6", 0))) {
        if(istrue(_id_05CE5B54E58D14C5._id_4D7BBD8D57D75E78))
          _id_05CE5B54E58D14C5 thread _id_2BC2DBC23B8D19C7();
      }
    }

    wait 0.2;
  }

  if(istrue(level._id_378BE3B1BD759734) || istrue(getdvarint("dvar_2DAC56226184B9A6", 0)))
    thread _id_F9027E9C8B02C5D1();
  else {
    _id_09734A15CD7A3845 delete();
    _id_09734715CD7A31AC delete();
    _id_09734815CD7A33DF delete();
    _id_09734515CD7A2D46 delete();
  }
}

_id_2BC2DBC23B8D19C7(_id_8CC78A9566E14CC6) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    wait 1;

    if(_id_24DD0590745CEBD1()) {
      level._id_08B0CEA9EBE21FF6 = 1;
      return;
    }

    wait 0.5;

    if(_id_24DD0590745CEBD1()) {
      level._id_08B0CEA9EBE21FF6 = 1;
      return;
    }

    wait 0.5;

    if(_id_24DD0590745CEBD1()) {
      level._id_08B0CEA9EBE21FF6 = 1;
      return;
    }

    wait 0.5;

    if(_id_24DD0590745CEBD1()) {
      level._id_08B0CEA9EBE21FF6 = 1;
      return;
    }

    wait 0.5;

    if(_id_24DD0590745CEBD1()) {
      level._id_08B0CEA9EBE21FF6 = 1;
      return;
    }

    wait 0.5;

    if(_id_24DD0590745CEBD1()) {
      level._id_08B0CEA9EBE21FF6 = 1;
      return;
    }
  }
}

_id_F9027E9C8B02C5D1() {
  level endon("game_ended");

  while(!istrue(level._id_08B0CEA9EBE21FF6))
    wait 0.2;

  thread _id_3D18D2B654EB98E6();
  _id_B53A1C085C4BC72F();
  _id_097EBD96A5566A05("easter_egg_valve_door_origin", "easter_egg_valve_door_clip");
}

_id_3D18D2B654EB98E6() {
  player = scripts\engine\utility::random(level.players);

  if(isDefined(player)) {
    if(isDefined(level.price)) {
      if(player == level.price)
        player _id_5D265B4FCA61F070::_id_88357F565D1BADF5(0.2, "dx_cp_cpr4_stls_pric_thatunlockedsomethin");
    }

    if(isDefined(level.farah)) {
      if(player == level.farah)
        player _id_5D265B4FCA61F070::_id_88357F565D1BADF5(0.2, "dx_cp_cpr4_stls_fara_wejustunlockedsometh");
    }

    if(isDefined(level.alex)) {
      if(player == level.alex)
        player _id_5D265B4FCA61F070::_id_88357F565D1BADF5(0.2, "dx_cp_cpr4_stls_alex_wejustunlockedsometh");
    }
  }
}

_id_097EBD96A5566A05(_id_5C3C95908409974F, _id_46D8A4066C8417BF) {
  _id_4E606D1ADB6C2FB9 = scripts\engine\utility::getStruct(_id_5C3C95908409974F, "targetname");
  _id_4A7FFA088CD0CE86 = _id_D93E790663B230C4(_id_46D8A4066C8417BF, _id_4E606D1ADB6C2FB9.origin);
  _id_4A7FFA088CD0CE86 rotateYaw(110, 1);
  thread scripts\engine\utility::play_sound_in_space("iw9_door_metal_bars_open", _id_4E606D1ADB6C2FB9.origin);
  _id_4A7FFA088CD0CE86 waittill("rotatedone");
}

_id_D93E790663B230C4(_id_4A6E62AA769AD290, origin) {
  _id_10D2EEADD8FC8F9A = getEntArray(_id_4A6E62AA769AD290, "targetname");
  tagorigin = scripts\engine\utility::spawn_tag_origin(origin);

  foreach(mesh in _id_10D2EEADD8FC8F9A)
  mesh linkTo(tagorigin);

  return tagorigin;
}

_id_24DD0590745CEBD1() {
  level endon("game_ended");

  foreach(_id_05CE5B54E58D14C5 in level._id_8CC78A9566E14CC6) {
    if(!istrue(_id_05CE5B54E58D14C5._id_4D7BBD8D57D75E78)) {
      continue;
    }
    if(!isDefined(_id_05CE5B54E58D14C5._id_98AABCA05601AA67))
      return 0;

    if(getdvarint("dvar_2DAC56226184B9A6", 0))
      return 1;

    if(istrue(_id_05CE5B54E58D14C5._id_98AABCA05601AA67))
      return 0;
  }

  return 1;
}

_id_7BED63E134C9AE06(weaponobj) {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", player);

    if(isDefined(player) && isPlayer(player) && !istestclient(player))
      player _id_66122A002AFF5D57::_id_4172A10AE7CBDB41(weaponobj);
  }
}

_id_B53A1C085C4BC72F() {
  level endon("game_ended");
  _id_733EBEE6FC41E4E6 = makeweaponfromstring("iw9_dm_scromeo_mp+ammo_65cm+bar_sn_long_p05+arscope_therm01+grip_angled01+mag_sn_p05+pgrip_aim_p05+rec_scromeo+stock_sn_light_p05+laserbox_ads03+silencer05_br+camo|camo_s_14");
  _id_F5E11FC2E4B8FBB9 = scripts\engine\utility::getStructArray("secretwpn", "targetname");

  foreach(_id_6A56A4079F195610 in _id_F5E11FC2E4B8FBB9) {
    sweapon = getcompleteweaponname(_id_733EBEE6FC41E4E6);
    _id_B8F5AC23CE0DFDE3 = spawn("weapon_" + sweapon, _id_6A56A4079F195610.origin, 17);
    _id_B8F5AC23CE0DFDE3.angles = _id_6A56A4079F195610.angles;
    _id_B8F5AC23CE0DFDE3 itemweaponsetammo(weaponclipsize(_id_733EBEE6FC41E4E6), weaponstartammo(_id_733EBEE6FC41E4E6));
    _id_B8F5AC23CE0DFDE3 thread _id_74502A9E0EF1F19C::watchweaponpickup(weaponclipsize(_id_733EBEE6FC41E4E6), weaponstartammo(_id_733EBEE6FC41E4E6));
    _id_B8F5AC23CE0DFDE3 thread _id_7BED63E134C9AE06(_id_733EBEE6FC41E4E6);
    level thread _id_FD123FFC502AB603(_id_B8F5AC23CE0DFDE3);
  }
}

_id_FD123FFC502AB603(weapon) {
  level endon("game_ended");
  _id_0788A9C187362ABE = 0;

  while(!istrue(_id_0788A9C187362ABE)) {
    weapon waittill("trigger", player);

    if(isPlayer(player))
      _id_0788A9C187362ABE = 1;
  }

  foreach(player in level.players) {
    typeid = _func_96B7FC7E35353254("raids4_reward_camo_collect");
    scripts\cp\challenges_cp::_id_7D7322BF935AB06A(player, typeid);
    player setplayerdata("cp", "lastRaidClassifiedReward", "raids4_reward_camo_collect");
  }

  thread _id_CBAB17DA47218978();
}

_id_CBAB17DA47218978() {
  if(istrue(level._id_BE62B5BD7C6ECF0B)) {
    return;
  }
  level._id_BE62B5BD7C6ECF0B = 1;
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"COOP_GAME_PLAY/CAMO_UNLOCKED", "allies", 4);
}

_id_5A13959F7AF9E427(_id_9B0573BDB5DD9890) {
  _id_3D6404612A600581 = ["brloot_health_adrenaline", "brloot_offhand_concussion", "brloot_offhand_flash", "brloot_offhand_smoke", "brloot_offhand_snapshot", "brloot_offhand_shockstick", "brloot_offhand_c4", "brloot_offhand_frag", "brloot_offhand_atmine", "brloot_offhand_claymore", "brloot_offhand_semtex", "brloot_offhand_decoy", "brloot_offhand_thermite"];
  _id_2797C9762E667CC1 = ["brloot_health_adrenaline", "brloot_offhand_concussion", "brloot_offhand_decoy", "brloot_offhand_flash", "brloot_offhand_gas", "brloot_offhand_smoke", "brloot_offhand_snapshot", "brloot_offhand_shockstick", "brloot_offhand_binoculars", "brloot_offhand_c4", "brloot_offhand_frag", "brloot_offhand_atmine", "brloot_offhand_claymore", "brloot_offhand_molotov", "brloot_offhand_semtex", "brloot_offhand_thermite"];
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray("equipment_spawn", "targetname");

  if(istrue(_id_9B0573BDB5DD9890))
    _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray("equipment_spawn_stealth", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_9E4E1482CB40C9C5.size; _id_AC0E594AC96AA3A8++) {
    _id_06FE80416B4BE165 = _id_66122A002AFF5D57::getitemdropinfo(_id_9E4E1482CB40C9C5[_id_AC0E594AC96AA3A8].origin, _id_9E4E1482CB40C9C5[_id_AC0E594AC96AA3A8].angles);
    _id_32E00752C95AAD17 = scripts\engine\utility::random(_id_3D6404612A600581);

    if(istrue(_id_9B0573BDB5DD9890))
      _id_32E00752C95AAD17 = scripts\engine\utility::random(_id_2797C9762E667CC1);

    if(isDefined(_id_9E4E1482CB40C9C5[_id_AC0E594AC96AA3A8].script_noteworthy))
      _id_32E00752C95AAD17 = _id_9E4E1482CB40C9C5[_id_AC0E594AC96AA3A8].script_noteworthy;

    item = _id_66122A002AFF5D57::spawnpickup(_id_32E00752C95AAD17, _id_06FE80416B4BE165, undefined, undefined, undefined, 0);
  }
}

monitor_player_jump() {
  self endon("disconnect");
  player = self;
  player.last_jumped_time = 0;

  for(;;) {
    skip_wait = 0;

    while(!player isjumping()) {
      skip_wait = 1;
      wait 0.05;
    }

    player.last_jumped_time = gettime();

    while(player isjumping()) {
      skip_wait = 1;
      wait 0.05;
    }

    if(!skip_wait)
      wait 0.05;
  }
}

#using_animtree("script_model");

_id_6086303DFF2B506D() {
  level.scr_animtree["plyr_valve_m"] = #animtree;
  level.scr_anim["plyr_valve_m"]["fire_off"] = % iw9_cp_raid2_extinguisher_valve_turn_plr_male;
  level.scr_animname["plyr_valve_m"]["fire_off"] = "iw9_cp_raid2_extinguisher_valve_turn_plr_male";
  level.scr_eventanim["plyr_valve_m"]["fire_off"] = "iw9_cp_raid2_extinguisher_valve_turn_plr_male";
  level.scr_anim["plyr_valve_m"]["steam_off"] = % iw9_cp_raid2_steam_valve_turn_off_plr_female;
  level.scr_animname["plyr_valve_m"]["steam_off"] = "iw9_cp_raid2_steam_valve_turn_off_plr_female";
  level.scr_eventanim["plyr_valve_m"]["steam_off"] = "iw9_cp_raid2_steam_valve_turn_off_plr_female";
  level.scr_animtree["plyr_valve_f"] = #animtree;
  level.scr_anim["plyr_valve_f"]["fire_off"] = % iw9_cp_raid2_extinguisher_valve_turn_plr_female;
  level.scr_animname["plyr_valve_f"]["fire_off"] = "iw9_cp_raid2_extinguisher_valve_turn_plr_female";
  level.scr_eventanim["plyr_valve_f"]["fire_off"] = "iw9_cp_raid2_extinguisher_valve_turn_plr_female";
  level.scr_anim["plyr_valve_f"]["steam_off"] = % iw9_cp_raid2_steam_valve_turn_off_plr_female;
  level.scr_animname["plyr_valve_f"]["steam_off"] = "iw9_cp_raid2_steam_valve_turn_off_plr_female";
  level.scr_eventanim["plyr_valve_f"]["steam_off"] = "iw9_cp_raid2_steam_valve_turn_off_plr_female";
  level.scr_animtree["fire_valve"] = #animtree;
  level.scr_anim["fire_valve"]["fire_off"] = % iw9_cp_raid2_extinguisher_valve_turn;
  level.scr_animname["fire_valve"]["fire_off"] = "iw9_cp_raid2_extinguisher_valve_turn";
  level.scr_anim["fire_valve"]["reset"] = % iw9_cp_raid2_extinguisher_valve_reset;
  level.scr_animname["fire_valve"]["reset"] = "iw9_cp_raid2_extinguisher_valve_reset";
  level.scr_animtree["steam_valve"] = #animtree;
  level.scr_anim["steam_valve"]["steam_off"] = % iw9_cp_raid2_steam_valve_turn_off;
  level.scr_animname["steam_valve"]["steam_off"] = "iw9_cp_raid2_steam_valve_turn_off";
  level.scr_anim["steam_valve"]["reset"] = % iw9_cp_raid2_steam_valve_turn_reset;
  level.scr_animname["steam_valve"]["reset"] = "iw9_cp_raid2_steam_valve_turn_reset";
}

_id_F58BECD289A026D6() {
  level.scr_animtree["mine_cart"] = #animtree;
  level.scr_model["mine_cart"] = "machinery_mining_orecart_01";
  level.scr_anim["mine_cart"]["pushable_cart_shaft"] = % zd30t_mine_cart_push_shaft;
}

setup_mine_carts() {
  _id_F58BECD289A026D6();
  scripts\engine\utility::flag_wait("cp_jugg_maze_create_script_completed");
  level.mine_carts = [];
  _id_A03A08A15FD51139 = setup_mine_cart("mine_cart", "pushable_cart_shaft", (0, 0, 0));
  _id_A03A08A15FD51139 hudoutlineenable("outline_nodepth_red");
  level.cart_push_trigger_array = [_id_A03A08A15FD51139.front_trig, _id_A03A08A15FD51139.back_trig];

  foreach(player in level.players)
  player thread push_hint_think();
}

push_hint_think() {
  player = self;
  player endon("disconnect");
  player setclientomnvar("ui_in_world_text_index", 1);
  _id_EC1BF9F975667878 = undefined;

  while(level.cart_push_trigger_array.size > 0) {
    _id_E804E33E7FAD3556 = scripts\engine\utility::getclosest(player.origin, level.cart_push_trigger_array);
    _id_8EFEF5B1E4D79B79 = _id_E804E33E7FAD3556.hint_ent getentitynumber();
    dist = 256;

    if(scripts\engine\utility::distance_2d_squared(player.origin, _id_E804E33E7FAD3556.origin) <= dist * dist) {
      if(!isDefined(_id_EC1BF9F975667878) || _id_EC1BF9F975667878 != _id_8EFEF5B1E4D79B79) {
        player setclientomnvar("ui_in_world_text_entnum", _id_8EFEF5B1E4D79B79);
        _id_EC1BF9F975667878 = _id_8EFEF5B1E4D79B79;
      }
    } else if(!isDefined(_id_EC1BF9F975667878) || _id_EC1BF9F975667878 != -1) {
      player setclientomnvar("ui_in_world_text_entnum", -1);
      _id_EC1BF9F975667878 = -1;
    }

    wait 0.5;
  }

  player setclientomnvar("ui_in_world_text_entnum", -1);
}

setup_mine_cart(_id_4493DCD330B64F3E, _id_998D72C2586C9577, _id_BB7AED343DAE6C29) {
  _id_A03A08A15FD51139 = getEnt(_id_4493DCD330B64F3E, "targetname");
  _id_A03A08A15FD51139 build_mine_cart();
  level.mine_carts[_id_4493DCD330B64F3E] = _id_A03A08A15FD51139;
  anim_struct = scripts\engine\utility::getStruct(_id_998D72C2586C9577, "targetname");
  _id_A03A08A15FD51139.angles = _id_A03A08A15FD51139.angles + _id_BB7AED343DAE6C29;
  _id_A03A08A15FD51139 setup_cart_animation(anim_struct);
  _id_A03A08A15FD51139 thread push_monitor();
  return _id_A03A08A15FD51139;
}

build_mine_cart() {
  self.max_speed = int(self.script_noteworthy) / 100;
  self.accel = 2;
  self.decel = 1;
  self.push_yaw_delta = 40;
  self.push_stick_intensity = 0.6;
  self.push_rumble = "light_1s";
  self.push_vfx = "";
  self.push_magic_coefficient = 2.2;
  self.push_delay = 0.25;
  self.push_yaw_delta_live = 0;
  self.stick_movement = 0;
  self.incline = 0;
  self.is_pushed = 0;
  self.clip = undefined;
  self.front_trig = undefined;
  self.back_trig = undefined;
  self.junks = [];
  pieces = getEntArray(self.target, "targetname");

  foreach(_id_104A0214A4EEC589 in pieces) {
    if(isDefined(_id_104A0214A4EEC589.script_noteworthy)) {
      switch (_id_104A0214A4EEC589.script_noteworthy) {
        case "clip":
          self.clip = _id_104A0214A4EEC589;
          break;
        case "front":
          self.front_trig = _id_104A0214A4EEC589;
          break;
        case "back":
          self.back_trig = _id_104A0214A4EEC589;
          break;
        case "junk":
          self.junks[self.junks.size] = _id_104A0214A4EEC589;
          break;
      }
    }
  }

  thread push_hint_duration_think();
  _id_C165F30CE50451ED = vectorNormalize(anglestoup(self.front_trig.angles)) * 24 + self.front_trig.origin;
  self.front_trig.hint_ent = spawn("script_model", _id_C165F30CE50451ED);
  self.front_trig.hint_ent setModel("tag_origin");
  self.front_trig.hint_ent linkTo(self.front_trig);
  _id_C165F30CE50451ED = vectorNormalize(anglestoup(self.back_trig.angles)) * 24 + self.back_trig.origin;
  self.back_trig.hint_ent = spawn("script_model", _id_C165F30CE50451ED);
  self.back_trig.hint_ent setModel("tag_origin");
  self.back_trig.hint_ent linkTo(self.back_trig);
  self.front_trig enablelinkTo();
  self.back_trig enablelinkTo();
  self.front_trig linkTo(self);
  self.back_trig linkTo(self);
  waitframe();
  self.clip linkTo(self);
  self.clip.allowunresolvedcollision = 1;

  foreach(_id_A859713E22F9DB22 in self.junks)
  _id_A859713E22F9DB22 linkTo(self);

  createnavrepulsor("mine_cart" + self getentitynumber(), -1, self, 100, 1, "axis");
}

push_hint_duration_think() {
  self endon("death");
  level waittill("infinite");
  self waittill("at_starting_position");
  _id_9354895D32CF0166 = 0.1;

  while(!istrue(self.disable_push)) {
    _id_E2893CCDFF4D92AE = self getanimtime(self.animation);

    if(abs(_id_E2893CCDFF4D92AE - self.starting_frac) >= _id_9354895D32CF0166) {
      break;
    }

    wait 0.25;
  }

  level.cart_push_trigger_array = scripts\engine\utility::array_remove(level.cart_push_trigger_array, self.front_trig);
  level.cart_push_trigger_array = scripts\engine\utility::array_remove(level.cart_push_trigger_array, self.back_trig);
  self.moved_by_player = 1;
  wait 2;

  if(isDefined(self.front_trig.hint_ent)) {
    self.front_trig.hint_ent unlink();
    self.front_trig.hint_ent delete();
  }

  if(isDefined(self.back_trig.hint_ent)) {
    self.back_trig.hint_ent unlink();
    self.back_trig.hint_ent delete();
  }
}

update_nav() {
  for(;;) {
    previous = createnavobstaclebybounds(self.origin, (44, 24, 60), self.angles, "all");
    wait 0.1;

    if(self getanimrate(self.animation) == 0)
      self waittill("pushed");

    destroynavobstacle(previous);
  }
}

setup_cart_animation(anim_struct) {
  _id_C613344C81956A3C(self.targetname);
  self.anim_struct = anim_struct;
  self.anim_name = anim_struct.targetname;
  self.animation = scripts\engine\utility::getanim(self.anim_name);
  _id_253C6E648811AF10 = 1;
  self setanim(self.animation, 1, 0, _id_253C6E648811AF10);
  thread mine_cart_debug();
  self.starting_frac = 0;
  _id_A85A6953259BA8FD = getnotetracktimes(self.animation, "start_location");

  if(isDefined(_id_A85A6953259BA8FD) && isDefined(_id_A85A6953259BA8FD[0])) {
    frac = _id_A85A6953259BA8FD[0];
    self.starting_frac = frac;
    progress = 0;

    while(progress < frac) {
      progress = self getanimtime(self.animation);
      wait 0.05;
    }
  }

  self notify("at_starting_position");
  cart_stop(1);
  self rotateYaw(90, 2);
}

push_monitor() {
  self endon("disable_push");
  _id_52CB6024A2C16083 = self;
  _id_52CB6024A2C16083 thread monitor_cart_directional_push(_id_52CB6024A2C16083.front_trig, 1);
  _id_52CB6024A2C16083 thread monitor_cart_directional_push(_id_52CB6024A2C16083.back_trig, -1);
  _id_1E6D224371BE587C = 0;
  _id_5FD6A9D0CA14213B = 1;

  for(;;) {
    _id_52CB6024A2C16083 waittill("pushed", direction, _id_752AA66F2EF12509);
    _id_64E5D13011016A93 = _id_52CB6024A2C16083 getanimtime(_id_52CB6024A2C16083.animation);
    _id_FBF9584811C1B8E0 = 0;

    if(_id_64E5D13011016A93 < _id_5FD6A9D0CA14213B) {
      if(direction == 1) {
        _id_FBF9584811C1B8E0 = 1;
        _id_52CB6024A2C16083 thread cart_directional_move(direction, _id_752AA66F2EF12509);
      }
    }

    if(_id_64E5D13011016A93 > _id_1E6D224371BE587C) {
      if(direction == -1) {
        _id_FBF9584811C1B8E0 = 1;
        _id_52CB6024A2C16083 thread cart_directional_move(direction, _id_752AA66F2EF12509);
      }
    }

    if(!_id_FBF9584811C1B8E0) {
      waitframe();
      continue;
    }

    _id_752AA66F2EF12509 playrumblelooponentity(_id_52CB6024A2C16083.push_rumble);
    _id_52CB6024A2C16083 playSound("zd30_mine_cart_start");

    if(scripts\engine\utility::cointoss())
      playFXOnTag(level._effect["vfx_mine_cart"], self, "tag_origin");

    _id_752AA66F2EF12509 allowsprint(0);
    _id_752AA66F2EF12509.pushing_mine_cart = 1;
    waittill_push_stopped(_id_752AA66F2EF12509);
    _id_752AA66F2EF12509.pushing_mine_cart = 0;
    _id_752AA66F2EF12509 stoprumble(_id_52CB6024A2C16083.push_rumble);
    _id_752AA66F2EF12509 _id_519BED5012F1C015::blend_movespeedscale(1, 1);
    _id_752AA66F2EF12509 allowsprint(1);
    _id_52CB6024A2C16083 playSound("zd30_mine_cart_stop");
    _id_52CB6024A2C16083 thread cart_stop(1);
  }
}

waittill_push_stopped(_id_752AA66F2EF12509) {
  self notify("new_push_monitor");
  self endon("new_push_monitor");
  _id_52CB6024A2C16083 = self;
  _id_E85134EAAFFFFBFD = 0;
  _id_64E5D13011016A93 = _id_52CB6024A2C16083 getanimtime(_id_52CB6024A2C16083.animation);

  if(_id_64E5D13011016A93 > 0 && _id_64E5D13011016A93 < 1)
    _id_E85134EAAFFFFBFD = 1;

  while(push_conditions(_id_52CB6024A2C16083, _id_52CB6024A2C16083.front_trig, _id_752AA66F2EF12509) || push_conditions(_id_52CB6024A2C16083, _id_52CB6024A2C16083.back_trig, _id_752AA66F2EF12509)) {
    if(_id_E85134EAAFFFFBFD) {
      _id_64E5D13011016A93 = _id_52CB6024A2C16083 getanimtime(_id_52CB6024A2C16083.animation);

      if(_id_64E5D13011016A93 == 0 || _id_64E5D13011016A93 == 1) {
        break;
      }
    }

    wait 0.05;
  }

  _id_52CB6024A2C16083 notify("push_stopped");
}

monitor_cart_directional_push(trig, direction) {
  _id_52CB6024A2C16083 = self;
  _id_52CB6024A2C16083.is_pushed = 0;

  for(;;) {
    for(;;) {
      trig waittill("trigger", entity);

      if(!isPlayer(entity)) {
        continue;
      }
      if(istrue(entity.inlaststand)) {
        continue;
      }
      if(_id_52CB6024A2C16083.is_pushed == 1) {
        continue;
      }
      if(!push_conditions(_id_52CB6024A2C16083, trig, entity)) {
        wait 0.05;
        continue;
      }

      delay = _id_52CB6024A2C16083.push_delay;

      while(push_conditions(_id_52CB6024A2C16083, trig, entity) && delay > 0) {
        delay = delay - 0.05;
        wait 0.05;
      }

      if(delay <= 0) {
        break;
      }
    }

    _id_52CB6024A2C16083.is_pushed = direction;
    _id_52CB6024A2C16083 notify("pushed", direction, entity);

    while(push_conditions(_id_52CB6024A2C16083, trig, entity))
      wait 0.05;

    _id_52CB6024A2C16083.is_pushed = 0;
    _id_52CB6024A2C16083 notify("push_stopped");
  }
}

push_conditions(_id_52CB6024A2C16083, trig, _id_58393C2556D19E8E) {
  _id_B044EC93BCF7F17E = _id_58393C2556D19E8E istouching(trig);
  _id_DFA1170E315E5147 = is_player_looking_towards_cart(_id_52CB6024A2C16083, _id_58393C2556D19E8E);
  _id_575CAF5D043F5C45 = is_player_pushing_stick(_id_52CB6024A2C16083, _id_58393C2556D19E8E);
  _id_A972013A6B774D6E = _id_58393C2556D19E8E isjumping();
  _id_55BA640F0B643197 = 0.4;
  _id_1EEC5A16D219F076 = gettime() - _id_58393C2556D19E8E.last_jumped_time >= _id_55BA640F0B643197 * 1000;
  _id_CFB60F884591DAD1 = vectorNormalize(scripts\engine\utility::flatten_vector(_id_58393C2556D19E8E.origin - _id_52CB6024A2C16083.origin));
  _id_90E29C37C1498AB9 = scripts\engine\utility::flatten_vector(anglesToForward(_id_52CB6024A2C16083.angles));
  dot = abs(vectordot(_id_CFB60F884591DAD1, _id_90E29C37C1498AB9));
  _id_21BAF98AD796C70E = dot > 0.93;
  return _id_B044EC93BCF7F17E && _id_DFA1170E315E5147 && _id_575CAF5D043F5C45 && !_id_A972013A6B774D6E && _id_21BAF98AD796C70E && _id_1EEC5A16D219F076;
}

is_player_pushing_stick(_id_52CB6024A2C16083, _id_752AA66F2EF12509) {
  movement = _id_752AA66F2EF12509 getnormalizedmovement();
  _id_52CB6024A2C16083.stick_movement = movement[0];
  return movement[0] > _id_52CB6024A2C16083.push_stick_intensity;
}

is_player_looking_towards_cart(_id_52CB6024A2C16083, _id_752AA66F2EF12509) {
  angle = _id_52CB6024A2C16083.push_yaw_delta;
  _id_81AA62BC76D16EBE = vectortoyaw(_id_52CB6024A2C16083.origin - _id_752AA66F2EF12509 getEye());
  _id_F511AC87A4EC676C = _id_752AA66F2EF12509 getplayerangles(1);
  _id_3777ECE6A73EADA5 = anglesdelta((0, _id_81AA62BC76D16EBE, 0), _id_F511AC87A4EC676C);
  _id_52CB6024A2C16083.push_yaw_delta_live = _id_3777ECE6A73EADA5;
  return _id_3777ECE6A73EADA5 < angle;
}

cart_directional_move(direction, _id_58393C2556D19E8E) {
  self endon("push_stopped");
  _id_52CB6024A2C16083 = self;
  speed = direction * _id_52CB6024A2C16083.max_speed;
  _id_63F445469B886BF8 = _id_52CB6024A2C16083.accel * 20;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_63F445469B886BF8; _id_AC0E594AC96AA3A8++) {
    frac = _id_AC0E594AC96AA3A8 / _id_63F445469B886BF8;
    _id_494A3A24DC585A44 = speed * frac;
    _id_52CB6024A2C16083 setanimrate(_id_52CB6024A2C16083.animation, _id_494A3A24DC585A44);
    _id_52CB6024A2C16083 thread set_player_optimal_speed(_id_494A3A24DC585A44, _id_58393C2556D19E8E);
    wait 0.05;
  }

  _id_52CB6024A2C16083 setanimrate(_id_52CB6024A2C16083.animation, speed);
}

set_player_optimal_speed(_id_494A3A24DC585A44, _id_58393C2556D19E8E) {
  _id_52CB6024A2C16083 = self;
  _id_53F5126D148F95EA = _id_52CB6024A2C16083.push_magic_coefficient;
  _id_A7F88EFF10F49698 = abs(_id_494A3A24DC585A44 * _id_53F5126D148F95EA);
  _id_52CB6024A2C16083.player_magic_speed = _id_A7F88EFF10F49698;
  _id_58393C2556D19E8E _id_519BED5012F1C015::blend_movespeedscale(_id_A7F88EFF10F49698);
}

cart_stop(_id_5E0065A1DC2434B6) {
  self endon("pushed");
  _id_52CB6024A2C16083 = self;

  if(isDefined(_id_5E0065A1DC2434B6) && _id_5E0065A1DC2434B6) {
    _id_52CB6024A2C16083 setanimrate(_id_52CB6024A2C16083.animation, 0);
    return;
  }

  rate = _id_52CB6024A2C16083 getanimrate(_id_52CB6024A2C16083.animation);
  _id_98EA5AFB293A76A2 = 0.5;
  _id_3A2E46AD5498D50C = 6;
  incline = get_cart_incline(_id_52CB6024A2C16083);
  incline = clamp(incline, -1 * _id_3A2E46AD5498D50C, _id_3A2E46AD5498D50C);

  if(rate < 0) {
    if(incline > 0)
      decel = _id_52CB6024A2C16083.decel * (1 - abs(incline) / _id_3A2E46AD5498D50C);
    else
      decel = _id_52CB6024A2C16083.decel * (1 + abs(incline) / _id_3A2E46AD5498D50C);
  } else if(incline > 0)
    decel = _id_52CB6024A2C16083.decel * (1 + abs(incline) / _id_3A2E46AD5498D50C);
  else
    decel = _id_52CB6024A2C16083.decel * (1 - abs(incline) / _id_3A2E46AD5498D50C);

  if(decel > 1)
    _id_52CB6024A2C16083 childthread play_decel_effects(decel);

  decel = decel * _id_98EA5AFB293A76A2;
  _id_63F445469B886BF8 = decel * 20;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_63F445469B886BF8; _id_AC0E594AC96AA3A8++) {
    frac = 1 - _id_AC0E594AC96AA3A8 / _id_63F445469B886BF8;
    _id_494A3A24DC585A44 = rate * frac;
    _id_52CB6024A2C16083 setanimrate(_id_52CB6024A2C16083.animation, _id_494A3A24DC585A44);
    wait 0.05;
  }

  _id_52CB6024A2C16083 setanimrate(_id_52CB6024A2C16083.animation, 0);
}

play_decel_effects(_id_FECC6E7F3326E7CA) {
  _id_03AE198B1EA89871 = 0.35;
  wait_time = _id_FECC6E7F3326E7CA - _id_03AE198B1EA89871;

  if(wait_time <= 0)
    wait_time = 0.05;

  wait(wait_time);
  playFXOnTag(level._effect["vfx_mine_cart"], self, "tag_origin");
  wait(_id_03AE198B1EA89871);
  stopFXOnTag(level._effect["vfx_mine_cart"], self, "tag_origin");
}

get_cart_incline(_id_52CB6024A2C16083) {
  f = vectortoangles(vectorNormalize(anglesToForward(_id_52CB6024A2C16083.angles)))[0];

  if(f > 180)
    f = f - 360;

  return f;
}

mine_cart_debug() {
  _id_52CB6024A2C16083 = self;

  for(;;) {
    if(getdvarint("dvar_4FEF1C89BFF34A30", 2) > 1) {
      org = _id_52CB6024A2C16083.origin + (0, 0, 45);
      _id_CE482778F59E640B = (0, 0, 8);

      if(isDefined(_id_52CB6024A2C16083.is_pushed)) {
        if(_id_52CB6024A2C16083.is_pushed < 0) {} else if(_id_52CB6024A2C16083.is_pushed > 0) {} else {}
      } else {}

      incline = get_cart_incline(_id_52CB6024A2C16083);
      player_speed = 0;

      if(isDefined(self.player_magic_speed))
        player_speed = self.player_magic_speed;

      wait 0.05;
      continue;
    }

    wait 1;
  }
}

_id_C613344C81956A3C(animname) {
  if(isDefined(animname))
    self.animname = animname;

  self useanimtree(level.scr_animtree[self.animname]);
}

_id_4155C92C3B8FA156() {
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(isDefined(checkpoint) && checkpoint != "")
    return 1;

  return 0;
}

_id_E7A64DF827074B05() {
  level.sentrysettings["bs_laser"].modelbasecover = "electronics_ir_laser_device_rig_skeleton";
  level.sentrysettings["bs_laser"].modelbaseground = "electronics_ir_laser_device_rig_skeleton";
  level.sentrysettings["bs_laser"].modeldestroyedcover = "electronics_ir_laser_device_rig_skeleton";
  level.sentrysettings["bs_laser"].modeldestroyedground = "electronics_ir_laser_device_rig_skeleton";
}

_id_2A227BF43B1B2354(_id_52A0C5F3380B4694) {
  foreach(noteworthy in _id_52A0C5F3380B4694) {
    level.sentrysettings[noteworthy] = spawnStruct();
    level.sentrysettings[noteworthy].health = 999999;
    level.sentrysettings[noteworthy].maxhealth = 350;
    level.sentrysettings[noteworthy].burstmin = 20;
    level.sentrysettings[noteworthy].burstmax = 120;
    level.sentrysettings[noteworthy].pausemin = 0.15;
    level.sentrysettings[noteworthy].pausemax = 0.35;
    level.sentrysettings[noteworthy].maxrange = 4000000;
    level.sentrysettings[noteworthy]._id_947AF351CE904AA5 = 7562500;
    level.sentrysettings[noteworthy].lockstrength = 2;
    level.sentrysettings[noteworthy].sentrymodeon = "manual";
    level.sentrysettings[noteworthy].sentrymodeoff = "sentry_offline";
    level.sentrysettings[noteworthy].ammo = 200;
    level.sentrysettings[noteworthy].timeout = 999999;
    level.sentrysettings[noteworthy].spinuptime = 0.65;
    level.sentrysettings[noteworthy].overheattime = 8.0;
    level.sentrysettings[noteworthy].cooldowntime = 0.1;
    level.sentrysettings[noteworthy].fxtime = 0.3;
    level.sentrysettings[noteworthy].streakname = "sentry_gun";

    if(getdvarint("dvar_094577B429C0E801", 1) != 0) {
      if(istrue(_id_74502A9E0EF1F19C::player_has_nvg())) {
        level.sentrysettings[noteworthy].weaponinfo = "laser_trap_nvg";
        level.sentrysettings[noteworthy].playerweaponinfo = "laser_trap_nvg";
      } else {
        level.sentrysettings[noteworthy].weaponinfo = "laser_trap_not_nvg";
        level.sentrysettings[noteworthy].playerweaponinfo = "laser_trap_not_nvg";
      }
    } else {
      level.sentrysettings[noteworthy].weaponinfo = "sentry_turret_mp";
      level.sentrysettings[noteworthy].playerweaponinfo = "sentry_turret_mp";
    }

    level.sentrysettings[noteworthy].scriptable = "ks_sentry_turret_mp";
    level.sentrysettings[noteworthy].modelbasecover = "electronics_ir_laser_device_assembly_nogeo";
    level.sentrysettings[noteworthy].modelbaseground = "electronics_ir_laser_device_assembly_nogeo";
    level.sentrysettings[noteworthy].modeldestroyedcover = "electronics_ir_laser_device_assembly_nogeo";
    level.sentrysettings[noteworthy].modeldestroyedground = "electronics_ir_laser_device_assembly_nogeo";
    level.sentrysettings[noteworthy].placementhintstring = &"KILLSTREAKS_HINTS/SENTRY_GUN_PLACE";
    level.sentrysettings[noteworthy].ownerusehintstring = &"KILLSTREAKS_HINTS/SENTRY_USE";
    level.sentrysettings[noteworthy].otherusehintstring = &"KILLSTREAKS_HINTS/SENTRY_OTHER_USE";
    level.sentrysettings[noteworthy].dismantlehintstring = &"KILLSTREAKS_HINTS/SENTRY_DISMANTLE";
    level.sentrysettings[noteworthy].headicon = 1;
    level.sentrysettings[noteworthy].teamsplash = "used_sentry_gun";
    level.sentrysettings[noteworthy].destroyedsplash = "callout_destroyed_sentry_gun";
    level.sentrysettings[noteworthy].shouldsplash = 1;
    level.sentrysettings[noteworthy].votimeout = "sentry_shock_timeout";
    level.sentrysettings[noteworthy].vodestroyed = "sentry_shock_destroy";
    level.sentrysettings[noteworthy].scorepopup = "destroyed_sentry";
    level.sentrysettings[noteworthy].lightfxtag = "tag_fx";
    level.sentrysettings[noteworthy].iskillstreak = 1;
    level.sentrysettings[noteworthy].headiconoffset = (0, 0, 75);
    level.sentrysettings[noteworthy].modelbasecover = "electronics_ir_laser_device_rig_skeleton";
    level.sentrysettings[noteworthy].modelbaseground = "electronics_ir_laser_device_rig_skeleton";
    level.sentrysettings[noteworthy].modeldestroyedcover = "electronics_ir_laser_device_rig_skeleton";
    level.sentrysettings[noteworthy].modeldestroyedground = "electronics_ir_laser_device_rig_skeleton";
  }
}

_id_E819355654F9E50D() {
  _id_CB385B838E10F79E = getDvar("start", "captured");

  switch (_id_CB385B838E10F79E) {
    case "captured":
    default:
      scripts\cp_mp\utility\script_utility::registersharedfunc("player_spawn", "getPlayerSpawnPointOverride", _id_424D9A66F5FD1677::_id_04BFC487778DC703);
      level thread _id_45F0E1DC4CE9ECCB::_id_989F834A7B2FAD26();
      break;
    case "escape_warehouse":
      scripts\cp_mp\utility\script_utility::registersharedfunc("player_spawn", "getPlayerSpawnPointOverride", _id_424D9A66F5FD1677::_id_04BFC487778DC703);
      level.default_player_spawns = "escape_warehouse_spawner";
      level thread _id_45F0E1DC4CE9ECCB::_id_7545C0A807BDBF85();
      break;
    case "stealth_section":
      level.default_player_spawns = "checkpoint_stealth_section";
      level thread _id_45F0E1DC4CE9ECCB::_id_EF769F72F1D0CE93();
      break;
    case "mine_section":
      level.default_player_spawns = "checkpoint_mine_section";
      level thread _id_45F0E1DC4CE9ECCB::_id_17DD07C93A594717();
      break;
    case "mine_section_laser_2":
      level.default_player_spawns = "lasers_part2_player_start";
      level thread _id_45F0E1DC4CE9ECCB::_id_BD3357A2E9D0417A();
      break;
    case "mine_section_laser_3":
      level.default_player_spawns = "lasers_part3_player_start";
      level thread _id_45F0E1DC4CE9ECCB::_id_BD3358A2E9D043AD();
      break;
    case "mine_section_postlasers":
      level.default_player_spawns = "checkpoint_mine_postlasers";
      level thread _id_45F0E1DC4CE9ECCB::_id_1131B2B86A2D10BE();
      break;
    case "jugg_maze":
      level.default_player_spawns = "checkpoint_jugg_maze_postvent";
      level thread _id_45F0E1DC4CE9ECCB::_id_2553ABB1C853755B();
      break;
    case "jugg_maze_postkeycard":
      level.default_player_spawns = "checkpoint_jugg_maze_postvent";
      level thread _id_45F0E1DC4CE9ECCB::_id_C9B72BA20CAF35D4();
      break;
    case "start_airlock_door":
      level.default_player_spawns = "checkpoint_jugg_maze_postcore";
      level thread _id_45F0E1DC4CE9ECCB::_id_FC72C2A1756D1379();
      break;
    case "start_elevator":
      scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::_id_D2B495A37F842C93);
      level.default_player_spawns = "hadir_elevator_spawner";
      level thread _id_45F0E1DC4CE9ECCB::_id_C808A106B1C73E31();
      break;
    case "elevator_counter_weights":
      scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::_id_D2B495A37F842C93);
      level.default_player_spawns = "hadir_elevator_spawner_front";
      level thread _id_45F0E1DC4CE9ECCB::_id_63386CF513A24131();
      break;
    case "approach_elevator":
      scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::_id_D2B495A37F842C93);
      level.default_player_spawns = "hadir_elevator_defend_spawner";
      level thread _id_45F0E1DC4CE9ECCB::_id_D1CF807FE22A3697();
      break;
    case "elevator_defend":
      scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::_id_D2B495A37F842C93);
      level.default_player_spawns = "hadir_elevator_defend_spawner";
      level thread _id_45F0E1DC4CE9ECCB::_id_268132AFCDFD38DC();
      break;
    case "elevator_testing":
      scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::_id_D2B495A37F842C93);
      level.default_player_spawns = "hadir_elevator_spawner";
      level thread _id_45F0E1DC4CE9ECCB::_id_8DA9763E6F7212C1();
      break;
    case "open_elevator_door":
      scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::_id_D2B495A37F842C93);
      level.default_player_spawns = "hadir_elevator_spawner";
      level thread _id_45F0E1DC4CE9ECCB::_id_8F9EDFFD39DEE153();
      break;
  }
}

_id_D2B495A37F842C93() {
  thread _id_B015303B77ED75CD();
}

_id_B015303B77ED75CD() {
  if(!istrue(self._id_3479EEB609F48D4C)) {
    self endon("death_or_disconnect");
    level endon("game_ended");
    scripts\cp\killstreaks\airdrop_cp::_id_3FBFEE87EE058FE1(undefined, 1);
    self._id_3479EEB609F48D4C = 1;
  }
}

_id_B050F27723670DDE() {
  level._id_168F04BC9AFCFAAC = undefined;
  data = spawnStruct();
  door_ent = getEnt("maze_puzzle_door", "script_noteworthy");
  _id_FEF7FF29C1843069 = getEnt("maze_puzzle_door_model", "script_noteworthy");
  door_ent linkTo(_id_FEF7FF29C1843069);

  if(!isDefined(_id_FEF7FF29C1843069.script_offset))
    _id_FEF7FF29C1843069.script_offset = (0, 0, 100);

  _id_5AC49E018B46B2CD = scripts\engine\utility::getStruct(_id_FEF7FF29C1843069.target, "targetname");
  _id_5AC49E018B46B2CD scripts\cp\cp_juggernaut::_id_91ED8C25C9B88686();
  _id_20F3271DC43A6012 = scripts\engine\utility::getStruct(_id_5AC49E018B46B2CD.target, "targetname");
  _id_20F3271DC43A6012 scripts\cp\cp_juggernaut::_id_91ED8C25C9B88686();
  _id_5AC49E018B46B2CD.origin = _id_5AC49E018B46B2CD.origin + rotatevector((0, 0, 4), _id_5AC49E018B46B2CD.angles);
  _id_20F3271DC43A6012.origin = _id_20F3271DC43A6012.origin + rotatevector((0, 0, 4), _id_20F3271DC43A6012.angles);
  hintstring = &"CP_RAID_WATERMAZE/DOOR_OPEN";
  model = "tag_origin";
  _id_5AC49E018B46B2CD _id_34D2771929BD6022::_id_2FECC1AAB1890E7D(hintstring, model, 64, 256, "duration_none", "hide", -2);
  _id_20F3271DC43A6012 _id_34D2771929BD6022::_id_2FECC1AAB1890E7D(hintstring, model, 64, 256, "duration_none", "hide", -2);
  _id_34D2771929BD6022::_id_05F7C6BF2110C0FE(_id_FEF7FF29C1843069);
}

_id_B7A1D836D257B8BD() {
  self notify("vents_trackPlayerPosition");
  self endon("vents_trackPlayerPosition");
  self endon("disconnect");
  level endon("game_ended");
  self._id_217C1AF507AA009E = 0;
  self._id_9488E1610FF570D3 = 0;
  level._id_DB61F4E8DA3F6664 = 0;
  level._id_F4F0553929F58C15 = [];

  for(;;) {
    wait 1;

    if(self istouching(level._id_4C86D225790B50B9)) {
      self._id_217C1AF507AA009E = 1;

      if(getdvarint("dvar_EE30F47163CE653B", 0))
        self iprintln("^4 INSIDE VENT! ");

      continue;
    }

    self._id_217C1AF507AA009E = 0;

    if(getdvarint("dvar_EE30F47163CE653B", 0))
      self iprintln("^1 OUTSIDE VENT ");
  }
}

_id_400A2209C5C763C4() {
  level endon("game_ended");
  level._id_DB61F4E8DA3F6664 = 0;
  level._id_F4F0553929F58C15 = [];

  for(;;) {
    self waittill("trigger", entity);

    if(isDefined(entity)) {
      if(!entity scripts\cp\utility::is_valid_player())
        continue;
    }

    foreach(player in level.players) {
      if(player istouching(self)) {
        player._id_217C1AF507AA009E = 1;

        if(getdvarint("dvar_EE30F47163CE653B", 0))
          player iprintln("^4 INSIDE VENT! ");

        if(!scripts\engine\utility::array_contains(level._id_F4F0553929F58C15, player))
          level._id_F4F0553929F58C15 = scripts\engine\utility::array_add(level._id_F4F0553929F58C15, player);

        continue;
      }

      player._id_217C1AF507AA009E = 0;

      if(getdvarint("dvar_EE30F47163CE653B", 0))
        player iprintln("^1 OUTSIDE VENT ");

      if(scripts\engine\utility::array_contains(level._id_F4F0553929F58C15, player))
        level._id_F4F0553929F58C15 = scripts\engine\utility::array_remove(level._id_F4F0553929F58C15, player);
    }
  }
}

_id_07F94C62EE68B800(victim, eattacker, einflictor, objweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("vents_updatePlayerEvent");
  self endon("vents_updatePlayerEvent");
  self._id_9488E1610FF570D3++;
  level._id_DB61F4E8DA3F6664++;

  if(!isDefined(self._id_9488E1610FF570D3))
    self._id_9488E1610FF570D3 = 0;

  if(!isDefined(level._id_DB61F4E8DA3F6664)) {
    if(!isDefined(level._id_DB61F4E8DA3F6664))
      level._id_DB61F4E8DA3F6664 = 0;
  }

  wait 4;

  if(level._id_DB61F4E8DA3F6664 > 12 || _func_8CE5803B7D377D72(self) == 1) {
    if(isPlayer(self) && istrue(self._id_217C1AF507AA009E))
      thread _id_E926FF50F6FD2163();
  }

  self._id_9488E1610FF570D3 = 0;
  level._id_DB61F4E8DA3F6664 = 0;
}

_id_E926FF50F6FD2163() {
  player = self;
  _id_D6EA6436C209971B = scripts\engine\utility::get_array_of_closest(player.origin, getaiarray("axis"), undefined, undefined, 1024);

  if(_id_D6EA6436C209971B.size > 0) {
    foreach(guy in _id_D6EA6436C209971B) {
      _id_F3E5EC9ECAAF8E1B = player.origin;
      grenade = magicgrenademanual("gas_grenade_mp", _id_F3E5EC9ECAAF8E1B, (0, 0, 1), 0.1);
      grenade.owner = guy;
      guy thread scripts\cp\equipment\cp_gas_grenade::gas_used(grenade);
    }
  }
}

_id_B94C9CB6E83F2E6E() {
  return level._id_F4F0553929F58C15;
}

_id_72EF66C68431D0E4(target) {
  self endon("kill_magic_bullet");
  self endon("death");
  level endon("game_ended");

  if(istrue(self.scripted_mode)) {
    return;
  }
  weapon = self.weapon;
  _id_73DB5E595DC80C23 = 50;
  fire_rate = 0.1;
  start = self.origin;
  end = undefined;

  if(isDefined(target))
    end = target.origin;
  else
    end = self getclosestenemy(1024, 120, 1).origin;

  _id_0F2C6E7B3FC1C38A = 0;

  if(isDefined(self.script_dot))
    _id_0F2C6E7B3FC1C38A = self.script_dot;

  if(isDefined(self.script_count))
    _id_73DB5E595DC80C23 = self.script_count;

  if(isDefined(self.script_burst_fire_rate))
    fire_rate = self.script_burst_fire_rate;

  if(isDefined(self.script_delay))
    wait(self.script_delay);

  shots_fired = 0;
  self.scripted_mode = 1;
  self hudoutlineenable("outline_nodepth_red");
  _id_4BB23F70102CF6BC::_id_587202DCEF401B18(target, 2, 1);

  for(;;) {
    self.projectile = scripts\cp_mp\utility\weapon_utility::_magicbullet(weapon, start, end, self, self);
    wait(fire_rate);
    shots_fired++;

    if(_id_73DB5E595DC80C23 == -1) {
      continue;
    }
    if(shots_fired >= _id_73DB5E595DC80C23) {
      break;
    }
  }

  self.scripted_mode = 0;
  self hudoutlinedisable();
  _id_4BB23F70102CF6BC::_id_815B24F247658730(target);
}

_id_75B8976CF0C4104F(victim, eattacker, einflictor, objweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath) {
  if(getdvarint("dvar_EE1AF47163B63208", 1) != 1) {
    return;
  }
  if(isPlayer(eattacker) && istrue(eattacker._id_217C1AF507AA009E))
    eattacker thread _id_07F94C62EE68B800(victim, eattacker, einflictor, objweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath);
}

_id_C28066D826277380(trigger) {
  if(getdvarint("dvar_EE1AF47163B63208", 1) != 1) {
    return;
  }
  if(isPlayer(self) && istrue(self._id_217C1AF507AA009E)) {
    _id_DE88CD14114C1E24 = makeweapon("gas_mp");
    self dodamage(getdvarint("dvar_53C3DA95FFD8D319", 10), self.origin, trigger.owner, trigger, "MOD_GRENADE_SPLASH", _id_DE88CD14114C1E24);
    thread _id_E3EC5AB573FDB1A7(trigger);
  }
}

_id_E3EC5AB573FDB1A7(trigger) {
  level endon("game_ended");
  self endon("death");
  trigger endon("death");
  wait 1;

  while(isDefined(self.gastriggerstouching) && self.gastriggerstouching.size > 0) {
    wait(getdvarfloat("dvar_3A01AFBA7D6B10D5", 1));

    if(isPlayer(self) && istrue(self._id_217C1AF507AA009E)) {
      _id_DE88CD14114C1E24 = makeweapon("gas_mp");
      self dodamage(getdvarint("dvar_B8B68077FAE09637", 15), self.origin, trigger.owner, trigger, "MOD_GRENADE_SPLASH", _id_DE88CD14114C1E24);
    }
  }
}

_id_AA38A86A8D57D526(_id_1730C8D8475566CD, _id_FB1DEF007972B25A, reviveent) {
  _id_9DDF8D4378FCEB16 = scripts\engine\utility::getStructArray("static_death_cam", "script_noteworthy");
  _id_F42869166D50FBE9 = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(!isDefined(_id_F42869166D50FBE9) || _id_F42869166D50FBE9 == "")
    _id_F42869166D50FBE9 = getDvar("start");

  _id_5C72B818B0325D8C = undefined;

  if(isDefined(_id_F42869166D50FBE9)) {
    switch (_id_F42869166D50FBE9) {
      case "checkpoint_rescue_warehouse":
      case "checkpoint_captured_blind":
        _id_5C72B818B0325D8C = _id_E0CF5BA976B37016(_id_9DDF8D4378FCEB16, "captured");
        break;
      case "checkpoint_stealth_section":
        _id_5C72B818B0325D8C = _id_E0CF5BA976B37016(_id_9DDF8D4378FCEB16, "stealth_tunnel");
        break;
      case "checkpoint_mine_section":
      case "checkpoint_mine_postlasers":
        _id_5315AB24A3128ABB = _id_E0CF5BA976B37016(_id_9DDF8D4378FCEB16, "laser_mines");
        _id_5315AC24A3128CEE = _id_E0CF5BA976B37016(_id_9DDF8D4378FCEB16, "laser_mines_2");
        _id_5C72B818B0325D8C = scripts\engine\utility::getclosest(_id_1730C8D8475566CD.origin, [_id_5315AB24A3128ABB, _id_5315AC24A3128CEE]);
        break;
      case "checkpoint_jugg_maze_section_postcard":
      case "checkpoint_jugg_maze":
      case "checkpoint_jugg_maze_section_postcore":
      case "checkpoint_jugg_maze_section_postvent":
        _id_5C72B818B0325D8C = _id_E0CF5BA976B37016(_id_9DDF8D4378FCEB16, "jugg_maze");
        break;
      case "checkpoint_elevator_section":
      case "checkpoint_elevator_defend_start":
      case "checkpoint_elevator_section_downstairs":
        _id_5C72B818B0325D8C = _id_E0CF5BA976B37016(_id_9DDF8D4378FCEB16, "elevator");
        break;
      default:
        _id_5C72B818B0325D8C = scripts\engine\utility::getclosest(_id_1730C8D8475566CD.origin, _id_9DDF8D4378FCEB16);
        break;
    }
  } else
    _id_5C72B818B0325D8C = scripts\engine\utility::getclosest(_id_1730C8D8475566CD.origin, _id_9DDF8D4378FCEB16);

  startpos = _id_5C72B818B0325D8C.origin;
  mover = spawn("script_model", startpos);
  mover setModel("tag_origin");
  mover.angles = _id_5C72B818B0325D8C.angles;
  mover thread _id_0AFB7E332AEE4BF2::cleanuplaststandent(_id_1730C8D8475566CD);
  _id_1730C8D8475566CD cameralinkTo(mover, "tag_origin");
  wait 2;

  if(isDefined(mover))
    mover delete();
}

_id_E0CF5BA976B37016(_id_A260750D2D3EB8B6, _id_838DCE3ED0A1A11C) {
  foreach(cam in _id_A260750D2D3EB8B6) {
    if(isDefined(cam.targetname) && cam.targetname == _id_838DCE3ED0A1A11C)
      return cam;
  }

  return undefined;
}

_id_F8C99FB28FA6A3DB(_id_47E569777F8BB300) {
  _id_45D25409ACB2D4F9 = level.players;

  if(_id_0AFB7E332AEE4BF2::everyone_else_all_in_laststand(_id_47E569777F8BB300))
    return 1;

  _id_0103ECCDF7E3E958 = _id_4BB23F70102CF6BC::_id_B34C6E374DF9C4A1(1);
  _id_D9E0D4D64A22FE76 = scripts\engine\utility::array_remove(_id_45D25409ACB2D4F9, _id_47E569777F8BB300);
  _id_F45C2577F4B46E85 = _id_4BB23F70102CF6BC::_id_91C2742E256F657D();
  _id_27AADF1D3D97D7BC = _id_4BB23F70102CF6BC::_id_91C2742E256F657D(1);
  _id_B83ADCBD1D76E652 = scripts\engine\utility::array_remove(_id_F45C2577F4B46E85, _id_47E569777F8BB300);

  if(_id_B83ADCBD1D76E652.size == 0) {
    _id_5A67C9D0186C1589 = &"CP_RAID_COMPLEX_JUGG_MAZE/OP_ROOM_DEATH";
    scripts\cp\cp_hud_message::teamhudtutorialmessage(_id_5A67C9D0186C1589, "allies", 3);
    level._id_04D5F75DF17960BF = "op_room_player_killed";
    return 1;
  }

  _id_B446E0A56D7D3A5D = _id_4BB23F70102CF6BC::_id_B34C6E374DF9C4A1();
  _id_3A4812AFCB00DE9A = scripts\engine\utility::array_remove(_id_B446E0A56D7D3A5D, _id_47E569777F8BB300);

  if(_id_3A4812AFCB00DE9A.size == 0) {
    if(_id_0103ECCDF7E3E958.size == 0)
      return _id_0AFB7E332AEE4BF2::everyone_else_all_in_laststand(_id_47E569777F8BB300);

    _id_5A67C9D0186C1589 = &"CP_RAID_COMPLEX_JUGG_MAZE/MAZE_PLAYERS_KILLED";
    scripts\cp\cp_hud_message::teamhudtutorialmessage(_id_5A67C9D0186C1589, "allies", 3);
    level._id_04D5F75DF17960BF = "maze_players_killed";
    return 1;
  }

  return 0;
}

_id_106779AEC832EF6D() {
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / KEYCARD:20 / Drop Keycard\" \"set scr_spawn_keycard 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  thread _id_F43CE7EA19394743();
}

_id_F43CE7EA19394743() {
  level endon("game_ended");
  _id_4D56A5BE03B9585F = ["interactable_note_keycard_raid4_maze"];
  setDvar("dvar_A4D28B299F4EE2E8", 0);

  for(;;) {
    if(getdvarint("dvar_A4D28B299F4EE2E8", 0) <= 0) {
      wait 0.5;
      continue;
    }

    _id_EAC2001CA8C8089B = level.players[0];
    _id_EAC2001CA8C8089B _id_4BB23F70102CF6BC::_id_C5979FDECB85AC32("interactable_note_keycard_raid4_maze", undefined, 1, 1);
    setDvar("dvar_A4D28B299F4EE2E8", 0);
  }
}

_id_101ACB9841ABA040() {
  level endon("game_ended");
  level endon("hadir_elevator_crashed");
  level endon("hadir_elevator_escaped");
  _id_8831727CF86C30A0 = scripts\engine\utility::getStructArray("elevator_exploit_repellers", "script_noteworthy");

  for(;;) {
    foreach(player in level.players) {
      foreach(marker in _id_8831727CF86C30A0) {
        if(distance(marker.origin, player.origin) <= 120) {
          if(player _meth_415FE9EECA7B2E2B())
            player _meth_8CA38A054F432FF2();

          level thread _id_39CC2868F024CE23(marker, player);
        }
      }

      waitframe();
    }

    waitframe();
  }
}

_id_39CC2868F024CE23(_id_2512AB39FCD38587, player) {
  level endon("game_ended");
  droppoint = scripts\cp\utility::get_point_in_local_ent_space(_id_2512AB39FCD38587, (130, 0, 0));
  player setOrigin(droppoint, 1);
}

_id_93ABDD2400A0A3E0() {
  self endon("death");

  if(isDefined(self.weapon))
    self takeallweapons();

  _id_ED540658678514F1 = _id_2669878CF5A1B6BC::buildweapon("iw9_lm_dblmg2_cp", scripts\engine\utility::array_combine(_func_6527364C1ECCA6C6("iw9_lm_dblmg2_cp"), ["laserbox_hip03"]));
  self.weapon = _id_ED540658678514F1;
  scripts\common\utility::initweapon(self.weapon);
  self giveweapon(self.weapon);
  self setspawnweapon(_id_ED540658678514F1);
  self.primaryweapon = _id_ED540658678514F1;
  wait 1;
  self laseron();
}

_id_55B2AB068074D468() {
  level endon("game_ended");
  scripts\engine\utility::flag_init("stealth_music_pause");
  scripts\engine\utility::flag_wait("both_players_intro_binks_complete");
  level._id_D9C72C053D9F2FED = "mx_cp_jugg_maze_nearsighted";
  start = getDvar("start");
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if((start == "captured" || start == "") && checkpoint == "") {
    level._id_C04EE29C854B01B8 = 1;
    level._id_4F2AB335EF95E1E3 = 1;

    if(getdvarint("dvar_F5740209893CDF46", 0))
      level thread scripts\stealth\init::set_stealth_mode(1, "mx_cp_jugg_maze_nearsighted", "mx_cp_jugg_maze_spottedfail");

    return;
  }
}

_id_F2CCA3182C8AD9B3() {
  setmusicstate("mx_cp_jugg_maze_nearsighted");
}

_id_9F97ECDCC0B8DEDC() {
  setmusicstate("mx_cp_jugg_maze_spottedfail");
}

_id_85CB4FB3C2383B84() {
  level endon("game_ended");

  while(!isDefined(level.players))
    waitframe();

  while(level.players.size == 0)
    waitframe();

  level._id_D9C72C053D9F2FED = undefined;
  level._id_C04EE29C854B01B8 = 1;
  level._id_4F2AB335EF95E1E3 = 1;

  if(getdvarint("dvar_F5740209893CDF46", 0))
    level thread scripts\stealth\init::set_stealth_mode(1, "mx_cp_jugg_maze_tier1_hidden", "mx_cp_jugg_maze_tier1_found");

  waitframe();
  _id_C3448D4698F8DCED();
}

_id_B70F7000FA998CBA() {
  level endon("game_ended");
  _id_02B67DF3DE379A0E();
  level._id_C04EE29C854B01B8 = 1;
  level._id_4F2AB335EF95E1E3 = 1;

  if(getdvarint("dvar_F5740209893CDF46", 0))
    level thread scripts\stealth\init::set_stealth_mode(1, "mx_cp_jugg_maze_tier2_hidden", "mx_cp_jugg_maze_tier2_found");

  waitframe();
  _id_A0EA022D43EE0F78();
}

_id_C3448D4698F8DCED() {
  setmusicstate("mx_cp_jugg_maze_tier1_stealth");
}

_id_A0EA022D43EE0F78() {
  setmusicstate("mx_cp_jugg_maze_tier2_stealth");
}

_id_9D7CE2AFF0635EBF() {
  setmusicstate("mx_cp_jugg_maze_laser1");
}

_id_9D7CE3AFF06360F2() {
  setmusicstate("mx_cp_jugg_maze_laser2");
}

_id_9D7CE4AFF0636325() {
  _func_A3901A965FC1D7DD("mx_cp_jugg_maze_laser2");
}

_id_C4E1DB936975EB1B() {
  scripts\engine\utility::flag_set("stealth_music_pause");
}

_id_02B67DF3DE379A0E() {
  scripts\engine\utility::flag_clear("stealth_music_pause");
}

_id_A42ED29F372BEE6B() {
  setmusicstate("mx_cp_jugg_maze_finalbattle");
}

_id_97B69D7F6259C773() {
  _func_A3901A965FC1D7DD("mx_cp_jugg_maze_finalbattle");
}

_id_C56F95CF7E0C190B(_id_1730C8D8475566CD, _id_BBDCC7365DD1C6BA) {
  if(isDefined(level._id_4C86D225790B50B9)) {
    if(_id_1730C8D8475566CD istouching(level._id_4C86D225790B50B9)) {
      _id_BBDCC7365DD1C6BA = scripts\engine\utility::getclosest(_id_1730C8D8475566CD.origin, level._id_E9DED374A39ECF8E).origin;
      return _id_BBDCC7365DD1C6BA;
    }
  }

  return _id_BBDCC7365DD1C6BA;
}

_id_BDB149C2835E58DD(_id_1730C8D8475566CD, _id_BBDCC7365DD1C6BA) {
  if(isDefined(level._id_2BC9DA10C058E6BC)) {
    foreach(_id_F058EDB91C155846 in level._id_2BC9DA10C058E6BC) {
      if(_id_1730C8D8475566CD istouching(_id_F058EDB91C155846)) {
        _id_BBDCC7365DD1C6BA = scripts\engine\utility::getclosest(_id_1730C8D8475566CD.origin, level._id_94ACA63D774C01F7).origin;
        return _id_BBDCC7365DD1C6BA;
      }
    }
  }

  return _id_BBDCC7365DD1C6BA;
}