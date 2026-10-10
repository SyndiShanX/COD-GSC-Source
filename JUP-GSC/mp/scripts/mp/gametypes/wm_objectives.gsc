/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\wm_objectives.gsc
*****************************************************/

#using script_1cb7d67b71a3b4a0;
#using script_3653c2969325f543;
#using script_3fddda92c991755e;
#using script_412f60226ac8bd5b;
#using script_62384cde1a08c286;
#using script_7406801b4c228018;
#using script_7b8639f512d4cfe4;
#using scripts\common\damage_tuning;
#using scripts\common\lighting;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\agents\agent_juggernaut;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\samsite;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\killstreaks\missile_turret;
#using scripts\mp\ai_heli_reinforce;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\equipment\tactical_cover;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\obj_bombzone;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\gametypes\obj_zonecapture;
#using scripts\mp\gametypes\rescue;
#using scripts\mp\gametypes\wm_ui;
#using scripts\mp\gametypes\wm_utility;
#using scripts\mp\hud_message;
#using scripts\mp\mp_agent;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\spawn_event_aggregator;
#using scripts\mp\utility\teams;
#namespace wm_objectives;

function function_16d881992389f811() {
  namespace_500f6f1bc37289b::function_9c1b71b6f81d3121();
  level.escortvehicles = [];
  level.var_58b44a84d306019c = [];
  level.var_58b44a84d306019c[1] = "zone";
  level.var_58b44a84d306019c[2] = "bomb";
  level.var_58b44a84d306019c[3] = "hostage";
  level.var_58b44a84d306019c[4] = "destroy";
  level.var_58b44a84d306019c[5] = "destroyPlant";
  level.var_58b44a84d306019c[6] = "escort";
  level.var_58b44a84d306019c[7] = "aiBoss";
  level.var_58b44a84d306019c[8] = "aiBossZone";
  level.var_58b44a84d306019c[9] = "hack";
  level.var_58b44a84d306019c[11] = "escortWheelson";
  level.var_58b44a84d306019c[12] = "captureFlag";
  level.var_58b44a84d306019c[10] = "hackBomb";
  level.var_58b44a84d306019c[13] = "multiTank";
  level.var_58b44a84d306019c[14] = "sequenceContest";
  function_ffc7820b3cd963b3(1, &function_a6cf61bad14de666);
  function_ffc7820b3cd963b3(2, &init_bomb_objective);
  function_ffc7820b3cd963b3(3, &function_841f344a6ab9d6f9);
  function_ffc7820b3cd963b3(4, &function_3cdc401d9689c176);
  function_ffc7820b3cd963b3(5, &function_7bcfd3c0f707dfd0);
  function_ffc7820b3cd963b3(6, &function_d1346b4018cc1509);
  function_ffc7820b3cd963b3(7, &function_1f435a041b5ad1d2);
  function_ffc7820b3cd963b3(8, &function_3b22215c63a7e4e5);
  function_ffc7820b3cd963b3(9, &function_2d7f27839316e035);
  function_ffc7820b3cd963b3(11, &function_c00d3986d67e0f5e);
  function_ffc7820b3cd963b3(12, &function_b707f54f7de4fd15);
  function_ffc7820b3cd963b3(10, &function_cb215e355cb593c6);
  function_ffc7820b3cd963b3(13, &function_60cc645082562276);
  function_ffc7820b3cd963b3(14, &function_436f588312714b4a);
  function_ed01ebaaf7e97967(1, &function_eee86cff5328a5f2);
  function_ed01ebaaf7e97967(2, &function_2e079de28a14edf4);
  function_ed01ebaaf7e97967(3, &function_ecbcf255884135c5);
  function_ed01ebaaf7e97967(4, &function_30887e570cb220ca);
  function_ed01ebaaf7e97967(5, &function_fe6c238f87f0d34);
  function_ed01ebaaf7e97967(6, &function_3b680608aad5e785);
  function_ed01ebaaf7e97967(7, &function_f9fc871c251cd35e);
  function_ed01ebaaf7e97967(8, &function_fa3e625bbc963a01);
  function_ed01ebaaf7e97967(9, &function_8ed8bdf501691dc9);
  function_ed01ebaaf7e97967(11, &function_df478f29c9a89d5a);
  function_ed01ebaaf7e97967(12, &function_4f20ec3b4b62da91);
  function_ed01ebaaf7e97967(10, &function_45828a6389a8309a);
  function_ed01ebaaf7e97967(13, &function_a8542f181657fc32);
  function_ed01ebaaf7e97967(14, &function_3e3c26832b57e926);
  function_65668288d02bbcba(1, &end_zone_objective);
  function_65668288d02bbcba(2, &function_b1e48e6ea7e1a047);
  function_65668288d02bbcba(3, &function_274763e755af09dc);
  function_65668288d02bbcba(4, &function_fc4467c9f0610bb9);
  function_65668288d02bbcba(5, &function_20ac728c10edaff1);
  function_65668288d02bbcba(6, &function_e94ef69d91354ea0);
  function_65668288d02bbcba(7, &function_673741f361e9dcf3);
  function_65668288d02bbcba(8, &function_bd6d6ca7a1eaafd0);
  function_65668288d02bbcba(9, &function_2816c555d1a0bde);
  function_65668288d02bbcba(11, &function_96d01b17312762c7);
  function_65668288d02bbcba(12, &function_df7bc18f8882600e);
  function_65668288d02bbcba(10, &function_3e616a6187e9d6ff);
  function_65668288d02bbcba(13, &function_d3768b4626b853b9);
  function_65668288d02bbcba(14, &function_e42b4521f694e3f9);
  function_eb9bcbf70f099dea(1, &function_1de7ce0d073824b5);
  function_eb9bcbf70f099dea(2, &function_b067e01602805443);
  function_eb9bcbf70f099dea(3, &function_efbf76fb0a1ae4d2);
  function_eb9bcbf70f099dea(4, &function_2cbdea506661cfc5);
  function_eb9bcbf70f099dea(5, &function_9673371186f2b1c3);
  function_eb9bcbf70f099dea(6, &function_15e2fb8e5bf9b01e);
  function_eb9bcbf70f099dea(7, &function_d52c2ed64193ecf9);
  function_eb9bcbf70f099dea(8, &function_1de7ce0d073824b5);
  function_eb9bcbf70f099dea(9, &function_af3f1639fddce6e6);
  function_eb9bcbf70f099dea(11, &function_a9895b70c0316593);
  function_eb9bcbf70f099dea(12, &function_b010a1f5f8885a06);
  function_eb9bcbf70f099dea(10, &function_505b442c33eb2055);
  function_eb9bcbf70f099dea(13, &function_81e0bb0e29ca78c5);
  function_eb9bcbf70f099dea(14, &function_f4284f31e0cf6cc1);
  function_145c8a3b2e26106b(1, &function_9080aa9578d94aca);
  function_145c8a3b2e26106b(2, &function_75354d8de2adc2a);
  function_145c8a3b2e26106b(4, &function_5755f5c774e319d6);
  function_145c8a3b2e26106b(5, &function_edcbb313f774a31a);
  function_145c8a3b2e26106b(6, &function_375f5ed9ca0d5437);
  function_145c8a3b2e26106b(9, &function_585d9ea0d3567c2f);
  function_145c8a3b2e26106b(10, &function_59da849245283fc8);
  function_145c8a3b2e26106b(11, &function_23eb8b768403db5e);
  function_145c8a3b2e26106b(12, &function_c59f8281fad3515b);
  function_145c8a3b2e26106b(13, &function_af28caae69f5d8f2);
  function_145c8a3b2e26106b(14, &function_bbaf59363e16090d);

  if(isDefined(level.var_f24db6a5246641cb)) {
    [[level.var_f24db6a5246641cb]]();
  }

  foreach(i, objective in level.var_f136ed04f6b294a7) {
    zone = level.zones["zone_" + i + 1];
    zone.objective = objective;
    [[level.var_c840756153dfdc80[objective.objectivetype]]](zone);
    scripts\mp\flags::gameflaginit(zone.name + "_objective_start", 0);
    scripts\mp\flags::gameflaginit(zone.name + "_objective_end", 0);
  }

  level thread function_4b399156131ac605();
}

function function_4b399156131ac605() {
  while(!isDefined(level.var_f55e20c194c117f4)) {
    waitframe();
  }

  while(true) {
    foreach(turret in level.var_f55e20c194c117f4) {
      if(!isDefined(turret)) {
        continue;
      }

      ent = function_fb532e39e9edebf5(turret);

      print3d(turret.origin, ent.var_f236a45969f96bb4, (1, 1, 1), 1, 1, 1);
    }

    waitframe();
  }
}

function function_458432ef4351024c(player) {
  if(player scripts\mp\gameobjects::function_781844c0c05b5ac7()) {
    player = player.owner;
  }

  player dlog_recordplayerevent("dlog_event_wm_player_objective_start", ["match_guid", function_94c7ae7049488358(), "objective_start_time", gettime() / 1000, "map_name", level.script, "player_team", player.team, "player_x", player.origin[0], "player_y", player.origin[1], "player_z", player.origin[2], "objective_type", "" + level.zone.objectivetype, "objective_key", self.objectivekey, "objective_id", level.zone.name, "round", "" + game["roundsPlayed"]]);
}

function function_bc781bec44dec115(player, success) {
  if(player scripts\mp\gameobjects::function_781844c0c05b5ac7()) {
    player = player.owner;
  }

  state = "success";

  if(!success) {
    state = ter_op(isalive(player), "cancel", "dead");
  }

  player dlog_recordplayerevent("dlog_event_wm_player_objective_end", ["match_guid", function_94c7ae7049488358(), "objective_end_time", gettime() / 1000, "map_name", level.script, "player_team", player.team, "player_x", player.origin[0], "player_y", player.origin[1], "player_z", player.origin[2], "objective_type", "" + level.zone.objectivetype, "objective_key", self.objectivekey, "objective_id", level.zone.name, "player_end_state", state, "round", "" + game["roundsPlayed"]]);
}

function function_333f4c66e6305891(objectivetype, objectivekey, objectiveid, targetname, params) {
  if(!isDefined(level.var_f136ed04f6b294a7)) {
    level.var_f136ed04f6b294a7 = [];
  }

  if(istrue(level.var_f5c4d2c739170293)) {
    return;
  }

  if(getdvarint(@ "hash_677b0279e04cc234", -1) > 0) {
    var_d93cc72872799b37 = getdvarint(@ "hash_677b0279e04cc234", -1);
    objectivetype = var_d93cc72872799b37;
    objectivekey = ["_a", "_b", "_c", "_d", "_e", "_f", "_g", "_h", "_i"];
    targetname = function_58f22e4d0d5e523a(objectivetype);
    ents = array_combine(getEntArray(targetname, "targetname"), getStructArray(targetname, "targetname"), getvehiclenodearray(targetname, "targetname"));
    objectivekey = array_slice(objectivekey, 0, ents.size);
    objectiveid = "zone_1";
    level.var_f5c4d2c739170293 = 1;
  }

  objectiveinfo = spawnStruct();
  objectiveinfo.objectivetype = objectivetype;
  objectiveinfo.objectivekey = objectivekey;
  objectiveinfo.objectiveid = objectiveid;
  objectiveinfo.targetname = targetname;
  objectiveinfo.params = default_to(params, []);
  level.var_f136ed04f6b294a7[level.var_f136ed04f6b294a7.size] = objectiveinfo;
}

function function_a6cc7589a41d621e(objectivetype, objectivekey, objectiveid, targetname, params, forceobjective) {
  if(!isDefined(level.var_f136ed04f6b294a7)) {
    return;
  }

  objectiveinfo = spawnStruct();
  objectiveinfo.objectivetype = objectivetype;
  objectiveinfo.objectivekey = objectivekey;
  objectiveinfo.objectiveid = objectiveid;
  objectiveinfo.targetname = targetname;
  objectiveinfo.params = default_to(params, []);

  if(istrue(forceobjective)) {
    level.var_f136ed04f6b294a7 = [];
    level.var_f136ed04f6b294a7[level.var_f136ed04f6b294a7.size] = objectiveinfo;
    return;
  }

  foreach(i, objective in level.var_f136ed04f6b294a7) {
    if(objective.objectivetype == objectivetype) {
      level.var_f136ed04f6b294a7[i] = objectiveinfo;
      return;
    }
  }
}

function function_58f22e4d0d5e523a(objectivetype) {
  switch (objectivetype) {
    case 1:
      return "jup_dam_wb_capture_zone_a";
    case 2:
      return "bombzone";
    case 9:
      return "hack_point";
    case 3:
      return "hostage_trigger";
    case 4:
      return "mp_jup_dam_aa_turret_spawn";
    case 5:
      return "samsite_loc";
    case 6:
      return "wm_escort_tank_path";
    case 7:
      return "wm_boss_spawn";
    case 8:
      if(scripts\cp_mp\utility\game_utility::getmapname() == "mp_jup_airstrip") {
        return "wm_airstrip_capture_zone";
      } else {
        return "wm_objective_ai_zone";
      }
    default:
      break;
  }
}

function function_145c8a3b2e26106b(objectivetype, func) {
  if(!isDefined(level.var_336690fd209abaee)) {
    level.var_336690fd209abaee = [];
  }

  level.var_336690fd209abaee[objectivetype] = func;
}

function function_4b6345bd08cabf83() {
  if(!isDefined(level.var_336690fd209abaee)) {
    return;
  }

  var_786b5c66fb3f03db = level.var_336690fd209abaee[level.zone.objectivetype];

  if(isDefined(var_786b5c66fb3f03db)) {
    if(istrue(level.var_741f3529369c673c)) {
      level thread function_f62d15beff032deb(level.zone);
    }

    level thread function_f7b85d2223351788(var_786b5c66fb3f03db, level.zone);
  }
}

function function_f62d15beff032deb(zone) {
  level endon(zone.name + "_objective_end");
  level thread function_3c45c49970a7becb(zone);

  while(level.ontimelimitgraceperiod > level.var_66e7e449b5f69bf1) {
    level waittill("OT_decay_triggered");
    level.ontimelimitgraceperiod--;
  }
}

function function_3c45c49970a7becb(zone, var_8d8e1e93369f1251) {
  level endon("game_ended");
  level waittill(zone.name + "_objective_end");
  waitframe();
  level.ontimelimitgraceperiod = 5;
}

function function_f7b85d2223351788(func, zone) {
  level endon(zone.name + "_objective_end");
  var_4547b33038e95e2f = gettime();

  while(true) {
    result = [[func]](zone);
    level.canprocessot = result;

    if(istrue(level.var_741f3529369c673c)) {
      if(!istrue(result) && gettime() - var_4547b33038e95e2f >= level.var_4b2e36526d174471) {
        level notify("OT_decay_triggered");
        var_4547b33038e95e2f = gettime();
      }
    }

    waitframe();
  }
}

function function_eb9bcbf70f099dea(objectivetype, func) {
  if(!isDefined(level.var_e357e71e1a77a8e)) {
    level.var_e357e71e1a77a8e = [];
  }

  level.var_e357e71e1a77a8e[objectivetype] = func;
}

function function_ffc7820b3cd963b3(objectivetype, func) {
  if(!isDefined(level.var_c840756153dfdc80)) {
    level.var_c840756153dfdc80 = [];
  }

  level.var_c840756153dfdc80[objectivetype] = func;
}

function function_ed01ebaaf7e97967(objectivetype, func) {
  if(!isDefined(level.var_b0c3857a6da91b6c)) {
    level.var_b0c3857a6da91b6c = [];
  }

  level.var_b0c3857a6da91b6c[objectivetype] = func;
}

function function_65668288d02bbcba(objectivetype, func) {
  if(!isDefined(level.var_d23ba6208081aa8f)) {
    level.var_d23ba6208081aa8f = [];
  }

  level.var_d23ba6208081aa8f[objectivetype] = func;
}

function function_e4285658260d1bfa(objectivetype, func) {
  if(!isDefined(level.var_829a632ddd0e4e79)) {
    level.var_829a632ddd0e4e79 = [];
  }

  level.var_829a632ddd0e4e79[objectivetype] = func;
}

function function_86e5700d7971e414(objectivetype, voline) {
  if(!isDefined(level.var_6e6d113bb7c9e6a2)) {
    level.var_6e6d113bb7c9e6a2 = [];
  }

  if(!isDefined(level.var_6e6d113bb7c9e6a2["attackers"])) {
    level.var_6e6d113bb7c9e6a2["attackers"] = [];
  }

  level.var_6e6d113bb7c9e6a2["attackers"][objectivetype] = voline;
}

function function_5580ef2fc74eb79c(objectivetype, voline) {
  if(!isDefined(level.var_6e6d113bb7c9e6a2)) {
    level.var_6e6d113bb7c9e6a2 = [];
  }

  if(!isDefined(level.var_6e6d113bb7c9e6a2["defenders"])) {
    level.var_6e6d113bb7c9e6a2["defenders"] = [];
  }

  level.var_6e6d113bb7c9e6a2["defenders"][objectivetype] = voline;
}

function function_8ee1bbc9a60b0b00(objectivetype, var_e504da863a6e3dcc, var_850279df06d6ac74) {
  if(!isDefined(level.var_81e886c170a93ace)) {
    level.var_81e886c170a93ace = [];
  }

  level.var_81e886c170a93ace[objectivetype] = spawnStruct();
  level.var_81e886c170a93ace[objectivetype].attackerline = var_e504da863a6e3dcc;
  level.var_81e886c170a93ace[objectivetype].defenderline = var_850279df06d6ac74;
}

function function_c4835bfede02aee0(objectivetype) {
  if(isDefined(level.var_6e6d113bb7c9e6a2["attackers"]) && isDefined(level.var_6e6d113bb7c9e6a2["attackers"][objectivetype])) {
    level.var_a4e3f457e2914d4a = 1;
    delaythread(2, &leaderdialog, level.var_6e6d113bb7c9e6a2["attackers"][objectivetype], game["attackers"]);
  }

  if(isDefined(level.var_6e6d113bb7c9e6a2["defenders"]) && isDefined(level.var_6e6d113bb7c9e6a2["defenders"][objectivetype])) {
    level.var_a4e3f457e2914d4a = 1;
    delaythread(2, &leaderdialog, level.var_6e6d113bb7c9e6a2["defenders"][objectivetype], game["defenders"]);
  }
}

function function_1de7ce0d073824b5(label) {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend" + label, 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hq_enemy");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture" + label, 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_hq_enemy");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defending" + label, 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_hq_enemy");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_taking" + label, 0, "enemy", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_hq_enemy");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_contested" + label, 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_hq_enemy");
}

function function_b067e01602805443(label) {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend" + label, 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_bomb");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture" + label, 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_bomb_defuse");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bomb_planting" + label, 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_bomb");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bomb_planting" + label, 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_bomb");
}

function function_af3f1639fddce6e6(label) {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend" + label, 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hack");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_hack" + label, 0, "enemy", "MP_INGAME_ONLY/OBJ_UPLOAD_CAPS", "icon_waypoint_hack");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_hacking" + label, 0, "enemy", &"MP_INGAME_ONLY/OBJ_STOP_CAPS", "icon_waypoint_hacking");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defuse" + label, 0, "friendly", &"MP_INGAME_ONLY/OBJ_UPLOADING_CAPS", "icon_waypoint_hacking");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_enter_silo_f", 0, "friendly", &"MP_JUP_LAUNCHFACILITY/PLANT_IED", "icon_waypoint_ied_plant");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_enter_silo_e", 0, "enemy", &"MP_JUP_LAUNCHFACILITY/PLANT_IED", "icon_waypoint_ied_plant");
}

function function_efbf76fb0a1ae4d2(label) {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture" + label, 0, "enemy", &"MP_INGAME_ONLY/OBJ_RESCUE_CAPS", "icon_waypoint_hostage", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend" + label, 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hostage_captive", 0);
}

function function_2cbdea506661cfc5(label) {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture" + label, 0, "enemy", &"MP_INGAME_ONLY/OBJ_HVT_CAPS", "icon_waypoint_ied_plant", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend" + label, 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_ied_plant", 0);
}

function function_9673371186f2b1c3(label) {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture" + label, 0, "enemy", &"MP_INGAME_ONLY/OBJ_PLANT_CAPS", "hud_icon_vehicle_samsite", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend" + label, 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "hud_icon_vehicle_samsite", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defuse" + label, 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_bomb");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defuse" + label, 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_bomb");
}

function function_15e2fb8e5bf9b01e(label) {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture" + label, 0, "enemy", &"MP_INGAME_ONLY/OBJ_HALT_CAPS", "icon_waypoint_dom" + label, 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend" + label, 0, "friendly", &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_dom" + label, 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_vehicle", 0, "friendly", &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_escort_tank", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_vehicle_blocked", 0, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_tank_blocked", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_vehicle_repair", 0, "friendly", &"MP_INGAME_ONLY/OBJ_TANK_REPAIRING", "icon_waypoint_tank_repair", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_vehicle_damaged", 0, "friendly", &"MP_INGAME_ONLY/OBJ_TANK_DAMAGED", "icon_waypoint_tank_damaged", 0);
}

function function_a9895b70c0316593(label) {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_vehicle", 0, "friendly", &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_wheelson", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_vehicle_blocked", 0, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_wheelson_blocked", 0);

  if(isDefined(level.objectives[label]) && istrue(level.objectives[label].var_7848db50cd8c444f)) {
    scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend" + label, 0, "friendly", "MP_INGAME_ONLY/OBJ_HALT_CAPS", "icon_waypoint_wheelson_hack");
    scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture" + label, 0, "enemy", "MP_INGAME_ONLY/OBJ_HACK_CAPS", "icon_waypoint_wheelson_hack");
    scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defending" + label, 0, "friendly", "MP_INGAME_ONLY/OBJ_HALTING_CAPS", "icon_waypoint_wheelson_hack");
    scripts\mp\gamelogic::setwaypointiconinfo("waypoint_taking" + label, 0, "enemy", "MP_INGAME_ONLY/OBJ_HACKING_CAPS", "icon_waypoint_wheelson_hack");
    scripts\mp\gamelogic::setwaypointiconinfo("waypoint_contested" + label, 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_wheelson_hack");
    scripts\mp\gamelogic::setwaypointiconinfo("waypoint_losing" + label, 0, "friendly", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_wheelson_hack");
    return;
  }

  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture" + label, 0, "enemy", &"MP_INGAME_ONLY/OBJ_HALT_CAPS", "icon_waypoint_dom" + label, 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend" + label, 0, "friendly", &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_dom" + label, 0);
}

function function_d52c2ed64193ecf9(label) {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend" + label, 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_jugg");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture" + label, 0, "enemy", &"MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_jugg");
}

