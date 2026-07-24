/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2993.gsc
**************************************/

main(var_0, var_1, var_2) {
  if(issubstr(var_2, "_plane")) {
    scripts\sp\vehicle_build::_id_31C5("capital_ship", var_0, var_1, var_2);
    scripts\sp\vehicle_build::_id_31C6();
    scripts\sp\vehicle_build::_id_319F();
  } else
    scripts\sp\vehicle_build::_id_31C5("capitalship_missileboat", var_0, var_1, var_2);

  precachemodel("veh_mil_air_ca_missile_boat_sheild_bottom_l");
  precachemodel("veh_mil_air_ca_missile_boat_sheild_bottom_r");
  precachemodel("veh_mil_air_ca_missile_boat_sheild_side_l");
  precachemodel("veh_mil_air_ca_missile_boat_sheild_side_r");
  precachemodel("veh_mil_air_ca_missile_boat_sheild_top_l");
  precachemodel("veh_mil_air_ca_missile_boat_sheild_top_r");
  precachemodel("veh_mil_air_ca_missile_boat_engine");
  _id_0BB6::_id_12A89();
  _id_0BA9::_id_39B3(var_0, "ca", var_2);
  scripts\sp\vehicle_build::_id_31A6(::init_location);
  scripts\sp\vehicle_build::_id_31A3(999, 500, 1500);
  scripts\sp\vehicle_build::_id_31B8("mig_rumble", 0.08, 0.15, 20300, 0.05, 0.05);
  scripts\sp\vehicle_build::_id_31C4("axis");

  if(issubstr(var_2, "cheap")) {
    precachemodel("veh_mil_air_ca_missile_boat_engine");
    level._effect["missileboat_thruster_rear_lrg_idle"] = loadfx("vfx/iw7/core/vehicle/missile_boat/vfx_vehicle_missileboat_thruster_rear_med_idle.vfx");
    level._effect["missileboat_thruster_rear_lrg_heavy"] = loadfx("vfx/iw7/core/vehicle/missile_boat/vfx_missileboat_rear_thrust_max.vfx");
    level._effect["missileboat_thruster_down_sml_idle"] = loadfx("vfx/iw7/core/vehicle/capship/ca/missileboat/vfx_capship_ca_missileboat_thruster_down_idle.vfx");
    level._effect["missileboat_thruster_down_sml_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/ca/missileboat/vfx_capship_ca_missileboat_thruster_down_heavy.vfx");
    level._effect["missile_boat_engine_light_small"] = loadfx("vfx/iw7/core/vehicle/capship/ca/missileboat/vfx_capship_ca_missileboat_engine_light_sml.vfx");
    level._effect["missile_boat_engine_light_large"] = loadfx("vfx/iw7/core/vehicle/capship/ca/missileboat/vfx_capship_ca_missileboat_light_lrg.vfx");
    return;
  }

  precachemodel("veh_mil_air_ca_missile_boat_engine_dest");
  level._effect["missileboat_ca_warp_in"] = loadfx("vfx/iw7/core/vehicle/missile_boat/vfx_vehicle_missile_boat_warp_in.vfx");
  level._effect["missileboat_ca_warp_out"] = loadfx("vfx/iw7/core/vehicle/missile_boat/vfx_vehicle_missile_boat_warp_out.vfx");
  level._effect["missileboat_ca_warp_pre"] = loadfx("vfx/iw7/core/vehicle/missile_boat/vfx_vehicle_missile_boat_warp_in_anticipation.vfx");
  level._effect["missileboat_missile_flare"] = loadfx("vfx/iw7/core/vehicle/missile_boat/vfx_vehicle_missileboat_missile.vfx");
  level._effect["missileboat_thruster_rear_lrg_idle"] = loadfx("vfx/iw7/core/vehicle/missile_boat/vfx_vehicle_missileboat_thruster_rear_med_idle.vfx");
  level._effect["missileboat_thruster_rear_lrg_heavy"] = loadfx("vfx/iw7/core/vehicle/missile_boat/vfx_missileboat_rear_thrust_max.vfx");
  level._effect["missileboat_thruster_rear_lrg_launch"] = loadfx("vfx/iw7/core/vehicle/missile_boat/vfx_missileboat_rear_thrust_boost.vfx");
  level._effect["missileboat_thruster_down_sml_idle"] = loadfx("vfx/iw7/core/vehicle/capship/ca/missileboat/vfx_capship_ca_missileboat_thruster_down_idle.vfx");
  level._effect["missileboat_thruster_down_sml_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/ca/missileboat/vfx_capship_ca_missileboat_thruster_down_heavy.vfx");
  level._effect["missile_boat_engine_light_small"] = loadfx("vfx/iw7/core/vehicle/capship/ca/missileboat/vfx_capship_ca_missileboat_engine_light_sml.vfx");
  level._effect["missile_boat_engine_light_large"] = loadfx("vfx/iw7/core/vehicle/capship/ca/missileboat/vfx_capship_ca_missileboat_light_lrg.vfx");
  level._effect["missile_boat_engine_light_small_emp"] = loadfx("vfx/iw7/core/vehicle/capship/ca/missileboat/vfx_capship_ca_missileboat_engine_arc_lights.vfx");
  level._effect["missile_boat_engine_emp_spark"] = loadfx("vfx/iw7/core/vehicle/capship/ca/missileboat/vfx_capship_ca_missileboat_engine_spark.vfx");
  level._effect["missile_boat_engine_emp_arc"] = loadfx("vfx/iw7/core/vehicle/capship/ca/missileboat/vfx_capship_ca_missileboat_engine_arc.vfx");
  level._effect["missile_boat_smoking"] = loadfx("vfx/iw7/core/vehicle/capship/ca/missileboat/vfx_capship_ca_missileboat_engine_fire.vfx");
  level._effect["missile_boat_death"] = loadfx("vfx/iw7/core/vehicle/missile_boat/vfx_missile_boat_destruction.vfx");
  level._effect["missileboat_shield_damage"] = loadfx("vfx/iw7/core/vehicle/capship/ca/missileboat/vfx_capship_ca_missileboat_shield_dmg.vfx");
  level._effect["missileboat_shield_float_lt"] = loadfx("vfx/iw7/core/vehicle/missile_boat/vfx_capship_ca_missileboat_shield_death_lt.vfx");
  level._effect["missileboat_shield_float_ls"] = loadfx("vfx/iw7/core/vehicle/missile_boat/vfx_capship_ca_missileboat_shield_death_l.vfx");
  level._effect["missileboat_shield_float_lb"] = loadfx("vfx/iw7/core/vehicle/missile_boat/vfx_capship_ca_missileboat_shield_death_lb.vfx");
  level._effect["missileboat_shield_float_rt"] = loadfx("vfx/iw7/core/vehicle/missile_boat/vfx_capship_ca_missileboat_shield_death_rt.vfx");
  level._effect["missileboat_shield_float_rs"] = loadfx("vfx/iw7/core/vehicle/missile_boat/vfx_capship_ca_missileboat_shield_death_r.vfx");
  level._effect["missileboat_shield_float_rb"] = loadfx("vfx/iw7/core/vehicle/missile_boat/vfx_capship_ca_missileboat_shield_death_rb.vfx");
  level._effect["missileboat_engine_damage"] = loadfx("vfx/iw7/core/vehicle/capship/ca/missileboat/vfx_capship_ca_missileboat_engine_dmg.vfx");
  level._effect["missileboat_engine_destroyed"] = loadfx("vfx/iw7/core/vehicle/capship/ca/missileboat/vfx_capship_ca_missileboat_engine_death.vfx");
  level._effect["capital_turret_death_sm_mb"] = loadfx("vfx/iw7/core/vehicle/turret/vfx_cap_turret_death_sm_mb.vfx");
  level._effect["capital_turret_smolder_sm_mb"] = loadfx("vfx/iw7/core/vehicle/turret/vfx_cap_turret_smolder_sm_mb.vfx");
  level._effect["capital_turret_death_smt_mb"] = loadfx("vfx/iw7/core/vehicle/turret/vfx_cap_turret_death_smt_mb.vfx");
  level._effect["capital_turret_smolder_smt_mb"] = loadfx("vfx/iw7/core/vehicle/turret/vfx_cap_turret_smolder_smt_mb.vfx");
}

