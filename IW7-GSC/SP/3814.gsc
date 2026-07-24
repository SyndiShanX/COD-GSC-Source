/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3814.gsc
**************************************/

main() {
  precachemodel("weapon_kbm4_legendary_wm");
  _id_EE1D();
  level._id_FD6E._id_2263 = getEntArray("armory_background_weapon_rack", "targetname");
  var_0 = getEntArray("armory_3d_printer", "targetname");
  level._id_FD6E._id_21A8 = [];

  foreach(var_2 in var_0) {
    level._id_FD6E._id_21A8[var_2.script_index] = var_2;
    level._id_FD6E._id_21A8[var_2.script_index]._id_13C50 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  }
}

#using_animtree("script_model");

_id_EE1D() {
  level._id_EC87["armory_gun_rack"] = #animtree;
  level._id_EC85["armory_gun_rack"]["gun_rack_loop"][0] = % shipcrib_armory_weapon_locker_idle;
  level._id_EC85["armory_gun_rack"]["gun_rack_move_weapon0"] = % shipcrib_armory_weapon_locker_01;
  level._id_EC85["armory_gun_rack"]["gun_rack_move_weapon1"] = % shipcrib_armory_weapon_locker_02;
  level._id_EC85["armory_gun_rack"]["gun_rack_move_weapon2"] = % shipcrib_armory_weapon_locker_03;
  level._id_EC85["armory_gun_rack"]["gun_rack_move_weapon3"] = % shipcrib_armory_weapon_locker_04;
  level._id_EC87["armory_gun_rack_weapon0"] = #animtree;
  level._id_EC8C["armory_gun_rack_weapon0"] = "weapon_kbm4_legendary_wm";
  level._id_EC85["armory_gun_rack_weapon0"]["gun_rack_move_weapon0"] = % shipcrib_armory_weapon_locker_gun_01;
  level._id_EC87["armory_gun_rack_weapon1"] = #animtree;
  level._id_EC8C["armory_gun_rack_weapon1"] = "weapon_kbm4_legendary_wm";
  level._id_EC85["armory_gun_rack_weapon1"]["gun_rack_move_weapon1"] = % shipcrib_armory_weapon_locker_gun_02;
  level._id_EC87["armory_gun_rack_weapon2"] = #animtree;
  level._id_EC8C["armory_gun_rack_weapon2"] = "weapon_kbm4_legendary_wm";
  level._id_EC85["armory_gun_rack_weapon2"]["gun_rack_move_weapon2"] = % shipcrib_armory_weapon_locker_gun_03;
  level._id_EC87["armory_gun_rack_weapon3"] = #animtree;
  level._id_EC8C["armory_gun_rack_weapon3"] = "weapon_kbm4_legendary_wm";
  level._id_EC85["armory_gun_rack_weapon3"]["gun_rack_move_weapon3"] = % shipcrib_armory_weapon_locker_gun_04;
  level._id_EC87["armory_3d_printer"] = #animtree;
  level._id_EC85["armory_3d_printer"]["hood_close_idle"][0] = % shipcrib_armory_printer_standby_hood_close_idle;
  level._id_EC85["armory_3d_printer"]["hood_close"] = % shipcrib_armory_printer_standby_hood_close;
  level._id_EC85["armory_3d_printer"]["hood_open_idle"][0] = % shipcrib_armory_printer_standby_hood_open_idle;
  level._id_EC85["armory_3d_printer"]["hood_open"] = % shipcrib_armory_printer_standby_hood_open;
  level._id_EC85["armory_3d_printer"]["warmup"] = % shipcrib_armory_printer_job_warmup;
  level._id_EC85["armory_3d_printer"]["active_loop"][0] = % shipcrib_armory_printer_job_active;
  level._id_EC85["armory_3d_printer"]["complete_idle"][0] = % shipcrib_armory_printer_job_complete_idle;
  level._id_EC85["armory_3d_printer"]["complete_hood_open"] = % shipcrib_armory_printer_job_complete_hood_open;
  level._id_EC85["armory_3d_printer"]["complete_hood_open_idle"][0] = % shipcrib_armory_printer_job_complete_hood_open_idle;
  level._id_EC85["armory_3d_printer"]["complete_hood_close"] = % shipcrib_armory_printer_job_complete_hood_close;
  level._id_EC85["armory_3d_printer"]["complete_cooldown"] = % shipcrib_armory_printer_job_complete_cooldown;
}

