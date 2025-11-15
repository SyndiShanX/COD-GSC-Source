/*****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_mrsiartillery.gsc
*****************************************************/

init() {
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("mrsiartillery", ::func_12906);
  var_00 = spawnStruct();
  var_00.var_39C = "airdrop_marker_mp";
  var_00.var_DA62 = "mrsiartillery_projectile_mp";
  var_00.var_C244 = 6;
  var_00.var_9831 = 1;
  var_00.var_B782 = 0.375;
  var_00.var_B49A = 0.5;
  var_00.var_11141 = 150;
  if(!isDefined(level.var_A692)) {
    level.var_A692 = [];
  }

  level.var_A692["mrsiartillery"] = var_00;
}

func_12906(param_00, param_01) {
  var_02 = level.var_A692["mrsiartillery"];
  var_03 = scripts\mp\killstreaks\_designator_grenade::func_526C("mrsiartillery", var_02.var_39C, ::onteamchangedeath);
  if(!isDefined(var_03) || !var_03) {
    return 0;
  }

  return 1;
}

onteamchangedeath(param_00, param_01) {
  var_02 = level.var_A692[param_00];
  var_03 = param_01.triggerportableradarping;
  var_04 = param_01.origin;
  param_01 detonate();
  dostrike(var_03, param_00, var_03.origin, var_04);
}

dostrike(param_00, param_01, param_02, param_03) {
  var_04 = level.var_A692[param_01];
  var_05 = param_03 - param_02;
  var_06 = (var_05[0], var_05[1], 0);
  var_05 = vectornormalize(var_05);
  var_07 = param_03;
  var_08 = scripts\mp\killstreaks\_killstreaks::findunobstructedfiringpoint(param_00, param_03 + (0, 0, 10), 10000);
  if(isDefined(var_08)) {
    iprintln("Firing Motar!");
    wait(var_04.var_9831);
    wait(randomfloatrange(var_04.var_B782, var_04.var_B49A));
    var_09 = scripts\mp\utility::_magicbullet(var_04.var_DA62, var_08, var_07, param_00);
    for(var_0A = 1; var_0A < var_04.var_C244; var_0A++) {
      wait(randomfloatrange(var_04.var_B782, var_04.var_B49A));
      var_0B = func_CB2F(var_07, var_04.var_11141);
      var_09 = scripts\mp\utility::_magicbullet(var_04.var_DA62, var_08, var_0B, param_00);
    }

    return;
  }

  iprintln("Mortar LOS blocked!");
}

func_CB2F(param_00, param_01) {
  var_02 = randomfloatrange(-1 * param_01, param_01);
  var_03 = randomfloatrange(-1 * param_01, param_01);
  return param_00 + (var_02, var_03, 0);
}