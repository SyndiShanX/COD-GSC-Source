/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 4268.gsc
**************************************/

_id_107D9(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3)) {
    var_3 = "spawner_mech_weld";
  }

  if(isDefined(var_4) && var_4 == "female") {
    var_5 = _id_0EF8::_id_FDFD(var_3, var_0, "cheap");
  } else {
    var_5 = _id_0EF8::_id_FE01(var_3, var_0, "cheap");
  }

  var_5 thread _id_E82C(var_2);
  var_5 scripts\engine\utility::delaycall(0.05, ::_meth_82B0, level._id_EC85["generic"][var_1][0], randomfloatrange(0, 0.9));
  var_5 thread scripts\sp\anim::_id_1ECC(var_5, var_1);
  return var_5;
}

_id_E82C(var_0) {
  var_1 = spawn("script_model", self.origin);
  var_1 setModel("equipment_welding_torch_01");
  var_1 linkTo(self, "TAG_ACCESSORY_RIGHT", (0, 0, 0), (0, 0, 0));
  var_2 = _id_7D79(var_0);
  thread _id_40DD(var_1, var_2);
  self endon("death");
  scripts\sp\anim::_id_17F6("generic", "flame_on", ::_id_6258);
  scripts\sp\anim::_id_17F6("generic", "flame_off", ::_id_55A7);

  while(isDefined(var_1)) {
    var_3 = scripts\engine\utility::waittill_any_return("flame_on", "flame_off", "death");

    switch (var_3) {
      case "flame_on":
        killfxontag(scripts\engine\utility::getfx(var_2), var_1, "tag_flame");
        scripts\engine\utility::waitframe();
        playFXOnTag(scripts\engine\utility::getfx(var_2), var_1, "tag_flame");
        thread scripts\sp\utility::play_sound_on_tag("scn_shipcrib_welder_start");
        scripts\engine\utility::waitframe();
        thread scripts\sp\utility::play_loop_sound_on_tag("scn_shipcrib_welders_spark_lp");
        break;
      case "flame_off":
        stopFXOnTag(scripts\engine\utility::getfx(var_2), var_1, "tag_flame");
        thread scripts\sp\utility::play_sound_on_tag("scn_shipcrib_welder_stop");
        scripts\engine\utility::waitframe();
        self notify("stop soundscn_shipcrib_welders_spark_lp");
        break;
    }
  }
}

_id_40DD(var_0, var_1) {
  self waittill("death");
  killfxontag(scripts\engine\utility::getfx(var_1), var_0, "tag_flame");

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_7D79(var_0) {
  var_1 = "welding_sparks_small";

  if(!isDefined(var_0)) {
    return var_1;
  } else if(isDefined(scripts\engine\utility::getfx(var_0))) {
    return var_0;
  } else {
    return var_1;
  }
}

_id_6258(var_0) {
  var_0 notify("flame_on");
}

_id_55A7(var_0) {
  var_0 notify("flame_off");
}

_id_3DE0() {
  if(!scripts\engine\utility::flag_exist("welders_initialized")) {
    _id_97A5();
  }
}

_id_97A5() {
  scripts\engine\utility::flag_init("welders_initialized");
  _id_D80B();
  _id_AE12();
  _id_AE13();
}

_id_D80B() {
  precachemodel("equipment_welding_torch_01");
}

#using_animtree("generic_human");

_id_AE12() {
  level._id_EC85["generic"]["welding_low"][0] = % shipcrib_hangar_welding_low_idle;
  level._id_EC85["generic"]["welding_medium"][0] = % shipcrib_hangar_welding_medium_idle;
  level._id_EC85["generic"]["welding_high"][0] = % shipcrib_hangar_welding_high_idle;
}

_id_AE13() {
  level._effect["welding_sparks"] = loadfx("vfx/iw7/levels/ship_crib/titan/vfx_sct_welding_child_a.vfx");
  level._effect["welding_sparks_small"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sct_welding_small_child_a.vfx");
  level._effect["welding_sparks_small_heavy"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sct_welding_small_child_a_heavy.vfx");
  level._effect["welding_sparks_hangar"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_welding_hangar_child_a.vfx");
  level._effect["welding_sparks_hangar_small"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_welding_hangar_child_sml.vfx");
}

_id_ADAE(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_0, "targetname");
  var_4 = [];

  foreach(var_6 in var_3) {
    var_7 = _id_107D9(var_6, var_6.script_noteworthy, var_1, var_2);
    var_4 = scripts\engine\utility::array_add(var_4, var_7);
  }

  return var_4;
}

_id_13CED() {
  self endon("death");

  if(!isDefined(self._id_13CEC)) {
    return;
  }
  switch (self._id_13CEC) {
    case "welding_low":
      self _meth_82B0(scripts\sp\utility::_id_7DC1(self._id_13CEC)[0], 0.646);
      break;
    case "welding_medium":
      self _meth_82B0(scripts\sp\utility::_id_7DC1(self._id_13CEC)[0], 0.505);
      break;
    case "welding_high":
      self _meth_82B0(scripts\sp\utility::_id_7DC1(self._id_13CEC)[0], 0.452);
      break;
  }
}