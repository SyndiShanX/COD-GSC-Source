/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2979.gsc
**************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  scripts\sp\vehicle_build::_id_31C5("apc", var_0, var_1, var_2);
  scripts\sp\vehicle_build::_id_31A6(::init_location);

  if(var_0 == "veh_mil_lnd_un_apc_drive")
    scripts\sp\vehicle_build::_id_3186(var_0, "veh_mil_lnd_un_apc_dmg");
  else if(var_0 == "veh_mil_lnd_un_apc_earth")
    scripts\sp\vehicle_build::_id_3186(var_0, "veh_mil_lnd_un_apc_earth_dmg");
  else
    scripts\sp\vehicle_build::_id_3186("veh_mil_lnd_un_apc", "veh_mil_lnd_un_apc");

  scripts\sp\vehicle_build::_id_3184("vfx/core/expl/large_vehicle_explosion.vfx", undefined, "explo_metal_rand");
  scripts\sp\vehicle_build::_id_318B(%vh_apc_driving_idle_forward, %vh_apc_driving_idle_backward, 10);

  if(var_2 == "script_vehicle_apc_turret")
    scripts\sp\vehicle_build::_id_31C8("apc_turret", "tag_turret", "veh_mil_lnd_un_apc_turret", undefined, "auto_nonai", undefined, 0);

  scripts\sp\vehicle_build::_id_31B3((0, 0, 53), 512, 300, 20, 0);
  scripts\sp\vehicle_build::_id_31C6(var_2, "default", "vfx/iw7/core/tread/vfx_tread_apc_asphalt.vfx");
  scripts\sp\vehicle_build::_id_31C6(var_2, "mud", "vfx/iw7/levels/titan/tread/vfx_tread_water_apc_titan.vfx");
  scripts\sp\vehicle_build::_id_31C6(var_2, "water", "vfx/iw7/levels/titan/tread/vfx_tread_water_apc_titan.vfx");
  scripts\sp\vehicle_build::_id_31C6(var_2, "concrete_wet", "vfx/iw7/levels/titan/tread/vfx_tread_water_apc_titan.vfx");
  scripts\sp\vehicle_build::_id_31C6(var_2, "asphalt_wet", "vfx/iw7/levels/titan/tread/vfx_tread_water_apc_titan.vfx");
  scripts\sp\vehicle_build::_id_31C6(var_2, "asphalt", "vfx/iw7/core/tread/vfx_tread_apc_asphalt.vfx");
  scripts\sp\vehicle_build::_id_31C6(var_2, "asphalt_dry", "vfx/iw7/core/tread/vfx_tread_apc_asphalt.vfx");
  scripts\sp\vehicle_build::_id_31C6(var_2, "metal_thick", "vfx/iw7/core/tread/vfx_tread_apc_metal.vfx");
  scripts\sp\vehicle_build::_id_31A3(999, 500, 1500);

  if(var_2 == "script_vehicle_apc_turret")
    scripts\sp\vehicle_build::_id_31C4("axis");
  else
    scripts\sp\vehicle_build::_id_31C4("allies");

  scripts\sp\vehicle_build::_id_31CC(::_id_12BBD);
  scripts\sp\vehicle_build::build_ace(::_id_F643, ::_id_F5FA);
  scripts\sp\vehicle_build::_id_3196(0.33);
  scripts\sp\vehicle_build::build_bulletshield(1);
  scripts\sp\vehicle_build::_id_3198(1);

  if(!isDefined(level.plant_anims)) {
    return;
  }
  switch (level.plant_anims) {
    case "titan":
      level.plant_anims = "titan";
      scripts\sp\vehicle_build::_id_31C6(var_2, "default", "vfx/iw7/levels/titan/tread/vfx_tread_dust_apc_titan.vfx");
      scripts\sp\vehicle_build::_id_31C6(var_2, "mud", "vfx/iw7/levels/titan/tread/vfx_tread_water_apc_titan.vfx");
      scripts\sp\vehicle_build::_id_31C6(var_2, "water", "vfx/iw7/levels/titan/tread/vfx_tread_water_apc_titan.vfx");
      scripts\sp\vehicle_build::_id_31C6(var_2, "concrete_wet", "vfx/iw7/levels/titan/tread/vfx_tread_water_apc_titan.vfx");
      scripts\sp\vehicle_build::_id_31C6(var_2, "asphalt_wet", "vfx/iw7/levels/titan/tread/vfx_tread_water_apc_titan.vfx");
      scripts\sp\vehicle_build::_id_31C6(var_2, "concrete", "vfx/iw7/levels/titan/tread/vfx_tread_concrete_apc_titan.vfx");
      scripts\sp\vehicle_build::_id_31C6(var_2, "asphalt", "vfx/iw7/levels/titan/tread/vfx_tread_concrete_apc_titan.vfx");
      scripts\sp\vehicle_build::_id_31C6(var_2, "dirt", "vfx/iw7/levels/titan/tread/vfx_tread_water_apc_titan.vfx");
      scripts\sp\vehicle_build::_id_31C6(var_2, "rock", "vfx/iw7/levels/titan/tread/vfx_tread_water_apc_titan.vfx");
      scripts\sp\vehicle_build::_id_31C6(var_2, "sand", "vfx/iw7/levels/titan/tread/vfx_tread_water_apc_titan.vfx");
  }
}

