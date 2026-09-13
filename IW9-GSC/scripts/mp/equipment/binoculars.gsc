/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\binoculars.gsc
***********************************************/

binoculars_init() {
  if(isDefined(level.binocularsinited)) {
    return;
  }
  level._id_2C4F2A5075921418 = 131074;
  level.binocularsinited = 1;
}

binoculars_onstateupdatefunc(_id_D73C9918509F8D36, targetent, cansee) {
  switch (_id_D73C9918509F8D36) {
    case 0:
      return binoculars_onstateinvalidupdate(targetent, cansee);
    case 2:
      return binoculars_onstateunmarkedupdate(targetent, cansee);
    case 4:
      return binoculars_onstatemarkpendingupdate(targetent, cansee);
  }
}

binoculars_onstateenterfunc(_id_D73C9918509F8D36, targetent) {
  switch (_id_D73C9918509F8D36) {
    case 0:
      binoculars_onstateinvalidenter(targetent);
      return;
    case 2:
      binoculars_onstateunmarkedenter(targetent);
      return;
    case 4:
      binoculars_onstatemarkpendingenter(targetent);
      return;
    case 5:
      binoculars_onstatemarkedenter(targetent);
      return;
  }
}

binoculars_onstateexitfunc(_id_D73C9918509F8D36, targetent) {
  switch (_id_D73C9918509F8D36) {
    case 4:
      binoculars_onstatemarkpendingexit(targetent);
      return;
    case 5:
      binoculars_onstatemarkedexit(targetent);
      return;
  }
}

binoculars_ongive(equipmentref, _id_CBB2B3D05E48BD27, variantid) {
  if(equipmentref != "equip_binoculars" || getdvarint("dvar_8BCD5B94785FA58B", 1) != 1) {
    return;
  }
  binoculars_init();
  thread binoculars_watchforads();
}

binoculars_ontake(equipmentref, _id_CBB2B3D05E48BD27) {
  if(equipmentref != "equip_binoculars") {
    return;
  }
  self notify("binoculars_take");
}

binoculars_used(grenade) {
  waitframe();

  if(isDefined(grenade))
    grenade delete();
}

binoculars_watchforads() {
  self endon("disconnect");
  self notify("binoculars_watchForADS");
  self endon("binoculars_watchForADS");
  isads = 0;

  for(;;) {
    _id_C05958D616DDF1C5 = spawnStruct();
    childthread binoculars_watchracedeath(_id_C05958D616DDF1C5);
    childthread binoculars_watchracelaststand(_id_C05958D616DDF1C5);
    childthread _id_0621D5BBA47A7C73(_id_C05958D616DDF1C5);
    childthread binoculars_watchracetake(_id_C05958D616DDF1C5);
    childthread binoculars_watchraceadson(_id_C05958D616DDF1C5);
    childthread binoculars_watchraceadsoff(_id_C05958D616DDF1C5);
    childthread _id_1BA52D293A13FE7A(_id_C05958D616DDF1C5);
    childthread _id_F802AA89B1F729A0(_id_C05958D616DDF1C5);
    childthread _id_FAEC4945097DE55D(_id_C05958D616DDF1C5);
    childthread _id_D32F05DDFE8701FE(_id_C05958D616DDF1C5);
    self waittill("binoculars_watchRaceStart");
    waittillframeend;
    death = istrue(_id_C05958D616DDF1C5.death);
    take = istrue(_id_C05958D616DDF1C5.take);
    adsoff = istrue(_id_C05958D616DDF1C5.adsoff) || istrue(_id_C05958D616DDF1C5.laststand) || istrue(_id_C05958D616DDF1C5.enteredvehicle) || istrue(_id_C05958D616DDF1C5._id_12BFB031C0A0EFD8) || istrue(_id_C05958D616DDF1C5._id_0A003E9E51F2CF83) || istrue(_id_C05958D616DDF1C5._id_8D20BEF4E952F457) || istrue(_id_C05958D616DDF1C5._id_DDF65301F7D23098);
    adson = !adsoff && istrue(_id_C05958D616DDF1C5.adson);

    if(death || take) {
      self notify("binoculars_watchRaceEnd");
      binoculars_endadslogic();
      return;
    }

    if(adson && !isads) {
      isads = 1;
      thread binoculars_runadslogic();
    } else if(adsoff && isads) {
      isads = 0;
      binoculars_endadslogic();
    }

    self notify("binoculars_watchRaceEnd");
  }
}

binoculars_watchracedeath(_id_C05958D616DDF1C5) {
  self endon("binoculars_watchRaceEnd");
  self waittill("death");
  _id_C05958D616DDF1C5.death = 1;
  self notify("binoculars_watchRaceStart");
}

