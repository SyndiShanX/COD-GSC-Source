/******************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_launchfacility\mp_jup_launchfacility.gsc
******************************************************************************/

#using script_3653c2969325f543;
#using script_62384cde1a08c286;
#using script_7af62d724b479189;
#using script_7d99d004b59cb01b;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\create_script_utility;
#using scripts\common\utility;
#using scripts\common\vehicle_paths;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\killstreaks\toma_strike;
#using scripts\cp_mp\samsite;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_load_all;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\anim;
#using scripts\mp\compass;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\wm;
#using scripts\mp\gametypes\wm_buildable;
#using scripts\mp\gametypes\wm_ending;
#using scripts\mp\gametypes\wm_objectives;
#using scripts\mp\gametypes\wm_ui;
#using scripts\mp\gametypes\wm_utility;
#using scripts\mp\hud_message;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_launchfacility\gen\mp_jup_launchfacility_art;
#using scripts\mp\maps\mp_jup_launchfacility\mp_jup_launchfacility_create_script;
#using scripts\mp\maps\mp_jup_launchfacility\mp_jup_launchfacility_fx;
#using scripts\mp\maps\mp_jup_launchfacility\mp_jup_launchfacility_lighting;
#using scripts\mp\maps\mp_jup_launchfacility\mp_jup_launchfacility_zone1_create_script;
#using scripts\mp\maps\mp_jup_launchfacility\mp_jup_launchfacility_zone2_create_script;
#using scripts\mp\maps\mp_jup_launchfacility\mp_jup_launchfacility_zone3_create_script;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#using scripts\quaked\script_struct_mp_jup_cougar_mg;
#namespace mp_jup_launchfacility;

function main() {
  scripts\mp\maps\mp_jup_launchfacility\gen\mp_jup_launchfacility_art::main();
  scripts\mp\maps\mp_jup_launchfacility\mp_jup_launchfacility_fx::main();
  scripts\mp\maps\mp_jup_launchfacility\mp_jup_launchfacility_lighting::main();
  namespace_d7d87c46812c4227::main();
  scripts\mp\load::main();
  scripts\common\create_script_utility::initialize_create_script();
  level thread scripts\mp\maps\mp_jup_launchfacility\mp_jup_launchfacility_create_script::main();
  level thread scripts\mp\maps\mp_jup_launchfacility\mp_jup_launchfacility_zone1_create_script::main();
  level thread scripts\mp\maps\mp_jup_launchfacility\mp_jup_launchfacility_zone2_create_script::main();
  level thread scripts\mp\maps\mp_jup_launchfacility\mp_jup_launchfacility_zone3_create_script::main();
  scripts\cp_mp\vehicles\vehicle_load_all::function_b82404e40cca2415();
  scripts\quaked\script_struct_mp_jup_cougar_mg::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_jup_launchfacility");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";

  if(scripts\cp_mp\utility\game_utility::function_d04af493b6e718ac()) {
    level.requiredplayercountoveride = 1;
    level.requiredplayercount["allies"] = 6;
    level.requiredplayercount["axis"] = 6;
    setDvar(@ "hash_a2e7d8fdf5d91dd9", 1);
    scripts\mp\gametypes\wm_objectives::function_333f4c66e6305891(1, ["_a", "_b"], "zone_1", ["jup_launchfacility_wb_capture_zone_a", "jup_launchfacility_wb_capture_zone_b"], function_d4b2873d01de6c04(1));
    scripts\mp\gametypes\wm_objectives::function_333f4c66e6305891(6, "_c", "zone_2", "wm_escort_tank_path", function_d4b2873d01de6c04(6));
    scripts\mp\gametypes\wm_objectives::function_333f4c66e6305891(9, ["_d", "_e"], "zone_3", "hack_point", function_d4b2873d01de6c04(9));

    var_1d1f34191a0036c4 = getdvarint(@ "hash_84dcf3cb7db8cb68", 0);

    if(var_1d1f34191a0036c4) {
      scripts\mp\gametypes\wm_objectives::function_a6cc7589a41d621e(6, "<dev string:x1c>", "<dev string:x22>", "<dev string:x2c>", function_d4b2873d01de6c04(6), 1);
    }

    scripts\mp\gametypes\wm_ending::function_1c915051680a9364(&function_d69acc92a86dd80b, &function_d5f16f7e888c59d3);
    level thread initai();
    level thread function_bdccfc7ecc6306c1();
    level.var_f24db6a5246641cb = &function_f24db6a5246641cb;
    level.var_77a7be006731f124 = "scripted_widget_objective_tracker_jup_wm_launch_facility";
    game["dialog"]["wm_oob_atk_launchfacility"] = "dx_mp_mwm1_mode_t141_oobk";
    game["dialog"]["wm_oob_def_launchfacility"] = "dx_mp_mwm1_mode_spet_oobd";
    level.var_c99eed54a2e150c7 = "wm_oob_atk_launchfacility";
    level.var_e7cbc43f8f9aa5d3 = "wm_oob_def_launchfacility";
    level.custom_ending = 1;
  }
}

function function_bdccfc7ecc6306c1() {
  flag_wait("onStartGameTypeFinished");
  level thread namespace_35c98dfcc5046aa3::init();
  level thread function_82913d07328e5537();
  level thread function_8ac0af786a238752();
  level thread function_bd4520ab6628ed1e();
  level.var_4a5cade1a0c8264 = &function_d48d53fecaf25074;
  level.var_eab5ff58683de92a = &function_3c8a7af329c87d2d;
  level.var_4538f9d8dc0b9007 = &function_4538f9d8dc0b9007;
  setDvar(@ "hash_3058503b6794e09b", 1);
  level thread function_27b5aad89735bcf9();
  level thread function_e2344ec3f70a089c();
  level thread function_a9229844e65e7b50();
  level thread function_4c3317636403651();
}

function function_f24db6a5246641cb() {
  scripts\mp\gametypes\wm_objectives::function_eb9bcbf70f099dea(1, &function_fdc304e86fdedba);
  scripts\mp\gametypes\wm_objectives::function_eb9bcbf70f099dea(6, &function_1c74e9d49ba96bc8);
  game["dialog"]["obj_atk_times_up_sixty"] = "dx_mp_mwm1_mode_t141_cssa";
  game["dialog"]["obj_def_times_up_sixty"] = "dx_mp_mwm1_mode_spet_cssd";
  game["dialog"]["obj_atk_times_up_thirty"] = "dx_mp_mwm1_mode_t141_csta";
  game["dialog"]["obj_def_times_up_thirty"] = "dx_mp_mwm1_mode_spet_cstd";
  game["dialog"]["obj_atk_times_up_ten"] = "dx_mp_mwm1_mode_t141_cstk";
  game["dialog"]["obj_def_times_up_ten"] = "dx_mp_mwm1_mode_spet_cstf";
  scripts\mp\gametypes\wm::function_ca18dc1a088a7245(60, "obj_atk_times_up_sixty", "obj_def_times_up_sixty");
  scripts\mp\gametypes\wm::function_ca18dc1a088a7245(30, "obj_atk_times_up_thirty", "obj_def_times_up_thirty");
  scripts\mp\gametypes\wm::function_ca18dc1a088a7245(10, "obj_atk_times_up_ten", "obj_def_times_up_ten");
  scripts\mp\gametypes\wm_objectives::function_e4285658260d1bfa(1, &function_4e41bf0f45af388d);
  scripts\mp\gametypes\wm_objectives::function_86e5700d7971e414(1, "obj1_atk_lost_launchfacility");
  scripts\mp\gametypes\wm_objectives::function_5580ef2fc74eb79c(1, "obj1_def_win_launchfacility");
  scripts\mp\gametypes\wm_objectives::function_8ee1bbc9a60b0b00(6, "obj2_atk_start_launchfacility", "obj2_def_start_launchfacility");
  scripts\mp\gametypes\wm_objectives::function_e4285658260d1bfa(6, &function_41fe0ce4b07a5ce7);
  scripts\mp\gametypes\wm_objectives::function_86e5700d7971e414(6, "obj2_atk_lost_launchfacility");
  scripts\mp\gametypes\wm_objectives::function_5580ef2fc74eb79c(6, "obj2_def_win_launchfacility");
}

