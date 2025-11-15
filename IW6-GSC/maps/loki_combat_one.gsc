/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\loki_combat_one.gsc
*****************************************************/

section_main() {
  maps\_utility::add_hint_string("up_hint", & "LOKI_HINT_UP", ::no_hint);
  maps\_utility::add_hint_string("down_hint", & "LOKI_HINT_DOWN", ::no_hint_down);
}

section_precache() {
  precacheshader("green_block");
}

section_flag_inits() {
  common_scripts\utility::flag_init("cool_spawn_finished");
  common_scripts\utility::flag_init("combat_one_wave2_started");
  common_scripts\utility::flag_init("door_traversal_done");
  common_scripts\utility::flag_init("stop_movement_hint");
}

combat_one_start() {
  maps\loki_util::player_move_to_checkpoint_start("combat_one");
  maps\loki_util::spawn_allies();
  thread maps\loki_audio::sfx_set_combat_amb();
  thread maps\loki_infil::setup_fuel_leak_lighting();
  thread maps\loki_util::player_boundaries_on();
  level.accuracy_ally = 0.6;
  level.accuracy_enemy = 1.4;
  level.allies[0].fixednode = 1;
  level.allies[1].baseaccuracy = level.accuracy_ally;
  level.allies[2].fixednode = 1;
  level.allies[2].baseaccuracy = level.accuracy_ally;
  var_0 = getnode("cover_one_ally0_node1", "targetname");
  level.allies[0] setgoalnode(var_0);
  var_0 = getnode("cover_one_ally1_node1", "targetname");
  level.allies[1] setgoalnode(var_0);
  var_0 = getnode("cover_one_ally2_node1", "targetname");
  level.allies[2] setgoalnode(var_0);
  maps\loki_infil::create_redshirts();

  foreach(var_2 in level.redshirts) {
    var_0 = getnode(var_2.first_goal_node, "targetname");
    var_2 forceteleport(var_0.origin, var_0.angles);
  }

  level thread spawn_wave1_enemies(1);
  level thread firstframe_combat_one_door();
}

combat_one() {
  thread maps\loki_audio::sfx_set_combat_amb();
  maps\_utility::battlechatter_on("allies");
  level.activebreaks = 0;
  level.grenadesplashing = 0;
  var_0 = getEntArray("breakTile", "targetname");
  var_1 = getEntArray("breakTileEdge", "targetname");
  common_scripts\utility::array_thread(var_0, ::do_tile_single, var_0, var_1);
  level thread track_ai();
  level thread trigger_wave2();
  level thread trigger_wave3();
  level thread unlink_door_traversal_nodes();
  level thread unlink_final_exposed_nodes();
  level thread track_fuel_leak_hit();
  level thread capsule_ninja();
  level thread instant_explosion();
  setsaveddvar("actor_spaceLightingOffset", -6);
  thread maps\loki_audio::sfx_loki_breathing_logic(1);
  var_2 = getent("combat_one_traversal1", "targetname");
  level.combat_one_wave_node = var_2;
  var_3 = getEntArray("sniper_sat_solarpanel", "targetname");
  common_scripts\utility::array_thread(var_3, ::solarpanels_damage_think);
  common_scripts\utility::array_thread(var_3, ::solarpanels_damage_think_instant);
  common_scripts\utility::flag_wait("combat_one_done");
}

start_fuel_leak_fx(var_0, var_1, var_2, var_3) {
  var_4 = common_scripts\utility::spawn_tag_origin();
  var_4.targetname = "fuel_leak_tag";
  var_4.script_noteworthy = "combat_one_cleanup";
  var_4 thread start_fuel_leak_fx_main(var_0, var_1, var_2, var_3);
  return var_4;
}

start_fuel_leak_lighting() {
  var_0 = getEntArray("combat_one_light", "script_noteworthy");

  foreach(var_2 in var_0) {
    wait 8.5;
    var_2 setlightradius(540);
    var_2 setlightintensity(8.0);
  }
}

start_fuel_leak_fx_main(var_0, var_1, var_2, var_3) {
  self endon("death");
  level endon("explosion");

  if(isDefined(var_1)) {
    var_4 = var_2;
    var_5 = var_3;
  } else {
    var_4 = common_scripts\utility::getstruct(var_0, "targetname").origin;
    var_5 = common_scripts\utility::getstruct(var_0, "targetname").angles;
  }

  self.origin = var_4;
  self.angles = var_5;
  self.is_on_fire = 0;
  thread stop_fuel_leak_fx();
  level thread start_fuel_leak_lighting();
  earthquake(0.15, 0.5, var_4, 1000);
  playFXOnTag(common_scripts\utility::getfx("vfx_fuel_leak_zerog"), self, "tag_origin");
  thread maps\loki_audio::sfx_gas_line_fuel_burst(self);
  var_6 = 1;

  foreach(var_8 in level.bullet_caused_fuel_leaks) {
    if(distance(var_8.origin, var_4) < 36 && var_8.is_on_fire) {
      maps\loki_util::jkuprint("close!!! skipping long fuel leak");
      var_6 = 0;
      wait 1;
      break;
    } else
      var_6 = 1;
  }

  if(var_6) {
    thread maps\loki_audio::sfx_gas_line_fuel_leak(self);
    wait 5;
  }

  thread maps\loki_audio::sfx_gas_line_ignite(self);
  self.is_on_fire = 1;
  playFXOnTag(common_scripts\utility::getfx("spc_fire_puff_light"), self, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("loki_fuel_ignite_fast"), self, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("vfx_fuel_leak_zerog"), self, "tag_origin");
  wait 0.5;

  if(isDefined(var_1) || var_0 == "fuel_explosion_spark_point2")
    thread maps\loki_audio::sfx_gas_line_fire_lp(self, 0);
  else if(level.bullet_caused_fuel_leaks.size < 2 && var_0 == "fuel_explosion_spark_point0")
    thread maps\loki_audio::sfx_gas_line_fire_lp(self, 0);
  else
    thread maps\loki_audio::sfx_gas_line_fire_lp(self, 1);

  playFXOnTag(common_scripts\utility::getfx("vfx_fuel_fire_zerog_cglight"), self, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("spc_fire_puff_big_single_runner"), self, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("spc_fire_puff_light"), self, "tag_origin");
}

