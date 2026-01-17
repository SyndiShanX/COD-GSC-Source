/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\carrier_sparrow_run.gsc
****************************************/

run_to_sparrow_pre_load() {
  common_scripts\utility::flag_init("player_knocked_down");
  common_scripts\utility::flag_init("sparrow_run_slowmo_end");
  common_scripts\utility::flag_init("sparrow_run_slowmo");
  common_scripts\utility::flag_init("run_to_sparrow_finished");
  precachestring(&"CARRIER_DEATH_GUNSHIP");
  level.sparrow_run_enemies = [];
  var_0 = getEntArray("sparrow_run_triggers", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_utility::hide_entity);
  level.dmg_rear_elevator = getent("stern_corner_dmg_elevator", "targetname");
  level.dmg_rear_elevator maps\_utility::hide_entity();
  level.slide_card = getent("slide_card", "targetname");
  level.slide_card maps\_utility::hide_entity();
}

setup_run_to_sparrow() {
  level.start_point = "run_to_sparrow";
  common_scripts\utility::flag_set("start_knockdown_moment");
  maps\carrier_code::setup_common();
  maps\carrier_code::spawn_allies();
  thread maps\carrier_audio::aud_check("run_to_sparrow");
  var_0 = getent("water_wake_intro", "targetname");
  var_0 delete();
  maps\_utility::set_team_bcvoice("allies", "delta");
  maps\_utility::battlechatter_on("allies");
  maps\_utility::flavorbursts_on("allies");
  thread maps\carrier_defend_zodiac::elevator_105(1);
  thread maps\carrier::obj_sparrow();
}

begin_run_to_sparrow() {
  level.player thread run_background_sparrow_vehicles();
  level.player thread monitor_sparrow_lookat();
  common_scripts\utility::flag_wait("start_knockdown_moment");
  var_0 = common_scripts\utility::getstruct("sparrow_trans_105_start", "targetname");
  var_1 = common_scripts\utility::getstruct("sparrow_trans_105_dest", "targetname");
  maps\carrier_code::ac130_magic_105_fake(var_0.origin, var_1.origin);
  thread maps\carrier_audio::aud_carr_sparrow_run_hit();
  wait 0.05;
  common_scripts\utility::flag_set("knockdown_moment");
  thread knockback_hesh();
  thread knockback_player();
  thread sparrow_run_enemies();
  common_scripts\utility::exploder(5535);
  thread spawn_deadbodies();
  maps\_utility::delaythread(1, ::swap_destroyed_deck);
  maps\_utility::delaythread(1, maps\carrier_code::phalanx_gun_offline, "crr_phalanx_02");
  maps\_utility::delaythread(2, maps\carrier_code::gunship_line_attack, "gunship_25_sparrow_run_right", 2);
  maps\_utility::delaythread(5, maps\carrier_code::gunship_line_attack, "gunship_25_sparrow_run_left", 2);
  level.defend_sparrow_control maps\_utility::show_entity();
  common_scripts\utility::flag_wait("player_knocked_down");
  common_scripts\utility::flag_set("defend_zodiac_ally_cleanup");
  thread cleanup_zodiacs();
  var_2 = getent("blast_shield1_clip", "targetname");
  var_2 delete();
  var_3 = getent("blast_shield2_clip", "targetname");
  var_3 delete();
  common_scripts\utility::flag_wait("run_to_sparrow_finished");
}

catchup_run_to_sparrow() {
  common_scripts\utility::exploder(5535);
  thread spawn_deadbodies();
  thread swap_destroyed_deck();
  level.defend_sparrow_control maps\_utility::show_entity();
}

