/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\stinger.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\utility;
#namespace stinger;

function init() {
  if(isDefined(level.player.stinger)) {
    return;
  }

  level.player clearirtarget();
  level.player thread stingerfirednotify();
  level.player thread stringemissilefired();
  level.player thread stingertoggleloop();
  level.player thread stingerdeathcleanup();
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
  assert(self.classname == "player");

  while(true) {
    self waittill("weapon_fired");

    if(!weaponhaslockon()) {
      continue;
    }

    self.stinger.lastfiredtime = gettime();
    self notify("stinger_fired");
  }
}

function stringemissilefired() {
  assert(self.classname == "player");

  while(true) {
    self waittill("missile_fire", missile);

    if(isDefined(missile)) {
      self.stinger.missile = missile;
      target = self.stinger.stingertarget;

      if(isstillvalidtarget(target)) {
        offset = getdesiredoffset(target);
        missile missile_settargetEnt(self.stinger.stingertarget, offset);
      }
    }
  }
}

function getdesiredoffset(target) {
  if(isDefined(target.vehicletype) && target scripts\common\vehicle::ishelicopter()) {
    return (0, 0, -100);
  } else if(is_equal(target.unittype, "soldier") || is_equal(target.unittype, "juggernaut") || is_equal(target.unittype, "suicidebomber")) {
    return (0, 0, 38);
  }

  return (0, 0, 0);
}

function stingertoggleloop() {
  assert(self.classname == "player");
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

    foreach(target in self.stinger.lockontargets) {
      cleartarget(target);
    }

    self.stinger.lockontargets = undefined;
    self.stinger.targetids = undefined;
  }
}

function stingerdeathcleanup() {
  self waittill("death");

  if(isDefined(self.stinger.lockontargets)) {
    foreach(target in self.stinger.lockontargets) {
      cleartarget(target);
    }
  }
}

function stingerirtloop() {
  assert(self.classname == "player");
  self endon("death");
  self endon("stinger_IRT_off");

  for(;;) {
    wait 0.05;

    if(self.stinger.stingerlockfinalized) {
      if(!isstillvalidtarget(self.stinger.stingertarget)) {
        clearirtarget();
        continue;
      }

      target = gettarget(self.stinger.stingertarget);
      thread looplocallocksound("clu_lock", 0.75);
      settargettooclose(self.stinger.stingertarget);
      continue;
    }

    if(self.stinger.stingerlockstarted) {
      if(!isstillvalidtarget(self.stinger.stingertarget)) {
        clearirtarget();
        continue;
      }

      target = gettarget(self.stinger.stingertarget);
      timepassed = gettime() - self.stinger.stingerlockstarttime;

      if(isDefined(self.stinger.lockonoverrideduration)) {
        maxtime = self.stinger.lockonoverrideduration;
      } else {
        maxtime = ter_op(self.stinger.stingertarget scripts\common\vehicle::isvehicle(), 1300, 500);
      }

      if(timepassed < maxtime) {
        continue;
      }

      assert(isDefined(self.stinger.stingertarget));
      self notify("stop_lockon_sound");
      self notify("stinger_locked_on");
      self.stinger.stingerlockfinalized = 1;
      self weaponlockfinalize(self.stinger.stingertarget);
      settargettooclose(self.stinger.stingertarget);
      continue;
    }

    besttarget = getbeststingertarget();

    if(!isDefined(besttarget)) {
      continue;
    }

    if(isDefined(self.stinger.lockontargetmarkergroup)) {
      targetmarkergroupsetentitystate(self.stinger.lockontargetmarkergroup, besttarget.ent, 1);
    }

    self.stinger.stingertarget = besttarget.ent;
    self.stinger.stingerlockstarttime = gettime();
    self.stinger.stingerlockstarted = 1;
    self notify("stinger_lock_begin");
    thread looplocalseeksound("clu_aquiring_lock", 0.6);
  }
}

