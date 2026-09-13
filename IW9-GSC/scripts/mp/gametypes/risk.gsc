/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\risk.gsc
***********************************************/

main() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  level thread _id_2C3C204D81FEB239();
  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(::onjoinedteam);

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
  setDvar("dvar_42EECE3F15E35B3D", 1);
  setDvar("dvar_A22F98E2C5B506CE", 30);
  setDvar("dvar_E4FA721677F03DE0", 1);
  setDvar("cg_friendlyReviveNameplateEnabled", 0);
  updategametypedvars();
  level.scoreperplayer = undefined;
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.modeonspawnplayer = ::onspawnplayer;
  level.onplayerkilled = ::onplayerkilled;
  level.onrespawndelay = ::getrespawndelay;
  level.onnormaldeath = ::onnormaldeath;
  level.ontimelimit = ::ontimelimit;
  level.onobjectivecomplete = _id_2DC3A143158CEC7C::onflagcapture;
  level.updatefobspawnselection = ::updatefobspawnselection;
  level.lastcaptime = gettime();
  level.promode = 1;
  level._id_A88344345B7590C8 = ::setupspawnlocations;
  level._id_E637D49948A038D3 = ::getmissedinfilcamerapositions;
  level._id_3C89983E2030DFFF = ::calculatecameraoffset;
  level._id_1063C425DDAB3330 = ::createdefaultcameras;
  level._id_D280C5FDB0036183 = ::_id_DC3A172BF923D9B3;
  level._id_72C2648CE78BEA79 = 1;
  level._id_8F6541607D5DDA6B = 1;

  if(getdvarint("dvar_9AB6D986E0FD6416", 1) == 1)
    level._id_840E89B17AC632EE = ::_id_B7262FC0DA03A04F;

  game["dialog"]["gametype"] = "gametype_groundwar";

  if(getdvarint("scr_diehard"))
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  else if(getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_promode")))
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";

  game["dialog"]["offense_obj"] = "boost_groundwar";
  game["dialog"]["defense_obj"] = "boost_groundwar";
  game["dialog"]["obj_destroyed"] = "obj_destroyed";
  game["dialog"]["obj_captured"] = "obj_captured";
  game["dialog"]["securing_a"] = "securing_a";
  game["dialog"]["securing_b"] = "securing_b";
  game["dialog"]["securing_c"] = "securing_c";
  game["dialog"]["securing_d"] = "securing_d";
  game["dialog"]["securing_e"] = "securing_e";
  game["dialog"]["secured_a"] = "secured_a";
  game["dialog"]["secured_b"] = "secured_b";
  game["dialog"]["secured_c"] = "secured_c";
  game["dialog"]["secured_d"] = "secured_d";
  game["dialog"]["secured_e"] = "secured_e";
  game["dialog"]["losing_a"] = "losing_a";
  game["dialog"]["losing_b"] = "losing_b";
  game["dialog"]["losing_c"] = "losing_c";
  game["dialog"]["losing_d"] = "losing_d";
  game["dialog"]["losing_e"] = "losing_e";
  game["dialog"]["lost_a"] = "lost_a";
  game["dialog"]["lost_b"] = "lost_b";
  game["dialog"]["lost_c"] = "lost_c";
  game["dialog"]["lost_d"] = "lost_d";
  game["dialog"]["lost_e"] = "lost_e";
  game["dialog"]["lost_all"] = "gamestate_domlosing";
  game["dialog"]["secure_all"] = "gamestate_domwinning";
  game["dialog"]["securing_f"] = "flag_securing";
  game["dialog"]["securing_g"] = "flag_securing";
  game["dialog"]["securing_h"] = "flag_securing";
  game["dialog"]["securing_i"] = "flag_securing";
  game["dialog"]["securing_j"] = "flag_securing";
  game["dialog"]["securing_k"] = "flag_securing";
  game["dialog"]["securing_l"] = "flag_securing";
  game["dialog"]["securing_m"] = "flag_securing";
  game["dialog"]["securing_n"] = "flag_securing";
  game["dialog"]["securing_o"] = "flag_securing";
  game["dialog"]["secured_f"] = "flag_secured";
  game["dialog"]["secured_g"] = "flag_secured";
  game["dialog"]["secured_h"] = "flag_secured";
  game["dialog"]["secured_i"] = "flag_secured";
  game["dialog"]["secured_j"] = "flag_secured";
  game["dialog"]["secured_k"] = "flag_secured";
  game["dialog"]["secured_l"] = "flag_secured";
  game["dialog"]["secured_m"] = "flag_secured";
  game["dialog"]["secured_n"] = "flag_secured";
  game["dialog"]["secured_o"] = "flag_secured";
  game["dialog"]["losing_f"] = "flag_losing";
  game["dialog"]["losing_g"] = "flag_losing";
  game["dialog"]["losing_h"] = "flag_losing";
  game["dialog"]["losing_i"] = "flag_losing";
  game["dialog"]["losing_j"] = "flag_losing";
  game["dialog"]["losing_k"] = "flag_losing";
  game["dialog"]["losing_l"] = "flag_losing";
  game["dialog"]["losing_m"] = "flag_losing";
  game["dialog"]["losing_n"] = "flag_losing";
  game["dialog"]["losing_o"] = "flag_losing";
  game["dialog"]["lost_f"] = "flag_lost";
  game["dialog"]["lost_g"] = "flag_lost";
  game["dialog"]["lost_h"] = "flag_lost";
  game["dialog"]["lost_i"] = "flag_lost";
  game["dialog"]["lost_j"] = "flag_lost";
  game["dialog"]["lost_k"] = "flag_lost";
  game["dialog"]["lost_l"] = "flag_lost";
  game["dialog"]["lost_m"] = "flag_lost";
  game["dialog"]["lost_n"] = "flag_lost";
  game["dialog"]["lost_o"] = "flag_lost";
  level._effect["vfx_smk_signal"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal");
  level._effect["vfx_smk_signal_gr"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal_gr");
  level._effect["vfx_snatch_ac130_clouds"] = loadfx("vfx/iw8_mp/gamemode/vfx_snatch_ac130_clouds.vfx");
  level._effect["vfx_br_infil_cloud_scroll"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_cloud_scroll.vfx");
  level._effect["vfx_br_infil_jump_smoke_01"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_smoke_01.vfx");
  level._effect["vfx_br_infil_jump_wisp_01"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_01.vfx");
  level._effect["vfx_br_infil_jump_wisp_02"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_02.vfx");
  level._effect["vfx_br_infil_omni_light"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_omni_light.vfx");
  level._effect["vfx_br_infil_spot_light"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_spot_light.vfx");
  level.nukeselectactive = getdvarint("dvar_720C7A325F31F44B", 0);
  level.killstoearnnukeselect = getdvarint("dvar_B081C1DD5EA0AF33", 7);
  level._id_1FFD19A2A9A5AA20 = getdvarint("dvar_27D2C9AE0137A563", 0) == 1;
  level.useobjectives = getdvarint("dvar_921E6EE792D53981", 1) == 1;
  level.userallypointvehicles = getdvarint("dvar_9381D93D96C2F50B", 0);
  level.hideenemyfobs = getdvarint("dvar_7AEFD938EDD32DCC", 0);
  level.completelyremovelittlebird = getdvarint("dvar_E39E476D418A5B03", 0);
  level.usec130spawn = getdvarint("dvar_9D9BB5A2F8144FB0", 0);
  level.usec130spawnfirstonly = getdvarint("dvar_930CE0BF448DADAA", 0);
  level.c130movementmethod = getdvarint("dvar_2A34AC7D0124085E", 0);
  level.c130flightdist = getdvarfloat("dvar_2D511CFD4EB77221", 4000);
  level.c130distapart = getdvarfloat("dvar_EF46594CD3335BD3", 5000);
  level.c130alignedtolocale = getdvarfloat("dvar_F4DA32C36B5DCD26", 1);
  level.parachutedeploydelay = getdvarfloat("dvar_10A03CAB3EBE8CFA", 3.0);
  level.dropbrloot = getdvarint("dvar_1D196605F8A290E3", 1);
  level.br_plunder_enabled = getdvarint("dvar_A6A9B41B654AFD1D", 1);
  level._id_1E17E3480B1D264D = getdvarint("dvar_D18FA801B9479B9C", 1);
  level._id_1F42DAB41EFF5CB2 = getdvarint("dvar_A62824C80691FDE2", 1);

  if(level._id_1E17E3480B1D264D)
    level._id_9C1E3C18B99409E9 = scripts\mp\utility\points::_id_9C1E3C18B99409E9;

  level.spawnselectionshowenemy = getdvarint("dvar_3F0DB83EA7503667", 0);
  level.spawnselectionshowfriendly = getdvarint("dvar_4134532F274E5DFA", 0);
  level.forcetopickafob = getdvarint("dvar_04A4C22866751F8E", 0);
  level.maxhqtanks = getdvarint("dvar_9DD6B3477D4B53C6", 2);
  level.tankrespawntime = getdvarint("dvar_B624863894A18F21", 120);
  level.apcrespawntime = getdvarint("dvar_BA2474692378B203", 120);
  level.longdialoguecooldown = getdvarint("dvar_E01953FCF34A5D51", 1);
  level.mercymatchending_nuke = getdvarint("dvar_D45CEA76B09D2CC5", 1);
  level.mercymatchending_time = getdvarint("dvar_799330195191B929", 60);
  level._id_AE48BC1A4B9CAA1C = getdvarint("dvar_0667DE5DFFC8B4CC", 1);
  level.numnonrallyvehicles = getdvarint("scr_arm_numnonrallyvehicles", 25);
  level.disablepersonalnuke = getdvarint("dvar_F271257BDDC28C95", 0);
  level.personalnukecostoverride = getdvarint("dvar_D9455F252FCCDB97", 30);
  level.showteamtanks = getdvarint("dvar_236401104966B535", 1);
  level.spawnselectionafktime = getdvarint("dvar_DA4E1D4C2111A1BC", 120);
  level.manualadjustlittlebirdlocs = getdvarint("dvar_1D04716268113CB5", 1);
  level.objectivescaler = getdvarint("dvar_64BBA1553089DAD4", 1.25);
  level._id_F59A46460CC3CAB5 = getdvarvector("dvar_2C4216225B4F446C", (23000, -14000, 0));
  level._id_4B80E3B89AD4842B = anglesToForward(getdvarvector("dvar_FED70E0E680B8240", (0, 90, 0)));
  level._id_F0EE57FB9EBFB867 = getdvarfloat("dvar_781225E0D23D5DDD", -22000);
  level._id_8D385A761D1D2E9F = getdvarfloat("dvar_808507211E1B1E33", 25000);
  level._id_EFB4EC5A8F5352BF = getdvarint("dvar_E76AEFCAFD544237", 0) == 1;
  level._id_67A7732487FB9242 = getdvarint("dvar_1DCD7C87DA382733", 1) == 1;
  level._id_90F4DC933B674184 = getdvarfloat("dvar_2EA02C74510FDCF9", 60.0);
  level._id_1A505675F3EF1197 = getdvarfloat("dvar_45ADEF1640013BB2", 60.0);
  level._id_8E9DABA162280A8E = getdvarint("dvar_34CD8A4B783E9D79", 1) == 1;
  level._id_EAA760F325371803 = getdvarint("dvar_F9B3581542E787C4", 1) == 1;
  level._id_7F5BE0207E7457B1 = getdvarint("dvar_C56057FD4BBAF32C", 1) == 1;
  level._id_4DE8052758F986F3 = ::_id_4DE8052758F986F3;
  level._id_3CE1055115EDCBBB = ::_id_3CE1055115EDCBBB;
  level._id_EFBC646224FDA4FA = ::_id_EFBC646224FDA4FA;

  if(level.useobjectives || level.userallypointvehicles || level.usesquadspawnselection) {
    setDvar("dvar_6E73595F4CE7501E", 1);
    setDvar("dvar_5FC696F5BBB3CA62", 0);
    setDvar("dvar_1A2C3B67392B6657", 1);
  } else {
    setDvar("dvar_6E73595F4CE7501E", 0);
    setDvar("dvar_5FC696F5BBB3CA62", 1);
    setDvar("dvar_1A2C3B67392B6657", 1);
  }

  setomnvar("ui_risk_obj_held_allies", 0);
  setomnvar("ui_risk_obj_held_axis", 0);
  setomnvar("ui_risk_obj_held_team_three", 0);
  setomnvar("ui_risk_obj_held_team_four", 0);

  if(level.c130movementmethod == 1) {
    level.c130pathkilltracker = [];
    level.c130pathkilltracker["axis"] = 0;
    level.c130pathkilltracker["allies"] = 0;
  }

  level.modecontrolledvehiclespawningonly = 1;
  level.disableteamstartspawns = 1;
  level.spawnprotectionexception = ::spawnprotectionexception;
  scripts\engine\utility::flag_init("stealth_enabled");
  scripts\engine\utility::flag_init("level_stealth_initialized");
  scripts\engine\utility::flag_init("stealth_spotted");
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  scripts\mp\utility\game::registerhalftimedvar("risk", 0);
}

onstartgametype() {
  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  setclientnamemode("auto_change");
  level.objectives = [];
  level.uncapturableobjectives = [];
  level.requiredplayercountoveride = 1;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    level.requiredplayercount[_id_F90358454413407F] = 6;

    if(istrue(level.showteamtanks))
      level.trackedtanks[_id_F90358454413407F] = [];
  }

  level._id_111C5F085A86C2F0 = ::_id_111C5F085A86C2F0;
  level._id_ABA39CAF969CD3F7 = ::_id_ABA39CAF969CD3F7;
  initspawns();
  seticonnames();
  level.usedomflag = 0;
  level thread setupwaypointicons();
  debug_setupmatchdata();
  level.gw_objstruct = spawnStruct();

  if(istrue(level._id_1FFD19A2A9A5AA20))
    setuphqs();

  if(istrue(level.useobjectives))
    setupobjectives();

  level thread runobjectives();

  if(level.usec130spawn)
    level thread managec130spawns();

  if(istrue(level.userallypointvehicles)) {
    scripts\mp\rally_point::init();
    level thread init_rallyvehicles();
  }

  thread init_groundwarvehicles();
  _id_AA0D1F90DCC5D366();
  _id_FB11675119ADE7D4();
  _id_5456C21DE8F2BBBC();

  if(getdvarint("scr_br_armory_kiosk", 0) == 1)
    _id_1629419647B0F862();

  if(getdvarint("dvar_261D66A288205DAE", 1) == 1)
    level thread _id_5A1699B27399A21E();

  scripts\mp\utility\dialog::initstatusdialog();

  if(istrue(level.mercymatchending_nuke)) {
    level._id_213E22EC0A4C13BA = [];
    level thread nuke_mercyending_init();
  }

  emergency_cleanupents();
  scripts\cp_mp\parachute::initparachutedvars();
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_compass", "shouldBeVisibleToPlayer", ::_id_F69E35A602975879);
  level thread _id_640CF1641C03E2A0::_id_CA39A413ACE3C168();
  level thread _id_2BC0B0102F9B7751::_id_D0FFCD08E0870CF2();
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level.pausescoring = scripts\mp\utility\dvars::dvarintvalue("pauseTime", 1, 0, 1);
  level.delayplayer = scripts\mp\utility\dvars::dvarintvalue("delayPlayer", 1, 0, 1);
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

debug_setupmatchdata() {
  level._id_0FC3733232F9C6B6 = [];

  foreach(_id_F90358454413407F in level.teamnamelist)
  level._id_0FC3733232F9C6B6[_id_F90358454413407F] = [];

  level.startingfobnames_neutral = ["risk_a", "risk_b", "risk_c", "risk_d", "risk_e", "risk_f", "risk_g", "risk_h", "risk_i", "risk_j", "risk_k", "risk_l", "risk_m", "risk_n", "risk_o", "risk_p", "risk_q", "risk_r"];

  if(getDvar("dvar_2B703A46D024BD77", "") != "") {
    level.startingfobnames_neutral = [];
    _id_1D7EAE3DF85707DF = strtok(getDvar("dvar_2B703A46D024BD77", ""), ",");

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1D7EAE3DF85707DF.size; _id_AC0E594AC96AA3A8++) {
      _id_1D7EAE3DF85707DF[_id_AC0E594AC96AA3A8] = "risk_" + _id_1D7EAE3DF85707DF[_id_AC0E594AC96AA3A8];
      level.startingfobnames_neutral[level.startingfobnames_neutral.size] = _id_1D7EAE3DF85707DF[_id_AC0E594AC96AA3A8];
    }
  }
}

seticonnames() {
  level.iconcapture = "waypoint_capture";
  level.iconneutral = "waypoint_captureneutral";
  level.icondefend = "waypoint_defend";
  level.iconcontested = "waypoint_contested";
  level.icondefending = "waypoint_defending";
  level.icontaking = "waypoint_taking";
  level.iconlosing = "waypoint_losing";
}

setupwaypointicons() {
  _id_A443300A7CC92EF0 = 0;
  _id_CED44BB139651FA8 = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];

  foreach(_id_783809DA65285CB1 in _id_CED44BB139651FA8) {
    scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_dom_" + _id_783809DA65285CB1, _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_" + _id_783809DA65285CB1, 0);
    scripts\mp\gamelogic::setwaypointiconinfo("waypoint_taking_" + _id_783809DA65285CB1, _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_" + _id_783809DA65285CB1, 1);
    scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture_" + _id_783809DA65285CB1, _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_" + _id_783809DA65285CB1, 0);
    scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend_" + _id_783809DA65285CB1, _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_" + _id_783809DA65285CB1, 0);
    scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defending_" + _id_783809DA65285CB1, _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_" + _id_783809DA65285CB1, 0);
    scripts\mp\gamelogic::setwaypointiconinfo("waypoint_blocking_" + _id_783809DA65285CB1, _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_" + _id_783809DA65285CB1, 1);
    scripts\mp\gamelogic::setwaypointiconinfo("waypoint_blocked_" + _id_783809DA65285CB1, _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_" + _id_783809DA65285CB1, 1);
    scripts\mp\gamelogic::setwaypointiconinfo("waypoint_losing_" + _id_783809DA65285CB1, _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_" + _id_783809DA65285CB1, 1);
    scripts\mp\gamelogic::setwaypointiconinfo("waypoint_captureneutral_" + _id_783809DA65285CB1, _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_" + _id_783809DA65285CB1, 0);
    scripts\mp\gamelogic::setwaypointiconinfo("waypoint_contested_" + _id_783809DA65285CB1, _id_A443300A7CC92EF0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_" + _id_783809DA65285CB1, 1);
    scripts\mp\gamelogic::setwaypointiconinfo("waypoint_dom_target_" + _id_783809DA65285CB1, _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_" + _id_783809DA65285CB1, 0);
  }

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
  level._id_6121D66FFC5B8EC9 = [];

  foreach(team in level.teamnamelist) {
    level._id_6121D66FFC5B8EC9[team] = "risk_hq_" + team;
    level.gw_objstruct._id_384217DDF47CCB48[team] = spawnStruct();
    level.gw_objstruct._id_384217DDF47CCB48[team].trigger = _id_766A95324AB2AAD3(team);
  }
}

_id_766A95324AB2AAD3(team) {
  switch (team) {
    case "axis":
      return spawn("trigger_radius", (14225, -4600, -500), 0, 300, 128);
    case "allies":
      return spawn("trigger_radius", (27950, -5700, -465), 0, 300, 128);
    case "team_three":
      return spawn("trigger_radius", (30400, -21200, -395), 0, 300, 128);
    case "team_four":
      return spawn("trigger_radius", (16300, -21525, -210), 0, 300, 128);
    default:
      return spawn("trigger_radius", (0, 0, 0), 0, 300, 128);
  }
}

setupobjectives() {
  level.gw_objstruct._id_C20C12B2E617D1CB = [];

  foreach(_id_F90358454413407F in level.teamnamelist)
  level.gw_objstruct._id_C20C12B2E617D1CB[_id_F90358454413407F] = [];

  level.gw_objstruct.startingfobs_neutral = [];
  _id_F6DDBB71B889A0BE = ["_a", "_b", "_c", "_d", "_e", "_f", "_g", "_h", "_i", "_j", "_k", "_l", "_m", "_n", "_o", "_p", "_q", "_r", "_s", "_t", "_u", "_v", "_w", "_x", "_y", "_z"];
  _id_A9B909BAC20BA503 = 0;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    foreach(_id_D83E5FA8F6CE891F in level._id_0FC3733232F9C6B6[_id_F90358454413407F]) {
      fob = spawnStruct();
      fob.name = _id_D83E5FA8F6CE891F;
      fob.trigger = scripts\cp_mp\utility\game_utility::getlocaleent(_id_D83E5FA8F6CE891F);
      fob.trigger.objkey = _id_F6DDBB71B889A0BE[_id_A9B909BAC20BA503];
      _id_A9B909BAC20BA503++;
      level.gw_objstruct._id_C20C12B2E617D1CB[_id_F90358454413407F][level.gw_objstruct._id_C20C12B2E617D1CB[_id_F90358454413407F].size] = fob;
    }
  }

  foreach(_id_D83E5FA8F6CE891F in level.startingfobnames_neutral) {
    fob = spawnStruct();
    fob.name = _id_D83E5FA8F6CE891F;
    fob.trigger = scripts\cp_mp\utility\game_utility::getlocaleent(_id_D83E5FA8F6CE891F);
    fob.trigger.objkey = _id_F6DDBB71B889A0BE[_id_A9B909BAC20BA503];
    _id_A9B909BAC20BA503++;
    level.gw_objstruct.startingfobs_neutral[level.gw_objstruct.startingfobs_neutral.size] = fob;
  }

  if(scripts\cp_mp\utility\game_utility::getmapname() == "mp_downtown_gw" && getdvarint("dvar_9B80AAC5287C580F", 0) == 1) {
    foreach(obj in _id_F6DDBB71B889A0BE) {
      if(getdvarvector(_func_2EF675C13CA1C4AF("dvar_AC622F742B7EFCCF", obj), (0, 0, 0)) != (0, 0, 0)) {
        foreach(fob in level.gw_objstruct.startingfobs_neutral) {
          if(fob.trigger.objkey == obj)
            fob.trigger.origin = getdvarvector(_func_2EF675C13CA1C4AF("dvar_AC622F742B7EFCCF", obj), (0, 0, 0));
        }
      }
    }
  }

  _id_79BF7801C1DD360C = getdvarint("dvar_47AD5E5A550536F2", -1);

  if(_id_79BF7801C1DD360C > -1) {
    while(_id_79BF7801C1DD360C < level.gw_objstruct.startingfobs_neutral.size)
      level.gw_objstruct.startingfobs_neutral = scripts\engine\utility::array_remove_index(level.gw_objstruct.startingfobs_neutral, randomint(level.gw_objstruct.startingfobs_neutral.size));
  }
}

_id_5A1699B27399A21E() {
  level endon("game_ended");
  _id_929A6DF466DC4F22 = undefined;
  _id_AC865A705B3E1162 = undefined;
  level waittill("prematch_done");
  level thread scripts\mp\spawnselection::updatefobindanger();

  while(!level.gameended) {
    wait(getdvarint("dvar_67A52BBC5F1E1AA0", 20));
    scripts\mp\hostmigration::waittillhostmigrationdone();
    domflags = getowneddomflags();

    if(!isDefined(level._id_9461E150CBB24A1B))
      level._id_9461E150CBB24A1B = [];

    foreach(_id_F90358454413407F in level.teamnamelist)
    level._id_9461E150CBB24A1B[_id_F90358454413407F] = 0;

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
        _id_FEE716687DD29378 = _id_6663215F917210AE::getteamflagcount(team);

        if(_id_FEE716687DD29378 >= level.flagsrequiredtoscore)
          level._id_9461E150CBB24A1B[team] = level._id_9461E150CBB24A1B[team] + level._id_1F42DAB41EFF5CB2;
      }
    }

    _id_D1B78E4D5310CD3B();
  }
}

_id_D1B78E4D5310CD3B() {
  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(level._id_9461E150CBB24A1B[_id_F90358454413407F] > 0) {
      foreach(player in scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "players"))
      player[[level._id_9C1E3C18B99409E9]](level._id_9461E150CBB24A1B[_id_F90358454413407F]);
    }
  }
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
    domflags = getowneddomflags();

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

getowneddomflags() {
  domflags = [];

  foreach(domflag in level.objectives) {
    if(domflag scripts\mp\gameobjects::getownerteam() != "neutral" && isDefined(domflag.capturetime))
      domflags[domflags.size] = domflag;
  }

  return domflags;
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

_id_D178DB205C1FB9D1(team) {
  _id_FEE716687DD29378 = 0;

  if(team != "neutral") {
    _id_FEE716687DD29378 = _id_6663215F917210AE::getteamflagcount(team);
    setomnvar("ui_risk_obj_held_" + team, _id_FEE716687DD29378);
  }

  if(_id_FEE716687DD29378 >= level._id_035022A7857106C0 && !scripts\engine\utility::array_contains(level._id_213E22EC0A4C13BA, team))
    level._id_213E22EC0A4C13BA[level._id_213E22EC0A4C13BA.size] = team;

  if(isDefined(self._id_8A04AA0E0755E7E3) && self._id_8A04AA0E0755E7E3 != "neutral") {
    _id_20CB1803648CBC73 = _id_6663215F917210AE::getteamflagcount(self._id_8A04AA0E0755E7E3);
    setomnvar("ui_risk_obj_held_" + self._id_8A04AA0E0755E7E3, _id_20CB1803648CBC73);

    if(level._id_213E22EC0A4C13BA.size > 0 && _id_20CB1803648CBC73 < level._id_035022A7857106C0 && scripts\engine\utility::array_contains(level._id_213E22EC0A4C13BA, self._id_8A04AA0E0755E7E3))
      level._id_213E22EC0A4C13BA = scripts\engine\utility::array_remove(level._id_213E22EC0A4C13BA, self._id_8A04AA0E0755E7E3);
  }
}

_id_3667B4285D355DD9(team) {
  foreach(flag in level.objectives) {
    if(flag scripts\mp\gameobjects::getownerteam() == team)
      flag _id_4CE0A109EC9345AB();
  }
}

_id_E23F5E44B6C9E25C(team) {
  foreach(flag in level.objectives) {
    flag scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
    flag scripts\cp_mp\utility\game_utility::_id_F630402329582086();
  }
}

_id_4CE0A109EC9345AB() {
  _id_6E831C5902E07B4C = getdvarint("dvar_1E488CEB6504874F", 2500);
  ownerteam = scripts\mp\gameobjects::getownerteam();
  scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
  scripts\cp_mp\utility\game_utility::_id_F630402329582086();
  scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("Risk_Circle_defcon", self.trigger.origin, _id_6E831C5902E07B4C);

  foreach(team, teamdata in level.teamdata) {
    if(teamdata["players"].size > 0 && team != ownerteam) {
      foreach(player in teamdata["players"])
      scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(player);
    }
  }

  scripts\cp_mp\utility\game_utility::_id_DB48978D7206BD41("Risk_Circle_allies", self.trigger.origin, _id_6E831C5902E07B4C);

  foreach(player in scripts\mp\utility\teams::getteamdata(ownerteam, "players"))
  scripts\cp_mp\utility\game_utility::_id_FAB8EC5FEB7D4C9C(player);
}

_id_D70BDCD0D50615D3(ownerteam) {
  switch (ownerteam) {
    case "allies":
      return "allies";
    case "axis":
      return "axis";
    case "team_three":
      return "team_three";
    case "team_four":
      return "team_four";
    default:
      return "axis_red";
  }
}

runobjectives(_id_AA030029A5B16AE5) {
  level.spawnareas = [];

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(level._id_1FFD19A2A9A5AA20) {
      level.spawnareas[_id_F90358454413407F] = [level._id_6121D66FFC5B8EC9[_id_F90358454413407F]];
      continue;
    }

    level.spawnareas[_id_F90358454413407F] = [];
  }

  level.allfobs = [];

  if(istrue(level.useobjectives)) {
    foreach(_id_F90358454413407F in level.teamnamelist) {
      foreach(fob in level._id_0FC3733232F9C6B6[_id_F90358454413407F]) {
        objective = runobjflag(fob.trigger, _id_F90358454413407F);
        objective.name = fob.name;
        level.allfobs[level.allfobs.size] = objective;
        level.spawnareas[_id_F90358454413407F][level.spawnareas[_id_F90358454413407F].size] = fob.name;

        if(isDefined(level.spawnselectionlocations[fob.name][_id_F90358454413407F].anchorentity))
          level.spawnselectionlocations[fob.name][_id_F90358454413407F].anchorentity.origin = fob.trigger.origin + (0, 0, 100);
      }
    }

    foreach(fob in level.gw_objstruct.startingfobs_neutral) {
      objective = runobjflag(fob.trigger, "neutral");
      objective.name = fob.name;

      if(isDefined(objective.objidnum))
        scripts\mp\objidpoolmanager::_id_D7E3C4A08682C1B9(objective.objidnum, 1);

      level.allfobs[level.allfobs.size] = objective;
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
    }
  }

  level._id_F13FCCB3E4A9F326 = 1;

  if(level.usesquadspawnselection) {
    if(level._id_1FFD19A2A9A5AA20)
      sethqmarkerobjective();

    foreach(_id_F90358454413407F in level.teamnamelist) {
      if(isDefined(level.spawnareas[_id_F90358454413407F]))
        scripts\mp\spawnselection::setspawnlocations(level.spawnareas[_id_F90358454413407F], _id_F90358454413407F);
    }

    while(!isDefined(level.spawnselectionlocations))
      waitframe();

    waitframe();

    if(level._id_1FFD19A2A9A5AA20) {
      foreach(team in level.teamnamelist) {
        if(isDefined(level.spawnselectionlocations[level._id_6121D66FFC5B8EC9[team]][team].anchorentity))
          level.spawnselectionlocations[level._id_6121D66FFC5B8EC9[team]][team].anchorentity.origin = level.gw_objstruct._id_384217DDF47CCB48[team].trigger.origin;
      }
    }

    foreach(fob in level.allfobs) {
      foreach(_id_F90358454413407F in level.teamnamelist)
      level.spawnselectionlocations[fob.name][_id_F90358454413407F].objectivekey = fob.trigger.gameobject.objectivekey;
    }
  }

  level thread objective_manageobjectivesintrovisibility();
  level thread allowobjectiveuseaftermatchstart();
  setomnvar("ui_num_dom_flags", level.objectives.size);
}

allowobjectiveuseaftermatchstart() {
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(fob in level.allfobs)
  fob.trigger.gameobject scripts\mp\gameobjects::allowuse("enemy");
}

objective_manageobjectivesintrovisibility() {
  wait 1;

  if(level._id_1FFD19A2A9A5AA20) {
    foreach(team in level.teamnamelist)
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.gw_objstruct._id_384217DDF47CCB48[team].marker.objidnum);
  }

  foreach(fob in level.allfobs)
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(fob.trigger.gameobject.objidnum);

  if(isDefined(level.rallypointvehicles)) {
    foreach(rallypoint in level.rallypointvehicles)
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(rallypoint.marker.objidnum);
  }

  while(!scripts\mp\flags::gameflag("prematch_done"))
    waitframe();

  if(level._id_1FFD19A2A9A5AA20) {
    foreach(team in level.teamnamelist)
    scripts\mp\objidpoolmanager::objective_teammask_addtomask(level.gw_objstruct._id_384217DDF47CCB48[team].marker.objidnum, team);
  }

  foreach(fob in level.allfobs)
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(fob.trigger.gameobject.objidnum);

  if(isDefined(level.rallypointvehicles)) {
    foreach(rallypoint in level.rallypointvehicles) {
      if(isDefined(rallypoint))
        scripts\mp\objidpoolmanager::objective_teammask_addtomask(rallypoint.marker.objidnum, rallypoint.team);
    }
  }
}

sethqmarkerobjective() {
  _id_7D3CF95BDBCA0939 = "any";

  foreach(team in level.teamnamelist) {
    origin = level.gw_objstruct._id_384217DDF47CCB48[team].trigger.origin;
    marker = scripts\mp\gameobjects::createobjidobject(origin, "neutral", (0, 0, 0), undefined, _id_7D3CF95BDBCA0939, 0);
    scripts\mp\objidpoolmanager::update_objective_ownerteam(marker.objidnum, team);
    scripts\mp\objidpoolmanager::objective_teammask_addtomask(marker.objidnum, team);
    scripts\mp\objidpoolmanager::objective_set_play_intro(marker.objidnum, 0);
    marker.lockupdatingicons = 0;
    scripts\mp\objidpoolmanager::objective_pin_global(marker.objidnum, 0);
    scripts\mp\objidpoolmanager::update_objective_icon(marker.objidnum, "icon_waypoint_hq_friendly");
    scripts\mp\objidpoolmanager::update_objective_setbackground(marker.objidnum, 6);
    marker.lockupdatingicons = 1;
    level.gw_objstruct._id_384217DDF47CCB48[team].marker = marker;
    level.uncapturableobjectives[level.uncapturableobjectives.size] = marker;
  }
}

_id_111C5F085A86C2F0() {
  if(!isDefined(level.gw_objstruct._id_384217DDF47CCB48)) {
    return;
  }
  if(level._id_A50B22FA98674A50)
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.gw_objstruct._id_384217DDF47CCB48[self.team].marker.objidnum, self);
  else
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct._id_384217DDF47CCB48[self.team].marker.objidnum, self);

  _id_B0C33D224B825287 = scripts\mp\utility\teams::getenemyteams(self.team);

  foreach(enemyteam in _id_B0C33D224B825287) {
    if(level._id_F15BECFBC1B01A1B) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.gw_objstruct._id_384217DDF47CCB48[enemyteam].marker.objidnum, self);
      continue;
    }

    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct._id_384217DDF47CCB48[enemyteam].marker.objidnum, self);
  }
}

