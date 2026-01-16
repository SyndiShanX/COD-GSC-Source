/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nml_code.gsc
*****************************************************/

opening_shot() {
  maps\_hud_util::start_overlay("overlay_static");
  level.player setclienttriggeraudiozone("nml_dog_camera", 0.1);
  level.player thread maps\_utility::play_sound_on_entity("scn_nml_camera_start_level");
  maps\nml_stealth::stealth_settings_intro();
  level.player maps\_dog_drive::dog_drive_indirect(level.dog);
  level.player notify("disable_zoom");
  thread maps\nml_util::mission_fail_on_dog_death();
  level.player notify("stop_dog_bark");
  level.dog maps\_utility::ent_flag_clear("dogcam_acquire_targets");
  level.see_enemy_dot = 0.99;
  level.see_enemy_dot_close = 0.995;
  level.dog setdogcommand("attack");
  level.player allowcrouch(0);
  level.player allowstand(0);
  level.baker allowedstances("crouch");
  level.baker.baseaccuracy = 0.01;
  level.baker.ignoreall = 1;
  level.baker.ignoreme = 1;
  var_0 = common_scripts\utility::get_target_ent("dog_intro_node");
  wait 0.1;
  maps\_utility::autosave_by_name("nml");
  level.dog endon("death");
  level.player setblurforplayer(20, 0.05);
  level.player lerpfov(15, 0.1);
  level.player lerpviewangleclamp(0.1, 0, 0, 15, 15, 15, 15);
  level.player freezecontrols(1);
  level.player maps\_dog_drive::delete_model_fx();
  wait 0.1;
  level.player maps\_dog_drive::spawn_model_fx((10, 0, 0), (150, 0, 0), (500, 0, 0));
  maps\nml_util::set_start_positions("start_intro");
  level.dog maps\_utility_dogs::enable_dog_sniff();
  level.dog maps\_utility_dogs::disable_dog_sniff();
  level.dog notify("stop_panting");
  level.dog.allowpain = 1;
  level.dog.allowdeath = 1;
  var_0 thread maps\_anim::anim_generic_loop(level.dog, "dog_sneak_idle_intro");
  level.dog.ignoreme = 0;
  thread intro_wait_spotted();
  thread intro_wait_dog_attack();
  thread intro_wait_dog_command(var_0);
  maps\nml_util::team_unset_colors(128);
  var_1 = maps\_utility::array_spawn_targetname("intro_enemy_1");
  thread maps\nml_util::group_walla(var_1, 1, 2);
  common_scripts\utility::array_thread(var_1, maps\nml_util::hazmat_if_hazmat);
  common_scripts\utility::array_thread(var_1, maps\_utility::set_baseaccuracy, 999);
  thread maps\nml_util::make_enemy_squad_burst(var_1, "cave_exit");
  level.player freezecontrols(0);
  thread intro_dialogue();
  level waittill("camera_clears");
  var_2 = anim.dogattackaidist;
  anim.dogattackaidist = anim.dogattackaidist * 2;
  thread maps\_hud_util::fade_in(1, "overlay_static");
  level.player common_scripts\utility::delaycall(0.25, ::setblurforplayer, 0, 1.5);
  earthquake(0.4, 2.3, level.player.origin, 1000);
  level.player thread maps\_dog_drive::constant_screen_glitches();
  level.player maps\_utility::notify_delay("stop_constant_glitch", 2);
  wait 2;
  level.dog maps\_utility::ent_flag_clear("pause_dog_command");
  level.player thread maps\_utility::player_speed_percent(30, 0.1);
  level.player allowcrouch(1);
  level.player allowstand(1);
  level.baker allowedstances("stand", "crouch", "prone");
  setsaveddvar("aim_autoAimRangeScale", "0");
  common_scripts\utility::flag_wait("intro_gunup");
  thread maps\nml_util::mission_fail_on_dog_death(&"NML_HINT_CAIRO_DEATH");
  level.dog_alt_melee_func = undefined;
  level.player thread maps\_utility::player_speed_percent(80, 1);
  level.player allowprone(0);
  anim.dogattackaidist = var_2;
  level.player clearclienttriggeraudiozone(0.5);
  maps\_hud_util::fade_out(0.25, "overlay_static");
  wait 0.05;
  level.player maps\_dog_drive::dog_drive_indirect_disable(level.dog);
  level.dog maps\_utility::ent_flag_set("pause_dog_command");

  if(common_scripts\utility::flag("intro_guys_close") && isDefined(level.dog.attacked)) {
    level.dog.attacked = undefined;
    thread intro_secondary_kill();
  }

  level.player disableweaponswitch();
  level.player giveweapon("remote_chopper_gunner_nopullout");
  level.player switchtoweaponimmediate("remote_chopper_gunner_nopullout");
  setdvar("hideHudFast", 1);
  setsaveddvar("ammoCounterHide", 1);
  cinematicingameloop("dog_in");
  wait 0.05;
  thread maps\_hud_util::fade_in(0.4, "overlay_static");
  common_scripts\utility::noself_delaycall(4, ::stopcinematicingame);
  level.player lerpfov(65, 1);
  level.baker thread maps\nml_util::wait_for_group_attack(var_1);
  level.baker setgoalnode(common_scripts\utility::get_target_ent("baker_intro_check"));
  wait 0.05;
  level.player switchtoweapon("honeybadger+acog_sp");
  level.player thread maps\_utility::play_sound_on_entity("scn_nml_tablet_put_away");
  maps\nml_util::volume_waittill_no_axis("intro_volume");
  var_3 = getaiarray("axis");

  foreach(var_5 in var_3)
  var_5 kill();

  maps\nml_util::team_unset_colors(128);
  level.dog.melee = undefined;
  level.dog setCanDamage(1);
  level.player allowprone(1);
  common_scripts\utility::flag_set("intro_clear");
  setsaveddvar("aim_autoAimRangeScale", "1");
  level.player takeweapon("remote_chopper_gunner_nopullout");
  level.player enableweaponswitch();
  setdvar("hideHudFast", 0);
  setsaveddvar("ammoCounterHide", 0);
  level.player maps\_ash_falling::ash_fall(1);
  wait 1;
  level.baker maps\_utility::delaythread(4, maps\nml_util::dyn_dogspeed_enable, 150);
  level.dog maps\_utility::delaythread(3, maps\_utility_dogs::dyn_sniff_enable, 500, 300);
  var_7 = common_scripts\utility::get_target_ent("NML_intro_exit");
  var_7 thread maps\_anim::anim_generic_gravity(level.baker, "NML_intro_exit");
  maps\nml_util::hero_paths("intro_path", 450);
  maps\_utility::delaythread(6.5, common_scripts\utility::flag_set, "start_earthquakes");
  common_scripts\utility::flag_wait("cave_entrance");
  level.player maps\_ash_falling::ash_fall(0.5);
  level.baker maps\_utility::enable_cqbwalk();
  maps\nml_util::hero_paths("intro_cave_path");
  level.baker thread hesh_gate_logic();
  level.baker thread maps\nml_util::dyn_dogspeed_disable();
  thread cave_earthquake();
}

cave_exit_dialogue() {
  common_scripts\utility::flag_wait("cave_hesh_done");
  wait 2;
  level.baker maps\_utility::smart_dialogue("nml_hsh_cmonletskeepmoving");
  wait 2;
  level.baker maps\_utility::smart_dialogue("nml_hsh_delta11thisis");
  wait 0.4;
  maps\_utility::smart_radio_dialogue("nml_mrk_solidcopystalkerdelta");
  common_scripts\utility::flag_clear("start_earthquakes");
  wait 0.1;
  maps\_utility::smart_radio_dialogue("nml_mrk_wererunningona");
  wait 0.4;
  level.baker maps\_utility::smart_dialogue("nml_hsh_hehrogerthat");
}

cave_exit() {
  common_scripts\utility::flag_wait("cave_exit");
  common_scripts\utility::flag_wait("hesh_ready_to_leave_cave");
  maps\nml_util::team_unset_colors(128);
  level.dog maps\_utility_dogs::disable_dog_sniff();
  level.dog thread maps\_utility_dogs::dyn_sniff_enable(400, 100);
  maps\nml_util::hero_paths("intro_house_path", 300, 300, 300, 0, 0);
}

mansion_exit() {
  common_scripts\utility::flag_wait("house_cqb_done");
  maps\nml_util::team_unset_colors(128);
  level.dog.idlelookattargets = undefined;
  wait 2;
  common_scripts\utility::flag_wait("player_looking_at_crater");

  if(!common_scripts\utility::flag("skip_house_cqb")) {
    maps\_utility::music_play("mus_nml_reveal");
    thread crater_reveal_dialogue();
    level.baker maps\_utility::disable_cqbwalk();
    level.baker maps\_utility::clear_generic_idle_anim();
    wait 4;
  } else {
    level.dog maps\_utility_dogs::dyn_sniff_disable();
    level.dog maps\_utility_dogs::disable_dog_sniff();
  }

  common_scripts\utility::flag_set("hesh_mansion_jumpdown");
}

crater_reveal_dialogue() {}

house_enter() {
  var_0 = common_scripts\utility::get_target_ent("nml_house_cqb");
  level.rifle = maps\_utility::spawn_anim_model("rifle");
  var_0 thread maps\_anim::anim_first_frame_solo(level.rifle, "NML_house_cqb");
  common_scripts\utility::flag_wait("hesh_ready_to_leave_cave");
  common_scripts\utility::flag_wait("player_enter_mansion");
  common_scripts\utility::exploder("church_sunflare");
  maps\nml_util::baker_noncombat();
  level.dog.idlelookattargets = undefined;
  level notify("start_birds_crater");
  level.player maps\_ash_falling::ash_fall(0);
  level.baker.animname = "hesh";
  var_1 = level.rifle;
  var_0 maps\_anim::anim_reach_solo(level.baker, "NML_house_cqb");

  if(!common_scripts\utility::flag("skip_house_cqb")) {
    maps\_utility::delaythread(5, maps\_utility::music_stop, 6);
    thread mansion_dialogue();
    level.player thread maps\_utility::player_speed_percent(60, 5);
    level.baker maps\_utility::delaythread(8, ::track_player_for_time, 0.5);
    level.baker maps\_utility::delaythread(14.4, ::track_player_for_time, 0.5);
    level.baker maps\_utility::disable_cqbwalk();
    level.baker maps\_utility::disable_exits();
    level.baker maps\_utility::disable_arrivals();
    var_0 maps\_anim::anim_single([level.baker, var_1], "NML_house_cqb");
  }

  var_2 = var_1.model;
  level.baker attach(var_2, "tag_stowed_back");
  var_1 delete();
  common_scripts\utility::flag_set("house_cqb_done");
}

mansion_sound_on_helis() {
  maps\_utility::trigger_wait_targetname("spawn_crater_helis");
  common_scripts\utility::play_sound_in_space("scn_nml_crater_choppers_by", (-1209, 729, 92));
}

track_player_for_time(var_0) {
  self notify("start_tracking");
  self endon("start_tracking");
  self setlookatentity(level.player);
  wait(var_0);
  self setlookatentity();
}

hesh_crater_look() {
  common_scripts\utility::flag_wait("house_cqb_done");

  if(!common_scripts\utility::flag("skip_house_cqb")) {
    level.baker maps\nml_util::switch_from_cqb_to_creepwalk();
    maps\nml_util::hero_paths("nml_mansion_exit", 300, 300, 300, 0, 0);
    common_scripts\utility::waitframe();
    var_0 = common_scripts\utility::get_target_ent("nml_craterview_node");
    level.baker notify("stop_path");
    var_0 maps\_anim::anim_generic_reach(level.baker, "NML_craterview_in");
    var_0 maps\_anim::anim_generic(level.baker, "NML_craterview_in");
    var_0 = spawnStruct();
    var_0.origin = level.baker.origin;
    var_0.angles = level.baker.angles;
    var_0 thread maps\_anim::anim_generic_loop(level.baker, "NML_craterview_idle");
    common_scripts\utility::flag_wait("hesh_mansion_jumpdown");
    var_0 notify("stop_loop");
    maps\nml_util::hero_paths("crater_pos_1", 350, undefined, undefined, 1, 1);
    var_0 maps\_anim::anim_generic(level.baker, "NML_craterview_out");
  } else
    maps\nml_util::hero_paths("crater_pos_1", 350, undefined, undefined, 0, 0);

  common_scripts\utility::flag_set("hesh_mansion_jumpdown_done");
}

mansion_quake_sounds() {
  thread common_scripts\utility::play_sound_in_space("elm_nml_quake_house_rattle_01", (3059, -3561, 106));
  thread common_scripts\utility::play_sound_in_space("elm_nml_quake_house_rattle_02", (2668, -3836, 65));
}

mansion_dialogue() {
  wait 12.5;
  common_scripts\utility::flag_set("start_earthquakes");
  level.force_next_earthquake = 1;
  level.next_quake_sound = "elm_nml_quake_house";
  level.next_earthquake = "med_4s";
  level notify("trigger_earthquake");
  level.dog maps\_utility_dogs::dyn_sniff_disable();
  thread mansion_quake_sounds();
  var_0 = common_scripts\utility::getstructarray("mansion_physics_node", "targetname");

  foreach(var_2 in var_0)
  var_2 thread physics_jolt_node();

  wait 3;

  if(!common_scripts\utility::flag("player_looking_at_crater"))
    maps\nml_util::hero_paths("nml_mansion_exit", 300, 300, 300, 0, 0);
}

physics_jolt_node() {
  wait(randomfloatrange(0.5, 1.5));
  physicsexplosionsphere(self.origin, 256, 64, 0.1);
}

house_deer() {}

deer_earthquake() {
  self endon("death");

  for(;;) {
    earthquake(0.2, 0.2, self.origin, 1500);
    wait(randomfloatrange(0.05, 0.2));
  }
}

intro_secondary_kill() {
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(isDefined(level.dog.enemy) && var_2 == level.dog.enemy && isDefined(level.dog.enemy.syncedmeleetarget)) {
      var_2.allowdeath = 1;
      var_2.a.nodeath = 1;
      var_2.forceragdollimmediate = 1;
      var_2 kill();
      continue;
    }

    var_2 delete();
  }

  level.baker.baseaccuracy = 1;
  level.baker.ignoreall = 0;
  maps\_utility::array_spawn_function_targetname("intro_secondary_scene_guys", ::intro_secondary_scene_guys_think);
  maps\_utility::array_spawn_targetname("intro_secondary_scene_guys", ::intro_secondary_scene_guys_think);
}

intro_secondary_scene_guys_think() {
  var_0 = self.spawner;

  if(isDefined(self.target) && self.target == "intro_secondary_node") {
    level.dog endon("death");

    if(isDefined(level.change_guard_to_hazmat)) {
      self setModel("fullbody_hazmat_a");
      level.change_guard_to_hazmat = undefined;
    }

    self.animname = "victim";
    level.dog.animname = "dog";
    level.dog unlink();
    level.dog.moveplaybackrate = 1;
    self.ignoreme = 1;
    var_0 = common_scripts\utility::get_target_ent();
    var_0 thread maps\_anim::anim_first_frame([self, level.dog], "iw6_dog_kill_front");
    wait 0.5;
    var_1 = common_scripts\utility::get_target_ent("intro_secondary_node_dog");
    level.dog setgoalpos(var_1.origin);
    thread maps\_utility::play_sound_on_entity("scn_nml_dog_attack_front_npc");
    level.dog thread animscripts\shared::donotetracks("single anim", maps\nml_dogattacks::handlevxnotetrack);
    var_0 maps\_anim::anim_single([self, level.dog], "iw6_dog_kill_front");
    level.dog setgoalpos(level.dog.origin);
    self.allowdeath = 1;
    self.a.nodeath = 1;
    self.forceragdollimmediate = 1;
    self kill();
    return;
  } else if(isDefined(self.target))
    var_0 = common_scripts\utility::get_target_ent();

  self.allowdeath = 1;
  self.allowpain = 1;
  self.a.disablelongdeath = 1;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.goalradius = 32;
  maps\_utility::gun_remove();
  self endon("death");
  var_0 thread maps\_anim::anim_generic_gravity(self, var_0.animation);
  var_0 = var_0 common_scripts\utility::get_target_ent();
  self setgoalpos(var_0.origin);
  maps\_utility::set_generic_run_anim("hazmat_run");
  wait 2;
  self.ignoreme = 0;
  wait 0.5;
  self kill();
}

