/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3005.gsc
************************/

main(param_00, param_01, param_02) {
  scripts\sp\vehicle_build::func_31C5("dropship", param_00, param_01, param_02);
  scripts\sp\vehicle_build::func_31A6(::init_location);
  scripts\sp\vehicle_build::func_31A3(3000, 2800, 3100);
  scripts\sp\vehicle_build::func_31C4("axis");
  if(issubstr(param_02, "_space")) {
    scripts\sp\vehicle_build::build_ace(::func_F8A2, ::func_F5FC);
  } else {
    scripts\sp\vehicle_build::build_ace(::func_F8A1, ::func_F5FC);
  }

  scripts\sp\vehicle_build::func_31CC(::func_12BBD);
  scripts\sp\vehicle_build::func_3184("vfx\iw7\core\vehicle\dropship\vfx_dropship_death_01.vfx", undefined, "dropship_helicopter_crash", undefined, undefined, undefined, -1, undefined, "stop_crash_loop_sound", 10, 5);
  scripts\sp\vehicle_build::func_31B7("vfx\iw7\core\vehicle\dropship\vfx_dropship_death_01.vfx", "tag_body", "dropship_helicopter_crash", undefined, undefined, undefined, undefined, 1, undefined, 0);
  var_03 = "vfx\code\tread\heli_dust_default.vfx";
  scripts\sp\vehicle_build::func_31C6(param_02, "default", var_03, 0);
  scripts\sp\vehicle_build::func_31B8("light_1s", 0.12, 0.15, 3000, 0.05, 0.05);
  if(issubstr(param_02, "plane")) {
    scripts\sp\vehicle_build::func_319F();
  } else {
    scripts\sp\vehicle_build::func_31A0();
  }

  if(!issubstr(param_02, "cheap")) {
    scripts\sp\vehicle_build::func_31C8("sdf_dropship_turret_energy", "tag_chin_turret", "veh_mil_air_ca_dropship_turret", undefined, "auto_nonai", 0, 20, -14, undefined);
    scripts\sp\vehicle_build::func_31C8("sdf_mg_turret", "tag_turret_attach_back", "weapon_railgun_turret", undefined, "auto_nonai", 0, 0, 0, undefined, "back");
    scripts\sp\vehicle_build::func_31C8("sdf_mg_turret", "tag_turret_attach_le", "weapon_railgun_turret", undefined, "auto_nonai", 0, 0, 0, undefined, "left");
    scripts\sp\vehicle_build::func_31C8("sdf_mg_turret", "tag_turret_attach_ri", "weapon_railgun_turret", undefined, "auto_nonai", 0, 0, 0, undefined, "right");
    precachemodel("veh_mil_air_ca_dropship_dst_rr");
    precachemodel("veh_mil_air_ca_dropship_dst_fr");
    precachemodel("veh_mil_air_ca_dropship_personnel");
    precachemodel("veh_mil_air_ca_dropship_mount");
    precacheturret("sdf_mg_turret");
  }

  lib_0BBE::func_774E(param_02);
  level.var_7649["engine_damage_feedback"] = loadfx("vfx\iw7\levels\pearl_harbor\dropship_down\vfx_ph_dropship_shoot_engine_impact_amped.vfx");
  level.var_7649["enemy_dropship_engine_death"] = loadfx("vfx\iw7\levels\pearl_harbor\dropship_down\vfx_ph_dropship_shoot_engine_explode.vfx");
  level.var_7649["enemy_dropship_engine_damaged"] = loadfx("vfx\iw7\levels\pearl_harbor\dropship_down\vfx_ph_dropship_shoot_engine_flaming.vfx");
}

