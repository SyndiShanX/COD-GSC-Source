/*********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\damage.gsc
*********************************/

callback_playerdamage_internal(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C) {
  if(isDefined(param_01) && scripts\mp\utility::istrue(level.jittermodcheck) && level.jittermodcheck == 2 && scripts\mp\utility::istrue(param_01.ismodded)) {
    param_03 = 0;
    return;
  }

  if(isDefined(param_01) && param_01.classname == "worldspawn") {
    param_01 = undefined;
  }

  if(isDefined(param_01) && isDefined(param_01.gunner)) {
    param_01 = param_01.gunner;
  }

  if(!scripts\mp\utility::gameflag("prematch_done")) {
    return "finished";
  }

  var_0E = gettime();
  var_0F = param_02.health;
  if(isplayer(param_02)) {
    param_02.var_AA47 = param_02 getcurrentweapon();
    param_02.var_13905 = param_02 scripts\mp\utility::func_9EE8();
    if(param_02.var_13905) {
      param_02.var_A98B = gettime();
    }
  }

  if(!level.tactical) {
    param_04 = param_04 | level.idflags_no_knockback;
  }

  if(func_B4CA(param_02, param_01, param_06)) {
    return;
  }

  if(param_05 == "MOD_FALLING" && isDefined(param_02.var_115FC) && param_02.var_115FC) {
    param_01 = param_02.var_115FD;
  }

  var_10 = 0;
  if(param_04 &level.idflags_stun) {
    var_10 = 0;
    param_03 = 0;
  }

  var_11 = filterdamage(param_00, param_01, param_02, param_03, param_05, param_06, param_09);
  if(isDefined(var_11)) {
    return var_11;
  }

  var_12 = scripts\mp\utility::attackerishittingteam(param_02, param_01);
  if(var_12) {
    param_03 = handlefriendlyfiredamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, var_10, param_0B, param_0C);
    if(param_03 == 0) {
      return;
    }
  }

  if(scripts\mp\utility::istrue(param_02.spawnprotection)) {
    var_13 = isDefined(param_01.classname) && param_01.classname == "trigger_hurt";
    if(!var_13) {
      handledamagefeedback(param_00, param_01, param_02, 0, param_05, param_06, param_09, param_04, 1, 1);
      return "finished";
    }
  }

  var_14 = scripts\mp\utility::getequipmenttype(param_06);
  if(isDefined(var_14)) {
    if(var_14 == "lethal") {
      param_03 = lethalequipmentdamagemod(param_00, param_01, param_02, param_03, param_04, param_05, param_06);
    } else if(var_14 == "equipment_other") {
      if(param_06 == "bouncingbetty_mp") {
        if(!scripts\mp\weapons::minedamageheightpassed(param_00, param_02)) {
          param_03 = 0;
        } else if(param_02 getstance() == "crouch" || param_02 getstance() == "prone") {
          param_03 = int(param_03 / 2);
        }
      }

      if(param_06 == "portal_grenade_mp" && param_03 != 400) {
        param_02 thread scripts\mp\equipment\portal_grenade::func_D68E(param_00, param_01);
      }
    }
  }

  var_15 = scripts\mp\utility::_meth_8238(param_06);
  if(var_15 == "killstreak") {
    param_03 = killstreakdamagefilter(param_01, param_02, param_03, param_06, param_05);
    if(param_03 == 0) {
      return;
    }

    if(param_06 == "killstreak_jammer_mp") {
      return "sWeapon == killstreak_jammer_mp";
    }

    if(isDefined(level.ac130player) && isDefined(param_01) && level.ac130player == param_01) {
      level notify("ai_pain", param_02);
    }
  }

  param_03 = modifydamagegeneral(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
  param_03 = handleriotshieldhits(param_00, param_02, param_01, param_03, param_05, param_06, param_07, param_08, param_09, param_04);
  if(isstring(param_03)) {
    return param_03;
  }

  if(scripts\mp\utility::func_9EF0(param_02)) {
    param_03 = param_02 scripts\mp\killstreaks\_utility::getmodifiedantikillstreakdamage(param_01, param_06, param_05, param_03, param_02.maxhealth, 3, 4, 6, 0);
    if(isDefined(param_01) && isplayer(param_01) && scripts\mp\equipment\phase_shift::isentityphaseshifted(param_01)) {
      param_03 = 0;
    }
  }

  if(isplayer(param_01)) {
    param_01 scripts\mp\perks\_weaponpassives::func_3E01();
  }

  var_16 = func_3696(param_02, param_01, param_03, param_05, param_06, param_07, param_08, param_09, param_00, 0, param_04);
  param_03 = var_16[0];
  var_17 = var_16[1];
  var_18 = var_16[2];
  var_19 = var_17 != 0 || var_18 != 0;
  param_09 = var_16[3];
  if(isDefined(param_02.forcehitlocation)) {
    param_09 = param_02.forcehitlocation;
  }

  scripts\mp\perks\_perkfunctions::bulletoutlinecheck(param_01, param_02, param_06, param_05);
  if((param_03 >= param_02.health && scripts\engine\utility::string_starts_with(param_06, "iw7_penetrationrail_mp") && param_05 != "MOD_MELEE") || param_03 >= param_02.health && scripts\engine\utility::string_starts_with(param_06, "iw7_nunchucks_mpl") && param_05 == "MOD_MELEE") {
    var_1A = scripts\mp\weapons::impale_endpoint(param_07, param_08);
    var_1B = scripts\mp\weapons::trace_impale(param_07, var_1A);
    if(var_1B["hittype"] != "hittype_world") {
      var_1C = (param_08[0], param_08[1], param_08[2]);
      if(var_1C[2] > -0.3 && var_1C[2] < 0.1) {
        var_1C = (var_1C[0], var_1C[1], 0.1);
        vectornormalize(var_1C);
      }

      param_02 _meth_84DC(var_1C, 650);
    }
  }

  if(isai(self)) {
    self[[level.bot_funcs["on_damaged"]]](param_01, param_03, param_05, param_06, param_00, param_09);
  }

  if(isplayer(param_01) && param_06 == "smoke_grenade_mp" || param_06 == "throwingknife_mp" || param_06 == "throwingknifeteleport_mp" || param_06 == "throwingknifesmokewall_mp" || param_06 == "gas_grenade_mp" || param_06 == "throwingreaper_mp") {
    param_01 thread scripts\mp\gamelogic::threadedsetweaponstatbyname(param_06, 1, "hits");
  }

  if(param_05 == "MOD_FALLING") {
    param_02 thread func_612A(param_03);
  }

  if(!isDefined(param_08)) {
    param_04 = param_04 | level.idflags_no_knockback;
  }

  if(isDefined(param_01) && param_01.classname == "script_origin" && isDefined(param_01.type) && param_01.type == "soft_landing") {
    return "soft_landing";
  }

  logattacker(param_02, param_01, param_00, param_06, param_03, param_07, param_08, param_09, param_0A, param_05);
  if(isDefined(param_00) && isDefined(param_00.triggerportableradarping) && param_00.triggerportableradarping.team != param_02.team) {
    param_02.lastdamagewasfromenemy = 1;
  } else {
    param_02.lastdamagewasfromenemy = isDefined(param_01) && param_01 != param_02;
  }

  if(param_02.lastdamagewasfromenemy) {
    var_1D = gettime();
    param_01.damagedplayers[param_02.guid] = var_1D;
    param_02.lastdamagedtime = var_1D;
  }

  param_02 func_12EFD(param_03, param_01, param_09, param_05);
  if(scripts\mp\codcasterclientmatchdata::shouldlogcodcasterclientmatchdata()) {
    if(isplayer(param_01)) {
      var_1E = scripts\mp\codcasterclientmatchdata::getcodcasterplayervalue(param_01, "damageDone");
      scripts\mp\codcasterclientmatchdata::setcodcasterplayervalue(param_01, "damageDone", var_1E + param_03);
    }
  }

  param_02 thread scripts\mp\missions::func_D378(param_00, param_01, param_03, param_05, param_06, param_09);
  if(isDefined(param_01) && param_03 != 0) {
    param_01 notify("victim_damaged", param_02, param_00, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
    param_01 scripts\mp\contractchallenges::contractplayerdamaged(param_03);
  }

  var_1F = param_08;
  if(isDefined(param_04) && param_04 &level.idflags_ricochet && param_03 < self.health) {
    var_1F = param_02.origin - param_01.origin;
  }

  param_02 finishplayerdamagewrapper(param_00, param_01, param_03, param_04, param_05, param_06, param_07, var_1F, param_09, param_0A, var_10, param_0B, param_0C, var_19);
  if(param_03 > 10 && isDefined(param_00) && !param_02 scripts\mp\utility::isusingremote() && isplayer(param_02)) {
    param_02 thread scripts\mp\shellshock::bloodeffect(param_00.origin);
    if(isplayer(param_00) && param_05 == "MOD_MELEE") {
      if(isalive(param_02) && !param_02 scripts\mp\utility::_hasperk("specialty_stun_resistance")) {
        param_02 thread func_B645(0.75);
        param_02.var_904B = gettime();
      }

      param_00 thread scripts\mp\shellshock::func_2BC3(param_06);
      param_02 playrumbleonentity("defaultweapon_melee");
      param_00 playrumbleonentity("defaultweapon_melee");
    }
  }

  if(isagent(self)) {
    if(scripts\mp\utility::func_9EF0(self)) {
      if(param_03 >= self.health) {
        param_03 = self.health - 1;
        if(isDefined(self.triggerportableradarping)) {
          self.triggerportableradarping notify("player_killstreak_agent_death", self, param_00, param_01, param_03, param_04, param_05, param_06);
        }
      } else {
        self[[scripts\mp\agents\agent_utility::agentfunc("on_damaged_finished")]](param_00, param_01, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
        if(self.var_165A == "remote_c8") {
          if(isDefined(self.triggerportableradarping) && isDefined(self.triggerportableradarping.var_4BE1) && self.triggerportableradarping.var_4BE1 == "MANUAL") {
            self setclientomnvar("ui_remote_c8_health", self.health / self.maxhealth);
          }
        }
      }
    } else {
      self[[scripts\mp\agents\agent_utility::agentfunc("on_damaged_finished")]](param_00, param_01, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
    }
  }

  handledamagefeedback(param_00, param_01, param_02, param_03, param_05, param_06, param_09, param_04, var_17, var_18);
  scripts\mp\gamelogic::sethasdonecombat(param_02, 1);
  if(isDefined(param_01) && param_01 != param_02) {
    level.usestartspawns = 0;
  }

  if(isplayer(param_01) && isDefined(param_01.pers["participation"])) {
    param_01.pers["participation"]++;
  } else if(isplayer(param_01)) {
    param_01.pers["participation"] = 1;
  }

  if(isDefined(level.matchrecording_logeventmsg) && isplayer(param_02) && isDefined(param_00) && isplayer(param_00) && scripts\engine\utility::isbulletdamage(param_05)) {
    if(var_0F == param_02.maxhealth && param_02.health != self.maxhealth) {
      param_02.engagementstarttime = gettime();
    }
  }

  if(allowdamageflash(param_01, param_02, param_06, param_05, param_03)) {
    param_02 showuidamageflash();
  }

  if(isDefined(param_01) && param_01 scripts\mp\utility::_hasperk("specialty_mark_targets") && param_03 > 0) {
    param_01 thread scripts\mp\perks\_perk_mark_targets::marktarget_run(param_02, param_05);
  }

  return "finished";
}

func_B645(param_00) {
  self endon("death");
  self endon("disconnect");
  var_01 = newclienthudelem(self);
  var_01.x = 0;
  var_01.y = 0;
  var_01.alignx = "left";
  var_01.aligny = "top";
  var_01.sort = 1;
  var_01.horzalign = "fullscreen";
  var_01.vertalign = "fullscreen";
  var_01.alpha = 0;
  var_01.foreground = 1;
  var_01 setshader("black", 640, 480);
  thread monitormeleeoverlay(var_01);
  self shellshock("melee_mp", param_00);
  self earthquakeforplayer(0.35, 0.5, self.origin, 100);
  self setclientomnvar("ui_hud_shake", 1);
  var_01 fadeovertime(0.1);
  var_01.alpha = 0.2;
  wait(0.1);
  var_01 fadeovertime(0.3);
  var_01.alpha = 0.4;
  wait(0.3);
  var_01 fadeovertime(0.6);
  var_01.alpha = 0;
}

monitormeleeoverlay(param_00) {
  scripts\engine\utility::waittill_any_timeout_1(2, "death", "disconnect");
  param_00 destroy();
}

allowdamageflash(param_00, param_01, param_02, param_03, param_04) {
  if(param_04 == 0) {
    return 0;
  }

  if(suppressdamageflash(param_00, param_01, param_02, param_03, param_04)) {
    return 0;
  }

  return 1;
}

suppressdamageflash(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(param_02)) {
    switch (param_02) {
      case "super_trophy_mp":
        return scripts\mp\supers\super_supertrophy::func_11286(param_00, param_01, param_02, param_03, param_04);
    }
  }

  return 0;
}

func_3696(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(isplayer(param_00) && param_00 _meth_8568() || param_00 _meth_8569()) {
    return [0, 0, 0, param_07];
  }

  param_00 notify("damage_begin", param_01);
  var_0B = 0;
  var_0C = 0;
  if(param_00 scripts\mp\utility::isjuggernaut()) {
    var_0C = level.var_A4A7;
    if(isDefined(self.isjuggernautmaniac) && self.isjuggernautmaniac) {
      var_0C = level.var_A4A6;
    }
  }

  if(scripts\engine\utility::isbulletdamage(param_03)) {
    if(isDefined(param_04) && scripts\mp\utility::iscacprimaryweapon(param_04) || scripts\mp\utility::iscacsecondaryweapon(param_04)) {
      if(isbehindmeleevictim(param_01, param_00) && isplayer(param_00)) {
        level thread scripts\mp\battlechatter_mp::saytoself(param_00, "plr_hit_back", undefined, 0.1);
      }

      if(isDefined(param_01.var_C7E6) && param_01.var_C7E6) {
        var_0B = var_0B + param_02 * 0.3;
      }
    }

    if(isDefined(param_04) && issubstr(param_04, "iw7_gauss_mpl")) {
      var_0D = scripts\mp\utility::weaponhasattachment(param_04, "barrelrange");
      var_0E = scripts\engine\utility::ter_op(var_0D, 2073600, 1440000);
      var_0F = scripts\engine\utility::ter_op(var_0D, 5760000, 4000000);
      if((distance2dsquared(param_00.origin, param_01.origin) < var_0E && param_02 >= 70) || distance2dsquared(param_00.origin, param_01.origin) < var_0F && param_02 >= 54 || distance2dsquared(param_00.origin, param_01.origin) >= var_0F && param_02 >= 42) {
        param_00.hitbychargedshot = param_01;
      }
    }

    if(isDefined(param_04) && issubstr(param_04, "iw7_ba50cal_mpl_overkill")) {
      if(param_02 >= 200) {
        param_00.hitbychargedshot = param_01;
      }
    }

    if(isDefined(param_0A) && param_0A &level.idflags_ricochet) {
      var_10 = scripts\mp\utility::getweaponbasedsmokegrenadecount(param_04);
      if(var_10 != "none" && !scripts\mp\utility::issuperweapon(var_10)) {
        param_02 = param_02 * 0.4;
      }
    }

    if(scripts\mp\utility::isfmjdamage(param_04, param_03)) {
      var_0C = var_0C * level.armorpiercingmod;
    }

    if(isplayer(param_01) && param_01 scripts\mp\utility::_hasperk("specialty_paint_pro") && !scripts\mp\utility::iskillstreakweapon(param_04)) {
      if(!param_00 scripts\mp\perks\_perkfunctions::ispainted()) {
        param_01 scripts\mp\missions::processchallenge("ch_bulletpaint");
      }

      param_00 thread scripts\mp\perks\_perkfunctions::setpainted(param_01);
    }

    if(isplayer(param_01) && param_01 scripts\mp\utility::_hasperk("specialty_bulletdamage") && param_00 scripts\mp\utility::_hasperk("specialty_armorvest")) {} else if(isplayer(param_01) && param_01 scripts\mp\utility::_hasperk("specialty_bulletdamage") || param_01 scripts\mp\utility::_hasperk("specialty_moredamage")) {
      var_0B = var_0B + param_02 * level.var_3245;
    } else if(param_00 scripts\mp\utility::_hasperk("specialty_armorvest")) {
      var_0B = var_0B - param_02 * level.var_21A3;
    } else if(param_00 scripts\mp\utility::_hasperk("specialty_headgear") && scripts\mp\utility::isheadshot(param_04, param_07, param_03, param_01) && !scripts\mp\utility::isfmjdamage(param_04, param_03)) {
      var_0B = var_0B - param_02 * level.var_8C74;
      param_00 notify("headgear_save", param_01, param_03, param_04);
    }

    if(param_00 scripts\mp\utility::isjuggernaut()) {
      if(level.hardcoremode && isDefined(param_04) && weaponclass(param_04) == "spread") {
        param_02 = min(param_02, 25) * var_0C;
        var_0B = min(param_02, 25) * var_0C;
      } else {
        param_02 = param_02 * var_0C;
        var_0B = var_0B * var_0C;
      }
    }

    if(param_01 scripts\mp\utility::_hasperk("passive_sonic") && param_01 issprintsliding()) {
      param_02 = param_02 * 1.25;
    }

    if(param_01 scripts\mp\utility::_hasperk("passive_below_the_belt")) {
      var_11 = undefined;
      switch (param_00.loadoutarchetype) {
        case "archetype_scout":
          var_11 = "torso_stabilizer";
          break;

        default:
          var_11 = "j_crotch";
          break;
      }

      if(isDefined(var_11)) {
        var_12 = param_00 gettagorigin(var_11);
        var_13 = distance(var_12, param_05);
        var_14 = 7.5;
        if(var_13 <= var_14) {
          param_02 = param_02 * 1.35;
          param_01 scripts\mp\utility::giveperk("specialty_moredamage");
        }
      }
    }

    if(scripts\mp\weapons::func_A008(param_04)) {
      param_00 thread scripts\mp\weapons::func_20E4();
    }

    if(isDefined(param_00.var_FC99)) {
      param_02 = 0;
    }
  } else if(isexplosivedamagemod(param_03)) {
    param_02 = scripts\mp\concussiongrenade::func_B92C(param_02, param_01, param_00, param_08, param_04);
    param_02 = scripts\mp\equipment\blackout_grenade::func_B92C(param_02, param_01, param_00, param_08, param_04);
    param_02 = scripts\mp\empgrenade::func_B92C(param_02, param_01, param_00, param_08, param_04);
    param_02 = scripts\mp\weapons::glprox_modifieddamage(param_02, param_01, param_00, param_08, param_04, param_03, param_05);
    if(param_04 == "proximity_explosive_mp" && isDefined(param_08.origin)) {
      var_15 = param_08.origin[2];
      var_16 = param_00.origin[2] + 24;
      if(var_15 < var_16 && !param_00 isonground()) {
        param_02 = param_02 * 0.8;
      } else if(var_15 >= var_16 && param_00 getstance() == "crouch") {
        param_02 = param_02 * 0.9;
      } else if(var_15 >= var_16 && param_00 getstance() == "prone") {
        param_02 = param_02 * 0.65;
      }
    }

    if(isplayer(param_01)) {
      if(param_01 != param_00 && param_01 isitemunlocked("specialty_paint", "perk") && param_01 scripts\mp\utility::_hasperk("specialty_paint") && !scripts\mp\utility::iskillstreakweapon(param_04)) {
        param_00 thread scripts\mp\perks\_perkfunctions::setpainted(param_01);
      }
    }

    if(isDefined(param_00.var_1177D) && param_00.var_1177D) {
      var_0B = var_0B + int(param_02 * level.var_1177E);
    }

    if(isplayer(param_01) && weaponinheritsperks(param_04) && param_01 scripts\mp\utility::_hasperk("specialty_explosivedamage") && param_00 scripts\mp\utility::_hasperk("specialty_blastshield")) {} else if(isplayer(param_01) && weaponinheritsperks(param_04) && !scripts\mp\utility::iskillstreakweapon(param_04) && param_01 scripts\mp\utility::_hasperk("specialty_explosivedamage")) {
      var_0B = var_0B + param_02 * level.var_69FE;
    } else if(param_00 scripts\mp\utility::_hasperk("specialty_blastshield") && !scripts\mp\utility::func_13C9A(param_04, param_07) && !scripts\mp\utility::func_9F7E(param_00, param_08, param_04, param_03) && !param_03 == "MOD_PROJECTILE") {
      var_17 = scripts\mp\weapons::glprox_modifiedblastshieldconst(level.var_2B68, param_04);
      var_17 = scripts\mp\equipment\ground_pound::groundpound_modifiedblastshieldconst(var_17, param_04);
      var_18 = int(param_02 * var_17);
      if(param_01 != param_00) {
        var_18 = clamp(var_18, 0, level.var_2B67);
      }

      var_0B = var_0B - param_02 - var_18;
    }

    if(param_00 scripts\mp\utility::isjuggernaut()) {
      var_0B = var_0B * var_0C;
      if(param_02 < 1000) {
        param_02 = param_02 * var_0C;
      }
    }

    if(isDefined(level.var_ABBF) && !scripts\mp\weapons::func_ABC1()) {
      param_02 = param_02 * level.allowgroundpound;
    }

    if(isDefined(param_00.var_FC99)) {
      param_02 = 0;
    }
  } else if(param_03 == "MOD_FALLING") {
    if(isDefined(param_00.var_115FC) && param_00.var_115FC) {
      param_02 = param_00.health + 100;
      param_01 thread scripts\mp\equipment\portal_grenade::func_468B(param_00, param_00.origin);
      param_00.var_115FC = 0;
      param_00.var_115FD = undefined;
      param_00.var_115FE = undefined;
    } else if(param_00 scripts\mp\utility::isjuggernaut()) {
      param_02 = param_02 * var_0C;
    } else if(scripts\mp\equipment\ground_pound::func_8651(param_00)) {
      param_02 = 0;
    } else {
      param_02 = int(max(33, param_02));
      if(param_02 >= param_00.health) {
        param_02 = int(max(0, param_00.health - 1));
      }
    }
  } else if(param_03 == "MOD_MELEE") {
    if(isDefined(param_08) && scripts\mp\utility::func_9EF0(param_08) && param_08.var_165A == "remote_c8") {
      param_02 = self.health - 1;
    } else if(param_00 scripts\mp\utility::isjuggernaut()) {
      param_02 = 20;
      var_0B = 0;
    } else if(param_04 == "iw7_reaperblade_mp") {
      param_00 thread scripts\mp\supers\super_reaper::func_A668();
    } else if(isDefined(param_00 scripts\mp\supers::getcurrentsuperref()) && param_00 scripts\mp\supers::getcurrentsuperref() == "super_reaper" && param_00 scripts\mp\supers::issuperinuse()) {
      param_02 = int(min(param_02, scripts\mp\supers\super_reaper::func_93D9()));
    } else if(scripts\mp\utility::func_9E7D(param_08, param_00, param_04, param_03)) {
      param_02 = param_00.health;
    } else if(isbehindmeleevictim(param_01, param_00) && isDefined(param_08) && !scripts\mp\utility::func_9EF0(param_08)) {
      param_02 = int(max(param_02, 100));
    } else {
      param_02 = 70;
    }
  } else if(param_03 == "MOD_IMPACT") {
    if(param_00 scripts\mp\utility::isjuggernaut()) {
      switch (param_04) {
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
          param_02 = 5;
          break;

        default:
          if(param_02 < 1000) {
            param_02 = 25;
          }
          break;
      }

      var_0B = 0;
    }

    if(isDefined(param_00.var_FC99)) {
      param_02 = 0;
    }

    if(isDefined(param_03) && param_03 == "MOD_IMPACT" && getweaponbasename(param_04) == "iw7_venomx_mp") {
      param_01 scripts\mp\missions::func_D991("ch_iw7_venomx_direct");
    }
  } else if(param_03 == "MOD_UNKNOWN" || param_03 == "MOD_MELEE_DOG") {
    if(isagent(param_01) && isDefined(param_01.agent_type) && param_01.agent_type == "dog" && param_00 scripts\mp\utility::isjuggernaut()) {
      param_00 shellshock("dog_bite", 2);
      param_02 = param_02 * var_0C;
    }
  }

  if(param_00 scripts\mp\utility::_hasperk("specialty_combathigh")) {
    if(isDefined(self.damageblockedtotal) && !level.teambased || isDefined(param_01) && isDefined(param_01.team) && param_00.team != param_01.team) {
      var_19 = param_02 + var_0B;
      var_1A = var_19 - var_19 / 3;
      self.damageblockedtotal = self.damageblockedtotal + var_1A;
      if(self.damageblockedtotal >= 101) {
        self notify("combathigh_survived");
        self.damageblockedtotal = undefined;
      }
    }

    if(param_04 != "throwingknife_mp" && param_04 != "throwingknifejugg_mp" && param_04 != "throwingknifeteleport_mp" && param_04 != "throwingreaper_mp" && !param_04 == "throwingknife_mp" && param_03 == "MOD_IMPACT") {
      switch (param_03) {
        case "MOD_FALLING":
        case "MOD_MELEE":
          break;

        default:
          param_02 = int(param_02 / 3);
          var_0B = int(var_0B / 3);
          break;
      }
    }
  }

  param_02 = scripts\mp\equipment\charge_mode::chargemode_modifieddamage(param_01, param_00, param_04, param_05, param_02);
  param_02 = scripts\mp\equipment\exploding_drone::explodingdrone_modifieddamage(param_01, param_00, param_04, param_08, param_02);
  param_02 = scripts\mp\supers\super_supertrophy::func_11280(param_01, param_00, param_04, param_02);
  param_02 = scripts\mp\equipment\ground_pound::func_8653(param_01, param_00, param_04, param_08, param_02);
  param_02 = scripts\mp\killstreaks\_venom::venommodifieddamage(param_01, param_00, param_04, param_08, param_02);
  var_1B = scripts\mp\playertrophy_system::playertrophy_modifieddamage(param_01, param_00, param_04, param_08, param_02);
  var_1B = scripts\mp\trophy_system::trophy_modifieddamage(param_01, param_00, param_04, param_02, var_0B);
  param_02 = var_1B[0];
  var_0B = var_1B[1];
  var_1C = 0;
  if(param_00 scripts\mp\heavyarmor::hasheavyarmor()) {
    var_1B = scripts\mp\heavyarmor::heavyarmormodifydamage(param_00, param_01, param_02, var_0B, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
    var_1C = var_1B[0] > 0;
    param_02 = var_1B[1];
    var_0B = var_1B[2];
  }

  var_1D = 0;
  if(scripts\mp\lightarmor::haslightarmor(param_00)) {
    var_1B = scripts\mp\lightarmor::lightarmor_modifydamage(param_00, param_01, param_02, var_0B, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
    var_1D = var_1B[0] > 0;
    param_02 = var_1B[1];
    var_0B = var_1B[2];
  }

  if(scripts\mp\utility::hashealthshield(param_00)) {
    param_02 = param_00 scripts\mp\utility::func_7EF7(param_02);
  }

  if(param_02 <= 1) {
    param_02 = int(ceil(clamp(param_02, 0, 1)));
  } else {
    param_02 = int(param_02 + var_0B);
  }

  if(isDefined(param_00.var_FC99)) {
    param_00.var_FC9A = param_02;
    param_02 = 0;
  } else if(param_07 == "shield" && param_00 scripts\mp\utility::_hasperk("specialty_rearguard") && param_03 == "MOD_EXPLOSIVE" || param_03 == "MOD_PROJECTILE_SPLASH" || param_03 == "MOD_PROJECTILE" || isDefined(param_08.weapon_name) && scripts\mp\utility::iskillstreakweapon(param_08.weapon_name)) {
    param_07 = "none";
  }

  if(isDefined(param_08) && isplayer(param_08) && isDefined(param_01) && isplayer(param_01) && param_01 != param_00) {
    thread scripts\mp\perks\_weaponpassives::updateweaponpassivesondamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
  }

  return [param_02, var_1D, var_1C, param_07];
}

func_B4CA(param_00, param_01, param_02) {
  var_03 = 0;
  if(isDefined(param_01) && isDefined(param_00) && isDefined(param_02)) {
    var_04 = getweaponbasename(param_02) == "iw7_mauler_mpr" || issubstr(param_02, "iw7_crdb_mp");
    var_05 = weaponclass(param_02) == "spread";
    if(!var_05 && !var_04) {
      return var_03;
    }

    var_06 = "" + gettime();
    var_07 = undefined;
    if(param_01 getweaponrankinfominxp() > 0.8 && param_01 scripts\mp\utility::_hasperk("passive_shotgun_focus")) {
      var_07 = 4;
    } else if(var_04) {
      var_07 = 4;
    } else if(param_01 isdualwielding()) {
      var_07 = 5;
    } else if(issubstr(param_02, "iw7_mod2187_mpl")) {
      var_07 = 4;
    } else if(issubstr(param_02, "iw7_longshot_mp")) {
      var_08 = param_01 getweaponrankinfominxp() > 0.95;
      var_09 = scripts\mp\weapons::isaltmodeweapon(param_02);
      if(!var_08 && !var_09) {
        var_07 = 1;
      } else if(var_08 && !var_09) {
        var_07 = 4;
      } else {
        var_07 = 3;
      }
    } else {
      var_07 = 3;
    }

    if(!isDefined(param_01.pelletdmg) || !isDefined(param_01.pelletdmg[var_06])) {
      param_01.pelletdmg = undefined;
      param_01.pelletdmg[var_06] = [];
    }

    if(!isDefined(param_01.pelletdmg[var_06][param_00.guid])) {
      param_01.pelletdmg[var_06][param_00.guid] = 1;
    } else if(param_01.pelletdmg[var_06][param_00.guid] + 1 > var_07) {
      var_03 = 1;
    } else {
      param_01.pelletdmg[var_06][param_00.guid]++;
    }
  }

  return var_03;
}

isbehindmeleevictim(param_00, param_01) {
  var_02 = vectornormalize((param_01.origin[0], param_01.origin[1], 0) - (param_00.origin[0], param_00.origin[1], 0));
  var_03 = anglesToForward((0, param_01.angles[1], 0));
  return vectordot(var_02, var_03) > 0.4;
}

func_9D68(param_00, param_01) {
  var_02 = vectornormalize((param_01.origin[0], param_01.origin[1], 0) - (param_00.origin[0], param_00.origin[1], 0));
  var_03 = anglesToForward((0, param_01.angles[1], 0));
  return vectordot(var_02, var_03) > 0.2;
}

killstreakdamagefilter(param_00, param_01, param_02, param_03, param_04) {
  if(param_03 == "hind_bomb_mp" || param_03 == "hind_missile_mp") {
    if(isDefined(param_00) && param_01 == param_00) {
      return 0;
    }
  }

  if(param_01 scripts\mp\utility::isspawnprotected()) {
    var_05 = int(max(param_01.health / 4, 1));
    if(param_02 >= var_05 && scripts\mp\utility::iskillstreakweapon(param_03) && param_04 != "MOD_MELEE") {
      param_02 = var_05;
    }
  }

  return param_02;
}

friendlyfire_ignoresdamageattacker(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D) {
  var_0E = 0;
  if(isDefined(param_06)) {
    switch (param_06) {
      case "none":
        if(isDefined(param_00) && scripts\mp\utility::isdronepackage(param_00)) {
          var_0E = 1;
        }
        break;

      case "iw7_minigun_c8_mp":
      case "iw7_chargeshot_c8_mp":
      case "iw7_c8offhandshield_mp":
        var_0F = undefined;
        if(isDefined(param_01) && scripts\mp\utility::func_9F22(param_01)) {
          var_0F = param_01;
        } else if(isDefined(param_00) && scripts\mp\utility::func_9F22(param_00)) {
          var_0F = param_00;
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

handlefriendlyfiredamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D) {
  if(isDefined(param_00) && !isplayer(param_00)) {
    if(!isDefined(param_01)) {
      if(isDefined(param_00.triggerportableradarping)) {
        param_01 = param_00.triggerportableradarping;
      }
    } else if(!isplayer(param_01)) {
      if(isDefined(param_00.triggerportableradarping)) {
        param_01 = param_00.triggerportableradarping;
      }
    }
  }

  if(level.hardcoremode) {
    if(param_01 scripts\mp\utility::_hasperk("passive_softcore") && scripts\engine\utility::isbulletdamage(param_05)) {
      return 0;
    }

    if(isDefined(param_04) && param_04 &level.idflags_ricochet && scripts\engine\utility::isbulletdamage(param_05)) {
      param_03 = int(param_03 * 0.2);
    }
  }

  if(level.friendlyfire != 0) {
    if(scripts\mp\utility::istrue(param_02.isdefusing) || scripts\mp\utility::istrue(param_02.iscapturingcrate)) {
      param_03 = int(param_03 * 0.5);
      if(param_03 < 1) {
        param_03 = 1;
      }

      param_01.lastdamagewasfromenemy = 0;
      damageattacker(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D);
      return 0;
    }
  }

  if(level.friendlyfire == 0 || !isplayer(param_01) && level.friendlyfire != 1 || param_06 == "bomb_site_mp") {
    if(param_06 == "artillery_mp" || param_06 == "stealth_bomb_mp") {
      param_02 damageshellshockandrumble(param_00, param_06, param_05, param_03, param_04, param_01);
    }

    return 0;
  } else if(level.friendlyfire == 1) {
    if(param_03 < 1) {
      param_03 = 1;
    }

    if(param_02 scripts\mp\utility::isjuggernaut()) {
      var_0E = func_3696(param_02, param_01, param_03, param_05, param_06, param_07, param_08, param_09, param_00, 0, param_04);
      param_03 = var_0E[0];
      var_0F = var_0E[1];
      var_10 = var_0E[2];
      param_09 = var_0E[3];
    }

    param_02.lastdamagewasfromenemy = 0;
    param_02 finishplayerdamagewrapper(param_00, param_01, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D);
    param_01 handledamagefeedback(param_00, param_01, param_02, param_03, param_05, param_06, param_09, param_04, 0, 0);
    return 0;
  } else if(level.friendlyfire == 2) {
    param_03 = int(param_03 * 0.5);
    if(param_03 < 1) {
      param_03 = 1;
    }

    param_01.lastdamagewasfromenemy = 0;
    if(!friendlyfire_ignoresdamageattacker(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D)) {
      damageattacker(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D);
    }

    return 0;
  } else if(level.friendlyfire == 3) {
    param_03 = int(param_03 * 0.5);
    if(param_03 < 1) {
      param_03 = 1;
    }

    param_02.lastdamagewasfromenemy = 0;
    param_01.lastdamagewasfromenemy = 0;
    param_02 finishplayerdamagewrapper(param_00, param_01, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D);
    if(!friendlyfire_ignoresdamageattacker(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D)) {
      damageattacker(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D);
    }

    param_01 handledamagefeedback(param_00, param_01, param_02, param_03, param_05, param_06, param_09, param_04, 0, 0);
    return 0;
  } else if(level.friendlyfire == 4) {
    var_11 = param_01.pers["teamkills"] >= level.maxallowedteamkills;
    if(var_11) {
      if(!friendlyfire_ignoresdamageattacker(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D)) {
        param_03 = int(param_03 * 0.5);
        if(param_03 < 1) {
          param_03 = 1;
        }

        param_01.lastdamagewasfromenemy = 0;
        damageattacker(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D);
      }

      return 0;
    }
  }

  return param_03;
}

damageattacker(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D) {
  if(scripts\mp\utility::isreallyalive(param_01)) {
    param_01.friendlydamage = 1;
    param_01 finishplayerdamagewrapper(param_00, param_01, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D);
    param_01.friendlydamage = undefined;
  }
}

modifydamagegeneral(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(param_05 == "MOD_EXPLOSIVE_BULLET" && param_03 != 1) {
    param_03 = param_03 * getdvarfloat("scr_explBulletMod");
    param_03 = int(param_03);
  }

  if(isDefined(level.modifyplayerdamage)) {
    param_03 = [[level.modifyplayerdamage]](param_02, param_01, param_03, param_05, param_06, param_07, param_08, param_09);
  }

  param_03 = int(param_03 * param_02 scripts\mp\utility::getdamagemodifiertotal(param_00, param_01, param_02, param_03, param_05, param_06, param_09));
  if(scripts\mp\utility::isheadshot(param_06, param_09, param_05, param_01)) {
    param_05 = "MOD_HEAD_SHOT";
  }

  if(scripts\mp\tweakables::gettweakablevalue("game", "onlyheadshots")) {
    if(param_05 == "MOD_HEAD_SHOT") {
      if(param_02 scripts\mp\utility::isjuggernaut()) {
        param_03 = 75;
      } else {
        param_03 = 150;
      }
    }
  }

  return param_03;
}

handleriotshieldhits(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(param_08 != "shield") {
    return param_03;
  }

  if(param_01 scripts\mp\utility::_hasperk("specialty_rearguard")) {
    var_0A = scripts\engine\utility::ter_op(isDefined(param_00), param_00, param_02);
    if(isDefined(var_0A)) {
      if(isplayer(var_0A) || scripts\mp\utility::func_9EF0(var_0A)) {
        if(func_9D68(var_0A, param_01)) {
          if(scripts\engine\utility::isbulletdamage(param_04) || param_04 == "MOD_EXPLOSIVE_BULLET") {
            param_02 scripts\mp\damagefeedback::updatedamagefeedback("hitlightarmor");
          }
        }
      } else if((isDefined(param_05) && param_05 == "destructible_car" || scripts\mp\utility::iskillstreakweapon(param_05)) || isexplosivedamagemod(param_04) || param_04 == "MOD_PROJECTILE") {
        param_01.var_FC96 = param_01.var_FC96 + param_03;
        if(func_9D68(var_0A, param_01) && !param_01 scripts\mp\utility::_hasperk("specialty_blastshield")) {
          return param_03 * 3;
        } else {
          return param_03;
        }
      }
    }
  }

  var_0B = scripts\mp\utility::istrue(param_01.var_9331);
  if(isDefined(param_01.triggerportableradarping)) {
    param_01 = param_01.triggerportableradarping;
    if(param_02 == param_01) {
      return "hit shield";
    }
  }

  if(param_04 == "MOD_PISTOL_BULLET" || param_04 == "MOD_RIFLE_BULLET" || param_04 == "MOD_EXPLOSIVE_BULLET") {
    if(isplayer(param_02)) {
      param_02.var_A93F = param_01;
      param_02.var_A940 = gettime();
    }

    param_01 notify("shield_blocked");
    if(scripts\mp\utility::isenvironmentweapon(param_05)) {
      var_0C = 25;
    } else if(param_02 scripts\mp\utility::_hasperk("specialty_rearguard") && func_9D68(param_03, param_02)) {
      var_0C = param_04;
    } else {
      var_0D = func_3696(param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_01, 0, var_0B);
      var_0C = var_0D[0];
      var_0E = var_0D[1];
      var_0F = var_0D[2];
      param_08 = var_0D[3];
    }

    param_01.var_FC96 = param_01.var_FC96 + var_0C;
    param_01.var_FC97 = param_01.var_FC97 + var_0C;
    if(isplayer(param_02) && isDefined(param_01.rearguardattackers)) {
      var_10 = param_02 getentitynumber();
      if(!isDefined(param_01.rearguardattackers[var_10])) {
        param_01.rearguardattackers[var_10] = var_0C;
      } else {
        param_01.rearguardattackers[var_10] = param_01.rearguardattackers[var_10] + var_0C;
      }
    }

    if(var_0B) {
      return "hit shield";
    }

    if(!scripts\mp\utility::isenvironmentweapon(param_05) || scripts\engine\utility::cointoss()) {
      param_01.var_FC95++;
    }

    if(param_01.var_FC95 >= level.riotshieldxpbullets) {
      var_11 = 1;
      if(self.recentshieldxp > 4) {
        var_11 = 1 / self.recentshieldxp;
      }

      var_12 = scripts\mp\rank::getscoreinfovalue("shield_damage");
      var_13 = param_01 getcurrentweapon();
      param_01 thread scripts\mp\utility::giveunifiedpoints("shield_damage", var_13, var_12 * var_11);
      param_01 thread giverecentshieldxp();
      param_01 thread scripts\mp\missions::processchallenge("shield_damage", param_01.var_FC97);
      param_01 thread scripts\mp\missions::processchallenge("shield_bullet_hits", param_01.var_FC95);
      param_01.var_FC97 = 0;
      param_01.var_FC95 = 0;
    }
  }

  var_14 = isDefined(param_00) && isDefined(param_00.stuckenemyentity) && param_00.stuckenemyentity == param_01;
  if(param_09 &level.idflags_shield_explosive_impact && !param_01 scripts\mp\utility::_hasperk("specialty_rearguard")) {
    param_01 thread scripts\mp\missions::processchallenge("shield_explosive_hits", 1);
    param_08 = "none";
    if(!param_09 &level.idflags_shield_explosive_impact_huge) {
      param_03 = 0;
    }
  } else if(param_09 &level.idflags_shield_explosive_splash) {
    if(scripts\mp\utility::func_9F7F(param_01, param_00, param_05, param_04)) {
      param_01.forcehitlocation = "none";
      param_03 = param_01.maxhealth;
    }

    if(!param_01 scripts\mp\utility::_hasperk("specialty_rearguard")) {
      param_01 thread scripts\mp\missions::processchallenge("shield_explosive_hits", 1);
      param_08 = "none";
    }
  } else {
    return "hit shield";
  }

  if(param_04 == "MOD_MELEE" && scripts\mp\weapons::isriotshield(param_05)) {
    var_15 = 0;
    param_01 _meth_83B2(0);
  }

  return param_03;
}

filterdamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(param_05 == "iw7_reaperblade_mp") {
    var_07 = gettime();
    if(isDefined(param_02.var_A9DA)) {
      if(param_02.var_A9DA + 200 >= var_07) {
        return "invalidVictim";
      }
    }

    param_02.var_A9DA = var_07;
  }

  if(!param_03) {
    return "!iDamage";
  }

  if(isDefined(level.hostmigrationtimer)) {
    return "level.hostMigrationTimer";
  }

  param_01 = scripts\mp\utility::_validateattacker(param_01);
  if(!isDefined(param_01) && param_04 != "MOD_FALLING") {
    return "invalid attacker";
  }

  param_02 = scripts\mp\utility::func_143B(param_02);
  if(!isDefined(param_02)) {
    return "invalidVictim";
  }

  if(game["state"] == "postgame") {
    return "game[state] == postgame";
  }

  if(param_02.sessionteam == "spectator") {
    return "victim.sessionteam == spectator";
  }

  if(isDefined(param_02.var_389E) && !param_02.var_389E) {
    return "!victim.canDoCombat";
  }

  if(isDefined(param_01) && isplayer(param_01) && isDefined(param_01.var_389E) && !param_01.var_389E) {
    return "!eAttacker.canDoCombat";
  }

  var_08 = isDefined(param_01) && isDefined(param_00) && isDefined(param_02) && isplayer(param_01) && param_01 == param_00 && param_01 == param_02 && !isDefined(param_00.poison);
  if(var_08) {
    return "attackerIsInflictorVictim";
  }

  if(scripts\mp\tweakables::gettweakablevalue("game", "onlyheadshots")) {
    if(param_06 != "head") {
      if(param_04 == "MOD_PISTOL_BULLET" || param_04 == "MOD_RIFLE_BULLET" || param_04 == "MOD_EXPLOSIVE_BULLET") {
        return "getTweakableValue(game, onlyheadshots)";
      }
    }
  }

  var_09 = isDefined(param_01) && !isDefined(param_01.gunner) && param_01.classname == "script_vehicle" || param_01.classname == "misc_turret" || param_01.classname == "script_model";
  if(!level.teambased && var_09 && isDefined(param_01.triggerportableradarping) && param_01.triggerportableradarping == param_02) {
    if(param_04 == "MOD_CRUSH") {
      param_02 scripts\mp\utility::_suicide();
    }

    return "ffa suicide";
  }

  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(param_02)) {
    if(!isDefined(param_00)) {
      return "outOfPhase";
    }

    if(!scripts\mp\equipment\phase_shift::isentityphaseshifted(param_00)) {
      if(!isDefined(param_00.classname) || param_00.classname != "trigger_hurt") {
        return "outOfPhase";
      }

      return;
    }

    return;
  }

  if(isDefined(param_00) && !scripts\mp\equipment\phase_shift::areentitiesinphase(param_00, param_02)) {
    return "outOfPhase";
  }
}

logattacker(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(isDefined(param_01) && isplayer(param_01)) {
    addattacker(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
  }

  if(isDefined(param_01) && !isplayer(param_01) && isDefined(param_01.triggerportableradarping) && !isDefined(param_01.scrambled) || !param_01.scrambled) {
    addattacker(param_00, param_01.triggerportableradarping, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
  } else if(isDefined(param_01) && !isplayer(param_01) && isDefined(param_01.secondowner) && isDefined(param_01.scrambled) && param_01.scrambled) {
    addattacker(param_00, param_01.secondowner, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
  }

  if(isDefined(param_02) && isDefined(param_02.triggerportableradarping)) {
    var_0A = param_02.triggerportableradarping.team != param_00.team || level.friendlyfire == 1;
    if(var_0A && !isDefined(self.attackerdata[param_02.triggerportableradarping.guid])) {
      addattacker(param_00, param_02.triggerportableradarping, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
    }
  }

  if(isDefined(param_01)) {
    level.lastlegitimateattacker = param_01;
  }

  if(isDefined(param_01) && isplayer(param_01) && isDefined(param_03)) {
    param_01 thread scripts\mp\weapons::func_3E1E(param_03, param_00);
  }

  if(isDefined(param_01) && isplayer(param_01) && isDefined(param_03) && param_01 != param_00) {
    param_01 thread scripts\mp\events::damagedplayer(self, param_04, param_03);
    param_00.attackerposition = param_01.origin;
    return;
  }

  param_00.attackerposition = undefined;
}

logattackerkillstreak(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(isDefined(param_02) && isplayer(param_02)) {
    addattackerkillstreak(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
  }

  if(isDefined(param_02) && !isplayer(param_02) && isDefined(param_02.triggerportableradarping) && !isDefined(param_02.scrambled) || !param_02.scrambled) {
    param_02 = param_02.triggerportableradarping;
    addattackerkillstreak(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
  } else if(isDefined(param_02) && !isplayer(param_02) && isDefined(param_02.secondowner) && isDefined(param_02.scrambled) && param_02.scrambled) {
    param_02 = param_02.secondowner;
    addattackerkillstreak(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
  }

  if(isDefined(param_02)) {
    level.lastlegitimateattacker = param_02;
  }

  if(isDefined(param_02) && isplayer(param_02) && isDefined(param_0A) && param_02 != param_00) {
    param_00.attackerposition = param_02.origin;
    return;
  }

  param_00.attackerposition = undefined;
}

loggrenadedata(param_00, param_01, param_02, param_03, param_04, param_05) {
  if((issubstr(param_04, "MOD_EXPLOSIVE") || issubstr(param_04, "MOD_PROJECTILE")) && isDefined(param_00) && isDefined(param_01)) {
    param_02.explosiveinfo = [];
    param_02.explosiveinfo["damageTime"] = gettime();
    param_02.explosiveinfo["damageId"] = param_00 getentitynumber();
    param_02.explosiveinfo["returnToSender"] = 0;
    param_02.explosiveinfo["counterKill"] = 0;
    param_02.explosiveinfo["chainKill"] = 0;
    param_02.explosiveinfo["cookedKill"] = 0;
    param_02.explosiveinfo["throwbackKill"] = 0;
    param_02.explosiveinfo["suicideGrenadeKill"] = 0;
    param_02.explosiveinfo["weapon"] = param_05;
    var_06 = issubstr(param_05, "frag_");
    if(param_01 != param_02) {
      if((issubstr(param_05, "c4_") || issubstr(param_05, "proximity_explosive_") || issubstr(param_05, "claymore_")) && isDefined(param_00.triggerportableradarping)) {
        param_02.explosiveinfo["returnToSender"] = param_00.triggerportableradarping == param_02;
        param_02.explosiveinfo["counterKill"] = isDefined(param_00.wasdamaged);
        param_02.explosiveinfo["chainKill"] = isDefined(param_00.waschained);
        param_02.explosiveinfo["bulletPenetrationKill"] = isDefined(param_00.wasdamagedfrombulletpenetration);
        param_02.explosiveinfo["cookedKill"] = 0;
      }

      if(isDefined(param_01.lastgrenadesuicidetime) && param_01.lastgrenadesuicidetime >= gettime() - 50 && var_06) {
        param_02.explosiveinfo["suicideGrenadeKill"] = 1;
      }
    }

    if(var_06) {
      param_02.explosiveinfo["cookedKill"] = isDefined(param_00.iscooked);
      param_02.explosiveinfo["throwbackKill"] = isDefined(param_00.threwback);
    }

    param_02.explosiveinfo["stickKill"] = isDefined(param_00.isstuck) && param_00.isstuck == "enemy";
    param_02.explosiveinfo["stickFriendlyKill"] = isDefined(param_00.isstuck) && param_00.isstuck == "friendly";
    if(isplayer(param_01) && param_01 != self && level.gametype != "aliens") {
      updateinflictorstat(param_00, param_01, param_05);
    }
  }

  if(issubstr(param_04, "MOD_IMPACT") && param_05 == "iw6_rgm_mp") {
    if(isplayer(param_01) && param_01 != self && level.gametype != "aliens") {
      updateinflictorstat(param_00, param_01, param_05);
    }
  }
}

handledamagefeedback(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  var_0A = isDefined(param_01) && !isDefined(param_01.gunner) && param_01.classname == "script_vehicle" || param_01.classname == "misc_turret" || param_01.classname == "script_model";
  if(var_0A && isDefined(param_01.gunner)) {
    var_0B = param_01.gunner;
  } else {
    var_0B = param_02;
  }

  var_0C = "standard";
  if(isDefined(var_0B) && var_0B != param_02 && param_03 + param_08 + param_09 > 0 && !isDefined(param_06) || param_06 != "shield") {
    var_0D = !scripts\mp\utility::isreallyalive(param_02) || isagent(param_02) && param_03 >= param_02.health;
    if(param_02 scripts\mp\heavyarmor::hasheavyarmor() || param_02 scripts\mp\heavyarmor::hasheavyarmorinvulnerability()) {
      var_0C = "hitjuggernaut";
    } else if(param_07 &level.idflags_stun) {
      var_0C = "stun";
    } else if(isexplosivedamagemod(param_04) && isDefined(param_02.var_1177D) && param_02.var_1177D) {
      var_0C = "thermobaric_debuff";
    } else if(scripts\mp\utility::func_9F93(param_05, param_04) && param_02 scripts\mp\utility::_hasperk("specialty_stun_resistance")) {
      var_0C = "hittacresist";
    } else if(isexplosivedamagemod(param_04) && param_02 scripts\mp\utility::_hasperk("specialty_blastshield") && !scripts\mp\utility::func_13C9A(param_05, param_06) && !scripts\mp\utility::func_9F7E(param_02, param_00, param_05, param_04)) {
      var_0C = "hitblastshield";
    } else if(param_02 scripts\mp\utility::_hasperk("specialty_combathigh")) {
      var_0C = "hitendgame";
    } else if(scripts\mp\utility::hashealthshield(param_02)) {
      var_0C = "hitlightarmor";
    } else if(param_08 > 0) {
      var_0C = "hitlightarmor";
    } else if(param_02 scripts\mp\utility::isjuggernaut()) {
      var_0C = "hitjuggernaut";
    } else if(param_02 scripts\mp\utility::_hasperk("specialty_moreHealth")) {
      var_0C = "hitmorehealth";
    } else if(var_0B scripts\mp\utility::_hasperk("specialty_moredamage")) {
      var_0C = "hitcritical";
      var_0B scripts\mp\utility::removeperk("specialty_moredamage");
    } else if(param_02 scripts\mp\utility::getdamagemodifiertotal(param_00, param_01, param_02, param_03, param_04, param_05, param_06) < 0.95) {
      var_0C = "hitlowdamage";
    } else if(param_02 scripts\mp\utility::isspawnprotected() && scripts\mp\utility::iskillstreakweapon(param_05)) {
      var_0C = "hitspawnprotection";
    } else if(!func_100C1(param_05)) {
      var_0C = "none";
    }

    var_0E = "high_damage";
    if(param_03 < 20) {
      var_0E = "low_damage";
    }

    var_0F = weaponclass(param_05) == "spread" || getweaponbasename(param_05) == "iw7_mauler_mpr" || issubstr(param_05, "iw7_crdb_mp");
    var_10 = !var_0F && scripts\mp\utility::isheadshot(param_05, param_06, param_04, param_01);
    var_11 = 1;
    var_12 = param_04 == "MOD_MELEE";
    var_13 = "" + gettime();
    if(!var_12 && var_0F && isDefined(var_0B.pelletdmg) && isDefined(var_0B.pelletdmg[var_13]) && isDefined(var_0B.pelletdmg[var_13][param_02.guid]) && var_0B.pelletdmg[var_13][param_02.guid] > 1) {
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

lethalequipmentdamagemod(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(isDefined(param_00) && isDefined(param_00.damagedby)) {
    param_01 = param_00.damagedby;
  }

  if(scripts\mp\utility::func_9F7F(param_02, param_00, param_06, param_05)) {
    param_03 = param_02.maxhealth;
  }

  if(isDefined(param_05) && param_05 != "MOD_IMPACT") {
    if(param_02 != param_01 && isDefined(param_00) && param_00.classname == "grenade" && param_02.lastspawntime + 3500 > gettime() && isDefined(param_02.lastspawnpoint) && distance(param_00.origin, param_02.lastspawnpoint.origin) < 500) {
      param_03 = 0;
    }
  }

  if(param_03 < param_02.health) {
    param_02 notify("survived_explosion", param_01);
  }

  loggrenadedata(param_00, param_01, param_02, param_03, param_05, param_06);
  return param_03;
}

func_1177F() {
  self endon("disconnect");
  level endon("game_ended");
  var_00 = gettime() + 5000;
  wait(0.05);
  self.var_1177D = 1;
  for(;;) {
    if(self.health == self.maxhealth) {
      self.var_1177D = 0;
      return;
    }

    if(gettime() >= var_00) {
      self.var_1177D = 0;
      return;
    }

    wait(0.05);
  }
}

playerkilled_internal(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = getweaponbasename(param_06);
  if(var_0C == "iw7_spas_mpr_focus") {
    var_0C = "iw7_spas_mpr";
  } else if(var_0C == "iw7_erad_mp_jump_spread") {
    var_0C = "iw7_erad_mp";
  }

  if(isDefined(var_0C)) {}

  scripts\mp\utility::printgameaction("death", param_02);
  param_02 endon("spawned");
  param_02 notify("killed_player");
  param_02 showuidamageflash();
  var_0D = 0;
  self setblurforplayer(0, 0);
  scripts\mp\outline::outlinedisableinternalall(self);
  param_02.var_1519 = 0;
  param_02.perkoutlined = 0;
  param_02.var_4F = param_01;
  if(scripts\mp\utility::gamehasneutralcrateowner(level.gametype)) {
    if(param_02 != param_01 && param_05 == "MOD_CRUSH") {
      param_00 = param_02;
      param_01 = param_02;
      param_05 = "MOD_SUICIDE";
      param_06 = "none";
      param_08 = "none";
      param_02.attackers = [];
    }
  }

  if(param_06 == "none") {
    if(isDefined(param_00) && isDefined(param_00.var_28AF)) {
      param_06 = param_00.var_28AF;
    }
  }

  if(isDefined(param_00) && !isplayer(param_00)) {
    if(!isDefined(param_01)) {
      if(isDefined(param_00.triggerportableradarping)) {
        param_01 = param_00.triggerportableradarping;
      }
    } else if(!isplayer(param_01)) {
      if(isDefined(param_00.triggerportableradarping)) {
        param_01 = param_00.triggerportableradarping;
      }
    }
  }

  param_01 = scripts\mp\utility::_validateattacker(param_01);
  if(isDefined(param_01)) {
    param_01.assistedsuicide = undefined;
  }

  if(isDefined(param_02.hasriotshieldequipped) && param_02.hasriotshieldequipped) {
    param_02 launchshield(param_03, param_05);
  }

  param_02 scripts\mp\utility::riotshield_clear();
  scripts\mp\weapons::recordtogglescopestates();
  if(!param_0B) {
    if(isDefined(param_02.endgame)) {
      scripts\mp\utility::restorebasevisionset(2);
    } else {
      scripts\mp\utility::restorebasevisionset(0);
      param_02 thermalvisionoff();
    }
  } else {
    param_02.fauxdeath = 1;
    self notify("death");
  }

  if(game["state"] == "postgame") {
    return;
  }

  scripts\mp\perks\_perks::updateactiveperks(param_00, param_01, param_02, param_03, param_05, param_06, param_08, param_07);
  var_0E = 0;
  if(!isplayer(param_00) && isDefined(param_00.primaryweapon)) {
    var_0F = param_00.primaryweapon;
  } else if(isDefined(param_02) && isplayer(param_02) && param_02 getcurrentprimaryweapon() != "none") {
    var_0F = param_02 getcurrentprimaryweapon();
  } else if(issubstr(param_07, "alt_")) {
    var_0F = getsubstr(param_07, 4, param_07.size);
  } else {
    var_0F = undefined;
  }

  if(isDefined(param_02.uselaststandparams) || isDefined(param_02.laststandparams) && param_05 == "MOD_SUICIDE") {
    param_02 ensurelaststandparamsvalidity();
    param_02.uselaststandparams = undefined;
    param_00 = param_02.laststandparams.einflictor;
    param_01 = param_02.laststandparams.var_4F;
    param_03 = param_02.laststandparams.idamage;
    param_05 = param_02.laststandparams.smeansofdeath;
    param_06 = param_02.laststandparams.sweapon;
    var_0F = param_02.laststandparams.sprimaryweapon;
    param_07 = param_02.laststandparams.vdir;
    param_08 = param_02.laststandparams.shitloc;
    var_0E = gettime() - param_02.laststandparams.laststandstarttime / 1000;
    param_02.laststandparams = undefined;
    param_01 = scripts\mp\utility::_validateattacker(param_01);
  }

  if(!isDefined(param_01) || param_01.classname == "trigger_hurt" || param_01.classname == "worldspawn" || param_01 == param_02) {
    var_10 = undefined;
    if(isDefined(self.attackers) && self.attackers.size > 0) {
      foreach(var_12 in self.attackers) {
        if(!isDefined(scripts\mp\utility::_validateattacker(var_12))) {
          continue;
        }

        if(!isDefined(param_02.attackerdata[var_12.guid].var_DA)) {
          continue;
        }

        if(var_12 == param_02 || level.teambased && var_12.team == param_02.team) {
          continue;
        }

        if(param_02.attackerdata[var_12.guid].lasttimedamaged + 2500 < gettime() && param_01 != param_02 && isDefined(param_02.setlasermaterial) && param_02.setlasermaterial) {
          continue;
        }

        if(param_02.attackerdata[var_12.guid].var_DA > 1 && !isDefined(var_10)) {
          var_10 = var_12;
          continue;
        }

        if(isDefined(var_10) && param_02.attackerdata[var_12.guid].var_DA > param_02.attackerdata[var_10.guid].var_DA) {
          var_10 = var_12;
        }
      }
    }

    if(!isDefined(var_10)) {
      if(isDefined(param_02.debuffedbyplayers) && param_02.debuffedbyplayers.size > 0) {
        var_14 = ["chargemode_mp", "cryo_mine_mp", "concussion_grenade_mp", "super_trophy_mp", "blackout_grenade_mp", "blackhole_grenade_mp", "power_spider_grenade_mp", "emp_grenade_mp"];
        foreach(var_16 in var_14) {
          var_17 = scripts\mp\gamescore::getdebuffattackersbyweapon(param_02, var_16);
          if(isDefined(var_17) && var_17.size > 0) {
            for(var_18 = var_17.size - 1; var_18 >= 0; var_18--) {
              var_19 = var_17[var_18];
              if(!isDefined(scripts\mp\utility::_validateattacker(var_19))) {
                continue;
              }

              if(!scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(var_19, param_02))) {
                continue;
              }

              var_10 = var_19;
              if(!isDefined(param_02.attackerdata) || !isDefined(param_02.attackerdata[var_10.guid])) {
                addattacker(param_02, var_10, undefined, var_16, 0, undefined, undefined, undefined, undefined, "MOD_EXPLOSIVE");
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
      param_01 = var_10;
      param_01.assistedsuicide = 1;
      param_06 = param_02.attackerdata[var_10.guid].var_394;
      param_07 = param_02.attackerdata[var_10.guid].vdir;
      param_08 = param_02.attackerdata[var_10.guid].shitloc;
      param_09 = param_02.attackerdata[var_10.guid].box;
      param_05 = param_02.attackerdata[var_10.guid].smeansofdeath;
      param_03 = param_02.attackerdata[var_10.guid].var_DA;
      var_0F = param_02.attackerdata[var_10.guid].sprimaryweapon;
      param_00 = param_01;
      var_0D = 1;
    }
  }

  scripts\mp\equipment\wrist_rocket::wristrocketcooksuicideexplodecheck(param_00, param_01, param_02, param_05, param_06);
  if(scripts\mp\utility::isheadshot(param_06, param_08, param_05, param_01)) {
    param_05 = "MOD_HEAD_SHOT";
  } else if(!isDefined(param_02.nuked)) {
    if(isDefined(level.var_4C4A)) {
      [
        [level.var_4C4A]
      ](param_02, param_05, param_00);
    } else if(param_05 != "MOD_MELEE") {
      param_02 scripts\mp\utility::playdeathsound();
    }
  }

  if(isDefined(level.var_4C47)) {
    [[level.var_4C47]](param_02, param_05, param_00);
  }

  if(isDefined(param_01) && isDefined(param_02) && param_05 == "MOD_MELEE") {
    var_1B = "defaultweapon_melee";
    if(getweaponbasename(param_06) == "iw7_nunchucks" || getweaponbasename(param_06) == "iw7_katana") {
      var_1B = "heavy_2s";
    }

    param_02 playrumbleonentity(var_1B);
    param_01 playrumbleonentity(var_1B);
  }

  var_1C = isfriendlyfire(param_02, param_01);
  if(isDefined(param_01)) {
    if(param_01.var_9F == "script_vehicle" && isDefined(param_01.triggerportableradarping)) {
      param_01 = param_01.triggerportableradarping;
    }

    if(param_01.var_9F == "misc_turret" && isDefined(param_01.triggerportableradarping)) {
      if(isDefined(param_01.vehicle)) {
        param_01.vehicle notify("killedPlayer", param_02);
      }

      param_01 = param_01.triggerportableradarping;
    }

    if(isagent(param_01)) {
      if(isDefined(param_01.agent_type)) {
        if(param_01.agent_type == "dog") {
          param_06 = "guard_dog_mp";
        } else if(param_01.agent_type == "squadmate") {
          param_06 = "agent_support_mp";
        }
      }

      if(isDefined(param_01.triggerportableradarping)) {
        param_01 = param_01.triggerportableradarping;
      }
    }

    if(param_01.var_9F == "script_model" && isDefined(param_01.triggerportableradarping)) {
      param_01 = param_01.triggerportableradarping;
      if(!isfriendlyfire(param_02, param_01) && param_01 != param_02) {
        param_01 notify("crushed_enemy");
      }
    }
  }

  if(param_05 != "MOD_SUICIDE" && scripts\mp\utility::isaigameparticipant(param_02) || scripts\mp\utility::isaigameparticipant(param_01) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["get_attacker_ent"])) {
    var_1D = [[level.bot_funcs["get_attacker_ent"]]](param_01, param_00);
    if(isDefined(var_1D)) {
      if(scripts\mp\utility::isaigameparticipant(param_02)) {
        param_02 botmemoryevent("death", param_06, var_1D.origin, param_02.origin, var_1D);
      }

      if(scripts\mp\utility::isaigameparticipant(param_01)) {
        var_1E = 1;
        if((var_1D.classname == "script_vehicle" && isDefined(var_1D.helitype)) || var_1D.classname == "rocket" || var_1D.classname == "misc_turret") {
          var_1E = 0;
        }

        if(var_1E) {
          param_01 botmemoryevent("kill", param_06, var_1D.origin, param_02.origin, param_02);
        }
      }
    }
  }

  if(scripts\mp\utility::func_9EF0(param_02)) {
    param_02.playerproxyagent scripts\mp\weapons::dropscavengerfordeath(param_01);
    param_02.playerproxyagent[[level.weapondropfunction]](param_01, param_05);
  } else {
    param_02 scripts\mp\weapons::dropscavengerfordeath(param_01, param_05);
    param_02[[level.weapondropfunction]](param_01, param_05);
  }

  if(!param_0B) {
    param_02 scripts\mp\utility::updatesessionstate("dead");
    if(isplayer(param_01) && param_01 != param_02) {
      param_02 setclientomnvar("ui_killcam_killedby_id", param_01 getentitynumber());
    }
  }

  var_1F = isDefined(param_02.fauxdeath) && param_02.fauxdeath && isDefined(param_02.switching_teams) && param_02.switching_teams;
  if(!var_1F) {
    param_02 scripts\mp\playerlogic::removefromalivecount();
  }

  if(!isDefined(param_02.switching_teams)) {
    var_20 = param_02;
    if(isDefined(param_02.commanding_bot)) {
      var_20 = param_02.commanding_bot;
    }

    if(!isDefined(level.ignorescoring) && !var_1C) {
      var_20 scripts\mp\utility::incperstat("deaths", 1, isDefined(level.ignorekdrstats));
      var_20.var_E9 = var_20 scripts\mp\utility::getpersstat("deaths");
      var_20 scripts\mp\utility::updatepersratio("kdRatio", "kills", "deaths", level.ignorekdrstats);
      var_20 scripts\mp\persistence::statsetchild("round", "deaths", var_20.var_E9, level.ignorekdrstats);
    }
  }

  if(isDefined(param_01) && isplayer(param_01)) {
    param_01 checkkillsteal(param_02);
  }

  var_21 = param_06;
  var_22 = param_05;
  if(scripts\mp\utility::iskillstreakweapon(var_21) || isDefined(param_00.streakinfo)) {
    var_23 = undefined;
    if(var_21 == "minijackal_assault_mp") {
      var_23 = 10042;
    } else if(isDefined(param_00.streakinfo)) {
      if(isDefined(param_00.streakinfo.variantid) && param_00.streakinfo.variantid > 0) {
        var_23 = param_00.streakinfo.variantid;
      }
    }

    if(isDefined(var_23)) {
      var_24 = level.var_110EC.rarity[var_23];
      var_25 = level.var_110EC.var_E76D[var_23];
      if(var_21 != "none") {
        var_21 = param_06 + "+loot" + var_25;
        var_22 = "MOD_SCORESTREAK";
      }

      param_02.killsteakvariantattackerinfo = spawnStruct();
      param_02.killsteakvariantattackerinfo.id = var_23;
      param_02.killsteakvariantattackerinfo.rarity = var_24;
    }
  }

  if(isDefined(var_21) && scripts\mp\utility::getweaponbasedsmokegrenadecount(var_21) == "iw7_axe_mp" && isDefined(param_01) && param_01 getweaponammoclip(var_21) > 0) {
    var_22 = "MOD_IMPACT";
  }

  obituary(param_02, param_01, var_21, var_22);
  var_26 = 0;
  var_27 = 1;
  param_02 scripts\mp\clientmatchdata::logplayerdeath(param_01);
  var_28 = param_02.matchdatalifeindex;
  if(!isDefined(var_28)) {
    var_28 = level.maxlives - 1;
  }

  param_02 scripts\mp\matchdata::logplayerdeath(var_28, param_01, param_03, param_05, param_06, var_0F, param_08);
  param_02 scripts\mp\analyticslog::logevent_path();
  param_02 scripts\mp\analyticslog::logevent_playerdeath(param_01, param_05, param_06);
  if(isplayer(param_01)) {
    param_01 scripts\mp\analyticslog::logevent_playerkill(param_02, param_05, param_06);
  }

  param_02 updatedeathdetails(self.attackers, self.attackerdata);
  param_02 func_41D5();
  param_02.deathspectatepos = undefined;
  if(param_02 isswitchingteams()) {
    func_89F1();
  } else if(!isplayer(param_01) || isplayer(param_01) && param_05 == "MOD_FALLING" && !isDefined(param_02.var_115FC) && !param_02.var_115FC) {
    param_02.deathspectatepos = param_02.origin;
    handleworlddeath(param_01, var_28, param_05, param_08);
    if(isagent(param_01)) {
      var_26 = 1;
    }
  } else if(param_01 == param_02 || !scripts\mp\utility::playersareenemies(param_01, param_02) && scripts\mp\utility::isdronepackage(param_00)) {
    handlesuicidedeath(param_05, param_08);
  } else if(var_1C) {
    if(!isDefined(param_02.nuked) || param_06 == "bomb_site_mp") {
      handlefriendlyfiredeath(param_01);
    }
  } else {
    if(param_05 == "MOD_GRENADE" && param_00 == param_01) {
      addattacker(param_02, param_01, param_00, param_06, param_03, (0, 0, 0), param_07, param_08, param_09, param_05);
    }

    if(param_01 scripts\mp\utility::_hasperk("specialty_chain_reaction")) {
      if(param_05 == "MOD_EXPLOSIVE" || param_05 == "MOD_GRENADE_SPLASH" || param_05 == "MOD_GRENADE") {
        param_02 scripts\mp\perks\_perkfunctions::func_10D79(param_01);
      }
    }

    if(param_06 == "case_bomb_mp") {
      param_01 thread scripts\mp\weapons::func_3B0D(param_02, param_02.origin);
    }

    var_26 = 1;
    if(isai(param_02) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["should_do_killcam"])) {
      var_26 = param_02[[level.bot_funcs["should_do_killcam"]]]();
    }

    if(isDefined(level.disable_killcam) && level.disable_killcam) {
      var_26 = 0;
    }

    handlenormaldeath(var_28, param_01, param_00, param_06, param_05, param_02, param_04);
    param_02 thread scripts\mp\missions::playerkilled(param_00, param_01, param_03, param_04, param_05, param_06, var_0F, param_08, param_01.modifiers);
    param_01 thread scripts\mp\intelchallenges::func_99BA(param_02, param_00, param_06, param_05, param_01.modifiers);
    param_01 thread scripts\mp\contractchallenges::contractkillsimmediate(param_02, param_00, param_06, param_05, param_01.modifiers);
    param_02.pers["cur_death_streak"]++;
    if(isplayer(param_01) && param_02 scripts\mp\utility::isjuggernaut()) {
      if(isDefined(param_02.isjuggernautmaniac) && param_02.isjuggernautmaniac) {
        param_01 thread scripts\mp\utility::teamplayercardsplash("callout_killed_maniac", param_01);
        if(param_05 == "MOD_MELEE") {
          param_01 scripts\mp\missions::processchallenge("ch_thisisaknife");
        }
      } else if(isDefined(param_02.isjuggernautlevelcustom) && param_02.isjuggernautlevelcustom) {
        param_01 thread scripts\mp\utility::teamplayercardsplash(level.var_B332, param_01);
      } else {
        param_01 thread scripts\mp\utility::teamplayercardsplash("callout_killed_juggernaut", param_01);
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

  if(isplayer(param_01) && param_01 != self && !level.teambased || level.teambased && self.team != param_01.team) {
    if(var_29 && isDefined(var_2A)) {
      var_2B = var_2A;
    } else {
      var_2B = self.lastdroppableweaponobj;
    }

    var_2B = scripts\mp\utility::func_13CA1(var_2B, param_00);
    thread scripts\mp\gamelogic::func_11AF7(var_2B, param_05);
    param_01 thread scripts\mp\gamelogic::func_11AC8(param_06, param_05);
  }

  param_02 resetplayervariables();
  param_02 resetplayeromnvarsonspawn();
  param_02.sethalfresparticles = param_01;
  param_02.lastdeathpos = param_02.origin;
  param_02.deathtime = gettime();
  param_02.wantsafespawn = 0;
  param_02.revived = 0;
  param_02.var_EB14 = 0;
  param_02.streaktype = scripts\mp\class::loadout_getplayerstreaktype(param_02.streaktype);
  if(scripts\mp\killstreaks\_killstreaks::streaktyperesetsondeath(param_02.streaktype)) {
    if(!level.var_3B1E && !param_02 scripts\mp\utility::_hasperk("specialty_support_killstreaks")) {
      param_02 scripts\mp\killstreaks\_killstreaks::func_E275();
    }
  }

  var_2C = undefined;
  if(var_0D || level.teambased && isDefined(param_01.team) && param_01.team == param_02.team) {
    var_26 = 0;
    var_27 = 0;
  }

  if(param_0B) {
    var_26 = 0;
    param_0A = param_02 _meth_8231(param_00, param_05, param_06, param_08, param_07);
  }

  if(isDefined(param_01) && isplayer(param_01) && isDefined(param_05) && isDefined(param_06) && isDefined(param_08) && isDefined(param_07)) {
    var_2D = scripts\mp\utility::getweaponrootname(param_06);
    var_2E = param_01 _meth_8519(param_06);
    if(isDefined(var_2D) && var_2D == "iw7_rvn" && scripts\mp\utility::istrue(var_2E) && param_05 == "MOD_MELEE") {
      param_0A = param_02 _meth_8231(param_01, "MOD_EXPLOSIVE", param_06, param_08, param_07);
      var_2F = getweaponvariantindex(param_06);
      if(!isDefined(var_2F) || var_2F != 3 && var_2F != 35) {
        playsoundatpos(param_02.origin, "melee_user2_human_default_fatal_npc");
      }
    }
  }

  if(!isDefined(self.nocorpse)) {
    param_02.body = param_02 getplayerweaponrankxp(param_0A);
    if(param_02 _meth_84CA()) {
      param_02.body setscriptablepartstate("chargeModeShieldDrop", "active", 0);
    }

    if(scripts\mp\utility::istrue(level.var_DC24)) {
      thread scripts\mp\weapons::throwingknife_detachknivesfromcorpse(param_02.body);
      thread scripts\mp\weapons::axedetachfromcorpse(param_02.body);
    }
  }

  if(!isDefined(self.nocorpse) && isDefined(param_02.body)) {
    param_02.body.var_336 = "player_corpse";
    if((scripts\engine\utility::isbulletdamage(param_05) && scripts\mp\utility::getweaponbasedsmokegrenadecount(param_06) == "iw7_atomizer_mp") || param_06 == "nuke_mp") {
      var_30 = undefined;
      if(param_06 == "nuke_mp") {
        var_30 = "ks_nuke_death_npc";
      }

      param_02.body thread scripts\mp\archetypes\archassassin_utility::playbodyfx(var_30);
      param_02.body hide(1);
    }

    enqueueweapononkillcorpsetablefuncs(param_01, param_02, param_00, param_06, param_05);
    param_02 thread callcorpsetablefuncs();
    if(param_0B) {
      param_02 getweaponrankxpmultiplier();
      param_02 setsolid(0);
    }

    if(param_02 isonladder() || param_02 ismantling() || !param_02 isonground() || isDefined(param_02.nuked) || isDefined(param_02.customdeath) || scripts\mp\utility::isragdollzerog()) {
      var_31 = 0;
      if(param_05 == "MOD_MELEE") {
        if((isDefined(param_02.isplanting) && param_02.isplanting) || isDefined(param_02.nuked)) {
          var_31 = 1;
        }
      }

      if(!var_31 || scripts\mp\utility::isragdollzerog()) {
        param_02.body giverankxp(1);
        param_02 notify("start_instant_ragdoll", param_05, param_00);
      }
    }

    if(!isDefined(param_02.switching_teams)) {
      if(isDefined(param_01) && isplayer(param_01) && !param_01 scripts\mp\utility::_hasperk("specialty_silentkill")) {
        thread scripts\mp\deathicons::func_17C1(param_02.body, param_02, param_02.team, 5);
      }
    }

    thread delaystartragdoll(param_02.body, param_08, param_07, param_06, param_00, param_05);
  } else if(isDefined(self.nocorpse)) {
    param_02.body = param_02 getplayerweaponrankxp(param_0A);
    param_02.body hide(1);
    if(level.mapname == "mp_neon") {
      thread scripts\mp\weapons::throwingknife_detachknivesfromcorpse(param_02.body);
      thread scripts\mp\weapons::axedetachfromcorpse(param_02.body);
    }
  }

  param_02 thread scripts\mp\supers::handledeath();
  updatecombatrecordkillstats(param_01, param_02, param_05, param_06);
  param_02 thread[[level.onplayerkilled]](param_00, param_01, param_03, param_05, param_06, param_07, param_08, param_09, param_0A, var_28);
  if(isai(param_02) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["on_killed"])) {
    param_02 thread[[level.bot_funcs["on_killed"]]](param_00, param_01, param_03, param_05, param_06, param_07, param_08, param_09, param_0A, var_28);
  }

  if(scripts\mp\utility::isgameparticipant(param_01)) {
    var_32 = param_01 getentitynumber();
  } else {
    var_32 = -1;
  }

  if(!isDefined(var_2C)) {
    var_2C = param_02 scripts\mp\killcam::func_7F32(param_01, param_00, param_06);
  }

  if(isDefined(level.matchrecording_logeventmsg) && isDefined(param_00) && isplayer(param_00) && scripts\engine\utility::isbulletdamage(param_05)) {
    var_33 = param_00.origin - self.origin;
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

  var_3C = param_05 == "MOD_IMPACT" || param_05 == "MOD_HEADSHOT" && isDefined(param_00) || param_05 == "MOD_GRENADE" || isDefined(param_02) && isDefined(param_02.var_1117F) && isDefined(param_00) && param_02.var_1117F == param_00 || param_06 == "throwingknifec4_mp";
  if(!scripts\mp\utility::iskillstreakweapon(param_06)) {
    scripts\mp\killcam::func_F770(param_06, param_05, param_00);
  }

  if(level.recordfinalkillcam && var_27) {
    if((!isDefined(level.disable_killcam) || !level.disable_killcam) && param_05 != "MOD_SUICIDE" && !!isDefined(param_01) || param_01.classname == "trigger_hurt" || param_01.classname == "worldspawn" || param_01 == param_02) {
      scripts\mp\final_killcam::recordfinalkillcam(5, param_02, param_01, var_32, param_00, var_3A, var_3B, var_3C, param_06, var_0E, param_09, param_05);
    }
  }

  param_02 setplayerdata("common", "killCamHowKilled", 0);
  switch (param_05) {
    case "MOD_HEAD_SHOT":
      param_02 setplayerdata("common", "killCamHowKilled", 1);
      break;

    default:
      break;
  }

  var_3D = undefined;
  if(var_26) {
    param_02 scripts\mp\killcam::func_D83E(param_00, param_01);
    if(isDefined(param_00) && isagent(param_00)) {
      var_3D = spawnStruct();
      var_3D.agent_type = param_00.agent_type;
      var_3D.lastspawntime = param_00.lastspawntime;
    }
  }

  if(!param_0B) {
    self.respawntimerstarttime = gettime() + 1750;
    var_3E = scripts\mp\playerlogic::timeuntilspawn(1);
    if(var_3E < 1) {
      var_3E = 1;
    }

    param_02 thread scripts\mp\playerlogic::predictabouttospawnplayerovertime(var_3E);
    wait(1.75);
    if(var_26) {
      var_26 = !scripts\mp\final_killcam::func_10266(0.5);
    }

    param_02 notify("death_delay_finished");
  }

  var_3F = gettime() - param_02.deathtime / 1000;
  self.respawntimerstarttime = gettime();
  var_26 = var_26 && !param_02 scripts\mp\battlebuddy::func_3876();
  if(!isDefined(param_02.cancelkillcam) && param_02.cancelkillcam && var_26 && level.killcam && game["state"] == "playing" && !param_02 scripts\mp\utility::isusingremote() && !level.showingfinalkillcam) {
    var_40 = !scripts\mp\utility::getgametypenumlives() && !param_02.pers["lives"];
    var_3E = scripts\mp\playerlogic::timeuntilspawn(1);
    var_41 = var_40 && var_3E <= 0;
    if(!var_40) {
      var_3E = -1;
      level notify("player_eliminated", param_02);
    }

    if(!isDefined(param_01)) {
      var_42 = [];
    } else {
      var_42 = param_02.pers["loadoutPerks"];
    }

    var_43 = undefined;
    if(isDefined(param_02.killsteakvariantattackerinfo)) {
      var_43 = param_02.killsteakvariantattackerinfo;
    }

    param_02 scripts\mp\killcam::killcam(param_00, var_3D, var_32, var_3A, var_3B, undefined, var_3C, param_06, var_3F + var_0E, param_09, var_3E, scripts\mp\gamelogic::func_11939(), param_01, param_02, param_05, var_42, var_43);
  }

  if(game["state"] != "playing") {
    if(!level.showingfinalkillcam) {
      param_02 scripts\mp\utility::updatesessionstate("dead");
      param_02 scripts\mp\utility::clearkillcamstate();
    }

    return;
  }

  var_44 = scripts\mp\utility::getgametypenumlives();
  var_45 = self.pers["lives"];
  if(self == param_02 && isDefined(param_02.battlebuddy) && scripts\mp\utility::isreallyalive(param_02.battlebuddy) && !scripts\mp\utility::getgametypenumlives() || self.pers["lives"] && !param_02 scripts\mp\utility::isusingremote()) {
    scripts\mp\battlebuddy::func_136D6();
  }

  if(scripts\mp\utility::isvalidclass(param_02.class)) {
    if(isDefined(level.var_1674) && level.var_1674.team == param_02.team) {
      param_02 scripts\mp\killstreaks\_orbital_deployment::func_10DD3("orbital_deployment", 1);
    } else {
      param_02 thread scripts\mp\playerlogic::spawnclient();
    }
  }

  param_02.var_4F = undefined;
}

isswitchingteams() {
  if(isDefined(self.switching_teams)) {
    return 1;
  }

  return 0;
}

isteamswitchbalanced() {
  var_00 = scripts\mp\teams::countplayers();
  var_00[self.leaving_team]--;
  var_00[self.joining_team]++;
  return var_00[self.joining_team] - var_00[self.leaving_team] < 2;
}

isfriendlyfire(param_00, param_01) {
  if(!level.teambased) {
    return 0;
  }

  if(!isDefined(param_01)) {
    return 0;
  }

  if(!isplayer(param_01) && !isDefined(param_01.team)) {
    return 0;
  }

  if(param_00.team != param_01.team) {
    return 0;
  }

  if(param_00 == param_01) {
    return 0;
  }

  return 1;
}

killedself(param_00) {
  if(!isplayer(param_00)) {
    return 0;
  }

  if(param_00 != self) {
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

handleworlddeath(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_00)) {
    return;
  }

  if(!isDefined(param_00.team)) {
    handlesuicidedeath(param_02, param_03);
    return;
  }

  if((level.teambased && param_00.team != self.team) || !level.teambased) {
    if(isDefined(level.onnormaldeath) && isplayer(param_00) || isagent(param_00) && param_00.team != "spectator") {
      if(!level.gameended) {
        [
          [level.onnormaldeath]
        ](self, param_00, param_01, param_02);
        return;
      }
    }
  }
}

handlesuicidedeath(param_00, param_01) {
  thread scripts\mp\utility::giveunifiedpoints("suicide");
  scripts\mp\utility::incperstat("suicides", 1);
  self.suicides = scripts\mp\utility::getpersstat("suicides");
  var_02 = scripts\mp\tweakables::gettweakablevalue("game", "suicidepointloss");
  scripts\mp\gamescore::_setplayerscore(self, scripts\mp\gamescore::_getplayerscore(self) - var_02);
  if(scripts\mp\weapons::_meth_85BE() && param_00 == "MOD_SUICIDE" && param_01 == "none") {
    self.lastgrenadesuicidetime = gettime();
  }

  if(isDefined(level.onsuicidedeath)) {
    [[level.onsuicidedeath]](self);
  }

  if(isDefined(self.friendlydamage)) {
    scripts\mp\hud_message::showerrormessage("MP_FRIENDLY_FIRE_WILL_NOT");
  }
}

handlefriendlyfiredeath(param_00) {
  param_00 thread scripts\mp\rank::scoreeventpopup("teamkill");
  param_00.pers["teamkills"] = param_00.pers["teamkills"] + 1;
  param_00.teamkillsthisround++;
  if(scripts\mp\tweakables::gettweakablevalue("team", "teamkillpointloss")) {
    var_01 = scripts\mp\rank::getscoreinfovalue("kill");
    scripts\mp\gamescore::_setplayerscore(param_00, scripts\mp\gamescore::_getplayerscore(param_00) - var_01);
  }

  if(level.maxallowedteamkills < 0) {
    return;
  }

  if(level.ingraceperiod) {
    var_02 = 1;
    param_00.pers["teamkills"] = param_00.pers["teamkills"] + level.maxallowedteamkills;
  } else if(var_02.pers["teamkills"] > 1 && scripts\mp\utility::gettimepassed() < level._meth_8487 * 1000 + 8000 + var_02.pers["teamkills"] * 1000) {
    var_02 = 1;
    param_00.pers["teamkills"] = param_00.pers["teamkills"] + level.maxallowedteamkills;
  } else {
    var_02 = var_02 scripts\mp\playerlogic::teamkilldelay();
  }

  if(var_02 > 0) {
    param_00.pers["teamKillPunish"] = 1;
    param_00 scripts\mp\utility::_suicide();
  }
}

handlenormaldeath(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  param_01 thread scripts\mp\events::func_A651(param_00, self, param_03, param_04, param_06, param_02);
  if(param_04 == "MOD_HEAD_SHOT") {
    param_01 scripts\mp\utility::incperstat("headshots", 1);
    param_01.headshots = param_01 scripts\mp\utility::getpersstat("headshots");
    if(isDefined(param_01.setlasermaterial)) {
      var_07 = scripts\mp\rank::getscoreinfovalue("kill") * 2;
    } else {
      var_07 = undefined;
    }

    param_01 playlocalsound("bullet_impact_headshot_plr");
    self playSound("bullet_impact_headshot");
  } else if(isDefined(param_02.setlasermaterial)) {
    var_07 = scripts\mp\rank::getscoreinfovalue("kill") * 2;
  } else {
    var_07 = undefined;
  }

  var_08 = param_01;
  if(isDefined(param_01.commanding_bot)) {
    var_08 = param_01.commanding_bot;
  }

  if(!scripts\mp\utility::istrue(level.ignorescoring) && !isfriendlyfire(param_05, param_01)) {
    var_08 scripts\mp\utility::incperstat("kills", 1, isDefined(level.ignorekdrstats));
    var_08.setculldist = var_08 scripts\mp\utility::getpersstat("kills");
    var_08 scripts\mp\utility::updatepersratio("kdRatio", "kills", "deaths", level.ignorekdrstats);
    var_08 scripts\mp\persistence::statsetchild("round", "kills", var_08.setculldist, level.ignorekdrstats);
  }

  self _meth_83FF();
  param_01 _meth_83FE();
  var_09 = param_01.pers["cur_kill_streak"];
  if(!scripts\mp\utility::istrue(level.ignorescoring) && isalive(param_01) || param_01.streaktype == "support") {
    if((param_04 == "MOD_MELEE" && !param_01 scripts\mp\utility::isjuggernaut()) || param_01 scripts\mp\utility::func_A679(param_03)) {
      param_01 registerkill(param_03, param_04, 1);
    }

    if(param_01.pers["cur_kill_streak"] > param_01 scripts\mp\utility::getpersstat("longestStreak")) {
      param_01 scripts\mp\utility::setpersstat("longestStreak", param_01.pers["cur_kill_streak"]);
    }
  }

  param_01.pers["cur_death_streak"] = 0;
  if(!scripts\mp\utility::istrue(level.ignorescoring) && param_01.pers["cur_kill_streak"] > param_01 scripts\mp\persistence::statgetchild("round", "killStreak")) {
    param_01 scripts\mp\persistence::statsetchild("round", "killStreak", param_01.pers["cur_kill_streak"]);
  }

  if(!scripts\mp\utility::istrue(level.ignorescoring) && param_01 scripts\mp\utility::rankingenabled()) {
    if(param_01.pers["cur_kill_streak"] > param_01.kill_streak) {
      param_01 scripts\mp\persistence::func_10E54("killStreak", param_01.pers["cur_kill_streak"]);
      param_01.kill_streak = param_01.pers["cur_kill_streak"];
    }
  }

  if(!scripts\mp\utility::iskillstreakweapon(param_03)) {
    param_01 thread scripts\mp\utility::giveunifiedpoints("kill", param_03);
    if(param_01 scripts\mp\utility::_hasperk("specialty_hardline") && isDefined(param_01.hardlineactive)) {
      param_01 thread scripts\mp\utility::givestreakpointswithtext("assist_hardline", param_03, undefined);
    }
  }

  var_0A = scripts\mp\tweakables::gettweakablevalue("game", "deathpointloss");
  scripts\mp\gamescore::_setplayerscore(self, scripts\mp\gamescore::_getplayerscore(self) - var_0A);
  if(isDefined(level.ac130player) && level.ac130player == param_01) {
    level notify("ai_killed", self, param_01, param_04, param_03);
  }

  if(isDefined(param_01.odin)) {
    level notify("odin_killed_player", self);
  }

  level notify("player_got_killstreak_" + param_01.pers["cur_kill_streak"], param_01);
  param_01 notify("got_killstreak", param_01.pers["cur_kill_streak"]);
  param_01 notify("killed_enemy", self, param_03, param_04);
  if(isDefined(level.onnormaldeath) && param_01.pers["team"] != "spectator" && !isDefined(level.ignorescoring)) {
    [[level.onnormaldeath]](self, param_01, param_00, param_04, param_03);
  }

  level thread scripts\mp\battlechatter_mp::saylocalsounddelayed(param_01, "kill", 0.75);
  var_0B = undefined;
  switch (param_05.loadoutarchetype) {
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
    level thread scripts\mp\battlechatter_mp::saytoself(param_01, var_0B, "plr_killfirm_generic", 0.75);
  }

  if(isDefined(self.var_A93F) && isDefined(self.var_A940) && self.var_A93F != param_01) {
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

  scripts\mp\gamescore::awardbuffdebuffassists(param_01, self);
  if(isDefined(self.attackers)) {
    foreach(var_0F in self.attackers) {
      if(!isDefined(scripts\mp\utility::_validateattacker(var_0F))) {
        continue;
      }

      if(var_0F == param_01) {
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
        param_05 thread scripts\mp\perks\_perkfunctions::setboominternal(var_0F);
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
        var_0F thread scripts\mp\gamescore::processassist(self, param_03);
      }
    }
  }

  if(level.teambased) {
    if(isDefined(level.uavmodels[param_01.team]) && level.uavmodels[param_01.team].size > 0) {
      var_16 = [];
      foreach(var_18 in level.uavmodels[param_01.team]) {
        if(isDefined(var_18) && isDefined(var_18.triggerportableradarping) && var_18.triggerportableradarping != param_01 && !scripts\engine\utility::exist_in_array_MAYBE(var_16, var_18.uavtype)) {
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

func_9EFE(param_00) {
  if(weaponclass(param_00) == "non-player") {
    return 0;
  }

  if(weaponclass(param_00) == "turret") {
    return 0;
  }

  if(weaponinventorytype(param_00) == "primary" || weaponinventorytype(param_00) == "altmode") {
    return 1;
  }

  return 0;
}

callback_playerkilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  playerkilled_internal(param_00, param_01, self, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, 0);
}

func_DB98(param_00) {
  var_01 = 5;
  if(!isDefined(level.var_FCA4)) {
    level.var_FCA4 = [];
  }

  if(level.var_FCA4.size >= var_01) {
    var_02 = level.var_FCA4.size - 1;
    level.var_FCA4[0] delete();
    for(var_03 = 0; var_03 < var_02; var_03++) {
      level.var_FCA4[var_03] = level.var_FCA4[var_03 + 1];
    }

    level.var_FCA4[var_02] = undefined;
  }

  level.var_FCA4[level.var_FCA4.size] = param_00;
}

launchshield(param_00, param_01) {
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

  foreach(var_01 in level.players) {
    if(!isalive(var_01)) {
      continue;
    }

    if(var_01.team != self.team) {
      continue;
    }

    if(var_01 == self) {
      continue;
    }

    if(!var_01.inlaststand) {
      return 0;
    }
  }

  foreach(var_01 in level.players) {
    if(!isalive(var_01)) {
      continue;
    }

    if(var_01.team != self.team) {
      continue;
    }

    if(var_01.inlaststand && var_01 != self) {
      var_01 func_AA07(0);
    }
  }

  return 1;
}

checkkillsteal(param_00) {
  if(scripts\mp\utility::matchmakinggame()) {
    return;
  }

  var_01 = 0;
  var_02 = undefined;
  if(isDefined(param_00.attackerdata) && param_00.attackerdata.size > 1) {
    foreach(var_04 in param_00.attackerdata) {
      if(var_04.var_DA > var_01) {
        var_01 = var_04.var_DA;
        var_02 = var_04.attackerent;
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

hitlocdebug(param_00, param_01, param_02, param_03, param_04) {
  var_05 = [];
  var_05[0] = 2;
  var_05[1] = 3;
  var_05[2] = 5;
  var_05[3] = 7;
  if(!getdvarint("scr_hitloc_debug")) {
    return;
  }

  if(!isDefined(param_00.hitlocinited)) {
    for(var_06 = 0; var_06 < 6; var_06++) {
      param_00 setclientdvar("ui_hitloc_" + var_06, "");
    }

    param_00.hitlocinited = 1;
  }

  if(level.splitscreen || !isplayer(param_00)) {
    return;
  }

  var_07 = 6;
  if(!isDefined(param_00.damageinfo)) {
    param_00.damageinfo = [];
    for(var_06 = 0; var_06 < var_07; var_06++) {
      param_00.damageinfo[var_06] = spawnStruct();
      param_00.damageinfo[var_06].var_DA = 0;
      param_00.damageinfo[var_06].hitloc = "";
      param_00.damageinfo[var_06].bp = 0;
      param_00.damageinfo[var_06].jugg = 0;
      param_00.damageinfo[var_06].colorindex = 0;
    }

    param_00.damageinfocolorindex = 0;
    param_00.damageinfovictim = undefined;
  }

  for(var_06 = var_07 - 1; var_06 > 0; var_06--) {
    param_00.damageinfo[var_06].var_DA = param_00.damageinfo[var_06 - 1].var_DA;
    param_00.damageinfo[var_06].hitloc = param_00.damageinfo[var_06 - 1].hitloc;
    param_00.damageinfo[var_06].bp = param_00.damageinfo[var_06 - 1].bp;
    param_00.damageinfo[var_06].jugg = param_00.damageinfo[var_06 - 1].jugg;
    param_00.damageinfo[var_06].colorindex = param_00.damageinfo[var_06 - 1].colorindex;
  }

  param_00.damageinfo[0].var_DA = param_02;
  param_00.damageinfo[0].hitloc = param_03;
  param_00.damageinfo[0].bp = param_04 &level.idflags_penetration;
  param_00.damageinfo[0].jugg = param_01 scripts\mp\utility::isjuggernaut();
  if(isDefined(param_00.damageinfovictim) && param_00.damageinfovictim != param_01) {
    param_00.damageinfocolorindex++;
    if(param_00.damageinfocolorindex == var_05.size) {
      param_00.damageinfocolorindex = 0;
    }
  }

  param_00.damageinfovictim = param_01;
  param_00.damageinfo[0].colorindex = param_00.damageinfocolorindex;
  for(var_06 = 0; var_06 < var_07; var_06++) {
    var_08 = "^" + var_05[param_00.damageinfo[var_06].colorindex];
    if(param_00.damageinfo[var_06].hitloc != "") {
      var_09 = var_08 + param_00.damageinfo[var_06].hitloc;
      if(param_00.damageinfo[var_06].bp) {
        var_09 = var_09 + " (BP)";
      }

      if(param_00.damageinfo[var_06].jugg) {
        var_09 = var_09 + " (Jugg)";
      }

      param_00 setclientdvar("ui_hitloc_" + var_06, var_09);
    }

    param_00 setclientdvar("ui_hitloc_damage_" + var_06, var_08 + param_00.damageinfo[var_06].var_DA);
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

updateinflictorstat(param_00, param_01, param_02) {
  if(!isDefined(param_00) || !isDefined(param_00.alreadyhit) || !param_00.alreadyhit || !scripts\mp\utility::issinglehitweapon(param_02)) {
    scripts\mp\gamelogic::setinflictorstat(param_00, param_01, param_02);
  }

  if(isDefined(param_00)) {
    param_00.alreadyhit = 1;
  }
}

func_100C1(param_00) {
  switch (param_00) {
    case "stealth_bomb_mp":
    case "artillery_mp":
      return 0;
  }

  return 1;
}

addattacker(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(!isDefined(param_00.attackerdata)) {
    param_00.attackerdata = [];
  }

  if(!isDefined(param_00.attackerdata[param_01.guid])) {
    param_00.attackers[param_01.guid] = param_01;
    param_00.attackerdata[param_01.guid] = spawnStruct();
    param_00.attackerdata[param_01.guid].var_DA = 0;
    param_00.attackerdata[param_01.guid].attackerent = param_01;
    param_00.attackerdata[param_01.guid].firsttimedamaged = gettime();
    param_00.attackerdata[param_01.guid].hits = 1;
  } else {
    param_00.attackerdata[param_01.guid].hits++;
  }

  if(scripts\mp\utility::iscacprimaryweapon(param_03) && !scripts\mp\utility::iscacsecondaryweapon(param_03)) {
    param_00.attackerdata[param_01.guid].var_54B4 = 1;
  }

  if(isDefined(param_09) && param_09 != "MOD_MELEE") {
    param_00.attackerdata[param_01.guid].didnonmeleedamage = 1;
  }

  var_0A = scripts\mp\utility::getequipmenttype(param_03);
  if(isDefined(var_0A)) {
    if(var_0A == "lethal") {
      param_00.attackerdata[param_01.guid].diddamagewithlethalequipment = 1;
      param_01 scripts\mp\contractchallenges::contractequipmentdamagedplayer(param_00, param_03, param_02);
    }

    if(var_0A == "tactical") {
      param_00.attackerdata[param_01.guid].diddamagewithtacticalequipment = 1;
      param_01 scripts\mp\contractchallenges::contractequipmentdamagedplayer(param_00, param_03, param_02);
    }
  }

  param_00.attackerdata[param_01.guid].var_DA = param_00.attackerdata[param_01.guid].var_DA + param_04;
  param_00.attackerdata[param_01.guid].var_394 = param_03;
  param_00.attackerdata[param_01.guid].vpoint = param_05;
  param_00.attackerdata[param_01.guid].vdir = param_06;
  param_00.attackerdata[param_01.guid].shitloc = param_07;
  param_00.attackerdata[param_01.guid].box = param_08;
  param_00.attackerdata[param_01.guid].smeansofdeath = param_09;
  param_00.attackerdata[param_01.guid].attackerent = param_01;
  param_00.attackerdata[param_01.guid].lasttimedamaged = gettime();
  if(isDefined(param_02) && !isplayer(param_02) && isDefined(param_02.primaryweapon)) {
    param_00.attackerdata[param_01.guid].sprimaryweapon = param_02.primaryweapon;
    return;
  }

  if(isDefined(param_01) && isplayer(param_01) && param_01 getcurrentprimaryweapon() != "none") {
    param_00.attackerdata[param_01.guid].sprimaryweapon = param_01 getcurrentprimaryweapon();
    return;
  }

  param_00.attackerdata[param_01.guid].sprimaryweapon = undefined;
}

addattackerkillstreak(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(!isDefined(param_00.attackerdata)) {
    param_00.attackerdata = [];
  }

  if(!isDefined(param_00.attackerdata[param_02.guid])) {
    param_00.attackers[param_02.guid] = param_02;
    param_00.attackerdata[param_02.guid] = spawnStruct();
    param_00.attackerdata[param_02.guid].var_DA = 0;
    param_00.attackerdata[param_02.guid].attackerent = param_02;
    param_00.attackerdata[param_02.guid].firsttimedamaged = gettime();
    param_00.attackerdata[param_02.guid].hits = 1;
  }

  param_00.attackerdata[param_02.guid].var_DA = param_00.attackerdata[param_02.guid].var_DA + param_01;
  param_00.attackerdata[param_02.guid].var_394 = param_0A;
  param_00.attackerdata[param_02.guid].vpoint = param_04;
  param_00.attackerdata[param_02.guid].vdir = param_03;
  param_00.attackerdata[param_02.guid].updategamerprofileall = param_08;
  param_00.attackerdata[param_02.guid].smeansofdeath = param_05;
  param_00.attackerdata[param_02.guid].attackerent = param_02;
  param_00.attackerdata[param_02.guid].lasttimedamaged = gettime();
  if(isDefined(param_02) && isplayer(param_02) && param_02 getcurrentprimaryweapon() != "none") {
    param_00.attackerdata[param_02.guid].sprimaryweapon = param_02 getcurrentprimaryweapon();
    return;
  }

  param_00.attackerdata[param_02.guid].sprimaryweapon = undefined;
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
    var_00 = gettime();
    foreach(var_03, var_02 in self.attackers) {
      if(isDefined(var_02) && var_00 - self.attackerdata[var_03].lasttimedamaged < 2000) {
        continue;
      }

      self.attackers[var_03] = undefined;
      self.attackerdata[var_03] = undefined;
    }

    scripts\engine\utility::waitframe();
  }
}

callback_playerdamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = callback_playerdamage_internal(param_00, param_01, self, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
}

finishplayerdamagewrapper(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D) {
  if(!isDefined(param_0A)) {
    param_0A = 0;
  }

  if(scripts\mp\utility::isusingremote() && param_02 >= self.health && !param_03 &level.idflags_stun && allowfauxdeath()) {
    if(!isDefined(param_07)) {
      param_07 = (0, 0, 0);
    }

    if(!isDefined(param_01)) {
      param_01 = self;
    }

    if(!isDefined(param_00)) {
      param_00 = param_01;
    }

    playerkilled_internal(param_00, param_01, self, param_02, param_03, param_04, param_05, param_07, param_08, param_09, 0, 1);
  } else {
    if(!callback_killingblow(param_00, param_01, param_02 - param_02 * param_0A, param_03, param_04, param_05, param_06, param_07, param_08, param_09)) {
      return;
    }

    if(!isalive(self)) {
      return;
    }

    if(isplayer(self)) {
      if(!isDefined(param_0C)) {
        param_0C = "";
      }

      if(!isDefined(param_0D)) {
        param_0D = 0;
      }

      self finishplayerdamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D);
    }
  }

  if(param_04 == "MOD_EXPLOSIVE_BULLET") {
    self shellshock("damage_mp", getdvarfloat("scr_csmode"));
  }

  damageshellshockandrumble(param_00, param_05, param_04, param_02, param_03, param_01);
}

callback_playerimpaled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  thread scripts\mp\weapons::impale(param_00, self, param_01, param_02, param_03, param_04, param_05, param_06, param_07);
}

allowfauxdeath() {
  if(!isDefined(level.allowfauxdeath)) {
    level.allowfauxdeath = 1;
  }

  return level.allowfauxdeath;
}

callback_playerlaststand(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  var_09 = spawnStruct();
  var_09.einflictor = param_00;
  var_09.var_4F = param_01;
  var_09.idamage = param_02;
  var_09.attackerposition = param_01.origin;
  if(param_01 == self) {
    var_09.smeansofdeath = "MOD_SUICIDE";
  } else {
    var_09.smeansofdeath = param_03;
  }

  var_09.sweapon = param_04;
  if(isDefined(param_01) && isplayer(param_01) && param_01 getcurrentprimaryweapon() != "none") {
    var_09.sprimaryweapon = param_01 getcurrentprimaryweapon();
  } else {
    var_09.sprimaryweapon = undefined;
  }

  var_09.vdir = param_05;
  var_09.shitloc = param_06;
  var_09.laststandstarttime = gettime();
  var_0A = maydolaststand(param_04, param_03, param_06);
  if(isDefined(self.endgame)) {
    var_0A = 0;
  }

  if(level.teambased && isDefined(param_01.team) && param_01.team == self.team) {
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
    self.laststandparams = var_09;
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
  if(isDefined(level.ac130player) && isDefined(param_01) && level.ac130player == param_01) {
    level notify("ai_crawling", self);
  }

  if(scripts\mp\utility::_hasperk("specialty_finalstand")) {
    self.laststandparams = var_09;
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
    self.laststandparams = var_09;
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
    param_01 thread scripts\mp\utility::giveunifiedpoints("kill", param_04);
    self.laststandparams = var_09;
    scripts\engine\utility::allow_weapon(0);
    thread func_AA11(20, 0);
    scripts\engine\utility::allow_usability(0);
    return;
  }

  self.laststandparams = var_09;
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

func_54C8(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  level endon("game_ended");
  wait(param_00);
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

func_AA11(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  level notify("player_last_stand");
  thread func_AA16();
  self.setlasermaterial = 1;
  if(!param_01 && !isDefined(self.inc4death) || !self.inc4death) {
    thread func_AA05();
    scripts\mp\utility::setlowermessage("last_stand", &"PLATFORM_COWARDS_WAY_OUT", undefined, undefined, undefined, undefined, undefined, undefined, 1);
    thread func_AA09();
  }

  if(level.diehardmode == 1 && level.diehardmode != 2) {
    var_02 = spawn("script_model", self.origin);
    var_02 setModel("tag_origin");
    var_02 setcursorhint("HINT_NOICON");
    var_02 sethintstring(&"PLATFORM_REVIVE");
    var_02 revivesetup(self);
    var_02 endon("death");
    var_03 = newteamhudelem(self.team);
    var_03 setshader("waypoint_revive", 8, 8);
    var_03 setwaypoint(1, 1);
    var_03 settargetent(self);
    var_03 thread func_5321(var_02);
    var_03.color = (0.33, 0.75, 0.24);
    scripts\mp\utility::playdeathsound();
    if(param_01) {
      wait(param_00);
      if(self.infinalstand) {
        thread func_AA07(param_01, var_02);
      }
    }

    return;
  } else if(level.diehardmode == 2) {
    thread func_AA09();
    var_02 = spawn("script_model", self.origin);
    var_03 setModel("tag_origin");
    var_03 setcursorhint("HINT_NOICON");
    var_03 sethintstring(&"PLATFORM_REVIVE");
    var_03 revivesetup(self);
    var_03 endon("death");
    var_03 = newteamhudelem(self.team);
    var_03 setshader("waypoint_revive", 8, 8);
    var_03 setwaypoint(1, 1);
    var_03 settargetent(self);
    var_03 thread func_5321(var_02);
    var_03.color = (0.33, 0.75, 0.24);
    scripts\mp\utility::playdeathsound();
    if(param_01) {
      wait(param_00);
      if(self.infinalstand) {
        thread func_AA07(param_01, var_02);
      }
    }

    wait(param_00 / 3);
    var_03.color = (1, 0.64, 0);
    while(var_02.inuse) {
      wait(0.05);
    }

    scripts\mp\utility::playdeathsound();
    wait(param_00 / 3);
    var_03.color = (1, 0, 0);
    while(var_02.inuse) {
      wait(0.05);
    }

    scripts\mp\utility::playdeathsound();
    wait(param_00 / 3);
    while(var_02.inuse) {
      wait(0.05);
    }

    wait(0.05);
    thread func_AA07(param_01);
    return;
  }

  thread func_AA09();
  wait(var_02);
  thread func_AA07(var_03);
}

func_B4A2(param_00, param_01) {
  self endon("stop_maxHealthOverlay");
  self endon("revive");
  self endon("death");
  for(;;) {
    self.health = self.health - 1;
    self.maxhealth = param_00;
    wait(0.05);
    self.maxhealth = 50;
    self.health = self.health + 1;
    wait(0.5);
  }
}

func_AA07(param_00, param_01) {
  if(param_00) {
    self.setlasermaterial = undefined;
    self.infinalstand = 0;
    self notify("revive");
    scripts\mp\utility::clearlowermessage("last_stand");
    scripts\mp\playerlogic::laststandrespawnplayer();
    if(isDefined(param_01)) {
      param_01 delete();
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
      var_00 = gettime();
      while(self usebuttonpressed()) {
        wait(0.05);
        if(gettime() - var_00 > 700) {
          break;
        }
      }

      if(gettime() - var_00 > 700) {
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

maydolaststand(param_00, param_01, param_02) {
  if(param_01 == "MOD_TRIGGER_HURT") {
    return 0;
  }

  if(param_01 != "MOD_PISTOL_BULLET" && param_01 != "MOD_RIFLE_BULLET" && param_01 != "MOD_FALLING" && param_01 != "MOD_EXPLOSIVE_BULLET") {
    return 0;
  }

  if(param_01 == "MOD_IMPACT" && scripts\mp\weapons::func_9FA9(param_00)) {
    return 0;
  }

  if(param_01 == "MOD_IMPACT" && param_00 == "m79_mp" || issubstr(param_00, "gl_")) {
    return 0;
  }

  if(scripts\mp\utility::isheadshot(param_00, param_02, param_01)) {
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

gethitlocheight(param_00) {
  switch (param_00) {
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

delaystartragdoll(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(isDefined(param_00)) {
    var_06 = param_00 _meth_8112();
    if(animhasnotetrack(var_06, "ignore_ragdoll")) {
      return;
    }
  }

  if(isDefined(level.noragdollents) && level.noragdollents.size) {
    foreach(var_08 in level.noragdollents) {
      if(distancesquared(param_00.origin, var_08.origin) < 65536) {
        return;
      }
    }
  }

  wait(0.2);
  if(!isDefined(param_00)) {
    return;
  }

  if(param_00 _meth_81B7()) {
    return;
  }

  var_06 = param_00 _meth_8112();
  var_0A = 0.35;
  if(animhasnotetrack(var_06, "start_ragdoll")) {
    var_0B = getnotetracktimes(var_06, "start_ragdoll");
    if(isDefined(var_0B)) {
      var_0A = var_0B[0];
    }
  }

  var_0C = var_0A * getanimlength(var_06);
  wait(var_0C);
  if(isDefined(param_00)) {
    param_00 giverankxp();
  }
}

func_7FCA() {
  var_00 = "";
  var_01 = 0;
  var_02 = getarraykeys(self.killedby);
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    var_04 = var_02[var_03];
    if(self.killedby[var_04] <= var_01) {
      continue;
    }

    var_01 = self.killedby[var_04];
    var_05 = var_04;
  }

  return var_00;
}

func_7FC9() {
  var_00 = "";
  var_01 = 0;
  var_02 = getarraykeys(self.var_A653);
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    var_04 = var_02[var_03];
    if(self.var_A653[var_04] <= var_01) {
      continue;
    }

    var_01 = self.var_A653[var_04];
    var_00 = var_04;
  }

  return var_00;
}

damageshellshockandrumble(param_00, param_01, param_02, param_03, param_04, param_05) {
  thread scripts\mp\weapons::onweapondamage(param_00, param_01, param_02, param_03, param_05);
  if(!isai(self) && scripts\engine\utility::getdamagetype(param_02) != "bullet") {
    self playrumbleonentity("damage_heavy");
  }
}

revivesetup(param_00) {
  var_01 = param_00.team;
  self linkto(param_00, "tag_origin");
  self.triggerportableradarping = param_00;
  self.inuse = 0;
  self makeusable();
  updateusablebyteam(var_01);
  thread trackteamchanges(var_01);
  thread revivetriggerthink(var_01);
  thread deleteotpreview();
}

deleteotpreview() {
  self endon("death");
  self.triggerportableradarping scripts\engine\utility::waittill_any_3("death", "disconnect");
  self delete();
}

updateusablebyteam(param_00) {
  foreach(var_02 in level.players) {
    if(param_00 == var_02.team && var_02 != self.triggerportableradarping) {
      self enableplayeruse(var_02);
      continue;
    }

    self disableplayeruse(var_02);
  }
}

trackteamchanges(param_00) {
  self endon("death");
  for(;;) {
    level waittill("joined_team");
    updateusablebyteam(param_00);
  }
}

func_11AF5(param_00) {
  self endon("death");
  for(;;) {
    level waittill("player_last_stand");
    updateusablebyteam(param_00);
  }
}

revivetriggerthink(param_00) {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("trigger", var_01);
    self.triggerportableradarping.var_2A8A = 1;
    if(isDefined(var_01.var_2A8A) && var_01.var_2A8A) {
      self.triggerportableradarping.var_2A8A = 0;
      continue;
    }

    self makeunusable();
    self.triggerportableradarping scripts\mp\utility::freezecontrolswrapper(1);
    var_02 = useholdthink(var_01);
    self.triggerportableradarping.var_2A8A = 0;
    if(!isalive(self.triggerportableradarping)) {
      self delete();
      return;
    }

    self.triggerportableradarping scripts\mp\utility::freezecontrolswrapper(0);
    if(var_02) {
      var_01 thread scripts\mp\hud_message::showsplash("reviver", scripts\mp\rank::getscoreinfovalue("reviver"));
      var_01 thread scripts\mp\utility::giveunifiedpoints("reviver");
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
    updateusablebyteam(param_00);
  }
}

useholdthink(param_00, param_01) {
  var_02 = 3000;
  var_03 = spawn("script_origin", self.origin);
  var_03 hide();
  param_00 playerlinkto(var_03);
  param_00 playerlinkedoffsetenable();
  param_00 scripts\engine\utility::allow_weapon(0);
  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 0;
  if(isDefined(param_01)) {
    self.usetime = param_01;
  } else {
    self.usetime = var_02;
  }

  var_04 = useholdthinkloop(param_00);
  self.inuse = 0;
  var_03 delete();
  if(isDefined(param_00) && scripts\mp\utility::isreallyalive(param_00)) {
    param_00 unlink();
    param_00 scripts\engine\utility::allow_weapon(1);
  }

  if(isDefined(var_04) && var_04) {
    self.triggerportableradarping thread scripts\mp\hud_message::showsplash("revived", undefined, param_00);
    self.triggerportableradarping.inlaststand = 0;
    return 1;
  }

  return 0;
}

useholdthinkloop(param_00) {
  level endon("game_ended");
  self.triggerportableradarping endon("death");
  self.triggerportableradarping endon("disconnect");
  while(scripts\mp\utility::isreallyalive(param_00) && param_00 usebuttonpressed() && self.curprogress < self.usetime && !isDefined(param_00.setlasermaterial) || !param_00.setlasermaterial) {
    self.curprogress = self.curprogress + 50 * self.userate;
    self.userate = 1;
    param_00 scripts\mp\gameobjects::updateuiprogress(self, 1);
    self.triggerportableradarping scripts\mp\gameobjects::updateuiprogress(self, 1);
    if(self.curprogress >= self.usetime) {
      self.inuse = 0;
      param_00 scripts\mp\gameobjects::updateuiprogress(self, 0);
      self.triggerportableradarping scripts\mp\gameobjects::updateuiprogress(self, 0);
      return scripts\mp\utility::isreallyalive(param_00);
    }

    wait(0.05);
  }

  param_00 scripts\mp\gameobjects::updateuiprogress(self, 0);
  self.triggerportableradarping scripts\mp\gameobjects::updateuiprogress(self, 0);
  return 0;
}

callback_killingblow(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(isDefined(self.lastdamagewasfromenemy) && self.lastdamagewasfromenemy && param_02 >= self.health && isDefined(self.combathigh) && self.combathigh == "specialty_endgame") {
    scripts\mp\utility::giveperk("specialty_endgame");
    return 0;
  }

  return 1;
}

func_612A(param_00) {
  physicsexplosionsphere(self.origin, 64, 64, 1);
  var_01 = [];
  for(var_02 = 0; var_02 < 360; var_02 = var_02 + 30) {
    var_03 = cos(var_02) * 16;
    var_04 = sin(var_02) * 16;
    var_05 = bulletTrace(self.origin + (var_03, var_04, 4), self.origin + (var_03, var_04, -6), 1, self);
    if(isDefined(var_05["entity"]) && isDefined(var_05["entity"].var_336) && var_05["entity"].var_336 == "destructible_vehicle" || var_05["entity"].var_336 == "destructible_toy") {
      var_01[var_01.size] = var_05["entity"];
    }
  }

  if(var_01.size) {
    var_06 = spawn("script_origin", self.origin);
    var_06 hide();
    var_06.type = "soft_landing";
    var_06.var_5379 = var_01;
    radiusdamage(self.origin, 64, 100, 100, var_06);
    wait(0.1);
    var_06 delete();
  }
}

func_9DF9(param_00, param_01) {
  var_02 = anglesToForward(param_00.angles);
  var_02 = (var_02[0], var_02[1], 0);
  var_02 = vectornormalize(var_02);
  var_03 = param_00.origin - param_01.origin;
  var_03 = (var_03[0], var_03[1], 0);
  var_03 = vectornormalize(var_03);
  var_04 = vectordot(var_02, var_03);
  if(var_04 > 0) {
    return 1;
  }

  return 0;
}

func_5321(param_00) {
  param_00 waittill("death");
  self destroy();
}

gamemodemodifyplayerdamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(isDefined(param_01) && isplayer(param_01) && isalive(param_01)) {
    if(level.matchrules_damagemultiplier) {
      param_02 = param_02 * level.matchrules_damagemultiplier;
    }

    if(level.matchrules_vampirism) {
      param_01.health = int(min(float(param_01.maxhealth), float(param_01.health + 20)));
    }

    if(level.tactical) {
      var_08 = weaponclass(param_04);
      if(var_08 == "sniper" || var_08 == "spread" || issubstr(param_04, "iw7_udm45_mpl")) {
        param_02 = param_02 * 0.7;
      }

      switch (param_07) {
        case "neck":
        case "helmet":
        case "head":
          if(var_08 != "spread") {
            param_02 = param_02 * 2;
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

  return param_02;
}

registerkill(param_00, param_01, param_02) {
  var_03 = scripts\mp\utility::iskillstreakweapon(param_00) && !param_01 == "MOD_MELEE";
  if(!var_03) {
    self.pers["cur_kill_streak_for_nuke"]++;
  }

  self.pers["cur_kill_streak"]++;
  if(param_02) {
    self notify("kill_streak_increased");
  }

  var_04 = 25;
  if(scripts\mp\utility::_hasperk("specialty_hardline")) {
    var_04--;
  }

  if(!var_03 && self.pers["cur_kill_streak_for_nuke"] == var_04 && !scripts\mp\utility::isanymlgmatch()) {
    if(!isDefined(level.supportnuke) || level.supportnuke) {
      suicide(var_04);
    }
  }
}

suicide(param_00) {}

monitordamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  self endon("death");
  level endon("game_ended");
  if(!isDefined(param_05)) {
    param_05 = 0;
  }

  self setCanDamage(1);
  self.health = 999999;
  self.maxhealth = param_00;
  if(!isDefined(self.var_E1) || scripts\mp\utility::istrue(param_06)) {
    self.var_E1 = 0;
  }

  if(!isDefined(param_04)) {
    param_04 = 0;
  }

  for(var_07 = 1; var_07; var_07 = monitordamageoneshot(var_08, var_09, var_0A, var_0B, var_0C, var_0D, var_0E, var_0F, var_10, var_11, param_01, param_02, param_03, param_04)) {
    self waittill("damage", var_08, var_09, var_0A, var_0B, var_0C, var_0D, var_0E, var_0F, var_10, var_11, var_12, var_13, var_14, var_15);
    var_11 = scripts\mp\utility::func_13CA1(var_11, var_15);
    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_09)) {
      continue;
    }

    if(param_05) {
      self playrumbleonentity("damage_light");
    }

    if(param_04) {
      logattackerkillstreak(self, var_08, var_09, var_0A, var_0B, var_0C, var_0D, var_0E, var_0F, var_10, var_11);
    }

    if(isDefined(self.helitype) && self.helitype == "littlebird") {
      if(!isDefined(self.attackers)) {
        self.attackers = [];
      }

      var_16 = "";
      if(isDefined(var_09) && isplayer(var_09)) {
        var_16 = var_09 scripts\mp\utility::getuniqueid();
      }

      if(isDefined(self.attackers[var_16])) {
        self.attackers[var_16] = self.attackers[var_16] + var_08;
      } else {
        self.attackers[var_16] = var_08;
      }
    }
  }
}

monitordamageoneshot(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D) {
  if(!isDefined(self)) {
    return 0;
  }

  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(param_01)) {
    return 0;
  }

  if(isDefined(param_01) && isDefined(param_01.triggerportableradarping)) {
    param_01 = param_01.triggerportableradarping;
  }

  if(isDefined(param_01) && !scripts\mp\utility::isgameparticipant(param_01)) {
    return 1;
  }

  if(isDefined(param_01) && !scripts\mp\weapons::friendlyfirecheck(self.triggerportableradarping, param_01)) {
    return 1;
  }

  if(isDefined(param_09) && scripts\mp\weapons::isballweapon(param_09)) {
    return 1;
  }

  var_0E = param_00;
  if(scripts\mp\weapons::func_66AA(param_09, param_04)) {
    return 1;
  }

  if(isDefined(param_09)) {
    if(!isDefined(param_0C)) {
      param_0C = ::modifydamage;
    }

    var_0E = self[[param_0C]](param_01, param_09, param_04, param_00, param_08);
  }

  if(var_0E <= 0) {
    return 1;
  }

  self.wasdamaged = 1;
  self.var_E1 = self.var_E1 + var_0E;
  if(isDefined(param_08) && param_08 &level.idflags_penetration) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  if(isDefined(param_08) && param_08 &level.idflags_ricochet) {
    self.wasdamagedfrombulletricochet = 1;
  }

  if(param_0D) {
    scripts\mp\killstreaks\_killstreaks::killstreakhit(param_01, param_09, self, param_04);
  }

  if(isDefined(param_01)) {
    if(isplayer(param_01)) {
      param_01 scripts\mp\damagefeedback::updatedamagefeedback(param_0A);
    }
  }

  if(self.var_E1 >= self.maxhealth) {
    self thread[[param_0B]](param_01, param_09, param_04, param_00);
    return 0;
  }

  return 1;
}

modifydamage(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(param_04) && param_04 && level.idflags_ricochet) {
    var_05 = 0.6 * param_03;
  } else {
    var_05 = param_04;
  }

  var_05 = handleempdamage(param_01, param_02, var_05);
  var_05 = handlemissiledamage(param_01, param_02, var_05);
  var_05 = handlegrenadedamage(param_01, param_02, var_05);
  var_05 = handleapdamage(param_01, param_02, var_05);
  return var_05;
}

handlemissiledamage(param_00, param_01, param_02) {
  param_00 = scripts\mp\utility::getweaponbasedsmokegrenadecount(param_00);
  var_03 = param_02;
  switch (param_00) {
    case "maverick_projectile_mp":
    case "ac130_40mm_mp":
    case "ac130_105mm_mp":
    case "aamissile_projectile_mp":
    case "iw7_chargeshot_mp":
    case "iw7_lockon_mp":
    case "drone_hive_projectile_mp":
    case "bomb_site_mp":
      self.largeprojectiledamage = 1;
      var_03 = self.maxhealth + 1;
      break;

    case "remote_tank_projectile_mp":
    case "hind_missile_mp":
    case "hind_bomb_mp":
    case "switch_blade_child_mp":
      self.largeprojectiledamage = 0;
      var_03 = self.maxhealth + 1;
      break;

    case "a10_30mm_turret_mp":
    case "heli_pilot_turret_mp":
      self.largeprojectiledamage = 0;
      var_03 = var_03 * 2;
      break;

    case "sam_projectile_mp":
      self.largeprojectiledamage = 1;
      var_03 = param_02;
      break;
  }

  return var_03;
}

handlegrenadedamage(param_00, param_01, param_02) {
  if(isexplosivedamagemod(param_01)) {
    switch (param_00) {
      case "iw6_rgm_mp":
      case "proximity_explosive_mp":
      case "c4_mp":
        param_02 = param_02 * 3;
        break;

      case "iw6_mk32_mp":
      case "semtexproj_mp":
      case "bouncingbetty_mp":
      case "semtex_mp":
      case "frag_grenade_mp":
        param_02 = param_02 * 4;
        break;

      default:
        if(scripts\mp\utility::isstrstart(param_00, "alt_")) {
          param_02 = param_02 * 3;
        }
        break;
    }
  }

  return param_02;
}

handlemeleedamage(param_00, param_01, param_02) {
  if(param_01 == "MOD_MELEE") {
    return self.maxhealth + 1;
  }

  return param_02;
}

handleempdamage(param_00, param_01, param_02) {
  return param_02;
}

handleapdamage(param_00, param_01, param_02, param_03) {
  var_04 = 1;
  var_05 = level.armorpiercingmod - 1;
  if(scripts\mp\utility::isfmjdamage(param_00, param_01)) {
    var_04 = var_04 + var_05;
  }

  var_06 = level.armorpiercingmodks - 1;
  if(isDefined(param_03) && param_03 scripts\mp\utility::_hasperk("specialty_armorpiercingks") && isDefined(self.streakname) && scripts\mp\weapons::isprimaryweapon(param_00) && scripts\engine\utility::isbulletdamage(param_01)) {
    var_04 = var_04 + var_06;
  }

  return param_02 * var_04;
}

handleshotgundamage(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    return param_02;
  }

  if(param_00 == "none") {
    return param_02;
  }

  if(scripts\mp\utility::getweaponbasedsmokegrenadecount(param_00) == "iw7_claw_mp") {
    return param_02;
  }

  if(weaponclass(param_00) != "spread") {
    return param_02;
  }

  return int(min(150, param_02));
}

onkillstreakdamaged(param_00, param_01, param_02, param_03) {
  var_04 = undefined;
  if(isDefined(param_01) && isDefined(self.triggerportableradarping)) {
    if(isDefined(param_01.triggerportableradarping) && isplayer(param_01.triggerportableradarping)) {
      param_01 = param_01.triggerportableradarping;
    }

    if(isplayer(param_01) && self.triggerportableradarping scripts\mp\utility::isenemy(param_01)) {
      var_04 = param_01;
    }
  }

  if(isDefined(var_04)) {
    thread scripts\mp\missions::killstreakdamaged(param_00, self.triggerportableradarping, var_04, param_02, param_03);
  }
}

onkillstreakkilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  var_09 = 0;
  var_0A = undefined;
  if(isDefined(param_01) && isDefined(self.triggerportableradarping)) {
    if(isDefined(param_01.triggerportableradarping) && isplayer(param_01.triggerportableradarping)) {
      param_01 = param_01.triggerportableradarping;
    }

    if(self.triggerportableradarping scripts\mp\utility::isenemy(param_01)) {
      var_0A = param_01;
    }
  }

  if(isDefined(var_0A)) {
    var_0A notify("destroyed_killstreak", param_02);
    if(isDefined(param_07)) {
      thread scripts\mp\utility::teamplayercardsplash(param_07, var_0A);
    }

    scripts\mp\missions::setweaponammostock(self, var_0A);
    thread scripts\mp\events::killedkillstreak(param_00, var_0A);
    thread scripts\mp\missions::killstreakkilled(param_00, self.triggerportableradarping, self, undefined, var_0A, param_04, param_03, param_02, param_05);
    var_09 = 1;
  }

  if(isDefined(self.triggerportableradarping) && isDefined(param_06)) {
    self.triggerportableradarping scripts\mp\utility::playkillstreakdialogonplayer(param_06, undefined, undefined, self.origin);
  }

  if(!scripts\mp\utility::istrue(param_08)) {
    self notify("death");
  }

  return var_09;
}

func_12EFD(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.var_DDBE)) {
    self.var_DDBE = [];
  }

  if(self.health >= self.maxhealth) {
    func_41D5();
  }

  var_04 = undefined;
  if(self.var_DDBE.size < 4) {
    var_04 = spawnStruct();
    self.var_DDBE[self.var_DDBE.size] = var_04;
  } else {
    for(var_05 = 0; var_05 < 3; var_05++) {
      self.var_DDBE[var_05] = self.var_DDBE[var_05 + 1];
    }

    var_04 = spawnStruct();
    self.var_DDBE[self.var_DDBE.size - 1] = var_04;
  }

  if(param_03 == "MOD_MELEE" && param_02 == "head") {
    param_02 = "torso_upper";
  }

  var_04.var_DA = int(min(param_00, self.health));
  var_04.var_4F = param_01;
  var_04.location = param_02;
}

func_41D5() {
  self.var_DDBE = [];
}

updatedeathdetails(param_00, param_01) {
  var_02 = 0;
  if(isDefined(param_00) && isDefined(param_01)) {
    foreach(var_06, var_04 in param_00) {
      if(!isplayer(var_04)) {
        continue;
      }

      var_05 = var_04 getentitynumber();
      self setclientomnvar("ui_death_details_attacker_" + var_02, var_05);
      self setclientomnvar("ui_death_details_hits_" + var_02, int(min(param_01[var_06].hits, 10)));
      var_02++;
      if(var_02 >= 4) {
        break;
      }
    }
  }

  for(var_07 = var_02; var_07 < 4; var_07++) {
    self setclientomnvar("ui_death_details_attacker_" + var_07, -1);
  }
}

getindexfromhitloc(param_00) {
  switch (param_00) {
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

updatecombatrecordkillstats(param_00, param_01, param_02, param_03) {
  if(!scripts\mp\utility::canrecordcombatrecordstats()) {
    return;
  }

  if(isDefined(param_00) && isplayer(param_00)) {
    param_00 combatrecordarchetypekill(param_00.loadoutarchetype);
    if(isDefined(param_03)) {
      var_04 = scripts\mp\utility::getequipmenttype(param_03);
      if(isDefined(var_04) && var_04 == "lethal") {
        var_05 = scripts\mp\powers::func_D737(param_03);
        param_00 combatrecordlethalkill(var_05);
      } else {
        var_06 = scripts\mp\missions::func_7F48(param_03);
        if(isDefined(var_06)) {
          if(isenumvaluevalid("mp", "LethalScorestreakStatItems", var_06)) {
            param_00 combatrecordkillstreakstat(var_06);
          }
        }

        if(scripts\mp\utility::istrue(param_00.personalradaractive)) {
          param_00 combatrecordtacticalstat("power_periphVis");
        }

        if(scripts\mp\utility::istrue(param_00.var_8BC2)) {
          param_00 combatrecordtacticalstat("power_adrenaline");
        }
      }
    }
  }

  if(isDefined(param_01) && isplayer(param_01)) {
    param_01 combatrecordarchetypedeath(param_01.loadoutarchetype);
  }
}

combatrecordarchetypekill(param_00) {
  if(!scripts\mp\utility::canrecordcombatrecordstats()) {
    return;
  }

  var_01 = self getplayerdata("mp", "archetypeStats", param_00, "kills");
  self setplayerdata("mp", "archetypeStats", param_00, "kills", var_01 + 1);
}

combatrecordarchetypedeath(param_00) {
  if(!scripts\mp\utility::canrecordcombatrecordstats()) {
    return;
  }

  var_01 = self getplayerdata("mp", "archetypeStats", param_00, "deaths");
  self setplayerdata("mp", "archetypeStats", param_00, "deaths", var_01 + 1);
}

combatrecordlethalkill(param_00) {
  if(!scripts\mp\utility::canrecordcombatrecordstats()) {
    return;
  }

  var_01 = self getplayerdata("mp", "lethalStats", param_00, "kills");
  self setplayerdata("mp", "lethalStats", param_00, "kills", var_01 + 1);
}

combatrecordtacticalstat(param_00, param_01) {
  if(!scripts\mp\utility::canrecordcombatrecordstats()) {
    return;
  }

  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  var_02 = self getplayerdata("mp", "tacticalStats", param_00, "extraStat1");
  self setplayerdata("mp", "tacticalStats", param_00, "extraStat1", var_02 + param_01);
}

combatrecordkillstreakstat(param_00) {
  if(!scripts\mp\utility::canrecordcombatrecordstats()) {
    return;
  }

  var_01 = scripts\mp\utility::getstreakrecordtype(param_00);
  if(!isDefined(var_01)) {
    return;
  }

  var_02 = self getplayerdata("mp", var_01, param_00, "extraStat1");
  self setplayerdata("mp", var_01, param_00, "extraStat1", var_02 + 1);
}

enqueuecorpsetablefunc(param_00, param_01) {
  if(!isDefined(self.corpsetablefuncs)) {
    self.corpsetablefuncs = [];
    self.corpsetablefunccounts = [];
  }

  if(!isDefined(self.corpsetablefuncs[param_00])) {
    self.corpsetablefuncs[param_00] = param_01;
    self.corpsetablefunccounts[param_00] = 0;
  }

  self.corpsetablefunccounts[param_00]++;
}

dequeuecorpsetablefunc(param_00) {
  if(!isDefined(self.corpsetablefuncs)) {
    return;
  }

  if(!isDefined(self.corpsetablefuncs[param_00])) {
    return;
  }

  self.corpsetablefunccounts[param_00]--;
  if(self.corpsetablefunccounts[param_00] <= 0) {
    self.corpsetablefuncs[param_00] = undefined;
    self.corpsetablefunccounts[param_00] = undefined;
  }
}

callcorpsetablefuncs() {
  if(!isDefined(self.corpsetablefuncs)) {
    return;
  }

  var_00 = self.body;
  foreach(var_02 in self.corpsetablefuncs) {
    self thread[[var_02]](var_00);
  }

  thread clearcorpsetablefuncs();
}

clearcorpsetablefuncs() {
  self notify("clearCorpsetableFuncs");
  self.corpsetablefuncs = undefined;
  self.corpsetablefunccounts = undefined;
}

enqueueweapononkillcorpsetablefuncs(param_00, param_01, param_02, param_03, param_04) {
  if(scripts\mp\weapons::isprimaryweapon(param_03)) {
    var_05 = scripts\mp\utility::getweaponrootname(param_03);
    var_06 = getweaponvariantindex(param_03);
    var_07 = param_00 _meth_8519(param_03);
    if(var_05 == "iw7_rvn" && scripts\mp\utility::istrue(var_07) && param_04 == "MOD_MELEE") {
      param_01 thread enqueuecorpsetablefunc("passive_melee_cone_expl", ::scripts\mp\perks\_weaponpassives::meleeconeexplodevictimcorpsefx);
    }
  }
}