/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2721.gsc
***************************************/

domeshield_init() {
  level.func_590F = [];
}

func_5910(var_00) {
  var_00 endon("death");
  var_00 thread domeshield_deleteondisowned(self);
  var_00 waittill("missile_stuck", var_01);
  var_00 missilethermal();
  var_00 missileoutline();
  scripts\mp\utility\game::_launchgrenade("domeshield_plant_mp", var_0.origin, (0, 0, 0), 100, 1, var_00);

  if(isDefined(var_01)) {
    var_00 linkto(var_01);
  }

  var_02 = domeshield_getplacementinfo(self, var_0.origin);

  if(var_2.func_38EE) {
    thread func_590C(var_00, var_01, var_02);
  } else {
    scripts\mp\hud_message::showerrormessage("MP_CANNOT_PLACE_DOMESHIELD");
    scripts\mp\powers::func_D74C("power_domeshield");
    var_00 delete();
  }
}

func_590C(var_00, var_01, var_02) {
  foreach(var_04 in var_2.func_C7FC) {
    var_04 domeshield_awardpoints(self);
    var_04 domeshield_givedamagefeedback(self);
    var_04 thread domeshield_destroy(1);
  }

  if(!isDefined(self.func_590F)) {
    self.func_590F = [];
  }

  if(self.func_590F.size + 1 > domeshield_getmax()) {
    self.func_590F[0] thread domeshield_destroy(0);
  }

  var_00 setotherent(self);
  var_00 give_player_tickets(1);
  var_06 = spawn("script_model", var_0.origin);
  var_6.angles = var_0.angles;
  var_06 setotherent(self);
  var_06 setModel("prop_mp_domeshield_col");
  var_06 setnonstick(1);
  var_06 give_player_tickets(1);
  var_06 linkto(var_00);
  var_6.func_2B0E = 1;
  var_6.owner = self;
  var_6.func_7734 = var_00;
  var_06 thread domeshield_cleanuponparentdeath(var_00);
  var_0.func_58EF = var_06;
  var_07 = scripts\mp\utility\game::_hasperk("specialty_rugged_eqp");

  if(var_07) {
    var_0.hasruggedeqp = 1;
    var_6.hasruggedeqp = 1;
  }

  var_08 = scripts\engine\utility::ter_op(scripts\mp\utility\game::istrue(var_07), "hitequip", "");
  var_09 = scripts\engine\utility::ter_op(scripts\mp\utility\game::istrue(var_07), 150, 100);
  var_00 thread scripts\mp\damage::monitordamage(var_09, var_08, ::domeshield_handledamagefatal, ::domeshield_handledamage, 0);
  var_09 = scripts\engine\utility::ter_op(scripts\mp\utility\game::istrue(var_07), 600, 450);
  var_06 thread scripts\mp\damage::monitordamage(var_09, var_08, ::domeshield_domehandledamagefatal, ::domeshield_domehandledamage, 0);
  var_00 thread domeshield_destroyonemp();
  var_00 thread domeshield_destroyontimeout();
  var_00 thread domeshield_destroyongameend();
  var_00 thread domeshield_deploysequence();
  var_00 thread scripts\mp\perks\perk_equipmentping::runequipmentping(var_06);
  thread scripts\mp\weapons::outlineequipmentforowner(var_00, self);
  domeshield_addtoarrays(var_00, self);
}

domeshield_deploysequence() {
  self endon("death");
  domeshield_setstate(1);
  wait 0.5;
  domeshield_setstate(2);
}

domeshield_destroy(var_00) {
  thread domeshield_delete(1.6);

  if(var_00) {
    domeshield_setstate(3);
  } else {
    domeshield_setstate(4);
  }

  wait 1.5;
  domeshield_setstate(5);
}

domeshield_delete(var_00) {
  self notify("death");
  self setCanDamage(0);
  self.exploding = 1;
  thread domeshield_removefromarrays(self, self.owner, self getentitynumber());

  if(isDefined(self.func_58EF)) {
    self.func_58EF delete();
  }

  if(isDefined(var_00)) {
    wait(var_00);
  }

  self delete();
}

domeshield_handledamage(var_00, var_01, var_02, var_03, var_04) {
  var_05 = var_03;
  var_05 = scripts\mp\damage::handlemeleedamage(var_01, var_02, var_05);
  var_05 = scripts\mp\damage::handleapdamage(var_01, var_02, var_05);
  scripts\mp\powers::equipmenthit(self.owner, var_00, var_01, var_02);
  return var_05;
}

domeshield_handledamagefatal(var_00, var_01, var_02, var_03, var_04) {
  domeshield_awardpoints(var_00);

  if(isDefined(var_00) && isplayer(var_00) && isDefined(var_02) && scripts\engine\utility::isbulletdamage(var_02) && var_00 != self.owner) {
    var_00 scripts\mp\missions::func_D991("ch_dome_kill");
  }

  thread domeshield_destroy(1);
}

domeshield_domehandledamage(var_00, var_01, var_02, var_03, var_04) {
  if(var_02 == "MOD_MELEE") {
    var_03 = 0;
  } else {
    var_03 = scripts\mp\damage::handleshotgundamage(var_01, var_02, var_03);
    var_03 = scripts\mp\damage::handleapdamage(var_01, var_02, var_03);
    var_03 = domeshield_domehandlesuperdamage(var_01, var_02, var_03);
  }

  if(var_03 > 0) {
    self.owner scripts\mp\missions::func_D991("ch_tactical_domeshield", var_03);
  }

  self.owner scripts\mp\missions::func_D998(var_00, var_01, self);
  self.owner scripts\mp\damage::combatrecordtacticalstat("power_domeshield", var_03);
  scripts\mp\powers::equipmenthit(self.owner, var_00, var_01, var_02);
  return var_03;
}

