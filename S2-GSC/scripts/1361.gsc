/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1361.gsc
**************************************/

_id_3D52(var_0) {
  var_1 = self;
  var_2 = common_scripts\utility::_id_44F5(_id_44E4());

  if(isDefined(var_1._id_3D4C) == var_0) {
    return;
  }
  if(var_0) {
    var_1._id_3D4C = _spawnlinkedfxforclient(var_2, var_1, "j_spineupper", var_1);
    _triggerfx(var_1._id_3D4C);
    var_1 lightsetoverrideenableforplayer("mp_zombie_descent_sewer_lgton", 0.5);
  } else {
    var_1._id_3D4C delete();
    var_1._id_3D4C = undefined;
    var_1 lightsetoverrideenableforplayer("mp_zombie_descent_secrettrial", 0.5);
  }
}

_id_3D51() {
  level endon("kill flashlight");
  var_0 = self;

  while(!isDefined(var_0._id_20DA)) {
    waitframe();
  }

  var_0 _id_3D52(1);
}

_id_298E() {
  var_0 = level._id_28F8 + 1;

  if(var_0 >= level._id_3D4F.size) {
    level._id_28F8 = 0;
  } else {
    level._id_28F8 = var_0;
  }
}

_id_44E4() {
  return level._id_3D4F[level._id_28F8];
}

_id_3D50(var_0) {
  level endon("kill flashlight");

  if(!isDefined(level._effect["zmb_player_attached_light"])) {
    level._effect["zmb_player_attached_light"] = loadfx("vfx/lights/mp_zombie_nest/zmb_player_attached_light");
  }

  level._effect["zmb_player_attached_light_far"] = loadfx("vfx/lights/mp_zombie_nest/zmb_player_attached_light_far");
  level._effect["zmb_player_attached_light_stealth"] = loadfx("vfx/lights/mp_zombie_nest/zmb_player_attached_light_stealth");
  level._id_3D4F = ["zmb_player_attached_light", "zmb_player_attached_light_far", "zmb_player_attached_light_stealth"];
  level._id_28F8 = 0;

  if(common_scripts\utility::_id_562E(var_0)) {
    thread maps\mp\_utility::_id_6F74(::_id_3D51);
  }
}

_id_3D53() {
  level notify("kill flashlight");

  foreach(var_1 in level.players) {
    var_1 _id_3D52(0);
  }
}