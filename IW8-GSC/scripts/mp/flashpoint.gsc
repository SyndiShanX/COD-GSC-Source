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
  var0 = getDvar("scr_flashpoint_toggle", 0);
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

  if(0 || var0 == "1") {
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

      foreach(var1 in level.players) {
        if(!isDefined(var1.flashpoint_trackingevents)) {
          flashpoint_trackplayerevents(var1);
        }
      }
    } else {
      level notify("disable_flashpoint");
      level.flashpointactive = 0;

      if(level.flashpoint_objectives) {
        foreach(var4 in level.flashpoint_struct.flashpoints) {
          flashpoint_shutdown(var4);
        }
      }
    }

    wait 1;
  }
}

function flashpoint_systemthink() {
  level endon("disable_flashpoint");

  for(;;) {
    foreach(var1 in level.flashpoint_struct.flashpoints) {
      var2 = gettime();

      if(var2 - var1.lasteventtime > 12500) {
        flashpoint_shutdown(var1);
        continue;
      }

      if(isDefined(var1.objective) && var2 - var1.lasteventtime >= 7500 && !istrue(var1.endingsoon)) {
        flashpoint_endingsoon(var1);
      }

      var3 = getarraykeys(var1.events);

      foreach(var5 in var3) {
        if(var2 - var5 > 12500) {
          var1.events = scripts\engine\utility::array_remove_key(var1.events, var5);
        }
      }
    }

    foreach(var9 in level.players) {
      if(!isDefined(var9.flashpoint_trackingevents)) {
        thread flashpoint_trackplayerevents(var9);
      }
    }

    wait 1;
  }
}

function flashpoint_processnewevent(var0, var1, var2, var3) {
  if(!level.flashpointactive) {
    return;
  }

  var4 = (0, 0, 0);

  if(false) {
    var4 = (randomfloatrange(-1000, 1000), randomfloatrange(-1000, 1000), 0);
  }

  if(var3 == "gunfire") {
    var5 = var0.origin + (0, 0, 32);

    if(false) {
      var5 += var4;
    }

    thread playvfx(var5, "flashpoint_kill_s2");
    return;
  }

  var5 = (0, 0, 0);

  if(level.flashpoint_objectives) {
    var5 = vectorlerp(var1.origin + (0, 0, 48), var2.origin + (0, 0, 48), 0.25);
  } else {
    var5 = var2.origin + (0, 0, 48);
  }

  if(false) {
    var5 += var5;
  }

  if(level.flashpoint_objectives) {
    var6 = spawn("script_model", var5);
    var7 = var6 scripts\engine\utility::array_sort_with_func(level.flashpoint_struct.flashpoints, &sortlocationsbydistance);
    var6 delete();

    foreach(var9 in var7) {
      if(distancesquared(var9.curorigin, var5) < level.flashpointmindist) {
        flashpoint_updatepoint(var9, var5, var3, var4);
        return;
      }
    }

    if(level.flashpoint_struct.flashpoints.size >= 2) {
      flashpoint_clearoldestpoint();
    }

    flashpoint_createnew(var5, var3, var4);
  }

  thread playvfx(var5, "flashpoint_kill_s2");
}

function flashpoint_createnew(var0, var1, var2) {
  var3 = spawnStruct();
  var3.curorigin = var0;
  var3.lasteventtime = var1;
  var3.team = "";
  flashpoint_addeventtoqueue(var3, var1, var2);
  level.flashpoint_struct.flashpoints[level.flashpoint_struct.flashpoints.size] = var3;
}

function flashpoint_createmarker(var0) {
  var0.objective = scripts\mp\gameobjects::createobjidobject(var0.curorigin, "neutral", (0, 0, 0), undefined, "any");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var0.objective.objidnum, 0);
  var0.objective.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::update_objective_icon(var0.objective.objidnum, level.iconflashpointneutral);
  scripts\mp\objidpoolmanager::update_objective_setbackground(var0.objective.objidnum, 2);
  var0.objective.lockupdatingicons = 1;
}

function flashpoint_updatepoint(var0, var1, var2, var3) {
  var0 notify("end_update");
  var0 endon("end_update");
  level endon("disable_flashpoint");

  if(!isDefined(var0.objective) && var0.events.size >= 5) {
    flashpoint_createmarker(var0);
  }

  var0.endingsoon = 0;
  var0.lasteventtime = gettime();

  if(isDefined(var0.objective) && level.flashpoint_objectives) {
    scripts\mp\objidpoolmanager::objective_set_pulsate(var0.objective.objidnum, 0);
  } else {
    var0.curorigin = vectorlerp(var0.curorigin, var1, 0.75);
  }

  thread playvfx(var1, "flashpoint_kill_s2");
  flashpoint_addeventtoqueue(var0, var2, var3);
}

