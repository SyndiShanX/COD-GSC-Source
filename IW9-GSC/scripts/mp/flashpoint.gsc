/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\flashpoint.gsc
***********************************************/

init() {
  level._effect["flashpoint_kill_s2"] = loadfx("vfx/iw8_mp/flashpoint/vfx_fp_gunfight_s2.vfx");
  level._effect["flashpoint_pulse_friendly"] = loadfx("vfx/iw8_mp/flashpoint/vfx_fp_pulse_friendly.vfx");
  level._effect["flashpoint_pulse_squad"] = loadfx("vfx/iw8_mp/flashpoint/vfx_fp_pulse_squad.vfx");
  level._effect["flashpoint_pulse_enemy"] = loadfx("vfx/iw8_mp/flashpoint/vfx_fp_pulse_enemy.vfx");
  _id_90D2FED9A87F1697 = getDvar("scr_flashpoint_toggle", 0);
  level.flashpoint_objectives = getDvar("scr_flashpoint_objectives", 0) == "1";
  level.iconflashpointfriendly = "icon_swords_friendly";
  level.iconflashpointenemy = "icon_swords_enemy";
  level.iconflashpointcontested = "icon_swords_contested";
  level.iconflashpointneutral = "icon_swords_neutral";
  level.flashpoint_struct = spawnStruct();
  level.flashpoint_struct.flashpoints = [];
  level.flashpointdebugactive = getdvarint("scr_flashpointdebugactive", 0);

  if(istrue(level.flashpoint_usebigmapsettings))
    level.flashpointmindist = 16777216;
  else
    level.flashpointmindist = 4194304;

  if(0 || _id_90D2FED9A87F1697 == "1") {
    thread flashpoint_systemthink();
    level.flashpointactive = 1;
  } else
    level.flashpointactive = 0;

  thread flashpoint_systemtoggle();
}

flashpoint_systemtoggle() {
  for(;;) {
    if(getDvar("scr_flashpoint_toggle", 0) != "0") {
      if(level.flashpoint_objectives)
        thread flashpoint_systemthink();

      level.flashpointactive = 1;

      foreach(player in level.players) {
        if(!isDefined(player.flashpoint_trackingevents))
          flashpoint_trackplayerevents(player);
      }
    } else {
      level notify("disable_flashpoint");
      level.flashpointactive = 0;

      if(level.flashpoint_objectives) {
        foreach(_id_703F8388035ACE89 in level.flashpoint_struct.flashpoints)
        flashpoint_shutdown(_id_703F8388035ACE89);
      }
    }

    wait 1;
  }
}

flashpoint_systemthink() {
  level endon("disable_flashpoint");

  for(;;) {
    foreach(_id_703F8388035ACE89 in level.flashpoint_struct.flashpoints) {
      _id_4DF1E1A017254690 = gettime();

      if(_id_4DF1E1A017254690 - _id_703F8388035ACE89.lasteventtime > 12500) {
        flashpoint_shutdown(_id_703F8388035ACE89);
        continue;
      }

      if(isDefined(_id_703F8388035ACE89.objective) && _id_4DF1E1A017254690 - _id_703F8388035ACE89.lasteventtime >= 7500 && !istrue(_id_703F8388035ACE89.endingsoon))
        flashpoint_endingsoon(_id_703F8388035ACE89);

      keys = getarraykeys(_id_703F8388035ACE89.events);

      foreach(key in keys) {
        if(_id_4DF1E1A017254690 - key > 12500)
          _id_703F8388035ACE89.events = scripts\engine\utility::array_remove_key(_id_703F8388035ACE89.events, key);
      }
    }

    foreach(player in level.players) {
      if(!isDefined(player.flashpoint_trackingevents))
        thread flashpoint_trackplayerevents(player);
    }

    wait 1;
  }
}

flashpoint_processnewevent(attacker, victim, time, eventtype) {
  if(!level.flashpointactive) {
    return;
  }
  _id_5856C0B118701A9F = (0, 0, 0);

  if(0)
    _id_5856C0B118701A9F = (randomfloatrange(-1000, 1000), randomfloatrange(-1000, 1000), 0);

  if(eventtype == "gunfire") {
    origin = attacker.origin + (0, 0, 32);

    if(0)
      origin = origin + _id_5856C0B118701A9F;

    thread playvfx(origin, "flashpoint_kill_s2");
  } else {
    origin = (0, 0, 0);

    if(level.flashpoint_objectives)
      origin = vectorlerp(attacker.origin + (0, 0, 48), victim.origin + (0, 0, 48), 0.25);
    else
      origin = victim.origin + (0, 0, 48);

    if(0)
      origin = origin + _id_5856C0B118701A9F;

    if(level.flashpoint_objectives) {
      ent = spawn("script_model", origin);
      _id_A618A20A42198FA1 = ent scripts\engine\utility::array_sort_with_func(level.flashpoint_struct.flashpoints, ::sortlocationsbydistance);
      ent delete();

      foreach(_id_703F8388035ACE89 in _id_A618A20A42198FA1) {
        if(distancesquared(_id_703F8388035ACE89.curorigin, origin) < level.flashpointmindist) {
          flashpoint_updatepoint(_id_703F8388035ACE89, origin, time, eventtype);
          return;
        }
      }

      if(level.flashpoint_struct.flashpoints.size >= 2)
        flashpoint_clearoldestpoint();

      flashpoint_createnew(origin, time, eventtype);
    }

    thread playvfx(origin, "flashpoint_kill_s2");
  }
}

