/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\humanoid\_humanoid_util.gsc
******************************************************/

canhumanoidmovepointtopoint(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 6;
  }

  var_3 = (0, 0, 1) * var_2;
  var_4 = var_0 + var_3;
  var_5 = var_1 + var_3;
  return capsuletracepassed(var_4, self.radius, self.height - var_2, self, 1, 0, 0, var_5);
}

getnummeleesectors() {
  return 8;
}

getmeleeanglestep() {
  return 360.0 / getnummeleesectors();
}

meleesectortargetposition(var_0, var_1, var_2) {
  var_3 = var_1 * getmeleeanglestep() - 180.0;
  var_4 = var_0 + anglesToForward((0, var_3, 0)) * var_2;
  return var_4;
}

getmeleesectors(var_0) {
  return self.meleesectors[var_0];
}

validatemeleesectors(var_0) {
  if(!isDefined(self.meleesectors)) {
    self.meleesectors = [];
  }

  if(!isDefined(self.meleesectors[var_0])) {
    self.meleesectors[var_0] = [];

    for(var_1 = 0; var_1 < getnummeleesectors(); var_1++) {
      self.meleesectors[var_0][var_1] = spawnStruct();
      self.meleesectors[var_0][var_1].timestamp = 0;
      self.meleesectors[var_0][var_1].claimer = undefined;
      self.meleesectors[var_0][var_1].origin = undefined;
      self.meleesectors[var_0][var_1].num = var_1;
    }
  }
}

getoriginformeleesectors(var_0) {
  var_1 = var_0.origin;

  if(isDefined(var_0.groundpos)) {
    var_1 = var_0.groundpos;

    if(isDefined(self.distractiondrone) && var_0 == self.distractiondrone && hascalculatednearestnodetounreachabledrone()) {
      var_2 = getnearestnodetounreachabledrone();

      if(isDefined(var_2)) {
        var_1 = var_2.origin;
      }
    }
  } else if(isPlayer(var_0) && (var_0 isjumping() || var_0 ishighjumping())) {
    if(!isDefined(var_0.playergroundpostime)) {
      var_0.playergroundpostime = 0;
    }

    if(gettime() > var_0.playergroundpostime) {
      var_0.playergroundpos = getgroundposition(var_0.origin, 15);
      var_0.playergroundpostime = gettime();
    }

    if(isDefined(var_0.playergroundpos)) {
      var_1 = var_0.playergroundpos;
    }
  }

  return var_1;
}

hasvalidmeleesectorsfortype(var_0, var_1) {
  for(var_2 = 0; var_2 < getnummeleesectors(); var_2++) {
    var_3 = var_0 getmeleesectors(var_1);
    var_4 = var_3[var_2];

    if(isDefined(var_4.origin)) {
      return 1;
    }
  }

  return 0;
}

calculatenearestnodetounreachabledrone() {
  var_0 = self getnearestnode();

  if(isDefined(var_0)) {
    var_1 = nodegetsplitgroup(var_0);

    if(!isDefined(self.distractiondrone.nearestnodeforgroup)) {
      self.distractiondrone.nearestnodeforgroup = [];
    }

    var_2 = 0;
    var_3 = 500;
    var_4 = undefined;

    for(var_5 = undefined; !isDefined(var_4) && var_3 <= 1500; var_3 = var_3 + 500) {
      var_6 = [];

      if(isDefined(level.nearestnodetounreachabledronesearchheight)) {
        var_6 = getnodesinradiussorted(self.distractiondrone.groundpos, var_3, var_2, level.nearestnodetounreachabledronesearchheight);
      } else {
        var_6 = getnodesinradiussorted(self.distractiondrone.groundpos, var_3, var_2);
      }

      var_7 = undefined;

      foreach(var_9 in var_6) {
        if(nodegetsplitgroup(var_9) == var_1) {
          if(!isDefined(var_7) || nodesvisible(var_9, var_7, 1)) {
            var_4 = var_9;
            break;
          } else if(!isDefined(var_5)) {
            var_5 = var_9;
          }
        }
      }

      var_2 = var_3;
    }

    if(isDefined(var_4)) {
      self.distractiondrone.nearestnodeforgroup[var_1] = var_4;
    } else if(isDefined(var_5)) {
      self.distractiondrone.nearestnodeforgroup[var_1] = var_5;
    } else {
      self.distractiondrone.nearestnodeforgroup[var_1] = 0;
    }
  }
}

