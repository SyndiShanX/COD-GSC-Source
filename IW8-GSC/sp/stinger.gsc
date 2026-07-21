/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\stinger.gsc
***********************************************/

init() {
  if(isDefined(level.player.stinger)) {
    return;
  }
  level.player clearirtarget();
  level.player thread stingerfirednotify();
  level.player thread stringemissilefired();
  level.player thread stingertoggleloop();
  level.player thread stingerdeathcleanup();
}

clearirtarget() {
  if(!isDefined(self.stinger))
    self.stinger = spawnStruct();

  self.stinger.stingerlockstarttime = 0;
  self.stinger.stingerlockstarted = 0;
  self.stinger.stingerlockfinalized = 0;

  if(isDefined(self.stinger.stingertarget))
    cleartarget(gettarget(self.stinger.stingertarget));

  self.stinger.stingertarget = undefined;
  self notify("stinger_irt_cleartarget");
  self notify("stop_lockon_sound");
  self notify("stop_locked_sound");
  self.stinger.stingerlocksound = undefined;
  self weaponlockfree();
  self weaponlocktargettooclose(0);
  self weaponlocknoclearance(0);
  self stoplocalsound("clu_lock");
  self stoplocalsound("clu_aquiring_lock");
}

stingerfirednotify() {
  for(;;) {
    self waittill("weapon_fired");

    if(!weaponhaslockon()) {
      continue;
    }
    self.stinger.lastfiredtime = gettime();
    self notify("stinger_fired");
  }
}

stringemissilefired() {
  for(;;) {
    self waittill("missile_fire", var_0);

    if(isDefined(var_0)) {
      self.stinger.missile = var_0;
      var_1 = self.stinger.stingertarget;

      if(isstillvalidtarget(var_1)) {
        var_2 = getdesiredoffset(var_1);
        var_0 missile_settargetEnt(self.stinger.stingertarget, var_2);
      }
    }
  }
}

getdesiredoffset(var_0) {
  if(isDefined(var_0.vehicletype) && var_0 scripts\common\vehicle::ishelicopter())
    return (0, 0, -100);
  else if(scripts\engine\utility::is_equal(var_0.unittype, "soldier") || scripts\engine\utility::is_equal(var_0.unittype, "juggernaut") || scripts\engine\utility::is_equal(var_0.unittype, "suicidebomber"))
    return (0, 0, 38);

  return (0, 0, 0);
}

stingertoggleloop() {
  self endon("death");

  for(;;) {
    while(!playerstingerads())
      wait 0.05;

    self.stinger.lockontargets = [];
    self.stinger.targetids = ["0", "1", "2", "3"];
    thread stingerirtloop();

    while(playerstingerads())
      wait 0.05;

    self notify("stinger_IRT_off");
    clearirtarget();

    foreach(var_1 in self.stinger.lockontargets)
    cleartarget(var_1);

    self.stinger.lockontargets = undefined;
    self.stinger.targetids = undefined;
  }
}

stingerdeathcleanup() {
  self waittill("death");

  if(isDefined(self.stinger.lockontargets)) {
    foreach(var_1 in self.stinger.lockontargets)
    cleartarget(var_1);
  }
}

stingerirtloop() {
  self endon("death");
  self endon("stinger_IRT_off");

  for(;;) {
    wait 0.05;

    if(self.stinger.stingerlockfinalized) {
      if(!isstillvalidtarget(self.stinger.stingertarget)) {
        clearirtarget();
        continue;
      }

      var_0 = gettarget(self.stinger.stingertarget);
      thread looplocallocksound("clu_lock", 0.75);
      settargettooclose(self.stinger.stingertarget);
      continue;
    }

    if(self.stinger.stingerlockstarted) {
      if(!isstillvalidtarget(self.stinger.stingertarget)) {
        clearirtarget();
        continue;
      }

      var_0 = gettarget(self.stinger.stingertarget);
      var_1 = gettime() - self.stinger.stingerlockstarttime;

      if(isDefined(self.stinger.lockonoverrideduration))
        var_2 = self.stinger.lockonoverrideduration;
      else
        var_2 = scripts\engine\utility::ter_op(self.stinger.stingertarget scripts\common\vehicle::isvehicle(), 1300, 500);

      if(var_1 < var_2) {
        continue;
      }
      self notify("stop_lockon_sound");
      self notify("stinger_locked_on");
      self.stinger.stingerlockfinalized = 1;
      self weaponlockfinalize(self.stinger.stingertarget);
      settargettooclose(self.stinger.stingertarget);
      continue;
    }

    var_3 = getbeststingertarget();

    if(!isDefined(var_3)) {
      continue;
    }
    if(isDefined(self.stinger.lockontargetmarkergroup))
      targetmarkergroupsetextrastate(self.stinger.lockontargetmarkergroup, var_3.ent, 1);

    self.stinger.stingertarget = var_3.ent;
    self.stinger.stingerlockstarttime = gettime();
    self.stinger.stingerlockstarted = 1;
    self notify("stinger_lock_begin");
    thread looplocalseeksound("clu_aquiring_lock", 0.6);
  }
}