binoculars_watchracelaststand(_id_C05958D616DDF1C5) {
  self endon("binoculars_watchRaceEnd");
  self waittill("last_stand_start");
  _id_C05958D616DDF1C5.laststand = 1;
  self notify("binoculars_watchRaceStart");
}

_id_0621D5BBA47A7C73(_id_C05958D616DDF1C5) {
  self endon("binoculars_watchRaceEnd");
  scripts\engine\utility::waittill_any_2("vehicle_enter", "vehicle_change_seat");
  _id_C05958D616DDF1C5.enteredvehicle = 1;
  self notify("binoculars_watchRaceStart");
}

binoculars_watchracetake(_id_C05958D616DDF1C5) {
  self endon("binoculars_watchRaceEnd");
  self waittill("binoculars_take");
  _id_C05958D616DDF1C5.take = 1;
  self notify("binoculars_watchRaceStart");
}

binoculars_watchraceadson(_id_C05958D616DDF1C5) {
  self endon("binoculars_watchRaceEnd");

  for(;;) {
    self waittill("offhand_ads_on", weapon);

    if(!istrue(self._id_74642C7F377A42C5)) {
      if(getweaponbasename(weapon) == "offhand_spotter_scope_mp") {
        break;
      }
    }
  }

  _id_C05958D616DDF1C5.adson = 1;
  self notify("binoculars_watchRaceStart");
}

binoculars_watchraceadsoff(_id_C05958D616DDF1C5) {
  self endon("binoculars_watchRaceEnd");

  for(;;) {
    self waittill("offhand_ads_off", weapon);

    if(getweaponbasename(weapon) == "offhand_spotter_scope_mp") {
      break;
    }
  }

  _id_C05958D616DDF1C5.adsoff = 1;
  self notify("binoculars_watchRaceStart");
}

_id_1BA52D293A13FE7A(_id_C05958D616DDF1C5) {
  self endon("binoculars_watchRaceEnd");

  for(;;) {
    self waittill("player_isHaywire");
    break;
  }

  _id_C05958D616DDF1C5._id_12BFB031C0A0EFD8 = 1;
  self notify("binoculars_watchRaceStart");
}

_id_F802AA89B1F729A0(_id_C05958D616DDF1C5) {
  self endon("binoculars_watchRaceEnd");

  for(;;) {
    self waittill("gas_begin_coughing");
    break;
  }

  _id_C05958D616DDF1C5._id_0A003E9E51F2CF83 = 1;
  self notify("binoculars_watchRaceStart");
}

_id_FAEC4945097DE55D(_id_C05958D616DDF1C5) {
  self endon("binoculars_watchRaceEnd");
  self waittill("detonate");
  _id_C05958D616DDF1C5._id_8D20BEF4E952F457 = 1;
  self notify("binoculars_watchRaceStart");
}

_id_D32F05DDFE8701FE(_id_C05958D616DDF1C5) {
  self endon("binoculars_watchRaceEnd");
  self waittill("binoculars_invalid_weapon");
  _id_C05958D616DDF1C5._id_DDF65301F7D23098 = 1;
  self notify("binoculars_watchRaceStart");
}

binoculars_endadslogic() {
  self notify("binoculars_ads_off");
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("binoculars_ads");

  if(isDefined(self.binocularsstruct)) {
    self.binocularsstruct.adson = undefined;
    self.binocularsstruct._id_811EB055AA6DF60E = undefined;

    if(isDefined(self.binocularsstruct.targetmarkergroup)) {
      scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.binocularsstruct.targetmarkergroup);
      self.binocularsstruct.targetmarkergroup = undefined;
    }

    binoculars_clearuidata();

    foreach(entnum, targetdata in self.binocularsstruct.targetdata) {
      if(!isDefined(targetdata)) {
        continue;
      }
      targetdata.hastargetmarker = undefined;

      if(isDefined(targetdata.headicon))
        binoculars_updateheadiconvisibilityforplayer(targetdata, self);
    }
  }
}

binoculars_runadslogic() {
  self endon("disconnect");
  self endon("binoculars_ads_off");
  self notify("binoculars_ads_on");
  _id_3B64EB40368C1450::set("binoculars_ads", "usability", 0);
  thread _id_B2875EA64BC1896F();

  if(!isDefined(self.binocularsstruct)) {
    self.binocularsstruct = spawnStruct();
    self.binocularsstruct.targetdata = [];
    self.binocularsstruct._id_811EB055AA6DF60E = 0;
  }

  self.binocularsstruct.adson = 1;
  self.binocularsstruct.targetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("overlaytargetmarkerenemy", self, undefined, self, 0, 0, 0);
  thread binoculars_processtargetdata();
}

