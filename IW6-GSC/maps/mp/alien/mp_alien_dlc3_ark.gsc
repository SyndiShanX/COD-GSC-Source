/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\mp_alien_dlc3_ark.gsc
***********************************************/

main() {
  ark_console_init();
}

ark_console_init() {
  if(maps\mp\alien\_utility::is_chaos_mode()) {
    return;
  }
  common_scripts\utility::flag_init("ark_console_cycle_over");
  common_scripts\utility::flag_init("ark_console_event_done");
  common_scripts\utility::flag_init("consoles_all_on");
  common_scripts\utility::flag_init("cortex_pulse");
  common_scripts\utility::flag_init("start_ark_encounter");
  common_scripts\utility::flag_init("cortex_carryable");
  common_scripts\utility::flag_init("everyone_in_ark");
  common_scripts\utility::flag_init("doors_open");
  common_scripts\utility::flag_init("start_archer_vignette");
  precachempanim("alien_descent_vignette_idle_a");
  precachempanim("alien_descent_vignette_idle_b");
  precachempanim("alien_descent_vignette_idle_c");
  precachempanim("alien_descent_vignette_dialogue_1");
  precachempanim("alien_descent_vignette_dialogue_2");
  precachempanim("alien_descent_vignette_dialogue_3");
  precachempanim("alien_descent_vignette_cannister");
  console_threatbias_setup();
  level.ark_console_time_paused = 0;
  level.total_consoles = 4;
  level thread ark_console_encounter();
}

ark_console_encounter() {
  level endon("end_ark_encounter");

  while(!isDefined(level.players))
    wait 0.1;

  level thread debug_end_encounter();

  if(isDefined(level.debug_ark_jump))
    level thread debug_open_ark_doors();
  else
    level thread open_ark_doors();

  common_scripts\utility::flag_wait("entering_ark_flag");
  level thread initial_outline_for_connecting_player();
  var_0 = getent("ark_fog_01", "targetname");
  var_0 setscriptablepartstate("base", "default");
  var_1 = getent("ark_glow_01", "targetname");
  var_1 setscriptablepartstate("base", "default");
  level.attack_points = [];
  level.gas_ents = [];

  for(var_2 = 0; var_2 < level.total_consoles; var_2++) {
    var_3 = getent("console_" + (var_2 + 1), "targetname");
    var_3.panels = getscriptablearray("panels_" + (var_2 + 1), "targetname")[0];
    level.attack_points[var_2] = var_3;
    level thread create_on_and_off_states_for_console(level.attack_points[var_2], "console_" + (var_2 + 1));
  }

  level thread set_ark_encounter_flag();
  common_scripts\utility::flag_wait("start_ark_encounter");
  create_initial_cortex();
  level thread spawn_archer();
  level thread disable_cortex_for_ark_encounter();
  level thread cortex_pulse_logic();
  level thread turn_on_consoles();
  level thread make_aliens_ignore_consoles();
  common_scripts\utility::flag_wait("consoles_all_on");
  level thread close_ark_doors();
  level thread teleport_players_not_in_ark();
  common_scripts\utility::flag_wait("everyone_in_ark");
  maps\mp\alien\_gamescore::reset_encounter_performance();
  var_4 = 1;

  foreach(var_3 in level.attack_points) {
    var_3 thread ark_console_attack_point_logic(var_4);
    var_4++;
  }

  wait 0.1;
  setomnvar("ui_alien_boss_status", 2);
  setomnvar("ui_alien_boss_icon", 4);
  setomnvar("ui_alien_boss_progression", 0);
  level thread spawn_ark_waves_on_progression("progress_25", "ark_spawn_25");
  level thread spawn_ark_waves_on_progression("progress_50", "ark_spawn_50");
  level thread spawn_ark_waves_on_progression("progress_75", "ark_spawn_75");
  level thread ark_console_combat_timer(240);
  level thread listen_for_all_consoles_down();
  level thread multiple_terminals_down_nag();
  level thread trigger_ark_defenses();
  level thread open_ark_obelisks();
  level.should_use_custom_death_func = 1;
  spawn_wave(19);
  common_scripts\utility::flag_wait("ark_console_cycle_over");

  foreach(var_8 in level.players)
  var_8 thread remove_ark_vo_on_player();

  foreach(var_11 in level.attack_points) {
    maps\mp\alien\_outline_proto::disable_outline_for_players(var_11, level.players);
    var_11.ignoreme = 1;
  }

  foreach(var_11 in level.gas_ents)
  var_11 delete();

  setomnvar("ui_alien_boss_status", 0);
  level notify("stop_waves");
  level notify("end_cycle");
  level notify("alien_cycle_ended");
  maps\mp\alien\_gamescore::calculate_and_show_encounter_scores(level.players, maps\mp\alien\_gamescore_dlc3::get_ark_score_component_list());
  give_players_ark_rewards();
  level thread open_ark_doors_end();
  wait_until_players_are_not_using_cortex();
  common_scripts\utility::flag_set("ark_console_event_done");
  level.encounter_name = undefined;
}

give_players_ark_rewards() {
  foreach(var_1 in level.players)
  var_1 thread maps\mp\alien\_hive::wait_to_give_rewards();
}

set_ark_encounter_flag() {
  var_0 = 0;

  while(!var_0) {
    foreach(var_2 in level.players) {
      if(distance(var_2.origin, (3564, 1887, 976)) < 1800) {
        var_0 = 1;
        break;
      }
    }

    wait 0.1;
  }

  common_scripts\utility::flag_set("start_ark_encounter");
}

wait_until_players_are_not_using_cortex() {
  var_0 = 1;

  for(;;) {
    var_0 = 1;

    foreach(var_2 in level.players) {
      if(isDefined(var_2.cortex_spot))
        var_0 = 0;
    }

    if(var_0) {
      break;
    }

    wait 0.1;
  }
}

debug_end_encounter() {
  level waittill("debug_beat_ark_interior");
  common_scripts\utility::flag_wait("consoles_all_on");
  level notify("end_ark_encounter");
  common_scripts\utility::flag_set("ark_console_cycle_over");
  common_scripts\utility::flag_set("ark_console_event_done");

  foreach(var_1 in level.attack_points) {
    maps\mp\alien\_outline_proto::disable_outline_for_players(var_1, level.players);
    var_1.ignoreme = 1;
  }

  setomnvar("ui_alien_boss_status", 0);
  level notify("stop_waves");
  level notify("alien_cycle_ended");
  common_scripts\utility::flag_set("ark_console_event_done");
  level thread open_ark_doors_end();
  level.encounter_name = undefined;
}

create_on_and_off_states_for_console(var_0, var_1) {
  make_cable_arrays(var_0, var_1);
  var_0 turn_off_console();
  wait 0.1;
  var_0.panels setscriptablepartstate(0, "idle");
}

