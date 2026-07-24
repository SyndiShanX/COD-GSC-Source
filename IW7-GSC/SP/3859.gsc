/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3859.gsc
**************************************/

_id_971E() {
  precachemodel("c6_rack_idle_pose_anim");
  precachemodel("veh_mil_air_ca_drop_pod_arm");
  precachemodel("equipment_sdf_kiosk_01_c6_deploy");
  precachemodel("equipment_sdf_kiosk_01_c6_standby");
  precachemodel("equipment_sdf_kiosk_01_off");
  precachestring(&"SHIP_ASSAULT_RSS_DISABLE");
  scripts\sp\utility::_id_22CA("sa_c6_rss_spawner", ::_id_E77D);
  _id_3358();
  _id_EE1D();
  _id_E77F();
}

#using_animtree("c6");

_id_3358() {
  level._id_EC85["generic"]["sa_c6_rack_idle"][0] = % c6_grnd_red_exposed_rack_arm_spawn_idle_ar;
  level._id_EC85["generic"]["sa_c6_rack_exit"] = % c6_grnd_red_exposed_rack_arm_spawn_ar;
}

#using_animtree("script_model");

_id_EE1D() {
  level._id_EC87["arm"] = #animtree;
  level._id_EC8C["arm"] = "veh_mil_air_ca_drop_pod_arm";
  level._id_EC85["arm"]["sa_c6_rack_idle"][0] = % c6_grnd_red_exposed_rack_arm_spawn_idle_arm;
  level._id_EC85["arm"]["sa_c6_rack_exit"] = % c6_grnd_red_exposed_rack_arm_spawn_arm;
}

_id_E77F() {
  level._effect["locker_set_white"] = loadfx("vfx/iw7/prop/vfx_c6_sa_locker_set_white.vfx");
  level._effect["locker_set_red"] = loadfx("vfx/iw7/prop/vfx_c6_sa_locker_set_red.vfx");
}

_id_E9DD(var_0, var_1) {
  var_2 = scripts\engine\utility::getStructArray("robot_security_station", "script_noteworthy");
  var_3 = [];

  if(var_2.size < 1) {
    return;
  }
  foreach(var_5 in var_2) {
    if(!isDefined(var_0) || !isDefined(var_0._id_1352E) || ispointinvolume(var_5.origin, var_0._id_1352E))
      var_3 = scripts\engine\utility::array_add(var_3, var_5);
  }

  if(var_3.size < 1) {
    return;
  }
  if(isDefined(var_0))
    var_0._id_E5A8 = [];

  for(var_7 = 0; var_7 < var_3.size; var_7++) {
    if(!var_3[var_7] scripts\sp\utility::_id_65DF("rss_activated"))
      var_3[var_7] scripts\sp\utility::_id_65E0("rss_activated");

    if(!var_3[var_7] scripts\sp\utility::_id_65DF("rss_deactivated"))
      var_3[var_7] scripts\sp\utility::_id_65E0("rss_deactivated");

    var_3[var_7]._id_E57E = 0;
    var_3[var_7]._id_10E43 = [];
    var_3[var_7]._id_DBBA = [];
    var_3[var_7]._id_107A5 = [];
    var_3[var_7].lights = [];
    var_3[var_7]._id_DBBE = [];
    var_3[var_7]._id_C891 = [];

    if(isDefined(var_0))
      var_0._id_E5A8[var_7] = var_3[var_7];

    var_8 = getEntArray(var_3[var_7].target, "targetname");
    var_9 = scripts\engine\utility::getStructArray(var_3[var_7].target, "targetname");

    foreach(var_11 in var_9) {
      if(isDefined(var_11.script_noteworthy) && var_11.script_noteworthy == "rss_robot_spawn_point") {
        var_3[var_7]._id_107A5 = scripts\engine\utility::array_add(var_3[var_7]._id_107A5, var_11);
        var_3[var_7]._id_E57E = var_3[var_7]._id_E57E + 1;
      }
    }

    foreach(var_14 in var_8) {
      if(isDefined(var_14.script_noteworthy)) {
        switch (var_14.script_noteworthy) {
          case "rss_static_robot":
            var_3[var_7]._id_10E43 = scripts\engine\utility::array_add(var_3[var_7]._id_10E43, var_14);
            break;
          case "rss_light":
            var_3[var_7].lights = scripts\engine\utility::array_add(var_3[var_7].lights, var_14);
            break;
          case "rss_rack":
            var_3[var_7]._id_DBBE = scripts\engine\utility::array_add(var_3[var_7]._id_DBBE, var_14);
            break;
          case "rss_rack_panel":
            var_3[var_7]._id_C891 = scripts\engine\utility::array_add(var_3[var_7]._id_C891, var_14);
            break;
          case "rss_rack_arm":
            var_3[var_7]._id_DBBA = scripts\engine\utility::array_add(var_3[var_7]._id_DBBA, var_14);
            break;
          default:
            break;
        }
      }
    }

    if(isDefined(var_3[var_7].script_index) && var_3[var_7].script_index < var_3[var_7]._id_E57E) {
      while(var_3[var_7].script_index < var_3[var_7]._id_E57E) {
        var_16 = scripts\engine\utility::random(var_3[var_7]._id_107A5);
        var_3[var_7]._id_107A5 = scripts\engine\utility::array_remove(var_3[var_7]._id_107A5, var_16);

        foreach(var_18 in var_3[var_7]._id_10E43) {
          if(isDefined(var_18) && var_18.script_parameters == var_16.script_parameters) {
            var_3[var_7]._id_10E43 = scripts\engine\utility::array_remove(var_3[var_7]._id_10E43, var_18);
            var_18 delete();
          }
        }

        if(var_3[var_7].lights.size > 0) {
          foreach(var_21 in var_3[var_7].lights) {
            if(var_21.script_parameters == var_16.script_parameters) {
              var_21 thread disablelittlebirdrally();
              var_3[var_7].lights = scripts\engine\utility::array_remove(var_3[var_7].lights, var_21);
            }
          }
        }

        var_3[var_7]._id_E57E--;
      }
    } else if(isDefined(var_3[var_7].script_index) && var_3[var_7].script_index >= var_3[var_7]._id_E57E) {}

    foreach(var_24 in var_3[var_7]._id_DBBE) {
      if(!isDefined(var_24.script_parameters)) {
        continue;
      }
      foreach(var_18 in var_3[var_7]._id_10E43) {
        if(!isDefined(var_18.script_parameters)) {
          continue;
        }
        if(var_18.script_parameters == var_24.script_parameters)
          var_18._id_101E1 = var_24;
      }
    }

    foreach(var_29 in var_3[var_7]._id_DBBA)
    var_3[var_7] _id_D852(var_29);

    if(isDefined(var_3[var_7].script_index) && var_3[var_7].script_index == 0) {
      var_3[var_7] thread _id_8954();
      continue;
    }

    if(isDefined(var_0))
      var_3[var_7] thread _id_8952(var_0);
  }
}

