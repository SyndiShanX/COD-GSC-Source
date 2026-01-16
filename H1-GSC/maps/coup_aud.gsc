/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\coup_aud.gsc
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
  thread intro_start();
}

config_system() {
  soundscripts\_audio::set_stringtable_mapname("shg");
  soundscripts\_snd_filters::snd_set_occlusion("med_occlusion");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_coup_global");
}

init_snd_flags() {
  common_scripts\utility::flag_init("music_part2");
  common_scripts\utility::flag_init("music_part3");
  common_scripts\utility::flag_init("music_part4");
}

init_globals() {}

launch_threads() {
  thread handle_heli_scripted_sfx();
  thread aud_first_bmp();
  thread aud_jeep_event();
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
  soundscripts\_snd::snd_register_message("start_intro_checkpoint", ::start_intro_checkpoint);
  soundscripts\_snd::snd_register_message("start_drive_checkpoint", ::start_drive_checkpoint);
  soundscripts\_snd::snd_register_message("start_doorkick_checkpoint", ::start_doorkick_checkpoint);
  soundscripts\_snd::snd_register_message("start_trashstumble_checkpoint", ::start_trashstumble_checkpoint);
  soundscripts\_snd::snd_register_message("start_runners2_checkpoint", ::start_runners2_checkpoint);
  soundscripts\_snd::snd_register_message("start_alley_checkpoint", ::start_alley_checkpoint);
  soundscripts\_snd::snd_register_message("start_shore_checkpoint", ::start_shore_checkpoint);
  soundscripts\_snd::snd_register_message("start_carexit_checkpoint", ::start_carexit_checkpoint);
  soundscripts\_snd::snd_register_message("start_ending_checkpoint", ::start_ending_checkpoint);
  soundscripts\_snd::snd_register_message("aud_coup_car_open", ::aud_coup_car_open);
  soundscripts\_snd::snd_register_message("aud_coup_enter_car", ::aud_coup_enter_car);
  soundscripts\_snd::snd_register_message("aud_coup_exit_car", ::aud_coup_exit_car);
  soundscripts\_snd::snd_register_message("aud_coup_car_thrown_out", ::aud_coup_car_thrown_out);
  soundscripts\_snd::snd_register_message("aud_exterior_to_bunker", ::aud_exterior_to_bunker);
  soundscripts\_snd::snd_register_message("aud_bunker_to_exterior", ::aud_bunker_to_exterior);
  soundscripts\_snd::snd_register_message("start_slowmo_mix", ::start_slowmo_mix);
  soundscripts\_snd::snd_register_message("stop_slowmo_mix", ::stop_slowmo_mix);
  soundscripts\_snd::snd_register_message("start_coup_player_death_mix", ::start_coup_player_death_mix);
  soundscripts\_snd::snd_register_message("aud_add_stunned_car_event", ::aud_add_stunned_car_event);
  soundscripts\_snd::snd_register_message("aud_stop_stunned_car_event", ::aud_stop_stunned_car_event);
  soundscripts\_snd::snd_register_message("aud_car_sound_node_spawner", ::aud_car_sound_node_spawner);
  soundscripts\_snd::snd_register_message("aud_shutoff_engine", ::aud_shutoff_engine);
}

zone_handler(var_0, var_1) {}

music_handler(var_0, var_1) {}

start_intro_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_drive_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("interior_vehicle");
}

start_doorkick_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("interior_vehicle");
}

start_trashstumble_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("interior_vehicle");
}

start_runners2_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("interior_vehicle");
}

start_alley_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("interior_vehicle");
}

start_shore_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("interior_vehicle");
}

start_carexit_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("interior_vehicle");
}

start_ending_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

intro_start() {
  common_scripts\utility::flag_wait("introscreen_activate");
  soundscripts\_audio_mix_manager::mm_add_submix("coup_intro_mute");
  intro_check_end();
}

