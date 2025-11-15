/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\carrier_defend_sparrow.gsc
*******************************************/

defend_sparrow_pre_load() {
  common_scripts\utility::flag_init("player_entering_sparrow");
  common_scripts\utility::flag_init("defend_sparrow_start");
  common_scripts\utility::flag_init("defend_sparrow_finished");
  common_scripts\utility::flag_init("sparrow_wave1_down");
  common_scripts\utility::flag_init("ac_130_hit");
  common_scripts\utility::flag_init("ac130_wave1_attack");
  common_scripts\utility::flag_init("ac130_wave2_attack");
  common_scripts\utility::flag_init("ac130_wave3_attack");
  common_scripts\utility::flag_init("ac130_wave4_attack");
  common_scripts\utility::flag_init("ac130_wave5_attack");
  common_scripts\utility::flag_init("ac130_final_approach");
  common_scripts\utility::flag_init("ac130_start_attack_run");
  common_scripts\utility::flag_init("ac_130_attack_run_1_done");
  common_scripts\utility::flag_init("ac_130_attack_run_2_done");
  common_scripts\utility::flag_init("ac_130_attack_run_3_done");
  common_scripts\utility::flag_init("ac_130_attack_run_4_done");
  common_scripts\utility::flag_init("ac_130_attack_run_5_done");
  common_scripts\utility::flag_init("gunship_death_path");
  common_scripts\utility::flag_init("gunship_left_path");
  common_scripts\utility::flag_init("gunship_right_path");
  precachedigitaldistortcodeassets();
  precachemodel("projectile_slamraam_missile");
  precachemodel("crr_sparrow_launcher");
  precacheitem("sparrow_missile");
  precacheitem("sparrow_missile_flak");
  precacheshader("dpad_laser_designator");
  precacheitem("sparrow_targeting_device");
  precacheshader("crr_hud_missile_system_overlay_01");
  precacheshader("crr_hud_lock_on_box");
  precacheshader("crr_hud_interlace_mask");
  precacheshader("crr_hud_rocket_icon_loaded");
  precacheshader("crr_hud_rocket_icon_empty");
  precacheshader("crr_hud_arrow_l");
  precacheshader("crr_hud_arrow_r");
  precacheshader("crr_hud_icon_class_2");
  precacheshader("crr_hud_icon_class_4");
  precacheshader("crr_hud_icon_fed_gunship");
  precacheshader("crr_hud_icon_fed_helicopter");
  precacheshader("crr_hud_icon_fed_inflatable");
  precacheshader("crr_hud_missl_sys_ladder_l");
  precacheshader("crr_hud_missl_sys_ladder_r");
  precacheshader("cinematic");
  precacheshader("hud_red_dot");
  precachemodel("com_barrel_black_h");
  precachestring(&"CARRIER_ENGAGE");
  precachestring(&"CARRIER_USE_SPARROW");
  precachestring(&"CARRIER_USE_SPARROW_CONSOLE");
  precachestring(&"CARRIER_SPARROW_FIRE");
  precachestring(&"CARRIER_SPARROW_FIRE_PC");
  maps\_utility::add_hint_string("fire_sparrow", & "CARRIER_SPARROW_FIRE");
  maps\_utility::add_hint_string("fire_sparrow_pc", & "CARRIER_SPARROW_FIRE_PC");
  precacherumble("ac130_40mm_fire");
  precachemodel("crr_laptop_toughbook_obj");
  precacheitem("ac130_25mm_carrier");
  precacheitem("ac130_40mm_carrier");
  precacheitem("ac130_105mm_carrier");
  level.defend_sparrow_control = getent("defend_sparrow_control", "targetname");
  level.defend_sparrow_control maps\_utility::hide_entity();
  var_0 = getent("sparrow_launcher", "targetname");
  var_1 = getent("sparrow_launcher_damage", "targetname");
  var_1 linkto(var_0);
  var_1 maps\_utility::hide_entity();
}

setup_defend_sparrow() {
  level.start_point = "defend_sparrow";
  maps\carrier_code::setup_common();
  maps\carrier_code::spawn_allies();
  thread maps\carrier_audio::aud_check("defend_sparrow");
  var_0 = getent("water_wake_intro", "targetname");
  var_0 delete();
  thread spawn_ac130();
  thread sparrow_dead_operator();
}

begin_defend_sparrow() {
  thread sparrow_handle_ps4_ssao(0);
  common_scripts\utility::waitframe();
  thread run_sparrow_down_vo();
  wait 1;
  thread cleanup_enemies();
  common_scripts\utility::flag_wait("defend_sparrow_finished");
  level.player setviewkickscale(level.original_view_kick);
  level maps\_utility::delaythread(4, ::heli_cleanup);
  wait 3;
  var_0 = getent("sparrow_launcher_damage", "targetname");
  var_0 maps\_utility::show_entity();
  level.player maps\carrier_code_sparrow::sam_remove_control();
  common_scripts\utility::exploder(5501);
  maps\_utility::stop_exploder(5505);
  thread maps\_utility::autosave_now();
}

sparrow_handle_ps4_ssao(var_0) {
  if(!level.ps4) {
    return;
  }
  if(!var_0)
    common_scripts\utility::flag_wait("defend_sparrow_start");

  setsaveddvar("r_ssaoScriptScale", 0);
  level waittill("odin_strike_over");
  maps\_art::enable_ssao_over_time(2);
}

catchup_defend_sparrow() {}

