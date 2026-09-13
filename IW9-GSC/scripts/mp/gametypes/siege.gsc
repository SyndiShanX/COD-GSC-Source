/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\siege.gsc
***********************************************/

main() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  level.isgroundwarsiege = 0;
  matchmakingmatch = getdvarint("onlinegame") && !getdvarint("xblive_privatematch");

  if(matchmakingmatch)
    level.isgroundwarsiege = getdvarint("dvar_F2D9A572DB1504F1", 0);

  level.allowmodestructs = [];

  if(level.isgroundwarsiege)
    level.allowmodestructs[level.allowmodestructs.size] = "arm";

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  _id_9BBACB179DEA3237[1] = "dom";

  if(istrue(level.isgroundwarsiege))
    _id_9BBACB179DEA3237[_id_9BBACB179DEA3237.size] = "arm";

  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 3, 0, 12);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 300);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 4);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerwinbytwoenableddvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinbytwomaxroundsdvar(scripts\mp\utility\game::getgametype(), 4);
  }

  updategametypedvars();
  level.objectivebased = 1;
  level.teambased = 1;
  level.nobuddyspawns = 1;
  level.gamehasstarted = 0;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.onplayerdisconnect = ::onplayerdisconnect;
  level.onplayerjointeam = ::onplayerjointeam;
  level.getspawnpoint = ::getspawnpoint;
  level.modeonspawnplayer = ::onspawnplayer;
  level.onplayerkilled = ::onplayerkilled;
  level.ondeadevent = ::ondeadevent;
  level.ononeleftevent = ::ononeleftevent;
  level.ontimelimit = ::ontimelimit;
  level.lastcaptime = gettime();
  level.alliesprevflagcount = 0;
  level.axisprevflagcount = 0;
  level.allowlatecomers = 0;
  level.gametimerbeeps = 0;
  level.rushtimerteam = "none";
  level.siegeflagcapturing = [];

  if(level.isgroundwarsiege) {
    level.requiredplayercountoveride = 1;
    level.requiredplayercount["allies"] = 12;
    level.requiredplayercount["axis"] = 12;
    level.modecontrolledvehiclespawningonly = 1;
    level.maxhqtanks = 0;
    level.numnonrallyvehicles = getdvarint("dvar_6695D60EF1E8627D", 25);
    level.skipplaybodycountsound = 1;
    level.disablespawncamera = 1;
    mapname = scripts\cp_mp\utility\game_utility::getmapname();

    switch (mapname) {
      case "mp_farms2":
      case "mp_riverside_gw":
      case "mp_promenade_gw":
      case "mp_layover_gw":
      case "mp_boneyard_gw":
      case "mp_port2_gw":
      case "mp_farms2_gw":
      case "mp_downtown_gw":
      case "mp_quarry2":
        scripts\cp_mp\parachute::initparachutedvars();
        break;
      default:
        break;
    }

    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      switch (mapname) {
        case "mp_downtown_gw":
          setDvar("scr_localeID", 6);
          break;
        case "mp_quarry2":
          setDvar("scr_localeID", 5);
          break;
        case "mp_farms2":
        case "mp_farms2_gw":
          setDvar("scr_localeID", 9);
          break;
        case "mp_port2_gw":
          setDvar("scr_localeID", 3);
          break;
        case "mp_boneyard_gw":
          setDvar("scr_localeID", 4);
          break;
        case "mp_aniyah":
          setDvar("scr_localeID", 17);
          break;
        case "mp_promenade_gw":
          setDvar("scr_localeID", 18);
          break;
        case "mp_layover_gw":
          setDvar("scr_localeID", 10);
          break;
        case "mp_riverside_gw":
          setDvar("scr_localeID", 19);
          break;
        default:
          setDvar("scr_localeID", 0);
      }
    }
  }

  game["canScoreOnTie"] = 1;

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    game["dialog"]["gametype"] = "iw9_mpsg_mode_uktl_snt1";
  else
    game["dialog"]["gametype"] = "gametype_siege";

  game["dialog"]["boost"] = "boost_siege";
  game["dialog"]["offense_obj"] = "boost_siege";
  game["dialog"]["defense_obj"] = "boost_siege";
  game["dialog"]["securing_a"] = "securing_a";
  game["dialog"]["securing_b"] = "securing_b";
  game["dialog"]["securing_c"] = "securing_c";
  game["dialog"]["secured_a"] = "secure_a";
  game["dialog"]["secured_b"] = "secure_b";
  game["dialog"]["secured_c"] = "secure_c";
  game["dialog"]["losing_a"] = "losing_a";
  game["dialog"]["losing_b"] = "losing_b";
  game["dialog"]["losing_c"] = "losing_c";
  game["dialog"]["lost_a"] = "lost_a";
  game["dialog"]["lost_b"] = "lost_b";
  game["dialog"]["lost_c"] = "lost_c";
  game["dialog"]["enemy_captured_2"] = "siege_enemy_captured_2";
  game["dialog"]["friendly_captured_2"] = "siege_friendly_captured_2";
  game["dialog"]["lastalive_zones"] = "lastalive_zones";
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("dvar_041BD47D6D0DEF56", getmatchrulesdata("siegeData", "rushTimer"));
  setdynamicdvar("scr_siege_rushtimeramount", getmatchrulesdata("siegeData", "rushTimerAmount"));
  setdynamicdvar("scr_siege_sharedrushtimer", getmatchrulesdata("siegeData", "sharedRushTimer"));
  setdynamicdvar("scr_siege_precappoints", getmatchrulesdata("siegeData", "preCapPoints"));
  setdynamicdvar("scr_siege_caprate", getmatchrulesdata("siegeData", "capRate"));
  setdynamicdvar("dvar_462E8DC6C1E380CC", getmatchrulesdata("siegeData", "objScalar"));
  setdynamicdvar("dvar_E2D968DAB42F65EE", getmatchrulesdata("siegeData", "holdAllTimer"));
  setdynamicdvar("scr_siege_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("siege", 0);
}

seticonnames() {
  level.iconneutral = "waypoint_captureneutral";
  level.iconcapture = "waypoint_capture";
  level.icondefend = "waypoint_defend";
  level.icondefending = "waypoint_defending";
  level.iconcontested = "waypoint_contested";
  level.icontaking = "waypoint_taking";
  level.iconlosing = "waypoint_losing";
}

onstartgametype() {
  seticonnames();

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    _id_2B21F2FBE8DD5C6E = game["attackers"];
    _id_8D904E28CF14C8AE = game["defenders"];
    game["attackers"] = _id_8D904E28CF14C8AE;
    game["defenders"] = _id_2B21F2FBE8DD5C6E;
  }

  foreach(_id_F90358454413407F in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/DOM");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/DOM");
    else
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/DOM_SCORE");

    scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/DOM_HINT");
  }

  thread waittooverridegraceperiod();

  if(level.isgroundwarsiege) {
    thread adjustroundendtimer();
    _id_3BA4F32E41F63B36::initspawns(isDefined(game["roundsPlayed"]) && game["roundsPlayed"] != 0);
    level thread _id_3BA4F32E41F63B36::setupwaypointicons();
    _id_3BA4F32E41F63B36::debug_setupmatchdata();
    _id_3BA4F32E41F63B36::setuphqs();
    _id_3BA4F32E41F63B36::calculatehqmidpoint();
    level.numsiegeflags = getdvarint("dvar_9EEE1E1F8390AC94", 3);
    setomnvar("ui_num_dom_flags", level.numsiegeflags);
    _id_3BA4F32E41F63B36::setupobjectives();
    level thread runobjectives();
    thread _id_27C2DB69A21775A0::init_groundwarvehicles();
    thread initvehicles();
    _id_3BA4F32E41F63B36::emergency_cleanupents();
  } else {
    initspawns();
    thread domflags();
  }

  thread watchflagtimerpause();
  thread watchgamestart();

  if(scripts\mp\utility\game::matchmakinggame())
    thread watchgameinactive();
}

vehiclespawn_getspawndata(loc) {
  spawndata = spawnStruct();
  spawndata.origin = loc.origin;
  spawndata.angles = loc.angles;
  spawndata.spawntype = "GAME_MODE";
  spawndata.showheadicon = 1;
  return spawndata;
}

registervehicletype(refname, _id_E4015CFE956F4F3F) {
  vehicleinfo = spawnStruct();
  vehicleinfo.refname = refname;
  vehicleinfo.spawncallback = _id_E4015CFE956F4F3F;
  vehicleinfo.vehiclespawns = scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F(refname);
  level.vehicleinfo[refname] = vehicleinfo;
}

