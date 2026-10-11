/********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving.gsc
********************************************************************/

#using script_187e2c28364e465b;
#using script_1bf7efeac8beb6f7;
#using script_1d1428a3b7b402b0;
#using script_248ec5040062d3ce;
#using script_24fbedba9a7a1ef4;
#using script_261f1b574c15eab1;
#using script_26b89331149b1719;
#using script_2d3fead1b9e1d7e5;
#using script_2d4b9c58ed0e3d91;
#using script_36967ce8ee2ea745;
#using script_3a535b44f9ecc6df;
#using script_49314540c657d352;
#using script_518ae857a3d351c;
#using script_545684ac3072093;
#using script_62384cde1a08c286;
#using script_66e0e331f9783820;
#using script_69a61780e1cc21a9;
#using script_6bc507afe7a93a3;
#using script_7abaa04d5f9fc22e;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\create_script_utility;
#using scripts\common\elevators;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\anim;
#using scripts\mp\compass;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\wm;
#using scripts\mp\gametypes\wm_buildable;
#using scripts\mp\gametypes\wm_ending;
#using scripts\mp\gametypes\wm_objectives;
#using scripts\mp\gametypes\wm_ui;
#using scripts\mp\gametypes\wm_utility;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_skydiving\gen\mp_jup_skydiving_art;
#using scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving_audio;
#using scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving_create_script;
#using scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving_fx;
#using scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving_lighting;
#using scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving_zone_1_create_script;
#using scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving_zone_2_create_script;
#using scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving_zone_3_create_script;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#using scripts\quaked\script_struct_mp_iw9_palfa;
#namespace mp_jup_skydiving;

function main() {
  scripts\mp\maps\mp_jup_skydiving\gen\mp_jup_skydiving_art::main();
  scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving_audio::main();
  scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving_fx::main();
  scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving_lighting::main();
  namespace_6bb2e038a2adbe49::main();
  initvehicles();
  scripts\mp\load::main();
  scripts\common\create_script_utility::initialize_create_script();
  level thread scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving_create_script::main();
  level thread scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving_zone_1_create_script::main();
  level thread scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving_zone_2_create_script::main();
  level thread scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving_zone_3_create_script::main();
  scripts\cp_mp\utility\game_utility::registerlargemap();
  scripts\cp_mp\utility\game_utility::function_3673befc7dcade8b();
  namespace_66ade5cda10fe3aa::init();
  function_e27bc4a5e8e27440();

  if(!isDefined(level.outofboundstriggers)) {
    level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  }

  setupminimap("compass_map_mp_jup_skydiving", undefined, undefined, "zone_1");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  setDvar(@ "hash_9365c7a237edaa2f", 1);
  level.parachutecancutautodeploy = 1;
  level.parachutecancutparachute = 1;
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";

  if(scripts\cp_mp\utility\game_utility::function_d04af493b6e718ac()) {
    scripts\mp\gametypes\wm_objectives::function_333f4c66e6305891(10, ["_a", "_b", "_c"], "zone_1", "", function_d4b2873d01de6c04(10));
    scripts\mp\gametypes\wm_objectives::function_333f4c66e6305891(11, ["_d", "_e", "_f"], "zone_2", ["wm_escort_tank_path", "capture_zone_wheelson_first", "capture_zone_wheelson_second"], function_d4b2873d01de6c04(11));
    scripts\mp\gametypes\wm_objectives::function_333f4c66e6305891(12, ["_g", "_h", "_i", "_j"], "zone_3", ["flag_begin_1", "flag_begin_2", "flag_end", "capture_zone"], function_d4b2873d01de6c04(12));
    level.var_f24db6a5246641cb = &function_f24db6a5246641cb;
    level.wmonplayerkilled = &wmonplayerkilled;
    level.var_77a7be006731f124 = "scripted_widget_objective_tracker_jup_wm_skydiving";
    scripts\mp\gametypes\wm_ending::function_1c915051680a9364(&function_d69acc92a86dd80b, &function_d5f16f7e888c59d3);
    level function_850846af3c63dab1();
    level thread initai();
    level thread function_bdccfc7ecc6306c1();
    wm_zombie::init();

    if(!getdvarint(@ "hash_eeef9f80e6c23588", 0)) {
      level thread namespace_d99736a82ac4e63b::init();
      level thread function_b9730bfe1e8b9f81();
      level thread function_dce86aec5b302384();
    }

    level thread function_e393d662064dffce();
    level thread function_1e57e0eff0416516();
  }

  level callback::add("on_wm_round_end", &function_7a49dcb707410ca2);
  level callback::add("on_wm_round_end", &function_c294f9788942533b);
}

function function_850846af3c63dab1() {
  level.enablezombie = getdvarint(@ "hash_1196c97cf6cee66e", 0);
  level.var_8034530507c48231 = getdvarint(@ "hash_9b1a6c207a13de7", 1);
  level.requiredplayercountoveride = 1;
  level.requiredplayercount["allies"] = 6;
  level.requiredplayercount["axis"] = 6;
  game["dialog"]["wm_oob_atk_skydiving"] = "dx_mp_skyd_game_seal_oobk";
  game["dialog"]["wm_oob_def_skydiving"] = "dx_mp_skyd_game_spet_oobd";
  level.var_c99eed54a2e150c7 = "wm_oob_atk_skydiving";
  level.var_e7cbc43f8f9aa5d3 = "wm_oob_def_skydiving";
  level.var_7b3187b12cba9559 = getEnt("unable_tank_nearby", "script_noteworthy");
  level.var_673860e74c8ec9d1 = getEntArray("destroy_tac_items", "script_noteworthy");
  level.spawnintermissiondelayseconds = 10;
  scripts\mp\flags::gameflaginit("wheelson_reach_hack_point_final", 0);
}

function function_bdccfc7ecc6306c1() {
  flag_wait("onStartGameTypeFinished");
  level thread namespace_f1904f34c0b223c1::init();
  function_28c9bb84699d73b2();
  level.var_57b13482577dd10 = getEntArray("tac_cover_dst_trigger", "script_noteworthy");
  level.var_4538f9d8dc0b9007 = &function_602c658374655858;

  if(isDefined(level.cratedropdata)) {
    if(isDefined(level.cratedropdata.heliheight)) {
      level.cratedropdata.heliheight += 5000;
    }

    level thread function_10137d9104d0f35c();
  }

  level thread function_90371f43aad9292a();
  level thread function_2825d48b0ba8d908();
  level thread function_e92f5d2e481565b1();
  level thread function_90c5aa738228d4df();
  level thread function_1eaefd55b8e356c7();
  level thread function_2d6d7d97de343d0f();
  level thread function_bc36ba717880033c();
  level thread function_14e9a0244a570ff6();
  level thread function_fd3c293d8f2b219e();
  level thread function_a5f8312fdbf97755();
  level thread function_7d25484659308d59();
}

function initai() {
  scripts\mp\ai_mp_controller::init();
  scripts\mp\ai_mp_controller::function_c8393014dd7f8ab6();
  scripts\mp\ai_mp_controller::function_ba4022744dce59f6("show");

  if(!getdvarint(@ "hash_8f919767a3bc1051", 1)) {
    level.agent_funcs["zombie"]["on_damaged"] = &namespace_daa149ca485fd50a::function_dffac413ed66bcd0;
  }
}