intro_wait_dog_command(var_0) {
  level endon("intro_gunup");
  level.dog waittill("dog_command_attack", var_1);
  level.dog maps\_utility::ent_flag_set("pause_dog_command");
  level.player lerpviewangleclamp(0.4, 0.3, 0.1, 20, 20, 0, 0);
  maps\_utility::music_stop(1);
  level.dog notify("stop_constant_glitch");
  level.dog notify("disable_screen_glitch");
  thread dog_run_earthquakes();
  level.dog_alt_melee_func = maps\nml_dogattacks::meleestrugglevsai_first_attack;
  level.dog.moveplaybackrate = 1.2;
  level.dog maps\_utility::disable_exits();
  level.dog unlink();
  var_0 maps\_anim::anim_generic_run(level.dog, "dog_sneakidle_2_run");
  var_0 notify("stop_loop");
  wait 0.5;
  level.dog maps\_utility::enable_exits();
}

dog_run_earthquakes() {
  level endon("dog_attacks_ai");
  level.dog endon("death");

  for(;;) {
    screenshake(level.dog.origin, 5, 0, 4, 0.6, 0.3, 0.3, 2000, 8, 15, 12, 1.8);
    wait 0.25;
  }
}

dog_cam_fov_default() {
  level.player setblurforplayer(3, 0.05);
  level.player maps\_dog_drive::delete_model_fx();
  level.player maps\_dog_drive::spawn_model_fx((0, 0, 0), (0, 0, 0));
  level.player thread maps\_dog_drive::constant_screen_glitches();
  earthquake(0.4, 0.3, level.player.origin, 1000);
  wait 0.15;
  level.player common_scripts\utility::delaycall(0.1, ::setblurforplayer, 0, 0.5);
  level.player lerpfov(90, 0.05);
  level.player thread maps\_utility::notify_delay("stop_constant_glitch", 0.1);
  wait 0.1;
}

intro_wait_dog_attack() {
  level endon("intro_gunup");
  level.dog waittill("dog_command_attack", var_0);
  level.dog thread maps\_utility_dogs::dog_pant_think();
  thread dog_cam_fov_default();
  level waittill("dog_attacks_ai", var_1);
  thread dog_attack_slowmo(var_1, var_0);
}

dog_attack_slowmo(var_0, var_1) {
  level.dog.attacked = 1;

  if(!issubstr(var_1.model, "hazmat"))
    level.change_guard_to_hazmat = 1;

  level.player stopshellshock();
  var_1 = getaiarray("axis");

  foreach(var_3 in var_1) {
    var_3.no_more_outlines = 1;
    var_3 hudoutlinedisable();
  }

  common_scripts\utility::flag_set("intro_dog_attacked");
  level.player thread maps\_utility::play_sound_on_entity("slomo_whoosh_in");
  level.player thread maps\_slowmo_breach::player_heartbeat();
  maps\_utility::slowmo_setspeed_slow(0.2);
  maps\_utility::slowmo_setlerptime_in(0.25);
  maps\_utility::slowmo_lerp_in();
  wait 0.4;
  level notify("stop_player_heartbeat");
  level.player thread maps\_utility::play_sound_on_entity("slomo_whoosh_out");
  maps\_utility::slowmo_setlerptime_out(0.5);
  maps\_utility::slowmo_lerp_out();
  wait 0.75;
  thread common_scripts\utility::flag_set("intro_gunup");
}

intro_wait_spotted() {}

intro_outlines() {
  wait 0.7;
  var_0 = getaiarray("axis");
  var_0 = sortbydistance(var_0, level.dog.origin);
  var_1 = [0.5, 0.7, 1];
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_4 thread maps\nml_util::hud_outlineenable();
    wait(var_1[var_2]);
    var_2 = var_2 + 1;
  }
}

intro_dialogue() {
  level.dog endon("dog_command_attack");
  thread intro_dialogue_2();
  level endon("intro_gunup");
  maps\_utility::smart_radio_dialogue("nml_hsh_isiton");
  level maps\_utility::notify_delay("camera_clears", 2);
  wait 0.5;
  maps\_utility::smart_radio_dialogue("nml_hsh_oklookslikewere");
  wait 1.5;
  thread maps\nml_util::blur_pulse(4);
  level.player.dog_track_range = 3000;
  level.player.dog_attack_range = 300;
  thread intro_outlines();
  maps\_utility::smart_radio_dialogue("nml_hsh_contact_2");
  wait 0.7;
  maps\_utility::smart_radio_dialogue("nml_hsh_enemypatrolapproaching");
  wait 0.5;
  level.player setblurforplayer(3, 0.05);
  level.player maps\_dog_drive::delete_model_fx();
  level.player maps\_dog_drive::spawn_model_fx((5, 0, 0), (75, 0, 0), (300, 0, 0));
  level.player thread maps\_dog_drive::constant_screen_glitches();
  earthquake(0.4, 0.5, level.player.origin, 1000);
  wait 0.15;
  level.player lerpfov(25, 0.05);
  level.player thread maps\_utility::play_sound_on_entity("scn_nml_camera_zoom_out");
  level.player thread maps\_utility::notify_delay("stop_constant_glitch", 0.3);
  wait 0.15;
  level.player lerpfov(30, 0.05);
  level.player common_scripts\utility::delaycall(0.2, ::setblurforplayer, 0, 0.5);
  wait 0.3;
  maps\_utility::smart_radio_dialogue("nml_hsh_donotengage");
  thread maps\nml_util::blur_pulse(3);
  wait 2;
  maps\_utility::smart_radio_dialogue("nml_hsh_letthemgetcloser");
  wait 0.6;
  level.player setblurforplayer(3, 0.05);
  level.player maps\_dog_drive::delete_model_fx();
  level.player maps\_dog_drive::spawn_model_fx((2, 0, 0), (25, 0, 0), (150, 0, 0));
  level.player thread maps\_dog_drive::constant_screen_glitches();
  earthquake(0.4, 0.5, level.player.origin, 1000);
  wait 0.15;
  level.player lerpfov(45, 0.05);
  level.player thread maps\_utility::play_sound_on_entity("scn_nml_camera_zoom_out");
  level.player thread maps\_utility::notify_delay("stop_constant_glitch", 0.3);
  wait 0.15;
  level.player lerpfov(50, 0.05);
  level.player common_scripts\utility::delaycall(0.2, ::setblurforplayer, 0, 0.5);
  wait 0.75;
  hesh_looks_at_cam();
  level.player setblurforplayer(3, 0.05);
  level.player maps\_dog_drive::delete_model_fx();
  level.player maps\_dog_drive::spawn_model_fx((2, 0, 0), (25, 0, 0), (150, 0, 0));
  level.player thread maps\_dog_drive::constant_screen_glitches();
  earthquake(0.4, 0.5, level.player.origin, 1000);
  wait 0.15;
  level.player lerpfov(65, 0.05);
  level.player thread maps\_utility::play_sound_on_entity("scn_nml_camera_zoom_out");
  level.player thread maps\_utility::notify_delay("stop_constant_glitch", 0.3);
  wait 0.15;
  level.player lerpfov(70, 0.05);
  level.player common_scripts\utility::delaycall(0.2, ::setblurforplayer, 0, 0.5);
  level.dog maps\_utility::ent_flag_clear("pause_dog_command");
  common_scripts\utility::flag_set("intro_guys_close");
  level.player.dog_attack_range = 2000;
  maps\_utility::smart_radio_dialogue("nml_hsh_doit");
  wait 0.5;

  if(getdvarint("e3") == 0)
    maps\_utility::display_hint_timeout("hint_dog_attack", 6);
}

hesh_looks_at_cam() {
  var_0 = common_scripts\utility::get_target_ent("dog_intro_node");
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_2 = level.baker.origin;
  var_3 = level.baker.angles;
  level.baker.animname = "hesh";
  level.dog maps\_utility::ent_flag_set("pause_dog_command");
  var_0 notify("stop_loop");
  level.player lerpviewangleclamp(0.4, 0.3, 0.1, 0, 0, 0, 0);
  level.player thread maps\_dog_drive::constant_screen_glitches();
  level.player thread maps\_utility::notify_delay("stop_constant_glitch", 0.5);
  earthquake(0.3, 0.75, level.dog.origin, 1000);
  maps\_art::dof_enable_script(0, 0, 6, 35, 280, 5, 0.5);
  level.player maps\_utility::delaythread(2.5, maps\_dog_drive::default_dof, 1.75);
  level.baker maps\_utility::gun_remove();
  var_1 maps\_anim::anim_single([level.dog, level.baker], "dog_intro");
  maps\_utility::autosave_stealth_silent();
  level.baker maps\_utility::delaythread(1, maps\_utility::gun_recall);
  level.player lerpviewangleclamp(0.1, 0, 0, 30, 30, 15, 15);
  var_0 thread maps\_anim::anim_generic_loop(level.dog, "dog_sneak_idle_intro");
  wait 0.2;
  level.baker forceteleport(var_2, var_3);
  level.baker.goalradius = 16;
  level.baker setgoalpos(level.baker.origin);
}

intro_kill_hazmats() {
  level endon("intro_clear");
  wait 5;
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(issubstr(var_2.model, "hazmat"))
      var_2 kill();
  }
}

intro_dialogue_2() {
  level.dog endon("death");
  common_scripts\utility::flag_wait("intro_gunup");
  wait 0.5;
  level.baker maps\_utility::smart_dialogue("nml_hsh_takeemout");
  thread intro_kill_hazmats();
  common_scripts\utility::flag_wait("intro_clear");
  wait 0.5;
  level.baker maps\_utility::smart_dialogue("nml_hsh_clear_4");
  maps\_utility::music_play("mus_nml_travel");
  wait 0.5;
  level.baker maps\_utility::smart_dialogue("nml_hsh_thatsthethirdgroup");
  wait 0.75;
  level.baker maps\_utility::smart_dialogue("nml_hsh_eyespeeledcouldbe");
  level endon("hesh_ready_to_leave_cave");
  level.baker waittill("starting_anim");
  thread hesh_gate_logic();
  level.baker maps\_utility::smart_dialogue("nml_hsh_standby");
  level.dog maps\_utility_dogs::disable_dog_sniff();
  maps\_utility::delaythread(0.3, ::cave_cairo_whine);
  level.baker waittill("starting_anim");
  level waittill("earthquaking");
  wait 0.5;
  level.baker maps\_utility::smart_dialogue("nml_hsh_eeaasycairo");
  wait 2.5;
  level.baker maps\_utility::smart_dialogue("nml_hsh_welcomehomeadam");
  wait 1.5;
  level.baker maps\_utility::smart_dialogue("nml_hsh_whatsleftofit");
}

hesh_gate_logic() {
  level.baker endon("leaving_cave");

  if(!common_scripts\utility::flag("hesh_ready_to_leave_cave")) {
    thread hesh_gate_logic_exit();
    level.baker waittill("NML_gate_in");
    var_0 = spawnStruct();
    var_0.origin = level.baker.origin;
    var_0.angles = (0, 90, 0);
    var_0 thread maps\_anim::anim_generic_loop(level.baker, "NML_gate_idle");
  }
}

hesh_gate_logic_exit() {
  common_scripts\utility::flag_wait("cave_exit");
  common_scripts\utility::flag_wait("hesh_ready_to_leave_cave");
  level.baker notify("leaving_cave");
  level.baker notify("stop_loop");
  level.baker thread maps\_anim::anim_generic_gravity(level.baker, "NML_gate_out");
  common_scripts\utility::flag_set("cave_hesh_done");
}

cave_cairo_whine() {
  level.dog endon("death");
  level.dog maps\_utility::play_sound_on_entity("nml_cairo_whine_1");
  level.dog maps\_utility::play_sound_on_entity("nml_cairo_whine_2");
}

cave_earthquake() {
  for(;;) {
    level.baker waittill("starting_anim", var_0);

    if(var_0 == "NML_gate_in") {
      break;
    }
  }

  wait 1;
  level.force_next_earthquake = 1;
  level.next_quake_sound = "elm_nml_quake_cave";
  level.next_earthquake = "med_4s";
  common_scripts\utility::flag_set("start_earthquakes");
  level notify("trigger_earthquake");
  level waittill("earthquaking");
  maps\_utility::activate_trigger_with_noteworthy("cave_quake_trig");
}

children_sounds() {
  self waittill("trigger");
  level.player thread maps\_utility::play_sound_on_entity("elm_ghostly_children");
}

crater_ledge_walk() {
  level.dog endon("death");
  common_scripts\utility::flag_clear("start_earthquakes");
  maps\nml_util::team_unset_colors(64);
  level.baker maps\_utility::clear_generic_idle_anim();
  maps\nml_util::hero_paths("crater_pos_2", 300, 300, 300, 0, 0);
  wait 0.2;
  common_scripts\utility::flag_wait("start_ledge_walk");
  maps\nml_util::hero_paths("post_crater_setup", 300, 300, 0, 0, 0);
  wait 0.2;
  thread hesh_crater_walk();
  thread post_crater_dog_scared();
}

hesh_crater_walk() {
  var_0 = common_scripts\utility::get_target_ent("cliff_walk_node_2");
  var_0 maps\_anim::anim_generic_reach(level.baker, "NML_cliff_walk");
  common_scripts\utility::flag_set("start_ledge_walk");

  if(!common_scripts\utility::flag("church_fall")) {
    var_1 = common_scripts\utility::get_target_ent("force_church_fall_trigger");
    var_1 delete();
    level.baker maps\_utility::delaythread(0.1, maps\_utility::smart_dialogue, "nml_hsh_watchyourstepover_2");
    var_0 thread maps\_anim::anim_generic(level.baker, "NML_cliff_walk");
    wait 7.2;
    common_scripts\utility::flag_set("church_fall");
  } else
    common_scripts\utility::flag_set("skip_church_walk");

  level.baker maps\_utility::enable_cqbwalk();
}

post_crater_dog_scared() {
  level.dog endon("death");
  level.dog waittill("path_end_reached");
  common_scripts\utility::flag_wait("start_ledge_walk");
  common_scripts\utility::flag_wait("church_fall");
  level.baker pushplayer(1);
  level.baker.animname = "hesh";
  var_0 = common_scripts\utility::get_target_ent("dog_affection_node");
  var_0 maps\_anim::anim_reach_solo(level.baker, "dog_affection");
  thread cairo_scared_dialogue();
  level.baker.anim_blend_time_override = 1;
  var_0 thread maps\_anim::anim_single([level.dog, level.baker], "dog_affection");
  wait 3.35;
  level.baker.anim_blend_time_override = 0.5;
  thread pc_walla();
  level.dog thread maps\_utility::play_sound_on_entity("scn_nml_dog_crater_growl");
  wait 0.66;
  level.dog thread maps\_utility_dogs::dog_bark("scn_nml_dog_crater_bark");
  thread common_scripts\utility::play_sound_in_space("scn_nml_dog_crater_bark_dist", (1341, -1142, -153));
  wait 0.1;
  common_scripts\utility::flag_set("baker_cliff_done");
  common_scripts\utility::flag_set("start_post_crater");
  common_scripts\utility::flag_set("crater_scared_done");
  level.dog.anim_blend_time_override = 0.75;
  level.dog thread maps\_anim::anim_generic(level.dog, "iw6_dog_attackidle_runout_6");
  level.dog common_scripts\utility::delaycall(0.95, ::stopanimscripted);
  level.baker thread maps\_anim::anim_generic_gravity(level.baker, "_stealth_behavior_generic2");
  level.baker thread maps\_utility::play_sound_on_entity("scn_nml_hesh_pet_cairo_up");
  maps\_utility::delaythread(2, ::scared_danger_dialogue);
  level.baker endon("follow_path");
  level.baker waittill("_stealth_behavior_generic2");
  level.baker setgoalpos(level.baker.origin);
  level.baker.anim_blend_time_override = undefined;
  level.dog.anim_blend_time_override = undefined;
  level.baker pushplayer(1);
  common_scripts\utility::flag_set("baker_cliff_done");
  common_scripts\utility::flag_set("start_post_crater");
  common_scripts\utility::flag_set("crater_scared_done");
}

pc_walla() {
  level endon("start_post_crater_dog");
  var_0 = common_scripts\utility::get_target_ent("pc_walla_org");

  for(var_1 = 1; var_1 < 9; var_1++) {
    common_scripts\utility::play_sound_in_space(level.scr_sound["generic"]["walla_4_" + var_1], var_0.origin);
    wait(randomfloatrange(0.3, 0.6));
  }
}

