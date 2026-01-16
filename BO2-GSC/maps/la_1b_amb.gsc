/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\la_1b_amb.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_music;

main() {
  level thread play_intro_radio();
  level thread force_reverb_for_intro();
  level thread play_sam_ambience();
  array_thread(getentarray("advertisement", "targetname"), ::advertisements);
}

advertisements() {
  if(self.script_noteworthy == "talent")
    self playloopsound("vox_ads_1_01_001a_pa");

  if(self.script_noteworthy == "tiny")
    self playloopsound("vox_ads_1_01_002a_pa");

  if(self.script_noteworthy == "bala")
    self playloopsound("vox_ads_1_01_004a_pa");

  if(self.script_noteworthy == "passion")
    self playloopsound("vox_ads_1_01_007a_pa");

  if(self.script_noteworthy == "cola")
    self playloopsound("vox_ads_1_01_008a_pa");

  if(self.script_noteworthy == "cinema")
    self playloopsound("vox_ads_1_01_009a_pa");

  self waittill("damage");
  self playsound("dst_glass_pane");
  self stoploopsound();
  self playloopsound("amb_" + self.script_noteworthy + "_damaged_ad");
}

force_snapshot_wait() {
  wait 20;
  clientnotify("stp_snp");
}

force_reverb_for_intro() {
  level waittill("force_verb");
  level.player shellshock("khe_sanh_woods_verb", 20);
  wait 20;
}

play_sam_ambience() {
  wait_for_first_player();
  level.player endon("death");
  level.player endon("missileTurret_off");
  level.player waittill("missileTurret_on");
  clientnotify("mTon");
  temp_ent = spawn("script_origin", level.player.origin);
  temp_ent playloopsound("wpn_sam_interface_loop", 1);
  level.player thread end_looping_sound(temp_ent);
  level.player thread play_sam_radio();
}

end_looping_sound(ent) {
  level.player waittill("missileTurret_off");
  clientnotify("mToff");
  ent stoploopsound(1);
  wait 1;
  ent delete();
}

play_sam_radio() {
  level.player endon("death");
  level.player endon("missileTurret_off");

  while(true) {
    level.player playsound("amb_sam_radio_chatter");
    wait(randomintrange(5, 10));
  }
}

play_sam_creaking_sounds() {
  level.player endon("death");
  level.player endon("missileTurret_off");
  wait_max = undefined;

  while(true) {
    if(!isDefined(level.num_planes_shot))
      wait_max = 15;
    else
      wait_max = get_wait_max();

    level.player playsound("evt_cougar_creak");
    wait(randomintrange(2, wait_max));
  }
}

get_wait_max() {
  if(level.num_planes_shot < 2)
    return 12;
  else if(level.num_planes_shot < 6)
    return 8;
  else if(level.num_planes_shot < 9)
    return 6;
  else
    return 4;
}

play_post_cougar_blend() {
  level waittill("cougar_blend_go");
  radioent = spawn("script_origin", (0, 0, 0));
  radioent playloopsound("vox_blend_post_la");
  level waittill("player_on_turret");
  radioent stoploopsound(0.5);
  radioent delete();
}

switch_music_wait() {
  wait 6;
  setmusicstate("LA_1_TURRET");
  level waittill("SAM_EVENT_OVER");
  setmusicstate("LA_1_OFF_TURRET");
}

play_intro_radio() {
  level waittill("radio_start_wakeup");
  playsoundatposition("vox_blend_la1b_intro", (0, 0, 0));
}

la_drone_control_tones(activate) {
  if(activate)
    level thread play_drone_control_tones();
  else
    level notify("stop_drone_control_tones");
}

play_drone_control_tones() {
  level endon("stop_drone_control_tones");
  level waitfor_enough_drones();

  while(true) {
    level thread play_drone_control_tones_single();
    wait(randomintrange(19, 39));
  }
}

waitfor_enough_drones() {
  level endon("stop_drone_control_tones");

  while(true) {
    drones = get_vehicle_array("veh_t6_drone_quad_rotor_sp", "model");

    if(!isDefined(drones) || drones.size <= 2)
      wait 1;
    else
      break;

    wait 0.1;
  }
}

play_drone_control_tones_single() {
  drones = get_vehicle_array("veh_t6_drone_quad_rotor_sp", "model");

  if(drones.size <= 2) {
    return;
  }
  drone = drones[randomintrange(0, drones.size)];
  drone playsound("veh_qr_tones_activate");
  wait 4;
  drones = get_vehicle_array("veh_t6_drone_quad_rotor_sp", "model");

  if(isDefined(drone))
    arrayremovevalue(drones, drone);

  array_thread(drones, ::play_drone_reply);
}

play_drone_reply() {
  wait(randomfloatrange(0.1, 0.85));

  if(isDefined(self))
    self playsound("veh_qr_tones_activate_reply");
}