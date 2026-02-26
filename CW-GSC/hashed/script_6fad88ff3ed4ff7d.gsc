/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6fad88ff3ed4ff7d.gsc
***********************************************/

#using script_3dc93ca9902a9cda;
#using script_5c325a0a637fdc2e;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\shared;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\manager;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\achievements;
#using scripts\cp_common\collectibles;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\player_decision;
#using scripts\cp_common\util;
#namespace namespace_b73b9191;

function function_2683ec5d() {
  if(isDefined(level.var_28c22d88[0])) {
    switch (level.var_28c22d88[0]) {
      case # "excavation_finale":
      case # "mountain_summit":
      case # "intro_heli":
      case # "server_reveal":
      case # "server_ascent":
      case # "zipline_intro":
      case # "bunker_explore":
      case # "ice_slide":
      case # "satcom_approach":
      case # "bunker_encounter":
      case # "satcom":
      case # "catwalks":
      case # "woods_regroup":
      case # "zipline_fall":
      case # "excavation":
        var_5b7b93ad = getspawnerarray("woods_ar", "script_noteworthy");
        break;
      default:
        var_5b7b93ad = getspawnerarray("woods_ar", "script_noteworthy");
        break;
    }
  }

  var_5b7b93ad[0] spawner::add_spawn_function(&function_2341d661);
  level.ai_woods = var_5b7b93ad[0] spawner::spawn(1);
}

