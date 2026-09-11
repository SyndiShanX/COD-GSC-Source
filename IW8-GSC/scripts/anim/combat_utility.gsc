/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\combat_utility.gsc
***********************************************/

function gettargetangleoffset(var0) {
  var1 = self getshootatpos() + (0, 0, -3);
  var2 = (var1[0] - var0[0], var1[1] - var0[1], var1[2] - var0[2]);
  var2 = vectorNormalize(var2);
  var3 = var2[2] * -1;
  return var3;
}

function getremainingburstdelaytime() {
  var0 = (gettime() - self.a.lastshoottime) / 1000;
  var1 = getburstdelaytime();

  if(var1 > var0) {
    return (var1 - var0);
  }

  return 0;
}

function getburstdelaytime() {
  if(scripts\anim\utility_common::isusingsidearm()) {
    return randomfloatrange(0.15, 0.55);
  }

  if(scripts\anim\utility_common::weapon_pump_action_shotgun()) {
    return randomfloatrange(1, 1.7);
  }

  if(scripts\anim\utility_common::weapon_genade_launcher()) {
    return scripts\asm\shared\utility::grenadelauncherfirerate();
  }

  if(scripts\anim\utility_common::isasniper()) {
    return scripts\asm\shared\utility::getsniperburstdelaytime();
  }

  if(self.fastburst) {
    return randomfloatrange(0.1, 0.35);
  }

  return randomfloatrange(0.2, 0.4);
}

function shootuntilshootbehaviorchange() {}

function getuniqueflagnameindex() {
  anim.animflagnameindex++;
  return anim.animflagnameindex;
}

#using_animtree("generic_human");

function setupaim(var0) {
  self setanim(%exposed_aiming, 1, 0.2);

  if(scripts\engine\utility::actor_is3d()) {
    self setflaggedanimknoblimited("exposed_aim", scripts\anim\utility::animarray("straight_level"), 1, var0);
  } else {
    self setanimknoblimited(scripts\anim\utility::animarray("straight_level"), 1, var0);
  }

  self setanimknoblimited(scripts\anim\utility::animarray("add_aim_up"), 1, var0);
  self setanimknoblimited(scripts\anim\utility::animarray("add_aim_down"), 1, var0);
  self setanimknoblimited(scripts\anim\utility::animarray("add_aim_left"), 1, var0);
  self setanimknoblimited(scripts\anim\utility::animarray("add_aim_right"), 1, var0);
  self.facialidx = scripts\anim\face::playfacialanim(undefined, "aim", self.facialidx);
}

function issingleshot() {
  if(weaponburstcount(self.weapon) > 0) {
    return false;
  } else if(weaponisauto(self.weapon) || weaponisbeam(self.weapon)) {
    return false;
  }

  return true;
}

function shotgunpumpsound(var0) {
  if(!scripts\anim\utility_common::weapon_pump_action_shotgun()) {
    return;
  }

  self endon("killanimscript");
  self notify("shotgun_pump_sound_end");
  self endon("shotgun_pump_sound_end");
  thread stopshotgunpumpaftertime(2);
  self waittillmatch(var0, "rechamber");
  self playSound("ai_shotgun_pump");
  self notify("shotgun_pump_sound_end");
}

function stopshotgunpumpaftertime(var0) {
  self endon("killanimscript");
  self endon("shotgun_pump_sound_end");
  wait var0;
  self notify("shotgun_pump_sound_end");
}

function rechamber(var0) {}

function putgunbackinhandonkillanimscript() {
  self endon("weapon_switch_done");
  self endon("death");
  self waittill("killanimscript");
  scripts\anim\shared::placeweaponon(self.primaryweapon, "right");
}

function reload(var0, var1) {}

function addgrenadethrowanimoffset(var0, var1) {
  if(!isDefined(anim.grenadethrowanims)) {
    anim.grenadethrowanims = [];
    anim.grenadethrowoffsets = [];
  }

  var2 = anim.grenadethrowanims.size;
  anim.grenadethrowanims[var2] = var0;
  anim.grenadethrowoffsets[var2] = var1;
}

function initgrenadethrowanims() {}

function getgrenadethrowoffset(var0) {
  var1 = (0, 0, 64);
  return var1;
}

