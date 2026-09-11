/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\brtdm.gsc
***********************************************/

function main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }

  level.ref_14434 = 1;
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  GscBinSkip1(0x45, 0, scripts\mp\utility\game::getgametype());
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_war_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  setdynamicdvar("scr_war_promode", 0);
}

function onstartgametype() {
  setclientnamemode("auto_change");

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
    scripts\mp\utility\game::setobjectivetext(var3, &"OBJECTIVES/WAR");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var3, &"OBJECTIVES/WAR");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var3, &"OBJECTIVES/WAR_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var3, &"OBJECTIVES/WAR_HINT");
  }

  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_compass", "shouldBeVisibleToPlayer", &ref_1411d);
  technical_initomnvars();
  initspawns();
  scripts\mp\gametypes\bradley_spawner::inittankspawns();
  level thread scripts\mp\gametypes\br_vehicles::brvehiclesonstartgametype();
  trace_to_eye_weight();
  thread tokenrespawnwaittime();
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  setDvar("NKTQRKRMTS", getdvarint("scr_brtdm_fallDamageMinHeight", 560));
  setDvar("LKMOLLSKKO", getdvarint("scr_brtdm_fallDamageMaxHeight", 561));
  setDvar("OMLLLQKQSR", getdvarint("scr_brtdm_softLandingMinHeight", 560));
  setDvar("LTMMLKRKTR", getdvarint("scr_brtdm_softLandingMaxHeight", 561));
  level.checkpoint_objective_id = getdvarint("scr_dmz_autoRespawnWaitTime", 3);
  level.ref_121cc = getdvarfloat("scr_bmo_parachuteDeployDelay", 0.5);
  level.endsuperdisableweaponbr = spawnStruct();
  level.endsuperdisableweaponbr.locale = getDvar("scr_brtdm_locale", "");
  calculate_zone_node_extents();
  level.endsuperdisableweaponbr.circlecenter = getdvarvector("scr_brtdm_circle_center", level.endsuperdisableweaponbr.ref_1196b["scr_brtdm_circle_center"]);
  level.endsuperdisableweaponbr.gulagfadetoblackspectatorsofplayer = getdvarint("scr_brtdm_circle_radius", level.endsuperdisableweaponbr.ref_1196b["scr_brtdm_circle_radius"]);

  if(!scripts\mp\utility\game::matchmakinggame()) {
    setDvar("scr_brtdm_circle_center", level.endsuperdisableweaponbr.circlecenter);
    setDvar("scr_brtdm_circle_radius", level.endsuperdisableweaponbr.gulagfadetoblackspectatorsofplayer);
  }

  level.endsuperdisableweaponbr.load_relics_vfx = [];
  var0 = ["little_bird", "little_bird_mg", "atv", "cargo_truck", "cargo_truck_mg", "jeep", "tac_rover"];

  foreach(var2 in var0) {
    if(getdvarint("scr_brtdm_vehicle_disable_" + var2, 0) == 1) {
      level.endsuperdisableweaponbr.load_relics_vfx[var2] = 1;
    }
  }

  level.endsuperdisableweaponbr.ref_136dc = spawnStruct();
  level.endsuperdisableweaponbr.ref_136dc.origin = getdvarvector("scr_brtdm_spectate_origin", level.endsuperdisableweaponbr.ref_1196b["scr_brtdm_spectate_origin"]);
  level.endsuperdisableweaponbr.ref_136dc.angles = getdvarvector("scr_brtdm_spectate_angles", level.endsuperdisableweaponbr.ref_1196b["scr_brtdm_spectate_angles"]);
}

function ref_1316d(var0, var1) {
  level.endsuperdisableweaponbr.ref_1196b[var0] = var1;
}

