/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_windmill_code.gsc
*******************************************************/

ee_init() {
  ee_init_flags();
  _id_0557::_id_786C();
  _id_0557::_id_7846("quest_frank", _id_0557::_id_30D8, [], _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_frank", "step_find_frank", ::ee_quest_step_find_frank, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_frank", "step_find_rope", ::ee_quest_step_find_rope, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_frank", "step_find_rods", ::ee_quest_step_find_rods, _id_0557::_id_30D8, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_frank", "step_hang_frank", ::ee_quest_step_hang_frank, maps\mp\zombies\shotgun\_zombies_shotgun_exp_events::award_exp_small, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_frank", "step_call_lightning", ::ee_quest_step_call_lightning, maps\mp\zombies\shotgun\_zombies_shotgun_exp_events::award_exp_small, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_frank", "step_defend_frank", ::ee_quest_step_defend_frank, maps\mp\zombies\shotgun\_zombies_shotgun_exp_events::award_exp_smallish, _id_0557::removed_quest_hint());
  _id_0557::_id_781E("quest_frank", "step_escort_frank", ::ee_quest_step_escort_frank, ::windmill_completion_rewards, _id_0557::removed_quest_hint());
  _id_0557::_id_7848("quest_frank");
  thread ee_quest_step_find_frank_init();
  thread ee_quest_step_find_rope_init();
  thread ee_quest_step_find_rods_init();
  thread ee_quest_step_hang_frank_init();
  thread ee_quest_step_escort_frank_init();
}

windmill_completion_rewards() {
  maps\mp\zombies\shotgun\_zombies_shotgun_exp_events::award_exp_med();
  common_scripts\utility::flag_set("zmb_objectives_quest_end");

  foreach(var_1 in level.players) {
    var_1 _id_056A::_id_4772(1);
    var_1 thread maps\mp\gametypes\_hud_message::_id_9102("zm_dlc3_ee_1_complete");

    if(_isonlinegame()) {
      var_1 _meth_8697(43, [5, 5]);
      var_1 thread maps\mp\gametypes\_hud_message::_id_9102("zm_camo_unlocked", 1);
    }
  }
}

ee_init_flags() {
  common_scripts\utility::flag_init("ee_find_frank_part_head_found");
  common_scripts\utility::flag_init("ee_find_frank_part_torso_found");
  common_scripts\utility::flag_init("ee_find_frank_part_left_leg_found");
  common_scripts\utility::flag_init("ee_find_frank_part_right_leg_found");
  common_scripts\utility::flag_init("ee_find_frank_part_left_arm_found");
  common_scripts\utility::flag_init("ee_find_frank_part_right_arm_found");
  common_scripts\utility::flag_init("ee_find_rope_part_shot");
  common_scripts\utility::flag_init("ee_find_rope_branch_pull_complete");
  common_scripts\utility::flag_init("ee_find_rope_part_collected");
  common_scripts\utility::flag_init("ee_find_rods_rods_found");
  common_scripts\utility::flag_init("ee_hang_frank_arm_dropped");
  common_scripts\utility::flag_init("ee_hang_frank_arm_acquired");
  common_scripts\utility::flag_init("ee_hang_frank_windmill_jammed");
  common_scripts\utility::flag_init("ee_hang_frank_complete");
  common_scripts\utility::flag_init("ee_call_lightning_complete");
  common_scripts\utility::flag_init("ee_call_lightning_frank_fell");
  common_scripts\utility::flag_init("ee_hang_frank_defend_complete");
  common_scripts\utility::flag_init("ee_escort_frank_reached_battery");
  common_scripts\utility::flag_init("ee_escort_frank_soul_collection_complete");
  common_scripts\utility::flag_init("ee_escort_frank_reached_basement");
  common_scripts\utility::flag_init("ee_escort_frank_battery_collected");
  common_scripts\utility::flag_init("ee_escort_hilt_collected");
}

audio_log_init() {
  var_0 = _getent("lore_primary", "script_noteworthy");
  var_0._id_9D5E = _getent(var_0.target, "targetname");
  var_0 hide();
  var_0._id_9D5E common_scripts\utility::_id_9D9F();
  audio_log_listen(var_0);
}

audio_log_listen(var_0) {
  var_1 = _getent("audio_log_hanging_model", "targetname");
  var_1 setcandamage(1);
  var_1 waittill("damage");
  var_2 = var_0.origin - var_1.origin;
  var_3 = _sqrt(_abs(var_2[2] * 2 / 800));
  var_4 = 1 / var_3;
  var_5 = var_2 * (var_4, var_4, 0);
  var_1 movegravity(var_5, var_3);
  var_1 rotateto(var_0.angles, var_3);
  wait(var_3);
  var_1.origin = var_0.origin;
  var_1 delete();
  var_0 show();
  var_0._id_9D5E common_scripts\utility::_id_9DA3();
}

__________________step_find_frank____________________() {}

ee_quest_step_find_frank_init() {
  level.zombie_parts_found = 0;
}

ee_quest_step_find_frank() {
  ee_quest_step_find_frank_parts_think();
  _id_0557::_id_782D("quest_frank", "step_find_frank");
}

ee_quest_step_find_frank_parts_think() {
  ee_quest_step_find_frank_part_setup("head");
  ee_quest_step_find_frank_part_setup("torso");
  ee_quest_step_find_frank_part_setup("left_leg");
  ee_quest_step_find_frank_part_setup("right_leg");
  ee_quest_step_find_frank_part_setup("left_arm");
  ee_quest_step_find_frank_part_setup("right_arm");
  var_0 = ["ee_find_frank_part_head_found", "ee_find_frank_part_torso_found", "ee_find_frank_part_left_leg_found", "ee_find_frank_part_right_leg_found", "ee_find_frank_part_left_arm_found", "ee_find_frank_part_right_arm_found"];
  common_scripts\utility::_id_3CA1(var_0);
}

