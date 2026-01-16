/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\combat_utility.gsc
******************************************/

#include animscripts\utility;
#include animscripts\debug;
#include animscripts\setposemovement;
#include animscripts\anims;
#include common_scripts\utility;
#include maps\_gameskill;
#include maps\_utility;
#include animscripts\run;
#include animscripts\shared;
#include animscripts\weaponlist;
#include maps\_dds;
#include maps\_damagefeedback;

player_init() {
}

enemieswithinstandingrange() {
  enemydistancesq = self mygetenemysqdist();
  return enemydistancesq < anim.standrangesq;
}

mygetenemysqdist() {
  dist = self getclosestenemysqdist();

  if(!isDefined(dist))
    dist = 1215752192;

  return dist;
}

gettargetangleoffset(target) {
  pos = self getshootatpos() + vectorscale((0, 0, -1), 3.0);
  dir = (pos[0] - target[0], pos[1] - target[1], pos[2] - target[2]);
  dir = vectornormalize(dir);
  fact = dir[2] * -1;
  return fact;
}

getsniperburstdelaytime() {
  return randomfloatrange(anim.min_sniper_burst_delay_time, anim.max_sniper_burst_delay_time);
}

getremainingburstdelaytime() {
  timesofar = (gettime() - self.a.lastshoottime) / 1000;
  delaytime = getburstdelaytime();

  if(delaytime > timesofar)
    return delaytime - timesofar;

  return 0;
}

getburstdelaytime() {
  if(self.weapon == self.sidearm)
    return randomfloatrange(0.15, 0.55);
  else if(self usingshotgun())
    return randomfloatrange(1.0, 1.7);
  else if(self issniper())
    return getsniperburstdelaytime();
  else if(self.fastburst)
    return randomfloatrange(0.1, 0.35);
  else if(self usinggrenadelauncher())
    return randomfloatrange(1.5, 2.0);
  else if(is_rusher() && self.rushertype == "pistol")
    return randomfloatrange(0.1, 0.3);
  else
    return randomfloatrange(0.4, 0.9);
}

burstdelay() {
  if(self.bulletsinclip) {
    if(self.shootstyle == "full" && !self.fastburst) {
      if(self.a.lastshoottime == gettime())
        wait 0.05;

      return;
    }

    delaytime = getremainingburstdelaytime();

    if(delaytime)
      wait(delaytime);
  }
}

cheatammoifnecessary() {
  assert(!self.bulletsinclip);

  if(shouldforcebehavior("force_cheat_ammo")) {
    self.bulletsinclip = 10;

    if(self.bulletsinclip > weaponclipsize(self.weapon))
      self.bulletsinclip = weaponclipsize(self.weapon);

    return true;
  }

  if(animscripts\run::shouldtacticalwalk()) {
    self.bulletsinclip = weaponclipsize(self.weapon);
    return true;
  }

  if(self is_rusher()) {
    self.bulletsinclip = weaponclipsize(self.weapon);
    return true;
  }

  return false;
}

stopfiringonshootbehaviorchange() {
  self waittill_any("shoot_burst_done", "shoot_behavior_change", "stopShooting", "killanimscript", "need_to_turn");

  if(isDefined(self))
    self stopshoot();
}

shootuntilshootbehaviorchange() {
  self endon("shoot_behavior_change");
  self endon("stopShooting");
  self thread stopfiringonshootbehaviorchange();

  self animscripts\debug::debugpopstate("shootUntilShootBehaviorChange", "was interrupted");
  self animscripts\debug::debugpushstate("shootUntilShootBehaviorChange", "shootStyle: " + self.shootstyle);

  if(self weaponanims() == "rocketlauncher" || self issniper()) {
    players = getplayers();

    if(self weaponanims() == "rocketlauncher" && issentient(self.enemy))
      wait(randomfloat(2.0));
  }

  if(isDefined(self.enemy) && distancesquared(self.origin, self.enemy.origin) > 160000)
    burstcount = randomintrange(1, 5);
  else
    burstcount = 10;

  while(true) {
    burstdelay();

    self animscripts\debug::debugpopstate("FireUntilOutOfAmmo");

    animprefix = getshootanimprefix();

    if(self.shootstyle == "full")
      self fireuntiloutofammo(animarray(animprefix + "fire"), 1, animscripts\shared::decidenumshotsforfull());
    else if(self.shootstyle == "burst" || self.shootstyle == "single" || self.shootstyle == "semi") {
      numshots = 1;

      if(self.shootstyle == "burst" || self.shootstyle == "semi")
        numshots = animscripts\shared::decidenumshotsforburst();

      if(numshots == 1)
        self fireuntiloutofammo(animarraypickrandom(animprefix + "single"), 1, numshots);
      else
        self fireuntiloutofammo(animarray(animprefix + self.shootstyle + numshots), 1, numshots);
    } else {
      assert(self.shootstyle == "none");
      self waittill("hell freezes over");
    }

    if(!self.bulletsinclip) {
      break;
    }

    if(animscripts\shared::shouldswitchweapons()) {
      self notify("need_to_switch_weapons");
      break;
    }

    burstcount--;

    if(burstcount < 0) {
      self.shouldreturntocover = 1;
      break;
    }
  }

  self notify("shoot_burst_done");

  self animscripts\debug::debugpopstate("shootUntilShootBehaviorChange");
}

getuniqueflagnameindex() {
  anim.animflagnameindex++;
  return anim.animflagnameindex;
}

#using_animtree("generic_human");

