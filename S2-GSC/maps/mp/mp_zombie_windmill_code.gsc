/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_windmill_code.gsc
***********************************************/

ee_init() {
  ee_init_flags();
  lib_0557::func_786C();
  lib_0557::func_7846("quest_frank", ::lib_0557::func_30D8, [], lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_frank", "step_find_frank", ::ee_quest_step_find_frank, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_frank", "step_find_rope", ::ee_quest_step_find_rope, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_frank", "step_find_rods", ::ee_quest_step_find_rods, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_frank", "step_hang_frank", ::ee_quest_step_hang_frank, ::maps\mp\zombies\shotgun\_zombies_shotgun_exp_events::award_exp_small, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_frank", "step_call_lightning", ::ee_quest_step_call_lightning, ::maps\mp\zombies\shotgun\_zombies_shotgun_exp_events::award_exp_small, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_frank", "step_defend_frank", ::ee_quest_step_defend_frank, ::maps\mp\zombies\shotgun\_zombies_shotgun_exp_events::award_exp_smallish, lib_0557::removed_quest_hint());
  lib_0557::func_781E("quest_frank", "step_escort_frank", ::ee_quest_step_escort_frank, ::windmill_completion_rewards, lib_0557::removed_quest_hint());
  lib_0557::func_7848("quest_frank");
  thread ee_quest_step_find_frank_init();
  thread ee_quest_step_find_rope_init();
  thread ee_quest_step_find_rods_init();
  thread ee_quest_step_hang_frank_init();
  thread ee_quest_step_escort_frank_init();
}

windmill_completion_rewards() {
  maps\mp\zombies\shotgun\_zombies_shotgun_exp_events::award_exp_med();
  common_scripts\utility::func_3C8F("zmb_objectives_quest_end");
  foreach(var_01 in level.var_744A) {
    var_01 lib_056A::func_4772(1);
    var_01 thread maps\mp\gametypes\_hud_message::func_9102("zm_dlc3_ee_1_complete");
    if(function_02A3()) {
      var_01 ae_reportcomplexgameevent(43, [5, 5]);
      var_01 thread maps\mp\gametypes\_hud_message::func_9102("zm_camo_unlocked", 1);
    }
  }
}

ee_init_flags() {
  common_scripts\utility::func_3C87("ee_find_frank_part_head_found");
  common_scripts\utility::func_3C87("ee_find_frank_part_torso_found");
  common_scripts\utility::func_3C87("ee_find_frank_part_left_leg_found");
  common_scripts\utility::func_3C87("ee_find_frank_part_right_leg_found");
  common_scripts\utility::func_3C87("ee_find_frank_part_left_arm_found");
  common_scripts\utility::func_3C87("ee_find_frank_part_right_arm_found");
  common_scripts\utility::func_3C87("ee_find_rope_part_shot");
  common_scripts\utility::func_3C87("ee_find_rope_branch_pull_complete");
  common_scripts\utility::func_3C87("ee_find_rope_part_collected");
  common_scripts\utility::func_3C87("ee_find_rods_rods_found");
  common_scripts\utility::func_3C87("ee_hang_frank_arm_dropped");
  common_scripts\utility::func_3C87("ee_hang_frank_arm_acquired");
  common_scripts\utility::func_3C87("ee_hang_frank_windmill_jammed");
  common_scripts\utility::func_3C87("ee_hang_frank_complete");
  common_scripts\utility::func_3C87("ee_call_lightning_complete");
  common_scripts\utility::func_3C87("ee_call_lightning_frank_fell");
  common_scripts\utility::func_3C87("ee_hang_frank_defend_complete");
  common_scripts\utility::func_3C87("ee_escort_frank_reached_battery");
  common_scripts\utility::func_3C87("ee_escort_frank_soul_collection_complete");
  common_scripts\utility::func_3C87("ee_escort_frank_reached_basement");
  common_scripts\utility::func_3C87("ee_escort_frank_battery_collected");
  common_scripts\utility::func_3C87("ee_escort_hilt_collected");
}

audio_log_init() {
  var_00 = getent("lore_primary", "script_noteworthy");
  var_00.var_9D5E = getent(var_00.var_1A2, "targetname");
  var_00 method_805C();
  var_00.var_9D5E common_scripts\utility::func_9D9F();
  audio_log_listen(var_00);
}

audio_log_listen(param_00) {
  var_01 = getent("audio_log_hanging_model", "targetname");
  var_01 setCanDamage(1);
  var_01 waittill("damage");
  var_02 = param_00.var_116 - var_01.var_116;
  var_03 = sqrt(abs(var_02[2] * 2 / 800));
  var_04 = 1 / var_03;
  var_05 = var_02 * (var_04, var_04, 0);
  var_01 gravitymove(var_05, var_03);
  var_01 rotateto(param_00.var_1D, var_03);
  wait(var_03);
  var_01.var_116 = param_00.var_116;
  var_01 delete();
  param_00 method_805B();
  param_00.var_9D5E common_scripts\utility::func_9DA3();
}

__________________step_find_frank____________________() {}

ee_quest_step_find_frank_init() {
  level.zombie_parts_found = 0;
}

ee_quest_step_find_frank() {
  ee_quest_step_find_frank_parts_think();
  lib_0557::func_782D("quest_frank", "step_find_frank");
}

ee_quest_step_find_frank_parts_think() {
  ee_quest_step_find_frank_part_setup("head");
  ee_quest_step_find_frank_part_setup("torso");
  ee_quest_step_find_frank_part_setup("left_leg");
  ee_quest_step_find_frank_part_setup("right_leg");
  ee_quest_step_find_frank_part_setup("left_arm");
  ee_quest_step_find_frank_part_setup("right_arm");
  var_00 = ["ee_find_frank_part_head_found", "ee_find_frank_part_torso_found", "ee_find_frank_part_left_leg_found", "ee_find_frank_part_right_leg_found", "ee_find_frank_part_left_arm_found", "ee_find_frank_part_right_arm_found"];
  common_scripts\utility::func_3CA1(var_00);
}

ee_quest_step_find_frank_part_setup(param_00) {
  var_01 = common_scripts\utility::func_46B7("frank_" + param_00, "targetname");
  var_02 = common_scripts\utility::func_7A33(var_01);
  var_02 thread ee_quest_step_find_frank_part_think(param_00);
}