function function_f24db6a5246641cb() {
  game["dialog"]["obj_atk_times_up_sixty"] = "dx_mp_skyd_game_seal_cssa";
  game["dialog"]["obj_def_times_up_sixty"] = "dx_mp_skyd_game_spet_cssd";
  game["dialog"]["obj_atk_times_up_thirty"] = "dx_mp_skyd_game_seal_csta";
  game["dialog"]["obj_def_times_up_thirty"] = "dx_mp_skyd_game_spet_cstd";
  game["dialog"]["obj_atk_times_up_ten"] = "dx_mp_skyd_game_seal_cstk";
  game["dialog"]["obj_def_times_up_ten"] = "dx_mp_skyd_game_spet_cstf";
  scripts\mp\gametypes\wm::function_ca18dc1a088a7245(60, "obj_atk_times_up_sixty", "obj_def_times_up_sixty");
  scripts\mp\gametypes\wm::function_ca18dc1a088a7245(30, "obj_atk_times_up_thirty", "obj_def_times_up_thirty");
  scripts\mp\gametypes\wm::function_ca18dc1a088a7245(10, "obj_atk_times_up_ten", "obj_def_times_up_ten");
}

function wmonplayerkilled() {
  if(istrue(self.ingas)) {
    namespace_f1904f34c0b223c1::function_7ff7466f14522ce3(0);
  }
}

function function_d4b2873d01de6c04(index) {
  if(!isDefined(level.var_ebec9ab53ddcfaa2)) {
    params = [];
    params["hackUploadTime"] = function_ef4d323f56385843("sdHackUploadTime", 28);
    params["leaderDialogAttackers"] = "obj1_atk_win_skydiving";
    params["leaderDialogDefenders"] = "obj1_def_lost_skydiving";
    params["transitionSplash"] = ["jup_wm_transition_launchfacility_escort", "jup_wm_transition_launchfacility_escort_defend"];
    params["hackObjective"] = [];
    params["hackObjective"]["openRoofTime"] = 10;
    params["hackObjective"]["targetname"] = "bombzone_unlock";
    params["usingVisualHintString"] = &"MP_JUP_LAUNCHFACILITY/CONSOLE_LAUNCH";
    params["hackUseTime"] = getdvarfloat(@ "hash_7deb1a2a556f0f68", 3);
    params["hackRestoreTime"] = getdvarfloat(@ "hash_71feab7b56287a35", 4);
    params["bombObjective"] = [];
    params["bombObjective"]["targetname"] = "bombzone";
    params["hack_zone_upload_complete_splash_friendly"] = "jup_wm_activate_first_control_panel_attacker";
    params["hack_zone_upload_complete_splash_enemy"] = "jup_wm_activate_first_control_panel_defender";
    params["hack_zone_upload_full_complete_splash_friendly"] = "jup_wm_open_rooftop_hatch_attacker";
    params["hack_zone_upload_full_complete_splash_enemy"] = "jup_wm_open_rooftop_hatch_defender";
    level.var_ebec9ab53ddcfaa2[10] = params;
    params = [];
    params["useP2P"] = getdvarint(@ "hash_53cf3fb27a4e4e35", 0) != 0;
    params["canStopByDefenders"] = istrue(function_29227adb79acc568("tankContestable", 1));
    params["progressByActualDistance"] = 1;
    params["vehicleRef"] = "veh_jup_skydiving_wheelson";
    params["vehicleSpeed"] = function_ef4d323f56385843("sdVehicleSpeed", 4);
    params["vehicleRef.vehObjZOffset"] = 65;
    params["tankNearbyRange"] = getdvarint(@ "hash_a05ad819aecbb000", 200);
    params["wheelsonCaptureTime"] = dvarfloatvalue("wheelsonCaptureTime", 30, 0, 120);
    params["airdrop_offset"] = (0, 0, 1450);
    params["wheelsonRetreatSpeed"] = getdvarint(@ "hash_7979684c0c17d015", 1.5);
    params["leaderDialogAttackers"] = "obj2_atk_win_skydiving";
    params["leaderDialogDefenders"] = "obj2_def_lost_skydiving";
    params["transitionSplash"] = ["jup_wm_transition_skydiving_zone1to2", "jup_wm_transition_skydiving_zone1to2_defend"];
    params["spawn_wheelson_delay_time"] = getdvarint(@ "hash_a88c8014d8aa26e7", 60);
    level.var_ebec9ab53ddcfaa2[11] = params;
    params = [];
    params["leaderDialogAttackers"] = "obj3_atk_win_skydiving";
    params["leaderDialogDefenders"] = "obj3_def_lost_skydiving";
    params["transitionSplash"] = ["jup_wm_transition_skydiving_zone2to3", "jup_wm_transition_skydiving_zone2to3_defend"];
    level.var_ebec9ab53ddcfaa2[12] = params;
  }

  return level.var_ebec9ab53ddcfaa2[index];
}

function initvehicles() {
  level.var_1b4da6b781c9dfbd = 1;
  namespace_8db7d778efdc3d65::main();
  namespace_15896d40cab0d429::main();
  namespace_a8c01726524388f5::main();
  namespace_d8c2d739478db8bb::main();
  namespace_a8b2611e1c2c0f9c::main();
  namespace_65ad5249b19d5d41::main();
  namespace_9972b4aee3d673ca::main();
  namespace_a5c3c313b4f6886a::main();
  namespace_3568ab3cfd523b38::main();
  namespace_405c71940c7ec9ea::main();
  namespace_8624e3257d13b029::main();
  namespace_ea79ad160580b4e7::main();
  scripts\quaked\script_struct_mp_iw9_palfa::main();
}

function function_d69acc92a86dd80b() {
  scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving_lighting::function_83165e6c3fba43ff((-45, -110, 0), (1, 0.9, 0.75), 0.016);
  intermission = getEnt("mp_global_intermission", "classname");
  animstruct = spawnStruct();
  animstruct.origin = intermission.origin;
  animstruct.angles = intermission.angles;
  animstruct.cam = animstruct scripts\mp\gametypes\wm_ending::create_cam();
  animstruct.cam.origin = animstruct.origin;
  animstruct.cam.angles = animstruct.angles;
  scene_struct = getStruct("attacker_exfil", "targetname");
  scene_struct scene::set_scriptbundle("jup_scene_wm_skydiving_attacker_exfil");
  level.var_a12c755dc79cd6f3 = 1;
  function_62247a3afa8950b6();
  playersinscene = [];

  foreach(player in level.players) {
    if(!isDefined(player) || !scripts\mp\utility\teams::isgameplayteam(player.pers["team"])) {
      continue;
    }

    player scripts\mp\gametypes\wm_utility::function_9a2fc80f0c0ef3b0();

    if(is_equal(player.pers["team"], game["attackers"])) {
      playersinscene[playersinscene.size] = player;
      continue;
    }

    player playerhide();
  }

  shots = scene_struct scene::function_8a37fe423de2b9db();
  scene::add_scene_func(scene_struct, &function_ff1e7af2ffb8692e, shots[1]);
  scene::add_scene_func(scene_struct, &function_b75465ae12ace0ab, shots[2]);
  scene::add_scene_func(scene_struct, &function_c9ef35515ffc769a, "shot_010");
  scene::add_scene_func(scene_struct, &function_c9ef34515ffc7467, "shot_020");
  scene::add_scene_func(scene_struct, &function_c9ef33515ffc7234, "shot_030");
  scene_struct scene::pre_stream(playersinscene);
  scene_struct thread scene::play(playersinscene);
  scenelength = scene_struct scripts\mp\gametypes\wm_utility::function_e31fc10a143fc19() - 10;

  if(scenelength > 0) {
    wait scenelength;
  }

  return animstruct.cam;
}

