/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\las_vegas_ending.gsc
*****************************************************/

start_ending1() {
  level.dog = maps\las_vegas_code::spawn_drone_dog();
  maps\_hud_util::fade_out(0.05, "white");
  drop_structs();
}

start_ending2() {
  level.dog = maps\las_vegas_code::spawn_drone_dog();
  maps\_hud_util::fade_out(0.05, "white");
  drop_structs();
}

start_ending3() {
  level.dog = maps\las_vegas_code::spawn_drone_dog();
  maps\_hud_util::fade_out(0.05, "white");
  drop_structs();
}

start_ending4() {
  level.dog = maps\las_vegas_code::spawn_drone_dog();
  maps\_hud_util::fade_out(0.05, "white");
  drop_structs();
}

start_dream() {
  level.dog = maps\las_vegas_code::spawn_drone_dog();
  maps\_hud_util::fade_out(0.05, "white");
  drop_structs();
}

start_save() {
  maps\_hud_util::fade_out(0.05, "white");
  drop_structs();
}

drop_structs() {
  var_0 = common_scripts\utility::getStructArray("ending1_start_spot", "targetname");
  var_0 = common_scripts\utility::array_combine(common_scripts\utility::getStructArray("ending2_start_spot", "targetname"), var_0);
  var_0 = common_scripts\utility::array_combine(common_scripts\utility::getStructArray("ending3_start_spot", "targetname"), var_0);

  foreach(var_2 in var_0)
  var_2.origin = common_scripts\utility::drop_to_ground(var_2.origin, 10, -100);
}

ending_init() {
  if(isDefined(level.ending_init)) {
    return;
  }
  level.ending_init = 1;
  drop_structs();
}

ending1() {
  ending_init();
  wait 1;
  level.player freezecontrols(1);
  level.player enableslowaim(0.3, 0.3);
  teleport_friends("ending1_start_spot");
  level.player maps\_utility::player_speed_set(20);
  wait 2;
  var_0 = 5;
  thread maps\las_vegas_code::ending_fadein(var_0, "vegas_ending1");
  level.player freezecontrols(0);
  var_1 = getanimlength(level.hesh maps\_utility::getanim("ending1"));
  var_2 = common_scripts\utility::getstruct("ending1_anim_spot", "targetname");
  var_2 thread maps\_anim::anim_custom_animmode(level.heroes, "gravity", "ending1");
  var_3 = 3;
  common_scripts\utility::flag_wait_or_timeout("ending1_done", var_1 - var_3);
  maps\las_vegas_code::ending_fadeout(var_3);
}

ending2() {
  ending_init();
  wait 0.5;
  level.player freezecontrols(1);
  level.player enableslowaim(0.2, 0.2);
  teleport_friends("ending2_start_spot");
  wait 1;
  var_0 = 5;
  thread maps\las_vegas_code::ending_fadein(var_0);
  level.player freezecontrols(0);
  level.player maps\_utility::player_speed_set(20);
  var_1 = getanimlength(level.hesh maps\_utility::getanim("ending2"));
  var_2 = common_scripts\utility::getstruct("ending2_anim_spot", "targetname");
  var_2 thread maps\_anim::anim_single(level.heroes, "ending2");
  var_3 = 3;
  common_scripts\utility::flag_wait_or_timeout("ending2_done", var_1 - var_3);
  maps\las_vegas_code::ending_fadeout(var_3);
}

ending3() {
  ending_init();
  wait 0.5;
  level.player freezecontrols(1);
  level.player enableslowaim(0.1, 0.1);
  teleport_friends("ending3_start_spot");
  remove_hero_guns();
  var_0 = 5;
  thread maps\las_vegas_code::ending_fadein(var_0);
  thread ending3_dialogue();
  level.player freezecontrols(0);
  level.player maps\_utility::player_speed_set(20);
  var_1 = getanimlength(level.hesh maps\_utility::getanim("ending3"));
  var_2 = common_scripts\utility::getstruct("ending3_anim_spot", "targetname");
  var_2 thread maps\_anim::anim_single(level.heroes, "ending3");
  var_3 = 3;
  common_scripts\utility::flag_wait_or_timeout("ending3_done", var_1 - var_3);
  maps\las_vegas_code::ending_fadeout(var_3);
}

ending3_dialogue() {}

ending4() {
  ending_init();
  wait 0.5;
  level.player freezecontrols(1);
  level.player enableslowaim(0.1, 0.1);
  teleport_friends("ending4_start_spot");
  wait 1;
  var_0 = 2;
  thread maps\las_vegas_code::ending_fadein(var_0);
  level.player freezecontrols(0);
  level.player maps\_utility::player_speed_set(20);
  var_1 = [level.hesh, level.merrick];
  var_2 = getanimlength(level.hesh maps\_utility::getanim("ending4"));
  var_3 = common_scripts\utility::getstruct("ending4_anim_spot", "targetname");
  var_3 thread maps\_anim::anim_single(var_1, "ending4");
  var_4 = 3;
  common_scripts\utility::flag_wait_or_timeout("ending4_done", var_2 - var_4);
  level.dog unlinkfromplayerview(level.player);
  maps\las_vegas_code::ending_fadeout(var_4);
}