_id_B2875EA64BC1896F() {
  self endon("disconnect");
  self endon("binoculars_ads_off");

  for(;;) {
    _id_8CB8729A7163C122 = self getheldoffhand();

    if(isnullweapon(_id_8CB8729A7163C122) || isDefined(_id_8CB8729A7163C122.basename) && _id_8CB8729A7163C122.basename != "offhand_spotter_scope_mp") {
      break;
    }

    waitframe();
  }

  wait 0.05;
  self notify("binoculars_invalid_weapon");
}

binoculars_isads() {
  return isDefined(self.binocularsstruct) && istrue(self.binocularsstruct.adson);
}

binoculars_processtargetdata() {
  if(istrue(self.binocularsstruct._id_2877D88B9A6D8CDB)) {
    return;
  }
  self.binocularsstruct._id_2877D88B9A6D8CDB = 1;
  self endon("disconnect");

  for(;;) {
    currenttarget = undefined;
    _id_5EBB903E8CA2AB84 = [];

    for(;;) {
      _id_5C3AB97C636C1B90();

      if(binoculars_isads()) {
        targetarray = sortbydistance(self _meth_C5140FFF72FECA2D(self.binocularsstruct.maxrange, binoculars_getfov(), level._id_2C4F2A5075921418, 0), self.origin);
        _id_56BF4E4B2BB221A7 = [];
        _id_CB791416725E9BC6 = 0;

        foreach(targetent in targetarray) {
          targetnum = targetent getentitynumber();
          curstate = _id_0856DB8D000D0BE6(targetnum);
          targetdata = self.binocularsstruct.targetdata[targetnum];

          if(isDefined(targetdata))
            _id_34D6333CA8B1F289(targetent);

          if(isDefined(currenttarget)) {
            continue;
          }
          if(curstate == 5) {
            continue;
          }
          _id_9B1941CB7354665E = binoculars_onstateupdatefunc(curstate, targetent, 1);
          _id_56BF4E4B2BB221A7[targetnum] = 1;
          _id_5EBB903E8CA2AB84[targetnum] = targetent;

          if(_id_9B1941CB7354665E != curstate) {
            binoculars_onstateexitfunc(curstate, targetent);
            binoculars_onstateenterfunc(_id_9B1941CB7354665E, targetent);

            if(_id_9B1941CB7354665E == 4)
              currenttarget = targetent;
          }
        }

        foreach(targetent in _id_5EBB903E8CA2AB84) {
          if(!isDefined(targetent)) {
            continue;
          }
          targetnum = targetent getentitynumber();

          if(!isDefined(_id_56BF4E4B2BB221A7[targetnum])) {
            _id_5EBB903E8CA2AB84[targetnum] = undefined;
            curstate = _id_0856DB8D000D0BE6(targetnum);
            _id_9B1941CB7354665E = binoculars_onstateupdatefunc(curstate, targetent, 0);

            if(_id_9B1941CB7354665E != curstate) {
              binoculars_onstateexitfunc(curstate, targetent);
              binoculars_onstateenterfunc(_id_9B1941CB7354665E, targetent);
            }
          }
        }

        if(isDefined(currenttarget)) {
          break;
        }

        binoculars_updateuidata();
      } else if(!isDefined(self.markedents)) {
        self.binocularsstruct = undefined;
        return;
      }

      waitframe();
    }

    waitframe();

    if(binoculars_isads()) {
      foreach(targetent in _id_5EBB903E8CA2AB84) {
        if(!isDefined(targetent)) {
          continue;
        }
        if(targetent == currenttarget) {
          continue;
        }
        curstate = _id_0856DB8D000D0BE6(targetent getentitynumber());
        _id_9B1941CB7354665E = binoculars_onstateupdatefunc(curstate, targetent, 0);

        if(_id_9B1941CB7354665E != curstate) {
          binoculars_onstateexitfunc(curstate, targetent);
          binoculars_onstateenterfunc(_id_9B1941CB7354665E, targetent);
        }
      }
    }

    if(!isDefined(currenttarget)) {
      waitframe();
      continue;
    }

    lastseentime = gettime();
    cansee = 1;
    _id_E6E07516A9F2893E = currenttarget getentitynumber();

    for(;;) {
      _id_5C3AB97C636C1B90();

      if(binoculars_isads()) {
        if(!isDefined(currenttarget)) {
          waitframe();
          break;
        }

        curstate = _id_0856DB8D000D0BE6(_id_E6E07516A9F2893E);

        if(gettime() - lastseentime > 100) {
          lastseentime = gettime();
          cansee = _id_67DA6F8A8E37737B(currenttarget);
        }

        _id_9B1941CB7354665E = binoculars_onstateupdatefunc(curstate, currenttarget, cansee);

        if(_id_9B1941CB7354665E != curstate) {
          binoculars_onstateexitfunc(curstate, currenttarget);
          binoculars_onstateenterfunc(_id_9B1941CB7354665E, currenttarget);

          if(_id_9B1941CB7354665E == 0 || _id_9B1941CB7354665E == 2) {
            waitframe();
            break;
          } else if(_id_9B1941CB7354665E == 5) {
            if(!isDefined(self.markedents))
              self.markedents = [];

            self.markedents[currenttarget getentitynumber()] = currenttarget;
            thread _id_4573EBA45AC98BCF();
            waitframe();
            break;
          }
        }

        binoculars_updateuidata();
      } else if(!isDefined(self.markedents)) {
        self.binocularsstruct = undefined;
        return;
      }

      waitframe();
    }
  }
}

