/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_61cfc2ab8e60625.gsc
***********************************************/

#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp\cp_takedown_fx;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#namespace namespace_b100dd86;

function init_clientfields() {
  clientfield::register("toplayer", "lerp_fov", 1, 3, "int");
  clientfield::register("toplayer", "force_stream_weapons", 1, 2, "int");
}

function function_9109a1fe() {
  level.adler = self;
  self function_854b5376(1);
  self.radius = 32;
  level thread util::magic_bullet_shield(self);
  a_ar = getweapon(#"ar_accurate_t9", "steadyaim", "reflex");
  self hms_util::function_65d14a19(a_ar);
  self ai::set_behavior_attribute("useGrenades", 0);
  self.script_forcecolor = "o";
}

function function_87d56d50() {
  level.woods = self;
  self function_854b5376(1);
  self.radius = 32;
  self ai::set_behavior_attribute("useGrenades", 0);
  level thread util::magic_bullet_shield(self);
  a_ar = getweapon(#"ar_standard_t9", "steadyaim", "reflex");
  self hms_util::function_65d14a19(a_ar);
  self.script_forcecolor = "c";
}

function function_b61ea696() {
  self.radius = 32;
  self.ignoresuppression = 1;
  self.forcesprint = 1;
  self val::set("sprinter_guy", "ignoreme", 1);
  self val::set("sprinter_guy", "ignoreall", 1);
  self ai::set_behavior_attribute("sprint", 1);
  self waittill(#"goal");
  self val::reset("sprinter_guy", "ignoreme");
  self val::reset("sprinter_guy", "ignoreall");
}

function function_ea49bc9() {
  level.wife = self;
  self.radius = 32;
  self.ignoreall = 1;
  level thread util::magic_bullet_shield(self);
}

function function_c3eb1449() {
  level.police_chief = self;
  self.ignoreall = 1;
  self.ignoreme = 1;
}

function function_170c5fef() {
  level.var_cb7eb1d8 = self;
}

function function_f82142f8(notify_str, body_model) {
  if(isDefined(notify_str)) {
    level waittill(notify_str);
  }

  self setModel(body_model);
}

function swap_head(notify_str, head_model) {
  if(isDefined(notify_str)) {
    level waittill(notify_str);
  }

  if(isDefined(self.hatmodel)) {
    self detach(self.hatmodel);
  }

  if(isDefined(self.head)) {
    self detach(self.head);
  }

  self attach(head_model);
  self.head = head_model;
}

function function_6578b894() {
  self endon(#"death");
  level notify(#"hash_530a04ce72c2c9");
  self thread function_a0f1fa27();
  objectives::follow("obj_takedown_qasim", self, undefined, undefined, 0, #"hash_29f1e9a2d045faaf");
  self val::set(#"qasim", "ignoreall", 1);
  self val::set(#"qasim", "ignoreme", 1);
  self.var_c681e4c1 = 1;
  self.forcesprint = 1;
  self disableaimassist();
  self function_854b5376(1);
  self setdesiredspeed(260);
  lmg = getweapon(#"lmg_light_t9");
  self setweapon(lmg);
  self thread set_ignoreall();
  self thread function_b1518d0e();
  self waittill(#"reached_path_end");
  objectives::remove("obj_takedown_qasim");
  level thread function_c212022b(180);
  self notify(#"hash_637416a1c8f37fe3");
  self deletedelay();
}

function function_c212022b(seconds) {
  level endon(#"hash_530a04ce72c2c9");
  wait seconds;
  util::missionfailedwrapper(#"hash_556f31329ba0db54");
}

function function_a66feb27() {
  self thread function_a0f1fa27();
  level notify(#"hash_530a04ce72c2c9");
  objectives::follow("obj_takedown_qasim", self, undefined, undefined, 0, #"hash_29f1e9a2d045faaf");
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.forcesprint = 1;
  self disableaimassist();
  self ai::set_behavior_attribute("sprint", 1);
  level thread scene::play("scene_tkd_hit2_qasim_vault", "Vault", self);
  self waittill(#"end_vault");
  objectives::hide("obj_takedown_qasim");
  self notify(#"hash_637416a1c8f37fe3");
  self deletedelay();
  level thread function_a3c6d04c();
}

function function_a3c6d04c() {
  objloc = struct::get("obj_jump", "targetname");
  objectives::complete("follow_adler", level.adler);
  objectives::follow("obj_rooftop_jump", objloc.origin, undefined, undefined, 0, #"hash_579ea815337d21d3");
  level flag::wait_till("flag_start_roof_slide");
  objectives::remove("obj_rooftop_jump");
}

function function_b1518d0e() {
  self endon(#"death");
  self flag::wait_till("ignoreall_false");
  self val::reset(#"qasim", "ignoreall");
}

function set_ignoreall() {
  self endon(#"death");
  self flag::wait_till("ignoreall_true");
  self val::set(#"qasim", "ignoreall", 1);
}

function function_a0f1fa27() {
  self endon(#"hash_637416a1c8f37fe3");
  self waittill(#"death");
  util::missionfailedwrapper(#"hash_acfc290b8145de6");
}

function function_3e6a0d68(str_aigroup) {
  var_523ed269 = getspawnerarray(str_aigroup, "script_aigroup");
  aiarray = array();

  foreach(spawner in var_523ed269) {
    guy = spawner spawner::spawn(1);

    if(!isDefined(aiarray)) {
      aiarray = [];
    } else if(!isarray(aiarray)) {
      aiarray = array(aiarray);
    }

    aiarray[aiarray.size] = guy;
  }

  return aiarray;
}

function array_spawn(name, key) {
  var_523ed269 = getspawnerarray(name, key);
  aiarray = array();

  foreach(spawner in var_523ed269) {
    guy = spawner spawnfromspawner(spawner.targetname, 1);

    if(!isDefined(aiarray)) {
      aiarray = [];
    } else if(!isarray(aiarray)) {
      aiarray = array(aiarray);
    }

    aiarray[aiarray.size] = guy;
  }

  return aiarray;
}

function function_53531f27(key, val = "targetname") {
  trig = getent(key, val);

  if(isDefined(trig) && trig istriggerenabled()) {
    trig trigger::use();
  }
}

function function_5431431d() {
  plane = getent("cargo_plane", "targetname");
  plane notsolid();
  var_853687bd = getEntArray("af_plane_triggers", "targetname");
  var_853687bd = arraycombine(var_853687bd, getEntArray("plane_floor_clip", "targetname"));
  var_853687bd = arraycombine(var_853687bd, getEntArray("plane_cargo", "targetname"));

  foreach(thing in var_853687bd) {
    thing enablelinkto();
    thing linkto(plane, "tag_body_animate");
  }

  snd::client_targetname(plane, "cargo_plane");
  plane cp_takedown_fx::function_8e4c996d();
  plane cp_takedown_fx::function_b6cccb8();
  scene::add_scene_func("scene_tkd_hit3_chase_plane", &function_d804fc99, "init");
  plane thread scene::init("scene_tkd_hit3_chase_plane");
  thread function_d60a1c78(plane);
  level.af_plane = plane;
  thread scene::init("scene_tkd_hit3_intro_overlook_arash", [level.af_plane]);
  level.var_c7b3a621 = util::spawn_model("tag_origin", plane.origin - (200, 0, 175), plane.angles);
  level.var_c7b3a621 linkto(plane);
  return plane;
}

function function_d804fc99(a_ents) {
  var_936fb5e7 = ["Prop 1", "Prop 2", "Prop 3", "Prop 4"];

  foreach(prop in var_936fb5e7) {
    if(isDefined(a_ents[prop]) && !isDefined(a_ents[prop].clip)) {
      clip = getent(prop, "script_noteworthy");
      a_ents[prop].clip = clip;
      clip linkto(a_ents[prop], undefined, (0, 0, 0), (0, 0, 0));
    }
  }
}

function function_c8381339(plane, var_857b0901) {
  probe = getent("cargo_probe_1", "targetname");

  if(isDefined(probe)) {
    probe linkto(plane, "tag_body_animate", (-24, 0, 24), (0, 0, 0));
  }

  probe = getent("cargo_probe_2", "targetname");

  if(isDefined(probe)) {
    probe linkto(plane, "tag_body_animate", (-152, 0, 24), (0, 0, 0));
  }

  probe = getent("cargo_probe_3", "targetname");

  if(isDefined(probe)) {
    probe linkto(plane, "tag_body_animate", (-288, 0, 24), (0, 0, 0));
  }

  probe = getent("cargo_probe_4", "targetname");

  if(isDefined(probe)) {
    probe linkto(plane, "tag_body_animate", (-408, 0, -40), (0, 0, 0));
  }

  if(var_857b0901) {
    probe = getent("cargo_probe_5", "targetname");

    if(isDefined(probe)) {
      probe linkto(plane, "tag_body_animate", (-72, 0, -88), (0, 0, 0));
    }

    probe = getent("cargo_probe_6", "targetname");

    if(isDefined(probe)) {
      probe linkto(plane, "tag_body_animate", (72, 280, -48), (0, 0, 0));
    }

    probe = getent("cargo_probe_7", "targetname");

    if(isDefined(probe)) {
      probe linkto(plane, "tag_body_animate", (72, -280, -48), (0, 0, 0));
    }

    probe = getent("cargo_probe_8", "targetname");

    if(isDefined(probe)) {
      probe linkto(plane, "tag_body_animate", (-664, 0, -40), (0, 0, 0));
    }
  }
}

function function_1c77193b(plane) {
  level waittill(#"hash_1e1d8f91cb3b7e82");
  plane cp_takedown_fx::function_675a8b8c();
  self waittill(#"hash_3678fbfcec341cb5");
  plane cp_takedown_fx::function_ee23b003();
}

function function_d60a1c78(plane) {
  wait 0.2;
  level.plane_mover = util::spawn_model("tag_origin", plane.origin, plane.angles);
  plane linkto(level.plane_mover, undefined, (0, 0, 0), (0, 0, 0));
}

function function_19919872() {
  level.var_2e151cca = spawner::simple_spawn("af_plane_guy");

  foreach(guy in level.var_2e151cca) {
    guy linkto(level.af_plane, "tag_body_animate");
  }
}

function setup_objectives(var_567f1ddd) {
  switch (var_567f1ddd) {
    default:
      break;
  }
}

function function_5aabc3fb() {
  ents = getEntArray("intro_runway_lights", "targetname");
  array::delete_all(ents);
}