stinger_get_closest_to_player_view(var_0, var_1, var_2, var_3) {
  if(!var_0.size) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = level.player;

  if(!isDefined(var_3))
    var_3 = -1;

  var_4 = var_1.origin;

  if(isDefined(var_2) && var_2)
    var_4 = var_1 getEye();

  var_5 = undefined;
  var_6 = var_1 getplayerangles();
  var_7 = anglesToForward(var_6);
  var_8 = -1;

  foreach(var_10 in var_0) {
    var_11 = vectortoangles(var_10.origin - var_4);
    var_12 = anglesToForward(var_11);
    var_13 = vectordot(var_7, var_12);
    var_14 = distancesquared(var_4, var_10.origin);
    var_15 = 1 - scripts\engine\math::normalize_value(squared(250), squared(5000), var_14);
    var_13 = var_13 * var_15;

    if(var_13 < var_8) {
      continue;
    }
    if(var_13 < var_3) {
      continue;
    }
    var_8 = var_13;
    var_5 = var_10;
  }

  return var_5;
}

getbeststingertarget() {
  var_0 = getcurrentents();
  var_1 = self.stinger.lockontargets;

  if(isDefined(self.stinger.stingertarget)) {
    var_0 = scripts\engine\utility::array_remove(var_0, self.stinger.stingertarget);
    var_1 = scripts\engine\utility::array_remove(var_1, gettarget(self.stinger.stingertarget));
  }

  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    if(haslos(var_4)) {
      var_2[var_2.size] = var_4;
      continue;
    }

    var_5 = gettarget(var_4);

    if(isDefined(var_5))
      cleartarget(var_5);
  }

  if(var_2.size == 0)
    return undefined;

  var_6 = [];
  var_7 = 4;

  if(isDefined(self.stinger.stingertarget))
    var_7--;

  for(var_8 = 0; var_8 < var_7; var_8++) {
    var_4 = stinger_get_closest_to_player_view(var_2, level.player, 1);
    var_6[var_8] = var_4;
    var_2 = scripts\engine\utility::array_remove(var_2, var_4);

    if(var_2.size == 0) {
      break;
    }
  }

  var_9 = var_6;

  foreach(var_5 in var_1) {
    if(!scripts\engine\utility::array_contains(var_9, var_5.ent)) {
      cleartarget(var_5);
      continue;
    }

    var_9 = scripts\engine\utility::array_remove(var_9, var_5.ent);
  }

  foreach(var_4 in var_9)
  addtarget(var_4);

  foreach(var_15 in var_6) {
    if(insidestingerreticlenolock(var_15))
      return gettarget(var_15);
  }

  return undefined;
}

getcurrentents() {
  var_0 = getaiarray("axis");
  var_1 = vehicle_getarray();

  foreach(var_3 in var_1) {
    if(scripts\engine\utility::is_equal(var_3.script_team, "axis"))
      var_0[var_0.size] = var_3;
  }

  return var_0;
}

gettarget(var_0) {
  foreach(var_2 in self.stinger.lockontargets) {
    if(var_2.ent == var_0)
      return var_2;
  }

  return undefined;
}

