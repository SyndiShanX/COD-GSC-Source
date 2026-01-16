/******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\combat_utility.gsc
******************************************/

gettargetangleoffset(var_0) {
  var_1 = self getshootatpos() + (0, 0, -3);
  var_2 = (var_1[0] - var_0[0], var_1[1] - var_0[1], var_1[2] - var_0[2]);
  var_2 = vectornormalize(var_2);
  var_3 = var_2[2] * -1;
  return var_3;
}

getsniperburstdelaytime() {
  if(isplayer(self.enemy))
    return randomfloatrange(self.enemy.gs.min_sniper_burst_delay_time, self.enemy.gs.max_sniper_burst_delay_time);
  else
    return randomfloatrange(anim.min_sniper_burst_delay_time, anim.max_sniper_burst_delay_time);
}

getremainingburstdelaytime() {
  var_0 = (gettime() - self.a.lastshoottime) / 1000;
  var_1 = getburstdelaytime();

  if(var_1 > var_0)
    return var_1 - var_0;

  return 0;
}

getfastburstdelaytime() {
  if(!isdefined(self.fastburstcount)) {
    self.fastburstcount = 1;
    self.fastburstmodtime = 3;
  }

  var_0 = 0.2;
  var_1 = 0.45;

  if(self.fastburstcount % self.fastburstmodtime == 0) {
    if(randomint(5) < 3) {
      var_0 = 0.45;
      var_1 = 1.0;
    }

    self.fastburstmodtime = randomintrange(2, 5);
  }

  self.fastburstcount++;
  return randomfloatrange(var_0, var_1);
}

getburstdelaytime() {
  if(animscripts\utility::usingsidearm())
    return randomfloatrange(0.15, 0.55);
  else if(animscripts\utility::weapon_pump_action_shotgun())
    return randomfloatrange(1.0, 1.7);
  else if(issniper())
    return getsniperburstdelaytime();
  else if(self.fastburst)
    return getfastburstdelaytime();
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

    var_0 = getremainingburstdelaytime();

    if(var_0)
      wait(var_0);
  }
}

cheatammoifnecessary() {
  setdvarifuninitialized("useCod3AmmoCheating", 1);

  if(getdvarint("useCod3AmmoCheating", 1) == 1)
    return cheatammoifnecessary_cod3();
  else
    return cheatammoifnecessary_h1();
}

cheatammoifnecessary_h1() {
  if(!isdefined(self.enemy))
    return 0;

  if(self.team != "allies") {
    if(!isplayer(self.enemy))
      return 0;

    if(self.enemy maps\_utility::ent_flag("player_is_invulnerable"))
      return 0;
  }

  if(animscripts\utility::usingsidearm() || animscripts\utility::usingrocketlauncher())
    return 0;

  if(gettime() - self.ammocheattime < self.ammocheatinterval)
    return 0;

  if(!self cansee(self.enemy) && distancesquared(self.origin, self.enemy.origin) > 65536)
    return 0;

  self.bulletsinclip = int(weaponclipsize(self.weapon) / 2);

  if(self.bulletsinclip > weaponclipsize(self.weapon))
    self.bulletsinclip = weaponclipsize(self.weapon);

  self.ammocheattime = gettime();
  self notify("cheated_reload_level_stats");
  return 1;
}

cheatammoifnecessary_cod3() {
  if(!isdefined(self.enemy))
    return 0;

  if(self.team != "allies") {
    if(!isplayer(self.enemy))
      return 0;

    if(weaponclipsize(self.weapon) < 15)
      return 0;

    if(self.enemy maps\_utility::ent_flag("player_is_invulnerable"))
      return 0;
  }

  if(animscripts\utility::usingsidearm() || animscripts\utility::usingrocketlauncher())
    return 0;

  if(isdefined(self.nextcheattime) && gettime() < self.nextcheattime)
    return 0;

  if(!self cansee(self.enemy))
    return 0;

  if(animscripts\utility::iscqbwalking())
    self.bulletsinclip = weaponclipsize(self.weapon);
  else
    self.bulletsinclip = 10;

  if(self.bulletsinclip > weaponclipsize(self.weapon))
    self.bulletsinclip = weaponclipsize(self.weapon);

  self.nextcheattime = gettime() + 4000;
  self notify("cheated_reload_level_stats");
  return 1;
}

aimbutdontshoot() {
  for (var_0 = int(60.0); var_0 > 0; var_0--) {
    if(isdefined(self.dontevershoot) || isdefined(self.enemy) && isdefined(self.enemy.dontattackme)) {
      wait 0.05;
      continue;
    }

    return 0;
  }

  return 1;
}

shootuntilshootbehaviorchange() {
  self endon("shoot_behavior_change");
  self endon("stopShooting");

  if(islongrangeai()) {
    if(isdefined(self.enemy) && isai(self.enemy) && distancesquared(level.player.origin, self.enemy.origin) < 147456)
      self.enemy animscripts\battlechatter_ai::addthreatevent("infantry", self, 1.0);

    if(animscripts\utility::usingrocketlauncher() && issentient(self.enemy))
      wait(randomfloat(2.0));
  }

  var_0 = 1;

  for (;;) {
    if(!var_0)
      burstdelay();

    var_0 = 0;

    if(aimbutdontshoot()) {
      break;
    }

    if(self.shootstyle == "full") {
      if(isdefined(self.mech) && self.mech)
        fireuntiloutofammo(animscripts\utility::animarray("fire"), 0, 100);
      else
        fireuntiloutofammo(animscripts\utility::animarray("fire"), 1, animscripts\shared::decidenumshotsforfull());
    } else if(self.shootstyle == "burst" || self.shootstyle == "semi") {
      var_1 = animscripts\shared::decidenumshotsforburst();

      if(var_1 == 1)
        fireuntiloutofammo(animscripts\utility::animarraypickrandom("single"), 1, var_1);
      else
        fireuntiloutofammo(animscripts\utility::animarray(self.shootstyle + var_1), 1, var_1);
    } else if(self.shootstyle == "single")
      fireuntiloutofammo(animscripts\utility::animarraypickrandom("single"), 1, 1);
    else
      self waittill("hell freezes over");

    if(!self.bulletsinclip) {
      break;
    }
  }
}

