/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2817.gsc
**************************************/

#using_animtree("generic_human");

_id_99FE(var_0, var_1) {
  self endon("death");
  self endon("stop_interact_with_me");

  if(!isDefined(var_1)) {
    var_1 = 128;
  }

  if(!isDefined(var_0)) {
    var_0 = 60;
  }

  var_0 = var_0 * 1000;
  var_2 = self;

  if(!isai(self) && !isPlayer(self)) {
    var_2 = level.player;
  }

  while(!isDefined(level._id_FD6E) || !isDefined(level._id_FD6E._id_1912)) {
    wait 0.25;
  }

  for(;;) {
    var_3 = scripts\engine\utility::get_array_of_closest(self.origin, _id_0EE4::_id_FD9C(), undefined, undefined, var_1, 16);
    var_4 = gettime();

    for(var_5 = var_3.size - 1; var_5 >= 0; var_5--) {
      var_6 = var_3[var_5];
      var_7 = var_6._id_1A1A;

      if(isPlayer(self)) {
        var_7 = var_6._id_CB18;
      }

      if(isDefined(var_7) && var_7 > var_4) {
        var_3 = scripts\engine\utility::array_remove(var_3, var_6);
        continue;
      }

      if(isDefined(var_6._id_9C84) && var_6._id_9C84) {
        var_3 = scripts\engine\utility::array_remove(var_3, var_6);
        continue;
      }

      if(isDefined(var_6._id_117C) && var_6._id_117C > 0) {
        var_3 = scripts\engine\utility::array_remove(var_3, var_6);
        continue;
      }

      if(!var_6 scripts\sp\utility::_id_D637(self.origin)) {
        var_3 = scripts\engine\utility::array_remove(var_3, var_6);
        continue;
      }

      if(!level.player scripts\sp\utility::_id_D637(var_6.origin) || distance(var_6.origin, level.player.origin) > 448) {
        var_3 = scripts\engine\utility::array_remove(var_3, var_6);
      }
    }

    if(var_3.size == 0) {
      wait 0.25;
      continue;
    }

    var_6 = var_3[0];

    if(isPlayer(self)) {
      var_6._id_CB18 = var_4 + randomfloatrange(var_0 - var_0 / 3, var_0 + var_0 / 3);
    } else {
      var_6._id_1A1A = var_4 + var_0;
    }

    var_6 thread scripts\sp\utility::_id_7790(%shipcrib_gst_head_nod_01);
    var_6 thread scripts\sp\utility::_id_7799(var_2);
    var_6 scripts\engine\utility::delaythread(1.0, scripts\sp\utility::_id_77B9, 0.5);
    wait 0.25;
  }
}