ee_quest_step_find_frank_part_setup(var_0) {
  var_1 = common_scripts\utility::_id_46B7("frank_" + var_0, "targetname");
  var_2 = common_scripts\utility::random(var_1);
  var_2 thread ee_quest_step_find_frank_part_think(var_0);
}

ee_quest_step_find_frank_part_think(var_0) {
  var_1 = self;

  if(!isDefined(var_1.showing_part) || !var_1.showing_part) {
    var_1.showing_part = 1;
    var_2 = spawn("script_model", var_1.origin);
    var_2.angles = var_1.angles;
    var_2 setModel(ee_quest_step_find_frank_get_modelname_by_partname(var_0));
    var_3 = 0;
    var_4 = 72;
    var_5 = 70;

    while(!var_3) {
      waitframe();
      var_6 = level.players;

      foreach(var_8 in var_6) {
        if(_distance2d(var_8.origin, var_2.origin) > var_4)
          var_6 = common_scripts\utility::_id_0F93(var_6, var_8);
      }

      if(var_6.size <= 0) {
        continue;
      }
      foreach(var_8 in var_6) {
        if(!var_8 usebuttonpressed())
          var_6 = common_scripts\utility::_id_0F93(var_6, var_8);
      }

      if(var_6.size <= 0) {
        continue;
      }
      foreach(var_8 in var_6) {
        if(!common_scripts\utility::within_fov(var_8 getEye(), var_8.angles, var_2.origin, _cos(var_5)))
          var_6 = common_scripts\utility::_id_0F93(var_6, var_8);
      }

      if(var_6.size <= 0) {
        continue;
      }
      wait 0.2;

      foreach(var_8 in var_6) {
        if(!common_scripts\utility::within_fov(var_8 getEye(), var_8.angles, var_2.origin, _cos(var_5)))
          var_6 = common_scripts\utility::_id_0F93(var_6, var_8);

        if(!var_8 usebuttonpressed())
          var_6 = common_scripts\utility::_id_0F93(var_6, var_8);
      }

      if(var_6.size > 0)
        var_3 = 1;
    }

    var_2 delete();
    level.zombie_parts_found++;
    common_scripts\utility::flag_set("ee_find_frank_part_" + var_0 + "_found");
  }
}

ee_quest_step_find_frank_get_modelname_by_partname(var_0) {
  switch (var_0) {
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
      return;
  }
}

warp_find_frank_complete() {
  common_scripts\utility::flag_set("ee_find_frank_part_head_found");
  common_scripts\utility::flag_set("ee_find_frank_part_torso_found");
  common_scripts\utility::flag_set("ee_find_frank_part_left_leg_found");
  common_scripts\utility::flag_set("ee_find_frank_part_right_leg_found");
  common_scripts\utility::flag_set("ee_find_frank_part_left_arm_found");
  common_scripts\utility::flag_set("ee_find_frank_part_right_arm_found");
  level.zombie_parts_found = 6;
}

cheat_show_all_bodyparts() {
  var_0 = ["head", "torso", "left_leg", "right_leg", "left_arm", "right_arm"];

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::_id_46B7("frank_" + var_2, "targetname");

    foreach(var_5 in var_3)
    var_5 thread ee_quest_step_find_frank_part_think(var_2);
  }
}

________________step_find_rope______________________() {}

ee_quest_step_find_rope_init() {
  var_0 = _getent("rope_pull_animorg", "targetname");
  var_1 = _getent("rope_fall", "targetname");
  var_1 scriptmodelplayanimdeltamotion("zmb_windmill_rope_hanging");
  var_0 scriptmodelplayanimdeltamotion("zmb_windmill_branch_start");
  thread ee_quest_step_find_rope_waitfor_rope_shot();
  common_scripts\utility::_id_3C9F("ee_find_rope_part_shot");

  if(!common_scripts\utility::_id_3C77("ee_find_rope_part_collected")) {
    level waittill("round complete");
    level waittill("zombie_wave_started");
    thread ee_quest_step_find_rope_waitfor_rope_recovered();
    common_scripts\utility::_id_3C9F("ee_find_rope_part_collected");
  }

  ee_quest_step_find_rope_cleanup();
}

ee_quest_step_find_rope() {
  common_scripts\utility::_id_3C9F("ee_find_rope_part_collected");
  _id_0557::_id_782D("quest_frank", "step_find_rope");
}

#using_animtree("animated_props_zombies_DLC3");

ee_quest_step_find_rope_waitfor_rope_shot() {
  level endon("ee_find_rope_part_shot");
  var_0 = _getent("rope_bundle_damage_trig", "targetname");
  var_0 setcontents(var_0 _meth_85A0() | 256);
  var_0 waittill("damage");
  var_1 = _getent("rope_fall", "targetname");
  var_1 scriptmodelplayanimdeltamotion("zmb_windmill_rope_fall");
  var_0 _id_0378::_id_8D74("frank_rope_shot");
  wait(_getanimlength(%zmb_windmill_rope_fall));
  var_1 scriptmodelclearanim();
  var_1 delete();
  common_scripts\utility::flag_set("ee_find_rope_part_shot");
}

