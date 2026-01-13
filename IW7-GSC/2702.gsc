/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2702.gsc
***************************************/

blackholegrenadeinit() {
  level.var_2ABD = [];
  level.var_2ABC = [];
}

blackholeminetrigger() {
  scripts\mp\weapons::makeexplosiveunusable();
  self.owner blackholegrenadeused(self, 1);
}

blackholemineexplode() {}

blackholegrenadeused(var_0, var_1) {
  var_0 endon("death");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  scripts\mp\utility\game::printgameaction("black hole grenade spawned", self);
  thread bhg_deleteondisowned(var_0);
  var_0.state = 0;
  thread func_12EB1(var_0, var_1);

  if(!var_1) {
    var_0 waittill("blackhole_grenade_stuck");

    if(!isDefined(var_0)) {
      return;
    }
  }

  var_0.state = 1;
  thread func_12F29(var_0);
  var_0 waittill("blackhole_grenade_active");

  if(!isDefined(var_0)) {
    return;
  }
  var_0.state = 2;
  thread func_12E56(var_0);
  var_0 waittill("blackhole_grenade_finished");

  if(!isDefined(var_0)) {
    return;
  }
}

func_2B3E(var_0) {
  var_0 endon("death");
  thread bhg_deleteondisowned(var_0);
  var_0.var_9935 = 1;
  var_1 = spawn("script_model", var_0.origin);
  var_1 setotherent(var_0.owner);
  var_1 setModel("prop_mp_black_hole_grenade_scr");
  var_1 give_player_tickets(1);
  var_1 linkto(var_0);
  var_1 thread func_4116(var_0);
  var_0.scriptable = var_1;
  var_2 = getblackholecenter(var_0);
  thread func_10831(var_0, var_2, var_0.angles, self, "blackhole_grenade_mp");
  thread spawnblackholephysicsvolume(var_0, var_2, var_0.angles, 2750);
  thread func_13A58(var_0, var_2);
  thread watchforempents(var_0, var_2);
  var_0.scriptable setscriptablepartstate("vortexUpdate", "active", 0);
  var_0 thread func_CB0C();
  wait 2.0;
  var_0 delete();
}

func_12EB1(var_0, var_1) {
  self endon("disconnect");
  var_0 endon("death");

  if(!var_1) {
    var_0 waittill("missile_stuck", var_2);
  }

  self notify("powers_blackholeGrenade_used", 1);
  playLoopSound(var_0.origin, "blackhole_plant");
  var_0 missilethermal();
  var_0 missileoutline();
  var_0 setotherent(var_0.owner);
  var_0 setentityowner(var_0.owner);
  var_0 give_player_tickets(1);
  var_3 = scripts\mp\utility\game::_hasperk("specialty_rugged_eqp");

  if(var_3) {
    var_0.hasruggedeqp = 1;
  }

  var_4 = scripts\engine\utility::ter_op(scripts\mp\utility\game::istrue(var_3), 30, 15);
  var_5 = scripts\engine\utility::ter_op(scripts\mp\utility\game::istrue(var_3), "hitequip", "");
  var_0 thread scripts\mp\damage::monitordamage(var_4, var_5, ::bhg_handlefataldamage, ::bhg_handledamage, 0);
  var_0 thread bhg_destroyonemp();
  var_0 thread bhg_destroyongameend();
  var_0 thread scripts\mp\perks\perk_equipmentping::runequipmentping();
  thread scripts\mp\weapons::outlineequipmentforowner(var_0, self);
  var_0 bhg_addtoglobalarr();
  var_6 = getblackholecenter(var_0);
  var_7 = func_10835(var_0, var_6, var_0.angles);
  var_0.scriptable = var_7;
  var_0 notify("blackhole_grenade_stuck");
}

func_12F29(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  var_0 setscriptablepartstate("beam", "active", 0);
  var_0.scriptable setscriptablepartstate("vortexStart", "active", 0);
  wait 1.2;
  var_0 notify("blackhole_grenade_active");
}