init_location() {
  thread _id_0BA9::_id_396E("ca");
  _id_0BB8::_id_7562("thrust_rear", "fx_engine_s", "missileboat_thruster_rear_lrg", self._id_501F);
  _id_0BB8::_id_7562("thrust_vert", "fx_thruster_v_s", "missileboat_thruster_down_sml", self._id_501F);

  if(!issubstr(self.classname, "_plane")) {
    self._id_51E6 = 1;
  }

  if(issubstr(self.classname, "cheap")) {
    _id_0BB2::_id_3193();
    return;
  }

  self._id_4E09 = "missile_boat_death";
  self._id_7482 = "missileboat_ca_warp";
  self._id_7481 = 1;

  if(scripts\sp\utility::_id_B324()) {
    self[[level._id_A056._id_11543]]("capitalship", "JACKAL_AJAK", "none", "none", 0, 1, 1);
  }

  if(issubstr(self.classname, "turret") || !issubstr(self.classname, "plane")) {
    self._id_EEF9 = "cannon_missile_ca_hardpoint cannon_small_ca,3,1,amb_turret_l_1,amb_turret_r_1,amb_turret_l_2,amb_turret_r_2,amb_turret_l_3,amb_turret_r_3";
    self._id_C825 = "missileboat_turret";
    _id_0BB6::_id_39E8();

    foreach(var_1 in self._id_8B4F["cap_hardpoint_missile_barrage"]) {
      var_1._id_FEAD = 0;
    }

    self._id_12A8B = 1;
    self._id_12B8B = 0;
    self._id_B8A8 = 0;
    self._id_DF62 = "stopped";
    _id_0BB2::_id_3193();
    var_3 = 200;
    var_4 = 13000;
    var_5 = 0.55;
    var_6 = 0.35;
    var_7 = 4000;
    var_8 = 1500;
    var_9 = 1000;
    _id_0BA9::_id_39D6(var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }

  _id_F5D9();

  if(issubstr(self.classname, "turret") || !issubstr(self.classname, "plane")) {
    thread _id_F04B(1);
  }
}

_id_F5D9() {
  if(!scripts\sp\utility::_id_B324()) {
    return;
  }
  var_0 = [];

  foreach(var_2 in self.turrets) {
    var_0 = scripts\engine\utility::array_combine(var_0, var_2);
  }

  foreach(var_5 in self._id_8B4F) {
    var_0 = scripts\engine\utility::array_combine(var_0, var_5);
  }

  foreach(var_8 in var_0) {
    var_8[[level._id_A056._id_1151D]]();
  }
}

_id_F486(var_0, var_1, var_2, var_3) {
  self notify("new_volume");
  self endon("death");
  self endon("new_volume");

  if(!isDefined(var_1)) {
    var_1 = self._id_63DE;
  }

  while(!isDefined(self._id_7560["thrust_vert"])) {
    scripts\engine\utility::waitframe();
  }

  var_4 = self;

  if(!isDefined(var_4._id_9391) || isDefined(var_4._id_9391) && !var_4._id_9391) {
    var_4._id_DF62 = "stopped";
    var_4._id_2409 = 0;
    var_4._id_12B8B = 0;
    var_4._id_E739 = undefined;
    var_4._id_9391 = 0;
    var_4._id_10D90 = 0;
  } else
    return;

  self _meth_851C(1);
  self _meth_8554(200, 10, 1, 1500, 10, 1, 0.25);
  self _meth_84BB(1);
  _id_0BB8::_id_39D0("off");
  _id_0BB8::_id_39CD("idle");

  if(isDefined(level._id_2523)) {
    level._id_2523 = scripts\engine\utility::array_add(level._id_2523, var_4);
  } else {
    level._id_2523 = [var_4];
  }

  if(!isDefined(var_2)) {
    var_2 = 25000;
  }

  var_5 = getcsplineidarray("missileboat_start", "targetname");

  if(!var_4 istouching(var_0)) {
    var_4 _id_B875(var_0, var_5);
    var_4._id_9829 = 1;
  }

  self._id_24CE = var_0;
  var_4._id_2409 = 1;
  self._id_DF62 = "stopped";
  var_4 _id_0BB8::_id_39CD("idle");
  var_4 _id_0BB8::_id_39CE("med");
  self _meth_84BB(0);
  var_4._id_63DE = var_1;

  while(var_4._id_63DE.size > 0) {
    for(;;) {
      var_4 notify("new_target");
      self._id_DF62 = "stopped";
      var_6 = undefined;
      var_4._id_63DE = scripts\engine\utility::array_randomize(var_4._id_63DE);

      if(isDefined(level._id_D127) && scripts\engine\utility::array_contains(var_4._id_63DE, level._id_D127) && level._id_D127 istouching(var_0)) {
        var_6 = level._id_D127;
      } else {
        foreach(var_8 in var_4._id_63DE) {
          if(isDefined(var_8) && var_8 istouching(var_0)) {
            var_6 = var_8;
            break;
          }
        }
      }

      if(var_4._id_12B8B) {
        if(isDefined(level._id_D127) && scripts\engine\utility::array_contains(var_4._id_63DE, level._id_D127) && isDefined(level._id_D127)) {
          var_10 = distance(var_4.origin, level._id_D127.origin);

          if(var_10 < var_2) {
            var_6 = level._id_D127;
          }
        }
      }

      if(!isDefined(var_6)) {
        self notify("no_enemies_in_volume");
        break;
      }

      var_4 thread _id_B84F(var_6);
      var_4 thread _id_B84E(var_0, var_6, var_2);

      if(!isDefined(level._id_D127) || var_6 != level._id_D127) {
        var_4 thread _id_B87D(var_6, var_3);
      }

      while(isDefined(var_6) && var_6 istouching(var_0)) {
        if(scripts\engine\utility::array_contains(var_4._id_63DE, level._id_D127)) {
          if(!level._id_D127 istouching(var_0) && !var_4._id_12B8B) {
            wait 0.5;
          } else if(var_6 == level._id_D127 && !var_4._id_12B8B) {
            wait 0.5;
          } else {
            if(!isDefined(var_6)) {
              var_4._id_63DE = scripts\engine\utility::array_remove(var_4._id_63DE, var_6);
            }

            break;
          }
        } else if(!isDefined(var_6)) {
          var_4._id_63DE = scripts\engine\utility::array_remove(var_4._id_63DE, var_6);
          break;
        } else
          wait 0.5;
      }

      if(isDefined(var_6)) {
        if(scripts\engine\utility::array_contains(var_4._id_63DE, level._id_D127)) {
          var_10 = distance(var_4.origin, var_6.origin);

          while(var_6 == level._id_D127 && var_10 < var_2) {
            if(isDefined(var_6)) {
              wait 0.5;
              var_10 = distance(var_4.origin, var_6.origin);
              continue;
            }

            var_4._id_63DE = scripts\engine\utility::array_remove(var_4._id_63DE, var_6);
            break;
          }
        } else {
          var_11 = distance(var_4.origin, var_6.origin);

          while(var_11 < var_2) {
            if(isDefined(var_6)) {
              var_11 = distance(var_4.origin, var_6.origin);
              wait 0.5;
              continue;
            }

            var_4._id_63DE = scripts\engine\utility::array_remove(var_4._id_63DE, var_6);
            break;
          }
        }
      } else {
        var_4._id_63DE = scripts\engine\utility::array_remove(var_4._id_63DE, var_6);
        break;
      }

      wait 0.5;
    }

    var_4 _id_B87B(var_0, var_4._id_63DE);
  }

  self notify("no_enemies_in_range");
}

_id_B84F(var_0) {
  self endon("death");
  self endon("new_volume");
  var_1 = self;
  var_2 = undefined;
  var_3 = 0;
  var_4 = var_1._id_8B50["cap_hardpoint_missile_barrage"].size;
  var_5 = var_1._id_8B51["cap_hardpoint_missile_barrage"].size;
  var_6 = 400000000;

  while(isDefined(var_0)) {
    var_7 = distancesquared(level._id_D127.origin, var_1.origin);
    var_1._id_8B50["cap_hardpoint_missile_barrage"] = ::scripts\engine\utility::array_removeundefined(var_1._id_8B50["cap_hardpoint_missile_barrage"]);
    var_1._id_8B51["cap_hardpoint_missile_barrage"] = ::scripts\engine\utility::array_removeundefined(var_1._id_8B51["cap_hardpoint_missile_barrage"]);
    var_8 = var_1._id_8B50["cap_hardpoint_missile_barrage"];
    var_9 = var_1._id_8B51["cap_hardpoint_missile_barrage"];

    if(!var_3) {
      var_1 _id_0BB8::_id_39D0("heavy");
      var_10 = 1;
    }

    if(var_7 < var_6 || var_1._id_12B8B) {
      var_11 = vectortoangles(level._id_D127.origin - var_1.origin);
    } else {
      var_11 = vectortoangles(var_0.origin - var_1.origin);
    }

    var_12 = var_1.angles[1] - var_11[1];

    if(var_12 < 0) {
      var_12 = 360 + var_12;
    }

    if(var_8.size + var_9.size == 0) {
      var_1 notify("all_turrets_dead");
      return;
    }

    if(abs(var_8.size - var_9.size) > 3 || var_8.size == 0 || var_9.size == 0) {
      if(var_8.size < var_9.size) {
        var_2 = (0, var_11[1] + 90, 0);
      } else {
        var_2 = (0, var_11[1] - 90, 0);
      }
    } else if(var_12 <= 180)
      var_2 = (0, var_11[1] + 90, 0);
    else {
      var_2 = (0, var_11[1] - 90, 0);
    }

    var_1._id_E739 = var_2;

    if(var_1._id_DF62 == "stopped") {
      if(var_1._id_12B8B) {
        var_1 _meth_845F(50, 35, 25, 15);
      } else {
        var_1 _meth_845F(25, 15, 25, 15);
      }

      var_1 _meth_8455(var_1.origin, 1, var_2);
    } else if(var_3) {
      var_1 _id_0BB8::_id_39D0("idle");
      var_10 = 0;
    }

    wait 0.1;
  }
}

_id_B84E(var_0, var_1, var_2) {
  self endon("no_enemies_in_range");
  self endon("death");
  self endon("new_volume");
  var_1 endon("death");
  self endon("new_target");
  var_3 = self;
  var_4 = [var_3];
  var_4 = scripts\engine\utility::array_combine(var_4, var_3.turrets["cap_turret_small_constant"]);
  var_4 = scripts\engine\utility::array_combine(var_4, var_3._id_8B51["cap_hardpoint_missile_barrage"]);
  var_4 = scripts\engine\utility::array_combine(var_4, var_3._id_8B50["cap_hardpoint_missile_barrage"]);

  foreach(var_6 in var_3._id_65CD) {
    var_4 = scripts\engine\utility::array_add(var_4, var_6._id_2F00[0]);
    var_4 = scripts\engine\utility::array_add(var_4, var_6._id_101B0[0]);
    var_4 = scripts\engine\utility::array_add(var_4, var_6._id_119EA[0]);
    var_4 = scripts\engine\utility::array_add(var_4, var_6._id_4651);
  }

  var_8 = 0;
  var_9 = undefined;
  var_10 = var_3.origin;
  var_11 = 225000000;
  var_12 = 3000;

  if(var_1 == level._id_D127) {
    var_13 = 4000;
    var_14 = 4;
    var_15 = 8;
    var_16 = 4;
    var_17 = 8;
    var_18 = 200;
  } else {
    var_13 = 2000;
    var_14 = 3;
    var_15 = 6;
    var_16 = 3;
    var_17 = 6;
    var_18 = 75;
  }

  var_19 = randomintrange(var_16, var_17);
  var_20 = 0;

  while(isDefined(var_1)) {
    var_21 = distancesquared(var_1.origin, var_3.origin);
    var_22 = var_3.origin[2];
    var_23 = var_1.origin[2];
    var_24 = abs(var_22 - var_23);

    if(var_21 > var_11 || !var_3 istouching(var_0) || var_20 > var_19 || var_24 > var_13) {
      while(isDefined(var_1)) {
        var_25 = (randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-0.15, 0.15));
        var_10 = var_25 * sqrt(var_11) + (var_1.origin[0], var_1.origin[1], var_3.origin[2]);

        if(ispointinvolume(var_10, var_0)) {
          var_4 = scripts\engine\utility::array_removeundefined(var_4);

          if(scripts\common\trace::sphere_trace_passed(var_3.origin, var_10, var_12, var_4)) {
            var_3 _meth_845F(var_18, 40, 25, 15);
            var_3 _id_B85C(var_10, 1, 100, var_3._id_E739);
            var_20 = 100;
            wait(randomintrange(var_14, var_15));
            break;
          }
        }

        wait 0.5;
      }
    }

    wait 0.5;

    if(var_20 > var_19) {
      var_19 = randomintrange(var_16, var_17);
      var_20 = 0;
      continue;
    }

    var_20++;
  }
}

