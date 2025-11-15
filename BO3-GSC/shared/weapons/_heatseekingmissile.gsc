/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\_heatseekingmissile.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\dev_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weapon_utils;
#namespace heatseekingmissile;

function init_shared() {
  game["locking_on_sound"] = "uin_alert_lockon_start";
  game["locked_on_sound"] = "uin_alert_lockon";
  callback::on_spawned( & on_player_spawned);
  level.fx_flare = "killstreaks/fx_heli_chaff";
  setdvar("", "");
}

function on_player_spawned() {
  self endon("disconnect");
  self clearirtarget();
  thread stingertoggleloop();
  self thread stingerfirednotify();
}

function clearirtarget() {
  self notify("stop_lockon_sound");
  self notify("stop_locked_sound");
  self.stingerlocksound = undefined;
  self stoprumble("stinger_lock_rumble");
  self.stingerlockstarttime = 0;
  self.stingerlockstarted = 0;
  self.stingerlockfinalized = 0;
  self.stingerlockdetected = 0;
  if(isDefined(self.stingertarget)) {
    self.stingertarget notify("missile_unlocked");
    self lockingon(self.stingertarget, 0);
    self lockedon(self.stingertarget, 0);
  }
  self.stingertarget = undefined;
  self weaponlockfree();
  self weaponlocktargettooclose(0);
  self weaponlocknoclearance(0);
  self stoplocalsound(game["locking_on_sound"]);
  self stoplocalsound(game["locked_on_sound"]);
  self destroylockoncanceledmessage();
}

function stingerfirednotify() {
  self endon("disconnect");
  self endon("death");
  while(true) {
    self waittill("missile_fire", missile, weapon);
    thread debug_missile(missile);
    if(weapon.lockontype == "Legacy Single") {
      if(isDefined(self.stingertarget) && self.stingerlockfinalized) {
        self.stingertarget notify("stinger_fired_at_me", missile, weapon, self);
      }
    }
  }
}

function debug_missile(missile) {
  level notify("debug_missile");
  level endon("debug_missile");
  level.debug_missile_dots = [];
  while(true) {
    if(getdvarint("", 0) == 0) {
      wait(0.5);
      continue;
    }
    if(isDefined(missile)) {
      missile_info = spawnStruct();
      missile_info.origin = missile.origin;
      target = missile missile_gettarget();
      missile_info.targetentnum = (isDefined(target) ? target getentitynumber() : undefined);
      if(!isDefined(level.debug_missile_dots)) {
        level.debug_missile_dots = [];
      } else if(!isarray(level.debug_missile_dots)) {
        level.debug_missile_dots = array(level.debug_missile_dots);
      }
      level.debug_missile_dots[level.debug_missile_dots.size] = missile_info;
    }
    foreach(missile_info in level.debug_missile_dots) {
      dot_color = (isDefined(missile_info.targetentnum) ? (1, 0, 0) : (0, 1, 0));
      dev::debug_sphere(missile_info.origin, 10, dot_color, 0.66, 1);
    }
    wait(0.05);
  }
}

function stingerwaitforads() {
  while(!self playerstingerads()) {
    wait(0.05);
    currentweapon = self getcurrentweapon();
    if(currentweapon.lockontype != "Legacy Single") {
      return false;
    }
  }
  return true;
}

function stingertoggleloop() {
  self endon("disconnect");
  self endon("death");
  for(;;) {
    self waittill("weapon_change", weapon);
    while(weapon.lockontype == "Legacy Single") {
      if(self getweaponammoclip(weapon) == 0) {
        wait(0.05);
        weapon = self getcurrentweapon();
        continue;
      }
      if(!stingerwaitforads()) {
        break;
      }
      self thread stingerirtloop(weapon);
      while(self playerstingerads()) {
        wait(0.05);
      }
      self notify("stinger_irt_off");
      self clearirtarget();
      weapon = self getcurrentweapon();
    }
  }
}