knockback_hesh() {
  var_0 = common_scripts\utility::getstruct("sparrow_run_animnode", "targetname");
  var_1 = common_scripts\utility::getstruct("sparrow_run_hesh_start_idle", "targetname");
  var_1 notify("stop_loop");
  var_0 thread maps\_anim::anim_single_solo(level.hesh, "carrier_sparrow_run_hesh");
  var_2 = getanimlength(level.scr_anim["hesh"]["carrier_sparrow_run_hesh"]);
  thread hesh_follow_vo();
  thread run_debris();
  level waittill("player_sliding");
  var_3 = level.hesh getanimtime(level.scr_anim["hesh"]["carrier_sparrow_run_hesh"]);
  var_4 = 8 / var_2;
  var_5 = 10.05 / var_2;
  maps\_utility::delaythread(0, ::hesh_kill_enemy);

  if(var_3 >= var_5) {
    level.hesh hide();
    maps\_anim::anim_set_rate_single(level.hesh, "carrier_sparrow_run_hesh", 0);
    common_scripts\utility::flag_wait("sparrow_run_slowmo");
    maps\_anim::anim_set_rate_single(level.hesh, "carrier_sparrow_run_hesh", 1);
    level.slide_card maps\_utility::delaythread(0.3, maps\_utility::hide_entity);
    var_0 maps\_anim::anim_set_time([level.hesh], "carrier_sparrow_run_hesh", 10.25 / var_2);
    common_scripts\utility::waitframe();
    level.hesh show();
  } else if(var_3 >= var_4) {
    var_6 = 0.2;
    var_7 = 1 - (1 - var_6) * (var_3 - var_4) / (var_5 - var_4);
    thread lerp_hesh_anim_rate(var_7);
  }

  level.hesh waittillmatch("single anim", "end");
  level.hesh maps\_utility::delaythread(0.5, maps\_utility::smart_dialogue, "carrier_hsh_loganwehaveto");
  var_8 = getnode("hesh_sparrow_location", "targetname");
  level.hesh setgoalnode(var_8);
  level.hesh pushplayer(1);
}

lerp_hesh_anim_rate(var_0) {
  var_1 = 0.25;
  var_2 = var_1 * 20;

  for(var_3 = 1; var_3 <= var_2; var_3++) {
    var_4 = 1 - (1 - var_0) * (var_3 / var_2);
    maps\_anim::anim_set_rate_single(level.hesh, "carrier_sparrow_run_hesh", var_4);
    common_scripts\utility::waitframe();
  }

  wait 2;

  for(var_3 = 1; var_3 <= var_2; var_3++) {
    var_4 = var_0 + (1 - var_0) * (var_3 / var_2);
    maps\_anim::anim_set_rate_single(level.hesh, "carrier_sparrow_run_hesh", var_4);
    common_scripts\utility::waitframe();
  }
}

hesh_follow_vo() {
  wait 2.25;
  level.hesh maps\_utility::smart_dialogue("carrier_hsh_weneedtoget");
  wait 1.5;
  level.hesh thread maps\_utility::smart_dialogue("carrier_hsh_getouttatheopen");
}

hesh_kill_enemy() {
  common_scripts\utility::flag_wait("sparrow_run_slowmo");
  wait 0.5;

  if(isalive(level.sparrow_run_enemy_01)) {
    level.sparrow_run_enemy_01 kill();
    level.sparrow_run_enemies = common_scripts\utility::array_remove(level.sparrow_run_enemies, level.sparrow_run_enemy_01);
  }
}