ee_quest_step_find_frank_part_think(param_00) {
  var_01 = self;
  if(!isDefined(var_01.showing_part) || !var_01.showing_part) {
    var_01.showing_part = 1;
    var_02 = spawn("script_model", var_01.var_116);
    var_02.var_1D = var_01.var_1D;
    var_02 setModel(ee_quest_step_find_frank_get_modelname_by_partname(param_00));
    var_03 = 0;
    var_04 = 72;
    var_05 = 70;
    while(!var_03) {
      wait 0.05;
      var_06 = level.var_744A;
      foreach(var_08 in var_06) {
        if(distance2d(var_08.var_116, var_02.var_116) > var_04) {
          var_06 = common_scripts\utility::func_F93(var_06, var_08);
        }
      }

      if(var_06.size <= 0) {
        continue;
      }

      foreach(var_08 in var_06) {
        if(!var_08 useButtonPressed()) {
          var_06 = common_scripts\utility::func_F93(var_06, var_08);
        }
      }

      if(var_06.size <= 0) {
        continue;
      }

      foreach(var_08 in var_06) {
        if(!common_scripts\utility::func_AA4A(var_08 getEye(), var_08.var_1D, var_02.var_116, cos(var_05))) {
          var_06 = common_scripts\utility::func_F93(var_06, var_08);
        }
      }

      if(var_06.size <= 0) {
        continue;
      }

      wait(0.2);
      foreach(var_08 in var_06) {
        if(!common_scripts\utility::func_AA4A(var_08 getEye(), var_08.var_1D, var_02.var_116, cos(var_05))) {
          var_06 = common_scripts\utility::func_F93(var_06, var_08);
        }

        if(!var_08 useButtonPressed()) {
          var_06 = common_scripts\utility::func_F93(var_06, var_08);
        }
      }

      if(var_06.size > 0) {
        var_03 = 1;
      }
    }

    var_02 delete();
    level.zombie_parts_found++;
    common_scripts\utility::func_3C8F("ee_find_frank_part_" + param_00 + "_found");
  }
}

ee_quest_step_find_frank_get_modelname_by_partname(param_00) {
  switch (param_00) {
    case "head":
      return "zom_ger_head_fdr_02_gib";

    case "torso":
      return "jfull_zom_infantrya_torso_slice";

    case "left_arm":
      return "jfull_zom_infantrya_l_arm_slice";

    case "right_arm":
      return "jfull_zom_infantrya_r_arm_slice";

    case "left_leg":
      return "jfull_zom_infantrya_l_leg_slice";

    case "right_leg":
      return "jfull_zom_infantrya_r_leg_slice";

    default:
      break;
  }
}

warp_find_frank_complete() {
  common_scripts\utility::func_3C8F("ee_find_frank_part_head_found");
  common_scripts\utility::func_3C8F("ee_find_frank_part_torso_found");
  common_scripts\utility::func_3C8F("ee_find_frank_part_left_leg_found");
  common_scripts\utility::func_3C8F("ee_find_frank_part_right_leg_found");
  common_scripts\utility::func_3C8F("ee_find_frank_part_left_arm_found");
  common_scripts\utility::func_3C8F("ee_find_frank_part_right_arm_found");
  level.zombie_parts_found = 6;
}

cheat_show_all_bodyparts() {
  var_00 = ["head", "torso", "left_leg", "right_leg", "left_arm", "right_arm"];
  foreach(var_02 in var_00) {
    var_03 = common_scripts\utility::func_46B7("frank_" + var_02, "targetname");
    foreach(var_05 in var_03) {
      var_05 thread ee_quest_step_find_frank_part_think(var_02);
    }
  }
}

________________step_find_rope______________________() {}

ee_quest_step_find_rope_init() {
  var_00 = getent("rope_pull_animorg", "targetname");
  var_01 = getent("rope_fall", "targetname");
  var_01 method_8278("zmb_windmill_rope_hanging");
  var_00 method_8278("zmb_windmill_branch_start");
  thread ee_quest_step_find_rope_waitfor_rope_shot();
  common_scripts\utility::func_3C9F("ee_find_rope_part_shot");
  if(!common_scripts\utility::func_3C77("ee_find_rope_part_collected")) {
    level waittill("round complete");
    level waittill("zombie_wave_started");
    thread ee_quest_step_find_rope_waitfor_rope_recovered();
    common_scripts\utility::func_3C9F("ee_find_rope_part_collected");
  }

  ee_quest_step_find_rope_cleanup();
}

ee_quest_step_find_rope() {
  common_scripts\utility::func_3C9F("ee_find_rope_part_collected");
  lib_0557::func_782D("quest_frank", "step_find_rope");
}

ee_quest_step_find_rope_waitfor_rope_shot() {
  level endon("ee_find_rope_part_shot");
  var_00 = getent("rope_bundle_damage_trig", "targetname");
  var_00 method_80B0(var_00 method_85A0() | 256);
  var_00 waittill("damage");
  var_01 = getent("rope_fall", "targetname");
  var_01 method_8278("zmb_windmill_rope_fall");
  var_00 lib_0378::func_8D74("frank_rope_shot");
  wait(getanimlength(%zmb_windmill_rope_fall));
  var_01 scriptmodelclearanim();
  var_01 delete();
  common_scripts\utility::func_3C8F("ee_find_rope_part_shot");
}

