/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\pakistan.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\_glasses;
#include clientscripts\_filter;
#include clientscripts\pakistan_fx;
#include clientscripts\_load;
#include clientscripts\_claw_grenade;
#include clientscripts\_flamethrower_plight;
#include clientscripts\_audio;
#include clientscripts\pakistan_amb;
#include clientscripts\_fire_direction;
#include clientscripts\_footsteps;

main() {
  clientscripts\pakistan_fx::main();
  clientscripts\_load::main();
  clientscripts\_claw_grenade::main();
  clientscripts\_flamethrower_plight::init();
  thread clientscripts\_audio::audio_init(0);
  thread clientscripts\pakistan_amb::main();
  thread clientscripts\_fire_direction::init();
  register_clientflag_callback("actor", 4, ::toggle_water_fx_actor);
  register_clientflag_callback("player", 0, ::toggle_water_fx_actor);
  register_clientflag_callback("scriptmover", 3, ::toggle_water_fx_model);
  register_clientflag_callback("actor", 15, ::toggle_flame_char_actor);
  waitforclient(0);
  level thread dynent_control();
  level thread frogger_street_wave();
  level thread bus_street_wave();
  level thread bus_street_initial_wave();
  level thread alley_set_underwater_fog();
  level thread init_claw_boot_sequence();
  level thread player_death_blur();
  clientscripts\_footsteps::registeraitypefootstepcb("Ally_SEAL_Pakistan_Bigdog", clientscripts\_footsteps::bigdogfootstepcbfunc);
}

player_death_blur() {
  level waittill("player_dead");
  getlocalplayers()[0] setblur(10, 0.1);
  setwaterfog(0.0, 0.1, 0.1, 280, 0.2211, 0.1614, 0.1018, 1, 0.5469, 0.5509, 0.5679, 0, 0, 0, 0, 0, 1.0);
}

dynent_control() {
  waitill_notify_and_toggle_dynents("cleanup_market_dynents", "market_dynent");
  waitill_notify_and_toggle_dynents("cleanup_market_pillars", "market_pillar");
  waitill_notify_and_toggle_dynents("start_stealth_dynents", "stealth_dynent", 1);
  waitill_notify_and_toggle_dynents("cleanup_stealth_dynents", "stealth_dynent");
}

waitill_notify_and_toggle_dynents(str_notify, str_dynent_name, b_active) {
  if(!isDefined(b_active))
    b_active = 0;

  level waittill(str_notify);
  a_e_dynents = getdynentarray(str_dynent_name);

  if(b_active == 0) {
    foreach(e_dynent in a_e_dynents)
    setdynentenabled(e_dynent, 0);
  } else {
    foreach(e_dynent in a_e_dynents)
    launchdynent(e_dynent, (0, 0, -1));
  }
}

init_claw_boot_sequence() {
  level waittill("init_claw");
  player = getlocalplayers()[0];
  init_filter_claw_boot(player);
  level thread set_claw_boot_sequence();
}

set_claw_boot_sequence() {
  player = getlocalplayers()[0];
  filterid = 0;
  amount = 1;
  set_filter_claw_boot_amount(player, filterid, amount);
  enable_filter_claw_boot(player, filterid);
  level waittill("disable_claw_boot");
  disable_filter_claw_boot(player, filterid);
}

frogger_street_wave() {
  level waittill("frogger_water_surge");
  s_wave_origin = getstruct("frogger_water_surge_struct", "targetname");
  x_pos = s_wave_origin.origin[0] * -1;
  y_pos = s_wave_origin.origin[1] * -1;
  setripplewave(0, x_pos, y_pos, 900, 1.6, 0.04, 0.0, 900.0, 1000, 1750);
}

bus_street_wave() {
  level waittill("bus_wave_start");
  s_wave_origin = getstruct("bus_wave_struct", "targetname");
  x_pos = s_wave_origin.origin[0] * -1;
  y_pos = s_wave_origin.origin[1] * -1;
  setripplewave(0, x_pos, y_pos, 650, 1.1, 0.067, 0.0, 5.0, 900, 1500);
}

bus_street_initial_wave() {
  level waittill("bus_wave_initial_start");
  s_wave_origin = getstruct("bus_wave_initial", "targetname");
  x_pos = s_wave_origin.origin[0] * -1;
  y_pos = s_wave_origin.origin[1] * -1;
  setripplewave(0, x_pos, y_pos, 450, 0.8, 0.03, 0.0, 10.0, 4100, 5100);
}

alley_set_underwater_fog() {
  setwaterfog(0.0, 7.24984, 2983.75, -2981.25, 0.2211, 0.1614, 0.1018, 1, 0.5469, 0.5509, 0.5679, 0, 0, 0, 0, 0, 1.0);
}

toggle_flame_char_actor(localclientnum, set, newent) {
  self mapshaderconstant(localclientnum, 0, "ScriptVector0");
  s_timer = new_timer();

  do {
    wait 0.01;
    n_current_time = s_timer get_time_in_seconds();
    n_delta_val = lerpfloat(0, 0.85, n_current_time / 3);
    self setshaderconstant(localclientnum, 0, 0, 0, n_delta_val, 0);
  }
  while(n_current_time < 3);
}

toggle_water_fx_actor(localclientnum, set, newent) {
  if(set)
    self.fx_handle = playfxontag(localclientnum, level._effect["water_loop"], self, "tag_origin");
  else
    deletefx(localclientnum, self.fx_handle);
}