/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\las_vegas_entrance.gsc
***************************************/

main_init() {
  if(isDefined(level.entrance_main_init)) {
    return;
  }
  level.entrance_main_init = 1;
  level.player_in_bus = 0;
}

spawn_functions() {
  maps\_utility::array_spawn_function_noteworthy("entrance_chopper_unloader", ::postspawn_entrance_chopper_unloader);
  maps\_utility::array_spawn_function_noteworthy("entrance_chopper_shooter", ::postspawn_entrance_chopper_shooter);
  maps\_utility::array_spawn_function_noteworthy("chopper_courtyard", ::postspawn_courtyard_chopper);
  maps\_utility::array_spawn_function_targetname("chopper_shooter2", ::postspawn_chopper_shooter);
  maps\_utility::array_spawn_function_noteworthy("courtyard_enemy", ::postspawn_courtyard_enemy);
  maps\_utility::array_spawn_function_targetname("exfil_chopper", ::postspawn_exfil_chopper);
  maps\_utility::array_spawn_function_targetname("exfil_f18", ::postspawn_exfil_f18);
}

start_entrance() {
  maps\las_vegas_code::set_player_speed();
  var_0 = common_scripts\utility::getstruct("casino_player_slide_start", "targetname");
  maps\las_vegas_code::set_start_locations("entrance_startspot");
  common_scripts\utility::flag_set("start_outside_animated_props");
}

start_entrance_combat() {
  maps\las_vegas_code::set_player_speed();
  maps\las_vegas_code::set_start_locations("entrance_startspot");
  level.keegan maps\_utility::clear_force_color();
  level.hesh maps\_utility::clear_force_color();
  init_courtyard();
  change_chopper_spawner("entrance_chopper_shooter", "entrance_chopper_shooter_late_start");
  change_chopper_spawner("entrance_chopper_unloader", "entrance_chopper_unloader_late_start");
  thread entrance_pursuers();
  common_scripts\utility::flag_set("start_outside_animated_props");
}

start_exfil() {
  init_courtyard();
  maps\las_vegas_code::set_player_speed();
  maps\las_vegas_code::set_start_locations("exfil_startpots");
  level.hesh maps\_utility::set_force_color("b");
  level.keegan maps\_utility::set_force_color("g");
  level.merrick maps\_utility::set_force_color("r");
  var_0 = maps\las_vegas_code::spawn_drone_dog();
  level.dog = var_0;
  var_0.origin = level.player.origin;
  var_0 thread maps\las_vegas_code::dog_thread();
  wait 0.1;
  var_0 notify("trigger");
}

change_chopper_spawner(var_0, var_1) {
  var_2 = getent(var_0, "script_noteworthy");
  var_3 = common_scripts\utility::getstruct(var_1, "script_noteworthy");
  var_2.origin = var_3.origin;
  var_4 = var_3 common_scripts\utility::get_target_ent();
  var_2.angles = vectortoangles(var_4.origin - var_3.origin);
  var_5 = getEntArray(var_2.target, "targetname");

  foreach(var_7 in var_5)
  var_7.targetname = var_3.targetname;

  var_2.target = var_3.targetname;
}

entrance_init() {
  if(isDefined(level.entrance_init)) {
    return;
  }
  level.entrance_init = 1;
  level.hesh maps\_utility::battlechatter_off();
  level.merrick maps\_utility::battlechatter_off();
  level.keegan maps\_utility::battlechatter_off();
}

entrance() {
  main_init();
  entrance_init();
  init_courtyard();

  foreach(var_1 in level.heroes)
  var_1 show();

  setsaveddvar("ai_friendlyFireBlockDuration", "2000");
  level.merrick maps\las_vegas_code::set_not_wounded();
  maps\las_vegas_code::set_player_speed("entrance");
  level.hesh maps\_utility::battlechatter_off();
  level.merrick maps\_utility::battlechatter_off();
  maps\_utility::transient_switch("las_vegas_transient_hotel_tr", "las_vegas_transient_crasharea_tr");
  getup();
}

getup() {
  maps\_hud_util::fade_out(0);
  maps\las_vegas_code::sun_direction("hand");
  level.player disableweapons();
  level.keegan maps\_utility::battlechatter_off();
  maps\_utility::battlechatter_off("axis");
  common_scripts\utility::array_thread(level.heroes, maps\las_vegas_code::set_ai_name, "");
  level notify("casino_player_jumped");
  level.keegan maps\_utility::clear_force_color();
  level.hesh maps\_utility::clear_force_color();
  setsaveddvar("player_sprintUnlimited", 0);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player setstance("stand");
  var_0 = common_scripts\utility::getstruct("bottom_anim_entrance", "targetname");
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.origin = var_1.origin + (0, 0, 1);
  level.player_rig = maps\_utility::spawn_anim_model("player_rig", var_1.origin);
  level.player_rig.animname = "player_rig";
  wait 4;
  thread getup_screen_effects();
  thread getup_fx();
  thread entrance_pursuers();
  level.player clearclienttriggeraudiozone(18.0);
  level.merrick notify("stop_custom_anim_run");

  foreach(var_3 in level.heroes) {
    var_3 maps\_utility::clear_force_color();
    var_3 maps\_utility::battlechatter_off();
  }

  maps\_utility::battlechatter_off("axis");
  var_5 = 15;
  level.player playerlinktodelta(level.player_rig, "tag_player", 1, var_5, var_5, 0, var_5, 1);
  thread getup_dialogue();
  common_scripts\utility::noself_delaycall(1, ::playrumblelooponposition, "subtle_tank_rumble", level.player.origin + (0, 0, 500));
  common_scripts\utility::noself_delaycall(14.5, ::stopallrumbles);
  level.player common_scripts\utility::delaycall(14.8, ::playrumbleonentity, "damage_light");
  var_6 = common_scripts\utility::array_add(level.heroes, level.player_rig);
  var_1 maps\_anim::anim_single(var_6, "raid_getup");
  level.player enableweapons();
  level.player unlink();
  level.player_rig delete();
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player setstance("stand", "crouch", "prone");
  common_scripts\utility::array_thread(level.heroes, maps\las_vegas_code::reset_ai_name);
  common_scripts\utility::flag_set("intro_lines");
  common_scripts\utility::flag_set("getup_done");
  level notify("getup_dialogue_continue");
  common_scripts\utility::flag_clear("disable_autosaves");
  maps\_utility::autosave_by_name("entrance");
}

