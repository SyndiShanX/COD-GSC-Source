/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\damage.gsc
*********************************************/

callback_playerdamage_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C) {
  if(isDefined(var_1) && scripts\mp\utility::istrue(level.jittermodcheck) && level.jittermodcheck == 2 && scripts\mp\utility::istrue(var_1.ismodded)) {
    var_3 = 0;
    return;
  }

  if(isDefined(var_1) && var_1.classname == "worldspawn") {
    var_1 = undefined;
  }

  if(isDefined(var_1) && isDefined(var_1.gunner)) {
    var_1 = var_1.gunner;
  }

  if(!scripts\mp\utility::gameflag("prematch_done")) {
    return "finished";
  }

  var_0E = gettime();
  var_0F = var_2.health;
  if(isplayer(var_2)) {
    var_2.var_AA47 = var_2 getcurrentweapon();
    var_2.var_13905 = var_2 scripts\mp\utility::func_9EE8();
    if(var_2.var_13905) {
      var_2.var_A98B = gettime();
    }
  }

  if(!level.tactical) {
    var_4 = var_4 | level.idflags_no_knockback;
  }

  if(func_B4CA(var_2, var_1, var_6)) {
    return;
  }

  if(var_5 == "MOD_FALLING" && isDefined(var_2.var_115FC) && var_2.var_115FC) {
    var_1 = var_2.var_115FD;
  }

  var_10 = 0;
  if(var_4 &level.idflags_stun) {
    var_10 = 0;
    var_3 = 0;
  }

  var_11 = filterdamage(var_0, var_1, var_2, var_3, var_5, var_6, var_9);
  if(isDefined(var_11)) {
    return var_11;
  }

  var_12 = scripts\mp\utility::attackerishittingteam(var_2, var_1);
  if(var_12) {
    var_3 = handlefriendlyfiredamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_10, var_0B, var_0C);
    if(var_3 == 0) {
      return;
    }
  }

  if(scripts\mp\utility::istrue(var_2.spawnprotection)) {
    var_13 = isDefined(var_1.classname) && var_1.classname == "trigger_hurt";
    if(!var_13) {
      handledamagefeedback(var_0, var_1, var_2, 0, var_5, var_6, var_9, var_4, 1, 1);
      return "finished";
    }
  }

  var_14 = scripts\mp\utility::getequipmenttype(var_6);
  if(isDefined(var_14)) {
    if(var_14 == "lethal") {
      var_3 = lethalequipmentdamagemod(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
    } else if(var_14 == "equipment_other") {
      if(var_6 == "bouncingbetty_mp") {
        if(!scripts\mp\weapons::minedamageheightpassed(var_0, var_2)) {
          var_3 = 0;
        } else if(var_2 getstance() == "crouch" || var_2 getstance() == "prone") {
          var_3 = int(var_3 / 2);
        }
      }

      if(var_6 == "portal_grenade_mp" && var_3 != 400) {
        var_2 thread scripts\mp\equipment\portal_grenade::func_D68E(var_0, var_1);
      }
    }
  }

  var_15 = scripts\mp\utility::_meth_8238(var_6);
  if(var_15 == "killstreak") {
    var_3 = killstreakdamagefilter(var_1, var_2, var_3, var_6, var_5);
    if(var_3 == 0) {
      return;
    }

    if(var_6 == "killstreak_jammer_mp") {
      return "sWeapon == killstreak_jammer_mp";
    }

    if(isDefined(level.ac130player) && isDefined(var_1) && level.ac130player == var_1) {
      level notify("ai_pain", var_2);
    }
  }

  var_3 = modifydamagegeneral(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A);
  var_3 = handleriotshieldhits(var_0, var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9, var_4);
  if(isstring(var_3)) {
    return var_3;
  }

  if(scripts\mp\utility::func_9EF0(var_2)) {
    var_3 = var_2 scripts\mp\killstreaks\_utility::getmodifiedantikillstreakdamage(var_1, var_6, var_5, var_3, var_2.maxhealth, 3, 4, 6, 0);
    if(isDefined(var_1) && isplayer(var_1) && scripts\mp\equipment\phase_shift::isentityphaseshifted(var_1)) {
      var_3 = 0;
    }
  }

  if(isplayer(var_1)) {
    var_1 scripts\mp\perks\_weaponpassives::func_3E01();
  }

  var_16 = func_3696(var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9, var_0, 0, var_4);
  var_3 = var_16[0];
  var_17 = var_16[1];
  var_18 = var_16[2];
  var_19 = var_17 != 0 || var_18 != 0;
  var_9 = var_16[3];
  if(isDefined(var_2.forcehitlocation)) {
    var_9 = var_2.forcehitlocation;
  }

  scripts\mp\perks\_perkfunctions::bulletoutlinecheck(var_1, var_2, var_6, var_5);
  if((var_3 >= var_2.health && scripts\engine\utility::string_starts_with(var_6, "iw7_penetrationrail_mp") && var_5 != "MOD_MELEE") || var_3 >= var_2.health && scripts\engine\utility::string_starts_with(var_6, "iw7_nunchucks_mpl") && var_5 == "MOD_MELEE") {
    var_1A = scripts\mp\weapons::impale_endpoint(var_7, var_8);
    var_1B = scripts\mp\weapons::trace_impale(var_7, var_1A);
    if(var_1B["hittype"] != "hittype_world") {
      var_1C = (var_8[0], var_8[1], var_8[2]);
      if(var_1C[2] > -0.3 && var_1C[2] < 0.1) {
        var_1C = (var_1C[0], var_1C[1], 0.1);
        vectornormalize(var_1C);
      }

      var_2 _meth_84DC(var_1C, 650);
    }
  }

  if(isai(self)) {
    self[[level.bot_funcs["on_damaged"]]](var_1, var_3, var_5, var_6, var_0, var_9);
  }

  if(isplayer(var_1) && var_6 == "smoke_grenade_mp" || var_6 == "throwingknife_mp" || var_6 == "throwingknifeteleport_mp" || var_6 == "throwingknifesmokewall_mp" || var_6 == "gas_grenade_mp" || var_6 == "throwingreaper_mp") {
    var_1 thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_6, 1, "hits");
  }

  if(var_5 == "MOD_FALLING") {
    var_2 thread func_612A(var_3);
  }

  if(!isDefined(var_8)) {
    var_4 = var_4 | level.idflags_no_knockback;
  }

  if(isDefined(var_1) && var_1.classname == "script_origin" && isDefined(var_1.type) && var_1.type == "soft_landing") {
    return "soft_landing";
  }

  logattacker(var_2, var_1, var_0, var_6, var_3, var_7, var_8, var_9, var_0A, var_5);
  if(isDefined(var_0) && isDefined(var_0.triggerportableradarping) && var_0.triggerportableradarping.team != var_2.team) {
    var_2.lastdamagewasfromenemy = 1;
  } else {
    var_2.lastdamagewasfromenemy = isDefined(var_1) && var_1 != var_2;
  }

  if(var_2.lastdamagewasfromenemy) {
    var_1D = gettime();
    var_1.damagedplayers[var_2.guid] = var_1D;
    var_2.lastdamagedtime = var_1D;
  }

  var_2 func_12EFD(var_3, var_1, var_9, var_5);
  if(scripts\mp\codcasterclientmatchdata::shouldlogcodcasterclientmatchdata()) {
    if(isplayer(var_1)) {
      var_1E = scripts\mp\codcasterclientmatchdata::getcodcasterplayervalue(var_1, "damageDone");
      scripts\mp\codcasterclientmatchdata::setcodcasterplayervalue(var_1, "damageDone", var_1E + var_3);
    }
  }

  var_2 thread scripts\mp\missions::func_D378(var_0, var_1, var_3, var_5, var_6, var_9);
  if(isDefined(var_1) && var_3 != 0) {
    var_1 notify("victim_damaged", var_2, var_0, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A);
    var_1 scripts\mp\contractchallenges::contractplayerdamaged(var_3);
  }

  var_1F = var_8;
  if(isDefined(var_4) && var_4 &level.idflags_ricochet && var_3 < self.health) {
    var_1F = var_2.origin - var_1.origin;
  }

  var_2 finishplayerdamagewrapper(var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_1F, var_9, var_0A, var_10, var_0B, var_0C, var_19);
  if(var_3 > 10 && isDefined(var_0) && !var_2 scripts\mp\utility::isusingremote() && isplayer(var_2)) {
    var_2 thread scripts\mp\shellshock::bloodeffect(var_0.origin);
    if(isplayer(var_0) && var_5 == "MOD_MELEE") {
      if(isalive(var_2) && !var_2 scripts\mp\utility::_hasperk("specialty_stun_resistance")) {
        var_2 thread func_B645(0.75);
        var_2.var_904B = gettime();
      }

      var_0 thread scripts\mp\shellshock::func_2BC3(var_6);
      var_2 playrumbleonentity("defaultweapon_melee");
      var_0 playrumbleonentity("defaultweapon_melee");
    }
  }

  if(isagent(self)) {
    if(scripts\mp\utility::func_9EF0(self)) {
      if(var_3 >= self.health) {
        var_3 = self.health - 1;
        if(isDefined(self.triggerportableradarping)) {
          self.triggerportableradarping notify("player_killstreak_agent_death", self, var_0, var_1, var_3, var_4, var_5, var_6);
        }
      } else {
        self[[scripts\mp\agents\agent_utility::agentfunc("on_damaged_finished")]](var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A);
        if(self.var_165A == "remote_c8") {
          if(isDefined(self.triggerportableradarping) && isDefined(self.triggerportableradarping.var_4BE1) && self.triggerportableradarping.var_4BE1 == "MANUAL") {
            self setclientomnvar("ui_remote_c8_health", self.health / self.maxhealth);
          }
        }
      }
    } else {
      self[[scripts\mp\agents\agent_utility::agentfunc("on_damaged_finished")]](var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A);
    }
  }

  handledamagefeedback(var_0, var_1, var_2, var_3, var_5, var_6, var_9, var_4, var_17, var_18);
  scripts\mp\gamelogic::sethasdonecombat(var_2, 1);
  if(isDefined(var_1) && var_1 != var_2) {
    level.usestartspawns = 0;
  }

  if(isplayer(var_1) && isDefined(var_1.pers["participation"])) {
    var_1.pers["participation"]++;
  } else if(isplayer(var_1)) {
    var_1.pers["participation"] = 1;
  }

  if(isDefined(level.matchrecording_logeventmsg) && isplayer(var_2) && isDefined(var_0) && isplayer(var_0) && scripts\engine\utility::isbulletdamage(var_5)) {
    if(var_0F == var_2.maxhealth && var_2.health != self.maxhealth) {
      var_2.engagementstarttime = gettime();
    }
  }

  if(allowdamageflash(var_1, var_2, var_6, var_5, var_3)) {
    var_2 showuidamageflash();
  }

  if(isDefined(var_1) && var_1 scripts\mp\utility::_hasperk("specialty_mark_targets") && var_3 > 0) {
    var_1 thread scripts\mp\perks\_perk_mark_targets::marktarget_run(var_2, var_5);
  }

  return "finished";
}

func_B645(var_0) {
  self endon("death");
  self endon("disconnect");
  var_1 = newclienthudelem(self);
  var_1.x = 0;
  var_1.y = 0;
  var_1.alignx = "left";
  var_1.aligny = "top";
  var_1.sort = 1;
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";
  var_1.alpha = 0;
  var_1.foreground = 1;
  var_1 setshader("black", 640, 480);
  thread monitormeleeoverlay(var_1);
  self shellshock("melee_mp", var_0);
  self earthquakeforplayer(0.35, 0.5, self.origin, 100);
  self setclientomnvar("ui_hud_shake", 1);
  var_1 fadeovertime(0.1);
  var_1.alpha = 0.2;
  wait(0.1);
  var_1 fadeovertime(0.3);
  var_1.alpha = 0.4;
  wait(0.3);
  var_1 fadeovertime(0.6);
  var_1.alpha = 0;
}

monitormeleeoverlay(var_0) {
  scripts\engine\utility::waittill_any_timeout_1(2, "death", "disconnect");
  var_0 destroy();
}

allowdamageflash(var_0, var_1, var_2, var_3, var_4) {
  if(var_4 == 0) {
    return 0;
  }

  if(suppressdamageflash(var_0, var_1, var_2, var_3, var_4)) {
    return 0;
  }

  return 1;
}

suppressdamageflash(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2)) {
    switch (var_2) {
      case "super_trophy_mp":
        return scripts\mp\supers\super_supertrophy::func_11286(var_0, var_1, var_2, var_3, var_4);
    }
  }

  return 0;
}

