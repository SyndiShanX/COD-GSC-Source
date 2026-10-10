/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\siege.gsc
***********************************************/

#using script_4a6760982b403bad;
#using scripts\common\utility;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\arm;
#using scripts\mp\gametypes\arm_vehicles;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\dom;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\music_and_dialog;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;
#using scripts\mp\spawnfactor;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\spectating;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#namespace siege;

function main() {
  if(getDvar(@ "g_mapname") == "mp_background") {
    return;
  }

  level.isgroundwarsiege = 0;
  matchmakingmatch = getdvarint(@ "onlinegame") && !getdvarint(@ "xblive_privatematch");

  if(matchmakingmatch) {
    level.isgroundwarsiege = getdvarint(@ "scr_siege_groundwarsiege", 0);
  }

  level.isgroundwarsiege = getdvarint(@ "scr_siege_groundwarsiege", 0);

  level.allowmodestructs = [];

  if(level.isgroundwarsiege) {
    level.allowmodestructs[level.allowmodestructs.size] = "arm";
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  allowed[0] = getgametype();
  allowed[1] = "dom";

  if(istrue(level.isgroundwarsiege)) {
    allowed[allowed.size] = "arm";
  }

  scripts\mp\gameobjects::main(allowed);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread reinitializematchrulesonmigration();
  } else {
    registerroundswitchdvar(getgametype(), 3, 0, 12);
    registertimelimitdvar(getgametype(), 300);
    registerscorelimitdvar(getgametype(), 1);
    registerroundlimitdvar(getgametype(), 0);
    registerwinlimitdvar(getgametype(), 4);
    registernumlivesdvar(getgametype(), 1);
    registerhalftimedvar(getgametype(), 0);
    registerwinbytwoenableddvar(getgametype(), 1);
    registerwinbytwomaxroundsdvar(getgametype(), 4);
  }

  updategametypedvars();
  level.objectivebased = 1;
  level.teambased = 1;
  level.nobuddyspawns = 1;
  level.gamehasstarted = 0;
  level.onstartgametype = &onstartgametype;
  level.onplayerconnect = &onplayerconnect;
  level.onplayerdisconnect = &onplayerdisconnect;
  level.onplayerjointeam = &onplayerjointeam;
  level.getspawnpoint = &getspawnpoint;
  level.modeonspawnplayer = &onspawnplayer;
  level.onplayerkilled = &onplayerkilled;
  level.ondeadevent = &ondeadevent;
  level.ononeleftevent = &ononeleftevent;
  level.ontimelimit = &ontimelimit;
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
    level.numnonrallyvehicles = getdvarint(@ "hash_6695d60ef1e8627d", 25);
    level.skipplaybodycountsound = 1;
    level.disablespawncamera = 1;
    mapname = scripts\cp_mp\utility\game_utility::getmapname();

    switch (mapname) {
      case #"hash_12f3765ef24b4037":
      case #"hash_1bc93b88575e82eb":
      case #"hash_32eaa112f8caa7e4":
      case #"hash_3a8b050ff58578ad":
      case #"hash_50de71be6e7469ff":
      case #"hash_7a28db3c5928c489":
      case #"hash_863773b8960b3944":
      case #"hash_924a3fbe9fbe15c6":
      case #"hash_e4ca6b73b5022b26":
        scripts\cp_mp\parachute::initparachutedvars();
        break;
      default:
        break;
    }

    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      switch (mapname) {
        case #"hash_32eaa112f8caa7e4":
          setDvar(@ "hash_6beec004cdf37c0", 6);
          break;
        case #"hash_7a28db3c5928c489":
          setDvar(@ "hash_6beec004cdf37c0", 5);
          break;
        case #"hash_50de71be6e7469ff":
        case #"hash_863773b8960b3944":
          setDvar(@ "hash_6beec004cdf37c0", 9);
          break;
        case #"hash_12f3765ef24b4037":
          setDvar(@ "hash_6beec004cdf37c0", 3);
          break;
        case #"hash_924a3fbe9fbe15c6":
          setDvar(@ "hash_6beec004cdf37c0", 4);
          break;
        case #"hash_a8b272dba33a4aed":
          setDvar(@ "hash_6beec004cdf37c0", 17);
          break;
        case #"hash_1bc93b88575e82eb":
          setDvar(@ "hash_6beec004cdf37c0", 18);
          break;
        case #"hash_e4ca6b73b5022b26":
          setDvar(@ "hash_6beec004cdf37c0", 10);
          break;
        case #"hash_3a8b050ff58578ad":
          setDvar(@ "hash_6beec004cdf37c0", 19);
          break;
        default:
          setDvar(@ "hash_6beec004cdf37c0", 0);
          break;
      }
    }
  }

  game["canScoreOnTie"] = 1;

  if(scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
    game["dialog"]["gametype"] = "iw9_mpsg_mode_uktl_snt1";
  } else {
    game["dialog"]["gametype"] = "gametype_siege";
  }

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

function initializematchrules() {
  setcommonrulesfrommatchrulesdata();
  setdynamicdvar(@ "hash_41bd47d6d0def56", getmatchrulesdata("siegeData", "rushTimer"));
  setdynamicdvar(@ "hash_24a372f8e55b2fea", getmatchrulesdata("siegeData", "rushTimerAmount"));
  setdynamicdvar(@ "hash_9e119c9c57105ac5", getmatchrulesdata("siegeData", "sharedRushTimer"));
  setdynamicdvar(@ "hash_132b182e76e85c9b", getmatchrulesdata("siegeData", "preCapPoints"));
  setdynamicdvar(@ "hash_18590465135e9503", getmatchrulesdata("siegeData", "capRate"));
  setdynamicdvar(@ "hash_462e8dc6c1e380cc", getmatchrulesdata("siegeData", "objScalar"));
  setdynamicdvar(@ "hash_e2d968dab42f65ee", getmatchrulesdata("siegeData", "holdAllTimer"));
  setdynamicdvar(@ "hash_22f872fa5a214897", 0);
  registerhalftimedvar("siege", 0);
}

function seticonnames() {
  level.iconneutral = "waypoint_captureneutral";
  level.iconcapture = "waypoint_capture";
  level.icondefend = "waypoint_defend";
  level.icondefending = "waypoint_defending";
  level.iconcontested = "waypoint_contested";
  level.icontaking = "waypoint_taking";
  level.iconlosing = "waypoint_losing";
}

function onstartgametype() {
  seticonnames();

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    oldattackers = game["attackers"];
    olddefenders = game["defenders"];
    game["attackers"] = olddefenders;
    game["defenders"] = oldattackers;
  }

  foreach(entry in level.teamnamelist) {
    setobjectivetext(entry, &"OBJECTIVES/DOM");

    if(level.splitscreen) {
      setobjectivescoretext(entry, &"OBJECTIVES/DOM");
    } else {
      setobjectivescoretext(entry, &"OBJECTIVES/DOM_SCORE");
    }

    setobjectivehinttext(entry, &"OBJECTIVES/DOM_HINT");
  }

  thread waittooverridegraceperiod();

  if(level.isgroundwarsiege) {
    thread adjustroundendtimer();
    scripts\mp\gametypes\arm::initspawns(isDefined(game["roundsPlayed"]) && game["roundsPlayed"] != 0);
    level thread scripts\mp\gametypes\arm::setupwaypointicons();
    scripts\mp\gametypes\arm::debug_setupmatchdata();
    scripts\mp\gametypes\arm::setuphqs();
    scripts\mp\gametypes\arm::calculatehqmidpoint();
    level.numsiegeflags = getdvarint(@ "hash_9eee1e1f8390ac94", 3);
    setomnvar("ui_num_dom_flags", level.numsiegeflags);
    scripts\mp\gametypes\arm::setupobjectives();
    level thread runobjectives();
    thread scripts\mp\gametypes\arm_vehicles::init_groundwarvehicles();
    thread initvehicles();
    scripts\mp\gametypes\arm::emergency_cleanupents();
  } else {
    initspawns();
    thread domflags();
  }

  thread watchflagtimerpause();
  thread watchgamestart();

  if(matchmakinggame()) {
    thread watchgameinactive();
  }

  thread function_7fd73dbe340f511d();
  thread removedompoint();
  thread placedompoint();
}

function vehiclespawn_getspawndata(loc) {
  spawndata = spawnStruct();
  spawndata.origin = loc.origin;
  spawndata.angles = loc.angles;
  spawndata.spawntype = "GAME_MODE";
  spawndata.showheadicon = 1;
  return spawndata;
}

function registervehicletype(refname, spawnvehiclecallback) {
  assert(isDefined(refname));
  vehicleinfo = spawnStruct();
  vehicleinfo.refname = refname;
  vehicleinfo.spawncallback = spawnvehiclecallback;
  vehicleinfo.vehiclespawns = function_b08e7e3a0b14f76f(refname);
  assert(isDefined(vehicleinfo.vehiclespawns));
  level.vehicleinfo[refname] = vehicleinfo;
}

