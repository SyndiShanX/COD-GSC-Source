/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\event.gsc
***********************************************/

function event_init_entity() {
  thread event_listener_thread();
  event_entity_core_set_enabled(1);
}

function event_entity_core_set_enabled(var_0) {
  if(!isDefined(level.stealth.core_events)) {
    level.stealth.core_events = ["bulletwhizby", "explode", "footstep", "footstep_sprint", "footstep_walk", "grenade danger", "gunshot", "gunshot_teammate", "projectile_impact", "silenced_shot", "glass_destroyed"];
  }

  jumpiffalse(var_0) LOC_00000099;

  foreach(var_2 in level.stealth.core_events) {
    self addaieventlistener(var_2);
  }

  return;
}

function event_init_level() {
  if(!isDefined(level.stealth.event_priority)) {
    level.stealth.event_priority = [];
  }

  level.stealth.event_priority["investigate"] = 0;
  level.stealth.event_priority["cover_blown"] = 1;
  level.stealth.event_priority["combat"] = 2;
  level scripts\stealth\utility::set_stealth_func("broadcast", &event_broadcast_generic);
  event_severity_set("investigate", "footstep", 15, 0.07);
  event_severity_set("investigate", "footstep_sprint", 10, 0.1);
  event_severity_set("investigate", "footstep_walk", 20, 0.05);
  event_severity_set("investigate", "unresponsive_teammate", 20, 0.05);
  event_severity_set("investigate", "window_open", 0, 0.2);
  event_severity_set("investigate", "ally_hurt_peripheral", 0, 0.1);
  event_severity_set("cover_blown", "sight", 2, 0.45);
  event_severity_set("cover_blown", "saw_corpse", 0, 0.3);
  event_severity_set("cover_blown", "found_corpse", 0, 0.3);
  event_severity_set("cover_blown", "gunshot_teammate", 10, 0.1);
  event_severity_set("cover_blown", "silenced_shot", 5, 0.23);
  event_severity_set("cover_blown", "gunshot", 3, 0.4);
  event_severity_set("cover_blown", "explode", 2, 0.8);
  event_severity_set("cover_blown", "seek_backup", 0, 0);
  event_severity_set("cover_blown", "grenade danger", 0, 0.9);
  event_severity_set("cover_blown", "glass_destroyed", 2, 0.5);
  event_severity_set("cover_blown", "light_killed", 3, 0.4);
  event_severity_set("cover_blown", "bulletwhizby", 3, 0.4);
  event_severity_set("combat", "projectile_impact");
  event_severity_set("combat", "attack");
  event_severity_set("combat", "damage");
  event_severity_set("combat", "proximity");
  event_severity_set("combat", "ally_damaged");
  event_severity_set("combat", "ally_killed");
}

function event_severity_compare(var_0, var_1) {
  var_2 = level.stealth.event_priority[var_0] - level.stealth.event_priority[var_1];
  return var_2;
}

function event_severity_shift(var_0, var_1) {
  var_2 = level.stealth.event_priority[var_0] + var_1;

  foreach(var_4 in level.stealth.event_priority) {
    if(var_4 == var_2) {
      return var_5;
    }
  }

  return var_0;
}

function event_severity_set(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(level.stealth.event_severity)) {
    level.stealth.event_severity = [];
  }

  if(!isDefined(level.stealth.event_escalation)) {
    level.stealth.event_escalation = [];
  }

  if(!isDefined(level.stealth.event_escalation_scalars)) {
    level.stealth.event_escalation_scalars = [];
  }

  if(!isDefined(level.stealth.event_escalation_to_combat)) {
    level.stealth.event_escalation_to_combat = [];
  }

  level.stealth.event_severity[var_1] = var_0;
  level.stealth.event_escalation[var_1] = var_2;
  level.stealth.event_escalation_scalars[var_1] = var_3;
  level.stealth.event_escalation_to_combat[var_1] = var_4;
}

function event_severity_get(var_0) {
  return level.stealth.event_severity[var_0];
}

function event_escalation_get(var_0) {
  return level.stealth.event_escalation[var_0];
}

function event_escalation_scalar_get(var_0) {
  return level.stealth.event_escalation_scalars[var_0];
}

function event_escalation_to_combat_get(var_0) {
  return level.stealth.event_escalation_to_combat[var_0];
}

function event_escalation_clear() {
  self.stealth.event_escalation_count = undefined;
  self.stealth.event_escalation_scalar = 0;
}

