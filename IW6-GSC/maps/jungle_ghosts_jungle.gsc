/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\jungle_ghosts_jungle.gsc
*****************************************/

intro_setup() {
  thread maps\jungle_ghosts_util::cull_distance_logic();
  thread maps\jungle_ghosts_util::fade_out_in("black", undefined, 1);
  level.player setclienttriggeraudiozone("jungle_ghosts_falling_through_air", 1.5);
  thread maps\_utility::vision_set_fog_changes("", 1);
  var_0 = maps\_utility::spawn_anim_model("player_harness", (0, 0, 0));
  level.harness_model = var_0;
  var_1 = common_scripts\utility::getstruct("parachute_anim_ent_player", "targetname");
  var_2 = maps\_utility::spawn_anim_model("player_rig", var_1.origin);
  var_2 hide();
  thread sunflare_toggle();
  level.player enableinvulnerability();
  maps\jungle_ghosts_util::move_player_to_start("player_freefall_start");
  var_3 = level.player common_scripts\utility::spawn_tag_origin();
  level.player playerlinkto(var_3);
  var_3 movegravity((500, 900, 100), 15);
  level.player freezecontrols(1);
  maps\_utility::trigger_wait_targetname("player_freefall_impact");
  level.player unlink();
  var_3 delete();
  level.player clearclienttriggeraudiozone(0.8);
  level.player playrumbleonentity("grenade_rumble");
  thread maps\jungle_ghosts_util::fade_out_in("white", undefined, 0.4);
  level.player freezecontrols(0);
  thread setup_friendlies();
  thread setup_jungle_enemies();
  thread close_to_waterfall_enemy_logic();
  thread parachute_intro_fx();
  level.player allowstand(1);
  level.player setstance("stand");
  level.player allowsprint(0);
  level.player allowcrouch(0);
  maps\_utility::delaythread(1, maps\jungle_ghosts_util::hud_on, 0);
  var_2 common_scripts\utility::delaycall(0.4, ::show);
  level.player playerlinktoblend(var_2, "tag_player", 0.4, 0.2, 0.2);
  level.player playerlinktodelta(var_2, "tag_player", 1, 12, 12, 5, 20);
  level.player notify("start_falling_anim");
  var_4 = [var_2, var_0];
  level thread chute_flies_up();
  var_1 maps\_anim::anim_single(var_4, "para_crash");
  var_2 attach("viewmodel_knife_iw6", "tag_weapon_right");
  level.player notify("done_falling");
  var_1 thread maps\_anim::anim_loop(var_4, "para_idle", "stop_idle");
  parachute_waittill_player_cuts();
  thread player_landing_sound();
  var_1 notify("stop_idle");
  var_2 maps\_utility::anim_stopanimscripted();
  level.player playerlinktoblend(var_2, "tag_player", 0.4, 0, 0);
  thread cut_exploders();
  var_1 maps\_anim::anim_single(var_4, "para_cut");
  var_2 detach("viewmodel_knife_iw6", "tag_weapon_right");
  var_2 delete();
  level.player unlink();
  thread tree_delete();
  var_0 delete();
  thread maps\_utility::autosave_stealth();
  thread hill_fx();
  thread maps\jungle_ghosts_util::do_bokeh("hill_pos_1");
  thread stand_player_up();
  thread do_birds();
  level thread jungle_stealth_settings();
  thread connect_dropdown_traverse();
  thread first_distant_sat_launch();
  thread dead_pilot_hang();
  level.did_inactive_vo = 0;
  level.laser_count = 0;
  common_scripts\utility::flag_wait("jungle_entrance");

  if(!common_scripts\utility::flag("_stealth_spotted")) {
    maps\_utility::autosave_stealth();
  }

  thread maps\jungle_ghosts_util::battle_chatter_controller_friendlies();
}

sunflare_toggle() {
  common_scripts\utility::exploder("sunflare");

  while(level.player.origin[1] < 9330) {
    wait 1;
  }

  maps\_utility::stop_exploder("sunflare");
}

cut_exploders() {
  var_0 = "j_RightDown4";
  var_1 = "j_LeftDown4";
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = level.harness_model gettagorigin(var_0) - (0, 0, 2);
  var_3.origin = level.harness_model gettagorigin(var_1);
  var_2 linkto(level.harness_model);
  var_3 linkto(level.harness_model);
  wait 0.85;
  playFXOnTag(common_scripts\utility::getfx("vfx_parachute_strap_cut"), var_2, "tag_origin");
  level.player playrumbleonentity("grenade_rumble");
  wait 2.5;
  playFXOnTag(common_scripts\utility::getfx("vfx_parachute_strap_cut"), var_3, "tag_origin");
  level.player playrumbleonentity("grenade_rumble");
}

player_landing_sound() {
  wait 4.6;
  level.player thread maps\_utility::play_sound_on_entity("scn_jungle_tree_jumpland");
  level.player thread maps\_gameskill::blood_splat_on_screen("bottom");
  level.player thread maps\_gameskill::grenade_dirt_on_screen("bottom");
  level.player thread maps\_gameskill::blood_splat_on_screen("right");
  level.player thread maps\_gameskill::grenade_dirt_on_screen("right");
}

#using_animtree("generic_human");

dead_pilot_hang() {
  var_0 = getEntArray("dead_guy_chutes", "targetname");
  var_0[0].linker = var_0[0] common_scripts\utility::spawn_tag_origin();
  var_0[1].linker = var_0[1] common_scripts\utility::spawn_tag_origin();
  var_1 = 286;
  var_0[0].linker.origin = var_0[0].origin + (0, 0, var_1);
  var_0[1].linker.origin = var_0[1].origin + (0, 0, var_1);
  var_0[0] linkto(var_0[0].linker, "tag_origin");
  var_0[1] linkto(var_0[1].linker, "tag_origin");
  var_2 = common_scripts\utility::get_target_ent("lt_jokes");
  var_2.animname = "dead_jungle_pilot";
  var_2 attach("head_pilot_a", "", 1);
  var_2.anim_ent = var_2 common_scripts\utility::spawn_tag_origin();
  var_2 linkto(var_2.anim_ent, "tag_origin");
  var_2.anim_ent linkto(var_0[0].linker, "tag_origin");
  var_2 useanimtree(#animtree);
  var_2.anim_ent thread maps\_anim::anim_loop_solo(var_2, "dead_idle", "dead_hang_ender");

  for(;;) {
    var_0[0].linker rotateto(var_0[0].linker.angles + (0.5, 0, 0), 6, 0, 0);
    var_0[1].linker rotateto(var_0[1].linker.angles - (0.5, 0, 0), 6, 0, 0);
    wait 5;
    var_0[0].linker rotateto(var_0[0].linker.angles - (0.5, 0, 0), 6, 0, 0);
    var_0[1].linker rotateto(var_0[1].linker.angles + (0.5, 0, 0), 6, 0, 0);
    wait 5;
    var_0[0].linker rotateto(var_0[0].linker.angles - (0.5, 0, 0), 6, 0, 0);
    var_0[1].linker rotateto(var_0[1].linker.angles + (0.5, 0, 0), 6, 0, 0);
    wait 5;
    var_0[0].linker rotateto(var_0[0].linker.angles + (0.5, 0, 0), 6, 0, 0);
    var_0[1].linker rotateto(var_0[1].linker.angles - (0.5, 0, 0), 6, 0, 0);
    wait 5;
  }
}

tree_delete() {
  var_0 = getEntArray("intro_trees", "targetname");

  foreach(var_2 in var_0) {
    var_2 delete();
  }
}

hill_fx() {
  common_scripts\utility::exploder("wind");
  common_scripts\utility::flag_wait("hill_pos_1");
  common_scripts\utility::flag_wait_any("crash_arrive", "_stealth_spotted");
  wait 3.5;
  maps\_utility::stop_exploder("wind");
  common_scripts\utility::exploder("nonwind");

  if(level.ps3) {
    common_scripts\utility::exploder("crash_site_fire_nonwind_ps3");
  } else {
    common_scripts\utility::exploder("crash_site_fire_nonwind");
  }
}

jungle_moving_foliage_settings() {
  setsaveddvar("r_reactiveMotionPlayerRadius", 100);
  setsaveddvar("r_reactiveMotionActorRadius", 20);
  setsaveddvar("r_reactiveMotionActorVelocityMax", 0.5);
  setsaveddvar("r_reactiveMotionEffectorStrengthScale", 10);
  setsaveddvar("r_reactiveMotionWindDir", (1, 1, 1));
  setsaveddvar("r_reactiveMotionWindFrequencyScale", 0.03);
  setsaveddvar("r_reactiveMotionWindAmplitudeScale", 2);
  setsaveddvar("r_reactiveMotionWindStrength", 0);
  maps\jungle_ghosts_util::adjust_moving_grass(0.8, 1, 0.4, 0.15);
}

keep_up_with_player(var_0) {
  self endon(var_0);
  thread keep_up_with_player_reset(var_0);
  self.orig_speed = self.moveplaybackrate;

  for(;;) {
    if(maps\_utility::ent_flag("override_follow_logic")) {
      wait 0.1;
      continue;
    }

    var_1 = distance2d(self.origin, level.player.origin);
    var_2 = 250;

    if(var_1 > var_2 && !common_scripts\utility::within_fov(level.player.origin, level.player.angles, self.origin, cos(90))) {
      self.moveplaybackrate = 1.25;
      var_1 = distance2d(self.origin, level.player.origin);

      while(var_1 > 100 && !common_scripts\utility::within_fov(level.player.origin, level.player.angles, self.origin, cos(90))) {
        var_1 = distance2d(self.origin, level.player.origin);
        wait 0.05;
      }

      self.moveplaybackrate = self.orig_speed;
    }

    common_scripts\utility::waitframe();
  }
}

keep_up_with_player_reset(var_0) {
  self waittill(var_0);
  self.moveplaybackrate = self.orig_speed;
}

parachute_waittill_player_cuts() {
  notifyoncommand("cut", "+melee");
  notifyoncommand("cut", "+melee_breath");
  notifyoncommand("cut", "+melee_zoom");
  thread draw_cut_hint();
  level.player waittill("cut");

  if(isDefined(level.cut_hint)) {
    var_0 = 1.5;
    thread fade_out_cut_hint(var_0);
    thread destroy_hint(var_0);
  }
}

destroy_hint(var_0) {
  wait(var_0);

  foreach(var_2 in level.cut_hint) {
    var_2 destroy();
  }
}

draw_cut_hint() {
  level.player endon("cut");
  wait 5;
  var_0 = 125;
  var_1 = 0;
  var_2 = 1;
  var_3 = level.player maps\_hud_util::createclientfontstring("default", 2);
  var_3.x = var_1 * -1;
  var_3.y = var_0;
  var_3.horzalign = "right";
  var_3.alignx = "right";
  var_3 set_default_hud_stuff();
  var_3 settext(&"JUNGLE_GHOSTS_MELEE_HINT");

  if(!level.console && !level.player usinggamepad()) {
    var_3.fontscale = 2;
  } else {
    var_3.fontscale = 2 * var_2;
  }

  var_4 = [];
  var_4["text"] = var_3;
  level.cut_hint = var_4;
  thread pulse_cut_hint();
}

set_default_hud_stuff() {
  level.player endon("cut");
  self.alignx = "center";
  self.aligny = "middle";
  self.horzalign = "center";
  self.vertalign = "middle";
  self.hidewhendead = 1;
  self.hidewheninmenu = 1;
  self.sort = 205;
  self.foreground = 1;
  self.alpha = 0;
}

pulse_cut_hint() {
  level.player endon("cut");

  for(;;) {
    fade_in_cut_hint();
    fade_out_cut_hint();
  }
}

fade_in_cut_hint(var_0) {
  level.player endon("cut");

  if(!isDefined(var_0)) {
    var_0 = 1.5;
  }

  foreach(var_2 in level.cut_hint) {
    var_2 fadeovertime(var_0);
    var_2.alpha = 0.95;
  }

  wait(var_0);
}

fade_out_cut_hint(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1.5;
  }

  foreach(var_2 in level.cut_hint) {
    var_2 fadeovertime(var_0);
    var_2.alpha = 0;
  }

  wait(var_0);
}