init_location() {
  self.var_12BBF = 150;
  self.var_12BC1 = 450 + self.var_12BBF;
  self.var_5F80 = 1;
  if(issubstr(self.classname, "cheap")) {
    var_00 = ["tag_front_thruster_1_le", "tag_front_thruster_2_le", "tag_front_thruster_1_ri", "tag_front_thruster_2_ri"];
    var_01 = ["tag_back_thruster_1_le", "tag_back_thruster_2_le", "tag_back_thruster_1_ri", "tag_back_thruster_2_ri"];
    var_02 = ["tag_back_thruster_3_le", "tag_back_thruster_4_le", "tag_back_thruster_3_ri", "tag_back_thruster_4_ri"];
    var_03 = scripts\engine\utility::array_combine(var_00, var_01);
    var_03 = scripts\engine\utility::array_combine(var_03, var_02);
    thread lib_0BBE::func_774B(var_03);
    return;
  }

  var_00 = ["tag_front_thruster_1_le", "tag_front_thruster_2_le", "tag_front_thruster_1_ri", "tag_front_thruster_2_ri"];
  lib_0BBE::func_FA5F("side_front", var_03);
  var_01 = ["tag_back_thruster_1_le", "tag_back_thruster_2_le", "tag_back_thruster_1_ri", "tag_back_thruster_2_ri"];
  lib_0BBE::func_FA5F("side_back", var_03);
  var_02 = ["tag_back_thruster_3_le", "tag_back_thruster_4_le", "tag_back_thruster_3_ri", "tag_back_thruster_4_ri"];
  lib_0BBE::func_FA5F("back", var_03, 10);
  thread lib_0BBE::func_774D();
  var_04 = self.script_team;
  if(var_04 == "axis") {
    thread lib_0BBE::func_774C();
  }

  thread lib_0BBE::func_5EC8( % vh_dropship_sdf_thrusters_up, % vh_dropship_sdf_thrusters_down);
  if(!issubstr(self.classname, "c6")) {
    self attach("veh_mil_air_ca_dropship_personnel", "tag_connect");
  }

  thread func_3E7A();
  thread func_101B3();
}

func_3E7A() {
  self endon("death");
  if(!isDefined(self.var_EEF8)) {
    self.var_EEF8 = 0;
  }

  wait(0.05);
  self.mgturret[0] setleftarc(65);
  self.mgturret[0] setrightarc(65);
  self.mgturret[0] settoparc(65);
  self.mgturret[0] give_crafted_gascan(65);
  self.mgturret[0].var_ED26 = 0.75;
  self.mgturret[0].var_ED25 = 1.5;
  self.mgturret[0].script_delay_min = 0.25;
  self.mgturret[0].script_delay_max = 0.75;
  self.mgturret[0].var_ED24 = 0.12;
  self.mgturret[0] notify("stop_burst_fire_unmanned");
  self.mgturret[0] thread scripts\sp\mgturret::func_32B7();
}

func_101B3() {
  wait(0.05);
  foreach(var_01 in self.mgturret) {
    if(!isDefined(var_01.var_DE46)) {
      continue;
    }

    var_02 = undefined;
    switch (var_01.var_DE46) {
      case "back":
        var_02 = "back";
        break;

      case "left":
        var_02 = "le";
        break;

      case "right":
        var_02 = "ri";
        break;
    }

    var_02 = "tag_turret_mount_" + var_02;
    var_03 = spawn("script_model", self gettagorigin(var_02));
    var_03 linkto(self, var_02, (0, 0, 0), (0, 0, 0));
    var_03 setModel("veh_mil_air_ca_dropship_mount");
  }
}

func_5DB9(param_00) {
  var_01 = undefined;
  switch (param_00) {
    case "right":
      var_01 = % vh_ca_dropship_side_door_r_open;
      break;

    case "left":
      var_01 = % vh_ca_dropship_side_door_l_open;
      break;

    case "back":
      var_01 = % vh_dropship_sdf_rear_doors_open;
      break;
  }

  self give_attacker_kill_rewards(var_01);
}

func_5DB7(param_00) {
  var_01 = undefined;
  var_02 = undefined;
  switch (param_00) {
    case "right":
      var_01 = % vh_ca_dropship_side_door_r_open;
      var_02 = % vh_ca_dropship_side_door_r_close;
      break;

    case "left":
      var_01 = % vh_ca_dropship_side_door_l_open;
      var_02 = % vh_ca_dropship_side_door_l_close;
      break;

    case "back":
      var_01 = % vh_dropship_sdf_rear_doors_open;
      var_02 = % vh_dropship_sdf_rear_doors_close;
      break;
  }

  self clearanim(var_01, 0.05);
  self give_attacker_kill_rewards(var_02);
}

