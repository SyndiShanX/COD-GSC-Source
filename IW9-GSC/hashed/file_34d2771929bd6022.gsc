/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_34d2771929bd6022.gsc
***********************************************/

#using_animtree("script_model");

_id_0BCD7DBE50E5AF96() {
  level.scr_animtree["plyr_twomandoor"] = #animtree;
  level.scr_anim["plyr_twomandoor"]["start_left"] = % iw9_cp_raid_buddy_door_l_enter;
  level.scr_animname["plyr_twomandoor"]["start_left"] = "iw9_cp_raid_buddy_door_l_enter";
  level.scr_eventanim["plyr_twomandoor"]["start_left"] = "iw9_cp_raid_buddy_door_l_enter";
  level.scr_anim["plyr_twomandoor"]["start_right"] = % iw9_cp_raid_buddy_door_r_enter;
  level.scr_animname["plyr_twomandoor"]["start_right"] = "iw9_cp_raid_buddy_door_r_enter";
  level.scr_eventanim["plyr_twomandoor"]["start_right"] = "iw9_cp_raid_buddy_door_r_enter";
  level.scr_anim["plyr_twomandoor"]["stop_left"] = % iw9_cp_raid_buddy_door_l_exit;
  level.scr_animname["plyr_twomandoor"]["stop_left"] = "iw9_cp_raid_buddy_door_l_exit";
  level.scr_eventanim["plyr_twomandoor"]["stop_left"] = "iw9_cp_raid_buddy_door_l_exit";
  level.scr_anim["plyr_twomandoor"]["stop_right"] = % iw9_cp_raid_buddy_door_r_exit;
  level.scr_animname["plyr_twomandoor"]["stop_right"] = "iw9_cp_raid_buddy_door_r_exit";
  level.scr_eventanim["plyr_twomandoor"]["stop_right"] = "iw9_cp_raid_buddy_door_r_exit";
  level.scr_anim["plyr_twomandoor"]["use_loop_left"][0] = % iw9_cp_raid_buddy_door_l_idle;
  level.scr_animname["plyr_twomandoor"]["use_loop_left"][0] = "iw9_cp_raid_buddy_door_l_idle";
  level.scr_eventanim["plyr_twomandoor"]["use_loop_left"][0] = "iw9_cp_raid_buddy_door_l_idle";
  level.scr_anim["plyr_twomandoor"]["use_loop_right"][0] = % iw9_cp_raid_buddy_door_r_idle;
  level.scr_animname["plyr_twomandoor"]["use_loop_right"][0] = "iw9_cp_raid_buddy_door_r_idle";
  level.scr_eventanim["plyr_twomandoor"]["use_loop_right"][0] = "iw9_cp_raid_buddy_door_r_idle";
  level.scr_anim["plyr_twomandoor"]["start_underwater"] = % iw9_cp_raid_underwater_button_enter;
  level.scr_animname["plyr_twomandoor"]["start_underwater"] = "iw9_cp_raid_underwater_button_enter";
  level.scr_eventanim["plyr_twomandoor"]["start_underwater"] = "iw9_cp_raid_underwater_button_enter";
  level.scr_anim["plyr_twomandoor"]["use_loop_underwater"][0] = % iw9_cp_raid_underwater_button_idle;
  level.scr_animname["plyr_twomandoor"]["use_loop_underwater"][0] = "iw9_cp_raid_underwater_button_idle";
  level.scr_eventanim["plyr_twomandoor"]["use_loop_underwater"][0] = "iw9_cp_raid_underwater_button_idle";
  level.scr_anim["plyr_twomandoor"]["stop_underwater"] = % iw9_cp_raid_underwater_button_exit;
  level.scr_animname["plyr_twomandoor"]["stop_underwater"] = "iw9_cp_raid_underwater_button_exit";
  level.scr_eventanim["plyr_twomandoor"]["stop_underwater"] = "iw9_cp_raid_underwater_button_exit";
  level.scr_animtree["twomandoor_button"] = #animtree;
  level.scr_anim["twomandoor_button"]["start_left"] = % iw9_cp_raid_buddy_door_l_enter_button;
  level.scr_animname["twomandoor_button"]["start_left"] = "iw9_cp_raid_buddy_door_l_enter_button";
  level.scr_anim["twomandoor_button"]["start_right"] = % iw9_cp_raid_buddy_door_r_enter_button;
  level.scr_animname["twomandoor_button"]["start_right"] = "iw9_cp_raid_buddy_door_r_enter_button";
  level.scr_anim["twomandoor_button"]["stop_left"] = % iw9_cp_raid_buddy_door_l_exit_button;
  level.scr_animname["twomandoor_button"]["stop_left"] = "iw9_cp_raid_buddy_door_l_exit_button";
  level.scr_anim["twomandoor_button"]["stop_right"] = % iw9_cp_raid_buddy_door_r_exit_button;
  level.scr_animname["twomandoor_button"]["stop_right"] = "iw9_cp_raid_buddy_door_r_exit_button";
  level.scr_anim["twomandoor_button"]["use_loop_left"][0] = % iw9_cp_raid_buddy_door_l_idle_button;
  level.scr_animname["twomandoor_button"]["use_loop_left"][0] = "iw9_cp_raid_buddy_door_l_idle_button";
  level.scr_anim["twomandoor_button"]["use_loop_right"][0] = % iw9_cp_raid_buddy_door_r_idle_button;
  level.scr_animname["twomandoor_button"]["use_loop_right"][0] = "iw9_cp_raid_buddy_door_r_idle_button";
  level.scr_anim["twomandoor_button"]["start_underwater"] = % iw9_cp_raid_underwater_button_enter_button;
  level.scr_animname["twomandoor_button"]["start_underwater"] = "iw9_cp_raid_underwater_button_enter_button";
  level.scr_anim["twomandoor_button"]["use_loop_underwater"][0] = % iw9_cp_raid_underwater_button_idle_button;
  level.scr_animname["twomandoor_button"]["use_loop_underwater"][0] = "iw9_cp_raid_underwater_button_idle_button";
  level.scr_anim["twomandoor_button"]["stop_underwater"] = % iw9_cp_raid_underwater_button_exit_button;
  level.scr_animname["twomandoor_button"]["stop_underwater"] = "iw9_cp_raid_underwater_button_exit_button";
}

