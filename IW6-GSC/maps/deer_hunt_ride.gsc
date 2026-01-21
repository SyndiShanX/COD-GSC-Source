/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\deer_hunt_ride.gsc
*****************************************************/

jeep_ride_setup() {
  common_scripts\utility::flag_clear("introscreen_complete");
  maps\_utility::delaythread(0.25, maps\_utility::music_play, "mus_deer_jeep_ride");
  var_0 = [ &"DEER_HUNT_JEEP_INTROLINE_1", &"DEER_HUNT_JEEP_INTROLINE_2"];
  thread display_stylized_message();
  level.player thread maps\_utility::play_sound_on_entity("scn_deer_jeep_drive_stop");

  if(level.start_point == "ride")
    thread maps\deer_hunt_util::fade_out_in("black", "fade_in_jeep_ride");

  clean_up();
  wait 1;
  thread setup_gate_ai();
  thread spawn_and_put_player_in_jeep();
  thread spawn_friendlies_and_put_in_jeep();
  thread scripted_vehicles();
  thread setup_house();
  thread ambient_a10s();
  thread food_truck();
  thread ambient_road_runners();
}

display_stylized_message() {
  wait 1;
  var_0 = [ &"DEER_HUNT_JEEP_INTROLINE_1", &"DEER_HUNT_JEEP_INTROLINE_2"];
  maps\_utility::stylized_center_text(var_0, 4.5);
  common_scripts\utility::flag_set("jeep_ride_message_displayed");
  common_scripts\utility::flag_wait("player_in_jeep");
  common_scripts\utility::flag_set("fade_in_jeep_ride");
  maps\_utility::autosave_by_name("jeep_ride_start");
}

#using_animtree("generic_human");

init_hesh_house_animset() {
  common_scripts\utility::flag_wait("deer_hunt_beach_tr_loaded");
  var_0 = [];
  var_0["run"]["straight"] = % dh_hesh_gun_walk;
  var_0["walk"]["straight"] = % dh_hesh_gun_walk;
  var_0["run"]["move_f"] = % dh_hesh_gun_walk;
  var_0["walk"]["move_f"] = % dh_hesh_gun_walk;
  var_0["run"]["stairs_up_in"] = % dh_hesh_stairs_up_in;
  var_0["walk"]["stairs_up_out"] = % dh_hesh_stairs_up_out;
  var_0["run"]["stairs_up_out"] = % dh_hesh_stairs_up_out;
  var_0["walk"]["stairs_up_in"] = % dh_hesh_stairs_up_in;
  var_0["run"]["stairs_up"] = % dh_hesh_stairs_up;
  var_0["walk"]["stairs_up"] = % dh_hesh_stairs_up;
  maps\_utility::register_archetype("hesh_house", var_0);
}

init_elias_house_animset() {
  common_scripts\utility::flag_wait("deer_hunt_beach_tr_loaded");
  var_0 = [];
  var_0["run"]["straight"] = % dh_elias_walk;
  var_0["walk"]["straight"] = % dh_elias_walk;
  var_0["run"]["move_f"] = % dh_elias_walk;
  var_0["walk"]["move_f"] = % dh_elias_walk;
  var_0["run"]["stairs_up_in"] = % dh_elias_stairs_up_in;
  var_0["walk"]["stairs_up_out"] = % dh_elias_stairs_up_out;
  var_0["run"]["stairs_up_out"] = % dh_elias_stairs_up_out;
  var_0["walk"]["stairs_up_in"] = % dh_elias_stairs_up_in;
  var_0["run"]["stairs_up"] = % dh_elias_stairs_up;
  var_0["walk"]["stairs_up"] = % dh_elias_stairs_up;
  var_0["idle"]["stand"][0] = [ % unarmed_cowerstand_idle];
  var_0["idle_weights"]["stand"][0] = [1];
  var_0["cover_trans"]["exposed"][1] = % unarmed_cowerstand_idle;
  var_0["cover_trans"]["exposed"][2] = % unarmed_cowerstand_idle;
  var_0["cover_trans"]["exposed"][3] = % unarmed_cowerstand_idle;
  var_0["cover_trans"]["exposed"][4] = % unarmed_cowerstand_idle;
  var_0["cover_trans"]["exposed"][5] = % unarmed_cowerstand_idle;
  var_0["cover_trans"]["exposed"][6] = % unarmed_cowerstand_idle;
  var_0["cover_trans"]["exposed"][7] = % unarmed_cowerstand_idle;
  var_0["cover_trans"]["exposed"][8] = % unarmed_cowerstand_idle;
  var_0["cover_trans"]["exposed"][9] = % unarmed_cowerstand_idle;
  maps\_utility::register_archetype("elias_house", var_0);
}

