/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_doors.gsc
**************************************/

init() {
  common_scripts\utility::flag_init("door_opened");

  if(!isDefined(level.doorhintstrings)) {
    level.doorhintstrings = [];
  }

  level.zombiedoors = common_scripts\utility::getstructarray("door", "targetname");
  common_scripts\utility::array_thread(level.zombiedoors, ::init_door);
}

init_door() {
  self.door_type = self.script_noteworthy;

  if(!isDefined(self.door_type)) {
    self.door_type = "normal";
  }

  switch (self.door_type) {
    case "normal":
      thread init_door_normal();
      break;
    default:
      break;
  }
}

door_set_cost(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 500;
  }

  self.cost = var_0;

  foreach(var_2 in self.triggers) {
    var_2 maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(self.cost));
  }
}

init_door_normal() {
  self.triggers = [];
  self.movers = [];
  self.blood = 0;

  if(!isDefined(self.target)) {
    door_error("Door struct without any targets at " + self.origin + ".");
    return;
  }

  var_0 = getEntArray(self.target, "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2.script_noteworthy;

    if(!isDefined(var_3) && isDefined(var_2.classname)) {
      switch (var_2.classname) {
        case "script_brushmodel":
        case "script_model":
          var_3 = "mover";
          break;
        case "trigger_use_touch":
        case "trigger_use":
          var_3 = "trigger";
          break;
      }
    }

    if(!isDefined(var_3)) {
      continue;
    }
    switch (var_3) {
      case "trigger":
        if(init_door_trigger(var_2)) {
          self.triggers[self.triggers.size] = var_2;
        }

        break;
      case "mover":
        if(init_door_mover(var_2)) {
          self.movers[self.movers.size] = var_2;
        }

        break;
      case "trap":
        self.traptrigger = var_2;
        break;
      default:
        door_error("Unknown ent type '" + var_3 + "' on entity at " + var_2.origin + ".");
        break;
    }
  }

  if(self.triggers.size && self.movers.size) {
    run_door();
  }
}

init_door_trigger(var_0) {
  return 1;
}

init_door_mover(var_0) {
  if(!isDefined(var_0.target)) {
    door_error("Door mover without a target key at " + self.origin + ".");
    return 0;
  }

  var_0.closed_pos = var_0.origin;
  var_0.is_door = 1;
  var_0.blood = [];
  var_0.movegoals = [];
  var_1 = common_scripts\utility::getstructarray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_4 = var_3.script_noteworthy;

    if(!isDefined(var_4)) {
      var_4 = "goal";
    }

    switch (var_4) {
      case "goal":
        var_0.movegoals[var_0.movegoals.size] = var_3;
        break;
      default:
        door_error("Unknown door target struct type '" + var_4 + "' on struct at " + var_3.origin + ".");
        break;
    }
  }

  var_6 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_6) {
    var_4 = var_3.script_noteworthy;

    if(!isDefined(var_4)) {
      var_4 = "link";
    }

    switch (var_4) {
      case "link_blood":
        var_0.blood[var_0.blood.size] = var_3;
        var_3 ghost();
        var_3 linkto(var_0);
        break;
      case "link":
        var_3 linkto(var_0);
        break;
      default:
        door_error("Unknown door target ent type '" + var_4 + "' on ent at " + var_3.origin + ".");
        break;
    }
  }

  if(var_0.movegoals.size > 0) {
    return 1;
  } else {
    door_error("Door mover at " + var_0.origin + "doesn't have a goal stuct.");
    return 0;
  }
}

all_doors_open() {
  foreach(var_1 in level.zombiedoors) {
    if(!(isDefined(var_1.open) && var_1.open)) {
      return 0;
    }
  }

  return 1;
}