function function_fdc304e86fdedba(label) {
  var_e374e16372dd03ec = "";

  if(label == "_a") {
    var_e374e16372dd03ec = &"MP_JUP_LAUNCHFACILITY/OBJ_RADAR_CAPS";
  } else if(label == "_b") {
    var_e374e16372dd03ec = &"MP_JUP_LAUNCHFACILITY/OBJ_SAM_SITE_CAPS";
  }

  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend" + label, 0, "friendly", var_e374e16372dd03ec, "icon_waypoint_hq_enemy");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture" + label, 0, "enemy", var_e374e16372dd03ec, "icon_waypoint_hq_enemy");
}

function function_1c74e9d49ba96bc8(label) {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_capture" + label, 0, "enemy", &"MP_INGAME_ONLY/OBJ_HALT_CAPS", "icon_waypoint_escort_tank", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend" + label, 0, "friendly", &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_escort_tank", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_vehicle", 0, "friendly", &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_escort_tank", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_vehicle_blocked", 0, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_tank_blocked", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_vehicle_repair", 0, "friendly", &"MP_INGAME_ONLY/OBJ_TANK_REPAIRING", "icon_waypoint_tank_repair", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_vehicle_damaged", 0, "friendly", &"MP_INGAME_ONLY/OBJ_TANK_DAMAGED", "icon_waypoint_tank_damaged", 0);
  level.var_3e6380e9591e50a5 = 1;
}

function initai() {
  scripts\mp\ai_mp_controller::init();
  scripts\mp\ai_mp_controller::function_c8393014dd7f8ab6();
  scripts\mp\ai_mp_controller::function_ba4022744dce59f6("show");
}

function function_d4b2873d01de6c04(index) {
  if(!isDefined(level.var_ebec9ab53ddcfaa2)) {
    extratimegap = getdvarint(@ "hash_d7e998dfd7d4869d", 0);
    params = [];
    params["extraTimeGap"] = extratimegap;
    params["flagCaptureTime"] = function_ef4d323f56385843("lfFlagCaptureTime", 40);
    params["leaderDialogAttackers"] = "obj1_atk_win_launchfacility";
    params["leaderDialogDefenders"] = "obj1_def_lost_launchfacility";
    level.var_ebec9ab53ddcfaa2[1] = params;
    params = [];
    params["timelimit"] = function_ef4d323f56385843("lfEscortTimeLimit", 360);
    params["extraTimeGap"] = extratimegap;
    params["vehicleRef"] = "veh_jup_cougar_mg";
    params["vehicleRef.vehObjZOffset"] = 170;
    params["vehicleSpeed"] = function_ef4d323f56385843("tankSpeed", 4);
    params["canDamageAndRepair"] = istrue(function_29227adb79acc568("tankRepair", 0));
    params["canStopByDefenders"] = istrue(function_29227adb79acc568("tankContestable", 1));
    params["progressByActualDistance"] = 1;
    params["tankNearbyRange"] = getdvarint(@ "hash_a05ad819aecbb000", 300);
    params["leaderDialogAttackers"] = "obj2_atk_win_launchfacility";
    params["leaderDialogDefenders"] = "obj2_def_lost_launchfacility";
    params["useP2P"] = getdvarint(@ "hash_53cf3fb27a4e4e35", 0) != 0;
    params["transitionSplash"] = ["jup_wm_transition_launchfacility_zone", "jup_wm_transition_launchfacility_zone_defend"];
    params["retreatTimeLimit"] = getdvarint(@ "hash_6aa8e557b74d0eb7", 24);
    level.var_ebec9ab53ddcfaa2[6] = params;
    params = [];
    params["hackUploadTime"] = function_ef4d323f56385843("hackUploadTime", 30);
    params["leaderDialogAttackers"] = "obj3_atk_win_launchfacility";
    params["leaderDialogDefenders"] = "obj3_def_lost_launchfacility";
    params["transitionSplash"] = ["jup_wm_transition_launchfacility_escort", "jup_wm_transition_launchfacility_escort_defend"];
    params["usingVisualHintString"] = &"MP_JUP_LAUNCHFACILITY/CONSOLE_LAUNCH";
    params["hack_zone_upload_complete_splash_friendly"] = "jup_wm_progress_hack";
    params["hack_zone_upload_complete_splash_enemy"] = "jup_wm_progress_hack_enemy";
    level.var_ebec9ab53ddcfaa2[9] = params;
  }

  return level.var_ebec9ab53ddcfaa2[index];
}

function function_d69acc92a86dd80b() {
  animstruct = getStruct("wm_launch_ending_cam_attackers", "targetname");
  animstruct.cam = animstruct scripts\mp\gametypes\wm_ending::create_cam();
  animstruct.cam.origin = animstruct.origin;
  animstruct.cam.angles = animstruct.angles;
  var_33b04d79a7b0daf7 = "body_c_jup_mp_charlie";
  var_1d5919b9c70cc84c = "head_c_jup_mp_charlie";
  var_c7de4b0b784161e = "vm_c_jup_mp_delta";
  var_1321643ea8606571 = "jup_military_launchfacility_missile_01_fxanim";
  actorplayer = spawnactor("attacker_outro_player", var_c7de4b0b784161e, "outro_player");
  var_dcff25cc8b29d54 = spawnactor("attacker_outro_body", var_33b04d79a7b0daf7, "outro_body");
  var_f409839cf9fc354a = spawnactor("attacker_outro_missile", var_1321643ea8606571, "outro_missile");
  var_dec8b2d641fcc6d6 = getEnt("attacker_outro_button", "targetname");
  var_dcff25cc8b29d54 setmoveravatar(var_33b04d79a7b0daf7, var_1d5919b9c70cc84c);
  actors = [var_dcff25cc8b29d54, actorplayer];
  var_981c48f09e087aa4 = "attacker_outro_shot01";
  var_981c4bf09e08813d = "attacker_outro_shot02";
  var_334a921a8678947b = getStruct("attacker_outro_player", "targetname");
  var_334a931a867896ae = getStruct("attacker_outro_missile", "targetname");

  foreach(player in level.players) {
    thread scripts\cp_mp\utility\game_utility::fadetoblackforplayerkeepui(player, 1);
  }

  omnvar = "ui_wm_launch_console_countdown_1";

  foreach(hackzone in level.zones["zone_3"].hackzones) {
    setomnvar(omnvar, 0);
    hackzone.redscreen dontinterpolate();
    hackzone.redscreen moveTo(hackzone.screen.origin, 0.1);
    hackzone.screen setscriptablepartstate("consoleScreen", "hacked");
  }

  var_dec8b2d641fcc6d6.cam = actorplayer scripts\mp\gametypes\wm_ending::create_cam();
  function_df6579cb4cbfbcfd(var_dec8b2d641fcc6d6);
  wait 1;

  foreach(player in level.players) {
    thread scripts\cp_mp\utility\game_utility::fadetoblackforplayerkeepui(player, 0, 0.5);
  }

  if(isDefined(var_dec8b2d641fcc6d6)) {
    var_dec8b2d641fcc6d6.animname = "outro_button";
    var_dec8b2d641fcc6d6 scripts\common\anim::setanimtree();
    var_dec8b2d641fcc6d6 thread scripts\common\anim::anim_single_solo(var_dec8b2d641fcc6d6, var_981c48f09e087aa4);
  }

  level thread function_f6a779553c406a5e();
  var_334a921a8678947b scripts\common\anim::anim_single(actors, var_981c48f09e087aa4);
  function_df6579cb4cbfbcfd(animstruct);

  foreach(player in level.players) {
    thread scripts\cp_mp\utility\game_utility::fadetoblackforplayerkeepui(player, 0, 0.5);
  }

  var_334a931a867896ae scripts\common\anim::anim_single_solo(var_f409839cf9fc354a, var_981c4bf09e08813d);
  return animstruct.cam;
}

