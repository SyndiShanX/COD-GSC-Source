/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_194827006298caa3.gsc
***********************************************/

#using script_16b1b77a76492c6a;
#using script_176597095ddfaa17;
#using script_215d7818c548cb51;
#using script_27347f09888ad15;
#using script_3411bb48d41bd3b;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\content_manager;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#namespace world_event_horde_hunt;

function private autoexec __init__system__() {
  system::register(#"hash_1e60252f388011fb", &preinit, undefined, undefined, #"content_manager");
}

function preinit() {
  if(!zm_utility::is_survival()) {
    return;
  }

  if(is_true(getgametypesetting(#"hash_1e1a5ebefe2772ba"))) {
    return;
  }

  if(!is_true(getgametypesetting(#"hash_7029ea8551fb906f")) && !getdvarint(#"hash_730311c63805303a", 0) && !getdvarint(#"hash_6a8bc2baa3d9fcb8", 0)) {
    return;
  }

  content_manager::register_script(#"horde_hunt", &function_8ebf52b6, 1);
  clientfield::register("actor", "sr_horde_hunt_fx", 1, 1, "int");
  clientfield::register("world", "sr_horde_hunt_decals", 1, 2, "int");
}

function private function_8ebf52b6(instance) {
  instance flag::clear("cleanup");
  instance callback::function_d8abfc3d(#"portal_activated", &function_1226f6af);
  level callback::add_callback(#"hash_594217387367ebb4", &function_1226f6af, instance);
  var_2b737124 = instance.contentgroups[# "corpses"][0];

  if(isDefined(var_2b737124.targetname)) {
    showmiscmodels(var_2b737124.targetname);

    if(getdvarint(#"hash_730311c63805303a", 0)) {
      level flag::wait_till(#"gameplay_started");
      wait randomfloatrange(1, 5);
    }

    if(issubstr(var_2b737124.targetname, "1")) {
      level clientfield::set("sr_horde_hunt_decals", 1);
    } else if(issubstr(var_2b737124.targetname, "2")) {
      level clientfield::set("sr_horde_hunt_decals", 2);
    } else if(issubstr(var_2b737124.targetname, "3")) {
      level clientfield::set("sr_horde_hunt_decals", 3);
    }
  }

  s_start = instance.contentgroups[# "start"][0];
  instance.trigger = content_manager::spawn_interact(s_start, &function_dbeb7b0f, #"hash_38e8b4d1311b4a2d", undefined, 100);
  instance.trigger.instance = instance;
  instance.var_ec694b2c = util::spawn_model(#"p9_zm_radio_pack_01_surface", s_start.origin - (0, 0, 8));
  instance.var_ec694b2c setscale(3);
  instance.var_ec694b2c function_619a5c20();
  instance.var_ec694b2c ghost();
  instance.var_ec694b2c playLoopSound(#"hash_5925f3613a001afc");
  instance.var_ec694b2c thread function_6400a64d(instance);
  instance.n_obj_id = zm_utility::function_f5a222a8(#"hash_5a77db57fc999c42", s_start.origin);
}

function private function_dbeb7b0f(eventstruct) {
  if(is_true(self.b_activated) || !isDefined(self.instance)) {
    return;
  }

  self.b_activated = 1;
  self sethintstring("");
  var_b976eb20 = randomint(9);
  str_vox = # "hash_51f7b50d9cc1fe6" + var_b976eb20 + 1 + "_" + var_b976eb20;
  var_9bb8ce1a = util::spawn_model("tag_origin", self.origin);
  waitframe(1);
  var_9bb8ce1a zm_vo::function_d6f8bbd9(str_vox);
  level thread zm_vo::function_7622cb70(#"hash_19913c8f26e0a808", 1);
  level thread function_deefa538(self.instance);

  if(isDefined(var_9bb8ce1a)) {
    var_9bb8ce1a deletedelay();
  }

  if(isDefined(self)) {
    self delete();
  }
}

function function_6400a64d(instance) {
  instance waittill(#"hash_68607fe956734fee", #"cleanup");
  playsoundatposition(#"hash_1231779900d59421", self.origin);
  self delete();
}

function private function_deefa538(instance) {
  if(!isDefined(instance) || instance flag::get("cleanup")) {
    return;
  }

  instance notify(#"hash_68607fe956734fee");
  instance endon(#"cleanup");
  wait 0.5;
  n_variant = randomintrange(1, 4);

  var_3d0c759f = getdvarint(#"hash_6a8bc2baa3d9fcb8", 0);

  if(var_3d0c759f) {
    n_variant = var_3d0c759f;
  }

  var_eb92deab = isDefined(instance.contentgroups[# "leader_spawn"]) ? instance.contentgroups[# "leader_spawn"] : [];
  var_ea63e380 = isDefined(instance.contentgroups[# "follower_spawn"]) ? instance.contentgroups[# "follower_spawn"] : [];
  function_283f2fb3(var_eb92deab);
  function_283f2fb3(var_ea63e380);
  var_18d554fc = int(min(level.realm, 3));
  var_b6947716 = "horde_hunt_realm_" + var_18d554fc + "_leader_" + n_variant;
  var_532e237f = "horde_hunt_realm_" + var_18d554fc + "_follower_" + n_variant;
  var_74714668 = "horde_hunt_realm_" + var_18d554fc + "_ambush_" + n_variant;

  if(!(isDefined(var_532e237f) && isDefined(var_b6947716) && isDefined(var_74714668)) || !var_eb92deab.size) {
    return;
  }

  var_10d9fd32 = var_eb92deab[0].origin;

  if(isDefined(instance.n_obj_id)) {
    zm_utility::function_bc5a54a8(instance.n_obj_id);
  }

  instance.n_obj_id = zm_utility::function_f5a222a8(#"hash_3643b91995cde879", var_10d9fd32);
  var_347a4920 = util::spawn_model("tag_origin", var_10d9fd32);
  var_347a4920 playSound(#"hash_149945a98c1798a6");
  var_347a4920 playLoopSound(#"hash_3b2e8e212c9bfb8a");
  level thread function_963ac9d8(var_347a4920);
  fx::play(#"hash_78d88a4dc6405970", var_10d9fd32 + (0, 0, 5000), undefined, 10);
  wait 1.5;
  instance.var_eb48250f = function_8a9ecf71(instance, var_eb92deab, var_b6947716, &function_57a97c81);
  instance.var_f2d5c926 = function_8a9ecf71(instance, var_ea63e380, var_532e237f, &function_ca46226a);
  instance thread function_1b8f27ec();
  instance thread function_e2f41f69(var_74714668);
}

function function_963ac9d8(var_347a4920) {
  wait 10;
  var_347a4920 stoploopsound();
  var_347a4920 playSound(#"hash_6eca5f5eaa236ce3");
  var_347a4920 util::deleteaftertime(1);
}

function private function_8a9ecf71(instance, var_842cdacd, var_aa19ae, spawn_func) {
  a_ai = [];
  var_ccd67daa = namespace_679a22ba::function_77be8a83(var_aa19ae);

  do {
    var_4bf95f4c = namespace_679a22ba::function_ca209564(var_aa19ae, var_ccd67daa);

    if(!isDefined(var_4bf95f4c)) {
      break;
    }

    str_aitype = var_4bf95f4c.aitype_name;
    spawn = var_842cdacd[0];
    ai = namespace_85745671::function_9d3ad056(str_aitype, spawn.origin, spawn.angles, #"hash_4085d77991160042");

    if(isDefined(ai)) {
      ai ghost();
      ai.var_a950813d = 1;
      ai.var_83fa6083 = 1;
      ai.var_7496eca2 = 1;
      ai.instance = instance;
      ai.spawn = spawn;
      namespace_679a22ba::function_266ee075(var_4bf95f4c.list_name, var_ccd67daa);

      if(!isDefined(a_ai)) {
        a_ai = [];
      } else if(!isarray(a_ai)) {
        a_ai = array(a_ai);
      }

      a_ai[a_ai.size] = ai;

      if(!isDefined(instance.a_ai)) {
        instance.a_ai = [];
      } else if(!isarray(instance.a_ai)) {
        instance.a_ai = array(instance.a_ai);
      }

      instance.a_ai[instance.a_ai.size] = ai;
      arrayremovevalue(var_842cdacd, spawn);
      ai callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_92184323);
      ai callback::function_d8abfc3d(#"on_ai_killed", &function_9974f649);
      ai thread[[spawn_func]](instance, spawn);
      ai thread function_f0abbc8b();

      if(ai.archetype === # "mechz") {
        ai thread function_c7db899f();
      } else if(ai.archetype === # "zombie_dog") {
        ai clientfield::set("sr_dog_fx", 1);
      } else if(ai.archetype === # "hash_7c0d83ac1e845ac2") {
        level thread function_d3d7a798(ai);
      }
    }

    wait 0.5;
    var_5af17050 = namespace_679a22ba::function_ce65eab6(var_ccd67daa);
  }
  while(var_842cdacd.size && var_5af17050.spawned < var_5af17050.var_cffbc08);

  return a_ai;
}

function private function_283f2fb3(&a_spawns) {
  var_866d39e6 = [];

  foreach(spawn in a_spawns) {
    if(spawn.script_noteworthy === "primary") {
      if(!isDefined(var_866d39e6)) {
        var_866d39e6 = [];
      } else if(!isarray(var_866d39e6)) {
        var_866d39e6 = array(var_866d39e6);
      }

      var_866d39e6[var_866d39e6.size] = spawn;
    }
  }

  foreach(var_7cc722dc in var_866d39e6) {
    arrayremovevalue(a_spawns, var_7cc722dc);
    arrayinsert(a_spawns, var_7cc722dc, 0);
  }
}

function private function_c7db899f() {
  self endon(#"death");

  while(!isDefined(self.var_7c4488fd)) {
    waitframe(1);
  }

  self.var_b49b10ee = undefined;
  self.var_7c4488fd = 0;
}

function private function_1b8f27ec() {
  array::flag_wait(self.a_ai, #"hash_576e1b7f4a5fe88e");

  foreach(ai in self.a_ai) {
    ai flag::clear(#"hash_576e1b7f4a5fe88e");
    ai val::reset_all(#"hash_59345e23ee60c2dd");
  }

  self flag::set(#"hash_50b20165dfb09565");
  self thread function_2660ef47();

  while(self.a_ai.size && !self flag::get("cleanup")) {
    foreach(ai in self.var_eb48250f) {
      if(isalive(ai) && !ai flag::get(#"hash_7a190647f4887d01")) {
        var_3d872e54 = 1;
        break;
      }
    }

    if(var_3d872e54 === 1) {
      var_3d872e54 = undefined;
      wait 1;
      continue;
    }

    foreach(ai in self.var_eb48250f) {
      if(isalive(ai)) {
        ai flag::clear(#"hash_7a190647f4887d01");
      }
    }

    if(self flag::get(#"hash_3ea0bab19c8c86b6")) {
      self flag::wait_till_clear(#"hash_3ea0bab19c8c86b6");
      wait 3;
      arrayremovevalue(self.var_eb48250f, undefined);
      function_1eaaceab(self.var_eb48250f);

      if(!self.var_eb48250f.size) {
        self function_b55fe25b();
      } else {
        foreach(ai in self.var_eb48250f) {
          ai notify(#"hash_2e9e1859076296fb");
        }
      }

      continue;
    }

    wait randomfloatrange(1.5, 3);
    arrayremovevalue(self.var_eb48250f, undefined);
    function_1eaaceab(self.var_eb48250f);

    if(!self.var_eb48250f.size) {
      self function_b55fe25b();
      continue;
    }

    array::notify_all(self.var_eb48250f, #"hash_11eeb7d23f82d744");
  }

  function_22e55954(self);
}

function private function_57a97c81(instance, spawn) {
  self endon(#"death");

  if(!isDefined(self.var_6b51e390)) {
    self.var_6b51e390 = struct::get(spawn.targetname, "target");

    if(!isDefined(instance.a_goals)) {
      instance.a_goals = [];
    } else if(!isarray(instance.a_goals)) {
      instance.a_goals = array(instance.a_goals);
    }

    if(!isinarray(instance.a_goals, self.var_6b51e390)) {
      instance.a_goals[instance.a_goals.size] = self.var_6b51e390;
    }

    instance flag::wait_till(#"hash_50b20165dfb09565");
  }

  while(isDefined(self.var_6b51e390)) {
    waitframe(randomintrange(5, 25));

    if(!instance flag::get(#"hash_3ea0bab19c8c86b6")) {
      self.var_7c4488fd = 0;
      self setgoal(self.var_6b51e390.origin);
      self thread function_c292b3fe(self.var_6b51e390.origin, instance);
    }

    s_result = self waittill(#"hash_11eeb7d23f82d744", #"hash_2e9e1859076296fb");

    if(s_result._notify === # "hash_11eeb7d23f82d744") {
      arrayremovevalue(instance.a_goals, self.var_6b51e390);
      self.var_6b51e390 = struct::get(self.var_6b51e390.targetname, "target");

      if(!isDefined(instance.a_goals)) {
        instance.a_goals = [];
      } else if(!isarray(instance.a_goals)) {
        instance.a_goals = array(instance.a_goals);
      }

      if(!isinarray(instance.a_goals, self.var_6b51e390)) {
        instance.a_goals[instance.a_goals.size] = self.var_6b51e390;
      }
    }
  }

  instance flag::set("cleanup");
}

function private function_c292b3fe(v_loc, instance) {
  self notify("7de34d93ee0908d1");
  self endon("7de34d93ee0908d1");
  self endon(#"death");
  instance endon(#"hash_3ea0bab19c8c86b6");
  n_time = 0;

  while(distance2dsquared(self.origin, v_loc) > 10000 && n_time < 90) {
    wait 1;
    n_time += 1;
  }

  if(n_time >= 90) {
    self.var_a950813d = undefined;
    self callback::callback(#"hash_10ab46b52df7967a");
  }

  self flag::set(#"hash_7a190647f4887d01");
}

function private function_ca46226a(instance, spawn) {
  self endon(#"death", #"hash_c923146051ebd8e");
  var_5e61a2e7 = arraygetclosest(self.origin, spawn.var_eb48250f);

  if(isDefined(var_5e61a2e7)) {
    var_1b1eb410 = 360 - var_5e61a2e7.spawn.angles[1];
    var_5d615ad6 = namespace_77bd50da::function_81cad6d6(self.spawn.origin - var_5e61a2e7.spawn.origin, var_1b1eb410);
  }

  spawn flag::wait_till(#"hash_50b20165dfb09565");
  waitframe(randomintrange(10, 30));
  var_de5b3f09 = 0;

  do {
    spawn flag::wait_till_clear(#"hash_3ea0bab19c8c86b6");

    if(!isalive(var_5e61a2e7)) {
      var_5e61a2e7 = arraygetclosest(self.origin, spawn.var_eb48250f);

      if(isDefined(var_5e61a2e7)) {
        var_b41c0723 = (0, 360, 0) - var_5e61a2e7.spawn.angles;
        var_5d615ad6 = namespace_77bd50da::function_81cad6d6(self.spawn.origin - var_5e61a2e7.spawn.origin, var_1b1eb410);
      }
    }

    if(!isalive(var_5e61a2e7) || !isDefined(var_5e61a2e7.var_6b51e390)) {
      break;
    }

    var_28f3b94b = struct::get(var_5e61a2e7.var_6b51e390.target, "targetname");

    if(isDefined(var_28f3b94b)) {
      var_18df63c9 = vectortoangles(var_5e61a2e7.var_6b51e390.origin - var_28f3b94b.origin)[1];
    } else {
      var_18df63c9 = var_5e61a2e7.var_6b51e390.angles[1];
    }

    v_goal = undefined;

    if(isDefined(var_5d615ad6)) {
      v_goal = var_5e61a2e7.origin + namespace_77bd50da::function_81cad6d6(var_5d615ad6, var_18df63c9) + (randomintrange(32 * -1, 32), randomintrange(32 * -1, 32), 0);
    }

    if(!isDefined(v_goal) || distance2dsquared(self.origin, v_goal) < 10000) {
      wait 1.5;
      continue;
    }

    v_goal = getclosestpointonnavmesh(v_goal, 128, 32);

    if(isDefined(v_goal)) {
      self setgoal(v_goal);
      s_result = self waittilltimeout(1.5, #"goal");
      var_de5b3f09 = 0;

      if(s_result._notify === "goal") {
        wait randomfloatrange(3, 4);
      }

      continue;
    }

    var_de5b3f09++;

    if(var_de5b3f09 > 10) {
      break;
    }

    wait 1;
  }
  while(spawn.var_eb48250f.size);
}

function private function_b55fe25b() {
  self.var_eb48250f = self.var_f2d5c926;
  self.var_f2d5c926 = [];
  arrayremovevalue(self.var_eb48250f, undefined);
  function_1eaaceab(self.var_eb48250f);

  foreach(ai in self.var_eb48250f) {
    var_31c3dcb4 = arraysortclosest(self.a_goals, ai.origin);

    foreach(s_path in var_31c3dcb4) {
      if(s_path.b_taken !== 1) {
        s_path.b_taken = 1;
        ai.var_6b51e390 = s_path;
        break;
      }
    }

    if(isDefined(ai.var_6b51e390)) {
      ai notify(#"hash_c923146051ebd8e");
      ai thread function_57a97c81(self);
      continue;
    }

    ai.var_a950813d = undefined;
    ai callback::callback(#"hash_10ab46b52df7967a");
  }
}

function private function_2660ef47() {
  self endon(#"cleanup");

  while(true) {
    wait 1;
    arrayremovevalue(self.a_ai, undefined);
    function_1eaaceab(self.a_ai);

    if(!self.a_ai.size) {
      function_22e55954(self);
      break;
    }

    if(isalive(self.var_805807d8) || !isDefined(self.n_obj_id)) {
      continue;
    }

    self.var_805807d8 = array::random(self.a_ai);
    objective_clearentity(self.n_obj_id);
    objective_onentity(self.n_obj_id, self.var_805807d8);
  }
}

function private function_e2f41f69(var_74714668) {
  self endon(#"cleanup");

  while(true) {
    self flag::wait_till(#"hash_3ea0bab19c8c86b6");

    if(isDefined(self.var_571f5454)) {
      namespace_2c949ef8::function_8b6ae460(self.var_571f5454, var_74714668);
      break;
    }

    wait 1;
  }
}

function private function_92184323(eventstruct) {
  self endon(#"death");
  instance = self.instance;
  function_1eaaceab(instance.a_ai);
  arrayremovevalue(instance.a_ai, undefined);

  if(self.current_state.name === # "wander") {
    foreach(ai in instance.a_ai) {
      if(ai.current_state.name === # "chase" || self.current_state.name === # "investigate") {
        function_7d9c6082(instance, ai);
        instance flag::set(#"hash_3ea0bab19c8c86b6");
        return;
      }
    }

    instance flag::clear(#"hash_3ea0bab19c8c86b6");
    instance.var_571f5454 = undefined;

    foreach(ai in instance.a_ai) {
      ai notify(#"hash_2e9e1859076296fb");
    }

    return;
  }

  if(self.current_state.name === # "investigate" || self.current_state.name === # "chase") {
    self.var_7c4488fd = 1;
    function_7d9c6082(instance, self);
    instance flag::set(#"hash_3ea0bab19c8c86b6");
  }
}

function private function_7d9c6082(instance, ai) {
  if(isDefined(instance.var_571f5454)) {
    return;
  }

  if(ai.current_state.name === # "chase") {
    if(isDefined(ai.favoriteenemy)) {
      instance.var_571f5454 = ai.favoriteenemy.origin;
      return;
    }

    if(isDefined(ai.var_b4b8ad5f.position)) {
      instance.var_571f5454 = ai.var_b4b8ad5f.position;
      return;
    }

    instance.var_571f5454 = ai.origin;
  }
}

function private function_9974f649(eventstruct) {
  if(!isDefined(self.instance.a_ai) || self.instance flag::get(#"cleanup")) {
    return;
  }

  foreach(ai in self.instance.a_ai) {
    if(isalive(ai) && ai !== self) {
      if(is_true(ai.hastwin)) {
        if(!is_true(ai.var_20841367)) {
          ai.var_20841367 = 1;
          ai callback::function_d8abfc3d(#"on_ai_killed", &function_9974f649);
          ai callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_92184323);
          ai thread namespace_2c949ef8::function_1c491c2b();
          println("<dev string:x38>");
        }

        if(isalive(ai.twin) && !is_true(ai.twin.var_20841367)) {
          ai.twin.var_20841367 = 1;
          ai.twin callback::function_d8abfc3d(#"on_ai_killed", &function_9974f649);
          ai.twin callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_92184323);
          ai.twin thread namespace_2c949ef8::function_1c491c2b();
          println("<dev string:x5d>");
        }
      }

      return;
    }
  }

  function_ca912561(self.instance);
}

function private function_ca912561(instance) {
  if(is_true(instance.var_ca912561)) {
    return;
  }

  instance.var_ca912561 = 1;

  if(isDefined(self.instance)) {
    self.instance flag::clear(#"hash_3ea0bab19c8c86b6");
  }

  level scoreevents::doscoreeventcallback("scoreEventSR", {
    #scoreevent: "event_complete", #nearbyplayers: 1, #var_b0a57f8c: 5000, #location: self.origin
  });
  players = getplayers();

  foreach(player in players) {
    player zm_stats::function_945c7ce2(#"hash_165462f560a0538c", 1);
    player zm_stats::increment_challenge_stat(#"hash_3b540abd221a6d9");
  }

  if(isentity(self)) {
    traceresult = physicstraceex(self getcentroid(), self getcentroid() - (0, 0, 1000), (-15, -15, 0), (15, 15, 72));
    v_drop = traceresult[# "position"];

    if(!isDefined(v_drop)) {
      v_drop = self.origin;
    }

    if(!namespace_d0ab5955::function_3824d2dc(v_drop)) {
      v_drop = arraygetclosest(v_drop, players).origin;
    }

    if(isvec(v_drop)) {
      level thread zm_powerups::specific_powerup_drop("free_perk", v_drop, undefined, 0);
    }
  }

  level thread zm_vo::function_7622cb70(#"hash_3052fb147a41904b", 3);
}

function private function_d3d7a798(ai) {
  level endon(#"end_game");
  instance = ai.instance;

  while(isDefined(instance) && !is_true(instance.var_ca912561)) {
    function_1eaaceab(instance.a_ai);

    if(!isDefined(instance.a_ai) || instance.a_ai.size <= 0) {
      println("<dev string:x82>");

      if(instance flag::get(#"cleanup")) {
        return;
      }

      ai function_ca912561(instance);
    } else {
      foreach(var_f077a87e in instance.a_ai) {
        if(var_f077a87e.aitype === # "spawner_zm_steiner_split_radiation_blast" || var_f077a87e.aitype === # "spawner_zm_steiner_split_radiation_bomb") {
          ai_name = var_f077a87e.aitype === # "spawner_zm_steiner_split_radiation_blast" ? "<dev string:xad>" : "<dev string:xc4>";
          println("<dev string:xda>" + ai_name + "<dev string:xfe>" + var_f077a87e getentitynumber() + "<dev string:x104>" + var_f077a87e.origin);

          if(var_f077a87e.origin[2] < -1000) {
            println("<dev string:xda>" + ai_name + "<dev string:xfe>" + var_f077a87e getentitynumber() + "<dev string:x112>");
            var_f077a87e.allowdeath = 1;
            var_f077a87e kill();
          }
        }
      }
    }

    wait 2;
  }

  println("<dev string:x134>");
}

function private function_f0abbc8b() {
  self endon(#"death");
  self val::set(#"hash_59345e23ee60c2dd", "allowdeath", 0);
  self val::set(#"hash_59345e23ee60c2dd", "ignoreall", 1);
  spawn = self.spawn;
  var_55e11aa9 = util::spawn_model("tag_origin", self.origin, spawn.angles);
  self linkto(var_55e11aa9);
  var_55e11aa9.origin = self.origin + (0, 0, 5000);
  level fx::play(#"hash_2520b0c56a09da9d", spawn.origin, undefined, 6);
  wait 0.25;
  str_anim = self function_4cb6cdb8();

  if(isDefined(str_anim)) {
    self thread animation::play(str_anim, self);
  }

  self show();
  var_55e11aa9 moveto(spawn.origin, 6);
  var_55e11aa9 rotatevelocity((0, 360 / 6, 0), 6);
  var_55e11aa9 waittill(#"movedone");
  var_55e11aa9 delete();

  if(isDefined(str_anim)) {
    self animation::stop();
  }

  self setgoal(self.origin);
  self flag::set(#"hash_576e1b7f4a5fe88e");
  waitframe(1);
  self clientfield::set("sr_horde_hunt_fx", 1);
}

function private function_4cb6cdb8() {
  switch (self.archetype) {
    case # "zombie_dog":
      return # "hash_16fb83823caa867c";
    case # "mechz":
      return # "hash_72102974314fff02";
    case # "hash_7c0d83ac1e845ac2":
      return # "hash_502ed36a2535b270";
    case # "raz":
      return # "hash_351d7331f52be032";
    case # "avogadro":
      return # "hash_1cbbcdbfd528f8e1";
  }
}

function private function_22e55954(instance) {
  self flag::set("cleanup");

  if(isDefined(instance.n_obj_id)) {
    objective_clearentity(instance.n_obj_id);
    zm_utility::function_bc5a54a8(instance.n_obj_id);
    instance.n_obj_id = undefined;
  }

  foreach(ai in instance.a_ai) {
    if(isalive(ai)) {
      ai.var_a950813d = undefined;
      ai callback::callback(#"hash_10ab46b52df7967a");
    }

    waitframe(1);
  }
}

function private function_1226f6af(var_273eefec) {
  self flag::set("cleanup");

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  if(isDefined(self.a_ai)) {
    function_22e55954(self);
  }
}