cairo_scared_dialogue() {
  level.dog endon("death");
  level.dog notify("stop_whine");
  level.dog thread maps\_utility::play_sound_on_entity("nml_cairo_whine_2");
  wait 0.6;
  level.baker maps\_utility::smart_dialogue("nml_hsh_youreallrightboy");
}

scared_danger_dialogue() {
  level.baker maps\_utility::smart_dialogue("nml_hsh_soundsliketrouble");
}

cairo_church_whines() {
  level.dog endon("death");
  level.dog maps\_utility::play_sound_on_entity("nml_cairo_whine_7");
  level.dog endon("stop_whine");

  for(;;) {
    level.dog maps\_utility::play_sound_on_entity("nml_cairo_whine_6");
    level.dog maps\_utility::play_sound_on_entity("nml_cairo_whine_4");
    common_scripts\utility::waitframe();
  }
}

church_collapse() {
  level.dog endon("death");
  wait 1;
  common_scripts\utility::flag_set("start_earthquakes");
  level.player allowsprint(0);
  level.force_next_earthquake = 1;
  level.next_quake_sound = "scn_nml_church_quake1";
  level notify("trigger_earthquake");
  level.player thread maps\_utility::player_speed_percent(30, 0.1);
  level.player maps\_utility::delaythread(1.5, maps\_utility::player_speed_percent, 80, 2);
  maps\_utility::activate_trigger_with_targetname("crater_mover1");
  thread attach_dust_to_mover("crater_mover1", "scn_nml_crater_fall_01");
  common_scripts\utility::exploder("crater_chunk_1");
  wait 4;
  common_scripts\utility::flag_set("start_earthquakes");
  level notify("trigger_earthquake");
  level.force_next_earthquake = 1;
  level.next_quake_sound = "scn_nml_church_quake2";
  level.next_earthquake = "med_4s";
  level waittill("earthquaking");
  level.player thread maps\_utility::player_speed_percent(10, 0.75);
  level.player maps\_utility::ent_flag_init("fall");
  level.player maps\_utility::ent_flag_init("collapse");
  level.player thread maps\_player_limp::stumble((5, 2, 7), 0.75, 2);
  maps\_utility::activate_trigger_with_targetname("crater_mover2");
  thread attach_dust_to_mover("crater_mover2", "scn_nml_crater_fall_02");
  common_scripts\utility::exploder("crater_chunk_2");
  wait 2;
  level.player thread maps\_utility::player_speed_percent(75, 1.5);
  level.player allowsprint(1);
  common_scripts\utility::exploder("church_collapse_birds");
  common_scripts\utility::flag_wait("church_fall");
  thread cairo_church_whines();
  common_scripts\utility::flag_set("start_earthquakes");
  level notify("trigger_earthquake");
  level.force_next_earthquake = 1;
  level.next_quake_sound = "scn_nml_church_quake3";
  level.next_earthquake = "med_4s";
  level waittill("earthquaking");
  level.player allowsprint(0);
  level.player thread maps\_utility::player_speed_percent(10, 0.75);
  level.player thread maps\_utility::play_sound_on_entity("scn_nml_foot_shuffle_plr");
  maps\_utility::delaythread(1, common_scripts\utility::exploder, "cliff_hero_dust");
  level.player thread maps\_player_limp::stumble((10, 5, 15), 0.75, 2);
  wait 0.5;
  thread common_scripts\utility::do_earthquake("weak_15s", level.player.origin);
  level.player setstance("crouch");
  level.player disableweapons();
  thread crater_baker_stumble();
  maps\_utility::delaythread(1, ::church_fall);
  wait 5.5;
  level.player enableweapons();
  level.player thread maps\_utility::play_sound_on_entity("weap_raise_plr");
  level.player thread maps\_utility::player_speed_percent(100, 1.5);
  level.player allowsprint(1);
}

crater_baker_stumble() {
  level.baker thread maps\_utility::smart_dialogue("nml_hsh_shimmy");
}

attach_dust_to_mover(var_0, var_1) {
  var_2 = common_scripts\utility::get_target_ent(var_0);
  var_3 = var_2.mover common_scripts\utility::get_target_ent();
  playFXOnTag(common_scripts\utility::getfx("crater_chunk_dust"), var_3, "tag_origin");
  var_3 thread maps\_utility::play_sound_on_entity(var_1);
  var_2 waittill("done_moving");
  wait 8;
  stopFXOnTag(common_scripts\utility::getfx("crater_chunk_dust"), var_3, "tag_origin");
}

church_fall() {
  var_0 = getent("church_cliff", "targetname");
  var_0.no_delete = 1;
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  level.player thread common_scripts\utility::play_sound_in_space("scn_nml_church_mono", (1588, 1015, -5));
  level.player maps\_utility::delaythread(6.326, common_scripts\utility::play_sound_in_space, "scn_nml_churchground_mono", (1048, -430, -1854));
  wait 0.075;
  var_2 = 1;
  var_3 = getEntArray("church_pieces", "script_noteworthy");
  var_4 = 0;

  foreach(var_6 in var_3) {
    var_6.animname = var_6.targetname;
    var_6 useanimtree(level.scr_animtree["church_cliff"]);
    var_7 = getanimlength(var_6 maps\_utility::getanim("collapse")) / var_2;

    if(var_4 < var_7)
      var_4 = var_7;
  }

  if(!maps\_utility::game_is_current_gen()) {
    var_9 = anglesToForward(var_1.angles);
    var_10 = anglestoup(var_1.angles);
    playFX(common_scripts\utility::getfx("vfx_church_collapse_debris"), var_1.origin, var_9, var_10);
  }

  common_scripts\utility::exploder("church_collapse_smoke");
  var_11 = ["church_piece_15", "church_piece_14", "church_piece_13", "church_piece_12", "church_piece_11", "church_piece_10", "church_piece_9", "church_piece_8", "church_piece_7", "church_piece_6", "church_piece_5"];
  var_12 = ["church_piece_15", "church_piece_14", "church_piece_13", "church_piece_12"];

  foreach(var_6 in var_3) {
    if(level.ps3 && common_scripts\utility::array_contains(var_11, var_6.animname)) {
      var_6 delete();
      continue;
    }

    if(level.xenon && common_scripts\utility::array_contains(var_12, var_6.animname)) {
      var_6 delete();
      continue;
    }

    var_6 setflaggedanimrestart("collapse", var_6 maps\_utility::getanim("collapse"), 1, 0.1, var_2);
    var_6 thread delete_on_collapse_done();
  }

  wait(var_4);
  var_15 = spawn("script_model", var_1.origin);
  var_15.angles = var_1.angles;
  var_15 setModel("vfx_nml_church_lastframe");
}

delete_on_collapse_done() {
  if(isDefined(self.no_delete)) {
    return;
  }
  self waittillmatch("collapse", "end");
  self delete();
}

growl_on_path_end() {
  level.dog endon("death");
  level endon("start_post_crater_dog");
  self waittill("path_end_reached");
  wait 0.5;

  while(isDefined(level.dog.script_growl)) {
    wait(randomfloatrange(0.5, 1));
    maps\_utility::play_sound_on_entity("scn_nml_dog_growl_fuss");
  }

  level waittill("hesh_foos_line_finished");
  wait 0.2;
  maps\_utility::play_sound_on_entity("scn_nml_dog_growl_fuss_final");
}

sync_nag() {
  level endon("kill_sync_nag");
  wait 5;

  for(;;) {
    level.baker maps\_utility::smart_dialogue("nml_hsh_adamsynconriley");
    wait 10;
  }
}

post_crater_dog_setup() {
  level.dog endon("death");
  common_scripts\utility::flag_wait("crater_scared_done");
  level.baker maps\nml_util::set_move_rate(1);
  level.baker maps\_utility::clear_generic_idle_anim();
  setsaveddvar("ai_friendlyFireBlockDuration", 0);
  maps\nml_util::team_unset_colors(96);
  level.baker maps\_utility::delaythread(2, maps\_utility::enable_cqbwalk);
  level.dog.script_growl = 1;
  level.dog maps\nml_util::set_move_rate(1);
  level.dog pushplayer(1);
  level.baker pushplayer(1);
  maps\nml_util::hero_paths_cairo_first("post_crater_pos1");
  level.dog maps\_utility::set_generic_idle_anim("dog_alert");
  level.dog thread growl_on_path_end();
  level.dog waittill("path_end_reached");
  common_scripts\utility::flag_wait("post_crater_pos1");
  wait 0.7;
  level.dog.script_growl = undefined;
  level.dog.script_nobark = 1;
  level notify("hesh_foos_line_finished");
  wait 0.5;
  level.baker maps\_utility::disable_cqbwalk();
  level.baker allowedstances("crouch");
  level.baker thread maps\_utility::smart_dialogue("nml_hsh_adamsyncupwith");
  thread sync_nag();
  setsaveddvar("r_hudoutlinewidth", 3);
  var_0 = level.dog.model;
  level.dog maps\_utility_dogs::set_dog_model("fullbody_dog_a_cam_obj");
  var_1 = level.dog;
  var_1 makeusable();

  if(!level.console && !level.player usinggamepad())
    var_1 sethintstring(&"NML_HINT_SYNC_KB");
  else
    var_1 sethintstring(&"NML_HINT_SYNC");

  var_1 waittill("trigger");
  level notify("kill_sync_nag");
  level.dog maps\_utility_dogs::set_dog_model_no_fur(var_0);
  var_1 makeunusable();
  level.player maps\_utility::player_speed_percent(1, 0.05);
  level.player allowjump(0);
  level.player allowsprint(0);
  level.dog maps\_utility::delaythread(0.01, maps\_utility_dogs::dog_raise_camera, 0.4);
  level.baker stopsounds();
  thread maps\_utility::smart_radio_dialogue_interrupt("nml_hsh_herewego");
  setsaveddvar("r_hudoutlinewidth", 1);
  level.player.pre_dogcam_weapon = level.player getcurrentweapon();
  level.player disableweaponswitch();
  level.player giveweapon("remote_chopper_gunner");
  level.player switchtoweapon("remote_chopper_gunner");
  setdvar("hideHudFast", 1);
  setsaveddvar("ammoCounterHide", 1);
  level.player thread maps\_utility::play_sound_on_entity("uav_remote_raise_plr");
  cinematicingameloop("dog_out");
  wait 1;
  maps\_hud_util::fade_out(0.5, "overlay_static");
  wait 0.5;
  thread maps\_lights::lerp_sunsamplesizenear_overtime(0.25, 0.1);
  level.dog maps\_utility::clear_generic_idle_anim();
  common_scripts\utility::flag_set("start_post_crater_dog");
  wait 0.5;
  level.player setclienttriggeraudiozone("nml_dog_camera", 0.5);
  thread maps\_utility::music_play("mus_nml_post_crater");
  maps\_hud_util::fade_in(0.5, "overlay_static");
  common_scripts\utility::noself_delaycall(4, ::stopcinematicingame);
  level.player maps\_utility::player_speed_percent(100, 0.1);
  level.player allowjump(1);
  level.player allowsprint(1);
}

player_drive_dog_pc() {
  maps\nml_stealth::stealth_settings_dog_pc();
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0)
  var_2 delete();

  level.dog.idlelookattargets = undefined;
  level.dog.ignoreall = 1;
  level.baker.ignoreme = 1;
  level.player.ignoreme = 1;
  level.dog maps\_utility::clear_generic_idle_anim();
  level.dog.script_nobark = 1;
  level.dog maps\nml_util::set_move_rate(0.7);
  level.dog.ignoreme = 1;
  level.dog maps\_utility::enable_pain();
  level.dog_alt_melee_func = undefined;
  level.player maps\_dog_drive::dog_drive_indirect(level.dog);
  thread maps\nml_stealth::dog_footstep_logic();
  thread maps\nml_util::mission_fail_on_dog_death();
  level.dog maps\_utility::ent_flag_set("dogcam_acquire_targets");
  level.player lerpviewangleclamp(0.3, 0, 0.2, 0, 0, 0, 0);
  level.dog setdogcommand("attack");
  common_scripts\utility::waitframe();
  thread pc_dog_drive_dialogue();
  level.player thread maps\_dog_drive::constant_screen_glitches();
  level.player maps\_utility::notify_delay("stop_constant_glitch", 2);
  level.baker.ignoreall = 1;
  thread track_dog_attacks();
  thread hint_for_first_attack();
  var_4 = common_scripts\utility::get_target_ent("dog_pc_drive_start");
  level.dog notify("stop_loop");
  level.dog stopanimscripted();
  level.dog.pushplayer = 1;
  level.dog pushplayer(1);
  level.dog.goalradius = 32;
  var_5 = common_scripts\utility::get_target_ent("pc_player_teleport");
  level.player setorigin(var_5.origin);
  level.dog setgoalpos(var_4.origin);
  level.dog maps\_utility::disable_arrivals();
  level.dog maps\_utility::disable_exits();
  thread dog_over_car_sound();
  level.dog waittill("goal");
  level.dog thread maps\_anim::anim_generic_gravity(level.dog, "iw6_dog_sneak_runin_8");
  level.player maps\_dog_drive::default_dog_limits();
  level.dog setdogcommand("driven");
  level.dog.ignoreme = 0;
  level.dog.ignoreall = 0;
  maps\_utility::autosave_stealth_silent();
  level.dog maps\_utility::enable_arrivals();
  level.dog maps\_utility::enable_exits();
}

dog_over_car_sound() {
  level.dog waittill("dog_traverse");
  level.dog maps\_utility::play_sound_on_entity("scn_nml_dog_traversal");
}

track_dog_attacks() {
  for(level.dog.attack_times = 0; level.dog.attack_times < 1; level.dog.attack_times = level.dog.attack_times + 1)
    level waittill("dog_attacks_ai");
}

hint_for_first_attack() {
  while(level.dog.attack_times < 1) {
    level.player waittill("dogcam_acquired_target");
    maps\_utility::display_hint_timeout("hint_dog_attack_cam", 3);
    wait 0.2;
  }
}

pc_dog_drive_dialogue() {
  level endon("pc_dog_moved");
  wait 0.1;
  thread pc_track_guy_1();
  thread pc_dog_drive_dialogue_2();
  thread pc_dog_drive_dialogue_3();
  thread pc_dog_drive_dialogue_4();
  wait 0.5;
  maps\_utility::smart_radio_dialogue("nml_hsh_okthevestis");
  wait 0.5;
  maps\_utility::smart_radio_dialogue("nml_hsh_itllhelpguidehim");
  wait 1;
  maps\_utility::smart_radio_dialogue("nml_hsh_scanaroundfora");
}

pc_track_guy_1() {
  level endon("stop_dogdrive_script");
  level.dog endon("death");
  var_0 = maps\_utility::get_living_ai("pc_hazmat_closest", "script_noteworthy");
  var_0 thread maps\nml_util::hazmat_think("stand");
  var_0 maps\nml_util::waittill_player_lookat_on_dog(1, 0.9);
  common_scripts\utility::flag_set("pc_dog_moved");
}

pc_dog_drive_dialogue_2() {
  level endon("stop_dogdrive_script");
  var_0 = maps\_utility::get_living_ai("pc_hazmat_closest", "script_noteworthy");
  var_0 thread maps\_utility::flag_on_death("pc_guy_1_dead");
  var_0 endon("death");
  common_scripts\utility::flag_wait("pc_dog_moved");
  common_scripts\utility::flag_set("pc_dog_at_wall");
  maps\_utility::smart_radio_dialogue_interrupt("nml_hsh_okiseetwo");
  wait 1;
  maps\_utility::smart_radio_dialogue("nml_hsh_letthemseparate");
  wait 4;
  thread maps\_utility::smart_radio_dialogue("nml_hsh_thecloseronetake");
  maps\_utility::display_hint_timeout("hint_dog_approach", 15);
}

pc_dog_drive_dialogue_3() {
  level endon("stop_dogdrive_script");
  thread maps\nml_util::track_player_bark();
  var_0 = maps\_utility::get_living_ai("pc_hazmat_farther", "script_noteworthy");
  var_0 thread maps\_utility::flag_on_death("pc_guy_2_dead");
  var_0 endon("death");
  common_scripts\utility::flag_wait("pc_guy_1_dead");
  level endon("pc_saw_second_guy");
  maps\_utility::smart_radio_dialogue("nml_hsh_nice_2");
  wait 1;
  maps\_utility::smart_radio_dialogue("nml_hsh_hmwheredtheother");
  wait 1.5;
  thread pc_saw_second_guy(var_0);

  if(!level.console && !level.player usinggamepad())
    maps\_utility::display_hint("hint_bark_kb");
  else
    maps\_utility::display_hint("hint_bark");

  maps\_utility::smart_radio_dialogue("nml_hsh_seeifyoucan");
}

