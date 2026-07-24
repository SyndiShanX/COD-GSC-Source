/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2996.gsc
**************************************/

main(var_0, var_1, var_2) {
  scripts\sp\vehicle_build::_id_31C5("capital_ship", var_0, var_1, var_2);
  scripts\sp\vehicle_build::_id_31A6(::init_location);
  _id_0BA9::_id_39B3(var_0, "ca", var_2);
  level._effect["mons_thrust_bottom_front_initiate"] = loadfx("vfx/iw7/core/vehicle/capship/ca/mons/vfx_capship_ca_thruster_down_array_front_initiate.vfx");
  level._effect["mons_thrust_bottom_front_idle"] = loadfx("vfx/iw7/core/vehicle/capship/ca/mons/vfx_capship_ca_thruster_down_array_front_idle.vfx");
  level._effect["mons_thrust_bottom_front_rampup"] = loadfx("vfx/iw7/core/vehicle/capship/ca/mons/vfx_capship_ca_thruster_down_array_front_idle_rampup.vfx");
  level._effect["mons_thrust_bottom_front_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/ca/mons/vfx_capship_ca_thruster_down_array_front.vfx");
  level._effect["mons_thrust_bottom_front_launch"] = loadfx("vfx/iw7/core/vehicle/capship/ca/mons/vfx_capship_ca_thruster_down_array_front.vfx");
  level._effect["mons_thrust_bottom_front_hburst"] = loadfx("vfx/iw7/core/vehicle/capship/ca/mons/vfx_capship_ca_thruster_down_array_front_hburst.vfx");
  level._effect["mons_thrust_bottom_middle_initiate"] = loadfx("vfx/iw7/core/vehicle/capship/ca/mons/vfx_capship_ca_thruster_down_array_mid_initiate.vfx");
  level._effect["mons_thrust_bottom_middle_idle"] = loadfx("vfx/iw7/core/vehicle/capship/ca/mons/vfx_capship_ca_thruster_down_array_mid_idle.vfx");
  level._effect["mons_thrust_bottom_middle_rampup"] = loadfx("vfx/iw7/core/vehicle/capship/ca/mons/vfx_capship_ca_thruster_down_array_mid_idle_rampup.vfx");
  level._effect["mons_thrust_bottom_middle_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/ca/mons/vfx_capship_ca_thruster_down_array_mid.vfx");
  level._effect["mons_thrust_bottom_middle_launch"] = loadfx("vfx/iw7/core/vehicle/capship/ca/mons/vfx_capship_ca_thruster_down_array_mid.vfx");
  level._effect["mons_thrust_bottom_middle_hburst"] = loadfx("vfx/iw7/core/vehicle/capship/ca/mons/vfx_capship_ca_thruster_down_array_mid_hburst.vfx");
  level._effect["mons_thrust_bottom_rear_initiate"] = loadfx("vfx/iw7/core/vehicle/capship/ca/mons/vfx_capship_ca_thruster_down_array_back_initiate.vfx");
  level._effect["mons_thrust_bottom_rear_idle"] = loadfx("vfx/iw7/core/vehicle/capship/ca/mons/vfx_capship_ca_thruster_down_array_back_idle.vfx");
  level._effect["mons_thrust_bottom_rear_rampup"] = loadfx("vfx/iw7/core/vehicle/capship/ca/mons/vfx_capship_ca_thruster_down_array_back_idle_rampup.vfx");
  level._effect["mons_thrust_bottom_rear_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/ca/mons/vfx_capship_ca_thruster_down_array_back.vfx");
  level._effect["mons_thrust_bottom_rear_launch"] = loadfx("vfx/iw7/core/vehicle/capship/ca/mons/vfx_capship_ca_thruster_down_array_back.vfx");
  level._effect["mons_thrust_bottom_rear_hburst"] = loadfx("vfx/iw7/core/vehicle/capship/ca/mons/vfx_capship_ca_thruster_down_array_back_hburst.vfx");
  level._effect["mons_thrust_rear_initiate"] = loadfx("vfx/iw7/core/vehicle/capship/ca/mons/vfx_capship_ca_thruster_rear_array_initiate.vfx");
  level._effect["mons_thrust_rear_idle"] = loadfx("vfx/iw7/core/vehicle/capship/ca/mons/vfx_capship_ca_thruster_rear_array_idle.vfx");
  level._effect["mons_thrust_rear_rampup"] = loadfx("vfx/iw7/core/vehicle/capship/ca/mons/vfx_capship_ca_thruster_rear_array_idle_rampup.vfx");
  level._effect["mons_thrust_rear_heavy"] = loadfx("vfx/iw7/core/vehicle/capship/ca/mons/vfx_capship_ca_thruster_rear_array.vfx");
  level._effect["mons_thrust_rear_launch"] = loadfx("vfx/iw7/core/vehicle/capship/ca/mons/vfx_capship_ca_thruster_rear_array.vfx");
  level._effect["vfx_vehicle_mons_warp_out_ftldrive_core"] = loadfx("vfx/iw7/core/vehicle/mons/vfx_vehicle_mons_warp_out_ftldrive_core.vfx");
  precachemodel("veh_mil_air_ca_olympus_mons");
  precachemodel("veh_mil_air_ca_olympus_mons_engines");
  precachemodel("vfx_ftl_mons");

  if(issubstr(var_2, "periph")) {
    precacheitem("cap_turret_proj_small_constant");
    precacheturret("cap_turret_cannon_large_ca");
    precacheturret("cap_turret_cannon_large_ca_zerog");
    return;
  }

  precachemodel("veh_mil_air_ca_olympus_mons_gun_rig");
  precachemodel("veh_mil_air_ca_olympus_mons_bridge");
  precachemodel("veh_mil_air_ca_olympus_mons_bridge_dmg");
  precachemodel("veh_mil_air_ca_olympus_mons_details");
  precachemodel("veh_mil_air_ca_olympus_mons_details_scr");
  precachemodel("veh_mil_air_ca_olympus_mons_interior_01");
  precachemodel("veh_mil_air_ca_olympus_mons_gun_rig");
  precacheturret("cap_turret_cannon_large_ca");
  precacheturret("cap_turret_cannon_large_ca_zerog");
  precachemodel("veh_mil_air_ca_olympus_mons_gun_rig");

  if(issubstr(var_2, "_damaged"))
    precachemodel("veh_mil_air_ca_olympus_mons_dmg");

  if(issubstr(var_2, "_heistspace_end"))
    precachemodel("veh_mil_air_ca_olympus_mons_heist_space");

  _id_0BB6::_id_12A89();
  scripts\sp\vehicle_build::_id_31C6(var_2, "default", "vfx/iw7/core/tread/tread_airship_mons_titan.vfx", 0);
  level._effect["mons_ca_warp_pre"] = loadfx("vfx/iw7/core/vehicle/mons/vfx_vehicle_mons_warp_in_anticipation.vfx");
  level._effect["mons_ca_warp_in"] = loadfx("vfx/iw7/core/vehicle/mons/vfx_vehicle_mons_warp_in.vfx");
  level._effect["mons_ca_warp_in_post"] = loadfx("vfx/iw7/core/vehicle/mons/vfx_vehicle_mons_warp_in.vfx");
  level._effect["mons_ca_warp_out"] = loadfx("vfx/iw7/core/vehicle/mons/vfx_vehicle_mons_warp_out.vfx");
  level._effect["capital_turret_sml_mons_cheap"] = loadfx("vfx/iw7/core/muzflash/cannon/vfx_mons_turret.vfx");
  level._effect["vfx_heist_mons_steeldragon_beam"] = loadfx("vfx/iw7/levels/heist/vfx_heist_mons_steeldragon_beam.vfx");
  level._effect["vfx_heist_mons_steeldragon_loop"] = loadfx("vfx/iw7/levels/heist/vfx_heist_mons_steeldragon_loop.vfx");
  level._effect["vfx_heist_mons_steeldragon_chargeup"] = loadfx("vfx/iw7/levels/heist/vfx_heist_mons_steeldragon_chargeup.vfx");
  level._effect["vfx_heist_mons_steeldragon_winddown"] = loadfx("vfx/iw7/levels/heist/vfx_heist_mons_steeldragon_winddown.vfx");
}