chute_flies_up() {
  wait 2.2;
  var_0 = level.player common_scripts\utility::spawn_tag_origin();
  var_0 setModel("parachute_hanging_static");
  var_0 show();
  var_0.origin = level.player.origin + (280, 0, -130);
  wait 4;
  var_0 delete();
}

parachute_sway_settings() {
  wait 0.15;
  var_0 = level.player getplayerangles();
  var_0 = (0, var_0[1], 0);
  var_1 = anglestoright(var_0);
  var_2 = var_1 * 10;
  var_3 = var_2 * -1;
  level endon("player_landed");
  var_4 = level.player.origin + var_2;
  var_5 = level.player.origin + var_3;
  var_6 = 12;
  self moveto(var_4, var_6 * 0.5);
  wait(var_6 * 0.5);

  for(;;) {
    var_6 = randomintrange(13, 18);
    self moveto(var_5, var_6, var_6 * 0.1, var_6 * 0.9);
    wait(var_6);
    self moveto(var_4, var_6, var_6 * 0.1, var_6 * 0.9);
    wait(var_6);
  }
}

parachute_intro_fx() {
  level endon("player_landed");
  thread parachute_intro_sound();
  level.player thread parachute_heartbeat();
  common_scripts\utility::exploder(1);
  level.player waittill("done_falling");
  setblur(5, 0.1);
  wait 2;
  setblur(0, 2);
  heartbeat();
  wait 1;
  do_bird_single();
  heartbeat();
  wait 2;
  heartbeat();
  wait 3;
  heartbeat();
}

parachute_heartbeat() {
  level.player endon("done_falling");

  for(;;) {
    heartbeat();
    wait 1.5;
  }
}

heartbeat() {
  setblur(5, 0.25);
  level.player thread maps\_utility::play_sound_on_entity("breathing_heartbeat");
  wait 0.25;
  setblur(0, 0.25);
}

parachute_intro_sound() {
  thread parachute_player_land_sounds();
  level endon("player_landed");
  level.player thread maps\_utility::play_sound_on_entity("scn_jungle_tree_landing");
  level.player common_scripts\utility::delaycall(3.0, ::setclienttriggeraudiozonepartial, "jungle_ghosts_intro_alley_no_ping", "mix");
}

parachute_player_land_sounds() {
  common_scripts\utility::flag_wait("player_landed");
  level.player playrumbleonentity("grenade_rumble");
  wait 0.5;
  level.player playrumbleonentity("grenade_rumble");
}

first_distant_sat_launch() {
  common_scripts\utility::flag_wait("jungle_entrance");
  level.player thread common_scripts\utility::play_sound_in_space("jg_sat_launch_distant_first", level.player.origin);
  wait 0.3;
  earthquake(0.1, 4, level.player.origin, 850);
  level.player playrumblelooponentity("damage_light");
  wait 4.0;
  level.player stoprumble("damage_light");
}

connect_dropdown_traverse() {
  var_0 = getent("dropdown_disconnect", "targetname");
  var_0 disconnectpaths();
  common_scripts\utility::flag_wait("hill_pos_1");
  var_0.origin = var_0.origin + (0, 0, 1000);
  var_0 connectpaths();
}

