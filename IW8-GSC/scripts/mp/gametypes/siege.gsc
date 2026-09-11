/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\siege.gsc
***********************************************/

function main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }

  level.unset_relic_lfo = 0;
  var_0 = getdvarint("LTSNLQNRKO") && !getdvarint("LSTLQTSSRM");

  if(var_0) {
    level.unset_relic_lfo = getdvarint("scr_siege_groundwarSiege", 0);
  }

  level.brking_createc130pathstruct = [];

  if(level.unset_relic_lfo) {
    level.brking_createc130pathstruct[level.brking_createc130pathstruct.size] = "arm";
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  GscBinSkip1(0x45, 0, scripts\mp\utility\game::getgametype());
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_siege_rushTimer", getmatchrulesdata("siegeData", "rushTimer"));
  setdynamicdvar("scr_siege_rushTimerAmount", getmatchrulesdata("siegeData", "rushTimerAmount"));
  setdynamicdvar("scr_siege_sharedRushTimer", getmatchrulesdata("siegeData", "sharedRushTimer"));
  setdynamicdvar("scr_siege_preCapPoints", getmatchrulesdata("siegeData", "preCapPoints"));
  setdynamicdvar("scr_siege_capRate", getmatchrulesdata("siegeData", "capRate"));
  setdynamicdvar("scr_siege_objScalar", getmatchrulesdata("siegeData", "objScalar"));
  setdynamicdvar("scr_siege_holdAllTimer", getmatchrulesdata("siegeData", "holdAllTimer"));
  setdynamicdvar("scr_siege_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("siege", 0);
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
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  foreach(var_3 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_3, &"OBJECTIVES/DOM");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"OBJECTIVES/DOM");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"OBJECTIVES/DOM_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var_3, &"OBJECTIVES/DOM_HINT");
  }

  thread waittooverridegraceperiod();

  if(level.unset_relic_lfo) {
    thread adjustroundendtimer();
    scripts\mp\gametypes\arm::initspawns(isDefined(game["roundsPlayed"]) && game["roundsPlayed"] != 0);
    level thread scripts\mp\gametypes\arm::setupwaypointicons();
    scripts\mp\gametypes\arm::debug_setupmatchdata();
    scripts\mp\gametypes\arm::ref_1324d();
    scripts\mp\gametypes\arm::calculatehqmidpoint();
    level.ref_11f45 = getdvarint("scr_siege_flagcount", 3);
    setomnvar("ui_num_dom_flags", level.ref_11f45);
    scripts\mp\gametypes\arm::setupobjectives();
    thread runobjectives();
    thread scripts\mp\gametypes\arm::init_groundwarvehicles();
    thread trace_to_eye_weight();
    scripts\mp\gametypes\arm::monitordriverexitbutton();
  } else {
    initspawns();
    thread domflags();
  }

  thread watchflagtimerpause();
  thread watchgamestart();

  if(scripts\mp\utility\game::matchmakinggame()) {
    thread watchgameinactive();
    return;
  }
}

function vehiclespawn_getspawndata(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.spawntype = "GAME_MODE";
  var_1.showheadicon = 1;
  return var_1;
}

function registervehicletype(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.refname = var_0;
  var_3.spawncallback = var_2;
  var_3.vehiclespawns = [[var_1]]();
  level.vehicleinfo[var_0] = var_3;
}

function trace_to_eye_weight() {
  level.numhqtanks_axis = 0;
  level.numhqtanks_allies = 0;

  if(!isDefined(level.vehicleinfo)) {
    level.vehicleinfo = [];
  }

  registervehicletype("little_bird", &scripts\cp_mp\vehicles\little_bird::little_bird_getspawnstructscallback, &vehiclespawn_littlebird);
  registervehicletype("atv", &scripts\cp_mp\vehicles\atv::atv_getspawnstructscallback, &vehiclespawn_atv);
  registervehicletype("cargo_truck", &scripts\cp_mp\vehicles\cargo_truck::cargo_truck_getspawnstructscallback, &vehiclespawn_cargotruck);
  registervehicletype("jeep", &scripts\cp_mp\vehicles\jeep::jeep_getspawnstructscallback, &vehiclespawn_jeep);
  registervehicletype("tac_rover", &scripts\cp_mp\vehicles\tac_rover::tac_rover_getspawnstructscallback, &vehiclespawn_tacrover);
  level.vehiclespawnlocs = [];

  foreach(var_1 in level.vehicleinfo) {
    switch (var_1.refname) {
      case "little_bird":
        var_1.vehiclespawns = rundrawprematchareas("little_bird", "lbravo_physics_mp");
        break;
      case "atv":
        var_1.vehiclespawns = rundrawprematchareas("atv", "atango_physics_mp");
        break;
      case "cargo_truck":
        var_1.vehiclespawns = rundrawprematchareas("cargo_truck", "mkilo_physics_mp");
        break;
      case "jeep":
        var_1.vehiclespawns = rundrawprematchareas("jeep", "decho_physics_mp");
        break;
      case "tac_rover":
        var_1.vehiclespawns = rundrawprematchareas("tac_rover", "tromeo_physics_mp");
        break;
    }

    foreach(var_3 in var_1.vehiclespawns) {
      var_4 = level.vehiclespawnlocs.size;
      level.vehiclespawnlocs[var_4] = var_3;
      level.vehiclespawnlocs[var_4].refname = var_1.refname;
    }
  }

  if(false) {
    foreach(var_8 in level.vehiclespawnlocs) {
      thread scripts\mp\utility\debug::drawline(var_8.origin, var_8.origin + (0, 0, 1500), 1000, (1, 0, 0));
    }
  }

  level.vehiclespawnlocs = scripts\engine\utility::array_randomize(level.vehiclespawnlocs);
  var_10 = level.ref_11f41;

  if(!isDefined(level.ref_11f41)) {
    var_10 = 25;
  }

  if(false) {
    for(var_11 = 0; var_11 < var_10; var_11++) {
      var_8 = level.vehiclespawnlocs[var_11];
      thread scripts\mp\utility\debug::drawline(var_8.origin + (0, 0, 1500), var_8.origin + (0, 0, 2500), 1000, (0, 1, 0));
    }
  }

  for(var_11 = 0; var_11 < var_10; var_11++) {
    var_8 = level.vehiclespawnlocs[var_11];

    if(isDefined(var_8)) {
      var_1 = level.vehicleinfo[var_8.refname];
      [[var_1.spawncallback]](var_8);
    }
  }
}

