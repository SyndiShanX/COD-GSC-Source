/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\payback_env_code.gsc
*********************************************/

_id_6699() {
  common_scripts\utility::flag_init("start_pre_construction_anims");
  common_scripts\utility::flag_init("stop_pre_construction_anims");
  common_scripts\utility::flag_init("start_construction_anims");
  common_scripts\utility::flag_init("stop_construction_anims");
  common_scripts\utility::flag_init("start_sandstorm_anims");
  common_scripts\utility::flag_init("stop_sandstorm_anims");
  common_scripts\utility::flag_init("start_rescue_anims");
  common_scripts\utility::flag_init("stop_rescue_anims");
}

_id_6507(var_0) {
  thread _id_6765();

  if(!isDefined(var_0)) {
    var_0 = getDvar("start");
  }
  switch (var_0) {
    case "s3_escape":
    case "s3_rescue":
      common_scripts\utility::flag_set("stop_sandstorm_anims");
      common_scripts\utility::flag_set("start_rescue_anims");
    case "s2_sandstorm":
    case "s2_rappel":
      common_scripts\utility::flag_set("stop_construction_anims");
      common_scripts\utility::flag_set("start_sandstorm_anims");
    case "s2_construction":
      common_scripts\utility::flag_set("stop_pre_construction_anims");
      common_scripts\utility::flag_set("start_construction_anims");
    case "s2_postambush":
    case "s2_city":
      common_scripts\utility::flag_set("start_pre_construction_anims");
    default:
      break;
  }
}

pip_test_init() {
  spawn_struct_array("tree_med_need_in_intro", "script_noteworthy");
  common_scripts\utility::flag_wait("start_pre_construction_anims");

  if(!common_scripts\utility::flag("stop_pre_construction_anims")) {
    spawn_struct_array("tree_low", "script_noteworthy");
    spawn_struct_array("moving_grass_low", "targetname");
    spawn_struct_array("moving_grass_01_low", "targetname");
    spawn_struct_array("moving_grass_02_low", "targetname");
    spawn_struct_array("moving_grass_03_low", "targetname");
    spawn_struct_array("moving_bushes_low", "targetname");
    spawn_struct_array("moving_bushes_med", "targetname");
  }

  if(!common_scripts\utility::flag("stop_construction_anims")) {
    spawn_struct_array("tree_med", "script_noteworthy");
  }
  common_scripts\utility::flag_wait("start_construction_anims");

  if(!common_scripts\utility::flag("stop_construction_anims")) {
    spawn_struct_array("moving_grass_01_med", "targetname");
    spawn_struct_array("moving_grass_02_med", "targetname");
    spawn_struct_array("moving_grass_03_med", "targetname");
    spawn_struct_array("moving_flag_med", "targetname");
    spawn_struct_array("moving_square_flag_med", "targetname");
    spawn_struct_array("moving_tarp_03", "targetname");
    spawn_struct_array("moving_tarp_01", "targetname");
  }

  if(!common_scripts\utility::flag("stop_sandstorm_anims")) {
    spawn_struct_array("tree_heavy", "script_noteworthy");
  }
  common_scripts\utility::flag_wait("start_sandstorm_anims");

  if(!common_scripts\utility::flag("stop_sandstorm_anims")) {
    spawn_struct_array("moving_grass_01_high", "targetname");
    spawn_struct_array("moving_grass_02_high", "targetname");
    spawn_struct_array("moving_grass_03_high", "targetname");
    spawn_struct_array("moving_bushes_high", "targetname");
  }

  common_scripts\utility::flag_wait("start_rescue_anims");
  spawn_struct_array("tree_rescue", "script_noteworthy");
  spawn_struct_array("moving_grass_01_rescue", "targetname");
  spawn_struct_array("moving_grass_02_rescue", "targetname");
  spawn_struct_array("moving_grass_03_rescue", "targetname");
  spawn_struct_array("moving_bushes_rescue", "targetname");
  spawn_struct_array("moving_grass_02_end", "targetname");
  spawn_struct_array("moving_bushes_end", "targetname");
}

spawn_struct_array(var_0, var_1) {
  var_2 = common_scripts\utility::getStructArray(var_0, var_1);

  foreach(var_4 in var_2) {}
  _id_6700(var_4);
}

_id_6700(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 setModel(var_0.script_parameters);
  var_1.targetname = var_0.targetname;
  var_1.script_noteworthy = var_0.script_noteworthy;
  return var_1;
}

_id_6765() {
  var_0 = getEntArray("rolling_barrel_clip", "targetname");

  foreach(var_2 in var_0) {}
  var_2 notsolid();

  thread _id_676A();
  thread _id_6766();
  thread _id_6767();
  thread _id_6768();
  thread _id_6769();
  thread _id_678D();
  thread _id_678E();
}