hascalculatednearestnodetounreachabledrone() {
  var_0 = self getnearestnode();

  if(isDefined(var_0) && isDefined(self.distractiondrone.nearestnodeforgroup)) {
    var_1 = self.distractiondrone.nearestnodeforgroup[nodegetsplitgroup(var_0)];

    if(isDefined(var_1)) {
      return 1;
    }
  }

  return 0;
}

getnearestnodetounreachabledrone() {
  var_0 = self getnearestnode();
  var_1 = self.distractiondrone.nearestnodeforgroup[nodegetsplitgroup(var_0)];

  if(!isnumber(var_1)) {
    return var_1;
  } else {
    return undefined;
  }
}

shouldtargetdistractiondrone() {
  if(hascalculatednearestnodetounreachabledrone()) {
    var_0 = getnearestnodetounreachabledrone();

    if(!isDefined(var_0)) {
      return 0;
    }
  }

  return 1;
}

isentunreachabledrone(var_0) {
  if(isDefined(self.distractiondrone) && var_0 == self.distractiondrone) {
    if(self.distractiondronebadpathcount > 5) {
      return 1;
    }
  }

  return 0;
}

getmeleetargetpoint(var_0, var_1) {
  var_0 validatemeleesectors(self.meleesectortype);
  var_2 = var_0 getmeleesectors(self.meleesectortype);
  var_4 = var_1;
  var_5 = self.origin - var_4;
  var_6 = lengthsquared(var_5);

  if(var_6 < 256) {
    var_7 = -1;

    for(var_8 = 0; var_8 < getnummeleesectors(); var_8++) {
      var_9 = var_2[var_8];

      if(isDefined(var_9.claimer) && var_9.claimer == self) {
        var_7 = var_9.num;
      }
    }

    if(var_7 < 0) {
      var_7 = self getentitynumber() % getnummeleesectors();
    }

    var_10 = var_7;
  } else {
    var_11 = angleclamp180(vectortoyaw(var_5)) + 180.0;
    var_10 = var_11 / getmeleeanglestep();
    var_7 = int(var_10 + 0.5);
  }

  var_12 = undefined;
  var_13 = -1;
  var_14 = 3;
  var_15 = 2;

  if(var_10 > var_7) {
    var_13 = var_13 * -1;
    var_14 = var_14 * -1;
    var_15 = var_15 * -1;
  }

  var_16 = getnummeleesectors();

  for(var_17 = 0; var_17 < var_16 / 2 + 1; var_17++) {
    for(var_18 = var_13; var_18 != var_14; var_18 = var_18 + var_15) {
      var_19 = var_7 + var_17 * var_18;

      if(var_19 >= var_16) {
        var_19 = var_19 - var_16;
      } else if(var_19 < 0) {
        var_19 = var_19 + var_16;
      }

      var_9 = var_2[var_19];

      if(!isDefined(var_12) && gettime() - var_9.timestamp >= self.meleesectorupdatetime) {
        if(isDefined(level.trycalculatesectororigin) && isDefined(level.trycalculatesectororigin[self.agent_type])) {
          [[level.trycalculatesectororigin[self.agent_type]]](var_9, var_4, self.attackoffset, self.radius);
        } else {
          trycalculatesectororigin(var_9, var_4, self.attackoffset, self.radius);
        }
      }

      if(!isDefined(var_12) && isDefined(var_9.origin)) {
        var_20 = 0;

        if(isDefined(var_9.claimer) && var_9.claimer != self) {
          var_21 = vectornormalize(var_4 - var_9.claimer.origin) * self.radius * 2;
          var_20 = distancesquared(var_9.claimer.origin + var_21, var_4);
        }

        if(!isalive(var_9.claimer) || !isDefined(var_9.claimer.curmeleetarget) || var_9.claimer.curmeleetarget != var_0 || var_9.claimer == self || var_6 < var_20) {
          if(isalive(var_9.claimer) && var_9.claimer != self) {
            var_9.claimer notify("lostSectorClaim");
            var_9.claimer.sector_claimed = undefined;
          }

          if(isDefined(self.sector_claimed) && self.sector_claimed != var_9) {
            self.sector_claimed.claimer = undefined;
          }

          self.sector_claimed = var_9;
          var_9.claimer = self;
          var_12 = var_9.origin;
          thread monitorsectorclaim(var_9);
        }
      }

      if(var_17 == 0) {
        break;
      }
    }
  }

  return var_12;
}

