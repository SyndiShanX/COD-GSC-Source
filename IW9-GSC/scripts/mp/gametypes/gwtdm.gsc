/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\gwtdm.gsc
***********************************************/

main() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  _id_9BBACB179DEA3237[1] = "arm";
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 300);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 3);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  setDvar("ai_allowdormancy", 0);
  setDvar("dvar_405E7E20D91344CC", 0);
  setDvar("scr_allow_technicals", 1);
  setDvar("scr_runlean_max_technicals", 30);
  setDvar("dvar_E4FA721677F03DE0", 1);
  setDvar("cg_friendlyReviveNameplateEnabled", 0);
  enablegroundwarspawnlogic(400, 1200);
  updategametypedvars();
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(::onjoinedteam);
  level._id_A0F41EC8E5268D15 = getdvarint("dvar_C3BABB46FE3FD12B", 1) == 1;
  level.scoreperplayer = undefined;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.modeonspawnplayer = ::onspawnplayer;
  level.onplayerkilled = ::onplayerkilled;
  level.onrespawndelay = ::getrespawndelay;
  level.onnormaldeath = ::onnormaldeath;
  level._id_CE95C7540070F7D0 = ::_id_CE95C7540070F7D0;
  level._id_8DECCE720ED19F1A = ::_id_8DECCE720ED19F1A;
  level.onplayerconnectstream = ::onplayerconnectstream;
  level.requiredplayercountoveride = 1;
  level.requiredplayercount["allies"] = 24;
  level.requiredplayercount["axis"] = 24;
  level._id_E637D49948A038D3 = ::getmissedinfilcamerapositions;
  level._id_3C89983E2030DFFF = ::calculatecameraoffset;
  game["dialog"]["gametype"] = "iw9_gwtd_mode_uktl_gtnm";

  if(getdvarint("scr_diehard"))
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  else if(getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_promode")))
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";

  game["dialog"]["offense_obj"] = "iw9_gwtd_mode_uktl_gtbs";
  game["dialog"]["defense_obj"] = "iw9_gwtd_mode_uktl_gtbs";
  game["dialog"]["lead_taken"] = "iw9_gwtd_mode_uktl_gtlg";
  game["dialog"]["lead_lost"] = "iw9_gwtd_mode_uktl_gtll";
  game["dialog"]["lead_tied"] = "iw9_gwtd_mode_uktl_gtlt";
  game["dialog"]["gwtdm_push_foward"] = "iw9_gwtd_mode_uktl_gtpo";
  game["dialog"]["gwtdm_fall_back"] = "iw9_gwtd_mode_uktl_gtpd";
  game["dialog"]["score_25_winning"] = "iw9_gwtd_mode_uktl_wi25";
  game["dialog"]["score_25_losing"] = "iw9_gwtd_mode_uktl_lo25";
  game["dialog"]["score_50_winning"] = "iw9_gwtd_mode_uktl_wi50";
  game["dialog"]["score_50_losing"] = "iw9_gwtd_mode_uktl_lo50";
  game["dialog"]["score_75_winning"] = "iw9_gwtd_mode_uktl_wi75";
  game["dialog"]["score_75_losing"] = "iw9_gwtd_mode_uktl_lo75";
  game["dialog"]["score_90_winning"] = "iw9_gwtd_mode_uktl_wi90";
  game["dialog"]["score_90_losing"] = "iw9_gwtd_mode_uktl_lo90";
  game["dialog"]["carepackage_inc"] = "iw9_gwtd_mode_uktl_gtcp";
  game["dialog"]["vehicles_inc"] = "iw9_gwtd_mode_uktl_gtv1";
  game["dialog"]["vehicles2_inc"] = "iw9_gwtd_mode_uktl_gtv2";
  game["dialog"]["tier2_friendly"] = "iw9_gwtd_mode_uktl_frt2";
  game["dialog"]["tier2_enemy"] = "iw9_gwtd_mode_uktl_ent2";
  game["dialog"]["tier3_friendly"] = "iw9_gwtd_mode_uktl_frt3";
  game["dialog"]["tier3_enemy"] = "iw9_gwtd_mode_uktl_ent3";
  level.nosuspensemusic = 1;
  level._effect["vfx_smk_signal_gr"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal_gr");
  level._effect["vfx_snatch_ac130_clouds"] = loadfx("vfx/iw8_mp/gamemode/vfx_snatch_ac130_clouds.vfx");
  level._effect["vfx_br_infil_cloud_scroll"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_cloud_scroll.vfx");
  level._effect["vfx_br_infil_jump_smoke_01"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_smoke_01.vfx");
  level._effect["vfx_br_infil_jump_smoke_01_enemy"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_smoke_01_enemy.vfx");
  level._effect["vfx_br_infil_jump_smoke_01_friendly"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_smoke_01_friendly.vfx");
  level._effect["vfx_br_infil_jump_wisp_01"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_01.vfx");
  level._effect["vfx_br_infil_jump_wisp_02"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_02.vfx");
  level._effect["vfx_br_infil_omni_light"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_omni_light.vfx");
  level._effect["vfx_br_infil_spot_light"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_spot_light.vfx");
  level._effect["vfx_gameplay_tier2_helmet_pop"] = loadfx("vfx/iw9/gameplay/mp/vfx_gameplay_tier2_helmet_pop.vfx");
  level._effect["vfx_gameplay_tier3_helmet_pop"] = loadfx("vfx/iw9/gameplay/mp/vfx_gameplay_tier3_helmet_pop.vfx");
  level._id_A98A9986264D0EFC = getdvarint("dvar_6228446F42D1367F", 1) == 1;
  level.userallypointvehicles = getdvarint("dvar_9381D93D96C2F50B", 1);
  level.hideenemyhq = getdvarint("dvar_5309488DD7832413", 0);
  level.hideenemyfobs = getdvarint("dvar_7AEFD938EDD32DCC", 0);
  level.completelyremovelittlebird = getdvarint("dvar_E39E476D418A5B03", 0);
  level._id_67A7732487FB9242 = getdvarint("dvar_E4A8296B521A6DEE", 1) == 1;
  level._id_90F4DC933B674184 = getdvarfloat("dvar_91D950C33D45AE50", 60.0);
  level._id_1A505675F3EF1197 = getdvarfloat("dvar_58C456EBD6371A4B", 60.0);
  level._id_8E9DABA162280A8E = getdvarint("dvar_19E5CADA53CCF044", 0) == 1;
  level._id_EAA760F325371803 = getdvarint("dvar_67A32114CE80B58F", 0) == 1;
  level._id_7F5BE0207E7457B1 = getdvarint("dvar_27ABAA55D7EC8EB9", 1) == 1;
  level._id_AD7B64F93B499EDB = getdvarint("dvar_0A3D174D73BEA831", 1) == 1;
  level._id_7232D887DBDA3729 = getdvarint("dvar_D23A54732DB0ACD0", 1) == 1;
  level._id_7232D587DBDA3090 = getdvarint("dvar_D23A57732DB0B369", 1) == 1;
  level._id_FA789E7BAB605E4C = getdvarint("dvar_72771BED0CB9E6FB", 1) == 1;
  level._id_AADF4E234F763771 = getdvarint("dvar_D141C82B315573ED", 9);
  level.dropbrloot = getdvarint("dvar_1D196605F8A290E3", 0);
  level.br_plunder_enabled = getdvarint("scr_game_cash", 0);

  if(level.br_plunder_enabled) {
    _id_600B944A95C3A7BF::init();
    level._id_E247454AC2869696 = 0;
  }

  level._id_1E17E3480B1D264D = getdvarint("dvar_644F043F54D141F5", 0);
  level._id_1F42DAB41EFF5CB2 = getdvarint("dvar_8FD67E929AF907EB", 0);

  if(level._id_1E17E3480B1D264D)
    level._id_9C1E3C18B99409E9 = scripts\mp\utility\points::_id_9C1E3C18B99409E9;

  level.spawnselectionshowenemy = getdvarint("scr_spawnselectionshowenemy", 0);
  level.spawnselectionshowfriendly = getdvarint("scr_spawnselectionshowfriendly", 0);
  level.forcetopickafob = getdvarint("dvar_04A4C22866751F8E", 0);
  level.maxhqtanks = getdvarint("scr_arm_maxhqtanks", 2);
  level.tankrespawntime = getdvarint("dvar_B624863894A18F21", 120);
  level.apcrespawntime = getdvarint("dvar_BA2474692378B203", 120);
  level.longdialoguecooldown = getdvarint("dvar_E01953FCF34A5D51", 1);
  level.numnonrallyvehicles = getdvarint("scr_arm_numnonrallyvehicles", 25);
  level.disablepersonalnuke = getdvarint("dvar_F271257BDDC28C95", 0);
  level.personalnukecostoverride = getdvarint("scr_personalnukecostoverride", 30);
  level.showteamtanks = getdvarint("dvar_236401104966B535", 1);
  level.spawnselectionafktime = getdvarint("dvar_DA4E1D4C2111A1BC", 120);
  level.manualadjustlittlebirdlocs = getdvarint("dvar_1D04716268113CB5", 1);
  level._id_56BCDC219D432F80 = [];

  if(istrue(level.showteamtanks)) {
    level.trackedtanks = [];
    level.trackedtanks["axis"] = [];
    level.trackedtanks["allies"] = [];
  }

  level.modecontrolledvehiclespawningonly = 1;
  level.disableteamstartspawns = 1;
  level.spawnprotectionexception = ::spawnprotectionexception;
  thread _id_658C8F668D2CD83C();
  scripts\engine\utility::flag_init("stealth_enabled");
  scripts\engine\utility::flag_init("level_stealth_initialized");
  scripts\engine\utility::flag_init("stealth_spotted");
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("dvar_4534D741E9C101D0", getmatchrulesdata("kothData", "zoneLifetime"));
  setdynamicdvar("dvar_ACCF47B7CC3FF48A", getmatchrulesdata("kothData", "zoneCaptureTime"));
  setdynamicdvar("dvar_942EEE1708BDFF82", getmatchrulesdata("kothData", "zoneActivationDelay"));
  setdynamicdvar("dvar_A5F514D70BC59C27", getmatchrulesdata("kothData", "randomLocationOrder"));
  setdynamicdvar("dvar_161F512A8EFE13F2", getmatchrulesdata("kothData", "additiveScoring"));
  setdynamicdvar("dvar_855B11A6ED4DB948", getmatchrulesdata("kothData", "pauseTime"));
  setdynamicdvar("dvar_013B7111B0A7197B", getmatchrulesdata("tdefData", "spawnDelay"));
  scripts\mp\utility\game::registerhalftimedvar("arm", 0);
}

onstartgametype() {
  scripts\engine\utility::flag_init("frontline_data_init");

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  foreach(team in level.teamnamelist)
  scripts\mp\utility\game::setobjectivehinttext(team, &"OBJECTIVES/GWTDM_HINT");

  setclientnamemode("auto_change");
  level.objectives = [];
  level.uncapturableobjectives = [];
  level._id_03FBBC6279594DDF = getdvarint("dvar_B43BFF2A3DD04855", 0) == 1;
  debug_setupmatchdata();
  setuphqs();
  initspawns();
  seticonnames();
  level.usedomflag = 0;
  level.killstreakqueue = [];
  level.teamkillstreakqueue = [];
  level.teamkillstreakqueue["allies"] = [];
  level.teamkillstreakqueue["axis"] = [];
  level.killstreaklist = [];
  level.killstreaklist[4] = ["cruise_predator", "scrambler_drone_guard"];
  level.killstreaklist[3] = ["precision_airstrike", "multi_airstrike", "bradley"];
  level.killstreaklist[2] = ["toma_strike", "chopper_gunner", "pac_sentry", "gunship"];
  level.teamkillstreakqueue["allies"] = ["cruise_predator", "precision_airstrike", "cruise_predator"];
  level.teamkillstreakqueue["axis"] = ["cruise_predator", "precision_airstrike", "cruise_predator"];
  level thread setupwaypointicons();
  calculatehqmidpoint();
  sethqmarkerobjective();

  if(level.usespawnselection)
    level thread _id_84FFED4EC1563259();

  if(istrue(level.userallypointvehicles)) {
    scripts\mp\rally_point::init();
    level thread _id_27C2DB69A21775A0::init_rallyvehicles();
  }

  level.numhqtanks_axis = 0;
  level.numhqtanks_allies = 0;
  level.maxhqtanks = 0;
  thread _id_27C2DB69A21775A0::_id_417194D265D63273();
  level thread scripts\mp\spawnselection::updatefobindanger();
  scripts\mp\utility\dialog::initstatusdialog();
  emergency_cleanupents();
  level thread _id_AABAACE9C798A2E1();

  if(getdvarint("dvar_248A817B330F8BEA", 1) == 1)
    level _id_E2AD02BE26BA3879();

  scripts\cp_mp\parachute::initparachutedvars();
  level thread _id_640CF1641C03E2A0::_id_CA39A413ACE3C168();
  level thread _id_2BC0B0102F9B7751::_id_D0FFCD08E0870CF2();

  if(getdvarint("dvar_48D28BA522840D33", 1) == 1)
    level thread _id_F16652E1462A3739();

  if(getdvarint("dvar_289D6DA5E0AFF476", 1) == 1) {
    level._id_04EB71F2B8CBA5CB = ::_id_6B1CBD26D1B252B4;
    level thread _id_6AD69DDD2454E5B3();
  }

  level thread _id_6D1FED8DD6165391();
  level thread _id_A999B4EE6F415E8C();

  if(level._id_33809C8A29CA064E[0]._id_A2D0446BC9B000AB[0]._id_E59F791D76C7BEEE.size > 0) {
    level thread _id_C1313BF26D803678("axis");
    level thread _id_C1313BF26D803678("allies");
  }

  level thread _id_4BAF8B94714B68FE();
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level._id_47E84D3946482B9F = scripts\mp\utility\dvars::dvarintvalue("gainPlantedSites", 0, 0, 1);
  level._id_85FAAACED1B1D39C = scripts\mp\utility\dvars::dvarintvalue("loseDestroyedSites", 1, 0, 1);
  level._id_3B3A02F94873E48A = scripts\mp\utility\dvars::dvarintvalue("gainDestroyedSites", 0, 0, 1);
  level.pausescoring = scripts\mp\utility\dvars::dvarintvalue("pauseTime", 1, 0, 1);
  level.delayplayer = scripts\mp\utility\dvars::dvarintvalue("delayPlayer", 0, 0, 1);
  level.spawndelay = scripts\mp\utility\dvars::dvarfloatvalue("spawnDelay", 5, 0, 30);
  level.flagcapturetime = scripts\mp\utility\dvars::dvarfloatvalue("flagCaptureTime", 30, 0, 30);
  level.flagsrequiredtoscore = scripts\mp\utility\dvars::dvarintvalue("flagsRequiredToScore", 1, 1, 3);
  level.pointsperflag = scripts\mp\utility\dvars::dvarintvalue("pointsPerFlag", 1, 1, 300);
  level.flagneutralization = scripts\mp\utility\dvars::dvarintvalue("flagNeutralization", 0, 0, 1);
  level.precappoints = scripts\mp\utility\dvars::dvarintvalue("preCapPoints", 0, 0, 1);
  level.capturedecay = scripts\mp\utility\dvars::dvarintvalue("captureDecay", 1, 0, 1);
  level.capturetype = scripts\mp\utility\dvars::dvarintvalue("captureType", 1, 0, 3);
  level.numflagsscoreonkill = scripts\mp\utility\dvars::dvarintvalue("numFlagsScoreOnKill", 0, 0, 3);
  level.objectivescaler = scripts\mp\utility\dvars::dvarfloatvalue("objScalar", 4, 1, 10);
  level._id_55328518D6FB7D07 = scripts\mp\utility\dvars::dvarintvalue("pointsperkill_ai", 1, 0, 10);
}

seticonnames() {}

emergency_cleanupents() {
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("delete_on_load", "targetname");
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("vehicle_volume", "script_noteworthy");
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("vehicle_volume_simplified", "script_noteworthy");
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("super", "script_noteworthy");
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("militarybase", "script_noteworthy");
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("location_volume", "targetname");
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("locale_area_trigger", "targetname");
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("bank_entry_detector", "targetname");
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("shadow_blocker", "targetname");
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_prison_cell_metal_mp", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("veh8_mil_air_acharlie130", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_wooden_panel_mp_01", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("me_electrical_box_street_01", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bycodeclassname("light");

  if(isDefined(level.localeid) && level.localeid == "locale_6")
    scripts\cp_mp\utility\game_utility::removematchingents_bykey("locale_8", "script_noteworthy");

  _id_A48BA5EE7FE7C64C = [];
  _id_A48BA5EE7FE7C64C[0] = (-22592, 27367, 1000);
  _id_A48BA5EE7FE7C64C[1] = (-22592, 27303, -448);
  _id_A48BA5EE7FE7C64C[2] = (7837, -9674, 1154);
  _id_A48BA5EE7FE7C64C[3] = (7637, -9674, 1154);
  _id_A48BA5EE7FE7C64C[4] = (7901, -9674, -270);
  _id_A48BA5EE7FE7C64C[5] = (7701, -9674, -270);
  _id_A48BA5EE7FE7C64C[6] = (10366, -11606, 66);
  _id_A48BA5EE7FE7C64C[7] = (10366, -11813, 66);
  _id_A48BA5EE7FE7C64C[6] = (10366, -11670, -270);
  _id_A48BA5EE7FE7C64C[7] = (10366, -11877, -270);
  _id_A48BA5EE7FE7C64C[8] = (7498, -11716, 66);
  _id_A48BA5EE7FE7C64C[9] = (7498, -11652, -270);
  _id_A48BA5EE7FE7C64C[10] = (-1200, -18954, -242);
  _id_A48BA5EE7FE7C64C[11] = (-1215, -19016, 774);
  ents = getEntArray();

  foreach(ent in ents) {
    if(isDefined(ent.model) && ent.model == "tag_origin") {
      _id_E24C6C7277A83762 = 0;

      foreach(_id_6CD1567FB4680666 in _id_A48BA5EE7FE7C64C) {
        if(_id_E24C6C7277A83762) {
          break;
        }

        if(distancesquared(ent.origin, _id_6CD1567FB4680666) < 144)
          _id_E24C6C7277A83762 = 1;
      }

      if(_id_E24C6C7277A83762)
        ent delete();
    }
  }
}

removepatchablecollision_delayed() {
  wait 5;
  _id_5C2C9D034EBE9DCD = [];
  _id_5C2C9D034EBE9DCD[0] = "tactical_cover_col";
  _id_5C2C9D034EBE9DCD[1] = "tactical_ladder_col";
  _id_5C2C9D034EBE9DCD[2] = "clip8x8x256";
  _id_5C2C9D034EBE9DCD[3] = "player8x8x256";
  _id_5C2C9D034EBE9DCD[4] = "ladderMetal264";
  _id_5C2C9D034EBE9DCD[5] = "ladderWood192";
  _id_5C2C9D034EBE9DCD[6] = "ladderMetal192";
  _id_5C2C9D034EBE9DCD[7] = "mount128";
  _id_5C2C9D034EBE9DCD[8] = "mount64";
  _id_5C2C9D034EBE9DCD[9] = "mount32";
  _id_5C2C9D034EBE9DCD[10] = "mount256";
  _id_5C2C9D034EBE9DCD[11] = "ladderWood264";
  _id_5C2C9D034EBE9DCD[12] = "nosight256x256x8";
  _id_5C2C9D034EBE9DCD[13] = "nosight128x128x8";
  _id_5C2C9D034EBE9DCD[14] = "mountCorner128";
  _id_5C2C9D034EBE9DCD[15] = "mantle256";
  _id_5C2C9D034EBE9DCD[16] = "mantle128";
  _id_5C2C9D034EBE9DCD[17] = "mantle64";
  _id_5C2C9D034EBE9DCD[18] = "mantle32";
  _id_5C2C9D034EBE9DCD[19] = "stairsHalfFlight128";
  _id_5C2C9D034EBE9DCD[20] = "stairsFullFlight128";

  foreach(name in _id_5C2C9D034EBE9DCD)
  scripts\cp_mp\utility\game_utility::removematchingents_bykey(name, "targetname");
}

onjoinedteam(player) {}

debug_setupmatchdata() {
  level._id_6121D66FFC5B8EC9 = [];
  level._id_6121D66FFC5B8EC9["axis"] = "gw_fob_axisHQ";
  level._id_6121D66FFC5B8EC9["allies"] = "gw_fob_alliesHQ";
}

setupwaypointicons() {
  while(!isDefined(game["killstreakTable"]))
    waitframe();

  foreach(_id_DFBD7318EF3CC9BD, data in game["killstreakTable"].tabledatabyref) {
    level.waypointcolors[_id_DFBD7318EF3CC9BD + "_incoming"] = "neutral";
    level.waypointbgtype[_id_DFBD7318EF3CC9BD + "_incoming"] = 1;
    level.waypointstring[_id_DFBD7318EF3CC9BD + "_incoming"] = "";
    level.waypointshader[_id_DFBD7318EF3CC9BD + "_incoming"] = data.hudicon;
    level.waypointpulses[_id_DFBD7318EF3CC9BD + "_incoming"] = 0;
    level.waypointcolors[_id_DFBD7318EF3CC9BD] = "neutral";
    level.waypointbgtype[_id_DFBD7318EF3CC9BD] = 1;
    level.waypointstring[_id_DFBD7318EF3CC9BD] = "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS";
    level.waypointshader[_id_DFBD7318EF3CC9BD] = data.hudicon;
  }
}

setuphqs() {
  level.gw_objstruct = spawnStruct();
  level.gw_objstruct.axishqloc = spawnStruct();
  level.gw_objstruct.axishqloc.trigger = scripts\cp_mp\utility\game_utility::getlocaleent(level._id_6121D66FFC5B8EC9["axis"]);

  if(!isDefined(level.gw_objstruct.axishqloc)) {}

  level.gw_objstruct.allieshqloc = spawnStruct();
  level.gw_objstruct.allieshqloc.trigger = scripts\cp_mp\utility\game_utility::getlocaleent(level._id_6121D66FFC5B8EC9["allies"]);

  if(!isDefined(level.gw_objstruct.allieshqloc))
    return;
}

_id_84FFED4EC1563259(_id_AA030029A5B16AE5) {
  level.spawnareas = [];

  foreach(_id_F90358454413407F in level.teamnamelist)
  level.spawnareas[_id_F90358454413407F] = [level._id_6121D66FFC5B8EC9[_id_F90358454413407F]];

  scripts\mp\spawnselection::setspawnlocations(level.spawnareas["axis"], "axis");
  scripts\mp\spawnselection::setspawnlocations(level.spawnareas["allies"], "allies");

  while(!isDefined(level.spawnselectionlocations))
    waitframe();

  waitframe();

  if(isDefined(level.spawnselectionlocations[level._id_6121D66FFC5B8EC9["axis"]]["axis"].anchorentity))
    level.spawnselectionlocations[level._id_6121D66FFC5B8EC9["axis"]]["axis"].anchorentity.origin = level.gw_objstruct.axishqloc.trigger.origin;

  if(isDefined(level.spawnselectionlocations[level._id_6121D66FFC5B8EC9["allies"]]["allies"].anchorentity))
    level.spawnselectionlocations[level._id_6121D66FFC5B8EC9["allies"]]["allies"].anchorentity.origin = level.gw_objstruct.allieshqloc.trigger.origin;

  level thread objective_manageobjectivesintrovisibility();
}

objective_manageobjectivesintrovisibility() {
  wait 1;
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.gw_objstruct.axishqloc.marker.objidnum);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.gw_objstruct.allieshqloc.marker.objidnum);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.gw_objstruct.axishqloc.enemymarker.objidnum);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.gw_objstruct.allieshqloc.enemymarker.objidnum);

  if(isDefined(level.rallypointvehicles)) {
    foreach(rallypoint in level.rallypointvehicles)
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(rallypoint.marker.objidnum);
  }

  while(!scripts\mp\flags::gameflag("prematch_done"))
    waitframe();

  scripts\mp\objidpoolmanager::objective_teammask_addtomask(level.gw_objstruct.axishqloc.marker.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(level.gw_objstruct.allieshqloc.marker.objidnum, "allies");

  if(isDefined(level.rallypointvehicles)) {
    foreach(rallypoint in level.rallypointvehicles) {
      if(isDefined(rallypoint))
        scripts\mp\objidpoolmanager::objective_teammask_addtomask(rallypoint.marker.objidnum, rallypoint.team);
    }
  }
}

hackfixcameras() {
  if(istrue(level.usestaticspawnselectioncamera)) {
    return;
  }
  while(!istrue(level._id_1091B5D43BA7A905))
    waitframe();

  team = "allies";
  forward = level.spawnselectionteamforward[team];

  if(istrue(level.usespawnselection))
    keys = ["gw_fob_alliesHQ", "_d", "_e", "_f"];
  else
    keys = ["default"];

  scripts\mp\spawncamera::_id_71A2A6A6F52AB30B(keys, team, forward, -8500, 7000);
  team = "axis";
  forward = level.spawnselectionteamforward[team];

  if(istrue(level.usespawnselection))
    keys = ["gw_fob_axisHQ", "_a", "_b", "_c"];
  else
    keys = ["default"];

  scripts\mp\spawncamera::_id_71A2A6A6F52AB30B(keys, team, forward, -8500, 7000);
}

sethqmarkerobjective() {
  _id_7D3CF95BDBCA0939 = "any";
  origin = level.gw_objstruct.axishqloc.trigger.origin;
  marker = scripts\mp\gameobjects::createobjidobject(origin, "neutral", (0, 0, 0), undefined, _id_7D3CF95BDBCA0939, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(marker.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(marker.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_set_play_intro(marker.objidnum, 0);
  marker.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(marker.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(marker.objidnum, "icon_waypoint_hq_friendly");
  scripts\mp\objidpoolmanager::update_objective_setbackground(marker.objidnum, 6);
  marker.lockupdatingicons = 1;
  level.gw_objstruct.axishqloc.marker = marker;
  level.uncapturableobjectives[level.uncapturableobjectives.size] = marker;
  marker = scripts\mp\gameobjects::createobjidobject(origin, "neutral", (0, 0, 0), undefined, _id_7D3CF95BDBCA0939, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(marker.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(marker.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_set_play_intro(marker.objidnum, 0);
  marker.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(marker.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(marker.objidnum, "icon_waypoint_hq_enemy");
  scripts\mp\objidpoolmanager::update_objective_setbackground(marker.objidnum, 7);
  marker.lockupdatingicons = 1;
  level.gw_objstruct.axishqloc.enemymarker = marker;
  level.uncapturableobjectives[level.uncapturableobjectives.size] = marker;
  origin = level.gw_objstruct.allieshqloc.trigger.origin;
  marker = scripts\mp\gameobjects::createobjidobject(origin, "neutral", (0, 0, 0), undefined, _id_7D3CF95BDBCA0939, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(marker.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(marker.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_set_play_intro(marker.objidnum, 0);
  marker.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(marker.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(marker.objidnum, "icon_waypoint_hq_friendly");
  scripts\mp\objidpoolmanager::update_objective_setbackground(marker.objidnum, 6);
  marker.lockupdatingicons = 1;
  level.gw_objstruct.allieshqloc.marker = marker;
  level.uncapturableobjectives[level.uncapturableobjectives.size] = marker;
  marker = scripts\mp\gameobjects::createobjidobject(origin, "neutral", (0, 0, 0), undefined, _id_7D3CF95BDBCA0939, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(marker.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(marker.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_set_play_intro(marker.objidnum, 0);
  marker.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(marker.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(marker.objidnum, "icon_waypoint_hq_enemy");
  scripts\mp\objidpoolmanager::update_objective_setbackground(marker.objidnum, 7);
  marker.lockupdatingicons = 1;
  level.gw_objstruct.allieshqloc.enemymarker = marker;
  level.uncapturableobjectives[level.uncapturableobjectives.size] = marker;
  level.spawnselectionteamforward = [];
  level.spawnselectionteamforward["allies"] = vectorNormalize(level.gw_objstruct.axishqloc.trigger.origin - level.gw_objstruct.allieshqloc.trigger.origin);
  level.spawnselectionteamforward["axis"] = vectorNormalize(level.gw_objstruct.allieshqloc.trigger.origin - level.gw_objstruct.axishqloc.trigger.origin);
}

dropcrate(_id_D8061F26B5ECA018, _id_76A22C18960F72AF, team) {
  crate = scripts\cp_mp\killstreaks\airdrop::_id_99CC30EA8BE5B2A6(team, _id_D8061F26B5ECA018, _id_76A22C18960F72AF.origin, (0, randomint(360), 0), undefined);
  return crate;
}

docratedropsmoke(crate, _id_76A22C18960F72AF, duration) {
  _id_E0D03A39E88DFF15 = _id_76A22C18960F72AF + (0, 0, 2000);
  spawnpos = scripts\common\utility::groundpos(_id_E0D03A39E88DFF15, (0, 0, 1));
  vfxent = spawn("script_model", spawnpos);
  vfxent setModel("tag_origin");
  vfxent.angles = (0, 0, 0);
  vfxent playLoopSound("smoke_carepackage_smoke_lp");
  wait 1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_gr"), vfxent, "tag_origin");

  if(isDefined(crate))
    crate scripts\engine\utility::waittill_any_timeout_1(duration, "crate_dropped");
  else
    wait(duration);

  stopFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_gr"), vfxent, "tag_origin");
  vfxent delete();
}

_id_E2AD02BE26BA3879() {
  level._id_98F1F016587A9593 = [];
  _id_9577902B42FBD7F6 = scripts\engine\utility::getStructArray("carepackage_loc", "targetname");

  foreach(loc in _id_9577902B42FBD7F6) {
    struct = spawnStruct();
    struct.origin = loc.origin;
    struct.angles = loc.angles;
    struct.inuse = 0;
    struct._id_A9E5B4CD62871172 = 0;

    if(isDefined(loc.script_noteworthy) && loc.script_noteworthy == "noVehicleDrop")
      struct._id_A9E5B4CD62871172 = 1;

    level._id_98F1F016587A9593[level._id_98F1F016587A9593.size] = struct;
  }
}

_id_99FEF643D7A98BB0() {
  level endon("game_ended");
  level notify("killstreakCrateLoop");
  level endon("killstreakCrateLoop");
  level._id_CBB5FB5077BAC26D = 0;

  while(!scripts\mp\flags::gameflag("prematch_done"))
    waitframe();

  interval = getdvarint("dvar_25B96A647E40DF81", 120);
  _id_FB197850EE0F47A0 = getdvarint("dvar_4220024CBEAFAEE2", 1) == 1;

  for(;;) {
    foreach(team in level.teamnamelist) {
      scripts\mp\utility\dialog::statusdialog("carepackage_inc", team, 1);
      scripts\mp\hud_util::showsplashtoteam(team, "gwtdm_carepackage_inc");
    }

    if(!_id_FB197850EE0F47A0)
      dropkillstreakcrate();
    else {
      data = level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A];

      for(_id_6C3FC29A5FD8751A = 0; _id_6C3FC29A5FD8751A < data._id_A2D0446BC9B000AB.size; _id_6C3FC29A5FD8751A++) {
        _id_A2D0446BC9B000AB = data._id_A2D0446BC9B000AB[_id_6C3FC29A5FD8751A];

        if(level._id_048E03F24B9B5C1A < level._id_272B2716F1938412 && _id_489262584E53D09B("axis"))
          droporigin = _id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["axis"].origin;
        else if(level._id_048E03F24B9B5C1A > level._id_272B2716F1938412 && _id_489262584E53D09B("allies"))
          droporigin = _id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["allies"].origin;
        else
          droporigin = _id_A2D0446BC9B000AB.origin;

        dropkillstreakcrate(droporigin);
        wait(randomintrange(5, 8));
      }
    }

    wait(interval);
  }
}

_id_489262584E53D09B(_id_7E441F99479E9B56) {
  _id_18A3FAB290E780C2 = getteamscore("axis");
  _id_43A41488C3C487DF = getteamscore("allies");

  if(_id_7E441F99479E9B56 == "axis") {
    if(_id_18A3FAB290E780C2 * 1.3 < _id_43A41488C3C487DF)
      return 1;
  } else if(_id_7E441F99479E9B56 == "allies") {
    if(_id_43A41488C3C487DF * 1.3 < _id_18A3FAB290E780C2)
      return 1;
  }

  return 0;
}

dropkillstreakcrate(droporigin) {
  _id_C7709EA550BBB458 = undefined;

  foreach(player in level.players) {
    if(isDefined(player)) {
      _id_C7709EA550BBB458 = player;
      break;
    }
  }

  if(level._id_CBB5FB5077BAC26D >= level._id_AADF4E234F763771) {
    return;
  }
  location = choosecratelocation(droporigin);

  if(isDefined(location))
    thread runkillstreakreward(location, _id_C7709EA550BBB458);
}

choosecratelocation(droporigin) {
  if(isDefined(droporigin))
    _id_92459AE9B006B9F7 = droporigin;
  else {
    _id_695A8B6F4AAEEEE6 = randomfloatrange(0, 1.0);

    if(level._id_048E03F24B9B5C1A < level._id_272B2716F1938412 && _id_489262584E53D09B("axis")) {
      _id_B027D6857AB9D713 = level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_A2D0446BC9B000AB[0]._id_E59F791D76C7BEEE["axis"].origin;
      _id_64517C7A808446BD = level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_A2D0446BC9B000AB.size;
      _id_014E33FB843CA741 = level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_A2D0446BC9B000AB[_id_64517C7A808446BD]._id_E59F791D76C7BEEE["axis"].origin;
    } else if(level._id_048E03F24B9B5C1A > level._id_272B2716F1938412 && _id_489262584E53D09B("allies")) {
      _id_B027D6857AB9D713 = level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_A2D0446BC9B000AB[0]._id_E59F791D76C7BEEE["allies"].origin;
      _id_64517C7A808446BD = level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_A2D0446BC9B000AB.size;
      _id_014E33FB843CA741 = level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_A2D0446BC9B000AB[_id_64517C7A808446BD]._id_E59F791D76C7BEEE["allies"].origin;
    } else {
      _id_B027D6857AB9D713 = level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_B027D6857AB9D713;
      _id_014E33FB843CA741 = level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_014E33FB843CA741;
    }

    _id_92459AE9B006B9F7 = vectorlerp(_id_B027D6857AB9D713, _id_014E33FB843CA741, _id_695A8B6F4AAEEEE6);
  }

  trace = scripts\engine\trace::ray_trace(_id_92459AE9B006B9F7, _id_92459AE9B006B9F7 - (0, 0, 100000));
  _id_92459AE9B006B9F7 = trace["position"];
  _id_794937A10118F0D9 = findclosestdroplocation(_id_92459AE9B006B9F7);

  if(0) {
    thread scripts\mp\utility\debug::drawline(level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_B027D6857AB9D713, level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_014E33FB843CA741, 1000, (0, 1, 1));
    thread scripts\mp\utility\debug::drawsphere(_id_92459AE9B006B9F7, 100, 1000, (1, 0, 0));
    thread scripts\mp\utility\debug::drawsphere(_id_794937A10118F0D9.origin, 100, 1000, (0, 1, 0));
    thread scripts\mp\utility\debug::drawline(_id_92459AE9B006B9F7, _id_794937A10118F0D9.origin, 1000, (0, 1, 0));
  }

  return _id_794937A10118F0D9;
}

findclosestdroplocation(origin, _id_8A1EC1E50582C07A) {
  startlocation = spawnStruct();
  startlocation.origin = origin;
  _id_DC469C4AF66C5CC3 = startlocation scripts\engine\utility::array_sort_with_func(level._id_98F1F016587A9593, ::_id_C271E4000367648F);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_DC469C4AF66C5CC3.size; _id_AC0E594AC96AA3A8++) {
    loc = _id_DC469C4AF66C5CC3[_id_AC0E594AC96AA3A8];

    if(loc.inuse) {
      continue;
    }
    if(istrue(_id_8A1EC1E50582C07A) && istrue(loc._id_A9E5B4CD62871172)) {
      continue;
    }
    loc.inuse = 1;
    return loc;
  }

  return undefined;
}

_id_C271E4000367648F(_id_0FCF7E6E6D8C4861, _id_0FCF7B6E6D8C41C8) {
  return distance2dsquared(_id_0FCF7E6E6D8C4861.origin, self.origin) < distance2dsquared(_id_0FCF7B6E6D8C41C8.origin, self.origin);
}

runkillstreakreward(location, _id_58E8D1412BC688CD) {
  level endon("game_ended");
  streakname = scripts\cp_mp\killstreaks\airdrop::_id_5D1369BFC4EFD8B7(_id_58E8D1412BC688CD.team);
  crate = undefined;
  object = scripts\mp\gameobjects::createobjidobject(location.origin, "neutral", (0, 0, 72), undefined, "any");
  object.origin = location.origin;
  thread docratedropsmoke(undefined, location.origin, 16);
  object.iconname = "_incoming";
  object.lockupdatingicons = 0;
  object scripts\mp\gameobjects::setobjectivestatusicons("carepackage");
  scripts\mp\objidpoolmanager::update_objective_setbackground(object.objidnum, 8);
  object.lockupdatingicons = 1;
  waittime = getdvarint("dvar_41F80710E72EB107", 5);
  wait(waittime);
  crate = scripts\cp_mp\killstreaks\airdrop::_id_99CC30EA8BE5B2A6(_id_58E8D1412BC688CD.team, streakname, location.origin, (0, randomint(360), 0), undefined);

  if(!isDefined(crate)) {
    object scripts\mp\gameobjects::setvisibleteam("none");
    object scripts\mp\gameobjects::releaseid();
    object.visibleteam = "none";
    location.inuse = 0;
    return;
  }

  crate.skipminimapicon = 1;
  crate.nevertimeout = 0;
  crate.waitforobjectiveactivate = 1;
  crate.killminimapicon = 0;
  crate.disallowheadiconid = 1;
  crate.isarmcrate = 1;
  level._id_CBB5FB5077BAC26D = level._id_CBB5FB5077BAC26D + 1;
  usetime = getdvarfloat("dvar_D25321C867CF3A80", 10.0);
  crate.usetimeoverride = usetime;
  crate waittill("crate_dropped");

  if(!isDefined(crate)) {
    object scripts\mp\gameobjects::setvisibleteam("none");
    object scripts\mp\gameobjects::releaseid();
    object.visibleteam = "none";
    location.inuse = 0;
    return;
  }

  object.useobj = crate;
  object.origin = crate.origin;
  crate notify("objective_activate");
  scripts\mp\objidpoolmanager::update_objective_onentity(object.objidnum, crate);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(object.objidnum, 72);
  object.iconname = "";
  object.lockupdatingicons = 0;
  object scripts\mp\gameobjects::setobjectivestatusicons("carepackage");
  object.lockupdatingicons = 1;
  scripts\mp\objidpoolmanager::update_objective_setbackground(object.objidnum, 8);
  objective_setlabel(object.objidnum, "");
  crate waittill("death");
  level._id_CBB5FB5077BAC26D = level._id_CBB5FB5077BAC26D - 1;
  object scripts\mp\gameobjects::setvisibleteam("none");
  object scripts\mp\gameobjects::releaseid();
  object.visibleteam = "none";
  location.inuse = 0;
}

initspawns() {
  level.gamemodestartspawnpointnames = [];

  if(scripts\mp\spawnselection::_id_167619FE3D0CFF00()) {
    _id_48501209A3E177A7 = "mp_gw_spawn_allies_start";
    _id_AE7D0107AD485428 = "mp_gw_spawn_axis_start";
    level.gamemodestartspawnpointnames["allies"] = _id_48501209A3E177A7;
    level.gamemodestartspawnpointnames["axis"] = _id_AE7D0107AD485428;
    level.gamemodespawnpointnames = [];
    level.gamemodespawnpointnames["allies"] = "mp_tdm_spawn";
    level.gamemodespawnpointnames["axis"] = "mp_tdm_spawn";
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);

    if(scripts\cp_mp\utility\game_utility::getmapname() == "mp_aniyah")
      scripts\mp\spawnlogic::setactivespawnlogic("GroundWarTTLOS", "Crit_Default");
    else if(scripts\cp_mp\utility\game_utility::islargemap())
      scripts\mp\spawnlogic::setactivespawnlogic("GroundWar", "Crit_Default");
    else
      scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");

    scripts\mp\spawnlogic::addstartspawnpoints(_id_48501209A3E177A7);
    scripts\mp\spawnlogic::addstartspawnpoints(_id_AE7D0107AD485428);
    scripts\mp\spawnlogic::addspawnpoints("allies", _id_48501209A3E177A7);
    scripts\mp\spawnlogic::addspawnpoints("axis", _id_AE7D0107AD485428);
    _id_99DF7CA30AD2726D = scripts\mp\spawnlogic::getspawnpointarray(_id_48501209A3E177A7);
    _id_C8D44E8665F9D370 = scripts\mp\spawnlogic::getspawnpointarray(_id_AE7D0107AD485428);
    scripts\mp\spawnlogic::registerspawnset("start_allies", _id_99DF7CA30AD2726D);
    scripts\mp\spawnlogic::registerspawnset("start_axis", _id_C8D44E8665F9D370);
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
    _id_29D9D2428185616D = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
    _id_3A5288F40C8BE099 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
    scripts\mp\spawnlogic::registerspawnset("normal", _id_29D9D2428185616D);
    scripts\mp\spawnlogic::registerspawnset("fallback", _id_3A5288F40C8BE099);
    level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
    level.spawnpoints = _id_29D9D2428185616D;
  } else if(level._id_03FBBC6279594DDF) {
    level.modespawnclient = ::modespawn;
    level.modeplayerkilledspawn = ::playerkilledspawn;
    level.parachutedeploydelay = getdvarfloat("dvar_922022EA1FCAA09A", 1.5);
  } else {
    _id_48501209A3E177A7 = "mp_gw_spawn_allies_start";
    _id_AE7D0107AD485428 = "mp_gw_spawn_axis_start";
    _id_600A07D6F7838F5E = "mp_tdm_spawn";
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    level._id_2AD659EDB860AB3A = [];
    level._id_2AD659EDB860AB3A["allies"] = "start_allies";
    level._id_2AD659EDB860AB3A["axis"] = "start_axis";
    level._id_AD9CAE795E7505C6 = [];
    level._id_AD9CAE795E7505C6["allies"] = "normal_allies";
    level._id_AD9CAE795E7505C6["axis"] = "normal_axis";
    scripts\mp\spawnlogic::addstartspawnpoints(_id_48501209A3E177A7);
    scripts\mp\spawnlogic::addstartspawnpoints(_id_AE7D0107AD485428);
    scripts\mp\spawnlogic::addspawnpoints("allies", _id_48501209A3E177A7);
    scripts\mp\spawnlogic::addspawnpoints("axis", _id_AE7D0107AD485428);
    _id_99DF7CA30AD2726D = scripts\mp\spawnlogic::getspawnpointarray(_id_48501209A3E177A7);
    _id_C8D44E8665F9D370 = scripts\mp\spawnlogic::getspawnpointarray(_id_AE7D0107AD485428);
    scripts\mp\spawnlogic::registerspawnset("start_allies", _id_99DF7CA30AD2726D);
    scripts\mp\spawnlogic::registerspawnset("start_axis", _id_C8D44E8665F9D370);
    scripts\mp\spawnlogic::addspawnpoints("allies", _id_600A07D6F7838F5E);
    scripts\mp\spawnlogic::addspawnpoints("axis", _id_600A07D6F7838F5E);
    _id_29D9D2428185616D = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
    _id_5CE0AF20B7B092CF = [];
    _id_3D051A5C0F38B5C4 = [];

    foreach(s in _id_29D9D2428185616D) {
      if(s.target == "axis") {
        _id_3D051A5C0F38B5C4[_id_3D051A5C0F38B5C4.size] = s;
        continue;
      }

      if(s.target == "allies") {
        _id_5CE0AF20B7B092CF[_id_5CE0AF20B7B092CF.size] = s;
        continue;
      }

      targets = scripts\engine\utility::getStructArray(s.target, "targetname");

      if(targets.size > 0) {
        continue;
      }
      fwd = anglesToForward(s.angles);
      _id_16F22C33F4D4D6DB = level.gw_objstruct.axishqloc.trigger.origin;
      _id_24D6579A0CB7B871 = vectorNormalize(_id_16F22C33F4D4D6DB - s.origin);
      _id_0FD83D4343D52E27 = vectordot(fwd, _id_24D6579A0CB7B871);
      _id_2780B1A6E44F11A0 = level.gw_objstruct.allieshqloc.trigger.origin;
      _id_8668B71CDF65A836 = vectorNormalize(_id_2780B1A6E44F11A0 - s.origin);
      _id_F33BF607ED56B2DE = vectordot(fwd, _id_8668B71CDF65A836);

      if(_id_0FD83D4343D52E27 > _id_F33BF607ED56B2DE)
        _id_5CE0AF20B7B092CF[_id_5CE0AF20B7B092CF.size] = s;
      else
        _id_3D051A5C0F38B5C4[_id_3D051A5C0F38B5C4.size] = s;
    }

    scripts\mp\spawnlogic::registerspawnset("normal_allies", _id_5CE0AF20B7B092CF);
    scripts\mp\spawnlogic::registerspawnset("normal_axis", _id_3D051A5C0F38B5C4);
    level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
  }

  level thread _id_E02A492A4A229F7E();
}

_id_E02A492A4A229F7E() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  _id_15F70B9B7E9402E3 = getdvarint("dvar_54449FE780DDB32F", 3000);
  scripts\engine\utility::flag_wait("frontline_data_init");

  for(key = 0; key < level._id_33809C8A29CA064E.size; key++) {
    data = level._id_33809C8A29CA064E[key];

    for(_id_6C3FC29A5FD8751A = 0; _id_6C3FC29A5FD8751A < data._id_A2D0446BC9B000AB.size; _id_6C3FC29A5FD8751A++) {
      _id_A2D0446BC9B000AB = data._id_A2D0446BC9B000AB[_id_6C3FC29A5FD8751A];
      _id_A2D0446BC9B000AB.redeployspawn = [];

      foreach(team in level.teamnamelist) {
        spawnpoint = spawnStruct();
        groundorigin = scripts\engine\utility::drop_to_ground(_id_A2D0446BC9B000AB.origin, undefined, undefined, (0, 0, 1));
        spawnpoint.origin = groundorigin + (0, 0, 1) * _id_15F70B9B7E9402E3;
        spawnpoint.angles = vectortoangles(level.spawnselectionteamforward[team]);
        spawnpoint.time = gettime();
        spawnpoint.index = -1;
        _id_A2D0446BC9B000AB.redeployspawn[team] = spawnpoint;
      }
    }
  }
}

generatespawnpoint() {
  _id_6C3FC29A5FD8751A = randomint(level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_A2D0446BC9B000AB.size);
  spawnpoint = _id_0277456E766F73B0(self.team, _id_6C3FC29A5FD8751A);
  _id_47AD41A1A8A19410 = getdvarint("dvar_05F04F6BEF3A9BE7", 512);
  self.redeployspawn.origin = (spawnpoint.origin[0] + randomfloatrange(_id_47AD41A1A8A19410 * -1, _id_47AD41A1A8A19410), spawnpoint.origin[1] + randomfloatrange(_id_47AD41A1A8A19410 * -1, _id_47AD41A1A8A19410), spawnpoint.origin[2]);
  self.redeployspawn.angles = spawnpoint.angles;
  self.redeployspawn.time = gettime();
  self.redeployspawn.team = self.team;
  self.redeployspawn.index = -1;
  self.redeployspawn.lifeid = self.lifeid;
  self.redeployspawn._id_6C3FC29A5FD8751A = _id_6C3FC29A5FD8751A;
  return self.redeployspawn;
}

_id_0277456E766F73B0(team, _id_6C3FC29A5FD8751A) {
  _id_77DBB639C4BA0C18 = level._id_048E03F24B9B5C1A + 1;

  if(team == "axis")
    _id_77DBB639C4BA0C18 = level._id_048E03F24B9B5C1A - 1;

  if(_id_77DBB639C4BA0C18 == level._id_33809C8A29CA064E.size) {
    if(!isDefined(level.gw_objstruct._id_333EFBBE6BCCA949)) {
      _id_15F70B9B7E9402E3 = getdvarint("dvar_54449FE780DDB32F", 3000);
      spawnpoint = spawnStruct();
      groundorigin = scripts\engine\utility::drop_to_ground(level.gw_objstruct.allieshqloc.trigger.origin, undefined, undefined, (0, 0, 1));
      spawnpoint.origin = groundorigin + (0, 0, 1) * _id_15F70B9B7E9402E3;
      spawnpoint.angles = vectortoangles(level.spawnselectionteamforward[team]);
      spawnpoint.time = gettime();
      spawnpoint.index = -1;
      level.gw_objstruct._id_333EFBBE6BCCA949 = spawnpoint;
    }

    return level.gw_objstruct._id_333EFBBE6BCCA949;
  } else if(_id_77DBB639C4BA0C18 < 0) {
    if(!isDefined(level.gw_objstruct._id_96832145B9161A04)) {
      _id_15F70B9B7E9402E3 = getdvarint("dvar_54449FE780DDB32F", 3000);
      spawnpoint = spawnStruct();
      groundorigin = scripts\engine\utility::drop_to_ground(level.gw_objstruct.axishqloc.trigger.origin, undefined, undefined, (0, 0, 1));
      spawnpoint.origin = groundorigin + (0, 0, 1) * _id_15F70B9B7E9402E3;
      spawnpoint.angles = vectortoangles(level.spawnselectionteamforward[team]);
      spawnpoint.time = gettime();
      spawnpoint.index = -1;
      level.gw_objstruct._id_96832145B9161A04 = spawnpoint;
    }

    return level.gw_objstruct._id_96832145B9161A04;
  }

  _id_77DBB639C4BA0C18 = int(clamp(_id_77DBB639C4BA0C18, 0, level._id_33809C8A29CA064E.size - 1));

  if(!isDefined(_id_6C3FC29A5FD8751A))
    _id_6C3FC29A5FD8751A = randomint(level._id_33809C8A29CA064E[_id_77DBB639C4BA0C18]._id_A2D0446BC9B000AB.size);

  current = level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_A2D0446BC9B000AB[_id_6C3FC29A5FD8751A].origin;
  _id_81791941B34CCBF7 = level._id_33809C8A29CA064E[_id_77DBB639C4BA0C18]._id_A2D0446BC9B000AB[_id_6C3FC29A5FD8751A].origin;
  _id_06AC38DAC8E6CC00 = vectorNormalize(_id_81791941B34CCBF7 - current);
  offset = getdvarint("dvar_082BCE2FB4193E57", 8000);
  _id_A0811053C6C53A98 = current + _id_06AC38DAC8E6CC00 * offset;
  _id_651BAE59B8C2E46C = undefined;
  _id_42CA41C7DADAE0C0 = undefined;

  foreach(_id_E9BF3955FA1125B5, _id_33809C8A29CA064E in level._id_33809C8A29CA064E) {
    dist = distance2dsquared(_id_A0811053C6C53A98, _id_33809C8A29CA064E._id_A2D0446BC9B000AB[_id_6C3FC29A5FD8751A].origin);

    if(!isDefined(_id_42CA41C7DADAE0C0) || dist < _id_42CA41C7DADAE0C0) {
      _id_651BAE59B8C2E46C = _id_E9BF3955FA1125B5;
      _id_42CA41C7DADAE0C0 = dist;
    }
  }

  return level._id_33809C8A29CA064E[_id_651BAE59B8C2E46C]._id_A2D0446BC9B000AB[_id_6C3FC29A5FD8751A].redeployspawn[team];
}

modespawn(_id_9156B53BCF7CE573) {
  thread playerrespawn();
  return 1;
}

playerkilledspawn(_id_642470E1ABC1BBF9, _id_8B3F6477DBED24D7) {
  _id_642470E1ABC1BBF9.victim thread playerrespawn();
  return 1;
}

playerrespawn() {
  level endon("game_ended");
  self endon("disconnect");

  if(istrue(level.gameended)) {
    return;
  }
  scripts\mp\playerlogic::waitforremoteend();
  spawnpoint = getspawnpoint();
  _id_C4E660D969DCEEE5 = vectorNormalize(level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_A2D0446BC9B000AB[spawnpoint._id_6C3FC29A5FD8751A].origin - spawnpoint.origin);
  spawnpoint.angles = vectortoangles(_id_C4E660D969DCEEE5);
  timeoutms = getdvarint("dvar_EEB59CEE28A5EAB7", 3000);
  _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint, timeoutms);

  if(scripts\mp\flags::gameflag("prematch_done")) {
    _id_AD4DD16F29E24B77 = 0.0;
    _id_DFAB0807D83A77FE = 0.5;
    thread scripts\mp\playerlogic::managerespawnfade(_id_AD4DD16F29E24B77, _id_DFAB0807D83A77FE);

    if(_id_AD4DD16F29E24B77 > 0)
      self waittill("fadeDown_complete");
  }

  _id_6489FCDFE6FA2E36::playerclearspectatekillchainsystem();
  _id_1E4A61DB11011446::spawnintermission(spawnpoint.origin, spawnpoint.angles);
  scripts\mp\spectating::setdisabled();
  _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete();
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  _id_67708F418B1FAC79::gulagwinnerrespawn(1, undefined, spawnpoint, 1, _id_11F3B4465C8B637B, undefined, undefined, 0, 0, 1);
  scripts\mp\damage::resetplayervariables();
  scripts\mp\damage::resetplayeromnvarsonspawn();
}

getspawnpoint() {
  if(istrue(level._id_03FBBC6279594DDF)) {
    if(!isDefined(self.redeployspawn)) {
      self.redeployspawn = spawnStruct();
      return generatespawnpoint();
    }

    if(isDefined(self.setspawnpoint))
      return self.setspawnpoint;
    else if(self.redeployspawn.lifeid != self.lifeid)
      return generatespawnpoint();

    return self.redeployspawn;
  } else {
    spawnteam = self.pers["team"];
    _id_31FF7305890A6EF2 = getdvarint("dvar_A66B78681B2D0805", 4096);
    _id_629E5FE2F6B337FA = [];
    _id_629E5FE2F6B337FA["teamForward"] = level.spawnselectionteamforward[spawnteam];
    _id_629E5FE2F6B337FA["idealDistSq"] = _id_31FF7305890A6EF2 * _id_31FF7305890A6EF2;

    if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
      scripts\mp\spawnlogic::setactivespawnlogic("StartSpawn", "Crit_Default");
      scripts\mp\spawnlogic::activatespawnset(level._id_2AD659EDB860AB3A[spawnteam], 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, level._id_2AD659EDB860AB3A[spawnteam], undefined, undefined, _id_629E5FE2F6B337FA);
    } else {
      scripts\mp\spawnlogic::setactivespawnlogic("Invasion", "Crit_Frontline");
      scripts\mp\spawnlogic::activatespawnset(level._id_AD9CAE795E7505C6[spawnteam], 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, level._id_AD9CAE795E7505C6[spawnteam], undefined, undefined, _id_629E5FE2F6B337FA);
    }

    return spawnpoint;
  }
}

_id_BD61217120C57971() {
  self endon("death_or_disconnect");
  _id_A2B13B5AE4CB7698 = level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A].origin;
  _id_31FF7305890A6EF2 = getdvarint("dvar_A66B78681B2D0805", 4096);
  _id_3B29F5840BE404C8 = _id_A2B13B5AE4CB7698;

  if(self.team == "axis")
    _id_3B29F5840BE404C8 = level.gw_objstruct.axishqloc.trigger.origin;
  else
    _id_3B29F5840BE404C8 = level.gw_objstruct.allieshqloc.trigger.origin;

  _id_F069BBF68802037B = vectorNormalize(_id_3B29F5840BE404C8 - _id_A2B13B5AE4CB7698);
  _id_11F3B4465C8B637B = _id_A2B13B5AE4CB7698 + _id_F069BBF68802037B * _id_31FF7305890A6EF2;
  _id_11F3B4465C8B637B = scripts\common\utility::groundpos(_id_11F3B4465C8B637B, (0, 0, 1));
  _id_2CEDCC356F1B9FC8::playerstreamhintlocation(_id_11F3B4465C8B637B);
}

_id_8964B48E4EBA5797(origin) {
  closestpoint = pointonsegmentnearesttopoint(level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_B027D6857AB9D713, level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_014E33FB843CA741, origin);
  return closestpoint;
}

_id_99146672EC896EFA(origin) {
  closestpoint = pointonsegmentnearesttopoint(level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_B027D6857AB9D713, level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_014E33FB843CA741, origin);
  _id_F6F8270F02B2B9BF = distance2dsquared(closestpoint, origin);
  return _id_F6F8270F02B2B9BF;
}

_id_7855EB28C2D21061(origin, team) {
  if(!isDefined(level._id_48549F359A11F105))
    level._id_48549F359A11F105 = [];

  if(!isDefined(level._id_48549F359A11F105[team]))
    level._id_48549F359A11F105[team] = spawnStruct();

  if(!isDefined(level._id_48549F359A11F105[team].timestamp) || level._id_48549F359A11F105[team].timestamp < gettime()) {
    level._id_48549F359A11F105[team].timestamp = gettime();
    level._id_48549F359A11F105[team]._id_813A0B907262A1C2 = [];

    foreach(_id_6C3FC29A5FD8751A, _id_A2D0446BC9B000AB in level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_A2D0446BC9B000AB)
    level._id_48549F359A11F105[team]._id_813A0B907262A1C2[_id_6C3FC29A5FD8751A] = 0;

    _id_54216530F9ADE838 = scripts\mp\utility\teams::getfriendlyplayers(team, 1);

    foreach(player in _id_54216530F9ADE838) {
      _id_74340F80A8FF4462 = undefined;
      _id_E61F33A1EC31A630 = undefined;

      foreach(_id_6C3FC29A5FD8751A, _id_A2D0446BC9B000AB in level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_A2D0446BC9B000AB) {
        _id_26D8A238BE314CF9 = distance2dsquared(player.origin, _id_A2D0446BC9B000AB.origin);

        if(!isDefined(_id_74340F80A8FF4462) || _id_26D8A238BE314CF9 < _id_E61F33A1EC31A630) {
          _id_74340F80A8FF4462 = _id_6C3FC29A5FD8751A;
          _id_E61F33A1EC31A630 = _id_26D8A238BE314CF9;
        }
      }

      level._id_48549F359A11F105[team]._id_813A0B907262A1C2[_id_74340F80A8FF4462]++;
    }
  }

  _id_53F513E3A2D22D55 = undefined;
  _id_4D6BD6D4C0E080B6 = undefined;

  foreach(key, _id_D12A341B40354143 in level._id_48549F359A11F105[team]._id_813A0B907262A1C2) {
    if(!isDefined(_id_53F513E3A2D22D55) || _id_D12A341B40354143 < _id_4D6BD6D4C0E080B6) {
      _id_53F513E3A2D22D55 = key;
      _id_4D6BD6D4C0E080B6 = _id_D12A341B40354143;
    }
  }

  _id_F6F8270F02B2B9BF = distance2dsquared(level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_A2D0446BC9B000AB[_id_53F513E3A2D22D55].origin, origin);
  return _id_F6F8270F02B2B9BF;
}

onspawnplayer(_id_9156B53BCF7CE573) {
  self.forcespawnnearteammates = undefined;
  thread updatematchstatushintonspawn();
  _id_03F1B6713CA4C9C7::_id_6DA8B65579348D0B();
  _id_76CC264B397DB9CB::updatesquadomnvars(self.team, self._id_0FF97225579DE16A);

  if(level.spawnprotectiontimer > 0) {
    thread removespawnprotectiononnotify();
    thread removespawnprotectiononads();
  }
}

removespawnprotectiononnotify() {
  self endon("death_or_disconnect");
  self endon("remove_spawn_protection");
  scripts\engine\utility::waittill_any_3("parachute_landed", "vehicle_enter", "weapon_fired");
  _id_0FD32F08E72B657F::removespawnprotection();
}

removespawnprotectiononads() {
  self endon("death_or_disconnect");
  self endon("remove_spawn_protection");

  while(self playerads() < 0.7)
    waitframe();

  _id_0FD32F08E72B657F::removespawnprotection();
}

updatematchstatushintonspawn() {
  level endon("game_ended");
  scripts\mp\hud_message::_id_F004EF4606B9EFDC("push_frontline");
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  _id_76CC264B397DB9CB::updatesquadomnvars(self.team, self._id_0FF97225579DE16A);

  if(level.dropbrloot) {
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
    dropstruct._id_DFBA5A2C3C6F0A07 = 14;
    _id_7E52B56769FA7774::dropbrhealthpack(dropstruct);
    _id_6AFF3948CF4CCA03::playerdropplunderondeath(dropstruct, attacker, 1);
  }

  thread _id_BD61217120C57971();
}

managedroppedents(_id_2C015943929AF247) {
  if(!isDefined(level.br_droppedloot))
    level.br_droppedloot = [];

  if(level.br_droppedloot.size > 64) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 16; _id_AC0E594AC96AA3A8++) {
      if(isDefined(level.br_droppedloot[_id_AC0E594AC96AA3A8])) {
        level.br_droppedloot[_id_AC0E594AC96AA3A8] delete();
        level.br_droppedloot[_id_AC0E594AC96AA3A8] = undefined;
      }
    }

    _id_50F783A5617F8940 = [];

    for(_id_AC0E594AC96AA3A8 = 16; _id_AC0E594AC96AA3A8 < level.br_droppedloot.size; _id_AC0E594AC96AA3A8++)
      _id_50F783A5617F8940[_id_AC0E594AC96AA3A8 - 16] = level.br_droppedloot[_id_AC0E594AC96AA3A8];

    level.br_droppedloot = _id_50F783A5617F8940;
  }

  foreach(ent in _id_2C015943929AF247)
  level.br_droppedloot[level.br_droppedloot.size] = ent;

  if(!isDefined(level.br_pickups.droppeditems))
    level.br_pickups.droppeditems = [];

  if(level.br_pickups.droppeditems.size > 64) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 16; _id_AC0E594AC96AA3A8++) {
      if(isDefined(level.br_pickups.droppeditems[_id_AC0E594AC96AA3A8])) {
        level.br_pickups.droppeditems[_id_AC0E594AC96AA3A8] delete();
        level.br_pickups.droppeditems[_id_AC0E594AC96AA3A8] = undefined;
      }
    }

    _id_50F783A5617F8940 = [];

    for(_id_AC0E594AC96AA3A8 = 16; _id_AC0E594AC96AA3A8 < level.br_pickups.droppeditems.size; _id_AC0E594AC96AA3A8++)
      _id_50F783A5617F8940[_id_AC0E594AC96AA3A8 - 16] = level.br_pickups.droppeditems[_id_AC0E594AC96AA3A8];

    level.br_pickups.droppeditems = _id_50F783A5617F8940;
  }
}

onplayerconnect(player) {
  if(isDefined(level.rallypointvehicles))
    thread scripts\mp\rally_point::rallypoint_showtoplayer(player);

  _id_6109158034DA3FE9 = scripts\mp\flags::gameflag("infil_will_run") && !istrue(scripts\mp\flags::gameflag("infil_started"));

  if(!level.usespawnselection && !scripts\mp\flags::gameflag("prematch_done") && !_id_6109158034DA3FE9)
    player thread manageprematchfade();

  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);
}

manageprematchfade() {
  self endon("disconnect");
  _id_AD4DD16F29E24B77 = 0.0;
  _id_DFAB0807D83A77FE = 0.5;
}

onplayerdisconnect(player) {}

getrespawndelay() {
  self.spawncameraskipthermal = 0;
  return undefined;
}

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  _id_0FD32F08E72B657F::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);

  if(getdvarint("dvar_2E405E2912DC4A44", 0) == 1)
    attacker thread scripts\mp\rank::scoreeventpopup(_func_2EF675C13CA1C4AF("stat_2C8BCBB02EC7FF9B", level.scoremod["kill"]));

  attacker scripts\mp\utility\stats::incpersstat("contribution", level.scoremod["kill"]);
  attacker scripts\mp\utility\stats::setextrascore0(attacker.pers["contribution"]);
}

initspecatatorcameras() {
  level.spectatorcameras = [];
  level.currentspectatorcamref = "cop_2";
  _id_84286554864313CB = scripts\engine\utility::getStructArray("tac_ops_map_config", "targetname");

  foreach(_id_48380029FBB1007A in _id_84286554864313CB) {
    _id_CA2C833762E5466C = _id_48380029FBB1007A.script_noteworthy;
    _id_84BD84DEB891A915 = scripts\engine\utility::getStructArray(_id_48380029FBB1007A.target, "targetname");

    foreach(_id_6A17713098332FE4 in _id_84BD84DEB891A915) {
      switch (_id_6A17713098332FE4.script_label) {
        case "to_allies_camera":
          setteammapposition(_id_CA2C833762E5466C, "allies", _id_6A17713098332FE4);
          break;
        case "to_axis_camera":
          setteammapposition(_id_CA2C833762E5466C, "axis", _id_6A17713098332FE4);
          break;
      }
    }
  }
}

setteammapposition(_id_CA2C833762E5466C, team, _id_20C18491AEB9A905) {
  if(!isDefined(level.spectatorcameras[_id_CA2C833762E5466C]))
    level.spectatorcameras[_id_CA2C833762E5466C] = [];

  level.spectatorcameras[_id_CA2C833762E5466C][team] = _id_20C18491AEB9A905;
}

applythermal() {
  self visionsetthermalforplayer("proto_apache_flir_mp");
  self thermalvisionon();
}

removethermal() {
  self thermalvisionoff();
}

startspectatorview() {
  if(scripts\mp\utility\game::isteamreviveenabled()) {
    return;
  }
  waitframe();
  scripts\mp\utility\player::updatesessionstate("spectator");
  scripts\mp\spectating::setdisabled();

  if(isDefined(self.lastdeathangles))
    self setplayerangles(self.lastdeathangles);

  wait 0.1;
  scripts\mp\utility\player::setdof_default();
  _id_26EE0F3F89450D97 = 0;
  _id_39A11613E5C11A5D = undefined;
  _id_EB381492A5DB110A = (0, 0, 0);
  zoffset = 1000;
  _id_0DEAD2082432CECC = self.origin + (0, 0, zoffset);
  _id_06788DC28320974A = self.angles;
  self.deathspectatepos = _id_0DEAD2082432CECC;
  self.deathspectateangles = _id_06788DC28320974A;
  cameraent = spawn("script_model", self getvieworigin());
  cameraent setModel("tag_origin");
  cameraent.angles = _id_06788DC28320974A;
  self.spectatorcament = cameraent;
  self.isusingtacopsmapcamera = 1;
  self cameralinkTo(cameraent, "tag_origin", 1);
  thread dohalfwayflash();
  cameraent movecameratomappos(self, _id_0DEAD2082432CECC, _id_06788DC28320974A);
}

dohalfwayflash() {
  wait 0.4;
  thread playslamzoomflash();
  applythermal();
}

endspectatorview() {
  if(!isDefined(self.spectatorcament)) {
    return;
  }
  removethermal();
  thread runslamzoomonspawn();
}

movecameratomappos(player, _id_9813182985677B23, finalangles) {
  player endon("spawned_player");
  movetime = 1.0;
  _id_CC5BC42930ABBC4F = 1.0;
  self moveTo(_id_9813182985677B23, 2.0, 1.0, 1.0);
  player playlocalsound("mp_cmd_camera_zoom_out");
  player setclienttriggeraudiozonepartialwithfade("spawn_cam", 0.5, "mix");
  self rotateTo(finalangles, 2.0, 1.0, 1.0);
  wait 1.1;
  _id_AE753108F3DFF053 = anglesToForward(finalangles) * 300;
  _id_AE753108F3DFF053 = _id_AE753108F3DFF053 * (1, 1, 0);

  if(isDefined(player) && isDefined(player.spectatorcament)) {
    self moveTo(_id_9813182985677B23 + _id_AE753108F3DFF053, 15.0, 1.0, 1.0);
    player earthquakeforplayer(0.03, 15.0, _id_9813182985677B23 + _id_AE753108F3DFF053, 1000);
  }
}

runslamzoomonspawn() {
  self waittill("spawned_player");
  targetpos = self getEye();
  targetangles = self.angles;
  scripts\mp\utility\player::updatesessionstate("spectator");
  self cameralinkTo(self.spectatorcament, "tag_origin", 1);
  self visionsetnakedforplayer("tac_ops_slamzoom", 0.2);
  self.spectatorcament moveTo(targetpos, 0.5);
  self playlocalsound("mp_cmd_camera_zoom_in");
  self clearclienttriggeraudiozone(0.5);
  self.spectatorcament rotateTo(targetangles, 0.5, 0.5);
  wait 0.5;

  if(!isDefined(self)) {
    return;
  }
  self visionsetnakedforplayer("", 0);
  thread playslamzoomflash();
  scripts\mp\utility\player::updatesessionstate("playing");
  self cameraunlink();
  self.spectatorcament delete();
}

playslamzoomflash() {
  overlay = newclienthudelem(self);
  overlay.x = 0;
  overlay.y = 0;
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.sort = 1;
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.alpha = 1;
  overlay.foreground = 1;
  overlay setshader("white", 640, 480);
  overlay fadeovertime(0.4);
  overlay.alpha = 0.0;
  wait 0.4;
  overlay destroy();
}

arm_playstatusdialog(_id_CB3339ECE72DBDEB, team) {
  soundalias = "dx_mpa_ustl_" + _id_CB3339ECE72DBDEB;
  soundalias = tolower(soundalias);
  players = undefined;

  if(team == "bothTeams") {
    _id_650728BA49299C62 = scripts\mp\utility\teams::getteamdata("axis", "players");
    _id_2005D12681400473 = scripts\mp\utility\teams::getteamdata("allies", "players");
    players = scripts\engine\utility::array_combine(_id_650728BA49299C62, _id_2005D12681400473);
  } else if(team == "axis" || team == "allies")
    players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players) {
    if(!isbot(player))
      player arm_leaderdialogonplayer_internal(soundalias, _id_CB3339ECE72DBDEB);
  }
}

arm_playstatusdialogonplayer(_id_CB3339ECE72DBDEB) {
  soundalias = "dx_mpa_ustl_announcer_" + _id_CB3339ECE72DBDEB;
  soundalias = tolower(soundalias);
  arm_leaderdialogonplayer_internal(soundalias, _id_CB3339ECE72DBDEB);
}

arm_leaderdialogonplayer_internal(soundalias, dialog) {
  if(isDefined(self.playerlastdialogstatus)) {
    time = 5000;

    if(gettime() < self.playerlastdialogstatus["time"] + time && self.playerlastdialogstatus["dialog"] == dialog) {
      return;
    }
    self.playerlastdialogstatus["time"] = gettime();
    self.playerlastdialogstatus["dialog"] = dialog;
  }

  if(soundexists(soundalias))
    self queuedialogforplayer(soundalias, dialog, 2);
}

arm_initoutofbounds() {
  level.outofboundstriggers = [];
  _id_CCFDB06748D7F326 = getEntArray("OutOfBounds", "targetname");

  foreach(trigger in _id_CCFDB06748D7F326) {
    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(trigger.script_noteworthy) && trigger.script_noteworthy == level.localeid && scripts\mp\utility\game_utility_mp::modeusesgroundwarteamoobtriggers(trigger)) {
      level.outofboundstriggers[level.outofboundstriggers.size] = trigger;
      continue;
    }

    trigger delete();
  }
}

debugprint(text) {
  if(0)
    return;
}

isobjectivecontested(gameobject) {
  if(gameobject.ownerteam == "axis")
    return gameobject.numtouching["allies"] > 0;
  else if(gameobject.ownerteam == "allies")
    return gameobject.numtouching["axis"] > 0;
}

calculateobjectivesheld(team) {
  _id_AE82E8F18CA8E0FE = 0;

  foreach(objective in level.objectives) {
    if(objective.ownerteam == team)
      _id_AE82E8F18CA8E0FE++;
  }

  return _id_AE82E8F18CA8E0FE;
}

createhintobject(org, type, icon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov, _id_DBCE45A33308630D) {
  hintobj = undefined;

  if(isDefined(_id_DBCE45A33308630D))
    hintobj = _id_DBCE45A33308630D;
  else
    hintobj = spawn("script_model", org);

  hintobj makeusable();

  if(isDefined(_id_DBCE45A33308630D) && isDefined(org))
    hintobj sethinttag(org);

  if(isDefined(type))
    hintobj setCursorHint(type);
  else
    hintobj setCursorHint("HINT_NOICON");

  if(isDefined(icon))
    hintobj sethinticon(icon);

  if(isDefined(hintstring))
    hintobj setHintString(hintstring);

  if(isDefined(priority))
    hintobj setusepriority(priority);
  else
    hintobj setusepriority(0);

  if(isDefined(duration))
    hintobj setuseholdduration(duration);
  else
    hintobj setuseholdduration("duration_short");

  if(isDefined(onobstruction))
    hintobj sethintonobstruction(onobstruction);
  else
    hintobj sethintonobstruction("hide");

  if(isDefined(hintdist))
    hintobj sethintdisplayrange(hintdist);
  else
    hintobj sethintdisplayrange(200);

  if(isDefined(hintfov))
    hintobj sethintdisplayfov(hintfov);
  else
    hintobj sethintdisplayfov(160);

  if(isDefined(usedist))
    hintobj setuserange(usedist);
  else
    hintobj setuserange(50);

  if(isDefined(usefov))
    hintobj setusefov(usefov);
  else
    hintobj setusefov(120);

  if(!isDefined(_id_DBCE45A33308630D))
    return hintobj;
}

getmissedinfilcamerapositions(team) {
  _id_B379BC48DC371726 = spawnStruct();
  _id_B379BC48DC371726.startorigin = undefined;
  _id_B379BC48DC371726.endpos = undefined;

  if(level.mapname == "mp_locale_test") {
    switch (level.localeid) {
      case "locale_8":
      case "locale_6":
        if(team == "axis") {
          _id_B379BC48DC371726.startorigin = (2094, -1804, 2763);
          _id_B379BC48DC371726.startangles = (54, 40, 0);
          _id_B379BC48DC371726.endorigin = (2094, -1804, 2763);
          _id_B379BC48DC371726.endangles = (54, 40, 0);
        } else {
          _id_B379BC48DC371726.startorigin = (2315, 1956, 2763);
          _id_B379BC48DC371726.startangles = (54, 296, 0);
          _id_B379BC48DC371726.endorigin = (2094, -1804, 2763);
          _id_B379BC48DC371726.endangles = (54, 40, 0);
        }

        break;
      default:
        _id_B379BC48DC371726.startorigin = (0, 0, 0);
        _id_B379BC48DC371726.startangles = (0, 0, 0);
        _id_B379BC48DC371726.endorigin = (0, 0, 0);
        _id_B379BC48DC371726.endangles = (0, 0, 0);
        break;
    }
  } else {
    switch (level.localeid) {
      case "locale_3":
        if(team == "axis") {
          _id_B379BC48DC371726.startorigin = (38864, -14018, -396);
          _id_B379BC48DC371726.startangles = (3, 250, 0);
          _id_B379BC48DC371726.endorigin = (38473, -14077, 401);
          _id_B379BC48DC371726.endangles = (15, 252, 0);
        } else {
          _id_B379BC48DC371726.startorigin = (30526, -38262, -483);
          _id_B379BC48DC371726.startangles = (0, 72, 0);
          _id_B379BC48DC371726.endorigin = (30024, -38403, 560);
          _id_B379BC48DC371726.endangles = (19, 67, 0);
        }

        break;
      case "locale_6":
        if(team == "axis") {
          _id_B379BC48DC371726.startorigin = (16977, -23256, 169);
          _id_B379BC48DC371726.startangles = (9, 69, 0);
          _id_B379BC48DC371726.endorigin = (16899, -23467, 683);
          _id_B379BC48DC371726.endangles = (15, 68, 0);
        } else {
          _id_B379BC48DC371726.startorigin = (18607, 1423, -355);
          _id_B379BC48DC371726.startangles = (8, 289, 0);
          _id_B379BC48DC371726.endorigin = (18100, 1083, 503);
          _id_B379BC48DC371726.endangles = (22, 302, 0);
        }

        break;
      case "locale_8":
        if(team == "axis") {
          _id_B379BC48DC371726.startorigin = (18672, -26836, -129);
          _id_B379BC48DC371726.startangles = (359, 76, 0);
          _id_B379BC48DC371726.endorigin = (18518, -26909, 314);
          _id_B379BC48DC371726.endangles = (14, 69, 0);
        } else {
          _id_B379BC48DC371726.startorigin = (18607, 1423, -355);
          _id_B379BC48DC371726.startangles = (8, 289, 0);
          _id_B379BC48DC371726.endorigin = (18100, 1083, 503);
          _id_B379BC48DC371726.endangles = (22, 302, 0);
        }

        break;
      case "locale_16":
      case "locale_5":
        if(team == "axis") {
          _id_B379BC48DC371726.startorigin = (24893, 28349, 1408);
          _id_B379BC48DC371726.startangles = (15, 54, 0);
          _id_B379BC48DC371726.endorigin = (25613, 29274, 1255);
          _id_B379BC48DC371726.endangles = (19, 53, 0);
        } else {
          _id_B379BC48DC371726.startorigin = (39490, 48919, 2302);
          _id_B379BC48DC371726.startangles = (17, 235, 0);
          _id_B379BC48DC371726.endorigin = (39254, 48584, 1542);
          _id_B379BC48DC371726.endangles = (18, 245, 0);
        }

        break;
      case "locale_9":
        if(team == "axis") {
          _id_B379BC48DC371726.startorigin = (48331, -24822, 514);
          _id_B379BC48DC371726.startangles = (12, 77, 0);
          _id_B379BC48DC371726.endorigin = (48424, -24421, -240);
          _id_B379BC48DC371726.endangles = (2, 77, 0);
        } else {
          _id_B379BC48DC371726.startorigin = (46188, 2520, 49);
          _id_B379BC48DC371726.startangles = (7, 295, 0);
          _id_B379BC48DC371726.endorigin = (46571, 2664, 526);
          _id_B379BC48DC371726.endangles = (16, 276, 0);
        }

        break;
      case "locale_10":
        if(team == "axis") {
          _id_B379BC48DC371726.startorigin = (-11083, 22197, 381);
          _id_B379BC48DC371726.startangles = (10, 181, 0);
          _id_B379BC48DC371726.endorigin = (-12112, 23761, 381);
          _id_B379BC48DC371726.endangles = (11, 201, 0);
        } else {
          _id_B379BC48DC371726.startorigin = (-31134, 11924, -116);
          _id_B379BC48DC371726.startangles = (0, 36, 0);
          _id_B379BC48DC371726.endorigin = (-31134, 11924, 434);
          _id_B379BC48DC371726.endangles = (11, 36, 0);
        }

        break;
      case "locale_17":
        if(team == "axis") {
          _id_B379BC48DC371726.startorigin = (9215, 984, 325);
          _id_B379BC48DC371726.startangles = (357, 186, 0);
          _id_B379BC48DC371726.endorigin = (9107, 628, 1144);
          _id_B379BC48DC371726.endangles = (19, 182, 0);
        } else {
          _id_B379BC48DC371726.startorigin = (-5351, 641, 408);
          _id_B379BC48DC371726.startangles = (2, 352, 0);
          _id_B379BC48DC371726.endorigin = (-5282, 996, 1103);
          _id_B379BC48DC371726.endangles = (11, 347, 0);
        }

        break;
      case "locale_18":
        if(team == "axis") {
          _id_B379BC48DC371726.startorigin = (-22847, -28632, 34);
          _id_B379BC48DC371726.startangles = (12, 42, 0);
          _id_B379BC48DC371726.endorigin = (-22694, -28429, 356);
          _id_B379BC48DC371726.endangles = (12, 40, 0);
        } else {
          _id_B379BC48DC371726.startorigin = (-8084, -20649, 72);
          _id_B379BC48DC371726.startangles = (10, 185, 0);
          _id_B379BC48DC371726.endorigin = (-9092, -20635, 224);
          _id_B379BC48DC371726.endangles = (12, 184, 0);
        }

        break;
      default:
        _id_B379BC48DC371726.startorigin = (0, 0, 0);
        _id_B379BC48DC371726.startangles = (0, 0, 0);
        _id_B379BC48DC371726.endorigin = (0, 0, 0);
        _id_B379BC48DC371726.endangles = (0, 0, 0);
        break;
    }
  }

  return _id_B379BC48DC371726;
}

calculatehqmidpoint() {
  level.hqmidpoint = (level.gw_objstruct.axishqloc.trigger.origin + level.gw_objstruct.allieshqloc.trigger.origin) * 0.5;
  level.hqvecttomid_allies = level.gw_objstruct.axishqloc.trigger.origin - level.hqmidpoint;
  level.hqvecttomid_axis = level.gw_objstruct.allieshqloc.trigger.origin - level.hqmidpoint;
  level.hqdisttomid = length(level.hqvecttomid_axis);
}

calculatecameraoffset(team, _id_800054CA1A89DACE) {
  switch (level.mapname) {
    case "mp_quarry2":
      _id_FC87D6FC10744D44 = 0.25;
      _id_6E9B9701B439AEB7 = 0.35;
      break;
    case "mp_farms2":
      _id_FC87D6FC10744D44 = 0.25;
      _id_6E9B9701B439AEB7 = 0.8;
      break;
    case "mp_aniyah":
      _id_FC87D6FC10744D44 = 0.5;
      _id_6E9B9701B439AEB7 = 0.3;
      break;
    default:
      _id_FC87D6FC10744D44 = 0.0;
      _id_6E9B9701B439AEB7 = 0.0;
      break;
  }

  _id_46F432042B3473D8 = distance(_id_800054CA1A89DACE, level.hqmidpoint);

  if(_id_46F432042B3473D8 < 2048)
    return (0, 0, 0);

  if(team == "axis") {
    _id_4881F7FE7FC2BAE2 = distance(level.gw_objstruct.axishqloc.trigger.origin, _id_800054CA1A89DACE);
    _id_3B776694EEAC2BEB = level.hqvecttomid_axis;
  } else {
    _id_4881F7FE7FC2BAE2 = distance(level.gw_objstruct.allieshqloc.trigger.origin, _id_800054CA1A89DACE);
    _id_3B776694EEAC2BEB = level.hqvecttomid_allies;
  }

  if(_id_4881F7FE7FC2BAE2 < 2048)
    return _id_3B776694EEAC2BEB * _id_FC87D6FC10744D44;

  if(_id_4881F7FE7FC2BAE2 > level.hqdisttomid) {
    if(team == "axis")
      _id_4881F7FE7FC2BAE2 = distance(level.gw_objstruct.allieshqloc.trigger.origin, _id_800054CA1A89DACE);
    else
      _id_4881F7FE7FC2BAE2 = distance(level.gw_objstruct.axishqloc.trigger.origin, _id_800054CA1A89DACE);

    _id_2BF3C98575BA0BE1 = 100 - _id_4881F7FE7FC2BAE2 * 100 / level.hqdisttomid;
    offset = _id_3B776694EEAC2BEB * _id_6E9B9701B439AEB7 * -1.0 * (_id_2BF3C98575BA0BE1 / 100);
    return offset;
  } else {
    _id_2BF3C98575BA0BE1 = 100 - _id_4881F7FE7FC2BAE2 * 100 / level.hqdisttomid;
    offset = _id_3B776694EEAC2BEB * _id_FC87D6FC10744D44 * (_id_2BF3C98575BA0BE1 / 100);
    return offset;
  }
}

spawnprotectionexception() {
  if(isDefined(self.selectedspawnarea) && issubstr(self.selectedspawnarea, "HQ"))
    return 1;

  return 0;
}

_id_658C8F668D2CD83C() {
  wait 5;
  _id_7AB5B649FA408138::_id_0F1AED36AB4598EA("mp_gamemode_gw");
}

_id_AABAACE9C798A2E1() {
  level._id_048E03F24B9B5C1A = 0;
  level._id_279807E5DA6C6A18 = [];
  frontlineinfo = spawnStruct();
  frontlineinfo.origin = (level.gw_objstruct.allieshqloc.trigger.origin + level.gw_objstruct.axishqloc.trigger.origin) * 0.5;
  level._id_279807E5DA6C6A18["player"] = frontlineinfo;
  frontlineinfo = spawnStruct();
  frontlineinfo.origin = (level.gw_objstruct.allieshqloc.trigger.origin + level.gw_objstruct.axishqloc.trigger.origin) * 0.5;
  level._id_279807E5DA6C6A18["agent"] = frontlineinfo;
  level _id_ADE21F3382E7E29A();
  level thread _id_D9730DBC16CE09E2();
  level thread _id_81ADD84C2385A7EE();
  level thread _id_E28BB63A5E8E8D12();
  level thread _id_E62DCABB18095ABB();
}

_id_E28BB63A5E8E8D12() {
  _id_9D66B11865F83798 = getdvarint("dvar_7BA9B97C63A992B5", 0);
  _id_EB132661853AA312 = getdvarfloat("dvar_1B0E9FAA2B5E36E4", 30.0);
  _id_11C5E87250CA0BF9 = getdvarint("dvar_6240B7BDF606E6AB", 60) * 1000;
  _id_5F857334B93B7B81 = getdvarint("dvar_C52AEE495FF0598A", 180) * 1000;
  _id_54739E717FA73734 = getdvarint("dvar_4C9D7F8DEDE759C7", 1);
  _id_88F3D778EFE40C6E = getdvarint("dvar_73D5DF0E713E122F", 200);
  _id_D3C8E7E7E4F0FAD5 = getdvarfloat("dvar_B9EC3BEA41DDD71B", 0.2);
  _id_750C94BA41F40A47 = 0;
  _id_26C3CDE297AFE485 = 0;
  level._id_272B2716F1938412 = 0;
  _id_EC823F5F10F705AC = 0;
  _id_03C1586D15C611AE = spawnStruct();
  _id_03C1586D15C611AE._id_FE95D825C29E4B68 = level._id_048E03F24B9B5C1A;
  _id_03C1586D15C611AE._id_38EF642AEDE44556 = 0;
  _id_03C1586D15C611AE._id_18A3FAB290E780C2 = getteamscore("axis");
  _id_03C1586D15C611AE._id_43A41488C3C487DF = getteamscore("allies");

  for(;;) {
    waitframe();
    currenttime = gettime();
    _id_C732AC2A579C99B1 = getteamscore("axis") - _id_03C1586D15C611AE._id_18A3FAB290E780C2;
    _id_8C6BCD8C000B8C10 = getteamscore("allies") - _id_03C1586D15C611AE._id_43A41488C3C487DF;
    _id_1C04D17C30083C16 = abs(level._id_048E03F24B9B5C1A - level._id_272B2716F1938412);
    _id_D50A39F7198881DC = scripts\engine\utility::ter_op(level._id_048E03F24B9B5C1A > level._id_272B2716F1938412, 1.0 + _id_1C04D17C30083C16 * _id_D3C8E7E7E4F0FAD5, 1.0);
    _id_0C24EFF89217D12F = scripts\engine\utility::ter_op(level._id_048E03F24B9B5C1A < level._id_272B2716F1938412, 1.0 + _id_1C04D17C30083C16 * _id_D3C8E7E7E4F0FAD5, 1.0);

    if(getdvarint("dvar_13FAE9C305971D06", 0) == 1) {
      _id_63F43F469B885EC6 = 25;
      _id_1B11EAA9B42E5081 = 800;
      _id_1B11E9A9B42E4E4E = 50;
      _id_7918C27CB3E1349A = 0;
      _id_7918C27CB3E1349A++;
      _id_7918C27CB3E1349A++;
      _id_7918C27CB3E1349A++;
      _id_7918C27CB3E1349A++;
      _id_12DDF4A9082AAA2A = max(0.0, (_id_03C1586D15C611AE._id_38EF642AEDE44556 + _id_11C5E87250CA0BF9 - currenttime) / 1000);
      _id_7918C27CB3E1349A++;
      _id_12DDF4A9082AAA2A = max(0.0, (_id_03C1586D15C611AE._id_38EF642AEDE44556 + _id_5F857334B93B7B81 - currenttime) / 1000);
      _id_7918C27CB3E1349A++;
      _id_7918C27CB3E1349A++;
      _id_7918C27CB3E1349A++;
      _id_7918C27CB3E1349A++;
    }

    if(getdvarint("dvar_4DAEF99E4FC56E2A", -1) != -1) {
      _id_03C1586D15C611AE._id_FE95D825C29E4B68 = level._id_048E03F24B9B5C1A;
      level._id_048E03F24B9B5C1A = getdvarint("dvar_4DAEF99E4FC56E2A", -1);
      _id_03C1586D15C611AE._id_38EF642AEDE44556 = gettime();
      _id_03C1586D15C611AE._id_18A3FAB290E780C2 = getteamscore("axis");
      _id_03C1586D15C611AE._id_43A41488C3C487DF = getteamscore("allies");

      if(level._id_048E03F24B9B5C1A != _id_03C1586D15C611AE._id_FE95D825C29E4B68) {
        if(_id_03C1586D15C611AE._id_FE95D825C29E4B68 < level._id_048E03F24B9B5C1A) {
          scripts\mp\utility\dialog::statusdialog("gwtdm_fall_back", "allies", 1);
          scripts\mp\utility\dialog::statusdialog("gwtdm_push_foward", "axis", 1);
          _id_3F6FD6EDAF6C6713 = "axis";
        } else {
          scripts\mp\utility\dialog::statusdialog("gwtdm_fall_back", "axis", 1);
          scripts\mp\utility\dialog::statusdialog("gwtdm_push_foward", "allies", 1);
          _id_3F6FD6EDAF6C6713 = "allies";
        }

        _id_2B4958ACF92594E3();
        level _id_02F5B6C628445768(_id_3F6FD6EDAF6C6713);
        level notify("frontline_moved");
      }

      continue;
    }

    switch (_id_9D66B11865F83798) {
      case 0:
        _id_EC823F5F10F705AC = _id_BF26CA1DFFD4923A();
        break;
      default:
        _id_EC823F5F10F705AC = _id_BF26CA1DFFD4923A();
        break;
    }

    if(!_id_26C3CDE297AFE485) {
      _id_26C3CDE297AFE485 = 1;
      _id_EC823F5F10F705AC = _id_BF26CA1DFFD4923A();
      level._id_272B2716F1938412 = _id_EC823F5F10F705AC;
      level._id_048E03F24B9B5C1A = _id_EC823F5F10F705AC;
      _id_03C1586D15C611AE._id_FE95D825C29E4B68 = level._id_048E03F24B9B5C1A;
      _id_03C1586D15C611AE._id_38EF642AEDE44556 = gettime();
      _id_03C1586D15C611AE._id_18A3FAB290E780C2 = getteamscore("axis");
      _id_03C1586D15C611AE._id_43A41488C3C487DF = getteamscore("allies");
      _id_2B4958ACF92594E3();
    }

    if(!scripts\mp\flags::gameflag("prematch_done")) {
      continue;
    }
    if(currenttime > _id_03C1586D15C611AE._id_38EF642AEDE44556 + _id_5F857334B93B7B81) {
      if(_id_C732AC2A579C99B1 >= _id_88F3D778EFE40C6E * _id_D50A39F7198881DC || _id_8C6BCD8C000B8C10 >= _id_88F3D778EFE40C6E * _id_0C24EFF89217D12F) {
        if(_id_C732AC2A579C99B1 > _id_8C6BCD8C000B8C10)
          _id_EC823F5F10F705AC = int(clamp(level._id_048E03F24B9B5C1A + 1, 0, level._id_33809C8A29CA064E.size - 1));
        else
          _id_EC823F5F10F705AC = int(clamp(level._id_048E03F24B9B5C1A - 1, 0, level._id_33809C8A29CA064E.size - 1));

        _id_750C94BA41F40A47 = _id_EB132661853AA312;
      }
    }

    if(_id_EC823F5F10F705AC != level._id_048E03F24B9B5C1A) {
      _id_750C94BA41F40A47 = _id_750C94BA41F40A47 + level.framedurationseconds;

      if(currenttime > _id_03C1586D15C611AE._id_38EF642AEDE44556 + _id_11C5E87250CA0BF9 && _id_750C94BA41F40A47 > _id_EB132661853AA312) {
        _id_750C94BA41F40A47 = 0;
        _id_03C1586D15C611AE._id_38EF642AEDE44556 = gettime();
        _id_03C1586D15C611AE._id_FE95D825C29E4B68 = level._id_048E03F24B9B5C1A;
        _id_03C1586D15C611AE._id_18A3FAB290E780C2 = getteamscore("axis");
        _id_03C1586D15C611AE._id_43A41488C3C487DF = getteamscore("allies");

        if(_id_54739E717FA73734) {
          if(_id_EC823F5F10F705AC > level._id_048E03F24B9B5C1A)
            level._id_048E03F24B9B5C1A++;
          else
            level._id_048E03F24B9B5C1A--;
        } else
          level._id_048E03F24B9B5C1A = _id_EC823F5F10F705AC;

        if(_id_03C1586D15C611AE._id_FE95D825C29E4B68 < level._id_048E03F24B9B5C1A) {
          scripts\mp\utility\dialog::statusdialog("gwtdm_fall_back", "allies", 1);
          scripts\mp\utility\dialog::statusdialog("gwtdm_push_foward", "axis", 1);
          _id_3F6FD6EDAF6C6713 = "axis";
        } else {
          scripts\mp\utility\dialog::statusdialog("gwtdm_fall_back", "axis", 1);
          scripts\mp\utility\dialog::statusdialog("gwtdm_push_foward", "allies", 1);
          _id_3F6FD6EDAF6C6713 = "allies";
        }

        _id_2B4958ACF92594E3();
        level _id_02F5B6C628445768(_id_3F6FD6EDAF6C6713);
        level notify("frontline_moved");
      }

      continue;
    }

    _id_750C94BA41F40A47 = 0;
  }
}

_id_BF26CA1DFFD4923A() {
  _id_84D4866087B00608 = undefined;
  _id_5020875C61575F25 = undefined;

  foreach(key, data in level._id_33809C8A29CA064E) {
    closestpoint = pointonsegmentnearesttopoint(data._id_B027D6857AB9D713, data._id_014E33FB843CA741, level._id_279807E5DA6C6A18["player"].origin);
    distsq = distance2dsquared(closestpoint, level._id_279807E5DA6C6A18["player"].origin);

    if(getdvarint("dvar_13FAE9C305971D06", 0) == 1)
      level thread scripts\cp_mp\utility\debug_utility::drawline(closestpoint, level._id_279807E5DA6C6A18["player"].origin, level.framedurationseconds, (1, 0, 1));

    if(!isDefined(_id_84D4866087B00608) || distsq < _id_84D4866087B00608) {
      _id_84D4866087B00608 = distsq;
      _id_5020875C61575F25 = key;
    }
  }

  return _id_5020875C61575F25;
}

_id_E62DCABB18095ABB() {
  for(;;) {
    waitframe();

    if(getdvarint("dvar_13FAE9C305971D06", 0) == 0) {
      continue;
    }
    foreach(key, data in level._id_279807E5DA6C6A18) {
      _id_B9DBC464A0B5E5D4 = 256;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 5; _id_AC0E594AC96AA3A8++) {
        height = _id_B9DBC464A0B5E5D4 * _id_AC0E594AC96AA3A8;
        color = (1, 1, 1);

        switch (key) {
          case "player":
            color = (0, 1, 0);
            break;
          case "agent":
            color = (0, 1, 1);
            break;
        }

        level thread scripts\cp_mp\utility\debug_utility::drawsphere(data.origin + (0, 0, 1) * height, _id_B9DBC464A0B5E5D4, level.framedurationseconds, color);
      }
    }

    for(key = 0; key < level._id_33809C8A29CA064E.size; key++) {
      data = level._id_33809C8A29CA064E[key];
      level thread scripts\cp_mp\utility\debug_utility::drawline(data._id_B027D6857AB9D713, data._id_014E33FB843CA741, level.framedurationseconds, (1, 0, 0));
      color = scripts\engine\utility::ter_op(level._id_048E03F24B9B5C1A == key, (0, 1, 0), (1, 1, 1));
      _id_D4145D9E255225DC = undefined;

      for(_id_6C3FC29A5FD8751A = 0; _id_6C3FC29A5FD8751A < data._id_A2D0446BC9B000AB.size; _id_6C3FC29A5FD8751A++) {
        _id_A2D0446BC9B000AB = data._id_A2D0446BC9B000AB[_id_6C3FC29A5FD8751A];
        color = scripts\engine\utility::ter_op(level._id_048E03F24B9B5C1A == key, (0, 1, 0), (1, 1, 1));

        foreach(team, loc in _id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80) {
          color = scripts\engine\utility::ter_op(team == "axis", (1, 0, 0), (0, 0, 1)) * scripts\engine\utility::ter_op(level._id_048E03F24B9B5C1A == key, 1.0, 0.5);
          level thread scripts\cp_mp\utility\debug_utility::drawline(_id_A2D0446BC9B000AB.origin, loc.origin, level.framedurationseconds, color);
        }

        foreach(team, loc in _id_A2D0446BC9B000AB._id_E59F791D76C7BEEE) {
          color = scripts\engine\utility::ter_op(team == "axis", (1, 0, 0), (0, 0, 1)) * scripts\engine\utility::ter_op(level._id_048E03F24B9B5C1A == key, 1.0, 0.5);
          level thread scripts\cp_mp\utility\debug_utility::drawline(_id_A2D0446BC9B000AB.origin, loc.origin, level.framedurationseconds, color);
        }

        foreach(team, loc in _id_A2D0446BC9B000AB.redeployspawn)
        level thread scripts\cp_mp\utility\debug_utility::drawline(loc.origin - (0, 0, 500), loc.origin + (0, 0, 500), level.framedurationseconds, (0, 1, 0));

        if(key + 1 < level._id_33809C8A29CA064E.size) {
          color = (1, 1, 1);

          if(istrue(level._id_828F62C79774EE99))
            color = (1, 1, 0);

          level thread scripts\cp_mp\utility\debug_utility::drawline(_id_A2D0446BC9B000AB.origin, level._id_33809C8A29CA064E[key + 1]._id_A2D0446BC9B000AB[_id_6C3FC29A5FD8751A].origin, level.framedurationseconds, color);
        }

        if(isDefined(_id_D4145D9E255225DC)) {
          startpos = _id_D4145D9E255225DC;
          endpos = _id_A2D0446BC9B000AB.origin;
          _id_949FC3545F13FFB0 = (0.5, 0.5, 0.5);

          if(istrue(level._id_3813C5843955E260))
            _id_949FC3545F13FFB0 = (0, 1, 1);

          color = scripts\engine\utility::ter_op(level._id_048E03F24B9B5C1A == key, (0, 1, 0), _id_949FC3545F13FFB0);
          level thread scripts\cp_mp\utility\debug_utility::drawline(startpos, endpos, level.framedurationseconds, color);
        }

        _id_D4145D9E255225DC = _id_A2D0446BC9B000AB.origin;
      }
    }
  }
}

_id_D9730DBC16CE09E2() {
  for(;;) {
    _id_E4C7B343246F2158 = scripts\mp\spawnfactor::getfrontlineteamcenter("axis");

    if(!isDefined(_id_E4C7B343246F2158))
      _id_E4C7B343246F2158 = level.gw_objstruct.axishqloc.trigger.origin;

    _id_AAC62807B84149B5 = scripts\mp\spawnfactor::getfrontlineteamcenter("allies");

    if(!isDefined(_id_AAC62807B84149B5))
      _id_AAC62807B84149B5 = level.gw_objstruct.allieshqloc.trigger.origin;

    _id_E4C7B343246F2158 = (_id_E4C7B343246F2158[0], _id_E4C7B343246F2158[1], level.gw_objstruct.axishqloc.trigger.origin[2]);
    _id_AAC62807B84149B5 = (_id_AAC62807B84149B5[0], _id_AAC62807B84149B5[1], level.gw_objstruct.axishqloc.trigger.origin[2]);
    origin = (_id_E4C7B343246F2158 + _id_AAC62807B84149B5) * 0.5;
    level._id_279807E5DA6C6A18["player"].origin = origin;
    waitframe();
  }
}

_id_81ADD84C2385A7EE() {
  while(!isDefined(level._id_AE5271D2ED773311))
    waitframe();

  for(;;) {
    agents = [];

    foreach(team in level.teamnamelist) {
      foreach(_id_6C3FC29A5FD8751A, _id_A2D0446BC9B000AB in level._id_AE5271D2ED773311[team])
      agents = scripts\engine\utility::array_combine(agents, _id_A2D0446BC9B000AB._id_E2C31580F508B878);
    }

    if(agents.size > 0) {
      _id_F95FEB63C772E28F = scripts\mp\utility\entity::getaverageorigin(agents);
      level._id_279807E5DA6C6A18["agent"].origin = (_id_F95FEB63C772E28F[0], _id_F95FEB63C772E28F[1], level.gw_objstruct.axishqloc.trigger.origin[2]);
    }

    waitframe();
  }
}

_id_ADE21F3382E7E29A() {
  _id_3767296E0C6CAB78 = scripts\engine\utility::getStructArray("frontlineData", "script_noteworthy");

  if(!isDefined(_id_3767296E0C6CAB78) || _id_3767296E0C6CAB78.size == 0)
    _id_3767296E0C6CAB78 = _id_E7B7B3F8010440FA();

  level._id_9DE3C802FCED05E2 = [];
  level._id_9DE3C802FCED05E2["axis"] = [];
  level._id_9DE3C802FCED05E2["allies"] = [];
  level._id_3BF1CF107E60E048 = [];
  level._id_3BF1CF107E60E048["axis"] = [];
  level._id_3BF1CF107E60E048["allies"] = [];
  _id_DE1E630F4EA7F25C = [];

  foreach(item in _id_3767296E0C6CAB78) {
    _id_583A3EE793DCF1C4 = 1;

    foreach(_id_87137DA4020A50A1 in _id_DE1E630F4EA7F25C) {
      if(distance2dsquared(item.origin, _id_87137DA4020A50A1.origin) < 16384) {
        _id_583A3EE793DCF1C4 = 0;
        break;
      }
    }

    if(_id_583A3EE793DCF1C4)
      _id_DE1E630F4EA7F25C[_id_DE1E630F4EA7F25C.size] = item;
  }

  _id_3767296E0C6CAB78 = _id_DE1E630F4EA7F25C;

  foreach(data in _id_3767296E0C6CAB78) {
    data.forward = anglesToForward(data.angles);
    data.right = anglestoright(data.angles);
    data.radius = randomfloatrange(2048, 4096);
    data._id_B027D6857AB9D713 = data.origin - data.right * data.radius;
    data._id_014E33FB843CA741 = data.origin + data.right * data.radius;
    _id_2FD222665175DF1B = scripts\engine\utility::getStructArray(data.target, "targetname");

    if(isDefined(_id_2FD222665175DF1B) && _id_2FD222665175DF1B.size > 0) {
      _id_A2D0446BC9B000AB = spawnStruct();
      _id_A2D0446BC9B000AB = [];

      foreach(_id_D8172E39EDF4D70A in _id_2FD222665175DF1B) {
        if(issubstr(_id_D8172E39EDF4D70A.script_noteworthy, "center")) {
          continue;
        }
        _id_6C3FC29A5FD8751A = int(strtok(_id_D8172E39EDF4D70A.script_noteworthy, "_")[1]) - 1;

        if(!isDefined(_id_A2D0446BC9B000AB[_id_6C3FC29A5FD8751A])) {
          _id_A2D0446BC9B000AB[_id_6C3FC29A5FD8751A] = spawnStruct();
          _id_A2D0446BC9B000AB[_id_6C3FC29A5FD8751A]._id_45D6F1C931BC6A8B = [];
          _id_A2D0446BC9B000AB[_id_6C3FC29A5FD8751A]._id_E59F791D76C7BEEE = [];
          _id_A2D0446BC9B000AB[_id_6C3FC29A5FD8751A]._id_D8C8EC702B9AFD80 = [];
        }

        if(!isDefined(_id_D8172E39EDF4D70A.script_team))
          _id_D8172E39EDF4D70A.script_team = "axis";

        _id_D8172E39EDF4D70A.radius = 1024;
        volumes = getEntArray("frontline0" + (int(data.script_label) + 1) + "_lane0" + (int(_id_6C3FC29A5FD8751A) + 1) + "_" + _id_D8172E39EDF4D70A.script_team, "script_noteworthy");
        _id_D8172E39EDF4D70A._id_448DCBC6F715EFDC = volumes[0];
        _id_064E328C24147BDF = "frontline0" + (int(data.script_label) + 1) + "_lane0" + (int(_id_6C3FC29A5FD8751A) + 1) + "_front_" + _id_D8172E39EDF4D70A.script_team;
        volumes = getEntArray(_id_064E328C24147BDF, "script_noteworthy");
        _id_A2D0446BC9B000AB[_id_6C3FC29A5FD8751A]._id_E59F791D76C7BEEE[_id_D8172E39EDF4D70A.script_team] = volumes[0];
        _id_CF3AC540CA289C49 = "frontline0" + (int(data.script_label) + 1) + "_lane0" + (int(_id_6C3FC29A5FD8751A) + 1) + "_back_" + _id_D8172E39EDF4D70A.script_team;
        volumes = getEntArray(_id_CF3AC540CA289C49, "script_noteworthy");
        _id_A2D0446BC9B000AB[_id_6C3FC29A5FD8751A]._id_D8C8EC702B9AFD80[_id_D8172E39EDF4D70A.script_team] = volumes[0];

        if(!isDefined(_id_A2D0446BC9B000AB[_id_6C3FC29A5FD8751A]._id_45D6F1C931BC6A8B[_id_D8172E39EDF4D70A.script_team]))
          _id_A2D0446BC9B000AB[_id_6C3FC29A5FD8751A]._id_45D6F1C931BC6A8B[_id_D8172E39EDF4D70A.script_team] = [];

        _id_A2D0446BC9B000AB[_id_6C3FC29A5FD8751A]._id_45D6F1C931BC6A8B[_id_D8172E39EDF4D70A.script_team][_id_A2D0446BC9B000AB[_id_6C3FC29A5FD8751A]._id_45D6F1C931BC6A8B[_id_D8172E39EDF4D70A.script_team].size] = _id_D8172E39EDF4D70A;
      }

      foreach(_id_D8172E39EDF4D70A in _id_2FD222665175DF1B) {
        if(issubstr(_id_D8172E39EDF4D70A.script_noteworthy, "center")) {
          _id_6C3FC29A5FD8751A = int(strtok(_id_D8172E39EDF4D70A.script_noteworthy, "_")[1]) - 1;
          _id_A2D0446BC9B000AB[_id_6C3FC29A5FD8751A].origin = _id_D8172E39EDF4D70A.origin;
        }
      }

      foreach(_id_6C3FC29A5FD8751A, lane in _id_A2D0446BC9B000AB) {
        if(!isDefined(lane.origin)) {
          _id_A76E5428020D35CC = (0, 0, 0);
          count = 0;

          foreach(_id_45D6F1C931BC6A8B in lane._id_45D6F1C931BC6A8B) {
            foreach(point in _id_45D6F1C931BC6A8B) {
              _id_A76E5428020D35CC = _id_A76E5428020D35CC + point.origin;
              count++;
            }
          }

          lane.origin = _id_A76E5428020D35CC / count;
        }
      }

      data._id_A2D0446BC9B000AB = _id_A2D0446BC9B000AB;
    } else
      data._id_A2D0446BC9B000AB = _id_49294D0067CB3C96(data);

    if(isDefined(data._id_A2D0446BC9B000AB[0])) {
      _id_54039817F24F4FE0 = vectorNormalize(data._id_A2D0446BC9B000AB[0].origin - data._id_A2D0446BC9B000AB[data._id_A2D0446BC9B000AB.size - 1].origin);
      data.right = _id_54039817F24F4FE0;
      data.forward = vectorcross(_id_54039817F24F4FE0, (0, 0, 1));
      data.radius = randomfloatrange(2048, 4096);
      data._id_B027D6857AB9D713 = data._id_A2D0446BC9B000AB[0].origin;
      data._id_014E33FB843CA741 = data._id_A2D0446BC9B000AB[data._id_A2D0446BC9B000AB.size - 1].origin;
    }
  }

  _id_4EA385AC02F17ACF = [];

  foreach(data in _id_3767296E0C6CAB78)
  _id_4EA385AC02F17ACF[int(data.script_label)] = data;

  _id_2535E9EA6DE28FD1 = getDvar("dvar_3560171963B3F075", "");
  _id_2535E9EA6DE28FD1 = strtok(_id_2535E9EA6DE28FD1, " ");
  _id_60598D075FC9CBB1 = [];

  if(_id_2535E9EA6DE28FD1.size > 0) {
    _id_EA979E5182F4F74D = _id_4EA385AC02F17ACF.size;

    foreach(_id_9F31B5CA38890225 in _id_2535E9EA6DE28FD1)
    _id_4EA385AC02F17ACF = scripts\engine\utility::array_remove_key(_id_4EA385AC02F17ACF, int(_id_9F31B5CA38890225));

    _id_AF79951156A8D90E = 0;

    for(_id_DD065E195E9D06B3 = 0; _id_AF79951156A8D90E < _id_4EA385AC02F17ACF.size; _id_DD065E195E9D06B3++) {
      if(isDefined(_id_4EA385AC02F17ACF[_id_DD065E195E9D06B3])) {
        _id_60598D075FC9CBB1[_id_AF79951156A8D90E] = _id_4EA385AC02F17ACF[_id_DD065E195E9D06B3];
        _id_AF79951156A8D90E++;
      }
    }
  } else
    _id_60598D075FC9CBB1 = _id_4EA385AC02F17ACF;

  level._id_33809C8A29CA064E = _id_60598D075FC9CBB1;
  _id_F42E3FF44A92F156();
  scripts\engine\utility::flag_set("frontline_data_init");
}

_id_F42E3FF44A92F156() {
  foreach(_id_30CEFDFAF86F81CE in level._id_33809C8A29CA064E) {
    foreach(_id_A2D0446BC9B000AB in _id_30CEFDFAF86F81CE._id_A2D0446BC9B000AB) {
      _id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["axis"].heading = _func_767CEA82B001F645(_id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["allies"].origin - _id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["axis"].origin);
      _id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["allies"].heading = _id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["axis"].heading * -1.0;
      _id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80["axis"].heading = _id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["axis"].heading;
      _id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80["allies"].heading = _id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["allies"].heading;
    }
  }
}

_id_CC492B99C56F8004() {
  foreach(index, _id_30CEFDFAF86F81CE in level._id_33809C8A29CA064E) {
    _id_A2D0446BC9B000AB = _id_30CEFDFAF86F81CE._id_A2D0446BC9B000AB[0];
    thread scripts\mp\utility\debug::drawsphere(_id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["axis"].origin, 256, 60, (1, 0, 0));
    endpoint = _id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["axis"].origin + _id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["axis"].heading * 1024;
    level thread scripts\cp_mp\utility\debug_utility::drawline(_id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["axis"].origin, endpoint, 60, (0, 0, 1));
    _id_A2D0446BC9B000AB = _id_30CEFDFAF86F81CE._id_A2D0446BC9B000AB[1];
    thread scripts\mp\utility\debug::drawsphere(_id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["axis"].origin, 256, 60, (1, 0, 0));
    endpoint = _id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["axis"].origin + _id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["axis"].heading * 1024;
    level thread scripts\cp_mp\utility\debug_utility::drawline(_id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["axis"].origin, endpoint, 60, (0, 0, 1));
    _id_A2D0446BC9B000AB = _id_30CEFDFAF86F81CE._id_A2D0446BC9B000AB[2];
    thread scripts\mp\utility\debug::drawsphere(_id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["axis"].origin, 256, 60, (1, 0, 0));
    endpoint = _id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["axis"].origin + _id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["axis"].heading * 1024;
    level thread scripts\cp_mp\utility\debug_utility::drawline(_id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["axis"].origin, endpoint, 60, (0, 0, 1));
    _id_A2D0446BC9B000AB = _id_30CEFDFAF86F81CE._id_A2D0446BC9B000AB[0];
    thread scripts\mp\utility\debug::drawsphere(_id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80["axis"].origin, 256, 60, (1, 0, 0));
    endpoint = _id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80["axis"].origin + _id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80["axis"].heading * 1024;
    level thread scripts\cp_mp\utility\debug_utility::drawline(_id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80["axis"].origin, endpoint, 60, (0, 0, 1));
    _id_A2D0446BC9B000AB = _id_30CEFDFAF86F81CE._id_A2D0446BC9B000AB[1];
    thread scripts\mp\utility\debug::drawsphere(_id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80["axis"].origin, 256, 60, (1, 0, 0));
    endpoint = _id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80["axis"].origin + _id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80["axis"].heading * 1024;
    level thread scripts\cp_mp\utility\debug_utility::drawline(_id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80["axis"].origin, endpoint, 60, (0, 0, 1));
    _id_A2D0446BC9B000AB = _id_30CEFDFAF86F81CE._id_A2D0446BC9B000AB[2];
    thread scripts\mp\utility\debug::drawsphere(_id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80["axis"].origin, 256, 60, (1, 0, 0));
    endpoint = _id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80["axis"].origin + _id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80["axis"].heading * 1024;
    level thread scripts\cp_mp\utility\debug_utility::drawline(_id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80["axis"].origin, endpoint, 60, (0, 0, 1));
    _id_A2D0446BC9B000AB = _id_30CEFDFAF86F81CE._id_A2D0446BC9B000AB[0];
    thread scripts\mp\utility\debug::drawsphere(_id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["allies"].origin, 256, 60, (1, 0, 0));
    endpoint = _id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["allies"].origin + _id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["allies"].heading * 1024;
    level thread scripts\cp_mp\utility\debug_utility::drawline(_id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["allies"].origin, endpoint, 60, (0, 0, 1));
    _id_A2D0446BC9B000AB = _id_30CEFDFAF86F81CE._id_A2D0446BC9B000AB[1];
    thread scripts\mp\utility\debug::drawsphere(_id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["allies"].origin, 256, 60, (1, 0, 0));
    endpoint = _id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["allies"].origin + _id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["allies"].heading * 1024;
    level thread scripts\cp_mp\utility\debug_utility::drawline(_id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["allies"].origin, endpoint, 60, (0, 0, 1));
    _id_A2D0446BC9B000AB = _id_30CEFDFAF86F81CE._id_A2D0446BC9B000AB[2];
    thread scripts\mp\utility\debug::drawsphere(_id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["allies"].origin, 256, 60, (1, 0, 0));
    endpoint = _id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["allies"].origin + _id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["allies"].heading * 1024;
    level thread scripts\cp_mp\utility\debug_utility::drawline(_id_A2D0446BC9B000AB._id_E59F791D76C7BEEE["allies"].origin, endpoint, 60, (0, 0, 1));
    _id_A2D0446BC9B000AB = _id_30CEFDFAF86F81CE._id_A2D0446BC9B000AB[0];
    thread scripts\mp\utility\debug::drawsphere(_id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80["allies"].origin, 256, 60, (1, 0, 0));
    endpoint = _id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80["allies"].origin + _id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80["allies"].heading * 1024;
    level thread scripts\cp_mp\utility\debug_utility::drawline(_id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80["allies"].origin, endpoint, 60, (0, 0, 1));
    _id_A2D0446BC9B000AB = _id_30CEFDFAF86F81CE._id_A2D0446BC9B000AB[1];
    thread scripts\mp\utility\debug::drawsphere(_id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80["allies"].origin, 256, 60, (1, 0, 0));
    endpoint = _id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80["allies"].origin + _id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80["allies"].heading * 1024;
    level thread scripts\cp_mp\utility\debug_utility::drawline(_id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80["allies"].origin, endpoint, 60, (0, 0, 1));
    _id_A2D0446BC9B000AB = _id_30CEFDFAF86F81CE._id_A2D0446BC9B000AB[2];
    thread scripts\mp\utility\debug::drawsphere(_id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80["allies"].origin, 256, 60, (1, 0, 0));
    endpoint = _id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80["allies"].origin + _id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80["allies"].heading * 1024;
    level thread scripts\cp_mp\utility\debug_utility::drawline(_id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80["allies"].origin, endpoint, 60, (0, 0, 1));
  }
}

_id_E7B7B3F8010440FA() {
  level._id_3813C5843955E260 = 1;
  _id_9E4E1482CB40C9C5 = [];
  startorigin = level.gw_objstruct.axishqloc.trigger.origin;
  _id_A5BB1FA786D5B61E = distance(level.gw_objstruct.allieshqloc.trigger.origin, level.gw_objstruct.axishqloc.trigger.origin);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 6; _id_AC0E594AC96AA3A8++) {
    frac = (_id_AC0E594AC96AA3A8 * 2 + 1) / 12;
    origin = startorigin + level.spawnselectionteamforward["axis"] * _id_A5BB1FA786D5B61E * frac;
    data = spawnStruct();
    data.origin = origin;
    data.angles = vectortoangles(level.spawnselectionteamforward["axis"]);
    data.target = "";
    _id_9E4E1482CB40C9C5[_id_9E4E1482CB40C9C5.size] = data;
  }

  return _id_9E4E1482CB40C9C5;
}

_id_49294D0067CB3C96(data) {
  level._id_828F62C79774EE99 = 1;
  _id_2FD222665175DF1B = [];
  _id_813A0B907262A1C2 = 3;
  _id_A6640E8FB7A2A52F = 3;
  startorigin = data.origin - data.right * data.radius;
  width = data.radius * 2;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_813A0B907262A1C2; _id_AC0E594AC96AA3A8++) {
    _id_02EE094617021E62 = (_id_AC0E594AC96AA3A8 * 2 + 1) / (_id_813A0B907262A1C2 * 2);
    _id_A2D0446BC9B000AB = spawnStruct();
    _id_A2D0446BC9B000AB.origin = startorigin + data.right * _id_02EE094617021E62 * width;
    _id_A2D0446BC9B000AB._id_45D6F1C931BC6A8B = [];

    foreach(team in level.teamnamelist) {
      _id_A2D0446BC9B000AB._id_45D6F1C931BC6A8B[team] = [];
      _id_9FC5FBEAE7221FB6 = vectordot(data.forward, level.spawnselectionteamforward[team]) < 0;

      if(_id_A6640E8FB7A2A52F > 0)
        _id_A6640E8FB7A2A52F = 1 + randomint(_id_A6640E8FB7A2A52F);
      else
        _id_A6640E8FB7A2A52F = 1;

      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_A6640E8FB7A2A52F; _id_AC0E5C4AC96AAA41++) {
        _id_F995A9D3C6447942 = _id_A2D0446BC9B000AB.origin + data.forward * 1024 * 1.5 * scripts\engine\utility::ter_op(_id_9FC5FBEAE7221FB6, 1.0, -1.0);
        struct = spawnStruct();
        struct.origin = _id_2695A20D4011076D::getrandompointincircle(_id_F995A9D3C6447942, 512.0);
        struct.team = team;
        struct.radius = randomfloatrange(256, 512);
        _id_A2D0446BC9B000AB._id_45D6F1C931BC6A8B[team][_id_A2D0446BC9B000AB._id_45D6F1C931BC6A8B[team].size] = struct;
      }
    }

    _id_2FD222665175DF1B[_id_2FD222665175DF1B.size] = _id_A2D0446BC9B000AB;
  }

  return _id_2FD222665175DF1B;
}

_id_3CAB19163F3E50D3(team, _id_E9BF3955FA1125B5, _id_6C3FC29A5FD8751A) {
  return level._id_33809C8A29CA064E[_id_E9BF3955FA1125B5]._id_A2D0446BC9B000AB[_id_6C3FC29A5FD8751A]._id_45D6F1C931BC6A8B[team];
}

_id_7BB4716AC5C42F7C(team, _id_6C3FC29A5FD8751A) {
  return level._id_AE5271D2ED773311[team][_id_6C3FC29A5FD8751A]._id_F76E10D4DCE6C204[randomint(level._id_AE5271D2ED773311[team][_id_6C3FC29A5FD8751A]._id_F76E10D4DCE6C204.size)];
}

_id_A998AB000DF3C84C(origin, team, _id_6C3FC29A5FD8751A) {
  volumes = [];

  foreach(_id_30CEFDFAF86F81CE in level._id_33809C8A29CA064E) {
    foreach(index, _id_A2D0446BC9B000AB in _id_30CEFDFAF86F81CE._id_A2D0446BC9B000AB) {
      if(isDefined(_id_6C3FC29A5FD8751A) && _id_6C3FC29A5FD8751A != index) {
        continue;
      }
      if(_id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80.size > 0) {
        foreach(index, volume in _id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80) {
          if(isDefined(team) && team != index) {
            continue;
          }
          volumes[volumes.size] = volume;
        }

        foreach(index, volume in _id_A2D0446BC9B000AB._id_E59F791D76C7BEEE) {
          if(isDefined(team) && team != index) {
            continue;
          }
          volumes[volumes.size] = volume;
        }

        continue;
      }

      foreach(index, _id_897C7C54286A3B86 in _id_A2D0446BC9B000AB._id_45D6F1C931BC6A8B) {
        if(isDefined(team) && team != index) {
          continue;
        }
        foreach(_id_2C34125A01D24D3F in _id_897C7C54286A3B86)
        volumes[volumes.size] = _id_2C34125A01D24D3F._id_448DCBC6F715EFDC;
      }
    }
  }

  volumes = sortbydistance(volumes, origin);
  return volumes[0];
}

_id_FF46CB0A3BC4B055(agent, team, _id_6C3FC29A5FD8751A) {
  array = [];
  index = 0;
  _id_2F977E27FA739602 = 1;

  if(team == "allies") {
    index = level._id_33809C8A29CA064E.size - 1;
    _id_2F977E27FA739602 = -1;
  }

  while(index != level._id_048E03F24B9B5C1A) {
    _id_45D6F1C931BC6A8B = level._id_33809C8A29CA064E[index]._id_A2D0446BC9B000AB[_id_6C3FC29A5FD8751A]._id_45D6F1C931BC6A8B[team];
    _id_FE55D7604CEF0E3A = _id_45D6F1C931BC6A8B[randomint(_id_45D6F1C931BC6A8B.size)];
    array[array.size] = _id_FE55D7604CEF0E3A.origin;
    index = index + _id_2F977E27FA739602;
  }

  _id_45D6F1C931BC6A8B = level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_A2D0446BC9B000AB[_id_6C3FC29A5FD8751A]._id_45D6F1C931BC6A8B[team];
  _id_FE55D7604CEF0E3A = _id_45D6F1C931BC6A8B[randomint(_id_45D6F1C931BC6A8B.size)];
  array[array.size] = _id_FE55D7604CEF0E3A.origin;
  _id_2ADFAF68BC38DDBC = [];

  foreach(origin in array) {
    _id_A011729D000A28D2 = vectorNormalize(origin - agent.origin);

    if(vectordot(level.spawnselectionteamforward[team], _id_A011729D000A28D2) > 0)
      _id_2ADFAF68BC38DDBC[_id_2ADFAF68BC38DDBC.size] = origin;
  }

  return _id_2ADFAF68BC38DDBC;
}

_id_F16652E1462A3739() {
  if(getdvarint("scr_default_maxagents", 120) == 0) {
    return;
  }
  level._id_72E8A99508B7BE1B = getdvarint("dvar_55D8273E8C59F973", 45);
  level._id_B747EE617515989A = getdvarint("dvar_9B987A555B7E16AF", 256);
  level._id_C7A4725D05BB7F22 = 1;
  level._id_72F834B3F8B2A366 = [];
  level._id_72F834B3F8B2A366["axis"] = "aq_gwtdm";
  level._id_72F834B3F8B2A366["allies"] = "pmc";
  level thread _id_268C4DA1EF6A20A8::init();
  _id_48814951E916AF89::init();
  _id_7F995B3E1538A773();
  _id_48814951E916AF89::_id_93ADD0B65DB9F722(::_id_5CD456D9B2CDC538, level);
  level._id_9D28D5B70AA9F5E4 = ::_id_91FD6F5B51FC3635;
  scripts\engine\utility::flag_wait("frontline_data_init");
  level._id_AE5271D2ED773311 = [];
  level._id_B21AAFD3E06B203D = 1;

  foreach(team in level.teamnamelist) {
    level._id_AE5271D2ED773311[team] = [];

    foreach(_id_6C3FC29A5FD8751A, _id_A2D0446BC9B000AB in level._id_33809C8A29CA064E[0]._id_A2D0446BC9B000AB) {
      data = spawnStruct();
      data._id_6C3FC29A5FD8751A = _id_6C3FC29A5FD8751A;
      data._id_83CF1C64372DCCA5 = level._id_72E8A99508B7BE1B / level._id_33809C8A29CA064E[0]._id_A2D0446BC9B000AB.size;
      data._id_F76E10D4DCE6C204 = _id_3CAB19163F3E50D3(team, level._id_048E03F24B9B5C1A, _id_6C3FC29A5FD8751A);
      data._id_E2C31580F508B878 = [];
      data._id_8E55C5943A080A2E = 0;
      level._id_AE5271D2ED773311[team][_id_6C3FC29A5FD8751A] = data;
    }
  }

  level._id_C0E1DE2E14E458BF = "gwtdm";

  while(!isDefined(level.agentarray))
    waitframe();

  _id_7E95BA18D5BF7855();
  level thread _id_F9B8935478663F0B();
  level thread _id_848D0782943B416D("axis");
  level thread _id_848D0782943B416D("allies");

  if(getdvarint("dvar_69CFAA4519BA27D9", 1) == 1)
    level thread _id_FDC34E092FE389C8();

  level thread _id_C771A77BF1F4D2C1();

  while(!scripts\mp\flags::gameflag("prematch_done"))
    waitframe();

  level thread _id_037169A4FB87A0E3();
  level thread _id_B34021CA662A03BD();
}

_id_91FD6F5B51FC3635(agent, _id_772EDBDCFE906C73) {
  if(!isalive(agent)) {
    return;
  }
  agent endon("death");
  team = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "team");

  if(!scripts\mp\utility\teams::isgameplayteam(team)) {
    return;
  }
  _id_6C3FC29A5FD8751A = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "laneKey");

  if(!isDefined(_id_6C3FC29A5FD8751A)) {
    return;
  }
  if(!isDefined(agent._id_630CF5F5EE1C2D64))
    agent._id_630CF5F5EE1C2D64 = 1;

  agent._id_630CF5F5EE1C2D64++;

  if(agent._id_630CF5F5EE1C2D64 == 3) {
    _id_0421E96E09A60042 = _id_A998AB000DF3C84C(agent.origin, team, _id_6C3FC29A5FD8751A);
    agent cleargoalvolume();
    agent setgoalvolumeauto(_id_0421E96E09A60042, _id_0421E96E09A60042.heading);
    wait 5;
  } else {
    if(agent._id_630CF5F5EE1C2D64 > 10) {
      agent._id_416835640E8C55CD = 1;
      return;
    }

    _id_CB61F2F08271E0BE = _id_FF46CB0A3BC4B055(agent, team, _id_6C3FC29A5FD8751A);

    if(_id_CB61F2F08271E0BE.size > 0) {
      agent._id_CB61F2F08271E0BE = _id_CB61F2F08271E0BE;
      agent thread _id_8D8F7C8F7D567EB6();
      agent thread _id_3DDB4976DE9FB061();
      agent thread _id_120270BD0A747A35::_id_65F6A39E1083FB6B(agent, agent._id_CB61F2F08271E0BE, 1024, 1024, 1024);
      return;
    }

    agent._id_CB61F2F08271E0BE = [];
    _id_FE55D7604CEF0E3A = _id_7BB4716AC5C42F7C(team, _id_6C3FC29A5FD8751A);
    _id_1F48F987BA8392D0 = level._id_B747EE617515989A * 3;
    origin = getclosestpointonnavmesh(_id_FE55D7604CEF0E3A.origin + (randomfloatrange(_id_1F48F987BA8392D0 * -1.0, _id_1F48F987BA8392D0), randomfloatrange(_id_1F48F987BA8392D0 * -1.0, _id_1F48F987BA8392D0), 0));
    agent thread _id_120270BD0A747A35::_id_A5117518725DA028(agent, origin);
  }
}

_id_4C7945217F8ADFFA(agent, _id_6C3FC29A5FD8751A) {
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "team", agent.team);

  if(!isDefined(_id_6C3FC29A5FD8751A))
    _id_6C3FC29A5FD8751A = scripts\engine\utility::random(getarraykeys(level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_A2D0446BC9B000AB));

  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "laneKey", _id_6C3FC29A5FD8751A);
  level._id_3BF1CF107E60E048[agent.team][level._id_3BF1CF107E60E048[agent.team].size] = agent;
  agent._id_D0038B3CF5C426EB = 1;
  agent._id_5966903B1E0154E5 = 0;
  _id_53407127D58E754D = 0;

  foreach(team in level.teamnamelist) {
    foreach(_id_FF5B80567ACF9B98, struct in level._id_AE5271D2ED773311[team]) {
      if(scripts\engine\utility::array_contains(level._id_AE5271D2ED773311[team][_id_FF5B80567ACF9B98]._id_E2C31580F508B878, agent)) {
        level._id_AE5271D2ED773311[team][_id_FF5B80567ACF9B98]._id_E2C31580F508B878 = scripts\engine\utility::array_remove(level._id_AE5271D2ED773311[team][_id_FF5B80567ACF9B98]._id_E2C31580F508B878, agent);
        _id_53407127D58E754D = 1;
        break;
      }
    }

    if(_id_53407127D58E754D) {
      break;
    }
  }

  level._id_AE5271D2ED773311[agent.team][_id_6C3FC29A5FD8751A]._id_E2C31580F508B878[level._id_AE5271D2ED773311[agent.team][_id_6C3FC29A5FD8751A]._id_E2C31580F508B878.size] = agent;

  if(agent.team == "axis" || istrue(agent._id_76F8DDB1563464BD)) {
    body = undefined;
    head = undefined;
  } else {
    body = undefined;
    head = undefined;
    agent._id_76F8DDB1563464BD = 1;
  }

  _id_A664AAD02EE98BD2 = _id_371B4C2AB5861E62::_id_BA0801276542946B();
  grenadeammo = getdvarint("dvar_2E7CC22BEE3354DF", 1);
  agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(body, head, undefined, _id_A664AAD02EE98BD2, grenadeammo);
  _id_48814951E916AF89::_id_C9DAD3876B9D8755(agent, "gwtdm");
  agent._id_1544C20E168D97C0 = 10000;
  agent thread _id_DA90E4DD433678F9();
}