_id_6766() {
  common_scripts\utility::flag_wait("start_pre_construction_anims");
  wait 1;
  var_0 = thread switch_vehicle_path_lerp("low");
  var_1 = thread _id_676D("low");
  var_2 = thread _id_6780();
  var_3 = thread _id_6773();
  var_4 = thread _id_6784();
  var_5 = thread _id_6788();
  common_scripts\utility::flag_wait("start_construction_anims");
  wait 1;

  foreach(var_7 in var_3) {
    var_7 notify("deleted_through_script");
    var_7 notify("stop_looping_anims");
  }

  var_3 = thread _id_6774(var_3);
  var_3 = getEntArray("payback_wires_wind_light", "script_noteworthy");
  common_scripts\utility::flag_wait("stop_pre_construction_anims");
  var_9 = common_scripts\utility::array_combine(var_2, common_scripts\utility::array_combine(var_1, common_scripts\utility::array_combine(var_0, common_scripts\utility::array_combine(var_4, common_scripts\utility::array_combine(var_5, var_3)))));

  foreach(var_11 in var_9) {
    var_11 notify("deleted_through_script");
    var_11 delete();
  }
}

_id_6767() {
  common_scripts\utility::flag_wait("start_construction_anims");
  wait 1;
  var_0 = thread switch_vehicle_path_lerp("med");
  var_1 = thread _id_676D("med");
  var_2 = thread _id_676E("med");
  var_3 = thread _id_6781();
  var_4 = thread _id_6774();
  var_5 = thread _id_6771();
  var_6 = thread _id_6779();
  var_7 = thread _id_6785();
  thread _id_678A();
  thread _id_676F();
  common_scripts\utility::flag_wait("stop_construction_anims");
  var_8 = common_scripts\utility::array_combine(var_2, common_scripts\utility::array_combine(var_3, common_scripts\utility::array_combine(var_0, common_scripts\utility::array_combine(var_1, var_5))));
  var_8 = common_scripts\utility::array_combine(var_8, common_scripts\utility::array_combine(var_4, common_scripts\utility::array_combine(var_6, var_7)));

  foreach(var_10 in var_8) {
    var_10 notify("deleted_through_script");
    var_10 delete();
  }
}

_id_6768() {
  common_scripts\utility::flag_wait("start_sandstorm_anims");
  wait 1;
  var_0 = thread switch_vehicle_path_lerp("high");
  var_1 = thread _id_676D("high");
  var_2 = thread _id_6782();
  var_3 = thread _id_6776();
  var_4 = thread _id_6775();
  var_5 = thread _id_6770();
  var_6 = thread _id_6772();
  var_3 = common_scripts\utility::array_combine(var_3, var_4);
  var_7 = thread _id_6786();
  common_scripts\utility::flag_wait("stop_sandstorm_anims");
  var_8 = common_scripts\utility::array_combine(var_5, common_scripts\utility::array_combine(var_1, common_scripts\utility::array_combine(var_0, var_2)));
  var_8 = common_scripts\utility::array_combine(var_8, common_scripts\utility::array_combine(var_6, common_scripts\utility::array_combine(var_3, var_7)));

  foreach(var_10 in var_8) {
    var_10 notify("deleted_through_script");
    var_10 delete();
  }
}

_id_6769() {
  common_scripts\utility::flag_wait("start_rescue_anims");
  wait 1;
  var_0 = thread switch_vehicle_path_lerp("rescue");
  var_1 = thread _id_676D("rescue");
  var_2 = thread _id_6777();
  var_3 = thread _id_6787();
  var_4 = thread switch_vehicle_path_lerp("end");
  var_5 = thread _id_676D("end");
  common_scripts\utility::flag_wait("stop_rescue_anims");
  var_6 = common_scripts\utility::array_combine(var_1, common_scripts\utility::array_combine(var_0, common_scripts\utility::array_combine(var_2, var_3)));

  foreach(var_8 in var_6) {
    var_8 notify("deleted_through_script");
    var_8 delete();
  }
}

