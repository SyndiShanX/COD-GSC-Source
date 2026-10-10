/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\flashpoint.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\gameobjects;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\game;
#namespace flashpoint;

function init() {
  level._effect["flashpoint_kill_s2"] = loadfx("vfx/iw8_mp/flashpoint/vfx_fp_gunfight_s2.vfx");
  level._effect["flashpoint_pulse_friendly"] = loadfx("vfx/iw8_mp/flashpoint/vfx_fp_pulse_friendly.vfx");
  level._effect["flashpoint_pulse_squad"] = loadfx("vfx/iw8_mp/flashpoint/vfx_fp_pulse_squad.vfx");
  level._effect["flashpoint_pulse_enemy"] = loadfx("vfx/iw8_mp/flashpoint/vfx_fp_pulse_enemy.vfx");
  var_90d2fed9a87f1697 = getDvar(@ "scr_flashpoint_toggle", 0);
  level.flashpoint_objectives = getDvar(@ "scr_flashpoint_objectives", 0) == "1";
  level.iconflashpointfriendly = "icon_swords_friendly";
  level.iconflashpointenemy = "icon_swords_enemy";
  level.iconflashpointcontested = "icon_swords_contested";
  level.iconflashpointneutral = "icon_swords_neutral";
  level.flashpoint_struct = spawnStruct();
  level.flashpoint_struct.flashpoints = [];
  level.flashpointdebugactive = getdvarint(@ "hash_9f7206466118e24c", 0);

  if(istrue(level.flashpoint_usebigmapsettings)) {
    level.flashpointmindist = 16777216;
  } else {
    level.flashpointmindist = 4194304;
  }

  if(0 || var_90d2fed9a87f1697 == "1") {
    thread flashpoint_systemthink();
    level.flashpointactive = 1;

    setdevdvar(@ "scr_flashpoint_toggle", 1);
  } else {
    setdevdvar(@ "scr_flashpoint_toggle", 0);

    level.flashpointactive = 0;
  }

  thread flashpoint_systemtoggle();

  if(istrue(level.flashpointdebugactive)) {
    function_34b4ca8a02efb2cc();
  }
}

function flashpoint_systemtoggle() {
  while(true) {
    if(getDvar(@ "scr_flashpoint_toggle", 0) != "0") {
      if(level.flashpoint_objectives) {
        thread flashpoint_systemthink();
      }

      level.flashpointactive = 1;

      foreach(player in level.players) {
        if(!isDefined(player.flashpoint_trackingevents)) {
          flashpoint_trackplayerevents(player);
        }
      }
    } else {
      level notify("disable_flashpoint");
      level.flashpointactive = 0;

      if(level.flashpoint_objectives) {
        foreach(flashpoint in level.flashpoint_struct.flashpoints) {
          flashpoint_shutdown(flashpoint);
        }
      }
    }

    wait 1;
  }
}

function flashpoint_systemthink() {
  level endon("disable_flashpoint");

  while(true) {
    foreach(flashpoint in level.flashpoint_struct.flashpoints) {
      timenow = gettime();

      if(timenow - flashpoint.lasteventtime > 12500) {
        flashpoint_shutdown(flashpoint);
        continue;
      }

      if(isDefined(flashpoint.objective) && timenow - flashpoint.lasteventtime >= 7500 && !istrue(flashpoint.endingsoon)) {
        flashpoint_endingsoon(flashpoint);
      }

      keys = getarraykeys(flashpoint.events);

      foreach(key in keys) {
        if(timenow - key > 12500) {
          flashpoint.events = array_remove_key(flashpoint.events, key);
        }
      }
    }

    foreach(player in level.players) {
      if(!isDefined(player.flashpoint_trackingevents)) {
        thread flashpoint_trackplayerevents(player);
      }
    }

    wait 1;
  }
}

function flashpoint_processnewevent(attacker, victim, time, eventtype) {
  if(!level.flashpointactive) {
    return;
  }

  var_5856c0b118701a9f = (0, 0, 0);

  if(false) {
    var_5856c0b118701a9f = (randomfloatrange(-1000, 1000), randomfloatrange(-1000, 1000), 0);
  }

  if(eventtype == "gunfire") {
    origin = attacker.origin + (0, 0, 32);

    if(false) {
      origin += var_5856c0b118701a9f;
    }

    thread playvfx(origin, "flashpoint_kill_s2");
    return;
  }

  origin = (0, 0, 0);

  if(level.flashpoint_objectives) {
    origin = vectorlerp(attacker.origin + (0, 0, 48), victim.origin + (0, 0, 48), 0.25);
  } else {
    origin = victim.origin + (0, 0, 48);
  }

  if(false) {
    origin += var_5856c0b118701a9f;
  }

  if(level.flashpoint_objectives) {
    ent = spawn("script_model", origin);
    var_a618a20a42198fa1 = ent array_sort_with_func(level.flashpoint_struct.flashpoints, &sortlocationsbydistance);
    ent delete();

    foreach(flashpoint in var_a618a20a42198fa1) {
      if(distancesquared(flashpoint.curorigin, origin) < level.flashpointmindist) {
        flashpoint_updatepoint(flashpoint, origin, time, eventtype);
        return;
      }
    }

    if(level.flashpoint_struct.flashpoints.size >= 2) {
      flashpoint_clearoldestpoint();
    }

    flashpoint_createnew(origin, time, eventtype);
  }

  thread playvfx(origin, "flashpoint_kill_s2");
}