func_3696(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A) {
  if(isplayer(var_0) && var_0 _meth_8568() || var_0 _meth_8569()) {
    return [0, 0, 0, var_7];
  }

  var_0 notify("damage_begin", var_1);
  var_0B = 0;
  var_0C = 0;
  if(var_0 scripts\mp\utility::isjuggernaut()) {
    var_0C = level.var_A4A7;
    if(isDefined(self.isjuggernautmaniac) && self.isjuggernautmaniac) {
      var_0C = level.var_A4A6;
    }
  }

  if(scripts\engine\utility::isbulletdamage(var_3)) {
    if(isDefined(var_4) && scripts\mp\utility::iscacprimaryweapon(var_4) || scripts\mp\utility::iscacsecondaryweapon(var_4)) {
      if(isbehindmeleevictim(var_1, var_0) && isplayer(var_0)) {
        level thread scripts\mp\battlechatter_mp::saytoself(var_0, "plr_hit_back", undefined, 0.1);
      }

      if(isDefined(var_1.var_C7E6) && var_1.var_C7E6) {
        var_0B = var_0B + var_2 * 0.3;
      }
    }

    if(isDefined(var_4) && issubstr(var_4, "iw7_gauss_mpl")) {
      var_0D = scripts\mp\utility::weaponhasattachment(var_4, "barrelrange");
      var_0E = scripts\engine\utility::ter_op(var_0D, 2073600, 1440000);
      var_0F = scripts\engine\utility::ter_op(var_0D, 5760000, 4000000);
      if((distance2dsquared(var_0.origin, var_1.origin) < var_0E && var_2 >= 70) || distance2dsquared(var_0.origin, var_1.origin) < var_0F && var_2 >= 54 || distance2dsquared(var_0.origin, var_1.origin) >= var_0F && var_2 >= 42) {
        var_0.hitbychargedshot = var_1;
      }
    }

    if(isDefined(var_4) && issubstr(var_4, "iw7_ba50cal_mpl_overkill")) {
      if(var_2 >= 200) {
        var_0.hitbychargedshot = var_1;
      }
    }

    if(isDefined(var_0A) && var_0A &level.idflags_ricochet) {
      var_10 = scripts\mp\utility::getweaponbasedsmokegrenadecount(var_4);
      if(var_10 != "none" && !scripts\mp\utility::issuperweapon(var_10)) {
        var_2 = var_2 * 0.4;
      }
    }

    if(scripts\mp\utility::isfmjdamage(var_4, var_3)) {
      var_0C = var_0C * level.armorpiercingmod;
    }

    if(isplayer(var_1) && var_1 scripts\mp\utility::_hasperk("specialty_paint_pro") && !scripts\mp\utility::iskillstreakweapon(var_4)) {
      if(!var_0 scripts\mp\perks\_perkfunctions::ispainted()) {
        var_1 scripts\mp\missions::processchallenge("ch_bulletpaint");
      }

      var_0 thread scripts\mp\perks\_perkfunctions::setpainted(var_1);
    }

    if(isplayer(var_1) && var_1 scripts\mp\utility::_hasperk("specialty_bulletdamage") && var_0 scripts\mp\utility::_hasperk("specialty_armorvest")) {} else if(isplayer(var_1) && var_1 scripts\mp\utility::_hasperk("specialty_bulletdamage") || var_1 scripts\mp\utility::_hasperk("specialty_moredamage")) {
      var_0B = var_0B + var_2 * level.var_3245;
    } else if(var_0 scripts\mp\utility::_hasperk("specialty_armorvest")) {
      var_0B = var_0B - var_2 * level.var_21A3;
    } else if(var_0 scripts\mp\utility::_hasperk("specialty_headgear") && scripts\mp\utility::isheadshot(var_4, var_7, var_3, var_1) && !scripts\mp\utility::isfmjdamage(var_4, var_3)) {
      var_0B = var_0B - var_2 * level.var_8C74;
      var_0 notify("headgear_save", var_1, var_3, var_4);
    }

    if(var_0 scripts\mp\utility::isjuggernaut()) {
      if(level.hardcoremode && isDefined(var_4) && weaponclass(var_4) == "spread") {
        var_2 = min(var_2, 25) * var_0C;
        var_0B = min(var_2, 25) * var_0C;
      } else {
        var_2 = var_2 * var_0C;
        var_0B = var_0B * var_0C;
      }
    }

    if(var_1 scripts\mp\utility::_hasperk("passive_sonic") && var_1 issprintsliding()) {
      var_2 = var_2 * 1.25;
    }

    if(var_1 scripts\mp\utility::_hasperk("passive_below_the_belt")) {
      var_11 = undefined;
      switch (var_0.loadoutarchetype) {
        case "archetype_scout":
          var_11 = "torso_stabilizer";
          break;

        default:
          var_11 = "j_crotch";
          break;
      }

      if(isDefined(var_11)) {
        var_12 = var_0 gettagorigin(var_11);
        var_13 = distance(var_12, var_5);
        var_14 = 7.5;
        if(var_13 <= var_14) {
          var_2 = var_2 * 1.35;
          var_1 scripts\mp\utility::giveperk("specialty_moredamage");
        }
      }
    }

    if(scripts\mp\weapons::func_A008(var_4)) {
      var_0 thread scripts\mp\weapons::func_20E4();
    }

    if(isDefined(var_0.var_FC99)) {
      var_2 = 0;
    }
  } else if(isexplosivedamagemod(var_3)) {
    var_2 = scripts\mp\concussiongrenade::func_B92C(var_2, var_1, var_0, var_8, var_4);
    var_2 = scripts\mp\equipment\blackout_grenade::func_B92C(var_2, var_1, var_0, var_8, var_4);
    var_2 = scripts\mp\empgrenade::func_B92C(var_2, var_1, var_0, var_8, var_4);
    var_2 = scripts\mp\weapons::glprox_modifieddamage(var_2, var_1, var_0, var_8, var_4, var_3, var_5);
    if(var_4 == "proximity_explosive_mp" && isDefined(var_8.origin)) {
      var_15 = var_8.origin[2];
      var_16 = var_0.origin[2] + 24;
      if(var_15 < var_16 && !var_0 isonground()) {
        var_2 = var_2 * 0.8;
      } else if(var_15 >= var_16 && var_0 getstance() == "crouch") {
        var_2 = var_2 * 0.9;
      } else if(var_15 >= var_16 && var_0 getstance() == "prone") {
        var_2 = var_2 * 0.65;
      }
    }

    if(isplayer(var_1)) {
      if(var_1 != var_0 && var_1 isitemunlocked("specialty_paint", "perk") && var_1 scripts\mp\utility::_hasperk("specialty_paint") && !scripts\mp\utility::iskillstreakweapon(var_4)) {
        var_0 thread scripts\mp\perks\_perkfunctions::setpainted(var_1);
      }
    }

    if(isDefined(var_0.var_1177D) && var_0.var_1177D) {
      var_0B = var_0B + int(var_2 * level.var_1177E);
    }

    if(isplayer(var_1) && weaponinheritsperks(var_4) && var_1 scripts\mp\utility::_hasperk("specialty_explosivedamage") && var_0 scripts\mp\utility::_hasperk("specialty_blastshield")) {} else if(isplayer(var_1) && weaponinheritsperks(var_4) && !scripts\mp\utility::iskillstreakweapon(var_4) && var_1 scripts\mp\utility::_hasperk("specialty_explosivedamage")) {
      var_0B = var_0B + var_2 * level.var_69FE;
    } else if(var_0 scripts\mp\utility::_hasperk("specialty_blastshield") && !scripts\mp\utility::func_13C9A(var_4, var_7) && !scripts\mp\utility::func_9F7E(var_0, var_8, var_4, var_3) && !var_3 == "MOD_PROJECTILE") {
      var_17 = scripts\mp\weapons::glprox_modifiedblastshieldconst(level.var_2B68, var_4);
      var_17 = scripts\mp\equipment\ground_pound::groundpound_modifiedblastshieldconst(var_17, var_4);
      var_18 = int(var_2 * var_17);
      if(var_1 != var_0) {
        var_18 = clamp(var_18, 0, level.var_2B67);
      }

      var_0B = var_0B - var_2 - var_18;
    }

    if(var_0 scripts\mp\utility::isjuggernaut()) {
      var_0B = var_0B * var_0C;
      if(var_2 < 1000) {
        var_2 = var_2 * var_0C;
      }
    }

    if(isDefined(level.var_ABBF) && !scripts\mp\weapons::func_ABC1()) {
      var_2 = var_2 * level.allowgroundpound;
    }

    if(isDefined(var_0.var_FC99)) {
      var_2 = 0;
    }
  } else if(var_3 == "MOD_FALLING") {
    if(isDefined(var_0.var_115FC) && var_0.var_115FC) {
      var_2 = var_0.health + 100;
      var_1 thread scripts\mp\equipment\portal_grenade::func_468B(var_0, var_0.origin);
      var_0.var_115FC = 0;
      var_0.var_115FD = undefined;
      var_0.var_115FE = undefined;
    } else if(var_0 scripts\mp\utility::isjuggernaut()) {
      var_2 = var_2 * var_0C;
    } else if(scripts\mp\equipment\ground_pound::func_8651(var_0)) {
      var_2 = 0;
    } else {
      var_2 = int(max(33, var_2));
      if(var_2 >= var_0.health) {
        var_2 = int(max(0, var_0.health - 1));
      }
    }
  } else if(var_3 == "MOD_MELEE") {
    if(isDefined(var_8) && scripts\mp\utility::func_9EF0(var_8) && var_8.var_165A == "remote_c8") {
      var_2 = self.health - 1;
    } else if(var_0 scripts\mp\utility::isjuggernaut()) {
      var_2 = 20;
      var_0B = 0;
    } else if(var_4 == "iw7_reaperblade_mp") {
      var_0 thread scripts\mp\supers\super_reaper::func_A668();
    } else if(isDefined(var_0 scripts\mp\supers::getcurrentsuperref()) && var_0 scripts\mp\supers::getcurrentsuperref() == "super_reaper" && var_0 scripts\mp\supers::issuperinuse()) {
      var_2 = int(min(var_2, scripts\mp\supers\super_reaper::func_93D9()));
    } else if(scripts\mp\utility::func_9E7D(var_8, var_0, var_4, var_3)) {
      var_2 = var_0.health;
    } else if(isbehindmeleevictim(var_1, var_0) && isDefined(var_8) && !scripts\mp\utility::func_9EF0(var_8)) {
      var_2 = int(max(var_2, 100));
    } else {
      var_2 = 70;
    }
  } else if(var_3 == "MOD_IMPACT") {
    if(var_0 scripts\mp\utility::isjuggernaut()) {
      switch (var_4) {
        case "semtexproj_mp":
        case "gas_grenade_mp":
        case "gravity_grenade_mp":
        case "sensor_grenade_mp":
        case "smoke_grenadejugg_mp":
        case "flash_grenade_mp":
        case "shard_ball_mp":
        case "mortar_shelljugg_mp":
        case "semtex_mp":
        case "frag_grenade_mp":
        case "concussion_grenade_mp":
        case "smoke_grenade_mp":
        case "splash_grenade_mp":
        case "cluster_grenade_mp":
          var_2 = 5;
          break;

        default:
          if(var_2 < 1000) {
            var_2 = 25;
          }
          break;
      }

      var_0B = 0;
    }

    if(isDefined(var_0.var_FC99)) {
      var_2 = 0;
    }

    if(isDefined(var_3) && var_3 == "MOD_IMPACT" && getweaponbasename(var_4) == "iw7_venomx_mp") {
      var_1 scripts\mp\missions::func_D991("ch_iw7_venomx_direct");
    }
  } else if(var_3 == "MOD_UNKNOWN" || var_3 == "MOD_MELEE_DOG") {
    if(isagent(var_1) && isDefined(var_1.agent_type) && var_1.agent_type == "dog" && var_0 scripts\mp\utility::isjuggernaut()) {
      var_0 shellshock("dog_bite", 2);
      var_2 = var_2 * var_0C;
    }
  }

  if(var_0 scripts\mp\utility::_hasperk("specialty_combathigh")) {
    if(isDefined(self.damageblockedtotal) && !level.teambased || isDefined(var_1) && isDefined(var_1.team) && var_0.team != var_1.team) {
      var_19 = var_2 + var_0B;
      var_1A = var_19 - var_19 / 3;
      self.damageblockedtotal = self.damageblockedtotal + var_1A;
      if(self.damageblockedtotal >= 101) {
        self notify("combathigh_survived");
        self.damageblockedtotal = undefined;
      }
    }

    if(var_4 != "throwingknife_mp" && var_4 != "throwingknifejugg_mp" && var_4 != "throwingknifeteleport_mp" && var_4 != "throwingreaper_mp" && !var_4 == "throwingknife_mp" && var_3 == "MOD_IMPACT") {
      switch (var_3) {
        case "MOD_FALLING":
        case "MOD_MELEE":
          break;

        default:
          var_2 = int(var_2 / 3);
          var_0B = int(var_0B / 3);
          break;
      }
    }
  }

  var_2 = scripts\mp\equipment\charge_mode::chargemode_modifieddamage(var_1, var_0, var_4, var_5, var_2);
  var_2 = scripts\mp\equipment\exploding_drone::explodingdrone_modifieddamage(var_1, var_0, var_4, var_8, var_2);
  var_2 = scripts\mp\supers\super_supertrophy::func_11280(var_1, var_0, var_4, var_2);
  var_2 = scripts\mp\equipment\ground_pound::func_8653(var_1, var_0, var_4, var_8, var_2);
  var_2 = scripts\mp\killstreaks\_venom::venommodifieddamage(var_1, var_0, var_4, var_8, var_2);
  var_1B = scripts\mp\playertrophy_system::playertrophy_modifieddamage(var_1, var_0, var_4, var_8, var_2);
  var_1B = scripts\mp\trophy_system::trophy_modifieddamage(var_1, var_0, var_4, var_2, var_0B);
  var_2 = var_1B[0];
  var_0B = var_1B[1];
  var_1C = 0;
  if(var_0 scripts\mp\heavyarmor::hasheavyarmor()) {
    var_1B = scripts\mp\heavyarmor::heavyarmormodifydamage(var_0, var_1, var_2, var_0B, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    var_1C = var_1B[0] > 0;
    var_2 = var_1B[1];
    var_0B = var_1B[2];
  }

  var_1D = 0;
  if(scripts\mp\lightarmor::haslightarmor(var_0)) {
    var_1B = scripts\mp\lightarmor::lightarmor_modifydamage(var_0, var_1, var_2, var_0B, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    var_1D = var_1B[0] > 0;
    var_2 = var_1B[1];
    var_0B = var_1B[2];
  }

  if(scripts\mp\utility::hashealthshield(var_0)) {
    var_2 = var_0 scripts\mp\utility::func_7EF7(var_2);
  }

  if(var_2 <= 1) {
    var_2 = int(ceil(clamp(var_2, 0, 1)));
  } else {
    var_2 = int(var_2 + var_0B);
  }

  if(isDefined(var_0.var_FC99)) {
    var_0.var_FC9A = var_2;
    var_2 = 0;
  } else if(var_7 == "shield" && var_0 scripts\mp\utility::_hasperk("specialty_rearguard") && var_3 == "MOD_EXPLOSIVE" || var_3 == "MOD_PROJECTILE_SPLASH" || var_3 == "MOD_PROJECTILE" || isDefined(var_8.weapon_name) && scripts\mp\utility::iskillstreakweapon(var_8.weapon_name)) {
    var_7 = "none";
  }

  if(isDefined(var_8) && isplayer(var_8) && isDefined(var_1) && isplayer(var_1) && var_1 != var_0) {
    thread scripts\mp\perks\_weaponpassives::updateweaponpassivesondamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }

  return [var_2, var_1D, var_1C, var_7];
}

func_B4CA(var_0, var_1, var_2) {
  var_3 = 0;
  if(isDefined(var_1) && isDefined(var_0) && isDefined(var_2)) {
    var_4 = getweaponbasename(var_2) == "iw7_mauler_mpr" || issubstr(var_2, "iw7_crdb_mp");
    var_5 = weaponclass(var_2) == "spread";
    if(!var_5 && !var_4) {
      return var_3;
    }

    var_6 = "" + gettime();
    var_7 = undefined;
    if(var_1 getweaponrankinfominxp() > 0.8 && var_1 scripts\mp\utility::_hasperk("passive_shotgun_focus")) {
      var_7 = 4;
    } else if(var_4) {
      var_7 = 4;
    } else if(var_1 isdualwielding()) {
      var_7 = 5;
    } else if(issubstr(var_2, "iw7_mod2187_mpl")) {
      var_7 = 4;
    } else if(issubstr(var_2, "iw7_longshot_mp")) {
      var_8 = var_1 getweaponrankinfominxp() > 0.95;
      var_9 = scripts\mp\weapons::isaltmodeweapon(var_2);
      if(!var_8 && !var_9) {
        var_7 = 1;
      } else if(var_8 && !var_9) {
        var_7 = 4;
      } else {
        var_7 = 3;
      }
    } else {
      var_7 = 3;
    }

    if(!isDefined(var_1.pelletdmg) || !isDefined(var_1.pelletdmg[var_6])) {
      var_1.pelletdmg = undefined;
      var_1.pelletdmg[var_6] = [];
    }

    if(!isDefined(var_1.pelletdmg[var_6][var_0.guid])) {
      var_1.pelletdmg[var_6][var_0.guid] = 1;
    } else if(var_1.pelletdmg[var_6][var_0.guid] + 1 > var_7) {
      var_3 = 1;
    } else {
      var_1.pelletdmg[var_6][var_0.guid]++;
    }
  }

  return var_3;
}

isbehindmeleevictim(var_0, var_1) {
  var_2 = vectornormalize((var_1.origin[0], var_1.origin[1], 0) - (var_0.origin[0], var_0.origin[1], 0));
  var_3 = anglesToForward((0, var_1.angles[1], 0));
  return vectordot(var_2, var_3) > 0.4;
}

func_9D68(var_0, var_1) {
  var_2 = vectornormalize((var_1.origin[0], var_1.origin[1], 0) - (var_0.origin[0], var_0.origin[1], 0));
  var_3 = anglesToForward((0, var_1.angles[1], 0));
  return vectordot(var_2, var_3) > 0.2;
}

killstreakdamagefilter(var_0, var_1, var_2, var_3, var_4) {
  if(var_3 == "hind_bomb_mp" || var_3 == "hind_missile_mp") {
    if(isDefined(var_0) && var_1 == var_0) {
      return 0;
    }
  }

  if(var_1 scripts\mp\utility::isspawnprotected()) {
    var_5 = int(max(var_1.health / 4, 1));
    if(var_2 >= var_5 && scripts\mp\utility::iskillstreakweapon(var_3) && var_4 != "MOD_MELEE") {
      var_2 = var_5;
    }
  }

  return var_2;
}

friendlyfire_ignoresdamageattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D) {
  var_0E = 0;
  if(isDefined(var_6)) {
    switch (var_6) {
      case "none":
        if(isDefined(var_0) && scripts\mp\utility::isdronepackage(var_0)) {
          var_0E = 1;
        }
        break;

      case "iw7_minigun_c8_mp":
      case "iw7_chargeshot_c8_mp":
      case "iw7_c8offhandshield_mp":
        var_0F = undefined;
        if(isDefined(var_1) && scripts\mp\utility::func_9F22(var_1)) {
          var_0F = var_1;
        } else if(isDefined(var_0) && scripts\mp\utility::func_9F22(var_0)) {
          var_0F = var_0;
        }

        if(isDefined(var_0F) && isDefined(var_0F.triggerportableradarping)) {
          if(!isDefined(var_0F.triggerportableradarping.var_4BE1)) {
            var_0E = 1;
          } else if(var_0F.triggerportableradarping.var_4BE1 != "MANUAL") {
            var_0E = 1;
          }
        }
        break;

      case "ball_drone_gun_mp":
      case "jackal_fast_cannon_mp":
      case "jackal_turret_mp":
      case "jackal_cannon_mp":
      case "sentry_shock_mp":
      case "iw7_c8landing_mp":
      case "iw7_c8destruct_mp":
      case "super_trophy_mp":
      case "micro_turret_gun_mp":
      case "player_trophy_system_mp":
      case "trophy_mp":
        var_0E = 1;
        break;
    }
  }

  return var_0E;
}

handlefriendlyfiredamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D) {
  if(isDefined(var_0) && !isplayer(var_0)) {
    if(!isDefined(var_1)) {
      if(isDefined(var_0.triggerportableradarping)) {
        var_1 = var_0.triggerportableradarping;
      }
    } else if(!isplayer(var_1)) {
      if(isDefined(var_0.triggerportableradarping)) {
        var_1 = var_0.triggerportableradarping;
      }
    }
  }

  if(level.hardcoremode) {
    if(var_1 scripts\mp\utility::_hasperk("passive_softcore") && scripts\engine\utility::isbulletdamage(var_5)) {
      return 0;
    }

    if(isDefined(var_4) && var_4 &level.idflags_ricochet && scripts\engine\utility::isbulletdamage(var_5)) {
      var_3 = int(var_3 * 0.2);
    }
  }

  if(level.friendlyfire != 0) {
    if(scripts\mp\utility::istrue(var_2.isdefusing) || scripts\mp\utility::istrue(var_2.iscapturingcrate)) {
      var_3 = int(var_3 * 0.5);
      if(var_3 < 1) {
        var_3 = 1;
      }

      var_1.lastdamagewasfromenemy = 0;
      damageattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D);
      return 0;
    }
  }

  if(level.friendlyfire == 0 || !isplayer(var_1) && level.friendlyfire != 1 || var_6 == "bomb_site_mp") {
    if(var_6 == "artillery_mp" || var_6 == "stealth_bomb_mp") {
      var_2 damageshellshockandrumble(var_0, var_6, var_5, var_3, var_4, var_1);
    }

    return 0;
  } else if(level.friendlyfire == 1) {
    if(var_3 < 1) {
      var_3 = 1;
    }

    if(var_2 scripts\mp\utility::isjuggernaut()) {
      var_0E = func_3696(var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9, var_0, 0, var_4);
      var_3 = var_0E[0];
      var_0F = var_0E[1];
      var_10 = var_0E[2];
      var_9 = var_0E[3];
    }

    var_2.lastdamagewasfromenemy = 0;
    var_2 finishplayerdamagewrapper(var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D);
    var_1 handledamagefeedback(var_0, var_1, var_2, var_3, var_5, var_6, var_9, var_4, 0, 0);
    return 0;
  } else if(level.friendlyfire == 2) {
    var_3 = int(var_3 * 0.5);
    if(var_3 < 1) {
      var_3 = 1;
    }

    var_1.lastdamagewasfromenemy = 0;
    if(!friendlyfire_ignoresdamageattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D)) {
      damageattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D);
    }

    return 0;
  } else if(level.friendlyfire == 3) {
    var_3 = int(var_3 * 0.5);
    if(var_3 < 1) {
      var_3 = 1;
    }

    var_2.lastdamagewasfromenemy = 0;
    var_1.lastdamagewasfromenemy = 0;
    var_2 finishplayerdamagewrapper(var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D);
    if(!friendlyfire_ignoresdamageattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D)) {
      damageattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D);
    }

    var_1 handledamagefeedback(var_0, var_1, var_2, var_3, var_5, var_6, var_9, var_4, 0, 0);
    return 0;
  } else if(level.friendlyfire == 4) {
    var_11 = var_1.pers["teamkills"] >= level.maxallowedteamkills;
    if(var_11) {
      if(!friendlyfire_ignoresdamageattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D)) {
        var_3 = int(var_3 * 0.5);
        if(var_3 < 1) {
          var_3 = 1;
        }

        var_1.lastdamagewasfromenemy = 0;
        damageattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D);
      }

      return 0;
    }
  }

  return var_3;
}

damageattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D) {
  if(scripts\mp\utility::isreallyalive(var_1)) {
    var_1.friendlydamage = 1;
    var_1 finishplayerdamagewrapper(var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D);
    var_1.friendlydamage = undefined;
  }
}

modifydamagegeneral(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A) {
  if(var_5 == "MOD_EXPLOSIVE_BULLET" && var_3 != 1) {
    var_3 = var_3 * getdvarfloat("scr_explBulletMod");
    var_3 = int(var_3);
  }

  if(isDefined(level.modifyplayerdamage)) {
    var_3 = [[level.modifyplayerdamage]](var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9);
  }

  var_3 = int(var_3 * var_2 scripts\mp\utility::getdamagemodifiertotal(var_0, var_1, var_2, var_3, var_5, var_6, var_9));
  if(scripts\mp\utility::isheadshot(var_6, var_9, var_5, var_1)) {
    var_5 = "MOD_HEAD_SHOT";
  }

  if(scripts\mp\tweakables::gettweakablevalue("game", "onlyheadshots")) {
    if(var_5 == "MOD_HEAD_SHOT") {
      if(var_2 scripts\mp\utility::isjuggernaut()) {
        var_3 = 75;
      } else {
        var_3 = 150;
      }
    }
  }

  return var_3;
}