create_initial_cortex() {
  var_0 = (3832, 1851, 920);
  maps\mp\alien\_cortex::drop_cortex(var_0, (0, 0, 0));
}

turn_on_consoles() {
  level endon("end_ark_encounter");
  wait 1.0;

  while(!isDefined(level.cortex))
    wait 0.1;

  while(!isDefined(level.cortex_use_trigger))
    wait 0.1;

  level thread start_ark_encounter_nag();
  level.cortex_use_trigger makeusable();
  level.cortex_use_trigger sethintstring(&"MP_ALIEN_DESCENT_CORTEX_USE");
  maps\mp\alien\_outline_proto::enable_outline_for_players(level.cortex, level.players, 3, 0, "high");
  level.cortex_use_trigger wait_until_player_use_cortex();
  playFX(level._effect["cortex_blast"], level.cortex.origin + (0, 0, 15));
  playsoundatpos(level.cortex.origin, "scn_cortex_activate");
  level thread rumble_players("heavygun_fire", 0.5);
  common_scripts\utility::flag_set("ark_encounter_begun");
  level.cortex_use_trigger sethintstring("");
  maps\mp\alien\_outline_proto::enable_outline_for_players(level.cortex, level.players, 1, 0, "high");

  foreach(var_1 in level.players)
  var_1 remove_ark_vo_on_player();

  common_scripts\utility::flag_set("consoles_all_on");
}

start_ark_encounter_nag() {
  level endon("end_ark_encounter");
  level endon("ark_encounter_begun");
  common_scripts\utility::flag_wait("ark_intro_vo_done");
  wait 20;
  var_0 = ["descent_crs_getthecortexand"];
  maps\mp\mp_alien_dlc3_vignettes::play_descent_vignette_vo(var_0);
  wait 20;
  var_0 = ["descent_crs_doitnowyoure"];
  maps\mp\mp_alien_dlc3_vignettes::play_descent_vignette_vo(var_0);
  wait 20;
  var_1 = 0;

  for(;;) {
    if(common_scripts\utility::flag("ark_encounter_begun")) {
      break;
    }

    level notify("dlc_vo_notify", "descent_vo", "nag_obelisks");
    wait(20 + var_1);

    if(var_1 < 120)
      var_1 = var_1 + 20;
  }
}

ark_console_attack_point_logic(var_0) {
  self makeentitysentient("allies");
  self.ignoreme = 0;
  self setthreatbiasgroup("consoles");
  self.threatbias = 1000;
  self setCanDamage(1);

  if(maps\mp\alien\_utility::isplayingsolo())
    self.progresshealth = 500;
  else
    self.progresshealth = 100;

  thread ark_console_point_health_monitor(var_0);
  thread prevent_friendly_fire();
}

prevent_friendly_fire() {
  level endon("end_ark_encounter");
  self endon("death");
  self endon("end_cycle");
  self.health = 9999999;

  for(;;) {
    var_0 = 0;
    self waittill("damage", var_1, var_2, var_3, var_4, var_5);

    if(isDefined(var_2.team) && var_2.team == "allies") {
      var_0 = 1;
      self.health = self.health + var_1;
    }

    if(!var_0 && self.progresshealth > 0) {
      self playSound("scn_dscnt_alien_pod_hit");
      self.progresshealth = self.progresshealth - var_1;
    }
  }
}

ark_console_point_health_monitor(var_0) {
  level endon("end_ark_encounter");
  level endon("end_cycle");
  var_1 = self.progresshealth;
  self.start_health = var_1;
  var_2 = 0;
  self.outline_color = 0;
  thread turn_on_console();
  maps\mp\alien\_outline_proto::enable_outline_for_players(self, level.players, 2, 1, "high");
  self.alarmed = 0;
  self makeentitysentient("allies");
  self.ignoreme = 0;
  self.sound_org = spawn("script_model", self.origin);
  self.sound_org setModel("tag_origin");

  while(!common_scripts\utility::flag("ark_console_cycle_over")) {
    while(self.progresshealth > 0) {
      if(self.progresshealth > var_1 * 0.75) {
        if(self.outline_color != 2) {
          self.outline_color = 2;
          maps\mp\alien\_outline_proto::enable_outline_for_players(self, level.players, 2, 0, "high");
        }
      } else if(self.progresshealth > var_1 * 0.5) {
        if(self.outline_color != 2) {
          self.outline_color = 2;
          maps\mp\alien\_outline_proto::enable_outline_for_players(self, level.players, 2, 0, "high");
          self.panels setscriptablepartstate(0, "damaged_1");
        }
      } else if(self.progresshealth > var_1 * 0.25) {
        if(self.outline_color != 5) {
          self.outline_color = 5;
          maps\mp\alien\_outline_proto::enable_outline_for_players(self, level.players, 5, 0, "high");
          self.panels setscriptablepartstate(0, "damaged_2");
          playsoundatpos(self.sound_org.origin + (0, 0, 40), "scn_ark_console_alert");
        }
      } else if(self.outline_color != 5) {
        self.outline_color = 5;
        maps\mp\alien\_outline_proto::enable_outline_for_players(self, level.players, 5, 0, "high");

        if(self.alarmed == 0)
          self.alarmed = 1;
      }

      if(self.progresshealth != self.start_health) {
        var_2 = 0;
        self.start_health = self.progresshealth;
      } else {
        var_2 = var_2 + 1;

        if(var_2 >= 50) {
          if(self.progresshealth > var_1 * 0.75) {
            self.progresshealth = var_1;
            self.panels setscriptablepartstate(0, "on");
            var_2 = 0;
          } else if(self.progresshealth > var_1 * 0.5) {
            self.progresshealth = int(floor(var_1 * 0.75));
            var_2 = 0;
          } else if(self.progresshealth > var_1 * 0.25) {
            self.progresshealth = int(floor(var_1 * 0.5));
            var_2 = 0;
          } else {
            self.progresshealth = int(floor(var_1 * 0.25));
            var_2 = 0;
          }
        }
      }

      wait 0.1;
    }

    thread turn_off_console();
    self.ignoreme = 1;
    thread terminal_down_vo(var_0);
    self sethintstring(&"MP_ALIEN_DESCENT_TERMINAL_ONLINE");
    maps\mp\alien\_outline_proto::enable_outline_for_players(self, level.players, 1, 0, "high");
    self.outline_color = 0;
    self makeusable();
    thread play_console_offline_audio();
    wait_until_player_repairs_console();
    reset_console_health();
    thread turn_on_console();
    thread make_console_sentient(5);
    self sethintstring("");
    self.sound_org stoploopsound("scn_ark_console_off_lp");
    wait 0.1;
  }

  maps\mp\alien\_outline_proto::disable_outline_for_players(self, level.players);
  self.sound_org stoploopsound("scn_ark_console_off_lp");
  wait 0.1;
  self.sound_org delete();
}

