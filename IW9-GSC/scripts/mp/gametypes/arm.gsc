/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\arm.gsc
***********************************************/

main() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 300);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 2400);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  setDvar("dvar_405E7E20D91344CC", 0);
  setDvar("scr_allow_technicals", 1);
  setDvar("scr_runlean_max_technicals", 30);
  setDvar("dvar_E4FA721677F03DE0", 1);
  setDvar("cg_friendlyReviveNameplateEnabled", 0);
  setomnvar("ui_num_dom_flags", 5);
  enablegroundwarspawnlogic(400, 1200);
  updategametypedvars();
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(::onjoinedteam);
  level.scoreperplayer = undefined;
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.modeonspawnplayer = ::onspawnplayer;
  level.onplayerkilled = ::onplayerkilled;
  level.onrespawndelay = ::getrespawndelay;
  level.onnormaldeath = ::onnormaldeath;
  level.onobjectivecomplete = _id_2DC3A143158CEC7C::onflagcapture;
  level.updatefobspawnselection = ::updatefobspawnselection;
  level.domflag_setneutral = _id_6663215F917210AE::domflag_setneutral;
  level.dompoint_setcaptured = _id_6663215F917210AE::dompoint_setcaptured;
  level.requiredplayercountoveride = 1;
  level.requiredplayercount["allies"] = 24;
  level.requiredplayercount["axis"] = 24;
  level._id_E637D49948A038D3 = ::getmissedinfilcamerapositions;
  level._id_3C89983E2030DFFF = ::calculatecameraoffset;

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    game["dialog"]["gametype"] = "iw9_mffa_mode_uktl_gwt1";
  else
    game["dialog"]["gametype"] = "iw9_mpgw_mode_uktl_name";

  if(getdvarint("scr_diehard"))
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  else if(getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_promode")))
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";

  game["dialog"]["offense_obj"] = "iw9_mpgw_mode_uktl_bost";
  game["dialog"]["defense_obj"] = "iw9_mpgw_mode_uktl_bost";
  game["dialog"]["securing_a"] = "iw9_mdom_mode_uktl_dsca";
  game["dialog"]["securing_b"] = "iw9_mdom_mode_uktl_dscb";
  game["dialog"]["securing_c"] = "iw9_mdom_mode_uktl_dscc";
  game["dialog"]["securing_d"] = "iw9_mdom_mode_uktl_dscd";
  game["dialog"]["securing_e"] = "iw9_mdom_mode_uktl_dsce";
  game["dialog"]["secured_a"] = "iw9_mdom_mode_uktl_dcpa";
  game["dialog"]["secured_b"] = "iw9_mdom_mode_uktl_dcpb";
  game["dialog"]["secured_c"] = "iw9_mdom_mode_uktl_dcpc";
  game["dialog"]["secured_d"] = "iw9_mdom_mode_uktl_dcpd";
  game["dialog"]["secured_e"] = "iw9_mdom_mode_uktl_dcpe";
  game["dialog"]["losing_a"] = "iw9_mdom_mode_uktl_dlsa";
  game["dialog"]["losing_b"] = "iw9_mdom_mode_uktl_dlsb";
  game["dialog"]["losing_c"] = "iw9_mdom_mode_uktl_dlsc";
  game["dialog"]["losing_d"] = "iw9_mdom_mode_uktl_dlsd";
  game["dialog"]["losing_e"] = "iw9_mdom_mode_uktl_dlse";
  game["dialog"]["lost_a"] = "iw9_mdom_mode_uktl_dloa";
  game["dialog"]["lost_b"] = "iw9_mdom_mode_uktl_dlob";
  game["dialog"]["lost_c"] = "iw9_mdom_mode_uktl_dloc";
  game["dialog"]["lost_d"] = "iw9_mdom_mode_uktl_dlod";
  game["dialog"]["lost_e"] = "iw9_mdom_mode_uktl_dloe";
  game["dialog"]["lost_all"] = "iw9_mdom_mode_uktl_doml";
  game["dialog"]["secure_all"] = "iw9_mdom_mode_uktl_domw";
  level.nosuspensemusic = 1;
  level._effect["vfx_smk_signal_gr"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal_gr");
  level._effect["vfx_snatch_ac130_clouds"] = loadfx("vfx/iw8_mp/gamemode/vfx_snatch_ac130_clouds.vfx");
  level._effect["vfx_br_infil_cloud_scroll"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_cloud_scroll.vfx");
  level._effect["vfx_br_infil_jump_smoke_01"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_smoke_01.vfx");
  level._effect["vfx_br_infil_jump_wisp_01"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_01.vfx");
  level._effect["vfx_br_infil_jump_wisp_02"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_02.vfx");
  level._effect["vfx_br_infil_omni_light"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_omni_light.vfx");
  level._effect["vfx_br_infil_spot_light"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_spot_light.vfx");
  level._id_A98A9986264D0EFC = getdvarint("dvar_6228446F42D1367F", 1) == 1;
  level.nukeselectactive = getdvarint("dvar_720C7A325F31F44B", 0);
  level.killstoearnnukeselect = getdvarint("dvar_B081C1DD5EA0AF33", 7);
  level.useobjectives = getdvarint("dvar_F487C553B2AE0BDB", 1);
  level.userallypointvehicles = getdvarint("dvar_9381D93D96C2F50B", 1);
  level.hideenemyfobs = getdvarint("dvar_7AEFD938EDD32DCC", 0);
  level.completelyremovelittlebird = getdvarint("dvar_E39E476D418A5B03", 0);
  level.usec130spawn = getdvarint("dvar_9D9BB5A2F8144FB0", 0);
  level.usec130spawnfirstonly = getdvarint("dvar_930CE0BF448DADAA", 0);
  level.c130movementmethod = getdvarint("dvar_2A34AC7D0124085E", 0);
  level.c130flightdist = getdvarfloat("dvar_2D511CFD4EB77221", 4000);
  level.c130distapart = getdvarfloat("dvar_EF46594CD3335BD3", 5000);
  level.c130alignedtolocale = getdvarfloat("dvar_F4DA32C36B5DCD26", 1);
  level._id_67A7732487FB9242 = getdvarint("dvar_E4A8296B521A6DEE", 1) == 1;
  level._id_90F4DC933B674184 = getdvarfloat("dvar_91D950C33D45AE50", 60.0);
  level._id_1A505675F3EF1197 = getdvarfloat("dvar_58C456EBD6371A4B", 60.0);
  level._id_8E9DABA162280A8E = getdvarint("dvar_19E5CADA53CCF044", 0) == 1;
  level._id_EAA760F325371803 = getdvarint("dvar_67A32114CE80B58F", 0) == 1;
  level._id_7F5BE0207E7457B1 = getdvarint("dvar_27ABAA55D7EC8EB9", 1) == 1;
  level._id_A6954A050D77D75C = getdvarint("scr_game_infilSkip", 0) == 1 || getdvarint("dvar_FF5233FCF546C6B1", 0) == 1;
  level._id_D23C7C1ADD9FB181 = _id_1D4B01C1EC829364::_id_D23C7C1ADD9FB181;
  level._id_4DE8052758F986F3 = _id_1D4B01C1EC829364::_id_4DE8052758F986F3;
  level._id_3CE1055115EDCBBB = _id_1D4B01C1EC829364::_id_3CE1055115EDCBBB;
  level._id_EFBC646224FDA4FA = _id_1D4B01C1EC829364::_id_EFBC646224FDA4FA;
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
  level.mercymatchending_nuke = getdvarint("dvar_647CFD0A848D6ED6", 1);
  level.mercymatchending_time = getdvarint("scr_arm_mercyendingtime", 30);
  level.numnonrallyvehicles = getdvarint("scr_arm_numnonrallyvehicles", 25);
  level.disablepersonalnuke = getdvarint("dvar_F271257BDDC28C95", 0);
  level.personalnukecostoverride = getdvarint("scr_personalnukecostoverride", 30);
  level.showteamtanks = getdvarint("dvar_236401104966B535", 1);
  level.spawnselectionafktime = getdvarint("dvar_DA4E1D4C2111A1BC", 120);
  level.manualadjustlittlebirdlocs = getdvarint("dvar_1D04716268113CB5", 1);
  level._id_B307135DBCEF5A38 = getdvarint("dvar_A9937F1A2710BCD8", 1);

  if(istrue(level.showteamtanks)) {
    level.trackedtanks = [];
    level.trackedtanks["axis"] = [];
    level.trackedtanks["allies"] = [];
  }

  if(level.useobjectives || level.userallypointvehicles || level.usesquadspawnselection) {
    setDvar("scr_game_usespawnselection", 1);
    setDvar("scr_game_disablespawncamera", 0);
    setDvar("dvar_1A2C3B67392B6657", 1);
  } else {
    setDvar("scr_game_usespawnselection", 0);
    setDvar("scr_game_disablespawncamera", 1);
    setDvar("dvar_1A2C3B67392B6657", 1);
  }

  if(level.c130movementmethod == 1) {
    level.c130pathkilltracker = [];
    level.c130pathkilltracker["axis"] = 0;
    level.c130pathkilltracker["allies"] = 0;
  }

  level.modecontrolledvehiclespawningonly = 1;
  level.disableteamstartspawns = 1;
  level.spawnprotectionexception = ::spawnprotectionexception;
  thread _id_658C8F668D2CD83C();

  if(getdvarint("dvar_60A5CD40EB9C3192", 0) == 1)
    level thread _id_2F4866552F0BA818::_id_5A426C120B990E2C();

  scripts\engine\utility::flag_init("stealth_enabled");
  scripts\engine\utility::flag_init("level_stealth_initialized");
  scripts\engine\utility::flag_init("stealth_spotted");
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("dvar_D4D118B003FBA411", getmatchrulesdata("kothData", "zoneLifetime"));
  setdynamicdvar("dvar_9E98511DD4AECAA9", getmatchrulesdata("kothData", "zoneCaptureTime"));
  setdynamicdvar("dvar_EEE91703AEB69145", getmatchrulesdata("kothData", "zoneActivationDelay"));
  setdynamicdvar("dvar_740BA249ACEC2B64", getmatchrulesdata("kothData", "randomLocationOrder"));
  setdynamicdvar("dvar_3AB8084DA34C4F35", getmatchrulesdata("kothData", "additiveScoring"));
  setdynamicdvar("dvar_B0CD219E4ED5F287", getmatchrulesdata("kothData", "pauseTime"));
  setdynamicdvar("dvar_56B7B535B0BD8D1A", getmatchrulesdata("tdefData", "spawnDelay"));
  scripts\mp\utility\game::registerhalftimedvar("arm", 0);
}

onstartgametype() {
  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  foreach(team in level.teamnamelist)
  scripts\mp\utility\game::setobjectivehinttext(team, &"OBJECTIVES/ARMSRACE_HINT");

  setclientnamemode("auto_change");
  level.objectives = [];
  level.uncapturableobjectives = [];
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
  debug_setupmatchdata();
  setuphqs();
  calculatehqmidpoint();

  if(istrue(level.useobjectives))
    setupobjectives();

  level thread runobjectives();

  if(level.usec130spawn)
    level thread _id_27C2DB69A21775A0::managec130spawns();

  if(istrue(level.userallypointvehicles)) {
    scripts\mp\rally_point::init();
    level thread _id_27C2DB69A21775A0::init_rallyvehicles();
  }

  thread _id_27C2DB69A21775A0::init_groundwarvehicles();
  level thread updatedomscores();
  scripts\mp\utility\dialog::initstatusdialog();

  if(istrue(level.mercymatchending_nuke))
    level thread nuke_mercyending_init();

  emergency_cleanupents();
  scripts\cp_mp\parachute::initparachutedvars();

  if(getdvarint("scr_br_armory_kiosk", 0) == 1) {
    level thread _id_640CF1641C03E2A0::_id_CA39A413ACE3C168();
    level thread _id_2BC0B0102F9B7751::_id_D0FFCD08E0870CF2();
    _id_4384ABBF498DF6A7::_id_B38F5FFE645943C3("gw_basic");
    level thread _id_1D4B01C1EC829364::_id_1629419647B0F862();
  }

  if(level.br_plunder_enabled && getdvarint("dvar_CDBBB44046B62549", 1) == 1)
    level thread _id_1D4B01C1EC829364::_id_5A1699B27399A21E();

  if(getdvarint("dvar_94FF1F40FF78051E", 0) == 1)
    level thread _id_2F4866552F0BA818::_id_0E86EA43131BE76C();
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
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
}

seticonnames() {
  level.iconcapture = "waypoint_capture";
  level.iconneutral = "waypoint_captureneutral";
  level.icondefend = "waypoint_defend";
  level.iconcontested = "waypoint_contested";
  level.icondefending = "waypoint_defending";
  level.icontaking = "waypoint_taking";
  level.iconlosing = "waypoint_losing";
  level._id_88E61386EF037AAF = "waypoint_clearing";
}

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
  scripts\cp_mp\utility\game_utility::removematchingents_bycodeclassname("trigger_use_touch");

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

onjoinedteam(player) {
  player _id_1D4B01C1EC829364::_id_6ED651811C936A22();
}

debug_setupmatchdata() {
  level._id_6121D66FFC5B8EC9 = [];
  level._id_6121D66FFC5B8EC9["axis"] = "gw_fob_axisHQ";
  level._id_6121D66FFC5B8EC9["allies"] = "gw_fob_alliesHQ";
  level.startingfobnames_allies = [];
  level.startingfobnames_axis = [];
  level.startingfobnames_neutral = ["gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05", "gw_fob_06", "gw_fob_07", "gw_fob_08", "gw_fob_09"];
  level.defaultaxisspawn = "gw_fob_axishq";
  level.defaultaxisspawncamera = "gw_fob_axishq";
  level.defaultalliesspawn = "gw_fob_allieshq";
  level.defaultalliesspawncamera = "gw_fob_allieshq";
}

setupwaypointicons() {
  while(!isDefined(level._id_0B23156D776B1D85) || !isDefined(level._id_0B23156D776B1D85._id_038F2A11237246AC))
    waitframe();

  foreach(_id_DFBD7318EF3CC9BD, _id_D442547D75DFFD09 in level._id_0B23156D776B1D85._id_038F2A11237246AC) {
    level.waypointcolors[_id_DFBD7318EF3CC9BD + "_incoming"] = "neutral";
    level.waypointbgtype[_id_DFBD7318EF3CC9BD + "_incoming"] = 1;
    level.waypointstring[_id_DFBD7318EF3CC9BD + "_incoming"] = "";
    level.waypointshader[_id_DFBD7318EF3CC9BD + "_incoming"] = scripts\engine\utility::ter_op(isDefined(_id_D442547D75DFFD09.hudicon), _id_D442547D75DFFD09.hudicon, "");
    level.waypointpulses[_id_DFBD7318EF3CC9BD + "_incoming"] = 0;
    level.waypointcolors[_id_DFBD7318EF3CC9BD] = "neutral";
    level.waypointbgtype[_id_DFBD7318EF3CC9BD] = 1;
    level.waypointstring[_id_DFBD7318EF3CC9BD] = "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS";
    level.waypointshader[_id_DFBD7318EF3CC9BD] = scripts\engine\utility::ter_op(isDefined(_id_D442547D75DFFD09.hudicon), _id_D442547D75DFFD09.hudicon, "");
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

setupobjectives() {
  level.gw_objstruct.startingfobs_allies = [];
  level.gw_objstruct.startingfobs_axis = [];
  level.gw_objstruct.startingfobs_neutral = [];
  _id_F6DDBB71B889A0BE = ["_a", "_b", "_c", "_d", "_e", "_f", "_g", "_h", "_i"];
  _id_A9B909BAC20BA503 = 0;

  foreach(_id_D83E5FA8F6CE891F in level.startingfobnames_allies) {
    fob = spawnStruct();
    fob.name = _id_D83E5FA8F6CE891F;
    fob.trigger = scripts\cp_mp\utility\game_utility::getlocaleent(_id_D83E5FA8F6CE891F);
    fob.trigger.objkey = _id_F6DDBB71B889A0BE[_id_A9B909BAC20BA503];
    _id_A9B909BAC20BA503++;
    level.gw_objstruct.startingfobs_allies[level.gw_objstruct.startingfobs_allies.size] = fob;
  }

  foreach(_id_D83E5FA8F6CE891F in level.startingfobnames_axis) {
    fob = spawnStruct();
    fob.name = _id_D83E5FA8F6CE891F;
    fob.trigger = scripts\cp_mp\utility\game_utility::getlocaleent(_id_D83E5FA8F6CE891F);
    fob.trigger.objkey = _id_F6DDBB71B889A0BE[_id_A9B909BAC20BA503];
    _id_A9B909BAC20BA503++;
    level.gw_objstruct.startingfobs_axis[level.gw_objstruct.startingfobs_axis.size] = fob;
  }

  foreach(_id_D83E5FA8F6CE891F in level.startingfobnames_neutral) {
    trigger = scripts\cp_mp\utility\game_utility::getlocaleent(_id_D83E5FA8F6CE891F);

    if(isDefined(trigger)) {
      fob = spawnStruct();
      fob.name = _id_D83E5FA8F6CE891F;
      fob.trigger = trigger;
      fob.trigger.objkey = _id_F6DDBB71B889A0BE[_id_A9B909BAC20BA503];
      _id_A9B909BAC20BA503++;
      level.gw_objstruct.startingfobs_neutral[level.gw_objstruct.startingfobs_neutral.size] = fob;
    }
  }

  setomnvar("ui_num_dom_flags", level.gw_objstruct.startingfobs_neutral.size);
}

updatedomscores() {
  level endon("game_ended");
  _id_929A6DF466DC4F22 = undefined;
  _id_AC865A705B3E1162 = undefined;
  level waittill("prematch_done");
  level thread scripts\mp\spawnselection::updatefobindanger();

  while(!level.gameended) {
    wait 10;
    scripts\mp\hostmigration::waittillhostmigrationdone();
    domflags = _id_1D4B01C1EC829364::getowneddomflags();

    if(!isDefined(level.scoretick))
      level.scoretick = [];

    foreach(_id_F90358454413407F in level.teamnamelist)
    level.scoretick[_id_F90358454413407F] = 0;

    if(domflags.size) {
      for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < domflags.size; _id_AC0E594AC96AA3A8++) {
        domflag = domflags[_id_AC0E594AC96AA3A8];
        _id_C2B268E253C97D27 = gettime() - domflag.capturetime;

        for(_id_AC0E5C4AC96AAA41 = _id_AC0E594AC96AA3A8 - 1; _id_AC0E5C4AC96AAA41 >= 0 && _id_C2B268E253C97D27 > gettime() - domflags[_id_AC0E5C4AC96AAA41].capturetime; _id_AC0E5C4AC96AAA41--)
          domflags[_id_AC0E5C4AC96AAA41 + 1] = domflags[_id_AC0E5C4AC96AAA41];

        domflags[_id_AC0E5C4AC96AAA41 + 1] = domflag;
      }

      foreach(domflag in domflags) {
        team = domflag scripts\mp\gameobjects::getownerteam();
        _id_929A6DF466DC4F22 = getteamscore(team);
        _id_FEE716687DD29378 = _id_6663215F917210AE::getteamflagcount(team);

        if(_id_FEE716687DD29378 >= level.flagsrequiredtoscore)
          level.scoretick[team] = level.scoretick[team] + level.pointsperflag;
      }
    }

    updatescores();
  }
}

updatescores() {
  _id_BC96F305D3D139CF = [];

  foreach(_id_F90358454413407F in level.teamnamelist) {
    _id_882B7AD682FF97CE = game["teamScores"][_id_F90358454413407F] + level.scoretick[_id_F90358454413407F];

    if(_id_882B7AD682FF97CE >= level.roundscorelimit)
      _id_BC96F305D3D139CF[_id_BC96F305D3D139CF.size] = _id_F90358454413407F;
  }

  if(_id_BC96F305D3D139CF.size == 1)
    level.scoretick[_id_BC96F305D3D139CF[0]] = level.roundscorelimit - game["teamScores"][_id_BC96F305D3D139CF[0]];

  _id_E80DC2F88D61C61C = scripts\mp\gamescore::calculatewinningteam();

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(level.scoretick[_id_F90358454413407F] > 0)
      scripts\mp\gamescore::giveteamscoreforobjective(_id_F90358454413407F, level.scoretick[_id_F90358454413407F], 1, undefined, 1);
  }

  _id_3397ACF8985DBD01 = scripts\mp\gamescore::calculatewinningteam();

  if(_id_E80DC2F88D61C61C != _id_3397ACF8985DBD01)
    scripts\mp\gamescore::playscorestatusdialog(_id_3397ACF8985DBD01, 1, _id_E80DC2F88D61C61C);
}

runobjectives(_id_AA030029A5B16AE5) {
  level.spawnareas = [];
  level._id_694388259AFB589B = [];

  foreach(_id_F90358454413407F in level.teamnamelist) {
    level.spawnareas[_id_F90358454413407F] = [level._id_6121D66FFC5B8EC9[_id_F90358454413407F]];
    level._id_694388259AFB589B[_id_F90358454413407F] = [level._id_6121D66FFC5B8EC9[_id_F90358454413407F]];
  }

  level.allfobs = [];

  if(istrue(level.useobjectives)) {
    foreach(fob in level.gw_objstruct.startingfobs_axis) {
      _id_DDCA7869B65236B6 = runobjflag(fob.trigger, "axis");
      level.allfobs[level.allfobs.size] = fob;
      level.spawnareas["axis"][level.spawnareas["axis"].size] = fob.name;
      level._id_694388259AFB589B["axis"][level._id_694388259AFB589B["axis"].size] = fob.name;
      level._id_694388259AFB589B["allies"][level._id_694388259AFB589B["allies"].size] = fob.name;

      if(isDefined(level.spawnselectionlocations[fob.name]["axis"].anchorentity))
        level.spawnselectionlocations[fob.name]["axis"].anchorentity.origin = fob.trigger.origin + (0, 0, 100);
    }

    foreach(fob in level.gw_objstruct.startingfobs_allies) {
      _id_DDCA7869B65236B6 = runobjflag(fob.trigger, "allies");
      level.allfobs[level.allfobs.size] = fob;
      level.spawnareas["allies"][level.spawnareas["allies"].size] = fob.name;
      level._id_694388259AFB589B["allies"][level._id_694388259AFB589B["allies"].size] = fob.name;
      level._id_694388259AFB589B["axis"][level._id_694388259AFB589B["axis"].size] = fob.name;

      if(isDefined(level.spawnselectionlocations[fob.name]["allies"].anchorentity))
        level.spawnselectionlocations[fob.name]["allies"].anchorentity.origin = fob.trigger.origin + (0, 0, 100);
    }

    foreach(fob in level.gw_objstruct.startingfobs_neutral) {
      _id_DDCA7869B65236B6 = runobjflag(fob.trigger, "neutral");
      level.allfobs[level.allfobs.size] = fob;
      level._id_694388259AFB589B["axis"][level._id_694388259AFB589B["axis"].size] = fob.name;
      level._id_694388259AFB589B["allies"][level._id_694388259AFB589B["allies"].size] = fob.name;

      if(isDefined(level.spawnselectionlocations[fob.name]["axis"].anchorentity))
        level.spawnselectionlocations[fob.name]["axis"].anchorentity.origin = fob.trigger.origin + (0, 0, 100);

      if(isDefined(level.spawnselectionlocations[fob.name]["allies"].anchorentity))
        level.spawnselectionlocations[fob.name]["allies"].anchorentity.origin = fob.trigger.origin + (0, 0, 100);
    }

    foreach(fob in level.allfobs) {
      fob.trigger.gameobject.oncontested = ::objective_oncontested;
      fob.trigger.gameobject.onuncontested = ::objective_onuncontested;
      fob.trigger.gameobject.onuse = ::objective_onuse;
      fob.trigger.gameobject.onbeginuse = ::objective_onusebegin;
      fob.trigger.gameobject.onenduse = ::objective_onuseend;
      fob.trigger.gameobject.onpinnedstate = ::objective_onpinnedstate;
      fob.trigger.gameobject.onunpinnedstate = ::objective_onunpinnedstate;

      if(istrue(level._id_DD7AF80C3EB2C1E0))
        fob._id_5261F4479B04F834 = _id_6663215F917210AE::_id_5261F4479B04F834;

      level.objectives[fob.trigger.gameobject.objectivekey] = fob.trigger.gameobject;
      level.spawnselectionlocations[fob.name]["allies"].objectivekey = fob.trigger.gameobject.objectivekey;
      level.spawnselectionlocations[fob.name]["axis"].objectivekey = fob.trigger.gameobject.objectivekey;
    }
  }

  if(level.usespawnselection) {
    if(istrue(level._id_B307135DBCEF5A38)) {
      scripts\mp\spawnselection::setspawnlocations(level._id_694388259AFB589B["axis"], "axis");
      scripts\mp\spawnselection::setspawnlocations(level._id_694388259AFB589B["allies"], "allies");
    } else {
      scripts\mp\spawnselection::setspawnlocations(level.spawnareas["axis"], "axis");
      scripts\mp\spawnselection::setspawnlocations(level.spawnareas["allies"], "allies");
    }

    sethqmarkerobjective();

    while(!isDefined(level.spawnselectionlocations))
      waitframe();

    waitframe();

    if(isDefined(level.spawnselectionlocations[level._id_6121D66FFC5B8EC9["axis"]]["axis"].anchorentity))
      level.spawnselectionlocations[level._id_6121D66FFC5B8EC9["axis"]]["axis"].anchorentity.origin = level.gw_objstruct.axishqloc.trigger.origin;

    if(isDefined(level.spawnselectionlocations[level._id_6121D66FFC5B8EC9["allies"]]["allies"].anchorentity))
      level.spawnselectionlocations[level._id_6121D66FFC5B8EC9["allies"]]["allies"].anchorentity.origin = level.gw_objstruct.allieshqloc.trigger.origin;
  }

  level thread objective_manageobjectivesintrovisibility();
  hackfixcameras();
  level thread allowobjectiveuseaftermatchstart();
  level._id_AA5583D4CBBFD72E = 1;
}

allowobjectiveuseaftermatchstart() {
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(fob in level.allfobs)
  fob.trigger.gameobject scripts\mp\gameobjects::allowuse("enemy");
}

objective_manageobjectivesintrovisibility() {
  wait 1;
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.gw_objstruct.axishqloc.marker.objidnum);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.gw_objstruct.allieshqloc.marker.objidnum);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.gw_objstruct.axishqloc.enemymarker.objidnum);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.gw_objstruct.allieshqloc.enemymarker.objidnum);

  foreach(fob in level.allfobs)
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(fob.trigger.gameobject.objidnum);

  if(isDefined(level.rallypointvehicles)) {
    foreach(rallypoint in level.rallypointvehicles)
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(rallypoint.marker.objidnum);
  }

  while(!scripts\mp\flags::gameflag("prematch_done"))
    waitframe();

  scripts\mp\objidpoolmanager::objective_teammask_addtomask(level.gw_objstruct.axishqloc.marker.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(level.gw_objstruct.allieshqloc.marker.objidnum, "allies");

  foreach(fob in level.allfobs)
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(fob.trigger.gameobject.objidnum);

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
  keys = ["gw_fob_alliesHQ", "gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05"];
  scripts\mp\spawncamera::_id_71A2A6A6F52AB30B(keys, team, forward, -8500, 7000);
  team = "axis";
  forward = level.spawnselectionteamforward[team];
  keys = ["gw_fob_axisHQ", "gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05"];
  scripts\mp\spawncamera::_id_71A2A6A6F52AB30B(keys, team, forward, -8500, 7000);
  level.spawncameras["default"]["allies"].origin = level.spawncameras["gw_fob_alliesHQ"]["allies"].origin;
  level.spawncameras["default"]["allies"].angles = level.spawncameras["gw_fob_alliesHQ"]["allies"].angles;
  level.spawncameras["default"]["axis"].origin = level.spawncameras["gw_fob_axisHQ"]["axis"].origin;
  level.spawncameras["default"]["axis"].angles = level.spawncameras["gw_fob_axisHQ"]["axis"].angles;
}

updatefobspawnselection() {
  level.spawnareas = [];

  foreach(_id_F90358454413407F in level.teamnamelist)
  level.spawnareas[_id_F90358454413407F] = [level._id_6121D66FFC5B8EC9[_id_F90358454413407F]];

  foreach(fob in level.allfobs) {
    gameobject = fob.trigger.gameobject;

    if(gameobject.ownerteam == "axis") {
      level.spawnareas["axis"][level.spawnareas["axis"].size] = fob.name;

      if(isDefined(level.spawnselectionlocations[fob.name]["axis"].anchorentity))
        level.spawnselectionlocations[fob.name]["axis"].anchorentity.origin = fob.trigger.origin + (0, 0, 100);

      continue;
    }

    if(gameobject.ownerteam == "allies") {
      level.spawnareas["allies"][level.spawnareas["allies"].size] = fob.name;

      if(isDefined(level.spawnselectionlocations[fob.name]["allies"].anchorentity))
        level.spawnselectionlocations[fob.name]["allies"].anchorentity.origin = fob.trigger.origin + (0, 0, 100);
    }
  }

  if(istrue(level._id_B307135DBCEF5A38)) {
    scripts\mp\spawnselection::setspawnlocations(level._id_694388259AFB589B["axis"], "axis");
    scripts\mp\spawnselection::setspawnlocations(level._id_694388259AFB589B["allies"], "allies");
  } else {
    scripts\mp\spawnselection::setspawnlocations(level.spawnareas["axis"], "axis");
    scripts\mp\spawnselection::setspawnlocations(level.spawnareas["allies"], "allies");
  }
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

objective_oncontested() {
  _id_6663215F917210AE::dompoint_oncontested();

  if(!istrue(self.updatedoncontestedspawnselection)) {
    updatefobspawnselection();
    self.updatedoncontestedspawnselection = 1;
  }
}

objective_onuncontested(lastclaimteam) {
  _id_6663215F917210AE::dompoint_onuncontested(lastclaimteam);

  if(istrue(self.updatedoncontestedspawnselection)) {
    updatefobspawnselection();
    self.updatedoncontestedspawnselection = 0;
  }
}

objective_onusebegin(player) {
  _id_6663215F917210AE::dompoint_onusebegin(player);
  updatefobspawnselection();
}

objective_onuseend(team, player, success) {
  _id_6663215F917210AE::dompoint_onuseend(team, player, success);
  updatefobspawnselection();
}

objective_onuse(_id_82236C155ECBEDC9) {
  _id_6663215F917210AE::dompoint_onuse(_id_82236C155ECBEDC9);
  updatefobspawnselection();

  if(istrue(level._id_EAA760F325371803))
    level thread _id_2F4866552F0BA818::_id_A30A48F0C1A403EC(self.objectivekey, self.ownerteam);

  otherteam = scripts\mp\utility\game::getotherteam(_id_82236C155ECBEDC9.team)[0];
  _id_1D4B01C1EC829364::_id_666A2979DEF5D705(otherteam, self.objectivekey);
  _id_1D4B01C1EC829364::_id_8D03978A31FABA3A(self.objectivekey, otherteam);
  _id_1D4B01C1EC829364::_id_E8A6E840EF663C81(self.objectivekey, self.ownerteam);
}

objective_onpinnedstate(player) {
  updatefobspawnselection();
  _id_6663215F917210AE::dompoint_onunpinnedstate(player);
}

objective_onunpinnedstate(player) {
  updatefobspawnselection();
  _id_6663215F917210AE::dompoint_onunpinnedstate(player);
}

runobjflag(objective, _id_35B9448411944BDC) {
  level endon("game_ended");

  while(!isDefined(level.spawnselectionlocations))
    waitframe();

  objective.script_label = objective.objkey;
  domflag = _id_6663215F917210AE::setupobjective(objective, undefined, undefined, undefined, 0);
  domflag.origin = objective.origin;
  domflag scripts\mp\gameobjects::allowuse("none");
  domflag.didstatusnotify = 0;
  domflag scripts\mp\gameobjects::setownerteam(_id_35B9448411944BDC);
  _id_7D3CF95BDBCA0939 = "any";

  if(_id_35B9448411944BDC != "neutral") {
    if(level.hideenemyfobs)
      _id_7D3CF95BDBCA0939 = "friendly";

    domflag.capturetime = gettime();
  }

  domflag scripts\mp\gameobjects::setvisibleteam(_id_7D3CF95BDBCA0939);
  return domflag;
}

dropcrate(_id_D8061F26B5ECA018, _id_76A22C18960F72AF, team) {
  crate = scripts\cp_mp\killstreaks\airdrop::droparmcratefromscriptedheli(team, _id_D8061F26B5ECA018, _id_76A22C18960F72AF.origin, (0, randomint(360), 0), undefined);
  return crate;
}

docratedropsmoke(crate, _id_76A22C18960F72AF, duration) {
  _id_E0D03A39E88DFF15 = _id_76A22C18960F72AF.origin + (0, 0, 2000);
  spawnpos = scripts\common\utility::groundpos(_id_E0D03A39E88DFF15, (0, 0, 1));
  _id_76A22C18960F72AF.vfxent = spawn("script_model", spawnpos);
  _id_76A22C18960F72AF.vfxent setModel("tag_origin");
  _id_76A22C18960F72AF.vfxent.angles = (0, 0, 0);
  _id_76A22C18960F72AF.vfxent playLoopSound("smoke_carepackage_smoke_lp");
  wait 1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_gr"), _id_76A22C18960F72AF.vfxent, "tag_origin");

  if(isDefined(crate))
    crate scripts\engine\utility::waittill_any_timeout_1(duration, "crate_dropped");
  else
    wait(duration);

  stopFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_gr"), _id_76A22C18960F72AF.vfxent, "tag_origin");
  _id_76A22C18960F72AF.vfxent delete();
}

registervaliddroplocations() {
  scripts\cp_mp\killstreaks\airdrop::initplundercratedata();
  level.validdroplocationstruct = spawnStruct();
  level.validdroplocationstruct.clusters = scripts\engine\utility::getStructArray("dropBagCluterNode", "script_noteworthy");
  _id_1BD7657BD69C8A8C = scripts\engine\utility::getStructArray("dropBagLocation", "script_noteworthy");

  foreach(location in _id_1BD7657BD69C8A8C) {
    location.inuse = 0;

    foreach(_id_3402D60C1EF6B931 in level.validdroplocationstruct.clusters) {
      if(location.target == _id_3402D60C1EF6B931.targetname) {
        if(!isDefined(_id_3402D60C1EF6B931.droplocations))
          _id_3402D60C1EF6B931.droplocations = [];

        _id_3402D60C1EF6B931.droplocations[_id_3402D60C1EF6B931.droplocations.size] = location;
        continue;
      }
    }
  }

  level.nextkillstreakgoal = 100;

  if(0)
    thread debug_testcratedroplocationpicker();
}

debug_testcratedroplocationpicker() {
  for(;;) {
    choosecratelocation();
    wait 1;
  }
}

checkkillstreakcratedrop(team) {
  if(game["teamScores"][team] >= level.nextkillstreakgoal) {
    level.nextkillstreakgoal = level.nextkillstreakgoal + 100;
    dropkillstreakcrates(2);
  }
}

dropkillstreakcrates(_id_FD2FEE325481DC7F) {
  _id_C7709EA550BBB458 = undefined;

  foreach(player in level.players) {
    if(isDefined(player)) {
      _id_C7709EA550BBB458 = player;
      break;
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FD2FEE325481DC7F; _id_AC0E594AC96AA3A8++) {
    location = choosecratelocation();
    thread runkillstreakreward(location, _id_C7709EA550BBB458, getkillstreak(1));
    wait 5;
  }
}

choosecratelocation() {
  _id_695A8B6F4AAEEEE6 = randomfloatrange(0, 1.0);
  _id_1B090DB7AD64072D = vectorlerp(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, _id_695A8B6F4AAEEEE6);
  _id_1B090AB7AD640094 = vectorlerp(level.c130pathstruct_b.endpt, level.c130pathstruct_b.startpt, _id_695A8B6F4AAEEEE6);
  _id_92459AE9B006B9F7 = vectorlerp(_id_1B090DB7AD64072D, _id_1B090AB7AD640094, 0.5);
  trace = scripts\engine\trace::ray_trace(_id_92459AE9B006B9F7, _id_92459AE9B006B9F7 - (0, 0, 100000));
  _id_92459AE9B006B9F7 = trace["position"];
  _id_794937A10118F0D9 = findclosestdroplocation(_id_92459AE9B006B9F7);

  if(0) {
    thread scripts\mp\utility\debug::drawsphere(_id_1B090DB7AD64072D, 1000, 100, (0, 0, 1));
    thread scripts\mp\utility\debug::drawsphere(_id_1B090AB7AD640094, 1000, 100, (0, 0, 1));
    thread scripts\mp\utility\debug::drawsphere(_id_92459AE9B006B9F7, 1000, 100, (1, 0, 0));
    thread scripts\mp\utility\debug::drawsphere(_id_794937A10118F0D9.origin, 1000, 100, (0, 1, 0));
    thread scripts\mp\utility\debug::drawline(_id_92459AE9B006B9F7, _id_794937A10118F0D9.origin, 3, (0, 1, 0));
  }

  return _id_794937A10118F0D9;
}

findclosestdroplocation(origin) {
  startlocation = spawnStruct();
  startlocation.origin = origin;
  _id_206C7349DD628BC8 = startlocation scripts\engine\utility::array_sort_with_func(level.validdroplocationstruct.clusters, ::sortlocationsbydistance);

  foreach(_id_3402D60C1EF6B931 in _id_206C7349DD628BC8) {
    _id_D6D0D0AB47B5B334 = scripts\engine\utility::array_randomize(_id_3402D60C1EF6B931.droplocations);

    if(0)
      return _id_D6D0D0AB47B5B334[0];
    else {
      foreach(location in _id_D6D0D0AB47B5B334) {
        if(!location.inuse) {
          location.inuse = 1;
          return location;
        }
      }
    }
  }

  return undefined;
}

choosenukecratelocation() {
  _id_308DA8B1FED334CE = randomfloatrange(level.mapsafecorners[1][0], level.mapsafecorners[0][0]);
  _id_308DA9B1FED33701 = randomfloatrange(level.mapsafecorners[1][1], level.mapsafecorners[0][1]);
  _id_92459AE9B006B9F7 = (_id_308DA8B1FED334CE, _id_308DA9B1FED33701, 100000);
  trace = scripts\engine\trace::ray_trace(_id_92459AE9B006B9F7, _id_92459AE9B006B9F7 - (0, 0, 100000));
  _id_92459AE9B006B9F7 = trace["position"];
  _id_794937A10118F0D9 = findclosestdroplocation(_id_92459AE9B006B9F7);

  if(0) {
    thread scripts\mp\utility\debug::drawsphere(_id_92459AE9B006B9F7, 1000, 100, (1, 0, 0));
    thread scripts\mp\utility\debug::drawsphere(_id_794937A10118F0D9, 1000, 100, (0, 1, 0));
    thread scripts\mp\utility\debug::drawline(_id_92459AE9B006B9F7, _id_794937A10118F0D9.origin, 3, (0, 1, 0));
  }

  return _id_794937A10118F0D9;
}

runkillstreakreward(location, _id_58E8D1412BC688CD, streakname) {
  level endon("game_ended");
  crate = undefined;
  object = scripts\mp\gameobjects::createobjidobject(location.origin, "neutral", (0, 0, 72), undefined, "any");
  object.origin = location.origin;
  object.angles = location.angles;
  thread docratedropsmoke(undefined, location, 16);
  object.iconname = "_incoming";
  object.lockupdatingicons = 0;
  object scripts\mp\gameobjects::setobjectivestatusicons(streakname);
  object.lockupdatingicons = 1;
  wait 4;
  crate = scripts\cp_mp\killstreaks\airdrop::droparmcratefromscriptedheli(_id_58E8D1412BC688CD.team, streakname, location.origin, (0, randomint(360), 0), undefined);
  crate.skipminimapicon = 1;
  crate.nevertimeout = 0;
  crate.waitforobjectiveactivate = 1;
  crate.killminimapicon = 0;
  crate.disallowheadiconid = 1;
  crate.isarmcrate = 1;
  crate waittill("crate_dropped");
  object.useobj = crate;
  object.origin = crate.origin;
  _id_DE9E30874C191943 = 0;
  interval = 0.1;
  wait 1;
  crate notify("objective_activate");
  scripts\mp\objidpoolmanager::update_objective_onentity(object.objidnum, crate);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(object.objidnum, 72);
  object.iconname = "";
  object.lockupdatingicons = 0;
  object scripts\mp\gameobjects::setobjectivestatusicons(streakname);
  object.lockupdatingicons = 1;
  objective_setlabel(object.objidnum, "");
  crate waittill("death");
  object scripts\mp\gameobjects::setvisibleteam("none");
  object scripts\mp\gameobjects::releaseid();
  object.visibleteam = "none";
}

getkillstreak(tier) {
  if(!isDefined(level.killstreaktierlist))
    processkillstreaksintotiers();

  level.killstreaktierlist[tier] = scripts\engine\utility::array_randomize(level.killstreaktierlist[tier]);
  return level.killstreaktierlist[tier][0];
}

processkillstreaksintotiers() {
  level.killstreaktierlist = [];
  level.killstreaktierlist[3] = ["cruise_predator", "scrambler_drone_guard", "uav"];
  level.killstreaktierlist[2] = ["precision_airstrike", "multi_airstrike", "bradley"];
  level.killstreaktierlist[1] = ["toma_strike", "uav", "pac_sentry", "white_phosphorus"];
  level.killstreaktierlist[0] = ["uav"];
}

br_getrewardicon(streakname) {
  _id_D442547D75DFFD09 = level._id_0B23156D776B1D85._id_038F2A11237246AC[streakname];

  if(isDefined(_id_D442547D75DFFD09) && isDefined(_id_D442547D75DFFD09.hudicon))
    return _id_D442547D75DFFD09.hudicon;

  return "";
}

nuke_mercyending_init() {
  scripts\mp\flags::gameflagwait("prematch_done");

  if(istrue(level.useobjectives))
    level thread nuke_mercyending_think();
}

nuke_mercyending_think() {
  level endon("game_ended");
  level endon("mercy_ending_timer_started");

  for(;;) {
    if(calculateobjectivesheld("axis") == level.objectives.size)
      level thread nuke_startmercycountdown("axis");
    else if(calculateobjectivesheld("allies") == level.objectives.size)
      level thread nuke_startmercycountdown("allies");

    waitframe();
  }
}

nuke_startmercycountdown(team) {
  level notify("mercy_ending_timer_started");
  level endon("mercy_ending_triggered");
  setomnvar("ui_nuke_timer_type", 1);
  setomnvar("ui_arm_dominatingTeam", scripts\engine\utility::ter_op(team == "axis", 1, 2));
  setomnvar("ui_nuke_timer_time", level.mercymatchending_time);
  setomnvar("ui_nuke_countdown_active", 1);
  _id_D984AAAFBB3F49E0 = 0;
  starttime = gettime();
  endtime = level.mercymatchending_time * 1000 + starttime;
  setomnvar("ui_nuke_end_milliseconds", level.mercymatchending_time * 1000 + starttime);

  while(calculateobjectivesheld(team) == level.objectives.size) {
    waitframe();

    if(gettime() > endtime) {
      nuke_triggermercywin(team);
      level notify("mercy_ending_triggered");
    }
  }

  setomnvar("ui_nuke_countdown_active", 0);
  level thread nuke_mercyending_think();
}

nuke_triggermercywin(team) {
  level endon("game_ended");
  level.mercywintriggered = 1;
  level.blocknukekills = 1;

  foreach(objective in level.objectives)
  objective scripts\mp\gameobjects::allowuse("none");

  setomnvar("ui_nuke_countdown_active", 0);

  foreach(player in level.players) {
    if(isDefined(player) && !isbot(player) && istrue(player.inspawnselection)) {
      if(isDefined(player.operatorsfx)) {
        player clearsoundsubmix("iw8_mp_spawn_camera");
        player.operatorsfx stoploopsound(player.operatorsfxalias);
        player.operatorsfx delete();
        player.operatorsfx = undefined;
        player.operatorsfxalias = undefined;
      }
    }
  }

  if(isDefined(level.teamdata[team]["alivePlayers"][0])) {
    _id_39E8F33513C716CD = level.teamdata[team]["alivePlayers"][0];
    _id_39E8F33513C716CD scripts\cp_mp\killstreaks\nuke::tryusenuke("nuke_multi");
  } else
    level thread scripts\mp\gamelogic::endgame(team, game["end_reason"]["mercy_win"], game["end_reason"]["mercy_loss"], 0, 1);
}

nukeselectgimmewatcher(_id_6181DE250AFA5BB6) {
  if(!istrue(_id_6181DE250AFA5BB6.hasnukeselectks)) {
    _id_02C0DC6323DDFA44 = _id_6181DE250AFA5BB6.killcountthislife % level.killstoearnnukeselect;

    if(_id_02C0DC6323DDFA44 >= 0 && _id_6181DE250AFA5BB6.killcountthislife >= level.killstoearnnukeselect) {
      _id_6181DE250AFA5BB6.hasnukeselectks = 1;
      _id_6181DE250AFA5BB6 thread scripts\mp\killstreaks\killstreaks::givekillstreak("nuke_select_location", 0, 0, _id_6181DE250AFA5BB6);
      _id_6181DE250AFA5BB6 scripts\mp\hud_message::showkillstreaksplash("nuke_select_location", undefined, 1);
    }
  }
}

initspawns(_id_4C3936C2C179FAB3) {
  level.gamemodestartspawnpointnames = [];

  if(istrue(_id_4C3936C2C179FAB3)) {
    _id_48501209A3E177A7 = "mp_gw_spawn_allies_start";
    _id_AE7D0107AD485428 = "mp_gw_spawn_axis_start";
    _id_E77FE17F16335F61 = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_allies_start_mod");

    if(_id_E77FE17F16335F61.size > 0)
      _id_48501209A3E177A7 = "mp_gw_spawn_allies_start_mod";

    _id_202C2C36D99ADA78 = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_axis_start_mod");

    if(_id_202C2C36D99ADA78.size > 0)
      _id_AE7D0107AD485428 = "mp_gw_spawn_axis_start_mod";
  } else {
    _id_48501209A3E177A7 = "mp_gw_spawn_allies_start";
    _id_AE7D0107AD485428 = "mp_gw_spawn_axis_start";
  }

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
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], _id_48501209A3E177A7);
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], _id_AE7D0107AD485428);
  attackers = scripts\mp\spawnlogic::getspawnpointarray(_id_48501209A3E177A7);
  _id_2FD93EA689E77097 = scripts\mp\spawnlogic::getspawnpointarray(_id_AE7D0107AD485428);
  scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", _id_2FD93EA689E77097);
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
}

calculatespawndisttozones(spawnpoint) {
  spawnpoint.scriptdata.distsqtokothzones = [];

  foreach(zone in level.objectives) {
    dist = getpathdist(spawnpoint.origin, zone.origin, 5000);

    if(dist < 0)
      dist = scripts\engine\utility::distance_2d_squared(spawnpoint.origin, zone.origin);
    else
      dist = dist * dist;

    spawnpoint.scriptdata.distsqtokothzones[zone getentitynumber()] = dist;

    if(dist > zone.furthestspawndistsq)
      zone.furthestspawndistsq = dist;
  }
}

getspawnpoint() {
  spawnteam = self.pers["team"];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(spawnteam == game["attackers"]) {
      scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers");
    } else {
      scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders");
    }
  } else {
    scripts\mp\spawnlogic::activatespawnset("normal", 1);
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "fallback");
  }

  if(istrue(level.usesquadspawn) && istrue(self.squadspawnconfirmed)) {
    _id_279BB6642EC5E695 = self getspectatingplayer();

    if(isDefined(_id_279BB6642EC5E695) && isDefined(self._id_0FF97225579DE16A) && self.team == _id_279BB6642EC5E695.team && self._id_0FF97225579DE16A == _id_279BB6642EC5E695._id_0FF97225579DE16A)
      spawnpoint = scripts\mp\spawnscoring::findteammatebuddyspawn(_id_279BB6642EC5E695);
  }

  return spawnpoint;
}

