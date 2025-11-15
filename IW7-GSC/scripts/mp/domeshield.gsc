/*************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\domeshield.gsc
*************************************/

domeshield_init() {
  level.var_590F = [];
}

func_5910(param_00) {
  param_00 endon("death");
  param_00 thread domeshield_deleteondisowned(self);
  param_00 waittill("missile_stuck", var_01);
  param_00 missilethermal();
  param_00 missileoutline();
  scripts\mp\utility::_launchgrenade("domeshield_plant_mp", param_00.origin, (0, 0, 0), 100, 1, param_00);
  if(isDefined(var_01)) {
    param_00 linkto(var_01);
  }

  var_02 = domeshield_getplacementinfo(self, param_00.origin);
  if(var_02.var_38EE) {
    thread func_590C(param_00, var_01, var_02);
    return;
  }

  scripts\mp\hud_message::showerrormessage("MP_CANNOT_PLACE_DOMESHIELD");
  scripts\mp\powers::func_D74C("power_domeshield");
  param_00 delete();
}

func_590C(param_00, param_01, param_02) {
  foreach(var_04 in param_02.var_C7FC) {
    var_04 domeshield_awardpoints(self);
    var_04 domeshield_givedamagefeedback(self);
    var_04 thread domeshield_destroy(1);
  }

  if(!isDefined(self.var_590F)) {
    self.var_590F = [];
  }

  if(self.var_590F.size + 1 > domeshield_getmax()) {
    self.var_590F[0] thread domeshield_destroy(0);
  }

  param_00 setotherent(self);
  param_00 give_player_tickets(1);
  var_06 = spawn("script_model", param_00.origin);
  var_06.angles = param_00.angles;
  var_06 setotherent(self);
  var_06 setModel("prop_mp_domeshield_col");
  var_06 setnonstick(1);
  var_06 give_player_tickets(1);
  var_06 linkto(param_00);
  var_06.var_2B0E = 1;
  var_06.triggerportableradarping = self;
  var_06.var_7734 = param_00;
  var_06 thread domeshield_cleanuponparentdeath(param_00);
  param_00.var_58EF = var_06;
  var_07 = scripts\mp\utility::_hasperk("specialty_rugged_eqp");
  if(var_07) {
    param_00.hasruggedeqp = 1;
    var_06.hasruggedeqp = 1;
  }

  var_08 = scripts\engine\utility::ter_op(scripts\mp\utility::istrue(var_07), "hitequip", "");
  var_09 = scripts\engine\utility::ter_op(scripts\mp\utility::istrue(var_07), 150, 100);
  param_00 thread scripts\mp\damage::monitordamage(var_09, var_08, ::domeshield_handledamagefatal, ::domeshield_handledamage, 0);
  var_09 = scripts\engine\utility::ter_op(scripts\mp\utility::istrue(var_07), 600, 450);
  var_06 thread scripts\mp\damage::monitordamage(var_09, var_08, ::domeshield_domehandledamagefatal, ::domeshield_domehandledamage, 0);
  param_00 thread domeshield_destroyonemp();
  param_00 thread domeshield_destroyontimeout();
  param_00 thread domeshield_destroyongameend();
  param_00 thread domeshield_deploysequence();
  param_00 thread scripts\mp\perks\_perk_equipmentping::runequipmentping(var_06);
  thread scripts\mp\weapons::outlineequipmentforowner(param_00, self);
  domeshield_addtoarrays(param_00, self);
}

domeshield_deploysequence() {
  self endon("death");
  domeshield_setstate(1);
  wait(0.5);
  domeshield_setstate(2);
}

domeshield_destroy(param_00) {
  thread domeshield_delete(1.6);
  if(param_00) {
    domeshield_setstate(3);
  } else {
    domeshield_setstate(4);
  }

  wait(1.5);
  domeshield_setstate(5);
}

domeshield_delete(param_00) {
  self notify("death");
  self setCanDamage(0);
  self.exploding = 1;
  thread domeshield_removefromarrays(self, self.triggerportableradarping, self getentitynumber());
  if(isDefined(self.var_58EF)) {
    self.var_58EF delete();
  }

  if(isDefined(param_00)) {
    wait(param_00);
  }

  self delete();
}