function event_listener_thread() {
  self notify("event_listener_thread");
  self endon("event_listener_thread");
  self endon("death");

  for(;;) {
    scripts\engine\utility::ent_flag_wait("stealth_enabled");
    self waittill("ai_events", var_0);

    if(!scripts\engine\utility::ent_flag("stealth_enabled")) {
      continue;
    }

    if(self.ignoreall || self isragdoll()) {
      continue;
    }

    foreach(var_2 in var_0) {
      if(!isDefined(var_2.entity)) {
        continue;
      }

      if(issentient(var_2.entity) && (var_2.entity.ignoreme || var_2.entity.notarget)) {
        continue;
      }

      if(isDefined(var_2.entity.ownervehicle)) {
        if(var_2.entity.ownervehicle.vehicletype == "capital_ship") {
          continue;
        }
      }

      var_2.typeorig = var_2.type;
      var_2.receiver = self;
      var_3 = event_severity_get(var_2.type);
      var_4 = undefined;
      var_5 = undefined;
      var_6 = undefined;

      if(isDefined(var_3)) {
        if(!isDefined(self.disableescalation) && var_3 != "combat") {
          var_4 = event_escalation_get(var_2.type);
          var_5 = event_escalation_scalar_get(var_2.type);
          var_6 = event_escalation_to_combat_get(var_2.type);

          if(var_4 > 0) {
            if(!isDefined(self.stealth.event_escalation_count)) {
              self.stealth.event_escalation_count = [];
            }

            if(!isDefined(self.stealth.event_escalation_count[var_2.type])) {
              self.stealth.event_escalation_count[var_2.type] = 0;
            }

            if(isDefined(var_6) && self.stealth.event_escalation_count[var_2.type] + 1 >= var_6) {
              var_3 = event_severity_shift(var_3, 2);
            } else if(self.stealth.event_escalation_count[var_2.type] + 1 >= var_4) {
              var_3 = event_severity_shift(var_3, 1);
            } else if(self.stealth.event_escalation_scalar + var_5 >= 1) {
              var_3 = event_severity_shift(var_3, 1);
            }
          }
        }

        var_2.type = var_3;
      }

      var_7 = scripts\stealth\callbacks::stealth_call_thread(var_2.type, var_2);

      if(istrue(var_7) && isDefined(var_4) && var_2.type != "combat") {
        if(var_4 > 0) {
          self.stealth.event_escalation_count[var_2.typeorig]++;
        }

        self.stealth.event_escalation_scalar += var_5;
      }
    }
  }
}

function entity_is_approved(var_0) {
  switch (var_0.classname) {
    case "script_vehicle_blackhornet":
      return 1;
    default:
      return 0;
  }
}

function event_broadcast_axis(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getaiunittypearray("bad_guys", "all");
  var_6 = squared(var_3);
  var_7 = squared(var_4);
  var_8 = self.team;

  if(!isDefined(var_8)) {
    var_8 = self.agentteam;
  }

  foreach(var_10 in var_5) {
    if(!isalive(var_10)) {
      continue;
    }

    if(var_10 == self) {
      continue;
    }

    if(var_10.team != var_8) {
      continue;
    }

    if(!isDefined(var_10.stealth)) {
      continue;
    }

    var_11 = 0;
    var_12 = distancesquared(var_10.origin, self.origin);

    if(var_12 <= var_6) {
      var_11 = self hastacvis(var_10);
    }

    if(!var_11 && var_12 <= var_7) {
      if(var_10 scripts\stealth\utility::is_visible(self) || var_10 scripts\stealth\utility::is_visible(var_2)) {
        var_11 = 1;
      }
    }

    if(var_10[[var_10.fnisinstealthcombat]]()) {
      if(var_11) {
        var_10 getenemyinfo(var_2);
      }

      continue;
    }

    if(var_11) {
      if(var_10 lastknowntime(var_2) == 0) {
        var_10 aieventlistenerevent(var_0, var_2, self.origin);
      } else {
        var_10 aieventlistenerevent(var_0, var_2, var_2.origin);
      }

      continue;
    }

    if(var_10 canseeperipheral(self)) {
      var_10 aieventlistenerevent(var_1, var_2, self.origin);
    }
  }
}

function event_broadcast_generic(var_0, var_1, var_2, var_3) {
  var_4 = getaiunittypearray("bad_guys");

  if(!isDefined(var_3)) {
    var_3 = level.player;
  }

  var_5 = squared(var_2);

  foreach(var_7 in var_4) {
    if(!isalive(var_7)) {
      continue;
    }

    if(!isDefined(var_7.stealth)) {
      continue;
    }

    if(distancesquared(var_7.origin, var_1) <= var_5) {
      var_7 aieventlistenerevent(var_0, var_3, var_1);
    }
  }
}

function event_broadcast_axis_by_tacsight(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = getaiunittypearray("bad_guys", "all");
  var_8 = var_3 * var_3;

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  var_9 = undefined;

  if(isDefined(var_6)) {
    var_9 = var_6 * var_6;
  }

  if(!isDefined(var_5)) {
    var_5 = var_2;
  }

  foreach(var_11 in var_7) {
    if(!isalive(var_11)) {
      continue;
    }

    if(!isDefined(var_11.stealth)) {
      continue;
    }

    var_12 = distancesquared(var_11.origin, var_2);

    if(var_12 > var_8) {
      continue;
    }

    var_13 = var_4;

    if(var_4 && isDefined(var_9) && var_12 <= var_9) {
      var_13 = 0;
    }

    if(!var_11 hastacvis(var_5, var_13)) {
      continue;
    }

    var_11 aieventlistenerevent(var_0, var_1, var_2);
  }
}

function event_broadcast_axis_by_sight(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  thread event_broadcast_axis_by_sight_thread(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

function event_broadcast_axis_by_sight_thread(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = getaiunittypearray("bad_guys", "all");
  var_8 = var_3 * var_3;

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(!isDefined(var_5)) {
    var_5 = var_2;
  }

  var_9 = 3;
  var_10 = 0;

  foreach(var_12 in var_7) {
    if(!isalive(var_12)) {
      continue;
    }

    if(!isDefined(var_12.stealth)) {
      continue;
    }

    var_13 = distancesquared(var_12.origin, var_2);

    if(var_13 > var_8) {
      continue;
    }

    if(isDefined(var_6) && var_13 <= var_6 * var_6) {
      var_12 aieventlistenerevent(var_0, var_1, var_2);
      continue;
    }

    if(!var_12 hastacvis(var_5, var_4)) {
      if(var_4 && !var_12 aipointinfov(var_2)) {
        continue;
      }

      var_10++;

      if(var_10 > var_9) {
        waitframe();
        var_10 = 0;
      }

      if(!sighttracepassed(var_12 getEye(), var_2, 0, var_1)) {
        continue;
      }
    }

    var_12 aieventlistenerevent(var_0, var_1, var_2);
  }
}