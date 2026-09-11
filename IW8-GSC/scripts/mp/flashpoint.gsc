/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\flashpoint.gsc
***********************************************/

function init() {
  level._effect["flashpoint_kill_s1"] = loadfx("vfx/iw8_mp/flashpoint/vfx_fp_gunfight_s1.vfx");
  level._effect["flashpoint_kill_s2"] = loadfx("vfx/iw8_mp/flashpoint/vfx_fp_gunfight_s2.vfx");
  level._effect["flashpoint_kill_s3"] = loadfx("vfx/iw8_mp/flashpoint/vfx_fp_gunfight_s3.vfx");
  level._effect["flashpoint_gunfire_s1"] = loadfx("vfx/iw8_mp/flashpoint/vfx_fp_gunfight_small_s1.vfx");
  level._effect["flashpoint_pulse_friendly"] = loadfx("vfx/iw8_mp/flashpoint/vfx_fp_pulse_friendly.vfx");
  level._effect["flashpoint_pulse_squad"] = loadfx("vfx/iw8_mp/flashpoint/vfx_fp_pulse_squad.vfx");
  level._effect["flashpoint_pulse_enemy"] = loadfx("vfx/iw8_mp/flashpoint/vfx_fp_pulse_enemy.vfx");
  var_0 = getDvar("scr_flashpoint_toggle", 0);
  level.flashpoint_objectives = getDvar("scr_flashpoint_objectives", 0) == "1";
  level.iconflashpointfriendly = "icon_swords_friendly";
  level.iconflashpointenemy = "icon_swords_enemy";
  level.iconflashpointcontested = "icon_swords_contested";
  level.iconflashpointneutral = "icon_swords_neutral";
  level.flashpoint_struct = spawnStruct();
  level.flashpoint_struct.flashpoints = [];
  level.flashpointdebugactive = getdvarint("scr_flashpointDebugActive", 0);

  if(istrue(level.flashpoint_usebigmapsettings)) {
    level.flashpointmindist = 16777216;
  } else {
    level.flashpointmindist = 4194304;
  }

  if(0 || var_0 == "1") {
    thread flashpoint_systemthink();
    level.flashpointactive = 1;
  } else {
    level.flashpointactive = 0;
  }

  thread flashpoint_systemtoggle();
}

function flashpoint_systemtoggle() {
  for(;;) {
    if(getDvar("scr_flashpoint_toggle", 0) != "0") {
      if(level.flashpoint_objectives) {
        thread flashpoint_systemthink();
      }

      level.flashpointactive = 1;

      foreach(var_1 in level.players) {
        if(!isDefined(var_1.flashpoint_trackingevents)) {
          flashpoint_trackplayerevents(var_1);
        }
      }
    } else {
      level notify("disable_flashpoint");
      level.flashpointactive = 0;

      if(level.flashpoint_objectives) {
        foreach(var_4 in level.flashpoint_struct.flashpoints) {
          flashpoint_shutdown(var_4);
        }
      }
    }

    wait 1;
  }
}

function flashpoint_systemthink() {
  level endon("disable_flashpoint");

  for(;;) {
    foreach(var_1 in level.flashpoint_struct.flashpoints) {
      var_2 = gettime();

      if(var_2 - var_1.lasteventtime > 12500) {
        flashpoint_shutdown(var_1);
        continue;
      }

      if(isDefined(var_1.objective) && var_2 - var_1.lasteventtime >= 7500 && !istrue(var_1.endingsoon)) {
        flashpoint_endingsoon(var_1);
      }

      var_3 = getarraykeys(var_1.events);

      foreach(var_5 in var_3) {
        if(var_2 - var_5 > 12500) {
          var_1.events = scripts\engine\utility::array_remove_key(var_1.events, var_5);
        }
      }
    }

    foreach(var_9 in level.players) {
      if(!isDefined(var_9.flashpoint_trackingevents)) {
        thread flashpoint_trackplayerevents(var_9);
      }
    }

    wait 1;
  }
}

