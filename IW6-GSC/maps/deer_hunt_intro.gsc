/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\deer_hunt_intro.gsc
*****************************************************/

intro_setup() {
  level.player takeallweapons();
  level.player freezecontrols(1);
  thread move_player_to_start("intro_player_start");
  thread deer_init();
  thread lobby_ruckus();
  thread intro_enemies();
  thread crouch_hint();
  spawn_hesh_and_dog();
  common_scripts\utility::flag_wait("friendlies_spawned");
  thread intro_vo();
  thread intro_fx();
  thread team2_nav_logic();
  thread intro_scene();
  thread maps\deer_hunt_util::do_bokeh("lobby_exit_approach");
  var_0 = getEntArray("deer_ruckus", "script_noteworthy");
  common_scripts\utility::array_thread(var_0, ::deer_ruckus_trig_logic);
  common_scripts\utility::flag_wait_any("pipe_enter", "player_rushed_lariver");
  thread lariver_global_setup();
}

crouch_hint() {
  if(maps\deer_hunt_util::gameskill_is_difficult()) {
    return;
  }
  common_scripts\utility::flag_wait("player_up");
  var_0 = getent("player_approaching_stage", "targetname");
  var_1 = 30625;

  while(distance2dsquared(level.player.origin, var_0.origin) > var_1)
    wait 0.25;

  thread maps\_utility::display_hint_timeout("crouch_hint", 5);
}

player_control() {
  switch (level.start_point) {
    case "default":
    case "intro":
      level.player maps\_utility::blend_movespeedscale_percent(25, 0.1);
      level.player allowsprint(0);
      common_scripts\utility::flag_wait("player_up");
      level.player maps\_utility::blend_movespeedscale_percent(65, 0.1);
      common_scripts\utility::flag_wait("hallway_halfway");
      level.player allowsprint(1);
      common_scripts\utility::flag_wait("screen_arrive");
      wait 2;
      level.player maps\_utility::blend_movespeedscale_percent(85, 0.1);
    case "lariver":
    case "encounter2":
    case "encounter1":
    case "street":
    case "lobby":
      common_scripts\utility::flag_wait("pipe_exit");
    case "lariver_defend":
      level.player maps\_utility::blend_movespeedscale_percent(95, 0.1);
    case "ride":
    case "lariver_exit":
      common_scripts\utility::flag_wait("player_exited_jeep");
    case "house":
      level.player maps\_utility::blend_movespeedscale_percent(50, 0.1);
      wait 0.05;
    case "elias":
  }
}

intro_scene_player() {
  var_0 = getent("player_gate", "targetname");
  var_1 = (-7499.94, 9432.14, -345.875);
  var_2 = (0, 57.7601, 0);
  level.player setorigin(var_1);
  level.player setplayerangles(var_2);
  level.player setstance("crouch");
  level.player allowstand(0);
  level.player allowprone(0);
  thread intro_player_blur();
  common_scripts\utility::flag_wait("introscreen_complete");
  wait 0.5;
  level.player freezecontrols(0);
  level.player allowstand(1);
  level.player allowprone(1);
  common_scripts\utility::flag_wait("intro_ruckus");
  var_0 delete();
  wait 1;

  if(level.player getstance() != "stand")
    level.player setstance("stand");

  common_scripts\utility::flag_wait("player_up");
  var_3 = ["honeybadger+acog_sp", "m9a1", "fraggrenade"];
  maps\deer_hunt_util::arm_player(var_3);
  wait 3;

  if(isDefined(var_0))
    var_0 delete();
}

intro_player_blur() {
  setblur(2, 0.05);
  common_scripts\utility::flag_wait("introscreen_complete");
  wait 2;
  setblur(0, 0.5);
  wait 1;
  setblur(1.2, 0.5);
  wait 1;
  setblur(0, 0.5);
  wait 1.5;
  setblur(1.2, 0.5);
  wait 1;
  setblur(0, 0.5);
}

set_player_speed(var_0) {
  level.current_speed_percent = var_0;
  level.player setmovespeedscale(var_0);
}

intro_vo() {
  switch (level.start_point) {
    case "default":
    case "intro":
      common_scripts\utility::flag_wait("introscreen_complete");
      common_scripts\utility::flag_set("intro_fade_in");
      wait 8;
      thread common_scripts\utility::play_sound_in_space("scn_deer_ruckus_01", (-7634, 9926, -286));
      wait 0.5;
      common_scripts\utility::flag_set("intro_ruckus");
      wait 0.4;
      level.dog maps\deer_hunt_util::dog_growl();
      wait 1.1;
      wait 7;
      common_scripts\utility::flag_set("player_up");
      wait 2;
      wait 1.5;
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_teamtwoareyou");
      wait 1;
      level.player maps\_utility::play_sound_on_entity("deerhunt_us1_negativewereoutside");
      level.player maps\_utility::play_sound_on_entity("deerhunt_us1_youboysgotsomethin");
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_rileydoes");
      wait 0.5;
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_werecheckinitnow");
      wait 0.25;
      level.player maps\_utility::play_sound_on_entity("deerhunt_us1_rogwellsecurethe");
      common_scripts\utility::flag_wait("curtain_cut");
      common_scripts\utility::flag_wait("through_screen");
      wait 2;
      var_0 = spawn("script_origin", (-8928, 10464, -368));
      var_0 playSound("scn_deer_birds_flyaway_chips");
      var_0 moveto((-8784, 10560, 16), 1);
      common_scripts\utility::flag_set("exit_theater");
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_coverme");
      wait 8;

      if(level.player.origin[2] < -190)
        level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_itsclearcomeon");

      common_scripts\utility::flag_wait("theater_exit");
      thread common_scripts\utility::play_sound_in_space("scn_deer_ruckus_03", (-9313, 11456, -18));
      thread maps\deer_hunt_util::play_loop_sound_in_space_stop_on_flag("scn_deer_ruckus_loop", (-8951, 12053, -138), "lobby_entrance");
      wait 1;
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_thatsclose");
      common_scripts\utility::flag_wait("to_lobby_entrance");
    case "lobby":
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_takethedooron");
      common_scripts\utility::flag_wait("lobby_entrance");
      wait 4;
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_hehguessrileywas");
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_youdontwannaeat");
      common_scripts\utility::flag_wait("lobby_exit");
      maps\_utility::autosave_by_name_silent("theater_exit");
    case "outside":
      wait 2;
      level.player maps\_utility::play_sound_on_entity("deerhunt_us1_sixonesitrep");
      wait 0.6;
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_justsomelocalwildlife");
      level.player maps\_utility::play_sound_on_entity("deerhunt_us1_check");
      wait 0.2;
      level.player maps\_utility::play_sound_on_entity("deerhunt_us1_weremovingup");
      wait 0.5;
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_yeahwelljoinya");
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_meetusatthe");
      wait 0.15;
      level.player maps\_utility::play_sound_on_entity("deerhunt_us1_rog");
      common_scripts\utility::flag_wait("promenade_exit");
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_sigholdfaithful");
    case "street":
      common_scripts\utility::flag_wait("road_chasm_approach");
      common_scripts\utility::flag_wait("meetup_completed");
      common_scripts\utility::flag_set("hesh_to_shop_door");
    case "encounter1":
      maps\_utility::autosave_by_name_silent("shop_approach");
      common_scripts\utility::flag_wait("encounter1_affection_started");
      level.dog maps\deer_hunt_util::dog_growl();
      wait 0.5;
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_rileyrileysearch");
      common_scripts\utility::flag_wait("player_at_shop_door");
      thread common_scripts\utility::play_sound_in_space("stealth_2_huh", (-13290.7, 14145.4, -212));
      wait 1.5;
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_youhearthatsomeones");
      thread common_scripts\utility::play_sound_in_space("stealth_2_huh", (-13290.7, 14145.4, -212));
      wait 0.5;
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_waitforcairoif");
      common_scripts\utility::flag_wait("shop_exit");
      maps\_utility::autosave_by_name("encounter1_approach");
      common_scripts\utility::flag_wait("dog_kill_started");
      wait 1;
      level.hesh maps\_utility::smart_radio_dialogue("deerhunt_hsh_droptheseguys");
      common_scripts\utility::flag_wait_any("dog_attack_enemies_dead", "player_rushed_gas_station");
      wait 1;
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_dogcall_3");
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_rileystay_2");
      wait 0.5;
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_fedreconagain");
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_thatsfivethismonth");
      wait 0.2;
      common_scripts\utility::flag_set("hesh_moves_from_encounter1");
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_twoonewejust");
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_meetusatoverwatch");
      level.team2[0] maps\_utility::smart_radio_dialogue("deerhunt_us1_checkwereonour");
      common_scripts\utility::flag_wait("player_at_encounter1");
      wait 2;
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_dogcall_1");
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_rileyhere");
    case "encounter2":
      common_scripts\utility::flag_wait("hesh_to_lookout");
      level.team2[1] maps\_utility::smart_dialogue_generic("deerhunt_us2_holyshit");
      common_scripts\utility::flag_wait_any("bully_kick_victim_dead", "bully_kick_aborted", "bully_kick_complete", "player_dropped_down", "civilians_shot");
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_theyreexecutingcivvies");
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_rileygo");
      common_scripts\utility::flag_wait("gasstation_clear");
      wait 2;
      level.hesh maps\_utility::smart_radio_dialogue("deerhunt_hsh_thisway_2");
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_dogcall_2");
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_rileyfollow");
      maps\_utility::battlechatter_off();
      level.player maps\_utility::play_sound_on_entity("deerhunt_us3_allavailableunitswe");
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_creepersixonesgotyou");
      level.player maps\_utility::play_sound_on_entity("deerhunt_us3_rogerthatpoppinggreen");
      maps\_utility::battlechatter_on();
      common_scripts\utility::flag_wait("pipe_enter");
      maps\_utility::autosave_by_name("pipe_enter");
      wait 4;
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_pushtothewall");
    case "lariver":
      common_scripts\utility::flag_wait("player_under_bridge");
      maps\_utility::smart_radio_dialogue("deerhunt_hsh_friendliesatthegreen");
      wait 3;
      maps\_utility::smart_radio_dialogue("deerhunt_hsh_thatsfriendliesatthe");
      common_scripts\utility::flag_wait("squad_to_defend");
      wait 3;
      level.balcony_friendlies[0] maps\_utility::smart_dialogue_generic("deerhunt_us3_morebirdsinbound");
      level.hesh maps\_utility::smart_radio_dialogue("deerhunt_hsh_thisway_2");
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_riley");
    case "lariver_defend":
      wait 1;
      maps\_utility::smart_radio_dialogue("deerhunt_hsh_logangrabalauncher");
      common_scripts\utility::flag_wait("player_in_defend_area");
      common_scripts\utility::flag_wait("drag_complete");
      common_scripts\utility::flag_wait("chopper_fight_start");
      wait 3;
      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_loganusetheguided");
      common_scripts\utility::flag_wait("lariver_defend_bridge_clear");
    case "lariver_exit":
      wait 2;
      level.team2[1] maps\_utility::smart_dialogue_generic("deerhunt_us1_clear");
      level.team2[0] maps\_utility::smart_dialogue_generic("deerhunt_us2_wereclear");
      wait 1;
      maps\deer_hunt_util::hesh_line("deerhunt_hsh_corporalholmesyoureon");
      level.team2[0] maps\_utility::smart_dialogue_generic("deerhunt_us1_rogercommandeeringfor");
      maps\deer_hunt_util::hesh_line("deerhunt_hsh_loganyoureonsecurity");
    case "ride":
      common_scripts\utility::flag_wait("jeep_arrived");
      level.driver maps\_utility::smart_dialogue_generic("deerhunt_us3_thisisussergeant");
    case "house":
  }
}

intro_vo_team2_chopper_convo() {
  common_scripts\utility::flag_wait("ambient_chopper_shoots_wall");
  wait 3;
  level.team2[1] maps\_utility::smart_dialogue_generic("deerhunt_us2_shitwheredidthat");
  wait 0.5;
  level.team2[0] maps\_utility::smart_dialogue_generic("deerhunt_us1_couldnthearituntil");
}

intro_fx() {
  switch (level.start_point) {
    case "default":
    case "street":
    case "outside":
    case "lobby":
    case "intro":
      common_scripts\utility::flag_wait("dropdown_arrive");
      common_scripts\utility::exploder("street_start_birds");
    case "ride":
    case "lariver":
    case "encounter2":
    case "encounter1":
  }
}

flashlight_on() {
  wait 1;
  self endon("death");
  self.flashlight_tag_origin = common_scripts\utility::spawn_tag_origin();
  self.flashlight_tag_origin.origin = self gettagorigin("tag_flash");
  self.flashlight_tag_origin.angles = self gettagangles("tag_flash");
  wait 0.05;
  self.flashlight_tag_origin linkto(self, "tag_flash");
  wait 0.1;
  playFXOnTag(common_scripts\utility::getfx("flashlight"), self.flashlight_tag_origin, "tag_origin");
}

flashlight_off() {
  if(isDefined(self.flashlight_tag_origin))
    stopFXOnTag(common_scripts\utility::getfx("flashlight"), self.flashlight_tag_origin, "tag_origin");
}

team2_nav_logic() {
  common_scripts\utility::flag_wait("road_chasm_approach");
  spawn_team2();
  level.team2[1].colornode_setgoal_func = ::hesh_does_360;
  var_0 = common_scripts\utility::getstruct("meetup", "targetname");
  var_1 = [level.hesh, level.team2[0]];
  level.hesh.animname = "generic";
  level.team2[0].animname = "guy2";
  level.team2[0] maps\_utility::disable_ai_color();
  common_scripts\utility::flag_wait("outside_360_complete");
  level.hesh maps\_utility::disable_ai_color();
  var_0 maps\_anim::anim_reach_together(var_1, "meetup");
  common_scripts\utility::flag_set("meetup_started");
  thread common_scripts\utility::trigger_off("road_chasm_approach", "targetname");
  common_scripts\utility::array_thread(var_1, maps\_utility::delaythread, 3, maps\_utility::enable_ai_color);
  var_0 maps\_anim::anim_single(var_1, "meetup");
  common_scripts\utility::flag_set("meetup_completed");

  if(!common_scripts\utility::flag("player_on_bus"))
    maps\_utility::activate_trigger_with_targetname("team2_covers_chasm");
}

spawn_team2() {
  maps\_utility::array_spawn_function_targetname("team2", ::lariver_team2_logic);
  level.team2 = maps\_utility::array_spawn_targetname("team2", 1);
  level.team2[0].name = "Cpl. Davis";
}

spawn_hesh_and_dog() {
  getent("hesh", "targetname") maps\_utility::add_spawn_function(::hesh_logic);
  level.hesh = maps\_utility::spawn_targetname("hesh", 1);
  getent("dog", "targetname") maps\_utility::add_spawn_function(::dog_logic);
  level.dog = maps\_utility::spawn_targetname("dog", 1);
  level.dog.name = "Riley";
  level.squad = [level.hesh, level.dog];
  maps\_utility::battlechatter_off("allies");
  maps\_utility::flavorbursts_off("allies");
  common_scripts\utility::flag_set("friendlies_spawned");
}

sniff_system_init() {
  while(!isDefined(level.dog))
    wait 0.05;

  common_scripts\utility::flag_wait("introscreen_complete");
  wait 1;
  var_0 = common_scripts\utility::getStructArray("dog_sniff", "targetname");

  foreach(var_2 in var_0) {
    var_3 = spawn("script_origin", var_2.origin);
    var_3.targetname = "dog_sniff";
  }

  var_5 = getEntArray("dog_sniff", "targetname");
  var_6 = getEntArray("sniff_zone", "script_noteworthy");

  foreach(var_8 in var_6)
  var_8 sniff_assign_structs_to_volume(var_5);

  level.current_sniff_zone = undefined;
  var_10 = getEntArray("sniff_trig", "targetname");
  common_scripts\utility::array_thread(var_10, ::sniff_trig_logic);
  common_scripts\utility::array_call(var_5, ::delete);
  common_scripts\utility::flag_wait("promenade_exit");
  common_scripts\utility::array_thread(var_10, common_scripts\utility::trigger_off);
  common_scripts\utility::flag_wait("player_in_jeep");
  common_scripts\utility::array_thread(var_10, common_scripts\utility::trigger_on);
}

