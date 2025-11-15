/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_geo_mover.gsc
*****************************************************/

trigger_moveto(var_0) {
  if(!isDefined(level.mover_candidates)) {
    level.mover_candidates = getEntArray("script_brushmodel", "classname");
    level.mover_candidates = common_scripts\utility::array_combine(level.mover_candidates, getEntArray("script_model", "classname"));
    level.mover_object = common_scripts\utility::spawn_tag_origin();
  }

  var_1 = getEntArray(self.target, "targetname");
  common_scripts\utility::array_thread(var_1, ::moveto_volume_think, self);
}

moveto_volume_think(var_0) {
  var_1 = [];
  var_2 = self;

  foreach(var_4 in level.mover_candidates) {
    level.mover_object.origin = var_4.origin;

    if(level.mover_object istouching(var_2)) {
      level.mover_candidates = common_scripts\utility::array_remove(level.mover_candidates, var_4);
      var_1 = common_scripts\utility::array_add(var_1, var_4);
    }
  }

  var_6 = undefined;

  foreach(var_4 in var_1) {
    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "mover" || isDefined(var_4.targetname) && var_4.targetname == "mover") {
      var_6 = var_4;
      break;
    }
  }

  foreach(var_4 in var_1) {
    if(var_6 != var_4)
      var_4 linkto(var_6);
  }

  var_11 = common_scripts\utility::get_target_ent();

  if(!isDefined(var_11.angles))
    var_11.angles = (0, 0, 0);

  var_0.mover = var_6;
  var_6.origin = var_11.origin;
  var_6.angles = var_11.angles;
  var_12 = undefined;
  var_13 = 5;
  var_14 = 0;
  var_15 = 0;

  if(isDefined(var_11.script_duration))
    var_13 = var_11.script_duration;

  if(isDefined(var_11.script_accel))
    var_14 = var_11.script_accel;

  if(isDefined(var_11.script_decel))
    var_15 = var_11.script_decel;

  if(isDefined(var_11.script_earthquake))
    var_12 = var_11.script_earthquake;

  var_0 waittill("trigger");
  var_11 maps\_utility::script_delay();

  if(isDefined(var_11.target))
    var_11 = var_11 common_scripts\utility::get_target_ent();
  else
    var_11 = undefined;

  while(isDefined(var_11)) {
    if(isDefined(var_12)) {
      if(issubstr(var_12, "constant"))
        var_6 thread constant_quake(var_12);
    }

    if(!isDefined(var_11.angles))
      var_11.angles = (0, 0, 0);

    var_6 moveto_rotateto(var_11, var_13, var_14, var_15);
    var_6 notify("stop_constant_quake");
    var_13 = 5;
    var_14 = 0;
    var_15 = 0;
    var_12 = undefined;
    var_11 maps\_utility::script_delay();

    if(isDefined(var_11.script_duration))
      var_13 = var_11.script_duration;

    if(isDefined(var_11.script_accel))
      var_14 = var_11.script_accel;

    if(isDefined(var_11.script_decel))
      var_15 = var_11.script_decel;

    if(isDefined(var_11.script_earthquake))
      var_12 = var_11.script_earthquake;

    var_16 = var_11 common_scripts\utility::get_linked_ents();

    if(var_16.size > 0) {
      if(issubstr(var_16[0].classname, "trigger"))
        var_16[0] waittill("trigger");
    }

    if(isDefined(var_11.target)) {
      var_11 = var_11 common_scripts\utility::get_target_ent();
      continue;
    }

    var_11 = undefined;
  }

  self notify("done_moving");
}

constant_quake(var_0) {
  self endon("stop_constant_quake");

  for(;;) {
    thread common_scripts\utility::do_earthquake(var_0, self.origin);
    wait(randomfloatrange(0.1, 0.2));
  }
}

moveto_rotateto_speed(var_0, var_1, var_2, var_3) {
  var_4 = var_0.origin;
  var_5 = self.origin;
  var_6 = distance(var_5, var_4);
  var_7 = var_6 / var_1;

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  self rotateto(var_0.angles, var_7, var_7 * var_2, var_7 * var_3);
  self moveto(var_4, var_7, var_7 * var_2, var_7 * var_3);
  self waittill("movedone");
}

moveto_rotateto(var_0, var_1, var_2, var_3) {
  self moveto(var_0.origin, var_1, var_2, var_3);
  self rotateto(var_0.angles, var_1, var_2, var_3);
  self waittill("movedone");
}

set_start_positions(var_0) {
  var_1 = common_scripts\utility::getstructarray(var_0, "targetname");

  foreach(var_3 in var_1) {
    switch (var_3.script_noteworthy) {
      case "player":
        level.player setorigin(var_3.origin);
        level.player setplayerangles(var_3.angles);
        break;
    }
  }
}