_id_B87D(var_0, var_1) {
  self endon("death");
  self endon("new_volume");
  var_0 endon("death");
  self endon("new_target");
  var_2 = self;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = var_2._id_8B50["cap_hardpoint_missile_barrage"];
  var_6 = var_2._id_8B51["cap_hardpoint_missile_barrage"];
  var_7 = scripts\engine\utility::array_combine(var_5, var_6);

  foreach(var_9 in var_7) {
    var_9._id_FEAD = 0;
  }

  while(isDefined(var_0)) {
    if(var_2._id_DF62 != "always") {
      var_5 = var_2._id_8B50["cap_hardpoint_missile_barrage"];
      var_6 = var_2._id_8B51["cap_hardpoint_missile_barrage"];
      var_7 = scripts\engine\utility::array_combine(var_5, var_6);
      var_11 = vectortoangles(var_0.origin - var_2.origin);
      var_12 = var_2.angles[1] - var_11[1];

      if(var_12 < 0) {
        var_12 = 360 + var_12;
      }

      if(var_12 >= 180) {
        var_3 = var_5;
        var_4 = var_6;
      } else {
        var_3 = var_6;
        var_4 = var_5;
      }

      foreach(var_9 in var_3) {
        if(!isDefined(var_9)) {
          var_3 = scripts\engine\utility::array_remove(var_3, var_9);
          continue;
        }

        if(!isDefined(var_9._id_FEAD)) {
          var_9._id_FEAD = 0;
        }

        if(!var_9._id_FEAD) {
          wait(randomfloatrange(0.5, 1.25));

          if(!isDefined(var_9)) {
            continue;
          }
          var_9 thread _id_B86F(var_0, var_2, var_1);
          var_9._id_FEAD = 1;
        }
      }

      foreach(var_9 in var_4) {
        if(!isDefined(var_9)) {
          var_4 = scripts\engine\utility::array_remove(var_4, var_9);
          continue;
        }

        if(!isDefined(var_9._id_FEAD)) {
          var_9._id_FEAD = 0;
        }

        if(var_9._id_FEAD) {
          var_9 notify("turret_closed");
          var_9._id_FEAD = 0;
        }
      }
    } else {
      for(var_17 = 0; var_17 < 2; var_17++) {
        foreach(var_9 in var_7) {
          if(!isDefined(var_9)) {
            continue;
          }
          if(var_9._id_FEAD) {
            var_9 notify("turret_closed");
            var_9._id_FEAD = 0;
          }
        }
      }
    }

    wait 1;
  }
}