onspawnplayer(_id_9156B53BCF7CE573) {
  self.forcespawnnearteammates = undefined;
  thread updatematchstatushintonspawn();
  _id_03F1B6713CA4C9C7::_id_6DA8B65579348D0B();
  _id_76CC264B397DB9CB::updatesquadomnvars(self.team, self._id_0FF97225579DE16A);
}

updatematchstatushintonspawn() {
  level endon("game_ended");

  if(isDefined(level.nukeprogress))
    scripts\mp\hud_message::_id_F004EF4606B9EFDC("nuke_capture");
  else
    scripts\mp\hud_message::_id_F004EF4606B9EFDC("dom_cap_defend");
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  _id_76CC264B397DB9CB::updatesquadomnvars(self.team, self._id_0FF97225579DE16A);
  _id_6663215F917210AE::awardgenericmedals(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00);

  if(level.dropbrloot) {
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
    dropstruct._id_DFBA5A2C3C6F0A07 = 14;
    _id_6AFF3948CF4CCA03::playerdropplunderondeath(dropstruct, attacker, 1);
  }

  if(level.nukeselectactive && isPlayer(attacker) && smeansofdeath != "MOD_SUICIDE") {
    if(!isDefined(attacker.killcountthislife))
      attacker.killcountthislife = 0;

    if(!istrue(attacker.hasnukeselectks))
      attacker.killcountthislife++;

    nukeselectgimmewatcher(attacker);
  }

  if(!isDefined(level.c130pathkilltracker) || level.c130movementmethod != 1) {
    return;
  }
  level.c130pathkilltracker[self.team] = level.c130pathkilltracker[self.team] + 1;
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

  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);
}

