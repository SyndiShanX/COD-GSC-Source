/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\loki_space_breach.gsc
**************************************/

section_main() {
  maps\_utility::add_hint_string("set_charge_hint", &"LOKI_PLANT_CHARGE", ::hint_button_press);
  maps\_utility::add_hint_string("set_charge_hint_pc", &"LOKI_PLANT_CHARGE_PC", ::hint_button_press_pc);
}

hint_button_press() {
  return !common_scripts\utility::flag("set_charge_hint");
}

hint_button_press_pc() {
  return !common_scripts\utility::flag("set_charge_hint_pc");
}

section_precache() {
  precachemodel("weapon_space_breacher");
  precachemodel("weapon_space_breacher_obj");
  precachemodel("loki_proxy_control_panel_obj");
  precachemodel("space_interior_pack_square_big");
  precachemodel("space_interior_pack_round");
  precachemodel("space_interior_pack_square");
  precachemodel("cnd_laptop_001_open_off");
}

section_flag_inits() {
  common_scripts\utility::flag_init("left_pressed");
  common_scripts\utility::flag_init("right_pressed");
  common_scripts\utility::flag_init("forward_pressed");
  common_scripts\utility::flag_init("attack_pressed");
  common_scripts\utility::flag_init("jump_pressed");
  common_scripts\utility::flag_init("use_pressed");
  common_scripts\utility::flag_init("target_found");
  common_scripts\utility::flag_init("earth_move1");
  common_scripts\utility::flag_init("earth_move2");
  common_scripts\utility::flag_init("controlroom_moved");
  common_scripts\utility::flag_init("breach_done");
  common_scripts\utility::flag_init("push_left");
  common_scripts\utility::flag_init("push_down");
  common_scripts\utility::flag_init("combat_two_enemies_dead");
  common_scripts\utility::flag_init("charge_set");
  common_scripts\utility::flag_init("player_teleport_done");
  common_scripts\utility::flag_init("console_activated");
  common_scripts\utility::flag_init("player_breach_anim_done");
  common_scripts\utility::flag_init("player_breach_enemies_dead");
  common_scripts\utility::flag_init("player_teleport_start");
  common_scripts\utility::flag_init("space_breach_vo_done");
  common_scripts\utility::flag_init("breach_enemies_spawned");
  common_scripts\utility::flag_init("shoot_at_player");
}

space_breach_start() {
  maps\loki_util::player_move_to_checkpoint_start("space_breach");
  maps\loki_util::spawn_allies();
  set_num_allies(2);
  level.player giveweapon(level.primary_weapon);
  level.player switchtoweapon(level.primary_weapon);
  level.player givemaxammo(level.primary_weapon);
  level.moving_cover_guys = [];
  common_scripts\utility::flag_set("combat_two_done");
  common_scripts\utility::flag_set("combat_two_enemies_dead");
  common_scripts\utility::flag_set("combat_two_dialogue_done");
  common_scripts\utility::flag_set("moving_cover_done2");
  common_scripts\utility::flag_set("ally_0_combat_two_anims_finished");
  common_scripts\utility::flag_set("ally_1_combat_two_anims_finished");
  level thread maps\loki_combat_two::fail_if_player_too_far();
  level thread maps\loki_fx::light_combat2_threads();
  level thread maps\loki_combat_two::moving_large_debris();
}

space_breach() {
  common_scripts\utility::flag_wait("combat_two_done");
  thread maps\loki_util::loki_autosave_by_name_silent("space_breach");
  wait 0.1;
  thread allies_catch_up();
  maps\loki_fx::light_combat2_threads();
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");
  var_0 = getent("space_breach_start_trigger", "targetname");
  var_0 notify("trigger");
  thread maps\loki_util::player_boundaries_on(1, 1);
  thread spawn_enemies();
  thread create_anim_node();
  thread set_flags_on_input();
  thread test_quick_breach();
  thread space_breach_dialogue();
  thread create_rog_controls();
  thread glow_console_after_breach();
  common_scripts\utility::flag_wait("space_breach_done");
  maps\_utility::stop_exploder("combat2_flare");
}

set_num_allies(var_0) {
  for(var_1 = 0; var_1 < level.allies.size; var_1++) {
    if(var_1 >= var_0) {
      var_2 = level.allies[var_1];
      var_2 maps\_utility::stop_magic_bullet_shield();
      var_2 delete();
    }
  }

  level.allies = common_scripts\utility::array_removeundefined(level.allies);
}

add_terminal_to_second_controlroom() {
  var_0 = getent("rog_terminal_obj", "targetname");
  var_1 = getent("rog_terminal_obj_2", "targetname");
  wait 1.0;

  if(!isDefined(level.center1))
    get_center(1);

  if(!isDefined(level.center2))
    get_center(2);

  transform_posrot(var_1, level.center1, level.center2, var_0);
  var_0 delete();
  var_1 delete();
}

ragdoll_shield() {
  var_0 = getent("ragdoll_shield", "targetname");
  var_0 hide();
}