function stingerirtloop(weapon) {
  self endon("disconnect");
  self endon("death");
  self endon("stinger_irt_off");
  locklength = self getlockonspeed();
  for(;;) {
    wait(0.05);
    if(!self hasweapon(weapon)) {
      break;
    }
    if(self.stingerlockfinalized) {
      passed = softsighttest();
      if(!passed) {
        continue;
      }
      if(!self isstillvalidtarget(self.stingertarget, weapon) || self insidestingerreticlelocked(self.stingertarget, weapon) == 0) {
        self setweaponlockonpercent(weapon, 0);
        self clearirtarget();
        continue;
      }
      if(!self.stingertarget.locked_on) {
        self.stingertarget notify("missile_lock", self, self getcurrentweapon());
      }
      self lockingon(self.stingertarget, 0);
      self lockedon(self.stingertarget, 1);
      if(isDefined(weapon)) {
        setfriendlyflags(weapon, self.stingertarget);
      }
      thread looplocallocksound(game["locked_on_sound"], 0.75);
      continue;
    }
    if(self.stingerlockstarted) {
      if(!self isstillvalidtarget(self.stingertarget, weapon) || self insidestingerreticlelocked(self.stingertarget, weapon) == 0) {
        self setweaponlockonpercent(weapon, 0);
        self clearirtarget();
        continue;
      }
      self lockingon(self.stingertarget, 1);
      self lockedon(self.stingertarget, 0);
      if(isDefined(weapon)) {
        setfriendlyflags(weapon, self.stingertarget);
      }
      passed = softsighttest();
      if(!passed) {
        continue;
      }
      timepassed = gettime() - self.stingerlockstarttime;
      if(isDefined(weapon)) {
        self setweaponlockonpercent(weapon, (timepassed / locklength) * 100);
        setfriendlyflags(weapon, self.stingertarget);
      }
      if(timepassed < locklength) {
        continue;
      }
      assert(isDefined(self.stingertarget));
      self notify("stop_lockon_sound");
      self.stingerlockfinalized = 1;
      self weaponlockfinalize(self.stingertarget);
      continue;
    }
    besttarget = self getbeststingertarget(weapon);
    if(!isDefined(besttarget) || (isDefined(self.stingertarget) && self.stingertarget != besttarget)) {
      self destroylockoncanceledmessage();
      if(self.stingerlockdetected == 1) {
        self weaponlockfree();
        self.stingerlockdetected = 0;
      }
      continue;
    }
    if(!self locksighttest(besttarget)) {
      self destroylockoncanceledmessage();
      continue;
    }
    if(isDefined(besttarget.lockondelay) && besttarget.lockondelay) {
      self displaylockoncanceledmessage();
      continue;
    }
    if(!targetwithinrangeofplayspace(besttarget)) {
      self displaylockoncanceledmessage();
      continue;
    }
    self destroylockoncanceledmessage();
    if(self insidestingerreticlelocked(besttarget, weapon) == 0) {
      if(self.stingerlockdetected == 0) {
        self weaponlockdetect(besttarget);
      }
      self.stingerlockdetected = 1;
      if(isDefined(weapon)) {
        setfriendlyflags(weapon, besttarget);
      }
      continue;
    }
    self.stingerlockdetected = 0;
    initlockfield(besttarget);
    self.stingertarget = besttarget;
    self.stingerlockstarttime = gettime();
    self.stingerlockstarted = 1;
    self.stingerlostsightlinetime = 0;
    self weaponlockstart(besttarget);
    self thread looplocalseeksound(game["locking_on_sound"], 0.6);
  }
}

