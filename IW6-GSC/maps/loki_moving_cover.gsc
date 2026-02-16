/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\loki_moving_cover.gsc
**************************************/

section_main() {
  maps\_utility::add_hint_string("pickup_gun", &"LOKI_IN_YOUR_FACE", ::stop_in_your_face_hint);
}

section_precache() {
  precacheitem(level.primary_weapon);
  precachestring(&"LOKI_IN_YOUR_FACE");
  precachestring(&"LOKI_IN_YOUR_FACE_FAIL");
  precacheshellshock("default_nosound");
  precachemodel("space_module_2_dest_split_01");
  precachemodel("space_module_2_dest_split_02");
  precachemodel("space_ctc1");
  precachemodel("space_ata_box");
  precachemodel("space_esp1");
  precachemodel("space_esp2");
  precachemodel("space_module_2_dest");
  precachemodel("vehicle_space_shuttle");
  precachemodel("loki_truss_sail");
  precachemodel("space_a25_ams");
  precachemodel("loki_antenna_1");
  precachemodel("loki_antenna_2");
  precachemodel("loki_cargo_container_01");
  precachemodel("loki_p6_battery");
  precachemodel("space_exterior_airlock_entrance");
  precachemodel("loki_exterior_round_hatch");
  precachemodel("space_module_2");
  precachemodel("space_module_5");
  precachemodel("space_module_3");
  precachemodel("space_module_2_panel_01");
  precachemodel("space_esp2_combined_01");
  precachemodel("space_esp2_combined_02");
  precachemodel("space_esp2_combined_03");
  precachemodel("space_esp2_combined_04");
  precachemodel("space_module_2_dest_split_01_int");
  precachemodel("space_module_2_dest_split_01_int_props_01");
  precachemodel("space_module_2_dest_split_01_int_props_02");
  precachemodel("space_solar_array_damage");
  precachemodel("space_module_2_dest_split_02_int");
  precachemodel("mp_dart_crate_01");
  precachemodel("loki_crate_01");
  precachemodel("space_solar_array_damage_posed");
}

section_flag_inits() {
  common_scripts\utility::flag_init("gun_picked_up");
  common_scripts\utility::flag_init("moving_cover_started");
}

moving_cover_start() {
  maps\loki_util::player_move_to_checkpoint_start("moving_cover");
  maps\loki_util::spawn_allies();
  level.allies[0] maps\_utility::set_force_color("r");
  level.allies[1] maps\_utility::set_force_color("g");
  level.allies[2] maps\_utility::set_force_color("b");
  level.moving_cover_jumped = 1;
  level.player freezecontrols(1);
}

moving_cover() {
  maps\loki_util::loki_autosave_by_name_silent("moving_cover");
  maps\_utility::battlechatter_off("allies");
  level.accuracy_ally = 1;
  level.accuracy_enemy = 1;
  maps\_utility::stop_exploder("c1_sunflare");
  maps\_utility::stop_exploder("blue_flare");
  common_scripts\utility::exploder("c2_sunflare");
  common_scripts\utility::exploder("mc_flare");
  thread maps\loki_fx::light_combat2_threads();
  level.allow_movement = 1;
  level.allies[0].baseaccuracy = level.accuracy_ally;
  level.allies[1].baseaccuracy = level.accuracy_ally;
  level.allies[2].baseaccuracy = level.accuracy_ally;
  level thread moving_cover_main();
  level.ground_ref_ent = spawn("script_model", (0, 0, 0));
  level thread maps\loki_fx::set_motionblur();
  level thread maps\loki_combat_two::moving_large_debris();
  common_scripts\utility::exploder("fiery_glow");
  common_scripts\utility::exploder("mc_exp");
  common_scripts\utility::flag_wait("moving_cover_done2");
  level thread maps\_utility::notify_delay("stop_explosions", 30);
}

white_hide() {
  var_0 = getent("face_explosion", "targetname");
  level.player maps\_hud_util::fade_out(0.01, "white");
  wait 0.15;
  level.player maps\_hud_util::fade_in(0.15, "white");
}