initvehicles() {
  level.numhqtanks_axis = 0;
  level.numhqtanks_allies = 0;

  if(!isDefined(level.vehicleinfo))
    level.vehicleinfo = [];

  registervehicletype("little_bird", ::vehiclespawn_littlebird);
  registervehicletype("atv", ::vehiclespawn_atv);
  registervehicletype("tac_rover", ::vehiclespawn_tacrover);
  level.vehiclespawnlocs = [];

  foreach(vehicleinfo in level.vehicleinfo) {
    switch (vehicleinfo.refname) {
      case "little_bird":
        vehicleinfo.vehiclespawns = getvehiclespawns("little_bird", "veh9_mil_air_heli_medium_physics_mp");
        break;
      case "atv":
        vehicleinfo.vehiclespawns = getvehiclespawns("atv", "veh9_mil_lnd_atv_physics_mp");
        break;
      case "tac_rover":
        vehicleinfo.vehiclespawns = getvehiclespawns("tac_rover", "tromeo_physics_mp");
        break;
    }

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
}

getvehiclespawns(_id_7731ADEF63E19B0C, vehicletype) {
  _id_29D9D2428185616D = [];
  mapname = scripts\cp_mp\utility\game_utility::getmapname();
  atvoriginsarray = [];
  atvanglesarray = [];
  _id_380B98510B5D0765 = [];
  _id_FB7E5F19EFD9D046 = [];

  switch (mapname) {
    case "mp_downtown_gw":
      if(_id_7731ADEF63E19B0C == "atv") {
        atvoriginsarray[atvoriginsarray.size] = (21843.8, -4640.11, -476.961);
        atvoriginsarray[atvoriginsarray.size] = (20375.9, -3612.78, -454);
        atvoriginsarray[atvoriginsarray.size] = (20728.8, -3309.36, -456);
        atvanglesarray[atvanglesarray.size] = (0, 255, 0);
        atvanglesarray[atvanglesarray.size] = (0, 330, 0);
        atvanglesarray[atvanglesarray.size] = (0, 292, 0);
        atvoriginsarray[atvoriginsarray.size] = (20937.2, -9029.28, -379.674);
        atvoriginsarray[atvoriginsarray.size] = (23097.1, -9966.89, -344);
        atvanglesarray[atvanglesarray.size] = (356.825, 240, 0);
        atvanglesarray[atvanglesarray.size] = (0, 0, 0);
        atvoriginsarray[atvoriginsarray.size] = (17471, -23211.4, -204);
        atvoriginsarray[atvoriginsarray.size] = (15960.1, -22768.1, -204);
        atvoriginsarray[atvoriginsarray.size] = (15821.3, -23568, -208.461);
        atvanglesarray[atvanglesarray.size] = (0, 90, 0);
        atvanglesarray[atvanglesarray.size] = (0, 45, 0);
        atvanglesarray[atvanglesarray.size] = (0, 90, 0);
        atvoriginsarray[atvoriginsarray.size] = (22994.3, -15304.5, -216);
        atvanglesarray[atvanglesarray.size] = (0, 105, 0);
      } else if(_id_7731ADEF63E19B0C == "tac_rover") {
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (20120.2, -3287.71, -456);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (21339.9, -4787.55, -450.176);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 345, 0);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (357.831, 255.032, -1.25312);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (17449, -22190.1, -208.116);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (16651.1, -22178.2, -207.908);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 60, 0);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 60, 0);
      }

      break;
    case "mp_quarry2":
      if(_id_7731ADEF63E19B0C == "atv") {
        atvoriginsarray[atvoriginsarray.size] = (26335.7, 30412.6, 655.471);
        atvoriginsarray[atvoriginsarray.size] = (27099.5, 30567.5, 639.236);
        atvoriginsarray[atvoriginsarray.size] = (27315.5, 30525.5, 639.236);
        atvanglesarray[atvanglesarray.size] = (0.0728273, 119, 0.843973);
        atvanglesarray[atvanglesarray.size] = (2.67817, 77.0718, 1.59551);
        atvanglesarray[atvanglesarray.size] = (2.67817, 77.0718, 1.59551);
        atvoriginsarray[atvoriginsarray.size] = (29610.4, 38228.5, 698.883);
        atvoriginsarray[atvoriginsarray.size] = (29465.5, 38973.6, 701);
        atvanglesarray[atvanglesarray.size] = (0, 315, 0);
        atvanglesarray[atvanglesarray.size] = (0, 88.9989, 0);
        atvoriginsarray[atvoriginsarray.size] = (39153, 46431.8, 932.749);
        atvoriginsarray[atvoriginsarray.size] = (38876.4, 46106.9, 925.771);
        atvoriginsarray[atvoriginsarray.size] = (37923.7, 47136.4, 949.247);
        atvanglesarray[atvanglesarray.size] = (1.88064, 180.047, 0.333796);
        atvanglesarray[atvanglesarray.size] = (1.47639, 180.039, 1.17305);
        atvanglesarray[atvanglesarray.size] = (359.077, 185.712, 7.76991);
        atvoriginsarray[atvoriginsarray.size] = (33628.2, 40971.6, 653.047);
        atvoriginsarray[atvoriginsarray.size] = (32104.4, 41719.8, 708.773);
        atvanglesarray[atvanglesarray.size] = (349.991, 186.286, -2.23687);
        atvanglesarray[atvanglesarray.size] = (3.95499, 211.371, 4.41818);
      } else if(_id_7731ADEF63E19B0C == "tac_rover") {
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (26310.8, 30168.4, 659.426);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (26954, 29794.1, 651.013);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (358.195, 118.006, -2.71651);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 89.9998, 0);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (38573.2, 47052.8, 950.28);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (39660.3, 45949.9, 952.362);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (359.669, 194.507, -0.439539);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (11.7511, 162.518, 0.102679);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (33138.2, 41498.6, 707.349);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (357.81, 284.768, 1.14713);
      }

      break;
    case "mp_farms2":
    case "mp_farms2_gw":
      if(_id_7731ADEF63E19B0C == "atv") {
        atvoriginsarray[atvoriginsarray.size] = (49063.3, -22654.9, -385.662);
        atvoriginsarray[atvoriginsarray.size] = (47332.9, -23070.6, -374.497);
        atvoriginsarray[atvoriginsarray.size] = (48281.3, -22202.5, -371.375);
        atvanglesarray[atvanglesarray.size] = (0.0275984, 103.998, 0.280605);
        atvanglesarray[atvanglesarray.size] = (357.226, 88.8435, 4.3294);
        atvanglesarray[atvanglesarray.size] = (3.93534, 89.3527, 4.34541);
        atvoriginsarray[atvoriginsarray.size] = (49720, -18492, -387.562);
        atvoriginsarray[atvoriginsarray.size] = (48107.4, -18052.3, -312.859);
        atvanglesarray[atvanglesarray.size] = (0, 73.9972, 0);
        atvanglesarray[atvanglesarray.size] = (352.657, 118.56, -10.3306);
        atvoriginsarray[atvoriginsarray.size] = (46431.3, -92.3425, -52.4549);
        atvoriginsarray[atvoriginsarray.size] = (47471, -192.634, -43.7394);
        atvoriginsarray[atvoriginsarray.size] = (48085.6, -358.42, 9.73944);
        atvanglesarray[atvanglesarray.size] = (359.802, 240.821, -3.32839);
        atvanglesarray[atvanglesarray.size] = (0.975088, 240.828, 0.322594);
        atvanglesarray[atvanglesarray.size] = (6.15886, 241.028, 2.20885);
        atvoriginsarray[atvoriginsarray.size] = (44528.7, -5376.79, 283.824);
        atvoriginsarray[atvoriginsarray.size] = (43628, -5846.41, 346.636);
        atvanglesarray[atvanglesarray.size] = (357.74, 256.16, -1.56165);
        atvanglesarray[atvanglesarray.size] = (0.506229, 241.181, 0.438595);
      } else if(_id_7731ADEF63E19B0C == "tac_rover") {
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (47872.6, -22645.4, -385.49);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (48501.7, -22505, -382.243);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (1.68464, 109.9, -3.26246);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (359.897, 89.9842, 8.71393);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (46034.5, -59.925, -29.8834);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (47108.8, -498.535, -35.0573);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (2.33612, 243.444, -0.141863);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (355.135, 243.112, 2.65064);
      }

      break;
    case "mp_port2_gw":
      if(_id_7731ADEF63E19B0C == "atv") {
        atvoriginsarray[atvoriginsarray.size] = (31381.3, -35260.4, -566.754);
        atvoriginsarray[atvoriginsarray.size] = (31087.5, -35307.9, -566.206);
        atvanglesarray[atvanglesarray.size] = (0, 106, 0);
        atvanglesarray[atvanglesarray.size] = (0, 91, 0);
        atvoriginsarray[atvoriginsarray.size] = (37273.8, -22647.6, -566);
        atvoriginsarray[atvoriginsarray.size] = (38224.6, -23864.4, -566);
        atvanglesarray[atvanglesarray.size] = (0, 225, 0);
        atvanglesarray[atvanglesarray.size] = (0, 225, 0);
        atvoriginsarray[atvoriginsarray.size] = (37183.4, -15816, -558.929);
        atvoriginsarray[atvoriginsarray.size] = (36704.9, -15941.1, -558);
        atvoriginsarray[atvoriginsarray.size] = (37630.9, -15950.5, -564);
        atvanglesarray[atvanglesarray.size] = (0, 270, 0);
        atvanglesarray[atvanglesarray.size] = (0, 270, 0);
        atvanglesarray[atvanglesarray.size] = (0, 270, 0);
        atvoriginsarray[atvoriginsarray.size] = (34323.3, -25831.8, -566);
        atvanglesarray[atvanglesarray.size] = (0, 45, 0);
      } else if(_id_7731ADEF63E19B0C == "tac_rover") {
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (31412.5, -34658.3, -564.862);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (31042.3, -16171.6, -565.383);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 105, 0);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 75, 0);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (36937.6, -15836.1, -559.8);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (37369.7, -16171.6, -562);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 270, 0);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 270, 0);
      }

      break;
    case "mp_boneyard_gw":
      if(_id_7731ADEF63E19B0C == "atv") {
        atvoriginsarray[atvoriginsarray.size] = (-28937.7, -17197.8, -246.637);
        atvoriginsarray[atvoriginsarray.size] = (-29175.8, -17121.9, -247.909);
        atvoriginsarray[atvoriginsarray.size] = (-28096.5, -16918.8, -246.085);
        atvanglesarray[atvanglesarray.size] = (1.203, 90, 0.12);
        atvanglesarray[atvanglesarray.size] = (0.597, 90, 0.15);
        atvanglesarray[atvanglesarray.size] = (358.68, 90.0277, -0.8);
        atvoriginsarray[atvoriginsarray.size] = (-25926, -12688.6, -89.5073);
        atvoriginsarray[atvoriginsarray.size] = (-24872.9, -12661.3, -65.0808);
        atvanglesarray[atvanglesarray.size] = (5.13576, 104.619, 0.240957);
        atvanglesarray[atvanglesarray.size] = (358.169, 15, -3.49767);
        atvoriginsarray[atvoriginsarray.size] = (-28315.5, -3152.67, -311.293);
        atvoriginsarray[atvoriginsarray.size] = (-28107.5, -3152.67, -311.293);
        atvoriginsarray[atvoriginsarray.size] = (-27778.8, -3591.73, -310.621);
        atvanglesarray[atvanglesarray.size] = (0.061, 270, 7.355);
        atvanglesarray[atvanglesarray.size] = (0.061, 270, 7.355);
        atvanglesarray[atvanglesarray.size] = (0, 270, 0);
        atvoriginsarray[atvoriginsarray.size] = (-25666, -8411.14, -47.9997);
        atvoriginsarray[atvoriginsarray.size] = (-26998.2, -9004.54, -40);
        atvanglesarray[atvanglesarray.size] = (358.715, 15.233, -10.279);
        atvanglesarray[atvanglesarray.size] = (0, 285, 0);
      } else if(_id_7731ADEF63E19B0C == "tac_rover") {
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-28683.3, -16741.2, -249.16);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-29128.7, -16577.6, -229.266);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (359.734, 90.0021, -0.454);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (353.195, 90.3463, -3.01942);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-27985.4, -3613.97, -315.978);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-28449.8, -3645.92, -312.247);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 270.003, 5.684);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 270.004, -3.208);
      }

      break;
    case "mp_aniyah":
      break;
    case "mp_promenade_gw":
      if(_id_7731ADEF63E19B0C == "atv") {
        atvoriginsarray[atvoriginsarray.size] = (-9606.95, -21527.2, -279.043);
        atvoriginsarray[atvoriginsarray.size] = (-10288.2, -20891.9, -356.989);
        atvoriginsarray[atvoriginsarray.size] = (-11011.4, -19877, -368.358);
        atvanglesarray[atvanglesarray.size] = (0, 200, 0);
        atvanglesarray[atvanglesarray.size] = (0, 222, 0);
        atvanglesarray[atvanglesarray.size] = (359.526, 210.007, -0.952);
        atvoriginsarray[atvoriginsarray.size] = (-13835.9, -23127.9, -278.639);
        atvoriginsarray[atvoriginsarray.size] = (-14327.9, -22160.8, -266.586);
        atvanglesarray[atvanglesarray.size] = (2.373, 210, 0);
        atvanglesarray[atvanglesarray.size] = (0.806, 194.929, 2.603);
        atvoriginsarray[atvoriginsarray.size] = (-21725.2, -26511, -152);
        atvoriginsarray[atvoriginsarray.size] = (-21577.7, -26755.1, -151.997);
        atvoriginsarray[atvoriginsarray.size] = (-21065.3, -27199.1, -148.746);
        atvanglesarray[atvanglesarray.size] = (0, 30, 0);
        atvanglesarray[atvanglesarray.size] = (0, 60, 0);
        atvanglesarray[atvanglesarray.size] = (5.079, 0.128, 1.453);
        atvoriginsarray[atvoriginsarray.size] = (-18873.3, -25796.5, -199.784);
        atvanglesarray[atvanglesarray.size] = (0, 30, 0);
      } else if(_id_7731ADEF63E19B0C == "tac_rover") {
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-10912.6, -20079.6, -367);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-10108.5, -21861.4, -287.271);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 196.996, 0);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (7.93172, 180.719, 4.15911);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-22036.5, -25881.6, -147.198);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-21144.5, -27447.1, -151.145);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 345, 0);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 30, 0);
      }

      break;
    case "mp_layover_gw":
      if(_id_7731ADEF63E19B0C == "atv") {
        atvoriginsarray[atvoriginsarray.size] = (-3749, 16980, -262);
        atvoriginsarray[atvoriginsarray.size] = (-2971.9, 18898, -262);
        atvoriginsarray[atvoriginsarray.size] = (-2735.8, 16203, -262);
        atvanglesarray[atvanglesarray.size] = (0, 218, 0);
        atvanglesarray[atvanglesarray.size] = (0, 174, 0);
        atvanglesarray[atvanglesarray.size] = (0, 208, 0);
        atvoriginsarray[atvoriginsarray.size] = (-11894, 16161, -266);
        atvoriginsarray[atvoriginsarray.size] = (-11841, 15884, -266);
        atvanglesarray[atvanglesarray.size] = (0, 162, 0);
        atvanglesarray[atvanglesarray.size] = (0, 248, 0);
        atvoriginsarray[atvoriginsarray.size] = (-29137, 12868, -244);
        atvoriginsarray[atvoriginsarray.size] = (-29539, 12883, -252);
        atvoriginsarray[atvoriginsarray.size] = (-29040, 13706, -497);
        atvanglesarray[atvanglesarray.size] = (0, 0, 0);
        atvanglesarray[atvanglesarray.size] = (0, 0, 0);
        atvanglesarray[atvanglesarray.size] = (0, 5, 0);
        atvoriginsarray[atvoriginsarray.size] = (-19181, 16384, -263);
        atvoriginsarray[atvoriginsarray.size] = (-19650, 17253, 54);
        atvoriginsarray[atvoriginsarray.size] = (-19937, 16123, -261);
        atvanglesarray[atvanglesarray.size] = (0, 310, 0);
        atvanglesarray[atvanglesarray.size] = (0, 357, 0);
        atvanglesarray[atvanglesarray.size] = (0, 35, 0);
      } else if(_id_7731ADEF63E19B0C == "tac_rover") {
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-3520, 17805, -262);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-3892, 18566, -262);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 165, 0);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 194, 0);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-29131, 13010, -244);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-28676, 13724, -518);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 0, 0);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 355, 0);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-19622, 17422, 54);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 357, 0);
      }

      break;
    case "mp_riverside_gw":
      if(_id_7731ADEF63E19B0C == "atv") {
        atvoriginsarray[atvoriginsarray.size] = (4103, 26076, 57);
        atvoriginsarray[atvoriginsarray.size] = (4247, 25021, -38);
        atvoriginsarray[atvoriginsarray.size] = (3517, 25981, 47);
        atvanglesarray[atvanglesarray.size] = (0, 143, 0);
        atvanglesarray[atvanglesarray.size] = (0, 189, 0);
        atvanglesarray[atvanglesarray.size] = (0, 103, 0);
        atvoriginsarray[atvoriginsarray.size] = (4989, 29842, 253);
        atvoriginsarray[atvoriginsarray.size] = (1725, 28703, 51);
        atvanglesarray[atvanglesarray.size] = (0, 162, 0);
        atvanglesarray[atvanglesarray.size] = (0, 141, 0);
        atvoriginsarray[atvoriginsarray.size] = (-6826, 33623, -46);
        atvoriginsarray[atvoriginsarray.size] = (-7642, 32168, -188);
        atvoriginsarray[atvoriginsarray.size] = (-6589, 32564, -82);
        atvanglesarray[atvanglesarray.size] = (3, 337, 0);
        atvanglesarray[atvanglesarray.size] = (0, 357, 0);
        atvanglesarray[atvanglesarray.size] = (0, 320, 0);
        atvoriginsarray[atvoriginsarray.size] = (-3326, 32657, 238);
        atvoriginsarray[atvoriginsarray.size] = (-2149, 33264, 253);
        atvanglesarray[atvanglesarray.size] = (0, 325, 0);
        atvanglesarray[atvanglesarray.size] = (0, 287, 0);
      } else if(_id_7731ADEF63E19B0C == "tac_rover") {
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (4157, 26465, 65);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (4628, 26545, 63);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 143, 0);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 63, 0);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-7337, 32683, -77);
        _id_380B98510B5D0765[_id_380B98510B5D0765.size] = (-6671, 32948, -67);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 320, 0);
        _id_FB7E5F19EFD9D046[_id_FB7E5F19EFD9D046.size] = (0, 36, 0);
      }

      break;
    default:
      break;
  }

  level.atvoriginsarray = atvoriginsarray;
  level.atvanglesarray = atvanglesarray;

  if(_id_7731ADEF63E19B0C == "atv") {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < atvoriginsarray.size; _id_AC0E594AC96AA3A8++) {
      if(_id_AC0E594AC96AA3A8 <= atvoriginsarray.size - 1) {
        _id_76239E3CB66A8278 = atvoriginsarray[_id_AC0E594AC96AA3A8];
        _id_79BDB2F0B2F0C692 = atvanglesarray[_id_AC0E594AC96AA3A8];
        vehicle = spawnStruct();
        vehicle.origin = _id_76239E3CB66A8278;
        vehicle.angles = _id_79BDB2F0B2F0C692;
        vehicle.targetname = _id_7731ADEF63E19B0C;
        vehicle.vehicletype = vehicletype;
        _id_29D9D2428185616D[_id_29D9D2428185616D.size] = vehicle;
      }
    }
  } else if(_id_7731ADEF63E19B0C == "tac_rover") {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_380B98510B5D0765.size; _id_AC0E594AC96AA3A8++) {
      if(_id_AC0E594AC96AA3A8 <= _id_380B98510B5D0765.size - 1) {
        _id_D82A9436EEE389CB = _id_380B98510B5D0765[_id_AC0E594AC96AA3A8];
        _id_17085FD4C01A3645 = _id_FB7E5F19EFD9D046[_id_AC0E594AC96AA3A8];
        vehicle = spawnStruct();
        vehicle.origin = _id_D82A9436EEE389CB;
        vehicle.angles = _id_17085FD4C01A3645;
        vehicle.targetname = _id_7731ADEF63E19B0C;
        vehicle.vehicletype = vehicletype;
        _id_29D9D2428185616D[_id_29D9D2428185616D.size] = vehicle;
      }
    }
  }

  _id_CEFFD5A372961F55 = _func_2EF675C13CA1C4AF("dvar_AD95D7262A11119E", _id_7731ADEF63E19B0C);
  index = 0;

  for(;;) {
    _id_F826F0378F17AE2F = _func_2EF675C13CA1C4AF(_id_CEFFD5A372961F55, "_origin_", index);
    _id_0D9C6C3C1205D844 = _func_2EF675C13CA1C4AF(_id_CEFFD5A372961F55, "_angles_", index);
    _id_08A4EA3A3BAA22E4 = (0, 0, 0);
    origin = getdvarvector(_id_F826F0378F17AE2F, _id_08A4EA3A3BAA22E4);

    if(origin == (0, 0, 0)) {
      break;
    }

    vehicle = spawnStruct();
    vehicle.origin = origin;
    _id_7224BACAB3F8EE26 = (0, 0, 0);
    vehicle.angles = getdvarvector(_id_0D9C6C3C1205D844, _id_7224BACAB3F8EE26);
    vehicle.targetname = _id_7731ADEF63E19B0C;
    vehicle.vehicletype = vehicletype;
    _id_29D9D2428185616D[_id_29D9D2428185616D.size] = vehicle;
    index++;
  }

  return _id_29D9D2428185616D;
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

