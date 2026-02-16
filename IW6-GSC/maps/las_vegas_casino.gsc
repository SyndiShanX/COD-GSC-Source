/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\las_vegas_casino.gsc
*****************************************************/

casino_spawn_functions() {
  maps\_utility::array_spawn_function_targetname("rescue_enemy_spawners", ::postspawn_rescue_enemy);
  maps\_utility::array_spawn_function_targetname("rescue_enemy_standers", ::postspawn_rescue_stander);
  maps\_utility::array_spawn_function_targetname("rescue_extra_enemies", ::postspawn_rescue_extra);
  maps\_utility::array_spawn_function_targetname("casino_bar_walkers", ::postspawn_bar_enemy);
  maps\_utility::array_spawn_function_targetname("bar_talkers", ::postspawn_bar_talker);
  maps\_utility::array_spawn_function_targetname("kitchen_enemy_spawners", ::postspawn_kitchen_enemy);
  maps\_utility::array_spawn_function_targetname("kitchen_reinforcements", ::postspawn_kitchen_reinforcement);
  maps\_utility::array_spawn_function_targetname("drag1_enemies", ::postspawn_drag_enemies);
  maps\_utility::array_spawn_function_targetname("drag2_enemies", ::postspawn_drag_enemies);
  maps\_utility::array_spawn_function_targetname("atrium_escalator_enemies", ::postspawn_atrium_enemy);
  maps\_utility::array_spawn_function_targetname("atrium_balcony_enemies", ::postspawn_atrium_enemy);
  maps\_utility::array_spawn_function_targetname("atrium_balcony_reinforcements", ::postspawn_balcony_reinforcement);
  maps\_utility::array_spawn_function_noteworthy("kitchen_flashlight_enemy", ::postspawn_kitchen_flashlight);
  maps\_utility::array_spawn_function_noteworthy("kitchen_flashlight_enemy", maps\_utility::set_moveplaybackrate, 1.2);
  maps\_utility::array_spawn_function_targetname("floor_ambush_spawners", ::postspawn_floor_ambush);
  maps\_utility::array_spawn_function_noteworthy("floor_spawners", ::postspawn_floor_enemy);
  maps\_utility::array_spawn_function_noteworthy("floor_last_spawners", ::postspawn_floor_gate);
  maps\_utility::array_spawn_function_targetname("chase_room_enemies", ::postspawn_chase_room_enemies);
  maps\_utility::array_spawn_function_targetname("chase_enemies", ::postspawn_chase_enemies);
  maps\_utility::array_spawn_function_targetname("floor_snipers", ::postspawn_floor_sniper);
}

casino_threatbias_groups() {
  createthreatbiasgroup("drones_stealth");
  maps\_utility::ignoreeachother("heroes", "drones_stealth");
  setthreatbias("heroes", "drones_stealth", 0);
  createthreatbiasgroup("chase_wall");
  maps\_utility::ignoreeachother("heroes", "chase_wall");
  setthreatbias("heroes", "chase_wall", 0);
}

main_init() {
  if(isDefined(level.casino_init)) {
    return;
  }
  level.casino_init = 1;
  thread maps\_utility::battlechatter_off("allies");
  thread maps\_utility::battlechatter_off("axis");
}

start_ambush() {
  maps\las_vegas_code::disable_all_triggers();
}

start_drag1() {
  maps\las_vegas_code::disable_all_triggers();
  maps\_hud_util::fade_out(0, "black");
}

start_drag2() {
  maps\las_vegas_code::disable_all_triggers();
  maps\_hud_util::fade_out(0, "black");
}

start_elias_death() {
  maps\las_vegas_code::disable_all_triggers();
  maps\_hud_util::fade_out(0, "black");
}

start_rescue() {
  maps\las_vegas_code::set_player_speed();
  maps\las_vegas_code::disable_all_triggers();
  maps\las_vegas_code::spawn_hero("merrick");
  maps\las_vegas_code::spawn_hero("hesh");
  maps\las_vegas_code::set_start_locations("rescue_start_spots");
  maps\_hud_util::fade_out(0, "black");
  main_init();
}

start_bar() {
  maps\las_vegas_code::set_player_speed();
  maps\las_vegas_code::spawn_hero("merrick");
  maps\las_vegas_code::spawn_hero("hesh");
  maps\las_vegas_code::set_start_locations("bar_startspots");
  common_scripts\utility::array_thread(level.heroes, maps\las_vegas_code::start_scripted_movement);
  level.hesh maps\_utility::set_archetype("creepwalk");
  level.merrick maps\las_vegas_code::set_wounded();
  common_scripts\utility::flag_set("merrick_human_shield_ready");
}

start_kitchen() {
  maps\las_vegas_code::set_player_speed();
  maps\las_vegas_code::spawn_hero("merrick");
  maps\las_vegas_code::spawn_hero("hesh");
  maps\las_vegas_code::set_start_locations("kitchen_startspots");
  level.hesh maps\_utility::set_archetype("creepwalk");
  level.merrick maps\las_vegas_code::set_wounded();
  common_scripts\utility::array_thread(level.heroes, maps\las_vegas_code::start_scripted_movement);
  maps\las_vegas_code::init_enemy_radio(1);
}

start_atrium() {
  maps\las_vegas_code::set_player_speed();
  maps\las_vegas_code::set_start_locations("atrium_startspots");
  level.hesh maps\_utility::set_archetype("creepwalk");
  common_scripts\utility::array_thread(level.heroes, maps\las_vegas_code::start_scripted_movement);
}

start_casino_floor() {
  maps\las_vegas_code::set_player_speed();
  common_scripts\utility::flag_set("player_atrium_halfway");
  maps\las_vegas_code::set_start_locations("casino_floor_startspots");
  common_scripts\utility::array_thread(level.heroes, maps\las_vegas_code::start_scripted_movement);
  common_scripts\utility::array_thread(level.heroes, maps\_utility::enable_cqbwalk);
}

start_hotel() {
  maps\las_vegas_code::set_player_speed();
  maps\las_vegas_code::set_start_locations("casino_hotel_startspots");
  common_scripts\utility::array_thread(level.heroes, maps\_utility::enable_cqbwalk);
}

start_hotel_chase() {
  maps\las_vegas_code::set_player_speed();
  common_scripts\utility::flag_set("player_in_hotel");
  maps\las_vegas_code::set_start_locations("hotel_chase_startspots");
  common_scripts\utility::array_thread(level.heroes, maps\las_vegas_code::start_scripted_movement);
  common_scripts\utility::array_thread(level.heroes, maps\_utility::enable_cqbwalk);
}

start_slide() {
  maps\las_vegas_code::set_player_speed();
  common_scripts\utility::flag_set("start_outside_animated_props");
  common_scripts\utility::array_thread(level.heroes, maps\_utility::enable_cqbwalk);
}

ambush() {
  maps\las_vegas_code::disable_all_triggers();
  main_init();
  level.player takeallweapons();
  var_0 = "r5rgp_gundown+acog_sp";
  level.player giveweapon(var_0);
  level.player givemaxammo(var_0);
  level.player switchtoweapon(var_0);
  disable_player_settings(1);
  maps\las_vegas_code::spawn_hero("elias_intro");
  maps\las_vegas_code::spawn_hero("merrick_intro");
  maps\las_vegas_code::spawn_hero("hesh_intro");
  maps\las_vegas_code::spawn_hero("riley");
  maps\las_vegas_code::set_player_speed("ambush", 0.05);
  maps\las_vegas_code::set_start_locations("ambush_startspots");
  level.elias maps\_utility::delaythread(1, maps\_utility::smart_dialogue, "vegas_els_jsocllwanttomove");
  maps\las_vegas_code::intro_time(&"LAS_VEGAS_INTRO_TIME1", 8, 3, 1);
  level.dog.movementtype = "walk";
  level.dog thread maps\las_vegas_code::start_scripted_movement();
  var_1 = common_scripts\utility::getstruct("ambush_struct", "targetname");
  var_2 = [level.hesh, level.elias, level.merrick];
  maps\_utility::delaythread(11, ::ambush_gas_grenades);
  maps\_utility::delaythread(15, ::ambush_riley_getout);
  maps\_utility::delaythread(10, ::riley_bark);
  maps\_utility::delaythread(14, ::player_fall);
  thread ambush_dialogue();
  var_1 maps\_anim::anim_single(var_2, "ambush");
  level.dog maps\_utility_dogs::kill_dog_fur_effect();

  foreach(var_4 in level.heroes) {
    if(isDefined(var_4.magic_bullet_shield))
      var_4 maps\_utility::stop_magic_bullet_shield();

    var_4.allowdeath = 1;
    var_4.a.nodeath = 1;
    var_4.script_noteworthy = "";
    var_4 kill();
  }

  common_scripts\utility::flag_wait("ambush_done");

  foreach(var_7 in level.gas_grenades) {
    if(!isDefined(var_7)) {
      continue;
    }
    if(isDefined(var_7.fx))
      var_7.fx delete();

    var_7 delete();
  }

  var_9 = getcorpsearray();

  foreach(var_11 in var_9)
  var_11 delete();
}

disable_player_settings(var_0) {
  var_0 = !var_0;
  level.player allowfire(var_0);
  level.player allowads(var_0);
  level.player allowprone(var_0);
  level.player allowjump(var_0);
  level.player allowsprint(var_0);
  level.player allowmelee(var_0);
  setsaveddvar("cg_drawcrosshair", var_0);
}

ambush_dialogue() {
  level.merrick maps\_utility::delaythread(3.8, maps\_utility::smart_dialogue, "vegas_mrk_holdup");
  level.merrick maps\_utility::delaythread(5.5, maps\_utility::smart_dialogue, "vegas_mrk_somethingfeeloffto");
  maps\_utility::delaythread(13.3, maps\_utility::music_play, "mus_vegas_kidnapped");
}

riley_bark() {
  level.dog.defaultidlestateoverride = "alertidle";

  for(var_0 = 0; var_0 < 10; var_0++) {
    if(common_scripts\utility::flag("ambush_riley_getout")) {
      return;
    }
    level.dog maps\_utility_dogs::dog_bark();
  }
}

ambush_riley_getout() {
  level.dog.movementtype = "run";
  common_scripts\utility::flag_set("ambush_riley_getout");
}

ambush_gas_grenades() {
  var_0 = common_scripts\utility::getStructArray("ambush_nade_structs", "targetname");
  var_0 = common_scripts\utility::array_randomize(var_0);

  foreach(var_3, var_2 in var_0) {
    if(common_scripts\utility::flag("ambush_done")) {
      return;
    }
    thread maps\las_vegas_code::launch_gas_grenade(var_2, var_3);
    wait(randomfloatrange(0.3, 0.6));
  }
}

player_fall() {
  thread player_drunk();
  thread common_scripts\utility::play_sound_in_space("scn_vegas_gassed_plr_fall", level.player.origin);
  level.player disableweapons();
  maps\las_vegas_code::ui_show_stance(0);
  disable_player_settings(0);
  level.player common_scripts\utility::delaycall(0.5, ::allowstand, 0);
  level.player common_scripts\utility::delaycall(2, ::allowcrouch, 0);
  maps\_utility::delaythread(2, common_scripts\utility::flag_set, "player_drunk");
  maps\_utility::delaythread(4, ::blur_pulse);
  var_0 = 2;
  maps\_utility::player_speed_set(10, var_0);
  level.player shellshock("vegas_gas", 30);
  level.player playrumbleonentity("grenade_rumble");
  level.player thread maps\_utility::play_sound_on_entity("scn_vegas_plr_cough");
  level.player allowjump(0);
  level.player setclienttriggeraudiozone("las_vegas_gassed_black", 6);
  thread pulse_in_out();
  thread gas_rorke_shows_up();
  var_1 = common_scripts\utility::spawn_tag_origin();
  level.player playersetgroundreferenceent(var_1);
  var_1 common_scripts\utility::delaycall(2, ::rotatepitch, -10, 3, 1, 2);
  var_1 common_scripts\utility::delaycall(4, ::rotatepitch, 30, 8, 5, 2);
  level.player common_scripts\utility::delaycall(2, ::playrumbleonentity, "damage_heavy");
  wait 10;
  setblur(60, 4);
  level notify("stop_pulsing");
  thread maps\_hud_util::fade_out(4);
  wait 4.5;
  level.player allowstand(1);
  level.player allowcrouch(1);
  level.player takeallweapons();
  level.player unlink();
  level.player playersetgroundreferenceent(undefined);
  var_1 delete();
  common_scripts\utility::flag_set("ambush_done");
}

blur_pulse() {
  thread maps\_hud_util::fade_out(2);
  setblur(15, 1);
  wait 1;
  level.player thread maps\_utility::play_sound_on_entity("breathing_limp_better");
  thread maps\_hud_util::fade_in(1);
  setblur(0, 2);
}

pitch_and_roll() {
  self notify("stop_bob");
  self endon("stop_bob");
  self endon("death");
  var_0 = self;
  var_1 = (0, var_0.angles[1], 0);
  var_2 = 20;

  if(isDefined(var_0.script_max_left_angle))
    var_2 = var_0.script_max_left_angle;

  var_3 = 1;

  if(var_2 < 0)
    var_3 = 4;

  var_4 = var_2 * 0.5 * var_3;
  var_5 = 4;

  if(isDefined(var_0.script_duration))
    var_5 = var_0.script_duration;

  var_6 = var_5 * 0.5;
  var_0 = undefined;

  for(;;) {
    var_7 = (randomfloatrange(var_4, var_2), 0, randomfloatrange(var_4, var_2));
    var_8 = randomfloatrange(var_6, var_5);
    self rotateto(var_1 + var_7, var_8, var_8 * 0.2, var_8 * 0.2);
    self waittill("rotatedone");
    self rotateto(var_1 - var_7, var_8, var_8 * 0.2, var_8 * 0.2);
    self waittill("rotatedone");
  }
}

gas_rorke_shows_up() {
  wait 5;
  level notify("stop_pulsing");
  setblur(10, 1);
  maps\_hud_util::fade_out(1);

  if(isDefined(level.dog))
    level.dog hide();

  maps\las_vegas_code::spawn_rorke();
  level.rorke maps\_utility::gun_remove();
  level.rorke setlookatentity(level.player);
  var_0 = maps\_utility::array_spawn_targetname("elite_gas_guys");

  foreach(var_2 in var_0)
  var_2 thread gas_guys_think();

  var_4 = common_scripts\utility::get_target_ent("rorke_gas_pos");
  var_4 thread maps\_anim::anim_generic_loop(level.rorke, "NML_vargas_idle");
  var_5 = common_scripts\utility::get_target_ent("gas_player_final_pos");
  level.player setorigin(var_5.origin);
  level.player setplayerangles(var_5.angles);
  wait 0.15;
  level notify("stop_player_drunk");
  level.player pushplayervector((0, 0, 0));
  setblur(1, 3);
  maps\_hud_util::fade_in(1.5);
  thread pulse_in_out();
  common_scripts\utility::flag_wait("ambush_done");
  level.rorke delete();
  common_scripts\utility::array_call(var_0, ::delete);
}

gas_guys_think(var_0) {
  maps\_utility::set_generic_run_anim("london_dock_soldier_walk");
  maps\_utility::walkdist_zero();
  maps\_utility::disable_arrivals();
  maps\_utility::disable_exits();
  self.goalradius = 32;
  self.combatmode = "no_cover";

  if(self.script_index == 0)
    self.moveplaybackrate = 0.5;
  else
    self.moveplaybackrate = 0.3;

  self setgoalentity(level.player);
}

pulse_in_out(var_0) {
  level endon("stop_pulsing");

  for(;;) {
    thread maps\_hud_util::fade_out(10, var_0);
    wait 4;
    thread maps\_hud_util::fade_in(5, var_0);
    wait 3;
  }
}

player_drunk() {
  level endon("stop_player_drunk");
  common_scripts\utility::flag_init("player_drunk");
  var_0 = 1;
  var_1 = 0;
  var_2 = 0;

  while(!common_scripts\utility::flag("ambush_done") && !common_scripts\utility::flag("player_drunk")) {
    var_3 = sin(gettime() * 0.15) * 4;
    var_4 = cos(gettime() * 0.15) * -3;
    level.player pushplayervector((var_3, var_4, 0));

    if(var_3 == 0)
      var_0 = var_0 * -1;

    wait 0.05;
  }

  level.player pushplayervector((0, 0, 0));
}

drag1() {
  common_scripts\utility::waitframe();
  maps\las_vegas_code::ui_show_stance(0);
  level.player setclienttriggeraudiozone("las_vegas_drag1", 5);
  level.ground_ref_ent = common_scripts\utility::spawn_tag_origin();
  level.player playersetgroundreferenceent(level.ground_ref_ent);
  level.ground_ref_ent.script_max_left_angle = 30;
  level.ground_ref_ent.script_duration = 3;
  level.ground_ref_ent thread pitch_and_roll();
  thread maps\las_vegas_code::intro_time(&"LAS_VEGAS_INTRO_TIME2", 5, 3);
  level.player shellshock("vegas_drag", 999);
  maps\_utility::array_spawn_targetname("drag1_enemies", 1);
  var_0 = common_scripts\utility::getstruct("drag1_struct", "targetname");
  level.player common_scripts\utility::delaycall(3, ::playrumblelooponentity, "vegas_drag");
  thread blur_fadein();
  thread maps\las_vegas_code::do_player_drag(var_0);
  var_0 = common_scripts\utility::getstruct("drag1_hesh_struct", "targetname");
  thread maps\las_vegas_code::do_hesh_drag(var_0);
  thread drag1_audio();
  wait 7;
  level.player common_scripts\utility::delaycall(6, ::stoprumble, "vegas_drag");
  blur_fadeout();
}

drag1_audio() {
  level.player maps\_utility::delaythread(3.0, maps\_utility::play_sound_on_entity, "scn_vegas_dragged1_plr");
}

postspawn_drag_enemies() {
  if(!isDefined(level.drag_enemies))
    level.drag_enemies = [];

  level.drag_enemies[level.drag_enemies.size] = self;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.goalradius = 4;
  self.script_forcegoal = 1;
  maps\_utility::disable_arrivals();

  if(!isDefined(self.target))
    self setgoalpos(self.origin);

  maps\_utility::set_generic_run_anim("active_patrolwalk_gundown");
}

blur_fadein(var_0) {
  level notify("stop_any_blur");
  level endon("stop_any_blur");

  if(!isDefined(var_0))
    var_0 = 30;

  setblur(var_0, 0.1);
  wait 2;
  thread maps\_hud_util::fade_in(5, "black");
  setblur(0, 5);
}

dof_on(var_0) {
  maps\_art::dof_enable_script(1, 1799, 30, 1800, 3800, 10, var_0);
}

dof_off(var_0) {
  maps\_art::dof_disable_script(var_0);
}

blur_fadeout(var_0) {
  if(!isDefined(var_0))
    var_0 = 5;

  level notify("stop_any_blur");
  level endon("stop_any_blur");
  level.player setclienttriggeraudiozone("las_vegas_between_drags_black", var_0);
  setblur(10, var_0);
  thread maps\_hud_util::fade_out(var_0, "black");
  wait(var_0);
}

drag2() {
  if(!isDefined(level.ground_ref_ent)) {
    level.ground_ref_ent = common_scripts\utility::spawn_tag_origin();
    level.player playersetgroundreferenceent(level.ground_ref_ent);
  }

  maps\las_vegas_code::ui_show_stance(0);
  level.ground_ref_ent.script_max_left_angle = -10;
  level.ground_ref_ent.script_duration = 3;
  level.ground_ref_ent thread pitch_and_roll();
  common_scripts\utility::waitframe();
  level.player setclienttriggeraudiozone("las_vegas_drag2", 5);
  level.player shellshock("vegas_drag", 999);
  maps\_utility::array_spawn_targetname("drag2_enemies", 1);
  var_0 = common_scripts\utility::getstruct("drag2_struct", "targetname");
  thread blur_fadein();
  maps\_utility::delaythread(7, ::blur_pulse);
  level.player common_scripts\utility::delaycall(3, ::playrumblelooponentity, "vegas_drag");
  thread maps\las_vegas_code::do_player_drag(var_0);
  thread merrick_beatup();
  var_0 = common_scripts\utility::getstruct("drag2_hesh_struct", "targetname");
  thread maps\las_vegas_code::do_hesh_drag(var_0);
  thread drag2_audio();
  common_scripts\utility::flag_wait("drag2_start_fadeout");
  level.player common_scripts\utility::delaycall(7, ::stoprumble, "vegas_drag");
  blur_fadeout(7);
  maps\las_vegas_code::cleanup_player_drag();
  maps\_utility::cleanup_ents("drag2");
}