function function_b010a1f5f8885a06(label) {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_take_flag" + label, 0, "friendly", &"MP_INGAME_ONLY/OBJ_TAKE_FILTER_CAPS", "icon_waypoint_filter", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend_flag" + label, 0, "enemy", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_filter", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_kill_flag" + label, 0, "enemy", &"MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_flag" + label, 0, "friendly", &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_filter", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend_PDS" + label, 0, "enemy", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_rescue_extract", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_install_PDS" + label, 0, "friendly", &"MP_INGAME_ONLY/OBJ_INSTALL_FILTER_CAPS", "icon_waypoint_rescue_extract", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend" + label, 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_rescue_extract");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture" + label, 0, "enemy", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_rescue_extract");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_taking" + label, 0, "enemy", &"MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_rescue_extract");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_losing" + label, 0, "friendly", &"MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_rescue_extract");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_contested" + label, 0, "contest", &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_rescue_extract");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defending" + label, 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_rescue_extract");
}

function function_505b442c33eb2055(label) {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend" + label, 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hack");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_hack" + label, 0, "enemy", &"MP_INGAME_ONLY/OBJ_ACTIVATE_CAPS", "icon_waypoint_hack");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_hacking" + label, 0, "enemy", &"MP_INGAME_ONLY/OBJ_STOP_CAPS", "icon_waypoint_hacking");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defuse" + label, 0, "friendly", &"MP_INGAME_ONLY/OBJ_ACTIVATING_CAPS", "icon_waypoint_hacking");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bomb_defuse" + label, 0, "enemy", &"MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_bomb_defuse");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bomb_plant" + label, 0, "enemy", &"MP_INGAME_ONLY/OBJ_PLANT_CAPS", "icon_waypoint_bomb");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bomb_defend" + label, 0, "enemy", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_bomb");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bomb_lock" + label, 0, "enemy", &"MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_locked");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bomb_lock" + label, 0, "friendly", &"MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_locked");
}

function function_3b22215c63a7e4e5(zone) {
  objective = zone.objective;
  function_a6cf61bad14de666(zone, 1);
}

function function_fa3e625bbc963a01(zone) {
  function_eee86cff5328a5f2(zone);
  objective = level.objectives[zone.objectives[0]];

  if(istrue(objective.var_31cc33cddb1dfba2)) {
    objective scripts\mp\gameobjects::allowuse("none");
  }

  if(isDefined(objective.aiobjectives)) {
    foreach(obj in objective.aiobjectives) {
      obj scripts\mp\gameobjects::setvisibleteam("any");
    }

    objective scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_locked");
  }

  objective scripts\mp\gameobjects::enableobject();
  objective scripts\mp\gameobjects::setownerteam(game["defenders"]);
  objective scripts\mp\gameobjects::allowuse("enemy");
}

function function_bd6d6ca7a1eaafd0(objective) {}

function function_a6cf61bad14de666(zone, ailockdown) {
  objective = zone.objective;

  if(!isarray(objective.objectivekey)) {
    objective.objectivekey = [objective.objectivekey];
  }

  objectiveid = objective.objectiveid;
  objectivekeys = objective.objectivekey;
  targetname = objective.targetname;
  function_37487e9ef3996964(objective);
  level.flagcapturetime = dvarfloatvalue("flagCaptureTime", 30, 0, 120);

  if(isDefined(zone.objective.params) && isDefined(zone.objective.params["flagCaptureTime"])) {
    level.flagcapturetime = zone.objective.params["flagCaptureTime"];
  }

  level.zonecapturetime = level.flagcapturetime;

  if(getdvarint(@ "hash_845b2cf80a6d0d0c", 0)) {
    level.flagcapturetime = 5;
    level.zonecapturetime = level.flagcapturetime;
  }

  if(isarray(targetname)) {
    triggers = [];

    foreach(name in targetname) {
      triggers[triggers.size] = getEnt(name, "targetname");
    }
  } else {
    triggers = getEntArray(targetname, "targetname");
  }

  if(!isDefined(triggers)) {
    return;
  }

  zone.capture_zones = [];

  foreach(i, trigger in triggers) {
    objectivekey = objectivekeys[i];
    trigger.objectivekey = objectivekey;
    trigger.script_label = objectivekey;
    capture_zone = scripts\mp\gametypes\obj_zonecapture::setupobjective(trigger);
    capture_zone.iconname = objectivekey;
    level.objectives[objectivekey] = capture_zone;
    level.objectives[objectivekey].objectivetype = objective.objectivetype;
    capture_zone scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture", zone.objidnum, game["defenders"]);
    capture_zone scripts\mp\gameobjects::setvisibleteam("none");

    if(!isDefined(level.var_261c48ef4ff3d77a)) {
      level.var_261c48ef4ff3d77a = [];
    }

    level.var_261c48ef4ff3d77a[level.var_261c48ef4ff3d77a.size] = capture_zone;
    zone.capture_zones[zone.capture_zones.size] = capture_zone;
  }

  if(istrue(ailockdown)) {
    structs = getStructArray("wm_boss_spawn", "targetname");

    foreach(capture_zone in zone.capture_zones) {
      capture_zone scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_locked" + objectivekeys[0]);
      capture_zone.var_31cc33cddb1dfba2 = 1;
      capture_zone.aiobjectives = [];
    }

    scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_locked" + objectivekeys[0], 0, "neutral", "MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_locked", 0);
    scripts\mp\ai_mp_controller::function_2b36368b8b1b2b30(1);
    objectivekeys = ["_h", "_i"];

    foreach(i, struct in structs) {
      scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend" + objectivekeys[i], 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_jugg");
      scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture" + objectivekeys[i], 0, "enemy", &"MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_jugg");
      marker = function_a62aee0aefa751b3(struct, objective, objectivekeys[i]);

      foreach(capture_zone in zone.capture_zones) {
        capture_zone.aiobjectives[capture_zone.aiobjectives.size] = marker;
      }
    }

    while(!istrue(level.objectives["_h"].complete) || !istrue(level.objectives["_i"].complete)) {
      waitframe();
    }

    foreach(capture_zone in zone.capture_zones) {
      capture_zone scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture");
      capture_zone scripts\mp\gameobjects::allowuse("any");
    }
  }
}

function function_eee86cff5328a5f2(zone, ailockdown) {
  function_21ee5fc831ef88cc(zone);
  level.ontimelimitgraceperiod = getdvarint(@ "hash_32868f1020ec5bcb", 9);

  foreach(capture_zone in zone.capture_zones) {
    capture_zone scripts\mp\gameobjects::setusetime(level.flagcapturetime);
    capture_zone scripts\mp\gametypes\obj_zonecapture::activatezone(undefined, 1);
    capture_zone.onuse = &function_7d30ae61c44bd1a0;
    capture_zone.onbeginuse = &function_ceb1bb733cf25d55;
    capture_zone.onenduse = &function_9e4725f0fafd0f29;
    capture_zone scripts\mp\gameobjects::setownerteam(game["defenders"]);
    capture_zone.ignorestomp = !istrue(function_29227adb79acc568("zoneReversible", 0));
    capture_zone.useratemultiplier = 1;
    capture_zone.var_823c5a7bf6a0e64a = level.flagreinforcement;
    capture_zone.blockcapdisabled = 1;
    capture_zone thread scripts\mp\gametypes\obj_zonecapture::updatechevrons(game["defenders"]);
    capture_zone scripts\mp\gameobjects::enableobject();
    capture_zone scripts\mp\gameobjects::setownerteam(game["defenders"]);
    capture_zone scripts\mp\gameobjects::allowuse("enemy");
    capture_zone.var_b2dfb3f0778c829a = &"MP_INGAME_ONLY/OBJ_CAPTURING_CAPS";
    level thread function_bd98c9e85905e50d(capture_zone);
  }
}