function targetwithinrangeofplayspace(target) {
  if(getdvarint("", 0) > 0) {
    extraradiusdvar = getdvarint("", 5000);
    if(extraradiusdvar != (isDefined(level.missilelockplayspacecheckextraradius) ? level.missilelockplayspacecheckextraradius : 0)) {
      level.missilelockplayspacecheckextraradius = extraradiusdvar;
      level.missilelockplayspacecheckradiussqr = undefined;
    }
  }
  if(level.missilelockplayspacecheckenabled === 1) {
    if(!isDefined(target)) {
      return false;
    }
    if(!isDefined(level.playspacecenter)) {
      level.playspacecenter = util::getplayspacecenter();
    }
    if(!isDefined(level.missilelockplayspacecheckradiussqr)) {
      level.missilelockplayspacecheckradiussqr = ((util::getplayspacemaxwidth() * 0.5) + level.missilelockplayspacecheckextraradius) * ((util::getplayspacemaxwidth() * 0.5) + level.missilelockplayspacecheckextraradius);
    }
    if(distance2dsquared(target.origin, level.playspacecenter) > level.missilelockplayspacecheckradiussqr) {
      return false;
    }
  }
  return true;
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

function getbeststingertarget(weapon) {
  targetsall = [];
  if(isDefined(self.get_stinger_target_override)) {
    targetsall = self[[self.get_stinger_target_override]]();
  } else {
    targetsall = target_getarray();
  }
  targetsvalid = [];
  for(idx = 0; idx < targetsall.size; idx++) {
    if(getdvarstring("") == "") {
      if(self insidestingerreticlenolock(targetsall[idx], weapon)) {
        targetsvalid[targetsvalid.size] = targetsall[idx];
      }
      continue;
    }
    target = targetsall[idx];
    if(level.teambased || level.use_team_based_logic_for_locking_on === 1) {
      if(isDefined(target.team) && target.team != self.team) {
        if(self insidestingerreticledetect(target, weapon)) {
          if(!isDefined(self.is_valid_target_for_stinger_override) || self[[self.is_valid_target_for_stinger_override]](target)) {
            hascamo = isDefined(target.camo_state) && target.camo_state == 1 && !self hasperk("specialty_showenemyequipment");
            if(!hascamo) {
              targetsvalid[targetsvalid.size] = target;
            }
          }
        }
      }
      continue;
    }
    if(self insidestingerreticledetect(target, weapon)) {
      if(isDefined(target.owner) && self != target.owner || (isplayer(target) && self != target)) {
        if(!isDefined(self.is_valid_target_for_stinger_override) || self[[self.is_valid_target_for_stinger_override]](target)) {
          targetsvalid[targetsvalid.size] = target;
        }
      }
    }
  }
  if(targetsvalid.size == 0) {
    return undefined;
  }
  besttarget = targetsvalid[0];
  if(targetsvalid.size > 1) {
    closestratio = 0;
    foreach(target in targetsvalid) {
      ratio = ratiodistancefromscreencenter(target, weapon);
      if(ratio > closestratio) {
        closestratio = ratio;
        besttarget = target;
      }
    }
  }
  return besttarget;
}

function calclockonradius(target, weapon) {
  radius = self getlockonradius();
  if(isDefined(weapon) && isDefined(weapon.lockonscreenradius) && weapon.lockonscreenradius > radius) {
    radius = weapon.lockonscreenradius;
  }
  if(isDefined(level.lockoncloserange) && isDefined(level.lockoncloseradiusscaler)) {
    dist2 = distancesquared(target.origin, self.origin);
    if(dist2 < (level.lockoncloserange * level.lockoncloserange)) {
      radius = radius * level.lockoncloseradiusscaler;
    }
  }
  return radius;
}

function calclockonlossradius(target, weapon) {
  radius = self getlockonlossradius();
  if(isDefined(weapon) && isDefined(weapon.lockonscreenradius) && weapon.lockonscreenradius > radius) {
    radius = weapon.lockonscreenradius;
  }
  if(isDefined(level.lockoncloserange) && isDefined(level.lockoncloseradiusscaler)) {
    dist2 = distancesquared(target.origin, self.origin);
    if(dist2 < (level.lockoncloserange * level.lockoncloserange)) {
      radius = radius * level.lockoncloseradiusscaler;
    }
  }
  return radius;
}

function ratiodistancefromscreencenter(target, weapon) {
  radius = calclockonradius(target, weapon);
  return target_scaleminmaxradius(target, self, 65, 0, radius);
}

function insidestingerreticledetect(target, weapon) {
  radius = calclockonradius(target, weapon);
  return target_isincircle(target, self, 65, radius);
}

function insidestingerreticlenolock(target, weapon) {
  radius = calclockonradius(target, weapon);
  return target_isincircle(target, self, 65, radius);
}

function insidestingerreticlelocked(target, weapon) {
  radius = calclockonlossradius(target, weapon);
  return target_isincircle(target, self, 65, radius);
}

function isstillvalidtarget(ent, weapon) {
  if(!isDefined(ent)) {
    return 0;
  }
  if(isDefined(self.is_still_valid_target_for_stinger_override)) {
    return self[[self.is_still_valid_target_for_stinger_override]](ent, weapon);
  }
  if(!target_istarget(ent) && (!(isDefined(ent.allowcontinuedlockonafterinvis) && ent.allowcontinuedlockonafterinvis))) {
    return 0;
  }
  if(!insidestingerreticledetect(ent, weapon)) {
    return 0;
  }
  return 1;
}

function playerstingerads() {
  return self playerads() == 1;
}

function looplocalseeksound(alias, interval) {
  self endon("stop_lockon_sound");
  self endon("disconnect");
  self endon("death");
  for(;;) {
    self playsoundforlocalplayer(alias);
    self playrumbleonentity("stinger_lock_rumble");
    wait(interval / 2);
  }
}

function playsoundforlocalplayer(alias) {
  if(self isinvehicle()) {
    sound_target = self getvehicleoccupied();
    if(isDefined(sound_target)) {
      sound_target playsoundtoplayer(alias, self);
    }
  } else {
    self playlocalsound(alias);
  }
}

function looplocallocksound(alias, interval) {
  self endon("stop_locked_sound");
  self endon("disconnect");
  self endon("death");
  if(isDefined(self.stingerlocksound)) {
    return;
  }
  self.stingerlocksound = 1;
  for(;;) {
    self playsoundforlocalplayer(alias);
    self playrumbleonentity("stinger_lock_rumble");
    wait(interval / 6);
    self playsoundforlocalplayer(alias);
    self playrumbleonentity("stinger_lock_rumble");
    wait(interval / 6);
    self playsoundforlocalplayer(alias);
    self playrumbleonentity("stinger_lock_rumble");
    wait(interval / 6);
    self stoprumble("stinger_lock_rumble");
  }
  self.stingerlocksound = undefined;
}

function locksighttest(target) {
  camerapos = self getplayercamerapos();
  if(!isDefined(target)) {
    return false;
  }
  if(isDefined(target.parent)) {
    passed = bullettracepassed(camerapos, target.origin, 0, target, target.parent);
  } else {
    passed = bullettracepassed(camerapos, target.origin, 0, target);
  }
  if(passed) {
    return true;
  }
  front = target getpointinbounds(1, 0, 0);
  if(isDefined(target.parent)) {
    passed = bullettracepassed(camerapos, front, 0, target, target.parent);
  } else {
    passed = bullettracepassed(camerapos, front, 0, target);
  }
  if(passed) {
    return true;
  }
  back = target getpointinbounds(-1, 0, 0);
  if(isDefined(target.parent)) {
    passed = bullettracepassed(camerapos, back, 0, target, target.parent);
  } else {
    passed = bullettracepassed(camerapos, back, 0, target);
  }
  if(passed) {
    return true;
  }
  return false;
}

function softsighttest() {
  lost_sight_limit = 500;
  if(self locksighttest(self.stingertarget)) {
    self.stingerlostsightlinetime = 0;
    return true;
  }
  if(self.stingerlostsightlinetime == 0) {
    self.stingerlostsightlinetime = gettime();
  }
  timepassed = gettime() - self.stingerlostsightlinetime;
  if(timepassed >= lost_sight_limit) {
    self clearirtarget();
    return false;
  }
  return true;
}

function initlockfield(target) {
  if(isDefined(target.locking_on)) {
    return;
  }
  target.locking_on = 0;
  target.locked_on = 0;
  target.locking_on_hacking = 0;
}

function lockingon(target, lock) {
  assert(isDefined(target.locking_on));
  clientnum = self getentitynumber();
  if(lock) {
    target notify("hash_b081980b");
    target.locking_on = target.locking_on | (1 << clientnum);
    self thread watchclearlockingon(target, clientnum);
  } else {
    self notify("locking_on_cleared");
    target.locking_on = target.locking_on & (~(1 << clientnum));
  }
}

function watchclearlockingon(target, clientnum) {
  target endon("death");
  self endon("locking_on_cleared");
  self util::waittill_any("death", "disconnect");
  target.locking_on = target.locking_on & (~(1 << clientnum));
}

function lockedon(target, lock) {
  assert(isDefined(target.locked_on));
  clientnum = self getentitynumber();
  if(lock) {
    target.locked_on = target.locked_on | (1 << clientnum);
    self thread watchclearlockedon(target, clientnum);
  } else {
    self notify("locked_on_cleared");
    target.locked_on = target.locked_on & (~(1 << clientnum));
  }
}

function targetinghacking(target, lock) {
  assert(isDefined(target.locking_on_hacking));
  clientnum = self getentitynumber();
  if(lock) {
    target notify("hash_e1494b46");
    target.locking_on_hacking = target.locking_on_hacking | (1 << clientnum);
    self thread watchclearhacking(target, clientnum);
  } else {
    self notify("locking_on_hacking_cleared");
    target.locking_on_hacking = target.locking_on_hacking & (~(1 << clientnum));
  }
}

function watchclearhacking(target, clientnum) {
  target endon("death");
  self endon("locking_on_hacking_cleared");
  self util::waittill_any("death", "disconnect");
  target.locking_on_hacking = target.locking_on_hacking & (~(1 << clientnum));
}

function setfriendlyflags(weapon, target) {
  if(!self isinvehicle()) {
    self setfriendlyhacking(weapon, target);
    self setfriendlytargetting(weapon, target);
    self setfriendlytargetlocked(weapon, target);
    if(isDefined(level.killstreakmaxhealthfunction)) {
      if(isDefined(target.usevtoltime) && isDefined(level.vtol)) {
        killstreakendtime = level.vtol.killstreakendtime;
        if(isDefined(killstreakendtime)) {
          self settargetedentityendtime(weapon, killstreakendtime);
        }
      } else {
        if(isDefined(target.killstreakendtime)) {
          self settargetedentityendtime(weapon, target.killstreakendtime);
        } else {
          if(isDefined(target.parentstruct) && isDefined(target.parentstruct.killstreakendtime)) {
            self settargetedentityendtime(weapon, target.parentstruct.killstreakendtime);
          } else {
            self settargetedentityendtime(weapon, 0);
          }
        }
      }
      self settargetedmissilesremaining(weapon, 0);
      killstreaktype = target.killstreaktype;
      if(!isDefined(target.killstreaktype) && isDefined(target.parentstruct) && isDefined(target.parentstruct.killstreaktype)) {
        killstreaktype = target.parentstruct.killstreaktype;
      } else if(isDefined(target.usevtoltime) && isDefined(level.vtol.killstreaktype)) {
        killstreaktype = level.vtol.killstreaktype;
      }
      if(isDefined(killstreaktype) && isDefined(level.killstreakbundle[killstreaktype])) {
        if(isDefined(target.forceonemissile)) {
          self settargetedmissilesremaining(weapon, 1);
        } else {
          if(isDefined(target.usevtoltime) && isDefined(level.vtol) && isDefined(level.vtol.totalrockethits) && isDefined(level.vtol.missiletodestroy)) {
            self settargetedmissilesremaining(weapon, level.vtol.missiletodestroy - level.vtol.totalrockethits);
          } else {
            maxhealth = [
              [level.killstreakmaxhealthfunction]
            ](killstreaktype);
            damagetaken = target.damagetaken;
            if(!isDefined(damagetaken) && isDefined(target.parentstruct)) {
              damagetaken = target.parentstruct.damagetaken;
            }
            if(isDefined(target.missiletrackdamage)) {
              damagetaken = target.missiletrackdamage;
            }
            if(isDefined(damagetaken) && isDefined(maxhealth)) {
              damageperrocket = (maxhealth / level.killstreakbundle[killstreaktype].ksrocketstokill) + 1;
              remaininghealth = maxhealth - damagetaken;
              if(remaininghealth > 0) {
                missilesremaining = int(ceil(remaininghealth / damageperrocket));
                if(isDefined(target.numflares) && target.numflares > 0) {
                  missilesremaining = missilesremaining + target.numflares;
                }
                if(isDefined(target.flak_drone)) {
                  missilesremaining = missilesremaining + 1;
                }
                self settargetedmissilesremaining(weapon, missilesremaining);
              }
            }
          }
        }
      }
    }
  }
}

function setfriendlyhacking(weapon, target) {
  if(level.teambased) {
    friendlyhackingmask = target.locking_on_hacking;
    if(isDefined(friendlyhackingmask)) {
      friendlyhacking = 0;
      clientnum = self getentitynumber();
      friendlyhackingmask = friendlyhackingmask & (~(1 << clientnum));
      if(friendlyhackingmask != 0) {
        friendlyhacking = 1;
      }
      self setweaponfriendlyhacking(weapon, friendlyhacking);
    }
  }
}

function setfriendlytargetting(weapon, target) {
  if(level.teambased) {
    friendlytargetingmask = target.locking_on;
    if(isDefined(friendlytargetingmask)) {
      friendlytargeting = 0;
      clientnum = self getentitynumber();
      friendlytargetingmask = friendlytargetingmask & (~(1 << clientnum));
      if(friendlytargetingmask != 0) {
        friendlytargeting = 1;
      }
      self setweaponfriendlytargeting(weapon, friendlytargeting);
    }
  }
}

function setfriendlytargetlocked(weapon, target) {
  if(level.teambased) {
    friendlytargetlocked = 0;
    friendlylockingonmask = target.locked_on;
    if(isDefined(friendlylockingonmask)) {
      friendlytargetlocked = 0;
      clientnum = self getentitynumber();
      friendlylockingonmask = friendlylockingonmask & (~(1 << clientnum));
      if(friendlylockingonmask != 0) {
        friendlytargetlocked = 1;
      }
    }
    if(friendlytargetlocked == 0) {
      friendlytargetlocked = target missiletarget_isotherplayermissileincoming(self);
    }
    self setweaponfriendlytargetlocked(weapon, friendlytargetlocked);
  }
}

function watchclearlockedon(target, clientnum) {
  self endon("locked_on_cleared");
  self util::waittill_any("death", "disconnect");
  if(isDefined(target)) {
    target.locked_on = target.locked_on & (~(1 << clientnum));
  }
}

function missiletarget_lockonmonitor(player, endon1, endon2) {
  self endon("death");
  if(isDefined(endon1)) {
    self endon(endon1);
  }
  if(isDefined(endon2)) {
    self endon(endon2);
  }
  for(;;) {
    if(target_istarget(self)) {
      if(self missiletarget_ismissileincoming()) {
        self clientfield::set("heli_warn_fired", 1);
        self clientfield::set("heli_warn_locked", 0);
        self clientfield::set("heli_warn_targeted", 0);
      } else {
        if(isDefined(self.locked_on) && self.locked_on) {
          self clientfield::set("heli_warn_locked", 1);
          self clientfield::set("heli_warn_fired", 0);
          self clientfield::set("heli_warn_targeted", 0);
        } else {
          if(isDefined(self.locking_on) && self.locking_on) {
            self clientfield::set("heli_warn_targeted", 1);
            self clientfield::set("heli_warn_fired", 0);
            self clientfield::set("heli_warn_locked", 0);
          } else {
            self clientfield::set("heli_warn_fired", 0);
            self clientfield::set("heli_warn_targeted", 0);
            self clientfield::set("heli_warn_locked", 0);
          }
        }
      }
    }
    wait(0.1);
  }
}

function _incomingmissile(missile, attacker) {
  if(!isDefined(self.incoming_missile)) {
    self.incoming_missile = 0;
  }
  if(!isDefined(self.incoming_missile_owner)) {
    self.incoming_missile_owner = [];
  }
  if(!isDefined(self.incoming_missile_owner[attacker.entnum])) {
    self.incoming_missile_owner[attacker.entnum] = 0;
  }
  self.incoming_missile++;
  self.incoming_missile_owner[attacker.entnum]++;
  attacker lockedon(self, 1);
  self thread _incomingmissiletracker(missile, attacker);
}

function _incomingmissiletracker(missile, attacker) {
  self endon("death");
  attacker_entnum = attacker.entnum;
  missile waittill("death");
  self.incoming_missile--;
  self.incoming_missile_owner[attacker_entnum]--;
  if(self.incoming_missile_owner[attacker_entnum] == 0) {
    self.incoming_missile_owner[attacker_entnum] = undefined;
  }
  if(isDefined(attacker)) {
    attacker lockedon(self, 0);
  }
  assert(self.incoming_missile >= 0);
}

function missiletarget_ismissileincoming() {
  if(!isDefined(self.incoming_missile)) {
    return false;
  }
  if(self.incoming_missile) {
    return true;
  }
  return false;
}

function missiletarget_isotherplayermissileincoming(attacker) {
  if(!isDefined(self.incoming_missile_owner)) {
    return false;
  }
  if(self.incoming_missile_owner.size == 0) {
    return false;
  }
  if(self.incoming_missile_owner.size == 1 && isDefined(self.incoming_missile_owner[attacker.entnum])) {
    return false;
  }
  return true;
}

function missiletarget_handleincomingmissile(responsefunc, endon1, endon2, allowdirectdamage) {
  level endon("game_ended");
  self endon("death");
  if(isDefined(endon1)) {
    self endon(endon1);
  }
  if(isDefined(endon2)) {
    self endon(endon2);
  }
  for(;;) {
    self waittill("stinger_fired_at_me", missile, weapon, attacker);
    _incomingmissile(missile, attacker);
    if(isDefined(responsefunc)) {
      [
        [responsefunc]
      ](missile, attacker, weapon, endon1, endon2, allowdirectdamage);
    }
  }
}

function missiletarget_proximitydetonateincomingmissile(endon1, endon2, allowdirectdamage) {
  missiletarget_handleincomingmissile( & missiletarget_proximitydetonate, endon1, endon2, allowdirectdamage);
}

function _missiledetonate(attacker, weapon, range, mindamage, maxdamage, allowdirectdamage) {
  origin = self.origin;
  target = self missile_gettarget();
  self detonate();
  if(allowdirectdamage === 1 && isDefined(target) && isDefined(target.origin)) {
    mindistsq = (isDefined(target.locked_missile_min_distsq) ? target.locked_missile_min_distsq : range * range);
    distsq = distancesquared(self.origin, target.origin);
    if(distsq < mindistsq) {
      target dodamage(maxdamage, origin, attacker, self, "none", "MOD_PROJECTILE", 0, weapon);
    }
  }
  radiusdamage(origin, range, maxdamage, mindamage, attacker, "MOD_PROJECTILE_SPLASH", weapon);
}

function missiletarget_proximitydetonate(missile, attacker, weapon, endon1, endon2, allowdirectdamage) {
  level endon("game_ended");
  missile endon("death");
  if(isDefined(endon1)) {
    self endon(endon1);
  }
  if(isDefined(endon2)) {
    self endon(endon2);
  }
  mindist = distancesquared(missile.origin, self.origin);
  lastcenter = self.origin;
  missile missile_settarget(self, (isDefined(target_getoffset(self)) ? target_getoffset(self) : (0, 0, 0)));
  if(isDefined(self.missiletargetmissdistance)) {
    misseddistancesq = self.missiletargetmissdistance * self.missiletargetmissdistance;
  } else {
    misseddistancesq = 250000;
  }
  flaredistancesq = 12250000;
  for(;;) {
    if(!isDefined(self)) {
      center = lastcenter;
    } else {
      center = self.origin;
    }
    lastcenter = center;
    curdist = distancesquared(missile.origin, center);
    if(curdist < flaredistancesq && isDefined(self.numflares) && self.numflares > 0) {
      self.numflares--;
      self thread missiletarget_playflarefx();
      self challenges::trackassists(attacker, 0, 1);
      newtarget = self missiletarget_deployflares(missile.origin, missile.angles);
      missile missile_settarget(newtarget, (isDefined(target_getoffset(newtarget)) ? target_getoffset(newtarget) : (0, 0, 0)));
      missiletarget = newtarget;
      return;
    }
    if(curdist < mindist) {
      mindist = curdist;
    }
    if(curdist > mindist) {
      if(curdist > misseddistancesq) {
        return;
      }
      missile thread _missiledetonate(attacker, weapon, 500, 600, 600, allowdirectdamage);
      return;
    }
    wait(0.05);
  }
}

function missiletarget_playflarefx() {
  if(!isDefined(self)) {
    return;
  }
  flare_fx = level.fx_flare;
  if(isDefined(self.fx_flare)) {
    flare_fx = self.fx_flare;
  }
  if(isDefined(self.flare_ent)) {
    playFXOnTag(flare_fx, self.flare_ent, "tag_origin");
  } else {
    playFXOnTag(flare_fx, self, "tag_origin");
  }
  if(isDefined(self.owner)) {
    self playsoundtoplayer("veh_huey_chaff_drop_plr", self.owner);
  }
  self playSound("veh_huey_chaff_explo_npc");
}

function missiletarget_deployflares(origin, angles) {
  vec_toforward = anglesToForward(self.angles);
  vec_toright = anglestoright(self.angles);
  vec_tomissileforward = anglesToForward(angles);
  delta = self.origin - origin;
  dot = vectordot(vec_tomissileforward, vec_toright);
  sign = 1;
  if(dot > 0) {
    sign = -1;
  }
  flare_dir = vectornormalize((vectorscale(vec_toforward, -0.5)) + vectorscale(vec_toright, sign));
  velocity = vectorscale(flare_dir, randomintrange(200, 400));
  velocity = (velocity[0], velocity[1], velocity[2] - randomintrange(10, 100));
  flareorigin = self.origin;
  flareorigin = flareorigin + vectorscale(flare_dir, randomintrange(600, 800));
  flareorigin = flareorigin + vectorscale((0, 0, 1), 500);
  if(isDefined(self.flareoffset)) {
    flareorigin = flareorigin + self.flareoffset;
  }
  flareobject = spawn("script_origin", flareorigin);
  flareobject.angles = self.angles;
  flareobject setModel("tag_origin");
  flareobject movegravity(velocity, 5);
  flareobject thread util::deleteaftertime(5);
  self thread debug_tracker(flareobject);
  return flareobject;
}

function debug_tracker(target) {
  target endon("death");
  while(true) {
    dev::debug_sphere(target.origin, 10, (1, 0, 0), 1, 1);
    wait(0.05);
  }
}