food_truck() {
  level endon("player_in_house");
  common_scripts\utility::flag_wait("gate_clear");
  var_0 = common_scripts\utility::getstruct("food_truck_ent", "targetname");
  var_1 = maps\_utility::spawn_targetname("food_truck_guy", 1);
  var_1.animname = "generic";
  var_2 = var_1 thread maps\deer_hunt_util::spawn_model_and_linkto_me("accessories_sack_coffee_animated", "tag_inhand");
  var_0 thread maps\_anim::anim_loop_solo(var_1, "dh_food_server", "player_in_house");
  var_3 = getanimlength(%dh_food_server);

  for(;;) {
    var_1 waittill("stop_sequencing_notetracks");
    wait 2;
    var_2 show();
    wait 3.8;
    var_2 hide();
  }
}

ambient_a10s() {
  var_0 = getvehiclenodearray("boom", "script_noteworthy");
  common_scripts\utility::array_thread(var_0, vehicle_scripts\_a10_warthog::plane_sound_node);
  level endon("player_in_house");
  common_scripts\utility::flag_wait("gate_clear");
  var_1 = maps\_utility::getvehiclespawnerarray("ambient_10");

  foreach(var_3 in var_1) {
    var_4 = var_3 maps\_vehicle::spawn_vehicle_and_gopath();
    var_4 vehicle_setspeedimmediate(350, 100);
    wait(randomfloatrange(1, 2.5));
  }
}

ai_debug() {}

clean_up(var_0) {
  if(!isDefined(var_0))
    var_0 = getaiarray();

  foreach(var_2 in var_0)
  var_2 thorough_delete();
}

is_hero_ai(var_0) {
  if(isDefined(var_0)) {
    if(self == var_0)
      return 1;
  }

  return 0;
}

thorough_delete() {
  if(is_hero_ai(level.hesh) || is_hero_ai(level.elias) || is_hero_ai(level.dog) || is_hero_ai(level.brian)) {
    return;
  }
  if(isDefined(self.magic_bullet_shield))
    maps\_utility::stop_magic_bullet_shield();

  self notify("deleted");
  self notify("death");
  self delete();
}

