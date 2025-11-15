/********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\blackhole_grenade.gsc
********************************************/

blackholegrenadeinit() {
  level.var_2ABD = [];
  level.var_2ABC = [];
}

blackholeminetrigger() {
  scripts\mp\weapons::makeexplosiveunusable();
  self.triggerportableradarping blackholegrenadeused(self, 1);
}

blackholemineexplode() {}

blackholegrenadeused(param_00, param_01) {
  param_00 endon("death");
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  scripts\mp\utility::printgameaction("black hole grenade spawned", self);
  thread bhg_deleteondisowned(param_00);
  param_00.state = 0;
  thread func_12EB1(param_00, param_01);
  if(!param_01) {
    param_00 waittill("blackhole_grenade_stuck");
    if(!isDefined(param_00)) {
      return;
    }
  }

  param_00.state = 1;
  thread func_12F29(param_00);
  param_00 waittill("blackhole_grenade_active");
  if(!isDefined(param_00)) {
    return;
  }

  param_00.state = 2;
  thread func_12E56(param_00);
  param_00 waittill("blackhole_grenade_finished");
  if(!isDefined(param_00)) {}
}

func_2B3E(param_00) {
  param_00 endon("death");
  thread bhg_deleteondisowned(param_00);
  param_00.var_9935 = 1;
  var_01 = spawn("script_model", param_00.origin);
  var_01 setotherent(param_00.triggerportableradarping);
  var_01 setModel("prop_mp_black_hole_grenade_scr");
  var_01 give_player_tickets(1);
  var_01 linkto(param_00);
  var_01 thread func_4116(param_00);
  param_00.physics_capsulecast = var_01;
  var_02 = getblackholecenter(param_00);
  thread func_10831(param_00, var_02, param_00.angles, self, "blackhole_grenade_mp");
  thread spawnblackholephysicsvolume(param_00, var_02, param_00.angles, 2750);
  thread func_13A58(param_00, var_02);
  thread watchforempents(param_00, var_02);
  param_00.physics_capsulecast setscriptablepartstate("vortexUpdate", "active", 0);
  param_00 thread func_CB0C();
  wait(2);
  param_00 delete();
}

func_12EB1(param_00, param_01) {
  self endon("disconnect");
  param_00 endon("death");
  if(!param_01) {
    param_00 waittill("missile_stuck", var_02);
  }

  self notify("powers_blackholeGrenade_used", 1);
  playsoundatpos(param_00.origin, "blackhole_plant");
  param_00 missilethermal();
  param_00 missileoutline();
  param_00 setotherent(param_00.triggerportableradarping);
  param_00 setentityowner(param_00.triggerportableradarping);
  param_00 give_player_tickets(1);
  var_03 = scripts\mp\utility::_hasperk("specialty_rugged_eqp");
  if(var_03) {
    param_00.hasruggedeqp = 1;
  }

  var_04 = scripts\engine\utility::ter_op(scripts\mp\utility::istrue(var_03), 30, 15);
  var_05 = scripts\engine\utility::ter_op(scripts\mp\utility::istrue(var_03), "hitequip", "");
  param_00 thread scripts\mp\damage::monitordamage(var_04, var_05, ::bhg_handlefataldamage, ::bhg_handledamage, 0);
  param_00 thread bhg_destroyonemp();
  param_00 thread bhg_destroyongameend();
  param_00 thread scripts\mp\perks\_perk_equipmentping::runequipmentping();
  thread scripts\mp\weapons::outlineequipmentforowner(param_00, self);
  param_00 bhg_addtoglobalarr();
  var_06 = getblackholecenter(param_00);
  var_07 = func_10835(param_00, var_06, param_00.angles);
  param_00.physics_capsulecast = var_07;
  param_00 notify("blackhole_grenade_stuck");
}

func_12F29(param_00) {
  self endon("disconnect");
  param_00 endon("death");
  param_00 setscriptablepartstate("beam", "active", 0);
  param_00.physics_capsulecast setscriptablepartstate("vortexStart", "active", 0);
  wait(1.2);
  param_00 notify("blackhole_grenade_active");
}

