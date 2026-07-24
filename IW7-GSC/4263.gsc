/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 4263.gsc
**************************************/

#using_animtree("generic_human");

_id_8A6A(var_0) {
  level._id_EC85["generic"]["shipcrib_hangar_guy_hustle_idle_stand"] = % shipcrib_hangar_guy_hustle_idle_stand;
  level._id_EC85["generic"]["shipcrib_hangar_guy_hustle_idle_kneel"] = % shipcrib_hangar_guy_hustle_idle_kneel;
  level._id_EC85["generic"]["shipcrib_hangar_guy_hustle_idle_lean"] = % shipcrib_hangar_guy_hustle_idle_lean;
  level._id_EC85["generic"]["shipcrib_hangar_hustle_30ft_guy_A_pt1"] = % shipcrib_hangar_hustle_30ft_guy_a_pt1;
  level._id_EC85["generic"]["shipcrib_hangar_hustle_30ft_guy_A_pt2"] = % shipcrib_hangar_hustle_30ft_guy_a_pt2;
  level._id_EC85["generic"]["shipcrib_hangar_hustle_15ft_guy_B_pt1"] = % shipcrib_hangar_hustle_15ft_guy_b_pt1;
  level._id_EC85["generic"]["shipcrib_hangar_hustle_15ft_guy_B_pt2"] = % shipcrib_hangar_hustle_15ft_guy_b_pt2;
  level._id_EC85["generic"]["shipcrib_hangar_hustle_30ft_guy_C_pt1"] = % shipcrib_hangar_hustle_30ft_guy_c_pt1;
  level._id_EC85["generic"]["shipcrib_hangar_hustle_30ft_guy_C_pt2"] = % shipcrib_hangar_hustle_30ft_guy_c_pt2;
  var_1 = ["spawner_flightdeck_maintenance", "spawner_flightdeck_ordnance", "spawner_flightdeck_handler"];
  var_2 = scripts\engine\utility::getStructArray(var_0, "script_noteworthy");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(!isDefined(var_5._id_EE52)) {
      continue;
    }
    if(isDefined(var_5.script_parameters)) {
      var_6 = _id_0EF8::_id_FE01(var_5.script_parameters, var_5, "cheap");
      var_3 = scripts\engine\utility::array_add(var_3, var_6);
    } else {
      var_6 = _id_0EF8::_id_FE01(var_1[randomint(var_1.size)], var_5, "cheap");
      var_3 = scripts\engine\utility::array_add(var_3, var_6);
    }

    var_6 _id_0EFB::_id_FD6F("hangar_hustle");

    if(isDefined(var_5.script_index)) {
      var_6.script_index = var_5.script_index;
    }

    var_7 = undefined;

    switch (var_5._id_EE52) {
      case "a":
        var_7["anim1"] = "shipcrib_hangar_hustle_30ft_guy_A_pt1";
        var_7["anim2"] = "shipcrib_hangar_hustle_30ft_guy_A_pt2";
        var_7["idle1"] = "shipcrib_hangar_guy_hustle_idle_stand";
        var_7["idle2"] = "shipcrib_hangar_guy_hustle_idle_stand";
        break;
      case "b":
        var_7["anim1"] = "shipcrib_hangar_hustle_15ft_guy_B_pt1";
        var_7["anim2"] = "shipcrib_hangar_hustle_15ft_guy_B_pt2";
        var_7["idle1"] = "shipcrib_hangar_guy_hustle_idle_kneel";
        var_7["idle2"] = "shipcrib_hangar_guy_hustle_idle_kneel";
        break;
      case "c":
        var_7["anim1"] = "shipcrib_hangar_hustle_30ft_guy_C_pt1";
        var_7["anim2"] = "shipcrib_hangar_hustle_30ft_guy_C_pt2";
        var_7["idle1"] = "shipcrib_hangar_guy_hustle_idle_kneel";
        var_7["idle2"] = "shipcrib_hangar_guy_hustle_idle_lean";
        break;
    }

    var_6 thread _id_8A68(var_7);
  }

  return var_3;
}

_id_8A68(var_0, var_1) {
  self endon("death");
  self endon("hustle_do_stop");

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  self._id_91F5 = var_0;

  if(var_1) {
    var_2 = randomfloatrange(0, 1);
    scripts\engine\utility::delaycall(0.05, ::_meth_82B0, scripts\sp\utility::_id_7DC1(var_0["anim1"]), var_2);
  }

  scripts\sp\anim::_id_1EC7(self, var_0["anim1"]);
  var_3 = gettime();
  var_4 = 0;
  var_5 = 1;

  for(;;) {
    var_6 = randomintrange(var_4, var_5);

    for(var_7 = 0; var_7 < var_6; var_7++) {
      if(var_7 == 0) {
        thread _id_0EE5::_id_202D();
      }

      scripts\sp\anim::_id_1EC7(self, var_0["idle1"]);
    }

    thread _id_0EE5::_id_10FC4();
    scripts\sp\anim::_id_1EC7(self, var_0["anim2"]);
    var_6 = randomintrange(var_4, var_5);

    for(var_7 = 0; var_7 < var_6; var_7++) {
      if(var_7 == 0) {
        thread _id_0EE5::_id_202D();
      }

      scripts\sp\anim::_id_1EC7(self, var_0["idle2"]);
    }

    thread _id_0EE5::_id_10FC4();
    scripts\sp\anim::_id_1EC7(self, var_0["anim1"]);

    if(gettime() - var_3 > 40000) {
      var_4 = 1;
      var_5 = 4;
      continue;
    }

    if(gettime() - var_3 > 20000) {
      var_4 = 1;
      var_5 = 2;
    }
  }
}

_id_8A69(var_0, var_1) {
  self endon("death");
  self notify("hustle_do_stop");
  var_0 = var_0 * 1000;
  var_2 = gettime();

  if(isDefined(var_1)) {
    thread _id_0EE5::_id_10FC4();
    scripts\sp\anim::_id_1EC7(self, self._id_91F5["anim1"]);
  }

  while(gettime() - var_2 < var_0) {
    thread _id_0EE5::_id_202D();
    scripts\sp\anim::_id_1EC7(self, self._id_91F5["idle1"]);
  }

  if(isDefined(var_1)) {
    thread _id_0EE5::_id_10FC4();
    scripts\sp\anim::_id_1EC7(self, self._id_91F5["anim2"]);
  } else {
    thread _id_0EE5::_id_10FC4();
    scripts\sp\anim::_id_1EC7(self, self._id_91F5["anim1"]);
  }

  thread _id_0EE5::_id_202D();
  scripts\sp\anim::_id_1EC7(self, self._id_91F5["idle2"]);
  thread _id_8A68(self._id_91F5, 0);
}

_id_8A6B(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_1F1C)) {
      var_2._id_1F1C notify("ambient_idle_scene_end");
    }

    var_2 notify("cleaned");

    if(isDefined(var_2._id_B14F)) {
      var_2 scripts\sp\utility::_id_1101B();
    }

    if(isai(var_2)) {
      var_2 _meth_81D0();
    }

    var_2 delete();
  }
}