moving_cover_main() {
  common_scripts\utility::waitframe();
  thread maps\loki_audio::sfx_moving_cover_2();
  level.friendlyfiredisabled = 1;
  var_0 = common_scripts\utility::getstruct("moving_cover_ally_0", "targetname");
  var_1 = common_scripts\utility::getstruct("moving_cover_ally_1", "targetname");
  level.allies[0] stopanimscripted();
  level.allies[1] stopanimscripted();
  level.allies[0] forceteleport(var_0.origin, var_0.angles);
  level.allies[1] forceteleport(var_1.origin, var_1.angles);
  level.allies[0] setgoalpos(var_0.origin);
  level.allies[1] setgoalpos(var_1.origin);
  var_2 = maps\loki_combat_one::get_all_wave_guys(1);
  var_2 = maps\_utility::array_merge(var_2, level.redshirts);

  if(isDefined(var_2)) {
    var_2 = maps\_utility::array_removedead_or_dying(var_2);

    foreach(var_4 in var_2) {
      if(isDefined(var_4.magic_bullet_shield))
        var_4 maps\_utility::stop_magic_bullet_shield();

      var_4.diequietly = 1;
      var_4 kill();
    }
  }

  if(isDefined(level.moving_cover_jumped)) {
    level firstframe_moving_cover();
    common_scripts\utility::waitframe();
    level thread white_hide();
  }

  var_6 = 12.5;
  var_7 = getent("explosion_node2", "targetname");
  var_8 = maps\_utility::spawn_anim_model("player_rig");
  level.player playerlinktodelta(var_8, "tag_player", 1, 0, 0, 0, 0, 1);
  level thread manage_control(var_8);
  common_scripts\utility::flag_set("moving_cover_started");
  level.hitsail thread maps\_anim::anim_single_solo(level.hitsail, "explosion_part2_sail");
  common_scripts\utility::waitframe();
  level.solar_array0 thread maps\_anim::anim_single_solo(level.solar_array0, "explosion_part2_solar0");
  level.solar_array1 thread maps\_anim::anim_single_solo(level.solar_array1, "explosion_part2_solar1");
  level.moving_cover_start_node thread maps\_anim::anim_single(level.moving_cover, "explosion_part2");
  level.moving_cover_opfor thread moving_cover_opfor_death_tracker();
  level.moving_cover_start_node maps\_anim::anim_single_solo(var_8, "explosion_part2");
  level.allies[2] moving_cover_death();
  level.player unlink();
  var_8 delete();
  level.friendlyfiredisabled = 0;
  common_scripts\utility::flag_set("moving_cover_done2");
  maps\_utility::stop_exploder("fiery_glow");
  common_scripts\utility::exploder("big_dust");
}

moving_cover_lightsoff(var_0) {
  var_0 maps\_utility::ent_flag_clear("lights_on");
  var_0 notify("faux_death");
}

#using_animtree("generic_human");

moving_cover_opfor_death_tracker() {
  thread maps\loki_util::loki_drop_weapon((7000, 0, 500));
  common_scripts\utility::flag_set("no_steam_on_death");
  self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  maps\loki_util::jkuprint("HIT!!!");
  self setanim(%space_pain_1, 1, 0.2);

  if(self.damagelocation != "neck") {
    wait 0.2;
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    maps\loki_util::jkuprint("HIT AGAIN!!!");
  }

  self startragdollfromimpact("torso_lower", (3500, 0, 0));
  self stopanimscripted();
  maps\loki_util::jkuprint("DEAD!!!");
  self notify("faux_death");
}

moving_cover_death(var_0) {
  self endon("death");

  if(isDefined(self.magic_bullet_shield))
    maps\_utility::stop_magic_bullet_shield();

  if(isDefined(var_0) && var_0) {
    if(isDefined(self))
      self stopanimscripted();

    if(isDefined(self))
      self safeteleport(self.origin + (0, 100, -1000), self.angles);
  }

  if(isalive(self))
    self kill();
}

take_control(var_0) {
  level notify("take_control");
  level.player freezecontrols(1);
  level.player hideviewmodel();
  level.player disableweapons();
  level thread maps\loki_combat_two::show_combat_two_intro_debris();
  level thread animate_combat_two_intro_debris();
  level thread delete_moving_cover_objects();
  level thread hit_panel(var_0, 0.5, 0.5, 1, 0.0);
  level.player playrumbleonentity("heavy_3s");
  level.moving_cover_opfor moving_cover_death(1);
  common_scripts\utility::flag_clear("no_steam_on_death");
  level thread maps\loki_combat_two::combat_two_intro_vignette(0.5);
  level thread maps\loki_combat_two::play_helmet_light_damage(6);
  var_0 maps\_utility::lerp_player_view_to_tag(level.player, "tag_camera", 0.05, 1, 0, 0, 0, 0);
}

