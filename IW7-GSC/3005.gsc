/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3005.gsc
**************************************/

main(var_0, var_1, var_2) {
  scripts\sp\vehicle_build::_id_31C5("dropship", var_0, var_1, var_2);
  scripts\sp\vehicle_build::_id_31A6(::init_location);
  scripts\sp\vehicle_build::_id_31A3(3000, 2800, 3100);
  scripts\sp\vehicle_build::_id_31C4("axis");

  if(issubstr(var_2, "_space")) {
    scripts\sp\vehicle_build::build_ace(::_id_F8A2, ::_id_F5FC);
  } else {
    scripts\sp\vehicle_build::build_ace(::_id_F8A1, ::_id_F5FC);
  }

  scripts\sp\vehicle_build::_id_31CC(::_id_12BBD);
  scripts\sp\vehicle_build::_id_3184("vfx/iw7/core/vehicle/dropship/vfx_dropship_death_01.vfx", undefined, "dropship_helicopter_crash", undefined, undefined, undefined, -1, undefined, "stop_crash_loop_sound", 10, 5);
  scripts\sp\vehicle_build::_id_31B7("vfx/iw7/core/vehicle/dropship/vfx_dropship_death_01.vfx", "tag_body", "dropship_helicopter_crash", undefined, undefined, undefined, undefined, 1, undefined, 0);
  var_3 = "vfx/code/tread/heli_dust_default.vfx";
  scripts\sp\vehicle_build::_id_31C6(var_2, "default", var_3, 0);
  scripts\sp\vehicle_build::_id_31B8("light_1s", 0.12, 0.15, 3000, 0.05, 0.05);

  if(issubstr(var_2, "plane")) {
    scripts\sp\vehicle_build::_id_319F();
  } else {
    scripts\sp\vehicle_build::_id_31A0();
  }

  if(!issubstr(var_2, "cheap")) {
    scripts\sp\vehicle_build::_id_31C8("sdf_dropship_turret_energy", "tag_chin_turret", "veh_mil_air_ca_dropship_turret", undefined, "auto_nonai", 0, 20, -14, undefined);
    scripts\sp\vehicle_build::_id_31C8("sdf_mg_turret", "tag_turret_attach_back", "weapon_railgun_turret", undefined, "auto_nonai", 0, 0, 0, undefined, "back");
    scripts\sp\vehicle_build::_id_31C8("sdf_mg_turret", "tag_turret_attach_le", "weapon_railgun_turret", undefined, "auto_nonai", 0, 0, 0, undefined, "left");
    scripts\sp\vehicle_build::_id_31C8("sdf_mg_turret", "tag_turret_attach_ri", "weapon_railgun_turret", undefined, "auto_nonai", 0, 0, 0, undefined, "right");
    precachemodel("veh_mil_air_ca_dropship_dst_rr");
    precachemodel("veh_mil_air_ca_dropship_dst_fr");
    precachemodel("veh_mil_air_ca_dropship_personnel");
    precachemodel("veh_mil_air_ca_dropship_mount");
    precacheturret("sdf_mg_turret");
  }

  _id_0BBE::_id_774E(var_2);
  level._id_7649["engine_damage_feedback"] = loadfx("vfx/iw7/levels/pearl_harbor/dropship_down/vfx_ph_dropship_shoot_engine_impact_amped.vfx");
  level._id_7649["enemy_dropship_engine_death"] = loadfx("vfx/iw7/levels/pearl_harbor/dropship_down/vfx_ph_dropship_shoot_engine_explode.vfx");
  level._id_7649["enemy_dropship_engine_damaged"] = loadfx("vfx/iw7/levels/pearl_harbor/dropship_down/vfx_ph_dropship_shoot_engine_flaming.vfx");
}

#using_animtree("vehicles");