stand_player_up() {
  level.player.ground_ref_ent = common_scripts\utility::spawn_tag_origin();
  level.player playersetgroundreferenceent(level.player.ground_ref_ent);
  level.player thread enable_tired(75);
  level.player allowstand(0);
  level.player allowcrouch(0);
  level.player allowprone(1);
  level.player setstance("prone");
  thread maps\_utility::player_speed_set(75, 0.1);
  level.player setbobrate(2.25);
  level.player disableinvulnerability();

  while(level.player.origin[0] < -7900) {
    common_scripts\utility::waitframe();
  }

  level.player thread transition_stance_cover(6, 3, 2, 75);
  wait 1.5;
  level.player allowcrouch(1);
  level.player allowprone(0);
  level.player setstance("crouch");
  level.player maps\_utility::play_sound_on_entity("scn_player_get_up_to_crouch");

  while(level.player.origin[0] < -7510) {
    common_scripts\utility::waitframe();
  }

  level.player thread transition_stance_cover(6, 3, 2, 75);
  wait 1.5;
  level.player allowstand(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player setstance("stand");
  level.player maps\_utility::play_sound_on_entity("scn_player_get_up_to_stand");

  while(level.player.origin[0] < -7346) {
    common_scripts\utility::waitframe();
  }

  level.player allowstand(1);
  level.player allowcrouch(1);
  level.player allowprone(1);

  while(level.player.origin[0] < -7346) {
    common_scripts\utility::waitframe();
  }

  var_0 = ["p226_tactical+silencerpistol_sp+tactical_sp"];
  wait 0.25;
  level.player clearclienttriggeraudiozone(0.1);
  maps\jungle_ghosts_util::arm_player(var_0);
  maps\jungle_ghosts_util::hud_on(1);
  wait 1;

  while(level.player.origin[0] < -6877) {
    common_scripts\utility::waitframe();
  }

  common_scripts\utility::flag_set("intro_lines");
  level.player thread disable_tired(1);
  setsaveddvar("cg_footsteps", 1);

  if(level.start_point == "parachute") {
    maps\_introscreen::introscreen(1);
  }

  wait 3;
  level thread player_spotted_logic();
}

transition_stance_cover(var_0, var_1, var_2, var_3) {
  level.player disable_tired();
  level.player allowjump(0);
  thread maps\_utility::player_speed_set(25, 3);
  level.player setbobrate(2.25);
  setblur(var_0, var_1);
  level.player thread stumble(level.player.angles + (0, 0, 35), 0.75, 0.75);
  wait(var_1);
  setblur(0, var_2);
  level.player thread enable_tired(var_3);
}

enable_tired(var_0) {
  init_default_tired();
  self.limp_strength = 1.0;
  self.ground_ref_ent = spawn("script_model", (0, 0, 0));
  self playersetgroundreferenceent(self.ground_ref_ent);
  maps\_utility::player_speed_set(var_0, 3);
  self.player_speed = var_0;
  level.player setbobrate(2.25);
  thread tired();
}

init_default_tired() {
  level.player_tired = [];
  level.player_tired["pitch"]["min"] = -3;
  level.player_tired["pitch"]["max"] = 4;
  level.player_tired["yaw"]["min"] = -8;
  level.player_tired["yaw"]["max"] = 5;
  level.player_tired["roll"]["min"] = 3;
  level.player_tired["roll"]["max"] = 5;
}

disable_tired(var_0, var_1) {
  self notify("stop_limp");
  self notify("stop_random_blur");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(isDefined(var_0)) {
    self playersetgroundreferenceent(undefined);
    setsaveddvar("player_sprintUnlimited", "0");
    self notify("stop_limp_forgood");
    level.player maps\_utility::player_speed_percent(90, 5);
    level.player setbobrate(1.1);
    self allowstand(1);
    self allowcrouch(1);
    self allowsprint(1);
    self allowjump(1);
  } else {
    var_2 = randomfloatrange(0.65, 1.25);
    var_3 = adjust_angles_to_player((0, 0, 0));
    self.ground_ref_ent rotateto(var_3, var_2, 0, var_2 / 2);
    self.ground_ref_ent waittill("rotatedone");
  }

  setblur(0, randomfloatrange(0.5, 0.75));
}

tired(var_0) {
  self endon("stop_limp");
  self allowsprint(0);
  self allowjump(0);
  thread player_random_blur();
  thread player_hurt_sounds();

  for(;;) {
    if(self playerads() > 0.3) {
      wait 0.05;
      continue;
    }

    var_1 = self getvelocity();
    var_2 = abs(var_1[0]) + abs(var_1[1]);

    if(var_2 < 10) {
      wait 0.05;
      continue;
    }

    var_3 = var_2 / self.player_speed;
    var_4 = randomfloatrange(level.player_tired["pitch"]["min"], level.player_tired["pitch"]["max"]);

    if(randomint(100) < 20) {
      var_4 = var_4 * 1.5;
    }

    var_5 = randomfloatrange(level.player_tired["roll"]["min"], level.player_tired["roll"]["max"]);
    var_6 = randomfloatrange(level.player_tired["yaw"]["min"], level.player_tired["yaw"]["max"]);
    var_7 = (var_4, var_6, var_5);
    var_7 = var_7 * var_3;
    var_7 = var_7 * self.limp_strength;
    var_8 = randomfloatrange(0.15, 0.45);
    var_9 = randomfloatrange(0.65, 1.25);
    thread stumble(var_7, var_8, var_9);
    wait(var_8);
    self waittill("recovered");
  }
}

stumble(var_0, var_1, var_2, var_3) {
  self endon("stop_stumble");
  self endon("stop_limp");
  var_0 = adjust_angles_to_player(var_0);
  self notify("stumble");
  self.ground_ref_ent rotateto(var_0, var_1, var_1 / 4 * 3, var_1 / 4);
  self.ground_ref_ent waittill("rotatedone");
  var_4 = (randomfloat(4) - 4, randomfloat(5), 0);
  var_4 = adjust_angles_to_player(var_4);
  self.ground_ref_ent rotateto(var_4, var_2, 0, var_2 / 2);
  self.ground_ref_ent waittill("rotatedone");

  if(!isDefined(var_3)) {
    self notify("recovered");
  }
}

player_random_blur() {
  self endon("dying");
  self endon("stop_random_blur");

  for(;;) {
    wait 0.05;

    if(randomint(100) > 10) {
      continue;
    }
    var_0 = randomint(3) + 4;
    var_1 = randomfloatrange(0.1, 0.3);
    var_2 = randomfloatrange(0.3, 1);
    setblur(var_0 * 1.2, var_1);
    wait(var_1);
    setblur(0, var_2);
    wait(var_2);
    wait(randomfloatrange(0, 1.5));
    common_scripts\utility::waittill_notify_or_timeout("blur", 5);
  }
}

player_hurt_sounds() {
  self endon("stop_limp");

  for(;;) {
    if(player_playing_hurt_sounds()) {
      wait 0.05;
      continue;
    }

    self notify("blur");
    common_scripts\utility::play_sound_in_space("breathing_limp_start");
    common_scripts\utility::play_sound_in_space("breathing_limp_better");
    wait(randomfloatrange(0, 1));
    self waittill("stumble");
  }
}

player_playing_hurt_sounds() {
  if(level.player.health < 50) {
    return 1;
  } else {
    return 0;
  }
}

adjust_angles_to_player(var_0) {
  var_1 = var_0[0];
  var_2 = var_0[2];
  var_3 = anglestoright(self.angles);
  var_4 = anglesToForward(self.angles);
  var_5 = (var_3[0], 0, var_3[1] * -1);
  var_6 = (var_4[0], 0, var_4[1] * -1);
  var_7 = var_5 * var_1;
  var_7 = var_7 + var_6 * var_2;
  return var_7 + (0, var_0[1], 0);
}

assign_archetypes() {
  foreach(var_1 in level.alpha) {
    var_1.animarchetype = "jungle_soldier";
  }
}

setup_jungle_enemies() {
  setsaveddvar("laserradius", 0.4);
  maps\_utility::array_spawn_function_targetname("jungle_patroller", ::jungle_enemy_logic, "zero", 1);
  maps\_utility::array_spawn_function_targetname("lookout_guys", ::lookout_guys_logic);
  maps\_utility::array_spawn_function_targetname("right_meeting_guys", ::right_meeting_guys_logic);
  maps\_utility::array_spawn_function_targetname("left_meeting_guys", ::left_meeting_guys_logic);
  level.jungle_enemies = maps\_utility::array_spawn_targetname("jungle_patroller", 1);
  var_0 = maps\_utility::array_spawn_targetname("lookout_guys", 1);
  waittillframeend;
  level.jungle_enemies = common_scripts\utility::array_combine(level.jungle_enemies, var_0);
  level.right_meeting_guys = maps\_utility::array_spawn_targetname("right_meeting_guys", 1);
  level.left_meeting_guys = maps\_utility::array_spawn_targetname("left_meeting_guys", 1);
  level.meeting_guys = common_scripts\utility::array_combine(level.right_meeting_guys, level.left_meeting_guys);
  waittillframeend;
  level.jungle_enemies = common_scripts\utility::array_combine(level.jungle_enemies, level.meeting_guys);
  level thread meeting_guys_vo(level.left_meeting_guys);
  level thread meeting_guys_vo(level.right_meeting_guys);
  thread setup_hill_enemies();
}

jungle_stealth_settings() {
  var_0 = [];
  var_0["prone"] = 100;
  var_0["crouch"] = 400;
  var_0["stand"] = 600;
  var_1 = [];
  var_1["prone"] = 500;
  var_1["crouch"] = 1500;
  var_1["stand"] = 2000;
  maps\_stealth_utility::stealth_detect_ranges_set(var_0, var_1);
  var_2 = [];
  var_2["player_dist"] = 600;
  var_2["sight_dist"] = 200;
  var_2["detect_dist"] = 100;
  var_2["found_dist"] = 50;
  var_2["found_dog_dist"] = 50;
  maps\_stealth_utility::stealth_corpse_ranges_custom(var_2);
}

player_spotted_count() {
  maps\_utility::ent_flag_wait("_stealth_behavior_first_reaction");

  if(level.laser_count < 5) {
    self laserforceon();
    level.laser_count++;
  }

  thread delay_notify_alive();

  if(!maps\_utility::is_in_array(level.stealth_player_aware_enemies, self)) {
    level.stealth_player_aware_enemies = common_scripts\utility::add_to_array(level.stealth_player_aware_enemies, self);
  }

  self waittill("death");
  level.laser_count--;
  level.stealth_player_aware_enemies = common_scripts\utility::array_remove(level.stealth_player_aware_enemies, self);
}

delay_notify_alive() {
  self endon("death");

  if(maps\jungle_ghosts_util::isdefined_and_alive(self)) {
    level notify("enemy_stealth_reaction");
  }
}

player_spotted_logic() {
  level endon("waterfall_approach");

  for(;;) {
    level.player setmovespeedscale(0.75);
    common_scripts\utility::flag_wait("_stealth_spotted");
    level.player setmovespeedscale(0.9);
    setsaveddvar("player_sprintSpeedScale", 1.4);
    common_scripts\utility::flag_waitopen("_stealth_spotted");

    if(common_scripts\utility::flag("waterfall_approach")) {
      thread maps\jungle_ghosts_util::stop_music_jg(1);
    }
  }
}

alert_on_chopper_damage() {
  self endon("death");
  self waittill("damage");
  var_0 = common_scripts\utility::get_array_of_closest(self.origin, getaiarray("axis"));

  for(var_1 = 0; var_1 < 3 || var_1 < var_0.size; var_1++) {
    if(maps\jungle_ghosts_util::isdefined_and_alive(var_0[var_1])) {
      var_0[var_1] thread maps\jungle_ghosts_util::manually_alert_me();
      wait(randomfloatrange(0.5, 1));
    }
  }
}

jungle_enemy_logic(var_0, var_1) {
  maps\jungle_ghosts_util::enemy_weapons_force_use_silencer();
  self endon("death");

  if(!common_scripts\utility::flag("second_distant_sat_launch")) {
    maps\_utility::set_moveplaybackrate(0.7);
  } else {
    maps\_utility::set_moveplaybackrate(1);
  }

  if(isDefined(self.target)) {
    thread maps\_patrol::patrol();
  }

  thread set_nearest_stealth_group();
  maps\_utility::disable_long_death();
  self.diequietly = 1;
  self.no_pain_sound = 1;
  self.skipbloodpool = 1;
  thread player_spotted_count();
  thread jungle_enemy_sfx();
  maps\_utility::set_ai_bcvoice("shadowcompany");
  thread maps\_utility::set_battlechatter(0);
  maps\_utility::ent_flag_init("stealth_kill");

  if(!common_scripts\utility::flag("second_distant_sat_launch")) {
    thread maps\_patrol_anims_creepwalk::enable_creepwalk();
  }

  if(isDefined(var_0)) {
    if(var_0 == "zero") {
      self.grenadeammo = 0;
    } else {
      self.grenadeammo = var_0;
    }
  }

  if(isDefined(var_1)) {
    self.stealth_blockers = 0;
    self._stealth.logic.alert_level.min_bulletwhizby_altert_dist = 500;
  }
}

jungle_enemy_sfx() {
  self endon("death");
  var_0 = 1000000;

  while(!isDefined(level.meeting_guys)) {
    wait 0.1;
  }

  if(maps\_utility::is_in_array(level.meeting_guys, self)) {
    return;
  }
  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "tall_grass_patroller" || self.script_noteworthy == "no_chatter") {
      return;
    }
  }

  var_1 = ["jungleg_safr_salvageteametato", "jungleg_safr_lookslikeuhhzerosurvivors", "jungleg_safr_maintainsweepchutes", "jungleg_safr_standbyforrules", "jungleg_safr_team2reportingzero", "jungleg_safr_team3hasrecovered", "jungleg_safr_primarytargetrecoveredall"];
  var_1 = common_scripts\utility::array_randomize(var_1);
  var_2 = 0;

  for(;;) {
    var_3 = distancesquared(self.origin, level.player.origin);

    if(var_3 <= var_0) {
      if(maps\jungle_ghosts_util::is_moving()) {
        play_foilage_sound_custom();
      }

      var_4 = var_1[var_2];
      maps\_utility::play_sound_on_tag(var_4, undefined, 1);
      var_2++;

      if(var_2 > var_1.size - 1) {
        var_2 = 0;
      }

      wait(randomintrange(5, 8));
    }

    wait 2;
  }
}

