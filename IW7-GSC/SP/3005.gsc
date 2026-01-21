/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3005.gsc
*********************************************/

main(var_0, var_1, var_2) {
  scripts\sp\vehicle_build::func_31C5("dropship", var_0, var_1, var_2);
  scripts\sp\vehicle_build::func_31A6(::init_location);
  scripts\sp\vehicle_build::func_31A3(3000, 2800, 3100);
  scripts\sp\vehicle_build::func_31C4("axis");
  if(issubstr(var_2, "_space")) {
    scripts\sp\vehicle_build::build_ace(::func_F8A2, ::func_F5FC);
  } else {
    scripts\sp\vehicle_build::build_ace(::func_F8A1, ::func_F5FC);
  }

  scripts\sp\vehicle_build::func_31CC(::func_12BBD);
  scripts\sp\vehicle_build::func_3184("vfx\iw7\core\vehicle\dropship\vfx_dropship_death_01.vfx", undefined, "dropship_helicopter_crash", undefined, undefined, undefined, -1, undefined, "stop_crash_loop_sound", 10, 5);
  scripts\sp\vehicle_build::func_31B7("vfx\iw7\core\vehicle\dropship\vfx_dropship_death_01.vfx", "tag_body", "dropship_helicopter_crash", undefined, undefined, undefined, undefined, 1, undefined, 0);
  var_3 = "vfx\code\tread\heli_dust_default.vfx";
  scripts\sp\vehicle_build::func_31C6(var_2, "default", var_3, 0);
  scripts\sp\vehicle_build::func_31B8("light_1s", 0.12, 0.15, 3000, 0.05, 0.05);
  if(issubstr(var_2, "plane")) {
    scripts\sp\vehicle_build::func_319F();
  } else {
    scripts\sp\vehicle_build::func_31A0();
  }

  if(!issubstr(var_2, "cheap")) {
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

  lib_0BBE::func_774E(var_2);
  level.var_7649["engine_damage_feedback"] = loadfx("vfx\iw7\levels\pearl_harbor\dropship_down\vfx_ph_dropship_shoot_engine_impact_amped.vfx");
  level.var_7649["enemy_dropship_engine_death"] = loadfx("vfx\iw7\levels\pearl_harbor\dropship_down\vfx_ph_dropship_shoot_engine_explode.vfx");
  level.var_7649["enemy_dropship_engine_damaged"] = loadfx("vfx\iw7\levels\pearl_harbor\dropship_down\vfx_ph_dropship_shoot_engine_flaming.vfx");
}

init_location() {
  self.var_12BBF = 150;
  self.var_12BC1 = 450 + self.var_12BBF;
  self.var_5F80 = 1;
  if(issubstr(self.classname, "cheap")) {
    var_0 = ["tag_front_thruster_1_le", "tag_front_thruster_2_le", "tag_front_thruster_1_ri", "tag_front_thruster_2_ri"];
    var_1 = ["tag_back_thruster_1_le", "tag_back_thruster_2_le", "tag_back_thruster_1_ri", "tag_back_thruster_2_ri"];
    var_2 = ["tag_back_thruster_3_le", "tag_back_thruster_4_le", "tag_back_thruster_3_ri", "tag_back_thruster_4_ri"];
    var_3 = scripts\engine\utility::array_combine(var_0, var_1);
    var_3 = scripts\engine\utility::array_combine(var_3, var_2);
    thread lib_0BBE::func_774B(var_3);
    return;
  }

  var_0 = ["tag_front_thruster_1_le", "tag_front_thruster_2_le", "tag_front_thruster_1_ri", "tag_front_thruster_2_ri"];
  lib_0BBE::func_FA5F("side_front", var_3);
  var_1 = ["tag_back_thruster_1_le", "tag_back_thruster_2_le", "tag_back_thruster_1_ri", "tag_back_thruster_2_ri"];
  lib_0BBE::func_FA5F("side_back", var_3);
  var_2 = ["tag_back_thruster_3_le", "tag_back_thruster_4_le", "tag_back_thruster_3_ri", "tag_back_thruster_4_ri"];
  lib_0BBE::func_FA5F("back", var_3, 10);
  thread lib_0BBE::func_774D();
  var_4 = self.script_team;
  if(var_4 == "axis") {
    thread lib_0BBE::func_774C();
  }

  thread lib_0BBE::func_5EC8(%vh_dropship_sdf_thrusters_up, %vh_dropship_sdf_thrusters_down);
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
  foreach(var_1 in self.mgturret) {
    if(!isDefined(var_1.var_DE46)) {
      continue;
    }

    var_2 = undefined;
    switch (var_1.var_DE46) {
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
    var_3 linkto(self, var_2, (0, 0, 0), (0, 0, 0));
    var_3 setModel("veh_mil_air_ca_dropship_mount");
  }
}

func_5DB9(var_0) {
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

  self give_attacker_kill_rewards(var_1);
}

func_5DB7(var_0) {
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
  self give_attacker_kill_rewards(var_2);
}

func_F8A1() {
  var_0 = [];
  for(var_1 = 0; var_1 < 17; var_1++) {
    var_0[var_1] = spawnStruct();
    var_0[var_1].var_10220 = "tag_detach";
    var_0[var_1].botgetscriptgoalyaw = "stand";
    var_0[var_1].var_DC19 = 1;
  }

  var_0[0].var_92CC = % vh_org_dropship_sdf_idle_pilot;
  var_0[1].var_92CC = % vh_org_dropship_sdf_idle_copilot;
  var_0[2].var_92CC = % vh_org_dropship_sdf_unload_guy1_idle;
  var_0[3].var_92CC = % vh_org_dropship_sdf_unload_guy2_idle;
  var_0[4].var_92CC = % vh_org_dropship_sdf_unload_guy3_idle;
  var_0[5].var_92CC = % vh_org_dropship_sdf_unload_guy4_idle;
  var_0[6].var_92CC = % vh_org_dropship_sdf_unload_guy5_idle;
  var_0[7].var_92CC = % vh_org_dropship_sdf_unload_guy6_idle;
  var_0[8].var_92CC = % vh_org_dropship_sdf_unload_guy7_idle;
  var_0[9].var_92CC = % vh_org_dropship_sdf_unload_guy8_idle;
  var_0[10].var_92CC = % vh_org_dropship_sdf_unload_guy9_idle;
  var_0[11].var_92CC = % vh_org_dropship_sdf_unload_guy10_idle;
  var_0[12].var_92CC = % vh_org_dropship_sdf_unload_guy11_idle;
  var_0[13].var_92CC = % vh_org_dropship_sdf_unload_guy12_idle;
  var_0[2].botclearscriptgoal = % vh_org_dropship_sdf_unload_jump_guy1;
  var_0[3].botclearscriptgoal = % vh_org_dropship_sdf_unload_jump_guy2;
  var_0[4].botclearscriptgoal = % vh_org_dropship_sdf_unload_jump_guy3;
  var_0[5].botclearscriptgoal = % vh_org_dropship_sdf_unload_jump_guy4;
  var_0[6].botclearscriptgoal = % vh_org_dropship_sdf_unload_jump_guy5;
  var_0[7].botclearscriptgoal = % vh_org_dropship_sdf_unload_jump_guy6;
  var_0[8].botclearscriptgoal = % vh_org_dropship_sdf_unload_jump_guy7;
  var_0[9].botclearscriptgoal = % vh_org_dropship_sdf_unload_jump_guy8;
  var_0[2].botgetdifficultysetting = % vh_org_dropship_sdf_unload_jump_loop_guy1;
  var_0[3].botgetdifficultysetting = % vh_org_dropship_sdf_unload_jump_loop_guy2;
  var_0[4].botgetdifficultysetting = % vh_org_dropship_sdf_unload_jump_loop_guy3;
  var_0[5].botgetdifficultysetting = % vh_org_dropship_sdf_unload_jump_loop_guy4;
  var_0[6].botgetdifficultysetting = % vh_org_dropship_sdf_unload_jump_loop_guy5;
  var_0[7].botgetdifficultysetting = % vh_org_dropship_sdf_unload_jump_loop_guy6;
  var_0[8].botgetdifficultysetting = % vh_org_dropship_sdf_unload_jump_loop_guy7;
  var_0[9].botgetdifficultysetting = % vh_org_dropship_sdf_unload_jump_loop_guy8;
  var_0[2].botgetdifficulty = % vh_org_dropship_sdf_unload_land_guy1;
  var_0[3].botgetdifficulty = % vh_org_dropship_sdf_unload_land_guy2;
  var_0[4].botgetdifficulty = % vh_org_dropship_sdf_unload_land_guy3;
  var_0[5].botgetdifficulty = % vh_org_dropship_sdf_unload_land_guy4;
  var_0[6].botgetdifficulty = % vh_org_dropship_sdf_unload_land_guy5;
  var_0[7].botgetdifficulty = % vh_org_dropship_sdf_unload_land_guy6;
  var_0[8].botgetdifficulty = % vh_org_dropship_sdf_unload_land_guy7;
  var_0[9].botgetdifficulty = % vh_org_dropship_sdf_unload_land_guy8;
  var_0[14].mgturret = 1;
  var_0[15].mgturret = 2;
  var_0[16].mgturret = 3;
  return var_0;
}

func_F8A2() {
  var_0 = [];
  for(var_1 = 0; var_1 < 15; var_1++) {
    var_0[var_1] = spawnStruct();
    var_0[var_1].var_10220 = "tag_detach";
    var_0[var_1].botgetscriptgoalyaw = "stand";
    var_0[var_1].var_DC19 = 1;
  }

  var_0[0].var_92CC = % vh_org_dropship_sdf_idle_pilot;
  var_0[1].var_92CC = % vh_org_dropship_sdf_idle_copilot;
  var_0[2].var_92CC = % vh_zg_org_dropship_sdf_unload_guy1_idle;
  var_0[3].var_92CC = % vh_zg_org_dropship_sdf_unload_guy2_idle;
  var_0[4].var_92CC = % vh_zg_org_dropship_sdf_unload_guy3_idle;
  var_0[5].var_92CC = % vh_zg_org_dropship_sdf_unload_guy4_idle;
  var_0[6].var_92CC = % vh_zg_org_dropship_sdf_unload_guy5_idle;
  var_0[7].var_92CC = % vh_zg_org_dropship_sdf_unload_guy6_idle;
  var_0[8].var_92CC = % vh_zg_org_dropship_sdf_unload_guy7_idle;
  var_0[9].var_92CC = % vh_zg_org_dropship_sdf_unload_guy8_idle;
  var_0[10].var_92CC = % vh_zg_org_dropship_sdf_unload_guy9_idle;
  var_0[11].var_92CC = % vh_zg_org_dropship_sdf_unload_guy10_idle;
  var_0[12].var_92CC = % vh_zg_org_dropship_sdf_unload_guy11_idle;
  var_0[13].var_92CC = % vh_zg_org_dropship_sdf_unload_guy12_idle;
  var_0[2].botclearscriptgoal = % vh_zg_org_dropship_sdf_unload_guy1;
  var_0[3].botclearscriptgoal = % vh_zg_org_dropship_sdf_unload_guy2;
  var_0[4].botclearscriptgoal = % vh_zg_org_dropship_sdf_unload_guy3;
  var_0[5].botclearscriptgoal = % vh_zg_org_dropship_sdf_unload_guy4;
  var_0[6].botclearscriptgoal = % vh_zg_org_dropship_sdf_unload_guy5;
  var_0[7].botclearscriptgoal = % vh_zg_org_dropship_sdf_unload_guy6;
  var_0[8].botclearscriptgoal = % vh_zg_org_dropship_sdf_unload_guy7;
  var_0[9].botclearscriptgoal = % vh_zg_org_dropship_sdf_unload_guy8;
  var_0[10].botclearscriptgoal = % vh_zg_org_dropship_sdf_unload_guy9;
  var_0[11].botclearscriptgoal = % vh_zg_org_dropship_sdf_unload_guy10;
  var_0[12].botclearscriptgoal = % vh_zg_org_dropship_sdf_unload_guy11;
  var_0[13].botclearscriptgoal = % vh_zg_org_dropship_sdf_unload_guy12;
  return var_0;
}

func_F5FC(var_0) {
  var_0[2].var_131E6 = % vh_ca_dropship_side_door_l_open;
  var_0[2].var_131E7 = 0;
  var_0[6].var_131E6 = % vh_ca_dropship_side_door_r_open;
  var_0[6].var_131E7 = 0;
  var_0[10].var_131E6 = % vh_dropship_sdf_rear_doors_open;
  var_0[10].var_131E7 = 0;
  return var_0;
}

func_12BBD() {
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

func_5DCE(var_0) {
  self endon("death");
  self endon("stop_engine_damage_manager");
  scripts\sp\utility::func_65E0("thruster_near_death");
  scripts\sp\vehicle::playgestureviewmodel();
  var_1 = ["j_wing_front_le", "j_wing_mid_le", "j_wing_front_ri", "j_wing_mid_ri"];
  self.var_65CD = [];
  foreach(var_3 in var_1) {
    self.var_65CD[var_3] = spawnStruct();
    self.var_65CD[var_3].maxhealth = 1500;
    self.var_65CD[var_3].health = self.var_65CD[var_3].maxhealth;
    self.var_65CD[var_3].var_9BB8 = 0;
    self.var_65CD[var_3].var_5762 = level.var_7649["enemy_dropship_engine_damaged"];
    self.var_65CD[var_3].var_4E26 = level.var_7649["enemy_dropship_engine_death"];
    self.var_65CD[var_3].var_5290 = "frag_grenade_explode";
    if(isDefined(var_0)) {
      self.var_65CD[var_3].var_4E40 = var_0;
    }

    switch (var_3) {
      case "j_wing_mid_ri":
        self.var_65CD[var_3].var_2C40 = "veh_mil_air_ca_dropship_dst_rr";
        self.var_65CD[var_3].var_2C41 = "j_wing_mid_RI";
        self.var_65CD[var_3].var_11867 = ["tag_back_thruster_1_ri", "tag_back_thruster_2_ri"];
        break;

      case "j_wing_front_ri":
        self.var_65CD[var_3].var_2C40 = "veh_mil_air_ca_dropship_dst_fr";
        self.var_65CD[var_3].var_2C41 = "j_wing_front_RI";
        self.var_65CD[var_3].var_11867 = ["tag_front_thruster_1_ri", "tag_front_thruster_2_ri"];
        break;

      default:
        break;
    }
  }

  for(;;) {
    self waittill("damage", var_5, var_6, var_7, var_8, var_7, var_7, var_7, var_9, var_7, var_10);
    if((isDefined(var_6) && isplayer(var_6)) || isDefined(var_6) && isDefined(level.var_A351) && var_6 == level.var_A351) {
      func_D973(var_9, var_5, var_8);
    }
  }
}

func_D973(var_0, var_1, var_2) {
  if(isDefined(level.var_5D81) && isDefined(level.var_5D81.var_24C0)) {
    level.var_5D81.var_24C0 = level.var_5D81.var_24C0 - 0.15;
  }

  if(isDefined(var_0) && !isDefined(self.var_65CD[var_0])) {
    return;
  }

  if(!isDefined(var_0) && !isDefined(var_1)) {
    return;
  }

  thread scripts\sp\damagefeedback::monitordamage();
  if(isDefined(var_2)) {
    playFX(level.var_7649["engine_damage_feedback"], var_2);
  }

  self.var_65CD[var_0].health = self.var_65CD[var_0].health - var_1;
  if(getdvarint("debug_engine_dmg")) {}

  if(self.var_65CD[var_0].health < 1) {
    if(getdvarint("debug_engine_dmg")) {}

    func_A5DA(var_0);
    return;
  }

  if(self.var_65CD[var_0].health <= self.var_65CD[var_0].maxhealth * 0.75 && !isDefined(self.var_65CD[var_0].var_9DA7)) {
    if(getdvarint("debug_engine_dmg")) {}

    self.var_65CD[var_0].var_9DA7 = 1;
    playFXOnTag(level.var_7649["enemy_dropship_engine_damaged"], self, var_0);
    if(isDefined(self.var_65CD[var_0].var_11867)) {
      lib_0BBE::func_A61E(self.var_65CD[var_0].var_11867);
      return;
    }

    return;
  }

  if(self.var_65CD[var_0].health <= self.var_65CD[var_0].maxhealth * 0.25 && !scripts\sp\utility::func_65DB("thruster_near_death")) {
    scripts\sp\utility::func_65E1("thruster_near_death");
    return;
  }
}

func_A5DA(var_0) {
  if(self.var_65CD[var_0].var_9BB8) {
    return;
  }

  self.var_65CD[var_0].var_9BB8 = 1;
  if(isDefined(self.var_65CD[var_0].var_2C40) && isDefined(self.var_65CD[var_0].var_2C41)) {
    self.var_65CD[var_0].var_9BB8 = 1;
    var_1 = spawn("script_model", self gettagorigin(self.var_65CD[var_0].var_2C41));
    var_1 linkto(self, self.var_65CD[var_0].var_2C41, (0, 0, 0), (0, 0, 0));
    var_1 setModel(self.var_65CD[var_0].var_2C40);
    thread scripts\engine\utility::delete_on_death(var_1);
  }

  playFXOnTag(level.var_7649["enemy_dropship_engine_death"], self, var_0);
  if(isDefined(self.var_65CD[var_0].var_5290)) {
    playworldsound(self.var_65CD[var_0].var_5290, self gettagorigin(var_0));
  }

  if(!isDefined(self.var_65CD[var_0].var_4E40)) {
    return;
  }

  var_2 = 0;
  if(isDefined(self.var_B73F)) {
    var_3 = 0;
    foreach(var_5 in self.var_65CD) {
      if(var_5.var_9BB8) {
        var_3++;
      }
    }

    if(var_3 >= self.var_B73F) {
      var_2 = 1;
    } else {
      thread func_101AF();
    }
  } else {
    var_2 = 1;
  }

  if(var_2) {
    self thread[[self.var_65CD[var_0].var_4E40]]();
  }
}

func_CD70(var_0, var_1, var_2) {
  self notify("custom_death_begin");
  self.var_1FEB = scripts\engine\utility::spawn_tag_origin();
  self linkto(self.var_1FEB);
  var_3 = undefined;
  if(isstring(var_1)) {
    var_3 = getanimlength(level.var_EC85[self.var_1FBB][var_1]);
    self.var_1FEB thread scripts\sp\anim::func_1F35(self, var_1);
  } else {
    var_3 = getanimlength(var_1);
    self animscripted("single anim", self.origin, self.angles, var_1);
  }

  if(!isDefined(var_2)) {
    var_2 = var_3;
  }

  if(getdvarint("debug_engine_dmg")) {
    thread scripts\sp\utility::func_5B51(var_0.origin, self, 1, 0, 0, var_3);
  }

  self.var_1FEB moveto(var_0.origin, var_2);
  self.var_1FEB rotateto(var_0.angles, var_2);
  wait(var_3);
  self.var_1FEB delete();
  self notify("custom_death_end");
}

func_101AF() {
  if(isDefined(self.var_9BC0)) {
    return;
  }

  self.var_9BC0 = 1;
  var_0 = 200;
  var_1 = self.angles;
  var_1 = (0, var_1[1], 0);
  var_2 = anglestoright(var_1);
  var_3 = var_2 * var_0;
  var_4 = self.origin + var_3;
  var_5 = undefined;
  if(!isDefined(self.var_A8AC)) {
    if(randomint(100) < 50) {
      self.var_A8AC = "left";
    } else {
      self.var_A8AC = "right";
    }
  }

  if(bullettracepassed(self.origin, var_4, 0, self) && self.var_A8AC == "left") {
    self.var_A8AC = "right";
    var_5 = var_4;
  } else {
    var_3 = var_3 * -1;
    var_4 = self.origin + var_3;
    if(bullettracepassed(self.origin, var_4, 0, self)) {
      self.var_A8AC = "left";
      var_5 = var_4;
    }
  }

  if(!isDefined(var_5)) {
    self.var_9BC0 = undefined;
    return;
  }

  var_6 = self.origin;
  self setvehgoalpos(var_5 + (0, 0, 100));
  self vehicle_setspeed(60, 50, 10);
  wait(3);
  self setvehgoalpos(var_6, 1);
  self vehicle_setspeed(50, 25, 25);
  self.var_9BC0 = undefined;
}