_id_642C7058D0A89B47(team) {
  _id_21AC360FE57642D6 = undefined;
  _id_4D6BD6D4C0E080B6 = undefined;

  foreach(_id_6C3FC29A5FD8751A, _id_A2D0446BC9B000AB in level._id_AE5271D2ED773311[team]) {
    count = _id_A2D0446BC9B000AB._id_E2C31580F508B878.size;

    if(!isDefined(_id_4D6BD6D4C0E080B6) || count < _id_4D6BD6D4C0E080B6) {
      _id_4D6BD6D4C0E080B6 = count;
      _id_21AC360FE57642D6 = _id_6C3FC29A5FD8751A;
    }
  }

  return _id_21AC360FE57642D6;
}

_id_B983381333B3881B(origin) {
  _id_62D0D46F9855096F = undefined;
  _id_42CA41C7DADAE0C0 = undefined;

  for(key = 0; key < level._id_33809C8A29CA064E.size; key++) {
    data = level._id_33809C8A29CA064E[key];

    for(_id_6C3FC29A5FD8751A = 0; _id_6C3FC29A5FD8751A < data._id_A2D0446BC9B000AB.size; _id_6C3FC29A5FD8751A++) {
      dist = distance2dsquared(data._id_A2D0446BC9B000AB[_id_6C3FC29A5FD8751A].origin, origin);

      if(!isDefined(_id_42CA41C7DADAE0C0) || dist < _id_42CA41C7DADAE0C0) {
        _id_42CA41C7DADAE0C0 = dist;
        _id_62D0D46F9855096F = _id_6C3FC29A5FD8751A;
      }
    }
  }

  return _id_62D0D46F9855096F;
}