function rundrawprematchareas(var_0, var_1) {
  var_2 = [];
  var_3 = scripts\cp_mp\utility\game_utility::getmapname();
  var_4 = [];
  var_5 = [];
  var_6 = [];
  var_7 = [];

  switch (var_3) {
    case "mp_downtown_gw":
      if(var_0 == "atv") {
        var_4 = (21843.8, -4640.11, -476.961);
        var_4 = (20375.9, -3612.78, -454);
        var_4 = (20728.8, -3309.36, -456);
        var_5 = (0, 255, 0);
        var_5 = (0, 330, 0);
        var_5 = (0, 292, 0);
        var_4 = (20937.2, -9029.28, -379.674);
        var_4 = (23097.1, -9966.89, -344);
        var_5 = (356.825, 240, 0);
        var_5 = (0, 0, 0);
        var_4 = (17471, -23211.4, -204);
        var_4 = (15960.1, -22768.1, -204);
        var_4 = (15821.3, -23568, -208.461);
        var_5 = (0, 90, 0);
        var_5 = (0, 45, 0);
        var_5 = (0, 90, 0);
        var_4 = (22994.3, -15304.5, -216);
        var_5 = (0, 105, 0);
      } else if(var_0 == "tac_rover") {
        var_6 = (20120.2, -3287.71, -456);
        var_6 = (21339.9, -4787.55, -450.176);
        GscBinSkip0(0x2e, var_7.size, (0, 345, 0));
      }

      break;
    case "mp_quarry2":
      if(var_0 == "atv") {
        var_4 = (26335.7, 30412.6, 655.471);
        var_4 = (27099.5, 30567.5, 639.236);
        var_4 = (27315.5, 30525.5, 639.236);
        var_5 = (0.0728273, 119, 0.843973);
        var_5 = (2.67817, 77.0718, 1.59551);
        var_5 = (2.67817, 77.0718, 1.59551);
        var_4 = (29610.4, 38228.5, 698.883);
        var_4 = (29465.5, 38973.6, 701);
        var_5 = (0, 315, 0);
        var_5 = (0, 88.9989, 0);
        var_4 = (39153, 46431.8, 932.749);
        var_4 = (38876.4, 46106.9, 925.771);
        var_4 = (37923.7, 47136.4, 949.247);
        var_5 = (1.88064, 180.047, 0.333796);
        var_5 = (1.47639, 180.039, 1.17305);
        var_5 = (359.077, 185.712, 7.76991);
        var_4 = (33628.2, 40971.6, 653.047);
        var_4 = (32104.4, 41719.8, 708.773);
        var_5 = (349.991, 186.286, -2.23687);
        var_5 = (3.95499, 211.371, 4.41818);
      } else if(var_0 == "tac_rover") {
        var_6 = (26310.8, 30168.4, 659.426);
        var_6 = (26954, 29794.1, 651.013);
        GscBinSkip0(0x2e, var_7.size, (358.195, 118.006, -2.71651));
      }

      break;
    case "mp_farms2":
    case "mp_farms2_gw":
      if(var_0 == "atv") {
        var_4 = (49063.3, -22654.9, -385.662);
        var_4 = (47332.9, -23070.6, -374.497);
        var_4 = (48281.3, -22202.5, -371.375);
        var_5 = (0.0275984, 103.998, 0.280605);
        var_5 = (357.226, 88.8435, 4.3294);
        var_5 = (3.93534, 89.3527, 4.34541);
        var_4 = (49720, -18492, -387.562);
        var_4 = (48107.4, -18052.3, -312.859);
        var_5 = (0, 73.9972, 0);
        var_5 = (352.657, 118.56, -10.3306);
        var_4 = (46431.3, -92.3425, -52.4549);
        var_4 = (47471, -192.634, -43.7394);
        var_4 = (48085.6, -358.42, 9.73944);
        var_5 = (359.802, 240.821, -3.32839);
        var_5 = (0.975088, 240.828, 0.322594);
        var_5 = (6.15886, 241.028, 2.20885);
        var_4 = (44528.7, -5376.79, 283.824);
        var_4 = (43628, -5846.41, 346.636);
        var_5 = (357.74, 256.16, -1.56165);
        var_5 = (0.506229, 241.181, 0.438595);
      } else if(var_0 == "tac_rover") {
        var_6 = (47872.6, -22645.4, -385.49);
        var_6 = (48501.7, -22505, -382.243);
        GscBinSkip0(0x2e, var_7.size, (1.68464, 109.9, -3.26246));
      }

      break;
    case "mp_port2_gw":
      if(var_0 == "atv") {
        var_4 = (31381.3, -35260.4, -566.754);
        var_4 = (31087.5, -35307.9, -566.206);
        var_5 = (0, 106, 0);
        var_5 = (0, 91, 0);
        var_4 = (37273.8, -22647.6, -566);
        var_4 = (38224.6, -23864.4, -566);
        var_5 = (0, 225, 0);
        var_5 = (0, 225, 0);
        var_4 = (37183.4, -15816, -558.929);
        var_4 = (36704.9, -15941.1, -558);
        var_4 = (37630.9, -15950.5, -564);
        var_5 = (0, 270, 0);
        var_5 = (0, 270, 0);
        var_5 = (0, 270, 0);
        var_4 = (34323.3, -25831.8, -566);
        var_5 = (0, 45, 0);
      } else if(var_0 == "tac_rover") {
        var_6 = (31412.5, -34658.3, -564.862);
        var_6 = (31042.3, -16171.6, -565.383);
        GscBinSkip0(0x2e, var_7.size, (0, 105, 0));
      }

      break;
    case "mp_boneyard_gw":
      if(var_0 == "atv") {
        var_4 = (-28937.7, -17197.8, -246.637);
        var_4 = (-29175.8, -17121.9, -247.909);
        var_4 = (-28096.5, -16918.8, -246.085);
        var_5 = (1.203, 90, 0.12);
        var_5 = (0.597, 90, 0.15);
        var_5 = (358.68, 90.0277, -0.8);
        var_4 = (-25926, -12688.6, -89.5073);
        var_4 = (-24872.9, -12661.3, -65.0808);
        var_5 = (5.13576, 104.619, 0.240957);
        var_5 = (358.169, 15, -3.49767);
        var_4 = (-28315.5, -3152.67, -311.293);
        var_4 = (-28107.5, -3152.67, -311.293);
        var_4 = (-27778.8, -3591.73, -310.621);
        var_5 = (0.061, 270, 7.355);
        var_5 = (0.061, 270, 7.355);
        var_5 = (0, 270, 0);
        var_4 = (-25666, -8411.14, -47.9997);
        var_4 = (-26998.2, -9004.54, -40);
        var_5 = (358.715, 15.233, -10.279);
        var_5 = (0, 285, 0);
      } else if(var_0 == "tac_rover") {
        var_6 = (-28683.3, -16741.2, -249.16);
        var_6 = (-29128.7, -16577.6, -229.266);
        GscBinSkip0(0x2e, var_7.size, (359.734, 90.0021, -0.454));
      }

      break;
    case "mp_aniyah":
      break;
    case "mp_promenade_gw":
      if(var_0 == "atv") {
        var_4 = (-9606.95, -21527.2, -279.043);
        var_4 = (-10288.2, -20891.9, -356.989);
        var_4 = (-11011.4, -19877, -368.358);
        var_5 = (0, 200, 0);
        var_5 = (0, 222, 0);
        var_5 = (359.526, 210.007, -0.952);
        var_4 = (-13835.9, -23127.9, -278.639);
        var_4 = (-14327.9, -22160.8, -266.586);
        var_5 = (2.373, 210, 0);
        var_5 = (0.806, 194.929, 2.603);
        var_4 = (-21725.2, -26511, -152);
        var_4 = (-21577.7, -26755.1, -151.997);
        var_4 = (-21065.3, -27199.1, -148.746);
        var_5 = (0, 30, 0);
        var_5 = (0, 60, 0);
        var_5 = (5.079, 0.128, 1.453);
        var_4 = (-18873.3, -25796.5, -199.784);
        var_5 = (0, 30, 0);
      } else if(var_0 == "tac_rover") {
        var_6 = (-10912.6, -20079.6, -367);
        var_6 = (-10108.5, -21861.4, -287.271);
        GscBinSkip0(0x2e, var_7.size, (0, 196.996, 0));
      }

      break;
    case "mp_layover_gw":
      if(var_0 == "atv") {
        var_4 = (-3749, 16980, -262);
        var_4 = (-2971.9, 18898, -262);
        var_4 = (-2735.8, 16203, -262);
        var_5 = (0, 218, 0);
        var_5 = (0, 174, 0);
        var_5 = (0, 208, 0);
        var_4 = (-11894, 16161, -266);
        var_4 = (-11841, 15884, -266);
        var_5 = (0, 162, 0);
        var_5 = (0, 248, 0);
        var_4 = (-29137, 12868, -244);
        var_4 = (-29539, 12883, -252);
        var_4 = (-29040, 13706, -497);
        var_5 = (0, 0, 0);
        var_5 = (0, 0, 0);
        var_5 = (0, 5, 0);
        var_4 = (-19181, 16384, -263);
        var_4 = (-19650, 17253, 54);
        var_4 = (-19937, 16123, -261);
        var_5 = (0, 310, 0);
        var_5 = (0, 357, 0);
        var_5 = (0, 35, 0);
      } else if(var_0 == "tac_rover") {
        var_6 = (-3520, 17805, -262);
        var_6 = (-3892, 18566, -262);
        GscBinSkip0(0x2e, var_7.size, (0, 165, 0));
      }

      break;
    case "mp_riverside_gw":
      if(var_0 == "atv") {
        var_4 = (4103, 26076, 57);
        var_4 = (4247, 25021, -38);
        var_4 = (3517, 25981, 47);
        var_5 = (0, 143, 0);
        var_5 = (0, 189, 0);
        var_5 = (0, 103, 0);
        var_4 = (4989, 29842, 253);
        var_4 = (1725, 28703, 51);
        var_5 = (0, 162, 0);
        var_5 = (0, 141, 0);
        var_4 = (-6826, 33623, -46);
        var_4 = (-7642, 32168, -188);
        var_4 = (-6589, 32564, -82);
        var_5 = (3, 337, 0);
        var_5 = (0, 357, 0);
        var_5 = (0, 320, 0);
        var_4 = (-3326, 32657, 238);
        var_4 = (-2149, 33264, 253);
        var_5 = (0, 325, 0);
        var_5 = (0, 287, 0);
      } else if(var_0 == "tac_rover") {
        var_6 = (4157, 26465, 65);
        var_6 = (4628, 26545, 63);
        GscBinSkip0(0x2e, var_7.size, (0, 143, 0));
      }

      break;
    default:
      break;
  }

  level.check_for_moody_traversal = var_4;
  level.check_for_execution_allows = var_5;

  if(var_0 == "atv") {
    for(var_8 = 0; var_8 < var_4.size; var_8++) {
      if(var_8 <= var_4.size - 1) {
        var_9 = var_4[var_8];
        var_10 = var_5[var_8];
        var_11 = spawnStruct();
        var_11.origin = var_9;
        var_11.angles = var_10;
        var_11.targetname = var_0;
        var_11.vehicletype = var_1;
        var_2 = var_11;
      }
    }
  } else if(var_0 == "tac_rover") {
    for(var_8 = 0; var_8 < var_6.size; var_8++) {
      if(var_8 <= var_6.size - 1) {
        var_12 = var_6[var_8];
        var_13 = var_7[var_8];
        var_11 = spawnStruct();
        var_11.origin = var_12;
        var_11.angles = var_13;
        var_11.targetname = var_0;
        var_11.vehicletype = var_1;
        var_2 = var_11;
      }
    }
  }

  var_14 = "scr_brtdm_vehicle_" + var_0;

  for(var_15 = 0;; var_15++) {
    var_16 = var_14 + "_origin_" + var_15;
    var_17 = var_14 + "_angles_" + var_15;
    var_18 = (0, 0, 0);
    var_19 = getdvarvector(var_16, var_18);

    if(var_19 == (0, 0, 0)) {
      break;
    }

    var_11 = spawnStruct();
    var_11.origin = var_19;
    var_20 = (0, 0, 0);
    var_11.angles = getdvarvector(var_17, var_20);
    var_11.targetname = var_0;
    var_11.vehicletype = var_1;
    var_2 = var_11;
  }

  return var_2;
}