_id_21F8() {
  if(!isDefined(level._id_FD6E._id_21BE))
    level._id_FD6E._id_21BE = [];
  else
    return level._id_FD6E._id_21BE;

  var_0 = ["iw7_ake", "iw7_devastator", "iw7_m4", "iw7_sdfshotty"];
  var_1 = [];

  foreach(var_3 in var_0) {
    if(level.player _meth_84C6("weaponsScanned", var_3) == "unlocked")
      var_1[var_1.size] = var_3;
  }

  var_1 = scripts\engine\utility::array_randomize(var_1);

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    if(var_5 > 2) {
      break;
    }

    level._id_FD6E._id_21BE[level._id_FD6E._id_21BE.size] = var_1[var_5];
  }

  return level._id_FD6E._id_21BE;
}

_id_2201(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  _id_21F8();

  if(isDefined(var_0))
    var_2 = var_0;
  else
    var_2 = level._id_FD6E._id_21BE;

  foreach(var_4 in var_2)
  _id_0A2F::_id_12646(var_4);

  foreach(var_7 in level._id_FD6E._id_2263) {
    var_7 scripts\sp\utility::_id_23B7("armory_gun_rack");
    var_7._id_1F89 = [];
    var_7._id_10E3D = [];
    var_7._id_1F89[0] = scripts\sp\utility::_id_10639("armory_gun_rack_weapon0", var_7.origin);
    var_7._id_1F89[0].animation = "gun_rack_move_weapon0";
    var_7._id_1F89[1] = scripts\sp\utility::_id_10639("armory_gun_rack_weapon1", var_7.origin);
    var_7._id_1F89[1].animation = "gun_rack_move_weapon1";
    var_7._id_1F89[2] = scripts\sp\utility::_id_10639("armory_gun_rack_weapon2", var_7.origin);
    var_7._id_1F89[2].animation = "gun_rack_move_weapon2";
    var_7._id_1F89[3] = scripts\sp\utility::_id_10639("armory_gun_rack_weapon3", var_7.origin);
    var_7._id_1F89[3].animation = "gun_rack_move_weapon3";

    if(var_1) {
      foreach(var_9 in var_7._id_1F89)
      var_9 setModel(getweaponmodel(var_2[0]));
    }

    var_11 = ["j_holder_base1", "j_holder_base2", "j_holder_base3", "j_holder_base5", "j_holder_base6", "j_holder_base8", "j_holder_base10", "j_holder_base11"];
    var_11 = scripts\engine\utility::array_randomize(var_11);

    for(var_12 = 0; var_12 < 3; var_12++) {
      var_13 = var_2[randomint(var_2.size)];
      var_14 = getweaponmodel(var_13);
      var_7 _id_1081D(var_11[var_12], var_14);
    }
  }
}

_id_1081D(var_0, var_1) {
  if(isstring(var_0)) {
    var_2 = self gettagorigin(var_0);
    var_3 = self gettagangles(var_0);
  } else {
    var_2 = var_0.origin;
    var_3 = var_0.angles;
  }

  var_4 = spawn("script_model", var_2);
  var_4 setModel(var_1);

  if(isstring(var_0))
    var_4.angles = var_3 + (270, 150, -60);
  else
    var_4.angles = var_3;

  if(issubstr(var_1, "devastator")) {
    if(isstring(var_0)) {
      var_5 = anglesToForward(var_4.angles) * -21;
      var_6 = anglestoright(var_4.angles) * -0.25;
      var_7 = anglestoup(var_4.angles) * 4.5;
    } else {
      var_5 = (0, 0, 0);
      var_6 = (0, 0, 0);
      var_7 = anglestoup((0, 0, 0)) * 1;
    }
  } else if(issubstr(var_1, "sdfshotty")) {
    if(isstring(var_0)) {
      var_5 = anglesToForward(var_4.angles) * -22.5;
      var_6 = (0, 0, 0);
      var_7 = anglestoup(var_4.angles) * 6;
    } else {
      var_5 = (0, 0, 0);
      var_6 = (0, 0, 0);
      var_7 = anglestoup((0, 0, 0)) * 0.5;
    }
  } else if(isstring(var_0)) {
    var_5 = anglesToForward(var_4.angles) * -22;
    var_6 = anglestoright(var_4.angles) * -0.25;
    var_7 = anglestoup(var_4.angles) * 4;
  } else {
    var_5 = (0, 0, 0);
    var_6 = (0, 0, 0);
    var_7 = (0, 0, 0);
  }

  var_4.origin = var_2 + var_5 + var_6 + var_7;

  if(isstring(var_0))
    self._id_10E3D[self._id_10E3D.size] = var_4;
  else
    self.weapon = var_4;
}