onplayerdisconnect(player) {}

updategamemodespawncamera() {
  _id_1FD5D62338AB6DE2 = "lane02_4";

  if(isDefined(level.activezone))
    _id_1FD5D62338AB6DE2 = level.activezone.zonetrigger.script_label;

  scripts\mp\spawncamera::setgamemodecamera("allies", level.spawncameras[_id_1FD5D62338AB6DE2]["allies"]);
  scripts\mp\spawncamera::setgamemodecamera("axis", level.spawncameras[_id_1FD5D62338AB6DE2]["axis"]);
}

debugdrawtocameras() {
  for(;;) {
    wait 0.25;

    if(!isDefined(level.players[0])) {
      continue;
    }
    foreach(loc, _id_5A9CFC3686B1FD8D in level.spawncameras) {
      foreach(team, camera in _id_5A9CFC3686B1FD8D) {
        thread scripts\mp\utility\debug::drawangles(camera.origin, camera.angles, 0.25, 50);
        thread scripts\mp\utility\debug::drawsphere(camera.origin, 50.0, 0.25, scripts\engine\utility::ter_op(team == "allies", (0, 0, 1), (1, 0, 0)));
      }
    }
  }
}

onplayerspawned(player) {
  for(;;)
    player waittill("spawned");
}

getownerteamplayer(ownerteam) {
  _id_A3010F9814A40C8D = undefined;

  foreach(player in level.players) {
    if(player.team == ownerteam) {
      _id_A3010F9814A40C8D = player;
      break;
    }
  }

  return _id_A3010F9814A40C8D;
}