flashpoint_createnew(origin, time, eventtype) {
  _id_703F8388035ACE89 = spawnStruct();
  _id_703F8388035ACE89.curorigin = origin;
  _id_703F8388035ACE89.lasteventtime = time;
  _id_703F8388035ACE89.team = "";
  flashpoint_addeventtoqueue(_id_703F8388035ACE89, time, eventtype);
  level.flashpoint_struct.flashpoints[level.flashpoint_struct.flashpoints.size] = _id_703F8388035ACE89;
}

flashpoint_createmarker(_id_703F8388035ACE89) {
  _id_703F8388035ACE89.objective = scripts\mp\gameobjects::createobjidobject(_id_703F8388035ACE89.curorigin, "neutral", (0, 0, 0), undefined, "any");
  scripts\mp\objidpoolmanager::objective_set_play_intro(_id_703F8388035ACE89.objective.objidnum, 0);
  _id_703F8388035ACE89.objective.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::update_objective_icon(_id_703F8388035ACE89.objective.objidnum, level.iconflashpointneutral);
  scripts\mp\objidpoolmanager::update_objective_setbackground(_id_703F8388035ACE89.objective.objidnum, 2);
  _id_703F8388035ACE89.objective.lockupdatingicons = 1;
}

flashpoint_updatepoint(_id_703F8388035ACE89, _id_6FC81B511DB04699, time, eventtype) {
  _id_703F8388035ACE89 notify("end_update");
  _id_703F8388035ACE89 endon("end_update");
  level endon("disable_flashpoint");

  if(!isDefined(_id_703F8388035ACE89.objective) && _id_703F8388035ACE89.events.size >= 5)
    flashpoint_createmarker(_id_703F8388035ACE89);

  _id_703F8388035ACE89.endingsoon = 0;
  _id_703F8388035ACE89.lasteventtime = gettime();

  if(isDefined(_id_703F8388035ACE89.objective) && level.flashpoint_objectives)
    scripts\mp\objidpoolmanager::objective_set_pulsate(_id_703F8388035ACE89.objective.objidnum, 0);
  else
    _id_703F8388035ACE89.curorigin = vectorlerp(_id_703F8388035ACE89.curorigin, _id_6FC81B511DB04699, 0.75);

  thread playvfx(_id_6FC81B511DB04699, "flashpoint_kill_s2");
  flashpoint_addeventtoqueue(_id_703F8388035ACE89, time, eventtype);
}

flashpoint_addeventtoqueue(_id_703F8388035ACE89, time, eventtype) {
  if(!isDefined(_id_703F8388035ACE89.events))
    _id_703F8388035ACE89.events = [];

  _id_703F8388035ACE89.events[time] = eventtype;

  if(_id_703F8388035ACE89.events.size > 8) {
    _id_8054FA0B4941D3FF = [];
    _id_AC0E594AC96AA3A8 = 0;

    foreach(index, event in _id_703F8388035ACE89.events) {
      if(_id_AC0E594AC96AA3A8 > _id_703F8388035ACE89.events.size - 8)
        _id_8054FA0B4941D3FF[index] = event;

      _id_AC0E594AC96AA3A8++;
    }

    _id_703F8388035ACE89.events = _id_8054FA0B4941D3FF;
  }
}

flashpoint_shutdown(_id_703F8388035ACE89) {
  _id_703F8388035ACE89 notify("end_update");

  if(isDefined(_id_703F8388035ACE89.objective) && level.flashpoint_objectives) {
    _id_703F8388035ACE89.objective scripts\mp\gameobjects::setvisibleteam("none");
    _id_703F8388035ACE89.objective scripts\mp\gameobjects::releaseid();
    _id_703F8388035ACE89.objective.visibleteam = "none";
    _id_703F8388035ACE89.objective = undefined;
  }

  level.flashpoint_struct.flashpoints = scripts\engine\utility::array_remove(level.flashpoint_struct.flashpoints, _id_703F8388035ACE89);
}

flashpoint_endingsoon(_id_703F8388035ACE89) {
  _id_703F8388035ACE89.endingsoon = 1;

  if(level.flashpoint_objectives)
    scripts\mp\objidpoolmanager::objective_set_pulsate(_id_703F8388035ACE89.objective.objidnum, 1);
}

