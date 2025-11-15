/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3503.gsc
***************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("mrsiartillery", ::func_12906);
  var_00 = spawnStruct();
  var_0.weaponname = "airdrop_marker_mp";
  var_0.func_DA62 = "mrsiartillery_projectile_mp";
  var_0.func_C244 = 6;
  var_0.func_9831 = 1.0;
  var_0.func_B782 = 0.375;
  var_0.func_B49A = 0.5;
  var_0.func_11141 = 150;

  if(!isDefined(level.func_A692))
    level.func_A692 = [];

  level.func_A692["mrsiartillery"] = var_00;
}

func_12906(var_00, var_01) {
  var_02 = level.func_A692["mrsiartillery"];
  var_03 = scripts\mp\killstreaks\designator_grenade::func_526C("mrsiartillery", var_2.weaponname, ::onteamchangedeath);

  if(!isDefined(var_03) || !var_03)
    return 0;
  else
    return 1;
}

onteamchangedeath(var_00, var_01) {
  var_02 = level.func_A692[var_00];
  var_03 = var_1.owner;
  var_04 = var_1.origin;
  var_01 detonate();
  dostrike(var_03, var_00, var_3.origin, var_04);
}

dostrike(var_00, var_01, var_02, var_03) {
  var_04 = level.func_A692[var_01];
  var_05 = var_03 - var_02;
  var_06 = (var_5[0], var_5[1], 0);
  var_05 = vectornormalize(var_05);
  var_07 = var_03;
  var_08 = scripts\mp\killstreaks\killstreaks::findunobstructedfiringpoint(var_00, var_03 + (0, 0, 10), 10000);

  if(isDefined(var_08)) {
    iprintln("Firing Motar!");
    wait(var_4.func_9831);
    wait(randomfloatrange(var_4.func_B782, var_4.func_B49A));
    var_09 = scripts\mp\utility\game::_magicbullet(var_4.func_DA62, var_08, var_07, var_00);

    for(var_10 = 1; var_10 < var_4.func_C244; var_10++) {
      wait(randomfloatrange(var_4.func_B782, var_4.func_B49A));
      var_11 = func_CB2F(var_07, var_4.func_11141);
      var_09 = scripts\mp\utility\game::_magicbullet(var_4.func_DA62, var_08, var_11, var_00);
    }
  } else
    iprintln("Mortar LOS blocked!");
}

func_CB2F(var_00, var_01) {
  var_02 = randomfloatrange(-1 * var_01, var_01);
  var_03 = randomfloatrange(-1 * var_01, var_01);
  return var_00 + (var_02, var_03, 0);
}