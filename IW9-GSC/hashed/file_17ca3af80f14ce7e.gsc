/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_17ca3af80f14ce7e.gsc
***********************************************/

_id_68C57B54D96715BE(ent, ref) {
  ent._id_5A3A4C78B256FD0C = ref;
}

_id_4BEBBB5C8C6E784D(ent) {
  ent._id_5A3A4C78B256FD0C = undefined;
}

_id_212D8F5B276B3F7B(ref, callback) {
  struct = _id_EE4CE9C0D26A5865();
  struct.entercallbacks[ref] = callback;
}

_id_6963AF169A8EBF81(ref, callback) {
  struct = _id_EE4CE9C0D26A5865();
  struct.exitcallbacks[ref] = callback;
}

_id_9013D3E97478C915(ref, callback) {
  struct = _id_EE4CE9C0D26A5865();
  struct.outoftimecallbacks[ref] = callback;
}

_id_ABE54546E3E8F240(ref, callback) {
  struct = _id_EE4CE9C0D26A5865();
  struct.clearcallbacks[ref] = callback;
}

_id_C38B50E3DD763AE3(ent, _id_3E36F415F762070E) {
  if(_id_96378641B22BEA7E(ent))
    return 0;

  if(istrue(_id_3E36F415F762070E) && _id_96378641B22BEA7E(ent))
    return 0;

  return isDefined(ent._id_FDA3C6FCF6638BF3) && ent._id_FDA3C6FCF6638BF3 > 0;
}

_id_6909CACFCF4034CC(ent) {
  if(!isDefined(ent._id_FDA3C6FCF6638BF3))
    ent._id_FDA3C6FCF6638BF3 = 0;

  ent._id_FDA3C6FCF6638BF3++;

  if(ent._id_FDA3C6FCF6638BF3 == 1) {
    if(!isDefined(ent._id_DEC3BE43668A3021) || ent._id_DEC3BE43668A3021 <= 0)
      _id_13D1E809C6B4C18C(ent);
  }
}

_id_9648A478F198A621(ent, _id_D5C909837FD4DEB4) {
  if(!isDefined(ent._id_FDA3C6FCF6638BF3)) {
    if(isDefined(ent)) {
      if(_id_34BE418B2813A498()) {
        iprintlnbold("^3 Ent -> ^1" + ent getentitynumber() + "^3 did not have .spawner variable Defined! (disableaiRegion) ");
        ent hudoutlineenable("outline_cp_teleport_debug");
        iprintlnbold("ent vars:script_suspend_group: ^1" + ent.script_suspend_group + "^5 script_suspend: ^1" + ent.script_suspend);
      }
    }
  }

  if(!istrue(_id_D5C909837FD4DEB4)) {}

  ent._id_FDA3C6FCF6638BF3--;

  if(ent._id_FDA3C6FCF6638BF3 == 0) {
    ent._id_FDA3C6FCF6638BF3 = undefined;

    if(!isDefined(ent._id_DEC3BE43668A3021) || ent._id_DEC3BE43668A3021 <= 0)
      _id_C87CEC962C595206(ent, 0);
  }
}

_id_96378641B22BEA7E(ent) {
  return isDefined(ent._id_DEC3BE43668A3021) && ent._id_DEC3BE43668A3021 > 0;
}

_id_DE8FD4597C7DE8C6(ent) {
  if(!isDefined(ent._id_DEC3BE43668A3021))
    ent._id_DEC3BE43668A3021 = 0;

  ent._id_DEC3BE43668A3021++;

  if(ent._id_DEC3BE43668A3021 == 1) {
    if(isDefined(ent._id_FDA3C6FCF6638BF3) && ent._id_FDA3C6FCF6638BF3 > 0)
      _id_C87CEC962C595206(ent, 0);
  }
}

_id_BBD1D29BB00C640B(ent) {
  ent._id_DEC3BE43668A3021--;

  if(ent._id_DEC3BE43668A3021 == 0) {
    ent._id_DEC3BE43668A3021 = undefined;

    if(isDefined(ent._id_FDA3C6FCF6638BF3) && ent._id_FDA3C6FCF6638BF3 > 0)
      _id_13D1E809C6B4C18C(ent);
  }
}

_id_983ADD621B34ED28(ent, _id_FCEF8D217A441961) {
  ent notify("clear_aiRegion");

  if(_id_C38B50E3DD763AE3(ent, 1))
    _id_C87CEC962C595206(ent, _id_FCEF8D217A441961, 1);

  _id_A92C68F274CD0239 = undefined;

  if(isPlayer(ent))
    _id_A92C68F274CD0239 = ::playerclearcallback;
  else if(isagent(ent))
    _id_A92C68F274CD0239 = ::playerclearcallback;
  else if(isDefined(ent._id_5A3A4C78B256FD0C)) {
    struct = _id_EE4CE9C0D26A5865();
    _id_A92C68F274CD0239 = struct.clearcallbacks[ent._id_5A3A4C78B256FD0C];
  }

  if(isDefined(_id_A92C68F274CD0239))
    ent[[_id_A92C68F274CD0239]]();

  ent._id_5A3A4C78B256FD0C = undefined;
  ent._id_FDA3C6FCF6638BF3 = undefined;
  ent._id_DEC3BE43668A3021 = undefined;
  ent._id_D9680B0125820647 = undefined;
  ent._id_0BAE64961A3976F9 = undefined;
  ent._id_3392EF5B6B742AD5 = undefined;

  if(isDefined(ent._id_CEB9D44B40906C4A)) {
    foreach(trigger in ent._id_CEB9D44B40906C4A)
    trigger.entstouching[ent getentitynumber()] = undefined;

    ent._id_CEB9D44B40906C4A = undefined;
  }

  if(isDefined(ent._id_2BA26FBB56CCE6B5)) {
    foreach(trigger in ent._id_2BA26FBB56CCE6B5)
    trigger.entstouching[ent getentitynumber()] = undefined;

    ent._id_2BA26FBB56CCE6B5 = undefined;
  }
}

_id_7E9F0258159A7BD6() {
  if(istrue(self.allowedintrigger))
    return 0;

  if(!isDefined(level._id_CEB9D44B40906C4A))
    return 0;

  foreach(trigger in level._id_CEB9D44B40906C4A) {
    if(!_id_84F2D42D2D646239(trigger, self)) {
      continue;
    }
    if(self istouching(trigger))
      return 1;
  }

  return 0;
}

_id_528BCC710BB30998(_id_863C619037F3AC74, _id_DA8CEC9BCE12F9CB) {
  _id_04B9D6F93B356408 = 0;

  if(!isDefined(level._id_CEB9D44B40906C4A))
    return _id_04B9D6F93B356408;
  else {
    foreach(trigger in level._id_CEB9D44B40906C4A) {
      if(ispointinvolume(_id_863C619037F3AC74, trigger)) {
        if(isDefined(trigger.script_team) && isDefined(_id_DA8CEC9BCE12F9CB) && trigger.script_team != _id_DA8CEC9BCE12F9CB)
          continue;
        else {
          _id_04B9D6F93B356408 = 1;
          break;
        }
      }
    }
  }

  return _id_04B9D6F93B356408;
}

_id_8370AF6CF6E65620(spawner, trigger) {
  _id_863C619037F3AC74 = spawner.origin;
  _id_04B9D6F93B356408 = 0;

  if(!isDefined(level._id_CEB9D44B40906C4A))
    return undefined;
  else if(_id_044A315340C86E09(_id_863C619037F3AC74, trigger.origin, trigger.struct.radius)) {
    _id_04B9D6F93B356408 = 1;
    trigger = _id_BAC68A34C968C639(spawner, trigger);
  }

  return trigger;
}

_id_044A315340C86E09(point, circlecenter, circleradius) {
  x = point[0];
  y = point[1];

  if((x - circlecenter[0]) * (x - circlecenter[0]) + (y - circlecenter[1]) * (y - circlecenter[1]) <= circleradius * circleradius)
    return 1;
  else
    return 0;
}