spawn_and_put_player_in_jeep() {
  level.player disableweapons();
  level.player freezecontrols(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  var_0 = (0, 0, 0);
  var_1 = "matv";
  level.jeep = maps\_vehicle::spawn_vehicle_from_targetname(var_1);
  level.jeep vehicle_turnengineoff();
  level.jeep thread jeep_speed_control();
  level.player.linker = level.player common_scripts\utility::spawn_tag_origin();
  var_2 = level.player.linker;
  var_3 = undefined;

  if(level.jeep.classname == "script_vehicle_matv_noturret") {
    var_3 = "tag_player";
    var_0 = (5, 0, 15);
  } else
    var_3 = "tag_player2";

  var_2.origin = level.jeep gettagorigin(var_3);
  var_2.angles = level.jeep gettagangles(var_3);

  if(level.player islinked())
    level.player unlink();

  var_2 linkto(level.jeep, var_3, var_0, (0, 0, 0));
  level.player setorigin(var_2.origin);
  level.player setplayerangles(var_2.angles);
  level.player playerlinktodelta(var_2, "tag_origin", 1, 60, 60, 50, 30, 0);
  common_scripts\utility::flag_wait("jeep_ai_spawned");
  common_scripts\utility::flag_set("player_in_jeep");
  wait 2.5;
  level.jeep maps\_vehicle::gopath();
  level.player playrumblelooponentity("vegas_drag");
  level.player freezecontrols(0);
  level thread jeep_exit_logic(var_3);
  maps\_utility::delaythread(1, ::gate_wallah);
}

spawn_friendlies_and_put_in_jeep() {
  getent("hesh", "targetname").count = 1;
  getent("dog", "targetname").count = 1;
  level.hesh = maps\_utility::spawn_targetname("hesh", 1);
  level.dog = maps\_utility::spawn_targetname("dog", 1);
  level.dog.name = "Riley";
  level.dog.goalradius = 32;
  level.dog thread maps\_utility::magic_bullet_shield();
  level.driver = maps\_utility::spawn_targetname("driver", 1);
  level.driver.name = "Cpl. Davis";
  level.squad = [level.hesh, level.dog, level.driver];

  while(!isDefined(level.jeep))
    wait 0.05;

  level.driver.script_startingposition = 0;
  level.jeep.dontunloadonend = 1;
  level.hesh.script_startingposition = 1;
  level.jeep maps\_vehicle_aianim::guy_enter(level.hesh);
  level.jeep maps\_vehicle_aianim::guy_enter(level.driver);
  level.dog.animname = "dog";
  level.dog forceteleport(level.jeep.origin, level.jeep.angles, 100000);
  level.jeep thread maps\_anim::anim_loop_solo(level.dog, "matv_idle", "stop_loop", "tag_dog");
  wait 0.1;
  level.dog linkto(level.jeep, "tag_dog");
  common_scripts\utility::flag_set("friendlies_in_jeep");
  level thread ride_dog_bark();
  var_0 = (26444, 8072, -184);
  var_1 = (0, 312.4, 0);
  level.jeep waittill("reached_end_node");
  common_scripts\utility::flag_set("jeep_arrived");
  level.jeep notify("stop_loop");
  level.player stoprumble("vegas_drag");
  level.jeep thread maps\_anim::anim_single_solo(level.dog, "matv_exit", "tag_dog");
  level.hesh delete();
  wait 2;
  var_2 = getent("hesh", "targetname");
  var_2.count = 10;
  level.hesh = maps\_utility::spawn_targetname("hesh", 1);
  level.hesh maps\_utility::set_force_color("r");
  level.hesh maps\_utility::enable_ai_color();
  level.hesh forceteleport(var_0, var_1, 100000);
  var_0 = (26415, 8024, -185);

  if(level.dog islinked()) {
    level.dog stopanimscripted();
    level.dog unlink();
  }

  var_3 = maps\_utility::groundpos(var_0);
  level.dog forceteleport(var_3);
  level.hesh thread hesh_navigation_logic();
}

ride_dog_bark() {
  common_scripts\utility::flag_wait("gate_clear");
  wait 4;
  common_scripts\utility::play_sound_in_space("deerhunt_us2_heyriley", (26053, 9496, -145));
  level.dog maps\_utility_dogs::dog_bark();

  if(common_scripts\utility::cointoss())
    level.dog maps\_utility_dogs::dog_bark();

  wait 3;
  level thread common_scripts\utility::play_sound_in_space("deerhunt_us2_charliecompanyloadup", (26049, 8336, -159));
}

dog_exits_jeep() {
  var_0 = (26432.5, 8072.2, -145);

  if(level.dog islinked()) {
    level.dog unlink();
    level.dog stopanimscripted();
  }

  var_1 = maps\_utility::groundpos(var_0);
  level.dog forceteleport(var_1);
}

hesh_navigation_logic() {
  self.goalradius = 60;
  common_scripts\utility::flag_wait("player_exited_jeep");
  maps\_utility::set_archetype("hesh_house");
}

house_vo() {
  var_0 = ["deerhunt_hsh_dad", "deerhunt_els_iheardaboutthe", "deerhunt_hsh_always", "deerhunt_els_hehwalkwithme"];
  var_1 = ["deerhunt_hsh_dadtheywereexecuting", "deerhunt_els_theyrelookingforother", "deerhunt_els_sotheyroundup", "deerhunt_els_letsstepoutside", "deerhunt_hsh_sowhatdoyou"];
  var_2 = ["deerhunt_els_yknowineverwanted", "deerhunt_els_hellyouusedto", "deerhunt_hsh_youtrainedusfor", "deerhunt_els_itrainedyouto", "deerhunt_hsh_isthereadifference"];
  var_3 = ["deerhunt_els_ineedyouboys", "deerhunt_hsh_waitwherearewe", "deerhunt_els_home"];

  while(!isDefined(level.elias))
    wait 0.1;

  while(!isDefined(level.hesh))
    wait 0.1;

  common_scripts\utility::flag_wait("player_exited_jeep");
  level.hesh thread house_nav_logic();
  level.elias thread house_nav_logic();
  wait 2;
  maps\deer_hunt_util::hesh_line("deerhunt_hsh_rileystay");
  wait 4;
  maps\deer_hunt_util::hesh_line("deerhunt_hsh_cmonletsgofind");
  common_scripts\utility::flag_wait("2nd_floor_start");
  thread house_vo_wallah();
  common_scripts\utility::flag_wait("2nd_floor_end");
  maps\deer_hunt_util::convo_generator(var_1);
  wait 1.5;
  maps\deer_hunt_util::hesh_line("deerhunt_hsh_dad_2");
}

house_vo_wallah() {
  var_0 = ["deerhunt_us1_conv1_1", "deerhunt_us2_conv1_2", "deerhunt_us1_conv1_3", "deerhunt_us2_conv1_4", "deerhunt_us1_conv1_5"];
  var_1 = ["deerhunt_us1_conv2_1", "deerhunt_us2_conv2_2", "deerhunt_us1_conv2_3"];
  var_2 = ["deerhunt_us1_conv3_1", "deerhunt_us2_conv3_2"];
  var_3 = (26542, 7791, -13);
  var_4 = (26542, 7870, -15);
  thread house_vo_radio_wallah();
  wallah_convo(var_0, var_3, var_4);
  wallah_convo(var_1, var_3, var_4);
  wallah_convo(var_2, var_3, var_4);
}

house_vo_radio_wallah() {
  var_0 = ["deerhunt_us1_allfobsalongthe", "deerhunt_us2_neworleansclear", "deerhunt_us3_tusconclear", "deerhunt_us1_confirmsitreponall"];
  maps\_utility::delaythread(2, ::wallah_convo, var_0, (26779, 7821, -5));
  var_1 = ["deerhunt_us3_yeahdidyouhear", "deerhunt_us2_therewasanotherattack", "deerhunt_us2_davidsonwastellingme", "deerhunt_us1_sowhosthatleave", "deerhunt_us3_idontknowbut", "deerhunt_us1_soyouthinkthats", "deerhunt_us1_thentheymovein"];
  var_2 = (26818, 8008, 12);
  var_3 = (26780, 7984, 12);
}

wallah_convo(var_0, var_1, var_2) {
  var_3 = var_1;

  foreach(var_5 in var_0) {
    common_scripts\utility::play_sound_in_space(var_5, var_3);
    maps\deer_hunt_util::vo_wait();

    if(isDefined(var_2)) {
      if(var_3 == var_1) {
        var_3 = var_2;
        continue;
      }

      var_3 = var_1;
    }
  }
}

house_nav_logic() {
  maps\_utility::disable_cqbwalk();
  maps\_utility::disable_arrivals();
  maps\_utility::disable_exits();
  maps\_utility::disable_turnanims();
  maps\deer_hunt_util::disable_twitches();
  self.goalradius = 32;
}

dog_navigation_logic() {
  var_0 = 80;
  var_1 = var_0 * 0.75;
  self.goalradius = var_0;
  self.animname = "generic";
}

jeep_exit_logic(var_0) {
  level.jeep waittill("reached_end_node");
  level.player allowmelee(0);
  level.player laserforceoff();
  level.player_rig = maps\_utility::spawn_anim_model("player_rig", level.jeep.origin);
  level.player_rig.angles = level.jeep.angles;
  level.player unlink();
  level.player thread maps\_utility::play_sound_on_entity("scn_deerhunt_plyr_jeep_exit_foley");
  level.jeep thread maps\_anim::anim_single_solo(level.player_rig, "intro_jeep_exit_player", "tag_gunner");
  level.player playerlinktoblend(level.player_rig, "tag_player", 0.6, 0.2, 0.4);
  level.player common_scripts\utility::delaycall(0.5, ::playrumbleonentity, "damage_light");
  level.player common_scripts\utility::delaycall(2, ::playrumbleonentity, "damage_light");
  level.player common_scripts\utility::delaycall(3, ::playrumbleonentity, "damage_heavy");
  level.jeep waittill("intro_jeep_exit_player");
  level.player_rig hide();
  level.player unlink();
  level.player_rig delete();
  level.player takeallweapons();
  level.player giveweapon("noweapon_deer_hunt");
  level.player enableweapons();
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player switchtoweapon("noweapon_deer_hunt");
  common_scripts\utility::flag_set("player_exited_jeep");
  maps\_utility::autosave_by_name("elias_house");
}

ambient_road_runners() {
  level endon("player_in_house");
  common_scripts\utility::flag_wait("player_exited_jeep");
  var_0 = getEntArray("road_runners", "targetname");
  var_0 = common_scripts\utility::array_randomize(var_0);
  level.current_runners = [];

  for(;;) {
    foreach(var_2 in var_0) {
      if(level.current_runners.size < 5) {
        var_2.count = 1;
        var_3 = var_2 maps\_utility::spawn_ai(1);
        var_3.goalradius = 32;
        level.current_runners = common_scripts\utility::add_to_array(level.current_runners, var_3);
        var_3 thread delete_on_goal();
      }

      wait(randomintrange(3, 6));
      level.current_runners = maps\_utility::array_removedead_or_dying(level.current_runners);
    }
  }
}

delete_on_goal() {
  self endon("death");
  self waittill("goal");
  thorough_delete();
}

jeep_speed_control() {
  self vehicle_setspeed(10, 10);
}

setup_gate_ai() {
  maps\_utility::array_spawn_function_targetname("patrol_jog_guys", ::patrol_jog_guys_logic);
  var_0 = maps\_utility::array_spawn_targetname("jeep_patroller", 1);
  var_1 = maps\_utility::array_spawn_targetname("road_guys", 1);
  thread maps\_utility::array_spawn_targetname("patrol_jog_guys", 1);
  var_2 = getent("gate_spawner", "targetname");
  var_3 = common_scripts\utility::getstructarray("jeep_anims", "targetname");
  spawn_ai_for_structs(var_2, var_3, 1);
  var_2 = getent("gate_civ", "targetname");
  var_3 = common_scripts\utility::getstructarray("jeep_anims_civ", "targetname");
  spawn_ai_for_structs(var_2, var_3, 1);
  common_scripts\utility::flag_set("jeep_ai_spawned");
  var_4 = getent("gate_entrance", "targetname");
  var_5 = var_4 maps\_utility::get_drones_touching_volume();
  var_6 = var_4 maps\_utility::get_ai_touching_volume();
  var_7 = common_scripts\utility::array_combine(var_5, var_6);

  foreach(var_9 in var_7) {
    if(!maps\_utility::is_in_array(level.squad, var_9))
      var_9 thread delete_when_behind_player();
  }

  common_scripts\utility::flag_wait("gate_clear");
  var_2 = getent("garage_spawner", "targetname");
  var_3 = common_scripts\utility::getstructarray("after_gate", "targetname");
  spawn_ai_for_structs(var_2, var_3, 1);
  maps\_utility::spawn_targetname("garage_standing_guy", 1);
  thread maps\_utility::delaythread(1, ::spawn_stair_runner);
}

gate_wallah() {
  var_0 = ["deerhunt_us1_attentionduetorecent", "deerhunt_us1_againallsupplyrations"];
  var_1 = (25560, 11039, -29);
  maps\_utility::delaythread(3, ::wallah_convo, var_0, var_1);
  wait 1;
  var_2 = ["deerhunt_us1_thisareaisrestricted", "deerhunt_civ2_letusinman", "deerhunt_us1_ialreadytoldyou"];
  var_3 = (25336, 10555, -184);
  var_4 = (25184, 10594, -190);
  thread wallah_convo(var_2, var_3, var_4);
  common_scripts\utility::flag_wait("jeep_arrived");
  var_1 = (26316.5, 6848.5, -13);
  wallah_convo(var_0, var_1);
}

spawn_stair_runner() {
  var_0 = maps\_utility::spawn_targetname("stair_runner", 1);

  if(!maps\_utility::spawn_failed(var_0)) {
    var_0.goalradius = 24;
    var_1 = common_scripts\utility::getstruct(var_0.target, "targetname");
    var_0 thread maps\_utility::follow_path_and_animate(var_1, 100000);
  }
}

delete_when_behind_player() {
  while(isDefined(self)) {
    if(maps\deer_hunt_util::is_behind_player())
      thorough_delete();

    wait 1;
  }
}

spawn_ai_for_structs(var_0, var_1, var_2, var_3) {
  var_4 = [];

  foreach(var_12, var_6 in var_1) {
    var_7 = strtok(var_6.script_parameters, " ");

    if(!isDefined(var_6.angles))
      var_6.angles = (0, 0, 0);

    foreach(var_9 in var_7) {
      var_0.count = 1;

      if(isDefined(var_2)) {
        var_10 = maps\_utility::dronespawn(var_0);
        var_10.targetname = var_0.targetname;
        var_10.team = "allies";

        if(!isDefined(var_3))
          var_10.dontdonotetracks = 1;

        if(isDefined(var_0.script_patroller))
          var_10.runanim = % patrol_bored_patrolwalk;
      } else
        var_10 = var_0 stalingradspawn();

      wait 0.05;
      var_10 thread maps\_utility::magic_bullet_shield(1);
      var_10 thread play_anim_off_me(var_6, var_9);
      var_4[var_12] = var_10;
    }
  }

  return var_4;
}

play_anim_off_me(var_0, var_1) {
  self endon("deleted");
  self endon("death");

  if(isDefined(var_0.script_noteworthy)) {
    if(var_0.script_noteworthy == "gun_hide")
      maps\_utility::gun_remove();
  }

  self.animname = "generic";

  if(isDefined(var_0.script_index)) {
    var_2 = getstartorigin(var_0.origin, var_0.angles, maps\_utility::getanim(var_1));
    var_3 = getstartangles(var_0.origin, var_0.angles, maps\_utility::getanim(var_1));

    if(issentient(self)) {
      self forceteleport(var_2, var_3, 10000);
      self.goalradius = 15;
      self setgoalpos(var_2);
    } else {
      self.origin = var_2;
      self.angles = var_2;
    }

    thread maps\_utility::notify_delay("start_scene", var_0.script_index);
    self waittill("start_scene");
  }

  if(isarray(level.scr_anim[self.animname][var_1]))
    var_0 maps\_anim::anim_loop_solo(self, var_1);
  else
    var_0 thread maps\_anim::anim_single_solo(self, var_1);

  if(isDefined(var_0.script_delay)) {
    wait 0.05;
    var_4 = var_0.script_delay;
    self setanimtime(maps\_utility::getanim(var_1), var_4);
  }

  var_0 waittill(var_1);

  if(var_0 maps\deer_hunt_util::has_script_noteworthy("delete_on_end")) {
    thorough_delete();
    return;
  }

  if(!issentient(self)) {
    return;
  }
  if(!isDefined(self.target)) {
    self.goalradius = 32;
    self setgoalpos(self.origin);
  }
}

patrol_jog_guys_logic() {
  self endon("deleted");
  self.animname = "generic";
  var_0 = "run_gun_up";
  maps\_utility::set_run_anim(var_0);
  var_1 = common_scripts\utility::getstruct(self.target, "targetname");
  thread maps\_utility::follow_path_and_animate(var_1, 100000);
}

custom_flavor_bursts() {
  var_0 = 3;
  var_1 = 800;

  while(!isDefined(level.squad))
    wait 0.05;

  maps\_utility::battlechatter_off("allies");
  maps\_utility::flavorbursts_off("allies");

  for(;;) {
    var_2 = getaiarray("allies");
    var_3 = common_scripts\utility::get_array_of_closest(level.player.origin, var_2, level.squad, var_0, var_1);
    common_scripts\utility::array_thread(var_3, ::custom_flavor_burst_on_me);
    wait 6;
  }
}

custom_flavor_burst_on_me() {
  self endon("death");
  self endon("deleted");

  if(!isDefined(level.custom_flavorburst_ents))
    level.custom_flavorburst_ents = [];

  wait(randomfloatrange(0.5, 2));

  if(isDefined(self.sound_ent))
    self.sound_ent notify("sounddone");

  var_0 = self.voice;
  var_1 = animscripts\battlechatter::getflavorburstid(self, var_0);
  var_2 = animscripts\battlechatter::getflavorburstaliases(var_0, var_1);

  if(isDefined(var_2.size)) {
    if(var_2.size > 0) {
      self.sound_ent = spawn("script_origin", self getEye());
      self.sound_ent linkto(self);
      level.custom_flavorburst_ents = common_scripts\utility::add_to_array(level.custom_flavorburst_ents, self.sound_ent);
      self.sound_ent thread maps\deer_hunt_util::delete_me_on_notifies("sounddone");
      self.sound_ent playSound(common_scripts\utility::random(var_2), "sounddone");
    }
  }
}

scripted_vehicles() {
  thread back_alley_humvee();
}

back_alley_humvee() {
  var_0 = maps\_utility::getvehiclespawner("back_alley_humvee");
  level endon("player_in_house");

  for(;;) {
    var_1 = var_0 maps\_vehicle::spawn_vehicle_and_gopath();
    wait 0.05;
    var_1 vehicle_setspeed(randomintrange(6, 12), 10, 5);
    var_1 waittill("death");
    wait(randomintrange(2, 4));
  }
}

setup_house() {
  thread init_hesh_house_animset();
  thread init_elias_house_animset();
  thread outside_reads();
  getent("elias", "targetname") maps\_utility::add_spawn_function(::elias_logic);
  level.elias = maps\_utility::spawn_targetname("elias", 1);
  thread ending_scene();
  common_scripts\utility::flag_wait("player_in_house");
  maps\_utility::flavorbursts_off();

  if(level.start_point != "elias") {
    var_0 = getnonheroallies();
    clean_up(var_0);
  }

  var_1 = getent("house_spawner", "targetname");
  var_2 = common_scripts\utility::getstructarray("house_scene", "targetname");
  spawn_ai_for_structs(var_1, var_2, 1, 1);
  var_0 = maps\_utility::get_drones_with_targetname("house_spawner");
  var_3 = ["Cpl. ", "Pvt. ", "Sgt. ", "Lt. "];
  var_4 = ["DeFields", "Watson", "Sago"];

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_0[var_5].name = "";
    var_0[var_5] setlookattext(common_scripts\utility::random(var_3) + var_4[var_5], &"");
  }

  thread balcony_read();
  common_scripts\utility::flag_wait("3rd_floor_start");

  foreach(var_7 in var_0)
  var_7.dontdonotetracks = 1;
}

