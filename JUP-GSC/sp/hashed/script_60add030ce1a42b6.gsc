/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_60add030ce1a42b6.gsc
*************************************************/

#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\vehicle_aianim;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\utility;
#namespace namespace_93635c21ec57253a;

function main() {
  level flag_init("flg_audio_underwater_sfx_playing");
}

function function_8fc9d6fd2773cfb3() {
  level.player setsoundsubmix("sp_jup_tundra_intro", 0);
  level waittill("audio_underwater_intro_mute_clear");
  thread function_5b29597b2f23102e();
  thread function_669c5b581f579331();
  level.player playSound("evt_jup_tun_intro_submerge_stringer_lr");
  level.player clearsoundsubmix("sp_jup_tundra_intro", 0.5);
}

function function_3cb460d33aaa813e() {
  level.player setsoundsubmix("sp_jup_tun_underwater_intro_mus");
}

function function_5b29597b2f23102e() {
  level.player setsoundsubmix("sp_jup_tun_underwater_mix", 0);
  level waittill("uw_audio_cleanup");
  level.player clearsoundsubmix("sp_jup_tun_underwater_mix", 0.25);
}

function function_669c5b581f579331() {
  wait 16;
  level.player playSound("tun_underwater_scripted_ice_cracks_01_lr");
  wait 10;
  level.player playSound("tun_underwater_scripted_ice_cracks_02_lr");
  wait 11.9;
  level.player playSound("tun_underwater_scripted_ice_cracks_03_lr");
}

function function_5510625cf2daa2bb() {
  thread intro_ice_cracks();
  wait 1.5;
  level.player playSound("evt_tun_underwater_car_engines_approach");
  level waittill("audio_stop_underwater_vehicles");
  level.player setsoundsubmix("sp_jup_tundra_underwater_vehicle", 4);
  wait 10;
  level.player clearsoundsubmix("sp_jup_tundra_underwater_vehicle");
}

function intro_ice_cracks() {
  play_sound_in_space("tun_underwater_intro_ice_cracks", (81754, -625, 615));
}

function function_a3f4f9c3f405b0c0() {
  level.player setsoundsubmix("sp_jup_tundra_underwater_explosion", 0.5);
  thread play_sound_in_space("exp_tun_underwater_explo_01", (81884, -1287, 615));
  wait 0.6;
  thread play_sound_in_space("exp_tun_underwater_explo_02", (81837, -970, 615));
  wait 0.7;
  thread function_73d7681781ebb6e8();
  thread play_sound_in_space("exp_tun_underwater_explo_03_body", (81754, -625, 615));
  level notify("audio_stop_underwater_vehicles");
  wait 5;
  level.player clearsoundsubmix("sp_jup_tundra_underwater_explosion", 2);
}

function function_73d7681781ebb6e8() {
  wait 0.2;
  soundsettimescalefactorfromtable("third_explosion");
  wait 1;
  soundsettimescalefactorfromtable("default");
}

function function_9aa1e57c196d4847() {
  if(level flag("flg_audio_underwater_sfx_playing")) {
    return;
  }

  level flag_set("flg_audio_underwater_sfx_playing");
  thread function_957cf1aa5f6b9c5f();
  thread function_fbc315aaaaa7c6a0();
  thread function_c2f083751f8230d6();
  thread function_65c94ad1dece6d5e();
}

function function_957cf1aa5f6b9c5f() {
  level endon("uw_audio_cleanup");
  wait randomfloatrange(5, 10);

  while(true) {
    dist_x = randomfloatrange(-500, 500);
    dist_y = randomfloatrange(-500, 500);
    dist_z = randomfloatrange(20, 500);
    position = level.player.origin + (dist_x, dist_y, dist_z);
    play_sound_in_space("tun_underwater_amb_ice_cracks_lrg", position);
    wait randomfloatrange(5, 10);
    dist_x = undefined;
    dist_y = undefined;
    dist_z = undefined;
    position = undefined;
    waitframe();
  }
}