_id_45A5AEEB6A2CD77B(_id_92C4DE821390F609, _id_69F0349ED9B6A3C0, data) {
  wait 1;
  _id_059BA39DC28C1DC5 = scripts\engine\utility::getStruct(_id_92C4DE821390F609, "script_noteworthy");
  _id_059BA39DC28C1DC5.doors = [];

  if(!istrue(_id_69F0349ED9B6A3C0)) {
    _id_65E7054279B5F718 = 0;
    _id_AC0E594AC96AA3A8 = 1;

    while(!istrue(_id_65E7054279B5F718)) {
      door = getEnt(_id_92C4DE821390F609 + "_" + _id_AC0E594AC96AA3A8, "script_noteworthy");

      if(!isDefined(door)) {
        _id_65E7054279B5F718 = 1;
        continue;
      }

      _id_059BA39DC28C1DC5.doors[_id_059BA39DC28C1DC5.doors.size] = door;
      _id_AC0E594AC96AA3A8++;
    }
  } else {
    door = getEnt(_id_92C4DE821390F609, "script_noteworthy");
    _id_059BA39DC28C1DC5.doors[_id_059BA39DC28C1DC5.doors.size] = door;
  }

  hintstring = &"CP_HARRIER_BOSS/HOLD_TO_OPEN";

  if(isDefined(data)) {
    _id_059BA39DC28C1DC5.data = data;

    if(isDefined(data.hintstring))
      hintstring = data.hintstring;
  }

  _id_69A72D7EC7EF23A4 = getEnt(_id_92C4DE821390F609 + "_left", "script_noteworthy");
  _id_4879514832A59AB5 = getEnt(_id_92C4DE821390F609 + "_right", "script_noteworthy");
  _id_059BA39DC28C1DC5._id_9EECF0AF19B92C7F = _id_69A72D7EC7EF23A4;
  _id_059BA39DC28C1DC5._id_1465D2271135E505 = _id_4879514832A59AB5;
  _id_059BA39DC28C1DC5.doorstate = "closed";
  _id_059BA39DC28C1DC5._id_A420FE6EF9FCCD0D = [];
  _id_84BD84DEB891A915 = scripts\engine\utility::getStructArray(_id_059BA39DC28C1DC5.target, "targetname");

  foreach(struct in _id_84BD84DEB891A915) {
    struct._id_059BA39DC28C1DC5 = _id_059BA39DC28C1DC5;

    if(isDefined(struct.script_noteworthy)) {
      if(struct.script_noteworthy == "2man_master_switch") {
        _id_198ECBF2B7BDBB69 = _id_18AF78602B67B70C::_id_683F024F53CEE760(struct, hintstring);
        _id_059BA39DC28C1DC5._id_F86AB71619B530B7 = _id_198ECBF2B7BDBB69;
        _id_198ECBF2B7BDBB69._id_059BA39DC28C1DC5 = _id_059BA39DC28C1DC5;
        level thread _id_5620FD48544AA355(_id_198ECBF2B7BDBB69, 1);
      } else
        _id_C30EF0F13E6FAC97(_id_059BA39DC28C1DC5, struct);
    } else {
      _id_198ECBF2B7BDBB69 = _id_18AF78602B67B70C::_id_683F024F53CEE760(struct, hintstring);
      _id_198ECBF2B7BDBB69._id_059BA39DC28C1DC5 = _id_059BA39DC28C1DC5;
      _id_059BA39DC28C1DC5._id_A420FE6EF9FCCD0D[_id_059BA39DC28C1DC5._id_A420FE6EF9FCCD0D.size] = _id_198ECBF2B7BDBB69;
      level thread _id_5620FD48544AA355(_id_198ECBF2B7BDBB69, 0);
    }

    waitframe();
  }

  level thread scripts\engine\utility::delaythread(1, ::_id_5FDD19D991E0C1DD, _id_059BA39DC28C1DC5);
  return _id_059BA39DC28C1DC5;
}