func_F8A1() {
  var_00 = [];
  for(var_01 = 0; var_01 < 17; var_01++) {
    var_00[var_01] = spawnStruct();
    var_00[var_01].var_10220 = "tag_detach";
    var_00[var_01].botgetscriptgoalyaw = "stand";
    var_00[var_01].var_DC19 = 1;
  }

  var_00[0].var_92CC = % vh_org_dropship_sdf_idle_pilot;
  var_00[1].var_92CC = % vh_org_dropship_sdf_idle_copilot;
  var_00[2].var_92CC = % vh_org_dropship_sdf_unload_guy1_idle;
  var_00[3].var_92CC = % vh_org_dropship_sdf_unload_guy2_idle;
  var_00[4].var_92CC = % vh_org_dropship_sdf_unload_guy3_idle;
  var_00[5].var_92CC = % vh_org_dropship_sdf_unload_guy4_idle;
  var_00[6].var_92CC = % vh_org_dropship_sdf_unload_guy5_idle;
  var_00[7].var_92CC = % vh_org_dropship_sdf_unload_guy6_idle;
  var_00[8].var_92CC = % vh_org_dropship_sdf_unload_guy7_idle;
  var_00[9].var_92CC = % vh_org_dropship_sdf_unload_guy8_idle;
  var_00[10].var_92CC = % vh_org_dropship_sdf_unload_guy9_idle;
  var_00[11].var_92CC = % vh_org_dropship_sdf_unload_guy10_idle;
  var_00[12].var_92CC = % vh_org_dropship_sdf_unload_guy11_idle;
  var_00[13].var_92CC = % vh_org_dropship_sdf_unload_guy12_idle;
  var_00[2].botclearscriptgoal = % vh_org_dropship_sdf_unload_jump_guy1;
  var_00[3].botclearscriptgoal = % vh_org_dropship_sdf_unload_jump_guy2;
  var_00[4].botclearscriptgoal = % vh_org_dropship_sdf_unload_jump_guy3;
  var_00[5].botclearscriptgoal = % vh_org_dropship_sdf_unload_jump_guy4;
  var_00[6].botclearscriptgoal = % vh_org_dropship_sdf_unload_jump_guy5;
  var_00[7].botclearscriptgoal = % vh_org_dropship_sdf_unload_jump_guy6;
  var_00[8].botclearscriptgoal = % vh_org_dropship_sdf_unload_jump_guy7;
  var_00[9].botclearscriptgoal = % vh_org_dropship_sdf_unload_jump_guy8;
  var_00[2].botgetdifficultysetting = % vh_org_dropship_sdf_unload_jump_loop_guy1;
  var_00[3].botgetdifficultysetting = % vh_org_dropship_sdf_unload_jump_loop_guy2;
  var_00[4].botgetdifficultysetting = % vh_org_dropship_sdf_unload_jump_loop_guy3;
  var_00[5].botgetdifficultysetting = % vh_org_dropship_sdf_unload_jump_loop_guy4;
  var_00[6].botgetdifficultysetting = % vh_org_dropship_sdf_unload_jump_loop_guy5;
  var_00[7].botgetdifficultysetting = % vh_org_dropship_sdf_unload_jump_loop_guy6;
  var_00[8].botgetdifficultysetting = % vh_org_dropship_sdf_unload_jump_loop_guy7;
  var_00[9].botgetdifficultysetting = % vh_org_dropship_sdf_unload_jump_loop_guy8;
  var_00[2].botgetdifficulty = % vh_org_dropship_sdf_unload_land_guy1;
  var_00[3].botgetdifficulty = % vh_org_dropship_sdf_unload_land_guy2;
  var_00[4].botgetdifficulty = % vh_org_dropship_sdf_unload_land_guy3;
  var_00[5].botgetdifficulty = % vh_org_dropship_sdf_unload_land_guy4;
  var_00[6].botgetdifficulty = % vh_org_dropship_sdf_unload_land_guy5;
  var_00[7].botgetdifficulty = % vh_org_dropship_sdf_unload_land_guy6;
  var_00[8].botgetdifficulty = % vh_org_dropship_sdf_unload_land_guy7;
  var_00[9].botgetdifficulty = % vh_org_dropship_sdf_unload_land_guy8;
  var_00[14].mgturret = 1;
  var_00[15].mgturret = 2;
  var_00[16].mgturret = 3;
  return var_00;
}