_id_B86F(var_0, var_1, var_2) {
  self endon("turret_closed");
  var_1 endon("death");
  self endon("death");
  var_0 endon("death");
  var_1 endon("new_target");
  var_1 endon("new_volume");
  var_3 = self;
  var_3._id_114FB = var_0;
  var_4 = 1;
  var_5 = 1;
  var_6 = 0;
  var_7 = var_1.turrets["cap_turret_small_constant"];

  if(isDefined(var_3._id_EF5B)) {
    var_3._id_EF5B = undefined;
  }

  if(isDefined(var_0.script_linkto)) {
    var_6 = 1;
  }

  wait(randomfloat(1));

  for(;;) {
    var_5 = randomintrange(2, 5);
    var_8 = var_3 gettagangles("tag_flash");
    var_9 = var_3 gettagorigin("tag_flash");
    var_10 = undefined;
    var_11 = [];

    if(isDefined(var_0.script_linkto)) {
      var_10 = var_0 scripts\sp\utility::_id_7A97();

      foreach(var_13 in var_10) {
        if(isDefined(var_13.script_parameters)) {
          var_10 = scripts\engine\utility::array_remove(var_10, var_13);
        }
      }

      var_10 = scripts\engine\utility::array_randomize(var_10);
      var_15 = 0;

      for(var_16 = 0; var_16 < var_5 * 2; var_16++) {
        if(var_10.size <= var_16) {
          var_10 = scripts\engine\utility::array_randomize(var_10);
          var_15 = 0;
        }

        var_11 = scripts\engine\utility::array_add(var_11, var_10[var_15]);
      }

      var_17 = [];

      foreach(var_19 in var_7) {
        if(isDefined(var_19) && !isDefined(var_19._id_12A01)) {
          for(var_16 = 0; var_16 < var_10.size; var_16++) {
            if(var_19 _meth_8540(var_10[var_16].origin)) {
              var_20 = spawn("script_origin", var_10[var_16].origin);
              var_17[var_17.size] = var_20;
              var_20._id_1153C = 1;
              var_19 thread _id_B869(var_20);
            }
          }

          if(var_17.size > 0) {
            var_19._id_12A01 = var_17;
            var_10 = scripts\engine\utility::array_randomize(var_10);
          }
        }
      }

      var_16 = randomint(var_10.size - 1);
      var_3._id_217B = 0.35;

      if(!isDefined(var_1.shooting_missile_barrage) || isDefined(var_1.shooting_missile_barrage) && !var_1.shooting_missile_barrage) {
        thread _id_0B76::_id_1992("tag_flash", var_10[var_16]);
      } else {
        wait 3;
      }

      var_22 = distancesquared(level._id_D127.origin, var_1.origin);

      if(var_22 < 1600000000) {
        wait(randomfloatrange(0.75, 1.25));
      } else {
        wait 4;
      }

      var_1._id_9829 = 0;
      wait(randomfloatrange(1, 3));
    } else {
      var_3._id_217B = 0.35;

      if(!isDefined(var_1.shooting_missile_barrage) || isDefined(var_1.shooting_missile_barrage) && !var_1.shooting_missile_barrage) {
        thread _id_0B76::_id_1992("tag_flash", var_0);
      } else {
        wait 3;
      }

      var_22 = distancesquared(level._id_D127.origin, var_1.origin);

      if(var_22 < 1600000000) {
        wait(randomfloatrange(0.75, 1.25));
      } else {
        wait 4;
      }

      var_1._id_9829 = 0;
      wait(randomfloatrange(2, 4));
    }

    if(isDefined(var_2)) {
      wait(randomfloat(0.5));
      var_23 = 20;
      var_24 = scripts\engine\utility::get_array_of_closest(var_1.origin, var_2, undefined, var_23);

      if(var_24.size > 0) {
        var_16 = randomint(var_23);

        if(isDefined(var_24[var_16])) {
          if(!isDefined(var_1.shooting_missile_barrage) || isDefined(var_1.shooting_missile_barrage) && !var_1.shooting_missile_barrage) {
            thread _id_0B76::_id_1992("tag_flash", var_24[var_16]);
          } else {
            wait 3;
          }

          wait(randomfloatrange(0.5, 0.75));
        }
      }
    }
  }
}

