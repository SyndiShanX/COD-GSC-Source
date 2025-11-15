/***************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\equipment\spider_grenade.gsc
***************************************************/

spidergrenade_init() {
  var_00 = spawnStruct();
  var_00.agents = [];
  var_00.activeagents = [];
  var_00.proxies = [];
  level.spidergrenade = var_00;
}

spidergrenade_used(param_00) {
  param_00 endon("death");
  if(!spidergrenade_agentavailable()) {
    spidergrenade_freeactiveagent();
  }

  param_00 thread spidergrenade_cleanuponownerdisconnect();
  param_00 waittill("missile_stuck", var_01);
  param_00 missilethermal();
  param_00 missileoutline();
  if(isplayer(var_01)) {
    thread spidergrenade_stuckplayer(param_00, var_01);
    return;
  }

  thread spidergrenade_stuckground(param_00, var_01);
}

spidergrenade_stuckground(param_00, param_01) {
  param_00 endon("death");
  spidergrenade_proxyinitialize(param_00);
  var_02 = spidergrenade_getplacementinfo(param_00, param_00.origin);
  if(var_02.var_38EE) {
    param_00 unlink();
    param_00 dontinterpolate();
    param_00.origin = var_02.weaponisauto;
    param_00.canbecomeagent = 1;
  } else {
    param_00.canbecomeagent = 0;
  }

  param_00 thread spidergrenade_setstate(0, param_01);
}

spidergrenade_stuckplayer(param_00, param_01) {
  spidergrenade_proxyinitialize(param_00);
  if(scripts\mp\utility::isreallyalive(param_01)) {
    param_00 linkto(param_01, "j_head", (3, -5, 0), (0, 0, 90));
  }

  scripts\mp\weapons::grenadestuckto(param_00, param_01);
  param_00 thread spidergrenade_setstate(3, param_01);
}

spidergrenade_destroy() {
  if(isagent(self)) {
    var_00 = self.proxy;
    if(isalive(self)) {
      self suicide();
    }

    if(isDefined(var_00) && !scripts\mp\utility::istrue(var_00.exploding)) {
      var_00 thread spidergrenade_destroy();
    }

    return;
  }

  scripts\mp\utility::printgameaction("spider grenade destroy", self.triggerportableradarping);
  self show();
  thread spidergrenade_delete(0.1);
  self setscriptablepartstate("beacon", "neutral", 0);
  self setscriptablepartstate("anims", "neutral", 0);
  self setscriptablepartstate("destroy", "active", 0);
}

spidergrenade_explode() {
  if(isagent(self)) {
    var_00 = self.proxy;
    if(isalive(self)) {
      self suicide();
    }

    if(isDefined(var_00) && !scripts\mp\utility::istrue(var_00.exploding)) {
      var_00 thread spidergrenade_explode();
    }

    return;
  }

  scripts\mp\utility::printgameaction("spider grenade explode", self.triggerportableradarping);
  self show();
  thread spidergrenade_delete(0.1);
  self setscriptablepartstate("beacon", "neutral", 0);
  self setscriptablepartstate("anims", "neutral", 0);
  self setscriptablepartstate("explode", "active", 0);
}

spidergrenade_delete(param_00) {
  self notify("death");
  self setCanDamage(0);
  self.exploding = 1;
  wait(param_00);
  self delete();
}

