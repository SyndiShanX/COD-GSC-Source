/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\equipment\binoculars.gsc
**************************************************/

#using scripts\common\ae_utility;
#using scripts\common\values;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\targetmarkergroups;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\team_utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\playerlogic;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#namespace binoculars;

function binoculars_init() {
  if(isDefined(level.binocularsinited)) {
    return;
  }

  level.var_2c4f2a5075921418 = 2 | 131072;
  level.binocularsinited = 1;
}

function binoculars_onstateupdatefunc(stateindex, targetent, cansee) {
  switch (stateindex) {
    case 0:
      return binoculars_onstateinvalidupdate(targetent, cansee);
    case 2:
      return binoculars_onstateunmarkedupdate(targetent, cansee);
    case 4:
      return binoculars_onstatemarkpendingupdate(targetent, cansee);
  }
}

function binoculars_onstateenterfunc(stateindex, targetent) {
  switch (stateindex) {
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

function binoculars_onstateexitfunc(stateindex, targetent) {
  switch (stateindex) {
    case 4:
      binoculars_onstatemarkpendingexit(targetent);
      return;
    case 5:
      binoculars_onstatemarkedexit(targetent);
      return;
  }
}

function binoculars_ongive(equipmentref, equipmentslot, variantid) {
  if(equipmentref != "equip_binoculars" || getdvarint(@ "hash_8bcd5b94785fa58b", 1) != 1) {
    return;
  }

  binoculars_init();
  thread binoculars_watchforads();
}

function binoculars_ontake(equipmentref, equipmentslot) {
  if(equipmentref != "equip_binoculars") {
    return;
  }

  self notify("binoculars_take");
}

function binoculars_used(grenade) {
  waitframe();

  if(isDefined(grenade)) {
    grenade delete();
  }
}

function binoculars_watchforads() {
  self endon("disconnect");
  self notify("binoculars_watchForADS");
  self endon("binoculars_watchForADS");
  isads = 0;

  while(true) {
    raceresult = spawnStruct();
    childthread binoculars_watchracedeath(raceresult);
    childthread binoculars_watchracelaststand(raceresult);
    childthread function_621d5bba47a7c73(raceresult);
    childthread binoculars_watchracetake(raceresult);
    childthread binoculars_watchraceadson(raceresult);
    childthread binoculars_watchraceadsoff(raceresult);
    childthread function_1ba52d293a13fe7a(raceresult);
    childthread function_f802aa89b1f729a0(raceresult);
    childthread function_faec4945097de55d(raceresult);
    childthread function_d32f05ddfe8701fe(raceresult);
    self waittill("binoculars_watchRaceStart");
    waittillframeend();
    death = istrue(raceresult.death);
    take = istrue(raceresult.take);
    adsoff = istrue(raceresult.adsoff) || istrue(raceresult.laststand) || istrue(raceresult.enteredvehicle) || istrue(raceresult.ishaywire) || istrue(raceresult.var_a003e9e51f2cf83) || istrue(raceresult.detonateequipment) || istrue(raceresult.invalidweapon);
    adson = !adsoff && istrue(raceresult.adson);

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

function binoculars_watchracedeath(raceresult) {
  self endon("binoculars_watchRaceEnd");
  self waittill("death");
  raceresult.death = 1;
  self notify("binoculars_watchRaceStart");
}

function binoculars_watchracelaststand(raceresult) {
  self endon("binoculars_watchRaceEnd");
  self waittill("last_stand_start");
  raceresult.laststand = 1;
  self notify("binoculars_watchRaceStart");
}

function function_621d5bba47a7c73(raceresult) {
  self endon("binoculars_watchRaceEnd");
  waittill_any_2("vehicle_enter", "vehicle_change_seat");
  raceresult.enteredvehicle = 1;
  self notify("binoculars_watchRaceStart");
}

function binoculars_watchracetake(raceresult) {
  self endon("binoculars_watchRaceEnd");
  self waittill("binoculars_take");
  raceresult.take = 1;
  self notify("binoculars_watchRaceStart");
}

function binoculars_watchraceadson(raceresult) {
  self endon("binoculars_watchRaceEnd");

  while(true) {
    self waittill("offhand_ads_on", weapon);

    if(!istrue(self.var_74642c7f377a42c5)) {
      if(getweaponbasename(weapon) == "offhand_spotter_scope_mp") {
        break;
      }
    }
  }

  raceresult.adson = 1;
  self notify("binoculars_watchRaceStart");
}

function binoculars_watchraceadsoff(raceresult) {
  self endon("binoculars_watchRaceEnd");

  while(true) {
    self waittill("offhand_ads_off", weapon);

    if(getweaponbasename(weapon) == "offhand_spotter_scope_mp") {
      break;
    }
  }

  raceresult.adsoff = 1;
  self notify("binoculars_watchRaceStart");
}

function function_1ba52d293a13fe7a(raceresult) {
  self endon("binoculars_watchRaceEnd");

  while(true) {
    self waittill("player_isHaywire");
    break;
  }

  raceresult.ishaywire = 1;
  self notify("binoculars_watchRaceStart");
}

function function_f802aa89b1f729a0(raceresult) {
  self endon("binoculars_watchRaceEnd");

  while(true) {
    self waittill("gas_begin_coughing");
    break;
  }

  raceresult.var_a003e9e51f2cf83 = 1;
  self notify("binoculars_watchRaceStart");
}

function function_faec4945097de55d(raceresult) {
  self endon("binoculars_watchRaceEnd");
  self waittill("detonate");
  raceresult.detonateequipment = 1;
  self notify("binoculars_watchRaceStart");
}

function function_d32f05ddfe8701fe(raceresult) {
  self endon("binoculars_watchRaceEnd");
  self waittill("binoculars_invalid_weapon");
  raceresult.invalidweapon = 1;
  self notify("binoculars_watchRaceStart");
}

function binoculars_endadslogic() {
  self notify("binoculars_ads_off");
  scripts\common\values::reset_all("binoculars_ads");

  if(isDefined(self.binocularsstruct)) {
    self.binocularsstruct.adson = undefined;
    self.binocularsstruct.var_811eb055aa6df60e = undefined;

    if(isDefined(self.binocularsstruct.targetmarkergroup)) {
      scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.binocularsstruct.targetmarkergroup);
      self.binocularsstruct.targetmarkergroup = undefined;
    }

    binoculars_clearuidata();

    foreach(targetdata in self.binocularsstruct.targetdata) {
      if(!isDefined(targetdata)) {
        continue;
      }

      targetdata.hastargetmarker = undefined;

      if(isDefined(targetdata.headicon)) {
        binoculars_updateheadiconvisibilityforplayer(targetdata, self);
      }
    }
  }
}

function binoculars_runadslogic() {
  self endon("disconnect");
  self endon("binoculars_ads_off");
  self notify("binoculars_ads_on");
  scripts\common\values::set("binoculars_ads", "usability", 0);
  thread function_b2875ea64bc1896f();

  if(!isDefined(self.binocularsstruct)) {
    self.binocularsstruct = spawnStruct();
    self.binocularsstruct.targetdata = [];
    self.binocularsstruct.var_811eb055aa6df60e = 0;
  }

  self.binocularsstruct.adson = 1;
  self.binocularsstruct.targetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("overlaytargetmarkerenemy", self, undefined, self, 0, 0, 0);
  thread binoculars_processtargetdata();
}

function function_b2875ea64bc1896f() {
  self endon("disconnect");
  self endon("binoculars_ads_off");

  while(true) {
    currentoffhand = self getheldoffhand();

    if(isnullweapon(currentoffhand) || isDefined(currentoffhand.basename) && currentoffhand.basename != "offhand_spotter_scope_mp") {
      break;
    }

    waitframe();
  }

  wait 0.05;
  self notify("binoculars_invalid_weapon");
}

function binoculars_isads() {
  return isDefined(self.binocularsstruct) && istrue(self.binocularsstruct.adson);
}

function binoculars_processtargetdata() {
  if(istrue(self.binocularsstruct.var_2877d88b9a6d8cdb)) {
    return;
  }

  self.binocularsstruct.var_2877d88b9a6d8cdb = 1;
  self endon("disconnect");

  while(true) {
    currenttarget = undefined;
    seentargets = [];

    while(true) {
      function_5c3ab97c636c1b90();

      if(binoculars_isads()) {
        targetarray = sortbydistance(self function_c5140fff72feca2d(self.binocularsstruct.maxrange, binoculars_getfov(), level.var_2c4f2a5075921418, 0), self.origin);
        var_56bf4e4b2bb221a7 = [];
        var_cb791416725e9bc6 = 0;

        foreach(targetent in targetarray) {
          targetnum = targetent getentitynumber();
          curstate = function_856db8d000d0be6(targetnum);
          targetdata = self.binocularsstruct.targetdata[targetnum];

          if(isDefined(targetdata)) {
            function_34d6333ca8b1f289(targetent);
          }

          if(isDefined(currenttarget)) {
            continue;
          }

          if(curstate == 5) {
            continue;
          }

          newstate = binoculars_onstateupdatefunc(curstate, targetent, 1);
          var_56bf4e4b2bb221a7[targetnum] = 1;
          seentargets[targetnum] = targetent;

          if(newstate != curstate) {
            binoculars_onstateexitfunc(curstate, targetent);
            binoculars_onstateenterfunc(newstate, targetent);

            if(newstate == 4) {
              currenttarget = targetent;
            }
          }
        }

        foreach(targetent in seentargets) {
          if(!isDefined(targetent)) {
            continue;
          }

          targetnum = targetent getentitynumber();

          if(!isDefined(var_56bf4e4b2bb221a7[targetnum])) {
            seentargets[targetnum] = undefined;
            curstate = function_856db8d000d0be6(targetnum);
            newstate = binoculars_onstateupdatefunc(curstate, targetent, 0);

            if(newstate != curstate) {
              binoculars_onstateexitfunc(curstate, targetent);
              binoculars_onstateenterfunc(newstate, targetent);
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
      foreach(targetent in seentargets) {
        if(!isDefined(targetent)) {
          continue;
        }

        if(targetent == currenttarget) {
          continue;
        }

        curstate = function_856db8d000d0be6(targetent getentitynumber());
        newstate = binoculars_onstateupdatefunc(curstate, targetent, 0);

        if(newstate != curstate) {
          binoculars_onstateexitfunc(curstate, targetent);
          binoculars_onstateenterfunc(newstate, targetent);
        }
      }
    }

    if(!isDefined(currenttarget)) {
      waitframe();
      continue;
    }

    lastseentime = gettime();
    cansee = 1;
    currenttargetnumber = currenttarget getentitynumber();

    while(true) {
      function_5c3ab97c636c1b90();

      if(binoculars_isads()) {
        if(!isDefined(currenttarget)) {
          waitframe();
          break;
        }

        curstate = function_856db8d000d0be6(currenttargetnumber);

        if(gettime() - lastseentime > 100) {
          lastseentime = gettime();
          cansee = function_67da6f8a8e37737b(currenttarget);
        }

        newstate = binoculars_onstateupdatefunc(curstate, currenttarget, cansee);

        if(newstate != curstate) {
          binoculars_onstateexitfunc(curstate, currenttarget);
          binoculars_onstateenterfunc(newstate, currenttarget);

          if(newstate == 0 || newstate == 2) {
            waitframe();
            break;
          } else if(newstate == 5) {
            if(!isDefined(self.markedents)) {
              self.markedents = [];
            }

            self.markedents[currenttarget getentitynumber()] = currenttarget;
            thread binoculars_updatemarkedents();
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

function function_856db8d000d0be6(targetnum) {
  targetdata = self.binocularsstruct.targetdata[targetnum];

  if(isDefined(targetdata)) {
    return targetdata.state;
  }

  return 0;
}

function function_5c3ab97c636c1b90() {
  projectiondistance = getdvarfloat(@ "hash_90d4dd93f932de3f", 72);
  self.binocularsstruct.maxrange = binoculars_getmaxrange();
  self.binocularsstruct.maxrangesq = self.binocularsstruct.maxrange * self.binocularsstruct.maxrange;
  self.binocularsstruct.cosfov = cos(binoculars_getfov());
  self.binocularsstruct.projdistsq = projectiondistance * projectiondistance;
  self.binocularsstruct.markingtarget = 0;
  self.binocularsstruct.markingcoldblooded = 0;
  self.binocularsstruct.markingendtime = 0;
}

function binoculars_updatemarkedents() {
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

      if(isDefined(targetdata)) {
        curstate = targetdata.state;
      }

      newstate = binoculars_onstatemarkedupdate(targetent);

      if(newstate != curstate) {
        binoculars_onstateexitfunc(curstate, targetent);
        binoculars_onstateenterfunc(newstate, targetent);
        self.markedents[entnum] = undefined;
      }
    }
  }

  self.markedents = undefined;
}

function function_67da6f8a8e37737b(targetent) {
  contents = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 1, 0, 1);
  tracepoints = [targetent.origin];

  if(isPlayer(targetent)) {
    headpos = targetent scripts\mp\utility\player::getstancetop();
    centerpos = targetent scripts\mp\utility\player::getstancecenter();
    tracepoints = [headpos, centerpos, targetent.origin];
  } else if(isagent(targetent)) {
    tracepoints = [targetent.origin + (0, 0, 48)];
  }

  ignorelist = [self, targetent];
  vehicle = targetent scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(vehicle)) {
    ignorelist[ignorelist.size] = vehicle;
    vehiclechildren = vehicle getlinkedchildren(1);

    foreach(child in vehiclechildren) {
      ignorelist[ignorelist.size] = vehicle;
    }
  }

  checkpassed = 0;

  foreach(point in tracepoints) {
    if(!scripts\engine\trace::ray_trace_passed(self getvieworigin(), point, ignorelist, contents)) {
      continue;
    }

    return true;
  }

  return false;
}

function function_34d6333ca8b1f289(targetent) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];
  assert(isDefined(targetdata));
  targetdata.loschecktime = gettime();
  targetdata.loscheckpassed = 1;
}

function binoculars_cansee(targetent) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];
  assert(isDefined(targetdata));

  if(!isDefined(targetdata.loschecktime) || gettime() - targetdata.loschecktime > 1000) {
    return false;
  }

  return istrue(targetdata.loscheckpassed);
}

function binoculars_setcurrentstate(targetent, newstate) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];

  if(!isDefined(targetdata)) {
    if(newstate == 0) {
      return;
    }

    targetdata = spawnStruct();
    self.binocularsstruct.targetdata[targetent getentitynumber()] = targetdata;
  }

  targetdata.state = newstate;
}

function binoculars_hascoldblooded(targetent) {
  return isPlayer(targetent) && targetent _hasperk("specialty_noscopeoutline");
}

function binoculars_showtargetmarker(targetent, ismarked) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];

  if(isDefined(targetdata)) {
    targetdata.hastargetmarker = 1;
  }

  if(!isDefined(self.binocularsstruct.targetmarkergroup)) {
    return;
  }

  scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(targetent, self.binocularsstruct.targetmarkergroup, 0);
  hascoldblooded = binoculars_hascoldblooded(targetent);

  if(hascoldblooded) {
    binoculars_settargetmarkerstate(targetent, 3);
    return;
  }

  if(ismarked) {
    binoculars_settargetmarkerstate(targetent, 2);
    return;
  }

  binoculars_settargetmarkerstate(targetent, 1);
}

function binoculars_updatetargetmarker(targetent, ismarked) {
  if(!isDefined(self.binocularsstruct.targetmarkergroup)) {
    return;
  }

  hascoldblooded = binoculars_hascoldblooded(targetent);

  if(hascoldblooded) {
    binoculars_settargetmarkerstate(targetent, 3);
    return;
  }

  if(ismarked) {
    binoculars_settargetmarkerstate(targetent, 2);
    return;
  }

  binoculars_settargetmarkerstate(targetent, 1);
}

function binoculars_hidetargetmarker(targetent) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];

  if(isDefined(targetdata)) {
    targetdata.hastargetmarker = undefined;
  }

  if(!isDefined(self.binocularsstruct.targetmarkergroup)) {
    return;
  }

  scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(targetent, self.binocularsstruct.targetmarkergroup);
}