filtervehiclespawnstructs(_id_9E4E1482CB40C9C5) {
  _id_7CB19F95DBC68942 = [];

  if(getdvarint("dvar_0ADB05B8132EC13B", level.brtdm_config.locale_defaults["scr_brtdm_disable_radiant_vehicles"]) == 1)
    return _id_7CB19F95DBC68942;

  foreach(struct in _id_9E4E1482CB40C9C5) {
    if(distance2dsquared(struct.origin, level.brtdm_config.circlecenter) < level.brtdm_config.circleradius * level.brtdm_config.circleradius)
      _id_7CB19F95DBC68942[_id_7CB19F95DBC68942.size] = struct;
  }

  return _id_7CB19F95DBC68942;
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level.rushtimer = scripts\mp\utility\dvars::dvarintvalue("rushTimer", 1, 0, 1);
  level.rushtimeramount = scripts\mp\utility\dvars::dvarfloatvalue("rushTimerAmount", 45.0, 30.0, 120);
  level.sharedrushtimer = scripts\mp\utility\dvars::dvarfloatvalue("sharedRushTimer", 0, 0, 1);
  level.precappoints = scripts\mp\utility\dvars::dvarintvalue("preCapPoints", 0, 0, 1);
  level.caprate = scripts\mp\utility\dvars::dvarfloatvalue("capRate", 7.5, 1, 60);
  level.objectivescaler = scripts\mp\utility\dvars::dvarfloatvalue("objScalar", 2, 1, 10);
  level.holdallflagstimer = scripts\mp\utility\dvars::dvarfloatvalue("holdAllTimer", 7.5, 0, 60);
}

