/************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\geo_mover.gsc
************************************/

func_12764(param_00) {
  if(!isDefined(level.var_BCDB)) {
    level.var_BCDB = getEntArray("script_brushmodel", "classname");
    level.var_BCDB = scripts\engine\utility::array_combine(level.var_BCDB, getEntArray("script_model", "classname"));
  }

  var_01 = getEntArray(param_00.target, "targetname");
  scripts\engine\utility::array_thread(var_01, ::func_BD15, param_00);
}

func_BD15(param_00) {
  var_01 = [];
  var_02 = scripts\engine\utility::spawn_tag_origin();
  var_03 = self;
  foreach(var_05 in level.var_BCDB) {
    var_02.origin = var_05.origin;
    if(var_02 istouching(var_03)) {
      level.var_BCDB = scripts\engine\utility::array_remove(level.var_BCDB, var_05);
      var_01 = scripts\engine\utility::array_add(var_01, var_05);
    }
  }

  var_02 delete();
  var_07 = undefined;
  foreach(var_05 in var_01) {
    if(isDefined(var_05.script_parameters) && var_05.script_parameters == "mover") {
      var_07 = var_05;
      break;
    }

    if(isDefined(var_05.isbotmatchmakingenabled) && var_05.isbotmatchmakingenabled == "mover") {
      var_07 = var_05;
      break;
    }
  }

  foreach(var_05 in var_01) {
    if(var_07 != var_05) {
      var_05 linkto(var_07);
    }
  }

  var_0F = scripts\engine\utility::get_target_ent();
  if(var_0F scripts\sp\vehicle::func_9FEF()) {
    var_07 func_BD16(var_0F, param_00);
    self notify("done_moving");
    return;
  }

  if(!isDefined(var_0F.angles)) {
    var_0F.angles = (0, 0, 0);
  }

  param_00.var_BCDA = var_07;
  var_07.origin = var_0F.origin;
  var_07.angles = var_0F.angles;
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

  param_00 waittill("trigger");
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
        var_07 thread func_4553(var_10);
      }
    }

    if(!isDefined(var_0F.angles)) {
      var_0F.angles = (0, 0, 0);
    }

    var_07 func_BD13(var_0F, var_12, var_13, var_14);
    var_07 notify("stop_constant_quake");
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

func_BD16(param_00, param_01) {
  var_02 = self;
  var_03 = getvehiclenode(param_00.target, "targetname");
  if(!isDefined(var_03.angles)) {
    var_03.angles = (0, 0, 0);
  }

  param_01.var_BCDA = var_02;
  var_02.origin = var_03.origin;
  var_02.angles = var_03.angles;
  param_01 waittill("trigger");
  var_04 = param_00 global_physics_sound_monitor();
  var_04 _meth_83E8();
  var_04 hide();
  var_04 scripts\sp\vehicle::playgestureviewmodel();
  var_04 _meth_83E8();
  var_02 linkto(var_04);
  var_04 attachpath(var_03);
  var_04 startpath();
}

func_4553(param_00) {
  self endon("stop_constant_quake");
  for(;;) {
    thread scripts\engine\utility::do_earthquake(param_00, self.origin);
    wait(randomfloatrange(0.1, 0.2));
  }
}

func_BD14(param_00, param_01, param_02, param_03) {
  var_04 = param_00.origin;
  var_05 = self.origin;
  var_06 = distance(var_05, var_04);
  var_07 = var_06 / param_01;
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  self rotateto(param_00.angles, var_07, var_07 * param_02, var_07 * param_03);
  self moveto(var_04, var_07, var_07 * param_02, var_07 * param_03);
  self waittill("movedone");
}

func_BD13(param_00, param_01, param_02, param_03) {
  self moveto(param_00.origin, param_01, param_02, param_03);
  self rotateto(param_00.angles, param_01, param_02, param_03);
  self waittill("movedone");
}

func_F5B1(param_00) {
  var_01 = scripts\engine\utility::getstructarray(param_00, "targetname");
  foreach(var_03 in var_01) {
    switch (var_03.script_noteworthy) {
      case "player":
        level.player setorigin(var_03.origin);
        level.player setplayerangles(var_03.angles);
        break;
    }
  }
}

func_409C() {
  waittillframeend;
  waittillframeend;
  level.var_BCDB = undefined;
}