function throwgrenadeatplayerasap_combat_utility() {
  for(var0 = 0; var0 < level.players.size; var0++) {
    if(level.players[var0].numgrenadesinprogresstowardsplayer == 0) {
      level.players[var0].grenadetimers["frag"] = 0;
      level.players[var0].grenadetimers["flash_grenade"] = 0;
      level.players[var0].grenadetimers["seeker"] = 0;
    }
  }

  anim.throwgrenadeatplayerasap = 1;
}

function setactivegrenadetimer(var0) {
  self.activegrenadetimer = spawnStruct();

  if(isPlayer(var0)) {
    self.activegrenadetimer.isplayertimer = 1;
    self.activegrenadetimer.player = var0;
    self.activegrenadetimer.timername = self.grenadeweapon.basename;
    return;
  }

  self.activegrenadetimer.isplayertimer = 0;
  self.activegrenadetimer.timername = "AI_" + self.grenadeweapon.basename;
}

function usingplayergrenadetimer() {
  return self.activegrenadetimer.isplayertimer;
}

function setgrenadetimer(var0, var1) {
  if(var0.isplayertimer) {
    var2 = var0.player;
    var3 = var2.grenadetimers[var0.timername];
    var2.grenadetimers[var0.timername] = max(var1, var3);
    return;
  }

  var3 = anim.grenadetimers[var1.timername];
  anim.grenadetimers[var1.timername] = max(var3, var3);
}

function getdesiredgrenadetimervalue() {
  var0 = undefined;

  if(usingplayergrenadetimer()) {
    var1 = self.activegrenadetimer.player;
    var0 = gettime() + var1.gs.playergrenadebasetime + randomint(var1.gs.playergrenaderangetime);
  } else {
    var0 = gettime() + 30000 + randomint(30000);
  }

  return var0;
}

function getgrenadetimertime(var0) {
  if(var0.isplayertimer) {
    return var0.player.grenadetimers[var0.timername];
  }

  return anim.grenadetimers[var0.timername];
}

function maythrowdoublegrenade(var0) {
  if(scripts\engine\utility::player_died_recently()) {
    return false;
  }

  if(!var0.gs.double_grenades_allowed) {
    return false;
  }

  var1 = gettime();

  if(var1 < var0.grenadetimers["double_grenade"]) {
    return false;
  }

  if(var1 > var0.lastfraggrenadetoplayerstart + 3000) {
    return false;
  }

  if(var1 < var0.lastfraggrenadetoplayerstart + 500) {
    return false;
  }

  return var0.numgrenadesinprogresstowardsplayer < 2;
}

function mygrenadecooldownelapsed() {
  return gettime() >= self.a.nextgrenadetrytime;
}

function grenadecooldownelapsed(var0) {
  if(scripts\engine\utility::player_died_recently()) {
    return false;
  }

  if(self.script_forcegrenade == 1) {
    return true;
  }

  if(!mygrenadecooldownelapsed()) {
    return false;
  }

  if(gettime() >= getgrenadetimertime(self.activegrenadetimer)) {
    return true;
  }

  if(self.activegrenadetimer.isplayertimer && self.activegrenadetimer.timername == "fraggrenade") {
    return maythrowdoublegrenade(var0);
  }

  return false;
}

function trygrenadeposproc(var0, var1, var2, var3) {
  if(!self isgrenadepossafe(var0, var1)) {
    return 0;
  } else if(distancesquared(self.origin, var1) < 40000) {
    return 0;
  }

  var4 = physicstrace(var1 + (0, 0, 1), var1 + (0, 0, -500));

  if(var4 == var1 + (0, 0, -500)) {
    return 0;
  }

  var4 += (0, 0, 0.1);
  return trygrenadethrow(var0, var4, var2, var3);
}

function trygrenadethrow(var0, var1, var2, var3, var4, var5, var6) {}

function reducegiptponkillanimscript(var0) {
  self endon("dont_reduce_giptp_on_killanimscript");
  self waittill("killanimscript");
  var0.numgrenadesinprogresstowardsplayer--;
}

#using_animtree("");