run_defend_sparrow() {
  level.player endon("death");
  var_0 = common_scripts\utility::getstruct("sparrow_run_animnode", "targetname");
  var_1 = maps\_utility::spawn_anim_model("player_rig");
  var_1 hide();
  var_1 dontcastshadows();
  var_0 maps\_anim::anim_first_frame_solo(var_1, "sparrow_enter_player");
  level.defend_sparrow_control maps\_utility::glow();
  var_2 = getent("sparrow_trigger_player", "targetname");
  var_2 setcursorhint("HINT_NOICON");

  if(level.console || level.player common_scripts\utility::is_player_gamepad_enabled())
    var_2 sethintstring(&"CARRIER_USE_SPARROW_CONSOLE");
  else
    var_2 sethintstring(&"CARRIER_USE_SPARROW");

  level.ds_vo_timer_left = 0;
  level.ds_vo_timer_right = 0;
  level notify("jet_battle_end");
  maps\player_scripted_anim_util::waittill_trigger_activate_looking_at(var_2, level.defend_sparrow_control, cos(40), 0, 1);
  common_scripts\utility::flag_set("obj_sparrow_complete");
  level.defend_sparrow_control maps\_utility::stopglow();
  level.original_view_kick = level.player getviewkickscale();
  level.player setviewkickscale(level.original_view_kick * 0.1);
  level.ac_130 thread maps\carrier_code_sparrow::sam_add_target();
  level.ac_130 thread ac130_constant_target();
  common_scripts\utility::flag_set("player_entering_sparrow");
  maps\_utility::battlechatter_off("allies");
  maps\_utility::flavorbursts_off("allies");
  level.player playerlinktoblend(var_1, "tag_player", 0.333333);
  level.player thread maps\carrier_code::cinematic_on();
  var_0 thread maps\_anim::anim_single_solo(var_1, "sparrow_enter_player");
  maps\_utility::delaythread(0.05, maps\_anim::anim_set_rate, [var_1], "sparrow_enter_player", 1.5);
  wait 0.333333;
  var_1 show();
  var_3 = getanimlength(var_1 maps\_utility::getanim("sparrow_enter_player"));
  wait((var_3 - 0.8) / 1.5);
  level.player thread maps\carrier_code_sparrow::sam_give_control();
  level.player notify("use_sam");
  var_1 waittillmatch("single anim", "end");
  var_1 delete();
  common_scripts\utility::exploder(5505);
  common_scripts\utility::waitframe();
  thread maps\carrier::obj_gunship();
  level.helis_can_respawn = 1;
  level.heli_kill_counter = 0;
  thread heli_combat_kill_counter();
  thread run_background_zodiacs();
  thread spawn_background_helis();
  common_scripts\utility::flag_set("defend_sparrow_start");
  thread sparrow_fire_hint();
  thread maps\_utility::vision_set_fog_changes("carrier", 0);
  thread maps\_art::sunflare_changes("carrier_sparrow_sunflare", 0);
  thread run_defend_vo();
  wait 0.25;
}

sparrow_fire_hint() {
  level endon("sparrow_missile_fired");
  wait 5;
  var_0 = getkeybinding("+speed_throw");
  var_1 = isDefined(var_0) && var_0["count"] != 0;

  if(var_1)
    level.player thread maps\_utility::display_hint("fire_sparrow");
  else
    level.player thread maps\_utility::display_hint("fire_sparrow_pc");
}

sparrow_dead_operator() {
  var_0 = maps\_utility::spawn_targetname("defend_sparrow_operator", 1);
  var_0.animname = "generic";
  var_0.ignoreall = 1;
  var_0.ignoreme = 1;
  var_0.diequietly = 1;
  var_0 setlookattext("", & "");
  var_0.name = "";
  var_0 setCanDamage(0);
  var_0.a.nodeath = 1;
  var_1 = maps\_utility::spawn_anim_model("sparrow_laptop");
  var_2 = common_scripts\utility::getstruct("sparrow_run_animnode", "targetname");
  var_3 = [var_0, var_1];
  common_scripts\utility::waitframe();
  var_2 maps\_anim::anim_first_frame_solo(var_0, "sparrow_enter");
  var_2 maps\_anim::anim_first_frame_solo(var_1, "sparrow_enter");
  var_4 = var_1 gettagorigin("j_prop_1");
  var_5 = var_1 gettagangles("j_prop_1");
  level.defend_sparrow_control.origin = var_4;
  level.defend_sparrow_control.angles = var_5;
  level.defend_sparrow_control linkto(var_1, "j_prop_1");
  common_scripts\utility::flag_wait("player_entering_sparrow");
  var_2 thread maps\_anim::anim_single(var_3, "sparrow_enter");
  common_scripts\utility::waitframe();
  maps\_anim::anim_set_rate(var_3, "sparrow_enter", 1.5);
  thread maps\carrier_audio::aud_carr_dead_sparrow_ops();
  var_0 waittillmatch("single anim", "end");
  level.defend_sparrow_control unlink();
  var_1 delete();
  var_2 maps\_anim::anim_last_frame_solo(var_0, "sparrow_enter");
  common_scripts\utility::flag_wait("defend_sparrow_start");
  wait 0.1;
  var_0 delete();
}

cleanup_enemies() {
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(isalive(var_2))
      var_2 thread maps\ss_util::fake_death_bullet(1.5);
  }
}

run_sparrow_down_vo() {
  level endon("defend_sparrow_start");
  level.hesh maps\_utility::smart_dialogue("carrier_hsh_weneedtotarget");
  thread run_defend_sparrow();
  thread run_nag_vo();
}

run_nag_vo() {
  level endon("defend_sparrow_start");
  var_0 = maps\_utility::make_array("carrier_hsh_logangetonthat", "carrier_hsh_getonthemark", "carrier_hsh_adamgrabtheguidance");
  maps\carrier_code::nag_until_flag(var_0, "defend_sparrow_start", 5, 10, 5);
}