play_foilage_sound_custom() {
  thread maps\_utility::play_sound_on_tag("scn_tree_snap", undefined, 1);
  wait 0.1;
  thread maps\_utility::play_sound_on_tag("scn_bush_movement", undefined, 1);
  wait 0.25;
  thread maps\_utility::play_sound_on_tag("scn_tree_snap", undefined, 1);
}

lookout_guys_logic() {
  maps\jungle_ghosts_util::enemy_weapons_force_use_silencer();
  thread jungle_enemy_logic("zero", 1);
  maps\_utility::trigger_wait_targetname("jungle_entrance");
  thread lookout_animation();
}

right_meeting_guys_logic() {
  maps\jungle_ghosts_util::enemy_weapons_force_use_silencer();
  thread jungle_enemy_logic("zero", 1);
  var_0 = common_scripts\utility::getstruct("right_meeting", "targetname");
  thread meeting_animation(var_0, "meeting_trig");
}

left_meeting_guys_logic() {
  maps\jungle_ghosts_util::enemy_weapons_force_use_silencer();
  thread jungle_enemy_logic("zero", 1);
  var_0 = common_scripts\utility::getstruct("left_meeting", "targetname");
  thread meeting_animation(var_0, undefined);
}

meeting_animation(var_0, var_1) {
  self endon("death");
  var_2 = undefined;

  switch (self.script_noteworthy) {
    case "guy1":
      var_2 = "meeting_idle1";
      break;
    case "guy2":
      var_2 = "meeting_idle2";
      break;
    case "guy3":
      var_2 = "meeting_idle3";
      break;
  }

  var_0 thread maps\jungle_ghosts_util::stealth_ai_idle(self, var_2, undefined, undefined);

  if(isDefined(var_1)) {
    thread stealth_anim_interupt_detection("meeting");
    self endon("abort_meeting");
    maps\_utility::trigger_wait_targetname(var_1);
    self notify("stop_meeting_vo");
    var_0 notify("stop_loop");
    self.animname = self.script_noteworthy;
    var_0 maps\_anim::anim_single_solo(self, "meeting");
    self notify("meeting");
    self.animname = self.og_animname;
    thread maps\_patrol::patrol();
  } else {
    thread stealth_anim_interupt_detection("death");
    var_3 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");
    common_scripts\utility::flag_wait(var_3);
    wait(randomintrange(1, 3));
    maps\jungle_ghosts_util::manually_alert_me();
    self.goalradius = 250;
    self setgoalentity(level.player);
  }
}

meeting_guys_vo(var_0) {
  level endon("_stealth_spotted");
  var_1 = ["jungleg_saf1_hqisreportingsurvivors", "jungleg_saf2_howmany", "jungleg_saf1_twosofartheyre", "jungleg_saf2_vasquezsaidhesaw", "jungleg_saf1_conflictingreportsfromthe"];
  var_2 = ["jungleg_saf3_team2iscoverng", "jungleg_saf4_idontunderstandwho", "jungleg_saf3_itswhowasnton", "jungleg_saf4_copythattheyrealready", "jungleg_saf3_weregoingtobe"];
  var_3 = ["jungleg_saf1_noimsayinghe", "jungleg_saf4_howdoyoueven", "jungleg_saf1_itdoesntmatterwhat", "jungleg_saf4_weregonnaneedmore", "jungleg_saf2_lesscomplainingmore", "jungleg_saf4_myteamsonit"];
  var_4 = [var_1, var_2, var_3];

  foreach(var_6 in var_0) {
    var_6 endon("stop_meeting_vo");
  }

  for(;;) {
    foreach(var_13, var_9 in var_4) {
      foreach(var_11 in var_9) {
        var_6 = common_scripts\utility::random(var_0);

        if(!maps\jungle_ghosts_util::isdefined_and_alive(var_6)) {
          return;
        } else {
          var_6 maps\_utility::play_sound_on_tag(var_11, undefined, 1);
        }
      }
    }

    wait 5;
  }
}

lookout_animation() {
  if(!isDefined(self)) {
    return;
  }
  self.og_animname = self.animname;
  self.animname = self.script_noteworthy;
  thread stealth_anim_interupt_detection("helpup_lookout");
  var_0 = common_scripts\utility::getstruct("lookout_scene", "targetname");
  var_0 thread maps\_anim::anim_single_solo(self, "helpup_lookout");
  wait 0.05;
  self setanimtime(maps\_utility::getanim("helpup_lookout"), 0.7);
  self.animname = self.og_animname;
  maps\_utility::notify_delay("helpup_lookout", 5);
  self.patrol_walk_anim = "active_patrolwalk_gundown";
  thread maps\_patrol::patrol();
}

stealth_anim_interupt_detection(var_0) {
  self endon(var_0);
  thread maps\_stealth_utility::stealth_enemy_endon_alert();
  common_scripts\utility::waittill_any("enemy_stealth_reaction", "damage", "stealth_enemy_endon_alert", "enemy_awareness_reaction", "bulletwhizby");
  self stopanimscripted();
  var_1 = get_my_meeting_group();

  if(isDefined(var_1)) {
    var_1 = maps\_utility::array_removedead_or_dying(var_1);
    maps\_utility::array_notify(var_1, "abort_meeting");
  }
}