drag2_audio() {
  level.player maps\_utility::delaythread(3.0, maps\_utility::play_sound_on_entity, "scn_vegas_dragged2_plr");
}

merrick_beatup() {
  var_0 = common_scripts\utility::getstruct("drag2_beatup_struct", "targetname");
  var_1 = [];
  var_2 = getEntArray("beatup_spawners", "targetname");

  foreach(var_4 in var_2)
  var_1[var_1.size] = var_4 spawndrone();

  var_6 = undefined;
  var_7 = undefined;

  foreach(var_9 in var_1) {
    maps\_utility::add_cleanup_ent(var_9, "drag2");

    if(isDefined(var_9.script_noteworthy) && var_9.script_noteworthy == "merrick") {
      var_9.animname = "merrick";
      var_6 = var_9;
    } else {
      var_9.animname = "enemy";
      var_7 = var_9;
    }

    var_9.origin = var_0.origin;
    var_9 maps\_anim::setanimtree();
  }

  thread merrick_beatup_sounds(var_6, var_7);
  wait 6;
  level notify("start_beatup");
  var_0 maps\_anim::anim_single(var_1, "beatup");
}

merrick_beatup_sounds(var_0, var_1) {
  var_1 maps\_utility::delaythread(0, maps\_utility::smart_dialogue, "vegas_rke_itsinthemanual");
  var_1 maps\_utility::delaythread(2, maps\_utility::smart_dialogue, "vegas_rke_thatanditook");
  var_1 maps\_utility::delaythread(5, maps\_utility::smart_dialogue, "vegas_els_iunderstandaboutbreaking");
  level waittill("start_beatup");
  maps\_utility::delaythread(2.05, common_scripts\utility::play_sound_in_space, "drag_punch", var_0 gettagorigin("j_head"));
  maps\_utility::delaythread(3.65, common_scripts\utility::play_sound_in_space, "drag_punch", var_0 gettagorigin("j_head"));
  maps\_utility::delaythread(5.15, common_scripts\utility::play_sound_in_space, "drag_punch", var_0 gettagorigin("j_head"));
  maps\_utility::delaythread(5.8, common_scripts\utility::play_sound_in_space, "drag_punch", var_0 gettagorigin("j_head"));
  var_0 maps\_utility::delaythread(7, maps\_utility::smart_dialogue, "vegas_rke_killthesonin");
  var_1 maps\_utility::delaythread(9, maps\_utility::smart_dialogue, "vegas_pmc3_wevebeenatthis");
}

elias_death() {
  wait 2;
  maps\las_vegas_code::ui_show_stance(0);
  thread maps\las_vegas_code::intro_time(&"LAS_VEGAS_INTRO_TIME4", 5, 3);
  maps\las_vegas_code::sun_direction("elias_death");
  setdvarifuninitialized("intro_origin", "");
  setdvarifuninitialized("intro_angles", "");
  setdvarifuninitialized("eliasdeath_win", "0");

  if(isDefined(level.ground_ref_ent)) {
    level.player playersetgroundreferenceent(undefined);
    level.ground_ref_ent delete();
  }

  maps\las_vegas_code::spawn_hero("elias");
  maps\las_vegas_code::spawn_hero("hesh");
  maps\las_vegas_code::spawn_rorke();
  maps\las_vegas_code::init_player_body();
  maps\_utility::add_cleanup_ent(level.elias, "elias_death");
  maps\_utility::add_cleanup_ent(level.rorke, "elias_death");
  level.heroes = common_scripts\utility::array_removeundefined(level.heroes);
  var_0 = common_scripts\utility::array_add(level.heroes, level.rorke);

  foreach(var_2 in var_0) {
    var_2.ignoreall = 1;
    var_2.ignoreme = 1;
    var_2 maps\las_vegas_code::remove_name();
    var_2 maps\_utility::gun_remove();
  }

  level.rorke attach("viewmodel_mp443", "tag_inhand");
  var_4 = common_scripts\utility::getstruct("elias_death_struct", "targetname");
  var_0 = [level.hesh, level.elias, level.rorke, level.player.body, level.player.rig];
  var_4 maps\_anim::anim_first_frame(var_0, "elias_death_start");
  level.hesh.chair = maps\las_vegas_code::spawn_linked_model("com_cafe_chair", level.hesh, "tag_sync");
  level.elias.chair = maps\las_vegas_code::spawn_linked_model("com_cafe_chair", level.elias, "tag_sync");
  level.elias.chair common_scripts\utility::delaycall(5, ::unlink);
  maps\_utility::add_cleanup_ent(level.hesh.chair, "elias_death");
  maps\_utility::add_cleanup_ent(level.elias.chair, "elias_death");
  maps\_utility::add_cleanup_ent(level.player.body, "elias_death");
  var_4 maps\_anim::anim_first_frame_solo(level.player.rig, "elias_death_start");
  level.ground_ref_ent = common_scripts\utility::spawn_tag_origin();
  level.ground_ref_ent linkto(level.player.rig, "tag_player", (0, 0, 0), (0, 0, 0));
  level.player playersetgroundreferenceent(level.ground_ref_ent);
  level.player playerlinktodelta(level.player.rig, "tag_player", 1, 0, 0, 0, 0, 1);
  level.rorke.anim_playsound_func = maps\las_vegas_code::custom_playsound_on_ent;
  thread maps\las_vegas_code::print_fov();
  common_scripts\utility::flag_set("elias_death_start");
  elias_death_start(var_4);
  common_scripts\utility::flag_set("elias_death_struggle");
  elias_death_struggle(var_4);
  common_scripts\utility::flag_set("elias_death_end");
  elias_death_end(var_4);
  level.player.rig delete();
  maps\las_vegas_code::sun_direction("og");
}

elias_death_start(var_0) {
  level.player setclienttriggeraudiozone("las_vegas_torture", 2.0);
  level.player shellshock("vegas_chair", 999);
  level.player lerpfov(50, 0.1);
  var_1 = [level.hesh, level.elias, level.rorke, level.player.body, level.player.rig];
  wait 1;
  level.rorke maps\_utility::delaythread(1, maps\_utility::play_sound_on_tag, "vegas_rke_killthefatherin", "j_head");
  setblur(0, 1);
  thread elias_death_fadein();
  thread elias_death_start_sounds();
  wait 3;
  maps\_utility::delaythread(4, maps\_utility::autosave_now_silent);
  level.player lerpviewangleclamp(10, 0, 0, 35, 35, 60, 30);
  thread maps\las_vegas_code::print_timer();
  thread elias_death_visual_tweaks();
  level.elias maps\_utility::delaythread(67.8, maps\_utility::play_sound_on_tag, "vegas_els_death_efforts_1", "j_head");
  var_2 = getanimlength(level.rorke maps\_utility::getanim("elias_death_start"));
  var_0 thread maps\_anim::anim_single(var_1, "elias_death_start");
  level.player common_scripts\utility::delaycall(4.5, ::playrumbleonentity, "vegas_brash");
  level.player common_scripts\utility::delaycall(6.5, ::playrumbleonentity, "damage_heavy");
  wait(var_2);
  var_3 = 7;
  var_4 = level.rorke maps\_utility::getanim("elias_death_start_b");
  var_5 = getnotetracktimes(var_4, "player_fail");
  var_2 = getanimlength(var_4) * var_5[0];
  maps\_utility::delaythread(var_2 - var_3, maps\las_vegas_code::hand_hint_thread, maps\las_vegas_code::grab_gun_smash_count());
  level.player common_scripts\utility::delaycall(var_2 - var_3, ::lerpviewangleclamp, 2, 0, 0, 15, 35, 60, 30);
  level.player common_scripts\utility::delaycall(var_2 - var_3, ::springcamenabled, 1);
  level.player common_scripts\utility::delaycall(var_2 - var_3 + 2, ::springcamdisabled, 0);
  var_2 = getanimlength(level.rorke maps\_utility::getanim("elias_death_start_b"));
  var_0 = var_0 maps\las_vegas_code::makestruct();
  var_1 = common_scripts\utility::array_remove(var_1, level.player.rig);
  var_1 = common_scripts\utility::array_remove(var_1, level.player.body);
  var_0 thread maps\_anim::anim_single(var_1, "elias_death_start_b");
  wait(var_2);

  if(common_scripts\utility::flag("elias_death_player_failed"))
    level waittill("forever");
}

elias_death_visual_tweaks() {
  thread maps\_art::dof_enable_script(0, 0, 10, 35, 75, 6, 0.1);
  wait 7;
  thread elias_death_dof_normal();
  level.ground_ref_ent rotateto((-45, 30, 0), 1);
  level.player lerpfov(45, 8);
  common_scripts\utility::flag_wait("elias_death_struggle");
  level notify("stop_hurt_overlay");
  level.player lerpviewangleclamp(5, 3, 0, 5, 5, 0, 15);
  thread elias_death_dof_normal();
  thread maps\_hud_util::fade_in(5);
  common_scripts\utility::flag_wait("elias_death_end");
  level.player lerpviewangleclamp(2, 1, 1, 5, 5, 20, -5);
  level.player lerpfov(55, 0.5);
  level.player common_scripts\utility::delaycall(3, ::lerpviewangleclamp, 15, 1, 1, 25, 10, 30, -15);
  level.player common_scripts\utility::delaycall(28, ::lerpviewangleclamp, 4, 1, 1, 12, 10, 40, 2);
  level.player common_scripts\utility::delaycall(54, ::lerpviewangleclamp, 1, 0.5, 0.5, 5, 5, 5, 2);
}

elias_death_start_sounds() {
  wait 4.85;
  level.player maps\_utility::delaythread(0.0, maps\_utility::play_sound_on_entity, "scn_vegas_torture_plr_wakeup");
  wait 0.2;
  level.elias maps\_utility::delaythread(5.167, maps\_utility::play_sound_on_tag, "scn_vegas_torture_elias_01", "j_spinelower");
  level.elias maps\_utility::delaythread(31.2, maps\_utility::play_sound_on_tag, "scn_vegas_torture_elias_02", "j_spinelower");
  level.elias maps\_utility::delaythread(53.2, maps\_utility::play_sound_on_tag, "scn_vegas_torture_elias_03", "j_spinelower");
  level.elias maps\_utility::delaythread(59.167, maps\_utility::play_sound_on_tag, "scn_vegas_torture_elias_04", "j_spinelower");
  level.elias maps\_utility::delaythread(64.533, maps\_utility::play_sound_on_tag, "scn_vegas_torture_elias_05", "j_spinelower");
  level.rorke maps\_utility::delaythread(64.434, maps\_utility::play_sound_on_tag, "scn_vegas_torture_rorke_03", "j_spinelower");
  level.rorke maps\_utility::delaythread(5.933, maps\_utility::play_sound_on_tag, "scn_vegas_torture_rorke_01", "j_spinelower");
  level.rorke maps\_utility::delaythread(41.8, maps\_utility::play_sound_on_tag, "scn_vegas_torture_rorke_02", "j_spinelower");
  level.hesh maps\_utility::delaythread(24.533, maps\_utility::play_sound_on_entity, "scn_vegas_torture_hesh_01");
  level.hesh maps\_utility::delaythread(64.933, maps\_utility::play_sound_on_entity, "scn_vegas_torture_hesh_02");
}

audio_player_frees_hand() {
  level.player thread maps\_utility::play_sound_on_entity("scn_vegas_torture_plr_rope_free_hand");
}

audio_player_grabs_gun() {
  level.player thread maps\_utility::play_sound_on_entity("scn_vegas_torture_plr_grab_gun");
}

audio_player_takes_shot() {
  level.player thread maps\_utility::play_sound_on_entity("scn_vegas_torture_plr_shot");
}

elias_death_struggle(var_0) {
  level.player.rig show();
  level.player.body hide();
  var_1 = [level.hesh, level.elias, level.rorke, level.player.rig];
  thread maps\las_vegas_code::print_timer();
  level.player thread maps\_utility::play_sound_on_entity("scn_vegas_torture_plr_struggle");
  thread maps\las_vegas_code::hand_hint_thread(maps\las_vegas_code::struggle_smash_count(), 1);
  thread elias_death_struggle_thread(var_1, var_0);
  var_0 maps\_anim::anim_single(var_1, "elias_death_struggle");
  common_scripts\utility::flag_set("elias_death_struggle_done");
  stopallrumbles();
}

elias_death_struggle_thread(var_0, var_1) {
  wait 0.1;
  var_2 = 0.6;
  var_3 = 1;
  var_4 = level.hand_hint.check - 10;
  var_5 = level.hand_hint.check + 10;
  var_6 = var_5 - var_4;
  var_7 = maps\las_vegas_code::struggle_smash_count();
  var_8 = 0;

  while(!common_scripts\utility::flag("elias_death_struggle_done")) {
    if(isDefined(level.player.smash_use_pause)) {
      wait 0.2;
      continue;
    }

    if(maps\las_vegas_code::player_smash_check(var_7)) {
      var_8 = 1;
      break;
    }

    var_9 = 1 - (level.hand_hint.meter - var_4) / var_6;
    var_9 = clamp(var_9, var_2, var_3);
    maps\_anim::anim_set_rate(var_0, "elias_death_struggle", var_9);
    wait 0.05;
  }

  level notify("stop_player_smash_use");
  thread maps\las_vegas_code::cleanup_hand_hint();
  level.player common_scripts\utility::delaycall(1, ::playrumbleonentity, "vegas_brash");

  if(var_8) {
    level.rorke.playsound_ents = common_scripts\utility::array_removeundefined(level.rorke.playsound_ents);

    foreach(var_11 in level.rorke.playsound_ents)
    var_11 scalevolume(0, 0.2);

    common_scripts\utility::array_thread(var_0, maps\_utility::anim_stopanimscripted);
    var_1 maps\las_vegas_code::struct_stopanimscripted();
  }
}

elias_death_end(var_0) {
  var_1 = [level.hesh, level.elias, level.rorke, level.player.rig];
  var_2 = getanimlength(level.elias maps\_utility::getanim("elias_death_end"));
  thread elias_death_end_thread();
  thread maps\las_vegas_code::print_timer();
  thread elias_death_end_sounds();
  maps\_utility::delaythread(33, ::elias_death_blood_pool);
  maps\_utility::delaythread(36, maps\_hud_util::fade_in, 2);
  maps\_utility::delaythread(36, ::elias_death_dof_normal);
  level thread maps\_utility::notify_delay("stop_hurt_overlay", 35);
  var_0 = var_0 maps\las_vegas_code::makestruct();
  maps\_utility::delaythread(55.65, maps\las_vegas_anim::end_shot_ringing);
  level.player lerpviewangleclamp(2, 1, 1, 30, 30, 30, 30);
  var_0 thread maps\_anim::anim_single(var_1, "elias_death_end");
  level.player common_scripts\utility::delaycall(3, ::playrumbleonentity, "heavy_1s");
  level.elias waittillmatch("single anim", "end");
  level notify("stop_print_timer");
  common_scripts\utility::flag_wait("elias_death_done");
}

elias_death_dof_normal() {
  maps\_art::dof_disable_script(2);
}

elias_death_end_sounds() {
  maps\_utility::delaythread(3.5, maps\_utility::music_stop, 0.2);
  level.player maps\_utility::delaythread(0.9, maps\_utility::play_sound_on_entity, "scn_vegas_torture_plr_pistol_whipped");
  level.hesh maps\_utility::delaythread(4.734, maps\_utility::play_sound_on_entity, "scn_vegas_torture_hesh_03");
  level.elias maps\_utility::delaythread(5.333, maps\_utility::play_sound_on_tag, "scn_vegas_torture_elias_06", "j_spinelower");
  level.elias maps\_utility::delaythread(23.2, maps\_utility::play_sound_on_tag, "scn_vegas_torture_elias_07", "j_spinelower");
  level.rorke maps\_utility::delaythread(4.966, maps\_utility::play_sound_on_tag, "scn_vegas_torture_rorke_04", "j_spinelower");
  level.rorke maps\_utility::delaythread(43.633, maps\_utility::play_sound_on_tag, "scn_vegas_torture_rorke_06_gun", "tag_inhand");
  level.elias maps\_utility::delaythread(42.666, common_scripts\utility::play_sound_in_space, "scn_vegas_torture_rorke_05_foot", (-29126, -31533, 1392));
  level.player maps\_utility::delaythread(54.166, maps\_utility::play_sound_on_entity, "scn_vegas_torture_gun_to_head");
  level.player common_scripts\utility::delaycall(1.5, ::fadeoutshellshock);
  wait 2.85;
  level.player thread maps\_utility::play_sound_on_entity("pistol_hit");
  thread maps\_hud_util::fade_out(0.1, "white");
  wait 0.1;
  maps\_hud_util::fade_in(0.5, "white");
  thread maps\las_vegas_anim::player_hurt_overlay();
}

elias_death_fadein() {
  wait 0.1;
  var_0 = 12;
  wait 4;
  thread maps\_hud_util::fade_in(var_0);
  wait 3;
  thread maps\_hud_util::fade_in(0.2);
}

elias_death_blood_pool() {
  var_0 = level.elias gettagorigin("J_Spine4");
  var_0 = common_scripts\utility::drop_to_ground(var_0, 0, -100) + (0, 0, -1);
  playFX(common_scripts\utility::getfx("blood_pool"), var_0);
}

intro_struct_realign(var_0, var_1) {
  var_2 = common_scripts\utility::getstruct("elias_death_struct", "targetname");

  if(isDefined(var_0))
    var_2.origin = common_scripts\utility::drop_to_ground(var_0, 10, -200);
  else if(getDvar("intro_origin") != "") {
    var_3 = strtok(getDvar("intro_origin"), " ");
    var_2.origin = (float(var_3[0]), float(var_3[1]), float(var_3[2]));
    var_2.origin = common_scripts\utility::drop_to_ground(var_2.origin, 10, -200);
  }

  if(isDefined(var_1))
    var_2.angles = var_1 + (0, 90, 0);
  else if(getDvar("intro_angles") != "") {
    var_3 = strtok(getDvar("intro_angles"), " ");
    var_2.angles = (float(var_3[0]), float(var_3[1]) + 90, float(var_3[2]));
  }
}

elias_death_end_thread() {
  wait 0.1;
  var_0 = level.elias maps\_utility::getanim("elias_death_end");

  while(level.elias getanimtime(var_0) < 0.992)
    wait 0.05;

  maps\_utility::set_vision_set("lv_tunnel_overbloom", 0.1);
  level.player setclienttriggeraudiozone("las_vegas_post_torture_black", 0.1);
  wait 0.05;
  maps\_hud_util::fade_out(0, "black");
  wait 4;
  common_scripts\utility::flag_set("elias_death_done");
  level.player lerpfov(65, 0.1);

  if(isDefined(level.ground_ref_ent)) {
    level.player playersetgroundreferenceent(undefined);
    level.ground_ref_ent delete();
  }

  maps\_utility::delaythread(3, maps\_utility::cleanup_ents, "elias_death");
  maps\_utility::delaythread(0.2, maps\_utility::set_vision_set, "", 0.1);
}

