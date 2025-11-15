/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2702.gsc
***************************************/

blackholegrenadeinit() {
  level.func_2ABD = [];
  level.func_2ABC = [];
}

blackholeminetrigger() {
  scripts\mp\weapons::makeexplosiveunusable();
  self.owner blackholegrenadeused(self, 1);
}

blackholemineexplode() {}

blackholegrenadeused(var_00, var_01) {
  var_00 endon("death");

  if(!isDefined(var_01))
    var_01 = 0;

  scripts\mp\utility\game::printgameaction("black hole grenade spawned", self);
  thread bhg_deleteondisowned(var_00);
  var_0.state = 0;
  thread func_12EB1(var_00, var_01);

  if(!var_01) {
    var_00 waittill("blackhole_grenade_stuck");

    if(!isDefined(var_00))
      return;
  }

  var_0.state = 1;
  thread func_12F29(var_00);
  var_00 waittill("blackhole_grenade_active");

  if(!isDefined(var_00)) {
    return;
  }
  var_0.state = 2;
  thread func_12E56(var_00);
  var_00 waittill("blackhole_grenade_finished");

  if(!isDefined(var_00))
    return;
}

func_2B3E(var_00) {
  var_00 endon("death");
  thread bhg_deleteondisowned(var_00);
  var_0.func_9935 = 1;
  var_01 = spawn("script_model", var_0.origin);
  var_01 setotherent(var_0.owner);
  var_01 setModel("prop_mp_black_hole_grenade_scr");
  var_01 give_player_tickets(1);
  var_01 linkto(var_00);
  var_01 thread func_4116(var_00);
  var_0.scriptable = var_01;
  var_02 = getblackholecenter(var_00);
  thread func_10831(var_00, var_02, var_0.angles, self, "blackhole_grenade_mp");
  thread spawnblackholephysicsvolume(var_00, var_02, var_0.angles, 2750);
  thread func_13A58(var_00, var_02);
  thread watchforempents(var_00, var_02);
  var_0.scriptable setscriptablepartstate("vortexUpdate", "active", 0);
  var_00 thread func_CB0C();
  wait 2.0;
  var_00 delete();
}

func_12EB1(var_00, var_01) {
  self endon("disconnect");
  var_00 endon("death");

  if(!var_01)
    var_00 waittill("missile_stuck", var_02);

  self notify("powers_blackholeGrenade_used", 1);
  playLoopSound(var_0.origin, "blackhole_plant");
  var_00 missilethermal();
  var_00 missileoutline();
  var_00 setotherent(var_0.owner);
  var_00 setentityowner(var_0.owner);
  var_00 give_player_tickets(1);
  var_03 = scripts\mp\utility\game::_hasperk("specialty_rugged_eqp");

  if(var_03)
    var_0.hasruggedeqp = 1;

  var_04 = scripts\engine\utility::ter_op(scripts\mp\utility\game::istrue(var_03), 30, 15);
  var_05 = scripts\engine\utility::ter_op(scripts\mp\utility\game::istrue(var_03), "hitequip", "");
  var_00 thread scripts\mp\damage::monitordamage(var_04, var_05, ::bhg_handlefataldamage, ::bhg_handledamage, 0);
  var_00 thread bhg_destroyonemp();
  var_00 thread bhg_destroyongameend();
  var_00 thread scripts\mp\perks\perk_equipmentping::runequipmentping();
  thread scripts\mp\weapons::outlineequipmentforowner(var_00, self);
  var_00 bhg_addtoglobalarr();
  var_06 = getblackholecenter(var_00);
  var_07 = func_10835(var_00, var_06, var_0.angles);
  var_0.scriptable = var_07;
  var_00 notify("blackhole_grenade_stuck");
}

func_12F29(var_00) {
  self endon("disconnect");
  var_00 endon("death");
  var_00 setscriptablepartstate("beam", "active", 0);
  var_0.scriptable setscriptablepartstate("vortexStart", "active", 0);
  wait 1.2;
  var_00 notify("blackhole_grenade_active");
}

