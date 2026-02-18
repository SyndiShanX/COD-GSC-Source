/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\load.gsc
***********************************************/

#using script_22caeaa9257194b8;
#using script_3919f386abede84;
#using script_45a1c6f3704b3b15;
#using script_5a9516c83d1ec8fc;
#using script_68364cfa1098cdd4;
#using script_7cc5fb39b97494c4;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\clientids_shared;
#using scripts\core_common\containers_shared;
#using scripts\core_common\encounters\wave_manager;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\lockpick;
#using scripts\core_common\lui_shared;
#using scripts\core_common\oob;
#using scripts\core_common\rank_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\scriptmodels_shared;
#using scripts\core_common\serverfaceanim_shared;
#using scripts\core_common\status_effects\status_effects;
#using scripts\core_common\string_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\traps_deployable;
#using scripts\core_common\turret_shared;
#using scripts\core_common\tweakables_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_drivable_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\art;
#using scripts\cp_common\challenges;
#using scripts\cp_common\debug;
#using scripts\cp_common\devgui;
#using scripts\cp_common\gamedifficulty;
#using scripts\cp_common\gametypes\globallogic;
#using scripts\cp_common\oed;
#using scripts\cp_common\skipto;
#using scripts\cp_common\spawn_manager;
#using scripts\cp_common\util;
#using scripts\weapons\antipersonnelguidance;
#using scripts\weapons\cp\weaponobjects;
#namespace load;

function private event_handler[createstruct] function_e0a8e4ba(struct) {
  foreach(var_55e4dfcf, k in ["script_objective", "script_likelyenemy"]) {
    if(!isDefined(level.var_41204f29)) {
      level.var_41204f29 = [];
    } else if(!isarray(level.var_41204f29)) {
      level.var_41204f29 = array(level.var_41204f29);
    }

    if(!isinarray(level.var_41204f29, tolower(k))) {
      level.var_41204f29[level.var_41204f29.size] = tolower(k);
    }
  }

  level.var_5e990e96 = arraycopy(level.var_41204f29);

  if(isDefined(level.struct)) {
    temp = arraycopy(level.struct);
    level.struct = [];

    foreach(struct in temp) {
      struct::init(struct);
    }
  }

  function_6c07201b("CreateStruct", &function_e0a8e4ba);
}

function autoexec function_aeb1baea() {
  assert(!isDefined(level.var_f18a6bd6));
  level.var_f18a6bd6 = &function_5e443ed1;
}