init_location() {
  self._id_12BBF = 150;
  self._id_12BC1 = 450 + self._id_12BBF;
  self._id_5F80 = 1;

  if(issubstr(self.classname, "cheap")) {
    var_0 = ["tag_front_thruster_1_le", "tag_front_thruster_2_le", "tag_front_thruster_1_ri", "tag_front_thruster_2_ri"];
    var_1 = ["tag_back_thruster_1_le", "tag_back_thruster_2_le", "tag_back_thruster_1_ri", "tag_back_thruster_2_ri"];
    var_2 = ["tag_back_thruster_3_le", "tag_back_thruster_4_le", "tag_back_thruster_3_ri", "tag_back_thruster_4_ri"];
    var_3 = scripts\engine\utility::array_combine(var_0, var_1);
    var_3 = scripts\engine\utility::array_combine(var_3, var_2);
    thread _id_0BBE::_id_774B(var_3);
    return;
  }

  var_0 = ["tag_front_thruster_1_le", "tag_front_thruster_2_le", "tag_front_thruster_1_ri", "tag_front_thruster_2_ri"];
  _id_0BBE::_id_FA5F("side_front", var_0);
  var_1 = ["tag_back_thruster_1_le", "tag_back_thruster_2_le", "tag_back_thruster_1_ri", "tag_back_thruster_2_ri"];
  _id_0BBE::_id_FA5F("side_back", var_1);
  var_2 = ["tag_back_thruster_3_le", "tag_back_thruster_4_le", "tag_back_thruster_3_ri", "tag_back_thruster_4_ri"];
  _id_0BBE::_id_FA5F("back", var_2, 10);
  thread _id_0BBE::_id_774D();
  var_4 = self.script_team;

  if(var_4 == "axis") {
    thread _id_0BBE::_id_774C();
  }

  thread _id_0BBE::_id_5EC8(%vh_dropship_sdf_thrusters_up, %vh_dropship_sdf_thrusters_down);

  if(!issubstr(self.classname, "c6")) {
    self attach("veh_mil_air_ca_dropship_personnel", "tag_connect");
  }

  thread _id_3E7A();
  thread _id_101B3();
}

_id_3E7A() {
  self endon("death");

  if(!isDefined(self._id_EEF8)) {
    self._id_EEF8 = 0;
  }

  wait 0.05;
  self.mgturret[0] setleftarc(65);
  self.mgturret[0] setrightarc(65);
  self.mgturret[0] settoparc(65);
  self.mgturret[0] setbottomarc(65);
  self.mgturret[0]._id_ED26 = 0.75;
  self.mgturret[0]._id_ED25 = 1.5;
  self.mgturret[0].script_delay_min = 0.25;
  self.mgturret[0].script_delay_max = 0.75;
  self.mgturret[0]._id_ED24 = 0.12;
  self.mgturret[0] notify("stop_burst_fire_unmanned");
  self.mgturret[0] thread scripts\sp\mgturret::_id_32B7();
}

_id_101B3() {
  wait 0.05;

  foreach(var_1 in self.mgturret) {
    if(!isDefined(var_1._id_DE46)) {
      continue;
    }
    var_2 = undefined;

    switch (var_1._id_DE46) {
      case "back":
        var_2 = "back";
        break;
      case "left":
        var_2 = "le";
        break;
      case "right":
        var_2 = "ri";
        break;
    }

    var_2 = "tag_turret_mount_" + var_2;
    var_3 = spawn("script_model", self gettagorigin(var_2));
    var_3 linkTo(self, var_2, (0, 0, 0), (0, 0, 0));
    var_3 setModel("veh_mil_air_ca_dropship_mount");
  }
}

_id_5DB9(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "right":
      var_1 = % vh_ca_dropship_side_door_r_open;
      break;
    case "left":
      var_1 = % vh_ca_dropship_side_door_l_open;
      break;
    case "back":
      var_1 = % vh_dropship_sdf_rear_doors_open;
      break;
  }

  self _meth_82A2(var_1);
}

_id_5DB7(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  switch (var_0) {
    case "right":
      var_1 = % vh_ca_dropship_side_door_r_open;
      var_2 = % vh_ca_dropship_side_door_r_close;
      break;
    case "left":
      var_1 = % vh_ca_dropship_side_door_l_open;
      var_2 = % vh_ca_dropship_side_door_l_close;
      break;
    case "back":
      var_1 = % vh_dropship_sdf_rear_doors_open;
      var_2 = % vh_dropship_sdf_rear_doors_close;
      break;
  }

  self clearanim(var_1, 0.05);
  self _meth_82A2(var_2);
}

#using_animtree("generic_human");

