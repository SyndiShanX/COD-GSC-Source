/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\see1_amb.gsc
*****************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_ambientpackage;
#include maps\_music;

main() {
  /
}

event1_mortars() {
  level waittill("charge_starts");
  setmusicstate("FIELDS_OF_FIRE");
  maps\_mortar::set_mortar_delays("dirt_small", 0.5, 3, 0.1, 0.5);
  maps\_mortar::set_mortar_range("dirt_small", 300, 4000);
  level thread maps\_mortar::mortar_loop("dirt_small", 1);
  maps\_mortar::set_mortar_delays("dirt_medium", 2, 6, 0.1, 0.5);
  maps\_mortar::set_mortar_range("dirt_medium", 300, 1000);
  level thread maps\_mortar::mortar_loop("dirt_medium", 1);
  maps\_mortar::set_mortar_delays("mud_small", 0.5, 3, 0.1, 0.5);
  maps\_mortar::set_mortar_range("mud_small", 300, 4000);
  level thread maps\_mortar::mortar_loop("mud_small", 1);
  maps\_mortar::set_mortar_delays("mud_far", 1, 2, 2, 3);
  maps\_mortar::set_mortar_range("mud_far", 300, 4000);
  level thread maps\_mortar::mortar_loop("mud_far", 1);
  maps\_mortar::set_mortar_delays("mud_medium", 4, 6, 2, 3);
  maps\_mortar::set_mortar_range("mud_medium", 300, 1000);
  level thread maps\_mortar::mortar_loop("mud_medium", 1);
}

event1_fakefire() {
  firepoints = getstructarray("prerocket_muzzleflashes", "script_noteworthy");
  level thread event1_fakefire_think(firepoints);
  level thread event1_fakefire_think(firepoints);
  level thread event1_fakefire_think(firepoints);
  level thread event1_fakefire_think(firepoints);
  level thread event1_fakefire_think(firepoints);
  level thread event1_fakefire_think(firepoints);
  level thread event1_fakefire_think(firepoints);
}

event1_fakefire_think(firepoints) {
  level endon("stop_event1_fakefire");
  while (1) {
    firepoint = firepoints[randomint(firepoints.size)];
    if(isDefined(firepoint.is_firing) && firepoint.is_firing == true) {
      continue;
    }
    firepoint.is_firing = true;
    clipsize = randomintrange(2, 7);
    for (i = 0; i < clipsize; i++) {
      playfx(level._effect["distant_muzzleflash"], firepoint.origin, anglestoforward(firepoint.angles), anglestoup(firepoint.angles));
      rand = randomint(3);
      if(!rand) {
        thread play_sound_in_space("weap_mp40_fire", firepoint.origin);
      }
      bullettracer(firepoint.origin, firepoint.origin - (randomintrange(1, 100), 4000 + randomintrange(1, 500), randomintrange(1, 40)), false);
      wait(randomfloatrange(0.1, 0.2));
    }
    wait(2);
    firepoint.is_firing = false;
  }
}

event1_katyusha_rocket_barrage(truck_name, trigger_name) {
  truck = getent(truck_name, "targetname");
  trigger = getent(trigger_name, "targetname");
  trigger waittill("trigger");
  attack_range = (0, 10000, 0);
  start_points = [];
  dest_points = [];
  rocket_num = 8;
  rocket_separation = 10;
  rocket_center_point = truck.origin + (0, -50, 100);
  rocket_left_most_point = rocket_center_point - (rocket_num * rocket_separation * 0.5, 0, 0);
  for (i = 0; i < rocket_num; i++) {
    start_points[i] = rocket_left_most_point + (i * rocket_separation, 0, 0);
    dest_points[i] = start_points[i] + attack_range;
  }
  for (i = 0; i < start_points.size; i++) {
    rocket = spawn("script_model", start_points[i]);
    rocket setmodel("weapon_ger_panzershreck_rocket");
    rocket.angles = (320, 90, 0);
    playfxontag(level._effect["rocket_trail"], rocket, "tag_origin");
    rocket playsound("rocket_run");
    rocket thread event1_katyusha_rocket_fly_think(dest_points[i] + (randomint(50), randomint(50), randomint(50)));
    wait(0.7);
  }
}

event1_katyusha_rocket_barrage_side(struct_name, trigger_name) {
  trucks = getstructarray(struct_name, "targetname");
  trigger = getent(trigger_name, "targetname");
  for (i = 0; i < trucks.size; i++) {
    event1_katyusha_rocket_barrage_side_single(trucks[i], trigger);
  }
}

event1_katyusha_rocket_barrage_side_single(start_struct, trigger) {
  level endon("event1_ends");
  trigger waittill("trigger");
  attack_range = (0, 10000, 0);
  start_points = [];
  dest_points = [];
  rocket_num = 8;
  rocket_separation = 10;
  rocket_center_point = start_struct.origin + (0, -50, 100);
  rocket_left_most_point = rocket_center_point - (rocket_num * rocket_separation * 0.5, 0, 0);
  for (i = 0; i < rocket_num; i++) {
    start_points[i] = rocket_left_most_point + (i * rocket_separation, 0, 0);
    dest_points[i] = start_points[i] + attack_range;
  }
  while (1) {
    wait(randomint(2));
    for (i = 0; i < start_points.size; i++) {
      rocket = spawn("script_model", start_points[i]);
      rocket setmodel("weapon_ger_panzershreck_rocket");
      rocket.angles = (320, 90, 0);
      playfxontag(level._effect["rocket_trail"], rocket, "tag_origin");
      rocket playsound("rocket_run");
      rocket thread event1_katyusha_rocket_fly_think(dest_points[i] + (randomint(50), randomint(50), randomint(50)));
      wait(0.7);
    }
    wait(randomint(3) + 3);
  }
}

event1_katyusha_rocket_fly_think(destination_pos) {
  playfx(level._effect["lci_rocket_launch"], self.origin, anglestoforward((320, 90, 0)), anglestoup((320, 90, 0)));
  while (1) {
    if(self.origin[2] < -500) {
      if(self.origin[1] > 8000) {
        playfx(level._effect["lci_rocket_impact"], self.origin);
        thread play_sound_in_space("rocket_dirt", self.origin);
      }
      break;
    }
    wait(0.05);
  }
  level notify("do aftermath");
  wait(2);
  self delete();
}

event2() {}
event3() {
  level thread event3_flak_flashes();
}

event3_flak_flashes() {
  targets = getstructarray("ev3_flash", "targetname");
  for (i = 0; i < targets.size; i++) {
    level thread event3_flak_flash_single(targets[i].origin);
  }
}

event3_flak_flash_single(position) {
  while (1) {
    wait(randomfloat(4) + 3);
    playfx(level._effect["flak_flash"], position);
  }
}