stop_fuel_leak_fx() {
  thread stop_fuel_leak_fx_explosion();
  self waittill("death");
  maps\loki_util::jkuprint("deleting leak fx");
  thread maps\loki_audio::sfx_gas_line_stop_sfx(self);
  stopFXOnTag(common_scripts\utility::getfx("vfx_fuel_leak_zerog"), self, "tag_origin");
  common_scripts\utility::waitframe();
  stopFXOnTag(common_scripts\utility::getfx("electrical_sparks_zerog_runner"), self, "tag_origin");
  common_scripts\utility::waitframe();
  stopFXOnTag(common_scripts\utility::getfx("vfx_fuel_fire_zerog_cglight"), self, "tag_origin");
  common_scripts\utility::waitframe();
  stopFXOnTag(common_scripts\utility::getfx("loki_fuel_ignite_fast_runner"), self, "tag_origin");
  common_scripts\utility::waitframe();
  stopFXOnTag(common_scripts\utility::getfx("spc_fire_puff_big_single_runner"), self, "tag_origin");
  self delete();
}

stop_fuel_leak_fx_explosion() {
  level waittill("explosion");
  self notify("death");
}

start_fuel_explosion_fx(var_0, var_1, var_2, var_3, var_4) {
  var_5 = common_scripts\utility::getstruct(var_0, "targetname");
  earthquake(var_3, 0.75, var_5.origin, 1200);
  var_6 = maps\loki_util::create_rumble_ent(var_4, "combat_one_cleanup", 3);
  var_6 playrumbleonentity("light_1s");

  if(!isDefined(var_2))
    playFX(common_scripts\utility::getfx(var_1), var_5.origin);
  else
    playFX(common_scripts\utility::getfx(var_1), var_5.origin, var_2);
}

test_lights() {
  var_0 = getent("combat_one", "targetname");
  var_1 = maps\_vignette_util::vignette_actor_spawn("deadbody", "deadbody");
  var_1 forceteleport(var_0.origin, var_1.angles + (0, 180, 0));
  var_1 thread maps\_space_ai::space_actor_lights();
  var_0 maps\_anim::anim_loop_solo(var_1, "test_loop");
}

movement_hints() {
  level.player endon("death");
  thread maps\_utility::display_hint_timeout("up_hint", 2.75);
  thread maps\_utility::display_hint_timeout("down_hint", 2);
  wait 2;

  for(;;) {
    if(level.player secondaryoffhandbuttonpressed()) {
      var_0 = gettime();

      while(level.player secondaryoffhandbuttonpressed()) {
        if(gettime() - var_0 > 500) {
          common_scripts\utility::flag_set("stop_movement_hint");
          return;
        }

        common_scripts\utility::waitframe();
      }
    }

    common_scripts\utility::waitframe();
  }
}

no_hint() {
  if(!isalive(level.player))
    return 1;

  return 0;
}

no_hint_down() {
  if(!isalive(level.player) || common_scripts\utility::flag("stop_movement_hint"))
    return 1;

  return 0;
}

move_explosion_buildup_rumble() {
  var_0 = maps\loki_util::create_rumble_ent(1000, "combat_one_cleanup");
  var_0 playrumblelooponentity("steady_rumble");

  while(!common_scripts\utility::flag("explosion")) {
    var_1 = distance(var_0.origin, level.player.origin);

    if(var_1 > 666)
      var_0.origin = var_0.origin + (0, 0, -7);
    else if(distance(var_0.origin, level.player.origin) < 200) {} else {
      maps\loki_util::jkuprint("fast move");
      var_0.origin = var_0.origin + (0, 0, -17);
    }

    var_0 linkto(level.player);
    common_scripts\utility::waitframe();
  }

  var_0 delete();
}

instant_explosion() {
  level.player endon("death");
  level endon("explosion_started");
  var_0 = getent("combat_one_door_instant", "targetname");
  var_0 waittill("trigger");
  level notify("explosion");
  level.combat_one_wave_node notify("explosion");
  maps\loki_util::jkuprint("CHEATER!!!!");
  level thread moving_cover_pre_tele(1);
}