run_defend_vo() {
  level endon("player_failed_gunship");
  wait 0.2;
  maps\_utility::smart_radio_dialogue("carrier_us1_thereitisenemy");
  maps\_utility::smart_radio_dialogue("carrier_us1_targettheac130");
  thread death_warning_vo();
  thread run_background_vo();
  common_scripts\utility::flag_wait("ac130_wave5_attack");
  maps\_utility::smart_radio_dialogue("carrier_hsh_thegunshipiscircling");
  wait 3;

  if(level.heli_kill_counter < 1)
    maps\_utility::smart_radio_dialogue("carrier_hsh_takeoutthosechoppers_2");

  while(!common_scripts\utility::flag("ac_130_attack_run_4_done")) {
    common_scripts\utility::flag_wait("ac130_start_attack_run");
    maps\_utility::smart_radio_dialogue("carrier_us1_theac130ismaking");
  }

  common_scripts\utility::flag_wait("defend_sparrow_finished");
  wait 0.8;
  maps\_utility::smart_radio_dialogue("carrier_ttn_radarisclearall");
}

death_warning_vo() {
  level endon("defend_sparrow_finished");
  common_scripts\utility::flag_wait("ac_130_attack_run_4_done");
  common_scripts\utility::flag_wait("ac130_start_attack_run");
  maps\_utility::smart_radio_dialogue("carrier_hsh_wecanttakeanother");
}

run_background_vo() {
  level endon("defend_sparrow_finished");
  wait 1.5;
  maps\_utility::smart_radio_dialogue_overlap("carrier_us1_maingunsdownwe");
  maps\_utility::smart_radio_dialogue_overlap("carrier_us2_hullbreachhullbreach");
  maps\_utility::smart_radio_dialogue_overlap("carrier_us2_thisistheoregon");
  maps\_utility::smart_radio_dialogue_overlap("carrier_ttn_sendingrescueteamsto");
  maps\_utility::smart_radio_dialogue_overlap("carrier_us1_weneedassistanceasap");
  maps\_utility::smart_radio_dialogue_overlap("carrier_ttn_attemptingtorerouteair");
  maps\_utility::smart_radio_dialogue_overlap("carrier_us2_hulliscompromisedabandon");
  maps\_utility::smart_radio_dialogue_overlap("carrier_hp2_comeinoregonyou");
  maps\_utility::smart_radio_dialogue_overlap("carrier_ttn_wevelostcommunications");
  maps\_utility::smart_radio_dialogue_overlap("carrier_hp2_wehavebeencut");
}

destroyer_mg_monitor() {
  level endon("defend_sparrow_finished");
  self endon("death");

  for(;;) {
    if(self.origin[0] >= 3600 && self.origin[0] <= 6600)
      destroyer_mg_fire();

    wait 0.05;
  }
}

destroyer_mg_fire() {
  level endon("defend_sparrow_finished");
  var_0 = common_scripts\utility::getstructarray("destroyer4_mg_fire", "targetname");
  var_1 = common_scripts\utility::getclosest(self.origin, var_0);
  var_2 = var_1 common_scripts\utility::spawn_tag_origin();
  var_3 = common_scripts\utility::getstruct(var_1.target, "targetname");
  var_4 = var_3 common_scripts\utility::spawn_tag_origin();
  var_5 = common_scripts\utility::getstruct(var_3.target, "targetname");

  if(common_scripts\utility::cointoss()) {
    var_4 moveto(var_5.origin, 2.5);
    var_2 destroyer_volley(var_4);
  } else
    var_2 destroyer_volley(self);

  var_2 delete();
  var_4 delete();
}

destroyer_ac130_exchange() {
  level endon("defend_sparrow_finished");
  var_0 = common_scripts\utility::getstructarray("destroyer_ac130_fire", "targetname");
  var_1 = level.destroyer_target;

  for(;;) {
    common_scripts\utility::flag_wait("ac130_start_attack_run");
    common_scripts\utility::array_thread(var_0, ::destroyer_volley, var_1);
  }
}

destroyer_volley(var_0) {
  level endon("defend_sparrow_finished");

  for(var_1 = 0; var_1 < 29; var_1++) {
    var_2 = magicbullet("ac130_25mm_carrier", self.origin, var_0.origin);
    wait 0.15;
  }
}

run_background_zodiacs() {
  level.sparrow_zodiacs = [];
  wait 0.1;
  maps\_utility::array_spawn_function_noteworthy("sparrow_zodiacs", ::bg_zodiac_respawn);
  maps\_utility::array_spawn_function_noteworthy("sparrow_zodiacs", ::zodiac_setup);
  maps\_vehicle::spawn_vehicles_from_targetname_and_drive("sparrow_zodiac_1");
  maps\_vehicle::spawn_vehicles_from_targetname_and_drive("sparrow_zodiac_2");
  maps\_vehicle::spawn_vehicles_from_targetname_and_drive("sparrow_zodiac_3");
  maps\_vehicle::spawn_vehicles_from_targetname_and_drive("sparrow_zodiac_4");
}

bg_zodiac_respawn() {
  level endon("defend_sparrow_finished");
  level.sparrow_zodiacs = common_scripts\utility::add_to_array(level.sparrow_zodiacs, self);
  maps\carrier_code_sparrow::sam_add_target();
  var_0 = self.spawner.targetname;
  common_scripts\utility::waittill_any("death", "reached_dynamic_path_end");

  if(isDefined(self.riders)) {
    foreach(var_2 in self.riders) {
      if(isDefined(var_2))
        var_2 delete();
    }
  }

  if(isDefined(self))
    self delete();

  wait 0.25;
  level.sparrow_zodiacs = maps\_utility::array_removedead(level.sparrow_zodiacs);
  maps\_utility::array_spawn_function_targetname(var_0, ::bg_zodiac_respawn);
  maps\_vehicle::spawn_vehicles_from_targetname_and_drive(var_0);
}

zodiac_setup() {
  self.health = 55000;
  self.currenthealth = self.health;
  thread zodiac_sparrow_death();
  thread maps\carrier_code_zodiac::zodiac_treadfx();
  thread maps\carrier_code_zodiac::setup_fake_riders();
}