_id_C9E5E3858AB1805F(agent) {
  _id_6C3FC29A5FD8751A = _id_642C7058D0A89B47(agent.team);
  _id_4C7945217F8ADFFA(agent, _id_6C3FC29A5FD8751A);
  agent._id_D6EB429048E1A4B5 = 1;
  success = _id_2DA93E2A35E2182F(agent, agent.team, level._id_048E03F24B9B5C1A, _id_6C3FC29A5FD8751A);

  if(!success) {
    agent._id_CB61F2F08271E0BE = _id_FF46CB0A3BC4B055(agent, agent.team, _id_6C3FC29A5FD8751A);
    agent thread _id_120270BD0A747A35::_id_65F6A39E1083FB6B(agent, agent._id_CB61F2F08271E0BE, 1024, 1024, 1024);
  }
}

_id_B744A1A8B7DABB6C(agent) {
  _id_6C3FC29A5FD8751A = _id_B983381333B3881B(agent.origin);
  _id_4C7945217F8ADFFA(agent, _id_6C3FC29A5FD8751A);
  agent._id_D6EB429048E1A4B5 = 1;
  success = _id_2DA93E2A35E2182F(agent, agent.team, level._id_048E03F24B9B5C1A, _id_6C3FC29A5FD8751A);

  if(!success) {
    agent._id_CB61F2F08271E0BE = _id_FF46CB0A3BC4B055(agent, agent.team, _id_6C3FC29A5FD8751A);
    agent thread _id_120270BD0A747A35::_id_65F6A39E1083FB6B(agent, agent._id_CB61F2F08271E0BE, 1024, 1024, 1024);
  }
}