_id_4BECAA200DDC0956() {
  if(!scripts\engine\utility::flag_exist("ai_regions_initialized"))
    scripts\engine\utility::flag_init("ai_regions_initialized");

  if(!scripts\engine\utility::flag_exist("ready_for_region_spawning"))
    scripts\engine\utility::flag_init("ready_for_region_spawning");

  if(!isDefined(level._id_CEB9D44B40906C4A))
    level._id_CEB9D44B40906C4A = [];

  level._id_CEB9D44B40906C4A = scripts\engine\utility::array_combine(level._id_CEB9D44B40906C4A, getEntArray("ai_region", "targetname"));
  thread _id_AAA58DF7DB9699E7();
  level thread _id_1A3FB64B55B6E6EE();
}

_id_2B1E89BBEBAB6964() {
  if(!scripts\engine\utility::flag_exist("level_ready_for_script"))
    scripts\engine\utility::flag_init("level_ready_for_script");

  scripts\engine\utility::flag_wait("level_ready_for_script");

  if(isDefined(level._id_FC46CD90F0A40C87))
    [[level._id_FC46CD90F0A40C87]]();

  if(!isDefined(level._id_CEB9D44B40906C4A))
    level._id_CEB9D44B40906C4A = [];

  level._id_CEB9D44B40906C4A = scripts\engine\utility::array_combine(level._id_CEB9D44B40906C4A, getEntArray("ai_region", "targetname"));
  thread _id_AAA58DF7DB9699E7();
}

_id_13D1E809C6B4C18C(ent) {
  _id_2D2D28B1528166D2 = undefined;
  trigger = _id_0F4E12ECCAEFC243(ent);
  triggertype = gettriggertype(ent, trigger);

  if(isPlayer(ent))
    _id_2D2D28B1528166D2 = ::playerentercallback;
  else if(isagent(ent))
    _id_2D2D28B1528166D2 = ::_id_B2A14335ECF202F8;
  else if(isDefined(ent._id_5A3A4C78B256FD0C)) {
    struct = _id_EE4CE9C0D26A5865();
    _id_2D2D28B1528166D2 = struct.entercallbacks[ent._id_5A3A4C78B256FD0C];
  }

  ent notify("aiRegion_cooldown_end");

  if(isDefined(ent._id_D9680B0125820647) && previouslytouchedtriggertype(ent, triggertype)) {
    _id_037DC2F766A2FA2A = ent._id_D9680B0125820647 / 1000;
    ent._id_0BAE64961A3976F9 = int(gettime() + ent._id_D9680B0125820647);
    ent._id_D9680B0125820647 = undefined;
    thread _id_269A6B999CB5F292(ent, _id_037DC2F766A2FA2A);
  } else {
    ent._id_D9680B0125820647 = undefined;
    ent._id_3392EF5B6B742AD5 = triggertype;
    _id_037DC2F766A2FA2A = _id_661D1B3CC3D5A2E4(triggertype);
    ent._id_0BAE64961A3976F9 = int(gettime() + _id_037DC2F766A2FA2A * 1000);
    thread _id_269A6B999CB5F292(ent, _id_037DC2F766A2FA2A);
  }

  if(isDefined(_id_2D2D28B1528166D2))
    ent thread[[_id_2D2D28B1528166D2]]("exit_aiRegion", "clear_aiRegion", triggertype, trigger);
}

_id_C87CEC962C595206(ent, _id_FCEF8D217A441961, _id_704294F906FAD67E) {
  ent notify("exit_aiRegion");
  _id_6166EC335950C5F2 = undefined;

  if(isPlayer(ent))
    _id_6166EC335950C5F2 = ::playerexitcallback;
  else if(isagent(ent))
    _id_6166EC335950C5F2 = ::_id_0D405DEE230E91B4;
  else if(isDefined(ent._id_5A3A4C78B256FD0C)) {
    struct = _id_EE4CE9C0D26A5865();
    _id_6166EC335950C5F2 = struct.exitcallbacks[ent._id_5A3A4C78B256FD0C];
  }

  ent notify("aiRegion_timeout_end");

  if(!istrue(_id_704294F906FAD67E)) {
    if(isDefined(ent._id_0BAE64961A3976F9)) {
      ent._id_D9680B0125820647 = int(max(0, ent._id_0BAE64961A3976F9 - gettime()));
      ent._id_0BAE64961A3976F9 = undefined;
      trigger = _id_0F4E12ECCAEFC243(ent);
      triggertype = gettriggertype(ent, trigger);
      cooldowntime = getcooldowntime(triggertype);
      thread _id_A0C5231A5482846F(ent, cooldowntime);
    }
  }

  if(isDefined(_id_6166EC335950C5F2))
    ent thread[[_id_6166EC335950C5F2]](_id_FCEF8D217A441961, _id_704294F906FAD67E, "clear_aiRegion");
}

_id_A02FD06DF65094C2(ent) {
  _id_106B10573BDEADF0 = undefined;

  if(isPlayer(ent)) {
    _id_775C9A68F9C00019 = 1;

    if(_id_775C9A68F9C00019)
      _id_106B10573BDEADF0 = ::playeroutoftimecallback;
  } else if(isagent(ent)) {
    _id_775C9A68F9C00019 = 1;

    if(_id_775C9A68F9C00019)
      _id_106B10573BDEADF0 = ::playeroutoftimecallback;
  } else if(isDefined(ent._id_5A3A4C78B256FD0C)) {
    struct = _id_EE4CE9C0D26A5865();
    _id_106B10573BDEADF0 = struct.outoftimecallbacks[ent._id_5A3A4C78B256FD0C];
  }

  if(isDefined(_id_106B10573BDEADF0))
    ent thread[[_id_106B10573BDEADF0]]("aiRegion_timeout_end", "clear_aiRegion");
}

_id_269A6B999CB5F292(ent, _id_8DD9F2EB8215A139) {
  if(isPlayer(ent) || isagent(ent))
    ent endon("death");

  ent notify("aiRegion_timeout_end");
  ent endon("aiRegion_timeout_end");
  ent endon("clear_aiRegion");
  wait(_id_8DD9F2EB8215A139);
  thread _id_A02FD06DF65094C2(ent);
}

_id_A0C5231A5482846F(ent, _id_8DD9F2EB8215A139) {
  if(isPlayer(ent) || isagent(ent))
    ent endon("death");

  ent notify("aiRegion_cooldown_end");
  ent endon("aiRegion_cooldown_end");
  ent endon("clear_aiRegion");
  wait(_id_8DD9F2EB8215A139);
  ent._id_D9680B0125820647 = undefined;
  ent._id_3392EF5B6B742AD5 = undefined;
}

playerentercallback(_id_44E306D53285E1F8, _id_93F5DB7E81311353, triggertype, trigger) {
  _id_EE954EF8140D304B = 1;

  if(isDefined(triggertype) && triggertype == "restricted")
    _id_EE954EF8140D304B = 2;

  self._id_77C36C0C605BF302 = trigger;
  trigger notify("spawning_request");
}

_id_B2A14335ECF202F8(_id_44E306D53285E1F8, _id_93F5DB7E81311353, triggertype, trigger) {
  _id_EE954EF8140D304B = 1;

  if(isDefined(triggertype) && triggertype == "restricted")
    _id_EE954EF8140D304B = 2;

  _id_86AFCFB8EB7BF0D2(trigger);
  self._id_77C36C0C605BF302 = trigger;
}

playerexitcallback(_id_FCEF8D217A441961, _id_704294F906FAD67E, _id_93F5DB7E81311353) {
  self._id_77C36C0C605BF302 = undefined;
}

_id_0D405DEE230E91B4(_id_FCEF8D217A441961, _id_704294F906FAD67E, _id_93F5DB7E81311353) {
  self._id_77C36C0C605BF302 = undefined;
  _id_D55ED59C0CE164D3();
}

playeroutoftimecallback(_id_2F57CFAE824CA728, _id_93F5DB7E81311353) {
  trigger = _id_0F4E12ECCAEFC243(self);
  triggertype = gettriggertype(self, trigger);
}

playerclearcallback(_id_93F5DB7E81311353) {}