knockback_player() {
  level.player endon("death");
  var_0 = getEntArray("sparrow_run_triggers", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_utility::show_entity);
  screenshake(level.player.origin, 4, 3, 3, 4, 0, 3, 256, 8, 15, 12, 1.8);
  level.player playrumbleonentity("ac130_40mm_fire");
  level.player shellshock("hijack_engine_explosion", 4);
  var_1 = common_scripts\utility::getstruct("sparrow_run_animnode", "targetname");
  var_2 = maps\_utility::spawn_anim_model("player_rig");
  var_3 = maps\_utility::spawn_anim_model("player_legs_rig");
  var_2 hide();
  var_3 hide();
  var_2 dontcastshadows();
  var_3 dontcastshadows();
  level.player setstance("stand");
  level.player playerlinktoblend(var_2, "tag_player", 0.4, 0.25, 0);
  level.player disableweapons();
  level.player freezecontrols(1);
  var_1 thread maps\_anim::anim_single_solo(var_2, "carrier_sparrow_run_player");
  wait 0.4;
  level.player playerlinktodelta(var_2, "tag_player", 1, 5, 5, 5, 5, 1);
  var_2 show();
  common_scripts\utility::flag_set("player_knocked_down");
  thread maps\carrier_defend_sparrow::sparrow_dead_operator();
  var_2 waittillmatch("single anim", "end");
  var_2 hide();
  level.player setstance("stand");
  level.player freezecontrols(0);
  level.player unlink();
  level.player enableweapons();
  thread maps\_utility::autosave_now_silent();
  level.player thread sparrow_run_death();
  var_1 maps\_anim::anim_first_frame_solo(var_2, "carrier_sparrow_slide_player");
  var_1 maps\_anim::anim_first_frame_solo(var_3, "carrier_sparrow_slide_player_legs");
  level.slide_card maps\_utility::show_entity();
  sparrow_run_mantle();
  level notify("player_sliding");
  level.player allowsprint(0);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowjump(0);
  level.player allowmelee(0);
  level.player disableweaponswitch();
  level.player disableoffhandweapons();
  level.player disableweapons();
  level.player.dontmelee = 1;
  level.player playerlinktoblend(var_2, "tag_player", 0.5, 0.4, 0);
  var_1 thread maps\_anim::anim_single_solo(var_2, "carrier_sparrow_slide_player");
  var_1 thread maps\_anim::anim_single_solo(var_3, "carrier_sparrow_slide_player_legs");
  thread maps\carrier_audio::aud_carr_slowmo_slide();
  wait 0.5;
  var_2 show();
  var_3 show();
  level.player playerlinktodelta(var_2, "tag_player", 1, 35, 35, 30, 0);
  level.player thread bumpy_ride();
  wait 1.45;
  level.player enableweapons();
  common_scripts\utility::waitframe();

  if(level.player getcurrentweaponclipammo() < 10)
    level.player setweaponammoclip(level.player getcurrentweapon(), weaponclipsize(level.player getcurrentweapon()));

  var_2 waittillmatch("single anim", "slowmo");
  level.player lerpviewangleclamp(0.5, 0.5, 0, 35, 35, 30, 10);
  maps\_utility::delaythread(0, common_scripts\utility::flag_set, "sparrow_run_slowmo");
  level.player notify("stop_bumpy_ride");
  var_4 = 0.75;
  var_5 = 0.75;
  maps\_utility::slowmo_setspeed_slow(0.2);
  maps\_utility::slowmo_setlerptime_in(var_4);
  maps\_utility::slowmo_lerp_in();
  level.player setperk("specialty_quickdraw", 1, 0);
  level.player setmovespeedscale(0.2);
  thread maps\carrier_audio::aud_carr_slowmo_in();
  thread maps\carrier_audio::aud_carr_slowmo_bg();
  level.player enableslowaim(0.62, 0.62);
  var_2 waittillmatch("single anim", "slowmo_end");
  maps\_utility::slowmo_setlerptime_out(var_5);
  maps\_utility::slowmo_lerp_out();
  level.player unsetperk("specialty_quickdraw", 1);
  thread maps\carrier_audio::aud_carr_slowmo_out();
  level.player disableslowaim();
  level.player disableinvulnerability();
  thread maps\carrier_audio::aud_carr_slowmo_roll();
  maps\_utility::delaythread(0, common_scripts\utility::flag_set, "sparrow_run_slowmo_end");
  var_2 waittillmatch("single anim", "start_clamp");
  level.player lerpviewangleclamp(1, 1, 0, 35, 35, 5, 5);
  var_2 waittillmatch("single anim", "end");
  level.player unlink();
  var_2 delete();
  var_3 delete();
  level.player allowsprint(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowjump(1);
  level.player allowmelee(1);
  level.player enableweaponswitch();
  level.player enableoffhandweapons();
  level.player setmovespeedscale(1);
  level.player.dontmelee = 0;
  common_scripts\utility::flag_wait("defend_sparrow_platform");
  level.player thread gunship_death_sparrow_platform();
  thread gunship_sparrow_platform_loop();
  common_scripts\utility::flag_set("run_to_sparrow_finished");
}

bumpy_ride() {
  self endon("stop_bumpy_ride");
  screenshake(self.origin, 4, 3, 3, 3, 1, 0, 256, 3, 5, 4);
  self enableinvulnerability();

  for(;;) {
    self viewkick(randomintrange(6, 12), level.player.origin);
    wait(randomfloatrange(0.2, 0.5));
  }
}

run_debris() {
  level.hesh waittillmatch("single anim", "debris_anim");
  thread debris();
}

debris() {
  var_0 = common_scripts\utility::getstruct("sparrow_run_animnode", "targetname");
  var_1 = maps\_utility::spawn_anim_model("debris_30");
  var_0 thread debris_chunk(var_1, "crr_metal_chunk_small", "J_prop_1");
  var_0 thread debris_chunk(var_1, "crr_metal_chunk_small", "J_prop_2");
  var_0 thread debris_chunk(var_1, "crr_metal_chunk_small", "J_prop_3");
  var_0 thread debris_chunk(var_1, "crr_metal_chunk_small", "J_prop_4");
  var_0 thread debris_chunk(var_1, "crr_metal_chunk_small", "J_prop_5");
  var_0 thread debris_chunk(var_1, "crr_metal_chunk_medium", "J_prop_6");
  var_0 thread debris_chunk(var_1, "crr_metal_chunk_medium", "J_prop_7");
  var_0 thread debris_chunk(var_1, "crr_metal_chunk_medium", "J_prop_8");
  var_0 thread debris_chunk(var_1, "crr_metal_chunk_medium", "J_prop_9");
  var_0 thread debris_chunk(var_1, "crr_metal_chunk_large", "J_prop_10");
  var_0 thread debris_chunk(var_1, "crr_metal_chunk_medium", "J_prop_11");
  var_0 thread debris_chunk(var_1, "crr_metal_chunk_medium", "J_prop_12");
  var_0 maps\_anim::anim_single_solo(var_1, "carrier_sparrow_slide_debris");
}

debris_chunk(var_0, var_1, var_2) {
  var_3 = spawn("script_model", (0, 0, 0));
  var_3 setModel(var_1);
  var_3 linkto(var_0, var_2, (0, 0, 0), (0, 0, 0));
  var_0 waittillmatch("single anim", "end");
  var_3 delete();
}

sparrow_run_enemies() {
  level waittill("player_sliding");
  maps\_utility::array_spawn_function_targetname("sparrow_run_enemy_01", ::sparrow_run_enemy_logic, 10, undefined, "rescue_enemy_breach_run_1");
  maps\_utility::array_spawn_function_targetname("sparrow_run_enemy_03", ::sparrow_run_enemy_03_logic, 10, undefined, "rescue_enemy_breach_run_3");
  maps\_utility::array_spawn_function_targetname("sparrow_run_enemy_climbover", ::climbover_enemy);
  maps\_utility::array_spawn_function_targetname("sparrow_run_enemy_plat", ::sparrow_run_enemy_logic, undefined, "sparrow_run_enemy_plat_node", "carrier_rappel_defend_ascend_exit_left", 0);
  maps\_utility::array_spawn_function_targetname("sparrow_run_enemy_plat", ::enemy_plat_death);
  var_0 = maps\_utility::spawn_targetname("sparrow_run_enemy_climbover", 1);
  thread execute();
  level.sparrow_run_enemy_01 = maps\_utility::spawn_targetname("sparrow_run_enemy_01", 1);
  var_1 = maps\_utility::spawn_targetname("sparrow_run_enemy_03", 1);
  var_2 = maps\_utility::spawn_targetname("sparrow_run_enemy_plat", 1);
  level.sparrow_run_enemies = common_scripts\utility::array_remove(level.sparrow_run_enemies, var_2);
  common_scripts\utility::flag_wait("sparrow_run_slowmo_end");

  foreach(var_4 in level.sparrow_run_enemies) {
    if(isalive(var_4))
      var_4 stopanimscripted();
  }

  wait 5;
  thread maps\_utility::autosave_tactical();
}

execute() {
  var_0 = maps\_utility::spawn_targetname("sparrow_run_enemy_02", 1);
  level.sparrow_run_enemies = common_scripts\utility::array_add(level.sparrow_run_enemies, var_0);
  var_0.animname = "generic";
  var_0.allowdeath = 1;
  var_0.accuracy = 0.1;
  var_0.health = 10;
  var_0 animscripts\notetracks::notetrackpistolpickup();
  var_0 thread maps\_anim::anim_generic_first_frame(var_0, "carrier_sparrow_slide_enemy2");
  level.slowmo_ally = maps\_utility::spawn_targetname("sparrow_run_ally_execute", 1);
  level.slowmo_ally maps\_anim::anim_generic_first_frame(level.slowmo_ally, "covercrouch_death_3");
  level.slowmo_ally.ignoreme = 1;
  level.slowmo_ally.allowdeath = 1;
  level.slowmo_ally maps\_utility::magic_bullet_shield(1);
  level.slowmo_ally maps\_utility::disable_pain();
  level.slowmo_ally.a.nodeath = 1;
  level.slowmo_ally.noragdoll = 1;
  level.slowmo_ally.isadeadman = 0;
  level.slowmo_ally endon("death");
  thread execute_save(var_0);
  common_scripts\utility::flag_wait("sparrow_run_slowmo");
  level.slowmo_ally maps\_utility::stop_magic_bullet_shield();

  if(isalive(var_0)) {
    maps\_anim::anim_set_rate([var_0], "carrier_sparrow_slide_enemy2", 1);
    var_0 waittillmatch("single anim", "fire");
    var_0 shoot();
    level.slowmo_ally.isadeadman = 1;
    level.slowmo_ally thread maps\_anim::anim_generic(level.slowmo_ally, "covercrouch_death_3");
    level.slowmo_ally waittillmatch("single anim", "start_ragdoll");
    level.slowmo_ally kill();
  }
}

execute_save(var_0) {
  var_0 waittill("death");

  if(isDefined(level.slowmo_ally) && !level.slowmo_ally.isadeadman) {
    level.slowmo_ally.ignoreme = 0;
    level.slowmo_ally.a.nodeath = 0;
    level.slowmo_ally.noragdoll = 0;
    level.slowmo_ally endon("death");
    level.slowmo_ally maps\_utility::enable_pain();
    level.slowmo_ally stopanimscripted();
    level.slowmo_ally maps\_anim::anim_generic(level.slowmo_ally, "covercrouch_run_out_ML");
    wait 3;
    var_1 = getnode("saved_grape_sparrow_location", "targetname");
    level.slowmo_ally setgoalnode(var_1);
    level.slowmo_ally pushplayer(1);
    common_scripts\utility::flag_wait("sparrow_hud_black");

    if(isalive(level.slowmo_ally))
      level.slowmo_ally delete();
  }
}

climbover_enemy() {
  level.sparrow_run_enemies = common_scripts\utility::array_add(level.sparrow_run_enemies, self);
  self.animname = "generic";
  self.health = 10;
  self.allowdeath = 1;
  self.accuracy = 0.1;
  self endon("death");
  var_0 = common_scripts\utility::getstruct("sparrow_run_animnode_climbover", "targetname");
  var_0 thread maps\_anim::anim_generic(self, "carrier_sparrow_slide_enemy");
}

sparrow_run_enemy_logic(var_0, var_1, var_2, var_3) {
  self endon("death");
  level.sparrow_run_enemies = common_scripts\utility::array_add(level.sparrow_run_enemies, self);
  self.animname = "generic";
  self.allowdeath = 1;
  self.accuracy = 0.1;

  if(isDefined(var_0))
    self.health = var_0;

  if(isDefined(var_1))
    var_4 = common_scripts\utility::getstruct(var_1, "targetname");
  else {
    var_4 = spawnStruct();
    var_4.origin = self.origin;
    var_4.angles = self.angles;
  }

  self animmode("nogravity");
  var_4 maps\_anim::anim_generic_first_frame(self, var_2);
  common_scripts\utility::flag_wait("sparrow_run_slowmo");

  if(isDefined(var_3))
    wait(var_3);

  self animmode("gravity");
  var_4 thread maps\_anim::anim_generic(self, var_2);
}

sparrow_run_enemy_03_logic(var_0, var_1, var_2) {
  self endon("death");
  level.sparrow_run_enemies = common_scripts\utility::array_add(level.sparrow_run_enemies, self);
  self.animname = "generic";
  self.allowdeath = 1;
  self.accuracy = 0.0001;

  if(isDefined(var_0))
    self.health = var_0;

  if(isDefined(var_1))
    var_3 = common_scripts\utility::getstruct(var_1, "targetname");
  else {
    var_3 = spawnStruct();
    var_3.origin = self.origin;
    var_3.angles = self.angles;
  }

  self animmode("nogravity");
  var_3 thread maps\_anim::anim_generic(self, var_2);
  common_scripts\utility::waitframe();
  maps\_anim::anim_set_time([self], var_2, 0.1);
  maps\_anim::anim_set_rate_single(self, var_2, 0);
  common_scripts\utility::flag_wait("sparrow_run_slowmo");
  maps\_utility::set_favoriteenemy(level.player);
  self animmode("gravity");
  maps\_anim::anim_set_rate_single(self, var_2, 1);
  wait 1;
  self stopanimscripted();
  common_scripts\utility::flag_wait("sparrow_run_slowmo_end");
  self.accuracy = 0.1;
}

enemy_plat_death() {
  self waittill("death");
  self startragdoll();
}

sparrow_run_mantle() {
  maps\carrier_code::setup_mantle_hint();
  level.player.looking_at_mantle = 0;
  var_0 = getent("sparrow_run_mantle", "targetname");
  var_0 thread maps\carrier_code::player_volume_check();
  var_1 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_1 thread maps\carrier_code::player_check_mantle_lookat();

  for(;;) {
    if(level.player istouching(var_0) && level.player.looking_at_mantle) {
      maps\carrier_code::show_mantle_hint();
      level.player maps\carrier_code::player_check_jump();
    }

    if(!level.player istouching(var_0) || !level.player.looking_at_mantle) {
      maps\carrier_code::hide_mantle_hint();
      wait 0.05;
      continue;
    }

    maps\carrier_code::hide_mantle_hint();
    level.player notify("stop_mantle_lookat");
    level.player allowjump(0);
    var_2 = distance2d(var_1.origin, level.player.origin);
    var_3 = int(var_2 / 60) * 0.05;
    wait(var_3);
    level.player allowjump(1);
    return;
  }
}

sparrow_run_death() {
  level endon("player_sliding");
  level endon("left_area");
  self endon("death");
  var_0 = getEntArray("sparrow_run_kill", "targetname");
  var_1 = 0;

  for(;;) {
    foreach(var_3 in var_0) {
      if(self istouching(var_3)) {
        var_4 = vectornormalize(anglesToForward(level.player.angles)) * 90;
        magicbullet("ac130_25mm_carrier", self.origin + (0, 0, 400), self.origin + var_4 + (0, 0, 24));
        wait 0.2;
        setdvar("ui_deadquote", &"CARRIER_DEATH_GUNSHIP");
        maps\_utility::missionfailedwrapper();
        self kill();
        level notify("left_area");
      }
    }

    if(var_1 >= 8.0) {
      var_4 = vectornormalize(anglesToForward(level.player.angles)) * 80;
      magicbullet("ac130_25mm_carrier", self.origin + (0, 0, 400), self.origin + var_4 + (0, 0, 24));
      wait 0.2;
      setdvar("ui_deadquote", &"CARRIER_DEATH_GUNSHIP");
      maps\_utility::missionfailedwrapper();
      self kill();
      level notify("left_area");
    }

    wait 0.05;
    var_1 = var_1 + 0.05;
  }
}

spawn_deadbodies() {
  maps\carrier_code::array_spawn_targetname_allow_fail("sparrow_transition_body", 1);
}

run_background_sparrow_vehicles() {
  thread maps\carrier_defend_sparrow::spawn_ac130();
  thread maps\carrier_defend_sparrow::spawn_pre_sparrow_helis();
}

monitor_sparrow_lookat() {
  var_0 = getent("sparrow_background_look", "targetname");

  while(!level.player worldpointinreticle_circle(var_0.origin, 65, 250))
    common_scripts\utility::waitframe();

  self notify("looking_away");
}

swap_destroyed_deck() {
  common_scripts\utility::array_thread(level.stern_corner_clean, maps\_utility::hide_entity);

  foreach(var_1 in level.stern_corner_dmg)
  var_1.origin = var_1.origin - (0, 0, 1024);

  common_scripts\utility::array_thread(level.stern_corner_dmg, maps\_utility::show_entity);
  level.rear_elevator maps\_utility::hide_entity();
  level.dmg_rear_elevator maps\_utility::show_entity();
  common_scripts\utility::array_thread(level.elevator_dmg_models, maps\carrier_code::show_and_raise_entity);
  maps\_utility::array_delete(level.rear_elevator.attachments);
  maps\_utility::array_delete(level.elevator_ac130_dmg);
  common_scripts\utility::array_thread(level.elevator_ac130_dmg_02, maps\carrier_code::show_and_raise_entity);
}

fx_fires() {
  maps\carrier_fx::playfx_targetname_endon("sparrow_trans_fx_fire", "fire_line_sm", "defend_sparrow_finished");
}

cleanup_zodiacs() {
  level.zodiacs = maps\_utility::array_removedead(level.zodiacs);

  foreach(var_1 in level.zodiacs)
  maps\_utility::deleteent(var_1);

  level.zodiacs = [];
}

gunship_sparrow_platform_loop() {
  level endon("player_entering_sparrow");
  level.player endon("death");

  for(;;) {
    maps\carrier_code::gunship_line_attack("gunship_25_sparrow_plat_01");
    wait(randomfloatrange(0.5, 2));
    maps\carrier_code::gunship_line_attack("gunship_25_sparrow_plat_02");
    wait(randomfloatrange(0.5, 2));
  }
}

gunship_death_sparrow_platform() {
  level endon("player_entering_sparrow");
  self endon("death");
  var_0 = getEntArray("gunship_sparrow_plat_kill", "targetname");
  var_1 = 0;
  var_2 = 0;

  for(;;) {
    foreach(var_4 in var_0) {
      if(self istouching(var_4)) {
        level.ac_130 maps\_utility::delaythread(0, maps\carrier_code::ac130_magic_bullet, "40mm", level.player.origin + anglesToForward(level.player getplayerangles()) * 200);
        level.ac_130 maps\_utility::play_sound_on_entity("ac130_40mm_fire_npc");
        maps\carrier_code::gunship_line_attack_death();
        wait 1;

        if(isalive(self)) {
          setdvar("ui_deadquote", &"CARRIER_DEATH_GUNSHIP");
          maps\_utility::missionfailedwrapper();
          self kill();
        }
      }
    }

    if(!var_2 && common_scripts\utility::flag("mantled_sparrow_plat")) {
      var_2 = 1;
      var_1 = var_1 - 10;
    }

    if(var_1 >= 20.0) {
      maps\carrier_code::gunship_line_attack_death();
      wait 1;
      setdvar("ui_deadquote", &"CARRIER_DEATH_GUNSHIP");
      maps\_utility::missionfailedwrapper();
      self kill();
    }

    wait 0.05;
    var_1 = var_1 + 0.05;
  }
}