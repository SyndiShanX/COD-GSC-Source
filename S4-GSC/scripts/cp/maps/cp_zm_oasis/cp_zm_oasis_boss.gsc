/************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_boss.gsc
************************************************************/

init() {
  level._effect["lighting_bolt"] = loadfx("vfx/s4/zombie_ai/vfx_boss_fight_elec");
  level._effect["lighting_bolt_big"] = loadfx("vfx/s4/zombie_ai/vfx_boss_fight_elec_big");
  level._effect["lighting_bolt_alarm"] = loadfx("vfx/s4/zombie_ai/vfx_boss_fight_elec_ready");
  level._effect["lighting_bolt_alarm_big"] = loadfx("vfx/s4/zombie_ai/vfx_boss_fight_elec_ready_big");
  level._effect["lighting_storm"] = loadfx("vfx/s4/zombie_ai/vfx_echo_calm_runner");
  level._effect["lighting_storm_terminate"] = loadfx("vfx/s4/zombie_ai/vfx_boss_fight_storm_terminate");
  level._effect["lighting_storm_trail"] = loadfx("vfx/s4/zombie_ai/vfx_boss_fight_storm_terminate_trail");
  level._effect["anemone_explode"] = loadfx("vfx/s4/zombie_ai/vfx_kortifex_eyes_explode");
  level._effect["rune_shield"] = loadfx("vfx/s4/level/cp_zm_oasis/vfx_rune_shield_lg_stage01");
  level._effect["mq_final_loot_fx"] = loadfx("vfx/s4/zombie/vfx_obj_domination_rune_zmb_spawn");
  level._effect["trap_electric_player"] = loadfx("vfx/s4/zombie/vfx_screen_elec_shock_bot");
  level._effect["electricity_hip_ri"] = loadfx("vfx/s4/zombie_weapon/vfx_cov_deadwire_elec_stun_hip_ri");
  level._effect["electricity_hip_le"] = loadfx("vfx/s4/zombie_weapon/vfx_cov_deadwire_elec_stun_hip_le");
  level._effect["electricity_knee_le"] = loadfx("vfx/s4/zombie_weapon/vfx_cov_deadwire_elec_stun_knee_le");
  level._effect["electricity_knee_ri"] = loadfx("vfx/s4/zombie_weapon/vfx_cov_deadwire_elec_stun_knee_ri");
  level._effect["electricity_shoulder_ri"] = loadfx("vfx/s4/zombie_weapon/vfx_cov_deadwire_elec_stun_shoulder_ri");
  level._effect["electricity_shoulder_le"] = loadfx("vfx/s4/zombie_weapon/vfx_cov_deadwire_elec_stun_shoulder_le");
  level._effect["electricity_elbow_le"] = loadfx("vfx/s4/zombie_weapon/vfx_cov_deadwire_elec_stun_elbow_le");
  level._effect["electricity_elbow_ri"] = loadfx("vfx/s4/zombie_weapon/vfx_cov_deadwire_elec_stun_elbow_ri");
  level._effect["construct_ambient"] = loadfx("vfx/s4/level/cp_zm_oasis/vfx_construct_red_vein");
  level._effect["summon_body"] = loadfx("vfx/s4/zombie_ai/vfx_boss_fight_summon_body");
  level._effect["summon_hand"] = loadfx("vfx/s4/zombie_ai/vfx_boss_fight_summon_hand");
  level._effect["suck_pillar"] = loadfx("vfx/s4/level/cp_zm_oasis/vfx_floating_monolith_energy_element");
  level._effect["healing_body"] = loadfx("vfx/s4/zombie_ai/vfx_boss_fight_healing_body");
  level._effect["healing_hand"] = loadfx("vfx/s4/zombie_ai/vfx_boss_fight_healing_hand");
  level._effect["healing_ground"] = loadfx("vfx/s4/zombie_ai/vfx_boss_fight_healing_glow");
  level._effect["storm_ball"] = loadfx("vfx/s4/zombie_ai/vfx_boss_fight_storm_ball");
  level._effect["storm_explode"] = loadfx("vfx/s4/zombie_ai/vfx_boss_fight_storm_explode");
  level._effect["storm_ball_a"] = loadfx("vfx/s4/zombie_ai/vfx_boss_fight_storm_ball_a");
  level._effect["storm_ball_b"] = loadfx("vfx/s4/zombie_ai/vfx_boss_fight_storm_ball_b");
  level._effect["ring_of_fire"] = loadfx("vfx/s4/zombie_ai/vfx_kortifex_ring_fire");
  level._effect["eye_ambient"] = loadfx("vfx/s4/zombie_ai/vfx_kortifex_eyes_light");
  level._effect["eye_impact"] = loadfx("vfx/s4/zombie_ai/vfx_kortifex_eyes_special_impact");
  level._effect["pillar_explode"] = loadfx("vfx/s4/level/cp_zm_oasis/vfx_floating_monolith_energy_exp");
  level._effect["lighting_bolt_hand_elec"] = loadfx("vfx/s4/zombie_ai/vfx_boss_fight_hand_elec");
  level._effect["lighting_bolt_hand_elec_exp"] = loadfx("vfx/s4/zombie_ai/vfx_boss_fight_hand_elec_exp");
  level._effect["lighting_bolt_hand_elec_trail"] = loadfx("vfx/s4/zombie_ai/vfx_boss_fight_hand_elec_trail");
  level._effect["lighting_bolt_hand_elec_ready"] = loadfx("vfx/s4/zombie_ai/vfx_boss_fight_hand_elec_ready");
  level._effect["lighting_bolt_hand_elec_sub_trail"] = loadfx("vfx/s4/zombie_ai/vfx_boss_fight_hand_elec_trail_a");
  level._effect["hit_decimator_shield"] = loadfx("vfx/s4/zombie/vfx_decimator_shield_hit");
  level._effect["eye_smoke"] = loadfx("vfx/s4/zombie/vfx_kortifex_eyes_hole_sm");
  level._effect["construct_hit_fx"] = loadfx("vfx/s4/level/cp_zm_oasis/vfx_construct_energy_flow_shock_wave");
  level._effect["zombie_heal_fx"] = loadfx("vfx/s4/zombie/vfx_boss_fight_healing_glow_sturmkrieger");
  level._effect["boss_falling_fx"] = loadfx("vfx/s4/zombie/vfx_boss_falling_dust");
  level._effect["shield_flash_fx"] = loadfx("vfx/s4/zombie/vfx_energy_absorbing_y");
  level._effect["hit_construct_fx"] = loadfx("vfx/s4/level/cp_zm_oasis/vfx_floating_monolith_energy_exp_g");
  level._effect["construct_hit_kortifex_fx"] = loadfx("vfx/s4/level/cp_zm_oasis/vfx_construct_imp_shock_wave_exit");
  level._effect["rune_shield_impact"] = loadfx("vfx/s4/level/cp_zm_oasis/vfx_boss_imp_bullet");
  level._effect["kortifex_ambient"] = loadfx("vfx/s4/level/cp_zm_oasis/vfx_kortifex_lighting_ambient");
  level._effect["shield_exp"] = loadfx("vfx/s4/level/cp_zm_oasis/vfx_rune_shield_exp");
  scripts\engine\utility::_id_5C24("introscreen_over");
  var_0 = scripts\engine\utility::getstructarray("kortifex_pos", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_039B)) {
      switch (var_2._id_039B) {
        case "30":
          var_2 setup_kortifex_fight_structs();
          level.kortifex_original_position = var_2;
          break;
        case "40":
          var_2 setup_kortifex_fight_structs();
          break;
        case "50":
          var_2 setup_kortifex_fight_structs();
          break;
      }
    }
  }

  level thread spawn_dark_aether_anemones();
  level.void_construct = getent("void_construct", "targetname");
  level.void_construct.fx_proxy = scripts\cp\utility::_id_E190("tag_origin", level.void_construct.origin, level.void_construct.angles);
  level.void_construct.fx_proxy linkto(level.void_construct);
  playFXOnTag(level._effect["construct_ambient"], level.void_construct.fx_proxy, "tag_origin");
}

spawn_dark_aether_anemones() {
  level.a_anemones = [];
  var_0 = scripts\engine\utility::getstructarray("s_anemones", "targetname");

  foreach(var_2 in var_0) {
    var_3 = _func_03C5("s4_zm_dark_aether_anemone", var_2.origin, var_2.angles);

    if(!isDefined(var_3)) {
      continue;
    }
    var_3 setscriptablepartstate("anemone", "idle");
    var_3.mouth = _func_03C5("s4_zm_dark_aether_anemone_mouth", var_2.origin, var_2.angles);

    if(!isDefined(var_3.mouth)) {
      continue;
    }
    var_3.mouth setscriptablepartstate("anemone_mouth", "idle");
    level.a_anemones = scripts\engine\utility::array_add(level.a_anemones, var_3);
  }

  level thread init_dark_aether_anemones();
}

destroy_dark_aether_crystal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(!isPlayer(var_2) || !isDefined(var_0) || !var_0 _meth_8679("crystal") || var_0 _meth_8575("crystal", 1) == "destroyed") {
    return;
  }
  var_0 setscriptablepartstate("crystal", "destroyed");
  waitframe();

  if(isDefined(var_0)) {
    _id_073D::_id_4FF0("dark_aether_crystal", var_0.origin, var_0.angles, 30);
  }
}

spawn_dark_aether_crystal() {
  if(!isDefined(self.crystal)) {
    var_0 = _func_03C5("s4_zm_dark_aether_crystal_a", self.origin, self.angles);
    self.crystal = var_0;
  }

  self.crystal setscriptablepartstate("crystal", "idle");
}

setup_kortifex_fight_structs() {
  var_0 = scripts\engine\utility::getstructarray(self.target, "targetname");

  foreach(var_2 in var_0) {
    if(var_2._id_039B == "skill_pos") {
      self.skill_pos = var_2;
    }

    if(var_2._id_039B == "spawner_pos") {
      self._id_E1C6 = var_2;
    }

    if(var_2._id_039B == "reward_pos") {
      self.reward_pos = var_2;
    }

    if(var_2._id_039B == "teleport_pos") {
      self.teleport_pos = var_2;
    }

    if(var_2._id_039B == "blocker") {
      self.blocker = var_2;
    }
  }
}

create_body_hit_boxes() {
  self.hitboxes = [];
  create_scriptable_hitbox("kortifex_head", "j_head");
  create_scriptable_hitbox("kortifex_clavicle_l", "j_clavicle_le");
  create_scriptable_hitbox("kortifex_stone_root_l", "l_stone_root_jnt");
  create_scriptable_hitbox("kortifex_clavicle_r", "j_clavicle_ri");
  create_scriptable_hitbox("kortifex_neck", "j_neck");
  create_scriptable_hitbox("kortifex_spine4", "j_spine4");
  create_scriptable_hitbox("kortifex_spine_up", "j_spineupper");
  create_scriptable_hitbox("kortifex_spine_low", "j_spinelower");
  create_scriptable_hitbox("kortifex_elbow_l", "j_elbow_le");
  create_scriptable_hitbox("kortifex_shoulder_l", "j_shoulder_le");
  create_scriptable_hitbox("kortifex_dn_elbow_l", "dn_j_elbow_le");
  create_scriptable_hitbox("kortifex_dn_shoulder_l", "dn_j_shoulder_le");
  create_scriptable_hitbox("kortifex_stone_root_r", "r_stone_root_jnt");
  create_scriptable_hitbox("kortifex_elbow_r", "j_elbow_ri");
  create_scriptable_hitbox("kortifex_dn_elbow_r", "dn_j_elbow_ri");
  create_scriptable_hitbox("kortifex_dn_shoulder_r", "dn_j_shoulder_ri");
  create_scriptable_hitbox("kortifex_shoulder_r", "j_shoulder_ri");
}

create_scriptable_hitbox(var_0, var_1) {
  var_2 = scripts\cp\utility::_id_E190("tag_origin", self gettagorigin(var_1), self gettagangles(var_1));
  var_2 linkto(self, var_1);
  var_2.proxy = _func_03C5("kortifex_head_hitbox", self gettagorigin(var_1), self gettagangles(var_1));
  var_2.proxy setscriptablepartstate("kortifex_head", var_0);
  var_2.proxy _meth_8746(var_2);
  self.hitboxes = scripts\engine\utility::array_add(self.hitboxes, var_2);
}

cleanup_body_hit_boxes() {
  foreach(var_1 in self.hitboxes) {
    if(isDefined(var_1) && isDefined(var_1.proxy) && var_1.proxy.classname == "scriptable") {
      var_1.proxy _meth_86BE();
      var_1 delete();
    }
  }
}

hit_lighting_storm(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(!isPlayer(var_2) || !isDefined(var_0) || !var_0 _meth_8679("cp_sumpf_zombie_head")) {
    return;
  }
  if(isent(var_0.parent)) {
    var_1 = _id_0F74(var_2, var_2, var_1, var_9, var_5, var_10, var_4, var_3);
    var_1 = get_speical_weapon_damage_scale(var_10, var_2, var_1);
    var_0.parent notify("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);

    if(isPlayer(var_2)) {
      var_2 thread _id_071B::_id_FC47("standard");
      scripts\cp\utility::_id_B8F4("ui_hitmarker_default", var_2);
      level thread _id_072E::display_damage_number_internal(var_2, 0, var_1, var_4 + (0, 0, 10));
    }
  }
}

hit_kortifex_body(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(!isPlayer(var_2) || !isDefined(var_0) || !var_0 _meth_8679("kortifex_head")) {
    return;
  }
  if(istrue(level.kortifex.b_protected_by_shield) || !istrue(level.kortifex.b_can_damage)) {
    return;
  }
  if(isPlayer(var_2)) {
    var_2 thread _id_071B::_id_FC47("standard");
  }
}

get_speical_weapon_damage_scale(var_0, var_1, var_2) {
  var_3 = 1;

  if(isDefined(var_0.basename)) {
    if(var_0.basename == "s4_la_walpha2_mp" || var_0.basename == "s4_mg_streak_mp") {
      var_3 = 3;
    } else if(var_0.basename == "s4_pi_raygun_mp") {
      var_3 = 0.15;
    }
  }

  if(isDefined(var_0.classname) && var_0.classname == "rocketlauncher") {
    if(scripts\engine\utility::is_equal(var_0.basename, "s4_ar_tgun_mp")) {
      var_4 = var_1 scripts\cp\cp_weapon::_id_683D(var_0);

      if(isDefined(var_4)) {
        switch (var_4) {
          case 1:
            return 24;
          case 2:
            return 93;
          case 3:
            return 183;
          case 4:
            return 366;
          default:
            return 24;
        }
      }
    } else
      var_3 = 0.2;
  }

  return int(var_2 * var_3);
}

kortifex_eye_take_damage_listener(var_0) {
  level endon("game_ended");
  level endon("kortifex_die");
  self endon("eye_explode");

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_1 = _id_0F74(var_2, var_2, var_1, var_9, var_5, var_10, var_4, var_3, "helmet");
    var_1 = get_speical_weapon_damage_scale(var_10, var_2, var_1);
    var_1 = clamp(var_1, 0, 900);
    var_1 = int(var_1 * 2);

    if(istrue(level.kortifex.b_protected_by_shield) || !istrue(level.kortifex.b_can_damage)) {
      continue;
    }
    if(isDefined(level.kortifex.stage_index) && scripts\cp\utility::_id_88B7(var_0, level.kortifex.stage_index)) {
      self playSound("zmb_kort_eye_impact");
      level notify("damage_kortifex", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, self);

      if(isPlayer(var_2)) {
        level thread _id_072E::display_damage_number_internal(var_2, 1, var_1, self.origin + (0, 0, 50));
        var_2 thread _id_071B::_id_FC47("hitcritical");
        scripts\cp\utility::_id_B8F4("ui_hitmarker_default", var_2);
      }

      if(self == level.kortifex.middle_eye) {
        playFXOnTag(level._effect["eye_impact"], level.kortifex, "j_eyeball_mi");
      } else if(self == level.kortifex.left_eye) {
        playFXOnTag(level._effect["eye_impact"], level.kortifex, "j_eyeball_le");
      } else if(self == level.kortifex.right_eye) {
        playFXOnTag(level._effect["eye_impact"], level.kortifex, "j_eyeball_ri");
      }

      if(!istrue(level.kortifex.b_play_first_hit_eye) && level scripts\engine\utility::_id_5C0C("finish_intro_vo") && !level scripts\engine\utility::_id_5C00("boss_dialogue_busy")) {
        level thread play_sequence_vos(["zm_cpm5_bfs5_krtx_bifa", "zm_cpm5_bfs5_dnrt_bifb", "zm_cpm5_bfs5_krft_bifc"]);
        level.kortifex.b_play_first_hit_eye = 1;
      }
    }
  }
}