ee_quest_step_find_rope_waitfor_rope_recovered() {
  level endon("ee_find_rope_part_collected");
  var_0 = _getent("rope_pull_animorg", "targetname");
  var_1 = _getent("branch_pull_trigger", "targetname");
  var_2 = _getent("rope_collect_trigger", "targetname");
  var_3 = 0;
  var_4 = 0;
  var_0 scriptmodelclearanim();
  var_0 scriptmodelplayanimdeltamotion("zmb_windmill_rope_trav");
  wait(_getanimlength(%zmb_windmill_rope_trav));
  var_0 scriptmodelclearanim();
  var_0 scriptmodelplayanimdeltamotion("zmb_windmill_rope_water_loop");

  while(!common_scripts\utility::_id_3C77("ee_find_rope_branch_pull_complete")) {
    while(!ee_quest_step_find_rope_return_branch_pulled(var_1) && !common_scripts\utility::_id_3C77("ee_find_rope_branch_pull_complete"))
      waitframe();

    if(!var_3) {
      var_0 scriptmodelplayanimdeltamotion("zmb_windmill_rope_recover");
      var_3 = 1;
      var_0 _id_0378::_id_8D74("frank_pull_branch", "pulling");
    } else {
      var_0 setshadowrendering(0);
      var_0 _id_0378::_id_8D74("frank_pull_branch", "pulling");
    }

    var_5 = gettime();

    while(ee_quest_step_find_rope_return_branch_pulled(var_1) && !common_scripts\utility::_id_3C77("ee_find_rope_branch_pull_complete")) {
      waitframe();
      var_4 = var_4 + (gettime() - var_5);
      var_5 = gettime();

      if(var_4 >= _getanimlength(%zmb_windmill_rope_recover) * 1000 - 100.0) {
        common_scripts\utility::flag_set("ee_find_rope_branch_pull_complete");
        var_0 _id_0378::_id_8D74("frank_pull_branch", "end");
        break;
      }
    }

    var_0 setshadowrendering(1);
    var_0 _id_0378::_id_8D74("frank_pull_branch", "stopped");
  }

  var_2 waittill("trigger");
  var_0 scriptmodelplayanimdeltamotionfrompos("zmb_windmill_branch_end", var_0.origin, var_0.angles);
  var_0 hidepart("rope");
  var_0 hidepart("bit_T");
  var_0 hidepart("bit_B");
  var_6 = 21;

  for(var_7 = 1; var_7 <= var_6; var_7++)
    var_0 hidepart("dangle_0" + var_7);

  common_scripts\utility::flag_set("ee_find_rope_part_collected");
}

ee_quest_step_find_rope_return_branch_pulled(var_0) {
  var_1 = level.players;
  var_2 = var_0;
  var_3 = 0;

  foreach(var_5 in var_1) {
    if(var_5 istouching(var_2)) {
      if(var_5 usebuttonpressed())
        var_3 = 1;
    }
  }

  return var_3;
}

ee_quest_step_find_rope_cleanup() {}

warp_rope_shot() {
  common_scripts\utility::flag_set("ee_find_rope_part_shot");
}

warp_rope_recovered() {
  warp_find_frank_complete();
  common_scripts\utility::flag_set("ee_find_rope_part_shot");
  common_scripts\utility::flag_set("ee_find_rope_branch_pull_complete");
  common_scripts\utility::flag_set("ee_find_rope_part_collected");
}

________________step_find_rods_______________________() {}

ee_quest_step_find_rods_init() {
  maps\mp\zombies\shotgun\_zombies_shotgun_drop_pod::init();
  level.drop_pod_rods = getEntArray("drop_pod_rod", "targetname");

  foreach(var_1 in level.drop_pod_rods)
  var_1 hide();

  level.num_rods_to_find = level.drop_pod_rods.size;
  level.num_rods_found = 0;
}

ee_quest_step_find_rods() {
  level waittill("round complete");
  level waittill("zombie_wave_started");
  wait 5;
  ee_quest_step_find_rods_spawn_pod_and_rods();
  common_scripts\utility::_id_3C9F("ee_find_rods_rods_found");
  _id_0557::_id_782D("quest_frank", "step_find_rods");
}

ee_quest_step_find_rods_spawn_pod_and_rods() {
  level endon("ee_find_rods_rods_found");
  var_0 = common_scripts\utility::_id_46B5("drop_pod_position", "targetname");
  thread maps\mp\zombies\shotgun\_zombies_shotgun_drop_pod::drop_pod_spawn_drop();

  if(!common_scripts\utility::_id_3C77("ee_find_rods_rods_found")) {
    while(!isDefined(var_0.spawned_model))
      waitframe();

    foreach(var_2 in level.drop_pod_rods) {
      var_3 = var_0.spawned_model.origin - var_0.pod_model.origin;
      var_2.origin = var_2.origin + var_3;
      var_2 linktosynchronizedparent(var_0.spawned_model);
      var_2 common_scripts\utility::_id_2CBE(0.05, ::show);
    }

    while(isDefined(var_0.clip_fall))
      waitframe();

    var_5 = common_scripts\utility::_id_46B7("drop_pod_rod_target_loc", "targetname");

    for(var_6 = 0; var_6 < level.drop_pod_rods.size; var_6++) {
      thread ee_quest_step_find_rods_throw_rod(level.drop_pod_rods[var_6], var_5[var_6]);
      thread ee_quest_step_find_rods_use_rod(level.drop_pod_rods[var_6]);
    }
  }
}

ee_quest_step_find_rods_throw_rod(var_0, var_1) {
  level endon("ee_find_rods_rods_found");
  var_0 unlink();
  var_2 = 0.25;
  var_0 moveto(var_1.origin, var_2);
  var_0 rotateto(var_1.angles, var_2);
  wait(var_2);
  var_0.origin = var_1.origin;
}

ee_quest_step_find_rods_use_rod(var_0) {
  level endon("ee_find_rods_rods_found");
  wait 2;
  var_0 _id_0547::_id_AC41(" ");
  var_0 waittill("player_used", var_1);
  var_0 delete();
  level.num_rods_found++;

  if(level.num_rods_found >= level.num_rods_to_find)
    common_scripts\utility::flag_set("ee_find_rods_rods_found");
}

warp_rods_found() {
  warp_rope_recovered();
  common_scripts\utility::flag_set("ee_find_rods_rods_found");
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
  common_scripts\utility::_id_3C9F("ee_hang_frank_complete");
  ee_quest_step_hang_frank_cleanup();
  _id_0557::_id_782D("quest_frank", "step_hang_frank");
}