ee_quest_step_find_rope_waitfor_rope_recovered() {
  level endon("ee_find_rope_part_collected");
  var_00 = getent("rope_pull_animorg", "targetname");
  var_01 = getent("branch_pull_trigger", "targetname");
  var_02 = getent("rope_collect_trigger", "targetname");
  var_03 = 0;
  var_04 = 0;
  var_00 scriptmodelclearanim();
  var_00 method_8278("zmb_windmill_rope_trav");
  wait(getanimlength(%zmb_windmill_rope_trav));
  var_00 scriptmodelclearanim();
  var_00 method_8278("zmb_windmill_rope_water_loop");
  while(!common_scripts\utility::func_3C77("ee_find_rope_branch_pull_complete")) {
    while(!ee_quest_step_find_rope_return_branch_pulled(var_01) && !common_scripts\utility::func_3C77("ee_find_rope_branch_pull_complete")) {
      wait 0.05;
    }

    if(!var_03) {
      var_00 method_8278("zmb_windmill_rope_recover");
      var_03 = 1;
      var_00 lib_0378::func_8D74("frank_pull_branch", "pulling");
    } else {
      var_00 scriptmodelpauseanim(0);
      var_00 lib_0378::func_8D74("frank_pull_branch", "pulling");
    }

    var_05 = gettime();
    while(ee_quest_step_find_rope_return_branch_pulled(var_01) && !common_scripts\utility::func_3C77("ee_find_rope_branch_pull_complete")) {
      wait 0.05;
      var_04 = var_04 + gettime() - var_05;
      var_05 = gettime();
      if(var_04 >= getanimlength(%zmb_windmill_rope_recover) * 1000 - 100) {
        common_scripts\utility::func_3C8F("ee_find_rope_branch_pull_complete");
        var_00 lib_0378::func_8D74("frank_pull_branch", "end");
        break;
      }
    }

    var_00 scriptmodelpauseanim(1);
    var_00 lib_0378::func_8D74("frank_pull_branch", "stopped");
  }

  var_02 waittill("trigger");
  var_00 method_8495("zmb_windmill_branch_end", var_00.var_116, var_00.var_1D);
  var_00 hidepart("rope");
  var_00 hidepart("bit_T");
  var_00 hidepart("bit_B");
  var_06 = 21;
  for(var_07 = 1; var_07 <= var_06; var_07++) {
    var_00 hidepart("dangle_0" + var_07);
  }

  common_scripts\utility::func_3C8F("ee_find_rope_part_collected");
}

ee_quest_step_find_rope_return_branch_pulled(param_00) {
  var_01 = level.var_744A;
  var_02 = param_00;
  var_03 = 0;
  foreach(var_05 in var_01) {
    if(var_05 istouching(var_02)) {
      if(var_05 useButtonPressed()) {
        var_03 = 1;
      }
    }
  }

  return var_03;
}

ee_quest_step_find_rope_cleanup() {}

warp_rope_shot() {
  common_scripts\utility::func_3C8F("ee_find_rope_part_shot");
}

warp_rope_recovered() {
  warp_find_frank_complete();
  common_scripts\utility::func_3C8F("ee_find_rope_part_shot");
  common_scripts\utility::func_3C8F("ee_find_rope_branch_pull_complete");
  common_scripts\utility::func_3C8F("ee_find_rope_part_collected");
}

________________step_find_rods_______________________() {}

ee_quest_step_find_rods_init() {
  maps\mp\zombies\shotgun\_zombies_shotgun_drop_pod::func_D5();
  level.drop_pod_rods = getEntArray("drop_pod_rod", "targetname");
  foreach(var_01 in level.drop_pod_rods) {
    var_01 method_805C();
  }

  level.num_rods_to_find = level.drop_pod_rods.size;
  level.num_rods_found = 0;
}

ee_quest_step_find_rods() {
  level waittill("round complete");
  level waittill("zombie_wave_started");
  wait(5);
  ee_quest_step_find_rods_spawn_pod_and_rods();
  common_scripts\utility::func_3C9F("ee_find_rods_rods_found");
  lib_0557::func_782D("quest_frank", "step_find_rods");
}

ee_quest_step_find_rods_spawn_pod_and_rods() {
  level endon("ee_find_rods_rods_found");
  var_00 = common_scripts\utility::func_46B5("drop_pod_position", "targetname");
  thread maps\mp\zombies\shotgun\_zombies_shotgun_drop_pod::drop_pod_spawn_drop();
  if(!common_scripts\utility::func_3C77("ee_find_rods_rods_found")) {
    while(!isDefined(var_00.spawned_model)) {
      wait 0.05;
    }

    foreach(var_02 in level.drop_pod_rods) {
      var_03 = var_00.spawned_model.var_116 - var_00.pod_model.var_116;
      var_02.var_116 = var_02.var_116 + var_03;
      var_02 method_8449(var_00.spawned_model);
      var_02 common_scripts\utility::func_2CBE(0.05, ::method_805B);
    }

    while(isDefined(var_00.clip_fall)) {
      wait 0.05;
    }

    var_05 = common_scripts\utility::func_46B7("drop_pod_rod_target_loc", "targetname");
    for(var_06 = 0; var_06 < level.drop_pod_rods.size; var_06++) {
      thread ee_quest_step_find_rods_throw_rod(level.drop_pod_rods[var_06], var_05[var_06]);
      thread ee_quest_step_find_rods_use_rod(level.drop_pod_rods[var_06]);
    }
  }
}

ee_quest_step_find_rods_throw_rod(param_00, param_01) {
  level endon("ee_find_rods_rods_found");
  param_00 unlink();
  var_02 = 0.25;
  param_00 moveto(param_01.var_116, var_02);
  param_00 rotateto(param_01.var_1D, var_02);
  wait(var_02);
  param_00.var_116 = param_01.var_116;
}

ee_quest_step_find_rods_use_rod(param_00) {
  level endon("ee_find_rods_rods_found");
  wait(2);
  param_00 lib_0547::func_AC41(" ");
  param_00 waittill("player_used", var_01);
  param_00 delete();
  level.num_rods_found++;
  if(level.num_rods_found >= level.num_rods_to_find) {
    common_scripts\utility::func_3C8F("ee_find_rods_rods_found");
  }
}

warp_rods_found() {
  warp_rope_recovered();
  common_scripts\utility::func_3C8F("ee_find_rods_rods_found");
  level.num_rods_found = level.num_rods_to_find;
}

________________step_hang_frank______________________() {}

ee_quest_step_hang_frank_init() {
  level.total_parts_placed = 0;
  level.required_fan_org_angle = 90;
  thread ee_quest_step_hang_frank_place_parts_think();
  thread ee_quest_step_hang_frank_acquire_wustling_arm();
  thread ee_quest_step_hang_frank_jam_windmill();
}

ee_quest_step_hang_frank() {
  common_scripts\utility::func_3C9F("ee_hang_frank_complete");
  ee_quest_step_hang_frank_cleanup();
  lib_0557::func_782D("quest_frank", "step_hang_frank");
}

