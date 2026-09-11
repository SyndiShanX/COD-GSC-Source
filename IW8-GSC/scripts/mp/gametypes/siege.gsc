/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\siege.gsc
***********************************************/

function main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }

  level.unset_relic_lfo = 0;
  var0 = getdvarint("LTSNLQNRKO") && !getdvarint("LSTLQTSSRM");

  if(var0) {
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
    var0 = game["attackers"];
    var1 = game["defenders"];
    game["attackers"] = var1;
    game["defenders"] = var0;
  }

  foreach(var3 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var3, &"OBJECTIVES/DOM");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var3, &"OBJECTIVES/DOM");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var3, &"OBJECTIVES/DOM_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var3, &"OBJECTIVES/DOM_HINT");
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

function vehiclespawn_getspawndata(var0) {
  var1 = spawnStruct();
  var1.origin = var0.origin;
  var1.angles = var0.angles;
  var1.spawntype = "GAME_MODE";
  var1.showheadicon = 1;
  return var1;
}

function registervehicletype(var0, var1, var2) {
  var3 = spawnStruct();
  var3.refname = var0;
  var3.spawncallback = var2;
  var3.vehiclespawns = [[var1]]();
  level.vehicleinfo[var0] = var3;
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

  foreach(var1 in level.vehicleinfo) {
    switch (var1.refname) {
      case "little_bird":
        var1.vehiclespawns = rundrawprematchareas("little_bird", "lbravo_physics_mp");
        break;
      case "atv":
        var1.vehiclespawns = rundrawprematchareas("atv", "atango_physics_mp");
        break;
      case "cargo_truck":
        var1.vehiclespawns = rundrawprematchareas("cargo_truck", "mkilo_physics_mp");
        break;
      case "jeep":
        var1.vehiclespawns = rundrawprematchareas("jeep", "decho_physics_mp");
        break;
      case "tac_rover":
        var1.vehiclespawns = rundrawprematchareas("tac_rover", "tromeo_physics_mp");
        break;
    }

    foreach(var3 in var1.vehiclespawns) {
      var4 = level.vehiclespawnlocs.size;
      level.vehiclespawnlocs[var4] = var3;
      level.vehiclespawnlocs[var4].refname = var1.refname;
    }
  }

  if(false) {
    foreach(var8 in level.vehiclespawnlocs) {
      thread scripts\mp\utility\debug::drawline(var8.origin, var8.origin + (0, 0, 1500), 1000, (1, 0, 0));
    }
  }

  level.vehiclespawnlocs = scripts\engine\utility::array_randomize(level.vehiclespawnlocs);
  var10 = level.ref_11f41;

  if(!isDefined(level.ref_11f41)) {
    var10 = 25;
  }

  if(false) {
    for(var11 = 0; var11 < var10; var11++) {
      var8 = level.vehiclespawnlocs[var11];
      thread scripts\mp\utility\debug::drawline(var8.origin + (0, 0, 1500), var8.origin + (0, 0, 2500), 1000, (0, 1, 0));
    }
  }

  for(var11 = 0; var11 < var10; var11++) {
    var8 = level.vehiclespawnlocs[var11];

    if(isDefined(var8)) {
      var1 = level.vehicleinfo[var8.refname];
      [[var1.spawncallback]](var8);
    }
  }
}