turn_off_console() {
  self.panels setscriptablepartstate(0, "off");

  if(isDefined(self.cable_on_array)) {
    foreach(var_1 in self.cable_on_array)
    var_1 hide();

    foreach(var_1 in self.cable_off_array)
    var_1 show();
  }
}

initial_outline_for_connecting_player() {
  level endon("game_ended");
  common_scripts\utility::flag_wait("everyone_in_ark");

  while(!common_scripts\utility::flag("ark_console_cycle_over")) {
    level waittill("connected", var_0);
    level thread init_console_outlines(var_0);
  }
}

init_console_outlines(var_0) {
  level endon("game_ended");
  var_0 waittill("outline_init_done");

  foreach(var_2 in level.attack_points) {
    if(maps\mp\alien\_utility::isplayingsolo())
      var_3 = 500;
    else
      var_3 = 100;

    if(var_2.progresshealth > 0) {
      if(var_2.progresshealth > var_3 * 0.75)
        maps\mp\alien\_outline_proto::enable_outline_for_player(var_2, var_0, 2, 0, "high");
      else if(var_2.progresshealth > var_3 * 0.5)
        maps\mp\alien\_outline_proto::enable_outline_for_player(var_2, var_0, 2, 0, "high");
      else if(var_2.progresshealth > var_3 * 0.25)
        maps\mp\alien\_outline_proto::enable_outline_for_player(var_2, var_0, 5, 0, "high");
      else
        maps\mp\alien\_outline_proto::enable_outline_for_player(var_2, var_0, 5, 0, "high");

      continue;
    }

    maps\mp\alien\_outline_proto::enable_outline_for_player(var_2, var_0, 1, 0, "high");
  }
}

play_console_offline_audio() {
  playsoundatpos(self.sound_org.origin + (0, 0, 40), "scn_ark_console_off");
  self.sound_org playLoopSound("scn_ark_console_off_lp");
}

make_cable_arrays(var_0, var_1) {
  var_2 = getEntArray(var_1 + "_cable", "targetname");

  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_noteworthy)) {
      if(var_4.script_noteworthy == "on")
        var_0.cable_on_array = common_scripts\utility::add_to_array(var_0.cable_on_array, var_4);

      if(var_4.script_noteworthy == "off")
        var_0.cable_off_array = common_scripts\utility::add_to_array(var_0.cable_off_array, var_4);
    }
  }
}

turn_on_console() {
  self.panels setscriptablepartstate(0, "on");

  if(isDefined(self.cable_on_array)) {
    foreach(var_1 in self.cable_on_array)
    var_1 show();

    foreach(var_1 in self.cable_off_array)
    var_1 hide();
  }
}

make_console_sentient(var_0) {
  level endon("end_ark_encounter");
  level endon("end_cycle");
  wait(var_0);
  self makeentitysentient("allies");
  self.ignoreme = 0;
  self setthreatbiasgroup("consoles");
  self.threatbias = 1000;
  self setCanDamage(1);
}

terminal_down_vo(var_0) {
  level endon("end_ark_encounter");
  var_1 = [var_0, "_single"];
  var_2 = common_scripts\utility::random(var_1);
  level notify("dlc_vo_notify", "descent_vo", "offline_obelisk" + var_2);
}

multiple_terminals_down_nag() {
  level endon("end_ark_encounter");
  level endon("ark_console_cycle_over");
  common_scripts\utility::flag_wait("consoles_all_on");

  while(!common_scripts\utility::flag("ark_console_cycle_over")) {
    while(get_num_online_consoles() > 3)
      wait 5;

    if(get_num_online_consoles() < 3)
      level notify("dlc_vo_notify", "descent_vo", "offline_obelisk");

    common_scripts\utility::flag_wait("cortex_pulse");
    common_scripts\utility::flag_waitopen("cortex_pulse");
  }
}

reset_console_health() {
  if(maps\mp\alien\_utility::isplayingsolo())
    self.progresshealth = 500;
  else
    self.progresshealth = 100;

  self.outline_color = 0;
}

ark_console_combat_timer(var_0) {
  level endon("end_ark_encounter");
  var_1 = var_0;
  level.elapsed_time = 0;
  var_2 = 0;
  var_3 = 1.0;
  var_4 = var_3 / level.total_consoles;
  var_5 = var_3 * 100 / var_1;
  var_6 = var_5 / level.total_consoles;
  var_7 = 0;
  level thread fx_ramp_on_progression(var_1);

  while(!common_scripts\utility::flag("ark_console_cycle_over")) {
    if(level.elapsed_time > var_1) {
      common_scripts\utility::flag_set("ark_console_cycle_over");
      break;
    } else {
      var_8 = get_num_online_consoles();

      if(var_8 == 0) {
        if(!var_7) {
          level notify("all_consoles_down");
          var_7 = 1;
        }
      }

      if(var_8 < 4) {
        wait(var_3);
        continue;
      }

      if(var_8 == level.total_consoles) {
        if(var_7)
          level notify("all_consoles_up");
      }

      level.elapsed_time = level.elapsed_time + var_4 * var_8;
      var_2 = var_2 + var_6 * var_8;
      setomnvar("ui_alien_boss_progression", 100 - int(var_2));
    }

    wait(var_3);
  }
}

fx_ramp_on_progression(var_0) {
  var_1 = var_0 * 0.25;
  var_2 = var_0 * 0.5;
  var_3 = var_0 * 0.75;
  var_4 = spawn("script_origin", (3390, 1924, 948));
  var_5 = getent("ark_fog_01", "targetname");
  var_6 = getent("ark_glow_01", "targetname");
  level thread lightning_loop_01();

  while(!isDefined(level.elapsed_time))
    wait 0.1;

  while(level.elapsed_time < var_1)
    wait 0.1;

  level notify("progress_25");
  maps\mp\mp_alien_dlc3_vignettes::descent_vo_ark_defenses();
  var_4 playSound("scn_descent_end_25per");
  earthquake(0.1, 3, level.archer.origin, 2000);
  level thread rumble_players("heavy_3s", 0);
  wait 0.1;
  var_5 setscriptablepartstate("base", "medium");
  var_6 setscriptablepartstate("base", "medium");

  while(level.elapsed_time < var_2)
    wait 0.1;

  maps\mp\mp_alien_dlc3_vignettes::descent_vo_ark_combat_halfway();
  level notify("progress_50");
  level notify("ark_stage_3");
  var_4 playSound("scn_descent_end_50per");
  earthquake(0.2, 3, level.archer.origin, 2000);
  level thread rumble_players("heavy_3s", 0);
  wait 0.1;
  var_5 setscriptablepartstate("base", "hot");
  var_6 setscriptablepartstate("base", "hot");
  level thread lightning_loop_01();

  while(level.elapsed_time < var_3)
    wait 0.1;

  level notify("progress_75");
  maps\mp\mp_alien_dlc3_vignettes::descent_vo_ark_combat_almost_done();
  var_4 playSound("scn_descent_end_75per");
  thread aud_node_cleanup(var_4);
  earthquake(0.4, 3, level.archer.origin, 2000);
  level thread rumble_players("heavy_3s", 0);
}