kortifex_take_damage_listener() {
  level endon("game_ended");
  level endon("kortifex_die");

  for(;;) {
    level waittill("damage_kortifex", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    level.kortifex.health = level.kortifex.health - var_0;
    level.kortifex thread update_kortifex_health_bar(var_0);

    if(level.kortifex.health <= 0) {
      level.kortifex.b_can_damage = 0;

      if(!isent(var_10)) {
        var_10 = level.kortifex.left_eye;
      }

      if(var_10 == level.kortifex.right_eye) {
        playFXOnTag(level._effect["anemone_explode"], self, "j_eyeball_ri");
        level.kortifex.sound_proxy_ri playSound("zmb_kort_3rd_eye_destroy");
        level.kortifex hidepart("j_eyeball_ri");
        var_10 delete();
        turn_kortifex_eyes_fx(1, 0);
      } else {
        playFXOnTag(level._effect["anemone_explode"], self, "j_eyeball_le");
        level.kortifex.sound_proxy_le playSound("zmb_kort_3rd_eye_destroy");
        level.kortifex hidepart("j_eyeball_le");
        var_10 delete();
        turn_kortifex_eyes_fx(2, 0);
      }

      level notify("kortifex_die");
      break;
    } else {
      if(level.kortifex.health <= level.kortifex._id_9C21 * 0.35 && level.kortifex.stage_index == 1) {
        level.kortifex.b_can_damage = 0;
        level.kortifex.stage_index = 2;
        var_11 = 2;
        level notify("jump_to_next_stage", var_11);

        if(!isent(var_10)) {
          var_10 = level.kortifex.right_eye;
        }

        if(var_10 == level.kortifex.right_eye) {
          playFXOnTag(level._effect["anemone_explode"], self, "j_eyeball_ri");
          level.kortifex.sound_proxy_ri playSound("zmb_kort_eye_destroy");
          level.kortifex hidepart("j_eyeball_ri");
          var_10 delete();
          turn_kortifex_eyes_fx(1, 0);
        } else {
          playFXOnTag(level._effect["anemone_explode"], self, "j_eyeball_le");
          level.kortifex.sound_proxy_le playSound("zmb_kort_eye_destroy");
          level.kortifex hidepart("j_eyeball_le");
          var_10 delete();
          turn_kortifex_eyes_fx(2, 0);
        }

        continue;
      }

      if(level.kortifex.health <= level.kortifex._id_9C21 * 0.65 && level.kortifex.stage_index == 0) {
        level.kortifex.b_can_damage = 0;
        level.kortifex.stage_index = 1;
        var_11 = 1;
        level notify("jump_to_next_stage", var_11);
        playFXOnTag(level._effect["anemone_explode"], self, "tag_eye");
        level.kortifex.sound_proxy playSound("zmb_kort_eye_destroy");
        level.kortifex.middle_eye notify("eye_explode");
        level.kortifex.middle_eye delete();
        turn_kortifex_eyes_fx(0, 0);
        level.kortifex hidepart("j_eyeball_mi");
      }
    }
  }
}

set_kortifex_current_stage_health() {
  if(level.kortifex.stage_index == 0) {
    var_0 = 0.35;
  } else if(level.kortifex.stage_index == 1) {
    var_0 = 0.35;
  } else {
    var_0 = 0.3;
  }

  level.kortifex.current_stage_max_health = int(level.kortifex._id_9C21 * var_0);
  level.kortifex.current_stage_health = level.kortifex.current_stage_max_health;
}

remove_dark_aether_location_string(var_0) {
  var_1 = level._id_2F7C;
  var_1._id_1A51 = [];
  var_1._id_1A51["none"] = -1;

  if(!_func_0221(level._id_2F7C._id_2FCD)) {
    return;
  }
  var_2 = 0;

  for(;;) {
    var_3 = tablelookupbyrow(level._id_2F7C._id_2FCD, var_2, 0);

    if(!isDefined(var_3) || var_3 == "") {
      break;
    }

    var_3 = int(var_3);
    var_4 = tablelookupbyrow(level._id_2F7C._id_2FCD, var_2, 3);

    if(var_4 != "area") {} else {
      var_5 = tablelookupbyrow(level._id_2F7C._id_2FCD, var_2, 1);

      if(!istrue(var_0)) {
        if(var_5 == "vercanna_home_soil" || var_5 == "bridge_of_sorrows" || var_5 == "the_shattered_land" || var_5 == "bridge_of_woe" || var_5 == "isle_of_blight" || var_5 == "night_legion_road" || var_5 == "stygian_heights" || var_5 == "chasm_path") {
          var_3 = -1;
        }
      }

      var_1._id_1A51[var_5] = var_3;
    }

    var_2++;
  }

  foreach(var_7 in level.players) {
    if(_func_0107(level._id_2F7C._id_1A53)) {
      foreach(var_9 in level._id_2F7C._id_1A53) {
        if(var_7 istouching(var_9)) {
          var_7 _id_D65C(var_9._id_039B, var_9);
          break;
        }
      }
    }
  }
}

_id_D65C(var_0, var_1) {
  self._id_2F79 = var_0;
  var_2 = level._id_2F7C._id_1A51[var_0];

  if(isDefined(var_2)) {
    self setclientomnvar("ui_callout_area_id", var_2);
  } else if(var_0 != "none") {
    return;
  }
}

kick_off_boss_fight() {
  level endon("game_ended");
  level scripts\engine\utility::_id_5C04("round_spawn_zombies");
  level thread cleanup_all_zombies();
  level.disable_pickup_item_vo = 1;

  if(level._id_11049 <= 20) {
    level.zombie_round_override = 30;
  }

  level thread remove_dark_aether_location_string(0);
  _id_06CB::_id_AA4A(::on_zombie_killed_drop_items);
  level._id_A52A = 1;
  _func_01E3("boss_fight");
  level.kortifex_original_position thread spawn_barricades();
  _id_B267();
  level thread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_papq::fadetowhite(0.3, 1);
  wait 0.4;
  var_0 = scripts\engine\utility::getstructarray("s_crystal", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread spawn_dark_aether_crystal();
  }

  _id_07A1::_id_CEC7(::destroy_dark_aether_crystal);
  _id_07A1::_id_CEC7(::hit_kortifex_body);
  _id_07A1::_id_CEC7(::hit_lighting_storm);
  level.kortifex = scripts\cp\utility::_id_E190("c_s4_zmb_kortifex_fifty", level.kortifex_original_position.origin, level.kortifex_original_position.angles);
  level.kortifex._id_B9FE = level.kortifex_original_position;
  level.kortifex create_body_hit_boxes();

  foreach(var_5 in level.players) {
    if(isPlayer(var_5)) {
      var_5 thread _id_0204();
    }
  }

  playFXOnTag(level._effect["kortifex_ambient"], level.kortifex, "j_spine4");
  level.kortifex _meth_82CB("ai_s4_zm_zombie_kortifex_vignette_intro_02", "boss_fight");
  level thread play_intro_sequence_vos(["zm_cpm5_bfs5_krtx_biae", "zm_cpm5_bfs5_krtx_biba", "zm_cpm5_bfs5_dnvk_bibb"]);
  level.kortifex waittillmatch("boss_fight", "shake");
  level thread skill_screen_shake();
  level.kortifex waittillmatch("boss_fight", "finish");
  level.kortifex.stage_index = 0;
  level.kortifex.common_skill_cool_down_time = 8.5;
  level.kortifex.b_common_cool_down = 1;
  level.kortifex._id_2038 = 0;
  level.kortifex.b_in_healing = 0;
  level.kortifex.spawned_actors = [];
  level.kortifex.stun_down_anim_intro = "ai_s4_zm_zombie_kortifex_light_shroud_pain_01";
  level.kortifex.stun_down_anim_loop = "ai_s4_zm_zombie_kortifex_light_shroud_pain_loop_01";
  level.kortifex.stun_down_anim_outro = "ai_s4_zm_zombie_kortifex_light_shroud_pain_outro_01";
  level.kortifex.jump_stage_anim = "ai_s4_zm_zombie_kortifex_light_pain_01";
  level.kortifex.die_anim = "ai_s4_zm_zombie_kortifex_outro_01";
  level.kortifex.idle_anims = ["ai_s4_zm_zombie_kortifex_idle_01"];
  level.kortifex.screen_flash_white = scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_papq::fadetowhite;
  level.kortifex._id_DD78 = [];
  level.kortifex._id_DD78["lighting_bolt"] = spawnStruct();
  level.kortifex._id_DD78["lighting_bolt"].b_cool_down = 1;
  level.kortifex._id_DD78["lighting_bolt"].cool_down_time = 1;
  level.kortifex._id_DD78["lighting_bolt"].lighting_move_speed = 150;
  level.kortifex._id_DD78["lighting_bolt"].lighting_damage = 100;
  level.kortifex._id_DD78["lighting_bolt"].lighting_damage_interval = 3;
  level.kortifex._id_DD78["lighting_bolt"].lighting_damage_radius = 120;
  level.kortifex._id_DD78["lighting_bolt"].life_time = 30;
  level.kortifex._id_DD78["lighting_bolt"].lighting_max_count = 3;
  level.kortifex._id_DD78["lighting_bolt"].lighting_max_kill_zombies = 2;
  level.kortifex._id_DD78["lighting_bolt"].skill_func = ::spawn_lighting;
  level.kortifex._id_DD78["lighting_bolt"].skill_anim = "ai_s4_zm_zombie_kortifex_summon_flash_01";
  level.kortifex._id_DD78["lighting_bolt"].b_vo_cool_down = 1;
  level.kortifex._id_DD78["lighting_bolt"].vo_cool_down_time = 60;
  level.kortifex._id_DD78["lighting_bolt"].skill_vos = ["zm_cpm5_bfs5_krtx_bica", "zm_cpm5_bfs5_krtx_bicb", "zm_cpm5_bfs5_krtx_bicc", "zm_cpm5_bfs5_krtx_bicd", "zm_cpm5_bfs5_krtx_bice", "zm_cpm5_bfs5_krtx_bicf"];
  level.kortifex._id_DD78["summon_zombie"] = spawnStruct();
  level.kortifex._id_DD78["summon_zombie"].b_cool_down = 1;
  level.kortifex._id_DD78["summon_zombie"].cool_down_time = 1;
  level.kortifex._id_DD78["summon_zombie"].spawn_dealy = 0.5;
  level.kortifex._id_DD78["summon_zombie"]._id_E109 = 10;
  level.kortifex._id_DD78["summon_zombie"]._id_E16D = [];
  level.kortifex._id_DD78["summon_zombie"]._id_E16D[0] = [];
  level.kortifex._id_DD78["summon_zombie"]._id_E16D[0]["spawn_ai_type"] = ["enemy_base_zombie_sumpf_cp", "enemy_zombie_screamer_cp"];
  level.kortifex._id_DD78["summon_zombie"]._id_E16D[0]["enemy_base_zombie_sumpf_cp"] = 8;
  level.kortifex._id_DD78["summon_zombie"]._id_E16D[0]["enemy_zombie_screamer_cp"] = 2;
  level.kortifex._id_DD78["summon_zombie"]._id_E16D[1] = [];
  level.kortifex._id_DD78["summon_zombie"]._id_E16D[1]["spawn_ai_type"] = ["enemy_base_zombie_sumpf_cp", "enemy_zombie_screamer_cp"];
  level.kortifex._id_DD78["summon_zombie"]._id_E16D[1]["enemy_base_zombie_sumpf_cp"] = 8;
  level.kortifex._id_DD78["summon_zombie"]._id_E16D[1]["enemy_zombie_screamer_cp"] = 4;
  level.kortifex._id_DD78["summon_zombie"]._id_E16D[2] = [];
  level.kortifex._id_DD78["summon_zombie"]._id_E16D[2]["spawn_ai_type"] = ["enemy_base_zombie_sumpf_cp", "enemy_zombie_screamer_cp", "enemy_zombie_juggernaut_cp"];
  level.kortifex._id_DD78["summon_zombie"]._id_E16D[2]["enemy_base_zombie_sumpf_cp"] = 8;
  level.kortifex._id_DD78["summon_zombie"]._id_E16D[2]["enemy_zombie_screamer_cp"] = 2;
  level.kortifex._id_DD78["summon_zombie"]._id_E16D[2]["enemy_zombie_juggernaut_cp"] = 1;
  level.kortifex._id_DD78["summon_zombie"].skill_func = ::_id_E258;
  level.kortifex._id_DD78["summon_zombie"].skill_anim = "ai_s4_zm_zombie_kortifex_summon_zombie_01";
  level.kortifex._id_DD78["summon_zombie"].b_vo_cool_down = 1;
  level.kortifex._id_DD78["summon_zombie"].vo_cool_down_time = 60;
  level.kortifex._id_DD78["summon_zombie"].skill_vos = ["zm_cpm5_bfs5_krtx_bida", "zm_cpm5_bfs5_krtx_bidb", "zm_cpm5_bfs5_krtx_bidc", "zm_cpm5_bfs5_krtx_bidd", "zm_cpm5_bfs5_krtx_bide", "zm_cpm5_bfs5_krtx_bidf"];
  level.kortifex._id_DD78["summon_weapons"] = spawnStruct();
  level.kortifex._id_DD78["summon_weapons"].b_cool_down = 1;
  level.kortifex._id_DD78["summon_weapons"].cool_down_time = 1;
  level.kortifex._id_DD78["summon_weapons"].weapon_types = [];
  level.kortifex._id_DD78["summon_weapons"].weapon_types["lighting_storm"] = spawnStruct();
  level.kortifex._id_DD78["summon_weapons"].weapon_types["lighting_storm"].skill_vos = ["zm_cpm5_bfs5_dsrx_biea", "zm_cpm5_bfs5_dsrx_bieb", "zm_cpm5_bfs5_dsrx_biec", "zm_cpm5_bfs5_dsrx_bied", "zm_cpm5_bfs5_dsrx_biee", "zm_cpm5_bfs5_dsrx_bief"];
  level.kortifex._id_DD78["summon_weapons"].weapon_types["lighting_storm"]._id_A1FD = 50;
  level.kortifex._id_DD78["summon_weapons"].weapon_types["lighting_storm"].damage = 130;
  level.kortifex._id_DD78["summon_weapons"].weapon_types["lighting_storm"].damage_radius = 150;
  level.kortifex._id_DD78["summon_weapons"].weapon_types["lighting_storm"].damage_interval = 2;
  level.kortifex._id_DD78["summon_weapons"].weapon_types["lighting_storm"].life_time = 25;
  level.kortifex._id_DD78["summon_weapons"].weapon_types["lighting_storm"].health = 250;
  level.kortifex._id_DD78["summon_weapons"].weapon_types["lighting_storm"].skill_anim = "ai_s4_zm_zombie_kortifex_summon_flashball_01";
  level.kortifex._id_DD78["summon_weapons"].weapon_types["lighting_storm"].b_vo_cool_down = 1;
  level.kortifex._id_DD78["summon_weapons"].weapon_types["lighting_storm"].vo_cool_down_time = 60;
  level.kortifex._id_DD78["summon_weapons"].weapon_types["ring_of_fire"] = spawnStruct();
  level.kortifex._id_DD78["summon_weapons"].weapon_types["ring_of_fire"].skill_vos = ["zm_cpm5_bfs5_dnvk_bija", "zm_cpm5_bfs5_dnvk_bijb", "zm_cpm5_bfs5_dnvk_bijc", "zm_cpm5_bfs5_dnvk_bijd", "zm_cpm5_bfs5_dnvk_bije", "zm_cpm5_bfs5_dnvk_bijf"];
  level.kortifex._id_DD78["summon_weapons"].weapon_types["ring_of_fire"].duration_time = 60;
  level.kortifex._id_DD78["summon_weapons"].weapon_types["ring_of_fire"]._id_10DF4 = 40;
  level.kortifex._id_DD78["summon_weapons"].weapon_types["ring_of_fire"].skill_anim = "ai_s4_zm_zombie_kortifex_summon_Inviktor_01";
  level.kortifex._id_DD78["summon_weapons"].weapon_types["ring_of_fire"].b_vo_cool_down = 1;
  level.kortifex._id_DD78["summon_weapons"].weapon_types["ring_of_fire"].vo_cool_down_time = 60;
  level.kortifex._id_DD78["summon_weapons"].weapon_types["healing"] = spawnStruct();
  level.kortifex._id_DD78["summon_weapons"].weapon_types["healing"].skill_vos = ["zm_cpm5_bfs5_vrcn_bita", "zm_cpm5_bfs5_vrcn_bitb", "zm_cpm5_bfs5_vrcn_bitc", "zm_cpm5_bfs5_vrcn_bitd", "zm_cpm5_bfs5_vrcn_bite", "zm_cpm5_bfs5_vrcn_bitf"];
  level.kortifex._id_DD78["summon_weapons"].weapon_types["healing"].duration_time = 30;
  level.kortifex._id_DD78["summon_weapons"].weapon_types["healing"].healing_rate = 8000;
  level.kortifex._id_DD78["summon_weapons"].weapon_types["healing"]._id_10DF4 = 20;
  level.kortifex._id_DD78["summon_weapons"].weapon_types["healing"].skill_anim = "ai_s4_zm_zombie_kortifex_healing_01";
  level.kortifex._id_DD78["summon_weapons"].weapon_types["healing"]._id_9C0E = 3;
  level.kortifex._id_DD78["summon_weapons"].weapon_types["healing"].b_vo_cool_down = 1;
  level.kortifex._id_DD78["summon_weapons"].weapon_types["healing"].vo_cool_down_time = 60;
  level.kortifex._id_DD78["summon_weapons"].skill_func = ::spawn_weapons;
  level.kortifex._id_DD78["skill_squenece"] = [];
  level.kortifex._id_DD78["skill_squenece"][0] = ["summon_weapons", "summon_zombie", "summon_weapons", "summon_weapons", "lighting_bolt"];
  level.kortifex._id_DD78["skill_squenece"][1] = ["summon_zombie", "summon_weapons", "lighting_bolt", "summon_weapons", "summon_weapons"];
  level.kortifex._id_DD78["skill_squenece"][2] = ["summon_zombie", "summon_weapons", "summon_weapons", "summon_zombie", "summon_weapons"];
  level.kortifex._id_DD78["skill_squenece"][3] = ["lighting_bolt", "summon_weapons", "summon_weapons", "summon_zombie", "lighting_bolt"];
  level.kortifex.b_can_damage = 1;
  level.kortifex.sound_proxy = scripts\cp\utility::_id_E190("tag_origin", level.kortifex gettagorigin("tag_eye"));
  level.kortifex.sound_proxy linkto(level.kortifex, "tag_eye");
  level.kortifex.sound_proxy_ri = scripts\cp\utility::_id_E190("tag_origin", level.kortifex gettagorigin("j_eyeball_ri"));
  level.kortifex.sound_proxy_ri linkto(level.kortifex, "j_eyeball_ri");
  level.kortifex.sound_proxy_le = scripts\cp\utility::_id_E190("tag_origin", level.kortifex gettagorigin("j_eyeball_le"));
  level.kortifex.sound_proxy_le linkto(level.kortifex, "j_eyeball_le");
  create_hand_fx_proxy();
  level.kortifex.middle_eye = scripts\cp\utility::_id_E190("s4_zm_kortifex_eyeball", level.kortifex gettagorigin("j_eyeball_mi"));
  level.kortifex.middle_eye linkto(level.kortifex, "j_eyeball_mi");
  level.kortifex.middle_eye setCanDamage(1);
  level.kortifex.middle_eye thread kortifex_eye_take_damage_listener([0]);
  level.kortifex.right_eye = scripts\cp\utility::_id_E190("s4_zm_kortifex_eyeball", level.kortifex gettagorigin("j_eyeball_ri"));
  level.kortifex.right_eye linkto(level.kortifex, "j_eyeball_ri");
  level.kortifex.right_eye setCanDamage(1);
  level.kortifex.right_eye thread kortifex_eye_take_damage_listener([1, 2]);
  level.kortifex.left_eye = scripts\cp\utility::_id_E190("s4_zm_kortifex_eyeball", level.kortifex gettagorigin("j_eyeball_le"));
  level.kortifex.left_eye linkto(level.kortifex, "j_eyeball_le");
  level.kortifex.left_eye setCanDamage(1);
  level.kortifex.left_eye thread kortifex_eye_take_damage_listener([1, 2]);
  turn_kortifex_eyes_fx(0, 1);
  level.kortifex scale_boss_health();
  level.kortifex create_kortifex_health_bar();
  level.kortifex thread kortifex_take_damage_listener();
  level.kortifex thread start_kortifex_behavior_manager();
  level waittill("kortifex_die");

  foreach(var_5 in level.players) {
    if(isPlayer(var_5)) {
      level thread scripts\cp\utility::_id_B8F4("zmb_kortifex_bb_over_stinger", var_5);
    }
  }

  level thread auto_revive_dead_players();
  level thread cleanup_kortifex_health_bar();
  level thread turn_kortifex_eyes_fx(1, 0);
  level.kortifex thread cleanup_body_hit_boxes();
  _func_0130(level.kortifex);
  playFXOnTag(level._effect["kortifex_ambient"], level.kortifex, "j_spine4");
  level.kortifex play_death_animations();
  _func_01E3("none");
  _id_07A1::scriptable_removedamagecallback(::hit_kortifex_body);
  _id_07A1::scriptable_removedamagecallback(::hit_lighting_storm);
  _id_06CB::_id_C417(::on_zombie_killed_drop_items);
  level thread[[level.kortifex.screen_flash_white]](0.3);
  wait 0.3;
  level thread remove_dark_aether_location_string(1);
  level.void_construct delete();
  level.kortifex thread cleanup_all_the_things();
  level thread cleanup_all_dark_aether_anemones();
  level.kortifex play_outro_vignette();
  level thread spawn_reward_each_stage(1);
  wait 1;
  level scripts\engine\utility::_id_5C1B("round_spawn_zombies");
  level.zombie_round_override = undefined;
  level._id_A52A = 0;
  level.disable_pickup_item_vo = undefined;

  foreach(var_5 in level.players) {
    if(isPlayer(var_5)) {
      level thread _id_070F::createfinishquestevent(var_5);
    }
  }

  level thread open_portal_back_to_oasis();
  wait 1;
  level.kortifex delete();
}

create_hand_fx_proxy() {
  var_0 = anglesToForward(vectortoangles(level.kortifex gettagorigin("J_Wrist_LE") - level.kortifex gettagorigin("J_Elbow_LE")));
  level.kortifex.hand_fx_1 = scripts\cp\utility::_id_E190("tag_origin", level.kortifex gettagorigin("J_Wrist_LE") + var_0 * 150 + (0, 0, -100));
  level.kortifex.hand_fx_1 linkto(level.kortifex, "J_Wrist_LE");
  var_0 = anglesToForward(vectortoangles(level.kortifex gettagorigin("J_Wrist_RI") - level.kortifex gettagorigin("J_Elbow_RI")));
  level.kortifex.hand_fx_2 = scripts\cp\utility::_id_E190("tag_origin", level.kortifex gettagorigin("J_Wrist_RI") + var_0 * 150 + (0, 0, -100));
  level.kortifex.hand_fx_2 linkto(level.kortifex, "J_Wrist_RI");
  var_0 = anglesToForward(vectortoangles(level.kortifex gettagorigin("dn_J_Wrist_LE") - level.kortifex gettagorigin("dn_J_Elbow_LE")));
  level.kortifex.hand_fx_3 = scripts\cp\utility::_id_E190("tag_origin", level.kortifex gettagorigin("dn_J_Wrist_LE") + var_0 * 150 + (0, 0, -100));
  level.kortifex.hand_fx_3 linkto(level.kortifex, "dn_J_Wrist_LE");
  var_0 = anglesToForward(vectortoangles(level.kortifex gettagorigin("dn_J_Wrist_RI") - level.kortifex gettagorigin("dn_J_Elbow_RI")));
  level.kortifex.hand_fx_4 = scripts\cp\utility::_id_E190("tag_origin", level.kortifex gettagorigin("dn_J_Wrist_RI") + var_0 * 150 + (0, 0, -100));
  level.kortifex.hand_fx_4 linkto(level.kortifex, "dn_J_Wrist_RI");
}

scale_boss_health() {
  var_0 = level.players.size;
  var_1 = level._id_11049;
  var_1 = clamp(var_1, 20, 50);
  var_2 = 1 - (50 - var_1) / 30;
  var_2 = clamp(var_2, 0, 1);
  var_0 = level.players.size;
  var_0 = clamp(var_0, 1, 4);
  var_3 = 1 + (var_0 - 1) * 0.4;

  if(1) {
    var_4 = int(scripts\engine\math::_id_91A9(250000, 350000, var_2) * var_3);
  } else {
    var_4 = int(250000 * var_3);
  }

  self._id_9C21 = int(var_4);
  self.health = self._id_9C21;
}

create_kortifex_health_bar() {
  level endon("game_ended");

  foreach(var_1 in level.players) {
    if(isDefined(var_1)) {
      if(!isDefined(var_1.kortifex_hint)) {
        var_1.kortifex_hint = var_1 scripts\cp\utility::createfontstring("default", 1.5);
        var_1.kortifex_hint scripts\cp\utility::setpoint("CENTER", undefined, 0, -180);
        var_1.kortifex_hint.color = (1, 1, 1);
        var_1.kortifex_hint settext(&"CP_ZM_OASIS/KORTIFEX_NAME");
        var_1.kortifex_hint.alpha = 1;
      }

      if(!isDefined(var_1.kortifex_health_bar)) {
        var_1.kortifex_health_bar = var_1 scripts\cp\utility::_id_3F99((1, 0, 0), 450, 10);
        var_1.kortifex_health_bar scripts\cp\utility::setpoint("CENTER", undefined, 0, -195);
        var_1.kortifex_health_bar scripts\cp\utility::_id_FC11(level.kortifex.health / level.kortifex._id_9C21);
      }
    }
  }
}

cleanup_kortifex_health_bar() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1)) {
      if(isDefined(var_1.kortifex_hint)) {
        var_1.kortifex_hint destroy();
      }

      if(isDefined(var_1.kortifex_health_bar)) {
        var_1.kortifex_health_bar scripts\cp\utility::destroyelem();
      }
    }
  }
}