_id_F8A1() {
  var_0 = [];

  for(var_1 = 0; var_1 < 17; var_1++) {
    var_0[var_1] = spawnStruct();
    var_0[var_1]._id_10220 = "tag_detach";
    var_0[var_1]._id_803A = "stand";
    var_0[var_1]._id_DC19 = 1;
  }

  var_0[0]._id_92CC = % vh_org_dropship_sdf_idle_pilot;
  var_0[1]._id_92CC = % vh_org_dropship_sdf_idle_copilot;
  var_0[2]._id_92CC = % vh_org_dropship_sdf_unload_guy1_idle;
  var_0[3]._id_92CC = % vh_org_dropship_sdf_unload_guy2_idle;
  var_0[4]._id_92CC = % vh_org_dropship_sdf_unload_guy3_idle;
  var_0[5]._id_92CC = % vh_org_dropship_sdf_unload_guy4_idle;
  var_0[6]._id_92CC = % vh_org_dropship_sdf_unload_guy5_idle;
  var_0[7]._id_92CC = % vh_org_dropship_sdf_unload_guy6_idle;
  var_0[8]._id_92CC = % vh_org_dropship_sdf_unload_guy7_idle;
  var_0[9]._id_92CC = % vh_org_dropship_sdf_unload_guy8_idle;
  var_0[10]._id_92CC = % vh_org_dropship_sdf_unload_guy9_idle;
  var_0[11]._id_92CC = % vh_org_dropship_sdf_unload_guy10_idle;
  var_0[12]._id_92CC = % vh_org_dropship_sdf_unload_guy11_idle;
  var_0[13]._id_92CC = % vh_org_dropship_sdf_unload_guy12_idle;
  var_0[2]._id_8028 = % vh_org_dropship_sdf_unload_jump_guy1;
  var_0[3]._id_8028 = % vh_org_dropship_sdf_unload_jump_guy2;
  var_0[4]._id_8028 = % vh_org_dropship_sdf_unload_jump_guy3;
  var_0[5]._id_8028 = % vh_org_dropship_sdf_unload_jump_guy4;
  var_0[6]._id_8028 = % vh_org_dropship_sdf_unload_jump_guy5;
  var_0[7]._id_8028 = % vh_org_dropship_sdf_unload_jump_guy6;
  var_0[8]._id_8028 = % vh_org_dropship_sdf_unload_jump_guy7;
  var_0[9]._id_8028 = % vh_org_dropship_sdf_unload_jump_guy8;
  var_0[2]._id_802D = % vh_org_dropship_sdf_unload_jump_loop_guy1;
  var_0[3]._id_802D = % vh_org_dropship_sdf_unload_jump_loop_guy2;
  var_0[4]._id_802D = % vh_org_dropship_sdf_unload_jump_loop_guy3;
  var_0[5]._id_802D = % vh_org_dropship_sdf_unload_jump_loop_guy4;
  var_0[6]._id_802D = % vh_org_dropship_sdf_unload_jump_loop_guy5;
  var_0[7]._id_802D = % vh_org_dropship_sdf_unload_jump_loop_guy6;
  var_0[8]._id_802D = % vh_org_dropship_sdf_unload_jump_loop_guy7;
  var_0[9]._id_802D = % vh_org_dropship_sdf_unload_jump_loop_guy8;
  var_0[2]._id_802C = % vh_org_dropship_sdf_unload_land_guy1;
  var_0[3]._id_802C = % vh_org_dropship_sdf_unload_land_guy2;
  var_0[4]._id_802C = % vh_org_dropship_sdf_unload_land_guy3;
  var_0[5]._id_802C = % vh_org_dropship_sdf_unload_land_guy4;
  var_0[6]._id_802C = % vh_org_dropship_sdf_unload_land_guy5;
  var_0[7]._id_802C = % vh_org_dropship_sdf_unload_land_guy6;
  var_0[8]._id_802C = % vh_org_dropship_sdf_unload_land_guy7;
  var_0[9]._id_802C = % vh_org_dropship_sdf_unload_land_guy8;
  var_0[14].mgturret = 1;
  var_0[15].mgturret = 2;
  var_0[16].mgturret = 3;
  return var_0;
}