playeroutoftimeminefield(_id_2F57CFAE824CA728, _id_93F5DB7E81311353) {
  _id_64AC6C50CE3A7C25 = self.origin;
  _id_CAB9F210984BED37 = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 1000), self);

  if(isDefined(_id_CAB9F210984BED37["hittype"] != "hittype_none") && isDefined(_id_CAB9F210984BED37["position"]))
    _id_64AC6C50CE3A7C25 = _id_CAB9F210984BED37["position"];

  mine = spawn("script_model", _id_64AC6C50CE3A7C25);
  mine setModel("ks_minefield_mp");
  mine setentityowner(self);
  mine setotherent(self);
  mine setscriptablepartstate("warning_click", "on", 0);
  _id_3F67BB4D035FB5A1 = playeroutoftimeminefieldinternal(mine, _id_2F57CFAE824CA728, _id_93F5DB7E81311353);

  if(istrue(_id_3F67BB4D035FB5A1))
    wait 2;

  mine delete();
}

playeroutoftimeminefieldinternal(mine, _id_2F57CFAE824CA728, _id_93F5DB7E81311353) {
  self endon("death_or_disconnect");

  if(isDefined(_id_2F57CFAE824CA728))
    self endon(_id_2F57CFAE824CA728);

  if(isDefined(_id_93F5DB7E81311353))
    self endon(_id_93F5DB7E81311353);

  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(0.3);
  mine setscriptablepartstate("explosion", "on", 0);
  wait 0.05;
  self dodamage(2000, self.origin, self, mine, "MOD_EXPLOSIVE", "minefield_mp");
  return 1;
}

killstreakentercallback(_id_44E306D53285E1F8, _id_93F5DB7E81311353, triggertype, trigger) {
  _id_EE954EF8140D304B = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.gametype == "arm" && isDefined(triggertype) && triggertype == "restricted")
    _id_EE954EF8140D304B = 2;

  if(isDefined(self.owner)) {
    if(isPlayer(self.owner))
      self.owner playerentercallback(_id_44E306D53285E1F8, _id_93F5DB7E81311353, triggertype, trigger);
    else if(isagent(self.owner))
      self.owner _id_B2A14335ECF202F8(_id_44E306D53285E1F8, _id_93F5DB7E81311353, triggertype, trigger);
  }
}

killstreakexitcallback(_id_FCEF8D217A441961, _id_704294F906FAD67E, _id_93F5DB7E81311353) {
  if(isDefined(self.owner)) {
    if(isPlayer(self.owner))
      self.owner playerexitcallback(_id_FCEF8D217A441961, _id_704294F906FAD67E, _id_93F5DB7E81311353);
    else if(isagent(self.owner))
      self.owner _id_0D405DEE230E91B4(_id_FCEF8D217A441961, _id_704294F906FAD67E, _id_93F5DB7E81311353);
  }
}

killstreakoutoftimecallback(_id_2F57CFAE824CA728, _id_93F5DB7E81311353) {}

killstreakclearcallback() {
  if(isDefined(self.owner)) {
    if(isPlayer(self.owner))
      self.owner playerclearcallback();
    else if(isagent(self.owner))
      self.owner playerclearcallback();
  }
}

_id_000D1F0B7AA511A0() {
  _id_212D8F5B276B3F7B("killstreak", ::killstreakentercallback);
  _id_6963AF169A8EBF81("killstreak", ::killstreakexitcallback);
  _id_9013D3E97478C915("killstreak", ::killstreakoutoftimecallback);
  _id_ABE54546E3E8F240("killstreak", ::killstreakclearcallback);
}

_id_AAA58DF7DB9699E7() {
  _id_20533273F43DD4E2 = [];

  if(isDefined(level._id_CEB9D44B40906C4A)) {
    foreach(trigger in level._id_CEB9D44B40906C4A) {
      if(!isDefined(trigger._id_9F9F230946BD8FAF))
        trigger._id_9F9F230946BD8FAF = [];

      _id_4B0722170880249F = _id_AFC5010EFFB06A46(trigger);
      _id_20533273F43DD4E2 = scripts\engine\utility::array_add(_id_20533273F43DD4E2, _id_4B0722170880249F);
    }

    level._id_CEB9D44B40906C4A = _id_20533273F43DD4E2;
    scripts\engine\utility::flag_set("ai_regions_initialized");

    foreach(trigger in level._id_CEB9D44B40906C4A) {
      if(!isDefined(trigger._id_9F9F230946BD8FAF))
        trigger._id_9F9F230946BD8FAF = [];

      thread _id_0F4627228B135D0E(trigger);
    }

    if(isDefined(level._id_ACF3FD19390FC26D)) {
      foreach(trigger in level._id_ACF3FD19390FC26D)
      thread _id_C0051AEFF94F97AF(trigger);
    }

    thread stealth_event_propagator();
  }
}

_id_AFC5010EFFB06A46(trigger) {
  _id_0D1FACFF1E900673 = [];

  foreach(_id_CA8D3101C7736449, _id_F8E5E3AA5762A8E7 in level.ambientgroups) {
    if(isarray(_id_F8E5E3AA5762A8E7)) {
      continue;
    }
    if(isarray(_id_F8E5E3AA5762A8E7.spawn_points)) {
      foreach(struct in _id_F8E5E3AA5762A8E7.spawn_points) {
        if(isDefined(struct.script_suspend)) {
          _id_11879C5AF01A1CDE = scripts\engine\utility::ter_op(isDefined(level._id_E9363E4BB08955E4), level._id_E9363E4BB08955E4, "region_spawning_test");

          if(_id_11879C5AF01A1CDE != _id_CA8D3101C7736449) {
            continue;
          }
          _id_CD2708A4B9D60BB9 = _id_8370AF6CF6E65620(struct, trigger);

          if(isDefined(_id_CD2708A4B9D60BB9)) {
            trigger = _id_CD2708A4B9D60BB9;

            if(_id_34BE418B2813A498()) {}
          }
        }
      }
    }
  }

  return trigger;
}

_id_0F4627228B135D0E(trigger) {
  trigger notify("watchaiRegionTrigger");
  trigger endon("watchaiRegionTrigger");
  trigger.entstouching = [];
  scripts\mp\flags::gameflagwait("prematch_done");
  thread _id_3151AD73D3072756(trigger);
  thread _id_56BBA4BF43908338(trigger);
  thread _id_C6C45C44B1CF7FD0(trigger);
}

_id_56BBA4BF43908338(trigger) {
  level endon("game_ended");
  trigger notify("watchaiRegionTriggerEnter");
  trigger endon("watchaiRegionTriggerEnter");

  for(;;) {
    trigger waittill("trigger", ent);

    if(isPlayer(ent) && isDefined(ent.c130)) {
      continue;
    }
    if(!_id_84F2D42D2D646239(trigger, ent)) {
      continue;
    }
    if(!_id_693B7E3703225A8B(ent)) {
      continue;
    }
    _id_8DD05DF654CDBBB0(trigger, ent);
  }
}

_id_3151AD73D3072756(trigger) {
  level endon("game_ended");
  trigger notify("watchaiRegionTriggerExit");
  trigger endon("watchaiRegionTriggerExit");

  for(;;) {
    _id_5C397C9CF7A06802 = trigger.entstouching;

    foreach(id, ent in _id_5C397C9CF7A06802) {
      if(!isDefined(ent))
        trigger.entstouching[id] = undefined;

      if(isDefined(ent) && !trigger istouching(ent))
        _id_985D2EDF83E8270E(trigger, ent);
    }

    waitframe();
  }
}

_id_8DD05DF654CDBBB0(trigger, ent) {
  entnum = ent getentitynumber();

  if(isDefined(trigger.entstouching[entnum])) {
    return;
  }
  trigger.entstouching[entnum] = ent;

  if(!isDefined(ent._id_CEB9D44B40906C4A))
    ent._id_CEB9D44B40906C4A = [];

  _id_5C397C9CF7A06802 = [trigger];

  foreach(_id_DEB4666F1507FCFD in ent._id_CEB9D44B40906C4A)
  _id_5C397C9CF7A06802[_id_5C397C9CF7A06802.size] = _id_DEB4666F1507FCFD;

  ent._id_CEB9D44B40906C4A = _id_5C397C9CF7A06802;
  _id_6909CACFCF4034CC(ent);

  if(isagent(ent)) {
    if(!isDefined(ent.spawner)) {
      if(_id_34BE418B2813A498()) {
        iprintlnbold("^3 Ent -> ^1" + ent getentitynumber() + "^3 did not have .spawner variable Defined! (onEnteraiRegionTrigger) ");
        ent hudoutlineenable("outline_cp_teleport_debug");
      }
    }

    if(!scripts\engine\utility::array_contains(trigger._id_9F9F230946BD8FAF, ent.spawner))
      trigger._id_9F9F230946BD8FAF = scripts\engine\utility::array_add(trigger._id_9F9F230946BD8FAF, ent.spawner);

    ent thread _id_0402C5F663FF803C();
  }
}