update_kortifex_health_bar(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2)) {
      if(isDefined(var_2.kortifex_health_bar)) {
        var_3 = self.health;
        var_3 = clamp(var_3, 0, self._id_9C21);
        var_2.kortifex_health_bar scripts\cp\utility::_id_FC11(var_3 / level.kortifex._id_9C21);
      }
    }
  }
}

spawn_barricades() {
  if(!isDefined(self.blocker)) {
    return;
  }
  var_0 = scripts\engine\utility::getstructarray(self.blocker.target, "targetname");

  foreach(var_2 in var_0) {
    var_2.mdl = scripts\cp\utility::_id_E190("s4_zm_rune_decal_inviktor", var_2.origin, var_2.angles);
    var_3 = scripts\engine\utility::getstructarray(var_2.target, "targetname");

    foreach(var_5 in var_3) {
      var_5.mdl = scripts\cp\utility::_id_E190("vfx_zm_obj_holdout_barrier_mod_bottom_center_56x48", var_5.origin, var_5.angles);
    }
  }
}

cleanup_barricades() {
  if(!isDefined(self._id_B9FE.blocker)) {
    return;
  }
  var_0 = scripts\engine\utility::getstructarray(self._id_B9FE.blocker.target, "targetname");

  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::getstructarray(var_2.target, "targetname");

    foreach(var_5 in var_3) {
      if(isDefined(var_5.mdl)) {
        var_5.mdl delete();
      }
    }

    if(isDefined(var_2.mdl)) {
      var_2.mdl delete();
    }
  }
}

open_portal_back_to_oasis() {
  _id_0737::_id_C266("da_portal_interaction", ::get_portal_hint_func, ::on_portal_interact, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 64);
  var_0 = scripts\engine\utility::getstruct("da_portal_pos", "targetname");
  var_0.fx_proxy = scripts\cp\utility::_id_E190("tag_origin", var_0.origin, var_0.angles);
  var_0.mdl = scripts\cp\utility::_id_E190("vfx_zm_hub_portal_center_dest_oasis_hub", var_0.origin, var_0.angles);
  playFXOnTag(level._effect["teleport_portal_red"], var_0.fx_proxy, "tag_origin");
}

get_portal_hint_func(var_0, var_1) {
  if(istrue(var_0.b_cool_down)) {
    return &"";
  } else {
    return &"CP_ZM_OASIS/BACK_TO_OASIS";
  }
}

on_portal_interact(var_0, var_1) {
  level endon("game_ended");
  var_2 = _id_0992::_id_106AF(var_1, 12, "failed deactivate rampage inducer");

  if(!var_2) {
    var_0.b_cool_down = 1;
    wait 3;
    var_0.b_cool_down = 0;
    return;
  }

  level scripts\engine\utility::_id_5C04("disallow_rbz_exfil");
  var_3 = scripts\engine\utility::getstructarray("default_player_start", "targetname");
  level thread _id_098A::warp_for_rbz(var_3, "cp_zm_oasis_oasis_tr");
  _id_0737::_id_C3C5(var_0);
  wait 11;
  stopFXOnTag(level._effect["teleport_portal_red"], var_0.fx_proxy, "tag_origin");

  if(isDefined(var_0.mdl)) {
    var_0.mdl delete();
  }

  level thread cleanup_round_base_spawn();
}

cleanup_round_base_spawn() {
  scripts\engine\utility::_id_5C04("round_spawn_zombies");
  level.force_cleanup_all_zombies = 1;
  var_0 = _func_0070("axis");

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      var_2 thread scripts\cp\zombies\zm_cleanup::cleanup_zombie();
    }
  }

  level.force_cleanup_all_zombies = 0;
  level.n_players_ready_for_boss_fight = 0;

  foreach(var_5 in level.players) {
    var_5 thread boss_fight_start_watcher();
  }

  while(level.n_players_ready_for_boss_fight < level.players.size) {
    waitframe();
  }

  level notify("hit_peeking_zombie", undefined, "none");
  scripts\engine\utility::_id_5C1B("round_spawn_zombies");
}

boss_fight_start_watcher() {
  self endon("death");
  level endon("end_game");
  self waittill("fasttravel_finished");
  level.n_players_ready_for_boss_fight++;
}

cleanup_all_the_things() {
  level endon("game_ended");
  cleanup_barricades();
  self _meth_83F8();

  foreach(var_1 in level.kortifex.spawned_actors) {
    if(isDefined(var_1)) {
      if(isDefined(var_1.hit_proxy) && var_1.hit_proxy.classname == "scriptable") {
        var_1.hit_proxy _meth_86BE();
      }

      _func_0130(var_1);
      var_1 notify("kill");
      waitframe();
      var_1 delete();
    }
  }

  level thread cleanup_all_zombies();

  if(isDefined(level.kortifex.sound_proxy)) {
    level.kortifex.sound_proxy _meth_83F8();
    waitframe();
    level.kortifex.sound_proxy delete();
  }

  if(isDefined(level.kortifex.sound_proxy_ri)) {
    level.kortifex.sound_proxy_ri _meth_83F8();
    waitframe();
    level.kortifex.sound_proxy_ri delete();
  }

  if(isDefined(level.kortifex.sound_proxy_le)) {
    level.kortifex.sound_proxy_le _meth_83F8();
    waitframe();
    level.kortifex.sound_proxy_le delete();
  }

  if(isDefined(level.kortifex.hand_fx_1)) {
    level.kortifex.hand_fx_1 delete();
  }

  if(isDefined(level.kortifex.hand_fx_2)) {
    level.kortifex.hand_fx_2 delete();
  }

  if(isDefined(level.kortifex.hand_fx_3)) {
    level.kortifex.hand_fx_3 delete();
  }

  if(isDefined(level.kortifex.hand_fx_4)) {
    level.kortifex.hand_fx_4 delete();
  }

  if(isDefined(self)) {
    self hide();
  }
}

cleanup_all_zombies() {
  var_0 = _func_0070(level._id_11056);

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      var_2 _meth_81FA();
    }
  }

  level notify("hit_peeking_zombie", undefined, "none");
  _func_0343();
}

start_kortifex_behavior_manager() {
  level endon("game_ended");
  level endon("kortifex_die");
  level.kortifex.activate_weapon_list = ["lighting_storm"];

  for(;;) {
    level thread start_boss_skill_manager();
    level waittill("jump_to_next_stage", var_0);

    if(istrue(level.kortifex.b_protected_by_shield)) {
      stopFXOnTag(level._effect["rune_shield"], level.kortifex, "j_neck");
      level.kortifex.b_protected_by_shield = 0;
    }

    if(istrue(level.kortifex.b_stun_down)) {
      level.kortifex.b_stun_down = 0;
    }

    level.kortifex._id_2038 = 0;
    level.kortifex thread stop_all_hands_fx();

    foreach(var_2 in level.players) {
      if(isPlayer(var_2)) {
        scripts\cp\utility::_id_B8F4("zmb_kortifex_stage_over_stinger", var_2);
      }
    }

    level thread cleanup_kortifex_health_bar();
    play_jump_stage_anim();
    wait 0.4;
    level thread auto_revive_dead_players();
    level thread cleanup_all_dark_aether_anemones();
    level.kortifex thread cleanup_body_hit_boxes();
    level thread cleanup_all_zombies();

    foreach(var_5 in level.kortifex.spawned_actors) {
      if(isDefined(var_5)) {
        if(isDefined(var_5.hit_proxy) && var_5.hit_proxy.classname == "scriptable") {
          var_5.hit_proxy _meth_86BE();
        }

        _func_0130(var_5);
        var_5 notify("kill");
        waitframe();
        var_5 delete();
      }
    }

    _func_0130(level.kortifex);
    level.kortifex thread cleanup_barricades();
    level thread spawn_reward_each_stage(0);

    switch (var_0) {
      case 1:
        level.kortifex.activate_weapon_list = ["lighting_storm", "ring_of_fire"];
        level.kortifex teleport_to_next_platform("40");
        level thread kortifex_stage2_manager();
        turn_kortifex_eyes_fx(1, 1);
        waitframe();
        turn_kortifex_eyes_fx(2, 1);
        break;
      case 2:
        level.kortifex.activate_weapon_list = ["lighting_storm", "ring_of_fire", "healing"];
        level.kortifex teleport_to_next_platform("50");
        level.kortifex reduce_all_skill_cool_down_time();
        level thread stun_down_kortifex_listener();
        turn_kortifex_eyes_fx(1, 1);
        waitframe();
        turn_kortifex_eyes_fx(2, 1);
        break;
    }

    level.kortifex.b_can_damage = 1;
    level.kortifex.b_common_cool_down = 1;
    playFXOnTag(level._effect["kortifex_ambient"], level.kortifex, "j_spine4");
    level.kortifex._id_B9FE thread spawn_barricades();
    level.kortifex create_kortifex_health_bar();
    level.kortifex create_body_hit_boxes();
    level thread respawn_anemones();
  }
}

