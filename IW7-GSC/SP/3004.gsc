/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3004.gsc
************************/

main(param_00, param_01, param_02) {
  scripts\sp\vehicle_build::func_31C5("dropship", param_00, param_01, param_02);
  scripts\sp\vehicle_build::func_31A6(::init_location);
  scripts\sp\vehicle_build::func_3186(param_00, param_00);
  lib_0BBE::func_774E(param_02);
  var_03 = "vfx\code\tread\heli_dust_default.vfx";
  if(!isDefined(level.plant_anims) || level.plant_anims == "earth") {
    var_03 = "vfx\code\tread\heli_dust_default.vfx";
  } else if(level.plant_anims == "titan") {
    var_03 = "vfx\iw7\core\tread\tread_airship_small_titan.vfx";
  }

  scripts\sp\vehicle_build::func_31C6(param_02, "default", var_03, 0);
  scripts\sp\vehicle_build::func_3184("vfx\iw7\core\vehicle\jackal\vfx_jackal_dying_01.vfx", "j_frontlandinggear", "dropship_helicopter_dying_loop", undefined, undefined, 1, undefined, undefined, undefined, 10, 5);
  scripts\sp\vehicle_build::func_3184("vfx\iw7\core\vehicle\dropship\vfx_dropship_hit_damage.vfx", "tag_back_thruster_1_ri", "dropship_helicopter_hit", undefined, undefined, undefined, undefined, undefined, undefined, 10, 5);
  scripts\sp\vehicle_build::func_3184("vfx\iw7\core\vehicle\dropship\vfx_dropship_hit_damage.vfx", "tag_frontsidethrsuter_ri", "dropship_helicopter_secondary_exp", undefined, undefined, undefined, 0.45, undefined, undefined, 10, 5);
  scripts\sp\vehicle_build::func_3184("vfx\iw7\core\vehicle\dropship\vfx_dropship_hit_damage.vfx", "j_frontlandinggear", "dropship_helicopter_secondary_exp", undefined, undefined, undefined, 1.5, undefined, undefined, 10, 5);
  scripts\sp\vehicle_build::func_3184("vfx\iw7\core\vehicle\dropship\vfx_dropship_hit_damage.vfx", "tag_back_thruster_1_le", "dropship_helicopter_secondary_exp", undefined, undefined, undefined, 3, undefined, undefined, 10, 5);
  scripts\sp\vehicle_build::func_3184("vfx\iw7\core\vehicle\dropship\vfx_dropship_hit_damage.vfx", "tag_frontsidethruster_le", "dropship_helicopter_secondary_exp", undefined, undefined, undefined, 5, undefined, undefined, 10, 5);
  scripts\sp\vehicle_build::func_3184("vfx\iw7\core\vehicle\dropship\vfx_dropship_death_01.vfx", undefined, "dropship_helicopter_crash", undefined, undefined, undefined, -1, undefined, "stop_crash_loop_sound", 10, 5);
  scripts\sp\vehicle_build::func_31B7("vfx\iw7\core\vehicle\dropship\vfx_dropship_death_01.vfx", "tag_body", "dropship_helicopter_crash", undefined, undefined, undefined, undefined, 1, undefined, 0);
  scripts\sp\vehicle_build::func_31A3(3000, 2800, 3100);
  scripts\sp\vehicle_build::func_31C4("allies");
  scripts\sp\vehicle_build::func_31A2(::func_F77B);
  scripts\sp\vehicle_build::build_ace(::func_F8A1, ::func_F5FC);
  scripts\sp\vehicle_build::func_31CC(::func_12BBD);
  if(issubstr(param_02, "plane")) {
    scripts\sp\vehicle_build::func_319F();
  } else {
    scripts\sp\vehicle_build::func_31A0();
  }

  if(!issubstr(param_02, "cheap")) {
    if(issubstr(param_02, "player")) {
      precachemodel("veh_mil_air_un_dropship_hero_interior");
      precachemodel("veh_mil_air_un_dropship_hero_interior_rig");
      precachemodel("veh_mil_air_un_dropship_hero_interior_light");
      precachemodel("veh_mil_air_un_dropship_hero_interior_cockpit_dash");
      precachemodel("veh_mil_air_un_dropship_hero_interior_pilot_seat");
      precachemodel("veh_mil_air_un_dropship_hero_interior_screens");
      precachemodel("veh_mil_air_un_dropship_hero_interior_props_rear");
      precachemodel("veh_mil_air_un_dropship_hero_interior_props_cockpit");
      precachemodel("veh_mil_air_un_dropship_hero_interior_metal_beams_rear");
      precachemodel("veh_mil_air_un_dropship_hero_interior_seat_bays_le");
      precachemodel("veh_mil_air_un_dropship_hero_interior_seat_bays_ri");
      precachemodel("veh_mil_air_un_dropship_hero_interior_carabiner_handle");
      return;
    }

    precachemodel("veh_mil_air_un_dropship_periph_interior");
  }
}