domeshield_handledamage(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_03;
  var_05 = scripts\mp\damage::handlemeleedamage(param_01, param_02, var_05);
  var_05 = scripts\mp\damage::handleapdamage(param_01, param_02, var_05);
  scripts\mp\powers::equipmenthit(self.triggerportableradarping, param_00, param_01, param_02);
  return var_05;
}

domeshield_handledamagefatal(param_00, param_01, param_02, param_03, param_04) {
  domeshield_awardpoints(param_00);
  if(isDefined(param_00) && isplayer(param_00) && isDefined(param_02) && scripts\engine\utility::isbulletdamage(param_02) && param_00 != self.triggerportableradarping) {
    param_00 scripts\mp\missions::func_D991("ch_dome_kill");
  }

  thread domeshield_destroy(1);
}

domeshield_domehandledamage(param_00, param_01, param_02, param_03, param_04) {
  if(param_02 == "MOD_MELEE") {
    param_03 = 0;
  } else {
    param_03 = scripts\mp\damage::handleshotgundamage(param_01, param_02, param_03);
    param_03 = scripts\mp\damage::handleapdamage(param_01, param_02, param_03);
    param_03 = domeshield_domehandlesuperdamage(param_01, param_02, param_03);
  }

  if(param_03 > 0) {
    self.triggerportableradarping scripts\mp\missions::func_D991("ch_tactical_domeshield", param_03);
  }

  self.triggerportableradarping scripts\mp\missions::func_D998(param_00, param_01, self);
  self.triggerportableradarping scripts\mp\damage::combatrecordtacticalstat("power_domeshield", param_03);
  scripts\mp\powers::equipmenthit(self.triggerportableradarping, param_00, param_01, param_02);
  return param_03;
}

domeshield_domehandledamagefatal(param_00, param_01, param_02, param_03, param_04) {
  self.var_7734 thread domeshield_handledamagefatal(param_00, param_01, param_02, param_03, param_04);
}

domeshield_domehandlesuperdamage(param_00, param_01, param_02) {
  var_03 = 1;
  var_04 = getweaponbasename(param_00);
  if(isDefined(var_04)) {
    param_00 = var_04;
  }

  switch (param_00) {
    case "micro_turret_gun_mp":
      var_03 = 3.75;
      break;

    case "iw7_penetrationrail_mp":
      var_03 = 1.75;
      break;

    case "iw7_atomizer_mp":
      var_03 = 1.75;
      break;
  }

  return int(ceil(var_03 * param_02));
}

domeshield_destroyonemp() {
  self endon("death");
  self waittill("emp_damage", var_00, var_01, var_02, var_03, var_04);
  if(isDefined(var_03) && var_03 == "emp_grenade_mp") {
    if(scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, var_00))) {
      var_00 scripts\mp\missions::func_D991("ch_tactical_emp_eqp");
    }
  }

  domeshield_awardpoints(var_00);
  domeshield_givedamagefeedback(var_00);
  thread domeshield_destroy(1);
}

domeshield_destroyontimeout() {
  self endon("death");
  wait(8);
  thread domeshield_destroy(1);
}

domeshield_destroyongameend() {
  self endon("death");
  level scripts\engine\utility::waittill_any_3("game_ended", "bro_shot_start");
  thread domeshield_destroy(0);
}

domeshield_deleteondisowned(param_00) {
  self endon("death");
  param_00 scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators", "disconnect");
  thread domeshield_removefromarrays(self, self.triggerportableradarping, self getentitynumber());
  if(isDefined(self.var_58EF)) {
    self.var_58EF delete();
  }

  self delete();
}

domeshield_getplacementinfo(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.var_38EE = 1;
  var_02.var_C7FC = [];
  var_03 = param_00.team;
  var_04 = pow(175, 2);
  foreach(var_06 in level.var_590F) {
    if(!isDefined(var_06)) {
      continue;
    }

    var_07 = length2dsquared(param_01 - var_06.origin);
    if(var_07 < var_04) {
      if(isDefined(var_06.triggerportableradarping) && var_06.triggerportableradarping != param_00 && !scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(var_06.triggerportableradarping, param_00))) {
        var_02.var_38EE = 0;
        break;
      }

      var_02.var_C7FC[var_02.var_C7FC.size] = var_06;
    }
  }

  return var_02;
}