function function_fbc315aaaaa7c6a0() {
  level endon("uw_audio_cleanup");
  wait randomfloatrange(10, 15);

  while(true) {
    dist_x = randomfloatrange(-500, 500);
    dist_y = randomfloatrange(-500, 500);
    dist_z = randomfloatrange(20, 500);
    position = level.player.origin + (dist_x, dist_y, dist_z);
    play_sound_in_space("tun_underwater_amb_ice_cracks_sml", position);
    wait randomfloatrange(5, 10);
    dist_x = undefined;
    dist_y = undefined;
    dist_z = undefined;
    position = undefined;
    waitframe();
  }
}

function function_c2f083751f8230d6() {
  level.player endon("death");
  level endon("stop_underwater_breathing");
  level endon("uw_audio_cleanup");
  var_877b978e63de2709 = getStruct("scene_jup_tun_0112_scuba_car1_plyr_takedown", "targetname");
  var_877b978e63de2709 scene::function_8207074e79f22926(level.player, "note_hold_breath", "player");
  var_877b978e63de2709 scene::function_8207074e79f22926(level.player, "note_start_breath", "player");
  var_8772a98e63d42ff1 = getStruct("scene_jup_tun_0130_scuba_plyr_takedown", "targetname");
  var_8772a98e63d42ff1 scene::function_8207074e79f22926(level.player, "note_hold_breath", "player");
  var_8772a98e63d42ff1 scene::function_8207074e79f22926(level.player, "note_start_breath", "player");
  var_8788a78e63ec5ebe = getStruct("scene_jup_tun_0140_scuba_vip_rescue", "targetname");
  var_8788a78e63ec5ebe scene::function_8207074e79f22926(level.player, "note_hold_breath", "Player 1");
  thread underwater_breathing();
  thread function_b1daf17b4376c583();
  flag_wait("flg_allies_veh_refs_created");
  thread function_426b5f7495da6b49();

  while(true) {
    level.player waittill("note_hold_breath");
    level notify("stop_breathing");
    level.player waittill("note_start_breath");
    thread underwater_breathing();
    thread function_b1daf17b4376c583();
    thread function_426b5f7495da6b49();
    wait 1;
  }
}

function underwater_breathing() {
  level.player endon("death");
  level endon("stop_breathing");
  level endon("uw_audio_cleanup");

  while(true) {
    level.player playSound("plr_underwater_scuba_idle_inh", "inhale_done");
    level.player waittill("inhale_done");
    level.player playSound("plr_underwater_scuba_idle_exh", "exhale_done");
    level.player waittill("exhale_done");
    wait 0.5;
  }
}

function function_b1daf17b4376c583() {
  level.player endon("death");
  level endon("stop_breathing");
  level endon("uw_audio_cleanup");
  wait randomfloatrange(15, 20);

  while(true) {
    level.player playSound("plr_underwater_scuba_oxygen");
    wait randomfloatrange(12, 26);
  }
}

function function_426b5f7495da6b49() {
  level.player endon("death");
  level endon("stop_breathing");
  level endon("uw_audio_cleanup");
  allies = [level.ally01, level.ally02];

  foreach(ally in allies) {
    ally thread function_258b04c4146401d6();
  }
}

function function_258b04c4146401d6() {
  level.player endon("death");
  level endon("stop_breathing");
  level endon("uw_audio_cleanup");
  wait randomfloatrange(16, 21);

  while(true) {
    self playSound("npc_underwater_scuba_oxygen");
    wait randomfloatrange(12, 28);
  }
}

function function_65c94ad1dece6d5e() {
  var_8788a78e63ec5ebe = getStruct("scene_jup_tun_0140_scuba_vip_rescue", "targetname");
  var_8788a78e63ec5ebe thread scene::function_8207074e79f22926(level.player, "note_welder_bubbles_sfx_ally", "Player 1");
  var_8788a78e63ec5ebe thread scene::function_8207074e79f22926(level.player, "note_metal_heat_sfx_ally", "Player 1");
  var_8788a78e63ec5ebe thread scene::function_8207074e79f22926(level.player, "note_welder_bubbles_sfx_plr", "Player 1");
  var_8788a78e63ec5ebe thread scene::function_8207074e79f22926(level.player, "note_metal_heat_sfx_plr", "Player 1");
  level.player waittill("note_welder_bubbles_sfx_ally");
  thread play_sound_in_space("emt_tun_underwater_welder_bubbles_ally_01", (81807, -482, 182));
  level.player waittill("note_metal_heat_sfx_ally");
  thread play_sound_in_space("emt_tun_underwater_welder_heat_stress_ally", (81807, -482, 182));
  level.player waittill("note_welder_bubbles_sfx_plr");
  thread play_sound_in_space("emt_tun_underwater_welder_bubbles_plr_01", (81779, -456, 154));
  level.player waittill("note_metal_heat_sfx_plr");
  thread play_sound_in_space("emt_tun_underwater_welder_heat_stress_plr", (81779, -456, 154));
}