_id_7E95BA18D5BF7855() {
  level._id_DF2344C49D981562 = [];
  level._id_DF2344C49D981562["allies"] = [];
  struct = spawnStruct();
  struct.body = "body_sp_ally_mex_sf_tier_1_1_1";
  struct.head = "head_sp_ally_mex_sf_tier_1_1_1";
  level._id_DF2344C49D981562["allies"][level._id_DF2344C49D981562["allies"].size] = struct;
  struct = spawnStruct();
  struct.body = "body_sp_ally_mex_sf_tier_1_2_1";
  struct.head = "head_sp_ally_mex_sf_tier_1_2_1";
  level._id_DF2344C49D981562["allies"][level._id_DF2344C49D981562["allies"].size] = struct;
  struct = spawnStruct();
  struct.body = "body_sp_ally_mex_sf_tier_1_3_1";
  struct.head = "head_sp_ally_mex_sf_tier_1_3_1";
  level._id_DF2344C49D981562["allies"][level._id_DF2344C49D981562["allies"].size] = struct;
  struct = spawnStruct();
  struct.body = "body_sp_ally_mex_sf_tier_1_4_1";
  struct.head = "head_sp_ally_mex_sf_tier_1_4_1";
  level._id_DF2344C49D981562["allies"][level._id_DF2344C49D981562["allies"].size] = struct;
}