function function_bd98c9e85905e50d(capture_zone) {
  level endon("end_zone_objective");

  while(true) {
    wait 5;

    if(istrue(capture_zone.stalemate)) {
      continue;
    }

    foreach(struct in capture_zone.touchlist[game["attackers"]]) {
      if(scripts\mp\gameobjects::function_21f4c6f630b17fc4(struct.player)) {
        struct.player.owner thread scripts\mp\utility\points::doscoreevent(#"hash_ab380575e645f59");
        continue;
      }

      struct.player thread scripts\mp\utility\points::doscoreevent(#"hash_8b25c2c59b73eb46");
    }
  }
}

function end_zone_objective(zone) {
  level notify("end_zone_objective");
  level.ontimelimitgraceperiod = 5;

  foreach(player in scripts\mp\utility\teams::getteamdata(game["attackers"], "players")) {
    if(scripts\mp\gameobjects::function_21f4c6f630b17fc4(player)) {
      player.owner thread scripts\mp\utility\points::doscoreevent(#"hash_1e81f3e4398c19dd");
      continue;
    }

    player thread scripts\mp\utility\points::doscoreevent(#"hash_c2a81e1bb7ec57c2");
  }

  chevrons = getentitylessscriptablearray("scriptable_hardpoint_chevron", "classname");

  foreach(chevron in chevrons) {
    if(is_equal(chevron.script_noteworthy, zone.targetname)) {
      for(i = 0; i < 1; i++) {
        chevron setscriptablepartstate("chevron_" + i, "off");
      }
    }
  }

  objective = zone.objective;

  if(isDefined(objective.params["leaderDialogAttackers"])) {
    attackersleaderdialog = objective.params["leaderDialogAttackers"];
    delaythread(2, &leaderdialog, attackersleaderdialog, game["attackers"]);
  }

  if(isDefined(objective.params["leaderDialogDefenders"])) {
    defendersleaderdialog = objective.params["leaderDialogDefenders"];
    delaythread(2, &leaderdialog, defendersleaderdialog, game["defenders"]);
    return;
  }

  delaythread(2, &leaderdialog, "defenders_lost_zone", game["defenders"]);
}

function function_8752b093985bf8e7(time, post_time, dialog, team) {
  level.var_a4e3f457e2914d4a = 1;
  wait time;
  leaderdialog(dialog, game[team]);
  wait post_time;
  level.var_a4e3f457e2914d4a = 0;
}

function function_3cdc401d9689c176(zone) {
  objective = zone.objective;

  if(!isarray(objective.objectivekey)) {
    objective.objectivekey = [objective.objectivekey];
  }

  objectiveid = objective.objectiveid;
  objectivekeys = objective.objectivekey;
  targetname = objective.targetname;
  function_37487e9ef3996964(objective);
  structs = getStructArray(targetname, "targetname");

  while(!isDefined(level.streakglobals)) {
    waitframe();
  }

  while(!isDefined(level.players) || level.players.size == 0) {
    waitframe();
  }

  level.var_7f636ee164a47ef7 = [];

  foreach(i, objstruct in structs) {
    objectivekey = objectivekeys[i];

    if(!isDefined(objectivekey)) {
      objectivekey = "_a";
    }

    marker = objstruct function_bbcd7058816ef794(objectivekey, &"MP_INGAME_ONLY/OBJ_HVT_CAPS", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_ied_plant");
    level.objectives[objectivekey] = marker;
    level.objectives[objectivekey].objectivetype = objective.objectivetype;
    marker.progress = 0;
    turretarray = getStructArray(objstruct.target, "targetname");

    foreach(struct in turretarray) {
      turret = spawnturret("misc_turret", struct.origin, level.missilesettings["missile_turret"].weaponinfo);
      turret.turrettype = "missile_turret";
      turret scripts\killstreaks\missile_turret::function_70c8684c2c29bf59("placed");
      turret maketurretinoperable();
      turret setleftarc(180);
      turret setrightarc(180);
      turret setbottomarc(50);
      turret settoparc(120);
      turret setconvergencetime(0.2, "pitch");
      turret setconvergencetime(0.2, "yaw");
      turret setconvergenceheightpercent(0.65);
      turret setdefaultdroppitch(-89);
      turret setdefaultdroppitch(0);
      turret setautorotationdelay(0.2);
      turret.colmodel = spawn("script_model", turret.origin);
      turret.colmodel.team = turret.team;
      turret.colmodel.owner = turret.owner;
      turret.colmodel setModel("weapon_vm_mg_sentry_turret_invis_base");
      turret.colmodel dontinterpolate();
      turret.shootingpositions = [1, 2, 3, 4, 5, 6, 7, 8];
      turret setturretmodechangewait(1);
      turret setmode("sentryManual");
      turret.health = 500;
      turret.maxhealth = 500;
      turret.currenthealth = turret.maxhealth;
      turret.marker = marker;
      level thread function_389ebc5025c28934(turret);
      level thread function_14aa40ae092fe7b1(turret);
      level thread function_3073d3141c30bbe5(turret);
      level.var_7f636ee164a47ef7[level.var_7f636ee164a47ef7.size] = turret;
    }
  }
}

function function_30887e570cb220ca(zone) {
  function_21ee5fc831ef88cc(zone);

  foreach(turret in level.var_7f636ee164a47ef7) {
    turret.outlineid = scripts\mp\utility\outline::outlineenableforall(turret, "outlinefill_nodepth_red", "level_script");
  }
}

function function_fc4467c9f0610bb9(zone) {}

function function_d1346b4018cc1509(zone) {
  objective = zone.objective;

  if(!isarray(objective.objectivekey)) {
    objective.objectivekey = [objective.objectivekey];
  }

  objectiveid = objective.objectiveid;
  objectivekeys = objective.objectivekey;
  targetname = objective.targetname;
  function_37487e9ef3996964(objective);
  nodes = getvehiclenodearray(targetname, "targetname");
  nodes = array_add(nodes, getvehiclenode("wm_stop_2", "script_noteworthy"));

  foreach(i, node in nodes) {
    objectivekey = objectivekeys[i];

    if(!isDefined(objectivekey)) {
      continue;
    }

    if(is_equal(node.script_noteworthy, "wm_stop_2")) {
      level.var_dc80dfc6726866ce = spawnStruct();
      level.var_dc80dfc6726866ce.node = node;
      level.var_dc80dfc6726866ce.objectivekey = objectivekey;
      level.var_dc80dfc6726866ce.marker = node function_bbcd7058816ef794(objectivekey, &"MP_INGAME_ONLY/OBJ_HALT_CAPS", &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_dom" + objectivekey, game["attackers"]);
      level.objectives[objectivekey] = level.var_dc80dfc6726866ce.marker;
      level.objectives[objectivekey].objectivetype = objective.objectivetype;
      continue;
    }

    spawndata = spawnStruct();
    spawndata.cantimeout = 0;
    spawndata.spawnmethod = "place_at_position_unsafe";
    spawndata.origin = node.origin;
    spawndata.angles = node.angles;
    spawndata.team = game["attackers"];
    spawndata.node = node;
    spawndata.objectivekey = objectivekey;
    vehicleref = "light_tank";

    if(isDefined(objective.params["vehicleRef"])) {
      vehicleref = objective.params["vehicleRef"];
    }

    if(getmapname() != "mp_jup_airstrip") {
      spawndata.spawnmethod = "airdrop_at_position_unsafe";
    }

    if(spawndata.spawnmethod == "airdrop_at_position_unsafe") {
      spawndata.vehicleref = vehicleref;
      level.var_1a8f6efd504faa14 = spawndata;
    } else {
      vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(vehicleref, spawndata);
      level.escortvehicles[level.escortvehicles.size] = vehicle;
    }

    marker = spawndata function_bbcd7058816ef794(objectivekey, &"MP_INGAME_ONLY/OBJ_HALT_CAPS", &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_dom" + objectivekey, game["attackers"]);
    level.objectives[objectivekey] = marker;
    level.objectives[objectivekey].objectivetype = objective.objectivetype;
  }
}

function function_3b680608aad5e785(zone) {
  level.ontimelimitgraceperiod = getdvarint(@ "hash_675c1f2b3e4bf7f9", 14);

  if(isDefined(level.var_1a8f6efd504faa14)) {
    vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(level.var_1a8f6efd504faa14.vehicleref, level.var_1a8f6efd504faa14);
    level.escortvehicles[level.escortvehicles.size] = vehicle;
  }

  function_21ee5fc831ef88cc(zone);
  objective = zone.objective;

  if(isDefined(level.var_9d7cf21bb90f2cc5)) {
    node = level.var_dc80dfc6726866ce.node;
    spawndata = spawnStruct();
    spawndata.cantimeout = 0;
    spawndata.spawnmethod = "place_at_position_unsafe";
    spawndata.origin = node.origin;
    spawndata.angles = node.angles;
    spawndata.team = game["defenders"];
    endnode = getvehiclenode("wm_stop_3", "script_noteworthy");
    level thread function_4a6cef3b190c8082(objective, level.var_9d7cf21bb90f2cc5, level.var_dc80dfc6726866ce.objectivekey, spawndata, level.var_dc80dfc6726866ce.node, level.var_dc80dfc6726866ce.marker, endnode);
  }

  foreach(vehicle in level.escortvehicles) {
    level thread function_4a6cef3b190c8082(level.zone.objective, vehicle, vehicle.spawndata.objectivekey, vehicle.spawndata, vehicle.spawndata.node, level.objectives[vehicle.spawndata.objectivekey]);
  }
}

function function_e94ef69d91354ea0(zone) {
  foreach(player in level.players) {
    player.var_974cca039ded252e = undefined;
    player function_160f522b63c32d76(0);
  }

  level.ontimelimitgraceperiod = 5;
  objective = zone.objective;

  if(isDefined(objective.params["leaderDialogAttackers"])) {
    attackersleaderdialog = objective.params["leaderDialogAttackers"];
    delaythread(2, &leaderdialog, attackersleaderdialog, game["attackers"]);
  }

  if(isDefined(objective.params["leaderDialogDefenders"])) {
    defendersleaderdialog = objective.params["leaderDialogDefenders"];
    delaythread(2, &leaderdialog, defendersleaderdialog, game["defenders"]);
  }

  wm_tank_barrier_entrance = getEntArray("wm_tank_barrier_entrance", "script_noteworthy");

  foreach(ent in wm_tank_barrier_entrance) {
    ent hide();
  }

  scripts\mp\utility\points::function_2a66e9acc30896c(game["attackers"], #"hash_18c44b230263da2c");
}

function function_4a6cef3b190c8082(objective, vehicle, objectivekey, spawndata, node, marker, endnode) {
  vehicle.marker = marker;

  if(11 != objective.objectivetype) {
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable(vehicle);
  }

  setDvar(@ "hash_fb517a5a3d736fa0", 1);

  if(isDefined(objective.params["tankNearbyRange"])) {
    vehicle.tanknearbyrange = objective.params["tankNearbyRange"];
  }

  if(istrue(objective.params["canStopByDefenders"])) {
    vehicle.canstopbydefenders = 1;
  }

  if(istrue(objective.params["canDamageAndRepair"])) {
    vehicle.demigodmode = 1;
    vehicle.var_5fb0e90d5b2a8aae = 0;
  } else {
    vehicle.godmode = 1;
  }

  vehicle.defaultspeed = getobjectiveparam("vehicleSpeed", 4);
  vehicle.var_98e373d243c1936f = 1;
  vehicle vehicleshowonminimap(0);
  vehicle.objectivekey = objectivekey;
  vehicle.usep2p = istrue(objective.params["useP2P"]);

  if(!isDefined(endnode)) {
    pathnodes = [];

    for(nextnode = node; isDefined(nextnode); nextnode = undefined) {
      pathnodes[pathnodes.size] = nextnode;

      if(isDefined(nextnode.target)) {
        nextnode = getvehiclenode(nextnode.target, "targetname");
        continue;
      }
    }

    endnode = pathnodes[pathnodes.size - 1];
    vehicle.pathnodes = pathnodes;

    if(!istrue(vehicle.usep2p)) {
      vehicle attachpath(vehicle.pathnodes[0]);
      vehicle startpath();
    } else {
      vehicle addcomponent("p2p");
      vehicle thread function_c1bc249b0499979e();
    }

    vehicle.stageid = 0;
    vehicle.progress = 0;
    totaldistance = 0;
    vehicle.pathnodes[0].var_1d7ebd1bcc23a4e1 = 0;

    for(i = 0; i < vehicle.pathnodes.size - 1; i++) {
      currentnode = vehicle.pathnodes[i];
      nextnode = vehicle.pathnodes[i + 1];
      totaldistance += distance2d(currentnode.origin, nextnode.origin);
      nextnode.var_1d7ebd1bcc23a4e1 = totaldistance;
    }

    foreach(pathnode in vehicle.pathnodes) {
      pathnode.progress = pathnode.var_1d7ebd1bcc23a4e1 / totaldistance;
    }
  }

  if(isDefined(level.var_4538f9d8dc0b9007)) {
    vehicle.checkpoints = [[level.var_4538f9d8dc0b9007]](vehicle);
  }

  level notify("escort_path_set", vehicle);

  if(istrue(level.var_3e6380e9591e50a5)) {
    vehicle thread function_305ffac5102f1b2b(endnode, "friendly", 6);
    vehicle thread function_305ffac5102f1b2b(endnode, "enemy", 6);
  }

  if(isDefined(objective.params["vehicleRef"])) {
    vehobjzoffset = objective.params["vehicleRef.vehObjZOffset"];
  }

  scripts\mp\objidpoolmanager::update_objective_onentity(marker.objidnum, vehicle);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(marker.objidnum, default_to(vehobjzoffset, 180));

  if(istrue(objective.params["progressByActualDistance"])) {
    if(11 != objective.objectivetype) {
      level thread function_f2a1c180dc67b7f8(vehicle, marker.objidnum);
    } else {
      level thread function_b63c307e88f55d86(vehicle, marker.objidnum);
    }
  } else {
    level thread function_98b9f09341fd9ba8(vehicle, marker.objidnum, endnode);
  }

  var_e21fdc330521a449 = 0;

  if(11 == objective.objectivetype) {
    vehicle setCanDamage(0);
    var_e21fdc330521a449 = 1;
  }

  vehicle thread function_eb31d2457d09576(var_e21fdc330521a449);
  level thread function_7d5057db2f8ddb6f(vehicle, marker.objidnum);
}

function function_eb31d2457d09576(var_e21fdc330521a449) {
  level endon("game_ended");
  self endon("death");
  self endon("reached_goal");
  self endon("other_reached_goal");
  thread function_367f87c96dccaf2();
  tank = self;
  var_40d4ab48b1615807 = tank getentitynumber();

  if(istrue(var_e21fdc330521a449)) {
    var_21412c22fd1045d7 = 50;
    var_dcb6304be0fe7b52 = 70;
    var_24d1ae7b69b2b3f3 = 80;
  } else {
    var_21412c22fd1045d7 = 150;
    var_dcb6304be0fe7b52 = 240;
    var_24d1ae7b69b2b3f3 = 160;
  }

  itemcontents = physics_createcontents(["physicscontents_item", "physicscontents_vehicle"]);
  radiusvector = (var_21412c22fd1045d7, var_21412c22fd1045d7, var_24d1ae7b69b2b3f3);
  var_f8d57c6bc526da29 = (var_dcb6304be0fe7b52, var_dcb6304be0fe7b52, var_24d1ae7b69b2b3f3);
  var_646389193279e8ec = [tank];

  while(true) {
    if(istrue(var_e21fdc330521a449)) {
      var_863c619037f3ac74 = tank.origin;
    } else {
      var_863c619037f3ac74 = tank.origin + rotatevector((30, 0, -30), tank.angles);
    }

    aabbmin = var_863c619037f3ac74 - radiusvector;
    aabbmax = var_863c619037f3ac74 + radiusvector;

    if(getdvarint(@ "hash_f4fab8835c5cae7a", 0)) {
      level thread draw_line_for_time(aabbmin, aabbmax, 1, 0, 0, 2);
      level thread draw_circle(var_863c619037f3ac74, var_21412c22fd1045d7, (1, 0, 0), 1, 0, 2);
    }

    var_3c4b19abbdf0937c = var_863c619037f3ac74 - var_f8d57c6bc526da29;
    var_2e1990d919dc0eb2 = var_863c619037f3ac74 + var_f8d57c6bc526da29;

    if(getdvarint(@ "hash_f4fab8835c5cae7a", 0)) {
      level thread draw_line_for_time(var_3c4b19abbdf0937c, var_2e1990d919dc0eb2, 1, 0, 0, 2);
      level thread draw_circle(var_863c619037f3ac74, var_dcb6304be0fe7b52, (1, 0, 0), 1, 0, 2);
    }

    var_3a3a8605cd6d3dfc = physics_aabbbroadphasequery(aabbmin, aabbmax, itemcontents, var_646389193279e8ec);
    var_e4c6a394b5df337 = physics_aabbbroadphasequery(var_3c4b19abbdf0937c, var_2e1990d919dc0eb2, itemcontents, var_646389193279e8ec);

    foreach(ent in var_e4c6a394b5df337) {
      if(isDefined(ent.cratetype) && ent.cratetype == "loadout_drop" && !istrue(ent.beingdestroyed)) {
        ent.beingdestroyed = 1;
        ent thread scripts\cp_mp\killstreaks\airdrop::destroycrate(0);
      }
    }

    foreach(ent in var_3a3a8605cd6d3dfc) {
      if(isDefined(ent.equipmentref) && ent.equipmentref == "equip_tac_cover" && !istrue(ent.beingdestroyed)) {
        ent.beingdestroyed = 1;
        ent thread scripts\mp\equipment\tactical_cover::tac_cover_destroy(undefined, 0);
      }

      if(isDefined(ent.vehiclename) && ent.vehiclename == "radar_drone_recon" && !istrue(ent.beingdestroyed)) {
        ent.beingdestroyed = 1;
        ent thread scripts\cp_mp\killstreaks\helper_drone::function_6edfda4764129e3(1);
      }
    }

    waitframe();
  }
}

function function_367f87c96dccaf2() {
  level endon("game_ended");
  self endon("death");
  self endon("reached_goal");
  self endon("other_reached_goal");
  temppos = self.origin;
  var_8fb02da86884df3f = 0;

  while(true) {
    wait 0.25;

    if(distancesquared(self.origin, temppos) < 16 && istrue(self.var_92051c7cb27cb3bb)) {
      var_8fb02da86884df3f++;
    } else if(distancesquared(self.origin, temppos) > 16) {
      var_8fb02da86884df3f = 0;
    }

    if(var_8fb02da86884df3f >= 2) {
      self startpath(self.pathnodes[self.var_6bb0ab1fe092bd5d - 1]);
      var_8fb02da86884df3f = 0;
    }

    temppos = self.origin;
  }
}

function function_305ffac5102f1b2b(node, teamrelative, backgroundtype) {
  level endon("game_ended");
  var_31b8262b5f39d22e = 20;
  position = node.origin + (0, 0, var_31b8262b5f39d22e);
  waypointid = requestobjectiveid();
  objective_add(waypointid, "active", position, "icon_waypoint_rescue_extract", "icon_regular");
  objective_setplayintro(waypointid, 1);
  objective_setbackground(waypointid, backgroundtype);
  objective_setfadedisabled(waypointid, 0);
  objective_setshowoncompass(waypointid, 1);
  objective_setshowdistance(waypointid, 1);
  objective_setownerteam(waypointid, game["attackers"]);

  if(teamrelative == "friendly") {
    objective_setfriendlylabel(waypointid, &"MP_INGAME_ONLY/OBJ_TANK_GOAL_CAPS");
    objective_mask_showtoplayerteam(waypointid, self);
  } else {
    objective_setenemylabel(waypointid, &"MP_INGAME_ONLY/OBJ_TANK_GOAL_CAPS");
    objective_mask_showtoenemyteam(waypointid, self);
  }

  gameflagwait(level.zone.name + "_objective_end");
  returnobjectiveid(waypointid);
}

function function_1f435a041b5ad1d2(zone) {
  objective = zone.objective;

  if(!isarray(objective.objectivekey)) {
    objective.objectivekey = [objective.objectivekey];
  }

  objectiveid = objective.objectiveid;
  objectivekeys = objective.objectivekey;
  targetname = objective.targetname;
  function_37487e9ef3996964(objective);
  structs = getStructArray(targetname, "targetname");

  foreach(i, struct in structs) {
    objectivekey = objectivekeys[i];
    function_a62aee0aefa751b3(struct, objective, objectivekey);
  }
}

function function_f9fc871c251cd35e(zone) {
  function_21ee5fc831ef88cc(zone);
}

function function_673741f361e9dcf3(zone) {}

function function_7bcfd3c0f707dfd0(zone) {
  objective = zone.objective;
  level.var_3f4534fb14cca909 = &function_a13d6040c09f7f03;
  level.var_2179c46fc54fd9ce = "offhand_2h_c4_prop_mp";
  namespace_82f05772526a4798::function_c25a40ae517ef340();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("usable_left", &namespace_82f05772526a4798::function_e8e4bb2f83e5055a);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("usable_right", &namespace_82f05772526a4798::function_e8e4bb2f83e5055a);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("usable_left_defuse", &function_cbd3979676d57efe);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("usable_right_defuse", &function_cbd3979676d57efe);
  level.var_f55e20c194c117f4 = [];
  zone.turrets = [];

  foreach(struct in getStructArray("samsite_loc", "targetname")) {
    turret = function_4af811e7fdb1c621(struct);
    turret.missile1 setCanDamage(0);
    turret.missile2 setCanDamage(0);
    turret.missile3 setCanDamage(0);
    level.var_f55e20c194c117f4[level.var_f55e20c194c117f4.size] = turret;
    turret setscriptablepartstate("usable_left", "usable");
    turret setscriptablepartstate("usable_front", "usable");
    turret setscriptablepartstate("usable_right", "usable");
    turret setscriptablepartstate("usable_left_defuse", "usable");
    turret setscriptablepartstate("usable_front_defuse", "usable");
    turret setscriptablepartstate("usable_right_defuse", "usable");
    turret setscriptablepartstate("usable_front", "unusable");
    turret function_e70d07a164d078c2("plant");
    zone.turrets[zone.turrets.size] = turret;
  }

  if(!isarray(objective.objectivekey)) {
    objective.objectivekey = [objective.objectivekey];
  }

  objectiveid = objective.objectiveid;
  objectivekeys = objective.objectivekey;
  function_37487e9ef3996964(objective);
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&function_260a303b50ba69cc);

  foreach(i, sam_site in level.var_f55e20c194c117f4) {
    objectivekey = objectivekeys[i];
    marker = sam_site function_bbcd7058816ef794(objectivekey, &"MP_INGAME_ONLY/OBJ_PLANT_CAPS", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "hud_icon_vehicle_samsite", undefined, (0, 0, 300));
    level.objectives[objectivekey] = marker;
    level.objectives[objectivekey].objectivetype = objective.objectivetype;
    level.objectives[objectivekey].turret = sam_site;
    level.objectives[objectivekey].turret.objectivekey = objectivekey;
    level.objectives[objectivekey] thread function_ce07c8b7bf47de7b();
  }
}

function function_fe6c238f87f0d34(zone) {
  foreach(sam_site in level.var_f55e20c194c117f4) {
    sam_site function_6ce08fcf00f18e1();
  }

  function_21ee5fc831ef88cc(zone);
}

function function_20ac728c10edaff1(zone) {
  foreach(player in scripts\mp\utility\teams::getteamdata(game["attackers"], "players")) {
    player thread scripts\mp\utility\points::doscoreevent(#"hash_f971655f11159a88");
  }

  delaythread(2, &leaderdialog, "defenders_lost_sam_site", game["defenders"]);
}

function function_841f344a6ab9d6f9(zone) {
  objective = zone.objective;
  var_6085a8df9c0e33eb = getEntArray(objective.targetname, "targetname");
  objectiveid = objective.objectiveid;
  objectivekeys = objective.objectivekey;
  var_3800a132040816d1 = 0;
  level.numhostages = var_6085a8df9c0e33eb.size;
  level.returnon = getdvarint(@ "hash_7798be18e3f3ad91", 0);
  level.var_e181fdcc8e4e5173 = getdvarint(@ "hash_71c04cb18cad67cd", 0);
  level.var_f224e09983ef4b2a = getdvarint(@ "hash_20103d7a5a56aac8", 20);
  level.iconrecover = "rescue_recover";
  level.iconescort = "rescue_escort";
  level.iconreturn = "rescue_escort_return";
  level.iconextract = "rescue_taking_extract";
  level.icondefendextract = "rescue_defend_extract";
  level.iconcaptureextract = "rescue_capture_extract";
  level.showenemycarrier = 0;
  level.var_385bb8fdab525e2b = 1;
  scripts\mp\gametypes\rescue::initanims();
  scripts\mp\gametypes\rescue::function_b924ba876ae5b152();
  function_37487e9ef3996964(objective);
  level.extractzones = [];

  foreach(i, trigger in var_6085a8df9c0e33eb) {
    if(var_3800a132040816d1 >= level.numhostages) {
      break;
    }

    objectivekey = objectivekeys[i];
    visuals[0] = spawn("script_model", trigger.origin);
    visuals[0] setModel("body_civ_me_male_1_1");
    visuals[0] setasgametypeobjective();
    hostage = scripts\mp\gameobjects::createcarryobject(game["defenders"], trigger, visuals, (0, 0, 16), undefined, 1);
    hostage.iconname = objectivekey;
    hostage.objectivekey = objectivekey;
    level.objectives[objectivekey] = hostage;
    level.objectives[objectivekey].objectivetype = objective.objectivetype;
    head = spawn("script_model", visuals[0].origin);
    head setModel("head_hostage_hood_01");
    head linkTo(visuals[0], "j_neck", (-9, 1, 0), (0, 0, 0));
    hostage.head = head;
    hostage.body = visuals[0];
    hostage.body solid();
    hostage.head solid();
    tracestart = visuals[0].origin + (0, 0, 32);
    traceend = visuals[0].origin + (0, 0, -100);
    contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1);
    ignoreents = [visuals[0], trigger];
    trace = scripts\engine\trace::ray_trace(tracestart, traceend, ignoreents, contentoverride);

    if(trace["fraction"] < 1) {
      visuals[0].origin = trace["position"] + (0, 0, 2);
    }

    hostage.body scriptmodelplayanimdeltamotion("iw9_mp_hostage_ground_idle");
    hostage scripts\mp\gameobjects::requestid(1, 1);
    hostage scripts\mp\gameobjects::allowuse("enemy");
    hostage.cancontestclaim = 0;
    hostage.stalemate = 0;
    hostage.wasstalemate = 1;
    hostage.currprogress = 0;
    hostage.usetime = 0;
    hostage.userate = 1;
    hostage.id = "care_package";
    hostage.exclusiveuse = 0;
    hostage.skiptouching = 1;
    hostage.skipminimapids = 1;
    hostage.curorigin = hostage.body.origin;
    hostage.offset3d = (0, 0, 30);
    hostage.trigger setHintString(&"MP/HOLD_TO_ESCORT_HOSTAGE");
    hostage.trigger setusepriority(-1 - 1 - 1 - 1);
    hostage scripts\mp\gameobjects::setusetime(0);
    hostage scripts\mp\gameobjects::setwaitweaponchangeonuse(0);
    hostage.allowweapons = 1;
    hostage.onpickup = &scripts\mp\gametypes\rescue::function_dc87fdd9e74e945e;
    hostage.ondrop = &function_13db2131b3f0851f;
    hostage.onreset = &scripts\mp\gametypes\rescue::function_3cac51c950d63e5d;
    hostage.pickupchecks = [ &scripts\mp\gametypes\rescue::function_6201c84e805ab787, &scripts\mp\gametypes\rescue::function_a4beda038141b8f8, &scripts\mp\gametypes\rescue::function_fda15d11f6baf729, &scripts\mp\gametypes\rescue::function_5c8cf2eee42128c8, &scripts\mp\gametypes\rescue::function_ed073d24cd8ed3c5];
    hostage.onpickupfailed = &scripts\mp\gametypes\rescue::function_23456bcbf6dd329f;
    hostage.var_4bcc694316c44d94 = &scripts\mp\gametypes\rescue::function_5c749561016bc2b2;
    hostage.carryobjectasset = "hostage_rescue";

    if(getdvarint(@ "hash_c44109000ed1922d") != 0) {
      hostage scripts\mp\gameobjects::create_manual_drop_data_struct([visuals[0], hostage.head], undefined, undefined, 32, 180, undefined, 1);
    }

    hostage.objidpingfriendly = 0;
    hostage.objidpingenemy = 0;
    hostage.objpingdelay = 0.05;
    pingobjid = scripts\mp\objidpoolmanager::requestobjectiveid(99);
    hostage.var_81121fb99d0a00b = pingobjid;
    scripts\mp\objidpoolmanager::objective_add_objective(pingobjid, "done", hostage.origin);
    scripts\mp\objidpoolmanager::objective_set_play_intro(pingobjid, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(pingobjid, 0);
    hostage scripts\mp\gameobjects::setvisibleteam("none", pingobjid);
    objective_setownerteam(pingobjid, game["defenders"]);
    hostage.objidpingfriendly = 0;
    hostage.objidpingenemy = 0;
    hostage.objpingdelay = 0.05;
    pingobjid = scripts\mp\objidpoolmanager::requestobjectiveid(99);
    hostage.var_bd657a84755765de = pingobjid;
    scripts\mp\objidpoolmanager::objective_add_objective(pingobjid, "done", hostage.origin);
    scripts\mp\objidpoolmanager::objective_set_play_intro(pingobjid, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(pingobjid, 0);
    hostage scripts\mp\gameobjects::setvisibleteam("none", pingobjid);
    objective_setownerteam(pingobjid, game["attackers"]);
    hostage thread scripts\mp\gametypes\rescue::function_a5b7c34a5c2d56d2();

    if(!isDefined(level.hostages)) {
      level.hostages = [];
    }

    level.hostages[hostage.objidnum] = hostage;
    hostage scripts\mp\gameobjects::setvisibleteam("none");
    hostage scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture");

    if(level.returnon) {
      scripts\mp\gametypes\rescue::function_7d3dbbb99ee466e0(trigger, hostage);
    }

    var_3800a132040816d1++;
  }

  var_591f07fc947562c9 = getStructArray("wm_hostage_vehicle_spawn_loc", "targetname");
  vehicles = [];

  foreach(struct in var_591f07fc947562c9) {
    spawndata = spawnStruct();
    spawndata.origin = struct.origin;
    spawndata.angles = struct.angles;
    vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_jltv", spawndata);
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable(vehicle);
    vehicle vehicleshowonminimap(0);
    vehicle setCanDamage(0);
    vehicles[vehicles.size] = vehicle;
    level.escortvehicles[level.escortvehicles.size] = vehicle;
    dropoff_marker = vehicle function_bbcd7058816ef794("", &"MP_INGAME_ONLY/OBJ_BLOCK_EXFIL_CAPS", &"MP_INGAME_ONLY/OBJ_DROPOFF_CAPS", "icon_waypoint_dom_a");
    scripts\mp\objidpoolmanager::update_objective_ownerteam(dropoff_marker.objidnum, game["attackers"]);
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(dropoff_marker.objidnum);
    scripts\mp\objidpoolmanager::update_objective_onentity(dropoff_marker.objidnum, vehicles[0]);
    level.var_c8bf3a4374d235bf = dropoff_marker;
  }

  level.var_9d7cf21bb90f2cc5 = vehicles[0];
  var_72c468051c88f62f = getStructArray("wm_hostage_dropoff_loc", "targetname");
  var_2776aeb45e3f60f0 = [];

  foreach(struct in var_72c468051c88f62f) {
    forward = vectorNormalize(anglesToForward(vehicles[0].angles));
    hostage = spawn("script_model", struct.origin - (0, 0, 3) + 16 * forward);
    hostage setModel("body_civ_me_male_1_1");
    hostage.angles = struct.angles;
    hostage linkTo(vehicles[0]);
    head = spawn("script_model", visuals[0].origin);
    head setModel("head_hostage_hood_01");
    head linkTo(hostage, "j_neck", (-9, 1, 0), (0, 0, 0));
    hostage.head = head;
    var_2776aeb45e3f60f0 = array_add(var_2776aeb45e3f60f0, hostage);
    hostage scriptmodelplayanimdeltamotion("cap_civ_prty_anxious_seat02");
    hostage.head hide();
    hostage hide();
  }

  wm_hostage_dropoff_trigger = getEnt("wm_hostage_dropoff_trigger", "targetname");
  wm_hostage_dropoff_trigger enablelinkTo();
  wm_hostage_dropoff_trigger linkTo(vehicles[0]);
  wm_hostage_dropoff_trigger setHintString(&"MP_INGAME_ONLY/WM_HOSTAGE_DROPOFF");
  wm_hostage_dropoff_trigger thread function_3f70bb8b39738c34(var_2776aeb45e3f60f0, vehicles, dropoff_marker);
}

function function_ecbcf255884135c5(zone) {
  function_21ee5fc831ef88cc(zone);
}

function function_274763e755af09dc(zone) {
  wm_hostage_dropoff_trigger = getEnt("wm_hostage_dropoff_trigger", "targetname");
  wm_hostage_dropoff_trigger delete();

  if(isDefined(level.var_9d7cf21bb90f2cc5)) {
    level.var_9d7cf21bb90f2cc5 thread vehicle_move_forward_until("wm_stop_2");
  }
}

function init_bomb_objective(zone) {
  objective = zone.objective;

  if(!isarray(objective.objectivekey)) {
    objective.objectivekey = [objective.objectivekey];
  }

  triggers = getEntArray(objective.targetname, "targetname");
  objectiveid = objective.objectiveid;
  objectivekeys = objective.objectivekey;
  function_37487e9ef3996964(objective);
  level.var_be550dbbd45701ee = [];
  objective.bombzones = [];

  foreach(i, trigger in triggers) {
    objectivekey = objectivekeys[i];
    trigger.objectivekey = objectivekeys[i];
    bombzone = scripts\mp\gametypes\obj_bombzone::setupobjective(trigger, 1, 1);
    bombzone scripts\mp\gameobjects::requestid(1, 1);
    bombzone.objectivekey = objectivekey;
    bombzone.onbeginuse = &onbeginuse;
    bombzone.onenduse = &onenduse;
    bombzone.onuse = &onuseplantobject;
    bombzone.iconname = objectivekey;
    bombzone scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture", bombzone.objidnum, game["defenders"]);
    bombzone scripts\mp\gameobjects::setvisibleteam("any");
    bombzone scripts\mp\gameobjects::setownerteam(game["defenders"]);
    bombzone scripts\mp\gameobjects::allowuse("enemy");
    bombzone scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_DEFUSE_EXPLOSIVES");
    bombzone scripts\mp\objidpoolmanager::objective_show_team_progress(bombzone.objidnum, game["attackers"]);
    bombzone scripts\mp\objidpoolmanager::objective_show_team_progress(bombzone.objidnum, game["defenders"]);
    bombzone scripts\mp\gameobjects::disableobject();
    bombzone scripts\mp\gameobjects::allowuse("none");
    level.objectives[objectivekey] = bombzone;
    level.objectives[objectivekey].objectivetype = objective.objectivetype;
    level.var_be550dbbd45701ee[level.var_be550dbbd45701ee.size] = bombzone;
    zone.bombzones[objective.bombzones.size] = bombzone;
  }

  ents2 = getEntArray("catwalk_bomb_lights", "targetname");

  foreach(light in ents2) {
    light thread blink_light(0.5, 0.3, 0, 1, 0.75, 1);
  }
}

function function_2e079de28a14edf4(zone) {
  function_21ee5fc831ef88cc(zone);

  foreach(objstr in zone.objectives) {
    bombzone = level.objectives[objstr];
    bombzone scripts\mp\gameobjects::enableobject();
    bombzone scripts\mp\gameobjects::allowuse("enemy");
  }
}

function function_b1e48e6ea7e1a047(zone) {
  foreach(player in scripts\mp\utility\teams::getteamdata(game["attackers"], "players")) {
    player thread scripts\mp\utility\points::doscoreevent(#"hash_57e238c776c8e030");
  }

  delaythread(2, &leaderdialog, "defenders_lost_bomb_objective", game["defenders"]);
}

function function_2d7f27839316e035(zone) {
  namespace_dad3c7903f3cd2f7::function_e27a6d1eec1c355e();
  objective = zone.objective;

  if(!isarray(objective.objectivekey)) {
    objective.objectivekey = [objective.objectivekey];
  }

  triggers = getEntArray(objective.targetname, "targetname");
  objectiveid = objective.objectiveid;
  objectivekeys = objective.objectivekey;
  function_37487e9ef3996964(objective);
  zone.hackzones = [];

  foreach(i, trigger in triggers) {
    objectivekey = objectivekeys[i];
    trigger.objectivekey = objectivekeys[i];
    usingvisualhintstring = objective.params["usingVisualHintString"];
    hackzone = namespace_dad3c7903f3cd2f7::setupobjective(trigger, i, 1, 1, usingvisualhintstring);
    hackzone scripts\mp\gameobjects::setvisibleteam("none");
    hackzone scripts\mp\gameobjects::allowuse("none");
    level.objectives[objectivekey] = hackzone;
    level.objectives[objectivekey].objectivetype = objective.objectivetype;
    zone.hackzones[zone.hackzones.size] = hackzone;
  }
}

function function_8ed8bdf501691dc9(zone) {
  level.ontimelimitgraceperiod = getdvarint(@ "hash_312c816d24ef8e64", 9);

  foreach(objstr in zone.objectives) {
    hackzone = level.objectives[objstr];
    hackzone.onbeginuse = &function_1b196fb976284ed1;
    hackzone.onenduse = &function_e47da7dc98a3d8cc;
    hackzone scripts\mp\gameobjects::setvisibleteam("any");
    hackzone scripts\mp\gameobjects::allowuse("enemy");
  }
}

function function_2816c555d1a0bde(zone) {
  level notify("end_hack_zone_objective");
  objective = zone.objective;
  level.ontimelimitgraceperiod = 5;

  if(isDefined(objective.params["leaderDialogAttackers"])) {
    attackersleaderdialog = objective.params["leaderDialogAttackers"];
    delaythread(2, &leaderdialog, attackersleaderdialog, game["attackers"]);
  }

  if(isDefined(objective.params["leaderDialogDefenders"])) {
    defendersleaderdialog = objective.params["leaderDialogDefenders"];
    delaythread(2, &leaderdialog, defendersleaderdialog, game["defenders"]);
  }

  foreach(objstr in zone.objectives) {
    hackzone = level.objectives[objstr];
    hackzone scripts\mp\gameobjects::setvisibleteam("none");
    hackzone scripts\mp\gameobjects::allowuse("none");
  }

  scripts\mp\utility\points::function_2a66e9acc30896c(game["attackers"], #"hash_6540fe71b5eda3fb");
}

function function_b707f54f7de4fd15(zone) {
  level.flagmodel = "jup_military_pdsf";
  level.carryflag = "prop_jup_military_pdsf";
  [level.flagbase] = getscriptablearray("flag_base", "targetname");
  level.flagbase.moverdoesnotkill = 1;
  level.var_544a602bcb83bd67 = [];

  if(isDefined(level.flagbase)) {
    var_a3eef61e74c63696 = level.flagbase gettagorigin("tag_turret01");
    var_b7e599a8c8b5dd4c = level.flagbase gettagangles("tag_turret01");
    level.var_544a602bcb83bd67[level.var_544a602bcb83bd67.size] = spawnscriptable("jup_skydiving_military_pdsf", var_a3eef61e74c63696, var_b7e599a8c8b5dd4c);
    var_a6a5d1c6330010ef = level.flagbase gettagorigin("tag_turret02");
    var_c6ac5393bb14da91 = level.flagbase gettagangles("tag_turret02");
    level.var_544a602bcb83bd67[level.var_544a602bcb83bd67.size] = spawnscriptable("jup_skydiving_military_pdsf", var_a6a5d1c6330010ef, var_c6ac5393bb14da91);
    level.flagbase function_3677f2be30fdd581("model", "red");
  }

  namespace_16a6643951556450::updategametypedvars();
  objective = zone.objective;

  if(!isarray(objective.objectivekey)) {
    objective.objectivekey = [objective.objectivekey];
  }

  objectiveid = objective.objectiveid;
  objectivekeys = objective.objectivekey;
  targetnames = objective.targetname;
  function_37487e9ef3996964(objective);
  objectivekey = objectivekeys[0];
  flagpoints = [];

  if(isarray(targetnames)) {
    foreach(targetname in targetnames) {
      if(issubstr(targetname, "flag_begin")) {
        flagpoint = getEnt(targetname, "targetname");
        flagpoints = array_add(flagpoints, flagpoint);
        assertex(flagpoints.size != 0, "<dev string:x1c>" + targetname);
        continue;
      }

      if(issubstr(targetname, "flag_end")) {
        flagzone = getEnt(targetname, "targetname");
        assertex(isDefined(flagzone), "<dev string:x1c>" + targetname);
        continue;
      }

      if(issubstr(targetname, "capture_zone")) {
        capturezone = getEnt(targetname, "targetname");
        assertex(isDefined(capturezone), "<dev string:x1c>" + targetname);
        continue;
      }

      assertmsg("<dev string:x44>" + targetname);
    }
  } else if(issubstr(targetnames, "flag_begin")) {
    flagpoints = getEntArray(targetnames, "targetname");
    assertex(flagpoints.size != 0, "<dev string:x1c>" + targetnames);
  } else if(issubstr(targetnames, "flag_end")) {
    flagzone = getEnt(targetnames, "targetname");
    assertex(flagzone != 0, "<dev string:x1c>" + targetnames);
  } else if(issubstr(targetname, "capture_zone")) {
    capturezone = getEnt(targetname, "targetname");
    assertex(isDefined(capturezone), "<dev string:x1c>" + targetname);
  } else {
    assertmsg("<dev string:x44>" + targetnames);
  }

  alltriggers = array_add(flagpoints, flagzone);
  alltriggers = array_add(alltriggers, capturezone);

  foreach(i, trigger in alltriggers) {
    trigger.objectivekey = objectivekeys[i];
    trigger.script_label = objectivekeys[i];
  }

  zone.captureflags = namespace_16a6643951556450::function_a892b65a4cfef993(flagpoints);
  zone.flagzone = namespace_16a6643951556450::createflagzone(flagzone);
  zone.var_dcecc1ffe9d55d6e = getStructArray("flag_checkpoint", "targetname");
  index = 0;

  foreach(captureflag in zone.captureflags) {
    objectivekey = objectivekeys[index];
    level.objectives[objectivekey] = captureflag;
    level.objectives[objectivekey].objectivetype = objective.objectivetype;
    index++;
  }

  objectivekey = objectivekeys[index];
  level.objectives[objectivekey] = zone.flagzone;
  level.objectives[objectivekey].objectivetype = objective.objectivetype;
  index++;
  level.var_f44f122a81824290 = function_ef4d323f56385843("captureFlagZoneTime", 60);
  level.zonecapturetime = level.var_f44f122a81824290;
  objectivekey = objectivekeys[index];
  capturezone.objectivekey = objectivekey;
  capturezone.script_label = objectivekey;
  var_f414affbb2644d5a = scripts\mp\gametypes\obj_zonecapture::setupobjective(capturezone);
  var_f414affbb2644d5a scripts\mp\gametypes\obj_zonecapture::activatezone(undefined, 1);
  var_f414affbb2644d5a.iconname = objectivekey;
  var_f414affbb2644d5a scripts\mp\gameobjects::setusetime(level.zonecapturetime);
  var_f414affbb2644d5a.onuse = &function_ba09d65c3d7386ea;
  var_f414affbb2644d5a.onbeginuse = &function_ceb1bb733cf25d55;
  var_f414affbb2644d5a.onuseupdate = &function_653bab3ddec214a3;
  var_f414affbb2644d5a.onenduse = &function_9e4725f0fafd0f29;
  var_f414affbb2644d5a.ignorestomp = !istrue(function_29227adb79acc568("zoneReversible", 0));
  var_f414affbb2644d5a.useratemultiplier = 1;
  var_f414affbb2644d5a.var_823c5a7bf6a0e64a = level.flagreinforcement;
  var_f414affbb2644d5a.blockcapdisabled = 1;
  var_f414affbb2644d5a scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture", var_f414affbb2644d5a.objidnum, game["attackers"]);
  var_f414affbb2644d5a scripts\mp\gameobjects::setvisibleteam("any");
  objective_state(var_f414affbb2644d5a.objidnum, "done");
  var_f414affbb2644d5a.var_b2dfb3f0778c829a = &"MP_INGAME_ONLY/OBJ_CAPTURING_CAPS";
  zone.flag_capture_zone = var_f414affbb2644d5a;
  level.objectives[objectivekey] = var_f414affbb2644d5a;
  level.objectives[objectivekey].objectivetype = objective.objectivetype;
  zone.var_a41fe785a977666f = 0;
}

function function_ba09d65c3d7386ea(player) {
  level.defendersrespawndelay = function_ef4d323f56385843("defendersRespawnDelay", 0);
  function_7d30ae61c44bd1a0(player);
}

function function_653bab3ddec214a3(team, progress, change, capplayer) {
  scripts\mp\gametypes\obj_zonecapture::zone_onuseupdate(team, progress, change, capplayer);

  if(progress >= 0.2 && level.flagbase.nextstate == "charged_1") {
    level.flagbase function_3677f2be30fdd581("model", "charged_1");
    waitframe();
    level.flagbase function_3677f2be30fdd581("model", "charging_2");
    level.flagbase.nextstate = "charging_2";
    return;
  }

  if(progress >= 0.2 && level.flagbase.nextstate == "charging_2") {
    level.flagbase function_3677f2be30fdd581("model", "charged_1");
    waitframe();
    level.flagbase function_3677f2be30fdd581("model", "charging_2");
    level.flagbase.nextstate = "charging_3";
    return;
  }

  if(progress >= 0.4 && level.flagbase.nextstate == "charging_3") {
    level.flagbase function_3677f2be30fdd581("model", "charged_2");
    waitframe();
    level.flagbase function_3677f2be30fdd581("model", "charging_3");
    level.flagbase.nextstate = "charging_4";
    return;
  }

  if(progress >= 0.6 && level.flagbase.nextstate == "charging_4") {
    level.flagbase function_3677f2be30fdd581("model", "charged_3");
    waitframe();
    level.flagbase function_3677f2be30fdd581("model", "charging_4");
    level.flagbase.nextstate = "charging_5";
    return;
  }

  if(progress >= 0.8 && level.flagbase.nextstate == "charging_5") {
    level.flagbase function_3677f2be30fdd581("model", "charged_4");
    waitframe();
    level.flagbase function_3677f2be30fdd581("model", "charging_5");
    level.flagbase.nextstate = "deploy";
    return;
  }

  if(progress >= 0.95 && level.flagbase.nextstate == "deploy") {
    level notify("zone_3_almost_done");
    level.flagbase.nextstate = "full_charged";
    return;
  }

  if(progress >= 1 && level.flagbase.nextstate == "full_charged") {
    level.flagbase function_3677f2be30fdd581("model", "charged_5");
    level.flagbase.nextstate = undefined;
  }
}

function function_4f20ec3b4b62da91(zone) {
  level.ontimelimitgraceperiod = getdvarint(@ "hash_e3f9b33c071fcce8", 10);
  level.objectivescaler = 1;
  namespace_16a6643951556450::function_fef84731c75ce2c5();
  flagzone = level.zone.flagzone;
  flagzone scripts\mp\gameobjects::setvisibleteam("any");
  flagzone scripts\mp\gameobjects::allowuse("enemy");
  namespace_16a6643951556450::function_e8c48ecc4a22fcd1();
  objective_state(flagzone.objidnum, "current");
  level.zonecapturetime = level.var_f44f122a81824290;
  zone.currentphase = "capture_flag";
  function_a2ef0341d328f8e1(flagzone.objectivekey);
  scripts\mp\gametypes\wm_utility::function_798f8bdeee7f862f();

  if(isDefined(level.flagbase)) {
    level.flagbase function_3677f2be30fdd581("model", "init");
  }
}

function function_df7bc18f8882600e(zone) {
  level.ontimelimitgraceperiod = 5;
  level.objectivescaler = undefined;
  objective = zone.objective;

  if(isDefined(objective.params["leaderDialogAttackers"])) {
    attackersleaderdialog = objective.params["leaderDialogAttackers"];
    delaythread(2, &leaderdialog, attackersleaderdialog, game["attackers"]);
  }

  if(isDefined(objective.params["leaderDialogDefenders"])) {
    defendersleaderdialog = objective.params["leaderDialogDefenders"];
    delaythread(2, &leaderdialog, defendersleaderdialog, game["defenders"]);
  }

  scripts\mp\utility\points::function_2a66e9acc30896c(game["attackers"], #"hash_c2a81e1bb7ec57c2");
}

function function_cb215e355cb593c6(zone) {
  namespace_dad3c7903f3cd2f7::function_e27a6d1eec1c355e();
  objective = zone.objective;
  objectiveid = objective.objectiveid;
  objectivekeys = objective.objectivekey;
  function_37487e9ef3996964(objective);
  zone.hackzones = [];
  triggers = getEntArray(objective.params["hackObjective"]["targetname"], "targetname");
  objectivekeyindex = 0;

  foreach(i, trigger in triggers) {
    objectivekey = objectivekeys[i];
    trigger.objectivekey = objectivekeys[i];
    usingvisualhintstring = objective.params["usingVisualHintString"];
    hackzone = namespace_dad3c7903f3cd2f7::setupobjective(trigger, i, 1, 1, usingvisualhintstring);
    trigger setusefov(37);
    hackzone scripts\mp\gameobjects::setvisibleteam("none");
    hackzone scripts\mp\gameobjects::allowuse("none");

    if(isDefined(zone.objective.params["hackUseTime"])) {
      hackzone scripts\mp\gameobjects::setusetime(zone.objective.params["hackUseTime"]);
    }

    hackzone scripts\mp\gameobjects::setusehinttext(&"MP_JUP_WM/HOLD_TO_START_ACTIVATION");
    hackzone.var_9e987a57f0db587a = &function_3437d0c8eca62f1c;
    hackzone.var_c2b12d87bb80faff = &function_cc4020b25a7774e9;
    hackzone.var_bde11092e7372a01 = &function_b56f77a071745943;
    level.objectives[objectivekey] = hackzone;
    level.objectives[objectivekey].objectivetype = objective.objectivetype;
    zone.hackzones[zone.hackzones.size] = hackzone;
    objectivekeyindex = i;
  }

  objectivekeyindex += 1;
  zone.bombzones = [];
  triggers = getEntArray(objective.params["bombObjective"]["targetname"], "targetname");

  foreach(i, trigger in triggers) {
    objectivekey = objectivekeys[i + objectivekeyindex];
    trigger.objectivekey = objectivekeys[i + objectivekeyindex];
    bombzone = namespace_2405c528d738b81a::setupobjective(trigger);
    bombzone scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_PLANT_EXPLOSIVES_2");
    bombzone scripts\mp\gameobjects::setusetime(function_ef4d323f56385843("plantTime", 3));
    bombzone.onbeginuse = &bombzone_onbeginuse;
    bombzone.onenduse = &bombzone_onenduse;
    bombzone.var_29496385a7b64f4c = &onbombplanted;
    bombzone.var_229b5586c139bcbf = &onbombdefused;
    bombzone.var_80eb66118fa863c1 = &onbombexploded;
    bombzone scripts\mp\gameobjects::setvisibleteam("any");
    bombzone scripts\mp\gameobjects::allowuse("none");
    bombzone.useweapon = makeweapon("briefcase_bomb_mp");
    bombzone.contesttotalseconds = function_ef4d323f56385843("bombTimer", 15);
    bombzone.var_5d8933c950c9a154 = "planting";
    bombzone.var_e1ccfd9aa9c23d7c = getEnt(trigger.target, "targetname");
    bombzone.var_de4b364812150b0f = getEnt(bombzone.var_e1ccfd9aa9c23d7c.target, "targetname");
    bombzone.var_a896c92b69335a38 = getEntArray(bombzone.var_de4b364812150b0f.target, "targetname");
    bombzone.model = array_add(bombzone.var_a896c92b69335a38, bombzone.var_e1ccfd9aa9c23d7c);
    level.objectives[objectivekey] = bombzone;
    level.objectives[objectivekey].objectivetype = objective.objectivetype;
    zone.bombzones[zone.bombzones.size] = bombzone;
  }
}

function function_3437d0c8eca62f1c(zone, player) {
  namespace_dad3c7903f3cd2f7::function_3437d0c8eca62f1c(zone, player);
  zone scripts\mp\gameobjects::setusehinttext(&"MP_JUP_WM/HOLD_TO_STOP_ACTIVATION");
}

function function_cc4020b25a7774e9(zone, player) {
  namespace_dad3c7903f3cd2f7::function_cc4020b25a7774e9(zone, player);
  zone scripts\mp\gameobjects::setusehinttext(&"MP_JUP_WM/HOLD_TO_START_ACTIVATION");
}

function function_b56f77a071745943() {
  function_8bce9c7e1a380040(self.objectivekey);
}

function bombzone_onbeginuse(player) {
  namespace_2405c528d738b81a::function_fa7eadcccfd9f8af(player);
  player thread scripts\mp\gametypes\obj_bombzone::setbombplantingomnvar("_a");
  player lerpfovscalefactor(0, 0);
}

function bombzone_onenduse(team, player, result) {
  namespace_2405c528d738b81a::function_8872296c098fd3(team, player, result);
  player lerpfovscalefactor(1, 0);
}

function onbombplanted(player) {
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_bomb_defend", "waypoint_bomb_defuse");
  scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_DEFUSE_EXPLOSIVES_2");
  scripts\mp\gameobjects::setusetime(function_ef4d323f56385843("defuseTime", 3));
  self.var_5d8933c950c9a154 = "defusing";
  self.trigger playsoundtoteam("jup_wm_bombsite_start_ally", player.team);
  self.trigger playsoundtoteam("jup_wm_bombsite_start_enemy", getotherteam(player.team)[0]);
  thread function_758991cbe4837f5c();
  level notify("hack_bomb_planted");
  player notify("wmObj_captured");
}

function onbombdefused(player) {
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_bomb_defend", "waypoint_bomb_plant");
  scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_PLANT_EXPLOSIVES_2");
  scripts\mp\gameobjects::setusetime(function_ef4d323f56385843("plantTime", 3));
  self.var_5d8933c950c9a154 = "planting";
  self.trigger playsoundtoteam("jup_wm_bombsite_recovered_ally", player.team);
  self.trigger playsoundtoteam("jup_wm_bombsite_recovered_enemy", getotherteam(player.team)[0]);
  level notify("hack_bomb_defused");
}

function onbombexploded() {
  foreach(bombmodel in self.model) {
    bombmodel delete();
  }

  function_8bce9c7e1a380040(self.objectivekey);
}

function function_758991cbe4837f5c() {
  level endon("game_ended");
  self endon("contest_recovered");
  self endon("obj_contest_zone_robbed");

  if(!isDefined(self.var_256648199aa47753)) {
    waitframe();
  }

  if(level.mapname == "mp_jup_skydiving") {
    thread function_392116cb868e4771();
  }

  while(true) {
    if(self.var_256648199aa47753 < 0.5) {
      playsoundatpos(self.trigger.origin + (0, 0, 15), "jup_wm_bombsite_beep");
    } else if(self.var_256648199aa47753 > 0.5 && self.var_256648199aa47753 < 0.95) {
      playsoundatpos(self.trigger.origin + (0, 0, 15), "jup_wm_bombsite_beep_half");
    } else if(self.var_256648199aa47753 > 0.95) {
      playsoundatpos(self.trigger.origin + (0, 0, 15), "jup_wm_bombsite_beep_final");
    }

    wait 1;
  }
}

function function_392116cb868e4771() {
  level endon("game_ended");
  self endon("contest_recovered");
  level endon("obj_contest_zone_robbed");
  var_e6bb11a78e566a1a = 0;

  while(var_e6bb11a78e566a1a < 2) {
    playsoundatpos((-12084, -24703, 5680), "jup_wm_bombsite_alarm_fl");
    playsoundatpos((-12275, -23812, 5680), "jup_wm_bombsite_alarm_fr");
    playsoundatpos((-11552, -23659, 5680), "jup_wm_bombsite_alarm_rl");
    playsoundatpos((-11363, -24544, 5680), "jup_wm_bombsite_alarm_rr");

    if(istrue(level.objectives["_c"].complete)) {
      var_e6bb11a78e566a1a++;
    }

    wait 2;
  }
}

function function_45828a6389a8309a(zone) {
  level.ontimelimitgraceperiod = getdvarint(@ "hash_e1f583ece5f18aad", 6);

  foreach(hackzone in zone.hackzones) {
    hackzone scripts\mp\gameobjects::setvisibleteam("any");
    hackzone scripts\mp\gameobjects::allowuse("enemy");
    function_a2ef0341d328f8e1(hackzone.objectivekey);
  }

  zone.currentphase = "hack";

  foreach(bombzone in zone.bombzones) {
    bombzone scripts\mp\gameobjects::setobjectivestatusicons("waypoint_bomb_lock");
    bombzone scripts\mp\gameobjects::setlocked(1);
    bombzone scripts\mp\gameobjects::function_3e4a31be47aee8f3(1);
    scripts\mp\objidpoolmanager::update_objective_setneutrallabel(bombzone.objidnum, &"MP_INGAME_ONLY/OBJ_LOCKED_CAPS");
  }

  level thread function_ffe3e3561b343b7d(zone);
}

function function_ffe3e3561b343b7d(zone) {
  level endon("game_ended");
  level waittill("hack_zone_upload_full_complete");
  zone.currentphase = "bomb";
  level.defendersrespawndelay = getdvarint(@ "hash_ab1f8c445e5c3618", 3);

  foreach(bombzone in zone.bombzones) {
    bombzone scripts\mp\gameobjects::setlocked(0);
    bombzone scripts\mp\gameobjects::setobjectivestatusicons("waypoint_bomb_defend", "waypoint_bomb_plant");
    bombzone scripts\mp\gameobjects::setvisibleteam("any");
    bombzone scripts\mp\gameobjects::allowuse("enemy");
    bombzone scripts\mp\gameobjects::function_c882c384f0e771a1(1);
    function_a2ef0341d328f8e1(bombzone.objectivekey);
  }
}

function function_3e616a6187e9d6ff(zone) {
  level.ontimelimitgraceperiod = 5;
  objective = zone.objective;
  level.defendersrespawndelay = function_ef4d323f56385843("defendersRespawnDelay", 0);

  if(isDefined(objective.params["leaderDialogAttackers"])) {
    attackersleaderdialog = objective.params["leaderDialogAttackers"];
    delaythread(2, &leaderdialog, attackersleaderdialog, game["attackers"]);
  }

  if(isDefined(objective.params["leaderDialogDefenders"])) {
    defendersleaderdialog = objective.params["leaderDialogDefenders"];
    delaythread(2, &leaderdialog, defendersleaderdialog, game["defenders"]);
  }

  foreach(objstr in zone.objectives) {
    zone = level.objectives[objstr];
    zone scripts\mp\gameobjects::setvisibleteam("none");
    zone scripts\mp\gameobjects::allowuse("none");
  }

  scripts\mp\utility\points::function_2a66e9acc30896c(game["attackers"], #"hash_57e238c776c8e030");
}

function function_77dccebe95510a4f() {
  remains = level.zone.hackzones.size;

  foreach(hackzone in level.zone.hackzones) {
    if(istrue(level.objectives[hackzone.objectivekey].complete)) {
      remains--;
    }
  }

  return remains;
}

function function_d277ca7e1acc3003() {
  return level.zone.currentphase;
}

function function_a62aee0aefa751b3(struct, objective, objectivekey) {
  marker = struct function_bbcd7058816ef794(objectivekey, &"MP_INGAME_ONLY/OBJ_KILL_CAPS", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_jugg");
  level.objectives[objectivekey] = marker;
  level.objectives[objectivekey].objectivetype = objective.objectivetype;
  level thread function_684d385924b600cb(struct, marker, objectivekey);
  return marker;
}

function function_684d385924b600cb(spawndata, marker, objectivekey) {
  while(!isDefined(level.agentarray) || level.agentarray.size == 0) {
    waitframe();
  }

  if(!isnavmeshloaded()) {
    return;
  }

  agent = scripts\mp\mp_agent::spawnnewagentaitype("actor_jup_exgm_enemy_warlord_test_jugg", spawndata.origin, spawndata.angles, game["defenders"]);
  agent scripts\cp_mp\agents\agent_juggernaut::function_1cbb19fc0caeab00();
  player_max_health = getmatchrulesdata("commonOption", "maxHealth");
  multiplier = 150;
  var_8e779b9bedae79b = int(player_max_health * multiplier);
  agent scripts\mp\mp_agent::set_agent_health(var_8e779b9bedae79b);
  scripts\mp\objidpoolmanager::update_objective_onentity(marker.objidnum, agent);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(marker.objidnum, 110);
  scripts\mp\objidpoolmanager::objective_pin_global(marker.objidnum, 1);
  agent.agentdamagefeedback = 1;
  agent thread function_ae789c283dba54c2(marker, spawndata);

  if(isDefined(spawndata.target)) {
    volume = function_f159c10d5cf8f0b4(spawndata.target, "targetname")[0];
    agent setgoalvolumeauto(volume);
  }

  agent waittill("death");
  level.objectives[objectivekey].complete = 1;
}

function function_ae789c283dba54c2(marker, spawndata) {
  self endon("death");
  agent = self;

  while(true) {
    agent function_9215ce6fc83759b9(550);
    agent setgoalpos(spawndata.origin);

    foreach(player in level.players) {
      health = agent.health / agent.maxhealth;

      if(health < 0) {
        health = 0;
      }

      scripts\mp\objidpoolmanager::objective_show_progress(marker.objidnum, 1);
      scripts\mp\objidpoolmanager::objective_set_progress(marker.objidnum, health);
    }

    wait 0.25;
  }
}

function function_f181e89f2aa5615f() {
  while(!isDefined(level.var_a0b2c978ca57ffc5)) {
    waitframe();
  }

  while(!isDefined(level.var_a0b2c978ca57ffc5["light_tank"])) {
    waitframe();
  }

  level.var_a0b2c978ca57ffc5["light_tank"].interact.var_9d0537be150542b3 = ["gunner"];
  level.var_a0b2c978ca57ffc5["light_tank"].interact.seatswitcharray = ["gunner"];
}

function tankscoreevent() {
  level endon("game_ended");
  self endon("entitydeleted");
  self endon("reached_goal");

  while(true) {
    wait 5;

    if(self vehicle_getspeed() <= 0 || istrue(self.contested)) {
      continue;
    }

    attackers = scripts\mp\utility\teams::getteamdata(game["attackers"], "alivePlayers");
    var_95f2a51e7b487eb2 = function_64bb0e20a20f59b7(attackers, self.origin, self.tanknearbyrange);

    foreach(player in var_95f2a51e7b487eb2) {
      if(is_equal(level.zone.objectivetype, 11)) {
        player scripts\mp\utility\points::doscoreevent(#"hash_81a9c1c924b14bba");
        continue;
      }

      player scripts\mp\utility\points::doscoreevent(#"wm_escort_tank");
    }
  }
}

function function_86bddcb4c5e824e9() {
  self endon("<dev string:x5d>");

  while(true) {
    box(self.origin);
    waitframe();
  }
}

function function_7d5057db2f8ddb6f(tank, objidnum) {
  tank endon("entitydeleted");
  tank endon("reached_goal");
  tank endon("other_reached_goal");
  tank vehicle_turnengineon();
  tank thread function_2fd30b01784b1b6b();

  while(!isDefined(level.players)) {
    waitframe();
  }

  while(isDefined(tank.var_77374a4ca1381d75) && !istrue(tank.var_77374a4ca1381d75["wm_stop_2"])) {
    waitframe();
  }

  if(!isDefined(tank.tanknearbyrange)) {
    tank.tanknearbyrange = 500;
  }

  tank thread tankscoreevent();
  reversible = function_29227adb79acc568("tankReversible", 1);
  setspeed = tank.defaultspeed;
  tank.var_7150b8620d62148 = [];
  tank.directionblocked = [];

  foreach(player in level.players) {
    player.var_3a9ae1fe9210a5b7 = 0;
  }

  tank childthread function_4453e34ea22074df();

  while(true) {
    shouldmove = 0;
    nearbyrange = tank.tanknearbyrange;
    tank.shouldjump = 0;
    tank.var_92051c7cb27cb3bb = 0;
    attackers = scripts\mp\utility\teams::getteamdata(game["attackers"], "alivePlayers");
    var_95f2a51e7b487eb2 = function_64bb0e20a20f59b7(attackers, tank.origin, nearbyrange);

    if(var_95f2a51e7b487eb2.size > 0) {
      shouldmove = 1;
    }

    defenders = scripts\mp\utility\teams::getteamdata(game["defenders"], "alivePlayers");
    nearbydefenders = function_64bb0e20a20f59b7(defenders, tank.origin, nearbyrange);
    tank.var_95f2a51e7b487eb2 = var_95f2a51e7b487eb2;
    tank.nearbydefenders = nearbydefenders;
    fullyhalt = istrue(tank.var_5fb0e90d5b2a8aae) || istrue(tank.var_6decdc73003db8d0) || istrue(tank.var_65ab8f532ca7195);
    var_99592f9425296050 = istrue(tank.var_65ab8f532ca7195);

    if(fullyhalt) {
      if(!isDefined(tank.var_c0d309289159602a)) {
        tank.var_c0d309289159602a = tank.origin;
      }
    } else {
      tank.var_c0d309289159602a = undefined;
    }

    foreach(player in level.players) {
      if(!isDefined(player.var_3a9ae1fe9210a5b7)) {
        player.var_3a9ae1fe9210a5b7 = 0;
      }

      var_763caca9e047aed4 = player.var_3a9ae1fe9210a5b7;

      if(game["attackers"] == player.team) {
        player.var_3a9ae1fe9210a5b7 = array_contains(var_95f2a51e7b487eb2, player);
      } else {
        player.var_3a9ae1fe9210a5b7 = array_contains(nearbydefenders, player);
      }

      if(var_763caca9e047aed4 != player.var_3a9ae1fe9210a5b7) {
        if(istrue(var_763caca9e047aed4)) {
          tank function_bc781bec44dec115(player, 1);
          continue;
        }

        tank function_458432ef4351024c(player);
      }
    }

    tank.contested = 0;

    if(istrue(tank.canstopbydefenders)) {
      if(shouldmove && nearbydefenders.size > 0) {
        tank.contested = 1;
        shouldmove = 0;
      }

      if(reversible) {
        backwardcheck = 0;

        if(isDefined(tank.stageid) && isDefined(tank.checkpoints) && isDefined(tank.checkpoints[tank.stageid - 1])) {
          backwardcheck = tank.checkpoints[tank.stageid - 1].progress;
        }

        if(!fullyhalt && !isDefined(tank.overridespeed)) {
          if(tank.progress - backwardcheck > 0.004 && nearbydefenders.size > 0 && var_95f2a51e7b487eb2.size == 0) {
            shouldmove = 1;

            if(!istrue(tank.shouldreverse)) {
              tank.shouldreverse = 1;
              setspeed = tank.defaultspeed / 2;

              if(isDefined(level.zone.objective) && isDefined(level.zone.objective.params["wheelsonRetreatSpeed"])) {
                setspeed = level.zone.objective.params["wheelsonRetreatSpeed"];
              }

              tank.veh_pathdir = "reverse";
              tank.veh_transmission = "reverse";
              tank notify("reverse_changed");
            }
          } else if(nearbydefenders.size == 0 && var_95f2a51e7b487eb2.size > 0) {
            if(istrue(tank.shouldreverse)) {
              tank.shouldreverse = 0;
              setspeed = tank.defaultspeed;
              tank.veh_pathdir = "forward";
              tank.veh_transmission = "forward";
              tank notify("reverse_changed");
            }
          }
        }
      }
    }

    if(level.escortvehicles.size > 1) {
      var_6af9a8091a2b404 = sortbydistancecullbyradius(level.players, tank.origin, nearbyrange + 100);

      foreach(player in var_6af9a8091a2b404) {
        player function_3cd19573df126b43(objidnum, tank);
      }
    } else {
      foreach(player in level.players) {
        player function_3cd19573df126b43(objidnum, tank);
      }
    }

    tank.var_5b67ad6d3409a341 = 0;

    if(isDefined(tank.var_7150b8620d62148)) {
      foreach(index, trapped in tank.var_7150b8620d62148) {
        if(istrue(trapped)) {
          tank.var_5b67ad6d3409a341 = 1;

          if(tank.directionblocked[index] == "forward" && !istrue(tank.shouldreverse)) {
            shouldmove = 0;
            break;
          }

          if(tank.directionblocked[index] == "backward" && istrue(tank.shouldreverse)) {
            shouldmove = 0;
            break;
          }
        }
      }
    }

    function_56a6df7bc15c1d56(tank, objidnum);

    if(fullyhalt) {
      tank.var_92051c7cb27cb3bb = 0;
      currentspeed = tank function_796a1097d8a12f6a();

      if(currentspeed != 0) {
        currentspeed -= 0.9;
        tank.shouldjump = 1;

        if(currentspeed < 0) {
          currentspeed = 0;
        }

        if(var_99592f9425296050) {
          if(distance2dsquared(tank.origin, tank.var_c0d309289159602a) >= 1225) {
            currentspeed = 0;
          }
        }

        tank function_221a50fb1dadfc46(currentspeed);
      } else {
        tank.shouldjump = 0;
        tank notify("tank_stop");
      }
    } else if(isDefined(tank.overridespeed)) {
      tank.var_92051c7cb27cb3bb = 0;
      tank function_221a50fb1dadfc46(tank.overridespeed);
      tank.shouldjump = 1;
    } else if(!shouldmove) {
      tank.var_92051c7cb27cb3bb = 0;
      tank function_221a50fb1dadfc46(0);
      tank.shouldjump = 0;
      tank notify("tank_stop");
    } else {
      tank.var_92051c7cb27cb3bb = 1;
      tank function_221a50fb1dadfc46(setspeed);
      tank.shouldjump = 1;
      tank notify("tank_moving");
    }

    wait 0.25;
  }
}

function function_3cd19573df126b43(objidnum, tank) {
  state = 0;
  text = undefined;

  if(istrue(self.var_3a9ae1fe9210a5b7)) {
    if(istrue(tank.var_5b67ad6d3409a341)) {
      state = 4;

      if(level.mapname == "mp_jup_skydiving") {
        text = &"MP_INGAME_ONLY/OBJ_BLOCKED_BAFFLE";
      } else {
        text = &"MP_INGAME_ONLY/OBJ_BLOCKED_HEDGEHOG_CAPS";
      }
    } else if(istrue(tank.var_65ab8f532ca7195)) {
      state = 4;
      text = &"MP_INGAME_ONLY/OBJ_HALT_CAPS";
    } else if(tank.contested) {
      state = 3;
      text = &"MP_INGAME_ONLY/OBJ_CONTESTING_CAPS";
    } else if(self.team == game["attackers"]) {
      state = 1;
      text = &"MP_INGAME_ONLY/OBJ_ESCORTING_CAPS";
    } else {
      state = 2;
      text = &"MP_INGAME_ONLY/OBJ_FORCING_BACK_CAPS";
    }
  }

  if(!isDefined(self.var_974cca039ded252e) || self.var_974cca039ded252e != state) {
    thread function_e9ecbc39979febfd(objidnum, state, text, !istrue(tank.var_65ab8f532ca7195));
    self.var_974cca039ded252e = state;
  }
}

function function_e9ecbc39979febfd(objidnum, var_974cca039ded252e, text, var_d2f33cb2882e714d) {
  if(isDefined(self.var_974cca039ded252e) && self.var_974cca039ded252e != 0) {
    objective_unpin_player(objidnum, self);
    function_8b71eb96e1636edc("", self);
    waitframe();
  }

  if(var_d2f33cb2882e714d) {
    if(var_974cca039ded252e != 0) {
      objective_pin_player(objidnum, self);
    }

    if(istrue(self.var_3a9ae1fe9210a5b7)) {
      function_160f522b63c32d76(1, text);
    }
  }
}

function function_221a50fb1dadfc46(speed) {
  if(speed < 0) {
    speed = 0;
  }

  if(speed == 0) {
    setomnvar("ui_wm_escort_dir", 0);
  } else {
    setomnvar("ui_wm_escort_dir", ter_op(self.veh_pathdir == "forward", 1, -1));
  }

  if(self.usep2p) {
    if(speed == 0) {
      self function_a7fac0397762d7a6("p2p", "pause", 1);
    } else {
      self function_a7fac0397762d7a6("p2p", "resume", 1);
    }

    self function_a7fac0397762d7a6("p2p", "manualSpeed", mph_to_ips(speed));
    return;
  }

  self vehicle_setspeed(speed);
}

function function_796a1097d8a12f6a() {
  if(self.usep2p) {
    return ips_to_mph(self function_210ad508dfc813a2("p2p", "manualSpeed"));
  }

  return self vehicle_getspeed();
}

function function_c1bc249b0499979e() {
  level endon("game_ended");
  self endon("entitydeleted");

  if(!isDefined(self.pathnodes) || self.pathnodes.size == 0) {
    return;
  }

  self function_a7fac0397762d7a6("p2p", "brakeAtGoal", 0);
  self function_a7fac0397762d7a6("p2p", "goalThreshold", 10);
  nodeid = 0;
  targetnode = self.pathnodes[nodeid];
  self.var_6bb0ab1fe092bd5d = 0;

  while(isDefined(targetnode)) {
    self function_a7fac0397762d7a6("p2p", "goalPoint", targetnode.origin);
    self function_a7fac0397762d7a6("p2p", "goalAngles", targetnode.angles);
    msg = waittill_any_return_3("near_goal", "path_blocked", "reverse_changed");

    if(msg == "path_blocked") {
      continue;
    } else if(msg == "reverse_changed") {
      if(istrue(self.shouldreverse)) {
        self function_a7fac0397762d7a6("p2p", "checkStuck", 0);
        self function_a7fac0397762d7a6("p2p", "reverseForBehindGoal", 1);
      } else {
        self function_a7fac0397762d7a6("p2p", "checkStuck", 1);
        self function_a7fac0397762d7a6("p2p", "reverseForBehindGoal", 0);
      }
    }

    if(istrue(self.shouldreverse)) {
      nodeid--;
    } else {
      nodeid++;
    }

    targetnode = self.pathnodes[nodeid];
    self.var_6bb0ab1fe092bd5d = nodeid;
  }
}

function function_2fd30b01784b1b6b() {
  self endon("entitydeleted");
  self endon("reached_goal");

  if(self.vehicletype == "veh_jup_mil_lnd_tank_cougar_mg_physics") {
    var_5be28c4da990b127 = spawn("script_model", self.origin);
    var_5be28c4da990b127 linkTo(self, "tag_origin", (-80, 0, 45), (0, 0, 0));

    while(true) {
      if(self vehicle_getspeed() > 0) {
        foreach(player in level.players) {
          if(isDefined(player)) {
            player clearsoundsubmix("jup_mode_wm_tank_engine", 0.2);
          }
        }

        var_5be28c4da990b127 stopsounds();
        var_5be28c4da990b127 playsoundonmovingent("veh_jup_mil_lnd_cougar_tank_wm_start");
        self waittill("tank_stop");
      } else {
        foreach(player in level.players) {
          if(isDefined(player)) {
            player setsoundsubmix("jup_mode_wm_tank_engine", 0.2, 1);
          }
        }

        var_5be28c4da990b127 stopsounds();
        var_5be28c4da990b127 playsoundonmovingent("veh_jup_mil_lnd_cougar_tank_wm_stop");
        self waittill("tank_moving");
      }

      waitframe();
    }

    return;
  }

  if(self.vehicletype == "veh_pac_sentry_amphibious_mp_skydiving") {
    self.var_5be28c4da990b127 = spawn("script_model", self.origin);
    self.var_5be28c4da990b127 linkTo(self, "tag_origin", (0, 0, 15), (0, 0, 0));

    while(true) {
      if(istrue(self.var_65ab8f532ca7195)) {
        self.var_5be28c4da990b127 stoploopsound("veh_jup_kls_wheelson_engine_lp");
        self.var_5be28c4da990b127 playsoundonmovingent("veh_jup_kls_wheelson_engine_stop");
        self waittill("tank_moving");
      }

      if(self vehicle_getspeed() > 0) {
        if(istrue(self.shouldreverse)) {
          self.var_5be28c4da990b127 playLoopSound("veh_jup_kls_wheelson_engine_reverse_lp");
          thread function_28518f0349b4e5cb();
          waittill_any_2("reverse_changed", "tank_stop");
        } else {
          self.var_5be28c4da990b127 playsoundonmovingent("veh_jup_kls_wheelson_engine_start");
          wait 0.5;
          self.var_5be28c4da990b127 playLoopSound("veh_jup_kls_wheelson_engine_lp");
          self waittill("tank_stop");
        }
      } else {
        self.var_5be28c4da990b127 stoploopsound();
        self.var_5be28c4da990b127 playsoundonmovingent("veh_jup_kls_wheelson_engine_stop");
        self waittill("tank_moving");
      }

      waitframe();
    }

    return;
  }

  return;
}

function function_28518f0349b4e5cb() {
  self endon("entitydeleted");
  self endon("reached_goal");
  self endon("tank_stop");

  while(self.veh_pathdir == "reverse") {
    self.var_5be28c4da990b127 playsoundonmovingent("veh_jup_kls_wheelson_engine_reverse_beep");
    wait 1;
  }
}

function function_56a6df7bc15c1d56(tank, objidnum) {
  scripts\mp\objidpoolmanager::update_objective_sethot(objidnum, istrue(tank.contested || tank.var_5b67ad6d3409a341));

  if(istrue(tank.var_5b67ad6d3409a341)) {
    scripts\mp\objidpoolmanager::update_objective_setenemylabel(objidnum, &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS");
    scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(objidnum, &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS");
  } else if(istrue(tank.contested)) {
    scripts\mp\objidpoolmanager::update_objective_setenemylabel(objidnum, &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS");
    scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(objidnum, &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS");
  } else {
    scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(objidnum, &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS");
    scripts\mp\objidpoolmanager::update_objective_setenemylabel(objidnum, &"MP_INGAME_ONLY/OBJ_HALT_CAPS");
  }

  if(istrue(tank.var_5b67ad6d3409a341)) {
    scripts\mp\objidpoolmanager::update_objective_icon(objidnum, scripts\mp\gameobjects::getwaypointshader("waypoint_escort_vehicle_blocked"));
    return;
  }

  if(istrue(tank.var_5fb0e90d5b2a8aae)) {
    if(isDefined(tank.repairguy)) {
      scripts\mp\objidpoolmanager::update_objective_icon(objidnum, scripts\mp\gameobjects::getwaypointshader("waypoint_escort_vehicle_repair"));
      scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(objidnum, &"MP_INGAME_ONLY/OBJ_TANK_REPAIRING");
      scripts\mp\objidpoolmanager::update_objective_setenemylabel(objidnum, &"MP_INGAME_ONLY/OBJ_TANK_REPAIRING");
    } else {
      scripts\mp\objidpoolmanager::update_objective_icon(objidnum, scripts\mp\gameobjects::getwaypointshader("waypoint_escort_vehicle_damaged"));
      scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(objidnum, &"MP_INGAME_ONLY/OBJ_TANK_DAMAGED");
      scripts\mp\objidpoolmanager::update_objective_setenemylabel(objidnum, &"MP_INGAME_ONLY/OBJ_TANK_DAMAGED");
    }

    return;
  }

  scripts\mp\objidpoolmanager::update_objective_icon(objidnum, scripts\mp\gameobjects::getwaypointshader("waypoint_escort_vehicle"));
}

function function_98b9f09341fd9ba8(vehicle, objidnum, pathend) {
  progress = 1;
  totaldistance = distance2d(vehicle.spawndata.node.origin, pathend.origin);
  scripts\mp\objidpoolmanager::objective_set_show_progress(objidnum, 0);
  scripts\mp\objidpoolmanager::objective_set_progress_team(objidnum, game["defenders"]);

  while(distance2d(vehicle.origin, pathend.origin) > 64) {
    currenttime = gettime();

    if(!isDefined(vehicle.origin)) {
      return;
    }

    progress = 1 - distance(vehicle.origin, pathend.origin) / totaldistance;

    if(progress < 0) {
      progress = 0;
    }

    scripts\mp\objidpoolmanager::objective_set_progress(objidnum, progress);
    vehicle.progress = progress;
    waitframe();
  }

  function_d507ea0668f3666c(vehicle);
}

function function_f2a1c180dc67b7f8(vehicle, objidnum) {
  level endon("game_ended");
  assert(vehicle.pathnodes.size > 0);
  endnode = vehicle.pathnodes[vehicle.pathnodes.size - 1];
  totaldistance = endnode.var_1d7ebd1bcc23a4e1;
  vehicle.var_56df20c41f5b3159 = 1 / totaldistance;

  level thread function_d36257ceb2380e24(vehicle, vehicle.pathnodes);

  if(isDefined(vehicle.spawndata.spawnmethod) && vehicle.spawndata.spawnmethod == "airdrop_at_position_unsafe") {
    vehicle waittill("landed");
  }

  scripts\mp\objidpoolmanager::objective_set_show_progress(objidnum, 0);
  scripts\mp\objidpoolmanager::objective_set_progress_team(objidnum, game["defenders"]);
  var_b8d9c602e284684e = 900;

  while(vehicle.progress != 1) {
    waitframe();

    if(!vehicle.usep2p) {
      if(!isDefined(vehicle.var_6bb0ab1fe092bd5d)) {
        vehicle.var_6bb0ab1fe092bd5d = 1;
      }

      var_b2f8f3051e3018b1 = distance2dsquared(vehicle.pathnodes[vehicle.var_6bb0ab1fe092bd5d].origin, vehicle.origin);
      var_1f7233a1b7010fe4 = distance2dsquared(vehicle.pathnodes[vehicle.var_6bb0ab1fe092bd5d - 1].origin, vehicle.origin);

      if(vehicle.var_6bb0ab1fe092bd5d + 1 < vehicle.pathnodes.size && var_b2f8f3051e3018b1 < var_b8d9c602e284684e && !istrue(vehicle.shouldreverse)) {
        vehicle.var_6bb0ab1fe092bd5d++;
      } else if(vehicle.var_6bb0ab1fe092bd5d > 0 && var_1f7233a1b7010fe4 < var_b8d9c602e284684e && istrue(vehicle.shouldreverse)) {
        vehicle.var_6bb0ab1fe092bd5d--;
      }

      print3d(vehicle.origin + (0, 0, 200), var_b2f8f3051e3018b1, (1, 0, 0));
    }

    var_92bc69459236be07 = vehicle.var_6bb0ab1fe092bd5d - 1;
    backnode = vehicle.pathnodes[var_92bc69459236be07];

    if(!isDefined(backnode)) {
      continue;
    }

    cachedistance = distance2d(vehicle.origin, backnode.origin);
    progress = (backnode.var_1d7ebd1bcc23a4e1 + cachedistance) / totaldistance;

    if(progress > 1) {
      progress = 1;
    } else if(vehicle.var_6bb0ab1fe092bd5d >= vehicle.pathnodes.size - 1) {
      var_b0162d29bef25c14 = distancesquared(vehicle.pathnodes[vehicle.pathnodes.size - 1].origin, vehicle.origin) < var_b8d9c602e284684e;

      if(var_b0162d29bef25c14) {
        progress = 1;
      }
    }

    vehicle.progress = progress;

    if(isDefined(vehicle.checkpoints) && isDefined(vehicle.checkpoints[vehicle.stageid])) {
      if(vehicle.progress >= vehicle.checkpoints[vehicle.stageid].progress) {
        vehicle.stageid++;

        foreach(player in scripts\mp\utility\teams::getteamdata(game["attackers"], "players")) {
          player notify("wmObj_captured");
        }
      }
    }

    scripts\mp\objidpoolmanager::objective_set_progress(objidnum, progress);

    print3d(vehicle.origin + (0, 0, 72), "<dev string:x66>" + vehicle.progress + "<dev string:x74>" + int(cachedistance) + "<dev string:x80>" + backnode.var_1d7ebd1bcc23a4e1 + "<dev string:x8f>" + distance2d(vehicle.origin, vehicle.pathnodes[var_92bc69459236be07 + 1].origin));
  }

  function_d507ea0668f3666c(vehicle);
}

function function_d507ea0668f3666c(vehicle) {
  if(!istrue(vehicle.var_a7719deb5db7d637)) {
    level.objectives[vehicle.objectivekey].complete = 1;
    level.objectives[vehicle.objectivekey] scripts\mp\gameobjects::setvisibleteam("none");
    vehicle notify("reached_goal");
    vehicle vehicle_setspeed(0, 0, 1);
    vehicle.var_a7719deb5db7d637 = 1;

    foreach(veh in level.escortvehicles) {
      if(veh == vehicle) {
        continue;
      }

      level.objectives[veh.objectivekey].complete = 1;
      level.objectives[veh.objectivekey] scripts\mp\gameobjects::setvisibleteam("none");
      veh notify("other_reached_goal");
      veh vehicle_setspeed(0, 0, 1);
      veh.var_a7719deb5db7d637 = 1;
    }
  }
}

function function_d36257ceb2380e24(vehicle, pathnodes) {
  level endon("<dev string:x9a>");
  vehicle endon("<dev string:xa8>");

  while(true) {
    for(i = 0; i < pathnodes.size; i++) {
      print3d(pathnodes[i].origin + (0, 0, 50), "<dev string:xb8>" + i + "<dev string:xc1>" + pathnodes[i].var_1d7ebd1bcc23a4e1);
      print3d(pathnodes[i].origin + (0, 0, 36), "<dev string:xc7>" + int(pathnodes[i].progress * 100) + "<dev string:xcb>");
    }

    waitframe();
  }
}

function function_a13d6040c09f7f03(c4, samsite, player) {
  if(!istrue(c4.var_7b0e1793e94cafb4)) {
    samsite function_e70d07a164d078c2("plant");
    return false;
  }

  player thread scripts\mp\utility\points::doscoreevent(#"hash_d9283d3795ee1ca0");
  level notify("planted_bomb_on_sam_site");
  samsite endon("samsite_cancel_bomb_countdown");
  currenttime = gettime();
  totaltime = 15000;
  bombendtime = int(currenttime + totaltime);
  var_c301d652d9a73075 = bombendtime - currenttime;
  objidnum = level.objectives[samsite.entity.objectivekey].objidnum;
  level.objectives[samsite.entity.objectivekey] scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defuse", "waypoint_defend", objidnum);
  level childthread function_3121d0837c912266(objidnum, bombendtime, totaltime);
  samsite function_e70d07a164d078c2("defuse");

  while(var_c301d652d9a73075 > 0) {
    currenttime = gettime();
    var_c301d652d9a73075 = bombendtime - currenttime;

    if(var_c301d652d9a73075 < 1500) {
      if(var_c301d652d9a73075 <= 250) {
        if(soundexists("breach_warning_beep_05")) {
          c4 playSound("breach_warning_beep_05");
        }
      } else if(var_c301d652d9a73075 < 500) {
        if(soundexists("breach_warning_beep_04")) {
          c4 playSound("breach_warning_beep_04");
        }
      } else if(var_c301d652d9a73075 < 1500) {
        if(soundexists("breach_warning_beep_03")) {
          c4 playSound("breach_warning_beep_03");
        }
      } else if(soundexists("breach_warning_beep_02")) {
        c4 playSound("breach_warning_beep_02");
      }

      wait 0.25;
    } else if(var_c301d652d9a73075 < 3500) {
      if(soundexists("breach_warning_beep_02")) {
        c4 playSound("breach_warning_beep_02");
      }

      wait 0.5;
    } else {
      if(soundexists("breach_warning_beep_01")) {
        c4 playSound("breach_warning_beep_01");
      }

      wait 1;
    }

    if(var_c301d652d9a73075 < 0) {
      break;
    }
  }

  foreach(player in scripts\mp\utility\teams::getteamdata(game["attackers"], "players")) {
    player thread scripts\mp\utility\points::doscoreevent(#"hash_9b82ab032940a3d6");
  }

  samsite notify("samsite_bomb_detonated");
  samsite.entity thread scripts\cp_mp\samsite::sam_explode(player, "samsite_base_mp");
  return true;
}

function function_e70d07a164d078c2(state) {
  turret = self;
  ent = function_fb532e39e9edebf5(turret);
  ent.var_f236a45969f96bb4 = state;

  if(state == "plant") {
    turret setscriptablepartstate("usable_left", "usable");
    turret setscriptablepartstate("usable_front", "usable");
    turret setscriptablepartstate("usable_right", "usable");
    turret setscriptablepartstate("usable_left_defuse", "unusable");
    turret setscriptablepartstate("usable_front_defuse", "unusable");
    turret setscriptablepartstate("usable_right_defuse", "unusable");
  } else {
    turret setscriptablepartstate("usable_left", "unusable");
    turret setscriptablepartstate("usable_front", "unusable");
    turret setscriptablepartstate("usable_right", "unusable");
    turret setscriptablepartstate("usable_left_defuse", "usable");
    turret setscriptablepartstate("usable_front_defuse", "usable");
    turret setscriptablepartstate("usable_right_defuse", "usable");
  }

  turret setscriptablepartstate("usable_front", "unusable");
  turret setscriptablepartstate("usable_front_defuse", "unusable");

  foreach(player in level.players) {
    turret function_ee3f9522a825f738(player);
  }
}

function function_ee3f9522a825f738(player) {
  turret = self;
  ent = function_fb532e39e9edebf5(turret);
  state = ent.var_f236a45969f96bb4;

  if(is_equal(player.pers["team"], game["attackers"])) {
    if(state == "plant") {
      turret function_2e03390bf1d8959d(player, 1);
      turret function_4f1745dec2e39ab4(player, 0);
    }

    if(state == "defuse") {
      turret function_2e03390bf1d8959d(player, 0);
      turret function_4f1745dec2e39ab4(player, 0);
    }

    return;
  }

  if(state == "plant") {
    turret function_2e03390bf1d8959d(player, 0);
    turret function_4f1745dec2e39ab4(player, 0);
  }

  if(state == "defuse") {
    turret function_2e03390bf1d8959d(player, 0);
    turret function_4f1745dec2e39ab4(player, 1);
  }
}

function function_fb532e39e9edebf5(turret) {
  if(is_equal(turret.classname, "misc_turret")) {
    return turret;
  }

  return turret.entity;
}

function function_2e03390bf1d8959d(player, bool) {
  if(!isDefined(bool)) {
    bool = 1;
  }

  turret = self;

  if(bool) {
    turret enablescriptablepartplayeruse("usable_left", player);
    turret enablescriptablepartplayeruse("usable_right", player);
    return;
  }

  turret disablescriptablepartplayeruse("usable_left", player);
  turret disablescriptablepartplayeruse("usable_right", player);
}

function function_4f1745dec2e39ab4(player, bool) {
  turret = self;

  if(bool) {
    turret enablescriptablepartplayeruse("usable_left_defuse", player);
    turret enablescriptablepartplayeruse("usable_right_defuse", player);
    return;
  }

  turret disablescriptablepartplayeruse("usable_left_defuse", player);
  turret disablescriptablepartplayeruse("usable_right_defuse", player);
}

function function_cbd3979676d57efe(instance, part, state, player, var_a5b2c541413aa895, usestring) {
  player thread scripts\mp\utility\points::doscoreevent(#"hash_fbc15faadfadee5d");
  objidnum = level.objectives[instance.entity.objectivekey].objidnum;
  objective_set_progress(objidnum, 1);
  level.objectives[instance.entity.objectivekey] scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture", objidnum);
  instance notify("samsite_cancel_bomb_countdown");
  instance function_e70d07a164d078c2("plant");
  level notify("defused_bomb_on_sam_site");
}

function function_3121d0837c912266(objidnum, bombendtime, totaltime) {
  progress = 1;

  while(progress > 0) {
    currenttime = gettime();
    var_c301d652d9a73075 = bombendtime - currenttime;
    progress = max(0, var_c301d652d9a73075 / totaltime);
    objective_set_progress(objidnum, progress);
    objective_set_progress_team(objidnum, game["attackers"]);
    objective_show_team_progress(objidnum, game["defenders"]);
    objective_show_team_progress(objidnum, game["attackers"]);
    waitframe();
  }
}

function function_4af811e7fdb1c621(struct) {
  turret = scripts\cp_mp\samsite::function_fefa23bed4e70fb2(struct, "military_samsite_01_rig_skeleton_war_mode_mp");
  function_f7c5fc38fdc4df8c(turret);
  turret.target_entity = spawn("script_model", turret.origin + (0, 0, 900) + anglesToForward(turret.angles) * 1000);
  turret settargetentity(turret.target_entity);
  turret thread function_3683331ec49168ba();
  return turret;
}

function function_3683331ec49168ba() {
  self endon("stop_dmgmonitor");
  self setCanDamage(1);
  self setCanRadiusDamage(1);
  self.dmgtaken = 0;
  self.var_59a09303493e759d = 750;
  attacker = undefined;
  self.health = 9999999;

  while(true) {
    self waittill("damage", amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, tagname, partname, dflags, objweapon);
  }
}

function function_ce07c8b7bf47de7b() {
  while(true) {
    self.turret waittill("samsite_dead");
    scripts\mp\gameobjects::setvisibleteam("none");
    self.complete = 1;
  }
}

function function_260a303b50ba69cc() {
  player = self;

  foreach(turret in level.var_f55e20c194c117f4) {
    if(!isDefined(turret)) {
      continue;
    }

    turret function_ee3f9522a825f738(player);

    if(is_equal(level.zone.objectivetype, 5)) {
      turret function_6ce08fcf00f18e1();
    }
  }
}

function function_6ce08fcf00f18e1() {
  turret = self;
  turret hudoutlineenable("outline_depth_red");
  turret.missile1 hudoutlineenable("outline_depth_red");
  turret.missile2 hudoutlineenable("outline_depth_red");
  turret.missile3 hudoutlineenable("outline_depth_red");
}

function function_bbcd7058816ef794(objectivekey, attackermsg, defendermsg, objectiveicon, overrideownerteam, offset) {
  struct = self;

  if(!isDefined(offset)) {
    offset = (0, 0, 84);
  }

  team = game["defenders"];

  if(isDefined(overrideownerteam)) {
    team = overrideownerteam;
  }

  marker = scripts\mp\gameobjects::createobjidobject(struct.origin, team, offset, undefined, "all", 0);
  marker.iconname = objectivekey;
  marker.objectivekey = objectivekey;
  marker scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture", marker.objidnum, team);
  scripts\mp\objidpoolmanager::update_objective_icon(marker.objidnum, objectiveicon);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(marker.objidnum, team);
  scripts\mp\objidpoolmanager::update_objective_setenemylabel(marker.objidnum, attackermsg);
  scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(marker.objidnum, defendermsg);
  objective_playermask_hidefromall(marker.objidnum);
  return marker;
}

function function_389ebc5025c28934(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  level endon("game_ended");
  turret thread[[getsharedfunc("damage", "monitorDamage")]](turret.maxhealth, "hitequip", &function_242ded3cfe2e5d3b, &function_e1c17d4c7c7e96a5, 1);
}

function function_3073d3141c30bbe5(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  level endon("game_ended");

  while(true) {
    turret waittill("damage");

    if(turret.currenthealth / turret.maxhealth < 0.5) {
      playFXOnTag(getfx("tank_damaged"), turret, "tag_fx");
      break;
    }
  }
}

function function_e1c17d4c7c7e96a5(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  modifieddamage = damage;

  if(!is_equal(attacker.pers["team"], game["attackers"])) {
    return 0;
  }

  self.underattack = 1;
  delaythread(0.2, &function_58f7ac8cca982832);

  if(istrue(level.var_be6a42242be00b66)) {
    bundle = level.streakglobals.streakbundles["missile_turret"];
    modifieddamage = scripts\common\damage_tuning::getmodifieddamageusingdamagetuning(attacker, objweapon, type, modifieddamage, self.maxhealth, bundle.var_e913079a5ffda56d);
  } else if(issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage")) {
    modifieddamage = self[[getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](attacker, objweapon, type, modifieddamage, self.maxhealth, 2, 3, 4, 3, 400);
  }

  self.currenthealth -= modifieddamage;
  return modifieddamage;
}

function function_58f7ac8cca982832() {
  self.underattack = 0;
}

function function_14aa40ae092fe7b1(turret) {
  turret endon("carried");
  turret waittill("kill_turret", skipshutdown, wasdestroyed);
  turret.marker.progress += 0.2;
  turret function_70c8684c2c29bf59("destroyed");
  turret setturretowner(undefined);
  turret playSound("mp_equip_destroyed");

  if(isDefined(turret.useownerobj)) {
    turret.useownerobj delete();
  }

  if(isDefined(turret.useotherobj)) {
    turret.useotherobj delete();
  }

  if(isDefined(turret.colmodel)) {
    turret.colmodel delete();
  }

  if(isDefined(turret.marker)) {
    scripts\mp\objidpoolmanager::objective_set_progress(turret.marker.objidnum, turret.marker.progress);
  }

  if(turret.marker.progress >= 1) {
    level.objectives[turret.marker.objectivekey].complete = 1;
    objective_playermask_hidefromall(turret.marker.objidnum);
  }

  level.var_7f636ee164a47ef7 = array_remove(level.var_7f636ee164a47ef7, turret);
  wait 0.2;
  turret delete();
}

function function_70c8684c2c29bf59(type) {
  turretmodel = undefined;

  if(type == "placed") {
    turretmodel = level.missilesettings[self.turrettype].modelbaseground;
  } else {
    turretmodel = level.missilesettings[self.turrettype].modeldestroyedground;
  }

  assertex(isDefined(turretmodel), "<dev string:xd0>");
  self setModel(turretmodel);
}

function function_3f70bb8b39738c34(var_2776aeb45e3f60f0, vehicles, dropoff_marker) {
  wm_escort_hostage_path = getvehiclenode("wm_escort_hostage_path", "targetname");

  foreach(vehicle in vehicles) {
    vehicle attachpath(wm_escort_hostage_path);
    vehicle startpath();
  }

  foreach(vehicle in vehicles) {
    vehicle vehicle_setspeed(0);
  }

  while(!gameflagexists("infil_will_run")) {
    waitframe();
  }

  if(gameflag("infil_will_run")) {
    gameflagwait("infil_started");
  } else {
    while(!istrue(level.prematchstarted)) {
      waitframe();
    }
  }

  foreach(vehicle in vehicles) {
    vehicle thread vehicle_move_forward_until("wm_stop_1");
  }

  while(true) {
    self waittill("trigger", player);

    if(!istrue(player.hashostage)) {
      continue;
    }

    remainingspots = [];
    level.objectives[player.carryobject.objectivekey].complete = 1;
    player.carryobject function_1e6e529917057bf2(player);
    player.carryobject scripts\mp\gameobjects::setvisibleteam("none");
    player.carryobject scripts\mp\gameobjects::setvisibleteam("none", self.var_81121fb99d0a00b);
    player.carryobject scripts\mp\gameobjects::setvisibleteam("none", self.var_bd657a84755765de);

    if(isDefined(player)) {
      foreach(hostage in level.hostages) {
        if(!isDefined(hostage.carrier)) {
          hostage.trigger enableplayeruse(player);
        }
      }
    }

    if(isDefined(player.carryobject.trackedobject)) {
      if(isDefined(player.carryobject.trackedobject.pingobjidnum)) {
        scripts\mp\objidpoolmanager::returnobjectiveid(player.carryobject.trackedobject.pingobjidnum);
        player.carryobject.trackedobject.pingobjidnum = undefined;
      }

      player.carryobject.trackedobject scripts\mp\gameobjects::deletetrackedobject();
      player.carryobject.trackedobject = undefined;
    }

    player.carryobject scripts\mp\gameobjects::deletetrackedobject();
    player.carryobject = undefined;
    player.hashostage = undefined;

    foreach(hostage in var_2776aeb45e3f60f0) {
      if(!istrue(hostage.saved)) {
        remainingspots[remainingspots.size] = hostage;
      }
    }

    var_288410680c3048c2 = getclosest(player.origin, remainingspots);
    var_288410680c3048c2 show();
    var_288410680c3048c2.head show();
    var_288410680c3048c2.saved = 1;
    var_288410680c3048c2 scriptmodelplayanimdeltamotion("cap_civ_prty_anxious_seat02");

    if(remainingspots.size == 1) {
      break;
    }
  }

  dropoff_marker scripts\mp\objidpoolmanager::objective_playermask_hidefromall(dropoff_marker.objidnum);
}

function function_1e6e529917057bf2(player) {
  self notify("prompt_cleanup");
  player notify("remove_rig");
  self notify("remove_rig");
  self notify("hostage_pickup");
  self notify("manual_drop_cleanup");
  player val::reset_all("carry");

  if(isDefined(player.givenweapon)) {
    player takeweapon(player.givenweapon);
    player.givenweapon = undefined;
  }

  if(isDefined(player.switchweapon)) {
    player.switchweapon = undefined;
  }

  player resetcarryobject();
}

function vehicle_move_forward_until(name) {
  vehicle = self;
  vehicle notify("vehicle_move_forward_until");
  vehicle endon("vehicle_move_forward_until");

  if(!isDefined(vehicle.var_77374a4ca1381d75)) {
    vehicle.var_77374a4ca1381d75 = [];
  }

  endnode = getvehiclenode(name, "script_noteworthy");
  vehicle vehicle_setspeed(7.5);

  while(distance2d(vehicle.origin, endnode.origin) > 64) {
    waitframe();
  }

  vehicle vehicle_setspeed(0);
  vehicle.var_77374a4ca1381d75[name] = 1;
}

function function_13db2131b3f0851f(player, var_20034b7333f48b8c, manualdrop) {
  scripts\mp\gametypes\rescue::function_13db2131b3f0851f(player, var_20034b7333f48b8c, manualdrop);
  scripts\mp\gameobjects::setownerteam(game["defenders"]);
  scripts\mp\gameobjects::setvisibleteam("enemy");
}

function function_37487e9ef3996964(objective) {
  objectivekeys = objective.objectivekey;
  objectivezone = objective.objectiveid;
  zone = level.zones[objectivezone];

  if(!isDefined(zone)) {
    return;
  }

  zone.objectives = objectivekeys;
  zone.objectivetype = objective.objectivetype;
}

function function_ceb1bb733cf25d55(player) {
  zone = self;
  zone.active = 1;
  zone function_684d05448781a1f4();
  scripts\mp\gametypes\obj_zonecapture::zone_onusebegin(player);
  level notify("wm_zone_begin_capture", self);
  function_458432ef4351024c(player);
}

function function_9e4725f0fafd0f29(team, player, success) {
  scripts\mp\gametypes\obj_zonecapture::zone_onuseend(team, player, success);
  function_bc781bec44dec115(player, success);
}

function function_7d30ae61c44bd1a0(player) {
  zone = self;
  zone.active = 0;
  function_434d2efc22402e59(zone.objectivekey);
  function_8bce9c7e1a380040(zone.objectivekey);
  zone scripts\mp\gametypes\obj_zonecapture::deactivatezone();
  zone thread scripts\mp\gametypes\obj_zonecapture::updatechevrons("off");
  zone scripts\mp\gameobjects::disableobject();
  level notify("wm_zone_captured", zone);
  player notify("wmObj_captured");

  if(isDefined(level.zone.capture_zones) && isDefined(level.var_eab5ff58683de92a)) {
    complete = 0;

    foreach(capture_zone in level.zone.capture_zones) {
      if(istrue(capture_zone.complete)) {
        complete++;
      }
    }

    if(complete < level.zone.capture_zones.size) {
      [[level.var_eab5ff58683de92a]](player);
    }
  }

  if(level.zone.objectives.size > function_b8bd193977a27782()) {
    if(level.mapname == "mp_jup_skydiving") {
      if(level.zone.objectives.size > function_b8bd193977a27782() + 1) {
        thread scripts\mp\utility\print::printandsoundoneveryone(game["attackers"], game["defenders"], undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost");
      }
    } else {
      scripts\mp\utility\points::function_2a66e9acc30896c(game["attackers"], #"wm_capture_zone");
      thread scripts\mp\utility\print::printandsoundoneveryone(game["attackers"], game["defenders"], undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost");
    }

    return;
  }

  return;
}

function function_b8bd193977a27782() {
  score = 0;

  foreach(objstr in level.zone.objectives) {
    if(istrue(level.objectives[objstr].complete)) {
      score++;
    }
  }

  return score;
}

function function_1b196fb976284ed1(player) {
  namespace_dad3c7903f3cd2f7::function_c4537fbaab36b51e(player);

  if(level.mapname == "mp_jup_skydiving") {
    self.hinttrigger sethintdisplayfov(37);
    self.hinttrigger setusefov(37);
  }

  function_458432ef4351024c(player);
}

function function_e47da7dc98a3d8cc(team, player, result) {
  namespace_dad3c7903f3cd2f7::function_647ca2a49f347576(team, player, result);
  function_bc781bec44dec115(player, result);
}

function function_ef39f46e9b9dcb50(player) {
  level.objectives[self.objectivekey].complete = 1;
  scripts\mp\gametypes\obj_dom::removeobjective(self);
}

function onbeginuse(player) {
  level notify("began_defusing_bomb", player);
  scripts\mp\gametypes\obj_bombzone::bombzone_onbeginuse(player);
  player scripts\mp\objidpoolmanager::function_160f522b63c32d76(2, "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS");
}

function onuseplantobject(player) {
  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\gameobjects::allowuse("none");
  player thread scripts\mp\utility\points::doscoreevent(#"hash_ec8a2dc2f4e07935");
  function_434d2efc22402e59(self.objectivekey);
}

function function_434d2efc22402e59(objectivekey) {
  level.objectives[objectivekey].complete = 1;
}

function function_a2ef0341d328f8e1(objectivekey) {
  dlog_recordevent("dlog_event_wm_server_sub_objective_start", ["match_guid", function_94c7ae7049488358(), "map_name", level.script, "objective_type", "" + level.zone.objectivetype, "objective_id", level.zone.name, "sub_objective_time", gettime() / 1000, "sub_objective_key", objectivekey, "round", "" + game["roundsPlayed"] + 1]);

  if(!isDefined(level.var_a2e61b8ea443febf)) {
    level.var_a2e61b8ea443febf = [];
  }

  level.var_a2e61b8ea443febf[objectivekey] = 1;
}

function function_8bce9c7e1a380040(objectivekey, objectivestatus, var_a49251cd591656c0) {
  if(!isDefined(level.var_a2e61b8ea443febf)) {
    return;
  }

  status = "Completed";

  if(isDefined(objectivestatus)) {
    status = objectivestatus;
  }

  if(istrue(var_a49251cd591656c0)) {
    var_b08dbe12274f918e = game["roundsPlayed"];
  } else {
    var_b08dbe12274f918e = game["roundsPlayed"] + 1;
  }

  if(istrue(level.var_a2e61b8ea443febf[objectivekey])) {
    dlog_recordevent("dlog_event_wm_server_sub_objective_end", ["match_guid", function_94c7ae7049488358(), "map_name", level.script, "objective_type", "" + level.zone.objectivetype, "objective_id", level.zone.name, "sub_objective_time", gettime() / 1000, "sub_objective_key", objectivekey, "round", "" + var_b08dbe12274f918e, "status", status]);
    level.var_a2e61b8ea443febf[objectivekey] = undefined;
  }
}

function onenduse(team, player, result) {
  player thread scripts\mp\gametypes\obj_bombzone::allowedwhileplanting(1);
  player.bombplantweapon = undefined;
  player.isplanting = 0;

  foreach(player in level.players) {
    if(isbot(player)) {
      player notify("finished_use");
    }
  }

  if(result) {
    scripts\mp\gametypes\wm_ui::function_ace0b0228cd34c4b();
  }
}

function function_21ee5fc831ef88cc(zone) {
  foreach(objstr in zone.objectives) {
    level.objectives[objstr] scripts\mp\gameobjects::setvisibleteam("any");
  }
}

function sdhack() {}

function function_1e87a912abc079e4(zone, team, dialog, condition, cooldown, delaystart, initialcooldown) {
  struct = spawnStruct();
  struct.dialog = dialog;
  struct.cooldown = cooldown;
  struct.condition = condition;
  struct.delaystart = delaystart;
  struct.initialcooldown = initialcooldown;
  function_7de515850cb39482(zone, team, struct);
}

function function_7de515850cb39482(zone, team, struct) {
  if(!isDefined(struct.delaystart)) {
    struct.delaystart = 0;
  }

  objectivetype = zone.objectivetype;

  if(!isDefined(level.var_6c0eaa5a95164771)) {
    level.var_6c0eaa5a95164771 = [];
  }

  if(!isDefined(level.var_6c0eaa5a95164771[objectivetype])) {
    level.var_6c0eaa5a95164771[objectivetype] = [];
  }

  if(!isDefined(level.var_6c0eaa5a95164771[objectivetype][team])) {
    level.var_6c0eaa5a95164771[objectivetype][team] = [];
  }

  level.var_6c0eaa5a95164771[objectivetype][team] = array_add(level.var_6c0eaa5a95164771[objectivetype][team], struct);
}

function function_266f0d24f28fc974(zone, objectivetype) {
  foreach(var_2afe36a43d508ce1 in level.var_6c0eaa5a95164771) {
    foreach(team, var_14533a3d442c56ff in var_2afe36a43d508ce1) {
      foreach(callback in var_14533a3d442c56ff) {
        level thread function_55922f60531de59(zone, callback, team);
      }
    }
  }
}

function function_55922f60531de59(zone, callback, team) {
  level endon("game_ended");
  level endon("start_game_ended");
  voline = callback.dialog;
  cooldown = callback.cooldown;
  condition = callback.condition;
  delaystart = callback.delaystart;
  initialcooldown = callback.initialcooldown;
  conditionobject = callback.conditionobject;
  group = callback.group;
  scripts\mp\flags::gameflagwait("prematch_done");

  if(isDefined(initialcooldown) && initialcooldown > 0) {
    wait initialcooldown;
  }

  while(true) {
    if(isDefined(condition)) {
      if(isstring(condition)) {
        level waittill(condition, object);

        if(isDefined(object) && isDefined(conditionobject) && object != conditionobject) {
          continue;
        }
      }

      if(isfunction(condition)) {
        result = [[condition]](zone);

        if(!result) {
          wait 1;
          continue;
        }
      }
    }

    while(istrue(level.var_a4e3f457e2914d4a)) {
      waitframe();
    }

    if(isDefined(delaystart) && delaystart > 0) {
      wait delaystart;
    }

    if(!is_equal(level.zone, zone)) {
      return;
    }

    leaderdialog(voline, game[team], group);

    if(isDefined(cooldown) && cooldown > 0) {
      wait cooldown;
    }
  }
}

function function_fb82e12375af065f() {
  remains = level.zone.objectives.size;

  foreach(objstr in level.zone.objectives) {
    if(istrue(level.objectives[objstr].complete)) {
      remains--;
    }
  }

  return remains;
}

function function_c00d3986d67e0f5e(zone) {
  objective = zone.objective;

  if(!isarray(objective.objectivekey)) {
    objective.objectivekey = [objective.objectivekey];
  }

  objectiveid = objective.objectiveid;
  objectivekeys = objective.objectivekey;
  targetname = objective.targetname[0];
  function_37487e9ef3996964(objective);
  node = getvehiclenode(targetname, "targetname");
  objectivekey = objectivekeys[0];
  var_cca418b856d14592 = array_slice(objective.targetname, 1);
  var_fd721cc1269c6971 = array_slice(objectivekeys, 1);
  assertex(var_cca418b856d14592.size > 0, "<dev string:x118>");
  assertex(var_fd721cc1269c6971.size > 0, "<dev string:x144>");

  if(!isDefined(objectivekey)) {
    return;
  }

  spawndata = spawnStruct();
  spawndata.origin = node.origin + (0, 0, -2000);
  spawndata.angles = node.angles;
  spawndata.spawntype = "veh_pac_sentry_amphibious_mp_skydiving";
  spawndata.ownerteam = game["attackers"];
  spawndata.team = game["attackers"];
  spawndata.modelname = "veh9_mil_lnd_whotel_v2_skydiving_com";
  spawndata.vehicletype = "veh_pac_sentry_amphibious_mp_skydiving";
  spawndata.targetname = "remote_tank";
  spawndata.cancapture = 0;
  spawndata.cancaptureimmediately = 0;
  spawndata.activateimmediately = 1;
  spawndata.objectivekey = objectivekey;
  spawndata.node = node;
  spawndata.var_558e3ab4e0b5ddbc = node.origin;
  objective.spawndata = spawndata;
  marker = spawndata function_bbcd7058816ef794(objectivekey, &"MP_INGAME_ONLY/OBJ_HALT_CAPS", &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_dom" + objectivekey, game["attackers"]);
  level.objectives[objectivekey] = marker;
  zone.var_4473aa927a80a0ee = marker;
  level.objectives[objectivekey].objectivetype = objective.objectivetype;
  level.var_dabf5c79ed95aead = getdvarfloat(@ "hash_6cc435c9e8e9abd6", 30);
  level.wheelsonCaptureTime = function_ef4d323f56385843("escortCaptureTime", 30);
  level.zonecapturetime = level.wheelsonCaptureTime;
  level.var_56adfa324022c19b = "state_1";
  var_28bc3fa69bbcd119 = spawnStruct();
  var_8b61e1ed30d128c2 = spawnStruct();
  var_8b61e1ed30d128c2.objectivetype = objective.objectivetype;
  var_8b61e1ed30d128c2.objectivekey = var_fd721cc1269c6971;
  var_8b61e1ed30d128c2.objectiveid = "zone_2";
  var_8b61e1ed30d128c2.targetname = var_cca418b856d14592;
  var_8b61e1ed30d128c2.params = [];
  var_28bc3fa69bbcd119.objective = var_8b61e1ed30d128c2;
  var_28bc3fa69bbcd119.objectives = var_fd721cc1269c6971;
  triggers = [];

  foreach(name in var_8b61e1ed30d128c2.targetname) {
    triggers[triggers.size] = getEnt(name, "targetname");
  }

  var_28bc3fa69bbcd119.capture_zones = [];

  foreach(i, trigger in triggers) {
    var_a06d775e754bb451 = var_8b61e1ed30d128c2.objectivekey[i];
    trigger.objectivekey = var_a06d775e754bb451;
    trigger.script_label = var_a06d775e754bb451;
    capturezone = scripts\mp\gametypes\obj_zonecapture::setupobjective(trigger, undefined, 0, 0);
    capturezone.iconname = var_a06d775e754bb451;
    capturezone scripts\mp\gametypes\obj_zonecapture::activatezone(undefined, 1);
    scripts\mp\objidpoolmanager::update_objective_position(capturezone.objidnum, capturezone.visuals[0].origin + (0, 0, 160));
    capturezone.onuse = &function_7d30ae61c44bd1a0;
    capturezone.onbeginuse = &function_ceb1bb733cf25d55;
    capturezone.onenduse = &function_9e4725f0fafd0f29;
    capturezone.onuseupdate = &function_de7525871e8ec1a;
    capturezone.ignorestomp = 1;
    capturezone.useratemultiplier = 1;
    capturezone.var_823c5a7bf6a0e64a = level.flagreinforcement;
    capturezone.blockcapdisabled = 1;
    capturezone.var_7848db50cd8c444f = 1;
    objective_state(capturezone.objidnum, "done");
    var_28bc3fa69bbcd119.capture_zones[var_28bc3fa69bbcd119.capture_zones.size] = capturezone;
    level.objectives[var_a06d775e754bb451] = capturezone;
    level.objectives[var_a06d775e754bb451].objectivetype = var_8b61e1ed30d128c2.objectivetype;
    scripts\mp\flags::gameflaginit("point_" + i + 1 + "_hacked", 0);
  }

  zone.var_3abf844425ac7c00 = var_28bc3fa69bbcd119;
}

function function_df478f29c9a89d5a(zone) {
  level.ontimelimitgraceperiod = getdvarint(@ "hash_dcc6194b439ea409", 10);
  var_1604f1383b5b8325 = getEnt("wheelson_airdrop", "script_noteworthy");
  destination_offset = zone.objective.params["airdrop_offset"];

  if(!isDefined(destination_offset)) {
    destination_offset = (0, 0, 0);
  }

  destination = var_1604f1383b5b8325.origin + destination_offset;
  zone.currentphase = "wheelson_escort";
  function_a2ef0341d328f8e1(zone.objective.spawndata.objectivekey);
  function_a1f09cc4dd4b4d47();
  var_1ad367f504aadb35 = airdrop_wheelson(var_1604f1383b5b8325, destination);
  spawndata = level.zone.objective.spawndata;
  vehicle = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(spawndata);
  level.escortvehicles[level.escortvehicles.size] = vehicle;
  vehicle.team = game["attackers"];
  vehicle.teamfriendlyto = game["attackers"];
  vehicle.vehiclename = "pac_sentry";
  vehicle setvehicleteam(game["attackers"]);
  vehicle notsolid();
  vehicle hide();
  function_4a6cef3b190c8082(level.zone.objective, vehicle, vehicle.spawndata.objectivekey, vehicle.spawndata, vehicle.spawndata.node, level.objectives[vehicle.spawndata.objectivekey]);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.objectives["_d"].objidnum);

  foreach(crate in var_1ad367f504aadb35.crates) {
    crate.skipminimapicon = 1;
    crate thread function_8cf94a98c8d72df0();
    scripts\mp\objidpoolmanager::update_objective_onentity(level.objectives["_d"].objidnum, crate);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(level.objectives["_d"].objidnum, 100);

    if(isDefined(getobjectiveparam("spawn_wheelson_delay_time"))) {
      crate thread function_e21690c11ec9f5ec(getobjectiveparam("spawn_wheelson_delay_time"));
    }
  }

  if(isDefined(level.zone.var_3abf844425ac7c00)) {
    foreach(i, capturezone in level.zone.var_3abf844425ac7c00.capture_zones) {
      capturezone scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture", capturezone.objidnum, game["defenders"]);
      capturezone scripts\mp\gameobjects::setownerteam(game["defenders"]);
      capturezone scripts\mp\gameobjects::setvisibleteam("any");
      setomnvar("ui_wm_escort_checkpoint_objid_" + i, capturezone.objidnum);
    }
  }

  vehicle.var_6decdc73003db8d0 = 1;
  var_4d900fc7b52f5778 = getdvarint(@ "hash_79df9d9b391becf6", 1);

  if(var_4d900fc7b52f5778) {
    level namespace_555f6ee22fb8fd82::function_51311df691f23540();
    return;
  }

  level namespace_555f6ee22fb8fd82::function_d1a514fda655e409();
}

function function_8cf94a98c8d72df0() {
  level endon("game_ended");
  self endon("death");
  self waittill("anim_finished");
  wait 5;
  self.moverdoesnotkill = 1;
}

function function_839e95bec92424a7() {
  level endon("game_ended");
  self endon("death");
  level waittill("wheelson_spawn");
  temppos = self.origin;
  var_8fb02da86884df3f = 0;

  while(true) {
    wait 0.25;

    if(distancesquared(self.origin, temppos) < 16 && istrue(self.shouldjump) && !istrue(self.var_3d669fde41c54012)) {
      var_8fb02da86884df3f++;
    } else if(distancesquared(self.origin, temppos) > 16) {
      var_8fb02da86884df3f = 0;
    }

    if(var_8fb02da86884df3f >= 2) {
      self.origin += (0, 0, 10);
      var_8fb02da86884df3f = 0;
    }

    temppos = self.origin;
  }
}

function function_96d01b17312762c7(zone) {
  level.ontimelimitgraceperiod = 5;
  level.defendersrespawndelay = function_ef4d323f56385843("defendersRespawnDelay", 0);

  foreach(player in level.players) {
    player.var_974cca039ded252e = undefined;
    player function_160f522b63c32d76(0);
  }

  objective = zone.objective;

  if(isDefined(objective.params["leaderDialogAttackers"])) {
    attackersleaderdialog = objective.params["leaderDialogAttackers"];
    delaythread(2, &leaderdialog, attackersleaderdialog, game["attackers"]);
  }

  if(isDefined(objective.params["leaderDialogDefenders"])) {
    defendersleaderdialog = objective.params["leaderDialogDefenders"];
    delaythread(2, &leaderdialog, defendersleaderdialog, game["defenders"]);
  }

  scripts\mp\utility\points::function_2a66e9acc30896c(game["attackers"], #"hash_18c44b230263da2c");
}

function function_60f4fb33f7ba40cc(capturezone) {
  level endon("game_ended");
  level endon("wm_zone_captured");

  while(true) {
    wait 5;

    if(istrue(capturezone.stalemate)) {
      continue;
    }

    foreach(struct in capturezone.touchlist[game["attackers"]]) {
      if(scripts\mp\gameobjects::function_21f4c6f630b17fc4(struct.player)) {
        struct.player.owner thread scripts\mp\utility\points::doscoreevent(#"hash_395340c089630375");
        continue;
      }

      struct.player scripts\mp\utility\points::doscoreevent(#"hash_395340c089630375");
    }
  }
}

function function_7318c4542deb6762(var_3abf844425ac7c00) {
  level endon("game_ended");
  self endon("entitydeleted");
  var_abbff9933224f0a = 0;
  var_da319380d6306e21 = 1;
  stopdistancesq = 1600;
  flagdistancesq = 1600;

  foreach(capturezone in var_3abf844425ac7c00.capture_zones) {
    level.zone.var_ef87618c979077d1 = undefined;
    self.var_bd58ba3741947988 = capturezone;

    capturezone.trigger thread function_86bddcb4c5e824e9();

    var_93f25dd7906beb3c = getStruct(capturezone.trigger.target, "targetname");
    var_abbff9933224f0a++;

    if(var_abbff9933224f0a == 1) {
      function_cc40376968f08b19(var_93f25dd7906beb3c, stopdistancesq);
      scripts\mp\flags::gameflagset("wheelson_reach_hack_point");
    } else if(var_abbff9933224f0a == 2) {
      function_cc40376968f08b19(var_93f25dd7906beb3c, stopdistancesq);
      scripts\mp\flags::gameflagset("wheelson_reach_hack_point_final");
      level.defendersrespawndelay = getdvarint(@ "hash_589f1cea04614fd5", 0);
    } else {
      function_cc40376968f08b19(var_93f25dd7906beb3c, stopdistancesq);
    }

    level.zone.currentphase = "wheelson_capture";
    level.zone.var_ef87618c979077d1 = capturezone;
    function_a2ef0341d328f8e1(capturezone.objectivekey);
    level.zonecapturetime = level.wheelsonCaptureTime;
    capturezone scripts\mp\gameobjects::setusetime(level.zonecapturetime);
    capturezone scripts\mp\gameobjects::enableobject();
    capturezone scripts\mp\gameobjects::allowuse("enemy");
    capturezone thread scripts\mp\gametypes\obj_zonecapture::updatechevrons(game["defenders"]);
    level thread function_60f4fb33f7ba40cc(capturezone);
    objective_state(capturezone.objidnum, "current");
    objective_state(level.zone.var_4473aa927a80a0ee.objidnum, "done");
    self setscriptablepartstate("wm_hack", "hacking_on_" + var_da319380d6306e21);
    capturezone.var_b2dfb3f0778c829a = &"MP/HACKING_EXPLOSIVE";
    capturezone.pointidx = var_abbff9933224f0a;
    self.var_65ab8f532ca7195 = 1;
    self playsoundtoteam("jup_wm_hack_init_ally", self.team);
    self playsoundtoteam("jup_wm_hack_init_enemy", scripts\mp\utility\game::getotherteam(self.team)[0]);
    level.objectivescaler = 1;
    level waittill("wm_zone_captured");
    function_8bce9c7e1a380040(capturezone.objectivekey);

    if(var_abbff9933224f0a == 1) {
      scripts\mp\hud_message::notifyteam("jup_wm_data_server_hacked_attacker", "jup_wm_data_server_hacked_defender", self.team);
    }

    level.objectivescaler = undefined;
    level.zone.currentphase = "wheelson_escort";
    function_a2ef0341d328f8e1(level.zone.objective.spawndata.objectivekey);

    if(var_abbff9933224f0a < var_3abf844425ac7c00.capture_zones.size) {
      objective_state(level.zone.var_4473aa927a80a0ee.objidnum, "current");
    }

    level.zone.var_4473aa927a80a0ee scripts\mp\gameobjects::setvisibleteam("any");
    self setscriptablepartstate("wm_hack", "hacking_off");
    var_da319380d6306e21 += 1;
    self notify("point_" + var_abbff9933224f0a + "_hacked");
    level notify("point_" + var_abbff9933224f0a + "_hacked");
    self.var_65ab8f532ca7195 = 0;
    scripts\mp\flags::gameflagset("point_" + var_abbff9933224f0a + "_hacked");

    if(!istrue(level.mapname == "mp_jup_skydiving")) {
      self playsoundtoteam("jup_wm_hack_complete_ally", self.team);
      self playsoundtoteam("jup_wm_hack_complete_enemy", scripts\mp\utility\game::getotherteam(self.team)[0]);
    }

    scripts\mp\utility\points::function_2a66e9acc30896c(game["attackers"], #"hash_a648a48b3a761036");
  }

  self.var_43af500ed85b7ace = 1;
}

function function_cc40376968f08b19(trigger, distsquared) {
  while(true) {
    if(distancesquared(self.origin, trigger.origin) <= distsquared) {
      break;
    }

    waitframe();
  }
}

function function_de7525871e8ec1a(team, progress, change, capplayer) {
  scripts\mp\gametypes\obj_zonecapture::zone_onuseupdate(team, progress, change, capplayer);

  if(!isDefined(level.escortvehicles) || level.escortvehicles.size < 1) {
    return;
  }

  if(progress >= 0 && level.var_56adfa324022c19b == "state_1") {
    level notify("wheelson_capture_state_1");
    level.var_56adfa324022c19b = "state_2";
  }

  if(progress >= 0.2 && level.var_56adfa324022c19b == "state_2") {
    level notify("wheelson_capture_state_2");
    level.var_56adfa324022c19b = "state_3";
  }

  if(progress >= 0.3 && !istrue(self.firstnotified)) {
    level.escortvehicles[0] notify("point_" + self.pointidx + "_30_percent");
    self.firstnotified = 1;
  }

  if(progress >= 0.4 && level.var_56adfa324022c19b == "state_3") {
    level notify("wheelson_capture_state_3");
    level.var_56adfa324022c19b = "state_4";
  }

  if(progress >= 0.8 && !istrue(self.secondnotified)) {
    level.escortvehicles[0] notify("point_" + self.pointidx + "_80_percent");
    self.secondnotified = 1;
  }

  if(progress >= 0.6 && level.var_56adfa324022c19b == "state_4") {
    level notify("wheelson_capture_state_4");
    level.var_56adfa324022c19b = "state_5";
  }

  if(progress >= 0.8 && level.var_56adfa324022c19b == "state_5") {
    level notify("wheelson_capture_state_5");
    level.var_56adfa324022c19b = "state_6";
  }

  if(progress >= 0.8 && level.var_56adfa324022c19b == "state_6") {
    level notify("wheelson_capture_state_6");
  }
}

function function_b63c307e88f55d86(vehicle, objidnum) {
  level endon("game_ended");
  assert(vehicle.pathnodes.size > 0);
  endnode = vehicle.pathnodes[vehicle.pathnodes.size - 1];
  totaldistance = endnode.var_1d7ebd1bcc23a4e1;
  vehicle.var_56df20c41f5b3159 = 1 / totaldistance;

  level thread function_d36257ceb2380e24(vehicle, vehicle.pathnodes);

  if(isDefined(vehicle.spawndata.spawnmethod) && vehicle.spawndata.spawnmethod == "airdrop_at_position_unsafe") {
    vehicle waittill("landed");
  }

  scripts\mp\objidpoolmanager::objective_set_show_progress(objidnum, 0);
  scripts\mp\objidpoolmanager::objective_set_progress_team(objidnum, game["defenders"]);
  var_b8d9c602e284684e = 900;

  while(vehicle.progress != 1) {
    waitframe();

    if(!vehicle.usep2p) {
      if(!isDefined(vehicle.var_6bb0ab1fe092bd5d)) {
        vehicle.var_6bb0ab1fe092bd5d = 1;
      }

      var_b2f8f3051e3018b1 = distance2dsquared(vehicle.pathnodes[vehicle.var_6bb0ab1fe092bd5d].origin, vehicle.origin);

      if(vehicle.var_6bb0ab1fe092bd5d > 0) {
        var_1f7233a1b7010fe4 = distance2dsquared(vehicle.pathnodes[vehicle.var_6bb0ab1fe092bd5d - 1].origin, vehicle.origin);
      } else {
        var_1f7233a1b7010fe4 = 0;
      }

      if(vehicle.var_6bb0ab1fe092bd5d + 1 < vehicle.pathnodes.size && var_b2f8f3051e3018b1 < var_b8d9c602e284684e && !istrue(vehicle.shouldreverse)) {
        vehicle.var_6bb0ab1fe092bd5d++;
      } else if(vehicle.var_6bb0ab1fe092bd5d > 0 && var_1f7233a1b7010fe4 < var_b8d9c602e284684e && istrue(vehicle.shouldreverse)) {
        vehicle.var_6bb0ab1fe092bd5d--;
      }

      print3d(vehicle.origin + (0, 0, 200), var_b2f8f3051e3018b1, (1, 0, 0));
    }

    var_92bc69459236be07 = vehicle.var_6bb0ab1fe092bd5d - 1;
    backnode = vehicle.pathnodes[var_92bc69459236be07];

    if(!isDefined(backnode)) {
      continue;
    }

    cachedistance = distance2d(vehicle.origin, backnode.origin);
    progress = (backnode.var_1d7ebd1bcc23a4e1 + cachedistance) / totaldistance;

    if(progress > 1) {
      progress = 1;
    } else if(vehicle.var_6bb0ab1fe092bd5d >= vehicle.pathnodes.size - 1) {
      var_b0162d29bef25c14 = distancesquared(vehicle.pathnodes[vehicle.pathnodes.size - 1].origin, vehicle.origin) < var_b8d9c602e284684e;

      if(var_b0162d29bef25c14) {
        progress = 1;
      }
    }

    if(istrue(vehicle.var_43af500ed85b7ace)) {
      progress = 1;
    } else if(1 == progress) {
      progress = 0.99;
    }

    vehicle.progress = progress;

    if(isDefined(vehicle.checkpoints) && isDefined(vehicle.checkpoints[vehicle.stageid])) {
      if(vehicle.progress >= vehicle.checkpoints[vehicle.stageid].progress) {
        vehicle.stageid++;
        level notify("escort_vehicle_checkpoint_" + vehicle.stageid);
      }
    }

    scripts\mp\objidpoolmanager::objective_set_progress(objidnum, progress);

    print3d(vehicle.origin + (0, 0, 72), "<dev string:x172>" + int(cachedistance) + "<dev string:x80>" + backnode.var_1d7ebd1bcc23a4e1 + "<dev string:x8f>" + distance2d(vehicle.origin, vehicle.pathnodes[var_92bc69459236be07 + 1].origin));
  }

  function_d507ea0668f3666c(vehicle);
}

function function_61f03fb6556f5c7f(zone) {
  level endon("game_ended");
  level endon(zone.name + "_objective_end");
  scripts\mp\flags::gameflagwait("zone_2" + "_objective_start");
  var_430192532a7cb360 = getEntArray("wheelson_route", "targetname");

  foreach(var_b6d7979ed726df53 in var_430192532a7cb360) {
    var_b6d7979ed726df53 hide();
  }

  level waittill("wheelson_spawn", vehicle);

  foreach(var_b6d7979ed726df53 in var_430192532a7cb360) {
    var_b6d7979ed726df53 show();
    var_b6d7979ed726df53 notsolid();
  }

  while(true) {
    foreach(var_b6d7979ed726df53 in var_430192532a7cb360) {
      if(isDefined(vehicle.progress) && isDefined(var_b6d7979ed726df53.script_noteworthy) && vehicle.progress > 0 && float(var_b6d7979ed726df53.script_noteworthy) < vehicle.progress) {
        var_b6d7979ed726df53 hide();
        continue;
      }

      if(isDefined(vehicle.progress) && isDefined(var_b6d7979ed726df53.script_noteworthy) && vehicle.progress > 0 && float(var_b6d7979ed726df53.script_noteworthy) > vehicle.progress) {
        var_b6d7979ed726df53 show();
      }
    }

    waitframe();
  }
}

function function_a1f09cc4dd4b4d47() {
  leveldata = scripts\cp_mp\killstreaks\airdrop::getleveldata("wheelson_drop");
  leveldata.capturestring = &"MP/BR_CRATE_LOADOUT";
  leveldata.basemodel = "military_carepackage_03_wheelson_fxanim";
  leveldata.supportsownercapture = 0;
  leveldata.headicon = undefined;
  leveldata.minimapicon = undefined;
  leveldata.usepriority = -1;
  leveldata.usefov = 360;
  leveldata.timeout = 1000;
  leveldata.friendlyuseonly = 1;
  leveldata.maxusage = 1;
  leveldata.ownerusetime = 0.5;
  leveldata.otherusetime = 0.5;
  leveldata.activatecallback = &function_e7ed2e5d8bd37b25;
  leveldata.capturecallback = &function_97bf2e4752f68b38;
  leveldata.destroyoncapture = 1;
  leveldata.onecaptureperplayer = 1;
  leveldata.isteamonlycrate = 1;
  leveldata.supportsreroll = 0;
  leveldata.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
}

function function_e7ed2e5d8bd37b25(isfirstactivation) {
  if(istrue(isfirstactivation)) {
    if(issharedfuncdefined("airdrop", "registerCrateForCleanup")) {
      [[getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
    }
  }
}

function function_97bf2e4752f68b38(player) {
  spawndata = level.zone.objective.spawndata;
  vehicle = level.escortvehicles[0];

  if(istrue(vehicle.var_29a4616e42091783)) {
    return;
  }

  vehicle.var_29a4616e42091783 = 1;
  vehobjzoffset = level.zone.objective.params["vehicleRef.vehObjZOffset"];
  objective = level.zone.objective;

  if(isDefined(level.zone.var_3abf844425ac7c00)) {
    vehicle thread function_7318c4542deb6762(level.zone.var_3abf844425ac7c00);
  }

  vehicle.origin = spawndata.var_558e3ab4e0b5ddbc;
  vehicle solid();
  vehicle show();
  vehicle.var_6decdc73003db8d0 = 1;
  wait 1;
  vehicle.var_6decdc73003db8d0 = 0;
  scripts\mp\objidpoolmanager::update_objective_onentity(level.objectives["_d"].objidnum, vehicle);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(level.objectives["_d"].objidnum, default_to(vehobjzoffset, 180));
  level notify("wheelson_spawn", vehicle);
}

function airdrop_wheelson(var_1604f1383b5b8325, destination) {
  level endon("game_ended");
  level endon(level.zone.name + "_objective_end");
  level.cratedropdata.heliheight = destination[2];
  var_1ad367f504aadb35 = scripts\cp_mp\killstreaks\airdrop::dropcratefromscriptedheli(undefined, game["attackers"], "wheelson_drop", var_1604f1383b5b8325.origin, var_1604f1383b5b8325.angles, destination, scripts\cp_mp\killstreaks\airdrop::getleveldata("wheelson_drop"));
  return var_1ad367f504aadb35;
}

function function_e21690c11ec9f5ec(time) {
  level endon("game_ended");
  msg = level waittill_any_timeout_1(time, "wheelson_spawn");

  if(isDefined(msg) && msg == "wheelson_spawn") {
    return;
  }

  level thread function_97bf2e4752f68b38();

  if(isDefined(self)) {
    scripts\cp_mp\killstreaks\airdrop::destroycrate(0);
  }
}

function function_64bb0e20a20f59b7(players, tankorigin, nearbyrange) {
  nearbyplayers = sortbydistancecullbyradius(players, tankorigin, nearbyrange);

  if(isDefined(level.var_7b3187b12cba9559)) {
    foreach(player in players) {
      if(player istouching(level.var_7b3187b12cba9559)) {
        nearbyplayers = arrayremove(nearbyplayers, player);
      }
    }
  }

  return nearbyplayers;
}

function function_60cc645082562276(zone) {
  objective = zone.objective;

  if(!isarray(objective.objectivekey)) {
    objective.objectivekey = [objective.objectivekey];
  }

  objectiveid = objective.objectiveid;
  objectivekeys = objective.objectivekey;
  targetname = objective.targetname;
  function_37487e9ef3996964(objective);
  nodes = getvehiclenodearray(targetname, "targetname");

  foreach(i, node in nodes) {
    objectivekey = objectivekeys[i];

    if(!isDefined(objectivekey)) {
      continue;
    }

    spawndata = spawnStruct();
    spawndata.cantimeout = 0;
    spawndata.spawnmethod = "place_at_position_unsafe";
    spawndata.origin = node.origin;
    spawndata.angles = node.angles;
    spawndata.team = game["attackers"];
    spawndata.node = node;
    spawndata.objectivekey = objectivekey;

    if(isDefined(node.script_noteworthy)) {
      if(node.script_noteworthy == "bridge_ahead") {
        spawndata.var_949ddd9ee6a3aaf5 = 1;
      } else if(node.script_noteworthy == "tank_trap_ahead") {
        spawndata.var_7a1abd6499827f97 = 1;
      }
    }

    vehicleref = "light_tank";

    if(isDefined(objective.params["vehicleRef"])) {
      vehicleref = objective.params["vehicleRef"];
    }

    vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(vehicleref, spawndata);
    level.escortvehicles[level.escortvehicles.size] = vehicle;
    marker = spawndata function_bbcd7058816ef794(objectivekey, &"MP_INGAME_ONLY/OBJ_HALT_CAPS", &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_dom" + objectivekey, game["attackers"]);
    level.objectives[objectivekey] = marker;
    level.objectives[objectivekey].objectivetype = objective.objectivetype;
  }
}

function function_a8542f181657fc32(zone) {
  function_21ee5fc831ef88cc(zone);
  objective = zone.objective;

  foreach(vehicle in level.escortvehicles) {
    level thread function_4a6cef3b190c8082(level.zone.objective, vehicle, vehicle.spawndata.objectivekey, vehicle.spawndata, vehicle.spawndata.node, level.objectives[vehicle.spawndata.objectivekey]);
  }
}

function function_d3768b4626b853b9(zone) {
  foreach(player in level.players) {
    player.var_974cca039ded252e = undefined;
    player function_160f522b63c32d76(0);
  }

  objective = zone.objective;

  if(isDefined(objective.params["leaderDialogAttackers"])) {
    attackersleaderdialog = objective.params["leaderDialogAttackers"];
    delaythread(2, &leaderdialog, attackersleaderdialog, game["attackers"]);
  }

  if(isDefined(objective.params["leaderDialogDefenders"])) {
    defendersleaderdialog = objective.params["leaderDialogDefenders"];
    delaythread(2, &leaderdialog, defendersleaderdialog, game["defenders"]);
  }

  scripts\mp\utility\points::function_2a66e9acc30896c(game["attackers"], #"hash_18c44b230263da2c");
}

function function_81e0bb0e29ca78c5(label) {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture" + label, 0, "enemy", &"MP_INGAME_ONLY/OBJ_HALT_CAPS", "icon_waypoint_dom" + label, 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend" + label, 0, "friendly", &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_dom" + label, 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_vehicle", 0, "friendly", &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_escort_tank", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_vehicle_blocked", 0, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_tank_blocked", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_vehicle_repair", 0, "friendly", &"MP_INGAME_ONLY/OBJ_TANK_REPAIRING", "icon_waypoint_tank_repair", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_vehicle_damaged", 0, "friendly", &"MP_INGAME_ONLY/OBJ_TANK_DAMAGED", "icon_waypoint_tank_damaged", 0);
}

function function_436f588312714b4a(zone) {
  objective = zone.objective;
  objectiveid = objective.objectiveid;
  objectivekeys = objective.objectivekey;
  function_37487e9ef3996964(objective);
  zone.bombzones = [];
  triggers = getEntArray(objective.params["bombObjective"]["targetname"], "targetname");

  foreach(i, trigger in triggers) {
    objectivekey = objectivekeys[i];
    trigger.objectivekey = objectivekeys[i];
    bombzone = namespace_2405c528d738b81a::setupobjective(trigger);
    bombzone scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_PLANT_EXPLOSIVES_2");
    bombzone scripts\mp\gameobjects::setusetime(function_ef4d323f56385843("plantTime", 3));
    bombzone.onbeginuse = &bombzone_onbeginuse;
    bombzone.onenduse = &bombzone_onenduse;
    bombzone.var_29496385a7b64f4c = &onbombplanted;
    bombzone.var_229b5586c139bcbf = &onbombdefused;
    bombzone.var_80eb66118fa863c1 = &function_fa563dd5b7992edf;
    bombzone scripts\mp\gameobjects::setvisibleteam("none");
    bombzone scripts\mp\gameobjects::allowuse("none");
    bombzone.useweapon = makeweapon("briefcase_bomb_mp");
    bombzone.contesttotalseconds = function_ef4d323f56385843("bombTimer", 15);
    bombzone.var_5d8933c950c9a154 = "planting";
    bombzone.model = getEnt(trigger.target, "targetname");
    level.objectives[objectivekey] = bombzone;
    level.objectives[objectivekey].objectivetype = objective.objectivetype;
    zone.bombzones[zone.bombzones.size] = bombzone;
    bombzone.zone = zone;
    var_c3a61499b29466e7 = getEntArray(bombzone.model.target, "targetname");

    foreach(ent in var_c3a61499b29466e7) {
      if(ent.script_noteworthy == "exploderPlatform_clip") {
        bombzone.clip = ent;
      }
    }
  }

  foreach(bombzone in zone.bombzones) {
    var_a39e4ed2521b0de4 = strtok(bombzone.model.script_noteworthy, "_");
    bombzone.sequence = int(var_a39e4ed2521b0de4[var_a39e4ed2521b0de4.size - 2]);
    bombzone.index = int(var_a39e4ed2521b0de4[var_a39e4ed2521b0de4.size - 1]);
  }
}

function function_fa563dd5b7992edf() {
  foreach(bombzone in self.zone.bombzones) {
    if(!istrue(bombzone.complete) && bombzone.sequence == self.sequence && bombzone.index == self.index + 1) {
      bombzone scripts\mp\gameobjects::setobjectivestatusicons("waypoint_bomb_defend", "waypoint_bomb_plant");
      bombzone scripts\mp\gameobjects::setvisibleteam("any");
      bombzone scripts\mp\gameobjects::allowuse("enemy");
      bombzone scripts\mp\gameobjects::function_c882c384f0e771a1(1);
    }
  }

  self.model delete();
  self.clip delete();
  level notify(self.trigger.script_label);
  function_8bce9c7e1a380040(self.objectivekey);
}

function function_3e3c26832b57e926(zone) {
  foreach(bombzone in zone.bombzones) {
    if(bombzone.index == 1) {
      bombzone scripts\mp\gameobjects::setobjectivestatusicons("waypoint_bomb_defend", "waypoint_bomb_plant");
      bombzone scripts\mp\gameobjects::setvisibleteam("any");
      bombzone scripts\mp\gameobjects::allowuse("enemy");
      bombzone scripts\mp\gameobjects::function_c882c384f0e771a1(1);
    }
  }
}

function function_e42b4521f694e3f9(zone) {
  objective = zone.objective;

  foreach(objstr in zone.objectives) {
    zone = level.objectives[objstr];
    zone scripts\mp\gameobjects::setvisibleteam("none");
    zone scripts\mp\gameobjects::allowuse("none");
  }

  scripts\mp\utility\points::function_2a66e9acc30896c(game["attackers"], #"hash_57e238c776c8e030");
}

function function_f4284f31e0cf6cc1(label) {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend" + label, 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hack");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_hack" + label, 0, "enemy", &"MP_INGAME_ONLY/OBJ_ACTIVATE_CAPS", "icon_waypoint_hack");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_hacking" + label, 0, "enemy", &"MP_INGAME_ONLY/OBJ_STOP_CAPS", "icon_waypoint_hacking");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defuse" + label, 0, "friendly", &"MP_INGAME_ONLY/OBJ_ACTIVATING_CAPS", "icon_waypoint_hacking");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bomb_defuse" + label, 0, "enemy", &"MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_bomb_defuse");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bomb_plant" + label, 0, "enemy", &"MP_INGAME_ONLY/OBJ_PLANT_CAPS", "icon_waypoint_bomb");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bomb_defend" + label, 0, "enemy", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_bomb");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bomb_lock" + label, 0, "enemy", &"MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_locked");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bomb_lock" + label, 0, "friendly", &"MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_locked");
}

function function_4453e34ea22074df() {
  while(true) {
    if(isDefined(self.var_c0d309289159602a)) {
      string = "<dev string:x17d>" + distance2d(self.origin, self.var_c0d309289159602a);
      print3d(self.origin + (0, 0, 50), string, (1, 1, 0), 1, 0.5);
    }

    waitframe();
  }
}

# /