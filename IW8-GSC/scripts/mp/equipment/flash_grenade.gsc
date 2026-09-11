/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\flash_grenade.gsc
**************************************************/

function onplayerdamaged(var_0) {
  if(var_0.meansofdeath == "MOD_IMPACT") {
    return 1;
  }

  var_1 = 0;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  if(var_0.attacker == var_0.victim && !istrue(var_4)) {
    var_2 = distancesquared(var_0.victim.origin, var_0.point);

    if(var_2 > 65536) {
      return 0;
    } else if(var_2 <= 0) {
      var_3 = 0;
    } else {
      var_3 = sqrt(var_2);
    }
  } else {
    var_3 = distance(var_0.victim.origin, var_0.point);
  }

  var_5 = scripts\mp\perks\perkfunctions::getstunscalartype(var_0.victim);

  if(var_5 == "stun_less" && var_0.attacker != var_0.victim) {
    var_0.attacker scripts\mp\damagefeedback::updatedamagefeedback("hittacresist", undefined, undefined, undefined, 1);

    if(scripts\cp_mp\utility\player_utility::playersareenemies(var_0.attacker, var_0.victim)) {
      var_0.victim scripts\cp\vehicles\vehicle_compass_cp::resistedstun(var_0.attacker);
    }

    if(scripts\mp\utility\game::unset_relic_grounded()) {
      thread applyflash(var_0.victim, var_0.attacker);
      return;
    }

    thread applyflash(var_0.victim, var_0.attacker);
    return;
  }

  var_3 = clamp(var_3, 0, 540);
  var_6 = 1 - (var_3 - 0) / 540;
  var_1 += floor(var_6 * 65);

  if(scripts\engine\utility::within_fov(var_0.victim.origin, var_0.victim getplayerangles(), var_0.point, 0.5)) {
    var_1 += 35;
  }

  if(!scripts\cp_mp\utility\player_utility::playersareenemies(var_0.attacker, var_0.victim)) {
    if(!istrue(var_4)) {
      if(var_0.attacker == var_0.victim) {
        var_1 += -30;
      } else {
        var_1 += -30;
      }
    }
  }

  if(var_5 == "stun_more" && var_0.attacker != var_0.victim) {
    var_1 *= getdvarfloat("perk_stun_more_scalar", 1.4);
  }

  var_1 = max(0, var_1);
  var_7 = var_1 / 100;
  var_8 = 4 + 2 * var_7;
  thread applyflash(var_0.victim, var_0.attacker);
  var_0.attacker scripts\mp\damage::combatrecordtacticalstat("equip_flash");
  var_0.attacker scripts\mp\utility\stats::incpersstat("flashbangHits", 1);
  return 1;
}

function applyflash(var_0, var_1) {
  self endon("disconnect");

  if(scripts\mp\utility\player::isusingremote()) {
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "arena" || level.gametype == "br" && var_0 scripts\mp\gametypes\br_public::isplayeringulag()) {
    var_1 = min(scripts\engine\utility::ter_op(level.tacticaltimemod <= 3, level.tacticaltimemod + 1.5, level.tacticaltimemod), var_1);
  }

  self notify("applyFlash");
  self endon("applyFlash");

  if(!istrue(self.flashbanged)) {
    self.flashbanged = 1;
    scripts\mp\utility\player::hidehudenable();
  }

  scripts\cp_mp\utility\shellshock_utility::_shellshock("flash_grenade_mp", "flash", var_1, 1);

  if(scripts\cp_mp\utility\player_utility::playersareenemies(self, var_0)) {
    var_0 scripts\cp\vehicles\vehicle_compass_cp::ref_12096("equip_flash");
    thread scripts\mp\gamescore::trackdebuffassistfortime(var_0, self, "flash_grenade_mp", var_1);
  }

  if(scripts\mp\utility\game::getgametype() == "arena") {
    var_1 = max(0, var_1);
  } else {
    var_1 = max(0, var_1 - 0.5);
  }

  scripts\engine\utility::waittill_notify_or_timeout("death", var_1);
  thread clearflash(!scripts\mp\utility\player::isreallyalive(self));
}

function clearflash(var_0) {
  self notify("applyFlash");

  if(istrue(self.flashbanged)) {
    if(!istrue(var_0)) {
      scripts\mp\utility\player::hidehuddisable();
    }
  }

  self.flashbanged = undefined;
}

function calculateinterruptdelay(var_0) {
  return max(0, var_0 - 1.5) * 1000;
}