function binoculars_settargetmarkerstate(targetent, state) {
  firstbit = (state >> 0) % 2 == 1;
  secondbit = (state >> 1) % 2 == 1;
  targetmarkergroupsetentitystate(self.binocularsstruct.targetmarkergroup, targetent, firstbit);
  targetmarkergroupsetextrastate(self.binocularsstruct.targetmarkergroup, targetent, secondbit);
}

function binoculars_addheadicon(targetent) {
  markicon = "hud_icon_new_marked";

  if(scripts\cp_mp\entityheadicons::function_6ede573723f08c0f()) {
    markicon = "hud_icon_head_marked";
  }

  var_f9cd7fda74e92e2a = 8;
  drawthroughgeo = 1;
  var_c5409ca7522182b3 = 0;
  naturaldist = 500;
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];
  assert(isDefined(targetdata));
  targetdata.headicon = targetent scripts\cp_mp\entityheadicons::setheadicon_singleimage([], markicon, var_f9cd7fda74e92e2a, drawthroughgeo, var_c5409ca7522182b3, naturaldist, undefined, 1, 1);
  thread binoculars_cleanupheadiconondisconnect(targetent);
}

function binoculars_updateheadiconvisibility(targetent) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];

  if(!isDefined(targetdata) || !isDefined(targetdata.headicon)) {
    return;
  }

  players = scripts\mp\utility\teams::getteamdata(self.team, "players");

  foreach(player in players) {
    binoculars_updateheadiconvisibilityforplayer(targetdata, player);
  }
}