init_location() {
  scripts\sp\utility::_id_65E0("no_riders_until_unload");
}

_id_035A() {
  var_0 = self.mgturret[0];
  var_0 shootturret();
  var_1 = anglesToForward(var_0 gettagangles("tag_flash"));
  var_2 = self.origin + var_1 * 10;
  self _meth_81CD(var_2 + (0, 0, 104), 0.3);
  wait 0.25;
}

#using_animtree("generic_human");

_id_F643() {
  var_0 = [];

  for(var_1 = 0; var_1 < 8; var_1++) {
    var_0[var_1] = spawnStruct();
    var_0[var_1]._id_10220 = "tag_detach";
  }

  var_0[0]._id_92CC = % vh_apc_org_idle_door_left_guy1;
  var_0[1]._id_92CC = % vh_apc_org_idle_door_left_guy2;
  var_0[2]._id_92CC = % vh_apc_org_idle_door_right_guy3;
  var_0[3]._id_92CC = % vh_apc_org_idle_door_right_guy4;
  var_0[4]._id_92CC = % vh_apc_org_idle_door_back_guy5;
  var_0[5]._id_92CC = % vh_apc_org_idle_door_back_guy6;
  var_0[6]._id_92CC = % vh_apc_org_idle_door_back_guy7;
  var_0[7]._id_92CC = % vh_apc_org_idle_door_back_guy8;
  var_0[0]._id_8028 = % vh_apc_org_unload_door_left_guy1;
  var_0[1]._id_8028 = % vh_apc_org_unload_door_left_guy2;
  var_0[2]._id_8028 = % vh_apc_org_unload_door_right_guy3;
  var_0[3]._id_8028 = % vh_apc_org_unload_door_right_guy4;
  var_0[4]._id_8028 = % vh_apc_org_unload_door_back_guy5;
  var_0[5]._id_8028 = % vh_apc_org_unload_door_back_guy6;
  var_0[6]._id_8028 = % vh_apc_org_unload_door_back_guy7;
  var_0[7]._id_8028 = % vh_apc_org_unload_door_back_guy8;
  return var_0;
}

#using_animtree("vehicles");

_id_F5FA(var_0) {
  var_0[0]._id_131E6 = % vh_apc_org_unload_door_l;
  var_0[0]._id_131E7 = 0;
  var_0[2]._id_131E6 = % vh_apc_org_unload_door_r;
  var_0[2]._id_131E7 = 0;
  var_0[4]._id_131E6 = % vh_apc_org_unload_door_back;
  var_0[4]._id_131E7 = 0;
  return var_0;
}

_id_12BBD() {
  var_0 = [];
  var_1 = "all";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 0;
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_0[var_1][var_0[var_1].size] = 4;
  var_0[var_1][var_0[var_1].size] = 5;
  var_0[var_1][var_0[var_1].size] = 6;
  var_0[var_1][var_0[var_1].size] = 7;
  var_1 = "left";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 0;
  var_0[var_1][var_0[var_1].size] = 1;
  var_1 = "right";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_1 = "back";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 4;
  var_0[var_1][var_0[var_1].size] = 5;
  var_0[var_1][var_0[var_1].size] = 6;
  var_0[var_1][var_0[var_1].size] = 7;
  var_0["default"] = var_0["all"];
  return var_0;
}

_id_205C() {
  self _meth_83E8();

  if(!isDefined(self._id_2096)) {
    self._id_2096 = spawn("script_origin", self.origin);
    self._id_2096 linkTo(self);
  }

  if(!isDefined(self._id_2073)) {
    self._id_2073 = spawn("script_origin", self.origin);
    self._id_2073 linkTo(self);
  }

  if(!isDefined(self._id_207C)) {
    self._id_207C = spawn("script_origin", self.origin);
    self._id_207C linkTo(self);
  }

  wait 0.05;
  thread _id_2063();
  thread _id_208F();
}

_id_2063() {
  self waittill("death");

  if(isDefined(self._id_207C))
    self._id_207C delete();

  if(isDefined(self._id_2073))
    self._id_2073 delete();

  if(isDefined(self._id_2096))
    self._id_2096 delete();
}