func_12E56(param_00) {
  self endon("disconnect");
  param_00 endon("death");
  var_01 = getblackholecenter(param_00);
  param_00.planted = 1;
  thread func_10831(param_00, var_01, param_00.angles, self, "blackhole_grenade_mp");
  thread spawnblackholephysicsvolume(param_00, var_01, param_00.angles, 2750);
  thread func_13A58(param_00, var_01);
  thread watchforempents(param_00, var_01);
  param_00.physics_capsulecast setscriptablepartstate("vortexUpdate", "active", 0);
  param_00 scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", param_00.triggerportableradarping, 1);
  param_00 thread func_CB0C();
  wait(2);
  scripts\mp\utility::printgameaction("black hole grenade finished", self);
  param_00 scripts\mp\sentientpoolmanager::unregistersentient(param_00.sentientpool, param_00.sentientpoolindex);
  param_00 thread bhg_destroy();
}

func_13A58(param_00, param_01) {
  self endon("disconnect");
  param_00 endon("death");
  param_00.var_11AD2 = [];
  var_02 = anglestoup(param_00.angles);
  var_03 = spawn("trigger_rotatable_radius", param_01 - var_02 * 20 * 0.5, 0, 20, 20);
  var_03.angles = param_00.angles;
  var_03 enablelinkto();
  var_03 linkto(param_00);
  var_03 thread cleanuponparentdeath(param_00);
  var_04 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_sky", "physicscontents_water", "physicscontents_item"]);
  while(isDefined(var_03)) {
    var_03 waittill("trigger", var_05);
    if(!isDefined(var_05)) {
      continue;
    }

    if(var_05 func_9FAF(param_00)) {
      continue;
    }

    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_05)) {
      continue;
    }

    if(!isplayer(var_05) || isagent(var_05)) {
      continue;
    }

    if(!scripts\mp\utility::isreallyalive(var_05)) {
      continue;
    }

    if(scripts\mp\utility::func_9F72(var_05)) {
      continue;
    }

    if(!level.friendlyfire && var_05 != self && !scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self, var_05))) {
      continue;
    }

    var_06 = "tag_eye";
    var_07 = getblackholecenter(param_00);
    var_08 = var_05 gettagorigin(var_06);
    var_09 = physics_raycast(var_07, var_08, var_04, [param_00, var_05], 0, "physicsquery_closest", 1);
    if(isDefined(var_09) && var_09.size > 0) {
      var_06 = "tag_origin";
      var_08 = var_05 gettagorigin(var_06);
      var_09 = physics_raycast(var_07, var_08, var_04, [param_00, var_05], 0, "physicsquery_closest", 1);
      if(isDefined(var_09) && var_09.size > 0) {
        continue;
      }
    }

    var_05 thread func_11AD5(param_00);
    var_05 dodamage(140, param_00.origin, param_00.triggerportableradarping, param_00, "MOD_EXPLOSIVE", "blackhole_grenade_mp");
  }
}

watchforempents(param_00, param_01) {
  self endon("disconnect");
  param_00 endon("death");
  var_02 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_sky", "physicscontents_water", "physicscontents_item"]);
  var_03 = getblackholecenter(param_00);
  for(;;) {
    var_04 = scripts\mp\weapons::getempdamageents(param_01, 60, 0);
    foreach(var_06 in var_04) {
      if(var_06 func_9FAF(param_00) || var_06 == param_00) {
        continue;
      }

      var_07 = var_06 gettagorigin("tag_origin");
      var_08 = physics_raycast(var_03, var_07, var_02, [param_00, var_06], 0, "physicsquery_closest", 1);
      if(isDefined(var_08) && var_08.size > 0) {
        continue;
      }

      var_06 thread func_11AD5(param_00);
      var_06 dodamage(140, param_00.origin, param_00.triggerportableradarping, param_00, "MOD_EXPLOSIVE", "blackhole_grenade_mp");
    }

    scripts\engine\utility::waitframe();
  }
}

func_10835(param_00, param_01, param_02) {
  var_03 = spawn("script_model", param_01);
  var_03.angles = param_02;
  var_03 setotherent(param_00.triggerportableradarping);
  var_03 setentityowner(param_00);
  var_03 setModel("prop_mp_black_hole_grenade_scr");
  var_03 linkto(param_00);
  var_03 thread func_4116(param_00);
  return var_03;
}

bhg_handlefataldamage(param_00, param_01, param_02, param_03, param_04) {
  bhg_awardpoints(param_00);
  thread bhg_destroy();
}