_id_676A() {
  common_scripts\utility::flag_wait("start_pre_construction_anims");
  wait 1;
  var_0 = thread _id_677C();
  var_1 = thread _id_677A();
  common_scripts\utility::flag_wait("start_construction_anims");
  wait 2;

  foreach(var_3 in var_0) {
    var_3 notify("deleted_through_script");
    var_3 notify("stop_looping_anims");
  }

  var_0 = thread _id_677D();
  common_scripts\utility::flag_wait("stop_pre_construction_anims");
  var_5 = getEntArray("tree_low", "script_noteworthy");

  foreach(var_3 in var_5) {
    var_3 notify("deleted_through_script");
    var_3 delete();
  }

  common_scripts\utility::flag_wait("start_sandstorm_anims");

  foreach(var_3 in var_0) {
    if(isDefined(var_3)) {
      if(var_3.targetname == "jungle_tree" || var_3.targetname == "pine_tree") {
        var_3 notify("deleted_through_script");
        var_3 notify("stop_looping_anims");
      }
    }
  }

  var_0 = common_scripts\utility::array_combine(var_0, thread _id_677F());
  common_scripts\utility::flag_wait("stop_construction_anims");
  var_5 = getEntArray("tree_med", "script_noteworthy");
  var_5 = common_scripts\utility::array_combine(var_5, getEntArray("tree_med_need_in_intro", "script_noteworthy"));

  foreach(var_3 in var_5) {
    var_3 notify("deleted_through_script");
    var_3 delete();
  }

  common_scripts\utility::flag_wait("start_rescue_anims");
  wait 1;
  var_0 = thread _id_677D();
  var_0 = common_scripts\utility::array_combine(var_0, thread _id_677F());
  common_scripts\utility::flag_wait("stop_sandstorm_anims");
  var_5 = getEntArray("tree_heavy", "script_noteworthy");

  foreach(var_3 in var_5) {
    var_3 notify("deleted_through_script");
    var_3 delete();
  }

  common_scripts\utility::flag_wait("stop_rescue_anims");

  foreach(var_3 in var_0) {
    if(isDefined(var_3)) {
      var_3 notify("deleted_through_script");
      var_3 delete();
    }
  }
}

start_anim_on_object(var_0, var_1, var_2) {
  self endon("deleted_through_script");

  if(isDefined(var_2)) {
    wait(var_2);
  }
  self.animname = var_0;
  self useanimtree(level.scr_animtree[self.animname]);
  self setanimrestart(level.scr_anim[self.animname][var_1][0], 1, 0, 1);
}

switch_vehicle_path_lerp(var_0) {
  var_1 = getEntArray("moving_grass_" + var_0, "targetname");

  foreach(var_3 in var_1) {}
  var_3 thread start_anim_on_object("payback_sstorm_grass", "light_sway", randomfloatrange(0.0, 1.5));

  var_5 = getEntArray("moving_grass_01_" + var_0, "targetname");

  foreach(var_3 in var_5) {}
  var_3 thread start_anim_on_object("payback_sstorm_grass", "strong_sway_1", randomfloatrange(0.0, 1.5));

  var_8 = getEntArray("moving_grass_02_" + var_0, "targetname");

  foreach(var_3 in var_8) {}
  var_3 thread start_anim_on_object("payback_sstorm_grass", "strong_sway_2", randomfloatrange(0.0, 1.5));

  var_11 = getEntArray("moving_grass_03_" + var_0, "targetname");

  foreach(var_3 in var_11) {}
  var_3 thread start_anim_on_object("payback_sstorm_grass", "strong_sway_3", randomfloatrange(0.0, 1.5));

  return common_scripts\utility::array_combine(var_5, common_scripts\utility::array_combine(var_8, common_scripts\utility::array_combine(var_11, var_1)));
}

_id_676D(var_0) {
  var_1 = getEntArray("moving_bushes_" + var_0, "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "compound_exit") {
      var_3 thread start_anim_on_object("payback_foliage_bush01", "light_sway", randomfloatrange(0.0, 1.5));
      continue;
    }

    var_4 = "strong_sway_" + randomintrange(1, 3);
    var_3 thread start_anim_on_object("payback_foliage_bush01", var_4, randomfloatrange(0.0, 1.5));
  }

  return var_1;
}

_id_676E(var_0) {
  var_1 = getEntArray("moving_flag_" + var_0, "targetname");

  foreach(var_3 in var_1) {}
  var_3 thread start_anim_on_object("highrise_fencetarp_08", "strong_sway", randomfloatrange(0.0, 1.5));

  var_5 = getEntArray("moving_square_flag_" + var_0, "targetname");

  foreach(var_3 in var_5) {}
  var_3 thread start_anim_on_object("com_square_flag", "strong_sway", randomfloatrange(0.0, 1.5));

  return common_scripts\utility::array_combine(var_1, var_5);
}

_id_676F() {
  var_0 = getEnt("construction_umbrella", "targetname");
  var_0 thread start_anim_on_object("umbrella", "heli_wind_far", randomfloatrange(0.0, 1.5));
  common_scripts\utility::flag_wait("stop_construction_anims");
  var_0 notify("deleted_through_script");
  var_0 delete();
  common_scripts\utility::flag_wait("start_rescue_anims");
  var_1 = getEnt("nikolai_umbrella", "targetname");
  var_1 thread start_anim_on_object("umbrella", "heli_wind_far", randomfloatrange(0.0, 1.5));
}