function function_d5f16f7e888c59d3() {
  animstruct = getStruct("wm_launch_ending_cam_defenders", "targetname");
  animstruct.cam = animstruct scripts\mp\gametypes\wm_ending::create_cam();
  animstruct.cam.origin = animstruct.origin;
  animstruct.cam.angles = animstruct.angles;
  var_c13b054489d8a913 = getxcamlength(level.scr_xcam["defender_outro"]);
  var_3cabbb06994374e3 = "veh9_mil_lnd_tank_cougar_fxanim";
  var_a080aea7da89a8e = "veh9_mil_lnd_tank_cougar_02_dst_fxanim";
  var_e59087cfb84c6eae = "jup_military_launchfacility_missile_01_fxanim";
  var_1321643ea8606571 = "weapon_wm_la_juliet_missile";
  var_f74e5629cbede10f = "c_jup_mp_delta_fb";
  tank = spawnactor("defender_outro_tank", var_3cabbb06994374e3, "tank_cougar");
  var_9cc46de2a314708c = spawnactor("defender_outro_tank_dst", var_a080aea7da89a8e, "tank_cougar_dst");
  missile = spawnactor("defender_outro_missile", var_1321643ea8606571, "missile");
  var_5134837896e2585f = spawnactor("defender_outro_missile_01", var_e59087cfb84c6eae, "icbm_launch_01");
  var_5134847896e25a92 = spawnactor("defender_outro_missile_02", var_e59087cfb84c6eae, "icbm_launch_02");
  soldier01 = spawnactor("defender_outro_soldier_01", var_f74e5629cbede10f, "soldier_01");
  soldier02 = spawnactor("defender_outro_soldier_02", var_f74e5629cbede10f, "soldier_02");
  soldier03 = spawnactor("defender_outro_soldier_03", var_f74e5629cbede10f, "soldier_03");
  actors = [tank, var_9cc46de2a314708c, missile, var_5134837896e2585f, var_5134847896e25a92, soldier01, soldier02, soldier03];
  scene = "defender_outro";
  animnode = getStruct("defender_outro_tank", "targetname");

  foreach(player in level.players) {
    thread scripts\cp_mp\utility\game_utility::fadetoblackforplayerkeepui(player, 1);
  }

  function_df6579cb4cbfbcfd(animstruct);

  foreach(player in level.players) {
    thread scripts\cp_mp\utility\game_utility::fadetoblackforplayerkeepui(player, 0, 0.5);
  }

  level thread function_26f23107e6cd179f();
  animnode thread scripts\common\anim::anim_single(actors, scene);
  level thread function_64c61d28f575a7a9(var_9cc46de2a314708c, tank);
  wait var_c13b054489d8a913;
  return animstruct.cam;
}

function function_64c61d28f575a7a9(var_9cc46de2a314708c, tank) {
  level endon("game_ended");
  var_9cc46de2a314708c hide();
  scripts\mp\anim::function_3c8f0102ea5254f3(169);
  var_9cc46de2a314708c show();
  tank hide();
}

function function_f6a779553c406a5e() {
  level endon("game_ended");
  wait 5.33;

  foreach(player in level.players) {
    thread scripts\cp_mp\utility\game_utility::fadetoblackforplayerkeepui(player, 1, 0.5);
  }
}

function function_df6579cb4cbfbcfd(animstruct) {
  level.brspawnplayersending = 1;
  level notify("brSpawnPlayersEnding");

  foreach(player in level.players) {
    player painvisionoff();
    player notify("ending_cinematic");
    player function_b88c89bb7cd1ab8e(animstruct.origin);
    player utility::hidehudenable();
    player setcinematicmotionoverride("disabled");
    player setclientomnvar("ui_hide_hud", 1);

    if(isDefined(player.sessionstate)) {
      if(player.sessionstate == "intermission") {
        player scripts\mp\utility\player::updatesessionstate("spectator");
      }

      if(player.sessionstate == "spectator") {
        player setspectatedefaults(animstruct.cam.origin, animstruct.cam.angles);
        player spawn(animstruct.cam.origin, animstruct.cam.angles);
        continue;
      }

      player setOrigin(animstruct.origin);
    }
  }

  foreach(player in level.players) {
    player cameraunlink();
    player playerlinkTo(animstruct.cam, "tag_player");
    player playerhide();
  }
}

function spawnactor(targetname, model, animname) {
  struct = getStruct(targetname, "targetname");

  if(!isDefined(struct)) {
    return undefined;
  }

  actor = spawn("script_model", struct.origin);
  actor setModel(model);
  actor.angles = struct.angles;
  actor.animname = animname;
  actor scripts\common\anim::setanimtree();
  return actor;
}

function function_26f23107e6cd179f() {
  level endon("game_ended");
  var_5731a50da1307842 = getStructArray("defender_outro_MG", "script_noteworthy");
  team = game["defenders"];
  targetpoint = getStruct("defender_outro_MG_fire_pos", "script_noteworthy");
  var_586ba434a3023c12 = spawn("script_model", targetpoint.origin);

  foreach(point in var_5731a50da1307842) {
    turret = spawnmgturret(point, undefined, undefined, undefined, team);
    turret.var_57abfc2b0a18dd65 = var_586ba434a3023c12;
    turret thread function_3cd75d5bf0fc9989(point, undefined, undefined, undefined, team);
  }

  wait 0.3;
  var_e2339bb4ccac4500 = getStructArray("defender_outro_extra_missile", "script_noteworthy");
  wait 0.6;

  foreach(point in var_e2339bb4ccac4500) {
    streakinfo = spawnStruct();
    missile = spawn("script_model", point.origin);
    missile thread scripts\cp_mp\killstreaks\toma_strike::function_6153b8a392d10771(point.origin, point.angles, undefined, level.players[0], 0, streakinfo);
    wait 0.6;
  }

  var_586ba434a3023c12 delete();
}

function function_e2344ec3f70a089c() {
  level endon("game_ended");

  if(!scripts\mp\gametypes\wm_buildable::function_87c403778d48f1b0()) {
    return;
  }

  level.var_96c8e55e70edd512 = &function_96c8e55e70edd512;
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_Buildable_ToBuild", 1, "neutral", undefined, "ui_icon_minimap_warmode_buildable_empty");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_Buildable_Built", 1, "neutral", undefined, "ui_icon_minimap_warmode_buildable_teardown");
  buildinfo = scripts\mp\gametypes\wm_buildable::function_91f9e0306d5d65a0("bdb_turret");
  buildinfo.buildusetime = 4;
  buildinfo.hintstring = &"MP_JUP_LAUNCHFACILITY/REPAIR";
  buildinfo.gestureweapon = "jup_war_ges_wrench_turret";
  buildinfo.var_32a2681a13f18cb1 = &namespace_555f6ee22fb8fd82::function_4009bbde647f8862;
  buildinfo.var_fc147a62066d05bd = &namespace_555f6ee22fb8fd82::function_8735b98397aaf042;
  buildinfo.var_562da06e56403b2f = &namespace_555f6ee22fb8fd82::function_723905cbc30e0b0a;
  buildinfo.var_5d8933c950c9a154 = "build_turret";
  buildinfo = scripts\mp\gametypes\wm_buildable::function_91f9e0306d5d65a0("bdb_earthen_wall");
  buildinfo.phases = [0, 0.5, 1];
  buildinfo.models = level.var_c88bedfa8ddcb42c["EarthenWall"]["models"];
  buildinfo.animations = level.var_c88bedfa8ddcb42c["EarthenWall"]["animations"];
  buildinfo.buildusetime = 3;
  buildinfo.hintstring = &"MP_JUP_LAUNCHFACILITY/BUILD";
  buildinfo.gestureweapon = "nothing_here";
  buildinfo.var_b3b899b146453c0c = &function_927b512a6d2c5d6d;
  buildinfo.var_562da06e56403b2f = &function_2e4f60aab0b9caa1;
  buildinfo = scripts\mp\gametypes\wm_buildable::function_91f9e0306d5d65a0("bdb_tankTrap");
  buildinfo.models = level.var_c88bedfa8ddcb42c["TankTrap"]["models"];
  buildinfo.animations = level.var_c88bedfa8ddcb42c["TankTrap"]["animations"];
  buildinfo.buildusetime = 4;
  buildinfo.hintstring = &"MP_JUP_LAUNCHFACILITY/BUILD";
  buildinfo.gestureweapon = "jup_war_ges_wrench_hedgehog";
  buildinfo.var_32a2681a13f18cb1 = &function_14557abb4173c907;
  buildinfo.var_fc147a62066d05bd = &function_e6e4ec899d114c59;
  buildinfo.var_562da06e56403b2f = &function_18b4ff54f4110b21;
  buildinfo = scripts\mp\gametypes\wm_buildable::function_91f9e0306d5d65a0("bdb_hesco");
  buildinfo.models = level.var_c88bedfa8ddcb42c["Hesco"]["models"];
  buildinfo.animations = level.var_c88bedfa8ddcb42c["Hesco"]["animations"];
  buildinfo.buildusetime = 4;
  buildinfo.hintstring = &"MP_JUP_LAUNCHFACILITY/BUILD";
  buildinfo.gestureweapon = "nothing_here";
  buildinfo.var_32a2681a13f18cb1 = &function_eeb5fae661444ab6;
  buildinfo.var_fc147a62066d05bd = &function_219488eeb71cf8ce;
  buildinfo.var_562da06e56403b2f = &function_f7d3423c552f1596;
  level namespace_555f6ee22fb8fd82::function_43a60391e95332e();
  level function_714ca74c07bcc71c();
  level function_259b94f62f15b4be();
  level function_503244ee309d918d();
}