ee_quest_step_hang_frank_acquire_wustling_arm() {
  level endon("ee_hang_frank_complete");
  wait(10);
  level.var_A41["zombie_heavy"]["post_model"] = ::ee_quest_step_hang_frank_acquire_wustling_arm_spawn_func;
  var_00 = lib_0547::func_4090("zombie_heavy");
  foreach(var_02 in var_00) {
    var_02 thread ee_quest_step_hang_frank_acquire_wustling_arm_spawn_func();
  }

  common_scripts\utility::func_3C9F("ee_hang_frank_arm_dropped");
  level.var_A41["zombie_heavy"]["post_model"] = ::lib_054D::func_AC1E;
  common_scripts\utility::func_3C9F("ee_hang_frank_arm_acquired");
}

ee_quest_step_hang_frank_acquire_wustling_arm_spawn_func() {
  self notify("running_arm_sever_spawn_func");
  self endon("running_arm_sever_spawn_func");
  self endon("death");
  level endon("ee_hang_frank_arm_dropped");
  while(isDefined(self)) {
    var_00 = lib_0547::func_4090("zombie_heavy");
    if(var_00.size > 1) {
      var_00 = common_scripts\utility::func_F93(var_00, self);
      foreach(var_02 in var_00) {
        if(distance(var_02.var_116, self.var_116) <= 64 && isDefined(var_02.var_5542) && var_02.var_5542 == 1) {
          var_03 = 36;
          if(isDefined(var_02.var_28D2)) {
            var_04 = distance(self.var_116, var_02.var_28D2.var_116);
            var_05 = distance(var_02.var_116, var_02.var_28D2.var_116) - var_03;
            if(var_04 <= var_05) {
              thread ee_quest_step_hang_frank_acquire_wustling_arm_drop_arm(self.var_116 - var_02.var_116);
              return;
            }
          }
        }
      }

      wait 0.05;
      continue;
    }

    wait 0.05;
  }
}

ee_quest_step_hang_frank_acquire_wustling_arm_drop_arm(param_00) {
  var_01 = self;
  wait(1.25);
  var_02 = var_01.var_116;
  lib_0547::func_5A85(self.var_116, param_00);
  var_02 = common_scripts\utility::func_348B(var_02, 32);
  var_03 = spawn("script_model", var_02 + (0, 0, 4));
  var_03 setModel("zmw_wustling_arm_01");
  var_03 hudoutlineenableforclients(level.var_744A, 2, 1);
  common_scripts\utility::func_3C8F("ee_hang_frank_arm_dropped");
  var_03 lib_0547::func_AC41(" ");
  var_03 waittill("player_used");
  var_03 hudoutlinedisableforclients(level.var_744A);
  var_03 delete();
  common_scripts\utility::func_3C8F("ee_hang_frank_arm_acquired");
}

ee_quest_step_hang_frank_jam_windmill() {
  var_00 = getent("windmill_jam_trigger", "targetname");
  var_01 = getent("wustling_arm_jam_model", "targetname");
  var_02 = getent("wustling_arm_jam_model_start", "targetname");
  var_03 = getent("wustling_arm_jam_model_end", "targetname");
  var_01.var_116 = var_02.var_116;
  var_01.var_1D = var_02.var_1D;
  var_01 method_805C();
  common_scripts\utility::func_3C9F("ee_hang_frank_arm_acquired");
  for(;;) {
    var_00 waittill("trigger");
    level thread common_scripts\_exploder::func_88E(204);
    var_01 lib_0378::func_8D74("wustling_arm_jam");
    maps\mp\mp_zombie_windmill_util::windmill_stop_idle();
    var_01 method_805B();
    var_01 moveto(var_03.var_116, 0.5, 0, 0.05);
    var_01 rotateto(var_03.var_1D, 0.5, 0, 0.05);
    level waittill("done_accelerating");
    iprintlnbold("JAMMED");
    common_scripts\utility::func_3C8F("ee_hang_frank_windmill_jammed");
    var_00 waittill("trigger");
    maps\mp\mp_zombie_windmill_util::windmill_idle_with_speed(1);
    var_01 method_805C();
    var_01.var_116 = var_02.var_116;
    var_01.var_1D = var_02.var_1D;
    level waittill("done_accelerating");
    iprintlnbold("UN-JAMMED");
    common_scripts\utility::func_3C7B("ee_hang_frank_windmill_jammed");
    wait(1);
  }
}

ee_quest_step_hang_frank_place_parts_think() {
  level endon("ee_hang_frank_complete");
  var_00 = 0;
  var_01 = 0;
  var_02 = getent("windmill_place_part_trig", "targetname");
  var_03 = getent("windmill_fan", "targetname");
  var_04 = getent("frank_fanblade_models_org", "targetname");
  var_05 = getEntArray("frank_fanblade_models", "script_noteworthy");
  foreach(var_07 in var_05) {
    var_07 method_8449(var_04);
    var_07 method_805C();
  }

  var_04 method_8449(var_03);
  common_scripts\utility::func_3C9F("ee_hang_frank_arm_acquired");
  while(var_00 < 6 || var_01 < level.drop_pod_rods.size) {
    common_scripts\utility::func_3C9F("ee_hang_frank_windmill_jammed");
    var_09 = abs(var_03.var_1D[0] % 90);
    var_0A = 5;
    if(ee_quest_step_hang_frank_check_if_fan_rot_correct(var_03)) {
      while(var_00 < 6 || var_01 < level.drop_pod_rods.size) {
        var_02 waittill("trigger");
        if(!common_scripts\utility::func_3C77("ee_hang_frank_windmill_jammed")) {
          break;
        } else {
          var_0B = ee_quest_step_hang_frank_check_if_fan_rot_correct(var_03);
          if(!var_0B) {
            break;
          }
        }

        if(!common_scripts\utility::func_3C77("ee_find_rope_part_collected")) {
          continue;
        }

        ee_quest_step_hang_frank_place_acquired_parts();
        var_00 = level.zombie_parts_found;
        var_01 = level.num_rods_found;
        level.total_parts_placed = var_00 + var_01;
      }

      continue;
    }

    while(common_scripts\utility::func_3C77("ee_hang_frank_windmill_jammed")) {
      wait 0.05;
    }

    wait 0.05;
  }

  common_scripts\utility::func_3C8F("ee_hang_frank_complete");
}