init_location() {
  if(issubstr(self.classname, "cheap")) {
    return;
  }

  scripts\sp\utility::func_65E0("side_thrusters_out");
  self.var_12BBF = 150;
  self.var_12BC1 = 450 + self.var_12BBF;
  self.var_5F80 = 1;
  self.var_7724 = % vh_dropship_landing_gear_up;
  self.var_7723 = % vh_dropship_landing_gear_down;
  if(isDefined(level.plant_anims) && level.plant_anims == "titan") {
    self.var_126F4 = 1;
  }

  var_00 = ["tag_frontsidethrsuter_ri", "tag_frontsidethruster_le"];
  lib_0BBE::func_FA5F("side_front", var_00, undefined, undefined, undefined, undefined, "side_thrusters_out");
  var_01 = ["tag_back_thruster_upper_ri", "tag_back_thruster_upper_le", "tag_back_thruster_lower_ri", "tag_back_thruster_lower_le"];
  lib_0BBE::func_FA5F("side_back", var_01);
  var_02 = ["tag_mid_thruster_1_ri", "tag_mid_thruster_3_ri", "tag_mid_thruster_1_le", "tag_mid_thruster_3_le", "tag_back_thruster_1_ri", "tag_back_thruster_2_ri", "tag_back_thruster_1_le", "tag_back_thruster_2_le"];
  lib_0BBE::func_FA5F("back", var_02, 10);
  thread lib_0BBE::func_774D();
  var_03 = self.script_team;
  if(var_03 == "axis") {
    thread lib_0BBE::func_774C();
  }

  self.var_101B2 = 0;
  thread lib_0BBE::func_5EC8( % vh_dropship_thrusters_up, % vh_dropship_thrusters_down, ::func_12B58);
  self.var_4D94 = spawnStruct();
  if(issubstr(self.classname, "player")) {
    self attach("veh_mil_air_un_dropship_hero_interior_rig", "tag_connect");
    self.var_4D94.var_EF3C = [];
    self.var_4D94.var_EF3C["cabin_lights"] = [];
    var_04 = ["tag_light_le_01", "tag_light_le_02", "tag_light_le_03", "tag_light_le_04", "tag_light_le_05", "tag_light_ri_01", "tag_light_ri_02", "tag_light_ri_03", "tag_light_ri_04", "tag_light_ri_05"];
    foreach(var_06 in var_04) {
      var_07 = scripts\sp\anim::func_1EE5("veh_mil_air_un_dropship_hero_interior_light", var_06);
      var_07.var_336 = "dropship_cabin_lights_" + self.var_6A0B;
      self.var_4D94.var_EF3C["cabin_lights"][self.var_4D94.var_EF3C["cabin_lights"].size] = var_07;
    }

    self.var_4D94.var_9A62 = [];
    self.var_4D94.var_9A62[self.var_4D94.var_9A62.size] = ::scripts\sp\anim::func_1EE5("veh_mil_air_un_dropship_hero_interior", "tag_connect");
    self.var_4D94.var_9A62[self.var_4D94.var_9A62.size] = ::scripts\sp\anim::func_1EE5("veh_mil_air_un_dropship_hero_interior_cockpit_dash", "TAG_COCKPIT_DASH");
    self.var_4D94.var_9A62[self.var_4D94.var_9A62.size] = ::scripts\sp\anim::func_1EE5("veh_mil_air_un_dropship_hero_interior_pilot_seat", "TAG_PILOT_SEAT_LE");
    self.var_4D94.var_9A62[self.var_4D94.var_9A62.size] = ::scripts\sp\anim::func_1EE5("veh_mil_air_un_dropship_hero_interior_pilot_seat", "TAG_PILOT_SEAT_RI");
    self.var_4D94.var_9A62[self.var_4D94.var_9A62.size] = ::scripts\sp\anim::func_1EE5("veh_mil_air_un_dropship_hero_interior_screens", "TAG_COCKPIT_SCREENS");
    self.var_4D94.var_9A62[self.var_4D94.var_9A62.size] = ::scripts\sp\anim::func_1EE5("veh_mil_air_un_dropship_hero_interior_props_rear", "TAG_PROPS_REAR");
    self.var_4D94.var_9A62[self.var_4D94.var_9A62.size] = ::scripts\sp\anim::func_1EE5("veh_mil_air_un_dropship_hero_interior_props_cockpit", "TAG_PROPS_COCKPIT");
    self.var_4D94.var_9A62[self.var_4D94.var_9A62.size] = ::scripts\sp\anim::func_1EE5("veh_mil_air_un_dropship_hero_interior_metal_beams_rear", "TAG_METAL_BEAMS_REAR");
    self.var_4D94.var_9A62[self.var_4D94.var_9A62.size] = ::scripts\sp\anim::func_1EE5("veh_mil_air_un_dropship_hero_interior_seat_bays_le", "TAG_SEAT_BAYS_LE");
    self.var_4D94.var_9A62[self.var_4D94.var_9A62.size] = ::scripts\sp\anim::func_1EE5("veh_mil_air_un_dropship_hero_interior_seat_bays_ri", "TAG_SEAT_BAYS_RI");
    self.var_4D94.parts = [];
    self.var_4D94.parts["straps"] = [];
    foreach(var_06 in ["TAG_CARABINER_HANDLE_LE_1", "TAG_CARABINER_HANDLE_LE_2", "TAG_CARABINER_HANDLE_RI_1", "TAG_CARABINER_HANDLE_RI_2"]) {
      var_0A = self gettagorigin(var_06);
      var_0B = spawn("script_model", var_0A);
      var_0B setModel("veh_mil_air_un_dropship_hero_interior_carabiner_handle");
      var_0B.var_1FBD = var_0B scripts\engine\utility::spawn_tag_origin();
      var_0B.physics_setgravitydynentscalar = var_06;
      self.var_4D94.parts["straps"][self.var_4D94.parts["straps"].size] = var_0B;
      var_0B.var_1FBD linkto(self, var_06, (0, 0, 0), (0, 0, 0));
      var_0B linkto(var_0B.var_1FBD, "tag_origin", (0, 0, 0), (0, 0, 0));
    }
  } else {
    self attach("veh_mil_air_un_dropship_periph_interior");
  }

  scripts\sp\utility::func_65E0("left_door_open");
  scripts\sp\utility::func_65E0("right_door_open");
  scripts\sp\utility::func_65E0("back_door_open");
  scripts\sp\utility::func_65E0("left_door_animating");
  scripts\sp\utility::func_65E0("right_door_animating");
  scripts\sp\utility::func_65E0("back_door_animating");
  self.var_4D94.var_5A13 = spawnStruct();
  self.var_4D94.var_5A13.physics_setgravitydynentscalar = "TAG_DOOR_LEFT";
  self.var_4D94.var_5A13.var_4284 = 1;
  self.var_4D94.doors["left"] = self.var_4D94.var_5A13;
  self.var_4D94.var_5A27 = spawnStruct();
  self.var_4D94.var_5A27.physics_setgravitydynentscalar = "TAG_DOOR_RIGHT";
  self.var_4D94.var_5A27.var_4284 = 1;
  self.var_4D94.doors["right"] = self.var_4D94.var_5A27;
  self.var_4D94.var_5A01 = spawnStruct();
  self.var_4D94.var_5A01.physics_setgravitydynentscalar = "J_LowerBackDoor1";
  self.var_4D94.var_5A01.var_4284 = 1;
  self.var_4D94.doors["back"] = self.var_4D94.var_5A01;
}

