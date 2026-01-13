/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3004.gsc
*********************************************/

main(var_0, var_1, var_2) {
  scripts\sp\vehicle_build::func_31C5("dropship", var_0, var_1, var_2);
  scripts\sp\vehicle_build::func_31A6(::init_location);
  scripts\sp\vehicle_build::func_3186(var_0, var_0);
  lib_0BBE::func_774E(var_2);
  var_3 = "vfx\code\tread\heli_dust_default.vfx";
  if(!isDefined(level.plant_anims) || level.plant_anims == "earth") {
    var_3 = "vfx\code\tread\heli_dust_default.vfx";
  } else if(level.plant_anims == "titan") {
    var_3 = "vfx\iw7\core\tread\tread_airship_small_titan.vfx";
  }

  scripts\sp\vehicle_build::func_31C6(var_2, "default", var_3, 0);
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
  if(issubstr(var_2, "plane")) {
    scripts\sp\vehicle_build::func_319F();
  } else {
    scripts\sp\vehicle_build::func_31A0();
  }

  if(!issubstr(var_2, "cheap")) {
    if(issubstr(var_2, "player")) {
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

  var_0 = ["tag_frontsidethrsuter_ri", "tag_frontsidethruster_le"];
  lib_0BBE::func_FA5F("side_front", var_0, undefined, undefined, undefined, undefined, "side_thrusters_out");
  var_1 = ["tag_back_thruster_upper_ri", "tag_back_thruster_upper_le", "tag_back_thruster_lower_ri", "tag_back_thruster_lower_le"];
  lib_0BBE::func_FA5F("side_back", var_1);
  var_2 = ["tag_mid_thruster_1_ri", "tag_mid_thruster_3_ri", "tag_mid_thruster_1_le", "tag_mid_thruster_3_le", "tag_back_thruster_1_ri", "tag_back_thruster_2_ri", "tag_back_thruster_1_le", "tag_back_thruster_2_le"];
  lib_0BBE::func_FA5F("back", var_2, 10);
  thread lib_0BBE::func_774D();
  var_3 = self.script_team;
  if(var_3 == "axis") {
    thread lib_0BBE::func_774C();
  }

  self.var_101B2 = 0;
  thread lib_0BBE::func_5EC8( % vh_dropship_thrusters_up, % vh_dropship_thrusters_down, ::func_12B58);
  self.var_4D94 = spawnStruct();
  if(issubstr(self.classname, "player")) {
    self attach("veh_mil_air_un_dropship_hero_interior_rig", "tag_connect");
    self.var_4D94.var_EF3C = [];
    self.var_4D94.var_EF3C["cabin_lights"] = [];
    var_4 = ["tag_light_le_01", "tag_light_le_02", "tag_light_le_03", "tag_light_le_04", "tag_light_le_05", "tag_light_ri_01", "tag_light_ri_02", "tag_light_ri_03", "tag_light_ri_04", "tag_light_ri_05"];
    foreach(var_6 in var_4) {
      var_7 = scripts\sp\anim::func_1EE5("veh_mil_air_un_dropship_hero_interior_light", var_6);
      var_7.var_336 = "dropship_cabin_lights_" + self.var_6A0B;
      self.var_4D94.var_EF3C["cabin_lights"][self.var_4D94.var_EF3C["cabin_lights"].size] = var_7;
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
    foreach(var_6 in ["TAG_CARABINER_HANDLE_LE_1", "TAG_CARABINER_HANDLE_LE_2", "TAG_CARABINER_HANDLE_RI_1", "TAG_CARABINER_HANDLE_RI_2"]) {
      var_0A = self gettagorigin(var_6);
      var_0B = spawn("script_model", var_0A);
      var_0B setModel("veh_mil_air_un_dropship_hero_interior_carabiner_handle");
      var_0B.var_1FBD = var_0B scripts\engine\utility::spawn_tag_origin();
      var_0B.physics_setgravitydynentscalar = var_6;
      self.var_4D94.parts["straps"][self.var_4D94.parts["straps"].size] = var_0B;
      var_0B.var_1FBD linkto(self, var_6, (0, 0, 0), (0, 0, 0));
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

func_12B58(var_0) {
  if(self.var_101B2 && var_0 > 50) {
    scripts\sp\utility::func_65DD("side_thrusters_out");
    self give_attacker_kill_rewards( % vh_dropship_front_thrusters_in);
    scripts\engine\utility::delaycall(0.05, ::_meth_82B1, % vh_dropship_front_thrusters_in, 0.25);
    self clearanim( % vh_dropship_front_thrusters_out, 0.05);
    self.var_101B2 = 0;
    return;
  }

  if(var_0 > 50) {
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
  var_0 = 0.3;
  var_1 = 0.3;
  var_2 = 500;
  for(;;) {
    var_3 = (0, 0, -100000);
    var_4 = scripts\sp\utility::func_864C(self.origin);
    var_5 = distance(self.origin, var_4);
    if(var_5 < var_2) {
      if(!isDefined(self.var_5ECA)) {
        self.var_5ECA = spawn("script_origin", var_4);
        wait(0.05);
        self.var_5ECA scripts\sp\utility::func_10461("dropship_lz_debris_lp", var_0, 1, 1);
        wait(1);
      }

      if(isDefined(self.var_5ECA)) {
        var_4 = scripts\sp\utility::func_864C(self.origin);
        var_5 = distance(self.origin, var_4);
        var_1 = var_5 - var_2 / 0 - var_2;
        if(var_1 < var_0) {
          var_1 = var_0;
        }

        self.var_5ECA ghostattack(var_1, 0.1);
        self.var_5ECA moveto(var_4, 0.1);
        wait(0.2);
      }
    } else if(var_5 > var_2) {
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

func_E752(var_0) {
  if(var_0 < 0) {
    return 0;
  }

  if(var_0 > 1) {
    return 1;
  }

  return var_0;
}

func_F8A1() {
  var_0 = [];
  for(var_1 = 0; var_1 < 12; var_1++) {
    var_0[var_1] = spawnStruct();
    var_0[var_1].var_10220 = "tag_detach";
    var_0[var_1].botgetscriptgoalyaw = "stand";
  }

  var_0[0].var_92CC = % vh_org_dropship_idle_pilot;
  var_0[1].var_92CC = % vh_org_dropship_idle_copilot;
  var_0[2].var_92CC = % vh_org_dropship_unload_guy1_idle;
  var_0[3].var_92CC = % vh_org_dropship_unload_guy2_idle;
  var_0[4].var_92CC = % vh_org_dropship_unload_guy3_idle;
  var_0[5].var_92CC = % vh_org_dropship_unload_guy4_idle;
  var_0[6].var_92CC = % vh_org_dropship_unload_guy5_idle;
  var_0[7].var_92CC = % vh_org_dropship_unload_guy6_idle;
  var_0[8].var_92CC = % vh_org_dropship_unload_guy7_idle;
  var_0[9].var_92CC = % vh_org_dropship_unload_guy8_idle;
  var_0[2].botclearscriptgoal = % vh_org_dropship_unload_jump_guy1;
  var_0[3].botclearscriptgoal = % vh_org_dropship_unload_jump_guy2;
  var_0[4].botclearscriptgoal = % vh_org_dropship_unload_jump_guy3;
  var_0[5].botclearscriptgoal = % vh_org_dropship_unload_jump_guy4;
  var_0[6].botclearscriptgoal = % vh_org_dropship_unload_jump_guy5;
  var_0[7].botclearscriptgoal = % vh_org_dropship_unload_jump_guy6;
  var_0[8].botclearscriptgoal = % vh_org_dropship_unload_jump_guy7;
  var_0[9].botclearscriptgoal = % vh_org_dropship_unload_jump_guy8;
  var_0[2].botgetdifficultysetting = % vh_org_dropship_unload_jump_loop_guy1;
  var_0[3].botgetdifficultysetting = % vh_org_dropship_unload_jump_loop_guy2;
  var_0[4].botgetdifficultysetting = % vh_org_dropship_unload_jump_loop_guy3;
  var_0[5].botgetdifficultysetting = % vh_org_dropship_unload_jump_loop_guy4;
  var_0[6].botgetdifficultysetting = % vh_org_dropship_unload_jump_loop_guy5;
  var_0[7].botgetdifficultysetting = % vh_org_dropship_unload_jump_loop_guy6;
  var_0[8].botgetdifficultysetting = % vh_org_dropship_unload_jump_loop_guy7;
  var_0[9].botgetdifficultysetting = % vh_org_dropship_unload_jump_loop_guy8;
  var_0[2].botgetdifficulty = % vh_org_dropship_unload_land_guy1;
  var_0[3].botgetdifficulty = % vh_org_dropship_unload_land_guy2;
  var_0[4].botgetdifficulty = % vh_org_dropship_unload_land_guy3;
  var_0[5].botgetdifficulty = % vh_org_dropship_unload_land_guy4;
  var_0[6].botgetdifficulty = % vh_org_dropship_unload_land_guy5;
  var_0[7].botgetdifficulty = % vh_org_dropship_unload_land_guy6;
  var_0[8].botgetdifficulty = % vh_org_dropship_unload_land_guy7;
  var_0[9].botgetdifficulty = % vh_org_dropship_unload_land_guy8;
  var_0[2].botgetentrancepoint = % vh_org_dropship_unload_guy1;
  var_0[3].botgetentrancepoint = % vh_org_dropship_unload_guy2;
  var_0[4].botgetentrancepoint = % vh_org_dropship_unload_guy3;
  var_0[5].botgetentrancepoint = % vh_org_dropship_unload_guy4;
  var_0[6].botgetentrancepoint = % vh_org_dropship_unload_guy5;
  var_0[7].botgetentrancepoint = % vh_org_dropship_unload_guy6;
  var_0[8].botgetentrancepoint = % vh_org_dropship_unload_guy7;
  var_0[9].botgetentrancepoint = % vh_org_dropship_unload_guy8;
  var_0 = func_FB0C(var_0);
  return var_0;
}

func_F5FC(var_0) {
  var_0[2].var_131E6 = % vh_dropship_front_door_left_open;
  var_0[2].var_131E7 = 0;
  var_0[6].var_131E6 = % vh_dropship_front_door_right_open;
  var_0[6].var_131E7 = 0;
  return var_0;
}

func_FB0C(var_0) {
  var_0[10].var_9FEF = 1;
  var_0[10].var_10220 = "tag_origin";
  var_0[10].var_92CC = % jsp_dropship_jumpout_apc_idle;
  var_0[10].botclearscriptgoal = % jsp_dropship_jumpout_apc_unload;
  var_0[11].var_9FEF = 1;
  var_0[11].var_10220 = "tag_detach";
  var_0[11].var_92CC = % jsp_dropship_apc_unload_idle;
  var_0[11].botclearscriptgoal = % jsp_dropship_apc_unload;
  return var_0;
}

func_12BBD() {
  var_0 = [];
  var_1 = "passengers";
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

func_F77B() {
  var_0 = [];
  for(var_1 = 0; var_1 < 1; var_1++) {
    var_0[var_1] = spawnStruct();
  }

  var_0[0].setglaregrimematerial = % vh_dropship_landing_gear_down;
  var_0[0].var_11472 = % vh_dropship_landing_gear_up;
  return var_0;
}

func_C5F1(var_0, var_1, var_2, var_3) {
  self endon("death");
  if(isDefined(var_0)) {
    var_0 = scripts\engine\utility::ter_op(!isarray(var_0), [var_0], var_0);
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_0) || !isDefined(var_0[0]) || var_0[0] == "all") {
    var_0 = ["left", "right", "back"];
  }

  var_4 = [];
  foreach(var_6 in var_0) {
    var_4 = scripts\engine\utility::array_add(var_4, self.var_4D94.doors[var_6]);
    childthread func_1236(var_6, var_1, var_2, var_3);
  }

  if(!var_2) {
    scripts\sp\utility::func_22D8(var_4, "open");
  }
}

func_1236(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.var_4D94.var_5A13.var_1EF5)) {
    self.var_4D94.var_5A13.var_1EF5 = % vh_dropship_front_door_left_open;
  }

  if(!isDefined(self.var_4D94.var_5A27.var_1EF5)) {
    self.var_4D94.var_5A27.var_1EF5 = % vh_dropship_front_door_right_open;
  }

  if(!isDefined(self.var_4D94.var_5A01.var_1EF5)) {
    self.var_4D94.var_5A01.var_1EF5 = % vh_dropship_rear_doors_open;
  }

  scripts\sp\utility::func_65E8(var_0 + "_door_animating");
  switch (var_0) {
    case "left":
      if(!isDefined(self.var_4D94.var_5A13)) {
        return;
      }

      if(scripts\sp\utility::func_65DB("left_door_open") || scripts\sp\utility::func_65DB("left_door_animating")) {
        return;
      }

      scripts\sp\utility::func_65E1(var_0 + "_door_animating");
      func_1242(self.var_4D94.var_5A13, self.var_4D94.var_5A13.var_1EF5, 0, var_2, var_1);
      if(var_3) {
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

      scripts\sp\utility::func_65E1(var_0 + "_door_animating");
      func_1242(self.var_4D94.var_5A27, self.var_4D94.var_5A27.var_1EF5, 0, var_2, var_1);
      if(var_3) {
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

      scripts\sp\utility::func_65E1(var_0 + "_door_animating");
      func_1242(self.var_4D94.var_5A01, self.var_4D94.var_5A01.var_1EF5, 0, var_2);
      if(var_3) {
        self.var_4D94.var_5A01.var_4348 playLoopSound("dropship_door_wind_lp");
      }

      self.var_4D94.var_5A01 notify("open");
      break;
  }

  scripts\sp\utility::func_65DD(var_0 + "_door_animating");
  scripts\sp\utility::func_65E1(var_0 + "_door_open");
}

func_1242(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(isDefined(var_0.var_4348)) {
    func_12E7(var_0.var_4348);
    if(var_2) {
      var_0.var_4348 solid();
    }
  }

  if(isDefined(var_0.var_D89D)) {
    self clearanim(var_0.var_D89D, 0);
  }

  self give_capture_credit(var_1, 1);
  var_5 = getanimlength(var_1);
  if(isDefined(var_3) && var_3) {
    self _meth_82B0(var_1, 1);
  } else {
    wait(var_5);
  }

  var_0.var_D89D = var_1;
  if(isDefined(var_0.var_4348) && !var_2 && !var_4) {
    var_0.var_4348 notsolid();
  }
}

func_12E7(var_0) {
  var_1 = 0;
  var_2 = 0;
  for(;;) {
    if(level.player istouching(var_0)) {
      var_1 = 0;
      var_2++;
    } else {
      if(var_1 > 2) {
        break;
      }

      var_1++;
    }

    scripts\engine\utility::waitframe();
  }

  return var_2;
}

func_F365(var_0, var_1) {
  if(isDefined(var_0)) {
    var_0 = scripts\engine\utility::ter_op(!isarray(var_0), [var_0], var_0);
  }

  foreach(var_3 in var_0) {
    switch (var_3) {
      case "left":
        self.var_4D94.var_5A13.var_1EF5 = var_1;
        break;

      case "right":
        self.var_4D94.var_5A27.var_1EF5 = var_1;
        break;

      case "back":
        self.var_4D94.var_5A01.var_1EF5 = var_1;
        break;

      default:
        break;
    }
  }
}

func_F362(var_0, var_1) {
  if(isDefined(var_0)) {
    var_0 = scripts\engine\utility::ter_op(!isarray(var_0), [var_0], var_0);
  }

  foreach(var_3 in var_0) {
    switch (var_3) {
      case "left":
        self.var_4D94.var_5A13.var_1EA9 = var_1;
        break;

      case "right":
        self.var_4D94.var_5A27.var_1EA9 = var_1;
        break;

      case "back":
        self.var_4D94.var_5A01.var_1EA9 = var_1;
        break;

      default:
        break;
    }
  }
}

func_4265(var_0, var_1) {
  self endon("death");
  if(isDefined(var_0)) {
    var_0 = scripts\engine\utility::ter_op(!isarray(var_0), [var_0], var_0);
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_0) || !isDefined(var_0[0]) || var_0[0] == "all") {
    var_0 = ["left", "right", "back"];
  }

  var_2 = [];
  foreach(var_4 in var_0) {
    var_2 = scripts\engine\utility::array_add(var_2, self.var_4D94.doors[var_4]);
    childthread func_1221(var_4, var_1);
  }

  if(!var_1) {
    scripts\sp\utility::func_22D8(var_2, "close");
  }
}

func_1221(var_0, var_1) {
  scripts\sp\utility::func_65E8(var_0 + "_door_animating");
  scripts\sp\utility::func_65E1(var_0 + "_door_animating");
  if(!isDefined(self.var_4D94.var_5A13.var_1EA9)) {
    self.var_4D94.var_5A13.var_1EA9 = % vh_dropship_front_door_left_close;
  }

  if(!isDefined(self.var_4D94.var_5A27.var_1EA9)) {
    self.var_4D94.var_5A27.var_1EA9 = % vh_dropship_front_door_right_close;
  }

  if(!isDefined(self.var_4D94.var_5A01.var_1EA9)) {
    self.var_4D94.var_5A01.var_1EA9 = % vh_dropship_rear_doors_close;
  }

  switch (var_0) {
    case "left":
      if(!isDefined(self.var_4D94.var_5A13)) {
        break;
      }

      if(!scripts\sp\utility::func_65DB("left_door_open")) {
        break;
      }

      scripts\sp\utility::func_65DD("left_door_open");
      func_1242(self.var_4D94.var_5A13, self.var_4D94.var_5A13.var_1EA9, 1, var_1);
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
      func_1242(self.var_4D94.var_5A27, self.var_4D94.var_5A27.var_1EA9, 1, var_1);
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
      func_1242(self.var_4D94.var_5A01, self.var_4D94.var_5A01.var_1EA9, 1, var_1);
      if(isDefined(self.var_4D94.var_5A01.var_4348)) {
        self.var_4D94.var_5A01.var_4348 stoploopsound();
      }

      self.var_4D94.var_5A01 notify("close");
      break;

    default:
      break;
  }

  scripts\sp\utility::func_65DD(var_0 + "_door_animating");
}