get_my_meeting_group() {
  if(maps\_utility::is_in_array(level.left_meeting_guys, self)) {
    return level.left_meeting_guys;
  } else if(maps\_utility::is_in_array(level.right_meeting_guys, self)) {
    return level.right_meeting_guys;
  } else {
    return undefined;
  }
}

hill_enemy_stealth_logic() {
  maps\jungle_ghosts_util::enemy_weapons_force_use_silencer();
  self endon("death");
  maps\_utility::disable_long_death();
  thread player_spotted_count();
  thread set_nearest_stealth_group();
  maps\_stealth_utility::stealth_pre_spotted_function_custom(::jungle_prespotted_func);
  maps\_utility::set_ai_bcvoice("shadowcompany");
  thread maps\_utility::set_battlechatter(0);
  thread maps\_patrol_anims_creepwalk::enable_creepwalk();
  maps\_utility::forceuseweapon("sc2010+silencer_sp", "primary");
  self.grenadeammo = 0;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "cliff_looker") {
    thread cliff_guy_logic();
    return;
  }

  level endon("_stealth_spotted");
  self laserforceon();
}

set_nearest_stealth_group() {
  self endon("death");

  if(common_scripts\utility::flag("second_distant_sat_launch")) {
    return;
  }
  self.og_script_stealthgroup = self.script_stealthgroup;

  for(;;) {
    var_0[0] = self;
    var_1 = maps\_utility::get_closest_ai(self.origin, "axis", var_0);

    if(isDefined(var_1)) {
      if(distance(var_1.origin, self.origin) < 600) {
        if(isDefined(var_1.script_stealthgroup) && var_1.script_stealthgroup != self.script_stealthgroup) {
          self.script_stealthgroup = var_1.script_stealthgroup;
        }
      } else if(self.script_stealthgroup != self.og_script_stealthgroup)
        self.script_stealthgroup = self.og_script_stealthgroup;
    }

    wait 1;
  }
}

cliff_guy_logic() {
  self endon("death");
  self.animname = "generic";
  var_0 = common_scripts\utility::getstruct(self.target, "targetname");
  self forceteleport(var_0.origin, var_0.angles);
  var_0 maps\_stealth_utility::stealth_ai_idle_and_react(self, "cliff_look", "cliff_look_react");
}

hill_enemy_on_spotted() {
  self endon("death");
  common_scripts\utility::flag_wait("_stealth_spotted");
  maps\_utility::disable_cqbwalk();
  self stopanimscripted();
  maps\_utility::set_moveplaybackrate(1);
}

jungle_prespotted_func() {
  wait(level.stealth_spotted_time);
}

stealth_hard_reset() {
  self.ignoreme = 1;
  self.ignoreall = 1;
  maps\_stealth_utility::disable_stealth_for_ai();
  wait 1;
  maps\_stealth_utility::enable_stealth_for_ai();
  self.ignoreme = 0;
  self.ignoreall = 0;
}

knife_victim_death_func() {
  self startragdoll();
}

jungle_friendly_logic() {
  self.disableplayeradsloscheck = 1;
  maps\_utility::ent_flag_init("stealth_kill");
  maps\_utility::ent_flag_init("override_follow_logic");
  self.grenadeammo = 0;
  thread maps\_utility::magic_bullet_shield(1);
  thread maps\_stealth_utility::stealth_default();
  thread maps\jungle_ghosts_util::friendly_jungle_stealth_color_behavior();
  self.maxsightdistsqrd = 810000;
  maps\_utility::set_ai_bcvoice("taskforce");
  self.npcid = 0;
  maps\_utility::disable_surprise();
  maps\_utility::set_force_color("r");
}

setup_hill_enemies() {
  maps\_utility::array_spawn_function_targetname("hill_patrollers", ::hill_enemy_stealth_logic);
  maps\_utility::array_spawn_function_targetname("hill_patrollers", ::hill_enemy_on_spotted);
  maps\_utility::array_spawn_function_targetname("plane_meeting_guys", ::plane_meeting_guys_logic);
  thread hill_chopper();
  common_scripts\utility::flag_wait("hill_pos_1");

  if(!common_scripts\utility::flag("_stealth_spotted")) {
    maps\_utility::autosave_stealth();
  }

  if(common_scripts\utility::flag("_stealth_spotted")) {
    level.hill_patrollers = maps\_utility::array_spawn_targetname("hill_patrollers", 1);
    level thread handle_enemies_behind_player();
  } else {
    level.hill_patrollers = maps\_utility::array_spawn_targetname("hill_patrollers", 1);
    var_0 = maps\_utility::array_spawn_targetname("plane_meeting_guys", 1);
    level.hill_patrollers = common_scripts\utility::array_combine(var_0, level.hill_patrollers);
    level thread handle_enemies_behind_player();
  }

  common_scripts\utility::flag_wait("hill_pos_4");
  wait 2;

  while(level.hill_patrollers.size != 0) {
    level.hill_patrollers = maps\_utility::array_removedead(level.hill_patrollers);
    wait 2;
  }

  common_scripts\utility::flag_set("hill_clear");
}

heli_guys_logic() {
  self.ignoreme = 1;
  self.ignoreall = 1;
}

plane_meeting_guys_logic() {
  thread jungle_enemy_logic("zero", 1);
  var_0 = common_scripts\utility::getstruct("plane_meeting", "targetname");
  thread meeting_animation(var_0);
}

spawn_hill_enemies_hot() {
  var_0 = getent("hill_main_volume", "targetname");
  var_1 = getent("hill_main_volume", "targetname");
  level.hill_patrollers = common_scripts\utility::array_removeundefined(level.hill_patrollers);
  var_2 = getEntArray("hill_hot_enemies", "targetname");
  var_3 = maps\jungle_ghosts_util::enemy_weapons_force_use_silencer;
  maps\_utility::array_spawn_function_targetname("hill_hot_enemies", var_3);
  level.hill_holders = [];
  level.hill_squad = [];
  level.hill_squad = maps\jungle_ghosts_util::create_a_squad_from_spawner(var_2[0], level.hill_squad, 5);
  level thread maps\jungle_ghosts_util::squad_manager(level.hill_squad);
  wait 5;
  level.hill_holders = maps\jungle_ghosts_util::spawn_ai_from_spawner_send_to_volume(var_2[1], 5, var_1);
  level.hill_patrollers = common_scripts\utility::array_combine(level.hill_holders, level.hill_squad);
}

handle_enemies_behind_player() {
  level endon("waterfall_approach");
  common_scripts\utility::flag_wait("hill_pos_1");

  if(common_scripts\utility::flag("_stealth_spotted")) {
    return;
  }
  common_scripts\utility::flag_wait("_stealth_spotted");
  var_0 = undefined;

  if(isDefined(level.jungle_enemies)) {
    if(common_scripts\utility::flag("hill_pos_4")) {
      common_scripts\utility::array_thread(level.jungle_enemies, maps\jungle_ghosts_util::delete_if_player_cant_see_me);
    } else {
      level.jungle_enemies = maps\_utility::array_removedead_or_dying(level.jungle_enemies);

      if(level.jungle_enemies.size > 2) {
        var_0 = common_scripts\utility::get_array_of_closest(level.player.origin, level.jungle_enemies);

        for(var_1 = 2; var_1 < var_0.size; var_1++) {
          var_0[var_1] maps\jungle_ghosts_util::delete_if_player_cant_see_me();
        }

        var_0 = common_scripts\utility::array_removeundefined(var_0);
      } else if(level.jungle_enemies.size != 0)
        var_0 = level.jungle_enemies;

      if(isDefined(var_0)) {
        foreach(var_3 in var_0) {
          var_3 maps\_utility::enable_sprint();
          var_4 = level.player;
          var_3 setgoalentity(var_4);
          var_3 thread set_flag_when_close(var_4);
        }
      }
    }
  }
}

hill_chopper() {
  maps\_utility::array_spawn_function_targetname("heli_guys", ::heli_guys_logic);
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname("hill_heli");
  var_0 vehicle_turnengineoff();
  var_0 endon("death");
  var_0 thread alert_on_chopper_damage();
  common_scripts\utility::flag_wait("hill_pos_1");
  level.player setclienttriggeraudiozonepartial("jungle_ghosts_intro_no_vehicle_npc", "mix");
  var_0 vehicle_turnengineon();
  thread hill_heli_fade_in_sounds();
  common_scripts\utility::flag_wait_any("crash_arrive", "_stealth_spotted");
  var_0 maps\_vehicle::gopath();
  wait 10;
  var_0 vehicle_setspeedimmediate(40, 10);
}