handleriotshieldhits(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(var_8 != "shield") {
    return var_3;
  }

  if(var_1 scripts\mp\utility::_hasperk("specialty_rearguard")) {
    var_0A = scripts\engine\utility::ter_op(isDefined(var_0), var_0, var_2);
    if(isDefined(var_0A)) {
      if(isplayer(var_0A) || scripts\mp\utility::func_9EF0(var_0A)) {
        if(func_9D68(var_0A, var_1)) {
          if(scripts\engine\utility::isbulletdamage(var_4) || var_4 == "MOD_EXPLOSIVE_BULLET") {
            var_2 scripts\mp\damagefeedback::updatedamagefeedback("hitlightarmor");
          }
        }
      } else if((isDefined(var_5) && var_5 == "destructible_car" || scripts\mp\utility::iskillstreakweapon(var_5)) || isexplosivedamagemod(var_4) || var_4 == "MOD_PROJECTILE") {
        var_1.var_FC96 = var_1.var_FC96 + var_3;
        if(func_9D68(var_0A, var_1) && !var_1 scripts\mp\utility::_hasperk("specialty_blastshield")) {
          return var_3 * 3;
        } else {
          return var_3;
        }
      }
    }
  }

  var_0B = scripts\mp\utility::istrue(var_1.var_9331);
  if(isDefined(var_1.triggerportableradarping)) {
    var_1 = var_1.triggerportableradarping;
    if(var_2 == var_1) {
      return "hit shield";
    }
  }

  if(var_4 == "MOD_PISTOL_BULLET" || var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_EXPLOSIVE_BULLET") {
    if(isplayer(var_2)) {
      var_2.var_A93F = var_1;
      var_2.var_A940 = gettime();
    }

    var_1 notify("shield_blocked");
    if(scripts\mp\utility::isenvironmentweapon(var_5)) {
      var_0C = 25;
    } else if(var_2 scripts\mp\utility::_hasperk("specialty_rearguard") && func_9D68(var_3, var_2)) {
      var_0C = var_4;
    } else {
      var_0D = func_3696(var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_1, 0, var_0B);
      var_0C = var_0D[0];
      var_0E = var_0D[1];
      var_0F = var_0D[2];
      var_8 = var_0D[3];
    }

    var_1.var_FC96 = var_1.var_FC96 + var_0C;
    var_1.var_FC97 = var_1.var_FC97 + var_0C;
    if(isplayer(var_2) && isDefined(var_1.rearguardattackers)) {
      var_10 = var_2 getentitynumber();
      if(!isDefined(var_1.rearguardattackers[var_10])) {
        var_1.rearguardattackers[var_10] = var_0C;
      } else {
        var_1.rearguardattackers[var_10] = var_1.rearguardattackers[var_10] + var_0C;
      }
    }

    if(var_0B) {
      return "hit shield";
    }

    if(!scripts\mp\utility::isenvironmentweapon(var_5) || scripts\engine\utility::cointoss()) {
      var_1.var_FC95++;
    }

    if(var_1.var_FC95 >= level.riotshieldxpbullets) {
      var_11 = 1;
      if(self.recentshieldxp > 4) {
        var_11 = 1 / self.recentshieldxp;
      }

      var_12 = scripts\mp\rank::getscoreinfovalue("shield_damage");
      var_13 = var_1 getcurrentweapon();
      var_1 thread scripts\mp\utility::giveunifiedpoints("shield_damage", var_13, var_12 * var_11);
      var_1 thread giverecentshieldxp();
      var_1 thread scripts\mp\missions::processchallenge("shield_damage", var_1.var_FC97);
      var_1 thread scripts\mp\missions::processchallenge("shield_bullet_hits", var_1.var_FC95);
      var_1.var_FC97 = 0;
      var_1.var_FC95 = 0;
    }
  }

  var_14 = isDefined(var_0) && isDefined(var_0.stuckenemyentity) && var_0.stuckenemyentity == var_1;
  if(var_9 &level.idflags_shield_explosive_impact && !var_1 scripts\mp\utility::_hasperk("specialty_rearguard")) {
    var_1 thread scripts\mp\missions::processchallenge("shield_explosive_hits", 1);
    var_8 = "none";
    if(!var_9 &level.idflags_shield_explosive_impact_huge) {
      var_3 = 0;
    }
  } else if(var_9 &level.idflags_shield_explosive_splash) {
    if(scripts\mp\utility::func_9F7F(var_1, var_0, var_5, var_4)) {
      var_1.forcehitlocation = "none";
      var_3 = var_1.maxhealth;
    }

    if(!var_1 scripts\mp\utility::_hasperk("specialty_rearguard")) {
      var_1 thread scripts\mp\missions::processchallenge("shield_explosive_hits", 1);
      var_8 = "none";
    }
  } else {
    return "hit shield";
  }

  if(var_4 == "MOD_MELEE" && scripts\mp\weapons::isriotshield(var_5)) {
    var_15 = 0;
    var_1 _meth_83B2(0);
  }

  return var_3;
}

filterdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_5 == "iw7_reaperblade_mp") {
    var_7 = gettime();
    if(isDefined(var_2.var_A9DA)) {
      if(var_2.var_A9DA + 200 >= var_7) {
        return "invalidVictim";
      }
    }

    var_2.var_A9DA = var_7;
  }

  if(!var_3) {
    return "!iDamage";
  }

  if(isDefined(level.hostmigrationtimer)) {
    return "level.hostMigrationTimer";
  }

  var_1 = scripts\mp\utility::_validateattacker(var_1);
  if(!isDefined(var_1) && var_4 != "MOD_FALLING") {
    return "invalid attacker";
  }

  var_2 = scripts\mp\utility::func_143B(var_2);
  if(!isDefined(var_2)) {
    return "invalidVictim";
  }

  if(game["state"] == "postgame") {
    return "game[state] == postgame";
  }

  if(var_2.sessionteam == "spectator") {
    return "victim.sessionteam == spectator";
  }

  if(isDefined(var_2.var_389E) && !var_2.var_389E) {
    return "!victim.canDoCombat";
  }

  if(isDefined(var_1) && isplayer(var_1) && isDefined(var_1.var_389E) && !var_1.var_389E) {
    return "!eAttacker.canDoCombat";
  }

  var_8 = isDefined(var_1) && isDefined(var_0) && isDefined(var_2) && isplayer(var_1) && var_1 == var_0 && var_1 == var_2 && !isDefined(var_0.poison);
  if(var_8) {
    return "attackerIsInflictorVictim";
  }

  if(scripts\mp\tweakables::gettweakablevalue("game", "onlyheadshots")) {
    if(var_6 != "head") {
      if(var_4 == "MOD_PISTOL_BULLET" || var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_EXPLOSIVE_BULLET") {
        return "getTweakableValue(game, onlyheadshots)";
      }
    }
  }

  var_9 = isDefined(var_1) && !isDefined(var_1.gunner) && var_1.classname == "script_vehicle" || var_1.classname == "misc_turret" || var_1.classname == "script_model";
  if(!level.teambased && var_9 && isDefined(var_1.triggerportableradarping) && var_1.triggerportableradarping == var_2) {
    if(var_4 == "MOD_CRUSH") {
      var_2 scripts\mp\utility::_suicide();
    }

    return "ffa suicide";
  }

  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_2)) {
    if(!isDefined(var_0)) {
      return "outOfPhase";
    }

    if(!scripts\mp\equipment\phase_shift::isentityphaseshifted(var_0)) {
      if(!isDefined(var_0.classname) || var_0.classname != "trigger_hurt") {
        return "outOfPhase";
      }

      return;
    }

    return;
  }

  if(isDefined(var_0) && !scripts\mp\equipment\phase_shift::areentitiesinphase(var_0, var_2)) {
    return "outOfPhase";
  }
}

logattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && isplayer(var_1)) {
    addattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }

  if(isDefined(var_1) && !isplayer(var_1) && isDefined(var_1.triggerportableradarping) && !isDefined(var_1.scrambled) || !var_1.scrambled) {
    addattacker(var_0, var_1.triggerportableradarping, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  } else if(isDefined(var_1) && !isplayer(var_1) && isDefined(var_1.secondowner) && isDefined(var_1.scrambled) && var_1.scrambled) {
    addattacker(var_0, var_1.secondowner, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }

  if(isDefined(var_2) && isDefined(var_2.triggerportableradarping)) {
    var_0A = var_2.triggerportableradarping.team != var_0.team || level.friendlyfire == 1;
    if(var_0A && !isDefined(self.attackerdata[var_2.triggerportableradarping.guid])) {
      addattacker(var_0, var_2.triggerportableradarping, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    }
  }

  if(isDefined(var_1)) {
    level.lastlegitimateattacker = var_1;
  }

  if(isDefined(var_1) && isplayer(var_1) && isDefined(var_3)) {
    var_1 thread scripts\mp\weapons::func_3E1E(var_3, var_0);
  }

  if(isDefined(var_1) && isplayer(var_1) && isDefined(var_3) && var_1 != var_0) {
    var_1 thread scripts\mp\events::damagedplayer(self, var_4, var_3);
    var_0.attackerposition = var_1.origin;
    return;
  }

  var_0.attackerposition = undefined;
}

logattackerkillstreak(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A) {
  if(isDefined(var_2) && isplayer(var_2)) {
    addattackerkillstreak(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A);
  }

  if(isDefined(var_2) && !isplayer(var_2) && isDefined(var_2.triggerportableradarping) && !isDefined(var_2.scrambled) || !var_2.scrambled) {
    var_2 = var_2.triggerportableradarping;
    addattackerkillstreak(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A);
  } else if(isDefined(var_2) && !isplayer(var_2) && isDefined(var_2.secondowner) && isDefined(var_2.scrambled) && var_2.scrambled) {
    var_2 = var_2.secondowner;
    addattackerkillstreak(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A);
  }

  if(isDefined(var_2)) {
    level.lastlegitimateattacker = var_2;
  }

  if(isDefined(var_2) && isplayer(var_2) && isDefined(var_0A) && var_2 != var_0) {
    var_0.attackerposition = var_2.origin;
    return;
  }

  var_0.attackerposition = undefined;
}

loggrenadedata(var_0, var_1, var_2, var_3, var_4, var_5) {
  if((issubstr(var_4, "MOD_EXPLOSIVE") || issubstr(var_4, "MOD_PROJECTILE")) && isDefined(var_0) && isDefined(var_1)) {
    var_2.explosiveinfo = [];
    var_2.explosiveinfo["damageTime"] = gettime();
    var_2.explosiveinfo["damageId"] = var_0 getentitynumber();
    var_2.explosiveinfo["returnToSender"] = 0;
    var_2.explosiveinfo["counterKill"] = 0;
    var_2.explosiveinfo["chainKill"] = 0;
    var_2.explosiveinfo["cookedKill"] = 0;
    var_2.explosiveinfo["throwbackKill"] = 0;
    var_2.explosiveinfo["suicideGrenadeKill"] = 0;
    var_2.explosiveinfo["weapon"] = var_5;
    var_6 = issubstr(var_5, "frag_");
    if(var_1 != var_2) {
      if((issubstr(var_5, "c4_") || issubstr(var_5, "proximity_explosive_") || issubstr(var_5, "claymore_")) && isDefined(var_0.triggerportableradarping)) {
        var_2.explosiveinfo["returnToSender"] = var_0.triggerportableradarping == var_2;
        var_2.explosiveinfo["counterKill"] = isDefined(var_0.wasdamaged);
        var_2.explosiveinfo["chainKill"] = isDefined(var_0.waschained);
        var_2.explosiveinfo["bulletPenetrationKill"] = isDefined(var_0.wasdamagedfrombulletpenetration);
        var_2.explosiveinfo["cookedKill"] = 0;
      }

      if(isDefined(var_1.lastgrenadesuicidetime) && var_1.lastgrenadesuicidetime >= gettime() - 50 && var_6) {
        var_2.explosiveinfo["suicideGrenadeKill"] = 1;
      }
    }

    if(var_6) {
      var_2.explosiveinfo["cookedKill"] = isDefined(var_0.iscooked);
      var_2.explosiveinfo["throwbackKill"] = isDefined(var_0.threwback);
    }

    var_2.explosiveinfo["stickKill"] = isDefined(var_0.isstuck) && var_0.isstuck == "enemy";
    var_2.explosiveinfo["stickFriendlyKill"] = isDefined(var_0.isstuck) && var_0.isstuck == "friendly";
    if(isplayer(var_1) && var_1 != self && level.gametype != "aliens") {
      updateinflictorstat(var_0, var_1, var_5);
    }
  }

  if(issubstr(var_4, "MOD_IMPACT") && var_5 == "iw6_rgm_mp") {
    if(isplayer(var_1) && var_1 != self && level.gametype != "aliens") {
      updateinflictorstat(var_0, var_1, var_5);
    }
  }
}

handledamagefeedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_0A = isDefined(var_1) && !isDefined(var_1.gunner) && var_1.classname == "script_vehicle" || var_1.classname == "misc_turret" || var_1.classname == "script_model";
  if(var_0A && isDefined(var_1.gunner)) {
    var_0B = var_1.gunner;
  } else {
    var_0B = var_2;
  }

  var_0C = "standard";
  if(isDefined(var_0B) && var_0B != var_2 && var_3 + var_8 + var_9 > 0 && !isDefined(var_6) || var_6 != "shield") {
    var_0D = !scripts\mp\utility::isreallyalive(var_2) || isagent(var_2) && var_3 >= var_2.health;
    if(var_2 scripts\mp\heavyarmor::hasheavyarmor() || var_2 scripts\mp\heavyarmor::hasheavyarmorinvulnerability()) {
      var_0C = "hitjuggernaut";
    } else if(var_7 &level.idflags_stun) {
      var_0C = "stun";
    } else if(isexplosivedamagemod(var_4) && isDefined(var_2.var_1177D) && var_2.var_1177D) {
      var_0C = "thermobaric_debuff";
    } else if(scripts\mp\utility::func_9F93(var_5, var_4) && var_2 scripts\mp\utility::_hasperk("specialty_stun_resistance")) {
      var_0C = "hittacresist";
    } else if(isexplosivedamagemod(var_4) && var_2 scripts\mp\utility::_hasperk("specialty_blastshield") && !scripts\mp\utility::func_13C9A(var_5, var_6) && !scripts\mp\utility::func_9F7E(var_2, var_0, var_5, var_4)) {
      var_0C = "hitblastshield";
    } else if(var_2 scripts\mp\utility::_hasperk("specialty_combathigh")) {
      var_0C = "hitendgame";
    } else if(scripts\mp\utility::hashealthshield(var_2)) {
      var_0C = "hitlightarmor";
    } else if(var_8 > 0) {
      var_0C = "hitlightarmor";
    } else if(var_2 scripts\mp\utility::isjuggernaut()) {
      var_0C = "hitjuggernaut";
    } else if(var_2 scripts\mp\utility::_hasperk("specialty_moreHealth")) {
      var_0C = "hitmorehealth";
    } else if(var_0B scripts\mp\utility::_hasperk("specialty_moredamage")) {
      var_0C = "hitcritical";
      var_0B scripts\mp\utility::removeperk("specialty_moredamage");
    } else if(var_2 scripts\mp\utility::getdamagemodifiertotal(var_0, var_1, var_2, var_3, var_4, var_5, var_6) < 0.95) {
      var_0C = "hitlowdamage";
    } else if(var_2 scripts\mp\utility::isspawnprotected() && scripts\mp\utility::iskillstreakweapon(var_5)) {
      var_0C = "hitspawnprotection";
    } else if(!func_100C1(var_5)) {
      var_0C = "none";
    }

    var_0E = "high_damage";
    if(var_3 < 20) {
      var_0E = "low_damage";
    }

    var_0F = weaponclass(var_5) == "spread" || getweaponbasename(var_5) == "iw7_mauler_mpr" || issubstr(var_5, "iw7_crdb_mp");
    var_10 = !var_0F && scripts\mp\utility::isheadshot(var_5, var_6, var_4, var_1);
    var_11 = 1;
    var_12 = var_4 == "MOD_MELEE";
    var_13 = "" + gettime();
    if(!var_12 && var_0F && isDefined(var_0B.pelletdmg) && isDefined(var_0B.pelletdmg[var_13]) && isDefined(var_0B.pelletdmg[var_13][var_2.guid]) && var_0B.pelletdmg[var_13][var_2.guid] > 1) {
      if(var_0D) {
        var_12 = 1;
      } else {
        var_11 = 0;
      }
    }

    if(var_11) {
      var_0B thread scripts\mp\damagefeedback::updatedamagefeedback(var_0C, var_0D, var_10, var_0E, var_12);
    }
  }
}

lethalequipmentdamagemod(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_0) && isDefined(var_0.damagedby)) {
    var_1 = var_0.damagedby;
  }

  if(scripts\mp\utility::func_9F7F(var_2, var_0, var_6, var_5)) {
    var_3 = var_2.maxhealth;
  }

  if(isDefined(var_5) && var_5 != "MOD_IMPACT") {
    if(var_2 != var_1 && isDefined(var_0) && var_0.classname == "grenade" && var_2.lastspawntime + 3500 > gettime() && isDefined(var_2.lastspawnpoint) && distance(var_0.origin, var_2.lastspawnpoint.origin) < 500) {
      var_3 = 0;
    }
  }

  if(var_3 < var_2.health) {
    var_2 notify("survived_explosion", var_1);
  }

  loggrenadedata(var_0, var_1, var_2, var_3, var_5, var_6);
  return var_3;
}

func_1177F() {
  self endon("disconnect");
  level endon("game_ended");
  var_0 = gettime() + 5000;
  wait(0.05);
  self.var_1177D = 1;
  for(;;) {
    if(self.health == self.maxhealth) {
      self.var_1177D = 0;
      return;
    }

    if(gettime() >= var_0) {
      self.var_1177D = 0;
      return;
    }

    wait(0.05);
  }
}