function binoculars_updateheadiconvisibilityforplayer(targetdata, player) {
  assert(isDefined(targetdata));
  assert(isDefined(targetdata.headicon));
  shouldshow = 1;

  if(player == self && binoculars_isads() && istrue(targetdata.hastargetmarker)) {
    shouldshow = 0;
  }

  if(shouldshow) {
    scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(targetdata.headicon, player);
    return;
  }

  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(targetdata.headicon, player);
}

function binoculars_cleanupheadiconondisconnect(targetent) {
  entnum = targetent getentitynumber();
  self endon("disconnect");
  self endon("removeHeadIcon_" + entnum);
  targetent waittill("disconnect");

  if(isDefined(self.binocularsstruct) && isDefined(self.binocularsstruct.targetdata)) {
    targetdata = self.binocularsstruct.targetdata[entnum];

    if(isDefined(targetdata) && isDefined(targetdata.headicon)) {
      scripts\cp_mp\entityheadicons::setheadicon_deleteicon(targetdata.headicon);
    }
  }
}

function binoculars_removeheadicon(targetent) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];
  assert(isDefined(targetdata));
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(targetdata.headicon);
  self notify("removeHeadIcon_" + targetent getentitynumber());
}

function binoculars_onstateinvalidenter(targetent) {
  binoculars_hidetargetmarker(targetent);
  binoculars_setcurrentstate(targetent, 0);
}