_id_6770() {
  var_0 = getEntArray("moving_sign_metal_l_high", "targetname");

  foreach(var_2 in var_0) {}
  var_2 thread start_anim_on_object("payback_sstorm_sign_metal", "strong_sway_l", randomfloatrange(0.0, 1.5));

  var_4 = getEntArray("moving_sign_metal_r_high", "targetname");

  foreach(var_2 in var_4) {}
  var_2 thread start_anim_on_object("payback_sstorm_sign_metal", "strong_sway_r", randomfloatrange(0.0, 1.5));

  var_7 = getEntArray("moving_sign_chain_l_high", "targetname");

  foreach(var_2 in var_7) {}
  var_2 thread start_anim_on_object("payback_sstorm_sign_chain", "strong_sway_l", randomfloatrange(0.0, 1.5));

  var_10 = getEntArray("moving_sign_chain_r_high", "targetname");

  foreach(var_2 in var_10) {}
  var_2 thread start_anim_on_object("payback_sstorm_sign_chain", "strong_sway_r", randomfloatrange(0.0, 1.5));

  return common_scripts\utility::array_combine(common_scripts\utility::array_combine(var_0, var_4), common_scripts\utility::array_combine(var_7, var_10));
}

_id_6771() {
  var_0 = getEntArray("moving_fence", "targetname");

  foreach(var_2 in var_0) {
    var_3 = "strong_sway_" + randomintrange(1, 3);
    var_2 thread start_anim_on_object("payback_sstorm_fence_chainlink", var_3, randomfloatrange(0.0, 1.5));
  }

  return var_0;
}

_id_6772() {
  var_0 = getEntArray("moving_fence_high", "targetname");

  foreach(var_2 in var_0) {
    var_3 = "strong_sway_" + randomintrange(1, 3);
    var_2 thread start_anim_on_object("payback_sstorm_fence_chainlink", var_3, randomfloatrange(0.0, 1.5));
  }

  return var_0;
}

_id_6773() {
  var_0 = getEntArray("payback_wires_wind_light", "script_noteworthy");
  var_1 = getEntArray("payback_wires_wind_medium", "script_noteworthy");
  var_2 = common_scripts\utility::array_combine(var_0, var_1);
  return waittill_ents_notified(var_2, "light");
}

_id_6774(var_0) {
  return waittill_ents_notified(var_0, "medium");
}

_id_6775() {
  return waittill_ents_notified(undefined, "heavy");
}

_id_6776() {
  return waittill_ents_notified(undefined, "extreme");
}

_id_6777() {
  return waittill_ents_notified(undefined, "rescue");
}

waittill_ents_notified(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = getEntArray("payback_wires_wind_" + var_1, "script_noteworthy");
  }
  var_2 = [];

  foreach(var_4 in var_0) {
    if(isDefined(var_4.targetname)) {
      if(var_4.targetname == "moving_wires_single") {
        var_4 thread start_anim_on_object("payback_wires_single", "strong_sway", randomfloatrange(0.0, 1.5));
        var_2[var_2.size] = var_4;
        continue;
      }

      if(var_4.targetname == "moving_wires_double") {
        var_4 thread start_anim_on_object("payback_wires_double", "strong_sway_" + var_1, randomfloatrange(0.0, 1.5));
        var_2[var_2.size] = var_4;
        continue;
      }

      if(var_4.targetname == "moving_wires_short") {
        var_5 = randomintrange(1, 3);
        var_6 = 0.0;

        if(isDefined(var_4.script_delay)) {
          var_6 = var_4.script_delay;
        }
        var_6 = randomfloatrange(var_6, var_6 + 0.25);
        var_4 thread start_anim_on_object("payback_wires_short", "wind_" + var_1 + "_" + var_5, var_6);
        var_2[var_2.size] = var_4;
        continue;
      }

      if(var_4.targetname == "moving_wires_long") {
        var_5 = randomintrange(1, 3);
        var_6 = 0.0;

        if(isDefined(var_4.script_delay)) {
          var_6 = var_4.script_delay;
        }
        var_6 = randomfloatrange(var_6, var_6 + 0.25);
        var_4 thread start_anim_on_object("payback_wires_long", "wind_" + var_1 + "_" + var_5, var_6);
        var_2[var_2.size] = var_4;
      }
    }
  }

  return var_2;
}