getuniqueflagnameindex() {
  anim.animflagnameindex++;
  return anim.animflagnameindex;
}

#using_animtree("generic_human");

setupaim(var_0) {
  self setanim( % exposed_aiming, 1, var_0);
  self setanimknoblimited(animscripts\utility::animarray("straight_level"), 1, var_0);
  self setanimknoblimited(animscripts\utility::animarray("add_aim_up"), 1, var_0);
  self setanimknoblimited(animscripts\utility::animarray("add_aim_down"), 1, var_0);
  self setanimknoblimited(animscripts\utility::animarray("add_aim_left"), 1, var_0);
  self setanimknoblimited(animscripts\utility::animarray("add_aim_right"), 1, var_0);
  self.facialidx = animscripts\face::playfacialanim(undefined, "aim", self.facialidx);
}

startfireandaimidlethread() {
  if(!isdefined(self.a.aimidlethread)) {
    var_0 = 0.2;

    if(isdefined(self.aimsetupblendtime))
      var_0 = self.aimsetupblendtime;

    setupaim(var_0);

    if(self.doaimidlethread)
      thread aimidlethread();

    thread animscripts\track::trackshootentorpos();
  }
}

endfireandanimidlethread() {
  endaimidlethread();
  self clearanim( % add_fire, 0.1);
  self notify("stop tracking");
}

showfirehideaimidle() {
  if(isdefined(self.a.aimidlethread))
    self setanim( % add_idle, 0, 0.2);

  self setanim( % add_fire, 1, 0.1);
}

hidefireshowaimidle() {
  if(isdefined(self.a.aimidlethread))
    self setanim( % add_idle, 1, 0.2);

  self setanim( % add_fire, 0, 0.1);
}

aimidlethread(var_0) {
  self endon("killanimscript");
  self endon("end_aim_idle_thread");

  if(isdefined(self.a.aimidlethread)) {
    return;
  }
  self.a.aimidlethread = 1;
  wait 0.1;
  self setanimlimited( % add_idle, 1, 0.2);
  var_1 = % add_idle;
  var_2 = 0;

  for (;;) {
    var_3 = "idle" + var_2;

    if(isdefined(self.a.leanaim))
      var_4 = animscripts\utility::animarraypickrandom("lean_idle");
    else if(animscripts\utility::animarrayanyexist("exposed_idle"))
      var_4 = animscripts\utility::animarraypickrandom("exposed_idle");
    else {
      wait 0.5;
      __asm_jmp(loc_711)
    }

    if(var_4 == var_1)
      self setflaggedanimlimitedrestart(var_3, var_4, 1, 0.2);
    else
      self setflaggedanimknoblimitedrestart(var_3, var_4, 1, 0.2);

    var_1 = var_4;
    self waittillmatch(var_3, "end");
    var_2++;
  }

  self clearanim( % add_idle, 0.1);
}

endaimidlethread() {
  self notify("end_aim_idle_thread");
  self.a.aimidlethread = undefined;
  self clearanim( % add_idle, 0.1);
}

shotgunfirerate_h1og() {
  return randomfloatrange(1.0, 1.7);
}

shotgunfirerate() {
  if(animscripts\utility::weapon_pump_action_shotgun())
    return 1.0;

  if(animscripts\weaponlist::usingautomaticweapon())
    return animscripts\weaponlist::autoshootanimrate() * 0.7;

  return 0.4;
}

fireuntiloutofammo(var_0, var_1, var_2) {
  var_3 = "fireAnim_" + getuniqueflagnameindex();
  maps\_gameskill::resetmisstime();

  while (!aimedatshootentorpos())
    wait 0.05;

  showfirehideaimidle();
  var_4 = 1.0;

  if(isdefined(self.shootrateoverride))
    var_4 = self.shootrateoverride;
  else if(self.shootstyle == "full")
    var_4 = animscripts\weaponlist::autoshootanimrate();
  else if(self.shootstyle == "burst")
    var_4 = animscripts\weaponlist::burstshootanimrate();
  else if(animscripts\utility::usingsidearm())
    var_4 = 3.0;
  else if(animscripts\utility::usingshotgun())
    var_4 = shotgunfirerate_h1og();

  self setflaggedanimknobrestart(var_3, var_0, 1, 0.2, var_4);
  self updateplayersightaccuracy();
  var_5 = weaponfiretime(self.weapon);
  fireuntiloutofammointernal(var_3, var_0, var_1, var_2, var_5);
  hidefireshowaimidle();
}

fireuntiloutofammo_waittillended() {
  self endon("killanimscript");
  self endon("fireAnimEnd");
  self notify("FireUntilOutOfAmmo_WaitTillEnded");
  self endon("FireUntilOutOfAmmo_WaitTillEnded");
  var_0 = thisthread;

  for (;;) {
    waittillframeend;

    if(!isdefined(var_0)) {
      self shootstopsound();
      return;
    }

    wait 0.05;
  }
}

fireuntiloutofammointernal(var_0, var_1, var_2, var_3, var_4) {
  self endon("enemy");

  if(isplayer(self.enemy) && (self.shootstyle == "full" || self.shootstyle == "semi"))
    level endon("player_becoming_invulnerable");

  if(var_2) {
    thread notifyonanimend(var_0, "fireAnimEnd");
    self endon("fireAnimEnd");
  }

  if(!isdefined(var_3))
    var_3 = -1;

  var_5 = 0;
  var_6 = getanimlength(var_1);
  var_7 = animhasnotetrack(var_1, "fire");
  var_8 = weaponclass(self.weapon) == "rocketlauncher";
  thread fireuntiloutofammo_waittillended();

  while (var_5 < var_3 && var_3 > 0) {
    var_9 = 0;

    if(var_7)
      self waittillmatch(var_0, "fire");

    if(!self.bulletsinclip) {
      if(!cheatammoifnecessary()) {
        break;
      }
    }

    if(!aimedatshootentorpos()) {
      break;
    }

    shootatshootentorpos();

    if(isplayer(self.enemy) && self.enemy maps\_utility::ent_flag("player_is_invulnerable")) {
      if(randomint(3) == 0)
        self.bulletsinclip--;
    } else
      self.bulletsinclip--;

    if(var_8) {
      self.a.rockets--;

      if(issubstr(tolower(self.weapon), "rpg") || issubstr(tolower(self.weapon), "panzerfaust")) {
        self hidepart("tag_rocket");
        self.a.rocketvisible = 0;
      }
    }

    var_5++;
    thread shotgunpumpsound(var_0);

    if(self.fastburst && var_5 == var_3) {
      break;
    }

    if(!var_7 || var_3 == 1 && self.shootstyle == "single") {
      self waittillmatch(var_0, "end");
      var_9 = var_6;
    }

    if(var_4 - var_9 > 0)
      wait(var_4 - var_9);
  }

  self shootstopsound();

  if(var_2)
    self notify("fireAnimEnd");
}

