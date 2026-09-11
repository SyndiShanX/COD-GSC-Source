/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\geo_mover.gsc
***********************************************/

function init_mover_candidates() {
  level.mover_candidates = undefined;
}

function trigger_moveTo(var0) {
  if(!isDefined(level.mover_candidates)) {
    level.mover_candidates = getEntArray("script_brushmodel", "classname");
    level.mover_candidates = scripts\engine\utility::array_combine(level.mover_candidates, getEntArray("script_model", "classname"));
  }

  var1 = getEntArray(var0.target, "targetname");
  scripts\engine\utility::array_thread(var1, &moveto_volume_think, var0);
}

function moveto_volume_think(var0) {
  var1 = [];
  var2 = scripts\engine\utility::spawn_tag_origin();
  var3 = self;

  foreach(var5 in level.mover_candidates) {
    var2.origin = var5.origin;

    if(var2 istouching(var3)) {
      level.mover_candidates = scripts\engine\utility::array_remove(level.mover_candidates, var5);
      var1 = scripts\engine\utility::array_add(var1, var5);
    }
  }

  var2 delete();
  var7 = undefined;

  foreach(var5 in var1) {
    if(isDefined(var5.script_parameters) && var5.script_parameters == "mover") {
      var7 = var5;
      break;
    }

    if(isDefined(var5.script_parent) && var5.script_parent == "mover") {
      var7 = var5;
      break;
    }
  }

  foreach(var5 in var1) {
    if(var7 != var5) {
      var5 linkTo(var7);
    }
  }

  var15 = scripts\engine\utility::get_target_ent();

  if(var15 scripts\common\vehicle::isvehicle()) {
    moveto_volume_vehiclespline(var7, var15, var0);
    self notify("done_moving");
    return;
  }

  if(!isDefined(var15.angles)) {
    var15.angles = (0, 0, 0);
  }

  var0.mover = var7;
  var7.origin = var15.origin;
  var7.angles = var15.angles;
  var16 = undefined;
  var17 = undefined;
  var18 = 5;
  var19 = 0;
  var20 = 0;
  var21 = undefined;

  if(isDefined(var15.script_duration)) {
    var18 = var15.script_duration;
  }

  if(isDefined(var15.script_accel)) {
    var19 = var15.script_accel;
  }

  if(isDefined(var15.script_decel)) {
    var20 = var15.script_decel;
  }

  if(isDefined(var15.script_earthquake)) {
    var16 = var15.script_earthquake;
  }

  if(isDefined(var15.script_exploder)) {
    var17 = var15.script_exploder;
  }

  if(isDefined(var15.script_flag_wait)) {
    var21 = var15.script_flag_wait;
  }

  var0 waittill("trigger");
  var15 scripts\engine\utility::script_delay();

  if(isDefined(var15.target)) {
    var15 = var15 scripts\engine\utility::get_target_ent();
    goto LOC_00000220;
  }

  for(var15 = undefined; isDefined(var15); var15 = undefined) {
    if(isDefined(var21)) {
      scripts\engine\utility::flag_wait(var21);
    }

    if(isDefined(var17)) {
      scripts\engine\utility::exploder(var17);
      level notify("geo_mover_exploder", var17);
    } else if(isDefined(var16)) {
      if(issubstr(var16, "constant")) {
        thread constant_quake(var7);
      }
    }

    if(!isDefined(var15.angles)) {
      var15.angles = (0, 0, 0);
    }

    moveto_rotateTo(var7, var15, var18, var19, var20);
    var7 notify("stop_constant_quake");
    var18 = 5;
    var19 = 0;
    var20 = 0;
    var16 = undefined;
    var15 scripts\engine\utility::script_delay();

    if(isDefined(var15.script_duration)) {
      var18 = var15.script_duration;
    }

    if(isDefined(var15.script_accel)) {
      var19 = var15.script_accel;
    }

    if(isDefined(var15.script_decel)) {
      var20 = var15.script_decel;
    }

    if(isDefined(var15.script_earthquake)) {
      var16 = var15.script_earthquake;
    }

    if(isDefined(var15.script_exploder)) {
      var17 = var15.script_exploder;
    }

    if(isDefined(var15.script_flag_wait)) {
      var21 = var15.script_flag_wait;
    }

    var22 = var15 scripts\engine\utility::get_linked_ents();

    if(var22.size > 0) {
      if(issubstr(var22[0].classname, "trigger")) {
        var22[0] waittill("trigger");
      }
    }

    if(isDefined(var15.target)) {
      var15 = var15 scripts\engine\utility::get_target_ent();
      continue;
    }
  }

  self notify("done_moving");
}

function moveto_volume_vehiclespline(var0, var1) {
  var2 = self;
  var3 = getvehiclenode(var0.target, "targetname");

  if(!isDefined(var3.angles)) {
    var3.angles = (0, 0, 0);
  }

  var1.mover = var2;
  var2.origin = var3.origin;
  var2.angles = var3.angles;
  var1 waittill("trigger");
  var4 = var0 vehicle_dospawn();
  var4 vehicle_turnengineoff();
  var4 hide();
  var4 scripts\common\vehicle::godon();
  var4 vehicle_turnengineoff();
  var2 linkTo(var4);
  var4 attachpath(var3);
  var4 startpath();
}

function constant_quake(var0) {
  self endon("stop_constant_quake");

  for(;;) {
    thread scripts\engine\utility::do_earthquake(var0, self.origin);
    wait randomfloatrange(0.1, 0.2);
  }
}

function moveto_rotateto_speed(var0, var1, var2, var3) {
  var4 = var0.origin;
  var5 = self.origin;
  var6 = distance(var5, var4);
  var7 = var6 / var1;

  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  self rotateTo(var0.angles, var7, var7 * var2, var7 * var3);
  self moveTo(var4, var7, var7 * var2, var7 * var3);
  self waittill("movedone");
}

function moveto_rotateTo(var0, var1, var2, var3) {
  self moveTo(var0.origin, var1, var2, var3);
  self rotateTo(var0.angles, var1, var2, var3);
  self waittill("movedone");
}

function set_start_positions(var0) {
  var1 = scripts\engine\utility::getStructArray(var0, "targetname");

  foreach(var3 in var1) {
    switch (var3.script_noteworthy) {
      case "player":
        level.player setOrigin(var3.origin);
        level.player setplayerangles(var3.angles);
        break;
    }
  }
}