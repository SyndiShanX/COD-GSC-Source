/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\event.gsc
***********************************************/



#using scripts\asm\asm;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\stealth\callbacks;
#using scripts\stealth\debug;
#using scripts\stealth\utility;
#namespace event;

function event_init_entity() {
  thread event_listener_thread();
  self function_4cd0eaf5381f92db(1);
}

function event_init_level() {
  if(!isDefined(level.stealth.event_priority)) {
    level.stealth.event_priority = [];
  }

  level.stealth.event_priority["investigate"] = 0;
  level.stealth.event_priority["cover_blown"] = 1;
  level.stealth.event_priority["combat"] = 2;
  level scripts\stealth\utility::set_stealth_func("broadcast", &event_broadcast_generic);
}

function event_severity_compare(severitya, severityb) {
  assert(isDefined(level.stealth));
  assert(isDefined(level.stealth.event_priority));
  assert(isDefined(level.stealth.event_priority[severitya]));
  assert(isDefined(level.stealth.event_priority[severityb]));
  result = level.stealth.event_priority[severitya] - level.stealth.event_priority[severityb];
  return result;
}

function event_severity_shift(severity, direction) {
  assert(isDefined(level.stealth));
  assert(isDefined(level.stealth.event_priority));
  assert(isDefined(level.stealth.event_priority[severity]));
  priority = level.stealth.event_priority[severity] + direction;

  foreach(priorityval in level.stealth.event_priority) {
    if(priorityval == priority) {
      return var_9339b42bbf1c7735;
    }
  }

  return severity;
}