aimedatshootentorpos() {
  if(!isdefined(self.shootpos))
    return 1;

  var_0 = self getmuzzleangle();
  var_1 = animscripts\shared::getshootfrompos();
  var_2 = vectortoangles(self.shootpos - var_1);
  var_3 = anim.aimyawdifffartolerance;

  if(isdefined(self.aimfaryawtolerance))
    var_3 = self.aimfaryawtolerance;

  var_4 = animscripts\utility::absangleclamp180(var_0[1] - var_2[1]);

  if(var_4 > var_3) {
    if(distancesquared(self geteye(), self.shootpos) > anim.aimyawdiffclosedistsq || var_4 > anim.aimyawdiffclosetolerance)
      return 0;
  }

  var_5 = anim.aimpitchdifftolerance;

  if(self.a.pose == "crouch" && distancesquared(self geteye(), self.shootpos) < anim.aimpitchdiffclosedistsq)
    var_5 = anim.aimpitchdiffclosetolerance;

  return animscripts\utility::absangleclamp180(var_0[0] - var_2[0]) <= var_5;
}

notifyonanimend(var_0, var_1) {
  self endon("killanimscript");
  self endon(var_1);
  self waittillmatch(var_0, "end");
  self notify(var_1);
}

issingleshot() {
  if(weaponburstcount(self.weapon) > 0)
    return 0;
  else if(weaponisauto(self.weapon))
    return 0;

  return 1;
}

shootatshootentorpos() {
  var_0 = issingleshot();

  if(isdefined(self.shootent)) {
    if(isdefined(self.enemy) && self.shootent == self.enemy)
      animscripts\utility::shootenemywrapper(var_0);
  } else
    self[[anim.shootposwrapper_func]](self.shootpos, var_0);
}

decrementbulletsinclip() {
  if(self.bulletsinclip)
    self.bulletsinclip--;
}

shotgunpumpsound(var_0) {
  if(!animscripts\utility::weapon_pump_action_shotgun()) {
    return;
  }
  self endon("killanimscript");
  self notify("shotgun_pump_sound_end");
  self endon("shotgun_pump_sound_end");
  thread stopshotgunpumpaftertime(2.0);
  self waittillmatch(var_0, "rechamber");
  self playsound("ai_shotgun_pump");
  self notify("shotgun_pump_sound_end");
}

stopshotgunpumpaftertime(var_0) {
  self endon("killanimscript");
  self endon("shotgun_pump_sound_end");
  wait(var_0);
  self notify("shotgun_pump_sound_end");
}

rechamber(var_0) {}

needtoreload(var_0) {
  if(self.weapon == "none")
    return 0;

  if(isdefined(self.noreload)) {
    if(self.bulletsinclip < weaponclipsize(self.weapon) * 0.5)
      self.bulletsinclip = int(weaponclipsize(self.weapon) * 0.5);

    if(self.bulletsinclip <= 0)
      self.bulletsinclip = 0;

    return 0;
  }

  if(animscripts\stairs_utility::stairstransitionpendingsince(100))
    return 0;

  if(self.bulletsinclip <= weaponclipsize(self.weapon) * var_0) {
    if(var_0 == 0) {
      if(cheatammoifnecessary())
        return 0;
    }

    return 1;
  }

  return 0;
}

putgunbackinhandonkillanimscript() {
  self endon("weapon_switch_done");
  self endon("death");
  self waittill("killanimscript");
  animscripts\shared::placeweaponon(self.primaryweapon, "right");
}

reload(var_0, var_1) {
  self endon("killanimscript");

  if(!needtoreload(var_0))
    return 0;

  animscripts\battlechatter_ai::evaluatereloadevent();
  animscripts\battlechatter::playbattlechatter();

  if(isdefined(var_1)) {
    self setflaggedanimknoball("reloadanim", var_1, % body, 1, 0.1, 1);
    animscripts\shared::donotetracks("reloadanim");
    animscripts\weaponlist::refillclip();
    self.a.needstorechamber = 0;
  } else {
    if(self.a.pose == "prone") {
      self setflaggedanimknoball("reloadanim", % prone_reload, % body, 1, 0.1, 1);
      self updateprone( % prone_legs_up, % prone_legs_down, 1, 0.1, 1);
    } else {
      wait 2;
      return;
    }

    animscripts\shared::donotetracks("reloadanim");
    animscripts\weaponlist::refillclip();
    self.a.needstorechamber = 0;
  }

  return 1;
}

addgrenadethrowanimoffset(var_0, var_1) {
  if(!isdefined(anim.grenadethrowanims)) {
    anim.grenadethrowanims = [];
    anim.grenadethrowoffsets = [];
  }

  var_2 = anim.grenadethrowanims.size;
  anim.grenadethrowanims[var_2] = var_0;
  anim.grenadethrowoffsets[var_2] = var_1;
}