_id_0402C5F663FF803C() {
  self endon("clean_up_exit_threads");
  self waittill("death");

  if(istrue(self.nocorpse) || self.damagemod == "MOD_SUICIDE") {
    return;
  }
  foreach(trigger in level._id_CEB9D44B40906C4A) {
    trigger.entstouching[self getentitynumber()] = undefined;

    if(isDefined(self.spawner)) {
      if(scripts\engine\utility::array_contains(trigger._id_9F9F230946BD8FAF, self.spawner))
        trigger._id_9F9F230946BD8FAF = scripts\engine\utility::array_remove(trigger._id_9F9F230946BD8FAF, self.spawner);
    }
  }
}

_id_3B55A5779A740DF1() {
  if(istrue(self.nocorpse) || self.damagemod == "MOD_SUICIDE") {
    return;
  }
  foreach(trigger in level._id_CEB9D44B40906C4A) {
    trigger.entstouching[self getentitynumber()] = undefined;

    if(isDefined(self.spawner)) {
      if(scripts\engine\utility::array_contains(trigger._id_9F9F230946BD8FAF, self.spawner))
        trigger._id_9F9F230946BD8FAF = scripts\engine\utility::array_remove(trigger._id_9F9F230946BD8FAF, self.spawner);
    }
  }

  _id_89F2489A97A98D30 = _id_56A6214AB214D8B1();

  if(isarray(_id_89F2489A97A98D30) && _id_89F2489A97A98D30.size > 0) {
    foreach(trig in _id_89F2489A97A98D30)
    trig notify("spawning_request");
  }
}

_id_985D2EDF83E8270E(trigger, ent) {
  entnum = ent getentitynumber();
  trigger.entstouching[entnum] = undefined;

  if(isagent(ent)) {
    if(!isDefined(ent.spawner)) {
      iprintlnbold("^3 Ent -> ^1" + ent getentitynumber() + "^3 did not have .spawner variable Defined! (onExitaiRegionTrigger)");
      ent hudoutlineenable("outline_cp_teleport_debug");
    }

    if(isDefined(ent.spawner)) {
      if(scripts\engine\utility::array_contains(trigger._id_9F9F230946BD8FAF, ent.spawner))
        trigger._id_9F9F230946BD8FAF = scripts\engine\utility::array_remove(trigger._id_9F9F230946BD8FAF, ent.spawner);
    }
  }

  if(isDefined(ent._id_FDA3C6FCF6638BF3))
    _id_9648A478F198A621(ent);

  ent notify("clean_up_exit_threads");

  if(isDefined(ent._id_CEB9D44B40906C4A)) {
    ent._id_CEB9D44B40906C4A = scripts\engine\utility::array_remove(ent._id_CEB9D44B40906C4A, trigger);

    if(ent._id_CEB9D44B40906C4A.size == 0)
      ent._id_CEB9D44B40906C4A = undefined;
  }
}

_id_C0051AEFF94F97AF(trigger) {
  trigger notify("watchaiRegionSuppressionTrigger");
  trigger endon("watchaiRegionSuppressionTrigger");
  trigger.entstouching = [];
  scripts\mp\flags::gameflagwait("prematch_done");
  thread _id_80B8855F3E789FAF(trigger);
  thread _id_7F4B23124CD6CFB7(trigger);
}

_id_7F4B23124CD6CFB7(trigger) {
  level endon("game_ended");
  trigger notify("watchaiRegionSupressionTriggerEnter");
  trigger endon("watchaiRegionSupressionTriggerEnter");

  for(;;) {
    trigger waittill("trigger", ent);

    if(!_id_693B7E3703225A8B(ent)) {
      continue;
    }
    _id_77576856C3A8FFF5(trigger, ent);
  }
}

_id_80B8855F3E789FAF(trigger) {
  level endon("game_ended");
  trigger notify("watchaiRegionSuppressionTriggerExit");
  trigger endon("watchaiRegionSuppressionTriggerExit");

  for(;;) {
    _id_5C397C9CF7A06802 = trigger.entstouching;

    if(isDefined(_id_5C397C9CF7A06802)) {
      foreach(id, ent in _id_5C397C9CF7A06802) {
        if(!isDefined(ent))
          trigger.entstouching[id] = undefined;

        if(isDefined(ent) && !trigger istouching(ent))
          _id_37227D6593DCC483(trigger, ent);
      }
    }

    waitframe();
  }
}

_id_77576856C3A8FFF5(trigger, ent) {
  entnum = ent getentitynumber();

  if(isDefined(trigger.entstouching[entnum])) {
    return;
  }
  trigger.entstouching[entnum] = ent;

  if(!isDefined(ent._id_2BA26FBB56CCE6B5))
    ent._id_2BA26FBB56CCE6B5 = [];

  _id_5C397C9CF7A06802 = [trigger];

  foreach(_id_742EC9851CE034DA in ent._id_2BA26FBB56CCE6B5)
  _id_5C397C9CF7A06802[_id_5C397C9CF7A06802.size] = _id_742EC9851CE034DA;

  ent._id_2BA26FBB56CCE6B5 = _id_5C397C9CF7A06802;
  _id_DE8FD4597C7DE8C6(ent);
}

_id_37227D6593DCC483(trigger, ent) {
  entnum = ent getentitynumber();
  trigger.entstouching[entnum] = undefined;
  ent._id_2BA26FBB56CCE6B5[trigger getentitynumber()] = undefined;

  if(ent._id_2BA26FBB56CCE6B5.size == 0)
    ent._id_2BA26FBB56CCE6B5 = undefined;

  _id_BBD1D29BB00C640B(ent);
}

_id_84F2D42D2D646239(trigger, ent) {
  if(isDefined(trigger.script_team)) {
    isvehicle = 0;

    if(ent scripts\cp_mp\vehicles\vehicle::isvehicle())
      isvehicle = 1;

    if(isvehicle) {
      if(isvehicle && isDefined(ent.team) && ent.team != "neutral" && ent.team != trigger.script_team)
        return 0;

      if(isvehicle && isDefined(ent.owner) && ent.owner.team != trigger.script_team)
        return 0;

      if(isvehicle && isDefined(ent.occupants)) {
        foreach(_id_F85572CD5F6117C6 in ent.occupants) {
          if(_id_F85572CD5F6117C6.team != trigger.script_team)
            return 0;
        }
      }
    } else if(ent.team != trigger.script_team)
      return 0;
  }

  return 1;
}

_id_693B7E3703225A8B(ent) {
  if(isDefined(ent)) {
    if(isPlayer(ent) || isagent(ent)) {
      if(ent scripts\cp_mp\utility\player_utility::_isalive())
        return 1;
    }

    if(isDefined(ent._id_5A3A4C78B256FD0C)) {
      if(ent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
        if(!istrue(ent.isdestroyed))
          return 1;
      }

      if(isDefined(ent.streakinfo) && _id_51BBCE44958B49F0(ent.streakinfo.streakname))
        return 1;
    }
  }

  return 0;
}

_id_EE4CE9C0D26A5865() {
  struct = level._id_332FB47555F99F3B;

  if(!isDefined(struct)) {
    struct = spawnStruct();
    struct.entercallbacks = [];
    struct.exitcallbacks = [];
    struct.outoftimecallbacks = [];
    struct.clearcallbacks = [];
    level._id_332FB47555F99F3B = struct;
  }

  return struct;
}

_id_51BBCE44958B49F0(streakname) {
  _id_43265C6BAD4D9E1E = 0;

  switch (streakname) {
    case "pac_sentry":
    case "radar_drone_recon":
      _id_43265C6BAD4D9E1E = 1;
      break;
  }

  return _id_43265C6BAD4D9E1E;
}