outside_reads() {
  common_scripts\utility::flag_wait("player_in_house");
  var_0 = maps\_utility::array_spawn_targetname("window_guys", 1);
  common_scripts\utility::flag_wait("3rd_floor_player");
  maps\_utility::array_delete(var_0);

  while(!common_scripts\utility::flag("balcony_player")) {
    var_1 = maps\_utility::getvehiclespawner("back_alley_humvee");
    var_2 = getvehiclenode("house_path", "targetname");
    var_3 = var_1 maps\_utility::spawn_vehicle();
    wait 0.05;
    var_3 attachpath(var_2);
    var_3 thread maps\_vehicle::vehicle_paths(var_2);
    maps\_vehicle::gopath(var_3);
    var_3 vehicle_setspeed(20, 10, 10);
    var_3 waittill("death");
    wait(randomintrange(3, 5));
  }
}

ending_scene() {
  common_scripts\utility::flag_wait("player_exited_jeep");
  maps\_anim::addnotetrack_customfunction("elias", "tablet_switch", ::swap_tablet, "2nd_floor");
  thread house_vo();
  var_0 = getent("house_spawner", "targetname");
  var_0.count = 1;
  level.brian = var_0 maps\_utility::spawn_ai(1);
  level.brian.animname = "brian";
  level.hesh.animname = "hesh";
  level.elias.animname = "elias";
  level.elias maps\_utility::gun_remove();
  level.brian maps\_utility::gun_remove();
  level.second_floor_actors = [level.elias, level.hesh, level.brian];
  level.third_floor_actors = [level.elias, level.hesh];

  foreach(var_2 in level.third_floor_actors) {
    var_2.pathrandompercent = 0;
    var_2 pushplayer(1);
    var_2.dontavoidplayer = 1;
  }

  common_scripts\utility::array_thread(level.third_floor_actors, maps\deer_hunt_util::retain_alert_level, 1);
  var_4 = common_scripts\utility::getstruct("house1", "targetname");
  var_5 = common_scripts\utility::getstruct("house2", "targetname");
  var_6 = spawnStruct();
  var_6.angles = (0, 0, 0);
  var_6.origin = (26489, 8027, -57);

  foreach(var_8 in level.second_floor_actors) {
    var_8.second_floor_anim_ent = spawn_anim_ent(var_4);
    var_8.third_floor_anim_ent = spawn_anim_ent(var_5);
  }

  var_4 thread maps\_anim::anim_loop([level.brian, level.elias], "2nd_floor_idle");
  level.elias.tablet = spawn("script_model", level.elias.origin);
  level.elias.tablet setModel("hjk_tablet_01");
  level.elias.tablet.origin = level.elias gettagorigin("tag_inhand");
  level.elias.tablet.angles = level.elias gettagangles("tag_inhand");
  level.elias.tablet linkto(level.elias, "tag_inhand");
  level.hesh thread set_goal_and_angle((26662, 7328, -174), 90);
  common_scripts\utility::flag_wait("player_in_house");
  level.hesh thread restore_playback_on_stairs_end();
  level.hesh notify("stop_array_set_goal_pos");
  level.hesh.second_floor_anim_ent maps\_anim::anim_reach_solo(level.hesh, "2nd_floor");
  common_scripts\utility::flag_set("2nd_floor_start");
  var_4 notify("stop_loop");

  if(isDefined(level.dog))
    level.dog notify("stop_sniffing");

  maps\_utility::music_play("mus_deer_elias");

  foreach(var_8 in level.second_floor_actors)
  var_8.second_floor_anim_ent thread maps\_anim::anim_single_solo(var_8, "2nd_floor");

  level.brian thread brian_does_idle_after_scene("2nd_floor");
  level.hesh thread hesh_stairs_anim("2nd_floor", var_6);
  level.elias.second_floor_anim_ent waittill("2nd_floor");
  var_12 = (26562, 7940, 79);
  level.elias thread elias_stairs(var_12);
  maps\deer_hunt_util::set_flag_if_not_set("2nd_floor_end");
  var_6 waittill("2nd_floor_stairs");
  var_13 = (26556, 7742, 79);
  level.hesh setgoalpos(var_13);
  wait 1;
  level.elias.anim_reach_playback_scale = 0.875;
  level.hesh.anim_reach_playback_scale = 0.9;
  var_14 = common_scripts\utility::getstruct("house2_animreach_path", "targetname");
  var_14 anim_reach_path(level.third_floor_actors, "3rd_floor_start");
  var_5 maps\_anim::anim_reach([level.hesh, level.elias], "3rd_floor_start");
  common_scripts\utility::flag_set("3rd_floor_start");

  foreach(var_8 in level.third_floor_actors)
  var_8.third_floor_anim_ent thread maps\_anim::anim_single_solo(var_8, "3rd_floor_start");

  level.hesh.third_floor_anim_ent waittill("3rd_floor_start");

  if(!common_scripts\utility::flag("balcony_player")) {
    var_5 thread maps\_anim::anim_loop([level.hesh, level.elias], "3rd_floor_idle");
    common_scripts\utility::flag_wait("balcony_player");
    var_5 notify("stop_loop");
  }

  maps\_utility::delaythread(0.5, maps\_utility::music_crossfade, "mus_deer_balcony", 2.0);

  foreach(var_8 in level.third_floor_actors)
  var_8.third_floor_anim_ent thread maps\_anim::anim_single_solo(var_8, "3rd_floor_end");

  var_19 = getanimlength(%dh_ending_hesh_end_b);
  wait(var_19 - 3);
  level_end();
}