ee_quest_step_hang_frank_acquire_wustling_arm() {
  level endon("ee_hang_frank_complete");
  wait 10;
  level._id_0A41["zombie_heavy"]["post_model"] = ::ee_quest_step_hang_frank_acquire_wustling_arm_spawn_func;
  var_0 = _id_0547::_id_4090("zombie_heavy");

  foreach(var_2 in var_0)
  var_2 thread ee_quest_step_hang_frank_acquire_wustling_arm_spawn_func();

  common_scripts\utility::_id_3C9F("ee_hang_frank_arm_dropped");
  level._id_0A41["zombie_heavy"]["post_model"] = _id_054D::_id_AC1E;
  common_scripts\utility::_id_3C9F("ee_hang_frank_arm_acquired");
}

ee_quest_step_hang_frank_acquire_wustling_arm_spawn_func() {
  self notify("running_arm_sever_spawn_func");
  self endon("running_arm_sever_spawn_func");
  self endon("death");
  level endon("ee_hang_frank_arm_dropped");

  while(isDefined(self)) {
    var_0 = _id_0547::_id_4090("zombie_heavy");

    if(var_0.size > 1) {
      var_0 = common_scripts\utility::_id_0F93(var_0, self);

      foreach(var_2 in var_0) {
        if(distance(var_2.origin, self.origin) <= 64 && isDefined(var_2._id_5542) && var_2._id_5542 == 1) {
          var_3 = 36;

          if(isDefined(var_2._id_28D2)) {
            var_4 = distance(self.origin, var_2._id_28D2.origin);
            var_5 = distance(var_2.origin, var_2._id_28D2.origin) - var_3;

            if(var_4 <= var_5) {
              thread ee_quest_step_hang_frank_acquire_wustling_arm_drop_arm(self.origin - var_2.origin);
              return;
            }
          }
        }
      }

      waitframe();
      continue;
    }

    waitframe();
  }
}

ee_quest_step_hang_frank_acquire_wustling_arm_drop_arm(var_0) {
  var_1 = self;
  wait 1.25;
  var_2 = var_1.origin;
  _id_0547::_id_5A85(self.origin, var_0);
  var_2 = common_scripts\utility::_id_348B(var_2, 32);
  var_3 = spawn("script_model", var_2 + (0, 0, 4));
  var_3 setModel("zmw_wustling_arm_01");
  var_3 hudoutlineenableforclients(level.players, 2, 1);
  common_scripts\utility::flag_set("ee_hang_frank_arm_dropped");
  var_3 _id_0547::_id_AC41(" ");
  var_3 waittill("player_used");
  var_3 hudoutlinedisableforclients(level.players);
  var_3 delete();
  common_scripts\utility::flag_set("ee_hang_frank_arm_acquired");
}

ee_quest_step_hang_frank_jam_windmill() {
  var_0 = _getent("windmill_jam_trigger", "targetname");
  var_1 = _getent("wustling_arm_jam_model", "targetname");
  var_2 = _getent("wustling_arm_jam_model_start", "targetname");
  var_3 = _getent("wustling_arm_jam_model_end", "targetname");
  var_1.origin = var_2.origin;
  var_1.angles = var_2.angles;
  var_1 hide();
  common_scripts\utility::_id_3C9F("ee_hang_frank_arm_acquired");

  for(;;) {
    var_0 waittill("trigger");
    level thread common_scripts\_exploder::_id_088E(204);
    var_1 _id_0378::_id_8D74("wustling_arm_jam");
    maps\mp\mp_zombie_windmill_util::windmill_stop_idle();
    var_1 show();
    var_1 moveto(var_3.origin, 0.5, 0, 0.05);
    var_1 rotateto(var_3.angles, 0.5, 0, 0.05);
    level waittill("done_accelerating");
    _iprintlnbold("JAMMED");
    common_scripts\utility::flag_set("ee_hang_frank_windmill_jammed");
    var_0 waittill("trigger");
    maps\mp\mp_zombie_windmill_util::windmill_idle_with_speed(1);
    var_1 hide();
    var_1.origin = var_2.origin;
    var_1.angles = var_2.angles;
    level waittill("done_accelerating");
    _iprintlnbold("UN-JAMMED");
    common_scripts\utility::_id_3C7B("ee_hang_frank_windmill_jammed");
    wait 1;
  }
}

ee_quest_step_hang_frank_place_parts_think() {
  level endon("ee_hang_frank_complete");
  var_0 = 0;
  var_1 = 0;
  var_2 = _getent("windmill_place_part_trig", "targetname");
  var_3 = _getent("windmill_fan", "targetname");
  var_4 = _getent("frank_fanblade_models_org", "targetname");
  var_5 = getEntArray("frank_fanblade_models", "script_noteworthy");

  foreach(var_7 in var_5) {
    var_7 linktosynchronizedparent(var_4);
    var_7 hide();
  }

  var_4 linktosynchronizedparent(var_3);
  common_scripts\utility::_id_3C9F("ee_hang_frank_arm_acquired");

  while(var_0 < 6 || var_1 < level.drop_pod_rods.size) {
    common_scripts\utility::_id_3C9F("ee_hang_frank_windmill_jammed");
    var_9 = _abs(var_3.angles[0] % 90);
    var_10 = 5;

    if(ee_quest_step_hang_frank_check_if_fan_rot_correct(var_3)) {
      while(var_0 < 6 || var_1 < level.drop_pod_rods.size) {
        var_2 waittill("trigger");

        if(!common_scripts\utility::_id_3C77("ee_hang_frank_windmill_jammed")) {
          break;
        } else {
          var_11 = ee_quest_step_hang_frank_check_if_fan_rot_correct(var_3);

          if(!var_11) {
            break;
          }
        }

        if(!common_scripts\utility::_id_3C77("ee_find_rope_part_collected")) {
          continue;
        }
        ee_quest_step_hang_frank_place_acquired_parts();
        var_0 = level.zombie_parts_found;
        var_1 = level.num_rods_found;
        level.total_parts_placed = var_0 + var_1;
      }
    } else {
      while(common_scripts\utility::_id_3C77("ee_hang_frank_windmill_jammed"))
        waitframe();
    }

    waitframe();
  }

  common_scripts\utility::flag_set("ee_hang_frank_complete");
}