intro_check_end() {
  common_scripts\utility::flag_wait("introscreen_remove_submix");
  soundscripts\_audio_mix_manager::mm_clear_submix("coup_intro_mute", 1);
}

aud_coup_enter_car() {
  soundscripts\_audio_zone_manager::azm_stop_zone("exterior", 0.3);
  soundscripts\_audio_zone_manager::azm_start_zone("interior_vehicle", 0.3);
}

aud_coup_exit_car() {
  soundscripts\_audio_zone_manager::azm_stop_zone("interior_vehicle", 0.3);
  soundscripts\_audio_zone_manager::azm_start_zone("interior_vehicle_open", 0.3);
}

aud_coup_car_open() {
  soundscripts\_audio_zone_manager::azm_stop_zone("exterior", 0.3);
  soundscripts\_audio_zone_manager::azm_stop_zone("interior_vehicle", 0.3);
  soundscripts\_audio_zone_manager::azm_start_zone("interior_vehicle_open", 0.3);
}

aud_coup_car_thrown_out() {
  soundscripts\_audio_zone_manager::azm_stop_zone("interior_vehicle_open", 0.3);
  soundscripts\_audio_zone_manager::azm_start_zone("exterior", 0.3);
}

aud_exterior_to_bunker() {
  soundscripts\_audio_zone_manager::azm_stop_zone("exterior", 0.3);
  soundscripts\_audio_zone_manager::azm_start_zone("bunker", 0.3);
}

aud_bunker_to_exterior() {
  soundscripts\_audio_zone_manager::azm_stop_zone("bunker", 5.5);
  soundscripts\_audio_zone_manager::azm_start_zone("exterior", 5.5);
}

start_slowmo_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("dead_man_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("slowmo_mix");
}

stop_slowmo_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("slowmo_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("getting_shot_mix");
}

start_coup_player_death_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("getting_shot_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("coup_player_death_mix");
}

aud_add_stunned_car_event() {
  soundscripts\_audio_mix_manager::mm_add_submix("stunned_car_mix");
}

aud_stop_stunned_car_event() {
  soundscripts\_audio_mix_manager::mm_clear_submix("stunned_car_mix");
}