test_quick_breach() {
  common_scripts\utility::flag_wait("controlroom_moved");
  wait 1.0;

  if(!isDefined(level.center1))
    get_center(1);

  if(!isDefined(level.center2))
    get_center(2);

  var_0 = getent("space_breach_anim_node", "targetname");
  level thread anim_enemies_before_breach(var_0, level.before_breach_guys);

  while(level._ai_group["combat_two_enemies"].aicount)
    wait 0.25;

  foreach(var_2 in level.moving_cover_guys) {
    if(isDefined(var_2) && isalive(var_2)) {
      if(isDefined(var_2.magic_bullet_shield))
        var_2 maps\_utility::stop_magic_bullet_shield();

      var_2 kill();
    }
  }

  common_scripts\utility::flag_set("combat_two_enemies_dead");
  var_4 = getent("quick_breach_door_target", "targetname");
  var_5 = [];
  var_6 = var_5.size;
  var_4 makeusable();
  var_5[var_6] = add_c4_to_spot(var_4.origin, var_4.angles);
  var_4 player_is_close_to_breach_location(100);
  common_scripts\utility::flag_set("charge_set");
  common_scripts\utility::flag_set("turn_off_rogs");
  level notify("stop_close_rogs");
  level thread maps\loki_util::player_boundaries_off();
  var_4 makeunusable();

  foreach(var_8 in var_5)
  var_8 delete();

  var_10 = getEntArray("quick_breach_door_target_ai", "targetname");

  foreach(var_8 in var_10)
  var_8 delete();

  level notify("activate_breach");
  thread maps\loki_audio::sfx_space_breach_logic();
  common_scripts\utility::flag_set("combat_two_music_end");
  wait 0.1;
  var_0 = var_4;
  var_13 = getent("breach_start_controlroom_fake", "script_noteworthy");
  var_0 = spawn("script_origin", level.center2.origin);
  var_14 = spawn("script_origin", level.center1.origin);
  common_scripts\utility::waitframe();
  var_0.angles = level.center2.angles;
  var_14.angles = level.center1.angles;
  var_15 = getent("space_breach_anim_node", "targetname");
  var_0 = var_15;
  var_16 = level.breach_anim_node;
  level thread anim_break_entrance(var_16, level.controlroom_top_1, "space_breach_enemy_die_2");
  level thread anim_player_and_allies(var_0, var_16);
  level thread anim_enemies(var_16, "space_breach_enemy_attack");
  wait 0.2;
  wait 0.5;
  wait 0.67;
  var_17 = getnodearray("inside_node", "targetname");

  foreach(var_19 in var_17)
  var_19 connectnode();

  wait 6;
  wait 1.5;
  level notify("ai_out_of_view");
  common_scripts\utility::flag_wait("player_breach_anim_done");
  teleport_allies_to_comm_center_interior();
  common_scripts\utility::flag_wait("player_breach_enemies_dead");
  wait 0.25;
  thread maps\loki_util::loki_autosave_by_name("space_breach_over");
  wait 0.75;
  common_scripts\utility::flag_set("space_breach_done");
}

move_controlroom_to_new_location() {
  level.comm_center_1_pieces = [];
  level.comm_center_2_pieces = [];
  var_0 = getEntArray("breach_start_controlroom", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.targetname) && var_2.targetname == "control_room_center")
      level.center2 = var_2;
  }

  var_0 = getEntArray("rog_controlroom", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.targetname) && var_2.targetname == "control_room_center")
      level.center1 = var_2;
  }

  wait 0.1;
  var_6 = getEntArray("controlroomdome", "targetname");

  foreach(var_8 in var_6) {
    if(isDefined(var_8.script_noteworthy) && var_8.script_noteworthy == "rog_controlroom")
      level.controlroom_top_1 = var_8;

    if(isDefined(var_8.script_noteworthy) && var_8.script_noteworthy == "breach_start_controlroom")
      level.controlroom_top_2 = var_8;
  }

  common_scripts\utility::flag_set("controlroom_moved");
}

player_is_close_to_breach_location(var_0) {
  if(level.console || level.player usinggamepad())
    maps\loki_util::waittill_trigger_activate_looking_at(self, "set_charge_hint", var_0, 0.8, undefined, 1, undefined);
  else
    maps\loki_util::waittill_trigger_activate_looking_at(self, "set_charge_hint_pc", var_0, 0.8, undefined, 1, undefined);
}

transform_posrot(var_0, var_1, var_2, var_3) {
  var_4 = transformmove(var_1.origin, var_1.angles, var_2.origin, var_2.angles, var_3.origin, var_3.angles);
  var_0.origin = var_4["origin"];
  var_0.angles = var_4["angles"];
}

push_player_around(var_0) {
  level.player pushplayervector(var_0);
  wait 0.1;
  level.player pushplayervector((var_0[0] / 2, var_0[1] / 2, var_0[2] / 2));
  wait 0.1;
  level.player pushplayervector((var_0[0] / 4, var_0[1] / 4, var_0[2] / 4));
  wait 0.2;
  level.player pushplayervector((0, 0, 0));
}

allies_catch_up() {
  common_scripts\utility::flag_wait("combat_two_done");
  turn_off_combat_two_triggers();
}

turn_off_combat_two_triggers() {
  var_0 = ["combat_two_third_wave_extra", "combat_two_third_wave_push_0", "combat_two_third_wave_push_1", "combat_two_third_wave_push_1_5", "combat_two_third_wave_push_2", "combat_two_second_wave_retreat", "combat_two_second_wave_push", "ignore_volume", "wave_3_underside", "no_cover", "combat_two_third_wave"];

  foreach(var_2 in var_0) {
    var_3 = getent(var_2, "targetname");

    if(isDefined(var_3))
      var_3 delete();
  }
}

spawn_enemies() {
  level.space_breach_enemies = [];
  level.before_breach_guys = [];
  var_0 = getEntArray("space_breach_enemy", "targetname");

  foreach(var_2 in var_0) {
    var_2 maps\_utility::add_spawn_function(::enemy_spawn_func);
    var_3 = var_2 maps\_utility::spawn_ai();
    level.space_breach_enemies[level.space_breach_enemies.size] = var_3;
  }

  var_0 = getEntArray("space_breach_enemy_2", "targetname");

  foreach(var_2 in var_0) {
    var_2 maps\_utility::add_spawn_function(::anim_enemy_spawn_func);
    var_3 = var_2 maps\_utility::spawn_ai();
    level.before_breach_guys[level.before_breach_guys.size] = var_3;
  }
}