function rundrawprematchareas(var0, var1) {
  var2 = [];
  var3 = scripts\cp_mp\utility\game_utility::getmapname();
  var4 = [];
  var5 = [];
  var6 = [];
  var7 = [];

  switch (var3) {
    case "mp_downtown_gw":
      if(var0 == "atv") {
        var4 = (21843.8, -4640.11, -476.961);
        var4 = (20375.9, -3612.78, -454);
        var4 = (20728.8, -3309.36, -456);
        var5 = (0, 255, 0);
        var5 = (0, 330, 0);
        var5 = (0, 292, 0);
        var4 = (20937.2, -9029.28, -379.674);
        var4 = (23097.1, -9966.89, -344);
        var5 = (356.825, 240, 0);
        var5 = (0, 0, 0);
        var4 = (17471, -23211.4, -204);
        var4 = (15960.1, -22768.1, -204);
        var4 = (15821.3, -23568, -208.461);
        var5 = (0, 90, 0);
        var5 = (0, 45, 0);
        var5 = (0, 90, 0);
        var4 = (22994.3, -15304.5, -216);
        var5 = (0, 105, 0);
      } else if(var0 == "tac_rover") {
        var6 = (20120.2, -3287.71, -456);
        var6 = (21339.9, -4787.55, -450.176);
        GscBinSkip0(0x2e, var7.size, (0, 345, 0));
      }

      break;
    case "mp_quarry2":
      if(var0 == "atv") {
        var4 = (26335.7, 30412.6, 655.471);
        var4 = (27099.5, 30567.5, 639.236);
        var4 = (27315.5, 30525.5, 639.236);
        var5 = (0.0728273, 119, 0.843973);
        var5 = (2.67817, 77.0718, 1.59551);
        var5 = (2.67817, 77.0718, 1.59551);
        var4 = (29610.4, 38228.5, 698.883);
        var4 = (29465.5, 38973.6, 701);
        var5 = (0, 315, 0);
        var5 = (0, 88.9989, 0);
        var4 = (39153, 46431.8, 932.749);
        var4 = (38876.4, 46106.9, 925.771);
        var4 = (37923.7, 47136.4, 949.247);
        var5 = (1.88064, 180.047, 0.333796);
        var5 = (1.47639, 180.039, 1.17305);
        var5 = (359.077, 185.712, 7.76991);
        var4 = (33628.2, 40971.6, 653.047);
        var4 = (32104.4, 41719.8, 708.773);
        var5 = (349.991, 186.286, -2.23687);
        var5 = (3.95499, 211.371, 4.41818);
      } else if(var0 == "tac_rover") {
        var6 = (26310.8, 30168.4, 659.426);
        var6 = (26954, 29794.1, 651.013);
        GscBinSkip0(0x2e, var7.size, (358.195, 118.006, -2.71651));
      }

      break;
    case "mp_farms2":
    case "mp_farms2_gw":
      if(var0 == "atv") {
        var4 = (49063.3, -22654.9, -385.662);
        var4 = (47332.9, -23070.6, -374.497);
        var4 = (48281.3, -22202.5, -371.375);
        var5 = (0.0275984, 103.998, 0.280605);
        var5 = (357.226, 88.8435, 4.3294);
        var5 = (3.93534, 89.3527, 4.34541);
        var4 = (49720, -18492, -387.562);
        var4 = (48107.4, -18052.3, -312.859);
        var5 = (0, 73.9972, 0);
        var5 = (352.657, 118.56, -10.3306);
        var4 = (46431.3, -92.3425, -52.4549);
        var4 = (47471, -192.634, -43.7394);
        var4 = (48085.6, -358.42, 9.73944);
        var5 = (359.802, 240.821, -3.32839);
        var5 = (0.975088, 240.828, 0.322594);
        var5 = (6.15886, 241.028, 2.20885);
        var4 = (44528.7, -5376.79, 283.824);
        var4 = (43628, -5846.41, 346.636);
        var5 = (357.74, 256.16, -1.56165);
        var5 = (0.506229, 241.181, 0.438595);
      } else if(var0 == "tac_rover") {
        var6 = (47872.6, -22645.4, -385.49);
        var6 = (48501.7, -22505, -382.243);
        GscBinSkip0(0x2e, var7.size, (1.68464, 109.9, -3.26246));
      }

      break;
    case "mp_port2_gw":
      if(var0 == "atv") {
        var4 = (31381.3, -35260.4, -566.754);
        var4 = (31087.5, -35307.9, -566.206);
        var5 = (0, 106, 0);
        var5 = (0, 91, 0);
        var4 = (37273.8, -22647.6, -566);
        var4 = (38224.6, -23864.4, -566);
        var5 = (0, 225, 0);
        var5 = (0, 225, 0);
        var4 = (37183.4, -15816, -558.929);
        var4 = (36704.9, -15941.1, -558);
        var4 = (37630.9, -15950.5, -564);
        var5 = (0, 270, 0);
        var5 = (0, 270, 0);
        var5 = (0, 270, 0);
        var4 = (34323.3, -25831.8, -566);
        var5 = (0, 45, 0);
      } else if(var0 == "tac_rover") {
        var6 = (31412.5, -34658.3, -564.862);
        var6 = (31042.3, -16171.6, -565.383);
        GscBinSkip0(0x2e, var7.size, (0, 105, 0));
      }

      break;
    case "mp_boneyard_gw":
      if(var0 == "atv") {
        var4 = (-28937.7, -17197.8, -246.637);
        var4 = (-29175.8, -17121.9, -247.909);
        var4 = (-28096.5, -16918.8, -246.085);
        var5 = (1.203, 90, 0.12);
        var5 = (0.597, 90, 0.15);
        var5 = (358.68, 90.0277, -0.8);
        var4 = (-25926, -12688.6, -89.5073);
        var4 = (-24872.9, -12661.3, -65.0808);
        var5 = (5.13576, 104.619, 0.240957);
        var5 = (358.169, 15, -3.49767);
        var4 = (-28315.5, -3152.67, -311.293);
        var4 = (-28107.5, -3152.67, -311.293);
        var4 = (-27778.8, -3591.73, -310.621);
        var5 = (0.061, 270, 7.355);
        var5 = (0.061, 270, 7.355);
        var5 = (0, 270, 0);
        var4 = (-25666, -8411.14, -47.9997);
        var4 = (-26998.2, -9004.54, -40);
        var5 = (358.715, 15.233, -10.279);
        var5 = (0, 285, 0);
      } else if(var0 == "tac_rover") {
        var6 = (-28683.3, -16741.2, -249.16);
        var6 = (-29128.7, -16577.6, -229.266);
        GscBinSkip0(0x2e, var7.size, (359.734, 90.0021, -0.454));
      }

      break;
    case "mp_aniyah":
      break;
    case "mp_promenade_gw":
      if(var0 == "atv") {
        var4 = (-9606.95, -21527.2, -279.043);
        var4 = (-10288.2, -20891.9, -356.989);
        var4 = (-11011.4, -19877, -368.358);
        var5 = (0, 200, 0);
        var5 = (0, 222, 0);
        var5 = (359.526, 210.007, -0.952);
        var4 = (-13835.9, -23127.9, -278.639);
        var4 = (-14327.9, -22160.8, -266.586);
        var5 = (2.373, 210, 0);
        var5 = (0.806, 194.929, 2.603);
        var4 = (-21725.2, -26511, -152);
        var4 = (-21577.7, -26755.1, -151.997);
        var4 = (-21065.3, -27199.1, -148.746);
        var5 = (0, 30, 0);
        var5 = (0, 60, 0);
        var5 = (5.079, 0.128, 1.453);
        var4 = (-18873.3, -25796.5, -199.784);
        var5 = (0, 30, 0);
      } else if(var0 == "tac_rover") {
        var6 = (-10912.6, -20079.6, -367);
        var6 = (-10108.5, -21861.4, -287.271);
        GscBinSkip0(0x2e, var7.size, (0, 196.996, 0));
      }

      break;
    case "mp_layover_gw":
      if(var0 == "atv") {
        var4 = (-3749, 16980, -262);
        var4 = (-2971.9, 18898, -262);
        var4 = (-2735.8, 16203, -262);
        var5 = (0, 218, 0);
        var5 = (0, 174, 0);
        var5 = (0, 208, 0);
        var4 = (-11894, 16161, -266);
        var4 = (-11841, 15884, -266);
        var5 = (0, 162, 0);
        var5 = (0, 248, 0);
        var4 = (-29137, 12868, -244);
        var4 = (-29539, 12883, -252);
        var4 = (-29040, 13706, -497);
        var5 = (0, 0, 0);
        var5 = (0, 0, 0);
        var5 = (0, 5, 0);
        var4 = (-19181, 16384, -263);
        var4 = (-19650, 17253, 54);
        var4 = (-19937, 16123, -261);
        var5 = (0, 310, 0);
        var5 = (0, 357, 0);
        var5 = (0, 35, 0);
      } else if(var0 == "tac_rover") {
        var6 = (-3520, 17805, -262);
        var6 = (-3892, 18566, -262);
        GscBinSkip0(0x2e, var7.size, (0, 165, 0));
      }

      break;
    case "mp_riverside_gw":
      if(var0 == "atv") {
        var4 = (4103, 26076, 57);
        var4 = (4247, 25021, -38);
        var4 = (3517, 25981, 47);
        var5 = (0, 143, 0);
        var5 = (0, 189, 0);
        var5 = (0, 103, 0);
        var4 = (4989, 29842, 253);
        var4 = (1725, 28703, 51);
        var5 = (0, 162, 0);
        var5 = (0, 141, 0);
        var4 = (-6826, 33623, -46);
        var4 = (-7642, 32168, -188);
        var4 = (-6589, 32564, -82);
        var5 = (3, 337, 0);
        var5 = (0, 357, 0);
        var5 = (0, 320, 0);
        var4 = (-3326, 32657, 238);
        var4 = (-2149, 33264, 253);
        var5 = (0, 325, 0);
        var5 = (0, 287, 0);
      } else if(var0 == "tac_rover") {
        var6 = (4157, 26465, 65);
        var6 = (4628, 26545, 63);
        GscBinSkip0(0x2e, var7.size, (0, 143, 0));
      }

      break;
    default:
      break;
  }

  level.check_for_moody_traversal = var4;
  level.check_for_execution_allows = var5;

  if(var0 == "atv") {
    for(var8 = 0; var8 < var4.size; var8++) {
      if(var8 <= var4.size - 1) {
        var9 = var4[var8];
        var10 = var5[var8];
        var11 = spawnStruct();
        var11.origin = var9;
        var11.angles = var10;
        var11.targetname = var0;
        var11.vehicletype = var1;
        var2 = var11;
      }
    }
  } else if(var0 == "tac_rover") {
    for(var8 = 0; var8 < var6.size; var8++) {
      if(var8 <= var6.size - 1) {
        var12 = var6[var8];
        var13 = var7[var8];
        var11 = spawnStruct();
        var11.origin = var12;
        var11.angles = var13;
        var11.targetname = var0;
        var11.vehicletype = var1;
        var2 = var11;
      }
    }
  }

  var14 = "scr_brtdm_vehicle_" + var0;

  for(var15 = 0;; var15++) {
    var16 = var14 + "_origin_" + var15;
    var17 = var14 + "_angles_" + var15;
    var18 = (0, 0, 0);
    var19 = getdvarvector(var16, var18);

    if(var19 == (0, 0, 0)) {
      break;
    }

    var11 = spawnStruct();
    var11.origin = var19;
    var20 = (0, 0, 0);
    var11.angles = getdvarvector(var17, var20);
    var11.targetname = var0;
    var11.vehicletype = var1;
    var2 = var11;
  }

  return var2;
}

function vehiclespawn_littlebird(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("little_bird", var2, var1);
}

function vehiclespawn_atv(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("atv", var2, var1);
}

function vehiclespawn_cargotruck(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("cargo_truck", var2, var1);
}

function vehiclespawn_tacrover(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("tac_rover", var2, var1);
}