anim_reach_path(var_0, var_1) {
  var_2 = self;

  for(;;) {
    var_2 maps\deer_hunt_util::custom_anim_reach_together(var_0, var_1);

    if(!isDefined(var_2.target)) {
      break;
    }

    var_2 = common_scripts\utility::getstruct(var_2.target, "targetname");
  }
}

set_goal_and_angle(var_0, var_1) {
  self notify("stop_array_set_goal_pos");
  self endon("stop_array_set_goal_pos");
  self setgoalpos(var_0);
  self waittill("goal");
  wait 0.2;

  if(isDefined(var_1))
    self orientmode("face angle", var_1);
}

elias_stairs(var_0) {
  var_1 = (26448, 7746, 94);
  self.goalradius = 50;
  self setgoalpos(var_1);
  self waittill("goal");
  self.moveplaybackrate = 0.7;
  self setgoalpos(var_0);
}

hesh_stairs_anim(var_0, var_1) {
  self.second_floor_anim_ent waittill(var_0);
  var_1 maps\_anim::anim_reach_solo(self, "2nd_floor_stairs");
  var_1 maps\_anim::anim_single_solo(self, "2nd_floor_stairs");
}

restore_playback_on_stairs_end() {
  wait 1.5;
  maps\_utility::set_moveplaybackrate(1.2);
  self waittill("move_loop_restart");
  maps\_utility::set_moveplaybackrate(1);
}