function function_5e443ed1() {
  assert(isDefined(level.first_frame), "<dev string:x38>");

  if(is_true(level._loadstarted)) {
    return;
  }

  level._loadstarted = 1;
  function_fbb2b180();
  setDvar(#"hash_2b7eabe1e310b191", 0);
  setDvar(#"g_speed", 160);
  setDvar(#"ik_terrain_vel_min", 120);
  setDvar(#"ik_terrain_vel_max", 150);
  var_4a3ec1d1 = getgametypesetting(#"hash_72a2919d2ac65850");
  setDvar(#"hash_7188be5be867a9ba", var_4a3ec1d1);
  setDvar(#"hash_862358d532e674c", var_4a3ec1d1);
  level.aitriggerspawnflags = getaitriggerflags();
  level.vehicletriggerspawnflags = getvehicletriggerflags();
  level flag::init("wait_and_revive");
  level flag::init("instant_revive");
  util::registerclientsys("lsm");
  level thread register_clientfields();
  setup_traversals();
  level thread onallplayersready();
  gamedifficulty::setskill(undefined, level.var_648a2ef0);
  system::function_c11b0642();
  art_review();
  level.growing_hitmarker = 1;
  level.var_6454ed48 = 0;
  level flag::set(#"load_main_complete");
  level flag::set("draft_complete");
  level.var_f320af85 = &function_e029c994;

  if(isDefined(level.var_b28c2c3a) && isDefined(level.var_46d8992a)) {
    if(level.var_b28c2c3a == level.var_46d8992a) {
      world.var_b86bf11e = undefined;
    }
  }

  level thread function_c9740807();
  level thread function_2dd7fc9e();
}

function private function_fbb2b180() {
  resetdynents();
  resetglass();

  if(isDefined(level.var_82eb1dab)) {
    foreach(deathmodel in level.var_82eb1dab) {
      deathmodel delete();
    }

    level.var_82eb1dab = undefined;
  }

  level flag::set(#"hash_507a4486c4a79f1d");
}

function function_2dd7fc9e() {
  level flag::wait_till("all_players_spawned");
  setDvar(#"ui_allowdisplaycontinue", 1);

  if(isloadingcinematicplaying()) {
    do {
      waitframe(1);
    }
    while(isloadingcinematicplaying());
  } else {
    wait 1;
  }

  level util::streamer_wait(undefined, 2, 45);
  level flag::set(#"loaded");
}

function function_bc5d59fb() {
  setDvar(#"ui_allowdisplaycontinue", 0);
}

function function_ba5622e() {
  util::function_49cd62a8("level_is_go");
}

function function_eb7b7382() {
  level flag::wait_till(#"loaded");
  level flag::wait_till(#"hud_initialized");
  level flag::set("level_is_go");
}

function function_c9740807() {
  player = getplayers()[0];

  if(isPlayer(player) && player util::function_a1d6293()) {
    return;
  }

  checkpointcreate();
  checkpointcommit();
  flag::wait_till("all_players_spawned");
  wait 0.5;
  player = getplayers()[0];

  if(isPlayer(player) && player util::function_a1d6293()) {
    return;
  }

  checkpointcreate();
  checkpointcommit();
}

function function_e029c994(player, target, weapon) {
  return !weapon oob::isoutofbounds();
}

function player_fake_death() {
  level notify(#"fake_death");
  self notify(#"fake_death");
  self takeallweapons();
  self allowstand(0);
  self allowcrouch(0);
  self allowprone(1);
  self val::set(#"fakedeath", "ignoreme", 1);
  self val::set(#"fakedeath", "takedamage", 0);
  wait 1;
  self val::set(#"fakedeath", "freezecontrols", 1);
}

function init_traverse() {
  point = getent(self.target, "targetname");

  if(isDefined(point)) {
    self.traverse_height = point.origin[2];
    point delete();
    return;
  }

  point = struct::get(self.target, "targetname");

  if(isDefined(point)) {
    self.traverse_height = point.origin[2];
  }
}

function setup_traversals() {
  potential_traverse_nodes = getallnodes();

  for(i = 0; i < potential_traverse_nodes.size; i++) {
    node = potential_traverse_nodes[i];

    if(node.type == # "begin") {
      node init_traverse();
    }
  }
}

function function_f97a8023(mission_name) {
  if(!isDefined(mission_name)) {
    return 0;
  }

  return function_dd83f1b6(mission_name);
}

function function_c9154eb7(var_83104433, var_585e39fb) {
  if(isDefined(var_83104433)) {
    if(!isDefined(var_585e39fb)) {
      var_585e39fb = skipto::function_455cb6c5(var_83104433);
    }

    function_cc51116c(var_83104433, var_585e39fb);
    return;
  }

  globallogic::function_7b994f00();
}

function function_d44ed07e(var_83104433 = skipto::function_60ca00f5(), var_585e39fb) {
  if(is_true(level.var_d89799d7)) {
    function_ff52baa2();
  }

  if(isDefined(var_585e39fb)) {
    skipto::function_8722a51a(var_585e39fb, 1);
  }

  var_7c9eb9c6 = getrootmapname(var_83104433);
  level flag::clear("switchmap_preload_finished");
  level.var_d89799d7 = 1;
  level util::delay("switchmap_preload_finished", "cancel_preload", &flag::set, "switchmap_preload_finished");
  switchmap_preload(var_7c9eb9c6, level.gametype);
}

function function_ff52baa2() {
  level notify(#"cancel_preload");
  function_227b0384();
  level.var_d89799d7 = undefined;
  level flag::clear("switchmap_preload_finished");
}

function function_cc51116c(var_83104433, var_585e39fb = "") {
  skipto::function_8722a51a(var_585e39fb, 1);
  var_31924550 = getuimodel(function_5f72e972(#"lobby_root"), "transitionMapIdOverride");
  setuimodelvalue(var_31924550, hash(var_83104433));

  if(is_true(level.var_d89799d7)) {
    util::wait_network_frame(1);
    level flag::wait_till_timeout(25, "switchmap_preload_finished");
    level.var_d89799d7 = undefined;
    switchmap_switch();
    return;
  }

  level.var_d89799d7 = undefined;
  var_7c9eb9c6 = getrootmapname(var_83104433);
  switchmap_load(var_7c9eb9c6, level.gametype);
  util::wait_network_frame(1);
  switchmap_switch();
}

function player_intermission(var_1ed3b46b = 1) {
  self closeingamemenu();
  level endon(#"hash_1ef9c6a01f34e17d", #"stop_intermission");
  self endon(#"death");
  self notify(#"_zombie_game_over");

  if(is_true(var_1ed3b46b)) {
    self.sessionstate = "intermission";
  }

  self.spectatorclient = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.friendlydamage = undefined;
  points = struct::get_array("intermission", "targetname");

  if(!isDefined(points) || points.size == 0) {
    points = getEntArray("info_intermission", "classname");

    if(points.size < 1) {
      println("<dev string:x67>");
      return;
    }
  }

  org = undefined;

  while(true) {
    points = array::randomize(points);

    for(i = 0; i < points.size; i++) {
      point = points[i];

      if(!isDefined(org)) {
        self spawn(point.origin, point.angles);
      }

      if(isDefined(points[i].target)) {
        if(!isDefined(org)) {
          org = spawn("script_model", self.origin + (0, 0, -60));
          org setModel(#"tag_origin");
        }

        org.origin = points[i].origin;
        org.angles = points[i].angles;

        for(j = 0; j < getplayers().size; j++) {
          player = getplayers()[j];
          player camerasetposition(org);
          player camerasetlookat();
          player cameraactivate(1);
        }

        speed = 20;

        if(isDefined(points[i].speed)) {
          speed = points[i].speed;
        }

        target_point = isDefined(struct::get(points[i].target, "targetname")) ? struct::get(points[i].target, "targetname") : getent(points[i].target, "targetname");
        dist = distance(points[i].origin, target_point.origin);
        time = dist / speed;
        var_91c3f3c4 = time * 0.25;

        if(var_91c3f3c4 > 1) {
          var_91c3f3c4 = 1;
        }

        org moveto(target_point.origin, time, var_91c3f3c4, var_91c3f3c4);
        org rotateto(target_point.angles, time, var_91c3f3c4, var_91c3f3c4);
        wait time;
        continue;
      }

      wait 5;
    }
  }
}

function onallplayersready() {
  level flag::init("start_coop_logic");

  println("<dev string:x8d>" + getnumexpectedplayers());
  var_f884532 = 0;

  do {
    waitframe(1);
    var_72e2b734 = getnumconnectedplayers();
    var_73f084c = getnumexpectedplayers(1);
    player_count_actual = 0;

    for(i = 0; i < level.players.size; i++) {
      if(level.players[i].sessionstate == "playing" || level.players[i].sessionstate == "spectator") {
        player_count_actual++;
      }
    }

    if(var_f884532 % 10 == 0) {
      println("<dev string:xad>" + var_72e2b734 + "<dev string:xc6>" + var_73f084c);
      println("<dev string:xd6>" + player_count_actual + "<dev string:xf3>" + level.players.size);
    }

    var_f884532++;
  }
  while(var_72e2b734 < var_73f084c || player_count_actual < var_73f084c);

  setinitialplayersconnected();

  printtoprightln("<dev string:x10d>", (1, 1, 1));

  level flag::set("all_players_connected");
  level flag::set("start_coop_logic");
}

function register_clientfields() {}