sniff_trig_logic() {
  self.did_riley_call = 0;

  for(;;) {
    self waittill("trigger");
    var_0 = getent(self.target, "targetname");

    if(!isDefined(level.current_sniff_zone))
      level.current_sniff_zone = var_0;
    else if(level.current_sniff_zone == var_0) {
      wait 2;
      continue;
    }

    level.current_sniff_zone = var_0;
    level.dog maps\_utility_dogs::disable_dog_sniff();

    if(maps\deer_hunt_util::has_script_noteworthy("walk"))
      level.dog maps\_utility_dogs::enable_dog_walk(1);
    else
      level.dog maps\_utility_dogs::disable_dog_walk();

    if(isDefined(self.script_index)) {
      if(!self.did_riley_call) {
        self.did_riley_call = 1;
        level.hesh maps\deer_hunt_util::call_riley(undefined, 1);
      }
    }

    level.dog thread dog_sniff_spots(level.current_sniff_zone.sniff_spots);
    wait 2;
  }
}

sniff_assign_structs_to_volume(var_0) {
  self.sniff_spots = [];

  foreach(var_3, var_2 in var_0) {
    if(var_2 istouching(self))
      self.sniff_spots[var_3] = var_2.origin;
  }
}

dog_logic() {
  level thread sniff_system_init();
  self endon("deleted");
  self.animname = "generic";
  self.meleealwayswin = 1;
  self.ignoreme = 1;
  thread maps\_utility::magic_bullet_shield();
  maps\_utility::disable_ai_color();
  maps\deer_hunt_util::ignore_me_ignore_all();
  self.goalradius = 32;

  switch (level.start_point) {
    case "default":
    case "intro":
      common_scripts\utility::flag_wait("introscreen_complete");
      thread maps\_utility_dogs::dog_pant_think();
      common_scripts\utility::flag_wait("curtain_cut");
      thread dog_jump_up_sound();
    case "lobby":
      common_scripts\utility::flag_wait("lobby_entrance");
      wait 2.5;
      maps\_utility_dogs::dog_bark();
      wait 0.5;
      maps\_utility_dogs::dog_bark();
    case "outside":
      common_scripts\utility::flag_wait("lobby_exit");
      var_0 = getent("bark", "targetname");

      while(!self istouching(var_0))
        wait 0.5;

      maps\_utility_dogs::dog_bark();
      wait 0.5;
      maps\_utility_dogs::dog_bark();
    case "street":
      common_scripts\utility::flag_wait("promenade_exit");
      self notify("stop_sniffing");
      maps\_utility_dogs::disable_dog_sniff();
      var_1 = getnode("dog_stay", "targetname");
      self setgoalnode(var_1);
      thread dog_jump_up_sound();
      self waittill("goal");
      maps\_utility_dogs::enable_dog_sniff();
      common_scripts\utility::flag_wait("hesh_to_shop_door");
      self notify("stop_sniffing");
      maps\_utility_dogs::disable_dog_sniff();
    case "encounter1":
      var_1 = getnode("dog_outside_shop", "targetname");
      self.goalradius = 20;
      self setgoalnode(var_1);
      thread maps\deer_hunt_util::dog_node_wait(var_1, "dog_in_affection_position");
      common_scripts\utility::flag_wait("player_out_of_chasm");
      var_2 = getent("dropdown_blocker", "targetname");
      var_2.origin = var_2.origin + (0, 0, 400);
      var_2 connectpaths();
      wait 0.05;
      var_2 delete();
      common_scripts\utility::flag_wait("encounter1_affection_done");
      common_scripts\utility::flag_wait("player_at_shop_door");
      maps\_utility_dogs::enable_dog_sneak();
      common_scripts\utility::flag_wait("player_entered_coffee_shop");
      maps\_utility_dogs::disable_dog_sneak();
      common_scripts\utility::flag_wait("back_enemies_fight_begin");
      wait 3;

      while(getaiarray("axis").size > 2)
        wait 0.5;

      level.hesh maps\_utility::smart_dialogue_generic("deerhunt_hsh_rileygo");
      var_1 = getnode("riley_flank", "targetname");
      self.goalradius = 32;
      maps\_utility::disable_ai_color();
      self setgoalnode(var_1);
      self waittill("goal");
      self.ignoreall = 0;
      common_scripts\utility::flag_wait("dog_attack_enemies_dead");
      self setgoalpos(self.origin);
      wait 7;
      maps\deer_hunt_util::clear_dog_master();
      maps\_utility::enable_ai_color();
      maps\deer_hunt_util::ignore_me_ignore_all();
    case "encounter2":
      common_scripts\utility::flag_wait("execution_start");
    case "lariver":
      common_scripts\utility::flag_wait("pipe_halfway");
      maps\deer_hunt_util::ignore_me_ignore_all();
      maps\_utility::disable_pain();
    case "ride":
      common_scripts\utility::flag_wait("player_exited_jeep");
      self pushplayer(1);
  }
}

dog_jump_up_sound() {
  self waittill("traverseAnim");
  maps\_utility::play_sound_on_entity("scn_deer_dog_jump_on_car");
}

dog_stays_in_front_of_player() {
  maps\_utility::ent_flag_init("override_follow_logic");
  self endon("stop_following_player");
  self.goalradius = 32;
  self.animname = "generic";
  var_0 = level.player getplayerangles();
  var_0 = (0, var_0[1], 0);
  var_1 = anglesToForward(var_0);
  var_2 = var_1 * 375;
  var_3 = level.player.origin + var_2;
  level.target_ent = spawn("script_origin", var_3);
  level.target_ent.angles = (0, var_0[1], 0);
  level.target_ent linkto(level.player);
  var_4 = common_scripts\utility::getStructArray("sniff_spots", "targetname");
  maps\_utility_dogs::disable_dog_sniff();

  for(;;) {
    if(maps\_utility::ent_flag("override_follow_logic")) {
      wait 0.1;
      continue;
    }

    var_5 = maps\_utility::groundpos(level.target_ent.origin);
    var_6 = distance2d(self.origin, var_5);

    if(var_6 > 75) {
      self notify("moving_up");
      var_7 = common_scripts\utility::get_array_of_closest(var_5, var_4, undefined, 5, 200, 0);

      if(maps\deer_hunt_util::array_is_greater_than(var_7, 0))
        thread dog_sniff_spots(var_7);
      else {
        iprintln("No sniff spots");
        self setgoalpos(var_5);
      }

      var_8 = 6;

      if(level.console)
        var_9 = maps\deer_hunt_util::waittill_player_moves_or_timeout_controller(var_8);
      else
        var_9 = maps\deer_hunt_util::waittill_player_moves_or_timeout_kb(var_8);

      iprintln("Moving up because of " + var_9);
    }

    wait 0.15;
  }
}

dog_sniff_spots(var_0) {
  self notify("new_spots");
  self endon("new_spots");
  self endon("stop_sniffing");
  var_1 = common_scripts\utility::random(var_0);
  self setgoalpos(var_1);

  while(distance2dsquared(self.origin, var_1) > 5625)
    wait 0.25;

  maps\_utility_dogs::disable_dog_walk();
  wait 0.05;
  maps\_utility_dogs::enable_dog_sniff();

  for(;;) {
    var_0 = common_scripts\utility::array_randomize(var_0);

    foreach(var_3 in var_0) {
      self setgoalpos(var_3);
      self waittill("goal");
      wait(randomintrange(4, 8));
    }
  }
}

dog_teleport_trig_logic() {
  var_0 = common_scripts\utility::getstruct(self.target, "targetname");
  self waittill("trigger", var_1);

  if(var_1.type == "dog") {
    var_1 forceteleport(var_0.origin, var_0.angles);
    wait 0.05;
    var_1 notify("teleported");
  }
}

intro_enemies() {
  maps\_utility::battlechatter_off();
  level.gasstation_guys = [];
  getent("dog_victim", "targetname") maps\_utility::add_spawn_function(::dog_attack_victim_logic);
  getent("dog_attack_guard", "targetname") maps\_utility::add_spawn_function(::dog_attack_guard_logic, "dog_attack_guard");
  getent("dog_attack_guard_stairs", "targetname") maps\_utility::add_spawn_function(::dog_attack_guard_logic, "dog_attack_guard_stairs");
  maps\_utility::array_spawn_function_targetname("dog_attack_back_enemies", ::dog_attack_back_enemies_logic);
  createthreatbiasgroup("dog_attack_enemies");
  createthreatbiasgroup("player");
  createthreatbiasgroup("team2");
  setignoremegroup("team2", "dog_attack_enemies");
  maps\_utility::array_spawn_function_targetname("executioners", ::gasstation_executioners_logic);
  maps\_utility::array_spawn_function_targetname("gasstation_backup", ::gasstation_executioners_logic);

  switch (level.start_point) {
    case "default":
    case "street":
    case "outside":
    case "lobby":
    case "intro":
      common_scripts\utility::flag_wait("promenade_exit");
    case "encounter1":
      level.dog_victim = maps\_utility::spawn_targetname("dog_victim", 1);
      level.dog_attack_guard = maps\_utility::spawn_targetname("dog_attack_guard", 1);
      level.dog_attack_guard_stairs = maps\_utility::spawn_targetname("dog_attack_guard_stairs", 1);
      thread dog_attack();
      level.dog_attack_guard_stairs maps\_utility::enable_sprint();
      thread gasstation_did_player_rush();
      common_scripts\utility::flag_wait_any("dog_attack_enemies_dead", "player_rushed_gas_station");
      maps\_utility::autosave_by_name("encounter1_done");
    case "encounter2":
      var_0 = getEntArray("center_guard_nodes", "targetname");

      foreach(var_2 in var_0)
      var_2 disconnectnode();

      thread gasstation_execution_timing();
      thread gasstation_civs();
      thread gasstation_ambient_aa72();
      thread wall_alarm_start();
      maps\_utility::array_spawn_targetname("executioners", 1);
      common_scripts\utility::flag_wait("player_dropped_down");
      var_4 = getent("gasstation_flag_trig", "targetname");

      if(!level.hesh istouching(var_4)) {
        level.backdoor_guy = maps\_utility::spawn_targetname("backdoor_runner", 1);
        level.backdoor_guy thread gasstation_enemy_globals();
        level.backdoor_guy maps\deer_hunt_util::set_forcegoal_nosight();
        level.backdoor_guy maps\_utility::delaythread(3, maps\deer_hunt_util::unset_forcegoal_nosight);
        level thread maps\deer_hunt_util::dog_attack_guy(level.backdoor_guy);
      }

      common_scripts\utility::flag_wait("gasstation_front_approach");
      var_5 = maps\_utility::array_spawn_targetname("gasstation_backup", 1);
      level.gasstation_guys = common_scripts\utility::array_add(level.gasstation_guys, var_5);
      common_scripts\utility::flag_wait("gasstation_clear");

      foreach(var_2 in var_0)
      var_2 connectnode();
  }
}

gasstation_did_player_rush() {
  common_scripts\utility::flag_wait("hesh_to_lookout");
  maps\deer_hunt_util::if_flag_and_not_flag("hesh_to_lookout", "dog_attack_enemies_dead", "player_rushed_gas_station");
}

gasstation_execution_timing() {
  var_0 = common_scripts\utility::flag_wait_any_return("bully_kick_victim_dead", "bully_kick_aborted", "bully_kick_complete", "player_dropped_down", "civilians_shot");
  maps\_utility::delaythread(randomfloatrange(0.25, 0.8), common_scripts\utility::play_sound_in_space, "deerhunt_civ1_nooooo", (-13770.7, 12401.9, -500.6));
  maps\_utility::delaythread(randomfloatrange(0.25, 0.8), common_scripts\utility::play_sound_in_space, "deerhunt_civ2_ahhhhhhh", (-13770.7, 12401.9, -500.6));

  if(var_0 == "player_dropped_down" && isDefined(level.bully))
    level.bully common_scripts\utility::delaycall(1, ::stopanimscripted);

  wait 0.5;
  common_scripts\utility::flag_set("execution_start");
  common_scripts\utility::array_call(level.team2, ::setthreatbiasgroup, "allies");
  level.player setthreatbiasgroup("allies");
  common_scripts\utility::array_thread(getaiarray("allies"), maps\deer_hunt_util::ignore_me_ignore_all_off);
  var_1 = getent("hill_pos1", "targetname");
  var_1 common_scripts\utility::trigger_off();
  var_1 = getent("hesh_to_lookout", "targetname");
  var_1 common_scripts\utility::trigger_off();
  maps\_utility::activate_trigger_with_targetname("hill_pos2");
  common_scripts\utility::array_thread(getaiarray("axis"), maps\deer_hunt_util::ignore_me_ignore_all_off);
  wait 3;
  maps\_utility::battlechatter_on("allies");
  maps\_utility::battlechatter_on("axis");
  var_2 = common_scripts\utility::play_loopsound_in_space("emt_deer_distant_war_lp", (-16366.9, 11819.1, -511.1));
  thread lariver_ambient_magicbullets();
  thread lariver_spawn_wall_battle_guys_early();
  common_scripts\utility::flag_wait("gasstation_clear");
  common_scripts\utility::flag_wait("to_pipe");
  wait 3;
  var_3 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("gasstation_hind");
  var_3 maps\_vehicle::mgoff();
  var_3 vehicle_turnengineoff();
  var_3 vehicle_setspeed(55, 25);
  var_3 waittill("missiles");
  common_scripts\utility::flag_set("ambient_chopper_shoots_wall");
  var_3 vehicle_turnengineon();
  var_3 thread chopper_missile_burst();
  common_scripts\utility::flag_wait("pipe_exit");
  var_2 delete();
}

lariver_ambient_magicbullets() {
  var_0 = (-16493.7, 13633.5, -207.1);
  level.temp_green_fx_tag = common_scripts\utility::spawn_tag_origin();
  level.temp_green_fx_tag.origin = var_0;
  level.temp_green_fx_tag.angles = (0, 0, 180);
  var_1 = (-18346.3, 15553.2, -121.6);
  playFX(common_scripts\utility::getfx("green_smoke"), var_1);
  playFXOnTag(common_scripts\utility::getfx("green_smoke"), level.temp_green_fx_tag, "tag_origin");
  var_2 = [(-16640, 11472, -416), (-16400, 12624, -416), (-17536, 12448, -416)];
  var_3 = [];

  foreach(var_7, var_5 in level.possible_guns) {
    var_6 = strtok(var_5, "+")[0];

    if(!isDefined(var_6[0])) {
      continue;
    }
    if(var_6 != "honeybadger" && !maps\_utility::is_in_array(var_3, var_6))
      var_3 = common_scripts\utility::add_to_array(var_3, var_6);
  }

  while(!common_scripts\utility::flag("pipe_halfway")) {
    var_8 = randomfloatrange(0.7, 1.2);

    foreach(var_7, var_1 in var_2) {
      var_10 = var_1;
      var_11 = maps\deer_hunt_util::get_random_from_array_except(var_2, var_10);
      maps\deer_hunt_util::magicburst(common_scripts\utility::random(var_3), var_10, var_11);
      wait(var_8);
    }
  }

  foreach(var_13 in level.team2)
  var_13 maps\_utility::forceuseweapon(common_scripts\utility::random(var_3), "primary");

  level.hesh maps\_utility::forceuseweapon(common_scripts\utility::random(var_3), "primary");
}

gasstation_ambient_aa72() {
  level endon("pipe_enter");
  common_scripts\utility::flag_wait("gasstation_front_approach");
  var_0 = common_scripts\utility::getStructArray("ambient_aa72x_splines", "targetname");
  var_1 = 2;
  var_2 = [];
  var_3 = 0;
  var_0 = common_scripts\utility::array_randomize(var_0);

  for(;;) {
    foreach(var_5 in var_0) {
      var_6 = maps\_vehicle::spawn_vehicle_from_targetname("ambient_aa72x");
      wait 0.1;

      if(isDefined(var_6)) {
        var_6 maps\_vehicle::godon();
        var_2 = common_scripts\utility::add_to_array(var_2, var_6);

        if(!isDefined(var_5.angles))
          var_5.angles = (0, 0, 0);

        var_6 vehicle_teleport(var_5.origin, var_5.angles);
        wait 0.05;
        var_6 thread maps\_vehicle_code::vehicle_paths_helicopter(var_5);
        wait(randomintrange(10, 15));
      }
    }

    wait 1;
  }
}

wall_alarm_start() {
  self endon("lariver_defend_bridge_clear");
  common_scripts\utility::flag_wait("gasstation_front_approach");

  for(;;) {
    wait 6;
    thread common_scripts\utility::play_sound_in_space("emt_deer_wall_siren_dist", (-19099, 15676, 1567));
  }
}