custom_dirt_hud() {
  var_0 = [];
  var_0[var_0.size] = ["fullscreen_dirt_left", -100, 5];
  var_0[var_0.size] = ["fullscreen_dirt_right", -200, 15];
  var_1 = [];
  var_2 = 1.5;

  foreach(var_4 in var_0) {
    var_5 = newhudelem();
    var_5 setshader(var_4[0], int(640 * var_2), int(480 * var_2));
    var_5.horzalign = "fullscreen";
    var_5.vertalign = "fullscreen";
    var_5.y = var_5.y + var_4[1];
    var_5 fadeovertime(var_4[2]);
    var_5.alpha = 0;
    var_1[var_1.size] = var_5;
  }

  var_7 = newhudelem();
  var_7 setshader("buried_sand_screen", 640, 480);
  var_7.horzalign = "fullscreen";
  var_7.vertalign = "fullscreen";
  var_7.alpha = 0;
  var_7.y = 200;
  level waittill("buried_sand_screen_increase");
  var_7 fadeovertime(3);
  var_7.alpha = 1;
  level waittill("buried_sand_screen_remove");
  var_8 = 2;
  var_7 fadeovertime(var_8);
  var_7.alpha = 0;
  wait(var_8);
  var_7 destroy();
  common_scripts\utility::flag_wait("leaving_entrance");
  maps\las_vegas_code::sun_direction("courtyard");
}

getup_dialogue() {
  level endon("entrance_combat_start");
  thread getup_enemy_radio();
}

getup_enemy_radio() {
  var_0 = ["vegas_spl_welostsightof", 1, "vegas_sp2_theywentoutthe", 2, "vegas_death_theentrancetheyshould", 1, "vegas_spl_allteamsconvergeon"];
  maps\las_vegas_code::array_play_enemy_radio(var_0);
}

getup_screen_effects() {
  thread custom_dirt_hud();

  if(isDefined(level.fadein))
    level.fadein destroy();

  thread maps\_hud_util::fade_in(3);
  level.player shellshock("las_vegas_getup", 5);
  thread getup_screenshake(5);
  setblur(30, 0.05);
  wait 0.1;
  maps\_art::dof_enable_script(1, 499, 10, 500, 600, 10, 0.1);
  setblur(5, 2);
  wait 1;
  maps\_art::dof_enable_script(1, 250, 10, level.dof["base"]["current"]["farStart"], level.dof["base"]["current"]["farEnd"], 10, 3.1);
  wait 1;
  setblur(0, 5);
  wait 5;
  maps\_art::dof_disable_script(2.5);
}

getup_screenshake(var_0) {
  var_1 = gettime() + var_0 * 1000;

  while(var_1 > gettime()) {
    earthquake(0.105, 0.2, level.player.origin, 500);
    wait 0.1;
  }
}

getup_fx() {
  var_0 = "vfx_thick_falling_stream";
  var_1 = "vfx_sand_ground_spawn_loop";
  var_2 = (-16, 70, 720);
  thread getup_fx_thread(var_0, level.player_rig.origin + var_2, "stop_hand_sand_stream");
  thread getup_fx_thread(var_1, maps\_utility::groundpos(level.player_rig.origin + var_2 + (0, 0, -500)), "stop_hand_sand_stream");
}

getup_fx_thread(var_0, var_1, var_2) {
  var_3 = spawnfx(common_scripts\utility::getfx(var_0), var_1, (1, 0, 0));
  triggerfx(var_3, -5);

  if(isDefined(var_2)) {
    level waittill(var_2);
    var_3 delete();
  }
}

entrance_combat() {
  init_courtyard();
  main_init();
  entrance_init();
  thread fail_no_pickup();
  maps\las_vegas_code::set_player_speed("entrance_combat", 2);
  thread combat_enemy_radio();
  thread train_fall();
  level.hesh thread maps\_utility::enable_cqbwalk();
  level.keegan thread maps\_utility::enable_cqbwalk();

  foreach(var_1 in level.heroes) {
    var_1.ignoreall = 1;
    var_1.grenadeawareness = 1;

    if(var_1.type != "dog")
      var_1 thread waittill_combat_start();
  }

  level.keegan allowedstances("crouch");
  level.hesh allowedstances("crouch");
  level.hesh maps\_utility::set_force_color("b");
  level.keegan thread start_walk("path_switch_to_sniper", "g");
  level.merrick maps\_utility::delaythread(4, maps\_utility::set_force_color, "r");
  maps\_utility::activate_trigger_with_targetname("color_post_getup");
  maps\_vehicle::spawn_vehicle_from_targetname_and_drive("courtyard_chopper_1");
  level thread entrance_combat_dialogue();
  common_scripts\utility::flag_wait("entrance_combat_start");
  maps\_utility::battlechatter_on();
  thread battle_think();
}