rescue() {
  maps\las_vegas_code::ui_show_stance(0);
  thread maps\las_vegas_code::intro_time(&"LAS_VEGAS_INTRO_TIME5", 10, 3);
  var_0 = common_scripts\utility::getstruct("rescue_struct", "targetname");
  rescue_player_init(var_0);
  wait 8;
  level.player clearclienttriggeraudiozone(3);
  maps\_utility::delaythread(1, maps\_hud_util::fade_in, 5, "black");
  thread maps\_utility::autosave_now_silent();
  setsaveddvar("laserrange", 20000);
  maps\_utility::array_spawn_targetname("rescue_enemy_spawners", 1);
  maps\_utility::array_spawn_targetname("rescue_enemy_standers", 1);
  maps\las_vegas_code::spawn_hero("hesh");
  maps\las_vegas_code::spawn_hero("merrick");

  if(isDefined(level.elias))
    level.heroes = common_scripts\utility::array_remove(level.heroes, level.elias);

  level.heroes = common_scripts\utility::array_removeundefined(level.heroes);

  foreach(var_2 in level.heroes)
  var_2 maps\_utility::gun_remove();

  thread rescue_sniper();
  thread rescue_player_thread();
  thread player_flinch();
  thread rescue_dialogue();
  thread rescue_merrick_thread(var_0);
  thread maps\las_vegas_code::print_timer();
  level.merrick maps\las_vegas_code::set_wounded();
  thread rescue_sounds();
  level.hesh rescue_tie((-0.2, 0.5, 1), (0, -30, -270));
  level.merrick rescue_tie((-0.2, -0.5, 0.5), (0, -10, -90));
  level.hesh.tie common_scripts\utility::delaycall(40, ::delete);
  var_4 = common_scripts\utility::array_combine(level.heroes, level.rescue_enemies);
  var_0 maps\_anim::anim_single(var_4, "rescue");
  level.hesh waittillmatch("single anim", "end");
  common_scripts\utility::flag_set("show_chyron");
  level notify("stop_print_timer");
}

rescue_tie(var_0, var_1) {
  var_2 = getent(self.script_noteworthy + "_tie", "targetname");
  var_2 notsolid();
  var_2 linkto(self, "J_Wrist_RI", var_0, var_1);
  self.tie = var_2;
}

rescue_sounds() {
  level.hesh maps\_utility::delaythread(16.92, maps\_utility::play_sound_on_tag, "vegas_hsh_rescue_push", "j_head");
  level.hesh maps\_utility::delaythread(17.2, maps\_utility::play_sound_on_tag, "vegas_hsh_rescue_strike_1", "j_head");
  level.hesh maps\_utility::delaythread(19.2, maps\_utility::play_sound_on_tag, "vegas_hsh_rescue_strike_2", "j_head");
  var_0 = getent("gunner2_ai", "targetname");
  var_0 maps\_utility::delaythread(18.43, maps\_utility::play_sound_on_tag, "vegas_fs1_rescue_hit", "j_head");
  var_0 maps\_utility::delaythread(19.6, maps\_utility::play_sound_on_tag, "vegas_fs1_rescue_struggle", "j_head");
  var_0 maps\_utility::delaythread(20.92, maps\_utility::play_sound_on_tag, "vegas_fs1_rescue_strangle", "j_head");
}

rescue_merrick_thread(var_0) {
  level.merrick waittillmatch("single anim", "end");
  var_1 = getstartorigin(var_0.origin, var_0.angles, level.merrick maps\_utility::getanim("rescue_end"));
  level.merrick.goalradius = 8;
  level.merrick.dontavoidplayer = 1;
  level.merrick setgoalpos(var_1);
  level.merrick.grenadeammo = 0;
  level.merrick.tie delete();
  level.merrick maps\_utility::delaythread(0.5, maps\_utility::forceuseweapon, "msbs+eotech_sp", "primary");
  level.rescue_standers = common_scripts\utility::array_removeundefined(level.rescue_standers);
  common_scripts\utility::array_thread(level.rescue_standers, maps\_utility::set_ignoreme, 0);
  common_scripts\utility::array_thread(level.rescue_standers, maps\_utility::set_ignoreall, 0);
  level.merrick waittill("goal");
  level.merrick.ignoreall = 0;
  level.merrick.ignoreme = 0;
  common_scripts\utility::flag_wait("rescue_merrick_end");
  var_0 = var_0 maps\las_vegas_code::makestruct();
  var_0 maps\_anim::anim_reach_solo(level.merrick, "rescue_end");
  thread rescue_end_dialogue();
  var_0 maps\_anim::anim_single_solo(level.merrick, "rescue_end");
  common_scripts\utility::array_thread(level.heroes, maps\las_vegas_code::start_scripted_movement);
  level.merrick.dontavoidplayer = 0;
}

rescue_dialogue() {
  wait 15;
  level.merrick maps\_utility::smart_dialogue("vegas_mrk_heshnow");
  wait 5;
  level.merrick maps\_utility::smart_dialogue("vegas_mrk_igotchalogan");
}

rescue_end_dialogue() {
  wait 0.5;
  level.hesh maps\_utility::smart_dialogue("vegas_hsh_youokmerrick");
  level.merrick maps\_utility::smart_dialogue("vegas_mrk_ribsbrokenbuti");
  level.merrick maps\_utility::smart_dialogue("vegas_mrk_wegottagetgoing");
  wait 1;
  level.hesh maps\_utility::smart_dialogue("vegas_hsh_keeganigotem");
  maps\_utility::smart_radio_dialogue("vegas_kgn_checkimonmy");
  wait 1;
  level.merrick maps\_utility::smart_dialogue("vegas_mrk_weneedtomake");
}

rescue_player_init(var_0) {
  level.player takeallweapons();
  level.player allowstand(0);
  level.player allowprone(0);
  level.player allowcrouch(1);
  level.player allowsprint(0);
  level.player giveweapon("flash_grenade");
  level.player setweaponammostock("flash_grenade", 0);
  level.player giveweapon("fraggrenade");
  level.player setweaponammostock("fraggrenade", 0);
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  level.player.link = var_1;
  var_2 = (0, -175, 0);
  var_3 = var_1 localtoworldcoords(var_2);
  var_4 = vectortoangles(var_0.origin - var_3);
  var_1.origin = var_3;
  var_1.angles = var_4;
  level.player playerlinktodelta(var_1, "tag_origin", 1, 0, 0, 0, 0);
  level.player lerpviewangleclamp(2, 0, 0, 30, 30, 60, 20);
}

rescue_player_thread() {
  common_scripts\utility::flag_wait("rescue_sniper_start");
  var_0 = level.merrick.threatbias;
  level.merrick.threatbias = 0;
  level.merrick maps\_utility::delaythread(10, ::set_threatbias, var_0);
  level.player lerpviewangleclamp(5, 0, 0, 50, 50, 60, 40);
  thread player_threatbias_thread();
  common_scripts\utility::flag_wait("rescue_unlink_player");
  level.player setCanDamage(0);
  thread maps\_art::dof_disable_script(1);
  level.player unlink();
  level.player allowstand(1);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player allowjump(1);
  level.player allowsprint(1);
  maps\las_vegas_code::ui_show_stance(1);

  foreach(var_2 in level.heroes)
  var_2 maps\las_vegas_code::restore_name();

  wait 5;
  level.player setCanDamage(1);
}

set_threatbias(var_0) {
  self.threatbias = var_0;
}

player_threatbias_thread() {
  var_0 = level.player.threatbias;
  level.player.threatbias = 0;
  common_scripts\utility::flag_wait("rescue_unlink_player");
  var_1 = 10;

  if(maps\_utility::getdifficulty() == "hard")
    var_1 = 15;
  else if(maps\_utility::getdifficulty() == "fu")
    var_1 = 30;

  var_2 = var_1 * 20;
  var_3 = var_0 / var_2;
  var_4 = 0;

  for(var_5 = 0; var_5 < var_2; var_5++) {
    var_4 = var_4 + var_3;
    level.player.threatbias = int(var_4);
    wait 0.05;
  }

  level.player.threatbias = var_0;
}

player_flinch() {
  wait 11;
  var_0 = maps\_hud_util::get_overlay("white");
  var_1 = 0.1;
  var_0 fadeovertime(var_1);
  var_0.alpha = 1;
  maps\_utility::set_vision_set("lv_tunnel_overbloom", var_1 + 0.2);
  wait(var_1);
  wait 0.3;
  var_1 = 0.2;
  maps\_utility::set_vision_set("", var_1 - 0.1);
  var_0 fadeovertime(var_1);
  var_0.alpha = 0;
}

rescue_sniper() {
  var_0 = common_scripts\utility::getstruct("sniper_glint_struct", "targetname");
  var_1 = gettime();
  var_2 = var_1 + 11000;
  sniper_sort_targets();
  wait 8;
  var_3 = common_scripts\utility::getfx("sniper_glint_large");
  playFX(var_3, var_0.origin);
  wait 1;
  playFX(var_3, var_0.origin);
  wait 0.2;
  playFX(var_3, var_0.origin);
  wait 1;
  playFX(var_3, var_0.origin);
  var_4 = (var_2 - gettime()) * 0.001;
  var_4 = max(var_4, 0);
  wait(var_4);
  var_5 = spawn("script_model", var_0.origin);
  var_5 setModel("tag_flash");
  var_5.angles = vectortoangles(var_5.origin - level.player.origin);
  var_6 = maps\las_vegas_code::array_get_noteworthy(level.rescue_enemies, "gunner1");
  var_7 = spawn("script_origin", level.player.origin);
  var_5 thread rescue_sniper_track_target(var_7);
  var_5 thread rescue_kill_targets(var_1);
  var_5 rescue_snipe_gunner(var_6, var_7);
  var_8 = 600;
  var_9 = undefined;
  var_10 = gettime() + randomintrange(2000, 4000);

  while(!common_scripts\utility::flag("rescue_sniper_done")) {
    if(gettime() > var_10) {
      var_10 = gettime() + randomintrange(4000, 8000);
      playFX(var_3, var_0.origin);
    }

    var_9 = sniper_get_target();

    if(!isDefined(var_9)) {
      wait 0.1;
      continue;
    }

    var_11 = var_9 gettagorigin("J_SpineUpper");
    var_12 = distance(var_7.origin, var_11);
    var_4 = var_12 / var_8;
    var_7 moveto(var_11, var_4);
    var_4 = max(var_4, 0.06);
    wait(var_4 - 0.05);
  }
}

rescue_snipe_gunner(var_0, var_1) {
  var_1.origin = var_0 gettagorigin("J_SpineUpper");
  rescue_sniper_shot(var_0, "J_SpineUpper", 1);
  wait 3;
  self laserforceon();
  var_1 linkto(var_0, "j_head", (0, 0, 0), (0, 0, 0));
  wait 0.5;
  thread rescue_sniper_shot(var_0, "j_head", 1);
  var_1 unlink();
  common_scripts\utility::flag_set("rescue_sniper_start");
  thread turn_off_laser();
}

turn_off_laser() {
  common_scripts\utility::flag_wait("rescue_sniper_done");
  self laserforceoff();
}

rescue_sniper_track_target(var_0) {
  self endon("death");
  var_1 = 0.2;

  for(;;) {
    var_2 = vectortoangles(var_0.origin - self.origin);
    self rotateto(var_2, var_1);
    wait(var_1);
  }
}

rescue_kill_targets(var_0) {
  self endon("death");

  for(;;) {
    if(level.rescue_targets.size == 0) {
      break;
    }

    wait 0.05;

    foreach(var_4, var_2 in level.rescue_targets) {
      if(!isDefined(var_2) || !isalive(var_2)) {
        break;
      }

      var_3 = var_0 + var_2.kill_time * 1000;

      for(;;) {
        wait 0.05;

        if(gettime() >= var_3) {
          if(!isDefined(var_2) || !isalive(var_2)) {
            break;
          }

          rescue_sniper_shot(var_2, "J_SpineUpper");
          level.rescue_targets = common_scripts\utility::array_remove(level.rescue_targets, var_2);

          if(common_scripts\utility::cointoss()) {
            wait(randomfloatrange(0.3, 0.7));
            rescue_sniper_shot(var_2, "J_SpineUpper");
          }

          if(isDefined(var_2) && isalive(var_2)) {
            if(!isDefined(var_2.animname)) {
              var_2.deathfunction = maps\las_vegas_code::sniper_ragdoll_death;
              var_2 kill(self.origin);
            }
          }

          break;
        }
      }
    }
  }

  common_scripts\utility::flag_set("rescue_sniper_done");
}

rescue_sniper_shot(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isalive(var_0)) {
    return;
  }
  var_3 = var_0 gettagorigin(var_1);
  var_4 = self.origin + vectornormalize(var_3 - self.origin) * 10000;
  magicbullet("l115a3_nosound", self.origin, var_3);
  var_5 = bulletTrace(self.origin, var_3, 0);
  var_3 = var_0 gettagorigin(var_1);
  var_6 = vectornormalize(self.origin - var_3);
  var_7 = var_3 + var_6 * 100;
  magicbullet("l115a3_nosound", var_7, var_3);
  var_8 = bulletTrace(var_7, var_4, 0);
  var_6 = vectornormalize(var_4 - var_7);
  playFX(common_scripts\utility::getfx("big_blood_spurt"), var_3, var_6);
  var_9 = common_scripts\utility::spawn_tag_origin();
  var_9.origin = var_5["position"];
  playFXOnTag(common_scripts\utility::getfx("bullettrail"), var_9, "tag_origin");

  if(isDefined(var_2)) {
    var_10 = getent("gunner1_ai", "targetname");
    var_10 thread maps\_utility::play_sound_on_tag("sniper_bullet_large_flesh_npc", "j_SpineUpper");
  }

  var_9 moveto(var_8["position"], 0.2);
  var_9 common_scripts\utility::delaycall(2, ::delete);
  level thread common_scripts\utility::play_sound_in_space("weap_l115a3_fire_sniper", self.origin);
}

sniper_sort_targets() {
  var_0 = [];
  var_0[var_0.size] = maps\las_vegas_code::array_get_noteworthy(level.rescue_enemies, "enemy2");
  var_0[var_0.size] = maps\las_vegas_code::array_get_noteworthy(level.rescue_enemies, "enemy1");
  var_0 = common_scripts\utility::array_combine(var_0, level.rescue_standers);
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(isDefined(var_3.animname)) {
      if(var_3.animname == "enemy2") {
        var_3.kill_time = 20.5;
        var_3.targetname = "rescue_enemy2";
      } else if(var_3.animname == "enemy1") {
        var_3 thread shootable_by_player();
        var_3.kill_time = 32.4;
      }

      continue;
    }

    if(isDefined(var_3.script_delay))
      var_3.kill_time = var_3.script_delay;
  }

  for(var_5 = 0; var_5 < var_0.size - 1; var_5++) {
    for(var_6 = var_5 + 1; var_6 < var_0.size; var_6++) {
      if(var_0[var_6].kill_time < var_0[var_5].kill_time) {
        var_7 = var_0[var_6];
        var_0[var_6] = var_0[var_5];
        var_0[var_5] = var_7;
      }
    }
  }

  level.rescue_targets = var_0;
}

shootable_by_player() {
  self endon("death");
  common_scripts\utility::flag_wait("rescue_unlink_player");
  self.allowdeath = 1;
  self.deathfunction = maps\las_vegas_code::death_ragdoll;
}

sniper_get_target() {
  level.rescue_targets = common_scripts\utility::array_removeundefined(level.rescue_targets);
  level.rescue_targets = maps\_utility::array_removedead_or_dying(level.rescue_targets);

  if(level.rescue_targets.size == 0)
    return undefined;

  var_0 = level.rescue_targets[0];

  if(isDefined(var_0) && isalive(var_0))
    return var_0;

  return undefined;
}

postspawn_rescue_enemy() {
  if(!isDefined(level.rescue_enemies))
    level.rescue_enemies = [];

  level.rescue_enemies[level.rescue_enemies.size] = self;
  self.ignoreme = 1;

  if(isDefined(self.script_noteworthy)) {
    self.animname = self.script_noteworthy;

    switch (self.script_noteworthy) {
      case "gunner1":
        maps\_utility::gun_remove();
        maps\_utility::forceuseweapon(self.sidearm, "primary");
        self.targetname = "gunner1_ai";
        break;
      case "gunner2":
        maps\_utility::gun_remove();
        animscripts\shared::placeweaponon(self.sidearm, "none");
        self.targetname = "gunner2_ai";
        break;
    }
  }
}

postspawn_rescue_extra() {
  level.rescue_enemies[level.rescue_enemies.size] = self;
  level.rescue_targets[level.rescue_targets.size] = self;
  self.baseaccuracy = self.baseaccuracy * 0.5;
  var_0 = level.rescue_targets[level.rescue_targets.size - 1];

  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "extra")
    self.kill_time = 36;
  else
    self.kill_time = 34;
}

postspawn_rescue_stander() {
  if(!isDefined(level.rescue_standers))
    level.rescue_standers = [];

  level.rescue_standers[level.rescue_standers.size] = self;
  self.alertlevelint = 0;
  self.goalradius = 16;
  common_scripts\utility::flag_wait("rescue_sniper_start");
  self.alertlevelint = 1;
}

