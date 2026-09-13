/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\brtdm.gsc
***********************************************/

main() {
  if(getDvar("mapname") == "mp_background") {
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
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 75);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_704789086C9AD943(scripts\mp\utility\game::getgametype(), 1);
  }

  setDvar("dvar_BF87FE7225567E4D", 2);
  level.teambased = 1;
  level.disablespawncamera = 1;
  level.ignoregulagredeploysplash = 1;
  level.brgametype = spawnStruct();
  level.brgametype.funcs = [];
  level.brgametype.disabledfeatures = [];
  level.brgametype.enabledfeatures = [];
  level.brgametype.data = [];
  _id_362C58E8BB39BCDA::disablefeature("kiosk");
  _id_362C58E8BB39BCDA::disablefeature("armor");
  _id_362C58E8BB39BCDA::disablefeature("missions");
  _id_362C58E8BB39BCDA::disablefeature("loot");
  _id_362C58E8BB39BCDA::disablefeature("dropbag");
  _id_362C58E8BB39BCDA::disablefeature("weapons");
  updategametypedvars();
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.modeonspawnplayer = ::onspawnplayer;
  level.modespawnclient = ::modespawn;
  level.modeplayerkilledspawn = ::playerkilledspawn;
  level.onplayerkilled = ::onplayerkilled;
  level.onplayerconnect = ::onplayerconnect;
  level.filtervehiclespawnstructsfunc = ::filtervehiclespawnstructs;
  game["dialog"]["gametype"] = "gametype_tdm";
  game["dialog"]["boost"] = "boost_tdm";
  game["dialog"]["offense_obj"] = "boost_tdm";
  game["dialog"]["defense_obj"] = "boost_tdm";
  level scripts\cp_mp\parachute::initparachutedvars();
  thread _id_2E385BC294259245::init();

  if(scripts\mp\utility\game::matchmakinggame())
    level.shouldgamelobbyremainintact = ::shouldgamelobbyremainintact;

  _id_46AF76764B1FC7F0::brvehiclesinit();
  level._id_152D5A9C5AC5CDAD = getdvarfloat("dvar_BA9E8FBF0254BE1E", 0.857);
  level._id_AA1AAED4A9B80D4B = getdvarint("dvar_3196E3743C6871B2", 3);
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_war_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  setdynamicdvar("scr_war_promode", 0);
}

onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    _id_2B21F2FBE8DD5C6E = game["attackers"];
    _id_8D904E28CF14C8AE = game["defenders"];
    game["attackers"] = _id_8D904E28CF14C8AE;
    game["defenders"] = _id_2B21F2FBE8DD5C6E;
  }

  foreach(_id_F90358454413407F in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/WAR");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/WAR");
    else
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/WAR_SCORE");

    scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/WAR_HINT");
  }

  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_compass", "shouldBeVisibleToPlayer", ::vehicle_compass_br_shouldbevisibletoplayer);
  initcircledata();
  initspawns();
  _id_641E4E9B12A99632::inittankspawns();
  level thread _id_46AF76764B1FC7F0::brvehiclesonstartgametype();
  initvehicles();
  level thread initprematchc130();
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  setDvar("bg_fallDamageMinHeight", getdvarint("dvar_29A2AAB7AFD7A31A", 225));
  setDvar("bg_fallDamageMaxHeight", getdvarint("dvar_6F3CA3679AC76B3C", 560));
  setDvar("bg_softLandingMinHeight", getdvarint("dvar_2CFD86EFAE0C680D", 225));
  setDvar("bg_softLandingMaxHeight", getdvarint("dvar_7F04D2BB2F5714A7", 560));
  level.autorespawnwaittime = getdvarint("dvar_4BEAC336193A373D", 3);
  level.parachutedeploydelay = getdvarfloat("dvar_12027360B079C1DB", 0.5);
  level.brtdm_config = spawnStruct();
  level.brtdm_config.locale = getDvar("scr_brtdm_locale", "");
  applylocaledefaults();
  level.brtdm_config.circlecenter = getdvarvector("dvar_01AFADBBBA931661", level.brtdm_config.locale_defaults["dvar_01AFADBBBA931661"]);
  level.brtdm_config.circleradius = getdvarint("scr_brtdm_circle_radius", level.brtdm_config.locale_defaults["scr_brtdm_circle_radius"]);

  if(!scripts\mp\utility\game::matchmakinggame()) {
    setDvar("dvar_01AFADBBBA931661", level.brtdm_config.circlecenter);
    setDvar("scr_brtdm_circle_radius", level.brtdm_config.circleradius);
  }

  level.brtdm_config.disabledvehicles = [];
  _id_4789ACDA6EA1F7B1 = ["little_bird", "atv", "tac_rover"];

  foreach(vehicle in _id_4789ACDA6EA1F7B1) {
    if(getdvarint(_func_2EF675C13CA1C4AF("dvar_CE84D111A575BEEB", vehicle), 0) == 1)
      level.brtdm_config.disabledvehicles[vehicle] = 1;
  }

  level.brtdm_config.spectatepoint = spawnStruct();
  level.brtdm_config.spectatepoint.origin = getdvarvector("scr_brtdm_spectate_origin", level.brtdm_config.locale_defaults["scr_brtdm_spectate_origin"]);
  level.brtdm_config.spectatepoint.angles = getdvarvector("scr_brtdm_spectate_angles", level.brtdm_config.locale_defaults["scr_brtdm_spectate_angles"]);
}

setlocaledefaultvalue(dvar, value) {
  level.brtdm_config.locale_defaults[dvar] = value;
}