spawn_ark_waves_on_progression(var_0, var_1) {
  level waittill(var_0);
  spawn_ark_event_wave(var_1);
}

spawn_ark_event_wave(var_0) {
  maps\mp\alien\_spawn_director::activate_spawn_event(var_0, 1);
}

aud_node_cleanup(var_0) {
  wait 7.5;

  if(isDefined(var_0))
    var_0 delete();
}

lightning_loop_01() {
  level endon("game_ended");
  level endon("ark_stage_3");
  var_0 = getent("ark_lightning_01", "targetname");
  var_1 = ["default", "bolt_1", "bolt_2", "bolt_3", "bolt_4"];

  for(;;) {
    wait 0.01;
    wait(randomfloatrange(0.8, 2.3));
    var_0 setscriptablepartstate("base", "default");
    wait 0.1;
    var_2 = common_scripts\utility::random(var_1);
    var_0 setscriptablepartstate("base", var_2);
  }
}

lightning_loop_02() {
  level endon("game_ended");
  var_0 = getent("ark_lightning_01", "targetname");
  var_1 = ["default", "bolt_5", "bolt_6", "bolt_7"];

  for(;;) {
    wait 0.01;
    wait(randomfloatrange(0.3, 1.3));
    var_0 setscriptablepartstate("base", "default");
    wait 0.1;
    var_2 = common_scripts\utility::random(var_1);
    var_0 setscriptablepartstate("base", var_2);
  }
}

listen_for_all_consoles_down() {
  level endon("end_ark_encounter");

  while(!common_scripts\utility::flag("ark_console_cycle_over")) {
    level waittill("all_consoles_down");

    if(!common_scripts\utility::flag("cortex_pulse"))
      level thread ark_emp_on_all_consoles_down();

    level waittill("all_consoles_up");
  }
}

ark_emp_on_all_consoles_down() {
  level endon("end_ark_encounter");
  var_0 = ["descent_crs_feelthemfocusing", "descent_crs_hibernation", "descent_crs_surgeinenergy"];
  var_1 = common_scripts\utility::random(var_0);
  maps\mp\mp_alien_dlc3::playdescentstoryvo(var_1);
  var_2 = 50;
  var_3 = 5;
  var_4 = [];
  var_4[0] = (4147, 2469, 1148);
  var_4[1] = (4488, 2145, 1148);
  var_4[2] = (4437, 1566, 1148);
  var_4[3] = (4164, 1292, 1148);
  var_5 = [];
  var_5[0] = anglesToForward((0, 270, 0));
  var_5[1] = anglesToForward((0, 225, 0));
  var_5[2] = anglesToForward((0, 135, 0));
  var_5[3] = anglesToForward((0, 90, 0));
  common_scripts\utility::exploder(2);
  wait 0.12;
  common_scripts\utility::exploder(3);
  common_scripts\utility::exploder(6);
  wait 1;
  var_6 = getscriptablearray("ark_emp_ent", "targetname");

  foreach(var_8 in var_6) {
    var_8 setscriptablepartstate(0, "idle");
    wait 0.1;
    var_8 setscriptablepartstate(0, "active");
  }

  foreach(var_11 in level.players) {
    if(!isalive(var_11)) {
      continue;
    }
    var_11 dodamage(var_2, var_11.origin, undefined, undefined, "MOD_MELEE");
    var_11 shellshock("alien_kraken_emp", var_3);
    var_11 playlocalsound("plr_emp_hit");
    thread doempdisables(var_11);
    earthquake(0.55, 1.0, var_11.origin, 100);
    playfxontagforclients(level._effect["player_emp_scrn_fx"], var_11, "tag_eye", var_11);

    if(!isDefined(var_11.crafted_items)) {
      continue;
    }
    if(isDefined(var_11.crafted_items["alien_crafting_hypno_trap"]))
      empattempttodestroydeployable(var_11.crafted_items["alien_crafting_hypno_trap"]);

    if(isDefined(var_11.crafted_items["alien_crafting_tesla_trap"]))
      empattempttodestroydeployable(var_11.crafted_items["alien_crafting_tesla_trap"]);
  }

  empprocessdeployablesarray(level.turrets);
  empprocessdeployablesarray(level.placedims);
  empprocessdeployablesarray(level.balldrones);
}

doempdisables(var_0, var_1, var_2) {
  var_0 endon("disconnect");

  if(isDefined(var_1))
    var_3 = var_1;
  else
    var_3 = 10;

  var_0.turn_off_class_skill_activation = 1;
  var_0.player_action_disabled = 1;
  var_0 setclientomnvar("ui_alien_quick_shop_disabled", 1);
  wait(var_3);

  if(!isDefined(var_0)) {
    return;
  }
  var_0.turn_off_class_skill_activation = undefined;
  var_0.player_action_disabled = undefined;
  var_0 setclientomnvar("ui_alien_quick_shop_disabled", 0);
}

empprocessdeployablesarray(var_0) {
  foreach(var_2 in var_0)
  empattempttodestroydeployable(var_2);
}

empattempttodestroydeployable(var_0) {
  if(isDefined(var_0) && !isDefined(var_0.carriedby))
    var_0 notify("death");
}

get_num_online_consoles() {
  var_0 = 0;

  foreach(var_2 in level.attack_points) {
    if(var_2.progresshealth > 0)
      var_0++;
  }

  return var_0;
}

cortex_pulse_logic() {
  level endon("end_ark_encounter");

  while(!isDefined(level.cortex_use_trigger))
    wait 0.1;

  while(!common_scripts\utility::flag("ark_console_cycle_over")) {
    wait_until_enough_alien_killed();
    level.cortex_use_trigger sethintstring(&"MP_ALIEN_DESCENT_CORTEX_USE");
    maps\mp\alien\_outline_proto::enable_outline_for_players(level.cortex, level.players, 3, 0, "high");
    level thread show_cortex_waypoint();
    var_0 = ["descent_crs_enoughpower", "descent_crs_energylevelsmaxed"];
    var_1 = common_scripts\utility::random(var_0);
    level thread maps\mp\mp_alien_dlc3::playdescentstoryvo(var_1);
    level.cortex_use_trigger wait_until_player_use_cortex();
    maps\mp\alien\_gamescore::update_team_encounter_performance("cortex", "times_cortex_activated");
    level.cortex_use_trigger sethintstring("");
    maps\mp\alien\_outline_proto::enable_outline_for_players(level.cortex, level.players, 1, 0, "high");
    level thread hide_cortex_waypoint();

    if(isDefined(level.cortex))
      var_2 = level.cortex;
    else if(isDefined(level.cortex_carrier))
      var_2 = level.cortex_carrier;
    else
      var_2 = level.archer;

    common_scripts\utility::flag_set("cortex_pulse");

    foreach(var_4 in level.players)
    var_4 remove_ark_vo_on_player();

    playsoundatpos(level.cortex.origin, "scn_cortex_activate");
    level thread rumble_players("heavygun_fire", 0.5);
    kill_aliens_with_cortex_pulse();
    wait 1.0;
    common_scripts\utility::flag_clear("cortex_pulse");
    wait 0.5;
    level notify("dlc_vo_notify", "descent_vo", "complete_obelisks");
  }
}