function stinger_get_closest_to_player_view(array, player, use_eye, min_dot) {
  if(!array.size) {
    return;
  }

  if(!isDefined(player)) {
    player = level.player;
  }

  if(!isDefined(min_dot)) {
    min_dot = -1;
  }

  player_origin = player.origin;

  if(isDefined(use_eye) && use_eye) {
    player_origin = player getEye();
  }

  ent = undefined;
  player_angles = player getplayerangles();
  player_forward = anglesToForward(player_angles);
  dot = -1;

  foreach(array_item in array) {
    angles = vectortoangles(array_item.origin - player_origin);
    forward = anglesToForward(angles);
    newdot = vectordot(player_forward, forward);
    dist = distancesquared(player_origin, array_item.origin);
    dist_score = 1 - math::normalize_value(squared(250), squared(5000), dist);
    newdot *= dist_score;

    if(newdot < dot) {
      continue;
    }

    if(newdot < min_dot) {
      continue;
    }

    dot = newdot;
    ent = array_item;
  }

  return ent;
}

function getbeststingertarget() {
  allents = getcurrentents();
  lockontargets = self.stinger.lockontargets;

  if(isDefined(self.stinger.stingertarget)) {
    allents = array_remove(allents, self.stinger.stingertarget);
    lockontargets = array_remove(lockontargets, gettarget(self.stinger.stingertarget));
  }

  var_f06c1dfac83f0753 = [];

  for(idx = 0; idx < allents.size; idx++) {
    ent = allents[idx];

    if(haslos(ent)) {
      var_f06c1dfac83f0753[var_f06c1dfac83f0753.size] = ent;
      continue;
    }

    target = gettarget(ent);

    if(isDefined(target)) {
      cleartarget(target);
    }
  }

  if(var_f06c1dfac83f0753.size == 0) {
    return undefined;
  }

  var_a7c5ffe4437069c2 = [];
  maxtargets = 4;

  if(isDefined(self.stinger.stingertarget)) {
    maxtargets--;
  }

  for(i = 0; i < maxtargets; i++) {
    ent = stinger_get_closest_to_player_view(var_f06c1dfac83f0753, level.player, 1);
    var_a7c5ffe4437069c2[i] = ent;
    var_f06c1dfac83f0753 = array_remove(var_f06c1dfac83f0753, ent);

    if(var_f06c1dfac83f0753.size == 0) {
      break;
    }
  }

  var_980b846a443b1f2b = var_a7c5ffe4437069c2;

  foreach(target in lockontargets) {
    if(!array_contains(var_980b846a443b1f2b, target.ent)) {
      cleartarget(target);
      continue;
    }

    var_980b846a443b1f2b = array_remove(var_980b846a443b1f2b, target.ent);
  }

  foreach(ent in var_980b846a443b1f2b) {
    addtarget(ent);
  }

  foreach(chosenent in var_a7c5ffe4437069c2) {
    if(insidestingerreticlenolock(chosenent)) {
      return gettarget(chosenent);
    }
  }

  return undefined;
}

function getcurrentents() {
  ents = getaiarray("axis");
  vehicles = vehicle_getarray();

  foreach(v in vehicles) {
    if(is_equal(v.script_team, "axis")) {
      ents[ents.size] = v;
    }
  }

  return ents;
}

function gettarget(ent) {
  foreach(target in self.stinger.lockontargets) {
    if(target.ent == ent) {
      return target;
    }
  }

  return undefined;
}

function addtarget(ent) {
  assert(self.stinger.targetids.size > 0, "Lockon: no ids left to distribute!");
  target = spawnStruct();
  target.ent = ent;
  target.id = self.stinger.targetids[0];

  if(!isDefined(self.stinger.lockontargetmarkergroup)) {
    self.stinger.lockontargetmarkergroup = createtargetmarkergroup("lockontarget");
    addclienttotargetmarkergroupmask(self.stinger.lockontargetmarkergroup, level.player);
  }

  targetmarkergroupaddentity(self.stinger.lockontargetmarkergroup, target.ent);
  self.stinger.targetids = array_remove(self.stinger.targetids, target.id);
  self.stinger.lockontargets[self.stinger.lockontargets.size] = target;
}