initgrenadethrowanims() {
  addgrenadethrowanimoffset( % exposed_grenadethrowb, (41.5391, 7.28883, 72.2128));
  addgrenadethrowanimoffset( % exposed_grenadethrowc, (34.8849, -4.77048, 74.0488));
  addgrenadethrowanimoffset( % corner_standl_grenade_a, (41.605, 6.80107, 81.4785));
  addgrenadethrowanimoffset( % corner_standl_grenade_b, (24.1585, -14.7221, 29.2992));
  addgrenadethrowanimoffset( % cornercrl_grenadea, (25.8988, -10.2811, 30.4813));
  addgrenadethrowanimoffset( % cornercrl_grenadeb, (24.688, 45.0702, 64.377));
  addgrenadethrowanimoffset( % corner_standr_grenade_a, (37.1254, -32.7053, 76.5745));
  addgrenadethrowanimoffset( % corner_standr_grenade_b, (19.356, 15.5341, 16.5036));
  addgrenadethrowanimoffset( % cornercrr_grenadea, (39.8857, 5.92472, 24.5878));
  addgrenadethrowanimoffset( % covercrouch_grenadea, (-1.6363, -0.693674, 60.1009));
  addgrenadethrowanimoffset( % covercrouch_grenadeb, (-1.6363, -0.693674, 60.1009));
  addgrenadethrowanimoffset( % coverstand_grenadea, (10.8573, 7.12614, 77.2356));
  addgrenadethrowanimoffset( % coverstand_grenadeb, (19.1804, 5.68214, 73.2278));
  addgrenadethrowanimoffset( % prone_grenade_a, (12.2859, -1.3019, 33.4307));
  addgrenadethrowanimoffset( % cqb_stand_grenade_throw, (35.7494, 26.6052, 37.7086));
  addgrenadethrowanimoffset( % s1_covercrouch_grenadea, (-15.5413, -16.7719, 19.4304));
  addgrenadethrowanimoffset( % s1_coverstand_grenadea, (3.99694, -2.76588, 32.8777));
  addgrenadethrowanimoffset( % s1_coverstand_grenadeb, (5.51904, 2.92983, 32.8406));
  addgrenadethrowanimoffset( % s1_exposed_crouch_fast_grenade_1, (16.4611, -8.55309, 30.1018));
  addgrenadethrowanimoffset( % s1_exposed_crouch_fast_grenade_2, (30.5886, -7.6374, 47.3139));
  addgrenadethrowanimoffset( % s1_exposed_grenadethrowc, (13.433, -0.473915, 43.3545));
  addgrenadethrowanimoffset( % s1_exposed_grenadethrowb, (-31.425, -7.62042, 42.4334));
  addgrenadethrowanimoffset( % s1_cornercrr_grenade_2, (37.4516, -2.01701, 22.6517));
  addgrenadethrowanimoffset( % s1_corner_standl_grenade_a, (41.605, 6.80107, 81.4785));
  addgrenadethrowanimoffset( % s1_cornercrr_grenadea, (39.8857, 5.92472, 24.5878));
}

h1_grenade_attach_detach_listener(var_0) {
  if(var_0 == "grenade_left" || var_0 == "grenade_right") {
    self.h1_scripted_grenade = spawn("script_model", self gettagorigin("tag_inhand"));
    var_1 = animscripts\utility::getgrenademodel();
    self.h1_scripted_grenade setmodel(var_1);
    self.h1_scripted_grenade linkto(self, "tag_inhand", (0, 0, 3), (0, 0, 0));
  } else if(var_0 == "grenade_throw") {
    self.h1_scripted_grenade delete();
    self.h1_scripted_grenade = undefined;
    return "end";
  }
}

getgrenadethrowoffset(var_0) {
  var_1 = (0, 0, 64);

  if(isdefined(var_0)) {
    foreach(var_4, var_3 in anim.grenadethrowanims) {
      if(var_0 == var_3) {
        var_1 = anim.grenadethrowoffsets[var_4];
        break;
      }
    }
  }

  if(var_1[2] == 64) {
    if(!isdefined(var_0)) {

    } else {

    }
  }

  return var_1;
}

throwgrenadeatplayerasap_combat_utility() {
  for (var_0 = 0; var_0 < level.players.size; var_0++) {
    if(level.players[var_0].numgrenadesinprogresstowardsplayer == 0) {
      level.players[var_0].grenadetimers["fraggrenade"] = 0;
      level.players[var_0].grenadetimers["flash_grenade"] = 0;
    }
  }

  anim.throwgrenadeatplayerasap = 1;
}

setactivegrenadetimer(var_0) {
  self.activegrenadetimer = spawnstruct();

  if(isplayer(var_0)) {
    self.activegrenadetimer.isplayertimer = 1;
    self.activegrenadetimer.player = var_0;
    self.activegrenadetimer.timername = self.grenadeweapon;
  } else {
    self.activegrenadetimer.isplayertimer = 0;
    self.activegrenadetimer.timername = "AI_" + self.grenadeweapon;
  }
}

usingplayergrenadetimer() {
  return self.activegrenadetimer.isplayertimer;
}

setgrenadetimer(var_0, var_1) {
  if(var_0.isplayertimer) {
    var_2 = var_0.player;
    var_3 = var_2.grenadetimers[var_0.timername];
    var_2.grenadetimers[var_0.timername] = max(var_1, var_3);
  } else {
    var_3 = anim.grenadetimers[var_0.timername];
    anim.grenadetimers[var_0.timername] = max(var_1, var_3);
  }
}

getdesiredgrenadetimervalue() {
  var_0 = undefined;

  if(usingplayergrenadetimer()) {
    var_1 = self.activegrenadetimer.player;
    var_0 = gettime() + var_1.gs.playergrenadebasetime + randomint(var_1.gs.playergrenaderangetime);
  } else
    var_0 = gettime() + 30000 + randomint(30000);

  return var_0;
}

getgrenadetimertime(var_0) {
  if(var_0.isplayertimer)
    return var_0.player.grenadetimers[var_0.timername];
  else
    return anim.grenadetimers[var_0.timername];
}

considerchangingtarget(var_0) {
  if(!isplayer(var_0) && self isbadguy()) {
    if(gettime() < getgrenadetimertime(self.activegrenadetimer)) {
      if(level.player.ignoreme)
        return var_0;

      var_1 = self getthreatbiasgroup();
      var_2 = level.player getthreatbiasgroup();

      if(var_1 != "" && var_2 != "" && getthreatbias(var_2, var_1) < -10000)
        return var_0;

      if(self cansee(level.player) || isai(var_0) && var_0 cansee(level.player)) {
        if(isdefined(self.covernode)) {
          var_3 = vectortoangles(level.player.origin - self.origin);
          var_4 = angleclamp180(self.covernode.angles[1] - var_3[1]);
        } else
          var_4 = animscripts\utility::getyawtospot(level.player.origin);

        if(abs(var_4) < 60) {
          var_0 = level.player;
          setactivegrenadetimer(var_0);
        }
      }
    }
  }

  return var_0;
}