function function_c9ef35515ffc769a() {
  function_584da1d8f2df50cc("jup_skydiving_exfil_attacker_shot_01");
}

function function_c9ef34515ffc7467() {
  function_584da1d8f2df50cc("jup_skydiving_exfil_attacker_shot_02");
}

function function_c9ef33515ffc7234() {
  function_584da1d8f2df50cc("jup_skydiving_exfil_attacker_shot_03");
}

function function_ff1e7af2ffb8692e() {
  level thread function_9b4edffa3400ada1();
  exploder("attacker_exfil");
}

function function_9b4edffa3400ada1() {
  level endon("game_ended");
  scripts\mp\anim::function_3c8f0102ea5254f3(190);

  foreach(player in level.players) {
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 0.5);
  }

  wait 0.5;

  foreach(player in level.players) {
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 1);
  }
}

function function_b75465ae12ace0ab() {
  kill_exploder("attacker_exfil");
}

function function_d5f16f7e888c59d3() {
  scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving_lighting::function_83165e6c3fba43ff((-38, 138, 0), (1, 0.9, 0.75), 0.02);
  intermission = getEnt("mp_global_intermission", "classname");
  animstruct = spawnStruct();
  animstruct.origin = intermission.origin;
  animstruct.angles = intermission.angles;
  animstruct.cam = animstruct scripts\mp\gametypes\wm_ending::create_cam();
  animstruct.cam.origin = animstruct.origin;
  animstruct.cam.angles = animstruct.angles;
  scene_struct = getStruct("defender_exfil", "targetname");
  scene_struct scene::set_scriptbundle("jup_scene_wm_skydiving_defender_exfil");
  level.var_a12c755dc79cd6f3 = 1;
  function_62247a3afa8950b6();
  playersinscene = [];

  foreach(player in level.players) {
    if(!isDefined(player) || !scripts\mp\utility\teams::isgameplayteam(player.pers["team"])) {
      continue;
    }

    player scripts\mp\gametypes\wm_utility::function_9a2fc80f0c0ef3b0();

    if(is_equal(player.pers["team"], game["defenders"])) {
      playersinscene[playersinscene.size] = player;
      continue;
    }

    player playerhide();
  }

  shots = scene_struct scene::function_8a37fe423de2b9db();
  scene::add_scene_func(scene_struct, &function_23ead4b32b3f6e5, shots[0]);
  scene::add_scene_func(scene_struct, &function_3b1605eb06863e62, "shot_010");
  scene::add_scene_func(scene_struct, &function_3b1604eb06863c2f, "shot_020");
  scene::add_scene_func(scene_struct, &function_3b1603eb068639fc, "shot_030a");
  scene::add_scene_func(scene_struct, &function_3b1602eb068637c9, "shot_060");
  scene_struct scene::pre_stream(playersinscene);
  scene_struct thread scene::play(playersinscene);
  scenelength = scene_struct scripts\mp\gametypes\wm_utility::function_e31fc10a143fc19() - 10 - 1;

  if(scenelength > 0) {
    wait scenelength;
  }

  return animstruct.cam;
}

function function_3b1605eb06863e62() {
  function_584da1d8f2df50cc("jup_skydiving_exfil_defender_shot_01");
}

function function_3b1604eb06863c2f() {
  function_584da1d8f2df50cc("jup_skydiving_exfil_defender_shot_02");
}

function function_3b1603eb068639fc() {
  function_584da1d8f2df50cc("jup_skydiving_exfil_defender_shot_03");
}

function function_3b1602eb068637c9() {
  function_584da1d8f2df50cc("jup_skydiving_exfil_defender_shot_04");
}

function function_584da1d8f2df50cc(soundalias) {
  foreach(player in level.players) {
    if(!isai(player)) {
      player playlocalsound(soundalias);
    }
  }
}

function function_23ead4b32b3f6e5() {
  exploder("defender_exfil");
}

function function_10137d9104d0f35c() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("zone_2" + "_objective_start");
  level.var_59aa0529c1cc5a3b = 0;
  level waittill("part_3_leak");

  while(!isDefined(level.var_73b072a7ebe7cb17)) {
    waitframe();
  }

  while(level.var_73b072a7ebe7cb17.size > 0) {
    waitframe();
  }

  level.var_59aa0529c1cc5a3b = 1;
}

function function_1eaefd55b8e356c7() {
  level endon("game_ended");
  level._effect["open_roof_dust"] = loadfx("vfx/jup/level/mp_jup_launchfacility/vfx_jup_launchfacility_air_cliff_falling_dust_lrg_01.vfx");
  level waittill("prematch_done");
  roofs = getEntArray("zone1_roof", "targetname");
  var_797f676eac2f5f5d = getStructArray("roof_origin", "targetname");
  var_24e1eee4a6f213b7 = getentitylessscriptablearray("deployable_roof", "script_noteworthy");
  var_633452f052c3d4ba = getscriptablearray("roof_light", "script_noteworthy");
  var_24e1eee4a6f213b7[0] setscriptablepartstate("light", "off");
  level waittill("hack_zone_upload_complete");
  level thread function_c8a59331ffa83829(roofs, var_797f676eac2f5f5d, var_24e1eee4a6f213b7, 0.5, var_633452f052c3d4ba);
  level waittill("hack_zone_upload_full_complete");
  level thread function_c8a59331ffa83829(roofs, var_797f676eac2f5f5d, var_24e1eee4a6f213b7, 1, var_633452f052c3d4ba);
}

function function_c8a59331ffa83829(roofs, var_797f676eac2f5f5d, var_24e1eee4a6f213b7, ratio, var_633452f052c3d4ba) {
  if(isDefined(level.zone.objective.params["hackObjective"]["openRoofTime"])) {
    openrooftime = level.zone.objective.params["hackObjective"]["openRoofTime"];
  } else {
    openrooftime = 10;
  }

  while(istrue(var_24e1eee4a6f213b7[0].ismoving)) {
    waitframe();
  }

  foreach(roof in roofs) {
    foreach(movenode in var_797f676eac2f5f5d) {
      if(roof.script_noteworthy == movenode.script_noteworthy) {
        origin = movenode.origin;

        if(ratio == 0.5) {
          origin = (movenode.origin - roof.origin) * 3 / 10 + roof.origin;
        }

        roof moveTo(origin, openrooftime, 0.1, 0.5);
        var_42515338db8d7dc5 = getEnt(roof.target, "targetname");
        var_d9016ba0c600cd99 = getStruct(var_42515338db8d7dc5.target, "targetname");
        origin = var_d9016ba0c600cd99.origin;

        if(ratio == 0.5) {
          origin = (var_d9016ba0c600cd99.origin - var_42515338db8d7dc5.origin) * 3 / 10 + var_42515338db8d7dc5.origin;
        }

        var_42515338db8d7dc5 moveTo(origin, openrooftime, 0.1, 0.5);
      }
    }
  }

  var_24e1eee4a6f213b7[0].ismoving = 1;
  var_24e1eee4a6f213b7[0] setscriptablepartstate("light", "red_flash");
  var_24e1eee4a6f213b7[0] setscriptablepartstate("sound", "moving");
  function_e45e5fd94ec4af36(0.3, 0.2, 0.1, 1, var_24e1eee4a6f213b7[0].origin, 1000, 1500, 3000);
  function_e45e5fd94ec4af36(0.15, 0.15, 0.15, 15, var_24e1eee4a6f213b7[0].origin, 1000, 1500, 3000);
  thread function_765136e4fecc97c3(10);

  foreach(light in var_633452f052c3d4ba) {
    light setscriptablepartstate("becon_light", "red_rotate");
  }

  wait 7.5;

  foreach(roof in roofs) {
    playFX(getfx("open_roof_dust"), roof.origin);
  }

  wait 1.5;
  var_24e1eee4a6f213b7[0] setscriptablepartstate("sound", "stop");
  wait 0.5;
  function_e45e5fd94ec4af36(0.3, 0.2, 0.1, 1, var_24e1eee4a6f213b7[0].origin, 1000, 1500, 3000);
  wait 0.5;
  color = "red";

  if(ratio == 1) {
    color = "green";
  }

  var_24e1eee4a6f213b7[0] setscriptablepartstate("light", color);

  foreach(light in var_633452f052c3d4ba) {
    light setscriptablepartstate("becon_light", color);
  }

  var_24e1eee4a6f213b7[0].ismoving = 0;
}