function initvehicles() {
  level.numhqtanks_axis = 0;
  level.numhqtanks_allies = 0;

  if(!isDefined(level.vehicleinfo)) {
    level.vehicleinfo = [];
  }

  registervehicletype("little_bird", &vehiclespawn_littlebird);
  registervehicletype("atv", &vehiclespawn_atv);
  registervehicletype("tac_rover", &vehiclespawn_tacrover);
  level.vehiclespawnlocs = [];

  foreach(vehicleinfo in level.vehicleinfo) {
    switch (vehicleinfo.refname) {
      case #"hash_9d4e22a00fc630b5":
        vehicleinfo.vehiclespawns = getvehiclespawns("little_bird", "veh9_mil_air_heli_medium_physics_mp");
        break;
      case #"hash_c93466c10cc10ba":
        vehicleinfo.vehiclespawns = getvehiclespawns("atv", "veh9_mil_lnd_atv_physics_mp");
        break;
      case #"hash_21e1eaa9138f512c":
        vehicleinfo.vehiclespawns = getvehiclespawns("tac_rover", "tromeo_physics_mp");
        break;
    }

    foreach(spawnpoint in vehicleinfo.vehiclespawns) {
      index = level.vehiclespawnlocs.size;
      level.vehiclespawnlocs[index] = spawnpoint;
      level.vehiclespawnlocs[index].refname = vehicleinfo.refname;
    }
  }

  if(false) {
    foreach(loc in level.vehiclespawnlocs) {
      thread drawline(loc.origin, loc.origin + (0, 0, 1500), 1000, (1, 0, 0));
    }
  }

  level.vehiclespawnlocs = array_randomize(level.vehiclespawnlocs);
  numtospawn = level.numnonrallyvehicles;

  if(!isDefined(level.numnonrallyvehicles)) {
    numtospawn = 25;
  }

  if(false) {
    for(i = 0; i < numtospawn; i++) {
      loc = level.vehiclespawnlocs[i];
      thread drawline(loc.origin + (0, 0, 1500), loc.origin + (0, 0, 2500), 1000, (0, 1, 0));
    }
  }

  for(i = 0; i < numtospawn; i++) {
    loc = level.vehiclespawnlocs[i];

    if(isDefined(loc)) {
      vehicleinfo = level.vehicleinfo[loc.refname];
      [[vehicleinfo.spawncallback]](loc);
    }
  }
}

function getvehiclespawns(vehicleref, vehicletype) {
  spawns = [];
  mapname = scripts\cp_mp\utility\game_utility::getmapname();
  atvoriginsarray = [];
  atvanglesarray = [];
  var_380b98510b5d0765 = [];
  var_fb7e5f19efd9d046 = [];

  switch (mapname) {
    case #"hash_32eaa112f8caa7e4":
      if(vehicleref == "atv") {
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
      } else if(vehicleref == "tac_rover") {
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (20120.2, -3287.71, -456);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (21339.9, -4787.55, -450.176);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 345, 0);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (357.831, 255.032, -1.25312);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (17449, -22190.1, -208.116);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (16651.1, -22178.2, -207.908);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 60, 0);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 60, 0);
      }

      break;
    case #"hash_7a28db3c5928c489":
      if(vehicleref == "atv") {
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
      } else if(vehicleref == "tac_rover") {
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (26310.8, 30168.4, 659.426);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (26954, 29794.1, 651.013);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (358.195, 118.006, -2.71651);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 89.9998, 0);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (38573.2, 47052.8, 950.28);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (39660.3, 45949.9, 952.362);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (359.669, 194.507, -0.439539);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (11.7511, 162.518, 0.102679);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (33138.2, 41498.6, 707.349);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (357.81, 284.768, 1.14713);
      }

      break;
    case #"hash_50de71be6e7469ff":
    case #"hash_863773b8960b3944":
      if(vehicleref == "atv") {
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
      } else if(vehicleref == "tac_rover") {
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (47872.6, -22645.4, -385.49);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (48501.7, -22505, -382.243);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (1.68464, 109.9, -3.26246);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (359.897, 89.9842, 8.71393);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (46034.5, -59.925, -29.8834);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (47108.8, -498.535, -35.0573);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (2.33612, 243.444, -0.141863);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (355.135, 243.112, 2.65064);
      }

      break;
    case #"hash_12f3765ef24b4037":
      if(vehicleref == "atv") {
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
      } else if(vehicleref == "tac_rover") {
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (31412.5, -34658.3, -564.862);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (31042.3, -16171.6, -565.383);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 105, 0);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 75, 0);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (36937.6, -15836.1, -559.8);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (37369.7, -16171.6, -562);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 270, 0);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 270, 0);
      }

      break;
    case #"hash_924a3fbe9fbe15c6":
      if(vehicleref == "atv") {
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
      } else if(vehicleref == "tac_rover") {
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-28683.3, -16741.2, -249.16);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-29128.7, -16577.6, -229.266);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (359.734, 90.0021, -0.454);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (353.195, 90.3463, -3.01942);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-27985.4, -3613.97, -315.978);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-28449.8, -3645.92, -312.247);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 270.003, 5.684);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 270.004, -3.208);
      }

      break;
    case #"hash_a8b272dba33a4aed":
      break;
    case #"hash_1bc93b88575e82eb":
      if(vehicleref == "atv") {
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
      } else if(vehicleref == "tac_rover") {
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-10912.6, -20079.6, -367);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-10108.5, -21861.4, -287.271);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 196.996, 0);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (7.93172, 180.719, 4.15911);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-22036.5, -25881.6, -147.198);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-21144.5, -27447.1, -151.145);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 345, 0);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 30, 0);
      }

      break;
    case #"hash_e4ca6b73b5022b26":
      if(vehicleref == "atv") {
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
      } else if(vehicleref == "tac_rover") {
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-3520, 17805, -262);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-3892, 18566, -262);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 165, 0);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 194, 0);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-29131, 13010, -244);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-28676, 13724, -518);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 0, 0);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 355, 0);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-19622, 17422, 54);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 357, 0);
      }

      break;
    case #"hash_3a8b050ff58578ad":
      if(vehicleref == "atv") {
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
      } else if(vehicleref == "tac_rover") {
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (4157, 26465, 65);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (4628, 26545, 63);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 143, 0);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 63, 0);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-7337, 32683, -77);
        var_380b98510b5d0765[var_380b98510b5d0765.size] = (-6671, 32948, -67);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 320, 0);
        var_fb7e5f19efd9d046[var_fb7e5f19efd9d046.size] = (0, 36, 0);
      }

      break;
    default:
      break;
  }

  level.atvoriginsarray = atvoriginsarray;
  level.atvanglesarray = atvanglesarray;

  if(vehicleref == "atv") {
    for(i = 0; i < atvoriginsarray.size; i++) {
      if(i <= atvoriginsarray.size - 1) {
        atvorigin = atvoriginsarray[i];
        atvangles = atvanglesarray[i];
        vehicle = spawnStruct();
        vehicle.origin = atvorigin;
        vehicle.angles = atvangles;
        vehicle.targetname = vehicleref;
        vehicle.vehicletype = vehicletype;
        spawns[spawns.size] = vehicle;
      }
    }
  } else if(vehicleref == "tac_rover") {
    for(i = 0; i < var_380b98510b5d0765.size; i++) {
      if(i <= var_380b98510b5d0765.size - 1) {
        var_d82a9436eee389cb = var_380b98510b5d0765[i];
        var_17085fd4c01a3645 = var_fb7e5f19efd9d046[i];
        vehicle = spawnStruct();
        vehicle.origin = var_d82a9436eee389cb;
        vehicle.angles = var_17085fd4c01a3645;
        vehicle.targetname = vehicleref;
        vehicle.vehicletype = vehicletype;
        spawns[spawns.size] = vehicle;
      }
    }
  }

  dvarstring = hashcat(@ "hash_ad95d7262a11119e", vehicleref);

  for(index = 0; true; index++) {
    origindvarstring = hashcat(dvarstring, "_origin_", index);
    angledvarstring = hashcat(dvarstring, "_angles_", index);
    defaultorigin = (0, 0, 0);
    origin = getdvarvector(origindvarstring, defaultorigin);

    if(origin == (0, 0, 0)) {
      break;
    }

    vehicle = spawnStruct();
    vehicle.origin = origin;
    var_7224bacab3f8ee26 = (0, 0, 0);
    vehicle.angles = getdvarvector(angledvarstring, var_7224bacab3f8ee26);
    vehicle.targetname = vehicleref;
    vehicle.vehicletype = vehicletype;
    spawns[spawns.size] = vehicle;
  }

  return spawns;
}

function vehiclespawn_littlebird(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("little_bird", spawndata, faildata);
}

function vehiclespawn_atv(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("atv", spawndata, faildata);
}

function vehiclespawn_tacrover(loc, faildata) {
  if(!isDefined(loc.angles)) {
    loc.angles = (0, randomfloat(360), 0);
  }

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("tac_rover", spawndata, faildata);
}

function filtervehiclespawnstructs(structs) {
  filtered = [];

  if(getdvarint(@ "scr_brtdm_disable_radiant_vehicles", level.brtdm_config.locale_defaults["scr_brtdm_disable_radiant_vehicles"]) == 1) {
    return filtered;
  }

  foreach(struct in structs) {
    if(distance2dsquared(struct.origin, level.brtdm_config.circlecenter) < level.brtdm_config.circleradius * level.brtdm_config.circleradius) {
      filtered[filtered.size] = struct;
    }
  }

  return filtered;
}