function binoculars_onstateinvalidupdate(targetent, cansee) {
  istargetvalid = binoculars_targetisValid(targetent);

  if(istargetvalid && cansee) {
    return 2;
  }

  return 0;
}

function binoculars_onstateunmarkedenter(targetent) {
  binoculars_showtargetmarker(targetent, 0);
  binoculars_setcurrentstate(targetent, 2);
}

function binoculars_onstateunmarkedupdate(targetent, cansee) {
  istargetvalid = binoculars_targetisValid(targetent);

  if(!istargetvalid) {
    return 0;
  }

  binoculars_updateprojectiondistance(targetent);

  if(!cansee) {
    return 0;
  }

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

function binoculars_onstatemarkpendingenter(targetent) {
  binoculars_setpendingtimer(targetent);
  binoculars_setcurrentstate(targetent, 4);
  self playlocalsound("eqp_spotter_scope_marking");
}

function binoculars_onstatemarkpendingexit(targetent) {
  binoculars_clearpendingtimer(targetent);
  self stoplocalsound("eqp_spotter_scope_marking");
}

function binoculars_onstatemarkpendingupdate(targetent, cansee) {
  istargetvalid = binoculars_targetisValid(targetent);

  if(!istargetvalid) {
    return 0;
  }

  binoculars_updateprojectiondistance(targetent);

  if(!cansee) {
    return 0;
  }

  if(!binoculars_iswithinprojectiondistance(targetent)) {
    return 2;
  }

  if(binoculars_checkpendingtimer(targetent)) {
    return 5;
  }

  self.binocularsstruct.markingtarget = 1;

  if(self.binocularsstruct.markingendtime == 0) {
    self.binocularsstruct.markingendtime = binoculars_getpendingendtime(targetent);
  } else {
    self.binocularsstruct.markingendtime = int(min(self.binocularsstruct.markingendtime, binoculars_getpendingendtime(targetent)));
  }

  return 4;
}

function binoculars_onstatemarkedenter(targetent) {
  binoculars_addheadicon(targetent);
  binoculars_updateheadiconvisibility(targetent);
  binoculars_showtargetmarker(targetent, 1);
  binoculars_setexpirationtimer(targetent);
  binoculars_addmarkpoints(targetent);
  binoculars_setcurrentstate(targetent, 5);
  self playlocalsound("eqp_spotter_scope_marked_beep");
  self stoplocalsound("eqp_spotter_scope_marking");
  incpersstat("binocularMarks", 1);
  scripts\cp_mp\challenges::function_b0f754c8a379154e("equip_binoculars", self, int(distance(self.origin, targetent.origin)), function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"hit"));
}