ee_quest_step_hang_frank_place_acquired_parts() {
  var_00 = level.zombie_parts_found + level.num_rods_found;
  if(var_00 <= level.total_parts_placed) {
    return;
  }

  if(level.num_rods_found >= 2) {
    ee_quest_step_hang_frank_show_part_with_targetname("frank_hang_rod01");
    ee_quest_step_hang_frank_show_part_with_targetname("frank_hang_rod02");
  } else if(level.num_rods_found == 1) {
    ee_quest_step_hang_frank_show_part_with_targetname("frank_hang_rod01");
  }

  if(common_scripts\utility::func_3C77("ee_find_frank_part_head_found")) {
    ee_quest_step_hang_frank_show_part_with_targetname("frank_hang_head");
  }

  if(common_scripts\utility::func_3C77("ee_find_frank_part_torso_found")) {
    ee_quest_step_hang_frank_show_part_with_targetname("frank_hang_torso");
  }

  if(common_scripts\utility::func_3C77("ee_find_frank_part_left_leg_found")) {
    ee_quest_step_hang_frank_show_part_with_targetname("frank_hang_ll");
  }

  if(common_scripts\utility::func_3C77("ee_find_frank_part_right_leg_found")) {
    ee_quest_step_hang_frank_show_part_with_targetname("frank_hang_rl");
  }

  if(common_scripts\utility::func_3C77("ee_find_frank_part_left_arm_found")) {
    ee_quest_step_hang_frank_show_part_with_targetname("frank_hang_la");
  }

  if(common_scripts\utility::func_3C77("ee_find_frank_part_right_arm_found")) {
    ee_quest_step_hang_frank_show_part_with_targetname("frank_hang_ra");
  }
}

ee_quest_step_hang_frank_show_part_with_targetname(param_00) {
  var_01 = getent(param_00, "targetname");
  var_02 = getEntArray(var_01.var_1A2, "targetname");
  var_01 method_805B();
  foreach(var_04 in var_02) {
    var_04 method_805B();
  }
}

ee_quest_step_hang_frank_delete_part_with_targetname(param_00) {
  var_01 = getent(param_00, "targetname");
  if(!isDefined(var_01)) {
    return;
  }

  var_02 = getEntArray(var_01.var_1A2, "targetname");
  if(var_02.size > 0) {
    foreach(var_04 in var_02) {
      var_04 unlink();
      var_04 delete();
    }
  }

  if(isDefined(var_01)) {
    var_01 unlink();
    var_01 delete();
  }
}

ee_quest_step_hang_frank_check_if_fan_rot_correct(param_00) {
  var_01 = abs(param_00.var_1D[0] % 90);
  var_02 = 5;
  if(var_01 < var_02 || var_01 > 90 - var_02) {
    if(isDefined(level.required_fan_org_angle)) {
      if(abs(level.required_fan_org_angle - param_00.var_1D[0]) < var_02) {
        return 1;
      }

      return 0;
    }

    return 1;
  }

  return 0;
}

ee_quest_step_hang_frank_cleanup() {}

warp_hang_frank() {
  warp_rods_found();
  common_scripts\utility::func_3C8F("ee_hang_frank_arm_dropped");
  common_scripts\utility::func_3C8F("ee_hang_frank_arm_acquired");
  common_scripts\utility::func_3C8F("ee_hang_frank_complete");
  ee_quest_step_hang_frank_place_acquired_parts();
  var_00 = getent("windmill_fan", "targetname");
  var_00.current_speed = 0;
  wait(1);
  var_00.var_1D = (270, var_00.var_1D[1], var_00.var_1D[2]);
  wait(2);
}

cheat_give_wustling_arm() {
  common_scripts\utility::func_3C8F("ee_hang_frank_arm_dropped");
  common_scripts\utility::func_3C8F("ee_hang_frank_arm_acquired");
}

___________step_call_lightning__________() {}

ee_quest_step_call_lightning_init() {}

ee_quest_step_call_lightning() {
  thread ee_quest_step_call_lightning_think();
  common_scripts\utility::func_3C9F("ee_call_lightning_complete");
  thread ee_quest_step_call_lightning_do_strike();
  lib_0557::func_782D("quest_frank", "step_call_lightning");
}

ee_quest_step_call_lightning_think() {
  level endon("ee_call_lightning_complete");
  if(!common_scripts\utility::func_3C77("ee_call_lightning_complete")) {
    var_00 = getent("windmill_fan", "targetname");
    level.windmill_charged = 0;
    while(!level.windmill_charged) {
      ee_quest_step_call_lightning_monitor_progress_for_round(var_00);
      if(var_00.var_1D[0] != 270 || var_00.current_speed != 0) {
        level.windmill_charged = 0;
        wait(10);
      }

      wait 0.05;
    }

    wait(5);
    common_scripts\utility::func_3C8F("ee_call_lightning_complete");
  }
}

ee_quest_step_call_lightning_monitor_progress_for_round(param_00) {
  level endon("round complete");
  for(;;) {
    if(param_00.var_1D[0] == 270 && param_00.current_speed == 0) {
      level.windmill_charged = 1;
    } else {
      level.windmill_charged = 0;
    }

    wait 0.05;
  }
}

ee_quest_step_call_lightning_do_strike() {
  common_scripts\utility::func_3C9F("ee_call_lightning_complete");
  var_00 = getent("frank_fanblade_models_org", "targetname");
  maps\mp\zombies\sg_events_v1\extermination::func_5D67(var_00.var_116 - (0, 0, 40));
  level thread common_scripts\_exploder::func_88E(202);
  wait(randomfloatrange(0.05, 0.07));
  maps\mp\zombies\sg_events_v1\extermination::func_5D67(var_00.var_116 - (0, 0, 40));
  wait(randomfloatrange(0.05, 0.07));
  thread maps\mp\zombies\sg_events_v1\extermination::func_5D67(var_00.var_116 - (0, 0, 40));
  lib_0378::func_8D74("call_lightning_do_strike", var_00.var_116 - (0, 0, 40));
  ee_quest_step_hang_frank_delete_part_with_targetname("frank_hang_head");
  ee_quest_step_hang_frank_delete_part_with_targetname("frank_hang_torso");
  ee_quest_step_hang_frank_delete_part_with_targetname("frank_hang_ll");
  ee_quest_step_hang_frank_delete_part_with_targetname("frank_hang_rl");
  ee_quest_step_hang_frank_delete_part_with_targetname("frank_hang_la");
  ee_quest_step_hang_frank_delete_part_with_targetname("frank_hang_ra");
  ee_quest_step_call_lightning_frank_fall();
}