gasstation_executioners_logic() {
  self endon("death");
  level.gasstation_guys = common_scripts\utility::add_to_array(level.gasstation_guys, self);
  maps\deer_hunt_util::ignore_me_ignore_all();
  self.dontevershoot = 1;
  self.dontmelee = 1;
  self.goalradius = 24;
  self setgoalpos(self.origin);
  self.anchor = spawn("script_origin", self.origin);
  self linkto(self.anchor);
  thread gasstation_guard_damage_detection();

  while(!isDefined(level.execuioner_targets))
    wait 0.25;

  common_scripts\utility::flag_wait("execution_start");
  wait(randomfloatrange(0.25, 0.5));
  self.dontevershoot = undefined;
  maps\deer_hunt_util::ignore_me_ignore_all_off();
  common_scripts\utility::flag_wait("civilians_shot");
  self unlink();
  var_0 = getent("gasstation_enemy_vol", "targetname");
  self setgoalvolumeauto(var_0);
}

dog_attack_back_enemies_logic() {
  self.grenadeammo = 0;
  maps\_utility::disable_long_death();
  maps\_utility::set_ignoresuppression(1);
  self setthreatbiasgroup("dog_attack_enemies");
}

dog_attack_guard_logic(var_0) {
  self endon("death");
  maps\deer_hunt_util::ignore_me_ignore_all();
  maps\_utility::disable_long_death();
  self setthreatbiasgroup("dog_attack_enemies");
  self.goalradius = 20;
  self.grenadeammo = 0;
  maps\_utility::disable_careful();
  var_1 = getnode(var_0, "targetname");
  thread dog_attack_on_damage();
  common_scripts\utility::flag_wait("dog_kill_started");
  wait 1.8;
  self setgoalnode(var_1);
  maps\deer_hunt_util::ignore_me_ignore_all_off();

  if(var_0 == "dog_attack_guard_stairs") {
    while(isalive(self) && isalive(level.player)) {
      if(abs(level.player.origin[2]) - abs(self.origin[2]) >= 30) {
        self setgoalpos(self.origin);
        return;
      }

      wait 0.1;
    }
  }
}

dog_attack_victim_logic() {
  self endon("death");
  maps\deer_hunt_util::ignore_me_ignore_all();
  self.maxvisibledist = 0.01;
  self.animname = "victim";
  self.goalradius = 24;
  self.allowdeath = 1;
  self.a.nodeath = 1;
  maps\_utility::disable_surprise();
  self.ragdoll_immediate = 1;
  self.forceragdollimmediate = 1;
  var_0 = common_scripts\utility::getstruct("dog_attack", "targetname");
  var_1 = maps\_utility::getanim("dog_kill_long");
  thread dog_victim_radio_sounds();
  var_2 = getstartorigin(var_0.origin, var_0.angles, var_1);
  var_3 = getstartangles(var_0.origin, var_0.angles, var_1);
  thread maps\deer_hunt_util::retain_alert_level(1, "player_fired_outside_coffee_shop");
  self.anchor = spawn("script_origin", var_2);
  self.anchor.angles = var_3;
  self forceteleport(var_2, var_3);
  self linkto(self.anchor);
  common_scripts\utility::flag_wait("player_at_shop_door");
  thread dog_victim_enemy_early_damage_detection();
  self endon("death");
  common_scripts\utility::flag_wait("dog_kill_started");
  var_4 = self.origin;

  if(!common_scripts\utility::flag("dog_kill_aborted"))
    thread common_scripts\utility::play_sound_in_space("scn_nml_dog_attack_front_npc");

  if(common_scripts\utility::flag("player_fired_outside_coffee_shop")) {
    maps\deer_hunt_util::ignore_me_ignore_all_off();
    self unlink();
    return;
  }

  self unlink();
  wait 0.25;
  thread maps\_utility::play_sound_on_tag("generic_meleecharge_enemy_7", "tag_eye", 1);
  wait 1.5;
  thread maps\_utility::play_sound_on_tag(maps\deer_hunt_util::get_random_death_sound(), "tag_eye", 1);
  wait 2;
  thread maps\_utility::play_sound_on_tag(maps\deer_hunt_util::get_random_death_sound(), "tag_eye", 1);
  wait 1;
  thread maps\_utility::play_sound_on_tag(maps\deer_hunt_util::get_random_death_sound(), "tag_eye", 1);
}

dog_victim_death_internal() {
  wait 8.33;

  if(isalive(self))
    maps\_utility::die();

  level thread maps\deer_hunt_util::ragdoll_corpses();
}

dog_victim_radio_sounds() {
  self endon("death");

  for(;;) {
    maps\_utility::play_sound_on_tag_endon_death("fed_flavor_burst", "tag_eye");
    wait(randomintrange(2, 3));

    if(common_scripts\utility::flag("dog_kill_started") || common_scripts\utility::flag("dog_kill_aborted"))
      return;
  }
}

dog_victim_enemy_early_damage_detection() {
  self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6);

  if(!common_scripts\utility::flag("dog_kill_aborted")) {
    maps\_utility::gun_remove();
    maps\_utility::die();
    common_scripts\utility::flag_set("dog_kill_aborted");
    common_scripts\utility::flag_set("dog_kill_ended");
    maps\deer_hunt_util::set_flag_if_not_set("dog_kill_started");
  }
}

dog_attack_on_damage() {
  self waittill("damage");
  maps\deer_hunt_util::set_flag_if_not_set("dog_kill_started");
}

dog_attack() {
  while(!isDefined(level.dog_victim))
    wait 0.05;

  var_0 = common_scripts\utility::getstruct("dog_attack", "targetname");
  var_1 = [level.dog_victim, level.dog];
  common_scripts\utility::flag_wait("player_entered_coffee_shop");

  if(common_scripts\utility::flag("player_fired_outside_coffee_shop")) {
    common_scripts\utility::flag_set("dog_kill_started");
    common_scripts\utility::flag_set("dog_kill_aborted");
    common_scripts\utility::flag_set("dog_kill_ended");
    return;
  }

  common_scripts\utility::flag_wait("shop_exit");
  wait 0.5;
  common_scripts\utility::flag_set("dog_kill_started");

  if(isalive(level.dog_victim)) {
    maps\_utility::battlechatter_on("axis");
    level.dog thread dog_attack_dog_ends_early();
    level.dog_victim.allowdeath = 1;
    level.dog_victim.a.nodeath = 1;
    level.dog_victim maps\_utility::disable_surprise();
    level.dog_victim.ragdoll_immediate = 1;
    level.dog_victim.forceragdollimmediate = 1;
    var_0 maps\_anim::anim_single(var_1, "dog_kill_long");

    if(isalive(level.dog_victim))
      level.dog_victim kill();

    wait 0.1;
    level thread maps\deer_hunt_util::ragdoll_corpses();
  }

  maps\deer_hunt_util::set_flag_if_not_set("dog_kill_ended");
}

dog_attack_dog_ends_early() {
  level endon("encounter1_approach");
  thread maps\_utility::play_sound_on_entity("anml_dog_attack_npc_jump");
  common_scripts\utility::flag_wait("dog_kill_aborted");
  self stopanimscripted();
  maps\_utility_dogs::disable_dog_walk();
  maps\_utility::enable_ai_color();
}

gasstation_civs() {
  level.civs = maps\_utility::array_spawn_targetname("gasstation_civs", "targetname");
  common_scripts\utility::array_thread(level.civs, ::gasstation_civs_logic);
  var_0 = ["_us_civ_male_a", "_us_civ_male_e", "_us_civ_male_i"];
  var_0 = common_scripts\utility::array_randomize(var_0);

  foreach(var_5, var_2 in level.civs) {
    var_3 = "head" + var_0[var_5];
    var_4 = "body" + var_0[var_5];
    var_2 replace_my_models(var_3, var_4);
  }

  common_scripts\utility::flag_wait_any("hesh_to_lookout", "player_rushed_gas_station");
  thread gasstation_bully_kick();
  wait(randomfloatrange(1, 2.5));

  foreach(var_2 in level.civs) {
    if(isalive(var_2)) {
      thread common_scripts\utility::play_sound_in_space("deerhunt_civ1_leavehimalone", var_2.origin);
      break;
    }
  }
}

replace_my_models(var_0, var_1) {
  self detach(self.headmodel, "");

  if(isDefined(self.hatmodel))
    self detach(self.hatmodel, "");

  self setModel(var_1);
  self attach(var_0, "", 1);
  self.headmodel = var_0;
}

#using_animtree("generic_human");

gasstation_bully_kick() {
  var_0 = common_scripts\utility::getstruct("bully_kick", "targetname");
  var_1 = maps\_utility::spawn_targetname("bully_guard", 1);
  level.bully = var_1;
  var_1.animname = "guard";
  var_1 thread kick_bully_logic();
  var_2 = maps\_utility::spawn_targetname("bully_civ", 1);
  var_2.animname = "civ";
  var_2 thread kick_civ_logic();
  var_3 = [var_1, var_2];
  var_0 thread maps\_anim::anim_single(var_3, "bully_kick");
  wait 0.05;
  var_1 setanimtime(%prague_bully_a_kick, 0.22);
  var_2 setanimtime(%prague_bully_civ_kick, 0.24);
  var_0 waittill("bully_kick");
  maps\deer_hunt_util::set_flag_if_not_set("bully_kick_complete");
}

anim_timing(var_0) {
  self setanimtime(maps\_utility::getanim("bully_kick"), var_0);
}

kick_bully_logic() {
  maps\deer_hunt_util::ignore_me_ignore_all();
  maps\_utility::delaythread(3.5, maps\_utility::play_sound_on_tag_endon_death, "deerhunt_saf1_yourcountrywillfall", "tag_eye");
  self waittill("damage");
  self stopanimscripted();
  common_scripts\utility::flag_set("bully_kick_aborted");
  common_scripts\utility::flag_set("bully_kick_complete");
}

gasstation_guard_damage_detection() {
  level endon("execution_start");
  self waittill("damage");

  if(isDefined(level.bully))
    level.bully dodamage(10, (0, 0, 0));
}

kick_civ_logic() {
  self endon("death");
  self.allowdeath = 1;
  self.a.nodeath = 1;
  self.ragdoll_immediate = 1;
  self.forceragdollimmediate = 1;
  maps\deer_hunt_util::ignore_me_ignore_all();
  common_scripts\utility::flag_wait("execution_start");

  if(isalive(self))
    maps\_utility::die();
}

gasstation_civs_logic() {
  self.animname = "generic";
  self.name = "";
  self.team = "allies";
  self.scream_spot = self getEye();
  self.dontmelee = 1;
  maps\_utility::set_battlechatter(0);
  self.deathanim = % exposed_crouch_death_fetal;
  self.ignoreme = 1;

  if(!isDefined(level.execuioner_targets))
    level.execuioner_targets = [];

  var_0 = spawn("script_origin", self getEye());
  var_0 linkto(self, "tag_eye");
  level.execuioner_targets = common_scripts\utility::add_to_array(level.execuioner_targets, var_0);

  if(common_scripts\utility::cointoss())
    var_1 = "knees_idle";
  else
    var_1 = "knees_idle2";

  thread maps\_anim::anim_loop_solo(self, var_1);
  maps\_utility::set_moveplaybackrate(randomfloatrange(0.6, 1.3));
  thread civs_set_flag_on_damage();
  common_scripts\utility::flag_wait_any("bully_kick_victim_dead", "bully_kick_aborted", "bully_kick_complete", "player_dropped_down", "civilians_shot");
  wait(randomfloatrange(1, 2));

  if(isalive(self)) {
    self notify("stop_loop");
    self stopanimscripted();
    maps\_utility::die();
  }
}

civs_set_flag_on_damage() {
  self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  maps\deer_hunt_util::set_flag_if_not_set("civilians_shot");
}

gasstation_enemy_globals() {
  level.gasstation_guys = common_scripts\utility::add_to_array(level.gasstation_guys, self);
  maps\_utility::set_ai_bcvoice("shadowcompany");
  self.grenadeammo = 0;
  maps\_utility::disable_long_death();
}

intro_scene() {
  common_scripts\utility::flag_wait("start_intro_scene");
  var_0 = common_scripts\utility::getstruct("intro_scene", "targetname");
  level.intro_ball = maps\_utility::spawn_anim_model("intro_ball", var_0.origin);
  var_1 = [level.hesh, level.dog, level.intro_ball];
  thread intro_scene_player();
  level.hesh.animname = "generic";
  level.dog.animname = "dog";
  var_2 = 3;
  var_3 = level.intro_ball maps\deer_hunt_util::get_anim_start_time(var_2, "intro1");
  var_4 = var_2 / getanimlength(%dh_intro1_guy);
  var_5 = var_2 / getanimlength(level.dog maps\_utility::getanim("intro1"));
  common_scripts\utility::flag_wait("introscreen_complete");
  maps\_utility::delaythread(2, common_scripts\utility::flag_set, "intro_scene_complete");

  if(!getdvarint("steve", 1)) {
    var_0 thread maps\_anim::anim_single_run(var_1, "intro1");
    wait 0.05;
    level.hesh thread maps\_utility::play_sound_on_entity("scn_deer_intro_hesh_mvmt");
    level.intro_ball thread maps\_utility::play_sound_on_entity("scn_deer_intro_ball_hits");
    level.dog thread maps\_utility::play_sound_on_entity("scn_deer_intro_dog_mvmt");
    level.hesh setanimtime(%dh_intro1_guy, var_4);
    level.dog setanimtime(level.dog maps\_utility::getanim("intro1"), var_5);
    level.intro_ball setanimtime(level.intro_ball maps\_utility::getanim("intro1"), var_3);
  } else
    common_scripts\utility::flag_set("player_up");

  maps\_utility::delaythread(2, maps\_utility::activate_trigger_with_targetname, "to_corner");
}