applylocaledefaults() {
  level.brtdm_config.locale_defaults = [];
  setlocaledefaultvalue("dvar_01AFADBBBA931661", (0, 0, 0));
  setlocaledefaultvalue("scr_brtdm_circle_radius", 10000);
  setlocaledefaultvalue("scr_brtdm_spawn_angles_allies", 0);
  setlocaledefaultvalue("scr_brtdm_spawn_angles_axis", 180);
  setlocaledefaultvalue("scr_brtdm_spawn_height_allies", 2500);
  setlocaledefaultvalue("scr_brtdm_spawn_height_axis", 2500);
  setlocaledefaultvalue("dvar_0B3655FCEA6BD08D", 0);
  setlocaledefaultvalue("dvar_0B133FFCEA455873", 30);
  setlocaledefaultvalue("scr_brtdm_spawn_dist_min", 0.9);
  setlocaledefaultvalue("scr_brtdm_spawn_dist_max", 0.99);
  setlocaledefaultvalue("scr_brtdm_spawn_face_enemy", 0);
  setlocaledefaultvalue("scr_brtdm_spectate_origin", (0, 0, 0));
  setlocaledefaultvalue("scr_brtdm_spectate_angles", (0, 0, 0));
  setlocaledefaultvalue("dvar_0ADB05B8132EC13B", 0);
  setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_0", (0, 0, 0));
  setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_0", (0, 0, 0));
  setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_0", (0, 0, 0));
  setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_0", (0, 0, 0));
  setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_origin_0", (0, 0, 0));
  setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_angles_0", (0, 0, 0));
  setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_0", (0, 0, 0));
  setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_0", (0, 0, 0));
  setlocaledefaultvalue("scr_brtdm_vehicle_little_bird_origin_0", (0, 0, 0));
  setlocaledefaultvalue("scr_brtdm_vehicle_little_bird_angles_0", (0, 0, 0));

  switch (level.brtdm_config.locale) {
    case "lumber":
      setlocaledefaultvalue("dvar_01AFADBBBA931661", (51500, 3500, 0));
      setlocaledefaultvalue("scr_brtdm_circle_radius", 12000);
      setlocaledefaultvalue("scr_brtdm_spawn_angles_allies", 238);
      setlocaledefaultvalue("scr_brtdm_spawn_angles_axis", 67);
      setlocaledefaultvalue("scr_brtdm_spectate_origin", (48265, 2555, 1580));
      setlocaledefaultvalue("scr_brtdm_spectate_angles", (27, 12, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_0", (53308, 6374, 100));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_0", (0, 155, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_1", (52810, 6734, 100));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_1", (0, 250, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_2", (49169, -478, 100));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_2", (0, 72, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_3", (49156, 1313, 100));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_3", (0, 60, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_origin_0", (52481, 5490, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_angles_0", (0, 247, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_origin_1", (49837, 1321, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_angles_1", (0, 26, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_0", (54585, 6990, 100));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_0", (0, 323, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_1", (51816, 6727, 100));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_1", (0, 200, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_2", (49599, -109, 100));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_2", (0, 333, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_3", (48721, 1557, 100));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_3", (0, 131, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_0", (53180, 7980, 100));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_0", (0, 255, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_1", (53767, 7455, 100));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_1", (0, 270, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_2", (48642, -115, 100));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_2", (0, 23, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_3", (50339, 559, 100));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_3", (0, 58, 0));
      break;
    case "frozen_pond":
      setlocaledefaultvalue("dvar_01AFADBBBA931661", (783, 36394, 2700));
      setlocaledefaultvalue("scr_brtdm_circle_radius", 10500);
      setlocaledefaultvalue("scr_brtdm_spawn_angles_allies", 117);
      setlocaledefaultvalue("scr_brtdm_spawn_angles_axis", 346);
      setlocaledefaultvalue("dvar_0B133FFCEA455873", 25);
      setlocaledefaultvalue("scr_brtdm_spawn_face_enemy", 1);
      setlocaledefaultvalue("scr_brtdm_spectate_origin", (8400, 33925, 4834));
      setlocaledefaultvalue("scr_brtdm_spectate_angles", (34, 104, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_0", (571, 45632, 1500));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_0", (0, 223, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_1", (-3332, 40505, 2140));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_1", (0, 253, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_origin_0", (-8780, 34027, 25));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_angles_0", (0, 317, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_0", (-3948, 43505, 2329));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_0", (0, 303, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_1", (-7129, 40319, 959));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_1", (0, 291, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_0", (-3004, 43593, 2356));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_0", (0, 271, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_1", (588, 44667, 1495));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_1", (0, 323, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_2", (10118, 36471, 1902));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_2", (0, 141, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_3", (9073, 32831, 1692));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_3", (0, 103, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_origin_1", (2617, 27523, 72));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_angles_1", (0, 142, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_2", (5061, 30887, 425));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_2", (0, 168, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_3", (9013, 37678, 1752));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_3", (0, 194, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_2", (7568, 33763, 1912));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_2", (0, 135, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_3", (9777, 33387, 1700));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_3", (0, 128, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_4", (-699, 30843, -34));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_4", (0, 147, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_5", (-4770, 30535, -219));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_5", (0, 343, 0));
      break;
    case "port_trenches":
      setlocaledefaultvalue("dvar_01AFADBBBA931661", (40225, -30954, -100));
      setlocaledefaultvalue("scr_brtdm_circle_radius", 10250);
      setlocaledefaultvalue("scr_brtdm_spawn_angles_allies", 216);
      setlocaledefaultvalue("scr_brtdm_spawn_angles_axis", 55);
      setlocaledefaultvalue("scr_brtdm_spawn_height_allies", 2000);
      setlocaledefaultvalue("scr_brtdm_spawn_height_axis", 2000);
      setlocaledefaultvalue("dvar_0B133FFCEA455873", 15.0);
      setlocaledefaultvalue("scr_brtdm_spawn_dist_max", 0.95);
      setlocaledefaultvalue("scr_brtdm_spectate_origin", (38843, -39882, -25));
      setlocaledefaultvalue("scr_brtdm_spectate_angles", (1, 43, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_0", (0, 88, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_1", (34474, -38278, -483));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_1", (0, 330, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_2", (32135, -34379, -449));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_2", (0, 105, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_0", (34938, -35005, -350));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_0", (0, 358, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_1", (35742, -39576, -519));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_1", (0, 31, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_0", (31217, -33896, -506));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_0", (0, 88, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_1", (31178, -31874, -507));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_1", (0, 36, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_3", (46648, -25226, -369));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_3", (0, 228, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_4", (44233, -24413, -374));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_4", (0, 263, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_5", (42296, -23065, -382));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_5", (0, 195, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_origin_0", (42507, -24819, -441));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_angles_0", (0, 246, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_2", (40389, -22449, -505));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_2", (0, 216, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_3", (40090, -24011, -500));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_3", (0, 197, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_4", (46988, -24370, -337));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_4", (0, 252, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_2", (45277, -29397, 202));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_2", (0, 199, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_3", (40374, -24937, -507));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_3", (0, 284, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_little_bird_origin_0", (46500, -24005, -180));
      setlocaledefaultvalue("scr_brtdm_vehicle_little_bird_angles_0", (0, 245, 0));
      break;
    case "downtown_park":
      setlocaledefaultvalue("dvar_01AFADBBBA931661", (20548, -30577, 0));
      setlocaledefaultvalue("scr_brtdm_circle_radius", 10000);
      setlocaledefaultvalue("scr_brtdm_spawn_angles_allies", 83);
      setlocaledefaultvalue("scr_brtdm_spawn_angles_axis", 224);
      setlocaledefaultvalue("scr_brtdm_spawn_height_allies", 1500);
      setlocaledefaultvalue("scr_brtdm_spawn_height_axis", 1500);
      setlocaledefaultvalue("dvar_0B133FFCEA455873", 15.0);
      setlocaledefaultvalue("scr_brtdm_spawn_dist_min", 0.65);
      setlocaledefaultvalue("scr_brtdm_spawn_dist_max", 0.75);
      setlocaledefaultvalue("scr_brtdm_spawn_face_enemy", 1);
      setlocaledefaultvalue("scr_brtdm_spectate_origin", (17027, -35357, 1505));
      setlocaledefaultvalue("scr_brtdm_spectate_angles", (21, 63, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_0", (21764, -24164, -142));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_0", (0, 174, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_1", (19780, -21087, -78));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_1", (0, 212, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_origin_0", (21514, -23467, -131));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_angles_0", (0, 225, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_0", (21033, -22870, -174));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_0", (0, 223, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_1", (24268, -23630, -134));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_1", (0, 277, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_0", (19014, -23313, -181));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_0", (0, 138, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_1", (27090, -24785, -334));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_1", (0, 267, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_2", (16600, -34006, 378));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_2", (0, 37, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_3", (19450, -35595, -350));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_3", (0, 7, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_origin_1", (13998, -33209, -183));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_angles_1", (0, 88, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_2", (14357, -33952, -198));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_2", (0, 91, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_3", (16839, -32558, 76));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_3", (0, 86, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_2", (17902, -37318, -312));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_2", (0, 14, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_3", (18828, -34025, 75));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_3", (0, 15, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_4", (17563, -32733, 75));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_4", (0, 58, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_little_bird_origin_1", (15583, -36396, 500));
      setlocaledefaultvalue("scr_brtdm_vehicle_little_bird_angles_1", (0, 71, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_5", (19482, -27539, -210));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_5", (0, 335, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_6", (19072, -30488, -208));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_7", (0, 33, 0));
      break;
    case "hospital_hill":
      setlocaledefaultvalue("dvar_01AFADBBBA931661", (3381, -6288, 750));
      setlocaledefaultvalue("scr_brtdm_circle_radius", 10000);
      setlocaledefaultvalue("scr_brtdm_spawn_angles_allies", 64);
      setlocaledefaultvalue("scr_brtdm_spawn_angles_axis", 234);
      setlocaledefaultvalue("scr_brtdm_spawn_height_allies", 3000);
      setlocaledefaultvalue("dvar_0B133FFCEA455873", 20.0);
      setlocaledefaultvalue("scr_brtdm_spectate_origin", (-384, -14886, 2237));
      setlocaledefaultvalue("scr_brtdm_spectate_angles", (19, 54, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_0", (7968, 1753, 164));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_0", (0, 328, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_1", (5668, 2760, -514));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_1", (0, 172, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_origin_0", (4071, 2010, -450));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_angles_0", (0, 250, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_0", (10647, -2434, -256));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_0", (0, 355, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_1", (2658, 2352, -392));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_1", (0, 192, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_0", (4700, 1713, -510));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_0", (0, 269, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_1", (9716, 596, -235));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_1", (0, 268, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_2", (-4398, -11073, -150));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_2", (0, 58, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_3", (1755, -15241, -223));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_3", (0, 12, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_origin_1", (-5265, -8379, -430));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_angles_1", (0, 18, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_2", (4103, -13423, -229));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_2", (0, 110, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_3", (6098, -13238, -228));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_3", (0, 85, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_2", (-2860, -9972, 109));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_2", (0, 120, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_3", (-4575, -6185, -330));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_3", (0, 321, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_little_bird_origin_0", (-4760, -2885, 750));
      setlocaledefaultvalue("scr_brtdm_vehicle_little_bird_angles_0", (0, 360, 0));
      break;
    case "east_promenade":
      setlocaledefaultvalue("dvar_01AFADBBBA931661", (3995, -22767, 0));
      setlocaledefaultvalue("scr_brtdm_circle_radius", 8000);
      setlocaledefaultvalue("scr_brtdm_spawn_angles_allies", 11);
      setlocaledefaultvalue("scr_brtdm_spawn_angles_axis", 171);
      setlocaledefaultvalue("scr_brtdm_spectate_origin", (-2763, -18250, 2498));
      setlocaledefaultvalue("scr_brtdm_spectate_angles", (32, 309, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_0", (11226, -22558, -150));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_0", (0, 103, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_1", (9301, -19445, -226));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_1", (0, 191, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_origin_0", (9728, -21523, -235));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_angles_0", (0, 193, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_0", (9504, -25962, -228));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_0", (0, 130, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_1", (8586, -19265, -228));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_1", (0, 173, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_0", (4201, -29392, -60));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_0", (0, 199, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_1", (7613, -27816, -92));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_1", (0, 140, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_2", (-2062, -19315, -228));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_2", (0, 87, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_3", (-2783, -26033, -74));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_3", (0, 347, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_origin_1", (-2419, -23019, -230));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_angles_1", (0, 357, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_2", (-1356, -20139, -228));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_2", (0, 250, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_3", (-1413, -25619, -225));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_3", (0, 36, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_2", (-1456, -26500, -134));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_2", (0, 345, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_3", (-91, -18495, -228));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_3", (0, 323, 0));
      break;
    case "hills":
      setlocaledefaultvalue("dvar_01AFADBBBA931661", (-9500, -36128, 0));
      setlocaledefaultvalue("scr_brtdm_circle_radius", 11500);
      setlocaledefaultvalue("scr_brtdm_spawn_angles_allies", 40);
      setlocaledefaultvalue("scr_brtdm_spawn_angles_axis", 156);
      setlocaledefaultvalue("dvar_0B133FFCEA455873", 25.0);
      setlocaledefaultvalue("scr_brtdm_spectate_origin", (-6862, -28777, 2602));
      setlocaledefaultvalue("scr_brtdm_spectate_angles", (39, 323, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_0", (-2042, -37869, 763));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_0", (0, 168, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_1", (-3384, -27953, 345));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_1", (0, 218, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_origin_0", (-1681, -32452, 99));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_angles_0", (0, 219, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_0", (-4163, -29770, 337));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_0", (0, 203, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_1", (-3076, -28450, 345));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_1", (0, 149, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_0", (-4725, -38714, 669));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_0", (0, 263, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_1", (-5249, -27281, 98));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_1", (0, 174, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_2", (-17139, -33568, 306));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_2", (0, 7, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_3", (-16560, -28505, 120));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_3", (0, 35, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_origin_1", (-16037, -32024, 277));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_angles_1", (0, 314, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_2", (-18517, -36246, 572));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_2", (0, 350, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_3", (-14810, -41243, 575));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_3", (0, 67, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_2", (-18733, -34650, 345));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_2", (0, 359, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_3", (-15813, -31002, 281));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_3", (0, 58, 0));
      break;
    case "storage":
      setlocaledefaultvalue("dvar_01AFADBBBA931661", (-25639, 7915, 0));
      setlocaledefaultvalue("scr_brtdm_circle_radius", 9000);
      setlocaledefaultvalue("scr_brtdm_spawn_angles_allies", 65);
      setlocaledefaultvalue("scr_brtdm_spawn_angles_axis", 250);
      setlocaledefaultvalue("scr_brtdm_spectate_origin", (-28789, 3796, 279));
      setlocaledefaultvalue("scr_brtdm_spectate_angles", (15, 48, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_0", (-28176, 13758, -520));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_0", (0, 178, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_1", (-19765, 13864, -257));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_1", (0, 290, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_origin_0", (-25942, 14835, -267));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_angles_0", (0, 270, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_0", (-22269, 13624, -259));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_0", (0, 243, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_1", (-29275, 12892, -246));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_1", (0, 198, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_0", (-25599, 14007, -622));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_0", (0, 272, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_1", (-20449, 13593, -258));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_1", (0, 357, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_2", (-24803, 1040, -259));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_2", (0, 48, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_3", (-31106, 2103, -240));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_3", (0, 109, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_origin_1", (-21457, 1579, -256));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_angles_1", (0, 90, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_2", (-31346, 3447, -228));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_2", (0, 176, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_3", (-22954, 2747, -151));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_3", (0, 90, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_2", (-24697, 3934, -256));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_2", (0, 357, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_3", (-27133, 1184, -252));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_3", (0, 351, 0));
      break;
    case "storage_shipment":
      setlocaledefaultvalue("dvar_01AFADBBBA931661", (-25973, 7847, 0));
      setlocaledefaultvalue("scr_brtdm_circle_radius", 4400);
      setlocaledefaultvalue("scr_brtdm_spawn_angles_allies", 90);
      setlocaledefaultvalue("scr_brtdm_spawn_angles_axis", 270);
      setlocaledefaultvalue("scr_brtdm_spawn_height_allies", 1250);
      setlocaledefaultvalue("scr_brtdm_spawn_height_axis", 1250);
      setlocaledefaultvalue("scr_brtdm_spectate_origin", (-27896, 3953, 571));
      setlocaledefaultvalue("scr_brtdm_spectate_angles", (21, 59, 0));
      setlocaledefaultvalue("dvar_0ADB05B8132EC13B", 1);
      break;
    case "dam":
      setlocaledefaultvalue("dvar_01AFADBBBA931661", (-20452, 43152, 5000));
      setlocaledefaultvalue("scr_brtdm_circle_radius", 12000);
      setlocaledefaultvalue("scr_brtdm_spawn_angles_allies", 204);
      setlocaledefaultvalue("scr_brtdm_spawn_angles_axis", 11);
      setlocaledefaultvalue("scr_brtdm_spectate_origin", (-19516, 36814, -422));
      setlocaledefaultvalue("scr_brtdm_spectate_angles", (357, 100, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_0", (-17241, 31978, -160));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_0", (0, 78, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_1", (-28316, 45020, 2750));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_1", (0, 107, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_origin_0", (-24699, 36333, 390));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_angles_0", (0, 55, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_0", (-23725, 35187, 310));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_0", (0, 327, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_1", (-15420, 32642, -170));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_1", (0, 149, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_0", (-29762, 42138, 2660));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_0", (0, 83, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_1", (-22650, 31751, -75));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_1", (0, 64, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_little_bird_origin_0", (-25554, 36568, 475));
      setlocaledefaultvalue("scr_brtdm_vehicle_little_bird_angles_0", (0, 336, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_2", (-16037, 51673, 2750));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_2", (0, 180, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_3", (-9893, 39929, 775));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_3", (0, 182, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_origin_1", (-12436, 46957, 1845));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_angles_1", (0, 36, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_2", (-10316, 39418, 788));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_2", (0, 76, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_3", (-17210, 52283, 2800));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_3", (0, 215, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_2", (-12629, 47575, 1895));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_2", (0, 332, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_3", (-12104, 37484, 70));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_3", (0, 122, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_little_bird_origin_1", (-13447, 46437, 1900));
      setlocaledefaultvalue("scr_brtdm_vehicle_little_bird_angles_1", (0, 206, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_little_bird_origin_2", (-24476, 43361, 660));
      setlocaledefaultvalue("scr_brtdm_vehicle_little_bird_angles_2", (0, 298, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_4", (-23603, 44704, 160));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_4", (0, 10, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_4", (-25505, 43962, 154));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_4", (0, 233, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_5", (-17379, 43475, -470));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_5", (0, 298, 0));
      break;
    case "mil_base":
      setlocaledefaultvalue("dvar_01AFADBBBA931661", (5872, 50100, 0));
      setlocaledefaultvalue("scr_brtdm_circle_radius", 10000);
      setlocaledefaultvalue("scr_brtdm_spawn_angles_allies", 136);
      setlocaledefaultvalue("scr_brtdm_spawn_angles_axis", 297);
      setlocaledefaultvalue("scr_brtdm_spectate_origin", (9131, 54369, 1406));
      setlocaledefaultvalue("scr_brtdm_spectate_angles", (11, 240, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_0", (2545, 58630, 762));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_0", (0, 323, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_1", (1443, 55766, 1083));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_1", (0, 261, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_origin_0", (-991, 53487, 1101));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_angles_0", (0, 313, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_0", (4966, 57483, 1092));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_0", (0, 314, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_1", (1123, 57730, 753));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_1", (0, 276, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_0", (-2161, 54088, 986));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_0", (0, 357, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_1", (3129, 53312, 1076));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_1", (0, 357, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_2", (9361, 43795, 1542));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_2", (0, 105, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_3", (11464, 44385, 1376));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_3", (0, 103, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_origin_1", (11606, 45427, 1127));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_angles_1", (0, 134, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_2", (5657, 45721, 1205));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_2", (0, 45, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_3", (2119, 44324, 1494));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_3", (0, 221, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_2", (12290, 46715, 1089));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_2", (0, 78, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_3", (4415, 46102, 1221));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_3", (0, 133, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_little_bird_origin_0", (2150, 46000, 1600));
      setlocaledefaultvalue("scr_brtdm_vehicle_little_bird_angles_0", (0, 42, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_little_bird_origin_1", (12276, 48974, 1200));
      setlocaledefaultvalue("scr_brtdm_vehicle_little_bird_angles_1", (0, 132, 0));
      break;
    case "karst_bridge":
      setlocaledefaultvalue("dvar_01AFADBBBA931661", (42455, 16503, 0));
      setlocaledefaultvalue("scr_brtdm_circle_radius", 10500);
      setlocaledefaultvalue("scr_brtdm_spawn_angles_allies", 25);
      setlocaledefaultvalue("scr_brtdm_spawn_angles_axis", 203);
      setlocaledefaultvalue("dvar_0B133FFCEA455873", 35.0);
      setlocaledefaultvalue("scr_brtdm_spectate_origin", (39686, 15544, -120));
      setlocaledefaultvalue("scr_brtdm_spectate_angles", (12, 11, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_0", (51614, 15518, 263));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_0", (0, 148, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_1", (45811, 24263, -330));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_1", (0, 228, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_origin_0", (48137, 16713, -270));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_angles_0", (0, 96, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_0", (44736, 17006, -305));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_0", (0, 291, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_1", (44518, 13224, -310));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_1", (0, 155, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_0", (49733, 18097, 15));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_0", (0, 153, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_1", (45970, 24954, -340));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_1", (0, 181, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_little_bird_origin_0", (46588, 19953, 150));
      setlocaledefaultvalue("scr_brtdm_vehicle_little_bird_angles_0", (0, 295, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_2", (34523, 19026, 313));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_2", (0, 320, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_3", (37466, 11429, 745));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_3", (0, 53, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_origin_1", (37558, 13535, 160));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_angles_1", (0, 257, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_2", (38461, 15634, -205));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_2", (0, 310, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_3", (38067, 20032, -170));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_3", (0, 49, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_2", (37354, 22300, 35));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_2", (0, 42, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_3", (36457, 13677, 368));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_3", (0, 335, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_little_bird_origin_1", (37203, 13902, 340));
      setlocaledefaultvalue("scr_brtdm_vehicle_little_bird_angles_1", (0, 20, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_origin_2", (40540, 15603, -302));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_angles_2", (0, 25, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_origin_3", (43693, 17090, -302));
      setlocaledefaultvalue("scr_brtdm_vehicle_cargo_truck_angles_3", (0, 204, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_4", (41479, 16080, -560));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_4", (0, 82, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_5", (43042, 16740, -570));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_5", (0, 266, 0));
      break;
    case "stadium":
      setlocaledefaultvalue("dvar_01AFADBBBA931661", (28681, 2318, 0));
      setlocaledefaultvalue("scr_brtdm_circle_radius", 8200);
      setlocaledefaultvalue("scr_brtdm_spawn_angles_allies", 45);
      setlocaledefaultvalue("scr_brtdm_spawn_angles_axis", 223);
      setlocaledefaultvalue("dvar_0B133FFCEA455873", 40.0);
      setlocaledefaultvalue("scr_brtdm_spawn_height_allies", 1200);
      setlocaledefaultvalue("scr_brtdm_spawn_height_axis", 1200);
      setlocaledefaultvalue("scr_brtdm_spectate_origin", (31146, 7827, 6721));
      setlocaledefaultvalue("scr_brtdm_spectate_angles", (52, 243, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_0", (33225, 7277, -452));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_0", (0, 172, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_1", (29981, 6843, -540));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_1", (0, 353, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_0", (32595, 5128, -615));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_0", (0, 312, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_1", (29427, 7834, -519));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_1", (0, 177, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_0", (28792, 9326, -387));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_0", (0, 172, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_little_bird_origin_0", (33644, 7831, -420));
      setlocaledefaultvalue("scr_brtdm_vehicle_little_bird_angles_0", (0, 227, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_2", (27088, -2862, -806));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_2", (0, 338, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_3", (22958, 866, -515));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_3", (0, 61, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_origin_4", (28840, -4019, -806));
      setlocaledefaultvalue("scr_brtdm_vehicle_atv_angles_4", (0, 6, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_origin_2", (25896, -1985, -802));
      setlocaledefaultvalue("scr_brtdm_vehicle_jeep_angles_2", (0, 46, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_origin_1", (22851, 2160, -506));
      setlocaledefaultvalue("scr_brtdm_vehicle_tac_rover_angles_1", (0, 64, 0));
      setlocaledefaultvalue("scr_brtdm_vehicle_little_bird_origin_1", (23764, -2676, -400));
      setlocaledefaultvalue("scr_brtdm_vehicle_little_bird_angles_1", (0, 39, 0));
      break;
    case "mechanics":
      setlocaledefaultvalue("scr_brtdm_spawn_height_allies", 5000);
      setlocaledefaultvalue("scr_brtdm_spawn_height_axis", 5000);
      setlocaledefaultvalue("scr_brtdm_spectate_origin", (0, 0, 1500));
      setlocaledefaultvalue("scr_brtdm_spectate_angles", (27, 12, 0));
      break;
  }
}

initcircledata() {
  level.br_level = spawnStruct();
  level.br_level.staticcircle = 1;
  level.br_level.br_mapcenter = level.brtdm_config.circlecenter;
  level.br_level.br_mapbounds = [];
  level.br_level.br_mapbounds[0] = (level.br_level.br_mapcenter[0] + level.brtdm_config.circleradius, level.br_level.br_mapcenter[1] + level.brtdm_config.circleradius, 0);
  level.br_level.br_mapbounds[1] = (level.br_level.br_mapcenter[0] - level.brtdm_config.circleradius, level.br_level.br_mapcenter[1] - level.brtdm_config.circleradius, 0);
  level.br_level.br_circleminimapradii = [level.brtdm_config.circleradius, level.brtdm_config.circleradius];
  level.br_level.br_circleradii = [level.brtdm_config.circleradius, level.brtdm_config.circleradius];
  _id_2695A20D4011076D::initcircle();
  level thread _id_2695A20D4011076D::runcircles(0);
  level.br_circle.circleindex = 0;
  setomnvar("ui_br_circle_num", 1);
  setomnvar("ui_br_minimap_radius", level.br_level.br_circleminimapradii[0]);
  _id_2695A20D4011076D::setstaticuicircles(9999, level.br_circle.safecircleui, level.br_circle.dangercircleui, 0);
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  level.brtdm_config.spawnheight["allies"] = getdvarfloat("scr_brtdm_spawn_height_allies", level.brtdm_config.locale_defaults["scr_brtdm_spawn_height_allies"]);
  level.brtdm_config.spawnheight["axis"] = getdvarfloat("scr_brtdm_spawn_height_axis", level.brtdm_config.locale_defaults["scr_brtdm_spawn_height_allies"]);
  level.brtdm_config.spawnvector["allies"] = anglesToForward((0, getdvarfloat("scr_brtdm_spawn_angles_allies", level.brtdm_config.locale_defaults["scr_brtdm_spawn_angles_allies"]), 0));
  level.brtdm_config.spawnvector["axis"] = anglesToForward((0, getdvarfloat("scr_brtdm_spawn_angles_axis", level.brtdm_config.locale_defaults["scr_brtdm_spawn_angles_axis"]), 0));
  level.brtdm_config.spawnanglemin = getdvarfloat("dvar_0B3655FCEA6BD08D", level.brtdm_config.locale_defaults["dvar_0B3655FCEA6BD08D"]);
  level.brtdm_config.spawnanglemax = getdvarfloat("dvar_0B133FFCEA455873", level.brtdm_config.locale_defaults["dvar_0B133FFCEA455873"]);
  level.brtdm_config.spawndistancemin = getdvarfloat("scr_brtdm_spawn_dist_min", level.brtdm_config.locale_defaults["scr_brtdm_spawn_dist_min"]);
  level.brtdm_config.spawndistancemax = getdvarfloat("scr_brtdm_spawn_dist_max", level.brtdm_config.locale_defaults["scr_brtdm_spawn_dist_max"]);
  level.brtdm_config.spawnoffsettacinsertmin = getdvarfloat("dvar_C8E62AADDC230556", 1000);
  level.brtdm_config.spawnoffsettacinsertmax = getdvarfloat("dvar_C9091CADDC492E44", 3000);
  level.brtdm_config.spawnorigin["allies"] = level.brtdm_config.circlecenter + level.brtdm_config.spawnvector["allies"] * level.brtdm_config.circleradius * level.brtdm_config.spawndistancemin;
  level.brtdm_config.spawnorigin["axis"] = level.brtdm_config.circlecenter + level.brtdm_config.spawnvector["axis"] * level.brtdm_config.circleradius * level.brtdm_config.spawndistancemin;
  level.brtdm_config.faceenemyspawn = getdvarint("scr_brtdm_spawn_face_enemy", level.brtdm_config.locale_defaults["scr_brtdm_spawn_face_enemy"]);
  level thread pregeneratespawnpoints();
}

getspawnpoint() {
  if(!isDefined(self.redeployspawn)) {
    self.redeployspawn = spawnStruct();
    return generatespawnpoint();
  }

  self.ti_spawn = 0;

  if(isDefined(self.setspawnpoint)) {
    spawnpoint = self.setspawnpoint;

    if(!istrue(self.setspawnpoint.notti)) {
      self.ti_spawn = 1;
      self playlocalsound("tactical_spawn");

      foreach(_id_F90358454413407F in level.teamnamelist) {
        if(_id_F90358454413407F != self.team)
          self playsoundtoteam("tactical_spawn", _id_F90358454413407F);
      }
    }

    foreach(tank in level.ugvs) {
      if(distancesquared(tank.origin, self.setspawnpoint.playerspawnpos) < 1024)
        tank notify("damage", 5000, tank.owner, (0, 0, 0), (0, 0, 0), "MOD_EXPLOSIVE", "", "", "", undefined, makeweapon("killstreak_jammer_mp"));
    }

    spawnangles = vectortoangles(level.brtdm_config.spawnvector[self.team]);
    _id_6768A915ED3C9351 = randomfloatrange(level.brtdm_config.spawnanglemin, level.brtdm_config.spawnanglemax);
    spawnvector = anglesToForward((0, spawnangles[1] + scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), _id_6768A915ED3C9351, _id_6768A915ED3C9351 * -1), 0));
    _id_53A3ED00687ACC12 = randomfloatrange(level.brtdm_config.spawnoffsettacinsertmin, level.brtdm_config.spawnoffsettacinsertmax);
    spawnorigin = self.setspawnpoint.playerspawnpos + spawnvector * _id_53A3ED00687ACC12;

    if(distance2dsquared(spawnorigin, level.brtdm_config.circlecenter) > level.brtdm_config.circleradius * level.brtdm_config.circleradius) {
      _id_2099C256F875AD40 = vectorNormalize(spawnorigin - level.brtdm_config.circlecenter);
      spawnorigin = level.brtdm_config.circlecenter + _id_2099C256F875AD40 * level.brtdm_config.circleradius * 0.99;
    }

    _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_default_contents(1);
    groundorigin = scripts\engine\utility::drop_to_ground(spawnorigin, 10000, -20000, undefined, _id_FBCABD62B8F66EB8);
    spawnorigin = (spawnorigin[0], spawnorigin[1], groundorigin[2]);
    spawnorigin = spawnorigin + (0, 0, 1) * level.brtdm_config.spawnheight[self.team];

    if(getdvarint("dvar_53B56FCD1AD4A8CE") == 1)
      thread scripts\mp\utility\debug::drawline(spawnorigin, groundorigin, 15.0, (1, 1, 0));

    self.redeployspawn.origin = spawnorigin;
    self.redeployspawn.angles = self.setspawnpoint.playerspawnangles;
    self.redeployspawn.lifeid = self.lifeid;
    self.redeployspawn.time = gettime();
    scripts\mp\equipment\tac_insert::spawnpoint_clearspawnpoint(0, 1);
  } else if(self.redeployspawn.team != self.team || self.redeployspawn.lifeid != self.lifeid)
    return generatespawnpoint();

  return self.redeployspawn;
}

pregeneratespawnpoints() {
  level.redeployspawns = [];
  level.redeployspawns["allies"] = [];
  level.redeployspawns["axis"] = [];
  spawncount = getdvarint("dvar_E1111CE9B4B5EB16", 50);
  _id_E14067C17E332089 = getdvarint("dvar_5951FD67C37A0E30", 5);
  _id_7426330C61B55320 = 0;

  foreach(team in level.teamnamelist) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < spawncount; _id_AC0E594AC96AA3A8++) {
      spawnpoint = spawnStruct();
      spawnangles = vectortoangles(level.brtdm_config.spawnvector[team]);
      _id_6768A915ED3C9351 = randomfloatrange(level.brtdm_config.spawnanglemin, level.brtdm_config.spawnanglemax);
      spawnvector = anglesToForward((0, spawnangles[1] + scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), _id_6768A915ED3C9351, _id_6768A915ED3C9351 * -1), 0));
      _id_53A3ED00687ACC12 = randomfloatrange(level.brtdm_config.spawndistancemin, level.brtdm_config.spawndistancemax);
      spawnorigin = level.brtdm_config.circlecenter + spawnvector * level.brtdm_config.circleradius * _id_53A3ED00687ACC12;

      if(istrue(level.brtdm_config.faceenemyspawn)) {
        _id_D663E897E8857AC3 = level.brtdm_config.spawnorigin[scripts\mp\utility\game::getotherteam(team)[0]] - spawnorigin;
        spawnangles = vectortoangles(_id_D663E897E8857AC3);
      } else
        spawnangles = vectortoangles(spawnvector * -1);

      _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_default_contents(1);
      _id_914989D39AD0D603 = 0;
      highesttraceindex = 0;
      _id_C0FD4E75A105DEAE = 10;
      results = [];

      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_E14067C17E332089; _id_AC0E5C4AC96AAA41++) {
        result = scripts\engine\trace::ray_trace(spawnorigin + (0, 0, 10000), spawnorigin - (0, 0, 20000) + anglesToForward(spawnangles) * _id_AC0E5C4AC96AAA41 * 2000, undefined, _id_FBCABD62B8F66EB8)["position"];
        results[results.size] = result;

        if(result[2] > _id_914989D39AD0D603) {
          _id_914989D39AD0D603 = result[2];
          highesttraceindex = _id_AC0E5C4AC96AAA41;
        }

        _id_7426330C61B55320++;

        if(_id_7426330C61B55320 == 5) {
          waitframe();
          _id_7426330C61B55320 = 0;
        }
      }

      spawnorigin = (spawnorigin[0], spawnorigin[1], _id_914989D39AD0D603 + level.brtdm_config.spawnheight[team]);
      spawnpoint.origin = spawnorigin;
      spawnpoint.traceresults = results;
      spawnpoint.highesttraceindex = highesttraceindex;
      spawnpoint.angles = spawnangles;
      spawnpoint.time = gettime();
      spawnpoint.team = team;
      spawnpoint.index = -1;
      level.redeployspawns[team][level.redeployspawns[team].size] = spawnpoint;
    }
  }
}

generatespawnpoint() {
  index = randomint(level.redeployspawns[self.team].size);
  spawnpoint = level.redeployspawns[self.team][index];
  self.redeployspawn.origin = spawnpoint.origin;
  self.redeployspawn.angles = spawnpoint.angles;
  self.redeployspawn.time = gettime();
  self.redeployspawn.team = self.team;
  self.redeployspawn.index = -1;
  self.redeployspawn.lifeid = self.lifeid;
  return self.redeployspawn;
}

onplayerconnect(player) {
  duration = 9999;
  safecircleent = level.br_circle.safecircleui;
  _id_FB3B2613D6F0EB05 = level.br_circle.dangercircleui;

  if(!isbot(player)) {
    _id_416318EE02BCD7D9 = _id_2695A20D4011076D::_safecircledurationforplayer(player, duration);
    player setclientomnvar("ui_br_circle0_start_time", gettime());
    player setclientomnvar("ui_br_circle0_duration", _id_416318EE02BCD7D9);
    player setclientomnvar("ui_br_circle0_start_entity", safecircleent);
    player setclientomnvar("ui_br_circle0_end_entity", safecircleent);
    player _id_2695A20D4011076D::_hidesafecircleui();
    _id_416318EE02BCD7D9 = _id_2695A20D4011076D::_dangercircledurationforplayer(player, duration);
    player setclientomnvar("ui_br_circle1_start_time", gettime());
    player setclientomnvar("ui_br_circle1_duration", _id_416318EE02BCD7D9);
    player setclientomnvar("ui_br_circle1_start_entity", _id_FB3B2613D6F0EB05);
    player setclientomnvar("ui_br_circle1_end_entity", _id_FB3B2613D6F0EB05);
  }

  if(!scripts\mp\flags::gameflag("prematch_done"))
    player thread manageprematchfade();
}

manageprematchfade(delay_time, _id_C82EABB722C361A7) {
  self endon("disconnect");
  thread infil_radio_idle();

  if(isPlayer(self))
    self setclienttriggeraudiozone("brtdm_intro", 1);

  _id_AD4DD16F29E24B77 = 0.0;
  _id_DFAB0807D83A77FE = 0.5;
  thread scripts\mp\playerlogic::managerespawnfade(_id_AD4DD16F29E24B77, _id_DFAB0807D83A77FE);
  scripts\mp\flags::gameflagwait("prematch_done");
  self clearallsoundsubmixes(6);
  self clearclienttriggeraudiozone(6);
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

  if(getdvarint("dvar_FE3AFD6EAD4AA523", 1) == 1)
    self endon("brWaitAndSpawnClientComplete");

  spawnpoint = getspawnpoint();
  _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);

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
  _id_7E52B56769FA7774::initplayer(1);
  _id_67708F418B1FAC79::gulagwinnerrespawn(1, undefined, spawnpoint, 1, _id_11F3B4465C8B637B, undefined, undefined, 0, 0, 1);
  scripts\mp\damage::resetplayervariables();
  scripts\mp\damage::resetplayeromnvarsonspawn();
}

onspawnplayer(_id_9156B53BCF7CE573) {
  if(level.parachutecancutautodeploy)
    self skydive_cutautodeployon();
  else
    self skydive_cutautodeployoff();

  if(level.parachutecancutparachute)
    self skydive_cutparachuteon();
  else
    self skydive_cutparachuteoff();

  scripts\mp\hud_message::_id_F004EF4606B9EFDC("kill");

  if(level.spawnprotectiontimer > 0) {
    thread removespawnprotectiononnotify();
    thread removespawnprotectiononads();
  }

  thread manageafktracking();
  _id_76CC264B397DB9CB::updatesquadomnvars(self.team, self._id_0FF97225579DE16A);
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

manageafktracking() {
  self endon("disconnect");
  self notify("manageAFKTracking");
  self endon("manageAFKTracking");
  self.ignoreafkcheck = 1;
  thread scripts\mp\class::blockclasschange();
  self waittill("parachute_landed");
  thread scripts\mp\class::unblockclasschange();
  self.ignoreafkcheck = undefined;
  self notify("afk_tracking_resume");
}

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  _id_0FD32F08E72B657F::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  _id_76CC264B397DB9CB::updatesquadomnvars(self.team, self._id_0FF97225579DE16A);
}

ontimelimit() {
  winner = scripts\mp\gamescore::gethighestscoringteam();

  if(game["status"] == "overtime")
    winner = "forfeit";
  else if("tie")
    winner = "overtime";

  thread scripts\mp\gamelogic::endgame(winner, game["end_reason"]["time_limit_reached"]);
}

shouldgamelobbyremainintact() {
  _id_18A3FAB290E780C2 = int(game["teamScores"]["axis"]);
  _id_43A41488C3C487DF = int(game["teamScores"]["allies"]);
  _id_F9C7AAE8C6ACD600 = _id_18A3FAB290E780C2 - _id_43A41488C3C487DF;
  return _id_F9C7AAE8C6ACD600 < 10;
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
  if(!isDefined(level.vehicleinfo))
    level.vehicleinfo = [];

  if(!isDefined(level.brtdm_config.disabledvehicles["little_bird"]))
    registervehicletype("little_bird", ::vehiclespawn_littlebird);

  if(!isDefined(level.brtdm_config.disabledvehicles["atv"]))
    registervehicletype("atv", ::vehiclespawn_atv);

  if(!isDefined(level.brtdm_config.disabledvehicles["tac_rover"]))
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
  _id_CEFFD5A372961F55 = _func_2EF675C13CA1C4AF("dvar_AD95D7262A11119E", _id_7731ADEF63E19B0C);
  index = 0;

  for(;;) {
    _id_F826F0378F17AE2F = _func_2EF675C13CA1C4AF(_id_CEFFD5A372961F55, "_origin_", index);
    _id_0D9C6C3C1205D844 = _func_2EF675C13CA1C4AF(_id_CEFFD5A372961F55, "_angles_", index);
    _id_08A4EA3A3BAA22E4 = (0, 0, 0);

    if(isDefined(level.brtdm_config.locale_defaults[_id_F826F0378F17AE2F]))
      _id_08A4EA3A3BAA22E4 = level.brtdm_config.locale_defaults[_id_F826F0378F17AE2F];

    origin = getdvarvector(_id_F826F0378F17AE2F, _id_08A4EA3A3BAA22E4);

    if(origin == (0, 0, 0)) {
      break;
    }

    if(!_id_2695A20D4011076D::ispointincurrentsafecircle(origin)) {
      index++;
      continue;
    }

    vehicle = spawnStruct();
    vehicle.origin = origin;
    _id_7224BACAB3F8EE26 = (0, 0, 0);

    if(isDefined(level.brtdm_config.locale_defaults[_id_0D9C6C3C1205D844]))
      _id_7224BACAB3F8EE26 = level.brtdm_config.locale_defaults[_id_0D9C6C3C1205D844];

    vehicle.angles = getdvarvector(_id_7224BACAB3F8EE26, _id_7224BACAB3F8EE26);
    vehicle.targetname = _id_7731ADEF63E19B0C;
    vehicle.vehicletype = vehicletype;
    _id_29D9D2428185616D[_id_29D9D2428185616D.size] = vehicle;
    index++;
  }

  return _id_29D9D2428185616D;
}

getatvspawns() {
  _id_29D9D2428185616D = [];

  switch (level.brtdm_config.locale) {
    case "lumber":
      vehicle = spawnStruct();
      vehicle.origin = (53308, 6374, 100);
      vehicle.angles = (0, 155, 0);
      vehicle.targetname = "atv";
      vehicle.vehicletype = "veh9_mil_lnd_atv_physics_mp";
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = vehicle;
      vehicle = spawnStruct();
      vehicle.origin = (52810, 6734, 100);
      vehicle.angles = (0, 250, 0);
      vehicle.targetname = "atv";
      vehicle.vehicletype = "veh9_mil_lnd_atv_physics_mp";
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = vehicle;
      vehicle = spawnStruct();
      vehicle.origin = (49169, -478, 100);
      vehicle.angles = (0, 72, 0);
      vehicle.targetname = "atv";
      vehicle.vehicletype = "veh9_mil_lnd_atv_physics_mp";
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = vehicle;
      vehicle = spawnStruct();
      vehicle.origin = (49156, 1313, 100);
      vehicle.angles = (0, 60, 0);
      vehicle.targetname = "atv";
      vehicle.vehicletype = "veh9_mil_lnd_atv_physics_mp";
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = vehicle;
      break;
    case "":
      vehicle = spawnStruct();
      vehicle.origin = (500, -3000, 0);
      vehicle.angles = (0, 90, 0);
      vehicle.targetname = "atv";
      vehicle.vehicletype = "veh9_mil_lnd_atv_physics_mp";
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = vehicle;
      vehicle = spawnStruct();
      vehicle.origin = (-500, 2000, 0);
      vehicle.angles = (0, 270, 0);
      vehicle.targetname = "atv";
      vehicle.vehicletype = "veh9_mil_lnd_atv_physics_mp";
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = vehicle;
      break;
  }

  return _id_29D9D2428185616D;
}

gettacroverspawns() {
  _id_29D9D2428185616D = [];

  switch (level.brtdm_config.locale) {
    case "lumber":
      vehicle = spawnStruct();
      vehicle.origin = (53180, 7980, 100);
      vehicle.angles = (0, 255, 0);
      vehicle.targetname = "tac_rover";
      vehicle.vehicletype = "tromeo_physics_mp";
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = vehicle;
      vehicle = spawnStruct();
      vehicle.origin = (53767, 7455, 100);
      vehicle.angles = (0, 270, 0);
      vehicle.targetname = "tac_rover";
      vehicle.vehicletype = "tromeo_physics_mp";
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = vehicle;
      vehicle = spawnStruct();
      vehicle.origin = (48642, -115, 100);
      vehicle.angles = (0, 23, 0);
      vehicle.targetname = "tac_rover";
      vehicle.vehicletype = "tromeo_physics_mp";
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = vehicle;
      vehicle = spawnStruct();
      vehicle.origin = (50339, 559, 100);
      vehicle.angles = (0, 58, 0);
      vehicle.targetname = "tac_rover";
      vehicle.vehicletype = "tromeo_physics_mp";
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = vehicle;
      break;
    case "":
      vehicle = spawnStruct();
      vehicle.origin = (2000, -3000, 0);
      vehicle.angles = (0, 90, 0);
      vehicle.targetname = "tac_rover";
      vehicle.vehicletype = "tromeo_physics_mp";
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = vehicle;
      vehicle = spawnStruct();
      vehicle.origin = (-2000, 2000, 0);
      vehicle.angles = (0, 270, 0);
      vehicle.targetname = "tac_rover";
      vehicle.vehicletype = "tromeo_physics_mp";
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = vehicle;
      break;
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

  if(getdvarint("dvar_0ADB05B8132EC13B", level.brtdm_config.locale_defaults["dvar_0ADB05B8132EC13B"]) == 1)
    return _id_7CB19F95DBC68942;

  foreach(struct in _id_9E4E1482CB40C9C5) {
    if(distance2dsquared(struct.origin, level.brtdm_config.circlecenter) < level.brtdm_config.circleradius * level.brtdm_config.circleradius)
      _id_7CB19F95DBC68942[_id_7CB19F95DBC68942.size] = struct;
  }

  return _id_7CB19F95DBC68942;
}

initprematchc130() {
  level waittill("prematch_countdown");
  _id_FBA760F7C08B6FBB = 15000;
  _id_DC12F67D76B34297 = 50000;
  _id_478490ADDCC8AA79 = 5000;
  _id_65A8A4791DDD85D8 = 10;
  _id_6F680EE249F67B0D = vectortoangles(level.brtdm_config.spawnvector["allies"] * -1);
  pathdir = anglesToForward((0, _id_6F680EE249F67B0D[1] + _id_65A8A4791DDD85D8, 0));
  startpt = level.brtdm_config.circlecenter + level.brtdm_config.spawnvector["allies"] * (level.brtdm_config.circleradius + _id_FBA760F7C08B6FBB) + (0, 0, 1);
  endpt = level.brtdm_config.circlecenter + pathdir * (level.brtdm_config.circleradius * 2 + _id_DC12F67D76B34297);
  _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_default_contents(1);
  startpt = scripts\engine\utility::drop_to_ground(startpt, level.brtdm_config.spawnheight["allies"], -1 * level.brtdm_config.spawnheight["allies"], undefined, _id_FBCABD62B8F66EB8);
  startpt = startpt + (0, 0, 1) * (level.brtdm_config.spawnheight["allies"] + _id_478490ADDCC8AA79);
  endpt = scripts\engine\utility::drop_to_ground(endpt, level.brtdm_config.spawnheight["allies"], -1 * level.brtdm_config.spawnheight["allies"], undefined, _id_FBCABD62B8F66EB8);
  endpt = endpt + (0, 0, 1) * (level.brtdm_config.spawnheight["allies"] + _id_478490ADDCC8AA79);
  pathstruct = spawnStruct();
  pathstruct.startpt = startpt;
  pathstruct.endpt = endpt;
  pathstruct.angle = vectortoangles(pathdir);
  dist = distance(pathstruct.startpt, pathstruct.endpt);
  travelspeed = _id_45B2B4A889E633FA::getc130speed();
  time = dist / travelspeed;
  _id_184D0A0CE31A2B27 = _id_2E385BC294259245::c130airdrop_spawn(pathstruct, dist, travelspeed, time);
  _id_184D0A0CE31A2B27 _id_2E385BC294259245::c130airdrop_startdelivery(0);
  _id_6F680EE249F67B0D = vectortoangles(level.brtdm_config.spawnvector["axis"] * -1);
  pathdir = anglesToForward((0, _id_6F680EE249F67B0D[1] + _id_65A8A4791DDD85D8, 0));
  startpt = level.brtdm_config.circlecenter + level.brtdm_config.spawnvector["axis"] * (level.brtdm_config.circleradius + _id_FBA760F7C08B6FBB) + (0, 0, 1);
  endpt = level.brtdm_config.circlecenter + pathdir * (level.brtdm_config.circleradius * 2 + _id_DC12F67D76B34297);
  startpt = scripts\engine\utility::drop_to_ground(startpt, level.brtdm_config.spawnheight["axis"], -1 * level.brtdm_config.spawnheight["axis"], undefined, _id_FBCABD62B8F66EB8);
  startpt = startpt + (0, 0, 1) * (level.brtdm_config.spawnheight["axis"] + _id_478490ADDCC8AA79);
  endpt = scripts\engine\utility::drop_to_ground(endpt, level.brtdm_config.spawnheight["axis"], -1 * level.brtdm_config.spawnheight["axis"], undefined, _id_FBCABD62B8F66EB8);
  endpt = endpt + (0, 0, 1) * (level.brtdm_config.spawnheight["axis"] + _id_478490ADDCC8AA79);
  pathstruct = spawnStruct();
  pathstruct.startpt = startpt;
  pathstruct.endpt = endpt;
  pathstruct.angle = vectortoangles(pathdir);
  dist = distance(pathstruct.startpt, pathstruct.endpt);
  travelspeed = _id_45B2B4A889E633FA::getc130speed();
  time = dist / travelspeed;
  _id_184D0A0CE31A2B27 = _id_2E385BC294259245::c130airdrop_spawn(pathstruct, dist, travelspeed, time);
  _id_184D0A0CE31A2B27 _id_2E385BC294259245::c130airdrop_startdelivery(0);
}

infil_radio_idle() {
  self endon("death_or_disconnect");

  if(isPlayer(self)) {
    _id_E014D2BCF2D12FAC = spawn("script_origin", (0, 0, 0));
    _id_E014D2BCF2D12FAC showonlytoplayer(self);

    if(isDefined(self.team)) {
      _id_1D6DF6A17CEE3314 = scripts\mp\utility\teams::getteamvoiceinfix(self.team);
      _id_53787B74A16A9D5E = "dx_mpo_" + _id_1D6DF6A17CEE3314 + "op_drone_deathchatter";
    } else
      _id_53787B74A16A9D5E = "dx_mpo_ruop_drone_deathchatter";

    if(!soundexists(_id_53787B74A16A9D5E))
      _id_53787B74A16A9D5E = "dx_mpo_ruop_drone_deathchatter";

    _id_E014D2BCF2D12FAC playLoopSound(_id_53787B74A16A9D5E);
    scripts\mp\flags::gameflagwait("prematch_done");
    wait 2;
    _id_E014D2BCF2D12FAC stoploopsound(_id_53787B74A16A9D5E);
    _id_E014D2BCF2D12FAC delete();
  }
}

vehicle_compass_br_shouldbevisibletoplayer(vehicle, player) {
  return 1;
}