spidergrenade_setstate(param_00, param_01) {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  self notify("spiderGrenade_setState");
  self endon("spiderGrenade_setState");
  switch (param_00) {
    case 0:
      self setscriptablepartstate("beacon", "activeSeek", 0);
      self setscriptablepartstate("anims", "activeSeek", 0);
      var_02 = gettime() + lib_0C26::getseekenemytimeout();
      var_03 = undefined;
      while(gettime() <= var_02) {
        var_03 = lib_0C26::func_7FDB();
        if(isDefined(var_03)) {
          break;
        }

        scripts\engine\utility::waitframe();
      }

      if(spidergrenade_agentavailable() && isDefined(var_03)) {
        var_04 = lib_0F6E::func_1090C(self.origin, self.angles, self.triggerportableradarping);
        if(isDefined(var_04)) {
          var_04.var_F181 = var_03;
          thread spidergrenade_proxytoagent(self, var_04);
          return;
        }
      }

      thread spidergrenade_setstate(2);
      break;

    case 1:
      self setscriptablepartstate("beacon", "activeChase", 0);
      self setscriptablepartstate("anims", "activeChase", 0);
      wait(lib_0C26::func_7E27() / 1000);
      thread spidergrenade_setstate(2);
      break;

    case 2:
      self setscriptablepartstate("beacon", "activeExplode", 0);
      self setscriptablepartstate("anims", "activeExplodeGround", 0);
      wait(lib_0C26::func_7EA9() / 1000);
      thread spidergrenade_explode();
      break;

    case 3:
      self hidefromplayer(param_01);
      self setscriptablepartstate("beacon", "activeExplode", 0);
      self setscriptablepartstate("anims", "activeExplodePlayer", 0);
      wait(lib_0C26::func_7EA9() / 1000);
      thread spidergrenade_explode();
      break;

    case 4:
      self setscriptablepartstate("beacon", "neutral", 0);
      self setscriptablepartstate("anims", "neutral", 0);
      break;
  }
}

spidergrenade_destroyonemp() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  self waittill("emp_damage", var_00, var_01, var_02, var_03, var_04);
  if(isDefined(var_03) && var_03 == "emp_grenade_mp") {
    if(scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, var_00))) {
      var_00 scripts\mp\missions::func_D991("ch_tactical_emp_eqp");
    }
  }

  spidergrenade_awardpoints(var_00);
  if(isplayer(var_00)) {
    var_05 = scripts\engine\utility::ter_op(scripts\mp\utility::istrue(self.hasruggedeqp), "hitequip", "");
    var_00 scripts\mp\damagefeedback::updatedamagefeedback(var_05);
  }

  thread spidergrenade_destroy();
}

spidergrenade_destroyongameend() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  level scripts\engine\utility::waittill_any_3("bro_shot_start", "game_ended");
  thread spidergrenade_destroy();
}

spidergrenadeproxy_handledamage(param_00, param_01, param_02, param_03, param_04) {
  if(!scripts\mp\equipment\phase_shift::areentitiesinphase(param_00, self)) {
    return 0;
  }

  if(param_02 == "MOD_MELEE") {
    return 0;
  }

  var_05 = lib_0F6E::getseekermaxhealth();
  var_06 = 1;
  if(scripts\mp\utility::isfmjdamage(param_01, param_02)) {
    var_06 = 2;
  } else if(param_03 >= scripts\mp\weapons::minegettwohitthreshold()) {
    var_06 = 2;
  }

  scripts\mp\powers::equipmenthit(self.triggerportableradarping, param_00, param_01, param_02);
  return var_06 * var_05;
}

spidergrenadeproxy_handlefataldamage(param_00, param_01, param_02, param_03, param_04) {
  spidergrenade_awardpoints(param_00);
  thread spidergrenade_explode();
}

func_5856(param_00) {
  playFX(scripts\engine\utility::getfx("seeker_sparks"), param_00);
}

spidergrenade_proxyinitialize(param_00) {
  param_00.var_9F72 = 1;
  param_00 setotherent(self);
  param_00 setentityowner(self);
  param_00 give_player_tickets(1);
  var_01 = param_00.triggerportableradarping scripts\mp\utility::_hasperk("specialty_rugged_eqp");
  param_00.hasruggedeqp = var_01;
  var_02 = scripts\engine\utility::ter_op(var_01, lib_0F6E::getseekermaxhealthrugged(), lib_0F6E::getseekermaxhealth());
  var_03 = scripts\engine\utility::ter_op(var_01, "hitequip", "");
  param_00 thread scripts\mp\damage::monitordamage(var_02, var_03, ::spidergrenadeproxy_handlefataldamage, ::spidergrenadeproxy_handledamage);
  param_00 thread spidergrenade_cleanuponownerdisconnect();
  param_00 thread spidergrenade_destroyongameend();
  param_00 thread spidergrenade_destroyonemp();
  param_00 thread scripts\mp\perks\_perk_equipmentping::runequipmentping();
  thread scripts\mp\weapons::outlineequipmentforowner(param_00, self);
  spidergrenade_addtoproxyarray(param_00);
}

