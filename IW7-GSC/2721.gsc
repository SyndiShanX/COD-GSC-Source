/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2721.gsc
***************************************/

domeshield_init() {
  level.var_590F = [];
}

func_5910(var_0) {
  var_0 endon("death");
  var_0 thread domeshield_deleteondisowned(self);
  var_0 waittill("missile_stuck", var_1);
  var_0 missilethermal();
  var_0 missileoutline();
  scripts\mp\utility\game::_launchgrenade("domeshield_plant_mp", var_0.origin, (0, 0, 0), 100, 1, var_0);

  if(isDefined(var_1)) {
    var_0 linkto(var_1);
  }

  var_2 = domeshield_getplacementinfo(self, var_0.origin);

  if(var_2.var_38EE) {
    thread func_590C(var_0, var_1, var_2);
  } else {
    scripts\mp\hud_message::showerrormessage("MP_CANNOT_PLACE_DOMESHIELD");
    scripts\mp\powers::func_D74C("power_domeshield");
    var_0 delete();
  }
}

func_590C(var_0, var_1, var_2) {
  foreach(var_4 in var_2.var_C7FC) {
    var_4 domeshield_awardpoints(self);
    var_4 domeshield_givedamagefeedback(self);
    var_4 thread domeshield_destroy(1);
  }

  if(!isDefined(self.var_590F)) {
    self.var_590F = [];
  }

  if(self.var_590F.size + 1 > domeshield_getmax()) {
    self.var_590F[0] thread domeshield_destroy(0);
  }

  var_0 setotherent(self);
  var_0 give_player_tickets(1);
  var_6 = spawn("script_model", var_0.origin);
  var_6.angles = var_0.angles;
  var_6 setotherent(self);
  var_6 setModel("prop_mp_domeshield_col");
  var_6 setnonstick(1);
  var_6 give_player_tickets(1);
  var_6 linkto(var_0);
  var_6.var_2B0E = 1;
  var_6.owner = self;
  var_6.var_7734 = var_0;
  var_6 thread domeshield_cleanuponparentdeath(var_0);
  var_0.var_58EF = var_6;
  var_7 = scripts\mp\utility\game::_hasperk("specialty_rugged_eqp");

  if(var_7) {
    var_0.hasruggedeqp = 1;
    var_6.hasruggedeqp = 1;
  }

  var_8 = scripts\engine\utility::ter_op(scripts\mp\utility\game::istrue(var_7), "hitequip", "");
  var_9 = scripts\engine\utility::ter_op(scripts\mp\utility\game::istrue(var_7), 150, 100);
  var_0 thread scripts\mp\damage::monitordamage(var_9, var_8, ::domeshield_handledamagefatal, ::domeshield_handledamage, 0);
  var_9 = scripts\engine\utility::ter_op(scripts\mp\utility\game::istrue(var_7), 600, 450);
  var_6 thread scripts\mp\damage::monitordamage(var_9, var_8, ::domeshield_domehandledamagefatal, ::domeshield_domehandledamage, 0);
  var_0 thread domeshield_destroyonemp();
  var_0 thread domeshield_destroyontimeout();
  var_0 thread domeshield_destroyongameend();
  var_0 thread domeshield_deploysequence();
  var_0 thread scripts\mp\perks\perk_equipmentping::runequipmentping(var_6);
  thread scripts\mp\weapons::outlineequipmentforowner(var_0, self);
  domeshield_addtoarrays(var_0, self);
}

domeshield_deploysequence() {
  self endon("death");
  domeshield_setstate(1);
  wait 0.5;
  domeshield_setstate(2);
}

domeshield_destroy(var_0) {
  thread domeshield_delete(1.6);

  if(var_0) {
    domeshield_setstate(3);
  } else {
    domeshield_setstate(4);
  }

  wait 1.5;
  domeshield_setstate(5);
}

domeshield_delete(var_0) {
  self notify("death");
  self setCanDamage(0);
  self.exploding = 1;
  thread domeshield_removefromarrays(self, self.owner, self getentitynumber());

  if(isDefined(self.var_58EF)) {
    self.var_58EF delete();
  }

  if(isDefined(var_0)) {
    wait(var_0);
  }

  self delete();
}

domeshield_handledamage(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3;
  var_5 = scripts\mp\damage::handlemeleedamage(var_1, var_2, var_5);
  var_5 = scripts\mp\damage::handleapdamage(var_1, var_2, var_5);
  scripts\mp\powers::equipmenthit(self.owner, var_0, var_1, var_2);
  return var_5;
}

domeshield_handledamagefatal(var_0, var_1, var_2, var_3, var_4) {
  domeshield_awardpoints(var_0);

  if(isDefined(var_0) && isplayer(var_0) && isDefined(var_2) && scripts\engine\utility::isbulletdamage(var_2) && var_0 != self.owner) {
    var_0 scripts\mp\missions::func_D991("ch_dome_kill");
  }

  thread domeshield_destroy(1);
}

domeshield_domehandledamage(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "MOD_MELEE") {
    var_3 = 0;
  } else {
    var_3 = scripts\mp\damage::handleshotgundamage(var_1, var_2, var_3);
    var_3 = scripts\mp\damage::handleapdamage(var_1, var_2, var_3);
    var_3 = domeshield_domehandlesuperdamage(var_1, var_2, var_3);
  }

  if(var_3 > 0) {
    self.owner scripts\mp\missions::func_D991("ch_tactical_domeshield", var_3);
  }

  self.owner scripts\mp\missions::func_D998(var_0, var_1, self);
  self.owner scripts\mp\damage::combatrecordtacticalstat("power_domeshield", var_3);
  scripts\mp\powers::equipmenthit(self.owner, var_0, var_1, var_2);
  return var_3;
}