bar() {
  maps\las_vegas_code::enable_all_triggers();
  main_init();
  maps\las_vegas_code::set_player_speed("bar");
  maps\_utility::autosave_by_name("bar");
  common_scripts\utility::flag_set("rescue_sniper_done");
  thread bar_dialogue();
  level.hesh maps\_utility::set_archetype("creepwalk");
  level.hesh pushplayer(1);
  level.hesh.accuracy = 9999;
  level.hesh maps\_utility::pathrandompercent_zero();
  level.merrick.og_baseaccuracy = level.merrick.baseaccuracy;
  level.merrick.baseaccuracy = 0.1;
  common_scripts\utility::array_thread(level.heroes, maps\_utility::set_ignoreall, 1);
  common_scripts\utility::flag_wait("human_shield");
  level.merrick.ignoreall = 0;
  level.bar_enemies = [];
  var_0 = getent("casino_bar_idler", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai();
  level.bar_enemies[level.bar_enemies.size] = var_1;
  var_2 = getnode(var_0.script_linkto, "script_linkname");
  var_3 = getnode(var_0.target, "targetname");
  var_1 thread maps\las_vegas_code::idle_and_react(var_2, var_0.animation, "none", var_3);
  var_1 thread bar_humanshield_deaths();
  thread bar_radio_scene();
  var_4 = getEntArray("casino_bar_walkers", "targetname");
  common_scripts\utility::array_thread(var_4, maps\_utility::spawn_ai);
  var_5 = level.player getweaponslistall();

  if(level.player getcurrentweapon() == "none") {
    level.player disableweapons();
    level.player giveweapon("p226");
    level.player enableweapons();
    level.player switchtoweapon("p226");
  }

  common_scripts\utility::flag_wait("bar_enemies_dead");
  level.merrick.baseaccuracy = level.merrick.og_baseaccuracy;
  level.merrick.ignoreall = 1;
  level.player disableinvulnerability();
  common_scripts\utility::array_call(level.heroes, ::pushplayer, 1);
  level.hesh maps\_utility::disable_cqbwalk();
  level.hesh maps\_utility::set_archetype("creepwalk");
  common_scripts\utility::flag_wait("human_shield_done");
  level.bar_enemies = undefined;
}

bar_dialogue() {
  common_scripts\utility::flag_wait("at_bar");
  var_0 = ["vegas_fs5_shitmandidyou", "vegas_pmc3_nowhat", "vegas_fs5_hetookagarrote", "vegas_pmc3_holyshitthatsbrutalman", "vegas_fs5_yeahremindmenever", "vegas_saf2_youwanttoknow", "vegas_fs5_whatsthat", "vegas_saf2_ithinkoneof", "vegas_pmc3_whatthefuck", "vegas_saf2_yeahhekilledthe"];
  var_1 = common_scripts\utility::getStructArray("bar_sound_structs", "targetname");
  var_2 = [];

  foreach(var_4 in var_1)
  var_2[var_2.size] = spawn("script_origin", var_4.origin);

  var_6 = undefined;

  foreach(var_10, var_8 in var_0) {
    if(common_scripts\utility::flag("humanshield_start")) {
      var_6 stopsounds();
      break;
    }

    if(isDefined(var_6))
      var_6 waittill("walla_stop");

    if(common_scripts\utility::flag("humanshield_start")) {
      break;
    }

    var_9 = var_2[var_10 % 2];
    var_9 playSound(var_8, "walla_stop", 1);
    var_6 = var_9;
    wait 0.1;
  }

  common_scripts\utility::array_call(var_2, ::delete);
}

human_shield_hesh(var_0) {
  var_0 maps\_anim::anim_reach_solo(self, "humanshield_doorstack");
  var_0 maps\_anim::anim_single_solo(self, "humanshield_doorstack");
  var_1 = maps\las_vegas_code::makestruct();
  var_1 thread maps\_anim::anim_loop_solo(self, "humanshield_doorstack_idle");
  var_2 = ["vegas_hsh_loganoverherequick", "vegas_mrk_getoverherekid", "vegas_mrk_dammitgetyourass"];
  level.hesh thread maps\las_vegas_code::nag_thread(var_2, "humanshield_start");
  common_scripts\utility::flag_wait("merrick_human_shield_ready");
  common_scripts\utility::flag_wait("human_shield");
  level.breach_ai = [];
  maps\_utility::array_spawn_targetname("bar_talkers");
  var_3 = getent("bar_left_entry_door", "targetname");
  var_1 maps\las_vegas_code::struct_stopanimscripted();
  var_4 = common_scripts\utility::getstruct("human_shield_spot", "targetname");
  var_4 thread maps\_anim::anim_first_frame(level.breach_ai, "vegas_humanshield_breach");
  common_scripts\utility::flag_set("humanshield_start");
  level.breach_ai[level.breach_ai.size] = self;
  var_4 thread humanshield_breach_code(level.breach_ai);
  level thread humandshield_end_dialogue();
  maps\_utility::delaythread(3.1, ::bar_player_ads_breathin);
  var_5 = common_scripts\utility::getclosest(self.origin, getaiarray("axis"));
  var_5 maps\_utility::delaythread(2.8, maps\_utility::smart_dialogue, "vegas_pmc2_huh");
  level.hesh thread maps\_utility::smart_dialogue("vegas_hsh_letsmakethisquick");
  var_4 thread maps\_anim::anim_single(level.breach_ai, "vegas_humanshield_breach");
  var_6 = getanimlength(maps\_utility::getanim("vegas_humanshield_breach"));
  wait(var_6);
  level notify("stealth_event_notify");
  level endon("bar_enemies_dead");
  level.breach_ai = maps\_utility::remove_dead_from_array(level.breach_ai);
  level notify("keegan_humanshield_shooting_start");
  maps\_utility::delaythread(0.1, common_scripts\utility::flag_set, "human_shield_ready_for_end");
  var_4 maps\_anim::anim_single(level.breach_ai, "vegas_humanshield_breach_loop");

  if(!common_scripts\utility::flag("bar_enemies_dead")) {
    level.hostage setCanDamage(1);
    var_4 maps\_anim::anim_single(level.breach_ai, "vegas_humanshield_breach_ending");
    common_scripts\utility::flag_set("human_shield_done");
  }
}

humandshield_end_dialogue() {
  common_scripts\utility::flag_wait("human_shield_done");
  var_0 = ["vegas_death_turnthetvdown", 1, "vegas_sp2_butthegameson", 0.5, "vegas_death_whatifthecaptain", 0.5, "vegas_sp2_yknowimgettingreally", 0.5, "vegas_death_ifyouwerentsuch", 0.5, "vegas_sp2_whatthehelldid", 0.5, "vegas_spl_whatthefuckare"];
  maps\_utility::delaythread(1, maps\las_vegas_code::array_play_enemy_radio, var_0);
  level.merrick thread maps\_utility::smart_dialogue("vegas_mrk_wereclear");
  wait 4;
  level.merrick maps\_utility::smart_dialogue("vegas_mrk_whereskeegan");
  level.hesh maps\_utility::smart_dialogue("vegas_hsh_hesonhisway");
}

postspawn_bar_talker() {
  if(isDefined(self.script_noteworthy)) {
    self.animname = "hostage";
    self setCanDamage(0);
    level.hostage = self;
  } else {
    self.animname = "sacrifice";
    self.headshotfx = 1;
    maps\_utility::gun_remove();
  }

  level.breach_ai[level.breach_ai.size] = self;
}

humanshield_breach_code(var_0) {
  self endon("vegas_humanshield_breach_loop");
  wait 2;
  var_1 = getent("bar_left_entry_door", "targetname");
  var_2 = getent("bar_right_entry_door", "targetname");
  var_1 thread maps\las_vegas_code::door_open(0.8, "double_door_wood_creeky", 96, undefined, 0.4);
  var_2 thread maps\las_vegas_code::door_open(1, undefined, 100, undefined, 0.4);
  wait 0.5;
  level notify("give_player_weapons");
  common_scripts\utility::flag_wait("bar_enemies_dead");
  common_scripts\utility::flag_wait("human_shield_ready_for_end");
  level.breach_ai = maps\_utility::remove_dead_from_array(level.breach_ai);
  var_3 = [];

  foreach(var_5 in level.breach_ai) {
    if(var_5.animname == "sacrifice") {
      continue;
    }
    var_3[var_3.size] = var_5;
  }

  level.breach_ai = var_3;
  common_scripts\utility::array_call(level.breach_ai, ::stopanimscripted);
  maps\_anim::anim_single(level.breach_ai, "vegas_humanshield_breach_ending");
  common_scripts\utility::flag_set("human_shield_done");
}

bar_player_ads_breathin() {
  level endon("bar_enemies_dead");
  var_0 = "weap_sniper_breathin";

  for(;;) {
    if(level.player maps\_utility::isads() || level.player adsButtonPressed()) {
      level.player thread maps\_utility::play_sound_on_entity(var_0);
      level.player notify("stop_fake_shellshock");
      break;
    }

    wait 0.05;
  }
}

bar_radio_scene() {
  var_0 = getent("casino_bar_radio_guy", "targetname");
  var_1 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_2 = maps\_utility::dronespawn_bodyonly(var_0);
  level.enemy_radio_guy = var_2;
  var_2.animname = "radio_guy";
  var_2 maps\_utility::gun_remove();
  var_2 notsolid();
  var_3 = "bar_radioguy_idle";
  var_4 = "bar_radioguy_react";
  var_5 = "bar_radioguy_death";
  var_2 thread maps\_anim::anim_loop_solo(var_2, var_3, "stop_anim");
  level waittill("stealth_event_notify");
  var_2 notify("stop_anim");
  var_2 maps\_anim::anim_single_solo(var_2, var_4);
  var_1 maps\_anim::anim_single_solo(var_2, var_5);
  maps\las_vegas_code::init_enemy_radio();
  level.enemy_radio linkto(var_2, "tag_weapon_chest", (0, 0, 0), (0, 0, 0));
  common_scripts\utility::flag_wait("bar_enemies_dead");
}

hesh_pickup_radio(var_0) {
  var_1 = common_scripts\utility::getstruct("casino_bar_radio_spot", "targetname");
  var_1 maps\_anim::anim_reach_solo(self, "bar_radio_pickup");
  level.merrick thread maps\_utility::smart_dialogue("vegas_mrk_grabhisradiowe");
  maps\_utility::delaythread(2, maps\las_vegas_code::radio_volume, 1, 4);
  var_2 = [level.enemy_radio_guy, self];
  maps\_utility::delaythread(4, maps\_utility::smart_dialogue, "vegas_hsh_soundsliketheyheard");
  thread post_bar_talk();
  var_1 maps\_anim::anim_single(var_2, "bar_radio_pickup");
}

post_bar_talk() {
  wait 6;
  maps\_utility::smart_radio_dialogue("vegas_kgn_heshwhatsyourlocation");
  wait 0.5;
  level.hesh maps\_utility::smart_dialogue("vegas_mrk_sohowarewe");
  maps\_utility::smart_radio_dialogue("vegas_hsh_thewestwingbut");
  level.hesh maps\_utility::smart_dialogue("vegas_mrk_wellhavetogo");
  wait 0.5;
  maps\_utility::smart_radio_dialogue("vegas_kgn_toomany");
}

postspawn_bar_enemy() {
  level.bar_enemies[level.bar_enemies.size] = self;
  var_0 = self.spawner;
  self endon("death");
  level endon("stealth_event_notify");
  self.ignoreall = 1;
  self.ignoreme = 1;
  maps\_utility::disable_arrivals();
  maps\_utility::disable_exits();
  maps\_utility::disable_surprise();
  maps\_utility::disable_pain();
  maps\_utility::pathrandompercent_zero();
  self.animname = "box_guy";
  maps\_utility::set_run_anim(self.animation);
  var_1 = strtok(self.animation, "_");
  self.num = var_1[2];
  self.deathanim = maps\_utility::getanim("vegas_guy_" + self.num + "_box_carry_dead");
  self.reactanim = "vegas_guy_" + self.num + "_box_carry_turn_shoot";
  var_2 = "com_cardboardbox_dusty_01";
  self.box = spawn("script_model", self.origin);
  self.box setModel(var_2);
  self.box linkto(self, "tag_inhand", (0, 0, 0), (0, 90, 0));
  self.stealth_radius_multiplier = 0;
  thread maps\las_vegas_code::waittill_stealth_notify();
  thread bar_walkers_reset();
  thread bar_humanshield_deaths();
  self.goalradius = 5;
  self setgoalpos(self.origin);
  wait 4;
  var_3 = common_scripts\utility::getstruct(var_0.script_linkto, "script_linkname");
  var_4 = maps\las_vegas_code::get_target_chain_array(var_3);

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_3 = var_4[var_5];
    self.goalradius = var_3.radius;
    self setgoalpos(var_3.origin);
    self waittill("goal");

    if(!common_scripts\utility::flag("humanshield_start")) {
      thread maps\_anim::anim_first_frame_solo(self, self.animation);
      common_scripts\utility::flag_wait("humanshield_start");
      self stopanimscripted();
    }
  }
}

bar_walkers_reset() {
  self endon("death");
  level waittill("stealth_event_notify");
  wait(randomfloatrange(0.2, 0.5));
  self.ignoreall = 0;
  maps\_utility::clear_run_anim();
  maps\_utility::clear_deathanim();
  maps\_utility::delaythread(0.5, maps\_utility::clear_deathanim);
  thread maps\las_vegas_code::waittill_dead_and_stop_anim(self, self.reactanim);
  thread bar_walkers_boxes();
  thread maps\_anim::anim_single_solo(self, self.reactanim);
  common_scripts\utility::waitframe();
  maps\_anim::anim_set_rate_single(self, self.reactanim, 2);
  wait(getanimlength(maps\_utility::getanim(self.reactanim)) / 2);
  self.box unlink();
  self.box physicslaunchclient(self.origin + (0, 0, 2), (0, 0, -10));
  self.box notify("phy_launched");
  self setgoalpos(self.origin);
  self.favoriteenemy = level.hesh;
}

bar_walkers_boxes() {
  self endon(self.reactanim);
  var_0 = self.box;
  var_0 endon("phy_launched");
  self waittill("death");
  playFX(level._effect["bar_box_exp"], var_0.origin);
  var_0 unlink();
  var_0 physicslaunchclient(self.origin + (0, 0, 2), (0, 0, -10));
}

bar_humanshield_deaths() {
  self endon("death");
  level waittill("keegan_humanshield_shooting_start");

  if(isDefined(self.script_death)) {
    wait(self.script_death);
    playFXOnTag(level._effect["headshot_blood"], self, "j_head");
    maps\_utility::die();
  }
}

kitchen() {
  main_init();
  init_kitchen_carts();
  thread kitchen_spawn_keegan();
  maps\las_vegas_code::set_player_speed("kitchen");
  maps\_utility::autosave_by_name("kitchen");
  common_scripts\utility::flag_wait("kitchen_hide_done");
}

init_kitchen_carts() {
  var_0 = init_kitchen_cart("kitchen_cart1");
  var_1 = common_scripts\utility::getstruct("kitchen_enter", "script_noteworthy");
  var_1 maps\_anim::anim_first_frame_solo(var_0, "kitchen_stumble");
  var_0 = init_kitchen_cart("kitchen_cart2");
  var_0 init_kitchen_cart_plates();
  var_1 = common_scripts\utility::getstruct("casino_kitchen_flashlight_scene", "targetname");
  var_1 maps\_anim::anim_first_frame_solo(var_0, "kitchen_hide_enter");
}

init_kitchen_cart(var_0) {
  var_1 = getEntArray(var_0, "script_noteworthy");
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_1) {
    if(var_5.classname == "script_model") {
      var_2 = var_5;
      continue;
    }

    var_3 = var_5;
  }

  var_2.animname = "cart";
  var_2 maps\_utility::assign_animtree();
  var_2.clip = var_3;
  var_3 linkto(var_2);
  var_2.targetname = var_0;
  return var_2;
}