_id_ABA39CAF969CD3F7() {
  if(!isDefined(level.gw_objstruct._id_384217DDF47CCB48)) {
    return;
  }
  if(level._id_757EC02DF4D678F5)
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.gw_objstruct._id_384217DDF47CCB48[self.team].marker.objidnum, self);
  else
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct._id_384217DDF47CCB48[self.team].marker.objidnum, self);

  _id_B0C33D224B825287 = scripts\mp\utility\teams::getenemyteams(self.team);

  foreach(enemyteam in _id_B0C33D224B825287) {
    if(level._id_6F40C2B6970373C0) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.gw_objstruct._id_384217DDF47CCB48[enemyteam].marker.objidnum, self);
      continue;
    }

    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct._id_384217DDF47CCB48[enemyteam].marker.objidnum, self);
  }
}

updatefobspawnselection() {
  level.spawnareas = [];

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(level._id_1FFD19A2A9A5AA20) {
      level.spawnareas[_id_F90358454413407F] = [level._id_6121D66FFC5B8EC9[_id_F90358454413407F]];
      continue;
    }

    level.spawnareas[_id_F90358454413407F] = [];
  }

  foreach(fob in level.allfobs) {
    gameobject = fob.trigger.gameobject;

    if(gameobject.ownerteam != "neutral") {
      level.spawnareas[gameobject.ownerteam][level.spawnareas[gameobject.ownerteam].size] = fob.name;

      if(isDefined(level.spawnselectionlocations[fob.name][gameobject.ownerteam].anchorentity))
        level.spawnselectionlocations[fob.name][gameobject.ownerteam].anchorentity.origin = fob.trigger.origin + (0, 0, 100);
    }
  }

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(isDefined(level.spawnareas[_id_F90358454413407F]))
      scripts\mp\spawnselection::setspawnlocations(level.spawnareas[_id_F90358454413407F], _id_F90358454413407F);
  }
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