func_12E56(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  var_1 = getblackholecenter(var_0);
  var_0.planted = 1;
  thread func_10831(var_0, var_1, var_0.angles, self, "blackhole_grenade_mp");
  thread spawnblackholephysicsvolume(var_0, var_1, var_0.angles, 2750);
  thread func_13A58(var_0, var_1);
  thread watchforempents(var_0, var_1);
  var_0.scriptable setscriptablepartstate("vortexUpdate", "active", 0);
  var_0 scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", var_0.owner, 1);
  var_0 thread func_CB0C();
  wait 2.0;
  scripts\mp\utility\game::printgameaction("black hole grenade finished", self);
  var_0 scripts\mp\sentientpoolmanager::unregistersentient(var_0.sentientpool, var_0.sentientpoolindex);
  var_0 thread bhg_destroy();
}

func_13A58(var_0, var_1) {
  self endon("disconnect");
  var_0 endon("death");
  var_0.var_11AD2 = [];
  var_2 = anglestoup(var_0.angles);
  var_3 = spawn("trigger_rotatable_radius", var_1 - var_2 * 20 * 0.5, 0, 20, 20);
  var_3.angles = var_0.angles;
  var_3 getrankxp();
  var_3 linkto(var_0);
  var_3 thread cleanuponparentdeath(var_0);
  var_4 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_sky", "physicscontents_water", "physicscontents_item"]);

  while(isDefined(var_3)) {
    var_3 waittill("trigger", var_5);

    if(!isDefined(var_5)) {
      continue;
    }
    if(var_5 func_9FAF(var_0)) {
      continue;
    }
    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_5)) {
      continue;
    }
    if(!isplayer(var_5) || isagent(var_5)) {
      continue;
    }
    if(!scripts\mp\utility\game::isreallyalive(var_5)) {
      continue;
    }
    if(scripts\mp\utility\game::func_9F72(var_5)) {
      continue;
    }
    if(!level.friendlyfire && var_5 != self && !scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(self, var_5))) {
      continue;
    }
    var_6 = "tag_eye";
    var_7 = getblackholecenter(var_0);
    var_8 = var_5 gettagorigin(var_6);
    var_9 = physics_raycast(var_7, var_8, var_4, [var_0, var_5], 0, "physicsquery_closest", 1);

    if(isDefined(var_9) && var_9.size > 0) {
      var_6 = "tag_origin";
      var_8 = var_5 gettagorigin(var_6);
      var_9 = physics_raycast(var_7, var_8, var_4, [var_0, var_5], 0, "physicsquery_closest", 1);

      if(isDefined(var_9) && var_9.size > 0) {
        continue;
      }
    }

    var_5 thread func_11AD5(var_0);
    var_5 getrandomarmkillstreak(140, var_0.origin, var_0.owner, var_0, "MOD_EXPLOSIVE", "blackhole_grenade_mp");
  }
}

watchforempents(var_0, var_1) {
  self endon("disconnect");
  var_0 endon("death");
  var_2 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_sky", "physicscontents_water", "physicscontents_item"]);
  var_3 = getblackholecenter(var_0);

  for(;;) {
    var_4 = scripts\mp\weapons::getempdamageents(var_1, 60, 0);

    foreach(var_6 in var_4) {
      if(var_6 func_9FAF(var_0) || var_6 == var_0) {
        continue;
      }
      var_7 = var_6 gettagorigin("tag_origin");
      var_8 = physics_raycast(var_3, var_7, var_2, [var_0, var_6], 0, "physicsquery_closest", 1);

      if(isDefined(var_8) && var_8.size > 0) {
        continue;
      }
      var_6 thread func_11AD5(var_0);
      var_6 getrandomarmkillstreak(140, var_0.origin, var_0.owner, var_0, "MOD_EXPLOSIVE", "blackhole_grenade_mp");
    }

    scripts\engine\utility::waitframe();
  }
}

func_10835(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_1);
  var_3.angles = var_2;
  var_3 setotherent(var_0.owner);
  var_3 setentityowner(var_0);
  var_3 setModel("prop_mp_black_hole_grenade_scr");
  var_3 linkto(var_0);
  var_3 thread func_4116(var_0);
  return var_3;
}

bhg_handlefataldamage(var_0, var_1, var_2, var_3, var_4) {
  bhg_awardpoints(var_0);
  thread bhg_destroy();
}

bhg_handledamage(var_0, var_1, var_2, var_3, var_4) {
  if(!scripts\mp\equipment\phase_shift::areentitiesinphase(var_0, self)) {
    return 0;
  }

  if(var_2 == "MOD_MELEE") {
    return self.maxhealth + 1;
  }

  var_5 = 15;
  var_6 = 1;

  if(scripts\mp\utility\game::isfmjdamage(var_1, var_2)) {
    var_6 = 2;
  } else if(var_3 >= scripts\mp\weapons::minegettwohitthreshold()) {
    var_6 = 2;
  }

  scripts\mp\powers::equipmenthit(self.owner, var_0, var_1, var_2);
  return var_6 * var_5;
}