gettriggertype(ent, trigger) {
  triggertype = "default";

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    return "br";

  if(isDefined(trigger) && isDefined(trigger.script_team))
    return "restricted";

  if(isDefined(ent) && ent scripts\cp_mp\vehicles\vehicle::isvehicle())
    return "default";

  if(isDefined(ent) && isDefined(ent.streakinfo))
    return "default";

  if(isDefined(trigger) && isDefined(trigger.script_noteworthy) && trigger.script_noteworthy == "MineField")
    triggertype = "minefield";

  return triggertype;
}

getcooldowntime(triggertype) {
  switch (triggertype) {
    case "restricted":
    case "minefield":
    case "br":
    case "default":
      return _id_661D1B3CC3D5A2E4(triggertype);
  }

  return undefined;
}

_id_661D1B3CC3D5A2E4(triggertype) {
  switch (triggertype) {
    case "restricted":
    case "minefield":
    case "br":
    case "default":
      return _id_8DD63B9A4A182F0C();
  }

  return undefined;
}

_id_8DD63B9A4A182F0C() {
  _id_037DC2F766A2FA2A = level._id_037DC2F766A2FA2A;

  if(!isDefined(_id_037DC2F766A2FA2A)) {
    _id_037DC2F766A2FA2A = max(0, getdvarfloat("dvar_D7E4068EDFEDB9D4", 3));
    level._id_037DC2F766A2FA2A = _id_037DC2F766A2FA2A;
  }

  return _id_037DC2F766A2FA2A;
}

_id_0F4E12ECCAEFC243(ent) {
  if(isDefined(ent._id_CEB9D44B40906C4A))
    return ent._id_CEB9D44B40906C4A[0];

  return undefined;
}

previouslytouchedtriggertype(_id_7EDFACE381884CA9, _id_D9D739B40FEDD346) {
  _id_1B99BB6CC4AEC0FE = 0;

  if(isDefined(_id_7EDFACE381884CA9._id_3392EF5B6B742AD5)) {
    _id_F4A7B9FD1E2F84F0 = _id_7EDFACE381884CA9._id_3392EF5B6B742AD5;

    if(_id_D9D739B40FEDD346 == _id_F4A7B9FD1E2F84F0)
      _id_1B99BB6CC4AEC0FE = 1;
    else if((_id_D9D739B40FEDD346 == "default" || _id_D9D739B40FEDD346 == "minefield") && (_id_F4A7B9FD1E2F84F0 == "default" || _id_F4A7B9FD1E2F84F0 == "minefield"))
      _id_1B99BB6CC4AEC0FE = 1;
  }

  return _id_1B99BB6CC4AEC0FE;
}

_id_86AFCFB8EB7BF0D2(trigger) {
  self.script_suspend_group = trigger.script_noteworthy;

  if(isDefined(self.spawner))
    self.spawner.script_suspend_group = trigger.script_noteworthy;
}

_id_D55ED59C0CE164D3() {
  self.script_suspend_group = undefined;

  if(isDefined(self.spawner))
    self.spawner.script_suspend_group = undefined;
}

_id_C6C45C44B1CF7FD0(trigger) {
  level endon("game_ended");
  trigger notify("watchaiRegionTriggerRequests");
  trigger endon("watchaiRegionTriggerRequests");

  for(;;) {
    trigger waittill("spawning_request", _id_D97BE0FB72FCA8A9);

    if(!_id_5E1050E3208C8C06()) {
      continue;
    }
    level notify("global_spawning_request", trigger, _id_D97BE0FB72FCA8A9);
  }
}

_id_1A3FB64B55B6E6EE() {
  level endon("game_ended");

  for(;;) {
    level waittill("global_spawning_request", _id_DEB4666F1507FCFD, _id_D97BE0FB72FCA8A9);

    if(!isDefined(_id_DEB4666F1507FCFD)) {
      if(!isDefined(_id_DEB4666F1507FCFD))
        continue;
    }

    _id_854A7E665D4ADAB2 = [];
    _id_20E01991CA5E0385 = 0;
    _id_FEDB346F9B68CE66 = [];
    _id_89F2489A97A98D30 = _id_56A6214AB214D8B1(_id_DEB4666F1507FCFD);

    if(isarray(_id_89F2489A97A98D30) && _id_89F2489A97A98D30.size > 0) {
      foreach(trigger in _id_89F2489A97A98D30)
      _id_FEDB346F9B68CE66 = scripts\engine\utility::array_combine(_id_FEDB346F9B68CE66, trigger._id_9F9F230946BD8FAF);
    }

    _id_E2646E4FD752AE67 = _id_FEE22980F1BE9191(_id_DEB4666F1507FCFD);

    if(isDefined(_id_D97BE0FB72FCA8A9) && isint(_id_D97BE0FB72FCA8A9))
      _id_E2646E4FD752AE67 = _id_D97BE0FB72FCA8A9;

    _id_673D056F46675A63 = scripts\engine\utility::ter_op(_id_18A73A64992DD07D::get_max_agent_count() < getaiarray("axis").size + _id_E2646E4FD752AE67, 1, 0);

    if(!_id_673D056F46675A63) {
      _id_98D19CC13A08F9E1(_id_DEB4666F1507FCFD, _id_E2646E4FD752AE67);
      continue;
    } else {
      _id_5F974F12D8B7CB29(_id_DEB4666F1507FCFD, _id_FEDB346F9B68CE66);
      _id_98D19CC13A08F9E1(_id_DEB4666F1507FCFD, _id_E2646E4FD752AE67);
    }
  }
}

_id_5F974F12D8B7CB29(_id_FD11088F77720495, _id_FEDB346F9B68CE66) {
  _id_20E01991CA5E0385 = 0;
  _id_854A7E665D4ADAB2 = _id_F4117C23B5C99C0B(_id_FD11088F77720495);

  foreach(ai in getaiarray("axis")) {
    if(isDefined(ai.spawner) && scripts\engine\utility::array_contains(_id_FD11088F77720495._id_9F9F230946BD8FAF, ai.spawner)) {
      continue;
    }
    if(isDefined(ai.spawner) && scripts\engine\utility::array_contains(_id_FEDB346F9B68CE66, ai.spawner)) {
      continue;
    }
    if(ai _id_7E4D332E911E1B90::hasenemysightpos()) {
      continue;
    }
    if(ai _id_2B79931B08683E0A::recentlysawenemy()) {
      continue;
    }
    if(_id_00A002C4413D571F(ai.origin)) {
      continue;
    }
    if(ai _id_14F781E51502CC47()) {
      continue;
    }
    if(!ai _id_18A73A64992DD07D::killoff_vis_passed()) {
      continue;
    }
    if(_id_70328E9769B9750F(ai.origin)) {
      continue;
    }
    if(_id_70328E9769B9750F(ai.origin + (0, 0, 50))) {
      continue;
    }
    if(isDefined(ai.script_suspend)) {
      _id_20E01991CA5E0385 = _id_7BD38C394517FF87(ai, _id_FD11088F77720495, _id_20E01991CA5E0385);
      continue;
    }

    _id_20E01991CA5E0385 = _id_4CBE4BA6BC116F99(ai, _id_FD11088F77720495, _id_20E01991CA5E0385);
  }
}