objective_onuse(_id_82236C155ECBEDC9, team) {
  if(!isDefined(team))
    _id_BD0124B2572298D0 = _id_82236C155ECBEDC9.team;
  else
    _id_BD0124B2572298D0 = team;

  _id_6663215F917210AE::dompoint_onuse(_id_82236C155ECBEDC9, team);
  team = scripts\mp\gameobjects::getownerteam();
  _id_D178DB205C1FB9D1(team);

  if(getdvarint("dvar_37F19F5A0CFA7CC3", 1) == 1 && istrue(level._id_F9747E9B80B3C33A)) {
    if(istrue(level._id_AE48BC1A4B9CAA1C)) {
      foreach(_id_0446395D3380CA51 in level._id_213E22EC0A4C13BA) {
        if(team == _id_0446395D3380CA51) {
          _id_4CE0A109EC9345AB();
          continue;
        }

        scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
        scripts\cp_mp\utility\game_utility::_id_F630402329582086();
      }
    } else if(isDefined(level._id_5932BBEF2FA89F92) && _id_BD0124B2572298D0 == level._id_5932BBEF2FA89F92)
      _id_4CE0A109EC9345AB();
    else {
      scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
      scripts\cp_mp\utility\game_utility::_id_F630402329582086();
    }
  } else if(getdvarint("dvar_3C11F8853FB930A3", 0) == 1)
    _id_4CE0A109EC9345AB();

  updatefobspawnselection();
  _id_666A2979DEF5D705(self.objectivekey);

  if(self.ownerteam == "neutral") {
    return;
  }
  _id_E8A6E840EF663C81(self.objectivekey, self.ownerteam);

  if(istrue(level._id_67A7732487FB9242)) {
    if(!isDefined(self._id_C4DC2BC15E70599D))
      self._id_C4DC2BC15E70599D = 1;
    else
      self._id_C4DC2BC15E70599D++;

    capturetime = level._id_90F4DC933B674184 * self._id_C4DC2BC15E70599D;

    if(capturetime > level._id_1A505675F3EF1197)
      capturetime = level._id_1A505675F3EF1197;

    scripts\mp\gameobjects::setusetime(capturetime);
    _func_FCE61CB0E2F1FC68(level.objectives[self.objectivekey].objidnum, 1);
  }

  if(istrue(level._id_EAA760F325371803)) {
    groupname = _id_48814951E916AF89::_id_78759441C259F58A();
    numagents = getdvarint("dvar_3AC57A7FBBFE5CF8", 4);

    if(numagents > 0) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < numagents; _id_AC0E594AC96AA3A8++) {
        aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB();
        agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, self.trigger.origin, (0, 0, 0), "medium", "everybody", "captureAgents", groupname, team);

        if(isDefined(agent)) {
          agent scripts\stealth\enemy::bt_set_stealth_state("combat", undefined);
          agent _id_120270BD0A747A35::_id_304DA84D9A815C01(self.trigger.origin, 1024);
          agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF("body_spetsnaz_cqc", "head_spetsnaz_cqc");
        }
      }
    }

    _id_40E875A042B82875 = getdvarint("dvar_2C76D4F86FD341DE", 1);

    if(_id_40E875A042B82875 > 0) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_40E875A042B82875; _id_AC0E594AC96AA3A8++) {
        agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF("enemy_mp_jugg_base", self.trigger.origin, (0, 0, 0), "absolute", "everybody", "jugg", groupname, team);

        if(isDefined(agent)) {
          _id_371B4C2AB5861E62::_id_1828F1E20E52B418(agent);
          agent scripts\stealth\enemy::bt_set_stealth_state("combat", undefined);
          agent _id_120270BD0A747A35::_id_304DA84D9A815C01(self.trigger.origin, 1024);
        }
      }
    }
  }
}

objective_onuseupdate(team, progress, _id_301D62DA1A0738F1, _id_4B22E50E504339FE) {}

objective_onpinnedstate(player) {
  updatefobspawnselection();
  _id_6663215F917210AE::dompoint_onpinnedstate(player);
}

objective_onunpinnedstate(player) {
  updatefobspawnselection();
  _id_6663215F917210AE::dompoint_onunpinnedstate(player);
}

dommainloop() {}

runobjflag(objective, _id_35B9448411944BDC) {
  level endon("game_ended");
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

nuke_mercyending_init() {
  scripts\mp\flags::gameflagwait("prematch_done");

  if(istrue(level.useobjectives))
    level thread nuke_mercyending_think();
}

nuke_mercyending_think() {
  level endon("game_ended");
  level endon("mercy_ending_timer_started");
  level._id_035022A7857106C0 = getdvarint("dvar_D885D71C2A455EB5", 5);

  for(;;) {
    foreach(team in level.teamnamelist) {
      _id_E1FC3ECB1D9E8392 = calculateobjectivesheld(team);

      if(_id_E1FC3ECB1D9E8392 >= level._id_035022A7857106C0)
        level thread nuke_startmercycountdown(team);
    }

    waitframe();
  }
}

nuke_startmercycountdown(team) {
  level notify("mercy_ending_timer_started");
  level endon("mercy_ending_triggered");
  setomnvar("ui_nuke_timer_type", 1);
  setomnvar("ui_nuke_timer_time", level.mercymatchending_time);
  setomnvar("ui_nuke_countdown_active", 1);
  setomnvar("ui_arm_dominatingTeam", scripts\engine\utility::array_find(level.allteamnamelist, team));
  _id_D984AAAFBB3F49E0 = 0;
  starttime = gettime();
  endtime = level.mercymatchending_time * 1000 + starttime;
  setomnvar("ui_nuke_end_milliseconds", level.mercymatchending_time * 1000 + starttime);

  if(getdvarint("dvar_37F19F5A0CFA7CC3", 1) == 1)
    level thread _id_3667B4285D355DD9(team);

  level._id_F9747E9B80B3C33A = 1;
  level._id_5932BBEF2FA89F92 = team;

  while(calculateobjectivesheld(team) >= level._id_035022A7857106C0) {
    waitframe();

    if(istrue(level._id_AE48BC1A4B9CAA1C) && level._id_213E22EC0A4C13BA.size > 1) {
      break;
    }

    if(gettime() > endtime) {
      if(getdvarint("dvar_716A70AD116D6C62", 0) == 1) {
        level._id_D37D95AC1717903C = ::_id_D37D95AC1717903C;
        _id_E6A7BB0501F0EBD4 = level thread _id_1347E3AB3C68B20E(team);
        level._id_9584DCC5D16D3469 = team;
        level._id_9584CEC5D16D159F = _id_E6A7BB0501F0EBD4;
        setnojipscore(1, 1);
        setnojiptime(1, 1);
        level.nojip = 1;

        if(getDvar("dvar_37F18CB13C592B0C", "neutral") == "combine")
          _id_F525754162A91372(team, _id_E6A7BB0501F0EBD4);
        else if(getDvar("dvar_37F18CB13C592B0C", "neutral") == "neutral")
          _id_F525754162A91372("neutral", _id_E6A7BB0501F0EBD4);

        _id_F6857CA2E18431E9(team, _id_E6A7BB0501F0EBD4);
        break;
      } else {
        nuke_triggermercywin(team);
        level notify("mercy_ending_triggered");
      }
    }
  }

  if(istrue(level._id_AE48BC1A4B9CAA1C)) {
    if(level._id_213E22EC0A4C13BA.size > 1) {
      foreach(_id_F90358454413407F in level._id_213E22EC0A4C13BA)
      level thread _id_3667B4285D355DD9(_id_F90358454413407F);

      setomnvar("ui_nuke_countdown_active", 0);
      setomnvar("ui_arm_dominatingTeam", -1);
      wait 1;
      setomnvar("ui_nuke_countdown_active", 1);
      setomnvar("ui_arm_dominatingTeam", -2);

      while(level._id_213E22EC0A4C13BA.size > 1)
        waitframe();
    } else
      setomnvar("ui_arm_dominatingTeam", scripts\engine\utility::array_find(level.allteamnamelist, team));
  }

  if(getdvarint("dvar_37F19F5A0CFA7CC3", 1) == 1)
    level thread _id_E23F5E44B6C9E25C(team);

  level._id_F9747E9B80B3C33A = 0;
  level._id_5932BBEF2FA89F92 = undefined;
  setomnvar("ui_nuke_countdown_active", 0);
  setomnvar("ui_arm_dominatingTeam", -1);
  wait 1;

  if(istrue(level._id_AE48BC1A4B9CAA1C) && !isDefined(level._id_9584CEC5D16D159F))
    level thread nuke_mercyending_think();
  else if(getdvarint("dvar_716A70AD116D6C62", 0) == 1) {
    if(getdvarint("dvar_48C89C3E6B934D79", 1))
      level thread _id_2A8ADCC9B74F4838();
  } else
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
    _id_39E8F33513C716CD scripts\cp_mp\killstreaks\nuke::tryusenuke();
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
    _id_48501209A3E177A7 = "mp_risk_spawn";
    _id_AE7D0107AD485428 = "mp_risk_spawn";
    _id_E77FE17F16335F61 = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_allies_start_mod");

    if(_id_E77FE17F16335F61.size > 0)
      _id_48501209A3E177A7 = "mp_gw_spawn_allies_start_mod";

    _id_202C2C36D99ADA78 = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_axis_start_mod");

    if(_id_202C2C36D99ADA78.size > 0)
      _id_AE7D0107AD485428 = "mp_gw_spawn_axis_start_mod";
  } else {
    _id_48501209A3E177A7 = "mp_risk_spawn";
    _id_AE7D0107AD485428 = "mp_risk_spawn";
  }

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(_id_F90358454413407F == "axis") {
      level.gamemodestartspawnpointnames[_id_F90358454413407F] = _id_AE7D0107AD485428;
      continue;
    }

    if(_id_F90358454413407F == "allies") {
      level.gamemodestartspawnpointnames[_id_F90358454413407F] = _id_48501209A3E177A7;
      continue;
    }

    level.gamemodestartspawnpointnames[_id_F90358454413407F] = _id_AE7D0107AD485428;
  }

  level.gamemodespawnpointnames = [];

  foreach(_id_F90358454413407F in level.teamnamelist)
  level.gamemodespawnpointnames[_id_F90358454413407F] = "mp_risk_spawn";

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

  foreach(_id_F90358454413407F in level.teamnamelist) {
    scripts\mp\spawnlogic::addspawnpoints(_id_F90358454413407F, level.gamemodestartspawnpointnames[_id_F90358454413407F]);
    _id_29D9D2428185616D = scripts\mp\spawnlogic::getspawnpointarray(level.gamemodestartspawnpointnames[_id_F90358454413407F]);
    scripts\mp\spawnlogic::registerspawnset("start_" + _id_F90358454413407F, _id_29D9D2428185616D);
    scripts\mp\spawnlogic::addspawnpoints(_id_F90358454413407F, "mp_risk_spawn");
  }

  _id_29D9D2428185616D = scripts\mp\spawnlogic::getspawnpointarray("mp_risk_spawn");
  scripts\mp\spawnlogic::registerspawnset("normal", _id_29D9D2428185616D);
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
  spawnpoint = undefined;

  if(istrue(level.usesquadspawn) && istrue(self.squadspawnconfirmed)) {
    _id_279BB6642EC5E695 = self getspectatingplayer();

    if(isDefined(_id_279BB6642EC5E695) && isDefined(self._id_0FF97225579DE16A) && self.team == _id_279BB6642EC5E695.team && self._id_0FF97225579DE16A == _id_279BB6642EC5E695._id_0FF97225579DE16A)
      spawnpoint = scripts\mp\spawnscoring::findteammatebuddyspawn(_id_279BB6642EC5E695);
  } else {
    scripts\mp\spawnlogic::activatespawnset("normal", 1);
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined);
  }

  return spawnpoint;
}