moving_cover_pre_tele(var_0) {
  level.player endon("death");

  if(!isDefined(var_0))
    var_0 = 0;

  common_scripts\utility::flag_wait("start_fuel_explosion");
  level notify("explosion_started");
  thread maps\loki_audio::sfx_gas_line_explo_logic();
  level.allies[0] notify("start_fuel_explosion");
  thread maps\loki_fx::fx_fuel_explosion_pre_fx();
  level thread move_explosion_buildup_rumble();

  if(!var_0) {
    level thread maps\loki_moving_cover::firstframe_moving_cover();
    wait 1.5;
  } else
    maps\loki_moving_cover::firstframe_moving_cover(1);

  var_1 = getent("combat_one_explosion", "targetname");
  var_2 = maps\_utility::spawn_anim_model("moving_cover_obj0");
  var_1 maps\_anim::anim_first_frame_solo(var_2, "explosion_part1");
  var_2 maps\loki_util::spawn_and_link_models_to_tags("combat_one_cleanup", undefined, 1);
  level maps\_utility::delaythread(0, ::start_fuel_explosion_fx, "fuel_explosion_point0", "fuel_explosion_zerog", undefined, 0.15, 800);
  level maps\_utility::delaythread(0.6, ::start_fuel_explosion_fx, "fuel_explosion_point1", "fuel_explosion_zerog", undefined, 0.25, 600);
  level maps\_utility::delaythread(1.0, ::start_fuel_explosion_fx, "fuel_explosion_point2", "fuel_explosion_zerog", undefined, 0.35, 400);
  level maps\_utility::delaythread(1.4, ::start_fuel_explosion_fx, "fuel_explosion_point3", "fuel_explosion_zerog", undefined, 0.45, 200);
  common_scripts\utility::flag_set("turn_off_creaks");

  if(!var_0)
    level maps\_utility::delaythread(0.75, ::explosion_anim, var_1, var_2);

  if(!var_0)
    wait 0.6;

  maps\_utility::radio_dialogue_clear_stack();
  level thread maps\_utility::smart_radio_dialogue_interrupt("loki_kgn_shit");

  if(!var_0)
    wait 0.9;

  level.player.og_health = level.player.health;
  level.player.demigod = 1;
  level.player playrumbleonentity("light_1s");
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_4 = common_scripts\utility::spawn_tag_origin();
  var_5 = common_scripts\utility::spawn_tag_origin();
  var_3.origin = level.player.origin + (0, 0, 40);
  var_5.origin = level.player.origin;
  var_3.angles = (0, 90, 0);
  var_5.angles = (0, 90, 0);
  var_5 linkto(var_3);
  var_3.angles = (330, 90, 0);
  var_4.origin = var_3.origin;
  var_3 linkto(var_4);
  level.player playerlinktoblend(var_5, "tag_origin", 0.3, 0, 0);
  level.player hideviewmodel();
  var_4 rotatevelocity((175, 0, 0), 999, 0, 0);
  var_6 = bulletTrace(level.player.origin, level.player.origin + (0, 0, 200), 0);
  var_7 = distance(level.player.origin, var_6["position"]);
  maps\loki_util::jkuprint("Distance above we can rotate you: " + var_7);
  var_4 movez(var_7, 0.65, 0, 0);
  level thread maps\loki_moving_cover::hit_panel(level.player, 0.65, 0.5, 2);
  level.player playrumbleonentity("heavy_3s");

  if(!var_0)
    wait 0.6;

  level.player.demigod = 0;
  level thread maps\loki_util::player_boundaries_off();
  level thread maps\loki_moving_cover::white_hide();
  common_scripts\utility::waitframe();
  common_scripts\utility::waitframe();
  common_scripts\utility::flag_set("explosion");
  level notify("explosion");
  level.combat_one_wave_node notify("explosion");
  common_scripts\utility::flag_set("combat_one_music_end");
  level.player unlink();
  var_3 delete();
  var_4 delete();
  var_5 delete();
  level notify("stop_explosions");
  common_scripts\utility::flag_set("combat_one_done");
}

explosion_anim(var_0, var_1) {
  var_2 = getEntArray("explosion_hide", "targetname");

  foreach(var_4 in var_2)
  var_4 hide();

  var_0 maps\_anim::anim_single_solo(var_1, "explosion_part1");
}

move_start_exposed_guy() {
  level.exposed_guy endon("death");
  level endon("combat_one_wave2_started");
  level.exposed_guy waittill("goal");
  maps\loki_util::jkuprint("exposed guy waiting");
  wait 8;
  var_0 = getnode("exposed_guy_start", "targetname");
  var_0 disconnectnode();
  maps\loki_util::jkuprint("exposed guy getting reassigned");
  var_0 = getnode("exposed_guy_move", "targetname");
  level.exposed_guy setgoalnode(var_0);
}