aud_curb_stomp_event() {
  wait 0.7;
  soundscripts\_audio_mix_manager::mm_clear_submix("engine_shutoff_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("curb_stomp_mix");
  wait 2.5;
  soundscripts\_audio_mix_manager::mm_clear_submix("curb_stomp_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("dead_man_mix");
}

handle_heli_scripted_sfx() {
  var_0 = common_scripts\utility::getstruct("auto2187", "targetname");
  var_1 = common_scripts\utility::getstruct("auto2712", "targetname");
  var_2 = common_scripts\utility::getstruct("auto2718", "targetname");
  var_3 = common_scripts\utility::getstruct("auto2601", "targetname");
  var_0 thread heli_scripted_sfx("scn_hind_passby_01", "unloaded");
  var_1 thread heli_scripted_sfx("scn_hind_passby_02");
  var_2 thread heli_scripted_sfx("scn_hind_passby_03");
  var_3 thread heli_scripted_sfx("scn_hind_passby_04", "unloaded");
  var_4 = getent("alleyway_hind1_trigger", "targetname");
  var_4 thread three_heli_passby_trig("scn_alleyway_hind1_0");
  var_5 = getent("alleyway_hind2_trigger", "targetname");
  var_5 thread three_heli_passby_trig("scn_alleyway_hind2_0");
}

heli_scripted_sfx(var_0, var_1) {
  self waittill("trigger", var_2);

  if(isdefined(var_1))
    var_2 waittill(var_1);

  var_2 play_helicopter_scripted_sfx(var_0);
}

three_heli_passby_trig(var_0) {
  var_1 = self.script_vehiclespawngroup;
  self waittill("trigger", var_2);
  wait 0.1;
  var_3 = maps\_utility::getvehiclearray();
  var_4 = 1;

  foreach(var_6 in var_3) {
    if(var_6.classname == "script_vehicle_mi24p_hind_desert" && isdefined(var_6.script_vehiclespawngroup) && var_6.script_vehiclespawngroup == var_1) {
      var_6 play_helicopter_scripted_sfx(var_0 + var_4);
      var_4++;
    }
  }
}

aud_jeep_event() {
  var_0 = getvehiclenode("auto2734", "targetname");
  var_0 waittill("trigger", var_1);
  var_1 thread maps\_utility::play_sound_on_entity("scn_coup_jeep_hard_turn");
}

play_helicopter_scripted_sfx(var_0) {
  self.script_disablevehicleaudio = 1;
  self vehicle_turnengineoff();
  thread maps\_utility::play_sound_on_entity(var_0);
}

aud_car_sound_node_spawner() {
  level.car_move_engine_sound_node = spawn("script_origin", level.car.origin);
  level.car_idle_engine_sound_node = spawn("script_origin", level.car.origin);
  level.car_move_engine_sound_node linkto(level.car);
  level.car_idle_engine_sound_node linkto(level.car);
}

aud_car_event_handler(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isdefined(var_5))
    soundscripts\_audio_mix_manager::mm_add_submix(var_5);

  thread aud_car_engine_idle_handler(var_0, var_1, var_2, var_3, var_4);
  self scalepitch(var_0, var_1);
  wait(var_2 + var_1);
  self scalepitch(var_3, var_4);
  wait(var_4);

  if(isdefined(var_5))
    soundscripts\_audio_mix_manager::mm_clear_submix(var_5);
}

aud_car_engine_idle_handler(var_0, var_1, var_2, var_3, var_4) {
  level.car_idle_engine_sound_node scalevolume(0, 0);
  waitframe();
  level.car_idle_engine_sound_node playloopsound("scn_coup_car_idle_engine");
  level.car_idle_engine_sound_node scalevolume(0.71, var_1);
  level.car_idle_engine_sound_node scalepitch(var_0, var_1);
  wait(var_2 + var_1);
  level.car_idle_engine_sound_node scalevolume(0, var_4);
  level.car_idle_engine_sound_node scalepitch(var_3, var_4);
  wait(var_4);
  level.car_idle_engine_sound_node stoploopsound("scn_coup_car_idle_engine");
}

aud_play_engine(var_0, var_1) {
  self playsound("scn_coup_car_move_engine_" + var_1);
}

aud_stop_engine(var_0, var_1) {
  self scalevolume(0, var_1);
  wait(var_1);
  self stopsound("scn_coup_car_move_engine_" + var_0);
  self scalevolume(1, 1);
}

aud_shutoff_engine() {
  wait 1.0;
  soundscripts\_audio_mix_manager::mm_add_submix("engine_shutoff_mix");
  level.car_move_engine_sound_node playsound("scn_coup_engine_shutoff");
  level.car_move_engine_sound_node thread aud_stop_engine("02", 1);
}

aud_music_handler() {
  maps\_utility::musicplaywrapper("music_coup_intro_01");
  common_scripts\utility::flag_wait("music_part2");
  wait 1.5;
  maps\_utility::music_stop(1.0);
  maps\_utility::musicplaywrapper("music_coup_intro_02");
  common_scripts\utility::flag_wait("music_part3");
  wait 8.0;
  maps\_utility::music_crossfade("music_coup_intro_03", 1.0);
  common_scripts\utility::flag_wait("music_part4");
  wait 1.5;
  maps\_utility::music_stop(1.0);
  maps\_utility::musicplaywrapper("music_coup_intro_04");
}

aud_first_bmp() {
  var_0 = getvehiclenode("auto707", "targetname");
  var_0 waittill("trigger", var_1);
  var_1 thread maps\_utility::play_sound_on_entity("scn_coup_first_bmp");
}