function binoculars_onstatemarkedexit(targetent) {
  binoculars_removeheadicon(targetent);
  binoculars_clearexpirationtimer(targetent);
  self stoplocalsound("eqp_spotter_scope_marking");
}

function binoculars_onstatemarkedupdate(targetent) {
  if(!binoculars_targetisvalidmark(targetent)) {
    return 0;
  }

  binoculars_updateprojectiondistance(targetent);

  if(binoculars_isads() && binoculars_cansee(targetent) && binoculars_iswithinprojectiondistance(targetent)) {
    binoculars_setexpirationtimer(targetent);
  } else if(binoculars_checkexpirationtimer(targetent)) {
    return 0;
  }

  binoculars_updateheadiconvisibility(targetent);
  binoculars_updatetargetmarker(targetent, 1);
  return 5;
}

function binoculars_targetisValid(targetent) {
  return isDefined(targetent) && binoculars_isads() && !(isPlayer(targetent) && !isreallyalive(targetent)) && !(isagent(targetent) && !isalive(targetent)) && !(level.teambased && isDefined(targetent.team) && targetent.team == self.team) && targetent != self && binoculars_istargetinrange(targetent) && binoculars_istargetinbroadfov(targetent);
}

function binoculars_targetisvalidmark(targetent) {
  if(!isDefined(targetent)) {
    return false;
  }

  if(isPlayer(targetent) && !isreallyalive(targetent)) {
    return false;
  }

  if(isagent(targetent) && !isalive(targetent)) {
    return false;
  }

  if(level.teambased) {
    if(isDefined(targetent.team) && targetent.team == self.team) {
      return false;
    }
  } else if(targetent == self) {
    return false;
  }

  return true;
}

