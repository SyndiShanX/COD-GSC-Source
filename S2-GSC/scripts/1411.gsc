/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1411.gsc
**************************************/

_id_6402() {
  common_scripts\utility::_id_092C("moon_plasma", "vfx/trail/zmb_tesla_moon_trail");
  common_scripts\utility::_id_092C("tesla_moon_explosion", "vfx/explosion/zmb_tesla_moon_body_gib");
  common_scripts\utility::_id_092C("moon_plasma_unstable", "vfx/trail/zmb_tesla_moon_trail_unstable");
  common_scripts\utility::_id_092C("tesla_moon_ambience", "vfx/zombie/tesla_guns/zmb_npc_tesla_tube_moon_idle");
  _id_0580::_id_98FA("teslagun_zm_moon", ::_id_433D, ::_id_433F, ::_id_4210, ::_id_63FF);
}

_id_63FF() {
  var_0 = self;
  var_0 endon("death");
  var_1 = _id_4344();
  var_2 = distance(var_0.origin, var_0._id_2DA7);
  var_3 = var_2 / var_1;

  if(var_3 > 0) {
    var_0 moveTo(var_0._id_2DA7, var_3, 0, 0);
  }

  _playFXOnTag(common_scripts\utility::_id_44F5("moon_plasma"), var_0, "tag_origin");
  var_0 _id_0378::_id_8D74("aud_moon_projectile_strt");
  wait(var_3);
  var_0 notify("moon_travel_end");
  var_0 _id_0378::_id_8D74("aud_moon_projectile_end");
  wait(_id_4319());
  var_4 = _id_40AA() / 2;
  _id_0580::_id_98E9(var_0.origin, var_4, var_0.player, undefined, var_0._id_953E, (0.188235, 0.235294, 0.454902));
  playFX(common_scripts\utility::_id_44F5("tesla_moon_explosion"), var_0.origin);
  var_0 delete();
}

_id_AAED() {
  var_0 = self;
  var_0 endon("moon_travel_end");

  for(;;) {
    var_1 = _id_0547::_id_408F();
    var_2 = _id_43EC();
    var_3 = common_scripts\utility::_id_4461(var_0.origin, var_1, var_2);

    if(isDefined(var_3)) {
      var_0 _id_0580::_id_98F7(var_3);
      playFX(common_scripts\utility::_id_44F5("tesla_moon_explosion"), var_3.origin + (0, 0, 54));
      _playFXOnTag(common_scripts\utility::_id_44F5("moon_plasma_unstable"), var_0, "tag_origin");
      var_3 _id_0378::_id_8D74("aud_ww_projectile_zap");
      waitframe();
      _id_0580::_id_98E9(var_3.origin, _id_40AA(), var_0.player, undefined, var_0._id_953E, (0.188235, 0.235294, 0.454902));
    }

    wait(max(0.05, _id_4319()));
  }
}

_id_63FC(var_0) {
  var_1 = self;
  var_1 _id_0580::_id_98F7(var_0);
  playFX(common_scripts\utility::_id_44F5("tesla_moon_explosion"), var_0.origin + (0, 0, 54));
  _playFXOnTag(common_scripts\utility::_id_44F5("moon_plasma_unstable"), var_1, "tag_origin");
  var_0 _id_0378::_id_8D74("aud_ww_projectile_zap");
  waitframe();
  var_2 = maps\mp\gametypes\zombies::_id_1E59() * 2;
  _id_0580::_id_98E9(var_0.origin, _id_40AA(), var_1.player, undefined, var_1._id_953E, (0.188235, 0.235294, 0.454902), var_2);
}

_id_4319() {
  var_0 = _id_4217();
  var_1 = _id_4344();
  var_2 = var_0 / max(1, var_1);
  return var_2;
}

_id_43EC() {
  return 50;
}

_id_4210() {
  return 1000;
}

_id_4217() {
  return 100;
}

_id_433D() {
  return 45;
}

_id_433F() {
  return -8;
}

_id_4344() {
  return 350;
}

_id_40AA() {
  return 120;
}