_id_0856DB8D000D0BE6(targetnum) {
  targetdata = self.binocularsstruct.targetdata[targetnum];

  if(isDefined(targetdata))
    return targetdata.state;

  return 0;
}

_id_5C3AB97C636C1B90() {
  _id_C50A828A855FA65F = getdvarfloat("dvar_90D4DD93F932DE3F", 72.0);
  self.binocularsstruct.maxrange = binoculars_getmaxrange();
  self.binocularsstruct.maxrangesq = self.binocularsstruct.maxrange * self.binocularsstruct.maxrange;
  self.binocularsstruct.cosfov = cos(binoculars_getfov());
  self.binocularsstruct.projdistsq = _id_C50A828A855FA65F * _id_C50A828A855FA65F;
  self.binocularsstruct.markingtarget = 0;
  self.binocularsstruct.markingcoldblooded = 0;
  self.binocularsstruct.markingendtime = 0;
}

_id_4573EBA45AC98BCF() {
  self endon("disconnect");
  self notify("binoculars_updateMarkedEnts");
  self endon("binoculars_updateMarkedEnts");

  while(isDefined(self.markedents) && self.markedents.size > 0) {
    waitframe();

    foreach(entnum, targetent in self.markedents) {
      if(!isDefined(targetent)) {
        self.markedents[entnum] = undefined;
        continue;
      }

      curstate = 0;
      targetdata = self.binocularsstruct.targetdata[entnum];

      if(isDefined(targetdata))
        curstate = targetdata.state;

      _id_9B1941CB7354665E = binoculars_onstatemarkedupdate(targetent);

      if(_id_9B1941CB7354665E != curstate) {
        binoculars_onstateexitfunc(curstate, targetent);
        binoculars_onstateenterfunc(_id_9B1941CB7354665E, targetent);
        self.markedents[entnum] = undefined;
      }
    }
  }

  self.markedents = undefined;
}

_id_67DA6F8A8E37737B(targetent) {
  contents = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 1, 0, 1);
  _id_D895C679F6A927E5 = [targetent.origin];

  if(isPlayer(targetent)) {
    _id_295719F06C03407F = targetent scripts\mp\utility\player::getstancetop();
    _id_FC60036BA7BF253A = targetent scripts\mp\utility\player::getstancecenter();
    _id_D895C679F6A927E5 = [_id_295719F06C03407F, _id_FC60036BA7BF253A, targetent.origin];
  } else if(isagent(targetent))
    _id_D895C679F6A927E5 = [targetent.origin + (0, 0, 48)];

  ignorelist = [self, targetent];
  vehicle = targetent scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(vehicle)) {
    ignorelist[ignorelist.size] = vehicle;
    _id_BB7AC665413117FC = vehicle getlinkedchildren(1);

    foreach(child in _id_BB7AC665413117FC)
    ignorelist[ignorelist.size] = vehicle;
  }

  _id_DA0F17FCC7950D77 = 0;

  foreach(point in _id_D895C679F6A927E5) {
    if(!scripts\engine\trace::ray_trace_passed(self getvieworigin(), point, ignorelist, contents)) {
      continue;
    }
    return 1;
  }

  return 0;
}

_id_34D6333CA8B1F289(targetent) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];
  targetdata.loschecktime = gettime();
  targetdata.loscheckpassed = 1;
}

binoculars_cansee(targetent) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];

  if(!isDefined(targetdata.loschecktime) || gettime() - targetdata.loschecktime > 1000)
    return 0;

  return istrue(targetdata.loscheckpassed);
}

binoculars_setcurrentstate(targetent, _id_9B1941CB7354665E) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];

  if(!isDefined(targetdata)) {
    if(_id_9B1941CB7354665E == 0) {
      return;
    }
    targetdata = spawnStruct();
    self.binocularsstruct.targetdata[targetent getentitynumber()] = targetdata;
  }

  targetdata.state = _id_9B1941CB7354665E;
}