function vehiclespawn_littlebird(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("little_bird", var_2, var_1);
}

function vehiclespawn_atv(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("atv", var_2, var_1);
}

function vehiclespawn_cargotruck(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("cargo_truck", var_2, var_1);
}

function vehiclespawn_tacrover(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("tac_rover", var_2, var_1);
}

function vehiclespawn_jeep(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("jeep", var_2, var_1);
}

function play_nag_intro_vo(var_0) {
  var_1 = [];

  if(getdvarint("scr_brtdm_disable_radiant_vehicles", level.endsuperdisableweaponbr.ref_1196b["scr_brtdm_disable_radiant_vehicles"]) == 1) {
    return var_1;
  }

  foreach(var_3 in var_0) {
    if(distance2dsquared(var_3.origin, level.endsuperdisableweaponbr.circlecenter) < level.endsuperdisableweaponbr.gulagfadetoblackspectatorsofplayer * level.endsuperdisableweaponbr.gulagfadetoblackspectatorsofplayer) {
      var_1 = var_3;
    }
  }

  return var_1;
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.rushtimer = scripts\mp\utility\dvars::dvarintvalue("rushTimer", 1, 0, 1);
  level.rushtimeramount = scripts\mp\utility\dvars::dvarfloatvalue("rushTimerAmount", 45, 30, 120);
  level.sharedrushtimer = scripts\mp\utility\dvars::dvarfloatvalue("sharedRushTimer", 0, 0, 1);
  level.precappoints = scripts\mp\utility\dvars::dvarintvalue("preCapPoints", 0, 0, 1);
  level.caprate = scripts\mp\utility\dvars::dvarfloatvalue("capRate", 7.5, 1, 60);
  level.objectivescaler = scripts\mp\utility\dvars::dvarfloatvalue("objScalar", 2, 1, 10);
  level.spawn_lmg_soldiers_05 = scripts\mp\utility\dvars::dvarfloatvalue("holdAllTimer", 7.5, 0, 60);
}

function adjustroundendtimer() {
  wait 1;
  level.roundenddelay = 8;
}

function waittooverridegraceperiod() {
  scripts\mp\flags::gameflagwait("prematch_done");

  if(!level.unset_relic_lfo) {
    level.overrideingraceperiod = 1;
    return;
  }
}

function initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_dom_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_dom_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dom_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dom_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dom_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dom_spawn_secondary", 1, 1);
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn");
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("dom", var_0);
  scripts\mp\spawnlogic::registerspawnset("dom_fallback", var_1);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function getspawnpoint() {
  if(level.unset_relic_lfo) {
    var_0 = self.pers["team"];

    if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
      if(var_0 == game["attackers"]) {
        scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
        var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "start_attackers");
      } else {
        scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
        var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_1, undefined, "start_defenders");
      }
    } else {
      scripts\mp\spawnlogic::activatespawnset("normal", 1);
      var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_1, undefined, "fallback");
    }

    if(istrue(level.usesquadspawn) && istrue(self.squadspawnconfirmed)) {
      var_2 = self getspectatingplayer();

      if(isDefined(var_2) && isDefined(self.squadindex) && self.team == var_2.team && self.squadindex == var_2.squadindex) {
        var_1 = scripts\mp\spawnscoring::findteammatebuddyspawn(var_2);
      }
    }

    return var_1;
  }

  var_0 = self.pers["team"];
  var_3 = scripts\mp\utility\game::getotherteam(var_0)[0];

  if(level.usestartspawns) {
    scripts\mp\spawnlogic::setactivespawnlogic("StartSpawn", "Crit_Default");
    jumpiffalse(game["switchedsides"]) LOC_00000137;
    var_4 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_" + var_3 + "_start");
    var_1 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_4);
    goto LOC_00000155;
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("Domination", "Crit_Default");
    var_5 = getteamdompoints(var_4);
    var_6 = scripts\mp\utility\game::getotherteam(var_4)[0];
    var_7 = getteamdompoints(var_6);
    var_8 = scripts\mp\gametypes\dom::getpreferreddompoints(var_5, var_7, var_4, var_1);
    var_9 = [];
    GscBinSkip0(0x2e, "preferredDomPoints", var_8["preferred"]);
  }

  return var_9;
}

function getteamdompoints(var_0) {
  var_1 = [];

  foreach(var_3 in level.objectives) {
    if(var_3.ownerteam == var_0) {
      var_1 = var_3;
    }
  }

  return var_1;
}

function gettimesincedompointcapture(var_0) {
  return gettime() - var_0.capturetime;
}

function onplayerconnect(var_0) {
  var_0._domflageffect = [];
  var_0._domflagpulseeffect = [];
  var_0.ui_dom_securing = undefined;
  var_0.ui_dom_stalemate = undefined;
  thread onplayerspawned();
  var_0 thread scripts\mp\gametypes\obj_dom::ondisconnect();
  var_0.siegelatecomer = 1;

  if(level.unset_relic_lfo && isDefined(game["roundsPlayed"]) && game["roundsPlayed"] != 0 && !scripts\mp\flags::gameflag("prematch_done")) {
    thread ref_11aaf();
    return;
  }
}

function onplayerdisconnect(var_0) {
  for(;;) {
    var_0 waittill("disconnect");

    foreach(var_2 in var_0._domflageffect) {
      if(isDefined(var_2)) {
        var_2 delete();
      }
    }
  }
}

function onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned");
    scripts\mp\utility\stats::setextrascore0(0);

    if(isDefined(self.pers["captures"])) {
      scripts\mp\utility\stats::setextrascore0(self.pers["captures"]);
    }

    scripts\mp\utility\stats::setextrascore1(0);

    if(isDefined(self.pers["rescues"])) {
      scripts\mp\utility\stats::setextrascore1(self.pers["rescues"]);
    }
  }
}

function onplayerjointeam(var_0) {
  if(scripts\mp\utility\game::gamehasstarted()) {
    var_0.siegelatecomer = 1;
    return;
  }
}

function onspawnplayer() {
  level notify("spawned_player");
  thread scripts\mp\gametypes\dom::updatematchstatushintonspawn();
}

function checkallowspectating() {
  if(level.rushtimerteam == "none") {
    return;
  }

  if(!scripts\mp\utility\teams::getteamdata(level.rushtimerteam, "aliveCount")) {
    level.spectateoverride[level.rushtimerteam].allowenemyspectate = 1;
    scripts\mp\spectating::updatespectatesettings();
    return;
  }
}