playerkilled_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B) {
  var_0C = getweaponbasename(var_6);
  if(var_0C == "iw7_spas_mpr_focus") {
    var_0C = "iw7_spas_mpr";
  } else if(var_0C == "iw7_erad_mp_jump_spread") {
    var_0C = "iw7_erad_mp";
  }

  if(isDefined(var_0C)) {}

  scripts\mp\utility::printgameaction("death", var_2);
  var_2 endon("spawned");
  var_2 notify("killed_player");
  var_2 showuidamageflash();
  var_0D = 0;
  self setblurforplayer(0, 0);
  scripts\mp\outline::outlinedisableinternalall(self);
  var_2.var_1519 = 0;
  var_2.perkoutlined = 0;
  var_2.var_4F = var_1;
  if(scripts\mp\utility::gamehasneutralcrateowner(level.gametype)) {
    if(var_2 != var_1 && var_5 == "MOD_CRUSH") {
      var_0 = var_2;
      var_1 = var_2;
      var_5 = "MOD_SUICIDE";
      var_6 = "none";
      var_8 = "none";
      var_2.attackers = [];
    }
  }

  if(var_6 == "none") {
    if(isDefined(var_0) && isDefined(var_0.var_28AF)) {
      var_6 = var_0.var_28AF;
    }
  }

  if(isDefined(var_0) && !isplayer(var_0)) {
    if(!isDefined(var_1)) {
      if(isDefined(var_0.triggerportableradarping)) {
        var_1 = var_0.triggerportableradarping;
      }
    } else if(!isplayer(var_1)) {
      if(isDefined(var_0.triggerportableradarping)) {
        var_1 = var_0.triggerportableradarping;
      }
    }
  }

  var_1 = scripts\mp\utility::_validateattacker(var_1);
  if(isDefined(var_1)) {
    var_1.assistedsuicide = undefined;
  }

  if(isDefined(var_2.hasriotshieldequipped) && var_2.hasriotshieldequipped) {
    var_2 launchshield(var_3, var_5);
  }

  var_2 scripts\mp\utility::riotshield_clear();
  scripts\mp\weapons::recordtogglescopestates();
  if(!var_0B) {
    if(isDefined(var_2.endgame)) {
      scripts\mp\utility::restorebasevisionset(2);
    } else {
      scripts\mp\utility::restorebasevisionset(0);
      var_2 thermalvisionoff();
    }
  } else {
    var_2.fauxdeath = 1;
    self notify("death");
  }

  if(game["state"] == "postgame") {
    return;
  }

  scripts\mp\perks\_perks::updateactiveperks(var_0, var_1, var_2, var_3, var_5, var_6, var_8, var_7);
  var_0E = 0;
  if(!isplayer(var_0) && isDefined(var_0.primaryweapon)) {
    var_0F = var_0.primaryweapon;
  } else if(isDefined(var_2) && isplayer(var_2) && var_2 getcurrentprimaryweapon() != "none") {
    var_0F = var_2 getcurrentprimaryweapon();
  } else if(issubstr(var_7, "alt_")) {
    var_0F = getsubstr(var_7, 4, var_7.size);
  } else {
    var_0F = undefined;
  }

  if(isDefined(var_2.uselaststandparams) || isDefined(var_2.laststandparams) && var_5 == "MOD_SUICIDE") {
    var_2 ensurelaststandparamsvalidity();
    var_2.uselaststandparams = undefined;
    var_0 = var_2.laststandparams.einflictor;
    var_1 = var_2.laststandparams.var_4F;
    var_3 = var_2.laststandparams.idamage;
    var_5 = var_2.laststandparams.smeansofdeath;
    var_6 = var_2.laststandparams.sweapon;
    var_0F = var_2.laststandparams.sprimaryweapon;
    var_7 = var_2.laststandparams.vdir;
    var_8 = var_2.laststandparams.shitloc;
    var_0E = gettime() - var_2.laststandparams.laststandstarttime / 1000;
    var_2.laststandparams = undefined;
    var_1 = scripts\mp\utility::_validateattacker(var_1);
  }

  if(!isDefined(var_1) || var_1.classname == "trigger_hurt" || var_1.classname == "worldspawn" || var_1 == var_2) {
    var_10 = undefined;
    if(isDefined(self.attackers) && self.attackers.size > 0) {
      foreach(var_12 in self.attackers) {
        if(!isDefined(scripts\mp\utility::_validateattacker(var_12))) {
          continue;
        }

        if(!isDefined(var_2.attackerdata[var_12.guid].var_DA)) {
          continue;
        }

        if(var_12 == var_2 || level.teambased && var_12.team == var_2.team) {
          continue;
        }

        if(var_2.attackerdata[var_12.guid].lasttimedamaged + 2500 < gettime() && var_1 != var_2 && isDefined(var_2.setlasermaterial) && var_2.setlasermaterial) {
          continue;
        }

        if(var_2.attackerdata[var_12.guid].var_DA > 1 && !isDefined(var_10)) {
          var_10 = var_12;
          continue;
        }

        if(isDefined(var_10) && var_2.attackerdata[var_12.guid].var_DA > var_2.attackerdata[var_10.guid].var_DA) {
          var_10 = var_12;
        }
      }
    }

    if(!isDefined(var_10)) {
      if(isDefined(var_2.debuffedbyplayers) && var_2.debuffedbyplayers.size > 0) {
        var_14 = ["chargemode_mp", "cryo_mine_mp", "concussion_grenade_mp", "super_trophy_mp", "blackout_grenade_mp", "blackhole_grenade_mp", "power_spider_grenade_mp", "emp_grenade_mp"];
        foreach(var_16 in var_14) {
          var_17 = scripts\mp\gamescore::getdebuffattackersbyweapon(var_2, var_16);
          if(isDefined(var_17) && var_17.size > 0) {
            for(var_18 = var_17.size - 1; var_18 >= 0; var_18--) {
              var_19 = var_17[var_18];
              if(!isDefined(scripts\mp\utility::_validateattacker(var_19))) {
                continue;
              }

              if(!scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(var_19, var_2))) {
                continue;
              }

              var_10 = var_19;
              if(!isDefined(var_2.attackerdata) || !isDefined(var_2.attackerdata[var_10.guid])) {
                addattacker(var_2, var_10, undefined, var_16, 0, undefined, undefined, undefined, undefined, "MOD_EXPLOSIVE");
              }

              break;
            }
          }

          if(isDefined(var_10)) {
            break;
          }
        }
      }
    }

    if(isDefined(var_10)) {
      var_1 = var_10;
      var_1.assistedsuicide = 1;
      var_6 = var_2.attackerdata[var_10.guid].var_394;
      var_7 = var_2.attackerdata[var_10.guid].vdir;
      var_8 = var_2.attackerdata[var_10.guid].shitloc;
      var_9 = var_2.attackerdata[var_10.guid].box;
      var_5 = var_2.attackerdata[var_10.guid].smeansofdeath;
      var_3 = var_2.attackerdata[var_10.guid].var_DA;
      var_0F = var_2.attackerdata[var_10.guid].sprimaryweapon;
      var_0 = var_1;
      var_0D = 1;
    }
  }

  scripts\mp\equipment\wrist_rocket::wristrocketcooksuicideexplodecheck(var_0, var_1, var_2, var_5, var_6);
  if(scripts\mp\utility::isheadshot(var_6, var_8, var_5, var_1)) {
    var_5 = "MOD_HEAD_SHOT";
  } else if(!isDefined(var_2.nuked)) {
    if(isDefined(level.var_4C4A)) {
      [
        [level.var_4C4A]
      ](var_2, var_5, var_0);
    } else if(var_5 != "MOD_MELEE") {
      var_2 scripts\mp\utility::playdeathsound();
    }
  }

  if(isDefined(level.var_4C47)) {
    [[level.var_4C47]](var_2, var_5, var_0);
  }

  if(isDefined(var_1) && isDefined(var_2) && var_5 == "MOD_MELEE") {
    var_1B = "defaultweapon_melee";
    if(getweaponbasename(var_6) == "iw7_nunchucks" || getweaponbasename(var_6) == "iw7_katana") {
      var_1B = "heavy_2s";
    }

    var_2 playrumbleonentity(var_1B);
    var_1 playrumbleonentity(var_1B);
  }

  var_1C = isfriendlyfire(var_2, var_1);
  if(isDefined(var_1)) {
    if(var_1.var_9F == "script_vehicle" && isDefined(var_1.triggerportableradarping)) {
      var_1 = var_1.triggerportableradarping;
    }

    if(var_1.var_9F == "misc_turret" && isDefined(var_1.triggerportableradarping)) {
      if(isDefined(var_1.vehicle)) {
        var_1.vehicle notify("killedPlayer", var_2);
      }

      var_1 = var_1.triggerportableradarping;
    }

    if(isagent(var_1)) {
      if(isDefined(var_1.agent_type)) {
        if(var_1.agent_type == "dog") {
          var_6 = "guard_dog_mp";
        } else if(var_1.agent_type == "squadmate") {
          var_6 = "agent_support_mp";
        }
      }

      if(isDefined(var_1.triggerportableradarping)) {
        var_1 = var_1.triggerportableradarping;
      }
    }

    if(var_1.var_9F == "script_model" && isDefined(var_1.triggerportableradarping)) {
      var_1 = var_1.triggerportableradarping;
      if(!isfriendlyfire(var_2, var_1) && var_1 != var_2) {
        var_1 notify("crushed_enemy");
      }
    }
  }

  if(var_5 != "MOD_SUICIDE" && scripts\mp\utility::isaigameparticipant(var_2) || scripts\mp\utility::isaigameparticipant(var_1) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["get_attacker_ent"])) {
    var_1D = [[level.bot_funcs["get_attacker_ent"]]](var_1, var_0);
    if(isDefined(var_1D)) {
      if(scripts\mp\utility::isaigameparticipant(var_2)) {
        var_2 botmemoryevent("death", var_6, var_1D.origin, var_2.origin, var_1D);
      }

      if(scripts\mp\utility::isaigameparticipant(var_1)) {
        var_1E = 1;
        if((var_1D.classname == "script_vehicle" && isDefined(var_1D.helitype)) || var_1D.classname == "rocket" || var_1D.classname == "misc_turret") {
          var_1E = 0;
        }

        if(var_1E) {
          var_1 botmemoryevent("kill", var_6, var_1D.origin, var_2.origin, var_2);
        }
      }
    }
  }

  if(scripts\mp\utility::func_9EF0(var_2)) {
    var_2.playerproxyagent scripts\mp\weapons::dropscavengerfordeath(var_1);
    var_2.playerproxyagent[[level.weapondropfunction]](var_1, var_5);
  } else {
    var_2 scripts\mp\weapons::dropscavengerfordeath(var_1, var_5);
    var_2[[level.weapondropfunction]](var_1, var_5);
  }

  if(!var_0B) {
    var_2 scripts\mp\utility::updatesessionstate("dead");
    if(isplayer(var_1) && var_1 != var_2) {
      var_2 setclientomnvar("ui_killcam_killedby_id", var_1 getentitynumber());
    }
  }

  var_1F = isDefined(var_2.fauxdeath) && var_2.fauxdeath && isDefined(var_2.switching_teams) && var_2.switching_teams;
  if(!var_1F) {
    var_2 scripts\mp\playerlogic::removefromalivecount();
  }

  if(!isDefined(var_2.switching_teams)) {
    var_20 = var_2;
    if(isDefined(var_2.commanding_bot)) {
      var_20 = var_2.commanding_bot;
    }

    if(!isDefined(level.ignorescoring) && !var_1C) {
      var_20 scripts\mp\utility::incperstat("deaths", 1, isDefined(level.ignorekdrstats));
      var_20.var_E9 = var_20 scripts\mp\utility::getpersstat("deaths");
      var_20 scripts\mp\utility::updatepersratio("kdRatio", "kills", "deaths", level.ignorekdrstats);
      var_20 scripts\mp\persistence::statsetchild("round", "deaths", var_20.var_E9, level.ignorekdrstats);
    }
  }

  if(isDefined(var_1) && isplayer(var_1)) {
    var_1 checkkillsteal(var_2);
  }

  var_21 = var_6;
  var_22 = var_5;
  if(scripts\mp\utility::iskillstreakweapon(var_21) || isDefined(var_0.streakinfo)) {
    var_23 = undefined;
    if(var_21 == "minijackal_assault_mp") {
      var_23 = 10042;
    } else if(isDefined(var_0.streakinfo)) {
      if(isDefined(var_0.streakinfo.variantid) && var_0.streakinfo.variantid > 0) {
        var_23 = var_0.streakinfo.variantid;
      }
    }

    if(isDefined(var_23)) {
      var_24 = level.var_110EC.rarity[var_23];
      var_25 = level.var_110EC.var_E76D[var_23];
      if(var_21 != "none") {
        var_21 = var_6 + "+loot" + var_25;
        var_22 = "MOD_SCORESTREAK";
      }

      var_2.killsteakvariantattackerinfo = spawnStruct();
      var_2.killsteakvariantattackerinfo.id = var_23;
      var_2.killsteakvariantattackerinfo.rarity = var_24;
    }
  }

  if(isDefined(var_21) && scripts\mp\utility::getweaponbasedsmokegrenadecount(var_21) == "iw7_axe_mp" && isDefined(var_1) && var_1 getweaponammoclip(var_21) > 0) {
    var_22 = "MOD_IMPACT";
  }

  obituary(var_2, var_1, var_21, var_22);
  var_26 = 0;
  var_27 = 1;
  var_2 scripts\mp\clientmatchdata::logplayerdeath(var_1);
  var_28 = var_2.matchdatalifeindex;
  if(!isDefined(var_28)) {
    var_28 = level.maxlives - 1;
  }

  var_2 scripts\mp\matchdata::logplayerdeath(var_28, var_1, var_3, var_5, var_6, var_0F, var_8);
  var_2 scripts\mp\analyticslog::logevent_path();
  var_2 scripts\mp\analyticslog::logevent_playerdeath(var_1, var_5, var_6);
  if(isplayer(var_1)) {
    var_1 scripts\mp\analyticslog::logevent_playerkill(var_2, var_5, var_6);
  }

  var_2 updatedeathdetails(self.attackers, self.attackerdata);
  var_2 func_41D5();
  var_2.deathspectatepos = undefined;
  if(var_2 isswitchingteams()) {
    func_89F1();
  } else if(!isplayer(var_1) || isplayer(var_1) && var_5 == "MOD_FALLING" && !isDefined(var_2.var_115FC) && !var_2.var_115FC) {
    var_2.deathspectatepos = var_2.origin;
    handleworlddeath(var_1, var_28, var_5, var_8);
    if(isagent(var_1)) {
      var_26 = 1;
    }
  } else if(var_1 == var_2 || !scripts\mp\utility::playersareenemies(var_1, var_2) && scripts\mp\utility::isdronepackage(var_0)) {
    handlesuicidedeath(var_5, var_8);
  } else if(var_1C) {
    if(!isDefined(var_2.nuked) || var_6 == "bomb_site_mp") {
      handlefriendlyfiredeath(var_1);
    }
  } else {
    if(var_5 == "MOD_GRENADE" && var_0 == var_1) {
      addattacker(var_2, var_1, var_0, var_6, var_3, (0, 0, 0), var_7, var_8, var_9, var_5);
    }

    if(var_1 scripts\mp\utility::_hasperk("specialty_chain_reaction")) {
      if(var_5 == "MOD_EXPLOSIVE" || var_5 == "MOD_GRENADE_SPLASH" || var_5 == "MOD_GRENADE") {
        var_2 scripts\mp\perks\_perkfunctions::func_10D79(var_1);
      }
    }

    if(var_6 == "case_bomb_mp") {
      var_1 thread scripts\mp\weapons::func_3B0D(var_2, var_2.origin);
    }

    var_26 = 1;
    if(isai(var_2) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["should_do_killcam"])) {
      var_26 = var_2[[level.bot_funcs["should_do_killcam"]]]();
    }

    if(isDefined(level.disable_killcam) && level.disable_killcam) {
      var_26 = 0;
    }

    handlenormaldeath(var_28, var_1, var_0, var_6, var_5, var_2, var_4);
    var_2 thread scripts\mp\missions::playerkilled(var_0, var_1, var_3, var_4, var_5, var_6, var_0F, var_8, var_1.modifiers);
    var_1 thread scripts\mp\intelchallenges::func_99BA(var_2, var_0, var_6, var_5, var_1.modifiers);
    var_1 thread scripts\mp\contractchallenges::contractkillsimmediate(var_2, var_0, var_6, var_5, var_1.modifiers);
    var_2.pers["cur_death_streak"]++;
    if(isplayer(var_1) && var_2 scripts\mp\utility::isjuggernaut()) {
      if(isDefined(var_2.isjuggernautmaniac) && var_2.isjuggernautmaniac) {
        var_1 thread scripts\mp\utility::teamplayercardsplash("callout_killed_maniac", var_1);
        if(var_5 == "MOD_MELEE") {
          var_1 scripts\mp\missions::processchallenge("ch_thisisaknife");
        }
      } else if(isDefined(var_2.isjuggernautlevelcustom) && var_2.isjuggernautlevelcustom) {
        var_1 thread scripts\mp\utility::teamplayercardsplash(level.var_B332, var_1);
      } else {
        var_1 thread scripts\mp\utility::teamplayercardsplash("callout_killed_juggernaut", var_1);
      }
    }
  }

  var_29 = 0;
  var_2A = undefined;
  if(isDefined(self.var_D8B0)) {
    var_29 = 1;
    var_2A = self.var_D8B0;
    self.var_D8B0 = undefined;
  }

  if(isplayer(var_1) && var_1 != self && !level.teambased || level.teambased && self.team != var_1.team) {
    if(var_29 && isDefined(var_2A)) {
      var_2B = var_2A;
    } else {
      var_2B = self.lastdroppableweaponobj;
    }

    var_2B = scripts\mp\utility::func_13CA1(var_2B, var_0);
    thread scripts\mp\gamelogic::func_11AF7(var_2B, var_5);
    var_1 thread scripts\mp\gamelogic::func_11AC8(var_6, var_5);
  }

  var_2 resetplayervariables();
  var_2 resetplayeromnvarsonspawn();
  var_2.sethalfresparticles = var_1;
  var_2.lastdeathpos = var_2.origin;
  var_2.deathtime = gettime();
  var_2.wantsafespawn = 0;
  var_2.revived = 0;
  var_2.var_EB14 = 0;
  var_2.streaktype = scripts\mp\class::loadout_getplayerstreaktype(var_2.streaktype);
  if(scripts\mp\killstreaks\_killstreaks::streaktyperesetsondeath(var_2.streaktype)) {
    if(!level.var_3B1E && !var_2 scripts\mp\utility::_hasperk("specialty_support_killstreaks")) {
      var_2 scripts\mp\killstreaks\_killstreaks::func_E275();
    }
  }

  var_2C = undefined;
  if(var_0D || level.teambased && isDefined(var_1.team) && var_1.team == var_2.team) {
    var_26 = 0;
    var_27 = 0;
  }

  if(var_0B) {
    var_26 = 0;
    var_0A = var_2 _meth_8231(var_0, var_5, var_6, var_8, var_7);
  }

  if(isDefined(var_1) && isplayer(var_1) && isDefined(var_5) && isDefined(var_6) && isDefined(var_8) && isDefined(var_7)) {
    var_2D = scripts\mp\utility::getweaponrootname(var_6);
    var_2E = var_1 _meth_8519(var_6);
    if(isDefined(var_2D) && var_2D == "iw7_rvn" && scripts\mp\utility::istrue(var_2E) && var_5 == "MOD_MELEE") {
      var_0A = var_2 _meth_8231(var_1, "MOD_EXPLOSIVE", var_6, var_8, var_7);
      var_2F = getweaponvariantindex(var_6);
      if(!isDefined(var_2F) || var_2F != 3 && var_2F != 35) {
        playsoundatpos(var_2.origin, "melee_user2_human_default_fatal_npc");
      }
    }
  }

  if(!isDefined(self.nocorpse)) {
    var_2.body = var_2 getplayerweaponrankxp(var_0A);
    if(var_2 _meth_84CA()) {
      var_2.body setscriptablepartstate("chargeModeShieldDrop", "active", 0);
    }

    if(scripts\mp\utility::istrue(level.var_DC24)) {
      thread scripts\mp\weapons::throwingknife_detachknivesfromcorpse(var_2.body);
      thread scripts\mp\weapons::axedetachfromcorpse(var_2.body);
    }
  }

  if(!isDefined(self.nocorpse) && isDefined(var_2.body)) {
    var_2.body.var_336 = "player_corpse";
    if((scripts\engine\utility::isbulletdamage(var_5) && scripts\mp\utility::getweaponbasedsmokegrenadecount(var_6) == "iw7_atomizer_mp") || var_6 == "nuke_mp") {
      var_30 = undefined;
      if(var_6 == "nuke_mp") {
        var_30 = "ks_nuke_death_npc";
      }

      var_2.body thread scripts\mp\archetypes\archassassin_utility::playbodyfx(var_30);
      var_2.body hide(1);
    }

    enqueueweapononkillcorpsetablefuncs(var_1, var_2, var_0, var_6, var_5);
    var_2 thread callcorpsetablefuncs();
    if(var_0B) {
      var_2 getweaponrankxpmultiplier();
      var_2 setsolid(0);
    }

    if(var_2 isonladder() || var_2 ismantling() || !var_2 isonground() || isDefined(var_2.nuked) || isDefined(var_2.customdeath) || scripts\mp\utility::isragdollzerog()) {
      var_31 = 0;
      if(var_5 == "MOD_MELEE") {
        if((isDefined(var_2.isplanting) && var_2.isplanting) || isDefined(var_2.nuked)) {
          var_31 = 1;
        }
      }

      if(!var_31 || scripts\mp\utility::isragdollzerog()) {
        var_2.body giverankxp(1);
        var_2 notify("start_instant_ragdoll", var_5, var_0);
      }
    }

    if(!isDefined(var_2.switching_teams)) {
      if(isDefined(var_1) && isplayer(var_1) && !var_1 scripts\mp\utility::_hasperk("specialty_silentkill")) {
        thread scripts\mp\deathicons::func_17C1(var_2.body, var_2, var_2.team, 5);
      }
    }

    thread delaystartragdoll(var_2.body, var_8, var_7, var_6, var_0, var_5);
  } else if(isDefined(self.nocorpse)) {
    var_2.body = var_2 getplayerweaponrankxp(var_0A);
    var_2.body hide(1);
    if(level.mapname == "mp_neon") {
      thread scripts\mp\weapons::throwingknife_detachknivesfromcorpse(var_2.body);
      thread scripts\mp\weapons::axedetachfromcorpse(var_2.body);
    }
  }

  var_2 thread scripts\mp\supers::handledeath();
  updatecombatrecordkillstats(var_1, var_2, var_5, var_6);
  var_2 thread[[level.onplayerkilled]](var_0, var_1, var_3, var_5, var_6, var_7, var_8, var_9, var_0A, var_28);
  if(isai(var_2) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["on_killed"])) {
    var_2 thread[[level.bot_funcs["on_killed"]]](var_0, var_1, var_3, var_5, var_6, var_7, var_8, var_9, var_0A, var_28);
  }

  if(scripts\mp\utility::isgameparticipant(var_1)) {
    var_32 = var_1 getentitynumber();
  } else {
    var_32 = -1;
  }

  if(!isDefined(var_2C)) {
    var_2C = var_2 scripts\mp\killcam::func_7F32(var_1, var_0, var_6);
  }

  if(isDefined(level.matchrecording_logeventmsg) && isDefined(var_0) && isplayer(var_0) && scripts\engine\utility::isbulletdamage(var_5)) {
    var_33 = var_0.origin - self.origin;
    var_34 = vectornormalize((var_33[0], var_33[1], 0));
    var_35 = anglesToForward(self.angles);
    var_36 = vectornormalize((var_35[0], var_35[1], 0));
    var_37 = clamp(var_36[0] * var_34[0] + var_36[1] * var_34[1], -1, 1);
    var_38 = acos(var_37);
    if(!isDefined(self.var_D37E)) {
      self.var_D37E = [];
    }

    self.var_D37E[self.var_D37E.size] = var_38;
    var_39 = 0;
    if(isDefined(self.engagementstarttime)) {
      var_39 = gettime() - self.engagementstarttime;
    }

    if(!isDefined(self.engagementtimes)) {
      self.engagementtimes = [];
    }

    self.engagementtimes[self.engagementtimes.size] = var_39;
    self.engagementstarttime = undefined;
  }

  var_3A = -1;
  var_3B = 0;
  if(isDefined(var_2C)) {
    var_3A = var_2C getentitynumber();
    var_3B = var_2C.var_64;
    if(!isDefined(var_3B)) {
      var_3B = 0;
    }
  }

  var_3C = var_5 == "MOD_IMPACT" || var_5 == "MOD_HEADSHOT" && isDefined(var_0) || var_5 == "MOD_GRENADE" || isDefined(var_2) && isDefined(var_2.var_1117F) && isDefined(var_0) && var_2.var_1117F == var_0 || var_6 == "throwingknifec4_mp";
  if(!scripts\mp\utility::iskillstreakweapon(var_6)) {
    scripts\mp\killcam::func_F770(var_6, var_5, var_0);
  }

  if(level.recordfinalkillcam && var_27) {
    if((!isDefined(level.disable_killcam) || !level.disable_killcam) && var_5 != "MOD_SUICIDE" && !!isDefined(var_1) || var_1.classname == "trigger_hurt" || var_1.classname == "worldspawn" || var_1 == var_2) {
      scripts\mp\final_killcam::recordfinalkillcam(5, var_2, var_1, var_32, var_0, var_3A, var_3B, var_3C, var_6, var_0E, var_9, var_5);
    }
  }

  var_2 setplayerdata("common", "killCamHowKilled", 0);
  switch (var_5) {
    case "MOD_HEAD_SHOT":
      var_2 setplayerdata("common", "killCamHowKilled", 1);
      break;

    default:
      break;
  }

  var_3D = undefined;
  if(var_26) {
    var_2 scripts\mp\killcam::func_D83E(var_0, var_1);
    if(isDefined(var_0) && isagent(var_0)) {
      var_3D = spawnStruct();
      var_3D.agent_type = var_0.agent_type;
      var_3D.lastspawntime = var_0.lastspawntime;
    }
  }

  if(!var_0B) {
    self.respawntimerstarttime = gettime() + 1750;
    var_3E = scripts\mp\playerlogic::timeuntilspawn(1);
    if(var_3E < 1) {
      var_3E = 1;
    }

    var_2 thread scripts\mp\playerlogic::predictabouttospawnplayerovertime(var_3E);
    wait(1.75);
    if(var_26) {
      var_26 = !scripts\mp\final_killcam::func_10266(0.5);
    }

    var_2 notify("death_delay_finished");
  }

  var_3F = gettime() - var_2.deathtime / 1000;
  self.respawntimerstarttime = gettime();
  var_26 = var_26 && !var_2 scripts\mp\battlebuddy::func_3876();
  if(!isDefined(var_2.cancelkillcam) && var_2.cancelkillcam && var_26 && level.killcam && game["state"] == "playing" && !var_2 scripts\mp\utility::isusingremote() && !level.showingfinalkillcam) {
    var_40 = !scripts\mp\utility::getgametypenumlives() && !var_2.pers["lives"];
    var_3E = scripts\mp\playerlogic::timeuntilspawn(1);
    var_41 = var_40 && var_3E <= 0;
    if(!var_40) {
      var_3E = -1;
      level notify("player_eliminated", var_2);
    }

    if(!isDefined(var_1)) {
      var_42 = [];
    } else {
      var_42 = var_2.pers["loadoutPerks"];
    }

    var_43 = undefined;
    if(isDefined(var_2.killsteakvariantattackerinfo)) {
      var_43 = var_2.killsteakvariantattackerinfo;
    }

    var_2 scripts\mp\killcam::killcam(var_0, var_3D, var_32, var_3A, var_3B, undefined, var_3C, var_6, var_3F + var_0E, var_9, var_3E, scripts\mp\gamelogic::func_11939(), var_1, var_2, var_5, var_42, var_43);
  }

  if(game["state"] != "playing") {
    if(!level.showingfinalkillcam) {
      var_2 scripts\mp\utility::updatesessionstate("dead");
      var_2 scripts\mp\utility::clearkillcamstate();
    }

    return;
  }

  var_44 = scripts\mp\utility::getgametypenumlives();
  var_45 = self.pers["lives"];
  if(self == var_2 && isDefined(var_2.battlebuddy) && scripts\mp\utility::isreallyalive(var_2.battlebuddy) && !scripts\mp\utility::getgametypenumlives() || self.pers["lives"] && !var_2 scripts\mp\utility::isusingremote()) {
    scripts\mp\battlebuddy::func_136D6();
  }

  if(scripts\mp\utility::isvalidclass(var_2.class)) {
    if(isDefined(level.var_1674) && level.var_1674.team == var_2.team) {
      var_2 scripts\mp\killstreaks\_orbital_deployment::func_10DD3("orbital_deployment", 1);
    } else {
      var_2 thread scripts\mp\playerlogic::spawnclient();
    }
  }

  var_2.var_4F = undefined;
}