func_12E56(var_00) {
  self endon("disconnect");
  var_00 endon("death");
  var_01 = getblackholecenter(var_00);
  var_0.planted = 1;
  thread func_10831(var_00, var_01, var_0.angles, self, "blackhole_grenade_mp");
  thread spawnblackholephysicsvolume(var_00, var_01, var_0.angles, 2750);
  thread func_13A58(var_00, var_01);
  thread watchforempents(var_00, var_01);
  var_0.scriptable setscriptablepartstate("vortexUpdate", "active", 0);
  var_00 scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", var_0.owner, 1);
  var_00 thread func_CB0C();
  wait 2.0;
  scripts\mp\utility\game::printgameaction("black hole grenade finished", self);
  var_00 scripts\mp\sentientpoolmanager::unregistersentient(var_0.sentientpool, var_0.sentientpoolindex);
  var_00 thread bhg_destroy();
}

func_13A58(var_00, var_01) {
  self endon("disconnect");
  var_00 endon("death");
  var_0.func_11AD2 = [];
  var_02 = anglestoup(var_0.angles);
  var_03 = spawn("trigger_rotatable_radius", var_01 - var_02 * 20 * 0.5, 0, 20, 20);
  var_3.angles = var_0.angles;
  var_03 getrankxp();
  var_03 linkto(var_00);
  var_03 thread cleanuponparentdeath(var_00);
  var_04 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_sky", "physicscontents_water", "physicscontents_item"]);

  while(isDefined(var_03)) {
    var_03 waittill("trigger", var_05);

    if(!isDefined(var_05)) {
      continue;
    }
    if(var_05 func_9FAF(var_00)) {
      continue;
    }
    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_05)) {
      continue;
    }
    if(!isplayer(var_05) || isagent(var_05)) {
      continue;
    }
    if(!scripts\mp\utility\game::isreallyalive(var_05)) {
      continue;
    }
    if(scripts\mp\utility\game::func_9F72(var_05)) {
      continue;
    }
    if(!level.friendlyfire && var_05 != self && !scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(self, var_05))) {
      continue;
    }
    var_06 = "tag_eye";
    var_07 = getblackholecenter(var_00);
    var_08 = var_05 gettagorigin(var_06);
    var_09 = physics_raycast(var_07, var_08, var_04, [var_00, var_05], 0, "physicsquery_closest", 1);

    if(isDefined(var_09) && var_9.size > 0) {
      var_06 = "tag_origin";
      var_08 = var_05 gettagorigin(var_06);
      var_09 = physics_raycast(var_07, var_08, var_04, [var_00, var_05], 0, "physicsquery_closest", 1);

      if(isDefined(var_09) && var_9.size > 0)
        continue;
    }

    var_05 thread func_11AD5(var_00);
    var_05 getrandomarmkillstreak(140, var_0.origin, var_0.owner, var_00, "MOD_EXPLOSIVE", "blackhole_grenade_mp");
  }
}

watchforempents(var_00, var_01) {
  self endon("disconnect");
  var_00 endon("death");
  var_02 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_sky", "physicscontents_water", "physicscontents_item"]);
  var_03 = getblackholecenter(var_00);

  for(;;) {
    var_04 = scripts\mp\weapons::getempdamageents(var_01, 60, 0);

    foreach(var_06 in var_04) {
      if(var_06 func_9FAF(var_00) || var_06 == var_00) {
        continue;
      }
      var_07 = var_06 gettagorigin("tag_origin");
      var_08 = physics_raycast(var_03, var_07, var_02, [var_00, var_06], 0, "physicsquery_closest", 1);

      if(isDefined(var_08) && var_8.size > 0) {
        continue;
      }
      var_06 thread func_11AD5(var_00);
      var_06 getrandomarmkillstreak(140, var_0.origin, var_0.owner, var_00, "MOD_EXPLOSIVE", "blackhole_grenade_mp");
    }

    scripts\engine\utility::waitframe();
  }
}

func_10835(var_00, var_01, var_02) {
  var_03 = spawn("script_model", var_01);
  var_3.angles = var_02;
  var_03 setotherent(var_0.owner);
  var_03 setentityowner(var_00);
  var_03 setModel("prop_mp_black_hole_grenade_scr");
  var_03 linkto(var_00);
  var_03 thread func_4116(var_00);
  return var_03;
}

bhg_handlefataldamage(var_00, var_01, var_02, var_03, var_04) {
  bhg_awardpoints(var_00);
  thread bhg_destroy();
}