function updategametypedvars() {
  updatecommongametypedvars();
  level.rushtimer = dvarintvalue("rushTimer", 1, 0, 1);
  level.rushtimeramount = dvarfloatvalue("rushTimerAmount", 45, 30, 120);
  level.sharedrushtimer = dvarfloatvalue("sharedRushTimer", 0, 0, 1);
  level.precappoints = dvarintvalue("preCapPoints", 0, 0, 1);
  level.caprate = dvarfloatvalue("capRate", 7.5, 1, 60);
  level.objectivescaler = dvarfloatvalue("objScalar", 2, 1, 10);
  level.holdallflagstimer = dvarfloatvalue("holdAllTimer", 7.5, 0, 60);
}

function adjustroundendtimer() {
  wait 1;
  level.roundenddelay = 8;
}

function waittooverridegraceperiod() {
  scripts\mp\flags::gameflagwait("prematch_done");

  if(!level.isgroundwarsiege) {
    level.overrideingraceperiod = 1;
  }
}

function initspawns() {
  level.spawnmins = (2.14748e+09, 2.14748e+09, 2.14748e+09);
  level.spawnmaxs = (-2147483647, -2147483647, -2147483647);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_dom_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_dom_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dom_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dom_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dom_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dom_spawn_secondary", 1, 1);
  spawns = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn");
  spawnssecondary = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("dom", spawns);
  scripts\mp\spawnlogic::registerspawnset("dom_fallback", spawnssecondary);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function getspawnpoint() {
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
      spectatingteammate = self getspectatingplayer();

      if(isDefined(spectatingteammate) && isDefined(self.sessionsquadid) && self.team == spectatingteammate.team && self.sessionsquadid == spectatingteammate.sessionsquadid) {
        spawnpoint = scripts\mp\spawnscoring::findteammatebuddyspawn(spectatingteammate);
      }
    }

    return spawnpoint;
  }

  spawnteam = self.pers["team"];
  otherteam = getotherteam(spawnteam)[0];

  if(level.usestartspawns) {
    if(function_bff229a11ecd1e34()) {
      scripts\mp\spawnlogic::setactivespawnlogic(#"start");
    } else {
      scripts\mp\spawnlogic::setactivespawnlogic("StartSpawn", "Crit_Default");
    }

    if(game["switchedsides"]) {
      spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_" + otherteam + "_start");
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn(spawnpoints);
    } else {
      spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_" + spawnteam + "_start");
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn(spawnpoints);
    }
  } else {
    if(function_bff229a11ecd1e34()) {
      scripts\mp\spawnlogic::setactivespawnlogic(#"default");
    } else {
      scripts\mp\spawnlogic::setactivespawnlogic("Domination", "Crit_Default");
    }

    teamdompoints = getteamdompoints(spawnteam);
    enemyteam = getotherteam(spawnteam)[0];
    var_db44ac0d1491f876 = getteamdompoints(enemyteam);
    flaggroups = scripts\mp\gametypes\dom::getpreferreddompoints(teamdompoints, var_db44ac0d1491f876, spawnteam, otherteam);
    var_ba0a9fd614a3f6ee = spawnfactor::function_5647d0dca50a2d4d(flaggroups["preferred"], flaggroups["secondary"]);
    scripts\mp\spawnlogic::activatespawnset("dom");
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, "dom", "dom_fallback", undefined, var_ba0a9fd614a3f6ee);
  }

  assert(isDefined(spawnpoint));
  return spawnpoint;
}

function getteamdompoints(team) {
  teamdompoints = [];

  foreach(dompoint in level.objectives) {
    if(dompoint.ownerteam == team) {
      teamdompoints[teamdompoints.size] = dompoint;
    }
  }

  return teamdompoints;
}

function gettimesincedompointcapture(dompoint) {
  return gettime() - dompoint.capturetime;
}

function onplayerconnect(player) {
  player._domflageffect = [];
  player._domflagpulseeffect = [];
  player thread onplayerspawned();
  player thread scripts\mp\gametypes\obj_dom::ondisconnect();
  player.siegelatecomer = 1;

  if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"] != 0 && !scripts\mp\flags::gameflag("prematch_done")) {
    player thread manageprematchfade();
  }
}

function onplayerdisconnect(player) {
  for(;;) {
    player waittill("disconnect");

    foreach(effect in player._domflageffect) {
      if(isDefined(effect)) {
        effect delete();
      }
    }
  }
}

function onplayerspawned() {
  self endon("disconnect");

  while(true) {
    self waittill("spawned");
    setextrascore0(0);

    if(isDefined(self.pers["captures"])) {
      setextrascore0(self.pers["captures"]);
    }

    setextrascore1(0);

    if(isDefined(self.pers["rescues"])) {
      setextrascore1(self.pers["rescues"]);
    }
  }
}

function onplayerjointeam(player) {
  if(gamehasstarted()) {
    player.siegelatecomer = 1;
  }
}

function onspawnplayer(revivespawn) {
  level notify("spawned_player");
  thread scripts\mp\gametypes\dom::updatematchstatushintonspawn();
}

function checkallowspectating() {
  if(level.rushtimerteam == "none") {
    return;
  }

  if(!getteamdata(level.rushtimerteam, "aliveCount")) {
    level.spectateoverride[level.rushtimerteam].allowenemyspectate = 1;
    scripts\mp\spectating::updatespectatesettings();
  }
}

function domflags() {
  level endon("game_ended");
  primaryflags = getEntArray("flag_primary", "targetname");
  secondaryflags = getEntArray("flag_secondary", "targetname");

  if(primaryflags.size + secondaryflags.size < 2) {
    assertmsg("<dev string:x1c>");
    return;
  }

  filename = "mp/siegeFlagPos.csv";
  currentmap = getmapname();
  searchcol = 1;

  for(returncol = 2; returncol < 11; returncol++) {
    returnvalue = tablelookup(filename, searchcol, currentmap, returncol);

    if(returnvalue != "") {
      setflagpositions(returncol, float(returnvalue));
    }
  }

  triggers = [];

  for(index = 0; index < primaryflags.size; index++) {
    triggers[triggers.size] = primaryflags[index];
  }

  for(index = 0; index < secondaryflags.size; index++) {
    triggers[triggers.size] = secondaryflags[index];
  }

  level.numsiegeflags = 3;
  setomnvar("ui_num_dom_flags", level.numsiegeflags);

  if(level.numsiegeflags == 3) {
    foreach(trigger in primaryflags) {
      trigger scripts\mp\gametypes\dom::remapdomtriggerscriptlabel();
    }
  }

  level.objectives = [];

  for(index = 0; index < triggers.size; index++) {
    trigger = triggers[index];

    if(level.numsiegeflags == 3) {
      if(trigger.script_label == "_d" || trigger.script_label == "_e") {
        continue;
      }
    }

    trigger.origin = getflagpos(trigger.script_label, trigger.origin);

    if(isDefined(trigger.target)) {
      visuals[0] = getEnt(trigger.target, "targetname");
    } else {
      visuals[0] = spawn("script_model", trigger.origin);
      visuals[0].angles = trigger.angles;
    }

    domflag = scripts\mp\gameobjects::createuseobject("neutral", trigger, visuals, (0, 0, 100), 1, 1);
    domflag scripts\mp\gameobjects::allowuse("enemy");
    domflag scripts\mp\gameobjects::setusetime(level.caprate);

    if(isDefined(trigger.objectivekey)) {
      domflag.objectivekey = trigger.objectivekey;
    } else {
      domflag.objectivekey = domflag scripts\mp\gameobjects::getlabel();
    }

    if(isDefined(trigger.iconname)) {
      domflag.iconname = trigger.iconname;
    } else {
      domflag.iconname = domflag scripts\mp\gameobjects::getlabel();
    }

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
    traceend = visuals[0].origin + (0, 0, -32);
    trace = scripts\engine\trace::ray_trace(tracestart, traceend, undefined, scripts\engine\trace::create_default_contents(1));
    offset = scripts\mp\gametypes\obj_dom::checkmapoffsets(domflag);
    domflag.baseeffectpos = trace["position"] + offset;
    upangles = vectortoangles(trace["normal"]);
    modifiedupangles = scripts\mp\gametypes\obj_dom::checkmapfxangles(domflag, upangles);
    domflag.baseeffectforward = anglesToForward(modifiedupangles);
    domflag.noscriptable = 1;
    domflag.flagmodel = spawn("script_model", domflag.baseeffectpos);
    domflag.flagmodel setModel("military_dom_flag_neutral");
    level.objectives[domflag.objectivekey] = domflag;
  }

  spawn_axis_start = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_axis_start");
  spawn_allies_start = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_allies_start");
  level.startpos["allies"] = spawn_allies_start[0].origin;
  level.startpos["axis"] = spawn_axis_start[0].origin;
  level.bestspawnflag = [];
  level.bestspawnflag["allies"] = scripts\mp\gametypes\obj_dom::getunownedflagneareststart("allies", undefined);
  level.bestspawnflag["axis"] = scripts\mp\gametypes\obj_dom::getunownedflagneareststart("axis", level.bestspawnflag["allies"]);
  scripts\mp\gametypes\dom::flagsetup();

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level waittill_any_2("prematch_done", "start_mode_setup");
  }

  foreach(flag in level.objectives) {
    reservedobjid = scripts\mp\gametypes\obj_dom::getreservedobjid(flag.objectivekey);
    flag scripts\mp\gameobjects::requestid(1, 1, reservedobjid);
    flag.onuse = &onuse;
    flag.onbeginuse = &onbeginuse;
    flag.onuseupdate = &onuseupdate;
    flag.onenduse = &onenduse;
    flag.oncontested = &oncontested;
    flag.onuncontested = &onuncontested;
    flag.onunoccupied = &onunoccupied;
    flag.onpinnedstate = &onpinnedstate;
    flag.onunpinnedstate = &onunpinnedstate;
    flag.stompeenemyprogressupdate = &onstompeenemyprogressupdate;
    flag.stompprogressreward = &stompprogressreward;
    flag scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_target");
    flag scripts\mp\gameobjects::setvisibleteam("any");
    flag scripts\mp\gametypes\obj_dom::domflag_setneutral();
  }

  if(level.precappoints) {
    scripts\mp\gametypes\obj_dom::precap();
  }
}