_id_8952(var_0) {
  if(scripts\sp\utility::_id_65DF("rss_deactivated") && !scripts\sp\utility::_id_65DB("rss_deactivated")) {
    _id_0E46::_id_48C4(undefined, (0, 0, 0), &"SHIP_ASSAULT_RSS_DISABLE", undefined, 512);
    thread _id_8954(1);
  }

  foreach(var_2 in self._id_10E43) {
    foreach(var_4 in self._id_DBBE) {
      if(isDefined(var_2.script_parameters) && isDefined(var_4.script_parameters) && var_2.script_parameters == var_4.script_parameters) {
        playFXOnTag(scripts\engine\utility::getfx("locker_set_white"), var_4, "tag_origin");
        var_4._id_75AD = 1;
      }
    }
  }

  for(var_7 = 0; var_7 < self._id_107A5.size; var_7++)
    self._id_107A5[var_7] _id_E781(self, var_0);

  thread _id_8953(var_0);
}

_id_E781(var_0, var_1) {
  thread _id_E780(var_0, var_1);
}

_id_E780(var_0, var_1) {
  self endon("rss_deactivated");
  var_0 endon("suspend_rss");
  var_0 endon("rss_deactivated");
  var_1 waittill("room_stealth_broken");

  if(var_0 scripts\sp\utility::_id_65DF("rss_deactivated") && var_0 scripts\sp\utility::_id_65DB("rss_deactivated")) {
    return;
  }
  if(isDefined(self.script_delay))
    wait(self.script_delay);

  var_2 = undefined;

  while(!isDefined(var_2)) {
    level._id_E977.spawners["c6_rss"][0].origin = self.origin;

    if(isDefined(self.angles))
      level._id_E977.spawners["c6_rss"][0].angles = self.angles;

    level._id_E977.spawners["c6_rss"][0].count = 99;
    var_2 = level._id_E977.spawners["c6_rss"][0] scripts\sp\utility::_id_10619(1);

    if(!isDefined(var_2))
      scripts\engine\utility::waitframe();
  }

  waittillframeend;

  foreach(var_4 in var_0._id_10E43) {
    if(isDefined(var_4) && var_4.script_parameters == self.script_parameters) {
      if(isDefined(var_4._id_113F3) && scripts\engine\utility::is_true(var_4._id_113F3[level.player getentitynumber()]))
        var_2 _id_0F25::_id_113D9(level.player, 0);

      var_4 delete();
    }
  }

  var_2.script_parameters = self.script_parameters;
  var_6 = undefined;

  foreach(var_8 in var_0._id_DBBE) {
    if(var_2.script_parameters == var_8.script_parameters)
      var_6 = var_8;
  }

  thread _id_0F00::_id_CDE4(var_2.origin);
  var_0 thread _id_CDD2(var_2);
  var_6 scripts\sp\anim::_id_1EC7(var_2, "sa_c6_rack_exit");

  if(isalive(var_2)) {
    var_2 scripts\sp\utility::_id_F415(0);
    var_2 scripts\sp\utility::_id_F416(0);
    var_2._id_10E6D._id_24CB = 800;
    var_2 _id_0F26::_id_117D4("spotted");
  }

  if(var_0.lights.size > 0) {
    foreach(var_11 in var_0.lights) {
      if(var_11.script_parameters == self.script_parameters)
        var_11 thread disablelittlebirdrally();
    }
  }

  var_0._id_E57E = var_0._id_E57E - 1;
}

