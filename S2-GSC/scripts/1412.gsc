/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1412.gsc
**************************************/

_id_9434() {
  common_scripts\utility::_id_092C("storm_plasma_stable", "vfx/trail/zmb_tesla_storm_trail");
  common_scripts\utility::_id_092C("storm_plasma_unstable", "vfx/trail/zmb_tesla_storm_trail_unstable");
  common_scripts\utility::_id_092C("head_sparks", "vfx/explosion/zmb_tesla_storm_body_gib");
  common_scripts\utility::_id_092C("tesla_storm_ambience", "vfx/zombie/tesla_guns/zmb_npc_tesla_tube_storm_idle");
  _id_0580::_id_98FA("teslagun_zm_storm", ::_id_433D, ::_id_433F, ::_id_4210, ::_id_9431);
}

_id_4134() {
  var_0 = self;
  var_1 = _id_43EB();
  var_2 = var_0.origin - (0, 0, var_1 * 0.5);
  return var_2;
}

_id_AAED() {
  var_0 = self;
  var_0 endon("death");
  var_1 = "tag_origin";

  for(;;) {
    wait(_id_4218());
    var_2 = _id_0547::_id_43F0(var_0 _id_4134(), _id_43EB(), _id_43EC(), 0);

    if(!var_2.size) {
      continue;
    }
    var_3 = var_2[randomint(var_2.size)];
    var_4 = "j_head";
    _func_147(common_scripts\utility::_id_44F5("storm_plasma_unstable"), var_0, "tag_origin");
    var_0 _id_0378::_id_8D74("aud_ww_projectile_zap");
    _func_176(var_0.origin, _id_43EC(), 0, 1);
    var_0 _id_0580::_id_98F7(var_3);
    var_0 _id_0580::_id_98F8(var_3, "head_sparks");
    var_0 _id_9430();
    var_0 notify("scr_storm_slow_speed");
  }
}

_id_9430() {
  var_0 = self;
  var_1 = _id_4345();
  var_2 = distance(var_0.origin, var_0._id_2DA7);
  var_3 = var_2 / var_1;
  var_4 = _id_405C();

  if(var_4 > var_3)
    var_4 = var_3;

  if(var_3 > 0)
    var_0 _meth_82B1(var_0._id_2DA7, var_3, var_4, 0);

  var_0._id_2A92 = _id_0580::_id_4385() + var_3;
}

_id_9435() {
  var_0 = self;

  for(;;) {
    var_1 = _id_0580::_id_4385();

    if(var_0._id_2A92 <= var_1) {
      break;
    }

    var_2 = var_0._id_2A92 - var_1;
    var_0._id_2A92 = var_0._id_2A92 - var_2;
    wait(var_2);
  }

  _id_0580::_id_98E9(var_0.origin, _id_43EC(), var_0.player, undefined, var_0._id_953E, (0.168627, 0.294118, 0.435294));
  _func_147(common_scripts\utility::_id_44F5("storm_plasma_unstable"), var_0, "tag_origin");
  var_0 _id_0378::_id_8D74("aud_storm_proj_loop_end");

  if(var_0._id_9B7F < 1)
    wait(_id_4192());

  var_0 delete();
}

_id_9431() {
  var_0 = self;
  _func_147(common_scripts\utility::_id_44F5("storm_plasma_stable"), var_0, "tag_origin");
  var_0 _id_0378::_id_8D74("aud_storm_proj_loop_strt");
  var_0 _id_9430();
  var_0 thread _id_AAED();
  var_0 thread _id_9435();
}

_id_43EC() {
  return 130;
}

_id_43EB() {
  return 150;
}

_id_4210() {
  return 1000;
}

_id_4218() {
  return 0.45;
}

_id_433D() {
  return 42;
}

_id_433F() {
  return -8;
}

_id_4345() {
  return 130;
}

_id_405C() {
  return 1;
}

_id_4192() {
  return 1.6;
}