/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\mp_nuketown_x.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_destructible;
#using scripts\mp\_load;
#using scripts\mp\_nuketown_mannequin;
#using scripts\mp\_util;
#using scripts\mp\mp_nuketown_x_fx;
#using scripts\mp\mp_nuketown_x_sound;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\compass;
#using scripts\shared\exploder_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;
#namespace mp_nuketown_x;

function autoexec init() {
  level._enablelastvalidposition = 1;
}

function main() {
  clientfield::register("scriptmover", "nuketown_population_ones", 1, 4, "int");
  clientfield::register("scriptmover", "nuketown_population_tens", 1, 4, "int");
  clientfield::register("world", "nuketown_endgame", 1, 1, "int");
  precache();
  namespace_6044bb60::main();
  namespace_4cda09f7::main();
  level.remotemissile_kill_z = -175 + 50;
  level.team_free_targeting = 1;
  level.update_escort_robot_path = &update_escort_robot_path;
  load::main();
  compass::setupminimap("compass_map_mp_nuketown_x");
  setDvar("compassmaxrange", "2100");
  level.levelescortdisable = [];
  level.levelescortdisable[level.levelescortdisable.size] = spawn("trigger_radius", (749, 872, -112.5), 0, 150, 128);
  level.levelescortdisable[level.levelescortdisable.size] = spawn("trigger_radius", (868, 909.5, -112.5), 0, 150, 128);
  level.levelescortdisable[level.levelescortdisable.size] = spawn("trigger_radius", (968, 894.5, -112.5), 0, 100, 128);
  level.levelescortdisable[level.levelescortdisable.size] = spawn("trigger_radius", (1009, 902, -112.5), 0, 100, 128);
  level.end_game_video = spawnStruct();
  level.end_game_video.name = "mp_nuketown_fs_endingmovie";
  level.end_game_video.duration = 5;
  level.headless_mannequin_count = 0;
  level.var_ce9a2d1f = 0;
  level.destructible_callbacks["headless"] = &mannequin_headless;
  level.destructible_callbacks["right_arm_lower"] = &function_2b3d2035;
  level.destructible_callbacks["right_arm_upper"] = &function_33cfa2;
  level.destructible_callbacks["left_arm_lower"] = &function_576ab778;
  level.destructible_callbacks["left_arm_upper"] = &function_952db647;
  level thread function_33a60aeb();
  level.cleandepositpoints = array((21.4622, 133.075, -65.875), (976.601, 630.604, -56.875), (-787.35, 508.411, -59.875), (32.424, 952.018, -60.875));
  level thread nuked_mannequin_init();
  level thread function_8d1f7bc9();
  level function_c2bbb7df();
}

function function_8d1f7bc9() {
  var_3976bfdf = getEntArray("counter_tens", "targetname");
  var_cdcdc7c6 = getEntArray("counter_ones", "targetname");
  var_f91396f2 = var_3976bfdf[0];
  var_1ab267f1 = var_cdcdc7c6[0];
  level.var_3e9c9ee4 = 0;
  level.var_49ae1c91 = 0;
  while(true) {
    players = getplayers();
    actors = getactorarray();
    count = 0;
    foreach(player in players) {
      if(isalive(player)) {
        count++;
      }
    }
    foreach(actor in actors) {
      if(isalive(actor)) {
        count++;
      }
    }
    level.var_f8f449e5 = int(floor(count / 10));
    level.var_310f9038 = count % 10;
    if(level.var_3e9c9ee4 != level.var_f8f449e5) {
      var_f91396f2 clientfield::set("nuketown_population_tens", level.var_f8f449e5);
    }
    if(level.var_49ae1c91 != level.var_310f9038) {
      var_1ab267f1 clientfield::set("nuketown_population_ones", level.var_310f9038);
    }
    level.var_3e9c9ee4 = level.var_f8f449e5;
    level.var_49ae1c91 = level.var_310f9038;
    wait(0.05);
  }
}

function precache() {}

function function_c2bbb7df() {
  mapname = getdvarstring("");
  adddebugcommand(("" + mapname) + "");
  adddebugcommand(("" + mapname) + "");
  adddebugcommand(("" + mapname) + "");
  level thread function_eaf0b837();
}