track_ai() {
  level endon("explosion");
  level.player endon("death");
  common_scripts\utility::flag_wait("first_wave_spawned");
  level thread move_start_exposed_guy();
  var_0 = get_all_wave_guys();

  while(var_0.size > 3) {
    if(common_scripts\utility::flag("combat_one_wave2_spawned")) {
      break;
    }

    var_0 = get_all_wave_guys();
    common_scripts\utility::waitframe();
  }

  maps\loki_util::jkuprint("w2: via tracker");
  maps\_utility::battlechatter_off("allies");
  common_scripts\utility::flag_set("combat_one_wave2_started");
  maps\_utility::activate_trigger_with_targetname("combat_one_trig_wave1_color");
  maps\_utility::activate_trigger_with_targetname("combat_one_trig_wave2");
  common_scripts\utility::waitframe();
  var_0 = get_all_wave_guys();

  while(var_0.size > 2) {
    if(common_scripts\utility::flag("combat_one_wave2_spawned")) {
      break;
    }

    var_0 = get_all_wave_guys();
    common_scripts\utility::waitframe();
  }

  level thread start_fuel_leak_fx("fuel_explosion_spark_point0");
  level thread start_fuel_leak_fx("fuel_explosion_spark_point1");
  level thread smart_radio_dialogue_enable_bc(0.33, "loki_kgn_watchyourfiredont", "combat_one_wave3_spawned", 1);
  var_0 = get_all_wave_guys();

  while(var_0.size > 1) {
    if(common_scripts\utility::flag("combat_one_wave3_spawned")) {
      break;
    }

    var_0 = get_all_wave_guys();
    common_scripts\utility::waitframe();
  }

  maps\loki_util::jkuprint("w3: via tracker");
  maps\_utility::battlechatter_off("allies");
  level maps\_utility::delaythread(1.5, ::start_fuel_leak_fx, "fuel_explosion_spark_point2");
  wait 2.666;
  level thread force_traversal("combat_one_traversal1", "cover_one_ally0_node2", "combat_one_ally0_traversal3", "combat_one_traversal3");
  level.allies[2] maps\_utility::set_force_color("r");
  level.allies[2].fixednode = 0;
  maps\_utility::activate_trigger_with_targetname("combat_one_trig_wave2_color");
  maps\_utility::activate_trigger_with_targetname("combat_one_trig_wave3");
  common_scripts\utility::flag_wait("cool_spawn_finished");
  level thread smart_radio_dialogue_enable_bc(4, "loki_kgn_thompsonwevegottangos", undefined, 1);
  var_1 = gettime() + 4000;
  common_scripts\utility::waitframe();
  var_0 = get_all_wave_guys(1);

  while(var_0.size > 2) {
    var_0 = get_all_wave_guys(1);
    common_scripts\utility::waitframe();
  }

  maps\loki_util::jkuprint("end: final stand");

  if(!common_scripts\utility::flag("start_fuel_explosion") && gettime() - var_1 > 1000) {
    maps\_utility::battlechatter_off("allies");
    level thread smart_radio_dialogue_enable_bc(0.66, "loki_kgn_clearthehatchthats", undefined, 1);
  }

  level thread link_final_exposed_nodes();
  var_0 = get_all_wave_guys(1);

  foreach(var_3 in var_0) {
    level thread maps\loki_util::reassign_goal_volume(var_3, "combat_one_final");
    var_3.health = 150;
  }

  var_0 = get_all_wave_guys(1);

  while(var_0.size > 0) {
    var_0 = get_all_wave_guys(1);
    common_scripts\utility::waitframe();
  }

  maps\loki_util::jkuprint("end: via tracker");
  level notify("player_can_move_to_door");
  maps\_utility::battlechatter_off("allies");
  level maps\_utility::delaythread(1, ::start_fuel_leak_fx, "fuel_explosion_spark_point3");
  level maps\_utility::delaythread(2, ::start_fuel_leak_fx, "fuel_explosion_spark_point4");
  var_5 = 0.8;
  level thread ally0_move_to_end();
  level maps\_utility::delaythread(var_5, ::moving_cover_pre_tele);
  maps\_utility::activate_trigger_with_targetname("combat_one_trig_wave3_color");
  var_6 = common_scripts\utility::getstruct("ally1_at_door", "targetname");
  level.allies[1] maps\_utility::clear_force_color();
  level.allies[1] setgoalpos(var_6.origin);
  var_7 = common_scripts\utility::getstruct("ally2_at_door", "targetname");
  level.allies[2] maps\_utility::clear_force_color();
  level.allies[2] setgoalpos(var_7.origin);
  wait(var_5);

  if(!common_scripts\utility::flag("start_fuel_explosion"))
    level maps\_utility::smart_radio_dialogue("loki_kgn_entrancesecuredmovein");
}

smart_radio_dialogue_enable_bc(var_0, var_1, var_2, var_3) {
  level endon("explosion");
  level endon("player_can_move_to_door");

  if(isDefined(var_2))
    level endon(var_2);

  wait(var_0);
  level maps\_utility::smart_radio_dialogue(var_1);
  wait(randomfloatrange(1, 2));

  if(isDefined(var_3) && var_3)
    maps\_utility::battlechatter_on("allies");
}

ally0_move_to_end() {
  level endon("explosion");
  level.player endon("death");
  var_0 = force_traversal("combat_one_traversal1", "combat_one_ally0_traversal3", undefined, "combat_one_traversal4");

  if(!var_0) {
    maps\loki_util::jkuprint("ally unable to animate last traversal");
    level.allies[0] stopanimscripted();
    level.combat_one_wave_node maps\_anim::anim_reach_solo(level.allies[0], "hatch_idle");
  }

  level.combat_one_wave_node thread maps\_anim::anim_loop_solo(level.allies[0], "hatch_idle", "explosion");

  if(!common_scripts\utility::flag("start_fuel_explosion")) {
    thread maps\loki_audio::sfx_end_combat_amb();
    level thread maps\_utility::smart_radio_dialogue("loki_kgn_throughherekick");
  }

  wait 6;
  var_1 = ["loki_kgn_hurryupkickwe", "loki_kgn_letsmoveitkick"];
  level.allies[0] thread maps\loki_util::play_nag(var_1, "start_fuel_explosion", 3, 8, 1, 8, "start_fuel_explosion");
}

set_goalvolume_after_node_reached(var_0, var_1) {
  self endon("death");
  level endon("combat_one_wave2_started");
  self.og_goalradius = self.goalradius;
  self.goalradius = 8;
  self waittill("goal");
  self waittill("goal");
  self.goalradius = self.og_goalradius;
  wait 10;

  if(!common_scripts\utility::flag(var_1))
    self setgoalvolumeauto(getent(var_0, "targetname"));
}