enemy_spawn_func(var_0) {
  self endon("death");
  thread teleport_to_target();
  thread maps\_space_ai::enable_space();
  self.diequietly = 1;
  self.ignoreall = 1;
  self.health = 5000;
  wait 0.5;
  self waittill("damage");
}

anim_enemy_spawn_func() {
  self endon("death");
  thread teleport_to_target();
  thread maps\_space_ai::enable_space();
  self.diequietly = 1;
  self.ignoreall = 1;
  self.deathfunction = ::breach_ai_space_death;
}

teleport_allies_to_comm_center_interior() {
  var_0 = getent("combat_one_traversal1", "targetname");

  if(isDefined(var_0))
    var_0 notify("explosion");

  common_scripts\utility::waitframe();
  var_1 = [];
  var_1[0] = getent("z_trans_ally_location_0", "targetname");
  level.allies[0] unlink();
  level.allies[0] stopanimscripted();
  var_2 = [];
  var_2["ally_0"] = level.allies[0];
  level.breach_anim_node thread maps\_anim::anim_loop(var_2, "rog_intro", "stop_loop");
}

teleport_ally_1_to_comm_center_interior(var_0) {
  var_1 = [];
  var_1[1] = getent("z_trans_ally_location_1", "targetname");
  var_2 = getnode("z_trans_ally_location_1_node", "targetname");
  level.allies[1] unlink();
  level.allies[1] stopanimscripted();
  common_scripts\utility::waitframe();
  level.allies[1] setgoalnode(var_2);
}

set_flags_on_input() {
  level endon("stop_listening_for_input");

  for(;;) {
    var_0 = level.player getnormalizedmovement();

    if(abs(var_0[1]) - abs(var_0[0]) > 0)
      var_1 = 1;
    else
      var_1 = 0;

    if(var_0[1] >= 0.15 && var_1) {
      common_scripts\utility::flag_clear("left_pressed");
      common_scripts\utility::flag_clear("forward_pressed");
      common_scripts\utility::flag_set("right_pressed");
    } else if(var_0[1] <= -0.15 && var_1) {
      common_scripts\utility::flag_clear("right_pressed");
      common_scripts\utility::flag_clear("forward_pressed");
      common_scripts\utility::flag_set("left_pressed");
    } else if(var_0[0] >= 0.15) {
      common_scripts\utility::flag_clear("right_pressed");
      common_scripts\utility::flag_clear("left_pressed");
      common_scripts\utility::flag_set("forward_pressed");
    } else {
      common_scripts\utility::flag_clear("left_pressed");
      common_scripts\utility::flag_clear("right_pressed");
      common_scripts\utility::flag_clear("forward_pressed");
    }

    if(level.player jumpbuttonpressed())
      common_scripts\utility::flag_set("jump_pressed");
    else
      common_scripts\utility::flag_clear("jump_pressed");

    if(level.player attackbuttonpressed())
      common_scripts\utility::flag_set("attack_pressed");
    else
      common_scripts\utility::flag_clear("attack_pressed");

    if(level.player usebuttonpressed())
      common_scripts\utility::flag_set("use_pressed");
    else
      common_scripts\utility::flag_clear("use_pressed");

    common_scripts\utility::waitframe();
  }
}

add_c4_to_spot(var_0, var_1) {
  var_2 = "weapon_space_breacher_obj";
  var_3 = spawn("script_model", var_0);
  var_3 setModel(var_2);
  var_3.angles = var_1;

  while(!isDefined(var_3))
    common_scripts\utility::waitframe();

  return var_3;
}

glow_console(var_0, var_1) {
  var_2 = "loki_proxy_control_panel_obj";
  var_3 = spawn("script_model", var_0);
  var_3 setModel(var_2);
  var_3.angles = var_1;

  while(!isDefined(var_3))
    common_scripts\utility::waitframe();

  return var_3;
}

print_object_vectors(var_0, var_1) {
  if(var_0)
    iprintln("origin: " + self.origin[0] + ", " + self.origin[1] + ", " + self.origin[2]);

  if(var_1)
    iprintln("angles: " + self.angles[0] + ", " + self.angles[1] + ", " + self.angles[2]);
}

teleport_to_target() {
  var_0 = common_scripts\utility::get_target_ent();

  if(!isDefined(var_0.angles))
    var_0.angles = self.angles;

  if(isai(self))
    self forceteleport(var_0.origin, var_0.angles);

  if(isDefined(var_0.target)) {
    var_0 = var_0 common_scripts\utility::get_target_ent();
    maps\_utility::follow_path_and_animate(var_0, 0);
  }
}

#using_animtree("generic_human");

breach_ai_space_death() {
  playFXOnTag(common_scripts\utility::getfx("vfx_blood_impact_space"), self, "j_spineupper");
  playFXOnTag(common_scripts\utility::getfx("space_death_steam_loop"), self, "j_spineupper");
  self.deathanim = % space_death_1;

  if(!isDefined(self.nodeathsound))
    animscripts\death::playdeathsound();

  return 0;
}

anim_enemies_before_breach(var_0, var_1) {
  var_2 = 1;

  foreach(var_4 in var_1) {
    if(var_2 < 8) {
      var_4 maps\_utility::gun_remove();
      var_4.animname = "enemy_" + var_2;
      var_5 = [];
      var_5["enemy_" + var_2] = var_4;
      var_0 thread maps\_anim::anim_loop(var_5, "before_breach");
      var_2++;
    }

    if(var_2 >= 8)
      var_4 delete();
  }

  var_1 = maps\_utility::array_removedead_or_dying(var_1);
  common_scripts\utility::flag_wait("charge_set");
  wait 3.0;

  foreach(var_4 in var_1)
  var_4 delete();
}

