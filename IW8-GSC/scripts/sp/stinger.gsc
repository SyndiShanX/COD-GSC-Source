/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\stinger.gsc
***********************************************/

function init() {
  if(isDefined(level.player.stinger)) {
    return;
  }

  clearirtarget(level.player);
  thread stingerfirednotify();
  thread stringemissilefired();
  thread stingertoggleloop();
  thread stingerdeathcleanup();
}

function clearirtarget() {
  if(!isDefined(self.stinger)) {
    self.stinger = spawnStruct();
  }

  self.stinger.stingerlockstarttime = 0;
  self.stinger.stingerlockstarted = 0;
  self.stinger.stingerlockfinalized = 0;

  if(isDefined(self.stinger.stingertarget)) {
    cleartarget(gettarget(self.stinger.stingertarget));
  }

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

function stingerfirednotify() {
  for(;;) {
    self waittill("weapon_fired");

    if(!weaponhaslockon()) {
      continue;
    }

    self.stinger.lastfiredtime = gettime();
    self notify("stinger_fired");
  }
}

function stringemissilefired() {
  for(;;) {
    self waittill("missile_fire", var0);

    if(isDefined(var0)) {
      self.stinger.missile = var0;
      var1 = self.stinger.stingertarget;

      if(isstillvalidtarget(var1)) {
        var2 = getdesiredoffset(var1);
        var0 missile_settargetEnt(self.stinger.stingertarget, var2);
      }
    }
  }
}

function getdesiredoffset(var0) {
  if(isDefined(var0.vehicletype) && var0 scripts\common\vehicle::ishelicopter()) {
    return (0, 0, -100);
  } else if(scripts\engine\utility::is_equal(var0.unittype, "soldier") || scripts\engine\utility::is_equal(var0.unittype, "juggernaut") || scripts\engine\utility::is_equal(var0.unittype, "suicidebomber")) {
    return (0, 0, 38);
  }

  return (0, 0, 0);
}

function stingertoggleloop() {
  self endon("death");

  for(;;) {
    while(!playerstingerads()) {
      wait 0.05;
    }

    self.stinger.lockontargets = [];
    self.stinger.targetids = ["0", "1", "2", "3"];
    thread stingerirtloop();

    while(playerstingerads()) {
      wait 0.05;
    }

    self notify("stinger_IRT_off");
    clearirtarget();

    foreach(var1 in self.stinger.lockontargets) {
      cleartarget(var1);
    }

    self.stinger.lockontargets = undefined;
    self.stinger.targetids = undefined;
  }
}

function stingerdeathcleanup() {
  self waittill("death");

  if(isDefined(self.stinger.lockontargets)) {
    foreach(var1 in self.stinger.lockontargets) {
      cleartarget(var1);
    }

    return;
  }
}

function stingerirtloop() {
  self endon("death");
  self endon("stinger_IRT_off");

  for(;;) {
    wait 0.05;

    if(self.stinger.stingerlockfinalized) {
      if(!isstillvalidtarget(self.stinger.stingertarget)) {
        clearirtarget();
        continue;
      }

      var0 = gettarget(self.stinger.stingertarget);
      thread looplocallocksound("clu_lock", 0.75);
      settargettooclose(self.stinger.stingertarget);
      continue;
    }

    if(self.stinger.stingerlockstarted) {
      if(!isstillvalidtarget(self.stinger.stingertarget)) {
        clearirtarget();
        continue;
      }

      var0 = gettarget(self.stinger.stingertarget);
      var1 = gettime() - self.stinger.stingerlockstarttime;

      if(isDefined(self.stinger.lockonoverrideduration)) {
        var2 = self.stinger.lockonoverrideduration;
      } else {
        var2 = scripts\engine\utility::ter_op(self.stinger.stingertarget scripts\common\vehicle::isvehicle(), 1300, 500);
      }

      if(var1 < var2) {
        continue;
      }

      self notify("stop_lockon_sound");
      self notify("stinger_locked_on");
      self.stinger.stingerlockfinalized = 1;
      self weaponlockfinalize(self.stinger.stingertarget);
      settargettooclose(self.stinger.stingertarget);
      continue;
    }

    var3 = getbeststingertarget();

    if(!isDefined(var3)) {
      continue;
    }

    if(isDefined(self.stinger.lockontargetmarkergroup)) {
      targetmarkergroupsetextrastate(self.stinger.lockontargetmarkergroup, var3.ent, 1);
    }

    self.stinger.stingertarget = var3.ent;
    self.stinger.stingerlockstarttime = gettime();
    self.stinger.stingerlockstarted = 1;
    self notify("stinger_lock_begin");
    thread looplocalseeksound("clu_aquiring_lock", 0.6);
  }
}

function stinger_get_closest_to_player_view(var0, var1, var2, var3) {
  if(!var0.size) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = level.player;
  }

  if(!isDefined(var3)) {
    var3 = -1;
  }

  var4 = var1.origin;

  if(isDefined(var2) && var2) {
    var4 = var1 getEye();
  }

  var5 = undefined;
  var6 = var1 getplayerangles();
  var7 = anglesToForward(var6);
  var8 = -1;

  foreach(var10 in var0) {
    var11 = vectortoangles(var10.origin - var4);
    var12 = anglesToForward(var11);
    var13 = vectordot(var7, var12);
    var14 = distancesquared(var4, var10.origin);
    var15 = 1 - scripts\engine\math::normalize_value(squared(250), squared(5000), var14);
    var13 *= var15;

    if(var13 < var8) {
      continue;
    }

    if(var13 < var3) {
      continue;
    }

    var8 = var13;
    var5 = var10;
  }

  return var5;
}