ee_quest_step_call_lightning_frank_fall() {
  level.frank_escort_health = 100;
  maps\mp\mp_zombie_windmill_util::spawn_frank();
  level.frank_dudebroman method_805C();
  var_00 = getent("frank_fall_animorg", "targetname");
  level.frank_dudebroman setorigin(var_00.var_116 - (0, 0, 20), 0);
  level.frank_dudebroman.var_1D = var_00.var_1D - (0, 90, 0);
  wait 0.05;
  var_01 = "s2_zom_frank_lightning_fall";
  level.frank_dudebroman scragentsetscripted(1);
  level.frank_dudebroman maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "ScriptedAnimation");
  level.frank_dudebroman method_839C("anim deltas");
  level.frank_dudebroman scragentsetorientmode("face angle abs", var_00.var_1D - (0, 90, 0));
  level.frank_dudebroman method_839D("noclip");
  level.frank_dudebroman common_scripts\utility::func_2CBE(0.05, ::method_805B);
  lib_0378::func_8D74("call_lightning_frank_fall", level.frank_dudebroman);
  level.frank_dudebroman maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_01, 0, 1, "scripted_anim");
  level.frank_dudebroman maps\mp\agents\_scripted_agent_anim_util::func_8732(0, "ScriptedAnimation");
  level.frank_dudebroman scragentsetscripted(0);
  level.frank_dudebroman method_839D("gravity");
  wait 0.05;
  var_00 = getent("frank_fall_animorg", "targetname");
  level.frank_dudebroman scragentsetscripted(1);
  level.frank_dudebroman maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "ScriptedAnimation");
  level.frank_dudebroman method_839C("anim deltas");
  level.frank_dudebroman scragentsetorientmode("face angle abs", var_00.var_1D);
  level.frank_dudebroman method_839D("noclip");
  var_01 = "s2_zom_frank_lightning_lay_loop";
  level.frank_dudebroman thread maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_01, 0, 1, "frank_getup");
  common_scripts\utility::func_3C8F("ee_call_lightning_frank_fell");
}

warp_call_lightning() {
  warp_hang_frank();
  common_scripts\utility::func_3C8F("ee_call_lightning_complete");
}

_____________step_defend_frank____________() {}

ee_quest_step_defend_frank_init() {}

ee_quest_step_defend_frank() {
  level waittill("zombie_wave_started");
  ee_quest_step_defend_frank_think();
  if(isDefined(level.defend_tag_org)) {
    level.var_8E3 = common_scripts\utility::func_F93(level.var_8E3, level.defend_tag_org);
    level.defend_tag_org delete();
  }

  common_scripts\utility::func_3C8F("ee_hang_frank_defend_complete");
  lib_0557::func_782D("quest_frank", "step_defend_frank");
}

ee_quest_step_defend_frank_think() {
  level endon("round complete");
  level endon("ee_hang_frank_defend_complete");
  while(!isDefined(level.frank_dudebroman)) {
    wait 0.05;
  }

  common_scripts\utility::func_3C9F("ee_call_lightning_frank_fell");
  if(!common_scripts\utility::func_3C77("ee_hang_frank_defend_complete")) {
    level.frank_escort_health = 100;
    level.defend_tag_org = spawn("script_model", level.frank_dudebroman gettagorigin("J_SpineLower"));
    level.defend_tag_org setModel("tag_origin");
    level.defend_tag_org thread maps\mp\mp_zombies_soul_collection::func_170B(999, 256, 512, "soul_collected_for_frank", undefined, "tag_origin", undefined, "tag_origin");
    var_00 = 250;
    var_01 = 1;
    for(;;) {
      level waittill("soul_collected_for_frank", var_02, var_03);
      if(isDefined(var_03)) {
        switch (var_03) {
          case "zombie_generic":
            level.frank_escort_health = level.frank_escort_health + 6 * var_01;
            break;

          case "zombie_berserker":
            level.frank_escort_health = level.frank_escort_health + 6 * var_01;
            break;

          case "zombie_exploder":
            level.frank_escort_health = level.frank_escort_health + 12 * var_01;
            break;

          case "zombie_heavy":
            level.frank_escort_health = level.frank_escort_health + 30 * var_01;
            break;

          case "zombie_sizzler":
            level.frank_escort_health = level.frank_escort_health + 12 * var_01;
            break;

          case "zombie_assassin":
            level.frank_escort_health = level.frank_escort_health + 100 * var_01;
            break;

          case "zombie_fireman":
            level.frank_escort_health = level.frank_escort_health + 200 * var_01;
            break;

          default:
            level.frank_escort_health = level.frank_escort_health + 10;
            break;
        }

        continue;
      }

      level.frank_escort_health = level.frank_escort_health + 10;
    }
  }
}

warp_defend_frank() {
  warp_call_lightning();
  level.frank_escort_health = 1000;
}

_____________step_escort_frank____________() {}

ee_quest_step_escort_frank_init() {
  var_00 = getent("escort_battery", "targetname");
  var_00 method_805C();
  var_01 = getent("wine_cellar_batt", "targetname");
  var_01 method_805C();
}