function function_96c8e55e70edd512(animname) {
  if(animname == "EarthenWall" || animname == "Hesco" || animname == "TankTrap") {
    return "slow";
  }

  return undefined;
}

function function_714ca74c07bcc71c() {
  ents = getEntArray("wm_build_wall", "targetname");

  foreach(ent in ents) {
    scriptorigin = getStruct(ent.target, "targetname");
    buildable = scripts\mp\gametypes\wm_buildable::function_e20a97a059fba2ea("bdb_earthen_wall", ent, ent.script_noteworthy, 0, scriptorigin.origin, scriptorigin.angles);
    fullclip = getEnt(scriptorigin.target, "targetname");
    buildable.fullclip = fullclip;
    halfclip = getEnt(fullclip.target, "targetname");
    buildable.halfclip = halfclip;
    buildable.fullclip.moverdoesnotkill = 1;
    buildable.halfclip.moverdoesnotkill = 1;
    buildable.fullclip connectpaths();
    buildable.halfclip connectpaths();
    buildable.fullclip notsolid();
    buildable.halfclip notsolid();
    buildable.halfclip.origin -= (0, 0, 400);
    buildable.fullclip.origin -= (0, 0, 400);
    buildable.var_aad507fcd3fa7aac = buildable.halfclip.origin;
    buildable.var_1e6b32b3a669c4a4 = buildable.fullclip.origin;
    var_8c093373c4b24c9b = getStructArray(scriptorigin.target, "targetname");

    foreach(node in var_8c093373c4b24c9b) {
      if(node.script_noteworthy == "full_warp_over") {
        buildable.var_25ce1472104e7323 = node;
        continue;
      }

      buildable.var_9add75b4f63984db = node;
    }

    foreach(model in buildable.models) {
      model.outlineid = scripts\mp\utility\outline::outlineenableforall(model, "shimmer_crafting_wm_buildable", "level_script");
    }

    c4set = getscriptablearray(ent.target, "targetname");

    foreach(c4 in c4set) {
      c4 setscriptablepartstate("body", "init");
      positionvec = c4.origin - buildable.models[0].origin;
      var_a12e637c4db09413 = vectordot(positionvec, anglesToForward(buildable.models[0].angles));

      if(var_a12e637c4db09413 > 0) {
        buildable.c4forward = c4;
        continue;
      }

      buildable.c4back = c4;
    }
  }
}

function function_927b512a6d2c5d6d(player, buildable, buildphase) {
  if(buildphase == 1) {
    buildable.halfclip solid();
    buildable.halfclip movez(400, 0.2);
    buildable.halfclip disconnectPaths();
    endnode = getStruct(buildable.var_9add75b4f63984db.target, "targetname");
    createnavlink("half_wall_warp_over", buildable.var_9add75b4f63984db.origin, endnode.origin, "traverse_warp_over");
    buildable thread function_aee75e15f0b3ace2();

    if(isDefined(buildable.zonename) && buildable.zonename == level.zone.name) {
      buildable.useobj scripts\mp\gameobjects::setobjectivestatusicons("waypoint_Buildable_Built");
    }
  }
}

function function_aee75e15f0b3ace2() {
  level endon("game_ended");
  self endon("stop_half_watch");
  self.models[0] childthread scripts\mp\gametypes\wm_buildable::function_df66656601b04226();
  self.models[0] waittillmatch("scriptableNotification", "half_wall_destroyed");
  self.halfclip.origin = self.var_aad507fcd3fa7aac;
  self.halfclip connectpaths();
  self.models[0] notsolid();
  self.models[0] connectpaths();
  function_3b27c12823e5dc9();
  self.buildphase = 0;
  self.useobj notify("destroyed_by_splash");
  self.models[0] notify("destroyed");
}

function function_2e4f60aab0b9caa1(player, buildable) {
  buildable notify("stop_half_watch");
  buildable.fullclip solid();
  buildable.fullclip movez(400, 0.2);
  buildable.fullclip disconnectPaths();
  buildable.halfclip delaycall(0.2, &moveto, buildable.var_aad507fcd3fa7aac, 0.1);
  buildable.halfclip delaycall(0.2, &notsolid);
  destroynavlink("half_wall_warp_over");
  endnode = getStruct(buildable.var_25ce1472104e7323.target, "targetname");
  createnavlink("full_wall_warp_over", buildable.var_25ce1472104e7323.origin, endnode.origin, "traverse_warp_over");
  var_96d232e2a285463c = getentarrayinradius("huge_deploy_cover_close", "targetname", buildable.triggerent.origin, 100);
  var_96d232e2a285463c = var_96d232e2a285463c[0];
  buildable.c4forward setscriptablepartstate("body", "built");
  buildable.c4forward.outlineid = scripts\mp\utility\outline::outlineenableforall(buildable.c4forward, "shimmer_crafting_wm_buildable", "level_script");
  buildable.c4back setscriptablepartstate("body", "built");
  buildable.c4back.outlineid = scripts\mp\utility\outline::outlineenableforall(buildable.c4back, "shimmer_crafting_wm_buildable", "level_script");

  foreach(model in buildable.models) {
    scripts\mp\utility\outline::outlinedisable(model.outlineid, model);
  }

  destroyobj = scripts\mp\gametypes\wm_buildable::function_e2f7c2b8cdaefdd7(var_96d232e2a285463c, &"MP_JUP_LAUNCHFACILITY/REMOVEWALL", 3, undefined, &function_1e4edfddaf68a61f);
  destroyobj.buildable = buildable;
  buildable.destroyobj = destroyobj;
  buildable thread scripts\mp\gametypes\wm_buildable::function_62602b0ea1741bd2(buildable.models[1], "full_wall_destroyed");
}

function function_1e4edfddaf68a61f(player) {
  scriptorigin = getStruct(self.buildable.triggerent.target, "targetname");
  buildable = scripts\mp\gametypes\wm_buildable::function_e20a97a059fba2ea(self.buildable.name, self.buildable.triggerent, self.buildable.zonename, 0, scriptorigin.origin, scriptorigin.angles);
  fullclip = getEnt(scriptorigin.target, "targetname");
  buildable.fullclip = fullclip;
  halfclip = getEnt(fullclip.target, "targetname");
  buildable.halfclip = halfclip;
  buildable.fullclip connectpaths();
  buildable.fullclip notsolid();
  buildable.halfclip notsolid();
  buildable.var_aad507fcd3fa7aac = self.buildable.var_aad507fcd3fa7aac;
  buildable.var_1e6b32b3a669c4a4 = self.buildable.var_1e6b32b3a669c4a4;
  buildable.halfclip delaycall(0.2, &moveto, buildable.var_aad507fcd3fa7aac, 0.1);
  buildable.fullclip delaycall(0.2, &moveto, buildable.var_1e6b32b3a669c4a4, 0.1);
  destroynavlink("full_wall_warp_over");
  buildable.var_9add75b4f63984db = self.buildable.var_9add75b4f63984db;
  buildable.var_25ce1472104e7323 = self.buildable.var_25ce1472104e7323;
  buildable.c4back = self.buildable.c4back;
  buildable.c4forward = self.buildable.c4forward;

  foreach(model in buildable.models) {
    model.outlineid = scripts\mp\utility\outline::outlineenableforall(model, "shimmer_crafting_wm_buildable", "level_script");
  }
}