maythrowdoublegrenade(var_0) {
  if(maps\_utility::player_died_recently())
    return 0;

  if(!var_0.gs.double_grenades_allowed)
    return 0;

  var_1 = gettime();

  if(var_1 < var_0.grenadetimers["double_grenade"])
    return 0;

  if(var_1 > var_0.lastfraggrenadetoplayerstart + 3000)
    return 0;

  if(var_1 < var_0.lastfraggrenadetoplayerstart + 500)
    return 0;

  return var_0.numgrenadesinprogresstowardsplayer < 2;
}

mygrenadecooldownelapsed() {
  return gettime() >= self.a.nextgrenadetrytime;
}

grenadecooldownelapsed(var_0) {
  if(maps\_utility::player_died_recently())
    return 0;

  if(self.script_forcegrenade == 1)
    return 1;

  if(!mygrenadecooldownelapsed())
    return 0;

  if(gettime() >= getgrenadetimertime(self.activegrenadetimer))
    return 1;

  if(self.activegrenadetimer.isplayertimer && self.activegrenadetimer.timername == "fraggrenade")
    return maythrowdoublegrenade(var_0);

  return 0;
}

isgrenadepossafe(var_0, var_1) {
  if(isdefined(anim.throwgrenadeatplayerasap) && usingplayergrenadetimer())
    return 1;

  var_2 = 200;

  if(self.grenadeweapon == "flash_grenade")
    var_2 = 512;

  var_3 = var_2 * var_2;
  var_4 = undefined;
  var_5 = 100000000;
  var_6 = undefined;
  var_7 = 100000000;

  for (var_8 = 0; var_8 < self.squad.members.size; var_8++) {
    if(!isalive(self.squad.members[var_8])) {
      continue;
    }
    var_9 = distancesquared(self.squad.members[var_8].origin, var_1);

    if(var_9 > var_3) {
      continue;
    }
    if(var_9 < var_5) {
      var_7 = var_5;
      var_6 = var_4;
      var_5 = var_9;
      var_4 = self.squad.members[var_8];
      continue;
    }

    if(var_9 < var_7) {
      var_7 = var_9;
      var_6 = self.squad.members[var_8];
    }
  }

  if(isdefined(var_4) && sighttracepassed(var_4 geteye(), var_1, 0, undefined))
    return 0;

  if(isdefined(var_6) && sighttracepassed(var_4 geteye(), var_1, 0, undefined))
    return 0;

  return 1;
}

trygrenadeposproc(var_0, var_1, var_2, var_3) {
  if(!isgrenadepossafe(var_0, var_1))
    return 0;
  else if(distancesquared(self.origin, var_1) < 40000)
    return 0;

  var_4 = physicstrace(var_1 + (0, 0, 1), var_1 + (0, 0, -500));

  if(var_4 == var_1 + (0, 0, -500))
    return 0;

  var_4 = var_4 + (0, 0, 0.1);
  return trygrenadethrow(var_0, var_4, var_2, var_3);
}

trygrenade(var_0, var_1) {
  if(self.weapon == "mg42" || self.grenadeammo <= 0)
    return 0;

  setactivegrenadetimer(var_0);
  var_0 = considerchangingtarget(var_0);

  if(!grenadecooldownelapsed(var_0))
    return 0;

  var_2 = getgrenadethrowoffset(var_1);

  if(isdefined(self.enemy) && var_0 == self.enemy) {
    if(!checkgrenadethrowdist())
      return 0;

    if(isplayer(self.enemy) && maps\_utility::is_player_down(self.enemy))
      return 0;

    if(animscripts\utility::canseeenemyfromexposed()) {
      if(!isgrenadepossafe(var_0, var_0.origin))
        return 0;

      return trygrenadethrow(var_0, undefined, var_1, var_2);
    } else if(animscripts\utility::cansuppressenemyfromexposed())
      return trygrenadeposproc(var_0, animscripts\utility::getenemysightpos(), var_1, var_2);
    else {
      if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
        var_3 = self lastknownpos(var_0);
      else
        var_3 = var_0.origin;

      if(!isgrenadepossafe(var_0, var_3))
        return 0;

      return trygrenadethrow(var_0, undefined, var_1, var_2);
    }

    return 0;
  } else {
    if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
      var_3 = self lastknownpos(var_0);
    else
      var_3 = var_0.origin;

    return trygrenadeposproc(var_0, var_3, var_1, var_2);
  }
}

trygrenadethrow(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(gettime() < 10000 && !isdefined(level.ignoregrenadesafetime))
    return 0;

  if(!isdefined(var_5))
    var_5 = 1;

  if(isdefined(var_2)) {
    var_7 = var_2;
    var_8 = self.a.gunhand;
  } else {
    switch (self.a.special) {
      case "cover_crouch":
      case "none":
        if(self.a.pose == "stand") {
          var_3 = (0, 0, 80);
          var_7 = % stand_grenade_throw;
        } else {
          var_3 = (0, 0, 65);
          var_7 = % crouch_grenade_throw;
        }

        var_8 = "left";
        break;
      default:
        var_7 = undefined;
        var_8 = undefined;
        break;
    }
  }

  if(!isdefined(var_7))
    return 0;

  if(isdefined(var_1)) {
    if(!isdefined(var_4))
      var_9 = self checkgrenadethrowpos(var_3, var_1, var_5, "min energy", "min time", "max time");
    else
      var_9 = self checkgrenadethrowpos(var_3, var_1, var_5, "min time", "min energy");
  } else if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
    var_9 = self checkgrenadethrowpos(var_3, self lastknownpos(var_0), var_5, "min energy", "min time", "max time");
  else {
    var_10 = distance(var_0.origin, self.origin);
    var_11 = self.randomgrenaderange;

    if(var_10 < 800) {
      if(var_10 < 256)
        var_11 = 0;
      else
        var_11 = var_11 * ((var_10 - 256) / 544);
    }

    if(!isdefined(var_4))
      var_9 = self checkgrenadethrow(var_3, var_11, "min energy", "min time", "max time");
    else
      var_9 = self checkgrenadethrow(var_3, var_11, "min time", "min energy");
  }

  self.a.nextgrenadetrytime = gettime() + randomintrange(1000, 2000);

  if(isdefined(var_9)) {
    if(!isdefined(self.oldgrenawareness))
      self.oldgrenawareness = self.grenadeawareness;

    self.grenadeawareness = 0;
    var_12 = getdesiredgrenadetimervalue();
    setgrenadetimer(self.activegrenadetimer, min(gettime() + 3000, var_12));
    var_13 = 0;

    if(usingplayergrenadetimer()) {
      var_0.numgrenadesinprogresstowardsplayer++;
      thread reducegiptponkillanimscript(var_0);

      if(var_0.numgrenadesinprogresstowardsplayer > 1)
        var_13 = 1;

      if(self.activegrenadetimer.timername == "fraggrenade") {
        if(var_0.numgrenadesinprogresstowardsplayer <= 1)
          var_0.lastfraggrenadetoplayerstart = gettime();
      }
    }

    if(isdefined(var_6))
      thread dogrenadethrow(var_7, var_9, var_12, var_13);
    else
      dogrenadethrow(var_7, var_9, var_12, var_13);

    return 1;
  } else {}

  return 0;
}