_id_C30EF0F13E6FAC97(_id_059BA39DC28C1DC5, _id_29497B9188AEED3A) {
  if(!isDefined(_id_059BA39DC28C1DC5._id_9F1C1CB287802AD4))
    _id_059BA39DC28C1DC5._id_9F1C1CB287802AD4 = [];

  _id_2138CD38ABD0F9D9 = spawnStruct();
  _id_2138CD38ABD0F9D9.script_noteworthy = _id_29497B9188AEED3A.script_noteworthy;
  _id_2138CD38ABD0F9D9._id_30C8B4C751DBEC43 = _id_29497B9188AEED3A;
  _id_2138CD38ABD0F9D9._id_5C00D02AB1048ECF = scripts\engine\utility::getStruct(_id_29497B9188AEED3A.target, "targetname");
  _id_059BA39DC28C1DC5._id_9F1C1CB287802AD4[_id_059BA39DC28C1DC5._id_9F1C1CB287802AD4.size] = _id_2138CD38ABD0F9D9;
}

_id_5620FD48544AA355(button, _id_C26F265C18265647) {
  level endon("game_ended");
  button._id_059BA39DC28C1DC5 endon("disable_2mandoor");
  button _meth_DFB78B3E724AD620(1);

  for(;;) {
    button waittill("trigger", player);

    if(!isPlayer(player)) {
      waitframe();
      continue;
    }

    if(istrue(button.disabled)) {
      continue;
    }
    player playerlinktodelta(button);

    while(istrue(player useButtonPressed())) {
      button._id_48EE2E092B24BD8B = 1;
      waitframe();
    }

    player unlink();

    if(istrue(_id_C26F265C18265647))
      wait 3;

    button._id_48EE2E092B24BD8B = 0;
  }
}

_id_5FDD19D991E0C1DD(_id_059BA39DC28C1DC5) {
  level endon("game_ended");
  _id_059BA39DC28C1DC5 endon("disable_2mandoor");

  for(;;) {
    if(_id_4422606CA4838220(_id_059BA39DC28C1DC5)) {
      if(_id_059BA39DC28C1DC5.doorstate == "closed")
        _id_BA68730C1DFF09AF(_id_059BA39DC28C1DC5);
    } else if(_id_059BA39DC28C1DC5.doorstate == "opened")
      _id_0CE89314F198B235(_id_059BA39DC28C1DC5);

    waitframe();
  }
}