zodiac_sparrow_death() {
  self waittill("sparrow_hit_zodiac");
  var_0 = self.origin + 250 * vectornormalize(level.player.origin - self.origin);
  thread maps\carrier_code_zodiac::explode_single_zodiac(0.33, var_0);
}

spawn_pre_sparrow_helis() {
  level.helis_can_respawn = 1;
  maps\_utility::array_spawn_function_targetname("ds_helis_pre_path", maps\carrier_code::heli_fast_explode, 100);
  maps\_utility::array_spawn_function_targetname("ds_helis_pre_path", ::heli_attack_mg, level.rear_elevator);
  var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("ds_helis_pre_path");
  common_scripts\utility::flag_wait("sparrow_hud_black");

  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 delete();
  }
}

spawn_background_helis() {
  level.sparrow_background_helis = [];
  wait 0.1;
  var_0 = thread spawn_repeating_background_heli("ds_background_heli_1");
  var_1 = thread spawn_repeating_background_heli("ds_background_heli_2");
  level.sparrow_background_helis = common_scripts\utility::add_to_array(level.sparrow_background_helis, var_0);
  level.sparrow_background_helis = common_scripts\utility::add_to_array(level.sparrow_background_helis, var_1);
}

spawn_repeating_background_heli(var_0) {
  maps\_utility::array_spawn_function_targetname(var_0, maps\carrier_code::heli_fast_explode, 100);
  maps\_utility::array_spawn_function_targetname(var_0, ::heli_background_attack_mg);
  maps\_utility::array_spawn_function_targetname(var_0, ::heli_background_respawn);
  maps\_utility::array_spawn_function_targetname(var_0, ::destroyer_mg_monitor);
  return maps\_vehicle::spawn_vehicles_from_targetname_and_drive(var_0);
}

heli_background_respawn() {
  level endon("defend_sparrow_finished");
  level endon("ac130_final_approach");
  level.sparrow_background_helis = common_scripts\utility::add_to_array(level.sparrow_background_helis, self);
  var_0 = self.spawner.targetname;
  wait 0.2;
  maps\carrier_code_sparrow::sam_add_target();

  for(;;) {
    common_scripts\utility::waittill_either("death", "reached_dynamic_path_end");

    if(isDefined(self) && isalive(self))
      self delete();

    level.sparrow_background_helis = maps\_utility::array_removedead(level.sparrow_background_helis);
    wait 0.1;
    thread spawn_repeating_background_heli(var_0);
  }
}

heli_background_attack_mg() {
  maps\_utility::ent_flag_init("sparrow_heli_start_mg_run");
  self endon("death");
  level endon("defend_sparrow_finished");
  self notify("heli_attack_mg_stop");
  self endon("heli_attack_mg_stop");
  common_scripts\utility::array_call(self.mgturret, ::turretfiredisable);
  common_scripts\utility::array_call(self.mgturret, ::setmode, "manual");
  var_0 = common_scripts\utility::getstructarray("sparrow_heli_background_attack", "targetname");
  var_1 = common_scripts\utility::spawn_tag_origin();
  thread self_cleanup(var_1);

  for(;;) {
    maps\_utility::ent_flag_wait("sparrow_heli_start_mg_run");
    var_2 = common_scripts\utility::getclosest(self.origin, var_0);
    var_1.origin = var_2.origin;
    common_scripts\utility::array_call(self.mgturret, ::turretfireenable);
    var_3 = 0.2;

    while(maps\_utility::ent_flag("sparrow_heli_start_mg_run")) {
      for(var_4 = 0; var_4 < 35; var_4++) {
        common_scripts\utility::array_call(self.mgturret, ::settargetentity, var_1);
        common_scripts\utility::array_call(self.mgturret, ::shootturret);
        wait(var_3);
      }

      self notify("done_with_volley");
      wait(randomfloatrange(0.25, 0.5));
    }

    common_scripts\utility::array_call(self.mgturret, ::turretfiredisable);
    common_scripts\utility::array_call(self.mgturret, ::setmode, "manual");
    wait 0.05;
  }
}

spawn_initial_combat_helis() {
  level.sparrow_helis = [];
  level.ds_vo_timer = 0;

  if(isDefined(level.sam_launchers) && level.sam_launchers[level.sam_launcher_index].angles[1] >= 17.5 && level.sam_launchers[level.sam_launcher_index].angles[1] < 105) {
    var_0 = thread spawn_repeating_heli("ds_helis_right_1", 1);
    var_1 = thread spawn_repeating_heli("ds_helis_right_2", 1);
    var_2 = thread spawn_repeating_heli("ds_helis_right_3", 1);
    maps\_utility::smart_radio_dialogue("carrier_ttn_incomingright");
  } else {
    var_0 = thread spawn_repeating_heli("ds_helis_left_1", 1);
    var_1 = thread spawn_repeating_heli("ds_helis_left_2", 1);
    var_2 = thread spawn_repeating_heli("ds_helis_left_3", 1);
    maps\_utility::smart_radio_dialogue("carrier_ttn_incomingleft");
  }
}

spawn_repeating_heli(var_0, var_1) {
  maps\_utility::array_spawn_function_targetname(var_0, maps\carrier_code_sparrow::sam_add_target);
  maps\_utility::array_spawn_function_targetname(var_0, maps\carrier_code::drone_delete_on_unload);
  maps\_utility::array_spawn_function_targetname(var_0, ::heli_attack_mg, level.sam_damage_dummy, level.sparrow_control);
  maps\_utility::array_spawn_function_targetname(var_0, ::heli_combat_respawn);
  maps\_utility::array_spawn_function_targetname(var_0, ::heli_combat_path);

  if(issubstr(var_0, "_1"))
    maps\_utility::array_spawn_function_targetname(var_0, maps\carrier_code::heli_fast_explode, 100);

  return maps\_vehicle::spawn_vehicles_from_targetname_and_drive(var_0);
}