ee_quest_step_escort_frank() {
  level waittill("zombie_wave_started");
  wait(3);
  ee_quest_step_escort_frank_wake_up_anim();
  if(!common_scripts\utility::func_3C77("ee_escort_frank_reached_battery")) {
    var_00 = 0;
    var_00 = ee_quest_step_escort_frank_move_to_battery_destination();
    if((!isDefined(var_00) || !var_00) && !common_scripts\utility::func_3C77("ee_escort_frank_reached_battery")) {
      return;
    } else {
      common_scripts\utility::func_3C8F("ee_escort_frank_reached_battery");
    }

    level waittill("round complete");
    var_01 = 0;
    if(level.var_A980 % 3 == 0) {
      var_01 = var_01 + 24;
    } else {
      var_01 = 14;
    }

    wait(var_01);
    level.frank_dudebroman.var_480F = 0;
    level.frank_dudebroman.var_CE = 0;
  }

  if(!common_scripts\utility::func_3C77("ee_escort_frank_reached_basement")) {
    var_00 = 0;
    var_00 = ee_quest_step_escort_frank_move_to_door_destination();
  }

  if(common_scripts\utility::func_3C77("ee_escort_frank_soul_collection_complete")) {
    var_00 = 1;
  } else {
    var_00 = 0;
  }

  if(isDefined(var_00) && var_00) {
    common_scripts\utility::func_3C8F("ee_escort_frank_reached_basement");
    ee_quest_step_escort_frank_drop_charged_battery();
    ee_quest_step_escort_frank_collect_prize_think();
    lib_0557::func_782D("quest_frank", "step_escort_frank");
    return;
  }

  if(common_scripts\utility::func_3C77("ee_escort_frank_soul_collection_complete")) {
    killfxontag(level.var_611["battery_glow_finished"], level.frank_battery.fx_tag, "tag_origin");
  } else {
    killfxontag(level.var_611["battery_glow"], level.frank_battery.fx_tag, "tag_origin");
    playFX(level.var_611["dlc_zmb_dig_02_uber_explode"], level.frank_battery.fx_tag.var_116);
  }

  level.frank_battery.fx_tag delete();
  level.frank_battery delete();
}

ee_quest_step_escort_frank_wake_up_anim() {
  level notify("frank_getup");
  common_scripts\utility::func_3C9F("ee_call_lightning_frank_fell");
  if(isDefined(level.frank_dudebroman) && isalive(level.frank_dudebroman)) {
    level.frank_dudebroman endon("death");
    level.frank_dudebroman maps\mp\agents\_scripted_agent_anim_util::func_8732(0, "ScriptedAnimation");
    level.frank_dudebroman scragentsetscripted(0);
    level.frank_dudebroman method_839D("gravity");
    wait 0.05;
    var_00 = getent("frank_fall_animorg", "targetname");
    level.frank_dudebroman scragentsetscripted(1);
    level.frank_dudebroman maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "ScriptedAnimation");
    level.frank_dudebroman method_839C("anim deltas");
    level.frank_dudebroman scragentsetorientmode("face angle abs", var_00.var_1D - (0, 90, 0));
    level.frank_dudebroman method_839D("noclip");
    var_01 = "s2_zom_frank_lightning_getup";
    level.frank_dudebroman maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_01, 0, 1, "scripted_anim");
    level.frank_dudebroman.var_480F = 0;
    level.frank_dudebroman.var_CE = 0;
    level.frank_dudebroman maps\mp\agents\_agent_common::func_83FD(level.frank_escort_health);
    level.frank_dudebroman maps\mp\agents\_scripted_agent_anim_util::func_8732(0, "ScriptedAnimation");
    level.frank_dudebroman scragentsetscripted(0);
    level.frank_dudebroman method_839D("gravity");
  }
}

ee_quest_step_escort_frank_move_to_battery_destination() {
  level endon("ee_escort_frank_reached_battery");
  level.frank_dudebroman endon("death");
  for(var_00 = 0; var_00 < level.frank_dudebroman.waypoints.size; var_00++) {
    level.frank_dudebroman.var_1928 = level.frank_dudebroman.waypoints[var_00];
    while(distance(level.frank_dudebroman.var_116, level.frank_dudebroman.waypoints[var_00].var_116) > 48) {
      wait 0.05;
    }

    if(isDefined(level.frank_dudebroman.waypoints[var_00].var_165)) {
      var_01 = level.frank_dudebroman.waypoints[var_00].var_165;
      if(var_01 == "frank_start_godon_node") {
        level.frank_dudebroman.var_480F = 1;
        level.frank_dudebroman.var_CE = 1;
      }
    }
  }

  return 1;
}

ee_quest_step_escort_frank_unset_goal() {
  level.frank_dudebroman.var_1928 = undefined;
}

ee_quest_step_escort_frank_move_to_door_destination() {
  level.frank_dudebroman endon("death");
  level endon("ee_escort_frank_reached_basement");
  level.battery_drop_org = level.frank_dudebroman.var_116;
  ee_quest_step_escort_frank_battery_setup();
  thread ee_quest_step_escort_frank_soul_collection();
  var_00 = common_scripts\utility::func_46B5("frank_second_path_start", "targetname");
  level.frank_dudebroman.waypoints = var_00 maps\mp\zombies\sg_events_v1\very_important_zombie::basic_vip_get_waypoints(level.frank_dudebroman);
  for(var_01 = 0; var_01 < level.frank_dudebroman.waypoints.size; var_01++) {
    level.frank_dudebroman.var_1928 = level.frank_dudebroman.waypoints[var_01];
    while(distance(level.frank_dudebroman.var_116, level.frank_dudebroman.waypoints[var_01].var_116) > 48) {
      level.battery_drop_org = level.frank_dudebroman.var_116;
      wait 0.05;
    }
  }

  if(isDefined(level.frank_dudebroman)) {
    level.frank_dudebroman common_scripts\utility::func_2CBE(0.05, ::dodamage, level.frank_dudebroman.var_BC * 2, level.frank_dudebroman.var_116);
  }

  return 1;
}

ee_quest_step_escort_frank_battery_setup() {
  if(!isDefined(level.frank_battery) || !isDefined(level.frank_battery.fx_tag)) {
    level.frank_battery = getent("escort_battery", "targetname");
    level.frank_battery method_805B();
    level.frank_battery.fx_tag = spawn("script_model", level.frank_battery.var_116);
    level.frank_battery.fx_tag setModel("tag_origin");
    level.frank_battery.fx_tag method_8449(level.frank_battery, "tag_origin");
    playFXOnTag(level.var_611["battery_glow"], level.frank_battery.fx_tag, "tag_origin");
    level.frank_battery.var_116 = level.frank_dudebroman gettagorigin("J_Wrist_LE");
    level.frank_battery.var_1D = level.frank_dudebroman gettagangles("J_Wrist_LE");
    level.frank_battery.var_116 = level.frank_battery.var_116 - anglestoup(level.frank_battery.var_1D) * 2;
    level.frank_battery.var_116 = level.frank_battery.var_116 + anglesToForward(level.frank_battery.var_1D) * 3;
    level.frank_battery.var_116 = level.frank_battery.var_116 - anglestoright(level.frank_battery.var_1D) * 3;
    level.frank_battery method_8449(level.frank_dudebroman, "J_Wrist_LE");
  }
}

