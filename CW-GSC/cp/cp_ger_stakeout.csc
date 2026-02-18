/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_ger_stakeout.csc
***********************************************/

#using script_196ed2508fd0fd9d;
#using script_38867f943fb86135;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\easing;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flashlight;
#using scripts\core_common\load_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;
#using scripts\weapons\cp\spy_camera;
#namespace cp_ger_stakeout;

function event_handler[level_init] main(eventstruct) {
  setsaveddvar(#"enable_global_wind", 1);
  setsaveddvar(#"wind_global_vector", "88 0 0");
  setsaveddvar(#"wind_global_low_altitude", 0);
  setsaveddvar(#"wind_global_hi_altitude", 10000);
  setsaveddvar(#"wind_global_low_strength_percent", 100);
  init_clientfields();
  load::main();
  util::waitforclient(0);
  level flashlight::function_69258685(undefined, "maps/cp_stakeout/fx9_flashlight");
  level._effect[# "guard_room_light"] = # "hash_d2a2dd55181f074";
  level._effect[# "darkroom_light"] = # "hash_78e234f940b499a";
  level._effect[# "rooftop_spotlight"] = # "hash_3a149841990ac7b1";
  level._effect[# "hash_27d555878676deb1"] = # "hash_7c3a90be6566a844";
  level._effect[# "player_blacklight"] = # "hash_2a8bc9be6587131c";
}

function init_clientfields() {
  clientfield::register("toplayer", "force_stream_train", 1, 1, "int", &function_602a63fc, 0, 0);
  clientfield::register("world", "force_stream_sewer_exit", 1, 1, "int", &function_7156aa2d, 0, 0);
  clientfield::register("world", "force_stream_bar", 1, 1, "int", &function_d5fba952, 0, 0);
  clientfield::register("world", "force_stream_warehouse", 1, 1, "int", &function_2ac1660e, 0, 0);
  clientfield::register("world", "cull_rear_warehouse", 1, 1, "int", &function_3378a40d, 0, 0);
  clientfield::register("toplayer", "pstfx_sprite_rain_loop", 1, 1, "int", &pstfx_sprite_rain_loop, 0, 0);
  clientfield::register("toplayer", "pstfx_sprite_rain_ladder", 1, 1, "int", &pstfx_sprite_rain_ladder, 0, 0);
  clientfield::register("toplayer", "pstfx_head_trauma", 1, 1, "counter", &pstfx_head_trauma, 0, 0);
  clientfield::register("toplayer", "lerp_fov", 1, 3, "int", &lerp_fov, 0, 1);
  clientfield::register("toplayer", "player_blacklight", 1, 1, "int", &function_c20ade4a, 0, 0);
  clientfield::register("toplayer", "knock_out_vision", 1, 1, "int", &function_5568fbbb, 1, 0);
  clientfield::register("toplayer", "camera_focal_distance_electronics_store", 1, 1, "int", &function_c44b561f, 1, 0);
  clientfield::register("toplayer", "force_stream_weapons", 1, 1, "int", &force_stream_weapons, 1, 1);
  clientfield::register("scriptmover", "guard_room_light", 1, 1, "int", &function_e80b775e, 0, 0);
  clientfield::register("scriptmover", "sewer_exit_flashlight_fx", 1, 1, "int", &sewer_exit_flashlight_fx, 0, 0);
  clientfield::register("scriptmover", "darkroom_light", 1, 1, "int", &darkroom_light, 0, 0);
  clientfield::register("scriptmover", "rooftop_spotlight", 1, 1, "int", &rooftop_spotlight, 0, 0);
  clientfield::register("scriptmover", "render_emissive_blacklight_material", 1, 8, "int", &render_emissive_blacklight_material, 0, 0);
  clientfield::register("scriptmover", "constraint_toggle_field", 1, 1, "int", &function_68c9f370, 0, 0);
  clientfield::register("vehicle", "constraint_toggle_field", 1, 1, "int", &function_68c9f370, 0, 0);
  clientfield::register("toplayer", "kraus_zoom_hint_start", 1, 1, "int", &function_e1bea416, 0, 0);
  serverfield::register("kraus_zoom_hint_end", 1, 1, "int");
}

function force_stream_weapons(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  weapons = [];

  switch (bwasdemojump) {
    case 1:
      weapons[weapons.size] = getweapon(#"smg_standard_t9", "extclip2", "reflex", "heavy", "grip", "steadyaim");
      break;
    default:
      weapons[weapons.size] = getweapon(#"pistol_semiauto_t9", "suppressed");
      weapons[weapons.size] = getweapon(#"hash_808100ca097e40c");
      weapons[weapons.size] = getweapon(#"eq_spy_camera");
      break;
  }

  self thread util::force_stream_weapons(fieldname, weapons);
}

function function_602a63fc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    forcestreamxmodel("c_t9_ger_civ_female_urban_07_body3");
    forcestreamxmodel("c_t9_ger_civ_female_head02");
    forcestreamxmodel("c_t9_net_civ_female_urban_body6");
    forcestreamxmodel("c_t9_ger_civ_female_head03");
    forcestreamxmodel("c_t9_ger_civ_female_urban_06b_body");
    forcestreamxmodel("c_t9_ger_civ_female_head04");
    forcestreamxmodel("c_t9_ger_civ_male_urban_body2b");
    forcestreamxmodel("c_t9_ger_civ_male_head02");
    forcestreamxmodel("c_t9_ger_civ_male_urban_body3");
    forcestreamxmodel("c_t9_ger_civ_male_head04");
    forcestreamxmodel("c_t9_ger_civ_male_urban_body4h");
    forcestreamxmodel("c_t9_guard_m_berlin_head02");
    forcestreamxmodel("c_t9_ger_civ_male_urban_body1b");
    forcestreamxmodel("c_t9_ger_civ_male_head05");
    forcestreamxmodel("c_t9_ger_civ_male_urban_body8");
    forcestreamxmodel("c_t9_shg_npc_j_hernandez");
    forcestreamxmodel("c_t9_net_civ_male_urban_body5b");
    forcestreamxmodel("c_t9_ger_civ_male_head07");
    forcestreamxmodel("c_t9_ger_civ_male_urban_body10");
    forcestreamxmodel("c_t9_ger_civ_male_head01");
    forcestreamxmodel("c_t9_ger_civ_male_urban_body5");
    forcestreamxmodel("c_t9_ger_civ_male_head02");
    forcestreamxmodel("c_t9_ger_civ_male_urban_body5b");
    forcestreamxmodel("c_t9_ger_civ_male_head02");
    forcestreamxmodel("ndy_cigarette_01");
    forcestreamxmodel("par_umbrella_closed_01_85");
    forcestreamxmodel("briefcase_prop");
    forcestreamxmodel("stk_newspaper_anim_01");
    return;
  }

  stopforcestreamingxmodel("c_t9_ger_civ_female_urban_07_body3");
  stopforcestreamingxmodel("c_t9_ger_civ_female_head02");
  stopforcestreamingxmodel("c_t9_net_civ_female_urban_body6");
  stopforcestreamingxmodel("c_t9_ger_civ_female_head03");
  stopforcestreamingxmodel("c_t9_ger_civ_female_urban_06b_body");
  stopforcestreamingxmodel("c_t9_ger_civ_female_head04");
  stopforcestreamingxmodel("c_t9_ger_civ_male_urban_body2b");
  stopforcestreamingxmodel("c_t9_ger_civ_male_head02");
  stopforcestreamingxmodel("c_t9_ger_civ_male_urban_body3");
  stopforcestreamingxmodel("c_t9_ger_civ_male_head04");
  stopforcestreamingxmodel("c_t9_ger_civ_male_urban_body4h");
  stopforcestreamingxmodel("c_t9_guard_m_berlin_head02");
  stopforcestreamingxmodel("c_t9_ger_civ_male_urban_body1b");
  stopforcestreamingxmodel("c_t9_ger_civ_male_head05");
  stopforcestreamingxmodel("c_t9_ger_civ_male_urban_body8");
  stopforcestreamingxmodel("c_t9_shg_npc_j_hernandez");
  stopforcestreamingxmodel("c_t9_net_civ_male_urban_body5b");
  stopforcestreamingxmodel("c_t9_ger_civ_male_head07");
  stopforcestreamingxmodel("c_t9_ger_civ_male_urban_body10");
  stopforcestreamingxmodel("c_t9_ger_civ_male_head01");
  stopforcestreamingxmodel("c_t9_ger_civ_male_urban_body5");
  stopforcestreamingxmodel("c_t9_ger_civ_male_head02");
  stopforcestreamingxmodel("c_t9_ger_civ_male_urban_body5b");
  stopforcestreamingxmodel("c_t9_ger_civ_male_head02");
  stopforcestreamingxmodel("ndy_cigarette_01");
  stopforcestreamingxmodel("par_umbrella_closed_01_85");
  stopforcestreamingxmodel("briefcase_prop");
  stopforcestreamingxmodel("stk_newspaper_anim_01");
}

function function_7156aa2d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    forcestreamxmodel("c_t9_usa_hero_adler_undercover_berlin_pistol_body1");
    forcestreamxmodel("c_t9_usa_hero_adler_undercover_berlin_body1");
    return;
  }

  stopforcestreamingxmodel("c_t9_usa_hero_adler_undercover_berlin_pistol_body1");
  stopforcestreamingxmodel("c_t9_usa_hero_adler_undercover_berlin_body1");
}

function function_d5fba952(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    forcestreamxmodel("aac_kitchen_chair_01");
    forcestreamxmodel("c_t9_ger_civ_male_head07");
    forcestreamxmodel("aac_kitchen_chair_01");
    forcestreamxmodel("par_glassware_01");
    forcestreamxmodel("par_glassware_03");
    forcestreamxmodel("cob_cigarette_pack_01");
    forcestreamxmodel("ndy_cigarette_static_01_lit_long");
    forcestreamxmodel("decor_ashtray_cigarette_01_drk");
    forcestreamxmodel("stk_serving_tray_01");
    forcestreamxmodel("stk_glass_beer_bottle_01_open");
    forcestreamxmodel("cob_playing_cards_01");
    forcestreamxmodel("stk_cards_playing_single_015");
    forcestreamxmodel("generic_prop_x5");
    forcestreamxmodel("par_umbrella_open_01_anim");
    forcestreamxmodel("c_t9_usa_cig_listening_device_01");
    forcestreamxmodel("c_t9_ger_civ_female_urban_06c_body");
    forcestreamxmodel("c_t9_ger_civ_female_head01_hair_bld");
    forcestreamxmodel("c_t9_ger_civ_female_urban_07_body2");
    forcestreamxmodel("c_t9_ger_civ_female_head03");
    forcestreamxmodel("c_t9_ger_civ_female_urban_02_body_b");
    forcestreamxmodel("c_t9_ger_civ_female_head05");
    forcestreamxmodel("c_t9_cp_rus_civ_female_office_03_body_d");
    forcestreamxmodel("c_t9_ger_civ_female_head02");
    forcestreamxmodel("c_t9_ger_civ_male_urban_body2");
    forcestreamxmodel("c_t9_ger_civ_male_head07b");
    forcestreamxmodel("c_t9_cp_rus_civ_male_office_body3_c");
    forcestreamxmodel("c_t9_ger_civ_male_head03");
    forcestreamxmodel("c_t9_ger_civ_male_urban_body3");
    forcestreamxmodel("c_t9_ger_civ_male_head08");
    forcestreamxmodel("c_t9_ger_civ_male_urban_body1");
    forcestreamxmodel("c_t9_ger_civ_male_head09b");
    forcestreamxmodel("c_t9_cp_rus_civ_male_office_body5");
    forcestreamxmodel("c_t9_ger_civ_male_head01");
    forcestreamxmodel("c_t9_ger_civ_male_urban_body4d");
    forcestreamxmodel("c_t9_ger_civ_male_head06c");
    forcestreamxmodel("c_t9_cp_rus_civ_male_office_body4_c");
    forcestreamxmodel("c_t9_shg_npc_a_smirnov");
    forcestreamxmodel("c_t9_net_civ_male_urban_body5c");
    forcestreamxmodel("c_t9_ger_civ_male_head02b");
    forcestreamxmodel("c_t9_ger_civ_male_urban_body5b");
    forcestreamxmodel("c_t9_ger_civ_male_head06b");
    return;
  }

  stopforcestreamingxmodel("aac_kitchen_chair_01");
  stopforcestreamingxmodel("c_t9_ger_civ_male_head07");
  stopforcestreamingxmodel("aac_kitchen_chair_01");
  stopforcestreamingxmodel("par_glassware_01");
  stopforcestreamingxmodel("par_glassware_03");
  stopforcestreamingxmodel("cob_cigarette_pack_01");
  stopforcestreamingxmodel("ndy_cigarette_static_01_lit_long");
  stopforcestreamingxmodel("decor_ashtray_cigarette_01_drk");
  stopforcestreamingxmodel("stk_serving_tray_01");
  stopforcestreamingxmodel("stk_glass_beer_bottle_01_open");
  stopforcestreamingxmodel("cob_playing_cards_01");
  stopforcestreamingxmodel("stk_cards_playing_single_015");
  stopforcestreamingxmodel("generic_prop_x5");
  stopforcestreamingxmodel("par_umbrella_open_01_anim");
  stopforcestreamingxmodel("c_t9_usa_cig_listening_device_01");
  stopforcestreamingxmodel("c_t9_ger_civ_female_urban_06c_body");
  stopforcestreamingxmodel("c_t9_ger_civ_female_head01_hair_bld");
  stopforcestreamingxmodel("c_t9_ger_civ_female_urban_07_body2");
  stopforcestreamingxmodel("c_t9_ger_civ_female_head03");
  stopforcestreamingxmodel("c_t9_ger_civ_female_urban_02_body_b");
  stopforcestreamingxmodel("c_t9_ger_civ_female_head05");
  stopforcestreamingxmodel("c_t9_cp_rus_civ_female_office_03_body_d");
  stopforcestreamingxmodel("c_t9_ger_civ_female_head02");
  stopforcestreamingxmodel("c_t9_ger_civ_male_urban_body2");
  stopforcestreamingxmodel("c_t9_ger_civ_male_head07b");
  stopforcestreamingxmodel("c_t9_cp_rus_civ_male_office_body3_c");
  stopforcestreamingxmodel("c_t9_ger_civ_male_head03");
  stopforcestreamingxmodel("c_t9_ger_civ_male_urban_body3");
  stopforcestreamingxmodel("c_t9_ger_civ_male_head08");
  stopforcestreamingxmodel("c_t9_ger_civ_male_urban_body1");
  stopforcestreamingxmodel("c_t9_ger_civ_male_head09b");
  stopforcestreamingxmodel("c_t9_cp_rus_civ_male_office_body5");
  stopforcestreamingxmodel("c_t9_ger_civ_male_head01");
  stopforcestreamingxmodel("c_t9_ger_civ_male_urban_body4d");
  stopforcestreamingxmodel("c_t9_ger_civ_male_head06c");
  stopforcestreamingxmodel("c_t9_cp_rus_civ_male_office_body4_c");
  stopforcestreamingxmodel("c_t9_shg_npc_a_smirnov");
  stopforcestreamingxmodel("c_t9_net_civ_male_urban_body5c");
  stopforcestreamingxmodel("c_t9_ger_civ_male_head02b");
  stopforcestreamingxmodel("c_t9_ger_civ_male_urban_body5b");
  stopforcestreamingxmodel("c_t9_ger_civ_male_head06b");
}

function function_2ac1660e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    forcestreamxmodel("c_t9_cp_rus_kgb_volkov_body");
    forcestreamxmodel("c_t9_cp_rus_civ_volkov_head");
    forcestreamxmodel("c_t9_ger_civ_kraus_02_body");
    forcestreamxmodel("c_t9_cp_ger_civ_kraus_head01");
    forcestreamxmodel("c_t9_ger_civ_female_contact_body");
    forcestreamxmodel("c_t9_ger_civ_female_contact_head");
    forcestreamxmodel("c_t9_cp_ger_civ_male_informant_body");
    forcestreamxmodel("c_t9_cp_ger_civ_male_informant_head01");
    forcestreamxmodel("c_t9_rus_smg_enemy_01");
    forcestreamxmodel("c_t9_usa_hero_adler_undercover_berlin_body1");
    forcestreamxmodel("c_t9_cp_usa_hero_adler_head1");
    forcestreamxmodel("c_t9_eng_hero_park_undercover_berlin_body1");
    forcestreamxmodel("c_t9_eng_hero_park_head");
    forcestreamxmodel("c_t9_cp_usa_hero_lazar_civ_berlin_body1");
    forcestreamxmodel("c_t9_cp_usa_hero_lazar_head1");
    forcestreamxmodel("ee_furniture_chair_metal_folding_open");
    forcestreamxmodel("wpn_t9_pistol_semiauto_prop_animate");
    forcestreamxmodel("z_briefcase_01");
    return;
  }

  stopforcestreamingxmodel("c_t9_cp_rus_kgb_volkov_body");
  stopforcestreamingxmodel("c_t9_cp_rus_civ_volkov_head");
  stopforcestreamingxmodel("c_t9_ger_civ_kraus_02_body");
  stopforcestreamingxmodel("c_t9_cp_ger_civ_kraus_head01");
  stopforcestreamingxmodel("c_t9_ger_civ_female_contact_body");
  stopforcestreamingxmodel("c_t9_ger_civ_female_contact_head");
  stopforcestreamingxmodel("c_t9_cp_ger_civ_male_informant_body");
  stopforcestreamingxmodel("c_t9_cp_ger_civ_male_informant_head01");
  stopforcestreamingxmodel("c_t9_rus_smg_enemy_01");
  stopforcestreamingxmodel("c_t9_usa_hero_adler_undercover_berlin_body1");
  stopforcestreamingxmodel("c_t9_cp_usa_hero_adler_head1");
  stopforcestreamingxmodel("c_t9_eng_hero_park_undercover_berlin_body1");
  stopforcestreamingxmodel("c_t9_eng_hero_park_head");
  stopforcestreamingxmodel("c_t9_cp_usa_hero_lazar_civ_berlin_body1");
  stopforcestreamingxmodel("c_t9_cp_usa_hero_lazar_head1");
  stopforcestreamingxmodel("ee_furniture_chair_metal_folding_open");
  stopforcestreamingxmodel("wpn_t9_pistol_semiauto_prop_animate");
  stopforcestreamingxmodel("z_briefcase_01");
}

function private function_3378a40d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    function_a5777754(fieldname, "exclude_inside_warehouse_end");
  }
}

function function_e1bea416(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    self endon(#"hash_17bf3ed360080e51", #"death");

    while(true) {
      zoom = self waittill(#"camera_zoom");

      if(zoom.pct > 0.2) {
        self serverfield::set("kraus_zoom_hint_end", 1);
        self notify(#"hash_17bf3ed360080e51");
      }
    }
  }
}

function lerp_fov(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  switch (bwasdemojump) {
    case 1:
      self easing::function_f95cb457(undefined, 23.9, 0.016, #"linear");
      break;
    case 2:
      self function_9298adaf(0.5);
      break;
    case 3:
      self easing::function_f95cb457(undefined, 20.13, 2, #"linear");
      break;
    case 4:
      self function_9298adaf(2);
      break;
    case 5:
      self easing::function_f95cb457(undefined, 21.55, 1, #"linear");
      self thread dof_enable_autofocus();
      break;
    case 6:
      self function_9298adaf(1);
      self thread dof_disable_autofocus();
      break;
    case 0:
    default:
      self function_9298adaf(0.5);
      self thread dof_disable_autofocus();
      break;
  }
}

function dof_enable_autofocus() {
  self endoncallback(&function_26826144, #"death", #"disable_autofocus");
  self function_9e574055(1);
  self easing::function_136edb11(undefined, 5.6, 1, #"linear");

  while(true) {
    v_eye = self getEye();
    v_fwd = anglesToForward(self getcamangles());
    a_trace = physicstrace(v_eye, v_eye + v_fwd * 1000, (1 * -1, 1 * -1, 1 * -1), (1, 1, 1), self, 1);
    var_a84275e3 = distance(v_eye, a_trace[# "position"] + v_fwd * 1);

    if(var_a84275e3 < 100) {
      self function_9e574055(2);
    } else {
      self function_9e574055(1);
    }

    self function_d7be9a9f(var_a84275e3, 0);
    waitframe(1);
  }
}

function dof_disable_autofocus() {
  self notify(#"disable_autofocus");
}

function function_26826144(str_notify) {
  self function_9e574055(0);
  self function_3c54e2b8(1);
  self function_9ea7b4eb(1);
}

function pstfx_sprite_rain_loop(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self util::waittill_dobj(fieldname);

  if(bwasdemojump) {
    if(self postfx::function_556665f2("pstfx_sprite_rain_loop")) {
      self postfx::stoppostfxbundle("pstfx_sprite_rain_loop");
      self notify(#"hash_31ca7d9fa1b055e0");
    }

    self postfx::playpostfxbundle("pstfx_sprite_rain_loop");
    var_3f79908d = playtagfxset(fieldname, "fx9_stakeout_screen_drop_distort", self);
    self thread function_f524c7a5(fieldname, var_3f79908d);
    return;
  }

  self postfx::exitpostfxbundle("pstfx_sprite_rain_loop");
  self notify(#"hash_31ca7d9fa1b055e0");
}

function function_f524c7a5(localclientnum, var_3f79908d) {
  self notify("46066bff125f2af7");
  self endon("46066bff125f2af7");
  self waittill(#"death", #"hash_31ca7d9fa1b055e0");

  foreach(fxid in var_3f79908d) {
    stopfx(localclientnum, fxid);
  }
}

function pstfx_sprite_rain_ladder(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    if(self postfx::function_556665f2("pstfx_sprite_rain_loop_enter_stage")) {
      self postfx::stoppostfxbundle("pstfx_sprite_rain_loop_enter_stage");
    }

    self postfx::playpostfxbundle("pstfx_sprite_rain_loop_enter_stage");
    return;
  }

  self postfx::exitpostfxbundle("pstfx_sprite_rain_loop_enter_stage");
}

function pstfx_head_trauma(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self thread function_cd8c0e74();
}

function function_cd8c0e74() {
  self notify("3b036890c54b1f80");
  self endon("3b036890c54b1f80");
  self endon(#"death");

  if(self postfx::function_556665f2("pstfx_head_trauma")) {
    self postfx::stoppostfxbundle("pstfx_head_trauma");
  }

  self thread postfx::playpostfxbundle("pstfx_head_trauma");
  wait 1.5;
  self thread postfx::exitpostfxbundle("pstfx_head_trauma");
}

function function_e80b775e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    self.var_9028faf2 = util::playFXOnTag(fieldname, level._effect[# "guard_room_light"], self, "tag_fx");
    return;
  }

  if(isDefined(self.var_9028faf2)) {
    killfx(fieldname, self.var_9028faf2);
    self.var_9028faf2 = undefined;
  }
}

function sewer_exit_flashlight_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    self.var_103f6c4c = util::playFXOnTag(fieldname, level._effect[# "hash_27d555878676deb1"], self, "tag_light");
    return;
  }

  if(isDefined(self.var_103f6c4c)) {
    killfx(fieldname, self.var_103f6c4c);
    self.var_103f6c4c = undefined;
  }
}

function darkroom_light(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    self.var_23de4c6c = util::playFXOnTag(fieldname, level._effect[# "darkroom_light"], self, "tag_fx");
    return;
  }

  if(isDefined(self.var_23de4c6c)) {
    killfx(fieldname, self.var_23de4c6c);
    self.var_23de4c6c = undefined;
  }
}

function rooftop_spotlight(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    self.var_7a1ac572 = util::playFXOnTag(fieldname, level._effect[# "rooftop_spotlight"], self, "fx_tag_spotlight_script");
    return;
  }

  if(isDefined(self.var_7a1ac572)) {
    killfx(fieldname, self.var_7a1ac572);
    self.var_7a1ac572 = undefined;
  }
}

function function_c20ade4a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    self.var_5da1ad93 = playfxoncamera(fieldname, level._effect[# "player_blacklight"], (0, 0, 0), (1, 0, -0.1), (0, 0, 1));
    return;
  }

  stopfx(fieldname, self.var_5da1ad93);
  self.var_5da1ad93 = undefined;
}

function render_emissive_blacklight_material(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  player = function_5c10bd79(fieldname);
  rob = undefined;

  switch (bwastimejump) {
    case 0:
      break;
    case 1:
      rob = # "hash_75541f13ad214906";
      break;
    case 2:
      rob = # "hash_75541e13ad214753";
      break;
    case 3:
      rob = # "hash_75541d13ad2145a0";
      break;
    case 4:
      rob = # "hash_75542413ad215185";
      break;
    case 5:
      rob = # "hash_75542313ad214fd2";
      break;
    case 6:
      rob = # "hash_75542213ad214e1f";
      break;
    case 7:
      rob = # "hash_75542113ad214c6c";
      break;
    case 8:
      rob = # "hash_75542813ad215851";
      break;
  }

  if(!isDefined(self.rob)) {
    self.rob = rob;
  }

  if(bwastimejump > 0) {
    self flag::set("draw_mat");
    self playrenderoverridebundle(self.rob);
    self.threshold = 0;
    min_dist = 10;
    min_dist_squared = min_dist * min_dist;
    max_dist = 400;
    var_11ecc9fe = max_dist * max_dist;

    while(self flag::get("draw_mat")) {
      eye = getlocalclienteyepos(0);
      fwd = anglesToForward(player getcamangles());
      dotlimit = 0.9744;
      delta = self.origin - eye;
      dir = vectornormalize(delta);
      vector_dot = vectordot(dir, fwd);
      dist = distance2dsquared(self.origin, eye);

      if(vector_dot > dotlimit && dist < var_11ecc9fe) {
        range = 0.0256;
        self.threshold = 1 - (1 - vector_dot) / range;

        self.threshold = math::clamp(self.threshold, 0, 1);
        self function_78233d29(self.rob, "", #"brightness", self.threshold);
        self function_78233d29(self.rob, "", #"threshold", self.threshold);
      } else {
        if(self.threshold > 0) {
          self util::lerp_generic(fieldname, 100, &function_9e7290f5, self.threshold, 0, self.rob);
          wait 0.1;
          self.threshold = 0;
        }

        self function_78233d29(self.rob, "", #"brightness", 0);
        self function_78233d29(self.rob, "", #"threshold", 0);
      }

      waitframe(1);
    }

    return;
  }

  if(isDefined(self.rob)) {
    if(self.threshold > 0) {
      self function_78233d29(self.rob, "", #"brightness", 0);
      self function_78233d29(self.rob, "", #"threshold", 0);
      self.threshold = 0;
    }

    self stoprenderoverridebundle(self.rob);
  }

  self flag::clear("draw_mat");
}

function function_9e7290f5(currenttime, elapsedtime, localclientnum, fadeduration, from, to, rob) {
  self endon(#"death");
  percent = localclientnum / fadeduration;
  amount = to * percent + from * (1 - percent);
  self function_78233d29(rob, "", #"brightness", amount);
  self function_78233d29(rob, "", #"threshold", amount);
}

function function_5568fbbb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    if(!self postfx::function_556665f2("pstfx_takedown_wreck_vision")) {
      self postfx::playpostfxbundle("pstfx_takedown_wreck_vision");
    }

    return;
  }

  if(self postfx::function_556665f2("pstfx_takedown_wreck_vision")) {
    self postfx::exitpostfxbundle("pstfx_takedown_wreck_vision");
  }
}

function function_68c9f370(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self function_d309e55a("tag_body_animate", 0);
    return;
  }

  self function_d309e55a("tag_body_animate", 1);
}

function function_c44b561f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    spy_camera::function_1323f7ed(256);
    return;
  }

  spy_camera::function_1323f7ed(undefined);
}