function dogrenadethrow(var0, var1, var2, var3) {
  self endon("killanimscript");

  if(!self.arriving) {
    self orientmode("face direction", var1);
  }

  scripts\anim\battlechatter_wrapper::evaluateattackevent(self.grenadeweapon.basename);
  self notify("stop_aiming_at_enemy");
  self setflaggedanimknoballrestart("throwanim", var0, %body, fasteranimspeed(), 0.1, 1);
  thread scripts\anim\notetracks::donotetracksforever("throwanim", "killanimscript");
  var4 = scripts\anim\utility_common::getgrenademodel();
  var5 = "none";

  for(;;) {
    self waittill("throwanim", var6);

    if(var6 == "grenade_left" || var6 == "grenade_right") {
      var5 = attachgrenademodel(var4, "TAG_INHAND");
      self.isholdinggrenade = 1;
    }

    if(var6 == "grenade_throw" || var6 == "grenade throw") {
      break;
    }

    if(var6 == "end") {
      self.activegrenadetimer.player.numgrenadesinprogresstowardsplayer--;
      self notify("dont_reduce_giptp_on_killanimscript");
      return 0;
    }
  }

  self notify("dont_reduce_giptp_on_killanimscript");

  if(usingplayergrenadetimer()) {
    thread watchgrenadetowardsplayer(self.activegrenadetimer.player, var2);
  }

  self throwgrenade();

  if(!usingplayergrenadetimer()) {
    setgrenadetimer(self.activegrenadetimer, var2);
  }

  if(var3 && self.activegrenadetimer.isplayertimer) {
    var13 = self.activegrenadetimer.player;

    if(var13.numgrenadesinprogresstowardsplayer > 1 || gettime() - var13.lastgrenadelandednearplayertime < 2000) {
      var13.grenadetimers["double_grenade"] = gettime() + min(5000, var13.gs.playerdoublegrenadetime);
    }
  }

  self notify("stop grenade check");

  if(var5 != "none") {
    self detach(var4, var5);
  }

  self.isholdinggrenade = undefined;
  self.grenadeawareness = self.oldgrenawareness;
  self.oldgrenawareness = undefined;
  self waittillmatch("throwanim", "end");
  self notify("done_grenade_throw");
  self notify("weapon_switch_done");
  self setanim(%exposed_modern, 1, 0.2);
  self setanim(%exposed_aiming, 1);
  self aiclearanim(var0, 0.2);
}

function watchgrenadetowardsplayer(var0, var1) {
  var0 endon("death");
  watchgrenadetowardsplayerinternal(var1);
  var0.numgrenadesinprogresstowardsplayer--;
}

function watchgrenadetowardsplayerinternal(var0) {
  var1 = self.activegrenadetimer;
  var2 = spawnStruct();
  thread watchgrenadetowardsplayertimeout(var2);
  var2 endon("watchGrenadeTowardsPlayerTimeout");
  var3 = self.grenadeweapon.basename;
  var4 = getgrenadeithrew();

  if(!isDefined(var4)) {
    return;
  }

  setgrenadetimer(var1, min(gettime() + 5000, var0));
  var5 = 62500;
  var6 = 160000;

  if(var3 == "flash_grenade") {
    var5 = 810000;
    var6 = 1690000;
  }

  var7 = level.players;
  var8 = var4.origin;

  for(;;) {
    wait 0.1;

    if(distancesquared(var4.origin, var8) < 400) {
      var9 = [];

      for(var10 = 0; var10 < var7.size; var10++) {
        var11 = var7[var10];
        var12 = distancesquared(var4.origin, var11.origin);

        if(var12 < var5) {
          grenadelandednearplayer(var11, var1, var0);
          continue;
        }

        if(var12 < var6) {
          var9 = var11;
        }
      }

      var7 = var9;

      if(var7.size == 0) {
        break;
      }
    }

    var4 = var0.origin;
  }
}

function grenadelandednearplayer(var0, var1) {
  var2 = self;
  anim.throwgrenadeatplayerasap = undefined;

  if(gettime() - var2.lastgrenadelandednearplayertime < 3000) {
    var2.grenadetimers["double_grenade"] = gettime() + var2.gs.playerdoublegrenadetime;
  }

  var2.lastgrenadelandednearplayertime = gettime();
  var3 = var2.grenadetimers[var0.timername];
  var2.grenadetimers[var0.timername] = max(var1, var3);
}

function getgrenadeithrew() {
  self endon("killanimscript");
  self waittill("grenade_fire", var0);
  return var0;
}