init_location() {
  if(issubstr(self.classname, "_damaged"))
    self._id_B210 = "veh_mil_air_ca_olympus_mons_dmg";

  if(issubstr(self.classname, "_heistspace_end"))
    self._id_B210 = "veh_mil_air_ca_olympus_mons_heist_space";

  self._id_24C4 = ["tag_origin", "amb_turret_r_6", "amb_turret_sml_r_1", "amb_turret_l_5", "amb_turret_sml_r_6", "amb_turret_l_1", "amb_turret_sml_r_16", "amb_turret_sml_l_14", "fx_light_main_a_1", "fx_light_running_lrg_b3_4", "fx_light_running_lrg_b3_2", "amb_missile_l_4", "amb_missile_r_16", "amb_missile_r_25", "fx_entryburn_1"];
  thread _id_0BA9::_id_396E("ca");
  thread _id_1EDC();
  scripts\sp\vehicle::_id_8441();
  self._id_129F5 = [];
  self._id_129F5["front_left"] = ["amb_turret_sml_l_11", "amb_turret_sml_l_12", "amb_turret_sml_l_13", "amb_turret_sml_l_14", "amb_turret_sml_l_15", "amb_turret_sml_l_16", "amb_turret_sml_l_17", "amb_turret_sml_l_18", "amb_turret_l_1", "amb_turret_l_2"];
  self._id_129F5["front_right"] = ["amb_turret_sml_r_11", "amb_turret_sml_r_12", "amb_turret_sml_r_13", "amb_turret_sml_r_14", "amb_turret_sml_r_15", "amb_turret_sml_r_16", "amb_turret_sml_r_17", "amb_turret_sml_r_18", "amb_turret_r_1", "amb_turret_r_2"];
  self._id_129F5["back_left"] = ["amb_turret_sml_l_1", "amb_turret_sml_l_2", "amb_turret_sml_l_3", "amb_turret_sml_l_4", "amb_turret_sml_l_5", "amb_turret_sml_l_6", "amb_turret_sml_l_7", "amb_turret_sml_l_8", "amb_turret_sml_l_9", "amb_turret_sml_l_10", "amb_turret_l_3", "amb_turret_l_4", "amb_turret_l_5", "amb_turret_l_6"];
  self._id_129F5["back_right"] = ["amb_turret_sml_r_1", "amb_turret_sml_r_2", "amb_turret_sml_r_3", "amb_turret_sml_r_4", "amb_turret_sml_r_5", "amb_turret_sml_r_6", "amb_turret_sml_r_7", "amb_turret_sml_r_8", "amb_turret_sml_r_9", "amb_turret_sml_r_10", "amb_turret_r_3", "amb_turret_r_4", "amb_turret_r_5", "amb_turret_r_6"];
  self._id_129F5["new"] = ["amb_turret_l_7", "amb_turret_l_8", "amb_turret_l_9", "amb_turret_l_10", "amb_turret_l_11", "amb_turret_l_12", "amb_turret_l_13", "amb_turret_r_7", "amb_turret_r_8", "amb_turret_r_9", "amb_turret_r_10", "amb_turret_r_11", "amb_turret_r_12", "amb_turret_r_13", "amb_turret_r_14", "amb_turret_r_15"];
  self._id_8B46 = [];
  self._id_8B46["left_1"] = ["amb_missile_l_18", "amb_missile_l_19", "amb_missile_l_20", "amb_missile_l_21", "amb_missile_l_22", "amb_missile_l_23"];
  self._id_8B46["right_1"] = ["amb_missile_r_18", "amb_missile_r_19", "amb_missile_r_20", "amb_missile_r_21", "amb_missile_r_22", "amb_missile_r_23"];
  self._id_8B46["left_2"] = ["amb_missile_l_1", "amb_missile_l_2", "amb_missile_l_3", "amb_missile_l_4", "amb_missile_l_5", "amb_missile_l_6", "amb_missile_l_7", "amb_missile_l_8", "amb_missile_l_9", "amb_missile_l_10"];
  self._id_8B46["right_2"] = ["amb_missile_r_1", "amb_missile_r_2", "amb_missile_r_3", "amb_missile_r_4", "amb_missile_r_5", "amb_missile_r_6", "amb_missile_r_7", "amb_missile_r_8", "amb_missile_r_9", "amb_missile_r_10"];
  self._id_8B46["left_3"] = ["amb_missile_l_11", "amb_missile_l_12", "amb_missile_l_13", "amb_missile_l_14", "amb_missile_l_15", "amb_missile_l_16", "amb_missile_l_17"];
  self._id_8B46["right_3"] = ["amb_missile_r_11", "amb_missile_r_12", "amb_missile_r_13", "amb_missile_r_14", "amb_missile_r_15", "amb_missile_r_16", "amb_missile_r_17"];
  self._id_8B46["left_4"] = ["amb_missile_l_26", "amb_missile_l_27", "amb_missile_l_28", "amb_missile_l_29", "amb_missile_l_30", "amb_missile_l_31", "amb_missile_l_32"];
  self._id_8B46["right_4"] = ["amb_missile_r_26", "amb_missile_r_27", "amb_missile_r_28", "amb_missile_r_29", "amb_missile_r_30", "amb_missile_r_31", "amb_missile_r_32"];
  self._id_8B46["center"] = ["amb_missile_l_24", "amb_missile_l_25", "amb_missile_r_24", "amb_missile_r_25"];
  _id_0BB8::_id_7561("thrust_vert", "tag_engine_bottom_front", "mons_thrust_bottom_front", self._id_5020);
  _id_0BB8::_id_7561("thrust_vert", "tag_engine_bottom_middle", "mons_thrust_bottom_middle", self._id_5020);
  _id_0BB8::_id_7561("thrust_vert", "tag_engine_bottom_rear", "mons_thrust_bottom_rear", self._id_5020);
  _id_0BB8::_id_7561("thrust_rear", "tag_engine_rear", "mons_thrust_rear", self._id_501F);

  if(self.classname != "script_vehicle_capitalship_mons_heistspace") {
    self._id_539B = ["veh_mil_air_ca_olympus_mons_engines", "veh_mil_air_ca_olympus_mons_details", "veh_mil_air_ca_olympus_mons_details_scr"];
    self._id_539A = "veh_mil_air_ca_olympus_mons_interior_01";
  }

  thread _id_7479();

  if(issubstr(self.classname, "periph")) {
    return;
  }
  self._id_129C4 = _id_129C4();
  self._id_12A08 = _id_12A08();
  self._id_7482 = "mons_ca_warp";
  self._id_748F = "vfx_ftl_mons";
  self._id_7475 = 0.35;
  self._id_7499 = "mons_ca_warp_in";
  self._id_749A = 0.195;

  if(self.classname != "script_vehicle_capitalship_mons_heistspace" && self.classname != "script_vehicle_capitalship_mons_damaged")
    thread _id_245B();
}