function flashpoint_createnew(origin, time, eventtype) {
  flashpoint = spawnStruct();
  flashpoint.curorigin = origin;
  flashpoint.lasteventtime = time;
  flashpoint.team = "";
  flashpoint_addeventtoqueue(flashpoint, time, eventtype);
  level.flashpoint_struct.flashpoints[level.flashpoint_struct.flashpoints.size] = flashpoint;
}

function flashpoint_createmarker(flashpoint) {
  flashpoint.objective = scripts\mp\gameobjects::createobjidobject(flashpoint.curorigin, "neutral", (0, 0, 0), undefined, "any");
  scripts\mp\objidpoolmanager::objective_set_play_intro(flashpoint.objective.objidnum, 0);
  flashpoint.objective.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::update_objective_icon(flashpoint.objective.objidnum, level.iconflashpointneutral);
  scripts\mp\objidpoolmanager::update_objective_setbackground(flashpoint.objective.objidnum, 2);
  flashpoint.objective.lockupdatingicons = 1;
}

function flashpoint_updatepoint(flashpoint, var_6fc81b511db04699, time, eventtype) {
  flashpoint notify("end_update");
  flashpoint endon("end_update");
  level endon("disable_flashpoint");

  if(!isDefined(flashpoint.objective) && flashpoint.events.size >= 5) {
    flashpoint_createmarker(flashpoint);
  }

  flashpoint.endingsoon = 0;
  flashpoint.lasteventtime = gettime();

  if(isDefined(flashpoint.objective) && level.flashpoint_objectives) {
    scripts\mp\objidpoolmanager::objective_set_pulsate(flashpoint.objective.objidnum, 0);
  } else {
    flashpoint.curorigin = vectorlerp(flashpoint.curorigin, var_6fc81b511db04699, 0.75);
  }

  thread playvfx(var_6fc81b511db04699, "flashpoint_kill_s2");
  flashpoint_addeventtoqueue(flashpoint, time, eventtype);
}

function flashpoint_addeventtoqueue(flashpoint, time, eventtype) {
  if(!isDefined(flashpoint.events)) {
    flashpoint.events = [];
  }

  flashpoint.events[time] = eventtype;

  if(flashpoint.events.size > 8) {
    var_8054fa0b4941d3ff = [];
    i = 0;

    foreach(index, event in flashpoint.events) {
      if(i > flashpoint.events.size - 8) {
        var_8054fa0b4941d3ff[index] = event;
      }

      i++;
    }

    flashpoint.events = var_8054fa0b4941d3ff;
  }
}

function flashpoint_shutdown(flashpoint) {
  flashpoint notify("end_update");

  if(isDefined(flashpoint.objective) && level.flashpoint_objectives) {
    flashpoint.objective scripts\mp\gameobjects::setvisibleteam("none");
    flashpoint.objective scripts\mp\gameobjects::releaseid();
    flashpoint.objective.visibleteam = "none";
    flashpoint.objective = undefined;
  }

  level.flashpoint_struct.flashpoints = array_remove(level.flashpoint_struct.flashpoints, flashpoint);
}

function flashpoint_endingsoon(flashpoint) {
  flashpoint.endingsoon = 1;

  if(level.flashpoint_objectives) {
    scripts\mp\objidpoolmanager::objective_set_pulsate(flashpoint.objective.objidnum, 1);
  }
}

