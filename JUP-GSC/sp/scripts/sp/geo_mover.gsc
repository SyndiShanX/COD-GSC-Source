/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\geo_mover.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\utility;
#namespace geo_mover;

function init_mover_candidates() {
  level.mover_candidates = undefined;
}

function trigger_moveTo(trigger) {
  if(!isDefined(level.mover_candidates)) {
    level.mover_candidates = getEntArray("script_brushmodel", "classname");
    level.mover_candidates = array_combine(level.mover_candidates, getEntArray("script_model", "classname"));
  }

  volumes = getEntArray(trigger.target, "targetname");
  array_thread(volumes, &moveto_volume_think, trigger);
}

function moveto_volume_think(trigger) {
  movers = [];
  var_e62dc69923720fa9 = spawn_tag_origin();
  touch_test = self;

  foreach(m in level.mover_candidates) {
    var_e62dc69923720fa9.origin = m.origin;

    if(var_e62dc69923720fa9 istouching(touch_test)) {
      level.mover_candidates = array_remove(level.mover_candidates, m);
      movers = array_add(movers, m);
    }
  }

  var_e62dc69923720fa9 delete();
  mover = undefined;

  var_d5d61a3d2ff3b06 = 0;

  foreach(m in movers) {
    if(isDefined(m.script_parameters) && m.script_parameters == "<dev string:x1c>") {
      var_d5d61a3d2ff3b06++;
    }

    if(isDefined(m.script_parent) && m.script_parent == "<dev string:x1c>") {
      var_d5d61a3d2ff3b06++;
    }
  }

  assertex(var_d5d61a3d2ff3b06 < 2, "<dev string:x22>" + self.origin);
  assertex(var_d5d61a3d2ff3b06 > 0, "<dev string:x76>" + self.origin);

  foreach(m in movers) {
    if(isDefined(m.script_parameters) && m.script_parameters == "mover") {
      mover = m;
      break;
    }

    if(isDefined(m.script_parent) && m.script_parent == "mover") {
      mover = m;
      break;
    }
  }

  foreach(m in movers) {
    if(mover != m) {
      m linkTo(mover);
    }
  }

  mover_target = get_target_ent();

  if(mover_target isvehicle()) {
    mover moveto_volume_vehiclespline(mover_target, trigger);
    self notify("done_moving");
    return;
  }

  if(!isDefined(mover_target.angles)) {
    mover_target.angles = (0, 0, 0);
  }

  trigger.mover = mover;
  mover.origin = mover_target.origin;
  mover.angles = mover_target.angles;
  quake = undefined;
  exploder_name = undefined;
  duration = 5;
  accel = 0;
  decel = 0;
  var_69298ea86a787593 = undefined;
  var_e9aa975bb373e72f = undefined;

  if(isDefined(mover_target.script_duration)) {
    duration = mover_target.script_duration;
  }

  if(isDefined(mover_target.script_accel)) {
    accel = mover_target.script_accel;
  }

  if(isDefined(mover_target.script_decel)) {
    decel = mover_target.script_decel;
  }

  if(isDefined(mover_target.script_earthquake)) {
    quake = mover_target.script_earthquake;
  }

  if(isDefined(mover_target.script_exploder)) {
    exploder_name = mover_target.script_exploder;
  }

  if(isDefined(mover_target.script_flag_wait)) {
    var_69298ea86a787593 = mover_target.script_flag_wait;
  }

  if(isDefined(mover_target.script_flag_waitopen)) {
    var_e9aa975bb373e72f = mover_target.script_flag_waitopen;
  }

  trigger waittill("trigger");
  mover_target script_delay();

  if(isDefined(mover_target.target)) {
    mover_target = mover_target get_target_ent();
  } else {}

  for(mover_target = undefined; isDefined(mover_target); mover_target = undefined) {
    if(isDefined(var_69298ea86a787593)) {
      flag_wait(var_69298ea86a787593);
    }

    if(isDefined(var_e9aa975bb373e72f)) {
      flag_waitopen(var_e9aa975bb373e72f);
    }

    if(isDefined(exploder_name)) {
      exploder(exploder_name);
      level notify("geo_mover_exploder", exploder_name);
    } else if(isDefined(quake)) {
      if(issubstr(quake, "constant")) {
        mover thread constant_quake(quake);
      }
    }

    if(!isDefined(mover_target.angles)) {
      mover_target.angles = (0, 0, 0);
    }

    mover moveto_rotateTo(mover_target, duration, accel, decel);
    mover notify("stop_constant_quake");
    duration = 5;
    accel = 0;
    decel = 0;
    quake = undefined;
    mover_target script_delay();

    if(isDefined(mover_target.script_duration)) {
      duration = mover_target.script_duration;
    }

    if(isDefined(mover_target.script_accel)) {
      accel = mover_target.script_accel;
    }

    if(isDefined(mover_target.script_decel)) {
      decel = mover_target.script_decel;
    }

    if(isDefined(mover_target.script_earthquake)) {
      quake = mover_target.script_earthquake;
    }

    if(isDefined(mover_target.script_exploder)) {
      exploder_name = mover_target.script_exploder;
    }

    if(isDefined(mover_target.script_flag_wait)) {
      var_69298ea86a787593 = mover_target.script_flag_wait;
    }

    if(isDefined(mover_target.script_flag_waitopen)) {
      var_e9aa975bb373e72f = mover_target.script_flag_waitopen;
    }

    linked = mover_target get_linked_ents();

    if(linked.size > 0) {
      if(issubstr(linked[0].classname, "trigger")) {
        linked[0] waittill("trigger");
      }
    }

    if(isDefined(mover_target.target)) {
      mover_target = mover_target get_target_ent();
      continue;
    }
  }

  self notify("done_moving");
}

function moveto_volume_vehiclespline(vehiclespawner, trigger) {
  mover = self;
  mover_target = getvehiclenode(vehiclespawner.target, "targetname");

  if(!isDefined(mover_target.angles)) {
    mover_target.angles = (0, 0, 0);
  }

  trigger.mover = mover;
  mover.origin = mover_target.origin;
  mover.angles = mover_target.angles;
  trigger waittill("trigger");
  vehicle = vehiclespawner vehicle_dospawn();
  vehicle vehicle_turnengineoff();
  vehicle hide();
  vehicle godon();
  vehicle vehicle_turnengineoff();
  mover linkTo(vehicle);
  vehicle attachpath(mover_target);
  vehicle startpath();
}

function constant_quake(quake) {
  self endon("stop_constant_quake");

  while(true) {
    thread do_earthquake(quake, self.origin);
    wait randomfloatrange(0.1, 0.2);
  }
}

function moveto_rotateto_speed(node, rate, accel, decel) {
  point = node.origin;
  start_pos = self.origin;
  dist = distance(start_pos, point);
  time = dist / rate;

  if(!isDefined(accel)) {
    accel = 0;
  }

  if(!isDefined(decel)) {
    decel = 0;
  }

  self rotateTo(node.angles, time, time * accel, time * decel);
  self moveTo(point, time, time * accel, time * decel);
  self waittill("movedone");
}

function moveto_rotateTo(node, time, accel, decel) {
  self moveTo(node.origin, time, accel, decel);
  self rotateTo(node.angles, time, accel, decel);
  self waittill("movedone");
}

function set_start_positions(targetname) {
  start_positions = getStructArray(targetname, "targetname");

  foreach(pos in start_positions) {
    switch (pos.script_noteworthy) {
      case #"hash_87d1443ef2805760":
        level.player setOrigin(pos.origin);
        level.player setplayerangles(pos.angles);
        break;
    }
  }
}