function getbeststingertarget() {
  var0 = getcurrentents();
  var1 = self.stinger.lockontargets;

  if(isDefined(self.stinger.stingertarget)) {
    var0 = scripts\engine\utility::array_remove(var0, self.stinger.stingertarget);
    var1 = scripts\engine\utility::array_remove(var1, gettarget(self.stinger.stingertarget));
  }

  var2 = [];

  for(var3 = 0; var3 < var0.size; var3++) {
    var4 = var0[var3];

    if(haslos(var4)) {
      var2 = var4;
      continue;
    }

    var5 = gettarget(var4);

    if(isDefined(var5)) {
      cleartarget(var5);
    }
  }

  if(var2.size == 0) {
    return undefined;
  }

  var6 = [];
  var7 = 4;

  if(isDefined(self.stinger.stingertarget)) {
    var7--;
  }

  for(var8 = 0; var8 < var7; var8++) {
    var4 = stinger_get_closest_to_player_view(var2, level.player, 1);
    var6 = var4;
    var2 = scripts\engine\utility::array_remove(var2, var4);

    if(var2.size == 0) {
      break;
    }
  }

  var9 = var6;

  foreach(var5 in var1) {
    if(!scripts\engine\utility::array_contains(var9, var5.ent)) {
      cleartarget(var5);
      continue;
    }

    var9 = scripts\engine\utility::array_remove(var9, var5.ent);
  }

  foreach(var4 in var9) {
    addtarget(var4);
  }

  foreach(var15 in var6) {
    if(insidestingerreticlenolock(var15)) {
      return gettarget(var15);
    }
  }

  return undefined;
}

function getcurrentents() {
  var0 = getaiarray("axis");
  var1 = vehicle_getarray();

  foreach(var3 in var1) {
    if(scripts\engine\utility::is_equal(var3.script_team, "axis")) {
      var0 = var3;
    }
  }

  return var0;
}

function gettarget(var0) {
  foreach(var2 in self.stinger.lockontargets) {
    if(var2.ent == var0) {
      return var2;
    }
  }

  return undefined;
}

function addtarget(var0) {
  var1 = spawnStruct();
  var1.ent = var0;
  var1.id = self.stinger.targetids[0];

  if(!isDefined(self.stinger.lockontargetmarkergroup)) {
    self.stinger.lockontargetmarkergroup = deletetargetmarkergroup("lockontarget");
    addteamtotargetmarkergroupmask(self.stinger.lockontargetmarkergroup, level.player);
  }

  targetmarkergroupremoveentity(self.stinger.lockontargetmarkergroup, var1.ent);
  self.stinger.targetids = scripts\engine\utility::array_remove(self.stinger.targetids, var1.id);
  self.stinger.lockontargets[self.stinger.lockontargets.size] = var1;
}