flashpoint_checkforownerupdate(_id_703F8388035ACE89) {
  _id_F46DE3669E2ACD79 = 0;
  _id_18606785039C7630 = 0;
  _id_2DC841AFF232FB90 = "No Change";
  _id_AB2D6F4CBA464964 = _id_703F8388035ACE89.team;

  foreach(event in _id_703F8388035ACE89.events) {
    if(event == "kill_by_axis") {
      _id_F46DE3669E2ACD79++;
      continue;
    }

    if(event == "kill_by_allies")
      _id_18606785039C7630++;
  }

  if((_id_F46DE3669E2ACD79 - 1 > _id_18606785039C7630 || _id_18606785039C7630 == 0) && _id_703F8388035ACE89.team != "axis" && _id_F46DE3669E2ACD79 != 0) {
    if(level.flashpoint_objectives) {
      scripts\mp\objidpoolmanager::update_objective_ownerteam(_id_703F8388035ACE89.objidnum, "axis");
      scripts\mp\objidpoolmanager::update_objective_sethot(_id_703F8388035ACE89.objidnum, 0);
    }

    _id_703F8388035ACE89.team = "axis";
    _id_2DC841AFF232FB90 = "Switch To Axis Owner";
  } else if((_id_18606785039C7630 - 1 > _id_F46DE3669E2ACD79 || _id_F46DE3669E2ACD79 == 0) && _id_703F8388035ACE89.team != "allies" && _id_18606785039C7630 != 0) {
    if(level.flashpoint_objectives) {
      scripts\mp\objidpoolmanager::update_objective_ownerteam(_id_703F8388035ACE89.objidnum, "allies");
      scripts\mp\objidpoolmanager::update_objective_sethot(_id_703F8388035ACE89.objidnum, 0);
    }

    _id_703F8388035ACE89.team = "allies";
    _id_2DC841AFF232FB90 = "Switch To Allies Owner";
  } else if(_id_703F8388035ACE89.team != "neutral" && _id_18606785039C7630 != 0 && _id_F46DE3669E2ACD79 != 0) {
    if(level.flashpoint_objectives) {
      scripts\mp\objidpoolmanager::update_objective_ownerteam(_id_703F8388035ACE89.objidnum, undefined);
      scripts\mp\objidpoolmanager::update_objective_sethot(_id_703F8388035ACE89.objidnum, 1);
    }

    _id_703F8388035ACE89.team = "neutral";
    _id_2DC841AFF232FB90 = "Switch To Contested";
  }
}

sortlocationsbydistance(_id_0FCF7E6E6D8C4861, _id_0FCF7B6E6D8C41C8) {
  return distancesquared(_id_0FCF7E6E6D8C4861.curorigin, self.origin) < distancesquared(_id_0FCF7B6E6D8C41C8.curorigin, self.origin);
}

flashpoint_clearoldestpoint() {
  _id_FCDEE31281119324 = undefined;

  foreach(_id_703F8388035ACE89 in level.flashpoint_struct.flashpoints) {
    if(!isDefined(_id_FCDEE31281119324)) {
      _id_FCDEE31281119324 = _id_703F8388035ACE89;
      continue;
    }

    if(_id_703F8388035ACE89.lasteventtime > _id_FCDEE31281119324.lasteventtime)
      _id_FCDEE31281119324 = _id_703F8388035ACE89;
  }

  flashpoint_shutdown(_id_FCDEE31281119324);
}

playvfx(origin, effect) {
  playFX(scripts\engine\utility::getfx(effect), origin);
}

flashpoint_trackplayerevents(player) {
  player endon("disconnect");
  level endon("disable_flashpoint");
  player.flashpoint_trackingevents = 1;

  for(;;) {
    player waittill("begin_firing");
    wait 1.0;
    flashpoint_processnewevent(player, undefined, gettime(), "gunfire");
    wait 0.25;
  }
}

flashpoint_spawnselectionvfx() {
  self endon("disconnect");
  self notify("start_SpawnSelectionThink");
  self endon("start_SpawnSelectionThink");

  while(self.inspawnselection) {
    foreach(player in level.players) {
      if(!isalive(player)) {
        continue;
      }
      if(self.team != player.team) {
        if(istrue(level.spawnselectionshowenemy))
          playfxontagforclients(level._effect["flashpoint_pulse_enemy"], player, "tag_eye", self);

        continue;
      }

      if(istrue(level.spawnselectionshowfriendly)) {
        if(self._id_0FF97225579DE16A == player._id_0FF97225579DE16A) {
          playfxontagforclients(level._effect["flashpoint_pulse_squad"], player, "tag_eye", self);
          continue;
        }

        playfxontagforclients(level._effect["flashpoint_pulse_friendly"], player, "tag_eye", self);
      }
    }

    wait 1.1;
  }
}