init_kitchen_cart_plates() {
  var_0 = getEntArray("kitchen_cart2_plates", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 delete();

  var_4 = [["a", "b", "c", "d"], ["d", "e"]];
  var_4 = [["tag_plates_level2_1", "small", -1], ["tag_plates_level2_3", "large", 1.0], ["tag_plates_level3_1", "small", -1], ["tag_plates_level4_2", "small", -1], ["tag_plates_level4_3", "large", 1.1], ["tag_plates_level5_2", "small", -1], ["tag_plates_level5_3", "large", -1], ["tag_plates_level6_2", "small", -1], ["tag_plates_level7_1", "large", -1], ["tag_plates_level7_2", "large", 2.75]];
  var_0 = [];

  foreach(var_6 in var_4) {
    var_2 = spawn("script_model", self gettagorigin(var_6[0]));

    if(var_6[1] == "large")
      var_2 setModel("com_breakable_platestack_large");
    else
      var_2 setModel("com_breakable_platestack_large");

    var_2 linkto(self, var_6[0]);
    var_2.tagname = var_6[0];
    var_2.falltime = var_6[2];
    var_0[var_0.size] = var_2;
  }

  self.plates = var_0;
}

kitchen_enter_merrick(var_0) {
  common_scripts\utility::flag_wait("kitchen_doors_open");
  var_1 = common_scripts\utility::getstruct("kitchen_enter", "script_noteworthy");
  var_1 maps\_anim::anim_reach_solo(self, "kitchen_stumble");
  var_2 = getent("kitchen_cart1", "targetname");
  var_2.animname = "cart";
  var_2 maps\_utility::assign_animtree();
  level.merrick maps\_utility::delaythread(1, maps\_utility::smart_dialogue, "vegas_mrk_aghdammitgrunt");
  level.merrick maps\_utility::delaythread(4, maps\_utility::smart_dialogue, "vegas_mrk_sonofaaghcmonmerrick");
  var_3 = [var_2, self];
  var_1 thread maps\_anim::anim_single(var_3, "kitchen_stumble");
  var_4 = getanimlength(maps\_utility::getanim("kitchen_stumble"));
  var_5 = 6.6;
  wait(var_5);

  if(!common_scripts\utility::flag("player_in_kitchen")) {
    var_1 waittill("kitchen_stumble");
    var_1 thread maps\_anim::anim_loop_solo(self, "kitchen_stumble_idle");
    common_scripts\utility::flag_wait("player_in_kitchen");
    var_1 maps\las_vegas_code::struct_stopanimscripted();
    var_1 maps\_anim::anim_single_solo(self, "kitchen_stumble_idle_exit");
  } else {
    var_1 maps\las_vegas_code::struct_stopanimscripted();
    maps\_utility::anim_stopanimscripted();
  }

  common_scripts\utility::flag_set("kitchen_spawn_keegan");
}

kitchen_hide_merrick(var_0) {
  var_0 maps\_anim::anim_reach_solo(self, "kitchen_hide_enter");
  var_1 = getent("kitchen_cart2", "targetname");
  var_0 maps\_anim::anim_first_frame_solo(var_1, "kitchen_hide_enter");

  foreach(var_3 in var_1.plates)
  var_3 thread kitchen_cart_plate_fall(var_1);

  common_scripts\utility::flag_set("kitchen_hide_start");
  thread kitchen_hide_dialogue();
  var_5 = [level.merrick, level.hesh, var_1];
  var_1.animating = 1;
  var_1 thread player_in_cart_thread();
  var_0 maps\_anim::anim_single(var_5, "kitchen_hide_enter");
  var_1.animating = 0;
  var_5 = common_scripts\utility::array_remove(var_5, var_1);
  common_scripts\utility::array_thread(var_5, ::kitchen_spotted, var_0);

  if(!common_scripts\utility::flag("kitchen_stealth_alert"))
    var_0 thread maps\_anim::anim_loop(var_5, "kitchen_hide_loop");

  common_scripts\utility::flag_wait("kitchen_hide_everyone_up");

  if(!common_scripts\utility::flag("kitchen_stealth_alert")) {
    var_0 maps\las_vegas_code::struct_stopanimscripted();
    var_0 maps\_anim::anim_single(var_5, "kitchen_hide_exit");
  }

  level.hesh maps\_utility::disable_cqbwalk();
  level.hesh maps\_utility::set_archetype("creepwalk");
}

player_in_cart_thread() {
  var_0 = 0;
  var_1 = (7, -7, 0);

  while(self.animating || var_0) {
    wait 0.05;

    if(level.player istouching(self.clip)) {
      var_0 = 1;
      self.clip notsolid();
      level.player pushplayervector(var_1);
      continue;
    }

    var_0 = 0;
    self.clip solid();
    level.player pushplayervector((0, 0, 0));
  }

  level.player pushplayervector((0, 0, 0));
}

kitchen_spotted(var_0) {
  level endon("kitchen_enemies_gone");
  common_scripts\utility::flag_wait("kitchen_stealth_alert");
  common_scripts\utility::flag_wait("kitchen_enemy_doors_open");
  var_0 maps\las_vegas_code::struct_stopanimscripted();
  maps\_utility::anim_stopanimscripted();
  var_0 maps\_anim::anim_single_solo(self, "kitchen_alert_exit");
  self.goalradius = 200;
  self.ignoreme = 0;
  self.ignoreall = 0;
  self.ignoresuppression = 0;
  var_0 = getnode("kitchen_" + self.script_noteworthy + "_node", "targetname");
  self setgoalnode(var_0);
}

kitchen_cart_plate_fall(var_0) {
  if(self.falltime == -1) {
    return;
  }
  self endon("death");
  wait(self.falltime);
  thread maps\_utility::play_sound_on_entity("scn_vegas_kitchen_dish_break");
  playFXOnTag(level._effect["com_platestack_large_tip1"], var_0, self.tagname);
  self delete();
}

kitchen_hide_dialogue() {
  level.merrick thread maps\_utility::smart_dialogue("vegas_mrk_ahshit");
  level.merrick maps\_utility::delaythread(1.5, maps\_utility::smart_dialogue, "vegas_mrk_heavywoundedbreathing");
  level.hesh maps\_utility::delaythread(3.5, maps\_utility::smart_dialogue, "vegas_hsh_keegan_3");
  level.hesh maps\_utility::delaythread(5, maps\_utility::smart_dialogue, "vegas_hsh_wegottahidenow");
  level.keegan maps\_utility::delaythread(6, maps\_utility::smart_dialogue, "vegas_kgn_shitgethimup");
  level.keegan maps\_utility::delaythread(7, maps\_utility::smart_dialogue, "vegas_kgn_hideinherequick");
  wait 11;

  if(!common_scripts\utility::flag("kitchen_hide_started")) {
    level.hesh thread maps\_utility::smart_dialogue("vegas_hsh_logangetinhere");
    var_0 = ["vegas_hsh_loganoverherequick", "vegas_hsh_logangetinhere", "vegas_hsh_inhere"];
    level.hesh maps\_utility::delaythread(4, maps\las_vegas_code::nag_thread, var_0, ["kitchen_player_hidden", "kitchen_stealth_alert", "kitchen_hide_started"], 5, 7);
  }

  common_scripts\utility::flag_wait("kitchen_hide_everyone_up");
  level.hesh maps\_utility::smart_dialogue("vegas_hsh_weregoodletsgo");
}

kitchen_spawn_keegan() {
  common_scripts\utility::flag_wait("kitchen_spawn_keegan");
  var_0 = common_scripts\utility::getstruct("keegan_kitchen_spot", "targetname");
  maps\las_vegas_code::spawn_hero("keegan", var_0);
  level.keegan.dontavoidplayer = 1;
  level.keegan pushplayer(1);
  level.keegan kitchen_hide_keegan();
  var_1 = getnode("keegan_hallway_node", "targetname");
  level.keegan thread maps\las_vegas_code::scripted_movement(var_1, 1);
}

kitchen_hide_keegan() {
  common_scripts\utility::flag_wait("player_in_kitchen");
  var_0 = common_scripts\utility::getstruct("kitchen_hide", "script_noteworthy");
  var_1 = var_0 maps\las_vegas_code::makestruct();
  var_1 maps\_anim::anim_reach_and_approach_node_solo(self, "kitchen_hide_enter", undefined, "Exposed", "stand");
  common_scripts\utility::flag_wait("kitchen_hide_start");
  level thread kitchen_hide_radio_loop();
  thread kitchen_hide_keegan_anim(var_1);
  wait 11;
  common_scripts\utility::flag_wait("kitchen_player_hidden");
  common_scripts\utility::flag_set("kitchen_hide_started");
  level notify("stop_keegan_hide_enter");
  var_1 maps\las_vegas_code::struct_stopanimscripted();
  maps\_utility::anim_stopanimscripted();
  maps\_utility::delaythread(2, ::kitchen_spawn_enemies);
  level thread kitchen_hide_enemy_dialogue();
  level thread kitchen_hide_loop_dialogue();
  var_1 maps\_anim::anim_single_solo(self, "kitchen_hide_wave_exit");
  maps\_utility::music_play("mus_vegas_kitchen_suspense");
  var_1 thread maps\_anim::anim_loop_solo(self, "kitchen_hide_loop");
  self setgoalpos((-31244, -27300, 2120));
  kitchen_ambush_keegan(var_1);
}

kitchen_hide_keegan_anim(var_0) {
  level endon("stop_keegan_hide_enter");
  var_0 maps\_anim::anim_single_solo(self, "kitchen_hide_enter");
  var_0 thread maps\_anim::anim_loop_solo(self, "kitchen_hide_wave_loop");
}

kitchen_ambush_keegan(var_0) {
  if(!isDefined(level.kitchen_flashlight_enemy))
    level waittill("kitchen_flashlight_enemy");

  thread kitchen_ambush_keegan_handler(var_0);
  var_1 = undefined;
  var_2 = [self];

  if(isDefined(level.kitchen_flashlight_enemy)) {
    var_1 = level.kitchen_flashlight_enemy;
    var_1.animname = "flashlight_guy";
    var_1 maps\_utility::gun_remove();
    var_2 = [var_1, self];
    maps\_utility::delaythread(10.75, common_scripts\utility::play_sound_in_space, "scn_vegas_stealthkill_flashlight", (-31286, -27272, 2115));
    var_0 maps\_anim::anim_reach_solo(var_1, "kitchen_ambush_start");
  }

  if(!common_scripts\utility::flag("kitchen_stealth_alert")) {
    var_1 thread maps\_utility::notify_delay("stop_stealth_notify", 7.7);
    var_0 maps\las_vegas_code::struct_stopanimscripted();
    var_0 = var_0 maps\las_vegas_code::makestruct();
    maps\_utility::anim_stopanimscripted();
    var_1 maps\_utility::anim_stopanimscripted();
    var_1.stealth_radius_multiplier = 0.5;
    level notify("flashlight_start_wait");
    var_2 = [var_1, self];
    self.kitchen_ambush_time = gettime();
    maps\_utility::friendlyfire_warnings_off();
    maps\_utility::delaythread(7.7, ::flag_set_flagcheck, "doing_kitchen_ambush", "kitchen_stealth_alert");
    var_1 thread kitchen_flashlight_alert_radius();
    level thread keegan_ambush_sounds(var_1);
    level.keegan.detach_gun_angles = (1.91891, 220.76, -83.3337);
    level.keegan.detach_gun_origin = (-31228.4, -27310.3, 2112.88);
    var_0 maps\_anim::anim_single(var_2, "kitchen_ambush_start");
    maps\_utility::friendlyfire_warnings_on();

    if(maps\_utility::ent_flag("doing_kitchen_ambush"))
      var_0 thread maps\_anim::anim_loop(var_2, "kitchen_ambush_loop");
  }

  common_scripts\utility::flag_wait_any("kitchen_enemies_gone", "kitchen_stealth_alert");

  if(maps\_utility::ent_flag("doing_kitchen_ambush")) {
    var_0 maps\las_vegas_code::struct_stopanimscripted();
    var_1.allowdeath = 1;
    var_1.deathfunction = maps\las_vegas_code::death_wait;
    var_1.dontavoidplayer = 1;
    var_1 common_scripts\utility::delaycall(1, ::kill);

    if(common_scripts\utility::flag("kitchen_stealth_alert"))
      thread keegan_ambush_end_early(var_0);

    var_0 maps\_anim::anim_single(var_2, "kitchen_ambush_end");
    level thread keegan_knife_off();

    if(common_scripts\utility::flag("kitchen_stealth_alert")) {
      common_scripts\utility::flag_wait("kitchen_enemies_gone");
      common_scripts\utility::flag_set("kitchen_hide_everyone_up");
    }
  }

  common_scripts\utility::flag_wait("kitchen_enemies_gone");
  common_scripts\utility::flag_set("kitchen_hide_done");
  level.merrick.a.pose = "stand";
  level.hesh.a.pose = "stand";
  level.keegan.a.pose = "stand";
  level.keegan maps\_utility::set_archetype("creepwalk");
}

keegan_knife_off() {
  wait 0.5;
  level.keegan detach("weapon_commando_knife_bloody", "tag_inhand");
  level.keegan.has_knife = undefined;
}

flag_set_flagcheck(var_0, var_1) {
  if(!common_scripts\utility::flag(var_1))
    maps\_utility::ent_flag_set("doing_kitchen_ambush");
}

keegan_ambush_sounds(var_0) {
  wait 8.4;

  if(common_scripts\utility::flag("kitchen_stealth_alert")) {
    return;
  }
  if(!isDefined(var_0) || !isalive(var_0)) {
    return;
  }
  var_0 thread maps\_utility::play_sound_on_tag("vegas_fs1_kitchen_stealthkill", "j_head");
}

keegan_ambush_end_early(var_0) {
  wait 4.5;
  set_pose("crouch");
  var_0 maps\las_vegas_code::struct_stopanimscripted();
  maps\_utility::anim_stopanimscripted();
  kitchen_keegan_cleanup();
}

kitchen_keegan_cleanup() {
  if(isDefined(level.keegan.has_knife))
    level.keegan detach("weapon_commando_knife_bloody", "tag_inhand");

  if(isDefined(level.keegan.dropped_gun))
    maps\las_vegas_anim::attach_gun_custom(level.keegan);
}

kitchen_flashlight_alert_radius() {
  self endon("death");
  wait 5;
  self.stealth_radius_multiplier = 0.6;
}

kitchen_hide_loop_dialogue() {
  level endon("kitchen_stealth_alert");

  if(common_scripts\utility::flag("kitchen_stealth_alert")) {
    return;
  }
  level.keegan maps\_utility::smart_dialogue("vegas_kgn_downgetdown");
  wait 1;
  level.merrick thread maps\_utility::smart_dialogue("vegas_mrk_turntheradiodown");
  maps\_utility::delaythread(1.5, maps\las_vegas_code::radio_volume, 0, 2);
  wait 2;
  level.keegan maps\_utility::smart_dialogue("vegas_kgn_shhhh");
}

kitchen_hide_radio_loop() {
  wait 4;
  var_0 = ["vegas_fs5_teamfivegiveme", "vegas_saf2_almosttoteamtwos", "vegas_fs5_thecaptainwantsto", "vegas_saf2_wereonourway", "vegas_fs5_okwellifhe", "vegas_saf2_haveyoutriedteam", "vegas_fs5_donttellmehow", "vegas_saf2_sorryoneoneyourebreaking", "vegas_fs5_whenyougetback"];
  maps\las_vegas_code::array_play_enemy_radio(var_0);
}

kitchen_hide_enemy_dialogue() {
  common_scripts\utility::flag_wait("kitchen_enemy_doors_open");
  var_0 = ["vegas_saf2_ihearditthe", "vegas_pmc3_checkyourcornersdont", "vegas_saf2_rodrigocheckinthere", "vegas_saf1_imonit"];

  foreach(var_5, var_2 in var_0) {
    if(common_scripts\utility::flag("kitchen_stealth_alert")) {
      break;
    }

    var_3 = [];

    if(isDefined(level.kitchen_flashlight_enemy))
      var_3[var_3.size] = level.kitchen_flashlight_enemy;

    var_4 = maps\_utility::get_closest_ai_exclude(level.player.origin, "axis", var_3);

    if(isDefined(var_4))
      var_4 maps\_utility::smart_dialogue_generic(var_2);
  }
}

kitchen_ambush_keegan_handler(var_0) {
  common_scripts\utility::flag_wait("kitchen_stealth_alert");
  var_1 = -1;

  if(isDefined(self.kitchen_ambush_time))
    var_1 = (gettime() - self.kitchen_ambush_time) * 0.001;

  if(var_1 < 7.1) {
    set_pose("crouch");
    common_scripts\utility::flag_wait("kitchen_enemy_doors_open");
    wait 1;
    var_0 maps\las_vegas_code::struct_stopanimscripted();
    maps\_utility::anim_stopanimscripted();
    kitchen_keegan_cleanup();
    wait 0.2;
    self.suppressionwait = 5;
    self orientmode("face point", level.merrick.origin);
    var_2 = getnode("kitchen_" + self.script_noteworthy + "_node", "targetname");
    self setgoalnode(var_2);
    self.og_suppressionthreshold = self.suppressionthreshold;
    self.suppressionthreshold = 0.1;
    self.ignoresuppression = 0;
    self.goalradius = 200;
    self.ignoreall = 0;
    self.ignoreme = 0;
    self.dontmelee = 1;

    if(isDefined(level.kitchen_flashlight_enemy) && isalive(level.kitchen_flashlight_enemy))
      level.kitchen_enemies[level.kitchen_enemies.size] = level.kitchen_flashlight_enemy;
  } else if(var_1 < 7.7) {
    maps\_utility::anim_stopanimscripted();
    kitchen_keegan_cleanup();
  } else {
    maps\_utility::ent_flag_set("doing_kitchen_ambush");
    return;
  }

  if(isDefined(level.kitchen_flashlight_enemy) && isalive(level.kitchen_flashlight_enemy)) {
    level.kitchen_enemies[level.kitchen_enemies.size] = level.kitchen_flashlight_enemy;
    level.kitchen_flashlight_enemy maps\_utility::anim_stopanimscripted();
    level.kitchen_flashlight_enemy kitchen_attack_player();
  }

  common_scripts\utility::flag_wait("kitchen_enemies_gone");
  thread maps\_utility::battlechatter_off("allies");
  thread maps\_utility::battlechatter_off("axis");

  foreach(var_4 in level.heroes) {
    var_4.ignoreme = 1;
    var_4.ignoreall = 1;
    var_4 allowedstances("stand", "crouch", "prone");
    var_4.forcesuppression = undefined;

    if(isDefined(var_4.og_suppressionthreshold))
      var_4.suppressionthreshold = var_4.og_suppressionthreshold;

    var_4.dontmelee = undefined;
    var_4.dontavoidplayer = 0;
    var_4 pushplayer(0);
  }

  self.kitchen_ambush_time = undefined;
  common_scripts\utility::flag_set("kitchen_hide_everyone_up");
}

set_pose(var_0) {
  animscripts\notetracks::setpose(var_0);
}

kitchen_spawn_enemies() {
  maps\_utility::spawn_script_noteworthy("kitchen_flashlight_enemy", 1);
  maps\_utility::array_spawn_targetname("kitchen_enemy_spawners");
  thread kitchen_nade_door();
  thread kitchen_spawn_reinforcements();
  var_0 = gettime();
  common_scripts\utility::flag_wait_or_timeout("kitchen_stealth_alert", 14);

  if(common_scripts\utility::flag("kitchen_stealth_alert")) {
    maps\_utility::battlechatter_on("axis");
    maps\_utility::battlechatter_on("allies");
    maps\_utility::wait_for_buffer_time_to_pass(var_0, 7);
  }

  maps\_utility::array_spawn_targetname("kitchen_enemy_spawners");
  maps\_utility::delaythread(0.1, ::kitchen_enemy_pass_count);
}

kitchen_spawn_reinforcements() {
  level endon("kitchen_enemies_gone");
  common_scripts\utility::flag_wait("kitchen_stealth_alert");
  common_scripts\utility::flag_wait("kitchen_enemy_doors_open");

  foreach(var_1 in level.kitchen_enemies)
  var_1 kitchen_attack_player();

  level.hesh maps\_utility::smart_dialogue("vegas_hsh_loganno");
}

postspawn_kitchen_enemy() {
  if(!isDefined(level.kitchen_enemies))
    level.kitchen_enemies = [];

  level.kitchen_enemies[level.kitchen_enemies.size] = self;

  if(common_scripts\utility::flag("kitchen_stealth_alert")) {
    kitchen_attack_player();
    return;
  }

  self.disabledoorbehavior = 1;
  self.doorflashchance = 1;
  self.ignoreall = 1;
  self.ignoreme = 1;
  thread kitchen_hold_position();
  thread kitchen_sight_check();
  thread maps\las_vegas_code::waittill_stealth_notify("kitchen_stealth_alert");
  maps\_utility::enable_cqbwalk();
  self.movement_funcs["remove_from_array"] = ::kitchen_remove_check;
  self.movement_funcs["delete_me"] = ::delete_self;
  thread maps\las_vegas_code::scripted_movement(self);
  self waittill("stealth_event_notify");
  self notify("stop_scripted_movement");
}

kitchen_remove_check(var_0) {
  self.removed = 1;

  if(!common_scripts\utility::flag("kitchen_stealth_alert"))
    thread kitchen_remove_thread();
}

kitchen_remove_thread() {
  self endon("death");
  common_scripts\utility::flag_wait("kitchen_enemies_gone");

  if(common_scripts\utility::flag("kitchen_stealth_alert")) {
    return;
  }
  self notify("stop_sight_stealth_notify");
  self notify("stop_stealth_notify");
  maps\_utility::disable_cqbwalk();
  maps\_utility::enable_sprint();
  self.disablebulletwhizbyreaction = 1;
  self setCanDamage(0);
  self.ignoreall = 1;
}

kitchen_sight_check() {
  self endon("death");
  common_scripts\utility::flag_wait("kitchen_enemy_doors_open");

  if(!common_scripts\utility::flag("kitchen_stealth_alert"))
    thread maps\las_vegas_code::sight_stealth_notify("kitchen_stealth_alert", "kitchen_player_hidden");
}

kitchen_hold_position() {
  level endon("kitchen_enemy_doors_open");
  self endon("death");
  common_scripts\utility::flag_wait("kitchen_stealth_alert");

  if(!common_scripts\utility::flag("kitchen_enemy_doors_open")) {
    self notify("stop_going_to_node");
    self notify("stop_scripted_movement");
    var_0 = common_scripts\utility::getstruct("kitchen_hold_struct", "targetname");
    self.goalradius = 100;
    self setgoalpos(var_0.origin);
    common_scripts\utility::flag_wait("kitchen_enemy_doors_open");
  }

  kitchen_attack_player();
}

kitchen_attack_player() {
  self notify("stop_scripted_movement");
  self notify("stop_going_to_node");
  self.goalradius = 500;
  self setgoalpos(self.origin);
  self setgoalentity(level.player);
  self.ignoresuppression = 1;
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.doorflashchance = 1;
  self.disabledoorbehavior = undefined;
}

kitchen_nade_door() {
  level endon("kitchen_enemies_gone");
  var_0 = common_scripts\utility::getstruct("kitchen_nade_struct", "targetname");
  var_1 = common_scripts\utility::getstruct(var_0.target, "targetname");
  common_scripts\utility::flag_wait("kitchen_stealth_alert");
  var_2 = vectornormalize(var_1.origin - var_0.origin);
  wait 4;

  if(common_scripts\utility::flag("kitchen_enemy_doors_open")) {
    return;
  }
  var_3 = gettime();
  var_4 = [];

  for(var_5 = 0; var_5 < 3; var_5++) {
    if(var_5 == 0)
      var_6 = 1000;
    else
      var_6 = randomfloatrange(800, 900);

    var_4[var_4.size] = magicgrenademanual("fraggrenade", var_0.origin, var_2 * var_6);
    wait(randomfloatrange(0.5, 1));
  }

  var_7 = (gettime() - var_3) * 0.001;
  maps\_utility::delaythread(4 - var_7, common_scripts\utility::flag_set, "kitchen_enemy_doors_open");
  var_8 = getEntArray("casino_kitchen_doors02", "targetname");
  var_4[0] waittill("death");
  maps\las_vegas_code::doors_open(var_8, 0.25, undefined, undefined, 0, 0.25);
}

kitchen_enemy_remove(var_0) {
  level.kitchen_enemies = common_scripts\utility::array_remove(level.kitchen_enemies, self);
}

delete_self(var_0) {
  kitchen_enemy_remove();
  self delete();
}

postspawn_kitchen_flashlight() {
  level.kitchen_flashlight_enemy = self;
  level notify("kitchen_flashlight_enemy", self);
  maps\_utility::set_generic_run_anim("active_patrolwalk_v1");
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.stealth_radius_multiplier = 0.5;
  thread kitchen_hold_position();
  thread maps\las_vegas_code::waittill_stealth_notify("kitchen_stealth_alert");
  var_0 = common_scripts\utility::getfx("flashlight_spotlight");
  var_1 = spawn("script_model", self.origin);
  var_1 setModel("com_flashlight_on");
  var_1 linkto(self, "tag_inhand", (0, 0, 0), (0, 0, 0));
  self.flashlight = var_1;
  playFXOnTag(var_0, var_1, "tag_light");
  level waittill("unlink_flashlight");
  var_1 unlink();
  var_1 setModel("com_flashlight_off");
  stopFXOnTag(var_0, var_1, "tag_light");
}

postspawn_kitchen_reinforcement() {
  if(!isDefined(level.kitchen_enemies))
    level.kitchen_enemies = [];

  level.kitchen_enemies[level.kitchen_enemies.size] = self;
  self.doorflashchance = 1;
  self.goalradius = 150;
  self setgoalentity(level.player);
  self.ignoresuppression = 1;
}

kitchen_enemy_pass_count() {
  for(;;) {
    var_0 = 0;
    level.kitchen_enemies = common_scripts\utility::array_removeundefined(level.kitchen_enemies);

    if(level.kitchen_enemies.size < 4) {
      if(common_scripts\utility::flag("kitchen_stealth_alert")) {
        foreach(var_2 in level.kitchen_enemies) {
          var_2.goalradius = 100;
          var_2 setgoalentity(level.player);
        }
      }
    }

    if(common_scripts\utility::flag("kitchen_stealth_alert")) {
      if(level.kitchen_enemies.size == 0) {
        break;
      }
    } else {
      foreach(var_5 in level.kitchen_enemies) {
        if(isDefined(var_5.removed))
          var_0++;
      }

      if(var_0 == level.kitchen_enemies.size) {
        break;
      }
    }

    wait 0.05;
  }

  common_scripts\utility::flag_set("kitchen_enemies_gone");
}

atrium() {
  maps\las_vegas_code::radio_volume(1, 2);
  common_scripts\utility::flag_wait("player_in_hallway");
  common_scripts\utility::array_thread(level.heroes, maps\_utility::set_ignoreall, 1);
  thread maps\las_vegas_code::random_radio_chatter();
  thread atrium_dialogue();
  thread atrium_thread();
  thread atrium_runners();
  thread atrium_player_shoots();
  thread atrium_rorke_pa();
  thread maps\_utility::autosave_by_name("atrium");
  maps\las_vegas_code::set_player_speed("atrium");
  level.keegan maps\_utility::enable_cqbwalk();
  level.hesh maps\_utility::enable_cqbwalk();
  wait 0.1;
  var_0 = getent("atrium_volume", "targetname");
  var_0 maps\_utility::waittill_volume_dead_or_dying();
  common_scripts\utility::flag_set("shops_area_clear");
  common_scripts\utility::flag_set("shops_move_in");

  if(!common_scripts\utility::flag("shops_combat_start")) {
    level.hesh maps\_utility::smart_dialogue("vegas_hsh_oktheyregone");
    wait 1;
  } else {
    foreach(var_2 in level.heroes) {
      var_2 maps\_utility::ent_flag_clear("scripted_movement_pause");
      var_2 maps\_utility::disable_ai_color();
    }
  }

  common_scripts\utility::flag_wait("headed_to_casino_floor");
}

atrium_thread() {
  common_scripts\utility::flag_wait("shops_combat_start");

  foreach(var_1 in level.heroes) {
    var_1 maps\_utility::ent_flag_set("scripted_movement_pause");
    var_1.ignoreall = 0;
    var_1.ignoreme = 0;
    var_1 maps\_utility::set_force_color("g");
    var_1 maps\_utility::enable_ai_color();
  }

  maps\_utility::activate_trigger_with_targetname("color_atrium");
  level.hesh maps\_utility::smart_dialogue("vegas_hsh_dammitloganwhatthe");
  common_scripts\utility::flag_set("shops_move_in");
  wait 1;
  level.merrick maps\_utility::smart_dialogue("vegas_mrk_gohot");
}

atrium_dialogue() {
  common_scripts\utility::flag_wait("player_in_hallway");
  var_0 = ["vegas_saf2_oneonewevegota", "vegas_fs5_whatisitnow", "vegas_saf2_theyrekiabothteams", "vegas_fs5_comeagainoneoneyou", "vegas_saf2_thatscorrectweneed"];
  level thread maps\las_vegas_code::array_play_enemy_radio(var_0);
  wait 1.5;
  level.merrick maps\_utility::smart_dialogue("vegas_mrk_quietnobodymove");
}

atrium_rorke_pa() {
  common_scripts\utility::flag_wait("player_in_hallway");
  wait 2;
  maps\las_vegas_code::pa_queue("vegas_rke_attentioneveryone", "shops_combat_start");
  wait 1;
  maps\las_vegas_code::pa_queue("vegas_rke_somefriendsofmine", "shops_combat_start");
  maps\las_vegas_code::pa_queue("vegas_rke_returnthemtome", "shops_combat_start");
  wait 2;
  maps\las_vegas_code::pa_queue("vegas_rke_merrickheshadamifyoure", "shops_combat_start");
  wait 1;
  maps\las_vegas_code::pa_queue("vegas_rke_goodluck", "shops_combat_start");
  wait 1;
  level.merrick thread maps\_utility::smart_dialogue("vegas_mrk_thanksfortheshoutout");
}

atrium_player_shoots() {
  level endon("cleared_atrium_no_fight");
  level endon("headed_to_casino_floor");
  level endon("shops_area_clear");
  common_scripts\utility::flag_wait("atrium_stealth_alert");
  common_scripts\utility::flag_set("shops_combat_start");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(!isalive(var_2)) {
      continue;
    }
    if(var_2 maps\_utility::doinglongdeath()) {
      continue;
    }
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "atrium_escalator_enemies") {
      var_2.pathrandompercent = 0;
      continue;
    }

    var_2.ignoreme = 0;
    var_2.ignoreall = 0;
    var_2.goalradius = 1000;
    var_2 notify("stop_going_to_node");
    var_2 setgoalpos(var_2.origin);
  }

  maps\_utility::array_spawn_targetname("atrium_balcony_reinforcements");
  wait 2;
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(isDefined(var_2.rappeller)) {
      continue;
    }
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "atrium_escalator_enemies") {
      continue;
    }
    if(isDefined(var_2.rappeller)) {
      continue;
    }
    if(!isalive(var_2)) {
      continue;
    }
    if(var_2 maps\_utility::doinglongdeath()) {
      continue;
    }
    wait(randomfloatrange(1, 3));
    var_5 = common_scripts\utility::getStructArray("balcony_rope", "script_noteworthy");
    var_5 = sortbydistance(var_5, var_2.origin);
    var_2 thread actor_rappel("rail", var_5[0]);
  }
}