heli_combat_kill_counter() {
  var_0 = 0;
  level.helis_can_respawn = 1;
  common_scripts\utility::flag_wait("ac130_wave5_attack");
  common_scripts\utility::waitframe();
  common_scripts\utility::flag_clear("ac130_wave5_attack");
  thread spawn_initial_combat_helis();
  heli_combat_kill_wave(5, 8);
  heli_combat_kill_wave(4, 6);
  heli_combat_kill_wave(3, 5.5);
  heli_combat_kill_wave(3, 5);
}

heli_combat_kill_wave(var_0, var_1) {
  var_2 = 0;
  thread heli_combat_stop_respawn(var_0);

  while(level.heli_kill_counter < var_0 || var_2 <= var_1) {
    wait 0.05;
    var_2 = var_2 + 0.05;
  }

  common_scripts\utility::flag_set("ac130_start_attack_run");
  common_scripts\utility::waitframe();
  common_scripts\utility::flag_clear("ac130_start_attack_run");
  common_scripts\utility::flag_wait("ac130_wave5_attack");
  common_scripts\utility::waitframe();
  common_scripts\utility::flag_clear("ac130_wave5_attack");
  level.heli_kill_counter = 0;
  level.helis_can_respawn = 1;
}

heli_combat_stop_respawn(var_0) {
  var_0 = var_0 - 1;

  while(level.heli_kill_counter < var_0)
    wait 0.05;

  level.helis_can_respawn = 0;
}

heli_combat_respawn() {
  level endon("defend_sparrow_finished");
  level endon("ac130_final_approach");
  level.sparrow_helis = common_scripts\utility::add_to_array(level.sparrow_helis, self);
  var_0 = self.spawner.targetname;
  self waittill("death");
  level.heli_kill_counter = level.heli_kill_counter + 1;
  level.sparrow_helis = maps\_utility::array_removedead(level.sparrow_helis);

  while(!level.helis_can_respawn)
    wait 0.05;

  if(isDefined(level.sam_launchers) && level.sam_launchers[level.sam_launcher_index].angles[1] >= 17.5 && level.sam_launchers[level.sam_launcher_index].angles[1] < 105) {
    if(issubstr(var_0, "_1"))
      thread spawn_repeating_heli("ds_helis_right_1");
    else if(issubstr(var_0, "_2"))
      thread spawn_repeating_heli("ds_helis_right_2");
    else if(issubstr(var_0, "_3"))
      thread spawn_repeating_heli("ds_helis_right_3");
    else {}

    maps\_utility::delaythread(0.4, ::run_incoming_vo, 0, 1);
  } else {
    if(issubstr(var_0, "_1"))
      thread spawn_repeating_heli("ds_helis_left_1", 1);
    else if(issubstr(var_0, "_2"))
      thread spawn_repeating_heli("ds_helis_left_2", 1);
    else if(issubstr(var_0, "_3"))
      thread spawn_repeating_heli("ds_helis_left_3", 1);
    else {}

    maps\_utility::delaythread(0.4, ::run_incoming_vo, 1, 0);
  }
}

heli_combat_path() {
  self endon("death");
  self waittill("reached_dynamic_path_end");

  if(isDefined(self))
    self delete();
}

run_incoming_vo(var_0, var_1) {
  level.player endon("death");
  level endon("defend_sparrow_finished");
  level endon("ac130_final_approach");
  level endon("player_failed_gunship");

  if(var_0 == 1) {
    if(level.ds_vo_timer == 0) {
      level.ds_vo_timer = 1;
      maps\_utility::smart_radio_dialogue("carrier_ttn_incomingleft");
      wait 9;
      level.ds_vo_timer = 0;
    }
  } else if(level.ds_vo_timer == 0) {
    level.ds_vo_timer = 1;
    maps\_utility::smart_radio_dialogue("carrier_ttn_incomingright");
    wait 9;
    level.ds_vo_timer = 0;
  }
}

debug_heli_gun(var_0) {
  self endon("done_with_volley");
  self endon("death");

  for(;;)
    wait 0.05;
}

heli_attack_mg(var_0, var_1) {
  if(!isDefined(self.ent_flag["sparrow_heli_start_mg_run"]))
    maps\_utility::ent_flag_init("sparrow_heli_start_mg_run");

  self endon("death");
  level endon("defend_sparrow_finished");
  self notify("heli_attack_mg_stop");
  self endon("heli_attack_mg_stop");
  common_scripts\utility::array_call(self.mgturret, ::turretfiredisable);
  common_scripts\utility::array_call(self.mgturret, ::setmode, "manual");
  var_2 = getEntArray("sparrow_heli_attack_location", "targetname");
  var_3 = var_0;
  var_4 = common_scripts\utility::spawn_tag_origin();
  thread self_cleanup(var_4);

  for(;;) {
    maps\_utility::ent_flag_wait("sparrow_heli_start_mg_run");

    if(isDefined(level.sam_damage_dummy)) {
      var_5 = common_scripts\utility::getclosest(self.origin, var_2);
      var_4.origin = var_5.origin;
      var_4 moveto(level.sam_damage_dummy.origin, 4.25);
    }

    common_scripts\utility::array_call(self.mgturret, ::turretfireenable);
    var_6 = 0.25;
    var_7 = 0.2;

    while(maps\_utility::ent_flag("sparrow_heli_start_mg_run") && level.helis_can_respawn == 1) {
      for(var_8 = 0; var_8 < 35; var_8++) {
        if(isDefined(level.sam_damage_dummy))
          common_scripts\utility::array_call(self.mgturret, ::settargetentity, var_4);
        else
          common_scripts\utility::array_call(self.mgturret, ::settargetentity, var_3);

        common_scripts\utility::array_call(self.mgturret, ::shootturret);
        wait(var_7);
      }

      self notify("done_with_volley");
      wait(randomfloatrange(0.25, 0.5));
    }

    common_scripts\utility::array_call(self.mgturret, ::turretfiredisable);
    common_scripts\utility::array_call(self.mgturret, ::setmode, "manual");
    var_3 = var_0;
    wait 0.05;
  }
}