_id_6779() {
  var_0 = getEntArray("shack_moving_roof", "targetname");

  foreach(var_2 in var_0) {}
  var_2 thread start_anim_on_object("payback_shack", "strong_sway", randomfloatrange(0.0, 1.5));

  return var_0;
}

_id_677A() {
  var_0 = getEntArray("moving_antenna_low", "targetname");

  foreach(var_2 in var_0) {}
  level thread _id_677B(var_2, 1);

  var_4 = getEntArray("moving_antenna", "targetname");

  foreach(var_2 in var_4) {}
  level thread _id_677B(var_2, 0);
}

_id_677B(var_0, var_1) {
  var_2 = spawn("script_model", var_0.origin);
  var_2.angles = var_0.angles;
  var_2 setModel("generic_prop_raven");
  var_2.animname = "sstorm_antenna";
  var_2 maps\_anim::setanimtree();
  var_2 attach(var_0.model, "J_prop_1");
  var_2 thread start_anim_on_object("sstorm_antenna", "light_sway", randomfloatrange(0.0, 3.0));
  var_0 delete();
  common_scripts\utility::flag_wait("start_construction_anims");
  var_2 notify("deleted_through_script");
  var_2 notify("stop_looping_anims");

  if(var_1) {
    var_2 delete();
  } else {
    var_2 thread start_anim_on_object("sstorm_antenna", "strong_sway", randomfloatrange(0.0, 3.0));
    common_scripts\utility::flag_wait("stop_rescue_anims");
    var_2 delete();
  }
}

_id_677C() {
  var_0 = getEntArray("moving_tree", "targetname");

  foreach(var_2 in var_0) {}
  var_2 thread start_anim_on_object("foliage_tree_palm_med_1", "light_sway", randomfloatrange(0.0, 3.0));

  var_4 = getEntArray("moving_bushy_tree_extreme", "targetname");

  foreach(var_2 in var_4) {}
  var_2 thread start_anim_on_object("foliage_tree_palm_bushy_3", "med_sway", randomfloatrange(0.0, 3.0));

  var_7 = getEntArray("jungle_tree", "targetname");

  foreach(var_2 in var_7) {
    var_9 = "wind_med_" + randomintrange(1, 3);
    var_2 thread start_anim_on_object("foliage_tree_jungle", var_9, randomfloatrange(0.0, 3.0));
  }

  var_11 = getEntArray("pine_tree", "targetname");

  foreach(var_2 in var_11) {
    var_9 = "wind_light_" + randomintrange(1, 3);
    var_2 thread start_anim_on_object("foliage_tree_pine", var_9, randomfloatrange(0.0, 3.0));
  }

  var_14 = getEntArray("palm_tree", "targetname");

  foreach(var_2 in var_14) {}
  var_2 thread start_anim_on_object("dwarf_palm", "wind_light", randomfloatrange(0.0, 3.0));

  return common_scripts\utility::array_combine(var_0, common_scripts\utility::array_combine(var_4, common_scripts\utility::array_combine(var_7, common_scripts\utility::array_combine(var_11, var_14))));
}

_id_677D() {
  var_0 = getEntArray("moving_tree", "targetname");

  foreach(var_2 in var_0) {}
  var_2 thread _id_677E("foliage_tree_palm_med_1", "strong_sway", randomfloatrange(0.0, 3.0));

  var_4 = getEntArray("moving_bushy_tree_extreme", "targetname");

  foreach(var_2 in var_4) {}
  var_2 thread _id_677E("foliage_tree_palm_bushy_3", "strong_sway", randomfloatrange(0.0, 3.0));

  var_7 = getEntArray("jungle_tree", "targetname");

  foreach(var_2 in var_7) {
    var_9 = "wind_med_" + randomintrange(1, 3);
    var_2 thread _id_677E("foliage_tree_jungle", var_9, randomfloatrange(0.0, 3.0));
  }

  var_11 = getEntArray("pine_tree", "targetname");

  foreach(var_2 in var_11) {
    var_9 = "wind_med_" + randomintrange(1, 3);
    var_2 thread _id_677E("foliage_tree_pine", var_9, randomfloatrange(0.0, 3.0));
  }

  var_14 = getEntArray("palm_tree", "targetname");

  foreach(var_2 in var_14) {}
  var_2 thread _id_677E("dwarf_palm", "wind_med", randomfloatrange(0.0, 3.0));

  return common_scripts\utility::array_combine(var_0, common_scripts\utility::array_combine(var_4, common_scripts\utility::array_combine(var_7, common_scripts\utility::array_combine(var_11, var_14))));
}

