/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3b7c3b99b28b21b7.gsc
***********************************************/

#using script_210ec734a4149bac;
#using script_3c70d86dfe255354;
#using script_3dc93ca9902a9cda;
#using script_6f92dbd09c4e8204;
#using script_758226507b1afa11;
#using script_7e8d968512a21e26;
#using script_86ebb5dd573a003;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\districts;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flashlight;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\enemy;
#using scripts\core_common\stealth\threat_sight;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\teleport_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp\cp_ger_stakeout_fx;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#using scripts\weapons\cp\spy_camera;
#namespace namespace_acaa3a2e;

function init_flags() {
  level flag::init("fade_in_rooftop_door_amb");
  level flag::init("saw_kraus");
  level flag::init("used_binocs");
  level flag::init("sign_spotlight_away");
  level flag::init("start_camera_hints");
  level flag::init("at_street_overlook");
  level flag::init("identify_kraus_done");
  level flag::init("rooftop_vo_done");
  level flag::init("wall_done");
  level flag::init("street_player_captured");
  level flag::init("kraus_reached_bar");
}

function function_22b7fffd() {
  animation::add_notetrack_func("cp_ger_stakeout_wall::assign_my_umbrella", &function_39369cca);
  scene::add_scene_func("aib_vign_stakeout_harass_check_papers", &function_5e77e85, "play");
  var_cbd9930a = getEntArray("checkpoint_trunk_props", "targetname");
  array::run_all(var_cbd9930a, &hide);
}

function wall_start(str_objective) {
  util::function_268bdf4f("adler", &namespace_11998b8f::function_2f0f0a84);
  level flag::set("start_berlin_wall_lighting");
  var_27e33204 = struct::get("ghost_station_open_manhole_anim_org");
  var_27e33204 struct::delete();
  manhole_target = struct::get("manhole_target");
  var_3fc9accf = getent("ghost_station_exit_sewer_cover", "targetname");
  var_3fc9accf.origin = manhole_target.origin;
  var_3fc9accf.angles = manhole_target.angles;
  getent("sewer_cover_clip", "targetname") delete();
}

function function_cca0368(str_objective, var_50cc0d4f) {
  scene::add_scene_func("aib_vign_stakeout_wall_gl", &function_a23963d2, "init");
  scene::add_scene_func("aib_vign_stakeout_wall_gl", &function_ba702467, "wall_acroof");
  player = getplayers()[0];
  namespace_5ceacc03::music("4.0_rooftops");

  if(var_50cc0d4f) {
    level scene::init("aib_vign_stakeout_wall_gl");
    level scene::init("aib_vign_stakeout_wall_alley_door");
    player namespace_979752dc::set_disguised(1);
    player setmovespeedscale(0.72);
    level namespace_979752dc::function_2324f175(0);
  }

  level thread function_4e2b941a();
  level thread namespace_11998b8f::function_de88eefd();
  level.var_4e5a623b = 1;
  level thread wall_adler();
  level thread function_713528d5();
  level thread identify_kraus();
  level thread function_e76b838d();
  level thread function_11a4c23();
  level thread function_13778421();
  level thread function_3fae1e4a();
  level thread namespace_5ceacc03::function_ddb87390();
  level flag::wait_till("move_wall_allies_01");
  player val::reset("ghost_station_exit", "allow_melee");
  level flag::wait_till("move_wall_allies_01a");
  savegame::checkpoint_save();
  level flag::wait_till_all(array("player_at_street_overlook", "ally_at_street_overlook"));
  level flag::set("at_street_overlook");
  namespace_5ceacc03::music("4.0_rooftops_stinger_2");
  level flag::set("wall_done");
  skipto::function_4e3ab877("wall");
}

function function_f39fdd43(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  if(player) {
    level flag::set("climbed_out_of_sewer");
    level flag::set("at_street_overlook");
    level flag::set("move_wall_allies_01a");
    level flag::set("approach_spotlight_done");
  }

  if(level scene::is_active("p9_fxanim_cp_stakeout_rooftop_pigeons_bundle")) {
    level thread scene::stop("p9_fxanim_cp_stakeout_rooftop_pigeons_bundle", 1);
  }

  if(level scene::is_ready("p9_fxanim_cp_stakeout_subway_train_passing_conduit_bundle")) {
    level thread scene::stop("p9_fxanim_cp_stakeout_subway_train_passing_conduit_bundle", 1);
  }

  if(level scene::is_ready("p9_fxanim_cp_stakeout_subway_train_passing_wires_bundle")) {
    level thread scene::stop("p9_fxanim_cp_stakeout_subway_train_passing_wires_bundle", 1);
  }

  if(level scene::is_ready("p9_fxanim_cp_stakeout_subway_train_passing_bottles_bundle")) {
    level thread scene::stop("p9_fxanim_cp_stakeout_subway_train_passing_bottles_bundle", 1);
  }

  if(level scene::is_ready("p9_fxanim_cp_stakeout_subway_door_breach_bundle")) {
    level thread scene::stop("p9_fxanim_cp_stakeout_subway_door_breach_bundle", 1);
  }

  if(level scene::is_ready("p9_fxanim_cp_stakeout_sewer_rats_bundle")) {
    level thread scene::stop("p9_fxanim_cp_stakeout_sewer_rats_bundle", 1);
  }

  var_b23faf66 = array("ghost_station_right_platform_despawn_closet_door_1", "ghost_station_right_platform_despawn_closet_door_2", "ghost_station_right_platform_despawn_closet_door_3", "guard_station_door_left", "guard_station_door_right");

  foreach(door_targetname in var_b23faf66) {
    door = doors::get_doors(door_targetname);

    if(isDefined(door)) {
      doors::function_3353d645(door_targetname);
    }
  }

  guard_room_shelf_clip = getent("guard_room_shelf_clip", "targetname");

  if(isDefined(guard_room_shelf_clip)) {
    guard_room_shelf_clip delete();
  }

  if(isDefined(level.var_7f69cef1)) {
    level.var_7f69cef1 delete();
  }

  ghost_station_exit_sewer_cover = getent("ghost_station_exit_sewer_cover", "targetname");

  if(isDefined(ghost_station_exit_sewer_cover)) {
    ghost_station_exit_sewer_cover delete();
  }

  var_aa11c33f = getent("sewer_cover_clip", "targetname");

  if(isDefined(var_aa11c33f)) {
    var_aa11c33f delete();
  }

  if(!player) {
    var_73a23c23 = getcorpsearray();

    foreach(corpse in var_73a23c23) {
      if(isDefined(corpse)) {
        corpse delete();
      }
    }
  }
}