self_cleanup(var_0) {
  self waittill("death");
  wait 0.1;

  if(isDefined(var_0))
    var_0 delete();
}

heli_cleanup() {
  foreach(var_1 in level.sparrow_helis) {
    if(isDefined(var_1))
      var_1 kill();
  }

  foreach(var_1 in level.sparrow_background_helis) {
    if(isDefined(var_1))
      var_1 kill();
  }

  foreach(var_6 in level.sparrow_zodiacs) {
    if(isDefined(var_6))
      var_6 delete();
  }
}

spawn_ac130() {
  maps\_utility::array_spawn_function_targetname("enemy_ac130", ::ac130_missile_defense_init);
  maps\_utility::array_spawn_function_targetname("enemy_ac130", ::ac130_attack_random);
  maps\_utility::array_spawn_function_targetname("enemy_ac130", ::ac130_direct_attack_path);
  level.ac_130 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_ac130");

  if(isDefined(level.player_ignored_2nd_osprey)) {
    var_0 = getvehiclenode("ac_130_skipped_osprey_path", "targetname");
    level.ac_130 vehicle_teleport(var_0.origin, var_0.angles);
    level.ac_130 thread maps\_vehicle::vehicle_paths(var_0);
  }

  thread maps\carrier_audio::aud_gunship_loc();
}

ac130_direct_attack_path() {
  self endon("death");
  self endon("ac130_done");
  common_scripts\utility::flag_wait("sparrow_hud_black");
  self notify("attack_starting");
  thread ac130_kill_player();
  var_0 = getvehiclenode("ac_130_attack_path_left", "targetname");
  var_1 = getvehiclenode("ac_130_attack_path_right", "targetname");
  var_2 = 1;
  level.ac130_last_105_fire_time = 0;

  for(;;) {
    self.attacked_this_run = 0;

    if(isDefined(level.sam_launchers) && level.sam_launchers[level.sam_launcher_index].angles[1] >= 17.5 && level.sam_launchers[level.sam_launcher_index].angles[1] < 105) {
      common_scripts\utility::flag_set("gunship_right_path");
      self vehicle_teleport(var_1.origin, var_1.angles);
      self attachpath(var_1);
      thread maps\_vehicle::vehicle_paths(var_1);
      thread maps\carrier_audio::aud_carr_gunship_attack_run();
      wait 0.75;

      if(common_scripts\utility::flag("ac_130_attack_run_1_done"))
        maps\_utility::smart_radio_dialogue("carrier_us1_ac130totheright");
    } else {
      common_scripts\utility::flag_set("gunship_left_path");
      self vehicle_teleport(var_0.origin, var_0.angles);
      self attachpath(var_0);
      thread maps\_vehicle::vehicle_paths(var_0);
      thread maps\carrier_audio::aud_carr_gunship_attack_run();
      wait 0.75;

      if(common_scripts\utility::flag("ac_130_attack_run_1_done"))
        maps\_utility::smart_radio_dialogue("carrier_us1_ac130totheleft");
    }

    wait 8;

    if(var_2 == 1 && level.ac130_attacked_player_count == 0 || var_2 == 3 && level.ac130_attacked_player_count < 2) {
      thread maps\carrier_code::ac130_magic_105(level.sam_launchers[level.sam_launcher_index].origin);
      level.ac130_last_105_fire_time = gettime();
      level.ac130_attacked_player_count++;
    }

    self waittill("reached_dynamic_path_end");
    common_scripts\utility::flag_clear("ac130_wave5_attack");
    common_scripts\utility::flag_clear("gunship_death_path");
    common_scripts\utility::flag_clear("gunship_left_path");
    common_scripts\utility::flag_clear("gunship_right_path");
    common_scripts\utility::flag_set("ac_130_attack_run_" + var_2 + "_done");
    var_2 = var_2 + 1;
    common_scripts\utility::flag_wait("ac130_start_attack_run");
  }
}

ac130_kill_player() {
  common_scripts\utility::flag_wait("ac_130_attack_run_4_done");

  if(!common_scripts\utility::flag("ac_130_hit")) {
    level.player disableinvulnerability();
    var_0 = level.player common_scripts\utility::spawn_tag_origin();
    level.ac_130 maps\carrier_code::ac130_magic_105(var_0.origin);
    wait 0.25;
    level notify("player_failed_gunship");
    level.player kill();
    common_scripts\utility::waitframe();
  }
}

ac130_constant_target() {
  self endon("death");
  level.ac130_attacked_player_count = 0;
  var_0 = 1;

  for(;;) {
    self waittill("sam_targeted", var_1);

    while(gettime() - level.ac130_last_105_fire_time > 8000 && distance2dsquared(self.origin, level.player getEye()) > 12960000)
      wait 0.05;

    if(gettime() - level.ac130_last_105_fire_time > 8000 && level.ac130_attacked_player_count < 2 && var_0 > level.ac130_attacked_player_count) {
      thread maps\carrier_code::ac130_magic_105(level.sam_launchers[level.sam_launcher_index].origin);
      level.ac130_attacked_player_count++;
    }

    common_scripts\utility::flag_wait("ac130_start_attack_run");
    var_0++;
    maps\carrier_code_sparrow::sam_add_target();
  }
}