isswitchingteams() {
  if(isDefined(self.switching_teams)) {
    return 1;
  }

  return 0;
}

isteamswitchbalanced() {
  var_0 = scripts\mp\teams::countplayers();
  var_0[self.leaving_team]--;
  var_0[self.joining_team]++;
  return var_0[self.joining_team] - var_0[self.leaving_team] < 2;
}

isfriendlyfire(var_0, var_1) {
  if(!level.teambased) {
    return 0;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  if(!isplayer(var_1) && !isDefined(var_1.team)) {
    return 0;
  }

  if(var_0.team != var_1.team) {
    return 0;
  }

  if(var_0 == var_1) {
    return 0;
  }

  return 1;
}

killedself(var_0) {
  if(!isplayer(var_0)) {
    return 0;
  }

  if(var_0 != self) {
    return 0;
  }

  return 1;
}

func_89F1() {
  if(!level.teambased) {
    return;
  }

  if(self.joining_team == "spectator" || !isteamswitchbalanced()) {
    thread scripts\mp\utility::giveunifiedpoints("suicide", undefined, undefined, 1, 1);
    scripts\mp\utility::incperstat("suicides", 1);
    self.suicides = scripts\mp\utility::getpersstat("suicides");
  }

  if(isDefined(level.onteamscore)) {
    [[level.onteamscore]](self);
  }
}

handleworlddeath(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(var_0.team)) {
    handlesuicidedeath(var_2, var_3);
    return;
  }

  if((level.teambased && var_0.team != self.team) || !level.teambased) {
    if(isDefined(level.onnormaldeath) && isplayer(var_0) || isagent(var_0) && var_0.team != "spectator") {
      if(!level.gameended) {
        [[level.onnormaldeath]](self, var_0, var_1, var_2);
        return;
      }
    }
  }
}

handlesuicidedeath(var_0, var_1) {
  thread scripts\mp\utility::giveunifiedpoints("suicide");
  scripts\mp\utility::incperstat("suicides", 1);
  self.suicides = scripts\mp\utility::getpersstat("suicides");
  var_2 = scripts\mp\tweakables::gettweakablevalue("game", "suicidepointloss");
  scripts\mp\gamescore::_setplayerscore(self, scripts\mp\gamescore::_getplayerscore(self) - var_2);
  if(scripts\mp\weapons::_meth_85BE() && var_0 == "MOD_SUICIDE" && var_1 == "none") {
    self.lastgrenadesuicidetime = gettime();
  }

  if(isDefined(level.onsuicidedeath)) {
    [[level.onsuicidedeath]](self);
  }

  if(isDefined(self.friendlydamage)) {
    scripts\mp\hud_message::showerrormessage("MP_FRIENDLY_FIRE_WILL_NOT");
  }
}

handlefriendlyfiredeath(var_0) {
  var_0 thread scripts\mp\rank::scoreeventpopup("teamkill");
  var_0.pers["teamkills"] = var_0.pers["teamkills"] + 1;
  var_0.teamkillsthisround++;
  if(scripts\mp\tweakables::gettweakablevalue("team", "teamkillpointloss")) {
    var_1 = scripts\mp\rank::getscoreinfovalue("kill");
    scripts\mp\gamescore::_setplayerscore(var_0, scripts\mp\gamescore::_getplayerscore(var_0) - var_1);
  }

  if(level.maxallowedteamkills < 0) {
    return;
  }

  if(level.ingraceperiod) {
    var_2 = 1;
    var_0.pers["teamkills"] = var_0.pers["teamkills"] + level.maxallowedteamkills;
  } else if(var_2.pers["teamkills"] > 1 && scripts\mp\utility::gettimepassed() < level._meth_8487 * 1000 + 8000 + var_2.pers["teamkills"] * 1000) {
    var_2 = 1;
    var_0.pers["teamkills"] = var_0.pers["teamkills"] + level.maxallowedteamkills;
  } else {
    var_2 = var_2 scripts\mp\playerlogic::teamkilldelay();
  }

  if(var_2 > 0) {
    var_0.pers["teamKillPunish"] = 1;
    var_0 scripts\mp\utility::_suicide();
  }
}

handlenormaldeath(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_1 thread scripts\mp\events::func_A651(var_0, self, var_3, var_4, var_6, var_2);
  if(var_4 == "MOD_HEAD_SHOT") {
    var_1 scripts\mp\utility::incperstat("headshots", 1);
    var_1.headshots = var_1 scripts\mp\utility::getpersstat("headshots");
    if(isDefined(var_1.setlasermaterial)) {
      var_7 = scripts\mp\rank::getscoreinfovalue("kill") * 2;
    } else {
      var_7 = undefined;
    }

    var_1 playlocalsound("bullet_impact_headshot_plr");
    self playSound("bullet_impact_headshot");
  } else if(isDefined(var_2.setlasermaterial)) {
    var_7 = scripts\mp\rank::getscoreinfovalue("kill") * 2;
  } else {
    var_7 = undefined;
  }

  var_8 = var_1;
  if(isDefined(var_1.commanding_bot)) {
    var_8 = var_1.commanding_bot;
  }

  if(!scripts\mp\utility::istrue(level.ignorescoring) && !isfriendlyfire(var_5, var_1)) {
    var_8 scripts\mp\utility::incperstat("kills", 1, isDefined(level.ignorekdrstats));
    var_8.setculldist = var_8 scripts\mp\utility::getpersstat("kills");
    var_8 scripts\mp\utility::updatepersratio("kdRatio", "kills", "deaths", level.ignorekdrstats);
    var_8 scripts\mp\persistence::statsetchild("round", "kills", var_8.setculldist, level.ignorekdrstats);
  }

  self _meth_83FF();
  var_1 _meth_83FE();
  var_9 = var_1.pers["cur_kill_streak"];
  if(!scripts\mp\utility::istrue(level.ignorescoring) && isalive(var_1) || var_1.streaktype == "support") {
    if((var_4 == "MOD_MELEE" && !var_1 scripts\mp\utility::isjuggernaut()) || var_1 scripts\mp\utility::func_A679(var_3)) {
      var_1 registerkill(var_3, var_4, 1);
    }

    if(var_1.pers["cur_kill_streak"] > var_1 scripts\mp\utility::getpersstat("longestStreak")) {
      var_1 scripts\mp\utility::setpersstat("longestStreak", var_1.pers["cur_kill_streak"]);
    }
  }

  var_1.pers["cur_death_streak"] = 0;
  if(!scripts\mp\utility::istrue(level.ignorescoring) && var_1.pers["cur_kill_streak"] > var_1 scripts\mp\persistence::statgetchild("round", "killStreak")) {
    var_1 scripts\mp\persistence::statsetchild("round", "killStreak", var_1.pers["cur_kill_streak"]);
  }

  if(!scripts\mp\utility::istrue(level.ignorescoring) && var_1 scripts\mp\utility::rankingenabled()) {
    if(var_1.pers["cur_kill_streak"] > var_1.kill_streak) {
      var_1 scripts\mp\persistence::func_10E54("killStreak", var_1.pers["cur_kill_streak"]);
      var_1.kill_streak = var_1.pers["cur_kill_streak"];
    }
  }

  if(!scripts\mp\utility::iskillstreakweapon(var_3)) {
    var_1 thread scripts\mp\utility::giveunifiedpoints("kill", var_3);
    if(var_1 scripts\mp\utility::_hasperk("specialty_hardline") && isDefined(var_1.hardlineactive)) {
      var_1 thread scripts\mp\utility::givestreakpointswithtext("assist_hardline", var_3, undefined);
    }
  }

  var_0A = scripts\mp\tweakables::gettweakablevalue("game", "deathpointloss");
  scripts\mp\gamescore::_setplayerscore(self, scripts\mp\gamescore::_getplayerscore(self) - var_0A);
  if(isDefined(level.ac130player) && level.ac130player == var_1) {
    level notify("ai_killed", self, var_1, var_4, var_3);
  }

  if(isDefined(var_1.odin)) {
    level notify("odin_killed_player", self);
  }

  level notify("player_got_killstreak_" + var_1.pers["cur_kill_streak"], var_1);
  var_1 notify("got_killstreak", var_1.pers["cur_kill_streak"]);
  var_1 notify("killed_enemy", self, var_3, var_4);
  if(isDefined(level.onnormaldeath) && var_1.pers["team"] != "spectator" && !isDefined(level.ignorescoring)) {
    [[level.onnormaldeath]](self, var_1, var_0, var_4, var_3);
  }

  level thread scripts\mp\battlechatter_mp::saylocalsounddelayed(var_1, "kill", 0.75);
  var_0B = undefined;
  switch (var_5.loadoutarchetype) {
    case "archetype_assault":
      var_0B = "plr_killfirm_warfighter";
      break;

    case "archetype_assassin":
      var_0B = "plr_killfirm_ftl";
      break;

    case "archetype_heavy":
      var_0B = "plr_killfirm_merc";
      break;

    case "archetype_scout":
      var_0B = "plr_killfirm_c6";
      break;

    case "archetype_engineer":
      var_0B = "plr_killfirm_stryker";
      break;

    case "archetype_sniper":
      var_0B = "plr_killfirm_ghost";
      break;
  }

  if(isDefined(var_0B)) {
    level thread scripts\mp\battlechatter_mp::saytoself(var_1, var_0B, "plr_killfirm_generic", 0.75);
  }

  if(isDefined(self.var_A93F) && isDefined(self.var_A940) && self.var_A93F != var_1) {
    if(gettime() - self.var_A940 < 2500) {
      self.var_A93F thread scripts\mp\gamescore::processshieldassist(self);
    } else if(isalive(self.var_A93F) && gettime() - self.var_A940 < 5000) {
      var_0C = vectornormalize(anglesToForward(self.angles));
      var_0D = vectornormalize(self.var_A93F.origin - self.origin);
      if(vectordot(var_0D, var_0C) > 0.925) {
        self.var_A93F thread scripts\mp\gamescore::processshieldassist(self);
      }
    }
  }

  scripts\mp\gamescore::awardbuffdebuffassists(var_1, self);
  if(isDefined(self.attackers)) {
    foreach(var_0F in self.attackers) {
      if(!isDefined(scripts\mp\utility::_validateattacker(var_0F))) {
        continue;
      }

      if(var_0F == var_1) {
        continue;
      }

      if(self == var_0F) {
        continue;
      }

      if(isDefined(level.assists_disabled)) {
        continue;
      }

      var_10 = undefined;
      if(isDefined(self.attackerdata)) {
        var_11 = self.attackerdata[var_0F.guid];
        if(isDefined(var_11)) {
          var_10 = var_11.var_394;
        }
      }

      var_12 = 0;
      if(self.attackerdata[var_0F.guid].var_DA >= 75) {
        var_12 = 1;
      }

      var_0F thread scripts\mp\gamescore::processassist(self, var_10, var_12);
      if(var_0F scripts\mp\utility::_hasperk("specialty_boom")) {
        var_5 thread scripts\mp\perks\_perkfunctions::setboominternal(var_0F);
      }
    }
  }

  if(isDefined(self.markedbyboomperk)) {
    foreach(var_0F in level.players) {
      if(var_0F.team == self.team) {
        continue;
      }

      if(scripts\engine\utility::array_contains(self.attackers, var_0F)) {
        continue;
      }

      if(scripts\mp\utility::func_2287(self.markedbyboomperk, var_0F scripts\mp\utility::getuniqueid())) {
        var_0F thread scripts\mp\gamescore::processassist(self, var_3);
      }
    }
  }

  if(level.teambased) {
    if(isDefined(level.uavmodels[var_1.team]) && level.uavmodels[var_1.team].size > 0) {
      var_16 = [];
      foreach(var_18 in level.uavmodels[var_1.team]) {
        if(isDefined(var_18) && isDefined(var_18.triggerportableradarping) && var_18.triggerportableradarping != var_1 && !scripts\engine\utility::exist_in_array_MAYBE(var_16, var_18.uavtype)) {
          var_19 = undefined;
          if(scripts\mp\killstreaks\_utility::func_A69F(var_18.streakinfo, "passive_extra_assist")) {
            var_19 = 20;
          }

          var_18.triggerportableradarping thread scripts\mp\utility::giveunifiedpoints(var_18.uavtype + "_assist", undefined, var_19);
          var_16[var_16.size] = var_18.uavtype;
          scripts\mp\missions::func_D9BC(var_18.triggerportableradarping, var_18.uavtype);
          var_18.triggerportableradarping scripts\mp\utility::bufferednotify("update_uav_assist_buffered");
          var_18.triggerportableradarping combatrecordkillstreakstat(var_18.uavtype);
        }
      }
    }
  }

  if(isDefined(self.var_12AF8)) {
    self.var_12AF8 = [];
  }
}

