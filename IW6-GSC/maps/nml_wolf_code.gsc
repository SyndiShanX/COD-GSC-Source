/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nml_wolf_code.gsc
*****************************************************/

chase_dog() {
  wait 0.25;
  level.player maps\_utility::player_speed_percent(90);
  level.dog.idlelookattargets = undefined;
  level.dog maps\_utility_dogs::dyn_sniff_disable();
  level.dog.script_nostairs = 1;
  maps\nml_util::team_unset_colors(128);
  level.dog maps\nml_util::set_move_rate(1);
  level.baker maps\nml_util::set_move_rate(1);
  level.baker allowedstances("stand", "crouch", "prone");
  level.baker maps\_utility::disable_cqbwalk();
  maps\nml_util::hero_paths("ridge_path", 300, 350, 700, 1, 0);
  common_scripts\utility::flag_wait("wolf_baker_slide");
  var_0 = common_scripts\utility::get_target_ent("hesh_slide_start");
  var_0 maps\_anim::anim_generic_reach(level.baker, var_0.animation);
  common_scripts\utility::flag_set("wolf_hesh_slide_done");
  level.baker thread maps\nml_util::slide_sounds(var_0.animation);
  var_0 maps\_anim::anim_generic(level.baker, var_0.animation);

  if(!common_scripts\utility::flag("wolf_start_wolfpack"))
    level.baker setgoalpos(level.baker.origin);
}

chase_dog_dialogue() {
  wait 2;
  level.baker maps\_utility::smart_dialogue("nml_hsh_letsmove_2");
  common_scripts\utility::flag_wait("wolf_cavern_start");
  level.baker maps\_utility::smart_dialogue("nml_hsh_delta11stalker2");
  common_scripts\utility::flag_wait("wolf_cavern_middle");
  level.dog thread maps\_utility_dogs::dog_bark("anml_dog_attack_npc_jump");
  level.dog maps\nml_util::set_move_rate(1.4);
  level.baker maps\_utility::disable_cqbwalk();
  wait 2;
  level.baker maps\nml_util::set_move_rate(1.1);
  level.baker maps\_utility::smart_dialogue("nml_hsh_rileyslowdown");
  wait 0.6;
  level.baker maps\_utility::smart_dialogue("nml_hsh_whatisthisdog");
  wait 0.6;
  level.baker maps\_utility::smart_dialogue("nml_hsh_rileyheel");
  level.dog maps\_utility_dogs::dog_bark("anml_dog_bark");
  wait 0.5;
  level.dog maps\_utility_dogs::dog_bark("anml_dog_bark");
  level.dog maps\_utility_dogs::dog_bark("anml_dog_bark");
  common_scripts\utility::flag_wait("wolf_baker_slide");
  wait 1.5;
  level.dog maps\_utility_dogs::dog_bark("anml_dog_bark");
  wait 0.5;
  level.dog maps\_utility_dogs::dog_bark("anml_dog_bark");
  level.dog maps\_utility_dogs::dog_bark("anml_dog_bark");
}

wolfpack() {
  level.player maps\_utility::player_speed_percent(60);
  level.baker.goalradius = 30;
  level.dog.goalradius = 30;
  level notify("wolf_wolfpack_opening");
  set_default_team_move_speed();
  level.baker maps\_utility::clear_force_color();
  level.dog maps\_utility::clear_force_color();
  level.baker maps\_utility::set_ignoreall(1);
  level.baker maps\_utility::set_ignoreme(1);
}

ghost_town_sneak() {
  var_0 = common_scripts\utility::get_target_ent("ghosttown_stack");
  var_0 common_scripts\utility::trigger_off();
  thread init_hover();
  maps\_vehicle::spawn_vehicles_from_targetname_and_drive("ghost_hover_01");
  var_1 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("ghosttown_jeeps");
  common_scripts\utility::array_thread(var_1, maps\_vehicle::godon);
  common_scripts\utility::array_thread(var_1, ::ghosttown_jeep_init);
  var_2 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("ghosttown_heli");
  common_scripts\utility::array_thread(var_2, ::ghosttown_heli_flyby_think);
  common_scripts\utility::array_thread(level.heroes, maps\_utility::set_goalradius, 64);
  level.player.ignoreme = 1;
  common_scripts\utility::array_thread(level.heroes, maps\_utility::set_ignoreme, 1);
  common_scripts\utility::array_thread(level.heroes, maps\_utility::set_ignoreall, 1);
  level.dog.ignoreme = 1;
  maps\_utility::array_spawn_targetname("ghosttown_patrol");
  ghost_town_open_the_gate();
  maps\_utility::autosave_by_name("nml");
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");
  common_scripts\utility::array_call(level.heroes, ::allowedstances, "crouch");
  level.dog thread maps\_utility_dogs::enable_dog_sneak();
  thread ghost_town_sneak_end();
  thread ghost_town_end();
}

ghosttown_heli_flyby_think() {
  if(isDefined(self.script_soundalias)) {
    self vehicle_turnengineoff();
    thread maps\_utility::play_sound_on_entity(self.script_soundalias);
  }
}

ghosttown_jeep_init() {
  self endon("death");
  self waittill("damage");
  common_scripts\utility::flag_set("ghosttown_end_patrol");
}

ghosttown_patrol_init() {
  self endon("death");
  self addaieventlistener("grenade danger");
  self addaieventlistener("projectile_impact");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("gunshot");
  self addaieventlistener("gunshot_teammate");
  self addaieventlistener("explode");
  self addaieventlistener("death");
  common_scripts\utility::waittill_either("damage", "ai_event");
  common_scripts\utility::flag_set("ghosttown_end_patrol");
}

ghost_town_open_the_gate() {
  var_0 = common_scripts\utility::get_target_ent("ghosttown_doorkick");
  var_1 = "NML_gate_open";
  var_2 = common_scripts\utility::get_target_ent("nml_gate_r_model");
  var_3 = common_scripts\utility::get_target_ent("nml_gate_r");
  var_4 = maps\_utility::spawn_anim_model("gate");
  var_0 maps\_anim::anim_first_frame_solo(var_4, var_1);
  wait 1;
  var_0 = common_scripts\utility::get_target_ent("ghosttown_keegan_signal");
  var_0 maps\_anim::anim_generic_reach(level.keegan, "signal_enemy_coverR");
  thread ghost_town_sneak_dialogue();
  var_0 maps\_anim::anim_generic(level.keegan, "signal_enemy_coverR");
  var_0 = common_scripts\utility::get_target_ent("ghosttown_doorkick");
  var_2 linkto(var_4);
  var_3 linkto(var_4);
  level.baker.animname = "hesh";
  var_0 maps\_anim::anim_reach_solo(level.baker, var_1);
  var_3 connectpaths();
  var_0 maps\_anim::anim_single([level.baker, var_4], var_1);
  var_3 disconnectpaths();
  var_0 = common_scripts\utility::get_target_ent("ghosttown_doorkick_after");
  level.baker setgoalnode(var_0);
  wait 1;
  maps\_utility::activate_trigger_with_targetname("ghosttown_move_sneak");
  maps\_utility::delaythread(1, ::set_team_colors);
}

ghost_town_sneak_dialogue() {
  common_scripts\utility::flag_init("merrick_done_talking");
  level endon("ghosttown_end_patrol");
  level.keegan maps\_utility::smart_dialogue("nml_kgn_enemycontactahead");
  wait 3;
  level.merrick maps\_utility::smart_dialogue("nml_mrk_hangontheyretaking");
  wait 1;
  level.merrick maps\_utility::smart_dialogue("nml_mrk_rightonschedule");
  common_scripts\utility::flag_wait("ghosttown_start_patrol");
  level.keegan maps\_utility::smart_dialogue("nml_mrk_wevegotsomestragglers");
  wait 1;
  level.merrick maps\_utility::smart_dialogue("nml_kgn_probablysomeinthe");
  wait 0.5;
  level.merrick maps\_utility::smart_dialogue("nml_mrk_mopemup");
  wait 1;
  level.keegan maps\_utility::smart_dialogue("nml_mrk_okkeegankickus");
  wait 0.5;
  common_scripts\utility::flag_set("merrick_done_talking");
  wait 0.75;
  level thread maps\_utility::notify_delay("stop_keegan_snipe", 1);
  thread keegan_snipes();
  wait 1;
  common_scripts\utility::flag_set("ghosttown_end_patrol");
}