function function_259b94f62f15b4be() {
  ents = getEntArray("tri_build_hesco", "targetname");

  foreach(ent in ents) {
    var_febb042dd9982690 = getStruct(ent.target, "targetname");
    var_2511d56abe3f9558 = getEnt(var_febb042dd9982690.target, "targetname");
    var_c96dc31f024483a8 = getEntArray(var_2511d56abe3f9558.target, "targetname");

    if(!isDefined(var_febb042dd9982690) || !isDefined(var_c96dc31f024483a8)) {
      continue;
    }

    buildable = scripts\mp\gametypes\wm_buildable::function_e20a97a059fba2ea("bdb_hesco", ent, ent.script_noteworthy, 0, var_febb042dd9982690.origin, var_febb042dd9982690.angles);
    ent.buildable = buildable;
    ent.buildable.clips = var_c96dc31f024483a8;
    ent.buildable.var_6d5cb3b114a96bfc = var_2511d56abe3f9558;

    foreach(clip in var_c96dc31f024483a8) {
      clip notsolid();

      if(!isDefined(clip.script_parameters)) {
        ent.buildable.clip = clip;
        ent.buildable.clip connectpaths();
        ent.buildable.clip.origin -= (0, 0, 50);
      } else if(clip.script_parameters == "surrounding") {
        clip.origin -= (0, 0, 50);

        if(!isDefined(ent.buildable.surroundingclips)) {
          ent.buildable.surroundingclips = [];
        }

        ent.buildable.surroundingclips[ent.buildable.surroundingclips.size] = clip;
      } else if(clip.script_parameters == "pop_up") {
        ent.buildable.pushingclip = clip;
      }

      clip.moverdoesnotkill = 1;
    }

    if(isDefined(ent.buildable.models[0])) {
      ent.buildable.models[0].outlineid = scripts\mp\utility\outline::outlineenableforall(ent.buildable.models[0], "shimmer_crafting_wm_buildable", "level_script");
    }

    ent useTriggerRequireLookAt(1);
  }
}

function function_eeb5fae661444ab6(player, buildable) {
  pushingdir = 50 * anglestoright(buildable.models[0].angles);
  buildable.pushingclip solid();
  buildable.pushingclip.originpos = buildable.pushingclip.origin;
  buildable.pushingclip moveTo(buildable.pushingclip.origin + pushingdir, 0.2);

  sphere(buildable.pushingclip.origin, 10, undefined, undefined, 10000);

  foreach(clip in buildable.surroundingclips) {
    clip solid();
    clip.originpos = clip.origin;
    clip delaycall(0.2, &movez, 50, 0.2);
  }

  buildable.clip solid();
  buildable.clip.originpos = buildable.clip.origin;
  buildable.clip movez(50, 4);
  buildable.clip namespace_555f6ee22fb8fd82::function_adc7327a592cc4a1();
}

function function_219488eeb71cf8ce(player, buildable) {
  foreach(clip in buildable.clips) {
    clip notsolid();

    if(isDefined(clip.originpos)) {
      clip.origin = clip.originpos;
    }
  }
}

function function_f7d3423c552f1596(player, buildable) {
  ent = buildable.triggerent;

  foreach(clip in buildable.clips) {
    if(isDefined(clip.script_parameters)) {
      clip notsolid();
      clip delete();
      continue;
    }

    clip disconnectPaths();
  }

  if(isDefined(buildable.models[0])) {
    playFX(level._effect["sandbag_built"], buildable.models[0].origin);
  }

  scripts\mp\utility\outline::outlinedisable(buildable.models[0].outlineid, buildable.models[0]);

  foreach(var_8fc3ede56d4571bf in level.players) {
    if(var_8fc3ede56d4571bf istouching(buildable.var_6d5cb3b114a96bfc)) {
      var_8fc3ede56d4571bf suicide();
    }
  }
}

function function_503244ee309d918d() {
  ents = getEntArray("tri_build_tank_trap", "targetname");

  foreach(index, ent in ents) {
    var_1c59cace1457e117 = getStruct(ent.target, "targetname");
    buildable = scripts\mp\gametypes\wm_buildable::function_e20a97a059fba2ea("bdb_tankTrap", ent, ent.script_noteworthy, 0, var_1c59cace1457e117.origin, var_1c59cace1457e117.angles);
    ent.buildable = buildable;
    ent.id = index;

    if(isDefined(ent.buildable.models[0])) {
      ent.buildable.models[0].outlineid = scripts\mp\utility\outline::outlineenableforall(ent.buildable.models[0], "shimmer_crafting_wm_buildable", "level_script");
    }

    var_58c4969f9f12ba44 = getEnt(var_1c59cace1457e117.target, "targetname");
    var_58c4969f9f12ba44 notsolid();
    var_58c4969f9f12ba44.origin -= (0, 0, 50);
    var_58c4969f9f12ba44.originalpos = var_58c4969f9f12ba44.origin;
    var_58c4969f9f12ba44.movingdir = anglesToForward(var_1c59cace1457e117.angles);
    buildable.clip = var_58c4969f9f12ba44;
    entparts = getEntArray(ent.target, "targetname");

    foreach(part in entparts) {
      if(!isDefined(part.script_noteworthy)) {
        continue;
      }

      if(part.script_noteworthy == "destroy_trigger") {
        ent.destroytrigger = part;
      }
    }

    [buildable.c4] = getscriptablearray(ent.target, "targetname");
    ent useTriggerRequireLookAt(1);
    ent thread scripts\mp\gametypes\wm_buildable::function_17763afd915cc73c();
    buildable thread scripts\mp\gametypes\wm_buildable::function_a0f277273d13196a("zone_2");
  }
}

function function_14557abb4173c907(player, buildable) {
  buildable thread pushingplayer();
}

function pushingplayer() {
  level endon("game_ended");
  self endon("stop_building");
  self notify("start_push");
  self endon("start_push");
  var_58c4969f9f12ba44 = self.clip;
  var_58c4969f9f12ba44 solid();
  var_58c4969f9f12ba44 movez(50, 0.2);
  wait 0.2;
  goalpos = var_58c4969f9f12ba44.origin + var_58c4969f9f12ba44.movingdir * 60;
  var_58c4969f9f12ba44 moveTo(goalpos, 0.2);
  wait 0.2;
  var_58c4969f9f12ba44 notsolid();
  var_58c4969f9f12ba44.origin = var_58c4969f9f12ba44.originalpos;
}

function function_e6e4ec899d114c59(player, buildable) {
  buildable notify("stop_building");
  var_58c4969f9f12ba44 = buildable.clip;
  var_58c4969f9f12ba44 notsolid();
  var_58c4969f9f12ba44.origin = var_58c4969f9f12ba44.originalpos;
}

