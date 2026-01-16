/***************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: vehicle_scripts\_littlebird_landing.gsc
***************************************************/

init_littlebird_landing() {
  if(isdefined(level.little_bird_landing_init)) {
    return;
  }
  level.little_bird_landing_init = 1;
  thread init_littlebird_landing_thread();
}

init_littlebird_landing_thread() {
  waittillframeend;
  common_scripts\utility::array_thread(common_scripts\utility::getstructarray("gag_stage_littlebird_unload", "script_noteworthy"), ::setup_gag_stage_littlebird_unload);
  common_scripts\utility::array_thread(common_scripts\utility::getstructarray("gag_stage_littlebird_load", "script_noteworthy"), ::setup_gag_stage_littlebird_load);
}

littlebird_landing() {
  self endon("death");
  maps\_utility::ent_flag_init("prep_unload");
  maps\_utility::ent_flag_wait("prep_unload");
  maps\_vehicle_code::turn_unloading_drones_to_ai();
  var_0 = get_landing_node();
  var_0 littlebird_lands_and_unloads(self);
  maps\_vehicle::vehicle_paths(var_0);
}

stage_guy(var_0, var_1, var_2, var_3) {
  var_4 = "stage_littlebird_" + var_1;
  var_5 = [];
  var_5[0] = var_0;
  var_3 maps\_anim::anim_generic_reach(var_5[0], var_4, "tag_detach_" + var_1);
  var_3 maps\_anim::anim_generic(var_5[0], var_4, "tag_detach_" + var_1);
  maps\_utility::ent_flag_set("staged_guy_" + var_1);
  var_0 setgoalpos(common_scripts\utility::drop_to_ground(var_0.origin));
  var_0.goalradius = 16;
  maps\_utility::ent_flag_wait("guy2_in_" + var_1);
  thread maps\_vehicle_aianim::load_ai([var_0], undefined, var_1);
}

setup_gag_stage_littlebird_unload() {
  for (;;) {
    self waittill("trigger", var_0);
    littlebird_lands_and_unloads(var_0);
  }
}

setup_gag_stage_littlebird_load() {
  for (;;) {
    self waittill("trigger", var_0);
    var_0 setdeceleration(6);
    var_0 setacceleration(4);
    var_0 settargetyaw(self.angles[1]);
    var_0 vehicle_setspeed(20, 7, 7);

    while (distance(common_scripts\utility::flat_origin(var_0.origin), common_scripts\utility::flat_origin(self.origin)) > 256)
      wait 0.05;

    var_0 endon("death");
    var_0 thread vehicle_land_beneath_node(220, self);
    var_0 waittill("near_goal");
    var_0 vehicle_setspeed(20, 22, 7);
    var_0 thread vehicle_land_beneath_node(16, self);
    var_0 waittill("near_goal");
    var_0 maps\_vehicle_code::waittill_stable();
    var_0 notify("touch_down", self);
    var_0 vehicle_setspeed(20, 8, 7);
  }
}

littlebird_lands_and_unloads(var_0) {
  var_0 setdeceleration(6);
  var_0 setacceleration(4);
  var_0 settargetyaw(self.angles[1]);
  var_0 vehicle_setspeed(20, 7, 7);

  while (distance(common_scripts\utility::flat_origin(var_0.origin), common_scripts\utility::flat_origin(self.origin)) > 512)
    wait 0.05;

  var_0 endon("death");
  var_1 = "landing" + randomint(99999);
  badplace_cylinder(var_1, 30, self.origin, 200, 300, "axis", "allies", "neutral", "team3");
  var_0 thread vehicle_land_beneath_node(424, self);
  var_0 waittill("near_goal");
  badplace_delete(var_1);
  badplace_cylinder(var_1, 30, self.origin, 200, 300, "axis", "allies", "neutral", "team3");
  var_0 notify("groupedanimevent", "pre_unload");
  var_0 thread maps\_vehicle_aianim::animate_guys("pre_unload");
  var_0 vehicle_setspeed(20, 22, 7);
  var_0 notify("nearing_landing");

  if(isdefined(var_0.custom_landing)) {
    switch (var_0.custom_landing) {
      case "hover_then_land":
        var_0 vehicle_setspeed(10, 22, 7);
        var_0 thread vehicle_land_beneath_node(32, self, 64);
        var_0 waittill("near_goal");
        var_0 notify("hovering");
        wait 1;
        break;
      default:
        break;
    }
  }

  var_0 thread vehicle_land_beneath_node(16, self);
  var_0 waittill("near_goal");
  badplace_delete(var_1);
  maps\_utility::script_delay();
  var_0 maps\_vehicle::vehicle_unload();
  var_0 maps\_vehicle_code::waittill_stable();
  var_0 vehicle_setspeed(20, 8, 7);
  wait 0.2;
  var_0 notify("stable_for_unlink");
  wait 0.2;

  if(isdefined(self.script_flag_set))
    common_scripts\utility::flag_set(self.script_flag_set);

  if(isdefined(self.script_flag_wait))
    common_scripts\utility::flag_wait(self.script_flag_wait);

  var_0 notify("littlebird_liftoff");
}