spawn_wave1_enemies(var_0) {
  var_1 = maps\loki_util::spawn_space_ai_from_targetname("combat_one_wave1_upper");
  var_1 thread set_goalvolume_after_node_reached("combat_one_wave1", "combat_one_wave2_started");
  var_1 thread combat_one_enemy();
  var_1 = maps\loki_util::spawn_space_ai_from_targetname("combat_one_wave1_lower");
  var_1 thread set_goalvolume_after_node_reached("combat_one_wave1", "combat_one_wave2_started");
  var_1 thread combat_one_enemy();
  var_2 = cool_spawn("combat_one_wave1_top", 3, var_0);
  level.exposed_guy = var_2[1];

  foreach(var_1 in var_2) {
    var_1 thread set_goalvolume_after_node_reached("combat_one_wave1", "combat_one_wave2_started");
    var_1 thread combat_one_enemy();
  }

  common_scripts\utility::flag_set("first_wave_spawned");
}

trigger_wave2() {
  level endon("explosion");
  var_0 = getent("combat_one_trig_wave2", "targetname");
  var_0 waittill("trigger");
  maps\loki_util::jkuprint("w2");
  level thread force_traversal("combat_one_traversal1", "cover_one_ally2_node1", "combat_one_traversal1_post", "combat_one_traversal1");
  level thread force_traversal("combat_one_traversal1", "cover_one_ally0_node1", "cover_one_ally0_node2", "combat_one_traversal2");
  var_1 = get_all_wave_guys();

  foreach(var_3 in var_1) {
    if(isDefined(self.og_goalradius))
      self.goalradius = self.og_goalradius;

    level thread maps\loki_util::reassign_goal_volume(var_3, "combat_one_wave2");
  }

  var_5 = maps\loki_util::spawn_space_ais_from_targetname("combat_one_wave2_new");

  foreach(var_7 in var_5)
  var_7 thread combat_one_enemy();
}

trigger_wave3() {
  level endon("explosion");
  var_0 = getent("combat_one_trig_wave3", "targetname");
  var_0 waittill("trigger");
  maps\loki_util::jkuprint("w3");
  common_scripts\utility::flag_set("combat_one_wave3_spawned");
  var_1 = get_all_wave_guys();

  foreach(var_3 in var_1)
  level thread maps\loki_util::reassign_goal_volume(var_3, "combat_one_wave3");

  level thread maps\loki_util::loki_autosave_now();
  var_5 = door_traversal();
}

capsule_ninja() {
  level endon("explosion");
  level endon("player_can_move_to_door");
  common_scripts\utility::flag_wait("door_traversal_done");
  common_scripts\utility::flag_wait("trigger_capsule_ninja");
  var_0 = maps\loki_util::spawn_space_ai_from_targetname("combat_one_capsule_ninja");
  var_0 thread maps\loki_util::loki_drop_weapon();
  var_0.health = 250;
  var_0.baseaccuracy = 50;
  var_0.favoriteenemy = level.player;
  var_0.ignoreme = 1;

  for(var_0.fixednode = 1; isalive(self); self.baseaccuracy = 50) {
    common_scripts\utility::flag_waitopen("trigger_capsule_ninja");
    maps\loki_util::jkuprint("ninja n-ap");
    self.favoriteenemy = undefined;
    self.baseaccuracy = level.accuracy_enemy;
    common_scripts\utility::flag_wait("trigger_capsule_ninja");
    maps\loki_util::jkuprint("ninja ap");
    self.favoriteenemy = level.player;
  }
}

combat_one_enemy() {
  self.baseaccuracy = level.accuracy_enemy;
  self.maxfaceenemydist = 1024;
  thread maps\loki_util::loki_drop_weapon();
  thread enemy_attack_player_when_flashing();
}

enemy_attack_player_when_flashing() {
  self endon("death");
  level.player endon("death");
  level endon("player_can_move_to_door");

  while(isalive(self)) {
    common_scripts\utility::flag_wait("player_too_close_to_door");
    maps\loki_util::jkuprint("ap");
    self.favoriteenemy = level.player;
    self.baseaccuracy = 50;
    common_scripts\utility::flag_waitopen("player_too_close_to_door");
    maps\loki_util::jkuprint("n-ap");
    self.favoriteenemy = undefined;
    self.baseaccuracy = level.accuracy_enemy;
  }
}

cool_spawn(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = undefined;

  if(!isDefined(var_4))
    var_4 = 1;

  var_5 = [];
  var_6 = getent("combat_one_door_col", "targetname");
  var_6 notsolid();
  var_6 connectpaths();

  for(var_7 = 0; var_7 < var_1; var_7++) {
    var_8 = maps\loki_util::spawn_space_ai_from_targetname(var_0 + var_7, var_2);
    var_8 thread ignore_and_move_fast(var_3);
    var_5 = common_scripts\utility::add_to_array(var_5, var_8);

    if(!var_2)
      wait 0.5;
  }

  if(!var_2 && var_4)
    var_6 common_scripts\utility::delaycall(8, ::rotateto, (0, 0, 0), 1, 0.5, 0.5);

  var_6 common_scripts\utility::delaycall(8, ::solid);
  var_6 common_scripts\utility::delaycall(8.1, ::disconnectpaths);
  common_scripts\utility::flag_set("cool_spawn_finished");
  return var_5;
}