function function_765136e4fecc97c3(var_8487dbb21cc6a45c) {
  level endon("game_ended");
  level endon("obj_contest_zone_robbed");
  level endon("zone_1_objective_end");

  while(var_8487dbb21cc6a45c > 0) {
    playsoundatpos((-12084, -24703, 5680), "jup_skydiving_zone01_door_alarm_fl");
    playsoundatpos((-12275, -23812, 5680), "jup_skydiving_zone01_door_alarm_fr");
    playsoundatpos((-11552, -23659, 5680), "jup_skydiving_zone01_door_alarm_rl");
    playsoundatpos((-11363, -24544, 5680), "jup_skydiving_zone01_door_alarm_rr");

    if(istrue(level.objectives["_c"].complete)) {
      break;
    }

    var_8487dbb21cc6a45c--;
    var_8487dbb21cc6a45c--;
    wait 2;
  }
}

function function_2825d48b0ba8d908() {
  level endon("game_ended");
  level endon("zone_2" + "_objective_end");
  level thread function_b0ab5d3af5ae8090();
  cables = getEntArray("zone_1_retreat_elevator_cable", "targetname");
  elevatordoors = getEntArray("exit_elevator_door", "script_noteworthy");

  foreach(cable in cables) {
    cable hide();
  }

  foreach(door in elevatordoors) {
    door hide();
  }

  var_d20c313a3b706ddc = getentitylessscriptablearray("scriptable_military_ascendertop_heavy", "classname");

  foreach(ascender in var_d20c313a3b706ddc) {
    ascender setscriptablepartstate("top", "off");
  }

  level.var_53dde20ce19c6235 = &function_96c67c16e4e1963b;
  level.var_72e0f43095476f99 = &function_16421f61ca024019;

  if(getdvarint(@ "scr_game_infilskip", 0) == 0) {
    scripts\mp\flags::gameflagwait("prematch_done");
  }

  foreach(door in elevatordoors) {
    door show();
    door.moverdoesnotkill = 1;
  }

  scripts\mp\flags::function_1240434f4201ac9d("zone_1" + "_objective_end");

  foreach(cable in cables) {
    cable show();
  }

  foreach(ascender in var_d20c313a3b706ddc) {
    ascender setscriptablepartstate("top", "use");
  }

  elevatordoors function_84a85e60d04b1e27(1);
  scripts\mp\flags::function_1240434f4201ac9d("zone_2" + "_objective_start");
  level waittill("zone_2_retreat_truly_finished");
  elevatordoors function_84a85e60d04b1e27(0);
}

function function_96c67c16e4e1963b(instance, player, edgeindex, isvertical, isinverted, isgoingup) {
  if(!istrue(isinverted)) {
    s = spawnStruct();
    s.type = "HINT_NOBUTTON";
    s.string = &"";
    return s;
  }

  return undefined;
}

function function_16421f61ca024019(instance, player, edgeindex, isinverted) {
  if(!istrue(isinverted)) {
    return 0;
  }

  return 1;
}

function function_84a85e60d04b1e27(var_cfa6055065f51e35) {
  if(!isDefined(var_cfa6055065f51e35)) {
    var_cfa6055065f51e35 = 1;
  }

  elevatordoors = self;
  var_5b1f5f16058b8397 = getEntArray("elevator_static_door", "script_noteworthy");
  var_e99c3a562cad4676 = 1;

  if(istrue(var_cfa6055065f51e35)) {
    foreach(door in elevatordoors) {
      var_b5475204a906e54c = ter_op(door.targetname == "left", 1, -1);
      var_ec8d350416c40dcd = anglestoright(door.angles) * 40 * var_b5475204a906e54c;
      var_4182fb045446cdc5 = door.origin + var_ec8d350416c40dcd;
      door moveTo(var_4182fb045446cdc5, var_e99c3a562cad4676, 0.5);
    }

    wait var_e99c3a562cad4676 + 0.5;

    foreach(door in elevatordoors) {
      door notsolid();
    }

    foreach(frame in var_5b1f5f16058b8397) {
      frame notsolid();
    }

    return;
  }

  foreach(door in elevatordoors) {
    var_b5475204a906e54c = ter_op(door.targetname == "left", 1, -1);
    var_ec8d350416c40dcd = anglestoleft(door.angles) * 40 * var_b5475204a906e54c;
    var_4182fb045446cdc5 = door.origin + var_ec8d350416c40dcd;
    door.moverdoesnotkill = 0;
    door moveTo(var_4182fb045446cdc5, var_e99c3a562cad4676, 0.5);
  }

  wait var_e99c3a562cad4676 + 0.5;

  foreach(door in elevatordoors) {
    door solid();
    door.moverdoesnotkill = 1;
  }

  foreach(frame in var_5b1f5f16058b8397) {
    frame solid();
  }
}

function function_b0ab5d3af5ae8090() {
  level endon("game_ended");
  level endon("zone_2" + "_objective_end");
  var_724beadfe7f1b30c = getEnt("set_OOB_immune", "script_noteworthy");
  removetrigger = getEnt("remove_OOB_immune", "script_noteworthy");
  var_86d1df2413175870 = [];
  scripts\mp\flags::function_1240434f4201ac9d("zone_1" + "_objective_end");
  retreatstarttime = gettime();

  while(true) {
    timeused = gettime() - retreatstarttime;

    if(timeused >= 30000) {
      foreach(player in var_86d1df2413175870) {
        player.var_66d6b2345ddc7da8 = undefined;
        player.var_d24048ab5fb37690 = undefined;
      }

      wait 5;
      level notify("zone_2_retreat_truly_finished");
      break;
    }

    var_99ccfc16e1128272 = [];

    foreach(player in level.players) {
      if(is_equal(player.pers["team"], game["attackers"])) {
        continue;
      }

      if(!isalive(player)) {
        player.var_66d6b2345ddc7da8 = 0;
        player.var_d24048ab5fb37690 = undefined;
        continue;
      }

      if(istrue(player.var_66d6b2345ddc7da8)) {
        if(ispointinvolume(player.origin, removetrigger)) {
          player.var_66d6b2345ddc7da8 = 0;
          player.var_d24048ab5fb37690 = undefined;
        } else {
          var_99ccfc16e1128272[var_99ccfc16e1128272.size] = player;
        }

        continue;
      }

      if(ispointinvolume(player.origin, var_724beadfe7f1b30c)) {
        player.var_66d6b2345ddc7da8 = 1;
        var_99ccfc16e1128272[var_99ccfc16e1128272.size] = player;
      }
    }

    var_86d1df2413175870 = var_99ccfc16e1128272;

    foreach(player in var_86d1df2413175870) {
      player.var_d24048ab5fb37690 = 1;
    }

    waitframe();
  }
}