getrespawndelay() {
  self.spawncameraskipthermal = 0;
  return undefined;
}

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  _id_0FD32F08E72B657F::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
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
    if(istrue(trigger._id_0456768C2E700260)) {
      level.outofboundstriggers[level.outofboundstriggers.size] = trigger;
      continue;
    }

    if((scripts\mp\utility\game::getgametype() == "sd" || scripts\mp\utility\game::getgametype() == "rescue" || scripts\mp\utility\game::getgametype() == "cyber") && trigger.classname == "trigger_rotatable_radius") {
      level.outofboundstriggers[level.outofboundstriggers.size] = trigger;
      continue;
    }

    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(trigger.script_noteworthy) && trigger.script_noteworthy == level.localeid && scripts\mp\utility\game_utility_mp::modeusesgroundwarteamoobtriggers(trigger)) {
      level.outofboundstriggers[level.outofboundstriggers.size] = trigger;
      continue;
    }

    if(level.mapname == "mp_nogales_gw2" && ispointinvolume((20500, 31700, 2500), trigger) && distancesquared((14038, 35144, 4608), trigger.origin) < 100) {
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

sortlocationsbydistance(_id_0FCF7E6E6D8C4861, _id_0FCF7B6E6D8C41C8) {
  return distancesquared(_id_0FCF7E6E6D8C4861.origin, self.origin) < distancesquared(_id_0FCF7B6E6D8C41C8.origin, self.origin);
}

calculatedroplocationnearlocation(location, _id_636C8575D7A7768B, maxdist) {
  pos = location.origin;
  x = undefined;
  y = undefined;
  _id_8B591B0BC361AB3D = randomint(2);
  direction = scripts\engine\utility::ter_op(_id_8B591B0BC361AB3D, -1.0, 1.0);

  if(direction > 0) {
    x = randomfloatrange(pos[0] + _id_636C8575D7A7768B * direction, pos[0] + maxdist * direction);

    if(x >= level.br_level.br_corners[0][0])
      x = level.br_level.br_corners[0][0] - 250;
  } else {
    x = randomfloatrange(pos[0] + maxdist * direction, pos[0] + _id_636C8575D7A7768B * direction);

    if(x <= level.br_level.br_corners[1][0])
      x = level.br_level.br_corners[1][0] + 250;
  }

  _id_8B591B0BC361AB3D = randomint(2);
  direction = scripts\engine\utility::ter_op(_id_8B591B0BC361AB3D, -1.0, 1.0);

  if(direction > 0) {
    y = randomfloatrange(pos[1] + _id_636C8575D7A7768B * direction, pos[1] + maxdist * direction);

    if(y >= level.br_level.br_corners[0][1])
      y = level.br_level.br_corners[0][1] - 250;
  } else {
    y = randomfloatrange(pos[1] + maxdist * direction, pos[1] + _id_636C8575D7A7768B * direction);

    if(y >= level.br_level.br_corners[1][1])
      y = level.br_level.br_corners[1][1] + 250;
  }

  _id_76A22C18960F72AF = spawnStruct();
  _id_76A22C18960F72AF.origin = (x, y, pos[2]);
  return _id_76A22C18960F72AF;
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
      case "locale_34":
      case "locale_33":
      case "locale_28":
        if(team == "axis") {
          _id_B379BC48DC371726.startorigin = (-8111.37, -50208.9, 1201.16);
          _id_B379BC48DC371726.startangles = (15, 176, 0);
          _id_B379BC48DC371726.endorigin = (-13177.5, -45326.2, 2957.64);
          _id_B379BC48DC371726.endangles = (41, 267, 0);
        } else {
          _id_B379BC48DC371726.startorigin = (7966.23, -35390.7, 1891.99);
          _id_B379BC48DC371726.startangles = (19, 352, 0);
          _id_B379BC48DC371726.endorigin = (11447.2, -40764, 2908.09);
          _id_B379BC48DC371726.endangles = (29, 76, 0);
        }

        break;
      case "locale_51":
      case "locale_50":
        if(team == "axis") {
          _id_B379BC48DC371726.startorigin = (-37269.9, -27684.2, 1093.4);
          _id_B379BC48DC371726.startangles = (13, 135, 0);
          _id_B379BC48DC371726.endorigin = (-38918.5, -22218, 2139);
          _id_B379BC48DC371726.endangles = (37, 240, 0);
        } else {
          _id_B379BC48DC371726.startorigin = (-31446.2, -18677.9, 883.622);
          _id_B379BC48DC371726.startangles = (10, 36, 0);
          _id_B379BC48DC371726.endorigin = (-30766.5, -23149.7, 1726.86);
          _id_B379BC48DC371726.endangles = (34, 42, 0);
        }

        break;
      case "locale_200":
        if(team == "allies") {
          _id_B379BC48DC371726.startorigin = (7124, 11776, 2556);
          _id_B379BC48DC371726.startangles = (13.829, 335.3, 0);
          _id_B379BC48DC371726.endorigin = (9004, 10088, 1988);
          _id_B379BC48DC371726.endangles = (24.9985, 220.001, -0.000213426);
        } else {
          _id_B379BC48DC371726.startorigin = (-15827.3, -133.42, 1550.86);
          _id_B379BC48DC371726.startangles = (13.829, 335.3, 0);
          _id_B379BC48DC371726.endorigin = (-14335.3, -3621.42, 1550.86);
          _id_B379BC48DC371726.endangles = (8.53518, 55.9275, 2.37782);
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