auto_revive_dead_players() {
  level thread scripts\cp\zombies\zm_round_logic::respawn_players(level.rbz);
}

turn_kortifex_eyes_fx(var_0, var_1) {
  switch (var_0) {
    case 0:
      if(istrue(var_1)) {
        if(isDefined(level.kortifex.middle_eye)) {
          playFXOnTag(level._effect["eye_ambient"], level.kortifex, "j_eyeball_mi");
          scripts\cp\utility::_id_B8ED(level.kortifex gettagorigin("j_eyeball_mi"), "zmb_kort_eye_spawn");
        }
      } else {
        stopFXOnTag(level._effect["eye_ambient"], level.kortifex, "j_eyeball_mi");
        scripts\cp\utility::_id_B8ED(level.kortifex gettagorigin("j_eyeball_mi"), "zmb_kort_eye_spark");
      }

      break;
    case 1:
      if(istrue(var_1)) {
        if(isDefined(level.kortifex.right_eye)) {
          playFXOnTag(level._effect["eye_ambient"], level.kortifex, "j_eyeball_ri");
          scripts\cp\utility::_id_B8ED(level.kortifex gettagorigin("j_eyeball_ri"), "zmb_kort_eye_spawn");
        }
      } else {
        stopFXOnTag(level._effect["eye_ambient"], level.kortifex, "j_eyeball_ri");
        scripts\cp\utility::_id_B8ED(level.kortifex gettagorigin("j_eyeball_ri"), "zmb_kort_eye_spark");
      }

      break;
    case 2:
      if(istrue(var_1)) {
        if(isDefined(level.kortifex.left_eye)) {
          playFXOnTag(level._effect["eye_ambient"], level.kortifex, "j_eyeball_le");
          scripts\cp\utility::_id_B8ED(level.kortifex gettagorigin("j_eyeball_le"), "zmb_kort_eye_spawn");
        }
      } else {
        stopFXOnTag(level._effect["eye_ambient"], level.kortifex, "j_eyeball_le");
        scripts\cp\utility::_id_B8ED(level.kortifex gettagorigin("j_eyeball_le"), "zmb_kort_eye_spark");
      }

      break;
  }

  if(!isDefined(level.kortifex.middle_eye)) {
    playFXOnTag(level._effect["eye_smoke"], level.kortifex, "j_eyeball_mi");
    scripts\cp\utility::_id_10839(2);
  }

  if(!isDefined(level.kortifex.right_eye)) {
    playFXOnTag(level._effect["eye_smoke"], level.kortifex, "j_eyeball_ri");
    scripts\cp\utility::_id_10839(2);
  }

  if(!isDefined(level.kortifex.left_eye)) {
    playFXOnTag(level._effect["eye_smoke"], level.kortifex, "j_eyeball_le");
    scripts\cp\utility::_id_10839(2);
  }
}

reduce_all_skill_cool_down_time() {
  level.kortifex.common_skill_cool_down_time = 7.5;
}

spawn_reward_each_stage(var_0) {
  level endon("game_ended");
  var_1 = level.kortifex._id_B9FE.reward_pos;

  if(istrue(var_0)) {
    var_2 = _func_02A9(var_1.origin, 70);
    playFX(level._effect["mq_final_loot_fx"], var_2);
    var_3 = scripts\cp\cp_weapon::buildweapon("s4_ar_tgun_mp");
    var_4 = _id_092E::_id_E24D(var_3, var_2 + (0, 0, 8), undefined, undefined, undefined, 1);
    wait 1;
    level thread give_pap_heart_salvage_to_player();
    wait 3;

    for(;;) {
      var_2 = _func_02AA(var_1.origin, 150, 9);

      if(_func_0107(var_2) && var_2.size == 9) {
        break;
      }

      waitframe();
    }

    for(var_5 = 0; var_5 < var_2.size; var_5++) {
      if(var_5 == 0) {
        level thread _id_0990::_id_E3DD("full_ammo", var_2[var_5]);
        continue;
      }

      level thread _id_0990::_id_E3DD("bonus_points_team", var_2[var_5]);
    }

    for(;;) {
      var_2 = _func_02AA(var_1.origin, 150, 1);

      if(_func_0107(var_2) && var_2.size == 1) {
        break;
      }

      waitframe();
    }

    for(var_5 = 0; var_5 < var_2.size; var_5++) {
      level thread drop_final_loot(var_1);
      wait 3;
    }
  } else {
    for(;;) {
      var_2 = _func_02AA(var_1.origin, 150, 3);

      if(_func_0107(var_2) && var_2.size == 3) {
        break;
      }

      waitframe();
    }

    for(var_5 = 0; var_5 < var_2.size; var_5++) {
      if(var_5 == 0) {
        level thread _id_0990::_id_E3DD("full_ammo", var_2[var_5]);
        continue;
      }

      level thread _id_0990::_id_E3DD("bonus_points_team", var_2[var_5]);
    }
  }
}

drop_final_loot(var_0) {
  var_1 = scripts\cp\utility::_id_E190("tag_origin", var_0.origin);
  var_2 = "zm_loot_reward_boss";
  _id_073D::_id_95C8(var_2);

  if(isDefined(var_1)) {
    playFX(level._effect["mq_final_loot_fx"], var_1.origin);
    var_1 playSound("zmb_exfil_portal_open");
    _id_073D::select_and_spawn_items_from_table(level._id_9860[var_2], var_1.origin + (0, 0, 48), var_1.angles, undefined, "zm_loot_chest", 20, undefined, 0.2, "zmb_spawn_portal", var_1);
  }
}

give_pap_heart_salvage_to_player() {
  foreach(var_1 in level.players) {
    if(isPlayer(var_1)) {
      var_1 thread triple_upgrade_weapon();
      var_2 = scripts\cp\zombies\perks\zm_perks::get_perk_max_level();

      foreach(var_6, var_4 in level.zm_perks) {
        var_5 = var_1 scripts\cp\zombies\perks\zm_perks::get_perk_level(var_6);

        if(var_5 < var_2) {
          var_1 scripts\cp\zombies\perks\zm_perks::set_perk_level(var_6, var_5 + 1);
        }
      }

      var_1 _id_075A::_id_6FCE(2000);
      var_1 scripts\cp\cp_sacrificial_heart::giveplayersacrificialheart(5);
    }
  }
}

triple_upgrade_weapon() {
  self endon("death_or_disconnect");
  var_0 = self getcurrentweapon();
  var_1 = scripts\cp\cp_weapon::_id_3101(var_0);
  var_2 = scripts\cp\cp_weapon::_id_683D(var_0);

  if(var_1 && var_2 < level._id_AE11) {
    for(var_3 = 0; var_3 < level._id_AE11; var_3++) {
      thread _id_0774::_id_10D20(1);
      scripts\engine\utility::_id_108F5("weapon_level_changed", 0.5);
    }
  }
}

play_outro_vignette() {
  var_0 = scripts\engine\utility::getstruct("kortifex_outro_pos", "targetname");
  var_1 = scripts\cp\utility::_id_E190("c_s4_zmb_kortifex", var_0.origin, var_0.angles);
  var_2 = scripts\engine\utility::getstruct(var_0.target, "targetname");
  var_1 _meth_82CB("ai_s4_zm_zombie_kortifex_death_01", "boss_fight", 0, 1, "normal");
  wait 2.7;
  var_2 = scripts\engine\utility::getstruct(var_0.target, "targetname");
  playFX(level._effect["boss_falling_fx"], var_2.origin, anglesToForward(var_2.angles), anglestoup(var_2.angles));
  var_1 waittillmatch("boss_fight", "finish");
  var_1 delete();
  level thread play_sequence_vos(["zm_cpm5_bfs5_dnrt_biva", "zm_cpm5_bfs5_blkr_bivb"]);
}

play_death_animations() {
  level endon("game_ended");
  level thread play_sequence_vos(["zm_cpm5_bfs5_krtx_biua", "zm_cpm5_bfs5_dnrt_biub"]);
  self _meth_82CB("ai_s4_zm_zombie_kortifex_death_50_01", "boss_fight", 0, 1, "normal");
  level thread play_construct_hit_beam(100);
  self waittillmatch("boss_fight", "start_shake");
  level thread loop_camera_shake_rumber();
  self waittillmatch("boss_fight", "hit1");
  level thread play_construct_hit_beam(100);
  self waittillmatch("boss_fight", "hit2");
  level thread play_construct_hit_beam(100);
  self waittillmatch("boss_fight", "stop_shake");
  level notify("stop_shake");
  self waittillmatch("boss_fight", "shake");
  level thread skill_screen_shake();
  self waittillmatch("boss_fight", "shake");
  level thread skill_screen_shake();
  self waittillmatch("boss_fight", "finish");
}

loop_camera_shake_rumber() {
  level endon("stop_shake");
  level endon("game_ended");

  for(;;) {
    level thread skill_screen_shake();
    wait 0.3;
  }
}

_id_B267() {
  level endon("game_ended");
  scripts\cp\utility::_id_B8ED(level.void_construct.origin, "zmb_construct_voice_stinger_0");
  wait 3;
  var_0 = scripts\engine\utility::getstruct("kortifex_intro_pos", "targetname");
  playFX(level._effect["mq_ktfx_showup_fx"], var_0.origin + (0, 0, 50), anglesToForward(var_0.angles), anglestoup(var_0.angles));
  var_1 = scripts\cp\utility::_id_E190("c_s4_zmb_kortifex", var_0.origin, var_0.angles);
  var_1 _meth_82CB("ai_s4_zm_zombie_kortifex_vignette_intro_01", "boss_fight");
  var_2 = getent("t_dmg_ktfx", "script_noteworthy");
  var_2 thread intro_kortifex_damage_listener();

  foreach(var_4 in level.players) {
    var_4 thread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_root::molotov_stuck_check(var_1);
  }

  var_1 thread play_sequence_3d_vos(["zm_cpm5_bfs5_krtx_biaa", "zm_cpm5_bfs5_krtx_biab", "zm_cpm5_bfs5_dnrt_biac", "zm_cpm5_bfs5_krtx_biad"]);
  var_1 waittillmatch("boss_fight", "finish");
  var_1 delete();
  var_2 delete();
  var_6 = getent("kortifex_clip", "targetname");
  var_6 delete();
}

intro_kortifex_damage_listener() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(isPlayer(var_1)) {
      level thread _id_072E::display_damage_number_internal(var_1, 2, 0, self.origin);
    }
  }
}

play_sequence_3d_vos(var_0) {
  level endon("game_ended");
  self endon("death");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(issubstr(var_0[var_1], "krtx")) {
      if(isDefined(self)) {
        self playSound(var_0[var_1]);
        wait(_id_0720::get_dialogue_length(var_0[var_1]));
      }

      continue;
    }

    _id_0720::play_narration(var_0[var_1]);
  }
}

play_sequence_vos(var_0, var_1, var_2, var_3) {
  if(!level scripts\engine\utility::_id_5C00("finish_intro_vo")) {
    return;
  }
  if(level scripts\engine\utility::_id_5C00("boss_dialogue_busy")) {
    return;
  }
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  level scripts\engine\utility::_id_5C1B("boss_dialogue_busy");

  if(var_3) {
    level.kortifex _meth_83F8();
  }

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    if(issubstr(var_0[var_4], "krtx") && !istrue(var_2)) {
      scripts\cp\utility::_id_B8ED(level.kortifex gettagorigin("tag_eye"), var_0[var_4]);
      wait(_id_0720::get_dialogue_length(var_0[var_4]));
      continue;
    }

    _id_0720::play_narration(var_0[var_4], var_3);
  }

  if(isDefined(var_1)) {
    level scripts\engine\utility::_id_5C1B(var_1);
  }

  level scripts\engine\utility::_id_5C04("boss_dialogue_busy");
}

play_intro_sequence_vos(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(issubstr(var_0[var_1], "krtx")) {
      scripts\cp\utility::_id_B8ED(level.kortifex gettagorigin("tag_eye"), var_0[var_1]);
      wait(_id_0720::get_dialogue_length(var_0[var_1]));
      continue;
    }

    _id_0720::play_narration(var_0[var_1]);
  }

  level scripts\engine\utility::_id_5C1B("finish_intro_vo");
  level scripts\engine\utility::_id_5C1B("finish_stage_intro_vo");
}

teleport_to_next_platform(var_0) {
  level endon("game_ended");
  var_1 = scripts\engine\utility::getstructarray("kortifex_pos", "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_039B) && var_3._id_039B == var_0) {
      level.kortifex.origin = var_3.origin;
      level.kortifex.angles = var_3.angles;
      level.kortifex._id_B9FE = var_3;
    }
  }

  level.kortifex hide();

  if(isDefined(level.kortifex.right_eye)) {
    level.kortifex.right_eye hide();
  }

  if(isDefined(level.kortifex.left_eye)) {
    level.kortifex.left_eye hide();
  }

  _func_0130(level.kortifex);
  wait 25;
  teleport_player_to_fight_area();
  wait 12;
  level.kortifex show();
  player_get_close_to_kortifex_check();

  if(isDefined(level.kortifex.right_eye)) {
    level.kortifex.right_eye show();
  }

  if(isDefined(level.kortifex.left_eye)) {
    level.kortifex.left_eye show();
  }

  level scripts\engine\utility::_id_5C04("finish_stage_intro_vo");

  if(var_0 == "40") {
    var_5 = scripts\engine\utility::getstruct(level.void_construct.target, "targetname");
    level.void_construct.origin = var_5.origin;
    level.void_construct.angles = var_5.angles;
    level thread play_sequence_vos(["zm_cpm5_bfs5_krtx_biia", "zm_cpm5_bfs5_krft_biib"], "finish_stage_intro_vo");
  }

  if(var_0 == "50") {
    var_5 = scripts\engine\utility::getstruct(level.void_construct.target, "targetname");
    var_6 = scripts\engine\utility::getstruct(var_5.target, "targetname");
    level.void_construct.origin = var_6.origin;
    level.void_construct.angles = var_6.angles;
    level thread play_sequence_vos(["zm_cpm5_bfs5_krtx_bisa", "zm_cpm5_bfs5_dnvk_bisb"], "finish_stage_intro_vo");
  }
}

teleport_player_to_fight_area() {
  var_0 = scripts\engine\utility::getstructarray(level.kortifex._id_B9FE.teleport_pos.target, "targetname");

  foreach(var_2 in level.players) {
    if(isPlayer(var_2)) {
      var_2._id_2031 = 1;
      level thread _id_098A::warp_sepcific_player(var_0, var_2);
    }
  }
}

player_get_close_to_kortifex_check() {
  for(;;) {
    foreach(var_1 in level.players) {
      if(var_1 scripts\cp\utility::_id_8708()) {
        var_2 = distancesquared(level.kortifex gettagorigin("j_spine4"), var_1.origin);

        if(var_2 <= _func_0219(3000)) {
          return;
        }
      }
    }

    wait 0.1;
  }
}

play_jump_stage_anim() {
  level endon("game_ended");
  self _meth_82CA();
  self _meth_82CB(level.kortifex.jump_stage_anim, "boss_fight", 0, 1, "normal");
  level scripts\engine\utility::_id_5C04("boss_dialogue_busy");

  if(level.kortifex.stage_index == 1) {
    level thread play_sequence_vos(["zm_cpm5_bfs5_krtx_biga", "zm_cpm5_bfs5_dnrt_bigb", "zm_cpm5_bfs5_krtx_biha"], "finish_jump_to_stage1_vo", 0, 1);
  } else if(level.kortifex.stage_index == 2) {
    level thread play_sequence_vos(["zm_cpm5_bfs5_krtx_biqa", "zm_cpm5_bfs5_dnrt_biqb", "zm_cpm5_bfs5_krtx_bira"], "finish_jump_to_stage2_vo", 0, 1);
  }

  self waittillmatch("boss_fight", "finish");
  self _meth_82CB(level.kortifex.idle_anims[0], "boss_fight", 0, 1, "normal");

  if(level.kortifex.stage_index == 1) {
    level scripts\engine\utility::_id_5C24("finish_jump_to_stage1_vo");
  } else if(level.kortifex.stage_index == 2) {
    level scripts\engine\utility::_id_5C24("finish_jump_to_stage2_vo");
  }

  level thread[[level.kortifex.screen_flash_white]](0.3);
  var_0 = undefined;

  if(level.kortifex.stage_index == 1) {
    var_0 = scripts\engine\utility::array_random(["zm_cpm5_bfs5_dnrt_bihb", "zm_cpm5_bfs5_dnvk_bihc", "zm_cpm5_bfs5_blkr_bihd", "zm_cpm5_bfs5_dsrx_bihe", "zm_cpm5_bfs5_vrcn_bihf"]);
  } else if(level.kortifex.stage_index == 2) {
    var_0 = scripts\engine\utility::array_random(["zm_cpm5_bfs5_dnrt_birb", "zm_cpm5_bfs5_dnvk_birc", "zm_cpm5_bfs5_blkr_bird", "zm_cpm5_bfs5_dsrx_bire", "zm_cpm5_bfs5_vrcn_birf"]);
  }

  level thread _id_0720::play_narration(var_0);
}

