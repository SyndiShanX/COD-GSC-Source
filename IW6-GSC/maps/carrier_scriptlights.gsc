/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\carrier_scriptlights.gsc
*****************************************/

main() {
  carrier_set_vision_rog_tilt();
  init_lights();
}

init_lights() {
  var_0 = getEntArray("carrier_light_post_sparrow", "targetname");
  common_scripts\utility::array_thread(var_0, ::carrier_light_post_sparrow);
}

carrier_set_vision_rog_tilt() {
  if(level.start_point != "deck_victory" && level.start_point != "deck_tilt") {
    level.player waittill("remove_sam_control");
    wait 0.2;
  }

  thread maps\_utility::vision_set_fog_changes("carrier_outdoor", 0);
  maps\_art::sunflare_changes("carrier_rog_ladder_sunflare", 0);
  common_scripts\utility::flag_wait("rog_impacts_deck");
  thread maps\_utility::vision_set_fog_changes("carrier_rog", 1.0);
  maps\_art::sunflare_changes("carrier_rog_sunflare", 1.0);
  wait 0.5;
  thread maps\_utility::vision_set_fog_changes("carrier_post_rog", 1.0);
  maps\_art::sunflare_changes("carrier_outdoor_sunflare", 1.0);
  wait 1.0;
  thread maps\_utility::vision_set_fog_changes("carrier_outdoor", 8);
  common_scripts\utility::flag_wait("carrier_front_impact");
  thread maps\_utility::vision_set_fog_changes("carrier_rog", 0.5);
  maps\_art::sunflare_changes("carrier_rog_sunflare", 0.5);
  wait 1.0;
  thread maps\_utility::vision_set_fog_changes("carrier_outdoor", 3);
  maps\_art::sunflare_changes("carrier_outdoor_sunflare", 2);
}

carrier_light_post_sparrow() {
  var_0 = self getlightintensity();
  var_1 = self getlightradius();
  self setlightintensity(0);
  self setlightradius(12);
  common_scripts\utility::flag_wait("defend_sparrow_finished");
  self setlightintensity(var_0);
  self setlightradius(var_1);
}