atrium_runners() {
  maps\_utility::array_spawn_targetname("atrium_escalator_enemies", 1);
  wait 3;
  maps\_utility::array_spawn_targetname("atrium_balcony_enemies", 1);
}

postspawn_atrium_enemy() {
  self endon("stop_going_to_node");
  self.ignoreall = 1;
  self.ignoreme = 1;

  if(isDefined(self.script_sound)) {
    self playLoopSound(self.script_sound);
    thread atrium_sound_guy_death();
    thread atrium_sound_guy();
  }

  thread maps\las_vegas_code::waittill_stealth_notify("atrium_stealth_alert", 0);
  self waittill("reached_path_end");
  self stoploopsound();
  self delete();
}

atrium_sound_guy_death() {
  self endon("entitydeleted");
  self waittill("death");
  self stoploopsound();
}

atrium_sound_guy() {
  self endon("death");
  common_scripts\utility::flag_wait("shops_combat_start");
  self stoploopsound();
}

postspawn_balcony_reinforcement() {
  wait(randomfloatrange(1, 3));
  actor_rappel("rail");
}

actor_rappel(var_0, var_1) {
  self endon("death");

  if(isDefined(self.rappeller)) {
    return;
  }
  self.rappeller = 1;
  self.animname = "rappeler";

  if(!isDefined(var_1))
    var_1 = maps\_utility::getent_or_struct_or_node(self.script_linkto, "script_linkname");

  if(var_0 == "rail") {
    if(!isDefined(var_1.rope))
      var_1.rope = maps\_utility::spawn_anim_model("rappel_rope_rail", var_1.origin);

    self.goalradius = 16;
    var_2 = var_1.origin + anglesToForward(var_1.angles) * 16;
    var_2 = (var_2[0], var_2[1], self.origin[2]);
    self setgoalpos(var_2);
    self waittill("goal");

    while(isDefined(var_1.inuse) && var_1.inuse)
      wait 0.05;

    var_3[0] = self;
    var_3[1] = var_1.rope;
    thread actor_rappel_death(var_1);
    var_1.inuse = 1;

    if(!maps\_utility::doinglongdeath()) {
      var_1 thread maps\_anim::anim_single(var_3, "temp_rappel_over_rail");
      common_scripts\utility::waitframe();
      var_1 maps\_anim::anim_set_rate(var_3, "temp_rappel_over_rail", 0.8);
      wait 2.6;

      foreach(var_5 in var_3) {
        var_1 maps\las_vegas_code::struct_stopanimscripted();
        var_5 maps\_utility::anim_stopanimscripted();
      }

      var_1 thread maps\_anim::anim_last_frame_solo(var_1.rope, "temp_rappel_over_rail");
      self notify("rappel_done");
      var_1.inuse = 0;
      self.a.nodeath = 0;
    }
  }

  self.goalradius = 1000;
  self setgoalpos(self.origin);
  self.ignoreme = 0;
}

actor_rappel_death(var_0) {
  self endon("rappel_done");
  self.allowdeath = 1;
  common_scripts\utility::waittill_any("damage");
  var_0.inuse = 0;

  if(!isDefined(self)) {
    return;
  }
  maps\_utility::anim_stopanimscripted();
  self.skipdeathanim = 1;
  self kill();
}

atrium_room_destruction() {
  wait(randomfloatrange(2, 4));
  var_0 = getent("atrium_car_fall", "targetname");
  var_1 = maps\_utility::getent_or_struct_or_node(var_0.target, "targetname");
  var_2 = maps\las_vegas_code::get_target_chain_array(var_1);

  foreach(var_4 in var_2) {
    var_0 moveto(var_4.origin, 0.4);
    var_0 rotateto(var_4.angles, 0.4);
    wait 0.4;
  }

  var_6 = getglass("atrium_car_fall_glass");
  destroyglass(var_6, (-1, 0, 0));
}

to_casino_floor(var_0) {
  if(!common_scripts\utility::flag("shops_combat_start"))
    common_scripts\utility::flag_wait_or_timeout("player_atrium_halfway", randomfloatrange(3, 5));
  else
    self.goalradius = 200;

  common_scripts\utility::flag_set("player_atrium_halfway");
  var_1 = getnodearray("floor_start_path", "targetname");
  var_0 = maps\las_vegas_code::array_get_noteworthy(var_1, self.script_noteworthy);

  if(!common_scripts\utility::flag("shops_combat_start"))
    wait(randomfloat(2));

  thread maps\las_vegas_code::scripted_movement(var_0);
}

casino_floor() {
  init_casino_door();
  init_gate();
  level.merrick maps\las_vegas_code::set_not_wounded();
  common_scripts\utility::array_thread(level.heroes, maps\_utility::enable_cqbwalk);
  maps\las_vegas_code::set_player_speed("floor");
  common_scripts\utility::array_thread(level.heroes, maps\_utility::set_ignoreall, 1);
  maps\_utility::autosave_by_name("casino_floor");
  common_scripts\utility::flag_wait("casino_floor_done");
  level notify("stop_enemy_radio_chatter");
  maps\_utility::music_stop(20);
}

init_casino_door() {
  var_0 = getent("casino_door", "targetname");
  var_1 = getEntArray(var_0.target, "targetname");
  common_scripts\utility::array_call(var_1, ::linkto, var_0);
}

open_casino_door_anim(var_0) {
  self setgoalnode(var_0);
  common_scripts\utility::flag_wait("headed_to_casino_floor");
  var_1 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_2 = getanimlength(maps\_utility::getanim("open_casino_door"));
  var_1 maps\_anim::anim_reach_solo(self, "open_casino_door");
  var_1 thread maps\_anim::anim_single_solo(self, "open_casino_door");
  var_3 = getent("casino_door", "targetname");
  var_3 maps\_utility::delaythread(1.25, ::open_casino_door);
  level maps\_utility::delaythread(1, common_scripts\utility::flag_set, "casino_door_opened");
}

open_casino_door() {
  self playSound("scn_vegas_glass_door_open");
  self rotateyaw(93, 1.5);
  wait 3;
  self connectpaths();
}

casino_ambush_keegan(var_0) {
  self.dontavoidplayer = 1;
  self pushplayer(1);
  level thread casino_floor_ambush();
}

casino_floor_ambush() {
  common_scripts\utility::flag_wait("start_casino_ambush");
  thread maps\_utility::array_spawn_targetname("floor_ambush_spawners");
  thread casino_ambush_dialogue();
  thread casino_floor_end();
  thread casino_battle();
  thread floor_restore_heroes();
  thread floor_colors();
}

floor_restore_heroes() {
  common_scripts\utility::flag_wait("floor_battle_start");

  foreach(var_1 in level.heroes) {
    var_1.ignoreall = 0;
    var_1.ignoreme = 0;
    var_1 maps\_utility::enable_arrivals();
    var_1 maps\_utility::enable_exits();
    var_1.dontevershoot = undefined;
    var_1 clearentitytarget();
    var_1 allowedstances("stand", "crouch", "prone");
    var_1.dontavoidplayer = 0;
    var_1 pushplayer(0);
  }
}

floor_colors() {
  var_0 = getent("start_casino_floor_colors", "targetname");
  var_0 waittill("trigger");

  if(!common_scripts\utility::flag("floor_battle_start")) {
    common_scripts\utility::flag_wait("floor_battle_start");
    wait 2;
  }

  level.hesh maps\_utility::set_force_color("r");
  level.keegan maps\_utility::set_force_color("b");
  level.merrick maps\_utility::set_force_color("g");
}

casino_battle() {
  level.casino_floor = spawnStruct();
  level.casino_floor.enemy_volume = getent("floor_volume_start", "targetname");
  level.casino_floor.enemies = [];
  var_0 = getEntArray("floor_volume_triggers", "targetname");
  common_scripts\utility::array_thread(var_0, maps\las_vegas_code::enemy_volume_trigger_thread, level.casino_floor, "casino_floor_done");
  thread casino_battle_think();
  common_scripts\utility::flag_wait("floor_battle_start");
  thread maps\las_vegas_code::enemy_radio_battle_loop();
  maps\_utility::battlechatter_on("axis");
  maps\_utility::battlechatter_on("allies");
  thread floor_go_colors();
  thread floor_reinforcements();

  if(level.gameskill > 1)
    maps\_utility::delaythread(2.5, maps\_utility::array_spawn_targetname, "floor_snipers");

  maps\_utility::delaythread(2, maps\_utility::music_play, "mus_vegas_casino_battle");
  maps\_utility::delaythread(30, maps\_spawner::killspawner, 300);
}

floor_go_colors() {
  var_0 = getent("start_casino_floor_colors", "targetname");
  var_0 endon("trigger");
  wait 5;
  var_1 = getent("floor_volume_start", "targetname");

  for(;;) {
    wait 0.1;
    var_2 = var_1 maps\_utility::get_ai_touching_volume("axis");

    if(var_2.size < 6) {
      break;
    }
  }

  maps\_utility::activate_trigger_with_targetname("start_casino_floor_colors");
}

floor_reinforcements() {
  var_0 = 4;

  while(!common_scripts\utility::flag("casino_floor_done")) {
    wait 0.2;
    level.casino_floor.enemies = common_scripts\utility::array_removeundefined(level.casino_floor.enemies);

    if(level.casino_floor.enemies.size >= var_0) {
      continue;
    }
    var_1 = getEntArray("floor_reinforcements", "targetname");

    if(var_1.size == 0) {
      return;
    }
    var_2 = var_1[randomint(var_1.size)];
    var_2 maps\_utility::spawn_ai();
  }
}

casino_battle_think() {
  while(!common_scripts\utility::flag("casino_floor_done")) {
    wait 0.1;
    maps\las_vegas_code::update_enemy_volume(level.casino_floor);
  }
}

casino_ambush_dialogue() {
  level endon("floor_battle_start");
  thread floor_keegan_shoot();
  level.hesh.bulletsinclip = 1;
  level.keegan.old_primaryweapon = level.keegan.primaryweapon;
  level.hesh maps\_utility::smart_dialogue("vegas_hsh_holduphere");
  level.keegan maps\_utility::forceuseweapon(level.keegan.secondaryweapon, "primary");
  wait 1;
  level.merrick.bulletsinclip = 1;
  level.merrick maps\_utility::smart_dialogue("vegas_mrk_wewontbeable");
  level.hesh maps\_utility::smart_dialogue("vegas_hsh_waituntiltheyget");
  wait 1;
  maps\_utility::notify_delay("keegan_do_it", 0.5);
  level.hesh maps\_utility::smart_dialogue("vegas_hsh_alrightkeegankickit");
}

floor_keegan_shoot() {
  level endon("floor_battle_start");

  if(common_scripts\utility::flag("floor_battle_start")) {
    return;
  }
  level waittill("keegan_do_it");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0)
  var_2.ignoreme = 0;

  level.keegan.ignoreall = 0;
  level.keegan waittill("shooting");
  common_scripts\utility::flag_set("floor_battle_start");
}

postspawn_floor_ambush() {
  self endon("death");
  maps\_utility::enable_cqbwalk();
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.script_forcegoal = 1;
  self.stealth_radius_multiplier = 4.25;
  thread ambush_handler();
  thread maps\las_vegas_code::waittill_stealth_notify("floor_battle_start");
  level waittill("stealth_event_notify");

  if(!common_scripts\utility::flag("floor_battle_start"))
    common_scripts\utility::flag_set("floor_battle_start");

  self.ignoreall = 0;
  self.ignoreme = 0;
  maps\_utility::clear_archetype();
  maps\_utility::disable_cqbwalk();
  wait(randomfloatrange(0.2, 5));
  add_casino_enemy();
}

ambush_handler() {
  level endon("stealth_event_notify");
  var_0 = common_scripts\utility::getstruct(self.target, "targetname");
  var_0 waittill("trigger");
  maps\_utility::disable_cqbwalk();
  maps\_utility::set_archetype("creepwalk");
}

postspawn_floor_enemy() {
  self endon("death");
  add_casino_enemy();
}

add_casino_enemy() {
  level.casino_floor.enemies[level.casino_floor.enemies.size] = self;
  maps\las_vegas_code::set_goal_volume(level.casino_floor.enemy_volume);
}

postspawn_floor_sniper() {
  self endon("death");
  self.ignoresuppression = 1;
  self.disablelongdeath = 1;
  var_0 = self.origin;
  self.accuracy = 0.3;

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "left_side_first")
      self allowedstances("crouch");
    else
      self allowedstances("stand");
  }

  self laserforceon();
  common_scripts\utility::flag_wait("player_halfway_casino_floor");
  self.goalradius = 50;
  self setgoalpos(var_0);
  self waittill("goal");
  self delete();
}

send_friends_down_first_stairs_guys_alive_setflag() {
  var_0 = getaiarray("axis");
  maps\_utility::waittill_dead_or_dying(var_0, 3, 35);
  common_scripts\utility::flag_set("player_on_stairs_casino_floor");
}

last_snipers_think() {
  self endon("death");
  self allowedstances("stand");

  if(isDefined(self.script_noteworthy)) {
    maps\_utility::forceuseweapon("l115a3+scopel115a3_sp", "primary");
    self.dontdropweapon = 1;
    self.disablelongdeath = 1;
    self laserforceon();
  }
}

casino_floor_end() {
  common_scripts\utility::flag_wait("player_escalator_casino_floor");
  var_0 = getent("floor_end_volume", "targetname");
  var_0 maps\_utility::waittill_volume_dead_or_dying();
  common_scripts\utility::flag_set("casino_floor_done");
}

postspawn_floor_gate() {
  self endon("death");
  var_0 = undefined;

  if(isDefined(self.script_parameters) && self.script_parameters == "last_guy") {
    self.ignoreall = 1;
    self.dontavoidplayer = 1;
    self setCanDamage(0);
    self waittill("goal");
    var_1 = getent("floor_gate", "targetname");
    var_1 moveto(var_1.origin + (0, 0, -40), 0.5, 0.4, 0.1);
    self.ignoreall = 0;
    self.dontavoidplayer = 0;
    self setCanDamage(1);
  }

  add_casino_enemy();
}

hotel() {
  init_gate();
  maps\las_vegas_code::set_player_speed("hotel");
  maps\_utility::delaythread(2, ::radio_conversation);
  thread open_gate_dialogue();
  var_0 = getnode("keegan_floor_end", "targetname");
  level.keegan thread maps\las_vegas_code::scripted_movement(var_0, 1);
  var_0 = getnode("merrick_floor_end", "targetname");
  level.merrick thread maps\las_vegas_code::scripted_movement(var_0, 1);
  var_0 = getnode("hesh_floor_end", "targetname");
  level.hesh thread maps\las_vegas_code::scripted_movement(var_0, 1);
  maps\_utility::autosave_by_name("hotel");
  thread escalator_birds();
  thread hotel_hallway_dialogue();
  common_scripts\utility::flag_wait("player_at_junction");
}

radio_conversation() {
  level endon("stop_radio_conversation");
  var_0 = ["conversation_1", "conversation_2", "conversation_3"];

  foreach(var_3, var_2 in var_0)
  maps\las_vegas_code::enemy_radio_chatter(var_2);
}

init_gate() {
  var_0 = getent("floor_gate", "targetname");

  if(isDefined(var_0.init)) {
    return;
  }
  var_0.animname = "gate";
  var_0 maps\_anim::setanimtree();
  var_0.init = 1;
  var_1 = common_scripts\utility::getstruct("open_gate", "script_noteworthy");
  var_2 = var_1 maps\las_vegas_code::makestruct();
  var_2.origin = var_2.origin + (0, 0, 40);
  var_2 maps\_anim::anim_first_frame_solo(var_0, "gate_lift");
}