ghost_town_end() {
  thread the_end();
  level endon("ghosttown_end");
  common_scripts\utility::flag_wait("ghosttown_pre_end");
  maps\nml_util::volume_waittill_no_axis("ghosttown_pre_end_vol", 1);
  common_scripts\utility::array_thread(level.heroes, maps\_utility::set_baseaccuracy, 20);
  common_scripts\utility::array_thread(level.heroes, maps\_utility::disable_ai_color);
  common_scripts\utility::array_thread(level.heroes, maps\_utility::disable_cqbwalk);
  level.dog maps\_utility::disable_ai_color();
  maps\nml_util::hero_paths("ghosttown_pre_end_pos");
  wait 1;
  level.merrick thread maps\_utility::smart_dialogue("nml_mrk_moveuptopof");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0)
  var_2.ignoreme = 0;
}

ghost_town_end_dialogue() {
  thread maps\_utility::music_crossfade("mus_nml_end_reveal", 3.0);
  level.merrick maps\_utility::smart_dialogue("nml_mrk_youboysstillup");
  wait 1;
  level.merrick maps\_utility::smart_dialogue("nml_mrk_hehtherearemore");
}

the_end() {
  common_scripts\utility::flag_wait("ghosttown_end");
  level.merrick.ignoresuppression = 1;
  level.keegan.ignoresuppression = 1;
  maps\nml_util::hero_paths("ghosttown_end_pos");
  thread ghost_town_end_dialogue();
  common_scripts\utility::flag_wait("the_end");
  thread stadium_pa();
  level.player allowfire(0);
  level.player disableoffhandweapons(1);
  level.player enableinvulnerability();
  level.player common_scripts\utility::delaycall(2.0, ::setclienttriggeraudiozone, "nml_fade_out", 6.5);
  wait 4;
  maps\_hud_util::fade_out(4);
  wait 1;
  maps\_utility::nextmission();
}

stadium_pa() {
  common_scripts\utility::play_sound_in_space("nml_pa_pmc3_allnoncombatpersonnel", (20124, 29924, -389));
  wait 0.25;
  common_scripts\utility::play_sound_in_space("nml_pa_saf1_perimeteroutpostswill", (17654, 31217, -389));
}

ghost_town_sneak_end() {
  common_scripts\utility::flag_wait("ghosttown_end_patrol");

  if(!common_scripts\utility::flag("merrick_done_talking"))
    maps\_utility::smart_radio_dialogue_interrupt("nml_mrk_weaponsfree");
  else {
    var_0 = getaiarray("axis");

    if(var_0.size > 0) {
      var_1 = var_0[0];
      var_1 thread maps\_utility::play_sound_on_entity("SP_0_stealth_alert");
      wait 0.6;
      thread maps\_utility::smart_radio_dialogue_interrupt("nml_mrk_weaponsfree");
    }
  }

  maps\_utility::music_play("mus_nml_battle_end");
  maps\_utility::autosave_by_name("nml");
  maps\_utility::battlechatter_on("axis");
  level.player maps\_utility::player_speed_percent(100, 1);
  level.default_goalheight = 64;
  level.dog.script_color_delay_override = 1.5;
  level.baker.script_color_delay_override = undefined;
  level.keegan.script_color_delay_override = undefined;
  level.merrick.script_color_delay_override = undefined;
  level.keegan maps\_utility::disable_pain();
  level.merrick maps\_utility::disable_pain();
  level.keegan maps\_utility::disable_bulletwhizbyreaction();
  level.merrick maps\_utility::disable_bulletwhizbyreaction();
  level.merrick.ignoresuppression = 1;
  level.keegan.ignoresuppression = 1;
  common_scripts\utility::array_call(level.heroes, ::allowedstances, "stand", "crouch", "prone");
  level.dog maps\_utility_dogs::disable_dog_sneak();
  level.dog setdogattackradius(256);
  level.player.ignoreme = 0;
  common_scripts\utility::array_thread(level.heroes, maps\_utility::set_ignoreme, 0);
  common_scripts\utility::array_thread(level.heroes, maps\_utility::set_ignoreall, 0);
  level.dog.ignoreme = 0;
  level.dog.ignoreall = 0;
  common_scripts\utility::array_thread(level.heroes, maps\_utility::enable_cqbwalk);
  common_scripts\utility::array_thread(level.heroes, ::set_fixednodesaferadius, 192);
  thread keegan_sniper_logic();
  maps\_utility::activate_trigger_with_targetname("ghosttown_first_pos");
  maps\_utility::array_spawn_targetname("ghosttown_w1");
  maps\_utility::set_team_bcvoice("allies", "seal");
  level.dog maps\_utility_dogs::disable_dog_sneak();
  wait 1;
  wait 0.5;
  maps\_utility::battlechatter_on("allies");
}

set_fixednodesaferadius(var_0) {
  self.fixednodesaferadius = var_0;
}

wolfpack_cairo() {
  level.dog set_ignore_states();
  level.dog notify("path_end");
  var_0 = common_scripts\utility::get_target_ent("cairo_wolfevent_01node");
  level.dog setgoalnode(var_0);
  level.dog.goalradius = 32;
  level.dog maps\nml_util::set_move_rate(1);
  var_0 = common_scripts\utility::get_target_ent("cairo_dragback_node");
  var_0 maps\_anim::anim_reach_solo(level.dog, "dog_drag");
  var_0 thread maps\_anim::anim_loop_solo(level.dog, "dog_drag_idle");
  level notify("dog_reached_goal");
}

wolfpack_hesh() {
  level endon("wolfpack_circle");
  thread wolfpack_drag();
  thread wolfpack_dialogue();
  common_scripts\utility::flag_wait("wolf_hesh_slide_done");
  level.baker notify("path_end");
  var_0 = common_scripts\utility::get_target_ent("hesh_wolfevent_01node");
  var_0 maps\_anim::anim_generic_reach(level.baker, "stand_exposed_wave_halt");
  var_0 thread maps\_anim::anim_generic_first_frame(level.baker, "stand_exposed_wave_halt");
  common_scripts\utility::flag_wait("wolf_dog_advance");
  var_0 notify("stop_loop");
  level.baker thread maps\_anim::anim_single_solo(level.baker, "stand_exposed_wave_halt");
  level.baker.goalradius = 64;
  level.baker.fixednode = 1;
  level.baker maps\_utility::disable_cqbwalk();
  level.baker allowedstances("crouch");
  level.baker maps\_utility::set_goal_node_targetname("hesh_wolfevent_02node");
}

wolf_baker_fire_thread() {
  if(common_scripts\utility::flag("begin_wolf_attack")) {
    return;
  }
  level endon("begin_wolf_attack");
  level.baker endon("done_dragging");
  common_scripts\utility::flag_wait("wolfpack_pack");

  for(;;) {
    var_0 = randomintrange(3, 9);

    for(var_1 = 0; var_1 < var_0; var_1++) {
      level.baker shoot();
      wait(randomfloatrange(0.1, 0.25));
    }

    wait(randomfloatrange(0.25, 0.75));
  }
}