function domflags() {
  level endon("game_ended");
  var_0 = getEntArray("flag_primary", "targetname");
  var_1 = getEntArray("flag_secondary", "targetname");

  if(var_0.size + var_1.size < 2) {
    return;
  }

  var_2 = "mp/siegeFlagPos.csv";
  var_3 = scripts\cp_mp\utility\game_utility::getmapname();
  var_4 = 1;

  for(var_5 = 2; var_5 < 11; var_5++) {
    var_6 = tablelookup(var_2, var_4, var_3, var_5);

    if(var_6 != "") {
      setflagpositions(var_5, float(var_6));
    }
  }

  var_7 = [];

  for(var_8 = 0; var_8 < var_0.size; var_8++) {
    var_7 = var_0[var_8];
  }

  for(var_8 = 0; var_8 < var_1.size; var_8++) {
    var_7 = var_1[var_8];
  }

  level.ref_11f45 = 3;
  setomnvar("ui_num_dom_flags", level.ref_11f45);

  if(level.ref_11f45 == 3) {
    foreach(var_10 in var_0) {
      var_10 scripts\mp\gametypes\dom::remapdomtriggerscriptlabel();
    }
  }

  level.objectives = [];

  for(var_8 = 0; var_8 < var_7.size; var_8++) {
    var_10 = var_7[var_8];

    if(level.ref_11f45 == 3) {
      if(var_10.script_label == "_d" || var_10.script_label == "_e") {
        continue;
      }
    }

    var_10.origin = getflagpos(var_10.script_label, var_10.origin);

    if(isDefined(var_10.target)) {
      var_12 = getEnt(var_10.target, "targetname");
    } else {
      var_12 = spawn("script_model", var_10.origin);
      var_12[0].angles = var_10.angles;
    }

    var_13 = scripts\mp\gameobjects::createuseobject("neutral", var_10, var_12, (0, 0, 100), 1, 1);
    var_13 scripts\mp\gameobjects::allowuse("enemy");
    var_13 scripts\mp\gameobjects::setusetime(level.caprate);

    if(isDefined(var_10.objectivekey)) {
      var_13.objectivekey = var_10.objectivekey;
    } else {
      var_13.objectivekey = var_13 scripts\mp\gameobjects::getlabel();
    }

    if(isDefined(var_10.iconname)) {
      var_13.iconname = var_10.iconname;
    } else {
      var_13.iconname = var_13 scripts\mp\gameobjects::getlabel();
    }

    var_13 scripts\mp\gameobjects::cancontestclaim(1);
    var_13.nousebar = 1;
    var_13.id = "domFlag";
    var_13.firstcapture = 1;
    var_13.prevteam = "neutral";
    var_13.flagcapsuccess = 0;
    var_13.playersrevived = 0;
    var_13.claimgracetime = level.caprate * 1000;
    var_13 scripts\mp\gameobjects::pinobjiconontriggertouch();
    var_14 = var_12[0].origin + (0, 0, 32);
    var_15 = var_12[0].origin + (0, 0, -32);
    var_16 = scripts\engine\trace::ray_trace(var_14, var_15, undefined, scripts\engine\trace::create_default_contents(1));
    var_17 = scripts\mp\gametypes\obj_dom::checkmapoffsets(var_13);
    var_13.baseeffectpos = var_16["position"] + var_17;
    var_18 = vectortoangles(var_16["normal"]);
    var_19 = scripts\mp\gametypes\obj_dom::checkmapfxangles(var_13, var_18);
    var_13.baseeffectforward = anglesToForward(var_19);
    var_13.noscriptable = 1;
    var_13.flagmodel = spawn("script_model", var_13.baseeffectpos);

    if(istrue(level.setplayerselfrevivingextrainfo)) {
      var_20 = "decor_halloween_scarecrow";
    } else {
      var_20 = "military_dom_flag_neutral";
    }

    var_13.flagmodel setModel(var_20);
    level.objectives[var_13.objectivekey] = var_13;
  }

  var_21 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_axis_start");
  var_22 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_allies_start");
  level.startpos["allies"] = var_22[0].origin;
  level.startpos["axis"] = var_21[0].origin;
  level.bestspawnflag = [];
  level.bestspawnflag["allies"] = scripts\mp\gametypes\obj_dom::getunownedflagneareststart("allies", undefined);
  level.bestspawnflag["axis"] = scripts\mp\gametypes\obj_dom::getunownedflagneareststart("axis", level.bestspawnflag["allies"]);
  scripts\mp\gametypes\dom::flagsetup();

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level scripts\engine\utility::ref_143a5("prematch_done", "start_mode_setup");
  }

  foreach(var_24 in level.objectives) {
    var_25 = scripts\mp\gametypes\obj_dom::getreservedobjid(var_24.objectivekey);
    var_24 scripts\mp\gameobjects::requestid(1, 1, var_25);
    var_24.onuse = &onuse;
    var_24.onbeginuse = &onbeginuse;
    var_24.onuseupdate = &onuseupdate;
    var_24.onenduse = &onenduse;
    var_24.oncontested = &oncontested;
    var_24.onuncontested = &onuncontested;
    var_24.onunoccupied = &onunoccupied;
    var_24.onpinnedstate = &onpinnedstate;
    var_24.onunpinnedstate = &onunpinnedstate;
    var_24.ref_138b2 = &ref_12093;
    var_24.stompprogressreward = &stompprogressreward;
    var_24 scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_target");
    var_24 scripts\mp\gameobjects::setvisibleteam("any");
    var_24 scripts\mp\gametypes\obj_dom::domflag_setneutral();
  }

  if(level.precappoints) {
    scripts\mp\gametypes\obj_dom::precap();
    return;
  }
}

function setneutral() {
  if(scripts\mp\gameobjects::getownerteam() == "neutral") {
    thread scripts\mp\gametypes\obj_dom::updateflagstate("idle", 0);
    return;
  }
}

function setflagpositions(var_0, var_1) {
  switch (var_0) {
    case 2:
      level.siege_a_xpos = var_1;
      break;
    case 3:
      level.siege_a_ypos = var_1;
      break;
    case 4:
      level.siege_a_zpos = var_1;
      break;
    case 5:
      level.siege_b_xpos = var_1;
      break;
    case 6:
      level.siege_b_ypos = var_1;
      break;
    case 7:
      level.siege_b_zpos = var_1;
      break;
    case 8:
      level.siege_c_xpos = var_1;
      break;
    case 9:
      level.siege_c_ypos = var_1;
      break;
    case 10:
      level.siege_c_zpos = var_1;
      break;
  }
}

function getflagpos(var_0, var_1) {
  var_2 = var_1;

  if(var_0 == "_a") {
    if(isDefined(level.siege_a_xpos) && isDefined(level.siege_a_ypos) && isDefined(level.siege_a_zpos)) {
      var_2 = (level.siege_a_xpos, level.siege_a_ypos, level.siege_a_zpos);
    }
  } else if(var_0 == "_b") {
    if(isDefined(level.siege_b_xpos) && isDefined(level.siege_b_ypos) && isDefined(level.siege_b_zpos)) {
      var_2 = (level.siege_b_xpos, level.siege_b_ypos, level.siege_b_zpos);
    }
  } else if(isDefined(level.siege_c_xpos) && isDefined(level.siege_c_ypos) && isDefined(level.siege_c_zpos)) {
    var_2 = (level.siege_c_xpos, level.siege_c_ypos, level.siege_c_zpos);
  }

  return var_2;
}

function watchflagtimerpause() {
  level endon("game_ended");

  for(;;) {
    level waittill("flag_capturing", var_0);

    if(level.rushtimer) {
      if(var_0.prevteam != "neutral") {
        var_1 = scripts\mp\utility\game::getotherteam(var_0.prevteam)[0];

        if(isDefined(level.siegetimerstate) && level.siegetimerstate != "pause" && !iswinningteam(var_1)) {
          level.gametimerbeeps = 0;
          level.siegetimerstate = "pause";
          pausecountdowntimer();

          if(!flagownersalive(var_0.prevteam)) {
            setwinner(var_1, tolower(game[var_0.prevteam]) + "_eliminated");
          }
        }
      }
    }
  }
}

function iswinningteam(var_0) {
  var_1 = 0;
  var_2 = getflagcount(var_0);

  if(level.ref_11f45 == 3) {
    if(var_2 == 2) {
      var_1 = 1;
    }
  } else if(var_2 >= 3) {
    var_1 = 1;
  }

  return var_1;
}