function function_90c5aa738228d4df() {
  level endon("game_ended");
  scripts\mp\flags::function_1240434f4201ac9d("zone_1" + "_objective_end");
  flag_wait_or_timeout("zone_2" + "_objective_end", 20);
  level.retreatend["zone_2"] = 1;
  scripts\mp\flags::function_1240434f4201ac9d("zone_2" + "_objective_end");
  flag_wait_or_timeout("zone_3" + "_objective_end", 20);
  level.retreatend["zone_3"] = 1;
}

function function_64ff7f15870ec86c() {
  level endon("game_ended");

  if(getdvarint(@ "hash_9a49531827cbbaa5", 0)) {
    return;
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  var_8b4d9964a3632abb = getEnt("fallback_destination_trigger_zone_2", "targetname");

  while(true) {
    if(istrue(scripts\mp\flags::gameflag("zone_1" + "_objective_end"))) {
      break;
    }

    foreach(player in level.players) {
      if(player.origin[2] <= 5000 && !istrue(player.var_7fd12290e298a95b)) {
        player thread function_4ea402a6861b8db4(var_8b4d9964a3632abb, 3);
      }
    }

    waitframe();
  }

  foreach(player in level.players) {
    if(ispointinvolume(player.origin, var_8b4d9964a3632abb)) {
      player scripts\mp\gametypes\wm::function_a2d9ea22cacea5e9();
    }
  }

  while(true) {
    if(isDefined(level.retreatend) && istrue(level.retreatend["zone_2"])) {
      break;
    }

    foreach(player in level.players) {
      if(istrue(player.var_a0921327fd546e9)) {
        continue;
      }

      if(ispointinvolume(player.origin, var_8b4d9964a3632abb)) {
        player.var_a0921327fd546e9 = 1;
        continue;
      }

      if(player.origin[2] <= 5000 && !istrue(player.var_7fd12290e298a95b) && !istrue(player.var_d24048ab5fb37690)) {
        player thread function_4ea402a6861b8db4(var_8b4d9964a3632abb);
        player thread function_1d8ed6f710ae98b5(var_8b4d9964a3632abb);
      }
    }

    waitframe();
  }

  foreach(player in level.players) {
    if(player.origin[2] >= 5000 && !istrue(player.var_7fd12290e298a95b)) {
      player thread function_4ea402a6861b8db4(var_8b4d9964a3632abb);
      player thread function_1d8ed6f710ae98b5(var_8b4d9964a3632abb);
    }
  }
}

function function_4ea402a6861b8db4(var_8b4d9964a3632abb, var_13014fb7b021de59) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self.var_7fd12290e298a95b = 1;
  time_limit = ter_op(isDefined(var_13014fb7b021de59), var_13014fb7b021de59, 5);

  if(scripts\mp\utility\player::isreallyalive(self)) {
    scripts\mp\outofbounds::enableoobimmunity(self);
    self.oobtriggertype = 1;
    scripts\mp\gametypes\wm_ui::function_557efb699f50447b(time_limit, undefined);
    thread scripts\mp\gametypes\wm::function_114808366456147a(time_limit);
  }
}

function function_1d8ed6f710ae98b5(var_8b4d9964a3632abb) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  while(!ispointinvolume(self.origin, var_8b4d9964a3632abb)) {
    waitframe();
  }

  self.var_a0921327fd546e9 = 1;
  self notify("left_wmOOB");
  self setclientomnvar("ui_out_of_bounds_type", 0);
  self setclientomnvar("ui_out_of_bounds_countdown", 0);
}

function function_e92f5d2e481565b1() {
  level endon("game_ended");

  foreach(index, zone in level.zones) {
    if(index == "zone_1") {
      continue;
    }

    scripts\mp\flags::gameflagwait(index + "_objective_start");
    var_b89ada9c7c4f7ab0 = function_acf2f75c0fa08edc(index);
    function_996ac0eb7587bc95();

    foreach(player in level.players) {
      player thread function_e8c580cd4ea3ba34(var_b89ada9c7c4f7ab0, index);
    }

    level thread function_856103351944a41b(var_b89ada9c7c4f7ab0, index);
    level thread function_8570f609d1b5ad56(var_b89ada9c7c4f7ab0, index);
    level thread function_5cb1c4f04a3cb5ca(index);
  }
}

function function_996ac0eb7587bc95() {
  foreach(player in level.players) {
    player.var_c18d4c0351800d9a = 0;
    player.var_cff8ac1d2f02680b = 0;
    player.var_6f250da77d3bd5ac = 0;
  }
}

function function_5cb1c4f04a3cb5ca(var_84f7e39587f529c4) {
  level endon("game_ended");
  level endon(var_84f7e39587f529c4 + "_objective_end");

  foreach(objstr in level.zone.objectives) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.objectives[objstr].objidnum);
  }

  if(var_84f7e39587f529c4 == "zone_2" && !isDefined(level.escortvehicles[0])) {
    level waittill("wheelson_spawn");
  }

  while(true) {
    if(isDefined(level.retreatend) && istrue(level.retreatend[var_84f7e39587f529c4])) {
      break;
    }

    foreach(player in level.players) {
      if(istrue(player.var_cff8ac1d2f02680b) && !istrue(player.var_6f250da77d3bd5ac)) {
        foreach(objstr in level.zone.objectives) {
          if(!istrue(level.objectives[objstr].complete)) {
            scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.objectives[objstr].objidnum, player);
          }
        }

        player.var_6f250da77d3bd5ac = 1;
      }
    }

    waitframe();
  }

  foreach(objstr in level.zone.objectives) {
    if(!istrue(level.objectives[objstr].complete)) {
      scripts\mp\objidpoolmanager::objective_playermask_showtoall(level.objectives[objstr].objidnum);
    }
  }
}

function function_8570f609d1b5ad56(var_b89ada9c7c4f7ab0, index) {
  level endon("game_ended");
  level endon(index + "_objective_end");

  while(true) {
    level waittill("player_spawned", player);

    if(isDefined(level.retreatend) && istrue(level.retreatend[index])) {
      break;
    }

    if(!istrue(player.var_c18d4c0351800d9a)) {
      player thread function_e8c580cd4ea3ba34(var_b89ada9c7c4f7ab0, index);
    }
  }
}

function function_856103351944a41b(indicators, var_84f7e39587f529c4) {
  level endon("game_ended");

  while(!isDefined(level.retreatend) || !istrue(level.retreatend[var_84f7e39587f529c4])) {
    waitframe();
  }

  foreach(indicator in indicators) {
    indicator scripts\mp\gameobjects::releaseid();
  }
}