function function_18b4ff54f4110b21(player, buildable) {
  ent = buildable.triggerent;
  playFX(level._effect["sandbag_built"], buildable.models[0].origin);
  buildable thread scripts\mp\gametypes\wm_buildable::function_5907a34f5fb0bf04("zone_2");
  buildable.clip notsolid();
  buildable.clip.origin = buildable.clip.originalpos;
  buildable.c4 setscriptablepartstate("body", "built");
  buildable.c4.outlineid = scripts\mp\utility\outline::outlineenableforall(buildable.c4, "shimmer_crafting_wm_buildable", "level_script");
  destroyobj = scripts\mp\gametypes\wm_buildable::function_e2f7c2b8cdaefdd7(ent.destroytrigger, &"MP_JUP_LAUNCHFACILITY/REMOVETANKTRAP", 3, undefined, &function_44bc02179cd2ed83);
  destroyobj.skiptouching = undefined;
  destroyobj.buildable = buildable;
  buildable.destroyobj = destroyobj;
  setomnvar("ui_wm_escort_trap_" + ent.id, ent.progress);
  buildable thread scripts\mp\gametypes\wm_buildable::function_62602b0ea1741bd2(buildable.models[0], "hogs_destroyed");
}

function function_44bc02179cd2ed83(player) {
  self.buildable notify("trap_destroyed");
  ent = self.buildable.triggerent;
  setomnvar("ui_wm_escort_trap_" + ent.id, 0);
  oldmodel = self.buildable.models[0];

  if(isDefined(oldmodel)) {
    scripts\mp\utility\outline::outlinedisable(oldmodel.outlineid, oldmodel);
  }

  var_2642ca865799c9 = oldmodel.origin;
  var_c617038fddbdb57 = oldmodel.angles;
  newbuildable = scripts\mp\gametypes\wm_buildable::function_e20a97a059fba2ea(self.buildable.name, self.buildable.triggerent, self.buildable.zonename, 0, var_2642ca865799c9, var_c617038fddbdb57);
  ent.buildable = newbuildable;
  newbuildable.clip = self.buildable.clip;
  newmodel = newbuildable.models[0];

  if(isDefined(newmodel)) {
    newmodel.outlineid = scripts\mp\utility\outline::outlineenableforall(newmodel, "shimmer_crafting_wm_buildable", "level_script");
  }

  ent.buildable.c4 = self.buildable.c4;
  ent useTriggerRequireLookAt(1);
  ent thread scripts\mp\gametypes\wm_buildable::function_17763afd915cc73c();
  newbuildable thread scripts\mp\gametypes\wm_buildable::function_a0f277273d13196a("zone_2");
}

function function_82913d07328e5537() {
  level endon("game_ended");
  level waittill("wm_zone_captured", zone);

  if(zone.objectivetype != 1) {
    assertmsg("<dev string:x40>");
  }

  foreach(objective in level.objectives) {
    if(objective.objectivetype == zone.objectivetype && !istrue(objective.complete)) {
      function_9fb7ca43ba3b6784("obj_1", "area" + objective.objectivekey);
      break;
    }
  }
}

function function_4538f9d8dc0b9007(vehicle) {
  vehicle.stageid = 1;
  var_5beb550b14979da6 = 5;
  var_2946f1f5b9485f68 = [];

  for(i = 0; i < var_5beb550b14979da6; i++) {
    name = "check_point_" + i;
    var_a1cf1ca2c44eca8b = getvehiclenode(name, "script_noteworthy");

    if(isDefined(var_a1cf1ca2c44eca8b)) {
      assert(isDefined(var_a1cf1ca2c44eca8b.progress));
      var_a1cf1ca2c44eca8b.visible = 1;
      var_2946f1f5b9485f68[i] = var_a1cf1ca2c44eca8b;

      if(name == "check_point_0" || name == "check_point_4") {
        var_a1cf1ca2c44eca8b.visible = 0;
      }
    }
  }

  assert(var_5beb550b14979da6 == var_2946f1f5b9485f68.size);
  return var_2946f1f5b9485f68;
}

function function_8ac0af786a238752() {
  level endon("game_ended");
  level waittill("escort_path_set", tank);
  assert(isDefined(tank.checkpoints));
  level.boundary_stage = [];
  level.volume_stage = [];

  foreach(i, checkpoint in tank.checkpoints) {
    foreach(side in ["attackers", "defenders"]) {
      var_606e9637acb77372 = getEntArray("boundary_stage_" + i + "_prevent_" + side, "targetname");

      if(isDefined(var_606e9637acb77372) && var_606e9637acb77372.size > 0) {
        level.boundary_stage[i][side] = var_606e9637acb77372;
        level.volume_stage[i][side] = getEnt("stage_" + i + "_" + side, "targetname");

        if(isDefined(level.volume_stage[i][side])) {
          level.volume_stage[i][side].side = side;
        }
      }
    }
  }

  tank thread function_9aa340020fc22929();
}

function function_9aa340020fc22929() {
  level endon("game_ended");
  self endon("reached_goal");
  level endon("zone_2" + "_objective_end");

  thread function_54a398090e73e4fe();

  level thread function_632813fe12ee1849();

  foreach(i, checkpoint in self.checkpoints) {
    if(!isDefined(level.boundary_stage[i])) {
      continue;
    }

    function_e7d2bd03a0c17f96(level.boundary_stage[i], level.volume_stage[i], i == 1);
    function_9fb7ca43ba3b6784("obj_2", "stage_" + i);

    while(self.stageid <= i) {
      waitframe();
    }
  }
}

function function_632813fe12ee1849() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("zone_2" + "_objective_end");
  function_e7d2bd03a0c17f96(undefined, undefined, 1);
}

function function_e7d2bd03a0c17f96(boundary, volumes, var_c90367cdfa30c3d3) {
  level.var_b7a5235fd7e9f2f2 = boundary;

  foreach(player in level.players) {
    scripts\mp\gametypes\wm::function_708eab29b3ad59d9(player);

    if(!istrue(var_c90367cdfa30c3d3)) {
      player scripts\mp\gametypes\wm::function_a2d9ea22cacea5e9();
      player.oobtimelimit = 5;
    }
  }

  level.var_354c397f5458af46 = volumes;
}

function function_54a398090e73e4fe() {
  level endon("<dev string:x79>");
  self endon("<dev string:x87>");

  if(getdvarint(@ "hash_84dcf3cb7db8cb68", 0) == 1) {
    return;
  }

  while(true) {
    print3d(self.origin + (0, 0, 60), int(self.progress * 100) + "<dev string:x97>");
    print3d(self.origin + (0, 0, 50), level.zone.subzones["<dev string:x9c>"].spawnset);

    foreach(node in self.checkpoints) {
      print3d(node.origin + (0, 0, 75), "<dev string:xa9>" + int(node.progress * 100) + "<dev string:x97>", (1, 0, 0));
    }

    waitframe();
  }
}

function function_d48d53fecaf25074(spawningplayer, spawnteam, spawnpointset, fallbackspawnset, var_a22bad5fe6fbf86d) {
  retreatzonename = level.zone.name;

  if(retreatzonename == "zone_1") {
    retreatzonename = "zone_2";
  }

  if(spawnteam == game["defenders"]) {
    if(retreatzonename == "zone_3") {
      var_fcdc7f62624c71ff = "defenders_when_retreating_" + retreatzonename;
      return scripts\mp\spawnlogic::getspawnpoint(spawningplayer, spawnteam, var_fcdc7f62624c71ff, undefined, var_a22bad5fe6fbf86d);
    } else {
      return scripts\mp\spawnlogic::getspawnpoint(spawningplayer, spawnteam, spawnpointset, fallbackspawnset, var_a22bad5fe6fbf86d);
    }
  }

  var_fcdc7f62624c71ff = "attackers_when_retreating_" + retreatzonename;
  return scripts\mp\spawnlogic::getspawnpoint(spawningplayer, spawnteam, var_fcdc7f62624c71ff, undefined, var_a22bad5fe6fbf86d);
}

function function_3c8a7af329c87d2d(player) {
  if(self.objectivekey == "_a") {
    scripts\mp\hud_message::notifyteam("jup_wm_progress_radar_station", "jup_wm_progress_radar_station_enemy", player.team);
    return;
  }

  scripts\mp\hud_message::notifyteam("jup_wm_progress_sam_site", "jup_wm_progress_sam_site_enemy", player.team);
}