animate_combat_two_intro_debris() {
  var_0 = getent("combat_two_intro_debris_move_main", "script_noteworthy");
  var_0.animname = "combat_two_intro_debris";
  var_0 maps\_utility::assign_animtree();
  var_1 = getEntArray("combat_two_intro_debris_move", "script_noteworthy");

  foreach(var_3 in var_1)
  var_3 linkto(var_0);

  level.moving_cover_start_node maps\_anim::anim_single_solo(var_0, "combat_two_intro_debris_move");
}

delete_moving_cover_objects() {
  level.cargo_container delete();
  level.module_ext delete();
  level.module_int delete();
  level.module_int_props01 delete();
  level.module_int_props02 delete();
  level.space_shuttle delete();
  level.ams delete();
  level.antenna_2 delete();
  level.p6_battery delete();
  level.hitsail hidepart("j_sail_001");
  level.solar_array0 delete();
  level.solar_array0 = spawn("script_model", (36277.5, -2451, 2014.5));
  level.solar_array0 setModel("space_solar_array_damage_posed");
}

firstframe_moving_cover(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  level.moving_cover_start_node = getent("moving_cover_vignette", "targetname");
  level.moving_cover_obj1 = maps\_utility::spawn_anim_model("moving_cover_obj1");
  level.moving_cover_obj1 maps\loki_util::spawn_and_link_models_to_tags("combat_one_cleanup", undefined, var_0);
  level.moving_cover_opfor = maps\loki_util::spawn_space_ai_from_targetname("enemy_moving_cover_final_new");
  level.moving_cover_opfor.animname = "moving_cover_opfor";
  level.moving_cover = [];
  level.moving_cover["moving_cover_opfor"] = level.moving_cover_opfor;
  level.moving_cover["ally_2"] = level.allies[2];
  level.moving_cover["moving_cover_obj1"] = level.moving_cover_obj1;
  level.hitsail.animname = "moving_cover_sail";
  level.hitsail maps\_utility::assign_animtree();
  level.hitsail thread maps\_anim::anim_first_frame_solo(level.hitsail, "explosion_part2_sail");
  level.solar_array0.animname = "moving_cover_solar0";
  level.solar_array0 maps\_utility::assign_animtree();
  level.solar_array0 thread maps\_anim::anim_first_frame_solo(level.solar_array0, "explosion_part2_solar0");
  level.solar_array1.animname = "moving_cover_solar1";
  level.solar_array1 maps\_utility::assign_animtree();
  level.solar_array1 thread maps\_anim::anim_first_frame_solo(level.solar_array1, "explosion_part2_solar1");
  level.allies[2] maps\_utility::gun_remove();
  level.moving_cover_start_node maps\_anim::anim_first_frame(level.moving_cover, "explosion_part2");
}

manage_control(var_0) {
  level.player endon("death");
  level.player freezecontrols(1);
  level.player hideviewmodel();
  level.player disableweapons();
  wait 3.2;
  level thread smooth_moving_cover_look();
  level.player freezecontrols(0);
  level.player showviewmodel(0);
  level.player enableweapons(0);
  var_0 hide();
}

smooth_moving_cover_look() {
  level endon("take_control");
  level endon("moving_cover_done2");
  level.player endon("death");
  var_0 = gettime();

  for(;;) {
    var_1 = level.player getnormalizedcameramovement();

    if(abs(var_1[0]) > 0.15 || abs(var_1[1]) > 0.15) {
      break;
    }

    common_scripts\utility::waitframe();
  }

  var_2 = gettime();
  var_3 = var_2 - var_0;

  if(var_3 > 2000) {
    maps\loki_util::jkuprint("no lerp " + var_3);
    level.player lerpviewangleclamp(0, 0, 0, 45, 45, 20, 30);
  } else {
    maps\loki_util::jkuprint("lerp " + var_3);
    level.player lerpviewangleclamp(2, 1, 0.5, 45, 45, 20, 30);
  }
}

set_current(var_0, var_1) {
  level.player endon("death");
  level endon("stop_explosion_push");
  var_1 = var_1 * 1000;
  var_2 = var_1 / 50;
  var_3 = var_0 / var_2;

  for(var_4 = 0; var_4 < var_2; var_4++) {
    setsaveddvar("player_swimWaterCurrent", (var_0, 0, 0));
    var_0 = var_0 - var_3;
    common_scripts\utility::waitframe();
  }

  maps\loki_util::jkuprint("push stopped");
}

ramp_up_accurracy(var_0, var_1) {
  self endon("death");
  var_0 = var_0 * 1000;
  var_2 = var_0 / 50;
  var_3 = (var_1 - self.baseaccuracy) / var_2;
  wait 3;

  for(var_4 = 0; var_4 < var_2; var_4++) {
    self.baseaccuracy = self.baseaccuracy + var_3;
    common_scripts\utility::waitframe();
  }

  self.baseaccuracy = var_1;
}