_id_677E(var_0, var_1, var_2) {
  self endon("deleted_through_script");
  wait(var_2);
  var_3 = 0;

  while(!var_3) {
    if(!maps\_utility::within_fov_2d(level.player.origin, level.player.angles, self.origin, cos(45))) {
      var_3 = 1;
      continue;
    }

    wait 0.1;
  }

  self.animname = var_0;
  self useanimtree(level.scr_animtree[self.animname]);
  self setanimrestart(level.scr_anim[self.animname][var_1][0], 1, 0, 1);
}

_id_677F() {
  var_0 = getEntArray("jungle_tree", "targetname");

  foreach(var_2 in var_0) {
    var_3 = "wind_heavy_" + randomintrange(1, 3);
    var_2 thread start_anim_on_object("foliage_tree_jungle", var_3, randomfloatrange(0.0, 3.0));
  }

  var_5 = getEntArray("pine_tree", "targetname");

  foreach(var_2 in var_5) {
    var_3 = "wind_heavy_" + randomintrange(1, 3);
    var_2 thread start_anim_on_object("foliage_tree_pine", var_3, randomfloatrange(0.0, 3.0));
  }

  return common_scripts\utility::array_combine(var_0, var_5);
}

_id_6780() {
  var_0 = getEntArray("moving_tarp_03_low", "targetname");

  foreach(var_2 in var_0) {}
  var_2 thread start_anim_on_object("highrise_fencetarp_03", "light_sway", randomfloatrange(0.0, 2.0));

  return var_0;
}

_id_6781() {
  var_0 = getEntArray("moving_tarp_01", "targetname");

  foreach(var_2 in var_0) {}
  var_2 thread _id_6789();

  var_4 = getEntArray("moving_tarp_03", "targetname");

  foreach(var_2 in var_4) {
    var_6 = "strong_sway_" + randomintrange(1, 3);
    var_2 thread start_anim_on_object("highrise_fencetarp_03", var_6, randomfloatrange(0.0, 2.0));
  }

  return common_scripts\utility::array_combine(var_0, var_4);
}

_id_6782() {
  var_0 = getEntArray("moving_tarp_03_high", "targetname");

  foreach(var_2 in var_0) {
    var_3 = "strong_sway_" + randomintrange(1, 3);
    var_2 thread start_anim_on_object("highrise_fencetarp_03", var_3, randomfloatrange(0.0, 2.0));
  }

  return var_0;
}

get_key(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");

  foreach(var_4 in var_2) {}
  var_4 thread start_anim_on_object("tarp_crate", var_1, randomfloatrange(0, 2));

  return var_2;
}

_id_6784() {
  return get_key("crate_with_tarp_low_wind", "payback_tarp_crate_light_wind");
}

_id_6785() {
  return get_key("crate_with_tarp_med_wind", "payback_tarp_crate_heavy_wind");
}

_id_6786() {
  return get_key("crate_with_tarp_high_wind", "payback_tarp_crate_heavy_wind");
}

_id_6787() {
  return get_key("crate_with_tarp_rescue_wind", "payback_tarp_crate_heavy_wind");
}

_id_6788() {
  var_0 = getEntArray("laundry_sheet", "targetname");

  foreach(var_2 in var_0) {}
  var_2 thread start_anim_on_object("hanging_sheet", "wind_medium", randomfloatrange(0.0, 3.0));

  var_4 = getEntArray("laundry_short_sleeve", "targetname");

  foreach(var_6 in var_4) {}
  var_6 thread start_anim_on_object("hanging_short_sleeve", "wind_medium", randomfloatrange(0.0, 3.0));

  var_8 = getEntArray("laundry_long_sleeve", "targetname");

  foreach(var_10 in var_8) {}
  var_10 thread start_anim_on_object("hanging_long_sleeve", "wind_medium", randomfloatrange(0.0, 3.0));

  var_12 = getEntArray("laundry_apron", "targetname");

  foreach(var_14 in var_12) {}
  var_14 thread start_anim_on_object("hanging_apron", "wind_medium", randomfloatrange(0.0, 3.0));

  return common_scripts\utility::array_combine(var_0, common_scripts\utility::array_combine(var_4, common_scripts\utility::array_combine(var_8, var_12)));
}

_id_6789() {
  thread start_anim_on_object("highrise_fencetarp_01", "strong_sway_initial_loop", randomfloatrange(0.0, 2.0));
  common_scripts\utility::flag_wait("start_tarp_rip");
  self notify("stop_looping_anims");
  self notify("deleted_through_script");

  if(isDefined(self)) {
    self.animname = "highrise_fencetarp_01";
    self useanimtree(level.scr_animtree[self.animname]);
    maps\_anim::anim_single_solo(self, "strong_sway_tear");
    thread maps\_anim::anim_loop_solo(self, "strong_sway_final_loop", "stop_looping_anims");
  }
}