function binoculars_getmaxrange() {
  zoomlevelindex = self playergetzoomlevelindex();

  if(zoomlevelindex > 0) {
    return getdvarint(@ "hash_60c09b13568650e9", 30000);
  }

  return getdvarint(@ "hash_c11b9fbc2f45b442", 15000);
}

function binoculars_getfov() {
  zoomfov = self playergetzoomfov();
  return zoomfov;
}

function binoculars_istargetinrange(targetent) {
  return distancesquared(self.origin, targetent.origin) < self.binocularsstruct.maxrangesq;
}

function binoculars_istargetinbroadfov(targetent) {
  return within_fov(self.origin, self getplayerangles(), targetent.origin, self.binocularsstruct.cosfov);
}

function binoculars_iswithinprojectiondistance_compute(targetent) {
  pointa = self getvieworigin();
  pointb = pointa + anglesToForward(self getplayerangles()) * self.binocularsstruct.maxrange;
  var_20c094516733ffb1 = [targetent.origin];

  if(isPlayer(targetent)) {
    headpos = targetent scripts\mp\utility\player::getstancetop();
    centerpos = targetent scripts\mp\utility\player::getstancecenter();
    var_20c094516733ffb1 = [headpos, centerpos, targetent.origin];
  } else if(isagent(targetent)) {
    var_20c094516733ffb1 = [targetent.origin + (0, 0, 48)];
  }

  foreach(point in var_20c094516733ffb1) {
    distsq = lengthsquared(vectorfromlinetopoint(pointa, pointb, point));

    if(distsq < self.binocularsstruct.projdistsq) {
      return true;
    }
  }

  return false;
}