wolfpack_drag() {
  level endon("begin_wolf_attack");
  common_scripts\utility::flag_wait("wolfpack_circle");
  wait 3;
  level.baker maps\_utility::smart_dialogue("nml_hsh_ohshit");
  thread wolfpack_circle_dialogue();
  level.baker.animname = "hesh";
  var_0 = common_scripts\utility::get_target_ent("cairo_dragback_node");
  level.baker maps\_utility::enable_cqbwalk();
  var_0 maps\_anim::anim_reach_solo(level.baker, "dog_drag");
  var_0 notify("stop_loop");
  level.baker maps\_utility::disable_cqbwalk();
  thread wolf_baker_fire_thread();
  level.dog thread maps\_utility::play_sound_on_entity("scn_nml_wolf_riley_pullback");
  var_0 maps\_anim::anim_single([level.baker, level.dog], "dog_drag_start");
  var_0.origin = level.dog.origin;
  var_0.angles = level.dog.angles;
  var_0 maps\_anim::anim_single([level.baker, level.dog], "dog_drag_loop");
  var_0.origin = level.dog.origin;
  var_0.angles = level.dog.angles;
  var_0 maps\_anim::anim_single([level.baker, level.dog], "dog_drag_loop");
  var_0.origin = level.dog.origin;
  var_0.angles = level.dog.angles;
  var_0 maps\_anim::anim_single([level.baker, level.dog], "dog_drag_end");
  level.baker notify("done_dragging");
  level.baker maps\_utility::set_ignoreall(0);
  level.baker.baseaccuracy = 0.3;
  level.baker setgoalpos(level.baker.origin);
  var_0.origin = level.dog.origin;
  var_0.angles = level.dog.angles;
  var_0 thread maps\_anim::anim_loop_solo(level.dog, "dog_drag_idle");
}

wolfpack_circle_dialogue() {
  level endon("begin_wolf_attack");
  wait 2;
  level.baker maps\_utility::smart_dialogue("nml_hsh_okadambackit");
}

wolfpack_dialogue() {
  level endon("begin_wolf_attack");
  common_scripts\utility::flag_wait("wolf_dog_advance");
  maps\_utility::autosave_by_name("nml");
  level.dog thread maps\_utility_dogs::dog_bark("anml_dog_attack_npc_jump");
  wait 0.5;
  level.baker maps\_utility::smart_dialogue("nml_hsh_woahwoahslowdown");
  wait 1;
  level.baker maps\_utility::smart_dialogue("nml_hsh_somethingisntright");
  maps\_utility::music_play("mus_nml_wolf_appear");
  wait 3;
  level.baker maps\_utility::smart_dialogue("nml_hsh_whatswrongboy");
  wait 1;
  level notify("wolf_advance");
  level.player thread maps\_utility::play_sound_on_entity("elm_anml_wolf_howl");
  thread wolf_howls();
  common_scripts\utility::flag_set("wolfpack_circle");
}

wolf_howls() {
  var_0 = maps\_utility::getstructarray_delete("wolf_sound_source_a", "targetname");
  common_scripts\utility::array_thread(var_0, ::wolf_howl_struct, "begin_wolf_attack");
}

wolf_howl_struct(var_0) {
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = self.origin;
  var_1 playSound(self.script_soundalias);
  common_scripts\utility::flag_wait(var_0);
  var_1 stopsounds();
  var_1 delete();
}

wolf_setup() {
  self setdogcommand("attack");
  self.ignoreme = 1;
  self.ignoreall = 1;
  wolf_face();
  self.custom_deathsound = "scn_wolf_nml_hurt";
  thread maps\_utility::deletable_magic_bullet_shield();
  maps\_utility::disable_pain();
  self setCanDamage(0);
  self.script_nobark = 1;
  self.script_nostairs = 1;
  maps\_utility::set_generic_run_anim("wolf_walk");
  maps\_utility::set_generic_idle_anim("dog_alert");

  if(isDefined(self.script_moveplaybackrate))
    self.moveplaybackrate = self.script_moveplaybackrate;

  wait(randomfloatrange(0, 1));
  maps\_utility::disable_arrivals();
  self.goalradius = 32;
  maps\_utility::walkdist_zero();
  var_0 = common_scripts\utility::get_target_ent();
  self setgoalpos(var_0.origin);
  thread wolf_growl();
}

wolf_growl() {
  self endon("death");
  level endon("stop_growling");
}

#using_animtree("dog");

wolf_face() {
  if(getdvarint("black_wolf", 0))
    self setModel("fullbody_wolf_b");

  self setanimknobrestart( % nml_wolf_aggressive_face, 1, 0, 1);
}

wolf_face_clear() {
  self clearanim( % nml_wolf_aggressive_face, 0.5);
}

wolf_init() {
  self.custom_deathsound = "scn_wolf_nml_hurt";
  self.goalradius = 64;
  self setdogcommand("attack");
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.script_nobark = 1;
  wolf_face();
  var_0 = self;
  self hide();
  self setCanDamage(0);
  thread wolf_player_hunt();

  if(!common_scripts\utility::flag("wolfpack_pack")) {
    level endon("wolfpack_pack");
    thread wolf_start_pos();
    self waittill("damage");
    common_scripts\utility::flag_set("wolf_died");
    self kill();
    common_scripts\utility::flag_set("wolfpack_pack");
  }
}

wolf_start_pos() {
  self endon("alpha_wolf");
  self endon("death");
  maps\_utility::disable_arrivals();
  maps\_utility::disable_exits();
  maps\_utility::set_generic_run_anim("wolf_walk");

  if(isDefined(self.script_moveplaybackrate))
    maps\nml_util::set_move_rate(self.script_moveplaybackrate);

  level waittill("wolf_advance");
  wait(randomfloatrange(2.5, 4));
  self.goalradius = 128;
  var_0 = common_scripts\utility::get_target_ent(self.target);
  thread maps\_utility::follow_path_and_animate(var_0, 0);
}

wolf_player_hunt() {
  self endon("death");
  var_0 = self;
  thread wolf_growl();
  common_scripts\utility::flag_wait("wolf_dog_advance");
  self show();
  self setCanDamage(1);
  common_scripts\utility::flag_wait("wolfpack_pack");
  wait(randomfloatrange(0.5, 2));
  maps\_utility::clear_generic_run_anim();
  maps\_utility::enable_arrivals();
  maps\_utility::enable_exits();
  maps\nml_util::set_move_rate(1);
  level notify("stop_growling");
  var_0 notify("stop_path");
  var_0 thread maps\_utility::play_sound_on_entity("anml_dog_attack_npc_jump");
  var_0 maps\_utility::set_ignoreme(0);
  var_0 maps\_utility::set_ignoreall(0);
  var_0 maps\nml_util::set_move_rate(1);
  var_0 maps\_utility::set_favoriteenemy(level.player);
  var_0.goalradius = 64;
  var_0 setgoalentity(level.player, 100);
  wait 0.3;
}

wolfpack_circle() {
  level endon("pack_fight");
  level.w_alpha = maps\_utility::spawn_targetname("wolf_alpha");
  level.w_alpha thread wolf_init();
  common_scripts\utility::flag_wait("wolf_dog_advance");
  wait 3;
  var_0 = common_scripts\utility::get_target_ent(level.w_alpha.target);
  maps\_utility::disable_arrivals();
  maps\_utility::disable_exits();
  maps\_utility::set_generic_run_anim("wolf_walk");
  maps\nml_util::set_move_rate(0.8);
  level.w_alpha.goalradius = 64;
  level.w_alpha notify("alpha_wolf");
  level.w_alpha thread maps\_utility::follow_path_and_animate(var_0, 0);
  wait 0.5;
  level.w_alpha waittill("path_end_reached");
  common_scripts\utility::flag_wait("wolfpack_circle");
  wait 8;
  common_scripts\utility::flag_set("wolfpack_pack");
}

wolfpack_pack() {
  var_0 = getEntArray("wolf_2", "targetname");

  foreach(var_2 in var_0)
  var_2.script_wait = 0.1;

  thread maps\_spawner::flood_spawner_scripted(var_0);
  common_scripts\utility::flag_wait("wolfpack_pack");
  level notify("pack_fight");
  level.baker stopsounds();
  level.baker thread maps\_utility::smart_dialogue("nml_hsh_shit_2");
  level.baker.ignoreall = 0;
  level.baker.baseaccuracy = 3;
  thread maps\_utility::music_crossfade("mus_nml_wolf_rush", 2.0);
  thread wolfpack_watcher();

  if(isDefined(level.w_alpha) && isalive(level.w_alpha)) {
    level.w_alpha maps\_utility::set_ignoreall(0);
    level.w_alpha maps\_utility::set_ignoreme(0);
    level.w_alpha maps\_utility::set_favoriteenemy(level.player);
  }

  if(!common_scripts\utility::flag("begin_wolf_attack")) {
    level endon("begin_wolf_attack");
    common_scripts\utility::flag_wait_or_timeout("wolf_died", 3);
    wait 2;
    thread wolf_backup();
  }
}