function function_4e2b941a() {
  level flag::wait_till("player_out_of_doors");
  var_62f78985 = getent("adler_roof_door1", "targetname");
  var_62f78985 unlink();
  var_62f78985 rotateto(var_62f78985.original_angles, 0.5);
  wait 0.5;
  districts::function_930f8c81("tunnels");
  districts::function_a7d79fcb("tailor_and_alley");
}

function function_a23963d2(a_ents) {
  namespace_3aaa42f7::function_d1bc79a0("adler_alley_door", a_ents[# "hash_475ee55621b83ca0"]);
}

function function_ba702467(a_ents) {
  namespace_3aaa42f7::function_d1bc79a0("adler_roof_door1", a_ents[# "hash_475ee55621b83ca0"]);
}

function wall_adler() {
  level.adler val::set("wall_adler", "ignoreall", 1);
  level.adler val::set("wall_adler", "ignoreme", 1);
  level thread function_7ad62e4();
}

function function_7ad62e4() {
  level flag::wait_till("go_in_roof_door");
  level scene::stop("aib_vign_stakeout_wall_alley_door");
  level scene::play("aib_vign_stakeout_wall_gl", "wall_start");
  exploder::exploder("fx_exp_wall_lightning");
  var_38d138fb = [];
  var_38d138fb[var_38d138fb.size] = "vox_cp_stkt_04004_adlr_wehavetogotothe_34";
  var_38d138fb[var_38d138fb.size] = "vox_cp_stkt_04004_adlr_letsmovetothero_25";
  var_38d138fb[var_38d138fb.size] = "vox_cp_stkt_04004_adlr_weneedtogettoth_96";
  level.adler thread namespace_11998b8f::function_ec76072d(15, var_38d138fb, 15, "move_wall_allies_01a");
  level thread scene::play("aib_vign_stakeout_wall_gl", "wall_door_loop");
  level flag::wait_till_all(array("move_wall_allies_01a", "approach_spotlight_done"));
  scene::add_scene_func("aib_vign_stakeout_street_rooftop_descend", &namespace_dd1bf157::function_bd064da5, "init");
  level scene::init("aib_vign_stakeout_street_rooftop_descend");
  namespace_5ceacc03::music("4.0_rooftops_stinger_1");
  level flag::set("fade_in_rooftop_door_amb");
  level thread namespace_5ceacc03::function_bc932ea6();
  snd::play("amb_thunder_rumble");
  level thread namespace_3e1df757::function_fafe48ab();
  level notify(#"hash_7bbbeb96c2b3efcd");
  level scene::play("aib_vign_stakeout_wall_gl", "wall_acroof");

  if(!level flag::get("move_wall_allies_02")) {
    level thread scene::play("aib_vign_stakeout_wall_gl", "wall_roof_wait_in");
    wait 7;
    level flag::wait_till("move_wall_allies_02");
    level scene::play("aib_vign_stakeout_wall_gl", "wall_roof_wait_out");
  } else {
    level scene::play("aib_vign_stakeout_wall_gl", "wall_roof_goahead");
  }

  level scene::play("aib_vign_stakeout_wall_gl", "wall_finish");
  level.adler setgoal(level.adler.origin);
  level thread scene::play("aib_vign_stakeout_wall_gl", "wall_finish_loop");
}

function function_713528d5(skipto) {
  level thread function_4fbe7d07(skipto);
  level thread function_a673fa00(skipto);

  if(!is_true(skipto)) {
    level flag::wait_till("move_wall_allies_02a");
  }

  level thread namespace_dd1bf157::function_16806e9();

  if(!is_true(skipto)) {
    level flag::wait_till("start_umbrella_civ_01");
  }

  scene::add_scene_func("scene_z_stk_wall_umbrella_civs", &function_5e77e85, "play");
  scene::add_scene_func("scene_z_stk_wall_umbrella_civs", &function_c15c5894, "done");
  level thread scene::play("scene_z_stk_wall_umbrella_civs");

  if(!is_true(skipto)) {
    level thread checkpoint_scene();
  } else {
    level thread checkpoint_scene(skipto);
  }

  if(!is_true(skipto)) {
    level flag::wait_till("start_umbrella_civ_02");
  }

  scene::add_scene_func("scene_z_stk_wall_umbrella_civs2", &function_5e77e85, "play");
  scene::add_scene_func("scene_z_stk_wall_umbrella_civs2", &function_c15c5894, "done");
  level thread scene::play("scene_z_stk_wall_umbrella_civs2");
}

function function_4fbe7d07(skipto) {
  if(!is_true(skipto)) {
    level flag::wait_till("move_wall_allies_01a");
  }

  level.wall_enemies = spawner::simple_spawn("wall_enemies", &function_6a048393);
  level.wall_tower_enemies = spawner::simple_spawn("wall_tower_enemies", &function_6a048393);
  level scene::init("scene_z_stk_tower_patrol", level.wall_tower_enemies);

  if(!is_true(skipto)) {
    level flag::wait_till("move_wall_allies_02a");
    level scene::play("scene_z_stk_tower_patrol", level.wall_tower_enemies);
  } else {
    level scene::play_from_time("scene_z_stk_tower_patrol", level.wall_tower_enemies, undefined, 0.9, 1);
  }

  level flag::set("move_tower_patrol");
}

function function_6a048393() {
  self endon(#"death");
  self stealth_enemy::set_blind(1);
  self.holdfire = 1;
  self.goalradius = 32;
  self thread function_fadf5523("checkpoint");

  if(self.script_noteworthy === "flashlight_guy") {
    self.flashlightoverride = 1;
  }

  if(self.script_noteworthy === "flashlight_idle") {
    scripted_node = struct::get(self.target, "targetname");
    self flashlight::function_65e5c8c8(1);
    self.flashlightfxoverridetag = "tag_light";
    self flashlight::function_7c2f623b();
    scripted_node thread scene::play("aib_vign_stakeout_wall_flashlight_idle", "flashlight_idle_1");
    return;
  }

  if(isDefined(self.target)) {
    scripted_node = struct::get(self.target, "targetname");

    if(isDefined(scripted_node.animation)) {
      if(!isDefined(self.animname)) {
        self.animname = "generic";
      }
    }
  }
}

function function_fadf5523(str_id) {
  self endon(#"death");
  level endon(#"street_done", #"bar_bathroom_door_locked");
  self notify("19809a5b0df768ba");
  self endon("19809a5b0df768ba");
  self.var_34415c06 = str_id;
  self val::set(str_id, "ignoreall", 1);
  self val::set(str_id, "ignoreme", 1);
  self callback::on_death(&function_e5e997f3);
  util::waittill_any_ents(self, "alert_level_increase", self, "damage", self, "stealth_investigate", self, "stealth_combat", level, "stealth_spotted", level, "flag_fail_street", level, "street_car_scene_end");
  level notify(#"street_car_scene_end");
  self notify(#"alert");

  if(str_id == "checkpoint" && level scene::is_active("scene_z_stk_tower_patrol")) {
    level scene::stop("scene_z_stk_tower_patrol");
  }

  if(str_id == "checkpoint_scene") {
    self animation::stop();
  }

  if(str_id == "bar" && level scene::is_active("cin_stakeout_street_bar_guys")) {
    self animation::stop();
  }

  self val::reset(str_id, "ignoreall");
  self val::reset(str_id, "ignoreme");
  player = getplayers()[0];
  self function_a3fcf9e0("attack", player, player.origin);
}

function function_e5e997f3(params) {
  if(isDefined(params.attacker) && isPlayer(params.attacker)) {
    level notify(#"guard_killed");
  }
}

function function_39369cca(params) {
  if(isDefined(self.var_a0639f34)) {
    return;
  }

  if(isDefined(params)) {
    if(isstring(params)) {
      a_strings = strtok(params, ",");
    }

    self.var_a0639f34 = spawnStruct();
    self.var_a0639f34.name = undefined;
    self.var_a0639f34.hand = undefined;

    if(isDefined(a_strings[0])) {
      self.var_a0639f34.name = a_strings[0];
    }

    if(isDefined(a_strings[1])) {
      self.var_a0639f34.hand = a_strings[1];
    }
  }
}

function function_5e77e85(a_ents) {
  foreach(actor in a_ents) {
    if(isactor(actor)) {
      if(!isDefined(actor.animname) || isDefined(actor.animname) && !issubstr(actor.animname, "guard")) {
        actor thread function_106c684b(a_ents);
      }
    }
  }
}

function function_c15c5894(a_ents) {
  if(level flag::get_any(array("stealth_spotted", "street_umbrella_drop"))) {
    return;
  }

  array::delete_all(a_ents);
}

function function_2322903a() {
  self endon(#"death");
  level endon(#"street_done");
  level waittill(#"street_car_scene_end");
  self animation::stop();
  self physicslaunch(self gettagorigin("j_briefcase_handle") + (0, 0, 2), (2, 2, -3));
}

function function_106c684b(a_ents, ender) {
  if(isDefined(ender)) {
    self endon(ender);
  }

  self endon(#"death");
  level endon(#"street_done");
  util::waittill_any_ents(self, "damage", level, "street_car_scene_end");
  level flag::set("street_umbrella_drop");

  if(self.health == self.maxhealth && isDefined(self.animname) && self.animname != "kraus") {
    wait randomfloatrange(0.1, 1);
  }

  self thread cp_ger_stakeout_fx::function_a2a2a7e9();
  self animation::stop();

  if(isarray(a_ents)) {
    foreach(ent in a_ents) {
      ent animation::stop();
    }
  } else {
    a_ents animation::stop();
  }

  if(isDefined(self.var_a0639f34) && isDefined(self.var_a0639f34.name)) {
    if(is_true(self.var_a0639f34.hand == "left")) {
      anim_org = util::spawn_model("tag_origin", self gettagorigin("tag_accessory_left"), self gettagangles("tag_accessory_left"));

      if(isarray(a_ents)) {
        anim_org thread scene::play("scene_z_stk_umbrella_left_drop", a_ents[self.var_a0639f34.name]);
      } else {
        anim_org thread scene::play("scene_z_stk_umbrella_left_drop", a_ents);
      }
    } else {
      anim_org = util::spawn_model("tag_origin", self gettagorigin("tag_accessory_right"), self gettagangles("tag_accessory_right"));

      if(isarray(a_ents)) {
        anim_org thread scene::play("scene_z_stk_umbrella_right_drop", a_ents[self.var_a0639f34.name]);
      } else {
        anim_org thread scene::play("scene_z_stk_umbrella_right_drop", a_ents);
      }
    }
  }

  self.var_c0321be9 = 1;

  if(!level flag::get("stealth_spotted")) {
    level flag::set("stealth_spotted");
  }
}

function function_8f97bdc0() {
  self endon(#"death");
  level endon(#"street_done");
  util::waittill_any_ents(self, "damage", level, "street_car_scene_end");

  if(self flag::get("in_car")) {
    self flag::wait_till_clear("in_car");
  }

  self animation::stop();
  self.var_c0321be9 = 1;

  if(!level flag::get("stealth_spotted")) {
    level flag::set("stealth_spotted");
  }
}

function function_ecb49051() {
  self endon(#"death");
  level endon(#"street_done");
  util::waittill_any_ents(self, "damage", level, "street_car_scene_end");
  wait randomfloatrange(0.1, 1);
  self animation::stop();
  self ai::set_behavior_attribute(#"_civ_mode", "panic");

  if(!level flag::get("stealth_spotted")) {
    level flag::set("stealth_spotted");
  }
}

function function_a673fa00(skipto) {
  level endon(#"rooftop_done");
  level.player endon(#"death");

  if(!is_true(skipto)) {
    level flag::wait_till("move_wall_allies_01a");
  }

  player = getplayers()[0];
  player thread function_6ea5318c(skipto);
  util::waittill_any_ents(level, "stealth_spotted", level, "street_car_scene_end", level, "guard_killed");
  player namespace_979752dc::set_disguised(0);
  level.adler dialogue::function_47b06180();

  if(level flag::get("rooftop_done")) {
    return;
  }

  ai_array = getaiteamarray("axis");
  closest_guy = arraygetclosest(player.origin, ai_array);
  closest_guy thread dialogue::queue("vox_cp_stkt_07130_gms2_stoppolice_64");
  wait 2;
  var_ac09f234 = arraysortclosest(ai_array, player.origin, 3);

  foreach(guy in var_ac09f234) {
    guy.holdfire = 0;
  }

  wait 1;
  level util::missionfailedwrapper(#"hash_4c5af5a1cd80371", #"hash_4e9d4bf1d65f17f5");
}

function function_6ea5318c(skipto) {
  self notify("28f8fcb896c07610");
  self endon("28f8fcb896c07610");
  level endon(#"street_car_scene_end", #"street_done");
  self endon(#"death");
  var_bd1c473f = getweapon(#"hash_5dbab0bd6a78c6e5");

  if(!is_true(skipto)) {
    level flag::wait_till("flag_on_rooftop");
  }

  while(true) {
    self waittill(#"weapon_fired");
    var_20c753ae = self getcurrentweapon();

    if(var_20c753ae === level.weaponnone || var_20c753ae === level.var_e3f5eafc || is_true(var_20c753ae.isgadget) || var_20c753ae === var_bd1c473f || weaponhasattachment(var_20c753ae, "suppressed")) {
      waitframe(1);
      continue;
    }

    level notify(#"street_car_scene_end");
  }
}

function function_e76b838d(skipto) {
  level thread namespace_11998b8f::function_2ba7047("west_berlin_window_cards", 8, 20, "bar_done");

  if(!is_true(skipto)) {
    level flag::wait_till("move_wall_allies_01");
  }

  level thread function_43de25e0();

  if(!is_true(skipto)) {
    level flag::wait_till("move_wall_allies_01a");
  }

  level thread function_ffb7e31d();

  if(!is_true(skipto)) {
    level flag::wait_till("move_wall_allies_02a");
  }

  level thread namespace_11998b8f::function_973a721b("vista_car", "street_done");
  var_da154b8a = struct::get_array("wall_street_area_traffic_lights", "targetname");
  array::thread_all(var_da154b8a, &namespace_11998b8f::function_f76805ab, "bar_done");
}

function function_ffb7e31d() {
  logo = getent("vista_building_logo", "targetname");

  while(!level flag::get("street_done")) {
    logo rotateyaw(360, 30, 0, 0);
    wait 30;
  }

  if(isDefined(logo)) {
    logo delete();
  }
}

function function_43de25e0() {
  scene::add_scene_func("p9_fxanim_cp_stakeout_spotlights_rooftop_scripted_bundle", &function_9862307b, "Shot 1");
  scene::add_scene_func("p9_fxanim_cp_stakeout_spotlights_rooftop_scripted_bundle", &function_9862307b, "Shot 2");
  scene::add_scene_func("p9_fxanim_cp_stakeout_spotlights_rooftop_scripted_bundle", &function_becd1d99, "play");
  scene::add_scene_func("p9_fxanim_cp_stakeout_spotlights_rooftop_tower_01_bundle", &function_becd1d99, "play");
  scene::add_scene_func("p9_fxanim_cp_stakeout_spotlights_rooftop_tower_02_bundle", &function_becd1d99, "play");
  scene::add_scene_func("p9_fxanim_cp_stakeout_spotlights_rooftop_tower_03_bundle", &function_becd1d99, "play");
  level thread scene::play("p9_fxanim_cp_stakeout_spotlights_rooftop_tower_01_bundle");
  level thread scene::play("p9_fxanim_cp_stakeout_spotlights_rooftop_tower_02_bundle");
  level thread scene::play("p9_fxanim_cp_stakeout_spotlights_rooftop_tower_03_bundle");
  level thread function_de07a5d6();
}

function function_becd1d99(a_ents) {
  foreach(ent in a_ents) {
    ent setforcenocull();
    ent.script_objective = "street";
  }
}

function function_9862307b(a_ents) {
  if(!isDefined(level.var_fef3d782)) {
    level.var_fef3d782 = a_ents[# "prop 1"];
    level.var_fef3d782 clientfield::set("rooftop_spotlight", 1);
  }
}

function function_de07a5d6() {
  b_first_time = 1;

  while(!level flag::get("street_done")) {
    if(!b_first_time) {
      wait randomintrange(5, 7);
    }

    level scene::play("p9_fxanim_cp_stakeout_spotlights_rooftop_scripted_bundle", "Shot 2");

    if(!flag::get_all(array("move_wall_allies_01a", "approach_spotlight_done"))) {
      level flag::wait_till_all(array("move_wall_allies_01a", "approach_spotlight_done"));
    }

    if(b_first_time) {
      wait 3.5;
    } else {
      wait randomintrange(5, 9);
    }

    b_first_time = 0;
    level scene::play("p9_fxanim_cp_stakeout_spotlights_rooftop_scripted_bundle", "Shot 1");
  }

  if(isDefined(level.var_fef3d782)) {
    level.var_fef3d782 clientfield::set("rooftop_spotlight", 0);
  }
}

function function_11a4c23() {
  level scene::init("p9_fxanim_cp_stakeout_spotlight_roof_approach_bundle");
  trigger::wait_till("t_rooftop_spotlight_approach");
  level scene::play("p9_fxanim_cp_stakeout_spotlight_roof_approach_bundle");
  wait 1;
  level flag::set("approach_spotlight_done");
}

function function_13778421(skipto) {
  scene::add_scene_func("p8_fxanim_gp_pigeon_standing_01_sbundle", &function_30b688c0, "init");
  scene::add_scene_func("p8_fxanim_gp_pigeon_standing_02_sbundle", &function_30b688c0, "init");
  scene::add_scene_func("p8_fxanim_gp_pigeon_standing_03_sbundle", &function_30b688c0, "init");
  scene::add_scene_func("p8_fxanim_gp_pigeon_standing_04_sbundle", &function_30b688c0, "init");

  if(!is_true(skipto)) {
    level flag::wait_till_all(array("move_wall_allies_01a", "approach_spotlight_done"));
  }

  level thread scene::play("p9_fxanim_cp_stakeout_rooftop_pigeons_bundle");
  level thread scene::play("p9_fxanim_cp_stakeout_tarp_rooftop_bundle");
  level thread function_59b4c034();
  level thread scene::init("rooftop_pigeons_ambient", "targetname");
  level flag::wait_till("player_in_bar");
  level scene::stop("rooftop_pigeons_ambient", "targetname", 1);
  level scene::stop("p9_fxanim_cp_stakeout_tarp_rooftop_bundle", 1);
}

function function_30b688c0(a_ents) {
  var_cafbbb40 = a_ents[# "prop 1"];
  thread namespace_5ceacc03::function_11e5f1bd(var_cafbbb40);
}

function function_59b4c034() {
  level thread scene::play("p9_fxanim_cp_stakeout_rooftop_street_traffic_bundle");
  level flag::wait_till("player_in_bar");
  level scene::stop("p9_fxanim_cp_stakeout_rooftop_street_traffic_bundle", 1);
}

function function_bc3cf90d() {
  level flag::wait_till("player_out_of_doors");
  door = getent("adler_roof_door1", "targetname");
  door unlink();
  door.angles = (0, 269, 0);
}

function function_3fae1e4a() {
  level waittill(#"hash_91d8b090b6da8a9");
  dialogue::radio("vox_cp_stkt_04008_park_copythat_9a");
}

function rooftop_start(str_objective) {
  util::function_268bdf4f("adler", &namespace_11998b8f::function_2f0f0a84);
  level flag::set("start_berlin_wall_lighting");
  level thread scene::play("aib_vign_stakeout_wall_gl", "wall_finish_loop");
  level thread function_e76b838d(1);
  level thread function_13778421(1);
  scene::add_scene_func("aib_vign_stakeout_street_rooftop_descend", &namespace_dd1bf157::function_bd064da5, "init");
  level scene::init("aib_vign_stakeout_street_rooftop_descend");
}

function rooftop_main(str_objective, var_50cc0d4f) {
  player = getplayers()[0];

  if(var_50cc0d4f) {
    namespace_5ceacc03::music("4.0_rooftops");
    level.adler val::set("wall_adler", "ignoreall", 1);
    level.adler val::set("wall_adler", "ignoreme", 1);
    level thread namespace_11998b8f::function_de88eefd();
    player namespace_979752dc::set_disguised(1);
    player setmovespeedscale(0.72);
    level namespace_979752dc::function_2324f175(0);
    level.var_4e5a623b = 1;
    level thread function_713528d5(1);
    level thread identify_kraus(1);
  }

  level thread rooftop_vo();
  level flag::wait_till("identify_kraus_done");
  namespace_5ceacc03::music("5.0_kraus");
  level thread function_85133ec9();
  level flag::wait_till("rooftop_vo_done");

  if(player adsButtonPressed()) {
    while(player adsButtonPressed()) {
      waitframe(1);
    }

    wait 0.25;
  }

  level flag::set("rooftop_done");
  skipto::function_4e3ab877("rooftop");
}

function function_85133ec9() {
  level flag::wait_till("flag_player_cleanup_wall");

  if(isDefined(level.wall_enemies)) {
    array::thread_all(level.wall_enemies, &util::auto_delete, undefined, undefined, 1900);
  }
}

function rooftop_cleanup(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  if(player) {
    level flag::set("identify_kraus_done");
    level flag::set("rooftop_done");
    level flag::set("flag_player_cleanup_wall");
    var_cbd9930a = getEntArray("checkpoint_trunk_props", "targetname");
    array::delete_all(var_cbd9930a);
  }
}

function checkpoint_scene(skipto) {
  level endon(#"street_car_scene_end");
  civs = spawner::simple_spawn("cp_civ");
  guards = spawner::simple_spawn("cp_guard");
  scene::add_scene_func("aib_vign_stakeout_wall_checkpoint_scene", &function_3f30a6be, "init");
  actors = arraycombine(civs, guards, 0, 0);

  foreach(actor in actors) {
    if(isDefined(actor.script_noteworthy) && actor.script_noteworthy != "") {
      actor.animname = actor.script_noteworthy;
    }

    actor sethighdetail(1);
  }

  foreach(guard in guards) {
    guard stealth_enemy::set_blind(1);
    guard thread function_fadf5523("checkpoint_scene");
    guard.holdfire = 1;
  }

  foreach(civ in civs) {
    civ thread function_8f97bdc0();
  }

  if(!is_true(skipto)) {
    level thread scene::init("aib_vign_stakeout_wall_checkpoint_scene", actors);
    level flag::wait_till("start_umbrella_civ_02");
    level thread scene::play("aib_vign_stakeout_wall_checkpoint_scene", actors);
    level waittill(#"hash_642ae3c5f89a9501");
    var_cbd9930a = getEntArray("checkpoint_trunk_props", "targetname");
    array::run_all(var_cbd9930a, &show);
    level flag::wait_till("checkpoint_trunk_closed");
    var_cbd9930a = getEntArray("checkpoint_trunk_props", "targetname");
    array::run_all(var_cbd9930a, &delete);
    level.var_1bacfdea flag::wait_till_clear(#"scriptedanim");
  } else {
    level thread scene::init("aib_vign_stakeout_wall_checkpoint_scene", actors);
    waitframe(1);
    level scene::play_from_time("aib_vign_stakeout_wall_checkpoint_scene", "shot 1", actors, 78, 0);
  }

  level thread scene::play("aib_vign_stakeout_wall_checkpoint_scene", "loop", actors);
  level flag::wait_till("bar_done");
  level scene::stop("aib_vign_stakeout_wall_checkpoint_scene", 1);
}

function function_3f30a6be(a_ents) {
  level.var_1bacfdea = a_ents[# "hash_6f5c91c5822ca56b"];
}

function identify_kraus(skipto) {
  level endon(#"street_car_scene_end");
  level.checkpoint_question_guard = spawner::simple_spawn_single("checkpoint_question_guard");
  level.checkpoint_question_guard stealth_enemy::set_blind(1);
  level.checkpoint_question_guard.holdfire = 1;
  level.checkpoint_question_guard thread function_fadf5523("checkpoint_scene");
  player = getplayers()[0];
  level thread function_967ed4a(skipto);
  level flag::wait_till("start_camera_hints");
  player spy_camera::function_6de171e9();
  level thread function_32b46292();
  level flag::wait_till("saw_kraus");
  spy_camera::function_b28ab5a9(level.kraus);
  self notify(#"hash_2977cbecfddfcab6");
  level thread namespace_3e1df757::function_dda7b522();
  level flag::set("identify_kraus_done");
}

function function_967ed4a(skipto) {
  if(!is_true(skipto)) {
    level flag::wait_till("at_street_overlook");
  }

  level.kraus = spawner::simple_spawn_single("kraus_cp_streets");
  level.kraus val::set("identify_kraus", "ignoreall", 1);
  level.kraus val::set("identify_kraus", "ignoreme", 1);
  level.kraus thread function_3f531d4();
  level.kraus thread function_69f72ac5();
  level.kraus.name = "Kraus";
  level.kraus.goalradius = 24;
  spy_camera::function_f785d9e9(level.kraus, 1);
  level.kraus thread namespace_11998b8f::function_d3e635a9("saw_kraus", "photo_taken", "rooftop_done");
  level.kraus thread function_11009074();
}

function function_11009074() {
  level endon(#"mission_failed");
  self endon(#"death");
  level endon(#"street_car_scene_end");
  level.checkpoint_question_anim_org = struct::get("checkpoint_question_anim_org", "targetname");
  self.animname = "kraus";
  self sethighdetail(1);
  level.checkpoint_question_guard sethighdetail(1);
  level.checkpoint_question_guard flashlight::function_bfffb3fe();
  self.var_34fc6abf = getent("kraus_cp_umbrella", "targetname");
  self.var_34fc6abf sethighdetail(1);
  self.var_34fc6abf.animname = "kraus_umbrella";
  self.briefcase = getent("kraus_cp_briefcase", "targetname");
  self.briefcase sethighdetail(1);
  self.briefcase.animname = "kraus_briefcase";
  level.kraus thread function_106c684b(self.var_34fc6abf, "switching_to_overlay");
  self.briefcase thread function_2322903a();
  level thread scene::init("aib_vign_stakeout_wall_checkpoint_question", array(self, level.checkpoint_question_guard, self.briefcase, self.var_34fc6abf));
  wait 8;
  level scene::play("aib_vign_stakeout_wall_checkpoint_question", "shot 1", array(self, level.checkpoint_question_guard, self.briefcase, self.var_34fc6abf));
  level thread scene::play("aib_vign_stakeout_wall_checkpoint_question", "loop", array(self, level.checkpoint_question_guard, self.briefcase, self.var_34fc6abf));
  level flag::wait_till("rooftop_vo_done");
  wait 2;
  self util::delay(0.2, "death", &function_aefb4fb1);
  level.checkpoint_question_guard util::delay(float(function_60d95f53()) / 1000, "death", &function_9c72e558);
  level scene::play("aib_vign_stakeout_wall_checkpoint_question", "exit", array(self, level.checkpoint_question_guard, self.briefcase, self.var_34fc6abf));
}

function function_aefb4fb1() {
  level endon(#"mission_failed");
  self endon(#"death");
  level endon(#"street_car_scene_end");
  self thread function_bfd89ef1();
  exploder::exploder_stop("fx_exp_wall_lightning");
  self flag::wait_till_clear(#"scriptedanim");
  self notify(#"switching_to_overlay");
  self namespace_f592a7b::function_7bd21c92("UMBRELLA_LEFT_AND_BRIEFCASE_RIGHT");
  self.var_34fc6abf util::delay(0.25, undefined, &hide);
  self.briefcase util::delay(0.25, undefined, &hide);
  goal = struct::get("kraus_path_part_2", "targetname");
  self ai::set_behavior_attribute("disablearrivals", 1);
  self thread spawner::go_to_node(goal);
  wait 2;
  self sethighdetail(0);
  self.var_34fc6abf sethighdetail(0);
  self.briefcase sethighdetail(0);
  waitresult = level waittill(#"hash_14642cad37b9cf06", #"kraus_reached_bar");
  self thread function_9a126ef9();
}

function function_9c72e558() {
  level endon(#"mission_failed");
  self endon(#"death");
  level endon(#"street_car_scene_end");
  self flag::wait_till_clear(#"scriptedanim");
  self flashlight::function_65e5c8c8(0);
  struct = struct::get("checkpoint_question_guard_spot_2", "targetname");
  self thread spawner::go_to_node(struct);
  self sethighdetail(0);
  self stealth_enemy::set_blind(0);
}

function function_e0855d12(a_ents) {
  if(!isDefined(level.var_74647f74)) {
    level.var_74647f74 = a_ents[# "hash_5aa24d6a1d003dc2"];
  }

  if(!isDefined(level.var_c49f9f4d)) {
    level.var_c49f9f4d = a_ents[# "hash_3b179fbfb1dea828"];
    level.var_c49f9f4d attach("aac_kitchen_chair_01", "j_prop_1");
    level.var_c49f9f4d attach("stk_glass_beer_bottle_01_open", "j_prop_2");
  }
}

function function_ba06bd3a(a_ents) {
  if(!isDefined(level.var_c0e9c7c4)) {
    level.var_c0e9c7c4 = doors::function_73f09315("bar_front_door");
  }

  level.var_c0e9c7c4.old_origin = level.var_c0e9c7c4.origin;
  level.var_c0e9c7c4.old_angles = level.var_c0e9c7c4.angles;
  level.var_c0e9c7c4 linkto(a_ents[# "hash_5aa24d6a1d003dc2"], "j_prop_1", (0, 0, 0), (0, 0, 0));
}

function function_bfd89ef1() {
  level endon(#"mission_failed");
  self endon(#"death");
  player = getplayers()[0];
  player forcestreambundle("cin_stakeout_wall_bar_enter");
  scene::add_scene_func("cin_stakeout_wall_bar_enter", &function_e0855d12, "init");
  scene::add_scene_func("cin_stakeout_wall_bar_enter", &function_ba06bd3a, "bar_dialogue_exit");
  scene::add_scene_func("cin_stakeout_wall_bar_enter", &function_ba06bd3a, "bar_enter");
  level scene::init("cin_stakeout_wall_bar_enter");
  doors::function_f35467ac("bar_front_door");
}

function function_9a126ef9(str_id) {
  level endon(#"mission_failed");
  self endon(#"death");

  if(!isDefined(str_id) || isDefined(str_id) && str_id != "bar") {
    level thread scene::play("cin_stakeout_wall_bar_enter", "bar_enter", array(self, self.briefcase, self.var_34fc6abf));
    self.var_34fc6abf show();
    self.briefcase show();
    waitframe(1);
    self namespace_f592a7b::function_7bd21c92("NONE");

    if(isDefined(self.civilian_props)) {
      array::delete_all(self.civilian_props);
      self.civilian_props = [];
    }

    self flag::wait_till_clear(#"scriptedanim");
  }

  if(!isDefined(level.var_c0e9c7c4)) {
    level.var_c0e9c7c4 = doors::function_73f09315("bar_front_door");
  }

  level.var_c0e9c7c4 unlink();

  if(isDefined(level.var_c0e9c7c4.old_origin)) {
    level.var_c0e9c7c4.origin = level.var_c0e9c7c4.old_origin;
  }

  if(isDefined(level.var_c0e9c7c4.old_angles)) {
    level.var_c0e9c7c4.angles = level.var_c0e9c7c4.old_angles;
  }

  doors::function_f5dd4f8f("bar_front_door");

  if(isDefined(self.var_34fc6abf)) {
    self.var_34fc6abf delete();
  }

  level thread scene::play("cin_stakeout_wall_bar_enter", "bar_enter_loop", array(self, self.briefcase));
}

function function_69f72ac5() {
  level endon(#"flag_player_cleanup_wall");
  s_waitresult = self waittill(#"death");

  if(isDefined(s_waitresult.attacker) && s_waitresult.attacker === getplayers()[0]) {
    level thread function_cb0dcac();
  }
}

function function_3f531d4() {
  level endon(#"flag_player_cleanup_wall");
  self endon(#"death");

  while(true) {
    s_waitresult = self waittill(#"damage");

    if(isDefined(s_waitresult.attacker) && s_waitresult.attacker == getplayers()[0]) {
      level thread function_cb0dcac();
    }
  }
}

function function_cb0dcac() {
  getplayers()[0] endon(#"death");
  wait 1;
  level util::missionfailedwrapper(#"hash_4c5af5a1cd80371", #"hash_4d106f3a6b13c1a");
}

function function_32b46292() {
  player = getplayers()[0];
  level endon(#"saw_kraus");
  player endon(#"death");
  player function_7d7b4491();
  player thread function_5c4360e6();
  wait 0.1;
  player function_274a9831();
  wait 0.1;
  player function_3b103fbc();
  wait 0.1;

  if(!flag::get("saw_kraus")) {
    player function_44cd5336();
  }
}

function function_5c4360e6() {
  level endon(#"saw_kraus");
  level endon(#"identify_kraus_done");
  wait 45;

  if(!isDefined(objectives::function_285e460(#"hash_2007375ae0a3f86f"))) {
    objectives::goto(#"hash_2007375ae0a3f86f", level.kraus.origin + (0, 0, 72), undefined, 0);
    objectives::function_67f87f80(#"hash_2007375ae0a3f86f", undefined, #"hash_25690fa219cddf5a");
  }
}

function function_7d7b4491() {
  self util::show_hint_text(#"hash_549b99af44962dbf", undefined, "ability_activated_camera", 8);
  self waittill(#"ability_activated_camera");
  level flag::set("camera_activated_first_time");
}

function function_274a9831() {
  level spy_camera::function_f91a82ef(1, #"hash_4f0d57b7fae34a99");
  self waittill(#"hash_59b80e9e535f9788");
  level spy_camera::function_f91a82ef(0);
}

function function_3b103fbc() {
  self endon(#"zoomed");
  clientfield::set_to_player("kraus_zoom_hint_start", 1);
  wait 8;
  self util::show_hint_text(#"hash_70bca84d8e31e618", undefined, "zoomed", 8);
  self waittill(#"zoomed");
}

function function_afc2d473(oldval, newval) {
  if(newval) {
    player = getplayers()[0];
    player notify(#"zoomed");
  }
}

function function_44cd5336() {
  level endon(#"saw_kraus");
  level.kraus waittill(#"hash_54596dc066040d8c");
  self util::show_hint_text(#"hash_1b44f90418fbe7c6", undefined, "saw_kraus", 8);
}

function rooftop_vo() {
  level endon(#"stealth_spotted");
  wait 1;
  level.adler dialogue::queue("vox_cp_stkt_05100_adlr_keepaneyeonthat_23");
  wait 1;
  level flag::set("flag_give_camera");
  level.adler dialogue::queue("vox_cp_stkt_05100_adlr_lookforkrauswit_a4");
  wait 0.5;
  level flag::set("start_camera_hints");
  level thread function_d5a5cf11();
  wait 4;
  level.adler dialogue::queue("vox_cp_stkt_05100_adlr_damnsecuritysev_0b");
  level flag::wait_till_timeout(6, "saw_kraus");

  if(!level flag::get("saw_kraus")) {
    level.adler dialogue::queue("vox_cp_stkt_05100_adlr_nearthecheckpoi_3f");
  }

  if(!level flag::get("camera_activated_first_time")) {
    var_38d138fb = [];
    var_38d138fb[var_38d138fb.size] = "vox_cp_stkt_05100_adlr_bellusethecamer_30";
    var_38d138fb[var_38d138fb.size] = "vox_cp_stkt_05100_adlr_findkrausbefore_08";
    level.adler thread namespace_11998b8f::function_ec76072d(10, var_38d138fb, 15, "camera_activated_first_time");
  }

  level flag::wait_till("saw_kraus");
  level.adler dialogue::queue("vox_cp_stkt_05100_adlr_goodjobthatsour_e3");
  wait 1;
  level flag::wait_till("identify_kraus_done");
  level flag::set("rooftop_vo_done");
}

function function_ecc8b2d() {
  level endon(#"saw_kraus");

  while(!flag::get("saw_kraus")) {
    self waittill(#"hash_54596dc066040d8c");
    level flag::set("kraus_zoom_fail");
    wait 1;
    level flag::clear("kraus_zoom_fail");
  }
}

function function_d5a5cf11() {
  var_54ca8df4 = [];
  var_54ca8df4[var_54ca8df4.size] = "vox_cp_stkt_05100_adlr_thatsnotkraus_c4";
  var_54ca8df4[var_54ca8df4.size] = "vox_cp_stkt_05100_adlr_keeplooking_c6";
  var_54ca8df4[var_54ca8df4.size] = "vox_cp_stkt_05100_adlr_negative_61";
  var_54ca8df4[var_54ca8df4.size] = "vox_cp_stkt_05100_adlr_thatsnothim_fc";
  var_54ca8df4[var_54ca8df4.size] = "vox_cp_stkt_05100_adlr_krausdoesntlook_47";
  var_54ca8df4[var_54ca8df4.size] = "vox_cp_stkt_05100_adlr_notourguy_4a";
  var_54ca8df4[var_54ca8df4.size] = "vox_cp_stkt_05100_adlr_no_eb";
  feedback = arraycopy(var_54ca8df4);
  var_8b6eeb37 = "vox_cp_stkt_05100_adlr_hesnotinuniform_d1";
  player = getplayers()[0];
  level.kraus thread function_ecc8b2d();

  while(true) {
    player waittill(#"take_picture");
    wait 0.2;

    if(!flag::get("saw_kraus")) {
      if(flag::get("kraus_zoom_fail")) {
        continue;
      }

      if(feedback.size == 0) {
        feedback = arraycopy(var_54ca8df4);
      }

      vo = array::random(feedback);
      arrayremovevalue(feedback, vo);
      level.adler dialogue::queue(vo);
      continue;
    }

    break;
  }
}