_id_DA90E4DD433678F9() {
  self endon("death");

  for(;;) {
    waitframe();

    if(getdvarint("dvar_997720413AFA2A67", 0) == 0) {
      continue;
    }
    color = scripts\engine\utility::ter_op(self.team == "allies", (0, 0, 1), (1, 0, 0));
    level thread scripts\cp_mp\utility\debug_utility::drawsphere(self gettagorigin("j_spinelower"), 32, level.framedurationseconds, color);
  }
}

_id_8D8F7C8F7D567EB6() {
  self endon("death");

  for(;;) {
    waitframe();

    if(!isDefined(self._id_CB61F2F08271E0BE) || self._id_CB61F2F08271E0BE.size == 0) {
      break;
    }

    if(getdvarint("dvar_090FAA795702E8F9", 0) == 0) {
      continue;
    }
    startpos = self.origin;
    endpos = self._id_CB61F2F08271E0BE[0];
    level thread scripts\cp_mp\utility\debug_utility::drawline(startpos, endpos, level.framedurationseconds, (0, 1, 0));

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_CB61F2F08271E0BE.size - 1; _id_AC0E594AC96AA3A8++) {
      startpos = self._id_CB61F2F08271E0BE[_id_AC0E594AC96AA3A8];
      endpos = self._id_CB61F2F08271E0BE[_id_AC0E594AC96AA3A8 + 1];
      level thread scripts\cp_mp\utility\debug_utility::drawline(startpos, endpos, level.framedurationseconds, (1, 1, 0));
    }
  }
}

_id_3DDB4976DE9FB061() {
  self notify("rushOriginRemover");
  self endon("rushOriginRemover");
  self endon("death");

  for(;;) {
    self waittill("combatRushComplete");
    _id_CB61F2F08271E0BE = [];

    for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < self._id_CB61F2F08271E0BE.size; _id_AC0E594AC96AA3A8++)
      _id_CB61F2F08271E0BE[_id_CB61F2F08271E0BE.size] = self._id_CB61F2F08271E0BE[_id_AC0E594AC96AA3A8];

    self._id_CB61F2F08271E0BE = _id_CB61F2F08271E0BE;
  }
}

_id_6AD69DDD2454E5B3() {
  for(;;) {
    waitframe();
    _id_E9BF3955FA1125B5 = getdvarint("dvar_91B9C2673018ACCC", -1);
    _id_6C3FC29A5FD8751A = getdvarint("dvar_7FC4E6C8F23E5735", -1);

    if(_id_E9BF3955FA1125B5 == -1 || _id_6C3FC29A5FD8751A == -1) {
      continue;
    }
    setDvar("dvar_91B9C2673018ACCC", -1);
    setDvar("dvar_7FC4E6C8F23E5735", -1);

    foreach(team in level.teamnamelist) {
      _id_45D6F1C931BC6A8B = _id_3CAB19163F3E50D3(team, _id_E9BF3955FA1125B5, _id_6C3FC29A5FD8751A);
      _id_EB8DECD97308075C = _id_45D6F1C931BC6A8B[randomint(_id_45D6F1C931BC6A8B.size)].origin;
      groupname = _id_48814951E916AF89::_id_78759441C259F58A(_id_EB8DECD97308075C);
      numagents = 5;
      _id_CF2FF249C028B242 = _id_48814951E916AF89::_id_AB14D6652E44FDA0(numagents, undefined, level._id_C7A4725D05BB7F22, "gwtdm");
      _id_CF2FF249C028B242._id_083C3368707C68E6 = "Helicopter";
      _id_0B58631347B6AB04 = _id_2BC0B0102F9B7751::_id_03779DEB97B61A65(numagents, _id_EB8DECD97308075C, "medium", "everybody", "captureAgents", groupname, team, 0, undefined, undefined, undefined, _id_CF2FF249C028B242, 1, 1);

      foreach(agent in _id_0B58631347B6AB04)
      _id_4C7945217F8ADFFA(agent, _id_6C3FC29A5FD8751A);
    }
  }
}

