/*********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\maps\sp_jup_surge\sp_jup_surge_lighting.gsc
*********************************************************************/

#using scripts\common\anim;
#using scripts\common\lighting;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\utility;
#namespace sp_jup_surge_lighting;

function main() {
  post_load_precache(&function_bf161307a213ad69);
  scripts\common\lighting::light_init();
  thread function_b5f7fb0fd62c4ce();
}

function function_bf161307a213ad69() {}

function init_flags() {
  utility::flag_init("hideout_bathroom_flag");
  utility::flag_init("hideout_bathroom_flag_corridor_enter");
  utility::flag_init("park_dof_scripting_enabled");
}

function function_b5f7fb0fd62c4ce() {
  flag_wait("park_dof_scripting_enabled");
  setsaveddvar(@ "hash_62c917f9692eb820", 1);
  level.player enablephysicaldepthoffieldscripting();

  while(flag("park_dof_scripting_enabled")) {
    if(level.player getstance() == "crouch") {
      flag_clear("park_dof_scripting_enabled");
      break;
    }

    playerpos = level.player.origin + (0, 0, 62);
    yaw = getplayeryaw(level.player);
    pitch = getplayerpitch(level.player);
    cameraangles = (pitch, yaw, 0);
    forward = vectorNormalize(anglesToForward(cameraangles));
    raystart = playerpos + forward * 20;
    rayend = playerpos + forward * 10000;
    result = ray_trace_detail(raystart, rayend);
    var_c0eb0a6fb2a4ace2 = distance(result["position"], raystart);
    down = (0, 0, -1);
    downdot = pow(clamp(vectordot(down, forward), 0, 1), 4);
    fstop = math::lerp(2, 15, downdot);
    level.player setphysicaldepthoffield(fstop, var_c0eb0a6fb2a4ace2, 100, 100, result["position"]);
    wait 0.1;

    if(flag("flg_park_blended") || flag("blending_anim_starting") || flag("flg_park_final_blend_in_progress")) {
      flag_clear("park_dof_scripting_enabled");
    }
  }

  level.player disablephysicaldepthoffieldscripting();
  thread function_b5f7fb0fd62c4ce();
}

function lighting_setup() {
  lerp_spot_intensity("horizon light 001", 0, 100000);
  lerp_spot_intensity("horizon light 002", 0, 100000);
  lerp_spot_intensity("horizon light 003", 0, 100000);
  lerp_spot_intensity("horizon light 004", 0, 100000);
  lerp_spot_intensity("horizon light 005", 0, 100000);
  lerp_spot_intensity("horizon light 006", 0, 100000);
  lerp_spot_intensity("horizon light 007", 0, 100000);
  lerp_spot_intensity("horizon light 008", 0, 100000);
  lerp_spot_intensity("horizon light 009", 0, 100000);
  lerp_spot_intensity("horizon light 010", 0, 100000);
  lerp_spot_intensity("light_000_intro_igc_cafe_001", 0, 0);
  lerp_spot_intensity("light_000_intro_igc_cafe_002", 0, 0);
  lerp_spot_intensity("light_000_intro_igc_cafe_003", 0, 0);
  lerp_spot_intensity("light_000_intro_igc_cafe_004", 0, 0);
}

function function_95cf17c99337346c() {
  lerp_spot_intensity("light_000_intro_igc_cafe_001", 0, 8);
  lerp_spot_intensity("light_000_intro_igc_cafe_002", 0, 50);
  lerp_spot_intensity("light_000_intro_igc_cafe_003", 0, 15);
  lerp_spot_intensity("light_000_intro_igc_cafe_004", 0, 10);
  lerp_spot_intensity("soap_house_005", 0, 0.15);
  lerp_spot_intensity("soap_house_006", 0, 0.15);
}

function function_3b4d555ff8ee0131() {
  lerp_spot_intensity("light_000_intro_igc_cafe_001", 2, 0);
  lerp_spot_intensity("light_000_intro_igc_cafe_002", 2, 0);
  lerp_spot_intensity("light_000_intro_igc_cafe_003", 2, 0);
  lerp_spot_intensity("light_000_intro_igc_cafe_004", 2, 0);
}

function function_12890444d983f3b5() {
  lerp_spot_intensity("light_IGC_park_target_001", 0, 5);
}

function function_a5c7dce5a458f75e() {
  lerp_spot_intensity("light_IGC_park_target_001", 0, 0);
}

function function_476b266a5d575d91() {
  lerp_spot_intensity("light_IGC_park_target_001", 6, 0);
}

function function_ddc443dca27ceeaa() {
  lerp_spot_intensity("light_igc_storefront_001", 0, 10);
}

function function_336d1a39589b061c() {
  lerp_spot_intensity("light_igc_storefront_001", 2, 0);
}

function function_272906e3119dd8e0() {
  lerp_spot_intensity("soap_house_005", 0, 0.1);
  lerp_spot_intensity("soap_house_006", 0, 0.05);
}

function function_5ccdc11fd0355883() {
  wait 3;
  lerp_spot_intensity("light_igc_tunnel_005", 0, 30);
  lerp_spot_intensity("light_igc_tunnel_004", 0, 40);
  lerp_spot_intensity("light_igc_tunnel_003", 0, 15);
  lerp_spot_intensity("light_igc_tunnel_002", 0, 8);
  lerp_spot_intensity("light_igc_tunnel_001", 0, 200);
  lerp_spot_intensity("tunnel_intro_IGC_fill_001", 0, 5);
  lerp_spot_intensity("tunnel_intro_IGC_fill_002", 0, 0.5);
  lerp_spot_intensity("tunnel_intro_IGC_fill_003", 0, 50);
  lerp_spot_intensity("tunnel_intro_IGC_fill_004", 0, 8);
  setsaveddvar(@ "hash_e918bd4613339eeb", 0);
  wait 15;
  setsaveddvar(@ "hash_e918bd4613339eeb", 2);
}

function function_4dfbcdf6e57930e7() {
  lerp_spot_intensity("light_igc_tunnel_005", 1, 0);
  lerp_spot_intensity("light_igc_tunnel_004", 1, 0);
  lerp_spot_intensity("light_igc_tunnel_003", 1, 0);
  lerp_spot_intensity("light_igc_tunnel_002", 1, 0);
  lerp_spot_intensity("light_igc_tunnel_001", 1, 0);
  lerp_spot_intensity("tunnel_intro_IGC_fill_001", 1, 0);
  lerp_spot_intensity("tunnel_intro_IGC_fill_002", 1, 0);
  lerp_spot_intensity("tunnel_intro_IGC_fill_003", 1, 0);
  lerp_spot_intensity("tunnel_intro_IGC_fill_004", 1, 0);
}

function function_e5983d2bf6e3dc1f() {}

function function_703a09200ce52e48() {
  utility::flag_wait("hideout_bathroom_flag");
  wait 0.2;
}

function function_b88dea8ecd8304e4() {
  level flag_wait("hideout_bathroom_flag_corridor_enter");
  wait 0.2;
}

function function_e16657777a0e7bf0() {}

function function_e1665a777a0e8289() {}

function function_dc0cd3c8aaa45469() {}

function function_dc0cd0c8aaa44dd0() {}

function function_f4c36c92e884a00f() {}