anim_break_entrance(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = getEntArray(var_2, "targetname");

  foreach(var_6 in var_4) {
    if(var_3.size < 3) {
      var_6 maps\_utility::add_spawn_function(::anim_enemy_spawn_func);
      var_7 = var_6 maps\_utility::spawn_ai();
      var_3[var_3.size] = var_7;
      continue;
    }

    var_6 delete();
  }

  wait 0.1;
  level.enemy2 = var_3[0];
  level.enemy2.animname = "enemy_2";
  level.enemy_weapon = level.enemy2.weapon;
  level.enemy2 maps\_utility::gun_remove();
  level.enemy2 thread anim_enemies_non_combat(var_0, "enemy_2");
  var_9 = var_3[1];
  var_9.animname = "enemy_6";
  var_9 thread anim_enemies_non_combat(var_0, "enemy_6");
  var_10 = var_3[2];
  var_10.animname = "enemy_7";
  var_10 thread anim_enemies_non_combat(var_0, "enemy_7");
  var_1.animname = "ctrlroom_top";
  var_1 maps\_utility::assign_animtree();
  var_1 maps\_utility::assign_model();
  var_11 = [];
  var_11["ctrlroom_top"] = var_1;
  var_0 thread maps\_anim::anim_single(var_11, "breach");
  var_12 = var_0;
  wait 10.8;
  level thread maps\loki_fx::loki_breach_lighting();
  common_scripts\utility::flag_wait("player_breach_anim_done");
  level thread rotate_control_room_top(var_1, var_12.origin);
}

anim_enemies_non_combat(var_0, var_1) {
  if(var_1 == "enemy_2")
    thread chair_guy_headshot(13.2);

  var_2 = [];
  var_2[var_1] = self;
  var_0 maps\_anim::anim_single(var_2, "breach");
  kill_anim_guy(var_1, 0);
}

anim_enemies_non_combat_rate(var_0, var_1, var_2) {
  var_3 = "single anim";
  var_4 = level.scr_anim[var_1]["breach"];
  self setanim(var_4, 1.0, 0.2, var_2);
  self animscripted(var_3, var_0.origin, var_0.angles, var_4);
}

chair_guy_headshot(var_0) {
  wait(var_0);

  if(self.model == "us_space_assault_a_body" || self.model == "us_space_assault_b_body" || self.model == "body_fed_space_assault_a" || self.model == "body_fed_space_assault_b") {
    playFXOnTag(common_scripts\utility::getfx("space_headshot"), self, "J_Head");
    self setModel(self.model + "_cracked");

    if(gettimescale() < 0.5) {} else {}

    wait 0.1;
    playFXOnTag(common_scripts\utility::getfx("space_headshot"), self, "J_Head");
    common_scripts\utility::waitframe();
  }
}

breach_enemy_headshot_checks() {
  self endon("stop_headshots");

  for(;;) {
    self waittill("damage");
    thread maps\_space_ai::ai_space_headshot_death();

    if(self.damagelocation == "head" || self.damagelocation == "neck") {
      break;
    }

    common_scripts\utility::waitframe();
  }
}

glow_console_after_breach() {
  common_scripts\utility::flag_wait("player_breach_anim_done");
  create_rog_controls();
  level.glow_console = glow_console(level.loki_rog_controls.origin, level.loki_rog_controls.angles);
}

kill_anim_guy(var_0, var_1) {
  wait(var_1);

  if(var_0 == "enemy_2") {
    if(isDefined(self) && isalive(self)) {
      self stopanimscripted();
      wait 0.1;
      var_2 = spawn("script_origin", self.origin);
      self linkto(var_2);
      var_2 moveto(self.origin + (-5, 0, 0), 0.2);
      wait 0.1;
      self kill();
      var_2 delete();
    }
  } else
    self delete();
}

rotate_control_room_top(var_0, var_1) {
  var_2 = 20000;
  var_3 = 2000;
  var_4 = (-1, 1, -1);
  var_4 = vectornormalize(var_4);
  var_5 = var_4 * var_2 + var_0.origin;
  var_0 moveto(var_5, var_3);
  var_0 rotatevelocity((5, 5, 0), var_3);
}

anim_head_faceplate(var_0) {
  var_1 = var_0 gettagorigin("J_Spine4");
  var_2 = var_0 gettagangles("J_Spine4");
  var_3 = getent("enemy_head", "targetname");
  var_4 = getent("enemy_inner_head", "targetname");
  var_3.origin = var_1;
  var_3.angles = var_2;
  var_4.origin = var_1;
  var_4.angles = var_2;
  var_3 linkto(var_0, "J_Spine4");
  var_4 linkto(var_0, "J_Spine4");
}