fail_no_pickup() {
  common_scripts\utility::flag_wait("start_train_fall");

  if(!common_scripts\utility::flag("dog_first_pickup"))
    maps\las_vegas_code::dog_mission_fail();
}

combat_enemy_radio() {
  common_scripts\utility::flag_wait("entrance_combat_start");
  wait 2;
  maps\las_vegas_code::play_enemy_radio("vegas_sp3_takingfireweneed");
  wait 3;
  var_0 = ["vegas_spl_spreadoutcoverthe", 2, "vegas_death_movingclosertothe", 3, "vegas_sp2_wevegotcontactgo", 5, "vegas_spl_sendingmoresupportnow"];
  thread maps\las_vegas_code::array_play_enemy_radio(var_0);
}

entrance_combat_dialogue() {
  level.merrick thread maps\las_vegas_code::flag_smart_dialogue("entrance_combat_start", "vegas_mrk_gogo");
  level.hesh thread maps\las_vegas_code::flag_smart_dialogue("incoming_chopper", "vegas_hsh_putsomefireon");
}

entrance_pursuers() {
  if(level.start_point != "entrance_combat")
    wait 4;

  maps\_vehicle::spawn_vehicles_from_targetname_and_drive("entrance_chopper");
}

entrance_enemy_alert_thread() {
  self endon("death");
  self endon("stop_alert_thread");
  self.ignoreall = 1;
  maps\_utility::set_archetype("creepwalk");
  var_0 = self.walkdist;
  self.walkdist = 1200;
  thread maps\las_vegas_code::waittill_flag_set("too_close", "entrance_combat_start");
  thread maps\las_vegas_code::waittill_flag_set("damage", "entrance_combat_start");
  thread maps\las_vegas_code::waittill_flag_set("bulletwhizby", "entrance_combat_start");
  thread maps\las_vegas_code::waittill_flag_set("explode", "entrance_combat_start");
  thread maps\las_vegas_code::too_close_to_allies("too_close", 250, "entrance_combat_start");
  self waittill("jumpedout");
  var_1 = common_scripts\utility::getstructarray("entrance_shooter_path", "targetname");
  var_1 = sortbydistance(var_1, self.origin);
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(isDefined(var_4.is_taken)) {
      continue;
    }
    var_4.is_taken = 1;
    var_2 = var_4;
    break;
  }

  self waittill("quick_getout_end");
  self.qsetgoalpos = 0;
  var_6 = 0;

  if(isDefined(var_2.script_noteworthy)) {
    if(var_2.script_noteworthy == "dog_guy") {
      self.disablebulletwhizbyreaction = 1;
      thread courtyard_dog_intro();
      var_6 = 1;
    }
  } else
    thread courtyard_dog_reaction();

  thread maps\_utility::follow_path(var_2);
  common_scripts\utility::flag_wait("entrance_combat_start");

  if(var_6) {
    return;
  }
  self notify("_utility::follow_path");
  maps\_utility::clear_archetype();
  self.walkdist = var_0;
  self.ignoreall = 0;
  self.goalradius = 1024;
}

start_walk(var_0, var_1) {
  maps\_utility::set_force_color(var_1);
  maps\_utility::disable_ai_color();
  maps\_utility::walkdist_zero();
  var_2 = common_scripts\utility::getstruct(var_0, "targetname");
  maps\_utility::follow_path(var_2, undefined, ::follow_path_node_anim);
  maps\_utility::walkdist_reset();
  maps\_utility::enable_ai_color();
}

waittill_combat_start() {
  common_scripts\utility::flag_wait("entrance_combat_start");

  if(self.team == "axis")
    self.goalradius = level.default_goalradius;

  maps\las_vegas_code::clear_ignore_everything();
}

courtyard_sniper() {
  var_0 = maps\_utility::spawn_targetname("courtyard_sniper", 1);
  var_0.disablelongdeath = 1;
  var_0.targetname = "courtyard_sniper_ai";
  var_0 setgoalpos(var_0.origin);
  var_0.ignoreall = 1;
  var_0 allowedstances("stand");
  var_0 setCanDamage(0);
  level waittill("laser_on");
  setsaveddvar("laserrange", 5000);
  var_1 = spawn("script_model", var_0 gettagorigin("tag_flash"));
  var_0 thread courtyard_sniper_laser(var_1);
  var_1.targetname = "courtyard_laser";
  var_1 setModel("tag_flash");
  var_1.angles = vectortoangles(level.player.origin - var_1.origin);
  var_1.angles = var_1.angles + (-70, 0, 0);
  var_1 laserforceon();
  var_2 = 0.2;

  while(!common_scripts\utility::flag("dog_down")) {
    var_3 = vectortoangles(level.dog.origin + (0, 0, 20) - var_1.origin);
    var_1 rotateto(var_3, var_2);
    wait(var_2);
  }

  var_0 setCanDamage(1);
  var_1 rotateto(var_1.angles + (30, 0, 0), 0.5);
  wait 0.5;
  var_1 laserforceoff();
  var_1 delete();

  if(isDefined(var_0) && isalive(var_0)) {
    var_0 endon("death");
    var_0 laserforceon();
    var_0.ignoreall = 0;
  }

  common_scripts\utility::flag_wait("leaving_entrance");
  wait(randomfloatrange(10, 20));

  if(isDefined(var_0) && isalive(var_0))
    var_0 kill();
}