function event_severity_set(severity, eventname, escalation, escalation_scalar, escalation_to_combat) {
  assert(!(severity == "cover_blown" && isDefined(escalation_to_combat)));
  assert(!(severity == "combat" && isDefined(escalation)));

  if(!isDefined(escalation)) {
    escalation = 0;
  }

  if(!isDefined(escalation_scalar)) {
    escalation_scalar = 0;
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
  level.stealth.event_escalation_scalars[eventname] = escalation_scalar;
  level.stealth.event_escalation_to_combat[eventname] = escalation_to_combat;
}

function event_severity_get(eventname) {
  return function_df4360488e5c458e(eventname);
}

function event_escalation_get(eventname, aient) {
  return function_9846f68b2edd52d5(eventname, aient);
}

function event_escalation_scalar_get(eventname, aient) {
  return function_1473e5c0181c7ad0(eventname, aient);
}

function event_escalation_to_combat_get(eventname, aient) {
  return function_67fee9f22662295c(eventname, aient);
}

function function_ce9fdd8d28d5d8dd(eventname, aient) {
  return function_63c101c16f5f40be(eventname, aient);
}

function event_escalation_clear() {
  self.stealth.event_escalation_count = undefined;
  self.event_escalation_scalar = 0;
}

function function_1f4d13d0f711ba69(event, eventhandled) {
  if(isDefined(level.var_1a6c1600565c49a)) {
    thread[[level.var_1a6c1600565c49a]](event);
  }

  if(function_1d0abf2c82b32237() == -1 || function_1d0abf2c82b32237() == self getentitynumber()) {
    if(isDefined(eventhandled) && eventhandled) {
      if(debug_enabled()) {
        typeorig = "<dev string:x1c>";

        if(isDefined(event.typeorig)) {
          typeorig = "<dev string:x1d>" + event.typeorig + "<dev string:x20>";
        }

        event_str = "<dev string:x22>" + event.type + typeorig;
        thread function_55f9cd7d60a115bb(event_str, (1, 1, 1), 1, 0.5, (0, 0, 40), 4);
      }

      self.stealth.ai_event = event.type;
    }
  }

}

function event_listener_thread() {
  self notify("event_listener_thread");
  self endon("event_listener_thread");
  self endon("death");
  filterexclusions = ["footstep", "footstep_sprint", "footstep_walk", "swim", "swim_sprint", "silenced_shot_impact", "gunshot_impact"];

  while(true) {
    ent_flag_wait("stealth_enabled");
    self waittill("ai_events", events);

    if(!ent_flag("stealth_enabled")) {
      continue;
    }

    if(self.ignoreall || self isragdoll()) {
      continue;
    }

    highestpriority = 0;

    foreach(event in events) {
      if(!isDefined(event.entity)) {
        continue;
      }

      if(istrue(event.var_f049a0914f8eeb8a)) {
        function_1f4d13d0f711ba69(event, 1);
      }
    }
  }
}

function entity_is_approved(entity) {
  switch (entity.classname) {
    case #"hash_adbcc9c8e4f8d955":
      return 1;
    default:
      return 0;
  }
}

function event_broadcast_axis(eventtype, eventtypeperipheral, enemy, rangeauto, rangesight) {
  ais = getaiunittypearray("bad_guys", "all");
  rangeautosq = squared(rangeauto);
  rangesightsq = squared(rangesight);
  myteam = self.team;

  if(!isDefined(myteam)) {
    myteam = self.agentteam;
  }

  assert(isDefined(myteam));
  var_291d5eed4387426d = issentient(enemy);

  foreach(ai in ais) {
    if(!isalive(ai)) {
      continue;
    }

    if(ai == self) {
      continue;
    }

    if(ai.team != myteam) {
      continue;
    }

    if(!isDefined(ai.stealth)) {
      continue;
    }

    broadcast = 0;
    distsq = distancesquared(ai.origin, self.origin);

    if(distsq <= rangeautosq) {
      broadcast = self hastacvis(ai);
    }

    if(!broadcast && distsq <= rangesightsq) {
      if(ai scripts\stealth\utility::is_visible(self) || ai scripts\stealth\utility::is_visible(enemy)) {
        broadcast = 1;
      }
    }

    if(ai[[ai.fnisinstealthcombat]]()) {
      if(broadcast) {
        ai getenemyinfo(enemy);
      }

      continue;
    }

    if(broadcast) {
      if(var_291d5eed4387426d && ai lastknowntime(enemy) == 0) {
        ai aieventlistenerevent(eventtype, enemy, self.origin);
        continue;
      }

      ai aieventlistenerevent(eventtype, enemy, enemy.origin);
    }
  }
}

function event_broadcast_generic(eventtype, eventposition, eventradius, evententity, teamsoverride) {
  ais = [];

  if(isarray(teamsoverride)) {
    ais = getaiarrayinradius(eventposition, eventradius, teamsoverride);
  } else {
    ais = getaiunittypearray("bad_guys");
  }

  if(!isDefined(evententity)) {
    evententity = level.player;
  }

  rangeautosq = squared(eventradius);

  foreach(ai in ais) {
    if(!isalive(ai)) {
      continue;
    }

    if(!isDefined(ai.stealth)) {
      continue;
    }

    if(distancesquared(ai.origin, eventposition) <= rangeautosq) {
      ai aieventlistenerevent(eventtype, evententity, eventposition);
    }
  }
}

function event_broadcast_axis_by_tacsight(eventtype, enemy, eventposition, eventradius, bcheckfov, tacposition, var_81a2fb4f638bbce8) {
  ais = getaiunittypearray("bad_guys", "all");
  cradiussq = eventradius * eventradius;

  if(!isDefined(bcheckfov)) {
    bcheckfov = 1;
  }

  var_8dfd9c1cb37614b0 = undefined;

  if(isDefined(var_81a2fb4f638bbce8)) {
    var_8dfd9c1cb37614b0 = var_81a2fb4f638bbce8 * var_81a2fb4f638bbce8;
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

    var_dbb6869e366c8aa4 = distancesquared(ai.origin, eventposition);

    if(var_dbb6869e366c8aa4 > cradiussq) {
      continue;
    }

    var_771837493a52b2f7 = bcheckfov;

    if(bcheckfov && isDefined(var_8dfd9c1cb37614b0) && var_dbb6869e366c8aa4 <= var_8dfd9c1cb37614b0) {
      var_771837493a52b2f7 = 0;
    }

    if(!ai hastacvis(tacposition, var_771837493a52b2f7)) {
      continue;
    }

    ai aieventlistenerevent(eventtype, enemy, eventposition);
  }
}

function event_broadcast_axis_by_sight(eventtype, enemy, eventposition, eventradius, bcheckfov, tacposition, autorange) {
  thread event_broadcast_axis_by_sight_thread(eventtype, enemy, eventposition, eventradius, bcheckfov, tacposition, autorange);
}

function event_broadcast_axis_by_sight_thread(eventtype, enemy, eventposition, eventradius, bcheckfov, tacposition, autorange) {
  ais = getaiunittypearray("bad_guys", "all");
  cradiussq = eventradius * eventradius;

  if(!isDefined(bcheckfov)) {
    bcheckfov = 1;
  }

  if(!isDefined(tacposition)) {
    tacposition = eventposition;
  }

  var_2068a3efd793afba = 3;
  var_c9787abb0668d729 = 0;

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

    if(isDefined(autorange) && distsq <= autorange * autorange) {
      ai aieventlistenerevent(eventtype, enemy, eventposition);
      continue;
    }

    if(!ai hastacvis(tacposition, bcheckfov)) {
      if(bcheckfov && !ai aipointinfov(eventposition)) {
        continue;
      }

      var_c9787abb0668d729++;

      if(var_c9787abb0668d729 > var_2068a3efd793afba) {
        waitframe();
        var_c9787abb0668d729 = 0;

        if(!isalive(ai)) {
          continue;
        }
      }

      if(!sighttracepassed(ai getEye(), eventposition, 0, enemy)) {
        continue;
      }
    }

    ai aieventlistenerevent(eventtype, enemy, eventposition);
  }
}

function function_1d0abf2c82b32237() {
  return getdvarint(@ "ai_debugentindex");
}