onspawnplayer(_id_9156B53BCF7CE573) {
  self setclientomnvar("ui_risk_obj_client_team", scripts\engine\utility::array_find(level.allteamnamelist, self.team));
  thread updatematchstatushintonspawn();
  _id_76CC264B397DB9CB::updatesquadomnvars(self.team, self._id_0FF97225579DE16A);

  if(!isDefined(self.plundercount))
    self.plundercount = 0;

  if(!scripts\mp\flags::gameflag("prematch_done") || !_id_DC3A172BF923D9B3())
    thread _id_B88EC41808EE3630();

  self._id_5354295B99468CEF = undefined;
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
    _id_6AFF3948CF4CCA03::playerdropplunderondeath(dropstruct, attacker);
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

onplayerconnect(player) {
  if(isDefined(level.rallypointvehicles))
    thread scripts\mp\rally_point::rallypoint_showtoplayer(player);

  if(isDefined(player) && istrue(level._id_289DF80E1DED586F)) {
    player.gameskill = _id_53DA3333B83B3527::get_gameskill();
    player _id_53DA3333B83B3527::set_difficulty_from_locked_settings();
    player.owner = undefined;
    scripts\engine\utility::flag_wait("level_stealth_initialized");

    while(!isDefined(player.team))
      waitframe();

    player scripts\stealth\player::main();
  }

  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);
}

onjoinedteam(player) {
  player _id_6ED651811C936A22();
}

onplayerdisconnect(player) {}

updategamemodespawncamera() {
  _id_1FD5D62338AB6DE2 = "lane02_4";

  if(isDefined(level.activezone))
    _id_1FD5D62338AB6DE2 = level.activezone.zonetrigger.script_label;

  foreach(_id_F90358454413407F in level.teamnamelist)
  scripts\mp\spawncamera::setgamemodecamera(_id_F90358454413407F, level.spawncameras[_id_1FD5D62338AB6DE2][_id_F90358454413407F]);
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

  if(getdvarint("dvar_DDD6A50EFCA1E2C2", 0) == 1) {
    if(!isDefined(level._id_D37D95AC1717903C))
      level._id_D37D95AC1717903C = ::_id_D37D95AC1717903C;

    victim thread _id_190616CDBC044966(attacker, attacker.team);
  }
}

_id_190616CDBC044966(attacker, _id_917D7051FE3EFEC8, _id_84C6550575008AAA) {
  if(istrue(_id_84C6550575008AAA))
    scripts\mp\utility\damage::_suicide();

  if(!isDefined(attacker)) {
    return;
  }
  if(isagent(attacker)) {
    return;
  }
  if(isDefined(attacker.owner))
    attacker = attacker.owner;

  if(attacker == self && !istrue(_id_84C6550575008AAA)) {
    return;
  }
  self._id_5354295B99468CEF = 1;
  wait 0.15;

  if(!isDefined(self)) {
    return;
  }
  self.teamchangedthisframe = 1;
  scripts\mp\menus::setteam(_id_917D7051FE3EFEC8);
}

ontimelimit() {
  _id_8B45A7F4F7EFD75A = "tie";
  _id_0405D9C96AABD571 = 0;
  domflags = getowneddomflags();

  if(domflags.size) {
    foreach(team in level.teamnamelist) {
      _id_FEE716687DD29378 = _id_6663215F917210AE::getteamflagcount(team);

      if(_id_FEE716687DD29378 > 0) {
        if(_id_0405D9C96AABD571 < _id_FEE716687DD29378) {
          _id_8B45A7F4F7EFD75A = team;
          _id_0405D9C96AABD571 = _id_FEE716687DD29378;
          continue;
        }

        if(_id_0405D9C96AABD571 == _id_FEE716687DD29378)
          _id_8B45A7F4F7EFD75A = "tie";
      }
    }

    if(_id_8B45A7F4F7EFD75A == "tie") {
      foreach(team in level.teamnamelist)
      scripts\mp\gamescore::giveteamscoreforobjective(team, 1);
    } else
      scripts\mp\gamescore::giveteamscoreforobjective(_id_8B45A7F4F7EFD75A, _id_0405D9C96AABD571);

    thread scripts\mp\gamelogic::endgame(_id_8B45A7F4F7EFD75A, game["end_reason"]["time_limit_reached"]);
  } else
    thread scripts\mp\gamelogic::endgame("tie", game["end_reason"]["time_limit_reached"]);
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

managec130spawns() {
  level endon("game_ended");
  _id_033BBC02ACA0008B = 6000;
  _id_FDFE2D4AAF8EC33D = 12000;
  _id_F382830CB3A96BF9 = 20000;
  _id_B34D9378696E10BB = 1;
  _id_2B4EE773F94CEDCF = (0, 0, 6000);
  level.timebetweenc130passes = 0;
  level.flighttime = 20;
  level.spawnc130 = [];

  foreach(_id_F90358454413407F in level.teamnamelist)
  level.spawnc130[_id_F90358454413407F] = undefined;

  c130_pickrandomflightpath();
  level.spawnc130["axis"] = createc130("axis", level.c130pathstruct_a.startpt + _id_2B4EE773F94CEDCF);
  level.spawnc130["allies"] = createc130("allies", level.c130pathstruct_b.startpt + _id_2B4EE773F94CEDCF);

  while(!isDefined(level.spawnselectionlocations))
    waitframe();

  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    if(!isDefined(level.timeuntilnextc130))
      level.timeuntilnextc130 = [];

    if(!isDefined(level.timeuntilnextc130["axis"]))
      level.timeuntilnextc130["axis"] = 0;

    if(!isDefined(level.timeuntilnextc130["allies"]))
      level.timeuntilnextc130["allies"] = 0;

    timeuntilnextc130 = gettime() + (level.flighttime + level.timebetweenc130passes) * 1000;
    level.timeuntilnextc130["axis"] = timeuntilnextc130;
    level.timeuntilnextc130["allies"] = timeuntilnextc130;

    if(0) {
      thread scripts\mp\utility\debug::drawline(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 1000, (1, 0, 0));
      thread scripts\mp\utility\debug::drawline(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 1000, (0, 0, 1));
    }

    if(_id_B34D9378696E10BB) {
      level.spawnc130["axis"] thread handlec130motion(level.c130pathstruct_a.startpt + _id_2B4EE773F94CEDCF, level.c130pathstruct_a.endpt + _id_2B4EE773F94CEDCF, level.flighttime, "axis");
      level.spawnc130["allies"] thread handlec130motion(level.c130pathstruct_b.startpt + _id_2B4EE773F94CEDCF, level.c130pathstruct_b.endpt + _id_2B4EE773F94CEDCF, level.flighttime, "allies");
    } else {
      level.spawnc130["axis"] thread handlec130motion(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, level.flighttime, "axis");
      level.spawnc130["allies"] thread handlec130motion(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, level.flighttime, "allies");
    }

    level.c130firstpassstarted = 1;
    level scripts\engine\utility::waittill_all_in_array(["C130_path_complete_axis", "C130_path_complete_allies"]);
    c130_fightpathmove();
    _id_AD5699EFE91E15CF = level.c130pathstruct_a.startpt;
    level.c130pathstruct_a.startpt = level.c130pathstruct_a.endpt;
    level.c130pathstruct_a.endpt = _id_AD5699EFE91E15CF;
    _id_AD5699EFE91E15CF = level.c130pathstruct_b.startpt;
    level.c130pathstruct_b.startpt = level.c130pathstruct_b.endpt;
    level.c130pathstruct_b.endpt = _id_AD5699EFE91E15CF;
    _id_B34D9378696E10BB = 0;

    if(istrue(level.usec130spawnfirstonly)) {
      level.usec130spawn = 0;
      break;
    }
  }

  scripts\mp\spawnselection::removedynamicspawnarea("axis", "dynamic_c130");
  scripts\mp\spawnselection::removedynamicspawnarea("allies", "dynamic_c130");
  scripts\mp\spawnselection::removespawnlocation("dynamic_c130", "axis");
  scripts\mp\spawnselection::removespawnlocation("dynamic_c130", "allies");
  level.spawnc130["axis"] delete();
  level.spawnc130["allies"] delete();
}

createc130(team, startpt) {
  gunship = spawn("script_model", startpt);
  gunship setModel("veh8_mil_air_acharlie130");
  gunship setCanDamage(0);
  gunship.maxhealth = 100000;
  gunship.health = gunship.maxhealth;
  gunship.playeroffsets = [(32, 30, 0), (-32, 30, 0), (0, 30, 0), (16, 30, 0), (-16, 30, 0)];
  gunship.currentplayeroffset = 0;
  gunship.respawnqueue = [];
  gunship.players = [];
  gunship.team = team;
  gunship playLoopSound("iw8_ks_ac130_lp");
  gunship thread _id_45B2B4A889E633FA::gunship_spawnvfx();
  return gunship;
}

handlec130motion(startpt, endpt, time, team) {
  _id_8F95F32CFD252A35 = vectorNormalize(endpt - startpt);
  dist = distance(endpt, startpt);
  _id_92A519173221837E = startpt + _id_8F95F32CFD252A35 * dist * 0.425;
  _id_E7C3539B6FC3114F = startpt + _id_8F95F32CFD252A35 * dist * 0.55;
  _id_3CF9C28B9CFCBDFC = time * 0.3;
  _id_C27959A7028DB85C = time * 0.6;
  _id_678AE55DDF94D0BD = time * 0.1;
  self.canjoin = 1;
  self.canparachute = 0;
  dir = vectorNormalize(endpt - startpt);
  self.angles = vectortoangles(dir);
  self.origin = startpt;
  gatherc130playerstospawn();
  self moveTo(endpt, _id_3CF9C28B9CFCBDFC + _id_C27959A7028DB85C + _id_678AE55DDF94D0BD, _id_3CF9C28B9CFCBDFC * 0.25);
  wait(_id_3CF9C28B9CFCBDFC);
  self.canparachute = 1;

  foreach(_id_AC0E424AC96A7113 in self.players)
  _id_AC0E424AC96A7113 notify("canParachute");

  wait(_id_C27959A7028DB85C);
  self.canjoin = 0;
  self.canparachute = 0;

  foreach(_id_AC0E424AC96A7113 in self.players)
  _id_AC0E424AC96A7113 notify("halo_kick_c130");

  wait(_id_678AE55DDF94D0BD);
  level notify("C130_path_complete_" + team);
}

gatherc130playerstospawn() {
  self.players = scripts\engine\utility::array_combine(self.players, self.respawnqueue);
  self.respawnqueue = [];
  radius = 1400;
  _id_AD3758FD3576AE97 = (30, 0, 0);
  _id_7599C0B16DDED944 = anglesToForward(_id_AD3758FD3576AE97) * radius * -1;
  spawnpos = self gettagorigin("tag_origin") + _id_7599C0B16DDED944;
  _id_B7850001037AA074 = self.angles;

  foreach(_id_AC0E424AC96A7113 in self.players) {
    if(!isDefined(_id_AC0E424AC96A7113)) {
      continue;
    }
    _id_AC0E424AC96A7113.forcespawncameraorg = spawnpos;
    _id_AC0E424AC96A7113.forcespawncameraang = _id_B7850001037AA074;
    _id_AC0E424AC96A7113 notify("c130_ready");
  }
}

removefromspawnselectionaftertime(time) {
  wait(time);
  removefromspawnselection();
}

removefromspawnselection() {
  scripts\mp\spawnselection::removedynamicspawnarea(self.team, "dynamic_c130");
  scripts\mp\spawnselection::removespawnlocation("dynamic_c130", self.team);
}

spawnplayertoc130() {
  self endon("disconnect");

  if(!isDefined(level.spawnc130[self.team])) {
    return;
  }
  self waittill("spawn_camera_idle");
  c130 = level.spawnc130[self.team];
  c130.respawnqueue[c130.respawnqueue.size] = self;

  if(istrue(c130.canjoin))
    c130 gatherc130playerstospawn();

  if(istrue(self.inspawncamera))
    self waittill("spawn_camera_complete");
  else
    self waittill("spawned_player");

  _id_3B64EB40368C1450::set("spawnPlayerToC130", "killstreaks", 0);
  self disableusability();
  self disableoffhandweapons();
  self allowmelee(0);
  self allowads(0);
  self allowfire(0);
  self setCanDamage(0);
  thread jumplistener(c130, 0);
  self.br_infil_type = "c130";

  if(!isbot(self))
    thread _id_45B2B4A889E633FA::orbitcam(c130);
}

jumplistener(c130, _id_1B89121EF11344D5) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("jumpListener()");
  self endon("jumpListener()");

  if(isDefined(self.parachute))
    self.parachute delete();

  self.c130 = c130;
  thread listenjump(c130, _id_1B89121EF11344D5);
  thread listenkick(c130, _id_1B89121EF11344D5);
}

listenkick(c130, _id_0A3F91A4A7069575) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("br_jump");
  self notify("listenKick()");
  self endon("listenKick()");
  self waittill("halo_kick_c130");
  self cameradefault();
  self unlink();
  wait 0.1;

  if(self.sessionstate == "spectator") {
    return;
  }
  _id_F9805AAD354A150E = c130 _id_60D787A38293225F::calctrailpoint();
  thread parachute(c130, _id_0A3F91A4A7069575);
  self notify("br_jump");
  self notify("stop_cam_shake");
}

listenjump(c130, _id_1B89121EF11344D5) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("br_jump");
  self notify("listenJump()");
  self endon("listenJump()");
  self notifyonplayercommand("halo_jump_c130", "+gostand");

  for(;;) {
    result = scripts\engine\utility::waittill_either("halo_jump_c130", "canParachute");

    if(isDefined(result) && result == "canParachute")
      self iprintlnbold("Press Jump to Parachute!");
    else if(!istrue(c130.canparachute))
      self iprintlnbold("Not over the AO");
    else
      break;

    if(self.sessionstate == "spectator")
      return;
  }

  self cameradefault();
  self unlink();
  wait 0.1;
  thread parachute(c130, _id_1B89121EF11344D5);
  self notify("br_jump");
  self notify("stop_cam_shake");
}

