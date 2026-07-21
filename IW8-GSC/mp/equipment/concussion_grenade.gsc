/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\equipment\concussion_grenade.gsc
***********************************************/

_id_12031(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  foreach(var_3 in level.mines) {
    if(!isDefined(var_3.equipmentref) || var_3.equipmentref != "_encstr_82A70F2B3B73E33B472371FF21D7809DDF") {
      continue;
    }
    if(!isDefined(var_3.owner) || !scripts\cp_mp\utility\player_utility::playersareenemies(var_0, var_3.owner)) {
      continue;
    }
    if(distancesquared(var_1, var_3.origin) < 262144)
      var_3 thread scripts\mp\equipment\claymore::handle_set_respawn_overrides(var_0);
  }
}

onplayerdamaged(var_0) {
  var_1 = var_0.victim;
  var_2 = var_0.attacker;
  var_3 = var_0.point;

  if(var_0.meansofdeath == "_encstr_A1ED0BA9FF84562B60BA073E83")
    return 1;

  if(var_2 == var_1 && distancesquared(var_3, var_1.origin) > 65536)
    return 0;

  if(!isDefined(var_0.inflictor))
    return 0;

  var_1 thread applyconcussion(var_0.inflictor, var_2);
  var_2 scripts\mp\damage::combatrecordtacticalstat("_encstr_AD0B110A20CB30F897F120B0BBDB76DBE8D81E");
  var_2 scripts\mp\utility\stats::incpersstat("_encstr_AA78094E598593A3674B2B", 1);
  return 1;
}

applyconcussion(var_0, var_1) {
  if(scripts\mp\utility\player::isusingremote()) {
    return;
  }
  if(istrue(self.hoopty_initomnvars)) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "_encstr_A9B606B0C956B916" || level.gametype == "_encstr_B607038AAB" && var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag()) {
    var_2 = level.tacticaltimemod;
    var_3 = level.tacticaltimemod;
  } else {
    var_2 = 3;
    var_3 = 3;
  }

  var_4 = self == var_1;

  if(var_4) {
    if(scripts\mp\utility\game::getgametype() == "_encstr_A9B606B0C956B916" || level.gametype == "_encstr_B607038AAB" && var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag()) {
      var_2 = max(level.tacticaltimemod - 1, 0.5);
      var_3 = max(level.tacticaltimemod - 1, 0.5);
    } else {
      var_2 = 2;
      var_3 = 2;
    }
  }

  var_5 = 1 - distance(self.origin, var_0.origin) / 512;

  if(var_5 < 0)
    var_5 = 0;

  if(scripts\mp\utility\game::getgametype() == "_encstr_A9B606B0C956B916")
    var_6 = var_2;
  else
    var_6 = var_2 + var_3 * var_5;

  var_7 = scripts\mp\utility\game::unset_relic_grounded();

  if(var_7)
    var_6 = var_6 * getdvarfloat("_encstr_B41D129B8D93BE13C9D79BD157E6DCD8581B2C4E", 0.75);

  var_6 = scripts\mp\perks\perkfunctions::applystunresistence(var_1, self, var_6);
  var_1 scripts\cp\vehicles\vehicle_compass_cp::_id_12096("_encstr_AD0B110A20CB30F897F120B0BBDB76DBE8D81E");
  thread scripts\mp\gamescore::trackdebuffassistfortime(var_1, self, "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B", var_6);
  var_1 notify("_encstr_931A09C264736B36580A55");
  self notify("_encstr_83F70A36ED73D8AECD37B223", var_1);
  scripts\mp\weapons::setplayerstunned();
  thread scripts\mp\weapons::cleanupconcussionstun(var_6);
  scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B", "_encstr_9B1905D3B92BF0", var_6, 1);
}

calculateinterruptdelay(var_0) {
  return max(0, var_0 - 2.6) * 1000;
}