hill_heli_fade_in_sounds() {
  level.player clearclienttriggeraudiozone(3.0);
}

hill_reenforcements() {
  level.spawned_reenforcements = 0;
  common_scripts\utility::flag_wait("hill_pos_4");
  send_hill_reenforcements_if_hot();
  common_scripts\utility::flag_wait("hill_pos_5");

  if(level.spawned_reenforcements == 0) {
    send_hill_reenforcements_if_hot();
  }
}

send_hill_reenforcements_if_hot() {
  level endon("waterfall_approach");

  if(common_scripts\utility::flag("_stealth_spotted")) {
    level.spawned_reenforcements = 1;
    var_0 = getent("hilltop_volume_1", "targetname");
    var_1 = getent("hill_backup_left", "targetname");
    var_2 = maps\jungle_ghosts_util::spawn_ai_from_spawner_send_to_volume(var_1, 4, var_0);
    level.hill_patrollers = common_scripts\utility::array_combine(level.hill_patrollers, var_2);
    common_scripts\utility::flag_set("player_agro_near_execution");
  }
}

set_flag_when_close(var_0) {
  self endon("death");
  level endon("hill_flanked");

  for(;;) {
    var_1 = distancesquared(self.origin, var_0.origin);

    if(var_1 <= 202500) {
      common_scripts\utility::flag_set("hill_flanked");
      iprintlnbold("enemies flanking!");
      return;
    }

    wait 0.5;
  }
}

setup_friendlies() {
  thread battlechatter_setup();
  thread jungle_vo();
  common_scripts\utility::flag_wait("waterfall_approach");
  maps\_utility::array_spawn_function_targetname("alpha_team", ::jungle_friendly_logic);
  level.alpha = maps\_utility::array_spawn_targetname("alpha_team", 1);

  foreach(var_1 in level.alpha) {
    if(var_1.script_friendname == "Elias") {
      level.alpha1 = var_1;
      level.alpha1.animname = "alpha1";
      level.alpha1 maps\_utility::forceuseweapon("honeybadger", "primary");
      level.alpha1.name = "Elias";
      continue;
    }

    level.alpha2 = var_1;
    level.alpha2.animname = "alpha2";
    level.alpha2 maps\_utility::forceuseweapon("honeybadger", "primary");
  }

  level.alpha1.animname = "alpha1";
  common_scripts\utility::flag_set("friendlies_ready");
  assign_archetypes();
  level thread friendly_navigation();
  thread delete_bloomdome();
  thread waterfall_execution();
  level.player thread maps\jungle_ghosts_util::stream_waterfx("stop_water_footsteps", "step_run_plr_water");
  thread maps\jungle_ghosts_util::stop_music_jg(1);
}

battlechatter_setup() {
  common_scripts\utility::waitframe();
  var_0 = getaiarray();

  foreach(var_2 in var_0) {
    var_2 thread maps\_utility::set_battlechatter(0);
  }
}

friendly_navigation() {
  common_scripts\utility::flag_wait("friendlies_ready");

  foreach(var_1 in level.alpha) {
    var_1 maps\_utility::set_moveplaybackrate(1);
    var_1.ignoreall = 1;
  }
}

bravo_friendly_logic() {
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.goalradius = 32;
  self.disableplayeradsloscheck = 1;
  thread maps\_utility::magic_bullet_shield(1);
  maps\_utility::set_ai_bcvoice("taskforce");
  thread maps\_stealth_utility::stealth_default();
  thread maps\jungle_ghosts_util::friendly_jungle_stealth_color_behavior();

  if(self.script_friendname == "Merrick") {
    level.merrick = self;
  } else {
    level.hesh = self;
  }
}

delete_bloomdome() {
  var_0 = getEntArray("bloomdome", "targetname");

  foreach(var_2 in var_0) {
    var_2 delete();
  }
}

close_to_waterfall_enemy_logic() {
  thread final_jungle_ai_cleanup();
  level endon("waterfall_trig");
  level endon("hostage_flag_set");
  common_scripts\utility::flag_wait("waterfall_approach");
  var_0 = getent("hilltop_volume_1", "targetname");

  for(;;) {
    var_1 = getaiarray("axis");

    foreach(var_3 in var_1) {
      if(maps\jungle_ghosts_util::isdefined_and_alive(var_3)) {
        if(common_scripts\utility::flag("_stealth_spotted")) {
          if(level.player.origin[1] > 850 && var_3.origin[1] > -350) {
            var_3 setgoalpos(var_3.origin);
            var_3 setgoalvolumeauto(var_0);
            var_3 maps\_stealth_utility::disable_stealth_for_ai();
            continue;
          }

          var_3 setgoalentity(level.player);
        }
      }
    }

    wait 1;
  }
}

final_jungle_ai_cleanup() {
  level common_scripts\utility::waittill_any("waterfall_trig", "hostage_flag_set");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy)) {
      if(var_2.script_noteworthy != "guard1" && var_2.script_noteworthy != "guard2" && var_2.script_noteworthy != "execution_guards") {
        var_2 delete();
      }

      continue;
    }

    var_2 delete();
  }
}

waterfall_execution() {
  common_scripts\utility::trigger_off("mid_stream", "targetname");
  common_scripts\utility::trigger_off("waterfall_to_stream", "targetname");
  level thread maps\jungle_ghosts_stream::friendly_stream_navigation();
  slomo_sound_scale_setup();
  maps\_utility::array_spawn_function_targetname("bravo_team", ::bravo_friendly_logic);
  var_0 = maps\_utility::spawn_targetname("guard_a_1", 1);
  var_0.ignoreme = 1;
  var_1 = maps\_utility::spawn_targetname("guard_a_2", 1);
  var_1.ignoreme = 1;
  var_2 = maps\_utility::spawn_targetname("guard_b_1", 1);
  var_2.ignoreme = 1;
  var_3 = maps\_utility::spawn_targetname("guard_b_2", 1);
  var_3.ignoreme = 1;
  level.bravo = maps\_utility::array_spawn_targetname("bravo_team", 1);
  maps\_utility::friendlyfire_warnings_off();
  var_4 = level.bravo[0];
  var_4.deathfunc = ::knife_victim_death_func;
  var_5 = level.bravo[1];
  var_5.deathfunc = ::knife_victim_death_func;
  var_4.animname = "hostage_a";
  var_5.animname = "hostage_b";
  var_0.animname = "guard_a_1";
  var_1.animname = "guard_a_2";
  var_2.animname = "guard_b_1";
  var_3.animname = "guard_b_2";
  var_0.skipbloodpool = 1;
  var_1.skipbloodpool = 1;
  var_2.skipbloodpool = 1;
  var_3.skipbloodpool = 1;
  var_6 = spawnStruct();
  var_6.guard_a_1 = var_0;
  var_6.guard_a_2 = var_1;
  var_6.guard_b_1 = var_2;
  var_6.guard_b_2 = var_3;
  var_6.hostage_a = var_4;
  var_6.hostage_b = var_5;
  var_6.guard_a_2 thread check_guard_death_to_stop_pistol_fire();
  var_6.guard_a_2.allowdeath = 1;
  var_6.guard_b_2.allowdeath = 1;
  var_4 maps\_utility::gun_remove();
  var_6.outcome_decided = 0;
  var_6.a_guys = [var_0, var_1, var_4];
  var_6.b_guys = [var_2, var_3, var_5];
  var_6.a_bad_guys = [var_0, var_1];
  var_6.b_bad_guys = [var_2, var_3];
  common_scripts\utility::array_thread(var_6.a_bad_guys, ::check_hostage_flag_a);
  common_scripts\utility::array_thread(var_6.b_bad_guys, ::check_hostage_flag_b);
  var_6.anim_ent_a = common_scripts\utility::get_target_ent("hostage_a_anim_ent");
  var_6.anim_ent_b = common_scripts\utility::get_target_ent("hostage_b_anim_ent");
  var_6.anim_ent_c = common_scripts\utility::get_target_ent("elias_walkin");
  common_scripts\utility::array_thread(var_6.a_guys, maps\_utility::disable_long_death);
  var_7 = getent("waterfall_spotted", "targetname");
  var_6 thread monitor_player_close(var_7);
  var_6.anim_ent_a thread maps\_anim::anim_loop(var_6.a_guys, "rescue_a_idle", "stop_loop");
  var_6.anim_ent_b thread maps\_anim::anim_loop(var_6.b_guys, "rescue_b_idle", "stop_loop");
  var_6 thread scene_vo();
  common_scripts\utility::flag_wait_any("waterfall_trig", "hostage_flag_set");
  common_scripts\utility::flag_set("player_at_execution");
  thread hostage_timer();
  common_scripts\utility::flag_wait_any("took_long_enough_to_rescue", "hostage_a_group_shot", "hostage_b_group_shot", "got_close_enough_to_rescue");
  level thread set_friendlies_to_not_shoot_at_hostages_mid_anim();
  var_6 thread friendlies_execute_enemies(var_6.anim_ent_a);
  var_6.a_bad_guys = maps\_utility::array_removedead(var_6.a_bad_guys);
  var_6.b_bad_guys = maps\_utility::array_removedead(var_6.b_bad_guys);
  common_scripts\utility::array_thread(var_6.a_bad_guys, ::auto_kill_enemies);
  common_scripts\utility::array_thread(var_6.b_bad_guys, ::auto_kill_enemies);
  var_6.anim_ent_a maps\_utility::anim_stopanimscripted();
  var_6.anim_ent_b maps\_utility::anim_stopanimscripted();
  var_6.a_guys = maps\_utility::array_removedead(var_6.a_guys);
  var_6.b_guys = maps\_utility::array_removedead(var_6.b_guys);

  if(common_scripts\utility::flag("hostage_a_group_shot")) {
    var_6.anim_ent_a thread maps\_anim::anim_single(var_6.a_guys, "rescue_a_shot");
    var_6.anim_ent_b maps\_anim::anim_single(var_6.b_guys, "rescue_b");
  } else if(common_scripts\utility::flag("hostage_b_group_shot")) {
    var_6.anim_ent_a thread maps\_anim::anim_single(var_6.a_guys, "rescue_a");
    var_6.anim_ent_b maps\_anim::anim_single(var_6.b_guys, "rescue_b_shot");
  } else {
    var_6.anim_ent_b thread maps\_anim::anim_single(var_6.b_guys, "rescue_b");
    var_6.anim_ent_a maps\_anim::anim_single(var_6.a_guys, "rescue_a");
  }

  common_scripts\utility::flag_set("player_rescued_hostage");
  wait 4;
  var_6.anim_ent_c maps\_anim::anim_reach_solo(level.alpha1, "elias_rescue");
  common_scripts\utility::flag_set("starting_elias_rescue");
  var_6.anim_ent_c thread maps\_anim::anim_single_solo(level.alpha1, "elias_rescue");
  maps\_utility::delaythread(5.3, maps\jungle_ghosts_anim::set_missile_reply);
  maps\_utility::delaythread(3.3, maps\jungle_ghosts_anim::set_missile_reaction);
  common_scripts\utility::flag_wait("second_distant_sat_launch");
  var_8 = common_scripts\utility::get_target_ent("river_blocker");
  var_8 connectpaths();
  var_8 delete();
  common_scripts\utility::trigger_on("mid_stream", "targetname");
  common_scripts\utility::trigger_on("waterfall_to_stream", "targetname");
  common_scripts\utility::flag_wait("obj_get_to_river");
  wait 1;
  thread maps\jungle_ghosts_util::music_stealth_tension_loop();
}

