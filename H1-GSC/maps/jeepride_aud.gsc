/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\jeepride_aud.gsc
********************************/

main() {
  config_system();
  init_snd_flags();
  init_globals();
  launch_threads();
  launch_loops();
  thread launch_line_emitters();
  create_level_envelop_arrays();
  precache_presets();
  register_snd_messages();
}

config_system() {
  soundscripts\_audio::set_stringtable_mapname("shg");
  soundscripts\_snd_filters::snd_set_occlusion("med_occlusion");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_jeepride_global");
  level.player disablefocus(0);
  soundsettimescalefactor("music", 0);
  soundsettimescalefactor("foley", 0.2);
}

init_snd_flags() {}

init_globals() {}

launch_threads() {
  thread jeepride_intro_start();
  thread start_scripted_sfx_node();
  thread monitor_end_chase_music();
  thread play_hind_first_arrival();
  thread play_hind_post_tanker_explosion();
  thread play_hind_open_tunnel_arrival();
  thread play_hind_last_tunnel_scripted_sfx();
  common_scripts\utility::array_thread(getvehiclenodearray("presideswipe", "script_noteworthy"), ::presideswipe);
}

launch_loops() {}

launch_line_emitters() {
  wait 0.1;
}

create_level_envelop_arrays() {}

precache_presets() {}

register_snd_messages() {
  soundscripts\_snd::snd_register_message("snd_zone_handler", ::zone_handler);
  soundscripts\_snd::snd_register_message("snd_music_handler", ::music_handler);
  soundscripts\_snd::snd_register_message("aud_start_checkpoint", ::aud_start_checkpoint);
  soundscripts\_snd::snd_register_message("aud_first_hind_checkpoint", ::aud_first_hind_checkpoint);
  soundscripts\_snd::snd_register_message("aud_against_traffic_checkpoint", ::aud_against_traffic_checkpoint);
  soundscripts\_snd::snd_register_message("aud_final_stretch_checkpoint", ::aud_final_stretch_checkpoint);
  soundscripts\_snd::snd_register_message("aud_bridge_explode_checkpoint", ::aud_bridge_explode_checkpoint);
  soundscripts\_snd::snd_register_message("aud_bridge_combat_checkpoint", ::aud_bridge_combat_checkpoint);
  soundscripts\_snd::snd_register_message("aud_bridge_zak_checkpoint", ::aud_bridge_zak_checkpoint);
  soundscripts\_snd::snd_register_message("aud_bridge_rescue_checkpoint", ::aud_bridge_rescue_checkpoint);
  soundscripts\_snd::snd_register_message("aud_nowhere_checkpoint", ::aud_nowhere_checkpoint);
  soundscripts\_snd::snd_register_message("remove_intro_mute", ::remove_intro_mute);
  soundscripts\_snd::snd_register_message("clear_whitescreen_mix", ::clear_whitescreen_mix);
  soundscripts\_snd::snd_register_message("start_bridge_collapse_mix", ::start_bridge_collapse_mix);
  soundscripts\_snd::snd_register_message("start_post_bridge_explosion", ::start_post_bridge_explosion);
  soundscripts\_snd::snd_register_message("stop_post_bridge_explosion", ::stop_post_bridge_explosion);
  soundscripts\_snd::snd_register_message("aud_start_slowmo_mix", ::aud_start_slowmo_mix);
  soundscripts\_snd::snd_register_message("start_hind_shoots_the_tanker_mix", ::start_hind_shoots_the_tanker_mix);
  soundscripts\_snd::snd_register_message("start_rescue_mix", ::start_rescue_mix);
  soundscripts\_snd::snd_register_message("start_last_whitescreen_mix", ::start_last_whitescreen_mix);
}

zone_handler(var_0, var_1) {}

music_handler(var_0, var_1) {}

