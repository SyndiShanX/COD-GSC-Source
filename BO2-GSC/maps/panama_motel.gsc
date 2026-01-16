/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\panama_motel.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\panama_utility;
#include maps\_objectives;
#include maps\_anim;
#include maps\_music;
#include maps\createart\panama_art;

skipto_motel() {
  skipto_setup();
  level.mason = init_hero("mason");
  a_hero[0] = level.mason;
  skipto_teleport("skipto_motel_player", a_hero);
  flag_set("trig_mason_to_motel");
  maps\createart\panama_art::set_water_dvar();
}

init_motel_flags() {
  flag_init("mason_at_motel");
  flag_init("motel_scene_end");
  flag_init("start_intro_anims");
  flag_init("trig_mason_to_motel");
  flag_init("player_pull_pin");
  flag_init("motel_room_cleared");
  flag_init("breach_gun_raised");
}

main() {
  level thread maps\createart\panama_art::motel();
  motel_breach_main();
}

motel_breach_main() {
  m_motel_tv_broken = getent("m_motel_tv_broken", "targetname");
  m_motel_tv_broken hide();
  level thread motel_fail_condition();
  trig_player_motel_door = getent("trig_player_motel_door", "targetname");
  trig_player_motel_door trigger_off();
  run_scene_first_frame("motel_chair");
  flag_wait("trig_mason_to_motel");
  run_scene("motel_approach");
  level thread run_scene("motel_approach_loop");
  flag_set("mason_at_motel");
  trig_player_motel_door trigger_on();
  trig_player_motel_door waittill("trigger");
  clean_up_enemy_ai();
  level clientnotify("mute_amb");
  flag_set("start_intro_anims");
  level thread run_scene("motel_door");
  level thread run_scene("motel_breach");
  flag_wait("motel_breach_started");
  str_weapon_model = getweaponmodel("m16_sp");
  m_player_body = get_model_or_models_from_scene("motel_breach", "player_body");
  m_player_body attach(str_weapon_model, "tag_weapon");
  scene_wait("motel_breach");
  flag_set("motel_room_cleared");
  level thread run_scene("motel_chair");
  level.player disableweaponcycling();
  level.player setlowready(1);

  if(level.player hasweapon("nightingale_dpad_sp"))
    level.player set_temp_stat(1, 1);

  run_scene("motel_scene");
  flag_set("motel_scene_end");
}

clean_up_enemy_ai() {
  enemies = getaiarray("axis");

  for(i = 0; i < enemies.size; i++)
    enemies[i] delete();
}

gun_raise(m_player_body) {
  m_player_body hide();

  if(level.player hasweapon("minigun_sp") || level.player hasweapon("minigun80s_sp"))
    level.player disableweapons();
  else {
    level.player enableweapons();
    level.player showviewmodel();
    level.player disableweaponfire();
  }
}

gun_lower(m_player_body) {
  m_player_body show();
  level.player disableweapons();
  level.player hideviewmodel();
}

fade_out_no_intel(m_player_body) {
  if(!(level.player get_story_stat("KRAVCHENKO_INTERROGATED") || level.player get_story_stat("FOUND_NICARAGUA_EASTEREGG"))) {
    flag_set("motel_scene_end");
    rpc("clientscripts/_audio", "cmnLevelFadeout");
    screen_fade_out(0.5);
    wait 0.1;
    nextmission();
  }
}

fade_out_one_intel(m_player_body) {
  if(!level.player get_story_stat("FOUND_NICARAGUA_EASTEREGG") || !level.player get_story_stat("KRAVCHENKO_INTERROGATED")) {
    flag_set("motel_scene_end");
    screen_fade_out(0.5);
    level.mason say_dialog("maso_there_s_something_s_0");
    wait 0.1;
    nextmission();
  }
}

motel_vo_afghanistan(m_player_body) {
  if(level.player get_story_stat("KRAVCHENKO_INTERROGATED")) {
    e_krav = spawn("script_origin", level.player.origin + vectorscale((0, 0, 1), 60.0));
    e_krav thread say_dialog("krav_he_even_has_people_i_0");
    wait 1.5;
    level.player say_dialog("wood_remember_what_kravch_0");
    level.player giveachievement_wrapper("SP_STORY_LINK_CIA");
    e_krav delete();
  } else if(level.player get_story_stat("FOUND_NICARAGUA_EASTEREGG"))
    level.player say_dialog("wood_there_was_the_cia_me_0");
}

