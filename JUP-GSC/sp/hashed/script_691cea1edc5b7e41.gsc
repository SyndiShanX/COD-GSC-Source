/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_691cea1edc5b7e41.gsc
*************************************************/

#using script_32876a523f324870;
#using script_4ab4bd3ef85fb34c;
#using scripts\anim\dialogue;
#using scripts\anim\utility_common;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\maps\sp_jup_flashback\sp_jup_flashback_lighting;
#using scripts\sp\spawner;
#using scripts\sp\utility;
#namespace namespace_5e9fb42dea43f1f0;

function function_976f2f5d255b2170() {
  level.player enableinvulnerability();
  level.player setOrigin((31328, 2512, -664));
  exploder("inside_stadium_fx");
}

function function_7fea2bfdbc2b2d5e() {
  setDvar(@ "hash_d76985a5147bddf0", 1);
  thread function_c192ee56043c4d4f();
  thread function_def2ca6a173dd447();
  level waittill("forever");
}

function function_c192ee56043c4d4f() {
  thread function_970d6a08ab976df7();
  thread function_9ea8b72fcd97394e();
  thread function_c09f705937921211();
}

function function_57dc6f590951cdc0() {
  assertex(!isDefined(level.var_1ef882f241704237), "Trying to run concourse civilian logic twice!");
  setdvarifuninitialized(@ "hash_d76985a5147bddf0", 0);
  setdvarifuninitialized(@ "hash_4568bc59fcf1a36e", 1);
  setdvarifuninitialized(@ "hash_9cce268ded1b5087", 0);
  level.var_1ef882f241704237 = [];
  level.var_ab31e06e378b397 = [];
  level.var_93a0e9d2eca11bfc = 0;
  level.var_a0bba063030a3106 = 35;
  debug_mode = getdvarint(@ "hash_d76985a5147bddf0") > 0;

  if(istrue(debug_mode)) {
    setDvar(@ "hash_985a6eb7146ff86e", 1);
    level.player thread namespace_fbd1c1b57d4f60c0::function_be2529906db91d65();
  }

  delete_node = spawnStruct();
  delete_node.targetname = "civ_safe_delete_node";
  addstruct(delete_node);
}

function function_def2ca6a173dd447() {
  function_57dc6f590951cdc0();
  thread function_a0fb5ab1cb327c79();
  thread function_3702dd1c3e9e412c();
  thread function_de4dd9cab4eb3871();
}

function function_1b73273370d27c99() {
  assertex(isDefined(level.var_1ef882f241704237), "Concourse civilians where not initialized yet!");
  civs = array_merge(level.var_1ef882f241704237, level.var_ab31e06e378b397);
  civs = function_fdc9d5557c53078e(civs);
  return civs;
}

function private function_9886db945af3b751() {
  level endon("stop_concourse_civ_logic");
  level endon("stop_bullet_passthroug_watcher");
  enabled = getdvarint(@ "hash_9cce268ded1b5087") > 0;

  if(!enabled) {
    return;
  }

  while(true) {
    self waittill("bullet_first_impact", var_9d7ca6252f103a3b, hitent, hitentpart, surfacenormal, surfacetype, weapon, bulletdir, impactpos, hitloc);
    waitframe();

    if(isDefined(hitent) && isDefined(hitent.team) && hitent.team != "axis") {
      continue;
    }

    civs = function_1b73273370d27c99();

    foreach(civ in civs) {
      civ.var_4eb648d546ef32fa = civ.var_137740b3477936a3;
      civ.var_137740b3477936a3 = 1;
    }

    waitframe();

    foreach(civ in civs) {
      if(!is_dead_or_dying(civ)) {
        civ.var_137740b3477936a3 = civ.var_4eb648d546ef32fa;
        civ.var_4eb648d546ef32fa = undefined;
        civ clearimpactmarks();
        node = getStruct("animnode_civ_execute", "targetname");
        civ delaythread(7, &spawner::go_to_node, node);
      }
    }
  }
}

function private function_de4dd9cab4eb3871() {
  level endon("stop_concourse_civ_logic");

  while(true) {
    level.var_1ef882f241704237 = function_fdc9d5557c53078e(level.var_1ef882f241704237);
    level.var_ab31e06e378b397 = function_fdc9d5557c53078e(level.var_ab31e06e378b397);
    function_f3d271989b63fc09(level.var_1ef882f241704237);
    function_f3d271989b63fc09(level.var_ab31e06e378b397);
    wait 1;
  }
}