parachute(c130, _id_1B89121EF11344D5) {
  self endon("jumpListener()");
  self notify("parachute()");
  self endon("parachute()");

  if(self.team == "axis")
    _id_69DBCC65237EC970 = level.c130pathstruct_b.midpt;
  else
    _id_69DBCC65237EC970 = level.c130pathstruct_a.midpt;

  _id_C4E660D969DCEEE5 = vectorNormalize(_id_69DBCC65237EC970 - c130.origin);
  c130.players = scripts\engine\utility::array_remove(c130.players, self);

  if(isDefined(c130.playeroffsets) && isDefined(c130.currentplayeroffset)) {
    offset = c130.playeroffsets[c130.currentplayeroffset];
    self setOrigin(c130.origin + offset, 1, 1);
    c130.currentplayeroffset++;

    if(c130.currentplayeroffset == c130.playeroffsets.size)
      c130.currentplayeroffset = 0;
  } else {
    _id_E03CC98B6B9A9F1C = anglesToForward(c130.angles) * c130.br_vieworigin;
    self setOrigin(c130.origin + _id_E03CC98B6B9A9F1C, 1, 1);
  }

  waitframe();
  scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();
  scripts\cp_mp\utility\player_utility::_id_985B0973F29DA4F8("risk::parachute()");
  self.plotarmor = 0;
  self.c130 = undefined;
  self setplayerangles(vectortoangles(_id_C4E660D969DCEEE5));
  thread scripts\cp_mp\parachute::startfreefall(5.0, 0);
}

debug_randomflightpathstest() {
  wait 10;

  for(;;) {
    c130_pickrandomflightpath();
    level.c130pathstruct_a.startpt = level.c130pathstruct_a.startpt - (0, 0, 10000);
    level.c130pathstruct_a.endpt = level.c130pathstruct_a.endpt - (0, 0, 10000);
    level.c130pathstruct_b.startpt = level.c130pathstruct_b.startpt - (0, 0, 10000);
    level.c130pathstruct_b.endpt = level.c130pathstruct_b.endpt - (0, 0, 10000);
    thread scripts\mp\utility\debug::drawline(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 1, (1, 0, 1));
    thread scripts\mp\utility\debug::drawline(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 1, (1, 0, 1));
    wait 1;
  }
}

c130_pickrandomflightpath() {
  if(istrue(level.c130alignedtolocale) && istrue(level.useobjectives)) {
    mapcenter = level.mapcenter;
    _id_F3C9E115B49A626A = vectortoangles(mapcenter - level.gw_objstruct._id_384217DDF47CCB48[0].trigger.origin);
    angle = _id_F3C9E115B49A626A[1];

    if(0)
      thread scripts\mp\utility\debug::drawsphere(mapcenter, 1000, 100000, (0, 1, 0));
  } else {
    mapcenter = (level.mapsafecorners[0] + level.mapsafecorners[1]) * 0.5;
    angle = randomfloatrange(0, 359);
  }

  _id_15C3CD2DAB9EA60C = makec130pathparamsstruct(mapcenter, angle - 90);
  level.c130pathstruct_a = _id_45B2B4A889E633FA::makepathstruct(_id_15C3CD2DAB9EA60C);
  _id_15C3CD2DAB9EA60C.randomangle = _id_15C3CD2DAB9EA60C.randomangle + 180;
  level.c130pathstruct_b = _id_45B2B4A889E633FA::makepathstruct(_id_15C3CD2DAB9EA60C);
  _id_3ABADAB203328AD1 = 0.2;
  _id_B4885B21FE401AC5 = 0;
  _id_A433228CDFB64C3A = 0;

  if(istrue(level.c130spacing_usebigmapsettings)) {
    _id_3ABADAB203328AD1 = 0.1;
    _id_B4885B21FE401AC5 = randomfloatrange(-5000.0, 5000);
    _id_A433228CDFB64C3A = randomfloatrange(-5000.0, 5000);
  }

  right = anglestoright(level.c130pathstruct_a.angle);
  level.c130pathstruct_a.startpt = right * level.c130distapart + level.c130pathstruct_a.startpt;
  level.c130pathstruct_a.endpt = right * level.c130distapart + level.c130pathstruct_a.endpt;
  right = anglestoright(level.c130pathstruct_b.angle);
  level.c130pathstruct_b.startpt = right * level.c130distapart + level.c130pathstruct_b.startpt;
  level.c130pathstruct_b.endpt = right * level.c130distapart + level.c130pathstruct_b.endpt;
  offset = (_id_B4885B21FE401AC5, _id_A433228CDFB64C3A, 0);
  level.c130pathstruct_a.startpt = level.c130pathstruct_a.startpt + offset;
  level.c130pathstruct_a.endpt = level.c130pathstruct_a.endpt + offset;
  level.c130pathstruct_a.midpt = vectorlerp(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 0.5);
  level.c130pathstruct_b.startpt = level.c130pathstruct_b.startpt + offset;
  level.c130pathstruct_b.endpt = level.c130pathstruct_b.endpt + offset;
  level.c130pathstruct_b.midpt = vectorlerp(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 0.5);
  level.battlecenter = vectorlerp(level.c130pathstruct_a.midpt, level.c130pathstruct_b.midpt, 0.5);
  level.c130minpathmovementinterval = vectorlerp(level.c130pathstruct_a.startpt, level.c130pathstruct_b.endpt, _id_3ABADAB203328AD1);
  level.c130minpathmovementinterval = level.c130minpathmovementinterval - level.c130pathstruct_a.startpt;
  level.c130minpathmovementinterval = vectorNormalize(level.c130minpathmovementinterval) * level.c130distapart / 10;
  level.c130minpathmovementinterval = (level.c130minpathmovementinterval[0], level.c130minpathmovementinterval[1], 0);
}

makec130pathparamsstruct(centerpt, angle) {
  _id_F94F9769A1F2D802 = 6.28318;
  randomangle = angle;
  endangleoffset = 180;
  r = level.c130flightdist;
  _id_CD37CE775909957B = spawnStruct();
  _id_CD37CE775909957B.r = r;
  _id_CD37CE775909957B.randomangle = randomangle;
  _id_CD37CE775909957B.endangleoffset = endangleoffset;
  _id_CD37CE775909957B.centerpt = centerpt;
  return _id_CD37CE775909957B;
}

c130_fightpathmove() {
  if(0)
    level.c130movementmethod = 2;

  if(level.c130movementmethod == 0)
    return;
  else if(level.c130movementmethod == 1) {
    if(0) {
      level.c130pathkilltracker["axis"] = 1;
      level.c130pathkilltracker["allies"] = 0;
    }

    if(level.c130pathkilltracker["axis"] > level.c130pathkilltracker["allies"]) {
      if(arenextpathsinsafebounds(level.c130minpathmovementinterval)) {
        level.c130pathstruct_a.startpt = level.c130pathstruct_a.startpt + level.c130minpathmovementinterval;
        level.c130pathstruct_a.endpt = level.c130pathstruct_a.endpt + level.c130minpathmovementinterval;
        level.c130pathstruct_b.startpt = level.c130pathstruct_b.startpt + level.c130minpathmovementinterval;
        level.c130pathstruct_b.endpt = level.c130pathstruct_b.endpt + level.c130minpathmovementinterval;
      }
    } else if(arenextpathsinsafebounds(level.c130minpathmovementinterval * -1.0)) {
      level.c130pathstruct_a.startpt = level.c130pathstruct_a.startpt - level.c130minpathmovementinterval;
      level.c130pathstruct_a.endpt = level.c130pathstruct_a.endpt - level.c130minpathmovementinterval;
      level.c130pathstruct_b.startpt = level.c130pathstruct_b.startpt - level.c130minpathmovementinterval;
      level.c130pathstruct_b.endpt = level.c130pathstruct_b.endpt - level.c130minpathmovementinterval;
    }

    level.c130pathstruct_a.midpt = vectorlerp(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 0.5);
    level.c130pathstruct_b.midpt = vectorlerp(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 0.5);
    level.c130pathkilltracker["axis"] = 0;
    level.c130pathkilltracker["allies"] = 0;
  } else if(level.c130movementmethod == 2) {
    _id_D320310339164AAC = (0, 0, 0);
    _id_EE6D8B534C2DDD2D = (0, 0, 0);
    _id_6D48EB54C3A800FC = 0;
    _id_9297D08353BAF063 = 0;

    foreach(player in level.players) {
      if(isalive(player)) {
        if(player.team == "axis") {
          _id_D320310339164AAC = _id_D320310339164AAC + player.origin;
          _id_6D48EB54C3A800FC++;
          continue;
        }

        if(player.team == "allies") {
          _id_EE6D8B534C2DDD2D = _id_EE6D8B534C2DDD2D + player.origin;
          _id_9297D08353BAF063++;
        }
      }
    }

    if(_id_6D48EB54C3A800FC == 0 || _id_9297D08353BAF063 == 0) {
      return;
    }
    _id_FABE25D5659F05A9 = _id_D320310339164AAC / _id_6D48EB54C3A800FC;
    _id_C43D9EC2E9A839C6 = _id_EE6D8B534C2DDD2D / _id_9297D08353BAF063;
    _id_0BE2C550023FB372 = vectorlerp(_id_FABE25D5659F05A9, _id_C43D9EC2E9A839C6, 0.5);
    level.c130minpathmovementinterval = vectorlerp(level.battlecenter, _id_0BE2C550023FB372, 0.5);
    level.c130minpathmovementinterval = level.c130minpathmovementinterval - level.battlecenter;
    _id_37DFB4F272C7016D = distance2d(level.battlecenter, _id_0BE2C550023FB372);
    level.c130minpathmovementinterval = vectorNormalize(level.c130minpathmovementinterval) * _id_37DFB4F272C7016D / 4;
    level.c130minpathmovementinterval = (level.c130minpathmovementinterval[0], level.c130minpathmovementinterval[1], 0);

    if(arenextpathsinsafebounds(level.c130minpathmovementinterval)) {
      level.c130pathstruct_a.startpt = level.c130pathstruct_a.startpt + level.c130minpathmovementinterval;
      level.c130pathstruct_a.endpt = level.c130pathstruct_a.endpt + level.c130minpathmovementinterval;
      level.c130pathstruct_a.midpt = vectorlerp(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 0.5);
      level.c130pathstruct_b.startpt = level.c130pathstruct_b.startpt + level.c130minpathmovementinterval;
      level.c130pathstruct_b.endpt = level.c130pathstruct_b.endpt + level.c130minpathmovementinterval;
      level.c130pathstruct_b.midpt = vectorlerp(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 0.5);

      if(0) {
        thread scripts\mp\utility\debug::drawsphere(level.battlecenter, 1000, 700, (1, 0, 0));
        thread scripts\mp\utility\debug::drawsphere(_id_0BE2C550023FB372, 1000, 700, (0, 1, 0));
      }

      level.battlecenter = level.battlecenter + level.c130minpathmovementinterval;
    }
  }
}

arenextpathsinsafebounds(offset) {
  return ispointinsafebounds(level.c130pathstruct_a.startpt + offset) && ispointinsafebounds(level.c130pathstruct_a.endpt + offset) && ispointinsafebounds(level.c130pathstruct_b.startpt + offset) && ispointinsafebounds(level.c130pathstruct_b.endpt + offset);
}

ispointinsafebounds(_id_CDCD3178F5176585) {
  return _id_CDCD3178F5176585[0] < level.mapsafecorners[0][0] && _id_CDCD3178F5176585[0] > level.mapsafecorners[1][0] && _id_CDCD3178F5176585[1] < level.mapsafecorners[0][1] && _id_CDCD3178F5176585[1] > level.mapsafecorners[1][1];
}

_id_F69E35A602975879(vehicle, player) {
  return 1;
}

registervehicletype(refname, _id_E4015CFE956F4F3F) {
  vehicleinfo = spawnStruct();
  vehicleinfo.refname = refname;
  vehicleinfo.spawncallback = _id_E4015CFE956F4F3F;
  vehicleinfo.vehiclespawns = scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F(refname);

  if(!isDefined(level.vehicleinfo))
    level.vehicleinfo = [];

  level.vehicleinfo[refname] = vehicleinfo;
}

init_groundwarvehicles() {
  registervehicletype("little_bird", ::vehiclespawn_littlebird);
  registervehicletype("atv", ::vehiclespawn_atv);
  registervehicletype("tac_rover", ::vehiclespawn_tacrover);
  registervehicletype("light_tank", ::vehiclespawn_tank);
  registervehicletype("veh9_rhib", ::_id_91397B675B427DA6);
  registervehicletype("veh9_jltv", ::_id_52E04331732241D7);
  level.vehiclespawnlocs = [];
  level.tankspawnlocs_axis = [];
  level.tankspawnlocs_allies = [];

  foreach(vehicleinfo in level.vehicleinfo) {
    foreach(spawnpoint in vehicleinfo.vehiclespawns) {
      index = level.vehiclespawnlocs.size;
      level.vehiclespawnlocs[index] = spawnpoint;
      level.vehiclespawnlocs[index].refname = vehicleinfo.refname;
    }
  }

  if(0) {
    foreach(loc in level.vehiclespawnlocs)
    thread scripts\mp\utility\debug::drawline(loc.origin, loc.origin + (0, 0, 1500), 1000, (1, 0, 0));
  }

  level.vehiclespawnlocs = scripts\engine\utility::array_randomize(level.vehiclespawnlocs);
  _id_FC617751F654A141 = level.numnonrallyvehicles;

  if(!isDefined(level.numnonrallyvehicles))
    _id_FC617751F654A141 = 25;

  if(0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FC617751F654A141; _id_AC0E594AC96AA3A8++) {
      loc = level.vehiclespawnlocs[_id_AC0E594AC96AA3A8];
      thread scripts\mp\utility\debug::drawline(loc.origin + (0, 0, 1500), loc.origin + (0, 0, 2500), 1000, (0, 1, 0));
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FC617751F654A141; _id_AC0E594AC96AA3A8++) {
    loc = level.vehiclespawnlocs[_id_AC0E594AC96AA3A8];

    if(isDefined(loc)) {
      vehicleinfo = level.vehicleinfo[loc.refname];
      [[vehicleinfo.spawncallback]](loc);
    }
  }

  scripts\mp\flags::gameflagwait("prematch_countdown");
  level.numhqtanks_axis = 0;
  level.numhqtanks_allies = 0;
  thread vehiclespawn_hqtanks(level.tankspawnlocs_axis);
  thread vehiclespawn_hqtanks(level.tankspawnlocs_allies);
}

vehiclespawn_hqtanks(_id_9D4B9FCD75D1A736) {
  foreach(loc in _id_9D4B9FCD75D1A736) {
    vehicleinfo = level.vehicleinfo[loc.refname];
    [[vehicleinfo.spawncallback]](loc);
    wait(randomfloatrange(2.0, 3.0));
  }
}

vehiclespawn_littlebird(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("little_bird", spawndata, _id_EE8DA5624236DC89);
}

vehiclespawn_atv(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("atv", spawndata, _id_EE8DA5624236DC89);
}