adjustroundendtimer() {
  wait 1;
  level.roundenddelay = 8.0;
}

waittooverridegraceperiod() {
  scripts\mp\flags::gameflagwait("prematch_done");

  if(!level.isgroundwarsiege)
    level.overrideingraceperiod = 1;
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_dom_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_dom_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dom_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dom_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dom_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dom_spawn_secondary", 1, 1);
  _id_29D9D2428185616D = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn");
  _id_3A5288F40C8BE099 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("dom", _id_29D9D2428185616D);
  scripts\mp\spawnlogic::registerspawnset("dom_fallback", _id_3A5288F40C8BE099);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  if(level.isgroundwarsiege) {
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
  } else {
    spawnteam = self.pers["team"];
    otherteam = scripts\mp\utility\game::getotherteam(spawnteam)[0];

    if(level.usestartspawns) {
      scripts\mp\spawnlogic::setactivespawnlogic("StartSpawn", "Crit_Default");

      if(game["switchedsides"]) {
        spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_" + otherteam + "_start");
        spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn(spawnpoints);
      } else {
        spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_" + spawnteam + "_start");
        spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn(spawnpoints);
      }
    } else {
      scripts\mp\spawnlogic::setactivespawnlogic("Domination", "Crit_Default");
      _id_E02688745E0052C3 = getteamdompoints(spawnteam);
      enemyteam = scripts\mp\utility\game::getotherteam(spawnteam)[0];
      _id_DB44AC0D1491F876 = getteamdompoints(enemyteam);
      _id_A57270E5BA6E59A3 = _id_2DC3A143158CEC7C::getpreferreddompoints(_id_E02688745E0052C3, _id_DB44AC0D1491F876, spawnteam, otherteam);
      _id_BA0A9FD614A3F6EE = [];
      _id_BA0A9FD614A3F6EE["preferredDomPoints"] = _id_A57270E5BA6E59A3["preferred"];
      _id_BA0A9FD614A3F6EE["secondaryDomPoints"] = _id_A57270E5BA6E59A3["secondary"];
      scripts\mp\spawnlogic::activatespawnset("dom");
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, "dom", "dom_fallback", undefined, _id_BA0A9FD614A3F6EE);
    }

    return spawnpoint;
  }
}

getteamdompoints(team) {
  _id_E02688745E0052C3 = [];

  foreach(_id_1183B8D0EE70C22F in level.objectives) {
    if(_id_1183B8D0EE70C22F.ownerteam == team)
      _id_E02688745E0052C3[_id_E02688745E0052C3.size] = _id_1183B8D0EE70C22F;
  }

  return _id_E02688745E0052C3;
}

gettimesincedompointcapture(_id_1183B8D0EE70C22F) {
  return gettime() - _id_1183B8D0EE70C22F.capturetime;
}

onplayerconnect(player) {
  player._domflageffect = [];
  player._domflagpulseeffect = [];
  player thread onplayerspawned();
  player thread _id_6663215F917210AE::ondisconnect();
  player.siegelatecomer = 1;

  if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"] != 0 && !scripts\mp\flags::gameflag("prematch_done"))
    player thread manageprematchfade();
}

onplayerdisconnect(player) {
  for(;;) {
    player waittill("disconnect");

    foreach(effect in player._domflageffect) {
      if(isDefined(effect))
        effect delete();
    }
  }
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned");
    scripts\mp\utility\stats::setextrascore0(0);

    if(isDefined(self.pers["captures"]))
      scripts\mp\utility\stats::setextrascore0(self.pers["captures"]);

    scripts\mp\utility\stats::setextrascore1(0);

    if(isDefined(self.pers["rescues"]))
      scripts\mp\utility\stats::setextrascore1(self.pers["rescues"]);
  }
}

onplayerjointeam(player) {
  if(scripts\mp\utility\game::gamehasstarted())
    player.siegelatecomer = 1;
}

onspawnplayer(_id_9156B53BCF7CE573) {
  level notify("spawned_player");
  thread _id_2DC3A143158CEC7C::updatematchstatushintonspawn();
}

checkallowspectating() {
  if(level.rushtimerteam == "none") {
    return;
  }
  if(!scripts\mp\utility\teams::getteamdata(level.rushtimerteam, "aliveCount")) {
    level.spectateoverride[level.rushtimerteam].allowenemyspectate = 1;
    scripts\mp\spectating::updatespectatesettings();
  }
}

domflags() {
  level endon("game_ended");
  primaryflags = getEntArray("flag_primary", "targetname");
  _id_528742B1628EB47C = getEntArray("flag_secondary", "targetname");

  if(primaryflags.size + _id_528742B1628EB47C.size < 2) {
    return;
  }
  _id_615B735DDA2A4C94 = "mp/siegeFlagPos.csv";
  _id_7B8A8DDCC38832E8 = scripts\cp_mp\utility\game_utility::getmapname();
  _id_DE9E89F4DFE76629 = 1;

  for(_id_2F6EDB39CF97E7FB = 2; _id_2F6EDB39CF97E7FB < 11; _id_2F6EDB39CF97E7FB++) {
    _id_0FB1BE37BB7CDA28 = tablelookup(_id_615B735DDA2A4C94, _id_DE9E89F4DFE76629, _id_7B8A8DDCC38832E8, _id_2F6EDB39CF97E7FB);

    if(_id_0FB1BE37BB7CDA28 != "")
      setflagpositions(_id_2F6EDB39CF97E7FB, float(_id_0FB1BE37BB7CDA28));
  }

  triggers = [];

  for(index = 0; index < primaryflags.size; index++)
    triggers[triggers.size] = primaryflags[index];

  for(index = 0; index < _id_528742B1628EB47C.size; index++)
    triggers[triggers.size] = _id_528742B1628EB47C[index];

  level.numsiegeflags = 3;
  setomnvar("ui_num_dom_flags", level.numsiegeflags);

  if(level.numsiegeflags == 3) {
    foreach(trigger in primaryflags)
    trigger _id_2DC3A143158CEC7C::remapdomtriggerscriptlabel();
  }

  level.objectives = [];

  for(index = 0; index < triggers.size; index++) {
    trigger = triggers[index];

    if(level.numsiegeflags == 3) {
      if(trigger.script_label == "_d" || trigger.script_label == "_e")
        continue;
    }

    trigger.origin = getflagpos(trigger.script_label, trigger.origin);

    if(isDefined(trigger.target))
      visuals[0] = getEnt(trigger.target, "targetname");
    else {
      visuals[0] = spawn("script_model", trigger.origin);
      visuals[0].angles = trigger.angles;
    }

    domflag = scripts\mp\gameobjects::createuseobject("neutral", trigger, visuals, (0, 0, 100), 1, 1);
    domflag scripts\mp\gameobjects::allowuse("enemy");
    domflag scripts\mp\gameobjects::setusetime(level.caprate);

    if(isDefined(trigger.objectivekey))
      domflag.objectivekey = trigger.objectivekey;
    else
      domflag.objectivekey = domflag scripts\mp\gameobjects::getlabel();

    if(isDefined(trigger.iconname))
      domflag.iconname = trigger.iconname;
    else
      domflag.iconname = domflag scripts\mp\gameobjects::getlabel();

    domflag scripts\mp\gameobjects::cancontestclaim(1);
    domflag.nousebar = 1;
    domflag.id = "domFlag";
    domflag.firstcapture = 1;
    domflag.prevteam = "neutral";
    domflag.flagcapsuccess = 0;
    domflag.playersrevived = 0;
    domflag.claimgracetime = level.caprate * 1000;
    domflag scripts\mp\gameobjects::pinobjiconontriggertouch();
    tracestart = visuals[0].origin + (0, 0, 32);
    _id_8B39E5984DA1FFAF = visuals[0].origin + (0, 0, -32);
    trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, undefined, scripts\engine\trace::create_default_contents(1));
    offset = _id_6663215F917210AE::checkmapoffsets(domflag);
    domflag.baseeffectpos = trace["position"] + offset;
    upangles = vectortoangles(trace["normal"]);
    _id_232BC202587CA413 = _id_6663215F917210AE::checkmapfxangles(domflag, upangles);
    domflag.baseeffectforward = anglesToForward(_id_232BC202587CA413);
    domflag.noscriptable = 1;
    domflag.flagmodel = spawn("script_model", domflag.baseeffectpos);
    domflag.flagmodel setModel("military_dom_flag_neutral");
    level.objectives[domflag.objectivekey] = domflag;
  }

  _id_7FC4B3DB1868930F = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_axis_start");
  _id_99A20728731AC0B0 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_allies_start");
  level.startpos["allies"] = _id_99A20728731AC0B0[0].origin;
  level.startpos["axis"] = _id_7FC4B3DB1868930F[0].origin;
  level.bestspawnflag = [];
  level.bestspawnflag["allies"] = _id_6663215F917210AE::getunownedflagneareststart("allies", undefined);
  level.bestspawnflag["axis"] = _id_6663215F917210AE::getunownedflagneareststart("axis", level.bestspawnflag["allies"]);
  _id_2DC3A143158CEC7C::flagsetup();

  if(!scripts\mp\flags::gameflag("prematch_done"))
    level scripts\engine\utility::waittill_any_2("prematch_done", "start_mode_setup");

  foreach(flag in level.objectives) {
    _id_3C2389BA69E5822B = _id_6663215F917210AE::getreservedobjid(flag.objectivekey);
    flag scripts\mp\gameobjects::requestid(1, 1, _id_3C2389BA69E5822B);
    flag.onuse = ::onuse;
    flag.onbeginuse = ::onbeginuse;
    flag.onuseupdate = ::onuseupdate;
    flag.onenduse = ::onenduse;
    flag.oncontested = ::oncontested;
    flag.onuncontested = ::onuncontested;
    flag.onunoccupied = ::onunoccupied;
    flag.onpinnedstate = ::onpinnedstate;
    flag.onunpinnedstate = ::onunpinnedstate;
    flag.stompeenemyprogressupdate = ::onstompeenemyprogressupdate;
    flag.stompprogressreward = ::stompprogressreward;
    flag scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_target");
    flag scripts\mp\gameobjects::setvisibleteam("any");
    flag _id_6663215F917210AE::domflag_setneutral();
  }

  if(level.precappoints)
    _id_6663215F917210AE::precap();
}

setneutral() {
  if(scripts\mp\gameobjects::getownerteam() == "neutral")
    thread _id_6663215F917210AE::updateflagstate("idle", 0);
}