spidergrenade_proxytoagent(param_00, param_01) {
  param_00 notify("death");
  param_00 thread spidergrenade_cleanuponownerdisconnect();
  var_02 = param_00.maxhealth - param_00.var_E1;
  var_03 = param_00.equipping_lastpingtime;
  param_01.triggerportableradarping = param_00.triggerportableradarping;
  param_01.team = param_00.team;
  param_01.weapon_name = param_00.weapon_name;
  param_01.power = param_00.power;
  param_01.attackers = param_00.attackers;
  param_01.proxy = param_00;
  param_01.killcament = param_00;
  param_01.var_9F72 = param_00.var_9F72;
  param_01.hasruggedeqp = param_00.hasruggedeqp;
  param_01 setotherent(param_01.triggerportableradarping);
  param_01 setentityowner(param_01.triggerportableradarping);
  param_01 give_player_tickets(1);
  param_01 scripts\mp\mp_agent::set_agent_health(var_02);
  param_01.perks = [];
  param_01.perksblocked = [];
  param_01 scripts\mp\utility::giveperk("specialty_blindeye");
  param_01 thread spidergrenade_cleanuponownerdisconnect();
  param_01 thread spidergrenade_cleanuponparentdeath(param_00);
  param_01 thread spidergrenade_destroyongameend();
  param_01 thread spidergrenade_destroyonemp();
  param_01 thread scripts\mp\perks\_perk_equipmentping::runequipmentping(undefined, var_03);
  thread scripts\mp\weapons::outlineequipmentforowner(param_01, param_01.triggerportableradarping);
  var_04 = spawn("script_model", param_01.origin);
  var_04 setModel("tag_origin");
  var_04 linkto(param_01);
  var_04 thread spidergrenade_cleanuponparentdeath(param_00);
  param_00.var_A638 = var_04;
  param_00 hide(1);
  param_00 setCanDamage(0);
  param_00 linkto(var_04);
  param_00 thread spidergrenade_setstate(4);
  param_01 thread spidergrenade_trackdebuff(undefined, param_01.var_F181);
}

spidergrenade_agenttoproxy(param_00, param_01) {
  var_02 = param_00.health;
  var_03 = param_00.equipping_lastpingtime;
  param_01.attackers = param_00.attackers;
  param_01.var_A638 delete();
  param_01 show();
  var_04 = scripts\engine\utility::ter_op(scripts\mp\utility::istrue(param_01.hasruggedeqp), "hitequip", "");
  param_01 thread scripts\mp\damage::monitordamage(var_02, var_04, ::spidergrenadeproxy_handlefataldamage, ::spidergrenadeproxy_handledamage);
  param_01 thread scripts\mp\perks\_perk_equipmentping::runequipmentping(undefined, var_03);
  thread scripts\mp\weapons::outlineequipmentforowner(param_01, param_01.triggerportableradarping);
  spidergrenade_addtoproxyarray(param_01);
  param_01 thread spidergrenade_setstate(2);
  if(isDefined(param_00.var_F181) && scripts\mp\utility::isreallyalive(param_00.var_F181)) {
    param_01 thread spidergrenade_trackdebuff(param_00, param_00.var_F181);
  }

  param_00 suicide();
}

spidergrenade_awardpoints(param_00) {
  if(scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, param_00))) {
    param_00 notify("destroyed_equipment");
    param_00 thread scripts\mp\utility::giveunifiedpoints("destroyed_equipment");
  }
}

spidergrenade_trackdebuff(param_00, param_01) {
  var_02 = self.triggerportableradarping;
  self endon("spiderGrenade_trackDebuff");
  var_02 endon("disconnect");
  param_01 endon("death");
  param_01 endon("disconnect");
  if(isDefined(param_00)) {
    param_00 notify("spiderGrenade_trackDebuff");
  } else {
    scripts\mp\gamescore::func_11ACE(var_02, param_01, "power_spider_grenade_mp");
  }

  self waittill("death");
  scripts\mp\gamescore::untrackdebuffassist(var_02, param_01, "power_spider_grenade_mp");
}

