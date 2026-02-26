/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_556db1e330468414.gsc
***********************************************/

#using script_16b1b77a76492c6a;
#using script_34ab99a4ca1a43d;
#using script_6155d71e1c9a57eb;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\content_manager;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\ping;
#using scripts\core_common\scene_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#namespace monster_house;

function private autoexec __init__system__() {
  system::register(#"monster_house", &preinit, undefined, undefined, #"content_manager");
}

function private preinit() {
  if(!zm_utility::is_survival()) {
    return;
  }

  if(is_true(getgametypesetting(#"hash_1e1a5ebefe2772ba"))) {
    return;
  }

  if(!is_true(getgametypesetting(#"hash_50bcc0278b8ff6b2")) && !getdvarint(#"hash_730311c63805303a", 0)) {
    return;
  }

  content_manager::register_script(#"monster_house", &function_66c8033b, 1);
}

function function_66c8033b(instance) {
  s_start = instance.contentgroups[#"start_crystal"][0];
  instance.var_8b241b32 = s_start.origin;
  mdl_start = function_4b312787(s_start);

  if(mdl_start clientfield::is_registered("perk_death_perception_item_marked_for_rob")) {
    mdl_start clientfield::set("perk_death_perception_item_marked_for_rob", 1);
  }

  mdl_start.instance = instance;
  instance.var_b9e44637 = mdl_start;
  instance.n_obj_id = zm_utility::function_f5a222a8(#"hash_4ca0447c67516315", instance.var_8b241b32);
  mdl_start callback::function_d8abfc3d(#"hash_5f0caa4b2d44fedf", &function_4c9f2ecc);
  instance flag::wait_till(#"cleanup");
  level thread namespace_9b972177::function_16bede30();

  if(isDefined(instance.n_obj_id)) {
    zm_utility::function_bc5a54a8(instance.n_obj_id);
  }

  a_ai = getaiarray("monster_house_ai", "targetname");

  foreach(ai in a_ai) {
    if(isalive(ai)) {
      gibserverutils::annihilate(ai);
      ai.allowdeath = 1;
      ai kill(undefined, undefined, undefined, undefined, undefined, 1);
      waitframe(1);
    }
  }
}

function private function_4c9f2ecc(s_result) {
  if(isDefined(self.instance) && (isPlayer(s_result.attacker) || isai(s_result.attacker) || isvehicle(s_result.attacker))) {
    self function_3a22c4f4();
    self.instance.var_b9e44637 playSound(#"hash_227254733f1aeabf");
    self.instance.var_b9e44637 playLoopSound(#"hash_42b8b4ed773cbb0b");
    level thread function_37eab05b(self.instance);
  }
}

function private function_37eab05b(instance) {
  level thread function_a77f3600(instance);
  level thread function_2d2fade8(instance);
  level thread function_68aac628(instance, "monsterhouse_low");
  var_d56fdb6 = array::randomize(isDefined(instance.contentgroups[#"spawn_crystal"]) ? instance.contentgroups[#"spawn_crystal"] : []);
  instance.var_eb3bf4b1 = [];
  var_90acdb64 = getplayers().size * 2 + 4;
  n_spawned = 0;
  instance.var_5cbcc78a = var_90acdb64;

  foreach(var_d2ee34ea in var_d56fdb6) {
    mdl_crystal = function_4b312787(var_d2ee34ea);

    if(isDefined(mdl_crystal)) {
      if(mdl_crystal clientfield::is_registered("perk_death_perception_item_marked_for_rob")) {
        mdl_crystal clientfield::set("perk_death_perception_item_marked_for_rob", 1);
      }

      if(!isDefined(instance.var_eb3bf4b1)) {
        instance.var_eb3bf4b1 = [];
      } else if(!isarray(instance.var_eb3bf4b1)) {
        instance.var_eb3bf4b1 = array(instance.var_eb3bf4b1);
      }

      instance.var_eb3bf4b1[instance.var_eb3bf4b1.size] = mdl_crystal;
      n_spawned++;
      mdl_crystal.instance = instance;
      mdl_crystal callback::function_d8abfc3d(#"hash_5f0caa4b2d44fedf", &function_cdec3a88);

      if(n_spawned >= var_90acdb64) {
        level thread function_fa4d3a3e(instance);

        return;
      }

      util::wait_network_frame();
    }
  }
}

function private function_6326cff8() {
  foreach(player in getplayers()) {
    if(isalive(player)) {
      player zm_stats::increment_challenge_stat(#"hash_3e5ce5fa7934ca93");
    }
  }
}

function private function_cdec3a88(s_result) {
  var_eb3bf4b1 = self.instance.var_eb3bf4b1;
  ping::function_9455917d(self);

  if(isDefined(var_eb3bf4b1) && isinarray(var_eb3bf4b1, self) && !self.instance flag::get(#"cleanup")) {
    self function_3a22c4f4();

    if(var_eb3bf4b1.size > 1) {
      arrayremovevalue(var_eb3bf4b1, self);

      if(var_eb3bf4b1.size / self.instance.var_5cbcc78a <= 0.33) {
        level thread function_68aac628(self.instance, "monsterhouse_high");
      } else if(var_eb3bf4b1.size / self.instance.var_5cbcc78a <= 0.66) {
        level thread function_68aac628(self.instance, "monsterhouse_med");
      }

      return;
    }

    self.instance flag::set(#"cleanup");
    self.instance.var_b9e44637 stoploopsound();
    self.instance.var_b9e44637 playSound(#"hash_4e683052f8d3eade");
    level thread function_68aac628(self.instance, "monsterhouse_success");
    level thread function_6326cff8();
    self fx::play(#"hash_124c673fd48c8a4", self.origin, self.angles);
    playsoundatposition(#"hash_4359f21da1a5d177", self.origin + (0, 0, 25));
    level scoreevents::doscoreeventcallback("scoreEventSR", {
      #scoreevent: "event_complete", #nearbyplayers: 1, #var_b0a57f8c: 2000, #location: self.origin
    });
  }
}

function private function_3a22c4f4() {
  self thread function_fc37bb4f("break");

  if(self.model === "p9_sur_crystal_medium_01_orange") {
    self setModel(#"p9_sur_crystal_medium_01_dmg");
    return;
  }

  self setModel(#"p9_sur_crystal_medium_02_dmg");
}

function private function_a77f3600(instance) {
  instance endon(#"cleanup");

  while(true) {
    namespace_2c949ef8::function_8b6ae460(instance.var_8b241b32, "monster_house_ambush_list_realm_" + level.realm, 500, 1500, undefined, undefined, 0, "monster_house_ai");
  }
}

function private function_2d2fade8(instance) {
  instance endon(#"cleanup");
  n_wait_time = 90 + getplayers().size * -10;
  level thread function_84ab63bd(instance, n_wait_time);
  wait n_wait_time;

  iprintlnbold("<dev string:x38>");

  if(isDefined(instance.var_b9e44637)) {
    instance.var_b9e44637 stoploopsound();
    instance.var_b9e44637 playSound(#"hash_2ed05354715fc032");
  }

  level thread function_68aac628(instance, "monsterhouse_fail");

  foreach(mdl_crystal in instance.var_eb3bf4b1) {
    if(!isentity(mdl_crystal)) {
      continue;
    }

    mdl_crystal notify(#"pod_destroyed");
    mdl_crystal notify(#"hash_52a1c0be67192d9b");
    mdl_crystal val::set(#"hash_3f8039e6e19dc02b", "takedamage", 0);
    mdl_crystal thread function_fc37bb4f("inactive");

    if(mdl_crystal.model === "p9_sur_crystal_medium_01_orange") {
      mdl_crystal setModel(#"p9_sur_crystal_medium_01_off");
      continue;
    }

    mdl_crystal setModel(#"p9_sur_crystal_medium_02_off");
  }

  instance flag::set(#"cleanup");
}

function function_84ab63bd(instance, n_wait_time) {
  instance endon(#"cleanup");
  var_286f8a2c = 0.33 * n_wait_time;
  wait var_286f8a2c;
  level thread function_68aac628(instance, "monsterhouse_med");
  wait var_286f8a2c;
  level thread function_68aac628(instance, "monsterhouse_high");
}

function private function_4b312787(struct) {
  if(math::cointoss(50)) {
    model = # "p9_sur_crystal_medium_01_orange";
    str_scene = "p9_zm_gold_sur_crystal_medium_01_bundle";
  } else {
    model = # "p9_sur_crystal_medium_02_orange";
    str_scene = "p9_zm_gold_sur_crystal_medium_02_bundle";
  }

  mdl_crystal = content_manager::spawn_script_model(struct, model);
  mdl_crystal setscale(randomfloatrange(0.9, 1.1));
  mdl_crystal val::set(#"hash_3f8039e6e19dc02b", "takedamage", 1);
  mdl_crystal.health = 5;
  mdl_crystal.var_ef3ac4e = # "hash_73df079d82dffbb";
  mdl_crystal.var_9880bf81 = 1;
  mdl_crystal thread function_fc37bb4f("active");
  mdl_crystal thread scene::play(str_scene, mdl_crystal);
  mdl_crystal fx::play(#"hash_55757df7429e3ca6", mdl_crystal.origin, mdl_crystal.angles, #"pod_destroyed", 1);
  level thread namespace_58949729::function_8265e656(mdl_crystal);
  return mdl_crystal;
}

function function_fc37bb4f(str_type) {
  if(!isDefined(self)) {
    return;
  }

  self endon(#"death");

  switch (str_type) {
    case # "active":
      self playSound(#"hash_1b7654f4f0a7838");
      self playLoopSound(#"hash_1b70ba6d6b31bb21");
      break;
    case # "break":
      self stoploopsound();
      waitframe(1);
      self playSound(#"hash_4edec6e285df4ad8");
      break;
    case # "inactive":
      self stoploopsound();
      waitframe(1);
      self playSound(#"hash_48c691f36c44892c");
      break;
  }
}

function function_68aac628(instance, var_9c1ed9ea) {
  if(!isDefined(instance.var_de3f63de) || instance.var_de3f63de != var_9c1ed9ea) {
    instance.var_de3f63de = var_9c1ed9ea;
    level namespace_9b972177::function_9a65b730(var_9c1ed9ea);
  }
}

function private function_fa4d3a3e(instance) {
  if(!getdvarint(#"hash_730311c63805303a", 0)) {
    return;
  }

  level endon(#"portal_activated");
  var_d56fdb6 = isDefined(instance.contentgroups[#"spawn_crystal"]) ? instance.contentgroups[#"spawn_crystal"] : [];

  while(true) {
    foreach(var_d2ee34ea in var_d56fdb6) {
      sphere(var_d2ee34ea.origin, 6, (0, 1, 1), 0.75, 0, 7, 10);
    }

    foreach(mdl_crystal in instance.var_eb3bf4b1) {
      if(isDefined(mdl_crystal)) {
        sphere(mdl_crystal.origin, 12, (1, 0, 0), 1, 0, 7, 10);
      }
    }

    waitframe(10);
  }
}