_id_98D19CC13A08F9E1(_id_DEB4666F1507FCFD, _id_CC45C3AC6EC69FEC) {
  level endon("game_ended");
  c = 0;
  _id_854A7E665D4ADAB2 = _id_F4117C23B5C99C0B(_id_DEB4666F1507FCFD);

  foreach(_id_4E289DE92961AB3D in _id_DEB4666F1507FCFD._id_9F9F230946BD8FAF) {
    if(c > _id_CC45C3AC6EC69FEC) {
      break;
    }

    if(scripts\engine\utility::array_contains(_id_854A7E665D4ADAB2, _id_4E289DE92961AB3D)) {
      continue;
    }
    _id_A9237F88BD342861 = _id_4B44DCE2FFDBCC48(_id_4E289DE92961AB3D);
    _id_5E8B303608F19B8C = _id_A9237F88BD342861 + (0, 0, 50);

    if(getdvarint("dvar_5F7C7350754FBFF0", 0) != 0)
      _id_A9237F88BD342861 = _id_5E8B303608F19B8C;

    if(_id_00A002C4413D571F(_id_A9237F88BD342861)) {
      continue;
    }
    if(_id_D43BB847CAB4433F(_id_A9237F88BD342861)) {
      continue;
    }
    if(_id_70328E9769B9750F(_id_A9237F88BD342861)) {
      continue;
    }
    if(_id_70328E9769B9750F(_id_A9237F88BD342861 + (0, 0, 50))) {
      continue;
    }
    _id_11879C5AF01A1CDE = scripts\engine\utility::ter_op(isDefined(level._id_E9363E4BB08955E4), level._id_E9363E4BB08955E4, "region_spawning_test");
    _id_F8E5E3AA5762A8E7 = _id_18A73A64992DD07D::create_module_struct(_id_11879C5AF01A1CDE);
    scripts\cp\cp_spawning_util::set_recent_spawn_time_threshold_override(_id_F8E5E3AA5762A8E7, 1000);
    spawn_point = _id_F8E5E3AA5762A8E7 _id_54F6CD90DD31BBF0::score_ai_spawns([_id_4E289DE92961AB3D]);
    _id_F8E5E3AA5762A8E7.position_ref = undefined;
    _id_F8E5E3AA5762A8E7 _id_54F6CD90DD31BBF0::print_spawner_score_for_factor(spawn_point);

    if(!isDefined(spawn_point)) {
      continue;
    }
    _id_F9D54801507D21F1(_id_F8E5E3AA5762A8E7, _id_4E289DE92961AB3D);
    c++;
  }

  if(c > 0)
    return;
}

_id_F4117C23B5C99C0B(_id_DEB4666F1507FCFD) {
  _id_854A7E665D4ADAB2 = [];

  foreach(ai in getaiarray("axis")) {
    if(isDefined(ai.spawner) && scripts\engine\utility::array_contains(_id_DEB4666F1507FCFD._id_9F9F230946BD8FAF, ai.spawner))
      _id_854A7E665D4ADAB2 = scripts\engine\utility::array_add(_id_854A7E665D4ADAB2, ai.spawner);
  }

  return _id_854A7E665D4ADAB2;
}

_id_FEE22980F1BE9191(_id_DEB4666F1507FCFD, _id_FEDB346F9B68CE66) {
  _id_FD1227D9F622AAA4 = 0;
  _id_854A7E665D4ADAB2 = _id_F4117C23B5C99C0B(_id_DEB4666F1507FCFD);

  foreach(_id_4E289DE92961AB3D in _id_DEB4666F1507FCFD._id_9F9F230946BD8FAF) {
    if(scripts\engine\utility::array_contains(_id_854A7E665D4ADAB2, _id_4E289DE92961AB3D)) {
      continue;
    }
    _id_A9237F88BD342861 = _id_4B44DCE2FFDBCC48(_id_4E289DE92961AB3D);

    if(_id_00A002C4413D571F(_id_A9237F88BD342861)) {
      continue;
    }
    if(_id_D43BB847CAB4433F(_id_A9237F88BD342861)) {
      continue;
    }
    if(_id_70328E9769B9750F(_id_A9237F88BD342861)) {
      continue;
    }
    _id_FD1227D9F622AAA4++;
  }

  if(_id_FD1227D9F622AAA4 > 0) {}

  return _id_FD1227D9F622AAA4;
}

_id_4B44DCE2FFDBCC48(spawner) {
  if(isDefined(spawner.suspended_ai))
    return spawner.suspended_ai.origin;
  else
    return spawner.origin;
}

_id_56A6214AB214D8B1(_id_2FC2F07166AE0E33) {
  _id_16FFA8D76CB46AF1 = [];

  foreach(trigger in level._id_CEB9D44B40906C4A) {
    if(isDefined(_id_2FC2F07166AE0E33) && isent(_id_2FC2F07166AE0E33)) {
      continue;
    }
    if(isDefined(trigger.entstouching) && isarray(trigger.entstouching)) {
      if(_id_5969DF6A64608C4B(trigger))
        _id_16FFA8D76CB46AF1 = scripts\engine\utility::array_add(_id_16FFA8D76CB46AF1, trigger);
    }
  }

  return _id_16FFA8D76CB46AF1;
}

_id_5969DF6A64608C4B(trigger) {
  if(isDefined(trigger.entstouching) && isarray(trigger.entstouching)) {
    foreach(ent in trigger.entstouching) {
      if(isPlayer(ent))
        return 1;
    }
  }

  return 0;
}

_id_14F781E51502CC47() {
  foreach(player in level.players) {
    if(self seerecently(player, 5))
      return 1;
  }

  return 0;
}

_id_00A002C4413D571F(_id_253F5C2C0B6125F6) {
  foreach(player in level.players) {
    if(distancesquared(player.origin, _id_253F5C2C0B6125F6) < 2250000) {
      if(_id_70328E9769B9750F(_id_253F5C2C0B6125F6))
        return 1;
    } else if(_id_70328E9769B9750F(_id_253F5C2C0B6125F6))
      return 1;
  }

  return 0;
}

_id_D43BB847CAB4433F(_id_253F5C2C0B6125F6) {
  foreach(player in level.players) {
    if(player hastacvis(_id_253F5C2C0B6125F6, 0, 64, 1))
      return 1;
  }

  return 0;
}

_id_70328E9769B9750F(_id_253F5C2C0B6125F6) {
  contents = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1, 1, 1);

  foreach(player in level.players) {
    if(scripts\engine\trace::ray_trace_passed(player getEye(), _id_253F5C2C0B6125F6, [player], contents)) {
      if(player scripts\engine\utility::within_fov(player getEye(), player getplayerangles(), _id_253F5C2C0B6125F6, cos(120)))
        return 1;
      else
        return 0;
    }
  }

  return 0;
}

_id_5E1050E3208C8C06() {
  return getdvarint("dvar_9804C42649D377C6", 0) == 1;
}

_id_34BE418B2813A498() {
  return getdvarint("dvar_091F8D0A94101EE4", 0) == 1;
}

_id_BAC68A34C968C639(spawner, trigger) {
  if(!isDefined(trigger._id_9F9F230946BD8FAF))
    trigger._id_9F9F230946BD8FAF = [];

  if(!scripts\engine\utility::array_contains(trigger._id_9F9F230946BD8FAF, spawner))
    trigger._id_9F9F230946BD8FAF = scripts\engine\utility::array_add(trigger._id_9F9F230946BD8FAF, spawner);
  else {}

  return trigger;
}

_id_6B44EE764600D649() {
  self.script_suspend = 1;
}

prespawn_suspended_ai() {
  if(!isDefined(self.script_suspend))
    return undefined;

  if(!isDefined(self.suspended_ai))
    return 0;

  self.count++;

  if(!isDefined(self.og_spawner_origin))
    self.og_spawner_origin = self.origin;

  if(!isDefined(self.og_spawner_angles))
    self.og_spawner_angles = self.angles;

  if(isDefined(self.try_og_origin)) {
    self.origin = self.og_spawner_origin;
    self.angles = self.og_spawner_angles;
  } else {
    self.origin = self.suspended_ai.origin;
    self.angles = self.suspended_ai.angles;
  }

  if(isDefined(self.suspended_ai.suspendvars))
    self.suspendvars = self.suspended_ai.suspendvars;

  return 1;
}

postspawn_suspended_ai() {
  _id_75CD41B6FD79C2A6 = self.spawner.suspended_ai;

  if(isDefined(self.spawner.postspawnresetorigin)) {
    self.spawner.origin = self.og_spawner_origin;
    self.spawner.angles = self.og_spawner_angles;
  }

  thread postspawn_suspend_ai_framedelay(_id_75CD41B6FD79C2A6);

  if(!isDefined(_id_75CD41B6FD79C2A6.suspendvars)) {
    return;
  }
  self.suspendvars = _id_75CD41B6FD79C2A6.suspendvars;
  self.spawner.suspended_ai = undefined;
}