spidergrenade_getplacementinfo(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_02)) {
    param_02 = spawnStruct();
    param_02.var_38EE = 0;
    param_02.weaponisauto = self.origin;
    param_02.angles = self.angles;
  }

  var_04 = isDefined(param_03);
  if(var_04) {
    scripts\engine\utility::waitframe();
  }

  var_05 = param_00.origin;
  var_06 = getclosestpointonnavmesh(param_01);
  var_07 = var_06 - var_05;
  if(var_04 && param_03 == var_06) {
    return param_02;
  }

  var_08 = lengthsquared(var_07 * (0, 0, 1));
  var_09 = lengthsquared(var_07 * (1, 1, 0));
  if(var_08 > 9216 || var_09 > 4096) {
    if(var_04) {
      return param_02;
    }

    param_01 = param_01 - (0, 0, 72);
    return spidergrenade_getplacementinfo(param_00, param_01, param_02, var_04);
  }

  var_0A = undefined;
  var_0B = undefined;
  var_0C = spidergrenade_getplacementcontents();
  var_0D = vectordot(var_07, (0, 0, 1)) >= 0;
  if(var_0D) {
    var_0E = var_05;
    var_0F = var_06 + (0, 0, 10);
    var_10 = var_0F - var_0E;
    var_11 = var_10 * (0, 0, 1);
    var_0A = var_0E;
    var_0B = var_0A + var_11;
    var_12 = physics_raycast(var_0A, var_0B, var_0C, [param_00], 1, "physicsquery_closest", 1);
    if(isDefined(var_12) && var_12.size > 0) {
      if(var_04) {
        return param_02;
      }

      param_01 = param_01 - (0, 0, 72);
      return spidergrenade_getplacementinfo(param_00, param_01, param_02, var_04);
    } else {
      var_11 = var_10 - var_11;
      var_0A = var_0B;
      var_0B = var_0F;
      var_12 = physics_raycast(var_0A, var_0B, var_0C, [param_00], 1, "physicsquery_closest", 1);
      if(isDefined(var_12) && var_12.size > 0) {
        if(var_04) {
          return param_02;
        }

        param_01 = param_01 - (0, 0, 72);
        return spidergrenade_getplacementinfo(param_00, param_01, param_02, var_04);
      } else {
        var_10 = var_06 - var_0B;
        var_11 = var_10 - (0, 0, 64);
        var_0A = var_0B;
        var_0B = var_0A + var_11;
        var_0C = spidergrenade_getfinalplacementcontents();
        var_12 = physics_raycast(var_0A, var_0B, var_0C, [param_00], 1, "physicsquery_closest", 1);
        if(isDefined(var_12) && var_12.size > 0) {
          var_13 = var_12[0]["position"];
          if(vectordot(var_13 - var_06, (0, 0, 1)) > 32) {
            if(var_04) {
              return param_02;
            }

            param_01 = param_01 - (0, 0, 72);
            return spidergrenade_getplacementinfo(param_00, param_01, param_02, var_04);
          } else {
            param_02.var_38EE = 1;
            param_02.weaponisauto = var_13 + (0, 0, 2);
            param_02.angles = param_00.angles * (0, 1, 0);
          }
        }
      }
    }
  } else {
    var_0D = var_08;
    var_10 = var_0D + (0, 0, 10);
    var_12 = physics_raycast(var_0D, var_10, var_11, [param_03], 1, "physicsquery_closest", 1);
    if(isDefined(var_12) && var_12.size > 0) {
      return param_02;
    } else {
      var_10 = var_06 - var_0B;
      var_11 = var_10 * (1, 1, 0);
      var_0A = var_0B;
      var_0B = var_0A + var_11;
      var_12 = physics_raycast(var_0A, var_0B, var_0C, [param_00], 1, "physicsquery_closest", 1);
      if(isDefined(var_12) && var_12.size > 0) {
        return param_02;
      } else {
        var_10 = var_06 - var_0B;
        var_11 = var_10 - (0, 0, 64);
        var_0A = var_0B;
        var_0B = var_0A + var_11;
        var_0C = spidergrenade_getfinalplacementcontents();
        var_12 = physics_raycast(var_0A, var_0B, var_0C, [param_00], 1, "physicsquery_closest", 1);
        if(isDefined(var_12) && var_12.size > 0) {
          var_13 = var_12[0]["position"];
          if(vectordot(var_13 - var_06, (0, 0, 1)) > 32) {
            return param_02;
          } else {
            param_02.var_38EE = 1;
            param_02.weaponisauto = var_13 + (0, 0, 2);
            param_02.angles = param_00.angles * (0, 1, 0);
          }
        }
      }
    }
  }

  return param_02;
}