func_9EFE(var_0) {
  if(weaponclass(var_0) == "non-player") {
    return 0;
  }

  if(weaponclass(var_0) == "turret") {
    return 0;
  }

  if(weaponinventorytype(var_0) == "primary" || weaponinventorytype(var_0) == "altmode") {
    return 1;
  }

  return 0;
}

callback_playerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  playerkilled_internal(var_0, var_1, self, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0);
}

func_DB98(var_0) {
  var_1 = 5;
  if(!isDefined(level.var_FCA4)) {
    level.var_FCA4 = [];
  }

  if(level.var_FCA4.size >= var_1) {
    var_2 = level.var_FCA4.size - 1;
    level.var_FCA4[0] delete();
    for(var_3 = 0; var_3 < var_2; var_3++) {
      level.var_FCA4[var_3] = level.var_FCA4[var_3 + 1];
    }

    level.var_FCA4[var_2] = undefined;
  }

  level.var_FCA4[level.var_FCA4.size] = var_0;
}

launchshield(var_0, var_1) {
  if(isDefined(self.hasriotshieldequipped) && self.hasriotshieldequipped) {
    if(isDefined(self.riotshieldmodel)) {
      scripts\mp\utility::riotshield_detach(1);
      return;
    }

    if(isDefined(self.riotshieldmodelstowed)) {
      scripts\mp\utility::riotshield_detach(0);
      return;
    }
  }
}

func_3E0D() {
  if(level.diehardmode != 1) {
    return 0;
  }

  if(!scripts\mp\utility::getgametypenumlives()) {
    return 0;
  }

  if(level.livescount[self.team] > 0) {
    return 0;
  }

  foreach(var_1 in level.players) {
    if(!isalive(var_1)) {
      continue;
    }

    if(var_1.team != self.team) {
      continue;
    }

    if(var_1 == self) {
      continue;
    }

    if(!var_1.inlaststand) {
      return 0;
    }
  }

  foreach(var_1 in level.players) {
    if(!isalive(var_1)) {
      continue;
    }

    if(var_1.team != self.team) {
      continue;
    }

    if(var_1.inlaststand && var_1 != self) {
      var_1 func_AA07(0);
    }
  }

  return 1;
}

checkkillsteal(var_0) {
  if(scripts\mp\utility::matchmakinggame()) {
    return;
  }

  var_1 = 0;
  var_2 = undefined;
  if(isDefined(var_0.attackerdata) && var_0.attackerdata.size > 1) {
    foreach(var_4 in var_0.attackerdata) {
      if(var_4.var_DA > var_1) {
        var_1 = var_4.var_DA;
        var_2 = var_4.attackerent;
      }
    }
  }
}

resetplayervariables() {
  self.switching_teams = undefined;
  self.joining_team = undefined;
  self.leaving_team = undefined;
  self.pers["cur_kill_streak"] = 0;
  self.pers["cur_kill_streak_for_nuke"] = 0;
  scripts\mp\gameobjects::detachusemodels();
}

resetplayeromnvarsonspawn() {
  self setclientomnvar("ui_carrying_bomb", 0);
  self setclientomnvar("ui_objective_state", 0);
  self setclientomnvar("ui_securing", 0);
  self setclientomnvar("ui_light_armor", 0);
  self setclientomnvar("ui_juiced_end_milliseconds", 0);
  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
  self setclientomnvar("ui_edge_glow", 0);
}

hitlocdebug(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_5[0] = 2;
  var_5[1] = 3;
  var_5[2] = 5;
  var_5[3] = 7;
  if(!getdvarint("scr_hitloc_debug")) {
    return;
  }

  if(!isDefined(var_0.hitlocinited)) {
    for(var_6 = 0; var_6 < 6; var_6++) {
      var_0 setclientdvar("ui_hitloc_" + var_6, "");
    }

    var_0.hitlocinited = 1;
  }

  if(level.splitscreen || !isplayer(var_0)) {
    return;
  }

  var_7 = 6;
  if(!isDefined(var_0.damageinfo)) {
    var_0.damageinfo = [];
    for(var_6 = 0; var_6 < var_7; var_6++) {
      var_0.damageinfo[var_6] = spawnStruct();
      var_0.damageinfo[var_6].var_DA = 0;
      var_0.damageinfo[var_6].hitloc = "";
      var_0.damageinfo[var_6].bp = 0;
      var_0.damageinfo[var_6].jugg = 0;
      var_0.damageinfo[var_6].colorindex = 0;
    }

    var_0.damageinfocolorindex = 0;
    var_0.damageinfovictim = undefined;
  }

  for(var_6 = var_7 - 1; var_6 > 0; var_6--) {
    var_0.damageinfo[var_6].var_DA = var_0.damageinfo[var_6 - 1].var_DA;
    var_0.damageinfo[var_6].hitloc = var_0.damageinfo[var_6 - 1].hitloc;
    var_0.damageinfo[var_6].bp = var_0.damageinfo[var_6 - 1].bp;
    var_0.damageinfo[var_6].jugg = var_0.damageinfo[var_6 - 1].jugg;
    var_0.damageinfo[var_6].colorindex = var_0.damageinfo[var_6 - 1].colorindex;
  }

  var_0.damageinfo[0].var_DA = var_2;
  var_0.damageinfo[0].hitloc = var_3;
  var_0.damageinfo[0].bp = var_4 &level.idflags_penetration;
  var_0.damageinfo[0].jugg = var_1 scripts\mp\utility::isjuggernaut();
  if(isDefined(var_0.damageinfovictim) && var_0.damageinfovictim != var_1) {
    var_0.damageinfocolorindex++;
    if(var_0.damageinfocolorindex == var_5.size) {
      var_0.damageinfocolorindex = 0;
    }
  }

  var_0.damageinfovictim = var_1;
  var_0.damageinfo[0].colorindex = var_0.damageinfocolorindex;
  for(var_6 = 0; var_6 < var_7; var_6++) {
    var_8 = "^" + var_5[var_0.damageinfo[var_6].colorindex];
    if(var_0.damageinfo[var_6].hitloc != "") {
      var_9 = var_8 + var_0.damageinfo[var_6].hitloc;
      if(var_0.damageinfo[var_6].bp) {
        var_9 = var_9 + " (BP)";
      }

      if(var_0.damageinfo[var_6].jugg) {
        var_9 = var_9 + " (Jugg)";
      }

      var_0 setclientdvar("ui_hitloc_" + var_6, var_9);
    }

    var_0 setclientdvar("ui_hitloc_damage_" + var_6, var_8 + var_0.damageinfo[var_6].var_DA);
  }
}

giverecentshieldxp() {
  self endon("death");
  self endon("disconnect");
  self notify("giveRecentShieldXP");
  self endon("giveRecentShieldXP");
  self.recentshieldxp++;
  wait(20);
  self.recentshieldxp = 0;
}

updateinflictorstat(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_0.alreadyhit) || !var_0.alreadyhit || !scripts\mp\utility::issinglehitweapon(var_2)) {
    scripts\mp\gamelogic::setinflictorstat(var_0, var_1, var_2);
  }

  if(isDefined(var_0)) {
    var_0.alreadyhit = 1;
  }
}

func_100C1(var_0) {
  switch (var_0) {
    case "stealth_bomb_mp":
    case "artillery_mp":
      return 0;
  }

  return 1;
}

addattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_0.attackerdata)) {
    var_0.attackerdata = [];
  }

  if(!isDefined(var_0.attackerdata[var_1.guid])) {
    var_0.attackers[var_1.guid] = var_1;
    var_0.attackerdata[var_1.guid] = spawnStruct();
    var_0.attackerdata[var_1.guid].var_DA = 0;
    var_0.attackerdata[var_1.guid].attackerent = var_1;
    var_0.attackerdata[var_1.guid].firsttimedamaged = gettime();
    var_0.attackerdata[var_1.guid].hits = 1;
  } else {
    var_0.attackerdata[var_1.guid].hits++;
  }

  if(scripts\mp\utility::iscacprimaryweapon(var_3) && !scripts\mp\utility::iscacsecondaryweapon(var_3)) {
    var_0.attackerdata[var_1.guid].var_54B4 = 1;
  }

  if(isDefined(var_9) && var_9 != "MOD_MELEE") {
    var_0.attackerdata[var_1.guid].didnonmeleedamage = 1;
  }

  var_0A = scripts\mp\utility::getequipmenttype(var_3);
  if(isDefined(var_0A)) {
    if(var_0A == "lethal") {
      var_0.attackerdata[var_1.guid].diddamagewithlethalequipment = 1;
      var_1 scripts\mp\contractchallenges::contractequipmentdamagedplayer(var_0, var_3, var_2);
    }

    if(var_0A == "tactical") {
      var_0.attackerdata[var_1.guid].diddamagewithtacticalequipment = 1;
      var_1 scripts\mp\contractchallenges::contractequipmentdamagedplayer(var_0, var_3, var_2);
    }
  }

  var_0.attackerdata[var_1.guid].var_DA = var_0.attackerdata[var_1.guid].var_DA + var_4;
  var_0.attackerdata[var_1.guid].var_394 = var_3;
  var_0.attackerdata[var_1.guid].vpoint = var_5;
  var_0.attackerdata[var_1.guid].vdir = var_6;
  var_0.attackerdata[var_1.guid].shitloc = var_7;
  var_0.attackerdata[var_1.guid].box = var_8;
  var_0.attackerdata[var_1.guid].smeansofdeath = var_9;
  var_0.attackerdata[var_1.guid].attackerent = var_1;
  var_0.attackerdata[var_1.guid].lasttimedamaged = gettime();
  if(isDefined(var_2) && !isplayer(var_2) && isDefined(var_2.primaryweapon)) {
    var_0.attackerdata[var_1.guid].sprimaryweapon = var_2.primaryweapon;
    return;
  }

  if(isDefined(var_1) && isplayer(var_1) && var_1 getcurrentprimaryweapon() != "none") {
    var_0.attackerdata[var_1.guid].sprimaryweapon = var_1 getcurrentprimaryweapon();
    return;
  }

  var_0.attackerdata[var_1.guid].sprimaryweapon = undefined;
}

addattackerkillstreak(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A) {
  if(!isDefined(var_0.attackerdata)) {
    var_0.attackerdata = [];
  }

  if(!isDefined(var_0.attackerdata[var_2.guid])) {
    var_0.attackers[var_2.guid] = var_2;
    var_0.attackerdata[var_2.guid] = spawnStruct();
    var_0.attackerdata[var_2.guid].var_DA = 0;
    var_0.attackerdata[var_2.guid].attackerent = var_2;
    var_0.attackerdata[var_2.guid].firsttimedamaged = gettime();
    var_0.attackerdata[var_2.guid].hits = 1;
  }

  var_0.attackerdata[var_2.guid].var_DA = var_0.attackerdata[var_2.guid].var_DA + var_1;
  var_0.attackerdata[var_2.guid].var_394 = var_0A;
  var_0.attackerdata[var_2.guid].vpoint = var_4;
  var_0.attackerdata[var_2.guid].vdir = var_3;
  var_0.attackerdata[var_2.guid].updategamerprofileall = var_8;
  var_0.attackerdata[var_2.guid].smeansofdeath = var_5;
  var_0.attackerdata[var_2.guid].attackerent = var_2;
  var_0.attackerdata[var_2.guid].lasttimedamaged = gettime();
  if(isDefined(var_2) && isplayer(var_2) && var_2 getcurrentprimaryweapon() != "none") {
    var_0.attackerdata[var_2.guid].sprimaryweapon = var_2 getcurrentprimaryweapon();
    return;
  }

  var_0.attackerdata[var_2.guid].sprimaryweapon = undefined;
}

resetattackerlist() {
  self.attackers = [];
  self.attackerdata = [];
}

removeoldattackersovertime() {
  self endon("damage");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(!isDefined(self.attackers)) {
    return;
  }

  for(;;) {
    var_0 = gettime();
    foreach(var_3, var_2 in self.attackers) {
      if(isDefined(var_2) && var_0 - self.attackerdata[var_3].lasttimedamaged < 2000) {
        continue;
      }

      self.attackers[var_3] = undefined;
      self.attackerdata[var_3] = undefined;
    }

    scripts\engine\utility::waitframe();
  }
}

callback_playerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B) {
  var_0C = callback_playerdamage_internal(var_0, var_1, self, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B);
}

finishplayerdamagewrapper(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D) {
  if(!isDefined(var_0A)) {
    var_0A = 0;
  }

  if(scripts\mp\utility::isusingremote() && var_2 >= self.health && !var_3 &level.idflags_stun && allowfauxdeath()) {
    if(!isDefined(var_7)) {
      var_7 = (0, 0, 0);
    }

    if(!isDefined(var_1)) {
      var_1 = self;
    }

    if(!isDefined(var_0)) {
      var_0 = var_1;
    }

    playerkilled_internal(var_0, var_1, self, var_2, var_3, var_4, var_5, var_7, var_8, var_9, 0, 1);
  } else {
    if(!callback_killingblow(var_0, var_1, var_2 - var_2 * var_0A, var_3, var_4, var_5, var_6, var_7, var_8, var_9)) {
      return;
    }

    if(!isalive(self)) {
      return;
    }

    if(isplayer(self)) {
      if(!isDefined(var_0C)) {
        var_0C = "";
      }

      if(!isDefined(var_0D)) {
        var_0D = 0;
      }

      self finishplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D);
    }
  }

  if(var_4 == "MOD_EXPLOSIVE_BULLET") {
    self shellshock("damage_mp", getdvarfloat("scr_csmode"));
  }

  damageshellshockandrumble(var_0, var_5, var_4, var_2, var_3, var_1);
}