hesh_logic() {
  self endon("deleted");
  self.animname = "generic";
  thread maps\_utility::magic_bullet_shield();
  maps\_utility::set_baseaccuracy(2);
  self.grenadeammo = 0;
  maps\_utility::disable_surprise();
  maps\_utility::disable_pain();
  maps\_utility::set_ignoresuppression(1);
  self.goalradius = 32;
  maps\_utility::set_ai_bcvoice("taskforce");

  switch (level.start_point) {
    case "default":
    case "intro":
      maps\deer_hunt_util::switch_from_cqb_to_creepwalk();
      var_0 = getent("theater_curtain", "targetname");
      var_0.animname = "curtain";
      var_0 maps\_utility::assign_animtree();
      var_1 = common_scripts\utility::getstruct("curtain_open", "targetname");
      var_2 = "curtain_cut_in";
      var_1 thread maps\_anim::anim_first_frame_solo(var_0, var_2);
      self.ignoreme = 1;
      self.ignoreall = 1;
      self.animname = "generic";
      maps\_utility::set_force_color("r");
      maps\_utility::enable_ai_color();
      maps\_utility::enable_readystand();
      common_scripts\utility::flag_wait("intro_scene_complete");
      common_scripts\utility::flag_wait("hallway_halfway");
      var_3 = common_scripts\utility::getstruct("crouch_test", "targetname");
      var_4 = "creepwalk_duck";
      maps\_utility::disable_ai_color();
      var_3 maps\_anim::anim_reach_solo(self, var_4);
      maps\_utility::delaythread(1, maps\_utility::enable_ai_color);
      var_3 maps\_anim::anim_single_solo(self, var_4);
      maps\deer_hunt_util::switch_from_creepwalk_to_cqb();
      common_scripts\utility::flag_wait("player_approaching_stage");
      var_5 = getent("theater_curtain_blocker", "targetname");
      maps\_utility::disable_ai_color();
      var_1 maps\_anim::anim_reach_solo(self, var_2);
      thread maps\deer_hunt_util::flag_set_delayed(14.5, "curtain_cut");
      level thread unblock_curtain(var_5);
      var_1 maps\_anim::anim_single([self, var_0], var_2);
      var_1 thread maps\_anim::anim_loop([self, var_0], "curtain_cut_idle");
      common_scripts\utility::flag_wait("through_screen");
      var_1 notify("stop_loop");
      maps\_utility::delaythread(0.7, common_scripts\utility::play_sound_in_space, "scn_deer_cut_screen_release", (-8755, 10166, -302));
      var_1 thread maps\_anim::anim_single([self, var_0], "curtain_cut_out");
      maps\_utility::delaythread(1, maps\_utility::enable_ai_color);
      maps\_utility::activate_trigger_with_targetname("theater_exit_wait");
      common_scripts\utility::flag_set("to_theater_exit");
      wait 5;
      maps\_utility::disable_cqbwalk();
      thread maps\deer_hunt_util::hesh_nag_til_flag("player_on_upper_level", 13, 1);
      common_scripts\utility::flag_wait("player_on_upper_level");
    case "lobby":
      maps\deer_hunt_util::switch_from_creepwalk_to_cqb();
      common_scripts\utility::flag_wait("to_lobby_entrance");
      thread maps\deer_hunt_util::hesh_nag_til_flag("lobby_entrance", 15);
      common_scripts\utility::flag_wait("lobby_exit_approach");
    case "outside":
      maps\_utility::disable_readystand();

      if(!common_scripts\utility::flag("promenade_exit")) {
        var_6 = common_scripts\utility::getstruct("pie_slice", "targetname");
        maps\_utility::disable_ai_color();
        var_6 maps\_anim::anim_reach_solo(level.hesh, "360");
        maps\_utility::delaythread(2, maps\_utility::enable_ai_color);
        var_6 maps\_anim::anim_single_solo(level.hesh, "360");
      }

      common_scripts\utility::flag_set("outside_360_complete");
      common_scripts\utility::flag_wait("promenade_exit_halfway");
    case "street":
      level thread bus_movement();
      maps\deer_hunt_util::ignore_me_ignore_all();
    case "encounter1":
      common_scripts\utility::flag_wait("meetup_completed");
      level thread hesh_dog_interaction();
      common_scripts\utility::flag_wait("encounter1_affection_done");
      var_6 = common_scripts\utility::getstruct("shop_door_anim_ent", "targetname");
      var_7 = spawn("script_origin", var_6.origin);
      var_7.angles = var_6.angles;
      maps\_utility::disable_ai_color();
      var_7 maps\_anim::anim_reach_and_approach([self], "shop_door_open", undefined, "Cover Right");
      var_7 thread maps\_anim::anim_loop_solo(self, "shop_door_idle");
      common_scripts\utility::flag_wait("player_at_shop_door");
      maps\_utility::clear_generic_run_anim();
      var_8 = getEntArray("shop_door_left", "targetname");
      var_9 = var_8[0];
      var_10 = getanimlength(%hunted_open_barndoor_flathand);

      if(isDefined(var_8[1]))
        var_8[1] delete();

      var_7 notify("stop_loop");
      self pushplayer(1);
      common_scripts\utility::delaycall(var_10, ::pushplayer, 0);
      var_7 thread maps\_anim::anim_single_solo(self, "shop_door_open");
      var_9 thread maps\deer_hunt_util::shop_door_open();
      wait 0.5;
      maps\_utility::enable_ai_color();
      common_scripts\utility::flag_wait("dog_kill_started");
      level.player setthreatbiasgroup("player");

      foreach(var_12 in level.team2)
      var_12 setthreatbiasgroup("team2");

      var_7 delete();
      wait 2.3;
      self.baseaccuracy = 0.8;
      maps\deer_hunt_util::ignore_me_ignore_all_off();
      common_scripts\utility::array_thread(level.team2, maps\deer_hunt_util::ignore_me_ignore_all_off);
      maps\_utility::battlechatter_on("allies");
      maps\_utility::delaythread(3, maps\deer_hunt_util::activate_trig_if_not_flag, "back_enemies_fight_begin");
      common_scripts\utility::flag_wait_any("dog_attack_enemies_dead", "player_rushed_gas_station");
      maps\_utility::battlechatter_off();
      common_scripts\utility::array_thread(level.team2, maps\deer_hunt_util::ignore_me_ignore_all);
      maps\_utility::activate_trigger_with_targetname("player_on_bus");
      wait 3;
      common_scripts\utility::flag_wait("hesh_moves_from_encounter1");
      var_6 = common_scripts\utility::getstruct("wall_kick", "targetname");
      var_6.origin = (-13736.5, 14092, -232);
      var_7 = spawn("script_origin", var_6.origin);
      var_7.angles = var_6.angles;
      var_7 maps\_anim::anim_reach_and_approach([level.hesh], "wall_kick", undefined, "Exposed");
      common_scripts\utility::flag_wait("player_at_encounter1");
      var_6 thread maps\_anim::anim_single_solo(self, "wall_kick");
      wait 1;
      level thread maps\_utility::activate_trigger_with_targetname("hesh_to_dropdown");
      maps\_utility::enable_ai_color();
    case "encounter2":
      maps\deer_hunt_util::ignore_me_ignore_all();
      common_scripts\utility::flag_wait("hesh_to_lookout");
      common_scripts\utility::flag_wait_either("player_dropped_down", "execution_start");

      if(!common_scripts\utility::flag("player_dropped_down"))
        maps\_utility::activate_trigger_with_targetname("player_dropped_down");

      thread hesh_gasstation_logic();
      common_scripts\utility::flag_wait_or_timeout("player_approaches_gasstation", 4.5);

      if(!common_scripts\utility::flag("execution_start"))
        maps\_utility::activate_trigger_with_targetname("hill_pos1");

      common_scripts\utility::flag_wait("gasstation_clear");
    case "lariver":
  }
}

gasstation_did_player_rush_pipe() {
  maps\deer_hunt_util::if_flag_and_not_flag("pipe_enter", "gasstation_clear", "player_rushed_lariver");
}

unblock_curtain(var_0) {
  common_scripts\utility::flag_wait_or_timeout("start_cut", 10);
  wait 3;
  var_0.origin = var_0.origin + (0, 0, 300);
  var_0 connectpaths();
}

hesh_dog_interaction() {
  while(!isDefined(level.hesh))
    wait 0.5;

  common_scripts\utility::flag_wait("meetup_completed");
  level.hesh maps\_utility::disable_ai_color();
  var_0 = common_scripts\utility::getstruct("dog_interact", "targetname");
  var_0 maps\_anim::anim_reach_solo(level.hesh, "affection");
  common_scripts\utility::flag_wait_all("player_out_of_chasm", "dog_in_affection_position");
  level.dog.animname = "dog";
  common_scripts\utility::flag_set("encounter1_affection_started");
  level.dog common_scripts\utility::delaycall(5, ::stopanimscripted);
  level.dog maps\_utility::delaythread(2.5, maps\_utility::enable_ai_color);
  var_0 maps\_anim::anim_single(level.squad, "affection");
  common_scripts\utility::flag_set("encounter1_affection_done");
  level.dog.animname = "generic";
  level.hesh maps\_utility::enable_ai_color();
}

hesh_waits_for_player(var_0) {}

bus_movement() {
  thread bus_movement_sounds_rumble_etc();
}

bus_movement_model_logic() {
  var_0 = getent(self.targetname + "_clip", "targetname");
  var_0 linkto(self);
  var_0 connectpaths();
}

bus_movement_internal() {
  var_0 = (272.4, 52.6004, 89.9999);
  var_1 = (275.186, 115.125, 27.5734);
  self rotatepitch(2, 0.5);
  wait 2;
  var_2 = 3;
  self rotatepitch(4, var_2, 0.5, var_2 - 0.5);
}

bus_movement_sounds_rumble_etc() {
  common_scripts\utility::flag_wait("player_on_bus");
  wait 1;
  thread common_scripts\utility::exploder(1);
  var_0 = level.player.origin - (0, 0, 400);
  earthquake(0.3, 1, level.player.origin, 600);
  earthquake(0.1, 8, level.player.origin, 600);
  playrumbleonposition("deer_hunt_earthquake", level.player.origin + (0, 0, 500));
  thread common_scripts\utility::play_sound_in_space("scn_deer_cementbridge_back", (-11659.9, 15248.6, -58));
  thread common_scripts\utility::play_sound_in_space("scn_deer_cementbridge_front", (-11835.1, 14961.6, -78.5));
}

hesh_does_360(var_0) {
  var_1 = common_scripts\utility::getstruct("360_turn", "targetname");
  var_1 maps\_anim::anim_reach_solo(self, "360");
  var_1 maps\_anim::anim_single_solo(self, "360");
  maps\_utility::enable_ai_color();
  self.colornode_setgoal_func = undefined;
}

hesh_gasstation_logic() {
  common_scripts\utility::flag_wait("player_dropped_down");
  var_0 = getEntArray("pipe_trigs", "script_noteworthy");
  common_scripts\utility::array_thread(var_0, common_scripts\utility::trigger_off);
  common_scripts\utility::flag_wait("execution_start");
  var_1 = getent("hesh_foliage_clip", "targetname");
  var_1 delete();
  self.baseaccuracy = 5;
  common_scripts\utility::flag_wait("gasstation_front_approach");
  level thread gasstation_waittill_clear_or_bypassed(var_0);
  common_scripts\utility::flag_wait_any("gasstation_enemies_dead", "player_rushed_lariver");
  maps\_utility::activate_trigger_with_targetname("gasstation_clear");
}

gasstation_waittill_clear_or_bypassed(var_0) {
  while(level.gasstation_guys.size > 1) {
    level.gasstation_guys = maps\_utility::array_removedead_or_dying(level.gasstation_guys);
    wait 1;
  }

  var_1 = getEntArray("hill_trigs", "script_noteworthy");
  common_scripts\utility::array_thread(var_1, common_scripts\utility::trigger_off);
  common_scripts\utility::array_thread(var_0, common_scripts\utility::trigger_on);

  if(isDefined(level.gasstation_guys[0]))
    level.gasstation_guys[0] thread maps\deer_hunt_util::kill_me_from_closest_enemy();

  common_scripts\utility::flag_set("gasstation_enemies_dead");
}

dog_gasstation_logic() {
  common_scripts\utility::flag_wait("hill_pos1");
  common_scripts\utility::flag_wait_or_timeout("gas_station_open_fire", 45);

  if(!common_scripts\utility::flag("roof_guy_dead")) {
    common_scripts\utility::flag_set("send_dog_to_roof");
    dog_kills_roof_guy();
    maps\deer_hunt_util::ignore_me_ignore_all();
  }
}

dog_kills_roof_guy() {
  if(common_scripts\utility::flag("roof_guy_dead")) {
    return;
  }
  if(!common_scripts\utility::flag("gas_station_open_fire"))
    level.hesh maps\_utility::smart_radio_dialogue("deerhunt_hsh_cairocantakeout");

  self endon("roof_guy_dead");
  maps\_utility::disable_ai_color();
  self setgoalentity(level.roof_guy);
  common_scripts\utility::flag_wait("dog_on_roof");
  wait 2;
  self.ignoreall = 0;
  common_scripts\utility::flag_wait("roof_guy_dead");
}

get_my_meeting_group() {
  if(maps\_utility::is_in_array(level.left_meeting_guys, self))
    return level.left_meeting_guys;
  else if(maps\_utility::is_in_array(level.right_meeting_guys, self))
    return level.right_meeting_guys;
  else
    return undefined;
}

move_player_to_start(var_0) {
  var_1 = common_scripts\utility::getstruct(var_0, "targetname");

  if(!isDefined(var_1)) {
    var_1 = getent(var_0, "targetname");

    if(!isDefined(var_1))
      return;
  }

  level.player setorigin(var_1.origin);
  var_2 = undefined;

  if(isDefined(var_1.target))
    var_2 = getent(var_1.target, "targetname");

  if(isDefined(var_2))
    level.player setplayerangles(vectortoangles(var_2.origin - var_1.origin));
  else
    level.player setplayerangles(var_1.angles);

  wait 0.1;
}

deer_ruckus_trig_logic() {
  self waittill("trigger");

  if(isDefined(self.target))
    thread common_scripts\utility::play_sound_in_space("scn_deer_ruckus_02", (-8636, 10060, -315));
}

deer_ruckus(var_0) {
  var_1 = ["deer_metal_impact", "deer_glass_break"];
  var_1 = common_scripts\utility::array_randomize(var_1);
  thread common_scripts\utility::play_sound_in_space(var_1[0], var_0);
  wait(randomfloatrange(0.5, 0.8));
  thread common_scripts\utility::play_sound_in_space(var_1[1], var_0);
}

deer_init() {
  deer_reveal_chairs();
  common_scripts\utility::exploder("deer_dust_still");
  level.drone_lookahead_value = 500;
  var_0 = getEntArray("lobby_deer", "targetname");
  var_1 = getEntArray("promenade_deer", "targetname");
  var_2 = getEntArray("promenade_exit_deer", "targetname");
  var_3 = [];
  var_4 = [];
  var_5 = [];

  foreach(var_8, var_7 in var_0)
  var_3[var_8] = maps\_drone_deer::deer_dronespawn(var_7);

  foreach(var_8, var_7 in var_2)
  var_5[var_8] = maps\_drone_deer::deer_dronespawn(var_7);

  thread theatre_doors(var_3);
  var_10 = common_scripts\utility::getstruct("deer_reveal", "targetname");

  foreach(var_8, var_12 in var_3) {
    var_12.animname = "deer" + var_8;
    var_12 thread maps\_utility::magic_bullet_shield();
  }

  var_5[0] thread maps\_utility::magic_bullet_shield();
  var_10 thread maps\_anim::anim_loop(var_3, "reveal_idle");
  var_13 = getanimlength(var_3[0] maps\_utility::getanim("reveal"));
  thread deer_player_leaning_detect();
  common_scripts\utility::flag_wait("lobby_entrance");
  var_3[1] thread maps\_utility::play_sound_on_entity("scn_deer_run_away_left");
  var_3[0] thread maps\_utility::play_sound_on_entity("scn_deer_run_away_right");
  thread common_scripts\utility::play_sound_in_space("scn_deer_run_away_glass", (-9404, 12199, -138));
  thread common_scripts\utility::play_sound_in_space("scn_deer_run_away_door_left", (-9382, 12525, -138));
  thread common_scripts\utility::play_sound_in_space("scn_deer_run_away_door_right", (-9151, 12584, -138));
  level.chair_models[1] thread maps\_utility::play_sound_on_entity("scn_deer_run_away_chair3");
  level.chair_models[2] thread maps\_utility::play_sound_on_entity("scn_deer_run_away_chair2");
  level.chair_models[4] thread maps\_utility::play_sound_on_entity("scn_deer_run_away_chair1");
  level.chair_anim_ent thread maps\_anim::anim_single(level.chair_models, "reveal");
  thread maps\_utility::stop_exploder("deer_dust_still");
  thread common_scripts\utility::exploder("deer_dust_kickup");
  var_10 notify("stop_loop");
  maps\_utility::delaythread(var_13 - 0.4, maps\_utility::array_notify, var_3, "move");
  var_10 maps\_anim::anim_single_run(var_3, "reveal");
  var_5[0] thread deer_detects_when_to_run();
}

deer_player_leaning_detect() {
  var_0 = getent("deer_doorway", "targetname");
  level endon("lobby_entrance");

  for(;;) {
    if(level.player istouching(var_0) && level.player playerads() > 0.5) {
      maps\_utility::activate_trigger_with_targetname("lobby_entrance");
      return;
    }

    wait 0.1;
  }
}

deer_reveal_chairs() {
  level.drone_lookahead_value = 800;
  var_0 = "chair_";
  var_1 = "reveal";
  var_2 = common_scripts\utility::getstruct("deer_reveal", "targetname");
  var_3 = "lv_redchair_dust";
  level.chair_models = [];
  level.chair_anim_ent = spawnStruct();
  level.chair_anim_ent.origin = var_2.origin;
  level.chair_anim_ent.angles = var_2.angles;

  for(var_4 = 0; var_4 < 5; var_4++) {
    if(var_4 == 0) {
      continue;
    }
    level.chair_models[var_4] = maps\_utility::spawn_anim_model(var_0 + var_4, level.chair_anim_ent.origin);
    level.chair_models[var_4].attached_actor = spawn("script_model", level.chair_anim_ent.origin);
    level.chair_models[var_4].attached_actor setModel(var_3);
    level.chair_models[var_4].attached_actor linkto(level.chair_models[var_4]);
    level.chair_anim_ent thread maps\_anim::anim_first_frame_solo(level.chair_models[var_4], var_1);
    wait 0.1;
  }
}

theatre_doors(var_0) {
  var_1 = [getent("theatre_doors_a_1", "targetname"), getent("theatre_doors_a_2", "targetname")];
  var_2 = [getent("theatre_doors_b_1", "targetname"), getent("theatre_doors_b_2", "targetname")];
  thread theater_door_deer_dist_check(var_1, var_0);
  thread theater_door_deer_dist_check(var_2, var_0);
}

theater_door_deer_dist_check(var_0, var_1) {
  wait 2;
  var_2 = 14400;

  for(;;) {
    foreach(var_4 in var_1) {
      if(distance2dsquared(var_0[0].origin, var_4.origin) <= var_2) {
        thread smash_open(var_0);
        return;
      }
    }

    wait 0.05;
  }
}

smash_open(var_0) {
  foreach(var_2 in var_0) {
    if(var_2.targetname == "theatre_doors_b_1" || var_2.targetname == "theatre_doors_a_1")
      var_3 = 96;
    else
      var_3 = -96;

    var_2 thread open_and_connect(var_3);
  }
}