_id_6B1CBD26D1B252B4(_id_34CE337E073A0C34, _id_93390A6953905FEF, team) {
  _id_4F922AF45D0CAC6C = undefined;

  if(0)
    level thread scripts\mp\utility\debug::drawsphere(_id_34CE337E073A0C34, 32, 60, (1, 1, 1));

  closestpoint = pointonsegmentnearesttopoint(level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_B027D6857AB9D713, level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_014E33FB843CA741, _id_34CE337E073A0C34);

  if(0)
    level thread scripts\mp\utility\debug::drawsphere(closestpoint, 32, 60, (0, 1, 1));

  _id_4F922AF45D0CAC6C = sortbydistance(level._id_B6D8EEC09E6F3C63._id_4F922AF45D0CAC6C, closestpoint);
  _id_581C052B571D00A6 = 5;

  if(istrue(_id_93390A6953905FEF))
    _id_581C052B571D00A6 = 1;

  _id_7127E3E9D3A5BA23 = [];

  foreach(loc in _id_4F922AF45D0CAC6C) {
    if(_id_7127E3E9D3A5BA23.size == _id_581C052B571D00A6) {
      break;
    }

    if(scripts\mp\outofbounds::ispointinoutofbounds(loc.origin, team)) {
      continue;
    }
    _id_54EE4011E4C0877E = vectorNormalize(level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A].origin - loc.origin);

    if(vectordot(level.spawnselectionteamforward[team], _id_54EE4011E4C0877E) < 0) {
      continue;
    }
    _id_0CC6CE1CC9644A2A = pointonsegmentnearesttopoint(level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_B027D6857AB9D713, level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_014E33FB843CA741, loc.origin);
    _id_636C8575D7A7768B = getdvarint("dvar_8EA81D61879B569F", 3000);
    _id_4F0FC1C36324AFFB = _id_636C8575D7A7768B * _id_636C8575D7A7768B;
    distsq = distance2dsquared(loc.origin, _id_0CC6CE1CC9644A2A);

    if(distsq < _id_4F0FC1C36324AFFB) {
      if(0) {
        level thread scripts\mp\utility\debug::drawsphere(loc.origin, 32, 60, (1, 0, 0));
        level thread scripts\mp\utility\debug::drawline(_id_0CC6CE1CC9644A2A, loc.origin, 60, (1, 0, 0));
      }

      continue;
    } else {
      if(0) {
        level thread scripts\mp\utility\debug::drawsphere(loc.origin, 32, 60, (0, 1, 0));
        level thread scripts\mp\utility\debug::drawline(_id_0CC6CE1CC9644A2A, loc.origin, 60, (0, 1, 0));
      }

      _id_7127E3E9D3A5BA23[_id_7127E3E9D3A5BA23.size] = loc;
    }
  }

  if(!istrue(level._id_85E83F382AEDC103))
    _id_7127E3E9D3A5BA23 = scripts\engine\utility::array_randomize(_id_7127E3E9D3A5BA23);

  _id_29376CACC64CC4E6 = _id_2BC0B0102F9B7751::_id_321665DCDCBF401E(_id_7127E3E9D3A5BA23, _id_34CE337E073A0C34);

  if(isDefined(_id_29376CACC64CC4E6))
    return _id_29376CACC64CC4E6;

  _id_29376CACC64CC4E6 = _id_2BC0B0102F9B7751::_id_321665DCDCBF401E(_id_4F922AF45D0CAC6C, _id_34CE337E073A0C34, _id_581C052B571D00A6);

  if(isDefined(_id_29376CACC64CC4E6))
    return _id_29376CACC64CC4E6;

  return undefined;
}

_id_5CD456D9B2CDC538(agent, attacker) {
  if(isDefined(attacker) && isDefined(attacker.owner))
    attacker = attacker.owner;

  team = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "team");

  if(isPlayer(attacker) && !isagent(attacker) && attacker.team != team) {
    scripts\mp\gamescore::giveteamscoreforobjective(attacker.team, level._id_55328518D6FB7D07, 0);

    if(getdvarint("dvar_2E405E2912DC4A44", 0) == 1)
      attacker thread scripts\mp\rank::scoreeventpopup(_func_2EF675C13CA1C4AF("stat_2C8BCBB02EC7FF9B", level._id_55328518D6FB7D07));

    attacker scripts\mp\utility\stats::incpersstat("contribution", level._id_55328518D6FB7D07);
    attacker scripts\mp\utility\stats::setextrascore0(attacker.pers["contribution"]);

    if(isPlayer(attacker)) {
      _id_4DA4CB52D0BF5B05 = 0;
      _id_4DA4CB52D0BF5B05 = _id_4DA4CB52D0BF5B05 + 2;
      _id_4DA4CB52D0BF5B05 = _id_4DA4CB52D0BF5B05 + (level._id_55328518D6FB7D07 << 4);
      attacker _id_0FD32F08E72B657F::_id_0417749E099F041F(_id_4DA4CB52D0BF5B05, -1);
    }
  }

  _id_6C3FC29A5FD8751A = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "laneKey");

  if(!isDefined(_id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "laneKey")) || !scripts\mp\utility\teams::isgameplayteam(team)) {
    return;
  }
  level._id_AE5271D2ED773311[team][_id_6C3FC29A5FD8751A]._id_E2C31580F508B878 = scripts\engine\utility::array_remove(level._id_AE5271D2ED773311[team][_id_6C3FC29A5FD8751A]._id_E2C31580F508B878, agent);
}

_id_848D0782943B416D(team) {
  _id_D5E5D93F3A939362 = getdvarint("dvar_A190ADDB512EC71A", 2);
  _id_C0E1F16535E4FA15 = getdvarint("dvar_60235D2AE0550BC5", 6);
  _id_68299821AD1626E0 = getdvarint("dvar_BAD4B491469253EF", 30) * 1000;
  _id_DB6AF0A1C5DB4E1F = getdvarint("dvar_289D6DA5E0AFF476", 1);
  _id_35C0E0D47EA5452F = "gw_fob_" + team + "HQ";
  _id_B5B1784D5A1327C7 = "spawnHQ_" + team;
  _id_48814951E916AF89::_id_BA4022744DCE59F6(_id_B5B1784D5A1327C7, int(level._id_72E8A99508B7BE1B * 1.5));
  _id_C9189FF5D2E5AF61(team, _id_DB6AF0A1C5DB4E1F, _id_C0E1F16535E4FA15);
  wait(getdvarfloat("dvar_EB2244B6B2A89169", 15));

  for(;;) {
    wait 5.0;
    currenttime = gettime();

    if(!_id_48814951E916AF89::_id_8C6DBB64C8E1603C(_id_D5E5D93F3A939362)) {
      continue;
    }
    foreach(_id_6C3FC29A5FD8751A, _id_A2D0446BC9B000AB in level._id_AE5271D2ED773311[team]) {
      if(_id_A2D0446BC9B000AB._id_E2C31580F508B878.size >= _id_A2D0446BC9B000AB._id_83CF1C64372DCCA5 - 1) {
        continue;
      }
      success = 0;

      if(_id_DB6AF0A1C5DB4E1F && (currenttime > _id_A2D0446BC9B000AB._id_8E55C5943A080A2E + _id_68299821AD1626E0 || _id_A2D0446BC9B000AB._id_8E55C5943A080A2E == 0)) {
        success = level _id_33D2A7321A928B5A(_id_C0E1F16535E4FA15, team, level._id_048E03F24B9B5C1A, _id_6C3FC29A5FD8751A);

        if(success)
          _id_A2D0446BC9B000AB._id_8E55C5943A080A2E = currenttime;
      }

      if(!success)
        level _id_21B7E8662F68614D(_id_D5E5D93F3A939362, team, _id_6C3FC29A5FD8751A);
    }
  }
}

_id_C9189FF5D2E5AF61(team, _id_DB6AF0A1C5DB4E1F, _id_C0E1F16535E4FA15) {
  scripts\mp\gamelogic::waitforplayers(level.prematchperiod, 0, 0);
  _id_5FB0D98B1B6F539D = 1;

  if(getdvarint("dvar_3D8FBE08639DA15A", 1) == 0)
    _id_5FB0D98B1B6F539D = 0;

  _id_7E85664E3CBFAB82 = scripts\engine\utility::ter_op(_id_DB6AF0A1C5DB4E1F && _id_5FB0D98B1B6F539D, 0, 1);
  _id_D17108F1E24B0868 = !level._id_FA789E7BAB605E4C;

  if(_id_7E85664E3CBFAB82 && _id_D17108F1E24B0868) {
    return;
  }
  _id_6749AB538EC0DDEB = 0;

  if(getdvarint("scr_game_infilSkip", 0) == 1)
    _id_6749AB538EC0DDEB = 12;

  _id_50BA4037BBD61CFF = 20 - _id_6749AB538EC0DDEB;
  _id_3768F1B2936AF69E = level.prematchperiodend - _id_50BA4037BBD61CFF;
  _id_3768F1B2936AF69E = scripts\engine\utility::ter_op(_id_3768F1B2936AF69E > 0, _id_3768F1B2936AF69E, 0);
  _id_A1D84737EC0B465D = 20 - _id_6749AB538EC0DDEB;
  _id_488A1360DA4E442A = level.prematchperiodend - _id_A1D84737EC0B465D;
  _id_488A1360DA4E442A = scripts\engine\utility::ter_op(_id_488A1360DA4E442A > 0, _id_488A1360DA4E442A, 0);

  for(_id_3B5803E733581858 = 0; !_id_7E85664E3CBFAB82 || !_id_D17108F1E24B0868; _id_3B5803E733581858++) {
    if(!_id_7E85664E3CBFAB82 && _id_3B5803E733581858 >= _id_3768F1B2936AF69E) {
      foreach(_id_6C3FC29A5FD8751A, _id_A2D0446BC9B000AB in level._id_AE5271D2ED773311[team])
      level thread _id_E3CA5378E0F544C3(team, _id_A2D0446BC9B000AB, _id_6C3FC29A5FD8751A, _id_C0E1F16535E4FA15);

      _id_7E85664E3CBFAB82 = 1;
    }

    if(!_id_D17108F1E24B0868 && _id_3B5803E733581858 >= _id_488A1360DA4E442A) {
      _id_93E7D3696CAA5331(10, level._id_048E03F24B9B5C1A, team);
      _id_D17108F1E24B0868 = 1;
    }

    wait 1;
  }
}

_id_EE0AA2C35417D524(team, _id_A2D0446BC9B000AB, _id_6C3FC29A5FD8751A) {
  _id_0E332FE633C8498B = 2;
  _id_5AE2EDE5B9D14341 = 0;
  _id_BA591582396EC120 = int(_id_A2D0446BC9B000AB._id_83CF1C64372DCCA5 / 2);

  while(_id_5AE2EDE5B9D14341 < _id_BA591582396EC120) {
    _id_2245633B901F80E1 = _id_0E332FE633C8498B;

    if(_id_5AE2EDE5B9D14341 + _id_0E332FE633C8498B > _id_BA591582396EC120)
      _id_2245633B901F80E1 = _id_BA591582396EC120 - _id_5AE2EDE5B9D14341;

    level _id_21B7E8662F68614D(_id_2245633B901F80E1, team, _id_6C3FC29A5FD8751A);
    _id_5AE2EDE5B9D14341 = _id_5AE2EDE5B9D14341 + _id_2245633B901F80E1;
    wait(randomfloatrange(2.5, 4));
  }
}

_id_E3CA5378E0F544C3(team, _id_A2D0446BC9B000AB, _id_6C3FC29A5FD8751A, _id_C0E1F16535E4FA15) {
  _id_BA591582396EC120 = int(_id_A2D0446BC9B000AB._id_83CF1C64372DCCA5 / 4);
  _id_7A155FEA3B7B30DC = _id_BA591582396EC120 / _id_C0E1F16535E4FA15;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_7A155FEA3B7B30DC; _id_AC0E594AC96AA3A8++) {
    wait(randomfloatrange(1, 3) + (_id_6C3FC29A5FD8751A + 2) * 2);
    level _id_33D2A7321A928B5A(_id_C0E1F16535E4FA15, team, level._id_048E03F24B9B5C1A, _id_6C3FC29A5FD8751A);
  }
}

_id_21B7E8662F68614D(numagents, team, _id_6C3FC29A5FD8751A) {
  if(level.usespawnselection) {
    _id_35C0E0D47EA5452F = "gw_fob_" + team + "HQ";
    _id_FD5EA9CB37C309D3 = level.spawnselectionlocations[_id_35C0E0D47EA5452F][team].spawnpoints;
    _id_B5B1784D5A1327C7 = "spawnHQ_" + team;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < numagents; _id_AC0E594AC96AA3A8++) {
      aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB(undefined, undefined, "gwtdm", undefined, level._id_C7A4725D05BB7F22, level._id_72F834B3F8B2A366[team]);
      agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, _id_FD5EA9CB37C309D3[_id_AC0E594AC96AA3A8].origin, _id_FD5EA9CB37C309D3[_id_AC0E594AC96AA3A8].angles, "medium", _id_B5B1784D5A1327C7, undefined, undefined, team, undefined, undefined, 1);

      if(isDefined(agent)) {
        _id_4C7945217F8ADFFA(agent, _id_6C3FC29A5FD8751A);
        success = _id_2DA93E2A35E2182F(agent, team, level._id_048E03F24B9B5C1A, _id_6C3FC29A5FD8751A);

        if(!success) {
          agent._id_CB61F2F08271E0BE = _id_FF46CB0A3BC4B055(agent, team, _id_6C3FC29A5FD8751A);
          agent thread _id_8D8F7C8F7D567EB6();
          agent thread _id_3DDB4976DE9FB061();
          agent thread _id_120270BD0A747A35::_id_65F6A39E1083FB6B(agent, agent._id_CB61F2F08271E0BE, 1024, 1024, 1024);
        }
      }
    }
  } else if(level._id_C7A4725D05BB7F22 == 1 && !level._id_7232D887DBDA3729 || level._id_C7A4725D05BB7F22 == 2 && !level._id_7232D587DBDA3090) {
    if(!level._id_AD7B64F93B499EDB) {
      return;
    }
    players = scripts\mp\utility\teams::getteamdata(team, "players");

    if(players.size > 0) {
      spawnpoint = players[0] getspawnpointforplayer();

      if(isDefined(spawnpoint)) {
        aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB(undefined, undefined, "gwtdm", undefined, level._id_C7A4725D05BB7F22, level._id_72F834B3F8B2A366[team]);
        agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, spawnpoint.origin, spawnpoint.angles, "medium", "spawnHQ_" + team, undefined, undefined, team, undefined, undefined, 1);

        if(isDefined(agent)) {
          _id_4C7945217F8ADFFA(agent, _id_6C3FC29A5FD8751A);
          success = _id_2DA93E2A35E2182F(agent, team, level._id_048E03F24B9B5C1A, _id_6C3FC29A5FD8751A);

          if(!success) {
            agent._id_CB61F2F08271E0BE = _id_FF46CB0A3BC4B055(agent, team, _id_6C3FC29A5FD8751A);
            agent thread _id_8D8F7C8F7D567EB6();
            agent thread _id_3DDB4976DE9FB061();
            agent thread _id_120270BD0A747A35::_id_65F6A39E1083FB6B(agent, agent._id_CB61F2F08271E0BE, 1024, 1024, 1024);
            return;
          }

          return;
        }

        return;
      }

      return;
    }
  } else if(istrue(level._id_EE41A5AAF764C9CC)) {
    players = scripts\mp\utility\teams::getteamdata(team, "players");

    if(!isDefined(players) || players.size == 0) {
      return;
    }
    _id_31FF7305890A6EF2 = getdvarint("dvar_A66B78681B2D0805", 4096);
    _id_629E5FE2F6B337FA = [];
    _id_629E5FE2F6B337FA["teamForward"] = level.spawnselectionteamforward[team];
    _id_629E5FE2F6B337FA["idealDistSq"] = _id_31FF7305890A6EF2 * _id_31FF7305890A6EF2;
    scripts\mp\spawnlogic::activatespawnset(level._id_AD9CAE795E7505C6[team], 1);
    spawnpoint = players[0] scripts\mp\spawnlogic::getspawnpoint(players[0], team, level._id_AD9CAE795E7505C6[team], undefined, undefined, _id_629E5FE2F6B337FA);

    if(isDefined(spawnpoint)) {
      aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB(undefined, undefined, "gwtdm", undefined, level._id_C7A4725D05BB7F22, level._id_72F834B3F8B2A366[team]);
      agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, spawnpoint.origin, spawnpoint.angles, "medium", "spawnHQ_" + team, undefined, undefined, team, undefined, undefined, 1);

      if(isDefined(agent)) {
        _id_4C7945217F8ADFFA(agent, _id_6C3FC29A5FD8751A);
        success = _id_2DA93E2A35E2182F(agent, team, level._id_048E03F24B9B5C1A, _id_6C3FC29A5FD8751A);

        if(!success) {
          agent._id_CB61F2F08271E0BE = _id_FF46CB0A3BC4B055(agent, team, _id_6C3FC29A5FD8751A);
          agent thread _id_8D8F7C8F7D567EB6();
          agent thread _id_3DDB4976DE9FB061();
          agent thread _id_120270BD0A747A35::_id_65F6A39E1083FB6B(agent, agent._id_CB61F2F08271E0BE, 1024, 1024, 1024);
          return;
        }

        return;
      }

      return;
    }
  } else {
    spawnpoint = _id_0277456E766F73B0(team, _id_6C3FC29A5FD8751A);
    heading = vectortoangles(level.spawnselectionteamforward[team]);
    agents = level _id_640CF1641C03E2A0::_id_55AB9C6DA96226E7(numagents, spawnpoint.origin, undefined, undefined, "medium", "spawnHQ_" + team, "debug", team, undefined, undefined, heading, ::_id_B744A1A8B7DABB6C, 1, 1, level._id_C7A4725D05BB7F22);
  }
}

_id_33D2A7321A928B5A(numagents, team, _id_E9BF3955FA1125B5, _id_6C3FC29A5FD8751A) {
  _id_FE55D7604CEF0E3A = _id_7BB4716AC5C42F7C(team, _id_6C3FC29A5FD8751A);
  groupname = _id_48814951E916AF89::_id_78759441C259F58A(_id_FE55D7604CEF0E3A.origin, numagents);
  _id_CF2FF249C028B242 = _id_48814951E916AF89::_id_AB14D6652E44FDA0(numagents, undefined, level._id_C7A4725D05BB7F22, "gwtdm");
  _id_CF2FF249C028B242._id_083C3368707C68E6 = "Helicopter";
  _id_0B58631347B6AB04 = _id_2BC0B0102F9B7751::_id_03779DEB97B61A65(numagents, _id_FE55D7604CEF0E3A.origin, "medium", "everybody", "captureAgents", groupname, team, 0, undefined, undefined, undefined, _id_CF2FF249C028B242, 1, 1);

  if(!isDefined(_id_0B58631347B6AB04))
    return 0;

  foreach(agent in _id_0B58631347B6AB04) {
    _id_4C7945217F8ADFFA(agent, _id_6C3FC29A5FD8751A);
    agent._id_2BAFFEF526C6DD6C = 1;
    _id_2AA208E2058474E5(agent, agent.team, _id_6C3FC29A5FD8751A);
  }

  return 1;
}

_id_02F5B6C628445768(_id_3F6FD6EDAF6C6713) {
  if(!isDefined(level._id_AE5271D2ED773311)) {
    return;
  }
  level thread _id_AC93EBB80902A467();

  foreach(team in level.teamnamelist) {
    level._id_3BF1CF107E60E048[team] = [];
    level._id_9DE3C802FCED05E2[team] = [];
    level thread _id_C1313BF26D803678(team);

    if(team == _id_3F6FD6EDAF6C6713)
      level thread _id_7A98EA2F74BA9607(team);
    else
      level thread _id_16B67172A4F3C6F8(team);

    foreach(_id_6C3FC29A5FD8751A, _id_A2D0446BC9B000AB in level._id_AE5271D2ED773311[team]) {
      _id_A2D0446BC9B000AB._id_F76E10D4DCE6C204 = _id_3CAB19163F3E50D3(team, level._id_048E03F24B9B5C1A, _id_6C3FC29A5FD8751A);

      foreach(agent in _id_A2D0446BC9B000AB._id_E2C31580F508B878) {
        if(istrue(agent._id_5966903B1E0154E5)) {
          level._id_9DE3C802FCED05E2[team][level._id_9DE3C802FCED05E2[team].size] = agent;
          agent._id_D0038B3CF5C426EB = 0;
          agent._id_5966903B1E0154E5 = 1;
          agent._id_A8A165C3323BDA48 = 0;
        } else {
          level._id_3BF1CF107E60E048[team][level._id_3BF1CF107E60E048[team].size] = agent;
          agent._id_D0038B3CF5C426EB = 1;
          agent._id_5966903B1E0154E5 = 0;
          agent._id_A8A165C3323BDA48 = 0;
        }

        if(istrue(agent._id_D0640290E2529307)) {
          continue;
        }
        if(!isalive(agent)) {
          continue;
        }
        agent thread _id_2AA208E2058474E5(agent, team, _id_6C3FC29A5FD8751A);
      }
    }
  }
}

_id_2AA208E2058474E5(agent, team, _id_6C3FC29A5FD8751A) {
  agent endon("death");

  if(!isalive(agent)) {
    return;
  }
  if(!isDefined(agent)) {
    return;
  }
  if(!isDefined(team))
    team = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "team");

  if(!isDefined(_id_6C3FC29A5FD8751A))
    _id_6C3FC29A5FD8751A = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "laneKey");

  if(!isDefined(team) || !isDefined(_id_6C3FC29A5FD8751A)) {
    return;
  }
  if(isDefined(agent._id_B8D7C82B53E74B77) && agent._id_B8D7C82B53E74B77 > 0)
    wait(agent._id_B8D7C82B53E74B77 + 1);

  success = _id_2DA93E2A35E2182F(agent, team, level._id_048E03F24B9B5C1A, _id_6C3FC29A5FD8751A);

  if(!success) {
    _id_CB61F2F08271E0BE = _id_FF46CB0A3BC4B055(agent, team, _id_6C3FC29A5FD8751A);

    if(_id_CB61F2F08271E0BE.size > 0) {
      agent._id_CB61F2F08271E0BE = _id_CB61F2F08271E0BE;
      agent thread _id_8D8F7C8F7D567EB6();
      agent thread _id_3DDB4976DE9FB061();
      agent thread _id_120270BD0A747A35::_id_65F6A39E1083FB6B(agent, agent._id_CB61F2F08271E0BE, 1024, 1024, 1024);
    } else {
      agent._id_CB61F2F08271E0BE = [];
      _id_FE55D7604CEF0E3A = _id_7BB4716AC5C42F7C(team, _id_6C3FC29A5FD8751A);
      origin = getclosestpointonnavmesh(_id_FE55D7604CEF0E3A.origin + (randomfloatrange(level._id_B747EE617515989A * -1.0, level._id_B747EE617515989A), randomfloatrange(level._id_B747EE617515989A * -1.0, level._id_B747EE617515989A), 0));
      agent thread _id_120270BD0A747A35::_id_A5117518725DA028(agent, origin, 1024, 1024, 1024, undefined, undefined, undefined, _id_120270BD0A747A35::_id_8DAD0C97C82FB52F);
    }
  }
}

_id_55C73DA3BC1275F7(agent) {
  if(getdvarint("dvar_6243EE712B007B0B", 0) == 1) {
    return;
  }
  agent endon("death");
  agent notify("killStallWatcher");
  agent endon("killStallWatcher");
  _id_ADD5ABB5C54D762F = 0;
  _id_B4EA66BC0E9FA1E9 = undefined;

  for(;;) {
    wait 0.5;
    dist = distance2dsquared(agent._id_99F2752B6513C9DD.origin, agent.origin);

    if(dist < 65536) {
      if(!isDefined(_id_B4EA66BC0E9FA1E9))
        _id_B4EA66BC0E9FA1E9 = dist;
      else if(abs(_id_B4EA66BC0E9FA1E9 - dist) < 4096) {
        _id_ADD5ABB5C54D762F++;
        _id_B4EA66BC0E9FA1E9 = dist;
      } else
        _id_ADD5ABB5C54D762F = 0;
    } else
      _id_ADD5ABB5C54D762F = 0;

    if(_id_ADD5ABB5C54D762F >= 3) {
      agent thread _id_FD1EF087D4A56D19(agent, agent.team);
      agent notify("killStallWatcher");
    }
  }
}

_id_7E904C73621A47D1(agent, time) {
  agent endon("death");

  for(_id_3B5803E733581858 = 0; _id_3B5803E733581858 < time; _id_3B5803E733581858++) {
    thread scripts\mp\utility\debug::drawsphere(agent.origin, 128, 1, (0, 1, 1));
    wait 1;
  }
}

_id_7A98EA2F74BA9607(team) {
  _id_3E38EE41DC326FDC = "cap_bark_orders";
  animset = "caps/common/cap_bark_orders_advance";

  foreach(_id_6C3FC29A5FD8751A, _id_A2D0446BC9B000AB in level._id_AE5271D2ED773311[team]) {
    agents = scripts\engine\utility::array_randomize(_id_A2D0446BC9B000AB._id_E2C31580F508B878);
    _id_6AA514CFD79E469F = 6;
    _id_8D02514CCC3F1FB8 = 0;
    origin = _id_4D65C1597EC31547(agents);

    if(isDefined(origin))
      playsoundatpos(origin, "mp_walla_invasion_charge_group");

    foreach(agent in agents) {
      if(_id_8D02514CCC3F1FB8 >= _id_6AA514CFD79E469F) {
        break;
      }

      if(!_id_8CC95623D93D70FB(agent)) {
        continue;
      }
      _id_8D02514CCC3F1FB8++;
      agent thread _id_0B1FF81F9E48F070(agent, agent.origin, _id_3E38EE41DC326FDC, animset, undefined, undefined, "mp_walla_invasion_charge_individual");
    }
  }
}

_id_16B67172A4F3C6F8(team) {
  _id_3E38EE41DC326FDC = "cap_bark_orders";
  animset = "caps/common/cap_bark_orders_fallback";

  foreach(_id_6C3FC29A5FD8751A, _id_A2D0446BC9B000AB in level._id_AE5271D2ED773311[team]) {
    agents = scripts\engine\utility::array_randomize(_id_A2D0446BC9B000AB._id_E2C31580F508B878);
    _id_B99BFD1384485E2D = 6;
    _id_7869ED48E794554E = 0;
    _id_E20187343CEA1130 = 3;
    _id_1303886FACE0EC6F = 0;
    origin = _id_4D65C1597EC31547(agents);

    if(isDefined(origin))
      playsoundatpos(origin, "mp_walla_invasion_retreat_group");

    foreach(agent in agents) {
      if(!_id_8CC95623D93D70FB(agent)) {
        continue;
      }
      if(_id_7869ED48E794554E < _id_B99BFD1384485E2D) {
        _id_7869ED48E794554E++;
        agent thread _id_0B1FF81F9E48F070(agent, agent.origin, _id_3E38EE41DC326FDC, animset);
        continue;
      }

      if(_id_1303886FACE0EC6F < _id_E20187343CEA1130) {
        _id_1303886FACE0EC6F++;
        _id_B1458F8ADB57F733(agent);
        continue;
      }
    }
  }
}