domeshield_setstate(param_00) {
  if(!isDefined(self.state)) {
    self.state = -1;
  }

  if(self.state == param_00) {
    return;
  }

  switch (param_00) {
    case 1:
      self.state = 1;
      self setscriptablepartstate("plant", "active", 0);
      break;

    case 2:
      self.state = 2;
      self setscriptablepartstate("plant", "neutral", 0);
      self setscriptablepartstate("armed", "active", 0);
      break;

    case 4:
      self.state = 4;
      self setscriptablepartstate("plant", "neutral", 0);
      self setscriptablepartstate("armed", "neutral", 0);
      self setscriptablepartstate("destroy", "activeStart", 0);
      self setscriptablepartstate("domeDestroy", "active", 0);
      break;

    case 3:
      self.state = 3;
      self setscriptablepartstate("plant", "neutral", 0);
      self setscriptablepartstate("armed", "neutral", 0);
      self setscriptablepartstate("destroy", "activeStart", 0);
      self setscriptablepartstate("domeDestroyDamage", "active", 0);
      break;

    case 5:
      self.state = 3;
      self setscriptablepartstate("destroy", "activeEnd", 0);
      break;
  }
}

domeshield_givedamagefeedback(param_00) {
  var_01 = "";
  if(scripts\mp\utility::istrue(self.hasruggedeqp)) {
    var_01 = "hitequip";
  }

  if(isplayer(param_00)) {
    param_00 scripts\mp\damagefeedback::updatedamagefeedback(var_01);
  }
}

domeshield_awardpoints(param_00) {
  if(scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, param_00))) {
    param_00 notify("destroyed_equipment");
    param_00 thread scripts\mp\utility::giveunifiedpoints("destroyed_equipment");
  }
}

domeshield_getmax() {
  var_00 = 1;
  if(scripts\mp\utility::_hasperk("specialty_rugged_eqp")) {
    var_00++;
  }

  return var_00;
}

func_7E80(param_00) {
  if(isDefined(level.var_590F)) {
    var_01 = 14400;
    foreach(var_03 in level.var_590F) {
      if(!isDefined(var_03)) {
        continue;
      }

      if(distancesquared(param_00.origin, var_03.origin) < var_01) {
        return var_03;
      }
    }
  }

  return undefined;
}

isdomeshield() {
  return isDefined(level.var_590F[self getentitynumber()]);
}

domeshield_addtoarrays(param_00, param_01) {
  if(!isDefined(param_01.var_590F)) {
    param_01.var_590F = [];
  }

  var_02 = [];
  foreach(var_04 in param_01.var_590F) {
    if(!isDefined(var_04)) {
      continue;
    }

    if(var_04 == param_00) {
      continue;
    }

    var_02[var_02.size] = var_04;
  }

  var_02[var_02.size] = param_00;
  param_01.var_590F = var_02;
  var_06 = param_00 getentitynumber();
  level.var_590F[var_06] = param_00;
  thread domeshield_removefromarraysondeath(param_00);
}

domeshield_removefromarrays(param_00, param_01, param_02) {
  param_00 notify("domeShield_removeFromArrays");
  if(isDefined(param_01) && isDefined(param_01.var_590F) && isDefined(param_00)) {
    param_01.var_590F = scripts\engine\utility::array_remove(param_01.var_590F, param_00);
  }

  level.var_590F[param_02] = undefined;
}

domeshield_removefromarraysondeath(param_00) {
  param_00 notify("domeShield_removeFromArraysOnDeath");
  param_00 endon("domeShield_removeFromArraysOnDeath");
  param_00 endon("domeShield_removeFromArrays");
  var_01 = param_00.triggerportableradarping;
  var_02 = param_00 getentitynumber();
  param_00 waittill("death");
  thread domeshield_removefromarrays(param_00, var_01, var_02);
}

domeshield_cleanuponparentdeath(param_00) {
  self endon("death");
  param_00 waittill("death");
  self delete();
}