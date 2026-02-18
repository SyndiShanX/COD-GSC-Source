/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\stealth\event.gsc
***********************************************/

#using scripts\core_common\flag_shared;
#using scripts\core_common\stealth\callbacks;
#using scripts\core_common\stealth\debug;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\util_shared;
#namespace event;

function scalevolume(ent, vol) {}

#namespace stealth_event;

function event_init_entity() {
  self thread event_listener_thread();
  self event_entity_core_set_enabled(1);
}

function event_entity_core_set_enabled(enabled) {
  if(!isDefined(level.stealth.core_events)) {
    level.stealth.core_events = ["bulletwhizby", "explode", "footstep", "footstep_run", "footstep_sprint", "footstep_walk", "gunshot", "gunshot_teammate", "projectile_impact", "silenced_shot"];
  }

  if(enabled && !is_true(self.stealth.var_6b368eb9)) {
    foreach(eventname in level.stealth.core_events) {
      self addsentienteventlistener(eventname);
    }

    self.stealth.var_6b368eb9 = 1;
    return;
  }

  if(!enabled && is_true(self.stealth.var_6b368eb9)) {
    foreach(eventname in level.stealth.core_events) {
      self removesentienteventlistener(eventname);
    }

    self.stealth.var_6b368eb9 = undefined;
  }
}

function event_init_level() {
  if(!isDefined(level.stealth.event_priority)) {
    level.stealth.event_priority = [];
  }

  level.stealth.event_priority["investigate"] = 0;
  level.stealth.event_priority["cover_blown"] = 1;
  level.stealth.event_priority["combat"] = 2;
  level.var_b19e4f0a = &event_broadcast_axis;
  level namespace_979752dc::set_stealth_func("broadcast", &event_broadcast_generic);
  event_severity_set("investigate", "footstep", 15, 0.07);
  event_severity_set("investigate", "footstep_sprint", 10, 0.1);
  event_severity_set("investigate", "unresponsive_teammate", 20, 0.05);
  event_severity_set("investigate", "window_open", 0, 0.2);
  event_severity_set("investigate", "ally_hurt_peripheral", 0, 0.1);
  event_severity_set("cover_blown", "sight", 2, 0.45);
  event_severity_set("cover_blown", "saw_corpse", 0, 0.3);
  event_severity_set("cover_blown", "found_corpse", 0, 0.3);
  event_severity_set("cover_blown", "thrown_projectile_impact", 6, 0.15);
  event_severity_set("cover_blown", "silenced_shot", 5, 0.23);
  event_severity_set("cover_blown", "explode", 2, 0.8);
  event_severity_set("cover_blown", "seek_backup", 0, 0);
  event_severity_set("cover_blown", "glass_destroyed", 2, 0.5);
  event_severity_set("cover_blown", "light_killed", 3, 0.4);
  event_severity_set("cover_blown", "door_bash", 4, 0.4);
  event_severity_set("combat", "bulletwhizby");
  event_severity_set("combat", "gunshot");
  event_severity_set("combat", "gunshot_teammate");
  event_severity_set("combat", "projectile_impact");
  event_severity_set("combat", "attack");
  event_severity_set("combat", "damage");
  event_severity_set("combat", "proximity");
  event_severity_set("combat", "ally_damaged");
  event_severity_set("combat", "ally_killed");
}

function event_severity_compare(var_86dfea16, var_3ec8d9e9) {
  assert(isDefined(level.stealth));
  assert(isDefined(level.stealth.event_priority));
  assert(isDefined(level.stealth.event_priority[var_86dfea16]));
  assert(isDefined(level.stealth.event_priority[var_3ec8d9e9]));
  result = level.stealth.event_priority[var_86dfea16] - level.stealth.event_priority[var_3ec8d9e9];
  return result;
}

function event_severity_shift(severity, direction) {
  assert(isDefined(level.stealth));
  assert(isDefined(level.stealth.event_priority));
  assert(isDefined(level.stealth.event_priority[severity]));
  priority = level.stealth.event_priority[severity] + direction;

  foreach(var_64cba2ea, priorityval in level.stealth.event_priority) {
    if(priorityval == priority) {
      return var_64cba2ea;
    }
  }

  return severity;
}

