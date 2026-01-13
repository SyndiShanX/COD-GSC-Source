/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\sp\geo_mover.gsc
*********************************************/

func_12764(var_0) {
  if(!isDefined(level.var_BCDB)) {
    level.var_BCDB = getEntArray("script_brushmodel", "classname");
    level.var_BCDB = scripts\engine\utility::array_combine(level.var_BCDB, getEntArray("script_model", "classname"));
  }

  var_1 = getEntArray(var_0.target, "targetname");
  scripts\engine\utility::array_thread(var_1, ::func_BD15, var_0);
}

func_BD15(var_0) {
  var_1 = [];
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_3 = self;
  foreach(var_5 in level.var_BCDB) {
    var_2.origin = var_5.origin;
    if(var_2 istouching(var_3)) {
      level.var_BCDB = scripts\engine\utility::array_remove(level.var_BCDB, var_5);
      var_1 = scripts\engine\utility::array_add(var_1, var_5);
    }
  }

  var_2 delete();
  var_7 = undefined;
  foreach(var_5 in var_1) {
    if(isDefined(var_5.script_parameters) && var_5.script_parameters == "mover") {
      var_7 = var_5;
      break;
    }

    if(isDefined(var_5.isbotmatchmakingenabled) && var_5.isbotmatchmakingenabled == "mover") {
      var_7 = var_5;
      break;
    }
  }

  foreach(var_5 in var_1) {
    if(var_7 != var_5) {
      var_5 linkto(var_7);
    }
  }

  var_0F = scripts\engine\utility::get_target_ent();
  if(var_0F scripts\sp\vehicle::func_9FEF()) {
    var_7 func_BD16(var_0F, var_0);
    self notify("done_moving");
    return;
  }

  if(!isDefined(var_0F.angles)) {
    var_0F.angles = (0, 0, 0);
  }

  var_0.var_BCDA = var_7;
  var_7.origin = var_0F.origin;
  var_7.angles = var_0F.angles;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = 5;
  var_13 = 0;
  var_14 = 0;
  var_15 = undefined;
  if(isDefined(var_0F.var_ED75)) {
    var_12 = var_0F.var_ED75;
  }

  if(isDefined(var_0F.script_accel)) {
    var_13 = var_0F.script_accel;
  }

  if(isDefined(var_0F.var_ED4C)) {
    var_14 = var_0F.var_ED4C;
  }

  if(isDefined(var_0F.script_earthquake)) {
    var_10 = var_0F.script_earthquake;
  }

  if(isDefined(var_0F.script_exploder)) {
    var_11 = var_0F.script_exploder;
  }

  if(isDefined(var_0F.var_EDA0)) {
    var_15 = var_0F.var_EDA0;
  }

  var_0 waittill("trigger");
  var_0F scripts\sp\utility::script_delay();
  if(isDefined(var_0F.target)) {
    var_0F = var_0F scripts\engine\utility::get_target_ent();
  } else {
    var_0F = undefined;
  }

  while(isDefined(var_0F)) {
    if(isDefined(var_15)) {
      scripts\engine\utility::flag_wait(var_15);
    }

    if(isDefined(var_11)) {
      scripts\engine\utility::exploder(var_11);
      level notify("geo_mover_exploder", var_11);
    } else if(isDefined(var_10)) {
      if(issubstr(var_10, "constant")) {
        var_7 thread func_4553(var_10);
      }
    }

    if(!isDefined(var_0F.angles)) {
      var_0F.angles = (0, 0, 0);
    }

    var_7 func_BD13(var_0F, var_12, var_13, var_14);
    var_7 notify("stop_constant_quake");
    var_12 = 5;
    var_13 = 0;
    var_14 = 0;
    var_10 = undefined;
    var_0F scripts\sp\utility::script_delay();
    if(isDefined(var_0F.var_ED75)) {
      var_12 = var_0F.var_ED75;
    }

    if(isDefined(var_0F.script_accel)) {
      var_13 = var_0F.script_accel;
    }

    if(isDefined(var_0F.var_ED4C)) {
      var_14 = var_0F.var_ED4C;
    }

    if(isDefined(var_0F.script_earthquake)) {
      var_10 = var_0F.script_earthquake;
    }

    if(isDefined(var_0F.script_exploder)) {
      var_11 = var_0F.script_exploder;
    }

    if(isDefined(var_0F.var_EDA0)) {
      var_15 = var_0F.var_EDA0;
    }

    var_16 = var_0F scripts\sp\utility::func_7A8F();
    if(var_16.size > 0) {
      if(issubstr(var_16[0].classname, "trigger")) {
        var_16[0] waittill("trigger");
      }
    }

    if(isDefined(var_0F.target)) {
      var_0F = var_0F scripts\engine\utility::get_target_ent();
      continue;
    }

    var_0F = undefined;
  }

  self notify("done_moving");
}

func_BD16(var_0, var_1) {
  var_2 = self;
  var_3 = getvehiclenode(var_0.target, "targetname");
  if(!isDefined(var_3.angles)) {
    var_3.angles = (0, 0, 0);
  }

  var_1.var_BCDA = var_2;
  var_2.origin = var_3.origin;
  var_2.angles = var_3.angles;
  var_1 waittill("trigger");
  var_4 = var_0 global_physics_sound_monitor();
  var_4 _meth_83E8();
  var_4 hide();
  var_4 scripts\sp\vehicle::playgestureviewmodel();
  var_4 _meth_83E8();
  var_2 linkto(var_4);
  var_4 attachpath(var_3);
  var_4 startpath();
}

func_4553(var_0) {
  self endon("stop_constant_quake");
  for(;;) {
    thread scripts\engine\utility::do_earthquake(var_0, self.origin);
    wait(randomfloatrange(0.1, 0.2));
  }
}

func_BD14(var_0, var_1, var_2, var_3) {
  var_4 = var_0.origin;
  var_5 = self.origin;
  var_6 = distance(var_5, var_4);
  var_7 = var_6 / var_1;
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  self rotateto(var_0.angles, var_7, var_7 * var_2, var_7 * var_3);
  self moveto(var_4, var_7, var_7 * var_2, var_7 * var_3);
  self waittill("movedone");
}

func_BD13(var_0, var_1, var_2, var_3) {
  self moveto(var_0.origin, var_1, var_2, var_3);
  self rotateto(var_0.angles, var_1, var_2, var_3);
  self waittill("movedone");
}

func_F5B1(var_0) {
  var_1 = scripts\engine\utility::getstructarray(var_0, "targetname");
  foreach(var_3 in var_1) {
    switch (var_3.script_noteworthy) {
      case "player":
        level.player setorigin(var_3.origin);
        level.player setplayerangles(var_3.angles);
        break;
    }
  }
}

func_409C() {
  waittillframeend;
  waittillframeend;
  level.var_BCDB = undefined;
}