_id_B34021CA662A03BD() {
  level endon("game_ended");

  if(getdvarint("dvar_EFA65DEF009DE58C", 0) == 1) {
    return;
  }
  _id_4DEE2F3ECB36D88A = getdvarint("dvar_FBC6C90A51E19CFA", 10);
  _id_A74D259A91A5635C = getdvarint("dvar_726C19967A7EB54C", 33);
  _id_96FA696D3E52E34F = getdvarint("dvar_13411E313136639F", 33);
  _id_BB833FE37B1C8283 = getdvarint("dvar_1818A2DF93845813", 33);
  _id_EB6F2E9E793E992E = _id_4DEE2F3ECB36D88A + _id_A74D259A91A5635C + _id_96FA696D3E52E34F + _id_BB833FE37B1C8283;

  while(!scripts\mp\flags::gameflag("prematch_done"))
    waitframe();

  wait 30;
  _id_27DF2F3E1070DC7C = 0;
  _id_F17CE0AB9390041E = 0;
  _id_6E8F659DFACD2391 = 1;
  _id_8284343D0FF94CC6 = undefined;

  for(;;) {
    _id_9C5B939810814304 = 0;
    _id_D7C42E70083DF35D = -1;
    _id_AFC2F18CDAA6C9CC = level.players;

    while(!_id_9C5B939810814304 && _id_AFC2F18CDAA6C9CC.size > 0) {
      _id_D7C42E70083DF35D = randomint(_id_AFC2F18CDAA6C9CC.size);

      if(isDefined(_id_AFC2F18CDAA6C9CC[_id_D7C42E70083DF35D]) && isalive(_id_AFC2F18CDAA6C9CC[_id_D7C42E70083DF35D])) {
        _id_9C5B939810814304 = 1;
        break;
      } else
        _id_AFC2F18CDAA6C9CC[_id_D7C42E70083DF35D] = undefined;

      if(_id_AFC2F18CDAA6C9CC.size <= 0) {
        wait 1;
        _id_AFC2F18CDAA6C9CC = level.players;
      }
    }

    playerteam = undefined;

    if(_id_D7C42E70083DF35D > -1) {
      _id_8284343D0FF94CC6 = sortbydistance(level.agentarray, _id_AFC2F18CDAA6C9CC[_id_D7C42E70083DF35D].origin);
      playerteam = _id_AFC2F18CDAA6C9CC[_id_D7C42E70083DF35D].team;
      _id_AFC2F18CDAA6C9CC[_id_D7C42E70083DF35D] = undefined;
    }

    success = 0;

    foreach(agent in _id_8284343D0FF94CC6) {
      if(_id_8CC95623D93D70FB(agent) && isDefined(playerteam) && agent.team == playerteam && (!isDefined(agent._id_07698B3F1E3D199C) || isDefined(agent._id_07698B3F1E3D199C) && agent._id_07698B3F1E3D199C < gettime() + 10000)) {
        agent._id_07698B3F1E3D199C = gettime();
        roll = randomint(_id_EB6F2E9E793E992E);

        if(roll <= _id_4DEE2F3ECB36D88A && isDefined(agent.enemy))
          agent thread _id_727CDA5EF2AE887D(agent);
        else if(roll <= _id_4DEE2F3ECB36D88A + _id_A74D259A91A5635C)
          agent thread _id_B1458F8ADB57F733(agent);
        else if(roll <= _id_4DEE2F3ECB36D88A + _id_A74D259A91A5635C + _id_96FA696D3E52E34F)
          agent thread _id_0B1FF81F9E48F070(agent, agent.origin, "cap_bark_orders", "caps/common/cap_bark_orders_advance");
        else
          agent thread _id_0B1FF81F9E48F070(agent, agent.origin, "cap_bark_orders", "caps/common/cap_bark_orders_fallback");

        success = 1;
      }

      if(success) {
        _id_27DF2F3E1070DC7C++;
        wait 5;
        break;
      } else {
        _id_F17CE0AB9390041E++;

        if(_id_F17CE0AB9390041E >= 5) {
          _id_F17CE0AB9390041E = 0;
          waitframe();
        }
      }
    }

    if(!success || _id_27DF2F3E1070DC7C >= 5) {
      _id_AFC2F18CDAA6C9CC = level.players;
      wait 5;
    }
  }
}

_id_AC93EBB80902A467() {
  foreach(agent in level.agentarray) {
    if(!_id_8CC95623D93D70FB(agent)) {
      continue;
    }
    if(!istrue(agent._id_416835640E8C55CD)) {
      continue;
    }
    if(!agent asmhasstate(agent.asmname, "choose_long_death")) {
      continue;
    }
    agent._id_37C05513D2997AB4 = 1;
    agent._id_416835640E8C55CD = 0;
    agent._id_1544C20E168D97C0 = 5000;
    agent thread _id_727CDA5EF2AE887D(agent);
    wait(randomfloatrange(2, 3));
  }
}

_id_8CC95623D93D70FB(agent) {
  if(!isalive(agent))
    return 0;

  if(isDefined(agent.vehicle_position) && isint(agent.vehicle_position))
    return 0;

  if(istrue(agent._id_37C05513D2997AB4))
    return 0;

  if(isDefined(agent.landing_spot))
    return 0;

  if(agent isinscriptedstate())
    return 0;

  if(istrue(agent.doinglongdeath))
    return 0;

  if(isDefined(agent _meth_92435C7A6AE85C3C()))
    return 0;

  if(!agent isonornearstairs())
    return 0;

  _id_00D5A54D862AACC2 = agent getnearbynegotiationinfo(32);

  if(isDefined(_id_00D5A54D862AACC2))
    return 0;

  if(agent.asmname != agent._id_A942DD31D55102C9)
    return 0;

  return 1;
}

_id_0B1FF81F9E48F070(agent, origin, _id_3E38EE41DC326FDC, animset, _id_CD40AC65A2951F58, _id_CD63C265A2BB9772, _id_20AA66E7DD98FB53) {
  agent endon("death");

  if(!isDefined(_id_CD40AC65A2951F58))
    _id_CD40AC65A2951F58 = 0.1;

  if(!isDefined(_id_CD63C265A2BB9772))
    _id_CD63C265A2BB9772 = 2;

  agent._id_B8D7C82B53E74B77 = randomfloatrange(_id_CD40AC65A2951F58, _id_CD63C265A2BB9772);
  wait(agent._id_B8D7C82B53E74B77);
  agent._id_B8D7C82B53E74B77 = -1;

  if(!_id_8CC95623D93D70FB(agent)) {
    return;
  }
  agent thread _id_010B6724C15A95E8::_id_B58F0A57ADF2948E(origin, _id_3E38EE41DC326FDC, animset, 1);

  if(isDefined(_id_20AA66E7DD98FB53))
    playsoundatpos(agent.origin, _id_20AA66E7DD98FB53);
}

_id_B1458F8ADB57F733(agent, _id_43730F07D9C240E6, _id_9B57BD8D7F3D4E6A, _id_CD40AC65A2951F58, _id_CD63C265A2BB9772) {
  agent endon("death");

  if(!isDefined(_id_CD40AC65A2951F58))
    _id_CD40AC65A2951F58 = 0.1;

  if(!isDefined(_id_CD63C265A2BB9772))
    _id_CD63C265A2BB9772 = 2;

  if(!isDefined(_id_43730F07D9C240E6))
    _id_43730F07D9C240E6 = 1;

  agent._id_B8D7C82B53E74B77 = randomfloatrange(_id_CD40AC65A2951F58, _id_CD63C265A2BB9772);
  wait(agent._id_B8D7C82B53E74B77);
  agent._id_B8D7C82B53E74B77 = -1;

  if(!_id_8CC95623D93D70FB(agent)) {
    return;
  }
  _id_7E7FD8191BD7BE26::_id_21BD6A8C4766AD5A(agent, _id_43730F07D9C240E6, _id_9B57BD8D7F3D4E6A);
}

_id_727CDA5EF2AE887D(agent, _id_EC2EBFC4CC6BFFC1, _id_CD40AC65A2951F58, _id_CD63C265A2BB9772) {
  agent endon("death");

  if(!isDefined(_id_CD40AC65A2951F58))
    _id_CD40AC65A2951F58 = 1;

  if(!isDefined(_id_CD63C265A2BB9772))
    _id_CD63C265A2BB9772 = 4;

  agent._id_B8D7C82B53E74B77 = randomfloatrange(_id_CD40AC65A2951F58, _id_CD63C265A2BB9772);
  wait(agent._id_B8D7C82B53E74B77);
  agent._id_B8D7C82B53E74B77 = -1;

  if(!_id_8CC95623D93D70FB(agent)) {
    return;
  }
  if(agent asmhasstate(agent.asmname, "choose_long_death"))
    _id_7E7FD8191BD7BE26::_id_63C85AB9240382F7(agent, _id_EC2EBFC4CC6BFFC1);
}

_id_C771A77BF1F4D2C1() {
  if(level.prematchperiodend > 0)
    level waittill("match_start_real_countdown");
  else
    return;

  _id_802CD1D828B52F29 = [];
  _id_8738B2877C92E837 = [];
  _id_97D80017548B48CB = [];

  foreach(team in game["infil"]) {
    if(!isDefined(team[1])) {
      continue;
    }
    foreach(_id_BA5196C78DFDA051 in team[1]) {
      foreach(_id_D2A495E530ABB848 in _id_BA5196C78DFDA051)
      _id_8738B2877C92E837[_id_8738B2877C92E837.size] = _id_D2A495E530ABB848.path;
    }
  }

  foreach(_id_21C526176E42A59E in _id_8738B2877C92E837)
  _id_97D80017548B48CB[_id_97D80017548B48CB.size] = createnavobstaclebybounds(_id_21C526176E42A59E.origin, (200, 128, 200), _id_21C526176E42A59E.angles);

  while(!scripts\mp\flags::gameflag("prematch_done"))
    waitframe();

  wait 3;

  foreach(_id_343AB41CE58C7A17 in _id_97D80017548B48CB)
  destroynavobstacle(_id_343AB41CE58C7A17);
}

_id_4D65C1597EC31547(agents) {
  origins = [];

  foreach(agent in agents) {
    if(_id_8CC95623D93D70FB(agent))
      origins[origins.size] = agent.origin;
  }

  if(origins.size > 0)
    return averagepoint(origins);
  else
    return undefined;
}

_id_F9B8935478663F0B() {
  _id_63F43F469B885EC6 = 25;

  for(;;) {
    waitframe();

    if(getdvarint("dvar_AE55816CBA943C57", 0) == 0) {
      continue;
    }
    foreach(team in level.teamnamelist) {
      _id_1B11EAA9B42E5081 = 400;

      if(team == "allies")
        _id_1B11EAA9B42E5081 = 800;

      _id_1B11E9A9B42E4E4E = 300;

      foreach(_id_6C3FC29A5FD8751A, _id_A2D0446BC9B000AB in level._id_AE5271D2ED773311[team]) {
        _id_7918C27CB3E1349A = 1;
        _id_7918C27CB3E1349A++;

        foreach(index, agent in _id_A2D0446BC9B000AB._id_E2C31580F508B878) {
          color = (1, 1, 1);

          if(istrue(agent._id_2BAFFEF526C6DD6C))
            color = (0, 1, 0);
          else if(istrue(agent._id_D6EB429048E1A4B5))
            color = (0, 1, 1);

          _id_7918C27CB3E1349A++;
        }

        _id_1B11EAA9B42E5081 = _id_1B11EAA9B42E5081 + 100;
      }
    }
  }
}

_id_CE95C7540070F7D0(_id_D8061F26B5ECA018, _id_78F4F12BE3B7507A, attacker) {
  if(isDefined(attacker) && isDefined(attacker.owner))
    attacker = attacker.owner;

  if(!isDefined(attacker) || !isDefined(attacker.team) || !isDefined(_id_78F4F12BE3B7507A)) {
    return;
  }
  if(!isenemyteam(_id_78F4F12BE3B7507A, attacker.team)) {
    return;
  }
  if(isagent(attacker)) {
    return;
  }
  _id_24D22C13C6FECE21 = 0;

  switch (_id_D8061F26B5ECA018) {
    case "scrambler_drone_guard":
    case "uav":
    case "sentry_gun":
    case "radar_drone_recon":
    case "pac_sentry":
    case "assault_drone":
      _id_24D22C13C6FECE21 = 5;
      break;
    case "airdrop_multiple":
    case "hover_jet":
    case "chopper_gunner":
    case "airdrop_escort":
      _id_24D22C13C6FECE21 = 10;
      break;
    case "gunship":
    case "juggernaut":
      _id_24D22C13C6FECE21 = 15;
      break;
  }

  if(_id_24D22C13C6FECE21 > 0) {
    scripts\mp\gamescore::giveteamscoreforobjective(attacker.team, _id_24D22C13C6FECE21, 0);

    if(getdvarint("dvar_2E405E2912DC4A44", 0) == 1)
      attacker thread scripts\mp\rank::scoreeventpopup(_func_2EF675C13CA1C4AF("stat_2C8BCBB02EC7FF9B", _id_24D22C13C6FECE21));

    attacker scripts\mp\utility\stats::incpersstat("contribution", _id_24D22C13C6FECE21);
    attacker scripts\mp\utility\stats::setextrascore0(attacker.pers["contribution"]);

    if(isPlayer(attacker)) {
      _id_4DA4CB52D0BF5B05 = 0;
      _id_4DA4CB52D0BF5B05 = _id_4DA4CB52D0BF5B05 + 4;
      _id_4DA4CB52D0BF5B05 = _id_4DA4CB52D0BF5B05 + (_id_24D22C13C6FECE21 << 4);
      attacker _id_0FD32F08E72B657F::_id_0417749E099F041F(_id_4DA4CB52D0BF5B05, -1);
    }
  }
}

_id_8DECCE720ED19F1A(vehiclename, vehicleteam, attacker) {
  if(isDefined(attacker) && isDefined(attacker.owner))
    attacker = attacker.owner;

  if(!isDefined(attacker) || !isDefined(attacker.team) || !isDefined(vehicleteam)) {
    return;
  }
  if(vehicleteam == "neutral" || !isenemyteam(vehicleteam, attacker.team)) {
    return;
  }
  if(isagent(attacker)) {
    return;
  }
  _id_24D22C13C6FECE21 = 0;

  switch (vehiclename) {
    case "little_bird_mg":
    case "veh9_rhib":
    case "veh9_jltv":
    case "veh9_jltv_mg":
    case "little_bird":
      _id_24D22C13C6FECE21 = 5;
      break;
    case "apc_russian":
    case "veh9_palfa":
    case "light_tank":
    case "veh9_cougar":
      _id_24D22C13C6FECE21 = 10;
  }

  if(_id_24D22C13C6FECE21 > 0) {
    scripts\mp\gamescore::giveteamscoreforobjective(attacker.team, _id_24D22C13C6FECE21, 0);

    if(getdvarint("dvar_2E405E2912DC4A44", 0) == 1)
      attacker thread scripts\mp\rank::scoreeventpopup(_func_2EF675C13CA1C4AF("stat_2C8BCBB02EC7FF9B", _id_24D22C13C6FECE21));

    attacker scripts\mp\utility\stats::incpersstat("contribution", _id_24D22C13C6FECE21);
    attacker scripts\mp\utility\stats::setextrascore0(attacker.pers["contribution"]);

    if(isPlayer(attacker)) {
      _id_4DA4CB52D0BF5B05 = 0;
      _id_4DA4CB52D0BF5B05 = _id_4DA4CB52D0BF5B05 + 4;
      _id_4DA4CB52D0BF5B05 = _id_4DA4CB52D0BF5B05 + (_id_24D22C13C6FECE21 << 4);
      attacker _id_0FD32F08E72B657F::_id_0417749E099F041F(_id_4DA4CB52D0BF5B05, -1);
    }
  }
}

_id_4BAF8B94714B68FE() {
  level endon("game_ended");
  _id_4AEA3B858D238FD2 = level.scorelimit * 0.25;
  _id_4B0036858D3BB806 = level.scorelimit * 0.5;
  _id_4AF747858D31BEBB = level.scorelimit * 0.75;
  _id_4B11CE858D4F10AA = level.scorelimit * 0.9;
  _id_AD04CF65B0FE1704 = 0;
  _id_AD095265B1032CF4 = 0;
  _id_AD11C365B10C1125 = 0;
  _id_AD1ACA65B1163F38 = 0;

  while(!scripts\mp\flags::gameflag("prematch_done"))
    waitframe();

  for(;;) {
    _id_18A3FAB290E780C2 = scripts\mp\gamescore::_getteamscore("axis");
    _id_43A41488C3C487DF = scripts\mp\gamescore::_getteamscore("allies");
    _id_EC15CE3E7A9D1D86 = scripts\engine\utility::ter_op(_id_18A3FAB290E780C2 > _id_43A41488C3C487DF, "axis", "allies");
    _id_1C1DEE64DF9A9C2E = scripts\mp\utility\game::getotherteam(_id_EC15CE3E7A9D1D86)[0];

    if(!_id_AD04CF65B0FE1704 && (_id_18A3FAB290E780C2 >= _id_4AEA3B858D238FD2 || _id_43A41488C3C487DF >= _id_4AEA3B858D238FD2)) {
      _id_AD04CF65B0FE1704 = 1;
      level thread _id_0A350EA3BD2C8470();
      scripts\mp\utility\dialog::statusdialog("score_25_winning", _id_EC15CE3E7A9D1D86, 1);
      scripts\mp\utility\dialog::statusdialog("score_25_losing", _id_1C1DEE64DF9A9C2E, 1);
    }

    if(!_id_AD095265B1032CF4 && (_id_18A3FAB290E780C2 >= _id_4B0036858D3BB806 || _id_43A41488C3C487DF >= _id_4B0036858D3BB806)) {
      _id_AD095265B1032CF4 = 1;
      level thread _id_99FEF643D7A98BB0();
      scripts\mp\utility\dialog::statusdialog("score_50_winning", _id_EC15CE3E7A9D1D86, 1);
      scripts\mp\utility\dialog::statusdialog("score_50_losing", _id_1C1DEE64DF9A9C2E, 1);
      level thread _id_4FA7B02D1BBE565E(6);
    }

    if(!_id_AD11C365B10C1125 && (_id_18A3FAB290E780C2 >= _id_4AF747858D31BEBB || _id_43A41488C3C487DF >= _id_4AF747858D31BEBB)) {
      _id_AD11C365B10C1125 = 1;
      level thread _id_1B39D0AC099F112F();
      scripts\mp\utility\dialog::statusdialog("score_75_winning", _id_EC15CE3E7A9D1D86, 1);
      scripts\mp\utility\dialog::statusdialog("score_75_losing", _id_1C1DEE64DF9A9C2E, 1);
    }

    if(!_id_AD1ACA65B1163F38 && (_id_18A3FAB290E780C2 >= _id_4B11CE858D4F10AA || _id_43A41488C3C487DF >= _id_4B11CE858D4F10AA)) {
      _id_AD1ACA65B1163F38 = 1;
      scripts\mp\utility\dialog::statusdialog("score_90_winning", _id_EC15CE3E7A9D1D86, 1);
      scripts\mp\utility\dialog::statusdialog("score_90_losing", _id_1C1DEE64DF9A9C2E, 1);
    }

    wait 1.0;
  }
}

_id_0A350EA3BD2C8470() {
  level._id_84C26A9FA39F7586 = [];
  level._id_EBB878F6221BED4F = [];
  _id_C2344893389FA188 = [];

  foreach(team in level.teamnamelist) {
    level._id_84C26A9FA39F7586[team] = 0;
    level._id_EBB878F6221BED4F[team] = 0;
    _id_C2344893389FA188[team] = 0;
  }

  scripts\cp_mp\vehicles\vehicle::_id_66AB4FB2175555E1("veh9_jltv_mg");
  _id_36967CE8EE2EA745::main();
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_jltv_mg", "onDeathRespawn", ::_id_52A967CC33E0F447);
  vehiclecount = getdvarint("dvar_BDA20DAC0244506B", 2);
  _id_226107F1B8475902 = int(getdvarfloat("dvar_6FF4EFB459D8B415", 30.0) * 1000);

  foreach(team in level.teamnamelist) {
    scripts\mp\utility\dialog::statusdialog("vehicles_inc", team, 1);
    scripts\mp\hud_util::showsplashtoteam(team, "gwtdm_vehicles_inc");
  }

  wait 5.0;

  for(;;) {
    currenttime = gettime();

    foreach(team in level.teamnamelist) {
      if(level._id_84C26A9FA39F7586[team] < vehiclecount) {
        if(_id_C2344893389FA188[team] && currenttime < level._id_EBB878F6221BED4F[team] + _id_226107F1B8475902) {
          continue;
        }
        _id_695A8B6F4AAEEEE6 = randomfloatrange(0, 1.0);
        _id_B5F7B6A6852C98B8 = vectorlerp(level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_B027D6857AB9D713, level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_014E33FB843CA741, _id_695A8B6F4AAEEEE6);
        _id_CAE290751508D1A0 = level.gw_objstruct.allieshqloc.trigger.origin;

        if(team == "axis")
          _id_CAE290751508D1A0 = level.gw_objstruct.axishqloc.trigger.origin;

        _id_D2666395E6CF4732 = getdvarint("dvar_345E75BC0B7ABA35", 3000);
        _id_2B58E9F9E67DE0A5 = vectorNormalize(_id_B5F7B6A6852C98B8 - _id_CAE290751508D1A0);
        offset = _id_2B58E9F9E67DE0A5 * _id_D2666395E6CF4732;
        _id_B5F7B6A6852C98B8 = _id_B5F7B6A6852C98B8 - offset;
        trace = scripts\engine\trace::ray_trace(_id_B5F7B6A6852C98B8, _id_B5F7B6A6852C98B8 - (0, 0, 100000));
        _id_B5F7B6A6852C98B8 = trace["position"];
        _id_76A22C18960F72AF = findclosestdroplocation(_id_B5F7B6A6852C98B8, 1);

        if(!isDefined(_id_76A22C18960F72AF)) {
          continue;
        }
        spawndata = spawnStruct();
        spawndata.origin = _id_76A22C18960F72AF.origin + (0, 0, 100);
        spawndata.angles = _id_76A22C18960F72AF.angles;
        spawndata.spawntype = "GAME_MODE";
        spawndata._id_B88B7B3C17715E3F = team;
        vehicle = _id_721EE99D7A8F9168::_id_66C684FEA143FBFD("veh9_jltv_mg", spawndata);

        if(isDefined(vehicle)) {
          level._id_84C26A9FA39F7586[team]++;

          if(!_id_C2344893389FA188[team] && level._id_84C26A9FA39F7586[team] == vehiclecount)
            _id_C2344893389FA188[team] = 1;

          level._id_EBB878F6221BED4F[team] = currenttime;
          vehicle thread _id_FEA1FEF8411948A5(_id_76A22C18960F72AF);
        }
      }
    }

    wait 1.0;
  }
}

_id_1B39D0AC099F112F() {
  level._id_FCED0B6C61F6BB77 = [];
  level._id_4C529FA033FB6AE2 = [];
  _id_C2344893389FA188 = [];

  foreach(team in level.teamnamelist) {
    level._id_FCED0B6C61F6BB77[team] = 0;
    level._id_4C529FA033FB6AE2[team] = 0;
    _id_C2344893389FA188[team] = 0;
  }

  vehiclecount = getdvarint("dvar_D3A11571B804DCD2", 2);
  _id_226107F1B8475902 = int(getdvarfloat("dvar_BCCA4BDB0041285A", 60.0) * 1000);

  foreach(team in level.teamnamelist) {
    scripts\mp\utility\dialog::statusdialog("vehicles2_inc", team, 1);
    scripts\mp\hud_util::showsplashtoteam(team, "gwtdm_vehicles2_inc");
  }

  wait 5.0;
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "onDeathRespawn", ::_id_77CA7D0AA1A51384);

  for(;;) {
    currenttime = gettime();

    foreach(team in level.teamnamelist) {
      if(level._id_FCED0B6C61F6BB77[team] < vehiclecount) {
        if(_id_C2344893389FA188[team] && currenttime < level._id_4C529FA033FB6AE2[team] + _id_226107F1B8475902) {
          continue;
        }
        _id_695A8B6F4AAEEEE6 = randomfloatrange(0, 1.0);
        _id_B5F7B6A6852C98B8 = vectorlerp(level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_B027D6857AB9D713, level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_014E33FB843CA741, _id_695A8B6F4AAEEEE6);
        _id_CAE290751508D1A0 = level.gw_objstruct.allieshqloc.trigger.origin;

        if(team == "axis")
          _id_CAE290751508D1A0 = level.gw_objstruct.axishqloc.trigger.origin;

        _id_D2666395E6CF4732 = getdvarint("dvar_345E75BC0B7ABA35", 3000);
        _id_2B58E9F9E67DE0A5 = vectorNormalize(_id_B5F7B6A6852C98B8 - _id_CAE290751508D1A0);
        offset = _id_2B58E9F9E67DE0A5 * _id_D2666395E6CF4732;
        _id_B5F7B6A6852C98B8 = _id_B5F7B6A6852C98B8 - offset;
        trace = scripts\engine\trace::ray_trace(_id_B5F7B6A6852C98B8, _id_B5F7B6A6852C98B8 - (0, 0, 100000));
        _id_B5F7B6A6852C98B8 = trace["position"];
        _id_76A22C18960F72AF = findclosestdroplocation(_id_B5F7B6A6852C98B8, 1);

        if(!isDefined(_id_76A22C18960F72AF)) {
          continue;
        }
        spawndata = spawnStruct();
        spawndata.origin = _id_76A22C18960F72AF.origin + (0, 0, 100);
        spawndata.angles = _id_76A22C18960F72AF.angles;
        spawndata.spawntype = "GAME_MODE";
        spawndata.spawnmethod = "airdrop_at_position_unsafe";
        spawndata._id_B88B7B3C17715E3F = team;
        _id_EE8DA5624236DC89 = spawnStruct();
        vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("light_tank", spawndata, _id_EE8DA5624236DC89);

        if(isDefined(vehicle)) {
          level._id_FCED0B6C61F6BB77[team]++;

          if(!_id_C2344893389FA188[team] && level._id_FCED0B6C61F6BB77[team] == vehiclecount)
            _id_C2344893389FA188[team] = 1;

          level._id_4C529FA033FB6AE2[team] = currenttime;
          vehicle thread _id_FEA1FEF8411948A5(_id_76A22C18960F72AF);
          wait 5.0;
        }
      }
    }

    wait 1.0;
  }
}

_id_52A967CC33E0F447() {
  spawndata = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);

  if(isDefined(spawndata._id_6DC04302DA1A9D03))
    spawndata = spawndata._id_6DC04302DA1A9D03;

  level._id_84C26A9FA39F7586[spawndata._id_B88B7B3C17715E3F]--;
}

_id_77CA7D0AA1A51384() {
  spawndata = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);

  if(isDefined(spawndata._id_6DC04302DA1A9D03))
    spawndata = spawndata._id_6DC04302DA1A9D03;

  level._id_FCED0B6C61F6BB77[spawndata._id_B88B7B3C17715E3F]--;
}

_id_FEA1FEF8411948A5(_id_76A22C18960F72AF) {
  self waittill("landed");
  _id_B9F3F0B165458920 = 262144;

  while(isDefined(self)) {
    distsq = distancesquared(self.origin, _id_76A22C18960F72AF.origin);

    if(distsq > _id_B9F3F0B165458920) {
      break;
    }

    wait 1.0;
  }

  _id_76A22C18960F72AF.inuse = 0;
}

_id_7A5DB011B55B3F21(numagents, _id_C5E7FCE963586EC0, team, _id_CD63C265A2BB9772) {
  heading = undefined;

  if(team == "allies")
    heading = vectortoangles(level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_014E33FB843CA741 - level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_B027D6857AB9D713);
  else
    heading = vectortoangles(level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_B027D6857AB9D713 - level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_014E33FB843CA741);

  wait(randomfloat(_id_CD63C265A2BB9772));
  agents = level _id_640CF1641C03E2A0::_id_55AB9C6DA96226E7(numagents, _id_C5E7FCE963586EC0, undefined, undefined, "medium", "spawnHQ_" + team, "debug", team, undefined, undefined, heading, ::_id_C9E5E3858AB1805F, undefined, 1, level._id_C7A4725D05BB7F22);
}

_id_93E7D3696CAA5331(numagents, _id_E9BF3955FA1125B5, team) {
  _id_C5E7FCE963586EC0 = level._id_33809C8A29CA064E[_id_E9BF3955FA1125B5].origin;
  _id_CAE290751508D1A0 = level.gw_objstruct.allieshqloc.trigger.origin;

  if(team == "axis")
    _id_CAE290751508D1A0 = level.gw_objstruct.axishqloc.trigger.origin;

  _id_D2666395E6CF4732 = getdvarint("dvar_7456A259DB14A9A2", 3000);
  offset = vectorNormalize(_id_C5E7FCE963586EC0 - _id_CAE290751508D1A0) * _id_D2666395E6CF4732;
  _id_C5E7FCE963586EC0 = _id_C5E7FCE963586EC0 - offset;
  level thread _id_7A5DB011B55B3F21(numagents, _id_C5E7FCE963586EC0, team, 4);
}