function function_26c637b4a0e68843() {
  var_35ba032abdd6e2e8 = getStruct("scene_jup_tun_0140_scuba_vip_rescue", "targetname");
  var_35ba032abdd6e2e8 thread scene::function_8207074e79f22926(level.player, "note_sfx_fade_start", "Player 1");
  level.player waittill("note_sfx_fade_start");
  level.player setsoundsubmix("sp_jup_tundra_fade_to_black_all_except_music", 5);
  level waittill("audio_clear_vip_rescue_mute");
  level.player clearsoundsubmix("sp_jup_tundra_fade_to_black_all_except_music", 1);
}

function function_864a8e9188f7b036() {
  var_7867f48e589b8b2f = getStruct("scene_jup_tun_0200_igc_forest_reveal", "targetname");
  var_7867f48e589b8b2f scene::function_8207074e79f22926(level.player, "note_amb_change_start", "price_igc");
  var_7867f48e589b8b2f scene::function_8207074e79f22926(level.player, "note_amb_change_end", "price_igc");
  price_igc = var_7867f48e589b8b2f scene::get_entity("price_igc");
  level.player playSound("scn_jup_tun_0200_igc_forest_reveal_lr");
  level.player waittill("note_amb_change_start");
  level.player setsoundsubmix("tun_forest_reveal", 0, 1);
  price_igc playLoopSound("amb_tun_clearing_igc_0200_lr");
  level.player waittill("note_amb_change_end");
  price_igc stoploopsound("amb_tun_clearing_igc_0200_lr");
  level.player clearsoundsubmix("tun_forest_reveal", 0.5);
}

function function_df167234b8c47354(bird) {
  level endon("flg_audio_bird_done");
  bird_audio = undefined;
  level.var_72d800ee048c7e49 = 0;
  play_delay = 0;

  while(true) {
    if(level.var_72d800ee048c7e49) {
      play_delay = 0;
      wait randomfloatrange(8, 15);
    } else if(!isDefined(bird_audio)) {
      play_delay -= 0.05;

      if(play_delay <= 0) {
        dist_x = randomfloatrange(-2500, 2500);
        dist_y = randomfloatrange(-2500, 2500);
        dist_z = randomfloatrange(0, 200);
        position = bird + (dist_x, dist_y, dist_z);
        bird_audio = play_sound_in_space("amb_emt_ext_tun_forest_birds", position);
        dist_x = undefined;
        dist_y = undefined;
        dist_z = undefined;
        position = undefined;
        waitframe();
        play_delay = randomfloatrange(4, 15);
      }
    }

    waitframe();
  }
}

function function_af1d28b3257969a7() {
  level endon("flg_audio_bird_done");

  while(true) {
    level.player waittill_any("weapon_fired", "grenade_fire");
    level.var_72d800ee048c7e49 = 1;
    wait randomfloatrange(10, 20);
    level.var_72d800ee048c7e49 = 0;
  }
}

function forest_birds() {
  bird_array = [(6458, -15241, 242), (5515, -13485, 229), (4507, -11710, 458), (3969, -10307, 606), (6086, -6670, 920), (-321, -1546, 1068), (-4632, -485, 1474)];

  foreach(bird in bird_array) {
    wait randomfloatrange(1, 4);
    thread function_df167234b8c47354(bird);
  }

  thread function_af1d28b3257969a7();
}

function function_eaa7e0dde7061f58() {
  level.player setsoundsubmix("sp_jup_tun_vista_heli");
  level waittill("audio_clear_heli_attenuate");
  wait 5;
  level.player clearsoundsubmix("sp_jup_tun_vista_heli");
}