bhg_handledamage(param_00, param_01, param_02, param_03, param_04) {
  if(!scripts\mp\equipment\phase_shift::areentitiesinphase(param_00, self)) {
    return 0;
  }

  if(param_02 == "MOD_MELEE") {
    return self.maxhealth + 1;
  }

  var_05 = 15;
  var_06 = 1;
  if(scripts\mp\utility::isfmjdamage(param_01, param_02)) {
    var_06 = 2;
  } else if(param_03 >= scripts\mp\weapons::minegettwohitthreshold()) {
    var_06 = 2;
  }

  scripts\mp\powers::equipmenthit(self.triggerportableradarping, param_00, param_01, param_02);
  return var_06 * var_05;
}

func_4116(param_00) {
  param_00 waittill("death");
  self setscriptablepartstate("vortexStart", "neutral", 0);
  self setscriptablepartstate("vortexUpdate", "neutral", 0);
  self setscriptablepartstate("vortexEnd", "active", 0);
  wait(2);
  self delete();
}

spawnblackholephysicsvolume(param_00, param_01, param_02, param_03) {
  var_04 = physics_volumecreate(param_01, 256);
  var_04.angles = param_02;
  var_04 linkto(param_00);
  var_04 physics_volumesetasfocalforce(1, param_01, param_03);
  var_04 physics_volumeenable(1);
  var_04 physics_volumesetactivator(1);
  var_04.time = gettime();
  var_04.var_720E = param_03;
  level.var_2ABC scripts\engine\utility::array_removeundefined(level.var_2ABC);
  var_05 = undefined;
  var_06 = 0;
  for(var_07 = 0; var_07 < 7; var_07++) {
    var_08 = level.var_2ABC[var_07];
    if(!isDefined(var_08)) {
      var_06 = var_07;
      break;
    } else if(!isDefined(var_05) || isDefined(var_05) && var_05.time > var_08.time) {
      var_05 = var_08;
      var_06 = var_07;
    }
  }

  if(isDefined(var_05)) {
    var_05 delete();
  }

  level.var_2ABC[var_06] = var_04;
  var_04 thread func_139AD();
  var_04 thread cleanuponparentdeath(param_00);
}

func_139AD() {
  self endon("death");
  var_00 = self.origin;
  for(;;) {
    if(var_00 != self.origin) {
      self physics_volumesetasfocalforce(1, self.origin, self.var_720E);
      var_00 = self.origin;
    }

    wait(0.1);
  }
}

func_10831(param_00, param_01, param_02, param_03, param_04) {
  var_05 = spawnimpulsefield(param_03, param_04, param_01);
  var_05.angles = param_02;
  var_05 linkto(param_00);
  thread bhg_trackimpulsefielddebuff(var_05, param_03);
  var_05 thread cleanuponparentdeath(param_00);
}

func_CB0C() {
  var_00 = spawnStruct();
  func_CB0D(var_00);
  physicsexplosionsphere(var_00.pos, 128, 0, 200);
}

func_CB0D(param_00) {
  self endon("death");
  for(;;) {
    param_00.pos = self.origin;
    scripts\engine\utility::waitframe();
  }
}

bhg_destroyongameend() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  level scripts\engine\utility::waittill_any_3("game_ended", "bro_shot_start");
  thread bhg_destroy();
}

bhg_destroyonemp() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  self waittill("emp_damage", var_00, var_01, var_02, var_03, var_04);
  if(isDefined(var_03) && var_03 == "emp_grenade_mp") {
    if(scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, var_00))) {
      var_00 scripts\mp\missions::func_D991("ch_tactical_emp_eqp");
    }
  }

  bhg_awardpoints(var_00);
  var_05 = "";
  if(scripts\mp\utility::istrue(self.hasruggedeqp)) {
    var_05 = "hitequip";
  }

  if(isplayer(var_00)) {
    var_00 scripts\mp\damagefeedback::updatedamagefeedback(var_05);
  }

  thread bhg_destroy();
}

bhg_deleteondisowned(param_00) {
  self endon("death");
  param_00 scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators", "disconnect");
  self delete();
}

cleanuponparentdeath(param_00, param_01) {
  self endon("death");
  self notify("cleanupOnParentDeath");
  self endon("cleanupOnParentDeath");
  if(isDefined(param_00)) {
    param_00 waittill("death");
  }

  if(isDefined(param_01)) {
    wait(param_01);
  }

  self delete();
}

func_9FAF(param_00) {
  return isDefined(param_00.var_11AD2[self getentitynumber()]);
}