_id_B869(var_0) {
  scripts\engine\utility::waittill_any_timeout(randomfloatrange(3, 5), "death");
  var_0._id_1153C = 0;
  var_0 delete();
}

_id_B87B(var_0, var_1) {
  self endon("death");
  self endon("new_volume");
  self endon("new_target");

  if(isDefined(self._id_7486) && self._id_7486) {
    self waittill("ftl_complete");
  }

  var_2 = self;
  var_3 = [var_2];

  while(!isDefined(var_2.turrets["cap_turret_small_constant"])) {
    wait 0.05;
  }

  while(!isDefined(var_2._id_8B51["cap_hardpoint_missile_barrage"])) {
    wait 0.05;
  }

  while(!isDefined(var_2._id_8B50["cap_hardpoint_missile_barrage"])) {
    wait 0.05;
  }

  var_3 = scripts\engine\utility::array_combine(var_3, var_2.turrets["cap_turret_small_constant"]);
  var_3 = scripts\engine\utility::array_combine(var_3, var_2._id_8B51["cap_hardpoint_missile_barrage"]);
  var_3 = scripts\engine\utility::array_combine(var_3, var_2._id_8B50["cap_hardpoint_missile_barrage"]);

  foreach(var_5 in var_2._id_65CD) {
    var_3 = scripts\engine\utility::array_add(var_3, var_5._id_2F00[0]);
    var_3 = scripts\engine\utility::array_add(var_3, var_5._id_101B0[0]);
    var_3 = scripts\engine\utility::array_add(var_3, var_5._id_119EA[0]);
    var_3 = scripts\engine\utility::array_add(var_3, var_5._id_4651);
  }

  var_7 = 3000;
  var_8 = undefined;
  var_2 notify("no_enemies_in_range");

  if(var_2._id_DF62 != "stopped") {
    var_2._id_DF62 = "stopped";
    _id_0BB8::_id_39CD("idle");
  }

  var_9 = 0;
  var_10 = var_2.origin;

  for(;;) {
    if(ispointinvolume(var_10, var_0)) {
      var_3 = scripts\engine\utility::array_removeundefined(var_3);

      if(scripts\common\trace::sphere_trace_passed(var_2.origin, var_10, var_7, var_3)) {
        var_2 _meth_845F(200, 180, 40, 20);

        if(!isDefined(var_2._id_E739)) {
          var_2 _id_B85C(var_10, 1, undefined, (0, var_2.angles[1], 0));
        } else {
          var_2 _id_B85C(var_10, 1, undefined, var_2._id_E739);
        }

        break;
      } else {
        var_8 = (randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-0.25, 0.25));
        var_10 = var_8 * 3000 + var_2.origin;
      }
    }

    wait 0.05;
  }

  var_11 = var_2._id_8B50["cap_hardpoint_missile_barrage"];
  var_12 = var_2._id_8B51["cap_hardpoint_missile_barrage"];
  var_13 = 0;

  foreach(var_15 in var_11) {
    if(!isDefined(var_15)) {
      continue;
    }
    if(var_15._id_FEAD) {
      var_15 notify("turret_closed");
      var_15._id_FEAD = 0;
    }
  }

  foreach(var_15 in var_12) {
    if(!isDefined(var_15)) {
      continue;
    }
    if(var_15._id_FEAD) {
      var_15 notify("turret_closed");
      var_15._id_FEAD = 0;
    }
  }

  for(;;) {
    foreach(var_20 in var_1) {
      if(isDefined(var_20) && ispointinvolume(var_20.origin, var_0)) {
        var_13 = var_13 + 1;
      }
    }

    if(var_13 > 0 || var_2._id_12B8B) {
      break;
    } else
      wait 0.5;

    var_2 notify("no_enemies_in_range");
    wait 0.5;
  }

  wait 0.5;
}