start_boss_skill_manager() {
  level endon("game_ended");
  level endon("jump_to_next_stage");
  level endon("kortifex_die");
  level endon("kortifex_stun_down");

  for(;;) {
    var_0 = scripts\engine\utility::array_random(level.kortifex._id_DD78["skill_squenece"]);

    foreach(var_2 in var_0) {
      if(_func_0107(level.kortifex.force_skill) && level.kortifex.force_skill.size != 0) {
        var_2 = level.kortifex.force_skill[0];
        level.kortifex cast_skill(var_2);
        level.kortifex thread enter_idle_state();
      } else {
        level.kortifex cast_skill(var_2);
        level.kortifex thread enter_idle_state();
      }

      level.kortifex common_cool_down_timer();
    }

    wait 1;
  }
}

enter_idle_state() {
  level endon("game_ended");
  level endon("jump_to_next_stage");
  level endon("kortifex_die");
  level endon("kortifex_cast_skill");

  for(;;) {
    var_0 = scripts\engine\utility::array_random(level.kortifex.idle_anims);
    self _meth_82CB(var_0, "boss_idle", 0, 1, "normal");
    self waittillmatch("boss_idle", "finish");
  }
}

cast_skill(var_0) {
  level endon("game_ended");
  level endon("jump_to_next_stage");
  level endon("kortifex_die");
  level notify("kortifex_cast_skill");
  self _meth_82CA();

  if(var_0 == "summon_weapons") {
    var_1 = kortifex_select_weapon();
    self _meth_82CB(self._id_DD78[var_0].weapon_types[var_1].skill_anim, "boss_fight", 0, 1, "normal");

    if(level scripts\engine\utility::_id_5C00("finish_intro_vo") && level scripts\engine\utility::_id_5C00("finish_stage_intro_vo") && istrue(self._id_DD78[var_0].weapon_types[var_1].b_vo_cool_down)) {
      var_2 = scripts\engine\utility::array_random(self._id_DD78[var_0].weapon_types[var_1].skill_vos);
      level thread play_sequence_vos([var_2]);
      level thread skill_vo_cool_down_listener(var_0, var_1);
    }

    if(var_1 == "healing") {
      thread handle_healing_fxs();
    }

    self waittillmatch("boss_fight", "fire");
    level thread skill_screen_shake();
    self thread[[self._id_DD78[var_0].skill_func]](var_1);
    self waittillmatch("boss_fight", "finish");
  } else {
    self _meth_82CB(self._id_DD78[var_0].skill_anim, "boss_fight", 0, 1, "normal");

    if(level scripts\engine\utility::_id_5C00("finish_intro_vo") && level scripts\engine\utility::_id_5C00("finish_stage_intro_vo") && istrue(self._id_DD78[var_0].b_vo_cool_down)) {
      var_2 = scripts\engine\utility::array_random(self._id_DD78[var_0].skill_vos);
      level thread play_sequence_vos([var_2]);
      level thread skill_vo_cool_down_listener(var_0);
    }

    if(var_0 == "summon_zombie") {
      thread handle_summon_fxs();
      playFXOnTag(level._effect["summon_body"], self, "j_spine4");
    }

    if(var_0 == "lighting_bolt") {
      thread handle_lighting_bolt_fxs();
    }

    self waittillmatch("boss_fight", "fire");
    level thread skill_screen_shake();
    self thread[[self._id_DD78[var_0].skill_func]]();
    self waittillmatch("boss_fight", "finish");

    if(var_0 == "summon_zombie") {
      stopFXOnTag(level._effect["summon_body"], self, "j_spine4");
    }
  }
}

skill_vo_cool_down_listener(var_0, var_1) {
  level endon("game_ended");
  level endon("kortifex_die");

  if(isDefined(var_0) && var_0 != "summon_weapons") {
    level.kortifex._id_DD78[var_0].b_vo_cool_down = 0;
    wait(level.kortifex._id_DD78[var_0].vo_cool_down_time);
    level.kortifex._id_DD78[var_0].b_vo_cool_down = 1;
  } else {
    level.kortifex._id_DD78[var_0].weapon_types[var_1].b_vo_cool_down = 0;
    wait(level.kortifex._id_DD78[var_0].weapon_types[var_1].vo_cool_down_time);
    level.kortifex._id_DD78[var_0].weapon_types[var_1].b_vo_cool_down = 1;
  }
}

handle_healing_fxs() {
  level endon("game_ended");
  level endon("jump_to_next_stage");
  level endon("kortifex_die");
  level endon("kortifex_stun_down");
  self waittillmatch("boss_fight", "play_hand_fx");
  playFXOnTag(level._effect["healing_hand"], self.hand_fx_2, "tag_origin");
  waitframe();
  playFXOnTag(level._effect["healing_hand"], self.hand_fx_1, "tag_origin");
  self waittillmatch("boss_fight", "stop_hand_fx");
  stopFXOnTag(level._effect["healing_hand"], self.hand_fx_2, "tag_origin");
  waitframe();
  stopFXOnTag(level._effect["healing_hand"], self.hand_fx_1, "tag_origin");
  self waittillmatch("boss_fight", "play_ambient_fx");
  playFX(level._effect["healing_ground"], self gettagorigin("j_mainroot"), anglesToForward(self.angles + (0, 0, 270)));
  waitframe();
  playFXOnTag(level._effect["healing_body"], self, "j_spine4");
  wait 1;
  stopFXOnTag(level._effect["healing_body"], self, "j_spine4");
}

handle_summon_fxs() {
  level endon("game_ended");
  level endon("jump_to_next_stage");
  level endon("kortifex_die");
  self waittillmatch("boss_fight", "right_hand_fx_on");
  playFXOnTag(level._effect["summon_hand"], self.hand_fx_2, "tag_origin");
  self.hand_fx_2 playSound("zmb_kort_light_ball_spawn");
  waitframe();
  playFXOnTag(level._effect["summon_hand"], self.hand_fx_4, "tag_origin");
  self.hand_fx_4 playSound("zmb_kort_light_ball_spawn");
  self waittillmatch("boss_fight", "left_hand_fx_on");
  playFXOnTag(level._effect["summon_hand"], self.hand_fx_1, "tag_origin");
  self.hand_fx_1 playSound("zmb_kort_light_ball_spawn");
  waitframe();
  playFXOnTag(level._effect["summon_hand"], self.hand_fx_3, "tag_origin");
  self.hand_fx_3 playSound("zmb_kort_light_ball_spawn");
  self waittillmatch("boss_fight", "fx_off");
  thread stop_all_hands_fx();
}

stop_all_hands_fx() {
  _func_012F(level._effect["summon_hand"], self.hand_fx_1, "tag_origin");
  scripts\cp\utility::_id_10839(2);
  _func_012F(level._effect["summon_hand"], self.hand_fx_2, "tag_origin");
  scripts\cp\utility::_id_10839(2);
  _func_012F(level._effect["summon_hand"], self.hand_fx_3, "tag_origin");
  scripts\cp\utility::_id_10839(2);
  _func_012F(level._effect["summon_hand"], self.hand_fx_4, "tag_origin");
  scripts\cp\utility::_id_10839(2);
  _func_012F(level._effect["healing_hand"], self.hand_fx_2, "tag_origin");
  scripts\cp\utility::_id_10839(2);
  _func_012F(level._effect["healing_hand"], self.hand_fx_1, "tag_origin");
  scripts\cp\utility::_id_10839(2);
  _func_012F(level._effect["lighting_bolt_hand_elec_sub_trail"], self, "j_mid_ri_2");
  scripts\cp\utility::_id_10839(2);
  _func_012F(level._effect["lighting_bolt_hand_elec_ready"], self, "j_mid_ri_1");
  scripts\cp\utility::_id_10839(2);
  _func_012F(level._effect["lighting_bolt_hand_elec"], self, "j_mid_ri_1");
  scripts\cp\utility::_id_10839(3);
  _func_012F(level._effect["lighting_bolt_hand_elec_trail"], self, "j_index_ri_3");
  scripts\cp\utility::_id_10839(3);
  _func_012F(level._effect["lighting_bolt_hand_elec_trail"], self, "j_mid_ri_3");
  scripts\cp\utility::_id_10839(3);
  _func_012F(level._effect["lighting_bolt_hand_elec_trail"], self, "j_ring_ri_3");
  scripts\cp\utility::_id_10839(3);
  _func_012F(level._effect["lighting_bolt_hand_elec_trail"], self, "j_thumb_ri_3");
}

common_cool_down_timer() {
  level endon("game_ended");
  level endon("kortifex_die");
  wait(self.common_skill_cool_down_time);
  self.b_common_cool_down = 1;
}

skill_cool_down_timer(var_0) {
  level endon("game_ended");
  level endon("kortifex_die");
  wait(self._id_DD78[var_0].cool_down_time);
  self._id_DD78[var_0].b_cool_down = 1;
}

handle_lighting_bolt_fxs() {
  level endon("game_ended");
  level endon("jump_to_next_stage");
  level endon("kortifex_die");
  self waittillmatch("boss_fight", "play_elec_smk");
  playFXOnTag(level._effect["lighting_bolt_hand_elec"], self, "j_mid_ri_1");
  self waittillmatch("boss_fight", "play_hand_ready");
  playFXOnTag(level._effect["lighting_bolt_hand_elec_ready"], self, "j_mid_ri_1");
  self waittillmatch("boss_fight", "play_hand_elec_exp");
  playFXOnTag(level._effect["lighting_bolt_hand_elec_exp"], self, "j_mid_ri_1");
  waitframe();
  stopFXOnTag(level._effect["lighting_bolt_hand_elec_ready"], self, "j_mid_ri_1");
  level thread skill_screen_shake();
  self waittillmatch("boss_fight", "play_hand_trails");
  playFXOnTag(level._effect["lighting_bolt_hand_elec_trail"], self, "j_index_ri_3");
  waitframe();
  playFXOnTag(level._effect["lighting_bolt_hand_elec_trail"], self, "j_mid_ri_3");
  waitframe();
  playFXOnTag(level._effect["lighting_bolt_hand_elec_trail"], self, "j_ring_ri_3");
  waitframe();
  playFXOnTag(level._effect["lighting_bolt_hand_elec_trail"], self, "j_thumb_ri_3");
  waitframe();
  self waittillmatch("boss_fight", "stop_fx");
  stopFXOnTag(level._effect["lighting_bolt_hand_elec_trail"], self, "j_index_ri_3");
  scripts\cp\utility::_id_10839(3);
  stopFXOnTag(level._effect["lighting_bolt_hand_elec_trail"], self, "j_mid_ri_3");
  scripts\cp\utility::_id_10839(3);
  stopFXOnTag(level._effect["lighting_bolt_hand_elec_trail"], self, "j_ring_ri_3");
  scripts\cp\utility::_id_10839(3);
  stopFXOnTag(level._effect["lighting_bolt_hand_elec_trail"], self, "j_thumb_ri_3");
  scripts\cp\utility::_id_10839(3);
  stopFXOnTag(level._effect["lighting_bolt_hand_elec"], self, "j_mid_ri_1");
}

spawn_lighting() {
  level endon("game_ended");
  level endon("kortifex_die");
  level endon("kortifex_stun_down");
  level endon("jump_to_next_stage");
  var_0 = scripts\engine\utility::getstructarray(self._id_B9FE.skill_pos.target, "targetname");
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = level.kortifex get_lighting_spawn_count();

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = scripts\cp\utility::_id_E190("tag_origin", var_0[var_2].origin, var_0[var_2].angles);
    var_3 thread _id_0402(var_0, var_0[var_2]);
    var_3 thread do_damage_check();
    var_3 thread time_out_listener();
    level.kortifex.spawned_actors = scripts\engine\utility::array_add(level.kortifex.spawned_actors, var_3);
    wait 1;
  }
}

get_lighting_spawn_count() {
  var_0 = level.players.size;
  return self._id_DD78["lighting_bolt"].lighting_max_count + (var_0 - 1);
}

_id_0402(var_0, var_1) {
  level endon("game_ended");
  self endon("kill");
  self endon("death");

  for(;;) {
    var_2 = scripts\engine\utility::array_random(var_0);

    if(var_2 != var_1) {
      var_3 = vectornormalize((var_2.origin[0], var_2.origin[1], 0) - (var_1.origin[0], var_1.origin[1], 0));
      var_4 = level.kortifex._id_DD78["lighting_bolt"].lighting_move_speed / 25;
      var_5 = self.origin + var_3 * var_4;

      while(distance2dsquared(self.origin, var_2.origin) > _func_0219(50)) {
        if(istrue(self.b_stop_moving)) {
          waitframe();
          continue;
        }

        var_6 = scripts\engine\trace::_bullet_trace((var_5[0], var_5[1], self.origin[2]) + (0, 0, 100), (var_5[0], var_5[1], self.origin[2]) + (0, 0, -500), 0, self);

        if(var_6["fraction"] < 1) {
          var_7 = var_6["position"];

          if(isvector(var_7)) {
            self.origin = (var_5[0], var_5[1], var_7[2]);
            var_5 = self.origin + var_3 * var_4;
          }
        } else {
          var_5 = (var_5[0] + randomintrange(-5, 5), var_5[1] + randomintrange(-5, 5), self.origin[2]);
          self.origin = var_5;
          var_5 = self.origin + var_3 * var_4;
        }

        waitframe();
      }

      var_1 = var_2;
    }

    waitframe();
  }
}

do_damage_check() {
  level endon("game_ended");
  self endon("kill");
  self endon("death");
  level endon("kortifex_die");
  level endon("jump_to_next_stage");

  for(;;) {
    var_0 = _func_040F(level.players, self.origin, 550);
    var_1 = undefined;

    if(_func_0107(var_0) && var_0.size != 0) {
      var_2 = scripts\engine\utility::array_random(level.players);
      var_1 = _func_02A9(var_2.origin, 30);
    }

    thread spawn_lighting_bolt_actor(var_1);
    wait(level.kortifex._id_DD78["lighting_bolt"].lighting_damage_interval);
  }
}

spawn_lighting_bolt_actor(var_0) {
  level endon("game_ended");

  if(isDefined(var_0)) {
    var_1 = var_0;
  } else {
    var_1 = self.origin;
  }

  var_2 = scripts\cp\utility::_id_E190("tag_origin", self.origin);

  if(istrue(level.kortifex._id_2038)) {
    playFXOnTag(level._effect["lighting_bolt_alarm_big"], var_2, "tag_origin");
  } else {
    playFXOnTag(level._effect["lighting_bolt_alarm"], var_2, "tag_origin");
  }

  waitframe();
  wait 3;
  stopFXOnTag(level._effect["lighting_bolt_alarm"], var_2, "tag_origin");
  waitframe();
  stopFXOnTag(level._effect["lighting_bolt_alarm_big"], var_2, "tag_origin");
  var_3 = undefined;

  foreach(var_5 in level.players) {
    if(var_5 scripts\cp\utility::_id_8708()) {
      var_6 = distancesquared(var_5.origin, var_2.origin);

      if(var_5._id_0133.basename == "s4_me_rindigoww_mp" && var_6 <= _func_0219(level.kortifex._id_DD78["lighting_bolt"].lighting_damage_radius)) {
        var_3 = var_5;
      }
    }
  }

  if(istrue(level.kortifex._id_2038)) {
    if(isPlayer(var_3)) {
      var_3 earthquakeforplayer(0.5, 2, var_3.origin, 100);
      var_3 playrumbleonentity("cp_zm_s2_mq_shield_rumble");
      playFXOnTag(level._effect["lighting_bolt_big"], var_3, "j_shield_ri");
      waitframe();
      playFXOnTag(level._effect["hit_decimator_shield"], var_3, "j_shield_ri");
      waitframe();
      playFXOnTag(level._effect["shield_flash_fx"], var_3, "j_shield_ri");
      var_3 playSound("zmb_decimator_shield_impact");
      level thread play_decimator_shield_vo();
      return;
    } else
      playFXOnTag(level._effect["lighting_bolt_big"], var_2, "tag_origin");

    var_2 playSound("zm_kort_ring_of_fire");
  } else {
    if(isPlayer(var_3)) {
      var_3 earthquakeforplayer(0.5, 2, var_3.origin, 150);
      var_3 playrumbleonentity("cp_zm_s2_mq_shield_rumble");
      playFXOnTag(level._effect["lighting_bolt"], var_3, "j_shield_ri");
      waitframe();
      playFXOnTag(level._effect["hit_decimator_shield"], var_3, "j_shield_ri");
      waitframe();
      playFXOnTag(level._effect["shield_flash_fx"], var_3, "j_shield_ri");
      var_3 playSound("zmb_decimator_shield_impact");
      level thread play_decimator_shield_vo();
      return;
    } else
      playFXOnTag(level._effect["lighting_bolt"], var_2, "tag_origin");

    var_2 playSound("zm_kort_lightning_bolt");
  }

  foreach(var_5 in level.players) {
    if(var_5 scripts\cp\utility::_id_8708()) {
      var_6 = distancesquared(var_5.origin, var_2.origin);

      if(var_6 <= _func_0219(level.kortifex._id_DD78["lighting_bolt"].lighting_damage_radius)) {
        if(istrue(level.kortifex._id_2038)) {
          var_9 = 99999;
        } else {
          var_9 = level.kortifex._id_DD78["lighting_bolt"].lighting_damage;
        }

        var_9 = int(_id_0707::_id_42B7(var_5, var_5, self, var_9, undefined, "MOD_IMPACT"));
        var_5 dodamage(var_9, var_2.origin, level.kortifex, undefined, "MOD_IMPACT");
        var_5 thread play_player_electric_effect();
      }
    }
  }

  var_11 = _func_0071(var_2.origin, level.kortifex._id_DD78["lighting_bolt"].lighting_damage_radius, level._id_11056);

  foreach(var_13 in var_11) {
    var_14 = 0;

    if(isalive(var_13)) {
      var_6 = distancesquared(var_13.origin, var_2.origin);

      if(var_6 <= _func_0219(level.kortifex._id_DD78["lighting_bolt"].lighting_damage_radius)) {
        var_13 dodamage(var_13.maxhealth, var_2.origin, level.kortifex, undefined, "MOD_UNKNOWN");
        var_13 thread lc_stun();
        var_14++;
      }
    }

    if(var_14 == level.kortifex._id_DD78["lighting_bolt"].lighting_max_kill_zombies) {
      break;
    }
  }

  if(_func_0107(level.a_anemones) && !isDefined(var_3)) {
    foreach(var_17 in level.a_anemones) {
      var_6 = distancesquared(var_17.origin, var_2.origin);

      if(var_6 <= _func_0219(level.kortifex._id_DD78["lighting_bolt"].lighting_damage_radius)) {
        var_18 = 1;

        foreach(var_5 in level.players) {
          if(isPlayer(var_5)) {
            var_20 = distancesquared(var_17.origin, var_5.origin);

            if(var_5._id_0133.basename == "s4_me_rindigoww_mp" && check_face_angles(0.6, var_2, var_5) && check_behind_angles(0.7, var_2, var_17, var_5) && var_20 <= var_6) {
              var_18 = 0;
              break;
            }
          }
        }

        if(var_17.health > 0 && istrue(var_18)) {
          if(istrue(level.kortifex._id_2038)) {
            var_17 _meth_8871(9999, undefined, level.kortifex);
          } else {
            var_17 _meth_8871(level.kortifex._id_DD78["lighting_bolt"].lighting_damage, undefined, level.kortifex);
          }
        }
      }
    }
  }

  wait 3;

  if(isDefined(var_2.fx_proxy)) {
    var_2.fx_proxy delete();
  }

  var_2 delete();
}