postspawn_suspend_ai_framedelay(_id_75CD41B6FD79C2A6) {
  waittillframeend;
  waittillframeend;

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(_id_75CD41B6FD79C2A6.stealth)) {
    bsmstate = _id_75CD41B6FD79C2A6.stealth.bsmstate;

    if(bsmstate > 1) {
      bsmstate = _id_75CD41B6FD79C2A6.stealth.bsmstate - int((gettime() - _id_75CD41B6FD79C2A6.suspendtime) / 10000);
      bsmstate = int(max(2, bsmstate));
    } else if(bsmstate > 0) {
      bsmstate = _id_75CD41B6FD79C2A6.stealth.bsmstate - int((gettime() - _id_75CD41B6FD79C2A6.suspendtime) / 5000);
      bsmstate = int(max(0, bsmstate));
    }

    state = int_to_stealth_state(bsmstate);
    scripts\stealth\enemy::bt_set_stealth_state(state, _id_75CD41B6FD79C2A6.stealth.investigateevent);
  }
}

int_to_stealth_state(num) {
  switch (num) {
    case 0:
      return "idle";
    case 1:
      return "investigate";
    case 2:
      return "hunt";
    case 3:
      return "combat";
  }
}

_id_7BD38C394517FF87(ai, trigger, _id_20E01991CA5E0385) {
  return ai free_expendable(_id_20E01991CA5E0385);
}

_id_4CBE4BA6BC116F99(ai, trigger, _id_20E01991CA5E0385) {
  ai kill();
  _id_20E01991CA5E0385++;
  return _id_20E01991CA5E0385;
}

free_expendable(_id_20E01991CA5E0385) {
  if(!isDefined(self.spawner) || !isDefined(self.script_suspend))
    return _id_20E01991CA5E0385;

  spawner = self.spawner;
  struct = spawnStruct();
  struct.origin = self.origin;
  struct.angles = self.angles;
  struct.suspendtime = gettime();

  if(isDefined(self.suspendvars))
    struct.suspendvars = self.suspendvars;
  else
    struct.suspendvars = spawnStruct();

  if(isDefined(self.stealth)) {
    struct.stealth = spawnStruct();
    struct.stealth_enabled = 1;
    struct.stealth.bsmstate = self._id_FE5EBEFA740C7106;
    struct.stealth.investigateevent = scripts\aitypes\stealth::_id_9C4A08F7DCD2796B();
  }

  if(isDefined(self.node)) {
    if(isDefined(self.using_goto_node)) {
      if(isDefined(self.node.targetname))
        struct.target = self.node.targetname;

      struct.node = self.node;
    }

    struct.target = self.node.targetname;
  }

  spawner.suspended_ai = struct;

  if(isDefined(self.script_suspend_group) && !isDefined(self.script_free))
    _id_20E01991CA5E0385 = free_groupname(self.script_suspend_group, _id_20E01991CA5E0385);

  return _id_20E01991CA5E0385;
}

free_groupname(groupname, _id_20E01991CA5E0385) {
  if(!isDefined(level.processfreegroupname))
    level.processfreegroupname = [];

  if(isDefined(level.processfreegroupname[groupname]))
    return _id_20E01991CA5E0385;

  level.processfreegroupname[groupname] = 1;
  _id_DA96C8943126A950 = getaiarray("axis");

  if(_id_34BE418B2813A498())
    iprintlnbold("^2groupname Processing - ^1" + groupname);

  foreach(ai in _id_DA96C8943126A950) {
    if(!isDefined(ai.script_suspend_group)) {
      if(_id_34BE418B2813A498())
        iprintlnbold("^2skipped Group Processing for ^1" + groupname + "^2 due to ^1 NO .script_suspend_group ^2var defined");

      continue;
    }

    if(ai.script_suspend_group != groupname) {
      if(_id_34BE418B2813A498()) {
        if(isDefined(ai.script_suspend)) {} else {}

        if(isDefined(ai.script_suspend))
          iprintlnbold("^5ai vars:script_suspend_group: ^1" + ai.script_suspend_group + "^5 script_suspend: ^1" + ai.script_suspend);
        else
          iprintlnbold("^5ai vars:script_suspend_group: ^1" + ai.script_suspend_group + "^5 script_suspend: NOT DEFINED");
      }

      continue;
    }

    ai.script_free = 1;
    _id_20E01991CA5E0385 = ai free_expendable(_id_20E01991CA5E0385);

    if(_id_34BE418B2813A498()) {
      iprintlnbold("^2free_groupname ^1" + groupname + "^2 origin: ^1" + ai.origin);
      iprintlnbold("^5ai vars:script_suspend_group: ^1" + ai.script_suspend_group + "^5 script_suspend: ^1" + ai.script_suspend);
    }

    ai.nocorpse = 1;
    _id_983ADD621B34ED28(ai, 1);
    ai kill();
    _id_20E01991CA5E0385++;
  }

  level.processfreegroupname[groupname] = undefined;
  return _id_20E01991CA5E0385;
}

stealth_event_propagator() {
  level notify("stealth_event_propagator");
  level endon("stealth_event_propagator");
  scripts\engine\utility::flag_wait("stealth_enabled");
  level endon("stealth_enabled");
  _id_4A56F39B88AB0B5D["gunshot"] = _func_9D30FD63965BAFA9("gunshot");
  _id_4A56F39B88AB0B5D["gunshot_teammate"] = _func_9D30FD63965BAFA9("gunshot_teammate");
  _id_4A56F39B88AB0B5D["explosion"] = _func_9D30FD63965BAFA9("explosion");
  _id_4A56F39B88AB0B5D["glass_destroyed"] = _func_9D30FD63965BAFA9("glass_destroyed");
  _id_4A56F39B88AB0B5D["light_killed"] = 800;
  _id_4A56F39B88AB0B5D["bulletwhizby"] = 3000;
  spawners = [];

  foreach(area in level._id_CEB9D44B40906C4A) {
    if(isDefined(area._id_9F9F230946BD8FAF)) {
      foreach(spawner in area._id_9F9F230946BD8FAF) {
        if(!isDefined(spawner)) {
          continue;
        }
        if(scripts\engine\utility::is_equal(spawner.script_noteworthy, "interrogator")) {
          continue;
        }
        if(scripts\engine\utility::is_equal(spawner.script_noteworthy, "escalation_patroller")) {
          continue;
        }
        if(isendstr(spawner.targetname, "ambush_spawner")) {
          continue;
        }
        if(scripts\engine\utility::is_equal(spawner.script_noteworthy, "extra_patrol"))
          spawner.dont_propagate_events_prespawn = 1;

        if(isendstr(spawner.targetname, "backup_spawner"))
          spawner.dont_propagate_events_prespawn = 1;

        spawners[spawners.size] = spawner;
      }
    }
  }

  _id_90940F1C797B8D16 = [];
  _id_81E55CD489351A8E = -10000;

  for(;;) {
    level waittill("stealth_event", event, receiver);

    if(!scripts\engine\utility::array_contains_key(_id_4A56F39B88AB0B5D, event.typeorig)) {
      continue;
    }
    if(scripts\engine\utility::time_has_passed(_id_81E55CD489351A8E, 10))
      _id_90940F1C797B8D16 = [];
    else {
      _id_38E30F6F71988282 = 0;

      foreach(e in _id_90940F1C797B8D16) {
        if(e.typeorig == event.typeorig && e.origin == event.origin) {
          _id_38E30F6F71988282 = 1;
          break;
        }
      }

      if(_id_38E30F6F71988282)
        continue;
    }

    _id_90940F1C797B8D16[_id_90940F1C797B8D16.size] = event;
    _id_81E55CD489351A8E = gettime();
    _id_5DF9D19E5429B0C1 = spawnStruct();
    _id_5DF9D19E5429B0C1.typeorig = event.typeorig;
    _id_5DF9D19E5429B0C1.entity = event.entity;
    _id_5DF9D19E5429B0C1.origin = event.origin;
    _id_5DF9D19E5429B0C1.receiver = event.receiver;
    _id_5DF9D19E5429B0C1.type = scripts\stealth\event::event_severity_get(event.typeorig);
    _id_5DF9D19E5429B0C1.investigate_pos = event.investigate_pos;
    spawners = scripts\engine\utility::array_removeundefined(spawners);
    spawners = sortbydistance(spawners, event.origin);
    childthread propagate_event_thread(_id_5DF9D19E5429B0C1, _id_4A56F39B88AB0B5D, spawners);
  }
}