anim_enemies(var_0, var_1) {
  foreach(var_3 in level.space_breach_enemies) {
    if(isDefined(var_3) && isalive(var_3))
      var_3 delete();
  }

  var_5 = [];
  var_5[0] = (30, 40, -10);
  var_5[1] = (160, 75, 25);
  var_5[2] = (100, 50, 25);
  var_5[3] = (75, 25, 0);
  var_6 = [];
  var_6[0] = (0, 0, 20);
  var_6[1] = (0, 0, 30);
  var_6[2] = (0, 0, -100);
  var_6[3] = (0, 0, 45);
  var_7 = [];
  var_7[0] = "enemy_1";
  var_7[1] = "enemy_4";
  var_7[2] = "enemy_5";
  var_8 = [];
  var_8[0] = 14;
  var_8[1] = 15;
  var_8[2] = 15;
  level.breach_enemy_array = [];
  var_9 = [];
  var_10 = getEntArray(var_1, "targetname");
  var_11 = var_10.size;
  var_11 = 3;

  for(var_12 = 0; var_12 < var_11; var_12++) {
    var_13 = var_10[var_12] maps\_utility::spawn_ai();
    common_scripts\utility::waitframe();
    var_13 maps\_utility::forceuseweapon("arx160_space", "primary");
    var_13 thread anim_player_target_enemy(var_7[var_12], var_0, var_8[var_12]);
    var_13 thread enemy_death_anim(var_7[var_12], var_0);
    level.breach_enemy_array[level.breach_enemy_array.size] = var_13;
  }

  common_scripts\utility::flag_set("breach_enemies_spawned");
}

anim_player_target_enemy(var_0, var_1, var_2) {
  self endon("death");
  self endon("damage");
  thread teleport_to_target();
  thread maps\loki_util::loki_drop_weapon(undefined, 1);
  thread maps\_space_ai::enable_space();
  self.diequietly = 1;
  self.ignoreall = 1;
  self.health = 5000;
  self.noragdoll = 1;
  self.animname = var_0;
  thread play_anim_kill_player_at_end(var_0, var_1);
  thread enemy_shoot_at_player(var_0, var_2);
  common_scripts\utility::flag_wait("player_breach_anim_done");
  wait 3.0;

  if(level.breach_enemy_array.size != 0) {
    if(level.breach_enemy_array.size < 2) {
      if(var_0 == "enemy_4")
        level.allies[1] shoot_at_chair_guy(6, self.origin);
      else
        level.allies[0] shoot_at_chair_guy(6, self.origin);
    }
  }
}

play_anim_kill_player_at_end(var_0, var_1) {
  self endon("death");
  self endon("damage");
  var_2 = [];
  var_2[var_0] = self;
  var_3 = level.scr_anim[var_0]["breach"];
  wait 0.1;
  var_4 = getanimlength(var_3);
  var_5 = "single anim";
  var_6 = getstartorigin(var_1.origin, var_1.angles, var_3);
  var_7 = getstartangles(var_1.origin, var_1.angles, var_3);
  self animscripted(var_5, var_1.origin, var_1.angles, var_3);
  wait 0.1;
  self setanimtime(var_3, 0.04);
  var_4 = var_4 * 0.96;
  wait(var_4 - 2.5);
  level.player kill();
  setslowmotion(0.25, 1.0, 0.25);
}

enemy_death_anim(var_0, var_1) {
  self endon("death");
  var_2 = spawn("script_origin", var_1.origin);
  common_scripts\utility::waitframe();
  var_2.angles = var_1.angles;
  self waittill("damage", var_3, var_4, var_5, var_6);
  thread breach_enemy_damage_fx(var_6);
  common_scripts\utility::waittill_notify_or_timeout("stop_damage_fx", 0.25);
  self notify("stop_damage_fx");
  level.breach_enemy_array = common_scripts\utility::array_remove(level.breach_enemy_array, self);
  thread delay_enemy_light_flicker(0.2);
  var_7 = [];
  var_7[var_0] = self;
  self.allowdeath = 1;
  self.a.nodeath = 1;
  self.noragdoll = 1;
  self.nocorpsedelete = 1;
  self setcontents(0);
  var_8 = self.origin;
  var_9 = 0;

  if(var_0 == "enemy_1") {
    var_8 = self.origin + (0, 10, -50);
    var_9 = 25;
  }

  if(var_0 == "enemy_4") {
    var_8 = self.origin + (0, 0, 15);
    var_9 = 3.5;
  }

  if(var_0 == "enemy_5") {
    var_2.origin = var_2.origin + (30, 30, 7);
    var_10 = getent("enemy_5_anim_loop_origin", "targetname");
    var_8 = var_10.origin;
    var_9 = 10;
  }

  var_11 = level.scr_anim[var_0]["breach_death_loop"][0];
  var_12 = self gettagorigin("tag_origin");
  var_12 = self.origin;
  var_13 = spawn("script_origin", var_12);
  self linkto(var_13);
  var_11 = level.scr_anim[var_0]["breach_death"];
  var_14 = getanimlength(var_11);
  var_13 moveto(var_8, var_14 - var_9, 0.5, 1.0);
  maps\_anim::anim_single(var_7, "breach_death");
  self notify("stop_headshots");
  maps\_anim::anim_loop(var_7, "breach_death_loop");
  self kill();
}

breach_enemy_damage_fx(var_0) {
  self endon("stop_damage_fx");
  var_1 = 0;
  common_scripts\utility::waitframe();

  for(;;) {
    if(self.damagelocation == "head" || self.damagelocation == "neck")
      var_1 = 1;

    thread maps\_space_ai::ai_space_headshot_death();
    var_2 = level.player.origin - var_0;
    playFX(common_scripts\utility::getfx("vfx_blood_impact_space_efxnow"), var_0, var_2);
    playFXOnTag(common_scripts\utility::getfx("space_death_steam_loop"), self, "j_spineupper");

    if(var_1)
      self notify("stop_damage_fx");

    self waittill("damage", var_3, var_4, var_5, var_0);
  }
}