function setneutral() {
  if(scripts\mp\gameobjects::getownerteam() == "neutral") {
    thread scripts\mp\gametypes\obj_dom::updateflagstate("idle", 0);
  }
}

function setflagpositions(col, posvalue) {
  switch (col) {
    case 2:
      level.siege_a_xpos = posvalue;
      break;
    case 3:
      level.siege_a_ypos = posvalue;
      break;
    case 4:
      level.siege_a_zpos = posvalue;
      break;
    case 5:
      level.siege_b_xpos = posvalue;
      break;
    case 6:
      level.siege_b_ypos = posvalue;
      break;
    case 7:
      level.siege_b_zpos = posvalue;
      break;
    case 8:
      level.siege_c_xpos = posvalue;
      break;
    case 9:
      level.siege_c_ypos = posvalue;
      break;
    case 10:
      level.siege_c_zpos = posvalue;
      break;
  }
}

function getflagpos(flaglabel, flagorigin) {
  returnorigin = flagorigin;

  if(flaglabel == "_a") {
    if(isDefined(level.siege_a_xpos) && isDefined(level.siege_a_ypos) && isDefined(level.siege_a_zpos)) {
      returnorigin = (level.siege_a_xpos, level.siege_a_ypos, level.siege_a_zpos);
    }
  } else if(flaglabel == "_b") {
    if(isDefined(level.siege_b_xpos) && isDefined(level.siege_b_ypos) && isDefined(level.siege_b_zpos)) {
      returnorigin = (level.siege_b_xpos, level.siege_b_ypos, level.siege_b_zpos);
    }
  } else if(isDefined(level.siege_c_xpos) && isDefined(level.siege_c_ypos) && isDefined(level.siege_c_zpos)) {
    returnorigin = (level.siege_c_xpos, level.siege_c_ypos, level.siege_c_zpos);
  }

  return returnorigin;
}

function watchflagtimerpause() {
  level endon("game_ended");

  while(true) {
    level waittill("flag_capturing", flag);

    if(level.rushtimer) {
      if(flag.prevteam != "neutral") {
        capturingteam = getotherteam(flag.prevteam)[0];

        if(isDefined(level.siegetimerstate) && level.siegetimerstate != "pause" && !iswinningteam(capturingteam)) {
          level.gametimerbeeps = 0;
          level.siegetimerstate = "pause";
          pausecountdowntimer();

          if(!flagownersalive(flag.prevteam)) {
            setwinner(capturingteam, tolower(game[flag.prevteam]) + "_eliminated");
          }
        }
      }
    }
  }
}

function iswinningteam(team) {
  iswinning = 0;
  teamflags = getflagcount(team);

  if(level.numsiegeflags == 3) {
    if(teamflags == 2) {
      iswinning = 1;
    }
  } else if(teamflags >= 3) {
    iswinning = 1;
  }

  return iswinning;
}

function flagownersalive(team) {
  ownersalive = 0;

  foreach(player in level.participants) {
    if(isDefined(player) && player.team == team && (isreallyalive(player) || player.pers["lives"] > 0)) {
      ownersalive = 1;
      break;
    }
  }

  return ownersalive;
}

function pausecountdowntimer() {
  if(!level.timerstoppedforgamemode) {
    var_fca15f66515ac04b = level.rushtimeramount;

    if(isDefined(level.siegetimeleft)) {
      var_fca15f66515ac04b = level.siegetimeleft;
    }

    gameovertime = int(gettime() + var_fca15f66515ac04b * 1000);
    scripts\mp\gamelogic::pausetimer(gameovertime);
  }

  level notify("siege_timer_paused");
}

function resumecountdowntimer(pause) {
  var_fca15f66515ac04b = level.rushtimeramount;

  if(level.timerstoppedforgamemode) {
    if(isDefined(level.siegetimeleft)) {
      var_fca15f66515ac04b = level.siegetimeleft;
    }

    gameovertime = int(gettime() + var_fca15f66515ac04b * 1000);
    setgameendtime(gameovertime);
    scripts\mp\gamelogic::resumetimer(gameovertime);

    if(!isDefined(level.siegetimerstate) || level.siegetimerstate == "pause") {
      level.siegetimerstate = "start";
    }

    thread watchgametimer(var_fca15f66515ac04b);

    if(istrue(pause)) {
      if(level.siegeflagcapturing.size > 0) {
        level notify("flag_capturing", self);
      }
    }
  }
}

