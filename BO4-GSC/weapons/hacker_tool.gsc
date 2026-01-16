/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\hacker_tool.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\killstreaks\killstreaks_util;
#include scripts\weapons\heatseekingmissile;
#include scripts\weapons\weaponobjects;

#namespace hacker_tool;

init_shared() {
  level.weaponhackertool = getweapon(#"pda_hack");
  level.hackertoollostsightlimitms = 1000;
  level.hackertoollockonradius = 25;
  level.hackertoollockonfov = 65;
  level.hackertoolhacktimems = 0.4;
  level.equipmenthackertoolradius = 20;
  level.equipmenthackertooltimems = 100;
  level.carepackagehackertoolradius = 60;
  level.carepackagehackertooltimems = getgametypesetting(#"cratecapturetime") * 500;
  level.carepackagefriendlyhackertooltimems = getgametypesetting(#"cratecapturetime") * 2000;
  level.carepackageownerhackertooltimems = 250;
  level.vehiclehackertoolradius = 80;
  level.vehiclehackertooltimems = 5000;
  clientfield::register("toplayer", "hacker_tool", 1, 2, "int");
  callback::on_spawned(&on_player_spawned);
}

on_player_spawned() {
  self endon(#"disconnect");
  self clearhackertarget(undefined, 0, 1);
  self thread watchhackertoolfired();
}

clearhackertarget(weapon, successfulhack, spawned) {
  self notify(#"stop_lockon_sound");
  self notify(#"stop_locked_sound");
  self notify(#"clearhackertarget");
  self.stingerlocksound = undefined;
  self stoprumble("stinger_lock_rumble");
  self.hackertoollockstarttime = 0;
  self.hackertoollockstarted = 0;
  self.hackertoollockfinalized = 0;
  self.hackertoollocktimeelapsed = 0;

  if(isDefined(weapon)) {
    self setweaponhackpercent(weapon, 0);

    if(isDefined(self.hackertooltarget)) {
      heatseekingmissile::setfriendlyflags(weapon, self.hackertooltarget);
    }
  }

  if(successfulhack == 0) {
    if(spawned == 0) {
      if(isDefined(self.hackertooltarget)) {
        self playsoundtoplayer(#"evt_hacker_hack_lost", self);
      }
    }

    self clientfield::set_to_player("hacker_tool", 0);
    self stophackertoolsoundloop();
  }

  if(isDefined(self.hackertooltarget)) {
    heatseekingmissile::targetinghacking(self.hackertooltarget, 0);
  }

  self.hackertooltarget = undefined;
  self weaponlockfree();
  self weaponlocktargettooclose(0);
  self weaponlocknoclearance(0);

  self heatseekingmissile::destroylockoncanceledmessage();

}

watchhackertoolfired() {
  self endon(#"disconnect", #"death", #"killhackermonitor");

  while(true) {
    waitresult = self waittill(#"hacker_tool_fired");
    hackertooltarget = waitresult.target;
    weapon = waitresult.weapon;

    if(isDefined(hackertooltarget)) {
      if(isentityhackablecarepackage(hackertooltarget)) {
        scoreevents::givecratecapturemedal(hackertooltarget, self);
        hackertooltarget notify(#"captured", {
          #player: self, 
          #is_remote_hack: 1
        });

        if(isDefined(hackertooltarget.owner) && isplayer(hackertooltarget.owner) && hackertooltarget.owner.team != self.team) {
          hackertooltarget.owner killstreaks::play_killstreak_hacked_dialog(hackertooltarget.killstreaktype, hackertooltarget.killstreakid, self);
        }
      } else if(isentityhackableweaponobject(hackertooltarget) && isDefined(hackertooltarget.hackertrigger)) {
        hackertooltarget.hackertrigger notify(#"trigger", {
          #activator: self, 
          #dropped_item: 1
        });
        hackertooltarget.previouslyhacked = 1;
        self.throwinggrenade = 0;
      } else if(isDefined(hackertooltarget.killstreak_hackedcallback) && (!isDefined(hackertooltarget.killstreaktimedout) || hackertooltarget.killstreaktimedout == 0)) {
        if(hackertooltarget.killstreak_hackedprotection == 0) {
          if(isDefined(hackertooltarget.owner) && isplayer(hackertooltarget.owner)) {
            hackertooltarget.owner killstreaks::play_killstreak_hacked_dialog(hackertooltarget.killstreaktype, hackertooltarget.killstreakid, self);
          }

          self playsoundtoplayer(#"evt_hacker_fw_success", self);
          hackertooltarget notify(#"killstreak_hacked", {
            #hacker: self
          });
          hackertooltarget.previouslyhacked = 1;
          hackertooltarget[[hackertooltarget.killstreak_hackedcallback]](self);

          if(self util::has_blind_eye_perk_purchased_and_equipped() || self util::has_hacker_perk_purchased_and_equipped()) {
            self stats::function_dad108fa(#"hack_streak_with_blindeye_or_engineer", 1);
          }
        } else {
          if(isDefined(hackertooltarget.owner) && isplayer(hackertooltarget.owner)) {
            self.hackertooltarget.owner killstreaks::play_killstreak_firewall_hacked_dialog(self.hackertooltarget.killstreaktype, self.hackertooltarget.killstreakid);
          }

          self playsoundtoplayer(#"evt_hacker_ks_success", self);
          scoreevents::processscoreevent(#"hacked_killstreak_protection", self, hackertooltarget, level.weaponhackertool);
        }

        hackertooltarget.killstreak_hackedprotection = 0;
      } else {
        if(isDefined(hackertooltarget.classname) && hackertooltarget.classname == "grenade") {
          damage = 1;
        } else if(isDefined(hackertooltarget.hackertooldamage)) {
          damage = hackertooltarget.hackertooldamage;
        } else if(isDefined(hackertooltarget.maxhealth)) {
          damage = hackertooltarget.maxhealth + 1;
        } else {
          damage = 999999;
        }

        if(isDefined(hackertooltarget.numflares) && hackertooltarget.numflares > 0) {
          damage = 1;
          hackertooltarget.numflares--;
          hackertooltarget heatseekingmissile::missiletarget_playflarefx();
        }

        hackertooltarget dodamage(damage, self.origin, self, self, 0, "MOD_UNKNOWN", 0, weapon);
      }

      if(self util::is_item_purchased(#"pda_hack")) {
        self stats::function_dad108fa(#"hack_enemy_target", 1);
      }

      self stats::function_e24eec31(weapon, #"used", 1);
    }

    clearhackertarget(weapon, 1, 0);
    self forceoffhandend();

    if(getdvarint(#"player_sustainammo", 0) == 0) {
      clip_ammo = self getweaponammoclip(weapon);
      clip_ammo--;
      assert(clip_ammo >= 0);
      self setweaponammoclip(weapon, clip_ammo);
    }

      self killstreaks::switch_to_last_non_killstreak_weapon();
  }
}

event_handler[grenade_pullback] function_f4068d35(eventstruct) {
  if(!isplayer(self)) {
    return;
  }

  weapon = eventstruct.weapon;

  if(isDefined(level.weaponhackertool) && weapon.rootweapon == level.weaponhackertool) {
    waitframe(1);
    currentoffhand = self getcurrentoffhand();

    if(self isusingoffhand() && currentoffhand.rootweapon == level.weaponhackertool) {
      self thread hackertooltargetloop(weapon);
      self thread watchhackertoolend(weapon);
      self thread watchforgrenadefire(weapon);
      self thread watchhackertoolinterrupt(weapon);
    }
  }
}

watchhackertoolinterrupt(weapon) {
  self endon(#"disconnect", #"hacker_tool_fired", #"death", #"weapon_change", #"grenade_fire");

  while(true) {
    waitresult = level waittill(#"use_interrupt");

    if(self.hackertooltarget == waitresult.target) {
      clearhackertarget(weapon, 0, 0);
    }

    waitframe(1);
  }
}

watchhackertoolend(weapon) {
  self endon(#"disconnect", #"hacker_tool_fired");
  self waittill(#"weapon_change", #"death", #"hacker_tool_fired", #"disconnect");
  clearhackertarget(weapon, 0, 0);
  self clientfield::set_to_player("hacker_tool", 0);
  self stophackertoolsoundloop();
}

watchforgrenadefire(weapon) {
  self endon(#"disconnect", #"hacker_tool_fired", #"weapon_change", #"death");

  while(true) {
    waitresult = self waittill(#"grenade_fire");
    grenade_instance = waitresult.projectile;
    grenade_weapon = waitresult.weapon;
    respawnfromhack = waitresult.respawn_from_hack;

    if(isDefined(respawnfromhack) && respawnfromhack) {
      continue;
    }

    clearhackertarget(grenade_weapon, 0, 0);
    clip_ammo = self getweaponammoclip(grenade_weapon);
    clip_max_ammo = grenade_weapon.clipsize;

    if(clip_ammo < clip_max_ammo) {
      clip_ammo++;
    }

    self setweaponammoclip(grenade_weapon, clip_ammo);
    break;
  }
}

playhackertoolsoundloop() {
  if(!isDefined(self.hacker_sound_ent) || isDefined(self.hacker_alreadyhacked) && self.hacker_alreadyhacked == 1) {
    self playLoopSound(#"evt_hacker_device_loop");
    self.hacker_sound_ent = 1;
    self.hacker_alreadyhacked = 0;
  }
}

stophackertoolsoundloop() {
  self stoploopsound(0.5);
  self.hacker_sound_ent = undefined;
  self.hacker_alreadyhacked = undefined;
}

hackertooltargetloop(weapon) {
  self endon(#"disconnect", #"death", #"weapon_change", #"grenade_fire");
  self clientfield::set_to_player("hacker_tool", 1);
  self playhackertoolsoundloop();

  while(true) {
    waitframe(1);
    waitframe(1);

    if(self.hackertoollockfinalized) {
      if(!self isvalidhackertooltarget(self.hackertooltarget, weapon, 0)) {
        self clearhackertarget(weapon, 0, 0);
        continue;
      }

      passed = self hackersoftsighttest(weapon);

      if(!passed) {
        continue;
      }

      self clientfield::set_to_player("hacker_tool", 0);
      self stophackertoolsoundloop();
      heatseekingmissile::targetinghacking(self.hackertooltarget, 0);
      heatseekingmissile::setfriendlyflags(weapon, self.hackertooltarget);
      thread heatseekingmissile::looplocallocksound(game.locked_on_sound, 0.75);
      self notify(#"hacker_tool_fired", {
        #target: self.hackertooltarget, 
        #weapon: weapon
      });
      return;
    }

    if(self.hackertoollockstarted) {
      if(!self isvalidhackertooltarget(self.hackertooltarget, weapon, 0)) {
        self clearhackertarget(weapon, 0, 0);
        continue;
      }

      lockontime = self getlockontime(self.hackertooltarget, weapon);

      if(lockontime == 0) {
        self clearhackertarget(weapon, 0, 0);
        continue;
      }

      if(self.hackertoollocktimeelapsed == 0) {
        self playlocalsound(#"evt_hacker_hacking");

        if(isDefined(self.hackertooltarget.owner) && isplayer(self.hackertooltarget.owner)) {
          if(isDefined(self.hackertooltarget.killstreak_hackedcallback) && (!isDefined(self.hackertooltarget.killstreaktimedout) || self.hackertooltarget.killstreaktimedout == 0)) {
            if(self.hackertooltarget.killstreak_hackedprotection == 0) {
              self.hackertooltarget.owner killstreaks::play_killstreak_being_hacked_dialog(self.hackertooltarget.killstreaktype, self.hackertooltarget.killstreakid);
            } else {
              self.hackertooltarget.owner killstreaks::play_killstreak_firewall_being_hacked_dialog(self.hackertooltarget.killstreaktype, self.hackertooltarget.killstreakid);
            }
          }
        }
      }

      self weaponlockstart(self.hackertooltarget);
      self playhackertoolsoundloop();

      if(isDefined(self.hackertooltarget.killstreak_hackedprotection) && self.hackertooltarget.killstreak_hackedprotection == 1) {
        self clientfield::set_to_player("hacker_tool", 3);
      } else {
        self clientfield::set_to_player("hacker_tool", 2);
      }

      heatseekingmissile::targetinghacking(self.hackertooltarget, 1);
      heatseekingmissile::setfriendlyflags(weapon, self.hackertooltarget);
      passed = self hackersoftsighttest(weapon);

      if(!passed) {
        continue;
      }

      if(self.hackertoollostsightlinetime == 0) {
        self.hackertoollocktimeelapsed += 0.1 * hackingtimescale(self.hackertooltarget);
        hackpercentage = self.hackertoollocktimeelapsed / lockontime * 100;
        self setweaponhackpercent(weapon, hackpercentage);
        heatseekingmissile::setfriendlyflags(weapon, self.hackertooltarget);
      } else {
        self.hackertoollocktimeelapsed -= 0.1 * hackingtimenolineofsightscale(self.hackertooltarget);

        if(self.hackertoollocktimeelapsed < 0) {
          self.hackertoollocktimeelapsed = 0;
          self clearhackertarget(weapon, 0, 0);
          continue;
        }

        hackpercentage = self.hackertoollocktimeelapsed / lockontime * 100;
        self setweaponhackpercent(weapon, hackpercentage);
        heatseekingmissile::setfriendlyflags(weapon, self.hackertooltarget);
      }

      if(self.hackertoollocktimeelapsed < lockontime) {
        continue;
      }

      assert(isDefined(self.hackertooltarget));
      self notify(#"stop_lockon_sound");
      self.hackertoollockfinalized = 1;
      self weaponlockfinalize(self.hackertooltarget);
      continue;
    }

    if(self isempjammed()) {

      self heatseekingmissile::destroylockoncanceledmessage();

        continue;
    }

    besttarget = self getbesthackertooltarget(weapon);

    if(!isDefined(besttarget)) {
      self stophackertoolsoundloop();

      self heatseekingmissile::destroylockoncanceledmessage();

        continue;
    }

    if(!self heatseekingmissile::locksighttest(besttarget)) {
      self stophackertoolsoundloop();

      self heatseekingmissile::destroylockoncanceledmessage();

        continue;
    }

    if(self heatseekingmissile::locksighttest(besttarget) && isDefined(besttarget.lockondelay) && besttarget.lockondelay) {
      self stophackertoolsoundloop();

      self heatseekingmissile::displaylockoncanceledmessage();

        continue;
    }

    self heatseekingmissile::destroylockoncanceledmessage();

      if(isentitypreviouslyhacked(besttarget)) {
        if(!isDefined(self.hacker_sound_ent) || isDefined(self.hacker_alreadyhacked) && self.hacker_alreadyhacked == 0) {
          self.hacker_sound_ent = 1;
          self.hacker_alreadyhacked = 1;
          self playLoopSound(#"evt_hacker_unhackable_loop");
        }

        continue;
      }
    else {
      self stophackertoolsoundloop();
    }

    heatseekingmissile::initlockfield(besttarget);
    self.hackertooltarget = besttarget;
    self thread watchtargetentityupdate(besttarget);
    self.hackertoollockstarttime = gettime();
    self.hackertoollockstarted = 1;
    self.hackertoollostsightlinetime = 0;
    self.hackertoollocktimeelapsed = 0;
    self setweaponhackpercent(weapon, 0);

    if(isDefined(self.hackertooltarget)) {
      heatseekingmissile::setfriendlyflags(weapon, self.hackertooltarget);
    }
  }
}

watchtargetentityupdate(besttarget) {
  self endon(#"death", #"disconnect");
  self notify(#"watchtargetentityupdate");
  self endon(#"watchtargetentityupdate", #"clearhackertarget");
  besttarget endon(#"death");
  waitresult = besttarget waittill(#"hackertool_update_ent");
  heatseekingmissile::initlockfield(waitresult.entity);
  self.hackertooltarget = waitresult.entity;
}

getbesthackertooltarget(weapon) {
  targetsvalid = [];
  targetsall = arraycombine(target_getarray(), level.missileentities, 0, 0);
  targetsall = arraycombine(targetsall, level.hackertooltargets, 0, 0);

  for(idx = 0; idx < targetsall.size; idx++) {
    target_ent = targetsall[idx];

    if(!isDefined(target_ent) || !isDefined(target_ent.owner)) {
      continue;
    }

    if(getdvarint(#"scr_freelock", 0) == 1) {
      if(self iswithinhackertoolreticle(targetsall[idx], weapon)) {
        targetsvalid[targetsvalid.size] = targetsall[idx];
      }

      continue;
    }

      if(level.teambased || level.use_team_based_logic_for_locking_on === 1) {
        if(isentityhackablecarepackage(target_ent)) {
          if(self cantargetentity(target_ent, weapon)) {
            targetsvalid[targetsvalid.size] = target_ent;
          }
        } else if(isDefined(target_ent.team)) {
          if(target_ent.team != self.team) {
            if(self cantargetentity(target_ent, weapon)) {
              targetsvalid[targetsvalid.size] = target_ent;
            }
          }
        } else if(isDefined(target_ent.owner.team)) {
          if(target_ent.owner.team != self.team) {
            if(self cantargetentity(target_ent, weapon)) {
              targetsvalid[targetsvalid.size] = target_ent;
            }
          }
        }

        continue;
      }

    if(self iswithinhackertoolreticle(target_ent, weapon)) {
      if(isentityhackablecarepackage(target_ent)) {
        if(self cantargetentity(target_ent, weapon)) {
          targetsvalid[targetsvalid.size] = target_ent;
        }

        continue;
      }

      if(isDefined(target_ent.owner) && self != target_ent.owner) {
        if(self cantargetentity(target_ent, weapon)) {
          targetsvalid[targetsvalid.size] = target_ent;
        }
      }
    }
  }

  chosenent = undefined;

  if(targetsvalid.size != 0) {
    chosenent = targetsvalid[0];
  }

  return chosenent;
}

cantargetentity(target, weapon) {
  if(!self iswithinhackertoolreticle(target, weapon)) {
    return false;
  }

  if(!isvalidhackertooltarget(target, weapon, 1)) {
    return false;
  }

  return true;
}

iswithinhackertoolreticle(target, weapon) {
  radiusinner = gethackertoolinnerradius(target);
  radiusouter = gethackertoolouterradius(target);

  if(target_scaleminmaxradius(target, self, level.hackertoollockonfov, radiusinner, radiusouter) > 0) {
    return 1;
  }

  return target_boundingisunderreticle(self, target, weapon.lockonmaxrange);
}

hackingtimescale(target) {
  hackratio = 1;
  radiusinner = gethackertoolinnerradius(target);
  radiusouter = gethackertoolouterradius(target);

  if(radiusinner != radiusouter) {
    scale = target_scaleminmaxradius(target, self, level.hackertoollockonfov, radiusinner, radiusouter);
    hacktime = lerpfloat(gethackoutertime(target), gethacktime(target), scale);

    hackertooldebugtext = getdvarint(#"hackertooldebugtext", 0);

    if(hackertooldebugtext) {
      print3d(target.origin, "<dev string:x38>" + scale + "<dev string:x42>" + radiusinner + "<dev string:x4d>" + radiusouter, (0, 0, 0), 1, hackertooldebugtext, 2);
    }

    assert(hacktime > 0);

      hackratio = gethacktime(target) / hacktime;

    if(!isDefined(hackratio)) {
      hackratio = 1;
    }
  }

  return hackratio;
}

hackingtimenolineofsightscale(target) {
  hackratio = 1;

  if(isDefined(target.killstreakhacklostlineofsighttimems) && target.killstreakhacklostlineofsighttimems > 0) {
    assert(target.killstreakhacklostlineofsighttimems > 0);
    hackratio = 1000 / target.killstreakhacklostlineofsighttimems;
  }

  return hackratio;
}

isentityhackableweaponobject(entity) {
  if(isDefined(entity.classname) && entity.classname == "grenade") {
    if(isDefined(entity.weapon)) {
      watcher = weaponobjects::getweaponobjectwatcherbyweapon(entity.weapon);

      if(isDefined(watcher)) {
        if(watcher.hackable) {

          assert(isDefined(watcher.hackertoolradius));
          assert(isDefined(watcher.hackertooltimems));

            return true;
        }
      }
    }
  }

  return false;
}

getweaponobjecthackerradius(entity) {

  assert(isDefined(entity.classname));
  assert(isDefined(entity.weapon));

    watcher = weaponobjects::getweaponobjectwatcherbyweapon(entity.weapon);

  assert(watcher.hackable);
  assert(isDefined(watcher.hackertoolradius));

    return watcher.hackertoolradius;
}

getweaponobjecthacktimems(entity) {

  assert(isDefined(entity.classname));
  assert(isDefined(entity.weapon));

    watcher = weaponobjects::getweaponobjectwatcherbyweapon(entity.weapon);

  assert(watcher.hackable);
  assert(isDefined(watcher.hackertooltimems));

    return watcher.hackertooltimems;
}

isentityhackablecarepackage(entity) {
  if(isDefined(entity.model)) {
    return (entity.model == #"wpn_t7_care_package_world");
  }

  return 0;
}

isvalidhackertooltarget(ent, weapon, allowhacked) {
  if(!isDefined(ent)) {
    return false;
  }

  if(self util::isusingremote()) {
    return false;
  }

  if(self isempjammed()) {
    return false;
  }

  if(!(target_istarget(ent) || isDefined(ent.allowhackingaftercloak) && ent.allowhackingaftercloak == 1) && !isentityhackableweaponobject(ent) && !isinarray(level.hackertooltargets, ent)) {
    return false;
  }

  if(isentityhackableweaponobject(ent)) {
    if(distancesquared(self.origin, ent.origin) > weapon.lockonmaxrange * weapon.lockonmaxrange) {
      return false;
    }
  }

  if(allowhacked == 0 && isentitypreviouslyhacked(ent)) {
    return false;
  }

  return true;
}

isentitypreviouslyhacked(entity) {
  if(isDefined(entity.previouslyhacked) && entity.previouslyhacked) {
    return true;
  }

  return false;
}

hackersoftsighttest(weapon) {
  passed = 1;
  lockontime = 0;

  if(isDefined(self.hackertooltarget)) {
    lockontime = self getlockontime(self.hackertooltarget, weapon);
  }

  if(lockontime == 0 || self isempjammed()) {
    self clearhackertarget(weapon, 0, 0);
    passed = 0;
  } else if(iswithinhackertoolreticle(self.hackertooltarget, weapon) && self heatseekingmissile::locksighttest(self.hackertooltarget)) {
    self.hackertoollostsightlinetime = 0;
  } else {
    if(self.hackertoollostsightlinetime == 0) {
      self.hackertoollostsightlinetime = gettime();
    }

    timepassed = gettime() - self.hackertoollostsightlinetime;
    lostlineofsighttimelimitmsec = level.hackertoollostsightlimitms;

    if(isDefined(self.hackertooltarget.killstreakhacklostlineofsightlimitms)) {
      lostlineofsighttimelimitmsec = self.hackertooltarget.killstreakhacklostlineofsightlimitms;
    }

    if(timepassed >= lostlineofsighttimelimitmsec) {
      self clearhackertarget(weapon, 0, 0);
      passed = 0;
    }
  }

  return passed;
}

registerwithhackertool(radius, hacktimems) {
  self endon(#"death");

  if(isDefined(radius)) {
    self.hackertoolradius = radius;
  } else {
    self.hackertoolradius = level.hackertoollockonradius;
  }

  if(isDefined(hacktimems)) {
    self.hackertooltimems = hacktimems;
  } else {
    self.hackertooltimems = level.hackertoolhacktimems;
  }

  self thread watchhackableentitydeath();
  level.hackertooltargets[level.hackertooltargets.size] = self;
}

watchhackableentitydeath() {
  self waittill(#"death");
  arrayremovevalue(level.hackertooltargets, self);
}

gethackertoolinnerradius(target) {
  radius = level.hackertoollockonradius;

  if(isentityhackablecarepackage(target)) {
    assert(isDefined(target.hackertoolradius));
    radius = target.hackertoolradius;
  } else if(isentityhackableweaponobject(target)) {
    radius = getweaponobjecthackerradius(target);
  } else if(isDefined(target.hackertoolinnerradius)) {
    radius = target.hackertoolinnerradius;
  } else if(isDefined(target.hackertoolradius)) {
    radius = target.hackertoolradius;
  }

  return radius;
}

gethackertoolouterradius(target) {
  radius = level.hackertoollockonradius;

  if(isentityhackablecarepackage(target)) {
    assert(isDefined(target.hackertoolradius));
    radius = target.hackertoolradius;
  } else if(isentityhackableweaponobject(target)) {
    radius = getweaponobjecthackerradius(target);
  } else if(isDefined(target.hackertoolouterradius)) {
    radius = target.hackertoolouterradius;
  } else if(isDefined(target.hackertoolradius)) {
    radius = target.hackertoolradius;
  }

  return radius;
}

gethacktime(target) {
  time = 500;

  if(isentityhackablecarepackage(target)) {
    assert(isDefined(target.hackertooltimems));

    if(isDefined(target.owner) && target.owner == self) {
      time = level.carepackageownerhackertooltimems;
    } else if(isDefined(target.owner) && target.owner.team == self.team) {
      time = level.carepackagefriendlyhackertooltimems;
    } else {
      time = level.carepackagehackertooltimems;
    }
  } else if(isentityhackableweaponobject(target)) {
    time = getweaponobjecthacktimems(target);
  } else if(isDefined(target.hackertoolinnertimems)) {
    time = target.hackertoolinnertimems;
  } else {
    time = level.vehiclehackertooltimems;
  }

  return time;
}

gethackoutertime(target) {
  time = 500;

  if(isentityhackablecarepackage(target)) {
    assert(isDefined(target.hackertooltimems));

    if(isDefined(target.owner) && target.owner == self) {
      time = level.carepackageownerhackertooltimems;
    } else if(isDefined(target.owner) && target.owner.team == self.team) {
      time = level.carepackagefriendlyhackertooltimems;
    } else {
      time = level.carepackagehackertooltimems;
    }
  } else if(isentityhackableweaponobject(target)) {
    time = getweaponobjecthacktimems(target);
  } else if(isDefined(target.hackertooloutertimems)) {
    time = target.hackertooloutertimems;
  } else {
    time = level.vehiclehackertooltimems;
  }

  return time;
}

getlockontime(target, weapon) {
  locklengthms = self gethacktime(self.hackertooltarget);

  if(locklengthms == 0) {
    return 0;
  }

  lockonspeed = weapon.lockonspeed;

  if(lockonspeed <= 0) {
    lockonspeed = 1000;
  }

  return locklengthms / lockonspeed;
}

tunables() {
  while(true) {
    level.hackertoollostsightlimitms = getdvarint(#"scr_hackertoollostsightlimitms", 1000);
    level.hackertoollockonradius = getdvarfloat(#"scr_hackertoollockonradius", 20);
    level.hackertoollockonfov = getdvarint(#"scr_hackertoollockonfov", 65);
    wait 1;
  }
}