function function_bd4520ab6628ed1e() {
  level endon("game_ended");
  level.tankturretusable = function_29227adb79acc568("tankTurretUsable", 1);

  if(!istrue(level.tankturretusable)) {
    return;
  }

  while(!isDefined(level.escortvehicles[0])) {
    waitframe();
  }

  tank = level.escortvehicles[0];

  if(tank.vehicleref != "veh_jup_cougar_mg") {
    return;
  }

  tank waittill("landed");
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeusable(tank);
  function_bfc085ddf18e1712("single", &function_447ef1228e11749c, &function_920fe39fda388722, &function_39c1f2552dcfd9b0, &function_c9601fed18d5b11e);
}

function function_447ef1228e11749c(pointref, instancedataforpoint, vehicle, player) {
  seatid = "gunner";
  thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, seatid, player);
  params = {
    #vehicle: vehicle, #seatid: seatid, #player: player
  };
  player callback::callback("player_vehicle_enter", params);
}

function function_920fe39fda388722(pointref, instancedataforpoint, vehicle, unusedtwo) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_seatisavailable(vehicle, "gunner")) {
    availableseatid = "gunner";
  }

  instancedataforpoint.disabled = !isDefined(availableseatid);
  instancedataforpoint.availableseatid = availableseatid;
}

function function_27b5aad89735bcf9() {
  level endon("game_ended");

  if(getdvarint(@ "hash_db157b7efd5c66bb", 0) != 1) {
    return;
  }

  level.var_d74eff66c95d8c11 = [];
  function_28260c713871bcd7("zone_1", "package_zone1_attacker", &function_a021bde59ed03a3, [120, "<=", 0], game["attackers"], ["cruise_predator", "precision_airstrike", "toma_strike"]);
  function_28260c713871bcd7("zone_2", "package_zone2_defender", &function_990d76825f5da2ed, ["zone_1", "<=", 150], game["defenders"], ["remote_turret", "airdrop_escort"]);
  function_28260c713871bcd7("zone_2", "package_zone2_attacker", &function_1e8ab9080586c6b3, [120, "<=", 0.45], game["attackers"], ["fuel_airstrike", "hover_jet"]);

  foreach(var_80ba0c1492df7800 in level.var_d74eff66c95d8c11) {
    var_80ba0c1492df7800 thread function_445dbcc7a86a8125();
  }

  function_3743a0dbb1ec5523();
}

function function_28260c713871bcd7(zone, packagename, var_1950ca16bf35a8dd, var_18d20d89a8667ce0, var_5b60c9669c3ae11b, var_874c3e372961f20e) {
  packagestruct = getStruct(packagename, "script_noteworthy");

  if(!isDefined(packagestruct)) {
    assertmsg("<dev string:xbc>");
    return;
  }

  var_80ba0c1492df7800 = spawnStruct();
  var_80ba0c1492df7800.zone = zone;
  var_80ba0c1492df7800.var_1950ca16bf35a8dd = var_1950ca16bf35a8dd;
  var_80ba0c1492df7800.var_18d20d89a8667ce0 = var_18d20d89a8667ce0;
  var_80ba0c1492df7800.var_5b60c9669c3ae11b = var_5b60c9669c3ae11b;
  var_80ba0c1492df7800.var_ac25fa2525c8af30 = packagestruct.origin;
  var_80ba0c1492df7800.var_874c3e372961f20e = var_874c3e372961f20e;
  level.var_d74eff66c95d8c11[level.var_d74eff66c95d8c11.size] = var_80ba0c1492df7800;
}

function function_445dbcc7a86a8125() {
  level endon("game_ended");
  var_80ba0c1492df7800 = self;

  if(isDefined(var_80ba0c1492df7800.zone)) {
    scripts\mp\flags::gameflagwait(var_80ba0c1492df7800.zone + "_objective_start");
  }

  if(isDefined(var_80ba0c1492df7800.var_1950ca16bf35a8dd)) {
    var_33fc6b6d273061e9 = self[[var_80ba0c1492df7800.var_1950ca16bf35a8dd]](var_80ba0c1492df7800.var_18d20d89a8667ce0, var_80ba0c1492df7800.zone);

    if(var_33fc6b6d273061e9 == 0) {
      logstring("NO We Should Not Drop Package here");
      return;
    }
  }

  cargo = array_random(var_80ba0c1492df7800.var_874c3e372961f20e);
  logstring("DROPPING PACKAGE NOW ! LOC IS " + self.var_ac25fa2525c8af30 + " CARGO IS " + cargo);
  level thread scripts\mp\hud_message::notifyteam("jup_wm_care_package_comes", "", var_80ba0c1492df7800.var_5b60c9669c3ae11b);
  var_b08c62c5c19789e = groundpos(var_80ba0c1492df7800.var_ac25fa2525c8af30);
  playFX(getfx("care_package"), var_b08c62c5c19789e);
  scripts\cp_mp\killstreaks\airdrop::dropkillstreakcratefromscriptedheli(undefined, var_80ba0c1492df7800.var_5b60c9669c3ae11b, cargo, var_b08c62c5c19789e, (0, 0, 0), var_b08c62c5c19789e, 1);
}

function function_a021bde59ed03a3(params, zone) {
  scripts\mp\flags::gameflagwait("prematch_done");
  wait params[0];

  if(level.zone.name != zone) {
    return 0;
  }

  result = ter_op(params[1] == ">", function_b8bd193977a27782() > params[2], function_b8bd193977a27782() <= params[2]);
  return result;
}

function function_990d76825f5da2ed(params, zone) {
  time = function_b4f31afe7ce91484(params[0], game["roundsPlayed"] + 1);
  result = ter_op(params[1] == ">", time > params[2], time <= params[2]);
  return result;
}

function function_1e8ab9080586c6b3(params, zone) {
  while(!isDefined(level.escortvehicles[0])) {
    waitframe();
  }

  tank = level.escortvehicles[0];
  wait params[0];

  if(level.zone.name != zone) {
    return 0;
  }

  result = ter_op(params[1] == ">", tank.progress > params[2], tank.progress <= params[2]);
  return result;
}

function function_3743a0dbb1ec5523() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("zone_2" + "_objective_start");
  tank = level.escortvehicles[0];
  tank.var_4b75a4ee07200d3b = &function_ebcf745913dfa4f7;
}

function function_ebcf745913dfa4f7(vehicle, otherent) {
  if(isDefined(otherent.classname) && otherent.classname == "script_model") {
    linkedparent = otherent getlinkedparent();

    if(isDefined(linkedparent)) {
      otherent = linkedparent;
    }
  }

  if(isDefined(otherent.streakname) && !istrue(otherent.ishitbyvehicle)) {
    if(otherent.streakname == "sentry_turret" || otherent.streakname == "remote_turret") {
      wasdestroyed = 1;
      skipshutdown = 1;
      otherent.ishitbyvehicle = 1;
      otherent notify("kill_turret", skipshutdown, wasdestroyed);
    }
  }
}