func_12B58(param_00) {
  if(self.var_101B2 && param_00 > 50) {
    scripts\sp\utility::func_65DD("side_thrusters_out");
    self give_attacker_kill_rewards( % vh_dropship_front_thrusters_in);
    scripts\engine\utility::delaycall(0.05, ::_meth_82B1, % vh_dropship_front_thrusters_in, 0.25);
    self clearanim( % vh_dropship_front_thrusters_out, 0.05);
    self.var_101B2 = 0;
    return;
  }

  if(param_00 > 50) {
    return;
  }

  if(self.var_101B2) {
    return;
  }

  scripts\engine\utility::delaythread(1.5, ::scripts\sp\utility::func_65E1, "side_thrusters_out");
  self give_attacker_kill_rewards( % vh_dropship_front_thrusters_out);
  scripts\engine\utility::delaycall(0.05, ::_meth_82B1, % vh_dropship_front_thrusters_out, 0.25);
  self clearanim( % vh_dropship_front_thrusters_in, 0.05);
  self.var_101B2 = 1;
}

func_5ECA() {
  self endon("death");
  self endon("entitydeleted");
  thread lib_0BBE::func_5DAE();
  var_00 = 0.3;
  var_01 = 0.3;
  var_02 = 500;
  for(;;) {
    var_03 = (0, 0, -100000);
    var_04 = scripts\sp\utility::func_864C(self.origin);
    var_05 = distance(self.origin, var_04);
    if(var_05 < var_02) {
      if(!isDefined(self.var_5ECA)) {
        self.var_5ECA = spawn("script_origin", var_04);
        wait(0.05);
        self.var_5ECA scripts\sp\utility::func_10461("dropship_lz_debris_lp", var_00, 1, 1);
        wait(1);
      }

      if(isDefined(self.var_5ECA)) {
        var_04 = scripts\sp\utility::func_864C(self.origin);
        var_05 = distance(self.origin, var_04);
        var_01 = var_05 - var_02 / 0 - var_02;
        if(var_01 < var_00) {
          var_01 = var_00;
        }

        self.var_5ECA ghostattack(var_01, 0.1);
        self.var_5ECA moveto(var_04, 0.1);
        wait(0.2);
      }
    } else if(var_05 > var_02) {
      if(isDefined(self.var_5ECA)) {
        self.var_5ECA ghostattack(0, 2);
        wait(2);
        self.var_5ECA delete();
      }
    }

    wait(0.2);
  }
}