courtyard_sniper_laser(var_0) {
  self endon("death");
  var_0 endon("death");

  for(;;) {
    var_0.origin = self gettagorigin("tag_flash");
    wait 0.05;
  }
}

courtyard_dog_intro(var_0) {
  self setCanDamage(0);
  self.grenadeawareness = 0;
  self.badplaceawareness = 0;
  maps\_utility::disable_arrivals();
  self.fixednode = 1;
  maps\_utility::forceuseweapon("lsat", "primary");
  maps\_utility::clear_archetype();
  var_1 = common_scripts\utility::getstruct("courtyard_dog_spawn_struct", "targetname");
  var_2 = maps\las_vegas_code::spawn_hero("riley", var_1);
  var_2.ignoreall = 1;
  var_2.ignoreme = 1;
  var_2.fixednode = 1;
  var_2 setCanDamage(0);
  self waittill("reached_path_end");
  maps\_utility::set_archetype("creepwalk");
  var_1 = common_scripts\utility::getstruct(var_1.target, "targetname");
  var_2 thread maps\_utility::follow_path(var_1);
  var_0 = common_scripts\utility::getstruct("dog_kill_struct", "targetname");
  var_0.origin = common_scripts\utility::drop_to_ground(var_0.origin, 10, -100);
  self notify("stop_alert_thread");
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.goalradius = 145;
  self setgoalpos(var_0.origin);
  self waittill("goal");
  level thread courtyard_sniper();
  var_2 notify("_utility::follow_path");
  var_3 = [self, var_2];
  self.animname = "dog_guy";
  var_2.fixednode = 1;
  var_2.grenadeawareness = 0;
  var_2.badplaceawareness = 0;
  var_2 maps\_utility::delaythread(0.1, ::dog_hack);
  var_0 maps\_anim::anim_reach(var_3, "dog_kill");
  level.hesh thread maps\_utility::smart_dialogue("vegas_hsh_riley");
  level notify("laser_on");
  level.dog thread maps\_utility_dogs::dog_bark();
  level notify("dog_reaction");
  common_scripts\utility::flag_set("entrance_combat_start");
  var_2.ignoreme = 0;
  var_0 thread maps\_anim::anim_single(var_3, "dog_kill");
  wait 3;
  level.dog thread dog_intro_pain();
  self.allowdeath = 1;
  self.a.nodeath = 1;
  self kill();
}

dog_hack() {
  self.fixednode = 1;
  self.goalradius = 32;
}

dog_friendly_react() {
  level.keegan.baseaccuracy = 500;
  dog_friendly_react_wait();
  var_0 = common_scripts\utility::getstruct("riley_hurt_struct_hesh", "targetname");
  level.hesh.alertlevelint = 0;
  level.hesh maps\_utility::disable_ai_color();
  var_0 maps\_anim::anim_reach_solo(level.hesh, "dog_hurt_enter");
  level thread dog_friendly_dialogue();
  level thread keegan_cover_dog();
  var_0 maps\_anim::anim_single_solo(level.hesh, "dog_hurt_enter");
  level.hesh thread maps\_anim::anim_single_solo(level.hesh, "dog_hurt_loop");
  level notify("stop_dog_hurt_anim");
  var_0 maps\las_vegas_code::struct_stopanimscripted();
  level.hesh maps\_anim::anim_single_solo(level.hesh, "dog_hurt_exit");
  level.hesh maps\_utility::enable_ai_color();
  maps\_utility::activate_trigger_with_targetname("entrance_battle_colors");
  common_scripts\utility::flag_set("entrance_chopper_reinforcement");
  thread courtyard_dialogue();
  level.keegan maps\_utility::set_force_color("g");
  level.keegan waittill("goal");
}

courtyard_dialogue() {
  common_scripts\utility::flag_wait("courtyard_stairs");
  level.keegan thread maps\_utility::smart_dialogue("vegas_kgn_thereitis");
  wait 3;
  level.merrick maps\_utility::smart_dialogue("vegas_mrk_everyoneonthebus");
  wait 2;
  level.keegan thread maps\_utility::smart_dialogue("vegas_mrk_moveyourasskid");
}

keegan_cover_dog() {
  var_0 = getnode("keegan_cover_dog", "targetname");
  level.keegan maps\_utility::disable_ai_color();
  level.keegan.goalradius = 32;
  level.keegan setgoalnode(var_0);
  var_1 = getent("courtyard_sniper_ai", "targetname");

  if(isDefined(var_1))
    level.keegan.favoriteenemy = var_1;
}

dog_friendly_react_wait() {
  var_0 = getent("courtyard_entry_volume", "targetname");

  for(;;) {
    wait 0.05;
    var_1 = var_0 maps\_utility::get_ai_touching_volume("axis");

    if(common_scripts\utility::flag("entrance_chopper_reinforcement")) {
      break;
    }

    if(var_1.size < 2) {
      break;
    }
  }
}