function flashpoint_processnewevent(var_0, var_1, var_2, var_3) {
  if(!level.flashpointactive) {
    return;
  }

  var_4 = (0, 0, 0);

  if(false) {
    var_4 = (randomfloatrange(-1000, 1000), randomfloatrange(-1000, 1000), 0);
  }

  if(var_3 == "gunfire") {
    var_5 = var_0.origin + (0, 0, 32);

    if(false) {
      var_5 += var_4;
    }

    thread playvfx(var_5, "flashpoint_kill_s2");
    return;
  }

  var_5 = (0, 0, 0);

  if(level.flashpoint_objectives) {
    var_5 = vectorlerp(var_1.origin + (0, 0, 48), var_2.origin + (0, 0, 48), 0.25);
  } else {
    var_5 = var_2.origin + (0, 0, 48);
  }

  if(false) {
    var_5 += var_5;
  }

  if(level.flashpoint_objectives) {
    var_6 = spawn("script_model", var_5);
    var_7 = var_6 scripts\engine\utility::array_sort_with_func(level.flashpoint_struct.flashpoints, &sortlocationsbydistance);
    var_6 delete();

    foreach(var_9 in var_7) {
      if(distancesquared(var_9.curorigin, var_5) < level.flashpointmindist) {
        flashpoint_updatepoint(var_9, var_5, var_3, var_4);
        return;
      }
    }

    if(level.flashpoint_struct.flashpoints.size >= 2) {
      flashpoint_clearoldestpoint();
    }

    flashpoint_createnew(var_5, var_3, var_4);
  }

  thread playvfx(var_5, "flashpoint_kill_s2");
}

function flashpoint_createnew(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.curorigin = var_0;
  var_3.lasteventtime = var_1;
  var_3.team = "";
  flashpoint_addeventtoqueue(var_3, var_1, var_2);
  level.flashpoint_struct.flashpoints[level.flashpoint_struct.flashpoints.size] = var_3;
}

function flashpoint_createmarker(var_0) {
  var_0.objective = scripts\mp\gameobjects::createobjidobject(var_0.curorigin, "neutral", (0, 0, 0), undefined, "any");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_0.objective.objidnum, 0);
  var_0.objective.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::update_objective_icon(var_0.objective.objidnum, level.iconflashpointneutral);
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_0.objective.objidnum, 2);
  var_0.objective.lockupdatingicons = 1;
}

function flashpoint_updatepoint(var_0, var_1, var_2, var_3) {
  var_0 notify("end_update");
  var_0 endon("end_update");
  level endon("disable_flashpoint");

  if(!isDefined(var_0.objective) && var_0.events.size >= 5) {
    flashpoint_createmarker(var_0);
  }

  var_0.endingsoon = 0;
  var_0.lasteventtime = gettime();

  if(isDefined(var_0.objective) && level.flashpoint_objectives) {
    scripts\mp\objidpoolmanager::objective_set_pulsate(var_0.objective.objidnum, 0);
  } else {
    var_0.curorigin = vectorlerp(var_0.curorigin, var_1, 0.75);
  }

  thread playvfx(var_1, "flashpoint_kill_s2");
  flashpoint_addeventtoqueue(var_0, var_2, var_3);
}

function flashpoint_addeventtoqueue(var_0, var_1, var_2) {
  if(!isDefined(var_0.events)) {
    var_0.events = [];
  }

  var_0.events[var_1] = var_2;

  if(var_0.events.size > 8) {
    var_3 = [];
    var_4 = 0;

    foreach(var_6 in var_0.events) {
      if(var_4 > var_0.events.size - 8) {
        var_3 = var_6;
      }

      var_4++;
    }

    var_0.events = var_3;
    return;
  }
}

function flashpoint_shutdown(var_0) {
  var_0 notify("end_update");

  if(isDefined(var_0.objective) && level.flashpoint_objectives) {
    var_0.objective scripts\mp\gameobjects::setvisibleteam("none");
    var_0.objective scripts\mp\gameobjects::releaseid();
    var_0.objective.visibleteam = "none";
    var_0.objective = undefined;
  }

  level.flashpoint_struct.flashpoints = scripts\engine\utility::array_remove(level.flashpoint_struct.flashpoints, var_0);
}