_id_4422606CA4838220(_id_059BA39DC28C1DC5) {
  if(istrue(_id_059BA39DC28C1DC5._id_F86AB71619B530B7._id_48EE2E092B24BD8B))
    return 1;

  foreach(_id_9DE36B2D58552961 in _id_059BA39DC28C1DC5._id_A420FE6EF9FCCD0D) {
    if(!istrue(_id_9DE36B2D58552961._id_48EE2E092B24BD8B))
      return 0;
  }

  return 1;
}

_id_26D57AACBFCEB191(_id_059BA39DC28C1DC5, door) {
  if(!isDefined(_id_059BA39DC28C1DC5._id_9F1C1CB287802AD4))
    return undefined;

  _id_92C4DE821390F609 = door.script_noteworthy;

  foreach(marker in _id_059BA39DC28C1DC5._id_9F1C1CB287802AD4) {
    if(_id_92C4DE821390F609 == marker.script_noteworthy)
      return marker;

    if(_id_059BA39DC28C1DC5._id_9F1C1CB287802AD4.size == 1)
      return marker;
  }

  return undefined;
}

_id_BA68730C1DFF09AF(_id_059BA39DC28C1DC5) {
  level endon("game_ended");

  foreach(door in _id_059BA39DC28C1DC5.doors) {
    _id_29497B9188AEED3A = _id_26D57AACBFCEB191(_id_059BA39DC28C1DC5, door);

    if(!isDefined(_id_29497B9188AEED3A)) {
      continue;
    }
    _id_27CA565A4E86B3ED = 1;

    if(isDefined(_id_29497B9188AEED3A.data) && isDefined(_id_29497B9188AEED3A.data._id_27CA565A4E86B3ED))
      _id_27CA565A4E86B3ED = _id_29497B9188AEED3A.data._id_27CA565A4E86B3ED;

    door moveTo(_id_29497B9188AEED3A._id_5C00D02AB1048ECF.origin, _id_27CA565A4E86B3ED, 0.5, 0.5);
    door notify("door_open");
    level notify("twoman_door_open", door);
  }

  wait 1;
  _id_059BA39DC28C1DC5.doorstate = "opened";
}

_id_0CE89314F198B235(_id_059BA39DC28C1DC5) {
  level endon("game_ended");

  foreach(door in _id_059BA39DC28C1DC5.doors) {
    _id_29497B9188AEED3A = _id_26D57AACBFCEB191(_id_059BA39DC28C1DC5, door);

    if(!isDefined(_id_29497B9188AEED3A)) {
      continue;
    }
    _id_2948CA54731DE34F = 0.5;

    if(isDefined(_id_29497B9188AEED3A.data) && isDefined(_id_29497B9188AEED3A.data._id_2948CA54731DE34F))
      _id_27CA565A4E86B3ED = _id_29497B9188AEED3A.data._id_2948CA54731DE34F;

    door moveTo(_id_29497B9188AEED3A._id_30C8B4C751DBEC43.origin, _id_2948CA54731DE34F, 0.2, 0.2);
    door notify("door_close");
    level notify("twoman_door_close", door);
  }

  wait 1;
  _id_059BA39DC28C1DC5.doorstate = "closed";
}