dune_tumble() {
  var_0 = common_scripts\utility::getstruct("ending_tumble_spot", "targetname");
  var_1 = spawn("script_origin", (0, 0, 0));
  level.ground_ref_ent = var_1;
  level.player playersetgroundreferenceent(var_1);
  var_2 = (30, 20, 10);
  var_3 = 2;
  maps\las_vegas_code::ground_ref_rotate(var_2, var_3, var_3 * 0.5, var_3 * 0.25);
  wait(var_3);
  level waittill("forever");
}

dream() {
  ending_init();
  level.player freezecontrols(1);
  level.player enableslowaim(0.1, 0.1);
  var_0 = common_scripts\utility::getstruct("ending_dream_spot", "targetname");
  var_0.origin = common_scripts\utility::drop_to_ground(var_0.origin, 10, -100);
  level.player setorigin(var_0.origin);
  level.player setplayerangles(var_0.angles);
  thread dream_warriors();
  maps\las_vegas_code::spawn_hero("elias");
  remove_hero_guns();
  var_1 = [level.hesh, level.elias];
  maps\las_vegas_code::set_start_locations("dream_spots", var_1);
  thread hesh_dream();
  thread elias_dream();
  var_2 = 5;
  thread maps\las_vegas_code::ending_fadein(var_2);
  level.player freezecontrols(0);
  common_scripts\utility::flag_wait("dream_fade_out");
  var_3 = 5;
  thread maps\las_vegas_code::ending_fadeout(var_3);
  var_4 = 1;
  wait(var_3 - var_4);
  setslowmotion(1, 0.5, 1);
  common_scripts\utility::flag_set("dream_done");
}

dream_warriors() {
  var_0 = common_scripts\utility::getStructArray("warrior_spot", "targetname");
  var_1 = getent("warrior_spawner", "targetname");
  var_2 = [];

  foreach(var_4 in var_0) {
    var_4.angles = vectortoangles(level.player.origin - var_4.origin);
    var_1.origin = common_scripts\utility::drop_to_ground(var_4.origin, 10, -200);
    var_2[var_2.size] = var_1 spawndrone();
    wait 0.05;
  }

  common_scripts\utility::flag_set("dream_start");
  common_scripts\utility::flag_wait("dream_done");
  common_scripts\utility::array_call(var_2, ::delete);
}

elias_dream() {
  level.elias.teleport_node thread maps\_anim::anim_custom_animmode_solo(level.elias, "gravity", "dream");
  var_0 = 5;
  var_1 = getanimlength(level.elias maps\_utility::getanim("dream")) - var_0;
  level.elias set_anim_time("dream", 5);
  wait(var_1 - 2);
  common_scripts\utility::flag_set("dream_fade_out");
}

hesh_dream() {
  level.hesh.teleport_node maps\_anim::anim_custom_animmode_solo(level.hesh, "gravity", "dream");
}

save() {
  ending_init();

  if(level.start_point == "save")
    setslowmotion(1, 0.5, 0.05);

  level.player freezecontrols(1);
  level.player enableslowaim(0.1, 0.1);
  maps\_utility::delaythread(2, ::hesh_wave);
  maps\_utility::delaythread(4, ::save_radio);
  var_0 = common_scripts\utility::getstruct("ending_save_start_spot", "targetname");
  var_1 = spawn("script_origin", level.player.origin + (0, 0, 60));
  var_2 = spawn("script_origin", level.player.origin);
  var_2 linkto(var_1);
  level.player playerlinktodelta(var_2, "", 1, 0, 0, 0, 0);
  wait 0.1;
  level.player lerpviewangleclamp(1, 0, 0, 20, 20, 20, 20);
  var_1 dontinterpolate();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  wait 0.1;
  thread ending_chopper();
  var_3 = 2;
  thread maps\las_vegas_code::ending_fadein(var_3);
  level.player freezecontrols(0);
  wait 5;
  maps\las_vegas_code::ending_fadeout(3);
  maps\_utility::nextmission();
}

save_radio() {
  soundsettimescalefactor("announcer", 0);
  maps\_utility::smart_radio_dialogue("vegas_hp1_commandthisiscrazy");
}

hesh_wave() {
  var_0 = common_scripts\utility::getstruct("save_hesh_spot", "targetname");
  var_0 maps\_anim::anim_single_solo(level.hesh, "save");
}

ending_chopper() {
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("ending_chopper");
  var_0 setmaxpitchroll(10, 10);
  var_0 setyawspeed(60, 10, 10);
}

set_anim_time(var_0, var_1) {
  wait 0.05;
  var_2 = maps\_utility::getanim(var_0);
  var_3 = var_1 / getanimlength(maps\_utility::getanim(var_0));
  self setanimtime(var_2, var_3);
}

teleport_friends(var_0) {
  maps\las_vegas_code::set_start_locations(var_0);

  foreach(var_2 in level.heroes)
  var_2 setgoalpos(var_2.origin);
}

remove_hero_guns() {
  common_scripts\utility::array_thread(level.heroes, maps\_utility::gun_remove);
}