open_gate_keegan(var_0) {
  var_0 maps\_anim::anim_reach_solo(level.keegan, "gate_lift");
  level maps\_utility::delaythread(3.5, common_scripts\utility::flag_set, "merrick_under_gate");
  level maps\_utility::delaythread(5, common_scripts\utility::flag_set, "hesh_under_gate");
  level.keegan maps\_utility::delaythread(3, maps\_utility::smart_dialogue, "vegas_kgn_effortsoundsoflifting");
  var_1 = getent("floor_gate", "targetname");
  var_1.animname = "gate";
  var_1 maps\_anim::setanimtree();
  var_2 = getent("gate_playerclip", "targetname");
  var_2.og_pos = var_2.origin;
  var_2 common_scripts\utility::delaycall(3.6, ::moveto, var_2.origin + (0, 0, 51), 2);
  var_3 = [level.keegan, var_1];
  var_0 maps\_anim::anim_single(var_3, "gate_lift");
  common_scripts\utility::flag_set("player_under_gate_ready");
  var_0 thread maps\_anim::anim_loop(var_3, "gate_idle");
  thread player_under_gate();
  common_scripts\utility::flag_wait("player_under_gate");

  foreach(var_5 in level.heroes) {
    var_5 maps\_utility::enable_arrivals();
    var_5 maps\_utility::enable_exits();
  }

  var_2.origin = var_2.og_pos;
  var_0 maps\las_vegas_code::struct_stopanimscripted();
  var_0 thread maps\_anim::anim_single(var_3, "under_gate");
}

open_gate_dialogue() {
  level.hesh thread maps\_utility::smart_dialogue("vegas_hsh_keepusmovinkeegan");
  wait 3;
  level.keegan thread maps\_utility::smart_dialogue("vegas_kgn_throughhere");
  common_scripts\utility::flag_wait("player_under_gate_ready");
  level.hesh thread maps\_utility::smart_dialogue("vegas_hsh_waitwheresriley");
  wait 3;
  level.merrick thread maps\_utility::smart_dialogue("vegas_mrk_itgotchaoticpretty");
}

hotel_hallway_dialogue() {
  common_scripts\utility::flag_wait("player_exiting_escalators");
  level.merrick thread maps\_utility::smart_dialogue("vegas_mrk_exitstotheleft");
  wait 1;
  level.hesh thread maps\_utility::smart_dialogue("vegas_hsh_goinleft");
}

player_under_gate() {
  var_0 = getent("through_gate_volume", "targetname");
  var_1 = [level.hesh, level.merrick, level.player];

  for(;;) {
    var_2 = 0;

    foreach(var_4 in var_1) {
      if(var_4 istouching(var_0))
        var_2++;
    }

    if(var_2 == var_1.size) {
      break;
    }

    wait 0.05;
  }

  common_scripts\utility::flag_set("player_under_gate");
  common_scripts\utility::flag_set("floor_gate_done");
}

escalator_birds() {
  var_0 = [];
  var_1 = getEntArray("casino_er_interactive_birds", "targetname");

  foreach(var_3 in var_1)
  var_0[var_0.size] = var_3 maps\interactive_models\_birds::birds_savetostruct();

  common_scripts\utility::flag_wait("player_in_escalators");
  wait(randomfloatrange(0.2, 1));

  foreach(var_6 in var_0)
  var_6 maps\interactive_models\_birds::birds_loadfromstruct();

  var_8 = getEntArray("casion_er_pigeons_trigs", "script_noteworthy");
  var_8 = common_scripts\utility::array_randomize(var_8);
  var_8[0] notify("trigger");
}

casino_hotel_runners(var_0) {
  wait(randomfloatrange(var_0[0], var_0[1]));
  var_1 = common_scripts\utility::getstruct(self.target, "targetname");
  var_2 = maps\_utility::spawn_ai(1);

  if(!isDefined(var_2)) {
    return;
  }
  var_2 maps\_utility::disable_arrivals();
  var_2 maps\_utility::disable_exits();
  var_2 maps\las_vegas_code::ignore_everything();
  var_2 thread maps\las_vegas_code::set_goal_any(var_1, 1);
}

hotel_chase() {
  maps\las_vegas_code::set_player_speed("chase", 2);
  maps\_utility::autosave_by_name("hotel_chase");
  common_scripts\utility::flag_wait("door_react_count");
  common_scripts\utility::flag_set("disable_autosaves");
  common_scripts\utility::flag_wait("chase_started");
  common_scripts\utility::array_thread(level.heroes, maps\_utility::disable_cqbwalk);
  casino_jumpout_sequence();
}

react_doors() {
  level notify("stop_radio_conversation");
  thread maps\las_vegas_code::enemy_radio_battle_loop();
  forever_spawn_targetname("chase_enemies", "FLAG_player_start_slide");
  common_scripts\utility::flag_set("chase_started");
  var_0 = getEntArray("white_doors", "targetname");
  var_1 = undefined;

  foreach(var_3 in var_0) {
    var_4 = getEntArray(var_3.target, "targetname");
    common_scripts\utility::array_call(var_4, ::linkto, var_3);
  }

  level thread nade_room();
  thread maps\las_vegas_code::doors_open(var_0, 1.4, "double_door_wood_creeky", 110, 0, 0.7);
  wait 1.9;
  maps\_utility::music_play("mus_vegas_hallway_chase");
  wait 8;
}

hallway_timed_grenades() {
  wait 1;
  thread maps\las_vegas_code::launch_gas_by_targetname("hallway_nade_structs");
  add_gas_struct("chase_enemy_gas1", "FLAG_player_start_slide");
  wait 2;
  thread maps\las_vegas_code::launch_gas_by_targetname("hallway_nade_structs01");
  add_gas_struct("chase_enemy_gas2", "FLAG_player_start_slide");
  wait 3;
  thread maps\las_vegas_code::launch_gas_by_targetname("hallway_nade_structs02");
  add_gas_struct("chase_enemy_gas3", "FLAG_player_start_slide");
  common_scripts\utility::flag_wait("player_in_hotel_room");
}

add_gas_struct(var_0, var_1) {
  var_2 = common_scripts\utility::getstruct(var_0, "targetname");
  var_2.end = common_scripts\utility::getstruct(var_2.target, "targetname");
  var_3 = 0;

  if(!isDefined(level.gas_handler)) {
    level.gas_handler = spawnStruct();
    level.gas_handler.structs = [];
    var_3 = 1;
  }

  var_2.normal = vectornormalize(var_2.end.origin - var_2.origin);
  level.gas_handler.structs[level.gas_handler.structs.size] = var_2;

  if(var_3)
    level thread gas_struct_think(var_1);
}

gas_struct_think(var_0) {
  var_1 = 50;
  var_2 = 30;
  var_3 = 0;

  while(!common_scripts\utility::flag(var_0)) {
    var_4 = 0;

    foreach(var_6 in level.gas_handler.structs) {
      var_7 = vectornormalize(level.player.origin - var_6.end.origin);
      var_8 = vectordot(var_7, var_6.normal);

      if(var_8 < 0) {
        var_9 = pointonsegmentnearesttopoint(var_6.origin, var_6.end.origin, level.player.origin);

        if(distancesquared(var_9, level.player.origin) > squared(var_6.radius))
          continue;
      }

      var_10 = maps\_utility::get_progress(var_6.origin, var_6.end.origin, level.player.origin);

      if(var_10 > var_4)
        var_4 = var_10;
    }

    var_12 = int(var_4 * 100);

    if(var_4 > 0)
      level.player dodamage(var_12 / level.player.damagemultiplier, level.player.origin + (0, 0, 60));

    level.player maps\_utility::player_speed_percent(100 - var_12);
    var_13 = var_2 * var_4;

    if(var_13 != var_3) {
      var_3 = var_13;
      setblur(var_13, 5);
    }

    wait 0.1;
  }

  level.player maps\_utility::player_speed_percent(100);
}

door_react_merrick(var_0) {
  maps\_utility::ent_flag_init("door_react_done");
  var_1 = var_0 maps\las_vegas_code::makestruct();
  var_1.angles = (0, 0, 0);
  anim_reach_goalnode(var_0);
  maps\_utility::flag_count_decrement("door_react_count");
  common_scripts\utility::flag_wait("door_react_count");
  common_scripts\utility::flag_wait("player_at_junction");
  level.merrick maps\_utility::delaythread(2, maps\_utility::smart_dialogue, "vegas_mrk_backitupback");
  maps\_utility::delaythread(1, ::react_doors);
  level thread hallway_timed_grenades();
  var_1 = var_0 maps\las_vegas_code::makestruct();
  var_1.angles = (0, 90, 0);
  thread temp_delayed_run();
  var_1 maps\_anim::anim_single_solo(self, "door_react");
  common_scripts\utility::flag_set("door_react_done");
  maps\_utility::ent_flag_set("door_react_done");
}

door_react_hesh(var_0) {
  maps\_utility::ent_flag_init("door_react_done");
  var_1 = var_0 maps\las_vegas_code::makestruct();
  var_1.angles = (0, 0, 0);
  anim_reach_goalnode(var_0);
  maps\_utility::flag_count_decrement("door_react_count");
  common_scripts\utility::flag_wait("door_react_count");
  common_scripts\utility::flag_wait("player_at_junction");
  var_1 = var_0 maps\las_vegas_code::makestruct();
  var_1.angles = (0, -90, 0);
  thread temp_delayed_run();
  var_1 maps\_anim::anim_single_solo(self, "door_react");
  maps\_utility::ent_flag_set("door_react_done");
}

door_react_keegan(var_0) {
  maps\_utility::ent_flag_init("door_react_done");
  var_1 = var_0 maps\las_vegas_code::makestruct();
  var_1.origin = var_1.origin + (-5, 0, 0);
  var_1.angles = (0, 0, 0);
  anim_reach_goalnode(var_0);
  maps\_utility::flag_count_decrement("door_react_count");
  common_scripts\utility::flag_wait("door_react_count");
  common_scripts\utility::flag_wait("player_at_junction");
  thread temp_delayed_run();
  var_0 maps\_anim::anim_single_solo(self, "door_react");
  maps\_utility::ent_flag_set("door_react_done");
}

delayed_goal_fix_animation_issues(var_0, var_1) {
  wait 0.2;
  var_2 = getstartorigin(var_0.origin, var_0.angles, level.scr_anim[self.animname][var_1]);
  self setgoalpos(var_2);
}

anim_reach_goalnode(var_0) {
  var_1 = self.goalradius;
  self.goalradius = 4;
  self setgoalnode(var_0);
  self waittill("goal");
  self.goalradius = var_1;
}

temp_delayed_run() {
  wait 3;
  self.a.movement = "run";
}

forever_spawn_targetname(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");

  foreach(var_4 in var_2)
  var_4 thread forever_spawn_thread(var_1);
}

forever_spawn_thread(var_0) {
  level endon(var_0);
  self endon("death");

  for(;;) {
    self.count = 1;
    var_1 = maps\_utility::spawn_ai();

    if(!isDefined(var_1)) {
      wait 0.2;
      continue;
    }

    var_1 waittill("death");

    if(!maps\_utility::script_delay())
      wait(randomfloatrange(1, 3));
  }
}

postspawn_chase_enemies() {
  self endon("death");
  self.baseaccuracy = 0.1;
  self setthreatbiasgroup("chase_wall");
  self.targetname = "chase_enemy_ai";

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "crouch")
    common_scripts\utility::delaycall(2, ::allowedstances, "crouch");

  self waittill("goal");
  self allowedstances("stand", "crouch", "prone");
  thread chase_enemy_path();
  common_scripts\utility::flag_wait("FLAG_player_slide_complete");
  self delete();
}

postspawn_chase_room_enemies() {
  self endon("death");
  self.flashbangimmunity = 1;
  self.disablepain = 1;
  self.doorflashchance = 1;
  self.goalradius = 200;
  self waittill("reached_path_end");
  self setgoalentity(level.player);
}

chase_enemy_path() {
  self endon("death");

  if(!isDefined(self.target)) {
    return;
  }
  var_0 = getnode(self.target, "targetname");

  for(;;) {
    if(isDefined(var_0.radius))
      self.goalradius = var_0.radius;

    self setgoalnode(var_0);
    self waittill("goal");

    if(isDefined(var_0.script_flag_wait))
      common_scripts\utility::flag_wait(var_0.script_flag_wait);

    var_1 = var_0 maps\_utility::script_delay();

    if(var_1) {
      if(isDefined(var_0.script_delay_min))
        var_0.script_delay_min = undefined;

      if(isDefined(var_0.script_delay_max))
        var_0.script_delay_max = undefined;

      if(isDefined(var_0.script_delay))
        var_0.script_delay = undefined;
    }

    if(!isDefined(var_0.target)) {
      break;
    }

    var_0 = getnode(var_0.target, "targetname");
  }
}

nade_room() {
  level endon("FLAG_player_start_slide");
  common_scripts\utility::flag_wait("player_in_hotel_room");
  wait 4;
  common_scripts\utility::flag_wait_any("player_nade_room", "player_in_hotel_room");
  maps\_utility::delaythread(2, ::forever_spawn_targetname, "chase_room_enemies", "FLAG_player_start_slide");
  maps\_spawner::killspawner(600);
  var_0 = getEntArray("chase_enemy_ai", "targetname");
  common_scripts\utility::array_call(var_0, ::delete);
  var_1 = common_scripts\utility::getStructArray("nade_room_struct", "targetname");

  foreach(var_3 in var_1) {
    var_4 = common_scripts\utility::getstruct(var_3.target, "targetname");
    var_3.dir = vectornormalize(var_4.origin - var_3.origin);
  }

  var_6 = "fraggrenade";
  var_7 = 2;
  var_8 = 3;

  for(var_9 = 0; var_9 < var_7; var_9++) {
    var_3 = var_1[var_9 % 2];

    if(var_6 == "fraggrenade")
      magicgrenademanual(var_6, var_3.origin, var_3.dir * randomfloatrange(700, 1000), var_8);
    else
      magicgrenademanual(var_6, var_3.origin, var_3.dir * randomfloatrange(600, 1000));

    wait(randomfloatrange(0.5, 2));
  }
}

anim_reach_arrival_solo(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  var_6[0] = var_0;
  var_7 = maps\_anim::get_anim_position(var_2);
  var_8 = var_7["origin"];
  var_9 = var_7["angles"];
  var_10 = var_0.animname;

  if(isDefined(level.scr_anim[var_10][var_1])) {
    if(isarray(level.scr_anim[var_10][var_1]))
      var_11 = level.scr_anim[var_10][var_1][0];
    else
      var_11 = level.scr_anim[var_10][var_1];

    var_8 = getstartorigin(var_8, var_9, var_11);
    var_9 = getstartorigin(var_8, var_9, var_11);
  }

  if(isDefined(var_5))
    var_9 = var_5;

  var_12 = spawn("script_origin", var_8);
  var_12.angles = var_9;

  if(isDefined(var_3))
    var_12.type = var_3;
  else
    var_12.type = self.type;

  if(isDefined(var_4))
    var_12.arrivalstance = var_4;
  else
    var_12.arrivalstance = self gethighestnodestance();

  var_0.scriptedarrivalent = var_12;
  maps\_anim::anim_reach_and_approach(var_6, var_1, var_2);
  var_0.scriptedarrivalent = undefined;
  var_12 delete();

  while(var_0.a.movement != "stop")
    wait 0.05;
}

casino_jumpout_sequence() {
  if(isDefined(level.jumpoutdone)) {
    level.jumpoutdone = undefined;
    return;
  }

  setsaveddvar("player_sprintUnlimited", 1);
  setsaveddvar("ai_friendlyFireBlockDuration", "0");
  maps\_utility::battlechatter_off("allies");

  foreach(var_1 in level.heroes) {
    var_1 setCanDamage(0);
    var_1.disableplayeradsloscheck = 1;
    var_1 maps\las_vegas_code::ignore_everything();
  }

  level.jumpout_enemies = [];
  var_3 = getent("casino_hotel_trig_5", "targetname");
  thread maps\las_vegas_code::func_waittill_msg(var_3, "trigger", ::casino_raid_end_hallway_guys);
  var_4 = common_scripts\utility::getstruct("casino_raid_sequence_spot", "targetname");
  var_5 = getent("casino_hotel_door", "targetname");
  var_6 = getEntArray(var_5.target, "targetname");

  foreach(var_8 in var_6) {
    var_8 linkto(var_5);

    if(isDefined(var_8.script_noteworthy))
      var_5.breakpiece = var_8;
  }

  thread lerp_threatbias();
  thread casino_jumpout_trenchrun();
  common_scripts\utility::array_thread(level.heroes, ::casino_jumpout_code, var_4, var_5);
  common_scripts\utility::flag_wait("player_in_hotel_room");

  if(!common_scripts\utility::flag("TRACKFLAG_KEEGAN_JUMP")) {
    level.player allowsprint(0);
    common_scripts\utility::flag_wait("TRACKFLAG_KEEGAN_JUMP");
    level.player allowsprint(1);
  }

  maps\las_vegas_code::trigger_waittill_trigger("casino_slide_start_trig");
  common_scripts\utility::flag_set("FLAG_player_start_slide");
  level notify("player_not_looking_into_wind");
  level.windspot maps\_utility::delaythread(2, common_scripts\utility::stop_loop_sound_on_entity, "loop_wind_near");
  level.windspot common_scripts\utility::delaycall(3, ::delete);

  foreach(var_1 in level.heroes)
  var_1 setCanDamage(1);

  setsaveddvar("player_sprintUnlimited", 1);
}

lerp_threatbias() {
  level endon("FLAG_player_start_slide");
  wait 8;
  var_0 = 0;

  for(;;) {
    var_0 = var_0 + 1;
    setthreatbias("heroes", "chase_wall", var_0);

    if(var_0 == 1000) {
      return;
    }
    wait 0.1;
  }
}