function function_e8c580cd4ea3ba34(indicators, var_84f7e39587f529c4) {
  level endon("game_ended");
  self endon("disconnect");
  self.var_c18d4c0351800d9a = 1;
  self setclientomnvar("ui_wm_objective_show_match_status", 0);
  cornera = getStruct("transition_corner_a", "script_noteworthy");
  cornerb = getStruct("transition_corner_b", "script_noteworthy");
  var_7ba531e5cc4cd455 = getStruct("transition_corner_c", "script_noteworthy");
  var_7ba52ae5cc4cc4f0 = getStruct("transition_corner_d", "script_noteworthy");

  if(var_84f7e39587f529c4 == "zone_2") {
    if(is_equal(self.pers["team"], game["attackers"])) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(indicators[0].objidnum, self);
    } else {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(indicators[1].objidnum, self);
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(indicators[2].objidnum, self);
    }
  } else {
    foreach(indicator in indicators) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(indicator.objidnum, self);
    }
  }

  if(var_84f7e39587f529c4 == "zone_2") {
    while(indicators[0].origin[2] - self.origin[2] < 400) {
      waitframe();
    }
  } else {
    while(true) {
      if(!scripts\common\elevators::function_cba565314ac6a79e(self.origin, cornera.origin, cornerb.origin, var_7ba531e5cc4cd455.origin, var_7ba52ae5cc4cc4f0.origin)) {
        if(indicators[0].origin[2] - self.origin[2] > 400) {
          break;
        }
      } else {
        break;
      }

      waitframe();
    }
  }

  if(var_84f7e39587f529c4 != "zone_3") {
    self setclientomnvar("ui_wm_objective_show_match_status", 1);
  }

  foreach(ent in indicators) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(ent.objidnum, self);
  }

  self.var_cff8ac1d2f02680b = 1;
}

function function_acf2f75c0fa08edc(var_84f7e39587f529c4) {
  var_b89ada9c7c4f7ab0 = [];

  if(var_84f7e39587f529c4 == "zone_2") {
    var_b89ada9c7c4f7ab0[0] = spawn("script_model", (-11828, -24228, 5100));
    var_b89ada9c7c4f7ab0[1] = spawn("script_model", (-13779, -24301, 5300));
    var_b89ada9c7c4f7ab0[2] = spawn("script_model", (-13646, -24870, 5300));
  } else {
    var_e9caac83c9b4cc34 = getStructArray("jump_down_indicator", "script_noteworthy");

    foreach(struct in var_e9caac83c9b4cc34) {
      var_b89ada9c7c4f7ab0[var_b89ada9c7c4f7ab0.size] = spawn("script_model", struct.origin);
    }
  }

  foreach(i, ent in var_b89ada9c7c4f7ab0) {
    ent.curorigin = ent.origin;
    ent.offset3d = (0, 0, 80);
    ent scripts\mp\gameobjects::requestid(1, 0, undefined, 1);
    objid = ent.objidnum;

    if(var_84f7e39587f529c4 == "zone_2") {
      if(i == 0) {
        scripts\mp\objidpoolmanager::update_objective_ownerteam(objid, game["attackers"]);
      } else {
        scripts\mp\objidpoolmanager::update_objective_ownerteam(objid, game["defenders"]);
      }
    } else {
      scripts\mp\objidpoolmanager::update_objective_ownerteam(objid, game["attackers"]);
    }

    scripts\mp\objidpoolmanager::update_objective_icon(objid, "icon_waypoint_ied_plant");
    scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
    scripts\mp\objidpoolmanager::function_9cad42ac02eff950(objid);

    if(var_84f7e39587f529c4 == "zone_2") {
      if(i == 0) {
        scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(objid, &"MP_JUP_LAUNCHFACILITY/JUMP_DOWN_ATTACKER");
      } else {
        scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(objid, &"MP_JUP_SKYDIVING/DESCEND_NOW");
      }
    } else {
      scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(objid, &"MP_JUP_LAUNCHFACILITY/JUMP_DOWN_ATTACKER");
      scripts\mp\objidpoolmanager::update_objective_setenemylabel(objid, &"MP_JUP_LAUNCHFACILITY/JUMP_DOWN_ATTACKER");
    }

    scripts\mp\objidpoolmanager::update_objective_state(objid, "current");
  }

  return var_b89ada9c7c4f7ab0;
}

function function_28c9bb84699d73b2() {
  isinit = level scripts\mp\gametypes\wm_buildable::function_e2344ec3f70a089c();

  if(istrue(isinit)) {
    namespace_555f6ee22fb8fd82::function_e5c4e335df2843c();
    namespace_555f6ee22fb8fd82::function_61359962e417f21();
    namespace_555f6ee22fb8fd82::function_566826c5ccdd0270();
    namespace_555f6ee22fb8fd82::function_b4ebcfb94d5a02a6();
    namespace_555f6ee22fb8fd82::function_d010329c992047c7();
    level.buildablepool["bdb_earthen_wall"].canmantle = 0;
    namespace_555f6ee22fb8fd82::function_e688c950f545c6dc();
    namespace_555f6ee22fb8fd82::function_a622792cc81eaea2();
    namespace_555f6ee22fb8fd82::function_4f6fdee5d536dbc6();
    level namespace_555f6ee22fb8fd82::function_43a60391e95332e();
    level namespace_555f6ee22fb8fd82::function_714ca74c07bcc71c();
    level namespace_555f6ee22fb8fd82::function_259b94f62f15b4be();
    level namespace_555f6ee22fb8fd82::function_60897351370d2636();
    level._effect["sandbag_built"] = loadfx("vfx/jup/level/mp_jup_launchfacility/vfx_jup_lf_sandbags_debris_02.vfx");
    level._effect["turret_fixed"] = loadfx("vfx/jup/level/mp_jup_launchfacility/vfx_jup_lf_machinegun_repaired_glow.vfx");
  }
}

function function_b9730bfe1e8b9f81() {
  level endon("game_ended");
  level waittill("matchStartTimer_done");
  scripts\mp\flags::function_1240434f4201ac9d("zone_3_objective_start");
  level thread namespace_d99736a82ac4e63b::radiation_start();
}

function function_2d6d7d97de343d0f() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("zone_2_objective_start");

  if(istrue(level.enablezombie) && istrue(level.var_8034530507c48231)) {
    var_3630956db3be458c = getStructArray("raygun", "script_noteworthy");

    if(isDefined(var_3630956db3be458c)) {
      foreach(var_4c447da4cc7b9037 in var_3630956db3be458c) {
        function_ce8588d31df66dd8(var_4c447da4cc7b9037.origin, var_4c447da4cc7b9037.angles, 1);
      }
    }

    return;
  }

  var_3630956db3be458c = getStructArray("rgl_80", "script_noteworthy");

  if(isDefined(var_3630956db3be458c)) {
    foreach(var_4c447da4cc7b9037 in var_3630956db3be458c) {
      function_ec8a443fe8165fe4("jup_jp26_la_mike32_mp", var_4c447da4cc7b9037.origin, [], var_4c447da4cc7b9037.angles, 1);
    }
  }
}