setflagpositions(col, _id_6B7DCAB5EC19E36A) {
  switch (col) {
    case 2:
      level.siege_a_xpos = _id_6B7DCAB5EC19E36A;
      break;
    case 3:
      level.siege_a_ypos = _id_6B7DCAB5EC19E36A;
      break;
    case 4:
      level.siege_a_zpos = _id_6B7DCAB5EC19E36A;
      break;
    case 5:
      level.siege_b_xpos = _id_6B7DCAB5EC19E36A;
      break;
    case 6:
      level.siege_b_ypos = _id_6B7DCAB5EC19E36A;
      break;
    case 7:
      level.siege_b_zpos = _id_6B7DCAB5EC19E36A;
      break;
    case 8:
      level.siege_c_xpos = _id_6B7DCAB5EC19E36A;
      break;
    case 9:
      level.siege_c_ypos = _id_6B7DCAB5EC19E36A;
      break;
    case 10:
      level.siege_c_zpos = _id_6B7DCAB5EC19E36A;
      break;
  }
}

getflagpos(_id_45360A7A32781F43, _id_1907878D3D2F9C75) {
  _id_DB56AC4DFE639215 = _id_1907878D3D2F9C75;

  if(_id_45360A7A32781F43 == "_a") {
    if(isDefined(level.siege_a_xpos) && isDefined(level.siege_a_ypos) && isDefined(level.siege_a_zpos))
      _id_DB56AC4DFE639215 = (level.siege_a_xpos, level.siege_a_ypos, level.siege_a_zpos);
  } else if(_id_45360A7A32781F43 == "_b") {
    if(isDefined(level.siege_b_xpos) && isDefined(level.siege_b_ypos) && isDefined(level.siege_b_zpos))
      _id_DB56AC4DFE639215 = (level.siege_b_xpos, level.siege_b_ypos, level.siege_b_zpos);
  } else if(isDefined(level.siege_c_xpos) && isDefined(level.siege_c_ypos) && isDefined(level.siege_c_zpos))
    _id_DB56AC4DFE639215 = (level.siege_c_xpos, level.siege_c_ypos, level.siege_c_zpos);

  return _id_DB56AC4DFE639215;
}

watchflagtimerpause() {
  level endon("game_ended");

  for(;;) {
    level waittill("flag_capturing", flag);

    if(level.rushtimer) {
      if(flag.prevteam != "neutral") {
        _id_118719DB7C3B0EEF = scripts\mp\utility\game::getotherteam(flag.prevteam)[0];

        if(isDefined(level.siegetimerstate) && level.siegetimerstate != "pause" && !iswinningteam(_id_118719DB7C3B0EEF)) {
          level.gametimerbeeps = 0;
          level.siegetimerstate = "pause";
          pausecountdowntimer();

          if(!flagownersalive(flag.prevteam))
            setwinner(_id_118719DB7C3B0EEF, tolower(game[flag.prevteam]) + "_eliminated");
        }
      }
    }
  }
}

iswinningteam(team) {
  _id_9B2A59FACC5B7A67 = 0;
  teamflags = getflagcount(team);

  if(level.numsiegeflags == 3) {
    if(teamflags == 2)
      _id_9B2A59FACC5B7A67 = 1;
  } else if(teamflags >= 3)
    _id_9B2A59FACC5B7A67 = 1;

  return _id_9B2A59FACC5B7A67;
}

flagownersalive(team) {
  _id_6378CCB27AA322D2 = 0;

  foreach(player in level.participants) {
    if(isDefined(player) && player.team == team && (scripts\mp\utility\player::isreallyalive(player) || player.pers["lives"] > 0)) {
      _id_6378CCB27AA322D2 = 1;
      break;
    }
  }

  return _id_6378CCB27AA322D2;
}

pausecountdowntimer() {
  if(!level.timerstoppedforgamemode) {
    _id_FCA15F66515AC04B = level.rushtimeramount;

    if(isDefined(level.siegetimeleft))
      _id_FCA15F66515AC04B = level.siegetimeleft;

    _id_E0968D887A942520 = int(gettime() + _id_FCA15F66515AC04B * 1000);
    scripts\mp\gamelogic::pausetimer(_id_E0968D887A942520);
  }

  level notify("siege_timer_paused");
}

resumecountdowntimer(_id_66C2115B7D407541) {
  _id_FCA15F66515AC04B = level.rushtimeramount;

  if(level.timerstoppedforgamemode) {
    if(isDefined(level.siegetimeleft))
      _id_FCA15F66515AC04B = level.siegetimeleft;

    _id_E0968D887A942520 = int(gettime() + _id_FCA15F66515AC04B * 1000);
    setgameendtime(_id_E0968D887A942520);
    scripts\mp\gamelogic::resumetimer(_id_E0968D887A942520);

    if(!isDefined(level.siegetimerstate) || level.siegetimerstate == "pause")
      level.siegetimerstate = "start";

    thread watchgametimer(_id_FCA15F66515AC04B);

    if(istrue(_id_66C2115B7D407541)) {
      if(level.siegeflagcapturing.size > 0)
        level notify("flag_capturing", self);
    }
  }
}

watchflagenduse(team) {
  level endon("game_ended");
  _id_464C0E9847A1A49A = 0;
  _id_B96A5E9D06866903 = 0;
  _id_DF3F0FE977558F9F = level.rushtimerteam;
  _id_464C0E9847A1A49A = getflagcount("allies");
  _id_B96A5E9D06866903 = getflagcount("axis");

  if(level.rushtimer && level.rushtimerteam != "none") {
    if(level.sharedrushtimer || _id_464C0E9847A1A49A == 1 && _id_B96A5E9D06866903 == 1) {
      level.siegetimerstate = "start";
      notifyplayers("siege_timer_start");
      resumecountdowntimer(1);
      return;
    }
  }

  if(_id_464C0E9847A1A49A == level.numsiegeflags)
    setwinner("allies", "siege_allflags_win", "siege_allflags_loss");
  else if(_id_B96A5E9D06866903 == level.numsiegeflags)
    setwinner("axis", "siege_allflags_win", "siege_allflags_loss");
  else if(level.rushtimer) {
    if(_id_464C0E9847A1A49A == 2 || _id_B96A5E9D06866903 == 2) {
      level.rushtimerteam = scripts\engine\utility::ter_op(_id_464C0E9847A1A49A > _id_B96A5E9D06866903, "allies", "axis");

      if(_id_DF3F0FE977558F9F != level.rushtimerteam) {
        if(isDefined(level.siegetimerstate) && level.siegetimerstate != "reset") {
          level.gametimerbeeps = 0;
          level.siegetimeleft = undefined;
          level.siegetimerstate = "reset";
          notifyplayers("siege_timer_reset");
        }

        if(!isDefined(level.siegetimerstate) || level.siegetimerstate != "start") {
          _id_FCA15F66515AC04B = level.rushtimeramount;

          if(isDefined(level.siegetimeleft))
            _id_FCA15F66515AC04B = level.siegetimeleft;

          _id_E0968D887A942520 = int(gettime() + _id_FCA15F66515AC04B * 1000);
          level.timelimitoverride = 1;
          scripts\mp\gamelogic::pausetimer(_id_E0968D887A942520);
          setgameendtime(_id_E0968D887A942520);
          scripts\mp\gamelogic::resumetimer(_id_E0968D887A942520);

          if(!isDefined(level.siegetimerstate) || level.siegetimerstate == "pause") {
            level.siegetimerstate = "start";
            notifyplayers("siege_timer_start");
          }

          if(!level.gametimerbeeps)
            thread watchgametimer(_id_FCA15F66515AC04B);
        }
      } else if(_id_DF3F0FE977558F9F == level.rushtimerteam && _id_464C0E9847A1A49A == 1 || _id_DF3F0FE977558F9F == level.rushtimerteam && _id_B96A5E9D06866903 == 1)
        resumecountdowntimer(1);
      else if(level.rushtimer) {
        level.gametimerbeeps = 0;
        level.siegetimeleft = undefined;
        level.siegetimerstate = "reset";
        notifyplayers("siege_timer_reset");
        resumecountdowntimer(1);
      }
    }
  }

  self.prevteam = self.ownerteam;
}

watchgameinactive() {
  level endon("game_ended");
  level endon("flag_capturing");
  timelimit = getdvarfloat("scr_siege_timelimit");

  if(timelimit > 0) {
    _id_44A306DB74F92B95 = timelimit - 1;

    while(_id_44A306DB74F92B95 > 0) {
      _id_44A306DB74F92B95 = _id_44A306DB74F92B95 - 1;
      wait 1;
    }

    level.siegegameinactive = 1;
  }
}

watchgamestart() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  while(!havespawnedplayers())
    waitframe();

  level.gamehasstarted = 1;
}

havespawnedplayers() {
  if(level.teambased) {
    foreach(team in level.teamnamelist) {
      if(!scripts\mp\utility\teams::getteamdata(team, "hasSpawned"))
        return 0;
    }

    return 1;
  }

  return level.maxplayercount > 1;
}

watchgametimer(gametime) {
  level endon("game_ended");
  level endon("siege_timer_paused");
  level endon("siege_timer_reset");
  remainingtime = gametime;
  _id_FC7BD6576D8C85BE = spawn("script_origin", (0, 0, 0));
  _id_FC7BD6576D8C85BE hide();
  level.gametimerbeeps = 1;

  while(remainingtime > 0) {
    remainingtime = remainingtime - 1;
    level.siegetimeleft = remainingtime;

    if(remainingtime <= 30) {
      if(remainingtime != 0)
        _id_FC7BD6576D8C85BE playSound("ui_mp_timer_countdown");
    }

    wait 1;
  }

  ontimelimit();
}

getflagcount(team) {
  teamflags = 0;

  foreach(flag in level.objectives) {
    if(flag.ownerteam == team && !isbeingcaptured(flag))
      teamflags = teamflags + 1;
  }

  return teamflags;
}

isbeingcaptured(flag) {
  _id_22C8BE36A2C1DB6D = 0;

  if(isDefined(flag)) {
    if(level.siegeflagcapturing.size > 0) {
      foreach(_id_45360A7A32781F43 in level.siegeflagcapturing) {
        if(flag.objectivekey == _id_45360A7A32781F43)
          _id_22C8BE36A2C1DB6D = 1;
      }
    }
  }

  return _id_22C8BE36A2C1DB6D;
}

setwinner(team, _id_401C3A2E68AAB0FD, _id_99B197E077E1D642) {
  foreach(player in level.players) {
    if(!isai(player))
      player setclientomnvar("ui_objective_pinned_text_param", 0);
  }

  if(isDefined(_id_99B197E077E1D642))
    thread scripts\mp\gamelogic::endgame(team, game["end_reason"][_id_401C3A2E68AAB0FD], game["end_reason"][_id_99B197E077E1D642]);
  else
    thread scripts\mp\gamelogic::endgame(team, game["end_reason"][_id_401C3A2E68AAB0FD]);
}