stop_in_your_face_hint() {
  if(common_scripts\utility::flag("gun_picked_up"))
    return 1;
  else
    return 0;
}

in_your_face() {
  level.player endon("death");
  level endon("gun_picked_up");

  for(;;) {
    var_0 = anglesToForward(level.player.angles);
    var_1 = level.player.origin + 15 * var_0 + (randomfloatrange(-10, 10), randomfloatrange(-10, 10), 55);
    magicbullet("microtar_space", var_1, level.player.origin);
    setDvar("ui_deadquote", &"LOKI_IN_YOUR_FACE_FAIL");
    wait(randomfloatrange(1, 2));
  }
}

wait_for_x_pressed() {
  level.player endon("death");
  var_0 = 0;
  var_1 = 5;

  while(!(var_0 > var_1)) {
    var_0 = 0;

    while(level.player useButtonPressed()) {
      if(var_0 > var_1) {
        break;
      }

      var_0 = var_0 + 1;
      common_scripts\utility::waitframe();
    }

    common_scripts\utility::waitframe();
  }

  common_scripts\utility::flag_set("gun_picked_up");
  level.player giveweapon(level.primary_weapon);
  level.player switchtoweapon(level.primary_weapon);
  level.player givemaxammo(level.primary_weapon);
}

start_moving_cover(var_0, var_1, var_2) {
  var_3 = getEntArray("explosion_debris_col", "targetname");

  foreach(var_5 in var_3)
  var_5 linkto(var_5 common_scripts\utility::get_target_ent());

  var_7 = var_1;

  for(var_8 = 1; var_8 <= var_7; var_8++) {
    var_9 = getEntArray(var_0 + var_8, "script_noteworthy");

    foreach(var_11 in var_9) {
      var_11 moveto(var_11 common_scripts\utility::getstruct(var_11.target, "targetname").origin, var_2, 0, 0);
      var_11 rotatevelocity((randomfloatrange(-55, 55), randomfloatrange(-55, 55), randomfloatrange(-55, 55)), 999);
    }
  }
}

start_moving_cover3(var_0, var_1, var_2) {
  var_3 = var_1;

  for(var_4 = 1; var_4 <= var_3; var_4++) {
    var_5 = getEntArray(var_0 + var_4, "script_noteworthy");

    foreach(var_7 in var_5) {
      var_8 = getent(var_7.script_linkto, "targetname");
      var_7 linkto(var_8);
    }

    foreach(var_7 in var_5) {
      var_8 = getent(var_7.script_linkto, "targetname");
      var_8 moveto(var_8 common_scripts\utility::getstruct(var_8.target, "targetname").origin, var_2);
      var_8 rotatevelocity((randomfloatrange(-5, 5), 0, randomfloatrange(-5, 5)), 999);
    }
  }
}

node_test() {
  var_0 = getnode("node_test", "targetname");

  for(;;) {
    maps\loki_util::jkuline(var_0.origin + (-12, 0, 0), var_0.origin + (12, 0, 0));
    maps\loki_util::jkuline(var_0.origin + (0, -12, 0), var_0.origin + (0, 12, 0));
    maps\loki_util::jkuline(var_0.origin + (0, 0, -12), var_0.origin + (0, 0, 12));
    common_scripts\utility::waitframe();
  }
}

ai_follow_cover(var_0, var_1) {
  self endon("death");
  self endon("stop_follow_cover");
  var_2 = var_0.origin - self.origin;

  for(;;) {
    var_3 = var_0.origin - var_2;
    self setgoalpos(var_3);

    if(bullettracepassed(self.origin, var_3, 0, undefined))
      maps\loki_util::jkuline(self.origin, var_3);
    else
      maps\loki_util::jkuline(self.origin, var_3, (1, 0, 0));

    if(distance2d(self.origin, var_3) < var_1 - 50) {
      self.ignoreall = 0;
      maps\loki_util::jkuline(var_3 + (-12, 0, 0), var_3 + (12, 0, 0));
      maps\loki_util::jkuline(var_3 + (0, -12, 0), var_3 + (0, 12, 0));
      maps\loki_util::jkuline(var_3 + (0, 0, -12), var_3 + (0, 0, 12));
    } else {
      self.ignoreall = 1;
      maps\loki_util::jkuline(var_3 + (-12, 0, 0), var_3 + (12, 0, 0), (1, 0, 0));
      maps\loki_util::jkuline(var_3 + (0, -12, 0), var_3 + (0, 12, 0), (1, 0, 0));
      maps\loki_util::jkuline(var_3 + (0, 0, -12), var_3 + (0, 0, 12), (1, 0, 0));
    }

    common_scripts\utility::waitframe();
  }
}