function watchflagenduse(team) {
  level endon("game_ended");
  alliesflags = 0;
  axisflags = 0;
  var_df3f0fe977558f9f = level.rushtimerteam;
  alliesflags = getflagcount("allies");
  axisflags = getflagcount("axis");

  if(level.rushtimer && level.rushtimerteam != "none") {
    if(level.sharedrushtimer || alliesflags == 1 && axisflags == 1) {
      level.siegetimerstate = "start";
      notifyplayers("siege_timer_start");
      resumecountdowntimer(1);
      return;
    }
  }

  if(alliesflags == level.numsiegeflags) {
    setwinner("allies", "siege_allflags_win", "siege_allflags_loss");
  } else if(axisflags == level.numsiegeflags) {
    setwinner("axis", "siege_allflags_win", "siege_allflags_loss");
  } else if(level.rushtimer) {
    if(alliesflags == 2 || axisflags == 2) {
      level.rushtimerteam = ter_op(alliesflags > axisflags, "allies", "axis");

      if(var_df3f0fe977558f9f != level.rushtimerteam) {
        if(isDefined(level.siegetimerstate) && level.siegetimerstate != "reset") {
          level.gametimerbeeps = 0;
          level.siegetimeleft = undefined;
          level.siegetimerstate = "reset";
          notifyplayers("siege_timer_reset");
        }

        if(!isDefined(level.siegetimerstate) || level.siegetimerstate != "start") {
          var_fca15f66515ac04b = level.rushtimeramount;

          if(isDefined(level.siegetimeleft)) {
            var_fca15f66515ac04b = level.siegetimeleft;
          }

          gameovertime = int(gettime() + var_fca15f66515ac04b * 1000);
          level.timelimitoverride = 1;
          scripts\mp\gamelogic::pausetimer(gameovertime);
          setgameendtime(gameovertime);
          scripts\mp\gamelogic::resumetimer(gameovertime);

          if(!isDefined(level.siegetimerstate) || level.siegetimerstate == "pause") {
            level.siegetimerstate = "start";
            notifyplayers("siege_timer_start");
          }

          if(!level.gametimerbeeps) {
            thread watchgametimer(var_fca15f66515ac04b);
          }
        }
      } else if(var_df3f0fe977558f9f == level.rushtimerteam && alliesflags == 1 || var_df3f0fe977558f9f == level.rushtimerteam && axisflags == 1) {
        resumecountdowntimer(1);
      } else if(level.rushtimer) {
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

function watchgameinactive() {
  level endon("game_ended");
  level endon("flag_capturing");
  timelimit = getdvarfloat(@ "hash_9ca646b1f57e85a1");

  if(timelimit > 0) {
    inactivetime = timelimit - 1;

    while(inactivetime > 0) {
      inactivetime -= 1;
      wait 1;
    }

    level.siegegameinactive = 1;
  }
}

function watchgamestart() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  while(!havespawnedplayers()) {
    waitframe();
  }

  level.gamehasstarted = 1;
}

function havespawnedplayers() {
  if(level.teambased) {
    foreach(team in level.teamnamelist) {
      if(!getteamdata(team, "hasSpawned")) {
        return false;
      }
    }

    return true;
  }

  return level.maxplayercount > 1;
}

function watchgametimer(gametime) {
  level endon("game_ended");
  level endon("siege_timer_paused");
  level endon("siege_timer_reset");
  remainingtime = gametime;
  clockobject = spawn("script_origin", (0, 0, 0));
  clockobject hide();
  level.gametimerbeeps = 1;

  while(remainingtime > 0) {
    remainingtime -= 1;
    level.siegetimeleft = remainingtime;

    if(remainingtime <= 30) {
      if(remainingtime != 0) {
        clockobject playSound("ui_mp_timer_countdown");
      }
    }

    wait 1;
  }

  ontimelimit();
}

function getflagcount(team) {
  teamflags = 0;

  foreach(flag in level.objectives) {
    if(flag.ownerteam == team && !isbeingcaptured(flag)) {
      teamflags += 1;
    }
  }

  return teamflags;
}

function isbeingcaptured(flag) {
  var_22c8be36a2c1db6d = 0;

  if(isDefined(flag)) {
    if(level.siegeflagcapturing.size > 0) {
      foreach(flaglabel in level.siegeflagcapturing) {
        if(flag.objectivekey == flaglabel) {
          var_22c8be36a2c1db6d = 1;
        }
      }
    }
  }

  return var_22c8be36a2c1db6d;
}

function setwinner(team, reason, lossreason) {
  foreach(player in level.players) {
    if(!isai(player)) {
      player setclientomnvar("ui_objective_pinned_text_param", 0);
    }
  }

  if(isDefined(lossreason)) {
    thread scripts\mp\gamelogic::endgame(team, game["end_reason"][reason], game["end_reason"][lossreason]);
    return;
  }

  thread scripts\mp\gamelogic::endgame(team, game["end_reason"][reason]);
}

function onbeginuse(player) {
  if(!array_contains(level.siegeflagcapturing, self.objectivekey)) {
    level.siegeflagcapturing[level.siegeflagcapturing.size] = self.objectivekey;
    ownerteam = scripts\mp\gameobjects::getownerteam();
    player setclientomnvar("ui_objective_pinned_text_param", 1);
    self.didstatusnotify = 0;
    scripts\mp\gameobjects::setusetime(level.caprate);
  }

  level notify("flag_capturing", self);
}

function onuse(credit_player) {
  self.didstatusnotify = 0;
  team = credit_player.team;
  oldteam = scripts\mp\gameobjects::getownerteam();
  otherteam = getotherteam(team)[0];
  self.capturetime = gettime();
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  thread scripts\mp\gametypes\obj_dom::updateflagstate(team, 0, team);
  scripts\mp\gametypes\obj_dom::setflagcaptured(team, oldteam, credit_player);
  level.usestartspawns = 0;

  if(oldteam == "neutral") {
    ownedflags = scripts\mp\gametypes\obj_dom::getteamflagcount(team);

    if(ownedflags < level.objectives.size) {
      if(ownedflags == 2 && level.numsiegeflags == 3) {
        statusdialog("friendly_captured_2", team);
        statusdialog("enemy_captured_2", otherteam, 1);
      } else {
        statusdialog("secured" + self.objectivekey, team);
        statusdialog("lost" + self.objectivekey, otherteam, 1);
      }
    }
  }

  if(scripts\mp\gametypes\obj_dom::getteamflagcount(team) == level.objectives.size) {
    soundalias = "mp_dom_flag_captured_all";
  } else {
    soundalias = "mp_dom_flag_captured";
  }

  thread printandsoundoneveryone(team, otherteam, undefined, undefined, soundalias, "mp_dom_flag_lost", credit_player);
  thread giveflagcapturexp(self.touchlist[team], oldteam, credit_player);
  self.firstcapture = 0;

  if(isgameplayteam(team)) {
    if(level.teamdata[team]["aliveCount"] < level.teamdata[team]["players"].size) {
      foreach(player in level.teamdata[team]["players"]) {
        player playlocalsound("mp_bodycount_tick_positive");
      }

      enemies = getenemyplayers(team);

      foreach(player in enemies) {
        player playlocalsound("mp_bodycount_tick_negative");
      }
    }
  }

  thread checkshouldplaymusic(team);
}

function onuseupdate(team, progress, change, capplayer) {
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(progress < 1 && !level.gameended && !istrue(self.captureblocked)) {
    play_dom_capture_sfx(progress, team);
  }

  if(progress > 0.05 && change && !self.didstatusnotify) {
    if(ownerteam == "neutral") {
      statusdialog("securing" + self.objectivekey, team);
      self.prevownerteam = getotherteam(team)[0];
    } else {
      statusdialog("losing" + self.objectivekey, ownerteam, 1);
      statusdialog("securing" + self.objectivekey, team);
    }

    if(!isagent(capplayer)) {
      scripts\mp\gametypes\obj_dom::updateflagcapturestate(team);
    }

    scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosing, level.icontaking);
    self.didstatusnotify = 1;
  }

  level notify("flag_capturing", self);
}

function checkshouldplaymusic(team) {
  playmusic = 0;
  teamflags = getflagcount(team);

  if(level.numsiegeflags == 3) {
    if(teamflags == 2) {
      playmusic = 1;
    }
  } else if(teamflags == 4) {
    playmusic = 1;
  }

  if(playmusic) {
    thread scripts\mp\music_and_dialog::dominating_music(team);
  }
}

function play_dom_capture_sfx(progress, team) {
  if(!isDefined(self.lastsfxplayedtime)) {
    self.lastsfxplayedtime = gettime();
  }

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var_c3ddfb0eaa8f761c = "";
    progress = int(floor(progress * 10));
    var_c3ddfb0eaa8f761c = "mp_dom_capturing_tick_0" + progress;
    self.visuals[0] playsoundtoteam(var_c3ddfb0eaa8f761c, team);
  }
}

function onenduse(team, player, success) {
  self.didstatusnotify = 0;

  if(isPlayer(player)) {
    player setclientomnvar("ui_objective_pinned_text_param", 0);
  }

  if(success) {
    self.flagcapsuccess = 1;
  } else {
    self.flagcapsuccess = 0;
    resumecountdowntimer();
  }

  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    scripts\mp\gametypes\obj_dom::updateflagstate("idle", 0);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    scripts\mp\gametypes\obj_dom::updateflagstate(ownerteam, 0);
  }

  if(!istrue(self.setblocking) && !istrue(self.stalemate)) {
    level.siegeflagcapturing = array_remove(level.siegeflagcapturing, self.objectivekey);
  }

  thread waitthencheckendgame();
}

function waitthencheckendgame() {
  waitframe();
  checkendgame();
}

function oncontested() {
  if(!array_contains(level.siegeflagcapturing, self.objectivekey)) {
    level.siegeflagcapturing[level.siegeflagcapturing.size] = self.objectivekey;
  }

  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontested);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  scripts\mp\gametypes\obj_dom::updateflagstate("contested", 0);

  if(level.rushtimerteam == self.ownerteam) {
    resumecountdowntimer();
  }
}

function onuncontested(lastclaimteam) {
  ownerteam = scripts\mp\gameobjects::getownerteam();
  numtouching = scripts\mp\gameobjects::getnumtouchingforteam(ownerteam);
  numother = scripts\mp\gameobjects::getnumtouchingexceptteam(ownerteam);

  if(numtouching && !numother) {
    level.siegeflagcapturing = array_remove(level.siegeflagcapturing, self.objectivekey);
  }

  thread waitthencheckendgame();

  if(ownerteam == "neutral") {
    if(lastclaimteam != "none") {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, lastclaimteam);
    } else {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
    }
  } else {
    scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, getotherteam(ownerteam)[0]);
  }

  if(lastclaimteam == "none" || ownerteam == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    self.didstatusnotify = 0;
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  }

  flagstate = ter_op(ownerteam == "neutral", "idle", ownerteam);
  scripts\mp\gametypes\obj_dom::updateflagstate(flagstate, 0);
}

function onunoccupied() {
  ownerteam = scripts\mp\gameobjects::getownerteam();
  level.siegeflagcapturing = array_remove(level.siegeflagcapturing, self.objectivekey);
  thread waitthencheckendgame();

  if(ownerteam == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    self.didstatusnotify = 0;
    return;
  }

  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
}

function onpinnedstate(player) {
  if(self.ownerteam != "neutral" && self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
  }
}

function onunpinnedstate(player) {
  if(self.ownerteam != "neutral" && !self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  }

  ownerteam = scripts\mp\gameobjects::getownerteam();
  numtouching = scripts\mp\gameobjects::getnumtouchingforteam(ownerteam);
  numother = scripts\mp\gameobjects::getnumtouchingexceptteam(ownerteam);

  if(numtouching && !numother) {
    level.siegeflagcapturing = array_remove(level.siegeflagcapturing, self.objectivekey);
  }

  thread waitthencheckendgame();
}

function onstompeenemyprogressupdate(team) {
  ownerteam = scripts\mp\gameobjects::getownerteam();
  numtouching = scripts\mp\gameobjects::getnumtouchingforteam(ownerteam);
  numother = scripts\mp\gameobjects::getnumtouchingexceptteam(ownerteam);

  if(numtouching && !numother) {
    level.siegeflagcapturing = array_remove(level.siegeflagcapturing, self.objectivekey);
  }

  if(level.rushtimerteam == self.ownerteam) {
    resumecountdowntimer();
    return;
  }

  resumecountdowntimer(1);
}