rumble_players(var_0, var_1) {
  wait(var_1);

  foreach(var_3 in level.players)
  var_3 playrumbleonentity(var_0);
}

wait_until_enough_alien_killed() {
  level endon("end_ark_encounter");
  var_0 = 0;
  var_1 = 1;

  if(maps\mp\alien\_utility::isplayingsolo())
    var_2 = 10;
  else
    var_2 = 20;

  while(var_0 < var_2) {
    level waittill("alien_killed", var_3, var_4, var_5);

    if(var_4 == "MOD_SUICIDE") {
      continue;
    }
    if(var_0 > 4 && var_1) {
      var_1 = 0;
      maps\mp\mp_alien_dlc3_vignettes::ark_cortex_help();
    }

    var_0++;
  }
}

kill_aliens_with_cortex_pulse() {
  playFX(level._effect["cortex_blast"], level.cortex.origin + (0, 0, 15));
  wait 1.5;
  var_0 = maps\mp\alien\_spawnlogic::get_alive_agents();

  if(isDefined(level.seeder_active_turrets))
    var_0 = common_scripts\utility::array_combine(var_0, level.seeder_active_turrets);

  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_2 dodamage(var_2.health + 1000, var_2.origin);
    playFX(level._effect["alien_gib"], var_2.origin + (0, 0, 32));
    common_scripts\utility::waitframe();
  }
}

show_cortex_waypoint() {
  if(isDefined(level.cortex_icon))
    level.cortex_icon.alpha = 0.75;
}

hide_cortex_waypoint() {
  if(isDefined(level.cortex_icon))
    level.cortex_icon.alpha = 0;
}

spawn_archer() {
  var_0 = (3832, 1871, 917);
  var_1 = spawn("script_model", var_0);
  var_1 setModel("body_archer_wounded_a");
  var_1.angles = (0, 180, 0);
  level.archer = var_1;
  var_2 = spawn_model("head_archer_a", var_1, "J_spine4", (0, 0, 0));
  level thread archer_vignette_anim_sequence(var_1, var_2);
  level thread archer_vignette_end_anim_sequence(var_1, var_2);
}

archer_vignette_anim_sequence(var_0, var_1) {
  level endon("end_ark_encounter");
  var_0 scriptmodelplayanimdeltamotion("alien_descent_vignette_idle_a");
  var_1 scriptmodelplayanim("alien_descent_vignette_idle_a");
  wait 5;
  common_scripts\utility::flag_wait("start_archer_vignette");
  maps\mp\mp_alien_dlc3_vignettes::descent_vo_inside_ark(var_0, var_1);
  var_0 scriptmodelplayanimdeltamotion("alien_descent_vignette_idle_b");
  var_1 scriptmodelplayanim("alien_descent_vignette_idle_b");
  wait 5;
}

archer_vignette_end_anim_sequence(var_0, var_1) {
  level waittill("cortex_pickedup");
  common_scripts\utility::flag_set("ark_cortex_pickedup");
  var_0 scriptmodelplayanimdeltamotion("alien_descent_vignette_dialogue_3");
  var_1 scriptmodelplayanim("alien_descent_vignette_dialogue_3");
  level waittill("archer_dialogue_3_done");
  var_0 scriptmodelplayanimdeltamotion("alien_descent_vignette_final_loop");
  var_1 scriptmodelplayanim("alien_descent_vignette_final_loop");
}

spawn_model(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", (0, 0, 0));
  var_4 setModel(var_0);
  var_4.origin = var_1 gettagorigin(var_2);
  var_4.angles = var_1 gettagangles(var_2) + var_3;
  var_4 linkto(var_1, var_2);
  return var_4;
}

spawn_archer_force_field() {
  wait 2;

  while(!isDefined(level.cortex))
    wait 0.1;

  var_0 = spawnfx(level._effect["archer_shield"], level.cortex.origin + (0, 20, 7));
  var_1 = spawn("script_origin", level.cortex.origin);
  wait 0.1;
  triggerfx(var_0);
  var_1 playLoopSound("archer_shield_sfx_lp");
  common_scripts\utility::flag_wait("ark_console_event_done");
  var_0 delete();
  var_1 stoploopsound("archer_shield_sfx_lp");
  var_1 delete();
}

reset_consoles() {
  foreach(var_1 in level.attack_points)
  var_1.progresshealth = 200;
}

zap_console(var_0) {
  playFX(level._effect["cortex_blast"], level.cortex.origin);
}

zap_point_to_point(var_0, var_1) {
  if(!isDefined(self.zap_struct)) {
    self.zap_struct = spawnStruct();
    self.zap_struct.attack_bolt = spawn("script_model", var_0);
    self.zap_struct.attack_bolt setModel("tag_origin");
    wait 0.1;
  }

  self.zap_struct.attack_bolt.origin = var_0;
  playFXOnTag(level._effect["ark_beam_attack"], self.zap_struct.attack_bolt, "TAG_ORIGIN");
  self.zap_struct.attack_bolt moveto(var_1, 0.1);
  wait 0.1;
  stopFXOnTag(level._effect["ark_beam_attack"], self.zap_struct.attack_bolt, "TAG_ORIGIN");
}

spawn_wave(var_0) {
  level endon("end_ark_encounter");
  level endon("stop_waves");
  maps\mp\alien\_spawn_director::start_cycle(var_0);
}

use_cortex_to_attack_enemies() {
  level endon("end_ark_encounter");

  while(!common_scripts\utility::flag("ark_console_cycle_over")) {
    while(!isDefined(level.cortex_carrier))
      wait 0.1;

    var_0 = level.cortex_carrier;
    level.cortex_carrier notifyonplayercommand("melee_button_pressed", "+melee");
    level.cortex_carrier notifyonplayercommand("melee_button_pressed", "+melee_breath");
    level.cortex_carrier notifyonplayercommand("melee_button_pressed", "+melee_zoom");
    level.cortex_carrier waittill("melee_button_pressed");

    if(!(isDefined(level.cortex_carrier) && level.cortex_carrier == var_0)) {
      continue;
    }
    var_1 = maps\mp\alien\_spawnlogic::get_alive_agents();

    if(isDefined(level.seeder_active_turrets))
      var_1 = common_scripts\utility::array_combine(var_1, level.seeder_active_turrets);

    foreach(var_3 in var_1) {
      if(!isDefined(var_3)) {
        continue;
      }
      if(distancesquared(level.cortex_carrier.origin, var_3.origin) > 40000) {
        continue;
      }
      if(isDefined(level.cortex_carrier)) {
        level.cortex_carrier zap_point_to_point(level.cortex_carrier.origin, var_3.origin);

        if(!isDefined(var_3)) {
          continue;
        }
        var_3.cortex_kill = 1;
        var_3 dodamage(var_3.health + 1000, var_3.origin, level.cortex_carrier, level.cortex_carrier);
        playFX(level._effect["alien_gib"], var_3.origin + (0, 0, 32));
      }

      wait 0.1;
    }

    wait 1.0;
  }
}