function event_severity_set(severity, eventname, escalation, var_4cca9730, var_af2ae264) {
  assert(!(severity == "<dev string:x38>" && isDefined(var_af2ae264)));
  assert(!(severity == "<dev string:x47>" && isDefined(escalation)));

  if(!isDefined(escalation)) {
    escalation = 0;
  }

  if(!isDefined(var_4cca9730)) {
    var_4cca9730 = 0;
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

  level.stealth.event_severity[eventname] = severity;
  level.stealth.event_escalation[eventname] = escalation;
  level.stealth.event_escalation_scalars[eventname] = var_4cca9730;
  level.stealth.event_escalation_to_combat[eventname] = var_af2ae264;
}

function event_severity_get(eventname) {
  assert(isDefined(level.stealth.event_severity));
  return level.stealth.event_severity[eventname];
}

function event_escalation_get(eventname) {
  assert(isDefined(level.stealth.event_escalation));
  return level.stealth.event_escalation[eventname];
}

function event_escalation_scalar_get(eventname) {
  assert(isDefined(level.stealth.event_escalation_scalars));
  return level.stealth.event_escalation_scalars[eventname];
}

function event_escalation_to_combat_get(eventname) {
  assert(isDefined(level.stealth.event_escalation_to_combat));
  return level.stealth.event_escalation_to_combat[eventname];
}

function event_escalation_clear() {
  self.stealth.event_escalation_count = undefined;
  self.stealth.event_escalation_scalar = 0;
}

function event_listener_thread() {
  self notify(#"event_listener_thread");
  self endon(#"event_listener_thread");
  self endon(#"death");

  while(true) {
    self flag::wait_till("stealth_enabled");
    wait_result = self waittill(#"ai_events");
    waittillframeend();

    if(!self flag::get("stealth_enabled")) {
      continue;
    }

    if(self.ignoreall || self isragdoll()) {
      continue;
    }

    foreach(event in wait_result.events) {
      if(!isDefined(event.entity)) {
        continue;
      }

      if(issentient(event.entity) && (event.entity.ignoreme || is_true(event.entity isnotarget()))) {
        continue;
      }

      event.typeorig = event.type;

      if(event.type == "projectile_impact") {
        if(function_961c59a4(event)) {
          event.type = "thrown_projectile_impact";
        }

        if(isDefined(event.entity.owner)) {
          event.entity = event.entity.owner;
        }
      }

      event.receiver = self;
      var_33a263c4 = event_severity_get(event.type);
      escalation = undefined;
      var_4cca9730 = undefined;
      var_af2ae264 = undefined;

      if(isDefined(var_33a263c4)) {
        if(!isDefined(self.disableescalation) && var_33a263c4 != "combat") {
          escalation = event_escalation_get(event.type);
          var_4cca9730 = event_escalation_scalar_get(event.type);
          var_af2ae264 = event_escalation_to_combat_get(event.type);

          if(escalation > 0) {
            if(!isDefined(self.stealth.event_escalation_count)) {
              self.stealth.event_escalation_count = [];
            }

            if(!isDefined(self.stealth.event_escalation_count[event.type])) {
              self.stealth.event_escalation_count[event.type] = 0;
            }

            if(isDefined(var_af2ae264) && self.stealth.event_escalation_count[event.type] + 1 >= var_af2ae264) {
              var_33a263c4 = event_severity_shift(var_33a263c4, 2);
            } else if(self.stealth.event_escalation_count[event.type] + 1 >= escalation) {
              var_33a263c4 = event_severity_shift(var_33a263c4, 1);
            } else if(self.stealth.event_escalation_scalar + var_4cca9730 >= 1) {
              var_33a263c4 = event_severity_shift(var_33a263c4, 1);
            }
          }
        }

        event.type = var_33a263c4;
      }

      eventhandled = self namespace_b2b86d39::stealth_call(event.type, event);

      if(is_true(eventhandled) && isDefined(escalation) && event.type != "combat") {
        if(escalation > 0) {
          if(!isDefined(self.stealth.event_escalation_count)) {
            self.stealth.event_escalation_count = [];
          }

          if(!isDefined(self.stealth.event_escalation_count[event.typeorig])) {
            self.stealth.event_escalation_count[event.typeorig] = 0;
          }

          self.stealth.event_escalation_count[event.typeorig]++;
        }

        self.stealth.event_escalation_scalar += var_4cca9730;
      }

      typeorig = "<dev string:x51>";

      if(isDefined(event.typeorig)) {
        typeorig = "<dev string:x55>" + (ishash(event.typeorig) ? function_9e72a96(event.typeorig) : event.typeorig) + "<dev string:x5b>";
      }

      event_str = "<dev string:x60>" + (ishash(event.type) ? function_9e72a96(event.type) : event.type) + typeorig;

      if(isDefined(eventhandled) && !eventhandled) {
        event_str += "<dev string:x6b>";
      }

      self thread stealth_debug::function_314b7255(event_str, (1, 1, 1), 1, 0.5, (0, 0, 40), 4);
      self.stealth.ai_event = event.type;
    }
  }
}

function event_broadcast_axis(eventtype, eventtypeperipheral, enemy, rangeauto, rangesight) {
  ais = getactorteamarray(self.team);
  var_1e5aa1c5 = sqr(rangeauto);
  var_1cd11ac7 = sqr(rangesight);

  foreach(ai in ais) {
    if(!isalive(ai)) {
      continue;
    }

    if(ai == self) {
      continue;
    }

    if(!isDefined(ai.stealth)) {
      continue;
    }

    broadcast = 0;
    distsq = distancesquared(ai.origin, self.origin);

    if(distsq <= var_1e5aa1c5) {
      broadcast = self util::has_tac_vis(ai);
    }

    if(!broadcast && distsq <= var_1cd11ac7) {
      if(ai namespace_979752dc::is_visible(self) || ai namespace_979752dc::is_visible(enemy)) {
        broadcast = 1;
      }
    }

    if(!isDefined(ai.fnisinstealthcombat) || ai[[ai.fnisinstealthcombat]]()) {
      if(broadcast) {
        ai getenemyinfo(enemy);
      }

      continue;
    }

    if(broadcast) {
      if(ai lastknowntime(enemy) == 0) {
        ai function_a3fcf9e0(eventtype, enemy, self.origin);
      } else {
        ai function_a3fcf9e0(eventtype, enemy, enemy.origin);
      }

      continue;
    }

    if(ai canseeperipheral(self)) {
      ai function_a3fcf9e0(eventtypeperipheral, enemy, self.origin);
    }
  }
}

function event_broadcast_generic(eventtype, eventposition, eventradius, evententity) {
  ais = getactorteamarray("axis", "team3");

  if(!isDefined(evententity)) {
    evententity = getplayers()[0];
  }

  var_1e5aa1c5 = sqr(eventradius);

  foreach(ai in ais) {
    if(!isalive(ai)) {
      continue;
    }

    if(!isDefined(ai.stealth)) {
      continue;
    }

    if(distancesquared(ai.origin, eventposition) <= var_1e5aa1c5) {
      ai function_a3fcf9e0(eventtype, evententity, eventposition);
    }
  }
}

function event_broadcast_axis_by_tacsight(eventtype, enemy, eventposition, eventradius, var_c5108979, tacposition, var_683e4bdc) {
  ais = getactorteamarray("axis", "team3");
  cradiussq = eventradius * eventradius;

  if(!isDefined(var_c5108979)) {
    var_c5108979 = 1;
  }

  var_ca5ecc3c = undefined;

  if(isDefined(var_683e4bdc)) {
    var_ca5ecc3c = var_683e4bdc * var_683e4bdc;
  }

  if(!isDefined(tacposition)) {
    tacposition = eventposition;
  }

  foreach(ai in ais) {
    if(!isalive(ai)) {
      continue;
    }

    if(!isDefined(ai.stealth)) {
      continue;
    }

    var_d60e3570 = distancesquared(ai.origin, eventposition);

    if(var_d60e3570 > cradiussq) {
      continue;
    }

    var_b03a913a = var_c5108979;

    if(var_c5108979 && isDefined(var_ca5ecc3c) && var_d60e3570 <= var_ca5ecc3c) {
      var_b03a913a = 0;
    }

    if(!ai util::has_tac_vis(tacposition, var_b03a913a)) {
      continue;
    }

    ai function_a3fcf9e0(eventtype, enemy, eventposition);
  }
}

function event_broadcast_axis_by_sight(eventtype, enemy, eventposition, eventradius, var_c5108979, tacposition, autorange) {
  thread event_broadcast_axis_by_sight_thread(eventtype, enemy, eventposition, eventradius, var_c5108979, tacposition, autorange);
}

function event_broadcast_axis_by_sight_thread(eventtype, enemy, eventposition, eventradius, var_c5108979, tacposition, autorange) {
  ais = getactorteamarray("axis", "team3");
  cradiussq = eventradius * eventradius;

  if(!isDefined(var_c5108979)) {
    var_c5108979 = 1;
  }

  if(!isDefined(tacposition)) {
    tacposition = eventposition;
  }

  var_a0229356 = 3;
  var_1389681c = 0;

  foreach(ai in ais) {
    if(!isalive(ai)) {
      continue;
    }

    if(!isDefined(ai.stealth)) {
      continue;
    }

    distsq = distancesquared(ai.origin, eventposition);

    if(distsq > cradiussq) {
      continue;
    }

    if(isDefined(autorange) && distsq <= sqr(autorange)) {
      ai function_a3fcf9e0(eventtype, enemy, eventposition);
      continue;
    }

    if(!ai util::has_tac_vis(tacposition, var_c5108979)) {
      if(var_c5108979 && !ai pointinfov(eventposition)) {
        continue;
      }

      var_1389681c++;

      if(var_1389681c > var_a0229356) {
        waitframe(1);
        var_1389681c = 0;
      }

      if(!sighttracepassed(ai getEye(), eventposition, 0, enemy)) {
        continue;
      }
    }

    ai function_a3fcf9e0(eventtype, enemy, eventposition);
  }
}

function function_961c59a4(event) {
  assert(event.type == "<dev string:x79>");

  if(!isDefined(event.entity.item.name)) {
    return false;
  }

  if(event.entity.item.name == # "hatchet") {
    return true;
  }

  if(event.entity.item.name == # "eq_flash_grenade") {
    return true;
  }

  return false;
}