vehiclespawn_tacrover(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("tac_rover", spawndata, _id_EE8DA5624236DC89);
}

vehiclespawn_tank(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  spawndata.spawnmethod = "airdrop_at_position_unsafe";

  if(isDefined(loc.script_team) && loc.script_team == "axis") {
    if(level.numhqtanks_axis >= level.maxhqtanks) {
      return;
    }
    spawndata.usealtmodel = 1;
    spawndata.team = "axis";
    level.numhqtanks_axis++;
  } else {
    if(level.numhqtanks_allies >= level.maxhqtanks) {
      return;
    }
    spawndata.team = "allies";
    level.numhqtanks_allies++;
  }

  _id_FE827F03F6233BE7 = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("light_tank", spawndata, _id_EE8DA5624236DC89);

  if(istrue(level.showteamtanks))
    vehicle_createspawnselectiontankmarker(_id_FE827F03F6233BE7, _id_FE827F03F6233BE7.team);

  return _id_FE827F03F6233BE7;
}

_id_91397B675B427DA6(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_rhib", spawndata, _id_EE8DA5624236DC89);
}

_id_52E04331732241D7(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_jltv", spawndata, _id_EE8DA5624236DC89);
}

vehicle_createspawnselectiontankmarker(vehicle, team) {
  wait 1;
  marker = scripts\mp\gameobjects::createobjidobject(vehicle.origin, team, (0, 0, 0), undefined, 0, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(marker.objidnum, team);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(marker.objidnum);
  scripts\mp\objidpoolmanager::objective_set_play_intro(marker.objidnum, 0);
  marker.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(marker.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(marker.objidnum, "hud_icon_minimap_vehicle_tank_coscar");
  scripts\mp\objidpoolmanager::update_objective_setbackground(marker.objidnum, 1);
  scripts\mp\objidpoolmanager::update_objective_onentity(marker.objidnum, vehicle);
  marker.lockupdatingicons = 1;

  foreach(player in level.players) {
    if(isDefined(player) && isDefined(player.team) && player.team == team && istrue(player.inspawnselection))
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(marker.objidnum, player);
  }

  vehicle.spawnselectionmarker = marker;
  thread vehicle_watchmarkedtankdeath(vehicle);
  level.trackedtanks[team][level.trackedtanks[team].size] = vehicle;
}

vehicle_watchmarkedtankdeath(vehicle) {
  objidnum = vehicle.spawnselectionmarker.objidnum;
  team = vehicle.team;
  vehicle waittill("death");
  scripts\mp\objidpoolmanager::returnobjectiveid(objidnum);
  level.trackedtanks[team] = scripts\engine\utility::array_remove(level.trackedtanks[team], vehicle);
}

vehicle_showteamtanks() {
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(tank in level.trackedtanks[self.team])
  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(tank.spawnselectionmarker.objidnum, self);

  while(self.inspawnselection)
    waitframe();

  foreach(tank in level.trackedtanks["axis"])
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(tank.spawnselectionmarker.objidnum, self);

  foreach(tank in level.trackedtanks["allies"])
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(tank.spawnselectionmarker.objidnum, self);
}

vehiclespawn_getspawndata(loc) {
  spawndata = spawnStruct();
  spawndata.origin = loc.origin;
  spawndata.angles = loc.angles;
  spawndata.spawntype = "GAME_MODE";
  spawndata.showheadicon = 1;
  return spawndata;
}

droptank_playincomingdialog(spawndata) {
  team = spawndata.team;
  streakname = "bradley";

  if(level.teambased) {
    if(isDefined(level.killstreakactivatedtime[streakname])) {
      if(isDefined(level.killstreakactivatedtime[streakname][team])) {
        if(gettime() < level.killstreakactivatedtime[streakname][team])
          return;
      }
    }

    level.killstreakactivatedtime[streakname][team] = gettime() + scripts\cp_mp\utility\killstreak_utility::getkillstreakdialogcooldown() * 1000;
  }

  scripts\mp\utility\dialog::leaderdialog(team + "_friendly_" + streakname + "_inbound", team, "killstreak_used");
}

init_rallyvehicles() {
  while(!isDefined(level.spawnselectionlocations))
    waitframe();

  waitframe();
  level.rallypointvehicles = [];
  _id_13B8ACCBD9C63733 = scripts\engine\utility::getStructArray("rallyPointAPC", "targetname");

  foreach(loc in _id_13B8ACCBD9C63733) {
    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(loc.script_noteworthy) && loc.script_noteworthy != level.localeid) {
      continue;
    }
    team = scripts\engine\utility::ter_op(loc.script_team == "axis", "axis", "allies");
    spawndata = getrallyvehiclespawndata(loc, team);

    if(team == "allies")
      spawndata.usealtmodel = 1;

    _id_EE8DA5624236DC89 = spawnStruct();
    vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("apc_russian", spawndata, _id_EE8DA5624236DC89);

    if(isDefined(vehicle)) {
      level.rallypointvehicles[level.rallypointvehicles.size] = vehicle;
      continue;
    }
  }

  foreach(_id_F90358454413407F in level.teamnamelist) {
    while(!isDefined(level.availablespawnlocations[_id_F90358454413407F][0]))
      waitframe();
  }

  _id_CA3C2FDF46BA3669 = 0;
  _id_31343980CBC746E5 = 0;
  _id_0245E307F2C92CA2 = 0;
  _id_660828356D2F44DA = 0;
  _id_FB299E7E5D830989 = 0;
  _id_29354B69BD8DEF17 = "gw_vehicle_technical_";
  _id_E6FE9018451C854C = "gw_vehicle_apc_";

  foreach(vehicle in level.rallypointvehicles) {
    spawndata = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(vehicle);

    if(!isDefined(spawndata.rallypointhealth))
      spawndata.rallypointhealth = vehicle.health;
    else
      vehicle.health = spawndata.rallypointhealth;

    index = 0;
    ref = undefined;

    if(vehicle.team == "axis") {
      if(vehicle.vehiclename == "apc_russian") {
        _id_0245E307F2C92CA2++;

        if(_id_0245E307F2C92CA2 <= 2)
          spawndata.ref = _id_E6FE9018451C854C + _id_0245E307F2C92CA2;
        else {}
      }
    } else if(vehicle.vehiclename == "apc_russian") {
      _id_FB299E7E5D830989++;

      if(_id_FB299E7E5D830989 <= 2)
        spawndata.ref = _id_E6FE9018451C854C + _id_FB299E7E5D830989;
      else {}
    }

    if(istrue(level.userallypointvehicles) && level.userallypointvehicles != 2)
      watchvehicleforrallypointactivation(vehicle);
  }
}

watchvehicleforrallypointactivation(vehicle) {
  scripts\mp\rally_point::rallypointvehicle_activate(vehicle);
}

getrallyvehiclespawndata(loc, team) {
  spawndata = spawnStruct();
  spawndata.origin = loc.origin;
  spawndata.angles = loc.angles;
  spawndata.spawntype = "GAME_MODE";
  spawndata.cannotbesuspended = 1;
  spawndata.team = team;
  return spawndata;
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

_id_2C3C204D81FEB239() {
  level._id_6AF5CEB6EEC10FEA = getdvarint("dvar_ECD2DCC19FC4D16E", 0);

  if(getdvarint("dvar_EB48BCB91D80ECEE", 0) == 1)
    return;
  else if(istrue(level._id_6AF5CEB6EEC10FEA)) {}

  _id_48814951E916AF89::init();

  if(istrue(level._id_6AF5CEB6EEC10FEA)) {}

  while(!isDefined(level.spawnselectionlocations))
    waitframe();

  while(!isDefined(level.stealth))
    waitframe();

  while(!isDefined(level.agentarray))
    waitframe();

  wait 1;
  _id_CFDE0D78A0770CE5 = [];

  foreach(objective in level.gw_objstruct.startingfobs_neutral) {
    _id_92DB85C8DCF21152 = spawnStruct();
    _id_92DB85C8DCF21152.origin = objective.trigger.origin;
    _id_CFDE0D78A0770CE5[_id_CFDE0D78A0770CE5.size] = _id_92DB85C8DCF21152;
  }

  _id_2BC0B0102F9B7751::_id_16C5CA10B4C664A7(_id_CFDE0D78A0770CE5, 1);
  _id_2BC0B0102F9B7751::_id_BF8AB11DD9E76F93(::_id_87B809F69028FF14);
  _id_E417E6CA41953906();
}

_id_E417E6CA41953906() {
  _id_CCFF9574F6A53859 = getdvarint("dvar_F4B8192392C987FC", 25);
  _id_B60A2AD1B8EB2369 = getdvarint("dvar_8EEC5964FBFE4A41", 5);

  if(istrue(level._id_6AF5CEB6EEC10FEA)) {}

  _id_DD7BFEA4EB1DA762 = [];

  foreach(key, data in level.spawnselectionlocations) {
    if(issubstr(key, "_hq_")) {
      continue;
    }
    _id_DD7BFEA4EB1DA762[key] = data;
  }

  _id_6C95BB29DB70AF0C = _id_DD7BFEA4EB1DA762.size * _id_CCFF9574F6A53859 / 100;
  _id_F6FFE6E5EB90834A = scripts\engine\utility::array_randomize(getarraykeys(_id_DD7BFEA4EB1DA762));

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6C95BB29DB70AF0C; _id_AC0E594AC96AA3A8++)
    _id_4C69BCDD9F13C968(_id_B60A2AD1B8EB2369, _id_F6FFE6E5EB90834A[_id_AC0E594AC96AA3A8], "team_six", 1);
}

_id_4C69BCDD9F13C968(numagents, objectivename, team, _id_FD9831032CDDAA89) {
  _id_FD5EA9CB37C309D3 = [];

  if(istrue(_id_FD9831032CDDAA89)) {
    foreach(team in level.spawnselectionlocations[objectivename])
    _id_FD5EA9CB37C309D3 = scripts\engine\utility::array_combine(_id_FD5EA9CB37C309D3, team.spawnpoints);
  }

  agents = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < numagents; _id_AC0E594AC96AA3A8++) {
    loc = scripts\engine\utility::random(_id_FD5EA9CB37C309D3);
    agent = undefined;

    if(isDefined(loc) && isDefined(loc.origin) && isDefined(loc.angles) && isDefined(objectivename)) {
      aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB();
      agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, loc.origin, loc.angles, "medium", "everybody", undefined, objectivename);

      if(!isDefined(agent) && istrue(level._id_6AF5CEB6EEC10FEA)) {}
    }

    agents[agents.size] = agent;
  }

  _id_800054CA1A89DACE = undefined;

  foreach(objective in level.gw_objstruct.startingfobs_neutral) {
    if(objective.name == objectivename) {
      _id_800054CA1A89DACE = objective.trigger.origin;
      break;
    }
  }

  foreach(agent in agents) {
    if(isalive(agent) && isDefined(agent)) {
      if(isDefined(_id_800054CA1A89DACE))
        agent _id_120270BD0A747A35::_id_304DA84D9A815C01(getclosestpointonnavmesh(_id_800054CA1A89DACE), 1024);

      agent scripts\stealth\enemy::bt_set_stealth_state("combat", undefined);
      agent._id_9A04C6CFE15E92A7 = _id_800054CA1A89DACE;
    }
  }
}

_id_E0AE27A2065777AC(objectivekey, numagents, team) {
  if(!isDefined(team))
    return undefined;

  _id_800054CA1A89DACE = level.objectives[objectivekey].trigger.origin;
  agents = _id_2BC0B0102F9B7751::_id_03779DEB97B61A65(numagents, _id_800054CA1A89DACE, "medium", "everybody", "heli", objectivekey, team);
  return agents;
}

_id_EB051CD1EA2A236E(objectivekey, numagents, team) {
  if(!isDefined(team))
    return undefined;

  _id_800054CA1A89DACE = level.objectives[objectivekey].trigger.origin;
  agents = _id_640CF1641C03E2A0::_id_55AB9C6DA96226E7(numagents, _id_800054CA1A89DACE, _id_800054CA1A89DACE[2] + 5000, undefined, "medium", "everybody", undefined, team);
  return agents;
}

_id_87B809F69028FF14(_id_34CE337E073A0C34, _id_93390A6953905FEF, team) {
  _id_9B3BB378DB91CF83 = spawnStruct();
  _id_9B3BB378DB91CF83.origin = _id_34CE337E073A0C34;
  _id_4F922AF45D0CAC6C = sortbydistance(level._id_B6D8EEC09E6F3C63._id_4F922AF45D0CAC6C, _id_9B3BB378DB91CF83.origin);
  _id_29376CACC64CC4E6 = _id_2BC0B0102F9B7751::_id_321665DCDCBF401E(_id_4F922AF45D0CAC6C, _id_34CE337E073A0C34);

  if(isDefined(_id_29376CACC64CC4E6))
    return _id_29376CACC64CC4E6;

  return undefined;
}

debugprint(text) {
  if(0)
    return;
}

