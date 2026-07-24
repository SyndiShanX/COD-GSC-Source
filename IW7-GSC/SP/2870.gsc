/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2870.gsc
**************************************/

_id_12764(var_0) {
  if(!isDefined(level._id_BCDB)) {
    level._id_BCDB = getEntArray("script_brushmodel", "classname");
    level._id_BCDB = scripts\engine\utility::array_combine(level._id_BCDB, getEntArray("script_model", "classname"));
  }

  var_1 = getEntArray(var_0.target, "targetname");
  scripts\engine\utility::array_thread(var_1, ::_id_BD15, var_0);
}

_id_BD15(var_0) {
  var_1 = [];
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_3 = self;

  foreach(var_5 in level._id_BCDB) {
    var_2.origin = var_5.origin;

    if(var_2 istouching(var_3)) {
      level._id_BCDB = scripts\engine\utility::array_remove(level._id_BCDB, var_5);
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

    if(isDefined(var_5.script_parent) && var_5.script_parent == "mover") {
      var_7 = var_5;
      break;
    }
  }

  foreach(var_5 in var_1) {
    if(var_7 != var_5)
      var_5 linkTo(var_7);
  }

  var_15 = scripts\engine\utility::get_target_ent();

  if(var_15 scripts\sp\vehicle::_id_9FEF()) {
    var_7 _id_BD16(var_15, var_0);
    self notify("done_moving");
    return;
  }

  if(!isDefined(var_15.angles))
    var_15.angles = (0, 0, 0);

  var_0._id_BCDA = var_7;
  var_7.origin = var_15.origin;
  var_7.angles = var_15.angles;
  var_16 = undefined;
  var_17 = undefined;
  var_18 = 5;
  var_19 = 0;
  var_20 = 0;
  var_21 = undefined;

  if(isDefined(var_15._id_ED75))
    var_18 = var_15._id_ED75;

  if(isDefined(var_15.script_accel))
    var_19 = var_15.script_accel;

  if(isDefined(var_15._id_ED4C))
    var_20 = var_15._id_ED4C;

  if(isDefined(var_15.script_earthquake))
    var_16 = var_15.script_earthquake;

  if(isDefined(var_15.script_exploder))
    var_17 = var_15.script_exploder;

  if(isDefined(var_15._id_EDA0))
    var_21 = var_15._id_EDA0;

  var_0 waittill("trigger");
  var_15 scripts\sp\utility::script_delay();

  if(isDefined(var_15.target))
    var_15 = var_15 scripts\engine\utility::get_target_ent();
  else
    var_15 = undefined;

  while(isDefined(var_15)) {
    if(isDefined(var_21))
      scripts\engine\utility::flag_wait(var_21);

    if(isDefined(var_17)) {
      scripts\engine\utility::exploder(var_17);
      level notify("geo_mover_exploder", var_17);
    } else if(isDefined(var_16)) {
      if(issubstr(var_16, "constant"))
        var_7 thread _id_4553(var_16);
    }

    if(!isDefined(var_15.angles))
      var_15.angles = (0, 0, 0);

    var_7 _id_BD13(var_15, var_18, var_19, var_20);
    var_7 notify("stop_constant_quake");
    var_18 = 5;
    var_19 = 0;
    var_20 = 0;
    var_16 = undefined;
    var_15 scripts\sp\utility::script_delay();

    if(isDefined(var_15._id_ED75))
      var_18 = var_15._id_ED75;

    if(isDefined(var_15.script_accel))
      var_19 = var_15.script_accel;

    if(isDefined(var_15._id_ED4C))
      var_20 = var_15._id_ED4C;

    if(isDefined(var_15.script_earthquake))
      var_16 = var_15.script_earthquake;

    if(isDefined(var_15.script_exploder))
      var_17 = var_15.script_exploder;

    if(isDefined(var_15._id_EDA0))
      var_21 = var_15._id_EDA0;

    var_22 = var_15 scripts\sp\utility::_id_7A8F();

    if(var_22.size > 0) {
      if(issubstr(var_22[0].classname, "trigger"))
        var_22[0] waittill("trigger");
    }

    if(isDefined(var_15.target)) {
      var_15 = var_15 scripts\engine\utility::get_target_ent();
      continue;
    }

    var_15 = undefined;
  }

  self notify("done_moving");
}

_id_BD16(var_0, var_1) {
  var_2 = self;
  var_3 = getvehiclenode(var_0.target, "targetname");

  if(!isDefined(var_3.angles))
    var_3.angles = (0, 0, 0);

  var_1._id_BCDA = var_2;
  var_2.origin = var_3.origin;
  var_2.angles = var_3.angles;
  var_1 waittill("trigger");
  var_4 = var_0 _meth_83DA();
  var_4 _meth_83E8();
  var_4 hide();
  var_4 scripts\sp\vehicle::_id_8441();
  var_4 _meth_83E8();
  var_2 linkTo(var_4);
  var_4 attachpath(var_3);
  var_4 startpath();
}

_id_4553(var_0) {
  self endon("stop_constant_quake");

  for(;;) {
    thread scripts\engine\utility::do_earthquake(var_0, self.origin);
    wait(randomfloatrange(0.1, 0.2));
  }
}

_id_BD14(var_0, var_1, var_2, var_3) {
  var_4 = var_0.origin;
  var_5 = self.origin;
  var_6 = distance(var_5, var_4);
  var_7 = var_6 / var_1;

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  self rotateTo(var_0.angles, var_7, var_7 * var_2, var_7 * var_3);
  self moveTo(var_4, var_7, var_7 * var_2, var_7 * var_3);
  self waittill("movedone");
}

_id_BD13(var_0, var_1, var_2, var_3) {
  self moveTo(var_0.origin, var_1, var_2, var_3);
  self rotateTo(var_0.angles, var_1, var_2, var_3);
  self waittill("movedone");
}

_id_F5B1(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    switch (var_3.script_noteworthy) {
      case "player":
        level.player setOrigin(var_3.origin);
        level.player setplayerangles(var_3.angles);
        break;
    }
  }
}

_id_409C() {
  waittillframeend;
  waittillframeend;
  level._id_BCDB = undefined;
}