binoculars_hascoldblooded(targetent) {
  return isPlayer(targetent) && targetent scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline");
}

binoculars_showtargetmarker(targetent, ismarked) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];

  if(isDefined(targetdata))
    targetdata.hastargetmarker = 1;

  if(!isDefined(self.binocularsstruct.targetmarkergroup)) {
    return;
  }
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(targetent, self.binocularsstruct.targetmarkergroup, 0);
  _id_177716BEC3407A6A = binoculars_hascoldblooded(targetent);

  if(_id_177716BEC3407A6A)
    binoculars_settargetmarkerstate(targetent, 3);
  else if(ismarked)
    binoculars_settargetmarkerstate(targetent, 2);
  else
    binoculars_settargetmarkerstate(targetent, 1);
}

binoculars_updatetargetmarker(targetent, ismarked) {
  if(!isDefined(self.binocularsstruct.targetmarkergroup)) {
    return;
  }
  _id_177716BEC3407A6A = binoculars_hascoldblooded(targetent);

  if(_id_177716BEC3407A6A)
    binoculars_settargetmarkerstate(targetent, 3);
  else if(ismarked)
    binoculars_settargetmarkerstate(targetent, 2);
  else
    binoculars_settargetmarkerstate(targetent, 1);
}

binoculars_hidetargetmarker(targetent) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];

  if(isDefined(targetdata))
    targetdata.hastargetmarker = undefined;

  if(!isDefined(self.binocularsstruct.targetmarkergroup)) {
    return;
  }
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(targetent, self.binocularsstruct.targetmarkergroup);
}

binoculars_settargetmarkerstate(targetent, state) {
  _id_7CBB905F3204B5D0 = (state >> 0) % 2 == 1;
  _id_01F6FF6A3877BF04 = (state >> 1) % 2 == 1;
  targetmarkergroupsetentitystate(self.binocularsstruct.targetmarkergroup, targetent, _id_7CBB905F3204B5D0);
  targetmarkergroupsetextrastate(self.binocularsstruct.targetmarkergroup, targetent, _id_01F6FF6A3877BF04);
}

binoculars_addheadicon(targetent) {
  _id_F98E48F2527D4205 = "hud_icon_new_marked";

  if(scripts\cp_mp\entityheadicons::_id_6EDE573723F08C0F())
    _id_F98E48F2527D4205 = "hud_icon_head_marked";

  _id_F9CD7FDA74E92E2A = 8;
  _id_E0E11F3B4551BE11 = 1;
  _id_C5409CA7522182B3 = 0;
  _id_30516B4AFD1763DE = 500;
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];
  targetdata.headicon = targetent scripts\cp_mp\entityheadicons::setheadicon_singleimage([], _id_F98E48F2527D4205, _id_F9CD7FDA74E92E2A, _id_E0E11F3B4551BE11, _id_C5409CA7522182B3, _id_30516B4AFD1763DE, undefined, 1, 1);
  thread binoculars_cleanupheadiconondisconnect(targetent);
}

binoculars_updateheadiconvisibility(targetent) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];

  if(!isDefined(targetdata) || !isDefined(targetdata.headicon)) {
    return;
  }
  players = scripts\mp\utility\teams::getteamdata(self.team, "players");

  foreach(player in players)
  binoculars_updateheadiconvisibilityforplayer(targetdata, player);
}

binoculars_updateheadiconvisibilityforplayer(targetdata, player) {
  _id_BD7E56573C70F3DB = 1;

  if(player == self && binoculars_isads() && istrue(targetdata.hastargetmarker))
    _id_BD7E56573C70F3DB = 0;

  if(_id_BD7E56573C70F3DB)
    scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(targetdata.headicon, player);
  else
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(targetdata.headicon, player);
}

binoculars_cleanupheadiconondisconnect(targetent) {
  entnum = targetent getentitynumber();
  self endon("disconnect");
  self endon("removeHeadIcon_" + entnum);
  targetent waittill("disconnect");

  if(isDefined(self.binocularsstruct) && isDefined(self.binocularsstruct.targetdata)) {
    targetdata = self.binocularsstruct.targetdata[entnum];

    if(isDefined(targetdata) && isDefined(targetdata.headicon))
      scripts\cp_mp\entityheadicons::setheadicon_deleteicon(targetdata.headicon);
  }
}

binoculars_removeheadicon(targetent) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(targetdata.headicon);
  self notify("removeHeadIcon_" + targetent getentitynumber());
}