_id_05F7C6BF2110C0FE(doors, allowweapons, _id_1C9B02E3E36CC88F, _id_DD00509DA4ADCBBA, _id_01A5E8B9533267A4) {
  door = doors;

  if(isarray(doors)) {
    door = doors[0];

    foreach(otherdoor in doors) {
      if(otherdoor == door) {
        continue;
      }
      otherdoor.closedpos = otherdoor.origin;
      otherdoor.openpos = otherdoor.origin + otherdoor.script_offset;
    }

    door._id_61A0BC9B5FDEF431 = doors;
  }

  if(!isDefined(allowweapons))
    allowweapons = 1;

  _id_5AC49E018B46B2CD = self;

  if(isDefined(door.target))
    _id_5AC49E018B46B2CD = scripts\engine\utility::getStruct(door.target, "targetname");

  _id_5AC49E018B46B2CD _id_0C48BF42FE488B71();
  door._id_7432D0D0FA70617C = _id_18AF78602B67B70C::_id_683F024F53CEE760(_id_5AC49E018B46B2CD, _id_5AC49E018B46B2CD.hintstring, _id_5AC49E018B46B2CD.buttonmodel, _id_5AC49E018B46B2CD.duration, _id_5AC49E018B46B2CD.usedist, _id_5AC49E018B46B2CD.hintdist, _id_5AC49E018B46B2CD.onobstruction, _id_5AC49E018B46B2CD.usefov);
  door._id_7432D0D0FA70617C thread _id_D61F0E1B1E3E6A20(door, 0, allowweapons, _id_1C9B02E3E36CC88F, _id_01A5E8B9533267A4);
  door._id_5AC49E018B46B2CD = _id_5AC49E018B46B2CD;

  if(isDefined(_id_5AC49E018B46B2CD.target)) {
    _id_20F3271DC43A6012 = scripts\engine\utility::getStruct(_id_5AC49E018B46B2CD.target, "targetname");
    _id_20F3271DC43A6012 _id_0C48BF42FE488B71();
    door._id_590D3F80EE9B48CB = _id_18AF78602B67B70C::_id_683F024F53CEE760(_id_20F3271DC43A6012, _id_20F3271DC43A6012.hintstring, _id_20F3271DC43A6012.buttonmodel, _id_20F3271DC43A6012.duration, _id_20F3271DC43A6012.usedist, _id_20F3271DC43A6012.hintdist, _id_20F3271DC43A6012.onobstruction, _id_20F3271DC43A6012.usefov);
    door._id_590D3F80EE9B48CB thread _id_D61F0E1B1E3E6A20(door, 1, allowweapons, undefined, _id_01A5E8B9533267A4);
  }

  door._id_233D382A9996DE04 = 0;
  door.closedpos = door.origin;
  door.openpos = door.origin + door.script_offset;

  if(istrue(_id_DD00509DA4ADCBBA))
    door._id_BA5410B92C5C60BB = door.closedpos + (0, 0, 55);

  level thread _id_593DA22F293BA95C(door);
}

_id_2FECC1AAB1890E7D(hintstring, buttonmodel, usedist, hintdist, duration, onobstruction, usefov, _id_FFA98FA05F7E08BD, _id_E213CDC03C01A000) {
  if(isDefined(hintstring))
    self.hintstring = hintstring;

  if(isDefined(buttonmodel))
    self.buttonmodel = buttonmodel;

  if(isDefined(usedist))
    self.usedist = usedist;

  if(isDefined(hintdist))
    self.hintdist = hintdist;

  if(isDefined(onobstruction))
    self.onobstruction = onobstruction;

  if(isDefined(duration))
    self.duration = duration;

  if(isDefined(usefov))
    self.usefov = usefov;

  if(isDefined(_id_FFA98FA05F7E08BD))
    self._id_FFA98FA05F7E08BD = _id_FFA98FA05F7E08BD;

  if(isDefined(_id_E213CDC03C01A000))
    self setusepriority(_id_E213CDC03C01A000);
}

_id_0C48BF42FE488B71() {
  if(!isDefined(self.hintstring))
    self.hintstring = &"CP_HARRIER_BOSS/HOLD_TO_OPEN";

  if(!isDefined(self.buttonmodel))
    self.buttonmodel = "button_on";

  if(!isDefined(self.usedist))
    self.usedist = 64;

  if(!isDefined(self.hintdist))
    self.hintdist = 256;

  if(!isDefined(self.onobstruction))
    self.onobstruction = "show";

  if(!isDefined(self.duration))
    self.duration = "duration_none";

  if(!isDefined(self.usefov))
    self.usefov = 65;
}