reducegiptponkillanimscript(var_0) {
  self endon("dont_reduce_giptp_on_killanimscript");
  self waittill("killanimscript");
  var_0.numgrenadesinprogresstowardsplayer--;
}

dogrenadethrow(var_0, var_1, var_2, var_3) {
  self endon("killanimscript");

  if(self.script == "combat" || self.script == "move")
    self orientmode("face direction", var_1);

  animscripts\battlechatter_ai::evaluateattackevent("grenade");
  self notify("stop_aiming_at_enemy");
  self setflaggedanimknoballrestart("throwanim", var_0, % body, fasteranimspeed(), 0.1, 1);
  thread animscripts\notetracks::donotetracksforever("throwanim", "killanimscript");
  var_4 = animscripts\utility::getgrenademodel();
  var_5 = "none";

  for (;;) {
    self waittill("throwanim", var_6);

    if(var_6 == "grenade_left" || var_6 == "grenade_right") {
      var_5 = attachgrenademodel(var_4, "TAG_INHAND");
      self.isholdinggrenade = 1;
    }

    if(var_6 == "grenade_throw" || var_6 == "grenade throw") {
      break;
    }

    if(var_6 == "end") {
      self.activegrenadetimer.player.numgrenadesinprogresstowardsplayer--;
      self notify("dont_reduce_giptp_on_killanimscript");
      return 0;
    }
  }

  self notify("dont_reduce_giptp_on_killanimscript");

  if(usingplayergrenadetimer())
    thread watchgrenadetowardsplayer(self.activegrenadetimer.player, var_2);

  self throwgrenade();

  if(!usingplayergrenadetimer())
    setgrenadetimer(self.activegrenadetimer, var_2);

  if(var_3) {
    var_13 = self.activegrenadetimer.player;

    if(var_13.numgrenadesinprogresstowardsplayer > 1 || gettime() - var_13.lastgrenadelandednearplayertime < 2000)
      var_13.grenadetimers["double_grenade"] = gettime() + min(5000, var_13.gs.playerdoublegrenadetime);
  }

  self notify("stop grenade check");

  if(var_5 != "none")
    self detach(var_4, var_5);
  else {}

  self.isholdinggrenade = undefined;
  self.grenadeawareness = self.oldgrenawareness;
  self.oldgrenawareness = undefined;
  self waittillmatch("throwanim", "end");
  self notify("done_grenade_throw");
  self notify("weapon_switch_done");
  self setanim( % exposed_modern, 1, 0.2);
  self setanim( % exposed_aiming, 1);
  self clearanim(var_0, 0.2);
}

watchgrenadetowardsplayer(var_0, var_1) {
  var_0 endon("death");
  watchgrenadetowardsplayerinternal(var_1);
  var_0.numgrenadesinprogresstowardsplayer--;
}

watchgrenadetowardsplayerinternal(var_0) {
  var_1 = self.activegrenadetimer;
  var_2 = spawnstruct();
  var_2 thread watchgrenadetowardsplayertimeout(5);
  var_2 endon("watchGrenadeTowardsPlayerTimeout");
  var_3 = self.grenadeweapon;
  var_4 = getgrenadeithrew();

  if(!isdefined(var_4)) {
    return;
  }
  setgrenadetimer(var_1, min(gettime() + 5000, var_0));
  var_5 = 62500;
  var_6 = 160000;

  if(var_3 == "flash_grenade") {
    var_5 = 810000;
    var_6 = 1690000;
  }

  var_7 = level.players;
  var_8 = var_4.origin;

  for (;;) {
    wait 0.1;

    if(!isdefined(var_4)) {
      break;
    }

    if(distancesquared(var_4.origin, var_8) < 400) {
      var_9 = [];

      for (var_10 = 0; var_10 < var_7.size; var_10++) {
        var_11 = var_7[var_10];
        var_12 = distancesquared(var_4.origin, var_11.origin);

        if(var_12 < var_5) {
          var_11 grenadelandednearplayer(var_1, var_0);
          continue;
        }

        if(var_12 < var_6)
          var_9[var_9.size] = var_11;
      }

      var_7 = var_9;

      if(var_7.size == 0) {
        break;
      }
    }

    var_8 = var_4.origin;
  }
}

grenadelandednearplayer(var_0, var_1) {
  var_2 = self;
  anim.throwgrenadeatplayerasap = undefined;

  if(gettime() - var_2.lastgrenadelandednearplayertime < 3000)
    var_2.grenadetimers["double_grenade"] = gettime() + var_2.gs.playerdoublegrenadetime;

  var_2.lastgrenadelandednearplayertime = gettime();
  var_3 = var_2.grenadetimers[var_0.timername];
  var_2.grenadetimers[var_0.timername] = max(var_1, var_3);
}

getgrenadeithrew() {
  self endon("killanimscript");
  self waittill("grenade_fire", var_0);
  return var_0;
}

watchgrenadetowardsplayertimeout(var_0) {
  wait(var_0);
  self notify("watchGrenadeTowardsPlayerTimeout");
}

