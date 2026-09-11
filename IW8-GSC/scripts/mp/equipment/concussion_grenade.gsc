/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\concussion_grenade.gsc
*******************************************************/

function ref_12031(var0, var1) {
  if(!isDefined(var0) || !isDefined(var1)) {
    return;
  }

  foreach(var3 in level.mines) {
    if(!isDefined(var3.equipmentref) || var3.equipmentref != "equip_claymore") {
      continue;
    }

    if(!isDefined(var3.owner) || !scripts\cp_mp\utility\player_utility::playersareenemies(var0, var3.owner)) {
      continue;
    }

    if(distancesquared(var1, var3.origin) < 262144) {
      var3 thread scripts\mp\equipment\claymore::handle_set_respawn_overrides(var0);
    }
  }
}

function onplayerdamaged(var0) {
  var1 = var0.victim;
  var2 = var0.attacker;
  var3 = var0.point;

  if(var0.meansofdeath == "MOD_IMPACT") {
    return true;
  }

  if(var2 == var1 && distancesquared(var3, var1.origin) > 65536) {
    return false;
  }

  if(!isDefined(var0.inflictor)) {
    return false;
  }

  thread applyconcussion(var1, var0.inflictor);
  var2 scripts\mp\damage::combatrecordtacticalstat("equip_concussion");
  var2 scripts\mp\utility\stats::incpersstat("stunHits", 1);
  return true;
}

function applyconcussion(var0, var1) {
  if(scripts\mp\utility\player::isusingremote()) {
    return;
  }

  if(istrue(self.hoopty_initomnvars)) {
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "arena" || level.gametype == "br" && var1 scripts\mp\gametypes\br_public::isplayeringulag()) {
    var2 = level.tacticaltimemod;
    var3 = level.tacticaltimemod;
  } else {
    var2 = 3;
    var3 = 3;
  }

  var4 = self == var3;

  if(var4) {
    if(scripts\mp\utility\game::getgametype() == "arena" || level.gametype == "br" && var3 scripts\mp\gametypes\br_public::isplayeringulag()) {
      var2 = max(level.tacticaltimemod - 1, 0.5);
      var3 = max(level.tacticaltimemod - 1, 0.5);
    } else {
      var2 = 2;
      var3 = 2;
    }
  }

  var5 = 1 - distance(self.origin, var2.origin) / 512;

  if(var5 < 0) {
    var5 = 0;
  }

  if(scripts\mp\utility\game::getgametype() == "arena") {
    var6 = var2;
  } else {
    var6 = var3 + var4 * var6;
  }

  var7 = scripts\mp\utility\game::unset_relic_grounded();

  if(var7) {
    var6 *= getdvarfloat("scr_br_stunscalar", 0.75);
  }

  var6 = scripts\mp\perks\perkfunctions::applystunresistence(var2, self, var6);
  var2 scripts\cp\vehicles\vehicle_compass_cp::ref_12096("equip_concussion");
  thread scripts\mp\gamescore::trackdebuffassistfortime(var2, self, "concussion_grenade_mp", var6);
  var2 notify("stun_hit");
  self notify("concussed", var2);
  scripts\mp\weapons::setplayerstunned();
  thread scripts\mp\weapons::cleanupconcussionstun(var6);
  scripts\cp_mp\utility\shellshock_utility::_shellshock("concussion_grenade_mp", "stun", var6, 1);
}

function calculateinterruptdelay(var0) {
  return max(0, var0 - 2.6) * 1000;
}