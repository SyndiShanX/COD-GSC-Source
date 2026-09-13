/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\threat_sight.gsc
***********************************************/

threat_sight_set_enabled(enabled) {
  _id_7F6280793295798B = _func_7A21AA652F0613B0();
  _func_24E85292B191399C(enabled);
  threat_sight_set_dvar(enabled);

  if(!enabled && _id_7F6280793295798B) {
    level notify("threat_sight_audio_disabled");

    foreach(player in level.players)
    player thread _id_9B25540DA1B89219();
  } else if(enabled && !_id_7F6280793295798B)
    level notify("threat_sight_enabled");

  _id_CD207438E3E764E6 = getaiarray();

  foreach(guy in _id_CD207438E3E764E6) {
    if(isalive(guy) && isDefined(guy._id_9329445A125D4443))
      guy _meth_24CB3B5E0D4216B1(guy._id_9329445A125D4443);
  }

  if(enabled && !_id_7F6280793295798B)
    level thread _id_468DA1365698EABF();
}

threat_sight_set_dvar(enabled) {
  if(enabled && !_func_7A21AA652F0613B0()) {
    return;
  }
  setsaveddvar("ai_threatSight", enabled);
  level thread threat_sight_set_dvar_display(enabled);
}

threat_sight_set_dvar_display(enabled) {
  self notify("threat_sight_set_dvar_display");
  self endon("threat_sight_set_dvar_display");

  if(!enabled)
    wait 1.0;

  if(getdvarint("ai_threatusedisplay", 0))
    setsaveddvar("ai_threatSightDisplay", enabled);

  setDvar("dvar_21B72D8C9FF7A1B3", enabled);
}

threat_sight_enabled() {
  if(!getdvarint("ai_threatSight"))
    return 0;

  if(self == level)
    return _func_7A21AA652F0613B0();

  return isDefined(self.threatsight) && self.threatsight;
}

threat_sight_player_entity_state_set(ai, statename) {
  if(!isDefined(self.stealth)) {
    return;
  }
  switch (statename) {
    case "combat_hunt":
      ai setthreatsight(self, 0.0);
      break;
    case "investigate":
      if(isDefined(ai.enemy) && ai.enemy == self)
        ai setthreatsight(self, 1.0);

      break;
    case "death":
      ai setthreatsight(self, 0.0);
      break;
  }
}

threat_sight_force_visible(_id_BCE7C35AE555FE5B, _id_246AEE6688CC8EAE) {
  self _meth_D955A85131DC6E69(_id_BCE7C35AE555FE5B, _id_246AEE6688CC8EAE);
  end = gettime() + int(1000.0 * _id_246AEE6688CC8EAE);
  entnum = _id_BCE7C35AE555FE5B getentitynumber();

  if(!isDefined(self.stealth.force_visible))
    self.stealth.force_visible = [];

  if(isDefined(self.stealth.force_visible[entnum]))
    self.stealth.force_visible[entnum].end = max(self.stealth.force_visible[entnum].end, end);
  else {
    self.stealth.force_visible[entnum] = spawnStruct();
    self.stealth.force_visible[entnum].end = end;
  }

  self.stealth.force_visible[entnum].ent = _id_BCE7C35AE555FE5B;
  thread threat_sight_force_visible_thread();
}

threat_sight_force_visible_thread() {
  if(istrue(self.stealth.force_visible_thread)) {
    return;
  }
  self notify("threat_sight_force_visible_thread");
  self endon("threat_sight_force_visible_thread");
  self endon("death");
  self.stealth.force_visible_thread = 1;
  waittime = 0.05;

  while(isDefined(self.stealth.force_visible) && self.stealth.force_visible.size > 0) {
    _id_64F88D0441939203 = gettime();
    _id_91CA07907A589301 = [];

    foreach(key, _id_5C3BFB25E4E70F12 in self.stealth.force_visible) {
      if(_id_64F88D0441939203 < _id_5C3BFB25E4E70F12.end && issentient(_id_5C3BFB25E4E70F12.ent) && !self cansee(_id_5C3BFB25E4E70F12.ent)) {
        if(isPlayer(_id_5C3BFB25E4E70F12.ent)) {
          _id_ABD22263A9A2A0A9 = self getthreatsight(_id_5C3BFB25E4E70F12.ent);
          _id_3D4B09D94DF0885A = _func_910A912F327B8D34(_id_5C3BFB25E4E70F12.ent);
          _id_5C3BFB25E4E70F12.ent thread threat_sight_player_sight_audio(1, max(_id_3D4B09D94DF0885A, _id_ABD22263A9A2A0A9));
        }

        continue;
      }

      _id_91CA07907A589301[_id_91CA07907A589301.size] = key;
    }

    foreach(key in _id_91CA07907A589301)
    self.stealth.force_visible[key] = undefined;

    wait(waittime);
  }

  self.stealth.force_visible = undefined;
  self.stealth.force_visible_thread = undefined;
}

_id_468DA1365698EABF() {
  level endon("threat_sight_audio_disabled");

  if(!isDefined(level.stealth.fnthreatsightplayersightaudio))
    level waittill("threat_sight_audio_enabled");

  while(!isDefined(level.players))
    waitframe();

  for(;;) {
    if(getdvarfloat("ai_threatSightFakeThreat") <= 0.0) {
      foreach(player in level.players) {
        if(!isalive(player) || !isDefined(player.stealth)) {
          continue;
        }
        player thread threat_sight_player_sight_audio(_func_8CE5803B7D377D72(player), _func_910A912F327B8D34(player));
      }
    }

    waitframe();
  }
}

threat_sight_fake(origin, amount) {
  self notify("threat_sight_fake");
  self endon("threat_sight_fake");
  setsaveddvar("ai_threatSightFakeThreat", amount);
  setsaveddvar("ai_threatSightFakeX", origin[0]);
  setsaveddvar("ai_threatSightFakeY", origin[1]);
  setsaveddvar("ai_threatSightFakeZ", origin[2]);
  _id_3D4B09D94DF0885A = _func_910A912F327B8D34(self);

  while(amount > 0) {
    thread threat_sight_player_sight_audio(1, max(_id_3D4B09D94DF0885A, amount));
    wait 0.15;
  }

  thread threat_sight_player_sight_audio(0, max(_id_3D4B09D94DF0885A, amount));
}

threat_sight_player_sight_audio(_id_5A80AEB955D466DC, maxthreat, _id_67E8151F4DFC690B) {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnthreatsightplayersightaudio))
    self thread[[level.stealth.fnthreatsightplayersightaudio]](_id_5A80AEB955D466DC, maxthreat, _id_67E8151F4DFC690B);
}

_id_9B25540DA1B89219() {
  if(isDefined(level.stealth) && isDefined(level.stealth._id_585390079B597CD6))
    self thread[[level.stealth._id_585390079B597CD6]]();
}