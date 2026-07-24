/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3848.gsc
**************************************/

_id_6A1F() {
  level._id_1AE3 = getEntArray("airlock", "targetname");
  level._id_F0C2 = 90;
  level._id_F0BF = 8;
  level._id_F0C1 = 152;
  level._id_F0C0 = 60;
  level._id_F0BE = 1;
  scripts\engine\utility::array_thread(getEntArray("ext_breach_door", "targetname"), ::_id_6A1E);
  scripts\engine\utility::flag_init("timer_expired");
  scripts\engine\utility::flag_init("airlocks_open_to_inside");
}

_id_6A1E() {
  self.collision = scripts\sp\utility::_id_7A8F();

  if(self.collision.size == 0)
    self.collision = undefined;
  else {
    self.collision = self.collision[0];
    self.collision linkTo(self);
  }

  self makeusable();
  self setHintString("Hold [{+activate}] to Hack Airlock");
  var_0 = 0;

  if(isDefined(self.script_noteworthy))
    var_0 = 1;

  var_1 = "breach_point";
  _id_0F14::_id_DAC3(self, 6, 800, 0, "Breach Point", var_0, var_1);
  scripts\engine\utility::flag_set("timer_expired");
  wait 0.5;

  if(!isDefined(self._id_BD0E))
    self movez(-200, 5);
  else
    self rotateTo(self._id_BD0E.angles, 5);
}

_id_1ADD() {
  scripts\engine\utility::waitframe();
  scripts\engine\utility::waitframe();
  self._id_C75F = scripts\engine\utility::get_target_ent();
  self.marker = self._id_C75F scripts\engine\utility::get_target_ent();
  var_0 = getEntArray("ship_door_interior_right", "script_noteworthy");
  var_0 = scripts\engine\utility::array_combine(var_0, getEntArray("ship_door_interior_up", "script_noteworthy"));
  var_1 = scripts\engine\utility::spawn_tag_origin();

  foreach(var_3 in var_0) {
    var_1.origin = var_3.origin;

    if(var_1 istouching(self._id_C75F)) {
      var_4 = self.marker.origin;
      var_5 = var_3.origin;
      var_6 = anglesToForward(self.marker.angles);
      var_7 = vectorNormalize(var_5 - var_4);
      var_8 = vectordot(var_6, var_7);

      if(var_8 > 0)
        self._id_98F6 = var_3;
      else
        self._id_C75C = var_3;

      foreach(var_10 in var_3._id_EBBA.doors)
      var_10 notify("stop_door_logic");

      foreach(var_13 in var_3._id_C95A)
      var_13 disconnectPaths();
    }
  }

  var_16 = getEntArray("airlock_trigger", "targetname");
  self._id_127C9 = [];

  foreach(var_18 in var_16) {
    var_1.origin = var_18.origin;

    if(var_1 istouching(self._id_C75F)) {
      var_18 scripts\engine\utility::trigger_off();
      self._id_127C9 = scripts\engine\utility::array_add(self._id_127C9, var_18);
    }
  }

  var_16 = undefined;
  var_20 = scripts\engine\utility::getStructArray("airlock_fx", "targetname");
  self._id_7577 = [];

  foreach(var_22 in var_20) {
    var_1.origin = var_22.origin;

    if(var_1 istouching(self._id_C75F))
      self._id_7577 = scripts\engine\utility::array_add(self._id_7577, var_22);
  }

  var_20 = undefined;

  for(;;) {
    self waittill("trigger", var_24);

    if(!scripts\engine\utility::flag("player_in_gravity"))
      _id_D870();
    else
      _id_5253();

    while(var_24 istouching(self._id_C75F))
      scripts\engine\utility::waitframe();
  }
}

_id_D870() {
  var_0 = self._id_C75C._id_EBBA.doors;
  scripts\engine\utility::array_thread(var_0, ::_id_425D, 0.25, 1);
  wait 1;

  foreach(var_2 in self._id_7577)
  var_2 thread _id_6129();

  wait 2;
  scripts\engine\utility::flag_set("player_in_gravity");
  wait 2;
  var_0 = self._id_98F6._id_EBBA.doors;
  scripts\engine\utility::array_thread(self._id_127C9, scripts\engine\utility::trigger_on);
  scripts\engine\utility::array_thread(var_0, ::_id_C5ED, 1.5);

  foreach(var_5 in level._id_1AE3) {
    if(var_5 != self) {
      var_0 = var_5._id_C75C._id_EBBA.doors;
      scripts\engine\utility::array_thread(var_0, ::_id_425D, 0.25, 1);
      var_0 = var_5._id_98F6._id_EBBA.doors;
      scripts\engine\utility::array_thread(var_5._id_127C9, scripts\engine\utility::trigger_on);
      scripts\engine\utility::array_thread(var_0, ::_id_C5ED, 0.25);
    }
  }
}

_id_5253() {
  level.player allowjump(0);
  var_0 = self._id_98F6._id_EBBA.doors;
  scripts\engine\utility::array_thread(var_0, ::_id_425D, 0.25, 1);
  wait 1;
  scripts\engine\utility::flag_clear("player_in_gravity");
  var_1 = level.player scripts\engine\utility::spawn_tag_origin();
  level.player playerlinkTo(var_1, "tag_origin");
  var_1 movez(64, 1.5, 0, 1.5);
  var_1 waittill("movedone");
  var_1 delete();
  var_0 = self._id_C75C._id_EBBA.doors;
  scripts\engine\utility::array_thread(self._id_127C9, scripts\engine\utility::trigger_off);
  scripts\engine\utility::array_thread(var_0, ::_id_C5ED, 1.5);

  foreach(var_3 in level._id_1AE3) {
    if(var_3 != self) {
      var_0 = var_3._id_98F6._id_EBBA.doors;
      scripts\engine\utility::array_thread(var_0, ::_id_425D, 0.25, 1);
      var_0 = var_3._id_C75C._id_EBBA.doors;
      scripts\engine\utility::array_thread(var_3._id_127C9, scripts\engine\utility::trigger_off);
      scripts\engine\utility::array_thread(var_0, ::_id_C5ED, 0.25);
    }
  }
}