_id_7479() {
  wait 0.5;

  if(isDefined(self.delay_warp_core))
    self waittill(self.delay_warp_core);

  self._id_7479 = 1;
  playFXOnTag(level._effect["vfx_vehicle_mons_warp_out_ftldrive_core"], self, "TAG_ORIGIN");
}

_id_129C4() {
  var_0 = [];
  var_0["amb_turret_r_1"] = [180, 180, 88, 10];
  var_0["amb_turret_l_1"] = [180, 180, 88, 10];
  var_0["amb_turret_r_2"] = [180, 180, 88, 10];
  var_0["amb_turret_l_2"] = [180, 180, 88, 10];
  var_0["amb_turret_r_3"] = [180, 180, 88, 10];
  var_0["amb_turret_l_3"] = [180, 180, 88, 10];
  var_0["amb_turret_r_4"] = [180, 180, 88, 10];
  var_0["amb_turret_l_4"] = [180, 180, 88, 10];
  var_0["amb_turret_r_5"] = [180, 180, 88, 10];
  var_0["amb_turret_l_5"] = [180, 180, 88, 10];
  var_0["amb_turret_r_6"] = [180, 180, 88, 10];
  var_0["amb_turret_l_6"] = [180, 180, 88, 10];
  return var_0;
}

_id_12A08() {
  var_0 = undefined;
  return var_0;
}