fireuntiloutofammo(fireanim, stoponanimationend, maxshots) {
  self animscripts\debug::debugpushstate("FireUntilOutOfAmmo", self.shootstyle + " (" + maxshots + " of " + self.bulletsinclip + ")");

  animname = "fireAnim_" + getuniqueflagnameindex();
  maps\_gameskill::resetmisstime();

  while(!aimedatshootentorpos())
    wait 0.05;

  self startshoot();
  self setanim( % add_fire, 1, 0.1, 1);
  rate = randomfloatrange(0.3, 2.0);

  if(self.shootstyle == "full" || self.shootstyle == "burst") {
    rate = animscripts\weaponlist::autoshootanimrate();

    if(rate > 1.999)
      rate = 1.999;
  } else if(isDefined(self.shootent) && isDefined(self.shootent.magic_bullet_shield))
    rate = 0.25;
  else if(is_rusher() && self.rushertype == "pistol")
    rate = 2.0;

  if(weaponisgasweapon(self.weapon))
    rate = 1.0;
  else if(self usingshotgun())
    rate = 1.0;
  else if(self usingrocketlauncher())
    rate = 1.0;

  self setflaggedanimknobrestart(animname, fireanim, 1, 0.2, rate);
  self updateplayersightaccuracy();
  fireuntiloutofammointernal(animname, fireanim, stoponanimationend, maxshots);
  self clearanim( % add_fire, 0.2);
}

fireuntiloutofammointernal(animname, fireanim, stoponanimationend, maxshots) {
  self endon("enemy");

  if(isplayer(self.enemy) && (self.shootstyle == "full" || self.shootstyle == "semi"))
    level endon("player_becoming_invulnerable");

  if(stoponanimationend) {
    self thread notifyonanimend(animname, "fireAnimEnd");
    self endon("fireAnimEnd");
  }

  if(!isDefined(maxshots))
    maxshots = -1;

  numshots = 0;
  hasfirenotetrack = animhasnotetrack(fireanim, "fire");
  usingrocketlauncher = self.weaponclass == "rocketlauncher";

  while(true) {
    if(hasfirenotetrack)
      self waittillmatch(animname, "fire");

    if(numshots == maxshots) {
      break;
    }

    if(!self.bulletsinclip) {
      if(!cheatammoifnecessary()) {
        break;
      }
    }

    if(aimedatshootentorpos() && gettime() > self.a.lastshoottime) {
      self shootatshootentorpos();
      assert(self.bulletsinclip >= 0, self.bulletsinclip);

      if(isplayer(self.enemy) && flag("player_is_invulnerable")) {
        if(randomint(3) == 0)
          self.bulletsinclip--;
      } else
        self.bulletsinclip--;

      if(usingrocketlauncher) {
        self.a.rockets--;

        if(!issubstr(self.weapon, "us") && issubstr(self.weapon, "rpg")) {
          self hidepart("tag_rocket");
          self.a.rocketvisible = 0;
        }
      }

      if(usinggrenadelauncher())
        self.bulletsinclip = 0;
    }

    numshots++;
    self thread shotgunpumpsound(animname);

    if(self.fastburst && numshots == maxshots) {
      break;
    }

    if(!hasfirenotetrack)
      self waittillmatch(animname, "end");
  }

  if(stoponanimationend)
    self notify("fireAnimEnd");
}

aimedatshootentorpos() {
  tag_weapon = self gettagorigin("tag_weapon");

  if(!isDefined(tag_weapon))
    return false;

  if(!isDefined(self.shootpos)) {
    assert(!isDefined(self.shootent));
    return true;
  }

  weaponangles = self gettagangles("tag_weapon");
  anglestoshootpos = vectortoangles(self.shootpos - tag_weapon);

  absyawdiff = absangleclamp180(weaponangles[1] - anglestoshootpos[1]);

  if(absyawdiff > self.aimthresholdyaw) {
    if(distancesquared(self getshootatpos(), self.shootpos) > 4096 || absyawdiff > 45)
      return false;
  }

  return absangleclamp180(weaponangles[0] - anglestoshootpos[0]) <= self.aimthresholdpitch;
}

notifyonanimend(animnotify, endnotify) {
  self endon("killanimscript");
  self endon(endnotify);
  self waittillmatch(animnotify, "end");
  self notify(endnotify);
}

shootatshootentorpos() {
  if(isDefined(self.shoot_notify))
    self notify(self.shoot_notify);

  if(isDefined(self.shootent)) {
    if(isDefined(self.enemy) && self.shootent == self.enemy)
      self shootenemywrapper();
  } else {
    assert(isDefined(self.shootpos));
    self shootposwrapper(self.shootpos);
  }
}

showrocket() {
  if(!issubstr(self.weapon, "us") && issubstr(self.weapon, "rpg")) {
    self.a.rocketvisible = 1;
    self showpart("tag_rocket");
    self notify("showing_rocket");
  }
}

showrocketwhenreloadisdone() {
  if(self.weapon != "rpg") {
    return;
  }
  self endon("death");
  self endon("showing_rocket");
  self waittill("killanimscript");
  self showrocket();
}

decrementbulletsinclip() {
  if(self.bulletsinclip)
    self.bulletsinclip--;
}

shotgunpumpsound(animname) {
  if(!self usingshotgun()) {
    return;
  }
  self endon("killanimscript");
  self notify("shotgun_pump_sound_end");
  self endon("shotgun_pump_sound_end");
  self thread stopshotgunpumpaftertime(2.0);
  self waittillmatch(animname, "rechamber");
  self playsound("wpn_shotgun_pump");
  self notify("shotgun_pump_sound_end");
}

stopshotgunpumpaftertime(timer) {
  self endon("killanimscript");
  self endon("shotgun_pump_sound_end");
  wait(timer);
  self notify("shotgun_pump_sound_end");
}