function watchgrenadetowardsplayertimeout(var0) {
  wait var0;
  self notify("watchGrenadeTowardsPlayerTimeout");
}

function attachgrenademodel(var0, var1) {
  self attach(var0, var1);
  thread detachgrenadeonscriptchange(var0, var1);
  return var1;
}

function detachgrenadeonscriptchange(var0, var1) {
  self endon("stop grenade check");
  self waittill("killanimscript");

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.oldgrenawareness)) {
    self.grenadeawareness = self.oldgrenawareness;
    self.oldgrenawareness = undefined;
  }

  self detach(var0, var1);
}

function offsettoorigin(var0) {
  var1 = anglesToForward(self.angles);
  var2 = anglestoright(self.angles);
  var3 = anglestoup(self.angles);
  var1 *= var0[0];
  var2 *= var0[1];
  var3 *= var0[2];
  return var1 + var2 + var3;
}

function grenadeline(var0, var1) {
  level notify("armoffset");
  level endon("armoffset");
  var0 = self.origin + offsettoorigin(var0);

  for(;;) {
    wait 0.05;
  }
}

function getgrenadedropvelocity() {
  var0 = randomfloat(360);
  var1 = randomfloatrange(30, 75);
  var2 = sin(var1);
  var3 = cos(var1);
  var4 = cos(var0) * var3;
  var5 = sin(var0) * var3;
  var6 = randomfloatrange(100, 200);
  var7 = (var4, var5, var2) * var6;
  return var7;
}

function dropgrenade() {
  if(isDefined(self.nodropgrenade)) {
    return;
  }

  var0 = self gettagorigin("tag_accessory_right");
  var1 = getgrenadedropvelocity();
  self magicgrenademanual(var0, var1, 3);
}

function shouldhelpadvancingteammate() {
  if(level.advancetoenemygroup[self.team] > 0 && level.advancetoenemygroup[self.team] < level.advancetoenemygroupmax) {
    if(gettime() - level.lastadvancetoenemytime[self.team] > 4000) {
      return false;
    }

    var0 = level.lastadvancetoenemyattacker[self.team];

    if(var0 == self) {
      return false;
    }

    var1 = isDefined(var0) && distancesquared(self.origin, var0.origin) < 65536;

    if((var1 || distancesquared(self.origin, level.lastadvancetoenemysrc[self.team]) < 65536) && (!isDefined(self.enemy) || distancesquared(self.enemy.origin, level.lastadvancetoenemydest[self.team]) < 262144)) {
      return true;
    }
  }

  return false;
}

function checkadvanceonenemyconditions() {
  if(!isDefined(level.lastadvancetoenemytime[self.team])) {
    return false;
  }

  if(shouldhelpadvancingteammate()) {
    return true;
  }

  if(gettime() - level.lastadvancetoenemytime[self.team] < level.advancetoenemyinterval) {
    return false;
  }

  if(!issentient(self.enemy)) {
    return false;
  }

  if(level.advancetoenemygroup[self.team]) {
    level.advancetoenemygroup[self.team] = 0;
  }

  var0 = isDefined(self.advance_regardless_of_numbers) && self.advance_regardless_of_numbers;

  if(!var0 && getaicount(self.team) < getaicount(self.enemy.team)) {
    return false;
  }

  return true;
}

function tryrunningtoenemy(var0) {
  if(!isDefined(self.enemy)) {
    return false;
  }

  if(self.fixednode) {
    return false;
  }

  if(self.combatmode == "ambush" || self.combatmode == "ambush_nodes_only") {
    return false;
  }

  if(!self isingoal(self.enemy.origin)) {
    return false;
  }

  if(scripts\anim\utility_common::islongrangeai()) {
    return false;
  }

  if(!checkadvanceonenemyconditions()) {
    return false;
  }

  if(isDefined(self.usingnavmesh) && self.usingnavmesh) {
    return false;
  }

  self findreacquiredirectpath(var0);

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
    return true;
  }

  return false;
}

function getpitchtoshootspot(var0) {
  if(!isDefined(var0)) {
    return 0;
  }

  var1 = var0 - self getshootatpos();
  var1 = vectorNormalize(var1);
  var2 = vectortoangles(var1)[0];
  return angleclamp180(var2);
}