func_F8A2() {
  var_00 = [];
  for(var_01 = 0; var_01 < 15; var_01++) {
    var_00[var_01] = spawnStruct();
    var_00[var_01].var_10220 = "tag_detach";
    var_00[var_01].botgetscriptgoalyaw = "stand";
    var_00[var_01].var_DC19 = 1;
  }

  var_00[0].var_92CC = % vh_org_dropship_sdf_idle_pilot;
  var_00[1].var_92CC = % vh_org_dropship_sdf_idle_copilot;
  var_00[2].var_92CC = % vh_zg_org_dropship_sdf_unload_guy1_idle;
  var_00[3].var_92CC = % vh_zg_org_dropship_sdf_unload_guy2_idle;
  var_00[4].var_92CC = % vh_zg_org_dropship_sdf_unload_guy3_idle;
  var_00[5].var_92CC = % vh_zg_org_dropship_sdf_unload_guy4_idle;
  var_00[6].var_92CC = % vh_zg_org_dropship_sdf_unload_guy5_idle;
  var_00[7].var_92CC = % vh_zg_org_dropship_sdf_unload_guy6_idle;
  var_00[8].var_92CC = % vh_zg_org_dropship_sdf_unload_guy7_idle;
  var_00[9].var_92CC = % vh_zg_org_dropship_sdf_unload_guy8_idle;
  var_00[10].var_92CC = % vh_zg_org_dropship_sdf_unload_guy9_idle;
  var_00[11].var_92CC = % vh_zg_org_dropship_sdf_unload_guy10_idle;
  var_00[12].var_92CC = % vh_zg_org_dropship_sdf_unload_guy11_idle;
  var_00[13].var_92CC = % vh_zg_org_dropship_sdf_unload_guy12_idle;
  var_00[2].botclearscriptgoal = % vh_zg_org_dropship_sdf_unload_guy1;
  var_00[3].botclearscriptgoal = % vh_zg_org_dropship_sdf_unload_guy2;
  var_00[4].botclearscriptgoal = % vh_zg_org_dropship_sdf_unload_guy3;
  var_00[5].botclearscriptgoal = % vh_zg_org_dropship_sdf_unload_guy4;
  var_00[6].botclearscriptgoal = % vh_zg_org_dropship_sdf_unload_guy5;
  var_00[7].botclearscriptgoal = % vh_zg_org_dropship_sdf_unload_guy6;
  var_00[8].botclearscriptgoal = % vh_zg_org_dropship_sdf_unload_guy7;
  var_00[9].botclearscriptgoal = % vh_zg_org_dropship_sdf_unload_guy8;
  var_00[10].botclearscriptgoal = % vh_zg_org_dropship_sdf_unload_guy9;
  var_00[11].botclearscriptgoal = % vh_zg_org_dropship_sdf_unload_guy10;
  var_00[12].botclearscriptgoal = % vh_zg_org_dropship_sdf_unload_guy11;
  var_00[13].botclearscriptgoal = % vh_zg_org_dropship_sdf_unload_guy12;
  return var_00;
}

func_F5FC(param_00) {
  param_00[2].var_131E6 = % vh_ca_dropship_side_door_l_open;
  param_00[2].var_131E7 = 0;
  param_00[6].var_131E6 = % vh_ca_dropship_side_door_r_open;
  param_00[6].var_131E7 = 0;
  param_00[10].var_131E6 = % vh_dropship_sdf_rear_doors_open;
  param_00[10].var_131E7 = 0;
  return param_00;
}

func_12BBD() {
  var_00 = [];
  var_01 = "left";
  var_00[var_01] = [];
  var_00[var_01][var_00[var_01].size] = 2;
  var_00[var_01][var_00[var_01].size] = 3;
  var_00[var_01][var_00[var_01].size] = 4;
  var_00[var_01][var_00[var_01].size] = 5;
  var_01 = "right";
  var_00[var_01] = [];
  var_00[var_01][var_00[var_01].size] = 6;
  var_00[var_01][var_00[var_01].size] = 7;
  var_00[var_01][var_00[var_01].size] = 8;
  var_00[var_01][var_00[var_01].size] = 9;
  var_01 = "back";
  var_00[var_01] = [];
  var_00[var_01][var_00[var_01].size] = 10;
  var_00[var_01][var_00[var_01].size] = 11;
  var_00[var_01][var_00[var_01].size] = 12;
  var_00[var_01][var_00[var_01].size] = 13;
  var_01 = "all";
  var_00[var_01] = [];
  var_00[var_01][var_00[var_01].size] = 2;
  var_00[var_01][var_00[var_01].size] = 3;
  var_00[var_01][var_00[var_01].size] = 4;
  var_00[var_01][var_00[var_01].size] = 5;
  var_00[var_01][var_00[var_01].size] = 6;
  var_00[var_01][var_00[var_01].size] = 7;
  var_00[var_01][var_00[var_01].size] = 8;
  var_00[var_01][var_00[var_01].size] = 9;
  var_00[var_01][var_00[var_01].size] = 10;
  var_00[var_01][var_00[var_01].size] = 11;
  var_00[var_01][var_00[var_01].size] = 12;
  var_00[var_01][var_00[var_01].size] = 13;
  var_00["default"] = var_00["all"];
  return var_00;
}