func_5DC2() {
  scripts\sp\utility::func_65DD("dynamicThrusters");
  self clearanim( % vh_dropship_thrusters_up, 0.05);
  self clearanim( % vh_dropship_thrusters_down, 0.05);
  self clearanim( % vh_dropship_front_thrusters_out, 0.05);
  self clearanim( % vh_dropship_front_thrusters_in, 0.05);
}

func_E752(param_00) {
  if(param_00 < 0) {
    return 0;
  }

  if(param_00 > 1) {
    return 1;
  }

  return param_00;
}

func_F8A1() {
  var_00 = [];
  for(var_01 = 0; var_01 < 12; var_01++) {
    var_00[var_01] = spawnStruct();
    var_00[var_01].var_10220 = "tag_detach";
    var_00[var_01].botgetscriptgoalyaw = "stand";
  }

  var_00[0].var_92CC = % vh_org_dropship_idle_pilot;
  var_00[1].var_92CC = % vh_org_dropship_idle_copilot;
  var_00[2].var_92CC = % vh_org_dropship_unload_guy1_idle;
  var_00[3].var_92CC = % vh_org_dropship_unload_guy2_idle;
  var_00[4].var_92CC = % vh_org_dropship_unload_guy3_idle;
  var_00[5].var_92CC = % vh_org_dropship_unload_guy4_idle;
  var_00[6].var_92CC = % vh_org_dropship_unload_guy5_idle;
  var_00[7].var_92CC = % vh_org_dropship_unload_guy6_idle;
  var_00[8].var_92CC = % vh_org_dropship_unload_guy7_idle;
  var_00[9].var_92CC = % vh_org_dropship_unload_guy8_idle;
  var_00[2].botclearscriptgoal = % vh_org_dropship_unload_jump_guy1;
  var_00[3].botclearscriptgoal = % vh_org_dropship_unload_jump_guy2;
  var_00[4].botclearscriptgoal = % vh_org_dropship_unload_jump_guy3;
  var_00[5].botclearscriptgoal = % vh_org_dropship_unload_jump_guy4;
  var_00[6].botclearscriptgoal = % vh_org_dropship_unload_jump_guy5;
  var_00[7].botclearscriptgoal = % vh_org_dropship_unload_jump_guy6;
  var_00[8].botclearscriptgoal = % vh_org_dropship_unload_jump_guy7;
  var_00[9].botclearscriptgoal = % vh_org_dropship_unload_jump_guy8;
  var_00[2].botgetdifficultysetting = % vh_org_dropship_unload_jump_loop_guy1;
  var_00[3].botgetdifficultysetting = % vh_org_dropship_unload_jump_loop_guy2;
  var_00[4].botgetdifficultysetting = % vh_org_dropship_unload_jump_loop_guy3;
  var_00[5].botgetdifficultysetting = % vh_org_dropship_unload_jump_loop_guy4;
  var_00[6].botgetdifficultysetting = % vh_org_dropship_unload_jump_loop_guy5;
  var_00[7].botgetdifficultysetting = % vh_org_dropship_unload_jump_loop_guy6;
  var_00[8].botgetdifficultysetting = % vh_org_dropship_unload_jump_loop_guy7;
  var_00[9].botgetdifficultysetting = % vh_org_dropship_unload_jump_loop_guy8;
  var_00[2].botgetdifficulty = % vh_org_dropship_unload_land_guy1;
  var_00[3].botgetdifficulty = % vh_org_dropship_unload_land_guy2;
  var_00[4].botgetdifficulty = % vh_org_dropship_unload_land_guy3;
  var_00[5].botgetdifficulty = % vh_org_dropship_unload_land_guy4;
  var_00[6].botgetdifficulty = % vh_org_dropship_unload_land_guy5;
  var_00[7].botgetdifficulty = % vh_org_dropship_unload_land_guy6;
  var_00[8].botgetdifficulty = % vh_org_dropship_unload_land_guy7;
  var_00[9].botgetdifficulty = % vh_org_dropship_unload_land_guy8;
  var_00[2].botgetentrancepoint = % vh_org_dropship_unload_guy1;
  var_00[3].botgetentrancepoint = % vh_org_dropship_unload_guy2;
  var_00[4].botgetentrancepoint = % vh_org_dropship_unload_guy3;
  var_00[5].botgetentrancepoint = % vh_org_dropship_unload_guy4;
  var_00[6].botgetentrancepoint = % vh_org_dropship_unload_guy5;
  var_00[7].botgetentrancepoint = % vh_org_dropship_unload_guy6;
  var_00[8].botgetentrancepoint = % vh_org_dropship_unload_guy7;
  var_00[9].botgetentrancepoint = % vh_org_dropship_unload_guy8;
  var_00 = func_FB0C(var_00);
  return var_00;
}