_id_593DA22F293BA95C(door) {
  level endon("game_ended");

  for(;;) {
    while(!istrue(door._id_233D382A9996DE04)) {
      wait 0.05;
      continue;
    }

    frac = 0.1;
    door playSound("cp_buddy_door_open");

    while(istrue(door._id_233D382A9996DE04)) {
      if(istrue(door.open)) {
        wait 0.05;
        continue;
      }

      _id_D0DE0DB1760B9C5B = vectorlerp(door.origin, door.openpos, frac);
      door moveTo(_id_D0DE0DB1760B9C5B, 0.1);

      if(isDefined(door._id_61A0BC9B5FDEF431)) {
        foreach(otherdoor in door._id_61A0BC9B5FDEF431) {
          if(otherdoor == door) {
            continue;
          }
          _id_D0DE0DB1760B9C5B = vectorlerp(otherdoor.origin, otherdoor.openpos, frac);
          otherdoor moveTo(_id_D0DE0DB1760B9C5B, 0.1);
        }
      }

      frac = frac + 0.1;

      if(frac >= 1) {
        door.open = 1;
        door notify("door_open");
        level notify("twoman_door_open", door);
      }

      wait 0.1;
    }

    if(isDefined(door._id_F14FE08CFB8BEE65)) {
      if(istrue(door[[door._id_F14FE08CFB8BEE65]]())) {
        while(istrue(door[[door._id_F14FE08CFB8BEE65]]()))
          wait 0.05;

        door.open = 0;
        door notify("door_close");
        level notify("twoman_door_close", door);
        continue;
      }
    }

    door playSound("cp_buddy_door_close");
    door moveTo(door.closedpos, 0.5);
    door thread _id_76E36F6406D4F382(0.5);

    if(isDefined(door._id_61A0BC9B5FDEF431)) {
      foreach(otherdoor in door._id_61A0BC9B5FDEF431) {
        if(otherdoor == door) {
          continue;
        }
        otherdoor moveTo(otherdoor.closedpos, 0.5);
      }
    }

    wait 1;
    door.open = 0;
    door notify("door_close");
    level notify("twoman_door_close", door);
  }
}