callback_playerimpaled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread scripts\mp\weapons::impale(var_0, self, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

allowfauxdeath() {
  if(!isDefined(level.allowfauxdeath)) {
    level.allowfauxdeath = 1;
  }

  return level.allowfauxdeath;
}

callback_playerlaststand(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = spawnStruct();
  var_9.einflictor = var_0;
  var_9.var_4F = var_1;
  var_9.idamage = var_2;
  var_9.attackerposition = var_1.origin;
  if(var_1 == self) {
    var_9.smeansofdeath = "MOD_SUICIDE";
  } else {
    var_9.smeansofdeath = var_3;
  }

  var_9.sweapon = var_4;
  if(isDefined(var_1) && isplayer(var_1) && var_1 getcurrentprimaryweapon() != "none") {
    var_9.sprimaryweapon = var_1 getcurrentprimaryweapon();
  } else {
    var_9.sprimaryweapon = undefined;
  }

  var_9.vdir = var_5;
  var_9.shitloc = var_6;
  var_9.laststandstarttime = gettime();
  var_0A = maydolaststand(var_4, var_3, var_6);
  if(isDefined(self.endgame)) {
    var_0A = 0;
  }

  if(level.teambased && isDefined(var_1.team) && var_1.team == self.team) {
    var_0A = 0;
  }

  if(level.diehardmode) {
    if(level.teamcount[self.team] <= 1) {
      var_0A = 0;
    } else if(scripts\mp\utility::isteaminlaststand()) {
      var_0A = 0;
      scripts\mp\utility::func_A6C7(self.team);
    }
  }

  if(!var_0A) {
    self.laststandparams = var_9;
    self.uselaststandparams = 1;
    scripts\mp\utility::_suicide();
    return;
  }

  self.inlaststand = 1;
  var_0B = spawnStruct();
  if(scripts\mp\utility::_hasperk("specialty_finalstand")) {
    var_0B.var_119A8 = game["strings"]["final_stand"];
    var_0B.var_92AE = "specialty_finalstand";
  } else if(scripts\mp\utility::_hasperk("specialty_c4death")) {
    var_0B.var_119A8 = game["strings"]["c4_death"];
    var_0B.var_92AE = "specialty_c4death";
  } else {
    var_0B.var_119A8 = game["strings"]["last_stand"];
    var_0B.var_92AE = "specialty_finalstand";
  }

  var_0B.objective_delete = (1, 0, 0);
  var_0B.sound = "mp_last_stand";
  var_0B.var_5F36 = 2;
  self.health = 1;
  var_0C = "frag_grenade_mp";
  if(isDefined(level.ac130player) && isDefined(var_1) && level.ac130player == var_1) {
    level notify("ai_crawling", self);
  }

  if(scripts\mp\utility::_hasperk("specialty_finalstand")) {
    self.laststandparams = var_9;
    self.infinalstand = 1;
    var_0D = self getweaponslistexclusives();
    foreach(var_0F in var_0D) {
      scripts\mp\utility::_takeweapon(var_0F);
    }

    scripts\engine\utility::allow_usability(0);
    thread func_626F();
    thread func_AA11(20, 1);
    return;
  }

  if(scripts\mp\utility::_hasperk("specialty_c4death")) {
    self.var_D8B0 = self.lastdroppableweaponobj;
    self.laststandparams = var_9;
    self takeallweapons();
    self giveweapon("c4death_mp", 0, 0);
    scripts\mp\utility::_switchtoweapon("c4death_mp");
    scripts\engine\utility::allow_usability(0);
    self.inc4death = 1;
    thread func_AA11(20, 0);
    thread func_53D3();
    thread func_53D2();
    return;
  }

  if(level.diehardmode) {
    var_1 thread scripts\mp\utility::giveunifiedpoints("kill", var_4);
    self.laststandparams = var_9;
    scripts\engine\utility::allow_weapon(0);
    thread func_AA11(20, 0);
    scripts\engine\utility::allow_usability(0);
    return;
  }

  self.laststandparams = var_9;
  var_11 = undefined;
  var_12 = self getweaponslistprimaries();
  foreach(var_0F in var_12) {
    if(scripts\mp\weapons::func_9F54(var_0F)) {
      var_11 = var_0F;
    }
  }

  if(!isDefined(var_11)) {
    var_11 = "iw6_p226_mp";
    scripts\mp\utility::_giveweapon(var_11);
  }

  self givemaxammo(var_11);
  self getraidspawnpoint();
  scripts\engine\utility::allow_usability(0);
  if(!scripts\mp\utility::_hasperk("specialty_laststandoffhand")) {
    self getquadrant();
  }

  scripts\mp\utility::_switchtoweapon(var_11);
  thread func_AA11(10, 0);
}

func_54C8(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  level endon("game_ended");
  wait(var_0);
  self.uselaststandparams = 1;
  scripts\mp\utility::_suicide();
}

func_53D3() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  level endon("game_ended");
  self waittill("detonate");
  self.uselaststandparams = 1;
  func_3345();
}

func_53D2() {
  self endon("detonate");
  self endon("disconnect");
  self endon("joined_team");
  level endon("game_ended");
  self waittill("death");
  func_3345();
}

func_3345() {
  self playSound("detpack_explo_default");
  radiusdamage(self.origin, 312, 100, 100, self);
  if(isalive(self)) {
    scripts\mp\utility::_suicide();
  }
}

func_626F() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  scripts\mp\utility::freezecontrolswrapper(1);
  wait(0.3);
  scripts\mp\utility::freezecontrolswrapper(0);
}

func_AA11(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  level notify("player_last_stand");
  thread func_AA16();
  self.setlasermaterial = 1;
  if(!var_1 && !isDefined(self.inc4death) || !self.inc4death) {
    thread func_AA05();
    scripts\mp\utility::setlowermessage("last_stand", &"PLATFORM_COWARDS_WAY_OUT", undefined, undefined, undefined, undefined, undefined, undefined, 1);
    thread func_AA09();
  }

  if(level.diehardmode == 1 && level.diehardmode != 2) {
    var_2 = spawn("script_model", self.origin);
    var_2 setModel("tag_origin");
    var_2 setcursorhint("HINT_NOICON");
    var_2 sethintstring(&"PLATFORM_REVIVE");
    var_2 revivesetup(self);
    var_2 endon("death");
    var_3 = newteamhudelem(self.team);
    var_3 setshader("waypoint_revive", 8, 8);
    var_3 setwaypoint(1, 1);
    var_3 settargetent(self);
    var_3 thread func_5321(var_2);
    var_3.color = (0.33, 0.75, 0.24);
    scripts\mp\utility::playdeathsound();
    if(var_1) {
      wait(var_0);
      if(self.infinalstand) {
        thread func_AA07(var_1, var_2);
      }
    }

    return;
  } else if(level.diehardmode == 2) {
    thread func_AA09();
    var_2 = spawn("script_model", self.origin);
    var_3 setModel("tag_origin");
    var_3 setcursorhint("HINT_NOICON");
    var_3 sethintstring(&"PLATFORM_REVIVE");
    var_3 revivesetup(self);
    var_3 endon("death");
    var_3 = newteamhudelem(self.team);
    var_3 setshader("waypoint_revive", 8, 8);
    var_3 setwaypoint(1, 1);
    var_3 settargetent(self);
    var_3 thread func_5321(var_2);
    var_3.color = (0.33, 0.75, 0.24);
    scripts\mp\utility::playdeathsound();
    if(var_1) {
      wait(var_0);
      if(self.infinalstand) {
        thread func_AA07(var_1, var_2);
      }
    }

    wait(var_0 / 3);
    var_3.color = (1, 0.64, 0);
    while(var_2.inuse) {
      wait(0.05);
    }

    scripts\mp\utility::playdeathsound();
    wait(var_0 / 3);
    var_3.color = (1, 0, 0);
    while(var_2.inuse) {
      wait(0.05);
    }

    scripts\mp\utility::playdeathsound();
    wait(var_0 / 3);
    while(var_2.inuse) {
      wait(0.05);
    }

    wait(0.05);
    thread func_AA07(var_1);
    return;
  }

  thread func_AA09();
  wait(var_2);
  thread func_AA07(var_3);
}

func_B4A2(var_0, var_1) {
  self endon("stop_maxHealthOverlay");
  self endon("revive");
  self endon("death");
  for(;;) {
    self.health = self.health - 1;
    self.maxhealth = var_0;
    wait(0.05);
    self.maxhealth = 50;
    self.health = self.health + 1;
    wait(0.5);
  }
}

func_AA07(var_0, var_1) {
  if(var_0) {
    self.setlasermaterial = undefined;
    self.infinalstand = 0;
    self notify("revive");
    scripts\mp\utility::clearlowermessage("last_stand");
    scripts\mp\playerlogic::laststandrespawnplayer();
    if(isDefined(var_1)) {
      var_1 delete();
      return;
    }

    return;
  }

  self.uselaststandparams = 1;
  self.var_2A8A = 0;
  scripts\mp\utility::_suicide();
}

func_AA05() {
  self endon("death");
  self endon("disconnect");
  self endon("game_ended");
  self endon("revive");
  for(;;) {
    if(self usebuttonpressed()) {
      var_0 = gettime();
      while(self usebuttonpressed()) {
        wait(0.05);
        if(gettime() - var_0 > 700) {
          break;
        }
      }

      if(gettime() - var_0 > 700) {
        break;
      }
    }

    wait(0.05);
  }

  thread func_AA07(0);
}

func_AA09() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  while(!level.gameended) {
    self.health = 2;
    wait(0.05);
    self.health = 1;
    wait(0.5);
  }

  self.health = self.maxhealth;
}

func_AA16() {
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  self waittill("death");
  scripts\mp\utility::clearlowermessage("last_stand");
  self.setlasermaterial = undefined;
}

maydolaststand(var_0, var_1, var_2) {
  if(var_1 == "MOD_TRIGGER_HURT") {
    return 0;
  }

  if(var_1 != "MOD_PISTOL_BULLET" && var_1 != "MOD_RIFLE_BULLET" && var_1 != "MOD_FALLING" && var_1 != "MOD_EXPLOSIVE_BULLET") {
    return 0;
  }

  if(var_1 == "MOD_IMPACT" && scripts\mp\weapons::func_9FA9(var_0)) {
    return 0;
  }

  if(var_1 == "MOD_IMPACT" && var_0 == "m79_mp" || issubstr(var_0, "gl_")) {
    return 0;
  }

  if(scripts\mp\utility::isheadshot(var_0, var_2, var_1)) {
    return 0;
  }

  if(scripts\mp\utility::isusingremote()) {
    return 0;
  }

  return 1;
}

ensurelaststandparamsvalidity() {
  if(!isDefined(self.laststandparams.var_4F)) {
    self.laststandparams.var_4F = self;
  }
}

gethitlocheight(var_0) {
  switch (var_0) {
    case "neck":
    case "helmet":
    case "head":
      return 60;

    case "left_hand":
    case "right_hand":
    case "left_arm_lower":
    case "right_arm_lower":
    case "left_arm_upper":
    case "right_arm_upper":
    case "torso_upper":
    case "gun":
      return 48;

    case "torso_lower":
      return 40;

    case "right_leg_upper":
    case "left_leg_upper":
      return 32;

    case "right_leg_lower":
    case "left_leg_lower":
      return 10;

    case "right_foot":
    case "left_foot":
      return 5;
  }

  return 48;
}

delaystartragdoll(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_0)) {
    var_6 = var_0 _meth_8112();
    if(animhasnotetrack(var_6, "ignore_ragdoll")) {
      return;
    }
  }

  if(isDefined(level.noragdollents) && level.noragdollents.size) {
    foreach(var_8 in level.noragdollents) {
      if(distancesquared(var_0.origin, var_8.origin) < 65536) {
        return;
      }
    }
  }

  wait(0.2);
  if(!isDefined(var_0)) {
    return;
  }

  if(var_0 _meth_81B7()) {
    return;
  }

  var_6 = var_0 _meth_8112();
  var_0A = 0.35;
  if(animhasnotetrack(var_6, "start_ragdoll")) {
    var_0B = getnotetracktimes(var_6, "start_ragdoll");
    if(isDefined(var_0B)) {
      var_0A = var_0B[0];
    }
  }

  var_0C = var_0A * getanimlength(var_6);
  wait(var_0C);
  if(isDefined(var_0)) {
    var_0 giverankxp();
  }
}

func_7FCA() {
  var_0 = "";
  var_1 = 0;
  var_2 = getarraykeys(self.killedby);
  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];
    if(self.killedby[var_4] <= var_1) {
      continue;
    }

    var_1 = self.killedby[var_4];
    var_5 = var_4;
  }

  return var_0;
}

func_7FC9() {
  var_0 = "";
  var_1 = 0;
  var_2 = getarraykeys(self.var_A653);
  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];
    if(self.var_A653[var_4] <= var_1) {
      continue;
    }

    var_1 = self.var_A653[var_4];
    var_0 = var_4;
  }

  return var_0;
}

damageshellshockandrumble(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread scripts\mp\weapons::onweapondamage(var_0, var_1, var_2, var_3, var_5);
  if(!isai(self) && scripts\engine\utility::getdamagetype(var_2) != "bullet") {
    self playrumbleonentity("damage_heavy");
  }
}

revivesetup(var_0) {
  var_1 = var_0.team;
  self linkto(var_0, "tag_origin");
  self.triggerportableradarping = var_0;
  self.inuse = 0;
  self makeusable();
  updateusablebyteam(var_1);
  thread trackteamchanges(var_1);
  thread revivetriggerthink(var_1);
  thread deleteotpreview();
}

deleteotpreview() {
  self endon("death");
  self.triggerportableradarping scripts\engine\utility::waittill_any_3("death", "disconnect");
  self delete();
}

updateusablebyteam(var_0) {
  foreach(var_2 in level.players) {
    if(var_0 == var_2.team && var_2 != self.triggerportableradarping) {
      self enableplayeruse(var_2);
      continue;
    }

    self disableplayeruse(var_2);
  }
}

trackteamchanges(var_0) {
  self endon("death");
  for(;;) {
    level waittill("joined_team");
    updateusablebyteam(var_0);
  }
}

func_11AF5(var_0) {
  self endon("death");
  for(;;) {
    level waittill("player_last_stand");
    updateusablebyteam(var_0);
  }
}

revivetriggerthink(var_0) {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("trigger", var_1);
    self.triggerportableradarping.var_2A8A = 1;
    if(isDefined(var_1.var_2A8A) && var_1.var_2A8A) {
      self.triggerportableradarping.var_2A8A = 0;
      continue;
    }

    self makeunusable();
    self.triggerportableradarping scripts\mp\utility::freezecontrolswrapper(1);
    var_2 = useholdthink(var_1);
    self.triggerportableradarping.var_2A8A = 0;
    if(!isalive(self.triggerportableradarping)) {
      self delete();
      return;
    }

    self.triggerportableradarping scripts\mp\utility::freezecontrolswrapper(0);
    if(var_2) {
      var_1 thread scripts\mp\hud_message::showsplash("reviver", scripts\mp\rank::getscoreinfovalue("reviver"));
      var_1 thread scripts\mp\utility::giveunifiedpoints("reviver");
      self.triggerportableradarping.setlasermaterial = undefined;
      self.triggerportableradarping scripts\mp\utility::clearlowermessage("last_stand");
      self.triggerportableradarping.movespeedscaler = 1;
      if(self.triggerportableradarping scripts\mp\utility::_hasperk("specialty_lightweight")) {
        self.triggerportableradarping.movespeedscaler = scripts\mp\utility::lightweightscalar();
      }

      self.triggerportableradarping scripts\engine\utility::allow_weapon(1);
      self.triggerportableradarping.maxhealth = 100;
      self.triggerportableradarping scripts\mp\weapons::updatemovespeedscale();
      self.triggerportableradarping scripts\mp\playerlogic::laststandrespawnplayer();
      self.triggerportableradarping scripts\mp\utility::giveperk("specialty_pistoldeath");
      self.triggerportableradarping.var_2A8A = 0;
      self delete();
      return;
    }

    self makeusable();
    updateusablebyteam(var_0);
  }
}

useholdthink(var_0, var_1) {
  var_2 = 3000;
  var_3 = spawn("script_origin", self.origin);
  var_3 hide();
  var_0 playerlinkto(var_3);
  var_0 playerlinkedoffsetenable();
  var_0 scripts\engine\utility::allow_weapon(0);
  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 0;
  if(isDefined(var_1)) {
    self.usetime = var_1;
  } else {
    self.usetime = var_2;
  }

  var_4 = useholdthinkloop(var_0);
  self.inuse = 0;
  var_3 delete();
  if(isDefined(var_0) && scripts\mp\utility::isreallyalive(var_0)) {
    var_0 unlink();
    var_0 scripts\engine\utility::allow_weapon(1);
  }

  if(isDefined(var_4) && var_4) {
    self.triggerportableradarping thread scripts\mp\hud_message::showsplash("revived", undefined, var_0);
    self.triggerportableradarping.inlaststand = 0;
    return 1;
  }

  return 0;
}

useholdthinkloop(var_0) {
  level endon("game_ended");
  self.triggerportableradarping endon("death");
  self.triggerportableradarping endon("disconnect");
  while(scripts\mp\utility::isreallyalive(var_0) && var_0 usebuttonpressed() && self.curprogress < self.usetime && !isDefined(var_0.setlasermaterial) || !var_0.setlasermaterial) {
    self.curprogress = self.curprogress + 50 * self.userate;
    self.userate = 1;
    var_0 scripts\mp\gameobjects::updateuiprogress(self, 1);
    self.triggerportableradarping scripts\mp\gameobjects::updateuiprogress(self, 1);
    if(self.curprogress >= self.usetime) {
      self.inuse = 0;
      var_0 scripts\mp\gameobjects::updateuiprogress(self, 0);
      self.triggerportableradarping scripts\mp\gameobjects::updateuiprogress(self, 0);
      return scripts\mp\utility::isreallyalive(var_0);
    }

    wait(0.05);
  }

  var_0 scripts\mp\gameobjects::updateuiprogress(self, 0);
  self.triggerportableradarping scripts\mp\gameobjects::updateuiprogress(self, 0);
  return 0;
}

callback_killingblow(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(self.lastdamagewasfromenemy) && self.lastdamagewasfromenemy && var_2 >= self.health && isDefined(self.combathigh) && self.combathigh == "specialty_endgame") {
    scripts\mp\utility::giveperk("specialty_endgame");
    return 0;
  }

  return 1;
}

func_612A(var_0) {
  physicsexplosionsphere(self.origin, 64, 64, 1);
  var_1 = [];
  for(var_2 = 0; var_2 < 360; var_2 = var_2 + 30) {
    var_3 = cos(var_2) * 16;
    var_4 = sin(var_2) * 16;
    var_5 = bulletTrace(self.origin + (var_3, var_4, 4), self.origin + (var_3, var_4, -6), 1, self);
    if(isDefined(var_5["entity"]) && isDefined(var_5["entity"].var_336) && var_5["entity"].var_336 == "destructible_vehicle" || var_5["entity"].var_336 == "destructible_toy") {
      var_1[var_1.size] = var_5["entity"];
    }
  }

  if(var_1.size) {
    var_6 = spawn("script_origin", self.origin);
    var_6 hide();
    var_6.type = "soft_landing";
    var_6.var_5379 = var_1;
    radiusdamage(self.origin, 64, 100, 100, var_6);
    wait(0.1);
    var_6 delete();
  }
}

