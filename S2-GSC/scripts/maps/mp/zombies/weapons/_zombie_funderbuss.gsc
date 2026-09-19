/******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\weapons\_zombie_funderbuss.gsc
******************************************************************/

init() {
  level.zmb_blundergrenades = [];
  level thread monitor_active_grenades();
  level thread maps\mp\_utility::_id_6F74(::shoot_happiness);
  waitframe();
  common_scripts\utility::_id_092C("vfx_clown_ball_trl", "vfx/map/mp_clowntown/vfx_clown_ball_trl");
}

shoot_happiness() {
  var_0 = self;
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("weapon_fired", var_1);
    var_1 = _id_0547::_id_AAF9(var_1, 1);

    if(!_id_0547::_id_5565(var_1, "blunderbuss_pap_zm")) {
      continue;
    }
    var_0 fire_funderbuss_grenades();
  }
}

fire_funderbuss_grenades(var_0, var_1) {
  var_2 = self;
  var_3 = var_2 _meth_8566();

  if(isDefined(var_1))
    var_3 = var_1;

  var_4 = anglesToForward(var_3);
  var_5 = anglestoup(var_3);
  var_6 = anglestoright(var_3);

  if(!isDefined(var_2.zmb_blundergrenades))
    var_2.zmb_blundergrenades = [];
  else
    var_2.zmb_blundergrenades = common_scripts\utility::_id_0FA0(var_2.zmb_blundergrenades);

  if(var_2.zmb_blundergrenades.size > 0) {
    return;
  }
  for(var_7 = 0; var_7 < 3; var_7++) {
    level.zmb_blundergrenades = common_scripts\utility::_id_0FA0(level.zmb_blundergrenades);

    if(level.zmb_blundergrenades.size >= 6) {
      continue;
    }
    var_8 = var_2 getEye() + var_4 * 45 + var_5 * -8;
    var_9 = 10;
    var_9 = var_9 * var_2 _meth_8345();
    var_9 = 10 - var_9;

    if(isDefined(var_1))
      var_9 = 10;

    if(var_9 < 1)
      var_9 = 1;

    if(isDefined(var_0)) {
      var_8 = var_0;
      var_3 = (var_3[0], randomint(360), var_3[2]);
    }

    var_10 = anglesToForward(var_3 + (0, -1 * var_9 + var_7 * var_9, 0));
    var_11 = 2;
    var_12 = _func_071("frag_grenade_funderbuss_zm", var_8, 2250 * vectorNormalize(var_10), var_11, var_2);
    var_12._id_0117 = var_2;
    var_2.zmb_blundergrenades = common_scripts\utility::_id_0F6F(var_2.zmb_blundergrenades, var_12);
    level.zmb_blundergrenades = common_scripts\utility::_id_0F6F(level.zmb_blundergrenades, var_12);
  }
}

monitor_active_grenades() {
  for(;;) {
    var_0 = common_scripts\utility::_id_0FA0(level.zmb_blundergrenades);

    foreach(var_2 in var_0) {
      if(!isDefined(var_2.life))
        var_2.life = 0;

      var_2.life = var_2.life + 0.1;

      if(var_2.life > 2.4) {
        var_3 = var_2 common_scripts\utility::_id_8FFC();
        var_3 _meth_805B();

        if(isDefined(var_3)) {
          var_3 _meth_8561("frag_grenade_funderbuss_zm", var_2._id_0117, var_3);
          var_2 delete();
          var_3 delete();
        }
      }
    }

    wait 0.1;
  }
}