function function_cadef408() {
  while(true) {
    level waittill("hash_cadef408");
    if(isDefined(level.end_game_video)) {
      level lui::play_movie_with_timeout(level.end_game_video.name, "fullscreen", level.end_game_video.duration, 1);
    }
  }
}

function function_eaf0b837() {
  level thread function_9071119b();
  level thread function_38b51a9e();
  level thread function_cadef408();
}

function function_9071119b() {
  var_825f4dc3 = struct::get_array("endgame_camera");
  camerastart = var_825f4dc3[0];
  if(!isDefined(camerastart)) {
    camerastart = spawnStruct();
    camerastart.origin = (-200, -167, 15);
    camerastart.angles = vectorscale((0, -1, 0), 81);
  }
  for(;;) {
    camera = spawn("script_model", camerastart.origin);
    camera.angles = camerastart.angles;
    camera setModel("tag_origin");
    level waittill("hash_ba6eb569");
    var_2ef11df4 = getEntArray("hide_end_game_sequence", "script_noteworthy");
    foreach(var_4c401d78 in var_2ef11df4) {
      var_4c401d78 hide();
    }
    clientfield::set("nuketown_endgame", 1);
    players = getplayers();
    foreach(player in players) {
      player camerasetposition(camera);
      player camerasetlookat();
      player cameraactivate(1);
      player setdepthoffield(0, 128, 7000, 10000, 6, 1.8);
    }
    wait(2);
    exploder::exploder("nuketown_derez_explosion");
    level thread run_scene("p7_fxanim_mp_nukex_derez_bridge_bundle");
    level thread run_scene("p7_fxanim_mp_nukex_end_derezzing_tree_bundle");
  }
}

function function_38b51a9e() {
  for(;;) {
    level waittill("hash_71410924");
    var_2ef11df4 = getEntArray("hide_end_game_sequence", "script_noteworthy");
    foreach(var_4c401d78 in var_2ef11df4) {
      var_4c401d78 show();
    }
    clientfield::set("nuketown_endgame", 0);
    exploder::stop_exploder("nuketown_derez_explosion");
    level thread init_scene("p7_fxanim_mp_nukex_derez_bridge_bundle");
    level thread init_scene("p7_fxanim_mp_nukex_end_derezzing_tree_bundle");
  }
}

function run_scene(str_scene) {
  b_found = 0;
  str_mode = tolower(getdvarstring("scene_menu_mode", "default"));
  a_scenes = struct::get_array(str_scene, "scriptbundlename");
  foreach(s_instance in a_scenes) {
    if(isDefined(s_instance)) {
      if(!isinarray(a_scenes, s_instance)) {
        b_found = 1;
        s_instance thread scene::play(undefined, undefined, undefined, 1, undefined, str_mode);
      }
    }
  }
  if(isDefined(level.active_scenes[str_scene])) {
    foreach(s_instance in level.active_scenes[str_scene]) {
      b_found = 1;
      s_instance thread scene::play(str_scene, undefined, undefined, 1, undefined, str_mode);
    }
  }
}

function init_scene(str_scene) {
  str_mode = tolower(getdvarstring("scene_menu_mode", "default"));
  b_found = 0;
  a_scenes = struct::get_array(str_scene, "scriptbundlename");
  foreach(s_instance in a_scenes) {
    if(isDefined(s_instance)) {
      b_found = 1;
      s_instance thread scene::init(undefined, undefined, undefined, 1);
    }
  }
  if(!b_found) {
    level.scene_test_struct thread scene::init(str_scene, undefined, undefined, 1);
  }
}