function cleartarget(var0) {
  if(isDefined(self.stinger.lockontargetmarkergroup)) {
    targetmarkergroupsetentitystate(self.stinger.lockontargetmarkergroup, var0.ent);
  }

  self.stinger.lockontargets = scripts\engine\utility::array_remove(self.stinger.lockontargets, var0);
  self.stinger.targetids[self.stinger.targetids.size] = var0.id;

  if(self.stinger.lockontargets.size == 0 && isDefined(self.stinger.lockontargetmarkergroup)) {
    targetmarkergroupaddentity(self.stinger.lockontargetmarkergroup);
    self.stinger.lockontargetmarkergroup = undefined;
    return;
  }
}

function insidestingerreticlenolock(var0) {
  return level.player worldpointinreticle_circle(getenthitpos(var0), 65, 105);
}

function insidestingerreticlelocked(var0) {
  return level.player worldpointinreticle_circle(getenthitpos(var0), 65, 105);
}

function insidestingerreticlelockoverride(var0) {
  return level.player worldpointinreticle_circle(getenthitpos(var0), 65, 105);
}

function haslos(var0) {
  var1 = self getEye();
  var2 = [self, var0];
  var3 = getenthitpos(var0);
  var4 = scripts\engine\trace::create_contents(1, 1, 0, 1, 0, 1, 0, 1);
  var5 = scripts\engine\trace::ray_trace(var1, var3, var2, var4);
  return distancesquared(var5["position"], var3) <= 1;
}

function getenthitpos(var0) {
  var1 = var0.origin;
  var2 = 38;
  var1 += var2 * anglestoup(var0.angles);
  return var1;
}

function isstillvalidtarget(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(!isalive(var0)) {
    return false;
  }

  if(!insidestingerreticlelocked(var0)) {
    return false;
  }

  if(!haslos(var0)) {
    return false;
  }

  if(insidestingerreticlelockoverride(self.stinger.stingertarget) || self.stinger.stingerlockstarted && !self.stinger.stingerlockfinalized) {
    return true;
  }

  var1 = getbeststingertarget();

  if(isDefined(var1) && insidestingerreticlelockoverride(var1.ent)) {
    return false;
  }

  return true;
}

function playerstingerads() {
  if(!weaponhaslockon()) {
    return false;
  }

  if(self playerads() == 1) {
    return true;
  }

  return false;
}

function weaponhaslockon() {
  var0 = self getcurrentweapon();

  if(var0 hasattachment("lalphascope", 1)) {
    return true;
  }

  if(var0 hasattachment("lnchrscope_lalpha", 1)) {
    return true;
  }

  return false;
}

function settargettooclose(var0) {
  var1 = 250;

  if(!isDefined(var0)) {
    return 0;
  }

  var2 = distance2d(self.origin, var0.origin);

  if(var2 < var1) {
    self.stinger.targettoclose = 1;
    self weaponlocktargettooclose(1);
    return;
  }

  self.stinger.targettoclose = 0;
  self weaponlocktargettooclose(0);
}

function looplocalseeksound(var0, var1) {
  self endon("stop_lockon_sound");
  self endon("death");

  for(;;) {
    self playlocalsound(var0);
    wait var1;
  }
}

function looplocallocksound(var0, var1) {
  self endon("stop_locked_sound");
  self endon("death");

  if(isDefined(self.stinger.stingerlocksound)) {
    return;
  }

  self.stinger.stingerlocksound = 1;

  for(;;) {
    self playlocalsound(var0);
    self playRumbleOnEntity("slide_start");
    wait var1 / 3;
    self playRumbleOnEntity("slide_start");
    wait var1 / 3;
    self playRumbleOnEntity("slide_start");
    wait var1 / 3;
    self stoprumble("slide_start");
  }

  self.stinger.stingerlocksound = undefined;
}