run_door() {
  foreach(var_1 in self.triggers) {
    thread run_door_trigger(var_1);
  }

  self waittill("open", var_3);
  self.open = 1;

  if(isDefined(var_3)) {
    var_3 thread maps\mp\zombies\_zombies_audio::moneyspend();
  }

  common_scripts\utility::flag_set("door_opened");

  if(isDefined(self.script_flag)) {
    common_scripts\utility::flag_set(self.script_flag, var_3);

    if(isDefined(level.doorbitmaskarray[self.script_flag])) {
      level.doorsopenedbitmask = level.doorsopenedbitmask | level.doorbitmaskarray[self.script_flag];
    }
  }

  foreach(var_1 in self.triggers) {
    thread end_door_trigger(var_1);
  }

  foreach(var_7 in self.movers) {
    thread run_door_mover(var_7);
  }

  if(isDefined(self.traversalnodepairs)) {
    for(var_9 = 0; var_9 < self.traversalnodepairs.size; var_9++) {
      connectnodepair(self.traversalnodepairs[var_9][0], self.traversalnodepairs[var_9][1]);
    }
  }

  thread run_door_trap();
}

run_door_trigger(var_0) {
  self endon("open");
  door_set_cost(self.script_count);
  thread run_door_hint(var_0);

  for(;;) {
    [var_2, var_3] = var_0 maps\mp\zombies\_util::waittilltriggerortokenuse();

    if(!door_has_power()) {
      continue;
    }
    if(var_3 == "token") {
      var_2 maps\mp\gametypes\zombies::spendtoken(var_0.tokencost);
      break;
    } else {
      var_4 = self.cost;

      if(var_2 maps\mp\gametypes\zombies::attempttobuy(var_4)) {
        break;
      }
    }

    var_2 thread maps\mp\zombies\_zombies_audio::playerweaponbuy("wpn_no_cash");
  }

  maps\mp\zombies\_zombies_audio_announcer::announcerdoordialog();
  self notify("open", var_2);
}

run_door_trap() {
  if(!isDefined(self.traptrigger)) {
    return;
  }
  if(isDefined(self.traptrigger.target)) {
    var_0 = common_scripts\utility::getstruct(self.traptrigger.target, "targetname");

    if(isDefined(var_0)) {
      self.trapdir = anglesToForward(var_0.angles);
    }
  }

  foreach(var_2 in self.movers) {
    var_2.unresolved_collision_notify_min = 1;
    var_2.unresolved_collision_func = ::door_trap_kill;
    var_2.parent = self;
  }

  self.trapactive = 0;
  thread run_door_trap_trigger();

  for(;;) {
    self waittill("trap_trigger", var_4, var_5);
    self.trapowner = var_4;
    self.trapactive = 1;
    thread door_trap_end(var_5);
  }
}

door_trap_end(var_0) {
  self notify("door_trap_end");
  self endon("door_trap_end");
  wait(var_0);
  self.trapactive = 0;
}

run_door_trap_trigger() {
  var_0 = 0.1;

  for(;;) {
    self.traptrigger waittill("trigger", var_1);

    if(!self.trapactive) {
      continue;
    }
    if(isplayer(var_1)) {
      continue;
    }
    if(var_1 maps\mp\zombies\_util::isdoortrapimmune()) {
      continue;
    }
    if(is_any_player_touching(self.traptrigger)) {
      continue;
    }
    if(isDefined(self.trapdir)) {
      var_2 = var_1 getvelocity();
      var_3 = var_1.origin - self.traptrigger.origin;
      var_4 = var_1.origin + var_2 * var_0 - self.traptrigger.origin;
      var_3 = (var_3[0], var_3[1], 0);
      var_4 = (var_4[0], var_4[1], 0);
      var_5 = vectordot(self.trapdir, var_3);
      var_6 = vectordot(self.trapdir, var_4);

      if(var_5 * var_6 > 0) {
        continue;
      }
    }

    foreach(var_8 in self.movers) {
      var_8 moveto(var_8.closed_pos, var_0, var_0);
      var_8 playSound("trap_security_door_slam");
    }

    wait(var_0);
    earthquake(0.2, 0.5, self.traptrigger.origin, 500);
    wait 0.1;
    var_10 = 1.0;

    foreach(var_8 in self.movers) {
      var_8 moveto(var_8.open_pos, var_10);
      var_8 playSound("trap_security_door_reset");
    }

    wait(var_10);
    wait 0.5;
  }
}