func_5DCE(param_00) {
  self endon("death");
  self endon("stop_engine_damage_manager");
  scripts\sp\utility::func_65E0("thruster_near_death");
  scripts\sp\vehicle::playgestureviewmodel();
  var_01 = ["j_wing_front_le", "j_wing_mid_le", "j_wing_front_ri", "j_wing_mid_ri"];
  self.var_65CD = [];
  foreach(var_03 in var_01) {
    self.var_65CD[var_03] = spawnStruct();
    self.var_65CD[var_03].maxhealth = 1500;
    self.var_65CD[var_03].health = self.var_65CD[var_03].maxhealth;
    self.var_65CD[var_03].var_9BB8 = 0;
    self.var_65CD[var_03].var_5762 = level.var_7649["enemy_dropship_engine_damaged"];
    self.var_65CD[var_03].var_4E26 = level.var_7649["enemy_dropship_engine_death"];
    self.var_65CD[var_03].var_5290 = "frag_grenade_explode";
    if(isDefined(param_00)) {
      self.var_65CD[var_03].var_4E40 = param_00;
    }

    switch (var_03) {
      case "j_wing_mid_ri":
        self.var_65CD[var_03].var_2C40 = "veh_mil_air_ca_dropship_dst_rr";
        self.var_65CD[var_03].var_2C41 = "j_wing_mid_RI";
        self.var_65CD[var_03].var_11867 = ["tag_back_thruster_1_ri", "tag_back_thruster_2_ri"];
        break;

      case "j_wing_front_ri":
        self.var_65CD[var_03].var_2C40 = "veh_mil_air_ca_dropship_dst_fr";
        self.var_65CD[var_03].var_2C41 = "j_wing_front_RI";
        self.var_65CD[var_03].var_11867 = ["tag_front_thruster_1_ri", "tag_front_thruster_2_ri"];
        break;

      default:
        break;
    }
  }

  for(;;) {
    self waittill("damage", var_05, var_06, var_07, var_08, var_07, var_07, var_07, var_09, var_07, var_0A);
    if((isDefined(var_06) && isplayer(var_06)) || isDefined(var_06) && isDefined(level.var_A351) && var_06 == level.var_A351) {
      func_D973(var_09, var_05, var_08);
    }
  }
}

func_D973(param_00, param_01, param_02) {
  if(isDefined(level.var_5D81) && isDefined(level.var_5D81.var_24C0)) {
    level.var_5D81.var_24C0 = level.var_5D81.var_24C0 - 0.15;
  }

  if(isDefined(param_00) && !isDefined(self.var_65CD[param_00])) {
    return;
  }

  if(!isDefined(param_00) && !isDefined(param_01)) {
    return;
  }

  thread scripts\sp\damagefeedback::monitordamage();
  if(isDefined(param_02)) {
    playFX(level.var_7649["engine_damage_feedback"], param_02);
  }

  self.var_65CD[param_00].health = self.var_65CD[param_00].health - param_01;
  if(getdvarint("debug_engine_dmg")) {}

  if(self.var_65CD[param_00].health < 1) {
    if(getdvarint("debug_engine_dmg")) {}

    func_A5DA(param_00);
    return;
  }

  if(self.var_65CD[param_00].health <= self.var_65CD[param_00].maxhealth * 0.75 && !isDefined(self.var_65CD[param_00].var_9DA7)) {
    if(getdvarint("debug_engine_dmg")) {}

    self.var_65CD[param_00].var_9DA7 = 1;
    playFXOnTag(level.var_7649["enemy_dropship_engine_damaged"], self, param_00);
    if(isDefined(self.var_65CD[param_00].var_11867)) {
      lib_0BBE::func_A61E(self.var_65CD[param_00].var_11867);
      return;
    }

    return;
  }

  if(self.var_65CD[param_00].health <= self.var_65CD[param_00].maxhealth * 0.25 && !scripts\sp\utility::func_65DB("thruster_near_death")) {
    scripts\sp\utility::func_65E1("thruster_near_death");
    return;
  }
}