ee_quest_step_escort_frank_soul_collection() {
  level.frank_dudebroman endon("death");
  level.frank_battery.fx_tag endon("death");
  var_00 = 30;
  level.frank_battery.fx_tag maps\mp\mp_zombies_soul_collection::func_170B(var_00, 256, 64, "battery_soul_collected", undefined, "tag_origin", undefined, "tag_origin", undefined, undefined, (0, 0, 64), undefined, undefined, undefined, 0);
  killfxontag(level.var_611["battery_glow"], level.frank_battery.fx_tag, "tag_origin");
  playFXOnTag(level.var_611["battery_glow_finished"], level.frank_battery.fx_tag, "tag_origin");
  common_scripts\utility::func_3C8F("ee_escort_frank_soul_collection_complete");
}

ee_quest_step_escort_frank_drop_charged_battery() {
  var_00 = level.battery_drop_org;
  if(isDefined(level.frank_dudebroman) && isalive(level.frank_dudebroman)) {
    level.frank_dudebroman.var_480F = 0;
    level.frank_dudebroman dodamage(level.frank_dudebroman.var_BC * 2, level.frank_dudebroman.var_116);
  }

  level.frank_battery unlink();
  var_00 = common_scripts\utility::func_348B(var_00, 32) + (0, 0, 2);
  var_01 = var_00 - level.frank_battery.var_116;
  var_02 = sqrt(abs(var_01[2] * 2 / 800));
  var_03 = 1 / var_02;
  var_04 = var_01 * (var_03, var_03, 0);
  level.frank_battery gravitymove(var_04, var_02);
  level.frank_battery rotateto((0, 0, 0), var_02);
  wait(var_02);
  level.frank_battery.var_116 = var_00;
  level.var_8E3 = common_scripts\utility::func_F93(level.var_8E3, level.frank_battery.fx_tag);
  level.frank_battery.fx_tag delete();
  level.frank_battery hudoutlineenableforclients(level.var_744A, 2, 1);
  level.frank_battery lib_0547::func_AC41(" ");
  level.frank_battery waittill("player_used");
  level.frank_battery hudoutlinedisableforclients(level.var_744A);
  level.frank_battery delete();
  common_scripts\utility::func_3C8F("ee_escort_frank_battery_collected");
}

ee_quest_step_escort_frank_collect_prize_think() {
  var_00 = getent("wine_cellar_batt_trig", "targetname");
  var_01 = getent("wine_cellar_batt", "targetname");
  var_02 = getent("wine_cellar_door_clip", "targetname");
  var_03 = getent("wine_cellar_door", "targetname");
  var_02 method_8449(var_03);
  var_00 waittill("trigger", var_04);
  level thread maps\mp\zombies\weapons\_zombie_dlc3_melee::sword_post_ee_complete_handler();
  var_01 method_805B();
  level thread common_scripts\_exploder::func_88E(205);
  var_00 delete();
  var_03 rotateby((0, -120, 0), 1, 0.25, 0.25);
  var_02 method_8060();
  lib_0378::func_8D74("wine_cellar_door_open", var_03.var_116);
  var_05 = getent("sword_hilt", "targetname");
  var_05 lib_0547::func_AC41(&"ZOMBIE_DLC3_PICKUP_PART_1");
  var_05 waittill("player_used", var_04);
  var_05 lib_0547::func_AC40();
  var_05 delete();
  common_scripts\utility::func_3C8F("ee_escort_hilt_collected");
  level.shattered_ee_complete = 1;
}

warp_skip_escort_part01() {
  warp_defend_frank();
  common_scripts\utility::func_3C8F("ee_escort_frank_reached_battery");
  common_scripts\utility::func_3C9F("ee_call_lightning_frank_fell");
  var_00 = common_scripts\utility::func_46B5("frank_first_half_escort_end", "script_noteworthy");
  level.frank_dudebroman setorigin(var_00.var_116);
}

warp_skip_escort_part02() {
  warp_skip_escort_part01();
  common_scripts\utility::func_3C8F("ee_escort_frank_reached_basement");
  common_scripts\utility::func_3C8F("ee_escort_frank_soul_collection_complete");
  var_00 = common_scripts\utility::func_46B5("frank_second_half_escort_end", "script_noteworthy");
  level.battery_drop_org = var_00.var_116;
  level.frank_dudebroman setorigin(var_00.var_116);
  ee_quest_step_escort_frank_battery_setup();
  level.frank_dudebroman.var_480F = 0;
  level.frank_dudebroman dodamage(level.frank_dudebroman.var_BC * 2, level.frank_dudebroman.var_116);
}

cheat_frank_godon_toggle() {
  if(isDefined(level.frank_dudebroman)) {
    if(level.frank_dudebroman.var_480F) {
      level.frank_dudebroman.var_480F = 0;
      return;
    }

    level.frank_dudebroman.var_480F = 1;
  }
}

cheat_frank_notarget_toggle() {
  if(isDefined(level.frank_dudebroman)) {
    if(level.frank_dudebroman.var_CE) {
      level.frank_dudebroman.var_CE = 0;
      return;
    }

    level.frank_dudebroman.var_CE = 1;
  }
}

cheat_frank_run_toggle() {
  if(isDefined(level.frank_dudebroman)) {
    if(!isDefined(level.frank_dudebroman.var_297D)) {
      return;
    }

    if(level.frank_dudebroman.var_297D == ::maps\mp\zombies\sg_events_v1\very_important_zombie::basic_vip_custom_movemode_walk) {
      level.frank_dudebroman.var_297D = ::maps\mp\zombies\sg_events_v1\very_important_zombie::basic_vip_custom_movemode_sprint;
      return;
    }

    level.frank_dudebroman.var_297D = ::maps\mp\zombies\sg_events_v1\very_important_zombie::basic_vip_custom_movemode_walk;
  }
}