func_F5FC(param_00) {
  param_00[2].var_131E6 = % vh_dropship_front_door_left_open;
  param_00[2].var_131E7 = 0;
  param_00[6].var_131E6 = % vh_dropship_front_door_right_open;
  param_00[6].var_131E7 = 0;
  return param_00;
}

func_FB0C(param_00) {
  param_00[10].var_9FEF = 1;
  param_00[10].var_10220 = "tag_origin";
  param_00[10].var_92CC = % jsp_dropship_jumpout_apc_idle;
  param_00[10].botclearscriptgoal = % jsp_dropship_jumpout_apc_unload;
  param_00[11].var_9FEF = 1;
  param_00[11].var_10220 = "tag_detach";
  param_00[11].var_92CC = % jsp_dropship_apc_unload_idle;
  param_00[11].botclearscriptgoal = % jsp_dropship_apc_unload;
  return param_00;
}

func_12BBD() {
  var_00 = [];
  var_01 = "passengers";
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

func_F77B() {
  var_00 = [];
  for(var_01 = 0; var_01 < 1; var_01++) {
    var_00[var_01] = spawnStruct();
  }

  var_00[0].setglaregrimematerial = % vh_dropship_landing_gear_down;
  var_00[0].var_11472 = % vh_dropship_landing_gear_up;
  return var_00;
}

func_C5F1(param_00, param_01, param_02, param_03) {
  self endon("death");
  if(isDefined(param_00)) {
    param_00 = scripts\engine\utility::ter_op(!isarray(param_00), [param_00], param_00);
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  if(!isDefined(param_00) || !isDefined(param_00[0]) || param_00[0] == "all") {
    param_00 = ["left", "right", "back"];
  }

  var_04 = [];
  foreach(var_06 in param_00) {
    var_04 = scripts\engine\utility::array_add(var_04, self.var_4D94.doors[var_06]);
    childthread func_1236(var_06, param_01, param_02, param_03);
  }

  if(!param_02) {
    scripts\sp\utility::func_22D8(var_04, "open");
  }
}

func_1236(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.var_4D94.var_5A13.var_1EF5)) {
    self.var_4D94.var_5A13.var_1EF5 = % vh_dropship_front_door_left_open;
  }

  if(!isDefined(self.var_4D94.var_5A27.var_1EF5)) {
    self.var_4D94.var_5A27.var_1EF5 = % vh_dropship_front_door_right_open;
  }

  if(!isDefined(self.var_4D94.var_5A01.var_1EF5)) {
    self.var_4D94.var_5A01.var_1EF5 = % vh_dropship_rear_doors_open;
  }

  scripts\sp\utility::func_65E8(param_00 + "_door_animating");
  switch (param_00) {
    case "left":
      if(!isDefined(self.var_4D94.var_5A13)) {
        return;
      }

      if(scripts\sp\utility::func_65DB("left_door_open") || scripts\sp\utility::func_65DB("left_door_animating")) {
        return;
      }

      scripts\sp\utility::func_65E1(param_00 + "_door_animating");
      func_1242(self.var_4D94.var_5A13, self.var_4D94.var_5A13.var_1EF5, 0, param_02, param_01);
      if(param_03) {
        self.var_4D94.var_5A13.var_4348 playLoopSound("dropship_door_wind_lp");
      }

      self.var_4D94.var_5A13 notify("open");
      break;

    case "right":
      if(!isDefined(self.var_4D94.var_5A27)) {
        return;
      }

      if(scripts\sp\utility::func_65DB("right_door_open") || scripts\sp\utility::func_65DB("right_door_animating")) {
        return;
      }

      scripts\sp\utility::func_65E1(param_00 + "_door_animating");
      func_1242(self.var_4D94.var_5A27, self.var_4D94.var_5A27.var_1EF5, 0, param_02, param_01);
      if(param_03) {
        self.var_4D94.var_5A27.var_4348 playLoopSound("dropship_door_wind_lp");
      }

      self.var_4D94.var_5A27 notify("open");
      break;

    case "back":
      if(!isDefined(self.var_4D94.var_5A01)) {
        return;
      }

      if(scripts\sp\utility::func_65DB("back_door_open") || scripts\sp\utility::func_65DB("back_door_animating")) {
        return;
      }

      scripts\sp\utility::func_65E1(param_00 + "_door_animating");
      func_1242(self.var_4D94.var_5A01, self.var_4D94.var_5A01.var_1EF5, 0, param_02);
      if(param_03) {
        self.var_4D94.var_5A01.var_4348 playLoopSound("dropship_door_wind_lp");
      }

      self.var_4D94.var_5A01 notify("open");
      break;
  }

  scripts\sp\utility::func_65DD(param_00 + "_door_animating");
  scripts\sp\utility::func_65E1(param_00 + "_door_open");
}