_id_2202(var_0) {
  var_1 = level._id_FD6E._id_2263.size;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = level._id_FD6E._id_2263[var_2];

    if(!isDefined(var_3._id_1F89)) {
      continue;
    }
    foreach(var_5 in var_3._id_1F89)
    var_3 thread scripts\sp\anim::_id_1EC3(var_5, var_5.animation);

    var_3 thread scripts\sp\anim::_id_1EEA(var_3, "gun_rack_loop");
    var_3 thread _id_21FF(var_0, var_2);
  }
}

_id_21FF(var_0, var_1) {
  level endon("stop_armory_gun_racks");

  if(isDefined(var_0))
    level waittill(var_0);

  var_2 = scripts\engine\utility::array_randomize(self._id_1F89);

  if(var_1 == 0)
    wait 0.25;
  else if(var_1 == 1)
    wait 2;
  else
    wait 3.5;

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(var_3 > 0)
      wait(randomfloatrange(2, 8));

    self notify("stop_loop");
    scripts\sp\anim::_id_1F2C([self, var_2[var_3]], var_2[var_3].animation);
  }

  thread scripts\sp\anim::_id_1EEA(self, "gun_rack_loop");
}

_id_2203() {
  level notify("stop_armory_gun_racks");

  foreach(var_1 in level._id_FD6E._id_2263)
  var_1 notify("stop_loop");
}

_id_2200() {
  _id_2203();

  foreach(var_1 in level._id_FD6E._id_2263) {
    if(isDefined(var_1._id_1F89)) {
      foreach(var_3 in var_1._id_1F89) {
        var_3 notify("death");
        var_3 delete();
      }
    }

    if(isDefined(var_1._id_10E3D)) {
      foreach(var_3 in var_1._id_10E3D)
      var_3 delete();
    }

    var_1 delete();
  }
}

_id_21A6(var_0) {
  _id_21F8();

  if(isDefined(var_0))
    var_1 = var_0;
  else
    var_1 = level._id_FD6E._id_21BE[randomintrange(0, level._id_FD6E._id_21BE.size)];

  if(var_1 != "none")
    _id_0A2F::_id_12646(var_1);

  scripts\sp\utility::_id_23B7("armory_3d_printer");

  if(var_1 != "none") {
    var_2 = var_1;
    var_3 = getweaponmodel(var_2);
    _id_1081D(self._id_13C50, var_3);
  }
}

_id_21A7(var_0) {
  thread _id_21A5(var_0);
}

_id_21A5(var_0) {
  level endon("stop_armory_3d_printers");

  if(!isDefined(self._id_1FBB) || !isDefined(scripts\sp\utility::_id_7DC1("active_loop")))
    return 0;

  if(isDefined(var_0)) {
    thread scripts\sp\anim::_id_1EC3(self, "active_loop");
    level waittill(var_0);
  }

  thread scripts\sp\anim::_id_1EEA(self, "active_loop");
}

_id_21A9() {
  level notify("stop_armory_3d_printers");

  foreach(var_1 in level._id_FD6E._id_21A8) {
    var_1 notify("stop_loop");

    if(isDefined(var_1.weapon))
      var_1.weapon delete();

    var_1 delete();
  }
}