attachgrenademodel(var_0, var_1) {
  self attach(var_0, var_1);
  thread detachgrenadeonscriptchange(var_0, var_1);
  return var_1;
}

detachgrenadeonscriptchange(var_0, var_1) {
  self endon("stop grenade check");
  self waittill("killanimscript");

  if(!isdefined(self)) {
    return;
  }
  if(isdefined(self.oldgrenawareness)) {
    self.grenadeawareness = self.oldgrenawareness;
    self.oldgrenawareness = undefined;
  }

  self detach(var_0, var_1);
}

offsettoorigin(var_0) {
  var_1 = anglestoforward(self.angles);
  var_2 = anglestoright(self.angles);
  var_3 = anglestoup(self.angles);
  var_1 = var_1 * var_0[0];
  var_2 = var_2 * var_0[1];
  var_3 = var_3 * var_0[2];
  return var_1 + var_2 + var_3;
}

grenadeline(var_0, var_1) {
  level notify("armoffset");
  level endon("armoffset");
  var_0 = self.origin + offsettoorigin(var_0);

  for (;;)
    wait 0.05;
}

getgrenadedropvelocity() {
  var_0 = randomfloat(360);
  var_1 = randomfloatrange(30, 75);
  var_2 = sin(var_1);
  var_3 = cos(var_1);
  var_4 = cos(var_0) * var_3;
  var_5 = sin(var_0) * var_3;
  var_6 = randomfloatrange(100, 200);
  var_7 = (var_4, var_5, var_2) * var_6;
  return var_7;
}

dropgrenade() {
  var_0 = self gettagorigin("tag_inhand");
  var_1 = getgrenadedropvelocity();
  self magicgrenademanual(var_0, var_1, 3);
}

lookforbettercover() {
  if(!isdefined(self.enemy))
    return 0;

  if(self.fixednode || self.doingambush)
    return 0;

  var_0 = getbestcovernodeifavailable();

  if(isdefined(var_0))
    return usecovernodeifpossible(var_0);

  return 0;
}

getbestcovernodeifavailable() {
  var_0 = self findbestcovernode();

  if(!isdefined(var_0))
    return undefined;

  var_1 = animscripts\utility::getclaimednode();

  if(isdefined(var_1) && var_0 == var_1)
    return undefined;

  if(isdefined(self.covernode) && var_0 == self.covernode)
    return undefined;

  return var_0;
}

usecovernodeifpossible(var_0) {
  var_1 = self.keepclaimednodeifvalid;
  var_2 = self.keepclaimednode;
  self.keepclaimednodeifvalid = 0;
  self.keepclaimednode = 0;

  if(self usecovernode(var_0))
    return 1;
  else {}

  self.keepclaimednodeifvalid = var_1;
  self.keepclaimednode = var_2;
  return 0;
}

shouldhelpadvancingteammate() {
  if(level.advancetoenemygroup[self.team] > 0 && level.advancetoenemygroup[self.team] < level.advancetoenemygroupmax) {
    if(gettime() - level.lastadvancetoenemytime[self.team] > 4000)
      return 0;

    var_0 = level.lastadvancetoenemyattacker[self.team];

    if(var_0 == self)
      return 0;

    var_1 = isdefined(var_0) && distancesquared(self.origin, var_0.origin) < 65536;

    if((var_1 || distancesquared(self.origin, level.lastadvancetoenemysrc[self.team]) < 65536) && (!isdefined(self.enemy) || distancesquared(self.enemy.origin, level.lastadvancetoenemydest[self.team]) < 262144))
      return 1;
  }

  return 0;
}

checkadvanceonenemyconditions() {
  if(!isdefined(level.lastadvancetoenemytime[self.team]))
    return 0;

  if(shouldhelpadvancingteammate())
    return 1;

  if(gettime() - level.lastadvancetoenemytime[self.team] < level.advancetoenemyinterval)
    return 0;

  if(!issentient(self.enemy))
    return 0;

  if(level.advancetoenemygroup[self.team])
    level.advancetoenemygroup[self.team] = 0;

  var_0 = isdefined(self.advance_regardless_of_numbers) && self.advance_regardless_of_numbers;

  if(!var_0 && getaicount(self.team) < getaicount(self.enemy.team))
    return 0;

  return 1;
}

tryrunningtoenemy(var_0) {
  if(!isdefined(self.enemy))
    return 0;

  if(self.fixednode)
    return 0;

  if(self.combatmode == "ambush" || self.combatmode == "ambush_nodes_only")
    return 0;

  if(!self isingoal(self.enemy.origin))
    return 0;

  if(islongrangeai())
    return 0;

  if(!checkadvanceonenemyconditions())
    return 0;

  self findreacquiredirectpath(var_0);

  if(self reacquiremove()) {
    self.keepclaimednodeifvalid = 0;
    self.keepclaimednode = 0;
    self.a.magicreloadwhenreachenemy = 1;

    if(level.advancetoenemygroup[self.team] == 0) {
      level.lastadvancetoenemytime[self.team] = gettime();
      level.lastadvancetoenemyattacker[self.team] = self;
    }

    level.lastadvancetoenemysrc[self.team] = self.origin;
    level.lastadvancetoenemydest[self.team] = self.enemy.origin;
    level.advancetoenemygroup[self.team]++;
    return 1;
  }

  return 0;
}

delayedbadplace(var_0) {
  self endon("death");
  wait 0.5;
  var_1 = "" + anim.badplaceint;
  badplace_cylinder(var_1, 5, var_0, 16, 64, self.team);
  anim.badplaces[anim.badplaces.size] = var_1;

  if(anim.badplaces.size >= 10) {
    var_2 = [];

    for (var_3 = 1; var_3 < anim.badplaces.size; var_3++)
      var_2[var_2.size] = anim.badplaces[var_3];

    badplace_delete(anim.badplaces[0]);
    anim.badplaces = var_2;
  }

  anim.badplaceint++;

  if(anim.badplaceint > 10)
    anim.badplaceint = anim.badplaceint - 20;
}

valueiswithin(var_0, var_1, var_2) {
  if(var_0 > var_1 && var_0 < var_2)
    return 1;

  return 0;
}