func_1242(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_04)) {
    param_04 = 0;
  }

  if(isDefined(param_00.var_4348)) {
    func_12E7(param_00.var_4348);
    if(param_02) {
      param_00.var_4348 solid();
    }
  }

  if(isDefined(param_00.var_D89D)) {
    self clearanim(param_00.var_D89D, 0);
  }

  self give_capture_credit(param_01, 1);
  var_05 = getanimlength(param_01);
  if(isDefined(param_03) && param_03) {
    self _meth_82B0(param_01, 1);
  } else {
    wait(var_05);
  }

  param_00.var_D89D = param_01;
  if(isDefined(param_00.var_4348) && !param_02 && !param_04) {
    param_00.var_4348 notsolid();
  }
}

func_12E7(param_00) {
  var_01 = 0;
  var_02 = 0;
  for(;;) {
    if(level.player istouching(param_00)) {
      var_01 = 0;
      var_02++;
    } else {
      if(var_01 > 2) {
        break;
      }

      var_01++;
    }

    scripts\engine\utility::waitframe();
  }

  return var_02;
}

func_F365(param_00, param_01) {
  if(isDefined(param_00)) {
    param_00 = scripts\engine\utility::ter_op(!isarray(param_00), [param_00], param_00);
  }

  foreach(var_03 in param_00) {
    switch (var_03) {
      case "left":
        self.var_4D94.var_5A13.var_1EF5 = param_01;
        break;

      case "right":
        self.var_4D94.var_5A27.var_1EF5 = param_01;
        break;

      case "back":
        self.var_4D94.var_5A01.var_1EF5 = param_01;
        break;

      default:
        break;
    }
  }
}

