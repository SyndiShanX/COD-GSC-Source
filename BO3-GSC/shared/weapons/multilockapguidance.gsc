/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\multilockapguidance.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace multilockap_guidance;

function autoexec __init__sytem__() {
  system::register("multilockap_guidance", &__init__, undefined, undefined);
}

function __init__() {
  callback::on_spawned(&on_player_spawned);
  setdvar("scr_max_simLocks", 3);
}

function on_player_spawned() {
  self endon("disconnect");
  self clearaptarget();
  thread aptoggleloop();
  self thread apfirednotify();
}

function clearaptarget(weapon, whom) {
  if(!isDefined(self.multilocklist)) {
    self.multilocklist = [];
  }
  if(isDefined(whom)) {
    for(i = 0; i < self.multilocklist.size; i++) {
      if(whom.aptarget == self.multilocklist[i].aptarget) {
        if(isDefined(self.multilocklist[i].aptarget)) {
          self.multilocklist[i].aptarget notify("missile_unlocked");
        }
        self notify("stop_sound" + whom.apsoundid);
        self weaponlockremoveslot(i);
        arrayremovevalue(self.multilocklist, whom, 0);
        break;
      }
    }
  } else {
    for(i = 0; i < self.multilocklist.size; i++) {
      self.multilocklist[i].aptarget notify("missile_unlocked");
      self notify("stop_sound" + self.multilocklist[i].apsoundid);
    }
    self.multilocklist = [];
  }
  if(self.multilocklist.size == 0) {
    self stoprumble("stinger_lock_rumble");
    self weaponlockremoveslot(-1);
    if(isDefined(weapon)) {
      if(isDefined(weapon.lockonseekersearchsound)) {
        self stoplocalsound(weapon.lockonseekersearchsound);
      }
      if(isDefined(weapon.lockonseekerlockedsound)) {
        self stoplocalsound(weapon.lockonseekerlockedsound);
      }
    }
    self destroylockoncanceledmessage();
  }
}

function apfirednotify() {
  self endon("disconnect");
  self endon("death");
  while(true) {
    self waittill("missile_fire", missile, weapon);
    if(weapon.lockontype == "AP Multi") {
      foreach(target in self.multilocklist) {
        if(isDefined(target.aptarget) && target.aplockfinalized) {
          target.aptarget notify("stinger_fired_at_me", missile, weapon, self);
        }
      }
    }
  }
}

function aptoggleloop() {
  self endon("disconnect");
  self endon("death");
  for(;;) {
    self waittill("weapon_change", weapon);
    while(weapon.lockontype == "AP Multi") {
      abort = 0;
      while(!self playerads() == 1) {
        wait(0.05);
        currentweapon = self getcurrentweapon();
        if(currentweapon.lockontype != "AP Multi") {
          abort = 1;
          break;
        }
      }
      if(abort) {
        break;
      }
      self thread aplockloop(weapon);
      while(self playerads() == 1) {
        wait(0.05);
      }
      self notify("ap_off");
      self clearaptarget(weapon);
      weapon = self getcurrentweapon();
    }
  }
}

function aplockloop(weapon) {
  self endon("disconnect");
  self endon("death");
  self endon("ap_off");
  locklength = self getlockonspeed();
  self.multilocklist = [];
  for(;;) {
    wait(0.05);
    do {
      done = 1;
      foreach(target in self.multilocklist) {
        if(target.aplockfinalized) {
          if(!isstillvalidtarget(weapon, target.aptarget)) {
            self clearaptarget(weapon, target);
            done = 0;
            break;
          }
        }
      }
    }
    while(!done);
    inlockingstate = 0;
    do {
      done = 1;
      for(i = 0; i < self.multilocklist.size; i++) {
        target = self.multilocklist[i];
        if(target.aplocking) {
          if(!isstillvalidtarget(weapon, target.aptarget)) {
            self clearaptarget(weapon, target);
            done = 0;
            break;
          }
          inlockingstate = 1;
          timepassed = gettime() - target.aplockstarttime;
          if(timepassed < locklength) {
            continue;
          }
          assert(isDefined(target.aptarget));
          target.aplockfinalized = 1;
          target.aplocking = 0;
          target.aplockpending = 0;
          self weaponlockfinalize(target.aptarget, i);
          self thread seekersound(weapon.lockonseekerlockedsound, weapon.lockonseekerlockedsoundloops, target.apsoundid);
          target.aptarget notify("missile_lock", self, weapon);
        }
      }
    }
    while(!done);
    if(!inlockingstate) {
      do {
        done = 1;
        for(i = 0; i < self.multilocklist.size; i++) {
          target = self.multilocklist[i];
          if(target.aplockpending) {
            if(!isstillvalidtarget(weapon, target.aptarget)) {
              self clearaptarget(weapon, target);
              done = 0;
              break;
            }
            target.aplockstarttime = gettime();
            target.aplockfinalized = 0;
            target.aplockpending = 0;
            target.aplocking = 1;
            self thread seekersound(weapon.lockonseekersearchsound, weapon.lockonseekersearchsoundloops, target.apsoundid);
            done = 1;
            break;
          }
        }
      }
      while(!done);
    }
    if(self.multilocklist.size >= getdvarint("scr_max_simLocks") || self.multilocklist.size >= self getweaponammoclip(weapon)) {
      continue;
    }
    besttarget = self getbesttarget(weapon);
    if(!isDefined(besttarget) && self.multilocklist.size == 0) {
      self destroylockoncanceledmessage();
      continue;
    }
    if(isDefined(besttarget) && self.multilocklist.size < getdvarint("scr_max_simLocks") && self.multilocklist.size < self getweaponammoclip(weapon)) {
      self weaponlockstart(besttarget.aptarget, self.multilocklist.size);
      self.multilocklist[self.multilocklist.size] = besttarget;
    }
  }
}