function watchreloading() {
  self.isreloading = 0;
  self.lastreloadstarttime = -1;

  for(;;) {
    self waittill("reload_start");
    self.isreloading = 1;
    self.lastreloadstarttime = gettime();
    scripts\anim\battlechatter_wrapper::evaluatereloadevent();
    waittillreloadfinished();
    self.isreloading = 0;
  }
}

function waittillreloadfinished() {
  thread timednotify(4, "reloadtimeout");
  self endon("reloadtimeout");
  self endon("weapon_taken");

  for(;;) {
    self waittill("reload");
    var0 = self getcurrentweapon();

    if(nullweapon(var0)) {
      break;
    }

    if(self getcurrentweaponclipammo() >= weaponclipsize(var0)) {
      break;
    }
  }

  self notify("reloadtimeout");
}

function timednotify(var0, var1) {
  self endon(var1);
  wait var0;
  self notify(var1);
}

function checkgrenadethrowdist() {
  var0 = self.enemy.origin - self.origin;
  var1 = lengthsquared((var0[0], var0[1], 0));

  if(self.grenadeweapon.basename == "flash_grenade") {
    return (var1 < 589824);
  }

  return var1 >= 40000 && var1 <= 1562500;
}

function monitorflash() {
  self endon("death");
  jumpiftrue(isDefined(level.neverstopmonitoringflash)) LOC_00000018;
  self endon("stop_monitoring_flash");

  for(;;) {
    var0 = undefined;
    var1 = undefined;
    var2 = undefined;
    var3 = undefined;
    var4 = undefined;
    self waittill("flashbang", var1, var0, var2, var3, var4);

    if(isDefined(self.flashbangimmunity) && self.flashbangimmunity) {
      continue;
    }

    if(isDefined(self.script_immunetoflash) && self.script_immunetoflash != 0) {
      continue;
    }

    if(isDefined(self.team) && isDefined(var4) && self.team == var4) {
      var0 = 3 * (var0 - 0.75);

      if(var0 < 0) {
        continue;
      }

      if(isDefined(self.teamflashbangimmunity)) {
        continue;
      }
    }

    var5 = 0.2;

    if(var0 > 1 - var5) {
      var0 = 1;
    } else {
      var0 /= 1 - var5;
    }

    var6 = 4.5 * var0;

    if(var6 < 0.25) {
      continue;
    }

    self.flashingteam = var4;
    flashbangstart(var6);
    self notify("doFlashBanged", var1, var3);
  }
}

function flashbangstart(var0) {
  if(isDefined(self.flashbangimmunity) && self.flashbangimmunity) {
    return;
  }

  if(isDefined(self.syncedmeleetarget)) {
    return;
  }

  if(self isinscriptedstate() || scripts\asm\asm_bb::bb_isanimScripted()) {
    return;
  }

  if(!self.allowpain || !self.allowpain_internal) {
    return;
  }

  var1 = gettime() + var0 * 1000;

  if(isDefined(self.flashendtime)) {
    self.flashendtime = max(self.flashendtime, var1);
  } else {
    self.flashendtime = var1;

    if(isDefined(self.asm)) {
      scripts\asm\asm::asm_setstate("pain_flashed_transition");
    }
  }

  self notify("flashed");
}

function fasteranimspeed() {
  return 1.5;
}

function randomfasteranimspeed() {
  return randomfloatrange(1, 1.2);
}

function player_sees_my_scope() {
  var0 = self getEye();

  foreach(var2 in level.players) {
    if(!self cansee(var2)) {
      continue;
    }

    var3 = var2 getEye();
    var4 = vectortoangles(var0 - var3);
    var5 = anglesToForward(var4);
    var6 = var2 getplayerangles();
    var7 = anglesToForward(var6);
    var8 = vectordot(var5, var7);

    if(var8 < 0.805) {
      continue;
    }

    if(scripts\engine\utility::cointoss() && var8 >= 0.996) {
      continue;
    }

    return true;
  }

  return false;
}

function combat_playfacialanim(var0, var1) {
  self.facialidx = scripts\anim\face::playfacialanim(var0, var1, self.facialidx);
}

function combat_clearfacialanim() {
  self.facialidx = undefined;
  self aiclearanim(%head, 0.2);
}