disable_cortex_for_ark_encounter() {
  level.archer thread spawn_archer_force_field();
  maps\mp\alien\_cortex::turn_off_cortex();
  common_scripts\utility::flag_wait("ark_console_cycle_over");
  wait 0.1;
  maps\mp\alien\_cortex::turn_on_cortex();
}

console_threatbias_setup() {
  createthreatbiasgroup("ignore_consoles");
  createthreatbiasgroup("consoles");
  setignoremegroup("consoles", "ignore_consoles");
}

make_aliens_ignore_consoles() {
  level endon("end_ark_encounter");

  while(!common_scripts\utility::flag("ark_console_cycle_over")) {
    level waittill("spawned_agent", var_0);

    if(isDefined(var_0.alien_type) && var_0.alien_type == "elite")
      var_0 setthreatbiasgroup("ignore_consoles");
  }
}

wait_until_player_use_cortex() {
  level endon("end_ark_encounter");
  var_0 = 0;

  while(!var_0) {
    self waittill("trigger", var_1);

    if(!isplayer(var_1)) {
      continue;
    }
    if(common_scripts\utility::flag("cortex_carryable")) {
      break;
    }

    if(useholdthink_cortex(var_1))
      var_0 = 1;
  }
}

remove_cortex_spot_when_possible() {
  self endon("disconnect");

  while(isDefined(self.cortex_spot) && !self.cortex_spot.done_with_use_bar)
    wait 0.1;

  if(isDefined(self.cortex_spot))
    self.cortex_spot = undefined;
}

useholdthink_cortex(var_0) {
  var_0 endon("disconnect");
  var_0.cortex_spot = spawnStruct();
  var_0.cortex_spot.curprogress = 0;
  var_0.cortex_spot.inuse = 1;
  var_0.cortex_spot.userate = 1;
  var_0.cortex_spot.usetime = 1000;
  var_0.cortex_spot.done_with_use_bar = 0;
  var_0.hasprogressbar = 1;
  var_1 = useholdthinkloopcortex(var_0, self, 40000, 6);
  var_0.hasprogressbar = 0;

  if(isDefined(var_0.cortex_spot)) {
    var_0.cortex_spot.inuse = 0;
    var_0.cortex_spot.curprogress = 0;
  }

  var_0.cortex_spot = undefined;
  return var_1;
}

wait_until_player_repairs_console() {
  var_0 = 0;

  while(!var_0) {
    self waittill("trigger", var_1);

    if(!isplayer(var_1)) {
      continue;
    }
    if(useholdthink(var_1)) {
      var_0 = 1;
      var_1 thread remove_repair_spot_when_possible();
    }
  }
}

remove_repair_spot_when_possible() {
  self endon("disconnect");

  while(isDefined(self.repair_spot) && !self.repair_spot.done_with_use_bar)
    wait 0.1;

  if(isDefined(self.repair_spot))
    self.repair_spot = undefined;
}

useholdthink(var_0) {
  var_0 endon("disconnect");
  var_0.repair_spot = spawnStruct();
  var_0.repair_spot.curprogress = 0;
  var_0.repair_spot.inuse = 1;
  var_0.repair_spot.userate = 1;

  if(maps\mp\alien\_utility::isplayingsolo())
    var_0.repair_spot.usetime = 2000;
  else
    var_0.repair_spot.usetime = 5000;

  if(var_0 maps\mp\alien\_perk_utility::has_perk("perk_rigger", [1, 2, 3, 4]))
    var_0.repair_spot.usetime = var_0.repair_spot.usetime * 0.5;

  var_0.repair_spot.done_with_use_bar = 0;

  if(isplayer(var_0))
    var_0 thread personalusebar(self);

  var_0.hasprogressbar = 1;
  var_1 = useholdthinkloop(var_0, self, 40000);
  var_0.hasprogressbar = 0;

  if(isDefined(var_0.repair_spot)) {
    var_0.repair_spot.inuse = 0;
    var_0.repair_spot.curprogress = 0;
  }

  return var_1;
}

personalusebar(var_0, var_1) {
  self endon("disconnect");
  self endon("game_ended");

  if(isDefined(var_1))
    self setclientomnvar("ui_securing", var_1);
  else
    self setclientomnvar("ui_securing", 5);

  var_2 = -1;

  while(self.sessionstate == "playing" && isDefined(var_0) && isDefined(self.repair_spot) && self.repair_spot.inuse && !level.gameended) {
    var_2 = self.repair_spot.userate;
    self setclientomnvar("ui_securing_progress", self.repair_spot.curprogress / self.repair_spot.usetime);
    wait 0.05;
  }

  self setclientomnvar("ui_securing", 0);
  self setclientomnvar("ui_securing_progress", 0);

  if(isDefined(self.repair_spot))
    self.repair_spot.done_with_use_bar = 1;
}

personalusebarcortex(var_0, var_1) {
  self endon("disconnect");
  self endon("game_ended");

  if(isDefined(var_1))
    self setclientomnvar("ui_securing", var_1);
  else
    self setclientomnvar("ui_securing", 5);

  var_2 = -1;

  while(self.sessionstate == "playing" && isDefined(var_0) && isDefined(self.cortex_spot) && self.cortex_spot.inuse && !level.gameended) {
    var_2 = self.cortex_spot.userate;
    self setclientomnvar("ui_securing_progress", self.cortex_spot.curprogress / self.cortex_spot.usetime);
    wait 0.05;
  }

  self setclientomnvar("ui_securing", 0);
  self setclientomnvar("ui_securing_progress", 0);

  if(isDefined(self.cortex_spot))
    self.cortex_spot.done_with_use_bar = 1;
}

useholdthinkloop(var_0, var_1, var_2) {
  while(!level.gameended && isDefined(self) && isDefined(var_0) && isDefined(var_0.repair_spot) && var_0.sessionstate == "playing" && var_0 usebuttonpressed() && var_0.repair_spot.curprogress < var_0.repair_spot.usetime) {
    if(isDefined(var_1) && isDefined(var_2)) {
      if(distancesquared(var_0.origin, var_1.origin) > var_2)
        return 0;
    }

    var_0.repair_spot.curprogress = var_0.repair_spot.curprogress + 50 * var_0.repair_spot.userate;
    var_0.repair_spot.userate = 1;

    if(var_0.repair_spot.curprogress >= var_0.repair_spot.usetime)
      return var_0.sessionstate == "playing";

    wait 0.05;
  }

  return 0;
}