function function_4e41bf0f45af388d(zone) {
  level.var_6c0eaa5a95164771 = undefined;
  const_attackers = "attackers";
  const_defenders = "defenders";
  var_c450199ce7b0b007 = "wm_zone_begin_capture";
  var_99716e712cb5d3e = "wm_zone_captured";
  var_2b294986c82254b3 = "vo_group_attackers_capture_zone";
  var_f00ee835cfdde317 = "vo_group_defenders_capture_zone";
  var_f2b3753e22a55135 = [[const_defenders, "obj1_nag_def_launchfacility", &namespace_500f6f1bc37289b::function_b908e49a52805716, undefined, var_f00ee835cfdde317, 20, 8], [const_attackers, "obj1_nag_atk_launchfacility", &namespace_500f6f1bc37289b::function_c6d032c5630b1779, undefined, var_2b294986c82254b3, 20, 8], [const_attackers, "obj1_securing_a_atk", var_c450199ce7b0b007, zone.capture_zones[0], var_2b294986c82254b3], [const_attackers, "obj1_captured_a_atk", var_99716e712cb5d3e, zone.capture_zones[0], var_2b294986c82254b3], [const_defenders, "obj1_losing_a_def", var_c450199ce7b0b007, zone.capture_zones[0], var_f00ee835cfdde317], [const_defenders, "obj1_lost_a_def", var_99716e712cb5d3e, zone.capture_zones[0], var_f00ee835cfdde317], [const_attackers, "obj1_securing_b_atk", var_c450199ce7b0b007, zone.capture_zones[1], var_2b294986c82254b3], [const_attackers, "obj1_captured_b_atk", var_99716e712cb5d3e, zone.capture_zones[1], var_2b294986c82254b3], [const_defenders, "obj1_losing_b_def", var_c450199ce7b0b007, zone.capture_zones[1], var_f00ee835cfdde317], [const_defenders, "obj1_lost_b_def", var_99716e712cb5d3e, zone.capture_zones[1], var_f00ee835cfdde317], [const_attackers, "obj1_missile_launch_atk", "zone_1_missile_launched", undefined, var_2b294986c82254b3, 2, 2], [const_attackers, "obj1_atk_overtime_launchfacility", "obj_type_1_overtime_mp_jup_launchfacility", undefined, var_2b294986c82254b3], [const_defenders, "obj1_def_overtime_launchfacility", "obj_type_1_overtime_mp_jup_launchfacility", undefined, var_f00ee835cfdde317]];

  foreach(setup in var_f2b3753e22a55135) {
    side = setup[0];
    struct = spawnStruct();
    struct.dialog = setup[1];
    struct.condition = setup[2];
    struct.conditionobject = setup[3];
    struct.group = setup[4];
    struct.cooldown = setup[5];
    struct.delaystart = setup[6];
    scripts\mp\gametypes\wm_objectives::function_7de515850cb39482(zone, side, struct);
  }

  scripts\mp\gametypes\wm_objectives::function_266f0d24f28fc974(zone);
}

function function_41fe0ce4b07a5ce7(zone) {
  level.var_6c0eaa5a95164771 = undefined;
  scripts\mp\gametypes\wm_objectives::function_1e87a912abc079e4(zone, "defenders", "obj2_nag_def_launchfacility", undefined, 14, 8);
  scripts\mp\gametypes\wm_objectives::function_1e87a912abc079e4(zone, "attackers", "obj2_nag_atk_launchfacility", undefined, 14, 8);
  scripts\mp\gametypes\wm_objectives::function_1e87a912abc079e4(zone, "attackers", "obj2_atk_tank_damaged_launchfacility", "tank_damaged", 2);
  scripts\mp\gametypes\wm_objectives::function_1e87a912abc079e4(zone, "defenders", "obj2_def_tank_damaged_launchfacility", "tank_damaged", 2);
  scripts\mp\gametypes\wm_objectives::function_1e87a912abc079e4(zone, "attackers", "obj2_atk_tank_repaired_launchfacility", "tank_repaired", 2);
  scripts\mp\gametypes\wm_objectives::function_1e87a912abc079e4(zone, "defenders", "obj2_def_tank_repaired_launchfacility", "tank_repaired", 2);
  scripts\mp\gametypes\wm_objectives::function_1e87a912abc079e4(zone, "attackers", "obj2_atk_tank_contested_launchfacility", &namespace_500f6f1bc37289b::function_620b653076493779, 20);
  scripts\mp\gametypes\wm_objectives::function_1e87a912abc079e4(zone, "defenders", "obj2_def_tank_contested_launchfacility", &namespace_500f6f1bc37289b::function_620b653076493779, 20);
  scripts\mp\gametypes\wm_objectives::function_1e87a912abc079e4(zone, "attackers", "obj2_atk_overtime_launchfacility", "obj_type_6_overtime_mp_jup_launchfacility", 2);
  scripts\mp\gametypes\wm_objectives::function_1e87a912abc079e4(zone, "defenders", "obj2_def_overtime_launchfacility", "obj_type_6_overtime_mp_jup_launchfacility", 2);
  scripts\mp\gametypes\wm_objectives::function_266f0d24f28fc974(zone);
}

function function_a9229844e65e7b50() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("zone_2" + "_objective_end");
  var_795e67d6e6be2a3c = getEnt("zone3", "script_noteworthy");

  if(!isDefined(var_795e67d6e6be2a3c)) {
    return;
  }

  assertex(isDefined(var_795e67d6e6be2a3c.script_floor_number), "<dev string:xf5>");

  while(true) {
    waitframe();

    foreach(player in level.players) {
      if(!istrue(player.var_9b713d24bdb6d97f) && (isalive(player) && player istouching(var_795e67d6e6be2a3c) || !isalive(player) && is_equal(player.team, game["defenders"]))) {
        player scripts\mp\compass::function_fb7bad834ce4b28c(var_795e67d6e6be2a3c.script_floor_number);
        player.var_9b713d24bdb6d97f = 1;
      }
    }
  }
}

function function_4c3317636403651() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("zone_3" + "_objective_start");
  var_d3c3ee3b2c62604f = function_4b0074ef058e72e9();

  foreach(player in level.players) {
    player thread function_59be3ae75b0410b3(var_d3c3ee3b2c62604f);
  }

  while(true) {
    level waittill("player_spawned", player);

    if(!istrue(player.var_70306faec99271f8)) {
      side = ter_op(is_equal(player.pers["team"], game["attackers"]), "attackers", "defenders");

      foreach(entry in var_d3c3ee3b2c62604f) {
        objid = entry.var_87f5044418228fdc[side].objidnum;
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(objid, player);
      }

      player thread function_59be3ae75b0410b3(var_d3c3ee3b2c62604f);
    }
  }
}

function function_59be3ae75b0410b3(var_d3c3ee3b2c62604f) {
  level endon("game_ended");
  self endon("disconnect");
  self.var_70306faec99271f8 = 1;

  foreach(objstr in level.zone.objectives) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.objectives[objstr].objidnum, self);
  }

  self setclientomnvar("ui_wm_objective_show_match_status", 0);

  while(self.origin[2] - var_d3c3ee3b2c62604f[0].origin[2] > -10) {
    waitframe();
  }

  self setclientomnvar("ui_wm_objective_show_match_status", 1);

  foreach(objstr in level.zone.objectives) {
    if(!istrue(level.objectives[objstr].complete)) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.objectives[objstr].objidnum, self);
    }
  }

  foreach(entry in var_d3c3ee3b2c62604f) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(entry.var_87f5044418228fdc["attackers"].objidnum, self);
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(entry.var_87f5044418228fdc["defenders"].objidnum, self);
  }
}

function function_4b0074ef058e72e9() {
  var_d3c3ee3b2c62604f = getscriptablearray("silo_door_zone_3", "script_noteworthy");

  foreach(entry in var_d3c3ee3b2c62604f) {
    foreach(side in ["attackers", "defenders"]) {
      var_87f5044418228fdc = spawn("script_model", entry.origin);
      var_87f5044418228fdc.curorigin = var_87f5044418228fdc.origin;
      var_87f5044418228fdc.offset3d = (0, 0, 80);
      var_87f5044418228fdc scripts\mp\gameobjects::requestid(1, 0, undefined, 1);
      objid = var_87f5044418228fdc.objidnum;
      scripts\mp\objidpoolmanager::update_objective_icon(objid, "icon_waypoint_ied_plant");
      scripts\mp\objidpoolmanager::update_objective_ownerteam(objid, game[side]);
      scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
      scripts\mp\objidpoolmanager::function_9cad42ac02eff950(objid);

      if(side == "attackers") {
        scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(objid, &"MP_JUP_LAUNCHFACILITY/JUMP_DOWN_ATTACKER");

        foreach(player in scripts\mp\utility\teams::getteamdata(game["attackers"], "players")) {
          scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(objid, player);
        }
      } else {
        scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(objid, &"MP_JUP_LAUNCHFACILITY/JUMP_DOWN_DEFENDER");

        foreach(player in scripts\mp\utility\teams::getteamdata(game["defenders"], "players")) {
          scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(objid, player);
        }
      }

      scripts\mp\objidpoolmanager::update_objective_state(objid, "current");
      entry.var_87f5044418228fdc[side] = var_87f5044418228fdc;
    }
  }

  return var_d3c3ee3b2c62604f;
}