dog_friendly_dialogue() {
  wait 2;
  var_0 = spawn("script_model", level.dog.origin + (0, 0, -200));
  var_0 maps\_utility_dogs::set_dog_model("fullbody_dog_b_cam_obj_hurt");
  level.hesh maps\_utility::smart_dialogue("vegas_kgn_hesokbulletwent");
  level.dog maps\_utility::delaythread(1, maps\las_vegas_code::dog_thread);
  level notify("stop_dog_hurt_anim");
  level.hesh maps\_utility::smart_dialogue("vegas_hsh_loganyoucarryhim");
  var_0 maps\_utility_dogs::kill_dog_fur_effect();
  common_scripts\utility::waitframe();
  var_0 delete();
}

dog_intro_pain() {
  maps\_utility::anim_stopanimscripted();
  common_scripts\utility::flag_set("dog_down");
  var_0 = getent("courtyard_laser", "targetname");
  thread common_scripts\utility::play_sound_in_space("weap_gm6_fire_npc", var_0.origin);
  var_1 = self.origin + (0, 0, 20);
  thread common_scripts\utility::play_sound_in_space("bullet_ap_flesh", var_1);
  var_2 = vectornormalize(var_0.origin - self.origin);
  playFX(common_scripts\utility::getfx("blood_spurt"), var_1, var_2);
  maps\_utility_dogs::set_dog_model("fullbody_dog_b_hurt");
  self playSound("vegas_riley_shot");
  var_3 = maps\las_vegas_code::makestruct();
  var_3.origin = common_scripts\utility::drop_to_ground(var_3.origin + (0, 0, 10), 10, -100);
  var_3 maps\_anim::anim_single_solo(self, "dog_pain");
  maps\_utility::anim_stopanimscripted();
  thread dog_friendly_react();
  thread maps\_anim::anim_single_solo(self, "hurt_idle_single");
  wait 0.5;
  thread maps\_anim::anim_loop_solo(self, "hurt_idle");
  var_4 = maps\las_vegas_code::spawn_drone_dog();
  var_4 hide();
  var_3 = maps\las_vegas_code::makestruct();
  var_3 maps\_anim::anim_first_frame_solo(var_4, "hurt_idle_single");
  var_4 show();
  maps\_utility::stop_magic_bullet_shield();
  self delete();
  level.dog = var_4;
  var_4 maps\_utility::ent_flag_init("picked_up");
  var_4 thread maps\las_vegas_code::dog_loop_audio();
  badplace_cylinder("dog_place", 0, var_4.origin, 32, 60);
  var_4 thread maps\_anim::anim_loop_solo(var_4, "hurt_idle");
}

courtyard_dog_reaction() {
  self endon("death");
  level waittill("dog_reaction");
  wait(randomfloatrange(0.2, 1.5));
  self animcustom(maps\las_vegas_code::do_reaction);
  self orientmode("face point", level.dog.origin);
}

init_courtyard() {
  if(isDefined(level.courtyard)) {
    return;
  }
  level.courtyard = spawnStruct();
  level.courtyard.enemy_volume = getent("courtyard_volume", "targetname");
  level.courtyard.enemies = [];
  level.courtyard.chopper_shooter_count = 0;
  level.courtyard.chopper_shooter_total = 0;
  level.courtyard.chopper_shooter_holding = 0;
  level.courtyard.next_chopper_shooter = 0;
  level.courtyard.choppers = [];
}

battle_think() {
  var_0 = getEntArray("courtyard_volume_triggers", "targetname");
  common_scripts\utility::array_thread(var_0, maps\las_vegas_code::enemy_volume_trigger_thread, level.courtyard, "courtyard_battle_done");
  maps\_vehicle::spawn_vehicle_from_targetname_and_drive("chopper_shooter2");
  var_1 = getEntArray("courtyard_chopper", "script_noteworthy");
  common_scripts\utility::array_thread(var_1, maps\_vehicle::spawn_vehicle_and_gopath);
}

unload_thread() {
  self endon("death");
  self notify("unload_thread");
  self endon("unload_thread");
  level.courtyard.enemies[level.courtyard.enemies.size] = self;
  self waittill("jumpedout");
  self.ignoreall = 0;
  wait 2;
  maps\las_vegas_code::set_goal_volume(level.courtyard.enemy_volume, randomfloat(2));
}

chopper_shooter_holding() {
  self endon("death");
  var_0 = maps\las_vegas_code::get_sorted_structs("courtyard_chopper_holding", self.origin);
  var_1 = maps\las_vegas_code::get_unused_struct(var_0);
  var_1.inuse = 1;
  var_1 thread maps\las_vegas_code::reset_inuse(self, "holding_done");
  self setvehgoalpos(var_1.origin, 1);
  common_scripts\utility::waittill_any("near_goal", "goal");
  var_2 = 0;

  for(;;) {
    if(var_2) {
      var_2 = 0;
      self settargetyaw(var_1.angles[1] + 180);
    } else {
      var_2 = 1;
      self settargetyaw(var_1.angles[1]);
    }

    var_3 = gettime() + randomfloatrange(5, 10) * 1000;

    while(var_3 > gettime()) {
      if(level.courtyard.chopper_shooter_count < 1) {
        self cleartargetyaw();
        return;
      }

      wait 0.2;
    }
  }
}

postspawn_courtyard_enemy() {
  level.courtyard.enemies = common_scripts\utility::array_removeundefined(level.courtyard.enemies);
  level.courtyard.enemies[level.courtyard.enemies.size] = self;
}

#using_animtree("script_model");

