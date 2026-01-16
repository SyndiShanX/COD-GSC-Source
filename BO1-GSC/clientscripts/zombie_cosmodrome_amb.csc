/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\zombie_cosmodrome_amb.csc
***************************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_music;
#include clientscripts\_busing;
#include clientscripts\_audio;

main() {
  declareAmbientRoom("cosmo_exterior");
  declareAmbientPackage("cosmo_exterior");
  setAmbientRoomReverb("cosmo_exterior", "flashpoint_outside", 1, 1);
  setAmbientRoomContext("cosmo_exterior", "ringoff_plr", "outdoor");
  declareAmbientRoom("cosmo_centrifuge");
  declareAmbientPackage("cosmo_centrifuge");
  setAmbientRoomReverb("cosmo_centrifuge", "flashpoint_concrete_room", 1, 1);
  setAmbientRoomContext("cosmo_centrifuge", "ringoff_plr", "indoor");
  declareAmbientRoom("cosmo_medium");
  declareAmbientPackage("cosmo_medium");
  setAmbientRoomReverb("cosmo_medium", "flashpoint_facility_tunnel", 1, 1);
  setAmbientRoomContext("cosmo_medium", "ringoff_plr", "indoor");
  declareAmbientRoom("cosmo_partial_metal");
  declareAmbientPackage("cosmo_partial_metal");
  setAmbientRoomReverb("cosmo_partial_metal", "flashpoint_facility_small_b", 1, 1);
  setAmbientRoomContext("cosmo_partial_metal", "ringoff_plr", "outdoor");
  declareAmbientRoom("cosmo_rocket_room");
  declareAmbientPackage("cosmo_rocket_room");
  setAmbientRoomReverb("cosmo_rocket_room", "flashpoint_rocket_pad", 1, 1);
  setAmbientRoomContext("cosmo_rocket_room", "ringoff_plr", "outdoor");
  declareAmbientRoom("cosmo_packa_room");
  declareAmbientPackage("cosmo_packa_room");
  setAmbientRoomReverb("cosmo_packa_room", "flashpoint_drainage_room", 1, 1);
  setAmbientRoomContext("cosmo_packa_room", "ringoff_plr", "indoor");
  activateAmbientPackage(0, "cosmo_exterior", 0);
  activateAmbientRoom(0, "cosmo_exterior", 0);
  declareMusicState("WAVE");
  musicAliasloop("mus_cosmo_underscore", 6, 2);
  declareMusicState("EGG");
  musicAlias("mus_egg", 2);
  declareMusicState("SILENCE");
  musicAlias("null", 1);
  level thread alarm_a_timer();
  level thread alarm_b_timer();
  level thread spawn_fx_loopers();
  level thread play_minigun_loop();
  level thread samantha_is_angry_setup();
}

spawn_fx_loopers() {
  clientscripts\_audio::snd_play_auto_fx("fx_fire_line_xsm", "amb_fire_medium");
  clientscripts\_audio::snd_play_auto_fx("fx_fire_line_sm", "amb_fire_large");
  clientscripts\_audio::snd_play_auto_fx("fx_fire_wall_back_sm", "amb_fire_large");
  clientscripts\_audio::snd_play_auto_fx("fx_fire_destruction_lg", "amb_fire_extreme");
  clientscripts\_audio::snd_play_auto_fx("fx_zmb_fire_sm_smolder", "amb_fire_medium");
  clientscripts\_audio::snd_play_auto_fx("fx_elec_terminal", "amb_break_arc");
  clientscripts\_audio::snd_play_auto_fx("fx_zmb_elec_terminal_bridge", "amb_break_arc");
  clientscripts\_audio::snd_play_auto_fx("fx_zmb_pipe_steam_md", "amb_steam_medium");
  clientscripts\_audio::snd_play_auto_fx("fx_zmb_pipe_steam_md_runner", "amb_steam_medium");
  clientscripts\_audio::snd_play_auto_fx("fx_zmb_steam_hallway_md", "amb_steam_medium");
  clientscripts\_audio::snd_play_auto_fx("fx_zmb_water_spray_leak_sm", "amb_water_spray_small");
}

play_minigun_loop() {
  while(1) {
    level waittill("minis");
    ent = spawn(0, (0, 0, 0), "script_origin");
    ent playLoopSound("zmb_insta_kill_loop");
    level waittill("minie");
    PlaySound(0, "zmb_insta_kill", (0, 0, 0));
    ent stopLoopSound(.5);
    wait(.5);
    ent Delete();
  }
}

alarm_a_timer() {
  level waittill("power_on");
  wait(2.5);
  level thread alarm_a();
  wait(21);
  level notify("alarm_a_Off");
}

alarm_b_timer() {
  level waittill("power_on");
  wait(8.5);
  level thread alarm_b();
}

play_alarm_a() {
  level endon("alarm_a_Off");
  while(1) {
    playsound(0, "evt_alarm_a", self.origin);
    wait(1.1);
  }
}

play_alarm_b() {
  alarm_bell = spawn(0, self.origin, "script.origin");
  alarm_bell playLoopSound("evt_alarm_b_loop", 0.8);
  wait(8.8);
  playsound(0, "evt_alarm_b_end", self.origin);
  wait(0.1);
  alarm_bell stopLoopSound(0.6);
  wait(3);
  alarm_bell delete();
}

alarm_a() {
  array_thread(getstructarray("amb_warning_siren", "targetname"), ::play_alarm_a);
}

alarm_b() {
  array_thread(getstructarray("amb_warning_bell", "targetname"), ::play_alarm_b);
}

play_pa_vox() {
  wait(2);
  playsound(0, "amb_vox_rus_PA", self.origin);
}

samantha_is_angry_setup() {
  waitforclient(0);
  player = getLocalPlayers();
  for(i = 0; i < player.size; i++) {
    player[i] thread samantha_is_angry_earthquake_and_rumbles();
  }
}

samantha_is_angry_earthquake_and_rumbles() {
  self endon("death");
  self endon("disconnect");
  level waittill("sia");
  snd_set_snapshot("zmb_samantha_scream");
  self Earthquake(.4, 10, self.origin, 150);
  self clientscripts\_zombiemode::zombie_vision_set_apply(level._visionset_map_nopower, 8);
  self thread do_that_sam_rumble();
  wait(6);
  snd_set_snapshot("default");
  self clientscripts\_zombiemode::zombie_vision_set_remove(level._visionset_map_nopower, 3);
}

do_that_sam_rumble() {
  count = 0;
  while(count <= 4) {
    self playRumbleOnEntity(0, "damage_heavy");
    wait(.1);
    count = count + .1;
  }
}