func_F362(param_00, param_01) {
  if(isDefined(param_00)) {
    param_00 = scripts\engine\utility::ter_op(!isarray(param_00), [param_00], param_00);
  }

  foreach(var_03 in param_00) {
    switch (var_03) {
      case "left":
        self.var_4D94.var_5A13.var_1EA9 = param_01;
        break;

      case "right":
        self.var_4D94.var_5A27.var_1EA9 = param_01;
        break;

      case "back":
        self.var_4D94.var_5A01.var_1EA9 = param_01;
        break;

      default:
        break;
    }
  }
}

func_4265(param_00, param_01) {
  self endon("death");
  if(isDefined(param_00)) {
    param_00 = scripts\engine\utility::ter_op(!isarray(param_00), [param_00], param_00);
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(!isDefined(param_00) || !isDefined(param_00[0]) || param_00[0] == "all") {
    param_00 = ["left", "right", "back"];
  }

  var_02 = [];
  foreach(var_04 in param_00) {
    var_02 = scripts\engine\utility::array_add(var_02, self.var_4D94.doors[var_04]);
    childthread func_1221(var_04, param_01);
  }

  if(!param_01) {
    scripts\sp\utility::func_22D8(var_02, "close");
  }
}

func_1221(param_00, param_01) {
  scripts\sp\utility::func_65E8(param_00 + "_door_animating");
  scripts\sp\utility::func_65E1(param_00 + "_door_animating");
  if(!isDefined(self.var_4D94.var_5A13.var_1EA9)) {
    self.var_4D94.var_5A13.var_1EA9 = % vh_dropship_front_door_left_close;
  }

  if(!isDefined(self.var_4D94.var_5A27.var_1EA9)) {
    self.var_4D94.var_5A27.var_1EA9 = % vh_dropship_front_door_right_close;
  }

  if(!isDefined(self.var_4D94.var_5A01.var_1EA9)) {
    self.var_4D94.var_5A01.var_1EA9 = % vh_dropship_rear_doors_close;
  }

  switch (param_00) {
    case "left":
      if(!isDefined(self.var_4D94.var_5A13)) {
        break;
      }

      if(!scripts\sp\utility::func_65DB("left_door_open")) {
        break;
      }

      scripts\sp\utility::func_65DD("left_door_open");
      func_1242(self.var_4D94.var_5A13, self.var_4D94.var_5A13.var_1EA9, 1, param_01);
      if(isDefined(self.var_4D94.var_5A13.var_4348)) {
        self.var_4D94.var_5A13.var_4348 stoploopsound();
      }

      self.var_4D94.var_5A13 notify("close");
      break;

    case "right":
      if(!isDefined(self.var_4D94.var_5A27)) {
        break;
      }

      if(!scripts\sp\utility::func_65DB("right_door_open")) {
        break;
      }

      scripts\sp\utility::func_65DD("right_door_open");
      func_1242(self.var_4D94.var_5A27, self.var_4D94.var_5A27.var_1EA9, 1, param_01);
      if(isDefined(self.var_4D94.var_5A27.var_4348)) {
        self.var_4D94.var_5A27.var_4348 stoploopsound();
      }

      self.var_4D94.var_5A27 notify("close");
      break;

    case "back":
      if(!isDefined(self.var_4D94.var_5A01)) {
        break;
      }

      if(!scripts\sp\utility::func_65DB("back_door_open")) {
        break;
      }

      scripts\sp\utility::func_65DD("back_door_open");
      func_1242(self.var_4D94.var_5A01, self.var_4D94.var_5A01.var_1EA9, 1, param_01);
      if(isDefined(self.var_4D94.var_5A01.var_4348)) {
        self.var_4D94.var_5A01.var_4348 stoploopsound();
      }

      self.var_4D94.var_5A01 notify("close");
      break;

    default:
      break;
  }

  scripts\sp\utility::func_65DD(param_00 + "_door_animating");
}