function private function_f3d271989b63fc09(civ_array) {
  assert(isDefined(civ_array));
  safe_delete_node = getStruct("civ_safe_delete_node", "targetname");
  var_a38124612062a202 = within_fov(level.player getEye(), level.player getplayerangles(), safe_delete_node.origin, cos(getdvarint(@ "cg_fov")));

  if(civ_array.size && !var_a38124612062a202) {
    foreach(civ in civ_array) {
      if(level.player function_4bcb166b7bd416a6(civ, 1700)) {
        civ notify("marked_for_cull");
      }
    }
  }
}

function private function_4bcb166b7bd416a6(civ, max_distance) {
  var_57ac1035e7974c82 = distance2dsquared(self.origin, civ.origin) > max_distance * max_distance;
  var_23fbe834bcd7812b = !player_can_see_ai(level.player, civ);
  safe_delete_node = getStruct("civ_safe_delete_node", "targetname");
  var_8f9cd770d81bafaa = !civ is_point_in_front(safe_delete_node.origin);
  return var_57ac1035e7974c82 && var_23fbe834bcd7812b && var_8f9cd770d81bafaa;
}

function private function_a0fb5ab1cb327c79() {
  level endon("stop_concourse_civ_logic");
  delete_node = getStruct("civ_safe_delete_node", "targetname");
  delete_node.origin = (31736, 2296, -672);
  delete_node.angles = (0, 285, 0);
  thread intro_civs("civ_intro_concourse_a", undefined, (30552, 3856, -624));
  thread function_ac1e6390883a78d1("civ_looper_concourse_a", ["stop_looping_civs_concourse_a"], 1);
  thread intro_civs("civ_intro_concourse_a_outer");
  thread function_ac1e6390883a78d1("civ_looper_concourse_a_outer", ["stop_looping_civs_concourse_a"], 1, &function_953a944ddc04aebd);
  flag_wait("stop_looping_civs_concourse_a");
  delete_node.origin = (30592, 3808, -664);
  thread intro_civs("civ_intro_concourse_b", undefined, (29488, 4928, -624));
  thread function_ac1e6390883a78d1("civ_looper_concourse_b", ["stop_looping_civs_concourse_b"], 2);
  thread intro_civs("civ_intro_concourse_b_outer", &function_953a944ddc04aebd);
  thread function_ac1e6390883a78d1("civ_looper_concourse_b_outer", ["stop_looping_civs_concourse_b"], 2, &function_953a944ddc04aebd);
  flag_wait("stop_looping_civs_concourse_b");
  delete_node.origin = (29784, 4784, -664);
  thread intro_civs("civ_intro_concourse_d", undefined, (28664, 5360, -624));
  thread function_ac1e6390883a78d1("civ_looper_concourse_d", ["stop_looping_civs_concourse_d"], 3);
  flag_wait("stop_looping_civs_concourse_d");
  thread intro_civs("civ_intro_concourse_e", undefined, (27032, 5360, -624));
}

function private function_3702dd1c3e9e412c() {
  level endon("stop_concourse_civ_logic");
  flag_wait("stop_looping_civs_concourse_a_outer");
  thread intro_civs("civ_intro_concourse_b_outside", &function_ff537fee4aaccedd, (29568, 3936, -624));
  thread function_ac1e6390883a78d1("civ_looper_concourse_b_outside", ["stop_looping_civs_concourse_b_outside", "stop_looping_civs_concourse_b"], 2, &function_ff537fee4aaccedd);
  flag_wait("stop_looping_civs_concourse_b_outside");
  thread intro_civs("civ_intro_concourse_d_outside", &function_ff537fee4aaccedd, (28496, 5016, -624));
  thread function_ac1e6390883a78d1("civ_looper_concourse_d_outside", ["stop_looping_civs_concourse_d_outside", "stop_looping_civs_concourse_d"], 2, &function_ff537fee4aaccedd);
}