door_traversal() {
  var_0 = getnode("combat_one_door_node1", "targetname");
  var_1 = getnode("combat_one_door_node2", "targetname");
  var_2 = getnode("combat_one_door_node3", "targetname");
  var_3 = getnode("combat_one_door_node4", "targetname");
  var_4 = maps\loki_util::spawn_space_ai_from_targetname("combat_one_wave3_0");
  var_4.animname = "opfor1";
  var_4 thread door_traversal_move(var_0);
  var_5 = maps\loki_util::spawn_space_ai_from_targetname("combat_one_wave3_1");
  var_5.animname = "opfor2";
  var_5 thread door_traversal_move(var_1);
  var_6 = maps\loki_util::spawn_space_ai_from_targetname("combat_one_wave3_2");
  var_6.animname = "opfor3";
  var_6 thread door_traversal_move(var_2);
  var_7 = maps\loki_util::spawn_space_ai_from_targetname("combat_one_wave3_3");
  var_7.animname = "opfor4";
  var_7 thread door_traversal_move(var_3);
  common_scripts\utility::flag_set("door_traversal_done");
  level.combat_one_door_node maps\_anim::anim_single_solo(level.combat_one_door, "combat_one_door");
  level.combat_one_door_col connectpaths();
}

door_traversal_move(var_0) {
  self.health = 300;
  self.fixednode = 1;
  self.allowdeath = 1;
  self.ignoreme = 1;
  thread force_traversal_check_hit();
  level.combat_one_door_node maps\_anim::anim_single_solo(self, "combat_one_door");
  var_0 connectnode();

  if(isalive(self)) {
    self notify("door_traversal_finished");
    self notify("stop_traversal_hit_detection");
    thread combat_one_enemy();
    maps\_utility::delaythread(15, maps\_utility::set_fixednode_false);
    maps\_utility::delaythread(15, maps\loki_util::jkuprint, self.animname + " free!");
    self.health = 150;
    self.ignoreme = 0;
  }

  self setgoalnode(var_0);
}

check_for_death_during_traversal() {
  self endon("death");
  self endon("door_traversal_finished");

  while(self.health > 1)
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  self stopanimscripted();
}

ignore_and_move_fast(var_0) {
  self endon("death");
  var_1 = self.health;
  self.health = 9999;
  self.ignoreme = 1;
  self.ignoreall = 1;
  var_2 = self.moveplaybackrate;
  self.moveplaybackrate = 1.5;

  if(isDefined(var_0))
    self setgoalvolumeauto(getent(var_0, "targetname"));

  wait 1.5;
  self.health = var_1;
  self.ignoreme = 0;
  self.ignoreall = 0;
  self.moveplaybackrate = var_2;
}

die_from_explosion() {
  self endon("death");

  if(isalive(self)) {
    maps\_anim::anim_generic(self, "explosion_part1");
    self kill();
  }
}

get_all_wave_guys(var_0) {
  var_1 = maps\_utility::get_ai_group_ai("combat_one_wave1");
  var_2 = maps\_utility::get_ai_group_ai("combat_one_wave2");
  var_1 = maps\_utility::array_merge(var_1, var_2);

  if(isDefined(var_0) && var_0) {
    var_3 = maps\_utility::get_ai_group_ai("combat_one_wave3");
    var_1 = maps\_utility::array_merge(var_1, var_3);
  }

  var_1 = maps\_utility::array_removedead_or_dying(var_1);
  return var_1;
}

get_all_allies() {
  var_0 = level.allies;
  var_1 = level.redshirts;
  var_0 = maps\_utility::array_merge(var_0, var_1);
  var_0 = maps\_utility::array_removedead_or_dying(var_0);
  return var_0;
}

unlink_final_exposed_nodes() {
  var_0 = getnodearray("combat_one_final_exposed_node", "targetname");

  foreach(var_2 in var_0)
  var_2 disconnectnode();
}

link_final_exposed_nodes() {
  var_0 = getnodearray("combat_one_final_exposed_node", "targetname");

  foreach(var_2 in var_0)
  var_2 connectnode();
}

unlink_door_traversal_nodes() {
  var_0 = getnode("combat_one_door_node1", "targetname");
  var_1 = getnode("combat_one_door_node2", "targetname");
  var_2 = getnode("combat_one_door_node3", "targetname");
  var_3 = getnode("combat_one_door_node4", "targetname");
  var_0 disconnectnode();
  var_1 disconnectnode();
  var_2 disconnectnode();
  var_3 disconnectnode();
}

force_traversal(var_0, var_1, var_2, var_3) {
  level endon("explosion");
  var_4 = getnode(var_1, "targetname");
  var_5 = getent(var_0, "targetname");

  if(!isDefined(var_2))
    var_6 = undefined;
  else
    var_6 = getnode(var_2, "targetname");

  var_7 = get_all_allies();

  foreach(var_9 in var_7) {
    maps\loki_util::jkuprint(var_9.animname + ": " + distance(var_9.origin, var_4.origin));

    if(distance(var_9.origin, var_4.origin) < 40) {
      maps\loki_util::jkuprint(var_9.animname + ": near node");
      var_9 endon("death");
      var_9.ignoreme = 1;
      var_9 thread force_traversal_check_hit();
      var_5 maps\_anim::anim_generic_reach(var_9, var_3);
      var_5 maps\_anim::anim_generic(var_9, var_3);
      var_9.ignoreme = 0;
      var_9 notify("stop_traversal_hit_detection");

      if(isDefined(var_6))
        var_9 setgoalnode(var_6);

      return 1;
    }
  }

  return 0;
}

#using_animtree("generic_human");

force_traversal_check_hit() {
  self endon("death");
  self endon("stop_traversal_hit_detection");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    maps\loki_util::jkuprint(self.animname + " hit while in traversal");
    self setanimrestart( % loki_traversal_pain_1, 1, 0.2);
    wait 0.5;
  }
}

