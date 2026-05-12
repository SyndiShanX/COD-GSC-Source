/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1409.gsc
*********************************************/

lib_0581::func_17FD() {
  lib_054D::func_7BC6(::lib_0581::func_29A5);
  common_scripts\utility::func_092C("tesla blood shock", "vfx/zombie/abilities_perks\zmb_blood_zmb_stun");
  common_scripts\utility::func_092C("tesla_blood_explosion", "vfx/explosion/zmb_tesla_blood_explosion");
  common_scripts\utility::func_092C("tesla_blood_ambience", "vfx/zombie/tesla_guns/zmb_npc_tesla_tube_blood_idle");
}

lib_0581::func_29A5(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  var_0B = self;
  if(!lib_0547::func_5565(param_05, "teslagun_zm_blood")) {
    return;
  }

  if(lib_0547::func_5565(param_04, "MOD_MELEE")) {
    return;
  }

  if(param_02 == lib_0580::func_4382()) {
    return;
  }

  lib_0580::func_98FD(param_00, param_01, var_0B, "j_head", param_04, param_05, ::lib_0581::func_7788, "tesla blood shock");
}

lib_0581::func_3B9D(param_00) {
  var_01 = self;
  playFX(common_scripts\utility::func_44F5("tesla_blood_explosion"), var_01.var_0116 + (0, 0, 24));
  var_02 = maps\mp\gametypes\zombies::func_1E59() * 2;
  lib_0580::func_98E9(var_01.var_0116, lib_0581::func_4184(), param_00.var_721C, undefined, "teslagun_zm_blood", (0.5803922, 0.1921569, 0.3372549), var_02);
  var_01 lib_0378::func_8D74("aud_ww_blood_explode");
}

lib_0581::func_7788(param_00, param_01) {
  var_02 = self;
  if(isDefined(var_02.var_0A4B)) {
    var_03 = lib_0547::func_0A51(var_02.var_0A4B);
    if(isDefined(var_03) && common_scripts\utility::func_562E(var_03.shockbyteslablood)) {
      var_04 = lib_0580::func_8317(param_00, param_01.var_721C, ::lib_0581::func_3B9D);
      var_02 thread lib_0547::func_7D1A("tesla_shock", [var_04], 4);
      return;
    }
  }

  var_02 thread lib_0580::func_98EE(param_00, param_01.var_721C, "MOD_ENERGY", "teslagun_zm_blood", 1);
}

lib_0581::func_4184() {
  return 210;
}