swap_tablet(var_0) {
  var_0.tablet unlink();
  var_0.tablet linkto(level.brian, "tag_inhand");
}

level_end() {
  level.player setclienttriggeraudiozone("deer_beach_fade_to_black", 3);
  var_0 = 4.5;
  level.player common_scripts\utility::delaycall(var_0, ::setclienttriggeraudiozone, "deer_beach_fade_everything", 1.5);
  thread maps\deer_hunt_util::fade_out_in("black", "never", undefined, 3);
  wait 6;
  level.player freezecontrols(1);
  level.elias setlookattext("", &"");
  level.hesh setlookattext("", &"");
  maps\_utility::nextmission();
}

brian_does_idle_after_scene(var_0) {
  self.second_floor_anim_ent waittill(var_0);
  self.second_floor_anim_ent thread maps\_anim::anim_loop_solo(self, "2nd_floor_idle_end");
}

set_flag_on_anim_reach(var_0, var_1, var_2) {
  self.second_floor_anim_ent waittill(var_0);
  maps\deer_hunt_util::set_flag_if_not_set("2nd_floor_end");

  if(self == level.hesh)
    thread maps\_utility::set_moveplaybackrate(1.1, 2);

  self.third_floor_anim_ent maps\_anim::anim_reach_solo(self, var_1);
  common_scripts\utility::flag_set(var_2);
}