function flagownersalive(var_0) {
  var_1 = 0;

  foreach(var_3 in level.participants) {
    if(isDefined(var_3) && var_3.team == var_0 && (scripts\mp\utility\player::isreallyalive(var_3) || var_3.pers["lives"] > 0)) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

function pausecountdowntimer() {
  if(!level.timerstoppedforgamemode) {
    var_0 = level.rushtimeramount;

    if(isDefined(level.siegetimeleft)) {
      var_0 = level.siegetimeleft;
    }

    var_1 = int(gettime() + var_0 * 1000);
    scripts\mp\gamelogic::pausetimer(var_1);
  }

  level notify("siege_timer_paused");
}

function resumecountdowntimer(var_0) {
  var_1 = level.rushtimeramount;

  if(level.timerstoppedforgamemode) {
    if(isDefined(level.siegetimeleft)) {
      var_1 = level.siegetimeleft;
    }

    var_2 = int(gettime() + var_1 * 1000);
    setgameendtime(var_2);
    scripts\mp\gamelogic::resumetimer(var_2);

    if(!isDefined(level.siegetimerstate) || level.siegetimerstate == "pause") {
      level.siegetimerstate = "start";
    }

    thread watchgametimer(var_1);

    if(istrue(var_0)) {
      if(level.siegeflagcapturing.size > 0) {
        level notify("flag_capturing", self);
        return;
      }

      return;
    }

    return;
  }
}

function watchflagenduse(var_0) {
  level endon("game_ended");
  var_1 = 0;
  var_2 = 0;
  var_3 = level.rushtimerteam;
  var_1 = getflagcount("allies");
  var_2 = getflagcount("axis");

  if(level.rushtimer && level.rushtimerteam != "none") {
    if(level.sharedrushtimer || var_1 == 1 && var_2 == 1) {
      level.siegetimerstate = "start";
      notifyplayers("siege_timer_start");
      resumecountdowntimer(1);
      return;
    }
  }

  if(var_1 == level.ref_11f45) {
    setwinner("allies", "siege_allflags_win", "siege_allflags_loss");
  } else if(var_2 == level.ref_11f45) {
    setwinner("axis", "siege_allflags_win", "siege_allflags_loss");
  } else if(level.rushtimer) {
    if(var_1 == 2 || var_2 == 2) {
      level.rushtimerteam = scripts\engine\utility::ter_op(var_1 > var_2, "allies", "axis");

      if(var_3 != level.rushtimerteam) {
        if(isDefined(level.siegetimerstate) && level.siegetimerstate != "reset") {
          level.gametimerbeeps = 0;
          level.siegetimeleft = undefined;
          level.siegetimerstate = "reset";
          notifyplayers("siege_timer_reset");
        }

        if(!isDefined(level.siegetimerstate) || level.siegetimerstate != "start") {
          var_4 = level.rushtimeramount;

          if(isDefined(level.siegetimeleft)) {
            var_4 = level.siegetimeleft;
          }

          var_5 = int(gettime() + var_4 * 1000);
          level.timelimitoverride = 1;
          scripts\mp\gamelogic::pausetimer(var_5);
          setgameendtime(var_5);
          scripts\mp\gamelogic::resumetimer(var_5);

          if(!isDefined(level.siegetimerstate) || level.siegetimerstate == "pause") {
            level.siegetimerstate = "start";
            notifyplayers("siege_timer_start");
          }

          if(!level.gametimerbeeps) {
            thread watchgametimer(var_4);
          }
        }
      } else if(var_3 == level.rushtimerteam && var_1 == 1 || var_3 == level.rushtimerteam && var_2 == 1) {
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
  var_0 = getdvarfloat("scr_siege_timelimit");

  if(var_0 > 0) {
    var_1 = var_0 - 1;

    while(var_1 > 0) {
      var_1 -= 1;
      wait 1;
    }

    level.siegegameinactive = 1;
    return;
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
    foreach(var_1 in level.teamnamelist) {
      if(!scripts\mp\utility\teams::getteamdata(var_1, "hasSpawned")) {
        return false;
      }
    }

    return true;
  }

  return level.maxplayercount > 1;
}

function watchgametimer(var_0) {
  level endon("game_ended");
  level endon("siege_timer_paused");
  level endon("siege_timer_reset");
  var_1 = var_0;
  var_2 = spawn("script_origin", (0, 0, 0));
  var_2 hide();
  level.gametimerbeeps = 1;

  while(var_1 > 0) {
    var_1 -= 1;
    level.siegetimeleft = var_1;

    if(var_1 <= 30) {
      if(var_1 != 0) {
        var_2 playSound("ui_mp_timer_countdown");
      }
    }

    wait 1;
  }

  ontimelimit();
}

function getflagcount(var_0) {
  var_1 = 0;

  foreach(var_3 in level.objectives) {
    if(var_3.ownerteam == var_0 && !isbeingcaptured(var_3)) {
      var_1 += 1;
    }
  }

  return var_1;
}

function isbeingcaptured(var_0) {
  var_1 = 0;

  if(isDefined(var_0)) {
    if(level.siegeflagcapturing.size > 0) {
      foreach(var_3 in level.siegeflagcapturing) {
        if(var_0.objectivekey == var_3) {
          var_1 = 1;
        }
      }
    }
  }

  return var_1;
}

function setwinner(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(!isai(var_4)) {
      var_4 setclientomnvar("ui_objective_state", 0);
    }
  }

  if(isDefined(var_2)) {
    thread scripts\mp\gamelogic::endgame(var_0, game["end_reason"][var_1], game["end_reason"][var_2]);
    return;
  }

  thread scripts\mp\gamelogic::endgame(var_0, game["end_reason"][var_1]);
}

function onbeginuse(var_0) {
  if(!scripts\engine\utility::array_contains(level.siegeflagcapturing, self.objectivekey)) {
    level.siegeflagcapturing[level.siegeflagcapturing.size] = self.objectivekey;
    var_1 = scripts\mp\gameobjects::getownerteam();
    var_0 setclientomnvar("ui_objective_state", 1);
    self.didstatusnotify = 0;
    scripts\mp\gameobjects::setusetime(level.caprate);
  }

  level notify("flag_capturing", self);
}

function onuse(var_0) {
  self.didstatusnotify = 0;
  var_1 = var_0.team;
  var_2 = scripts\mp\gameobjects::getownerteam();
  var_3 = scripts\mp\utility\game::getotherteam(var_1)[0];
  self.capturetime = gettime();
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  thread scripts\mp\gametypes\obj_dom::updateflagstate(var_1, 0, var_1);
  scripts\mp\gametypes\obj_dom::setflagcaptured(var_1, var_2, var_0);
  level.usestartspawns = 0;

  if(var_2 == "neutral") {
    var_4 = scripts\mp\gametypes\obj_dom::getteamflagcount(var_1);

    if(var_4 < level.objectives.size) {
      if(var_4 == 2 && level.ref_11f45 == 3) {
        scripts\mp\utility\dialog::statusdialog("friendly_captured_2", var_1);
        scripts\mp\utility\dialog::statusdialog("enemy_captured_2", var_3, 1);
      } else {
        scripts\mp\utility\dialog::statusdialog("secured" + self.objectivekey, var_1);
        scripts\mp\utility\dialog::statusdialog("lost" + self.objectivekey, var_3, 1);
      }
    }
  }

  if(scripts\mp\gametypes\obj_dom::getteamflagcount(var_1) == level.objectives.size) {
    var_5 = "mp_dom_flag_captured_all";
  } else {
    var_5 = "mp_dom_flag_captured";
  }

  thread scripts\mp\utility\print::printandsoundoneveryone(var_2, var_5, undefined, undefined, var_5, "mp_dom_flag_lost", var_1);
  thread giveflagcapturexp(self.touchlist[var_2], var_3, var_1);
  self.firstcapture = 0;

  if(scripts\mp\utility\teams::isgameplayteam(var_2)) {
    if(level.teamdata[var_2]["aliveCount"] < level.teamdata[var_2]["players"].size) {
      foreach(var_7 in level.teamdata[var_2]["players"]) {
        var_7 playlocalsound("mp_bodycount_tick_positive");
      }

      var_9 = scripts\mp\utility\teams::getenemyplayers(var_2);

      foreach(var_7 in var_9) {
        var_7 playlocalsound("mp_bodycount_tick_negative");
      }
    }
  }

  thread getquickdropitemcount(var_2);
}

function onuseupdate(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\gameobjects::getownerteam();

  if(var_1 < 1 && !level.gameended && !istrue(self.captureblocked)) {
    play_dom_capture_sfx(var_1, var_0);
  }

  if(var_1 > 0.05 && var_2 && !self.didstatusnotify) {
    if(var_4 == "neutral") {
      scripts\mp\utility\dialog::statusdialog("securing" + self.objectivekey, var_0);
      self.prevownerteam = scripts\mp\utility\game::getotherteam(var_0)[0];
    } else {
      scripts\mp\utility\dialog::statusdialog("losing" + self.objectivekey, var_4, 1);
      scripts\mp\utility\dialog::statusdialog("securing" + self.objectivekey, var_0);
    }

    if(!isagent(var_3)) {
      scripts\mp\gametypes\obj_dom::updateflagcapturestate(var_0);
    }

    scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosing, level.icontaking);
    self.didstatusnotify = 1;
  }

  level notify("flag_capturing", self);
}

function getquickdropitemcount(var_0) {
  var_1 = 0;
  var_2 = getflagcount(var_0);

  if(level.ref_11f45 == 3) {
    if(var_2 == 2) {
      var_1 = 1;
    }
  } else if(var_2 == 4) {
    var_1 = 1;
  }

  if(var_1) {
    thread scripts\mp\music_and_dialog::dominating_music(var_0);
    return;
  }
}

function play_dom_capture_sfx(var_0, var_1) {
  if(!isDefined(self.lastsfxplayedtime)) {
    self.lastsfxplayedtime = gettime();
  }

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var_2 = "";
    var_0 = int(floor(var_0 * 10));
    var_2 = "mp_dom_capturing_tick_0" + var_0;
    self.visuals[0] playsoundtoteam(var_2, var_1);
    return;
  }
}

function onenduse(var_0, var_1, var_2) {
  self.didstatusnotify = 0;

  if(isPlayer(var_1)) {
    var_1 setclientomnvar("ui_objective_state", 0);
    var_1.ui_dom_securing = undefined;
  }

  if(var_2) {
    self.flagcapsuccess = 1;
  } else {
    self.flagcapsuccess = 0;
    resumecountdowntimer();
  }

  var_3 = scripts\mp\gameobjects::getownerteam();

  if(var_3 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    scripts\mp\gametypes\obj_dom::updateflagstate("idle", 0);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    scripts\mp\gametypes\obj_dom::updateflagstate(var_3, 0);
  }

  if(!istrue(self.setblocking) && !istrue(self.stalemate)) {
    level.siegeflagcapturing = scripts\engine\utility::array_remove(level.siegeflagcapturing, self.objectivekey);
  }

  thread ref_14393();
}

function ref_14393() {
  waitframe();
  checkendgame();
}

function oncontested() {
  if(!scripts\engine\utility::array_contains(level.siegeflagcapturing, self.objectivekey)) {
    level.siegeflagcapturing[level.siegeflagcapturing.size] = self.objectivekey;
  }

  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontested);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  scripts\mp\gametypes\obj_dom::updateflagstate("contested", 0);

  if(level.rushtimerteam == self.ownerteam) {
    resumecountdowntimer();
    return;
  }
}

function onuncontested(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = scripts\mp\gameobjects::getnumtouchingforteam(var_1);
  var_3 = scripts\mp\gameobjects::getnumtouchingexceptteam(var_1);

  if(var_2 && !var_3) {
    level.siegeflagcapturing = scripts\engine\utility::array_remove(level.siegeflagcapturing, self.objectivekey);
  }

  thread ref_14393();

  if(var_1 == "neutral") {
    if(var_0 != "none") {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_0);
    } else {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
    }
  } else {
    scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, scripts\mp\utility\game::getotherteam(var_1)[0]);
  }

  if(var_0 == "none" || var_1 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    self.didstatusnotify = 0;
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  }

  var_4 = scripts\engine\utility::ter_op(var_1 == "neutral", "idle", var_1);
  scripts\mp\gametypes\obj_dom::updateflagstate(var_4, 0);
}

