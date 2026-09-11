/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\event.gsc
***********************************************/

function event_init_entity() {
  thread event_listener_thread();
  event_entity_core_set_enabled(1);
}

function event_entity_core_set_enabled(var0) {
  if(!isDefined(level.stealth.core_events)) {
    level.stealth.core_events = ["bulletwhizby", "explode", "footstep", "footstep_sprint", "footstep_walk", "grenade danger", "gunshot", "gunshot_teammate", "projectile_impact", "silenced_shot", "glass_destroyed"];
  }

  jumpiffalse(var0) LOC_00000099;

  foreach(var2 in level.stealth.core_events) {
    self addaieventlistener(var2);
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

function event_severity_compare(var0, var1) {
  var2 = level.stealth.event_priority[var0] - level.stealth.event_priority[var1];
  return var2;
}

function event_severity_shift(var0, var1) {
  var2 = level.stealth.event_priority[var0] + var1;

  foreach(var4 in level.stealth.event_priority) {
    if(var4 == var2) {
      return var5;
    }
  }

  return var0;
}

function event_severity_set(var0, var1, var2, var3, var4) {
  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(!isDefined(var3)) {
    var3 = 0;
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

  level.stealth.event_severity[var1] = var0;
  level.stealth.event_escalation[var1] = var2;
  level.stealth.event_escalation_scalars[var1] = var3;
  level.stealth.event_escalation_to_combat[var1] = var4;
}

function event_severity_get(var0) {
  return level.stealth.event_severity[var0];
}

function event_escalation_get(var0) {
  return level.stealth.event_escalation[var0];
}

function event_escalation_scalar_get(var0) {
  return level.stealth.event_escalation_scalars[var0];
}

function event_escalation_to_combat_get(var0) {
  return level.stealth.event_escalation_to_combat[var0];
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
    self waittill("ai_events", var0);

    if(!scripts\engine\utility::ent_flag("stealth_enabled")) {
      continue;
    }

    if(self.ignoreall || self isragdoll()) {
      continue;
    }

    foreach(var2 in var0) {
      if(!isDefined(var2.entity)) {
        continue;
      }

      if(issentient(var2.entity) && (var2.entity.ignoreme || var2.entity.notarget)) {
        continue;
      }

      if(isDefined(var2.entity.ownervehicle)) {
        if(var2.entity.ownervehicle.vehicletype == "capital_ship") {
          continue;
        }
      }

      var2.typeorig = var2.type;
      var2.receiver = self;
      var3 = event_severity_get(var2.type);
      var4 = undefined;
      var5 = undefined;
      var6 = undefined;

      if(isDefined(var3)) {
        if(!isDefined(self.disableescalation) && var3 != "combat") {
          var4 = event_escalation_get(var2.type);
          var5 = event_escalation_scalar_get(var2.type);
          var6 = event_escalation_to_combat_get(var2.type);

          if(var4 > 0) {
            if(!isDefined(self.stealth.event_escalation_count)) {
              self.stealth.event_escalation_count = [];
            }

            if(!isDefined(self.stealth.event_escalation_count[var2.type])) {
              self.stealth.event_escalation_count[var2.type] = 0;
            }

            if(isDefined(var6) && self.stealth.event_escalation_count[var2.type] + 1 >= var6) {
              var3 = event_severity_shift(var3, 2);
            } else if(self.stealth.event_escalation_count[var2.type] + 1 >= var4) {
              var3 = event_severity_shift(var3, 1);
            } else if(self.stealth.event_escalation_scalar + var5 >= 1) {
              var3 = event_severity_shift(var3, 1);
            }
          }
        }

        var2.type = var3;
      }

      var7 = scripts\stealth\callbacks::stealth_call_thread(var2.type, var2);

      if(istrue(var7) && isDefined(var4) && var2.type != "combat") {
        if(var4 > 0) {
          self.stealth.event_escalation_count[var2.typeorig]++;
        }

        self.stealth.event_escalation_scalar += var5;
      }
    }
  }
}

function entity_is_approved(var0) {
  switch (var0.classname) {
    case "script_vehicle_blackhornet":
      return 1;
    default:
      return 0;
  }
}

function event_broadcast_axis(var0, var1, var2, var3, var4) {
  var5 = getaiunittypearray("bad_guys", "all");
  var6 = squared(var3);
  var7 = squared(var4);
  var8 = self.team;

  if(!isDefined(var8)) {
    var8 = self.agentteam;
  }

  foreach(var10 in var5) {
    if(!isalive(var10)) {
      continue;
    }

    if(var10 == self) {
      continue;
    }

    if(var10.team != var8) {
      continue;
    }

    if(!isDefined(var10.stealth)) {
      continue;
    }

    var11 = 0;
    var12 = distancesquared(var10.origin, self.origin);

    if(var12 <= var6) {
      var11 = self hastacvis(var10);
    }

    if(!var11 && var12 <= var7) {
      if(var10 scripts\stealth\utility::is_visible(self) || var10 scripts\stealth\utility::is_visible(var2)) {
        var11 = 1;
      }
    }

    if(var10[[var10.fnisinstealthcombat]]()) {
      if(var11) {
        var10 getenemyinfo(var2);
      }

      continue;
    }

    if(var11) {
      if(var10 lastknowntime(var2) == 0) {
        var10 aieventlistenerevent(var0, var2, self.origin);
      } else {
        var10 aieventlistenerevent(var0, var2, var2.origin);
      }

      continue;
    }

    if(var10 canseeperipheral(self)) {
      var10 aieventlistenerevent(var1, var2, self.origin);
    }
  }
}

function event_broadcast_generic(var0, var1, var2, var3) {
  var4 = getaiunittypearray("bad_guys");

  if(!isDefined(var3)) {
    var3 = level.player;
  }

  var5 = squared(var2);

  foreach(var7 in var4) {
    if(!isalive(var7)) {
      continue;
    }

    if(!isDefined(var7.stealth)) {
      continue;
    }

    if(distancesquared(var7.origin, var1) <= var5) {
      var7 aieventlistenerevent(var0, var3, var1);
    }
  }
}

function event_broadcast_axis_by_tacsight(var0, var1, var2, var3, var4, var5, var6) {
  var7 = getaiunittypearray("bad_guys", "all");
  var8 = var3 * var3;

  if(!isDefined(var4)) {
    var4 = 1;
  }

  var9 = undefined;

  if(isDefined(var6)) {
    var9 = var6 * var6;
  }

  if(!isDefined(var5)) {
    var5 = var2;
  }

  foreach(var11 in var7) {
    if(!isalive(var11)) {
      continue;
    }

    if(!isDefined(var11.stealth)) {
      continue;
    }

    var12 = distancesquared(var11.origin, var2);

    if(var12 > var8) {
      continue;
    }

    var13 = var4;

    if(var4 && isDefined(var9) && var12 <= var9) {
      var13 = 0;
    }

    if(!var11 hastacvis(var5, var13)) {
      continue;
    }

    var11 aieventlistenerevent(var0, var1, var2);
  }
}

function event_broadcast_axis_by_sight(var0, var1, var2, var3, var4, var5, var6) {
  thread event_broadcast_axis_by_sight_thread(var0, var1, var2, var3, var4, var5, var6);
}

function event_broadcast_axis_by_sight_thread(var0, var1, var2, var3, var4, var5, var6) {
  var7 = getaiunittypearray("bad_guys", "all");
  var8 = var3 * var3;

  if(!isDefined(var4)) {
    var4 = 1;
  }

  if(!isDefined(var5)) {
    var5 = var2;
  }

  var9 = 3;
  var10 = 0;

  foreach(var12 in var7) {
    if(!isalive(var12)) {
      continue;
    }

    if(!isDefined(var12.stealth)) {
      continue;
    }

    var13 = distancesquared(var12.origin, var2);

    if(var13 > var8) {
      continue;
    }

    if(isDefined(var6) && var13 <= var6 * var6) {
      var12 aieventlistenerevent(var0, var1, var2);
      continue;
    }

    if(!var12 hastacvis(var5, var4)) {
      if(var4 && !var12 aipointinfov(var2)) {
        continue;
      }

      var10++;

      if(var10 > var9) {
        waitframe();
        var10 = 0;
      }

      if(!sighttracepassed(var12 getEye(), var2, 0, var1)) {
        continue;
      }
    }

    var12 aieventlistenerevent(var0, var1, var2);
  }
}