/*************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\sg_events_v1\keypoint_defense.gsc
*************************************************************/

func_00D5() {
  maps\mp\mp_zombies_attack_object::func_D5();
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register_defaults("type_defense_common", ::basic_defense_run, 120, 1, 1);
  level._zombies_shotgun_obj_keypoint_defense_dmg_structs = initialize_damage_states();
  var_00 = common_scripts\utility::func_46B5("zmb_shotgun_keypoint_defend_point_a", "targetname");
  var_01 = common_scripts\utility::func_46B5("zmb_shotgun_keypoint_defend_point_b", "targetname");
  if(isDefined(var_00) && isDefined(var_01)) {
    foreach(var_03 in [var_00, var_01]) {
      var_03.ondamagetakenfunc = ::uberschnell_pile_update_visuals;
      var_03 initialize_defend_point();
    }
  }
}

basic_defense_run(param_00) {
  if(maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::not_the_final_objective()) {
    level.var_1CC0 = ["zombie_generic"];
  }

  level thread maps\mp\zombies\shotgun\_zombies_shotgun_rideau_global::run_rideau_defense_comment();
  var_01 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_defense_common_zombie_attacker_allow_bombers");
  var_02 = ["zombie_generic"];
  if(var_01) {
    var_02 = ["zombie_generic", "zombie_exploder"];
  }

  var_03 = common_scripts\utility::func_46B5("zmb_shotgun_keypoint_defend_point_a", "targetname");
  var_04 = common_scripts\utility::func_46B5("zmb_shotgun_keypoint_defend_point_b", "targetname");
  var_05 = [var_03, var_04];
  var_06 = common_scripts\utility::func_7A33(var_05);
  level.outro_targetname = var_06.var_1A5 + "_cam";
  var_07 = spawn("script_model", var_06.var_116);
  var_07 setModel("tag_origin");
  var_07.ammo_attack_points = common_scripts\utility::func_46B7(var_06.var_165, "targetname");
  if(isDefined(var_06.var_1D)) {
    var_07.var_1D = var_06.var_1D;
  }

  if(isDefined(var_06.ondamagetakenfunc)) {
    var_07.ondamagetakenfunc = var_06.ondamagetakenfunc;
  }

  var_08 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("defense_common");
  var_08 = var_08 + maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_defense_common_generator_health_buff");
  var_08 = var_08 * maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_defense_common_generator_health_red_skull");
  var_08 = int(var_08);
  var_07.capture_health = var_08;
  var_07.var_FB = var_08;
  level thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::single_ent_health_display_start(var_07, 0, 1);
  var_07 common_scripts\utility::func_3799("obj_destroyed");
  var_09 = spawn("script_model", var_07.var_116);
  var_09 setModel("zmb_uberschnalle_battery_chunk_01");
  if(isDefined(var_07.var_1D)) {
    var_09.var_1D = var_07.var_1D;
  }

  level thread maps\mp\_utility::func_6F74(::showoutlinehelp, [var_09]);
  common_scripts\utility::func_3C8F("zmb_objectives_defense_start");
  var_0A = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_defense_common_zombie_attacker_count");
  var_0B = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("type_defense_common_zombie_attacker_count_max");
  var_0C = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("type_defense_common_zombie_attacker_count_wave");
  var_0A = var_0A + var_0C;
  if(var_0A > var_0B) {
    var_0A = var_0B;
  }

  var_07 thread maps\mp\mp_zombies_attack_object::create_inanimate_zombie_enemy(var_0A, var_08, "obj_destroyed", 99999, 400, ::basic_defense_on_finished, [], var_07.ammo_attack_points, var_02, ["zombie_is_passive", "zombie_is_crawler", "zombie_is_objective", "zombie_is_stunned"]);
  var_07 thread basic_defense_wait_for_destruction();
  var_0D = basic_defense_waitfor_timeout_or_fail();
  level.var_1CC0 = undefined;
  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("mp_zombie_nest_01_tower_battle", int(100 * var_07.capture_health / var_07.var_FB));
  common_scripts\utility::func_3C8F("zmb_objectives_defense_end");
  level thread maps\mp\_utility::func_6F74(::canceloutlinehelp);
  var_09 method_805C();
  if((lib_0547::func_5565(var_0D, "sg_obj_timeout") || lib_0547::func_5565(var_0D, "zombie_wave_ended")) && isDefined(var_07)) {
    var_07.shouldterminate = 1;
  }

  if((lib_0547::func_5565(var_0D, "sg_obj_timeout") && common_scripts\utility::func_562E(level.zmb_sg_objectives[param_00].timeout_win)) || lib_0547::func_5565(var_0D, "zombie_wave_ended")) {
    return 1;
  }

  return 0;
}