open_and_connect(var_0) {
  var_1 = 0.1;
  self rotateyaw(var_0, var_1);
  self connectpaths();
  self waittill("rotatedone");
  var_2 = randomintrange(18, 27);

  if(var_0 > 0)
    var_2 = var_2 * -1;

  var_3 = randomintrange(10, 15);
  var_4 = 0.1;
  var_5 = var_3 - var_4;
  self rotateyaw(var_2, var_3, var_4, var_5);
  thread connect_while_opening();
  self waittill("rotatedone");
  self notify("stop_updating_door_paths");
}

connect_while_opening() {
  self endon("stop_updating_door_paths");

  for(;;) {
    self connectpaths();
    self disconnectpaths();
    wait 0.05;
  }
}

deer_detects_when_to_run() {
  wait 1;
  thread deer_allies_dist_detection();
  thread deer_damage_detection();
  thread deer_player_aim_detection();
  self waittill("move");
  level common_scripts\utility::flag_set("deer_moved_away");
}

deer_allies_dist_detection() {
  self endon("stop_deciding_when_to_move");
  var_0 = 250000;
  var_1 = common_scripts\utility::add_to_array(level.squad, level.player);

  while(!maps\deer_hunt_util::is_array_close(var_1, var_0))
    wait 0.05;

  self notify("move");
  self notify("stop_deciding_when_to_move");
}

deer_damage_detection() {
  self endon("stop_deciding_when_to_move");
  var_0 = 0;

  for(;;) {
    self waittill("damage", var_1, var_2);
    var_0 = var_0 + var_1;

    if(isDefined(var_2)) {
      if(var_2 == level.player) {
        wait 0.25;
        self notify("move");
        self notify("stop_deciding_when_to_move");
        return;
      }
    }
  }
}

deer_player_aim_detection() {
  self endon("stop_deciding_when_to_move");

  for(;;) {
    var_0 = vectornormalize(anglesToForward(level.player getplayerangles()));
    var_1 = level.player.origin + var_0 * 10000;
    var_2 = bulletTrace(level.player getEye(), var_1, 1, level.player);

    if(isDefined(var_2["entity"])) {
      if(var_2["entity"] == self) {
        wait 0.25;
        self notify("move");
        self notify("stop_deciding_when_to_move");
        return;
      }
    }

    wait 0.1;
  }
}

do_physics_pulse() {
  common_scripts\utility::flag_wait("lobby_entrance");
  wait 0.4;
  physicsexplosionsphere(self.origin, 50, 30, 1);
}

lobby_ruckus() {
  common_scripts\utility::flag_wait("lobby_entrance");
  var_0 = (-9124.8, 12167.3, -170);
  var_1 = ["deer_metal_fall", "deer_glass_break", "deer_metal_impact"];
  var_1 = common_scripts\utility::array_randomize(var_1);
  wait 0.5;
  wait(randomfloatrange(0.5, 0.8));
  wait(randomfloatrange(0.5, 0.8));
}

lariver_spawn_wall_battle_guys_early() {
  createthreatbiasgroup("final_pos_enemies");
  createthreatbiasgroup("final_pos_friendlies");
  setthreatbias("final_pos_enemies", "final_pos_friendlies", 10000);
  setthreatbias("final_pos_friendlies", "final_pos_enemies", 10000);
  setthreatbias("axis", "final_pos_friendlies", 0);
  setthreatbias("allies", "final_pos_enemies", 0);
  maps\_utility::array_spawn_function_targetname("rpg_guys", ::lariver_balcony_friendly_logic);
  maps\_utility::array_spawn_function_targetname("lariver_backline_guys", ::lariver_backline_guys_logic);
  level.lariver_early_ai = [];
  var_0 = maps\_utility::array_spawn_targetname("rpg_guys", 1);
  level.lariver_early_ai = common_scripts\utility::array_combine(level.lariver_early_ai, var_0);

  foreach(var_2 in level.lariver_early_ai)
  var_2.spawner = common_scripts\utility::random(getEntArray("rpg_guys", "targetname"));

  var_4 = maps\_utility::array_spawn_targetname("lariver_backline_guys", 1);
  level.lariver_early_ai = common_scripts\utility::array_combine(level.lariver_early_ai, var_4);
  level.balcony_friendlies = var_0;
}

lariver_global_setup() {
  maps\deer_hunt_color_system::init_enemy_color_volumes();
  thread lariver_friendly_setup();
  thread lariver_enemies();
  level.hesh thread maps\deer_hunt_util::hesh_calls_riley(4, "squad_to_defend");
  createthreatbiasgroup("final_pos_enemies");
  createthreatbiasgroup("final_pos_friendlies");
  setthreatbias("final_pos_enemies", "final_pos_friendlies", 10000);
  setthreatbias("final_pos_friendlies", "final_pos_enemies", 10000);
  setthreatbias("axis", "final_pos_friendlies", 0);
  setthreatbias("allies", "final_pos_enemies", 0);

  if(isDefined(level.temp_green_fx_tag)) {
    stopFXOnTag(common_scripts\utility::getfx("green_smoke"), level.temp_green_fx_tag, "tag_origin");
    level.temp_green_fx_tag delete();
  }

  level.matv = maps\_vehicle::spawn_vehicle_from_targetname("gate_matv");
  level.matv.godmode = 1;
  level.matv.obj_ent = getent("obj_ramp", "targetname");
  level.matv.obj_ent linkto(level.matv);
  level.matv.obj_ent hide();
  wait 0.05;
  var_0 = getvehiclenode("matv_start", "targetname");
  level.matv attachpath(var_0);
  common_scripts\utility::flag_wait("player_under_bridge");
  thread lariver_defend_globals();
  thread la_river_defend_weapons_spawn();
}

lariver_defend_spawn_choppers() {
  common_scripts\utility::flag_wait("spawn_defend_choppers");
  level.choppers = [];
  var_0 = ["lariver_defend_chopper_left"];

  foreach(var_2 in var_0)
  getent(var_2, "targetname") maps\_utility::add_spawn_function(::chopper_spawn_func);

  common_scripts\utility::flag_wait("defend_chopp1_dead");
  common_scripts\utility::flag_wait("spawn_defend_chopper2");
  level.chopper2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("lariver_defend_chopper_left");
  level.choppers = common_scripts\utility::array_add(level.choppers, level.chopper2);
  level.chopper2 thread make_me_a_target();
  level.valid_missile_target = level.chopper2;
  level.chopper2 chopper_does_first_flyby();
  thread choppers_do_strafe_attacks();
  common_scripts\utility::flag_wait("defend_chopp2_dead");
  common_scripts\utility::flag_set("choppers_dead");
}

chopper_spawn_func() {
  self.shoot_tag = "tag_flash";
  self.is_dying = 0;
  self.enablerocketdeath = 1;
  self.alwaysrocketdeath = 1;
  self.is_dodging = 0;
  self.last_dodge = "left";
  self.is_strafing = 0;
  self.preferred_crash_style = 0;
  self setmaxpitchroll(10, 10);
  self.node_array = maps\deer_hunt_util::return_struct_spline(common_scripts\utility::getstruct(self.spawner.target, "targetname"));
  thread chopper_attacker_check();
  thread chopper_outline_monitor();
  maps\_vehicle::godon();
  maps\_vehicle::mgoff();
  self setyawspeedbyname("faster");
  level.player.head_target = spawn("script_origin", level.player getEye());
  level.player.head_target linkto(level.player);
  self.had_mercy = 0;
  self.mgturret[0].bottomarc = 180;
  self.mgturret[0].leftarc = 180;
  self.mgturret[0].rightarc = 180;
  self.mgturret[0].toparc = 180;
  self waittill("death");

  if(!common_scripts\utility::flag("defend_chopp1_dead"))
    common_scripts\utility::flag_set("defend_chopp1_dead");
}

choppers_do_strafe_attacks() {
  level endon("defend_chopp2_dead");
  wait 15;

  for(;;) {
    level.choppers = common_scripts\utility::array_removeundefined(level.choppers);

    if(level.choppers.size == 0) {
      wait 2;
      continue;
    }

    common_scripts\utility::random(level.choppers) chopper_strafe_attack();
    var_0 = randomintrange(15, 22);
    wait(var_0);
  }
}

chopper_strafe_attack() {
  if(self.is_dying) {
    return;
  }
  if(self.is_strafing) {
    return;
  }
  self endon("stop_strafing");
  self notify("strafe_run");
  self.is_strafing = 1;
  self.attack_pos = undefined;
  self setneargoalnotifydist(500);
  var_0 = common_scripts\utility::getStructArray("strafe_attack", "script_noteworthy");
  self.old_node = self.currentnode;
  maps\_utility::vehicle_detachfrompath();
  var_1 = common_scripts\utility::getclosest(self.origin, var_0);
  self.attack_pos = var_1.origin;

  while(self.is_dodging)
    wait 0.25;

  self vehicle_setspeed(45, 20);
  self setvehgoalpos(self.attack_pos, 1);
  self setlookatent(level.player);

  while(distance(self.origin, self.attack_pos) > 300)
    wait 0.25;

  thread chopper_attack_logic();
  thread chopper_destroys_cover();
  var_2 = common_scripts\utility::getstruct(var_1.target, "targetname");
  self.attack_pos = var_2.origin;

  while(self.is_dodging)
    wait 0.25;

  self setvehgoalpos(self.attack_pos);
  self vehicle_setspeed(50, 25);

  while(distance(self.origin, self.attack_pos) > 300)
    wait 0.25;

  common_scripts\utility::delaycall(4, ::clearlookatent);
  self.is_strafing = 0;
  thread maps\_utility::notify_delay("stop_shooting", 10);
  self.attack_pos = undefined;
  thread chopper_resume_path(1);
}

chopper_resume_path(var_0) {
  if(self.is_dying) {
    return;
  }
  var_1 = common_scripts\utility::getstruct("right_spline", "script_noteworthy");
  var_2 = common_scripts\utility::getstruct("left_spline", "script_noteworthy");

  if(maps\_utility::is_in_array(self.node_array, var_2)) {
    self.node_array = maps\deer_hunt_util::return_struct_spline(var_1);
    var_3 = common_scripts\utility::getclosest(self.origin, self.node_array, 10000);
  } else {
    self.node_array = maps\deer_hunt_util::return_struct_spline(var_2);
    var_3 = common_scripts\utility::getclosest(self.origin, self.node_array, 10000);
  }

  self.is_strafing = 0;
  thread maps\_vehicle_code::vehicle_paths_helicopter(var_3);
  self vehicle_setspeed(50, 50);

  if(isDefined(var_0))
    thread chopper_attack_logic();
}

chopper_side_dodge() {
  if(self.is_dodging) {
    return;
  }
  self.is_dodging = 1;
  var_0 = 200;
  var_1 = self.angles;
  var_1 = (0, var_1[1], 0);
  var_2 = anglestoright(var_1);
  var_3 = var_2 * var_0;
  var_4 = self.origin + var_3;
  var_5 = undefined;

  if(bullettracepassed(self.origin, var_4, 0, self) && self.last_dodge == "left") {
    self.last_dodge = "right";
    var_5 = var_4;
  } else {
    var_3 = var_3 * -1;
    var_4 = self.origin + var_3;

    if(bullettracepassed(self.origin, var_4, 0, self)) {
      self.last_dodge = "left";
      var_5 = var_4;
    }
  }

  if(!isDefined(var_5)) {
    self.is_dodging = 0;
    return;
  } else {
    self setvehgoalpos(var_5 + (0, 0, 100));
    self vehicle_setspeed(60, 60, 60);
    thread maps\_utility::play_sound_on_entity("scn_deer_hind_avoid");
    wait 3;
    self.is_dodging = 0;

    if(isDefined(self.attack_pos))
      self setvehgoalpos(self.attack_pos, 1);
    else
      thread chopper_resume_path();

    return;
  }
}

chopper_does_first_flyby() {
  var_0 = (-17617.2, 13590, 80.9);
  var_1 = (-18519.2, 15965, 1282.9);
  self.old_node = self.currentnode;
  maps\_utility::vehicle_detachfrompath();
  maps\_utility::delaythread(6, ::chopper_missile_burst);
  self vehicle_setspeed(75, 35);
  self setvehgoalpos(var_0);
  self waittill("goal");
  self setvehgoalpos(var_1);
  self waittill("goal");
  self vehicle_setspeed(40, 40);
  chopper_strafe_attack();
  level thread choppers_do_strafe_attacks();
}

chopper_missile_burst() {
  var_0 = [(-18265.1, 14554.4, -511.1), (-18457.2, 14546, -511.1), (-17975.9, 14705.3, -511.1), (-17996.2, 14528.5, -511.1)];
  var_1 = "tag_missile_right";

  foreach(var_3 in var_0) {
    var_4 = self gettagorigin(var_1) - (0, 0, 50);
    var_5 = magicbullet("zippy_rockets", var_4, var_3);
    wait 0.3;

    if(var_1 == "tag_missile_right") {
      var_1 = "tag_missile_left";
      continue;
    }

    var_1 = "tag_missile_right";
  }

  var_7 = getent("player_defend_area", "script_noteworthy");

  if(level.player istouching(var_7)) {
    level.player_is_stunned = 1;
    level.player enableinvulnerability();
    earthquake(0.8, 2, level.player.origin, 500);
    level.player maps\_utility::blend_movespeedscale_percent(20, 0.1);
    level.player maps\_utility::delaythread(3, maps\_utility::blend_movespeedscale_percent, 95, 0.1);
    level.player shellshock("default", 4);
    level.player playrumbleonentity("damage_heavy");
    level.player disableweapons();
    wait 3;
    level.player enableweapons();
    level.player disableinvulnerability();
    wait 1;
    level.player_is_stunned = 0;
  }

  if(common_scripts\utility::flag("squad_to_defend")) {
    common_scripts\utility::flag_set("chopper_fight_start");
    maps\_utility::autosave_by_name("chopper_fight");
  }
}

chopper_attack_logic() {
  if(self.is_dying) {
    return;
  }
  self endon("death");
  self endon("stop_shooting");
  self notify("shooting_mg");
  self endon("shooting_mg");
  var_0 = 3;
  var_1 = 50;
  var_2 = maps\_utility::getdifficulty();

  switch (var_2) {
    case "easy":
      var_0 = 5;
      var_1 = 25;
      break;
    case "medium":
      var_0 = 3;
      var_1 = 50;
      break;
    case "fu":
    case "hard":
      var_0 = 2;
      var_1 = 75;
      break;
  }

  var_3 = cos(70);

  while(self.health > 0) {
    burst_mg(level.player);

    if(randomint(100) <= var_1)
      maps\deer_hunt_util::shoot_rocket("zippy_rockets");

    wait(var_0);
  }
}

burst_mg(var_0) {
  self endon("stop_shooting_mg");
  var_1 = self.mgturret[0];
  var_2 = randomintrange(40, 50);
  var_3 = 150;
  var_4 = 200;
  var_5 = 50;
  var_6 = 0;
  var_7 = maps\_utility::getdifficulty();

  switch (var_7) {
    case "easy":
      var_3 = 10;
      var_4 = 40;
      var_5 = 25;
      var_2 = randomintrange(15, 20);
      break;
    case "medium":
      var_3 = 9;
      var_4 = 28;
      var_5 = 50;
      var_2 = randomintrange(25, 35);
      break;
    case "fu":
    case "hard":
      var_3 = 8;
      var_4 = 12;
      var_5 = 75;
      var_2 = randomintrange(8, 12);
      break;
  }

  for(var_8 = 0; var_8 < var_2; var_8++) {
    var_6 = randomint(10);
    var_9 = randomintrange(var_3, var_4);

    if(common_scripts\utility::cointoss())
      var_9 = var_9 * -1;

    var_1 settargetentity(level.player.head_target, (var_9, var_9, 0));
    var_1 shootturret();

    if(!self.had_mercy && level.player.health <= 20) {
      self.had_mercy = 1;
      return;
    }

    wait 0.05;
  }
}

chopper_attacker_check() {
  self.shot_with_rpg = 0;
  var_0 = 2;
  var_1 = maps\_utility::getdifficulty();

  switch (var_1) {
    case "easy":
      var_0 = 2;
      break;
    case "medium":
      var_0 = 2;
      break;
    case "fu":
    case "hard":
      var_0 = 2;
      break;
  }

  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(isDefined(var_3)) {
      if(isPlayer(var_3)) {
        if(isDefined(var_11)) {
          if(var_11 == "rpg_player" || var_11 == "maaws") {
            thread chopper_damage_state();
            self.shot_with_rpg++;

            if(self.shot_with_rpg >= var_0) {
              thread chopper_scripted_death();
              return;
            }
          }
        }
      }
    }
  }
}