function destroylockoncanceledmessage() {
  if(isDefined(self.lockoncanceledmessage)) {
    self.lockoncanceledmessage destroy();
  }
}

function displaylockoncanceledmessage() {
  if(isDefined(self.lockoncanceledmessage)) {
    return;
  }
  self.lockoncanceledmessage = newclienthudelem(self);
  self.lockoncanceledmessage.fontscale = 1.25;
  self.lockoncanceledmessage.x = 0;
  self.lockoncanceledmessage.y = 50;
  self.lockoncanceledmessage.alignx = "center";
  self.lockoncanceledmessage.aligny = "top";
  self.lockoncanceledmessage.horzalign = "center";
  self.lockoncanceledmessage.vertalign = "top";
  self.lockoncanceledmessage.foreground = 1;
  self.lockoncanceledmessage.hidewhendead = 0;
  self.lockoncanceledmessage.hidewheninmenu = 1;
  self.lockoncanceledmessage.archived = 0;
  self.lockoncanceledmessage.alpha = 1;
  self.lockoncanceledmessage settext(&"MP_CANNOT_LOCKON_TO_TARGET");
}

function getbesttarget(weapon) {
  playertargets = getplayers();
  vehicletargets = target_getarray();
  targetsall = getaiteamarray();
  targetsall = arraycombine(targetsall, playertargets, 0, 0);
  targetsall = arraycombine(targetsall, vehicletargets, 0, 0);
  targetsvalid = [];
  for(idx = 0; idx < targetsall.size; idx++) {
    if(level.teambased) {
      if(isDefined(targetsall[idx].team) && targetsall[idx].team != self.team) {
        if(self insideapreticlenolock(targetsall[idx])) {
          if(self locksighttest(targetsall[idx])) {
            targetsvalid[targetsvalid.size] = targetsall[idx];
          }
        }
      }
      continue;
    }
    if(self insideapreticlenolock(targetsall[idx])) {
      if(isDefined(targetsall[idx].owner) && self != targetsall[idx].owner) {
        if(self locksighttest(targetsall[idx])) {
          targetsvalid[targetsvalid.size] = targetsall[idx];
        }
      }
    }
  }
  if(targetsvalid.size == 0) {
    return undefined;
  }
  playerforward = anglesToForward(self getplayerangles());
  dots = [];
  for(i = 0; i < targetsvalid.size; i++) {
    newitem = spawnStruct();
    newitem.index = i;
    newitem.dot = vectordot(playerforward, vectornormalize(targetsvalid[i].origin - self.origin));
    array::insertion_sort(dots, &targetinsertionsortcompare, newitem);
  }
  index = 0;
  foreach(dot in dots) {
    found = 0;
    foreach(lock in self.multilocklist) {
      if(lock.aptarget == targetsvalid[dot.index]) {
        found = 1;
      }
    }
    if(found) {
      continue;
    }
    newentry = spawnStruct();
    newentry.aptarget = targetsvalid[dot.index];
    newentry.aplockstarttime = gettime();
    newentry.aplockpending = 1;
    newentry.aplocking = 0;
    newentry.aplockfinalized = 0;
    newentry.aplostsightlinetime = 0;
    newentry.apsoundid = randomint(2147483647);
    return newentry;
  }
  return undefined;
}

function targetinsertionsortcompare(a, b) {
  if(a.dot < b.dot) {
    return -1;
  }
  if(a.dot > b.dot) {
    return 1;
  }
  return 0;
}

function insideapreticlenolock(target) {
  radius = self getlockonradius();
  return target_isincircle(target, self, 65, radius);
}

function insideapreticlelocked(target) {
  radius = self getlockonlossradius();
  return target_isincircle(target, self, 65, radius);
}

function isstillvalidtarget(weapon, ent) {
  if(!isDefined(ent)) {
    return false;
  }
  if(!insideapreticlelocked(ent)) {
    return false;
  }
  if(!isalive(ent)) {
    return false;
  }
  if(!locksighttest(ent)) {
    return false;
  }
  return true;
}

function seekersound(alias, looping, id) {
  self notify("stop_sound" + id);
  self endon("stop_sound" + id);
  self endon("disconnect");
  self endon("death");
  if(isDefined(alias)) {
    self playrumbleonentity("stinger_lock_rumble");
    time = soundgetplaybacktime(alias) * 0.001;
    do {
      self playlocalsound(alias);
      wait(time);
    }
    while(looping);
    self stoprumble("stinger_lock_rumble");
  }
}

function locksighttest(target) {
  eyepos = self getEye();
  if(!isDefined(target)) {
    return false;
  }
  if(!isalive(target)) {
    return false;
  }
  pos = target getshootatpos();
  if(isDefined(pos)) {
    passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);
    if(passed) {
      return true;
    }
  }
  pos = target getcentroid();
  if(isDefined(pos)) {
    passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);
    if(passed) {
      return true;
    }
  }
  pos = target.origin;
  passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);
  if(passed) {
    return true;
  }
  return false;
}