_id_B85C(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("new_volume");
  self endon("new_target");

  if(self._id_DF62 == "stopped") {
    self._id_DF62 = "heavy";
    _id_0BB8::_id_39CD("heavy");

    if(!isDefined(var_2)) {
      var_2 = 1000.0;
    }

    if(isDefined(var_3)) {
      self _meth_8455(var_0, var_1, var_3);
    } else {
      self _meth_8455(var_0, var_1);
    }

    self setneargoalnotifydist(var_2);
    var_4 = distance(var_0, self.origin);

    if(var_4 > var_2) {
      self waittill("near_goal");
    }

    self._id_DF62 = "stopped";
    self._id_9829 = 0;
    _id_0BB8::_id_39CD("idle");
  }
}

_id_B875(var_0, var_1) {
  self endon("death");
  self endon("new_volume");
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = 0;
  var_8 = undefined;
  var_9 = distancesquared(self.origin, var_0.origin);

  foreach(var_11 in var_1) {
    var_12 = getcsplinepointcount(var_11) - 1;
    var_13 = getcsplinepointposition(var_11, var_12);

    if(ispointinvolume(var_13, var_0)) {
      var_3 = getcsplinepointposition(var_11, 0);
      var_4 = distancesquared(self.origin, var_3);

      if(!isDefined(var_8) || isDefined(var_8) && var_4 < var_8) {
        var_5 = var_3;
        var_8 = var_4;
        var_7 = var_8;
        var_14 = distancesquared(var_3, var_0.origin);

        if(var_14 < var_9) {
          var_2 = var_11;
        } else {
          var_6 = var_11;
        }
      }
    }
  }

  if(!isDefined(var_2)) {
    var_2 = var_6;
  }

  if(isDefined(var_2)) {
    var_16 = vectorNormalize(var_5 - self.origin);
    var_17 = anglesToForward(self.angles);
    var_18 = vectordot(var_17, var_16);
    self _meth_845F(250, 35, 50, 25);

    if(var_18 < 0.7) {
      _id_0BB8::_id_39D0("heavy");
      var_19 = vectortoangles(var_5 - self.origin);
      self setneargoalnotifydist(100);
      self _meth_8455(self.origin, 1, (0, var_19[1], 0));

      for(var_20 = 0; var_18 < 0.8 || var_20 < 10; var_20++) {
        var_16 = vectorNormalize(var_5 - self.origin);
        var_17 = anglesToForward(self.angles);
        var_18 = vectordot(var_17, var_16);
        wait 0.5;
      }

      self._id_DF62 = "heavy";
      _id_0BB8::_id_39CD("heavy");
      _id_0BB8::_id_39D0("idle");
      wait 0.5;
    }

    self setneargoalnotifydist(1000);
    _id_B85C(var_5);
    _id_0BB8::_id_39CD("launch");

    if(self._id_DF62 != "launch") {
      self._id_DF62 = "launch";
      _id_0BB8::_id_39CD("launch");
    }

    self _meth_8491("fly");
    _id_B872(var_2);
    self _meth_847A();
    self _meth_8491("hover");
  } else {}
}