getgunyawtoshootentorpos() {
  if(!isdefined(self.shootpos))
    return 0;

  var_0 = self getmuzzleangle()[1] - animscripts\utility::getyaw(self.shootpos);
  var_0 = angleclamp180(var_0);
  return var_0;
}

getgunpitchtoshootentorpos() {
  if(!isdefined(self.shootpos))
    return 0;

  var_0 = self getmuzzleangle()[0] - vectortoangles(self.shootpos - self getmuzzlepos())[0];
  var_0 = angleclamp180(var_0);
  return var_0;
}

getpitchtoenemy() {
  if(!isdefined(self.enemy))
    return 0;

  if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
    var_0 = get_last_known_shoot_pos(self.enemy);
  else
    var_0 = self.enemy getshootatpos();

  var_1 = var_0 - self getshootatpos();
  var_1 = vectornormalize(var_1);
  var_2 = 360 - vectortoangles(var_1)[0];
  return angleclamp180(var_2);
}

getpitchtospot(var_0) {
  if(!isdefined(var_0))
    return 0;

  var_1 = var_0 - self getshootatpos();
  var_1 = vectornormalize(var_1);
  var_2 = 360 - vectortoangles(var_1)[0];
  return angleclamp180(var_2);
}

getpitchtoorgfromorg(var_0, var_1) {
  if(!isdefined(var_0) || !isdefined(var_1))
    return 0;

  if(isdefined(self) && animscripts\utility::isspaceai()) {
    var_2 = anglestoforward(self.angles);
    var_3 = rotatepointaroundvector(var_2, var_0 - self.origin, self.angles[2] * -1);
    var_0 = var_3 + self.origin;
  }

  var_4 = var_0 - var_1;
  var_4 = vectornormalize(var_4);
  var_5 = 360 - vectortoangles(var_4)[0];
  return angleclamp180(var_5);
}

watchreloading() {
  self.isreloading = 0;
  self.lastreloadstarttime = -1;

  for (;;) {
    self waittill("reload_start");
    self.isreloading = 1;
    self.lastreloadstarttime = gettime();
    waittillreloadfinished();
    self.isreloading = 0;
  }
}

waittillreloadfinished() {
  thread timednotify(4, "reloadtimeout");
  self endon("reloadtimeout");
  self endon("weapon_taken");

  for (;;) {
    self waittill("reload");
    var_0 = self getcurrentweapon();

    if(var_0 == "none") {
      break;
    }

    if(self getcurrentweaponclipammo() >= weaponclipsize(var_0)) {
      break;
    }
  }

  self notify("reloadtimeout");
}

timednotify(var_0, var_1) {
  self endon(var_1);
  wait(var_0);
  self notify(var_1);
}

checkgrenadethrowdist() {
  var_0 = self.enemy.origin - self.origin;
  var_1 = lengthsquared((var_0[0], var_0[1], 0));

  if(self.grenadeweapon == "flash_grenade")
    return var_1 < 589824;

  if(isdefined(level.usinggrenadedistancechecks) && level.usinggrenadedistancechecks)
    return var_1 >= 40000 && var_1 <= 1562500;
  else
    return 1;
}

monitorflash() {
  self endon("death");

  if(!isdefined(level.neverstopmonitoringflash))
    self endon("stop_monitoring_flash");

  for (;;) {
    var_0 = undefined;
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;
    self waittill("flashbang", var_1, var_0, var_2, var_3, var_4);

    if(isdefined(self.flashbangimmunity) && self.flashbangimmunity) {
      continue;
    }
    if(isdefined(self.script_immunetoflash) && self.script_immunetoflash != 0) {
      continue;
    }
    if(isdefined(self.team) && isdefined(var_4) && self.team == var_4) {
      var_0 = 3 * (var_0 - 0.75);

      if(var_0 < 0) {
        continue;
      }
      if(isdefined(self.teamflashbangimmunity))
        continue;
    }

    var_5 = 0.2;

    if(var_0 > 1 - var_5)
      var_0 = 1.0;
    else
      var_0 = var_0 / (1 - var_5);

    var_6 = 4.5 * var_0;

    if(var_6 < 0.25) {
      continue;
    }
    self.flashingteam = var_4;

    if(isdefined(self.flashbangstopsscriptedanim) && self.flashbangstopsscriptedanim)
      self stopanimscripted();

    maps\_utility::flashbangstart(var_6);
    self notify("doFlashBanged", var_1, var_3);
  }
}

isshotgunai() {
  return animscripts\utility::isshotgun(self.primaryweapon);
}

issniper() {
  return animscripts\utility::issniperrifle(self.primaryweapon);
}

islongrangeai() {
  return issniper() || animscripts\utility::usingrocketlauncher();
}

fasteranimspeed() {
  return 1.5;
}

randomfasteranimspeed() {
  return randomfloatrange(1, 1.2);
}

getrandomcovermode(var_0) {
  if(var_0.size == 0)
    return undefined;

  if(var_0.size == 1)
    return var_0[0];

  if(isdefined(self.a.prevattack) && randomint(100) > 20) {
    foreach(var_3, var_2 in var_0) {
      if(var_2 == self.a.prevattack) {
        if(var_3 < var_0.size - 1)
          var_0[var_3] = var_0[var_0.size - 1];

        var_0[var_0.size - 1] = undefined;
        break;
      }
    }
  }

  return var_0[randomint(var_0.size)];
}

player_sees_my_scope() {
  var_0 = self geteye();

  foreach(var_2 in level.players) {
    if(!self cansee(var_2)) {
      continue;
    }
    var_3 = var_2 geteye();
    var_4 = vectortoangles(var_0 - var_3);
    var_5 = anglestoforward(var_4);
    var_6 = var_2 getplayerangles();
    var_7 = anglestoforward(var_6);
    var_8 = vectordot(var_5, var_7);

    if(var_8 < 0.805) {
      continue;
    }
    if(common_scripts\utility::cointoss() && var_8 >= 0.996) {
      continue;
    }
    return 1;
  }

  return 0;
}

get_last_known_shoot_pos(var_0) {
  var_1 = self lastknownpos(var_0);
  var_2 = var_0 getshootatpos() - var_0.origin;
  return var_1 + var_2;
}