function flashpoint_endingsoon(var_0) {
  var_0.endingsoon = 1;

  if(level.flashpoint_objectives) {
    scripts\mp\objidpoolmanager::objective_set_pulsate(var_0.objective.objidnum, 1);
    return;
  }
}

function flashpoint_checkforownerupdate(var_0) {
  var_1 = 0;
  var_2 = 0;
  var_3 = "No Change";
  var_4 = var_0.team;

  foreach(var_6 in var_0.events) {
    if(var_6 == "kill_by_axis") {
      var_1++;
      continue;
    }

    if(var_6 == "kill_by_allies") {
      var_2++;
    }
  }

  if((var_1 - 1 > var_2 || var_2 == 0) && var_0.team != "axis" && var_1 != 0) {
    if(level.flashpoint_objectives) {
      scripts\mp\objidpoolmanager::update_objective_ownerteam(var_0.objidnum, "axis");
      scripts\mp\objidpoolmanager::update_objective_sethot(var_0.objidnum, 0);
    }

    var_0.team = "axis";
    var_3 = "Switch To Axis Owner";
    return;
  }

  if((var_2 - 1 > var_1 || var_1 == 0) && var_0.team != "allies" && var_2 != 0) {
    if(level.flashpoint_objectives) {
      scripts\mp\objidpoolmanager::update_objective_ownerteam(var_0.objidnum, "allies");
      scripts\mp\objidpoolmanager::update_objective_sethot(var_0.objidnum, 0);
    }

    var_0.team = "allies";
    var_3 = "Switch To Allies Owner";
    return;
  }

  if(var_0.team != "neutral" && var_2 != 0 && var_1 != 0) {
    if(level.flashpoint_objectives) {
      scripts\mp\objidpoolmanager::update_objective_ownerteam(var_0.objidnum, undefined);
      scripts\mp\objidpoolmanager::update_objective_sethot(var_0.objidnum, 1);
    }

    var_0.team = "neutral";
    var_3 = "Switch To Contested";
    return;
  }
}

function sortlocationsbydistance(var_0, var_1) {
  return distancesquared(var_0.curorigin, self.origin) < distancesquared(var_1.curorigin, self.origin);
}

function flashpoint_clearoldestpoint() {
  var_0 = undefined;

  foreach(var_2 in level.flashpoint_struct.flashpoints) {
    if(!isDefined(var_0)) {
      var_0 = var_2;
      continue;
    }

    if(var_2.lasteventtime > var_0.lasteventtime) {
      var_0 = var_2;
    }
  }

  flashpoint_shutdown(var_0);
}

function playvfx(var_0, var_1) {
  playFX(scripts\engine\utility::getfx(var_1), var_0);
}

function flashpoint_trackplayerevents(var_0) {
  var_0 endon("disconnect");
  level endon("disable_flashpoint");
  var_0.flashpoint_trackingevents = 1;

  for(;;) {
    var_0 waittill("begin_firing");
    wait 1;
    flashpoint_processnewevent(var_0, undefined, gettime(), "gunfire");
    wait 0.25;
  }
}

function flashpoint_spawnselectionvfx() {
  self endon("disconnect");
  self notify("start_SpawnSelectionThink");
  self endon("start_SpawnSelectionThink");

  while(self.inspawnselection) {
    foreach(var_1 in level.players) {
      if(!isalive(var_1)) {
        continue;
      }

      if(self.team != var_1.team) {
        if(istrue(level.spawnselectionshowenemy)) {
          playfxontagforclients(level._effect["flashpoint_pulse_enemy"], var_1, "tag_eye", self);
        }

        continue;
      }

      if(istrue(level.spawnselectionshowfriendly)) {
        if(self.squadindex == var_1.squadindex) {
          playfxontagforclients(level._effect["flashpoint_pulse_squad"], var_1, "tag_eye", self);
          continue;
        }

        playfxontagforclients(level._effect["flashpoint_pulse_friendly"], var_1, "tag_eye", self);
      }
    }

    wait 1.1;
  }
}