function stompprogressreward(player) {
  player thread scripts\mp\rank::scoreeventpopup(#"defend");
  player thread scripts\mp\utility\points::doscoreevent(#"hash_2d96ced878338cd2");
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
}

function ondeadevent(team) {
  if(gamehasstarted()) {
    if(team == "all") {
      ontimelimit();
      return;
    }

    if(team == game["attackers"]) {
      if(level.rushtimer && getflagcount(team) == 2) {
        return;
      }

      setwinner(game["defenders"], tolower(game[game["attackers"]]) + "_eliminated");
      return;
    }

    if(team == game["defenders"]) {
      if(level.rushtimer && getflagcount(team) == 2) {
        return;
      }

      setwinner(game["attackers"], tolower(game[game["defenders"]]) + "_eliminated");
    }
  }
}

function ononeleftevent(team) {
  lastplayer = getlastlivingplayer(team);
  lastplayer thread givelastonteamwarning();
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid) {
  if(isDefined(self.wasflagspawned)) {
    self.wasflagspawned = undefined;
  }

  if(!isPlayer(attacker) || attacker.team == self.team) {
    return;
  }

  if(!flagownersalive(self.team) && scripts\mp\gametypes\obj_dom::getteamflagcount(self.team) == 2) {
    statusdialog("objs_capture", attacker.team, 1);
  }

  var_9ff9376383f4bc58 = 0;
  var_8363beb01b537d3e = 0;
  awardeddefend = 0;
  victim = self;
  victimteam = victim.team;
  victimpos = victim.origin;
  attackerteam = attacker.team;
  attackerpos = attacker.origin;
  attackerisinflictor = 0;

  if(isDefined(einflictor)) {
    attackerpos = einflictor.origin;
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
      if(!var_9ff9376383f4bc58) {
        var_9ff9376383f4bc58 = 1;
      }
    }
  }

  foreach(objective in level.objectives) {
    trigger = objective.trigger;
    ownerteam = objective.ownerteam;

    if(ownerteam == "neutral") {
      attackertouching = attacker istouching(trigger);
      victimtouching = victim istouching(trigger);

      if(attackertouching || victimtouching) {
        if(objective.claimteam == victimteam) {
          if(!var_8363beb01b537d3e) {
            if(var_9ff9376383f4bc58) {
              attacker thread function_e3e3e81453fd788b(#"capture_kill");
            } else {
              attacker thread scripts\mp\rank::scoreeventpopup(#"assault");
              attacker thread scripts\mp\utility\points::doscoreevent(#"mode_x_assault");
            }

            var_8363beb01b537d3e = 1;
            thread utility::trycall(level.matchdata_logattackerkillevent, killid, "assaulting");
            continue;
          }
        } else if(objective.claimteam == attackerteam) {
          if(!awardeddefend) {
            if(var_9ff9376383f4bc58) {
              attacker thread function_e3e3e81453fd788b(#"capture_kill");
            } else {
              attacker thread scripts\mp\rank::scoreeventpopup(#"defend");
              attacker thread scripts\mp\utility\points::doscoreevent(#"hash_2d96ced878338cd2");
            }

            awardeddefend = 1;
            attacker incpersstat("defends", 1);
            attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
            thread utility::trycall(level.matchdata_logattackerkillevent, killid, "defending");
            continue;
          }
        }
      }

      continue;
    }

    if(ownerteam != attackerteam) {
      if(!var_8363beb01b537d3e) {
        var_a3a2ce8b8e74ebef = distsquaredcheck(trigger, attackerpos, victimpos);

        if(var_a3a2ce8b8e74ebef) {
          if(var_9ff9376383f4bc58) {
            attacker thread function_e3e3e81453fd788b(#"capture_kill");
          } else {
            attacker thread scripts\mp\rank::scoreeventpopup(#"assault");
            attacker thread scripts\mp\utility\points::doscoreevent(#"mode_x_assault");
          }

          var_8363beb01b537d3e = 1;
          thread utility::trycall(level.matchdata_logattackerkillevent, killid, "assaulting");
          continue;
        }
      }

      continue;
    }

    if(!awardeddefend) {
      givedefend = distsquaredcheck(trigger, attackerpos, victimpos);

      if(givedefend) {
        if(var_9ff9376383f4bc58) {
          attacker thread function_e3e3e81453fd788b(#"capture_kill");
        } else {
          attacker thread scripts\mp\rank::scoreeventpopup(#"defend");
          attacker thread scripts\mp\utility\points::doscoreevent(#"hash_2d96ced878338cd2");
        }

        awardeddefend = 1;
        attacker incpersstat("defends", 1);
        attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
        thread utility::trycall(level.matchdata_logattackerkillevent, killid, "defending");
      }
    }
  }

  thread checkallowspectating();
}

function distsquaredcheck(trigger, attackerpos, victimpos) {
  var_9ae8b00a8e8f64fa = distancesquared(trigger.origin, attackerpos);
  var_1881a89c6f1e8775 = distancesquared(trigger.origin, victimpos);

  if(var_9ae8b00a8e8f64fa < 105625 || var_1881a89c6f1e8775 < 105625) {
    if(!isDefined(trigger.modifieddefendcheck)) {
      return 1;
    } else if(attackerpos[2] - trigger.origin[2] < 100 || victimpos[2] - trigger.origin[2] < 100) {
      return 1;
    } else {
      return 0;
    }

    return;
  }

  return 0;
}

function givelastonteamwarning() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  waittillrecoveredhealth(3);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, #"bc_status_inform_last_one");
  otherteam = getotherteam(self.pers["team"])[0];
  level thread teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
  level thread teamplayercardsplash("callout_lastenemyalive", self, otherteam);
  level notify("last_alive", self);
}

function ontimelimit() {
  if(isDefined(level.siegegameinactive)) {
    level.forcedend = 1;
    thread scripts\mp\gamelogic::endgame("none", game["end_reason"]["siege_force_end"]);
    return;
  }

  alliesflags = getflagcount("allies");
  axisflags = getflagcount("axis");

  if(alliesflags > axisflags) {
    setwinner("allies", "siege_flag_win", "siege_flag_loss");
    return;
  }

  if(axisflags > alliesflags) {
    setwinner("axis", "siege_flag_win", "siege_flag_loss");
    return;
  }

  setwinner("tie", "cyber_tie");
}

function teamrespawn(team, credit_player) {
  teamsize = getteamdata(credit_player.team, "teamCount");

  if(!isDefined(credit_player.rescuedplayers)) {
    credit_player.rescuedplayers = [];
  }

  foreach(player in level.participants) {
    if(isDefined(player) && player.team == team && !isreallyalive(player) && !array_contains(getfriendlyplayers(player.team, 1), player) && (!isDefined(player.waitingtoselectclass) || !player.waitingtoselectclass)) {
      if(isDefined(player.siegelatecomer) && player.siegelatecomer) {
        player.siegelatecomer = 0;
      }

      if(!istrue(player.pers["teamKillPunish"])) {
        if(istrue(player.wasflagspawned)) {
          continue;
        }

        player.wasflagspawned = 1;
        player thread scripts\mp\playerlogic::waittillcanspawnclient(0);
        player thread scripts\mp\rank::scoreeventpopup(#"revived");
        level notify("sr_player_respawned", player);
        player leaderdialogonplayer("revived");
      }

      credit_player.rescuedplayers[player.guid] = 1;
    }
  }

  self.playersrevived = credit_player.rescuedplayers.size;
}

function notifyplayers(notifystring) {
  foreach(player in level.players) {
    player thread scripts\mp\hud_message::showsplash(notifystring);
  }

  level notify("match_ending_soon", "time");
  level notify(notifystring);
}

function giveflagcapturexp(touchlist, oldteam, credit_player) {
  level endon("game_ended");
  first_player = credit_player;

  if(isDefined(first_player.owner)) {
    first_player = first_player.owner;
  }

  level.lastcaptime = gettime();

  if(isPlayer(first_player)) {
    level thread teamplayercardsplash("callout_securedposition" + self.objectivekey, first_player);
    var_7e2c53b0bcf117d9 = spawnStruct();
    var_7e2c53b0bcf117d9.player = first_player;
    var_7e2c53b0bcf117d9.eventname = "capture";
    var_7e2c53b0bcf117d9.position = first_player.origin;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_on_game_event", var_7e2c53b0bcf117d9);
  }

  players_touching = getarraykeys(touchlist);

  for(index = 0; index < players_touching.size; index++) {
    player = touchlist[players_touching[index]].player;

    if(isDefined(player.owner)) {
      player = player.owner;
    }

    if(!isPlayer(player)) {
      continue;
    }

    player thread updatecpm();

    if(player.cpm > 3) {
      xpreward = 0;
      capreward = 0;
    } else if(player.numcaps > 5) {
      xpreward = 125;
      capreward = 50;
    } else if(self.objectivekey == "_b" || oldteam != "neutral" || self.playersrevived > 0) {
      xpreward = undefined;
      capreward = undefined;
    } else {
      xpreward = 125;
      capreward = 50;
    }

    player thread scripts\mp\rank::scoreeventpopup(#"capture");
    player thread scripts\mp\utility\points::doscoreevent(#"hash_32ffd90c03ec37c6", undefined, capreward, xpreward);
    player incpersstat("captures", 1);
    player scripts\mp\persistence::statsetchild("round", "captures", player.pers["captures"]);
    player setextrascore0(player.pers["captures"]);
    player incpersstat("rescues", self.playersrevived);
    player scripts\mp\persistence::statsetchild("round", "rescues", player.pers["rescues"]);
    player setextrascore1(player.pers["rescues"]);
    wait 0.05;
  }

  self.playersrevived = 0;
}

function getcapxpscale() {
  if(self.cpm < 4) {
    return 1;
  }

  return 0.25;
}

function updatecpm() {
  if(!isDefined(self.cpm)) {
    self.numcaps = 0;
    self.cpm = 0;
  }

  self.numcaps++;

  if(getminutespassed() < 1) {
    return;
  }

  self.cpm = self.numcaps / getminutespassed();
}

function checkendgame() {
  alliesflags = getflagcount("allies");
  axisflags = getflagcount("axis");

  if(alliesflags == level.numsiegeflags) {
    setwinner("allies", "siege_allflags_win", "siege_allflags_loss");
    return;
  }

  if(axisflags == level.numsiegeflags) {
    setwinner("axis", "siege_allflags_win", "siege_allflags_loss");
  }
}

function runobjectives(numobjs) {
  level.axisspawnareas = [level.axishqname];
  level.alliesspawnareas = [level.allieshqname];
  level.allfobs = [];

  foreach(fob in level.gw_objstruct.startingfobs_axis) {
    var_ddca7869b65236b6 = runobjflag(fob.trigger, "axis");
    level.allfobs[level.allfobs.size] = fob;
    level.axisspawnareas[level.axisspawnareas.size] = fob.name;

    if(isDefined(level.spawnselectionlocations[fob.name]["axis"].anchorentity)) {
      level.spawnselectionlocations[fob.name]["axis"].anchorentity.origin = fob.trigger.origin + (0, 0, 100);
    }
  }

  foreach(fob in level.gw_objstruct.startingfobs_allies) {
    var_ddca7869b65236b6 = runobjflag(fob.trigger, "allies");
    level.allfobs[level.allfobs.size] = fob;
    level.alliesspawnareas[level.alliesspawnareas.size] = fob.name;

    if(isDefined(level.spawnselectionlocations[fob.name]["allies"].anchorentity)) {
      level.spawnselectionlocations[fob.name]["allies"].anchorentity.origin = fob.trigger.origin + (0, 0, 100);
    }
  }

  foreach(fob in level.gw_objstruct.startingfobs_neutral) {
    if(level.numsiegeflags == 3) {
      if(level.mapname == "mp_downtown_gw") {
        if(fob.trigger.objkey == "_a" || fob.trigger.objkey == "_e") {
          continue;
        } else {
          remapobjkeysandscriptlabels(fob.trigger);
        }
      } else if(level.mapname == "mp_aniyah") {
        if(fob.trigger.objkey == "_b" || fob.trigger.objkey == "_d") {
          continue;
        } else {
          remapobjkeysandscriptlabels(fob.trigger);
        }
      } else if(level.mapname == "mp_farms2_gw") {
        if(fob.trigger.objkey == "_b" || fob.trigger.objkey == "_d") {
          continue;
        } else {
          remapobjkeysandscriptlabels(fob.trigger);
        }
      } else if(level.mapname == "mp_promenade_gw") {
        if(fob.trigger.objkey == "_a" || fob.trigger.objkey == "_e") {
          continue;
        } else {
          remapobjkeysandscriptlabels(fob.trigger);
        }
      } else if(level.mapname == "mp_riverside_gw") {
        if(fob.trigger.objkey == "_b" || fob.trigger.objkey == "_d") {
          continue;
        } else {
          remapobjkeysandscriptlabels(fob.trigger);
        }
      } else if(fob.trigger.objkey == "_a" || fob.trigger.objkey == "_e") {
        continue;
      } else {
        remapobjkeysandscriptlabels(fob.trigger);
      }
    }

    var_ddca7869b65236b6 = runobjflag(fob.trigger, "neutral");
    level.allfobs[level.allfobs.size] = fob;
  }

  spawn_axis_start = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_axis_start");
  spawn_allies_start = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_allies_start");
  level.startpos["allies"] = spawn_allies_start[0].origin;
  level.startpos["axis"] = spawn_axis_start[0].origin;

  foreach(fob in level.allfobs) {
    reservedobjid = scripts\mp\gametypes\obj_dom::getreservedobjid(fob.trigger.gameobject.objectivekey);
    fob.trigger.gameobject scripts\mp\gameobjects::requestid(1, 1, reservedobjid);
    fob.trigger.gameobject.onuse = &onuse;
    fob.trigger.gameobject.onbeginuse = &onbeginuse;
    fob.trigger.gameobject.onuseupdate = &onuseupdate;
    fob.trigger.gameobject.onenduse = &onenduse;
    fob.trigger.gameobject.oncontested = &oncontested;
    fob.trigger.gameobject.onuncontested = &onuncontested;
    fob.trigger.gameobject.onunoccupied = &onunoccupied;
    fob.trigger.gameobject.onpinnedstate = &onpinnedstate;
    fob.trigger.gameobject.onunpinnedstate = &onunpinnedstate;
    fob.trigger.gameobject.stompeenemyprogressupdate = &onstompeenemyprogressupdate;
    fob.trigger.gameobject.stompprogressreward = &stompprogressreward;
    fob.trigger.gameobject scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_target");
    fob.trigger.gameobject scripts\mp\gameobjects::setvisibleteam("any");
    fob.trigger.gameobject scripts\mp\gametypes\obj_dom::domflag_setneutral();
    level.objectives[fob.trigger.gameobject.objectivekey] = fob.trigger.gameobject;
  }

  level.bestspawnflag = [];
  level.bestspawnflag["allies"] = scripts\mp\gametypes\obj_dom::getunownedflagneareststart("allies", undefined);
  level.bestspawnflag["axis"] = scripts\mp\gametypes\obj_dom::getunownedflagneareststart("axis", level.bestspawnflag["allies"]);

  if(level.precappoints) {
    scripts\mp\gametypes\obj_dom::precap(level.numsiegeflags == 5);
  }

  scripts\mp\gametypes\dom::flagsetup();
  level thread objective_manageobjectivesintrovisibility();
  level thread scripts\mp\gametypes\arm::allowobjectiveuseaftermatchstart();
}

function objective_manageobjectivesintrovisibility() {
  wait 1;

  foreach(fob in level.allfobs) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(fob.trigger.gameobject.objidnum);
  }

  while(!scripts\mp\flags::gameflag("prematch_done")) {
    waitframe();
  }

  foreach(fob in level.allfobs) {
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(fob.trigger.gameobject.objidnum);
  }
}

function remapobjkeysandscriptlabels(objective) {
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

    return;
  }

  if(level.mapname == "mp_boneyard_gw") {
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

    return;
  }

  if(level.mapname == "mp_aniyah") {
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

    return;
  }

  if(level.mapname == "mp_promenade_gw") {
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

    return;
  }

  if(level.mapname == "mp_farms2_gw") {
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

    return;
  }

  if(level.mapname == "mp_riverside_gw") {
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

    return;
  }

  if(objective.objkey == "_b" && !isDefined(objective.oldkey)) {
    objective.oldkey = "_b";
    objective.objkey = "_a";
    objective.script_label = objective.objkey;
    return;
  }

  if(objective.objkey == "_c" && !isDefined(objective.oldkey)) {
    objective.oldkey = "_c";
    objective.objkey = "_b";
    objective.script_label = objective.objkey;
    return;
  }

  if(objective.objkey == "_d" && !isDefined(objective.oldkey)) {
    objective.oldkey = "_d";
    objective.objkey = "_c";
    objective.script_label = objective.objkey;
  }
}

function runobjflag(objective, startingteam) {
  level endon("game_ended");
  objective.script_label = objective.objkey;
  domflag = scripts\mp\gametypes\obj_dom::setupobjective(objective, undefined, 1);
  domflag.origin = objective.origin;
  domflag scripts\mp\gameobjects::allowuse("none");
  domflag.didstatusnotify = 0;
  domflag scripts\mp\gameobjects::setownerteam(startingteam);
  visibility = "any";

  if(startingteam != "neutral") {
    if(level.hideenemyfobs) {
      visibility = "friendly";
    }

    domflag.capturetime = gettime();
  }

  domflag scripts\mp\gameobjects::setvisibleteam(visibility);
  return domflag;
}

function manageprematchfade(delay_time, var_c82eabb722c361a7) {
  self endon("disconnect");
  var_ad4dd16f29e24b77 = 0;
  var_dfab0807d83a77fe = 0.5;
  thread scripts\mp\playerlogic::managerespawnfade(var_ad4dd16f29e24b77, var_dfab0807d83a77fe);
}

function function_7fd73dbe340f511d() {
  self endon("<dev string:x4d>");
  setdevdvarifuninitialized(@ "hash_1432c61b2a63cd8e", 0);
  capplayer = undefined;

  while(true) {
    if(getdvarint(@ "hash_1432c61b2a63cd8e", 0) != 0) {
      foreach(player in level.players) {
        if(player ishost()) {
          capplayer = player;
          break;
        }
      }

      level.objectives["<dev string:x5b>"] onuse(capplayer);
      wait 0.15;
      level.objectives["<dev string:x61>"] onuse(capplayer);
    }

    setdevdvar(@ "hash_1432c61b2a63cd8e", 0);
    wait 1;
  }
}

function removedompoint() {
  self endon("<dev string:x4d>");

  while(true) {
    if(getDvar(@ "hash_6ce167f2cdc8ef7c", "<dev string:x67>") != "<dev string:x67>") {
      flaglabel = getDvar(@ "hash_6ce167f2cdc8ef7c", "<dev string:x67>");

      foreach(domflag in level.objectives) {
        if(isDefined(domflag.objectivekey) && domflag.objectivekey == flaglabel) {
          domflag scripts\mp\gameobjects::allowuse("<dev string:x6b>");
          domflag.trigger = undefined;
          domflag notify("<dev string:x73>");

          if(isDefined(domflag.neutralflagfx)) {
            domflag.neutralflagfx delete();
          }

          foreach(player in level.players) {
            foreach(effect in player._domflageffect) {
              if(isDefined(effect)) {
                effect delete();
              }
            }

            foreach(pulseeffect in player._domflagpulseeffect) {
              if(isDefined(pulseeffect)) {
                pulseeffect delete();
              }
            }
          }

          domflag.visibleteam = "<dev string:x6b>";
          domflag scripts\mp\gameobjects::setobjectivestatusicons(undefined, undefined);
          tempflags = [];

          foreach(objective in level.objectives) {
            if(objective.objectivekey != flaglabel) {
              tempflags[tempflags.size] = objective;
            }
          }

          level.objectives = tempflags;
          break;
        }
      }

      setdynamicdvar(@ "hash_6ce167f2cdc8ef7c", "<dev string:x67>");
    }

    wait 1;
  }
}

function placedompoint() {
  self endon("<dev string:x4d>");

  while(true) {
    if(getDvar(@ "hash_29d45d6822a1cf6d", "<dev string:x67>") != "<dev string:x67>") {
      flaglabel = getDvar(@ "hash_29d45d6822a1cf6d", "<dev string:x67>");
      zone = spawnStruct();
      zone.origin = level.players[0].origin;
      zone.angles = level.players[0].angles;
      trigger = spawn("<dev string:x7e>", zone.origin, 0, 120, 128);
      zone.trigger = trigger;
      zone.trigger.script_label = flaglabel;
      zone.ownerteam = "<dev string:x90>";
      tracestart = zone.origin + (0, 0, 32);
      traceend = zone.origin + (0, 0, -32);
      trace = scripts\engine\trace::_bullet_trace(tracestart, traceend, 0, undefined);
      zone.origin = trace["<dev string:x9b>"];
      zone.upangles = vectortoangles(trace["<dev string:xa7>"]);
      zone.forward = anglesToForward(zone.upangles);
      zone.right = anglestoright(zone.upangles);
      zone.visuals[0] = spawn("<dev string:xb1>", zone.origin);
      zone.visuals[0].angles = zone.angles;
      domflag = scripts\mp\gameobjects::createuseobject("<dev string:x90>", zone.trigger, zone.visuals, (0, 0, 100));
      domflag scripts\mp\gameobjects::allowuse("<dev string:xc1>");
      domflag scripts\mp\gameobjects::setusetime(level.caprate);

      if(isDefined(trigger.objectivekey)) {
        domflag.objectivekey = trigger.objectivekey;
      } else {
        domflag.objectivekey = domflag scripts\mp\gameobjects::getlabel();
      }

      if(isDefined(trigger.iconname)) {
        domflag.iconname = trigger.iconname;
      } else {
        domflag.iconname = domflag scripts\mp\gameobjects::getlabel();
      }

      domflag scripts\mp\gameobjects::setobjectivestatusicons("<dev string:xca>", "<dev string:xdd>");
      domflag scripts\mp\gameobjects::setvisibleteam("<dev string:xf8>");
      domflag scripts\mp\gameobjects::cancontestclaim(1);
      domflag.onuse = &onuse;
      domflag.onbeginuse = &onbeginuse;
      domflag.onuseupdate = &onuseupdate;
      domflag.onenduse = &onenduse;
      domflag.oncontested = &oncontested;
      domflag.onuncontested = &onuncontested;
      domflag.onunoccupied = &scripts\mp\gametypes\obj_dom::dompoint_onunoccupied;
      domflag.onpinnedstate = &scripts\mp\gametypes\obj_dom::dompoint_onpinnedstate;
      domflag.onunpinnedstate = &scripts\mp\gametypes\obj_dom::dompoint_onunpinnedstate;
      domflag.stompprogressreward = &scripts\mp\gametypes\obj_dom::dompoint_stompprogressreward;
      domflag.nousebar = 1;
      domflag.id = "<dev string:xff>";
      domflag.firstcapture = 1;
      domflag.claimgracetime = 10000;
      domflag scripts\mp\gameobjects::pinobjiconontriggertouch();
      tracestart = zone.visuals[0].origin + (0, 0, 32);
      traceend = zone.visuals[0].origin + (0, 0, -32);
      contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
      ignoreents = [];
      trace = scripts\engine\trace::ray_trace(tracestart, traceend, ignoreents, contentoverride);
      domflag.baseeffectpos = trace["<dev string:x9b>"];
      upangles = vectortoangles(trace["<dev string:xa7>"]);
      domflag.baseeffectforward = anglesToForward(upangles);
      domflag scripts\mp\gametypes\obj_dom::initializematchrecording();
      domflag delaythread(1, &setneutral);
      level.objectives[domflag.objectivekey] = domflag;
      setdynamicdvar(@ "hash_29d45d6822a1cf6d", "<dev string:x67>");
    }

    wait 1;
  }
}

function domdebug() {
  spawnpoints = scripts\mp\spawnlogic::getteamspawnpoints("<dev string:x10a>");
  ispathdataavailable = scripts\mp\spawnlogic::ispathdataavailable();
  heightoffsetlines = (0, 0, 12);
  heightoffsetnames = (0, 0, 64);
  colors = [];
  colors[1] = (1, 0, 0);
  colors[2] = (0, 1, 0);
  colors[4] = (0, 0, 1);
  colors[8] = (1, 1, 1);
  colors[16] = (0, 0, 0);
  colors[32] = (1, 1, 0);
  colors[64] = (0, 1, 1);
  colors[128] = (1, 0, 1);

  while(true) {
    if(getDvar(@ "scr_domdebug") != "<dev string:x112>") {
      wait 1;
      continue;
    }

    setdevdvar(@ "scr_showspawns", "<dev string:x112>");

    while(true) {
      if(getDvar(@ "scr_domdebug") != "<dev string:x112>") {
        setdevdvar(@ "scr_showspawns", "<dev string:x117>");
        break;
      }

      if(!isDefined(level.players[0])) {
        waitframe();
        continue;
      }

      endpoints = [];
      endpoints[1] = [level.objectives["<dev string:x5b>"]];
      endpoints[2] = [level.objectives["<dev string:x61>"]];
      endpoints[4] = [level.objectives["<dev string:x11c>"]];
      endpoints[8] = [level.objectives["<dev string:x122>"]];
      endpoints[16] = [level.objectives["<dev string:x128>"]];
      endpoints[32] = [level.objectives["<dev string:x5b>"], level.objectives["<dev string:x61>"]];
      endpoints[64] = [level.objectives["<dev string:x11c>"], level.objectives["<dev string:x61>"]];
      endpoints[128] = [level.objectives["<dev string:x5b>"], level.objectives["<dev string:x11c>"]];

      foreach(spawnpoint in spawnpoints) {
        spawnpointdata = spawnpoint.scriptdata;

        if(!isDefined(spawnpointdata.var_601117ef603f46a3)) {
          spawnpointdata.var_601117ef603f46a3 = [];
        }

        if(ispathdataavailable) {
          foreach(endpoint in endpoints[spawnpoint.scriptdata.domflagassignments]) {
            if(!isDefined(spawnpointdata.var_601117ef603f46a3[endpoint.spawnflagid])) {
              spawnpointdata.var_601117ef603f46a3[endpoint.spawnflagid] = level.players[0] findpath(spawnpoint.origin, endpoint.curorigin);
            }

            if(!isDefined(spawnpointdata.var_601117ef603f46a3[endpoint.spawnflagid]) || spawnpointdata.var_601117ef603f46a3[endpoint.spawnflagid].size == 0) {
              continue;
            }

            color = colors[spawnpoint.scriptdata.domflagassignments];
            line(spawnpoint.origin + heightoffsetlines, spawnpointdata.var_601117ef603f46a3[endpoint.spawnflagid][0] + heightoffsetlines, color);

            for(i = 0; i < spawnpointdata.var_601117ef603f46a3[endpoint.spawnflagid].size - 1; i++) {
              line(spawnpointdata.var_601117ef603f46a3[endpoint.spawnflagid][i] + heightoffsetlines, spawnpointdata.var_601117ef603f46a3[endpoint.spawnflagid][i + 1] + heightoffsetlines, color);
            }
          }

          continue;
        }

        foreach(endpoint in endpoints[spawnpoint.scriptdata.domflagassignments]) {
          line(endpoint.curorigin + heightoffsetlines, spawnpoint.origin + heightoffsetlines, (0.2, 0.2, 0.6));
        }
      }

      foreach(flaglocation in level.objectives) {
        if(flaglocation == level.bestspawnflag["<dev string:x12e>"]) {
          print3d(flaglocation.trigger.origin + heightoffsetnames, "<dev string:x138>");
        }

        if(flaglocation == level.bestspawnflag["<dev string:x10a>"]) {
          print3d(flaglocation.trigger.origin + heightoffsetnames, "<dev string:x152>");
        }
      }

      waitframe();
    }
  }
}

# /