_id_F8A2() {
  var_0 = [];

  for(var_1 = 0; var_1 < 15; var_1++) {
    var_0[var_1] = spawnStruct();
    var_0[var_1]._id_10220 = "tag_detach";
    var_0[var_1]._id_803A = "stand";
    var_0[var_1]._id_DC19 = 1;
  }

  var_0[0]._id_92CC = % vh_org_dropship_sdf_idle_pilot;
  var_0[1]._id_92CC = % vh_org_dropship_sdf_idle_copilot;
  var_0[2]._id_92CC = % vh_zg_org_dropship_sdf_unload_guy1_idle;
  var_0[3]._id_92CC = % vh_zg_org_dropship_sdf_unload_guy2_idle;
  var_0[4]._id_92CC = % vh_zg_org_dropship_sdf_unload_guy3_idle;
  var_0[5]._id_92CC = % vh_zg_org_dropship_sdf_unload_guy4_idle;
  var_0[6]._id_92CC = % vh_zg_org_dropship_sdf_unload_guy5_idle;
  var_0[7]._id_92CC = % vh_zg_org_dropship_sdf_unload_guy6_idle;
  var_0[8]._id_92CC = % vh_zg_org_dropship_sdf_unload_guy7_idle;
  var_0[9]._id_92CC = % vh_zg_org_dropship_sdf_unload_guy8_idle;
  var_0[10]._id_92CC = % vh_zg_org_dropship_sdf_unload_guy9_idle;
  var_0[11]._id_92CC = % vh_zg_org_dropship_sdf_unload_guy10_idle;
  var_0[12]._id_92CC = % vh_zg_org_dropship_sdf_unload_guy11_idle;
  var_0[13]._id_92CC = % vh_zg_org_dropship_sdf_unload_guy12_idle;
  var_0[2]._id_8028 = % vh_zg_org_dropship_sdf_unload_guy1;
  var_0[3]._id_8028 = % vh_zg_org_dropship_sdf_unload_guy2;
  var_0[4]._id_8028 = % vh_zg_org_dropship_sdf_unload_guy3;
  var_0[5]._id_8028 = % vh_zg_org_dropship_sdf_unload_guy4;
  var_0[6]._id_8028 = % vh_zg_org_dropship_sdf_unload_guy5;
  var_0[7]._id_8028 = % vh_zg_org_dropship_sdf_unload_guy6;
  var_0[8]._id_8028 = % vh_zg_org_dropship_sdf_unload_guy7;
  var_0[9]._id_8028 = % vh_zg_org_dropship_sdf_unload_guy8;
  var_0[10]._id_8028 = % vh_zg_org_dropship_sdf_unload_guy9;
  var_0[11]._id_8028 = % vh_zg_org_dropship_sdf_unload_guy10;
  var_0[12]._id_8028 = % vh_zg_org_dropship_sdf_unload_guy11;
  var_0[13]._id_8028 = % vh_zg_org_dropship_sdf_unload_guy12;
  return var_0;
}

#using_animtree("vehicles");

_id_F5FC(var_0) {
  var_0[2]._id_131E6 = % vh_ca_dropship_side_door_l_open;
  var_0[2]._id_131E7 = 0;
  var_0[6]._id_131E6 = % vh_ca_dropship_side_door_r_open;
  var_0[6]._id_131E7 = 0;
  var_0[10]._id_131E6 = % vh_dropship_sdf_rear_doors_open;
  var_0[10]._id_131E7 = 0;
  return var_0;
}

_id_12BBD() {
  var_0 = [];
  var_1 = "left";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_0[var_1][var_0[var_1].size] = 4;
  var_0[var_1][var_0[var_1].size] = 5;
  var_1 = "right";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 6;
  var_0[var_1][var_0[var_1].size] = 7;
  var_0[var_1][var_0[var_1].size] = 8;
  var_0[var_1][var_0[var_1].size] = 9;
  var_1 = "back";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 10;
  var_0[var_1][var_0[var_1].size] = 11;
  var_0[var_1][var_0[var_1].size] = 12;
  var_0[var_1][var_0[var_1].size] = 13;
  var_1 = "all";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_0[var_1][var_0[var_1].size] = 4;
  var_0[var_1][var_0[var_1].size] = 5;
  var_0[var_1][var_0[var_1].size] = 6;
  var_0[var_1][var_0[var_1].size] = 7;
  var_0[var_1][var_0[var_1].size] = 8;
  var_0[var_1][var_0[var_1].size] = 9;
  var_0[var_1][var_0[var_1].size] = 10;
  var_0[var_1][var_0[var_1].size] = 11;
  var_0[var_1][var_0[var_1].size] = 12;
  var_0[var_1][var_0[var_1].size] = 13;
  var_0["default"] = var_0["all"];
  return var_0;
}