isobjectivecontested(gameobject) {
  if(gameobject.ownerteam != "neutral") {
    _id_B0C33D224B825287 = scripts\mp\utility\teams::getenemyteams(gameobject.ownerteam);

    foreach(enemyteam in _id_B0C33D224B825287) {
      if(gameobject.numtouching[enemyteam] > 0)
        return 1;
    }

    return 0;
  } else
    return 0;
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

calculatecameraoffset(team, _id_800054CA1A89DACE) {
  return (0, 0, 0);
}

spawnprotectionexception() {
  if(isDefined(self.selectedspawnarea) && issubstr(self.selectedspawnarea, "HQ"))
    return 1;

  return 0;
}

_id_B88EC41808EE3630() {
  self endon("death_or_disconnect");
  self waittill("spawned_player");
  spawnheight = getdvarfloat("dvar_5B1F2FA863C241CF", 20000);
  spawnorigin = getdvarvector("dvar_9A34B1DB929C0C76", (23000, -14000, 0));
  _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_default_contents(1);

  if(level._id_1FFD19A2A9A5AA20) {
    _id_0A77F05E36991EC5 = getdvarfloat("dvar_3C6081EDC25B177B", 0.8);
    _id_9005B92B370647A5 = spawnorigin;
    _id_3B29F5840BE404C8 = level.gw_objstruct._id_384217DDF47CCB48[self.team].trigger.origin;
    _id_F069BBF68802037B = _id_3B29F5840BE404C8 - _id_9005B92B370647A5;
    dist = length(_id_F069BBF68802037B);
    dir = vectorNormalize(_id_F069BBF68802037B);
    spawnorigin = _id_9005B92B370647A5 + dir * dist * _id_0A77F05E36991EC5;
  }

  groundorigin = scripts\engine\utility::drop_to_ground(spawnorigin, 10000, -20000, undefined, _id_FBCABD62B8F66EB8);
  spawnorigin = (spawnorigin[0], spawnorigin[1], groundorigin[2]);
  spawnorigin = spawnorigin + (0, 0, spawnheight);
  spawnpoint = spawnStruct();
  spawnpoint.origin = spawnorigin;
  spawnpoint.angles = vectortoangles(level.mapcenter - spawnpoint.origin);
  _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
  _id_AD4DD16F29E24B77 = 0.0;
  _id_DFAB0807D83A77FE = 0.5;
  thread scripts\mp\playerlogic::managerespawnfade(_id_AD4DD16F29E24B77, _id_DFAB0807D83A77FE);

  if(_id_AD4DD16F29E24B77 > 0)
    self waittill("fadeDown_complete");

  self setOrigin(spawnpoint.origin);
  self setplayerangles(spawnpoint.angles);
  _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete();
  self setOrigin(spawnpoint.origin);
  self setplayerangles(spawnpoint.angles);

  if(level.parachutecancutautodeploy)
    self skydive_cutautodeployon();
  else
    self skydive_cutautodeployoff();

  if(level.parachutecancutparachute)
    self skydive_cutparachuteon();
  else
    self skydive_cutparachuteoff();

  thread scripts\cp_mp\parachute::startfreefall(level.parachutedeploydelay, 0, undefined, undefined, 1);
}

createdefaultcameras() {
  level.spawncameras["default"] = [];
  camerapos = level._id_F59A46460CC3CAB5 + level._id_4B80E3B89AD4842B * level._id_F0EE57FB9EBFB867 + (0, 0, level._id_8D385A761D1D2E9F);
  _id_6841474D6FED394F = vectorNormalize(level._id_F59A46460CC3CAB5 - camerapos);
  cameraang = scripts\mp\utility\script::vectortoanglessafe(_id_6841474D6FED394F, (0, 0, 1));
  _id_1F1C8D335BF8F19F = spawnStruct();
  _id_1F1C8D335BF8F19F.origin = camerapos;
  _id_1F1C8D335BF8F19F.angles = cameraang;

  foreach(_id_F90358454413407F in level.teamnamelist)
  level.spawncameras["default"][_id_F90358454413407F] = _id_1F1C8D335BF8F19F;

  if(0)
    thread scripts\mp\utility\debug::drawline(camerapos, level._id_F59A46460CC3CAB5, 600.0, (1, 0, 1));

  _id_796860F89DEC057D = level._id_4B80E3B89AD4842B;
  level.spawnselectionteamforward = [];

  foreach(_id_F90358454413407F in level.teamnamelist)
  level.spawnselectionteamforward[_id_F90358454413407F] = _id_796860F89DEC057D;
}

setupspawnlocations() {
  while(!isDefined(level.gamemodespawnpointnames) || !istrue(level._id_F13FCCB3E4A9F326))
    waitframe();

  level.spawnselectionlocations = [];

  foreach(_id_F90358454413407F in level.teamnamelist) {
    _id_29D9D2428185616D = scripts\mp\spawnlogic::getspawnpointarray(level.gamemodespawnpointnames[_id_F90358454413407F]);
    scripts\mp\spawnlogic::registerspawnpoints(_id_F90358454413407F, _id_29D9D2428185616D);

    foreach(s in _id_29D9D2428185616D) {
      if(level._id_1FFD19A2A9A5AA20)
        _id_B639E9890C95CC72(level._id_6121D66FFC5B8EC9[_id_F90358454413407F], _id_F90358454413407F, level.gw_objstruct._id_384217DDF47CCB48[_id_F90358454413407F].trigger.origin, s);

      foreach(obj in level.objectives)
      _id_B639E9890C95CC72(obj.name, _id_F90358454413407F, obj.trigger.origin, s);

      if(0)
        thread scripts\mp\utility\debug::drawline(s.origin, s.origin + (0, 0, 200), 600.0, (1, 0, 0));
    }

    foreach(key, _id_5A9CFC3686B1FD8D in level.spawnselectionlocations) {
      if(isDefined(_id_5A9CFC3686B1FD8D[_id_F90358454413407F]))
        scripts\mp\spawnlogic::registerspawnset(key + "_" + _id_F90358454413407F, _id_5A9CFC3686B1FD8D[_id_F90358454413407F].spawnpoints);
    }
  }

  level.usespawnselection = scripts\mp\spawnselection::_id_167619FE3D0CFF00() && level.spawnselectionlocations.size > 0;

  if(level.usespawnselection)
    level.getspawnpoint = ::getspawnpoint;
}

_id_B639E9890C95CC72(ref, team, _id_1CFCCAC3E5778BBB, _id_266C3B00991CDA91) {
  _id_CF9508A32AE936EF = getdvarint("dvar_CA02D03A0895582A", 0);
  _id_F992E8484DAF8A5F = getdvarfloat("dvar_3EF27B1B4AF37146", 0.0);
  _id_714CE97175180899 = getdvarfloat("dvar_80F34F05EBFF950B", 4000);
  _id_E7F83D51A3C75D98 = _id_1CFCCAC3E5778BBB - _id_266C3B00991CDA91.origin;

  if(!_id_CF9508A32AE936EF || _id_CF9508A32AE936EF && vectordot(anglesToForward(_id_266C3B00991CDA91.angles), _id_E7F83D51A3C75D98) > _id_F992E8484DAF8A5F) {
    if(length(_id_E7F83D51A3C75D98) < _id_714CE97175180899) {
      if(0)
        thread scripts\mp\utility\debug::drawline(_id_1CFCCAC3E5778BBB, _id_266C3B00991CDA91.origin, 600.0, (0, 1, 0));

      if(isDefined(level.spawnselectionlocations[ref]) && isDefined(level.spawnselectionlocations[ref][team])) {
        loc = level.spawnselectionlocations[ref][team];

        if(!scripts\engine\utility::array_contains(loc.spawnpoints, _id_266C3B00991CDA91)) {
          loc.spawnpoints[loc.spawnpoints.size] = _id_266C3B00991CDA91;
          return;
        }
      } else {
        struct = spawnStruct();
        struct.origin = _id_1CFCCAC3E5778BBB;
        struct.angles = (0, 0, 0);
        struct.spawnpoints = [];
        struct.spawnpoints[0] = _id_266C3B00991CDA91;

        if(!issubstr(ref, "safe"))
          scripts\mp\spawnselection::initspawnarea(team, struct, ref);
        else
          level.spawnselectionlocations[ref][team] = struct;
      }
    }
  }
}

_id_DC3A172BF923D9B3() {
  if(!scripts\mp\flags::gameflag("prematch_done"))
    return 0;

  _id_D4BA9BA1C1344502 = 0;

  foreach(location in level.spawnareas[self.team]) {
    if(!isDefined(level.spawnselectionlocations[location]) || !isDefined(level.spawnselectionlocations[location][self.team])) {
      continue;
    }
    if(issubstr(location, "_hq_")) {
      continue;
    }
    objectivekey = level.spawnselectionlocations[location][self.team].objectivekey;

    if(!scripts\mp\spawnselection::isobjectiveindanger(objectivekey, self.team)) {
      _id_D4BA9BA1C1344502 = 1;
      break;
    }
  }

  _id_370F490883F908A4 = scripts\mp\spawnselection::getsquadspawnlocations(self.team, self._id_0FF97225579DE16A);
  _id_06B1775723EF7C56 = 0;

  if(istrue(level._id_EFB4EC5A8F5352BF)) {
    foreach(_id_6CF53DD09C6AE328 in _id_370F490883F908A4) {
      if(self != _id_6CF53DD09C6AE328.dynamicent && scripts\mp\spawnselection::issquadspawnable(_id_6CF53DD09C6AE328.dynamicent)) {
        _id_06B1775723EF7C56 = 1;
        break;
      }
    }
  }

  return level._id_1FFD19A2A9A5AA20 || _id_D4BA9BA1C1344502 || _id_06B1775723EF7C56;
}

_id_B7262FC0DA03A04F() {
  if(!isDefined(self.selectedspawnarea) || !isDefined(level.spawnselectionlocations[self.selectedspawnarea]) || !isDefined(level.spawnselectionlocations[self.selectedspawnarea][self.team])) {
    return;
  }
  if(issubstr(self.selectedspawnarea, "_hq_"))
    _id_851F0CE8DF2EB27D = (level.mapcorners[0].origin + level.mapcorners[1].origin) * 0.5;
  else
    _id_851F0CE8DF2EB27D = level.spawnselectionlocations[self.selectedspawnarea][self.team].origin;

  _id_9B4F42CA197744FE = _id_851F0CE8DF2EB27D - self.spawndata.spawnorigin;
  spawnangles = vectortoangles(vectorNormalize(_id_9B4F42CA197744FE));
  self.spawndata.spawnangles = (0, spawnangles[1], 0);

  if(0)
    thread scripts\mp\utility\debug::drawline(_id_851F0CE8DF2EB27D, self.spawndata.spawnorigin, 60.0, (1, 0, 0));

  self setplayerangles(self.spawndata.spawnangles);
}

_id_AA0D1F90DCC5D366() {
  level.br_armory_kiosk = spawnStruct();
  level.br_armory_kiosk.scriptables = [];
}

_id_FB11675119ADE7D4() {
  if(getdvarint("dvar_8A1945C94D5092C2") == 1) {
    return;
  }
  level.brloottablename = getDvar("loot_table_name", "mp/loot/br/default/loot_item_defs.csv");

  if(!isDefined(level.br_pickups))
    level.br_pickups = spawnStruct();

  level.br_pickups.createcallbacks = [];
  level.br_pickups.droppedgasmasks = [];
  level.br_pickups.br_equipname = [];
  level.br_pickups.stackable = [];
  level.br_pickups.maxcounts = [];
  level.br_pickups.counts = [];
  level.br_pickups.br_itemtype = [];
  level.br_pickups.br_itemrow = [];
  level.br_pickups.br_itemrarity = [];
  level.br_pickups._id_D93566A78E29D583 = [];
  level.br_pickups.br_equipnametoscriptable = [];
  level.br_pickups.br_weapontoscriptable = [];
  level.br_pickups._id_7B2BFF2D04EE1017 = [];
  level.br_pickups._id_B13DC7E63676BBE7 = [];
  level.br_pickups.br_pickupsfx = [];
  level.br_pickups._id_14BD11727C4B6629 = [];
  level.br_pickups._id_838863C4848D4C26 = [];
  level.br_pickups.br_hasautopickup = [];
  level.br_pickups.uniquelootcallbacks = [];
  level.br_pickups.br_allguns = [];
  level.br_pickups.br_lootguns = [];
  level.br_pickups.br_crateguns = [];
  level.br_pickups.br_crateitems = [];
  level.br_pickups.br_gulagpickups = [];
  level.br_lootiteminfo = [];
  level.br_weaponsprimary = [];
  level.br_weaponssecondary = [];
  level.br_throwables = [];
  level.br_usables = [];
}

_id_5456C21DE8F2BBBC() {
  if(getdvarint("dvar_8A1945C94D5092C2") == 1) {
    return;
  }
  level._effect["vfx_extract_smoke"] = loadfx("vfx/iw8_br/gameplay/vfx_br_adv_supply_drop_marker");
  level._effect["vfx_br_cashLeaderBag"] = loadfx("vfx/iw8_br/gameplay/vfx_br_money_vip_burst.vfx");
  level.br_plunder_lobby = getdvarint("dvar_A17AADC2E70FAAD1", 1) != 0 && istrue(level.allowprematchdamage);
  level.br_plunder = spawnStruct();
  level.br_plunder.plunderlimit = 16383;
  level.br_plunder.plunder_items_picked_up = 0;
  level.br_plunder.plunder_value_picked_up = 0;
  level.br_plunder.plunder_items_dropped = 0;
  level.br_plunder.plunder_value_dropped = 0;
  level.br_plunder.kiosk_spent_total = 0;
  level.br_plunder.kiosk_num_purchases = 0;
  level.br_plunder.extraction_balloon_total_plunder = 0;
  level.br_plunder.extraction_balloon_num_completed = 0;
  level.br_plunder.extraction_helicoptor_total_plunder = 0;
  level.br_plunder.extraction_helicoptor_num_completed = 0;
  level.br_plunder.plunder_awarded_by_missions_total = 0;
  level.br_plunder.itemsinworld = [];
  level.br_plunder.itemsinworld["brloot_plunder_cash_common_1"] = getscriptablelootspawnedcountbyname("brloot_plunder_cash_common_1");
  _id_6AFF3948CF4CCA03::setupquantities();
  level.br_depots = [];
  _id_6AFF3948CF4CCA03::initplayerplunderevents();
  _id_6AFF3948CF4CCA03::initteamdatafields();
}

_id_D23C7C1ADD9FB181() {
  _id_9F098B6FC547A435 = undefined;
  _id_42CA41C7DADAE0C0 = undefined;

  foreach(objective in level.objectives) {
    dist = distancesquared(self.origin, objective.curorigin);

    if(!isDefined(_id_9F098B6FC547A435) || dist < _id_42CA41C7DADAE0C0) {
      _id_9F098B6FC547A435 = objective;
      _id_42CA41C7DADAE0C0 = dist;
    }
  }

  return _id_9F098B6FC547A435;
}

_id_1629419647B0F862() {
  _id_4384ABBF498DF6A7::init();
  level._id_6BEFF7B631AB7E18 = ::_id_6BEFF7B631AB7E18;
  _id_16858EAC88E8C825 = [];
  _id_16858EAC88E8C825[_id_16858EAC88E8C825.size] = "longer_capture_time";
  _id_16858EAC88E8C825[_id_16858EAC88E8C825.size] = "ammo_depot";
  _id_16858EAC88E8C825[_id_16858EAC88E8C825.size] = "uav_ping";
  _id_16858EAC88E8C825[_id_16858EAC88E8C825.size] = "ai_squad";
  _id_16858EAC88E8C825[_id_16858EAC88E8C825.size] = "ai_jugg";
  _id_16858EAC88E8C825[_id_16858EAC88E8C825.size] = "deploy_minefield";
  level._id_57734B23ED1998D6 = 1;
  level._id_73E72117ADA9CCE6 = getdvarfloat("dvar_E8C1E6C77E11300D", level.flagcapturetime * 2.0);
  level._id_5B25E7620E424CB2 = [];
  level._id_1B37B352EC399488 = [];
  level._id_B8D2B366AC757DA6 = [];
  _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_default_contents(1);

  foreach(key, objective in level.objectives) {
    groundorigin = scripts\engine\utility::drop_to_ground(objective.curorigin + anglesToForward(objective.trigger.angles) * 50, 50, -200, undefined, _id_FBCABD62B8F66EB8);
    _id_2FA65F34EB9042F5 = spawnscriptable("br_plunder_box", groundorigin, objective.trigger.angles);
    _id_2FA65F34EB9042F5.objectivekey = key;
    level._id_5B25E7620E424CB2[key] = _id_2FA65F34EB9042F5;
    _id_2FA65F34EB9042F5 setscriptablepartstate("br_plunder_box", "visible");
    _id_2FA65F34EB9042F5._id_5CFA621EBF61D8AA = 0;
    _id_9316A571D5756B1B = spawnStruct();
    _id_9316A571D5756B1B.origin = scripts\engine\utility::drop_to_ground(objective.curorigin + anglesToForward(objective.trigger.angles) * -50, 50, -200, undefined, _id_FBCABD62B8F66EB8);
    _id_9316A571D5756B1B.angles = objective.trigger.angles;
    _id_D7043241CAEEA644 = scripts\mp\ammorestock::_id_2AC210AF318CF38B(_id_9316A571D5756B1B);
    _id_D7043241CAEEA644 hide();
    level._id_B8D2B366AC757DA6[key] = _id_D7043241CAEEA644;

    foreach(ref in _id_16858EAC88E8C825)
    level._id_1B37B352EC399488[key][ref] = 0;
  }

  level thread _id_C800466F69DFC582();
}

_id_6BEFF7B631AB7E18(instance, player) {
  if(istrue(instance._id_5CFA621EBF61D8AA) || istrue(level._id_8E9DABA162280A8E))
    player setclientomnvar("ui_buystation_override", _id_600B944A95C3A7BF::_id_54B046AA3BA2678A("personalOnly"));

  player _id_E29957ADFBE3C040(instance.objectivekey);
}

_id_E29957ADFBE3C040(objectivekey) {
  _id_5C9DDCF56D36F133 = 0;

  if(istrue(level._id_1B37B352EC399488[objectivekey]["longer_capture_time"]))
    _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 1;

  if(istrue(level._id_1B37B352EC399488[objectivekey]["ammo_depot"]))
    _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 2;

  if(istrue(level._id_1B37B352EC399488[objectivekey]["uav_ping"]))
    _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 4;

  if(istrue(level._id_1B37B352EC399488[objectivekey]["ai_squad"]))
    _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 8;

  if(istrue(level._id_1B37B352EC399488[objectivekey]["ai_jugg"]))
    _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 16;

  self setclientomnvar("ui_upgrade_status", _id_5C9DDCF56D36F133);
}

_id_C800466F69DFC582() {
  scripts\mp\flags::gameflagwait("prematch_done");

  if(istrue(level._id_7F5BE0207E7457B1)) {
    return;
  }
  foreach(key, _id_2FA65F34EB9042F5 in level._id_5B25E7620E424CB2) {
    foreach(team in level.teamnamelist)
    _id_2FA65F34EB9042F5 _id_8D03978A31FABA3A(key, team);
  }
}

_id_6ED651811C936A22() {
  if(!istrue(level._id_57734B23ED1998D6)) {
    return;
  }
  if(istrue(level._id_7F5BE0207E7457B1)) {
    return;
  }
  foreach(key, _id_2FA65F34EB9042F5 in level._id_5B25E7620E424CB2) {
    ownerteam = level.objectives[key] scripts\mp\gameobjects::getownerteam();

    if(self.team == ownerteam) {
      _id_2FA65F34EB9042F5 enablescriptableplayeruse(self);
      continue;
    }

    _id_2FA65F34EB9042F5 disablescriptableplayeruse(self);
  }

  foreach(key, _id_D7043241CAEEA644 in level._id_B8D2B366AC757DA6) {
    ownerteam = level.objectives[key] scripts\mp\gameobjects::getownerteam();

    if(self.team == ownerteam && istrue(level._id_1B37B352EC399488[key]["ammo_depot"])) {
      _id_D7043241CAEEA644 enablescriptableplayeruse(self);
      continue;
    }

    _id_D7043241CAEEA644 disablescriptableplayeruse(self);
  }
}

_id_E8A6E840EF663C81(key, team) {
  if(!istrue(level._id_57734B23ED1998D6)) {
    return;
  }
  if(istrue(level._id_7F5BE0207E7457B1)) {
    return;
  }
  if(!isDefined(team) || !scripts\mp\utility\teams::isgameplayteam(team)) {
    return;
  }
  foreach(player in level.players) {
    if(player.team == team) {
      level._id_5B25E7620E424CB2[key] enablescriptableplayeruse(player);
      continue;
    }

    level._id_5B25E7620E424CB2[key] disablescriptableplayeruse(player);
  }
}

_id_8D03978A31FABA3A(key, team) {
  if(!istrue(level._id_57734B23ED1998D6)) {
    return;
  }
  if(!isDefined(team) || !scripts\mp\utility\teams::isgameplayteam(team)) {
    return;
  }
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players)
  level._id_5B25E7620E424CB2[key] disablescriptableplayeruse(player);
}