binoculars_onstateinvalidenter(targetent) {
  binoculars_hidetargetmarker(targetent);
  binoculars_setcurrentstate(targetent, 0);
}

binoculars_onstateinvalidupdate(targetent, cansee) {
  _id_86F520BA99D66386 = binoculars_targetisValid(targetent);

  if(_id_86F520BA99D66386 && cansee)
    return 2;

  return 0;
}

binoculars_onstateunmarkedenter(targetent) {
  binoculars_showtargetmarker(targetent, 0);
  binoculars_setcurrentstate(targetent, 2);
}

binoculars_onstateunmarkedupdate(targetent, cansee) {
  _id_86F520BA99D66386 = binoculars_targetisValid(targetent);

  if(!_id_86F520BA99D66386)
    return 0;

  binoculars_updateprojectiondistance(targetent);

  if(!cansee)
    return 0;

  binoculars_updatetargetmarker(targetent, 0);

  if(binoculars_iswithinprojectiondistance(targetent)) {
    if(binoculars_hascoldblooded(targetent)) {
      self.binocularsstruct.markingcoldblooded = 1;
      return 2;
    }

    return 4;
  }

  return 2;
}

binoculars_onstatemarkpendingenter(targetent) {
  binoculars_setpendingtimer(targetent);
  binoculars_setcurrentstate(targetent, 4);
  self playlocalsound("binoculars_marking");
}

binoculars_onstatemarkpendingexit(targetent) {
  binoculars_clearpendingtimer(targetent);
  self stoplocalsound("binoculars_marking");
}

binoculars_onstatemarkpendingupdate(targetent, cansee) {
  _id_86F520BA99D66386 = binoculars_targetisValid(targetent);

  if(!_id_86F520BA99D66386)
    return 0;

  binoculars_updateprojectiondistance(targetent);

  if(!cansee)
    return 0;

  if(!binoculars_iswithinprojectiondistance(targetent))
    return 2;

  if(binoculars_checkpendingtimer(targetent))
    return 5;

  self.binocularsstruct.markingtarget = 1;

  if(self.binocularsstruct.markingendtime == 0)
    self.binocularsstruct.markingendtime = binoculars_getpendingendtime(targetent);
  else
    self.binocularsstruct.markingendtime = int(min(self.binocularsstruct.markingendtime, binoculars_getpendingendtime(targetent)));

  return 4;
}

binoculars_onstatemarkedenter(targetent) {
  binoculars_addheadicon(targetent);
  binoculars_updateheadiconvisibility(targetent);
  binoculars_showtargetmarker(targetent, 1);
  binoculars_setexpirationtimer(targetent);
  binoculars_addmarkpoints(targetent);
  binoculars_setcurrentstate(targetent, 5);
  self playlocalsound("binoculars_marked");
  self stoplocalsound("binoculars_marking");
  scripts\mp\utility\stats::incpersstat("binocularMarks", 1);
  scripts\cp_mp\challenges::_id_B0F754C8A379154E("equip_binoculars", self, int(distance(self.origin, targetent.origin)), 1);
}

binoculars_onstatemarkedexit(targetent) {
  binoculars_removeheadicon(targetent);
  binoculars_clearexpirationtimer(targetent);
}

binoculars_onstatemarkedupdate(targetent) {
  if(!binoculars_targetisvalidmark(targetent))
    return 0;

  binoculars_updateprojectiondistance(targetent);

  if(binoculars_isads() && binoculars_cansee(targetent) && binoculars_iswithinprojectiondistance(targetent))
    binoculars_setexpirationtimer(targetent);
  else if(binoculars_checkexpirationtimer(targetent))
    return 0;

  binoculars_updateheadiconvisibility(targetent);
  binoculars_updatetargetmarker(targetent, 1);
  return 5;
}

binoculars_targetisValid(targetent) {
  return isDefined(targetent) && binoculars_isads() && !(isPlayer(targetent) && !scripts\mp\utility\player::isreallyalive(targetent)) && !(isagent(targetent) && !isalive(targetent)) && !(level.teambased && isDefined(targetent.team) && targetent.team == self.team) && targetent != self && binoculars_istargetinrange(targetent) && binoculars_istargetinbroadfov(targetent);
}

binoculars_targetisvalidmark(targetent) {
  if(!isDefined(targetent))
    return 0;

  if(isPlayer(targetent) && !scripts\mp\utility\player::isreallyalive(targetent))
    return 0;

  if(isagent(targetent) && !isalive(targetent))
    return 0;

  if(level.teambased) {
    if(isDefined(targetent.team) && targetent.team == self.team)
      return 0;
  } else if(targetent == self)
    return 0;

  return 1;
}