pc_saw_second_guy(var_0) {
  level endon("stop_dogdrive_script");
  level.dog endon("death");
  var_0 maps\nml_util::waittill_player_lookat_on_dog(0.75, 0.75);
  level notify("pc_saw_second_guy");
  var_0 maps\_utility::set_hudoutline("enemy", 0);
  var_0 endon("dog_attacks_ai");
  level.dog thread maps\_utility::play_sound_on_entity("scn_nml_camera_enemy_contact_on");

  if(isDefined(var_0) && distance(var_0.origin, level.dog.origin) > 450) {
    maps\_utility::smart_radio_dialogue_interrupt("nml_hsh_thereheis");
    wait 0.7;
  }

  var_1 = 1;

  if(isalive(var_0) && !isDefined(var_0.syncedmeleetarget))
    maps\_utility::smart_radio_dialogue_interrupt("nml_hsh_illtakethisone");

  wait 0.6;

  if(isalive(var_0) && !isDefined(var_0.syncedmeleetarget))
    level.baker maps\nml_stealth::magic_stealth_shot(var_0, var_1);
}

pc_dog_drive_dialogue_4() {
  level endon("stop_dogdrive_script");
  common_scripts\utility::flag_wait("pc_guy_1_dead");
  common_scripts\utility::flag_wait("pc_guy_2_dead");
  wait 0.5;
  maps\_utility::smart_radio_dialogue_interrupt("nml_hsh_alright");
  wait 0.3;
  maps\_utility::autosave_stealth();
  maps\_utility::smart_radio_dialogue("nml_hsh_havecairosearchthe");
}

guy_wait_for_bark(var_0) {
  level endon("pc_saw_second_guy");
  level waittill("dog_barked", var_1);
  var_2 = spawn("script_origin", var_1.origin);
  var_2.origin = var_1.origin;
  var_2.angles = var_1.angles;
  var_2.targetname = "dog_patrol_node";
  var_0.script_animation = "creepwalk";
  var_0 thread maps\_patrol::patrol("dog_patrol_node");
}

pc_dog_drive_killed_by_sniper(var_0) {
  if(getdvarint("jimmy", 0) == 0) {
    var_0 endon("death");
    maps\_utility::trigger_wait_targetname("pc_courtyard_trigger");
    common_scripts\utility::flag_set("_stealth_spotted");
    wait 1.5;
    var_0 maps\nml_stealth::magic_stealth_shot(level.dog);
  }
}

pc_dog_drive_spotted() {
  level endon("pc_dog_drive_killed_guard");
  level endon("start_post_crater_house");
  level.dog endon("death");
  common_scripts\utility::flag_wait("_stealth_spotted");
  thread maps\_utility::smart_radio_dialogue_interrupt("nml_hsh_werespottedtakeem");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    var_2 getenemyinfo(level.dog);

    if(issubstr(var_2.model, "hazmat")) {
      var_2 notify("runaway", level.dog);
      continue;
    }

    var_2 notify("stop_path");
    var_2 notify("end_patrol");
    var_2.favoritenemy = level.dog;
    var_2 setgoalentity(level.dog);
  }
}

courtyard_guys_notify_on_death(var_0) {
  if(self == var_0) {
    return;
  }
  if(issubstr(self.model, "hazmat")) {
    return;
  }
  self waittill("death");
  level notify("pc_dog_drive_killed_guard");
}

pc_dog_drive_enemies() {
  level.dog endon("death");
  level endon("stop_dogdrive_script");
  var_0 = maps\_utility::array_spawn_targetname("post_crater_dog_guys", 1);
  thread maps\nml_util::make_enemy_squad_burst(var_0, "cave_exit");
  common_scripts\utility::array_thread(var_0, maps\nml_util::hud_outlineenable);
  var_1 = common_scripts\utility::get_target_ent("pc_search_1_volume");
  var_1 waittill("trigger");
  maps\nml_util::volume_waittill_no_axis("pc_search_1_volume");
  wait 0.75;
  var_1 = common_scripts\utility::get_target_ent("pc_search_1_exit");
  var_1 waittill("trigger");
  common_scripts\utility::flag_set("pc_dogdrive_courtyard");
  courtyard_guys_walla();
  var_2 = maps\_utility::get_living_ai("balcony_guy", "script_noteworthy");
  common_scripts\utility::array_thread(getaiarray("axis"), ::courtyard_guys_notify_on_death, var_2);
  thread pc_dog_drive_killed_by_sniper(var_2);
  maps\_utility::smart_radio_dialogue_interrupt("nml_hsh_hangonivegot");
  var_2 maps\_utility::set_hudoutline("enemy", 0);
  level.dog thread maps\_utility::play_sound_on_entity("scn_nml_camera_enemy_contact_on");
  wait 1;
  thread maps\_utility::smart_radio_dialogue("nml_hsh_hesmine");
  wait 1.6;
  level.baker maps\nml_stealth::magic_stealth_shot(var_2, 2);
  level.baker.ignoreall = 1;
  common_scripts\utility::flag_set("pc_sniper_dead");
  wait 2;

  if(!level.console && !level.player usinggamepad() && maps\_utility::is_command_bound("+sprint_zoom"))
    maps\_utility::display_hint_timeout("hint_dog_sprintzoom", 9);
  else
    maps\_utility::display_hint_timeout("hint_dog_sprint", 9);

  var_2 = getaiarray("axis");

  if(var_2.size > 1)
    maps\_utility::smart_radio_dialogue("nml_hsh_oktaketheguard");
}

pc_dog_drive_end() {
  common_scripts\utility::flag_wait("pc_dogdrive_courtyard");
  maps\nml_util::volume_waittill_no_axis("pc_search_2_volume");
  maps\nml_util::volume_waittill_no_axis("post_crater_volume");
  level notify("stop_dogdrive_script");
  wait 0.5;
  maps\_utility::smart_radio_dialogue("nml_hsh_allclear");
  wait 0.7;
  thread maps\_utility::smart_radio_dialogue("nml_hsh_goodboycairo_2");
  cinematicingameloop("dog_out");
  level.player thread maps\_dog_drive::constant_screen_glitches();
  wait 0.5;
  level.player clearclienttriggeraudiozone(0.5);
  level.player thread maps\_utility::play_sound_on_entity("scn_nml_tablet_put_away");
  level.player notify("disable_zoom");
  maps\_hud_util::fade_out(0.25, "overlay_static");
  wait 0.5;
  var_0 = getaiarray("axis");
  common_scripts\utility::array_call(var_0, ::delete);
  maps\_stealth_visibility_system::system_state_try_clear_flag("default");
  level.player freezecontrols(1);
  level.dog_alt_melee_func = undefined;
  level.dog.script_nostairs = undefined;
  level.dog.script_noturnanim = undefined;
  level.baker.ignoreall = 0;
  level.player maps\_dog_drive::dog_drive_indirect_disable(level.dog);
  level.dog.melee = undefined;
  level.dog thread maps\_utility::magic_bullet_shield();
  level.dog maps\_utility_dogs::set_dog_model(level.dog.model);
  common_scripts\utility::flag_waitopen("_stealth_spotted");
  maps\nml_util::set_start_positions("start_post_crater_house");
  common_scripts\utility::flag_set("start_post_crater_house");
  level.player giveweapon("fraggrenade");
  maps\_hud_util::fade_in(0.25, "overlay_static");

  if(!isDefined(level.player.pre_dogcam_weapon))
    level.player.pre_dogcam_weapon = "honeybadger+acog_sp";

  level.player disableweaponswitch();
  level.player switchtoweapon(level.player.pre_dogcam_weapon);
  wait 0.5;
  level.player freezecontrols(0);
  wait 1;
  level.player takeweapon("remote_chopper_gunner");
  level.player enableweaponswitch();
  setdvar("hideHudFast", 0);
  setsaveddvar("ammoCounterHide", 0);
  common_scripts\utility::noself_delaycall(4, ::stopcinematicingame);
}

courtyard_guys_walla() {
  var_0 = maps\_utility::get_living_ai("balcony_guy", "script_noteworthy");
  var_1 = getaiarray("axis");
  var_2 = [];

  foreach(var_4 in var_1) {
    var_4 thread maps\_utility::set_battlechatter(0);

    if(var_4 != var_0) {
      var_2 = common_scripts\utility::array_add(var_2, var_4);

      if(!issubstr(var_4.model, "hazmat"))
        var_4.use_old_dog_attack = 1;
    }
  }

  thread maps\nml_util::group_walla(var_2, 3, 5);
}

courtyard_hazmat_guy_think() {
  thread maps\nml_util::hazmat_think("crouch");
}

post_crater_end() {
  maps\_utility::stop_exploder("church_sunflare");
  common_scripts\utility::flag_waitopen("_stealth_spotted");
  level.baker maps\nml_util::set_move_rate(1);
  level.slowmo_breach_start_delay = 0.5;
  level.slomobreachduration = 5.5;
  common_scripts\utility::flag_set("post_crater_1_clear");
  thread post_crater_breach_walla();
  wait 1;
  maps\_utility::autosave_by_name("nml");
  level.baker allowedstances("stand", "crouch", "prone");
  level.dog maps\nml_util::set_move_rate(1);
  level.dog maps\_utility_dogs::dyn_sniff_disable();
  maps\nml_util::team_unset_colors(128);
  maps\nml_util::hero_paths("post_crater_exit_path");
  thread post_crater_breach_dialogue();
  level.baker waittill("path_end_reached");
  maps\_utility::trigger_wait_targetname("post_crater_front_of_house");
  var_0 = common_scripts\utility::get_target_ent("pc_house_entrance_dog");
  var_1 = common_scripts\utility::get_target_ent("pc_house_baker_node");
  var_2 = common_scripts\utility::get_target_ent("post_crater_house_enemy_flee");
  var_3 = common_scripts\utility::get_target_ent("player_breach_node");
  thread pc_house_baker_get_ready(var_1);
  var_4 = maps\_player_rig::get_player_rig();
  var_4 hide();
  var_4.origin = var_3.origin;
  var_4.angles = var_3.angles;
  var_5 = level.player getcurrentweapon();
  level.player.prebreachcurrentweapon = var_5;

  if(level.player maps\_slowmo_breach::should_topoff_breach_weapon(var_5)) {
    var_6 = weaponclipsize(var_5);

    if(level.player getweaponammoclip(var_5) < var_6)
      level.player setweaponammoclip(var_5, var_6);
  }

  level.player.prebreachcurrentweapon = undefined;
  level.player thread maps\_utility::play_sound_on_entity("scn_nml_plr_weap_down");
  level.player disableweapons();
  level.player allowstand(0);
  level.player allowprone(0);
  level.player playerlinktoblend(var_4, "tag_origin", 0.75, 0.25, 0.5);
  level.player enableinvulnerability();
  level.player maps\_utility::delaythread(0.25, maps\_utility::play_sound_on_entity, "scn_nml_plr_stackup");
  wait 0.75;
  common_scripts\utility::flag_clear("start_earthquakes");
  level.player playerlinktodelta(var_4, "tag_origin", 0.5, 15, 15, 15, 15);
  var_7 = common_scripts\utility::get_target_ent("NML_window_smash_node");
  var_7 maps\_anim::anim_generic_reach(level.baker, "NML_window_smash");
  var_7 thread maps\_anim::anim_generic(level.baker, "NML_window_smash");
  var_7 thread hesh_breach_wait();
  maps\_utility::delaythread(2.7, common_scripts\utility::exploder, "house_prebreach");
  wait 2.8;
  level notify("begin dog breach");
  wait 0.75;
  level.dog maps\_utility::walkdist_zero();
  var_0 maps\_anim::anim_generic_reach(level.dog, "iw6_dog_traverse_over_36");
  thread pc_house_yells();
  thread delete_cracked_glass();
  var_8 = spawn("script_model", level.dog.origin);
  var_8 setModel("tag_origin");
  var_8 linkto(level.dog, "tag_camera", (0, 0, 0), (0, 0, 0));
  var_8 common_scripts\utility::delaycall(0.5, ::playsound, "scn_nml_house_enemy_mvmt_chaos");
  var_0 maps\_anim::anim_generic(level.dog, "iw6_dog_traverse_over_36");
  level.dog setgoalpos(level.dog.origin);
  maps\nml_util::team_unset_colors(32);
  level.dog maps\_utility::walkdist_reset();
  var_9 = common_scripts\utility::get_target_ent("pc_house_blocker");
  var_9 connectpaths();
  var_9 delete();
  wait 1.2;
  maps\_utility::array_spawn_function_targetname("crater_enemy_house_breach", ::pc_house_breach_think);
  maps\_utility::array_spawn_targetname("crater_enemy_house_breach");
  thread post_crater_house_door_crash();
  maps\_utility::delaythread(0.5, ::door_push);
  level waittill("door_knockdown");
  var_8 stopsounds();
  thread hesh_breach_melee();
  level.dog endon("death");
  common_scripts\utility::exploder("pc_house_breach_door");
  setsaveddvar("aim_autoAimRangeScale", "0");
  level.dog.idlelookattargets = undefined;
  level.baker maps\_utility::disable_pain();
  level.player allowstand(1);
  level.player allowprone(1);
  setsaveddvar("ai_friendlyFireBlockDuration", 0);
  thread maps\_slowmo_breach::slowmo_begins();
  maps\_art::dof_enable_script(1, 1, 5, 2, 150, 5, 0.1);
  maps\_utility::delaythread(0.5, maps\_art::dof_disable_script, 1);
  level.player playerlinktodelta(var_4, "tag_origin", 0.8, 60, 60, 90, 90);
  var_7 = var_3 common_scripts\utility::get_target_ent();
  var_10 = 1;
  var_11 = 0.15;
  var_4 maps\_utility::delaythread(var_11, maps\nml_util::moveto_rotateto, var_7, var_10, 0.5, 0);
  level.player common_scripts\utility::delaycall(var_10 + var_11, ::unlink);
  level.player common_scripts\utility::delaycall(var_10 + var_11, ::disableinvulnerability);
  var_7 = common_scripts\utility::get_target_ent("baker_post_breach_node");
  level.baker common_scripts\utility::delaycall(1.25, ::setgoalnode, var_7);
  level.player common_scripts\utility::delaycall(0.75, ::enableweapons);
  common_scripts\utility::flag_wait("pc_house_baker_ready");
  wait 0.05;
  maps\nml_util::volume_waittill_no_axis("post_crater_volume");
  var_8 delete();
  level.dog.melee = undefined;
  level.dog thread maps\_utility::magic_bullet_shield();
  setsaveddvar("aim_autoAimRangeScale", "1");
  thread maps\nml_util::ragdoll_corpses();
  maps\_art::dof_disable_script(1);
  thread post_crater_breach_dialogue_2();
  maps\nml_util::team_unset_colors(196);
  level.baker maps\_utility::enable_cqbwalk();
  setsaveddvar("ai_friendlyFireBlockDuration", 2000);
  level.baker maps\_utility::enable_pain();
  common_scripts\utility::flag_wait("house_breach_melee_done");
  var_7 = common_scripts\utility::get_target_ent("pc_house_breach_exit");
  var_7 thread maps\_anim::anim_generic_gravity(level.baker, "corner_standR_trans_CQB_OUT_8");
  maps\nml_util::hero_paths("sat_entrance_path", 300, 300, 300, 0, 2.5);

  if(getdvarint("e3", 0)) {
    level.baker maps\_utility::disable_cqbwalk();
    wait 1.6;
    level.baker waittill("goal");
    wait 1.5;
    maps\_utility::trigger_wait_targetname("nml_mask_trigger");
    var_7 = common_scripts\utility::get_target_ent("nml_mask_node");
    var_7 maps\_anim::anim_generic_reach(level.baker, "NML_mask_pulldown");
    var_7 thread maps\_anim::anim_generic_first_frame(level.baker, "NML_mask_pulldown");
    thread hesh_mask_dialogue(var_7);
  } else if(getdvarint("jimmy", 0)) {
    maps\_hud_util::fade_out(2);
    level.player freezecontrols(1);
  }
}

hesh_breach_wait() {
  self waittill("NML_window_smash");
  thread maps\_anim::anim_generic_loop(level.baker, "NML_window_wait");
}

delete_cracked_glass() {
  maps\_utility::trigger_wait("house_prebreach_glass_destroy", "script_noteworthy");
  var_0 = getent("house_prebreach_glass", "script_noteworthy");
  var_0 delete();
}

