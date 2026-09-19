/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1409.gsc
**************************************/

_id_17FD() {
  _id_054D::_id_7BC6(::_id_29A5);
  common_scripts\utility::_id_092C("tesla blood shock", "vfx/zombie/abilities_perks/zmb_blood_zmb_stun");
  common_scripts\utility::_id_092C("tesla_blood_explosion", "vfx/explosion/zmb_tesla_blood_explosion");
  common_scripts\utility::_id_092C("tesla_blood_ambience", "vfx/zombie/tesla_guns/zmb_npc_tesla_tube_blood_idle");
}

_id_29A5(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = self;

  if(!_id_0547::_id_5565(var_5, "teslagun_zm_blood")) {
    return;
  }
  if(_id_0547::_id_5565(var_4, "MOD_MELEE")) {
    return;
  }
  if(var_2 == _id_0580::_id_4382()) {
    return;
  }
  _id_0580::_id_98FD(var_0, var_1, var_11, "j_head", var_4, var_5, ::_id_7788, "tesla blood shock");
}

_id_3B9D(var_0) {
  var_1 = self;
  playFX(common_scripts\utility::_id_44F5("tesla_blood_explosion"), var_1.origin + (0, 0, 24));
  var_2 = maps\mp\gametypes\zombies::_id_1E59() * 2;
  _id_0580::_id_98E9(var_1.origin, _id_4184(), var_0.player, undefined, "teslagun_zm_blood", (0.580392, 0.192157, 0.337255), var_2);
  var_1 _id_0378::_id_8D74("aud_ww_blood_explode");
}

_id_7788(var_0, var_1) {
  var_2 = self;

  if(isDefined(var_2._id_0A4B)) {
    var_3 = _id_0547::_id_0A51(var_2._id_0A4B);

    if(isDefined(var_3) && common_scripts\utility::_id_562E(var_3.shockbyteslablood)) {
      var_4 = _id_0580::_id_8317(var_0, var_1.player, ::_id_3B9D);
      var_2 thread _id_0547::_id_7D1A("tesla_shock", [var_4], 4);
      return;
    }
  }

  var_2 thread _id_0580::_id_98EE(var_0, var_1.player, "MOD_ENERGY", "teslagun_zm_blood", 1);
}

_id_4184() {
  return 210;
}