function onunoccupied() {
  var_0 = scripts\mp\gameobjects::getownerteam();
  level.siegeflagcapturing = scripts\engine\utility::array_remove(level.siegeflagcapturing, self.objectivekey);
  thread ref_14393();

  if(var_0 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    self.didstatusnotify = 0;
    return;
  }

  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
}

function onpinnedstate(var_0) {
  if(self.ownerteam != "neutral" && self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
    return;
  }
}

function onunpinnedstate(var_0) {
  if(self.ownerteam != "neutral" && !self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  }

  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = scripts\mp\gameobjects::getnumtouchingforteam(var_1);
  var_3 = scripts\mp\gameobjects::getnumtouchingexceptteam(var_1);

  if(var_2 && !var_3) {
    level.siegeflagcapturing = scripts\engine\utility::array_remove(level.siegeflagcapturing, self.objectivekey);
  }

  thread ref_14393();
}

function ref_12093(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = scripts\mp\gameobjects::getnumtouchingforteam(var_1);
  var_3 = scripts\mp\gameobjects::getnumtouchingexceptteam(var_1);

  if(var_2 && !var_3) {
    level.siegeflagcapturing = scripts\engine\utility::array_remove(level.siegeflagcapturing, self.objectivekey);
  }

  if(level.rushtimerteam == self.ownerteam) {
    resumecountdowntimer();
    return;
  }

  resumecountdowntimer(1);
}

function stompprogressreward(var_0) {
  var_0 thread scripts\mp\rank::scoreeventpopup("defend");
  var_0 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
}

function ondeadevent(var_0) {
  if(scripts\mp\utility\game::gamehasstarted()) {
    if(var_0 == "all") {
      ontimelimit();
      return;
    }

    if(var_0 == game["attackers"]) {
      if(level.rushtimer && getflagcount(var_0) == 2) {
        return;
      }

      setwinner(game["defenders"], tolower(game[game["attackers"]]) + "_eliminated");
      return;
    }

    if(var_0 == game["defenders"]) {
      if(level.rushtimer && getflagcount(var_0) == 2) {
        return;
      }

      setwinner(game["attackers"], tolower(game[game["defenders"]]) + "_eliminated");
      return;
    }

    return;
  }
}

function ononeleftevent(var_0) {
  var_1 = scripts\mp\utility\game::getlastlivingplayer(var_0);
  thread givelastonteamwarning();
}

function onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(self.ref_14437)) {
    self.ref_14437 = undefined;
  }

  if(!isPlayer(var_1) || var_1.team == self.team) {
    return;
  }

  if(!flagownersalive(self.team) && scripts\mp\gametypes\obj_dom::getteamflagcount(self.team) == 2) {
    scripts\mp\utility\dialog::statusdialog("objs_capture", var_1.team, 1);
  }

  var_10 = 0;
  var_11 = 0;
  var_12 = 0;
  var_13 = self;
  var_14 = var_13.team;
  var_15 = var_13.origin;
  var_16 = var_1.team;
  var_17 = var_1.origin;
  var_18 = 0;

  if(isDefined(var_0)) {
    var_17 = var_0.origin;
    var_18 = var_0 == var_1;
  }

  foreach(var_20 in var_1.touchtriggers) {
    var_21 = undefined;

    foreach(var_23 in level.objectives) {
      if(var_23.trigger == var_20) {
        var_21 = var_23;
        break;
      }
    }

    if(!isDefined(var_21)) {
      continue;
    }

    var_25 = var_21.ownerteam;

    if(var_16 != var_25) {
      if(!var_10) {
        var_10 = 1;
      }
    }
  }

  foreach(var_21 in level.objectives) {
    var_20 = var_21.trigger;
    var_25 = var_21.ownerteam;

    if(var_25 == "neutral") {
      var_28 = var_1 istouching(var_20);
      var_29 = var_13 istouching(var_20);

      if(var_28 || var_29) {
        if(var_21.claimteam == var_14) {
          if(!var_11) {
            if(var_10) {
              var_1 thread scripts\mp\utility\points::giveunifiedpoints("capture_kill");
            } else {
              var_1 thread scripts\mp\rank::scoreeventpopup("assault");
              var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
            }

            var_11 = 1;
            thread scripts\common\utility::ref_13e0a(level.ref_11b26, var_9, "assaulting");
            continue;
          }
        } else if(var_21.claimteam == var_16) {
          if(!var_12) {
            if(var_10) {
              var_1 thread scripts\mp\utility\points::giveunifiedpoints("capture_kill");
            } else {
              var_1 thread scripts\mp\rank::scoreeventpopup("defend");
              var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
            }

            var_12 = 1;
            var_1 scripts\mp\utility\stats::incpersstat("defends", 1);
            var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
            thread scripts\common\utility::ref_13e0a(level.ref_11b26, var_9, "defending");
            continue;
          }
        }
      }

      continue;
    }

    if(var_25 != var_16) {
      if(!var_11) {
        var_30 = distsquaredcheck(var_20, var_17, var_15);

        if(var_30) {
          if(var_10) {
            var_1 thread scripts\mp\utility\points::giveunifiedpoints("capture_kill");
          } else {
            var_1 thread scripts\mp\rank::scoreeventpopup("assault");
            var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
          }

          var_11 = 1;
          thread scripts\common\utility::ref_13e0a(level.ref_11b26, var_9, "assaulting");
          continue;
        }
      }

      continue;
    }

    if(!var_12) {
      var_31 = distsquaredcheck(var_20, var_17, var_15);

      if(var_31) {
        if(var_10) {
          var_1 thread scripts\mp\utility\points::giveunifiedpoints("capture_kill");
        } else {
          var_1 thread scripts\mp\rank::scoreeventpopup("defend");
          var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
        }

        var_12 = 1;
        var_1 scripts\mp\utility\stats::incpersstat("defends", 1);
        var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
        thread scripts\common\utility::ref_13e0a(level.ref_11b26, var_9, "defending");
      }
    }
  }

  thread checkallowspectating();
}

function distsquaredcheck(var_0, var_1, var_2) {
  var_3 = distancesquared(var_0.origin, var_1);
  var_4 = distancesquared(var_0.origin, var_2);

  if(var_3 < 105625 || var_4 < 105625) {
    if(!isDefined(var_0.modifieddefendcheck)) {
      return 1;
    }

    if(var_1[2] - var_0.origin[2] < 100 || var_2[2] - var_0.origin[2] < 100) {
      return 1;
    }

    return 0;
  }

  return 0;
}

function givelastonteamwarning() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\mp\utility\player::waittillrecoveredhealth(3);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "inform_last_one");
  var_0 = scripts\mp\utility\game::getotherteam(self.pers["team"])[0];
  level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
  level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastenemyalive", self, var_0);
  level notify("last_alive", self);
}