breach_ai_space_headshot_death(var_0) {
  var_1 = self getEye();

  if(distance(var_1, var_0) < 20) {
    if(self.model == "us_space_assault_a_body" || self.model == "us_space_assault_b_body" || self.model == "body_fed_space_assault_a" || self.model == "body_fed_space_assault_b") {
      playFXOnTag(common_scripts\utility::getfx("space_headshot"), self, "J_Head");
      self setModel(self.model + "_cracked");

      if(gettimescale() < 0.5)
        self playSound("space_npc_helmet_shatter_slomo");
      else
        self playSound("space_npc_helmet_shatter");
    }
  }
}

delay_enemy_light_flicker(var_0) {
  wait(var_0);
  self notify("faux_death");
}

enemy_link_node_move(var_0, var_1) {
  self moveto(var_0, var_1);
}

enemy_shoot_at_player(var_0, var_1) {
  self endon("death");
  self endon("damage");
  wait(var_1);
  var_2 = 1;

  while(!common_scripts\utility::flag("player_breach_anim_done")) {
    var_3 = [0, 10, -10];
    var_4 = 3;

    for(var_5 = 0; var_5 < var_4; var_5++) {
      var_6 = common_scripts\utility::random(var_3);
      playFXOnTag(common_scripts\utility::getfx("pistol_muzzleflash"), self, "tag_flash");
      magicbullet(self.weapon, self gettagorigin("tag_flash"), level.player.origin + (0, var_6, 60));
      wait 0.1;
    }

    if(common_scripts\utility::flag("player_breach_anim_done")) {
      break;
    }

    wait 0.3;
  }

  var_7 = 20;

  if(var_0 != "enemy_1")
    var_7 = 30;

  for(;;) {
    var_3 = [0, 10, -10];
    var_4 = 1;

    for(var_5 = 0; var_5 < var_4; var_5++) {
      var_8 = 0;
      playFXOnTag(common_scripts\utility::getfx("pistol_muzzleflash"), self, "tag_flash");
      magicbullet(self.weapon, self gettagorigin("tag_flash"), level.player.origin + (0, var_3[var_8], var_7));
      wait 0.1;
    }

    wait 0.3;
  }
}