_id_E77D() {
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_F416(1);
}

_id_D852(var_0) {
  var_0._id_DBB9 = undefined;

  foreach(var_2 in self._id_DBBE) {
    if(var_2.script_parameters == var_0.script_parameters)
      var_0._id_DBB9 = var_2;
  }

  var_0._id_1FBB = "arm";

  if(isDefined(level._id_EC87[var_0._id_1FBB])) {
    var_0 scripts\sp\anim::_id_F64A();
    var_0._id_DBB9 scripts\sp\anim::_id_1EC3(var_0, "sa_c6_rack_exit");
  }
}

_id_CDD2(var_0) {
  var_1 = undefined;

  foreach(var_3 in self._id_DBBA) {
    if(var_3.script_parameters == var_0.script_parameters)
      var_1 = var_3;
  }

  var_1._id_1FBB = "arm";
  var_1._id_DBB9 scripts\sp\anim::_id_1F35(var_1, "sa_c6_rack_exit");
}

_id_8953(var_0) {
  self endon("suspend_rss");
  var_0 waittill("room_stealth_broken");

  if(scripts\sp\utility::_id_65DF("rss_deactivated") && scripts\sp\utility::_id_65DB("rss_deactivated")) {
    return;
  }
  _id_0E46::_id_DFE3();
  self notify("kill_deactivation");
  thread _id_E782();
}

_id_8954(var_0) {
  self endon("suspend_rss");
  self endon("kill_deactivation");

  if(isDefined(var_0) && var_0 == 1) {
    self waittill("trigger");
    _id_0E46::_id_DFE3();
    thread _id_0F00::_id_CDE5(self.origin);
  }

  if(self.lights.size > 0)
    scripts\engine\utility::array_thread(self.lights, ::disablelittlebirdrally);

  wait 0.25;

  foreach(var_2 in self._id_DBBE) {
    if(isDefined(var_2._id_75AD) && var_2._id_75AD == 1)
      stopFXOnTag(scripts\engine\utility::getfx("locker_set_white"), var_2, "tag_origin");
  }

  foreach(var_5 in self._id_10E43) {
    if(isDefined(var_5._id_113F3))
      var_5 _id_0F25::_id_113E2(0);
  }

  foreach(var_8 in self._id_C891)
  var_8 setModel("equipment_sdf_kiosk_01_off");

  scripts\sp\utility::_id_65E1("rss_deactivated");
}

_id_E782() {
  self endon("suspend_rss");

  foreach(var_1 in self._id_DBBE) {
    if(isDefined(var_1._id_75AD) && var_1._id_75AD == 1) {
      stopFXOnTag(scripts\engine\utility::getfx("locker_set_white"), var_1, "tag_origin");
      playFXOnTag(scripts\engine\utility::getfx("locker_set_red"), var_1, "tag_origin");
    }
  }

  foreach(var_4 in self._id_C891)
  var_4 setModel("equipment_sdf_kiosk_01_c6_deploy");

  while(self._id_E57E > 0)
    wait 0.05;

  scripts\sp\utility::_id_65E1("rss_deactivated");
  wait 0.25;

  foreach(var_1 in self._id_DBBE) {
    if(isDefined(var_1._id_75AD) && var_1._id_75AD == 1)
      stopFXOnTag(scripts\engine\utility::getfx("locker_set_red"), var_1, "tag_origin");
  }

  foreach(var_4 in self._id_C891)
  var_4 setModel("equipment_sdf_kiosk_01_off");
}

disablelittlebirdrally() {
  scripts\sp\lights::_id_AB83(0.0, 0.5);
}

_id_E9E6(var_0) {
  if(!isDefined(var_0._id_E5A8)) {
    return;
  }
  foreach(var_2 in var_0._id_E5A8) {
    if(isDefined(var_2._id_4C1F)) {
      var_2 _id_0E46::_id_DFE3();

      foreach(var_4 in var_2._id_DBBE) {
        if(isDefined(var_4._id_75AD) && var_4._id_75AD == 1) {
          stopFXOnTag(scripts\engine\utility::getfx("locker_set_white"), var_4, "tag_origin");
          var_4._id_75AD = undefined;
        }
      }
    }

    var_2 notify("suspend_rss");
  }
}