needtoreload(thresholdfraction) {
  if(shouldforcebehavior("reload"))
    return true;

  if(isDefined(self.noreload)) {
    assert(self.noreload, ".noreload must be true or undefined");

    if(self.bulletsinclip < weaponclipsize(self.weapon) * 0.5)
      self.bulletsinclip = int(weaponclipsize(self.weapon) * 0.5);

    return false;
  }

  if(self.weapon == "none")
    return false;

  if(self.bulletsinclip <= weaponclipsize(self.weapon) * thresholdfraction) {
    if(thresholdfraction == 0) {
      if(cheatammoifnecessary())
        return false;
    }

    return true;
  }

  return false;
}

putgunbackinhandonkillanimscript() {
  self endon("weapon_switch_done");
  self endon("death");
  self notify("put gun back in hand end unique");
  self endon("put gun back in hand end unique");
  self waittill("killanimscript");
  animscripts\shared::placeweaponon(self.primaryweapon, "right");
}

reload(thresholdfraction, optionalanimation) {
  if(weaponisgasweapon(self.weapon))
    return flamethrower_reload();

  self endon("killanimscript");

  if(!needtoreload(thresholdfraction))
    return 0;

  self maps\_dds::dds_notify_reload(undefined, self.team == "allies");

  if(isDefined(optionalanimation)) {
    self clearanim( % body, 0.1);
    self setflaggedanimknoball("reloadanim", optionalanimation, % body, 1, 0.1, 1);
    animscripts\shared::donotetracks("reloadanim");
    self animscripts\weaponlist::refillclip();
  } else {
    if(self.a.pose == "prone") {
      self setflaggedanimknoball("reloadanim", animarraypickrandom("reload"), % body, 1, 0.1, 1);
      self updateprone( % prone_legs_up, % prone_legs_down, 1, 0.1, 1);
    } else {
      println("Bad anim_pose in combat::Reload");

      wait 2;
      return;
    }

    animscripts\shared::donotetracks("reloadanim");
    animscripts\weaponlist::refillclip();
    self clearanim( % upperbody, 0.1);
  }

  return 1;
}

flamethrower_reload() {
  wait 0.05;
  self animscripts\weaponlist::refillclip();
  return true;
}

getgrenadethrowoffset(throwanim) {
  assert(isDefined(anim.grenadethrowoffsets));
  assert(isDefined(anim.grenadethrowoffsets[throwanim]), "Grenade throwing anim " + throwanim + " has no grenade offset defined. Add to precache_grenade_offsets()");

  if(isDefined(anim.grenadethrowoffsets[throwanim]))
    return anim.grenadethrowoffsets[throwanim];

  return vectorscale((0, 0, 1), 64.0);
}

throwgrenadeatenemyasap_combat_utility(enemy) {
  if(!isDefined(enemy) || isDefined(enemy) && isplayer(enemy)) {
    if(anim.numgrenadesinprogresstowardsplayer == 0) {
      anim.grenadetimers["player_frag_grenade_sp"] = 0;
      anim.grenadetimers["player_flash_grenade_sp"] = 0;
    }

    anim.throwgrenadeatplayerasap = 1;
  } else
    anim.throwgrenadeatenemyasap = 1;

  enemies = getaiarray("axis", "team3");

  if(enemies.size == 0) {
    return;
  }
  for(i = 0; i < enemies.size; i++) {
    if(enemies[i].grenadeammo > 0)
      return;
  }

  println("^1Warning: called ThrowGrenadeAtEnemyASAP, but no enemies have any grenadeammo!");
}

setactivegrenadetimer(throwingat) {
  if(isplayer(throwingat))
    self.activegrenadetimer = "player_" + self.grenadeweapon;
  else
    self.activegrenadetimer = "AI_" + self.grenadeweapon;

  if(!isDefined(anim.grenadetimers[self.activegrenadetimer]))
    anim.grenadetimers[self.activegrenadetimer] = randomintrange(1000, 20000);
}

considerchangingtarget(throwingat) {
  if(!isplayer(throwingat) && self.team == "axis" || self.team == "team3") {
    players = getplayers();

    for(i = 0; i < players.size; i++) {
      player = players[i];

      if(gettime() < anim.grenadetimers[self.activegrenadetimer]) {
        if(player isnotarget())
          return throwingat;

        mygroup = self getthreatbiasgroup();
        playergroup = player getthreatbiasgroup();

        if(mygroup != "" && playergroup != "" && getthreatbias(playergroup, mygroup) < -10000)
          return throwingat;

        if(self cansee(player) || isai(throwingat) && throwingat cansee(player)) {
          if(isDefined(self.covernode)) {
            angles = vectortoangles(player.origin - self.origin);
            yawdiff = angleclamp180(self.covernode.angles[1] - angles[1]);
          } else
            yawdiff = self getyawtospot(player.origin);

          if(abs(yawdiff) < 60) {
            throwingat = player;
            self setactivegrenadetimer(throwingat);
          }
        }
      }
    }
  }

  return throwingat;
}

usingplayergrenadetimer() {
  return self.activegrenadetimer == "player_" + self.grenadeweapon;
}

setgrenadetimer(grenadetimer, newvalue) {
  oldvalue = anim.grenadetimers[grenadetimer];
  anim.grenadetimers[grenadetimer] = max(newvalue, oldvalue);
}

getdesiredgrenadetimervalue() {
  nextgrenadetimetouse = undefined;

  if(self usingplayergrenadetimer())
    nextgrenadetimetouse = gettime() + anim.playergrenadebasetime + randomint(anim.playergrenaderangetime);
  else
    nextgrenadetimetouse = gettime() + 40000 + randomint(60000);

  return nextgrenadetimetouse;
}