function function_2341d661() {
  self.goalradius = 64;
  self val::set(#"woods", "allowdeath", 0);
  self ai::set_behavior_attribute("demeanor", "combat");
  self.name = "Woods";
  self.propername = # "hash_22f2861ded3918a8";
  self.script_accuracy = 0.7;
  self.attackeraccuracy = 0.1;
  self function_d432b47b();
}

function function_d432b47b() {
  if(isDefined(level.var_28c22d88[0])) {
    switch (level.var_28c22d88[0]) {
      case # "mountain_summit":
      case # "intro_heli":
      case # "zipline_intro":
      case # "bunker_explore":
      case # "ice_slide":
      case # "satcom_approach":
      case # "bunker_encounter":
      case # "satcom":
      case # "catwalks":
      case # "zipline_fall":
        w_primary = getweapon(#"ar_standard_t9", "reflex", "suppressed2");
        w_secondary = getweapon(#"pistol_semiauto_t9", "suppressed");
        self aiutility::setcurrentweapon(w_primary);
        self aiutility::setprimaryweapon(w_primary);
        self aiutility::setsecondaryweapon(w_secondary);
        self shared::placeweaponon(w_primary, "right");
        break;
      case # "excavation_finale":
      case # "server_reveal":
      case # "server_ascent":
      case # "woods_regroup":
      case # "excavation":
        w_primary = getweapon(#"ar_standard_t9", "reflex");
        w_secondary = getweapon(#"pistol_semiauto_t9");
        self aiutility::setcurrentweapon(w_primary);
        self aiutility::setprimaryweapon(w_primary);
        self aiutility::setsecondaryweapon(w_secondary);
        self shared::placeweaponon(w_primary, "right");
        break;
      default:
        w_primary = getweapon(#"ar_standard_t9", "reflex");
        w_secondary = getweapon(#"pistol_semiauto_t9");
        self aiutility::setcurrentweapon(w_primary);
        self aiutility::setprimaryweapon(w_primary);
        self aiutility::setsecondaryweapon(w_secondary);
        self shared::placeweaponon(w_primary, "right");
        break;
    }
  }
}

function function_48a0851a() {
  self endon(#"death");

  while(level.player === undefined) {
    waitframe(1);
  }

  self setgoal(level.player);
}

function function_5d981106(var_8be63fee, n_count, str_flag) {
  spawner::waittill_ai_group_ai_count(var_8be63fee, n_count);

  if(isalive(level.player)) {
    level flag::set(str_flag);
  }
}

function function_e79ede39(flag) {
  level flag::clear("no_corpse_pickup ");

  while(!stealth_manager::anyone_in_combat() && !flag::get(flag)) {
    wait 0.2;
  }

  level flag::set("no_corpse_pickup ");
}

function function_54b7084f(var_e2454fa1, var_84669fca, var_55e78e1d) {
  while(!isDefined(level.player)) {
    waitframe(1);
  }

  if(isDefined(var_e2454fa1)) {
    level waittill(var_e2454fa1);
  } else if(isDefined(var_84669fca)) {
    wait var_84669fca;
  }

  if(isDefined(var_55e78e1d)) {
    n_damage = floor(level.player.health * var_55e78e1d);
  } else {
    n_damage = floor(level.player.health * 0.8);
  }

  level.player dodamage(n_damage, level.player.origin);
  waitframe(1);

  if(n_damage > 50) {
    level.player.var_4d9b2bc3 = 0;
    level.player val::set(#"zipline_fall", "allow_jump", 0);
    level.player val::set(#"zipline_fall", "allow_sprint", 0);
    level.player setmovespeedscale(0.7);

    while(level.player.health < 100) {
      waitframe(1);
    }

    level.player val::reset(#"zipline_fall", "allow_jump");
    level.player val::reset(#"zipline_fall", "allow_sprint");
    level.player setmovespeedscale(1);
  }
}

function function_608217cf(var_97c45fa7) {
  self ai::disable_pain();
  self ai::set_behavior_attribute("vignette_mode", "fast");
  level flag::wait_till(var_97c45fa7);
  self ai::enable_pain();
  self ai::set_behavior_attribute("vignette_mode", "off");
}

function function_5c5b6ea7(var_13a1bfd8, var_d6acc33, var_1da4b8f4 = 0, b_ignoreall = 0, var_c0116a7f = 0, var_91eb2583 = undefined) {
  level.ai_woods notify(#"new_goal");
  level.ai_woods endon(#"new_goal");

  if(isDefined(var_91eb2583)) {
    level endon(var_91eb2583);
  }

  if(var_1da4b8f4 == 1) {
    level.ai_woods.script_forcegoal = 1;
  }

  if(b_ignoreall == 1) {
    level.ai_woods.ignoreall = 1;
  }

  if(isDefined(var_13a1bfd8) && isDefined(var_d6acc33)) {
    if(var_d6acc33 == "node") {
      nd_start = getnode(var_13a1bfd8, "targetname");

      if(isDefined(level.ai_woods.script_force_color)) {
        level.ai_woods colors::color_force_goal(nd_start);
      } else {
        level.ai_woods spawner::go_to_node(nd_start);
      }
    } else if(var_d6acc33 == "struct") {
      s_start = struct::get(var_13a1bfd8, "targetname");
      level.ai_woods spawner::go_to_node(s_start, "struct");
    }
  }

  if(var_c0116a7f == 1) {
    waitframe(1);
    level.ai_woods.goalradius = 32;
    level.ai_woods.script_radius = 32;
  }

  if(b_ignoreall == 1) {
    level.ai_woods.ignoreall = 0;
  }

  if(var_1da4b8f4 == 1) {
    level.ai_woods.script_forcegoal = 0;
    level.ai_woods clearforcedgoal();
  }
}

function function_f206e65e(var_b3a058ca, var_83d281d, var_86a56d5f = 1) {
  heli = vehicle::simple_spawn_single(var_83d281d, 1);
  heli thread function_53c06d6e();

  if(var_86a56d5f == 1) {
    heli thread vehicle::go_path();
  }

  return heli;
}

function function_887fdde7(var_7954f958, e_target, var_34fc75ef) {
  self endon(#"death");
  var_876ccac = 0;
  var_446f64ef = 0.1;
  var_31ecd8a5 = 0.5;
  var_caad4850 = undefined;
  self turretsettarget(0, e_target.origin);
  self turretsettarget(1, e_target.origin);
  var_7060da37 = self gettagorigin("tag_fx_light_wing_left") + (60, 200, -10);
  var_dce1d2d1 = self gettagorigin("tag_fx_light_wing_right") + (-60, 200, -10);

  while(var_876ccac < var_34fc75ef) {
    if(!isDefined(e_target) && isDefined(var_caad4850)) {
      target_vector = var_caad4850;
    } else if(!isDefined(e_target) && !isDefined(var_caad4850)) {
      break;
    } else if(isDefined(e_target)) {
      target_vector = e_target.origin;
    }

    if(var_7954f958 == "front") {
      magicbullet(getweapon("player_hind_gunner1_turret"), self gettagorigin("tag_gunner_flash1"), target_vector, self);
      var_876ccac += var_446f64ef;
      wait var_446f64ef;
    } else if(var_7954f958 == "side") {
      magicbullet(getweapon("player_hind_main_turret_3rd_person"), var_7060da37, target_vector, self);
      magicbullet(getweapon("player_hind_main_turret_3rd_person"), var_dce1d2d1, target_vector, self);
      var_876ccac += var_31ecd8a5;
      wait var_31ecd8a5;
    }

    var_caad4850 = target_vector;
  }

  self turretcleartarget(0);
  self turretcleartarget(1);
}

function function_53c06d6e(var_80561a4a = 0, turn_on_lights = 1, var_dbce26d4 = 1, var_3f8e3ea9 = 1, var_52fa354e = 1) {
  var_8734dfd9 = undefined;
  var_7cb53dc = undefined;
  var_5e36f96c = undefined;
  var_d20a4380 = undefined;
  var_87c3ba4a = undefined;

  if(isstring(var_80561a4a)) {
    params = strtok(var_80561a4a, ",");

    if(isDefined(params[0])) {
      var_8734dfd9 = params[0];
    } else {
      var_8734dfd9 = 0;
    }

    if(isDefined(params[1])) {
      var_87c3ba4a = params[1];
    } else {
      var_87c3ba4a = turn_on_lights;
    }

    if(isDefined(params[2])) {
      var_7cb53dc = params[2];
    } else {
      var_7cb53dc = var_dbce26d4;
    }

    if(isDefined(params[3])) {
      var_5e36f96c = params[3];
    } else {
      var_5e36f96c = var_3f8e3ea9;
    }

    if(isDefined(params[4])) {
      var_d20a4380 = params[4];
    } else {
      var_d20a4380 = var_52fa354e;
    }
  } else {
    var_8734dfd9 = var_80561a4a;
    var_87c3ba4a = turn_on_lights;
    var_7cb53dc = var_dbce26d4;
    var_5e36f96c = var_3f8e3ea9;
    var_d20a4380 = var_52fa354e;
  }

  if(is_true(var_7cb53dc)) {
    self vehicle::toggle_tread_fx(1);
  }

  if(is_true(var_5e36f96c)) {
    self vehicle::toggle_exhaust_fx(1);
  }

  if(is_true(var_d20a4380)) {
    self thread function_7e3b4837(var_8734dfd9);
  }

  self function_388cae02(1);

  if(!is_true(self.nolights) || is_true(var_87c3ba4a)) {
    self vehicle::lights_on();
  }
}

function function_388cae02(speed) {
  if(!isDefined(speed)) {
    return;
  }

  f_speed = speed;

  if(isstring(speed)) {
    f_speed = float(speed);
  }

  self setrotorspeed(f_speed);
}

function function_7e3b4837(var_80561a4a) {
  self endon(#"death", #"exit_vehicle");

  if(is_true(var_80561a4a)) {
    if(isDefined(self.var_42cfec27) && self.var_42cfec27 != "") {
      var_b0c85051 = soundgetplaybacktime(self.var_42cfec27) * 0.001;
      var_b0c85051 -= 0.5;

      if(var_b0c85051 > 0) {
        var_b0c85051 = math::clamp(var_b0c85051, 0.25, 1.5);
        self playSound(self.var_42cfec27);
        wait var_b0c85051;
      }
    }
  }

  self vehicle::toggle_sounds(1);
}

function function_15426f9d(name) {
  clientfield::set(name, 2);
}

function function_ee83e03a(name) {
  clientfield::set(name, 1);
}

function function_6f1012dd(str_location) {
  var_d87261a4 = struct::get_array("s_corpse_crossbow_bolt_interact", "targetname");

  foreach(var_350bdb56 in var_d87261a4) {
    if(var_350bdb56.str_location === str_location) {
      var_350bdb56 util::create_cursor_hint(undefined, undefined, #"hash_540e42ba8e5725e7");
      var_350bdb56 thread function_700c9104();
    }
  }
}

function function_700c9104() {
  self endon(#"hash_36fff570c9861b");
  self waittill(#"trigger");
  level.player thread function_d7ce9e77(1);
  snd::play("evt_yam_frozen_body_examine", self);
  level flag::set("flg_crossbow_bolt_corpse_interacted_with");
  transient = savegame::function_6440b06b(#"transient");
  transient.var_c99708b8 = 1;
  level thread namespace_7468806b::function_6b5bf445(self.str_location);
  level thread function_2e5072b5(self.str_location);
}

function function_2e5072b5(str_location) {
  var_d87261a4 = struct::get_array("s_corpse_crossbow_bolt_interact", "targetname");

  foreach(var_350bdb56 in var_d87261a4) {
    if(var_350bdb56.str_location === str_location) {
      var_350bdb56 util::remove_cursor_hint();
      var_350bdb56 notify(#"hash_36fff570c9861b");
    }
  }
}

function function_315b14d6() {
  transient = savegame::function_6440b06b(#"transient");

  if(level flag::get("flg_crossbow_bolt_corpse_interacted_with") || is_true(transient.var_c99708b8)) {
    return true;
  }

  return false;
}

function function_d7ce9e77(var_ec3d9404 = 0) {
  self endon(#"death");
  wait var_ec3d9404;
  self clientfield::set_to_player("optional_objective_camera_fx", 1);
  wait 3.5;
  self clientfield::set_to_player("optional_objective_camera_fx", 0);
}

function function_346d9c79() {
  level thread function_cfb0039f("e_collectible_satcom");
  level thread function_cfb0039f("e_collectible_woods_regroup");
  level thread function_cfb0039f("e_collectible_excavation");
  level waittill(#"save_restore");
  level thread function_cfb0039f("e_collectible_satcom");
  level thread function_cfb0039f("e_collectible_woods_regroup");
  level thread function_cfb0039f("e_collectible_excavation");
}

function function_cfb0039f(var_c33719f5) {
  level endon(#"save_restore");
  level flag::wait_till("all_players_connected");
  var_615bb7b5 = getent(var_c33719f5, "targetname");

  if(isDefined(var_615bb7b5)) {
    if(collectibles::function_ab921f3d(5)) {
      var_615bb7b5 delete();
      return;
    }

    var_615bb7b5 util::create_cursor_hint("tag_origin", (0, 0, 4), #"hash_681addf148e5303");
    var_615bb7b5 thread collectibles::function_d06c5a39();
    var_615bb7b5 util::waittill_any_ents(var_615bb7b5, "trigger", level, "flg_collectible_found");

    if(!level flag::get("flg_collectible_found")) {
      level flag::set("flg_collectible_found");
      collectibles::function_6cd091d2(5);
      level.player playgestureviewmodel("ges_t9_cp_yam_intel_inspect");
      snd::play("evt_collectible_gesture_cloth");
    }

    if(isDefined(var_615bb7b5)) {
      var_615bb7b5 delete();
    }
  }
}

function function_97822284(s_params) {
  if(isDefined(self) && isalive(self) && !isDefined(self.var_97b7f7bf) && isDefined(s_params.eattacker) && !s_params.weapon hms_util::is_tactical_grenade()) {
    self.var_97b7f7bf = 1;
    self dodamage(5000, s_params.eattacker.origin, s_params.eattacker, s_params.eattacker, s_params.shitloc, s_params.smeansofdeath, 0, s_params.weapon);
  }
}

function function_29b49cb5() {
  missionid = savegame::function_8136eb5a();
  var_212d7370 = getweapon(#"hash_3ed4419427e0d85a");
  var_a44b6842 = getweapon(#"hash_165cf52ce418f5a1");
  a_weapon_list = level.player getweaponslist();

  if(isinarray(a_weapon_list, var_212d7370) || isinarray(a_weapon_list, var_a44b6842)) {
    savegame::function_379f84b3();
    return;
  }

  if(isDefined(world.mapdata[missionid][#"transient"].var_2e7c022f)) {
    world.mapdata[missionid][#"transient"].var_2e7c022f = undefined;
    world.mapdata[missionid][#"transient"].var_37017d9 = undefined;
    world.mapdata[missionid][#"transient"].var_ba4d1bad = undefined;
  }
}

function function_34163738() {
  missionid = savegame::function_8136eb5a();

  if(isDefined(world.mapdata[missionid][#"transient"].var_2e7c022f)) {
    level.var_7334dc42 = world.mapdata[missionid][#"transient"].var_2e7c022f;
    return true;
  }

  return false;
}

function function_91e76e2e(s_params) {
  if(isPlayer(s_params.eattacker) && is_true(s_params.eattacker.is_ziplining) && isDefined(s_params.weapon) && s_params.weapon hms_util::function_17fe30b7()) {
    level.player achievements::give_achievement(#"cp_achievement_patriot_arrow");
  }
}

function function_5b62c8af() {
  level flag::wait_till("flg_fall_death");
  util::screen_fade_out(0.5, "white");
  wait 2;
  util::screen_fade_out(0, "black");
  level flag::clear("flg_fall_death");
  util::missionfailedwrapper();
}