aud_start_checkpoint(var_0) {
  soundscripts\_audio_mix_manager::mm_add_submix("jeep_ride_mix");
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("exterior", undefined);
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

aud_first_hind_checkpoint(var_0) {
  soundscripts\_audio_mix_manager::mm_add_submix("jeep_ride_mix");
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("exterior", undefined);
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

aud_against_traffic_checkpoint(var_0) {
  soundscripts\_audio_mix_manager::mm_add_submix("jeep_ride_mix");
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("exterior", undefined);
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

aud_final_stretch_checkpoint(var_0) {
  soundscripts\_audio_mix_manager::mm_add_submix("jeep_ride_mix");
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("exterior", undefined);
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

aud_bridge_explode_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("exterior", undefined);
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

aud_bridge_combat_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

aud_bridge_zak_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

aud_bridge_rescue_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

aud_nowhere_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

remove_intro_mute() {
  soundscripts\_audio_mix_manager::mm_clear_submix("jeepride_intro_mute");
}

clear_whitescreen_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("whitescreen_mix");
}

start_hind_shoots_the_tanker_mix() {
  level.player playsound("scn_last_hind_flyby_boom");
  soundscripts\_audio_mix_manager::mm_add_submix("hind_shoots_the_tanker_mix");
}

aud_start_slowmo_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("hind_shoots_the_tanker_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("slow_motion_mix");
  level.player thread maps\_utility::play_sound_on_entity("scn_player_tanker_explo_wake_up");
}

start_rescue_mix() {
  wait 0.5;
  soundscripts\_audio_mix_manager::mm_clear_submix("slow_motion_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("rescue_mix");
}

start_bridge_collapse_mix() {
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("exterior", "ambient_jeepride_ext1", 0.1);
  soundscripts\_audio_mix_manager::mm_clear_submix("bridge_uaz_crash_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("bridge_collapsing_mix");
  thread handle_bridge_collapse_mix();
  level.player thread maps\_utility::play_sound_on_entity("scn_bridge_collapse");
}

handle_bridge_collapse_mix() {
  var_0 = getent("remove_bridge_collapse_mix", "targetname");
  var_0 waittill("trigger", var_1);
  soundscripts\_audio_mix_manager::mm_clear_submix("bridge_collapsing_mix");
}

start_post_bridge_explosion() {
  soundscripts\_audio_zone_manager::azm_set_filter_bypass(1);
  soundscripts\_snd_filters::snd_fade_in_filter("post_bridge_exp_filter", 0.5);
  level.player thread common_scripts\utility::play_loop_sound_on_entity("flashbang_tinnitus_loop", undefined, 0.5, 2);
}

stop_post_bridge_explosion() {
  soundscripts\_snd_filters::snd_fade_out_filter(4);
  level.player common_scripts\utility::stop_loop_sound_on_entity("flashbang_tinnitus_loop");
  wait 4;
  soundscripts\_audio_zone_manager::azm_set_filter_bypass(0);
}

start_last_whitescreen_mix() {
  wait 0.3;
  level.player thread maps\_utility::play_sound_on_entity("scn_last_whitescreen_stinger");
  soundscripts\_audio_mix_manager::mm_clear_submix("rescue_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("last_whitescreen_mix");
}

jeepride_intro_start() {
  common_scripts\utility::flag_wait("introscreen_activate");
  soundscripts\_audio_mix_manager::mm_add_submix("jeepride_intro_mute");
  soundscripts\_audio_mix_manager::mm_add_submix("whitescreen_mix");
}

start_scripted_sfx_node() {
  var_0 = [["auto1593", "scn_start_jeep_honk_crash", undefined, undefined, undefined],
    ["auto1585", "scn_start_car_honk_crash", undefined, undefined, undefined],
    ["sideswipe_bmp_accelerate_01", "scn_sideswipe_bmp_accelerate_01", undefined, "bmp_accelerate_mix", undefined],
    ["auto1721", "scn_bmp_accelerate_01", undefined, "bmp_accelerate_mix", undefined],
    ["auto1746", "scn_bmp_accelerate_02", undefined, undefined, "bmp_accelerate_mix"],
    ["auto63", undefined, undefined, "first_hind_mix", undefined],
    ["auto3651", undefined, undefined, "tanker_explode_mix", undefined],
    ["auto3740", undefined, undefined, undefined, "tanker_explode_mix"],
    ["auto72", undefined, undefined, "car_passby_mix", undefined],
    ["auto2379", undefined, undefined, undefined, "car_passby_mix"],
    ["auto2637", undefined, undefined, undefined, "first_hind_mix"],
    ["auto4115", "scn_uaz_convoy_arrival_01", undefined, undefined, undefined],
    ["auto4059", "scn_uaz_convoy_arrival_02", undefined, undefined, undefined],
    ["auto4088", "scn_uaz_convoy_arrival_03", undefined, undefined, undefined]
  ];

  foreach(var_2 in var_0)
  thread handle_scripted_sfx_node(var_2);
}

handle_scripted_sfx_node(var_0) {
  var_1 = getvehiclenode(var_0[0], "targetname");
  var_1 waittill("trigger", var_2);

  if(isdefined(var_0[1]))
    var_2 playsound(var_0[1]);

  if(isdefined(var_0[2]))
    var_2 stopsound(var_0[2]);

  if(isdefined(var_0[3]))
    soundscripts\_audio_mix_manager::mm_add_submix(var_0[3]);

  if(isdefined(var_0[4]))
    soundscripts\_audio_mix_manager::mm_clear_submix(var_0[4]);
}

presideswipe() {
  self waittill("trigger", var_0);
  var_0 thread maps\_utility::play_sound_on_entity("scn_jeepride_presideswipe");
}

start_player_jeep_sfx() {
  self vehicle_turnengineoff();
  thread maps\_utility::play_loop_sound_on_tag("scn_jeep_player_front", "tag_hood", 1, 1);
  thread maps\_utility::play_loop_sound_on_tag("scn_jeep_player_back", "tag_bumper_back", 1, 1);
  thread maps\_utility::play_loop_sound_on_tag("scn_jeep_player_center", "tag_body", 1, 1);
}

stop_unimportant_vehicle() {
  switch (self.classname) {
    case "script_vehicle_bm21_mobile_bed_destructible":
    case "script_vehicle_bm21_cover_destructible":
    case "script_vehicle_small_wagon_white":
    case "script_vehicle_small_hatchback_turq":
    case "script_vehicle_pickup_roobars":
    case "script_vehicle_pickup_4door":
    case "script_vehicle_80s_wagon1_tan_destructible":
    case "script_vehicle_80s_wagon1_green_destructible":
    case "vehicle_80s_hatch1_silv_destructible":
    case "script_vehicle_bus":
    case "script_vehicle_tanker_truck_civ":
    case "script_vehicle_luxurysedan":
      self.script_disablevehicleaudio = 1;
      self vehicle_turnengineoff();
      break;
  }
}

passby_sfx() {
  self endon("death");

  switch (self.vehicletype) {
    case "uaz":
    case "mi17":
    case "mi28":
    case "hind":
      return;
  }

  while (!vehicleisclose(self, level.playersride))
    wait 0.05;

  if(targetisinfront(level.playersride, self))
    thread maps\_utility::play_sound_on_entity(passby_get_aliases());
}

targetisinfront(var_0, var_1) {
  var_2 = anglestoforward(var_0.angles);
  var_3 = var_1.origin - var_0.origin;
  var_4 = vectordot(var_2, var_3);
  return var_4 > 0;
}

vehicleisclose(var_0, var_1) {
  if(!targetisinfront(var_0, var_1))
    return 0;

  var_2 = distance(var_0.origin, var_1.origin);
  var_3 = 4800;

  if(isdefined(var_0.veh_speed) && var_0.veh_speed > 0) {
    var_4 = var_0.veh_speed * 63360 / 60 / 60;
    var_5 = level.playersride.veh_speed * 63360 / 60 / 60;
    var_3 = var_4 * 2.3 + var_5 * 2.3;
  }

  return var_2 < var_3;
}

passby_get_aliases() {
  switch (self.vehicletype) {
    case "bus":
    case "tanker":
    case "van":
    case "bm21_troops":
    case "bmp":
      return "veh_van_passby";
    case "small_wagon":
    case "80s_wagon1":
    case "truck":
      return "veh_truck_passby";
    default:
      return "veh_car_passby";
  }
}

start_bridge_uaz_crash() {
  soundscripts\_audio_mix_manager::mm_clear_submix("jeep_ride_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("bridge_uaz_crash_mix");
}

monitor_end_chase_music() {
  var_0 = getvehiclenode("auto231", "targetname");
  var_0 waittill("trigger", var_1);
  wait 2;
  common_scripts\utility::flag_set("music_chase_end");
}

play_hind_first_arrival() {
  var_0 = getent("auto2140", "targetname");
  var_0 waittill("trigger", var_1);
  var_1 thread maps\_utility::play_sound_on_entity("scn_hind_first_appear");
}

play_hind_post_tanker_explosion() {
  var_0 = getent("auto2498", "targetname");
  var_0 waittill("trigger", var_1);
  var_1 thread maps\_utility::play_sound_on_entity("scn_hind_post_tanker_explosion");
}

play_hind_open_tunnel_arrival() {
  var_0 = getvehiclenode("auto135", "targetname");
  var_1 = var_0.script_vehiclespawngroup;
  var_0 waittill("trigger", var_2);
  wait 0.1;
  var_2 play_scripted_sfx_on_vehicle_spawn("scn_hind_open_tunnel_appear", "script_vehicle_mi24p_hind_woodland", var_1, 0.8);
}

play_hind_last_tunnel_scripted_sfx() {
  var_0 = getvehiclenode("auto174", "targetname");
  var_1 = var_0.script_vehiclespawngroup;
  var_0 waittill("trigger", var_2);
  wait 0.1;
  var_2 play_scripted_sfx_on_vehicle_spawn("scn_hind_last_tunnel_appear", "script_vehicle_mi24p_hind_woodland", var_1);
}

play_mi17_scripted_sequence() {
  thread play_mi17_unload_ennemies("auto4413", "auto4416", 1);
  thread play_mi17_unload_ennemies("auto5018", "auto5020", 2);
}

play_bm21_unload_troops_sequence() {
  var_0 = getvehiclenode("auto4032", "targetname");
  var_1 = getvehiclenode("auto4038", "targetname");
  var_0 waittill("trigger", var_2);
  var_2 vehicle_turnengineoff();
  var_2.script_disablevehicleaudio = 1;
  var_2 thread maps\_utility::play_sound_on_tag_endon_death("scn_bm21_unload_arrival_01");
  var_1 waittill("trigger", var_2);
  var_2 thread common_scripts\utility::play_loop_sound_on_entity("bm21_idle_low", undefined, 0.5, 0.5);
  var_2 waittill("unloaded");
  var_2 thread common_scripts\utility::stop_loop_sound_on_entity("bm21_idle_low");
  var_2 thread maps\_utility::play_sound_on_tag_endon_death("scn_bm21_unload_leaving_01");
}

play_mi17_unload_ennemies(var_0, var_1, var_2) {
  var_3 = getent(var_0, "targetname");
  var_4 = getent(var_1, "targetname");
  var_3 waittill("trigger", var_5);
  var_5 vehicle_turnengineoff();
  var_5.script_disablevehicleaudio = 1;
  var_5 thread maps\_utility::play_sound_on_tag_endon_death("scn_mi17_unload_arrival_0" + var_2);
  var_4 waittill("trigger", var_5);
  var_5 thread common_scripts\utility::play_loop_sound_on_entity("mi17_close_towards_lp", undefined, 0.5, 0.5);
  var_5 waittill("unloaded");
  var_5 thread common_scripts\utility::stop_loop_sound_on_entity("mi17_close_towards_lp");
  var_5 thread maps\_utility::play_sound_on_tag_endon_death("scn_mi17_unload_leaving_0" + var_2);
}

play_last_hind_flyby() {
  wait 0.1;
  play_scripted_sfx_on_vehicle_spawn("scn_last_hind_flyby", "script_vehicle_mi24p_hind_woodland", 72);
}

play_scripted_sfx_on_vehicle_spawn(var_0, var_1, var_2, var_3) {
  var_4 = maps\_utility::getvehiclearray();

  foreach(var_6 in var_4) {
    if(var_6.classname == var_1 && isdefined(var_6.script_vehiclespawngroup) && var_6.script_vehiclespawngroup == var_2) {
      if(isdefined(var_3))
        wait(var_3);

      var_6 thread maps\_utility::play_sound_on_tag_endon_death(var_0);
      return;
    }
  }
}

play_zak_enemy_heli_sfx() {
  wait 0.1;
  self.script_disablevehicleaudio = 1;
  self vehicle_turnengineoff();
  thread maps\_utility::play_sound_on_tag_endon_death("scn_zak_enemy_hind_arrival");
}

play_zak_ally_heli_sfx() {
  wait 0.1;
  thread maps\_utility::play_sound_on_tag_endon_death("scn_zak_ally_hind_arrival");
}

crossroad_crash(var_0) {
  var_0 thread maps\_utility::play_sound_on_tag("scn_bmp_ravine_flipcontact", "body_animate_jnt");
}

truck_tanker_crash(var_0) {
  var_0 thread maps\_utility::play_sound_on_tag("scn_tanker_truck_crash", "body_animate_jnt");
}

tanker_tanker_crash(var_0) {
  var_0 thread maps\_utility::play_sound_on_tag("scn_tanker_tanker_crash", "body_animate_jnt");
}

tunnel_crash_truck01(var_0) {
  var_0 thread maps\_utility::play_sound_on_tag("scn_bmp_front_tunnel_crash", "body_animate_jnt");
}

tunnel_crash_truck02(var_0) {
  soundscripts\_audio_mix_manager::mm_clear_submix("bmp_accelerate_mix");
  var_0 thread maps\_utility::play_sound_on_tag("scn_bmp_first_tunnel_crash_01", "body_animate_jnt");
  var_0 stopsound("scn_sideswipe_bmp_accelerate_01");
}

play_bridge_collapse_sfx(var_0, var_1) {
  var_0 thread maps\_utility::play_sound_on_tag("scn_bridge_collapse_" + var_1, "j_chunk_" + var_1);
}

play_anim_vehicle_explosion_sfx(var_0, var_1) {
  var_0 thread maps\_utility::play_sound_on_tag(var_1, "body_animate_jnt");
}