ee_quest_step_hang_frank_place_acquired_parts() {
  var_0 = level.zombie_parts_found + level.num_rods_found;

  if(var_0 <= level.total_parts_placed) {
    return;
  }
  if(level.num_rods_found >= 2) {
    ee_quest_step_hang_frank_show_part_with_targetname("frank_hang_rod01");
    ee_quest_step_hang_frank_show_part_with_targetname("frank_hang_rod02");
  } else if(level.num_rods_found == 1)
    ee_quest_step_hang_frank_show_part_with_targetname("frank_hang_rod01");

  if(common_scripts\utility::_id_3C77("ee_find_frank_part_head_found"))
    ee_quest_step_hang_frank_show_part_with_targetname("frank_hang_head");

  if(common_scripts\utility::_id_3C77("ee_find_frank_part_torso_found"))
    ee_quest_step_hang_frank_show_part_with_targetname("frank_hang_torso");

  if(common_scripts\utility::_id_3C77("ee_find_frank_part_left_leg_found"))
    ee_quest_step_hang_frank_show_part_with_targetname("frank_hang_ll");

  if(common_scripts\utility::_id_3C77("ee_find_frank_part_right_leg_found"))
    ee_quest_step_hang_frank_show_part_with_targetname("frank_hang_rl");

  if(common_scripts\utility::_id_3C77("ee_find_frank_part_left_arm_found"))
    ee_quest_step_hang_frank_show_part_with_targetname("frank_hang_la");

  if(common_scripts\utility::_id_3C77("ee_find_frank_part_right_arm_found"))
    ee_quest_step_hang_frank_show_part_with_targetname("frank_hang_ra");
}

ee_quest_step_hang_frank_show_part_with_targetname(var_0) {
  var_1 = _getent(var_0, "targetname");
  var_2 = getEntArray(var_1.target, "targetname");
  var_1 show();

  foreach(var_4 in var_2)
  var_4 show();
}

ee_quest_step_hang_frank_delete_part_with_targetname(var_0) {
  var_1 = _getent(var_0, "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = getEntArray(var_1.target, "targetname");

  if(var_2.size > 0) {
    foreach(var_4 in var_2) {
      var_4 unlink();
      var_4 delete();
    }
  }

  if(isDefined(var_1)) {
    var_1 unlink();
    var_1 delete();
  }
}

ee_quest_step_hang_frank_check_if_fan_rot_correct(var_0) {
  var_1 = _abs(var_0.angles[0] % 90);
  var_2 = 5;

  if(var_1 < var_2 || var_1 > 90 - var_2) {
    if(isDefined(level.required_fan_org_angle)) {
      if(_abs(level.required_fan_org_angle - var_0.angles[0]) < var_2)
        return 1;
      else
        return 0;
    } else
      return 1;
  } else
    return 0;
}

ee_quest_step_hang_frank_cleanup() {}

warp_hang_frank() {
  warp_rods_found();
  common_scripts\utility::flag_set("ee_hang_frank_arm_dropped");
  common_scripts\utility::flag_set("ee_hang_frank_arm_acquired");
  common_scripts\utility::flag_set("ee_hang_frank_complete");
  ee_quest_step_hang_frank_place_acquired_parts();
  var_0 = _getent("windmill_fan", "targetname");
  var_0.current_speed = 0;
  wait 1;
  var_0.angles = (270, var_0.angles[1], var_0.angles[2]);
  wait 2;
}

cheat_give_wustling_arm() {
  common_scripts\utility::flag_set("ee_hang_frank_arm_dropped");
  common_scripts\utility::flag_set("ee_hang_frank_arm_acquired");
}

___________step_call_lightning__________() {}

ee_quest_step_call_lightning_init() {}

ee_quest_step_call_lightning() {
  thread ee_quest_step_call_lightning_think();
  common_scripts\utility::_id_3C9F("ee_call_lightning_complete");
  thread ee_quest_step_call_lightning_do_strike();
  _id_0557::_id_782D("quest_frank", "step_call_lightning");
}

ee_quest_step_call_lightning_think() {
  level endon("ee_call_lightning_complete");

  if(!common_scripts\utility::_id_3C77("ee_call_lightning_complete")) {
    var_0 = _getent("windmill_fan", "targetname");
    level.windmill_charged = 0;

    while(!level.windmill_charged) {
      ee_quest_step_call_lightning_monitor_progress_for_round(var_0);

      if(var_0.angles[0] != 270 || var_0.current_speed != 0) {
        level.windmill_charged = 0;
        wait 10;
      }

      waitframe();
    }

    wait 5;
    common_scripts\utility::flag_set("ee_call_lightning_complete");
  }
}

ee_quest_step_call_lightning_monitor_progress_for_round(var_0) {
  level endon("round complete");

  for(;;) {
    if(var_0.angles[0] == 270 && var_0.current_speed == 0)
      level.windmill_charged = 1;
    else
      level.windmill_charged = 0;

    waitframe();
  }
}

ee_quest_step_call_lightning_do_strike() {
  common_scripts\utility::_id_3C9F("ee_call_lightning_complete");
  var_0 = _getent("frank_fanblade_models_org", "targetname");
  maps\mp\zombies\sg_events_v1\extermination::_id_5D67(var_0.origin - (0, 0, 40));
  level thread common_scripts\_exploder::_id_088E(202);
  wait(_randomfloatrange(0.05, 0.07));
  maps\mp\zombies\sg_events_v1\extermination::_id_5D67(var_0.origin - (0, 0, 40));
  wait(_randomfloatrange(0.05, 0.07));
  thread maps\mp\zombies\sg_events_v1\extermination::_id_5D67(var_0.origin - (0, 0, 40));
  _id_0378::_id_8D74("call_lightning_do_strike", var_0.origin - (0, 0, 40));
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
  level.frank_dudebroman hide();
  var_0 = _getent("frank_fall_animorg", "targetname");
  level.frank_dudebroman setOrigin(var_0.origin - (0, 0, 20), 0);
  level.frank_dudebroman.angles = var_0.angles - (0, 90, 0);
  waitframe();
  var_1 = "s2_zom_frank_lightning_fall";
  level.frank_dudebroman scragentsetscripted(1);
  level.frank_dudebroman maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "ScriptedAnimation");
  level.frank_dudebroman scragentsetanimmode("anim deltas");
  level.frank_dudebroman scragentsetorientmode("face angle abs", var_0.angles - (0, 90, 0));
  level.frank_dudebroman scragentsetphysicsmode("noclip");
  level.frank_dudebroman common_scripts\utility::_id_2CBE(0.05, ::show);
  _id_0378::_id_8D74("call_lightning_frank_fall", level.frank_dudebroman);
  level.frank_dudebroman maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_1, 0, 1, "scripted_anim");
  level.frank_dudebroman maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "ScriptedAnimation");
  level.frank_dudebroman scragentsetscripted(0);
  level.frank_dudebroman scragentsetphysicsmode("gravity");
  waitframe();
  var_0 = _getent("frank_fall_animorg", "targetname");
  level.frank_dudebroman scragentsetscripted(1);
  level.frank_dudebroman maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "ScriptedAnimation");
  level.frank_dudebroman scragentsetanimmode("anim deltas");
  level.frank_dudebroman scragentsetorientmode("face angle abs", var_0.angles);
  level.frank_dudebroman scragentsetphysicsmode("noclip");
  var_1 = "s2_zom_frank_lightning_lay_loop";
  level.frank_dudebroman thread maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_1, 0, 1, "frank_getup");
  common_scripts\utility::flag_set("ee_call_lightning_frank_fell");
}