motel_vo_nicaragua(ai_mason) {
  if(level.player get_story_stat("FOUND_NICARAGUA_EASTEREGG") && level.player get_story_stat("KRAVCHENKO_INTERROGATED")) {
    level thread screen_fade_out(0.5);
    level.screen_faded_already = 1;
    ai_mason say_dialog("maso_there_was_the_cia_me_0");
  }
}

next_mission(m_player_body) {
  if(is_false(level.screen_faded))
    screen_fade_out(0.5);
  else
    wait 0.5;

  wait 0.5;
  nextmission();
}

player_breach_fake_fire() {
  while(flag("breach_gun_raised")) {
    if(level.player attackbuttonpressed()) {
      level.player playrumbleonentity("damage_heavy");
      playfxontag(getfx("maginified_muzzle_flash"), level.ai_thug_4, "tag_flash");
    }

    wait 0.05;
  }
}

set_breach_gun_raised(guy) {
  flag_set("breach_gun_raised");
}

clear_breach_gun_raised(guy) {
  flag_clear("breach_gun_raised");
}

motel_tv_swap(guy) {
  m_motel_tv_pristine = getent("m_motel_tv_pristine", "targetname");
  m_motel_tv_pristine hide();
  m_motel_tv_broken = getent("m_motel_tv_broken", "targetname");
  m_motel_tv_broken show();
}

test_print(guy) {
}

head_shot_bathroom_guy(guy) {
}

player_breach_button_press() {
  screen_message_create(&"PANAMA_MOTEL_BREACH");

  while(true) {
    if(level.player usebuttonpressed() || level.player secondaryoffhandbuttonpressed()) {
      screen_message_delete();
      flag_set("player_pull_pin");
      level clientnotify("aS_off");
      break;
    }

    wait 0.05;
  }
}

open_motel_door() {
  m_motel_door = getent("motel_door", "targetname");
  m_motel_door rotateyaw(120, 0.3, 0.3, 0);
  playfx(getfx("door_breach"), m_motel_door.origin);
}

mason_breach() {
  flag_wait("trig_mason_to_motel");
  level.mason.goalradius = 32;
  nd_motel_door = getnode("nd_motel_door", "targetname");
  level.mason setgoalnode(nd_motel_door);
  level.mason waittill("goal");
  level thread run_scene("mason_door_loop");
  flag_set("mason_at_motel");
}

motel_fail_condition() {
  trig_motel_fail = getent("trig_motel_fail", "targetname");
  trig_motel_fail trigger_off();
  flag_wait("trig_mason_to_motel");
  trig_motel_fail trigger_on();
  trig_motel_fail waittill("trigger");
  setdvar("ui_deadquote", & "PANAMA_HANGAR_FAIL");
  level notify("mission failed");
  maps\_utility::missionfailedwrapper();
}

thug_1_breach() {
  flag_wait("start_intro_anims");
  ai_thug_1 = simple_spawn_single("thug_1");
  ai_thug_1.animname = "thug_1";
  run_scene("thug_1_intro");
  ai_thug_1 die();
}

thug_2_breach() {
  flag_wait("start_intro_anims");
  ai_thug_2 = simple_spawn_single("thug_2");
  ai_thug_2.animname = "thug_2";
  ai_thug_2 set_ignoreall(1);
  run_scene("thug_2_intro");
  run_scene("thug_2_shot");
  level thread run_scene("thug_2_death_loop");
}

thug_3_breach() {
  flag_wait("start_intro_anims");
  ai_thug_3 = simple_spawn_single("thug_3");
  ai_thug_3.animname = "thug_3";
  run_scene("thug_3_intro");
  level thread run_scene("thug_3_death_loop");
}

thug_4_breach() {
  flag_wait("start_intro_anims");
  level.ai_thug_4 = simple_spawn_single("thug_4");
  level.ai_thug_4.animname = "thug_4";
  run_scene("thug_4_intro");
  level thread run_scene("thug_4_death_loop");
}