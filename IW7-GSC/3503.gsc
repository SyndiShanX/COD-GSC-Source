/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3503.gsc
**************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("mrsiartillery", ::func_12906);
  var_0 = spawnStruct();
  var_0.weaponname = "airdrop_marker_mp";
  var_0.var_DA62 = "mrsiartillery_projectile_mp";
  var_0.var_C244 = 6;
  var_0.var_9831 = 1.0;
  var_0.var_B782 = 0.375;
  var_0.var_B49A = 0.5;
  var_0.var_11141 = 150;

  if(!isDefined(level.var_A692)) {
    level.var_A692 = [];
  }

  level.var_A692["mrsiartillery"] = var_0;
}

func_12906(var_0, var_1) {
  var_2 = level.var_A692["mrsiartillery"];
  var_3 = scripts\mp\killstreaks\designator_grenade::func_526C("mrsiartillery", var_2.weaponname, ::onteamchangedeath);

  if(!isDefined(var_3) || !var_3) {
    return 0;
  } else {
    return 1;
  }
}

onteamchangedeath(var_0, var_1) {
  var_2 = level.var_A692[var_0];
  var_3 = var_1.owner;
  var_4 = var_1.origin;
  var_1 detonate();
  dostrike(var_3, var_0, var_3.origin, var_4);
}

dostrike(var_0, var_1, var_2, var_3) {
  var_4 = level.var_A692[var_1];
  var_5 = var_3 - var_2;
  var_6 = (var_5[0], var_5[1], 0);
  var_5 = vectornormalize(var_5);
  var_7 = var_3;
  var_8 = scripts\mp\killstreaks\killstreaks::findunobstructedfiringpoint(var_0, var_3 + (0, 0, 10), 10000);

  if(isDefined(var_8)) {
    iprintln("Firing Motar!");
    wait(var_4.var_9831);
    wait(randomfloatrange(var_4.var_B782, var_4.var_B49A));
    var_9 = scripts\mp\utility\game::_magicbullet(var_4.var_DA62, var_8, var_7, var_0);

    for(var_10 = 1; var_10 < var_4.var_C244; var_10++) {
      wait(randomfloatrange(var_4.var_B782, var_4.var_B49A));
      var_11 = func_CB2F(var_7, var_4.var_11141);
      var_9 = scripts\mp\utility\game::_magicbullet(var_4.var_DA62, var_8, var_11, var_0);
    }
  } else {
    iprintln("Mortar LOS blocked!");
  }
}

func_CB2F(var_0, var_1) {
  var_2 = randomfloatrange(-1 * var_1, var_1);
  var_3 = randomfloatrange(-1 * var_1, var_1);
  return var_0 + (var_2, var_3, 0);
}