player_in_combat_area() {
  for(;;) {
    if(common_scripts\utility::flag("in_combat_area"))
      iprintln("player safe");

    common_scripts\utility::waitframe();
  }
}

solarpanels_damage_think() {
  level endon("explosion");
  level.player endon("death");
  self setCanDamage(1);
  self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

  if(var_0 < 200) {
    wait 0.1;

    if(randomint(3) == 0)
      self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  }

  var_11 = getglass(self.target);
  destroyglass(var_11, var_2);
  solarpanel_disconnect_nodes();
}

solarpanels_damage_think_instant() {
  level endon("explosion");
  level.player endon("death");

  for(;;) {
    var_0 = getglass(self.target);

    if(isglassdestroyed(var_0)) {
      break;
    }

    common_scripts\utility::waitframe();
  }

  solarpanel_disconnect_nodes();
}

solarpanel_disconnect_nodes() {
  var_0 = getnodesinradius(self.origin, 48, 0, 48, "cover");

  foreach(var_2 in var_0) {
    var_2 disconnectnode();
    badplace_cylinder("foo", 0, var_2.origin, 48, 48, "axis", "allies");
    var_3 = get_all_wave_guys();

    foreach(var_5 in var_3) {
      if(var_5 nearnode(var_2))
        maps\loki_util::jkuprint("crap my node sucks now");
    }
  }

  self hide();
  self notsolid();
}

random_explosions(var_0, var_1, var_2) {
  level.player endon("death");
  level endon("stop_explosions");
  playFX(common_scripts\utility::getfx("fuel_explosion_zerog"), var_0);

  if(!isDefined(var_1))
    earthquake(0.6, 1, level.player.origin, 1600);

  for(;;) {
    wait(randomfloatrange(1, 3));
    thread maps\loki_audio::sfx_gas_line_dist_explo(var_0);

    if(isDefined(var_2))
      playFX(common_scripts\utility::getfx("fuel_explosion_zerog"), var_0);
    else
      playFX(common_scripts\utility::getfx("explosion_small"), var_0);

    if(!isDefined(var_1))
      earthquake(0.3, 1, level.player.origin, 1600);
  }
}

track_player_hiding() {
  var_0 = getEntArray("combat_one_hide", "targetname");
  level.hiding_icon = maps\_hud_util::createicon("green_block", 16, 16);
  level.hiding_icon.alignx = "right";
  level.hiding_icon.aligny = "middle";
  level.hiding_icon.vertalign = "top";
  level.hiding_icon.alpha = 0;
  level.hiding_icon.hidewhendead = 0;
  level.hiding_icon.hidewheninmenu = 0;
  level.hiding_icon.sort = -205;
  level.hiding_icon.foreground = 1;
  level thread set_player_hidden();
}

track_hiding_think() {
  self endon("death");
  level.last_used_cover_vol = 0;

  for(;;) {
    if(level.player istouching(self) && self != level.last_used_cover_vol) {
      common_scripts\utility::flag_set("combat_one_player_hiding");
      level.hiding_icon.alpha = 0.8;
    } else if(level.player istouching(self)) {} else if(level.player_in_cover) {
      common_scripts\utility::flag_clear("combat_one_player_hiding");
      level.player_in_cover = 0;
      level.hiding_icon.alpha = 0.0;
    }

    common_scripts\utility::waitframe();
  }
}

set_player_hidden() {
  level.player endon("death");

  for(;;) {
    common_scripts\utility::flag_wait("combat_one_player_hiding");
    level.hiding_icon.alpha = 0.8;
    level.player.ignoreme = 1;
    common_scripts\utility::flag_waitopen("combat_one_player_hiding");
    level.hiding_icon.alpha = 0;
    level.player.ignoreme = 0;
  }
}

do_tile_single(var_0, var_1) {
  get_touching_tiles(var_0);
  get_edge_tiles(var_1);
  self.tilealive = 1;
  self setCanDamage(1);
  self endon("tileDeath");
  var_2 = undefined;

  for(;;) {
    self waittill("damage", var_3, var_4, var_5, var_2, var_6, var_7, var_8, var_9, var_10, var_11);

    if(var_6 == "MOD_GRENADE_SPLASH" || var_6 == "MOD_EXPLOSIVE") {
      if(var_6 == "MOD_EXPLOSIVE" && var_4.classname == "script_model")
        var_2 = var_4 getcentroid();

      thread dogrenadesplash(var_2);
      continue;
    }

    if(level.activebreaks < 10) {
      break;
    }
  }

  thread tile_death(var_2);
}

dogrenadesplash(var_0) {
  if(level.grenadesplashing) {
    return;
  }
  level.grenadesplashing = 1;
  var_1 = common_scripts\utility::get_array_of_closest(var_0, getEntArray("breakTile", "targetname"), undefined, 75);
  var_1 = featherents(var_1);
  common_scripts\utility::array_thread(var_1, ::tile_death, var_0);
  thread removegrenadesplash();
}

featherents(var_0) {
  var_1 = 1;
  var_2 = [];

  foreach(var_4 in var_0) {
    if(var_1)
      var_2[var_2.size] = var_4;

    var_1 = !var_1;
  }

  return var_2;
}

removegrenadesplash() {
  wait 0.05;
  level.grenadesplashing = 0;
}

get_touching_tiles(var_0) {
  self.touchingtiles = [];

  foreach(var_2 in var_0) {
    if(var_2 istouchinglinktos(self) && var_2 != self)
      self.touchingtiles[self.touchingtiles.size] = var_2;
  }
}

