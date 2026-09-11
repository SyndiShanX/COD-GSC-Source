/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\flash_grenade.gsc
**************************************************/

function onplayerdamaged(var0) {
  if(var0.meansofdeath == "MOD_IMPACT") {
    return 1;
  }

  var1 = 0;
  var2 = undefined;
  var3 = undefined;
  var4 = undefined;

  if(var0.attacker == var0.victim && !istrue(var4)) {
    var2 = distancesquared(var0.victim.origin, var0.point);

    if(var2 > 65536) {
      return 0;
    } else if(var2 <= 0) {
      var3 = 0;
    } else {
      var3 = sqrt(var2);
    }
  } else {
    var3 = distance(var0.victim.origin, var0.point);
  }

  var5 = scripts\mp\perks\perkfunctions::getstunscalartype(var0.victim);

  if(var5 == "stun_less" && var0.attacker != var0.victim) {
    var0.attacker scripts\mp\damagefeedback::updatedamagefeedback("hittacresist", undefined, undefined, undefined, 1);

    if(scripts\cp_mp\utility\player_utility::playersareenemies(var0.attacker, var0.victim)) {
      var0.victim scripts\cp\vehicles\vehicle_compass_cp::resistedstun(var0.attacker);
    }

    if(scripts\mp\utility\game::unset_relic_grounded()) {
      thread applyflash(var0.victim, var0.attacker);
      return;
    }

    thread applyflash(var0.victim, var0.attacker);
    return;
  }

  var3 = clamp(var3, 0, 540);
  var6 = 1 - (var3 - 0) / 540;
  var1 += floor(var6 * 65);

  if(scripts\engine\utility::within_fov(var0.victim.origin, var0.victim getplayerangles(), var0.point, 0.5)) {
    var1 += 35;
  }

  if(!scripts\cp_mp\utility\player_utility::playersareenemies(var0.attacker, var0.victim)) {
    if(!istrue(var4)) {
      if(var0.attacker == var0.victim) {
        var1 += -30;
      } else {
        var1 += -30;
      }
    }
  }

  if(var5 == "stun_more" && var0.attacker != var0.victim) {
    var1 *= getdvarfloat("perk_stun_more_scalar", 1.4);
  }

  var1 = max(0, var1);
  var7 = var1 / 100;
  var8 = 4 + 2 * var7;
  thread applyflash(var0.victim, var0.attacker);
  var0.attacker scripts\mp\damage::combatrecordtacticalstat("equip_flash");
  var0.attacker scripts\mp\utility\stats::incpersstat("flashbangHits", 1);
  return 1;
}

function applyflash(var0, var1) {
  self endon("disconnect");

  if(scripts\mp\utility\player::isusingremote()) {
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "arena" || level.gametype == "br" && var0 scripts\mp\gametypes\br_public::isplayeringulag()) {
    var1 = min(scripts\engine\utility::ter_op(level.tacticaltimemod <= 3, level.tacticaltimemod + 1.5, level.tacticaltimemod), var1);
  }

  self notify("applyFlash");
  self endon("applyFlash");

  if(!istrue(self.flashbanged)) {
    self.flashbanged = 1;
    scripts\mp\utility\player::hidehudenable();
  }

  scripts\cp_mp\utility\shellshock_utility::_shellshock("flash_grenade_mp", "flash", var1, 1);

  if(scripts\cp_mp\utility\player_utility::playersareenemies(self, var0)) {
    var0 scripts\cp\vehicles\vehicle_compass_cp::ref_12096("equip_flash");
    thread scripts\mp\gamescore::trackdebuffassistfortime(var0, self, "flash_grenade_mp", var1);
  }

  if(scripts\mp\utility\game::getgametype() == "arena") {
    var1 = max(0, var1);
  } else {
    var1 = max(0, var1 - 0.5);
  }

  scripts\engine\utility::waittill_notify_or_timeout("death", var1);
  thread clearflash(!scripts\mp\utility\player::isreallyalive(self));
}

function clearflash(var0) {
  self notify("applyFlash");

  if(istrue(self.flashbanged)) {
    if(!istrue(var0)) {
      scripts\mp\utility\player::hidehuddisable();
    }
  }

  self.flashbanged = undefined;
}

function calculateinterruptdelay(var0) {
  return max(0, var0 - 1.5) * 1000;
}