time_out_listener() {
  level endon("game_ended");
  self endon("kill");
  self endon("death");

  if(istrue(level.kortifex._id_2038)) {
    var_0 = level.kortifex._id_DD78["lighting_bolt"].life_time / 2;
  } else {
    var_0 = level.kortifex._id_DD78["lighting_bolt"].life_time;
  }

  wait(var_0);
  level.kortifex.spawned_actors = scripts\engine\utility::array_remove(level.kortifex.spawned_actors, self);
  self notify("kill");
  self delete();
}

_id_E258() {
  level endon("game_ended");
  level endon("kortifex_die");
  level endon("kortifex_stun_down");
  level endon("jump_to_next_stage");

  if(isDefined(level.kortifex.sound_proxy)) {
    level.kortifex.sound_proxy playSound("zmb_kort_zmb_horde_stinger");
  }

  var_0 = scripts\engine\utility::getstructarray(self._id_B9FE._id_E1C6.target, "targetname");
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = 0;

  for(var_2 = 0; var_2 < level.kortifex._id_DD78["summon_zombie"]._id_E16D[level.kortifex.stage_index]["spawn_ai_type"].size; var_2++) {
    var_3 = level.kortifex._id_DD78["summon_zombie"]._id_E16D[level.kortifex.stage_index]["spawn_ai_type"][var_2];
    var_4 = level.kortifex._id_DD78["summon_zombie"]._id_E16D[level.kortifex.stage_index][var_3];
    var_4 = level.kortifex get_spawn_zombie_count(var_4, var_3);

    for(var_5 = 0; var_5 < var_4; var_5++) {
      level.kortifex thread spawn_zombie_with_fx(var_0[var_1], var_3);
      wait(self._id_DD78["summon_zombie"].spawn_dealy);
      var_1++;

      if(var_1 == var_0.size) {
        var_1 = 0;
      }
    }

    wait(self._id_DD78["summon_zombie"].spawn_dealy);
  }
}

get_spawn_zombie_count(var_0, var_1) {
  var_2 = level.players.size;

  if(var_1 == "enemy_base_zombie_sumpf_cp") {
    return var_0 + 3 * (var_2 - 1);
  } else if(var_1 == "enemy_zombie_screamer_cp") {
    return var_0 + 1 * (var_2 - 1);
  } else if(var_1 == "enemy_zombie_juggernaut_cp") {
    if(var_2 >= 3) {
      return var_0 + 2;
    } else {
      return var_0;
    }
  }
}

spawn_zombie_with_fx(var_0, var_1) {
  level endon("game_ended");
  level endon("kortifex_die");
  var_2 = _func_0070(level._id_11056);

  if(_func_0107(var_2) && var_2.size > 23) {
    return;
  }
  var_3 = scripts\cp\utility::_id_E190("tag_origin", var_0.origin, var_0.angles);
  level.kortifex.spawned_actors = scripts\cp\utility::_id_1B8C(level.kortifex.spawned_actors, var_3);
  playFXOnTag(level._effect["domination_rune_idle"], var_3, "tag_origin");
  wait 1;
  playFXOnTag(level._effect["domination_rune_zombie_spawn"], var_3, "tag_origin");
  var_4 = _id_09A4::_id_110AD(var_1, var_0.origin, var_0.angles, var_0);

  if(isDefined(var_4)) {
    if(isDefined(var_4._id_D603)) {
      var_4 scripts\engine\utility::delaythread(1, var_4._id_D603, "sprint");
    }
  }

  wait 1;
  stopFXOnTag(level._effect["domination_rune_idle"], var_3, "tag_origin");
  var_3 delete();
}

kortifex_select_weapon() {
  var_0 = self.activate_weapon_list;

  if(_func_0107(level.kortifex.force_skill) && level.kortifex.force_skill.size != 0 && level.kortifex.force_skill[0] == "summon_weapons") {
    if(_func_0107(level.kortifex.force_weapon) && level.kortifex.force_weapon.size != 0) {
      return level.kortifex.force_weapon[0];
    }
  }

  if(istrue(self._id_2038)) {
    if(scripts\cp\utility::_id_88B7(var_0, "ring_of_fire")) {
      var_0 = scripts\engine\utility::array_remove(var_0, "ring_of_fire");
    }
  }

  if(istrue(self.b_in_healing) || level.kortifex.health >= level.kortifex._id_9C21 * 0.5 || self._id_DD78["summon_weapons"].weapon_types["healing"]._id_9C0E == 0) {
    if(scripts\cp\utility::_id_88B7(var_0, "healing")) {
      var_0 = scripts\engine\utility::array_remove(var_0, "healing");
    }
  }

  var_1 = randomintrange(0, 100);

  if(var_1 < self._id_DD78["summon_weapons"].weapon_types["healing"]._id_10DF4 && scripts\cp\utility::_id_88B7(var_0, "healing")) {
    self._id_DD78["summon_weapons"].weapon_types["healing"]._id_10DF4 = 20;
    self._id_DD78["summon_weapons"].weapon_types["healing"]._id_9C0E--;
    return "healing";
  } else if(var_1 <= self._id_DD78["summon_weapons"].weapon_types["ring_of_fire"]._id_10DF4 && scripts\cp\utility::_id_88B7(var_0, "ring_of_fire")) {
    self._id_DD78["summon_weapons"].weapon_types["ring_of_fire"]._id_10DF4 = 40;
    return "ring_of_fire";
  } else {
    if(istrue(level.kortifex.stage_index != 0)) {
      self._id_DD78["summon_weapons"].weapon_types["ring_of_fire"]._id_10DF4 = self._id_DD78["summon_weapons"].weapon_types["ring_of_fire"]._id_10DF4 + 5;
    }

    if(istrue(level.kortifex.stage_index == 2)) {
      self._id_DD78["summon_weapons"].weapon_types["healing"]._id_10DF4 = self._id_DD78["summon_weapons"].weapon_types["healing"]._id_10DF4 + 1;
    }

    return "lighting_storm";
  }
}

spawn_weapons(var_0) {
  level endon("game_ended");
  level endon("kortifex_die");

  switch (var_0) {
    case "lighting_storm":
      if(isDefined(self)) {
        thread spawn_lighting_storm();
      }

      break;
    case "ring_of_fire":
      if(isDefined(self)) {
        thread spawn_ring_of_fire();
      }

      break;
    case "healing":
      if(isDefined(self)) {
        thread spawn_healing();
      }

      break;
  }
}

spawn_lighting_storm() {
  level endon("game_ended");
  level endon("kortifex_die");
  level endon("kortifex_stun_down");
  var_0 = anglesToForward(level.kortifex.angles);
  var_1 = scripts\cp\utility::_id_E190("tag_origin", self gettagorigin("tag_eye") + (0, 0, 400) + var_0 * 500);
  level.kortifex.current_lighting_storm_actor = var_1;
  playFXOnTag(level._effect["storm_ball"], var_1, "tag_origin");
  var_1 playSound("zmb_kort_light_ball_spawn");
  var_1 playLoopSound("zmb_kort_light_ball_lp");
  level.kortifex.spawned_actors = scripts\engine\utility::array_add(level.kortifex.spawned_actors, var_1);
  self waittillmatch("boss_fight", "strike");
  playFXOnTag(level._effect["storm_ball"], var_1, "tag_origin");
  level thread skill_screen_shake();

  if(isDefined(var_1)) {
    var_1.hit_proxy = _func_03C5("s4_zm_sumpf_zombie_head", var_1.origin);
    var_1.hit_proxy _meth_8746(var_1);
    var_1.hit_proxy.parent = var_1;
    var_1 thread take_damage_listener();
    var_1 thread weapon_actor_start_move("lighting_storm");
    var_1 thread weapon_actor_do_damage_check("lighting_storm");
    var_1 thread weapon_actor_time_out_listener("lighting_storm");
    var_1 thread check_block_by_shield();
  }
}

check_block_by_shield() {
  level endon("game_ended");
  level endon("kortifex_die");
  self endon("death");

  for(;;) {
    foreach(var_1 in level.players) {
      if(isPlayer(var_1)) {
        var_2 = distancesquared(var_1.origin, self.origin);

        if(var_1._id_0133.basename == "s4_me_rindigoww_mp" && check_face_angles(1, self, var_1) && var_2 <= _func_0219(level.kortifex._id_DD78["summon_weapons"].weapon_types["lighting_storm"].damage_radius)) {
          self.b_dont_deal_damage = 1;
          playFXOnTag(level._effect["hit_decimator_shield"], var_1, "j_shield_ri");
          waitframe();
          playFXOnTag(level._effect["shield_flash_fx"], var_1, "j_shield_ri");
          var_1 playSound("zmb_decimator_shield_impact");
          _func_0130(self);
          waitframe();
          playFX(level._effect["lighting_storm_terminate"], self.origin);
          waitframe();

          if(isDefined(self.hit_proxy) && self.hit_proxy.classname == "scriptable") {
            self.hit_proxy _meth_86BE();
          }

          level thread play_decimator_shield_vo();
          self delete();
        }
      }
    }

    wait 0.1;
  }
}

take_damage_listener() {
  level endon("game_ended");
  level endon("kortifex_die");
  self endon("death");
  var_0 = level.kortifex._id_DD78["summon_weapons"].weapon_types["lighting_storm"].health;

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
    var_15 = var_2 _id_0774::_id_684B(var_10);
    var_1 = 0;

    switch (var_15) {
      case 0:
        var_1 = 5;
        break;
      case 1:
        var_1 = 8;
        break;
      case 2:
        var_1 = 10;
        break;
      case 3:
        var_1 = 12;
        break;
    }

    if(isDefined(var_10.classname) && var_10.classname == "spread") {
      var_1 = var_1 * 2.3;
      var_1 = int(var_1);
    }

    var_0 = var_0 - var_1;

    if(var_0 <= 0) {
      _func_0130(self);
      waitframe();
      playFX(level._effect["lighting_storm_terminate"], self.origin);

      if(isDefined(self.hit_proxy) && self.hit_proxy.classname == "scriptable") {
        self.hit_proxy _meth_86BE();
      }

      self notify("kill");
      self delete();
    }
  }
}

weapon_actor_start_move(var_0) {
  level endon("game_ended");
  self endon("kill");
  self endon("death");
  var_1 = scripts\engine\utility::getstructarray(level.kortifex._id_B9FE.skill_pos.target, "targetname");
  var_2 = scripts\engine\utility::array_random(var_1);
  var_3 = level.players;
  var_3 = scripts\engine\utility::array_randomize(var_3);

  foreach(var_5 in var_3) {
    if(var_5 scripts\cp\utility::_id_8708()) {
      var_2 = var_5;
      break;
    }
  }

  self moveto(var_2.origin + (0, 0, 30), 2);
  self waittill("movedone");

  if(isDefined(self)) {
    self playSound("zmb_kort_light_ball_spawn");
    _func_012F(level._effect["storm_ball"], self, "tag_origin");
  }

  waitframe();

  if(isDefined(self)) {
    playFXOnTag(level._effect["storm_explode"], self, "tag_origin");
  }

  wait 0.3;

  if(isDefined(self)) {
    if(istrue(level.kortifex._id_2038)) {
      playFXOnTag(level._effect["storm_ball_b"], self, "tag_origin");
    } else {
      playFXOnTag(level._effect["storm_ball_a"], self, "tag_origin");
    }
  }

  var_7 = undefined;

  for(;;) {
    if(var_2 scripts\cp\utility::_id_8708()) {
      while(var_2 scripts\cp\utility::_id_8708() && isDefined(self)) {
        if(distance2dsquared(self.origin, var_2.origin) > _func_0219(100)) {
          if(!isDefined(var_7)) {
            var_7 = self.origin;
          }

          var_8 = _func_02A4(var_7, var_2.origin, 1, 1);
          var_9 = undefined;

          for(var_10 = 0; var_10 < var_8.size; var_10++) {
            if(distance2d(var_8[var_10], var_7) > 2) {
              var_9 = var_8[var_10];
              break;
            }
          }

          if(!isvector(var_9)) {
            waitframe();
            continue;
          }

          var_11 = vectornormalize(var_9 - var_7);
          var_12 = level.kortifex._id_DD78["summon_weapons"].weapon_types[var_0]._id_A1FD / 20;
          var_9 = var_7 + var_11 * var_12;
          self.origin = var_9 + (0, 0, 30);
          var_7 = var_9;
        }

        waitframe();
      }
    } else {
      for(;;) {
        var_2 = scripts\engine\utility::array_random(level.players);

        if(var_2 scripts\cp\utility::_id_8708()) {
          break;
        }

        waitframe();
      }
    }

    waitframe();
  }
}

weapon_actor_do_damage_check(var_0) {
  level endon("game_ended");
  self endon("kill");
  level endon("kortifex_die");
  self endon("death");

  for(;;) {
    foreach(var_2 in level.players) {
      if(var_2 scripts\cp\utility::_id_8708()) {
        var_3 = distancesquared(var_2.origin, self.origin);

        if(var_3 <= _func_0219(level.kortifex._id_DD78["summon_weapons"].weapon_types[var_0].damage_radius) && !istrue(self.b_dont_deal_damage)) {
          if(var_0 == "lighting_storm") {
            if(istrue(level.kortifex._id_2038)) {
              var_4 = 99999;
            } else {
              var_4 = level.kortifex._id_DD78["summon_weapons"].weapon_types[var_0].damage;
            }

            var_4 = int(_id_0707::_id_42B7(var_2, var_2, self, var_4, undefined, "MOD_IMPACT"));
            var_2 dodamage(var_4, self.origin, self, undefined, "MOD_UNKNOWN");
            var_2 thread play_player_electric_effect();
            var_2 playSound("zmb_kort_light_ball_impact");
          } else {
            var_2 dodamage(level.kortifex._id_DD78["summon_weapons"].weapon_types[var_0].damage, self.origin, self, undefined, "MOD_UNKNOWN");
            var_2 thread play_player_electric_effect();
          }
        }
      }
    }

    var_6 = _func_0071(self.origin, level.kortifex._id_DD78["summon_weapons"].weapon_types[var_0].damage_radius, level._id_11056);

    foreach(var_8 in var_6) {
      if(isalive(var_8)) {
        var_3 = distancesquared(var_8.origin, self.origin);

        if(var_3 <= _func_0219(level.kortifex._id_DD78["summon_weapons"].weapon_types[var_0].damage_radius)) {
          var_8 dodamage(var_8.maxhealth / 3, self.origin, self, undefined, "MOD_UNKNOWN");
          var_8 thread lc_stun();
          var_8 playSound("zmb_kort_light_ball_impact");
        }
      }
    }

    if(_func_0107(level.a_anemones)) {
      foreach(var_11 in level.a_anemones) {
        var_3 = distancesquared(var_11.origin, self.origin);

        if(var_3 <= _func_0219(level.kortifex._id_DD78["summon_weapons"].weapon_types[var_0].damage_radius)) {
          if(var_11.health > 0) {
            if(istrue(level.kortifex._id_2038)) {
              var_11 _meth_8871(9999, undefined, self);
              continue;
            }

            var_11 _meth_8871(level.kortifex._id_DD78["summon_weapons"].weapon_types[var_0].damage, undefined, self);
          }
        }
      }
    }

    wait(level.kortifex._id_DD78["summon_weapons"].weapon_types[var_0].damage_interval);
  }
}