wolf_backup() {
  level endon("begin_wolf_attack");
  var_0 = getEntArray("wolf_backup", "targetname");

  for(;;) {
    var_0 = sortbydistance(var_0, level.player.origin);

    foreach(var_2 in var_0) {
      if(!maps\_utility::player_looking_at(var_2.origin, 0.6, 1)) {
        var_3 = var_2 maps\_utility::spawn_ai(1);
        var_3 waittill("death");
        break;
      }

      wait 0.1;
    }
  }
}

wolfpack_watcher() {
  level endon("begin_wolf_attack");
  var_0 = 120;

  for(;;) {
    var_1 = getaispeciesarray("axis");
    var_1 = sortbydistance(var_1, level.player.origin);

    foreach(var_3 in var_1) {
      if(distance2d(var_3.origin, level.player.origin) < var_0) {
        level.main_wolf = var_3;
        break;
      } else
        break;
    }

    if(isDefined(level.main_wolf)) {
      break;
    }

    wait 0.05;
  }

  common_scripts\utility::flag_set("begin_wolf_attack");
}

wolf_event() {
  common_scripts\utility::flag_wait("begin_wolf_attack");
  common_scripts\utility::flag_clear("start_earthquakes");
  level.player endon("death");
  setdvar("hideHudFast", 1);
  setsaveddvar("ammoCounterHide", 1);
  setsaveddvar("compass", 0);
  setsaveddvar("hud_showstance", 0);
  level.baker maps\_utility::set_ignoreall(1);
  level.baker stopsounds();
  thread maps\_utility::smart_radio_dialogue("nml_hsh_adam");
  maps\_utility::delaythread(0.5, maps\_utility::music_crossfade, "mus_nml_wolf_takedown", 0.8);
  var_0 = common_scripts\utility::get_target_ent("wolf_melee");
  maps\_utility::disable_trigger_with_targetname("wolf_slide_trig");
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = level.main_wolf.origin;
  var_1.angles = level.main_wolf.angles;
  level.main_wolf.animname = "wolf";
  level.main_wolf wolf_face_clear();
  level.main_wolf show();
  var_2 = maps\_player_rig::get_player_rig();
  var_2 show();
  level.player disableweapons();
  level.player notify("cancel_sliding");
  level.player notify("stop_sliding");
  level.player allowstand(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player setstance("stand");
  level.dog notify("stop_loop");
  level.main_wolf thread maps\_utility::play_sound_on_entity("anml_dog_attack_npc_jump");
  var_1 thread maps\_anim::anim_single([var_2, level.main_wolf], "wolf_takedown");
  level.player playerlinktoblend(var_2, "tag_player", 0.1);
  level.player playrumbleonentity("grenade_rumble");
  wait 0.35;
  var_3 = getEntArray("grenade", "classname");
  common_scripts\utility::array_call(var_3, ::delete);
  level.player stopsounds();
  level.player notify("stop soundfoot_slide_plr_loop");

  if(isDefined(level.player.slidemodel))
    level.player.slidemodel delete();

  maps\_spawner::killspawner(100);
  var_4 = getaispeciesarray("axis");

  foreach(var_6 in var_4) {
    if(isDefined(var_6) && isalive(var_6) && var_6 != level.main_wolf)
      var_6 thread maps\_utility_dogs::kill_dog_fur_effect_and_delete();
  }

  var_0 thread maps\_anim::anim_first_frame_solo(level.dog, "wolf_struggle_end");
  level endon("wolf_eat_player");
  level.player common_scripts\utility::delaycall(1.3, ::playrumbleonentity, "grenade_rumble");
  level.player common_scripts\utility::delaycall(2.1, ::playrumbleonentity, "grenade_rumble");

  if(!level.player isthrowinggrenade())
    thread maps\_utility::autosave_now_silent();

  thread mash_to_survive();
  setsaveddvar("r_znear", 0.001);

  if(maps\_utility::is_gen4()) {
    level.old_mb = getdvarint("r_mbEnable", 0);
    setsaveddvar("r_mbEnable", 0);
  }

  maps\_art::dof_enable_script(0, 0, 10, 6, 9.5, 10, 1);
  level.player thread maps\_utility::play_sound_on_entity("scn_nml_wolf_in_face");
  level.player playrumbleonentity("grenade_rumble");
  level.player maps\_utility::delaythread(0.3, maps\_gameskill::grenade_dirt_on_screen, "right");
  var_0 maps\_anim::anim_single([var_2, level.main_wolf], "wolf_struggle_start");
  thread wolf_event_vfx();
  var_0 maps\_anim::anim_single([var_2, level.main_wolf], "wolf_struggle_cycle");
  var_0 maps\_anim::anim_single([var_2, level.main_wolf], "wolf_struggle_cycle");
  thread maps\_utility::autosave_now_silent();
  thread wolf_scene_end_dof();
  thread wolf_scene_end();
  setsaveddvar("r_znear", 4);
  thread maps\nml_util::mission_fail_on_dog_death();
  thread wolf_dog_save(var_2, var_0, var_1);
  level.main_wolf endon("death");
  level.player common_scripts\utility::delaycall(0.8, ::playrumbleonentity, "grenade_rumble");
  level.player common_scripts\utility::delaycall(4.3, ::playrumbleonentity, "damage_heavy");
  level.player common_scripts\utility::delaycall(4.6, ::playrumbleonentity, "damage_heavy");
  maps\_utility::delaythread(0.6, maps\_utility::music_crossfade, "mus_nml_wolf_riley_save", 0.1);
  var_8 = maps\_utility::spawn_anim_model("pistol");
  var_8 common_scripts\utility::delaycall(5, ::delete);
  level.dog thread maps\_utility::play_sound_on_entity("scn_nml_wolf_riley_attacked_by_wolf");
  level.player maps\_utility::delaythread(4.4, maps\_utility::play_sound_on_entity, "scn_nml_wolf_plr_grab_gun");
  var_0 thread maps\_anim::anim_single([var_2, level.main_wolf, level.dog, var_8], "wolf_struggle_end");
  level.dog waittillmatch("single anim", "dog_death_start");
  level.player common_scripts\utility::delaycall(0, ::playrumbleonentity, "damage_heavy");
  wait 0.25;
  level.main_wolf setCanDamage(0);
  playFXOnTag(common_scripts\utility::getfx("vfx_dog_attack_throatrip"), level.main_wolf, "TAG_MOUTH_FX");
  level.dog thread maps\_utility::play_sound_on_entity("anml_dog_shot_death");
  wait 0.1;
  level.dog.allowdeath = 1;
  level.dog.a.nodeath = 1;
  level.dog kill();
}

wolf_scene_end_dof() {
  thread maps\_art::dof_enable_script(0, 63, 8, 130, 320, 6, 0.5);
  wait 2.75;
  thread maps\_art::dof_enable_script(0, 12.5, 10, 33, 78, 10, 0.1);
  wait 0.5;
  thread maps\_art::dof_enable_script(0, 63, 8, 130, 320, 6, 0.25);
}

wolf_event_vfx() {
  level endon("wolf_scene_end");
  level.player.screenblood_org = spawn("script_model", (0, 0, 0));
  level.player.screenblood_org setModel("tag_origin");
  level.player.screenblood_org.origin = level.player.origin;
  level.player.screenblood_org linktoplayerview(level.player, "tag_origin", (25, 0, 0), (0, 180, 0), 1);
  var_0 = ["right", "left"];

  for(;;) {
    playFXOnTag(common_scripts\utility::getfx("vfx_wolf_droolfoam"), level.main_wolf, "TAG_MOUTH_FX");
    playFXOnTag(common_scripts\utility::getfx("vfx_wolf_screendrool"), level.player.screenblood_org, "tag_origin");
    wait(randomfloatrange(0.5, 1.5));
    var_1 = common_scripts\utility::random(var_0);
    level.player maps\_utility::delaythread(0.3, maps\_gameskill::grenade_dirt_on_screen, var_1);
    wait(randomfloatrange(0.5, 1.5));
  }
}

wolf_dog_save(var_0, var_1, var_2) {
  level.dog endon("death");
  level thread maps\_slowmo_breach::breach_enemy_track_status(level.main_wolf);
  thread player_gets_pistol(var_0);
  level.main_wolf setCanDamage(1);
  level.main_wolf.health = 1;
  level.main_wolf waittill("death");
  thread maps\_art::dof_disable_script(3);
  maps\_utility::music_stop(0.25);
  level.player lerpviewangleclamp(2, 0, 0, 25, 5, 15, 15);

  if(level.player getweaponammoclip("p226_scripted_nml") > 0)
    level.player setweaponammoclip("p226_scripted_nml", 2);

  var_2 delete();
  level.dog setgoalpos(level.dog.origin);
  thread merrick_scene(var_1);
  level.dog maps\_utility::delaythread(0.2, maps\_utility::play_sound_on_entity, "scn_nml_wolf_riley_saved");
  level.dog maps\_utility::delaythread(0.5, maps\_utility::play_sound_on_entity, "scn_dog_nml_hurt_long");
  var_1 maps\_anim::anim_single([var_0, level.dog], "wolf_end");
  level.dog thread maps\_utility::magic_bullet_shield();
  level.dog.a.nodeath = undefined;
}

player_gets_pistol(var_0) {
  setsaveddvar("cg_drawCrosshair", 0);
  setsaveddvar("ammocounterhide", 1);
  level.main_wolf.health = 1;
  level.main_wolf.allowdeath = 1;
  level.main_wolf maps\_utility::set_deathanim("wolf_death");
  var_0 waittillmatch("single anim", "pistol_bringup");
  level.player allowads(0);
  level.player.prevweapon = level.player getcurrentweapon();
  level.player.prevweapons = level.player getweaponslist("primary");

  foreach(var_2 in level.player.prevweapons)
  level.player takeweapon(var_2);

  level.player disableoffhandweapons();
  level.player giveweapon("p226_scripted_nml");
  level.player switchtoweaponimmediate("p226_scripted_nml");
  level.player setweaponammostock("p226_scripted_nml", 0);
  level.player setweaponammoclip("p226_scripted_nml", 5);
  level.player disableweaponswitch();
  level.player enableweapons();
  level.player playerlinktodelta(var_0, "tag_player", 1, 30, 30, 15, 15, 1);
  level.player lerpfov(55, 0.5);
  maps\_slowmo_breach::slowmo_begins();
  level.player allowmelee(0);
}

merrick_scene(var_0) {
  level.dog endon("death");
  var_1 = maps\_utility::array_spawn_targetname("last_wolves");
  var_2 = maps\_utility::spawn_targetname("last_wolves_main");
  var_2 thread maps\_utility::play_sound_on_entity("scn_nml_wolf_second_approach");
  var_2.animname = "wolf";
  var_3 = common_scripts\utility::get_target_ent("blocker_wolf_protector");
  var_3 linkto(var_2);
  var_0 waittill("wolf_end");
  maps\_utility::delaythread(0.8, maps\_utility::music_crossfade, "mus_nml_wolf_merrick", 3.0);
  var_2 wolf_face_clear();
  wait 4;
  maps\nml_util::spawn_keegan();
  maps\nml_util::spawn_merrick();
  level notify("stop_growling");
  var_2 thread maps\_utility::play_sound_on_entity("anml_dog_attack_npc_jump");
  var_0 = common_scripts\utility::get_target_ent("wolf_melee");
  var_2 maps\_utility::clear_generic_run_anim();
  var_2 maps\_utility::enable_sprint();
  var_2.moveplaybackrate = 1.3;
  var_2 thread maps\_utility::play_sound_on_entity("scn_nml_wolf_2nd_attack");
  var_0 maps\_anim::anim_reach_solo(var_2, "merrick_entrance");
  var_4 = level.merrick.primaryweapon;
  level.merrick maps\_utility::forceuseweapon("p226_scripted_nml", "sidearm");
  var_5 = maps\_player_rig::get_player_rig();
  common_scripts\utility::array_thread(var_1, ::wolf_runaway);
  var_3 delete();
  var_6 = common_scripts\utility::get_target_ent("wolf_sound_source_b");
  maps\_utility::delaythread(1, common_scripts\utility::play_sound_in_space, var_6.script_soundalias, var_6.origin);
  thread wolf_thrown(var_0, var_2);
  thread wolf_slowmo();
  level.player common_scripts\utility::delaycall(0.4, ::playrumbleonentity, "grenade_rumble");
  level.player maps\_utility::delaythread(0.4, maps\_utility::play_sound_on_entity, "scn_nml_wolf_merrick_save");
  var_0 maps\_anim::anim_single_solo_run(level.merrick, "merrick_entrance");
  var_7 = maps\_utility::spawn_anim_model("player_rig");
  var_7 hide();
  var_0 = common_scripts\utility::get_target_ent("wolf_merrick");
  level.baker.animname = "hesh";
  level.keegan.animname = "keegan";
  level.merrick.animname = "merrick";
  var_8 = 0;
  var_9 = 0.5;
  level.merrick maps\_utility::forceuseweapon(var_4, "primary");
  level.merrick maps\_utility::disable_arrivals();
  level.merrick maps\_utility::disable_exits();
  level.merrick maps\_utility::set_generic_run_anim("active_patrolwalk_gundown");
  level.player maps\_utility::delaythread(1.0, maps\_utility::play_sound_on_entity, "scn_nml_wolf_plr_grab_merrick");
  level.merrick maps\_utility::delaythread(0.0, maps\_utility::play_sound_on_entity, "scn_nml_wolf_ending_merrick");
  level.keegan maps\_utility::delaythread(4.0, maps\_utility::play_sound_on_entity, "scn_nml_wolf_ending_keegan");
  level.baker maps\_utility::delaythread(2.6, maps\_utility::play_sound_on_entity, "scn_nml_wolf_ending_hesh");
  var_0 maps\_anim::anim_reach_solo(level.merrick, "merrick_scene");
  level.merrick maps\_utility::clear_generic_run_anim();
  thread merrick_scene_dialogue(var_7);
  level.player common_scripts\utility::delaycall(var_8, ::playerlinktoblend, var_7, "tag_player", var_9);
  level.player common_scripts\utility::delaycall(0.6, ::playrumbleonentity, "damage_heavy");
  level.player common_scripts\utility::delaycall(0.9, ::playrumbleonentity, "grenade_rumble");
  var_7 common_scripts\utility::delaycall(var_8 + var_9, ::show);
  thread take_pistol(var_8);
  var_10 = maps\_utility::spawn_anim_model("dsm");
  level.baker.dsm = var_10;
  var_10 hide();
  var_0 thread maps\_anim::anim_single([var_7], "merrick_scene");
  enable_team_color();
  set_team_colors();
  level.dog maps\_utility::disable_ai_color();
  maps\_utility::activate_trigger_with_targetname("wolfpack_end_move");
  var_11 = [level.baker, level.merrick, level.keegan];
  common_scripts\utility::array_thread(var_11, maps\_utility::disable_exits);
  common_scripts\utility::array_thread(var_11, maps\_utility::walkdist_zero);
  common_scripts\utility::array_call(var_11, ::orientmode, "face motion");
  var_0 thread maps\_anim::anim_single_solo_run(var_10, "merrick_scene");
  var_0 thread maps\_anim::anim_single_solo_run(level.keegan, "merrick_scene");
  var_0 thread maps\_anim::anim_single_solo_run(level.merrick, "merrick_scene");
  var_0 maps\_anim::anim_single_solo_run(level.baker, "merrick_scene");
  common_scripts\utility::flag_set("merrick_scene_done");
  enable_team_color();
  set_team_colors();
  level.player maps\_utility::player_speed_percent(80);
  set_default_team_move_speed();
  level.dog.script_color_delay_override = 3;
  level.baker.script_color_delay_override = 2;
  level.keegan.script_color_delay_override = 1;
  level.merrick.script_color_delay_override = 0;
  level.merrick maps\_utility::enable_arrivals();
  maps\_utility::delaythread(1, common_scripts\utility::array_thread, var_11, maps\_utility::enable_exits);
  maps\_utility::delaythread(1, common_scripts\utility::array_thread, var_11, maps\_utility::walkdist_reset);

  if(maps\_utility::is_gen4()) {
    if(!isDefined(level.old_mb))
      level.old_mb = 0;

    setsaveddvar("r_mbEnable", level.old_mb);
  }
}

wolf_slowmo() {
  common_scripts\utility::waitframe();
  level.player thread maps\_utility::play_sound_on_entity("slomo_whoosh_in");
  level.player thread maps\_slowmo_breach::player_heartbeat();
  level.player common_scripts\utility::delaycall(0.1, ::lerpfov, 35, 0.35);
  maps\_utility::slowmo_setspeed_slow(0.2);
  maps\_utility::slowmo_setlerptime_in(0.25);
  maps\_utility::slowmo_lerp_in();
  wait 0.5;
  level notify("stop_player_heartbeat");
  level.player thread maps\_utility::play_sound_on_entity("slomo_whoosh_out");
  maps\_utility::slowmo_setlerptime_out(0.5);
  maps\_utility::slowmo_lerp_out();
  var_0 = maps\_player_rig::get_player_rig();
  level.player playerlinktodelta(var_0, "tag_player", 1, 20, 20, 30, 5);
  wait 2.5;
  level.player lerpfov(65, 12);
  wait 2;
  level.merrick setlookatentity(level.player);
  wait 4;
  level.merrick setlookatentity();
}

wolf_thrown(var_0, var_1) {
  var_1 maps\_utility::delaythread(0.5, maps\_utility::play_sound_on_entity, "anml_dog_run_hurt");
  var_2 = maps\_player_rig::get_player_rig();
  level.player allowfire(0);
  level.player common_scripts\utility::delaycall(0.3, ::disableweapons);
  level.player common_scripts\utility::delaycall(0.1, ::playerlinktoblend, var_2, "tag_player", 0.1, 0, 0.1);
  var_0 thread maps\_anim::anim_single_solo(level.player_rig, "merrick_entrance");
  var_0 maps\_anim::anim_single_solo(var_1, "merrick_entrance");
  var_1 maps\_utility::stop_magic_bullet_shield();
  var_1 thread maps\_utility::play_sound_on_entity("anml_dog_die_front");
  var_1.a.nodeath = 1;
  var_1.allowdeath = 1;
  var_1 kill();
}

take_pistol(var_0) {
  wait(var_0);
  level.player allowmelee(1);
  level.player enableoffhandweapons();
  level.player allowfire(1);
  level.player allowads(1);
  level.player disableweapons();
  level.player takeweapon("p226_scripted_nml");

  foreach(var_2 in level.player.prevweapons) {
    level.player giveweapon(var_2);

    if(issubstr(var_2, "p226")) {
      level.player setweaponammostock(var_2, 0);
      level.player setweaponammoclip(var_2, 0);
    }
  }

  level.player switchtoweaponimmediate(level.player.prevweapon);
  level.player enableweaponswitch();
}

wolf_runaway() {
  wait(randomfloatrange(0, 2));
  var_0 = common_scripts\utility::getstruct(self.script_noteworthy, "script_noteworthy");
  self.goalradius = 32;
  maps\_utility::clear_generic_run_anim();
  self.moveplaybackrate = 1;
  self setgoalpos(var_0.origin);
  self waittill("goal");
  maps\_utility_dogs::kill_dog_fur_effect_and_delete();
}

merrick_scene_dialogue(var_0) {
  level.dog setgoalpos(level.dog.origin);
  level.baker allowedstances("stand", "crouch", "prone");
  level.merrick.goalradius = 32;
  level.keegan.goalradius = 32;
  level.baker.a.pose = "stand";
  level.keegan.a.pose = "stand";
  maps\_utility::delaythread(3, ::merrick_scene_player_unlink, var_0);
  thread merrick_scene_dialogue2();
}

merrick_scene_player_unlink(var_0) {
  common_scripts\utility::flag_set("start_earthquakes");
  level.player maps\_utility::player_speed_percent(30);
  level.player unlink();
  level.player allowcrouch(1);
  level.player allowprone(1);
  var_0 delete();

  if(isDefined(level.player_rig))
    level.player_rig delete();
}

merrick_scene_dialogue2() {
  wait 22;
  level.player maps\_utility::player_speed_percent(100, 3);
  level.player enableweapons();
  setdvar("hideHudFast", 0);
  setsaveddvar("cg_drawCrosshair", 1);
  setsaveddvar("ammocounterhide", 0);
  setsaveddvar("compass", 1);
  setsaveddvar("hud_showstance", 1);
}

set_bark_cairo() {
  level endon("wolfpack_pack");
  level endon("death");

  for(;;)
    level.dog maps\_utility::play_sound_on_entity("anml_dog_growl");
}

clear_bark_cairo() {}

bark_trigger(var_0) {
  self waittill("trigger");
  var_1 = common_scripts\utility::getstruct(self.target, "targetname");
  thread common_scripts\utility::play_sound_in_space("anml_dog_bark", var_1.origin);

  if(randomint(100) > 50) {
    wait 0.5;
    thread common_scripts\utility::play_sound_in_space("anml_dog_bark", var_1.origin);
  }

  switch (var_0) {
    case 0:
      wait 1.2;
      thread maps\_utility::add_dialogue_line("Hesh", "Adam- Come on ... we've got to find Cairo");
      break;
    case 1:
      wait 1.5;
      thread maps\_utility::add_dialogue_line("Hesh", "Through here, Cairo- Komm!");
      break;
    case 2:
      wait 1.0;
      thread maps\_utility::add_dialogue_line("Hesh", "He's close.");
      break;
  }
}

faster_baker() {
  level.player endon("death");
  level endon("wolf_wolfpack_opening");

  for(;;) {
    wait 0.1;

    if(distance(level.player.origin, level.baker.origin) < 400) {
      level.baker maps\nml_util::set_move_rate(1.15);
      continue;
    }

    var_0 = vectornormalize(level.player.origin - level.baker.origin);
    var_1 = anglesToForward(level.baker.angles);
    var_2 = vectordot(var_1, var_0);

    if(var_2 > 0)
      level.baker maps\nml_util::set_move_rate(1.15);
    else
      level.baker maps\nml_util::set_move_rate(1.0);
  }
}

hesh_dialog_dog_calm() {
  level.player endon("death");
  level endon("stop_hesh_dog_calm_dialog");
  thread maps\_utility::add_dialogue_line("Hesh", "Cairo- Bleib!");
  wait 2.3;
  thread maps\_utility::add_dialogue_line("Hesh", "Foos!");
  wait 2.7;
}

tell_adam_stop() {
  level.player endon("death");
  common_scripts\utility::flag_wait("wolf_adam_stop");
  thread maps\_utility::add_dialogue_line("Hesh", "Adam STOP! Cover me...");
  level.player setmovespeedscale(0.5);
  wait 2.0;
  level.player setmovespeedscale(1);
}

ghost_patroller_setup() {
  self endon("death");
  level endon("patrol_over");
  maps\_utility::set_ignoreall(1);
  maps\_utility::set_ignoreme(1);
  self.health = 50;
  self addaieventlistener("grenade danger");
  self addaieventlistener("projectile_impact");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("gunshot");
  self addaieventlistener("gunshot_teammate");
  self addaieventlistener("explode");
  self addaieventlistener("death");
  self waittill("ai_event", var_0);
  common_scripts\utility::flag_set("ghost_ambush_started");
  level notify("patrol_over", self);
}

ghost_patroller_flee() {
  common_scripts\utility::flag_wait("ghost_ambush_started");
  wait 1;
  var_0 = maps\_utility::get_ai_group_ai("ghost_town_guys");
  var_1 = common_scripts\utility::get_target_ent("ghost_delete_1");

  foreach(var_3 in var_0) {
    if(isDefined(var_3) && isalive(var_3)) {
      var_3 maps\_utility::anim_stopanimscripted();
      var_3 notify("end_patrol");
      var_3 thread temp_ghost_flee(var_1);
    }
  }
}

temp_ghost_flee(var_0) {
  self endon("death");
  maps\_utility::enable_sprint();
  maps\_utility::set_goal_radius(64);
  self setgoalnode(var_0);
  self waittill("goal");
  wait 6;
  self delete();
}

wait_until_enemies_in_volume(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_3 = var_2 maps\_utility::get_ai_touching_volume("axis");
  var_4 = var_3.size;

  while(var_4 > var_1) {
    wait 2;
    var_3 = var_2 maps\_utility::get_ai_touching_volume("axis");
    var_4 = var_3.size;

    if(var_4 - var_1 < 3) {
      foreach(var_6 in var_3) {
        if(var_6 maps\_utility::doinglongdeath() || var_6.delayeddeath)
          var_4--;
      }
    }
  }
}

stop_looping_anims() {
  if(!isDefined(self.target)) {
    self notify("stop_loop");
    return;
  }

  var_0 = getnode(self.target, "targetname");

  if(isDefined(var_0) && isalive(var_0)) {
    var_0 notify("stop_loop");
    return;
  }
}

set_default_team_move_speed() {
  level.baker maps\nml_util::set_move_rate(1.0);
  level.dog maps\nml_util::set_move_rate(0.7);
  level.player setmovespeedscale(1.0);

  if(isDefined(level.merrick))
    level.merrick maps\nml_util::set_move_rate(1.0);

  if(isDefined(level.keegan))
    level.keegan maps\nml_util::set_move_rate(1.0);
}

set_ignore_states() {
  maps\_utility::set_ignoreall(1);
  maps\_utility::set_ignoreme(1);
}

clear_ignore_states() {
  maps\_utility::set_ignoreall(0);
  maps\_utility::set_ignoreall(0);
}

set_team_ignore_states() {
  level.baker maps\_utility::set_ignoreall(1);
  level.baker maps\_utility::set_ignoreme(1);
  level.dog maps\_utility::set_ignoreall(1);
  level.dog maps\_utility::set_ignoreme(1);

  if(isDefined(level.merrick)) {
    level.merrick maps\_utility::set_ignoreall(1);
    level.merrick maps\_utility::set_ignoreme(1);
  }

  if(isDefined(level.keegan)) {
    level.keegan maps\_utility::set_ignoreall(1);
    level.keegan maps\_utility::set_ignoreme(1);
  }
}

clear_team_ignore_states() {
  level.baker maps\_utility::set_ignoreall(0);
  level.baker maps\_utility::set_ignoreme(0);
  level.dog maps\_utility::set_ignoreall(0);
  level.dog maps\_utility::set_ignoreme(0);

  if(isDefined(level.merrick)) {
    level.merrick maps\_utility::set_ignoreall(0);
    level.merrick maps\_utility::set_ignoreme(0);
  }

  if(isDefined(level.keegan)) {
    level.keegan maps\_utility::set_ignoreall(0);
    level.keegan maps\_utility::set_ignoreme(0);
  }
}

set_team_colors() {
  level.baker maps\_utility::set_force_color("r");
  level.dog maps\_utility::set_force_color("o");

  if(isDefined(level.merrick))
    level.merrick maps\_utility::set_force_color("p");

  if(isDefined(level.keegan))
    level.keegan maps\_utility::set_force_color("b");
}

enable_team_color() {
  level.baker maps\_utility::enable_ai_color();
  level.dog maps\_utility::enable_ai_color();

  if(isDefined(level.merrick))
    level.merrick maps\_utility::enable_ai_color();

  if(isDefined(level.keegan))
    level.keegan maps\_utility::enable_ai_color();
}

disable_team_color() {
  level.baker maps\_utility::disable_ai_color();
  level.dog maps\_utility::disable_ai_color();

  if(isDefined(level.merrick))
    level.merrick maps\_utility::disable_ai_color();

  if(isDefined(level.keegan))
    level.keegan maps\_utility::disable_ai_color();
}

trigger_activate_targetname_safe(var_0) {
  var_1 = getent(var_0, "targetname");

  if(isDefined(var_1))
    var_1 notify("trigger");
}

select_and_move(var_0, var_1) {
  var_2 = common_scripts\utility::get_target_ent(var_0);
  var_3 = getaiarray("axis");
  var_4 = common_scripts\utility::get_target_ent(var_1);
  var_5 = getnodesinradius(var_2.origin, var_2.radius, 0, 512, "cover");
  var_6 = maps\_utility::remove_dead_from_array(var_3);

  foreach(var_8 in var_6) {
    if(var_8 istouching(var_4) && isDefined(var_8)) {
      var_8.goalradius = 256;
      var_8.ignoresuppression = 1;
      var_8 setgoalnode(var_5[randomintrange(0, var_5.size)]);
    }
  }
}

select_and_targetplayer(var_0) {
  var_1 = getaiarray("axis");
  var_2 = common_scripts\utility::get_target_ent(var_0);
  var_3 = maps\_utility::remove_dead_from_array(var_1);

  foreach(var_5 in var_3) {
    if(var_5 istouching(var_2) && isDefined(var_5))
      var_5.favoriteenemy = level.player;
  }
}

delete_on_path_end(var_0) {
  self endon("death");
  maps\_utility::enable_sprint();
  maps\_utility::set_goal_radius(64);
  self setgoalnode(var_0);
  self waittill("goal");
  self delete();
}

#using_animtree("vehicles");

init_hover() {
  var_0 = common_scripts\utility::get_target_ent("ghost_hover_lower");
  var_0 useanimtree(#animtree);
  wait 1;
  var_0 setanim( % hovercraft_enemy_upper_fans, 1, 0, 0.025);
}

mash_to_survive() {
  wait 0.75;
  fade_in_x_hint(2);
  thread x_hint_blinks();
  thread increase_difficulty();
  level endon("wolf_scene_end");
  level.player endon("death");
  level.fade_out_death_time = 2.5;
  level.occumulator = 0;
  level.drown_max_alpha = 65;

  for(;;) {
    fade_out_death();
    wait 0.05;
  }
}

increase_difficulty() {
  level waittill("player_hit_x");
  level.fade_out_death_time = 1;
  thread lerp_maxalpha_overtime(55, 3);
  wait 3;
  level.fade_out_death_time = 0.6;
  thread lerp_maxalpha_overtime(45, 3);
  wait 3;

  if(level.gameskill > 1)
    level.fade_out_death_time = 0.3;
}

lerp_maxalpha_overtime(var_0, var_1) {
  level notify("lerp_maxalpha_overtime");
  level endon("lerp_maxalpha_overtime");
  var_2 = level.drown_max_alpha;
  var_3 = int(var_1 / 0.05);
  var_4 = (var_0 - var_2) / var_3;

  for(;;) {
    level.drown_max_alpha = level.drown_max_alpha + var_4;
    wait 0.05;
  }

  level.drown_max_alpha = var_0;
}

mini_earthquakes() {
  level endon("player_hit_x");
  level endon("wolf_scene_end");

  for(;;) {
    earthquake(0.15, 0.2, level.player.origin, 512);
    wait 0.1;
  }
}

fade_out_death() {
  thread mini_earthquakes();
  thread wait_for_x_input();
  level endon("player_hit_x");
  level.player thread maps\_utility::lerp_saveddvar("cg_fov", 30, level.fade_out_death_time);
  var_0 = max(0, level.fade_out_death_time - 1.75);
  var_1 = level.fade_out_death_time - var_0;
  wait(var_0);
  level.occumulator = 0;
  wait(var_1);
  thread fade_out_x_hint(0.05);
  thread wolf_scene_death();
}

wait_for_x_input() {
  level.player endon("death");
  level endon("wolf_scene_end");

  while(use_pressed())
    wait 0.05;

  while(!use_pressed())
    wait 0.05;

  level notify("player_hit_x");
  var_0 = getdvarint("cg_fov", level.drown_max_alpha);
  var_0 = min(var_0 + 7, level.drown_max_alpha);
  thread fade_in_to_alpha(0.1, var_0);
  earthquake(0.35, 0.2, level.player.origin, 512);
  level.player playrumbleonentity("damage_light");
  level.occumulator = level.occumulator + 1;
}

fade_in_to_alpha(var_0, var_1) {
  if(level.missionfailed) {
    return;
  }
  level.player thread maps\_utility::lerp_saveddvar("cg_fov", var_1, var_0);
  wait(var_0);
}

fade_in_x_hint(var_0) {
  if(!isDefined(var_0))
    var_0 = 1.5;

  if(!isDefined(level.x_hint))
    draw_x_hint();

  foreach(var_2 in level.x_hint) {
    var_2 fadeovertime(var_0);
    var_2.alpha = 0.95;
  }
}

draw_x_hint() {
  var_0 = 125;
  var_1 = 0;
  var_2 = level.player maps\_hud_util::createclientfontstring("default", 2);
  var_2.x = var_1 * -1;
  var_2.y = var_0;
  var_2.horzalign = "right";
  var_2.alignx = "right";
  var_2 set_default_hud_stuff();

  if(!level.console && !level.player usinggamepad())
    var_2 settext(&"NML_HINT_X_KB");
  else
    var_2 settext(&"NML_HINT_X");

  var_3 = [];
  var_3["text"] = var_2;
  level.x_hint = var_3;
}

x_hint_blinks() {
  level notify("fade_out_x_hint");
  level endon("fade_out_x_hint");

  if(!isDefined(level.x_hint))
    draw_x_hint();

  var_0 = 0.2;
  var_1 = 0.1;

  foreach(var_3 in level.x_hint) {
    var_3 fadeovertime(0.1);
    var_3.alpha = 0.95;
  }

  wait 0.1;
  var_5 = level.x_hint["text"];
  var_6 = 2;

  for(;;) {
    var_5 fadeovertime(0.01);
    var_5.alpha = 0.95;
    var_5 changefontscaleovertime(0.01);

    if(!level.console && !level.player usinggamepad())
      var_5.fontscale = 2;
    else
      var_5.fontscale = 2 * var_6;

    wait 0.1;
    var_5 fadeovertime(var_0);
    var_5.alpha = 0.0;
    var_5 changefontscaleovertime(var_0);

    if(!level.console && !level.player usinggamepad())
      var_5.fontscale = 0.25;
    else
      var_5.fontscale = 0.25 * var_6;

    wait(var_1);
    var_7 = 4;

    while(isDefined(level.occumulator)) {
      if(level.occumulator < var_7) {
        break;
      }

      foreach(var_3 in level.x_hint)
      var_3.alpha = 0;

      var_0 = 0.1;
      var_1 = 0.1;
      wait 0.05;
    }
  }
}

fade_out_x_hint(var_0) {
  level notify("fade_out_x_hint");

  if(!isDefined(var_0))
    var_0 = 1.5;

  if(!isDefined(level.x_hint))
    draw_x_hint();

  foreach(var_2 in level.x_hint) {
    var_2 fadeovertime(var_0);
    var_2.alpha = 0;
  }
}

set_default_hud_stuff() {
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

use_pressed() {
  if(!level.console && !level.player usinggamepad())
    return level.player attackbuttonpressed();
  else
    return level.player usebuttonpressed();
}

wolf_scene_end() {
  level notify("wolf_scene_end");
  thread fade_out_x_hint(0.1);
  thread fade_in_to_alpha(0.5, 48);
  wait 3;
  level.player.screenblood_org delete();
}

wolf_scene_death() {
  level notify("wolf_scene_end");
  thread fade_out_x_hint(0.1);
  level notify("wolf_eat_player");
  var_0 = common_scripts\utility::get_target_ent("wolf_melee");
  var_1 = maps\_player_rig::get_player_rig();
  level.player lerpfov(65, 0.5);
  var_0 thread maps\_anim::anim_single([var_1, level.main_wolf], "wolf_playerdeath");
  wait 0.25;
  level.player kill();
}

end_heli_2_think() {
  self vehicle_turnengineoff();
  thread maps\_utility::play_sound_on_entity("scn_nml_heli_end_reveal");
}

keegan_sniper_logic() {
  level.keegan maps\_utility::disable_ai_color();
  level.keegan.no_pistol_switch = 1;
  level.heroes = common_scripts\utility::array_remove(level.heroes, level.keegan);
  thread keegan_snipes(1);
  common_scripts\utility::flag_wait("ghosttown_pre_end");
  level notify("stop_keegan_snipe");
  level.keegan.dontevershoot = undefined;
  level.heroes = common_scripts\utility::array_add(level.heroes, level.keegan);
  level.keegan maps\_utility::enable_ai_color();
  level.keegan.moveplaybackrate = 1.2;
  common_scripts\utility::waitframe();
  level.keegan waittill("goal");
  level.keegan.moveplaybackrate = 1;
}

keegan_snipes(var_0) {
  level notify("start_keegan_snipe");
  level endon("start_keegan_snipe");
  level endon("stop_keegan_snipe");
  var_1 = 3;

  for(;;) {
    level.keegan.dontevershoot = 1;
    var_2 = getaiarray("axis");

    foreach(var_4 in var_2) {
      if(!isDefined(var_4)) {
        continue;
      }
      if(isDefined(var_4.syncedmeleetarget)) {
        continue;
      }
      if(maps\_utility::player_looking_at(var_4 getEye(), 0.8, 1)) {
        var_5 = bullettracepassed(level.keegan gettagorigin("tag_flash"), var_4 getEye(), 0, level.keegan);

        if(var_5) {
          if(isDefined(var_0) && common_scripts\utility::cointoss())
            maps\_utility::smart_radio_dialogue("nml_kgn_exposed_acquired");

          if(!isalive(var_4)) {
            continue;
          }
          playFXOnTag(common_scripts\utility::getfx("sniper_muzzleflash"), level.keegan, "tag_flash");
          level.keegan thread maps\_utility::play_sound_on_tag("weap_l115a3_fire_npc", "tag_flash");
          var_6 = var_4.origin;

          if(distance2d(level.player.origin, level.keegan.origin) < 300)
            level.keegan maps\nml_stealth::magic_stealth_shot(var_4);
          else
            level.keegan maps\nml_stealth::magic_stealth_shot(var_4, 2);

          if(!common_scripts\utility::flag("ghosttown_end_patrol"))
            thread teammates_react(var_6);

          wait 0.5;
          maps\_utility::smart_radio_dialogue("nml_kgn_inform_killfirm_generic");
          var_1 = var_1 + 2;
          break;
        }
      }
    }

    wait(var_1);
  }
}

teammates_react(var_0) {
  var_1 = getaiarray("axis");

  foreach(var_3 in var_1) {
    var_4 = distance2d(var_3.origin, var_0);

    if(isalive(var_3) && var_4 < 400)
      var_3 maps\_utility::delaythread(randomfloat(0.3), ::guy_react, var_4 < 300);
  }
}

guy_react(var_0) {
  if(var_0)
    var_1 = ["exposed_dive_grenade_B", "exposed_dive_grenade_F"];
  else
    var_1 = ["_stealth_behavior_generic1", "_stealth_behavior_generic2"];

  var_2 = common_scripts\utility::random(var_1);
  self notify("end_patrol");
  thread maps\_anim::anim_generic_gravity(self, var_2);
  self.allowdeath = 1;
  self.allowpain = 1;
}