_id_245B() {
  wait 0.1;
  var_0 = "veh_mil_air_ca_olympus_mons_bridge";

  if(isDefined(self.script_label) && self.script_label == "damaged") {
    self._id_2FEC = 1;
    var_0 = "veh_mil_air_ca_olympus_mons_bridge_dmg";
    stopFXOnTag(level._effect["light_red_small"], self, "fx_light_running_lrg_b3_1");
  }

  self attach(var_0, "TAG_ORIGIN");
}

#using_animtree("vehicles");

_id_1EDC() {
  level._id_EC87["ftl_model"] = #animtree;
  level._id_EC8C["ftl_model"] = "vfx_ftl_mons";
  level._id_EC85["ftl_model"]["ftl_in"] = % vfx_ftl_mons_in;
  level._id_EC85["ftl_model"]["ftl_out"] = % vfx_ftl_mons_out;
}

_id_10770() {
  self endon("death");

  if(isDefined(self.cannon)) {
    return;
  }
  var_0 = 0.5;
  self hidepart("tag_main_cannon_hood");
  self.cannon = spawnturret("misc_turret", self gettagorigin("tag_main_cannon"), "cap_turret_cannon_large_ca");
  self.cannon.angles = self gettagangles("tag_main_cannon");
  self.cannon linkTo(self, "tag_main_cannon");
  self.cannon setdefaultdroppitch(0);
  self.cannon setModel("veh_mil_air_ca_olympus_mons_gun_rig");
  self.cannon setmode("manual");
  self.cannon makeunusable();
  self.cannon notsolid();
  self.cannon setCanDamage(0);
  self.cannon setturretteam("axis");
  self.cannon setleftarc(180);
  self.cannon setrightarc(180);
  self.cannon settoparc(80);
  self.cannon setbottomarc(0);
  self _meth_82A2(%veh_mil_air_ca_mons_main_cannon_open);
  wait(getanimlength(%veh_mil_air_ca_mons_main_cannon_open) * var_0);
}