_id_D61F0E1B1E3E6A20(door, _id_B322230DFCCF2433, _id_C74648864D9160C6, _id_1C9B02E3E36CC88F, _id_01A5E8B9533267A4) {
  for(;;) {
    self waittill("trigger", ent);

    if(!ent scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(istrue(self.disabled)) {
      continue;
    }
    if(isDefined(self._id_785C56130FCDBC47))
      self playSound(self._id_785C56130FCDBC47);

    if(ent secondaryoffhandbuttonPressed() || ent isthrowinggrenade() || ent isthrowingbackgrenade() || ent isreloading() || ent fragButtonPressed() || ent _meth_415FE9EECA7B2E2B() || istrue(ent.inlaststand) || istrue(ent.iscarrying) || istrue(ent.bgivensentry) || ent isswitchingweapon() || ent scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress()) {
      continue;
    }
    door notify("door_used");
    level notify("twoman_door_used", door);
    door._id_0A365BADCD826F9D = ent;
    door._id_7432D0D0FA70617C _meth_DFB78B3E724AD620(0);

    if(isDefined(door._id_590D3F80EE9B48CB))
      door._id_590D3F80EE9B48CB _meth_DFB78B3E724AD620(0);

    if(!istrue(ent._id_EB8EE2C6D463E28F)) {
      ent._id_EB8EE2C6D463E28F = 1;
      ent thread _id_2098BF9F4DE12403(self, door, _id_B322230DFCCF2433, _id_C74648864D9160C6, _id_1C9B02E3E36CC88F, _id_01A5E8B9533267A4);
    }
  }
}

_id_2098BF9F4DE12403(button, door, _id_B322230DFCCF2433, _id_C74648864D9160C6, _id_1C9B02E3E36CC88F, _id_01A5E8B9533267A4) {
  level endon("game_ended");
  self endon("disconnect");
  _id_CEE4F221D5369025 = !self _meth_E40102956C887F7C() || getdvarint("dvar_D5DFE13D0CDAF6FE");

  if(istrue(level._id_168F04BC9AFCFAAC))
    _id_CEE4F221D5369025 = 0;

  if(istrue(_id_CEE4F221D5369025) || istrue(_id_01A5E8B9533267A4))
    _id_3B64EB40368C1450::set("opening", "allow_movement", 0);

  if(_id_CEE4F221D5369025) {
    _id_42C39BE9231F929F = !istrue(_id_B322230DFCCF2433);

    if(isDefined(_id_1C9B02E3E36CC88F))
      _id_42C39BE9231F929F = _id_1C9B02E3E36CC88F;

    button thread _id_3287D082EC56C521(self, _id_42C39BE9231F929F, door);
    _id_3B64EB40368C1450::set("opening", "usability", 0);
  }

  if(!istrue(door._id_BCBE2E310C02E89B) && (!istrue(_id_C74648864D9160C6) || !_id_CEE4F221D5369025)) {
    _id_3B64EB40368C1450::set("opening", "weapon", 0);
    wait 0.5;
  }

  if(_id_CEE4F221D5369025)
    self waittill("button_pressed_anim");

  door._id_233D382A9996DE04 = 1;

  if(_id_CEE4F221D5369025)
    self waittill("button_pressed_done");

  door notify("opening");

  while(self useButtonPressed() && distance2d(self.origin, button.origin) < 64 && !istrue(self.inlaststand) && !istrue(button.disabled) || istrue(door._id_BCBE2E310C02E89B)) {
    door._id_233D382A9996DE04 = 1;
    wait 0.05;
  }

  if(getdvarint("dvar_012114CE683CFADB", 0) > 0) {
    _id_3B64EB40368C1450::set("opening", "allow_movement", 1);
    time = getdvarint("dvar_012114CE683CFADB", 0);
    waittime = gettime() + time * 1000;

    while(gettime() < waittime) {
      door._id_233D382A9996DE04 = 1;
      wait 0.05;
    }
  }

  self._id_EB8EE2C6D463E28F = undefined;

  if(_id_CEE4F221D5369025 && !istrue(door._id_CDFF6CE3D4D73F68))
    self waittill("button_released_anim");

  if(!_id_B322230DFCCF2433 || !istrue(door.open)) {
    if(!istrue(door._id_A85B0AF305EEDD88))
      door._id_233D382A9996DE04 = 0;
    else if(!_id_B322230DFCCF2433)
      door._id_233D382A9996DE04 = 0;
  }

  if(_id_CEE4F221D5369025)
    self waittill("buddy_door_unlinked");

  if(istrue(_id_01A5E8B9533267A4))
    _id_3B64EB40368C1450::set("opening", "allow_movement", 1);

  if(!istrue(_id_C74648864D9160C6) || !_id_CEE4F221D5369025) {
    _id_3B64EB40368C1450::set("opening", "weapon", 1);
    wait 0.5;
  }

  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("opening");

  if(_id_B322230DFCCF2433 && istrue(door.open)) {
    if(!istrue(level._id_30783085C294B022))
      wait 4;

    door._id_233D382A9996DE04 = 0;
  }

  wait 0.5;
  door._id_7432D0D0FA70617C _meth_DFB78B3E724AD620(1);

  if(isDefined(door._id_590D3F80EE9B48CB))
    door._id_590D3F80EE9B48CB _meth_DFB78B3E724AD620(1);
}

_id_3287D082EC56C521(player, _id_42C39BE9231F929F, door) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  button = self;
  buttons = getEntArray("buddy_door_button", "script_noteworthy");

  if(buttons.size)
    button = scripts\engine\utility::getclosest(player.origin, buttons);

  scenenode = spawnStruct();
  scenenode.origin = button.origin;
  scenenode.angles = button.angles;
  self.scenenode = scenenode;
  player.scenenode = self.scenenode;
  _id_0E4731409BD255E0 = "_left";
  _id_FDFAF00190EFAF80 = 0;

  if(player _meth_E40102956C887F7C()) {
    _id_0E4731409BD255E0 = "_underwater";
    _id_FDFAF00190EFAF80 = 1;
  } else if(istrue(_id_42C39BE9231F929F))
    _id_0E4731409BD255E0 = "_right";

  actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, "plyr_twomandoor", 1, 1, 1, _id_FDFAF00190EFAF80);
  _id_54E38BC53ABC8A5E = scripts\cp_mp\anim_scene::anim_scene_create_actor(button, "twomandoor_button");
  actorplayer scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  _id_54E38BC53ABC8A5E scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  actors = [actorplayer, _id_54E38BC53ABC8A5E];
  player scripts\engine\utility::delaythread(1.5, scripts\engine\utility::send_notify, "button_pressed_anim");
  started = self.scenenode scripts\cp_mp\anim_scene::anim_scene(actors, "start" + _id_0E4731409BD255E0, 1, 0, undefined, 0.4, 0.8) && player scripts\cp_mp\utility\player_utility::_isalive();
  player notify("button_pressed_done");

  if(isDefined(door) && isDefined(door._id_5AC49E018B46B2CD) && isDefined(door._id_5AC49E018B46B2CD._id_FFA98FA05F7E08BD) && door._id_5AC49E018B46B2CD._id_FFA98FA05F7E08BD != "tag_origin")
    button setModel(door._id_5AC49E018B46B2CD._id_FFA98FA05F7E08BD);

  self.scenenode _id_DEEC8849F0CF1A68(player, actors, _id_0E4731409BD255E0);

  if(isDefined(door) && isDefined(door._id_5AC49E018B46B2CD) && isDefined(door._id_5AC49E018B46B2CD.buttonmodel) && door._id_5AC49E018B46B2CD.buttonmodel != "tag_origin")
    button setModel(door._id_5AC49E018B46B2CD.buttonmodel);

  button useanimtree(#animtree);
  player scripts\engine\utility::delaythread(0.25, scripts\engine\utility::send_notify, "button_released_anim");
  self.scenenode scripts\cp_mp\anim_scene::anim_scene(actors, "stop" + _id_0E4731409BD255E0, 0, 1);
  player notify("buddy_door_unlinked");
}

