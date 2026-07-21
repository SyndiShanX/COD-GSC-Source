/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\equipment\flash_grenade.gsc
***********************************************/

onplayerdamaged(var_0) {
  if(var_0.meansofdeath == "_encstr_A1ED0BA9FF84562B60BA073E83")
    return 1;

  var_1 = 0;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  if(var_0.attacker == var_0.victim && !istrue(var_4)) {
    var_2 = distancesquared(var_0.victim.origin, var_0.point);

    if(var_2 > 65536)
      return 0;
    else if(var_2 <= 0)
      var_3 = 0;
    else
      var_3 = sqrt(var_2);
  } else
    var_3 = distance(var_0.victim.origin, var_0.point);

  var_5 = scripts\mp\perks\perkfunctions::_encstr_B15B12C76BA37A7B15788BF2E1E1677258FB684D(var_0.victim);

  if(var_5 == "_encstr_A95E0ADC3AAECDBEC62BDCDC" && var_0.attacker != var_0.victim) {
    var_0.attacker scripts\mp\damagefeedback::updatedamagefeedback("_encstr_8D760DB8F77343CF62BEB7E3D01013", undefined, undefined, undefined, 1);

    if(scripts\cp_mp\utility\player_utility::playersareenemies(var_0.attacker, var_0.victim))
      var_0.victim scripts\cp\vehicles\vehicle_compass_cp::resistedstun(var_0.attacker);

    if(scripts\mp\utility\game::unset_relic_grounded())
      var_0.victim thread applyflash(var_0.attacker, 1.1);
    else
      var_0.victim thread applyflash(var_0.attacker, 3.6);
  } else {
    var_3 = clamp(var_3, 0, 540);
    var_6 = 1 - (var_3 - 0) / 540;
    var_1 = var_1 + floor(var_6 * 65);

    if(scripts\engine\utility::within_fov(var_0.victim.origin, var_0.victim getplayerangles(), var_0.point, 0.5))
      var_1 = var_1 + 35;

    if(!scripts\cp_mp\utility\player_utility::playersareenemies(var_0.attacker, var_0.victim)) {
      if(!istrue(var_4)) {
        if(var_0.attacker == var_0.victim)
          var_1 = var_1 + -30;
        else
          var_1 = var_1 + -30;
      }
    }

    if(var_5 == "_encstr_B46A0A7BD353B5DFD8308DFA" && var_0.attacker != var_0.victim)
      var_1 = var_1 * getdvarfloat("_encstr_82EF1690ED2E0F61F849453D3F715FBE1D7FEEAA727868FB", 1.4);

    var_1 = max(0, var_1);
    var_7 = var_1 / 100;
    var_8 = 4.0 + 2.0 * var_7;
    var_0.victim thread applyflash(var_0.attacker, var_8);
    var_0.attacker scripts\mp\damage::combatrecordtacticalstat("_encstr_BD170C5B689B786221E98009A80C");
    var_0.attacker scripts\mp\utility\stats::incpersstat("_encstr_B8890E42A897E73420FB2E2FC1107BBF", 1);
  }
}

applyflash(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(scripts\mp\utility\player::isusingremote()) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "_encstr_A9B606B0C956B916" || level.gametype == "_encstr_B607038AAB" && var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag())
    var_1 = min(scripts\engine\utility::ter_op(level.tacticaltimemod <= 3, level.tacticaltimemod + 1.5, level.tacticaltimemod), var_1);

  self notify("_encstr_A65A0B6AF8996D97A551012B7B");
  self endon("_encstr_A65A0B6AF8996D97A551012B7B");

  if(!istrue(self.flashbanged)) {
    self.flashbanged = 1;
    scripts\mp\utility\player::hidehudenable();
  }

  scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683", "_encstr_88A906570DDE7B21", var_1, 1);

  if(scripts\cp_mp\utility\player_utility::playersareenemies(self, var_0)) {
    var_0 scripts\cp\vehicles\vehicle_compass_cp::_id_12096("_encstr_BD170C5B689B786221E98009A80C");
    thread scripts\mp\gamescore::trackdebuffassistfortime(var_0, self, "_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683", var_1);
  }

  if(scripts\mp\utility\game::getgametype() == "_encstr_A9B606B0C956B916")
    var_1 = max(0, var_1);
  else
    var_1 = max(0, var_1 - 0.5);

  scripts\engine\utility::waittill_notify_or_timeout("_encstr_AD75063D571AE108", var_1);
  thread clearflash(!scripts\mp\utility\player::isreallyalive(self));
}

clearflash(var_0) {
  self notify("_encstr_A65A0B6AF8996D97A551012B7B");

  if(istrue(self.flashbanged)) {
    if(!istrue(var_0))
      scripts\mp\utility\player::hidehuddisable();
  }

  self.flashbanged = undefined;
}

calculateinterruptdelay(var_0) {
  return max(0, var_0 - 1.5) * 1000;
}