onbeginuse(player) {
  if(!scripts\engine\utility::array_contains(level.siegeflagcapturing, self.objectivekey)) {
    level.siegeflagcapturing[level.siegeflagcapturing.size] = self.objectivekey;
    ownerteam = scripts\mp\gameobjects::getownerteam();
    player setclientomnvar("ui_objective_pinned_text_param", 1);
    self.didstatusnotify = 0;
    scripts\mp\gameobjects::setusetime(level.caprate);
  }

  level notify("flag_capturing", self);
}

onuse(_id_22282E7D48CA3400) {
  self.didstatusnotify = 0;
  team = _id_22282E7D48CA3400.team;
  _id_8A04AA0E0755E7E3 = scripts\mp\gameobjects::getownerteam();
  otherteam = scripts\mp\utility\game::getotherteam(team)[0];
  self.capturetime = gettime();
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  thread _id_6663215F917210AE::updateflagstate(team, 0, team);
  _id_6663215F917210AE::setflagcaptured(team, _id_8A04AA0E0755E7E3, _id_22282E7D48CA3400);
  level.usestartspawns = 0;

  if(_id_8A04AA0E0755E7E3 == "neutral") {
    _id_BDE78B1B09AE7F75 = _id_6663215F917210AE::getteamflagcount(team);

    if(_id_BDE78B1B09AE7F75 < level.objectives.size) {
      if(_id_BDE78B1B09AE7F75 == 2 && level.numsiegeflags == 3) {
        scripts\mp\utility\dialog::statusdialog("friendly_captured_2", team);
        scripts\mp\utility\dialog::statusdialog("enemy_captured_2", otherteam, 1);
      } else {
        scripts\mp\utility\dialog::statusdialog("secured" + self.objectivekey, team);
        scripts\mp\utility\dialog::statusdialog("lost" + self.objectivekey, otherteam, 1);
      }
    }
  }

  if(_id_6663215F917210AE::getteamflagcount(team) == level.objectives.size)
    soundalias = "mp_dom_flag_captured_all";
  else
    soundalias = "mp_dom_flag_captured";

  thread scripts\mp\utility\print::printandsoundoneveryone(team, otherteam, undefined, undefined, soundalias, "mp_dom_flag_lost", _id_22282E7D48CA3400);
  thread giveflagcapturexp(self.touchlist[team], _id_8A04AA0E0755E7E3, _id_22282E7D48CA3400);
  self.firstcapture = 0;

  if(scripts\mp\utility\teams::isgameplayteam(team)) {
    if(level.teamdata[team]["aliveCount"] < level.teamdata[team]["players"].size) {
      foreach(player in level.teamdata[team]["players"])
      player playlocalsound("mp_bodycount_tick_positive");

      enemies = scripts\mp\utility\teams::getenemyplayers(team);

      foreach(player in enemies)
      player playlocalsound("mp_bodycount_tick_negative");
    }
  }

  thread checkshouldplaymusic(team);
}

onuseupdate(team, progress, _id_301D62DA1A0738F1, _id_4B22E50E504339FE) {
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(progress < 1.0 && !level.gameended && !istrue(self.captureblocked))
    play_dom_capture_sfx(progress, team);

  if(progress > 0.05 && _id_301D62DA1A0738F1 && !self.didstatusnotify) {
    if(ownerteam == "neutral") {
      scripts\mp\utility\dialog::statusdialog("securing" + self.objectivekey, team);
      self.prevownerteam = scripts\mp\utility\game::getotherteam(team)[0];
    } else {
      scripts\mp\utility\dialog::statusdialog("losing" + self.objectivekey, ownerteam, 1);
      scripts\mp\utility\dialog::statusdialog("securing" + self.objectivekey, team);
    }

    if(!isagent(_id_4B22E50E504339FE))
      _id_6663215F917210AE::updateflagcapturestate(team);

    scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosing, level.icontaking);
    self.didstatusnotify = 1;
  }

  level notify("flag_capturing", self);
}

checkshouldplaymusic(team) {
  _id_7122BDD2EBB697FA = 0;
  teamflags = getflagcount(team);

  if(level.numsiegeflags == 3) {
    if(teamflags == 2)
      _id_7122BDD2EBB697FA = 1;
  } else if(teamflags == 4)
    _id_7122BDD2EBB697FA = 1;

  if(_id_7122BDD2EBB697FA)
    thread scripts\mp\music_and_dialog::dominating_music(team);
}

play_dom_capture_sfx(progress, team) {
  if(!isDefined(self.lastsfxplayedtime))
    self.lastsfxplayedtime = gettime();

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    _id_C3DDFB0EAA8F761C = "";
    progress = int(floor(progress * 10));
    _id_C3DDFB0EAA8F761C = "mp_dom_capturing_tick_0" + progress;
    self.visuals[0] playsoundtoteam(_id_C3DDFB0EAA8F761C, team);
  }
}

onenduse(team, player, success) {
  self.didstatusnotify = 0;

  if(isPlayer(player))
    player setclientomnvar("ui_objective_pinned_text_param", 0);

  if(success)
    self.flagcapsuccess = 1;
  else {
    self.flagcapsuccess = 0;
    resumecountdowntimer();
  }

  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    _id_6663215F917210AE::updateflagstate("idle", 0);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    _id_6663215F917210AE::updateflagstate(ownerteam, 0);
  }

  if(!istrue(self.setblocking) && !istrue(self.stalemate))
    level.siegeflagcapturing = scripts\engine\utility::array_remove(level.siegeflagcapturing, self.objectivekey);

  thread waitthencheckendgame();
}

waitthencheckendgame() {
  waitframe();
  checkendgame();
}

oncontested() {
  if(!scripts\engine\utility::array_contains(level.siegeflagcapturing, self.objectivekey))
    level.siegeflagcapturing[level.siegeflagcapturing.size] = self.objectivekey;

  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontested);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  _id_6663215F917210AE::updateflagstate("contested", 0);

  if(level.rushtimerteam == self.ownerteam)
    resumecountdowntimer();
}

onuncontested(lastclaimteam) {
  ownerteam = scripts\mp\gameobjects::getownerteam();
  numtouching = scripts\mp\gameobjects::getnumtouchingforteam(ownerteam);
  _id_65218754A3CA92DB = scripts\mp\gameobjects::getnumtouchingexceptteam(ownerteam);

  if(numtouching && !_id_65218754A3CA92DB)
    level.siegeflagcapturing = scripts\engine\utility::array_remove(level.siegeflagcapturing, self.objectivekey);

  thread waitthencheckendgame();

  if(ownerteam == "neutral") {
    if(lastclaimteam != "none")
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, lastclaimteam);
    else
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  } else
    scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, scripts\mp\utility\game::getotherteam(ownerteam)[0]);

  if(lastclaimteam == "none" || ownerteam == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    self.didstatusnotify = 0;
  } else
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);

  _id_FF99447227B9FBAC = scripts\engine\utility::ter_op(ownerteam == "neutral", "idle", ownerteam);
  _id_6663215F917210AE::updateflagstate(_id_FF99447227B9FBAC, 0);
}

onunoccupied() {
  ownerteam = scripts\mp\gameobjects::getownerteam();
  level.siegeflagcapturing = scripts\engine\utility::array_remove(level.siegeflagcapturing, self.objectivekey);
  thread waitthencheckendgame();

  if(ownerteam == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    self.didstatusnotify = 0;
  } else
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
}

onpinnedstate(player) {
  if(self.ownerteam != "neutral" && self.numtouching[self.ownerteam] && !self.stalemate)
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
}

onunpinnedstate(player) {
  if(self.ownerteam != "neutral" && !self.numtouching[self.ownerteam] && !self.stalemate)
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);

  ownerteam = scripts\mp\gameobjects::getownerteam();
  numtouching = scripts\mp\gameobjects::getnumtouchingforteam(ownerteam);
  _id_65218754A3CA92DB = scripts\mp\gameobjects::getnumtouchingexceptteam(ownerteam);

  if(numtouching && !_id_65218754A3CA92DB)
    level.siegeflagcapturing = scripts\engine\utility::array_remove(level.siegeflagcapturing, self.objectivekey);

  thread waitthencheckendgame();
}

onstompeenemyprogressupdate(team) {
  ownerteam = scripts\mp\gameobjects::getownerteam();
  numtouching = scripts\mp\gameobjects::getnumtouchingforteam(ownerteam);
  _id_65218754A3CA92DB = scripts\mp\gameobjects::getnumtouchingexceptteam(ownerteam);

  if(numtouching && !_id_65218754A3CA92DB)
    level.siegeflagcapturing = scripts\engine\utility::array_remove(level.siegeflagcapturing, self.objectivekey);

  if(level.rushtimerteam == self.ownerteam)
    resumecountdowntimer();
  else
    resumecountdowntimer(1);
}

stompprogressreward(player) {
  player thread scripts\mp\rank::scoreeventpopup("stat_6FF0E80C570DACA1");
  player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2D96CED878338CD2");
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
}

ondeadevent(team) {
  if(scripts\mp\utility\game::gamehasstarted()) {
    if(team == "all")
      ontimelimit();
    else if(team == game["attackers"]) {
      if(level.rushtimer && getflagcount(team) == 2) {
        return;
      }
      setwinner(game["defenders"], tolower(game[game["attackers"]]) + "_eliminated");
    } else if(team == game["defenders"]) {
      if(level.rushtimer && getflagcount(team) == 2) {
        return;
      }
      setwinner(game["attackers"], tolower(game[game["defenders"]]) + "_eliminated");
    }
  }
}