function function_90371f43aad9292a() {
  level endon("game_ended");

  foreach(side in ["attackers", "defenders"]) {
    for(i = 0; i < 2; i++) {
      var_313cc7f0af1986d3[i][side] = getEntArray("zone2_lines_stage_" + i + "_" + side, "targetname");
      var_a89c46af827461f6[i][side] = getEntArray("zone3_lines_stage_" + i + "_" + side, "targetname");
      var_dcc19d04090b463f[i][side] = getEnt("zone2_boundary_stage_" + i + "_" + side, "targetname");
      var_7e01f1f27883d50e[i][side] = getEnt("zone3_boundary_stage_" + i + "_" + side, "targetname");

      if(isDefined(var_dcc19d04090b463f[i][side])) {
        var_dcc19d04090b463f[i][side].side = side;
      }

      if(isDefined(var_7e01f1f27883d50e[i][side])) {
        var_7e01f1f27883d50e[i][side].side = side;
      }
    }
  }

  scripts\mp\flags::gameflagwait("zone_2" + "_objective_start");
  function_e7d2bd03a0c17f96(var_313cc7f0af1986d3[0], undefined, 0);
  level waittill("escort_vehicle_checkpoint_2");
  function_e7d2bd03a0c17f96(var_313cc7f0af1986d3[1], var_dcc19d04090b463f[1], 0);
  scripts\mp\gametypes\wm::function_9fb7ca43ba3b6784("obj_2", "stage_1");
  scripts\mp\flags::gameflagwait("zone_3" + "_objective_start");
  function_e7d2bd03a0c17f96(var_a89c46af827461f6[0], undefined, 0);
  level waittill("captureflag_device_deployed");
  function_e7d2bd03a0c17f96(var_a89c46af827461f6[1], var_7e01f1f27883d50e[1], 0);
  scripts\mp\gametypes\wm::function_9fb7ca43ba3b6784("obj_3", "stage_1");
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

function function_dce86aec5b302384() {
  level endon("game_ended");
  level waittill("captureflag_device_deployed");
  namespace_d99736a82ac4e63b::function_b04fbceae9e9a1f2();
}

function function_602c658374655858(vehicle) {
  var_5beb550b14979da6 = 5;
  var_2946f1f5b9485f68 = [];

  for(i = 0; i < var_5beb550b14979da6; i++) {
    name = "check_point_" + i;
    var_a1cf1ca2c44eca8b = getvehiclenode(name, "script_noteworthy");

    if(isDefined(var_a1cf1ca2c44eca8b)) {
      assert(isDefined(var_a1cf1ca2c44eca8b.progress));
      var_a1cf1ca2c44eca8b.visible = 1;
      var_2946f1f5b9485f68[i] = var_a1cf1ca2c44eca8b;

      if(name == "check_point_1") {
        var_a1cf1ca2c44eca8b.visible = 0;
      }
    }
  }

  return var_2946f1f5b9485f68;
}

function function_bc36ba717880033c() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("zone_1" + "_objective_end");
  var_795e67d6e6be2a3c = getEnt("zone2", "script_noteworthy");

  if(!isDefined(var_795e67d6e6be2a3c)) {
    return;
  }

  assertex(isDefined(var_795e67d6e6be2a3c.script_floor_number), "<dev string:x1c>");

  while(true) {
    waitframe();

    foreach(player in level.players) {
      if(isalive(player) && !istrue(player.var_9b713d24bdb6d97f) && player istouching(var_795e67d6e6be2a3c)) {
        player function_fb7bad834ce4b28c(var_795e67d6e6be2a3c.script_floor_number, "zone_2");
        player.var_9b713d24bdb6d97f = 1;
      }
    }
  }
}

function function_14e9a0244a570ff6() {
  level endon("game_ended");
  var_f34b4b2f93de2e65 = getEntArray("trigger_hurt_zone" + 1, "targetname");
  var_8db1224543207c9c = getEntArray("trigger_hurt_zone" + 2, "targetname");
  var_f8ed772ba77bbb5f = getEntArray("trigger_hurt_zone" + 3, "targetname");
  level function_fc626277bab0c689(var_8db1224543207c9c);
  level function_fc626277bab0c689(var_f8ed772ba77bbb5f);
  scripts\mp\flags::gameflagwait("zone_2" + "_objective_start");
  level function_fc626277bab0c689(var_f34b4b2f93de2e65);
  level function_d06a757de49b167c(var_8db1224543207c9c);
  scripts\mp\flags::gameflagwait("zone_3" + "_objective_start");
  level function_fc626277bab0c689(var_8db1224543207c9c);
  level function_d06a757de49b167c(var_f8ed772ba77bbb5f);
  level waittill("start_game_ended");
  level function_fc626277bab0c689(var_f8ed772ba77bbb5f);
}

function function_d06a757de49b167c(trigger_array) {
  foreach(trigger in trigger_array) {
    trigger.origin = trigger.originalpos;
    trigger trigger_on();
  }
}

function function_fc626277bab0c689(trigger_array) {
  foreach(trigger in trigger_array) {
    trigger.originalpos = trigger.origin;
    trigger.origin -= (0, 0, 10000);
    trigger trigger_off();
  }
}

function function_fd3c293d8f2b219e() {
  level endon("game_ended");
  var_61523ce476fc10e3 = getdvarint(@ "hash_466dcdf9da2b1cfc", 1) == 1;

  if(!istrue(var_61523ce476fc10e3)) {
    return;
  }

  level thread function_61559e3ffa6ff01e();
  level thread function_a258cbe71c26c6b();
  level thread function_a7b9407940a23b9c();
}

function function_61559e3ffa6ff01e() {
  level endon("game_ended");
  enable = getdvarint(@ "hash_95dc6472527d97ca", 1) == 1;

  if(istrue(enable)) {
    level waittill("matchStartTimer_done");
    var_64c0dd127fab03a4 = getdvarint(@ "hash_e3c1bfbfb075cd0a", 30);

    if(var_64c0dd127fab03a4 > 0) {
      wait var_64c0dd127fab03a4;
    }

    scripts\mp\gametypes\wm::function_48cad4789e694e53();
  }
}

function function_a258cbe71c26c6b() {
  level endon("game_ended");
  enable = getdvarint(@ "hash_497e249d641e0e63", 1) == 1;

  if(istrue(enable)) {
    scripts\mp\flags::gameflagwait("zone_2" + "_objective_start");
    wait 20;
    scripts\mp\gametypes\wm::function_48cad4789e694e53();
  }
}

function function_a7b9407940a23b9c() {
  level endon("game_ended");
  enable = getdvarint(@ "hash_b9d6c777d1f1f58c", 1) == 1;

  if(istrue(enable)) {
    scripts\mp\flags::gameflagwait("zone_3" + "_objective_start");
    wait 20;
    scripts\mp\gametypes\wm::function_48cad4789e694e53();
  }
}

function function_ccd8a337aae472de(nodeorigin, range) {
  var_652a66e0975580eb = getentarrayinradius(undefined, undefined, nodeorigin, range);

  if(isDefined(level.var_673860e74c8ec9d1)) {
    foreach(trigger in level.var_673860e74c8ec9d1) {
      trigger scripts\mp\gametypes\wm_utility::function_51039de6a7a95d10(var_652a66e0975580eb);
    }
  }
}

function function_a5f8312fdbf97755() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("zone_2" + "_objective_start");
  var_e641696b925ca657 = getStructArray("spawn_trap_cover", "targetname");

  foreach(cover in var_e641696b925ca657) {
    spawn_model(cover.script_noteworthy, cover.origin, cover.angles);
  }
}