function vehiclespawn_jeep(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("jeep", var2, var1);
}

function play_nag_intro_vo(var0) {
  var1 = [];

  if(getdvarint("scr_brtdm_disable_radiant_vehicles", level.endsuperdisableweaponbr.ref_1196b["scr_brtdm_disable_radiant_vehicles"]) == 1) {
    return var1;
  }

  foreach(var3 in var0) {
    if(distance2dsquared(var3.origin, level.endsuperdisableweaponbr.circlecenter) < level.endsuperdisableweaponbr.gulagfadetoblackspectatorsofplayer * level.endsuperdisableweaponbr.gulagfadetoblackspectatorsofplayer) {
      var1 = var3;
    }
  }

  return var1;
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
  var0 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn");
  var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("dom", var0);
  scripts\mp\spawnlogic::registerspawnset("dom_fallback", var1);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function getspawnpoint() {
  if(level.unset_relic_lfo) {
    var0 = self.pers["team"];

    if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
      if(var0 == game["attackers"]) {
        scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
        var1 = scripts\mp\spawnlogic::getspawnpoint(self, var0, undefined, "start_attackers");
      } else {
        scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
        var1 = scripts\mp\spawnlogic::getspawnpoint(self, var1, undefined, "start_defenders");
      }
    } else {
      scripts\mp\spawnlogic::activatespawnset("normal", 1);
      var1 = scripts\mp\spawnlogic::getspawnpoint(self, var1, undefined, "fallback");
    }

    if(istrue(level.usesquadspawn) && istrue(self.squadspawnconfirmed)) {
      var2 = self getspectatingplayer();

      if(isDefined(var2) && isDefined(self.squadindex) && self.team == var2.team && self.squadindex == var2.squadindex) {
        var1 = scripts\mp\spawnscoring::findteammatebuddyspawn(var2);
      }
    }

    return var1;
  }

  var0 = self.pers["team"];
  var3 = scripts\mp\utility\game::getotherteam(var0)[0];

  if(level.usestartspawns) {
    scripts\mp\spawnlogic::setactivespawnlogic("StartSpawn", "Crit_Default");
    jumpiffalse(game["switchedsides"]) LOC_00000137;
    var4 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_" + var3 + "_start");
    var1 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var4);
    goto LOC_00000155;
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("Domination", "Crit_Default");
    var5 = getteamdompoints(var4);
    var6 = scripts\mp\utility\game::getotherteam(var4)[0];
    var7 = getteamdompoints(var6);
    var8 = scripts\mp\gametypes\dom::getpreferreddompoints(var5, var7, var4, var1);
    var9 = [];
    GscBinSkip0(0x2e, "preferredDomPoints", var8["preferred"]);
  }

  return var9;
}

function getteamdompoints(var0) {
  var1 = [];

  foreach(var3 in level.objectives) {
    if(var3.ownerteam == var0) {
      var1 = var3;
    }
  }

  return var1;
}

function gettimesincedompointcapture(var0) {
  return gettime() - var0.capturetime;
}

function onplayerconnect(var0) {
  var0._domflageffect = [];
  var0._domflagpulseeffect = [];
  var0.ui_dom_securing = undefined;
  var0.ui_dom_stalemate = undefined;
  thread onplayerspawned();
  var0 thread scripts\mp\gametypes\obj_dom::ondisconnect();
  var0.siegelatecomer = 1;

  if(level.unset_relic_lfo && isDefined(game["roundsPlayed"]) && game["roundsPlayed"] != 0 && !scripts\mp\flags::gameflag("prematch_done")) {
    thread ref_11aaf();
    return;
  }
}