monitorsectorclaim(var_0) {
  level endon("game_ended");
  self notify("monitorSectorClaim");
  self endon("monitorSectorClaim");
  self endon("lostSectorClaim");
  common_scripts\utility::waittill_any("death", "disconnect");
  var_0.claimer = undefined;
}

trycalculatesectororigin(var_0, var_1, var_2, var_3) {
  if(gettime() - var_0.timestamp >= 50) {
    var_0.origin = meleesectortargetposition(var_1, var_0.num, var_2);
    var_0.origin = dropsectorpostoground(var_0.origin, var_3, 55);
    var_0.timestamp = gettime();
  }
}

dropsectorpostoground(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 18;
  }

  var_4 = var_0 + (0, 0, var_3);
  var_5 = var_0 + (0, 0, var_3 * -1);
  var_6 = self aiphysicstrace(var_4, var_5, var_1, var_2, 1);

  if(abs(var_6[2] - var_4[2]) < 0.1) {
    return undefined;
  }

  if(abs(var_6[2] - var_5[2]) < 0.1) {
    return undefined;
  }

  return var_6;
}

iscrawling() {
  return isDefined(self.dismember_crawl) && self.dismember_crawl;
}

getmeleeradius() {
  if(!isDefined(self.lungemeleeenabled) || self.lungemeleeenabled) {
    return self.meleeradius;
  } else {
    return self.meleeradiusbase;
  }
}

getmeleeradiussq() {
  if(!isDefined(self.lungemeleeenabled) || self.lungemeleeenabled) {
    return self.meleeradiussq;
  } else {
    return self.meleeradiusbasesq;
  }
}

lungemeleeupdate(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self.lungedebouncems = var_0 * 1000.0;
  self.lungefx = var_4;
  self.lungeanimstate = var_3;
  self.lungeanimratescale = isDefined(var_5) && var_5;
  self.lungelerprange = var_6;
  self.lungeminrange = var_2;
  self.lungeminrangesq = squared(self.lungeminrange);
  maps\mp\zombies\_util::setmeleeradius(var_1);
}

lungemeleeenable() {
  if(isDefined(self.disabledlungerefcount) && self.disabledlungerefcount > 0) {
    self.disabledlungerefcount--;

    if(self.disabledlungerefcount > 0) {
      return;
    }
  }

  self.lungemeleeenabled = 1;
}

lungemeleedisable() {
  if(!isDefined(self.disabledlungerefcount)) {
    self.disabledlungerefcount = 0;
  }

  self.disabledlungerefcount++;
  self.lungemeleeenabled = 0;
}

dodgeupdate(var_0, var_1, var_2, var_3) {
  self.dodgedebouncems = var_0 * 1000.0;
  self.dodgechance = var_1;
  self.dodgeanimstate = var_2;
  self.dodge_dirs = ["back", "right", "left"];
  self.dodge_fx = [];

  foreach(var_6, var_5 in self.dodge_dirs) {
    self.dodge_fx[var_6] = level._effect[var_3 + var_5];
  }
}

dodgeenable() {
  if(isDefined(self.disableddodgerefcount) && self.disableddodgerefcount > 0) {
    self.disableddodgerefcount--;

    if(self.disableddodgerefcount > 0) {
      return;
    }
  }

  self.dodgeenabled = 1;
}

dodgedisable() {
  if(!isDefined(self.disableddodgerefcount)) {
    self.disableddodgerefcount = 0;
  }

  self.disableddodgerefcount++;
  self.dodgeenabled = 0;
}

leapupdate(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self.leapdebouncems = var_0 * 1000.0;
  self.leapchecktimems = var_1 * 1000.0;
  self.leapchance = var_2;
  self.leapmaxrange = var_3;
  self.leapmaxrangesq = squared(self.leapmaxrange);
  self.leapminrange = var_4;
  self.leapminrangesq = squared(self.leapminrange);
  self.leapfx = var_6;
  self.leapanimstate = var_5;
  self.leaplastcheck = 0;
  self.leaplastperform = 0;
}

leapenable() {
  if(isDefined(self.disabledleaprefcount) && self.disabledleaprefcount > 0) {
    self.disabledleaprefcount--;

    if(self.disabledleaprefcount > 0) {
      return;
    }
  }

  self.leapenabled = 1;
}

leapdisable() {
  if(!isDefined(self.disabledleaprefcount)) {
    self.disabledleaprefcount = 0;
  }

  self.disabledleaprefcount++;
  self.leapenabled = 0;
}