post_crater_breach_walla() {
  var_0 = getEntArray("crater_enemy_house_breach", "targetname");
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = var_0[0].origin;
  var_1 playLoopSound("scn_nml_house_enemy_mvmt_lp");
  thread scn_nml_house_enemy_mvmt_lp_death(var_1);
  wait 2;
  var_2 = var_0[0];
  common_scripts\utility::play_sound_in_space("nml_saf2_perdimoscontactocondos", var_0[0].origin);
  wait 0.5;
  common_scripts\utility::play_sound_in_space("nml_saf1_cules", var_0[0].origin);
  wait 0.5;
  common_scripts\utility::play_sound_in_space("nml_saf2_elequipo7y", var_0[0].origin);
  wait 0.5;
  thread common_scripts\utility::play_sound_in_space("nml_saf1_quevayarodrigocon", var_0[0].origin);
}

scn_nml_house_enemy_mvmt_lp_death(var_0) {
  level waittill("stop_house_sounds");
  var_0 stoploopsound();
  wait 0.5;
  var_0 delete();
}

hesh_breach_melee() {
  common_scripts\utility::flag_init("house_breach_melee_done");
  wait 0.2;
  var_0 = maps\_utility::spawn_targetname("crater_enemy_house_melee");
  var_0.ignoreme = 1;
  var_1 = common_scripts\utility::get_target_ent("NML_window_smash_node");
  var_0.animname = "victim";
  level.baker.animname = "hesh";
  var_1 notify("stop_loop");
  var_1 maps\_anim::anim_single([level.baker, var_0], "breach_melee");
  var_0.allowdeath = 1;
  var_0.a.nodeath = 1;
  var_0 kill();
  common_scripts\utility::flag_set("house_breach_melee_done");
}

speed_up_slow_mo() {
  wait 0.25;
  maps\_utility::slowmo_setspeed_slow(0.5);
  maps\_utility::slowmo_setlerptime_in(0.25);
  maps\_utility::slowmo_lerp_in();
}

hesh_mask_dialogue(var_0) {
  wait 0.5;
  level.baker maps\_utility::smart_dialogue("nml_hsh_wereinposition");
  wait 0.5;
  level.baker maps\_utility::smart_dialogue("nml_hsh_ok");
  wait 0.35;
  var_0 thread maps\_anim::anim_generic_gravity(level.baker, "NML_mask_pulldown");
  level.baker thread track_player_for_time(1.3);
  wait 1.5;
  level.player thread maps\_utility::play_sound_on_entity("scn_nml_mask_on_plr");
  player_pulls_mask_down();
}

player_pulls_mask_down() {
  var_0 = maps\_player_rig::get_player_rig();
  var_0.origin = level.player.origin;
  var_0.angles = level.player.angles;
  var_0 maps\_anim::anim_first_frame_solo(var_0, "mask_puton");
  wait 0.1;
  level.player playerlinktoblend(var_0, "tag_player", 0.5, 0.1, 0.1);
  level.player disableweapons();
  level.player allowcrouch(0);
  level.player allowprone(0);
  var_0 show();
  wait 0.4;
  maps\_art::dof_enable_script(0, 0, 10, 15, 40, 6, 0.25);
  setsaveddvar("r_znear", 0.001);
  var_0 thread maps\_anim::anim_single_solo(var_0, "mask_puton");
  wait 1;
  var_1 = maps\_hud_util::create_client_overlay("overlay_mask_edge", 1, level.player);
  var_1.y = var_1.y - 1000;
  var_1 moveovertime(0.5);
  var_1.y = 0;
  wait 0.2;
  level.player setclienttriggeraudiozone("nml_house3_fadeout_for_e3", 0.2);
  maps\_hud_util::fade_out(0.3);
  wait 18;
  maps\_utility::nextmission();
}

post_crater_breach_dialogue() {
  level endon("begin dog breach");
  level.baker maps\_utility::smart_dialogue("nml_hsh_letsmove");
  wait 2;
  level.baker maps\_utility::smart_dialogue("nml_hsh_soundslikemoreinside");
  wait 1;
  level.baker maps\_utility::smart_dialogue("nml_hsh_stackup");
}

post_crater_breach_dialogue_2() {
  level.baker maps\_utility::smart_dialogue("nml_hsh_clear_5");
  wait 0.75;
  level.baker maps\_utility::smart_dialogue("nml_hsh_onme_2");
}

pc_house_breach_think() {
  thread maps\_utility::set_battlechatter(0);

  if(isDefined(self.target) && self.target == "dog_breach_dog") {
    maps\_utility::forceuseweapon("p226", "sidearm");
    maps\_utility::add_damage_function(maps\_slowmo_breach::record_last_player_damage);
    thread maps\_slowmo_breach::breach_enemy_ignored_by_friendlies();
    thread maps\_slowmo_breach::breach_enemy_ragdoll_on_death();
    level thread maps\_slowmo_breach::breach_enemy_track_status(self);
    level waittill("door_knockdown");
    self endon("death");
    wait 0.1;
    self.animname = "victim";
    level.dog.animname = "dog";
    var_0 = common_scripts\utility::get_target_ent();
    self.health = 1;
    self.allowdeath = 1;
    self.a.nodeath = 1;
    thread release_dog_on_death();
    level.dog.allowpain = 1;
    level.dog.allowdeath = 1;
    thread maps\nml_util::mission_fail_on_dog_death(&"NML_HINT_CAIRO_DEATH");
    var_0 thread maps\_anim::anim_single([self, level.dog], "dog_attack_kill");
    level.dog thread animscripts\shared::donotetracks("single anim", maps\nml_dogattacks::handlevxnotetrack);
    wait 3;
    self kill();
  } else {
    self endon("death");
    thread maps\_slowmo_breach::breach_enemy_spawner_think();
    wait 1;
    self getenemyinfo(level.player);
    self setgoalpos(self.origin);
    self.fixednode = 0;
    self.goalradius = 1024;
  }
}

release_dog_on_death() {
  level.dog endon("death");
  self waittill("death");
  level.dog maps\_anim::anim_generic_gravity(level.dog, "dog_attack_kill_end");
  level.dog setgoalpos(level.dog.origin);
  level.dog.idlelookattargets = [level.player];
}

pc_house_yells() {
  level.dog maps\_utility::delaythread(0.5, maps\_utility::play_sound_on_entity, "nml_saf2_unmomentooyeneso");
  level.dog maps\_utility::delaythread(1, maps\_utility::play_sound_on_entity, "nml_saf1_qucooeseso");
  level.dog maps\_utility::delaythread(1.5, maps\_utility::play_sound_on_entity, "nml_saf1_salgandeaquya");
  level.dog maps\_utility::play_sound_on_entity("anml_dog_bark");
  wait 0.1;
  level.dog maps\_utility::play_sound_on_entity("anml_dog_bark");
  wait 0.1;
  level notify("stop_house_sounds");
}

pc_house_baker_get_ready(var_0) {
  common_scripts\utility::flag_init("pc_house_baker_ready");
  level.baker setgoalnode(var_0);
  level.baker waittill("goal");
  level.baker.ignoreall = 1;
  wait 2;
  common_scripts\utility::flag_set("pc_house_baker_ready");
}

pc_house_fall() {
  common_scripts\utility::flag_wait("pc_house_baker_ready");
  var_0 = maps\_utility::spawn_targetname("crater_enemy_house_fall");
  var_1 = common_scripts\utility::get_target_ent("pc_house_enemy_fall");
  var_0 thread maps\_utility::set_battlechatter(0);
  var_0.allowpain = 1;
  var_0.allowdeath = 1;
  level.dog maps\nml_util::set_move_rate(1);
  level.dog setgoalentity(var_0);
  var_1 maps\_anim::anim_generic_gravity(var_0, "run_pain_fall");
}

pc_house_melee(var_0) {
  common_scripts\utility::flag_wait("pc_house_baker_ready");
  var_1 = maps\_utility::spawn_targetname("crater_enemy_house");
  var_1 maps\_utility::set_battlechatter(0);
  var_1 maps\_utility::disable_exits();
  var_1.ignoreme = 1;
  var_1 maps\_utility::set_generic_run_anim("flee_run_shoot_behind");
  thread post_crater_house_door_crash();
  var_0 maps\_anim::anim_generic_reach(var_1, "cornerSdR_melee_winD_attacker");
  var_0 thread maps\_anim::anim_generic(level.baker, "cornerSdR_melee_winD_defender");
  var_0 maps\_anim::anim_generic(var_1, "cornerSdR_melee_winD_attacker");
}

post_crater_house_door_crash() {
  var_0 = common_scripts\utility::get_target_ent("pc_house_door_trig");
  var_0 waittill("trigger");
  var_1 = getEntArray("pc_house_door", "targetname");
  thread common_scripts\utility::play_sound_in_space("scn_nml_house_door_burst", var_1[0].origin);
  common_scripts\utility::array_thread(var_1, ::door_knockdown);
  level notify("door_knockdown");
}

door_push() {
  var_0 = getEntArray("pc_house_door", "targetname");
  thread common_scripts\utility::play_sound_in_space("wood_door_kick", var_0[0].origin);
  common_scripts\utility::exploder("pc_house_door_nudge");
  common_scripts\utility::array_thread(var_0, ::door_nudge);
}

door_nudge() {
  var_0 = spawnStruct();
  var_0.origin = self.origin;
  var_0.angles = self.angles;
  var_1 = common_scripts\utility::get_target_ent();
  maps\nml_util::moveto_rotateto(var_1, 0.1, 0.1, 0);
  maps\nml_util::moveto_rotateto(var_0, 0.2, 0, 0.1);
}

door_knockdown() {
  var_0 = common_scripts\utility::get_target_ent();
  self delete();
}

door_knockback(var_0, var_1) {
  var_2 = anglesToForward(var_1.angles);
  var_3 = var_0 common_scripts\utility::get_target_ent();
  var_3 hide();
  var_0 maps\nml_util::moveto_rotateto_speed(var_3, 120, 0, 0.2);
  var_0 physicslaunchclient(var_1.origin, var_2 * 350);
}

nh90_unload() {
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("satellite_heli");
  var_0 vehicle_turnengineoff();
  var_0 playLoopSound("scn_nml_heli_post_house_lp");
  common_scripts\utility::flag_wait("satellite_overlook_1");
  var_1 = common_scripts\utility::get_target_ent("sat_heli_unload");
  wait 5;
  var_0 scalevolume(0, 4);
  var_0 thread maps\_utility::play_sound_on_entity("scn_nml_heli_post_house_move");
  var_0 maps\_vehicle::vehicle_paths(var_1);
  var_0 delete();
}

sat_combat() {
  level.dog endon("death");

  if(!isDefined(level.dog) || !isalive(level.dog)) {
    return;
  }
  common_scripts\utility::flag_set("start_earthquakes");
  maps\_utility::array_spawn_targetname("sat_combat_starters");
  common_scripts\utility::flag_set("_stealth_spotted");
  setsaveddvar("ai_friendlyFireBlockDuration", 2000);
  maps\nml_stealth::disable_stealth();
  level.baker maps\_utility::delaythread(8, maps\_utility::set_ignoreall, 0);
  maps\_utility::trigger_wait_targetname("satellite_combat_start");
  setsaveddvar("ai_friendlyFireBlockDuration", 0);
  level.baker maps\_utility::disable_pain();
  level.dog maps\_utility::disable_pain();
  level.baker.ignoresuppression = 1;
  level.baker.ignoreall = 0;
  level.dog.idlelookattargets = undefined;
  level.baker.baseaccuracy = 0.5;
  wait 1;
  thread sat_dialogue();
  maps\_utility::display_hint_timeout("hint_dog_attack_3p", 10);
  common_scripts\utility::flag_wait("satellite_overlook_1");
  level.baker.baseaccuracy = 0.8;
  level.baker maps\_utility::enable_pain();
  level.dog maps\_utility::enable_pain();
  level.baker.ignoresuppression = 0;
  setsaveddvar("ai_friendlyFireBlockDuration", 2000);
}

sat_dialogue() {
  level.baker thread maps\_utility::smart_dialogue("nml_hsh_contactfront_2");
  wait 0.75;
  common_scripts\utility::flag_wait("start_sat_combat");
  level.baker maps\_utility::smart_dialogue("nml_hsh_thisisdefinitelythe");
  wait 2.5;
  level.baker maps\_utility::smart_dialogue("nml_hsh_delta11weare");
  wait 1;
  maps\_utility::smart_radio_dialogue("nml_mrk_copykeepusupdated");
  wait 1.25;
  level.baker maps\_utility::smart_dialogue("nml_hsh_weveencounteredlightenemy");
  maps\_utility::autosave_by_name("nml");
  maps\_utility::trigger_wait_targetname("sat_combat_room");
  maps\_utility::music_stop(6);
  maps\_utility::smart_radio_dialogue("nml_mrk_stalkerweregettingreports");
  maps\_utility::autosave_by_name("nml");
  wait 0.5;
  maps\_utility::smart_radio_dialogue("nml_mrk_ifyouhurryyou");
  wait 1;
  level.baker maps\_utility::smart_dialogue("nml_hsh_rogerthat");
  wait 1.5;
  level.baker maps\_utility::smart_dialogue("nml_hsh_adamletsmove");
}

transition_to_tunnel() {
  level endon("baker_stop_going_to_slide");
  level endon("baker_started_slide");
  level.baker maps\_utility::disable_cqbwalk();
  level.dog maps\nml_util::set_move_rate(1);
  level.dog maps\_utility::disable_ai_color();
  level.baker maps\_utility::disable_ai_color();
  maps\nml_util::hero_paths("tunnel_enter_path", 300, 300, 300, 0, 3);
  wait 0.5;
  var_0 = common_scripts\utility::get_target_ent("satellite_slide_node");
  var_0 maps\_anim::anim_generic_reach(level.baker, "NML_slide_left");
  common_scripts\utility::flag_set("baker_started_slide");
}

tunnel_slide() {
  var_0 = common_scripts\utility::get_target_ent("satellite_slide_node");
  common_scripts\utility::flag_wait_either("baker_started_slide", "start_tunnel");

  if(!common_scripts\utility::flag("baker_started_slide")) {
    level.dog forceteleport(var_0.origin, var_0.angles);
    common_scripts\utility::flag_set("baker_started_slide");
    maps\_anim::anim_reach_cleanup_solo(level.baker);
  }

  common_scripts\utility::flag_wait("baker_started_slide");
  level notify("baker_stop_going_to_slide");
  level.baker thread maps\nml_util::slide_sounds("NML_slide_left");
  var_0 thread maps\_anim::anim_generic(level.baker, "NML_slide_left");
  wait 1;
  maps\nml_util::hero_paths("tunnel_enter_path", 300, 300, 300, 0, 1);
}

sat_crane_arm() {
  var_0 = common_scripts\utility::get_target_ent("sat_crane_arm");
  common_scripts\utility::flag_wait("satellite_overlook_1");
  var_0 rotateyaw(-45, 5, 1, 2);
  var_0 waittill("rotatedone");
  wait 2;

  for(;;) {
    var_0 rotateyaw(90, 5, 1, 2);
    var_0 waittill("rotatedone");
    wait(randomfloatrange(3, 10));
    var_0 rotateyaw(-90, 5, 1, 2);
    var_0 waittill("rotatedone");
  }
}