check_guard_death_to_stop_pistol_fire() {
  level.fire_notetracks = 0;
  level.execution_guy_dead = 0;
  self waittill("death");
  level.execution_guy_dead = 1;
}

auto_kill_enemies() {
  self endon("death");
  wait 8;
  self kill();
}

hostage_timer() {
  wait 9;
  common_scripts\utility::flag_set("took_long_enough_to_rescue");
}

check_hostage_flag_a() {
  level endon("hostage_flag_set");
  thread check_whizby();
  self waittill("damage");
  common_scripts\utility::flag_set("hostage_a_group_shot");
  common_scripts\utility::flag_set("hostage_flag_set");
}

check_hostage_flag_b() {
  level endon("hostage_flag_set");
  thread check_whizby();
  self waittill("damage");
  common_scripts\utility::flag_set("hostage_b_group_shot");
  common_scripts\utility::flag_set("hostage_flag_set");
}

check_whizby() {
  level endon("hostage_flag_set");
  self waittill("bulletwhizby");
  common_scripts\utility::flag_set("got_close_enough_to_rescue");
  common_scripts\utility::flag_set("hostage_flag_set");
}

scene_vo() {
  self.guard_a_1 endon("death");
  level endon("got_close_enough_to_rescue");
  level endon("took_long_enough_to_rescue");
  level endon("hostage_a_group_shot");
  level endon("hostage_b_group_shot");
  common_scripts\utility::flag_wait("squad_to_waterfall");
  wait 2;
  self.guard_a_1 maps\_utility::smart_dialogue("jungleg_saf1_wherestherestof");
  wait 1;
  self.guard_a_1 maps\_utility::smart_dialogue("jungleg_saf1_howmanymenwere");
  wait 2;
  self.guard_a_1 maps\_utility::play_sound_on_tag("jungleg_saf1_yourfriendisgoing", undefined, 1);
}

friendlies_execute_enemies(var_0) {
  if(!self.outcome_decided) {
    self.outcome_decided = 1;
    thread execution_slowmo(var_0);
    wait 0.4;

    if(isalive(self.guard_a_1)) {
      magicbullet(level.alpha[0].weapon, level.alpha[0] gettagorigin("tag_flash"), self.guard_a_1 getEye());
    }

    common_scripts\utility::array_thread(level.alpha, maps\_utility::set_baseaccuracy, 1000);
    common_scripts\utility::array_thread(self.a_bad_guys, maps\_utility::set_ignoreall, 0);
    common_scripts\utility::array_thread(self.a_bad_guys, maps\_utility::set_ignoreme, 0);
    common_scripts\utility::array_thread(self.b_bad_guys, maps\_utility::set_ignoreall, 0);
    common_scripts\utility::array_thread(self.b_bad_guys, maps\_utility::set_ignoreme, 0);
    common_scripts\utility::flag_wait("player_rescued_hostage");
    wait 3;
    common_scripts\utility::array_thread(level.alpha, maps\_utility::set_baseaccuracy, 1);
    maps\_utility::activate_trigger_with_targetname("squad_covers_helpup");
    wait 3;
    level.squad = common_scripts\utility::array_combine(level.alpha, level.bravo);
    common_scripts\utility::array_thread(level.squad, maps\_utility::disable_ai_color);
  }
}

monitor_player_close(var_0) {
  var_0 waittill("trigger");
  self notify("player_interupted");
  common_scripts\utility::flag_set("got_close_enough_to_rescue");
}

execution_slowmo(var_0) {
  if(distance(level.player.origin, var_0.origin) > 500 || !level.player maps\_utility::point_in_fov(var_0.origin)) {
    return;
  }
  level.player thread maps\_utility::play_sound_on_entity("weap_sniper_breathin");
  level thread player_heartbeat();
  setslowmotion(1, 0.5, 0.15);
  wait 1;
  setslowmotion(0.5, 1, 0.15);
  level notify("stop_player_heartbeat");
  level.player thread maps\_utility::play_sound_on_entity("ui_camera_whoosh_in");
}

do_birds() {
  maps\_utility::trigger_wait_targetname("jungle_entrance");
  level endon("hill_pos_6");

  for(;;) {
    do_bird_single();
    wait(randomintrange(20, 45));
  }
}

do_bird_single_enemy(var_0) {
  var_1 = vectornormalize(anglesToForward(self.angles));
  var_2 = self.origin + var_1 * randomintrange(10, 30);
  var_3 = var_2 + (0, 0, 1000);
  var_4 = randomintrange(-100, 100);
  var_5 = maps\_utility::groundpos(var_3) + (var_4, var_4, 0);
  thread common_scripts\utility::play_sound_in_space("anml_bird_startle_foliage", var_5);
  wait 0.5;
  maps\interactive_models\_birds::birds_spawnandflyaway("parakeets", var_5, (1000, 0, 1000), randomintrange(3, 8));
}

do_bird_single(var_0) {
  var_1 = vectornormalize(anglesToForward(level.player getplayerangles()));
  var_2 = level.player.origin + var_1 * 1200;
  var_3 = var_2 + (0, 0, 1000);
  var_4 = randomintrange(-300, 300);
  var_5 = maps\_utility::groundpos(var_3) + (var_4, var_4, 0);

  if(randomint(100) < 33) {
    thread common_scripts\utility::play_sound_in_space("anml_bird_startle_foliage", var_5);
    wait 0.5;
  }

  maps\interactive_models\_birds::birds_spawnandflyaway("parakeets", var_5, (500, 0, 500), randomintrange(3, 8));
}

birds_on_baddy() {
  self endon("death");

  if(isDefined(self.doing_enemy_birds)) {
    return;
  }
  self.doing_enemy_birds = 1;
  do_bird_single_enemy();
  wait 25;
  self.doing_enemy_birds = undefined;
}