initialize_defend_point() {
  set_condition(1);
}

initialize_damage_states() {
  var_00 = [1, 2, 3, 4, 5];
  var_01 = [];
  foreach(var_05, var_03 in var_00) {
    var_04 = spawnStruct();
    switch (var_03) {
      case 1:
        var_04.var_3F02 = ::set_condition_prestine;
        var_04.var_3F2F = undefined;
        break;

      case 2:
        var_04.var_3F02 = ::set_condition_damage_low;
        var_04.var_3F2F = "zmb_battery_defense_dmg_1";
        break;

      case 3:
        var_04.var_3F02 = ::set_condition_damage_med;
        var_04.var_3F2F = "zmb_battery_defense_dmg_2";
        break;

      case 4:
        var_04.var_3F02 = ::set_condition_damage_high;
        var_04.var_3F2F = "zmb_battery_defense_dmg_3";
        break;

      case 5:
        var_04.var_3F02 = ::set_condition_damage_exp;
        var_04.var_3F2F = "zmb_battery_defense_dmg_fail";
        break;
    }

    var_01[var_05] = var_04;
  }

  return var_01;
}

uberschnell_pile_update_visuals() {
  var_00 = self.var_FB * 0.2;
  if(!isDefined(self.nexthealthcheckpoint)) {
    self.healthstate = 0;
    self.nexthealthcheckpoint = self.var_FB - var_00;
  }

  if(self.capture_health < self.nexthealthcheckpoint) {
    self.healthstate++;
    self.nexthealthcheckpoint = self.nexthealthcheckpoint - var_00;
    if(self.nexthealthcheckpoint < var_00) {
      self.nexthealthcheckpoint = 1;
    }

    thread set_condition(self.healthstate);
  }
}

set_condition(param_00) {
  var_01 = level._zombies_shotgun_obj_keypoint_defense_dmg_structs;
  if(param_00 > var_01.size) {
    return;
  }

  if(param_00 == var_01.size) {
    wait(1.3);
    var_02 = lib_0547::func_408F();
    var_02 = common_scripts\utility::func_40B0(self.var_116, var_02);
    foreach(var_05, var_04 in var_02) {
      if(var_05 < 4) {
        var_04 setonfire(0, 10, 1, "none", 1);
      }
    }
  }

  clear_dmg_fx();
  spawn_defense_fx(var_01[param_00 - 1].var_3F2F);
  self[[var_01[param_00 - 1].var_3F02]]();
}

set_condition_prestine() {}

set_condition_damage_low() {}

set_condition_damage_med() {}

set_condition_damage_high() {}

set_condition_damage_exp() {}

basic_defense_on_finished() {}

basic_defense_waitfor_timeout_or_fail(param_00) {
  var_01 = common_scripts\utility::func_A70E(level, "sg_defense_failed", level, "sg_obj_timeout", level, "zombie_wave_ended");
  var_02 = var_01[0];
  var_03 = var_01[1];
  return var_02;
}

basic_defense_wait_for_destruction() {
  level endon("sg_obj_timeout");
  level endon("sg_defense_failed");
  var_00 = self;
  var_00 common_scripts\utility::func_379C("obj_destroyed");
  level notify("sg_defense_failed");
}

spawn_defense_fx(param_00) {
  if(isDefined(param_00)) {
    self.dmgfx = lib_0547::func_8FBA(self, param_00);
    triggerfx(self.dmgfx);
  }
}

clear_dmg_fx() {
  if(isDefined(self.dmgfx)) {
    self.dmgfx delete();
  }
}

basic_defense_skip_cleanup(param_00) {
  level endon("sg_obj_timeout");
  level endon("sg_defense_failed");
  level waittill("skipWave");
  param_00.shouldterminate = 1;
}

showoutlinehelp(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  var_01 endon("helper_canceled");
  var_02 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("type_defense_common_outline_dist");
  for(;;) {
    foreach(var_04 in param_00) {
      if(distance(var_04.var_116, var_01.var_116) > var_02) {
        var_04 showtoclient(var_01);
        var_04 hudoutlineenableforclient(var_01, 2, 0);
        continue;
      }

      var_04 hidefromclient(var_01);
      var_04 hudoutlinedisableforclient(var_01);
    }

    wait(0.5);
  }
}

canceloutlinehelp() {
  var_00 = self;
  var_00 notify("helper_canceled");
}