movement_input_think(var_0, var_1) {
  level.player endon("death");
  level endon("swept_take_control");

  for(;;) {
    var_2 = level.player getnormalizedmovement();
    var_3 = (var_2[1], var_2[0], var_2[2]);
    maps\loki_util::jkuprint(var_2);
    var_4 = anglestoright(var_0.angles) * (var_2[1] * 100);
    var_5 = anglesToForward(var_0.angles) * (var_2[0] * 100);
    maps\loki_util::jkuline(var_0.origin, var_0.origin + (var_4 + var_5), (0, 1, 1));
    maps\loki_util::jkuline(var_0.origin, var_0.origin + anglestoup(var_0.angles) * 100, (0, 0, 1));

    if(level.allow_movement) {
      for(var_6 = 0.05; length(var_2) > 0.1; var_2 = level.player getnormalizedmovement()) {
        var_4 = anglestoright(var_0.angles) * (var_2[1] * 100);
        var_5 = anglesToForward(var_0.angles) * (var_2[0] * 100);
        maps\loki_util::jkuline(var_0.origin, var_0.origin + (var_4 + var_5), (0, 1, 1));
        var_7 = length(var_2);

        if(var_7 > 1)
          var_7 = 1;

        var_8 = anglestoright(var_0.angles) * (var_2[1] * (var_6 * 2 * var_7));
        var_9 = anglesToForward(var_0.angles) * (var_2[0] * (var_6 * 2 * var_7));
        var_10 = var_0.origin + var_8;

        if(distance2d(var_10, var_1.origin) <= 360) {
          var_0.origin = var_10;
          var_0 linkto(var_1, "tag_player");
        } else
          iprintln("max distance reached");

        if(var_6 != 1)
          var_6 = var_6 + 0.05;

        common_scripts\utility::waitframe();
        var_3 = var_8;
      }

      while(var_6 != 0.01 && length(var_2) < 0.1) {
        if(var_6 != 0.01)
          var_6 = var_6 - 0.01;

        var_10 = var_0.origin + var_3 * (var_6 * 2);

        if(distance2d(var_10, var_1.origin) <= 360) {
          var_0.origin = var_10;
          var_0 linkto(var_1, "tag_player");
        }

        common_scripts\utility::waitframe();
        var_2 = level.player getnormalizedmovement();
      }
    }

    common_scripts\utility::waitframe();
  }
}

moving_cover_cleanup() {
  var_0 = getEntArray("moving_cover_cleanup", "script_noteworthy");
  maps\loki_util::jkuprint(var_0.size + ": moving cover ents cleaned up");
  maps\_utility::array_delete(var_0);
}

lastframe_moving_cover() {
  var_0 = getent("moving_cover_vignette", "targetname");
  var_1 = maps\_utility::spawn_anim_model("moving_cover_obj1");
  var_0 thread maps\_anim::anim_last_frame_solo(var_1, "explosion_part2");
  var_1 maps\loki_util::spawn_and_link_models_to_tags("combat_one_cleanup");
  level.solar_array1.animname = "moving_cover_solar1";
  level.solar_array1 maps\_utility::assign_animtree();
  level.solar_array1 thread maps\_anim::anim_last_frame_solo(level.solar_array1, "explosion_part2_solar1");
  level thread delete_moving_cover_objects();
}

hit_panel(var_0, var_1, var_2, var_3, var_4) {
  level.player endon("death");

  if(!isDefined(var_1))
    var_1 = 0.3;

  if(!isDefined(var_2))
    var_2 = 0.5;

  if(!isDefined(var_3))
    var_3 = 0.5;

  earthquake(var_1, var_2, level.player.origin, 1000);
  level.player shellshock("default_nosound", var_3);

  if(isDefined(var_4) && isalive(level.player)) {
    level.player.og_health = level.player.health;
    level.player.demigod = 1;
    maps\loki_util::jkuprint("faux damage pre: " + level.player.health);
    wait 0.1;
    level.player.demigod = 0;
    maps\loki_util::jkuprint("faux damage post: " + level.player.health);
  }
}

hit_panel_rumble(var_0) {
  var_0 playrumbleonentity("light_1s");
}