tunnel_enter() {
  maps\_utility::music_stop(3);
  maps\nml_util::team_unset_colors(128);
  level.baker maps\_utility::enable_cqbwalk();
  thread maps\nml_util::hero_paths("tunnel_enter_path");
  level.dog maps\nml_util::set_move_rate(0.7);
  common_scripts\utility::flag_wait("convoy_start_walk");
  wait 0.75;
  level.baker maps\_utility::smart_dialogue("nml_hsh_youhearthat");
  wait 2.75;
  level.baker thread maps\_utility::smart_dialogue("nml_hsh_enemyconvoygetto");
  level.baker stopanimscripted();
  level.baker notify("stop_path");
  level.baker maps\_utility::disable_cqbwalk();
  maps\nml_util::team_unset_colors(32);
  var_0 = common_scripts\utility::get_target_ent("hesh_tunnel_pos_1");
  level.baker setgoalnode(var_0);
  level.baker waittill("goal");
  wait 1.5;
  level.baker maps\_utility::smart_dialogue("nml_hsh_shittherestoomany");
  wait 1.5;
  var_0 = common_scripts\utility::get_target_ent("hesh_tunnel_pos_2");
  level.baker setgoalnode(var_0);
  level.baker thread maps\_utility::smart_dialogue("nml_hsh_thiswaymove");
  level.baker waittill("goal");
  var_0 thread maps\_anim::anim_generic(level.baker, "stand_2_prone");
  level.baker maps\_utility::set_generic_idle_anim("prague_prone_idle");
  level.baker allowedstances("prone");
  var_1 = common_scripts\utility::get_noteworthy_ent("tunnel_sight_blocker");
  var_1 common_scripts\utility::delaycall(3.5, ::delete);
  var_2 = common_scripts\utility::get_target_ent("tunnel_cairo_teleport");
  level.dog.ignoreall = 1;
  level.dog forceteleport(var_2.origin, var_2.angles);
  level.dog setgoalpos(var_2.origin);
  var_0 = common_scripts\utility::get_target_ent("hesh_tunnel_pos_3");
  level.baker.ignoreall = 1;
  level.baker.goalradius = 16;
  level.baker setgoalpos(var_0.origin);
  thread baker_crawl_dialogue();
  level.baker waittill("goal");
  common_scripts\utility::flag_wait("tunnel_player_ready_to_jump");
  thread maps\_utility::add_dialogue_line("Hesh", "Shit.We're gonna have to jump.");
  wait 1.5;
  thread maps\_utility::add_dialogue_line("Hesh", "I'll go first...");
  thread player_jump_hint();
  var_3 = common_scripts\utility::get_target_ent("nml_pipe_jump");
  var_3 maps\_anim::anim_generic_reach(level.baker, "nml_pipe_jump");
  var_3 maps\_anim::anim_generic(level.baker, "nml_pipe_jump");
  level.baker thread maps\_utility::play_sound_on_entity("nml_plr_pipe_land");
  var_3 thread maps\_anim::anim_generic_loop(level.baker, "nml_pipe_jump_idle");
  var_0 = common_scripts\utility::get_target_ent("hesh_tunnel_pos_4");
  level.baker.ignoreall = 1;
  level.baker.goalradius = 16;
  level.baker setgoalpos(var_0.origin);
  thread baker_post_jump_dialogue();
  wait 5;
  var_3 thread maps\_anim::anim_generic(level.baker, "nml_pipe_jump_out");
  var_3 notify("stop_loop");
  level.baker waittill("goal");
  common_scripts\utility::flag_wait("tunnel_tank_crush_done");
  level.baker thread maps\_utility::smart_dialogue("nml_hsh_okcrawloutslowly");
  level.baker allowedstances("crouch");
  level.baker maps\_utility::clear_generic_idle_anim();
  level.baker thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("tunnel_hesh_crawl_exit"), 150);
  common_scripts\utility::flag_wait("tunnel_exit");
  thread tunnel_exit_dialogue();
  maps\nml_util::volume_waittill_no_axis("tunnel_exit_volume");
  level notify("tunnel_exit_clear");
  level.baker thread maps\_utility::smart_dialogue("nml_hsh_okletsgo");
  level.baker allowedstances("stand", "crouch", "prone");
  maps\nml_util::team_unset_colors(196);
  maps\nml_util::hero_paths("tunnel_exit_path");
}

player_jump_hint() {
  level endon("player_jumped");
  common_scripts\utility::flag_wait("tunnel_player_tell_to_jump");
  thread maps\_utility::add_dialogue_line("Hesh", "Ok, that's good enough.");
  wait 3;
  thread maps\_utility::add_dialogue_line("Hesh", "Jump!");
}

baker_post_jump_dialogue() {
  thread maps\_utility::add_dialogue_line("Hesh", "Shit!");
  wait 1;
  thread maps\_utility::add_dialogue_line("Hesh", "This isn't going to hold...");
  wait 1.5;
  thread maps\_utility::add_dialogue_line("Hesh", "Go find another way around...");
}

tunnel_pipe_logic() {
  for(;;) {
    common_scripts\utility::flag_wait("player_on_tunnel_pipes");
    thread player_force_prone_recover();
    level.player thread maps\_utility::player_speed_percent(80, 2);
    var_0 = common_scripts\utility::spawn_tag_origin();
    wait(randomfloatrange(0.2, 1));
    level.player playersetgroundreferenceent(var_0);
    thread tunnel_pipe_quake(var_0);
    thread tunnel_pipe_sway(var_0);
    common_scripts\utility::flag_waitopen("player_on_tunnel_pipes");
    level.player thread maps\_utility::player_speed_percent(100, 2);
    var_0 notify("stop_sway");
    var_0 rotateto((0, 0, 0), 0.5);
    wait 0.5;
    level.player playersetgroundreferenceent(undefined);
    var_0 delete();
  }
}

tunnel_pipe_quake(var_0) {
  var_0 endon("stop_sway");

  for(;;) {
    var_1 = randomfloatrange(0.1, 0.3);
    earthquake(0.1, var_1 * 2, level.player.origin, 512);
    wait(var_1);
  }
}

tunnel_pipe_sway(var_0) {
  var_0 endon("stop_sway");
  var_1 = common_scripts\utility::get_target_ent("tunnel_pipes_pitch_trig");
  var_2 = 2;
  var_3 = 3;

  if(level.player istouching(var_1))
    var_0 rotateto((var_2, 0, 0), var_3, var_3 * 0.3, var_3 * 0.3);
  else
    var_0 rotateto((0, 0, var_2), var_3, var_3 * 0.3, var_3 * 0.3);

  var_0 waittill("rotatedone");

  for(;;) {
    if(level.player istouching(var_1)) {
      var_4 = (-2 * var_2, 0, 0);
      var_5 = (2 * var_2, 0, 0);
    } else {
      var_4 = (0, 0, -2 * var_2);
      var_5 = (0, 0, 2 * var_2);
    }

    var_0 rotateto(var_4, var_3, var_3 * 0.3, var_3 * 0.3);
    var_0 waittill("rotatedone");

    if(level.player istouching(var_1)) {
      var_4 = (-2 * var_2, 0, 0);
      var_5 = (2 * var_2, 0, 0);
    } else {
      var_4 = (0, 0, -2 * var_2);
      var_5 = (0, 0, 2 * var_2);
    }

    var_0 rotateto(var_5, var_3, var_3 * 0.3, var_3 * 0.3);
    var_0 waittill("rotatedone");
  }
}

tunnel_spotted_trigger() {
  var_0 = common_scripts\utility::get_target_ent("tunnel_spotted_trigger");
  var_0 waittill("trigger");
  maps\nml_stealth::player_set_spotted();
}

tunnel_player_jump_trigger() {
  self waittill("trigger");
  level notify("player_jumped");
  thread player_force_prone_recover();
  wait 0.1;
  earthquake(0.5, 1.5, level.player.origin, 512);
  level.player thread maps\_utility::play_sound_on_entity("nml_plr_pipe_land");
  level.player thread maps\_utility::play_sound_on_entity("nml_plr_pipe_land_ext");
  level.player thread maps\_utility::player_speed_percent(10, 0.1);
  level.player disableweapons();
  wait 1;
  level.player thread maps\_utility::player_speed_percent(80, 1);
  level.player enableweapons();
}

player_force_prone_recover() {
  level.player allowprone(1);
  level.player allowstand(0);
  level.player allowcrouch(0);
  level.player setstance("prone");
  wait 1;
  level.player allowstand(1);
  level.player allowcrouch(1);
}

tunnel_pipe_fall() {
  for(;;) {
    level waittill("pipe_fall", var_0);
    thread common_scripts\utility::play_sound_in_space("nml_pipe_break", var_0);
    thread common_scripts\utility::play_sound_in_space("nml_pipe_breakoff", var_0);
    earthquake(0.5, 1.5, var_0, 1024);
    maps\_utility::delaythread(0.8, common_scripts\utility::play_sound_in_space, "nml_pipe_clang", var_0 - (0, 0, 200));
    wait 1;
  }
}

tunnel_pipe_trigger() {
  self endon("fall");
  self.brushmodels = getEntArray(self.target, "targetname");
  var_0 = 8.0;
  var_1 = randomfloatrange(0.5, 0.9) * var_0;

  while(var_0 > var_1) {
    self waittill("trigger", var_2);
    var_3 = var_2 getvelocity();

    if(var_3[2] < -50) {
      var_0 = var_0 - 4;
      wait 0.25;
    } else
      var_0 = var_0 - 0.05;

    wait 0.05;
  }

  thread pipe_warning_shift();
  thread pipe_warning_fx();

  while(var_0 > 2.5) {
    self waittill("trigger", var_2);
    var_3 = var_2 getvelocity();

    if(var_3[2] < -50) {
      var_0 = var_0 - 4;
      wait 0.25;
    } else
      var_0 = var_0 - 0.05;

    wait 0.05;
  }

  pipe_warning_shift();
  wait 0.3;
  thread pipe_warning_shift();
  thread pipe_warning_fx();

  while(var_0 > 0) {
    self waittill("trigger", var_2);
    var_3 = var_2 getvelocity();

    if(var_3[2] < -50) {
      var_0 = var_0 - 4;
      wait 0.25;
    } else
      var_0 = var_0 - 0.05;

    wait 0.05;
  }

  thread tunnel_pipe_trigger_fall(1);
}

pipe_warning_shift() {
  thread common_scripts\utility::play_sound_in_space("nml_pipe_break", self.origin);
  earthquake(0.3, 0.5, self.origin, 1024);

  foreach(var_1 in self.brushmodels) {
    var_1 movez(-1 * randomfloatrange(1, 2), randomfloatrange(0.1, 0.2));
    var_1 rotateto((randomfloatrange(-1.5, 1.5), 0, randomfloatrange(-1, 1)), randomfloatrange(0.1, 0.2));
    wait 0.05;
  }
}

pipe_warning_fx() {
  var_0 = common_scripts\utility::getstructarray(self.target, "targetname");

  foreach(var_2 in var_0)
  common_scripts\utility::noself_delaycall(randomfloatrange(0, 0.5), ::playfx, common_scripts\utility::getfx("pipe_dust"), var_2.origin);
}

tunnel_pipe_trigger_fall(var_0) {
  self notify("fall");

  if(var_0) {
    level notify("pipe_fall", self.origin);
    var_1 = getEntArray("tunnel_pipe_trigger", "targetname");

    foreach(var_3 in var_1) {
      if(var_3 != self) {
        if(var_3 istouching(level.player))
          var_3 thread tunnel_pipe_trigger_fall(0);
      }
    }
  }

  pipe_warning_fx();

  foreach(var_6 in self.brushmodels) {
    var_6 movegravity((0, 0, -10), 20);
    var_6 rotatevelocity((50, 50, 50), 10, 0, 0);
    wait 0.15;
    var_6 notsolid();
  }
}

baker_crawl_dialogue() {
  wait 3;
  thread maps\_utility::add_dialogue_line("Hesh", "Easy... easy... ");
  wait 2.5;
  thread maps\_utility::add_dialogue_line("Hesh", "Just stay low, and keep moving forward...");
  wait 1.5;
  thread maps\_utility::add_dialogue_line("Hesh", "We wouldn't want these pipes to break on us...");
  wait 1.5;
}

tunnel_exit_dialogue() {
  level endon("tunnel_exit_clear");
  wait 2;
  level.baker maps\_utility::smart_dialogue("nml_hsh_theresalookouton");
  wait 0.7;
  level.baker maps\_utility::smart_dialogue("nml_hsh_takehimoutor");
}

tunnel_convoy() {
  var_0 = maps\_utility::array_spawn_targetname("tunnel_guys_1");
  var_1 = maps\_vehicle::spawn_vehicles_from_targetname("tunnel_convoy_vehicles");
  var_2 = common_scripts\utility::get_target_ent("tunnel_btr_light");
  var_3 = var_2 common_scripts\utility::spawn_tag_origin();
  var_3.angles = var_2.angles;

  foreach(var_5 in var_1) {
    if(isDefined(var_5.script_noteworthy)) {
      if(var_5.script_noteworthy == "tunnel_lead_vehicle")
        var_3 linkto(var_5);
    }
  }

  var_2 thread follow_origin(var_3);
  var_2 thread light_fade();
  thread convoy_start_walk(var_1);
}

convoy_start_walk(var_0) {
  common_scripts\utility::flag_wait("convoy_start_walk");

  foreach(var_2 in var_0) {
    if(var_2.model == "vehicle_btr80") {
      var_2 maps\_utility::delaythread(4, ::dlight_on_me, "TAG_FRONT_LIGHT_RIGHT");
      var_2 maps\_vehicle::build_rumble_unique("subtle_tank_rumble", 0.3, 4.5, 300, 1, 1);
    }

    if(var_2.model == "vehicle_t90_tank_woodland") {
      var_2 maps\_utility::delaythread(4, ::dlight_on_me, "TAG_FRONT_LIGHT_LEFT");
      var_2 thread tunnel_tank_crush();
    }

    var_2 thread maps\_vehicle::gopath();
    var_2 thread tunnel_vehicle_think();
    var_2 thread maps\nml_util::vehicle_rumble_even_if_not_moving();
  }
}

follow_origin(var_0) {
  self endon("stop_follow");

  for(;;) {
    self.origin = var_0.origin;
    self.angles = var_0.angles;
    wait 0.05;
  }
}

light_fade() {
  var_0 = self.old_intensity;
  self setlightintensity(0);
  common_scripts\utility::flag_wait("convoy_start_walk");

  for(var_1 = self getlightintensity(); self getlightintensity() < var_0; var_1 = self getlightintensity()) {
    self setlightintensity(min(var_1 + 0.1, var_0));
    wait 0.1;
  }

  wait 5;

  for(var_1 = self getlightintensity(); self getlightintensity() > 0; var_1 = self getlightintensity()) {
    self setlightintensity(max(var_1 - 0.1, 0));
    wait 0.15;
  }
}

dlight_on_me(var_0) {
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = self gettagorigin(var_0);
  var_1.angles = self gettagangles(var_0);
  self.dlight_org = var_1;
  self.dlight_org.tag = var_0;
  var_2 = anglesToForward(var_1.angles);
  var_1.origin = var_1.origin + var_2 * 350;
  var_1 linkto(self);
  playFXOnTag(common_scripts\utility::getfx("btr_light_fadein"), var_1, "tag_origin");
  wait 3;
  stopFXOnTag(common_scripts\utility::getfx("btr_light_fadein"), var_1, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("btr_light"), var_1, "tag_origin");
  self waittill("death");
  var_1 delete();
}

tunnel_guys_think() {
  level endon("start_grass");
  self endon("death");
  self.pathrandompercent = 0;
  maps\_utility::ent_flag_waitopen("_stealth_normal");
  maps\nml_stealth::player_set_spotted();
}

tunnel_vehicle_think() {
  self endon("death");
  self endon("cancel_spotted_reaction");
  thread maps\nml_util::btr_attack_player_on_flag("_stealth_spotted");

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(var_1 == level.player) {
      maps\nml_stealth::player_set_spotted();
      break;
    }
  }
}

tunnel_tank_crush() {
  level endon("_stealth_spotted");
  var_0 = getent("tankcrush_car", "targetname");
  var_1 = self;
  var_1 maps\_vehicle::godon();
  var_2 = getvehiclenode("tunnel_tankcrush", "script_noteworthy");
  var_2 waittill("trigger");
  var_1 vehicle_setspeed(0, 999999999, 999999999);
  var_3 = getvehiclenode("tunnel_tankcrush_2", "targetname");
  var_1 resumespeed(5);
  var_1 notify("newpath");
  var_1 vehicle_scripts\_tank_crush::tank_crush(var_0, var_3, level.scr_anim["tank"]["tank_crush"], level.scr_anim["truck"]["tank_crush"], level.scr_animtree["tank_crush"], level.scr_sound["tank_crush"], 0.6);
  var_1 resumespeed(5);
  var_1 notify("dummy_2_model");
  common_scripts\utility::flag_set("tunnel_tank_crush_done");
  var_1 maps\_vehicle::gopath();
}

link_dlight_to_dummy() {
  common_scripts\utility::waitframe();
  self.dlight_org linkto(self.modeldummy, self.dlight_org.tag);
  self waittill("dummy_2_model");
  self.dlight_org linkto(self, self.dlight_org.tag);
}

mall_spotted() {
  level.player endon("death");
  level.dog endon("death");
  level endon("start_dog_hunt");
  childthread instant_spotted();
  common_scripts\utility::flag_wait("_stealth_spotted");
  level.baker.ignoreme = 0;
  level.baker.ignoreall = 0;
  level.baker.dontevershoot = undefined;
  level.dog.ignoreme = 0;
  level.dog.ignoreall = 0;
  level.baker maps\_utility::set_ai_bcvoice("taskforce");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    var_2.ignoreme = 0;
    var_2.dontattackme = undefined;
  }

  thread mall_spotted_kill();
}

