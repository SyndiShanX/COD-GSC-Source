/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\combat_utility.gsc
***********************************************/

function gettargetangleoffset(var_0) {
  var_1 = self getshootatpos() + (0, 0, -3);
  var_2 = (var_1[0] - var_0[0], var_1[1] - var_0[1], var_1[2] - var_0[2]);
  var_2 = vectorNormalize(var_2);
  var_3 = var_2[2] * -1;
  return var_3;
}

function getremainingburstdelaytime() {
  var_0 = (gettime() - self.a.lastshoottime) / 1000;
  var_1 = getburstdelaytime();

  if(var_1 > var_0) {
    return (var_1 - var_0);
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

function setupaim(var_0) {
  self setanim(%exposed_aiming, 1, 0.2);

  if(scripts\engine\utility::actor_is3d()) {
    self setflaggedanimknoblimited("exposed_aim", scripts\anim\utility::animarray("straight_level"), 1, var_0);
  } else {
    self setanimknoblimited(scripts\anim\utility::animarray("straight_level"), 1, var_0);
  }

  self setanimknoblimited(scripts\anim\utility::animarray("add_aim_up"), 1, var_0);
  self setanimknoblimited(scripts\anim\utility::animarray("add_aim_down"), 1, var_0);
  self setanimknoblimited(scripts\anim\utility::animarray("add_aim_left"), 1, var_0);
  self setanimknoblimited(scripts\anim\utility::animarray("add_aim_right"), 1, var_0);
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

function shotgunpumpsound(var_0) {
  if(!scripts\anim\utility_common::weapon_pump_action_shotgun()) {
    return;
  }

  self endon("killanimscript");
  self notify("shotgun_pump_sound_end");
  self endon("shotgun_pump_sound_end");
  thread stopshotgunpumpaftertime(2);
  self waittillmatch(var_0, "rechamber");
  self playSound("ai_shotgun_pump");
  self notify("shotgun_pump_sound_end");
}

function stopshotgunpumpaftertime(var_0) {
  self endon("killanimscript");
  self endon("shotgun_pump_sound_end");
  wait var_0;
  self notify("shotgun_pump_sound_end");
}

function rechamber(var_0) {}

function putgunbackinhandonkillanimscript() {
  self endon("weapon_switch_done");
  self endon("death");
  self waittill("killanimscript");
  scripts\anim\shared::placeweaponon(self.primaryweapon, "right");
}

function reload(var_0, var_1) {}

function addgrenadethrowanimoffset(var_0, var_1) {
  if(!isDefined(anim.grenadethrowanims)) {
    anim.grenadethrowanims = [];
    anim.grenadethrowoffsets = [];
  }

  var_2 = anim.grenadethrowanims.size;
  anim.grenadethrowanims[var_2] = var_0;
  anim.grenadethrowoffsets[var_2] = var_1;
}

function initgrenadethrowanims() {}

function getgrenadethrowoffset(var_0) {
  var_1 = (0, 0, 64);
  return var_1;
}

function throwgrenadeatplayerasap_combat_utility() {
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    if(level.players[var_0].numgrenadesinprogresstowardsplayer == 0) {
      level.players[var_0].grenadetimers["frag"] = 0;
      level.players[var_0].grenadetimers["flash_grenade"] = 0;
      level.players[var_0].grenadetimers["seeker"] = 0;
    }
  }

  anim.throwgrenadeatplayerasap = 1;
}

function setactivegrenadetimer(var_0) {
  self.activegrenadetimer = spawnStruct();

  if(isPlayer(var_0)) {
    self.activegrenadetimer.isplayertimer = 1;
    self.activegrenadetimer.player = var_0;
    self.activegrenadetimer.timername = self.grenadeweapon.basename;
    return;
  }

  self.activegrenadetimer.isplayertimer = 0;
  self.activegrenadetimer.timername = "AI_" + self.grenadeweapon.basename;
}

function usingplayergrenadetimer() {
  return self.activegrenadetimer.isplayertimer;
}

function setgrenadetimer(var_0, var_1) {
  if(var_0.isplayertimer) {
    var_2 = var_0.player;
    var_3 = var_2.grenadetimers[var_0.timername];
    var_2.grenadetimers[var_0.timername] = max(var_1, var_3);
    return;
  }

  var_3 = anim.grenadetimers[var_1.timername];
  anim.grenadetimers[var_1.timername] = max(var_3, var_3);
}

function getdesiredgrenadetimervalue() {
  var_0 = undefined;

  if(usingplayergrenadetimer()) {
    var_1 = self.activegrenadetimer.player;
    var_0 = gettime() + var_1.gs.playergrenadebasetime + randomint(var_1.gs.playergrenaderangetime);
  } else {
    var_0 = gettime() + 30000 + randomint(30000);
  }

  return var_0;
}

function getgrenadetimertime(var_0) {
  if(var_0.isplayertimer) {
    return var_0.player.grenadetimers[var_0.timername];
  }

  return anim.grenadetimers[var_0.timername];
}

function maythrowdoublegrenade(var_0) {
  if(scripts\engine\utility::player_died_recently()) {
    return false;
  }

  if(!var_0.gs.double_grenades_allowed) {
    return false;
  }

  var_1 = gettime();

  if(var_1 < var_0.grenadetimers["double_grenade"]) {
    return false;
  }

  if(var_1 > var_0.lastfraggrenadetoplayerstart + 3000) {
    return false;
  }

  if(var_1 < var_0.lastfraggrenadetoplayerstart + 500) {
    return false;
  }

  return var_0.numgrenadesinprogresstowardsplayer < 2;
}

function mygrenadecooldownelapsed() {
  return gettime() >= self.a.nextgrenadetrytime;
}

function grenadecooldownelapsed(var_0) {
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
    return maythrowdoublegrenade(var_0);
  }

  return false;
}

function trygrenadeposproc(var_0, var_1, var_2, var_3) {
  if(!self isgrenadepossafe(var_0, var_1)) {
    return 0;
  } else if(distancesquared(self.origin, var_1) < 40000) {
    return 0;
  }

  var_4 = physicstrace(var_1 + (0, 0, 1), var_1 + (0, 0, -500));

  if(var_4 == var_1 + (0, 0, -500)) {
    return 0;
  }

  var_4 += (0, 0, 0.1);
  return trygrenadethrow(var_0, var_4, var_2, var_3);
}

function trygrenadethrow(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {}

function reducegiptponkillanimscript(var_0) {
  self endon("dont_reduce_giptp_on_killanimscript");
  self waittill("killanimscript");
  var_0.numgrenadesinprogresstowardsplayer--;
}

#using_animtree("");

function dogrenadethrow(var_0, var_1, var_2, var_3) {
  self endon("killanimscript");

  if(!self.arriving) {
    self orientmode("face direction", var_1);
  }

  scripts\anim\battlechatter_wrapper::evaluateattackevent(self.grenadeweapon.basename);
  self notify("stop_aiming_at_enemy");
  self setflaggedanimknoballrestart("throwanim", var_0, %body, fasteranimspeed(), 0.1, 1);
  thread scripts\anim\notetracks::donotetracksforever("throwanim", "killanimscript");
  var_4 = scripts\anim\utility_common::getgrenademodel();
  var_5 = "none";

  for(;;) {
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

  if(usingplayergrenadetimer()) {
    thread watchgrenadetowardsplayer(self.activegrenadetimer.player, var_2);
  }

  self throwgrenade();

  if(!usingplayergrenadetimer()) {
    setgrenadetimer(self.activegrenadetimer, var_2);
  }

  if(var_3 && self.activegrenadetimer.isplayertimer) {
    var_13 = self.activegrenadetimer.player;

    if(var_13.numgrenadesinprogresstowardsplayer > 1 || gettime() - var_13.lastgrenadelandednearplayertime < 2000) {
      var_13.grenadetimers["double_grenade"] = gettime() + min(5000, var_13.gs.playerdoublegrenadetime);
    }
  }

  self notify("stop grenade check");

  if(var_5 != "none") {
    self detach(var_4, var_5);
  }

  self.isholdinggrenade = undefined;
  self.grenadeawareness = self.oldgrenawareness;
  self.oldgrenawareness = undefined;
  self waittillmatch("throwanim", "end");
  self notify("done_grenade_throw");
  self notify("weapon_switch_done");
  self setanim(%exposed_modern, 1, 0.2);
  self setanim(%exposed_aiming, 1);
  self aiclearanim(var_0, 0.2);
}

function watchgrenadetowardsplayer(var_0, var_1) {
  var_0 endon("death");
  watchgrenadetowardsplayerinternal(var_1);
  var_0.numgrenadesinprogresstowardsplayer--;
}

function watchgrenadetowardsplayerinternal(var_0) {
  var_1 = self.activegrenadetimer;
  var_2 = spawnStruct();
  thread watchgrenadetowardsplayertimeout(var_2);
  var_2 endon("watchGrenadeTowardsPlayerTimeout");
  var_3 = self.grenadeweapon.basename;
  var_4 = getgrenadeithrew();

  if(!isDefined(var_4)) {
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

  for(;;) {
    wait 0.1;

    if(distancesquared(var_4.origin, var_8) < 400) {
      var_9 = [];

      for(var_10 = 0; var_10 < var_7.size; var_10++) {
        var_11 = var_7[var_10];
        var_12 = distancesquared(var_4.origin, var_11.origin);

        if(var_12 < var_5) {
          grenadelandednearplayer(var_11, var_1, var_0);
          continue;
        }

        if(var_12 < var_6) {
          var_9 = var_11;
        }
      }

      var_7 = var_9;

      if(var_7.size == 0) {
        break;
      }
    }

    var_4 = var_0.origin;
  }
}

function grenadelandednearplayer(var_0, var_1) {
  var_2 = self;
  anim.throwgrenadeatplayerasap = undefined;

  if(gettime() - var_2.lastgrenadelandednearplayertime < 3000) {
    var_2.grenadetimers["double_grenade"] = gettime() + var_2.gs.playerdoublegrenadetime;
  }

  var_2.lastgrenadelandednearplayertime = gettime();
  var_3 = var_2.grenadetimers[var_0.timername];
  var_2.grenadetimers[var_0.timername] = max(var_1, var_3);
}

function getgrenadeithrew() {
  self endon("killanimscript");
  self waittill("grenade_fire", var_0);
  return var_0;
}

function watchgrenadetowardsplayertimeout(var_0) {
  wait var_0;
  self notify("watchGrenadeTowardsPlayerTimeout");
}

function attachgrenademodel(var_0, var_1) {
  self attach(var_0, var_1);
  thread detachgrenadeonscriptchange(var_0, var_1);
  return var_1;
}

function detachgrenadeonscriptchange(var_0, var_1) {
  self endon("stop grenade check");
  self waittill("killanimscript");

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.oldgrenawareness)) {
    self.grenadeawareness = self.oldgrenawareness;
    self.oldgrenawareness = undefined;
  }

  self detach(var_0, var_1);
}

function offsettoorigin(var_0) {
  var_1 = anglesToForward(self.angles);
  var_2 = anglestoright(self.angles);
  var_3 = anglestoup(self.angles);
  var_1 *= var_0[0];
  var_2 *= var_0[1];
  var_3 *= var_0[2];
  return var_1 + var_2 + var_3;
}

function grenadeline(var_0, var_1) {
  level notify("armoffset");
  level endon("armoffset");
  var_0 = self.origin + offsettoorigin(var_0);

  for(;;) {
    wait 0.05;
  }
}

function getgrenadedropvelocity() {
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

function dropgrenade() {
  if(isDefined(self.nodropgrenade)) {
    return;
  }

  var_0 = self gettagorigin("tag_accessory_right");
  var_1 = getgrenadedropvelocity();
  self magicgrenademanual(var_0, var_1, 3);
}

function shouldhelpadvancingteammate() {
  if(level.advancetoenemygroup[self.team] > 0 && level.advancetoenemygroup[self.team] < level.advancetoenemygroupmax) {
    if(gettime() - level.lastadvancetoenemytime[self.team] > 4000) {
      return false;
    }

    var_0 = level.lastadvancetoenemyattacker[self.team];

    if(var_0 == self) {
      return false;
    }

    var_1 = isDefined(var_0) && distancesquared(self.origin, var_0.origin) < 65536;

    if((var_1 || distancesquared(self.origin, level.lastadvancetoenemysrc[self.team]) < 65536) && (!isDefined(self.enemy) || distancesquared(self.enemy.origin, level.lastadvancetoenemydest[self.team]) < 262144)) {
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

  var_0 = isDefined(self.advance_regardless_of_numbers) && self.advance_regardless_of_numbers;

  if(!var_0 && getaicount(self.team) < getaicount(self.enemy.team)) {
    return false;
  }

  return true;
}

function tryrunningtoenemy(var_0) {
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
    return true;
  }

  return false;
}

function getpitchtoshootspot(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = var_0 - self getshootatpos();
  var_1 = vectorNormalize(var_1);
  var_2 = vectortoangles(var_1)[0];
  return angleclamp180(var_2);
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
    var_0 = self getcurrentweapon();

    if(nullweapon(var_0)) {
      break;
    }

    if(self getcurrentweaponclipammo() >= weaponclipsize(var_0)) {
      break;
    }
  }

  self notify("reloadtimeout");
}

function timednotify(var_0, var_1) {
  self endon(var_1);
  wait var_0;
  self notify(var_1);
}

function checkgrenadethrowdist() {
  var_0 = self.enemy.origin - self.origin;
  var_1 = lengthsquared((var_0[0], var_0[1], 0));

  if(self.grenadeweapon.basename == "flash_grenade") {
    return (var_1 < 589824);
  }

  return var_1 >= 40000 && var_1 <= 1562500;
}

function monitorflash() {
  self endon("death");
  jumpiftrue(isDefined(level.neverstopmonitoringflash)) LOC_00000018;
  self endon("stop_monitoring_flash");

  for(;;) {
    var_0 = undefined;
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;
    self waittill("flashbang", var_1, var_0, var_2, var_3, var_4);

    if(isDefined(self.flashbangimmunity) && self.flashbangimmunity) {
      continue;
    }

    if(isDefined(self.script_immunetoflash) && self.script_immunetoflash != 0) {
      continue;
    }

    if(isDefined(self.team) && isDefined(var_4) && self.team == var_4) {
      var_0 = 3 * (var_0 - 0.75);

      if(var_0 < 0) {
        continue;
      }

      if(isDefined(self.teamflashbangimmunity)) {
        continue;
      }
    }

    var_5 = 0.2;

    if(var_0 > 1 - var_5) {
      var_0 = 1;
    } else {
      var_0 /= 1 - var_5;
    }

    var_6 = 4.5 * var_0;

    if(var_6 < 0.25) {
      continue;
    }

    self.flashingteam = var_4;
    flashbangstart(var_6);
    self notify("doFlashBanged", var_1, var_3);
  }
}

function flashbangstart(var_0) {
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

  var_1 = gettime() + var_0 * 1000;

  if(isDefined(self.flashendtime)) {
    self.flashendtime = max(self.flashendtime, var_1);
  } else {
    self.flashendtime = var_1;

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
  var_0 = self getEye();

  foreach(var_2 in level.players) {
    if(!self cansee(var_2)) {
      continue;
    }

    var_3 = var_2 getEye();
    var_4 = vectortoangles(var_0 - var_3);
    var_5 = anglesToForward(var_4);
    var_6 = var_2 getplayerangles();
    var_7 = anglesToForward(var_6);
    var_8 = vectordot(var_5, var_7);

    if(var_8 < 0.805) {
      continue;
    }

    if(scripts\engine\utility::cointoss() && var_8 >= 0.996) {
      continue;
    }

    return true;
  }

  return false;
}

function combat_playfacialanim(var_0, var_1) {
  self.facialidx = scripts\anim\face::playfacialanim(var_0, var_1, self.facialidx);
}

function combat_clearfacialanim() {
  self.facialidx = undefined;
  self aiclearanim(%head, 0.2);
}