warp_call_lightning() {
  warp_hang_frank();
  common_scripts\utility::flag_set("ee_call_lightning_complete");
}

_____________step_defend_frank____________() {}

ee_quest_step_defend_frank_init() {}

ee_quest_step_defend_frank() {
  level waittill("zombie_wave_started");
  ee_quest_step_defend_frank_think();

  if(isDefined(level.defend_tag_org)) {
    level._id_08E3 = common_scripts\utility::_id_0F93(level._id_08E3, level.defend_tag_org);
    level.defend_tag_org delete();
  }

  common_scripts\utility::flag_set("ee_hang_frank_defend_complete");
  _id_0557::_id_782D("quest_frank", "step_defend_frank");
}

ee_quest_step_defend_frank_think() {
  level endon("round complete");
  level endon("ee_hang_frank_defend_complete");

  while(!isDefined(level.frank_dudebroman))
    waitframe();

  common_scripts\utility::_id_3C9F("ee_call_lightning_frank_fell");

  if(!common_scripts\utility::_id_3C77("ee_hang_frank_defend_complete")) {
    level.frank_escort_health = 100;
    level.defend_tag_org = spawn("script_model", level.frank_dudebroman gettagorigin("J_SpineLower"));
    level.defend_tag_org setModel("tag_origin");
    level.defend_tag_org thread maps\mp\mp_zombies_soul_collection::_id_170B(999, 256, 512, "soul_collected_for_frank", undefined, "tag_origin", undefined, "tag_origin");
    var_0 = 250;
    var_1 = 1;

    for(;;) {
      level waittill("soul_collected_for_frank", var_2, var_3);

      if(isDefined(var_3)) {
        switch (var_3) {
          case "zombie_generic":
            level.frank_escort_health = level.frank_escort_health + 6 * var_1;
            break;
          case "zombie_berserker":
            level.frank_escort_health = level.frank_escort_health + 6 * var_1;
            break;
          case "zombie_exploder":
            level.frank_escort_health = level.frank_escort_health + 12 * var_1;
            break;
          case "zombie_heavy":
            level.frank_escort_health = level.frank_escort_health + 30 * var_1;
            break;
          case "zombie_sizzler":
            level.frank_escort_health = level.frank_escort_health + 12 * var_1;
            break;
          case "zombie_assassin":
            level.frank_escort_health = level.frank_escort_health + 100 * var_1;
            break;
          case "zombie_fireman":
            level.frank_escort_health = level.frank_escort_health + 200 * var_1;
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
  var_0 = _getent("escort_battery", "targetname");
  var_0 hide();
  var_1 = _getent("wine_cellar_batt", "targetname");
  var_1 hide();
}

ee_quest_step_escort_frank() {
  level waittill("zombie_wave_started");
  wait 3;
  ee_quest_step_escort_frank_wake_up_anim();

  if(!common_scripts\utility::_id_3C77("ee_escort_frank_reached_battery")) {
    var_0 = 0;
    var_0 = ee_quest_step_escort_frank_move_to_battery_destination();

    if((!isDefined(var_0) || !var_0) && !common_scripts\utility::_id_3C77("ee_escort_frank_reached_battery"))
      return;
    else
      common_scripts\utility::flag_set("ee_escort_frank_reached_battery");

    level waittill("round complete");
    var_1 = 0;

    if(level._id_A980 % 3 == 0)
      var_1 = var_1 + 24;
    else
      var_1 = 14;

    wait(var_1);
    level.frank_dudebroman._id_480F = 0;
    level.frank_dudebroman._id_00CE = 0;
  }

  if(!common_scripts\utility::_id_3C77("ee_escort_frank_reached_basement")) {
    var_0 = 0;
    var_0 = ee_quest_step_escort_frank_move_to_door_destination();
  }

  if(common_scripts\utility::_id_3C77("ee_escort_frank_soul_collection_complete"))
    var_0 = 1;
  else
    var_0 = 0;

  if(isDefined(var_0) && var_0) {
    common_scripts\utility::flag_set("ee_escort_frank_reached_basement");
    ee_quest_step_escort_frank_drop_charged_battery();
    ee_quest_step_escort_frank_collect_prize_think();
    _id_0557::_id_782D("quest_frank", "step_escort_frank");
  } else {
    if(common_scripts\utility::_id_3C77("ee_escort_frank_soul_collection_complete"))
      _killfxontag(level._effect["battery_glow_finished"], level.frank_battery.fx_tag, "tag_origin");
    else {
      _killfxontag(level._effect["battery_glow"], level.frank_battery.fx_tag, "tag_origin");
      playFX(level._effect["dlc_zmb_dig_02_uber_explode"], level.frank_battery.fx_tag.origin);
    }

    level.frank_battery.fx_tag delete();
    level.frank_battery delete();
  }
}

ee_quest_step_escort_frank_wake_up_anim() {
  level notify("frank_getup");
  common_scripts\utility::_id_3C9F("ee_call_lightning_frank_fell");

  if(isDefined(level.frank_dudebroman) && isalive(level.frank_dudebroman)) {
    level.frank_dudebroman endon("death");
    level.frank_dudebroman maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "ScriptedAnimation");
    level.frank_dudebroman scragentsetscripted(0);
    level.frank_dudebroman scragentsetphysicsmode("gravity");
    waitframe();
    var_0 = _getent("frank_fall_animorg", "targetname");
    level.frank_dudebroman scragentsetscripted(1);
    level.frank_dudebroman maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "ScriptedAnimation");
    level.frank_dudebroman scragentsetanimmode("anim deltas");
    level.frank_dudebroman scragentsetorientmode("face angle abs", var_0.angles - (0, 90, 0));
    level.frank_dudebroman scragentsetphysicsmode("noclip");
    var_1 = "s2_zom_frank_lightning_getup";
    level.frank_dudebroman maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_1, 0, 1, "scripted_anim");
    level.frank_dudebroman._id_480F = 0;
    level.frank_dudebroman._id_00CE = 0;
    level.frank_dudebroman maps\mp\agents\_agent_common::_id_83FD(level.frank_escort_health);
    level.frank_dudebroman maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "ScriptedAnimation");
    level.frank_dudebroman scragentsetscripted(0);
    level.frank_dudebroman scragentsetphysicsmode("gravity");
  }
}