changeanimclass(var_0, var_1) {
  self endon("death");
  self scragentsetscripted(1);
  maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1, "ChangeAnimClass");
  self.inpain = 1;
  self scragentsetorientmode("face angle abs", (0, self.angles[1], 0));
  self scragentsetanimmode("anim deltas");
  self scragentsetanimscale(1, 1);
  maps\mp\agents\_scripted_agent_anim_util::playanimnuntilnotetrack_safe(var_1, randomint(self getanimentrycount(var_1)), "change_anim_class");
  self setanimclass(var_0);
  maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0, "ChangeAnimClass");
  self.inpain = 0;
  self scragentsetscripted(0);
}

scriptedanimation(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  var_6 = self getanimentrycount(var_2);
  var_3 = isDefined(var_3) && var_3;

  if(isDefined(var_6) && var_6 > 0) {
    self scragentsetscripted(1);
    maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1, "ScriptedAnimation");

    if(var_3) {
      self.inspawnanim = 1;
    }

    self scragentsetanimmode("anim deltas");
    self scragentsetorientmode("face angle abs", var_1);
    self scragentsetanimscale(1, 1);
    self scragentsetphysicsmode("noclip");
    var_6 = self getanimentrycount(var_2);
    var_7 = randomint(var_6);

    if(!var_5) {
      lerptoendonground(var_2, var_7);
    }

    self.origin = var_0;
    self.angles = var_1;
    maps\mp\agents\_scripted_agent_anim_util::playanimnuntilnotetrack_safe(var_2, var_7, "scripted_anim", "end", var_4);
    maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0, "ScriptedAnimation");

    if(var_3) {
      self.inspawnanim = undefined;
      self.hastraversed = 1;
    }

    self scragentsetscripted(0);
  }
}

lerptoendonground(var_0, var_1) {
  var_2 = 2;
  var_3 = self getanimentry(var_0, var_1);
  var_4 = getlerptime(var_3);
  var_5 = getposinspaceatanimtime(var_3, var_4);
  var_6 = getverticaldeltatogroundatanimend(var_3);
  var_5 = var_5 + (0, 0, var_6 + var_2);
  thread performlerp(var_5, var_4);
}

getverticaldeltatogroundatanimend(var_0) {
  var_1 = 50;
  var_2 = 32;
  var_3 = 72;
  var_4 = getmovedelta(var_0);
  var_4 = rotatevector(var_4, self.angles);
  var_5 = self.origin + var_4;
  var_6 = (0, 0, var_1);
  var_7 = self aiphysicstrace(var_5 + var_6, var_5 - var_6, var_2, var_3);
  var_8 = var_7 - var_5;
  return var_8[2];
}

getposinspaceatanimtime(var_0, var_1) {
  var_2 = getanimlength(var_0);
  var_3 = var_1 / var_2;
  var_4 = getmovedelta(var_0, 0, var_3);
  var_5 = rotatevector(var_4, self.angles);
  return self.origin + var_5;
}

getlerptime(var_0) {
  var_1 = 0.2;
  var_2 = getanimlength(var_0);
  return min(var_1, var_2);
}

performlerp(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  self scragentdoanimlerp(self.origin, var_0, var_1);
  wait(var_1);
  self scragentsetanimmode("anim deltas");
}

getpainangleindexvariable(var_0, var_1) {
  var_2 = 0;

  if(var_1 > 1) {
    var_3 = int(var_1 * 0.5);
    var_4 = var_3 + var_1 % 2;

    if(var_0 < 0) {
      var_2 = randomint(var_4);
    } else {
      var_2 = var_3 + randomint(var_4);
    }
  }

  return var_2;
}

isentstandingonme(var_0) {
  var_1 = self.origin[2] + self.height;

  if(var_0.origin[2] < var_1) {
    return 0;
  }

  var_2 = self.origin[2] + self.height + 2 * self.radius;

  if(var_0.origin[2] > var_2) {
    return 0;
  }

  if(isPlayer(var_0)) {
    var_3 = var_0 getvelocity()[2];

    if(abs(var_3) > 12) {
      return 0;
    }
  }

  var_4 = 15.0;

  if(isDefined(var_0.radius)) {
    var_4 = var_0.radius;
  }

  var_5 = self.radius + var_4;
  var_5 = var_5 * var_5;

  if(distance2dsquared(self.origin, var_0.origin) > var_5) {
    return 0;
  }

  return 1;
}

setfavoriteenemy(var_0) {
  self.favoriteenemy = var_0;
  self agentsetfavoriteenemy(var_0);
}