useholdthinkloopcortex(var_0, var_1, var_2, var_3) {
  var_0 endon("disconnect");
  level endon("game_ended");
  var_0 setclientomnvar("ui_securing", var_3);
  var_4 = -1;
  var_5 = 0;

  while(!level.gameended && isDefined(self) && isDefined(var_0) && isDefined(var_0.cortex_spot) && var_0.sessionstate == "playing" && var_0 usebuttonpressed() && var_0.cortex_spot.curprogress < var_0.cortex_spot.usetime) {
    if(isDefined(var_1) && isDefined(var_2)) {
      if(distancesquared(var_0.origin, var_1.origin) > var_2)
        return 0;
    }

    var_4 = var_0.cortex_spot.userate;
    var_0 setclientomnvar("ui_securing_progress", var_0.cortex_spot.curprogress / var_0.cortex_spot.usetime);
    var_0.cortex_spot.curprogress = var_0.cortex_spot.curprogress + 50 * var_0.cortex_spot.userate;
    var_0.cortex_spot.userate = 1;

    if(var_0.cortex_spot.curprogress >= var_0.cortex_spot.usetime) {
      var_5 = 1;
      break;
    }

    wait 0.05;
  }

  var_0 setclientomnvar("ui_securing", 0);
  var_0 setclientomnvar("ui_securing_progress", 0);

  if(isDefined(var_0.cortex_spot))
    var_0.cortex_spot.done_with_use_bar = 1;

  if(var_5 && var_0.sessionstate == "playing")
    return 1;
  else
    return 0;
}

remove_ark_vo_on_player() {
  foreach(var_2, var_1 in level.alien_vo_priority_level)
  maps\mp\alien\_music_and_dialog::remove_vo_data("obelisk", var_1);
}

ark_defense_lightning(var_0) {
  level endon("end_ark_encounter");
  var_1 = 5;
  var_2 = 200;
  var_3 = var_2 * var_2;
  var_4 = (4171, 2469, 1179);
  var_5 = [0];
  var_6 = [];
  var_7 = [];
  var_7[0] = (4171, 2469, 1179);
  var_7[1] = (4490, 2149, 1179);
  var_7[2] = (4478, 1600, 1179);
  var_7[3] = (4181, 1278, 1179);

  foreach(var_9 in level.players) {
    if(isDefined(var_9) && isalive(var_9) && !var_9 maps\mp\alien\_utility::is_in_laststand())
      var_6 = common_scripts\utility::add_to_array(var_6, var_9);
  }

  var_9 = common_scripts\utility::random(var_6);
  var_11 = var_9.origin;

  if(var_11[2] < 890)
    var_11 = (var_11[0], var_11[1], 890);

  if(var_11[1] > 1900)
    var_5 = [0, 1];
  else if(var_11[1] < 1830)
    var_5 = [2, 3];
  else
    var_5 = [0, 3];

  var_4 = var_7[common_scripts\utility::random(var_5)];
  var_11 = ark_zap_attack(var_4, var_9, var_11, undefined, 1);
  wait 0.5;
  var_11 = ark_zap_attack(var_4, var_9, var_11);
  wait 0.5;
  var_11 = ark_zap_attack(var_4, var_9, var_11);
  wait 1.0;
  var_11 = ark_zap_attack(var_4, undefined, var_11, 1);
  var_12 = 0;
  var_13 = 5;
  var_14 = 0.25;

  while(var_12 < var_13) {
    foreach(var_9 in level.players) {
      if(distancesquared(var_11, var_9.origin) < var_3)
        var_9 dodamage(var_1, var_9.origin, undefined, undefined, "MOD_MELEE");
    }

    var_12 = var_12 + var_14;
    wait(var_14);
  }
}

ark_zap_attack(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_1)) {
    var_2 = var_1.origin;

    if(var_2[2] < 890)
      var_2 = (var_2[0], var_2[1], 890);
  }

  var_5 = (randomintrange(-100, 100), randomintrange(-100, 100), 0);
  var_2 = var_2 + var_5;
  zap_point_to_point(var_0, var_2);
  playFX(level._effect["ark_beam_glow"], var_2);
  playsoundatpos(var_2, "turret_shock");
  wait 0.1;

  if(!isDefined(var_3))
    var_6 = playFX(level._effect["ark_attack_ball_buildup"], var_2);
  else
    var_6 = playFX(level._effect["ark_attack_ball"], var_2);

  if(isDefined(var_4))
    playsoundatpos(var_2, "scn_ark_electric_ball");

  return var_2;
}

activate_ark_defenses() {
  while(!common_scripts\utility::flag("ark_console_event_done")) {
    ark_defense_lightning();
    wait(level.ark_defense_wait);
  }
}

trigger_ark_defenses() {
  while(level.elapsed_time < 60.0)
    wait 0.1;

  wait 10;
  level.ark_defense_wait = 40;
  level thread activate_ark_defenses();

  while(level.elapsed_time < 120.0)
    wait 0.1;

  level.ark_defense_wait = 20;

  while(level.elapsed_time < 180.0)
    wait 0.1;

  level.ark_defense_wait = 10;
}

debug_open_ark_doors() {
  level thread open_ark_door("ark_door_01", 0.1);
  level thread open_ark_door("ark_door_02", 0.1);
  level thread open_ark_door("ark_door_03", 0.1);
  level thread open_ark_door("ark_door_04", 0.1);
}

open_ark_doors() {
  common_scripts\utility::flag_wait("area_3_done");
  open_ark_door("ark_door_01", 5);
  wait 5;
  open_ark_door("ark_door_02", 5);
  wait 5;
  open_ark_door("ark_door_03", 5);
  wait 5;
  open_ark_door("ark_door_04", 5);
  wait 5;
}

open_ark_doors_end() {
  open_ark_door("ark_door_04", 5);
  wait 5;
  open_ark_door("ark_door_03", 5);
  wait 5;
  open_ark_door("ark_door_02", 5);
  wait 5;
  open_ark_door("ark_door_01", 5);
  common_scripts\utility::flag_wait("players_left_ark");
  close_ark_door("ark_door_04", 2);
}