ee_quest_step_escort_frank_move_to_battery_destination() {
  level endon("ee_escort_frank_reached_battery");
  level.frank_dudebroman endon("death");

  for(var_0 = 0; var_0 < level.frank_dudebroman.waypoints.size; var_0++) {
    level.frank_dudebroman._id_1928 = level.frank_dudebroman.waypoints[var_0];

    while(distance(level.frank_dudebroman.origin, level.frank_dudebroman.waypoints[var_0].origin) > 48)
      waitframe();

    if(isDefined(level.frank_dudebroman.waypoints[var_0]._id_0165)) {
      var_1 = level.frank_dudebroman.waypoints[var_0]._id_0165;

      if(var_1 == "frank_start_godon_node") {
        level.frank_dudebroman._id_480F = 1;
        level.frank_dudebroman._id_00CE = 1;
      }
    }
  }

  return 1;
}

ee_quest_step_escort_frank_unset_goal() {
  level.frank_dudebroman._id_1928 = undefined;
}

ee_quest_step_escort_frank_move_to_door_destination() {
  level.frank_dudebroman endon("death");
  level endon("ee_escort_frank_reached_basement");
  level.battery_drop_org = level.frank_dudebroman.origin;
  ee_quest_step_escort_frank_battery_setup();
  thread ee_quest_step_escort_frank_soul_collection();
  var_0 = common_scripts\utility::_id_46B5("frank_second_path_start", "targetname");
  level.frank_dudebroman.waypoints = var_0 maps\mp\zombies\sg_events_v1\very_important_zombie::basic_vip_get_waypoints(level.frank_dudebroman);

  for(var_1 = 0; var_1 < level.frank_dudebroman.waypoints.size; var_1++) {
    level.frank_dudebroman._id_1928 = level.frank_dudebroman.waypoints[var_1];

    while(distance(level.frank_dudebroman.origin, level.frank_dudebroman.waypoints[var_1].origin) > 48) {
      level.battery_drop_org = level.frank_dudebroman.origin;
      waitframe();
    }
  }

  if(isDefined(level.frank_dudebroman))
    level.frank_dudebroman common_scripts\utility::_id_2CBE(0.05, ::dodamage, level.frank_dudebroman.health * 2, level.frank_dudebroman.origin);

  return 1;
}

ee_quest_step_escort_frank_battery_setup() {
  if(!isDefined(level.frank_battery) || !isDefined(level.frank_battery.fx_tag)) {
    level.frank_battery = _getent("escort_battery", "targetname");
    level.frank_battery show();
    level.frank_battery.fx_tag = spawn("script_model", level.frank_battery.origin);
    level.frank_battery.fx_tag setModel("tag_origin");
    level.frank_battery.fx_tag linktosynchronizedparent(level.frank_battery, "tag_origin");
    _playfxontag(level._effect["battery_glow"], level.frank_battery.fx_tag, "tag_origin");
    level.frank_battery.origin = level.frank_dudebroman gettagorigin("J_Wrist_LE");
    level.frank_battery.angles = level.frank_dudebroman gettagangles("J_Wrist_LE");
    level.frank_battery.origin = level.frank_battery.origin - anglestoup(level.frank_battery.angles) * 2;
    level.frank_battery.origin = level.frank_battery.origin + anglesToForward(level.frank_battery.angles) * 3;
    level.frank_battery.origin = level.frank_battery.origin - anglestoright(level.frank_battery.angles) * 3;
    level.frank_battery linktosynchronizedparent(level.frank_dudebroman, "J_Wrist_LE");
  }
}

