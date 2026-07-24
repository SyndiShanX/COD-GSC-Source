/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2985.gsc
**************************************/

_id_39B3(var_0, var_1, var_2) {
  scripts\sp\vehicle_build::_id_31A3(999, 500, 1500);

  if(issubstr(var_2, "mons") && level.script != "marscrash") {
    scripts\sp\vehicle_build::_id_31B8("mig_rumble", 0.2, 0.15, 1000000, 0.05, 0.05);
  } else {
    scripts\sp\vehicle_build::_id_31B8("mig_rumble", 0.2, 0.15, 20300, 0.05, 0.05);
  }

  scripts\sp\vehicle_build::_id_31C4("axis");
  scripts\sp\vehicle_build::_id_319F();
  scripts\sp\vehicle_build::_id_31C6(var_2, "default", "vfx/iw7/core/tread/vfx_treadfx_capship_dust_02.vfx", 0);
  scripts\sp\vehicle_build::_id_3186(var_0, "tag_origin");
  _id_39C7(var_0);

  if(issubstr(var_2, "cheap")) {
    _id_3995(var_1, var_2);
  } else if(issubstr(var_2, "periph")) {
    _id_3995(var_1, var_2);
  } else {
    _id_3994(var_1);
  }
}

_id_396E(var_0) {
  self._id_6A8D = var_0;
  self._id_9B82 = 1;
  self._id_C721 = self.classname;
  thread _id_3998();
  thread _id_39D4();

  if(self.classname != "script_vehicle_capitalship_missileboat_ca") {
    thread _id_0BB6::_id_39E8();
  }

  thread _id_3981();
  thread _id_3972();
  thread _id_396C();
  thread _id_39A6();

  if(issubstr(self.classname, "periph")) {
    thread _id_246C(self.model);
  } else if(issubstr(self.classname, "cheap")) {
    thread _id_246C(self.model);
    thread scripts\engine\utility::delaythread(0.1, _id_0BB8::_id_397F, 1, 0);
  } else {
    thread _id_246C(self.model);
    thread scripts\engine\utility::delaythread(0.1, _id_0BB8::_id_397F, 1, 1);
  }

  self._id_9310 = 1;
  self._id_55A4 = 1;
  self._id_A8EA = -99999;
  self._id_B83F = 0;
  self._id_B794 = 3;
  self._id_B795 = 0;
  self._id_126F3 = 5000;
  self._id_126F4 = 1;
  self castspotshadows(1);
}

_id_3972() {
  self endon("entitydeleted");
  self waittill("death");
  _id_0BB6::_id_398A(0);
  _id_0BB8::_id_39CD("off");
  _id_0BB8::_id_39D0("off");
  _id_0BB8::_id_39CE("off");

  if(isDefined(self._id_12FF3)) {
    if(isDefined(self._id_10250)) {
      var_0 = 1;
    } else {
      var_0 = 0;
    }

    _id_39AA(self.origin, var_0);
    self delete();
  } else {
    if(isDefined(self._id_BFE3)) {
      return;
    }
    var_1 = spawn("script_model", self.origin);
    var_1 setModel("tag_origin");
    var_1.angles = self.angles;

    if(soundexists("capital_ship_explo")) {
      var_1 playSound("capital_ship_explo");
      var_1 scripts\engine\utility::delaycall(randomfloatrange(1.0, 2.5), ::playsound, "capital_ship_explo_jackal_debris");
    } else {}

    if(isDefined(self._id_4E09)) {
      playFXOnTag(level._effect[self._id_4E09], var_1, "tag_origin");
      return;
    }

    playFXOnTag(level._effect["vfx_generic_ship_death"], var_1, "tag_origin");
  }
}

_id_39A6() {
  self endon("death");
  self.health = 99999;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);
    self.health = 99999;
  }
}

_id_396C() {
  scripts\engine\utility::waittill_any("death", "entitydeleted", "delete_cleanup");
  _id_0BB6::_id_39E1();
  _id_0BB8::_id_39C5();
  _id_EA02(self._id_10381);

  if(isDefined(self._id_4074)) {
    foreach(var_1 in self._id_4074) {
      if(isDefined(var_1)) {
        var_1 delete();
      }
    }

    self._id_4074 = [];
  }
}

_id_397B() {
  if(isDefined(self)) {
    self._id_BFE3 = 1;
    self notify("delete_cleanup");
    wait 0.1;
    var_0 = [];

    if(isDefined(self._id_65CD)) {
      foreach(var_2 in self._id_65CD) {
        var_0 = scripts\engine\utility::array_add(var_0, var_2._id_2F00[0]);
        var_0 = scripts\engine\utility::array_add(var_0, var_2._id_101B0[0]);
        var_0 = scripts\engine\utility::array_add(var_0, var_2._id_119EA[0]);
        var_0 = scripts\engine\utility::array_add(var_0, var_2._id_4651);
      }

      foreach(var_5 in var_0) {
        if(isDefined(var_5)) {
          var_5 delete();
        }
      }
    }

    self delete();
  }
}

_id_246C(var_0) {
  wait 0.2;

  if(issubstr(var_0, "_rig") && !issubstr(var_0, "_sa_")) {
    if(isDefined(self._id_B210)) {
      self attach(self._id_B210, "TAG_ORIGIN");
    } else if(issubstr(self.classname, "_cheap")) {
      var_0 = getsubstr(var_0, 0, var_0.size - 4);
      var_0 = var_0 + "_periph";
      self attach(var_0, "TAG_ORIGIN");
    } else {
      var_0 = getsubstr(var_0, 0, var_0.size - 4);
      self attach(var_0, "TAG_ORIGIN");
    }
  }
}