spawn_anim_ent(var_0) {
  var_1 = spawn("script_origin", var_0.origin);
  var_1.angles = var_0.angles;
  return var_1;
}

elias_logic() {
  self.name = "Elias";
  thread maps\_utility::magic_bullet_shield();
  maps\_utility::gun_remove();
  common_scripts\utility::flag_wait("player_exited_jeep");
  maps\_utility::set_archetype("elias_house");
}

balcony_read() {
  common_scripts\utility::flag_wait("3rd_floor_player");
  var_0 = getent("beach_scene_actor", "targetname");
  var_1 = common_scripts\utility::getstructarray("beach_anims", "targetname");
  spawn_ai_for_structs(var_0, var_1, 1);
  thread beach_matv();
  wait 0.1;
  thread beach_ai();
  var_2 = maps\_utility::getvehiclearray();
  common_scripts\utility::array_thread(var_2, ::stop_hovering_at_path_end);
}

stop_hovering_at_path_end() {
  if(self.classname != "script_vehicle_silenthawk") {
    return;
  }
  self waittill("reached_dynamic_path_end");
  self sethoverparams(0, 0, 0);
}

beach_matv() {
  common_scripts\utility::flag_wait("balcony_player");
  var_0 = maps\_utility::getvehiclespawner("balcony_matv");

  for(;;) {
    var_1 = 2;
    var_2 = 9;

    for(var_3 = 0; var_3 < var_1; var_3++) {
      var_4 = var_0 maps\_vehicle::spawn_vehicle_and_gopath();
      wait 5.5;
    }

    wait(var_2);
  }
}