func_9DF9(var_0, var_1) {
  var_2 = anglesToForward(var_0.angles);
  var_2 = (var_2[0], var_2[1], 0);
  var_2 = vectornormalize(var_2);
  var_3 = var_0.origin - var_1.origin;
  var_3 = (var_3[0], var_3[1], 0);
  var_3 = vectornormalize(var_3);
  var_4 = vectordot(var_2, var_3);
  if(var_4 > 0) {
    return 1;
  }

  return 0;
}

func_5321(var_0) {
  var_0 waittill("death");
  self destroy();
}

gamemodemodifyplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_1) && isplayer(var_1) && isalive(var_1)) {
    if(level.matchrules_damagemultiplier) {
      var_2 = var_2 * level.matchrules_damagemultiplier;
    }

    if(level.matchrules_vampirism) {
      var_1.health = int(min(float(var_1.maxhealth), float(var_1.health + 20)));
    }

    if(level.tactical) {
      var_8 = weaponclass(var_4);
      if(var_8 == "sniper" || var_8 == "spread" || issubstr(var_4, "iw7_udm45_mpl")) {
        var_2 = var_2 * 0.7;
      }

      switch (var_7) {
        case "neck":
        case "helmet":
        case "head":
          if(var_8 != "spread") {
            var_2 = var_2 * 2;
          }
          break;

        case "torso_upper":
          break;

        case "left_hand":
        case "right_hand":
        case "left_arm_lower":
        case "right_arm_lower":
        case "left_arm_upper":
        case "right_arm_upper":
        case "gun":
          break;

        case "torso_lower":
          break;

        case "right_leg_upper":
        case "left_leg_upper":
          break;

        case "right_foot":
        case "right_leg_lower":
        case "left_foot":
        case "left_leg_lower":
          break;
      }
    }
  }

  return var_2;
}

registerkill(var_0, var_1, var_2) {
  var_3 = scripts\mp\utility::iskillstreakweapon(var_0) && !var_1 == "MOD_MELEE";
  if(!var_3) {
    self.pers["cur_kill_streak_for_nuke"]++;
  }

  self.pers["cur_kill_streak"]++;
  if(var_2) {
    self notify("kill_streak_increased");
  }

  var_4 = 25;
  if(scripts\mp\utility::_hasperk("specialty_hardline")) {
    var_4--;
  }

  if(!var_3 && self.pers["cur_kill_streak_for_nuke"] == var_4 && !scripts\mp\utility::isanymlgmatch()) {
    if(!isDefined(level.supportnuke) || level.supportnuke) {
      suicide(var_4);
    }
  }
}

suicide(var_0) {}

monitordamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  level endon("game_ended");
  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  self setCanDamage(1);
  self.health = 999999;
  self.maxhealth = var_0;
  if(!isDefined(self.var_E1) || scripts\mp\utility::istrue(var_6)) {
    self.var_E1 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  for(var_7 = 1; var_7; var_7 = monitordamageoneshot(var_8, var_9, var_0A, var_0B, var_0C, var_0D, var_0E, var_0F, var_10, var_11, var_1, var_2, var_3, var_4)) {
    self waittill("damage", var_8, var_9, var_0A, var_0B, var_0C, var_0D, var_0E, var_0F, var_10, var_11, var_12, var_13, var_14, var_15);
    var_11 = scripts\mp\utility::func_13CA1(var_11, var_15);
    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_9)) {
      continue;
    }

    if(var_5) {
      self playrumbleonentity("damage_light");
    }

    if(var_4) {
      logattackerkillstreak(self, var_8, var_9, var_0A, var_0B, var_0C, var_0D, var_0E, var_0F, var_10, var_11);
    }

    if(isDefined(self.helitype) && self.helitype == "littlebird") {
      if(!isDefined(self.attackers)) {
        self.attackers = [];
      }

      var_16 = "";
      if(isDefined(var_9) && isplayer(var_9)) {
        var_16 = var_9 scripts\mp\utility::getuniqueid();
      }

      if(isDefined(self.attackers[var_16])) {
        self.attackers[var_16] = self.attackers[var_16] + var_8;
      } else {
        self.attackers[var_16] = var_8;
      }
    }
  }
}

monitordamageoneshot(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D) {
  if(!isDefined(self)) {
    return 0;
  }

  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_1)) {
    return 0;
  }

  if(isDefined(var_1) && isDefined(var_1.triggerportableradarping)) {
    var_1 = var_1.triggerportableradarping;
  }

  if(isDefined(var_1) && !scripts\mp\utility::isgameparticipant(var_1)) {
    return 1;
  }

  if(isDefined(var_1) && !scripts\mp\weapons::friendlyfirecheck(self.triggerportableradarping, var_1)) {
    return 1;
  }

  if(isDefined(var_9) && scripts\mp\weapons::isballweapon(var_9)) {
    return 1;
  }

  var_0E = var_0;
  if(scripts\mp\weapons::func_66AA(var_9, var_4)) {
    return 1;
  }

  if(isDefined(var_9)) {
    if(!isDefined(var_0C)) {
      var_0C = ::modifydamage;
    }

    var_0E = self[[var_0C]](var_1, var_9, var_4, var_0, var_8);
  }

  if(var_0E <= 0) {
    return 1;
  }

  self.wasdamaged = 1;
  self.var_E1 = self.var_E1 + var_0E;
  if(isDefined(var_8) && var_8 &level.idflags_penetration) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  if(isDefined(var_8) && var_8 &level.idflags_ricochet) {
    self.wasdamagedfrombulletricochet = 1;
  }

  if(var_0D) {
    scripts\mp\killstreaks\_killstreaks::killstreakhit(var_1, var_9, self, var_4);
  }

  if(isDefined(var_1)) {
    if(isplayer(var_1)) {
      var_1 scripts\mp\damagefeedback::updatedamagefeedback(var_0A);
    }
  }

  if(self.var_E1 >= self.maxhealth) {
    self thread[[var_0B]](var_1, var_9, var_4, var_0);
    return 0;
  }

  return 1;
}

modifydamage(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4) && var_4 && level.idflags_ricochet) {
    var_5 = 0.6 * var_3;
  } else {
    var_5 = var_4;
  }

  var_5 = handleempdamage(var_1, var_2, var_5);
  var_5 = handlemissiledamage(var_1, var_2, var_5);
  var_5 = handlegrenadedamage(var_1, var_2, var_5);
  var_5 = handleapdamage(var_1, var_2, var_5);
  return var_5;
}

handlemissiledamage(var_0, var_1, var_2) {
  var_0 = scripts\mp\utility::getweaponbasedsmokegrenadecount(var_0);
  var_3 = var_2;
  switch (var_0) {
    case "maverick_projectile_mp":
    case "ac130_40mm_mp":
    case "ac130_105mm_mp":
    case "aamissile_projectile_mp":
    case "iw7_chargeshot_mp":
    case "iw7_lockon_mp":
    case "drone_hive_projectile_mp":
    case "bomb_site_mp":
      self.largeprojectiledamage = 1;
      var_3 = self.maxhealth + 1;
      break;

    case "remote_tank_projectile_mp":
    case "hind_missile_mp":
    case "hind_bomb_mp":
    case "switch_blade_child_mp":
      self.largeprojectiledamage = 0;
      var_3 = self.maxhealth + 1;
      break;

    case "a10_30mm_turret_mp":
    case "heli_pilot_turret_mp":
      self.largeprojectiledamage = 0;
      var_3 = var_3 * 2;
      break;

    case "sam_projectile_mp":
      self.largeprojectiledamage = 1;
      var_3 = var_2;
      break;
  }

  return var_3;
}

handlegrenadedamage(var_0, var_1, var_2) {
  if(isexplosivedamagemod(var_1)) {
    switch (var_0) {
      case "iw6_rgm_mp":
      case "proximity_explosive_mp":
      case "c4_mp":
        var_2 = var_2 * 3;
        break;

      case "iw6_mk32_mp":
      case "semtexproj_mp":
      case "bouncingbetty_mp":
      case "semtex_mp":
      case "frag_grenade_mp":
        var_2 = var_2 * 4;
        break;

      default:
        if(scripts\mp\utility::isstrstart(var_0, "alt_")) {
          var_2 = var_2 * 3;
        }
        break;
    }
  }

  return var_2;
}

handlemeleedamage(var_0, var_1, var_2) {
  if(var_1 == "MOD_MELEE") {
    return self.maxhealth + 1;
  }

  return var_2;
}

handleempdamage(var_0, var_1, var_2) {
  return var_2;
}

handleapdamage(var_0, var_1, var_2, var_3) {
  var_4 = 1;
  var_5 = level.armorpiercingmod - 1;
  if(scripts\mp\utility::isfmjdamage(var_0, var_1)) {
    var_4 = var_4 + var_5;
  }

  var_6 = level.armorpiercingmodks - 1;
  if(isDefined(var_3) && var_3 scripts\mp\utility::_hasperk("specialty_armorpiercingks") && isDefined(self.streakname) && scripts\mp\weapons::isprimaryweapon(var_0) && scripts\engine\utility::isbulletdamage(var_1)) {
    var_4 = var_4 + var_6;
  }

  return var_2 * var_4;
}

handleshotgundamage(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return var_2;
  }

  if(var_0 == "none") {
    return var_2;
  }

  if(scripts\mp\utility::getweaponbasedsmokegrenadecount(var_0) == "iw7_claw_mp") {
    return var_2;
  }

  if(weaponclass(var_0) != "spread") {
    return var_2;
  }

  return int(min(150, var_2));
}

onkillstreakdamaged(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  if(isDefined(var_1) && isDefined(self.triggerportableradarping)) {
    if(isDefined(var_1.triggerportableradarping) && isplayer(var_1.triggerportableradarping)) {
      var_1 = var_1.triggerportableradarping;
    }

    if(isplayer(var_1) && self.triggerportableradarping scripts\mp\utility::isenemy(var_1)) {
      var_4 = var_1;
    }
  }

  if(isDefined(var_4)) {
    thread scripts\mp\missions::killstreakdamaged(var_0, self.triggerportableradarping, var_4, var_2, var_3);
  }
}

onkillstreakkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = 0;
  var_0A = undefined;
  if(isDefined(var_1) && isDefined(self.triggerportableradarping)) {
    if(isDefined(var_1.triggerportableradarping) && isplayer(var_1.triggerportableradarping)) {
      var_1 = var_1.triggerportableradarping;
    }

    if(self.triggerportableradarping scripts\mp\utility::isenemy(var_1)) {
      var_0A = var_1;
    }
  }

  if(isDefined(var_0A)) {
    var_0A notify("destroyed_killstreak", var_2);
    if(isDefined(var_7)) {
      thread scripts\mp\utility::teamplayercardsplash(var_7, var_0A);
    }

    scripts\mp\missions::setweaponammostock(self, var_0A);
    thread scripts\mp\events::killedkillstreak(var_0, var_0A);
    thread scripts\mp\missions::killstreakkilled(var_0, self.triggerportableradarping, self, undefined, var_0A, var_4, var_3, var_2, var_5);
    var_9 = 1;
  }

  if(isDefined(self.triggerportableradarping) && isDefined(var_6)) {
    self.triggerportableradarping scripts\mp\utility::playkillstreakdialogonplayer(var_6, undefined, undefined, self.origin);
  }

  if(!scripts\mp\utility::istrue(var_8)) {
    self notify("death");
  }

  return var_9;
}

func_12EFD(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.var_DDBE)) {
    self.var_DDBE = [];
  }

  if(self.health >= self.maxhealth) {
    func_41D5();
  }

  var_4 = undefined;
  if(self.var_DDBE.size < 4) {
    var_4 = spawnStruct();
    self.var_DDBE[self.var_DDBE.size] = var_4;
  } else {
    for(var_5 = 0; var_5 < 3; var_5++) {
      self.var_DDBE[var_5] = self.var_DDBE[var_5 + 1];
    }

    var_4 = spawnStruct();
    self.var_DDBE[self.var_DDBE.size - 1] = var_4;
  }

  if(var_3 == "MOD_MELEE" && var_2 == "head") {
    var_2 = "torso_upper";
  }

  var_4.var_DA = int(min(var_0, self.health));
  var_4.var_4F = var_1;
  var_4.location = var_2;
}

func_41D5() {
  self.var_DDBE = [];
}

updatedeathdetails(var_0, var_1) {
  var_2 = 0;
  if(isDefined(var_0) && isDefined(var_1)) {
    foreach(var_6, var_4 in var_0) {
      if(!isplayer(var_4)) {
        continue;
      }

      var_5 = var_4 getentitynumber();
      self setclientomnvar("ui_death_details_attacker_" + var_2, var_5);
      self setclientomnvar("ui_death_details_hits_" + var_2, int(min(var_1[var_6].hits, 10)));
      var_2++;
      if(var_2 >= 4) {
        break;
      }
    }
  }

  for(var_7 = var_2; var_7 < 4; var_7++) {
    self setclientomnvar("ui_death_details_attacker_" + var_7, -1);
  }
}

getindexfromhitloc(var_0) {
  switch (var_0) {
    case "torso_upper":
      return 0;

    case "torso_lower":
      return 1;

    case "helmet":
      return 2;

    case "head":
      return 3;

    case "neck":
      return 4;

    case "left_arm_upper":
      return 5;

    case "left_arm_lower":
      return 6;

    case "left_hand":
      return 7;

    case "right_arm_upper":
      return 8;

    case "right_arm_lower":
      return 9;

    case "right_hand":
      return 10;

    case "left_leg_upper":
      return 11;

    case "left_leg_lower":
      return 12;

    case "left_foot":
      return 13;

    case "right_leg_upper":
      return 14;

    case "right_leg_lower":
      return 15;

    case "right_foot":
      return 16;

    case "gun":
      return 17;

    case "none":
      return 18;
  }

  return 0;
}

showuidamageflash() {
  self setclientomnvar("ui_damage_event", self.damageeventcount);
}

updatecombatrecordkillstats(var_0, var_1, var_2, var_3) {
  if(!scripts\mp\utility::canrecordcombatrecordstats()) {
    return;
  }

  if(isDefined(var_0) && isplayer(var_0)) {
    var_0 combatrecordarchetypekill(var_0.loadoutarchetype);
    if(isDefined(var_3)) {
      var_4 = scripts\mp\utility::getequipmenttype(var_3);
      if(isDefined(var_4) && var_4 == "lethal") {
        var_5 = scripts\mp\powers::func_D737(var_3);
        var_0 combatrecordlethalkill(var_5);
      } else {
        var_6 = scripts\mp\missions::func_7F48(var_3);
        if(isDefined(var_6)) {
          if(isenumvaluevalid("mp", "LethalScorestreakStatItems", var_6)) {
            var_0 combatrecordkillstreakstat(var_6);
          }
        }

        if(scripts\mp\utility::istrue(var_0.personalradaractive)) {
          var_0 combatrecordtacticalstat("power_periphVis");
        }

        if(scripts\mp\utility::istrue(var_0.var_8BC2)) {
          var_0 combatrecordtacticalstat("power_adrenaline");
        }
      }
    }
  }

  if(isDefined(var_1) && isplayer(var_1)) {
    var_1 combatrecordarchetypedeath(var_1.loadoutarchetype);
  }
}

combatrecordarchetypekill(var_0) {
  if(!scripts\mp\utility::canrecordcombatrecordstats()) {
    return;
  }

  var_1 = self getplayerdata("mp", "archetypeStats", var_0, "kills");
  self setplayerdata("mp", "archetypeStats", var_0, "kills", var_1 + 1);
}

combatrecordarchetypedeath(var_0) {
  if(!scripts\mp\utility::canrecordcombatrecordstats()) {
    return;
  }

  var_1 = self getplayerdata("mp", "archetypeStats", var_0, "deaths");
  self setplayerdata("mp", "archetypeStats", var_0, "deaths", var_1 + 1);
}

combatrecordlethalkill(var_0) {
  if(!scripts\mp\utility::canrecordcombatrecordstats()) {
    return;
  }

  var_1 = self getplayerdata("mp", "lethalStats", var_0, "kills");
  self setplayerdata("mp", "lethalStats", var_0, "kills", var_1 + 1);
}

combatrecordtacticalstat(var_0, var_1) {
  if(!scripts\mp\utility::canrecordcombatrecordstats()) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = self getplayerdata("mp", "tacticalStats", var_0, "extraStat1");
  self setplayerdata("mp", "tacticalStats", var_0, "extraStat1", var_2 + var_1);
}

combatrecordkillstreakstat(var_0) {
  if(!scripts\mp\utility::canrecordcombatrecordstats()) {
    return;
  }

  var_1 = scripts\mp\utility::getstreakrecordtype(var_0);
  if(!isDefined(var_1)) {
    return;
  }

  var_2 = self getplayerdata("mp", var_1, var_0, "extraStat1");
  self setplayerdata("mp", var_1, var_0, "extraStat1", var_2 + 1);
}

enqueuecorpsetablefunc(var_0, var_1) {
  if(!isDefined(self.corpsetablefuncs)) {
    self.corpsetablefuncs = [];
    self.corpsetablefunccounts = [];
  }

  if(!isDefined(self.corpsetablefuncs[var_0])) {
    self.corpsetablefuncs[var_0] = var_1;
    self.corpsetablefunccounts[var_0] = 0;
  }

  self.corpsetablefunccounts[var_0]++;
}

dequeuecorpsetablefunc(var_0) {
  if(!isDefined(self.corpsetablefuncs)) {
    return;
  }

  if(!isDefined(self.corpsetablefuncs[var_0])) {
    return;
  }

  self.corpsetablefunccounts[var_0]--;
  if(self.corpsetablefunccounts[var_0] <= 0) {
    self.corpsetablefuncs[var_0] = undefined;
    self.corpsetablefunccounts[var_0] = undefined;
  }
}

callcorpsetablefuncs() {
  if(!isDefined(self.corpsetablefuncs)) {
    return;
  }

  var_0 = self.body;
  foreach(var_2 in self.corpsetablefuncs) {
    self thread[[var_2]](var_0);
  }

  thread clearcorpsetablefuncs();
}

clearcorpsetablefuncs() {
  self notify("clearCorpsetableFuncs");
  self.corpsetablefuncs = undefined;
  self.corpsetablefunccounts = undefined;
}

enqueueweapononkillcorpsetablefuncs(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\mp\weapons::isprimaryweapon(var_3)) {
    var_5 = scripts\mp\utility::getweaponrootname(var_3);
    var_6 = getweaponvariantindex(var_3);
    var_7 = var_0 _meth_8519(var_3);
    if(var_5 == "iw7_rvn" && scripts\mp\utility::istrue(var_7) && var_4 == "MOD_MELEE") {
      var_1 thread enqueuecorpsetablefunc("passive_melee_cone_expl", ::scripts\mp\perks\_weaponpassives::meleeconeexplodevictimcorpsefx);
    }
  }
}