set_stage(var_0, var_1, var_2) {
  if(!maps\_utility::ent_flag_exist("staged_guy_" + var_2))
    maps\_utility::ent_flag_init("staged_guy_" + var_2);
  else
    maps\_utility::ent_flag_clear("staged_guy_" + var_2);

  if(!maps\_utility::ent_flag_exist("guy2_in_" + var_2))
    maps\_utility::ent_flag_init("guy2_in_" + var_2);
  else
    maps\_utility::ent_flag_clear("guy2_in_" + var_2);

  var_3 = get_stage_nodes(var_0, var_2);
  var_4 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_5 = spawn("script_model", (0, 0, 0));
  var_5 setmodel(self.model);

  if(isdefined(self.new_stage_heli_spawn))
    var_5.origin = self.origin;
  else
    var_5.origin = common_scripts\utility::drop_to_ground(var_4.origin) + (0, 0, self.originheightoffset);

  var_5.angles = var_4.angles;
  var_5 hide();
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;

  foreach(var_10 in var_3) {
    var_11 = undefined;

    foreach(var_13 in var_1) {
      if(isdefined(var_13.script_startingposition) && var_13.script_startingposition == var_10.script_startingposition) {
        var_11 = var_13;
        break;
      }
    }

    if(!isdefined(var_11))
      var_11 = common_scripts\utility::getclosest(var_10.origin, var_1);

    var_11.script_startingposition = var_10.script_startingposition;

    if(var_11.script_startingposition == 2 || var_11.script_startingposition == 5) {
      var_6 = var_11;
      var_11 maps\_spawner::go_to_node_set_goal_node(var_10);
    } else if(var_11.script_startingposition == 3 || var_11.script_startingposition == 6)
      var_8 = var_11;
    else if(var_11.script_startingposition == 4 || var_11.script_startingposition == 7) {
      var_7 = var_11;
      var_11 maps\_spawner::go_to_node_set_goal_node(var_10);
    }

    var_1 = common_scripts\utility::array_remove(var_1, var_11);
  }

  thread stage_guy(var_8, var_2, var_7, var_5);
  thread common_scripts\utility::delete_on_death(var_5);
}

get_stage_nodes(var_0, var_1) {
  var_2 = getnodearray(var_0.target, "targetname");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(var_5.script_noteworthy == "stage_" + var_1)
      var_3[var_3.size] = var_5;
  }

  return var_3;
}

get_landing_node() {
  var_0 = self.currentnode;

  for (;;) {
    var_1 = maps\_utility::getent_or_struct(var_0.target, "targetname");

    if(isdefined(var_1.script_unload))
      return var_1;

    var_0 = var_1;
  }
}

load_side(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in var_1) {
    if(var_6.script_startingposition == 2 || var_6.script_startingposition == 5) {
      var_2 = var_6;
      continue;
    }

    if(var_6.script_startingposition == 3 || var_6.script_startingposition == 6) {
      var_4 = var_6;
      continue;
    }

    if(var_6.script_startingposition == 4 || var_6.script_startingposition == 7)
      var_3 = var_6;
  }

  maps\_utility::ent_flag_wait("staged_guy_" + var_0);
  thread maps\_vehicle::vehicle_load_ai_single(var_2, undefined, var_0);
  var_2 waittill("boarding_vehicle");
  thread maps\_vehicle::vehicle_load_ai_single(var_3, undefined, var_0);
  var_3 waittill("boarding_vehicle");
  maps\_utility::ent_flag_set("guy2_in_" + var_0);
}

vehicle_land_beneath_node(var_0, var_1, var_2) {
  if(!isdefined(var_2))
    var_2 = 0;

  self notify("newpath");

  if(!isdefined(var_0))
    var_0 = 2;

  self setneargoalnotifydist(var_0);
  self sethoverparams(0, 0, 0);
  self cleargoalyaw();
  self settargetyaw(common_scripts\utility::flat_angle(var_1.angles)[1]);
  maps\_vehicle_code::_setvehgoalpos_wrap(maps\_utility::groundpos(var_1.origin) + (0, 0, var_2), 1);
  self waittill("goal");
}