mall_spotted_kill() {
  level.player endon("death");
  level.dog endon("death");
  level.cansave = 0;
  level.baker thread maps\_utility::smart_dialogue("nml_hsh_werespottedtakeem");
  level.player enablehealthshield(0);
  thread maps\nml_util::mission_fail_on_dog_death(&"NML_FAIL_SPOTTED");
  wait 5;
  level.dog kill();
}

instant_spotted() {
  level notify("instant_spotted");
  level endon("instant_spotted");
  level endon("start_dog_hunt");

  for(;;) {
    while(maps\_stealth_utility::stealth_is_everything_normal())
      wait 0.05;

    wait 1;

    if(maps\_stealth_utility::stealth_is_everything_normal()) {
      continue;
    }
    break;
  }

  maps\nml_stealth::player_set_spotted();
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    var_2 notify("stop_path");
    var_2 notify("end_patrol");
    var_2 getenemyinfo(level.player);
    var_2 setgoalentity(level.player);
  }
}

mall_sniper() {
  level endon("tunnel_exit_clear");

  if(!common_scripts\utility::flag("tunnel_exit_clear"))
    maps\nml_stealth::player_set_spotted();
}

mall_heli() {
  thread mall_heli_think("mall_heli", "mall_heli_leave_node", 1.5, "scn_nml_heli2_post_tunnel");
  thread mall_heli_think("mall_heli_2", "mall_heli_leave_node_2", 0, "scn_nml_heli1_post_tunnel");
}

mall_heli_think(var_0, var_1, var_2, var_3) {
  var_4 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(var_0);
  common_scripts\utility::flag_wait("mall_heli_go");
  wait(var_2);
  var_5 = common_scripts\utility::get_target_ent(var_1);
  var_4 vehicle_turnengineoff();
  var_4 thread maps\_utility::play_sound_on_entity(var_3);
  var_4 maps\_vehicle::vehicle_paths(var_5);
}

vargas_think() {}

mall_btrs() {
  var_0 = maps\_vehicle::spawn_vehicles_from_targetname("mall_btr");
  common_scripts\utility::array_thread(var_0, maps\nml_util::btr_attack_player_on_flag, "_stealth_spotted");
  common_scripts\utility::flag_wait("mall_btr_go");
  common_scripts\utility::array_thread(var_0, maps\_vehicle::gopath);
}

mall_blockade() {
  thread mall_btrs();
  maps\nml_stealth::wait_till_every_thing_stealth_normal_for(1);
  level.baker.ignoreall = 1;
  level.player.ignoreme = 0;
  setsaveddvar("ai_eventDistFootstep", 64);
  setsaveddvar("ai_eventDistFootstepWalk", 32);
  setsaveddvar("ai_eventDistFootstepSprint", 96);
  setsaveddvar("ai_eventDistDeath", 64);
  thread trigger_restore_dvars();
  thread mall_teleport_dog();
  thread maps\_utility::smart_radio_dialogue_interrupt("nml_hsh_hangon");
  maps\nml_util::hero_paths("mall_start_path", 500, 500, 300, 0, 0);
  level.baker waittill("path_end_reached");

  if(!common_scripts\utility::flag("mall_btr_go") && !isDefined(level.dog.favoriteenemy))
    thread maps\_utility::autosave_stealth();

  level.baker pushplayer(1);
  level.dog pushplayer(1);
  level.baker allowedstances("crouch");
  level.baker maps\nml_util::set_move_rate(1.3);
  thread mall_lookout();
  common_scripts\utility::flag_set("mall_btr_go");
  setsaveddvar("ai_friendlyFireBlockDuration", 0);
  var_0 = common_scripts\utility::get_target_ent("mall_melee");
  var_1 = maps\_utility::get_living_ai("mall_lone_patrol", "script_noteworthy");

  if(isalive(var_1)) {
    var_1 endon("death");
    var_0 = common_scripts\utility::get_target_ent("mall_signal");
    var_0 maps\_anim::anim_generic_reach(level.baker, "signal_enemy_coverR");
    var_0 thread maps\_anim::anim_generic(level.baker, "signal_enemy_coverR");
    level.baker maps\_utility::smart_dialogue("nml_hsh_sniper12oclockhigh");
    wait 1;
    level.player.ignoreme = 0;
    level.baker thread maps\_utility::smart_dialogue("nml_hsh_takehimout");

    if(!maps\nml_util::player_has_silenced_weapon())
      maps\_utility::delaythread(0.25, maps\_utility::display_hint_timeout, "hint_dog_attack_3p", 7);
  }
}

mall_teleport_dog() {
  var_0 = common_scripts\utility::get_target_ent("mall_tunnel_volume");

  if(!level.dog istouching(var_0)) {
    var_1 = common_scripts\utility::get_target_ent("mall_dog_teleport");
    level.dog forceteleport(var_1.origin, var_1.angles);
  }
}

trigger_restore_dvars() {
  maps\_utility::trigger_wait_targetname("mall_restore_dvars");
  var_0 = "hidden";

  if(common_scripts\utility::flag("_stealth_spotted"))
    var_0 = "spotted";

  setsaveddvar("ai_eventDistDeath", level._stealth.logic.ai_event["ai_eventDistDeath"][var_0]);
  setsaveddvar("ai_eventDistFootstepSprint", level._stealth.logic.ai_event["ai_eventDistFootstepSprint"][var_0]);
  setsaveddvar("ai_eventDistFootstepWalk", level._stealth.logic.ai_event["ai_eventDistFootstepWalk"][var_0]);
  setsaveddvar("ai_eventDistFootstep", level._stealth.logic.ai_event["ai_eventDistFootstep"][var_0]);
}

mall_lookout() {
  common_scripts\utility::flag_wait("mall_lone_patrol_dead");
  level.player notify("cancel_command");
  level.dog maps\_utility::ent_flag_set("pause_dog_command");
  level.dog notify("stop_path");
  level.dog.old_path = undefined;
  level.dog setgoalpos(level.dog.origin);
  common_scripts\utility::flag_set("mall_btr_go");
  level endon("_stealth_spotted");
  maps\nml_stealth::wait_till_every_thing_stealth_normal_for(1);

  if(!common_scripts\utility::flag("mall_guy_died_by_dog"))
    level.baker maps\_utility::smart_dialogue("nml_hsh_goodkill");
  else
    level.baker maps\_utility::smart_dialogue("nml_hsh_goodboyriley");

  level.player.ignoreme = 0;
  level.baker maps\_utility::delaythread(1, maps\_utility::smart_dialogue, "nml_hsh_staylowfollowmy");
  level.baker maps\nml_util::set_move_rate(1.3);
  level.baker maps\_utility::clear_generic_run_anim();
  level.baker maps\_utility::enable_arrivals();
  level.baker maps\_utility::enable_exits();
  level.baker.goalradius = 96;
  level.baker maps\_utility::disable_cqbwalk();
  level.baker allowedstances("crouch");
  level.dog maps\_utility_dogs::enable_dog_walk(1);
  level.dog maps\nml_util::set_move_rate(1);
  level.dog.idlelookattargets = undefined;
  level.dog.ignoreall = 0;
  level.baker pushplayer(1);
  level.dog pushplayer(1);
  maps\nml_util::hero_paths("mall_lookout_path");
  common_scripts\utility::flag_wait("mall_heli_go");
  wait 2;
  level.baker maps\_utility::smart_dialogue("nml_hsh_jackpot");
  wait 1.5;
  level.baker maps\_utility::smart_dialogue("nml_hsh_delta11wereseeing");
  wait 1.5;
  level.baker maps\_utility::smart_dialogue("nml_hsh_movingintoinvestigate");
  maps\nml_stealth::wait_till_every_thing_stealth_normal_for(1);
  level.baker thread maps\_utility::smart_dialogue("nml_hsh_adamsynconriley");
  thread sync_nag();
  setsaveddvar("r_hudoutlinewidth", 3);
  var_0 = level.dog.model;
  level.dog maps\_utility_dogs::set_dog_model("fullbody_dog_a_cam_obj");
  var_1 = level.dog;
  var_1 makeusable();

  if(!level.console && !level.player usinggamepad())
    var_1 sethintstring(&"NML_HINT_SYNC_KB");
  else
    var_1 sethintstring(&"NML_HINT_SYNC");

  var_1 waittill("trigger");
  thread mall_sync_spotted_logic();
  level notify("kill_sync_nag");
  level.dog maps\_utility_dogs::set_dog_model_no_fur(var_0);
  var_1 makeunusable();
  level.player maps\_utility::player_speed_percent(1, 0.05);
  level.player allowjump(0);
  level.player allowsprint(0);
  level.dog maps\_utility::delaythread(0.01, maps\_utility_dogs::dog_raise_camera, 0.4);
  thread common_scripts\utility::play_sound_in_space("scn_nml_camera_raise", level.dog gettagorigin("tag_camera"));
  level.baker stopsounds();
  thread maps\_utility::smart_radio_dialogue_interrupt("nml_hsh_herewego");
  setsaveddvar("r_hudoutlinewidth", 1);
  wait 0.5;
  var_1 makeunusable();
  level.player.pre_dogcam_weapon = level.player getcurrentweapon();
  level.player disableweaponswitch();
  level.player giveweapon("remote_chopper_gunner");
  level.player switchtoweapon("remote_chopper_gunner");
  setdvar("hideHudFast", 1);
  setsaveddvar("ammoCounterHide", 1);
  level.player thread maps\_utility::play_sound_on_entity("uav_remote_raise_plr");
  cinematicingameloop("dog_out");
  wait 1;
  maps\_hud_util::fade_out(0.5, "overlay_static");
  wait 0.5;
  level.dog maps\_utility::clear_generic_idle_anim();
  common_scripts\utility::flag_set("start_dog_hunt");
  wait 0.5;
  thread mall_dog_init();
  level.player setclienttriggeraudiozone("nml_dog_camera", 0.5);
  thread maps\_utility::music_play("mus_nml_dog_stealth");
  maps\_hud_util::fade_in(0.5, "overlay_static");
  level.dog.ignoreall = 0;
  common_scripts\utility::noself_delaycall(4, ::stopcinematicingame);
  level.player maps\_utility::player_speed_percent(100, 0.1);
  level.player allowjump(1);
  level.player allowsprint(1);
}

mall_sync_spotted_logic() {
  level endon("start_dog_hunt");
  level.player endon("death");
  common_scripts\utility::flag_wait("_stealth_spotted");

  for(;;) {
    level.player dodamage(25, level.player.origin);
    level.player viewkick(10, level.player.origin);
    wait 0.1;
  }
}

mall_dog_init() {
  level.dog maps\_utility::ent_flag_set("dogcam_acquire_targets");
  level.player lerpviewangleclamp(0.3, 0, 0.2, 0, 0, 0, 0);
  level.dog setdogcommand("attack");
  level.dog maps\_utility_dogs::disable_dog_walk();
  level.dog maps\_utility::disable_arrivals();
  level.player thread maps\_dog_drive::constant_screen_glitches();
  level.player maps\_utility::notify_delay("stop_constant_glitch", 2);
  var_0 = common_scripts\utility::get_target_ent("dog_hunt_start_dog");
  level.dog.pushplayer = 1;
  level.dog pushplayer(1);
  level.dog.goalradius = 32;
  var_1 = common_scripts\utility::get_target_ent("mall_player_teleport");
  level.player setorigin(var_1.origin);
  level.dog setgoalpos(var_0.origin);
  level.dog waittill("goal");
  level.dog thread maps\_anim::anim_generic_gravity(level.dog, "iw6_dog_sneak_runin_8");
  level.player maps\_dog_drive::default_dog_limits();
  level.dog setdogcommand("driven");
  level.dog maps\_utility::enable_arrivals();
  level.dog.ignoreme = 1;
  var_2 = getent("boat_range_trigger", "script_noteworthy");
  var_2 common_scripts\utility::trigger_off();
  wait 0.5;
  level.dog.ignoreme = 0;
}

mall_lone_patrol_think() {
  self waittill("death", var_0);
  var_1 = common_scripts\utility::get_target_ent("mall_outside_grass_vol");

  if(var_0 == level.dog)
    common_scripts\utility::flag_set("mall_guy_died_by_dog");

  if(self istouching(var_1))
    common_scripts\utility::flag_set("mall_lone_patrol_dead");
  else {
    wait 0.3;
    maps\nml_stealth::player_set_spotted();
  }
}

player_drive_dog() {
  maps\nml_stealth::stealth_settings_dog();
  setnorthyaw(223.8);
  var_0 = getaiarray("axis");
  common_scripts\utility::array_call(var_0, ::delete);
  var_1 = maps\_utility::getvehiclearray();
  common_scripts\utility::array_call(var_1, ::delete);
  maps\_vehicle::spawn_vehicles_from_targetname_and_drive("mall2_btrs");
  var_2 = maps\_vehicle::spawn_vehicles_from_targetname("mall_btr_inside");
  var_3 = maps\_utility::array_spawn_targetname("dog_hunt_guys1");
  var_4 = maps\_utility::array_spawn_targetname("dog_hunt_guys2");
  level.baker.ignoreme = 1;
  level.player.ignoreme = 1;
  level.dog.ignoreme = 0;
  level.dog_alt_melee_func = undefined;
  level.player maps\_dog_drive::dog_drive_indirect(level.dog);
  thread maps\nml_stealth::dog_footstep_logic();
  thread maps\nml_util::mission_fail_on_dog_death();
  common_scripts\utility::flag_wait("mall_second_spawn");
  common_scripts\utility::array_thread(var_2, maps\_vehicle::gopath);
}

mall_walla_guys() {
  wait(randomfloatrange(0, 0.5));

  if(isDefined(self.walla)) {
    return;
  }
  var_0 = getEntArray("mall_walla_volume", "targetname");

  foreach(var_2 in var_0) {
    if(self istouching(var_2)) {
      var_2 mall_walla_volume();
      break;
    }
  }

  wait(randomfloatrange(0, 0.5));

  if(isDefined(self.walla)) {
    return;
  }
  var_0 = getEntArray("mall_radioburst_volume", "targetname");

  foreach(var_2 in var_0) {
    if(self istouching(var_2)) {
      var_2 mall_radioburst_volume();
      break;
    }
  }
}

mall_radioburst_volume() {
  if(isDefined(self.used)) {
    return;
  }
  var_0 = [];
  var_1 = getaiarray("axis");

  foreach(var_3 in var_1) {
    if(var_3 istouching(self)) {
      self.used = 1;
      var_3.walla = 1;
      var_0 = common_scripts\utility::array_add(var_0, var_3);
    }
  }

  if(var_0.size > 0)
    thread maps\nml_util::make_enemy_squad_burst(var_0, self.script_parameters);
}

mall_walla_volume() {
  if(isDefined(self.used)) {
    return;
  }
  var_0 = [];
  var_1 = getaiarray("axis");

  foreach(var_3 in var_1) {
    if(var_3 istouching(self)) {
      self.used = 1;
      var_3.walla = 1;
      var_0 = common_scripts\utility::array_add(var_0, var_3);
    }
  }

  if(var_0.size > 0)
    thread maps\nml_util::group_walla(var_0, self.script_count_min, self.script_count_max, self.script_parameters);
}

dog_hunt_spotted() {
  level endon("wolf_start_chase_dog");
  common_scripts\utility::flag_wait("_stealth_spotted");
  maps\_utility::smart_radio_dialogue("nml_hsh_werespottedtakeem");
}

mall_inside() {
  level.vargas = maps\_utility::spawn_targetname("vargas_spawner");
  level.oldboy = maps\_utility::spawn_targetname("oldboy_spawner");
  level.handler = maps\_utility::spawn_targetname("handler_spawner");
  level.vargas maps\_utility::gun_remove();
  level.oldboy maps\_utility::gun_remove();
  thread vargas_scene();
  common_scripts\utility::flag_wait("mall_inside_2");
  level.oldboy.name = "";
  level.oldboy.script_friendname = "";
  level.vargas.do_not_acquire = 1;
  level.oldboy.do_not_acquire = 1;
  level.handler.do_not_acquire = 1;
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("vargas_heli");
  var_0 vehicle_turnengineoff();
  var_0 thread common_scripts\utility::play_loop_sound_on_entity("scn_nml_heli_mall_street_lp");
  common_scripts\utility::flag_wait("varges_heli_leave");
  var_0 maps\_vehicle::vehicle_paths(common_scripts\utility::get_target_ent("vargas_heli_exit"));
  var_0 delete();
}