anim_player_and_allies(var_0, var_1) {
  level.player freezecontrols(1);
  level.allies[0].ignoreme = 1;
  level.allies[1].ignoreme = 1;
  level.allies[0] maps\_utility::forceuseweapon("arx160_spacealt", "primary");
  level.allies[1] maps\_utility::forceuseweapon("arx160_spacealt", "primary");
  level.player.attackeraccuracy = 0;
  var_2 = maps\_utility::spawn_anim_model("ctrlroom_explosive");
  var_3 = maps\_utility::spawn_anim_model("ctrlroom_explosive");
  var_4 = maps\_utility::spawn_anim_model("loki_breach_bag_big");
  var_5 = maps\_utility::spawn_anim_model("loki_breach_bag_round");
  var_6 = maps\_utility::spawn_anim_model("loki_breach_bag_square");
  var_7 = maps\_utility::spawn_anim_model("loki_breach_laptop");
  var_8 = maps\_utility::spawn_anim_model("player_rig", var_0.origin);
  var_8.angles = level.player.angles;
  var_8 hide();
  var_9 = maps\_utility::spawn_anim_model("player_legs", var_0.origin);
  var_9.angles = level.player.angles;
  var_9 hide();
  var_10 = [];
  var_10["player"] = var_8;
  var_10["player_legs"] = var_9;
  var_0 maps\_anim::anim_first_frame(var_10, "breach");
  var_11 = maps\_utility::spawn_anim_model("player_rig", var_1.origin);
  var_11.angles = level.player.angles;
  var_11 hide();
  var_12 = maps\_utility::spawn_anim_model("player_legs", var_1.origin);
  var_12.angles = level.player.angles;
  var_12 hide();
  var_13 = [];
  var_13["player"] = var_11;
  var_13["player_legs"] = var_12;
  var_1 maps\_anim::anim_first_frame(var_13, "breach");
  level.player disableweapons();
  level.player playerlinktoblend(var_8, "tag_player", 0.5);
  var_14 = getEntArray("control_room_cap", "targetname");

  foreach(var_16 in var_14) {
    var_16 hide();
    var_16 notsolid();
    var_16 connectpaths();
  }

  wait 0.5;
  setsaveddvar("actionSlotsHide", 1);
  setsaveddvar("ammoCounterHide", 1);
  setsaveddvar("hud_showStance", 0);
  var_18 = level.player getweaponammoclip(level.primary_weapon);

  if(var_18 < 10)
    var_18 = 20;

  level.player setweaponammoclip(level.primary_weapon, var_18);
  var_19 = 1;
  level.player playerlinktodelta(var_8, "tag_player", 1, var_19, var_19, var_19, var_19, 1);
  common_scripts\utility::waitframe();
  var_8 show();
  var_11 show();
  var_9 show();
  var_12 show();
  var_10["ctrlroom_explosive"] = var_2;
  var_13 = [];
  var_13["ally_0"] = level.allies[0];
  var_13["ctrlroom_explosive"] = var_3;
  var_13["loki_breach_bag_big"] = var_4;
  var_13["loki_breach_bag_round"] = var_5;
  var_13["loki_breach_bag_square"] = var_6;
  var_13["loki_breach_laptop"] = var_7;
  var_1 thread maps\_anim::anim_single(var_13, "breach");
  var_13 = [];
  var_13["player"] = var_11;
  var_13["player_legs"] = var_12;
  thread play_anim_and_end_slowmo_logic(var_0, var_10, var_1, var_13);
  wait 0.1;
  level.player setorigin(var_11.origin);
  level.player setplayerangles(var_11.angles);
  level.player playerlinktodelta(var_11, "tag_player", 1, var_19, var_19, var_19, var_19, 1);
  level.player playersetgroundreferenceent(var_11);
  wait 0.1;
  var_19 = 30;
  level.player playerlinktodelta(var_11, "tag_player", 1, var_19, var_19, var_19, var_19, 1);
  common_scripts\utility::flag_set("player_teleport_done");
  wait 0.5;
  var_11 attach("viewmodel_arx_160", "tag_weapon", 1);
  var_11 attach("viewmodel_acog_iw6", "TAG_ACOG_2", 1);
  var_11 attach("viewmodel_reticle_acog", "TAG_RETICLE_ATTACH", 1);
  var_11 attach("viewmodel_grenade_launcher", "TAG_GRENADE_LAUNCHER", 1);
  var_11 hidepart("TAG_SIGHT_ON", "viewmodel_arx_160");
  wait 1.5;
  wait 6;
  thread maps\loki_fx::fx_space_breach();
  var_2 delete();
  var_3 delete();
  wait 0.1;
  level.player playrumbleonentity("damage_heavy");
  wait 0.1;
  wait 3.0;
  var_19 = 25;
  level.player playerlinktodelta(var_11, "tag_player", 1, var_19, var_19, var_19, 20, 1);
  level.player.ignoreme = 0;
  level.enemy2 thread maps\loki_audio::sfx_ally_shoot();
  wait 0.1;
  wait 0.25;
  level.player freezecontrols(0);
  var_18 = level.player getweaponammoclip(level.primary_weapon);
  var_20 = level.player getweaponammostock(level.primary_weapon);
  var_21 = level.player getweaponammoclip(weaponaltweaponname(level.primary_weapon));
  var_22 = level.player getweaponammostock(weaponaltweaponname(level.primary_weapon));
  level.player takeallweapons();
  level.player giveweapon(level.breach_weapon, 0, 0, 0, 1);
  level.player setweaponammoclip(level.breach_weapon, var_18);
  level.player setweaponammostock(level.breach_weapon, var_20);
  level.player switchtoweapon(level.breach_weapon);
  level.player enableweapons();
  level.player showviewmodel();
  level.player disableweaponswitch();
  setsaveddvar("ammoCounterHide", 0);
  setsaveddvar("hud_showStance", 1);
  wait 0.25;
  level thread remove_weapon_clip_on_notify("kill_chair_clip");
  level.allies[1] thread shoot_at_chair_guy(3, level.enemy2.origin + (0, 5, 0));
  level.allies[1] thread shoot_at_chair_guy(5, level.enemy2.origin + (0, 5, 2), "kill_chair_clip", 0.75);
  level.enemy2 notify("faux_death");
  level.enemy2 setcontents(0);
  var_11 hide();
  wait 0.35;
  var_23 = 0.25;
  thread player_slow_mo_death_watch(var_23);
  setslowmotion(1.0, var_23, 0.25);
  wait 1.0;
  var_12 hide();
  common_scripts\utility::flag_wait("player_breach_enemies_dead");
  thread maps\loki_audio::sfx_space_breach_over();
  level thread player_switch_weapon(level.primary_weapon, var_18, var_20);
  setslowmotion(var_23, 1.0, 0.25);
  common_scripts\utility::flag_wait("player_breach_anim_done");
  var_14 = getEntArray("control_room_boundary_collision", "targetname");

  foreach(var_16 in var_14)
  var_16 solid();

  var_14 = getEntArray("control_room_cap", "targetname");

  foreach(var_16 in var_14) {
    var_16 hide();
    var_16 notsolid();
    var_16 connectpaths();
  }

  var_28 = getnodearray("post_breach_pathnode", "targetname");

  foreach(var_30 in var_28)
  var_30 connectnode();

  level.player playersetgroundreferenceent(undefined);
  wait 0.1;
  level.player unlink();
  level.player enableweaponswitch();
  var_8 delete();
  var_11 delete();
  var_9 delete();
  var_12 delete();
  var_4 delete();
  var_5 delete();
  var_6 delete();
  var_7 delete();
  common_scripts\utility::flag_set("breach_done");
}

player_switch_weapon(var_0, var_1, var_2) {
  common_scripts\utility::flag_wait("player_breach_enemies_dead");
  common_scripts\utility::flag_wait("player_breach_anim_done");
  wait 0.5;
  level.player freezecontrols(0);
  level.player setweaponammoclip(level.breach_weapon, 20);
  setsaveddvar("ammoCounterHide", 1);
  level.player disableweapons();
}

player_slow_mo_death_watch(var_0) {
  level endon("breach_done");
  level.player waittill("death");
  setslowmotion(var_0, 1.0, 0.1);
}

lerp_ref_ent(var_0) {
  var_1 = (level.player.angles[0], level.player.angles[1], 0);

  for(var_2 = 0; var_2 < var_0; var_2++) {
    var_3 = maps\_space_ai::fake_slerp(self.angles, var_1, var_2 / var_0);
    self.angles = var_3;
    common_scripts\utility::waitframe();
  }
}

create_rog_controls() {
  var_0 = getEntArray("control_panel_armature", "script_noteworthy");
  var_1 = 100000;

  foreach(var_3 in var_0) {
    if(!isDefined(level.loki_rog_controls) || distance(var_3.origin, level.player.origin) < var_1) {
      level.loki_rog_controls = var_3;
      var_1 = distance(var_3.origin, level.player.origin);
    }
  }
}

shoot_at_chair_guy(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3))
    wait(var_3);

  var_4 = 0;

  while(var_4 < var_0) {
    var_5 = self gettagorigin("tag_flash");
    var_6 = var_1 + (0, 0, 20);
    playFXOnTag(common_scripts\utility::getfx("pistol_muzzleflash"), self, "tag_flash");
    magicbullet(self.weapon, var_5, var_6);
    bullettracer(var_5, var_6, 1);
    var_4++;
    wait 0.1;
  }

  if(isDefined(var_2))
    level notify(var_2);
}