domeshield_domehandledamagefatal(var_0, var_1, var_2, var_3, var_4) {
  self.var_7734 thread domeshield_handledamagefatal(var_0, var_1, var_2, var_3, var_4);
}

domeshield_domehandlesuperdamage(var_0, var_1, var_2) {
  var_3 = 1;
  var_4 = getweaponbasename(var_0);

  if(isDefined(var_4)) {
    var_0 = var_4;
  }

  switch (var_0) {
    case "micro_turret_gun_mp":
      var_3 = 3.75;
      break;
    case "iw7_penetrationrail_mp":
      var_3 = 1.75;
      break;
    case "iw7_atomizer_mp":
      var_3 = 1.75;
      break;
  }

  return int(ceil(var_3 * var_2));
}

domeshield_destroyonemp() {
  self endon("death");
  self waittill("emp_damage", var_0, var_1, var_2, var_3, var_4);

  if(isDefined(var_3) && var_3 == "emp_grenade_mp") {
    if(scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(self.owner, var_0))) {
      var_0 scripts\mp\missions::func_D991("ch_tactical_emp_eqp");
    }
  }

  domeshield_awardpoints(var_0);
  domeshield_givedamagefeedback(var_0);
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

domeshield_deleteondisowned(var_0) {
  self endon("death");
  var_0 scripts\engine\utility::waittill_any("joined_team", "joined_spectators", "disconnect");
  thread domeshield_removefromarrays(self, self.owner, self getentitynumber());

  if(isDefined(self.var_58EF)) {
    self.var_58EF delete();
  }

  self delete();
}

domeshield_getplacementinfo(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.var_38EE = 1;
  var_2.var_C7FC = [];
  var_3 = var_0.team;
  var_4 = _pow(175, 2);

  foreach(var_6 in level.var_590F) {
    if(!isDefined(var_6)) {
      continue;
    }
    var_7 = length2dsquared(var_1 - var_6.origin);

    if(var_7 < var_4) {
      if(isDefined(var_6.owner) && var_6.owner != var_0 && !scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(var_6.owner, var_0))) {
        var_2.var_38EE = 0;
        break;
      }

      var_2.var_C7FC[var_2.var_C7FC.size] = var_6;
    }
  }

  return var_2;
}

domeshield_setstate(var_0) {
  if(!isDefined(self.state)) {
    self.state = -1;
  }

  if(self.state == var_0) {
    return;
  }
  switch (var_0) {
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

domeshield_givedamagefeedback(var_0) {
  var_1 = "";

  if(scripts\mp\utility\game::istrue(self.hasruggedeqp)) {
    var_1 = "hitequip";
  }

  if(isplayer(var_0)) {
    var_0 scripts\mp\damagefeedback::updatedamagefeedback(var_1);
  }
}

domeshield_awardpoints(var_0) {
  if(scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(self.owner, var_0))) {
    var_0 notify("destroyed_equipment");
    var_0 thread scripts\mp\utility\game::giveunifiedpoints("destroyed_equipment");
  }
}

domeshield_getmax() {
  var_0 = 1;

  if(scripts\mp\utility\game::_hasperk("specialty_rugged_eqp")) {
    var_0++;
  }

  return var_0;
}

func_7E80(var_0) {
  if(isDefined(level.var_590F)) {
    var_1 = 14400;

    foreach(var_3 in level.var_590F) {
      if(!isDefined(var_3)) {
        continue;
      }
      if(distancesquared(var_0.origin, var_3.origin) < var_1) {
        return var_3;
      }
    }
  }

  return undefined;
}

isdomeshield() {
  return isDefined(level.var_590F[self getentitynumber()]);
}

domeshield_addtoarrays(var_0, var_1) {
  if(!isDefined(var_1.var_590F)) {
    var_1.var_590F = [];
  }

  var_2 = [];

  foreach(var_4 in var_1.var_590F) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(var_4 == var_0) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  var_2[var_2.size] = var_0;
  var_1.var_590F = var_2;
  var_6 = var_0 getentitynumber();
  level.var_590F[var_6] = var_0;
  thread domeshield_removefromarraysondeath(var_0);
}

domeshield_removefromarrays(var_0, var_1, var_2) {
  var_0 notify("domeShield_removeFromArrays");

  if(isDefined(var_1) && isDefined(var_1.var_590F) && isDefined(var_0)) {
    var_1.var_590F = scripts\engine\utility::array_remove(var_1.var_590F, var_0);
  }

  level.var_590F[var_2] = undefined;
}

domeshield_removefromarraysondeath(var_0) {
  var_0 notify("domeShield_removeFromArraysOnDeath");
  var_0 endon("domeShield_removeFromArraysOnDeath");
  var_0 endon("domeShield_removeFromArrays");
  var_1 = var_0.owner;
  var_2 = var_0 getentitynumber();
  var_0 waittill("death");
  thread domeshield_removefromarrays(var_0, var_1, var_2);
}

domeshield_cleanuponparentdeath(var_0) {
  self endon("death");
  var_0 waittill("death");
  self delete();
}