_id_3994(var_0) {
  if(!isDefined(level._id_3997)) {
    level._effect["light_blue_small"] = loadfx("vfx/iw7/core/light/vfx_blue_light_sml.vfx");
    level._effect["light_red_small"] = loadfx("vfx/core/lights/vfx_orange_lights_med.vfx");
    level._effect["light_blue_large"] = loadfx("vfx/iw7/core/light/vfx_blue_light_lrg.vfx");
    level._effect["light_red_large"] = loadfx("vfx/core/lights/vfx_red_lights_big.vfx");
    level._effect["flak_omni_space"] = loadfx("vfx/iw7/core/vehicle/capship/vfx_capship_flak_omni_space_opt.vfx");
    level._effect["flak_wall_space"] = loadfx("vfx/iw7/core/vehicle/capship/vfx_capship_flak_wall_space.vfx");
    level._effect["phalanx_burst_fire"] = loadfx("vfx/iw7/core/vehicle/capship/vfx_capship_phalanx_spray_space.vfx");
    level._effect["miniflak_muzzle"] = loadfx("vfx/iw7/core/vehicle/capship/vfx_capship_flak_mini_muzz.vfx");
    level._effect["miniflak_trace"] = loadfx("vfx/iw7/core/vehicle/capship/vfx_capship_flak_mini_trace.vfx");
    level._effect["miniflak"] = loadfx("vfx/iw7/core/vehicle/capship/vfx_capship_flak_mini.vfx");
    level._effect["damage_heavy_fire"] = loadfx("vfx/iw7/core/vehicle/capship/vfx_capship_damage_heavy_fire.vfx");
    level._effect["missile_flare_generic"] = loadfx("vfx/iw7/core/vehicle/jackal/vfx_player_missile.vfx");
    level._effect["jet_missile_imp_water"] = loadfx("vfx/old/space_fighter/vfx_jet_missile_imp_water.vfx");
    level._effect["jet_missile_imp_generic"] = loadfx("vfx/iw7/levels/moon/vfx_jet_missile_imp_generic_moon.vfx");
    level._effect["jet_missile_imp_airburst"] = loadfx("vfx/iw7/levels/moon/vfx_jet_missile_imp_generic_moon_premature.vfx");
    level._effect["vfx_generic_ship_death"] = loadfx("vfx/iw7/core/expl/vehicle/vfx_destroyer_death_dps.vfx");
    level._effect["vfx_capship_ca_death_small"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_death_small.vfx");
    level._effect["vfx_capship_ca_death_med"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_death_med.vfx");
    level._effect["vfx_capship_ca_death_large"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_death_large.vfx");
    level._effect["vfx_capship_ca_death_huge"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_death_huge.vfx");
    level._id_3997 = 1;
  }

  if(var_0 == "un" && !isDefined(level._id_399A)) {
    level._effect["un_thruster_down_sml_idle"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_down_sml_idle.vfx");
    level._effect["un_thruster_down_sml_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_down_sml_heavy.vfx");
    level._effect["un_thruster_down_sml_launch"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_down_sml_heavy.vfx");
    level._effect["un_thruster_down_med_idle"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_down_med_idle.vfx");
    level._effect["un_thruster_down_med_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_down_med_heavy.vfx");
    level._effect["un_thruster_down_med_launch"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_down_med_launch.vfx");
    level._effect["un_thruster_down_lrg_idle"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_down_lrg_idle.vfx");
    level._effect["un_thruster_down_lrg_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_down_lrg_heavy.vfx");
    level._effect["un_thruster_down_lrg_launch"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_down_lrg_launch.vfx");
    level._effect["un_thruster_rear_med_idle"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_rear_med_idle.vfx");
    level._effect["un_thruster_rear_med_light"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_rear_med_light.vfx");
    level._effect["un_thruster_rear_med_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_rear_med_heavy.vfx");
    level._effect["un_thruster_rear_med_launch"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_rear_med_launch.vfx");
    level._effect["un_thruster_rear_lrg_idle"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_rear_lrg_idle.vfx");
    level._effect["un_thruster_rear_lrg_idle_light"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_rear_lrg_idle_light.vfx");
    level._effect["un_thruster_rear_lrg_light"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_rear_lrg_light.vfx");
    level._effect["un_thruster_rear_lrg_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_rear_lrg_heavy.vfx");
    level._effect["un_thruster_rear_lrg_launch"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_rear_lrg_launch.vfx");
    level._id_399A = 1;
  }

  if(var_0 == "ca" && !isDefined(level._id_3993)) {
    level._effect["ca_thruster_down_sml_idle"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_down_sml_idle.vfx");
    level._effect["ca_thruster_down_sml_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_down_sml_heavy.vfx");
    level._effect["ca_thruster_down_sml_launch"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_down_sml_launch.vfx");
    level._effect["ca_thruster_down_med_idle"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_down_med_idle.vfx");
    level._effect["ca_thruster_down_med_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_down_med_heavy.vfx");
    level._effect["ca_thruster_down_lrg_idle"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_down_lrg_idle.vfx");
    level._effect["ca_thruster_down_lrg_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_down_lrg_heavy.vfx");
    level._effect["ca_thruster_down_lrg_launch"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_down_lrg_launch.vfx");
    level._effect["ca_thruster_rear_sml_idle"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_rear_sml_idle.vfx");
    level._effect["ca_thruster_rear_sml_light"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_rear_sml_light.vfx");
    level._effect["ca_thruster_rear_sml_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_rear_sml_heavy.vfx");
    level._effect["ca_thruster_rear_sml_burst"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_rear_sml_heavy_burst.vfx");
    level._effect["ca_thruster_rear_sml_launch"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_rear_sml_launch.vfx");
    level._effect["ca_thruster_rear_med_idle"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_rear_med_idle.vfx");
    level._effect["ca_thruster_rear_med_light"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_rear_med_light.vfx");
    level._effect["ca_thruster_rear_med_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_rear_med_heavy.vfx");
    level._effect["ca_thruster_rear_med_burst"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_rear_med_heavy_burst.vfx");
    level._effect["ca_thruster_rear_med_launch"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_rear_med_launch.vfx");
    level._effect["ca_thruster_rear_lrg_idle"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_rear_lrg_idle.vfx");
    level._effect["ca_thruster_rear_lrg_light"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_rear_lrg_light.vfx");
    level._effect["ca_thruster_rear_lrg_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_rear_lrg_heavy.vfx");
    level._effect["ca_thruster_rear_lrg_burst"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_rear_lrg_heavy_burst.vfx");
    level._effect["ca_thruster_rear_lrg_launch"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_rear_lrg_launch.vfx");
    level._id_3993 = 1;
  }
}

_id_3995(var_0, var_1) {
  if(!isDefined(level._id_3996)) {
    level._effect["light_blue_small"] = loadfx("vfx/iw7/core/light/vfx_blue_light_sml.vfx");
    level._effect["light_red_small"] = loadfx("vfx/core/lights/vfx_orange_lights_med.vfx");
    level._effect["light_blue_large"] = loadfx("vfx/iw7/core/light/vfx_blue_light_lrg.vfx");
    level._effect["light_red_large"] = loadfx("vfx/core/lights/vfx_red_lights_big.vfx");
    level._id_3996 = 1;
  }

  if(var_0 == "un" && !isDefined(level._id_3999)) {
    level._effect["un_thruster_down_sml_idle"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_down_sml_idle.vfx");
    level._effect["un_thruster_down_sml_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_down_sml_heavy.vfx");
    level._effect["un_thruster_down_med_idle"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_down_med_idle.vfx");
    level._effect["un_thruster_down_med_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_down_med_heavy.vfx");
    level._effect["un_thruster_down_lrg_idle"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_down_lrg_idle.vfx");
    level._effect["un_thruster_down_lrg_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_down_lrg_heavy.vfx");
    level._effect["un_thruster_rear_med_idle"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_rear_med_idle.vfx");
    level._effect["un_thruster_rear_med_light"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_rear_med_light.vfx");
    level._effect["un_thruster_rear_lrg_idle"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_rear_lrg_idle.vfx");
    level._effect["un_thruster_rear_lrg_light"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_rear_lrg_light.vfx");
    level._effect["un_thruster_rear_med_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_rear_med_heavy.vfx");
    level._effect["un_thruster_rear_lrg_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/un/vfx_capship_un_thruster_rear_lrg_heavy.vfx");
    level._id_3999 = 1;
  }

  if(var_0 == "ca" && !isDefined(level._id_3992)) {
    level._effect["ca_thruster_down_sml_idle"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_down_sml_idle.vfx");
    level._effect["ca_thruster_down_sml_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_down_sml_heavy.vfx");
    level._effect["ca_thruster_down_med_idle"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_down_med_idle.vfx");
    level._effect["ca_thruster_down_med_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_down_med_heavy.vfx");
    level._effect["ca_thruster_down_lrg_idle"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_down_lrg_idle.vfx");
    level._effect["ca_thruster_down_lrg_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_down_lrg_heavy.vfx");
    level._effect["ca_thruster_rear_sml_idle"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_rear_sml_idle.vfx");
    level._effect["ca_thruster_rear_sml_light"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_rear_sml_light.vfx");
    level._effect["ca_thruster_rear_med_idle"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_rear_med_idle.vfx");
    level._effect["ca_thruster_rear_med_light"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_rear_med_light.vfx");
    level._effect["ca_thruster_rear_lrg_idle"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_rear_lrg_idle.vfx");
    level._effect["ca_thruster_rear_lrg_light"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_rear_lrg_light.vfx");
    level._effect["ca_thruster_rear_sml_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_rear_sml_heavy.vfx");
    level._effect["ca_thruster_rear_med_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_rear_med_heavy.vfx");
    level._effect["ca_thruster_rear_lrg_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_thruster_rear_lrg_heavy.vfx");
    level._id_3992 = 1;
  }
}

_id_3998() {
  var_0 = "blue";

  if(self._id_6A8D == "ca") {
    var_0 = "red";
  }

  _id_0BB8::_id_7561("light_lod_high", "fx_light_main_a_1", "light_" + var_0 + "_large");
  _id_0BB8::_id_7562("light_lod_high", "fx_light_running_lrg_b1", "light_" + var_0 + "_small");
  _id_0BB8::_id_7562("light_lod_high", "fx_light_running_lrg_b2", "light_" + var_0 + "_small");
  _id_0BB8::_id_7562("light_lod_high", "fx_light_running_lrg_b3", "light_" + var_0 + "_small");
  _id_0BB8::_id_7562("light_lod_high", "fx_light_running_lrg_b4", "light_" + var_0 + "_small");
  thread _id_0BB8::_id_39CE("high");
}

_id_39D4() {}

_id_3981() {
  self._id_5020 = "idle";
  self._id_501F = "idle";

  if(isDefined(self._id_ED7C)) {
    var_0 = strtok(self._id_ED7C, " ");

    if(var_0.size != 2) {}

    self._id_5020 = var_0[0];
    self._id_501F = var_0[1];
  }

  waittillframeend;
  thread _id_0BB8::_id_39CD(self._id_5020);
  thread _id_0BB8::_id_39D0(self._id_501F);
}

_id_39C7(var_0) {
  var_1 = _id_7C33(var_0);
  var_2 = scripts\engine\utility::getStruct(var_1, "targetname");

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = scripts\engine\utility::getStructArray(var_2.target, "targetname");

  if(!isDefined(var_3) || var_3.size == 0) {
    return;
  }
  foreach(var_5 in var_3) {
    precachemodel(var_5.script_parameters);
  }
}

_id_7C33(var_0) {
  var_1 = var_0 + "_scriptables";

  switch (var_0) {
    case "veh_mil_air_ca_destroyer_sa_breach":
      var_1 = "veh_mil_air_ca_destroyer_scriptables";
      break;
    case "veh_mil_air_ca_destroyer_sa_rig":
      var_1 = "veh_mil_air_ca_destroyer_rig_scriptables";
      break;
    case "veh_mil_air_ca_olympus_mons_sa_rig":
      var_1 = "veh_mil_air_ca_olympus_mons_scriptables_heistspace";
      break;
    case "veh_mil_air_ca_destroyer_yard_end":
      var_1 = "veh_mil_air_ca_destroyer_rig_scriptables_yard";
      break;
    default:
      break;
  }

  return var_1;
}

_id_39C9() {
  var_0 = _id_7C33(self.model);

  if(isDefined(self._id_EF30)) {
    var_0 = _id_7C33(self._id_EF30);
  }

  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");

  if(!isDefined(var_1)) {}

  if(!isDefined(var_1.angles)) {
    var_1.angles = (0, 0, 0);
  }

  var_2 = scripts\engine\utility::getStructArray(var_1.target, "targetname");

  if(!isDefined(var_2) || var_2.size == 0) {}

  if(!isDefined(self._id_EF3C)) {
    self._id_EF3C = [];
  }

  foreach(var_4 in var_2) {
    var_5 = var_4.origin - var_1.origin;
    var_5 = rotatevector(var_5, self.angles);

    if(!isDefined(var_4.angles)) {
      var_4.angles = (0, 0, 0);
    }

    var_6 = transformmove(self.origin, self.angles, var_1.origin, var_1.angles, var_4.origin, var_4.angles);
    var_7 = spawn("script_model", var_6["origin"]);
    var_7 setModel(var_4.script_parameters);
    var_7.angles = var_6["angles"];
    var_7 linkTo(self);
    var_7 setCanDamage(1);
    self._id_EF3C[self._id_EF3C.size] = var_7;
  }

  if(isDefined(self._id_539C) && isDefined(self._id_539C[1]) && isDefined(self._id_539B[2])) {
    self detach(self._id_539C[1], "TAG_ORIGIN");
    thread _id_0BB8::_id_16C4(self._id_539B[2], 2);
  }
}

_id_48AF(var_0) {
  for(var_1 = 1; var_1 <= self._id_C1FB; var_1++) {
    if(var_1 < 10) {
      var_2 = "0";
    } else {
      var_2 = "";
    }

    precachemodel(self._id_CB56 + var_2 + var_1);
  }

  precachemodel(self._id_E505);
  level._id_3979[var_0] = self;
}

_id_ACEB(var_0) {
  while(!isDefined(level._id_D127)) {
    wait 0.05;
  }

  for(;;) {
    wait 0.05;
  }
}

_id_39AA(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = self.origin;
  }

  self._id_BFE3 = 1;

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!var_1) {
    _id_39BE(var_0);
  }

  var_3 = _id_3977();
  var_3 _meth_82A2(level._id_3979[var_3.type]._id_1FAF);
  var_3 thread _id_3974(var_0, var_2);
  var_3 thread _id_3975();
  self notify("death");

  if(!isDefined(level._id_3971)) {
    level._id_3971 = [];
  }

  level._id_3971 = scripts\engine\utility::array_add(level._id_3971, var_3);
  return var_3;
}

_id_39AC() {
  self._id_BFE3 = 1;
  var_0 = _id_3977();
  var_0 _meth_82A2(level._id_3979[var_0.type]._id_1FAF);
  var_0 _meth_82B0(level._id_3979[var_0.type]._id_1FAF, 1);
  self notify("death");
  return var_0;
}

_id_39AD() {}

_id_39AB() {
  foreach(var_1 in self._id_CB53) {
    var_1 delete();
  }

  self delete();
}

_id_3974(var_0, var_1) {
  self playSound(level._id_3979[self.type]._id_FB8C);
  playFX(level._id_3979[self.type]._id_7582, self.origin, anglesToForward(self.angles), anglestoup(self.angles));

  if(!isDefined(level._id_1024A)) {
    if(scripts\engine\utility::is_true(level._id_12FB6) == 1) {
      playFX(level._id_3979[self.type]._id_7571, self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    } else {
      playFX(level._id_3979[self.type]._id_7570, self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    }
  }

  if(scripts\engine\utility::player_is_in_jackal()) {
    thread _id_395F();
    var_2 = 0.2;
    var_3 = 4.0;
    var_4 = distance(level._id_D127.origin, var_0);
    var_5 = scripts\sp\math::_id_C097(7000, 100000, var_4);
    var_6 = scripts\sp\math::_id_6A8E(130, 0, var_5);
    var_7 = scripts\sp\math::_id_6A8E(0.8, 0, var_5);
    var_8 = scripts\sp\math::_id_6A8E(0.25, 0, var_5);
    var_9 = scripts\sp\math::_id_6A8E(0.45, 0.2, var_5);
    earthquake(var_9, 1.9, level._id_D127.origin, 25000);
    var_5 = scripts\sp\math::_id_C097(2000, 25000, var_4);
    var_10 = scripts\sp\math::_id_6A8E(0.75, 2.5, var_5);
    scripts\engine\utility::delaycall(var_10, ::playsound, "capital_ship_explo_jackal_debris");

    if(isDefined(level._id_A056) && isDefined(var_1) && var_1) {
      [[level._id_A056._id_3A02]](var_0, var_6, var_7, var_8, var_2, var_3);
    }
  }
}

_id_395F() {
  level.player endon("flag_player_dismounting");

  for(;;) {
    if(isDefined(level._id_D127) && isDefined(self)) {
      var_0 = distancesquared(level._id_D127.origin, self.origin);

      if(var_0 < 400000000) {
        while(var_0 < 400000000) {
          if(!isDefined(level._id_D127._id_4E93)) {
            level._id_D127._id_4E93 = spawn("script_origin", level._id_D127.origin);
            level._id_D127._id_4E93 linkTo(level._id_D127);
            wait 0.05;
            level._id_D127._id_4E93 _meth_8278(0);
            level._id_D127._id_4E93 playLoopSound("jackal_debris_lp_sfx");
          }

          var_1 = var_0 / 20000;
          var_2 = scripts\sp\math::_id_C097(2500, 20000, var_1);
          var_2 = (var_2 - 1) * -1;

          if(isDefined(level._id_D127._id_4E93)) {
            level._id_D127._id_4E93 _meth_8278(var_2, 0.1);
          }

          wait 0.1;
          var_0 = distancesquared(level._id_D127.origin, self.origin);
        }

        if(isDefined(level._id_D127._id_4E93)) {
          level._id_D127._id_4E93 _meth_8278(0, 0.5);
        }

        wait 0.5;

        if(isDefined(level._id_D127._id_4E93)) {
          level._id_D127._id_4E93 stoploopsound("jackal_debris_lp_sfx");
          level._id_D127._id_4E93 delete();
        }
      }
    }

    wait 0.1;
  }
}

_id_3975() {
  var_0 = 3;
  var_1 = 4;

  foreach(var_3 in self._id_CB53) {
    var_4 = getnumparts(var_3.model);

    for(var_5 = 0; var_5 < var_4; var_5++) {
      var_6 = getpartname(var_3.model, var_5);

      foreach(var_9, var_8 in level._id_3979[self.type]._id_7586) {
        if(issubstr(var_6, var_9)) {
          var_3 scripts\sp\utility::_id_75C4(var_8, var_6, randomfloatrange(var_0, var_1));
          break;
        }
      }
    }
  }
}

_id_3978(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0.05;
  }

  foreach(var_2 in self._id_CB53) {
    var_3 = getnumparts(var_2.model);

    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = getpartname(var_2.model, var_4);

      foreach(var_8, var_7 in level._id_3979[self.type]._id_7586) {
        if(issubstr(var_5, var_8)) {
          var_2 scripts\sp\utility::_id_75F8(var_7, var_5, randomfloatrange(0, var_0));
          break;
        }
      }
    }
  }
}

_id_39BE(var_0) {
  self notify("predeath");
  var_1 = 4;
  thread _id_3976(var_0, var_1);
  thread _id_397A(var_0, var_1);
  thread _id_3973(var_0, var_1);
  wait(var_1 + 0.3);
}

_id_7D02(var_0, var_1) {
  var_2 = distance(self.origin, var_0);
  var_3 = scripts\sp\math::_id_C097(200, 7000, var_2);
  var_4 = scripts\sp\math::_id_6A8E(0, var_1, var_3);
  var_4 = var_4 + randomfloatrange(-0.2, 0.2);

  if(var_4 < 0) {
    var_4 = 0;
  }

  return var_4;
}

_id_397A(var_0, var_1) {
  if(!isDefined(self) || !isDefined(self.turrets) || self.turrets.size == 0) {
    return;
  }
  foreach(var_3 in self.turrets) {
    foreach(var_5 in var_3) {
      if(!isDefined(var_5)) {
        continue;
      }
      var_6 = var_5 _id_7D02(var_0, var_1);
      var_5 thread _id_12A4F(var_6);
    }
  }
}

_id_3973(var_0, var_1) {
  if(!isDefined(self) || !isDefined(self._id_10381) || self._id_10381.size == 0) {
    return;
  }
  foreach(var_3 in self._id_10381) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = var_3 _id_7D02(var_0, var_1);
    var_3 thread _id_4DEA(var_4);
  }
}

_id_3976(var_0, var_1) {
  if(!isDefined(self._id_EF3C)) {
    return;
  }
  foreach(var_3 in self._id_EF3C) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = var_3 _id_7D02(var_0, var_1);
    var_3 thread _id_EF37(var_4);
  }
}

_id_4DEA(var_0) {
  self endon("death");
  wait(var_0);
  playFX(scripts\engine\utility::getfx("capital_dead_turret_ship_predeath"), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  playworldsound("capital_ship_turret_explode", self.origin);
}

_id_12A4F(var_0) {
  self endon("death");
  wait(var_0);
  _id_0BB6::_id_12A06();
  thread _id_0BB6::_id_129DF();
}

_id_EF37(var_0) {
  self endon("death");
  wait(var_0);
}

#using_animtree("vehicles");

_id_3977() {
  var_0 = level._id_3979[self._id_C721];
  var_1 = spawn("script_model", self.origin);
  var_1.angles = self.angles;
  var_1 setModel(var_0._id_E505);
  var_1 _meth_83D0(#animtree);
  var_1._id_CB53 = [];
  var_1.type = self._id_C721;

  if(isDefined(self._id_CB55)) {
    foreach(var_3 in self._id_CB55) {
      var_4 = var_3;

      if(issubstr(var_4, "_mat_rdc")) {
        var_5 = scripts\sp\utility::strip_suffix(var_4, "_mat_rdc");
        var_6 = "tag_" + var_5;
      } else
        var_6 = "tag_" + var_4;

      var_3 = spawn("script_model", self.origin);
      var_3 setModel(var_4);
      var_3 linkTo(var_1, var_6, (0, 0, 0), (0, 0, 0));
      var_1._id_CB53 = scripts\engine\utility::array_add(var_1._id_CB53, var_3);
    }
  } else {
    for(var_8 = 1; var_8 <= var_0._id_C1FB; var_8++) {
      if(var_8 < 10) {
        var_9 = "0";
      } else {
        var_9 = "";
      }

      var_4 = var_0._id_CB56 + var_9 + var_8;
      var_6 = "tag_" + var_4;
      var_3 = spawn("script_model", self.origin);
      var_3 setModel(var_4);
      var_3 linkTo(var_1, var_6, (0, 0, 0), (0, 0, 0));
      var_1._id_CB53 = scripts\engine\utility::array_add(var_1._id_CB53, var_3);
    }
  }

  return var_1;
}

_id_396F(var_0) {
  thread _id_B2E5();
  _id_3985(var_0);
}

_id_9799(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_0 = 1.0;
  }

  if(!isDefined(var_1)) {
    var_1 = 3.0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0.3;
  }

  if(!isDefined(var_3)) {
    var_3 = 0.75;
  }

  var_4 = spawnStruct();
  var_4._id_DCE5 = var_0;
  var_4._id_DCE3 = var_1;
  var_4._id_DCE4 = var_2;
  var_4._id_DCE2 = var_3;
  self._id_B797 = var_4;
}

_id_3985(var_0, var_1) {
  if(!isDefined(self._id_B797)) {
    _id_9799();
  }

  if(var_0) {
    thread _id_39BD();

    if(!isDefined(var_1) || !var_1) {
      if(isDefined(self._id_8B4F) && isDefined(self._id_8B4F["cap_hardpoint_missile_barrage"])) {
        thread _id_39B4();
      }

      thread _id_0BB6::_id_398A(0);
      thread _id_0BB6::_id_398A(1);
    }

    _id_0BB6::_id_39F1();
    thread _id_0BB6::_id_39F0();
  } else {
    self notify("disable_combat");
    thread _id_0BB6::_id_398A(0);
    thread _id_0BB6::_id_39F1();
  }
}

_id_B2E5() {
  if(scripts\engine\utility::flag_exist("flag_capitalship_targeting_init")) {
    return;
  }
  scripts\engine\utility::flag_init("flag_capitalship_targeting_init");

  while(!isDefined(level._id_D127)) {
    wait 0.05;
  }

  scripts\engine\utility::flag_init("flag_changing_capitalship_targets");
  var_0 = undefined;
  var_1 = 50000;
  var_2 = 10000;
  var_3 = 0.99;
  var_4 = 0.85;
  var_5 = 30000;
  var_6 = 25000;
  var_7 = 0.8;

  for(;;) {
    if(!scripts\sp\utility::_id_D123()) {
      wait 1;
      continue;
    }

    level._id_F02D = scripts\engine\utility::array_removeundefined(level._id_F02D);

    while(level._id_F02D.size == 0) {
      wait 0.05;
    }

    var_8 = anglesToForward(level._id_D127.angles);
    var_9 = undefined;

    foreach(var_11 in level._id_F02D) {
      var_12 = var_11.origin - level._id_D127.origin;
      var_11._id_56EA = length(var_12);
      var_13 = vectorNormalize(var_12);
      var_11._id_5ABB = vectordot(var_13, var_8);
      var_14 = 1 - scripts\sp\math::_id_C097(0, var_6, var_11._id_56EA);
      var_15 = scripts\sp\math::_id_C097(var_7, 1, var_11._id_5ABB);
      var_11._id_1153F = var_14 * var_15;

      if(var_11._id_1153F > 0) {
        if(isDefined(var_9)) {
          if(var_11._id_1153F > var_9._id_1153F) {
            var_9 = var_11;
          }
        } else
          var_9 = var_11;
      }

      var_16 = scripts\sp\math::_id_C097(var_2, var_1, var_11._id_56EA);
      var_17 = scripts\sp\math::_id_6A8E(var_4, var_3, var_16);

      if(var_11._id_5ABB > var_17 && var_11._id_56EA < var_1) {
        if(var_11._id_AEDF._id_3782 != "enemy_capitalship" && var_11._id_3775 == 0) {
          var_11._id_AEDF._id_3782 = "enemy_capitalship";
          var_11 _id_0B76::_id_F42B(var_11._id_AEDF._id_3782);
          var_11 thread _id_3968(1.5);
        }

        continue;
      }

      if(var_11._id_AEDF._id_3782 != "none" && var_11._id_3775 == 0) {
        var_11._id_AEDF._id_3782 = "none";
        var_11 _id_0B76::_id_F42B(var_11._id_AEDF._id_3782);
        var_11 thread _id_3968(1.5);
      }
    }

    if(!scripts\engine\utility::flag("flag_changing_capitalship_targets")) {
      if(isDefined(var_0)) {
        if(isDefined(var_9)) {
          if(var_9 != var_0 && var_9._id_1153F > var_0._id_1153F) {
            var_9 thread _id_11308(var_0);
            var_0 = var_9;
          }
        }

        if(var_0._id_56EA > var_5) {
          var_0 thread _id_DFD2();
          var_0 = undefined;
        }
      } else if(isDefined(var_9)) {
        var_9 thread _id_F2F7();
        var_0 = var_9;
      }
    }

    wait 0.05;
  }
}

_id_11308(var_0) {
  scripts\engine\utility::flag_set("flag_changing_capitalship_targets");
  var_0 _id_0BB6::_id_39C0();
  var_0 waittill("turrets_not_targetable");
  var_0._id_12A8B = 0;
  var_0._id_D436 = 0;

  if(isDefined(self) && isalive(self)) {
    _id_F2F7();
  }
}

_id_F2F7() {
  if(!scripts\engine\utility::flag("flag_changing_capitalship_targets")) {
    scripts\engine\utility::flag_set("flag_changing_capitalship_targets");
  }

  self._id_D436 = 1;

  if(isDefined(self._id_C825)) {
    var_0 = self._id_C825;
  } else {
    var_0 = "turret_ja";
  }

  _id_0BB6::_id_39CA(0, 1, var_0);
  wait 1;
  scripts\engine\utility::flag_clear("flag_changing_capitalship_targets");
}

_id_DFD2() {
  self._id_D436 = 0;
  _id_0BB6::_id_39C0();
}

_id_3968(var_0) {
  self endon("death");
  self notify("new_callout_timer");
  self endon("new_callout_timer");

  for(self._id_3775 = var_0; self._id_3775 > 0; self._id_3775 = self._id_3775 - 0.05) {
    wait 0.05;
  }

  self._id_3775 = 0;
}

_id_52FD() {
  self._id_B89E = 15000;
  self._id_B89F = 5000;
  self._id_B89B = 25000;
  self._id_B89C = 0.9;
  self._id_B89D = 1.0;
  self._id_B8A3 = 30000;
  self._id_B8A0 = 18000;
  self._id_B8A1 = 0.8;
  self._id_B8A2 = 3.0;
  self._id_B89A = 1;
  self._id_B899 = 1;
}

_id_B862() {
  self._id_B89E = 15000;
  self._id_B89F = 5000;
  self._id_B89B = 25000;
  self._id_B89C = 0.9;
  self._id_B89D = 1.0;
  self._id_B8A3 = 30000;
  self._id_B8A0 = 18000;
  self._id_B8A1 = 0.8;
  self._id_B8A2 = 3.0;
  self._id_B89A = 1;
  self._id_B899 = 1;
}

_id_F2F5(var_0) {
  self._id_38B5 = var_0;
}

_id_39B4() {
  self notify("miniflak_and_missiles_think");
  self endon("miniflak_and_missiles_think");
  self endon("death");
  self endon("disable_combat");

  for(;;) {
    wait 0.2;

    if(!scripts\sp\utility::_id_D123()) {
      wait 1;
      continue;
    }

    var_0 = undefined;

    if(_id_9C74() && _id_396B()) {
      var_0 = level._id_D127;
    }

    if(isDefined(var_0)) {
      if(_id_396A(var_0, self._id_9278)) {
        _id_3987(var_0);
        continue;
      }

      if(_id_3969(var_0) && var_0 == level._id_D127) {
        var_1 = distance(self.origin, level._id_D127.origin);
        var_2 = anglestoright(self.angles);
        var_3 = anglestoup(self.angles);
        var_4 = vectorNormalize(level._id_D127.origin - self.origin);
        var_5 = vectordot(var_2, var_4);
        var_6 = vectordot(var_3, var_4);
        _id_0BB6::_id_399F(var_1, var_5, var_6);
      }
    }
  }
}

_id_3987(var_0) {
  self endon("death");
  self endon("predeath");
  var_1 = anglestoright(self.angles);
  var_2 = anglestoup(self.angles);
  var_3 = vectorNormalize(var_0.origin - self.origin);
  var_4 = vectordot(var_1, var_3);
  var_5 = vectordot(var_2, var_3);
  self._id_8B50["cap_hardpoint_missile_barrage"] = ::scripts\engine\utility::array_removeundefined(self._id_8B50["cap_hardpoint_missile_barrage"]);
  self._id_8B51["cap_hardpoint_missile_barrage"] = ::scripts\engine\utility::array_removeundefined(self._id_8B51["cap_hardpoint_missile_barrage"]);

  if(var_4 < 0) {
    var_6 = self._id_8B50["cap_hardpoint_missile_barrage"];
  } else {
    var_6 = self._id_8B51["cap_hardpoint_missile_barrage"];
  }

  if(!isDefined(var_6)) {
    return;
  }
  if(var_6.size == 0) {
    if(var_4 < 0) {
      var_6 = self._id_8B51["cap_hardpoint_missile_barrage"];
    } else {
      var_6 = self._id_8B50["cap_hardpoint_missile_barrage"];
    }

    if(var_6.size == 0) {
      return;
    }
  }

  thread _id_0BB6::_id_39A0(var_0, var_6, 5);
  self._id_A8EA = gettime();

  if(isDefined(self._id_B89A) && isDefined(self._id_B899)) {
    if(self._id_B89A == self._id_B899) {
      var_7 = self._id_B89A * 1000;
    } else {
      var_7 = randomfloatrange(self._id_B89A, self._id_B899) * 1000;
    }

    self._id_B83F = var_7;
  }

  while(level._id_D127._id_93D2.size > 0) {
    wait 0.05;
  }
}

_id_396B() {
  if(!isDefined(level._id_D127)) {
    return 0;
  }

  if(level._id_D127._id_58B5) {
    return 0;
  }

  if(_id_0B76::_id_7B95() > 0) {
    return 0;
  }

  return 1;
}

_id_396A(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_2 = gettime() - self._id_A8EA;

  if(var_2 < self._id_B83F) {
    return 0;
  }

  if(isDefined(self._id_38B5) && ![[self._id_38B5]]()) {
    return 0;
  }

  if(isDefined(level._id_D127) && var_0 == level._id_D127) {
    if(level._id_A056._id_68B3.running) {
      return 0;
    }

    if(!isDefined(var_1) || !var_1) {
      if(!level.player scripts\sp\utility::_id_65DB("jackal_enemy_homing_missile_allowed")) {
        return 0;
      }
    } else if(!level.player scripts\sp\utility::_id_65DB("jackal_enemy_homing_missile_allowed_hyperaggressive"))
      return 0;
  }

  return 1;
}

_id_3969(var_0) {
  if(isDefined(level._id_D127) && isDefined(var_0) && var_0 == level._id_D127 && _id_0B76::_id_7B95() > 0) {
    return 0;
  }

  return 1;
}

_id_9C74() {
  if(!scripts\sp\utility::_id_65DF("player_is_near")) {
    return 0;
  }

  return scripts\sp\utility::_id_65DB("player_is_near");
}

_id_39BD() {
  self notify("player_jackal_near_think");
  self endon("player_jackal_near_think");
  self endon("death");
  self endon("disable_combat");

  if(!scripts\sp\utility::_id_65DF("player_is_near")) {
    scripts\sp\utility::_id_65E0("missiles_player_close_force");
    scripts\sp\utility::_id_65E0("missiles_player_far_force");
    scripts\sp\utility::_id_65E0("missiles_player_looking");
    scripts\sp\utility::_id_65E0("missiles_player_close");
    scripts\sp\utility::_id_65E0("player_is_near");
  }

  scripts\sp\utility::_id_65DD("player_is_near");

  for(;;) {
    if(!scripts\sp\utility::_id_D123()) {
      wait 1;
      continue;
    }

    _id_B8AA();
    scripts\sp\utility::_id_65E1("player_is_near");
    thread _id_12A1E();
    _id_B8AB();
    scripts\sp\utility::_id_65DD("player_is_near");
    self notify("player_not_near");
  }
}

_id_B8AA() {
  self endon("should_fire_missiles");
  self endon("death");
  childthread _id_FF48();
  childthread _id_FF47();
  wait 0.1;

  for(;;) {
    if(scripts\sp\utility::_id_65DB("missiles_player_looking") && scripts\sp\utility::_id_65DB("missiles_player_close")) {
      break;
    } else if(scripts\sp\utility::_id_65DB("missiles_player_close_force")) {
      break;
    }

    wait 0.05;
  }
}

_id_FF48() {
  var_0 = undefined;

  for(;;) {
    if(self._id_5ABB >= self._id_B89C) {
      if(isDefined(var_0)) {
        if(gettime() - self._id_B89D * 1000 >= var_0) {
          scripts\sp\utility::_id_65E1("missiles_player_looking");
        }
      } else
        var_0 = gettime();
    } else {
      scripts\sp\utility::_id_65DD("missiles_player_looking");
      var_0 = undefined;
    }

    wait 0.05;
  }
}

_id_FF47() {
  for(;;) {
    if(!isDefined(level._id_D127)) {
      scripts\sp\utility::_id_65DD("missiles_player_close_force");
      scripts\sp\utility::_id_65DD("missiles_player_close");
      wait 0.05;
      continue;
    }

    var_0 = abs(self.origin[2] - level._id_D127.origin[2]);

    if(self._id_56EA <= self._id_B89E && var_0 <= self._id_B89F) {
      scripts\sp\utility::_id_65E1("missiles_player_close_force");
    } else {
      scripts\sp\utility::_id_65DD("missiles_player_close_force");
    }

    if(self._id_56EA <= self._id_B89B) {
      scripts\sp\utility::_id_65E1("missiles_player_close");
    } else {
      scripts\sp\utility::_id_65DD("missiles_player_close");
    }

    wait 0.05;
  }
}

_id_B8AB() {
  childthread _id_FF6E();
  childthread _id_FF6D();
  wait 0.1;

  for(;;) {
    wait 0.05;

    if(scripts\sp\utility::_id_65DB("missiles_player_far_force")) {
      break;
    }

    if(!scripts\sp\utility::_id_65DB("missiles_player_looking") && !scripts\sp\utility::_id_65DB("missiles_player_close")) {
      break;
    }
  }

  self notify("should_not_fire_missiles");
}

_id_FF6E() {
  self endon("should_not_fire_missiles");
  self endon("death");
  var_0 = undefined;

  for(;;) {
    if(self._id_5ABB < self._id_B8A1) {
      if(isDefined(var_0)) {
        if(gettime() - self._id_B8A2 * 1000 >= var_0) {
          scripts\sp\utility::_id_65DD("missiles_player_looking");
        }
      } else
        var_0 = gettime();
    } else {
      scripts\sp\utility::_id_65E1("missiles_player_looking");
      var_0 = undefined;
    }

    wait 0.05;
  }
}

_id_FF6D() {
  self endon("should_not_fire_missiles");
  self endon("death");

  for(;;) {
    if(self._id_56EA >= self._id_B8A3) {
      scripts\sp\utility::_id_65E1("missiles_player_far_force");
    } else {
      scripts\sp\utility::_id_65DD("missiles_player_far_force");
    }

    if(self._id_56EA >= self._id_B8A0) {
      scripts\sp\utility::_id_65DD("missiles_player_close");
    } else {
      scripts\sp\utility::_id_65E1("missiles_player_close");
    }

    wait 0.05;
  }
}

_id_12A1E() {
  self endon("disable_combat");
  self endon("death");
  self endon("player_not_near");

  for(;;) {
    var_0 = 0;

    if(!scripts\sp\utility::_id_D123()) {
      wait 1;
      continue;
    }

    var_1 = distance(level._id_D127.origin, self.origin);

    if(var_1 < 18000 && randomint(100) < 90) {
      var_0 = 1;
    }

    if(var_1 <= 8000) {
      var_0 = 1;
    }

    if(scripts\sp\utility::_id_7B9D() <= 0.1) {
      var_0 = 0;
    } else if(scripts\sp\utility::_id_7B9D() >= 0.6) {
      var_0 = 1;
    }

    self._id_1D62 = var_0;
    self._id_11578 = var_0;
    wait 3;
  }
}

_id_39D6(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(level._id_A056)) {
    self[[level._id_A056._id_A16E]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, 0);
  }
}

_id_EA01() {
  if(isDefined(self)) {
    self delete();
  }
}

_id_EA02(var_0) {
  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      var_2 _id_EA01();
    }
  }
}

_id_DFE9(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3) || !isstruct(var_3) && !isalive(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}