function cleartarget(target) {
  if(isDefined(self.stinger.lockontargetmarkergroup)) {
    targetmarkergroupremoveentity(self.stinger.lockontargetmarkergroup, target.ent);
  }

  self.stinger.lockontargets = array_remove(self.stinger.lockontargets, target);
  self.stinger.targetids[self.stinger.targetids.size] = target.id;

  if(self.stinger.lockontargets.size == 0 && isDefined(self.stinger.lockontargetmarkergroup)) {
    deletetargetmarkergroup(self.stinger.lockontargetmarkergroup);
    self.stinger.lockontargetmarkergroup = undefined;
  }
}

function insidestingerreticlenolock(ent) {
  return level.player worldpointinreticle_circle(getenthitpos(ent), 65, 105);
}

function insidestingerreticlelocked(ent) {
  return level.player worldpointinreticle_circle(getenthitpos(ent), 65, 105);
}

function insidestingerreticlelockoverride(ent) {
  return level.player worldpointinreticle_circle(getenthitpos(ent), 65, 105);
}

function haslos(ent) {
  eyepos = self getEye();
  ignoreents = [self, ent];
  endpos = getenthitpos(ent);
  contents = scripts\engine\trace::create_contents(1, 1, 0, 1, 0, 1, 0, 1);
  traceresult = ray_trace(eyepos, endpos, ignoreents, contents);
  return distancesquared(traceresult["position"], endpos) <= 1;
}

function getenthitpos(ent) {
  pos = ent.origin;
  offset = 38;
  pos += offset * anglestoup(ent.angles);
  return pos;
}

function isstillvalidtarget(ent) {
  assert(self.classname == "player");

  if(!isDefined(ent)) {
    return false;
  }

  if(!isalive(ent)) {
    return false;
  }

  if(!insidestingerreticlelocked(ent)) {
    return false;
  }

  if(!haslos(ent)) {
    return false;
  }

  if(insidestingerreticlelockoverride(self.stinger.stingertarget) || self.stinger.stingerlockstarted && !self.stinger.stingerlockfinalized) {
    return true;
  }

  besttarget = getbeststingertarget();

  if(isDefined(besttarget) && insidestingerreticlelockoverride(besttarget.ent)) {
    return false;
  }

  return true;
}

function playerstingerads() {
  assert(self.classname == "player");

  if(!weaponhaslockon()) {
    return false;
  }

  if(self playerads() == 1) {
    return true;
  }

  return false;
}

function weaponhaslockon() {
  currentweapon = self getcurrentweapon();

  if(currentweapon hasattachment("lalphascope")) {
    return true;
  }

  if(currentweapon hasattachment("lnchrscope_lalpha")) {
    return true;
  }

  return false;
}

function settargettooclose(ent) {
  assert(self.classname == "player");
  minimum_sti_distance = 250;

  if(!isDefined(ent)) {
    return 0;
  }

  dist = distance2d(self.origin, ent.origin);

  if(dist < minimum_sti_distance) {
    self.stinger.targettoclose = 1;
    self weaponlocktargettooclose(1);
    return;
  }

  self.stinger.targettoclose = 0;
  self weaponlocktargettooclose(0);
}

function looplocalseeksound(alias, interval) {
  assert(self.classname == "player");
  self endon("stop_lockon_sound");
  self endon("death");

  for(;;) {
    self playlocalsound(alias);
    wait interval;
  }
}

function looplocallocksound(alias, interval) {
  assert(self.classname == "player");
  self endon("stop_locked_sound");
  self endon("death");

  if(isDefined(self.stinger.stingerlocksound)) {
    return;
  }

  self.stinger.stingerlocksound = 1;

  for(;;) {
    self playlocalsound(alias);
    self playRumbleOnEntity("slide_start");
    wait interval / 3;
    self playRumbleOnEntity("slide_start");
    wait interval / 3;
    self playRumbleOnEntity("slide_start");
    wait interval / 3;
    self stoprumble("slide_start");
  }

  self.stinger.stingerlocksound = undefined;
}