chopper_scripted_death() {
  common_scripts\utility::flag_set("defend_chopp2_dead");
  level.valid_missile_target = undefined;
  var_0 = randomintrange(420, 550);
  var_1 = [(-18376, 12256, var_0), (-17368, 12856, var_0), (-16400, 13392, var_0)];
  var_2 = common_scripts\utility::random(var_1);
  self.is_dying = 1;
  self.preferred_death_anim = "battle_hind_explode_singleV3";
  level.chopper_death_anim = self.preferred_death_anim;
  self notify("stop_shooting");
  self notify("stop_strafing");
  self notify("scripted_death");
  maps\_utility::vehicle_detachfrompath();
  thread chopper_custom_death_spin();
  self setvehgoalpos(var_2, 1);
  self vehicle_setspeed(50, 25);
  thread common_scripts\utility::play_loop_sound_on_entity("hind_helicopter_dying_loop");
  self setneargoalnotifydist(200);
  common_scripts\utility::waittill_notify_or_timeout("near_goal", 3);
  maps\_vehicle::godoff();
  common_scripts\utility::stop_loop_sound_on_entity("hind_helicopter_dying_loop");
  level thread common_scripts\utility::play_sound_in_space("hind_helicopter_hit", self.origin);
  self notify("stop_roatating");
  self kill(self.origin);
  earthquake(1, 0.7, level.player.origin, 500);
  self vehicle_turnengineoff();
  wait 2;
}

chopper_custom_death_spin() {
  self endon("stop_roatating");
  self clearlookatent();
  self setyawspeed(400, 100, 100);

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    var_0 = randomintrange(90, 120);
    self settargetyaw(self.angles[1] + var_0);
    wait 0.5;
  }
}

chopper_damage_state() {
  if(isDefined(self.is_damaged)) {
    return;
  }
  self.is_damaged = 1;
  playFXOnTag(common_scripts\utility::getfx("chopper_damage_smoke"), self, "tag_engine_left");
  self playSound("scn_deer_hind_pain1");
  wait 0.5;
  playFXOnTag(common_scripts\utility::getfx("chopper_damage_smoke2"), self, "tail_rotor_jnt");
  self waittill("scripted_death");
  self playSound("scn_deer_hind_pain2");
  stopFXOnTag(common_scripts\utility::getfx("chopper_damage_smoke"), self, "tag_engine_left");
  stopFXOnTag(common_scripts\utility::getfx("chopper_damage_smoke2"), self, "tail_rotor_jnt");
}

chopper_destroys_cover() {
  if(!isDefined(level.destroyed_hesco_count))
    level.destroyed_hesco_count = 0;

  if(level.destroyed_hesco_count >= 2) {
    return;
  }
  if(!isDefined(level.defend_cover_nodes))
    level.defend_cover_nodes = getnodearray("defend_cover_nodes", "script_noteworthy");

  var_0 = undefined;
  level.hescos = common_scripts\utility::array_randomize(level.hescos);
  var_1 = get_player_hesco();

  if(!isDefined(var_1))
    var_1 = common_scripts\utility::random(level.hescos);

  var_0 = maps\deer_hunt_util::shoot_rocket("zippy_rockets", var_1.origin);
  var_0 waittill("death");
  var_1 setscriptablepartstate(0, "destroyed");

  foreach(var_3 in level.defend_cover_nodes) {
    if(distance2dsquared(var_3.origin, var_1.trig.origin) < 1600) {
      var_3 common_scripts\utility::delaycall(4, ::disconnectnode);
      level.defend_cover_nodes = common_scripts\utility::array_remove(level.defend_cover_nodes, var_3);

      foreach(var_5 in getaiarray("allies")) {
        if(isDefined(var_5.node)) {
          if(var_5.node == var_3) {
            foreach(var_3 in level.defend_cover_nodes) {
              if(!isnodeoccupied(var_3)) {
                var_5 maps\_utility::disable_ai_color();
                var_5.goalradius = 32;
                var_5 setgoalnode(var_3);
                break;
              }
            }

            break;
          }
        }
      }

      break;
    }
  }

  level.hescos = common_scripts\utility::array_remove(level.hescos, var_1);
  level.destroyed_hesco_count++;
  return 1;
}

get_player_hesco() {
  foreach(var_2, var_1 in level.hescos) {
    if(level.player istouching(var_1.trig)) {
      maps\_utility::notify_delay("stop_shooting_mg", 2);
      return var_1;
    }
  }

  return undefined;
}

lariver_defend_globals(var_0) {
  maps\_utility::array_spawn_function_targetname("chopper_defend_pilots", ::lariver_assign_pilot_func);
  level.player_is_stunned = 0;
  level.valid_missile_target = undefined;
  thread lariver_setup_launchers();
  thread lariver_defend_guided_missile_setup();

  if(!isDefined(var_0)) {
    while(getaiarray("axis").size > 1)
      wait 0.15;

    var_1 = getaiarray("axis");

    if(isDefined(var_1))
      common_scripts\utility::array_thread(var_1, maps\deer_hunt_util::kill_me_from_closest_enemy);

    thread chopper_sounds_for_defend();
    thread maps\_utility::music_stop(30);
    wait 4;
    level.lariver_early_ai = maps\_utility::array_removedead(level.lariver_early_ai);
    common_scripts\utility::array_thread(level.lariver_early_ai, ::drone_stops_shooting);
  }

  common_scripts\utility::flag_set("squad_to_defend");
  var_2 = getEntArray("color_trig", "script_noteworthy");
  level notify("stop_custom_color_system");

  foreach(var_4 in var_2)
  var_4 common_scripts\utility::trigger_off();

  level thread chopper_achievement_check();
  maps\_utility::activate_trigger_with_targetname("squad_to_defend");
  var_1 = getaiarray("allies");
  common_scripts\utility::array_thread(var_1, maps\deer_hunt_util::ignore_me_ignore_all);
  var_6 = common_scripts\utility::getstruct("dog_drag_defend", "targetname");
  level maps\deer_hunt_util::dog_drag_to_cover(var_6, 6);
  thread lariver_defend_destructible_cover();
  thread lariver_defend_enemy_population();
  maps\_utility::autosave_by_name("defend_begin");
  maps\_utility::set_team_bcvoice("allies", "delta");
  common_scripts\utility::flag_wait("defend_chopp2_dead");
  wait 5;
  var_1 = getaiarray("axis");

  if(var_1.size > 0) {
    getent("squad_to_defend", "targetname") common_scripts\utility::trigger_off();
    common_scripts\utility::array_thread(getaiarray("allies"), maps\_utility::enable_ai_color);
    maps\_utility::activate_trigger_with_targetname("squad_charges_final_enemies");
    wait 6;
    var_1 = maps\_utility::array_removedead_or_dying(var_1);

    if(var_1.size > 0)
      common_scripts\utility::array_thread(var_1, maps\deer_hunt_util::kill_me_from_closest_enemy);
  }

  common_scripts\utility::flag_set("lariver_defend_bridge_clear");
}

chopper_sounds_for_defend() {
  level.bridge_chopper = maps\_vehicle::spawn_vehicle_from_targetname("lariver_defend_bridge_guys_chopper");
  wait 0.5;
  common_scripts\utility::array_thread(level.bridge_chopper.riders, maps\deer_hunt_util::ignore_me_ignore_all);
  common_scripts\utility::flag_wait("player_in_defend_area");
  common_scripts\utility::array_thread(level.bridge_chopper.riders, maps\deer_hunt_util::ignore_me_ignore_all_off);
}

chopper_achievement_check() {
  common_scripts\utility::flag_wait_all("player_killed_defend_aa72x", "defend_chopp2_dead");
  wait 5;
  level.player maps\_utility::player_giveachievement_wrapper("LEVEL_2A");
}

drone_stops_shooting() {
  self notify("stop_drone_fighting");
  wait(randomfloatrange(0.3, 1.3));
  thread maps\_drone::drone_idle();
}

lariver_setup_launchers() {
  var_0 = getEntArray("left_launchers", "targetname");
  var_1 = getEntArray("right_launchers", "targetname");
  var_2 = [var_0[0], var_0[1], var_1[0], var_1[1]];
  common_scripts\utility::array_thread(var_2, maps\deer_hunt_util::set_flag_on_weapon_pickup, "player_picked_up_launcher");
  common_scripts\utility::array_thread(var_2, ::replenish_on_pickup);
  common_scripts\utility::flag_wait_or_timeout("player_in_defend_area", 5);
  var_3 = [];
  var_3[0] = spawn_obj_on_launchers(var_0);
  var_3[1] = spawn_obj_on_launchers(var_1);
  common_scripts\utility::flag_wait("player_picked_up_launcher");

  foreach(var_5 in var_3)
  var_5 delete();
}

spawn_obj_on_launchers(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_3 = var_2 maps\deer_hunt_util::spawn_model_on_me("weapon_maaws_obj");
      return var_3;
    }
  }
}

replenish_on_pickup() {
  level endon("defend_chopp2_dead");
  var_0 = self.origin;
  var_1 = self.angles;
  var_2 = self;

  for(;;) {
    var_2 waittill("trigger");
    level.player givemaxammo("maaws");
    var_3 = spawn("weapon_maaws", var_0, 1);
    var_3.angles = var_1;
    var_2 = var_3;
  }
}

lariver_defend_destructible_cover() {
  level.hescos = [];
  var_0 = 6;
  var_1 = 0;

  for(var_2 = 0; var_2 <= var_0; var_2++) {
    if(var_2 == 0) {
      var_1++;
      continue;
    }

    var_3 = "hesco_" + var_2;
    level.hescos[var_1] = getent(var_3, "targetname");
    var_1++;
  }

  common_scripts\utility::array_thread(level.hescos, ::hesco_logic);
}

hesco_logic() {
  var_0 = strtok(self.model, "_");

  if(var_0[0] == "concrete") {
    var_1 = self.angles;
    var_1 = (0, var_1[1], 0);
    var_2 = anglestoright(var_1);
    var_3 = var_2 * -54;
    var_4 = self.origin + var_3;
  } else
    var_4 = maps\deer_hunt_util::get_spot_in_front_of_ent(54);

  self.trig = spawn("trigger_radius", var_4, 0, 30, 128);
}

lariver_defend_guided_missile_setup() {
  level endon("la_river_complete");
  var_0 = level.player getplayerangles();
  var_1 = anglesToForward(var_0);
  var_2 = var_1 * 10000;
  var_3 = level.player.origin + var_2;
  var_4 = level.player getEye();
  level.missile_target = spawn("script_model", var_3);
  level.missile_target setModel("tag_origin");
  level.player.laser_ent = spawn("script_model", (0, 0, 0));
  level.player.laser_ent setModel("tag_laser");
  level.player.laser_ent.angles = level.player.angles;
  level.player.laser_ent linktoplayerview(level.player, "tag_origin", (0, -30, 5), (0, 0, 0), 0);
  level.player thread lariver_defend_player_laser_toggle();
  level.player thread laser_hint();
  maps\_utility::setsaveddvar_cg_ng("laserRadius", 1, 1.5);
  var_5 = 50000;
  setsaveddvar("laserRange", var_5);
  setsaveddvar("laserRangePlayer", var_5);
  setsaveddvar("LaserLightRadius", 7);
  level thread lariver_defend_missile_attractor_logic();
  level thread la_river_defend_missile_dist_check();

  for(;;) {
    var_6 = level.player getcurrentweapon();

    if(var_6 == "maaws") {
      level.player setweaponammoclip(var_6, 2);
      return;
    }

    wait 0.25;
  }
}

lariver_defend_missile_attractor_logic() {
  level endon("la_river_complete");
  level.dummy_ent = common_scripts\utility::spawn_tag_origin();
  level.missile_target.tagged_ent = level.dummy_ent;
  level.is_playing_locked_on_sound = 0;
  var_0 = (0, 0, -60);
  var_1 = 50;
  var_2 = maps\_utility::getdifficulty();

  switch (var_2) {
    case "easy":
      var_1 = 60;
      break;
    case "medium":
      var_1 = 60;
      break;
    case "fu":
    case "hard":
      var_1 = 60;
      break;
  }

  for(;;) {
    if(level.player.is_targeting && enemy_chopper_within_circle(var_1)) {
      level.missile_target.origin = level.valid_missile_target.origin + var_0;

      if(level.valid_missile_target != level.missile_target.tagged_ent)
        level.missile_target.tagged_ent = level.valid_missile_target;
    } else if(level.player.is_targeting) {
      var_3 = anglesToForward(level.player getplayerangles());
      var_4 = var_3 * 10000;
      var_5 = var_3 * 250;
      var_6 = bulletTrace(level.player getEye() + var_5, level.player.origin + var_4, 1, level.player, 1, 0, 1);
      level.missile_target.origin = var_6["position"];

      if(isDefined(var_6["entity"])) {
        if(var_6["entity"] != level.missile_target.tagged_ent)
          level.missile_target.tagged_ent = var_6["entity"];
      }

      level.missile_target.tagged_ent = level.dummy_ent;
    }

    wait 0.05;
  }
}

enemy_chopper_within_circle(var_0) {
  var_1 = getdvarint("cg_fov", 65);

  if(isDefined(level.valid_missile_target)) {
    if(target_isincircle(level.valid_missile_target, level.player, var_1, var_0))
      return 1;

    return 0;
  }

  return 0;
}

make_me_a_target() {
  if(isDefined(self.is_targeted)) {
    return;
  }
  self.is_targeted = 1;
  target_set(self);

  foreach(var_1 in level.players)
  target_hidefromplayer(self, var_1);
}

chopper_outline_monitor() {
  return;
}

play_locked_on_sound() {
  if(level.is_playing_locked_on_sound) {
    return;
  }
  level.is_playing_locked_on_sound = 1;
  level.player maps\_utility::play_sound_on_entity("laser_guided_missile_locked");
  level.is_playing_locked_on_sound = 0;
}

disable_hudoutline_on_death() {
  self waittill("death");
  self notify("stop_monitoring_outline");

  if(isDefined(self))
    self hudoutlinedisable();
}

la_river_defend_missile_dist_check() {
  level endon("player_in_matv");

  for(;;) {
    level.player waittill("missile_fire", var_0);
    var_0 missile_settargetent(level.missile_target);

    if(!common_scripts\utility::flag("defend_chopp2_dead")) {
      var_0 thread missile_dist_internal();
      level thread chopper_reacts_to_lockon();
    }
  }
}

chopper_reacts_to_lockon() {
  if(!common_scripts\utility::flag("spawn_defend_chopper2")) {
    return;
  }
  if(!common_scripts\utility::flag("chopper_fight_start")) {
    return;
  }
  var_0 = 70;

  if(level.chopper2 == level.missile_target.tagged_ent) {
    wait(randomfloatrange(0.5, 1));
    level.chopper2 chopper_side_dodge();
  } else if(randomint(100) < var_0) {
    wait(randomfloatrange(0.5, 1));
    level.chopper2 chopper_side_dodge();
  }
}

missile_dist_internal() {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(level.choppers)) {
    return;
  }
  self endon("death");
  var_0 = 1210000;

  while(isDefined(self)) {
    foreach(var_2 in level.choppers) {
      if(isDefined(var_2) && distancesquared(self.origin, var_2.origin) <= var_0) {
        var_2 thread chopper_decoys_and_evade(self);
        return;
      }
    }

    wait 0.1;
  }
}

chopper_decoys_and_evade(var_0) {
  if(isDefined(self.did_flares) || self.shot_with_rpg == 0 || common_scripts\utility::flag("defend_chopp2_dead")) {
    return;
  }
  self.did_flares = 1;

  if(isDefined(var_0)) {
    var_1 = var_0.origin;
    thread maps\deer_hunt_util::shootflares(var_0);
    thread chopper_side_dodge();
    wait 1;
    playFX(common_scripts\utility::getfx("chopper_flare_explosion"), var_1);
    level thread common_scripts\utility::play_sound_in_space("chopper_trophy_fire", var_1);

    if(isDefined(var_0))
      var_0 delete();
  }
}

lariver_defend_player_laser_toggle() {
  level endon("player_in_matv");
  createthreatbiasgroup("missile_player");
  thread lariver_defend_playerbias();
  level.player.is_targeting = 0;
  level thread lariver_ignore_player_if_in_defend_area();

  for(;;) {
    self waittill("weapon_change");
    var_0 = level.player getcurrentweapon();

    if(var_0 == "maaws") {
      level.player laserforceon();
      level.player.is_targeting = 1;
      level.player disableautoreload();
      continue;
    }

    level.player laserforceoff();
    level.player setthreatbiasgroup("allies");
    level.player.is_targeting = 0;
    level.player enableautoreload();
  }
}