func_4116(var_0) {
  var_0 waittill("death");
  self setscriptablepartstate("vortexStart", "neutral", 0);
  self setscriptablepartstate("vortexUpdate", "neutral", 0);
  self setscriptablepartstate("vortexEnd", "active", 0);
  wait 2;
  self delete();
}

spawnblackholephysicsvolume(var_0, var_1, var_2, var_3) {
  var_4 = _physics_volumecreate(var_1, 256);
  var_4.angles = var_2;
  var_4 linkto(var_0);
  var_4 physics_volumesetasfocalforce(1, var_1, var_3);
  var_4 physics_volumeenable(1);
  var_4 physics_volumesetactivator(1);
  var_4.time = gettime();
  var_4.var_720E = var_3;
  level.var_2ABC scripts\engine\utility::array_removeundefined(level.var_2ABC);
  var_5 = undefined;
  var_6 = 0;

  for(var_7 = 0; var_7 < 7; var_7++) {
    var_8 = level.var_2ABC[var_7];

    if(!isDefined(var_8)) {
      var_6 = var_7;
      break;
    } else if(!isDefined(var_5) || isDefined(var_5) && var_5.time > var_8.time) {
      var_5 = var_8;
      var_6 = var_7;
    }
  }

  if(isDefined(var_5)) {
    var_5 delete();
  }

  level.var_2ABC[var_6] = var_4;
  var_4 thread func_139AD();
  var_4 thread cleanuponparentdeath(var_0);
}

func_139AD() {
  self endon("death");
  var_0 = self.origin;

  for(;;) {
    if(var_0 != self.origin) {
      self physics_volumesetasfocalforce(1, self.origin, self.var_720E);
      var_0 = self.origin;
    }

    wait 0.1;
  }
}

func_10831(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _spawnimpulsefield(var_3, var_4, var_1);
  var_5.angles = var_2;
  var_5 linkto(var_0);
  thread bhg_trackimpulsefielddebuff(var_5, var_3);
  var_5 thread cleanuponparentdeath(var_0);
}

func_CB0C() {
  var_0 = spawnStruct();
  func_CB0D(var_0);
  physicsexplosionsphere(var_0.pos, 128.0, 0, 200);
}

func_CB0D(var_0) {
  self endon("death");

  for(;;) {
    var_0.pos = self.origin;
    scripts\engine\utility::waitframe();
  }
}

bhg_destroyongameend() {
  self endon("death");
  self.owner endon("disconnect");
  level scripts\engine\utility::waittill_any("game_ended", "bro_shot_start");
  thread bhg_destroy();
}

bhg_destroyonemp() {
  self endon("death");
  self.owner endon("disconnect");
  self waittill("emp_damage", var_0, var_1, var_2, var_3, var_4);

  if(isDefined(var_3) && var_3 == "emp_grenade_mp") {
    if(scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(self.owner, var_0))) {
      var_0 scripts\mp\missions::func_D991("ch_tactical_emp_eqp");
    }
  }

  bhg_awardpoints(var_0);
  var_5 = "";

  if(scripts\mp\utility\game::istrue(self.hasruggedeqp)) {
    var_5 = "hitequip";
  }

  if(isplayer(var_0)) {
    var_0 scripts\mp\damagefeedback::updatedamagefeedback(var_5);
  }

  thread bhg_destroy();
}

bhg_deleteondisowned(var_0) {
  self endon("death");
  var_0 scripts\engine\utility::waittill_any("joined_team", "joined_spectators", "disconnect");
  self delete();
}

cleanuponparentdeath(var_0, var_1) {
  self endon("death");
  self notify("cleanupOnParentDeath");
  self endon("cleanupOnParentDeath");

  if(isDefined(var_0)) {
    var_0 waittill("death");
  }

  if(isDefined(var_1)) {
    wait(var_1);
  }

  self delete();
}

func_9FAF(var_0) {
  return isDefined(var_0.var_11AD2[self getentitynumber()]);
}