propagate_event_thread(event, _id_4A56F39B88AB0B5D, spawners) {
  foreach(spawner in spawners) {
    if(!isDefined(spawner)) {
      continue;
    }
    if(distancesquared(spawner.origin, event.origin) > _id_4A56F39B88AB0B5D[event.typeorig] * _id_4A56F39B88AB0B5D[event.typeorig]) {
      break;
    }

    if(scripts\engine\utility::is_equal(spawner.script_noteworthy, "lone_patroller") && scripts\engine\utility::flag(spawner.script_stealthgroup + "_spawned")) {
      continue;
    }
    if(!isDefined(spawner.suspended_ai)) {
      if(istrue(spawner.dont_propagate_events_prespawn))
        continue;
    }

    if(event.typeorig == "light_killed" && distancesquared(spawner.origin, event.origin) > 160000) {
      waitframe();

      if(!isDefined(spawner)) {
        continue;
      }
      if(!sighttracepassed(spawner.origin + (0, 0, 60), event.origin, 0, event.entity))
        continue;
    }

    guy = undefined;

    if(isDefined(guy)) {
      guy aieventlistenerevent(event.typeorig, event.entity, event.origin);
      continue;
    }

    if(isDefined(spawner.suspended_ai)) {
      if(event.type == "combat")
        spawner.suspended_ai.stealth.bsmstate = 3;
      else {
        spawner.suspended_ai.stealth.bsmstate = max(1, spawner.suspended_ai.stealth.bsmstate);
        spawner.suspended_ai scripts\aitypes\stealth::_id_6BDCFA57946930C7(event);
      }

      continue;
    }

    struct = spawnStruct();
    struct.origin = spawner.origin;
    struct.angles = spawner.angles;
    struct.suspendtime = gettime();
    struct.stealth = spawnStruct();
    struct.stealth_enabled = 1;

    if(event.type == "combat")
      struct.stealth.bsmstate = 3;
    else {
      struct.stealth.bsmstate = 1;
      struct.stealth.investigateevent = event;
    }

    struct.suspendvars = spawnStruct();
    spawner.suspended_ai = struct;
    spawner.count = 0;
  }
}

_id_F9D54801507D21F1(_id_F8E5E3AA5762A8E7, spawnpoint, _id_8CB6EC14C2F6392D, _id_ABB7BDD43400A0C7, spawn_parameter_array, _id_3A308E048FA5CEC7) {
  spec = undefined;
  _id_536D11C1D37833B7 = undefined;
  _id_00DB52FA830038A9 = undefined;
  _id_ABB7BDD43400A0C7 = undefined;

  if(isDefined(spawnpoint.pos_override_struct)) {
    _id_536D11C1D37833B7 = spawnpoint.pos_override_struct.origin;
    _id_00DB52FA830038A9 = spawnpoint.pos_override_struct.angles;
  } else if(isDefined(spawnpoint.vehicle_position)) {
    _id_536D11C1D37833B7 = spawnpoint.origin;
    _id_00DB52FA830038A9 = spawnpoint.angles;
  }

  if(isDefined(spawnpoint.specs)) {
    if(!isarray(spawnpoint.specs))
      spawnpoint.specs = [spawnpoint.specs];

    _id_ABB7BDD43400A0C7 = scripts\engine\utility::random(spawnpoint.specs);
    spec = _id_ABB7BDD43400A0C7;
  }

  _id_07208FC96EA182F6 = 0;

  if(!isDefined(spawnpoint.count))
    spawnpoint.count = 1;

  if(isDefined(spawnpoint.script_suspend)) {
    _id_07208FC96EA182F6 = spawnpoint prespawn_suspended_ai();

    if(spawnpoint.count == 0 && !_id_07208FC96EA182F6)
      return undefined;
  }

  soldier = spawnpoint _id_18A73A64992DD07D::spawn_ai(_id_536D11C1D37833B7, _id_00DB52FA830038A9, _id_ABB7BDD43400A0C7, _id_F8E5E3AA5762A8E7);

  if(isDefined(soldier)) {
    soldier.suspended_ai = spawnpoint.suspended_ai;
    soldier.script_suspend = spawnpoint.script_suspend;
    soldier.script_suspend_group = spawnpoint.script_suspend_group;
    soldier.spawner = spawnpoint;
    spawnpoint notify("spawn_success", spawnpoint);
    level notify("spawned_group_soldier", soldier);
    level notify("ai_spawn_successful", soldier, spawnpoint, spawnpoint.origin, _id_F8E5E3AA5762A8E7);
    return _id_18A73A64992DD07D::run_ai_post_spawn_init(_id_F8E5E3AA5762A8E7, soldier, spawnpoint, spawn_parameter_array, spec, _id_8CB6EC14C2F6392D, _id_3A308E048FA5CEC7);
  }
}

_id_192F8A34D0AE130F(ai_array, _id_CE3C23B4AB427559) {
  if(!isDefined(level._id_B8071E682932B403))
    level._id_B8071E682932B403 = [];

  leader = scripts\engine\utility::random(ai_array);

  if(isDefined(_id_CE3C23B4AB427559)) {
    if(isarray(_id_CE3C23B4AB427559))
      leader = scripts\engine\utility::random(_id_CE3C23B4AB427559);
    else
      leader = _id_CE3C23B4AB427559;
  }

  level._id_B8071E682932B403[leader.enemy_group] = leader;

  for(;;) {
    alive = 0;

    foreach(ai in ai_array) {
      if(!isalive(ai) || ai.health < 1) {
        continue;
      }
      alive = 1;
    }

    if(!alive) {
      return;
    }
    if(isDefined(leader) && isalive(leader)) {
      foreach(ai in ai_array) {
        if(!isDefined(ai)) {
          continue;
        }
        if(ai == leader) {
          continue;
        }
        if(!isalive(ai) || ai.health < 1) {
          continue;
        }
        if(!isDefined(ai.goalent) || ai.goalent != leader) {
          if(getDvar("squad_debug") != "")
            ai hudoutlineenable("outline_nodepth_white");

          ai setgoalentity(leader);
          ai.goalent = leader;
        }

        _id_4666C0E35742BC07 = 0;

        foreach(player in level.players) {
          if(distance2dsquared(leader.origin, player.origin) < squared(leader.goalradius))
            _id_4666C0E35742BC07 = 1;
        }

        if(_id_4666C0E35742BC07 || distance2dsquared(leader.origin, ai.origin) < squared(ai.goalradius)) {
          if(distance2dsquared(leader.origin, ai.origin) < squared(ai.goalradius))
            ai setcoverselectionfocusent(leader);
        }
      }
    } else {
      ai_array = scripts\engine\utility::array_removeundefined(ai_array);

      if(ai_array.size == 0) {
        return;
      }
      leader = scripts\engine\utility::random(ai_array);

      if(isDefined(_id_CE3C23B4AB427559)) {
        alive = 0;

        foreach(guy in _id_CE3C23B4AB427559) {
          if(!isalive(guy) || guy.health < 1) {
            continue;
          }
          alive = 1;
        }

        if(alive) {
          if(isarray(_id_CE3C23B4AB427559))
            leader = scripts\engine\utility::random(_id_CE3C23B4AB427559);
          else
            leader = _id_CE3C23B4AB427559;

          level._id_B8071E682932B403[leader.enemy_group] = leader;
        }
      }

      if(getDvar("squad_debug") != "")
        leader hudoutlineenable("outline_nodepth_green");
    }

    wait 1;
  }
}

_id_9C0FBE62C1B9D660() {
  self endon("death");
  self endon("stop_hunting");
  player = scripts\engine\utility::random(level.players);

  for(;;) {
    if(!isDefined(player) || istrue(player.inlaststand)) {
      selected = 0;

      foreach(_id_4A27F44F23590C6F in level.players) {
        if(istrue(_id_4A27F44F23590C6F.inlaststand)) {
          continue;
        }
        player = _id_4A27F44F23590C6F;
        selected = 1;
      }

      if(!selected) {
        wait 3;
        player = undefined;
        continue;
      }
    }

    foreach(_id_8B6D3988CED8664E in level.players)
    self getenemyinfo(_id_8B6D3988CED8664E);

    org = player.origin;
    self setgoalpos(player.origin);
    wait 3;
  }
}

_id_48EA085692ABDACF(_id_F8E5E3AA5762A8E7) {
  _id_D46124083728196A = _id_F8E5E3AA5762A8E7.group_name;
}