func_A5DA(param_00) {
  if(self.var_65CD[param_00].var_9BB8) {
    return;
  }

  self.var_65CD[param_00].var_9BB8 = 1;
  if(isDefined(self.var_65CD[param_00].var_2C40) && isDefined(self.var_65CD[param_00].var_2C41)) {
    self.var_65CD[param_00].var_9BB8 = 1;
    var_01 = spawn("script_model", self gettagorigin(self.var_65CD[param_00].var_2C41));
    var_01 linkto(self, self.var_65CD[param_00].var_2C41, (0, 0, 0), (0, 0, 0));
    var_01 setModel(self.var_65CD[param_00].var_2C40);
    thread scripts\engine\utility::delete_on_death(var_01);
  }

  playFXOnTag(level.var_7649["enemy_dropship_engine_death"], self, param_00);
  if(isDefined(self.var_65CD[param_00].var_5290)) {
    playworldsound(self.var_65CD[param_00].var_5290, self gettagorigin(param_00));
  }

  if(!isDefined(self.var_65CD[param_00].var_4E40)) {
    return;
  }

  var_02 = 0;
  if(isDefined(self.var_B73F)) {
    var_03 = 0;
    foreach(var_05 in self.var_65CD) {
      if(var_05.var_9BB8) {
        var_03++;
      }
    }

    if(var_03 >= self.var_B73F) {
      var_02 = 1;
    } else {
      thread func_101AF();
    }
  } else {
    var_02 = 1;
  }

  if(var_02) {
    self thread[[self.var_65CD[param_00].var_4E40]]();
  }
}

func_CD70(param_00, param_01, param_02) {
  self notify("custom_death_begin");
  self.var_1FEB = scripts\engine\utility::spawn_tag_origin();
  self linkto(self.var_1FEB);
  var_03 = undefined;
  if(isstring(param_01)) {
    var_03 = getanimlength(level.var_EC85[self.var_1FBB][param_01]);
    self.var_1FEB thread scripts\sp\anim::func_1F35(self, param_01);
  } else {
    var_03 = getanimlength(param_01);
    self animscripted("single anim", self.origin, self.angles, param_01);
  }

  if(!isDefined(param_02)) {
    param_02 = var_03;
  }

  if(getdvarint("debug_engine_dmg")) {
    thread scripts\sp\utility::func_5B51(param_00.origin, self, 1, 0, 0, var_03);
  }

  self.var_1FEB moveto(param_00.origin, param_02);
  self.var_1FEB rotateto(param_00.angles, param_02);
  wait(var_03);
  self.var_1FEB delete();
  self notify("custom_death_end");
}

func_101AF() {
  if(isDefined(self.var_9BC0)) {
    return;
  }

  self.var_9BC0 = 1;
  var_00 = 200;
  var_01 = self.angles;
  var_01 = (0, var_01[1], 0);
  var_02 = anglestoright(var_01);
  var_03 = var_02 * var_00;
  var_04 = self.origin + var_03;
  var_05 = undefined;
  if(!isDefined(self.var_A8AC)) {
    if(randomint(100) < 50) {
      self.var_A8AC = "left";
    } else {
      self.var_A8AC = "right";
    }
  }

  if(bullettracepassed(self.origin, var_04, 0, self) && self.var_A8AC == "left") {
    self.var_A8AC = "right";
    var_05 = var_04;
  } else {
    var_03 = var_03 * -1;
    var_04 = self.origin + var_03;
    if(bullettracepassed(self.origin, var_04, 0, self)) {
      self.var_A8AC = "left";
      var_05 = var_04;
    }
  }

  if(!isDefined(var_05)) {
    self.var_9BC0 = undefined;
    return;
  }

  var_06 = self.origin;
  self setvehgoalpos(var_05 + (0, 0, 100));
  self vehicle_setspeed(60, 50, 10);
  wait(3);
  self setvehgoalpos(var_06, 1);
  self vehicle_setspeed(50, 25, 25);
  self.var_9BC0 = undefined;
}