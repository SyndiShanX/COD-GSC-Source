/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\stealth\event.gsc
**************************************/

#using scripts\common\system;
#using scripts\common\values;
#using scripts\engine\utility;
#using scripts\stealth\debug;
#using scripts\stealth\utility;
#namespace event;

function private autoexec __init__system__() {
  system::register(#"stealth_events", #"val", &pre_main, undefined);
}

function private pre_main() {
  if(isDefined(level.gamemodebundle) && isDefined(level.gamemodebundle.aieventlist)) {
    val::set("\x13rC>T\xc2\x1e\xaa\xb4u\x1c\xd3=\xee", "\xa8+s\x99ms4\xbe\xa8\x8348", level.gamemodebundle.aieventlist);
  }
}

function event_init_entity() {
  thread event_listener_thread();
  self function_76460814d82df4ee(1);
}

function event_init_level() {
  if(!isDefined(level.stealth.event_priority)) {
    level.stealth.event_priority = [];
  }

  level.stealth.event_priority["\xc2\x99.K\xdd\x9fBw>]\x8e"] = 0;
  level.stealth.event_priority["\x8e\x86U\b\xe9s\xa7\xb1\x87\x99\xb9"] = 1;
  level.stealth.event_priority["\xe3\xd0\xc3e\x85h"] = 2;
  level utility::set_stealth_func("\xe5\xd3M\xe3\x05\x16\x1euu", &event_broadcast_generic);
}

function event_severity_compare(severitya, severityb) {
  assert(isDefined(level.stealth));
  assert(isDefined(level.stealth.event_priority));
  assert(isDefined(level.stealth.event_priority[severitya]));
  assert(isDefined(level.stealth.event_priority[severityb]));
  result = level.stealth.event_priority[severitya] - level.stealth.event_priority[severityb];
  return result;
}

function event_escalation_clear() {
  self.stealth.event_escalation_count = undefined;
  self.event_escalation_scalar = 0;
}

function function_89e10d44b1a1e140(event, eventhandled) {
  if(isDefined(level.var_c7f53b580e68739f)) {
    thread[[level.var_c7f53b580e68739f]](event);
  }

  if(function_78793b915840ceba() == -1 || function_78793b915840ceba() == self getentitynumber()) {
    if(isDefined(eventhandled) && eventhandled) {
      if(debug::debug_enabled()) {
        typeorig = "<dev string:x24>";

        if(isDefined(event.typeorig)) {
          typeorig = "<dev string:x28>" + event.typeorig + "<dev string:x2e>";
        }

        event_str = "<dev string:x33>" + event.type + typeorig;
        thread debug::function_3e870c8e5a0ad5e2(event_str, (1, 1, 1), 1, 0.5, (0, 0, 40), 4);
      }

      self.stealth.ai_event = event.type;
    }
  }

}

function event_listener_thread() {
  self notify("\x10X\x94\xe4\x1a\x81\x83ba\x83\x8e\x96}\xf2\xda\xda\x9b\\5\xf5C");
  self endon("\x10X\x94\xe4\x1a\x81\x83ba\x83\x8e\x96}\xf2\xda\xda\x9b\\5\xf5C");
  self endon("\x1e\xfd\xd1\xa2\a");
  filterexclusions = ["3\xdb\xb7tn:\x95\xe0", "\x82\xe4/D\x10Z\x7f\x11\x031\x94:\xddY>", "]\xa0\xfb\x14$N\xda\xdb\x06\x0e\x1a\x99\x01", "\x04N\xf5\xdf", "\x9bG\xf18/\xbb\x9aF\xc3\xf5#", "\xbc\a\r\x1dx\xe7i\x93\az\xee\xd6\xd7\xb8G\xbbl\xf5\xec\xa6", "k\x83\xdb6\xf8Wz`Q\x95N\x88\x8eu"];

  while(true) {
    utility::ent_flag_wait("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");
    self waittill("\xb0\xd2\xaf\xca\xec\xb2s\x8e\x9b", events);

    if(!utility::ent_flag("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3")) {
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

      if(istrue(event.var_c666681b7cb7ce2f)) {
        function_89e10d44b1a1e140(event, 1);
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
  ais = getaiunittypearray("\x9a\x1f\x83\x1bs=\x13\xf8", "\xc0\xc6J");
  rangeautosq = squared(rangeauto);
  rangesightsq = squared(rangesight);
  myteam = self.team;

  if(!isDefined(myteam)) {
    myteam = self.agentteam;
  }

  assert(isDefined(myteam));
  var_4f329cdbb905063c = issentient(enemy);

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
      if(ai utility::is_visible(self) || ai utility::is_visible(enemy)) {
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
      if(var_4f329cdbb905063c && ai lastknowntime(enemy) == 0) {
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
    ais = getaiunittypearray("\x9a\x1f\x83\x1bs=\x13\xf8");
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

function event_broadcast_axis_by_tacsight(eventtype, enemy, eventposition, eventradius, bcheckfov, tacposition, var_89993f76c77c6421) {
  ais = getaiunittypearray("\x9a\x1f\x83\x1bs=\x13\xf8", "\xc0\xc6J");
  cradiussq = eventradius * eventradius;

  if(!isDefined(bcheckfov)) {
    bcheckfov = 1;
  }

  var_f445237f54ad5955 = undefined;

  if(isDefined(var_89993f76c77c6421)) {
    var_f445237f54ad5955 = var_89993f76c77c6421 * var_89993f76c77c6421;
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

    var_a58141bdd46ebfc1 = distancesquared(ai.origin, eventposition);

    if(var_a58141bdd46ebfc1 > cradiussq) {
      continue;
    }

    var_acc5d5a4b0b96cfe = bcheckfov;

    if(bcheckfov && isDefined(var_f445237f54ad5955) && var_a58141bdd46ebfc1 <= var_f445237f54ad5955) {
      var_acc5d5a4b0b96cfe = 0;
    }

    if(!ai hastacvis(tacposition, var_acc5d5a4b0b96cfe)) {
      continue;
    }

    ai aieventlistenerevent(eventtype, enemy, eventposition);
  }
}

function event_broadcast_axis_by_sight(eventtype, enemy, eventposition, eventradius, bcheckfov, tacposition, autorange) {
  thread event_broadcast_axis_by_sight_thread(eventtype, enemy, eventposition, eventradius, bcheckfov, tacposition, autorange);
}

function event_broadcast_axis_by_sight_thread(eventtype, enemy, eventposition, eventradius, bcheckfov, tacposition, autorange) {
  ais = getaiunittypearray("\x9a\x1f\x83\x1bs=\x13\xf8", "\xc0\xc6J");
  cradiussq = eventradius * eventradius;

  if(!isDefined(bcheckfov)) {
    bcheckfov = 1;
  }

  if(!isDefined(tacposition)) {
    tacposition = eventposition;
  }

  var_8b5b8efc2d3c77e7 = 3;
  var_4a21e1800dbbd5f0 = 0;

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

      var_4a21e1800dbbd5f0++;

      if(var_4a21e1800dbbd5f0 > var_8b5b8efc2d3c77e7) {
        waitframe();
        var_4a21e1800dbbd5f0 = 0;

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

function function_78793b915840ceba() {
  return getdvarint(@ "ai_debugentindex");
}