function nuked_mannequin_init() {
  keep_count = 28;
  level.mannequin_count = 0;
  destructibles = getEntArray("destructible", "targetname");
  mannequins = nuked_mannequin_filter(destructibles);
  if(mannequins.size <= 0) {
    return;
  }
  arrayremovevalue(mannequins, undefined);
  var_c5761915 = 0;
  for(i = 0; i < mannequins.size; i++) {
    if("p7_dest_ntx_mannequin_female_04_purple_ddef" == mannequins[i].destructibledef) {
      collision = getent(mannequins[i].target, "targetname");
      assert(isDefined(collision));
      collision delete();
      mannequins[i] delete();
      level.mannequin_count--;
      var_c5761915++;
    }
    if(!isDefined(mannequins[i])) {
      continue;
    }
    assert(isDefined(mannequins[i].target));
    if(level.gametype == "dem" || level.gametype == "dom") {
      if(mannequins[i].target == "pf1160_auto1" || mannequins[i].target == "pf1179_auto1") {
        collision = getent(mannequins[i].target, "targetname");
        assert(isDefined(collision));
        collision delete();
        mannequins[i] delete();
        level.mannequin_count--;
        var_c5761915++;
      }
    }
  }
  level.mannequin_count = mannequins.size;
  remove_count = (mannequins.size - keep_count) - var_c5761915;
  remove_count = math::clamp(remove_count, 0, remove_count);
  mannequins = array::randomize(mannequins);
  for(i = 0; i < mannequins.size; i++) {
    if(!isDefined(mannequins[i])) {
      continue;
    }
    assert(isDefined(mannequins[i].target));
    if(i < remove_count) {
      collision = getent(mannequins[i].target, "targetname");
      assert(isDefined(collision));
      collision delete();
      mannequins[i] delete();
      level.mannequin_count--;
      continue;
    }
    mannequins[i] disconnectpaths();
  }
  arrayremovevalue(mannequins, undefined);
  level.mannequins = mannequins;
  level waittill("prematch_over");
  level.mannequin_time = gettime();
  function_5fdaba50();
  if(getdvarint("nuketown_mannequin", 0)) {
    level thread function_3c0e90cb(0);
  }
}

function function_5fdaba50() {
  level.var_fd975a01 = [];
  level.var_b8fc7cc7 = [];
  destructibles = getEntArray("destructible", "targetname");
  mannequins = nuked_mannequin_filter(destructibles);
  foreach(mannequin in mannequins) {
    level.var_fd975a01[level.var_fd975a01.size] = mannequin.origin;
    level.var_b8fc7cc7[level.var_b8fc7cc7.size] = mannequin.angles;
  }
  mapname = getdvarstring("");
  adddebugcommand(("" + mapname) + "");
  adddebugcommand(("" + mapname) + "");
  adddebugcommand(("" + mapname) + "");
  level thread function_339cd93d();
  level thread function_599f53a6();
  level thread function_d77bb766();
}

function private function_66d1dfaa() {
  destructibles = getEntArray("destructible", "targetname");
  mannequins = nuked_mannequin_filter(destructibles);
  foreach(mannequin in mannequins) {
    mannequin connectpaths();
    collision = getent(mannequin.target, "targetname");
    collision delete();
    mannequin delete();
  }
}

function private function_6ac7b21() {
  level notify("hash_d4fbdcde");
  mannequins = getaiarchetypearray("mannequin");
  foreach(mannequin in mannequins) {
    mannequin kill();
  }
}

function private function_ad600192() {
  level notify("hash_ad600192");
  level endon("hash_ad600192");
  while(true) {
    if(!function_4b855423()) {
      function_6ac7b21();
      return;
    }
    wait(0.05);
  }
}

function private function_e20b8430(weepingangel) {
  level endon("hash_d4fbdcde");
  level thread function_ad600192();
  if(isDefined(level.var_fd975a01)) {
    function_66d1dfaa();
    for(index = 0; index < level.var_fd975a01.size; index++) {
      origin = level.var_fd975a01[index];
      angles = level.var_b8fc7cc7[index];
      gender = (randomint(2) ? "male" : "female");
      mannequin = nuketownmannequin::spawnmannequin(origin, angles, gender, undefined, weepingangel);
      wait(0.05);
    }
  }
  if(weepingangel) {
    level thread nuketownmannequin::watch_player_looking();
  }
}

function private function_3c0e90cb(weepingangel) {
  level endon("hash_d4fbdcde");
  function_e20b8430(weepingangel);
  while(1 && isDefined(level.var_fd975a01)) {
    mannequins = getaiarchetypearray("mannequin");
    if(mannequins.size < level.var_fd975a01.size) {
      index = randomint(level.var_fd975a01.size);
      origin = level.var_fd975a01[index];
      angles = level.var_b8fc7cc7[index];
      gender = (randomint(2) ? "male" : "female");
      mannequin = nuketownmannequin::spawnmannequin(origin, angles, gender, undefined, weepingangel);
    }
    wait(0.1);
  }
}

