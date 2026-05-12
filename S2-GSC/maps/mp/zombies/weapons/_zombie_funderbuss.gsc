/**********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\weapons\_zombie_funderbuss.gsc
**********************************************************/

func_00D5() {
  level.zmb_blundergrenades = [];
  level thread monitor_active_grenades();
  level thread maps\mp\_utility::func_6F74(::shoot_happiness);
  wait 0.05;
  common_scripts\utility::func_092C("vfx_clown_ball_trl", "vfx/map/mp_clowntown/vfx_clown_ball_trl");
}

shoot_happiness() {
  var_00 = self;
  var_00 endon("disconnect");
  for(;;) {
    var_00 waittill("weapon_fired", var_01);
    var_01 = lib_0547::func_AAF9(var_01, 1);
    if(!lib_0547::func_5565(var_01, "blunderbuss_pap_zm")) {
      continue;
    }

    var_00 fire_funderbuss_grenades();
  }
}

fire_funderbuss_grenades(param_00, param_01) {
  var_02 = self;
  var_03 = var_02 geteyeangles();
  if(isDefined(param_01)) {
    var_03 = param_01;
  }

  var_04 = anglesToForward(var_03);
  var_05 = anglestoup(var_03);
  var_06 = anglestoright(var_03);
  if(!isDefined(var_02.zmb_blundergrenades)) {
    var_02.zmb_blundergrenades = [];
  } else {
    var_02.zmb_blundergrenades = common_scripts\utility::func_0FA0(var_02.zmb_blundergrenades);
  }

  if(var_02.zmb_blundergrenades.size > 0) {
    return;
  }

  for(var_07 = 0; var_07 < 3; var_07++) {
    level.zmb_blundergrenades = common_scripts\utility::func_0FA0(level.zmb_blundergrenades);
    if(level.zmb_blundergrenades.size >= 6) {
      continue;
    }

    var_08 = var_02 getEye() + var_04 * 45 + var_05 * -8;
    var_09 = 10;
    var_09 = var_09 * var_02 playerads();
    var_09 = 10 - var_09;
    if(isDefined(param_01)) {
      var_09 = 10;
    }

    if(var_09 < 1) {
      var_09 = 1;
    }

    if(isDefined(param_00)) {
      var_08 = param_00;
      var_03 = (var_03[0], randomint(360), var_03[2]);
    }

    var_0A = anglesToForward(var_03 + (0, -1 * var_09 + var_07 * var_09, 0));
    var_0B = 2;
    var_0C = magicgrenademanual("frag_grenade_funderbuss_zm", var_08, 2250 * vectornormalize(var_0A), var_0B, var_02);
    var_0C.var_0117 = var_02;
    var_02.zmb_blundergrenades = common_scripts\utility::func_0F6F(var_02.zmb_blundergrenades, var_0C);
    level.zmb_blundergrenades = common_scripts\utility::func_0F6F(level.zmb_blundergrenades, var_0C);
  }
}

monitor_active_grenades() {
  for(;;) {
    var_00 = common_scripts\utility::func_0FA0(level.zmb_blundergrenades);
    foreach(var_02 in var_00) {
      if(!isDefined(var_02.life)) {
        var_02.life = 0;
      }

      var_02.life = var_02.life + 0.1;
      if(var_02.life > 2.4) {
        var_03 = var_02 common_scripts\utility::func_8FFC();
        var_03 method_805B();
        if(isDefined(var_03)) {
          var_03 detonateusingweapon("frag_grenade_funderbuss_zm", var_02.var_0117, var_03);
          var_02 delete();
          var_03 delete();
        }
      }
    }

    wait(0.1);
  }
}