function calculate_zone_node_extents() {
  level.endsuperdisableweaponbr.ref_1196b = [];
  ref_1316d("scr_brtdm_circle_center", (0, 0, 0));
  ref_1316d("scr_brtdm_circle_radius", 10000);
  ref_1316d("scr_brtdm_spawn_angles_allies", 0);
  ref_1316d("scr_brtdm_spawn_angles_axis", 180);
  ref_1316d("scr_brtdm_spawn_height_allies", 2500);
  ref_1316d("scr_brtdm_spawn_height_axis", 2500);
  ref_1316d("scr_brtdm_spawn_angle_min", 0);
  ref_1316d("scr_brtdm_spawn_angle_max", 30);
  ref_1316d("scr_brtdm_spawn_dist_min", 0.9);
  ref_1316d("scr_brtdm_spawn_dist_max", 0.99);
  ref_1316d("scr_brtdm_spawn_face_enemy", 0);
  ref_1316d("scr_brtdm_spectate_origin", (0, 0, 0));
  ref_1316d("scr_brtdm_spectate_angles", (0, 0, 0));
  ref_1316d("scr_brtdm_disable_radiant_vehicles", 0);
  ref_1316d("scr_brtdm_vehicle_atv_origin_0", (0, 0, 0));
  ref_1316d("scr_brtdm_vehicle_atv_angles_0", (0, 0, 0));
  ref_1316d("scr_brtdm_vehicle_jeep_origin_0", (0, 0, 0));
  ref_1316d("scr_brtdm_vehicle_jeep_angles_0", (0, 0, 0));
  ref_1316d("scr_brtdm_vehicle_cargo_truck_origin_0", (0, 0, 0));
  ref_1316d("scr_brtdm_vehicle_cargo_truck_angles_0", (0, 0, 0));
  ref_1316d("scr_brtdm_vehicle_tac_rover_origin_0", (0, 0, 0));
  ref_1316d("scr_brtdm_vehicle_tac_rover_angles_0", (0, 0, 0));
  ref_1316d("scr_brtdm_vehicle_little_bird_origin_0", (0, 0, 0));
  ref_1316d("scr_brtdm_vehicle_little_bird_angles_0", (0, 0, 0));

  switch (level.endsuperdisableweaponbr.locale) {
    case "lumber":
      ref_1316d("scr_brtdm_circle_center", (51500, 3500, 0));
      ref_1316d("scr_brtdm_circle_radius", 12000);
      ref_1316d("scr_brtdm_spawn_angles_allies", 238);
      ref_1316d("scr_brtdm_spawn_angles_axis", 67);
      ref_1316d("scr_brtdm_spectate_origin", (48265, 2555, 1580));
      ref_1316d("scr_brtdm_spectate_angles", (27, 12, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_0", (53308, 6374, 100));
      ref_1316d("scr_brtdm_vehicle_atv_angles_0", (0, 155, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_1", (52810, 6734, 100));
      ref_1316d("scr_brtdm_vehicle_atv_angles_1", (0, 250, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_2", (49169, -478, 100));
      ref_1316d("scr_brtdm_vehicle_atv_angles_2", (0, 72, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_3", (49156, 1313, 100));
      ref_1316d("scr_brtdm_vehicle_atv_angles_3", (0, 60, 0));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_origin_0", (52481, 5490, 0));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_angles_0", (0, 247, 0));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_origin_1", (49837, 1321, 0));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_angles_1", (0, 26, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_0", (54585, 6990, 100));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_0", (0, 323, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_1", (51816, 6727, 100));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_1", (0, 200, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_2", (49599, -109, 100));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_2", (0, 333, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_3", (48721, 1557, 100));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_3", (0, 131, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_0", (53180, 7980, 100));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_0", (0, 255, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_1", (53767, 7455, 100));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_1", (0, 270, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_2", (48642, -115, 100));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_2", (0, 23, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_3", (50339, 559, 100));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_3", (0, 58, 0));
      break;
    case "frozen_pond":
      ref_1316d("scr_brtdm_circle_center", (783, 36394, 2700));
      ref_1316d("scr_brtdm_circle_radius", 10500);
      ref_1316d("scr_brtdm_spawn_angles_allies", 117);
      ref_1316d("scr_brtdm_spawn_angles_axis", 346);
      ref_1316d("scr_brtdm_spawn_angle_max", 25);
      ref_1316d("scr_brtdm_spawn_face_enemy", 1);
      ref_1316d("scr_brtdm_spectate_origin", (8400, 33925, 4834));
      ref_1316d("scr_brtdm_spectate_angles", (34, 104, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_0", (571, 45632, 1500));
      ref_1316d("scr_brtdm_vehicle_atv_angles_0", (0, 223, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_1", (-3332, 40505, 2140));
      ref_1316d("scr_brtdm_vehicle_atv_angles_1", (0, 253, 0));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_origin_0", (-8780, 34027, 25));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_angles_0", (0, 317, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_0", (-3948, 43505, 2329));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_0", (0, 303, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_1", (-7129, 40319, 959));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_1", (0, 291, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_0", (-3004, 43593, 2356));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_0", (0, 271, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_1", (588, 44667, 1495));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_1", (0, 323, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_2", (10118, 36471, 1902));
      ref_1316d("scr_brtdm_vehicle_atv_angles_2", (0, 141, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_3", (9073, 32831, 1692));
      ref_1316d("scr_brtdm_vehicle_atv_angles_3", (0, 103, 0));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_origin_1", (2617, 27523, 72));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_angles_1", (0, 142, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_2", (5061, 30887, 425));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_2", (0, 168, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_3", (9013, 37678, 1752));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_3", (0, 194, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_2", (7568, 33763, 1912));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_2", (0, 135, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_3", (9777, 33387, 1700));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_3", (0, 128, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_4", (-699, 30843, -34));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_4", (0, 147, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_5", (-4770, 30535, -219));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_5", (0, 343, 0));
      break;
    case "port_trenches":
      ref_1316d("scr_brtdm_circle_center", (40225, -30954, -100));
      ref_1316d("scr_brtdm_circle_radius", 10250);
      ref_1316d("scr_brtdm_spawn_angles_allies", 216);
      ref_1316d("scr_brtdm_spawn_angles_axis", 55);
      ref_1316d("scr_brtdm_spawn_height_allies", 2000);
      ref_1316d("scr_brtdm_spawn_height_axis", 2000);
      ref_1316d("scr_brtdm_spawn_angle_max", 15);
      ref_1316d("scr_brtdm_spawn_dist_max", 0.95);
      ref_1316d("scr_brtdm_spectate_origin", (38843, -39882, -25));
      ref_1316d("scr_brtdm_spectate_angles", (1, 43, 0));
      ref_1316d("scr_brtdm_vehicle_atv_angles_0", (0, 88, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_1", (34474, -38278, -483));
      ref_1316d("scr_brtdm_vehicle_atv_angles_1", (0, 330, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_2", (32135, -34379, -449));
      ref_1316d("scr_brtdm_vehicle_atv_angles_2", (0, 105, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_0", (34938, -35005, -350));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_0", (0, 358, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_1", (35742, -39576, -519));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_1", (0, 31, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_0", (31217, -33896, -506));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_0", (0, 88, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_1", (31178, -31874, -507));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_1", (0, 36, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_3", (46648, -25226, -369));
      ref_1316d("scr_brtdm_vehicle_atv_angles_3", (0, 228, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_4", (44233, -24413, -374));
      ref_1316d("scr_brtdm_vehicle_atv_angles_4", (0, 263, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_5", (42296, -23065, -382));
      ref_1316d("scr_brtdm_vehicle_atv_angles_5", (0, 195, 0));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_origin_0", (42507, -24819, -441));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_angles_0", (0, 246, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_2", (40389, -22449, -505));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_2", (0, 216, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_3", (40090, -24011, -500));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_3", (0, 197, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_4", (46988, -24370, -337));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_4", (0, 252, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_2", (45277, -29397, 202));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_2", (0, 199, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_3", (40374, -24937, -507));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_3", (0, 284, 0));
      ref_1316d("scr_brtdm_vehicle_little_bird_origin_0", (46500, -24005, -180));
      ref_1316d("scr_brtdm_vehicle_little_bird_angles_0", (0, 245, 0));
      break;
    case "downtown_park":
      ref_1316d("scr_brtdm_circle_center", (20548, -30577, 0));
      ref_1316d("scr_brtdm_circle_radius", 10000);
      ref_1316d("scr_brtdm_spawn_angles_allies", 83);
      ref_1316d("scr_brtdm_spawn_angles_axis", 224);
      ref_1316d("scr_brtdm_spawn_height_allies", 1500);
      ref_1316d("scr_brtdm_spawn_height_axis", 1500);
      ref_1316d("scr_brtdm_spawn_angle_max", 15);
      ref_1316d("scr_brtdm_spawn_dist_min", 0.65);
      ref_1316d("scr_brtdm_spawn_dist_max", 0.75);
      ref_1316d("scr_brtdm_spawn_face_enemy", 1);
      ref_1316d("scr_brtdm_spectate_origin", (17027, -35357, 1505));
      ref_1316d("scr_brtdm_spectate_angles", (21, 63, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_0", (21764, -24164, -142));
      ref_1316d("scr_brtdm_vehicle_atv_angles_0", (0, 174, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_1", (19780, -21087, -78));
      ref_1316d("scr_brtdm_vehicle_atv_angles_1", (0, 212, 0));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_origin_0", (21514, -23467, -131));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_angles_0", (0, 225, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_0", (21033, -22870, -174));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_0", (0, 223, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_1", (24268, -23630, -134));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_1", (0, 277, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_0", (19014, -23313, -181));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_0", (0, 138, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_1", (27090, -24785, -334));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_1", (0, 267, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_2", (16600, -34006, 378));
      ref_1316d("scr_brtdm_vehicle_atv_angles_2", (0, 37, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_3", (19450, -35595, -350));
      ref_1316d("scr_brtdm_vehicle_atv_angles_3", (0, 7, 0));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_origin_1", (13998, -33209, -183));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_angles_1", (0, 88, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_2", (14357, -33952, -198));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_2", (0, 91, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_3", (16839, -32558, 76));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_3", (0, 86, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_2", (17902, -37318, -312));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_2", (0, 14, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_3", (18828, -34025, 75));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_3", (0, 15, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_4", (17563, -32733, 75));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_4", (0, 58, 0));
      ref_1316d("scr_brtdm_vehicle_little_bird_origin_1", (15583, -36396, 500));
      ref_1316d("scr_brtdm_vehicle_little_bird_angles_1", (0, 71, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_5", (19482, -27539, -210));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_5", (0, 335, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_6", (19072, -30488, -208));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_7", (0, 33, 0));
      break;
    case "hospital_hill":
      ref_1316d("scr_brtdm_circle_center", (3381, -6288, 750));
      ref_1316d("scr_brtdm_circle_radius", 10000);
      ref_1316d("scr_brtdm_spawn_angles_allies", 64);
      ref_1316d("scr_brtdm_spawn_angles_axis", 234);
      ref_1316d("scr_brtdm_spawn_height_allies", 3000);
      ref_1316d("scr_brtdm_spawn_angle_max", 20);
      ref_1316d("scr_brtdm_spectate_origin", (-384, -14886, 2237));
      ref_1316d("scr_brtdm_spectate_angles", (19, 54, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_0", (7968, 1753, 164));
      ref_1316d("scr_brtdm_vehicle_atv_angles_0", (0, 328, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_1", (5668, 2760, -514));
      ref_1316d("scr_brtdm_vehicle_atv_angles_1", (0, 172, 0));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_origin_0", (4071, 2010, -450));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_angles_0", (0, 250, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_0", (10647, -2434, -256));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_0", (0, 355, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_1", (2658, 2352, -392));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_1", (0, 192, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_0", (4700, 1713, -510));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_0", (0, 269, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_1", (9716, 596, -235));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_1", (0, 268, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_2", (-4398, -11073, -150));
      ref_1316d("scr_brtdm_vehicle_atv_angles_2", (0, 58, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_3", (1755, -15241, -223));
      ref_1316d("scr_brtdm_vehicle_atv_angles_3", (0, 12, 0));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_origin_1", (-5265, -8379, -430));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_angles_1", (0, 18, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_2", (4103, -13423, -229));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_2", (0, 110, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_3", (6098, -13238, -228));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_3", (0, 85, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_2", (-2860, -9972, 109));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_2", (0, 120, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_3", (-4575, -6185, -330));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_3", (0, 321, 0));
      ref_1316d("scr_brtdm_vehicle_little_bird_origin_0", (-4760, -2885, 750));
      ref_1316d("scr_brtdm_vehicle_little_bird_angles_0", (0, 360, 0));
      break;
    case "east_promenade":
      ref_1316d("scr_brtdm_circle_center", (3995, -22767, 0));
      ref_1316d("scr_brtdm_circle_radius", 8000);
      ref_1316d("scr_brtdm_spawn_angles_allies", 11);
      ref_1316d("scr_brtdm_spawn_angles_axis", 171);
      ref_1316d("scr_brtdm_spectate_origin", (-2763, -18250, 2498));
      ref_1316d("scr_brtdm_spectate_angles", (32, 309, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_0", (11226, -22558, -150));
      ref_1316d("scr_brtdm_vehicle_atv_angles_0", (0, 103, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_1", (9301, -19445, -226));
      ref_1316d("scr_brtdm_vehicle_atv_angles_1", (0, 191, 0));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_origin_0", (9728, -21523, -235));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_angles_0", (0, 193, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_0", (9504, -25962, -228));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_0", (0, 130, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_1", (8586, -19265, -228));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_1", (0, 173, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_0", (4201, -29392, -60));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_0", (0, 199, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_1", (7613, -27816, -92));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_1", (0, 140, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_2", (-2062, -19315, -228));
      ref_1316d("scr_brtdm_vehicle_atv_angles_2", (0, 87, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_3", (-2783, -26033, -74));
      ref_1316d("scr_brtdm_vehicle_atv_angles_3", (0, 347, 0));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_origin_1", (-2419, -23019, -230));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_angles_1", (0, 357, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_2", (-1356, -20139, -228));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_2", (0, 250, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_3", (-1413, -25619, -225));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_3", (0, 36, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_2", (-1456, -26500, -134));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_2", (0, 345, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_3", (-91, -18495, -228));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_3", (0, 323, 0));
      break;
    case "hills":
      ref_1316d("scr_brtdm_circle_center", (-9500, -36128, 0));
      ref_1316d("scr_brtdm_circle_radius", 11500);
      ref_1316d("scr_brtdm_spawn_angles_allies", 40);
      ref_1316d("scr_brtdm_spawn_angles_axis", 156);
      ref_1316d("scr_brtdm_spawn_angle_max", 25);
      ref_1316d("scr_brtdm_spectate_origin", (-6862, -28777, 2602));
      ref_1316d("scr_brtdm_spectate_angles", (39, 323, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_0", (-2042, -37869, 763));
      ref_1316d("scr_brtdm_vehicle_atv_angles_0", (0, 168, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_1", (-3384, -27953, 345));
      ref_1316d("scr_brtdm_vehicle_atv_angles_1", (0, 218, 0));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_origin_0", (-1681, -32452, 99));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_angles_0", (0, 219, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_0", (-4163, -29770, 337));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_0", (0, 203, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_1", (-3076, -28450, 345));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_1", (0, 149, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_0", (-4725, -38714, 669));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_0", (0, 263, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_1", (-5249, -27281, 98));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_1", (0, 174, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_2", (-17139, -33568, 306));
      ref_1316d("scr_brtdm_vehicle_atv_angles_2", (0, 7, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_3", (-16560, -28505, 120));
      ref_1316d("scr_brtdm_vehicle_atv_angles_3", (0, 35, 0));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_origin_1", (-16037, -32024, 277));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_angles_1", (0, 314, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_2", (-18517, -36246, 572));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_2", (0, 350, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_3", (-14810, -41243, 575));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_3", (0, 67, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_2", (-18733, -34650, 345));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_2", (0, 359, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_3", (-15813, -31002, 281));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_3", (0, 58, 0));
      break;
    case "storage":
      ref_1316d("scr_brtdm_circle_center", (-25639, 7915, 0));
      ref_1316d("scr_brtdm_circle_radius", 9000);
      ref_1316d("scr_brtdm_spawn_angles_allies", 65);
      ref_1316d("scr_brtdm_spawn_angles_axis", 250);
      ref_1316d("scr_brtdm_spectate_origin", (-28789, 3796, 279));
      ref_1316d("scr_brtdm_spectate_angles", (15, 48, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_0", (-28176, 13758, -520));
      ref_1316d("scr_brtdm_vehicle_atv_angles_0", (0, 178, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_1", (-19765, 13864, -257));
      ref_1316d("scr_brtdm_vehicle_atv_angles_1", (0, 290, 0));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_origin_0", (-25942, 14835, -267));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_angles_0", (0, 270, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_0", (-22269, 13624, -259));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_0", (0, 243, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_1", (-29275, 12892, -246));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_1", (0, 198, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_0", (-25599, 14007, -622));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_0", (0, 272, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_1", (-20449, 13593, -258));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_1", (0, 357, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_2", (-24803, 1040, -259));
      ref_1316d("scr_brtdm_vehicle_atv_angles_2", (0, 48, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_3", (-31106, 2103, -240));
      ref_1316d("scr_brtdm_vehicle_atv_angles_3", (0, 109, 0));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_origin_1", (-21457, 1579, -256));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_angles_1", (0, 90, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_2", (-31346, 3447, -228));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_2", (0, 176, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_3", (-22954, 2747, -151));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_3", (0, 90, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_2", (-24697, 3934, -256));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_2", (0, 357, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_3", (-27133, 1184, -252));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_3", (0, 351, 0));
      break;
    case "storage_shipment":
      ref_1316d("scr_brtdm_circle_center", (-25973, 7847, 0));
      ref_1316d("scr_brtdm_circle_radius", 4400);
      ref_1316d("scr_brtdm_spawn_angles_allies", 90);
      ref_1316d("scr_brtdm_spawn_angles_axis", 270);
      ref_1316d("scr_brtdm_spawn_height_allies", 1250);
      ref_1316d("scr_brtdm_spawn_height_axis", 1250);
      ref_1316d("scr_brtdm_spectate_origin", (-27896, 3953, 571));
      ref_1316d("scr_brtdm_spectate_angles", (21, 59, 0));
      ref_1316d("scr_brtdm_disable_radiant_vehicles", 1);
      break;
    case "dam":
      ref_1316d("scr_brtdm_circle_center", (-20452, 43152, 5000));
      ref_1316d("scr_brtdm_circle_radius", 12000);
      ref_1316d("scr_brtdm_spawn_angles_allies", 204);
      ref_1316d("scr_brtdm_spawn_angles_axis", 11);
      ref_1316d("scr_brtdm_spectate_origin", (-19516, 36814, -422));
      ref_1316d("scr_brtdm_spectate_angles", (357, 100, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_0", (-17241, 31978, -160));
      ref_1316d("scr_brtdm_vehicle_atv_angles_0", (0, 78, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_1", (-28316, 45020, 2750));
      ref_1316d("scr_brtdm_vehicle_atv_angles_1", (0, 107, 0));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_origin_0", (-24699, 36333, 390));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_angles_0", (0, 55, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_0", (-23725, 35187, 310));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_0", (0, 327, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_1", (-15420, 32642, -170));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_1", (0, 149, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_0", (-29762, 42138, 2660));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_0", (0, 83, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_1", (-22650, 31751, -75));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_1", (0, 64, 0));
      ref_1316d("scr_brtdm_vehicle_little_bird_origin_0", (-25554, 36568, 475));
      ref_1316d("scr_brtdm_vehicle_little_bird_angles_0", (0, 336, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_2", (-16037, 51673, 2750));
      ref_1316d("scr_brtdm_vehicle_atv_angles_2", (0, 180, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_3", (-9893, 39929, 775));
      ref_1316d("scr_brtdm_vehicle_atv_angles_3", (0, 182, 0));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_origin_1", (-12436, 46957, 1845));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_angles_1", (0, 36, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_2", (-10316, 39418, 788));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_2", (0, 76, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_3", (-17210, 52283, 2800));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_3", (0, 215, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_2", (-12629, 47575, 1895));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_2", (0, 332, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_3", (-12104, 37484, 70));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_3", (0, 122, 0));
      ref_1316d("scr_brtdm_vehicle_little_bird_origin_1", (-13447, 46437, 1900));
      ref_1316d("scr_brtdm_vehicle_little_bird_angles_1", (0, 206, 0));
      ref_1316d("scr_brtdm_vehicle_little_bird_origin_2", (-24476, 43361, 660));
      ref_1316d("scr_brtdm_vehicle_little_bird_angles_2", (0, 298, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_4", (-23603, 44704, 160));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_4", (0, 10, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_4", (-25505, 43962, 154));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_4", (0, 233, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_5", (-17379, 43475, -470));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_5", (0, 298, 0));
      break;
    case "mil_base":
      ref_1316d("scr_brtdm_circle_center", (5872, 50100, 0));
      ref_1316d("scr_brtdm_circle_radius", 10000);
      ref_1316d("scr_brtdm_spawn_angles_allies", 136);
      ref_1316d("scr_brtdm_spawn_angles_axis", 297);
      ref_1316d("scr_brtdm_spectate_origin", (9131, 54369, 1406));
      ref_1316d("scr_brtdm_spectate_angles", (11, 240, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_0", (2545, 58630, 762));
      ref_1316d("scr_brtdm_vehicle_atv_angles_0", (0, 323, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_1", (1443, 55766, 1083));
      ref_1316d("scr_brtdm_vehicle_atv_angles_1", (0, 261, 0));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_origin_0", (-991, 53487, 1101));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_angles_0", (0, 313, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_0", (4966, 57483, 1092));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_0", (0, 314, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_1", (1123, 57730, 753));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_1", (0, 276, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_0", (-2161, 54088, 986));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_0", (0, 357, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_1", (3129, 53312, 1076));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_1", (0, 357, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_2", (9361, 43795, 1542));
      ref_1316d("scr_brtdm_vehicle_atv_angles_2", (0, 105, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_3", (11464, 44385, 1376));
      ref_1316d("scr_brtdm_vehicle_atv_angles_3", (0, 103, 0));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_origin_1", (11606, 45427, 1127));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_angles_1", (0, 134, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_2", (5657, 45721, 1205));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_2", (0, 45, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_3", (2119, 44324, 1494));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_3", (0, 221, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_2", (12290, 46715, 1089));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_2", (0, 78, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_3", (4415, 46102, 1221));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_3", (0, 133, 0));
      ref_1316d("scr_brtdm_vehicle_little_bird_origin_0", (2150, 46000, 1600));
      ref_1316d("scr_brtdm_vehicle_little_bird_angles_0", (0, 42, 0));
      ref_1316d("scr_brtdm_vehicle_little_bird_origin_1", (12276, 48974, 1200));
      ref_1316d("scr_brtdm_vehicle_little_bird_angles_1", (0, 132, 0));
      break;
    case "karst_bridge":
      ref_1316d("scr_brtdm_circle_center", (42455, 16503, 0));
      ref_1316d("scr_brtdm_circle_radius", 10500);
      ref_1316d("scr_brtdm_spawn_angles_allies", 25);
      ref_1316d("scr_brtdm_spawn_angles_axis", 203);
      ref_1316d("scr_brtdm_spawn_angle_max", 35);
      ref_1316d("scr_brtdm_spectate_origin", (39686, 15544, -120));
      ref_1316d("scr_brtdm_spectate_angles", (12, 11, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_0", (51614, 15518, 263));
      ref_1316d("scr_brtdm_vehicle_atv_angles_0", (0, 148, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_1", (45811, 24263, -330));
      ref_1316d("scr_brtdm_vehicle_atv_angles_1", (0, 228, 0));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_origin_0", (48137, 16713, -270));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_angles_0", (0, 96, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_0", (44736, 17006, -305));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_0", (0, 291, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_1", (44518, 13224, -310));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_1", (0, 155, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_0", (49733, 18097, 15));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_0", (0, 153, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_1", (45970, 24954, -340));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_1", (0, 181, 0));
      ref_1316d("scr_brtdm_vehicle_little_bird_origin_0", (46588, 19953, 150));
      ref_1316d("scr_brtdm_vehicle_little_bird_angles_0", (0, 295, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_2", (34523, 19026, 313));
      ref_1316d("scr_brtdm_vehicle_atv_angles_2", (0, 320, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_3", (37466, 11429, 745));
      ref_1316d("scr_brtdm_vehicle_atv_angles_3", (0, 53, 0));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_origin_1", (37558, 13535, 160));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_angles_1", (0, 257, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_2", (38461, 15634, -205));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_2", (0, 310, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_3", (38067, 20032, -170));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_3", (0, 49, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_2", (37354, 22300, 35));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_2", (0, 42, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_3", (36457, 13677, 368));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_3", (0, 335, 0));
      ref_1316d("scr_brtdm_vehicle_little_bird_origin_1", (37203, 13902, 340));
      ref_1316d("scr_brtdm_vehicle_little_bird_angles_1", (0, 20, 0));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_origin_2", (40540, 15603, -302));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_angles_2", (0, 25, 0));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_origin_3", (43693, 17090, -302));
      ref_1316d("scr_brtdm_vehicle_cargo_truck_angles_3", (0, 204, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_4", (41479, 16080, -560));
      ref_1316d("scr_brtdm_vehicle_atv_angles_4", (0, 82, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_5", (43042, 16740, -570));
      ref_1316d("scr_brtdm_vehicle_atv_angles_5", (0, 266, 0));
      break;
    case "stadium":
      ref_1316d("scr_brtdm_circle_center", (28681, 2318, 0));
      ref_1316d("scr_brtdm_circle_radius", 8200);
      ref_1316d("scr_brtdm_spawn_angles_allies", 45);
      ref_1316d("scr_brtdm_spawn_angles_axis", 223);
      ref_1316d("scr_brtdm_spawn_angle_max", 40);
      ref_1316d("scr_brtdm_spawn_height_allies", 1200);
      ref_1316d("scr_brtdm_spawn_height_axis", 1200);
      ref_1316d("scr_brtdm_spectate_origin", (31146, 7827, 6721));
      ref_1316d("scr_brtdm_spectate_angles", (52, 243, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_0", (33225, 7277, -452));
      ref_1316d("scr_brtdm_vehicle_atv_angles_0", (0, 172, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_1", (29981, 6843, -540));
      ref_1316d("scr_brtdm_vehicle_atv_angles_1", (0, 353, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_0", (32595, 5128, -615));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_0", (0, 312, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_1", (29427, 7834, -519));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_1", (0, 177, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_0", (28792, 9326, -387));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_0", (0, 172, 0));
      ref_1316d("scr_brtdm_vehicle_little_bird_origin_0", (33644, 7831, -420));
      ref_1316d("scr_brtdm_vehicle_little_bird_angles_0", (0, 227, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_2", (27088, -2862, -806));
      ref_1316d("scr_brtdm_vehicle_atv_angles_2", (0, 338, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_3", (22958, 866, -515));
      ref_1316d("scr_brtdm_vehicle_atv_angles_3", (0, 61, 0));
      ref_1316d("scr_brtdm_vehicle_atv_origin_4", (28840, -4019, -806));
      ref_1316d("scr_brtdm_vehicle_atv_angles_4", (0, 6, 0));
      ref_1316d("scr_brtdm_vehicle_jeep_origin_2", (25896, -1985, -802));
      ref_1316d("scr_brtdm_vehicle_jeep_angles_2", (0, 46, 0));
      ref_1316d("scr_brtdm_vehicle_tac_rover_origin_1", (22851, 2160, -506));
      ref_1316d("scr_brtdm_vehicle_tac_rover_angles_1", (0, 64, 0));
      ref_1316d("scr_brtdm_vehicle_little_bird_origin_1", (23764, -2676, -400));
      ref_1316d("scr_brtdm_vehicle_little_bird_angles_1", (0, 39, 0));
      break;
    case "escape2":
      ref_1316d("scr_brtdm_circle_center", (0, 0, 0));
      ref_1316d("scr_brtdm_circle_radius", 7000);
      ref_1316d("scr_brtdm_spawn_angles_allies", 90);
      ref_1316d("scr_brtdm_spawn_angles_axis", 270);
      ref_1316d("scr_brtdm_spawn_angle_max", 25);
      ref_1316d("scr_brtdm_spawn_height_allies", 2250);
      ref_1316d("scr_brtdm_spawn_height_axis", 2500);
      ref_1316d("scr_brtdm_spectate_origin", (3492, 706, 2292));
      ref_1316d("scr_brtdm_spectate_angles", (0, 180, 0));
      break;
    case "island_arsenal":
      ref_1316d("scr_brtdm_circle_center", (-20588, 44501, 0));
      ref_1316d("scr_brtdm_circle_radius", 11500);
      ref_1316d("scr_brtdm_spawn_angles_allies", 20);
      ref_1316d("scr_brtdm_spawn_angles_axis", 250);
      ref_1316d("scr_brtdm_spawn_angle_max", 35);
      ref_1316d("scr_brtdm_spectate_origin", (-20588, 44501, 5000));
      ref_1316d("scr_brtdm_spectate_angles", (0, 0, 0));
      break;
    case "island_docks":
      ref_1316d("scr_brtdm_circle_center", (11850, 52000, 800));
      ref_1316d("scr_brtdm_circle_radius", 11500);
      ref_1316d("scr_brtdm_spawn_angles_allies", 30);
      ref_1316d("scr_brtdm_spawn_angles_axis", 210);
      ref_1316d("scr_brtdm_spawn_height_allies", 3500);
      ref_1316d("scr_brtdm_spawn_height_axis", 3500);
      ref_1316d("scr_brtdm_spawn_angle_min", 0);
      ref_1316d("scr_brtdm_spawn_angle_max", 40);
      ref_1316d("scr_brtdm_spawn_dist_min", 0.7);
      ref_1316d("scr_brtdm_spawn_dist_max", 0.85);
      ref_1316d("scr_brtdm_spawn_face_enemy", 0);
      ref_1316d("scr_brtdm_spectate_origin", (1600, 43846, 6400));
      ref_1316d("scr_brtdm_spectate_angles", (0, 90, 25));
      break;
    case "island_airstrip":
      ref_1316d("scr_brtdm_circle_center", (43396, 38781, 0));
      ref_1316d("scr_brtdm_circle_radius", 9000);
      ref_1316d("scr_brtdm_spawn_angles_allies", 315);
      ref_1316d("scr_brtdm_spawn_angles_axis", 135);
      ref_1316d("scr_brtdm_spawn_angle_max", 35);
      ref_1316d("scr_brtdm_spectate_origin", (43396, 38781, 5000));
      ref_1316d("scr_brtdm_spectate_angles", (0, 0, 0));
      break;
    case "island_village":
      ref_1316d("scr_brtdm_circle_center", (-38638, 15509, 2170));
      ref_1316d("scr_brtdm_circle_radius", 10000);
      ref_1316d("scr_brtdm_spawn_angles_allies", 90);
      ref_1316d("scr_brtdm_spawn_angles_axis", 270);
      ref_1316d("scr_brtdm_spawn_height_allies", 3000);
      ref_1316d("scr_brtdm_spawn_height_axis", 3000);
      ref_1316d("scr_brtdm_spawn_angle_min", 0);
      ref_1316d("scr_brtdm_spawn_angle_max", 25);
      ref_1316d("scr_brtdm_spawn_dist_min", 0.9);
      ref_1316d("scr_brtdm_spawn_dist_max", 0.99);
      ref_1316d("scr_brtdm_spawn_face_enemy", 0);
      ref_1316d("scr_brtdm_spectate_origin", (-38638, 15509, 4000));
      ref_1316d("scr_brtdm_spectate_angles", (21, 59, 0));
      break;
    case "island_mines":
      ref_1316d("scr_brtdm_circle_center", (-8648, 15640, 2000));
      ref_1316d("scr_brtdm_circle_radius", 18000);
      ref_1316d("scr_brtdm_spawn_angles_allies", 180);
      ref_1316d("scr_brtdm_spawn_angles_axis", 360);
      ref_1316d("scr_brtdm_spawn_height_allies", 10000);
      ref_1316d("scr_brtdm_spawn_height_axis", 10000);
      ref_1316d("scr_brtdm_spawn_angle_min", 0);
      ref_1316d("scr_brtdm_spawn_angle_max", 90);
      ref_1316d("scr_brtdm_spawn_dist_min", 0.5);
      ref_1316d("scr_brtdm_spawn_dist_min", 0.6);
      ref_1316d("scr_brtdm_spawn_face_enemy", 0);
      ref_1316d("scr_brtdm_spectate_origin", (-9232, 4384, 9344));
      ref_1316d("scr_brtdm_spectate_angles", (30, 90, 0));
      break;
    case "island_ruins":
      ref_1316d("scr_brtdm_circle_center", (-39936, 23552, 1544));
      ref_1316d("scr_brtdm_circle_radius", 8832);
      ref_1316d("set scr_brtdm_spawn_angles_allie", 0);
      ref_1316d("set scr_brtdm_spawn_angles_axis", 180);
      ref_1316d("set scr_brtdm_spawn_height_allies", 6000);
      ref_1316d("set scr_brtdm_spawn_height_axis", 6000);
      ref_1316d("set scr_brtdm_spawn_angle_min", 0);
      ref_1316d("set scr_brtdm_spawn_angle_max", 30);
      ref_1316d("set scr_brtdm_spawn_dist_min", 0.9);
      ref_1316d("set scr_brtdm_spawn_dist_max", 0.99);
      ref_1316d("set scr_brtdm_spawn_face_enemy", 0);
      ref_1316d("set scr_brtdm_spectate_origin", (0, 0, 0));
      ref_1316d("set scr_brtdm_spectate_angles", (21, 59, 0));
      break;
    case "island_caldera":
      ref_1316d("scr_brtdm_circle_center", (11428, 12629, 0));
      ref_1316d("scr_brtdm_circle_radius", 9000);
      ref_1316d("scr_brtdm_spawn_angles_allies", 90);
      ref_1316d("scr_brtdm_spawn_angles_axis", 270);
      ref_1316d("scr_brtdm_spawn_angle_max", 35);
      ref_1316d("scr_brtdm_spectate_origin", (11428, 12629, 10000));
      ref_1316d("scr_brtdm_spectate_angles", (0, 0, 0));
      break;
    case "island_beachhead":
      ref_1316d("scr_brtdm_circle_center", (44884, 20181, 0));
      ref_1316d("scr_brtdm_circle_radius", 12000);
      ref_1316d("scr_brtdm_spawn_angles_allies", 25);
      ref_1316d("scr_brtdm_spawn_angles_axis", 203);
      ref_1316d("scr_brtdm_spawn_angle_max", 35);
      ref_1316d("scr_brtdm_spectate_origin", (44884, 20181, 5000));
      ref_1316d("scr_brtdm_spectate_angles", (0, 0, 0));
      break;
    case "island_lagoon":
      ref_1316d("scr_brtdm_circle_center", (-41892, -17059, 0));
      ref_1316d("scr_brtdm_circle_radius", 12000);
      ref_1316d("scr_brtdm_spawn_angles_allies", 315);
      ref_1316d("scr_brtdm_spawn_angles_axis", 45);
      ref_1316d("scr_brtdm_spawn_angle_max", 35);
      ref_1316d("scr_brtdm_spectate_origin", (-41892, -17059, 5000));
      ref_1316d("scr_brtdm_spectate_angles", (0, 0, 0));
      break;
    case "island_airfield":
      ref_1316d("scr_brtdm_circle_center", (-21116, -21707, 0));
      ref_1316d("scr_brtdm_circle_radius", 13000);
      ref_1316d("scr_brtdm_spawn_angles_allies", 315);
      ref_1316d("scr_brtdm_spawn_angles_axis", 135);
      ref_1316d("scr_brtdm_spawn_angle_max", 35);
      ref_1316d("scr_brtdm_spectate_origin", (-21116, -21707, 5000));
      ref_1316d("scr_brtdm_spectate_angles", (0, 0, 0));
      break;
    case "island_farms":
      ref_1316d("scr_brtdm_circle_center", (7045, -13890, 0));
      ref_1316d("scr_brtdm_circle_radius", 13000);
      ref_1316d("scr_brtdm_spawn_angles_allies", 0);
      ref_1316d("scr_brtdm_spawn_angles_axis", 180);
      ref_1316d("scr_brtdm_spawn_angle_max", 35);
      ref_1316d("scr_brtdm_spectate_origin", (15348, -14891, 5000));
      ref_1316d("scr_brtdm_spectate_angles", (0, 0, 0));
      break;
    case "island_subpen":
      ref_1316d("scr_brtdm_circle_center", (42404, -21779, 0));
      ref_1316d("scr_brtdm_circle_radius", 13000);
      ref_1316d("scr_brtdm_spawn_angles_allies", 105);
      ref_1316d("scr_brtdm_spawn_angles_axis", 260);
      ref_1316d("scr_brtdm_spawn_angle_max", 35);
      ref_1316d("scr_brtdm_spectate_origin", (42404, -16859, 5000));
      ref_1316d("scr_brtdm_spectate_angles", (0, 0, 0));
      break;
    case "island_radiostation":
      ref_1316d("scr_brtdm_circle_center", (-12492, -41683, 0));
      ref_1316d("scr_brtdm_circle_radius", 13000);
      ref_1316d("scr_brtdm_spawn_angles_allies", 315);
      ref_1316d("scr_brtdm_spawn_angles_axis", 135);
      ref_1316d("scr_brtdm_spawn_angle_max", 35);
      ref_1316d("scr_brtdm_spectate_origin", (-12492, -41683, 5000));
      ref_1316d("scr_brtdm_spectate_angles", (0, 0, 0));
      break;
    case "island_capital":
      ref_1316d("scr_brtdm_circle_center", (21155, -49133, 0));
      ref_1316d("scr_brtdm_circle_radius", 13000);
      ref_1316d("scr_brtdm_spawn_angles_allies", 0);
      ref_1316d("scr_brtdm_spawn_angles_axis", 180);
      ref_1316d("scr_brtdm_spawn_angle_max", 35);
      ref_1316d("scr_brtdm_spectate_origin", (25116, -49203, 5000));
      ref_1316d("scr_brtdm_spectate_angles", (0, 0, 0));
      break;
    case "island_resort":
      ref_1316d("scr_brtdm_circle_center", (39180, -41211, 0));
      ref_1316d("scr_brtdm_circle_radius", 9000);
      ref_1316d("scr_brtdm_spawn_angles_allies", 60);
      ref_1316d("scr_brtdm_spawn_angles_axis", 240);
      ref_1316d("scr_brtdm_spawn_angle_max", 35);
      ref_1316d("scr_brtdm_spectate_origin", (39180, -41211, 5000));
      ref_1316d("scr_brtdm_spectate_angles", (0, 0, 0));
      break;
    case "mechanics":
      ref_1316d("scr_brtdm_spawn_height_allies", 5000);
      ref_1316d("scr_brtdm_spawn_height_axis", 5000);
      ref_1316d("scr_brtdm_spectate_origin", (0, 0, 1500));
      ref_1316d("scr_brtdm_spectate_angles", (27, 12, 0));
      break;
  }
}

function technical_initomnvars() {
  level.br_level = spawnStruct();
  level.br_level.ref_13884 = 1;
  level.br_level.br_mapcenter = level.endsuperdisableweaponbr.circlecenter;
  level.br_level.br_mapbounds = [];
  level.br_level.br_mapbounds[0] = (level.br_level.br_mapcenter[0] + level.endsuperdisableweaponbr.gulagfadetoblackspectatorsofplayer, level.br_level.br_mapcenter[1] + level.endsuperdisableweaponbr.gulagfadetoblackspectatorsofplayer, 0);
  level.br_level.br_mapbounds[1] = (level.br_level.br_mapcenter[0] - level.endsuperdisableweaponbr.gulagfadetoblackspectatorsofplayer, level.br_level.br_mapcenter[1] - level.endsuperdisableweaponbr.gulagfadetoblackspectatorsofplayer, 0);
  level.br_level.br_circleminimapradii = [level.endsuperdisableweaponbr.gulagfadetoblackspectatorsofplayer, level.endsuperdisableweaponbr.gulagfadetoblackspectatorsofplayer];
  level.br_level.br_circleradii = [level.endsuperdisableweaponbr.gulagfadetoblackspectatorsofplayer, level.endsuperdisableweaponbr.gulagfadetoblackspectatorsofplayer];
  scripts\mp\gametypes\br_circle::initcircle();

  if(!istrue(level.br_circle_disabled)) {
    level thread scripts\mp\gametypes\br_circle::ref_12e09(0);
    level.br_circle.circleindex = 0;
    setomnvar("ui_br_circle_num", 1);
    setomnvar("ui_br_minimap_radius", level.br_level.br_circleminimapradii[0]);
    scripts\mp\gametypes\br_circle::setstaticuicircles(9999, level.br_circle.safecircleui, level.br_circle.dangercircleui, 0);
    return;
  }
}

function initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  level.endsuperdisableweaponbr.ref_1365e["allies"] = getdvarfloat("scr_brtdm_spawn_height_allies", level.endsuperdisableweaponbr.ref_1196b["scr_brtdm_spawn_height_allies"]);
  level.endsuperdisableweaponbr.ref_1365e["axis"] = getdvarfloat("scr_brtdm_spawn_height_axis", level.endsuperdisableweaponbr.ref_1196b["scr_brtdm_spawn_height_allies"]);
  level.endsuperdisableweaponbr.ref_136a8["allies"] = anglesToForward((0, getdvarfloat("scr_brtdm_spawn_angles_allies", level.endsuperdisableweaponbr.ref_1196b["scr_brtdm_spawn_angles_allies"]), 0));
  level.endsuperdisableweaponbr.ref_136a8["axis"] = anglesToForward((0, getdvarfloat("scr_brtdm_spawn_angles_axis", level.endsuperdisableweaponbr.ref_1196b["scr_brtdm_spawn_angles_axis"]), 0));
  level.endsuperdisableweaponbr.ref_13608 = getdvarfloat("scr_brtdm_spawn_angle_min", level.endsuperdisableweaponbr.ref_1196b["scr_brtdm_spawn_angle_min"]);
  level.endsuperdisableweaponbr.ref_13607 = getdvarfloat("scr_brtdm_spawn_angle_max", level.endsuperdisableweaponbr.ref_1196b["scr_brtdm_spawn_angle_max"]);
  level.endsuperdisableweaponbr.ref_13631 = getdvarfloat("scr_brtdm_spawn_dist_min", level.endsuperdisableweaponbr.ref_1196b["scr_brtdm_spawn_dist_min"]);
  level.endsuperdisableweaponbr.ref_13630 = getdvarfloat("scr_brtdm_spawn_dist_max", level.endsuperdisableweaponbr.ref_1196b["scr_brtdm_spawn_dist_max"]);
  level.endsuperdisableweaponbr.ref_13677 = getdvarfloat("scr_brtdm_ti_spawn_dist_min", 1000);
  level.endsuperdisableweaponbr.ref_13676 = getdvarfloat("scr_brtdm_ti_spawn_dist_max", 3000);
  level.endsuperdisableweaponbr.spawnorigin["allies"] = level.endsuperdisableweaponbr.circlecenter + level.endsuperdisableweaponbr.ref_136a8["allies"] * level.endsuperdisableweaponbr.gulagfadetoblackspectatorsofplayer * level.endsuperdisableweaponbr.ref_13631;
  level.endsuperdisableweaponbr.spawnorigin["axis"] = level.endsuperdisableweaponbr.circlecenter + level.endsuperdisableweaponbr.ref_136a8["axis"] * level.endsuperdisableweaponbr.gulagfadetoblackspectatorsofplayer * level.endsuperdisableweaponbr.ref_13631;
  level.endsuperdisableweaponbr.passes_final_capsule_check = getdvarint("scr_brtdm_spawn_face_enemy", level.endsuperdisableweaponbr.ref_1196b["scr_brtdm_spawn_face_enemy"]);
  thread ref_12850();
}

function getspawnpoint() {
  if(!isDefined(self.ref_12ab3)) {
    self.ref_12ab3 = spawnStruct();
    return pre_race();
  }

  self.ti_spawn = 0;

  if(isDefined(self.setspawnpoint)) {
    var0 = self.setspawnpoint;

    if(!istrue(self.setspawnpoint.notti)) {
      self.ti_spawn = 1;
      self playlocalsound("tactical_spawn");

      foreach(var2 in level.teamnamelist) {
        if(var2 != self.team) {
          self playsoundtoteam("tactical_spawn", var2);
        }
      }
    }

    foreach(var5 in level.ugvs) {
      if(distancesquared(var5.origin, self.setspawnpoint.playerspawnpos) < 1024) {
        var5 notify("damage", 5000, var5.owner, (0, 0, 0), (0, 0, 0), "MOD_EXPLOSIVE", "", "", "", undefined, getcompleteweaponname("killstreak_jammer_mp"));
      }
    }

    var7 = vectortoangles(level.endsuperdisableweaponbr.ref_136a8[self.team]);
    var8 = randomfloatrange(level.endsuperdisableweaponbr.ref_13608, level.endsuperdisableweaponbr.ref_13607);
    var9 = anglesToForward((0, var7[1] + scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), var8, var8 * -1), 0));
    var10 = randomfloatrange(level.endsuperdisableweaponbr.ref_13677, level.endsuperdisableweaponbr.ref_13676);
    var11 = self.setspawnpoint.playerspawnpos + var9 * var10;

    if(distance2dsquared(var11, level.endsuperdisableweaponbr.circlecenter) > level.endsuperdisableweaponbr.gulagfadetoblackspectatorsofplayer * level.endsuperdisableweaponbr.gulagfadetoblackspectatorsofplayer) {
      var12 = vectorNormalize(var11 - level.endsuperdisableweaponbr.circlecenter);
      var11 = level.endsuperdisableweaponbr.circlecenter + var12 * level.endsuperdisableweaponbr.gulagfadetoblackspectatorsofplayer * 0.99;
    }

    var13 = scripts\engine\trace::create_default_contents(1);
    var14 = scripts\engine\utility::drop_to_ground(var11, 10000, -20000, undefined, var13);
    var11 = (var11[0], var11[1], var14[2]);
    var11 += (0, 0, 1) * level.endsuperdisableweaponbr.ref_1365e[self.team];

    if(getdvarint("scr_brtdm_spawn_debug") == 1) {
      thread scripts\mp\utility\debug::drawline(var11, var14, 15, (1, 1, 0));
    }

    self.ref_12ab3.origin = var11;
    self.ref_12ab3.angles = self.setspawnpoint.playerspawnangles;
    self.ref_12ab3.lifeid = self.lifeid;
    self.ref_12ab3.time = gettime();
    scripts\mp\equipment\tac_insert::ref_13681(0, 1);
  } else if(self.ref_12ab3.team != self.team || self.ref_12ab3.lifeid != self.lifeid) {
    return pre_race();
  }

  return self.ref_12ab3;
}

function ref_12850() {
  level.ref_12ab4 = [];
  level.ref_12ab4["allies"] = [];
  level.ref_12ab4["axis"] = [];
  var0 = getdvarint("scr_brtdm_spawn_count", 50);
  var1 = getdvarint("scr_brtdm_spawn_trace_count", 5);
  var2 = 0;
  var3 = scripts\mp\teams::ref_132e6();

  foreach(var5 in level.teamnamelist) {
    if(var3 && var5 == "team_two_hundred") {
      continue;
    }

    for(var6 = 0; var6 < var0; var6++) {
      var7 = spawnStruct();
      var8 = vectortoangles(level.endsuperdisableweaponbr.ref_136a8[var5]);
      var9 = randomfloatrange(level.endsuperdisableweaponbr.ref_13608, level.endsuperdisableweaponbr.ref_13607);
      var10 = anglesToForward((0, var8[1] + scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), var9, var9 * -1), 0));
      var11 = randomfloatrange(level.endsuperdisableweaponbr.ref_13631, level.endsuperdisableweaponbr.ref_13630);
      var12 = level.endsuperdisableweaponbr.circlecenter + var10 * level.endsuperdisableweaponbr.gulagfadetoblackspectatorsofplayer * var11;

      if(istrue(level.endsuperdisableweaponbr.passes_final_capsule_check)) {
        var13 = level.endsuperdisableweaponbr.spawnorigin[scripts\mp\utility\game::getotherteam(var5)[0]] - var12;
        var8 = vectortoangles(var13);
      } else {
        var8 = vectortoangles(var10 * -1);
      }

      var14 = scripts\engine\trace::create_default_contents(1);
      var15 = 0;
      var16 = 0;
      var17 = 10;
      var18 = [];

      for(var19 = 0; var19 < var1; var19++) {
        var20 = scripts\engine\trace::ray_trace(var12 + (0, 0, 10000), var12 - (0, 0, 20000) + anglesToForward(var8) * var19 * 2000, undefined, var14)["position"];
        var18 = var20;

        if(var20[2] > var15) {
          var15 = var20[2];
          var16 = var19;
        }

        var2++;

        if(var2 == 5) {
          waitframe();
          var2 = 0;
        }
      }

      var12 = (var12[0], var12[1], var15 + level.endsuperdisableweaponbr.ref_1365e[var5]);
      var7.origin = var12;
      var7.ref_13c33 = var18;
      var7.spawn_exfil_heli = var16;
      var7.angles = var8;
      var7.time = gettime();
      var7.team = var5;
      var7.index = -1;
      level.ref_12ab4[var5][level.ref_12ab4[var5].size] = var7;
    }
  }
}

function pre_race() {
  var0 = randomint(level.ref_12ab4[self.team].size);
  var1 = level.ref_12ab4[self.team][var0];
  self.ref_12ab3.origin = var1.origin;
  self.ref_12ab3.angles = var1.angles;
  self.ref_12ab3.time = gettime();
  self.ref_12ab3.team = self.team;
  self.ref_12ab3.index = -1;
  self.ref_12ab3.lifeid = self.lifeid;
  return self.ref_12ab3;
}

function onplayerconnect(var0) {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    thread ref_11aaf();
    return;
  }
}

function ref_11aaf(var0, var1) {
  self endon("disconnect");
  thread infil_radio_idle();

  if(isPlayer(self)) {
    self setclienttriggeraudiozone("brtdm_intro", 1);
  }

  var2 = 0;
  var3 = 0.5;
  thread ref_11ab0(var2, var3);
  scripts\mp\flags::gameflagwait("prematch_done");
  self clearallsoundsubmixes(6);
  self clearclienttriggeraudiozone(6);
}

function ref_11c83(var0) {
  thread playerrespawn();
  return true;
}

function ref_125f7(var0, var1) {
  thread playerrespawn();
  return true;
}

function playerrespawn() {
  level endon("game_ended");
  self endon("disconnect");

  if(istrue(level.gameended)) {
    return;
  }

  scripts\mp\playerlogic::ref_1437c();

  if(getdvarint("scr_bmo_use_spawn_fix", 1) == 1) {
    self endon("brWaitAndSpawnClientComplete");
  }

  var0 = getspawnpoint();
  var1 = scripts\mp\gametypes\br_gulag::ref_1263e(var0);

  if(scripts\mp\flags::gameflag("prematch_done")) {
    var2 = 0;
    var3 = 0.5;
    thread ref_11ab0(var2, var3);

    if(var2 > 0) {
      self waittill("fadeDown_complete");
    }
  }

  scripts\mp\gametypes\br_spectate::ref_1252a();
  scripts\mp\gametypes\br::spawnintermission(var0.origin, var0.angles);
  scripts\mp\spectating::setdisabled();
  scripts\mp\gametypes\br_public::ref_126ed();
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  scripts\mp\gametypes\br_pickups::initplayer(1);
  scripts\mp\gametypes\br_gulag::gulagwinnerrespawn(1, undefined, var0, 1, var1, undefined, undefined, 0, 0, 1);
  scripts\mp\damage::resetplayervariables();
  scripts\mp\damage::resetplayeromnvarsonspawn();
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

  scripts\mp\flags::gameflagwait("prematch_done");

  if(var7) {
    scripts\mp\utility\player::hidehudenable();
  }

  wait 2;
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

function onspawnplayer() {
  if(level.ref_121c8) {
    self getclientomnvar();
  } else {
    self weaponswitchbuttonPressed();
  }

  if(level.ref_121c9) {
    self skydive_cutautodeployon();
  } else {
    self skydive_cutautodeployoff();
  }

  self setclientomnvar("ui_match_status_hint_text", 0);

  if(level.spawnprotectiontimer > 0) {
    thread ref_12c22();
    thread ref_12c20();
  }

  thread ref_11aa7();
  scripts\mp\menus::updatesquadomnvars(self.team, self.squadindex);
}

function ref_12c22() {
  self endon("death_or_disconnect");
  self endon("remove_spawn_protection");
  scripts\engine\utility::ref_143a6("parachute_landed", "vehicle_enter", "weapon_fired");
  scripts\mp\gametypes\common::removespawnprotection();
}

function ref_12c20() {
  self endon("death_or_disconnect");
  self endon("remove_spawn_protection");

  while(self playerads() < 0.7) {
    waitframe();
  }

  scripts\mp\gametypes\common::removespawnprotection();
}

function ref_11aa7() {
  self endon("disconnect");
  self notify("manageAFKTracking");
  self endon("manageAFKTracking");
  self.stack_patch_waittill_node = 1;
  thread scripts\mp\class::computerrebootsequence_init();
  self waittill("parachute_landed");
  thread scripts\mp\class::ref_13f02();
  self.stack_patch_waittill_node = undefined;
  self notify("afk_tracking_resume");
}

function onnormaldeath(var0, var1, var2, var3, var4, var5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var0, var1, var2, var3, var4, var5);
}

function onplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  scripts\mp\menus::updatesquadomnvars(self.team, self.squadindex);
}

function ontimelimit() {
  var0 = scripts\mp\gamescore::gethighestscoringteam();

  if(game["status"] == "overtime") {
    var0 = "forfeit";
  } else if("tie") {
    var0 = "overtime";
  }

  thread scripts\mp\gamelogic::endgame(var0, game["end_reason"]["time_limit_reached"]);
}

function ref_132fe() {
  var0 = int(game["teamScores"]["axis"]);
  var1 = int(game["teamScores"]["allies"]);
  var2 = var0 - var1;
  return var2 < 10;
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
  if(!isDefined(level.vehicleinfo)) {
    level.vehicleinfo = [];
  }

  if(!isDefined(level.endsuperdisableweaponbr.load_relics_vfx["little_bird"])) {
    registervehicletype("little_bird", &scripts\cp_mp\vehicles\little_bird::little_bird_getspawnstructscallback, &vehiclespawn_littlebird);
  }

  if(!isDefined(level.endsuperdisableweaponbr.load_relics_vfx["little_bird_mg"])) {
    registervehicletype("little_bird_mg", &_calloutmarkerping_poolidisdanger::x1stash_detectplayers, &ref_14266);
  }

  if(!isDefined(level.endsuperdisableweaponbr.load_relics_vfx["atv"])) {
    registervehicletype("atv", &scripts\cp_mp\vehicles\atv::atv_getspawnstructscallback, &vehiclespawn_atv);
  }

  if(!isDefined(level.endsuperdisableweaponbr.load_relics_vfx["cargo_truck"])) {
    registervehicletype("cargo_truck", &scripts\cp_mp\vehicles\cargo_truck::cargo_truck_getspawnstructscallback, &vehiclespawn_cargotruck);
  }

  if(!isDefined(level.endsuperdisableweaponbr.load_relics_vfx["cargo_truck_mg"])) {
    registervehicletype("cargo_truck_mg", &_calloutmarkerping_isdropcrate::get_health_multiplier_relic_mythic, &ref_14264);
  }

  if(!isDefined(level.endsuperdisableweaponbr.load_relics_vfx["jeep"])) {
    registervehicletype("jeep", &scripts\cp_mp\vehicles\jeep::jeep_getspawnstructscallback, &vehiclespawn_jeep);
  }

  if(!isDefined(level.endsuperdisableweaponbr.load_relics_vfx["tac_rover"])) {
    registervehicletype("tac_rover", &scripts\cp_mp\vehicles\tac_rover::tac_rover_getspawnstructscallback, &vehiclespawn_tacrover);
  }

  level.vehiclespawnlocs = [];

  foreach(var1 in level.vehicleinfo) {
    switch (var1.refname) {
      case "little_bird":
        var1.vehiclespawns = rundrawprematchareas("little_bird", "lbravo_physics_mp");
        break;
      case "little_bird_mg":
        var1.vehiclespawns = rundrawprematchareas("little_bird_mg", "lbravo_physics_mp");
        break;
      case "atv":
        var1.vehiclespawns = rundrawprematchareas("atv", "atango_physics_mp");
        break;
      case "cargo_truck":
        var1.vehiclespawns = rundrawprematchareas("cargo_truck", "mkilo_physics_mp");
        break;
      case "cargo_truck_mg":
        var1.vehiclespawns = rundrawprematchareas("cargo_truck_mg", "mkilo_physics_mg");
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
  var3 = "scr_brtdm_vehicle_" + var0;

  for(var4 = 0;; var4++) {
    var5 = var3 + "_origin_" + var4;
    var6 = var3 + "_angles_" + var4;
    var7 = (0, 0, 0);

    if(isDefined(level.endsuperdisableweaponbr.ref_1196b[var5])) {
      var7 = level.endsuperdisableweaponbr.ref_1196b[var5];
    }

    var8 = getdvarvector(var5, var7);

    if(var8 == (0, 0, 0)) {
      break;
    }

    if(!scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var8)) {
      var4++;
      continue;
    }

    var9 = spawnStruct();
    var9.origin = var8;
    var10 = (0, 0, 0);

    if(isDefined(level.endsuperdisableweaponbr.ref_1196b[var6])) {
      var10 = level.endsuperdisableweaponbr.ref_1196b[var6];
    }

    var9.angles = getdvarvector(var10, var10);
    var9.targetname = var0;
    var9.vehicletype = var1;
    var2 = var9;
  }

  return var2;
}

function registeronentergulag() {
  var0 = [];

  switch (level.endsuperdisableweaponbr.locale) {
    case "lumber":
      var1 = spawnStruct();
      var1.origin = (53308, 6374, 100);
      var1.angles = (0, 155, 0);
      var1.targetname = "atv";
      var1.vehicletype = "atango_physics_mp";
      var0 = var1;
      var1 = spawnStruct();
      var1.origin = (52810, 6734, 100);
      var1.angles = (0, 250, 0);
      var1.targetname = "atv";
      var1.vehicletype = "atango_physics_mp";
      var0 = var1;
      var1 = spawnStruct();
      var1.origin = (49169, -478, 100);
      var1.angles = (0, 72, 0);
      var1.targetname = "atv";
      var1.vehicletype = "atango_physics_mp";
      var0 = var1;
      var1 = spawnStruct();
      var1.origin = (49156, 1313, 100);
      var1.angles = (0, 60, 0);
      var1.targetname = "atv";
      var1.vehicletype = "atango_physics_mp";
      var0 = var1;
      break;
    case "":
      var1 = spawnStruct();
      var1.origin = (500, -3000, 0);
      var1.angles = (0, 90, 0);
      var1.targetname = "atv";
      var1.vehicletype = "atango_physics_mp";
      var0 = var1;
      var1 = spawnStruct();
      var1.origin = (-500, 2000, 0);
      var1.angles = (0, 270, 0);
      var1.targetname = "atv";
      var1.vehicletype = "atango_physics_mp";
      var0 = var1;
      break;
  }

  return var0;
}

function relic_amped_clear_victim() {
  var0 = [];

  switch (level.endsuperdisableweaponbr.locale) {
    case "lumber":
      var1 = spawnStruct();
      var1.origin = (52481, 5490, 0);
      var1.angles = (0, 247, 0);
      var1.targetname = "cargo_truck";
      var1.vehicletype = "mkilo_physics_mp";
      var0 = var1;
      var1 = spawnStruct();
      var1.origin = (49837, 1321, 0);
      var1.angles = (0, 26, 0);
      var1.targetname = "cargo_truck";
      var1.vehicletype = "mkilo_physics_mp";
      var0 = var1;
      break;
    case "":
      var1 = spawnStruct();
      var1.origin = (1000, -3000, 0);
      var1.angles = (0, 90, 0);
      var1.targetname = "cargo_truck";
      var1.vehicletype = "mkilo_physics_mp";
      var0 = var1;
      var1 = spawnStruct();
      var1.origin = (-1000, 2000, 0);
      var1.angles = (0, 270, 0);
      var1.targetname = "cargo_truck";
      var1.vehicletype = "mkilo_physics_mp";
      var0 = var1;
      break;
  }

  return var0;
}

function remove_soldier_armor() {
  var0 = [];

  switch (level.endsuperdisableweaponbr.locale) {
    case "lumber":
      var1 = spawnStruct();
      var1.origin = (54585, 6990, 100);
      var1.angles = (0, 323, 0);
      var1.targetname = "jeep";
      var1.vehicletype = "decho_physics_mp";
      var0 = var1;
      var1 = spawnStruct();
      var1.origin = (51816, 6727, 100);
      var1.angles = (0, 200, 0);
      var1.targetname = "jeep";
      var1.vehicletype = "decho_physics_mp";
      var0 = var1;
      var1 = spawnStruct();
      var1.origin = (49599, -109, 100);
      var1.angles = (0, 333, 0);
      var1.targetname = "jeep";
      var1.vehicletype = "decho_physics_mp";
      var0 = var1;
      var1 = spawnStruct();
      var1.origin = (48721, 1557, 100);
      var1.angles = (0, 131, 0);
      var1.targetname = "jeep";
      var1.vehicletype = "decho_physics_mp";
      var0 = var1;
      break;
    case "":
      var1 = spawnStruct();
      var1.origin = (1500, -3000, 0);
      var1.angles = (0, 90, 0);
      var1.targetname = "jeep";
      var1.vehicletype = "decho_physics_mp";
      var0 = var1;
      var1 = spawnStruct();
      var1.origin = (-1500, 2000, 0);
      var1.angles = (0, 270, 0);
      var1.targetname = "jeep";
      var1.vehicletype = "decho_physics_mp";
      var0 = var1;
      break;
  }

  return var0;
}

function rpg_enemy_damage_debug() {
  var0 = [];

  switch (level.endsuperdisableweaponbr.locale) {
    case "lumber":
      var1 = spawnStruct();
      var1.origin = (53180, 7980, 100);
      var1.angles = (0, 255, 0);
      var1.targetname = "tac_rover";
      var1.vehicletype = "tromeo_physics_mp";
      var0 = var1;
      var1 = spawnStruct();
      var1.origin = (53767, 7455, 100);
      var1.angles = (0, 270, 0);
      var1.targetname = "tac_rover";
      var1.vehicletype = "tromeo_physics_mp";
      var0 = var1;
      var1 = spawnStruct();
      var1.origin = (48642, -115, 100);
      var1.angles = (0, 23, 0);
      var1.targetname = "tac_rover";
      var1.vehicletype = "tromeo_physics_mp";
      var0 = var1;
      var1 = spawnStruct();
      var1.origin = (50339, 559, 100);
      var1.angles = (0, 58, 0);
      var1.targetname = "tac_rover";
      var1.vehicletype = "tromeo_physics_mp";
      var0 = var1;
      break;
    case "":
      var1 = spawnStruct();
      var1.origin = (2000, -3000, 0);
      var1.angles = (0, 90, 0);
      var1.targetname = "tac_rover";
      var1.vehicletype = "tromeo_physics_mp";
      var0 = var1;
      var1 = spawnStruct();
      var1.origin = (-2000, 2000, 0);
      var1.angles = (0, 270, 0);
      var1.targetname = "tac_rover";
      var1.vehicletype = "tromeo_physics_mp";
      var0 = var1;
      break;
  }

  return var0;
}

function vehiclespawn_littlebird(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("little_bird", var2, var1);
}

function ref_14266(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("little_bird_mg", var2, var1);
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

function ref_14264(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("cargo_truck_mg", var2, var1);
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

function tokenrespawnwaittime() {
  level waittill("prematch_countdown");
  var0 = 15000;
  var1 = 50000;
  var2 = 5000;
  var3 = 10;
  var4 = vectortoangles(level.endsuperdisableweaponbr.ref_136a8["allies"] * -1);
  var5 = anglesToForward((0, var4[1] + var3, 0));
  var6 = level.endsuperdisableweaponbr.circlecenter + level.endsuperdisableweaponbr.ref_136a8["allies"] * (level.endsuperdisableweaponbr.gulagfadetoblackspectatorsofplayer + var0) + (0, 0, 1);
  var7 = level.endsuperdisableweaponbr.circlecenter + var5 * (level.endsuperdisableweaponbr.gulagfadetoblackspectatorsofplayer * 2 + var1);
  var8 = scripts\engine\trace::create_default_contents(1);
  var6 = scripts\engine\utility::drop_to_ground(var6, level.endsuperdisableweaponbr.ref_1365e["allies"], -1 * level.endsuperdisableweaponbr.ref_1365e["allies"], undefined, var8);
  var6 += (0, 0, 1) * (level.endsuperdisableweaponbr.ref_1365e["allies"] + var2);
  var7 = scripts\engine\utility::drop_to_ground(var7, level.endsuperdisableweaponbr.ref_1365e["allies"], -1 * level.endsuperdisableweaponbr.ref_1365e["allies"], undefined, var8);
  var7 += (0, 0, 1) * (level.endsuperdisableweaponbr.ref_1365e["allies"] + var2);
  var9 = spawnStruct();
  var9.startpt = var6;
  var9.endpt = var7;
  var9.angle = vectortoangles(var5);
  var10 = distance(var9.startpt, var9.endpt);
  var11 = scripts\mp\gametypes\br_c130::getc130speed();
  var12 = var10 / var11;
  var13 = scripts\mp\gametypes\br_c130airdrop::fntrapdeactivation(var9, var10, var11, var12);
  var13 scripts\mp\gametypes\br_c130airdrop::fob(0);
  var4 = vectortoangles(level.endsuperdisableweaponbr.ref_136a8["axis"] * -1);
  var5 = anglesToForward((0, var4[1] + var3, 0));
  var6 = level.endsuperdisableweaponbr.circlecenter + level.endsuperdisableweaponbr.ref_136a8["axis"] * (level.endsuperdisableweaponbr.gulagfadetoblackspectatorsofplayer + var0) + (0, 0, 1);
  var7 = level.endsuperdisableweaponbr.circlecenter + var5 * (level.endsuperdisableweaponbr.gulagfadetoblackspectatorsofplayer * 2 + var1);
  var6 = scripts\engine\utility::drop_to_ground(var6, level.endsuperdisableweaponbr.ref_1365e["axis"], -1 * level.endsuperdisableweaponbr.ref_1365e["axis"], undefined, var8);
  var6 += (0, 0, 1) * (level.endsuperdisableweaponbr.ref_1365e["axis"] + var2);
  var7 = scripts\engine\utility::drop_to_ground(var7, level.endsuperdisableweaponbr.ref_1365e["axis"], -1 * level.endsuperdisableweaponbr.ref_1365e["axis"], undefined, var8);
  var7 += (0, 0, 1) * (level.endsuperdisableweaponbr.ref_1365e["axis"] + var2);
  var9 = spawnStruct();
  var9.startpt = var6;
  var9.endpt = var7;
  var9.angle = vectortoangles(var5);
  var10 = distance(var9.startpt, var9.endpt);
  var11 = scripts\mp\gametypes\br_c130::getc130speed();
  var12 = var10 / var11;
  var13 = scripts\mp\gametypes\br_c130airdrop::fntrapdeactivation(var9, var10, var11, var12);
  var13 scripts\mp\gametypes\br_c130airdrop::fob(0);
}

function infil_radio_idle() {
  self endon("death_or_disconnect");

  if(isPlayer(self)) {
    var0 = spawn("script_origin", (0, 0, 0));
    var0 showonlytoplayer(self);

    if(isDefined(self.team)) {
      var1 = scripts\mp\utility\teams::getteamvoiceinfix(self.team);
      var2 = "dx_mpo_" + var1 + "op_drone_deathchatter";
    } else {
      var2 = "dx_mpo_usop_drone_deathchatter";
    }

    if(soundexists(var2)) {
      var2 playLoopSound(var2);
    } else {
      var2 playLoopSound("dx_mpo_usop_drone_deathchatter");
    }

    scripts\mp\flags::gameflagwait("prematch_done");
    wait 2;
    var2 stoploopsound(var2);
    var2 delete();
    return;
  }
}

function ref_1411d(var0, var1) {
  return true;
}