domeshield_domehandledamagefatal(var_00, var_01, var_02, var_03, var_04) {
  self.func_7734 thread domeshield_handledamagefatal(var_00, var_01, var_02, var_03, var_04);
}

domeshield_domehandlesuperdamage(var_00, var_01, var_02) {
  var_03 = 1;
  var_04 = getweaponbasename(var_00);

  if(isDefined(var_04)) {
    var_00 = var_04;
  }

  switch (var_00) {
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

  return int(ceil(var_03 * var_02));
}

domeshield_destroyonemp() {
  self endon("death");
  self waittill("emp_damage", var_00, var_01, var_02, var_03, var_04);

  if(isDefined(var_03) && var_03 == "emp_grenade_mp") {
    if(scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(self.owner, var_00))) {
      var_00 scripts\mp\missions::func_D991("ch_tactical_emp_eqp");
    }
  }

  domeshield_awardpoints(var_00);
  domeshield_givedamagefeedback(var_00);
  thread domeshield_destroy(1);
}

domeshield_destroyontimeout() {
  self endon("death");
  wait 8;
  thread domeshield_destroy(1);
}

domeshield_destroyongameend() {
  self endon("death");
  level scripts\engine\utility::waittill_any("game_ended", "bro_shot_start");
  thread domeshield_destroy(0);
}

domeshield_deleteondisowned(var_00) {
  self endon("death");
  var_00 scripts\engine\utility::waittill_any("joined_team", "joined_spectators", "disconnect");
  thread domeshield_removefromarrays(self, self.owner, self getentitynumber());

  if(isDefined(self.func_58EF)) {
    self.func_58EF delete();
  }

  self delete();
}

domeshield_getplacementinfo(var_00, var_01) {
  var_02 = spawnStruct();
  var_2.func_38EE = 1;
  var_2.func_C7FC = [];
  var_03 = var_0.team;
  var_04 = _pow(175, 2);

  foreach(var_06 in level.func_590F) {
    if(!isDefined(var_06)) {
      continue;
    }
    var_07 = length2dsquared(var_01 - var_6.origin);

    if(var_07 < var_04) {
      if(isDefined(var_6.owner) && var_6.owner != var_00 && !scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(var_6.owner, var_00))) {
        var_2.func_38EE = 0;
        break;
      }

      var_2.func_C7FC[var_2.func_C7FC.size] = var_06;
    }
  }

  return var_02;
}

domeshield_setstate(var_00) {
  if(!isDefined(self.state)) {
    self.state = -1;
  }

  if(self.state == var_00) {
    return;
  }
  switch (var_00) {
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

domeshield_givedamagefeedback(var_00) {
  var_01 = "";

  if(scripts\mp\utility\game::istrue(self.hasruggedeqp)) {
    var_01 = "hitequip";
  }

  if(isplayer(var_00)) {
    var_00 scripts\mp\damagefeedback::updatedamagefeedback(var_01);
  }
}

domeshield_awardpoints(var_00) {
  if(scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(self.owner, var_00))) {
    var_00 notify("destroyed_equipment");
    var_00 thread scripts\mp\utility\game::giveunifiedpoints("destroyed_equipment");
  }
}

domeshield_getmax() {
  var_00 = 1;

  if(scripts\mp\utility\game::_hasperk("specialty_rugged_eqp")) {
    var_0++;
  }

  return var_00;
}

func_7E80(var_00) {
  if(isDefined(level.func_590F)) {
    var_01 = 14400;

    foreach(var_03 in level.func_590F) {
      if(!isDefined(var_03)) {
        continue;
      }
      if(distancesquared(var_0.origin, var_3.origin) < var_01) {
        return var_03;
      }
    }
  }

  return undefined;
}

isdomeshield() {
  return isDefined(level.func_590F[self getentitynumber()]);
}

domeshield_addtoarrays(var_00, var_01) {
  if(!isDefined(var_1.func_590F)) {
    var_1.func_590F = [];
  }

  var_02 = [];

  foreach(var_04 in var_1.func_590F) {
    if(!isDefined(var_04)) {
      continue;
    }
    if(var_04 == var_00) {
      continue;
    }
    var_2[var_2.size] = var_04;
  }

  var_2[var_2.size] = var_00;
  var_1.func_590F = var_02;
  var_06 = var_00 getentitynumber();
  level.func_590F[var_06] = var_00;
  thread domeshield_removefromarraysondeath(var_00);
}

domeshield_removefromarrays(var_00, var_01, var_02) {
  var_00 notify("domeShield_removeFromArrays");

  if(isDefined(var_01) && isDefined(var_1.func_590F) && isDefined(var_00)) {
    var_1.func_590F = scripts\engine\utility::array_remove(var_1.func_590F, var_00);
  }

  level.func_590F[var_02] = undefined;
}

domeshield_removefromarraysondeath(var_00) {
  var_00 notify("domeShield_removeFromArraysOnDeath");
  var_00 endon("domeShield_removeFromArraysOnDeath");
  var_00 endon("domeShield_removeFromArrays");
  var_01 = var_0.owner;
  var_02 = var_00 getentitynumber();
  var_00 waittill("death");
  thread domeshield_removefromarrays(var_00, var_01, var_02);
}

domeshield_cleanuponparentdeath(var_00) {
  self endon("death");
  var_00 waittill("death");
  self delete();
}