function ontimelimit() {
  if(isDefined(level.siegegameinactive)) {
    level.forcedend = 1;
    thread scripts\mp\gamelogic::endgame("none", game["end_reason"]["siege_force_end"]);
    return;
  }

  var_0 = getflagcount("allies");
  var_1 = getflagcount("axis");

  if(var_0 > var_1) {
    setwinner("allies", "siege_flag_win", "siege_flag_loss");
    return;
  }

  if(var_1 > var_0) {
    setwinner("axis", "siege_flag_win", "siege_flag_loss");
    return;
  }

  setwinner("tie", "cyber_tie");
}

function teamrespawn(var_0, var_1) {
  var_2 = scripts\mp\utility\teams::getteamdata(var_1.team, "teamCount");

  if(!isDefined(var_1.rescuedplayers)) {
    var_1.rescuedplayers = [];
  }

  foreach(var_4 in level.participants) {
    if(isDefined(var_4) && var_4.team == var_0 && !scripts\mp\utility\player::isreallyalive(var_4) && !scripts\engine\utility::array_contains(scripts\mp\utility\teams::getfriendlyplayers(var_4.team, 1), var_4) && (!isDefined(var_4.waitingtoselectclass) || !var_4.waitingtoselectclass)) {
      if(isDefined(var_4.siegelatecomer) && var_4.siegelatecomer) {
        var_4.siegelatecomer = 0;
      }

      if(!istrue(var_4.pers["teamKillPunish"])) {
        if(istrue(var_4.ref_14437)) {
          continue;
        }

        var_4.ref_14437 = 1;
        var_4 thread scripts\mp\playerlogic::waittillcanspawnclient(0);
        var_4 thread scripts\mp\rank::scoreeventpopup("revived");
        level notify("sr_player_respawned", var_4);
        var_4 scripts\mp\utility\dialog::leaderdialogonplayer("revived");
      }

      var_1.rescuedplayers[var_4.guid] = 1;
    }
  }

  self.playersrevived = var_1.rescuedplayers.size;
}

function notifyplayers(var_0) {
  foreach(var_2 in level.players) {
    var_2 thread scripts\mp\hud_message::showsplash(var_0);
  }

  level notify("match_ending_soon", "time");
  level notify(var_0);
}

function giveflagcapturexp(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = var_2;

  if(isDefined(var_3.owner)) {
    var_3 = var_3.owner;
  }

  level.lastcaptime = gettime();

  if(isPlayer(var_3)) {
    level thread scripts\mp\hud_util::teamplayercardsplash("callout_securedposition" + self.objectivekey, var_3);
    var_3 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "capture", var_3.origin);
  }

  var_4 = getarraykeys(var_0);

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_6 = var_0[var_4[var_5]].player;

    if(isDefined(var_6.owner)) {
      var_6 = var_6.owner;
    }

    if(!isPlayer(var_6)) {
      continue;
    }

    thread updatecpm();

    if(var_6.cpm > 3) {
      var_7 = 0;
      var_8 = 0;
    } else if(var_6.numcaps > 5) {
      var_7 = 125;
      var_8 = 50;
    } else if(self.objectivekey == "_b" || var_1 != "neutral" || self.playersrevived > 0) {
      var_7 = undefined;
      var_8 = undefined;
    } else {
      var_7 = 125;
      var_8 = 50;
    }

    var_6 thread scripts\mp\rank::scoreeventpopup("capture");
    var_6 thread scripts\mp\awards::givemidmatchaward("mode_siege_secure", var_8, var_7);
    var_6 scripts\mp\utility\stats::incpersstat("captures", 1);
    var_6 scripts\mp\persistence::statsetchild("round", "captures", var_6.pers["captures"]);
    var_6 scripts\mp\utility\stats::setextrascore0(var_6.pers["captures"]);
    var_6 scripts\mp\utility\stats::incpersstat("rescues", self.playersrevived);
    var_6 scripts\mp\persistence::statsetchild("round", "rescues", var_6.pers["rescues"]);
    var_6 scripts\mp\utility\stats::setextrascore1(var_6.pers["rescues"]);
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

  if(scripts\mp\utility\game::getminutespassed() < 1) {
    return;
  }

  self.cpm = self.numcaps / scripts\mp\utility\game::getminutespassed();
}

function checkendgame() {
  var_0 = getflagcount("allies");
  var_1 = getflagcount("axis");

  if(var_0 == level.ref_11f45) {
    setwinner("allies", "siege_allflags_win", "siege_allflags_loss");
    return;
  }

  if(var_1 == level.ref_11f45) {
    setwinner("axis", "siege_allflags_win", "siege_allflags_loss");
    return;
  }
}

function runobjectives(var_0) {
  level.axisspawnareas = [level.axishqname];
  level.alliesspawnareas = [level.allieshqname];
  level.allfobs = [];

  foreach(var_2 in level.gw_objstruct.startingfobs_axis) {
    var_3 = runobjflag(var_2.trigger, "axis");
    level.allfobs[level.allfobs.size] = var_2;
    level.axisspawnareas[level.axisspawnareas.size] = var_2.name;

    if(isDefined(level.spawnselectionlocations[var_2.name]["axis"].anchorentity)) {
      level.spawnselectionlocations[var_2.name]["axis"].anchorentity.origin = var_2.trigger.origin + (0, 0, 100);
    }
  }

  foreach(var_2 in level.gw_objstruct.startingfobs_allies) {
    var_3 = runobjflag(var_2.trigger, "allies");
    level.allfobs[level.allfobs.size] = var_2;
    level.alliesspawnareas[level.alliesspawnareas.size] = var_2.name;

    if(isDefined(level.spawnselectionlocations[var_2.name]["allies"].anchorentity)) {
      level.spawnselectionlocations[var_2.name]["allies"].anchorentity.origin = var_2.trigger.origin + (0, 0, 100);
    }
  }

  foreach(var_2 in level.gw_objstruct.startingfobs_neutral) {
    if(level.ref_11f45 == 3) {
      if(level.mapname == "mp_downtown_gw") {
        if(var_2.trigger.objkey == "_a" || var_2.trigger.objkey == "_e") {
          continue;
        } else {
          ref_12bbd(var_2.trigger);
        }
      } else if(level.mapname == "mp_aniyah") {
        if(var_2.trigger.objkey == "_b" || var_2.trigger.objkey == "_d") {
          continue;
        } else {
          ref_12bbd(var_2.trigger);
        }
      } else if(level.mapname == "mp_farms2_gw") {
        if(var_2.trigger.objkey == "_b" || var_2.trigger.objkey == "_d") {
          continue;
        } else {
          ref_12bbd(var_2.trigger);
        }
      } else if(level.mapname == "mp_promenade_gw") {
        if(var_2.trigger.objkey == "_a" || var_2.trigger.objkey == "_e") {
          continue;
        } else {
          ref_12bbd(var_2.trigger);
        }
      } else if(level.mapname == "mp_riverside_gw") {
        if(var_2.trigger.objkey == "_b" || var_2.trigger.objkey == "_d") {
          continue;
        } else {
          ref_12bbd(var_2.trigger);
        }
      } else if(var_2.trigger.objkey == "_a" || var_2.trigger.objkey == "_e") {
        continue;
      } else {
        ref_12bbd(var_2.trigger);
      }
    }

    var_3 = runobjflag(var_2.trigger, "neutral");
    level.allfobs[level.allfobs.size] = var_2;
  }

  var_9 = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_axis_start");
  var_10 = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_allies_start");
  level.startpos["allies"] = var_10[0].origin;
  level.startpos["axis"] = var_9[0].origin;

  foreach(var_2 in level.allfobs) {
    var_12 = scripts\mp\gametypes\obj_dom::getreservedobjid(var_2.trigger.gameobject.objectivekey);
    var_2.trigger.gameobject scripts\mp\gameobjects::requestid(1, 1, var_12);
    var_2.trigger.gameobject.onuse = &onuse;
    var_2.trigger.gameobject.onbeginuse = &onbeginuse;
    var_2.trigger.gameobject.onuseupdate = &onuseupdate;
    var_2.trigger.gameobject.onenduse = &onenduse;
    var_2.trigger.gameobject.oncontested = &oncontested;
    var_2.trigger.gameobject.onuncontested = &onuncontested;
    var_2.trigger.gameobject.onunoccupied = &onunoccupied;
    var_2.trigger.gameobject.onpinnedstate = &onpinnedstate;
    var_2.trigger.gameobject.onunpinnedstate = &onunpinnedstate;
    var_2.trigger.gameobject.ref_138b2 = &ref_12093;
    var_2.trigger.gameobject.stompprogressreward = &stompprogressreward;
    var_2.trigger.gameobject scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_target");
    var_2.trigger.gameobject scripts\mp\gameobjects::setvisibleteam("any");
    var_2.trigger.gameobject scripts\mp\gametypes\obj_dom::domflag_setneutral();
    level.objectives[var_2.trigger.gameobject.objectivekey] = var_2.trigger.gameobject;
  }

  level.bestspawnflag = [];
  level.bestspawnflag["allies"] = scripts\mp\gametypes\obj_dom::getunownedflagneareststart("allies", undefined);
  level.bestspawnflag["axis"] = scripts\mp\gametypes\obj_dom::getunownedflagneareststart("axis", level.bestspawnflag["allies"]);

  if(level.precappoints) {
    scripts\mp\gametypes\obj_dom::precap(level.ref_11f45 == 5);
  }

  scripts\mp\gametypes\dom::flagsetup();
  thread objective_manageobjectivesintrovisibility();
  level thread scripts\mp\gametypes\arm::brking_getspawnpoint();
}