ee_quest_step_escort_frank_soul_collection() {
  level.frank_dudebroman endon("death");
  level.frank_battery.fx_tag endon("death");
  var_0 = 30;
  level.frank_battery.fx_tag maps\mp\mp_zombies_soul_collection::_id_170B(var_0, 256, 64, "battery_soul_collected", undefined, "tag_origin", undefined, "tag_origin", undefined, undefined, (0, 0, 64), undefined, undefined, undefined, 0);
  _killfxontag(level._effect["battery_glow"], level.frank_battery.fx_tag, "tag_origin");
  _playfxontag(level._effect["battery_glow_finished"], level.frank_battery.fx_tag, "tag_origin");
  common_scripts\utility::flag_set("ee_escort_frank_soul_collection_complete");
}

ee_quest_step_escort_frank_drop_charged_battery() {
  var_0 = level.battery_drop_org;

  if(isDefined(level.frank_dudebroman) && isalive(level.frank_dudebroman)) {
    level.frank_dudebroman._id_480F = 0;
    level.frank_dudebroman dodamage(level.frank_dudebroman.health * 2, level.frank_dudebroman.origin);
  }

  level.frank_battery unlink();
  var_0 = common_scripts\utility::_id_348B(var_0, 32) + (0, 0, 2);
  var_1 = var_0 - level.frank_battery.origin;
  var_2 = _sqrt(_abs(var_1[2] * 2 / 800));
  var_3 = 1 / var_2;
  var_4 = var_1 * (var_3, var_3, 0);
  level.frank_battery movegravity(var_4, var_2);
  level.frank_battery rotateto((0, 0, 0), var_2);
  wait(var_2);
  level.frank_battery.origin = var_0;
  level._id_08E3 = common_scripts\utility::_id_0F93(level._id_08E3, level.frank_battery.fx_tag);
  level.frank_battery.fx_tag delete();
  level.frank_battery hudoutlineenableforclients(level.players, 2, 1);
  level.frank_battery _id_0547::_id_AC41(" ");
  level.frank_battery waittill("player_used");
  level.frank_battery hudoutlinedisableforclients(level.players);
  level.frank_battery delete();
  common_scripts\utility::flag_set("ee_escort_frank_battery_collected");
}

ee_quest_step_escort_frank_collect_prize_think() {
  var_0 = _getent("wine_cellar_batt_trig", "targetname");
  var_1 = _getent("wine_cellar_batt", "targetname");
  var_2 = _getent("wine_cellar_door_clip", "targetname");
  var_3 = _getent("wine_cellar_door", "targetname");
  var_2 linktosynchronizedparent(var_3);
  var_0 waittill("trigger", var_4);
  level thread maps\mp\zombies\weapons\_zombie_dlc3_melee::sword_post_ee_complete_handler();
  var_1 show();
  level thread common_scripts\_exploder::_id_088E(205);
  var_0 delete();
  var_3 rotateby((0, -120, 0), 1, 0.25, 0.25);
  var_2 connectpaths();
  _id_0378::_id_8D74("wine_cellar_door_open", var_3.origin);
  var_5 = _getent("sword_hilt", "targetname");
  var_5 _id_0547::_id_AC41(&"ZOMBIE_DLC3_PICKUP_PART_1");
  var_5 waittill("player_used", var_4);
  var_5 _id_0547::_id_AC40();
  var_5 delete();
  common_scripts\utility::flag_set("ee_escort_hilt_collected");
  level.shattered_ee_complete = 1;
}

warp_skip_escort_part01() {
  warp_defend_frank();
  common_scripts\utility::flag_set("ee_escort_frank_reached_battery");
  common_scripts\utility::_id_3C9F("ee_call_lightning_frank_fell");
  var_0 = common_scripts\utility::_id_46B5("frank_first_half_escort_end", "script_noteworthy");
  level.frank_dudebroman setOrigin(var_0.origin);
}

warp_skip_escort_part02() {
  warp_skip_escort_part01();
  common_scripts\utility::flag_set("ee_escort_frank_reached_basement");
  common_scripts\utility::flag_set("ee_escort_frank_soul_collection_complete");
  var_0 = common_scripts\utility::_id_46B5("frank_second_half_escort_end", "script_noteworthy");
  level.battery_drop_org = var_0.origin;
  level.frank_dudebroman setOrigin(var_0.origin);
  ee_quest_step_escort_frank_battery_setup();
  level.frank_dudebroman._id_480F = 0;
  level.frank_dudebroman dodamage(level.frank_dudebroman.health * 2, level.frank_dudebroman.origin);
}

cheat_frank_godon_toggle() {
  if(isDefined(level.frank_dudebroman)) {
    if(level.frank_dudebroman._id_480F)
      level.frank_dudebroman._id_480F = 0;
    else
      level.frank_dudebroman._id_480F = 1;
  }
}

cheat_frank_notarget_toggle() {
  if(isDefined(level.frank_dudebroman)) {
    if(level.frank_dudebroman._id_00CE)
      level.frank_dudebroman._id_00CE = 0;
    else
      level.frank_dudebroman._id_00CE = 1;
  }
}

cheat_frank_run_toggle() {
  if(isDefined(level.frank_dudebroman)) {
    if(!isDefined(level.frank_dudebroman._id_297D)) {
      return;
    }
    if(level.frank_dudebroman._id_297D == maps\mp\zombies\sg_events_v1\very_important_zombie::basic_vip_custom_movemode_walk)
      level.frank_dudebroman._id_297D = maps\mp\zombies\sg_events_v1\very_important_zombie::basic_vip_custom_movemode_sprint;
    else
      level.frank_dudebroman._id_297D = maps\mp\zombies\sg_events_v1\very_important_zombie::basic_vip_custom_movemode_walk;
  }
}