_id_DEEC8849F0CF1A68(player, actors, _id_0E4731409BD255E0) {
  player endon("exit_twomandoor");
  player endon("death_or_disconnect");
  childthread scripts\cp_mp\anim_scene::anim_scene_loop(actors, "use_loop" + _id_0E4731409BD255E0, 0, 0);

  while(player scripts\cp_mp\utility\player_utility::_isalive() && istrue(player._id_EB8EE2C6D463E28F))
    waitframe();

  scripts\cp_mp\anim_scene::anim_scene_stop();
  waittillframeend;

  foreach(actor in actors)
  actor.forceendscene = 0;
}

_id_76E36F6406D4F382(delay) {
  if(getdvarint("dvar_077B885A4EA2D501", 0)) {
    return;
  }
  _id_A840EFBCA5F076BF = scripts\engine\utility::getStructArray("twomandoor_crusher", "targetname");

  if(!isDefined(_id_A840EFBCA5F076BF) || _id_A840EFBCA5F076BF.size == 0)
    thread _id_2817029CF18B85BA();
  else {
    if(isDefined(delay))
      wait(delay);

    _id_CCF3B3C7E627605D = scripts\engine\utility::getclosest(self.origin, _id_A840EFBCA5F076BF, 500);

    if(isDefined(_id_CCF3B3C7E627605D)) {
      target = scripts\engine\utility::getStruct(_id_CCF3B3C7E627605D.target, "targetname");

      foreach(player in level.players) {
        dist = scripts\cp\utility::_id_28AB2855171F96F0(_id_CCF3B3C7E627605D.origin, target.origin, player.origin);

        if(dist < 16)
          _id_CCF3B3C7E627605D thread _id_50E781B8D90E013E(player);
      }
    }
  }
}

_id_50E781B8D90E013E(player) {
  if(!isDefined(player) || !isalive(player)) {
    return;
  }
  player.shouldskipdeathsshield = 1;
  player dodamage(500, self.origin, undefined, undefined, "MOD_CRUSH");
  _id_F0D0842E8A7BD953 = getclosestpointonnavmesh(player.origin);

  if(distance(player.origin, _id_F0D0842E8A7BD953) < 100)
    player setOrigin(_id_F0D0842E8A7BD953);
}

_id_2817029CF18B85BA() {
  self endon("movedone");

  for(;;) {
    foreach(player in level.players) {
      if(player istouching(self))
        player dodamage(player.health + 1000, player getEye() + (0, 0, 20), self, self, "MOD_CRUSH");
    }

    waitframe();
  }
}