function flashpoint_addeventtoqueue(var0, var1, var2) {
  if(!isDefined(var0.events)) {
    var0.events = [];
  }

  var0.events[var1] = var2;

  if(var0.events.size > 8) {
    var3 = [];
    var4 = 0;

    foreach(var6 in var0.events) {
      if(var4 > var0.events.size - 8) {
        var3 = var6;
      }

      var4++;
    }

    var0.events = var3;
    return;
  }
}

function flashpoint_shutdown(var0) {
  var0 notify("end_update");

  if(isDefined(var0.objective) && level.flashpoint_objectives) {
    var0.objective scripts\mp\gameobjects::setvisibleteam("none");
    var0.objective scripts\mp\gameobjects::releaseid();
    var0.objective.visibleteam = "none";
    var0.objective = undefined;
  }

  level.flashpoint_struct.flashpoints = scripts\engine\utility::array_remove(level.flashpoint_struct.flashpoints, var0);
}

function flashpoint_endingsoon(var0) {
  var0.endingsoon = 1;

  if(level.flashpoint_objectives) {
    scripts\mp\objidpoolmanager::objective_set_pulsate(var0.objective.objidnum, 1);
    return;
  }
}

function flashpoint_checkforownerupdate(var0) {
  var1 = 0;
  var2 = 0;
  var3 = "No Change";
  var4 = var0.team;

  foreach(var6 in var0.events) {
    if(var6 == "kill_by_axis") {
      var1++;
      continue;
    }

    if(var6 == "kill_by_allies") {
      var2++;
    }
  }

  if((var1 - 1 > var2 || var2 == 0) && var0.team != "axis" && var1 != 0) {
    if(level.flashpoint_objectives) {
      scripts\mp\objidpoolmanager::update_objective_ownerteam(var0.objidnum, "axis");
      scripts\mp\objidpoolmanager::update_objective_sethot(var0.objidnum, 0);
    }

    var0.team = "axis";
    var3 = "Switch To Axis Owner";
    return;
  }

  if((var2 - 1 > var1 || var1 == 0) && var0.team != "allies" && var2 != 0) {
    if(level.flashpoint_objectives) {
      scripts\mp\objidpoolmanager::update_objective_ownerteam(var0.objidnum, "allies");
      scripts\mp\objidpoolmanager::update_objective_sethot(var0.objidnum, 0);
    }

    var0.team = "allies";
    var3 = "Switch To Allies Owner";
    return;
  }

  if(var0.team != "neutral" && var2 != 0 && var1 != 0) {
    if(level.flashpoint_objectives) {
      scripts\mp\objidpoolmanager::update_objective_ownerteam(var0.objidnum, undefined);
      scripts\mp\objidpoolmanager::update_objective_sethot(var0.objidnum, 1);
    }

    var0.team = "neutral";
    var3 = "Switch To Contested";
    return;
  }
}

function sortlocationsbydistance(var0, var1) {
  return distancesquared(var0.curorigin, self.origin) < distancesquared(var1.curorigin, self.origin);
}

function flashpoint_clearoldestpoint() {
  var0 = undefined;

  foreach(var2 in level.flashpoint_struct.flashpoints) {
    if(!isDefined(var0)) {
      var0 = var2;
      continue;
    }

    if(var2.lasteventtime > var0.lasteventtime) {
      var0 = var2;
    }
  }

  flashpoint_shutdown(var0);
}

function playvfx(var0, var1) {
  playFX(scripts\engine\utility::getfx(var1), var0);
}

function flashpoint_trackplayerevents(var0) {
  var0 endon("disconnect");
  level endon("disable_flashpoint");
  var0.flashpoint_trackingevents = 1;

  for(;;) {
    var0 waittill("begin_firing");
    wait 1;
    flashpoint_processnewevent(var0, undefined, gettime(), "gunfire");
    wait 0.25;
  }
}

function flashpoint_spawnselectionvfx() {
  self endon("disconnect");
  self notify("start_SpawnSelectionThink");
  self endon("start_SpawnSelectionThink");

  while(self.inspawnselection) {
    foreach(var1 in level.players) {
      if(!isalive(var1)) {
        continue;
      }

      if(self.team != var1.team) {
        if(istrue(level.spawnselectionshowenemy)) {
          playfxontagforclients(level._effect["flashpoint_pulse_enemy"], var1, "tag_eye", self);
        }

        continue;
      }

      if(istrue(level.spawnselectionshowfriendly)) {
        if(self.squadindex == var1.squadindex) {
          playfxontagforclients(level._effect["flashpoint_pulse_squad"], var1, "tag_eye", self);
          continue;
        }

        playfxontagforclients(level._effect["flashpoint_pulse_friendly"], var1, "tag_eye", self);
      }
    }

    wait 1.1;
  }
}