get_edge_tiles(var_0) {
  self.edgetiles = [];

  foreach(var_2 in var_0) {
    if(var_2 istouchinglinktos(self) && var_2 != self)
      self.edgetiles[self.edgetiles.size] = var_2;
  }
}

istouchinglinktos(var_0) {
  return var_0 islinkedto(self) || islinkedto(var_0);
}

islinkedto(var_0) {
  var_1 = common_scripts\utility::get_linked_ents();

  foreach(var_3 in var_1) {
    if(var_3 == var_0)
      return 1;
  }

  return 0;
}

tile_spider(var_0) {
  if(!self.tilealive) {
    return;
  }
  var_1 = spawnStruct();
  var_1.basetile = self;
  var_1.testedarray = [];
  var_1.totestarray = self.touchingtiles;
  var_1.foundwall = 0;
  var_1.livingedgeconnections = 0;

  foreach(var_3 in self.touchingtiles) {
    if(var_3.tilealive && var_3.edgetiles.size)
      var_1.livingedgeconnections++;
  }

  while(!var_1.foundwall && var_1.totestarray.size > 0) {
    var_5 = var_1.totestarray[0];
    var_1.totestarray = common_scripts\utility::array_remove(var_1.totestarray, var_5);

    if(!var_5.tilealive) {
      continue;
    }
    var_5 tile_attached_to_edge(var_1);
  }

  if(var_1.foundwall && nonedgemaintains(var_1)) {
    return;
  }
  thread tile_death(var_0);
}

nonedgemaintains(var_0) {
  if(self.edgetiles.size > 0)
    return 1;

  if(var_0.livingedgeconnections > 1)
    return 1;

  return 1;
}

tile_attached_to_edge(var_0) {
  if(common_scripts\utility::array_contains(var_0.testedarray, self))
    return;
  else
    var_0.testedarray[var_0.testedarray.size] = self;

  if(self.edgetiles.size > 0)
    var_0.foundwall = 1;

  foreach(var_2 in self.touchingtiles) {
    if(!var_2.tilealive) {
      continue;
    }
    if(!common_scripts\utility::array_contains(var_0.testedarray, var_2))
      var_0.totestarray[var_0.totestarray.size] = var_2;
  }
}

tile_death(var_0) {
  if(!self.tilealive) {
    return;
  }
  level.activebreaks = level.activebreaks + 1;
  self notify("tileDeath");
  self.tilealive = 0;
  var_1 = var_0;
  self rotatevelocity(var_1, 0.5);
  self movegravity((0, 0, -3), 1);

  foreach(var_3 in self.touchingtiles)
  var_3 maps\_utility::delaythread(randomfloatrange(0.05, 0.1), ::tile_spider, var_0);

  thread decrementlevelbreaks();
  thread fallingtileeffect();
}

fallingtileeffect() {
  while(self.origin[2] > -64)
    wait 0.05;

  var_0 = maps\_utility::set_z(self.origin, -64);
}

decrementlevelbreaks() {
  wait 0.05;
  level.activebreaks--;
}

combat_one_cleanup() {
  var_0 = getEntArray("combat_one_cleanup", "script_noteworthy");
  maps\loki_util::jkuprint(var_0.size + ": combat one ents cleaned up");
}

firstframe_combat_one_door() {
  level.combat_one_door_node = getent("combat_one_door_traversal", "targetname");
  level.combat_one_door = maps\_utility::spawn_anim_model("combat_one_door");
  level.combat_one_door_node thread maps\_anim::anim_first_frame_solo(level.combat_one_door, "combat_one_door");
  level.combat_one_door_col = getent("combat_one_door_col", "targetname");
  level.combat_one_door_col linkto(level.combat_one_door);
  level.combat_one_door_col disconnectpaths();
}

track_fuel_leak_hit() {
  level endon("explosion");
  var_0 = getent("fuel_leak_col", "targetname");
  var_0 setCanDamage(1);
  var_0 setCanRadiusDamage(0);
  level.bullet_caused_fuel_leaks = [];

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    var_12 = vectortoangles(var_3 * -1);
    level thread line_debug(var_4, var_4 + anglesToForward(var_12) * 12, (1, 1, 1));
    var_13 = bulletTrace(var_4 + anglesToForward(var_12) * 1, var_4, 0);
    var_12 = vectortoangles(var_13["normal"]);

    if(distance(var_12, vectortoangles(var_3)) < 1) {
      maps\loki_util::jkuprint("bad leak angles");
      level thread line_debug(var_4, var_4 + anglesToForward(var_12) * 12, (1, 0, 0));
      var_12 = vectortoangles(var_3 * -1);
    } else
      level thread line_debug(var_4, var_4 + anglesToForward(var_12) * 12, (0, 0, 1));

    var_14 = start_fuel_leak_fx(undefined, 1, var_4, var_12);
    level.bullet_caused_fuel_leaks[level.bullet_caused_fuel_leaks.size] = var_14;

    if(level.bullet_caused_fuel_leaks.size > 5) {
      maps\loki_util::jkuprint("deleting leak");
      level.bullet_caused_fuel_leaks[0] notify("death");
      level.bullet_caused_fuel_leaks = maps\_utility::array_remove_index(level.bullet_caused_fuel_leaks, 0);
    }

    maps\loki_util::jkuprint("hits: " + level.bullet_caused_fuel_leaks.size);
    wait 0.3;
  }
}

line_debug(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < 1000; var_3++) {
    maps\loki_util::jkuline(var_0, var_1, var_2);
    common_scripts\utility::waitframe();
  }
}