play_storm_trail(var_0, var_1) {
  level endon("game_ended");
  var_2 = scripts\cp\utility::_id_E190("tag_origin", var_0);
  playFXOnTag(level._effect["lighting_storm_trail"], var_2, "tag_origin");
  var_2 moveto(var_1 gettagorigin("j_shield_ri"), 2);
  var_2 waittill("movedone");
  var_2 delete();
}

check_face_angles(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = var_2 getEye();

  if(!isvector(var_1.origin) || !isvector(var_4)) {
    return 0;
  }

  var_5 = vectortoangles((var_1.origin[0], var_1.origin[1], 0) - (var_4[0], var_4[1], 0));
  var_5 = anglesToForward(var_5);

  if(isDefined(var_5)) {
    var_6 = var_2 getplayerangles();
    var_6 = anglesToForward(var_6);
    var_3 = length(var_6 - var_5);
  }

  if(var_3 <= var_0) {
    return 1;
  }

  return 0;
}

check_behind_angles(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_5 = vectortoangles((var_3.origin[0], var_3.origin[1], 0) - (var_1.origin[0], var_1.origin[1], 0));
  var_6 = vectortoangles((var_2.origin[0], var_2.origin[1], 0) - (var_1.origin[0], var_1.origin[1], 0));
  var_5 = anglesToForward(var_5);
  var_6 = anglesToForward(var_6);

  if(isDefined(var_5) && isDefined(var_6)) {
    var_4 = length(var_6 - var_5);
  }

  if(var_4 < var_0) {
    return 1;
  }

  return 0;
}

lc_stun() {
  level endon("game_ended");
  self endon("death");

  if(isDefined(self.zm_ai_category) && (self.zm_ai_category == "special" || self.zm_ai_category == "elite")) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  scripts\aitypes\zombie_common\stun::stun(2, "dead_wire");
  self.lc_stunned = 1;
  self notify("zombie_lc_stunned");
  self setscriptablepartstate("electricity", "active");
  self playLoopSound("zmb_deadwire_stun_lp");
  wait 2;
  self setscriptablepartstate("electricity", "neutral");
  self stoploopsound("zmb_deadwire_stun_lp");
  self.lc_stunned = 0;
}

play_player_electric_effect() {
  level endon("game_ended");
  self endon("disconnect");
  self shellshock("damage_cp", 0.5);
  self notify("refresh_electric_effect");
  self endon("refresh_electric_effect");

  if(!isDefined(self.electric_vfx_ent)) {
    self.electric_vfx_ent = _func_020D(scripts\engine\utility::getfx("trap_electric_player"), self.origin, self);
    triggerfx(self.electric_vfx_ent);
    scripts\cp\utility::_id_10839(2);
    thread switch_electricity_effect_on_body(1);
  }

  wait 1.5;

  if(isDefined(self.electric_vfx_ent)) {
    self.electric_vfx_ent delete();
  }

  scripts\cp\utility::_id_10839(2);
  switch_electricity_effect_on_body(0);
  self.b_playing_electric_effect = undefined;
}

switch_electricity_effect_on_body(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(istrue(var_0)) {
    playFXOnTag(level._effect["electricity_hip_le"], self, "j_hip_proc_le");
    scripts\cp\utility::_id_10839(2);
    playFXOnTag(level._effect["electricity_hip_ri"], self, "j_hip_proc_ri");
    scripts\cp\utility::_id_10839(2);
    playFXOnTag(level._effect["electricity_knee_le"], self, "j_knee_le");
    scripts\cp\utility::_id_10839(2);
    playFXOnTag(level._effect["electricity_knee_ri"], self, "j_knee_ri");
    scripts\cp\utility::_id_10839(2);
    playFXOnTag(level._effect["electricity_shoulder_ri"], self, "j_shouldertwist_ri");
    scripts\cp\utility::_id_10839(2);
    playFXOnTag(level._effect["electricity_shoulder_le"], self, "j_shouldertwist_le");
    scripts\cp\utility::_id_10839(2);
    playFXOnTag(level._effect["electricity_elbow_le"], self, "j_elbow_le");
    scripts\cp\utility::_id_10839(2);
    playFXOnTag(level._effect["electricity_elbow_ri"], self, "j_elbow_ri");
  } else {
    _func_012F(level._effect["electricity_hip_le"], self, "j_hip_proc_le");
    scripts\cp\utility::_id_10839(2);
    _func_012F(level._effect["electricity_hip_ri"], self, "j_hip_proc_ri");
    scripts\cp\utility::_id_10839(2);
    _func_012F(level._effect["electricity_knee_le"], self, "j_knee_le");
    scripts\cp\utility::_id_10839(2);
    _func_012F(level._effect["electricity_knee_ri"], self, "j_knee_ri");
    scripts\cp\utility::_id_10839(2);
    _func_012F(level._effect["electricity_shoulder_ri"], self, "j_shouldertwist_ri");
    scripts\cp\utility::_id_10839(2);
    _func_012F(level._effect["electricity_shoulder_le"], self, "j_shouldertwist_le");
    scripts\cp\utility::_id_10839(2);
    _func_012F(level._effect["electricity_elbow_le"], self, "j_elbow_le");
    scripts\cp\utility::_id_10839(2);
    _func_012F(level._effect["electricity_elbow_ri"], self, "j_elbow_ri");
  }
}

weapon_actor_time_out_listener(var_0) {
  level endon("game_ended");
  level endon("kortifex_die");
  self endon("death");
  wait(level.kortifex._id_DD78["summon_weapons"].weapon_types[var_0].life_time);
  _func_0130(self);

  if(isDefined(self.hit_proxy) && self.hit_proxy.classname == "scriptable") {
    self.hit_proxy _meth_86BE();
  }

  self notify("kill");
  waitframe();
  self delete();
}

activate_aether_shroud() {
  level endon("game_end");
  self hide();
  self.middle_eye hide();
  wait 3;
  self.middle_eye show();
  self show();
  self.b_can_damage = 0;
  wait(self._id_DD78["summon_weapons"].weapon_types["aether_shroud"].duration_time);
  self.b_can_damage = 1;
}

spawn_frozen_fog() {
  level endon("game_ended");
  level endon("kortifex_die");
  var_0 = self gettagorigin("j_metaindex_ri_1");
  var_1 = scripts\cp\utility::_id_E190("tag_origin", var_0 + (0, 0, 30));
  playFXOnTag(level._effect["lighting_storm"], var_1, "tag_origin");
  level.kortifex.spawned_actors = scripts\engine\utility::array_add(level.kortifex.spawned_actors, var_1);
  wait 2;
  var_1 thread weapon_actor_start_move("frozen_fog");
  var_1 thread weapon_actor_do_damage_check("frozen_fog");
  var_1 thread weapon_actor_time_out_listener("frozen_fog");
  var_1 thread slow_down_players_check();
  var_1 waittill("kill");

  foreach(var_3 in level.players) {
    var_3 _id_06E5::_id_C5A1("forze_slow");
  }
}

slow_down_players_check() {
  level endon("game_ended");
  self endon("kill");

  for(;;) {
    foreach(var_1 in level.players) {
      if(var_1 scripts\cp\utility::_id_8708()) {
        var_2 = distancesquared(self.origin, var_1.origin);

        if(var_2 <= _func_0219(level.kortifex._id_DD78["summon_weapons"].weapon_types["frozen_fog"].damage_radius)) {
          var_1 _id_06E5::_id_D12B("forze_slow", "move_speed_scale", level.kortifex._id_DD78["summon_weapons"].weapon_types["frozen_fog"].slow_rate);
        } else {
          var_1 _id_06E5::_id_C5A1("forze_slow");
        }
      }
    }

    wait 0.1;
  }
}

spawn_ring_of_fire() {
  level endon("game_ended");
  self endon("death");
  level endon("jump_to_next_stage");
  playFXOnTag(level._effect["ring_of_fire"], level.kortifex, "tag_origin");
  level.kortifex._id_2038 = 1;
  wait(level.kortifex._id_DD78["summon_weapons"].weapon_types["ring_of_fire"].duration_time);
  stopFXOnTag(level._effect["ring_of_fire"], level.kortifex, "tag_origin");
  level.kortifex._id_2038 = 0;
}

spawn_healing() {
  level endon("game_ended");
  self endon("death");
  level endon("kortifex_die");
  level.kortifex.sound_proxy playSound("zmb_kort_healing_aura_on");
  level.kortifex.b_in_healing = 1;
  var_0 = 0;
  level.kortifex.sound_proxy playLoopSound("zmb_kort_healing_aura_lp");
  var_1 = int(level.kortifex get_healing_number());
  level thread healing_all_zombies();
  var_2 = level.kortifex.health + var_1;
  var_2 = clamp(var_2, 0, level.kortifex._id_9C21);
  level.kortifex.health = int(var_2);
  level.kortifex thread update_kortifex_health_bar(var_1 * -1);
  wait 1;
  level.kortifex.sound_proxy stoploopsound("zmb_kort_healing_aura_lp");
  level.kortifex.sound_proxy playSound("zmb_kort_healing_aura_off");
  level.kortifex.b_in_healing = 0;
}

healing_all_zombies() {
  var_0 = _func_0070(level._id_11056);

  foreach(var_2 in var_0) {
    if(isalive(var_2) && var_2._id_1210 != "actor_enemy_zombie_screamer_cp") {
      playFXOnTag(level._effect["zombie_heal_fx"], var_2, "tag_origin");
      var_2.health = var_2.maxhealth;
    }
  }
}

get_healing_number() {
  var_0 = level.players.size;
  return int(level.kortifex._id_9C21 / 9);
}

start_executions() {
  level endon("game_ended");
  level endon("jump_to_next_stage");

  for(;;) {
    var_0 = scripts\engine\utility::array_random(level.players);

    if(var_0 scripts\cp\utility::_id_8708()) {
      var_1 = var_0;
      break;
    }

    waitframe();
  }

  var_1 disable_player_movement(1);
  var_2 = scripts\cp\utility::_id_E190("tag_origin", var_1.origin);
  var_1.moving_proxy = var_2;
  var_1 playerlinkto(var_2, "tag_origin");
  var_2 moveto(var_2.origin + (0, 0, 250), 5);
  var_2 waittill("movedone");
  thread break_execution_listener();
  thread execution_timer();
  level waittill("finish_execution", var_3);

  if(istrue(var_3)) {
    var_1 dodamage(9999, var_1.origin, self, undefined, "MOD_UNKNOWN");
  }

  var_1 thread release_execution_player();
}

break_execution_listener() {
  level endon("game_ended");
  level endon("finish_execution");

  for(var_0 = self._id_DD78["executions"].execution_break_damage; var_0 >= 0; var_0 = var_0 - var_1) {
    self.middle_eye waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  }

  level notify("finish_execution", 0);
}

execution_timer() {
  level endon("game_ended");
  level endon("finish_execution");
  wait(self._id_DD78["executions"].execution_time);
  level notify("finish_execution", 1);
}

disable_player_movement(var_0) {
  if(istrue(var_0)) {
    self.ignoreme = 1;
    _id_06E5::_id_D12B("execution", "allow_movement", 0);
    _id_06E5::_id_D12B("execution", "allow_jump", 0);
    _id_06E5::_id_D12B("execution", "allow_crouch", 0);
    _id_06E5::_id_D12B("execution", "allow_prone", 0);
  } else {
    self.ignoreme = 0;
    _id_06E5::_id_C5A1("execution");
  }
}

release_execution_player() {
  if(!isDefined(self.moving_proxy)) {
    return;
  }
  var_0 = scripts\engine\trace::_bullet_trace(self.origin, self.origin + (0, 0, -500), 0, self);
  var_1 = var_0["position"];
  self.moving_proxy moveto(var_1, 1);
  self.moving_proxy waittill("movedone");
  self unlink();
  disable_player_movement(0);
  self.moving_proxy delete();
}

kortifex_stage2_manager() {
  level endon("game_ended");
  level endon("kortifex_die");
  level endon("jump_to_next_stage");
  level thread spawn_floating_pillars();
  level thread refresh_stage2_actors();
  level thread stun_down_kortifex_listener();
}

kortifex_rune_shield_manager() {
  level endon("game_ended");
  level endon("kortifex_die");
  level endon("jump_to_next_stage");
  level.kortifex.b_protected_by_shield = 1;
  scripts\cp\utility::_id_10839(2);
  playFXOnTag(level._effect["rune_shield"], level.kortifex, "j_neck");

  for(;;) {
    level waittill("kortifex_stun_down");
    level.kortifex.b_protected_by_shield = 0;
    wait 15;
    level.kortifex.b_protected_by_shield = 1;
  }
}

ruin_shield_take_damage() {
  level endon("game_ended");
  self endon("kill");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    _func_0102(var_3);
    var_10 = vectortoangles(var_3 - self.origin);
    playFX(level._effect["rune_shield_impact"], var_3, anglesToForward(var_10));

    if(!istrue(level.kortifex.b_play_hit_shield) && level scripts\engine\utility::_id_5C00("finish_intro_vo") && !level scripts\engine\utility::_id_5C00("boss_dialogue_busy")) {
      level thread play_sequence_vos(["zm_cpm5_bfs5_krtx_bika", "zm_cpm5_bfs5_dnrt_bikb", "zm_cpm5_bfs5_vrcn_bikc"], "finish_hit_shield_vo");
      level.kortifex.b_play_hit_shield = 1;
    }
  }
}

stun_down_kortifex_listener() {
  level endon("game_ended");
  level endon("kortifex_die");
  level endon("jump_to_next_stage");
  level.kortifex.b_protected_by_shield = 1;
  scripts\cp\utility::_id_10839(2);
  playFXOnTag(level._effect["rune_shield"], level.kortifex, "j_neck");
  level.kortifex.rune_shield = scripts\cp\utility::_id_E190("s4_zm_kortifex_eyeball_large", level.kortifex gettagorigin("j_neck"));
  level.kortifex.rune_shield linkto(level.kortifex, "j_neck");
  level.kortifex.rune_shield setCanDamage(1);
  level.kortifex.rune_shield thread ruin_shield_take_damage();
  var_0 = 0;

  for(;;) {
    level waittill("hit_void_construct");

    if(!istrue(level.kortifex.b_protected_by_shield) || !istrue(level.kortifex.b_can_damage) || istrue(level.kortifex.b_stun_down)) {
      wait 1;
      continue;
    }

    var_0++;
    playFXOnTag(level._effect["hit_construct_fx"], level.void_construct.fx_proxy, "tag_origin");

    foreach(var_2 in level.players) {
      var_2 earthquakeforplayer(0.5, 1, var_2.origin, 100);
      var_2 playrumbleonentity("cp_zm_s2_mq_shield_rumble");
    }

    var_4 = scripts\engine\utility::ter_op(level.players.size >= 2, 3, 1);

    if(level.kortifex.rune_shield.model == "s4_zm_kortifex_eyeball_large") {
      level.kortifex.rune_shield setModel("s4_zm_kortifex_eyeball_large02");
    } else if(level.kortifex.rune_shield.model == "s4_zm_kortifex_eyeball_large02") {
      level.kortifex.rune_shield setModel("s4_zm_kortifex_eyeball_large03");
    }

    stopFXOnTag(level._effect["rune_shield"], level.kortifex, "j_neck");

    if(var_0 % var_4 == 0) {
      wait 0.5;
      play_construct_hit_beam(1000);

      if(isDefined(level.kortifex) && !istrue(level.kortifex.b_play_shield_down)) {
        level thread _id_0720::play_narration("zm_cpm5_bfs5_dnrt_bipa");
        level.kortifex.b_play_shield_down = 1;
      }

      playFX(level._effect["shield_exp"], level.kortifex gettagorigin("j_neck"), anglesToForward(level.kortifex.angles), anglestoup(level.kortifex.angles));
      level notify("kortifex_stun_down");
      level thread kortifex_stun_down_timer();
      stopFXOnTag(level._effect["rune_shield"], level.kortifex, "j_neck");
      level.kortifex.b_protected_by_shield = 0;

      if(isDefined(level.kortifex.rune_shield)) {
        level.kortifex.rune_shield notify("kill");
        level.kortifex.rune_shield unlink();
        level.kortifex.rune_shield delete();
      }

      stopFXOnTag(level._effect["summon_body"], level.kortifex, "j_spine4");
      waitframe();
      level.kortifex thread stop_all_hands_fx();

      if(isDefined(level.kortifex.current_lighting_storm_actor)) {
        if(isDefined(level.kortifex.current_lighting_storm_actor.hit_proxy)) {
          level.kortifex.current_lighting_storm_actor.hit_proxy _meth_86BE();
        }

        level.kortifex.current_lighting_storm_actor delete();
      }

      level.kortifex _meth_82CA();
      level.kortifex _meth_82CB(level.kortifex.stun_down_anim_intro, "boss_fight");
      level.kortifex waittillmatch("boss_fight", "finish");

      for(;;) {
        level.kortifex _meth_82CB(level.kortifex.stun_down_anim_loop, "boss_fight", 0, 1, "normal");
        level.kortifex waittillmatch("boss_fight", "finish");

        if(!istrue(level.kortifex.b_stun_down)) {
          break;
        }
      }

      level.kortifex _meth_82CB(level.kortifex.stun_down_anim_outro, "boss_fight", 0, 1, "normal");
      level.kortifex waittillmatch("boss_fight", "finish");
      level.kortifex.b_protected_by_shield = 1;
      playFXOnTag(level._effect["rune_shield"], level.kortifex, "j_neck");
      level.kortifex.rune_shield = scripts\cp\utility::_id_E190("s4_zm_kortifex_eyeball_large", level.kortifex gettagorigin("j_neck"));
      level.kortifex.rune_shield linkto(level.kortifex, "j_neck");
      level.kortifex.rune_shield setCanDamage(1);
      level.kortifex.rune_shield thread ruin_shield_take_damage();
      playFXOnTag(level._effect["rune_shield"], level.kortifex, "j_neck");
      level.kortifex.b_common_cool_down = 1;
      level.kortifex.b_in_idle_state = 0;
      level.kortifex thread start_boss_skill_manager();
    }
  }
}