door_trap_kill(var_0) {
  if(!isDefined(var_0) || isplayer(var_0)) {
    return;
  }
  if(var_0 maps\mp\zombies\_util::isdoortrapimmune()) {
    return;
  }
  self.parent door_add_blood();
  var_0 dodamage(var_0.health, var_0.origin, self.parent.trapowner, self, "MOD_CRUSH", "trap_zm_mp", "torso_upper");
}

door_add_blood() {
  if(self.blood) {
    return;
  }
  self.blood = 1;

  foreach(var_1 in self.movers) {
    foreach(var_3 in var_1.blood) {
      var_3 show();
    }
  }
}

is_any_player_touching(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 istouching(var_0)) {
      return 1;
    }
  }

  return 0;
}

run_door_hint(var_0) {
  self endon("open");

  if(door_requires_power()) {
    for(;;) {
      if(!door_has_power()) {
        var_0 sethintstring(&"ZOMBIES_REQUIRES_POWER");
        var_0 setsecondaryhintstring("");
        var_0 maps\mp\zombies\_util::tokenhintstring(0);
        common_scripts\utility::flag_wait(self.script_flag_true);
      }

      var_0 sethintstring(gethintstring(var_0));
      var_0 setsecondaryhintstring(maps\mp\zombies\_util::getcoststring(self.cost));
      var_0 maps\mp\zombies\_util::tokenhintstring(1);

      if(isDefined(self.script_flag_true)) {
        common_scripts\utility::flag_waitopen(self.script_flag_true);
      }
    }
  } else {
    var_0 sethintstring(gethintstring(var_0));
    var_0 setsecondaryhintstring(maps\mp\zombies\_util::getcoststring(self.cost));
    var_0 maps\mp\zombies\_util::tokenhintstring(1);
  }
}

door_requires_power() {
  return isDefined(self.script_flag_true);
}

door_has_power() {
  if(door_requires_power()) {
    return common_scripts\utility::flag(self.script_flag_true);
  }

  return 1;
}

end_door_trigger(var_0) {
  var_0 sethintstring("");
  var_0 setsecondaryhintstring("");
  var_0 maps\mp\zombies\_util::tokenhintstring(0);

  if(level.currentgen) {
    var_0 delete();
  }
}

run_door_mover(var_0) {
  var_1 = common_scripts\utility::random(var_0.movegoals);
  var_0 moveto(var_1.origin, 1.0);
  var_0.open_pos = var_1.origin;
  var_2 = "interact_door";

  if(isDefined(var_0.script_parameters)) {
    if(soundexists(var_0.script_parameters)) {
      var_2 = var_0.script_parameters;
    }
  }

  var_0 playSound(var_2);

  if(var_0 maps\mp\_movers::script_mover_is_dynamic_path()) {
    var_0 connectpaths();
  }
}

door_error(var_0) {}

registerhintstring(var_0, var_1, var_2) {
  if(!isDefined(level.doorhintstrings)) {
    level.doorhintstrings = [];
  }

  if(!isDefined(level.doorhintstrings[var_1])) {
    level.doorhintstrings[var_1] = [];
  }

  level.doorhintstrings[var_1][var_2] = var_0;
}

gethintstring(var_0) {
  if(isDefined(var_0.script_flag) && isDefined(var_0.script_index)) {
    var_1 = level.doorhintstrings[var_0.script_flag];

    if(isDefined(var_1) && isDefined(var_1[var_0.script_index])) {
      return var_1[var_0.script_index];
    }
  }

  return &"ZOMBIES_DOOR_BUY";
}

doorhasbeenopened() {
  return common_scripts\utility::flag_exist("door_opened") && common_scripts\utility::flag("door_opened");
}