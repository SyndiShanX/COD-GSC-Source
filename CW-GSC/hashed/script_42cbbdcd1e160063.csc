/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_42cbbdcd1e160063.csc
***********************************************/

#using script_18910f59cc847b42;
#using script_30c7fb449869910;
#using script_3314b730521b9666;
#using script_38635d174016f682;
#using script_3c8eb74f9fce795a;
#using script_42cbbdcd1e160063;
#using script_64e5d3ad71ce8140;
#using script_67049b48b589d81;
#using script_6b71c9befed901f2;
#using script_71603a58e2da0698;
#using script_75c3996cce8959f7;
#using script_76abb7986de59601;
#using script_77163d5a569e2071;
#using script_771f5bff431d8d57;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_83eb6304;

function init() {
  level.var_11c4dca4 = [];
  clientfield::register("scriptmover", "play_fx", 1, 8, "int", &play_fx, 0, 0);
  clientfield::register("allplayers", "play_fx", 1, 8, "int", &function_368dc9eb, 0, 0);
  clientfield::register("actor", "play_fx", 1, 8, "int", &play_fx, 0, 0);
  clientfield::register("vehicle", "play_fx", 1, 8, "int", &play_fx, 0, 0);
  clientfield::register("scriptmover", "stop_fx", 1, 8, "int", &stop_fx, 0, 0);
  clientfield::register("allplayers", "stop_fx", 1, 8, "int", &stop_fx, 0, 0);
  clientfield::register("actor", "stop_fx", 1, 8, "int", &stop_fx, 0, 0);
  clientfield::register("vehicle", "stop_fx", 1, 8, "int", &stop_fx, 0, 0);
  level._effect[#"bomb"] = "zombie/fx_concussive_wave_impact_zdo";
  level._effect[#"nuke_dust"] = "zombie/fx_debris_body_nuke_dust_doa";
  level._effect[#"turret_impact"] = "doa/fx9_impact_turret_land";
  level._effect[#"skel_stomp_impact"] = "explosions/fx_exp_grenade_dirt";
  level._effect[#"character_fire_death_torso"] = "zombie/fx_fire_torso_os_doa";
  level._effect[#"character_fire_death_sm"] = "zombie/fx_fire_zombie_sm_os_doa";
  level._effect[#"gib_fx"] = "zombie/fx_blood_torso_explo_zmb";
  level._effect[#"gibtrail_fx"] = "blood/fx_blood_trail_zmb";
  level._effect[#"zombie_guts_explosion"] = "zombie/fx_blood_torso_explo_lg_os_zmb";
  level._effect[#"hash_551e1d0fcdb105e6"] = "zombie/fx_fire_arm_left_os_doa";
  level._effect[#"hash_4b37c12194af9a3b"] = "zombie/fx_fire_arm_right_os_doa";
  level._effect[#"fire_torso"] = "zombie/fx_fire_torso_os_doa";
  level._effect[#"hash_1d9e53a201883cb"] = "doa/fx_fire_arm_left_purple_os_doa";
  level._effect[#"gem_trail_red"] = "doa/fx_trail_gem_red_doa";
  level._effect[#"gem_trail_white"] = "doa/fx_trail_gem_white_doa";
  level._effect[#"gem_trail_blue"] = "doa/fx_trail_gem_blue_doa";
  level._effect[#"gem_trail_green"] = "doa/fx_trail_gem_green_doa";
  level._effect[#"gem_trail_yellow"] = "doa/fx_trail_gem_yellow_doa";
  level._effect[#"player_trail_green"] = "doa/fx9_trail_player_green";
  level._effect[#"player_trail_blue"] = "doa/fx9_trail_player_blue";
  level._effect[#"player_trail_red"] = "doa/fx9_trail_player_red";
  level._effect[#"player_trail_yellow"] = "doa/fx9_trail_player_yellow";
  level._effect[#"glow_blue"] = "doa/fx_light_doa_pickup_glow_blue";
  level._effect[#"glow_yellow"] = "doa/fx_light_doa_pickup_glow_gold";
  level._effect[#"glow_green"] = "doa/fx_light_doa_pickup_glow_green";
  level._effect[#"glow_red"] = "doa/fx_light_doa_pickup_glow_red";
  level._effect[#"glow_white"] = "doa/fx_light_doa_pickup_glow_white";
  level._effect[#"glow_item"] = "doa/fx_light_doa_pickup_glow_white";
  level._effect[#"glow_weapon"] = "doa/fx_light_doa_pickup_glow_blue";
  level._effect[#"giantskelheartglow"] = "doa/fx_light_doa_pickup_glow_red";
  level._effect[#"generic_generator_die"] = "explosions/fx8_exp_elec_killstreak";
  level._effect[#"generic_generator_active"] = "explosions/fx8_exp_equipment_lg";
  level._effect[#"hash_2ba7079a15be757c"] = "doa/fx9_spawn_blood_hand_burst_zmb";
  level._effect[#"hash_7207b019e119bc7d"] = "doa/fx9_spawn_blood_body_billowing_zmb";
  level._effect[#"hash_4dd7773ae2a48977"] = "zombie/fx_spawn_dirt_hand_burst_zmb";
  level._effect[#"hash_4f9dc73a09ccac6c"] = "zombie/fx_spawn_dirt_body_billowing_zmb";
  level._effect[#"demon_burst"] = "doa/fx9_spawn_demon_burst";
  level._effect[#"red_shield"] = "doa/fx9_shield_red_loop";
  level._effect[#"red_shield_os"] = "doa/fx9_shield_red_os";
  level._effect[#"silverback_shield"] = "zombie/fx_shield_red_zdo";
  level._effect[#"player_shield_long"] = "zombie/fx_shield_zdo";
  level._effect[#"player_shield_short"] = "zombie/fx_shield_gone_zdo";
  level._effect[#"player_shield_long_sideview"] = "zombie/fx_shield_side_zdo";
  level._effect[#"player_shield_short_sideview"] = "zombie/fx_shield_gone_side_zdo";
  level._effect[#"headshot"] = "zombie/fx_bul_flesh_head_fatal_zmb";
  level._effect[#"headshot_nochunks"] = "zombie/fx_bul_flesh_head_nochunks_zmb";
  level._effect[#"bloodspurt"] = "zombie/fx_bul_flesh_neck_spurt_zmb";
  level._effect[#"chicken_explode"] = "doa/fx_bio_chicken_death_doa";
  level._effect[#"treasure_chest_impact"] = "zombie/fx_concussive_wave_impact_zdo";
  level._effect[#"treasure_chest_explode"] = "doa/fx9_exp_chest_pirate_wood";
  level._effect[#"teleporter_dungeon_light"] = "doa/fx9_marker_tele_white_dist";
  level._effect[#"demon_burst"] = "doa/fx9_spawn_demon_burst";
  level._effect[#"exit_fog_marker"] = "doa/fx9_marker_exit_fog_md";
  level._effect[#"boxing_pow"] = "zombie/fx_powerup_boxer_gloves_impact_doa";
  level._effect[#"boxing_stars"] = "zombie/fx_powerup_boxer_gloves_impact_stars_doa";
  level._effect[#"magnet_on"] = "zombie/fx_magnet_ring_zdo";
  level._effect[#"magnet_fade"] = "zombie/fx_magnet_ring_fade_doa";
  level._effect[#"boots"] = "doa/fx_fire_furiousfeet_os_zdo";
  level._effect[#"timeshift"] = "doa/fx_powerup_timeshift_doa";
  level._effect[#"timeshift_contact"] = "doa/fx_powerup_timeshift_impact_doa";
  level._effect[#"timeshift_fade"] = "doa/fx_powerup_timeshift_fade_doa";
  level._effect[#"divine_shield"] = "doa/fx_powerup_timeshift_impact_nolight_doa";
  level._effect[#"divine_shield_off"] = "doa/fx_powerup_timeshift_nolight_os";
  level._effect[#"teamshift_contact"] = "doa/fx_horn_doa";
  level._effect[#"teamshift"] = "doa/fx_powerup_timeshift_red_doa";
  level._effect[#"monkey_light"] = "zm_weapons/fx8_cymbal_monkey_light";
  level._effect[#"monkey_reveal"] = "maps/zm_white/fx8_monkey_bomb_reveal";
  level._effect[#"monkey_detonate"] = "doa/fx_exp_rpg_purple_doa";
  level._effect[#"stunbear_affected"] = "doa/fx_powerup_stun_bear_fear_doa";
  level._effect[#"stunbear_contact"] = "doa/fx_powerup_stun_bear_shield_impact_doa";
  level._effect[#"stunbear"] = "doa/fx_powerup_stun_bear_shield_doa";
  level._effect[#"stunbear_fade"] = "animals/fx_bio_butterfly_top";
  level._effect[#"tesla_launch"] = "doa/fx_elec_sparks_burst_blue";
  level._effect[#"tesla_ball"] = "electric/fx8_elec_sparks_fixture_blue_md";
  level._effect[#"tesla_trail"] = "doa/fx_trail_tesla_balls_doa";
  level._effect[#"tesla_shock"] = "doa/fx_tesla_shock_doa";
  level._effect[#"tesla_shock_eyes"] = "zombie/fx_tesla_shock_eyes_zmb";
  level._effect[#"sprinkler_active"] = "doa/fx_sprinkler_active_doa";
  level._effect[#"sprinkler_land"] = "doa/fx_sprinkler_impact_doa";
  level._effect[#"sprinkler_takeoff"] = "doa/fx_sprinkler_impact_doa";
  level._effect[#"clone_orb"] = "player/fx_plyr_clone_reaper_orb";
  level._effect[#"clone_appear"] = "player/fx_plyr_clone_reaper_appear";
  level._effect[#"clone_vanish"] = "player/fx_plyr_clone_vanish";
  level._effect[#"egg_hatch"] = "doa/fx_powerup_egg_hatch_doa";
  level._effect[#"egg_explode"] = "doa/fx_powerup_egg_destroy_doa";
  level._effect[#"barrel_fire"] = "doa/fx9_fire_barrel_red_os";
  level._effect[#"barrel_fire_top"] = "doa/fx9_red_barrel_fire_os";
  level._effect[#"explode_lg"] = "doa/fx9_exp_doa_lg";
  level._effect[#"electrical_explo"] = "doa/fx9_mech_wpn_115_blob_exp_doa";
  level._effect[#"hazard_electric"] = "doa/fx_elec_sparks_burst_med_os_doa";
  level._effect[#"hazard_electric_trap_red"] = "doa/fx_trap_red_light_doa";
  level._effect[#"hazard_electric_trap_green"] = "doa/fx_trap_green_light_doa";
  level._effect[#"hazard_electric_trap_active"] = "zombie/fx_electric_trap_zdo";
  level._effect[#"hash_4c83639bb82942d8"] = "zombie/fx_electric_trap_sm_light_zdo";
  level._effect[#"teleporter_disabled"] = "electric/fx_sparks_burst_dir_md_z270_blue_os";
  level._effect[#"electrical_fire"] = "fire/fx9_spot_md_blue";
  level._effect[#"arcade_spark"] = "zombie/fx_electric_trap_zdo";
  level._effect[#"shadow_fade"] = "doa/fx_ai_raven_dissolve_torso";
  level._effect[#"shadow_move"] = "doa/fx_ai_raven_teleport";
  level._effect[#"shadow_appear"] = "doa/fx_ai_raven_teleport_in";
  level._effect[#"shadow_die"] = "doa/fx_ai_raven_juke_out";
  level._effect[#"shadow_rez_in"] = "doa/fx_ai_dni_rez_in";
  level._effect[#"hash_7fb19df63df2dd4c"] = "doa/fx_ai_dni_rez_out_clean";
  level._effect[#"shadow_emerge"] = "doa/fx_raven_teleport_doa";
  level._effect[#"shadow_glow"] = "doa/fx_glow_smokeman_doa";
  level._effect[#"heart_explode"] = "zombie/fx_blood_torso_explo_lg_os_zmb";
  level._effect[#"spawnzombie"] = "zombie/fx_spawn_body_cp_zmb";
  level._effect[#"weaponchargeractive"] = "doa/fx_trashcan_doa";
  level._effect[#"weaponchargerdone"] = "doa/fx_trashcan_damaged_doa";
  level._effect[#"pungi_hint"] = "doa/fx9_trap_spike_tell";
  level._effect[#"pungi_activate"] = "doa/fx9_trap_spike_damage";
  level._effect[#"pungi_damage"] = "doa/fx9_trap_spike_damage_player";
  level._effect[#"nova_crawler_aura_fx"] = "zm_ai/fx8_nova_crawler_aura";
  level._effect[#"nova_crawler_burst"] = "zm_ai/fx8_nova_crawler_gas_release";
  level._effect[#"nova_fx"] = "zm_ai/fx8_nova_crawler_aura";
  level._effect[#"silverback_launch"] = "zombie/fx_spawn_dirt_hand_burst_zmb";
  level._effect[#"silverback_land"] = "zombie/fx_debris_body_nuke_dust_doa";
  level._effect[#"silverback_banana_explo"] = "zombie/fx_exp_noxious_gas";
  level._effect[#"explo_warning_light"] = "doa/fx_ability_light_chest_immolation";
  level._effect[#"wild_portal"] = "doa/fx9_portal_loop";
  level._effect[#"basketexplo"] = "doa/fx9_exp_chest_pirate_wood";
  level._effect[#"lightningstrike"] = "zm_ai/fx8_dog_lightning_spawn";
  level._effect[#"wild_portal_elec_burst"] = "doa/fx9_elec_pulse_os";
  level._effect[#"wild_portal_radial_burst"] = "doa/fx9_elec_burst_radial_os";
  level._effect[#"dragontrap"] = "doa/fx9_trap_dragon_mouth_fire";
  level._effect[#"zombie_generator_die"] = "doa/fx9_exp_skull_blood_lg";
  level._effect[#"skeleton_generator_die"] = "doa/fx9_exp_skull_bones_lg";
  level._effect[#"fate_landing"] = "doa/fx9_elec_burst_radial_os";
  level._effect[#"fate_explo"] = "doa/fx9_exp_chest_pirate_wood";
  level._effect[#"magic_door_open"] = "doa/fx9_fireworks_gate";
  level._effect[#"fireworks"] = "doa/fx9_fireworks_gate";
  level._effect[#"fx_fire_torch_wall_lit_castle"] = "light/fx9_light_wz_doa_fire_animated";
  level._effect[#"crawler_generator_spawn"] = "doa/fx9_char_crawler_vomit_stream_rnr";
  level._effect[#"axe_trail"] = "doa/fx9_axe_trail_vis";
  level._effect[#"ethereal_vapors"] = "doa/fx9_char_ethereal_spawn";
  level._effect[#"blightfather_vomit"] = "zm_ai/fx8_blightfather_vomit";
  level._effect[#"player_respawn_green"] = "doa/fx_player_respawn_doa";
  level._effect[#"player_respawn_blue"] = "doa/fx_player_respawn_blue_doa";
  level._effect[#"player_respawn_red"] = "doa/fx_player_respawn_red_doa";
  level._effect[#"player_respawn_red"] = "doa/fx_player_respawn_yellow_doa";
  level._effect[#"ammo_unlimited"] = "doa/fx_ammo_can_doa";
  level._effect[#"explode_red_barrel"] = "destruct/fx9_red_barrel_exp";
  level._effect[#"meat_explode"] = "zombie/fx_meatball_explo_zod_zmb";
  level._effect[#"player_heal"] = "doa/fx9_ui_heal_aura_loop_red";
  level._effect[#"player_healos"] = "doa/fx9_ui_heal_aura_os_red";
  level._effect[#"firstpersonmarker"] = "doa/fx9_marker_1st_person";
  level._effect[#"lantern"] = "doa/fx9_marker_lantern";
  level._effect[#"lantern_fade"] = "doa/fx9_marker_lantern_os";
  level._effect[#"ghosthound_death"] = "doa/fx9_hellhound_ghost_exp";
  level._effect[#"hellhound_death"] = "zm_ai/fx8_cata_plasma_blast";
  level._effect[#"skeleton_death"] = "doa/fx9_exp_skeleton_fb";
  level._effect[#"skeleton_giant_death"] = "doa/fx9_exp_skeleton_fb_giant";
  level._effect[#"skeleton_hand_lightning"] = "zm_ai/fx8_dog_lightning_spawn";
  level._effect[#"skeleton_hand_energy"] = "zombie/fx_electric_trap_zdo";
  level._effect[#"bombfuse"] = "doa/fx9_cannon_ball_fuse";
  level._effect[#"crab_bubbles"] = "player/fx8_plyr_emote_bubbles_sm";
  level._effect[#"incoming_impact"] = "doa/fx_incoming_impact_doa";
  level._effect[#"lawn_mower"] = "doa/fx9_debris_lawn_mower";
  level._effect[#"pole_blast"] = "doa/fx9_hazard_elec_pole";
  level._effect[#"pole_zombie_elecburst"] = "electric/fx_sparks_burst_dir_md_z270_blue_os";
  level._effect[#"muzzleflash_md"] = "weapon/fx9_muz_md_gas_3p";
  level._effect[#"water_explosion"] = "explosions/fx9_bm_exp_surface_water_250";
  level._effect[#"water_geyser"] = "doa/fx8_geyser";
  level._effect[#"water_geyser_sm"] = "water/fx_water_geyser_md";
  level._effect[#"water_boil_ambient"] = "doa/fx9_water_boil_area_ambient";
  level._effect[#"water_boil_deathzone"] = "doa/fx9_water_boil_death_area_rnr";
  level._effect[#"remote_player_busy"] = "doa/fx9_marker_lightbulb";
  namespace_7e1ec234::function_10d1200d();
  level.var_8056ac44 = array(level._effect[#"hash_551e1d0fcdb105e6"], level._effect[#"hash_4b37c12194af9a3b"], level._effect[#"fire_torso"], level._effect[#"hash_551e1d0fcdb105e6"], level._effect[#"hash_4b37c12194af9a3b"]);
  level.var_75aaaa81 = array("j_elbow_le", "j_elbow_ri", "j_spine4", "j_knee_le", "j_knee_ri");
  level.gibresettime = 0.5;
  level.gibmaxcount = 3;
  level.gibtimer = 0;
  level.gibcount = 0;
  level.var_45fa1b3d = (0, 0, 4);
  level.var_e696e731 = 3;
  level.var_be2bb100 = 2;
  level.var_49fcf1d9 = 0.5;
  level.var_48152abe = array("zombietron_gib_chunk_fat", "zombietron_gib_chunk_bone_01", "zombietron_gib_chunk_bone_02", "zombietron_gib_chunk_bone_03", "zombietron_gib_chunk_flesh_01", "zombietron_gib_chunk_flesh_02", "zombietron_gib_chunk_flesh_03", "zombietron_gib_chunk_meat_01", "zombietron_gib_chunk_meat_02", "zombietron_gib_chunk_meat_03");
  function_3385d776(#"zombie/fx_concussive_wave_impact_zdo");
}

function function_79f3460b(localclientnum, cmd) {
  self notify("4589039b6c0d3db6");
  self endon("4589039b6c0d3db6");
  self endon(#"disconnect", #"entityshutdown", #"death");

  if(!isDefined(self.var_7d4b2574)) {
    self.var_7d4b2574 = [];
  }

  cmd.time = gettime();

  if(!isDefined(self.var_7d4b2574)) {
    self.var_7d4b2574 = [];
  } else if(!isarray(self.var_7d4b2574)) {
    self.var_7d4b2574 = array(self.var_7d4b2574);
  }

  self.var_7d4b2574[self.var_7d4b2574.size] = cmd;
  self util::waittill_dobj(localclientnum);
  namespace_1e25ad94::debugmsg("============================================== Processing DOBJ FX Queue");

  while(isDefined(self.var_7d4b2574) && self.var_7d4b2574.size) {
    cmd = self.var_7d4b2574[0];
    arrayremoveindex(self.var_7d4b2574, 0);

    if(cmd.on === 1) {
      namespace_1e25ad94::debugmsg("" + self getentitynumber() + "++++++++++++++++++++++++++++++++++++++++++> ON " + cmd.name + " issued at: " + cmd.time);
      self function_d0edb8b6(localclientnum, cmd.name, cmd.tag, cmd.unique);
    } else {
      namespace_1e25ad94::debugmsg("" + self getentitynumber() + "-----------------------------------------> OFF " + cmd.name + " issued at: " + cmd.time);
      self function_a28211cd(localclientnum, cmd.name);
    }

    waitframe(1);
  }

  self.var_7d4b2574 = undefined;
  namespace_1e25ad94::debugmsg("============================================== FINISHED DOBJ FX Queue");
}

function function_d0edb8b6(localclientnum, name, tag, unique) {
  if(isDefined(self.fxorigin)) {
    self.fxorigin thread function_f58618d7(localclientnum, name, tag, unique);
    return;
  }

  self thread function_f58618d7(localclientnum, name, tag, unique);
}

function function_e76f738(localclientnum, name, tag, unique, var_1fbeccf = 0) {
  if(var_1fbeccf) {
    self endon(#"disconnect", #"entityshutdown", #"death");

    while(isDefined(self) && !isDefined(self.fxorigin)) {
      waitframe(1);
    }
  }

  if(!isDefined(self) || !isDefined(localclientnum)) {
    return;
  }

  if(self hasdobj(localclientnum) === 0 || isDefined(self.var_7d4b2574)) {
    cmd = {
      #on: 1, #name: name, #tag: tag, #unique: unique
    };
    self thread function_79f3460b(localclientnum, cmd);
    return;
  }

  self function_d0edb8b6(localclientnum, name, tag, unique);
}

function play_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump != 0) {
    self thread function_e76f738(fieldname, function_43755017(bwastimejump), function_a3682ae2(bwastimejump), function_7450c5f4(bwastimejump));
  }
}

function function_368dc9eb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump != 0) {
    self thread function_e76f738(fieldname, function_43755017(bwastimejump), function_a3682ae2(bwastimejump), function_7450c5f4(bwastimejump), 1);
  }
}

function function_a28211cd(localclientnum, name) {
  if(isDefined(self.fxorigin)) {
    self.fxorigin function_8b1a4e9c(localclientnum, name);
    return;
  }

  self function_8b1a4e9c(localclientnum, name);
}

function function_68c546ac(localclientnum, name) {
  if(self hasdobj(localclientnum) === 0 || isDefined(self.var_7d4b2574)) {
    cmd = {
      #on: 0, #name: name
    };
    self thread function_79f3460b(localclientnum, cmd);
    return;
  }

  self function_a28211cd(localclientnum, name);
}

function stop_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump != 0) {
    self thread function_68c546ac(fieldname, function_43755017(bwastimejump));
  }
}

function function_4060ccb4(name, tag, unused1 = "tag_origin", forcestream = 0, var_23a371c9 = 0) {
  var_318e5b78 = level.var_11c4dca4.size;
  assert(var_318e5b78 < 256, "<dev string:x38>");
  level.var_11c4dca4[var_318e5b78] = {
    #name: tag, #tag: unused1, #id: var_318e5b78, #unique: var_23a371c9
  };

  if(forcestream) {
    function_3385d776(level._effect[tag]);
  }
}

function function_ede08af4(name) {
  foreach(fx in level.var_11c4dca4) {
    if(fx.name == name) {
      return fx.id;
    }
  }

  return 0;
}

function function_43755017(type) {
  assert(isDefined(level.var_11c4dca4[type]), "<dev string:x51>");
  return level.var_11c4dca4[type].name;
}

function function_a3682ae2(type) {
  assert(isDefined(level.var_11c4dca4[type]), "<dev string:x51>");
  return level.var_11c4dca4[type].tag;
}

function function_7450c5f4(type) {
  assert(isDefined(level.var_11c4dca4[type]), "<dev string:x51>");
  return level.var_11c4dca4[type].unique;
}

function function_8b1a4e9c(localclientnum, name) {
  profilestart();

  if(!isDefined(self.var_10b0846b)) {
    profilestop();
    return;
  }

  if(isDefined(self.var_10b0846b[name])) {
    stopfx(localclientnum, self.var_10b0846b[name]);
    self.var_10b0846b[name] = undefined;
  }

  if(isDefined(self.var_15b0b40[name])) {
    self.var_15b0b40[name] delete();
    self.var_15b0b40[name] = undefined;
  }

  if(isDefined(self.var_a7bcf699[name])) {
    foreach(fx in self.var_a7bcf699[name]) {
      stopfx(localclientnum, fx);
    }

    self.var_a7bcf699[name] = undefined;
  }

  profilestop();
}

function function_f58618d7(localclientnum, name, tag, var_fc8ee72b = 0) {
  self endon(#"entityshutdown", #"death", #"disconnect");

  if(!isDefined(localclientnum)) {
    return;
  }

  while(!clienthassnapshot(localclientnum)) {
    waitframe(1);
  }

  if(!is_true(self.hasdobj)) {
    self util::waittill_dobj(localclientnum);
    self.hasdobj = 1;
  }

  if(!isDefined(self.var_10b0846b)) {
    self.var_10b0846b = [];
  }

  if(!isDefined(self.var_15b0b40)) {
    self.var_15b0b40 = [];
  }

  if(!isDefined(self.var_a7bcf699)) {
    self.var_a7bcf699 = [];
  }

  if(tag == "special") {
    self thread function_d8c789b8(localclientnum, name);
    return;
  }

  if(tag == "fakelink") {
    org = namespace_ec06fe4a::spawnmodel(localclientnum, self.origin, "tag_origin", self.angles, "fx fakelink");

    if(!isDefined(org)) {
      return;
    }

    org.fx = util::playFXOnTag(localclientnum, level._effect[name], org, "tag_origin");

    if(isDefined(self.var_10b0846b[name])) {
      stopfx(localclientnum, self.var_10b0846b[name]);
    }

    if(isDefined(self.var_15b0b40[name])) {
      self.var_15b0b40[name] delete();
    }

    if(var_fc8ee72b && isDefined(self.var_10b0846b[name]) && isfxplaying(localclientnum, self.var_10b0846b[name])) {
      killfx(localclientnum, self.var_10b0846b[name]);
    }

    self.var_10b0846b[name] = org.fx;
    self.var_15b0b40[name] = org;
    org thread namespace_ec06fe4a::function_73d79e7d(self);
    return;
  }

  if(tag == "none") {
    if(var_fc8ee72b && isDefined(self.var_10b0846b[name]) && isfxplaying(localclientnum, self.var_10b0846b[name])) {
      killfx(localclientnum, self.var_10b0846b[name]);
    }

    self.var_10b0846b[name] = playFX(localclientnum, level._effect[name], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    return;
  }

  if(isDefined(tag) && tag != "tag_origin") {
    tagorigin = self gettagorigin(tag);

    if(!isDefined(tagorigin)) {
      tag = "tag_origin";
    }
  }

  modelent = isDefined(self.fakemodel) ? self.fakemodel : self;

  if(var_fc8ee72b && isDefined(self.var_10b0846b[name]) && isfxplaying(localclientnum, self.var_10b0846b[name])) {
    killfx(localclientnum, self.var_10b0846b[name]);
  }

  self.var_10b0846b[name] = util::playFXOnTag(localclientnum, level._effect[name], modelent, tag);
}

function function_a65eebe3(localclientnum) {
  self notify("65618fc845e4916b");
  self endon("65618fc845e4916b");
  result = self waittill(#"entityshutdown", #"death", #"disconnect");

  if(isDefined(self.var_a7bcf699)) {
    foreach(var_4212fdee in self.var_a7bcf699) {
      foreach(fx in var_4212fdee) {
        stopfx(localclientnum, fx);
      }
    }
  }
}

function function_d8c789b8(localclientnum, name, tag) {
  self endon(#"entityshutdown", #"death", #"disconnect");
  self thread function_a65eebe3(name);

  switch (tag) {
    case # "annhilate":
      self annihilate(name);
      break;
    case # "gut_explode":
      self zombie_gut_explosion(name);
      break;
    case # "saw_explode":
      self function_e5d3c2b4(name);
      break;
    case # "boost_explode":
      self function_96d7f2e2(name);
      break;
    case # "delay_explode":
      self zombie_wait_explode(name);
      break;
    case # "burn_zombie":
      self function_8fd3b08d(name, undefined);
      break;
    case # "zombie_chunk":
      self zombie_chunk(name);
      break;
    case # "ai_blood_riser":
      playFX(name, level._effect[#"hash_2ba7079a15be757c"], self.origin);
      wait 0.25;
      playFX(name, level._effect[#"hash_7207b019e119bc7d"], self.origin);
      break;
    case # "ai_zombie_riser":
      playFX(name, level._effect[#"hash_4dd7773ae2a48977"], self.origin);
      wait 0.25;
      playFX(name, level._effect[#"hash_4f9dc73a09ccac6c"], self.origin);
      break;
    case # "pole_zombie_elecburst":
      currentangle = randomint(360);
      var_5ccd914d = rotatepointaroundaxis((1, 0, 0), (0, 0, 1), currentangle);
      playFX(name, level._effect[#"pole_zombie_elecburst"], self.origin, var_5ccd914d, (0, 0, 1));
      break;
    case # "hash_2488c7de86684bbd":
      if(isDefined(self.var_a7bcf699[tag])) {
        foreach(fx in self.var_a7bcf699[tag]) {
          stopfx(name, fx);
        }
      }

      self.var_a7bcf699[tag] = [];
      self.var_a7bcf699[tag][self.var_a7bcf699[tag].size] = util::playFXOnTag(name, level._effect[#"hash_2488c7de86684bbd"], self, "j_belly");
      self.var_a7bcf699[tag][self.var_a7bcf699[tag].size] = util::playFXOnTag(name, level._effect[#"hash_2fbce616d1238481"], self, "j_ankle_le");
      self.var_a7bcf699[tag][self.var_a7bcf699[tag].size] = util::playFXOnTag(name, level._effect[#"hash_2fbce616d1238481"], self, "j_ankle_ri");
      self.var_a7bcf699[tag][self.var_a7bcf699[tag].size] = util::playFXOnTag(name, level._effect[#"hash_2fbce616d1238481"], self, "j_wrist_le");
      self.var_a7bcf699[tag][self.var_a7bcf699[tag].size] = util::playFXOnTag(name, level._effect[#"hash_2fbce616d1238481"], self, "j_wrist_ri");
      break;
    case # "shadow_appear":
      playFX(name, level._effect[#"shadow_appear"], self.origin);
      playFX(name, level._effect[#"shadow_rez_in"], self.origin);
      playFX(name, level._effect[#"shadow_emerge"], self.origin);
      break;
    case # "shadow_die":
      playFX(name, level._effect[#"shadow_fade"], self.origin);
      playFX(name, level._effect[#"heart_explode"], self.origin);
      playFX(name, level._effect[#"hash_7fb19df63df2dd4c"], self.origin);
      break;
    case # "hazard_electric_trap_active":
      if(isDefined(self.var_a7bcf699[tag])) {
        foreach(fx in self.var_a7bcf699[tag]) {
          stopfx(name, fx);
        }
      }

      self.var_a7bcf699[tag] = [];
      self.var_a7bcf699[tag][self.var_a7bcf699[tag].size] = playFX(name, level._effect[tag], self.origin + (0, 0, 100));
      self.var_a7bcf699[tag][self.var_a7bcf699[tag].size] = playFX(name, level._effect[#"hash_4c83639bb82942d8"], self.origin + (0, 0, 124));
      break;
    case # "hazard_electric_trap_red":
    case # "hazard_electric_trap_green":
      if(isDefined(self.var_a7bcf699[tag])) {
        foreach(fx in self.var_a7bcf699[tag]) {
          stopfx(name, fx);
        }
      }

      self.var_a7bcf699[tag] = [];
      self.var_a7bcf699[tag][self.var_a7bcf699[tag].size] = playFX(name, level._effect[tag], self.origin + (0, 0, 124));
      break;
    case # "skel_stomp_impact":
      if(isDefined(self.var_a7bcf699[tag])) {
        foreach(fx in self.var_a7bcf699[tag]) {
          stopfx(name, fx);
        }
      }

      self.var_a7bcf699[tag] = [];
      self.var_a7bcf699[tag][self.var_a7bcf699[tag].size] = playFX(name, level._effect[tag], self gettagorigin("j_ball_ri"));
      break;
    case # "crab_bubbles":
      if(isDefined(self.var_a7bcf699[tag])) {
        foreach(fx in self.var_a7bcf699[tag]) {
          stopfx(name, fx);
        }
      }

      self.var_a7bcf699[tag] = [];

      if(!isDefined(self.var_8d26e38d)) {
        self.var_8d26e38d = self.origin + (16, 0, 0) + anglesToForward(self.angles) * 16;
        self.var_f5ec511d = anglesToForward(self.angles + (0, -135, 0));
      }

      self.var_a7bcf699[tag][self.var_a7bcf699[tag].size] = playFX(name, level._effect[tag], self.var_8d26e38d, self.var_f5ec511d);
      break;
  }
}

function function_918c5de1(origin, count = 3, dir) {
  while(count) {
    if(!isDefined(dir)) {
      dir = (level.var_45fa1b3d + (randomfloatrange(level.var_be2bb100 * -1 - count, level.var_be2bb100 + count), randomfloatrange(level.var_be2bb100 * -1 - count, level.var_be2bb100 + count), randomintrange(level.var_e696e731 * -1 - count, level.var_e696e731 + count))) * level.var_49fcf1d9;
    }

    model = level.var_48152abe[randomint(level.var_48152abe.size)];
    launchorigin = origin + (randomintrange(-12, 12), randomintrange(-12, 12), randomintrange(-40, 12));
    createdynentandlaunch(0, model, launchorigin, (0, 0, 0), launchorigin, dir, level._effect[#"gibtrail_fx"], 1);
    count--;
  }
}

function annihilate(localclientnum) {
  gibclientutils::cliententgibannihilate(localclientnum, self);
}

function zombie_gut_explosion(localclientnum) {
  if(isDefined(level._effect[#"zombie_guts_explosion"]) && util::is_mature()) {
    where = self gettagorigin("J_SpineLower");

    if(!isDefined(where)) {
      where = self.origin;
    }

    playFX(localclientnum, level._effect[#"zombie_guts_explosion"], where);
    level thread function_918c5de1(where, 6);
  }
}

function function_e5d3c2b4(localclientnum) {
  if(isDefined(level._effect[#"zombie_guts_explosion"]) && util::is_mature()) {
    where = self gettagorigin("J_SpineLower");

    if(!isDefined(where)) {
      where = self.origin;
    }

    playFX(localclientnum, level._effect[#"zombie_guts_explosion"], where);
    level thread function_918c5de1(where);
  }
}

function function_96d7f2e2(localclientnum) {
  if(isDefined(level._effect[#"gif_fx"]) && util::is_mature()) {
    where = self gettagorigin("J_SpineLower");

    if(!isDefined(where)) {
      where = self.origin;
    }

    playFX(localclientnum, level._effect[#"gif_fx"], where);
    level thread function_918c5de1(where, 5);
  }
}

function zombie_wait_explode(localclientnum) {
  where = self gettagorigin("J_SpineLower");

  if(!isDefined(where)) {
    where = self.origin;
  }

  start = gettime();

  while(gettime() - start < 2000) {
    if(isDefined(self)) {
      where = self gettagorigin("J_SpineLower");

      if(!isDefined(where)) {
        where = self.origin;
      }
    }

    wait 0.05;
  }

  if(isDefined(level._effect[#"zombie_guts_explosion"]) && util::is_mature()) {
    playFX(localclientnum, level._effect[#"zombie_guts_explosion"], where);
  }
}

function zombie_chunk(localclientnum) {
  if(isDefined(level._effect[#"zombie_guts_explosion"]) && util::is_mature()) {
    where = self gettagorigin("J_SpineLower");

    if(!isDefined(where)) {
      where = self.origin;
    }

    playFX(localclientnum, level._effect[#"zombie_guts_explosion"], where);
    level thread function_918c5de1(where, 1);
  }
}

function function_9b1a8f91(localclientnum, mask = randomint(1 << level.var_8056ac44.size)) {
  for(idx = 0; mask > 0; idx++) {
    if(mask & 1) {
      util::playFXOnTag(localclientnum, isDefined(self.var_600c0020) ? self.var_600c0020[idx] : level.var_8056ac44[idx], self, level.var_75aaaa81[idx]);
    }

    mask >>= 1;
  }
}

function function_8fd3b08d(localclientnum, mask) {
  if(!self hasdobj(localclientnum)) {
    return;
  }

  if(!isDefined(self.var_48dac788)) {
    self.var_48dac788 = 0;
  }

  if(gettime() < self.var_48dac788) {
    return;
  }

  self.var_48dac788 = gettime() + getdvarint(#"hash_75f1994694418afc", 1500);
  self function_9b1a8f91(localclientnum, mask);
}