_id_B872(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 0.2;
  }

  self _meth_8479(var_0);

  if(isDefined(var_2)) {
    self _meth_847B(var_1, var_2);
  } else {
    self _meth_847B(var_1);
  }

  self._id_10A43 = var_0;
  self waittill("near_goal");
  self notify("end_spline");
  _id_B871(var_0);
}

_id_B871(var_0) {
  var_1 = getcsplinepointcount(var_0) - 1;
  var_2 = getcsplinepointlabel(var_0, var_1);

  if(isDefined(var_2) && var_2 != "") {
    var_3 = getcsplinepointstring(var_0, var_1);

    if(isDefined(var_3) && var_2 != "") {
      self notify("splinenode_label", var_2, var_0, var_1, var_3);
    } else {
      self notify("splinenode_label", var_2, var_0, var_1);
    }
  }
}

_id_B870(var_0) {
  var_1 = scripts\sp\utility::_id_10808();
  var_1 hide();
  var_1._id_74A6 = 1;
  var_1 _meth_8554(200, 10, 1, 1500, 10, 1, 0.25);

  if(isDefined(var_0)) {
    var_1 scripts\engine\utility::delaythread(var_0, ::_id_B859);
  } else {
    var_1 thread _id_B859();
  }

  return var_1;
}

_id_B859() {
  self endon("death");
  self._id_7486 = 1;
  var_0 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);

  if(soundexists("capitalship_npc_enemy_ftl_in")) {
    self playSound("capitalship_npc_enemy_ftl_in");
  }

  wait 0.25;
  self setneargoalnotifydist(100);
  self _meth_845F(600, 5000, 20, 10);
  var_1 = anglesToForward(self.angles);
  var_1 = vectorNormalize(var_1);
  var_2 = var_1 * 13500 + self.origin;
  self _meth_8455(var_2, 1, (0, self.angles[1], 0));
  thread _id_7476();
  wait 0.1;
  self _meth_845F(175, 150, 20, 8);
  wait 0.15;
  self show();
  self._id_74A6 = undefined;
  _id_0BB6::_id_39EE(0);
  _id_0BB8::_id_39D0("off");
  _id_0BB8::_id_39CD("launch");
  scripts\engine\utility::delaythread(0.9, _id_0BB8::_id_39CD, "idle");
  _id_0BB8::_id_39CE("off");
  _id_0BB8::_id_397E();
  _id_0BB8::_id_39C8();
  thread scripts\engine\utility::play_loop_sound_on_entity("ajak_engine_lfe");
  wait 3.0;
  var_0 delete();
  self._id_7486 = 0;
  self notify("ftl_complete");
}

