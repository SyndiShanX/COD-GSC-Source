/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\zombie_coast_lighthouse\.csc
*****************************************************/

#include clientscripts\_utility;

main() {
  waitforallclients();
  level thread init_lighthouse_light();
  level thread lighthouse_search_toggle();
  level thread lighthouse_packapunch_think("pp0");
  level thread lighthouse_packapunch_think("pp1");
  level thread lighthouse_packapunch_think("pp2");
}
init_lighthouse_light() {
  local_players = getlocalplayers();
  for(index = 0; index < local_players.size; index++) {
    local_players[index] thread lighthouse_light(index);
  }
}
lighthouse_light(index) {
  level waittill("LHL");
  self.light_start_point = getstruct("pack_light", "targetname");
  self.lighthouse_fx_model = spawn(index, self.light_start_point.origin, "script_model");
  self.lighthouse_fx_model setModel("tag_origin");
  playFXOnTag(index, level._effect["fx_zmb_coast_spotlight_main"], self.lighthouse_fx_model, "tag_origin");
  if(index == 0) {
    level.packapunch_active = false;
  }
  self thread lighthouse_search_logic();
  self thread lighthouse_freak_out(index);
  while(1) {
    if(level.packapunch_active) {
      self wait_for_packapunch_to_finish();
    }
    self.lighthouse_fx_model rotateto((self.lighthouse_fx_model.angles[0], self.lighthouse_fx_model.angles[1] + 5, self.lighthouse_fx_model.angles[2]), .2);
    wait(.1);
  }
}
wait_for_packapunch_to_finish() {
  while(level.packapunch_active) {
    wait .05;
  }
  self.lighthouse_fx_model rotateto((0, self.lighthouse_fx_model.angles[1], 0), 1);
  self.lighthouse_fx_model waittill("rotatedone");
}
lighthouse_search_toggle() {
  while(1) {
    level waittill("PPH");
    level.packapunch_active = false;
  }
}
lighthouse_search_logic() {
  while(1) {
    level waittill("pap_time", pap_struct);
    pap_location = get_packapunch_location(pap_struct);
    org = pap_location.origin;
    dir = org - self.lighthouse_fx_model.origin;
    angles = vectortoangles(dir);
    self.pre_pap_angles = self.lighthouse_fx_model.angles;
    level.packapunch_active = true;
    wait(.2);
    self.lighthouse_fx_model rotateto(angles, 1);
  }
}
lighthouse_freak_out(index) {
  while(1) {
    level waittill("lhfo");
    f_activate_time = 0.1;
    f_remove_time = 1.5;
    level thread freakout_sun_reaction();
    self clientscripts\_zombiemode::zombie_vision_set_apply(level._coast_lighthouse_freak_out_set, level._coast_lighthouse_freak_out_set_priority, f_activate_time, index);
    wait(f_remove_time);
    self clientscripts\_zombiemode::zombie_vision_set_remove(level._coast_lighthouse_freak_out_set, f_remove_time, index);
    level.lighthouse_freakout = 1;
    level thread freakout_timer();
    level.packapunch_active = true;
    while(level.lighthouse_freakout) {
      time = randomfloatrange(.5, 1);
      self.lighthouse_fx_model rotateto((randomintrange(-90, 90), randomintrange(-180, 180), randomintrange(-90, 90)), time);
      wait(time);
    }
  }
}
freakout_timer() {
  level waittill("lhfd");
  level.lighthouse_freakout = 0;
}
freakout_sun_reaction() {
  full_wait_time = 1.5;
  incremental_wait_time = 0.05;
  current_time = 0;
  sun_amount_array = [];
  sun_amount_array[0] = 1.5;
  sun_amount_array[1] = 0.8;
  sun_amount_array[2] = 0.2;
  sun_amount_array[3] = 2.2;
  sun_amount_array[4] = 1.1;
  sun_amount_array[5] = 0.5;
  while(current_time < full_wait_time) {
    flt_amount = sun_amount_array[RandomInt(sun_amount_array.size)];
    SetSunLight(flt_amount, flt_amount, flt_amount);
    wait(incremental_wait_time);
    current_time = current_time + incremental_wait_time;
  }
  ResetSunlight();
}
get_packapunch_location(pap_script_string) {
  pap_locations = getstructarray("pap_location", "targetname");
  pap_location = undefined;
  for(i = 0; i < pap_locations.size; i++) {
    if(pap_locations[i].script_string == pap_script_string) {
      pap_location = pap_locations[i];
    }
  }
  return pap_location;
}
lighthouse_packapunch_think(str_notify) {
  while(1) {
    level waittill(str_notify);
    level notify("pap_time", str_notify);
  }
}