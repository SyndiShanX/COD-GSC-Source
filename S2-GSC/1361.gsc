/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1361.gsc
*********************************************/

func_3D52(param_00) {
  var_01 = self;
  var_02 = common_scripts\utility::func_44F5(func_44E4());
  if(isDefined(var_01.var_3D4C) == param_00) {
    return;
  }

  if(param_00) {
    var_01.var_3D4C = spawnlinkedfxforclient(var_02, var_01, "j_spineupper", var_01);
    triggerfx(var_01.var_3D4C);
    var_01 lightsetoverrideenableforplayer("mp_zombie_descent_sewer_lgton", 0.5);
    return;
  }

  var_01.var_3D4C delete();
  var_01.var_3D4C = undefined;
  var_01 lightsetoverrideenableforplayer("mp_zombie_descent_secrettrial", 0.5);
}

func_3D51() {
  level endon("kill flashlight");
  var_00 = self;
  while(!isDefined(var_00.var_20DA)) {
    wait 0.05;
  }

  var_00 func_3D52(1);
}

func_298E() {
  var_00 = level.var_28F8 + 1;
  if(var_00 >= level.var_3D4F.size) {
    level.var_28F8 = 0;
    return;
  }

  level.var_28F8 = var_00;
}

func_44E4() {
  return level.var_3D4F[level.var_28F8];
}

func_3D50(param_00) {
  level endon("kill flashlight");
  if(!isDefined(level._effect["zmb_player_attached_light"])) {
    level._effect["zmb_player_attached_light"] = loadfx("vfx/lights/mp_zombie_nest/zmb_player_attached_light");
  }

  level._effect["zmb_player_attached_light_far"] = loadfx("vfx/lights/mp_zombie_nest/zmb_player_attached_light_far");
  level._effect["zmb_player_attached_light_stealth"] = loadfx("vfx/lights/mp_zombie_nest/zmb_player_attached_light_stealth");
  level.var_3D4F = ["zmb_player_attached_light", "zmb_player_attached_light_far", "zmb_player_attached_light_stealth"];
  level.var_28F8 = 0;
  if(common_scripts\utility::func_562E(param_00)) {
    thread maps\mp\_utility::func_6F74(::func_3D51);
  }
}

func_3D53() {
  level notify("kill flashlight");
  foreach(var_01 in level.players) {
    var_01 func_3D52(0);
  }
}