func_11AD5(var_0) {
  var_0 endon("death");
  var_1 = self getentitynumber();
  var_0.var_11AD2[var_1] = self;
  func_11AD6();
  var_0.var_11AD2[var_1] = undefined;
}

func_11AD6() {
  self endon("death");
  self endon("disconnect");
  wait 0.75;
}

bhg_addtoglobalarr() {
  var_0 = self getentitynumber();

  if(isDefined(level.var_2ABD[var_0])) {
    return;
  }
  level.var_2ABD[var_0] = self;
  thread bhg_removefromglobalarrondeath();
}

bhg_removefromglobalarr(var_0) {
  self notify("blackHoleGrenade_removeFromGlobalArr");

  if(!isDefined(var_0)) {
    var_0 = self getentitynumber();
  }

  level.var_2ABD[var_0] = undefined;
}

bhg_removefromglobalarrondeath() {
  self endon("blackHoleGrenade_removeFromGlobalArr");
  var_0 = self getentitynumber();
  self waittill("death");
  thread bhg_removefromglobalarr(var_0);
}

bhg_trackimpulsefielddebuff(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.players = [];
  bhg_trackimpulsefielddebuffend(var_0, var_1, var_2);

  if(isDefined(var_1)) {
    foreach(var_4 in var_2.players) {
      if(isDefined(var_4) && scripts\mp\utility\game::isreallyalive(var_4)) {
        scripts\mp\gamescore::untrackdebuffassist(var_1, var_4, "blackhole_grenade_mp");
      }
    }
  }
}

bhg_trackimpulsefielddebuffend(var_0, var_1, var_2) {
  var_0 endon("death");
  var_1 endon("disconnect");

  for(;;) {
    var_3 = [];
    var_4 = undefined;

    if(level.teambased) {
      var_4 = scripts\mp\utility\game::clearscrambler(var_0.origin, 256, scripts\mp\utility\game::getotherteam(var_1.team), var_1);
    } else {
      var_4 = scripts\mp\utility\game::clearscrambler(var_0.origin, 256, undefined, var_1);
    }

    foreach(var_6 in var_4) {
      var_7 = var_6 getentitynumber();

      if(!scripts\mp\utility\game::isreallyalive(var_6)) {
        var_2.players[var_7] = undefined;
        continue;
      }

      if(isDefined(var_2.players[var_7])) {
        var_2.players[var_7] = undefined;
        var_3[var_7] = var_6;
        continue;
      }

      var_3[var_7] = var_6;
      scripts\mp\gamescore::func_11ACE(var_1, var_6, "blackhole_grenade_mp");
    }

    foreach(var_6 in var_2.players) {
      if(isDefined(var_6) && scripts\mp\utility\game::isreallyalive(var_6)) {
        scripts\mp\gamescore::untrackdebuffassist(var_1, var_6, "blackhole_grenade_mp");
      }
    }

    var_2.players = var_3;
    scripts\engine\utility::waitframe();
  }
}

bhg_destroy() {
  thread bhg_delete(0.1);
  self setscriptablepartstate("beam", "neutral", 0);
  self setscriptablepartstate("destroy", "active", 0);
}

bhg_delete(var_0) {
  self notify("death");
  self setCanDamage(0);
  self.exploding = 1;
  wait 0.1;
  self delete();
}

bhg_awardpoints(var_0) {
  if(scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(self.owner, var_0))) {
    var_0 notify("destroyed_equipment");
    var_0 thread scripts\mp\utility\game::giveunifiedpoints("destroyed_equipment");
  }
}

getblackholecenter(var_0) {
  if(scripts\mp\utility\game::istrue(var_0.var_9935)) {
    return var_0.origin;
  }

  if(!isDefined(var_0.centeroffset)) {
    var_1 = anglestoup(var_0.angles);
    var_2 = var_0.origin;
    var_3 = var_2 + var_1 * 55.0;
    var_4 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_sky", "physicscontents_water", "physicscontents_item"]);
    var_5 = physics_raycast(var_2, var_3, var_4, [self], 0, "physicsquery_closest");

    if(isDefined(var_5) && var_5.size > 0) {
      var_3 = var_5[0]["position"];
      var_0.centeroffset = max(3, vectordot(var_1, var_3 - var_2) - 2);
    } else
      var_0.centeroffset = 55.0;
  }

  return var_0.origin + anglestoup(var_0.angles) * var_0.centeroffset;
}