_id_5DCE(var_0) {
  self endon("death");
  self endon("stop_engine_damage_manager");
  scripts\sp\utility::_id_65E0("thruster_near_death");
  scripts\sp\vehicle::_id_8441();
  var_1 = ["j_wing_front_le", "j_wing_mid_le", "j_wing_front_ri", "j_wing_mid_ri"];
  self._id_65CD = [];

  foreach(var_3 in var_1) {
    self._id_65CD[var_3] = spawnStruct();
    self._id_65CD[var_3].maxhealth = 1500;
    self._id_65CD[var_3].health = self._id_65CD[var_3].maxhealth;
    self._id_65CD[var_3]._id_9BB8 = 0;
    self._id_65CD[var_3]._id_5762 = level._id_7649["enemy_dropship_engine_damaged"];
    self._id_65CD[var_3]._id_4E26 = level._id_7649["enemy_dropship_engine_death"];
    self._id_65CD[var_3]._id_5290 = "frag_grenade_explode";

    if(isDefined(var_0)) {
      self._id_65CD[var_3]._id_4E40 = var_0;
    }

    switch (var_3) {
      case "j_wing_mid_ri":
        self._id_65CD[var_3]._id_2C40 = "veh_mil_air_ca_dropship_dst_rr";
        self._id_65CD[var_3]._id_2C41 = "j_wing_mid_RI";
        self._id_65CD[var_3]._id_11867 = ["tag_back_thruster_1_ri", "tag_back_thruster_2_ri"];
        break;
      case "j_wing_front_ri":
        self._id_65CD[var_3]._id_2C40 = "veh_mil_air_ca_dropship_dst_fr";
        self._id_65CD[var_3]._id_2C41 = "j_wing_front_RI";
        self._id_65CD[var_3]._id_11867 = ["tag_front_thruster_1_ri", "tag_front_thruster_2_ri"];
      default:
        break;
    }
  }

  for(;;) {
    self waittill("damage", var_5, var_6, var_7, var_8, var_7, var_7, var_7, var_9, var_7, var_10);

    if(isDefined(var_6) && isPlayer(var_6) || isDefined(var_6) && isDefined(level._id_A351) && var_6 == level._id_A351) {
      _id_D973(var_9, var_5, var_8);
    }
  }
}

_id_D973(var_0, var_1, var_2) {
  if(isDefined(level._id_5D81) && isDefined(level._id_5D81._id_24C0)) {
    level._id_5D81._id_24C0 = level._id_5D81._id_24C0 - 0.15;
  }

  if(isDefined(var_0) && !isDefined(self._id_65CD[var_0])) {
    return;
  }
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return;
  }
  thread scripts\sp\damagefeedback::monitordamage();

  if(isDefined(var_2)) {
    playFX(level._id_7649["engine_damage_feedback"], var_2);
  }

  self._id_65CD[var_0].health = self._id_65CD[var_0].health - var_1;

  if(getdvarint("debug_engine_dmg")) {}

  if(self._id_65CD[var_0].health < 1) {
    if(getdvarint("debug_engine_dmg")) {}

    _id_A5DA(var_0);
  } else if(self._id_65CD[var_0].health <= self._id_65CD[var_0].maxhealth * 0.75 && !isDefined(self._id_65CD[var_0]._id_9DA7)) {
    if(getdvarint("debug_engine_dmg")) {}

    self._id_65CD[var_0]._id_9DA7 = 1;
    playFXOnTag(level._id_7649["enemy_dropship_engine_damaged"], self, var_0);

    if(isDefined(self._id_65CD[var_0]._id_11867)) {
      _id_0BBE::_id_A61E(self._id_65CD[var_0]._id_11867);
    }
  } else if(self._id_65CD[var_0].health <= self._id_65CD[var_0].maxhealth * 0.25 && !scripts\sp\utility::_id_65DB("thruster_near_death"))
    scripts\sp\utility::_id_65E1("thruster_near_death");
}