ononeleftevent(team) {
  _id_B0DFD912BE32D040 = scripts\mp\utility\game::getlastlivingplayer(team);
  _id_B0DFD912BE32D040 thread givelastonteamwarning();
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  if(isDefined(self.wasflagspawned))
    self.wasflagspawned = undefined;

  if(!isPlayer(attacker) || attacker.team == self.team) {
    return;
  }
  if(!flagownersalive(self.team) && _id_6663215F917210AE::getteamflagcount(self.team) == 2)
    scripts\mp\utility\dialog::statusdialog("objs_capture", attacker.team, 1);

  _id_9FF9376383F4BC58 = 0;
  _id_8363BEB01B537D3E = 0;
  _id_88F4967A49A22ED7 = 0;
  victim = self;
  victimteam = victim.team;
  _id_F7DED1FDB02A123D = victim.origin;
  attackerteam = attacker.team;
  _id_86C1C8628B1D55F8 = attacker.origin;
  attackerisinflictor = 0;

  if(isDefined(einflictor)) {
    _id_86C1C8628B1D55F8 = einflictor.origin;
    attackerisinflictor = einflictor == attacker;
  }

  foreach(trigger in attacker.touchtriggers) {
    objective = undefined;

    foreach(obj in level.objectives) {
      if(obj.trigger == trigger) {
        objective = obj;
        break;
      }
    }

    if(!isDefined(objective)) {
      continue;
    }
    ownerteam = objective.ownerteam;

    if(attackerteam != ownerteam) {
      if(!_id_9FF9376383F4BC58)
        _id_9FF9376383F4BC58 = 1;

      continue;
    }
  }

  foreach(objective in level.objectives) {
    trigger = objective.trigger;
    ownerteam = objective.ownerteam;

    if(ownerteam == "neutral") {
      _id_31E1574AABDEFEAB = attacker istouching(trigger);
      _id_FD534BAA79DD395C = victim istouching(trigger);

      if(_id_31E1574AABDEFEAB || _id_FD534BAA79DD395C) {
        if(objective.claimteam == victimteam) {
          if(!_id_8363BEB01B537D3E) {
            if(_id_9FF9376383F4BC58)
              attacker thread scripts\mp\utility\points::_id_E3E3E81453FD788B("stat_470103FDE6A5E1AE");
            else {
              attacker thread scripts\mp\rank::scoreeventpopup("stat_E54C7B357A5A826C");
              attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_5A3B180273BE47B1");
            }

            _id_8363BEB01B537D3E = 1;
            thread scripts\common\utility::trycall(level.matchdata_logattackerkillevent, _id_61B5D0250B328F00, "assaulting");
            continue;
          }
        } else if(objective.claimteam == attackerteam) {
          if(!_id_88F4967A49A22ED7) {
            if(_id_9FF9376383F4BC58)
              attacker thread scripts\mp\utility\points::_id_E3E3E81453FD788B("stat_470103FDE6A5E1AE");
            else {
              attacker thread scripts\mp\rank::scoreeventpopup("stat_6FF0E80C570DACA1");
              attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2D96CED878338CD2");
            }

            _id_88F4967A49A22ED7 = 1;
            attacker scripts\mp\utility\stats::incpersstat("defends", 1);
            attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
            thread scripts\common\utility::trycall(level.matchdata_logattackerkillevent, _id_61B5D0250B328F00, "defending");
            continue;
          }
        }
      }
    } else if(ownerteam != attackerteam) {
      if(!_id_8363BEB01B537D3E) {
        _id_A3A2CE8B8E74EBEF = distsquaredcheck(trigger, _id_86C1C8628B1D55F8, _id_F7DED1FDB02A123D);

        if(_id_A3A2CE8B8E74EBEF) {
          if(_id_9FF9376383F4BC58)
            attacker thread scripts\mp\utility\points::_id_E3E3E81453FD788B("stat_470103FDE6A5E1AE");
          else {
            attacker thread scripts\mp\rank::scoreeventpopup("stat_E54C7B357A5A826C");
            attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_5A3B180273BE47B1");
          }

          _id_8363BEB01B537D3E = 1;
          thread scripts\common\utility::trycall(level.matchdata_logattackerkillevent, _id_61B5D0250B328F00, "assaulting");
          continue;
        }
      }
    } else if(!_id_88F4967A49A22ED7) {
      _id_F6A091229A5E7B04 = distsquaredcheck(trigger, _id_86C1C8628B1D55F8, _id_F7DED1FDB02A123D);

      if(_id_F6A091229A5E7B04) {
        if(_id_9FF9376383F4BC58)
          attacker thread scripts\mp\utility\points::_id_E3E3E81453FD788B("stat_470103FDE6A5E1AE");
        else {
          attacker thread scripts\mp\rank::scoreeventpopup("stat_6FF0E80C570DACA1");
          attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2D96CED878338CD2");
        }

        _id_88F4967A49A22ED7 = 1;
        attacker scripts\mp\utility\stats::incpersstat("defends", 1);
        attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
        thread scripts\common\utility::trycall(level.matchdata_logattackerkillevent, _id_61B5D0250B328F00, "defending");
        continue;
      }
    }
  }

  thread checkallowspectating();
}

distsquaredcheck(trigger, _id_86C1C8628B1D55F8, _id_F7DED1FDB02A123D) {
  _id_9AE8B00A8E8F64FA = distancesquared(trigger.origin, _id_86C1C8628B1D55F8);
  _id_1881A89C6F1E8775 = distancesquared(trigger.origin, _id_F7DED1FDB02A123D);

  if(_id_9AE8B00A8E8F64FA < 105625 || _id_1881A89C6F1E8775 < 105625) {
    if(!isDefined(trigger.modifieddefendcheck))
      return 1;
    else if(_id_86C1C8628B1D55F8[2] - trigger.origin[2] < 100 || _id_F7DED1FDB02A123D[2] - trigger.origin[2] < 100)
      return 1;
    else
      return 0;
  } else
    return 0;
}

givelastonteamwarning() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\mp\utility\player::waittillrecoveredhealth(3);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "stat_915F01BAA2419C9F");
  otherteam = scripts\mp\utility\game::getotherteam(self.pers["team"])[0];
  level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
  level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastenemyalive", self, otherteam);
  level notify("last_alive", self);
}

ontimelimit() {
  if(isDefined(level.siegegameinactive)) {
    level.forcedend = 1;
    thread scripts\mp\gamelogic::endgame("none", game["end_reason"]["siege_force_end"]);
    return;
  } else {
    _id_464C0E9847A1A49A = getflagcount("allies");
    _id_B96A5E9D06866903 = getflagcount("axis");

    if(_id_464C0E9847A1A49A > _id_B96A5E9D06866903)
      setwinner("allies", "siege_flag_win", "siege_flag_loss");
    else if(_id_B96A5E9D06866903 > _id_464C0E9847A1A49A)
      setwinner("axis", "siege_flag_win", "siege_flag_loss");
    else
      setwinner("tie", "cyber_tie");
  }
}

teamrespawn(team, _id_22282E7D48CA3400) {
  _id_0774C9CA5D1D6221 = scripts\mp\utility\teams::getteamdata(_id_22282E7D48CA3400.team, "teamCount");

  if(!isDefined(_id_22282E7D48CA3400.rescuedplayers))
    _id_22282E7D48CA3400.rescuedplayers = [];

  foreach(player in level.participants) {
    if(isDefined(player) && player.team == team && !scripts\mp\utility\player::isreallyalive(player) && !scripts\engine\utility::array_contains(scripts\mp\utility\teams::getfriendlyplayers(player.team, 1), player) && (!isDefined(player.waitingtoselectclass) || !player.waitingtoselectclass)) {
      if(isDefined(player.siegelatecomer) && player.siegelatecomer)
        player.siegelatecomer = 0;

      if(!istrue(player.pers["teamKillPunish"])) {
        if(istrue(player.wasflagspawned)) {
          continue;
        }
        player.wasflagspawned = 1;
        player thread scripts\mp\playerlogic::waittillcanspawnclient(0);
        player thread scripts\mp\rank::scoreeventpopup("stat_AB2FB342759B6ABC");
        level notify("sr_player_respawned", player);
        player scripts\mp\utility\dialog::leaderdialogonplayer("revived");
      }

      _id_22282E7D48CA3400.rescuedplayers[player.guid] = 1;
    }
  }

  self.playersrevived = _id_22282E7D48CA3400.rescuedplayers.size;
}

notifyplayers(notifystring) {
  foreach(player in level.players)
  player thread scripts\mp\hud_message::showsplash(notifystring);

  level notify("match_ending_soon", "time");
  level notify(notifystring);
}

giveflagcapturexp(touchlist, _id_8A04AA0E0755E7E3, _id_22282E7D48CA3400) {
  level endon("game_ended");
  _id_0666D6B1872868D7 = _id_22282E7D48CA3400;

  if(isDefined(_id_0666D6B1872868D7.owner))
    _id_0666D6B1872868D7 = _id_0666D6B1872868D7.owner;

  level.lastcaptime = gettime();

  if(isPlayer(_id_0666D6B1872868D7)) {
    level thread scripts\mp\hud_util::teamplayercardsplash("callout_securedposition" + self.objectivekey, _id_0666D6B1872868D7);
    _id_7E2C53B0BCF117D9 = spawnStruct();
    _id_7E2C53B0BCF117D9.player = _id_0666D6B1872868D7;
    _id_7E2C53B0BCF117D9.eventname = "capture";
    _id_7E2C53B0BCF117D9.position = _id_0666D6B1872868D7.origin;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);
  }

  _id_59DB5D0F4E3000A7 = getarraykeys(touchlist);

  for(index = 0; index < _id_59DB5D0F4E3000A7.size; index++) {
    player = touchlist[_id_59DB5D0F4E3000A7[index]].player;

    if(isDefined(player.owner))
      player = player.owner;

    if(!isPlayer(player)) {
      continue;
    }
    player thread updatecpm();

    if(player.cpm > 3) {
      _id_492CB44147FCF2CE = 0;
      _id_BB8C393C8A630338 = 0;
    } else if(player.numcaps > 5) {
      _id_492CB44147FCF2CE = 125;
      _id_BB8C393C8A630338 = 50;
    } else if(self.objectivekey == "_b" || _id_8A04AA0E0755E7E3 != "neutral" || self.playersrevived > 0) {
      _id_492CB44147FCF2CE = undefined;
      _id_BB8C393C8A630338 = undefined;
    } else {
      _id_492CB44147FCF2CE = 125;
      _id_BB8C393C8A630338 = 50;
    }

    player thread scripts\mp\rank::scoreeventpopup("stat_F4CD65EB4AA3FD61");
    player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_32FFD90C03EC37C6", undefined, _id_BB8C393C8A630338, _id_492CB44147FCF2CE);
    player scripts\mp\utility\stats::incpersstat("captures", 1);
    player scripts\mp\persistence::statsetchild("round", "captures", player.pers["captures"]);
    player scripts\mp\utility\stats::setextrascore0(player.pers["captures"]);
    player scripts\mp\utility\stats::incpersstat("rescues", self.playersrevived);
    player scripts\mp\persistence::statsetchild("round", "rescues", player.pers["rescues"]);
    player scripts\mp\utility\stats::setextrascore1(player.pers["rescues"]);
    wait 0.05;
  }

  self.playersrevived = 0;
}

getcapxpscale() {
  if(self.cpm < 4)
    return 1;
  else
    return 0.25;
}

updatecpm() {
  if(!isDefined(self.cpm)) {
    self.numcaps = 0;
    self.cpm = 0;
  }

  self.numcaps++;

  if(scripts\mp\utility\game::getminutespassed() < 1) {
    return;
  }
  self.cpm = self.numcaps / scripts\mp\utility\game::getminutespassed();
}

