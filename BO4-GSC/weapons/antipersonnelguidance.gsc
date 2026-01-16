/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\antipersonnelguidance.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;

#namespace singlelockap_guidance;

autoexec __init__system__() {
  system::register(#"singlelockap_guidance", &__init__, undefined, undefined);
}

__init__() {
  callback::on_spawned(&on_player_spawned);
}

on_player_spawned() {
  self endon(#"disconnect");
  self clearaptarget();
  thread aptoggleloop();
}

clearaptarget(weapon, whom) {
  if(!isDefined(self.multilocklist)) {
    self.multilocklist = [];
  }

  if(isDefined(whom)) {
    for(i = 0; i < self.multilocklist.size; i++) {
      if(whom.aptarget == self.multilocklist[i].aptarget) {
        self.multilocklist[i].aptarget notify(#"missile_unlocked");
        self notify("stop_sound" + whom.apsoundid);
        self weaponlockremoveslot(i);
        arrayremovevalue(self.multilocklist, whom, 0);
        break;
      }
    }
  } else {
    for(i = 0; i < self.multilocklist.size; i++) {
      self.multilocklist[i].aptarget notify(#"missile_unlocked");
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
  }
}

event_handler[missile_fire] function_dc710809(eventstruct) {
  if(!isplayer(self)) {
    return;
  }

  missile = eventstruct.projectile;
  weapon = eventstruct.weapon;

  if(weapon.lockontype == "AP Single") {
    foreach(target in self.multilocklist) {
      if(isDefined(target.aptarget) && target.aplockfinalized) {
        target.aptarget notify(#"stinger_fired_at_me", {
          #projectile: missile, 
          #weapon: weapon, 
          #attacker: self
        });
      }
    }
  }
}

aptoggleloop() {
  self endon(#"disconnect", #"death");

  for(;;) {
    waitresult = self waittill(#"weapon_change");

    for(weapon = waitresult.weapon; weapon.lockontype == "AP Single"; weapon = self getcurrentweapon()) {
      abort = 0;

      while(!(self playerads() == 1)) {
        waitframe(1);
        currentweapon = self getcurrentweapon();

        if(currentweapon.lockontype != "AP Single") {
          abort = 1;
          break;
        }
      }

      if(abort) {
        break;
      }

      self thread aplockloop(weapon);

      while(self playerads() == 1) {
        waitframe(1);
      }

      self notify(#"ap_off");
      self clearaptarget(weapon);
    }
  }
}

aplockloop(weapon) {
  self endon(#"disconnect", #"death", #"ap_off");
  locklength = self getlockonspeed();
  self.multilocklist = [];

  for(;;) {
    waitframe(1);

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
          target.aptarget notify(#"missile_lock", {
            #attacker: self, 
            #weapon: weapon
          });
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

    if(self.multilocklist.size >= 1) {
      continue;
    }

    besttarget = self getbesttarget(weapon);

    if(!isDefined(besttarget) && self.multilocklist.size == 0) {
      continue;
    }

    if(isDefined(besttarget) && self.multilocklist.size < 1) {
      self weaponlockstart(besttarget.aptarget, self.multilocklist.size);
      self.multilocklist[self.multilocklist.size] = besttarget;
    }
  }
}

getbesttarget(weapon) {
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
    array::add_sorted(dots, newitem, 0, &targetinsertionsortcompare);
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

targetinsertionsortcompare(a, b) {
  if(a.dot < b.dot) {
    return -1;
  }

  if(a.dot > b.dot) {
    return 1;
  }

  return 0;
}

insideapreticlenolock(target) {
  radius = self getlockonradius();
  return target_isincircle(target, self, 65, radius);
}

insideapreticlelocked(target) {
  radius = self getlockonlossradius();
  return target_isincircle(target, self, 65, radius);
}

isstillvalidtarget(weapon, ent) {
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

seekersound(alias, looping, id) {
  self notify("stop_sound" + id);
  self endon("stop_sound" + id, #"disconnect", #"death");

  if(isDefined(alias)) {
    self playrumbleonentity("stinger_lock_rumble");
    time = soundgetplaybacktime(alias) * 0.001;

    do {
      self playlocalsound(alias);
      wait time;
    }
    while(looping);

    self stoprumble("stinger_lock_rumble");
  }
}

locksighttest(target) {
  eyepos = self getEye();

  if(!isDefined(target)) {
    return false;
  }

  if(!isalive(target)) {
    return false;
  }

  if(isDefined(target.var_e8ec304d) && target.var_e8ec304d) {
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