beach_ai() {
  maps\_utility::array_spawn_function_targetname("target_practice_guys", ::target_practice_guys_logic);
  maps\_utility::array_spawn_function_targetname("beach_runners_group", ::runner_logic);
  maps\_utility::array_spawn_targetname("beach_ai", 1);
  maps\_utility::array_spawn_targetname("target_practice_guys", 1);
  common_scripts\utility::flag_wait("balcony_player");
  maps\_utility::array_spawn_targetname("beach_runners_group", 1);
  thread beach_runners();
}

runner_logic() {
  maps\_utility::gun_remove();
  self.runanim = % training_jog_guy1;
  maps\_utility::set_moveplaybackrate(randomfloatrange(0.9, 1.1));
  self.name = "";
}

beach_runners() {
  wait 5;
  var_0 = getEntArray("beach_runners", "targetname");

  for(;;) {
    var_0 = common_scripts\utility::array_randomize(var_0);
    var_1 = maps\_utility::dronespawn(common_scripts\utility::random(var_0));
    var_1.runanim = % training_jog_guy1;
    wait(randomintrange(6, 9));
  }
}

getnonheroallies() {
  var_0 = getaiarray("allies");

  if(isDefined(level.hesh))
    var_0 = common_scripts\utility::array_remove(var_0, level.hesh);

  if(isDefined(level.dog))
    var_0 = common_scripts\utility::array_remove(var_0, level.dog);

  return var_0;
}

target_practice_guys_logic() {
  self.goalradius = 32;
  self setgoalpos(self.origin);
  var_0 = getent(self.target, "targetname");
  self setentitytarget(var_0, 1);
  self.dontevershoot = 1;
  self.pistol = 0;

  if(randomint(100) < 33) {
    self.forcesidearm = 1;
    self.pistol = 1;
  }

  for(;;) {
    if(common_scripts\utility::cointoss() && !self.pistol)
      self allowedstances("stand");

    burst_fire();
    self.bulletsinclip = 0;
    self allowedstances("stand", "crouch");
    wait(randomfloatrange(6, 10));
  }
}

burst_fire() {
  var_0 = randomintrange(8, 16);

  for(var_1 = 0; var_1 < var_0; var_1++) {
    self shoot();
    wait(randomfloatrange(1, 4));
  }
}