_id_7476() {
  var_0 = self.origin;

  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(level._id_58D9)) {
    return;
  }
  level._id_58D9 = 1;
  var_1["r_mbenable"] = getDvar("r_mbenable");
  var_1["r_mbRadialOverridePosition"] = getDvar("r_mbRadialOverridePosition");
  var_1["r_mbRadialOverridePositionActive"] = getdvarint("r_mbRadialOverridePositionActive");
  var_1["r_mbradialoverridestrength"] = getdvarfloat("r_mbradialoverridestrength");
  var_1["r_mbradialoverrideradius"] = getdvarfloat("r_mbradialoverrideradius");
  setsaveddvar("r_mbenable", 1);
  setsaveddvar("r_mbRadialOverridePosition", var_0);
  setsaveddvar("r_mbRadialOverridePositionActive", 1);
  var_2 = 0.25;
  var_3 = var_2 * 0.04;
  var_4 = 1000;
  var_5 = 60000;
  var_6 = distance2d(level._id_D127.origin, var_0);
  var_7 = scripts\sp\math::_id_C097(var_5, var_4, var_6);
  var_8 = scripts\sp\math::_id_6A8E(var_2, var_3, var_7);
  level.player earthquakeforplayer(var_8 * 4, 0.5, level._id_D127.origin, 20000);
  playFXOnTag(scripts\engine\utility::getfx("missileboat_ca_warp_pre"), self, "tag_origin");

  if(!scripts\common\trace::ray_trace_passed(var_0 + (0, 0, 12), level.player getEye())) {
    var_8 = var_8 * 0.5;
  }

  if(getdvarint("debug_frag_mb")) {
    iprintln("Naromalized value is " + var_7);
    iprintln("Dist is " + var_6 + " Strength is " + var_8);
  }

  setsaveddvar("r_mbradialoverridestrength", var_8);
  setsaveddvar("r_mbradialoverrideradius", -0.107266);
  wait 0.05;
  var_9 = 0.5;
  thread scripts\sp\utility::_id_AB9A("r_mbradialoverridestrength", var_1["r_mbradialoverridestrength"], var_9);
  thread scripts\sp\utility::_id_AB9A("r_mbradialoverrideradius", var_1["r_mbradialoverrideradius"], var_9);
  wait(var_9);
  setsaveddvar("r_mbenable", var_1["r_mbenable"]);
  setsaveddvar("r_mbRadialOverridePosition", var_1["r_mbRadialOverridePosition"]);
  setsaveddvar("r_mbRadialOverridePositionActive", var_1["r_mbRadialOverridePositionActive"]);
  level._id_58D9 = undefined;
}

_id_F04B(var_0) {
  while(isDefined(self._id_74A6)) {
    wait 0.05;
  }

  if(!isDefined(level._id_F04D)) {
    level._id_F04D = [];
  }

  if(!isDefined(level._id_F02D)) {
    level._id_F02D = [];
  }

  level._id_F04D = scripts\engine\utility::array_add(level._id_F04D, self);
  level._id_F02D = scripts\engine\utility::array_add(level._id_F02D, self);
  self._id_3775 = 0;
  self._id_1153F = 0;
  self._id_56EA = 9999999;
  self._id_5ABB = -1;
  self._id_D436 = 0;
  var_1 = scripts\engine\utility::array_combine(self._id_8B50["cap_hardpoint_missile_barrage"], self._id_8B51["cap_hardpoint_missile_barrage"]);

  foreach(var_3 in var_1) {
    var_3._id_EF63 = 2000;
    var_3._id_EF5A = 25;
    var_3._id_EF61 = "missileboat_missile_flare";
  }

  _id_0BA9::_id_9799(2, 5, 1, 2);
  _id_0BA9::_id_B862();
  _id_0BA9::_id_F2F5(::_id_B84D);
  thread _id_0BA9::_id_396F(var_0);
}

_id_B84D() {
  if(isDefined(self._id_9278) && self._id_9278) {
    return 1;
  }

  if(!isDefined(self._id_DF62)) {
    return 0;
  }

  if(length(self.spaceship_vel) > 100) {
    return 0;
  }

  if(self._id_DF62 != "stopped") {
    return 0;
  }

  return 1;
}

_id_B85F() {
  thread _id_0BB2::_id_B850(self);
}

_id_77D2(var_0) {
  var_1 = getcsplineidarray("missileboat_start", "targetname");
  var_2 = [];
  var_3 = [];

  foreach(var_5 in var_1) {
    var_6 = getcsplinepointposition(var_5, 0);

    if(ispointinvolume(var_6, self._id_24CE)) {
      var_2[var_2.size] = var_5;
    }
  }

  foreach(var_9 in var_0) {
    foreach(var_5 in var_2) {
      var_11 = getcsplinepointcount(var_5) - 1;
      var_12 = getcsplinepointposition(var_5, var_11);

      if(ispointinvolume(var_12, var_9)) {
        var_3[var_3.size] = var_9;
        break;
      }
    }
  }

  return var_3;
}