ac130_attack_random() {
  self endon("death");
  level.destroyer_target = common_scripts\utility::spawn_tag_origin();
  level.destroyer_target linkto(self, "tag_origin");
  common_scripts\utility::flag_wait("sparrow_hud_black");
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  for(;;) {
    var_4 = randomint(2);

    switch (var_4) {
      case 0:
        var_0 = 0;
        break;
      case 1:
        var_0 = 1;
        break;
    }

    if(var_0 == 0) {
      var_1 = common_scripts\utility::spawn_tag_origin();
      var_2 = maps\carrier_code::get_gun_tag();
      var_3 = self gettagorigin("tag_flash_40mm_" + var_2);
      var_1.origin = var_3;
      var_1 linkto(self, "tag_flash_40mm_" + var_2);

      for(var_5 = 0; var_5 < 2; var_5++) {
        thread maps\carrier_code::ac130_magic_bullet("40mm");
        var_1 maps\_utility::play_sound_on_entity("ac130_40mm_fire_npc");
        wait 0.5;
      }
    } else {
      var_1 = common_scripts\utility::spawn_tag_origin();
      var_2 = maps\carrier_code::get_gun_tag();
      var_3 = self gettagorigin("tag_flash_25mm_" + var_2);
      var_1.origin = var_3;
      var_1 linkto(self, "tag_flash_25mm_" + var_2);

      for(var_5 = 0; var_5 < 40; var_5++) {
        thread maps\carrier_code::ac130_magic_bullet("25mm");
        var_1 maps\_utility::play_sound_on_entity("ac130_25mm_fire_npc");
        wait 0.15;
      }
    }

    wait(randomfloatrange(1.25, 2.0));
    var_1 delete();
  }
}

ac130_missile_defense_init() {
  self endon("death");
  self endon("flares_empty");

  for(;;) {
    self waittill("sam_targeted", var_0);
    common_scripts\utility::flag_set("ac_130_hit");

    while(isvalidmissile(var_0)) {
      if(common_scripts\utility::distance_2d_squared(self.origin, var_0.origin) < squared(2500)) {
        break;
      }

      wait 0.05;
    }

    if(!isDefined(var_0) || !isvalidmissile(var_0)) {
      continue;
    }
    thread angel_flare_burst(10);

    while(!isDefined(self.flares))
      wait 0.05;

    if(!isDefined(var_0) || !isvalidmissile(var_0)) {
      continue;
    }
    var_1 = common_scripts\utility::getclosest(var_0.origin, self.flares);
    var_1.mytarget = var_0;
    var_0 missile_settargetent(var_1);

    while(isvalidmissile(var_0)) {
      if(distancesquared(var_1.origin, var_0.origin) < squared(768)) {
        break;
      }

      wait 0.05;
    }

    var_2 = common_scripts\utility::getfx("chopper_flare_explosion");

    if(isDefined(var_0))
      var_0 delete();

    playFX(var_2, var_1.origin);
    var_1 delete();
    thread ac130_missile_take_hit();
    maps\_utility::delaythread(5, common_scripts\utility::flag_clear, "ac_130_hit");
    wait 0.4;
    thread maps\_utility::smart_radio_dialogue("carrier_us2_ac130hasdeployedflares");
    common_scripts\utility::waitframe();
    self notify("flares_empty");
  }
}

angel_flare_burst(var_0) {
  playFXOnTag(common_scripts\utility::getfx("angel_flare_swirl"), self, "tag_flash_flares");

  for(var_1 = 0; var_1 < var_0; var_1++) {
    thread shootflares();
    wait(randomfloatrange(0.1, 0.25));
  }
}

shootflares() {
  if(!isDefined(level.anim_index))
    level.anim_index = 0;

  var_0 = maps\_utility::spawn_anim_model("flare_rig");
  var_0.origin = self gettagorigin("tag_flash_flares");
  var_0.angles = self gettagangles("tag_flash_flares") + (0, 180, 0);
  var_1 = [];
  var_2 = ["flare_right_top", "flare_left_bot", "flare_right_bot", "flare_left_top"];

  foreach(var_4 in var_2) {
    var_5 = common_scripts\utility::spawn_tag_origin();
    var_5.origin = var_0 gettagorigin(var_4);
    var_5.angles = var_0 gettagangles(var_4);
    var_5 linkto(var_0, var_4);
    var_5 thread flare_trackvelocity();
    var_1[var_4] = var_5;
  }

  self.flares = var_1;
  var_7 = level.scr_anim["flare_rig"]["flare"].size;
  var_8 = level.scr_anim["flare_rig"]["flare"][level.anim_index % var_7];
  level.anim_index++;
  var_0 setflaggedanim("flare_anim", var_8, 1, 0, 1);
  var_9 = common_scripts\utility::getfx("angel_flare_geotrail");
  var_1 = common_scripts\utility::array_randomize(var_1);

  foreach(var_4, var_5 in var_1) {
    if(isDefined(var_5))
      playFXOnTag(var_9, var_1[var_4], "tag_origin");
  }

  var_0 waittillmatch("flare_anim", "end");

  foreach(var_4, var_5 in var_1) {
    if(isDefined(var_5)) {
      stopFXOnTag(var_9, var_1[var_4], "tag_origin");
      var_5 delete();
    }
  }

  var_0 delete();
  var_1 = common_scripts\utility::array_removeundefined(var_1);
  common_scripts\utility::array_thread(var_1, ::flare_doburnout);
  return var_1;
}

flare_trackvelocity() {
  self endon("death");
  self.velocity = 0;
  var_0 = self.origin;

  for(;;) {
    self.velocity = self.origin - var_0;
    var_0 = self.origin;
    wait 0.05;
  }
}

flare_doburnout() {
  self endon("death");
  self movegravity(14 * self.velocity, 0.2);
  wait 0.2;

  if(!isDefined(self) || isDefined(self.mytarget)) {
    return;
  }
  self delete();
}