function flashpoint_checkforownerupdate(flashpoint) {
  axiskills = 0;
  allieskills = 0;
  switchstring = "No Change";
  startingowner = flashpoint.team;

  foreach(event in flashpoint.events) {
    if(event == "kill_by_axis") {
      axiskills++;
      continue;
    }

    if(event == "kill_by_allies") {
      allieskills++;
    }
  }

  if((axiskills - 1 > allieskills || allieskills == 0) && flashpoint.team != "axis" && axiskills != 0) {
    if(level.flashpoint_objectives) {
      scripts\mp\objidpoolmanager::update_objective_ownerteam(flashpoint.objidnum, "axis");
      scripts\mp\objidpoolmanager::update_objective_sethot(flashpoint.objidnum, 0);
    }

    flashpoint.team = "axis";
    switchstring = "Switch To Axis Owner";
  } else if((allieskills - 1 > axiskills || axiskills == 0) && flashpoint.team != "allies" && allieskills != 0) {
    if(level.flashpoint_objectives) {
      scripts\mp\objidpoolmanager::update_objective_ownerteam(flashpoint.objidnum, "allies");
      scripts\mp\objidpoolmanager::update_objective_sethot(flashpoint.objidnum, 0);
    }

    flashpoint.team = "allies";
    switchstring = "Switch To Allies Owner";
  } else if(flashpoint.team != "neutral" && allieskills != 0 && axiskills != 0) {
    if(level.flashpoint_objectives) {
      scripts\mp\objidpoolmanager::update_objective_ownerteam(flashpoint.objidnum, undefined);
      scripts\mp\objidpoolmanager::update_objective_sethot(flashpoint.objidnum, 1);
    }

    flashpoint.team = "neutral";
    switchstring = "Switch To Contested";
  }

  if(false) {
    println("<dev string:x1c>");
    println("<dev string:x46>");
    println("<dev string:x64>" + startingowner);
    println("<dev string:x77>" + switchstring);
    println("<dev string:x85>" + axiskills);
    println("<dev string:x97>" + allieskills);
    println("<dev string:x1c>");
  }
}

function sortlocationsbydistance(location1, location2) {
  return distancesquared(location1.curorigin, self.origin) < distancesquared(location2.curorigin, self.origin);
}

function flashpoint_clearoldestpoint() {
  oldestpoint = undefined;

  foreach(flashpoint in level.flashpoint_struct.flashpoints) {
    if(!isDefined(oldestpoint)) {
      oldestpoint = flashpoint;
      continue;
    }

    if(flashpoint.lasteventtime > oldestpoint.lasteventtime) {
      oldestpoint = flashpoint;
    }
  }

  if(false) {
    println("<dev string:xab>");
    println("<dev string:xe1>");
    println("<dev string:xab>");
  }

  flashpoint_shutdown(oldestpoint);
}

function function_34b4ca8a02efb2cc() {
  while(true) {
    if(level.flashpointdebugactive == 1) {
      origin = (randomfloatrange(0, 7000), randomfloatrange(0, 7000), randomfloatrange(100, 500));
      thread playvfx(origin, "<dev string:x115>");

      for(i = 0; i < 10; i++) {
        thread playvfx((47318 + randomfloatrange(-1024, 1024), -10783 + randomfloatrange(-1024, 1024), 160 + randomfloatrange(-100, 100)), "<dev string:x115>");
        wait randomfloatrange(0.01, 0.05);
      }
    } else if(level.flashpointdebugactive == 2) {
      thread playvfx((7000, 7000, 100), "<dev string:x115>");
      thread playvfx((-7000, 7000, 100), "<dev string:x115>");
      thread playvfx((7000, -7000, 100), "<dev string:x115>");
      thread playvfx((-7000, -7000, 100), "<dev string:x115>");
    }

    origin = (0, 0, 100);
    thread playvfx(origin, "<dev string:x115>");
    waittime = 1.1;
    wait waittime;
  }
}

function playvfx(origin, effect) {
  playFX(getfx(effect), origin);
}

function flashpoint_trackplayerevents(player) {
  player endon("disconnect");
  level endon("disable_flashpoint");
  player.flashpoint_trackingevents = 1;

  while(true) {
    player waittill("begin_firing");
    wait 1;
    flashpoint_processnewevent(player, undefined, gettime(), "gunfire");
    wait 0.25;
  }
}

function flashpoint_spawnselectionvfx() {
  self endon("disconnect");
  self notify("start_SpawnSelectionThink");
  self endon("start_SpawnSelectionThink");

  while(self.inspawnselection) {
    foreach(player in level.players) {
      if(!isalive(player)) {
        continue;
      }

      if(self.team != player.team) {
        if(istrue(level.spawnselectionshowenemy)) {
          playfxontagforclients(level._effect["flashpoint_pulse_enemy"], player, "tag_eye", self);
        }

        continue;
      }

      if(istrue(level.spawnselectionshowfriendly)) {
        if(self.sessionsquadid == player.sessionsquadid) {
          playfxontagforclients(level._effect["flashpoint_pulse_squad"], player, "tag_eye", self);
          continue;
        }

        playfxontagforclients(level._effect["flashpoint_pulse_friendly"], player, "tag_eye", self);
      }
    }

    wait 1.1;
  }
}