function binoculars_updateprojectiondistance(targetent) {
  passed = binoculars_iswithinprojectiondistance_compute(targetent);
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];
  assert(isDefined(targetdata));

  if(passed) {
    targetdata.withinprojectiondistance = 1;
    return;
  }

  targetdata.withinprojectiondistance = undefined;
}

function binoculars_iswithinprojectiondistance(targetent) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];
  assert(isDefined(targetdata));
  return istrue(targetdata.withinprojectiondistance);
}

function binoculars_setpendingtimer(targetent) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];
  assert(isDefined(targetdata));
  targetdata.pendingtimer = gettime() + binoculars_getpendingtime(targetent);
}

function binoculars_clearpendingtimer(targetent) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];
  assert(isDefined(targetdata));
  targetdata.pendingtimer = undefined;
}

function binoculars_checkpendingtimer(targetent) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];
  assert(isDefined(targetdata));

  if(!isDefined(targetdata.pendingtimer)) {
    return false;
  }

  return gettime() > targetdata.pendingtimer;
}

function binoculars_getpendingtime(targetent) {
  mindistance = getdvarfloat(@ "hash_f59503ac1ff0e454", 2500);
  maxdistance = getdvarfloat(@ "hash_c7d3a5fbd69e4e06", 5000);

  if(mindistance >= maxdistance) {
    return getdvarfloat(@ "hash_882715f356441b92", 500);
  }

  disttotarget = distance(self.origin, targetent.origin);

  if(disttotarget <= mindistance) {
    return getdvarfloat(@ "hash_882715f356441b92", 500);
  }

  if(disttotarget >= 5000) {
    return getdvarfloat(@ "hash_81f96de1624a2fc0", 500);
  }

  mintime = getdvarfloat(@ "hash_882715f356441b92", 500);
  maxtime = getdvarfloat(@ "hash_81f96de1624a2fc0", 500);
  distfrac = (disttotarget - mindistance) / (maxdistance - mindistance);
  return int(math::lerp(mintime, maxtime, distfrac));
}

function binoculars_getpendingendtime(targetent) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];
  assert(isDefined(targetdata));

  if(!isDefined(targetdata.pendingtimer)) {
    return (gettime() + binoculars_getpendingtime(targetent));
  }

  return targetdata.pendingtimer;
}

function binoculars_setexpirationtimer(targetent) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];
  assert(isDefined(targetdata));
  expiretime = getdvarint(@ "hash_b9e9ee1040e95fe3", 5000);
  targetdata.expirationtimer = gettime() + expiretime;
}

function binoculars_clearexpirationtimer(targetent) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];
  assert(isDefined(targetdata));
  targetdata.expirationtimer = undefined;
}

function binoculars_checkexpirationtimer(targetent) {
  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];
  assert(isDefined(targetdata));

  if(!isDefined(targetdata.expirationtimer)) {
    return true;
  }

  return gettime() >= targetdata.expirationtimer;
}