bhg_handledamage(var_00, var_01, var_02, var_03, var_04) {
  if(!scripts\mp\equipment\phase_shift::areentitiesinphase(var_00, self))
    return 0;

  if(var_02 == "MOD_MELEE")
    return self.maxhealth + 1;

  var_05 = 15;
  var_06 = 1;

  if(scripts\mp\utility\game::isfmjdamage(var_01, var_02))
    var_06 = 2;
  else if(var_03 >= scripts\mp\weapons::minegettwohitthreshold())
    var_06 = 2;

  scripts\mp\powers::equipmenthit(self.owner, var_00, var_01, var_02);
  return var_06 * var_05;
}

func_4116(var_00) {
  var_00 waittill("death");
  self setscriptablepartstate("vortexStart", "neutral", 0);
  self setscriptablepartstate("vortexUpdate", "neutral", 0);
  self setscriptablepartstate("vortexEnd", "active", 0);
  wait 2;
  self delete();
}

spawnblackholephysicsvolume(var_00, var_01, var_02, var_03) {
  var_04 = _physics_volumecreate(var_01, 256);
  var_4.angles = var_02;
  var_04 linkto(var_00);
  var_04 physics_volumesetasfocalforce(1, var_01, var_03);
  var_04 physics_volumeenable(1);
  var_04 physics_volumesetactivator(1);
  var_4.time = gettime();
  var_4.func_720E = var_03;
  level.func_2ABC scripts\engine\utility::array_removeundefined(level.func_2ABC);
  var_05 = undefined;
  var_06 = 0;

  for(var_07 = 0; var_07 < 7; var_7++) {
    var_08 = level.func_2ABC[var_07];

    if(!isDefined(var_08)) {
      var_06 = var_07;
      break;
    } else if(!isDefined(var_05) || isDefined(var_05) && var_5.time > var_8.time) {
      var_05 = var_08;
      var_06 = var_07;
    }
  }

  if(isDefined(var_05))
    var_05 delete();

  level.func_2ABC[var_06] = var_04;
  var_04 thread func_139AD();
  var_04 thread cleanuponparentdeath(var_00);
}

func_139AD() {
  self endon("death");
  var_00 = self.origin;

  for(;;) {
    if(var_00 != self.origin) {
      self physics_volumesetasfocalforce(1, self.origin, self.func_720E);
      var_00 = self.origin;
    }

    wait 0.1;
  }
}

func_10831(var_00, var_01, var_02, var_03, var_04) {
  var_05 = _spawnimpulsefield(var_03, var_04, var_01);
  var_5.angles = var_02;
  var_05 linkto(var_00);
  thread bhg_trackimpulsefielddebuff(var_05, var_03);
  var_05 thread cleanuponparentdeath(var_00);
}

func_CB0C() {
  var_00 = spawnStruct();
  func_CB0D(var_00);
  physicsexplosionsphere(var_0.pos, 128.0, 0, 200);
}

func_CB0D(var_00) {
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
  self waittill("emp_damage", var_00, var_01, var_02, var_03, var_04);

  if(isDefined(var_03) && var_03 == "emp_grenade_mp") {
    if(scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(self.owner, var_00)))
      var_00 scripts\mp\missions::func_D991("ch_tactical_emp_eqp");
  }

  bhg_awardpoints(var_00);
  var_05 = "";

  if(scripts\mp\utility\game::istrue(self.hasruggedeqp))
    var_05 = "hitequip";

  if(isplayer(var_00))
    var_00 scripts\mp\damagefeedback::updatedamagefeedback(var_05);

  thread bhg_destroy();
}

bhg_deleteondisowned(var_00) {
  self endon("death");
  var_00 scripts\engine\utility::waittill_any("joined_team", "joined_spectators", "disconnect");
  self delete();
}

cleanuponparentdeath(var_00, var_01) {
  self endon("death");
  self notify("cleanupOnParentDeath");
  self endon("cleanupOnParentDeath");

  if(isDefined(var_00))
    var_00 waittill("death");

  if(isDefined(var_01))
    wait(var_01);

  self delete();
}

func_9FAF(var_00) {
  return isDefined(var_0.func_11AD2[self getentitynumber()]);
}

func_11AD5(var_00) {
  var_00 endon("death");
  var_01 = self getentitynumber();
  var_0.func_11AD2[var_01] = self;
  func_11AD6();
  var_0.func_11AD2[var_01] = undefined;
}