_id_208A() {
  self endon("death");
  self endon("stop_move_along_struct_path");
  self endon("apc_sfx_stop");
  self endon("apc_stopped");
  var_0 = "";
  var_1 = 0.2;
  var_2 = 0.2;
  self._id_2073 scripts\sp\utility::_id_10461("veh_apc_slow_lp", 0.5, 0.5, 1);
  self._id_2096 scripts\sp\utility::_id_10461("veh_apc_tires_lp", 0.5, 0.5, 1);
  self._id_207C _meth_8278(0, 3);

  for(;;) {
    var_3 = self vehicle_getspeed();
    var_4 = var_3 / 8;

    if(var_1 < var_4)
      var_2 = var_1 + (var_4 - var_1) / 30;

    if(var_1 > var_4)
      var_2 = var_1 - (var_1 - var_4) / 30;

    if(var_2 > 1)
      var_2 = 1;

    var_1 = var_2;
    self._id_2096 _meth_8278(var_1, 0.1);

    if(var_3 > 8) {
      if(var_0 == "med") {
        var_0 = "fast";
        self playSound("veh_apc_upshift_to_fast");
        self._id_2073 _meth_8278(0, 0.5);
        wait 0.5;
        self._id_2073 playLoopSound("veh_apc_fast_lp");
        self._id_207C stoploopsound();
        self._id_2073 _meth_8278(1, 1);
      }

      if(var_0 == "slow") {
        var_0 = "fast";
        self playSound("veh_apc_quick_accel_to_fast");
        self._id_2073 _meth_8278(0, 0.5);
        wait 0.5;
        self._id_2073 playLoopSound("veh_apc_fast_lp");
        self._id_207C stoploopsound();
        self._id_2073 _meth_8278(1, 1);
      }
    } else if(var_3 > 4) {
      if(var_0 == "fast") {
        var_0 = "med";
        self playSound("veh_apc_downshift_to_med");
        self._id_2073 _meth_8278(0, 0.5);
        wait 0.5;
        self._id_2073 playLoopSound("veh_apc_med_lp");
        self._id_207C stoploopsound();
        self._id_2073 _meth_8278(1, 1);
      }

      if(var_0 == "slow") {
        var_0 = "med";
        self playSound("veh_apc_upshift_to_med");
        self._id_2073 _meth_8278(0, 0.5);
        wait 0.5;
        self._id_2073 playLoopSound("veh_apc_med_lp");
        self._id_207C stoploopsound();
        self._id_2073 _meth_8278(1, 1);
      }
    } else if(var_3 > 0.4) {
      if(var_0 == "med") {
        var_0 = "slow";
        self playSound("veh_apc_downshift_to_slow");
        self._id_2073 _meth_8278(0, 0.5);
        wait 0.5;
        self._id_2073 playLoopSound("veh_apc_slow_lp");
        self._id_207C stoploopsound();
        self._id_2073 _meth_8278(1, 1);
      } else if(var_0 == "fast") {
        var_0 = "slow";
        self playSound("veh_apc_downshift_to_slow");
        self._id_2073 _meth_8278(0, 0.5);
        wait 0.5;
        self._id_2073 playLoopSound("veh_apc_slow_lp");
        self._id_207C stoploopsound();
        self._id_2073 _meth_8278(1, 1);
      } else if(var_0 != "slow") {
        var_0 = "slow";
        self playSound("veh_apc_upshift_to_slow");
        self._id_2073 playLoopSound("veh_apc_slow_lp");
        self._id_207C stoploopsound();
        self._id_2073 _meth_8278(1, 1);
        wait 0.1;
      }
    }

    wait 0.1;
  }
}

_id_2094() {
  self endon("death");
  self endon("stop_move_along_struct_path");
  var_0 = self vehicle_getspeed();

  if(var_0 < 4)
    self playSound("veh_apc_slow_stop_from_slow");
  else if(var_0 < 8)
    self playSound("veh_apc_slow_stop_from_med");
  else
    self playSound("veh_apc_slow_stop_from_fast");

  self._id_207C scripts\sp\utility::_id_10461("veh_apc_idle_lp", 1, 2, 1);
  self._id_2096 _meth_8278(0, 3);
  self._id_2073 _meth_8278(0, 2);
}

_id_2091() {
  self endon("death");
  self endon("stop_move_along_struct_path");
  self endon("apc_sfx_stop");
  self waittill("apc_sfx_slowing");
  var_0 = 1;
  var_1 = 1;

  for(;;) {
    if(self vehicle_getspeed() < 0.3) {
      var_2 = self vehicle_getspeed();
      var_3 = var_2 / 15;

      if(var_0 < var_3)
        var_1 = var_0 + (var_3 - var_0) / 30;

      if(var_0 > var_3)
        var_1 = var_0 - (var_0 - var_3) / 30;

      if(var_1 > 1)
        var_1 = 1;

      var_0 = var_1;
      self._id_2073 _meth_8278(var_0, 0.1);
      wait 0.1;
    }

    if(self vehicle_getspeed() < 0.1) {
      break;
    }
  }

  self notify("apc_sfx_stop");
}

_id_208F() {
  self endon("death");
  self endon("stop_move_along_struct_path");
  self playSound("veh_apc_ignition");
  self._id_207C scripts\sp\utility::_id_10461("veh_apc_idle_lp", 1, 2, 1);

  for(;;) {
    while(!self vehicle_getspeed() > 0)
      wait 0.1;

    thread _id_208A();
    thread _id_2091();

    while(self vehicle_getspeed() > 0.2)
      wait 0.1;

    self notify("apc_sfx_slowing");
    self waittill("apc_sfx_stop");
    thread _id_2094();

    while(self vehicle_getspeed() != 0)
      wait 0.1;

    self notify("apc_stopped");
    self._id_2073 stoploopsound();
    self._id_2096 stoploopsound();
  }
}