remove_weapon_clip_on_notify(var_0) {
  var_1 = getEntArray("breach_bullet_block", "targetname");
  level waittill(var_0);

  foreach(var_3 in var_1)
  var_3 delete();
}

play_anim_and_end_slowmo_logic(var_0, var_1, var_2, var_3) {
  thread set_flag_when_enemies_dead("player_breach_enemies_dead");
  level thread set_fire_flag_near_anim_end(4);
  level thread play_ally_anim(var_2);
  var_0 thread maps\_anim::anim_single(var_1, "breach");
  var_2 maps\_anim::anim_single(var_3, "breach");
  common_scripts\utility::flag_set("player_breach_anim_done");
}

play_ally_anim(var_0) {
  var_1 = spawn("script_origin", var_0.origin);
  var_1.angles = var_0.angles;
  var_2 = [];
  var_2["ally_1"] = level.allies[1];
  var_1 maps\_anim::anim_single(var_2, "breach");
  common_scripts\utility::flag_wait("player_breach_anim_done");
  common_scripts\utility::flag_wait("player_breach_enemies_dead");
  teleport_ally_1_to_comm_center_interior(0);
}

set_fire_flag_near_anim_end(var_0) {
  var_1 = getanimlength(level.scr_anim["player_rig"]["breach"]);
  wait(var_1 - var_0);
  common_scripts\utility::flag_set("shoot_at_player");
}

set_flag_when_enemies_dead(var_0) {
  common_scripts\utility::flag_wait("breach_enemies_spawned");

  while(level.breach_enemy_array.size > 0)
    wait 0.1;

  common_scripts\utility::flag_set(var_0);
}

create_anim_node() {
  var_0 = getent("space_breach_anim_node", "targetname");
  var_1 = spawn("script_origin", var_0.origin);
  common_scripts\utility::waitframe();
  var_1.angles = var_0.angles;

  if(!isDefined(level.center1))
    get_center(1);

  if(!isDefined(level.center2))
    get_center(2);

  transform_posrot(var_1, level.center1, level.center2, var_1);
  level.breach_anim_node = var_1;
}

set_earth_pos_during_breach(var_0) {
  if(!isDefined(level.center1))
    get_center(1);

  if(!isDefined(level.center2))
    get_center(2);

  transform_posrot(var_0, level.center1, level.center2, var_0);
}

get_center(var_0) {
  if(var_0 == 1) {
    if(!isDefined(level.center1)) {
      var_1 = getEntArray("rog_controlroom", "script_noteworthy");

      foreach(var_3 in var_1) {
        if(isDefined(var_3.targetname) && var_3.targetname == "control_room_center")
          level.center1 = var_3;
      }
    }
  }

  if(var_0 == 2) {
    if(!isDefined(level.center2)) {
      var_1 = getEntArray("breach_start_controlroom", "script_noteworthy");

      foreach(var_3 in var_1) {
        if(isDefined(var_3.targetname) && var_3.targetname == "control_room_center")
          level.center2 = var_3;
      }
    }
  }
}

add_dead_enemy_clip() {
  var_0 = getEntArray("dead_enemy_collision", "targetname");

  foreach(var_2 in var_0) {
    var_2 hide();
    var_2 notsolid();
  }

  common_scripts\utility::flag_wait("charge_set");

  foreach(var_2 in var_0) {
    var_2 show();
    var_2 solid();
  }
}

play_nag_after_delay(var_0, var_1, var_2, var_3) {
  self endon("stop nags");
  wait(var_0);

  if(isDefined(var_3))
    thread maps\loki_util::play_nag(var_1, var_2, 5, 8, 1, 8, undefined, undefined, 1);
  else
    thread maps\loki_util::play_nag(var_1, var_2, 5, 8, 1, 8, undefined, undefined);
}

space_breach_dialogue() {
  common_scripts\utility::flag_wait("combat_two_done");
  common_scripts\utility::flag_wait("combat_two_dialogue_done");
  common_scripts\utility::flag_wait_any("ally_0_combat_two_anims_finished", "ally_1_combat_two_anims_finished", "charge_set");

  if(!common_scripts\utility::flag("charge_set"))
    maps\_utility::smart_radio_dialogue("loki_kgn_getyourchargesplanted");

  var_0 = ["loki_gs3_thompsongetoverhere", "loki_gs3_thompsonsetyourcharge", "loki_gs3_weneedtobreach", "loki_gs3_wegottastopthese"];
  level.allies[0] thread play_nag_after_delay(5.0, var_0, "charge_set");
  common_scripts\utility::flag_wait("charge_set");
  level.allies[0] notify("stop nags");
  wait 3.0;
  maps\_utility::smart_radio_dialogue("loki_kgn_chargesset");
  wait 1.0;
  thread maps\_utility::smart_radio_dialogue("loki_kgn_hereshopingthesething");
  wait 2.0;
  maps\_utility::radio_dialogue_stop();
  common_scripts\utility::flag_wait("breach_done");
  common_scripts\utility::flag_wait("player_breach_enemies_dead");
  maps\_utility::smart_radio_dialogue("loki_gs3_clear");
  maps\_utility::smart_radio_dialogue("loki_kgn_thompsongettocontrol");
  var_0 = ["loki_gs3_werewaitingonyou"];
  level.allies[0] thread play_nag_after_delay(10.0, var_0, "console_activated");
  common_scripts\utility::flag_wait("console_activated");
  level.allies[0] notify("stop nags");
  wait 0.2;
}