casino_jumpout_code(var_0, var_1) {
  maps\_utility::disable_arrivals();
  maps\_utility::disable_exits();
  self pushplayer(1);
  self.dontavoidplayer = 1;
  var_2 = var_0 maps\las_vegas_code::makestruct();
  maps\_utility::ent_flag_wait("door_react_done");
  var_3 = self.pathrandompercent;
  self.pathrandompercent = 0;

  if(self == level.keegan) {
    self.animplaybackrate = 1.3;
    self.doslide = 1;
    maps\_utility::set_run_anim("sprint_1hand_gundown");
    var_2 maps\_anim::anim_reach_solo(self, "vegas_raid_jump");
    var_2 thread maps\_anim::anim_single_solo(self, "vegas_raid_jump");
    thread casino_heroes_tarp_anim(var_2);
    level.hesh maps\_utility::delaythread(1, maps\_utility::smart_dialogue, "vegas_hsh_leftgoleft");
    level.merrick maps\_utility::delaythread(3, maps\_utility::smart_dialogue, "vegas_bkr_throughheregogo");
    var_4 = ["vegas_mrk_logancatchup", "vegas_hsh_loganhurry"];
    maps\_utility::delaythread(4, maps\las_vegas_code::nag_thread, var_4, "player_in_hotel_room", 3, 7, 0);
    var_1 maps\_utility::delaythread(2.4, maps\las_vegas_code::door_open, 0.4, undefined, 105);
    var_1 maps\_utility::delaythread(2.85, maps\las_vegas_code::door_open, 0.8, undefined, -10, 0, 0.2);
    wait 5;
    var_5 = getent("casino_raidroom_wind_trig", "targetname");

    if(!level.player maps\_utility::player_looking_at(var_5.origin + (-20, 0, 0))) {
      var_2 maps\_anim::anim_set_rate_single(self, "vegas_raid_jump", 0);

      for(;;) {
        if(level.player maps\_utility::player_looking_at(var_5.origin + (-20, 0, 0))) {
          break;
        }

        if(common_scripts\utility::flag("player_in_hotel_room")) {
          break;
        }

        wait 0.05;
      }

      var_2 maps\_anim::anim_set_rate_single(self, "vegas_raid_jump", 1);
    }

    thread maps\_utility::smart_dialogue("vegas_mrk_gettothewindow");
    var_6 = getent("casino_raidroom_glass", "targetname");
    level.windspot = spawn("script_origin", var_6.origin + (0, -500, 0));
    level.windspot maps\_utility::delaythread(1.3, common_scripts\utility::play_loop_sound_on_entity, "loop_wind_near");
    maps\_utility::delaythread(1.3, common_scripts\utility::play_sound_in_space, "glass_pane_blowout", var_6.origin);
    maps\_utility::delaythread(1.3, maps\_utility::deleteent, var_6);
    maps\_utility::delaythread(1.3, common_scripts\utility::exploder, "raidroom_dust_enter");
    var_7 = common_scripts\utility::getstruct("raidroom_glass_spot", "targetname");
    var_8 = maps\_utility::spawn_anim_model("window", var_7.origin);
    var_7 maps\_anim::anim_first_frame_solo(var_8, "raid_window_shatter");
    var_8 hide();
    var_7 maps\_utility::delaythread(0.7, maps\_anim::anim_single_solo, var_8, "raid_window_shatter");
    var_8 common_scripts\utility::delaycall(0.35, ::show);
    maps\_utility::delaythread(1.3, ::casino_raidroom_wind);
    maps\_utility::delaythread(1.3, common_scripts\utility::exploder, "raidroom_paper_vortex");
    var_9 = 3;

    for(var_10 = 0; var_10 < var_9; var_10++) {
      self shoot();
      wait(randomfloatrange(0.2, 0.4));
    }

    maps\_utility::clear_run_anim();
    wait 1.3;
    var_11 = gettime();
    var_12 = 2500;

    if(!common_scripts\utility::flag("FLAG_player_start_slide")) {
      var_2 maps\_anim::anim_set_rate_single(self, "vegas_raid_jump", 0);

      while(!common_scripts\utility::flag("FLAG_player_start_slide")) {
        if(gettime() - var_11 >= var_12) {
          break;
        }

        wait 0.05;
      }

      var_2 maps\_anim::anim_set_rate_single(self, "vegas_raid_jump", 1);
      var_2 waittill("vegas_raid_jump");
      wait 0.05;
      var_2 = common_scripts\utility::getstruct("outside_temp_spot", "targetname");
      self forceteleport(var_2.origin, var_2.angles, 10000);
      self setgoalpos(var_2.origin);
    }
  } else {
    self.animplaybackrate = 0.7;
    maps\_utility::enable_sprint();
    maps\_utility::disable_cqbwalk();

    if(self == level.merrick)
      maps\_utility::delaythread(3, maps\_utility::smart_dialogue, "vegas_mrk_shitshitshit");

    var_2 anim_reach_solo_funcs(self, "vegas_raid_enter_jump2");
    var_2 maps\_anim::anim_single_solo(self, "vegas_raid_enter_jump2");
    maps\_utility::disable_sprint();
    var_2 maps\_anim::anim_reach_solo(self, "vegas_raid_jump");

    if(!common_scripts\utility::flag("FLAG_player_start_slide")) {
      self.doslide = 1;
      thread jumpout_ahead_of_player();
      var_2 maps\_anim::anim_single_solo(self, "vegas_raid_jump");
      wait 0.05;
      var_2 = common_scripts\utility::getstruct("outside_temp_spot", "targetname");
      self forceteleport(var_2.origin, var_2.angles, 10000);
      self setgoalpos(var_2.origin);
    }

    thread casino_heroes_tarp_anim(var_2);
  }

  self.pathrandompercent = var_3;
  self.dontavoidplayer = 0;
  maps\_utility::enable_arrivals();
  maps\_utility::enable_exits();
  self pushplayer(0);
  self.moveloopoverridefunc = undefined;
}

anim_reach_solo_funcs(var_0, var_1, var_2, var_3) {
  var_4 = [var_0];
  maps\_anim::anim_reach_with_funcs(var_4, var_1, var_2, var_3, ::hack_reach_start_func, ::hack_reach_end_func);
}

hack_reach_start_func(var_0) {
  self.oldgoalradius = self.goalradius;
  self.oldpathenemyfightdist = self.pathenemyfightdist;
  self.oldpathenemylookahead = self.pathenemylookahead;
  self.pathenemyfightdist = 128;
  self.pathenemylookahead = 128;
  maps\_utility::disable_ai_color();
  maps\_anim::anim_changes_pushplayer(1);
  self.nododgemove = 0;
  self.og_interval = self.interval;
  self.interval = 50;
  self.fixednodewason = self.fixednode;
  self.fixednode = 0;

  if(!isDefined(self.scriptedarrivalent)) {
    self.old_disablearrivals = self.disablearrivals;
    self.disablearrivals = 1;
  }

  self.reach_goal_pos = undefined;
  return var_0;
}

hack_reach_end_func() {
  maps\_anim::reach_with_standard_adjustments_end();
  self.interval = self.og_interval;
  self.og_interval = undefined;
}

jumpout_ahead_of_player() {
  var_0 = maps\_utility::getanim("vegas_raid_jump");
  var_1 = 5;
  var_2 = 1.1;

  while(self getanimtime(var_0) < 0.333) {
    wait 0.05;

    if(level.player.origin[1] - self.origin[1] < 80) {
      var_2 = var_2 + 0.2;
      var_3 = min(5, var_2);
      maps\_anim::anim_set_rate_single(self, "vegas_raid_jump", var_2);
    }
  }

  maps\_anim::anim_set_rate_single(self, "vegas_raid_jump", 1);
}

casino_jumpout_trenchrun() {
  var_0 = getEntArray("hotel_hallway_trenchrun_phys_obj", "targetname");
  level.objectforce = [];
  level.objectforce["ac_prs_imp_com_lamp_ornate_off"] = 400;
  level.objectforce["lv_luggagedestroyed_03_dust"] = 100;
  level.objectforce["lv_luggagedestroyed_04_dust"] = 100;
  var_1 = common_scripts\utility::getStructArray("hotel_hallway_trenchrun_fake_shooters", "targetname");
  common_scripts\utility::array_thread(common_scripts\utility::getStructArray("hotel_hallway_trenchrun_shot_obj", "targetname"), ::trenchrun_objdamage, "bullet");
  common_scripts\utility::array_thread(var_0, ::trenchrun_objdamage, "phys", undefined);
  var_2 = 0;
  var_3 = common_scripts\utility::getStructArray("hotel_hallway_trenchrun_lights_start", "targetname");

  foreach(var_5 in var_3) {
    var_6 = var_5;
    var_7 = randomfloatrange(0.5, 1);

    for(;;) {
      if(var_2 == 0) {
        if(common_scripts\utility::cointoss()) {
          var_6 thread trenchrun_objdamage("radius", var_7);
          var_2 = 0;
        } else
          var_2 = 1;
      } else {
        var_6 thread trenchrun_objdamage("radius", var_7);
        var_2 = 0;
      }

      if(!isDefined(var_6.target)) {
        break;
      }

      var_6 = common_scripts\utility::getstruct(var_6.target, "targetname");
      var_7 = var_7 + randomfloatrange(0.5, 1);
      wait 0.05;
    }
  }
}

trenchrun_objdamage(var_0, var_1, var_2) {
  var_3 = self.origin;
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(var_1)) {
    var_4 = gettime();
    var_5 = var_1 * 1000;
  }

  if(var_0 == "phys") {
    self endon("damage");
    thread trenchrun_objdamage_phys_cancel();
  }

  for(;;) {
    if(isDefined(var_1)) {
      var_6 = gettime();

      if(var_6 - var_4 >= var_5) {
        break;
      }
    }

    if(common_scripts\utility::distance_2d_squared(level.player.origin, var_3) < squared(300)) {
      break;
    }

    wait 0.05;
  }

  if(common_scripts\utility::cointoss())
    wait(randomfloatrange(0.1, 0.3));

  switch (var_0) {
    case "radius":
      radiusdamage(var_3, 25, 999, 999);
      break;
    case "bullet":
      var_7 = trenchrun_get_gun();
      magicbullet(var_7, var_3 + (10, 0, 0), var_3);
      wait 0.05;
      magicbullet(var_7, var_3 + (10, 0, 0), var_3);
      break;
    case "phys":
      self notify("trenchrun_throw");
      self physicslaunchclient(var_3 + (5, 0, 0), (-25, 0, 0) * level.objectforce[self.model]);
      break;
  }

  if(isDefined(self.script_fxid))
    playFX(common_scripts\utility::getfx(self.script_fxid), var_3);
}

trenchrun_objdamage_phys_cancel() {
  self endon("trenchrun_throw");
  self setCanDamage(1);
  self waittill("damage");
  self physicslaunchclient(self.origin, (0, 0, -25));
}

trenchrun_get_gun() {
  var_0 = ["fads", "msbs"];
  var_0 = common_scripts\utility::array_randomize(var_0);
  return var_0[0];
}

trenchrun_fake_shooters() {
  level endon("player_in_hotel_room");
  var_0 = getent("casino_hotel_trig_4", "targetname");
  var_0 waittill("trigger");
  maps\_utility::battlechatter_on("axis");
  var_1 = common_scripts\utility::getstruct(self.target, "targetname");

  for(;;) {
    wait(randomfloatrange(0.5, 1));

    if(common_scripts\utility::cointoss()) {
      continue;
    }
    var_2 = bulletTrace(self.origin, var_1.origin, 1);

    if(isDefined(var_2["entity"]) && var_2["entity"] == level.player) {
      continue;
    }
    if(level.player maps\_utility::player_looking_at(var_0.origin)) {
      continue;
    }
    if(common_scripts\utility::cointoss()) {
      var_3 = randomintrange(3, 5);

      for(var_4 = 0; var_4 < var_3; var_4++) {
        var_5 = trenchrun_get_gun();
        magicbullet(var_5, self.origin, var_1.origin);
        wait(randomfloatrange(0.1, 0.2));
        var_2 = bulletTrace(self.origin, var_1.origin, 1);

        if(isDefined(var_2["entity"]) && var_2["entity"] == level.player) {
          continue;
        }
        if(level.player maps\_utility::player_looking_at(var_0.origin))
          continue;
      }

      continue;
    }

    magicbullet("fads", self.origin, var_1.origin);
  }
}

casino_heroes_tarp_anim(var_0) {
  if(isDefined(self.doslide)) {
    self.doslide = undefined;
    var_0 waittill("vegas_raid_jump");
  }
}

casino_raid_end_hallway_guys() {
  forever_spawn_targetname("casino_hotel_baddies_flooders01", "FLAG_player_start_slide");
  common_scripts\utility::flag_wait("FLAG_player_start_slide");
}

play_nag_lines(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = "";

  for(var_3 = ""; !common_scripts\utility::flag(var_2); var_1 = var_3) {
    for(;;) {
      var_3 = var_0[randomint(var_0.size)];

      if(var_3 != var_1) {
        break;
      }
    }

    maps\_utility::dialogue_queue(var_3);
    wait(randomfloatrange(1, 1.5));
  }
}

casino_raidroom_wind() {
  level endon("delete_interior_sandstorm");
  var_0 = getent("casino_raidroom_wind_trig", "targetname");
  maps\las_vegas_code::trigger_waittill_trigger("casino_raidroom_wind_trig");
  var_1 = 0;

  for(;;) {
    if(!level.player istouching(var_0)) {
      break;
    }

    var_2 = 0.15;
    var_3 = anglesToForward(level.player.angles);

    if(var_3[0] <= 0 && var_3[1] <= 0 || var_3[0] >= 0 && var_3[1] <= 0) {
      setblur(randomfloatrange(0.3, 1), 0.1);

      if(var_1 == 0) {
        var_1 = 1;
        thread casino_wind_screen_dirt("player_not_looking_into_wind");
      }
    } else {
      var_2 = 0.1;
      level notify("player_not_looking_into_wind");
      var_1 = 0;
    }

    earthquake(var_2, 0.1, level.player.origin, 9999);
    wait 0.1;
  }

  thread maps\_utility::set_blur(0, 0.1);
  level notify("player_out_of_current");
  thread casino_raidroom_wind();
}

casino_wind_screen_dirt(var_0) {
  var_1 = [];
  var_1[var_1.size] = ["fullscreen_dirt_left", -100, 5];
  var_1[var_1.size] = ["fullscreen_dirt_right", -200, 15];
  var_2 = 1.5;
  var_3 = [];

  foreach(var_5 in var_1) {
    var_6 = newhudelem();
    var_6 setshader(var_5[0], int(640 * var_2), int(480 * var_2));
    var_6.horzalign = "fullscreen";
    var_6.vertalign = "fullscreen";
    var_6.y = var_6.y + var_5[1];
    var_6 fadeovertime(0.2);
    var_6.alpha = 1;
    var_6 thread casino_wind_screen_dirt_loop(var_0);
    var_3[var_3.size] = var_6;
  }

  level waittill(var_0);

  foreach(var_6 in var_3) {
    var_9 = randomfloatrange(0.2, 0.6);
    var_6 fadeovertime(var_9);
    var_6.alpha = 0;
    var_6 common_scripts\utility::delaycall(var_9, ::destroy);
  }
}

casino_wind_screen_dirt_loop(var_0) {
  level endon(var_0);

  for(;;) {
    var_1 = randomfloatrange(0.2, 0.4);
    self fadeovertime(var_1);
    self.alpha = randomfloatrange(0.5, 1);
    wait(var_1);
  }
}

casino_heroes_slide_hide(var_0) {
  level endon("FLAG_player_slide_complete");
  wait(var_0);
  self hide();
}

#using_animtree("script_model");

slide() {
  level notify("stop_enemy_radio_chatter");
  var_0 = getEntArray("player_slide_ambient_tarps", "targetname");

  foreach(var_2 in var_0) {
    var_2.animname = "tarp";
    var_2 useanimtree(#animtree);
  }

  var_4 = getent("vegas_window_hdr", "targetname");
  var_4 hide();
  var_5 = common_scripts\utility::getstruct("casino_player_slide_start", "targetname");
  var_6 = var_5 maps\las_vegas_code::makestruct();
  var_7 = maps\_utility::spawn_anim_model("player_rig", level.player.origin);
  var_7 hide();
  var_8 = maps\_utility::spawn_anim_model("player_legs", level.player.origin);
  var_9 = getent("player_slide_tarp", "targetname");
  var_9 useanimtree(#animtree);
  var_9.animname = "tarp";
  var_10 = [var_7, var_8];
  var_11 = level.player getcurrentweapon();

  if(isDefined(var_11)) {
    var_12 = weaponclipsize(var_11);
    level.player setweaponammoclip(var_11, var_12);
  }

  var_13 = -78.6855;
  var_14 = var_13 + 36;
  var_15 = var_13 - 36;
  var_16 = level.player.origin[0] - var_6.origin[0];
  var_16 = clamp(var_16, var_15, var_14);
  var_16 = var_16 - var_13;
  var_6.origin = var_6.origin + (var_16, 0, 0);
  maps\las_vegas_code::cinematicmode_on();
  var_6 maps\_anim::anim_first_frame_solo(var_7, "casino_player_slide");
  var_17 = 0.8;
  var_18 = anglesToForward(level.player.angles);

  if(var_18[0] <= 0 && var_18[1] <= 0 || var_18[0] >= 0 && var_18[1] <= 0)
    var_17 = 0.3;

  var_19 = 10;
  maps\_utility::delaythread(1, maps\_utility::music_stop, 2);

  if(!isalive(level.player))
    level waittill("forever");

  level.player playerlinktoblend(var_7, "tag_player", var_17);
  wait(var_17);
  level.player playerlinktodelta(var_7, "tag_player", 1, var_19, var_19, var_19, var_19, var_19, 1);
  thread slide_hide_heroes();
  var_6 thread maps\_anim::anim_single(var_10, "casino_player_slide");
  level.player common_scripts\utility::delaycall(0.5, ::playrumbleonentity, "heavy_1s");
  level.player common_scripts\utility::delaycall(1, ::playrumblelooponentity, "slide_loop");
  level.player common_scripts\utility::delaycall(2.5, ::stoprumble, "slide_loop");
  thread casino_wind_screen_dirt("TRACKFLAG_slide_stop_dirt_screen");
  level.player common_scripts\utility::delaycall(6, ::lerpfov, 100, 2.5);
  maps\_utility::delaythread(2, common_scripts\utility::flag_set, "FLAG_stop_feet_slide_fx");
  wait 0.1;
  var_7 show();
  thread player_slide_fx(var_6, var_7, var_8);
  wait 3.2;
  earthquake(0.3, 0.6, level.player.origin, 999);
  setblur(3, 0);
  wait 0.1;
  setblur(0, 0.8);
  level.player playrumbleonentity("heavy_1s");
  var_6 waittill("casino_player_slide");
  level.player common_scripts\utility::delaycall(0.6, ::setclienttriggeraudiozone, "las_vegas_gassed_black", 0.2);
  level.fadein = maps\_hud_util::create_client_overlay("black", 1, level.player);
  level notify("player_not_looking_into_wind");
  level notify("delete_interior_sandstorm");
  common_scripts\utility::array_call(level.heroes, ::show);

  if(isDefined(level.baker_glight))
    level.baker_glight delete();

  common_scripts\utility::flag_set("FLAG_player_slide_complete");
  level.player playrumbleonentity("grenade_rumble");

  if(isDefined(level.jumpout_enemies)) {
    level.jumpout_enemies = maps\_utility::remove_dead_from_array(level.jumpout_enemies);

    foreach(var_21 in level.jumpout_enemies)
    var_21 delete();
  }

  var_23 = getaiarray("axis");
  common_scripts\utility::array_call(var_23, ::delete);
  maps\las_vegas_code::cinematicmode_off();
  level.player unlink();
  var_7 delete();
  var_8 delete();
  setblur(0, 0);
  level.player lerpfov(65, 0.05);
  var_4 show();
}

slide_hide_heroes() {
  var_0 = gettime() + 3000;

  while(gettime() < var_0) {
    wait 0.05;

    foreach(var_2 in level.heroes) {
      if(var_2.origin[1] > level.player.origin[1] + 10)
        var_2 hide();
    }
  }
}

player_slide_fx(var_0, var_1, var_2) {
  var_3 = ["j_ball_le", "j_ball_ri"];

  foreach(var_5 in var_3)
  thread player_slide_fx_legs(var_5, var_2);

  var_3 = ["j_ringpalm_le", "j_ringpalm_ri"];

  foreach(var_5 in var_3)
  maps\_utility::flagwaitthread("TRACKFLAG_player_fall_grab", ::player_slide_fx_clap, var_1, var_5);

  var_9 = anglesToForward(var_0.angles);
  var_9 = var_9 * -80;
  var_10 = var_0.origin + var_9;
  var_11 = anglestoright(var_0.angles);
  var_11 = var_11 + (0, 0, -1);
  playFX(level._effect["raidroom_jump_slide_glass"], var_10, var_11);
  wait 3;
  var_10 = level.player.origin;
  playFX(level._effect["raidroom_jump_slide_glass"], var_10, var_11);
  wait 2.5;
  playFX(level._effect["raidroom_jump_drop_glass"], level.player.origin + (0, 25, 50));
}

player_slide_fx_legs(var_0, var_1) {
  var_2 = ["j_ball_le", "j_ball_ri"];
  var_3 = common_scripts\utility::getfx("slide_boot_dust");
  var_4 = anglesToForward((-45, 90, 0));
  var_5 = anglesToForward((45, 270, 0));

  while(!common_scripts\utility::flag("FLAG_stop_feet_slide_fx")) {
    var_6 = var_1 gettagorigin(var_0) + var_5 * 25;
    playFX(var_3, var_6, var_4);
    wait 0.05;
  }
}

player_slide_fx_clap(var_0, var_1) {
  var_2 = anglesToForward((-270, 0, -90));

  if(var_1 == "j_ringpalm_ri")
    wait 0.13;
  else
    wait 0.09;

  var_3 = var_0 gettagorigin(var_1) + (-4, 0, 2);
  var_4 = common_scripts\utility::getfx("vfx_dust_hand_clap");
  playFX(var_4, var_3, var_2);
}