checkendgame() {
  _id_464C0E9847A1A49A = getflagcount("allies");
  _id_B96A5E9D06866903 = getflagcount("axis");

  if(_id_464C0E9847A1A49A == level.numsiegeflags)
    setwinner("allies", "siege_allflags_win", "siege_allflags_loss");
  else if(_id_B96A5E9D06866903 == level.numsiegeflags)
    setwinner("axis", "siege_allflags_win", "siege_allflags_loss");
}

runobjectives(_id_AA030029A5B16AE5) {
  level.axisspawnareas = [level.axishqname];
  level.alliesspawnareas = [level.allieshqname];
  level.allfobs = [];

  foreach(fob in level.gw_objstruct.startingfobs_axis) {
    _id_DDCA7869B65236B6 = runobjflag(fob.trigger, "axis");
    level.allfobs[level.allfobs.size] = fob;
    level.axisspawnareas[level.axisspawnareas.size] = fob.name;

    if(isDefined(level.spawnselectionlocations[fob.name]["axis"].anchorentity))
      level.spawnselectionlocations[fob.name]["axis"].anchorentity.origin = fob.trigger.origin + (0, 0, 100);
  }

  foreach(fob in level.gw_objstruct.startingfobs_allies) {
    _id_DDCA7869B65236B6 = runobjflag(fob.trigger, "allies");
    level.allfobs[level.allfobs.size] = fob;
    level.alliesspawnareas[level.alliesspawnareas.size] = fob.name;

    if(isDefined(level.spawnselectionlocations[fob.name]["allies"].anchorentity))
      level.spawnselectionlocations[fob.name]["allies"].anchorentity.origin = fob.trigger.origin + (0, 0, 100);
  }

  foreach(fob in level.gw_objstruct.startingfobs_neutral) {
    if(level.numsiegeflags == 3) {
      if(level.mapname == "mp_downtown_gw") {
        if(fob.trigger.objkey == "_a" || fob.trigger.objkey == "_e")
          continue;
        else
          remapobjkeysandscriptlabels(fob.trigger);
      } else if(level.mapname == "mp_aniyah") {
        if(fob.trigger.objkey == "_b" || fob.trigger.objkey == "_d")
          continue;
        else
          remapobjkeysandscriptlabels(fob.trigger);
      } else if(level.mapname == "mp_farms2_gw") {
        if(fob.trigger.objkey == "_b" || fob.trigger.objkey == "_d")
          continue;
        else
          remapobjkeysandscriptlabels(fob.trigger);
      } else if(level.mapname == "mp_promenade_gw") {
        if(fob.trigger.objkey == "_a" || fob.trigger.objkey == "_e")
          continue;
        else
          remapobjkeysandscriptlabels(fob.trigger);
      } else if(level.mapname == "mp_riverside_gw") {
        if(fob.trigger.objkey == "_b" || fob.trigger.objkey == "_d")
          continue;
        else
          remapobjkeysandscriptlabels(fob.trigger);
      } else if(fob.trigger.objkey == "_a" || fob.trigger.objkey == "_e")
        continue;
      else
        remapobjkeysandscriptlabels(fob.trigger);
    }

    _id_DDCA7869B65236B6 = runobjflag(fob.trigger, "neutral");
    level.allfobs[level.allfobs.size] = fob;
  }

  _id_7FC4B3DB1868930F = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_axis_start");
  _id_99A20728731AC0B0 = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_allies_start");
  level.startpos["allies"] = _id_99A20728731AC0B0[0].origin;
  level.startpos["axis"] = _id_7FC4B3DB1868930F[0].origin;

  foreach(fob in level.allfobs) {
    _id_3C2389BA69E5822B = _id_6663215F917210AE::getreservedobjid(fob.trigger.gameobject.objectivekey);
    fob.trigger.gameobject scripts\mp\gameobjects::requestid(1, 1, _id_3C2389BA69E5822B);
    fob.trigger.gameobject.onuse = ::onuse;
    fob.trigger.gameobject.onbeginuse = ::onbeginuse;
    fob.trigger.gameobject.onuseupdate = ::onuseupdate;
    fob.trigger.gameobject.onenduse = ::onenduse;
    fob.trigger.gameobject.oncontested = ::oncontested;
    fob.trigger.gameobject.onuncontested = ::onuncontested;
    fob.trigger.gameobject.onunoccupied = ::onunoccupied;
    fob.trigger.gameobject.onpinnedstate = ::onpinnedstate;
    fob.trigger.gameobject.onunpinnedstate = ::onunpinnedstate;
    fob.trigger.gameobject.stompeenemyprogressupdate = ::onstompeenemyprogressupdate;
    fob.trigger.gameobject.stompprogressreward = ::stompprogressreward;
    fob.trigger.gameobject scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_target");
    fob.trigger.gameobject scripts\mp\gameobjects::setvisibleteam("any");
    fob.trigger.gameobject _id_6663215F917210AE::domflag_setneutral();
    level.objectives[fob.trigger.gameobject.objectivekey] = fob.trigger.gameobject;
  }

  level.bestspawnflag = [];
  level.bestspawnflag["allies"] = _id_6663215F917210AE::getunownedflagneareststart("allies", undefined);
  level.bestspawnflag["axis"] = _id_6663215F917210AE::getunownedflagneareststart("axis", level.bestspawnflag["allies"]);

  if(level.precappoints)
    _id_6663215F917210AE::precap(level.numsiegeflags == 5);

  _id_2DC3A143158CEC7C::flagsetup();
  level thread objective_manageobjectivesintrovisibility();
  level thread _id_3BA4F32E41F63B36::allowobjectiveuseaftermatchstart();
}

objective_manageobjectivesintrovisibility() {
  wait 1;

  foreach(fob in level.allfobs)
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(fob.trigger.gameobject.objidnum);

  while(!scripts\mp\flags::gameflag("prematch_done"))
    waitframe();

  foreach(fob in level.allfobs)
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(fob.trigger.gameobject.objidnum);
}

remapobjkeysandscriptlabels(objective) {
  if(level.mapname == "mp_downtown_gw") {
    if(objective.objkey == "_b" && !isDefined(objective.oldkey)) {
      objective.oldkey = "_a";
      objective.objkey = "_a";
      objective.script_label = objective.objkey;
    } else if(objective.objkey == "_c" && !isDefined(objective.oldkey)) {
      objective.oldkey = "_c";
      objective.objkey = "_b";
      objective.script_label = objective.objkey;
    } else if(objective.objkey == "_d" && !isDefined(objective.oldkey)) {
      objective.oldkey = "_d";
      objective.objkey = "_c";
      objective.script_label = objective.objkey;
    }
  } else if(level.mapname == "mp_boneyard_gw") {
    if(objective.objkey == "_b" && !isDefined(objective.oldkey)) {
      objective.oldkey = "_b";
      objective.objkey = "_a";
      objective.script_label = objective.objkey;
    } else if(objective.objkey == "_d" && !isDefined(objective.oldkey)) {
      objective.oldkey = "_d";
      objective.objkey = "_b";
      objective.script_label = objective.objkey;
    } else if(objective.objkey == "_c" && !isDefined(objective.oldkey)) {
      objective.oldkey = "_c";
      objective.objkey = "_c";
      objective.script_label = objective.objkey;
    }
  } else if(level.mapname == "mp_aniyah") {
    if(objective.objkey == "_a" && !isDefined(objective.oldkey)) {
      objective.oldkey = "_a";
      objective.objkey = "_a";
      objective.script_label = objective.objkey;
    } else if(objective.objkey == "_c" && !isDefined(objective.oldkey)) {
      objective.oldkey = "_c";
      objective.objkey = "_b";
      objective.script_label = objective.objkey;
    } else if(objective.objkey == "_e" && !isDefined(objective.oldkey)) {
      objective.oldkey = "_e";
      objective.objkey = "_c";
      objective.script_label = objective.objkey;
    }
  } else if(level.mapname == "mp_promenade_gw") {
    if(objective.objkey == "_b" && !isDefined(objective.oldkey)) {
      objective.oldkey = "_b";
      objective.objkey = "_a";
      objective.script_label = objective.objkey;
    } else if(objective.objkey == "_c" && !isDefined(objective.oldkey)) {
      objective.oldkey = "_c";
      objective.objkey = "_b";
      objective.script_label = objective.objkey;
    } else if(objective.objkey == "_d" && !isDefined(objective.oldkey)) {
      objective.oldkey = "_e";
      objective.objkey = "_c";
      objective.script_label = objective.objkey;
    }
  } else if(level.mapname == "mp_farms2_gw") {
    if(objective.objkey == "_a" && !isDefined(objective.oldkey)) {
      objective.oldkey = "_a";
      objective.objkey = "_a";
      objective.script_label = objective.objkey;
    } else if(objective.objkey == "_c" && !isDefined(objective.oldkey)) {
      objective.oldkey = "_c";
      objective.objkey = "_b";
      objective.script_label = objective.objkey;
    } else if(objective.objkey == "_e" && !isDefined(objective.oldkey)) {
      objective.oldkey = "_e";
      objective.objkey = "_c";
      objective.script_label = objective.objkey;
    }
  } else if(level.mapname == "mp_riverside_gw") {
    if(objective.objkey == "_a" && !isDefined(objective.oldkey)) {
      objective.oldkey = "_a";
      objective.objkey = "_a";
      objective.script_label = objective.objkey;
    } else if(objective.objkey == "_c" && !isDefined(objective.oldkey)) {
      objective.oldkey = "_c";
      objective.objkey = "_b";
      objective.script_label = objective.objkey;
    } else if(objective.objkey == "_e" && !isDefined(objective.oldkey)) {
      objective.oldkey = "_e";
      objective.objkey = "_c";
      objective.script_label = objective.objkey;
    }
  } else if(objective.objkey == "_b" && !isDefined(objective.oldkey)) {
    objective.oldkey = "_b";
    objective.objkey = "_a";
    objective.script_label = objective.objkey;
  } else if(objective.objkey == "_c" && !isDefined(objective.oldkey)) {
    objective.oldkey = "_c";
    objective.objkey = "_b";
    objective.script_label = objective.objkey;
  } else if(objective.objkey == "_d" && !isDefined(objective.oldkey)) {
    objective.oldkey = "_d";
    objective.objkey = "_c";
    objective.script_label = objective.objkey;
  }
}

runobjflag(objective, _id_35B9448411944BDC) {
  level endon("game_ended");
  objective.script_label = objective.objkey;
  domflag = _id_6663215F917210AE::setupobjective(objective, undefined, 1);
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

manageprematchfade(delay_time, _id_C82EABB722C361A7) {
  self endon("disconnect");
  _id_AD4DD16F29E24B77 = 0.0;
  _id_DFAB0807D83A77FE = 0.5;
  thread scripts\mp\playerlogic::managerespawnfade(_id_AD4DD16F29E24B77, _id_DFAB0807D83A77FE);
}