function binoculars_addmarkpoints(targetent) {
  if(!isDefined(self.markedentitieslifeindices)) {
    self.markedentitieslifeindices = [];
  }

  entitynum = targetent getentitynumber();
  lifeindex = ter_op(isDefined(self.matchdatalifeindex), self.matchdatalifeindex, 0);

  if(!isDefined(self.markedentitieslifeindices[entitynum]) || self.markedentitieslifeindices[entitynum] > lifeindex) {
    self.markedentitieslifeindices[entitynum] = lifeindex;
    thread doscoreevent(#"binoculars_marked");
    scripts\mp\playerlogic::playerhasmoved();
  }
}

function binoculars_targetismarked(targetent) {
  if(!isDefined(self.binocularsstruct) || !isDefined(self.binocularsstruct.targetdata)) {
    return false;
  }

  targetdata = self.binocularsstruct.targetdata[targetent getentitynumber()];

  if(!isDefined(targetdata)) {
    return false;
  }

  return targetdata.state == 5;
}

function binoculars_giveassistpoints(attacker, victim) {
  if(!isDefined(level.binocularsinited)) {
    return;
  }

  if(!isDefined(attacker) || !isDefined(victim) || !isDefined(attacker.team)) {
    return;
  }

  teammates = scripts\mp\utility\teams::getteamdata(attacker.team, "players");

  foreach(teammate in teammates) {
    if(teammate == attacker) {
      continue;
    }

    if(teammate binoculars_targetismarked(victim)) {
      teammate thread scripts\mp\utility\points::doscoreevent(#"binoculars_assist");
    }
  }
}

function binoculars_clearuidata() {
  self setclientomnvar("ui_binoculars_timer", 0);
  self setclientomnvar("ui_binoculars_state", 0);
  self stoplocalsound("eqp_spotter_scope_marking");
}

function binoculars_setuidata(state, timer) {
  if(self getclientomnvar("ui_binoculars_state") == state && self getclientomnvar("ui_binoculars_timer") == timer) {
    return;
  }

  self setclientomnvar("ui_binoculars_state", state);
  self setclientomnvar("ui_binoculars_timer", timer);
}

function binoculars_updateuidata() {
  var_4fbba5fa20d85eed = istrue(self.binocularsstruct.markingtarget);

  if(var_4fbba5fa20d85eed) {
    binoculars_setuidata(1, self.binocularsstruct.markingendtime);
    return;
  }

  var_1b92495009d23667 = istrue(self.binocularsstruct.markingcoldblooded);

  if(var_1b92495009d23667) {
    binoculars_setuidata(2, 0);
    return;
  }

  binoculars_setuidata(0, 0);

  if(!istrue(self.binocularsstruct.var_811eb055aa6df60e)) {
    self.binocularsstruct.var_811eb055aa6df60e = 1;
    thread function_972e3424668e97f4();
  }
}

function function_972e3424668e97f4() {
  self endon("binoculars_ads_off");
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    newlookatpos = function_8a8136a64df0f01d();

    if(isDefined(newlookatpos)) {
      targetdistance = distance(self getvieworigin(), newlookatpos);
      targetdegree = asin((newlookatpos[2] - self getvieworigin()[2]) / targetdistance);
      targetdistance *= 0.0254;
      self setclientomnvar("ui_binoculars_target_distance", int(round(targetdistance)));
      self setclientomnvar("ui_binoculars_target_degree", int(round(targetdegree)));
    } else {
      self setclientomnvar("ui_binoculars_target_distance", -1);
    }

    wait 0.15;
  }
}

function function_8a8136a64df0f01d() {
  content = ["physicscontents_characterproxy", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicleclip"];
  contentoverride = physics_createcontents(content);
  starttrace = self getvieworigin();
  endtrace = starttrace + anglesToForward(self getplayerangles()) * 50000;
  ignoreents = scripts\cp_mp\utility\killstreak_utility::playerkillstreakgetownerlookatignoreents();
  trace = scripts\engine\trace::ray_trace(starttrace, endtrace, ignoreents, contentoverride);

  if(trace["hittype"] == "hittype_none") {
    return undefined;
  }

  return trace["position"];
}