ac130_missile_take_hit() {
  self endon("ac130_hit");
  var_0 = [];
  var_0[0] = common_scripts\utility::spawn_tag_origin();
  var_0[1] = common_scripts\utility::spawn_tag_origin();
  var_0[0].origin = self gettagorigin("tag_light_l_wing");
  var_0[1].origin = self gettagorigin("tag_light_r_wing");
  var_0[0] linkto(self);
  var_0[1] linkto(self);

  for(;;) {
    self waittill("sam_targeted", var_1);
    common_scripts\utility::flag_set("ac_130_hit");

    while(isvalidmissile(var_1)) {
      if(common_scripts\utility::distance_2d_squared(self.origin, var_1.origin) < squared(1500)) {
        break;
      }

      wait 0.05;
    }

    if(!isDefined(var_1) || !isvalidmissile(var_1)) {
      continue;
    }
    var_2 = common_scripts\utility::getclosest(var_1.origin, var_0);

    if(var_2 == var_0[0])
      var_3 = anglestoright(var_2.angles) * -12;
    else
      var_3 = anglestoright(var_2.angles) * 12;

    var_1 missile_settargetent(var_2, var_3);
    var_4 = missile_createattractorent(var_2, 25000, 10000);

    while(isvalidmissile(var_1)) {
      if(distancesquared(var_2.origin + var_3, var_1.origin) < squared(768)) {
        break;
      }

      wait 0.05;
    }

    missile_deleteattractor(var_4);
    var_5 = common_scripts\utility::getfx("vfx_missile_death_air");

    if(isDefined(var_1))
      var_1 delete();

    playFX(var_5, var_2.origin);
    wait 0.1;
    level.wing_tag = common_scripts\utility::spawn_tag_origin();

    if(var_2 == var_0[0]) {
      level.first_gunship_wing = "left1";
      level.wing_tag.origin = self gettagorigin("tag_fx_engine_le_1");
      level.wing_tag.angles = self gettagangles("tag_fx_engine_le_1");
      level.wing_tag linkto(self, "tag_fx_engine_le_1");
      playFXOnTag(common_scripts\utility::getfx("vfx_ac130_engine_fire"), level.wing_tag, "tag_origin");
    } else {
      level.first_gunship_wing = "right1";
      level.wing_tag.origin = self gettagorigin("tag_fx_engine_ri_1");
      level.wing_tag.angles = self gettagangles("tag_fx_engine_ri_1");
      level.wing_tag linkto(self, "tag_fx_engine_ri_1");
      playFXOnTag(common_scripts\utility::getfx("vfx_ac130_engine_fire"), level.wing_tag, "tag_origin");
    }

    maps\_utility::delaythread(1, common_scripts\utility::flag_clear, "ac_130_hit");
    wait 0.4;
    thread maps\_utility::smart_radio_dialogue("carrier_us2_goodhittheac130");
    thread ac130_final_life();
    common_scripts\utility::waitframe();
    self notify("ac130_hit");
  }
}

ac130_final_life() {
  self endon("death");
  level endon("player_failed_gunship");

  for(;;) {
    self waittill("sam_targeted", var_0);
    common_scripts\utility::flag_set("ac_130_hit");

    while(isvalidmissile(var_0)) {
      if(distancesquared(self.origin, var_0.origin) < squared(640)) {
        break;
      }

      wait 0.05;
    }

    if(!common_scripts\utility::flag("gunship_death_path")) {
      common_scripts\utility::flag_wait("gunship_death_path");

      if(common_scripts\utility::flag("gunship_right_path")) {
        var_1 = getvehiclenode("gunship_deathpath_right", "targetname");
        self attachpath(var_1);
        thread maps\_vehicle::vehicle_paths(var_1);
      } else {
        var_1 = getvehiclenode("gunship_deathpath_left", "targetname");
        self attachpath(var_1);
        thread maps\_vehicle::vehicle_paths(var_1);
      }
    }

    self.script_bulletshield = 0;
    self.script_grenadeshield = 0;
    level.ac_130 maps\_utility::delaythread(1.25, maps\carrier_code::ac130_magic_bullet, "40mm", level.sam_launchers[level.sam_launcher_index].origin);
    var_2 = common_scripts\utility::getfx("vfx_missile_death_air");

    if(isDefined(var_0))
      var_0 delete();

    playFX(var_2, self.origin);
    wait 0.1;
    common_scripts\utility::flag_set("defend_sparrow_finished");
    thread maps\carrier_audio::aud_carr_sparrow_105_incoming();
    thread maps\carrier_audio::aud_carr_gunship_killed();
    thread maps\_utility::smart_radio_dialogue("carrier_ttn_federationgunshipisdown");
    maps\_utility::delaythread(1.5, common_scripts\utility::flag_set, "obj_gunship_complete");
    var_3 = common_scripts\utility::spawn_tag_origin();

    if(isDefined(level.first_gunship_wing) && level.first_gunship_wing == "left1") {
      level.second_gunship_wing = "right2";
      var_3.origin = self gettagorigin("tag_fx_engine_ri_2");
      var_3.angles = self gettagangles("tag_fx_engine_ri_2");
      var_3 linkto(self, "tag_fx_engine_ri_2");
      playFXOnTag(common_scripts\utility::getfx("vfx_ac130_engine_fire"), var_3, "tag_origin");
    } else {
      level.second_gunship_wing = "left2";
      var_3.origin = self gettagorigin("tag_fx_engine_le_2");
      var_3.angles = self gettagangles("tag_fx_engine_le_2");
      var_3 linkto(self, "tag_fx_engine_le_2");
      playFXOnTag(common_scripts\utility::getfx("vfx_ac130_engine_fire"), var_3, "tag_origin");
    }

    common_scripts\utility::waittill_either("reached_dynamic_path_end", "victory_start");
    stopFXOnTag(common_scripts\utility::getfx("vfx_ac130_engine_fire"), level.wing_tag, "tag_origin");
    stopFXOnTag(common_scripts\utility::getfx("vfx_ac130_engine_fire"), var_3, "tag_origin");
    common_scripts\utility::waitframe();

    if(isDefined(self))
      self delete();

    common_scripts\utility::waitframe();
    var_3 delete();

    if(isDefined(level.wing_tag))
      level.wing_tag delete();
  }
}