play_construct_hit_beam(var_0) {
  var_1 = vectortoangles(level.void_construct.origin + (0, 0, 1000) - level.kortifex gettagorigin("j_neck"));
  var_2 = anglesToForward(var_1);
  var_3 = level.kortifex gettagorigin("j_neck") + var_2 * 150;
  _func_0313(level._effect["construct_hit_fx"], var_3, var_2, level.void_construct.origin);
  waitframe();
  playFX(level._effect["construct_hit_kortifex_fx"], level.kortifex gettagorigin("j_neck") + var_2 * var_0, anglesToForward(var_1), anglestoup(var_1));
}

kortifex_stun_down_timer() {
  level endon("game_ended");
  level endon("kortifex_die");
  level endon("jump_to_next_stage");
  level.kortifex.b_stun_down = 1;
  wait 15;
  level.kortifex.b_stun_down = 0;
}

refresh_stage2_actors() {
  level endon("game_ended");
  level endon("kortifex_die");
  wait 60;

  for(;;) {
    var_0 = scripts\engine\utility::getstructarray("s_crystal", "targetname");

    foreach(var_2 in var_0) {
      var_2 spawn_dark_aether_crystal();
    }

    var_4 = scripts\engine\utility::getstructarray("s_floating_pillar", "targetname");

    foreach(var_6 in var_4) {
      if(!isDefined(var_6.mdl_pillar)) {
        var_6 thread pillar_jump_into_level();
        var_7 = randomfloatrange(0.5, 1.5);
        wait(var_7);
      }
    }

    wait 60;
  }
}

spawn_floating_pillars() {
  level endon("game_ended");
  wait 3;
  var_0 = scripts\engine\utility::getstructarray("s_floating_pillar", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread pillar_jump_into_level();
    var_3 = randomfloatrange(0.5, 1.5);
    wait(var_3);
  }
}

pillar_jump_into_level() {
  level endon("game_ended");
  self.mdl_pillar = scripts\cp\utility::_id_E190("s4_zm_floating_monolith", self.origin + (0, 0, 20000), self.angles);
  self.mdl_pillar movez(-20000, 5);
  self.mdl_pillar waittill("movedone");
  self.mdl_pillar thread start_bobbing();
  self.mdl_pillar thread watch_electric_heart_stuck();
}

start_bobbing() {
  level endon("game_ended");
  self endon("death");
  self endon("stop_bobbing");
  var_0 = 15;

  for(;;) {
    self movez(var_0, 3);
    self waittill("movedone");
    var_0 = var_0 * -1;
  }
}

watch_electric_heart_stuck() {
  level endon("game_ended");
  self endon("death");
  level endon("kortifex_die");
  self waittill("electric_heart_stuck", var_0, var_1);

  if(isDefined(var_0)) {
    var_0 notify("tossed_electric_heart");
  }

  self notify("stop_bobbing");

  if(isvector(var_1)) {
    scripts\cp\utility::_id_B8ED(var_1, "zmb_construct_grenade_hit");
  }

  var_2 = vectortoangles((level.void_construct.origin[0], level.void_construct.origin[1], 0) - (self.origin[0], self.origin[1], 0));
  self.fx_proxy = scripts\cp\utility::_id_E190("tag_origin", self.origin, var_2 + (0, -45, 0));
  playFXOnTag(level._effect["suck_pillar"], self.fx_proxy, "tag_origin");
  self.fx_proxy linkto(self);
  self movez(200, 3);
  self waittill("movedone");

  if(isDefined(level.void_construct)) {
    var_3 = level.void_construct.origin + anglesToForward(level.void_construct.angles + (0, -90, 0)) * 2000;
    scripts\cp\utility::_id_B8ED(self.origin, "zmb_meteor_leave_whoosh");
    self moveto(var_3, 3);
    self waittill("movedone");
  }

  level.kortifex _meth_83F8();
  var_4 = scripts\engine\utility::array_random(["zm_cpm5_bfs5_krtx_bioa", "zm_cpm5_bfs5_krtx_biob", "zm_cpm5_bfs5_krtx_bioc", "zm_cpm5_bfs5_krtx_biod"]);
  level thread play_sequence_vos([var_4]);
  playFXOnTag(level._effect["pillar_explode"], self.fx_proxy, "tag_origin");
  waitframe();
  stopFXOnTag(level._effect["suck_pillar"], self.fx_proxy, "tag_origin");
  level notify("hit_void_construct");
  self hide();
  wait 5;
  self.fx_proxy delete();
  self delete();
}

anemone_spawn(var_0) {
  self.health = 300;
  var_1 = scripts\engine\utility::ter_op(var_0, "revive", "spawn");
  self setscriptablepartstate("anemone", var_1);
  self.mouth setscriptablepartstate("anemone_mouth", "active");
  thread release_toxic_smoke();
  thread anemone_monitor_damage();
  thread watch_crystal_shard_swallowed();
}

init_dark_aether_anemones() {
  foreach(var_1 in level.a_anemones) {
    if(isDefined(var_1)) {
      var_1 thread anemone_spawn(0);
    }
  }

  level thread anemone_molotov_use_check();
}

anemone_molotov_use_check() {
  level endon("game_ended");

  for(;;) {
    foreach(var_1 in level._id_A02C._id_CF26) {
      if(!isDefined(var_1) || !isDefined(var_1.trigger)) {
        continue;
      }
      foreach(var_3 in level.a_anemones) {
        if(isDefined(var_3) && distance(var_3.origin, var_1.trigger.origin) < var_1._id_B9D9._id_F630) {
          var_3 notify("damage", 10, var_1.trigger.attacker);
        }
      }
    }

    wait 0.5;
  }
}

cleanup_all_dark_aether_anemones() {
  foreach(var_1 in level.a_anemones) {
    if(isDefined(var_1)) {
      var_1 notify("anemone_explode");
      var_1 setscriptablepartstate("anemone", "dead");
      var_1.mouth setscriptablepartstate("anemone_mouth", "idle");
      var_1.mouth.has_crystal = undefined;
    }
  }
}

respawn_anemones() {
  foreach(var_1 in level.a_anemones) {
    if(isDefined(var_1)) {
      var_1 thread anemone_spawn(1);
    }
  }
}

watch_crystal_shard_swallowed() {
  self notify("watch_crystal_shard_swallowed");
  self endon("watch_crystal_shard_swallowed");
  level endon("game_ended");
  self endon("anemone_explode");
  self.mouth waittill("crystal_shard_swallowed");
  self.mouth.has_crystal = 1;

  if(isDefined(level.kortifex) && !istrue(level.kortifex.b_play_toss_crystal) && scripts\engine\utility::is_equal(level.kortifex.stage_index, 1) && level scripts\engine\utility::_id_5C00("finish_intro_anemone_vo")) {
    var_0 = scripts\engine\utility::array_random(["zm_cpm5_bfs5_vrcn_bima", "zm_cpm5_bfs5_vrcn_bimb", "zm_cpm5_bfs5_vrcn_bimc", "zm_cpm5_bfs5_vrcn_bimd"]);
    level thread play_sequence_vos([var_0], "finish_protect_anemone_vo");
    level.kortifex.b_play_toss_crystal = 1;
  }

  wait 0.3;
  self.mouth setscriptablepartstate("anemone_mouth", "idle");
  self setscriptablepartstate("anemone", "swallow");
  wait 20;

  if(isDefined(level.kortifex) && !scripts\engine\utility::is_equal(level.kortifex.stage_index, 0) && level scripts\engine\utility::_id_5C00("finish_protect_anemone_vo")) {
    level thread _id_0720::play_narration(["zm_cpm5_bfs5_vrcn_bina", "zm_cpm5_bfs5_vrcn_binb", "zm_cpm5_bfs5_vrcn_binc", "zm_cpm5_bfs5_vrcn_bind"]);
  }

  _id_073D::_id_4FF0("dark_aether_anemone", self.origin, self.angles, undefined, 30);
  thread explode_and_respawn(1);
}

release_toxic_smoke() {
  level endon("game_ended");
  self endon("anemone_explode");

  for(;;) {
    if(scripts\engine\utility::is_equal(self _meth_8575("anemone", 1), "active")) {
      var_0 = scripts\cp\utility::_id_688C(self.origin, 120);

      if(_func_0107(var_0) && var_0.size > 0) {
        self setscriptablepartstate("anemone", "attack");

        foreach(var_2 in var_0) {
          if(isalive(var_2)) {
            var_3 = scripts\engine\utility::ter_op(isPlayer(var_2), self, var_2);
            var_2 dodamage(30, self.origin, var_3, undefined, "MOD_UNKNOWN");
          }
        }

        if(isDefined(level.kortifex) && istrue(level.kortifex.b_play_hit_shield) && !istrue(level.kortifex.b_play_approaches_anemone) && level scripts\engine\utility::_id_5C00("finish_hit_shield_vo") && level.kortifex.stage_index == 1) {
          level thread play_sequence_vos(["zm_cpm5_bfs5_vrcn_bila", "zm_cpm5_bfs5_vrcn_bilb", "zm_cpm5_bfs5_vrcn_bilc"], "finish_intro_anemone_vo");
          level.kortifex.b_play_approaches_anemone = 1;
        }

        wait 8;
        continue;
      }
    }

    wait 1;
  }
}

anemone_monitor_mouth_damage() {
  level endon("game_ended");
  self endon("anemone_explode");

  for(;;) {
    self.mouth waittill("damage", var_0, var_1);
    self notify("damage", var_0, var_1);
  }
}

anemone_monitor_damage() {
  level endon("game_ended");
  self endon("anemone_explode");
  thread anemone_monitor_mouth_damage();

  while(self.health > 0) {
    self waittill("damage", var_0, var_1, var_2, var_3);
    self.health = self.health - var_0;
    var_4 = self.origin + anglestoup(self.angles) * 20;

    if(isPlayer(var_1)) {
      var_1 thread _id_071B::_id_FC47("standard");
      level thread _id_072E::display_damage_number_internal(var_1, 0, var_0, var_4);
      continue;
    }

    foreach(var_6 in level.players) {
      if(isPlayer(var_6)) {
        level thread _id_072E::display_damage_number_internal(var_6, 0, var_0, var_4);
      }
    }
  }

  thread explode_and_respawn(0);
}

explode_and_respawn(var_0) {
  level endon("game_ended");
  self notify("anemone_explode");
  self endon("anemone_explode");
  var_1 = scripts\engine\utility::ter_op(var_0, "zmb_anemone_explo", "zmb_anemone_psuedo_death");
  playsoundatpos(self.origin, var_1);
  self setscriptablepartstate("anemone", "dead");
  self.mouth setscriptablepartstate("anemone_mouth", "idle");
  self.mouth.has_crystal = undefined;
  wait 60;
  anemone_spawn(1);
}

skill_screen_shake() {
  foreach(var_1 in level.players) {
    if(isPlayer(var_1)) {
      var_1 earthquakeforplayer(0.5, 2, var_1.origin, 100);
      var_1 playrumbleonentity("cp_zm_s2_mq_shield_rumble");
    }
  }
}

is_wonder_weapon(var_0) {
  return var_0 == "s4_pi_raygun_mp" || var_0 == "s4_me_rindigoww_mp" || var_0 == "s4_ar_tgun_mp";
}

getweaponpaplevel(var_0, var_1) {
  if(isDefined(var_1) && isDefined(level._id_6E79)) {
    return var_0[[level._id_6E79]](var_1);
  }

  return 0;
}

_id_0F74(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(!isDefined(self) || !isDefined(var_1)) {
    return var_2;
  }

  scripts\cp\covenants\cp_critical_expertise::try_convert_to_critical_hit(var_1, var_8, var_4);

  if(scripts\cp\covenants\cp_critical_expertise::is_critical_hit(var_1)) {
    var_13 = scripts\cp\covenants\cp_critical_expertise::get_critical_expertise_multiplier(var_1, var_5);
    var_2 = int(var_12 * var_13);
  }

  if(var_4 == "MOD_PROJECTILE" || var_4 == "MOD_PROJECTILE_SPLASH" || var_4 == "MOD_GRENADE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_EXPLOSIVE_BULLET") {
    self._id_FF28 = var_6;

    if(isPlayer(var_1) && isDefined(var_5.basename) && (var_4 == "MOD_PROJECTILE_SPLASH" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_EXPLOSIVE_BULLET")) {
      switch (var_5.basename) {
        case "s4_la_m1bravo_mp":
          var_2 = var_2 * 3;
          var_14 = var_1 _id_0774::_id_684B(var_5);

          if(var_14 > 0) {
            var_2 = var_2 * 1.5;
          }

          break;
        case "s4_la_palpha_mp":
          var_2 = var_2 * 3;
          var_14 = var_1 _id_0774::_id_684B(var_5);

          if(var_14 > 0) {
            var_2 = var_2 * 1.5;
          }

          break;
        case "s4_la_palpha42_mp":
          var_2 = var_2 * 2.8;
          var_14 = var_1 _id_0774::_id_684B(var_5);

          if(var_14 > 0) {
            var_2 = var_2 * 1.5;
          }

          break;
        case "s4_la_mkilo1_mp":
          var_2 = var_2 * 2.8;
          var_14 = var_1 _id_0774::_id_684B(var_5);

          if(var_14 > 0) {
            var_2 = var_2 * 1.5;
          }

          break;
        case "s4_la_walpha2_mp":
          if(!getdvarint("#x3dee089cb49164e4e", 0)) {
            var_2 = var_2 * 1.0;
          }

          break;
        case "s4_mg_streak_mp":
          if(!getdvarint("#x3dee089cb49164e4e", 0)) {
            var_2 = var_2 * 0.75;
          }

          break;
        default:
          break;
      }
    }
  } else
    self._id_FF28 = undefined;

  var_2 = _id_0774::_id_6C04(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

  if(istrue(self._id_203F)) {
    var_2 = var_2 * 2;
  }

  if(!isDefined(var_2) || !isDefined(var_4)) {
    return var_2;
  }

  if(var_4 == "") {
    return var_2;
  }

  var_2 = _id_098E::_id_0F74(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  var_2 = scripts\cp\covenants\cull_the_weak::apply_cull_the_weak_bonus_crit_damage(var_1, var_2, var_4, var_5, var_8);
  self._id_2032 = undefined;
  var_15 = var_2;

  if(isDefined(self._id_2037) && var_15 == 0) {
    return 0;
  }

  var_15 = int(scripts\cp\utility::_id_459B(var_15, var_15));
  scripts\cp\covenants\cp_critical_expertise::reset_critical_hit(var_1);
  return int(var_15);
}

on_zombie_killed_drop_items(var_0) {
  var_1 = randomintrange(0, 100);

  if(var_1 < 15) {
    [var_3, var_4, var_5] = _id_073D::_id_6531(0, self.origin, self.angles);
    _id_092E::_id_E178("cploot_armor_shard", var_3, var_4, var_5, 1, 0, undefined, 30);
  } else if(var_1 < 30) {
    [var_3, var_4, var_5] = _id_073D::_id_6531(0, self.origin, self.angles);
    _id_092E::_id_E178("cploot_ammo", var_3, var_4, var_5, 1, 0, undefined, 30);
  }
}

play_decimator_shield_vo() {
  level endon("game_ended");

  if(!istrue(level.b_shield_cool_down)) {
    level.b_shield_cool_down = 1;
    _id_0720::play_narration(["zm_cpm5_bfs5_dcmt_biwa", "zm_cpm5_bfs5_dcmt_biwb", "zm_cpm5_bfs5_dcmt_biwc", "zm_cpm5_bfs5_dcmt_biwd", "zm_cpm5_bfs5_dcmt_biwe"]);
    wait 30;
    level.b_shield_cool_down = 0;
  }
}

_id_0204() {
  level endon("game_ended");
  level endon("kortifex_die");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1, var_2, var_3);

    if(isDefined(self._id_F1B3) && var_1.basename != self._id_F1B3) {
      continue;
    }
    var_0 thread check_nearby_kortifex_body();
    wait 0.1;
  }
}

check_nearby_kortifex_body() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    if(isDefined(level.kortifex) && _func_0107(level.kortifex.hitboxes)) {
      foreach(var_1 in level.kortifex.hitboxes) {
        if(isDefined(var_1)) {
          var_2 = distancesquared(var_1.origin, self.origin);

          if(var_2 <= _func_0219(430)) {
            var_3 = vectortoangles(self.origin - var_1.origin);
            playFX(level._effect["monkey_bomb_oob"], self.origin, anglesToForward(var_3), anglestoup(var_3));
            self delete();
          }

          continue;
        }

        break;
      }
    }

    wait 0.1;
  }
}