function objective_manageobjectivesintrovisibility() {
  wait 1;

  foreach(var_1 in level.allfobs) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_1.trigger.gameobject.objidnum);
  }

  while(!scripts\mp\flags::gameflag("prematch_done")) {
    waitframe();
  }

  foreach(var_1 in level.allfobs) {
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_1.trigger.gameobject.objidnum);
  }
}

function ref_12bbd(var_0) {
  if(level.mapname == "mp_downtown_gw") {
    if(var_0.objkey == "_b" && !isDefined(var_0.ref_11fcb)) {
      var_0.ref_11fcb = "_a";
      var_0.objkey = "_a";
      var_0.script_label = var_0.objkey;
      return;
    }

    if(var_0.objkey == "_c" && !isDefined(var_0.ref_11fcb)) {
      var_0.ref_11fcb = "_c";
      var_0.objkey = "_b";
      var_0.script_label = var_0.objkey;
      return;
    }

    if(var_0.objkey == "_d" && !isDefined(var_0.ref_11fcb)) {
      var_0.ref_11fcb = "_d";
      var_0.objkey = "_c";
      var_0.script_label = var_0.objkey;
      return;
    }

    return;
  }

  if(level.mapname == "mp_boneyard_gw") {
    if(var_0.objkey == "_b" && !isDefined(var_0.ref_11fcb)) {
      var_0.ref_11fcb = "_b";
      var_0.objkey = "_a";
      var_0.script_label = var_0.objkey;
      return;
    }

    if(var_0.objkey == "_d" && !isDefined(var_0.ref_11fcb)) {
      var_0.ref_11fcb = "_d";
      var_0.objkey = "_b";
      var_0.script_label = var_0.objkey;
      return;
    }

    if(var_0.objkey == "_c" && !isDefined(var_0.ref_11fcb)) {
      var_0.ref_11fcb = "_c";
      var_0.objkey = "_c";
      var_0.script_label = var_0.objkey;
      return;
    }

    return;
  }

  if(level.mapname == "mp_aniyah") {
    if(var_0.objkey == "_a" && !isDefined(var_0.ref_11fcb)) {
      var_0.ref_11fcb = "_a";
      var_0.objkey = "_a";
      var_0.script_label = var_0.objkey;
      return;
    }

    if(var_0.objkey == "_c" && !isDefined(var_0.ref_11fcb)) {
      var_0.ref_11fcb = "_c";
      var_0.objkey = "_b";
      var_0.script_label = var_0.objkey;
      return;
    }

    if(var_0.objkey == "_e" && !isDefined(var_0.ref_11fcb)) {
      var_0.ref_11fcb = "_e";
      var_0.objkey = "_c";
      var_0.script_label = var_0.objkey;
      return;
    }

    return;
  }

  if(level.mapname == "mp_promenade_gw") {
    if(var_0.objkey == "_b" && !isDefined(var_0.ref_11fcb)) {
      var_0.ref_11fcb = "_b";
      var_0.objkey = "_a";
      var_0.script_label = var_0.objkey;
      return;
    }

    if(var_0.objkey == "_c" && !isDefined(var_0.ref_11fcb)) {
      var_0.ref_11fcb = "_c";
      var_0.objkey = "_b";
      var_0.script_label = var_0.objkey;
      return;
    }

    if(var_0.objkey == "_d" && !isDefined(var_0.ref_11fcb)) {
      var_0.ref_11fcb = "_e";
      var_0.objkey = "_c";
      var_0.script_label = var_0.objkey;
      return;
    }

    return;
  }

  if(level.mapname == "mp_farms2_gw") {
    if(var_0.objkey == "_a" && !isDefined(var_0.ref_11fcb)) {
      var_0.ref_11fcb = "_a";
      var_0.objkey = "_a";
      var_0.script_label = var_0.objkey;
      return;
    }

    if(var_0.objkey == "_c" && !isDefined(var_0.ref_11fcb)) {
      var_0.ref_11fcb = "_c";
      var_0.objkey = "_b";
      var_0.script_label = var_0.objkey;
      return;
    }

    if(var_0.objkey == "_e" && !isDefined(var_0.ref_11fcb)) {
      var_0.ref_11fcb = "_e";
      var_0.objkey = "_c";
      var_0.script_label = var_0.objkey;
      return;
    }

    return;
  }

  if(level.mapname == "mp_riverside_gw") {
    if(var_0.objkey == "_a" && !isDefined(var_0.ref_11fcb)) {
      var_0.ref_11fcb = "_a";
      var_0.objkey = "_a";
      var_0.script_label = var_0.objkey;
      return;
    }

    if(var_0.objkey == "_c" && !isDefined(var_0.ref_11fcb)) {
      var_0.ref_11fcb = "_c";
      var_0.objkey = "_b";
      var_0.script_label = var_0.objkey;
      return;
    }

    if(var_0.objkey == "_e" && !isDefined(var_0.ref_11fcb)) {
      var_0.ref_11fcb = "_e";
      var_0.objkey = "_c";
      var_0.script_label = var_0.objkey;
      return;
    }

    return;
  }

  if(var_0.objkey == "_b" && !isDefined(var_0.ref_11fcb)) {
    var_0.ref_11fcb = "_b";
    var_0.objkey = "_a";
    var_0.script_label = var_0.objkey;
    return;
  }

  if(var_0.objkey == "_c" && !isDefined(var_0.ref_11fcb)) {
    var_0.ref_11fcb = "_c";
    var_0.objkey = "_b";
    var_0.script_label = var_0.objkey;
    return;
  }

  if(var_0.objkey == "_d" && !isDefined(var_0.ref_11fcb)) {
    var_0.ref_11fcb = "_d";
    var_0.objkey = "_c";
    var_0.script_label = var_0.objkey;
    return;
  }
}

function runobjflag(var_0, var_1) {
  level endon("game_ended");
  var_0.script_label = var_0.objkey;
  var_2 = scripts\mp\gametypes\obj_dom::setupobjective(var_0, undefined, 1);
  var_2.origin = var_0.origin;
  var_2 scripts\mp\gameobjects::allowuse("none");
  var_2.didstatusnotify = 0;
  var_2 scripts\mp\gameobjects::setownerteam(var_1);
  var_3 = "any";

  if(var_1 != "neutral") {
    if(level.hideenemyfobs) {
      var_3 = "friendly";
    }

    var_2.capturetime = gettime();
  }

  var_2 scripts\mp\gameobjects::setvisibleteam(var_3);
  return var_2;
}

function ref_11aaf(var_0, var_1) {
  self endon("disconnect");
  var_2 = 0;
  var_3 = 0.5;
  thread ref_11ab0(var_2, var_3);
}

function ref_11ab0(var_0, var_1) {
  self endon("disconnect");

  if(istrue(self.ref_12ca6)) {
    return;
  }

  self.ref_12ca6 = 1;
  self notify("fadeDown_start");

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_2 = var_0;

  if(var_2 > 0) {
    var_3 = 0;
    var_4 = var_2 / level.framedurationseconds;
    var_5 = 1 / var_4;
    var_6 = 0;

    while(var_6 < var_4) {
      var_6++;
      var_3 += var_5;
      var_3 = clamp(var_3, 0, 1);
      self setclientomnvar("ui_world_fade", var_3);
      waitframe();
    }
  } else {
    self setclientomnvar("ui_world_fade", 1);
  }

  self notify("fadeDown_complete");
  var_7 = 0;

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    self waittill("spawned_player");
    var_7 = 1;
  }

  if(var_7) {
    scripts\mp\utility\player::hidehudenable();
  }

  wait 1;
  self notify("fadeUp_start");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = var_1;

  if(var_2 > 0) {
    var_3 = 1;
    var_4 = var_2 / level.framedurationseconds;
    var_5 = 1 / var_4;
    var_6 = 0;

    while(var_6 < var_4) {
      var_6++;
      var_3 -= var_5;
      var_3 = clamp(var_3, 0, 1);
      self setclientomnvar("ui_world_fade", var_3);
      waitframe();
    }
  } else {
    self setclientomnvar("ui_world_fade", 0);
  }

  if(var_7) {
    scripts\mp\utility\player::hidehuddisable();
  }

  self.ref_12ca6 = undefined;
  self notify("fadeUp_complete");
}