motion_tracker_setup() {
  common_scripts\utility::flag_wait("jungle_entrance");
  var_0 = undefined;
  var_1 = 2;
  var_2 = var_1;
  level.motion_tracker_sweep_speed = var_1;
  level.motion_tracker_sweep_range = 1600;
  setsaveddvar("MotionTrackerRange", level.motion_tracker_sweep_range);
  setsaveddvar("MotionTrackerSweepInterval", level.motion_tracker_sweep_speed);

  for(;;) {
    var_3 = getaiarray("axis");

    if(var_3.size != 0) {
      var_3 = sortbydistance(var_3, level.player.origin);
      var_4 = distancesquared(var_3[0].origin, level.player.origin);

      if(var_4 < 160000) {
        var_0 = 0.5;
      } else if(var_4 < 360000) {
        var_0 = 1;
      } else if(var_4 < 640000) {
        var_0 = 1.5;
      } else {
        var_0 = var_1;
      }

      if(var_0 != var_2) {
        update_motion_tracker_speed(var_0);
        var_2 = var_0;
      }
    } else if(var_2 != var_1) {
      update_motion_tracker_speed(var_1);
      var_2 = var_1;
    }

    wait 1;
  }
}

update_motion_tracker_speed(var_0) {
  setsaveddvar("MotionTrackerSweepInterval", var_0);
}

jungle_vo(var_0) {
  switch (level.start_point) {
    case "jungle_corridor":
    case "jungle":
    case "parachute":
    case "default":
      common_scripts\utility::flag_wait("player_landed");
      maps\jungle_ghosts_util::waittill_x_passed(-7949);
      level.player maps\_utility::play_sound_on_entity("jungleg_els_everyonereportin");
      wait 1;
      level.player maps\_utility::play_sound_on_entity("jungleg_hsh_itsheshimwith");
      wait 0.75;
      level.player maps\_utility::play_sound_on_entity("jungleg_els_goodkeeganswithme");
      maps\jungle_ghosts_util::waittill_x_passed(-7750);
      level.player maps\_utility::play_sound_on_entity("jungleg_els_adam");
      level.player maps\_utility::play_sound_on_entity("jungleg_hsh_sawhimgetsnagged");
      maps\jungle_ghosts_util::waittill_x_passed(-7406);
      level.player maps\_utility::play_sound_on_entity("jungleg_hsh_shitgetdown");
      wait 0.5;
      level.player maps\_utility::play_sound_on_entity("jungleg_hsh_lookslikewegot");
      wait 0.7;
      level.player maps\_utility::play_sound_on_entity("jungleg_els_werecomingtoyou");
    case "e3":
      maps\jungle_ghosts_util::waittill_x_passed(-6983);
      level.player maps\_utility::play_sound_on_entity("jungleg_els_adamifyoucan");
      common_scripts\utility::flag_set("obj_regroup");
      wait 0.5;
      level.player maps\_utility::play_sound_on_entity("jungleg_els_staylowandquiet");
      wait 0.5;
      level.player maps\_utility::play_sound_on_entity("jungleg_els_youcandothis");
      common_scripts\utility::flag_wait("jungle_entrance");
      wait 1;
      level.player maps\_utility::play_sound_on_entity("jungleg_hsh_whatthehellwas");
      wait 0.5;
      level.player maps\_utility::play_sound_on_entity("jungleg_els_atremormaybe");
      wait 0.5;
      level.player maps\_utility::play_sound_on_entity("jungleg_els_butivebeenwrong");
      wait 0.25;
      level.player maps\_utility::play_sound_on_entity("jungleg_hsh_westillhavepatrols");
      common_scripts\utility::flag_wait("early_jungle_flag");
      level.player maps\_utility::play_sound_on_entity("jungleg_hsh_youllhaveagroup");
      wait 1;
      level.player maps\_utility::play_sound_on_entity("jungleg_els_copythatstaysafe");
      wait 1;
      common_scripts\utility::flag_wait("mid_jungle_flag");
      level.player maps\_utility::play_sound_on_entity("jungleg_hsh_theseguysaregetting");
      wait 0.5;
      level.player maps\_utility::play_sound_on_entity("jungleg_hsh_leftleftside");
      wait 0.25;
      level.player maps\_utility::play_sound_on_entity("jungleg_els_heshhesh");
      wait 1;
    case "jungle_hill":
      common_scripts\utility::flag_wait("crash_arrive");
      level.player maps\_utility::play_sound_on_entity("jungleg_els_theyremovingthroughthe");
      level.player maps\_utility::play_sound_on_entity("jungleg_els_stayclearofthat");
      common_scripts\utility::flag_wait_any("hill_clear", "hill_pos_6");
      level.player thread maps\_utility::play_sound_on_entity("jungleg_els_loganwecansee");
      common_scripts\utility::flag_wait("waterfall_see_friendlies");
      common_scripts\utility::flag_wait("friendlies_ready");
      maps\_utility::autosave_stealth();

      if(!level.was_spotted) {
        level.alpha2 maps\_utility::smart_dialogue("jungleg_kgn_nicework");
        wait 0.5;
        level.alpha2 maps\_utility::smart_dialogue("jungleg_kgn_kidsgoodelias");
      } else if(!common_scripts\utility::flag("player_agro_near_execution")) {
        level.alpha1 maps\_utility::smart_dialogue("jungleg_els_weheardgunfire");
        wait 0.25;
        level.alpha1 maps\_utility::smart_dialogue("jungleg_els_youok");
      } else
        level.alpha2 maps\_utility::smart_dialogue("jungleg_kgn_youtryingtoget");

      wait 0.25;
      level.alpha1 maps\_utility::smart_dialogue("jungleg_els_gotheshandmerrick");
      common_scripts\utility::flag_set("obj_save_team");
    case "waterfall":
      common_scripts\utility::flag_wait("waterfall_trig");

      if(!common_scripts\utility::flag("hostage_flag_set") && !common_scripts\utility::flag("got_close_enough_to_rescue")) {
        level thread stop_execution_dialoigue_on_shot();
        level.alpha1 maps\_utility::smart_dialogue("jungleg_els_heshweseeyou");
        wait 0.25;

        if(!common_scripts\utility::flag("hostage_flag_set") && !common_scripts\utility::flag("got_close_enough_to_rescue")) {
          level.alpha1 maps\_utility::smart_dialogue("jungleg_els_adamdoit");
        }
      }

      common_scripts\utility::flag_wait("player_rescued_hostage");
      common_scripts\utility::flag_wait("starting_elias_rescue");
      common_scripts\utility::flag_wait("second_distant_sat_launch");
      level.player playrumblelooponentity("damage_heavy");
      wait 3;
      level.player stoprumble("damage_heavy");
      common_scripts\utility::flag_wait("do_jungleg_bkr_coughingcatchingbreath");
      common_scripts\utility::flag_set("obj_get_to_river");
  }
}

set_friendlies_to_not_shoot_at_hostages_mid_anim() {
  wait 5;
  common_scripts\utility::array_thread(level.alpha, maps\jungle_ghosts_util::generic_ignore_on);
  wait 10;
  common_scripts\utility::array_thread(level.alpha, maps\jungle_ghosts_util::generic_ignore_off);
}

stop_execution_dialoigue_on_shot() {
  common_scripts\utility::flag_wait_any("took_long_enough_to_rescue", "hostage_flag_set", "got_close_enough_to_rescue");
  maps\jungle_ghosts_util::dialogue_stop();
  maps\_utility::radio_dialogue_stop();
}

do_story_line(var_0) {
  common_scripts\utility::flag_set("doing_story_vo");
  maps\_utility::radio_dialogue_stop();
  maps\_utility::smart_radio_dialogue(var_0);
  common_scripts\utility::flag_clear("doing_story_vo");
}

do_safe_radio_line(var_0) {
  if(!common_scripts\utility::flag("_stealth_spotted") && !common_scripts\utility::flag("doing_story_vo")) {
    level.vo_activity = 1;
    maps\_utility::smart_radio_dialogue(var_0);
    level.vo_activity = 0;
  }
}

slomo_sound_scale_setup() {
  soundsettimescalefactor("Music", 0);
  soundsettimescalefactor("Menu", 0);
  soundsettimescalefactor("local3", 0.0);
  soundsettimescalefactor("Mission", 0.0);
  soundsettimescalefactor("Announcer", 0.0);
  soundsettimescalefactor("Bulletimpact", 0.6);
  soundsettimescalefactor("Voice", 0.4);
  soundsettimescalefactor("effects2", 0.2);
  soundsettimescalefactor("local", 0.4);
  soundsettimescalefactor("physics", 0.2);
  soundsettimescalefactor("ambient", 0.5);
  soundsettimescalefactor("auto", 0.5);
}

player_heartbeat() {
  level endon("stop_player_heartbeat");

  for(;;) {
    level.player playlocalsound("breathing_heartbeat");
    wait 0.5;
  }
}