function onplayerdisconnect(var0) {
  for(;;) {
    var0 waittill("disconnect");

    foreach(var2 in var0._domflageffect) {
      if(isDefined(var2)) {
        var2 delete();
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

function onplayerjointeam(var0) {
  if(scripts\mp\utility\game::gamehasstarted()) {
    var0.siegelatecomer = 1;
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
  var0 = getEntArray("flag_primary", "targetname");
  var1 = getEntArray("flag_secondary", "targetname");

  if(var0.size + var1.size < 2) {
    return;
  }

  var2 = "mp/siegeFlagPos.csv";
  var3 = scripts\cp_mp\utility\game_utility::getmapname();
  var4 = 1;

  for(var5 = 2; var5 < 11; var5++) {
    var6 = tablelookup(var2, var4, var3, var5);

    if(var6 != "") {
      setflagpositions(var5, float(var6));
    }
  }

  var7 = [];

  for(var8 = 0; var8 < var0.size; var8++) {
    var7 = var0[var8];
  }

  for(var8 = 0; var8 < var1.size; var8++) {
    var7 = var1[var8];
  }

  level.ref_11f45 = 3;
  setomnvar("ui_num_dom_flags", level.ref_11f45);

  if(level.ref_11f45 == 3) {
    foreach(var10 in var0) {
      var10 scripts\mp\gametypes\dom::remapdomtriggerscriptlabel();
    }
  }

  level.objectives = [];

  for(var8 = 0; var8 < var7.size; var8++) {
    var10 = var7[var8];

    if(level.ref_11f45 == 3) {
      if(var10.script_label == "_d" || var10.script_label == "_e") {
        continue;
      }
    }

    var10.origin = getflagpos(var10.script_label, var10.origin);

    if(isDefined(var10.target)) {
      var12 = getEnt(var10.target, "targetname");
    } else {
      var12 = spawn("script_model", var10.origin);
      var12[0].angles = var10.angles;
    }

    var13 = scripts\mp\gameobjects::createuseobject("neutral", var10, var12, (0, 0, 100), 1, 1);
    var13 scripts\mp\gameobjects::allowuse("enemy");
    var13 scripts\mp\gameobjects::setusetime(level.caprate);

    if(isDefined(var10.objectivekey)) {
      var13.objectivekey = var10.objectivekey;
    } else {
      var13.objectivekey = var13 scripts\mp\gameobjects::getlabel();
    }

    if(isDefined(var10.iconname)) {
      var13.iconname = var10.iconname;
    } else {
      var13.iconname = var13 scripts\mp\gameobjects::getlabel();
    }

    var13 scripts\mp\gameobjects::cancontestclaim(1);
    var13.nousebar = 1;
    var13.id = "domFlag";
    var13.firstcapture = 1;
    var13.prevteam = "neutral";
    var13.flagcapsuccess = 0;
    var13.playersrevived = 0;
    var13.claimgracetime = level.caprate * 1000;
    var13 scripts\mp\gameobjects::pinobjiconontriggertouch();
    var14 = var12[0].origin + (0, 0, 32);
    var15 = var12[0].origin + (0, 0, -32);
    var16 = scripts\engine\trace::ray_trace(var14, var15, undefined, scripts\engine\trace::create_default_contents(1));
    var17 = scripts\mp\gametypes\obj_dom::checkmapoffsets(var13);
    var13.baseeffectpos = var16["position"] + var17;
    var18 = vectortoangles(var16["normal"]);
    var19 = scripts\mp\gametypes\obj_dom::checkmapfxangles(var13, var18);
    var13.baseeffectforward = anglesToForward(var19);
    var13.noscriptable = 1;
    var13.flagmodel = spawn("script_model", var13.baseeffectpos);

    if(istrue(level.setplayerselfrevivingextrainfo)) {
      var20 = "decor_halloween_scarecrow";
    } else {
      var20 = "military_dom_flag_neutral";
    }

    var13.flagmodel setModel(var20);
    level.objectives[var13.objectivekey] = var13;
  }

  var21 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_axis_start");
  var22 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_allies_start");
  level.startpos["allies"] = var22[0].origin;
  level.startpos["axis"] = var21[0].origin;
  level.bestspawnflag = [];
  level.bestspawnflag["allies"] = scripts\mp\gametypes\obj_dom::getunownedflagneareststart("allies", undefined);
  level.bestspawnflag["axis"] = scripts\mp\gametypes\obj_dom::getunownedflagneareststart("axis", level.bestspawnflag["allies"]);
  scripts\mp\gametypes\dom::flagsetup();

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level scripts\engine\utility::ref_143a5("prematch_done", "start_mode_setup");
  }

  foreach(var24 in level.objectives) {
    var25 = scripts\mp\gametypes\obj_dom::getreservedobjid(var24.objectivekey);
    var24 scripts\mp\gameobjects::requestid(1, 1, var25);
    var24.onuse = &onuse;
    var24.onbeginuse = &onbeginuse;
    var24.onuseupdate = &onuseupdate;
    var24.onenduse = &onenduse;
    var24.oncontested = &oncontested;
    var24.onuncontested = &onuncontested;
    var24.onunoccupied = &onunoccupied;
    var24.onpinnedstate = &onpinnedstate;
    var24.onunpinnedstate = &onunpinnedstate;
    var24.ref_138b2 = &ref_12093;
    var24.stompprogressreward = &stompprogressreward;
    var24 scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_target");
    var24 scripts\mp\gameobjects::setvisibleteam("any");
    var24 scripts\mp\gametypes\obj_dom::domflag_setneutral();
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

function setflagpositions(var0, var1) {
  switch (var0) {
    case 2:
      level.siege_a_xpos = var1;
      break;
    case 3:
      level.siege_a_ypos = var1;
      break;
    case 4:
      level.siege_a_zpos = var1;
      break;
    case 5:
      level.siege_b_xpos = var1;
      break;
    case 6:
      level.siege_b_ypos = var1;
      break;
    case 7:
      level.siege_b_zpos = var1;
      break;
    case 8:
      level.siege_c_xpos = var1;
      break;
    case 9:
      level.siege_c_ypos = var1;
      break;
    case 10:
      level.siege_c_zpos = var1;
      break;
  }
}

function getflagpos(var0, var1) {
  var2 = var1;

  if(var0 == "_a") {
    if(isDefined(level.siege_a_xpos) && isDefined(level.siege_a_ypos) && isDefined(level.siege_a_zpos)) {
      var2 = (level.siege_a_xpos, level.siege_a_ypos, level.siege_a_zpos);
    }
  } else if(var0 == "_b") {
    if(isDefined(level.siege_b_xpos) && isDefined(level.siege_b_ypos) && isDefined(level.siege_b_zpos)) {
      var2 = (level.siege_b_xpos, level.siege_b_ypos, level.siege_b_zpos);
    }
  } else if(isDefined(level.siege_c_xpos) && isDefined(level.siege_c_ypos) && isDefined(level.siege_c_zpos)) {
    var2 = (level.siege_c_xpos, level.siege_c_ypos, level.siege_c_zpos);
  }

  return var2;
}

function watchflagtimerpause() {
  level endon("game_ended");

  for(;;) {
    level waittill("flag_capturing", var0);

    if(level.rushtimer) {
      if(var0.prevteam != "neutral") {
        var1 = scripts\mp\utility\game::getotherteam(var0.prevteam)[0];

        if(isDefined(level.siegetimerstate) && level.siegetimerstate != "pause" && !iswinningteam(var1)) {
          level.gametimerbeeps = 0;
          level.siegetimerstate = "pause";
          pausecountdowntimer();

          if(!flagownersalive(var0.prevteam)) {
            setwinner(var1, tolower(game[var0.prevteam]) + "_eliminated");
          }
        }
      }
    }
  }
}

function iswinningteam(var0) {
  var1 = 0;
  var2 = getflagcount(var0);

  if(level.ref_11f45 == 3) {
    if(var2 == 2) {
      var1 = 1;
    }
  } else if(var2 >= 3) {
    var1 = 1;
  }

  return var1;
}

function flagownersalive(var0) {
  var1 = 0;

  foreach(var3 in level.participants) {
    if(isDefined(var3) && var3.team == var0 && (scripts\mp\utility\player::isreallyalive(var3) || var3.pers["lives"] > 0)) {
      var1 = 1;
      break;
    }
  }

  return var1;
}

function pausecountdowntimer() {
  if(!level.timerstoppedforgamemode) {
    var0 = level.rushtimeramount;

    if(isDefined(level.siegetimeleft)) {
      var0 = level.siegetimeleft;
    }

    var1 = int(gettime() + var0 * 1000);
    scripts\mp\gamelogic::pausetimer(var1);
  }

  level notify("siege_timer_paused");
}

function resumecountdowntimer(var0) {
  var1 = level.rushtimeramount;

  if(level.timerstoppedforgamemode) {
    if(isDefined(level.siegetimeleft)) {
      var1 = level.siegetimeleft;
    }

    var2 = int(gettime() + var1 * 1000);
    setgameendtime(var2);
    scripts\mp\gamelogic::resumetimer(var2);

    if(!isDefined(level.siegetimerstate) || level.siegetimerstate == "pause") {
      level.siegetimerstate = "start";
    }

    thread watchgametimer(var1);

    if(istrue(var0)) {
      if(level.siegeflagcapturing.size > 0) {
        level notify("flag_capturing", self);
        return;
      }

      return;
    }

    return;
  }
}

function watchflagenduse(var0) {
  level endon("game_ended");
  var1 = 0;
  var2 = 0;
  var3 = level.rushtimerteam;
  var1 = getflagcount("allies");
  var2 = getflagcount("axis");

  if(level.rushtimer && level.rushtimerteam != "none") {
    if(level.sharedrushtimer || var1 == 1 && var2 == 1) {
      level.siegetimerstate = "start";
      notifyplayers("siege_timer_start");
      resumecountdowntimer(1);
      return;
    }
  }

  if(var1 == level.ref_11f45) {
    setwinner("allies", "siege_allflags_win", "siege_allflags_loss");
  } else if(var2 == level.ref_11f45) {
    setwinner("axis", "siege_allflags_win", "siege_allflags_loss");
  } else if(level.rushtimer) {
    if(var1 == 2 || var2 == 2) {
      level.rushtimerteam = scripts\engine\utility::ter_op(var1 > var2, "allies", "axis");

      if(var3 != level.rushtimerteam) {
        if(isDefined(level.siegetimerstate) && level.siegetimerstate != "reset") {
          level.gametimerbeeps = 0;
          level.siegetimeleft = undefined;
          level.siegetimerstate = "reset";
          notifyplayers("siege_timer_reset");
        }

        if(!isDefined(level.siegetimerstate) || level.siegetimerstate != "start") {
          var4 = level.rushtimeramount;

          if(isDefined(level.siegetimeleft)) {
            var4 = level.siegetimeleft;
          }

          var5 = int(gettime() + var4 * 1000);
          level.timelimitoverride = 1;
          scripts\mp\gamelogic::pausetimer(var5);
          setgameendtime(var5);
          scripts\mp\gamelogic::resumetimer(var5);

          if(!isDefined(level.siegetimerstate) || level.siegetimerstate == "pause") {
            level.siegetimerstate = "start";
            notifyplayers("siege_timer_start");
          }

          if(!level.gametimerbeeps) {
            thread watchgametimer(var4);
          }
        }
      } else if(var3 == level.rushtimerteam && var1 == 1 || var3 == level.rushtimerteam && var2 == 1) {
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
  var0 = getdvarfloat("scr_siege_timelimit");

  if(var0 > 0) {
    var1 = var0 - 1;

    while(var1 > 0) {
      var1 -= 1;
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
    foreach(var1 in level.teamnamelist) {
      if(!scripts\mp\utility\teams::getteamdata(var1, "hasSpawned")) {
        return false;
      }
    }

    return true;
  }

  return level.maxplayercount > 1;
}

function watchgametimer(var0) {
  level endon("game_ended");
  level endon("siege_timer_paused");
  level endon("siege_timer_reset");
  var1 = var0;
  var2 = spawn("script_origin", (0, 0, 0));
  var2 hide();
  level.gametimerbeeps = 1;

  while(var1 > 0) {
    var1 -= 1;
    level.siegetimeleft = var1;

    if(var1 <= 30) {
      if(var1 != 0) {
        var2 playSound("ui_mp_timer_countdown");
      }
    }

    wait 1;
  }

  ontimelimit();
}

function getflagcount(var0) {
  var1 = 0;

  foreach(var3 in level.objectives) {
    if(var3.ownerteam == var0 && !isbeingcaptured(var3)) {
      var1 += 1;
    }
  }

  return var1;
}

function isbeingcaptured(var0) {
  var1 = 0;

  if(isDefined(var0)) {
    if(level.siegeflagcapturing.size > 0) {
      foreach(var3 in level.siegeflagcapturing) {
        if(var0.objectivekey == var3) {
          var1 = 1;
        }
      }
    }
  }

  return var1;
}

function setwinner(var0, var1, var2) {
  foreach(var4 in level.players) {
    if(!isai(var4)) {
      var4 setclientomnvar("ui_objective_state", 0);
    }
  }

  if(isDefined(var2)) {
    thread scripts\mp\gamelogic::endgame(var0, game["end_reason"][var1], game["end_reason"][var2]);
    return;
  }

  thread scripts\mp\gamelogic::endgame(var0, game["end_reason"][var1]);
}

function onbeginuse(var0) {
  if(!scripts\engine\utility::array_contains(level.siegeflagcapturing, self.objectivekey)) {
    level.siegeflagcapturing[level.siegeflagcapturing.size] = self.objectivekey;
    var1 = scripts\mp\gameobjects::getownerteam();
    var0 setclientomnvar("ui_objective_state", 1);
    self.didstatusnotify = 0;
    scripts\mp\gameobjects::setusetime(level.caprate);
  }

  level notify("flag_capturing", self);
}

function onuse(var0) {
  self.didstatusnotify = 0;
  var1 = var0.team;
  var2 = scripts\mp\gameobjects::getownerteam();
  var3 = scripts\mp\utility\game::getotherteam(var1)[0];
  self.capturetime = gettime();
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  thread scripts\mp\gametypes\obj_dom::updateflagstate(var1, 0, var1);
  scripts\mp\gametypes\obj_dom::setflagcaptured(var1, var2, var0);
  level.usestartspawns = 0;

  if(var2 == "neutral") {
    var4 = scripts\mp\gametypes\obj_dom::getteamflagcount(var1);

    if(var4 < level.objectives.size) {
      if(var4 == 2 && level.ref_11f45 == 3) {
        scripts\mp\utility\dialog::statusdialog("friendly_captured_2", var1);
        scripts\mp\utility\dialog::statusdialog("enemy_captured_2", var3, 1);
      } else {
        scripts\mp\utility\dialog::statusdialog("secured" + self.objectivekey, var1);
        scripts\mp\utility\dialog::statusdialog("lost" + self.objectivekey, var3, 1);
      }
    }
  }

  if(scripts\mp\gametypes\obj_dom::getteamflagcount(var1) == level.objectives.size) {
    var5 = "mp_dom_flag_captured_all";
  } else {
    var5 = "mp_dom_flag_captured";
  }

  thread scripts\mp\utility\print::printandsoundoneveryone(var2, var5, undefined, undefined, var5, "mp_dom_flag_lost", var1);
  thread giveflagcapturexp(self.touchlist[var2], var3, var1);
  self.firstcapture = 0;

  if(scripts\mp\utility\teams::isgameplayteam(var2)) {
    if(level.teamdata[var2]["aliveCount"] < level.teamdata[var2]["players"].size) {
      foreach(var7 in level.teamdata[var2]["players"]) {
        var7 playlocalsound("mp_bodycount_tick_positive");
      }

      var9 = scripts\mp\utility\teams::getenemyplayers(var2);

      foreach(var7 in var9) {
        var7 playlocalsound("mp_bodycount_tick_negative");
      }
    }
  }

  thread getquickdropitemcount(var2);
}

function onuseupdate(var0, var1, var2, var3) {
  var4 = scripts\mp\gameobjects::getownerteam();

  if(var1 < 1 && !level.gameended && !istrue(self.captureblocked)) {
    play_dom_capture_sfx(var1, var0);
  }

  if(var1 > 0.05 && var2 && !self.didstatusnotify) {
    if(var4 == "neutral") {
      scripts\mp\utility\dialog::statusdialog("securing" + self.objectivekey, var0);
      self.prevownerteam = scripts\mp\utility\game::getotherteam(var0)[0];
    } else {
      scripts\mp\utility\dialog::statusdialog("losing" + self.objectivekey, var4, 1);
      scripts\mp\utility\dialog::statusdialog("securing" + self.objectivekey, var0);
    }

    if(!isagent(var3)) {
      scripts\mp\gametypes\obj_dom::updateflagcapturestate(var0);
    }

    scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosing, level.icontaking);
    self.didstatusnotify = 1;
  }

  level notify("flag_capturing", self);
}

function getquickdropitemcount(var0) {
  var1 = 0;
  var2 = getflagcount(var0);

  if(level.ref_11f45 == 3) {
    if(var2 == 2) {
      var1 = 1;
    }
  } else if(var2 == 4) {
    var1 = 1;
  }

  if(var1) {
    thread scripts\mp\music_and_dialog::dominating_music(var0);
    return;
  }
}

function play_dom_capture_sfx(var0, var1) {
  if(!isDefined(self.lastsfxplayedtime)) {
    self.lastsfxplayedtime = gettime();
  }

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var2 = "";
    var0 = int(floor(var0 * 10));
    var2 = "mp_dom_capturing_tick_0" + var0;
    self.visuals[0] playsoundtoteam(var2, var1);
    return;
  }
}

function onenduse(var0, var1, var2) {
  self.didstatusnotify = 0;

  if(isPlayer(var1)) {
    var1 setclientomnvar("ui_objective_state", 0);
    var1.ui_dom_securing = undefined;
  }

  if(var2) {
    self.flagcapsuccess = 1;
  } else {
    self.flagcapsuccess = 0;
    resumecountdowntimer();
  }

  var3 = scripts\mp\gameobjects::getownerteam();

  if(var3 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    scripts\mp\gametypes\obj_dom::updateflagstate("idle", 0);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    scripts\mp\gametypes\obj_dom::updateflagstate(var3, 0);
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

function onuncontested(var0) {
  var1 = scripts\mp\gameobjects::getownerteam();
  var2 = scripts\mp\gameobjects::getnumtouchingforteam(var1);
  var3 = scripts\mp\gameobjects::getnumtouchingexceptteam(var1);

  if(var2 && !var3) {
    level.siegeflagcapturing = scripts\engine\utility::array_remove(level.siegeflagcapturing, self.objectivekey);
  }

  thread ref_14393();

  if(var1 == "neutral") {
    if(var0 != "none") {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var0);
    } else {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
    }
  } else {
    scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, scripts\mp\utility\game::getotherteam(var1)[0]);
  }

  if(var0 == "none" || var1 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    self.didstatusnotify = 0;
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  }

  var4 = scripts\engine\utility::ter_op(var1 == "neutral", "idle", var1);
  scripts\mp\gametypes\obj_dom::updateflagstate(var4, 0);
}

function onunoccupied() {
  var0 = scripts\mp\gameobjects::getownerteam();
  level.siegeflagcapturing = scripts\engine\utility::array_remove(level.siegeflagcapturing, self.objectivekey);
  thread ref_14393();

  if(var0 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    self.didstatusnotify = 0;
    return;
  }

  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
}

function onpinnedstate(var0) {
  if(self.ownerteam != "neutral" && self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
    return;
  }
}

function onunpinnedstate(var0) {
  if(self.ownerteam != "neutral" && !self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  }

  var1 = scripts\mp\gameobjects::getownerteam();
  var2 = scripts\mp\gameobjects::getnumtouchingforteam(var1);
  var3 = scripts\mp\gameobjects::getnumtouchingexceptteam(var1);

  if(var2 && !var3) {
    level.siegeflagcapturing = scripts\engine\utility::array_remove(level.siegeflagcapturing, self.objectivekey);
  }

  thread ref_14393();
}

function ref_12093(var0) {
  var1 = scripts\mp\gameobjects::getownerteam();
  var2 = scripts\mp\gameobjects::getnumtouchingforteam(var1);
  var3 = scripts\mp\gameobjects::getnumtouchingexceptteam(var1);

  if(var2 && !var3) {
    level.siegeflagcapturing = scripts\engine\utility::array_remove(level.siegeflagcapturing, self.objectivekey);
  }

  if(level.rushtimerteam == self.ownerteam) {
    resumecountdowntimer();
    return;
  }

  resumecountdowntimer(1);
}

function stompprogressreward(var0) {
  var0 thread scripts\mp\rank::scoreeventpopup("defend");
  var0 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
}

function ondeadevent(var0) {
  if(scripts\mp\utility\game::gamehasstarted()) {
    if(var0 == "all") {
      ontimelimit();
      return;
    }

    if(var0 == game["attackers"]) {
      if(level.rushtimer && getflagcount(var0) == 2) {
        return;
      }

      setwinner(game["defenders"], tolower(game[game["attackers"]]) + "_eliminated");
      return;
    }

    if(var0 == game["defenders"]) {
      if(level.rushtimer && getflagcount(var0) == 2) {
        return;
      }

      setwinner(game["attackers"], tolower(game[game["defenders"]]) + "_eliminated");
      return;
    }

    return;
  }
}

function ononeleftevent(var0) {
  var1 = scripts\mp\utility\game::getlastlivingplayer(var0);
  thread givelastonteamwarning();
}

function onplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(isDefined(self.ref_14437)) {
    self.ref_14437 = undefined;
  }

  if(!isPlayer(var1) || var1.team == self.team) {
    return;
  }

  if(!flagownersalive(self.team) && scripts\mp\gametypes\obj_dom::getteamflagcount(self.team) == 2) {
    scripts\mp\utility\dialog::statusdialog("objs_capture", var1.team, 1);
  }

  var10 = 0;
  var11 = 0;
  var12 = 0;
  var13 = self;
  var14 = var13.team;
  var15 = var13.origin;
  var16 = var1.team;
  var17 = var1.origin;
  var18 = 0;

  if(isDefined(var0)) {
    var17 = var0.origin;
    var18 = var0 == var1;
  }

  foreach(var20 in var1.touchtriggers) {
    var21 = undefined;

    foreach(var23 in level.objectives) {
      if(var23.trigger == var20) {
        var21 = var23;
        break;
      }
    }

    if(!isDefined(var21)) {
      continue;
    }

    var25 = var21.ownerteam;

    if(var16 != var25) {
      if(!var10) {
        var10 = 1;
      }
    }
  }

  foreach(var21 in level.objectives) {
    var20 = var21.trigger;
    var25 = var21.ownerteam;

    if(var25 == "neutral") {
      var28 = var1 istouching(var20);
      var29 = var13 istouching(var20);

      if(var28 || var29) {
        if(var21.claimteam == var14) {
          if(!var11) {
            if(var10) {
              var1 thread scripts\mp\utility\points::giveunifiedpoints("capture_kill");
            } else {
              var1 thread scripts\mp\rank::scoreeventpopup("assault");
              var1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
            }

            var11 = 1;
            thread scripts\common\utility::ref_13e0a(level.ref_11b26, var9, "assaulting");
            continue;
          }
        } else if(var21.claimteam == var16) {
          if(!var12) {
            if(var10) {
              var1 thread scripts\mp\utility\points::giveunifiedpoints("capture_kill");
            } else {
              var1 thread scripts\mp\rank::scoreeventpopup("defend");
              var1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
            }

            var12 = 1;
            var1 scripts\mp\utility\stats::incpersstat("defends", 1);
            var1 scripts\mp\persistence::statsetchild("round", "defends", var1.pers["defends"]);
            thread scripts\common\utility::ref_13e0a(level.ref_11b26, var9, "defending");
            continue;
          }
        }
      }

      continue;
    }

    if(var25 != var16) {
      if(!var11) {
        var30 = distsquaredcheck(var20, var17, var15);

        if(var30) {
          if(var10) {
            var1 thread scripts\mp\utility\points::giveunifiedpoints("capture_kill");
          } else {
            var1 thread scripts\mp\rank::scoreeventpopup("assault");
            var1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
          }

          var11 = 1;
          thread scripts\common\utility::ref_13e0a(level.ref_11b26, var9, "assaulting");
          continue;
        }
      }

      continue;
    }

    if(!var12) {
      var31 = distsquaredcheck(var20, var17, var15);

      if(var31) {
        if(var10) {
          var1 thread scripts\mp\utility\points::giveunifiedpoints("capture_kill");
        } else {
          var1 thread scripts\mp\rank::scoreeventpopup("defend");
          var1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
        }

        var12 = 1;
        var1 scripts\mp\utility\stats::incpersstat("defends", 1);
        var1 scripts\mp\persistence::statsetchild("round", "defends", var1.pers["defends"]);
        thread scripts\common\utility::ref_13e0a(level.ref_11b26, var9, "defending");
      }
    }
  }

  thread checkallowspectating();
}

function distsquaredcheck(var0, var1, var2) {
  var3 = distancesquared(var0.origin, var1);
  var4 = distancesquared(var0.origin, var2);

  if(var3 < 105625 || var4 < 105625) {
    if(!isDefined(var0.modifieddefendcheck)) {
      return 1;
    }

    if(var1[2] - var0.origin[2] < 100 || var2[2] - var0.origin[2] < 100) {
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
  var0 = scripts\mp\utility\game::getotherteam(self.pers["team"])[0];
  level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
  level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastenemyalive", self, var0);
  level notify("last_alive", self);
}

function ontimelimit() {
  if(isDefined(level.siegegameinactive)) {
    level.forcedend = 1;
    thread scripts\mp\gamelogic::endgame("none", game["end_reason"]["siege_force_end"]);
    return;
  }

  var0 = getflagcount("allies");
  var1 = getflagcount("axis");

  if(var0 > var1) {
    setwinner("allies", "siege_flag_win", "siege_flag_loss");
    return;
  }

  if(var1 > var0) {
    setwinner("axis", "siege_flag_win", "siege_flag_loss");
    return;
  }

  setwinner("tie", "cyber_tie");
}

function teamrespawn(var0, var1) {
  var2 = scripts\mp\utility\teams::getteamdata(var1.team, "teamCount");

  if(!isDefined(var1.rescuedplayers)) {
    var1.rescuedplayers = [];
  }

  foreach(var4 in level.participants) {
    if(isDefined(var4) && var4.team == var0 && !scripts\mp\utility\player::isreallyalive(var4) && !scripts\engine\utility::array_contains(scripts\mp\utility\teams::getfriendlyplayers(var4.team, 1), var4) && (!isDefined(var4.waitingtoselectclass) || !var4.waitingtoselectclass)) {
      if(isDefined(var4.siegelatecomer) && var4.siegelatecomer) {
        var4.siegelatecomer = 0;
      }

      if(!istrue(var4.pers["teamKillPunish"])) {
        if(istrue(var4.ref_14437)) {
          continue;
        }

        var4.ref_14437 = 1;
        var4 thread scripts\mp\playerlogic::waittillcanspawnclient(0);
        var4 thread scripts\mp\rank::scoreeventpopup("revived");
        level notify("sr_player_respawned", var4);
        var4 scripts\mp\utility\dialog::leaderdialogonplayer("revived");
      }

      var1.rescuedplayers[var4.guid] = 1;
    }
  }

  self.playersrevived = var1.rescuedplayers.size;
}

function notifyplayers(var0) {
  foreach(var2 in level.players) {
    var2 thread scripts\mp\hud_message::showsplash(var0);
  }

  level notify("match_ending_soon", "time");
  level notify(var0);
}

function giveflagcapturexp(var0, var1, var2) {
  level endon("game_ended");
  var3 = var2;

  if(isDefined(var3.owner)) {
    var3 = var3.owner;
  }

  level.lastcaptime = gettime();

  if(isPlayer(var3)) {
    level thread scripts\mp\hud_util::teamplayercardsplash("callout_securedposition" + self.objectivekey, var3);
    var3 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "capture", var3.origin);
  }

  var4 = getarraykeys(var0);

  for(var5 = 0; var5 < var4.size; var5++) {
    var6 = var0[var4[var5]].player;

    if(isDefined(var6.owner)) {
      var6 = var6.owner;
    }

    if(!isPlayer(var6)) {
      continue;
    }

    thread updatecpm();

    if(var6.cpm > 3) {
      var7 = 0;
      var8 = 0;
    } else if(var6.numcaps > 5) {
      var7 = 125;
      var8 = 50;
    } else if(self.objectivekey == "_b" || var1 != "neutral" || self.playersrevived > 0) {
      var7 = undefined;
      var8 = undefined;
    } else {
      var7 = 125;
      var8 = 50;
    }

    var6 thread scripts\mp\rank::scoreeventpopup("capture");
    var6 thread scripts\mp\awards::givemidmatchaward("mode_siege_secure", var8, var7);
    var6 scripts\mp\utility\stats::incpersstat("captures", 1);
    var6 scripts\mp\persistence::statsetchild("round", "captures", var6.pers["captures"]);
    var6 scripts\mp\utility\stats::setextrascore0(var6.pers["captures"]);
    var6 scripts\mp\utility\stats::incpersstat("rescues", self.playersrevived);
    var6 scripts\mp\persistence::statsetchild("round", "rescues", var6.pers["rescues"]);
    var6 scripts\mp\utility\stats::setextrascore1(var6.pers["rescues"]);
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
  var0 = getflagcount("allies");
  var1 = getflagcount("axis");

  if(var0 == level.ref_11f45) {
    setwinner("allies", "siege_allflags_win", "siege_allflags_loss");
    return;
  }

  if(var1 == level.ref_11f45) {
    setwinner("axis", "siege_allflags_win", "siege_allflags_loss");
    return;
  }
}

function runobjectives(var0) {
  level.axisspawnareas = [level.axishqname];
  level.alliesspawnareas = [level.allieshqname];
  level.allfobs = [];

  foreach(var2 in level.gw_objstruct.startingfobs_axis) {
    var3 = runobjflag(var2.trigger, "axis");
    level.allfobs[level.allfobs.size] = var2;
    level.axisspawnareas[level.axisspawnareas.size] = var2.name;

    if(isDefined(level.spawnselectionlocations[var2.name]["axis"].anchorentity)) {
      level.spawnselectionlocations[var2.name]["axis"].anchorentity.origin = var2.trigger.origin + (0, 0, 100);
    }
  }

  foreach(var2 in level.gw_objstruct.startingfobs_allies) {
    var3 = runobjflag(var2.trigger, "allies");
    level.allfobs[level.allfobs.size] = var2;
    level.alliesspawnareas[level.alliesspawnareas.size] = var2.name;

    if(isDefined(level.spawnselectionlocations[var2.name]["allies"].anchorentity)) {
      level.spawnselectionlocations[var2.name]["allies"].anchorentity.origin = var2.trigger.origin + (0, 0, 100);
    }
  }

  foreach(var2 in level.gw_objstruct.startingfobs_neutral) {
    if(level.ref_11f45 == 3) {
      if(level.mapname == "mp_downtown_gw") {
        if(var2.trigger.objkey == "_a" || var2.trigger.objkey == "_e") {
          continue;
        } else {
          ref_12bbd(var2.trigger);
        }
      } else if(level.mapname == "mp_aniyah") {
        if(var2.trigger.objkey == "_b" || var2.trigger.objkey == "_d") {
          continue;
        } else {
          ref_12bbd(var2.trigger);
        }
      } else if(level.mapname == "mp_farms2_gw") {
        if(var2.trigger.objkey == "_b" || var2.trigger.objkey == "_d") {
          continue;
        } else {
          ref_12bbd(var2.trigger);
        }
      } else if(level.mapname == "mp_promenade_gw") {
        if(var2.trigger.objkey == "_a" || var2.trigger.objkey == "_e") {
          continue;
        } else {
          ref_12bbd(var2.trigger);
        }
      } else if(level.mapname == "mp_riverside_gw") {
        if(var2.trigger.objkey == "_b" || var2.trigger.objkey == "_d") {
          continue;
        } else {
          ref_12bbd(var2.trigger);
        }
      } else if(var2.trigger.objkey == "_a" || var2.trigger.objkey == "_e") {
        continue;
      } else {
        ref_12bbd(var2.trigger);
      }
    }

    var3 = runobjflag(var2.trigger, "neutral");
    level.allfobs[level.allfobs.size] = var2;
  }

  var9 = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_axis_start");
  var10 = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_allies_start");
  level.startpos["allies"] = var10[0].origin;
  level.startpos["axis"] = var9[0].origin;

  foreach(var2 in level.allfobs) {
    var12 = scripts\mp\gametypes\obj_dom::getreservedobjid(var2.trigger.gameobject.objectivekey);
    var2.trigger.gameobject scripts\mp\gameobjects::requestid(1, 1, var12);
    var2.trigger.gameobject.onuse = &onuse;
    var2.trigger.gameobject.onbeginuse = &onbeginuse;
    var2.trigger.gameobject.onuseupdate = &onuseupdate;
    var2.trigger.gameobject.onenduse = &onenduse;
    var2.trigger.gameobject.oncontested = &oncontested;
    var2.trigger.gameobject.onuncontested = &onuncontested;
    var2.trigger.gameobject.onunoccupied = &onunoccupied;
    var2.trigger.gameobject.onpinnedstate = &onpinnedstate;
    var2.trigger.gameobject.onunpinnedstate = &onunpinnedstate;
    var2.trigger.gameobject.ref_138b2 = &ref_12093;
    var2.trigger.gameobject.stompprogressreward = &stompprogressreward;
    var2.trigger.gameobject scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_target");
    var2.trigger.gameobject scripts\mp\gameobjects::setvisibleteam("any");
    var2.trigger.gameobject scripts\mp\gametypes\obj_dom::domflag_setneutral();
    level.objectives[var2.trigger.gameobject.objectivekey] = var2.trigger.gameobject;
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

  foreach(var1 in level.allfobs) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var1.trigger.gameobject.objidnum);
  }

  while(!scripts\mp\flags::gameflag("prematch_done")) {
    waitframe();
  }

  foreach(var1 in level.allfobs) {
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(var1.trigger.gameobject.objidnum);
  }
}

function ref_12bbd(var0) {
  if(level.mapname == "mp_downtown_gw") {
    if(var0.objkey == "_b" && !isDefined(var0.ref_11fcb)) {
      var0.ref_11fcb = "_a";
      var0.objkey = "_a";
      var0.script_label = var0.objkey;
      return;
    }

    if(var0.objkey == "_c" && !isDefined(var0.ref_11fcb)) {
      var0.ref_11fcb = "_c";
      var0.objkey = "_b";
      var0.script_label = var0.objkey;
      return;
    }

    if(var0.objkey == "_d" && !isDefined(var0.ref_11fcb)) {
      var0.ref_11fcb = "_d";
      var0.objkey = "_c";
      var0.script_label = var0.objkey;
      return;
    }

    return;
  }

  if(level.mapname == "mp_boneyard_gw") {
    if(var0.objkey == "_b" && !isDefined(var0.ref_11fcb)) {
      var0.ref_11fcb = "_b";
      var0.objkey = "_a";
      var0.script_label = var0.objkey;
      return;
    }

    if(var0.objkey == "_d" && !isDefined(var0.ref_11fcb)) {
      var0.ref_11fcb = "_d";
      var0.objkey = "_b";
      var0.script_label = var0.objkey;
      return;
    }

    if(var0.objkey == "_c" && !isDefined(var0.ref_11fcb)) {
      var0.ref_11fcb = "_c";
      var0.objkey = "_c";
      var0.script_label = var0.objkey;
      return;
    }

    return;
  }

  if(level.mapname == "mp_aniyah") {
    if(var0.objkey == "_a" && !isDefined(var0.ref_11fcb)) {
      var0.ref_11fcb = "_a";
      var0.objkey = "_a";
      var0.script_label = var0.objkey;
      return;
    }

    if(var0.objkey == "_c" && !isDefined(var0.ref_11fcb)) {
      var0.ref_11fcb = "_c";
      var0.objkey = "_b";
      var0.script_label = var0.objkey;
      return;
    }

    if(var0.objkey == "_e" && !isDefined(var0.ref_11fcb)) {
      var0.ref_11fcb = "_e";
      var0.objkey = "_c";
      var0.script_label = var0.objkey;
      return;
    }

    return;
  }

  if(level.mapname == "mp_promenade_gw") {
    if(var0.objkey == "_b" && !isDefined(var0.ref_11fcb)) {
      var0.ref_11fcb = "_b";
      var0.objkey = "_a";
      var0.script_label = var0.objkey;
      return;
    }

    if(var0.objkey == "_c" && !isDefined(var0.ref_11fcb)) {
      var0.ref_11fcb = "_c";
      var0.objkey = "_b";
      var0.script_label = var0.objkey;
      return;
    }

    if(var0.objkey == "_d" && !isDefined(var0.ref_11fcb)) {
      var0.ref_11fcb = "_e";
      var0.objkey = "_c";
      var0.script_label = var0.objkey;
      return;
    }

    return;
  }

  if(level.mapname == "mp_farms2_gw") {
    if(var0.objkey == "_a" && !isDefined(var0.ref_11fcb)) {
      var0.ref_11fcb = "_a";
      var0.objkey = "_a";
      var0.script_label = var0.objkey;
      return;
    }

    if(var0.objkey == "_c" && !isDefined(var0.ref_11fcb)) {
      var0.ref_11fcb = "_c";
      var0.objkey = "_b";
      var0.script_label = var0.objkey;
      return;
    }

    if(var0.objkey == "_e" && !isDefined(var0.ref_11fcb)) {
      var0.ref_11fcb = "_e";
      var0.objkey = "_c";
      var0.script_label = var0.objkey;
      return;
    }

    return;
  }

  if(level.mapname == "mp_riverside_gw") {
    if(var0.objkey == "_a" && !isDefined(var0.ref_11fcb)) {
      var0.ref_11fcb = "_a";
      var0.objkey = "_a";
      var0.script_label = var0.objkey;
      return;
    }

    if(var0.objkey == "_c" && !isDefined(var0.ref_11fcb)) {
      var0.ref_11fcb = "_c";
      var0.objkey = "_b";
      var0.script_label = var0.objkey;
      return;
    }

    if(var0.objkey == "_e" && !isDefined(var0.ref_11fcb)) {
      var0.ref_11fcb = "_e";
      var0.objkey = "_c";
      var0.script_label = var0.objkey;
      return;
    }

    return;
  }

  if(var0.objkey == "_b" && !isDefined(var0.ref_11fcb)) {
    var0.ref_11fcb = "_b";
    var0.objkey = "_a";
    var0.script_label = var0.objkey;
    return;
  }

  if(var0.objkey == "_c" && !isDefined(var0.ref_11fcb)) {
    var0.ref_11fcb = "_c";
    var0.objkey = "_b";
    var0.script_label = var0.objkey;
    return;
  }

  if(var0.objkey == "_d" && !isDefined(var0.ref_11fcb)) {
    var0.ref_11fcb = "_d";
    var0.objkey = "_c";
    var0.script_label = var0.objkey;
    return;
  }
}

function runobjflag(var0, var1) {
  level endon("game_ended");
  var0.script_label = var0.objkey;
  var2 = scripts\mp\gametypes\obj_dom::setupobjective(var0, undefined, 1);
  var2.origin = var0.origin;
  var2 scripts\mp\gameobjects::allowuse("none");
  var2.didstatusnotify = 0;
  var2 scripts\mp\gameobjects::setownerteam(var1);
  var3 = "any";

  if(var1 != "neutral") {
    if(level.hideenemyfobs) {
      var3 = "friendly";
    }

    var2.capturetime = gettime();
  }

  var2 scripts\mp\gameobjects::setvisibleteam(var3);
  return var2;
}

function ref_11aaf(var0, var1) {
  self endon("disconnect");
  var2 = 0;
  var3 = 0.5;
  thread ref_11ab0(var2, var3);
}

function ref_11ab0(var0, var1) {
  self endon("disconnect");

  if(istrue(self.ref_12ca6)) {
    return;
  }

  self.ref_12ca6 = 1;
  self notify("fadeDown_start");

  if(!isDefined(var0)) {
    var0 = 0;
  }

  var2 = var0;

  if(var2 > 0) {
    var3 = 0;
    var4 = var2 / level.framedurationseconds;
    var5 = 1 / var4;
    var6 = 0;

    while(var6 < var4) {
      var6++;
      var3 += var5;
      var3 = clamp(var3, 0, 1);
      self setclientomnvar("ui_world_fade", var3);
      waitframe();
    }
  } else {
    self setclientomnvar("ui_world_fade", 1);
  }

  self notify("fadeDown_complete");
  var7 = 0;

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    self waittill("spawned_player");
    var7 = 1;
  }

  if(var7) {
    scripts\mp\utility\player::hidehudenable();
  }

  wait 1;
  self notify("fadeUp_start");

  if(!isDefined(var1)) {
    var1 = 0;
  }

  var2 = var1;

  if(var2 > 0) {
    var3 = 1;
    var4 = var2 / level.framedurationseconds;
    var5 = 1 / var4;
    var6 = 0;

    while(var6 < var4) {
      var6++;
      var3 -= var5;
      var3 = clamp(var3, 0, 1);
      self setclientomnvar("ui_world_fade", var3);
      waitframe();
    }
  } else {
    self setclientomnvar("ui_world_fade", 0);
  }

  if(var7) {
    scripts\mp\utility\player::hidehuddisable();
  }

  self.ref_12ca6 = undefined;
  self notify("fadeUp_complete");
}