spidergrenade_getplacementcontents() {
  return physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_sky", "physicscontents_water"]);
}

spidergrenade_getfinalplacementcontents() {
  return physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_sky", "physicscontents_water", "physicscontents_item", "physicscontents_playerclip", "physicscontents_monsterclip"]);
}

spidergrenade_addtoproxyarray(param_00) {
  var_01 = param_00 getentitynumber();
  if(isDefined(level.spidergrenade.proxies[var_01])) {
    return;
  }

  level.spidergrenade.proxies[var_01] = param_00;
  thread spidergrenade_removefromproxyarrayondeath(param_00);
}

spidergrenade_removefromproxyarray(param_00) {
  level.spidergrenade.proxies[param_00] = undefined;
}

spidergrenade_removefromproxyarrayondeath(param_00) {
  var_01 = param_00 getentitynumber();
  param_00 waittill("death");
  spidergrenade_removefromproxyarray(var_01);
}

spidergrenade_addtoactiveagentarray(param_00) {
  var_01 = [];
  foreach(var_03 in level.spidergrenade.activeagents) {
    if(!isDefined(var_03)) {
      continue;
    }

    if(var_03 == param_00) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  var_01[var_01.size] = param_00;
  level.spidergrenade.activeagents = var_01;
  spidergrenade_addtoagentarray(param_00);
}

spidergrenade_removefromactiveagentarray(param_00) {
  level.spidergrenade.activeagents = scripts\engine\utility::array_remove(level.spidergrenade.activeagents, param_00);
  thread spidergrenade_removefromactiveagentarrayinternal(param_00);
}

spidergrenade_removefromactiveagentarrayinternal(param_00) {
  param_00 scripts\engine\utility::waittill_any_timeout_no_endon_death_2(level.agent_recycle_interval, "agent_in_use");
  spidergrenade_removefromagentarray(param_00);
}

spidergrenade_addtoagentarray(param_00) {
  var_01 = [];
  var_01[0] = param_00;
  foreach(var_03 in level.spidergrenade.agents) {
    if(!isDefined(var_03)) {
      continue;
    }

    if(var_03 == param_00) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  level.spidergrenade.agents = var_01;
}

spidergrenade_removefromagentarray(param_00) {
  level.spidergrenade.agents = scripts\engine\utility::array_remove(level.spidergrenade.agents, param_00);
}

spidergrenade_agentavailable() {
  return level.spidergrenade.agents.size < 8;
}

spidergrenade_freeactiveagent() {
  foreach(var_01 in level.spidergrenade.activeagents) {
    if(!var_01 lib_0C26::func_9FB2() && isDefined(var_01.proxy)) {
      thread spidergrenade_agenttoproxy(var_01, var_01.proxy);
      return 1;
    }
  }

  return 0;
}

spidergrenade_cleanuponparentdeath(param_00) {
  self endon("death");
  self notify("spiderGrenade_cleanupOnParentDeath");
  self endon("spiderGrenade_cleanupOnParentDeath");
  param_00 waittill("death");
  if(isagent(self) && isalive(self)) {
    self suicide();
    return;
  }

  self delete();
}

spidergrenade_cleanuponownerdisconnect() {
  self endon("death");
  self notify("spiderGrenade_cleanupOnOwnerDisconnect");
  self endon("spiderGrenade_cleanupOnOwnerDisconnect");
  self.triggerportableradarping scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators", "disconnect");
  if(isagent(self) && isalive(self)) {
    self suicide();
    return;
  }

  self delete();
}