_id_678A() {
  var_0 = common_scripts\utility::getStruct("gate_origin", "targetname");
  var_1 = "gate_loop_closed";
  var_2 = "gate_loop_closed_single";
  var_3 = getEnt("wind_gate_left", "targetname");
  var_4 = getEnt("wind_gate_right", "targetname");

  if(isDefined(var_3) && isDefined(var_4)) {
    var_3 delete();
    var_4 delete();
    var_5 = getEnt("gate_rig", "targetname");
    thread _id_678B(var_0, var_2, var_1, var_5);
    thread set_key(var_5, var_0);
  }

  var_0 = common_scripts\utility::getStruct("sandstorm_gates_2", "targetname");

  if(isDefined(var_0)) {
    var_1 = "gate_loop_2";
    var_2 = "gate_loop_2_single";
    var_5 = getEnt("gate_rig_2", "targetname");
    thread _id_678B(var_0, var_2, var_1, var_5);
    thread set_key(var_5, var_0);
  }
}

_id_678B(var_0, var_1, var_2, var_3) {
  var_3.animname = "sstorm_gate";
  var_3 maps\_anim::setanimtree();
  var_3 attach("pb_gate_wall_alt", "J_prop_1");
  var_3 attach("pb_gate_wall_alt", "J_prop_2");
  var_0 thread maps\_anim::anim_first_frame_solo(var_3, var_1);
  common_scripts\utility::flag_wait("start_sandstorm_anims");
  var_0 thread maps\_anim::anim_loop_solo(var_3, var_2, "stop_gate_loop");
  common_scripts\utility::flag_wait("stop_sandstorm_anims");
  var_0 notify("stop_gate_loop");
  waittillframeend;
  var_3 delete();
}

set_key(var_0, var_1) {
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel("generic_prop_raven");
  var_2.animname = "sstorm_gate_chain";
  var_2 maps\_anim::setanimtree();
  var_2 attach("pb_gate_chain", "J_prop_1");

  if(var_0 == getEnt("gate_rig", "targetname")) {
    var_3 = "chain_windy_loop_closed_single";
    var_4 = "chain_windy_loop_closed";
    var_5 = "gate_1_stop";
    thread maps\payback_streets_const::gate_chain(var_2, var_1);
  } else {
    var_3 = "chain_windy_2_single";
    var_4 = "chain_windy_2_loop";
    var_5 = "gate_2_stop";
  }

  var_1 thread maps\_anim::anim_first_frame_solo(var_2, var_3);
  common_scripts\utility::flag_wait("start_sandstorm_anims");
  var_1 thread maps\_anim::anim_loop_solo(var_2, var_4, var_5);
  common_scripts\utility::flag_wait("stop_sandstorm_anims");
  var_2 delete();
}

_id_678D() {
  var_0 = getEntArray("rolling_barrel_trigger", "targetname");

  foreach(var_2 in var_0) {}
  var_2 thread lookat_player("sstorm_barrel", "com_barrel_green_dirt", 0);

  var_4 = getEntArray("rolling_bucket_trigger", "targetname");

  foreach(var_2 in var_4) {}
  var_2 thread lookat_player("sstorm_bucket", "com_plastic_bucket_empty", 1);

  var_7 = getEntArray("rolling_bush_trigger", "targetname");

  foreach(var_2 in var_7) {}
  var_2 thread lookat_player("sstorm_bush", "", 1);

  var_10 = getEntArray("rolling_chicken_coop_trigger", "targetname");

  foreach(var_2 in var_10) {}
  var_2 thread _id_6793();
}

_id_678E() {
  level._id_678F = (-1.0 * cos(getnorthyaw()), -1.0 * sin(getnorthyaw()), 0);
  var_0 = getEntArray("payback_impulse_trigger", "targetname");

  foreach(var_2 in var_0) {}
  var_2 thread _id_6790();
}

_id_6790() {
  self waittill("trigger");
  var_0 = getEntArray(self.target, "targetname");

  foreach(var_2 in var_0) {
    var_3 = 50;

    if(isDefined(var_2.script_parameters)) {
      var_3 = float(var_2.script_parameters);
    }
    var_4 = (1, 0, 0);

    if(isDefined(var_2.angles)) {
      var_4 = anglesToForward(var_2.angles);
    } else {
      var_4 = level._id_678F;
    }
    var_5 = var_4 * var_3;
    var_2 physicslaunchserver(var_2.origin, var_5);
  }
}