function private function_e27bc4a5e8e27440() {
  level.sentrysettings["bs_laser"].ignoreownerteam = 1;
  level.sentrysettings["bs_laser"].var_b58e018f63b5d93b = 0;
  level.sentrysettings["bs_laser"].laserexplosion = 0;
  level.sentrysettings["bs_laser"].trapdamageweapon = "jup_c4_mp";
  level.sentrysettings["bs_laser"].trapmeansofdeath = "MOD_GRENADE";
  level.sentrysettings["bs_laser"].trapmindamage = 100;
  level.sentrysettings["bs_laser"].trapmaxdamage = 200;
  level.sentrysettings["bs_laser"].var_bd106a486cdfd461 = 384;
}

function private function_62247a3afa8950b6() {
  for(idx = 1; idx <= 3; idx++) {
    var_64c417244bd50932 = getEntArray("trigger_hurt_zone" + idx, "targetname");
    level function_fc626277bab0c689(var_64c417244bd50932);
  }
}

function private function_7a49dcb707410ca2(params) {
  if(!istrue(level.enablezombie) || !getdvarint(@ "hash_e10575de97288b22", 1)) {
    return;
  }

  level notify("wm_stop_zombie_spawn");
  all_zombies = getaiarray("team_two_hundred");

  foreach(zombie in all_zombies) {
    if(!isDefined(zombie) || !isalive(zombie)) {
      continue;
    }

    zombie dodamage(zombie.health + 150, zombie.origin);
    waitframe();
  }
}

function private function_c294f9788942533b(params) {
  if(!isDefined(level.buildables)) {
    return;
  }

  foreach(var_341059c86e3a7310 in level.buildables) {
    var_341059c86e3a7310 function_1c548268f36ed307();
  }
}

function function_7d25484659308d59() {
  level endon("game_ended");
  ents = getEntArray("tri_build_hesco", "targetname");
  var_febb042dd9982690 = getStruct(ents[0].target, "targetname");
  var_c96dc31f024483a8 = getEntArray(var_febb042dd9982690.target, "targetname");

  foreach(clip in var_c96dc31f024483a8) {
    if(!isDefined(clip.script_parameters)) {
      clip.initialposition = clip.origin;
      clip.var_caf3e3fb4a14b329 = clip.angles;
      clip solid();
      clip.origin = (-11158, -31979, 1863);
      clip.angles = (0, 8.3, 0);
      clip disconnectPaths();
      clip notsolid();
      clip.origin = clip.initialposition;
      clip.angles = clip.var_caf3e3fb4a14b329;
    }
  }
}

function setupminimap(material, var_11f306b80ae0c39e, numtiles, zonename) {
  requiredmapaspectratio = getdvarfloat(@ "scr_requiredmapaspectratio", 1);
  mapinfo = getmapscriptbundle();

  if(isDefined(mapinfo) && isDefined(mapinfo.var_cea11b0bd8f76b2d)) {
    foreach(minimapversion in mapinfo.var_cea11b0bd8f76b2d) {
      if(minimapversion.gametype == scripts\mp\utility\game::getgametype()) {
        material = minimapversion.var_bf768d8db892be1b;
      }
    }
  }

  if(!isDefined(material)) {
    material = "";
  }

  if(!isDefined(var_11f306b80ae0c39e)) {
    var_11f306b80ae0c39e = material;
  }

  corners = [];
  allcorners = getEntArray("minimap_corner", "targetname");

  foreach(corner in allcorners) {
    if(corner.script_noteworthy == zonename) {
      corners[corners.size] = corner;
    }
  }

  if(corners.size != 2) {
    println("<dev string:x57>");
    return;
  }

  corner0 = (corners[0].origin[0], corners[0].origin[1], 0);
  corner1 = (corners[1].origin[0], corners[1].origin[1], 0);
  cornerdiff = corner1 - corner0;
  north = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  west = (0 - north[1], north[0], 0);

  if(vectordot(cornerdiff, west) > 0) {
    if(vectordot(cornerdiff, north) > 0) {
      northwest = corner1;
      southeast = corner0;
    } else {
      side = scripts\mp\compass::vecscale(north, vectordot(cornerdiff, north));
      northwest = corner1 - side;
      southeast = corner0 + side;
    }
  } else if(vectordot(cornerdiff, north) > 0) {
    side = scripts\mp\compass::vecscale(north, vectordot(cornerdiff, north));
    northwest = corner0 + side;
    southeast = corner1 - side;
  } else {
    northwest = corner0;
    southeast = corner1;
  }

  if(requiredmapaspectratio > 0) {
    northportion = vectordot(northwest - southeast, north);
    westportion = vectordot(northwest - southeast, west);
    mapaspectratio = westportion / northportion;

    if(mapaspectratio < requiredmapaspectratio) {
      incr = requiredmapaspectratio / mapaspectratio;
      addvec = scripts\mp\compass::vecscale(west, westportion * (incr - 1) * 0.5);
    } else {
      incr = mapaspectratio / requiredmapaspectratio;
      addvec = scripts\mp\compass::vecscale(north, northportion * (incr - 1) * 0.5);
    }

    northwest += addvec;
    southeast -= addvec;
  }

  corners[0].origin = northwest;
  corners[1].origin = southeast;
  level.mapsize = vectordot(northwest - southeast, north);
  level.mapcorners = corners;
  level.mapcorners[0].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[1].origin - level.mapcorners[0].origin), (0, 0, 1));
  level.mapcorners[0] addyaw(45);
  level.mapcorners[1].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[0].origin - level.mapcorners[1].origin), (0, 0, 1));
  level.mapcorners[1] addyaw(45);

  if(!isDefined(numtiles) || numtiles < 1) {
    numtiles = 1;
  }

  level.minimapmaterial = material;

  setminimap(material, northwest[0], northwest[1], southeast[0], southeast[1], numtiles, var_11f306b80ae0c39e);
}

function function_fb7bad834ce4b28c(floornumber, zonename) {
  self setclientomnvar("ui_minimap_floor", floornumber);
  map_name = tolower(getDvar(@ "ui_mapname"));
  minimap_image = "compass_map_" + map_name + "_floor_" + floornumber;
  self.var_109a3bfd035f27be = floornumber;
  setupminimap(minimap_image, undefined, undefined, zonename);
}

function function_e393d662064dffce() {
  level endon("<dev string:xbd>");
  level waittill("<dev string:xcb>", zone_name);

  if(zone_name != "<dev string:xe6>") {
    return;
  }

  roofs = getEntArray("<dev string:xf0>", "<dev string:xfe>");
  var_797f676eac2f5f5d = getStructArray("<dev string:x10c>", "<dev string:xfe>");
  var_24e1eee4a6f213b7 = getentitylessscriptablearray("<dev string:x11b>", "<dev string:x12e>");
  var_633452f052c3d4ba = getscriptablearray("<dev string:x143>", "<dev string:x12e>");
  function_c8a59331ffa83829(roofs, var_797f676eac2f5f5d, var_24e1eee4a6f213b7, 1, var_633452f052c3d4ba);
}

function function_1e57e0eff0416516() {
  level endon("<dev string:xbd>");
  level waittill("<dev string:x151>");

  while(true) {
    teamidx = getdvarint(@ "hash_cb0271966982116a", -1);

    if(teamidx != -1) {
      setDvar(@ "hash_cb0271966982116a", -1);
    }

    if(teamidx == 0) {
      scripts\mp\gametypes\wm_ending::function_cc892bd20a432474(game["<dev string:x162>"]);
    } else if(teamidx == 1) {
      scripts\mp\gametypes\wm_ending::function_cc892bd20a432474(game["<dev string:x16f>"]);
    }

    waitframe();
  }
}

# /