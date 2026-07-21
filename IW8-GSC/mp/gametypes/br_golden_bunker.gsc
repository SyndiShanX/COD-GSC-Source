/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_golden_bunker.gsc
***********************************************/

init() {
  _encstr_A69B105892D75550BD0C91953DA56895D33B();
}

_encstr_A69B105892D75550BD0C91953DA56895D33B() {
  level._encstr_B6080CDA7A20AF9AB0B077AF33EF = [];

  for(var_0 = 1; var_0 <= 7; var_0++) {
    var_1 = getentitylessscriptablearrayinradius("_encstr_8133079685E083B530" + var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_2 = [];
    var_3 = [];

    foreach(var_5 in var_1) {
      if(issubstr(var_5.script_noteworthy, "_encstr_B16705D9AFE22E")) {
        var_2[var_2.size] = var_5;
        continue;
      }

      var_3[var_3.size] = var_5;
    }

    level._encstr_B6080CDA7A20AF9AB0B077AF33EF[level._encstr_B6080CDA7A20AF9AB0B077AF33EF.size] = _encstr_B88811126B95AF3318F72F2499483BCBCA21BB(var_3, var_2);
  }

  scripts\engine\scriptable::_id_12F5B("_encstr_8F420E12BBB5609BDEE7528F70DFD7A9", ::_encstr_A9950BC7755088B793AB9B41A2);
}

_encstr_B88811126B95AF3318F72F2499483BCBCA21BB(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._encstr_AD8308B6562FC10B236E = var_0;
  var_2._encstr_915B0C13438DCFB1EB4C98803287 = var_1;
  return var_2;
}

_encstr_A9950BC7755088B793AB9B41A2(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getdvarint("_encstr_85451CD3673071371838FA92CD786BB388DF7D5A87D084D7BF7682DAABCD", 0) == 1;

  if(var_5 || var_3 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::should_damage_pavelow_boss("_encstr_BD0326BAEE586F152139AA82B06B4A4796DE01220DC687DD29F8313A08A106FBA9A88ABD90E8F7A2")) {
    var_6 = _encstr_8F0518CE591D3BF63623985773B6B29C334E7BB5ADB2F2388591(var_0);
    thread _encstr_92730BE290DB9583ABC89395DE(var_6);
    var_3 scripts\cp\vehicles\vehicle_compass_cp::_id_120A4("_encstr_B11C1447FF403FBF18DE5B52E361B3B97B69FDC673E8");

    if(!var_5)
      var_3 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12BFC();
  }
}

_encstr_8F0518CE591D3BF63623985773B6B29C334E7BB5ADB2F2388591(var_0) {
  foreach(var_2 in level._encstr_B6080CDA7A20AF9AB0B077AF33EF) {
    foreach(var_4 in var_2._encstr_AD8308B6562FC10B236E) {
      if(var_4.index == var_0.index)
        return var_2;
    }
  }
}

_encstr_92730BE290DB9583ABC89395DE(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  foreach(var_2 in var_0._encstr_AD8308B6562FC10B236E)
  var_2 setscriptablepartstate("_encstr_8F420E12BBB5609BDEE7528F70DFD7A9", "_encstr_95E405AEDCCA91");

  wait 2;

  foreach(var_5 in var_0._encstr_915B0C13438DCFB1EB4C98803287)
  var_5 setscriptablepartstate("_encstr_84CE0F5085BFC0501A3B47C5DFF2AA2B4A", "_encstr_ADB405071B8AE8");
}