lariver_ignore_player_if_in_defend_area() {
  level endon("load_matv");
  var_0 = getent("player_defend_area", "script_noteworthy");

  for(;;) {
    if(level.player istouching(var_0))
      level.player setthreatbiasgroup("missile_player");
    else
      level.player setthreatbiasgroup("allies");

    wait 1;
  }
}

lariver_defend_playerbias() {
  common_scripts\utility::flag_wait("squad_to_defend");
  setignoremegroup("missile_player", "axis");
}

laser_hint() {
  level endon("defend_chopp2_dead");

  for(;;) {
    self waittill("weapon_change");
    var_0 = level.player getcurrentweapon();

    if(var_0 == "maaws") {
      maps\_utility::display_hint_timeout("laser_hint", 6);
      thread periodically_display_laser_hint();
      return;
    }
  }
}

periodically_display_laser_hint() {
  level endon("defend_chopp2_dead");

  for(;;) {
    var_0 = 25;
    wait(var_0);

    while(maps\deer_hunt_util::player_is_using_missile_launcher() || level.player_is_stunned == 1 || level.player isreloading())
      wait 0.5;

    maps\_utility::display_hint_timeout("laser_hint", 6);
  }
}

la_river_defend_weapons_spawn() {
  if(!isDefined(level.possible_guns)) {
    return;
  }
  level.possible_guns = common_scripts\utility::array_randomize(level.possible_guns);
  level.defend_weapons = [];
  var_0 = common_scripts\utility::getStructArray("defend_weapons", "targetname");

  foreach(var_6, var_2 in var_0) {
    if(!isDefined(level.possible_guns[var_6])) {
      return;
    }
    var_3 = check_weapon(level.possible_guns[var_6]);

    if(isDefined(var_3)) {
      var_4 = "weapon_" + var_3;
      var_5 = spawn(var_4, var_2.origin);
      level.defend_weapons = common_scripts\utility::add_to_array(level.defend_weapons, var_3);
    }
  }
}

check_weapon(var_0) {
  var_1 = strtok(var_0, "+");

  if(!isDefined(var_1[1]))
    return undefined;

  if(level.defend_weapons.size == 0)
    return var_0;
  else {
    foreach(var_3 in level.defend_weapons) {
      var_4 = strtok(var_3, "+");

      if(var_4[0] == var_1[0])
        return undefined;
    }

    return var_0;
  }
}

lariver_defend_enemy_population() {
  maps\_utility::array_spawn_function_targetname("defend_bridge_spawner", ::lariver_bridge_enemy_logic);
  maps\_utility::array_spawn_function_noteworthy("slide", ::lariver_defend_slide_down_river_wall);
  level.close_enemy_volume = getent("close_volume", "targetname");
  thread lariver_defend_is_player_in_defend_area();
  common_scripts\utility::flag_wait_or_timeout("player_in_defend_area", 20);
  maps\deer_hunt_util::set_flag_if_not_set("player_in_defend_area");
  var_0 = [];

  foreach(var_3, var_2 in level.lariver_early_ai) {
    var_2 maps\_utility::stop_magic_bullet_shield();
    var_0[var_3] = maps\_spawner::spawner_makerealai(var_2);
    wait 0.1;

    if(isDefined(var_0[var_3]))
      var_0[var_3] maps\deer_hunt_util::ignore_me_ignore_all();
  }

  level.balcony_friendlies = maps\_utility::array_removedead(level.balcony_friendlies);
  level.balcony_friendlies = common_scripts\utility::array_combine(level.balcony_friendlies, var_0);
  maps\_utility::battlechatter_on();
  maps\_utility::flavorbursts_on();
  thread lariver_defend_bridge_enemies();
  thread lariver_defend_spawn_choppers();
  common_scripts\utility::flag_wait_or_timeout("player_killed_defend_aa72x", 25);
  common_scripts\utility::flag_set("spawn_defend_choppers");
  common_scripts\utility::flag_set("defend_chopp1_dead");
  common_scripts\utility::flag_set("spawn_defend_chopper2");
  common_scripts\utility::flag_wait("defend_chopp1_dead");
  maps\_spawner::killspawner(200);

  while(getaiarray("axis").size > 3)
    wait 1;

  common_scripts\utility::flag_set("spawn_defend_chopper2");
  common_scripts\utility::flag_wait("defend_chopp2_dead");

  while(getaiarray("axis").size > 0)
    wait 1;

  maps\_utility::autosave_by_name("matv_load");
  wait 3;
  thread lariver_matv_load_and_go();
}

lariver_matv_load_and_go() {
  level thread lariver_matv_ride();
  common_scripts\utility::flag_set("load_matv");
  thread wall_ride_cilivians();
  wait 2;
  var_0 = level.team2[0];
  var_0.script_startingposition = 0;
  level.hesh.script_startingposition = 1;
  var_0 maps\_utility::disable_ai_color();
  level.hesh maps\_utility::disable_ai_color();
  var_1 = getnode("team2_standby", "targetname");
  level.team2[1] maps\_utility::disable_ai_color();
  level.team2[1] maps\_utility::disable_cqbwalk();
  level.team2[1].goalradius = 32;
  level.team2[1] maps\_utility::enable_readystand();
  level.team2[1] common_scripts\utility::delaycall(3, ::setgoalnode, var_1);
  level.matv maps\_vehicle::vehicle_load_ai([var_0, level.hesh]);
  level.matv hidepart("ramp_jnt");
  level.matv.obj_ent show();
  var_2 = getnode("riley_jeep-", "targetname");
  level.dog maps\_utility::disable_ai_color();
  level.dog.goalradius = 32;
  level.dog maps\_utility::delaythread(4, ::lariver_matv_dog_nag, var_2);
  thread maps\deer_hunt_util::hesh_nag_til_flag("player_in_matv", 10);
  player_gets_in_matv();
  level.matv.obj_ent hide();

  while(level.matv.riders.size != 2)
    wait 0.5;

  common_scripts\utility::flag_set("matv_loaded");
  thread lariver_transition_to_beach();
}

lariver_matv_dog_nag(var_0) {
  self setgoalnode(var_0);
  self waittill("goal");

  while(!common_scripts\utility::flag("player_in_matv")) {
    maps\_utility_dogs::dog_bark();

    if(common_scripts\utility::cointoss())
      maps\_utility_dogs::dog_bark();

    wait(randomintrange(6, 9));
  }
}

lariver_transition_to_beach() {
  common_scripts\utility::flag_wait("lariver_turn");
  var_0 = 1;
  thread maps\deer_hunt_util::fade_out_in("black", "fade_in_jeep_ride", undefined, var_0);
  wait(var_0);
  level.player common_scripts\utility::delaycall(1, ::stoprumble, "vegas_drag");
  maps\_utility::transient_switch("deer_hunt_intro_tr", "deer_hunt_beach_tr");
  common_scripts\utility::flag_set("la_river_complete");
  getent("hesh", "targetname") maps\_utility::remove_spawn_function(::hesh_logic);
  getent("dog", "targetname") maps\_utility::remove_spawn_function(::dog_logic);
  maps\deer_hunt_ride::jeep_ride_setup();
}

chopper_crash_fx_cleanup() {
  level.stopped_crash_fx = [];
  var_0 = level.scr_notetrack["battle_hind"][level.chopper_death_anim];

  foreach(var_2 in var_0) {
    foreach(var_4 in var_2)
    stop_crash_fx_in_array(var_4);
  }
}

stop_crash_fx_in_array(var_0) {
  if(!isDefined(var_0["selftag"])) {
    return;
  }
  var_1 = undefined;

  if(var_0["selftag"] == "tag_fx_expl_missile" || var_0["selftag"] == "tag_fx_expl_fuel") {
    return;
  }
  if(isDefined(var_0["effect"]))
    var_1 = common_scripts\utility::getfx(var_0["effect"]);
  else if(isDefined(var_0["trace_part_for_efx"]))
    var_1 = common_scripts\utility::getfx(var_0["trace_part_for_efx"]);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = var_0["selftag"];
  iprintln("stopping fx: " + var_1 + " on tag " + var_2);
  stopFXOnTag(var_1, self, var_2);
  level.stopped_crash_fx = common_scripts\utility::add_to_array(level.stopped_crash_fx, var_2);
}

#using_animtree("player");

player_gets_in_matv() {
  var_0 = "tag_gunner";
  var_1 = getstartorigin(level.matv gettagorigin("tag_gunner"), level.matv gettagangles("tag_gunner"), %dh_matv_getin_player);
  level.player_rig = maps\_utility::spawn_anim_model("player_rig", var_1);
  level.player_rig.angles = level.matv.angles;
  level.player_rig hide();
  level.player_rig linkto(level.matv, "tag_player");
  var_2 = maps\_utility::groundpos(var_1 + (0, 0, 300));
  var_3 = spawn("script_origin", var_2, 0, 300, 200);
  var_4 = maps\deer_hunt_util::getactionbind("matv_enter");
  var_3 sethintstring(var_4.hint);
  var_3 makeusable();
  thread matv_player_jumped_in(var_3);
  var_3 waittill("trigger");
  var_3 sethintstring("");
  common_scripts\utility::flag_set("player_in_matv");
  level.player disableweapons();
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);

  if(isDefined(level.player.laser_ent)) {
    level.player.laser_ent laserforceoff();
    level.player.laser_ent delete();
  }

  level.player thread maps\_utility::play_sound_on_entity("scn_deer_truck_plr_getin");
  level.player thread maps\_utility::play_sound_on_entity("scn_deer_jeep_start_drive");
  maps\_utility::delaythread(2.3, common_scripts\utility::play_sound_in_space, "scn_deer_truck_call_dog", (-18343, 15331, -486));
  maps\_utility::delaythread(2.3, common_scripts\utility::play_sound_in_space, "scn_deer_truck_dog_getin", (-18320, 15365, -486));
  var_5 = getanimlength(%dh_matv_getin_player);
  level.matv thread maps\_anim::anim_single_solo(level.player_rig, "matv_player_getin", var_0);
  level.player common_scripts\utility::delaycall(0.5, ::playrumbleonentity, "damage_heavy");
  level.player common_scripts\utility::delaycall(0.95, ::playrumbleonentity, "damage_light");
  level.player common_scripts\utility::delaycall(1.7, ::playrumbleonentity, "damage_heavy");
  level.player playerlinktoblend(level.player_rig, "tag_player", 0.4, 0.2, 0.2);
  wait 0.5;
  level.player playerlinktodelta(level.player_rig, "tag_player", 1, 40, 40, 50, 30, 0);
  level.player_rig show();
  setsaveddvar("ammocounterHide", "1");
  wait(var_5);
  level.player_rig hide();
}

matv_player_jumped_in(var_0) {
  var_1 = 2500;
  level endon("player_in_matv");

  for(;;) {
    if(distance2dsquared(var_0.origin, level.player.origin) < var_1 && level.player jumpbuttonPressed()) {
      while(!level.player isonground())
        wait 0.05;

      var_0 useby(level.player);
      return;
    }

    wait 0.05;
  }
}

wall_ride_cilivians() {
  common_scripts\utility::flag_wait("load_matv");
  var_0 = common_scripts\utility::getStructArray("river_gate_civs", "targetname");
  var_1 = getent("river_gate_civ", "targetname");
  level.river_drones = maps\deer_hunt_ride::spawn_ai_for_structs(var_1, var_0, 1);
  var_0 = common_scripts\utility::getStructArray("river_gate_soldiers", "targetname");
  var_1 = getent("river_soldier_spawner", "targetname");
  var_2 = maps\deer_hunt_ride::spawn_ai_for_structs(var_1, var_0, 1);
  level.river_drones = common_scripts\utility::array_combine(level.river_drones, var_2);
  common_scripts\utility::flag_wait("lariver_turn");
  wait 2;
  maps\_utility::array_delete(level.river_drones);
}

dog_gets_in_matv() {
  wait 2;
  level.dog.animname = "dog";
  level.matv maps\_anim::anim_single_solo(level.dog, "matv_enter", "tag_dog");
  level.dog linkto(level.matv, "tag_dog");
  level.matv thread maps\_anim::anim_loop_solo(level.dog, "matv_idle", "stop_loop", "tag_dog");
}

lariver_matv_ride() {
  thread lariver_matv_open_doors();
  common_scripts\utility::flag_wait("open_gate");
  thread lariver_ride_cowbell();
  wait 3.6;
  level.matv vehicle_turnengineoff();
  level.matv maps\_vehicle::gopath();
  level.player playrumblelooponentity("vegas_drag");
  level.matv vehicle_setspeedimmediate(8, 2);
  wait 3;
  level.matv vehicle_setspeed(20, 5);
}

matv_sounds() {
  level.player thread maps\_utility::play_sound_on_entity("scn_deer_jeep_start_drive");
}

lariver_ride_cowbell() {
  var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("river_vehicles");
  var_1 = maps\_utility::array_spawn_targetname("lariver_runners", 1);
  wait 4;
  var_2 = maps\_utility::array_spawn_targetname("river_gate_civ_runners", 1);
  common_scripts\utility::flag_wait("la_river_complete");
  maps\_utility::array_delete(var_0);
}

lariver_matv_open_doors() {
  thread lariver_doors_sound_setup();
  common_scripts\utility::flag_wait("open_gate");
  var_0 = ["river_door_left", "river_door_right"];
  maps\deer_hunt_util::set_flag_if_not_set("gate_opening");

  foreach(var_4, var_2 in var_0) {
    var_2 = getent(var_2, "targetname");

    if(var_4 == 1)
      var_3 = (120, 0, 0);
    else
      var_3 = (-120, 0, 0);

    var_2 moveto(var_2.origin + var_3, 5.6, 2.8, 2.8);
    var_2 common_scripts\utility::delaycall(5.6, ::connectpaths);
    var_2 common_scripts\utility::delaycall(5.6, ::disconnectpaths);
  }
}

lariver_doors_sound_setup() {
  var_0 = getent("river_door_left", "targetname");
  var_1 = getent("river_door_right", "targetname");
  var_0 create_door_sound_ents((-18417, 15837, -535), (-18696, 15837, -535));
  var_1 create_door_sound_ents((-18349, 15858, -537), (-18057, 15858, -537));
  var_2 = spawn("script_origin", (-18371, 15820, -349));
  var_3 = spawn("script_origin", (-18372, 15733, -17));
  var_4 = spawn("script_origin", (-17721, 15733, -136));
  var_5 = (-18550, 16695, -465);
  var_6 = (-18057, 16695, -476);
  common_scripts\utility::flag_wait("load_matv");
  wait 5;
  thread lariver_doors_siren();
  var_4 thread common_scripts\utility::play_loop_sound_on_entity("scn_deer_wall_alarm1");
  common_scripts\utility::flag_wait("matv_loaded");
  var_0.corner_sound_ent thread maps\_utility::play_sound_on_entity("scn_deer_wall_unlock_left_corner");
  var_1.corner_sound_ent thread maps\_utility::play_sound_on_entity("scn_deer_wall_unlock_right_corner");
  var_2 thread maps\_utility::play_sound_on_entity("scn_deer_wall_unlock_middle");
  wait 4;
  var_3 thread maps\_utility::play_sound_on_entity("scn_deer_wall_alarm2");
  wait 1.68;
  common_scripts\utility::flag_set("open_gate");
  var_0 thread door_play_sounds("scn_deer_wall_open_left_edge", "scn_deer_wall_open_left_corner");
  var_1 thread door_play_sounds("scn_deer_wall_open_right_edge", "scn_deer_wall_open_right_corner");
  var_2 thread maps\_utility::play_sound_on_entity("scn_deer_wall_open_middle");
  wait 3.15;
  thread common_scripts\utility::play_sound_in_space("scn_deer_wall_crowd_left", var_5);
  thread common_scripts\utility::play_sound_in_space("scn_deer_wall_crowd_right", var_6);
  wait 1.5;
  var_0.corner_sound_ent thread maps\_utility::play_sound_on_entity("scn_deer_wall_stop_left");
  var_1.corner_sound_ent thread maps\_utility::play_sound_on_entity("scn_deer_wall_stop_right");
  var_2 thread maps\_utility::play_sound_on_entity("scn_deer_wall_stop_middle");
  wait 2;
  var_2 thread maps\_utility::play_sound_on_entity("scn_deer_wall_transition_middle");
  wait 1;
  var_0.edge_sound_ent thread maps\_utility::play_sound_on_entity("scn_deer_wall_close_stop_left");
  var_1.edge_sound_ent thread maps\_utility::play_sound_on_entity("scn_deer_wall_close_stop_right");
  var_2 thread maps\_utility::play_sound_on_entity("scn_deer_wall_close_stop_middle");
  var_4 notify("stop soundscn_deer_wall_alarm1");
}