binoculars_getmaxrange() {
  _id_0801F8D99ADFF8B0 = self playergetzoomlevelindex();

  if(_id_0801F8D99ADFF8B0 > 0)
    return getdvarint("dvar_60C09B13568650E9", 30000);
  else
    return getdvarint("dvar_C11B9FBC2F45B442", 15000);
}

binoculars_getfov() {
  _id_B52CDF6675378A31 = self playergetzoomfov();
  return _id_B52CDF6675378A31;
}

binoculars_istargetinrange(targetent) {
  return distancesquared(self.origin, targetent.origin) < self.binocularsstruct.maxrangesq;
}

binoculars_istargetinbroadfov(targetent) {
  return scripts\engine\utility::within_fov(self.origin, self getplayerangles(), targetent.origin, self.binocularsstruct.cosfov);
}

binoculars_iswithinprojectiondistance_compute(targetent) {
  _id_BF6A083C5A5402A4 = self getvieworigin();
  _id_BF6A0B3C5A54093D = _id_BF6A083C5A5402A4 + anglesToForward(self getplayerangles()) * self.binocularsstruct.maxrange;
  _id_20C094516733FFB1 = [targetent.origin];

  if(isPlayer(targetent)) {
    _id_295719F06C03407F = targetent scripts\mp\utility\player::getstancetop();
    _id_FC60036BA7BF253A = targetent scripts\mp\utility\player::getstancecenter();
    _id_20C094516733FFB1 = [_id_295719F06C03407F, _id_FC60036BA7BF253A, targetent.origin];
  } else if(isagent(targetent))
    _id_20C094516733FFB1 = [targetent.origin + (0, 0, 48)];

  foreach(point in _id_20C094516733FFB1) {
    distsq = lengthsquared(vectorfromlinetopoint(_id_BF6A083C5A5402A4, _id_BF6A0B3C5A54093D, point));

    if(distsq < self.binocularsstruct.projdistsq)
      return 1;
  }

  return 0;
}

binoculars_updateprojectiondistance(targetent) {
  passed = binoculars_iswithinprojectiondistance_compute(targetent);
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];

  if(passed)
    targetdata.withinprojectiondistance = 1;
  else
    targetdata.withinprojectiondistance = undefined;
}

binoculars_iswithinprojectiondistance(targetent) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];
  return istrue(targetdata.withinprojectiondistance);
}

binoculars_setpendingtimer(targetent) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];
  targetdata.pendingtimer = gettime() + binoculars_getpendingtime(targetent);
}

binoculars_clearpendingtimer(targetent) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];
  targetdata.pendingtimer = undefined;
}

binoculars_checkpendingtimer(targetent) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];

  if(!isDefined(targetdata.pendingtimer))
    return 0;

  return gettime() > targetdata.pendingtimer;
}

binoculars_getpendingtime(targetent) {
  mindistance = getdvarfloat("dvar_F59503AC1FF0E454", 2500);
  maxdistance = getdvarfloat("dvar_C7D3A5FBD69E4E06", 5000);

  if(mindistance >= maxdistance)
    return getdvarfloat("dvar_882715F356441B92", 500);

  _id_1AC96A06E64C75CD = distance(self.origin, targetent.origin);

  if(_id_1AC96A06E64C75CD <= mindistance)
    return getdvarfloat("dvar_882715F356441B92", 500);
  else if(_id_1AC96A06E64C75CD >= 5000)
    return getdvarfloat("dvar_81F96DE1624A2FC0", 500);
  else {
    mintime = getdvarfloat("dvar_882715F356441B92", 500);
    maxtime = getdvarfloat("dvar_81F96DE1624A2FC0", 500);
    _id_3042A94E9A4AD389 = (_id_1AC96A06E64C75CD - mindistance) / (maxdistance - mindistance);
    return int(scripts\engine\math::lerp(mintime, maxtime, _id_3042A94E9A4AD389));
  }
}

binoculars_getpendingendtime(targetent) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];

  if(!isDefined(targetdata.pendingtimer))
    return gettime() + binoculars_getpendingtime(targetent);

  return targetdata.pendingtimer;
}

binoculars_setexpirationtimer(targetent) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];
  expiretime = getdvarint("dvar_B9E9EE1040E95FE3", 5000);
  targetdata.expirationtimer = gettime() + expiretime;
}

binoculars_clearexpirationtimer(targetent) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];
  targetdata.expirationtimer = undefined;
}

binoculars_checkexpirationtimer(targetent) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];

  if(!isDefined(targetdata.expirationtimer))
    return 1;

  return gettime() >= targetdata.expirationtimer;
}