train_fall() {
  var_0 = common_scripts\utility::getstruct("courtyard_train_spot", "targetname");
  var_1 = getEntArray(var_0.target, "targetname");
  var_2 = getEntArray("trainfall_spark_spots", "targetname");

  foreach(var_4 in var_1) {
    var_4.animname = var_4.script_noteworthy;
    var_4 useanimtree(#animtree);
    var_0 maps\_anim::anim_first_frame_solo(var_4, "vegas_train_fall");
  }

  level.train_drippy_num_right = 0;
  level.train_drippy_num_left = 0;
  var_6 = undefined;

  foreach(var_4 in var_1) {
    var_4.animname = var_4.script_noteworthy;
    var_4 useanimtree(#animtree);
    var_0 maps\_anim::anim_first_frame_solo(var_4, "vegas_train_fall");

    if(var_4.script_noteworthy == "train1") {
      var_6 = var_4;
      var_0 thread maps\_anim::anim_loop_solo(var_4, "vegas_train_fall_idle", "stop_anim");
    }

    foreach(var_9 in var_2) {
      if(var_9.script_noteworthy == var_4.script_noteworthy) {
        var_9 linkto(var_4, "train1_jnt");
        var_4 thread train_crash_fx(var_9);
      }
    }
  }

  common_scripts\utility::flag_wait("leaving_entrance");
  var_12 = [(-29881, -34947, 458), (-29681, -34883, 458)];

  for(;;) {
    wait 0.1;

    if(distancesquared(level.player.origin, var_6.origin) > squared(1200)) {
      continue;
    }
    if(distancesquared(level.player.origin, var_6.origin) > squared(950)) {
      var_13 = 0;

      foreach(var_9 in var_12) {
        if(level.player maps\_utility::player_looking_at(var_9))
          var_13++;
      }

      if(var_13 == 0)
        continue;
    }

    wait(randomfloat(1));
    common_scripts\utility::flag_set("FLAG_traincrash_start");
    thread train_quake_crash();
    var_0 notify("stop_anim");
    var_0 maps\_anim::anim_single(var_1, "vegas_train_fall");
    break;
  }
}

train_crash_fx(var_0) {
  common_scripts\utility::flag_wait("FLAG_traincrash_start");

  if(self.script_noteworthy == "train1") {
    if(level.train_drippy_num_left > 2) {
      return;
    }
    level.train_drippy_num_left++;
    var_0 thread train_crash_fx_sparks(0, 0.25, "vfx_electrical_spark");
    var_0 thread train_crash_fx_sparks(randomfloatrange(0.5, 0.7), 0.2);
    var_0 thread train_crash_fx_sparks(randomfloatrange(1.15, 1.45), 0.3);
    var_0 thread train_crash_fx_sparks(randomfloatrange(2.15, 2.35), 0.4);
    common_scripts\utility::exploder(3);
    wait 0.6;
    common_scripts\utility::exploder("train_fall_track_impact");
    common_scripts\utility::exploder(3);
    wait 2.2;
    common_scripts\utility::exploder(1);
  } else {
    if(level.train_drippy_num_right > 0) {
      return;
    }
    level.train_drippy_num_right++;
    var_0 thread train_crash_fx_sparks(0, 0.3, "vfx_electrical_spark");
  }
}

train_crash_fx_sparks(var_0, var_1, var_2) {
  var_3 = "vfx_train_track_sparks";

  if(isDefined(var_2))
    var_3 = var_2;

  wait(var_0);
  var_4 = gettime();
  var_1 = var_1 * 1000;

  while(gettime() - var_4 <= var_1) {
    var_5 = anglesToForward((0, 90, randomintrange(-360, 360)));
    playFX(common_scripts\utility::getfx(var_3), self.origin, var_5);
    wait(randomfloatrange(0.1, 0.25));
  }
}

train_quake_crash() {
  wait 0.7;
  earthquake(0.2, 0.5, level.player.origin, 1000);
  wait 2.2;
  earthquake(0.4, 0.8, level.player.origin, 1000);
}

off_timed_run_back(var_0, var_1) {
  foreach(var_3 in var_0) {
    var_3 endon("death");
    wait(randomfloatrange(0.3, 1));
    var_3.ignoreall = 1;
    var_3 setgoalvolumeauto(var_1);
    var_3 thread reset_ignore_for_enemy();
  }
}

attack_if_player_close_when_retreating() {
  self endon("death");

  for(;;) {
    if(distance2d(level.player.origin, self.origin) <= 300) {
      self.ignoreall = 0;
      self setgoalentity(level.player);
      break;
    }

    wait 0.3;
  }
}

reset_ignore_for_enemy() {
  self endon("death");
  self waittill("goal");
  self.ignoreall = 0;
  wait 10;
  self.goalradius = 2048;
}

exfil() {
  common_scripts\utility::flag_wait("exfil");
  thread exfil_end();
  maps\_vehicle::spawn_vehicles_from_targetname_and_drive("exfil_chopper");
  common_scripts\utility::flag_wait("exfil_f18");
  thread maps\_utility::smart_radio_dialogue("vegas_hsh_letsgoadammove");
  var_0 = ["vegas_mrk_movethisthingget", "vegas_mrk_choppers"];

  foreach(var_3, var_2 in level.exfil_choppers) {
    maps\_utility::delaythread(1, maps\_utility::smart_radio_dialogue, var_0[var_3]);
    level thread f18_sidewinder(var_2);
    wait 2;
  }

  if(isDefined(level.courtyard.choppers)) {
    level.courtyard.choppers = common_scripts\utility::array_removeundefined(level.courtyard.choppers);

    foreach(var_2 in level.courtyard.choppers) {
      if(isDefined(var_2))
        level thread f18_sidewinder(var_2);

      wait 0.5;
    }
  }

  wait 2;
  var_6 = getEntArray("courtyard_color_triggers", "script_noteworthy");
  common_scripts\utility::array_call(var_6, ::delete);
  maps\_utility::delaythread(4, maps\_utility::activate_trigger, "color_get_to_bus", "targetname");
  maps\_vehicle::spawn_vehicles_from_targetname_and_drive("exfil_f18");
  thread exfil_silenthawk();
}

f18_sidewinder(var_0) {
  var_1 = getent("sidewinder", "targetname");
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel(var_1.model);
  playFXOnTag(common_scripts\utility::getfx("smoke_geotrail_rpg"), var_2, "tag_fx");
  var_2 playLoopSound("sidewinder_loop");
  var_3 = squared(200);
  var_4 = 500;
  var_5 = 8800.0;
  var_2 rotateroll(1280, randomfloatrange(4, 6));
  var_6 = (0, 0, -70);
  var_7 = undefined;

  for(;;) {
    if(isDefined(var_0))
      var_7 = var_0.origin;
    else
      var_7 = (-20000, randomfloatrange(-38000, -36000), randomfloatrange(3000, 6000));

    if(var_2.origin[0] > var_7[0]) {
      break;
    }

    var_8 = vectornormalize(var_7 + var_6 - var_2.origin);
    var_7 = var_2.origin + var_8 * var_4;
    var_9 = var_4 / var_5;
    var_2 moveto(var_7, var_9);
    wait(var_9);
  }

  if(isDefined(var_0)) {
    var_0 vehicle_turnengineoff();
    thread common_scripts\utility::play_sound_in_space("sidewinder_exp", var_7);
    var_0 kill();
  }

  var_2 delete();
}

postspawn_exfil_chopper() {
  if(!isDefined(level.exfil_choppers))
    level.exfil_choppers = [];

  if(self.script_index == 1)
    self.preferred_death_anim = "aas_72x_explode_C";
  else
    self.preferred_death_anim = "aas_72x_explode_B";

  level.exfil_choppers[level.exfil_choppers.size] = self;
  common_scripts\utility::waittill_either("death", "reached_dynamic_path_end");
  common_scripts\utility::flag_set("exfil_f18");
}

postspawn_exfil_f18() {
  var_0 = spawn("script_origin", self.origin + (-1000, 0, 0));
  var_0 linkto(self);

  if(isDefined(self.script_index))
    var_0 playSound("veh_f18_long_flyby2");
  else
    var_0 playSound("veh_f18_long_flyby");
}

exfil_silenthawk() {
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("exfil_silenthawk_hover");
  var_0 thread exfil_hover();
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("exfil_silenthawk");
  var_1 waittillmatch("noteworthy", "exfil_dialogue");
  thread exfil_chopper_dialogue();
  var_1 waittillmatch("noteworthy", "land");
  var_1 notify("newpath");
  var_2 = var_1.currentnode;
  var_2 = common_scripts\utility::getstruct(var_2.target, "targetname");
  var_1 setgoalyaw(var_2.angles[1]);
  var_1 setvehgoalpos(var_2.origin, 1);
  var_1 sethoverparams(10, 5, 15);
  var_1 setneargoalnotifydist(100);
  var_1 waittill("near_goal");
  thread exfil_trigger(var_1);
}

exfil_chopper_dialogue() {
  maps\_utility::smart_radio_dialogue("vegas_hsh_gogo");
  wait 2;
  maps\_utility::smart_radio_dialogue("vegas_mrk_wegottalosesome");
  level.hesh maps\_utility::smart_dialogue("vegas_kgn_hardrighthardright");
}

exfil_end() {
  common_scripts\utility::flag_wait("exfil_run");

  if(!level.dog maps\_utility::ent_flag("picked_up"))
    level.dog maps\_utility::ent_flag_wait("picked_up");

  level.dog maps\_utility::ent_flag_set("disable_put_down");
  level.dog maps\las_vegas_code::dog_disable_trigger();
  level.hesh thread maps\_utility::smart_dialogue("vegas_hsh_leftsidesgettinghit");
  common_scripts\utility::flag_wait("exfil_reached");
  thread exfil_fade();
  maps\_utility::smart_radio_dialogue("vegas_hsh_ontheright");
  maps\_utility::smart_radio_dialogue("vegas_mrk_thisthingsdragginass");
  maps\_utility::nextmission();
}

exfil_fade() {
  common_scripts\utility::flag_wait("exfil_fade");
  maps\_hud_util::fade_out(3);
  level.player freezecontrols(1);
}

exfil_trigger(var_0) {
  var_1 = spawn("trigger_radius", var_0.origin + (0, 0, -200), 0, 800, 500);
  var_1 waittill("trigger");
  common_scripts\utility::flag_set("exfil_reached");
  var_1.radius = 300;
  var_1 waittill("trigger");
  common_scripts\utility::flag_set("exfil_fade");
}

exfil_hover() {
  self waittillmatch("noteworthy", "hover");
  self notify("newpath");
  var_0 = get_hover_points();
  self setneargoalnotifydist(300);
  var_1 = get_nearest_hover_point(var_0);

  for(;;) {
    for(var_2 = var_1; var_2 < var_0.size; var_2++) {
      self setvehgoalpos(var_0[var_2]);
      self waittill("near_goal");
    }

    var_1 = 0;
  }
}

get_nearest_hover_point(var_0) {
  var_1 = 0;
  var_2 = distancesquared(var_0[0], self.origin);

  foreach(var_6, var_4 in var_0) {
    var_5 = distancesquared(var_4, self.origin);

    if(var_5 < var_2) {
      var_1 = var_6;
      var_2 = var_5;
    }
  }

  return var_1;
}

get_hover_point(var_0, var_1) {
  var_2 = 24.0;
  var_3 = (0, var_2 * var_1, 0);
  var_4 = anglesToForward(var_3);
  var_5 = var_0.origin + var_4 * var_0.radius;
  return var_5;
}

get_hover_points() {
  var_0 = [];
  var_1 = common_scripts\utility::getstruct("exfil_hover_struct", "targetname");

  for(var_2 = 0; var_2 < 15; var_2++)
    var_0[var_2] = get_hover_point(var_1, var_2);

  return var_0;
}

postspawn_entrance_chopper() {
  self.quick_getout = 1;
  level.courtyard.choppers = common_scripts\utility::array_removeundefined(level.courtyard.choppers);
  level.courtyard.choppers[level.courtyard.choppers.size] = self;
  thread maps\las_vegas_code::vehicle_path_notifies();
  self setmaxpitchroll(60, 40);
}

postspawn_entrance_chopper_unloader() {
  self setcontents(0);
  thread postspawn_entrance_chopper();

  foreach(var_1 in self.shooters) {
    var_2 = var_1.vehicle_position;
    var_3 = 0;

    if(var_2 == 2)
      var_1.delay = 0 + var_3;
    else if(var_2 == 3)
      var_1.delay = 1 + var_3;
    else if(var_2 == 4)
      var_1.delay = 3 + var_3;
    else if(var_2 == 5)
      var_1.delay = 4 + var_3;

    var_1 thread entrance_enemy_alert_thread();
  }
}

postspawn_entrance_chopper_shooter() {
  thread postspawn_entrance_chopper();
  maps\las_vegas_code::enable_shooters(0);
  common_scripts\utility::flag_wait("entrance_combat_start");
  maps\las_vegas_code::enable_shooters(1);
  self setmaxpitchroll(30, 30);
  self sethoverparams(60, 20, 50);
  self waittill("reached_dynamic_path_end");
  wait 0.5;
  level.courtyard.chopper_shooter_count++;
  self.shooter_side = "left";
  thread maps\las_vegas_code::chopper_shooter_init("courtyard_dyn_path");
}

postspawn_courtyard_chopper() {
  self.quick_getout = 1;
  level.courtyard.choppers = common_scripts\utility::array_removeundefined(level.courtyard.choppers);
  level.courtyard.choppers[level.courtyard.choppers.size] = self;
  thread maps\las_vegas_code::vehicle_path_notifies();
  thread maps\las_vegas_code::shooter_range();

  if(isDefined(self.shooters))
    common_scripts\utility::array_thread(self.shooters, ::unload_thread);
}

postspawn_chopper_shooter() {
  self endon("death");
  self.quick_getout = 1;
  level.courtyard.choppers = common_scripts\utility::array_removeundefined(level.courtyard.choppers);
  level.courtyard.choppers[level.courtyard.choppers.size] = self;
  thread maps\las_vegas_code::shooter_range();
  maps\las_vegas_code::enable_shooters(0);
  common_scripts\utility::flag_wait("chopper_shooter_is_needed");
  level.courtyard.chopper_shooter_count++;
  wait(randomfloatrange(20, 30));
  thread chopper_inbound_dialogue();
  thread maps\las_vegas_code::chopper_shooter_init("courtyard_dyn_path");
}

chopper_inbound_dialogue() {
  self endon("death");
  wait 4;
  level.merrick maps\_utility::smart_dialogue("vegas_mrk_keeppushingforwardtowards");
}

follow_path_node_anim(var_0) {
  if(!isDefined(var_0.animation)) {
    return;
  }
  var_1 = "normal";

  if(isDefined(var_0.script_type))
    var_1 = var_0.script_type;

  var_2 = var_0.animation;

  if(var_1 == "play_once")
    var_0.animation = undefined;

  var_3 = 1;

  if(isDefined(var_0.script_parameters)) {
    if(var_0.script_parameters == "no_arrivals")
      var_3 = 0;
  }

  if(!var_3) {
    maps\_utility::disable_arrivals();
    maps\_utility::disable_exits();
  }

  var_0 maps\_anim::anim_generic_reach(self, var_2);
  self notify("start_follow_path_anim");

  switch (var_1) {
    case "run_anim":
      var_0 maps\_anim::anim_generic_run(self, var_2);
      break;
    case "switch_to_sniper":
      thread switch_to_sniper(var_0);
      break;
    default:
      var_0 maps\_anim::anim_generic(self, var_2);
      break;
  }

  if(!var_3) {
    maps\_utility::enable_arrivals();
    maps\_utility::enable_exits();
  }
}

switch_to_sniper(var_0) {
  self orientmode("face angle", var_0.angles[1]);
  self animcustom(::switch_to_sniper_internal);
}

switch_to_sniper_internal() {
  var_0 = animscripts\utility::lookupanim("cqb", "shotgun_pullout");
  animscripts\run::shotgunswitchstandruninternal("sniper_pullout", var_0, "gun_2_chest", "none", self.secondaryweapon, "shotgun_pickup");
}

array_remove_after_index(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_1; var_3++)
    var_2[var_2.size] = var_0[var_3];

  return var_2;
}

get_script_index() {
  return self.script_index;
}