_id_A5DA(var_0) {
  if(self._id_65CD[var_0]._id_9BB8) {
    return;
  }
  self._id_65CD[var_0]._id_9BB8 = 1;

  if(isDefined(self._id_65CD[var_0]._id_2C40) && isDefined(self._id_65CD[var_0]._id_2C41)) {
    self._id_65CD[var_0]._id_9BB8 = 1;
    var_1 = spawn("script_model", self gettagorigin(self._id_65CD[var_0]._id_2C41));
    var_1 linkTo(self, self._id_65CD[var_0]._id_2C41, (0, 0, 0), (0, 0, 0));
    var_1 setModel(self._id_65CD[var_0]._id_2C40);
    thread scripts\engine\utility::delete_on_death(var_1);
  }

  playFXOnTag(level._id_7649["enemy_dropship_engine_death"], self, var_0);

  if(isDefined(self._id_65CD[var_0]._id_5290)) {
    playworldsound(self._id_65CD[var_0]._id_5290, self gettagorigin(var_0));
  }

  if(!isDefined(self._id_65CD[var_0]._id_4E40)) {
    return;
  }
  var_2 = 0;

  if(isDefined(self._id_B73F)) {
    var_3 = 0;

    foreach(var_5 in self._id_65CD) {
      if(var_5._id_9BB8) {
        var_3++;
      }
    }

    if(var_3 >= self._id_B73F) {
      var_2 = 1;
    } else {
      thread _id_101AF();
    }
  } else
    var_2 = 1;

  if(var_2) {
    self thread[[self._id_65CD[var_0]._id_4E40]]();
  }
}

_id_CD70(var_0, var_1, var_2) {
  self notify("custom_death_begin");
  self._id_1FEB = scripts\engine\utility::spawn_tag_origin();
  self linkTo(self._id_1FEB);
  var_3 = undefined;

  if(isstring(var_1)) {
    var_3 = getanimlength(level._id_EC85[self._id_1FBB][var_1]);
    self._id_1FEB thread scripts\sp\anim::_id_1F35(self, var_1);
  } else {
    var_3 = getanimlength(var_1);
    self animScripted("single anim", self.origin, self.angles, var_1);
  }

  if(!isDefined(var_2)) {
    var_2 = var_3;
  }

  if(getdvarint("debug_engine_dmg")) {
    thread scripts\sp\utility::_id_5B51(var_0.origin, self, 1, 0, 0, var_3);
  }

  self._id_1FEB moveTo(var_0.origin, var_2);
  self._id_1FEB rotateTo(var_0.angles, var_2);
  wait(var_3);
  self._id_1FEB delete();
  self notify("custom_death_end");
}

_id_101AF() {
  if(isDefined(self._id_9BC0)) {
    return;
  }
  self._id_9BC0 = 1;
  var_0 = 200;
  var_1 = self.angles;
  var_1 = (0, var_1[1], 0);
  var_2 = anglestoright(var_1);
  var_3 = var_2 * var_0;
  var_4 = self.origin + var_3;
  var_5 = undefined;

  if(!isDefined(self._id_A8AC)) {
    if(randomint(100) < 50) {
      self._id_A8AC = "left";
    } else {
      self._id_A8AC = "right";
    }
  }

  if(bullettracepassed(self.origin, var_4, 0, self) && self._id_A8AC == "left") {
    self._id_A8AC = "right";
    var_5 = var_4;
  } else {
    var_3 = var_3 * -1;
    var_4 = self.origin + var_3;

    if(bullettracepassed(self.origin, var_4, 0, self)) {
      self._id_A8AC = "left";
      var_5 = var_4;
    }
  }

  if(!isDefined(var_5)) {
    self._id_9BC0 = undefined;
    return;
  } else {
    var_6 = self.origin;
    self setvehgoalpos(var_5 + (0, 0, 100));
    self vehicle_setspeed(60, 50, 10);
    wait 3;
    self setvehgoalpos(var_6, 1);
    self vehicle_setspeed(50, 25, 25);
    self._id_9BC0 = undefined;
    return;
  }
}