damagehitangle(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0)) {
    var_3 = var_0 - self gettagorigin("J_SpineLower");
    var_3 = (var_3[0], var_3[1], 0);
    var_4 = vectortoangles(vectornormalize(var_3));
    var_2 = var_4[1];
  } else if(isDefined(var_1)) {
    var_4 = vectortoangles(var_1);
    var_2 = var_4[1] - 180;
  }

  return var_2;
}

enable_humanoid_exo_abilities() {
  if(isDefined(self.disabledhumanoidexoabilities) && self.disabledhumanoidexoabilities > 0) {
    self.disabledhumanoidexoabilities--;

    if(self.disabledhumanoidexoabilities > 0) {
      return;
    }
  }

  self.hashumanoidexoabilities = 1;
  enable_humanoid_exo_traverse();
  setup_humanoid_exo_combat();
  enable_humanoid_exo_combat();
}

disable_humanoid_exo_abilities() {
  if(!isDefined(self.disabledhumanoidexoabilities)) {
    self.disabledhumanoidexoabilities = 0;
  }

  self.disabledhumanoidexoabilities++;
  disable_humanoid_exo_combat();
  disable_humanoid_exo_traverse();
}

has_humanoid_exo_abilities() {
  return maps\mp\zombies\_util::is_true(self.hashumanoidexoabilities);
}

enable_humanoid_exo_traverse() {
  self scragentallowboost(1);
}

disable_humanoid_exo_traverse() {
  self scragentallowboost(0);
}

setup_humanoid_exo_combat() {
  var_0 = clamp(level.wavecounter / 20, 0.0, 1.0);
  var_1 = maps\mp\zombies\_util::lerp(var_0, 0.35, 0.55);
  var_2 = maps\mp\zombies\_util::lerp(var_0, 0.06, 0.12);
  lungemeleeupdate(5.0, self.meleeradiusbase * 2, self.meleeradiusbase * 1.5, "attack_lunge_boost", level._effect["boost_lunge"]);
  dodgeupdate(5.0, var_1, "dodge_boost", "boost_dodge_");
  leapupdate(10.0, 2.0, var_2, 550, 350, "leap_boost", level._effect["boost_jump"]);
}

enable_humanoid_exo_combat() {
  lungemeleeenable();
  dodgeenable();
  leapenable();
}

disable_humanoid_exo_combat() {
  lungemeleedisable();
  dodgedisable();
  leapdisable();
}

play_boost_fx(var_0) {
  if(!isDefined(self.boostfxtag)) {
    return;
  }
  if(self.boostfxtag != "no_boost_fx") {
    playFXOnTag(var_0, self, self.boostfxtag);
  }
}

find_valid_pathnodes_for_random_pathing(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(maps\mp\zombies\_util::isplayerinlaststand(var_3)) {
      var_1[var_1.size] = var_3;
    }
  }

  var_5 = [];

  foreach(var_7 in var_0) {
    if(maps\mp\zombies\_util::nodeisinspawncloset(var_7)) {
      continue;
    }
    var_8 = 0;

    foreach(var_3 in var_1) {
      if(distancesquared(var_7.origin, var_3.origin) < 65536) {
        var_8 = 1;
        break;
      }
    }

    if(var_8) {
      continue;
    }
    var_5[var_5.size] = var_7;
  }

  return var_5;
}

withinmeleeradius() {
  if(getmeleeradius() == self.meleeradiusbase) {
    return withinmeleeradiusbase();
  }

  var_0 = distancesquared(self.origin, self.curmeleetarget.origin) <= getmeleeradiussq();
  return var_0;
}

withinmeleeradiusbase() {
  var_0 = distancesquared(self.origin, self.curmeleetarget.origin) <= self.meleeradiusbasesq;

  if(!var_0 && (isPlayer(self.curmeleetarget) || isagent(self.curmeleetarget)) && isalive(self.curmeleetarget)) {
    var_1 = self.curmeleetarget getgroundentity();

    if(isDefined(var_1) && isDefined(var_1.targetname) && var_1.targetname == "care_package") {
      var_0 = distancesquared(self.origin, self.curmeleetarget.origin) <= self.meleeradiusbasesq * 4;
    }
  }

  if(!var_0 && isPlayer(self.curmeleetarget) && maps\mp\zombies\_util::is_true(self.curmeleetarget.isinexploitspot)) {
    if(length(self getvelocity()) < 5) {
      var_0 = distancesquared(self.origin, self.curmeleetarget.origin) <= self.meleeradiusbasesq * 4;
    }
  }

  return var_0;
}