lookat_player(var_0, var_1, var_2) {
  self waittill("trigger");
  var_3 = undefined;
  var_4 = undefined;
  var_5 = common_scripts\utility::getStruct(self.target, "targetname");

  if(!isDefined(var_5)) {
    var_3 = getEnt(self.target, "targetname");
    var_5 = common_scripts\utility::getStruct(var_3.target, "targetname");
  }

  var_6 = common_scripts\utility::getStruct(var_5.target, "targetname");
  var_7 = spawn("script_origin", var_5.origin);

  if(isDefined(var_3)) {
    var_3.animname = var_0;
    var_3 maps\_anim::setanimtree();
    var_3.origin = var_5.origin;

    if(isDefined(var_5.angles)) {
      var_3.angles = var_5.angles;
    }
    var_4 = var_3;
  } else {
    var_4 = spawn("script_model", var_5.origin);
    var_4 setModel("generic_prop_raven");
    var_4.animname = var_0;
    var_4 maps\_anim::setanimtree();

    if(isDefined(var_5.angles)) {
      var_4.angles = var_5.angles;
    }
    var_4 attach(var_1, "J_prop_1");

    if(var_4.animname == "sstorm_barrel") {
      var_8 = getEntArray("rolling_barrel_clip", "targetname");

      foreach(var_10 in var_8) {
        var_11 = distance(var_10.origin, var_5.origin);

        if(var_11 <= 50) {
          var_10 solid();
          var_10 linkTo(var_4);
        }
      }
    }
  }

  var_4 linkTo(var_7);
  var_4 thread maps\_anim::anim_loop_solo(var_4, "roll_loop");

  if(var_4.animname == "sstorm_barrel") {
    var_4._id_6792 = "pybk_rolling_barrel";
    var_4 playLoopSound(var_4._id_6792);
  } else if(var_4.animname == "sstorm_bucket") {
    var_4._id_6792 = "pybk_rolling_bucket";
    var_4 playLoopSound(var_4._id_6792);
  } else if(var_4.animname == "sstorm_bush") {
    var_4._id_6792 = "pybk_rolling_bush";
    var_4 playLoopSound(var_4._id_6792);
  } else {
    iprintlnbold("rolling_object_trigger() model '" + var_4.animname + "' with no soundalias defined! please contact audio department with asset request!");
  }
  var_13 = var_5;

  for(var_14 = 0; isDefined(var_13.target); var_13 = var_15) {
    var_15 = common_scripts\utility::getStruct(var_13.target, "targetname");
    var_16 = distance(var_13.origin, var_15.origin);
    var_17 = var_16 / 12;
    var_18 = var_17 / var_13.speed;
    var_7 moveTo(var_15.origin, var_18);
    wait(var_18);
    var_14 = var_14 + var_18;
  }

  var_4 stopanimScripted();
  var_4 notify("stop_loop");

  if(var_2) {
    var_4 thread maps\_anim::anim_loop_solo(var_4, "roll_stop_loop");
  } else {
    var_19 = getanimlength(level.scr_anim[var_0]["roll_loop"][0]);
    var_20 = var_14 / var_19;
    var_21 = var_20 - int(var_20);
    var_4 setanimknob(level.scr_anim[var_0]["roll_loop"][0], 1, 0, 0);
    var_4 setanimtime(level.scr_anim[var_0]["roll_loop"][0], var_21);
  }

  var_4 stoploopsound();
  var_4 thread _id_6794();
  var_7 delete();
  self delete();
}

_id_6793() {
  self waittill("trigger");
  var_0 = common_scripts\utility::getStruct(self.target, "targetname");
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("generic_prop_raven");
  var_1.animname = "sstorm_chicken_coop";
  var_1 maps\_anim::setanimtree();
  var_1.angles = var_0.angles;
  var_2 = spawn("script_model", var_1 gettagorigin("J_prop_1"));
  var_2 setModel("me_wood_cage_large");
  var_2.angles = var_1 gettagangles("J_prop_1");
  var_3 = spawn("script_model", var_1 gettagorigin("J_prop_2"));
  var_3 setModel("chicken_black_white");
  var_3.angles = var_1 gettagangles("J_prop_2");
  var_3.animname = "sstorm_chicken";
  var_3 maps\_anim::setanimtree();
  var_2 linkTo(var_1, "J_prop_1");
  var_3 linkTo(var_1, "J_prop_2");
  var_1 thread maps\_anim::anim_single_solo(var_1, "roll_loop");

  for(;;) {
    var_3 maps\_anim::anim_single_solo(var_3, "chicken_loop_01");
    var_3 maps\_anim::anim_single_solo(var_3, "chicken_loop_02");
  }
}

_id_6794() {
  self endon("deleted");

  while(isDefined(self)) {
    var_0 = distance(level.player.origin, self.origin);

    if(var_0 > 2000) {
      self delete();
      self notify("deleted");
    }

    wait 1.0;
  }
}