function function_e93afe911221b883() {
  wait 1;
  play_sound_in_space("exp_tun_forest_vista_explo", (-537, -210, 1189));
  flag_set("flg_audio_bird_done");
}

function function_50c54ccefd9163de() {
  level waittill("audio_lumbermill_vehicle_started");
  wait 0.4;
  self playSound("veh_lumbermill_drive_in");
}

function function_163cc1ee70056ff() {
  level waittill("audio_lumbermill_vehicle_started");
  wait 0.1;
  self playSound("veh_lumbermill_drive_in");
}

function function_620ba573390478ce() {
  self playSound("veh_lumbermill_drive_in_back");
}

function function_7f440c78fa69709() {
  a_pos = [0, 1, 2, 3];

  foreach(pos in a_pos) {
    animpos = scripts\common\vehicle_aianim::anim_pos(self, pos);

    if(isDefined(animpos)) {
      animpos.vehicle_getoutsound = "veh_lumbermill_truck_door_open";
    }
  }
}

function function_4e97b1a797add6f0() {
  thread function_9b9d6ffab72245fa();
  level.player setsoundsubmix("tun_cliff_snowdrift", 3);
  level.player playSound("evt_tun_snowdrift_cliff_lr");
  level flag_wait("flag_cliff_snowdrift_off");
  level.player clearsoundsubmix("tun_cliff_snowdrift", 10);
}

function function_9b9d6ffab72245fa() {
  var_7b31cdde6dd7bf88 = spawn_script_origin((740, 7080, -264));
  var_7b31d0de6dd7c621 = spawn_script_origin((-22, 6094, 304));
  var_7b31cdde6dd7bf88 scalevolume(0, 0);
  var_7b31cdde6dd7bf88 scalevolume(1, 2.5);
  var_7b31cdde6dd7bf88 playLoopSound("amb_tun_snowdrift_tree_wind_lp");
  var_7b31d0de6dd7c621 scalevolume(0, 0);
  var_7b31d0de6dd7c621 scalevolume(1, 4.5);
  var_7b31d0de6dd7c621 playLoopSound("amb_tun_snowdrift_tree_wind_lp");
  level flag_wait("flag_cliff_snowdrift_off");
  wait 2;
  var_7b31cdde6dd7bf88 scalevolume(0, 2.5);
  wait 2.5;
  var_7b31cdde6dd7bf88 stoploopsound("amb_tun_snowdrift_tree_wind_lp");
  var_7b31d0de6dd7c621 scalevolume(0, 2.5);
  wait 2.5;
  var_7b31d0de6dd7c621 stoploopsound("amb_tun_snowdrift_tree_wind_lp");
  wait 2.5;
  var_7b31cdde6dd7bf88 delete();
  var_7b31d0de6dd7c621 delete();
}

function function_89261962aa444c35() {
  level.player playSound("evt_tun_snowdrift_shipyard_lr");
}

function function_733b42fe33959ee() {
  self endon("death");
  engine_ent = utility::spawn_script_origin(self.origin);
  engine_ent linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  self playLoopSound("veh_jup_tun_finale_jltv_engine_lp");
  utility::waittill_any_ents(self, "vehicle_near_path_end", level, "flag_" + self.targetname + "_clear");
  engine_ent playSound("veh_jup_tun_veh9_mil_lnd_jltv_engine_shutoff");
  self scalevolume(0, 0.5);
  wait 0.8;
  self stoploopsound("veh_jup_tun_finale_jltv_engine_lp");
  wait 5;
  engine_ent delete();
}

function function_a08690148d25a40e() {
  var_3a465e75b646f5d4 = getStruct("scene_jup_tun_1000_igc_outro", "targetname");
  var_3a465e75b646f5d4 thread scene::function_8207074e79f22926(level, "audio_notify_sh060_heli", "heli");
  level.nikolai_heli playLoopSound("evt_tun_1000_exfil_heli_idle");
  level waittill("audio_notify_sh060_heli");
  level.nikolai_heli scalevolume(0, 1);
  wait 1;
  level.nikolai_heli stoploopsound("evt_tun_1000_exfil_heli_idle");
}

function function_fe45177bf22323f9() {
  level.player setsoundsubmix("sp_jup_tun_level_fade_out", 0.5);
}