/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2924.gsc
**************************************/

_id_9717() {
  precachemodel("c6_rack_idle_pose_anim");
  precachemodel("veh_mil_air_ca_drop_pod_arm");
  precachemodel("equipment_sdf_kiosk_01_c6_deploy");
  precachemodel("equipment_sdf_kiosk_01_c6_standby");
  precachemodel("equipment_sdf_kiosk_01_off");
  level._effect["locker_set_white"] = loadfx("vfx/iw7/prop/vfx_c6_sa_locker_set_white.vfx");
  level._effect["locker_set_red"] = loadfx("vfx/iw7/prop/vfx_c6_sa_locker_set_red.vfx");
  _id_3353();
  script_model();
  scripts\sp\utility::_id_22CA("c6_rss_spawner", ::_id_E77D);
}

_id_FA2A(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");
  var_3 = scripts\engine\utility::getStructArray("robot_security_station", "script_noteworthy");
  var_4 = undefined;

  foreach(var_6 in var_3) {
    if(ispointinvolume(var_6.origin, var_2))
      var_4 = var_6;
  }

  if(!isDefined(var_4)) {
    return;
  }
  if(!var_4 scripts\sp\utility::_id_65DF("rss_activated"))
    var_4 scripts\sp\utility::_id_65E0("rss_activated");

  if(!var_4 scripts\sp\utility::_id_65DF("rss_deactivated"))
    var_4 scripts\sp\utility::_id_65E0("rss_deactivated");

  var_4._id_E57E = 0;
  var_4._id_10E43 = [];
  var_4._id_DBBA = [];
  var_4._id_107A5 = [];
  var_4.lights = [];
  var_4._id_DBBE = [];
  var_4._id_C891 = [];
  var_4.team = "axis";

  if(isDefined(var_1))
    var_4.spawners = var_1;

  if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "allies")
    var_4.team = "allies";

  var_8 = getEntArray(var_4.target, "targetname");
  var_9 = scripts\engine\utility::getStructArray(var_4.target, "targetname");

  foreach(var_11 in var_9) {
    if(isDefined(var_11.script_noteworthy) && var_11.script_noteworthy == "rss_robot_spawn_point") {
      var_4._id_107A5 = scripts\engine\utility::array_add(var_4._id_107A5, var_11);
      var_4._id_E57E = var_4._id_E57E + 1;
    }
  }

  foreach(var_6 in var_8) {
    if(isDefined(var_6.script_noteworthy)) {
      switch (var_6.script_noteworthy) {
        case "rss_static_robot":
          var_4._id_10E43 = scripts\engine\utility::array_add(var_4._id_10E43, var_6);
          break;
        case "rss_light":
          var_4.lights = scripts\engine\utility::array_add(var_4.lights, var_6);
          break;
        case "rss_rack":
          var_4._id_DBBE = scripts\engine\utility::array_add(var_4._id_DBBE, var_6);
          break;
        case "rss_rack_panel":
          var_4._id_C891 = scripts\engine\utility::array_add(var_4._id_C891, var_6);
          break;
        case "rss_rack_arm":
          var_4._id_DBBA = scripts\engine\utility::array_add(var_4._id_DBBA, var_6);
          break;
        default:
          break;
      }
    }
  }

  if(isDefined(var_4.script_index) && var_4.script_index < var_4._id_E57E) {
    while(var_4.script_index < var_4._id_E57E) {
      var_15 = scripts\engine\utility::random(var_4._id_107A5);
      var_4._id_107A5 = scripts\engine\utility::array_remove(var_4._id_107A5, var_15);

      foreach(var_17 in var_4._id_10E43) {
        if(isDefined(var_17) && var_17.script_parameters == var_15.script_parameters) {
          var_4._id_10E43 = scripts\engine\utility::array_remove(var_4._id_10E43, var_17);
          var_17 delete();
        }
      }

      foreach(var_20 in var_4.lights) {
        if(var_20.script_parameters == var_15.script_parameters) {
          var_20 thread _id_557C();
          var_4.lights = scripts\engine\utility::array_remove(var_4.lights, var_20);
        }
      }

      var_4._id_E57E--;
    }
  } else if(isDefined(var_4.script_index) && var_4.script_index >= var_4._id_E57E) {}

  foreach(var_23 in var_4._id_DBBE) {
    if(!isDefined(var_23.script_parameters)) {
      continue;
    }
    foreach(var_17 in var_4._id_10E43) {
      if(!isDefined(var_17.script_parameters)) {
        continue;
      }
      if(var_17.script_parameters == var_23.script_parameters)
        var_17._id_101E1 = var_23;
    }
  }

  foreach(var_28 in var_4._id_DBBA)
  var_4 _id_D852(var_28);

  if(isDefined(var_2.target))
    var_4.goal = getEnt(var_2.target, "targetname");

  if(isDefined(var_2._id_EECE))
    var_4._id_10E6D = 1;

  if(isDefined(var_2._id_EED1))
    var_4._id_10F48 = var_2._id_EED1;

  if(isDefined(var_4.script_index) && var_4.script_index == 0)
    var_4 thread _id_8954();
  else {
    foreach(var_31 in var_4._id_10E43) {
      foreach(var_23 in var_4._id_DBBE) {
        if(isDefined(var_31.script_parameters) && isDefined(var_23.script_parameters) && var_31.script_parameters == var_23.script_parameters) {
          playFXOnTag(scripts\engine\utility::getfx("locker_set_white"), var_23, "tag_origin");
          var_23._id_75AD = 1;
        }
      }
    }

    return var_4;
  }
}