_id_0A957005E5FF1B17() {
  _id_93E7D3696CAA5331(14, level._id_048E03F24B9B5C1A, "axis");
  _id_93E7D3696CAA5331(14, level._id_048E03F24B9B5C1A, "allies");
  level thread _id_037169A4FB87A0E3();
}

_id_037169A4FB87A0E3() {
  level endon("game_ended");
  _id_4AEA3B858D238FD2 = level.scorelimit * 0.25;
  _id_4B0036858D3BB806 = level.scorelimit * 0.5;
  _id_4B1634858D53E6D3 = level.scorelimit * 0.8;
  _id_76650562E610D426 = 0;
  _id_7FBA03C049D4FABA = 0;
  _id_1ACB94D12E9F55F3 = 0;
  _id_02C7AD0C8251C8F9 = 0;
  _id_427D285446343E15 = 0;
  _id_977746FCCDD041C8 = 0;

  for(;;) {
    _id_18A3FAB290E780C2 = scripts\mp\gamescore::_getteamscore("axis");
    _id_43A41488C3C487DF = scripts\mp\gamescore::_getteamscore("allies");

    if(_id_18A3FAB290E780C2 >= _id_4AEA3B858D238FD2 && !_id_76650562E610D426) {
      _id_93E7D3696CAA5331(5, level._id_048E03F24B9B5C1A, "axis");
      _id_76650562E610D426 = 1;
    } else if(_id_18A3FAB290E780C2 > _id_4B0036858D3BB806 && !_id_7FBA03C049D4FABA)
      _id_7FBA03C049D4FABA = 1;
    else if(_id_18A3FAB290E780C2 > _id_4B1634858D53E6D3 && !_id_1ACB94D12E9F55F3) {
      _id_93E7D3696CAA5331(9, level._id_048E03F24B9B5C1A, "axis");
      _id_1ACB94D12E9F55F3 = 1;
    }

    if(_id_43A41488C3C487DF >= _id_4AEA3B858D238FD2 && !_id_02C7AD0C8251C8F9) {
      _id_93E7D3696CAA5331(5, level._id_048E03F24B9B5C1A, "allies");
      _id_02C7AD0C8251C8F9 = 1;
    } else if(_id_43A41488C3C487DF > _id_4B0036858D3BB806 && !_id_427D285446343E15)
      _id_427D285446343E15 = 1;
    else if(_id_43A41488C3C487DF > _id_4B1634858D53E6D3 && !_id_977746FCCDD041C8) {
      _id_93E7D3696CAA5331(9, level._id_048E03F24B9B5C1A, "allies");
      _id_977746FCCDD041C8 = 1;
    }

    if(_id_76650562E610D426 && _id_7FBA03C049D4FABA && _id_1ACB94D12E9F55F3 && _id_02C7AD0C8251C8F9 && _id_427D285446343E15 && _id_977746FCCDD041C8) {
      return;
    }
    wait 1;
  }
}

_id_529A85D52F057F9B() {
  self endon("game_ended");

  for(;;) {
    if(getdvarint("dvar_46A6B424AF6ACBC2") != 0) {
      scripts\mp\gamescore::giveteamscoreforobjective("allies", getdvarint("dvar_46A6B424AF6ACBC2"), 0);
      break;
    } else if(getdvarint("dvar_86E14326E43C0115") != 0) {
      scripts\mp\gamescore::giveteamscoreforobjective("axis", getdvarint("dvar_86E14326E43C0115"), 0);
      break;
    }

    wait 1;
  }

  thread _id_529A85D52F057F9B();
}

_id_2DA93E2A35E2182F(agent, team, _id_BAA22CF8DB30F212, _id_6C3FC29A5FD8751A, _id_3E332762C9138001) {
  if(!isalive(agent)) {
    return;
  }
  _id_A2D0446BC9B000AB = level._id_33809C8A29CA064E[_id_BAA22CF8DB30F212]._id_A2D0446BC9B000AB[_id_6C3FC29A5FD8751A];

  if(isDefined(_id_A2D0446BC9B000AB._id_E59F791D76C7BEEE) && isDefined(_id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80) && _id_A2D0446BC9B000AB._id_E59F791D76C7BEEE.size > 0 && _id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80.size > 0) {
    if(istrue(agent._id_5966903B1E0154E5))
      volume = _id_A2D0446BC9B000AB._id_E59F791D76C7BEEE[scripts\mp\utility\teams::getenemyteams(team)[0]];
    else
      volume = _id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80[team];
  } else
    volume = level._id_33809C8A29CA064E[_id_BAA22CF8DB30F212]._id_A2D0446BC9B000AB[_id_6C3FC29A5FD8751A]._id_45D6F1C931BC6A8B[team][0]._id_448DCBC6F715EFDC;

  angles = level._id_33809C8A29CA064E[_id_BAA22CF8DB30F212]._id_A2D0446BC9B000AB[_id_6C3FC29A5FD8751A]._id_45D6F1C931BC6A8B[team][0].angles;

  if(isDefined(volume)) {
    agent cleargoalvolume();
    agent setgoalvolumeauto(volume, volume.heading);
    agent._id_99F2752B6513C9DD = volume;

    if(!istrue(_id_3E332762C9138001)) {
      level thread _id_120270BD0A747A35::_id_05D96B05A065564E(agent);
      agent thread _id_55C73DA3BC1275F7(agent);
    }

    return 1;
  }

  return 0;
}

_id_6D1FED8DD6165391() {
  level endon("game_ended");
  level._id_0CE3B5EF4C0B6019 = [];
  level._id_0CE3B5EF4C0B6019["axis"] = [];
  level._id_0CE3B5EF4C0B6019["allies"] = [];
  level._id_E71982FF48057365 = [];

  while(!scripts\mp\flags::gameflag("prematch_done"))
    waitframe();

  scripts\engine\utility::flag_wait("frontline_data_init");
  scripts\mp\gamelogic::waitforplayers(level.prematchperiod, 0, 0);
  level thread _id_6A6A92B892CF9E9A("axis");
  level thread _id_6A6A92B892CF9E9A("allies");

  for(;;) {
    foreach(player in level.players) {
      if(!isalive(player)) {
        continue;
      }
      _id_C53E78332A6C514F = player getentitynumber();

      if(isDefined(level._id_0CE3B5EF4C0B6019[player.team][_id_C53E78332A6C514F])) {
        continue;
      }
      if(!isDefined(level._id_E71982FF48057365[_id_C53E78332A6C514F]) && _id_6BC95C97CE75AE39(player))
        level._id_0CE3B5EF4C0B6019[player.team][_id_C53E78332A6C514F] = player;
    }

    wait 1;
  }
}

_id_6A6A92B892CF9E9A(team) {
  level endon("game_ended");
  enemyteam = scripts\mp\utility\teams::getenemyteams(team)[0];

  for(;;) {
    foreach(key, player in level._id_0CE3B5EF4C0B6019[team]) {
      if(!isDefined(player) || !isalive(player)) {
        level._id_0CE3B5EF4C0B6019[team][key] = undefined;
        continue;
      }

      agents = scripts\mp\utility\entity::_id_D9CE8FB00F0E5FA1(player.origin, 5000, enemyteam);
      agents = sortbydistance(agents, player.origin);
      _id_C5A227521B066BDD = [];

      foreach(agent in agents) {
        if(isPlayer(agent)) {
          continue;
        }
        if(_id_C5A227521B066BDD.size >= 5) {
          break;
        }

        if(istrue(agent._id_D0640290E2529307) || isDefined(agent.vehicle_position) && isint(agent.vehicle_position)) {
          continue;
        }
        _id_C5A227521B066BDD[_id_C5A227521B066BDD.size] = agent;
      }

      if(_id_C5A227521B066BDD.size > 0) {
        level._id_0CE3B5EF4C0B6019[player.team][key] = undefined;
        level._id_E71982FF48057365[key] = player;

        foreach(agent in _id_C5A227521B066BDD)
        _id_0B692EED7A70F888(player, agent);
      }
    }

    wait 5;
  }
}

_id_0B692EED7A70F888(player, agent) {
  agent cleargoalvolume();
  agent _meth_D955A85131DC6E69(player, 40);
  agent._id_D0640290E2529307 = 1;
  agent thread _id_120270BD0A747A35::_id_A5117518725DA028(agent, player.origin, 8, 8, undefined, 1, undefined, 0, ::_id_F06BE3FF9086A2AD, player);
  agent._id_E79513BBF1767908 = agent.baseaccuracy;
  agent.baseaccuracy = agent.baseaccuracy + getdvarfloat("dvar_67A1AF3428021A00", 0.5);
  agent thread _id_289C977B7523EFBA(agent, player);
}

_id_F06BE3FF9086A2AD(agent, targetent) {
  if(istrue(agent._id_D0640290E2529307))
    agent thread _id_120270BD0A747A35::_id_A5117518725DA028(agent, targetent.origin, 8, 8, undefined, 1, undefined, 0, ::_id_F06BE3FF9086A2AD, targetent);
}

_id_289C977B7523EFBA(agent, player) {
  agent notify("endHuntTrackerTimer");
  level endon("game_ended");
  agent endon("death");
  agent endon("endHuntTrackerTimer");
  _id_C53E78332A6C514F = player getentitynumber();
  player scripts\engine\utility::waittill_notify_or_timeout("death", 20);
  level._id_E71982FF48057365[_id_C53E78332A6C514F] = undefined;
  agent._id_D0640290E2529307 = 0;
  agent.baseaccuracy = agent._id_E79513BBF1767908;
  _id_2AA208E2058474E5(agent);
}

_id_C4232CF1E0949932(player) {
  _id_A2B13B5AE4CB7698 = level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A].origin;
  _id_A011729D000A28D2 = vectorNormalize(_id_A2B13B5AE4CB7698 - player.origin);
  dot = vectordot(level.spawnselectionteamforward[player.team], _id_A011729D000A28D2);

  if(vectordot(level.spawnselectionteamforward[player.team], _id_A011729D000A28D2) < 0)
    return 1;

  return 0;
}

_id_6BC95C97CE75AE39(player) {
  _id_A2D0446BC9B000AB = level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_A2D0446BC9B000AB[1];

  if(!isDefined(_id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80) || _id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80.size <= 0) {
    _id_BAA22CF8DB30F212 = level._id_048E03F24B9B5C1A;
    _id_55DCE045DCD7EBA2 = level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_A2D0446BC9B000AB[1]._id_45D6F1C931BC6A8B[player.team][0]._id_448DCBC6F715EFDC.origin;
  } else
    _id_55DCE045DCD7EBA2 = _id_A2D0446BC9B000AB._id_D8C8EC702B9AFD80[scripts\mp\utility\teams::getenemyteams(player.team)[0]].origin;

  _id_A011729D000A28D2 = vectorNormalize(_id_55DCE045DCD7EBA2 - player.origin);
  dot = vectordot(level.spawnselectionteamforward[player.team], _id_A011729D000A28D2);

  if(vectordot(level.spawnselectionteamforward[player.team], _id_A011729D000A28D2) < 0)
    return 1;

  return 0;
}

_id_AE56674143E0EC69() {
  _id_48814951E916AF89::_id_2FC80954FA70D153();

  for(;;) {
    _id_7D07BCC667393CDF = 0;
    _id_ACCE55F72D869802 = 0;

    foreach(agent in level.agentarray) {
      if(isalive(agent)) {
        color = (0, 1, 0);

        if(agent.team == "axis") {
          color = (1, 0, 0);
          _id_7D07BCC667393CDF++;
        } else
          _id_ACCE55F72D869802++;

        thread scripts\mp\utility\debug::drawsphere(agent.origin, 32, 0.05, color);

        if(istrue(agent._id_D0640290E2529307))
          thread scripts\mp\utility\debug::drawsphere(agent.origin, 42, 0.05, (1, 0, 1));

        if(istrue(agent._id_5966903B1E0154E5))
          thread scripts\mp\utility\debug::drawsphere(agent.origin, 52, 0.05, (1, 1, 1));
      }
    }

    waitframe();
  }
}

_id_A999B4EE6F415E8C() {
  self endon("game_ended");
  _id_48814951E916AF89::_id_2FC80954FA70D153();

  for(;;) {
    foreach(agent in level.agentarray) {
      if(isalive(agent) && !istrue(agent._id_D0640290E2529307)) {
        if(isDefined(agent.vehicle_position) && isint(agent.vehicle_position)) {
          continue;
        }
        if(isDefined(agent.landing_spot)) {
          continue;
        }
        _id_6C3FC29A5FD8751A = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "laneKey");

        if(isDefined(_id_6C3FC29A5FD8751A)) {
          if(istrue(agent._id_A8A165C3323BDA48)) {
            continue;
          }
          _id_2DA93E2A35E2182F(agent, agent.team, level._id_048E03F24B9B5C1A, _id_6C3FC29A5FD8751A);
        }
      }
    }

    wait 5;
  }
}

_id_C1313BF26D803678(team) {
  self endon("game_ended");
  level notify("resetAgentVolumeMovementThink" + team);
  level endon("resetAgentVolumeMovementThink" + team);
  _id_48814951E916AF89::_id_2FC80954FA70D153();
  scripts\engine\utility::flag_wait("frontline_data_init");
  wait 5;

  for(;;) {
    _id_43EE1459B6B49B5A = 0;
    level._id_3BF1CF107E60E048[team] = scripts\engine\utility::array_randomize(level._id_3BF1CF107E60E048[team]);

    foreach(index, agent in level._id_3BF1CF107E60E048[team]) {
      if(isalive(agent) && !isDefined(agent.vehicle) && (istrue(agent._id_A8A165C3323BDA48) || !istrue(_id_47D612D4D655F75D(agent)))) {
        _id_FD1EF087D4A56D19(agent, team, index);
        _id_43EE1459B6B49B5A = 1;
        break;
      }
    }

    if(!istrue(_id_43EE1459B6B49B5A)) {
      foreach(index, agent in level._id_3BF1CF107E60E048[team]) {
        if(isalive(agent) && !isDefined(agent.vehicle) && !istrue(_id_47D612D4D655F75D(agent))) {
          level._id_3BF1CF107E60E048[team][index] = undefined;
          level._id_9DE3C802FCED05E2[team][level._id_9DE3C802FCED05E2[team].size] = agent;
          agent._id_5966903B1E0154E5 = 1;
          agent playsoundtoteam("mp_walla_invasion_charge_individual", agent.team);
          _id_2AA208E2058474E5(agent);
          break;
        }
      }
    }

    wait(randomfloatrange(4, 7));
  }
}

_id_FD1EF087D4A56D19(agent, team, _id_9BA14084CC963AA1) {
  agent._id_A8A165C3323BDA48 = 0;

  if(isDefined(_id_9BA14084CC963AA1))
    level._id_3BF1CF107E60E048[team][_id_9BA14084CC963AA1] = undefined;
  else
    level._id_3BF1CF107E60E048[team] = scripts\engine\utility::array_remove(level._id_3BF1CF107E60E048[team], agent);

  level._id_9DE3C802FCED05E2[team][level._id_9DE3C802FCED05E2[team].size] = agent;
  agent._id_5966903B1E0154E5 = 1;
  agent playsoundtoteam("mp_walla_invasion_charge_individual", agent.team);
  _id_2AA208E2058474E5(agent);
}

_id_47D612D4D655F75D(agent) {
  if(!isalive(agent) || !isDefined(agent.agent_type))
    return undefined;

  if(issubstr(agent.agent_type, "rpg") || issubstr(agent.agent_type, "sniper"))
    return 1;

  return 0;
}

_id_7F995B3E1538A773() {
  level._id_F74D710168834C2B = [];
  level._id_F74D710168834C2B["axis"] = [];
  level._id_F74D710168834C2B["allies"] = [];
  _id_5352A7311A690A33 = scripts\engine\utility::getStructArray("intro_scene_axis", "script_noteworthy");

  foreach(intronode in _id_5352A7311A690A33) {
    _id_F3199F1FAF87346C = scripts\engine\utility::getStructArray(intronode.target, "targetname");

    foreach(loc in _id_F3199F1FAF87346C) {
      script_noteworthy = tolower(loc.script_noteworthy);

      if(isDefined(script_noteworthy) && !isDefined(level._id_F74D710168834C2B["axis"][script_noteworthy]))
        level._id_F74D710168834C2B["axis"][script_noteworthy] = [];

      level._id_F74D710168834C2B["axis"][script_noteworthy][level._id_F74D710168834C2B["axis"][script_noteworthy].size] = loc;
    }
  }

  _id_0494169AFC61A508 = scripts\engine\utility::getStructArray("intro_scene_allies", "script_noteworthy");

  foreach(intronode in _id_0494169AFC61A508) {
    _id_F3199F1FAF87346C = scripts\engine\utility::getStructArray(intronode.target, "targetname");

    foreach(loc in _id_F3199F1FAF87346C) {
      script_noteworthy = tolower(loc.script_noteworthy);

      if(isDefined(script_noteworthy) && !isDefined(level._id_F74D710168834C2B["allies"][script_noteworthy]))
        level._id_F74D710168834C2B["allies"][script_noteworthy] = [];

      level._id_F74D710168834C2B["allies"][script_noteworthy][level._id_F74D710168834C2B["allies"][script_noteworthy].size] = loc;
    }
  }
}

_id_FDC34E092FE389C8() {
  _id_48814951E916AF89::_id_2FC80954FA70D153();
  waitframe();

  foreach(_id_26B788EEE5E1C883, _id_075F30B91D39C93D in level._id_F74D710168834C2B["axis"]) {
    foreach(_id_470945768F8F02B6 in _id_075F30B91D39C93D) {
      [_id_3E38EE41DC326FDC, _id_52C58DA4C35FDE00, _id_30F3543613EDAA6E] = _id_D7FCF73C5CF90BE1(_id_26B788EEE5E1C883);
      _id_B5B1784D5A1327C7 = "spawnHQ_axis";
      aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB(undefined, undefined, "guard", undefined, level._id_C7A4725D05BB7F22, level._id_72F834B3F8B2A366["axis"]);
      origin = getclosestpointonnavmesh(_id_470945768F8F02B6.origin);
      agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, origin, _id_470945768F8F02B6.angles + _id_52C58DA4C35FDE00, "medium", _id_B5B1784D5A1327C7, undefined, undefined, "axis", undefined, undefined, 1);

      if(isalive(agent)) {
        agent thread _id_6C7668729D88ED55(agent, _id_3E38EE41DC326FDC, "intro_cap_complete", _id_30F3543613EDAA6E);
        agent thread _id_08C8977B452F6A8A(agent);
      }
    }
  }

  foreach(_id_26B788EEE5E1C883, _id_075F30B91D39C93D in level._id_F74D710168834C2B["allies"]) {
    foreach(_id_470945768F8F02B6 in _id_075F30B91D39C93D) {
      [_id_3E38EE41DC326FDC, _id_52C58DA4C35FDE00, _id_30F3543613EDAA6E] = _id_D7FCF73C5CF90BE1(_id_26B788EEE5E1C883);
      _id_B5B1784D5A1327C7 = "spawnHQ_allies";
      aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB(undefined, undefined, "guard", undefined, level._id_C7A4725D05BB7F22, level._id_72F834B3F8B2A366["allies"]);
      origin = getclosestpointonnavmesh(_id_470945768F8F02B6.origin);
      agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, origin, _id_470945768F8F02B6.angles + _id_52C58DA4C35FDE00, "medium", _id_B5B1784D5A1327C7, undefined, undefined, "allies", undefined, undefined, 1);

      if(isalive(agent)) {
        agent thread _id_6C7668729D88ED55(agent, _id_3E38EE41DC326FDC, "intro_cap_complete", _id_30F3543613EDAA6E);
        agent thread _id_08C8977B452F6A8A(agent);
      }
    }
  }
}

_id_D7FCF73C5CF90BE1(_id_26B788EEE5E1C883) {
  _id_3E38EE41DC326FDC = undefined;
  _id_52C58DA4C35FDE00 = (0, 0, 0);
  _id_30F3543613EDAA6E = 6 + randomfloatrange(-0.75, 0.75);

  switch (_id_26B788EEE5E1C883) {
    case "rebelcrouch01":
      _id_3E38EE41DC326FDC = "caps/mp/rebel_peptalk_01";
      break;
    case "rebelcrouch02":
      _id_3E38EE41DC326FDC = "caps/mp/rebel_peptalk_01";
      break;
    case "rebelcrouch03":
      _id_3E38EE41DC326FDC = "caps/mp/rebel_peptalk_01";
      break;
    case "rebelcrouch04":
      _id_3E38EE41DC326FDC = "caps/mp/rebel_peptalk_04";
      break;
    case "rebelstand01":
      _id_3E38EE41DC326FDC = "caps/mp/rebel_stand_05";
      _id_52C58DA4C35FDE00 = (0, -90, 0);
      break;
    case "rebelstand02":
      _id_3E38EE41DC326FDC = "caps/mp/rebel_stand_02";
      _id_52C58DA4C35FDE00 = (0, -90, 0);
      break;
    case "leader":
      _id_3E38EE41DC326FDC = "caps/mp/rebel_peptalk_leader";
      break;
  }

  return [_id_3E38EE41DC326FDC, _id_52C58DA4C35FDE00, _id_30F3543613EDAA6E];
}

_id_6C7668729D88ED55(agent, _id_3E38EE41DC326FDC, _id_610BE4AFA05A30CB, _id_30F3543613EDAA6E) {
  if(!isDefined(_id_3E38EE41DC326FDC))
    _id_3E38EE41DC326FDC = "caps/mp/rebel_peptalk_01";

  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "team", agent.team);
  waitframe();
  agent thread _id_010B6724C15A95E8::_id_C434AF0895CC147C("cap_single", _id_3E38EE41DC326FDC);
  waittime = 3;

  if(level.prematchperiodend > 0) {
    level waittill("match_start_real_countdown");
    waittime = level.prematchperiodend - _id_30F3543613EDAA6E;
    waittime = scripts\engine\utility::ter_op(0 < waittime, waittime, 0);
  }

  wait(waittime);
  agent._id_760F5D16839D683F = 1;
  remainingtime = 7;
  _id_5321EB7C0023B4A7 = randomfloatrange(4.0, 6.0);
  wait(_id_5321EB7C0023B4A7);
  playsoundatpos(agent.origin, "mp_walla_invasion_charge_individual");
  wait(remainingtime - _id_5321EB7C0023B4A7);
  agent _id_010B6724C15A95E8::_id_B6AF4ADE50626E90();
  agent notify(_id_610BE4AFA05A30CB);
}

_id_08C8977B452F6A8A(agent) {
  if(agent.team == "allies") {
    _id_F23987BCABEE0296 = level._id_DF2344C49D981562[agent.team][randomint(level._id_DF2344C49D981562[agent.team].size)];
    agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(_id_F23987BCABEE0296.body, _id_F23987BCABEE0296.head);
    agent._id_76F8DDB1563464BD = 1;
  }

  agent waittill("intro_cap_complete");
  _id_6C3FC29A5FD8751A = _id_B983381333B3881B(agent.origin);
  _id_2DA93E2A35E2182F(agent, agent.team, level._id_048E03F24B9B5C1A, _id_6C3FC29A5FD8751A);
  _id_4C7945217F8ADFFA(agent, _id_6C3FC29A5FD8751A);
}

_id_2B4958ACF92594E3() {
  while(!istrue(level._id_1091B5D43BA7A905))
    waitframe();

  foreach(team in level.teamnamelist) {
    _id_A2B13B5AE4CB7698 = (0, 0, 0);

    foreach(_id_A2D0446BC9B000AB in level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_A2D0446BC9B000AB)
    _id_A2B13B5AE4CB7698 = _id_A2B13B5AE4CB7698 + _id_A2D0446BC9B000AB.origin;

    _id_A2B13B5AE4CB7698 = _id_A2B13B5AE4CB7698 / level._id_33809C8A29CA064E[level._id_048E03F24B9B5C1A]._id_A2D0446BC9B000AB.size;

    if(team == "allies")
      forward = level.spawnselectionteamforward["allies"] * -1;
    else
      forward = level.spawnselectionteamforward["axis"] * -1;

    _id_D2666395E6CF4732 = getdvarint("dvar_25E538731B72B1B4", 10000);
    height = getdvarint("dvar_B78EF73B0670B310", 2000);
    camerapos = _id_A2B13B5AE4CB7698 + forward * _id_D2666395E6CF4732;
    trace = scripts\engine\trace::ray_trace(camerapos + (0, 0, 10000), camerapos - (0, 0, 20000));

    if(trace["hittype"] == "hittype_none")
      camerapos = (camerapos[0], camerapos[1], scripts\mp\spawncamera::getstartspawnavg(team)[2]) + (0, 0, height);
    else if(trace["position"][2] < scripts\mp\spawncamera::getstartspawnavg(team)[2])
      camerapos = (camerapos[0], camerapos[1], scripts\mp\spawncamera::getstartspawnavg(team)[2]) + (0, 0, height);
    else
      camerapos = trace["position"] + (0, 0, height);

    _id_6D399A908D913B0B = vectorNormalize(_id_A2B13B5AE4CB7698 - camerapos);
    cameraang = scripts\mp\utility\script::vectortoanglessafe(_id_6D399A908D913B0B, (0, 0, 1));
    level.spawncameras["default"][team].origin = camerapos;
    level.spawncameras["default"][team].angles = cameraang;
    _id_28D7C5CA5BA161E1 = getdvarint("dvar_A66B78681B2D0805", 4096);
    _id_963953C3478BF4FE = _id_A2B13B5AE4CB7698 + forward * _id_28D7C5CA5BA161E1;
    _id_963953C3478BF4FE = scripts\engine\utility::drop_to_ground(_id_963953C3478BF4FE);
    level.spawncameras["default"][team]._id_6930961C8A8D33FC = _id_963953C3478BF4FE;

    if(getdvarint("dvar_13FAE9C305971D06", 0) == 1) {
      color = (1, 0, 0);

      if(team == "allies")
        color = (0, 0, 1);

      thread scripts\mp\utility\debug::drawline(camerapos + (0, 0, 10000), camerapos - (0, 0, 20000), 60.0, (1, 1, 0));
      thread scripts\mp\utility\debug::drawsphere(camerapos, 100, 60.0, color);
      thread scripts\mp\utility\debug::drawline(camerapos, _id_A2B13B5AE4CB7698, 60.0, color);
      thread scripts\mp\utility\debug::drawline(camerapos, _id_963953C3478BF4FE, 60.0, (0, 1, 0));
    }
  }
}

_id_4FA7B02D1BBE565E(_id_D011F1ADEDD9D3ED) {
  level._id_C7A4725D05BB7F22 = 2;

  if(!isDefined(_id_D011F1ADEDD9D3ED))
    _id_D011F1ADEDD9D3ED = 0;

  wait(_id_D011F1ADEDD9D3ED);

  foreach(team in level.teamnamelist) {
    scripts\mp\utility\dialog::statusdialog("tier2_friendly", team, 1);
    scripts\mp\hud_util::showsplashtoteam(team, "gwtdm_tier2_agents_inc");
  }

  _id_93E7D3696CAA5331(7, level._id_048E03F24B9B5C1A, "axis");
  _id_93E7D3696CAA5331(7, level._id_048E03F24B9B5C1A, "allies");
}

_id_4FA7B12D1BBE5891(_id_D011F1ADEDD9D3ED) {
  level._id_C7A4725D05BB7F22 = 3;

  if(!isDefined(_id_D011F1ADEDD9D3ED))
    _id_D011F1ADEDD9D3ED = 0;

  wait(_id_D011F1ADEDD9D3ED);

  foreach(team in level.teamnamelist) {
    scripts\mp\utility\dialog::statusdialog("tier3_friendly", team, 1);
    scripts\mp\hud_util::showsplashtoteam(team, "gwtdm_tier3_agents_inc");
  }
}

onplayerconnectstream() {
  if(!isDefined(self.sessionteam) || self.sessionteam == "spectator" || self.sessionteam == "none" || self isplayerheadless())
    return 0;

  return 1;
}