maythrowdoublegrenade() {
  assert(self.activegrenadetimer == "player_frag_grenade_sp");

  if(player_died_recently())
    return false;

  if(!anim.double_grenades_allowed)
    return false;

  if(gettime() < anim.grenadetimers["player_double_grenade"])
    return false;

  if(gettime() > anim.lastfraggrenadetoplayerstart + 3000)
    return false;

  if(gettime() > anim.lastfraggrenadetoplayerstart + 500)
    return false;

  return anim.numgrenadesinprogresstowardsplayer < 2;
}

mygrenadecooldownelapsed() {
  if(self.script_forcegrenade == 1)
    return true;

  if(self.grenadeammo <= 0)
    return false;

  return gettime() >= self.a.nextgrenadetrytime;
}

grenadecooldownelapsed() {
  if(self.script_forcegrenade == 1)
    return true;

  if(shouldforcebehavior("grenade"))
    return true;

  if(player_died_recently())
    return false;

  if(!mygrenadecooldownelapsed())
    return false;

  if(gettime() >= anim.grenadetimers[self.activegrenadetimer])
    return true;

  return false;
}

printgrenadetimers() {
  level notify("stop_printing_grenade_timers");
  level endon("stop_printing_grenade_timers");
  y = 40;
  level.grenadetimerhudelem = [];
  keys = getarraykeys(anim.grenadetimers);

  for(i = 0; i < keys.size; i++) {
    textelem = newhudelem();
    textelem.x = 40;
    textelem.y = y;
    textelem.alignx = "left";
    textelem.aligny = "top";
    textelem.horzalign = "fullscreen";
    textelem.vertalign = "fullscreen";
    textelem settext(keys[i]);
    bar = newhudelem();
    bar.x = 40 + 110;
    bar.y = y + 2;
    bar.alignx = "left";
    bar.aligny = "top";
    bar.horzalign = "fullscreen";
    bar.vertalign = "fullscreen";
    bar setshader("black", 1, 8);
    textelem.bar = bar;
    textelem.key = keys[i];
    y = y + 10;
    level.grenadetimerhudelem[keys[i]] = textelem;
  }

  while(true) {
    wait 0.05;

    for(i = 0; i < keys.size; i++) {
      timeleft = (anim.grenadetimers[keys[i]] - gettime()) / 1000;
      width = max(timeleft * 4, 1);
      width = int(width);
      bar = level.grenadetimerhudelem[keys[i]].bar;
      bar setshader("black", width, 8);
    }
  }

}

destroygrenadetimers() {
  if(!isDefined(level.grenadetimerhudelem)) {
    return;
  }
  keys = getarraykeys(anim.grenadetimers);

  for(i = 0; i < keys.size; i++) {
    level.grenadetimerhudelem[keys[i]].bar destroy();
    level.grenadetimerhudelem[keys[i]] destroy();
  }

}