open_ark_door(var_0, var_1) {
  var_2 = getent(var_0 + "a", "targetname");

  if(isDefined(var_2)) {
    var_3 = anglestoup(var_2.angles);
    var_4 = (var_3[0] * -1, var_3[1] * -1, var_3[2] * -1);
    var_5 = var_2.origin + 300 * var_4;
    var_2 moveto(var_5, var_1);
  }

  var_6 = getent(var_0 + "b", "targetname");

  if(isDefined(var_6)) {
    var_7 = anglestoright(var_6.angles);
    var_8 = var_7;
    var_5 = var_6.origin + 300 * var_8;
    var_6 moveto(var_5, var_1);
  }

  var_9 = getent(var_0 + "c", "targetname");

  if(isDefined(var_9)) {
    var_7 = anglestoright(var_9.angles);
    var_5 = var_9.origin + 300 * var_7;
    var_9 moveto(var_5, var_1);
  }

  switch (var_0) {
    case "ark_door_01":
      playsoundatpos((621, 1855, 948), "scn_ark_door_open");
      break;
    case "ark_door_02":
      playsoundatpos((1447, 1872, 948), "scn_ark_door_open");
      break;
    case "ark_door_03":
      playsoundatpos((2015, 1868, 948), "scn_ark_door_open");
      break;
    case "ark_door_04":
      playsoundatpos((2807, 1860, 948), "scn_ark_door_open");
      break;
  }

  wait 1.0;
  var_10 = getent(var_0 + "_clip", "targetname");

  if(isDefined(var_10)) {
    var_10 notsolid();
    var_10 connectpaths();
  }
}

close_ark_doors() {
  close_ark_door("ark_door_04", 5);
  wait 0.1;
  close_ark_door("ark_door_03", 5);
  wait 0.1;
  close_ark_door("ark_door_02", 5);
  wait 0.1;
  close_ark_door("ark_door_01", 5);
  wait 5;
}

close_ark_door(var_0, var_1) {
  var_1 = 5.0;
  var_2 = getent(var_0 + "a", "targetname");

  if(isDefined(var_2)) {
    var_3 = anglestoup(var_2.angles);
    var_4 = var_2.origin + 300 * var_3;
    var_2 moveto(var_4, var_1);
  }

  var_5 = getent(var_0 + "b", "targetname");

  if(isDefined(var_5)) {
    var_6 = anglestoright(var_5.angles);
    var_7 = (var_6[0] * -1, var_6[1] * -1, var_6[2] * -1);
    var_4 = var_5.origin + 300 * var_7;
    var_5 moveto(var_4, var_1);
  }

  var_8 = getent(var_0 + "c", "targetname");

  if(isDefined(var_8)) {
    var_6 = anglestoright(var_8.angles);
    var_6 = (var_6[0] * -1, var_6[1] * -1, var_6[2] * -1);
    var_4 = var_8.origin + 300 * var_6;
    var_8 moveto(var_4, var_1);
  }

  switch (var_0) {
    case "ark_door_01":
      playsoundatpos((621, 1855, 948), "scn_ark_door_close");
      break;
    case "ark_door_02":
      playsoundatpos((1447, 1872, 948), "scn_ark_door_close");
      break;
    case "ark_door_03":
      playsoundatpos((2015, 1868, 948), "scn_ark_door_close");
      break;
    case "ark_door_04":
      playsoundatpos((2807, 1860, 948), "scn_ark_door_close");
      break;
  }

  var_9 = getent(var_0 + "_clip", "targetname");

  if(isDefined(var_9)) {
    var_9 solid();
    var_9 disconnectpaths();
  }
}

teleport_players_not_in_ark() {
  wait 1.0;
  var_0 = getent("ark_interior_volume", "targetname");
  var_1 = 0;

  if(isDefined(var_0)) {
    foreach(var_3 in level.players) {
      if(!var_3 istouching(var_0)) {
        level thread teleport_player_to_ark(var_3);
        var_1++;
      }
    }
  }

  wait 1.0;
  common_scripts\utility::flag_set("everyone_in_ark");
}

teleport_player_to_ark(var_0) {
  var_1 = var_0;

  if(isDefined(var_0.reviveent))
    var_1 = var_0.reviveent;

  if(!isDefined(var_0.forceteleportorigin))
    var_0 thread find_spot_to_teleport(var_1);
}

teleport_player_to_spot(var_0, var_1) {
  self endon("disconnect");
  self cancelmantle();
  self dontinterpolate();
  self setorigin(var_0);
  self.forceteleportorigin = var_0;

  if(isDefined(var_1)) {
    var_1.origin = var_0;
    self.reviveiconent.origin = var_0;
  }

  self notify("teleport_finished");

  if(isDefined(self.teleport_overlay)) {
    self.teleport_overlay fadeovertime(0.75);
    self.teleport_overlay.alpha = 0;
    wait 1;

    if(isDefined(self.teleport_overlay))
      self.teleport_overlay destroy();
  }

  maps\mp\_utility::clearlowermessage("cargo_teleport");

  if(isDefined(self.reviveent))
    thread wait_for_spawn_and_remove_forceteleport();
  else
    self.forceteleportorigin = undefined;
}

wait_for_spawn_and_remove_forceteleport() {
  for(;;) {
    level waittill("player_spawned", var_0);

    if(self == var_0) {
      break;
    }
  }

  self.forceteleportorigin = undefined;
}

teleport_black_screen() {
  self endon("disconnect");
  maps\mp\_utility::setlowermessage("cargo_teleport", & "MP_ALIEN_BEACON_CARGO_TELEPORT", 3);
  self.teleport_overlay = newclienthudelem(self);
  self.teleport_overlay.x = 0;
  self.teleport_overlay.y = 0;
  self.teleport_overlay setshader("black", 640, 480);
  self.teleport_overlay.alignx = "left";
  self.teleport_overlay.aligny = "top";
  self.teleport_overlay.sort = 1;
  self.teleport_overlay.horzalign = "fullscreen";
  self.teleport_overlay.vertalign = "fullscreen";
  self.teleport_overlay.alpha = 0;
  self.teleport_overlay.foreground = 1;
  self.teleport_overlay fadeovertime(0.75);
  self.teleport_overlay.alpha = 1;
}

find_spot_to_teleport(var_0) {
  var_1 = [];
  var_1[0] = (3390, 1924, 948);
  var_1[1] = (3390, 1799, 948);
  var_1[2] = (3246, 1923, 948);
  var_1[3] = (3226, 1808, 948);
  var_2 = (0, 0, 0);
  var_3 = 0;

  while(!var_3) {
    foreach(var_5 in var_1) {
      if(canspawn(var_5) && !positionwouldtelefrag(var_5)) {
        if(!isDefined(self.teleport_overlay)) {
          thread teleport_black_screen();
          wait 1;
        }

        if(canspawn(var_5) && !positionwouldtelefrag(var_5)) {
          if(isDefined(var_0) && var_0 != self)
            teleport_player_to_spot(var_5, var_0);
          else
            teleport_player_to_spot(var_5);

          var_3 = 1;
          break;
        } else
          continue;
      }
    }

    wait 0.1;
  }

  self notify("player_teleported");
}

open_ark_obelisks() {
  maps\mp\mp_alien_dlc3::open_obelisk("ark_interior_obelisk_l", "on_interior");
  maps\mp\mp_alien_dlc3::open_obelisk("ark_interior_obelisk_r", "on_interior");
}