_id_E058() {
  self endon("death");

  if(!isDefined(self.cannon)) {
    return;
  }
  var_0 = 1;
  level notify("removing_mons_cannon");
  var_1 = self gettagorigin("tag_main_cannon");
  var_2 = anglesToForward(self gettagangles("tag_main_cannon"));
  var_3 = var_1 + var_2 * 10000;
  var_4 = spawn("script_origin", var_3);
  var_4 linkTo(self);
  self.cannon _meth_8535(0);
  self clearanim(%veh_mil_air_ca_mons_main_cannon_open, 0);
  self _meth_82A2(%veh_mil_air_ca_mons_main_cannon_close);
  wait(getanimlength(%veh_mil_air_ca_mons_main_cannon_close));
  self showpart("tag_main_cannon_hood");
  self.cannon delete();
  var_4 delete();
}

_id_5171() {
  if(!isDefined(self.cannon)) {
    return;
  }
  self.cannon delete();
}

_id_BA69(var_0, var_1) {
  var_2 = spawn("script_origin", var_0);
  _id_BA68(var_2, var_1);
  thread _id_409A(var_2);
}

_id_409A(var_0) {
  level scripts\engine\utility::waittill_any("mons_cannon_fired", "removing_mons_cannon");
  var_0 delete();
}

_id_BA68(var_0, var_1) {
  level notify("mons_cannon_targeting");
  level endon("mons_cannon_targeting");
  level endon("removing_mons_cannon");
  self.cannon _meth_8535(0);
  self.cannon _meth_82C9(var_1, "yaw");
  self.cannon _meth_82C9(var_1, "pitch");
  self.cannon settargetentity(var_0);
  self.cannon scripts\engine\utility::waittill_notify_or_timeout("turret_on_target", var_1);
}

_id_BA6A(var_0, var_1, var_2) {
  level endon("mons_cannon_targeting");
  level endon("removing_mons_cannon");

  if(!isDefined(var_2))
    var_2 = 1;

  var_3 = "tag_fx";

  if(!isDefined(self._id_38D7)) {
    self._id_38D7 = spawn("script_origin", self.cannon gettagorigin(var_3));
    self._id_38D7 linkTo(self.cannon, "tag_fx");
    self._id_38D7 thread _id_B2DF();
    self._id_38D7 thread _id_BA6B();
  }

  if(var_0 > 0) {
    var_4 = gettime();
    var_5 = var_4 + var_0 * 1000;
    playFXOnTag(level._effect["vfx_heist_mons_steeldragon_chargeup"], self.cannon, var_3);

    while(gettime() < var_5) {
      earthquake(0.1, 0.05, self.origin, 150000);
      wait 0.05;
    }

    self._id_38D7 notify("chargeup_over");
    stopFXOnTag(level._effect["vfx_heist_mons_steeldragon_chargeup"], self.cannon, var_3);
  }

  playFXOnTag(level._effect["vfx_heist_mons_steeldragon_loop"], self.cannon, var_3);
  var_4 = gettime();
  var_1 = var_4 + var_1 * 1000;

  while(gettime() < var_1) {
    if(var_2)
      var_6 = self.cannon getturrettarget(0).origin;
    else
      var_6 = self.cannon._id_11512.origin;

    var_7 = self.cannon gettagorigin(var_3);
    var_8 = self.cannon gettagangles(var_3);
    playfxbetweenpoints(level._effect["vfx_heist_mons_steeldragon_beam"], var_7, var_8, var_6);
    earthquake(0.3, 0.1, self.origin, 150000);
    wait 0.1;
  }

  stopFXOnTag(level._effect["vfx_heist_mons_steeldragon_loop"], self.cannon, var_3);
  level notify("mons_cannon_fired");

  if(var_2) {
    self.cannon cleartargetentity();
    self.cannon _meth_8535(1);
  }
}

_id_B2DF() {
  var_0 = self.origin;
  level endon("mons_cannon_targeting");
  level endon("removing_mons_cannon");
  self endon("death");
  self playSound("heistspace_fspar_spool_up");
  self waittill("chargeup_over");
  self stopsounds();
  self playSound("heistspace_fspar_fire");
  level waittill("mons_cannon_fired");
  self stopsounds();
  thread scripts\engine\utility::play_sound_in_space("heistspace_fspar_powerdown", var_0);
}

_id_BA6B() {
  level scripts\engine\utility::waittill_any("mons_cannon_fired", "mons_cannon_targeting", "removing_mons_cannon");
  self stopsounds();
  wait 0.05;
  self delete();
}