lariver_doors_siren() {
  var_0 = [(-18553, 15385, -255), (-18232, 15384, -255)];
  var_1 = getEntArray("wall_sirens", "targetname");
  var_2 = [];
  var_3 = 1;

  foreach(var_6, var_5 in var_1) {
    var_2[var_6] = common_scripts\utility::spawn_tag_origin();
    var_2[var_6].origin = var_5.origin;
    var_2[var_6].angles = var_5.angles;
    var_2[var_6] thread siren_logic(var_3);
    var_3++;
  }
}

siren_logic(var_0) {
  wait(var_0);
  playFXOnTag(common_scripts\utility::getfx("siren_red"), self, "tag_origin");
  var_1 = randomfloatrange(0.4, 0.6);

  while(!common_scripts\utility::flag("lariver_turn")) {
    self rotatepitch(360, var_1);
    self waittill("rotatedone");
  }

  stopFXOnTag(common_scripts\utility::getfx("siren_red"), self, "tag_origin");
  wait 0.05;
  self delete();
}

create_door_sound_ents(var_0, var_1) {
  self.corner_sound_ent = spawn("script_origin", var_1);
  self.edge_sound_ent = spawn("script_origin", var_0);
  self.corner_sound_ent linkto(self);
  self.edge_sound_ent linkto(self);
}

door_play_sounds(var_0, var_1) {
  if(isDefined(var_0))
    self.edge_sound_ent thread maps\_utility::play_sound_on_entity(var_0);

  if(isDefined(var_1))
    self.corner_sound_ent thread maps\_utility::play_sound_on_entity(var_1);
}

lariver_defend_is_player_in_defend_area() {
  level endon("player_in_defend_area");
  var_0 = getent("player_defend_area", "script_noteworthy");

  while(!level.player istouching(var_0))
    wait 0.25;

  common_scripts\utility::flag_set("player_in_defend_area");
}

lariver_defend_bridge_enemies() {
  level endon("defend_chopp2_dead");
  common_scripts\utility::flag_wait("player_in_defend_area");
  var_0 = level.bridge_chopper;
  maps\_vehicle::gopath(var_0);
  var_0 thread make_me_a_target();
  level.valid_missile_target = var_0;
  var_0 thread lariver_defend_aa72x_missile_detection();
  var_0 thread chopper_outline_monitor();
  var_0 common_scripts\utility::waittill_any("unloaded", "death");
  var_1 = getaiarray("allies");
  common_scripts\utility::array_thread(var_1, maps\deer_hunt_util::ignore_me_ignore_all_off);
  var_2 = 2;
  level.bridge_enemies = [];
  var_3 = maps\_utility::getdifficulty();

  switch (var_3) {
    case "easy":
      var_2 = 1;
      break;
    case "medium":
      var_2 = 3;
      break;
    case "fu":
    case "hard":
      var_2 = 5;
      break;
  }

  var_4 = getEntArray("defend_bridge_spawner", "targetname");

  for(;;) {
    level.bridge_enemies = maps\_utility::array_removedead_or_dying(level.bridge_enemies);

    if(level.bridge_enemies.size < var_2) {
      var_5 = common_scripts\utility::random(var_4);
      var_6 = var_5 maps\_utility::spawn_ai();

      if(!maps\_utility::spawn_failed(var_6))
        level.bridge_enemies = common_scripts\utility::add_to_array(level.bridge_enemies, var_6);
    }

    wait(randomintrange(4, 8));
  }
}

lariver_defend_aa72x_missile_detection() {
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(maps\deer_hunt_util::array_is_defined([var_9, var_1]) && var_9 == "maaws" && isPlayer(var_1)) {
      self kill((0, 0, 0), level.player);
      common_scripts\utility::flag_set("player_killed_defend_aa72x");

      if(isDefined(level.chopper2)) {
        level.chopper2 thread make_me_a_target();
        level.valid_missile_target = level.chopper2;
      }

      return;
    }
  }
}

lariver_bridge_enemy_logic() {
  maps\_utility::disable_long_death();
  self.goalradius = 32;
}

lariver_defend_populate_close_area() {
  level endon("defend_chopp1_dead");
  common_scripts\utility::flag_wait("spawn_close_guys");
  var_0 = getEntArray("defend_left_close", "targetname");
  var_1 = getEntArray("defend_right_close", "targetname");
  var_2 = getEntArray("defend_back_flood_spawner", "targetname");
  thread maps\_utility::flood_spawn(var_2);
  wait 15;
  iprintln("slide guys");
  var_3 = level.close_enemy_volume;

  if(!player_is_on_right_incline()) {
    var_4 = var_1;
    var_5 = "right_spawners";
  } else {
    var_4 = var_0;
    var_5 = "left_spawners";
  }

  for(;;) {
    var_6 = var_3 maps\_utility::get_ai_touching_volume("axis");

    if(var_6.size < 5) {
      var_7 = common_scripts\utility::random(var_4);
      var_7.count = 1;
      var_8 = var_7 maps\_utility::spawn_ai();

      if(!maps\_utility::spawn_failed(var_8)) {
        if(var_5 == "right_spawners" && !player_is_on_left_incline()) {
          var_4 = var_0;
          var_5 = "left_spawners";
        } else if(var_5 == "left_spawners" && !player_is_on_right_incline()) {
          var_4 = var_1;
          var_5 = "right_spawners";
        }
      }
    }

    wait(randomfloatrange(1, 4));
  }
}

player_is_on_right_incline() {
  return level.player istouching(getent("defend_right_incline", "targetname"));
}

player_is_on_left_incline() {
  return level.player istouching(getent("defend_left_incline", "targetname"));
}

lariver_defend_enemy_global_logic() {
  self.grenadeammo = 0;
}

lariver_defend_slide_down_river_wall() {
  thread lariver_defend_enemy_global_logic();
  lariver_slide_anim(self, common_scripts\utility::getstruct(self.target, "targetname"));
  self setgoalvolumeauto(level.close_enemy_volume);
}

lariver_enemies() {
  maps\_utility::array_spawn_function_noteworthy("lariver_enemies", ::lariver_enemies_global_logic);
  maps\_utility::array_spawn_function_noteworthy("lariver_enemies", maps\deer_hunt_color_system::enemy_color_volume_logic);
  maps\_utility::array_spawn_function_targetname("chopper_guys", ::lariver_enemies_global_logic);
  maps\_utility::array_spawn_function_targetname("lariver_frontline", ::lariver_frontline_logic);
  common_scripts\utility::flag_wait("pipe_halfway");
  common_scripts\utility::exploder(2);
  maps\_utility::array_spawn_targetname("lariver_frontline", 1);
  wait 0.5;
  level.chopper = maps\_utility::get_vehicle("lariver_enemy_chopper", "targetname");
  level.chopper thread lariver_enemy_chopper_logic();
  level thread kill_bridge_guys();
  level thread lariver_bridge_rappel_enemies();
  level thread lariver_bridge_drones();
  var_0 = getEntArray("lariver_flood_filler", "targetname");

  foreach(var_2 in var_0)
  var_2.count = 10;

  maps\_utility::flood_spawn(var_0);
  common_scripts\utility::flag_wait("la_river_complete");
}

lariver_assign_pilot_func() {
  self endon("death");
  self allowedstances("crouch");
  common_scripts\utility::flag_wait("player_killed_defend_aa72x");
  wait(randomfloatrange(0.2, 1));

  if(!isalive(self)) {
    return;
  }
  self startragdoll();
}

lariver_stop_pilot_stand_on_death() {
  self.allowdeath = 1;
  self.a.nodeath = 1;
  self.ragdoll_immediate = 1;
  self.forceragdollimmediate = 1;
}

lariver_frontline_logic() {
  self endon("death");
  var_0 = getnode(self.target, "targetname");
  var_1 = getent("enemy_line_2", "targetname");
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.script_forcegoal = 1;
  common_scripts\utility::flag_wait("pipe_exit");
  self setgoalvolumeauto(var_1);
  self.ignoreall = 0;

  if(randomint(100) < 20) {
    wait(randomintrange(1, 3));
    self.goalradius = 32;
    self setgoalnode(var_0);
    wait 5;
    self setgoalvolumeauto(var_1);
    self.ignoreme = 0;
  }
}

lariver_bridge_drones() {
  var_0 = getEntArray("bridge_drones", "targetname");
  level endon("color_line_2");

  for(;;) {
    var_1 = maps\_utility::dronespawn(common_scripts\utility::random(var_0));
    wait(randomintrange(3, 6));
  }
}

#using_animtree("generic_human");

lariver_bridge_rappel_enemies() {
  common_scripts\utility::flag_wait("player_under_bridge");

  while(level.player.origin[2] > -410)
    wait 1;

  var_0 = common_scripts\utility::getStructArray("rappel_spot", "targetname");
  var_1 = common_scripts\utility::getclosest(level.player.origin, var_0);
  var_2 = maps\_utility::groundpos(var_1.origin) + (0, 0, 810);
  var_3 = var_1.angles;
  var_4 = (0, 0, 57);
  var_5 = (0, -20, -12);
  var_6 = (0, 90, 0);
  var_7 = spawn("script_model", var_2);
  var_7.angles = var_1.angles + (0, 0, 90);
  var_7 setModel("tag_origin");
  var_8 = common_scripts\utility::random(getEntArray("defend_bridge_spawner", "targetname"));
  var_8.count = 100;
  var_9 = var_8 maps\_utility::spawn_ai(1);
  level.rappel_guy = var_9;
  var_9.ignoreme = 1;
  var_9 thread maps\_utility::magic_bullet_shield();
  var_9 thread rappel_guy_internal();
  var_9 linkto(var_7, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_9.team = "axis";
  var_10 = spawn("script_model", var_2);
  var_10 setModel("fastrope_80ft_ri");
  var_10 useanimtree(#animtree);
  var_10 linkto(var_7, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_11 = 0.5 / getanimlength(%bh_1_drop);
  var_12 = 4 / getanimlength(%bh_rope_drop_ri);
  var_9 animscripted("start_rappel", var_7.origin + var_5, var_6, %bh_1_drop);
  var_10 animscripted("start_rappel", var_7.origin + var_4, var_7.angles, %bh_rope_drop_ri);
  wait 0.05;
  var_9 setanimtime(%bh_1_drop, var_12);
  var_10 setanimtime(%bh_rope_drop_ri, var_11);
  wait 0.05;
  var_10 setflaggedanim("single anim", %bh_rope_drop_ri, 1, 0, 2.8);
  wait 4;

  if(isDefined(var_9)) {
    var_9.ignoreme = 0;
    var_9 unlink();
    var_9.goalradius = 800;
    var_9 notify("stopScript");
    var_9 findbestcovernode();

    if(isDefined(var_9.magic_bullet_shield))
      var_9 maps\_utility::stop_magic_bullet_shield();
  }
}

rappel_guy_internal() {
  self endon("stopScript");

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(isDefined(var_1)) {
      if(var_1 == level.player) {
        if(isDefined(self.magic_bullet_shield))
          maps\_utility::stop_magic_bullet_shield();

        self stopanimscripted();
        maps\_utility::die();
        self startragdoll();
      }
    }
  }
}

lariver_enemies_global_logic() {
  self endon("death");
  maps\deer_hunt_util::grenades_by_difficulty();
  self.script_forcegoal = 1;
  maps\_utility::set_ai_bcvoice("shadowcompany");
  self waittill("jumpedout");
  wait 2;
  var_0 = getnode(self.target, "targetname");

  if(isDefined(var_0)) {
    self.goalradius = 32;
    self setgoalnode(var_0);
  }
}

lariver_backline_guys_logic() {
  self.grenadeammo = 0;
  self setthreatbiasgroup("final_pos_enemies");
  thread maps\deer_hunt_util::only_take_damage_from_player("player_under_bridge");

  while(!isDefined(level.drone_targets))
    wait 0.25;

  wait 2;
  self setentitytarget(common_scripts\utility::random(level.drone_targets));
  common_scripts\utility::flag_wait("player_under_bridge");
  self endon("death");
  self endon("entitydeleted");
  wait 6;

  if(!isDefined(self)) {
    return;
  }
  self setthreatbiasgroup("axis");
  self clearentitytarget();
  var_0 = getent("enemy_line_4", "targetname");
  self setgoalvolumeauto(var_0);

  if(isDefined(self.magic_bullet_shield))
    thread maps\_utility::stop_magic_bullet_shield();
}

lariver_friendly_setup() {
  maps\_utility::battlechatter_on("allies");
  maps\_utility::array_spawn_function_targetname("fodder", ::lariver_fodder_friendly_logic);
  maps\_utility::array_spawn_targetname("fodder", 1);
}

lariver_fodder_friendly_logic() {
  self endon("death");
  self.baseaccuracy = 0.1;
  self.dropweapon = 0;
  thread maps\_utility::magic_bullet_shield();
  self.script_forcegoal = 1;
  self setgoalnode(getnode(self.target, "targetname"));
  common_scripts\utility::flag_wait("pipe_exit");
  wait(randomfloatrange(0.6, 1.4));
  maps\_utility::stop_magic_bullet_shield();
  maps\deer_hunt_util::kill_me_from_closest_enemy();
}

lariver_balcony_friendly_logic(var_0) {
  thread maps\_utility::magic_bullet_shield();
  self.grenadeammo = 0;

  if(!isDefined(level.drone_targets))
    level.drone_targets = [];

  var_1 = spawn("script_origin", self.origin + (0, 0, 85));
  var_1 linkto(self);
  level.drone_targets = common_scripts\utility::add_to_array(level.drone_targets, var_1);
}

lariver_rivertop_friendly_logic() {
  self.grenadeammo = 0;

  if(randomint(100) < 33)
    self laserforceon();

  self.dontevershoot = 1;
  thread maps\_utility::magic_bullet_shield();
  wait 6;
  self.dontevershoot = undefined;
  self.baseaccuracy = 3;
}

lariver_enemy_chopper_logic() {
  self endon("death");
  self.preferred_crash_style = 1;
  wait 2;
  self notify("stop_kicking_up_dust");
  self waittill("unloaded");
  wait 1.5;
  common_scripts\utility::array_thread(self.riders, ::lariver_chopper_passanger_logic);
  maps\_utility::delaythread(2, maps\_vehicle::aircraft_wash);
  self waittill("player_attacked_riders");
  self vehicle_setspeed(50, 10);
}

lariver_chopper_evade() {
  var_0 = self.currentnode.origin;
  self.currentnode.origin = self.currentnode.origin + (0, 0, 200);
  wait 5;
  self.currentnode.origin = self.currentnode.origin - (0, 0, 200);
}

lariver_chopper_passanger_logic() {
  self waittill("death", var_0);

  if(!isDefined(self.ridingvehicle)) {
    return;
  }
  if(isDefined(var_0)) {
    if(isPlayer(var_0))
      self.ridingvehicle notify("player_attacked_riders");
  }
}

kill_bridge_guys() {
  common_scripts\utility::flag_wait("player_under_bridge");

  while(level.player.origin[2] > -410)
    wait 1;

  foreach(var_1 in getaiarray("axis")) {
    if(isDefined(level.rappel_guy)) {
      if(var_1 == level.rappel_guy)
        continue;
    }

    if(var_1.origin[2] > -340)
      var_1 maps\_utility::die();
  }
}

lariver_team2_leader_logic() {
  thread maps\_utility::magic_bullet_shield();
  lariver_team2_logic();
}

lariver_team2_logic() {
  self.flavorbursts = 0;
  self.animname = "generic";
  maps\_utility::set_force_color("o");
  maps\_utility::enable_ai_color();
  maps\_utility::set_ai_bcvoice("american");
  self.grenadeammo = 0;
  maps\deer_hunt_util::ignore_me_ignore_all();
  maps\_utility::enable_cqbwalk();
  thread maps\_utility::magic_bullet_shield();
}

lariver_slide_anim(var_0, var_1) {
  var_0 endon("death");

  if(common_scripts\utility::cointoss())
    var_2 = "la_river_slide_1";
  else
    var_2 = "la_river_slide_2";

  var_0.allowdeath = 1;
  self.a.nodeath = 1;
  var_0.ragdoll_immediate = 1;
  var_0.animname = "generic";
  wait(randomfloatrange(0.5, 1.5));
  var_1 thread maps\_anim::anim_single_solo(var_0, var_2);
  wait 0.05;
  maps\_anim::anim_set_rate_single(var_0, var_2, 1.4);
  var_0.ragdoll_immediate = undefined;
}