binoculars_addmarkpoints(targetent) {
  if(!isDefined(self.markedentitieslifeindices))
    self.markedentitieslifeindices = [];

  _id_8B1683C8EAD7B9BE = targetent getentitynumber();
  _id_59A52BFE186A64C9 = scripts\engine\utility::ter_op(isDefined(self.matchdatalifeindex), self.matchdatalifeindex, 0);

  if(!isDefined(self.markedentitieslifeindices[_id_8B1683C8EAD7B9BE]) || self.markedentitieslifeindices[_id_8B1683C8EAD7B9BE] > _id_59A52BFE186A64C9) {
    self.markedentitieslifeindices[_id_8B1683C8EAD7B9BE] = _id_59A52BFE186A64C9;
    thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_6EBE4FC013B04480");
    scripts\mp\playerlogic::_id_E636E108DFFE6AB7();
  }
}

binoculars_targetismarked(targetent) {
  if(!isDefined(self.binocularsstruct) || !isDefined(self.binocularsstruct.targetdata))
    return 0;

  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];

  if(!isDefined(targetdata))
    return 0;

  return targetdata.state == 5;
}

binoculars_giveassistpoints(attacker, victim) {
  if(!isDefined(level.binocularsinited)) {
    return;
  }
  if(!isDefined(attacker) || !isDefined(victim) || !isDefined(attacker.team)) {
    return;
  }
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(attacker.team, "players");

  foreach(_id_F0EA4030349A33D5 in _id_6D5ED003AF1F9612) {
    if(_id_F0EA4030349A33D5 == attacker) {
      continue;
    }
    if(_id_F0EA4030349A33D5 binoculars_targetismarked(victim))
      _id_F0EA4030349A33D5 thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_1928D4DC8BB8669F");
  }
}

binoculars_clearuidata() {
  self setclientomnvar("ui_binoculars_timer", 0);
  self setclientomnvar("ui_binoculars_state", 0);
  self stoplocalsound("binoculars_marking");
}

binoculars_setuidata(state, timer) {
  if(self getclientomnvar("ui_binoculars_state") == state && self getclientomnvar("ui_binoculars_timer") == timer) {
    return;
  }
  self setclientomnvar("ui_binoculars_state", state);
  self setclientomnvar("ui_binoculars_timer", timer);
}

binoculars_updateuidata() {
  _id_4FBBA5FA20D85EED = istrue(self.binocularsstruct.markingtarget);

  if(_id_4FBBA5FA20D85EED) {
    binoculars_setuidata(1, self.binocularsstruct.markingendtime);
    return;
  }

  _id_1B92495009D23667 = istrue(self.binocularsstruct.markingcoldblooded);

  if(_id_1B92495009D23667) {
    binoculars_setuidata(2, 0);
    return;
  }

  binoculars_setuidata(0, 0);

  if(!istrue(self.binocularsstruct._id_811EB055AA6DF60E)) {
    self.binocularsstruct._id_811EB055AA6DF60E = 1;
    thread _id_972E3424668E97F4();
  }
}

_id_972E3424668E97F4() {
  self endon("binoculars_ads_off");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    _id_A705A5A2E887557B = _id_8A8136A64DF0F01D();

    if(isDefined(_id_A705A5A2E887557B)) {
      _id_847B006DECFBCE4F = distance(self getvieworigin(), _id_A705A5A2E887557B);
      _id_48F6E924BB30EE5C = asin((_id_A705A5A2E887557B[2] - self getvieworigin()[2]) / _id_847B006DECFBCE4F);
      _id_847B006DECFBCE4F = _id_847B006DECFBCE4F * 0.0254;
      self setclientomnvar("ui_binoculars_target_distance", int(_func_C5CF558181E12D1F(_id_847B006DECFBCE4F)));
      self setclientomnvar("ui_binoculars_target_degree", int(_func_C5CF558181E12D1F(_id_48F6E924BB30EE5C)));
    } else
      self setclientomnvar("ui_binoculars_target_distance", -1);

    wait 0.15;
  }
}

_id_8A8136A64DF0F01D() {
  _id_C56207BDA09B3A36 = ["physicscontents_characterproxy", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicleclip"];
  contentoverride = physics_createcontents(_id_C56207BDA09B3A36);
  _id_22C4300CE1D248E8 = self getvieworigin();
  _id_98C6610C2907BA2B = _id_22C4300CE1D248E8 + anglesToForward(self getplayerangles()) * 50000;
  ignoreents = scripts\cp_mp\utility\killstreak_utility::playerkillstreakgetownerlookatignoreents();
  trace = scripts\engine\trace::ray_trace(_id_22C4300CE1D248E8, _id_98C6610C2907BA2B, ignoreents, contentoverride);

  if(trace["hittype"] == "hittype_none")
    return undefined;

  return trace["position"];
}