_id_8953() {
  if(scripts\sp\utility::_id_65DF("rss_deactivated") && scripts\sp\utility::_id_65DB("rss_deactivated")) {
    return;
  }
  self notify("kill_deactivation");

  for(var_0 = 0; var_0 < self._id_107A5.size; var_0++)
    self._id_107A5[var_0] thread _id_E780(self);

  thread _id_E782();
}

_id_E780(var_0) {
  self endon("rss_deactivated");

  if(var_0 scripts\sp\utility::_id_65DF("rss_deactivated") && var_0 scripts\sp\utility::_id_65DB("rss_deactivated")) {
    return;
  }
  if(isDefined(self.script_delay))
    wait(self.script_delay);

  var_1 = undefined;
  var_2 = undefined;

  if(isDefined(var_0.spawners))
    var_2 = scripts\engine\utility::random(var_0.spawners);
  else
    var_2 = getEnt("c6_rss_spawner", "targetname");

  if(isDefined(var_0._id_10E6D) && var_0._id_10E6D == 1)
    var_2._id_EECE = 1;

  if(isDefined(var_0._id_10F48))
    var_2._id_EED1 = var_0._id_10F48;

  while(!isDefined(var_1)) {
    var_2.origin = self.origin;

    if(isDefined(self.angles))
      var_2.angles = self.angles;

    var_2.count = 99;
    var_1 = var_2 scripts\sp\utility::_id_10619(1);

    if(!isDefined(var_1))
      scripts\engine\utility::waitframe();

    if(isDefined(var_1))
      var_1.team = var_0.team;
  }

  waittillframeend;

  foreach(var_4 in var_0._id_10E43) {
    if(isDefined(var_4) && var_4.script_parameters == self.script_parameters)
      var_4 delete();
  }

  var_1.script_parameters = self.script_parameters;
  var_6 = undefined;

  foreach(var_8 in var_0._id_DBBE) {
    if(var_1.script_parameters == var_8.script_parameters)
      var_6 = var_8;
  }

  var_0 thread _id_CDD2(var_1);
  var_6 scripts\sp\anim::_id_1EC7(var_1, "sa_c6_rack_exit");

  if(isalive(var_1)) {
    if(isDefined(var_0.goal))
      var_1 _meth_82F1(var_0.goal);

    if(isDefined(var_1._id_EECE) && var_1._id_EECE == 1)
      var_1 scripts\sp\utility::_id_61E7();

    var_1 scripts\sp\utility::_id_F415(0);
    var_1 scripts\sp\utility::_id_F416(0);
  }

  if(var_0.lights.size > 0) {
    foreach(var_11 in var_0.lights) {
      if(var_11.script_parameters == self.script_parameters)
        var_11 thread _id_557C();
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

_id_8954() {
  if(self.lights.size > 0)
    scripts\engine\utility::array_thread(self.lights, ::_id_557C);

  wait 0.25;

  foreach(var_1 in self._id_DBBE) {
    if(isDefined(var_1._id_75AD) && var_1._id_75AD == 1)
      stopFXOnTag(scripts\engine\utility::getfx("locker_set_white"), var_1, "tag_origin");
  }

  foreach(var_4 in self._id_C891)
  var_4 setModel("equipment_sdf_kiosk_01_off");

  scripts\sp\utility::_id_65E1("rss_deactivated");
}

_id_E782() {
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

_id_557C() {
  scripts\sp\lights::_id_AB83(0.0, 0.5);
}

#using_animtree("c6");

_id_3353() {
  level._id_EC85["generic"]["sa_c6_rack_idle"][0] = % c6_grnd_red_exposed_rack_arm_spawn_idle_ar;
  level._id_EC85["generic"]["sa_c6_rack_exit"] = % c6_grnd_red_exposed_rack_arm_spawn_ar;
}

#using_animtree("script_model");

script_model() {
  level._id_EC87["arm"] = #animtree;
  level._id_EC8C["arm"] = "veh_mil_air_ca_drop_pod_arm";
  level._id_EC85["arm"]["sa_c6_rack_idle"][0] = % c6_grnd_red_exposed_rack_arm_spawn_idle_arm;
  level._id_EC85["arm"]["sa_c6_rack_exit"] = % c6_grnd_red_exposed_rack_arm_spawn_arm;
}