addtarget(var_0) {
  var_1 = spawnStruct();
  var_1.ent = var_0;
  var_1.id = self.stinger.targetids[0];

  if(!isDefined(self.stinger.lockontargetmarkergroup)) {
    self.stinger.lockontargetmarkergroup = deletetargetmarkergroup("lockontarget");
    addteamtotargetmarkergroupmask(self.stinger.lockontargetmarkergroup, level.player);
  }

  targetmarkergroupremoveentity(self.stinger.lockontargetmarkergroup, var_1.ent);
  self.stinger.targetids = scripts\engine\utility::array_remove(self.stinger.targetids, var_1.id);
  self.stinger.lockontargets[self.stinger.lockontargets.size] = var_1;
}

cleartarget(var_0) {
  if(isDefined(self.stinger.lockontargetmarkergroup))
    targetmarkergroupsetentitystate(self.stinger.lockontargetmarkergroup, var_0.ent);

  self.stinger.lockontargets = scripts\engine\utility::array_remove(self.stinger.lockontargets, var_0);
  self.stinger.targetids[self.stinger.targetids.size] = var_0.id;

  if(self.stinger.lockontargets.size == 0 && isDefined(self.stinger.lockontargetmarkergroup)) {
    targetmarkergroupaddentity(self.stinger.lockontargetmarkergroup);
    self.stinger.lockontargetmarkergroup = undefined;
  }
}

insidestingerreticlenolock(var_0) {
  return level.player worldpointinreticle_circle(getenthitpos(var_0), 65, 105);
}

insidestingerreticlelocked(var_0) {
  return level.player worldpointinreticle_circle(getenthitpos(var_0), 65, 105);
}

insidestingerreticlelockoverride(var_0) {
  return level.player worldpointinreticle_circle(getenthitpos(var_0), 65, 105);
}

haslos(var_0) {
  var_1 = self getEye();
  var_2 = [self, var_0];
  var_3 = getenthitpos(var_0);
  var_4 = scripts\engine\trace::create_contents(1, 1, 0, 1, 0, 1, 0, 1);
  var_5 = scripts\engine\trace::ray_trace(var_1, var_3, var_2, var_4);
  return distancesquared(var_5["position"], var_3) <= 1;
}

getenthitpos(var_0) {
  var_1 = var_0.origin;
  var_2 = 38;
  var_1 = var_1 + var_2 * anglestoup(var_0.angles);
  return var_1;
}

isstillvalidtarget(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(!isalive(var_0))
    return 0;

  if(!insidestingerreticlelocked(var_0))
    return 0;

  if(!haslos(var_0))
    return 0;

  if(insidestingerreticlelockoverride(self.stinger.stingertarget) || self.stinger.stingerlockstarted && !self.stinger.stingerlockfinalized)
    return 1;

  var_1 = getbeststingertarget();

  if(isDefined(var_1) && insidestingerreticlelockoverride(var_1.ent))
    return 0;

  return 1;
}

playerstingerads() {
  if(!weaponhaslockon())
    return 0;

  if(self playerads() == 1.0)
    return 1;

  return 0;
}

weaponhaslockon() {
  var_0 = self getcurrentweapon();

  if(var_0 hasattachment("lalphascope", 1))
    return 1;

  if(var_0 hasattachment("lnchrscope_lalpha", 1))
    return 1;

  return 0;
}

settargettooclose(var_0) {
  var_1 = 250;

  if(!isDefined(var_0))
    return 0;

  var_2 = distance2d(self.origin, var_0.origin);

  if(var_2 < var_1) {
    self.stinger.targettoclose = 1;
    self weaponlocktargettooclose(1);
  } else {
    self.stinger.targettoclose = 0;
    self weaponlocktargettooclose(0);
  }
}

looplocalseeksound(var_0, var_1) {
  self endon("stop_lockon_sound");
  self endon("death");

  for(;;) {
    self playlocalsound(var_0);
    wait(var_1);
  }
}

looplocallocksound(var_0, var_1) {
  self endon("stop_locked_sound");
  self endon("death");

  if(isDefined(self.stinger.stingerlocksound)) {
    return;
  }
  self.stinger.stingerlocksound = 1;

  for(;;) {
    self playlocalsound(var_0);
    self playRumbleOnEntity("slide_start");
    wait(var_1 / 3);
    self playRumbleOnEntity("slide_start");
    wait(var_1 / 3);
    self playRumbleOnEntity("slide_start");
    wait(var_1 / 3);
    self stoprumble("slide_start");
  }

  self.stinger.stingerlocksound = undefined;
}