function private function_339cd93d() {
  while(true) {
    level waittill("hash_42cf0b29");
    function_6ac7b21();
    function_e20b8430(0);
  }
}

function private function_599f53a6() {
  while(true) {
    level waittill("hash_68d18592");
    function_6ac7b21();
    function_e20b8430(1);
  }
}

function private function_d77bb766() {
  while(true) {
    level waittill("mannequin_force_cleanup");
    function_6ac7b21();
  }
}

function nuked_mannequin_filter(destructibles) {
  mannequins = [];
  for(i = 0; i < destructibles.size; i++) {
    destructible = destructibles[i];
    if(issubstr(destructible.destructibledef, "male")) {
      mannequins[mannequins.size] = destructible;
      level.mannequin_count++;
    }
  }
  return mannequins;
}

function mannequin_headless(notifytype, attacker, weapon) {
  if(gettime() < (level.mannequin_time + (getdvarint("mannequin_timelimit", 120) * 1000))) {
    level.headless_mannequin_count++;
    if(level.headless_mannequin_count == getdvarint("mannequin_headless_count", 28)) {
      level thread function_58872b81();
    }
  }
}

function function_2f2fa868() {
  if(!getdvarint("nuketown_mannequin", 1)) {
    return false;
  }
  if(sessionmodeisonlinegame() && !sessionmodeisprivateonlinegame()) {
    return false;
  }
  if(util::isprophuntgametype()) {
    return false;
  }
  return true;
}

function function_4b855423() {
  players = getplayers();
  if(players.size > 12) {
    return false;
  }
  return true;
}

function function_58872b81() {
  wait(1);
  if(!function_2f2fa868()) {
    return;
  }
  level thread function_3c0e90cb(0);
}

function function_576ab778(notifytype, attacker, weapon) {}

function function_952db647(notifytype, attacker, weapon) {
  function_240b22bd(notifytype, attacker, weapon);
}

function function_2b3d2035(notifytype, attacker, weapon) {}

function function_33cfa2(notifytype, attacker, weapon) {
  function_240b22bd(notifytype, attacker, weapon);
}

function function_240b22bd(notifytype, attacker, weapon) {
  if(gettime() < (level.mannequin_time + (getdvarint("mannequin_timelimit", 120) * 1000))) {
    level.var_ce9a2d1f++;
    if(level.var_ce9a2d1f == getdvarint("mannequin_limbless_count", 56)) {
      level thread function_21402507();
    }
  }
}

function function_21402507() {
  wait(1);
  if(!function_2f2fa868()) {
    return;
  }
  level thread function_3c0e90cb(1);
}

function function_33a60aeb() {
  nodes = getnodesinradius((-765.225, 938.762, 7.377), 30, 0, 10, "End");
  setenablenode(nodes[0], 0);
  nodes = getnodesinradius((-1158.76, 1070.65, 7.377), 30, 0, 10, "End");
  setenablenode(nodes[0], 0);
  nodes = getnodesinradius((-926.372, -224.916, 7.376), 30, 0, 10, "End");
  setenablenode(nodes[0], 0);
  nodes = getnodesinradius((-1319.91, -93.028, 7.376), 30, 0, 10, "End");
  setenablenode(nodes[0], 0);
  nodes = getnodesinradius((918.81, -206.969, 7.376), 30, 0, 10, "End");
  setenablenode(nodes[0], 0);
  nodes = getnodesinradius((1313.93, -79.594, 7.376), 30, 0, 10, "End");
  setenablenode(nodes[0], 0);
  nodes = getnodesinradius((736.484, 925.845, 7.376), 30, 0, 10, "End");
  setenablenode(nodes[0], 0);
  nodes = getnodesinradius((1131.5, 1053.22, 7.376), 30, 0, 10, "End");
  setenablenode(nodes[0], 0);
}

function update_escort_robot_path(&patharray) {
  arrayinsert(patharray, (929, 626, -56.875), 10);
}