vargas_scene() {
  var_0 = common_scripts\utility::get_target_ent("vargas_scene_anim");
  level.handler.animname = "soldier";
  level.oldboy.animname = "hostage";
  level.vargas.animname = "vargas";
  level.handler hide();
  level.oldboy hide();
  var_0 thread maps\_anim::anim_loop_solo(level.vargas, "vargas_scene_idle");
  var_0 maps\_anim::anim_first_frame([level.handler, level.oldboy], "vargas_scene");
  common_scripts\utility::flag_wait("player_looking_at_vargas");
  level.handler show();
  level.oldboy show();
  thread vargas_scene_dialogue();
  thread vargas_scene_dialogue_volume();
  level.oldboy maps\_utility::set_hudoutline("neutral", 0);
  var_1 = [level.vargas, level.handler, level.oldboy];
  var_0 notify("stop_loop");
  common_scripts\utility::array_thread(var_1, ::vargas_anim, var_0);
}

vargas_anim(var_0) {
  self.ignoreme = 1;
  var_0 maps\_anim::anim_single_solo(self, "vargas_scene");

  if(isDefined(self))
    self delete();
}

vargas_scene_dialogue_volume() {
  level endon("mall_player_ready_to_leave");
  level.dog endon("death");

  for(;;) {
    var_0 = min(1.5, vargas_scene_get_lookat_score());

    if(isDefined(level.vargas))
      level.vargas scalevolume(var_0, 0.1);

    if(isDefined(level.oldboy))
      level.oldboy scalevolume(var_0, 0.1);

    if(isDefined(level.dog.v_static))
      level.dog.v_static scalevolume(min(max(0, 1.2 - var_0), 0.4), 0.1);

    wait 0.1;
  }
}

vargas_scene_get_lookat_score() {
  if(!level.dog.zoomed && level.gameskill > 2)
    return 0;

  var_0 = level.vargas getEye();
  var_1 = 0.97;
  var_2 = level.player;
  var_3 = var_2 maps\_dog_control::get_eye();
  var_4 = vectortoangles(var_0 - var_3);
  var_5 = anglesToForward(var_4);
  var_6 = var_2 getplayerangles();
  var_7 = anglesToForward(var_6);
  var_8 = vectordot(var_5, var_7);

  if(var_8 < var_1)
    return 0;

  return (var_8 - var_1) / (0.995 - var_1);
}

vargas_scene_save() {
  wait 27;
  var_0 = vargas_scene_get_lookat_score();

  if(var_0 > 0.4)
    maps\_utility::autosave_stealth_silent();
}

vargas_scene_dialogue() {
  level.vargas.animname = "vargas";
  level.dog.v_static = common_scripts\utility::spawn_tag_origin();
  level.dog.v_static linkto(level.dog, "tag_camera", (0, 0, 0), (0, 0, 0));
  level.dog.v_static playLoopSound("dogcam_radiostatic");
  thread vargas_scene_save();
  maps\_utility::delaythread(3, maps\_utility::smart_radio_dialogue, "nml_hsh_youseethatguys");
  level.vargas common_scripts\utility::delaycall(15, ::attach, "weapon_p226", "tag_weapon_right");
  level.vargas maps\_utility::delaythread(20.25, maps\_utility::smart_dialogue, "scn_dryfire_pistol_npc");
  wait 32;
  level.oldboy hudoutlinedisable();
  level.handler hudoutlinedisable();
  level.vargas waittillmatch("single anim", "ps_nml_rke_iwanteverythingmoved");
  var_0 = 0;
  var_1 = vargas_scene_get_lookat_score();

  if(var_1 < 0.1) {
    maps\nml_util::force_deathquote(&"NML_FAIL_INTEL");
    maps\_utility::missionfailedwrapper();
    var_0 = 1;
  }

  wait 0.5;
  level.vargas waittillmatch("single anim", "ps_nml_rke_operationhomecomingwill_2");
  wait 1.5;

  if(!var_0)
    common_scripts\utility::flag_set("mall_player_ready_to_leave");

  level.vargas hudoutlinedisable();
  wait 1;
  level.dog.v_static scalevolume(0, 1);
  wait 1;
  level.dog.v_static stoploopsound();
  wait 0.1;
  level.dog.v_static delete();
}

mall_dialogue() {
  level.dog endon("death");
  wait 5;
  thread maps\_utility::autosave_stealth();
  level.dog.attack_times = 0;
  thread hint_for_first_attack();
  maps\_utility::smart_radio_dialogue("nml_hsh_oklotsofenemy");
  wait 1;
  maps\_utility::smart_radio_dialogue("nml_hsh_scoutaroundseeif");
  thread mall_marker();
  mall_dialogue_grp1();
  common_scripts\utility::flag_waitopen("_stealth_spotted");
}

mall_dialogue_grp1() {
  level endon("_stealth_spotted");
  wait 5;
  thread maps\_utility::smart_radio_dialogue("nml_hsh_remembermoveslowand");
  maps\_utility::trigger_wait_targetname("mall_dialogue_1");
  wait 3;
  maps\_utility::trigger_wait_targetname("mall_dialogue_2");
  maps\_utility::display_hint("hint_stealthkill", 10);
  maps\_utility::smart_radio_dialogue_interrupt("nml_hsh_thisshouldwork");
}

mall_dialogue_grp2() {
  level endon("_stealth_spotted");
  wait 2;
  maps\_utility::smart_radio_dialogue("nml_hsh_okwerein");
  wait 2;
  maps\_utility::smart_radio_dialogue("nml_hsh_letsfindoutwhats");
  common_scripts\utility::flag_wait("mall_inside_2");
  wait 6;
  thread maps\_utility::smart_radio_dialogue("nml_hsh_okweremovingup");
}

mall_marker() {
  level.dog endon("death");
  var_0 = common_scripts\utility::get_target_ent("vargas_scene_anim");
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = var_0.origin;
  objective_current(maps\_utility::obj("1"));
  objective_position(maps\_utility::obj("1"), var_1.origin);
  level.dog thread maps\_utility::play_sound_on_entity("scn_nml_camera_enemy_contact_on");
  common_scripts\utility::flag_wait("player_close_to_vargas");
  wait 1;
  objective_position(maps\_utility::obj("1"), (0, 0, 0));
  var_1 delete();
}

mall_dialogue_2() {
  setsaveddvar("g_friendlyNameDist", 0);
  common_scripts\utility::flag_waitopen("_stealth_spotted");
  mall_dialogue_grp2();
  common_scripts\utility::flag_wait("varges_heli_leave");
  common_scripts\utility::flag_wait("player_close_to_vargas");
  thread vargas_instakill();
  maps\_utility::autosave_stealth_silent();
  common_scripts\utility::flag_waitopen("_stealth_spotted");
  level.dog endon("death");
  maps\_utility::smart_radio_dialogue_interrupt("nml_hsh_theguyonthe");
  common_scripts\utility::flag_clear("start_earthquakes");
  thread vargas_scene_flag_waiter();
  level.vargas maps\_utility::set_hudoutline("enemy", 0);
  wait 1;
  maps\_utility::smart_radio_dialogue("nml_hsh_zoominletssee");
  maps\_utility::display_hint("hint_zoom");
  common_scripts\utility::flag_wait("mall_player_ready_to_leave");
  level endon("dog_drive_stop_dialogue");
  level endon("wolf_start_chase_dog");
  setsaveddvar("g_friendlyNameDist", 15000);
  thread mall_teleport_allies_to_exit();
  wait 0.5;
  maps\_utility::smart_radio_dialogue("nml_hsh_firebasecharlieoperation");
  maps\_utility::smart_radio_dialogue("nml_mrk_stalker2whatis");
  wait 0.3;
  maps\_utility::smart_radio_dialogue("nml_hsh_rogerthatdeltawere");
  thread maps\_utility::autosave_stealth();
  wait 1;
  setnorthyaw(223.8);
  thread spawn_mall_exit();
  maps\_utility::smart_radio_dialogue("nml_hsh_markingourpositionsnow");
  wait 1;
  maps\_utility::smart_radio_dialogue("nml_hsh_adamgetrileyout");
  common_scripts\utility::flag_set("start_earthquakes");
  thread exit_nags();
}

vargas_scene_flag_waiter() {
  level.dog endon("death");

  for(;;) {
    if(player_looking_at_vargas()) {
      common_scripts\utility::flag_set("player_looking_at_vargas");
      break;
    }

    wait 0.05;
  }
}

exit_nags() {
  level endon("wolf_start_chase_dog");
  level endon("stop_mall_nags");

  while(!common_scripts\utility::flag("wolf_start_chase_dog")) {
    wait 8;
    setnorthyaw(223.8);
    maps\_utility::smart_radio_dialogue("nml_hsh_guiderileysouthto");
    wait 8;
    setnorthyaw(223.8);
    maps\_utility::smart_radio_dialogue("nml_hsh_logantheexitis");
    wait 8;
    setnorthyaw(223.8);
    maps\_utility::smart_radio_dialogue("nml_hsh_ivemarkedtherally");
    wait 8;
  }
}

spawn_mall_exit() {
  var_0 = common_scripts\utility::get_target_ent("mall_exit_marker");
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = var_0.origin;
  objective_position(maps\_utility::obj("1"), var_1.origin);
  level.dog thread maps\_utility::play_sound_on_entity("scn_nml_camera_enemy_contact_on");
  common_scripts\utility::flag_wait("wolf_start_chase_dog");
  objective_position(maps\_utility::obj("1"), (0, 0, 0));
  var_1 delete();
}

mall_teleport_allies_to_exit() {
  maps\_utility::trigger_wait_targetname("mall_teleport_allies_to_exit");
  level notify("stop_mall_nags");
  level.baker.goalradius = 64;
  level.adam.goalradius = 64;
  maps\nml_util::set_start_positions("mall_exit");
  level.baker maps\_utility::set_hudoutline("friendly", 0);
  level.adam maps\_utility::set_hudoutline("friendly", 0);
  level.baker maps\_utility::enable_cqbwalk();
  level.adam maps\_utility::enable_cqbwalk();
}

vargas_instakill() {
  level endon("mall_player_ready_to_leave");
  level.dog endon("death");

  while(maps\nml_stealth::stealth_is_everything_normal_for_group("400"))
    wait 0.05;

  common_scripts\utility::flag_set("_stealth_spotted");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    var_2 notify("stop_path");
    var_2 notify("end_patrol");
    var_2 getenemyinfo(level.dog);
    var_2 setgoalentity(level.dog);
  }

  wait 3;
  level.dog kill();
}

mall_exit() {
  common_scripts\utility::flag_wait("mall_player_ready_to_leave");
  var_0 = common_scripts\utility::get_target_ent("mall_exit");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(var_1 == level.dog) {
      break;
    }

    wait 0.05;
  }

  maps\_utility::music_stop(3);
  level notify("dog_drive_stop_dialogue");
  thread maps\_utility::smart_radio_dialogue_interrupt("nml_hsh_goodboyriley");
  level.player clearclienttriggeraudiozone(0.5);
  level.player notify("disable_zoom");
  maps\_hud_util::fade_out(0.25, "overlay_static");
  wait 0.5;
  level.player freezecontrols(1);

  while(level.adam.origin[2] > -1000)
    wait 0.05;

  level.dog_alt_melee_func = undefined;
  level.dog.script_nostairs = undefined;
  level.dog.script_noturnanim = undefined;
  level.baker.ignoreall = 0;
  level.baker hudoutlinedisable();
  level.player maps\_dog_drive::dog_drive_indirect_disable(level.dog);
  level.dog.melee = undefined;
  level.dog thread maps\_utility::magic_bullet_shield();
  level.dog maps\_utility_dogs::set_dog_model(level.dog.model);
  level.player setorigin(level.adam.origin);
  level.player setplayerangles(level.adam.angles);
  level.adam delete();
  var_2 = common_scripts\utility::get_target_ent("chase_dog_dog_teleport");
  level.dog forceteleport(var_2.origin, var_2.angles);
  common_scripts\utility::flag_set("wolf_start_chase_dog");
  maps\_hud_util::fade_in(0.25, "overlay_static");

  if(!isDefined(level.player.pre_dogcam_weapon))
    level.player.pre_dogcam_weapon = "honeybadger+acog_sp";

  level.player disableweaponswitch();
  cinematicingameloop("dog_out");
  level.player switchtoweapon(level.player.pre_dogcam_weapon);
  wait 0.5;
  level.player freezecontrols(0);
  wait 1;
  level.player takeweapon("remote_chopper_gunner");
  level.player enableweaponswitch();
  setdvar("hideHudFast", 0);
  setsaveddvar("ammoCounterHide", 0);
}

mall_blockers() {
  var_0 = maps\_utility::array_spawn_targetname("mall_blocker_guys");
  var_1 = common_scripts\utility::get_target_ent("mall_blocker_brushmodel_a");
  var_2 = common_scripts\utility::get_target_ent("mall_blocker_brushmodel_b");
  var_3 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("mall_blocker_a");
  var_2 notsolid();
  common_scripts\utility::flag_wait("mall_player_ready_to_leave");
  var_3 delete();
  var_1 connectpaths();
  var_1 delete();

  foreach(var_5 in var_0) {
    if(isDefined(var_5))
      var_5 delete();
  }

  common_scripts\utility::flag_wait("wolf_start_chase_dog");
  wait 0.75;
  var_3 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("mall_blocker_b");
  var_2 solid();
  common_scripts\utility::array_thread(var_3, ::chase_dog_blocker_think);
  common_scripts\utility::flag_wait("wolf_start_wolfpack");
  common_scripts\utility::array_call(var_3, ::delete);
}

chase_dog_blocker_think() {
  self endon("death");
  thread maps\_vehicle::mgon();
  maps\_utility::trigger_wait_targetname("mall_blocker_2_spotted_trig");

  foreach(var_1 in self.mgturret) {
    var_1 thread maps\_mgturret::burst_fire_unmanned();
    var_1 setmode("auto_nonai");
  }

  thread maps\nml_util::btr_target_player();
}

player_looking_at_vargas() {
  var_0 = level.vargas getEye();
  var_1 = distance(level.vargas.origin, level.dog.origin) < 800 && level.dog.zoomed && level.player maps\nml_util::player_looking_at_on_dog(var_0, 0.992, undefined, level.vargas);
  level.bool = var_1;
  return var_1;
}

play_next_vargas_line() {
  if(!isDefined(level.vargas_lines)) {
    level.vargas_lines = [];
    level.vargas_lines[level.vargas_lines.size] = "** static **";
    level.vargas_lines[level.vargas_lines.size] = "What do you mean we're behind schedule?!";
    level.vargas_lines[level.vargas_lines.size] = "Sir, the dig site was attacked...";
    level.vargas_lines[level.vargas_lines.size] = "What?!";
    level.vargas_lines[level.vargas_lines.size] = "I cannot deal with this incompetence...";
    level.vargas_lines[level.vargas_lines.size] = "** GENERAL SHOOTS PRIVATE **";
    level.vargas_lines[level.vargas_lines.size] = "You!You've just been promoted...";
    level.vargas_lines[level.vargas_lines.size] = "We need this shipment moved to Firebase Charlie in two hours...";
    level.vargas_lines[level.vargas_lines.size] = "Operation Loose Ends will proceed as planned...";
    level.vargas_lines[level.vargas_lines.size] = "** static **";
    level.vargas_line_count = 0;
  }

  iprintlnbold(level.vargas_lines[level.vargas_line_count]);
  wait 1.5;
  level.vargas_line_count = level.vargas_line_count + 1;

  if(level.vargas_line_count >= level.vargas_lines.size)
    return 1;

  return 0;
}

enemy_grass_stealth_think() {
  var_0 = [];
  var_0["hidden"] = maps\_stealth_behavior_enemy::enemy_state_hidden;
  var_0["spotted"] = ::enemy_grass_stealth_spotted;
  maps\_stealth_behavior_enemy::enemy_custom_state_behavior(var_0);
}

enemy_grass_stealth_spotted(var_0) {
  thread maps\_stealth_behavior_enemy::enemy_state_spotted(var_0);

  if(isDefined(level.dog.enemy) && level.dog.enemy == self && level.dog.script == "dog_combat")
    thread maps\_utility::set_battlechatter(0);

  thread maps\nml_util::run_away_from_dog();
}