function private intro_civs(var_b39aa4be423cd14, var_e5a66feed4c0ff83, var_f3df27e27594eee4) {
  level endon("stop_concourse_civ_logic");
  assert(isstring(var_b39aa4be423cd14));

  if(isDefined(var_e5a66feed4c0ff83)) {
    if(![[var_e5a66feed4c0ff83]]()) {
      return;
    }
  }

  if(isDefined(var_f3df27e27594eee4)) {
    thread play_sound_in_space("fb_crowd_panic", var_f3df27e27594eee4);
  }

  debug_mode = getdvarint(@ "hash_d76985a5147bddf0") > 0;

  if(debug_mode) {
    iprintln("<dev string:x1c>" + var_b39aa4be423cd14);
  }

  spawn_structs = getStructArray(var_b39aa4be423cd14, "targetname");
  assert(spawn_structs.size);

  foreach(spawn_struct in spawn_structs) {
    civ = function_5e211e568807234b(spawn_struct.origin, spawn_struct.angles);

    if(isDefined(civ)) {
      civ thread go_to_node(getStruct(spawn_struct.target, "targetname"));
      level.var_1ef882f241704237[level.var_1ef882f241704237.size] = civ;
    }
  }

  thread function_f8f4132a3b55812(spawn_structs);
}

function function_f8f4132a3b55812(structs, var_8b7b9f50e7d9d756) {
  if(!isDefined(var_8b7b9f50e7d9d756)) {
    var_8b7b9f50e7d9d756 = 5;
  }

  mover = spawn_script_origin((0, 0, 0), (0, 0, 0));
  mover play_sound_on_entity("fb_crowd_panic");
  current_time = gettime();

  while(true) {
    mover.origin = utility::get_average_origin(structs);
    waitframe();

    if(time_has_passed(current_time, var_8b7b9f50e7d9d756)) {
      break;
    }
  }
}

function function_5e211e568807234b(spawn_origin, spawn_angles) {
  if(level.var_93a0e9d2eca11bfc == level.var_a0bba063030a3106) {
    return undefined;
  }

  civ = namespace_47819225b08b445d::spawn_civ(spawn_origin, spawn_angles, undefined, 0, 0);

  if(isDefined(civ)) {
    civ.ignoreplayersuppressionlines = 0;
    civ.var_dee4eba7c4ec60b9 = 1;
    civ thread function_3c467c1913e25349();
    level.var_93a0e9d2eca11bfc++;
  }

  return civ;
}

function private function_3c467c1913e25349() {
  result = waittill_any_return("death", "reached_path_end", "marked_for_cull");

  if(result != "death") {
    self delete();
  }

  level.var_93a0e9d2eca11bfc--;
}

function function_ac1e6390883a78d1(var_b39aa4be423cd14, enders, spawn_delay, var_e5a66feed4c0ff83) {
  level endon("stop_concourse_civ_logic");
  assert(isstring(var_b39aa4be423cd14));
  assert(isnumber(spawn_delay));
  debug_mode = getdvarint(@ "hash_d76985a5147bddf0") > 0;

  foreach(ender in enders) {
    if(debug_mode) {
      level thread function_c10e218473f76c22(var_b39aa4be423cd14, ender);
    }

    level endon(ender);
  }

  if(debug_mode) {
    iprintln("<dev string:x42>" + var_b39aa4be423cd14);
  }

  spawn_structs = getStructArray(var_b39aa4be423cd14, "targetname");
  assert(spawn_structs.size);

  while(true) {
    if(isDefined(var_e5a66feed4c0ff83)) {
      if(![[var_e5a66feed4c0ff83]]()) {
        waitframe();
        continue;
      }
    }

    spawn_struct = spawn_structs[randomint(spawn_structs.size)];
    civ = function_5e211e568807234b(spawn_struct.origin, spawn_struct.angles);

    if(isDefined(civ)) {
      civ thread go_to_node(getStruct(spawn_struct.target, "targetname"));
      level.var_ab31e06e378b397[level.var_ab31e06e378b397.size] = civ;
    }

    wait spawn_delay;
  }
}

function function_c10e218473f76c22(var_b39aa4be423cd14, ender) {
  self waittill(ender);
  iprintln("<dev string:x6a>" + var_b39aa4be423cd14 + "<dev string:x92>" + ender);
}

function function_ff537fee4aaccedd() {
  var_bed4cc0624a44efa = getEnt("volume_outside_alley", "targetname");
  return level.player istouching(var_bed4cc0624a44efa);
}

function function_953a944ddc04aebd() {
  return !function_ff537fee4aaccedd();
}