func_11AD5(param_00) {
  param_00 endon("death");
  var_01 = self getentitynumber();
  param_00.var_11AD2[var_01] = self;
  func_11AD6();
  param_00.var_11AD2[var_01] = undefined;
}

func_11AD6() {
  self endon("death");
  self endon("disconnect");
  wait(0.75);
}

bhg_addtoglobalarr() {
  var_00 = self getentitynumber();
  if(isDefined(level.var_2ABD[var_00])) {
    return;
  }

  level.var_2ABD[var_00] = self;
  thread bhg_removefromglobalarrondeath();
}

bhg_removefromglobalarr(param_00) {
  self notify("blackHoleGrenade_removeFromGlobalArr");
  if(!isDefined(param_00)) {
    param_00 = self getentitynumber();
  }

  level.var_2ABD[param_00] = undefined;
}

bhg_removefromglobalarrondeath() {
  self endon("blackHoleGrenade_removeFromGlobalArr");
  var_00 = self getentitynumber();
  self waittill("death");
  thread bhg_removefromglobalarr(var_00);
}

bhg_trackimpulsefielddebuff(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.players = [];
  bhg_trackimpulsefielddebuffend(param_00, param_01, var_02);
  if(isDefined(param_01)) {
    foreach(var_04 in var_02.players) {
      if(isDefined(var_04) && scripts\mp\utility::isreallyalive(var_04)) {
        scripts\mp\gamescore::untrackdebuffassist(param_01, var_04, "blackhole_grenade_mp");
      }
    }
  }
}

bhg_trackimpulsefielddebuffend(param_00, param_01, param_02) {
  param_00 endon("death");
  param_01 endon("disconnect");
  for(;;) {
    var_03 = [];
    var_04 = undefined;
    if(level.teambased) {
      var_04 = scripts\mp\utility::clearscrambler(param_00.origin, 256, scripts\mp\utility::getotherteam(param_01.team), param_01);
    } else {
      var_04 = scripts\mp\utility::clearscrambler(param_00.origin, 256, undefined, param_01);
    }

    foreach(var_06 in var_04) {
      var_07 = var_06 getentitynumber();
      if(!scripts\mp\utility::isreallyalive(var_06)) {
        param_02.players[var_07] = undefined;
        continue;
      }

      if(isDefined(param_02.players[var_07])) {
        param_02.players[var_07] = undefined;
        var_03[var_07] = var_06;
        continue;
      }

      var_03[var_07] = var_06;
      scripts\mp\gamescore::func_11ACE(param_01, var_06, "blackhole_grenade_mp");
    }

    foreach(var_06 in param_02.players) {
      if(isDefined(var_06) && scripts\mp\utility::isreallyalive(var_06)) {
        scripts\mp\gamescore::untrackdebuffassist(param_01, var_06, "blackhole_grenade_mp");
      }
    }

    param_02.players = var_03;
    scripts\engine\utility::waitframe();
  }
}

bhg_destroy() {
  thread bhg_delete(0.1);
  self setscriptablepartstate("beam", "neutral", 0);
  self setscriptablepartstate("destroy", "active", 0);
}

bhg_delete(param_00) {
  self notify("death");
  self setCanDamage(0);
  self.exploding = 1;
  wait(0.1);
  self delete();
}

bhg_awardpoints(param_00) {
  if(scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, param_00))) {
    param_00 notify("destroyed_equipment");
    param_00 thread scripts\mp\utility::giveunifiedpoints("destroyed_equipment");
  }
}

getblackholecenter(param_00) {
  if(scripts\mp\utility::istrue(param_00.var_9935)) {
    return param_00.origin;
  }

  if(!isDefined(param_00.centeroffset)) {
    var_01 = anglestoup(param_00.angles);
    var_02 = param_00.origin;
    var_03 = var_02 + var_01 * 55;
    var_04 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_sky", "physicscontents_water", "physicscontents_item"]);
    var_05 = physics_raycast(var_02, var_03, var_04, [self], 0, "physicsquery_closest");
    if(isDefined(var_05) && var_05.size > 0) {
      var_03 = var_05[0]["position"];
      param_00.centeroffset = max(3, vectordot(var_01, var_03 - var_02) - 2);
    } else {
      param_00.centeroffset = 55;
    }
  }

  return param_00.origin + anglestoup(param_00.angles) * param_00.centeroffset;
}