func_11AD6() {
  self endon("death");
  self endon("disconnect");
  wait 0.75;
}

bhg_addtoglobalarr() {
  var_00 = self getentitynumber();

  if(isDefined(level.func_2ABD[var_00])) {
    return;
  }
  level.func_2ABD[var_00] = self;
  thread bhg_removefromglobalarrondeath();
}

bhg_removefromglobalarr(var_00) {
  self notify("blackHoleGrenade_removeFromGlobalArr");

  if(!isDefined(var_00))
    var_00 = self getentitynumber();

  level.func_2ABD[var_00] = undefined;
}

bhg_removefromglobalarrondeath() {
  self endon("blackHoleGrenade_removeFromGlobalArr");
  var_00 = self getentitynumber();
  self waittill("death");
  thread bhg_removefromglobalarr(var_00);
}

bhg_trackimpulsefielddebuff(var_00, var_01) {
  var_02 = spawnStruct();
  var_2.players = [];
  bhg_trackimpulsefielddebuffend(var_00, var_01, var_02);

  if(isDefined(var_01)) {
    foreach(var_04 in var_2.players) {
      if(isDefined(var_04) && scripts\mp\utility\game::isreallyalive(var_04))
        scripts\mp\gamescore::untrackdebuffassist(var_01, var_04, "blackhole_grenade_mp");
    }
  }
}

bhg_trackimpulsefielddebuffend(var_00, var_01, var_02) {
  var_00 endon("death");
  var_01 endon("disconnect");

  for(;;) {
    var_03 = [];
    var_04 = undefined;

    if(level.teambased)
      var_04 = scripts\mp\utility\game::clearscrambler(var_0.origin, 256, scripts\mp\utility\game::getotherteam(var_1.team), var_01);
    else
      var_04 = scripts\mp\utility\game::clearscrambler(var_0.origin, 256, undefined, var_01);

    foreach(var_06 in var_04) {
      var_07 = var_06 getentitynumber();

      if(!scripts\mp\utility\game::isreallyalive(var_06)) {
        var_2.players[var_07] = undefined;
        continue;
      }

      if(isDefined(var_2.players[var_07])) {
        var_2.players[var_07] = undefined;
        var_3[var_07] = var_06;
        continue;
      }

      var_3[var_07] = var_06;
      scripts\mp\gamescore::func_11ACE(var_01, var_06, "blackhole_grenade_mp");
    }

    foreach(var_06 in var_2.players) {
      if(isDefined(var_06) && scripts\mp\utility\game::isreallyalive(var_06))
        scripts\mp\gamescore::untrackdebuffassist(var_01, var_06, "blackhole_grenade_mp");
    }

    var_2.players = var_03;
    scripts\engine\utility::waitframe();
  }
}

bhg_destroy() {
  thread bhg_delete(0.1);
  self setscriptablepartstate("beam", "neutral", 0);
  self setscriptablepartstate("destroy", "active", 0);
}

bhg_delete(var_00) {
  self notify("death");
  self setCanDamage(0);
  self.exploding = 1;
  wait 0.1;
  self delete();
}

bhg_awardpoints(var_00) {
  if(scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(self.owner, var_00))) {
    var_00 notify("destroyed_equipment");
    var_00 thread scripts\mp\utility\game::giveunifiedpoints("destroyed_equipment");
  }
}

getblackholecenter(var_00) {
  if(scripts\mp\utility\game::istrue(var_0.func_9935))
    return var_0.origin;

  if(!isDefined(var_0.centeroffset)) {
    var_01 = anglestoup(var_0.angles);
    var_02 = var_0.origin;
    var_03 = var_02 + var_01 * 55.0;
    var_04 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_sky", "physicscontents_water", "physicscontents_item"]);
    var_05 = physics_raycast(var_02, var_03, var_04, [self], 0, "physicsquery_closest");

    if(isDefined(var_05) && var_5.size > 0) {
      var_03 = var_5[0]["position"];
      var_0.centeroffset = max(3, vectordot(var_01, var_03 - var_02) - 2);
    } else
      var_0.centeroffset = 55.0;
  }

  return var_0.origin + anglestoup(var_0.angles) * var_0.centeroffset;
}