_id_6129() {
  scripts\sp\utility::script_delay();
  playFX(scripts\engine\utility::getfx(self.script_fxid), self.origin, anglesToForward(self.angles), anglestoup(self.angles));

  if(isDefined(self.script_soundalias))
    playworldsound(self.script_soundalias, self.origin);
}

door_setup() {
  var_0 = getEntArray("ship_door_interior", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2 scripts\engine\utility::get_target_ent()))
      var_2 linkTo(var_2 scripts\engine\utility::get_target_ent());
  }

  var_4 = getEntArray("ship_door_interior_left", "script_noteworthy");
  var_5 = getEntArray("ship_door_interior_right", "script_noteworthy");
  var_6 = getEntArray("ship_door_interior_up", "script_noteworthy");

  foreach(var_8 in var_5) {
    var_8.trigger = spawn("trigger_radius", var_8.origin, 7, 200, 64);
    var_9 = var_8 scripts\engine\utility::get_target_ent();
    var_9.trigger = var_8.trigger;
    var_8._id_EBBA = var_9 scripts\engine\utility::get_target_ent();
    var_9._id_EBBA = var_8._id_EBBA;
    var_8._id_EBBA.doors = [var_8, var_9];
    waittillframeend;
    var_8 thread _id_59AD();
    var_9 thread _id_59AD();
  }

  foreach(var_8 in var_6) {
    var_8.trigger = spawn("trigger_radius", var_8.origin, 3, 200, 64);
    var_8._id_EBBA = var_8 scripts\engine\utility::get_target_ent();
    var_8._id_EBBA.doors = [var_8];
    var_8 thread _id_59AD();
  }
}

_id_59AD() {
  self endon("stop_door_logic");

  if(!isDefined(self.script_noteworthy)) {
    return;
  }
  self._id_8804 = 0;
  var_0 = [];
  var_0 = self getlinkedchildren();
  self._id_C95A = var_0;

  foreach(var_2 in var_0) {
    if(var_2.script_parameters != "lock_broken") {
      var_2 connectpaths();
      continue;
    }

    var_2 disconnectPaths();
  }

  self._id_4284 = 1;

  if(self.script_noteworthy == "ship_door_interior_right") {
    self._id_EBBA thread _id_0F14::_id_882B(self.trigger);
    var_4 = self._id_EBBA scripts\engine\utility::get_target_ent();
    var_4 thread _id_0F14::_id_882B(self.trigger);
  }

  if(self.script_noteworthy == "ship_door_interior_up")
    self._id_EBBA thread _id_0F14::_id_882B(self.trigger);

  var_5 = 0;

  switch (self.script_parameters) {
    case "lock_1":
      var_5 = 1;
      break;
    case "lock_2":
      var_5 = 2;
      break;
    case "lock_3":
      var_5 = 3;
      break;
    case "lock_4":
      var_5 = 4;
    case "lock_open":
      var_5 = 0;
    case "lock_broken":
      var_5 = 999;
      break;
    default:
      break;
  }

  for(;;) {
    if(self.script_parameters != "lock_open")
      self.trigger waittill("trigger", var_6);
    else {
      var_6 = level.player;
      self.trigger._id_8804 = 1;
    }

    if(!isDefined(var_6._id_597F))
      var_6._id_597F = 0;
    else {}

    if(self._id_4284 == 1 && var_6._id_597F >= var_5 || isDefined(self.trigger._id_8804)) {
      _id_C5ED();

      if(isDefined(self.trigger._id_8804)) {
        break;
      }

      for(;;) {
        var_7 = 1;
        var_8 = getaiarray("axis", "allies", "neutral");
        var_8[var_8.size] = level.player;

        foreach(var_10 in var_8) {
          if(var_10 istouching(self.trigger))
            var_7 = 0;
        }

        if(var_7 == 1) {
          _id_425D();
          break;
        }

        wait 0.1;
      }
    }

    wait 0.1;
  }
}

_id_C5ED(var_0) {
  if(!self._id_4284) {
    return;
  }
  self._id_4284 = 0;

  if(!isDefined(var_0))
    var_0 = 0.25;

  if(self.script_noteworthy == "ship_door_interior_right")
    self moveTo(self.origin + anglestoright(self.angles) * -56, var_0, 0, 0);
  else if(self.script_noteworthy == "ship_door_interior_up")
    self moveTo(self.origin + (0, 0, 122), var_0, 0, 0);
  else
    self moveTo(self.origin + anglestoright(self.angles) * 56, var_0, 0, 0);

  wait(var_0);

  foreach(var_2 in self._id_C95A)
  var_2 connectpaths();
}

_id_425D(var_0, var_1) {
  if(self._id_4284) {
    return;
  }
  if(!isDefined(var_0))
    var_0 = 0.25;

  self._id_4284 = 1;

  if(self.script_noteworthy == "ship_door_interior_right")
    self moveTo(self.origin + anglestoright(self.angles) * 56, var_0, 0, 0);
  else if(self.script_noteworthy == "ship_door_interior_up")
    self moveTo(self.origin + (0, 0, -122), var_0, 0, 0);
  else
    self moveTo(self.origin + anglestoright(self.angles) * -56, var_0, 0, 0);

  wait(var_0);

  if(isDefined(var_1)) {
    foreach(var_3 in self._id_C95A)
    var_3 disconnectPaths();
  }
}