grenadetimerdebug() {
  if(getdvar(#"_id_A084BFE8") == "")
    setdvar("scr_grenade_debug", "0");

  while(true) {
    while(true) {
      if(getdebugdvar("scr_grenade_debug") != "0") {
        break;
      }

      wait 0.5;
    }

    thread printgrenadetimers();

    while(true) {
      if(getdebugdvar("scr_grenade_debug") == "0") {
        break;
      }

      wait 0.5;
    }

    level notify("stop_printing_grenade_timers");
    destroygrenadetimers();
  }

}

grenadedebug(state, duration, showmissreason) {
  if(getdebugdvar("scr_grenade_debug") == "0") {
    return;
  }
  self notify("grenade_debug");
  self endon("grenade_debug");
  self endon("killanimscript");
  self endon("death");
  endtime = gettime() + 1000 * duration;

  while(gettime() < endtime) {
    print3d(self getshootatpos() + vectorscale((0, 0, 1), 10.0), state);

    if(isDefined(showmissreason) && isDefined(self.grenademissreason))
      print3d(self getshootatpos() + (0, 0, 0), "Failed: " + self.grenademissreason);
    else if(isDefined(self.activegrenadetimer))
      print3d(self getshootatpos() + (0, 0, 0), "Timer: " + self.activegrenadetimer);

    wait 0.05;
  }

}

setgrenademissreason(reason) {
  if(getdebugdvar("scr_grenade_debug") == "0") {
    return;
  }
  self.grenademissreason = reason;
}

trygrenadeposproc(destination, optionalanimation, armoffset) {
  if(!self isgrenadepossafe(destination)) {
    self animscripts\debug::debugpopstate(undefined, "teammates near target");

    return 0;
  } else if(distancesquared(self.origin, destination) < 40000) {
    self animscripts\debug::debugpopstate(undefined, "too close (<200)");

    return 0;
  }

  trace = physicstrace(destination + (0, 0, 1), destination + vectorscale((0, 0, -1), 500.0));

  if(trace == destination + vectorscale((0, 0, -1), 500.0)) {
    self animscripts\debug::debugpopstate(undefined, "no ground under target");

    return 0;
  }

  trace = trace + vectorscale((0, 0, 1), 0.1);
  return trygrenadethrow(trace, optionalanimation, armoffset);
}

checkgrenadethrowdist() {
  diff = self.enemy.origin - self.origin;
  dist = length((diff[0], diff[1], 0));
  distsq = lengthsquared((diff[0], diff[1], 0));
  return distsq >= anim.combatglobals.min_exposed_grenade_distsq && distsq <= anim.combatglobals.max_grenade_throw_distsq;
}

trygrenade(throwingat, optionalanimation, forcethrow) {
  forcethrow = isDefined(forcethrow) && forcethrow;
  self setactivegrenadetimer(throwingat);
  throwingat = considerchangingtarget(throwingat);

  if(!forcethrow && !grenadecooldownelapsed()) {
    self animscripts\debug::debugpopstate(undefined, "cooldown from last throw");

    return 0;
  }

  self thread grenadedebug("Tried grenade throw", 4, 1);

  armoffset = getgrenadethrowoffset(optionalanimation);

  if(isDefined(self.enemy) && throwingat == self.enemy) {
    if(!checkgrenadethrowdist()) {
      self animscripts\debug::debugpopstate(undefined, "Too close or too far");

      self setgrenademissreason("Too close or too far");

      return 0;
    }

    if(self canseeenemyfromexposed()) {
      if(!self isgrenadepossafe(throwingat.origin)) {
        self animscripts\debug::debugpopstate(undefined, "teammates near target");

        self setgrenademissreason("Teammates near target");

        return 0;
      }

      return trygrenadethrow(undefined, optionalanimation, armoffset);
    } else if(self cansuppressenemyfromexposed())
      return trygrenadeposproc(self getenemysightpos(), optionalanimation, armoffset);
    else {
      if(!self isgrenadepossafe(throwingat.origin)) {
        self animscripts\debug::debugpopstate(undefined, "teammates near target");

        self setgrenademissreason("Teammates near target");

        return 0;
      }

      return trygrenadethrow(undefined, optionalanimation, armoffset);
    }

    self animscripts\debug::debugpopstate(undefined, "don't know where to throw");

    self setgrenademissreason("Don't know where to throw");

    return 0;
  } else
    return trygrenadeposproc(throwingat.origin, optionalanimation, armoffset);
}

trygrenadethrow(destination, optionalanimation, armoffset) {
  if(weaponisgasweapon(self.weapon)) {
    self animscripts\debug::debugpopstate(undefined, "using gas weapon");

    return false;
  }

  if(gettime() < 10000) {
    self animscripts\debug::debugpopstate(undefined, "first 10 seconds of game");

    self setgrenademissreason("First 10 seconds of game");

    return false;
  }

  if(isDefined(optionalanimation)) {
    throw_anim = optionalanimation;
    gunhand = self.a.gunhand;
  } else {
    switch (self.a.special) {
      case "cover_crouch":
      case "none":
        if(self.a.pose == "stand") {
          armoffset = vectorscale((0, 0, 1), 80.0);
          throw_anim = animarray("grenade_throw");
        } else {
          armoffset = vectorscale((0, 0, 1), 65.0);
          throw_anim = animarray("grenade_throw");
        }

        gunhand = "left";
        break;
      default:
        throw_anim = undefined;
        gunhand = undefined;
        break;
    }
  }

  if(!isDefined(throw_anim)) {
    self animscripts\debug::debugpopstate(undefined, "no throw anim");

    return false;
  }

  if(isDefined(destination)) {
    throwvel = self checkgrenadethrowpos(armoffset, "min energy", destination);

    if(!isDefined(throwvel))
      throwvel = self checkgrenadethrowpos(armoffset, "min time", destination);

    if(!isDefined(throwvel))
      throwvel = self checkgrenadethrowpos(armoffset, "max time", destination);
  } else {
    throwvel = self checkgrenadethrow(armoffset, "min energy", self.randomgrenaderange);

    if(!isDefined(throwvel))
      throwvel = self checkgrenadethrow(armoffset, "min time", self.randomgrenaderange);

    if(!isDefined(throwvel))
      throwvel = self checkgrenadethrow(armoffset, "max time", self.randomgrenaderange);
  }

  self.a.nextgrenadetrytime = gettime() + randomintrange(1000, 2000);

  if(isDefined(throwvel)) {
    if(!isDefined(self.oldgrenawareness))
      self.oldgrenawareness = self.grenadeawareness;

    self.grenadeawareness = 0;

    if(getdebugdvar("anim_debug") == "1")
      thread animscripts\utility::debugpos(destination, "O");

    nextgrenadetimetouse = self getdesiredgrenadetimervalue();
    setgrenadetimer(self.activegrenadetimer, min(gettime() + 3000, nextgrenadetimetouse));
    secondgrenadeofdouble = 0;

    if(self usingplayergrenadetimer()) {
      anim.numgrenadesinprogresstowardsplayer++;
      self thread reducegiptponkillanimscript();

      if(anim.numgrenadesinprogresstowardsplayer > 1)
        secondgrenadeofdouble = 1;
    }

    if(self.activegrenadetimer == "player_frag_grenade_sp" && anim.numgrenadesinprogresstowardsplayer <= 1)
      anim.lastfraggrenadetoplayerstart = gettime();

    if(getdvar(#"_id_9CBC5AEB") == "on")
      nextgrenadetimetouse = 0;

    dogrenadethrow(throw_anim, nextgrenadetimetouse, secondgrenadeofdouble);

    self animscripts\debug::debugpopstate(undefined, "success");

    return true;
  } else {
    self setgrenademissreason("Couldn't find trajectory");

    if(getdebugdvar("debug_grenademiss") == "on" && isDefined(destination))
      thread grenadeline(armoffset, destination);

  }

  self animscripts\debug::debugpopstate(undefined, "couldn't find suitable trajectory");

  return false;
}

reducegiptponkillanimscript() {
  self endon("dont_reduce_giptp_on_killanimscript");
  self waittill("killanimscript");
  anim.numgrenadesinprogresstowardsplayer--;
}

dogrenadethrow(throw_anim, nextgrenadetimetouse, secondgrenadeofdouble) {
  self thread grenadedebug("Starting throw", 3);

  self notify("stop_aiming_at_enemy");
  self setflaggedanimknoballrestart("throwanim", throw_anim, % body, 1, 0.1, 1);
  self thread animscripts\shared::donotetracksforever("throwanim", "killanimscript");
  model = getweaponmodel(self.grenadeweapon);
  attachside = "none";

  for(;;) {
    self waittill("throwanim", notetrack);

    if(notetrack == "grenade_left" || notetrack == "grenade_right") {
      attachside = attachgrenademodel(model, "TAG_INHAND");
      self.isholdinggrenade = 1;
    }

    if(notetrack == "grenade_throw" || notetrack == "grenade throw") {
      break;
    }

    assert(notetrack != "end");

    if(notetrack == "end") {
      anim.numgrenadesinprogresstowardsplayer--;
      self notify("dont_reduce_giptp_on_killanimscript");
      return false;
    }
  }

  if(getdebugdvar("debug_grenadehand") == "on") {
    tags = [];
    numtags = self getattachsize();
    emptyslot = [];

    for(i = 0; i < numtags; i++) {
      name = self getattachmodelname(i);

      if(issubstr(name, "weapon")) {
        tagname = self getattachtagname(i);
        emptyslot[tagname] = 0;
        tags[tags.size] = tagname;
      }
    }

    for(i = 0; i < tags.size; i++) {
      emptyslot[tags[i]]++;

      if(emptyslot[tags[i]] < 2) {
        continue;
      }
      iprintlnbold("Grenade throw needs fixing (check console)");
      println("Grenade throw animation ", throw_anim, " has multiple weapons attached to ", tags[i]);
      break;
    }
  }

  self thread grenadedebug("Threw", 5);

  self notify("dont_reduce_giptp_on_killanimscript");

  if(self usingplayergrenadetimer())
    self thread watchgrenadetowardsplayer(nextgrenadetimetouse);
  else {
    level notify("threw_grenade_at_enemy");
    self notify("threw_grenade_at_enemy");
    anim.throwgrenadeatenemyasap = undefined;
  }

  self maps\_dds::dds_notify_grenade(self.grenadeweapon, self.team == "allies", 0);
  self throwgrenade();

  if(!self usingplayergrenadetimer())
    setgrenadetimer(self.activegrenadetimer, nextgrenadetimetouse);

  if(secondgrenadeofdouble) {
    if(anim.numgrenadesinprogresstowardsplayer > 1 || gettime() - anim.lastgrenadelandednearplayertime < 2000)
      anim.grenadetimers["player_double_grenade"] = gettime() + min(5000, anim.playerdoublegrenadetime);
  }

  self notify("stop grenade check");

  if(attachside != "none")
    self detach(model, attachside);
  else {
    print("No grenade hand set: ");
    println(throw_anim);
    println("animation in console does not specify grenade hand");

  }

  self.isholdinggrenade = undefined;
  self.grenadeawareness = self.oldgrenawareness;
  self.oldgrenawareness = undefined;
  self waittillmatch("throwanim", "end");
  self setanim( % exposed_modern, 1, 0.2);
  self setanim( % exposed_aiming, 1);
  self clearanim(throw_anim, 0.2);
}

watchgrenadetowardsplayer(nextgrenadetimetouse) {
  watchgrenadetowardsplayerinternal(nextgrenadetimetouse);
  anim.numgrenadesinprogresstowardsplayer--;
}

watchgrenadetowardsplayerinternal(nextgrenadetimetouse) {
  activegrenadetimer = self.activegrenadetimer;
  timeoutobj = spawnstruct();
  timeoutobj thread watchgrenadetowardsplayertimeout(5);
  timeoutobj endon("watchGrenadeTowardsPlayerTimeout");
  type = self.grenadeweapon;
  grenade = self getgrenadeithrew();

  if(!isDefined(grenade)) {
    return;
  }
  setgrenadetimer(activegrenadetimer, min(gettime() + 5000, nextgrenadetimetouse));

  grenade thread grenadedebug("Incoming", 5);

  goodradiussqrd = 62500;
  giveupradiussqrd = 160000;

  if(type == "flash_grenade") {
    goodradiussqrd = 810000;
    giveupradiussqrd = 1690000;
  }

  players = getplayers();

  for(prevorigin = grenade.origin; 1; prevorigin = grenade.origin) {
    wait 0.1;

    if(!isDefined(grenade)) {
      break;
    }

    if(grenade.origin == prevorigin) {
      if(distancesquared(grenade.origin, players[0].origin) < goodradiussqrd || distancesquared(grenade.origin, players[0].origin) > giveupradiussqrd) {
        break;
      }
    }
  }

  grenadeorigin = prevorigin;

  if(isDefined(grenade))
    grenadeorigin = grenade.origin;

  if(distancesquared(grenadeorigin, players[0].origin) < goodradiussqrd) {
    if(isDefined(grenade))
      grenade thread grenadedebug("Landed near player", 5);

    level notify("threw_grenade_at_player");
    anim.throwgrenadeatplayerasap = undefined;

    if(gettime() - anim.lastgrenadelandednearplayertime < 3000)
      anim.grenadetimers["player_double_grenade"] = gettime() + anim.playerdoublegrenadetime;

    anim.lastgrenadelandednearplayertime = gettime();
    setgrenadetimer(activegrenadetimer, nextgrenadetimetouse);
  } else {
    if(isDefined(grenade))
      grenade thread grenadedebug("Missed", 5);

  }
}

getgrenadeithrew() {
  self endon("killanimscript");
  self waittill("grenade_fire", grenade);
  return grenade;
}

watchgrenadetowardsplayertimeout(timerlength) {
  wait(timerlength);
  self notify("watchGrenadeTowardsPlayerTimeout");
}

attachgrenademodel(model, tag) {
  self attach(model, tag);
  thread detachgrenadeonscriptchange(model, tag);
  return tag;
}

detachgrenadeonscriptchange(model, tag) {
  self endon("stop grenade check");
  self waittill("killanimscript");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.oldgrenawareness)) {
    self.grenadeawareness = self.oldgrenawareness;
    self.oldgrenawareness = undefined;
  }

  self detach(model, tag);
}

offsettoorigin(start) {
  forward = anglestoforward(self.angles);
  right = anglestoright(self.angles);
  up = anglestoup(self.angles);
  forward = vectorscale(forward, start[0]);
  right = vectorscale(right, start[1]);
  up = vectorscale(up, start[2]);
  return forward + right + up;
}

grenadeline(start, end) {
  level notify("armoffset");
  level endon("armoffset");
  start = self.origin + offsettoorigin(start);

  for(;;) {
    line(start, end, (1, 0, 1));
    print3d(start, start, (0.2, 0.5, 1.0), 1, 1);
    print3d(end, end, (0.2, 0.5, 1.0), 1, 1);
    wait 0.05;
  }

}

getgrenadedropvelocity() {
  yaw = randomfloat(360);
  pitch = randomfloatrange(30, 75);
  amntz = sin(pitch);
  cospitch = cos(pitch);
  amntx = cos(yaw) * cospitch;
  amnty = sin(yaw) * cospitch;
  speed = randomfloatrange(100, 200);
  velocity = (amntx, amnty, amntz) * speed;
  return velocity;
}

dropgrenade() {
  grenadeorigin = self gettagorigin("tag_inhand");
  velocity = getgrenadedropvelocity();
  self magicgrenademanual(grenadeorigin, velocity, 3);
}

lookforbettercover(checkenemy) {
  if(!isDefined(checkenemy))
    checkenemy = 1;

  if(checkenemy && !isvalidenemy(self.enemy))
    return 0;

  if(self.fixednode || self.doingambush)
    return 0;

  node = self getbestcovernodeifavailable();

  if(isDefined(node))
    return usecovernodeifpossible(node);

  return 0;
}

getbestcovernodeifavailable() {
  node = self findbestcovernode();

  if(!isDefined(node)) {
    recordenttext("FindBestCoverNode from getBestCoverNodeIfAvailable (fail1)", self, level.color_debug["white"], "Cover");

    return undefined;
  }

  currentnode = self getclaimednode();

  if(isDefined(currentnode) && node == currentnode) {
    recordenttext("FindBestCoverNode from getBestCoverNodeIfAvailable (fail2)", self, level.color_debug["white"], "Cover");

    return undefined;
  }

  if(isDefined(self.covernode) && node == self.covernode) {
    recordenttext("FindBestCoverNode from getBestCoverNodeIfAvailable (fail3)", self, level.color_debug["white"], "Cover");

    return undefined;
  }

  recordenttext("FindBestCoverNode from getBestCoverNodeIfAvailable (success)", self, level.color_debug["white"], "Cover");

  return node;
}

usecovernodeifpossible(node) {
  oldkeepnodeingoal = self.keepclaimednodeifvalid;
  oldkeepnode = self.keepclaimednode;
  self.keepclaimednodeifvalid = 0;
  self.keepclaimednode = 0;

  if(self usecovernode(node))
    return true;
  else {
    self thread debugfailedcoverusage(node);

  }

  self.keepclaimednodeifvalid = oldkeepnodeingoal;
  self.keepclaimednode = oldkeepnode;
  return false;
}

debugfailedcoverusage(node) {
  if(getdvar(#"_id_88718E17") == "")
    setdvar("scr_debugfailedcover", "0");

  if(getdebugdvarint("scr_debugfailedcover") == 1) {
    self endon("death");

    for(i = 0; i < 20; i++) {
      line(self.origin, node.origin);
      print3d(node.origin, "failed");
      wait 0.05;
    }
  }

}

tryrunningtoenemy(ignoresuppression) {
  if(isDefined(self.a.disablereacquire) && self.a.disablereacquire)
    return false;

  if(!isvalidenemy(self.enemy))
    return false;

  if(self.enemy isvehicle() || isai(self.enemy) && self.enemy.isbigdog)
    return false;

  if(self.fixednode)
    return false;

  if(self.combatmode == "ambush" || self.combatmode == "ambush_nodes_only")
    return false;

  if(self isingoal(self.enemy.origin))
    self findreacquiredirectpath(ignoresuppression);
  else
    self findreacquireproximatepath(ignoresuppression);

  if(self reacquiremove()) {
    self.keepclaimednodeifvalid = 0;
    self.keepclaimednode = 0;
    self.a.magicreloadwhenreachenemy = 1;
    return true;
  }

  return false;
}

getgunyawtoshootentorpos() {
  if(!isDefined(self.shootpos)) {
    assert(!isDefined(self.shootent));
    return 0;
  }

  yaw = self gettagangles("tag_weapon")[1] - vectortoangles(self.shootpos - self.origin)[1];
  yaw = angleclamp180(yaw);
  return yaw;
}

getgunpitchtoshootentorpos() {
  if(!isDefined(self.shootpos)) {
    assert(!isDefined(self.shootent));
    return 0;
  }

  pitch = self gettagangles("tag_weapon")[0] - vectortoangles(self.shootpos - self gettagorigin("tag_weapon"))[0];
  pitch = angleclamp180(pitch);
  return pitch;
}

getpitchtoenemy() {
  if(!isDefined(self.enemy))
    return 0;

  vectortoenemy = self.enemy getshootatpos() - self getshootatpos();
  vectortoenemy = vectornormalize(vectortoenemy);
  pitchdelta = 360 - vectortoangles(vectortoenemy)[0];
  return angleclamp180(pitchdelta);
}

getpitchtospot(spot) {
  if(!isDefined(spot))
    return 0;

  vectortoenemy = spot - self getshootatpos();
  vectortoenemy = vectornormalize(vectortoenemy);
  pitchdelta = 360 - vectortoangles(vectortoenemy)[0];
  return angleclamp180(pitchdelta);
}

watchreloading() {
  self.isreloading = 0;

  while(true) {
    self waittill("reload_start");
    self maps\_dds::dds_notify_reload(self getcurrentweapon(), self.team == "allies");
    self.isreloading = 1;
    self waittillreloadfinished();
    self.isreloading = 0;
  }
}

waittillreloadfinished() {
  self thread timednotify(4, "reloadtimeout");
  self endon("reloadtimeout");

  while(true) {
    self waittill("reload");
    weap = self getcurrentweapon();

    if(weap == "none") {
      break;
    }

    if(self getcurrentweaponclipammo() >= weaponclipsize(weap)) {
      break;
    }
  }

  self notify("reloadtimeout");
}

timednotify(time, msg) {
  self endon(msg);
  wait(time);
  self notify(msg);
}

attackenemywhenflashed() {
  self endon("killanimscript");

  while(true) {
    if(!isDefined(self.enemy) || !isalive(self.enemy) || !issentient(self.enemy)) {
      self waittill("enemy");
      continue;
    }

    attackspecificenemywhenflashed();
  }
}

attackspecificenemywhenflashed() {
  self endon("enemy");
  self.enemy endon("death");

  if(isDefined(self.enemy.flashendtime) && gettime() < self.enemy.flashendtime)
    trytoattackflashedenemy();

  while(true) {
    self.enemy waittill("flashed");
    trytoattackflashedenemy();
  }
}

trytoattackflashedenemy() {
  if(self.enemy.flashingteam != self.team) {
    return;
  }
  if(distancesquared(self.origin, self.enemy.origin) > 1048576) {
    return;
  }
  while(gettime() < self.enemy.flashendtime - 500) {
    if(!self cansee(self.enemy) && distancesquared(self.origin, self.enemy.origin) < 640000)
      tryrunningtoenemy(1);

    wait 0.05;
  }
}

startflashbanged() {
  if(isDefined(self.flashduration))
    duration = self.flashduration * 1000;
  else
    duration = self getflashbangedstrength() * 1000;

  self.flashendtime = gettime() + duration;
  self notify("flashed");
  return duration;
}

monitorflashorstun() {
  self endon("death");
  self endon("stop_monitoring_flash");

  while(true) {
    self waittill("flashbang", amount_distance, amount_angle, attacker, attackerteam, weapon);

    if(self.flashbangimmunity) {
      continue;
    }
    if(isDefined(self.script_immunetoflash) && self.script_immunetoflash != 0) {
      continue;
    }
    if(isDefined(self.team) && isDefined(attackerteam) && self.team == attackerteam) {
      amount_distance = 3 * (amount_distance - 0.75);

      if(amount_distance < 0)
        continue;
    }

    if(issubstr(weapon, "emp") || issubstr(weapon, "concussion") || issubstr(weapon, "proximity")) {
      if(isstunned()) {
        continue;
      }
      if(isplayer(attacker))
        attacker thread maps\_damagefeedback::updatedamagefeedback();

      self.flashingteam = attackerteam;
      self.flashduration = 5;
      self setflashbanged(1, 5);
      self notify("doFlashBanged", attacker);

      if(issubstr(weapon, "emp"))
        self notify("doEmpBehavior", attacker, 5);
      else if(issubstr(weapon, "proximity"))
        self thread proximitygrenadeaireactionfx(5);
    } else {
      if(amount_distance > 1 - 0.2)
        amount_distance = 1.0;
      else
        amount_distance = amount_distance / (1 - 0.2);

      duration = 5.5 * amount_distance;

      if(duration < 0.25) {
        continue;
      }
      if(isplayer(attacker))
        attacker thread maps\_damagefeedback::updatedamagefeedback();

      self.flashingteam = attackerteam;
      self setflashbanged(1, duration);
      self notify("doFlashBanged", attacker);
    }
  }
}

proximitygrenadeaireactionfx(duration) {
  self endon("death");

  if(isDefined(self.isbigdog) && self.isbigdog) {
    if(isDefined(anim._effect["bigdog_emped"]))
      playfxontag(anim._effect["bigdog_emped"], self, "tag_body_animate");
  } else if(isDefined(level._effect["prox_grenade_shock"])) {
    playfxontag(level._effect["prox_grenade_shock"], self, "J_SpineUpper");
    wait(duration / 2);
    playfxontag(level._effect["prox_grenade_shock"], self, "J_SpineUpper");
  }
}

issniper() {
  return self.issniper;
}

issniperrifle(weapon) {
  return weaponissniperweapon(weapon);
}

ischargedshotsniperrifle(weapon) {
  return weaponischargeshot(weapon) && weaponissniperweapon(weapon);
}

iscrossbow(weapon) {
  return issubstr(weapon, "crossbow") && !issubstr(weapon, "explosive") || issubstr(weapon, "exptitus6");
}

iscrossbowexplosive(weapon) {
  return issubstr(weapon, "crossbow_explosive_alt") || issubstr(weapon, "exptitus6");
}

getshootanimprefix() {
  if(self.a.script == "cover_left" || self.a.script == "cover_right" || self.a.script == "cover_pillar") {
    if(isDefined(self.corneraiming) && self.corneraiming && isDefined(self.a.cornermode) && self.a.cornermode == "lean")
      return "lean_";
  }

  return "";
}

randomfasteranimspeed() {
  return randomfloatrange(1, 1.1);
}

player_sees_my_scope() {
  start = self geteye();
  players = get_players();

  foreach(player in players) {
    if(!self cansee(player)) {
      continue;
    }
    end = player geteye();
    angles = vectortoangles(start - end);
    forward = anglestoforward(angles);
    player_angles = player getplayerangles();
    player_forward = anglestoforward(player_angles);
    dot = vectordot(forward, player_forward);

    if(dot < 0.805) {
      continue;
    }
    if(cointoss() && dot >= 0.996) {
      continue;
    }
    return true;
  }

  return false;
}