_id_4DE8052758F986F3(player, ref) {
  if(!istrue(level._id_57734B23ED1998D6))
    return 0;

  objective = player _id_D23C7C1ADD9FB181();

  if(objective.ownerteam != player.team)
    return 0;

  return level._id_1B37B352EC399488[objective.objectivekey][ref];
}

_id_3CE1055115EDCBBB(player, ref) {
  if(!istrue(level._id_57734B23ED1998D6))
    return 0;

  objective = player _id_D23C7C1ADD9FB181();

  if(objective.ownerteam != player.team)
    return 0;

  _id_E154E439D3C5FCB5(objective.objectivekey, ref);
  return 1;
}

_id_E154E439D3C5FCB5(objectivekey, ref) {
  if(!istrue(level._id_57734B23ED1998D6)) {
    return;
  }
  level._id_1B37B352EC399488[objectivekey][ref] = 1;
  ownerteam = level.objectives[objectivekey] scripts\mp\gameobjects::getownerteam();

  switch (ref) {
    case "longer_capture_time":
      level.objectives[objectivekey] scripts\mp\gameobjects::setusetime(level._id_73E72117ADA9CCE6);
      _func_FCE61CB0E2F1FC68(level.objectives[objectivekey].objidnum, 1);
      break;
    case "ammo_depot":
      _id_D05DE3A316EDA41F(objectivekey, ownerteam);
      break;
    case "uav_ping":
      level.objectives[objectivekey] thread _id_C929FB023D29DE5E(ownerteam);
      break;
    case "ai_squad":
      _id_E0AE27A2065777AC(objectivekey, 5, ownerteam);
      break;
    case "ai_jugg":
      groupname = _id_48814951E916AF89::_id_78759441C259F58A();
      agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF("enemy_mp_jugg_base", level.objectives[objectivekey].trigger.origin, (0, 0, 0), "absolute", "everybody", "jugg", groupname, ownerteam);
      _id_371B4C2AB5861E62::_id_1828F1E20E52B418(agent);
      agent thread _id_120270BD0A747A35::_id_B11C1964F528574B(agent);
      break;
    case "deploy_minefield":
      break;
  }
}

_id_3D186B2B2EE293BB(objectivekey, ref) {
  if(!istrue(level._id_57734B23ED1998D6)) {
    return;
  }
  level._id_1B37B352EC399488[objectivekey][ref] = 0;

  switch (ref) {
    case "longer_capture_time":
      level.objectives[objectivekey] scripts\mp\gameobjects::setusetime(level.flagcapturetime);
      _func_FCE61CB0E2F1FC68(level.objectives[objectivekey].objidnum, 0);
      break;
    case "ammo_depot":
      foreach(team in level.teamnamelist)
      _id_A1C82CB0172D09A6(objectivekey, team);

      break;
    case "uav_ping":
      level.objectives[objectivekey] thread _id_2F936733AA3FF4C5();
      break;
    case "deploy_minefield":
    case "ai_jugg":
    case "ai_squad":
      break;
  }
}

_id_666A2979DEF5D705(objectivekey) {
  if(!istrue(level._id_57734B23ED1998D6)) {
    return;
  }
  foreach(ref, value in level._id_1B37B352EC399488[objectivekey])
  _id_3D186B2B2EE293BB(objectivekey, ref);
}

_id_D05DE3A316EDA41F(key, team) {
  if(!istrue(level._id_57734B23ED1998D6)) {
    return;
  }
  if(!isDefined(team) || !scripts\mp\utility\teams::isgameplayteam(team)) {
    return;
  }
  level._id_B8D2B366AC757DA6[key] show();
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players)
  level._id_B8D2B366AC757DA6[key] enablescriptableplayeruse(player);
}

_id_A1C82CB0172D09A6(key, team) {
  if(!istrue(level._id_57734B23ED1998D6)) {
    return;
  }
  if(!isDefined(team) || !scripts\mp\utility\teams::isgameplayteam(team)) {
    return;
  }
  level._id_B8D2B366AC757DA6[key] hide();
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players)
  level._id_B8D2B366AC757DA6[key] disablescriptableplayeruse(player);
}

_id_C929FB023D29DE5E(team) {
  if(!istrue(level._id_57734B23ED1998D6)) {
    return;
  }
  if(!isDefined(team) || !scripts\mp\utility\teams::isgameplayteam(team)) {
    return;
  }
  radius = getdvarint("dvar_00BBF08A38C88577", 3000);
  duration = getdvarfloat("dvar_E34E9EA29B7CC0A9", 3.0);
  self endon("disableUAVPing");

  for(;;) {
    triggerportableradarpingteam(self.curorigin, team, radius, int(duration * 1000));
    wait(duration);
  }
}

_id_2F936733AA3FF4C5() {
  if(!istrue(level._id_57734B23ED1998D6)) {
    return;
  }
  self notify("disableUAVPing");
}

_id_EFBC646224FDA4FA() {
  level thread _id_64ACB6CE534155B7::utilflare_shootflare(self.origin, "revive");
  spawnheight = getdvarfloat("dvar_50F18343F33B6153", 8000);
  spawnorigin = self.origin;
  spawnorigin = spawnorigin + (0, 0, spawnheight);
  _id_AD4DD16F29E24B77 = 0.0;
  _id_DFAB0807D83A77FE = 0.5;
  thread scripts\mp\playerlogic::managerespawnfade(_id_AD4DD16F29E24B77, _id_DFAB0807D83A77FE);

  if(_id_AD4DD16F29E24B77 > 0)
    self waittill("fadeDown_complete");

  _id_851F0CE8DF2EB27D = (level.mapcorners[0].origin + level.mapcorners[1].origin) * 0.5;
  _id_9B4F42CA197744FE = _id_851F0CE8DF2EB27D - spawnorigin;
  spawnangles = vectortoangles(vectorNormalize(_id_9B4F42CA197744FE));
  self setOrigin(spawnorigin);
  self setplayerangles(spawnangles);

  if(level.parachutecancutautodeploy)
    self skydive_cutautodeployon();
  else
    self skydive_cutautodeployoff();

  if(level.parachutecancutparachute)
    self skydive_cutparachuteon();
  else
    self skydive_cutparachuteoff();

  thread scripts\cp_mp\parachute::startfreefall(level.parachutedeploydelay, 0, undefined, undefined, 1);
}

_id_1347E3AB3C68B20E(_id_5932BBEF2FA89F92) {
  _id_E6A7BB0501F0EBD4 = _id_1416C66B41EDF9EE(_id_5932BBEF2FA89F92);

  foreach(player in scripts\mp\utility\teams::getteamdata(_id_E6A7BB0501F0EBD4, "players"))
  player thread _id_190616CDBC044966(player, _id_5932BBEF2FA89F92, 1);

  return _id_E6A7BB0501F0EBD4;
}

_id_1416C66B41EDF9EE(_id_5932BBEF2FA89F92) {
  _id_156EE87BDEAE6828 = 0;
  _id_4BDDE661AF8E9ED5 = [];
  _id_B7E76E8A63129A64 = undefined;

  foreach(team in level.teamnamelist) {
    if(team == _id_5932BBEF2FA89F92) {
      continue;
    }
    _id_BC2470C042A8B5F3 = _id_6663215F917210AE::getteamflagcount(team);

    if(_id_4BDDE661AF8E9ED5.size == 0) {
      _id_156EE87BDEAE6828 = _id_BC2470C042A8B5F3;
      _id_4BDDE661AF8E9ED5[_id_4BDDE661AF8E9ED5.size] = team;
      continue;
    }

    if(_id_BC2470C042A8B5F3 < _id_156EE87BDEAE6828) {
      _id_156EE87BDEAE6828 = _id_BC2470C042A8B5F3;
      _id_4BDDE661AF8E9ED5 = [];
      _id_4BDDE661AF8E9ED5[_id_4BDDE661AF8E9ED5.size] = team;
      continue;
    }

    if(_id_BC2470C042A8B5F3 == _id_156EE87BDEAE6828)
      _id_4BDDE661AF8E9ED5[_id_4BDDE661AF8E9ED5.size] = team;
  }

  if(_id_4BDDE661AF8E9ED5.size > 1)
    _id_B7E76E8A63129A64 = scripts\engine\utility::random(_id_4BDDE661AF8E9ED5);
  else
    _id_B7E76E8A63129A64 = _id_4BDDE661AF8E9ED5[0];

  return _id_B7E76E8A63129A64;
}

_id_F525754162A91372(_id_B46BDDA9AB158F09, _id_E6A7BB0501F0EBD4) {
  foreach(objective in level.objectives) {
    if(objective.ownerteam == _id_E6A7BB0501F0EBD4) {
      if(_id_B46BDDA9AB158F09 == "neutral")
        objective._id_B2555C1E8CA32569 = 1;

      objective objective_onuse(undefined, _id_B46BDDA9AB158F09);
    }
  }
}

_id_2A8ADCC9B74F4838() {
  _id_F538734234F5F0D4 = 0;
  _id_14B2FF118503F57B = undefined;

  for(;;) {
    foreach(team in level.teamnamelist) {
      _id_E1FC3ECB1D9E8392 = calculateobjectivesheld(team);

      if(_id_E1FC3ECB1D9E8392 >= level.objectives.size) {
        _id_14B2FF118503F57B = team;
        _id_F538734234F5F0D4 = 1;
        break;
      }
    }

    if(_id_F538734234F5F0D4) {
      break;
    }

    waitframe();
  }

  setomnvar("ui_nuke_timer_type", 2);
  setomnvar("ui_nuke_timer_time", 10);
  setomnvar("ui_nuke_countdown_active", 1);
  setomnvar("ui_arm_dominatingTeam", scripts\engine\utility::array_find(level.allteamnamelist, _id_14B2FF118503F57B));
  starttime = gettime();
  endtime = 10000 + starttime;
  setomnvar("ui_nuke_end_milliseconds", 10000 + starttime);

  for(;;) {
    waitframe();

    if(gettime() > endtime) {
      break;
    }
  }

  level nuke_triggermercywin(_id_14B2FF118503F57B);
}

_id_D37D95AC1717903C() {
  if(isDefined(level._id_9584CEC5D16D159F)) {
    _id_1D647D624F816CD9 = [];
    _id_EEEF116046415E84 = undefined;

    foreach(_id_F90358454413407F in level.teamnamelist) {
      if(_id_F90358454413407F != level._id_9584CEC5D16D159F && _id_F90358454413407F != level._id_9584DCC5D16D3469)
        _id_1D647D624F816CD9[_id_1D647D624F816CD9.size] = _id_F90358454413407F;
    }

    numplayers = 0;
    _id_D94AB82B7DF755A1 = undefined;

    foreach(_id_F90358454413407F in _id_1D647D624F816CD9) {
      numplayers = scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "teamCount");

      if(!isDefined(_id_D94AB82B7DF755A1)) {
        _id_D94AB82B7DF755A1 = numplayers;
        _id_EEEF116046415E84 = _id_F90358454413407F;
        continue;
      }

      if(numplayers < _id_D94AB82B7DF755A1) {
        _id_EEEF116046415E84 = _id_F90358454413407F;
        continue;
      }

      if(numplayers == _id_D94AB82B7DF755A1)
        _id_EEEF116046415E84 = scripts\engine\utility::random(_id_1D647D624F816CD9);
    }

    scripts\mp\menus::setteam(_id_1D647D624F816CD9);
  }
}

_id_F6857CA2E18431E9(_id_3168C8300EF54732, _id_E6A7BB0501F0EBD4) {
  foreach(team in level.teamnamelist) {
    if(team == _id_3168C8300EF54732) {
      scripts\mp\hud_util::showsplashtoteam(team, "risk_team_absorb_us");
      continue;
    }

    if(team == _id_E6A7BB0501F0EBD4) {
      scripts\mp\hud_util::showsplashtoteam(team, "risk_team_absorb_them");
      continue;
    }

    scripts\mp\hud_util::showsplashtoteam(team, "risk_team_absorb_other");
  }
}