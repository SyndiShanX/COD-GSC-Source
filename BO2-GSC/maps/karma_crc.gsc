/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\karma_crc.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\karma_util;
#include maps\_scene;
#include maps\_objectives;
#include maps\_glasses;
#include maps\_dialog;
#include maps\_music;
#include maps\karma_arrival;
#include maps\karma_anim;
#include maps\createart\karma_art;
#include maps\_audio;
#include maps\_rusher;

init_flags() {
  flag_init("crc_karma_identified");
  flag_init("crc_flash_out");
  flag_init("crc_breach_guards_spawned");
}

init_spawn_funcs() {
}

skipto_crc() {
  iprintln("crc");

  cleanup_ents("cleanup_checkin");
  cleanup_ents("cleanup_tower");
  cleanup_ents("cleanup_dropdown");
  cleanup_ents("cleanup_spiderbot");
  maps\karma_arrival::deconstruct_fxanims();
  add_global_spawn_function("axis", ::change_movemode, "cqb_run");
  trigger_off("construction_battle_color_triggers", "script_noteworthy");
  skipto_teleport("skipto_crc");
}

main() {
  spiderbot_transition();
  crc_breach_event();
  crc_terminal_event();
  cleanup_ents("cleanup_crc");
}

crc_objectives() {
  set_objective(level.obj_enter_crc, undefined, "remove");
  flag_wait("spiderbot_transition_done");
  set_objective(level.obj_enter_crc, getstruct("struct_obj_crc_door"), "breadcrumb");
  trigger_wait("t_eye_scan_crc");
  set_objective(level.obj_enter_crc, undefined, "done");
  set_objective(level.obj_id_karma);
  waittill_ai_group_cleared("crc_interior_guards");
  autosave_by_name("crc_guards_cleared");
  set_objective(level.obj_id_karma, getstruct("struct_obj_computer"), "breadcrumb");
  flag_wait("crc_karma_identified");
  set_objective(level.obj_id_karma, undefined, "done");
}

crc_flashbang_add_script_noteworthy(ent) {
  ent.script_noteworthy = "cleanup_construction";
}

init_door_clip() {
  foreach(door in getentarray("script_doors", "script_noteworthy"))
  getent(door.target, "targetname") linkto(door);
}

init_crc_glass_monster_clip() {
  a_clip_brushes = getentarray("crc_glass_clip", "targetname");

  foreach(e_brush in a_clip_brushes)
  e_brush thread crc_glass_monster_clip_think();
}

init_tarp_clip() {
  for(i = 1; i <= 12; i++) {
    if(i < 10) {
      m_tarp = getent("fxanim_tarp_shootdown_0" + i, "targetname");
      e_clip = getent("tarp_collision_0" + i, "targetname");
    } else {
      m_tarp = getent("fxanim_tarp_shootdown_" + i, "targetname");
      e_clip = getent("tarp_collision_" + i, "targetname");
    }

    if(isDefined(m_tarp) && isDefined(e_clip))
      m_tarp thread tarp_clip_think(e_clip);
  }
}

tarp_clip_think(e_clip) {
  level endon("offices_cleared");
  self waittill("damage");
  wait 3.0;
  e_clip notsolid();
  e_clip connectpaths();
  e_clip delete();
}

init_use_trigger_hints() {
  getent("destroyed_spider_bot_trigger", "targetname") sethintstring(&"KARMA_PICKUP_SPIDERBOT_HINT");
  getent("trespasser_reward_interact_trigger", "targetname") sethintstring(&"SCRIPT_HINT_HACK");
}

crc_glass_monster_clip_think() {
  level endon("offices_cleared");
  s_start_point = getstruct(self.target, "targetname");
  v_endpoint = s_start_point.origin + anglestoforward(s_start_point.angles) * 18;

  while(isDefined(self)) {
    level waittill("glass_smash");
    wait 0.05;

    if(bullettrace(s_start_point.origin, v_endpoint, 0, level.player, 1, 0, level.ai_salazar)["position"] == v_endpoint) {
      self notsolid();
      self connectpaths();
      self delete();

      if(isDefined(s_start_point.target)) {
        foreach(ent in getentarray(s_start_point.target, "targetname"))
        ent delete();
      }
    }
  }
}

spiderbot_transition() {
  maps\karma_anim::construction_anims();
  init_door_clip();
  init_use_trigger_hints();
  init_crc_glass_monster_clip();
  init_tarp_clip();
  level thread trespasser_perk();
  getent("destroyed_spider_bot", "targetname") show();
  level.player notify("depth_of_field_tween");
  level.player depth_of_field_off(0.05);
  level.player maps\createart\karma_art::vision_set_change("sp_karma_construction");
  level.ai_salazar = init_hero("salazar");
  salazar_start_pos = getstruct("spiderbot_transition_salazar_pos", "targetname");
  player_start_pos = getstruct("skipto_crc", "targetname");
  level.ai_salazar forceteleport(salazar_start_pos.origin, salazar_start_pos.angles);
  level.player setorigin(player_start_pos.origin);
  level.player setplayerangles(player_start_pos.angles);
  wait 1.0;
  level.player freezecontrols(0);
  screen_fade_in(0, "compass_static");
  level thread run_scene_and_delete("it_mgr_body");
  level.player playsound("evt_spiderbot_outro");
  level.player thread queue_dialog("pa_access_granted_0", 4, "scene_p_eye_scan_started");
}

crc_breach_event() {
  setsaveddvar("player_standingViewHeight", level.default_player_height);
  m_crc_door = getent("crc_door", "targetname");
  level.ai_salazar thread force_goal(getnode("n_salazar_crc_enter", "targetname"), 8);
  level thread crc_objectives();
  level.ai_salazar waittill("goal");
  flag_wait("spiderbot_transition_done");
  level thread autosave_by_name("crc");
  trigger_wait("t_eye_scan_crc");
  level thread maps\_audio::switch_music_wait("KARMA_1_ENTER_CRC", 0);
  crc_eye_scan();
  m_crc_door thread open_crc_door();
  scene_wait("scene_p_eye_scan");
  getent(m_crc_door.target, "targetname") connectpaths();
  level thread crc_breach_flash();
  level thread run_scene_and_delete("crc_breach_flashed_dude");
  level thread run_scene_and_delete("scene_p_eye_scan_breach");
  wait 5.0;
  level thread close_crc_door();
  scene_wait("scene_p_eye_scan_breach");
  level.ai_salazar force_goal(getnode("crc_breach_salazar_start_pos", "targetname"), 16);

  foreach(ai_enemy in getentarray("crc_breach_guards_ai", "targetname")) {
    if(isalive(ai_enemy)) {
      ai_enemy set_goalradius(128);
      ai_enemy thread crc_breach_rush();
    }
  }

  waittill_ai_group_cleared("crc_interior_guards");
  level thread crc_salazar_terminal_idle();
}

crc_breach_rush() {
  waittill_ai_group_ai_count("crc_interior_guards", 2);
  wait(randomfloat(1.0));
  self maps\_rusher::rush();
}

open_crc_door() {
  self movey(63, 1.5);
  self waittill("movedone");
  level thread crc_breach_enemy_fire();
}

close_crc_door() {
  m_crc_door = getent("crc_door", "targetname");
  m_crc_door movey(-63, 1.5);
  m_crc_door waittill("movedone");
  m_crc_door disconnectpaths();
}

crc_salazar_terminal_idle() {
  foreach(e_trigger in getentarray("crc_entrance_color_trigger", "targetname"))
  e_trigger delete();

  level.ai_salazar say_dialog("sala_clear_0", 1.0);
  setmusicstate("KARMA_1_CRC");
  level.ai_salazar set_goalradius(8);
  level.ai_salazar setgoalnode(getnode("salazar_crc_guard_pos", "script_noteworthy"));
  flag_wait("crc5_started");
  wait 16.0;
  run_scene_and_delete("scene_sal_ready_crc_door");
  level thread run_scene_and_delete("scene_sal_loop_crc_door");
}

crc_breach_enemy_fire() {
  a_shooters = simple_spawn("crc_breach_guards");
  e_shoot_target = getent("crc_breach_fire_target", "targetname");
  flag_set("crc_breach_guards_spawned");
  level.player enableinvulnerability();

  foreach(ai_shooter in a_shooters) {
    if(isDefined(ai_shooter.script_string) && ai_shooter.script_string == "crc_breach_shooters")
      ai_shooter thread shoot_at_target(e_shoot_target, undefined, 0.0, 10.0);
  }

  wait 14.0;
  level.player disableinvulnerability();
}

crc_breach_flash() {
  level thread breach_vo();
  s_flash_target = getstruct("crc_breach_flash_target", "targetname");
  flag_wait("crc_flash_out");
  level.ai_salazar magicgrenadetype("flash_grenade_sp", s_flash_target.origin, (0, 0, 0), 0.05);
  exploder(540);
  wait 5.0;
  delete_exploder(540);
}

breach_vo() {
  flag_wait("crc_breach_guards_spawned");
  queue_dialog_enemy("pmc4_enemy_breaching_the_0");
  queue_dialog_enemy("pmc3_flashbang_0");
  queue_dialog_enemy("pmc3_get_in_cover_0", 2);
  queue_dialog_enemy("pmc4_return_fire_0", 3);
}

crc_eye_scan() {
  luinotifyevent(&"hud_update_vehicle_custom", 3, 1, & "retina_scanner", 3250);
  level thread run_scene_and_delete("scene_p_eye_scan");
  level.player playsound("evt_eye_scan_boot_up");
  add_visor_text("KARMA_ACCESSING_SOURCE_DATA", 2, "orange");
  wait 2.0;
  add_visor_text("KARMA_MATCH_COMPLETE", 2, "orange");
  exploder(480);
  level.player playsound("evt_eye_scanner");
  luinotifyevent(&"begin_retina_scan", 1, 1000);
  wait 3.0;
  luinotifyevent(&"hud_update_vehicle_custom", 1, 0);
  playsoundatposition("evt_eye_scan_door_open", (5325, -6532, -3504));
  delete_exploder(480);
}

crc_terminal_event() {
  trigger_wait("t_minority_report");
  level.player playsound("evt_ui_wall");
  crc_interact();
  flag_set("crc_karma_identified");
}

crc_interact() {
  level.player_interactive_model = "c_usa_masonjr_karma_viewbody";
  level.player maps\createart\karma_art::vision_set_change("sp_karma_crc_screens");
  cin_id = start3dcinematic("crc_part01", 0, 0, 0, 0, 1);
  playsoundatposition("evt_ui_wall_801", (0, 0, 0));
  next_cin_id = start3dcinematic("crc_part01_loop", 1, 0, 0, 0, 1);
  run_scene_and_delete("crc1");
  stop3dcinematic(cin_id);
  cin_id = next_cin_id;
  next_cin_id = start3dcinematic("crc_part02", 0, 0, 0, 0, 1);
  level thread run_scene_and_delete("crc1_idle");
  wait 3.0;
  wait_for_input("right");
  stop3dcinematic(cin_id);
  playsoundatposition("evt_ui_wall_803", (0, 0, 0));
  cin_id = next_cin_id;
  next_cin_id = start3dcinematic("crc_part02_loop", 1, 0, 0, 0, 1);
  run_scene_and_delete("crc2");
  stop3dcinematic(cin_id);
  cin_id = next_cin_id;
  next_cin_id = start3dcinematic("crc_part03", 0, 0, 0, 0, 1);
  level thread run_scene_and_delete("crc2_idle");
  wait 3.0;
  wait_for_input("unzoom");
  stop3dcinematic(cin_id);
  playsoundatposition("evt_ui_wall_805", (0, 0, 0));
  cin_id = next_cin_id;
  next_cin_id = start3dcinematic("crc_part03_loop", 1, 0, 0, 0, 1);
  run_scene_and_delete("crc3");
  stop3dcinematic(cin_id);
  cin_id = next_cin_id;
  next_cin_id = start3dcinematic("crc_part04", 0, 0, 0, 0, 1);
  level thread run_scene_and_delete("crc3_idle");
  wait 3.0;
  wait_for_input("unzoom");
  stop3dcinematic(cin_id);
  playsoundatposition("evt_ui_wall_807", (0, 0, 0));
  cin_id = next_cin_id;
  next_cin_id = start3dcinematic("crc_part04_loop", 1, 0, 0, 0, 1);
  level thread maps\_audio::switch_music_wait("KARMA_1_KARMA_FOUND", 2);
  run_scene_and_delete("crc4");
  stop3dcinematic(cin_id);
  cin_id = next_cin_id;
  next_cin_id = start3dcinematic("crc_part05", 0, 0, 0, 0, 1);
  level thread run_scene_and_delete("crc4_idle");
  wait 3.0;
  wait_for_input("up");
  stop3dcinematic(cin_id);
  playsoundatposition("evt_ui_wall_809", (0, 0, 0));
  cin_id = next_cin_id;
  run_scene_and_delete("crc5");
  stop3dcinematic(cin_id);
  level.player maps\createart\karma_art::vision_set_change("sp_karma_crc");
  level.player_interactive_model = "c_usa_masonjr_karma_armlaunch_viewbody";
}

wait_for_input(str_input) {
  switch (str_input) {
    case "attack":
      str_msg = & "KARMA_HINT_ATTACK";
      break;
    case "melee":
      str_msg = & "KARMA_HINT_MELEE";
      break;
    case "down":
      str_msg = & "KARMA_HINT_MOVE_DOWN";
      break;
    case "left":
      str_msg = & "KARMA_HINT_MOVE_LEFT";
      break;
    case "right":
      str_msg = & "KARMA_HINT_MOVE_RIGHT";
      break;
    case "up":
      str_msg = & "KARMA_HINT_MOVE_UP";
      break;
    case "sprint":
      str_msg = & "KARMA_HINT_SPRINT";
      break;
    case "use":
      str_msg = & "KARMA_HINT_USE";
      break;
    case "zoom":
      str_msg = & "KARMA_HINT_ZOOM";
      break;
    case "unzoom":
      str_msg = & "KARMA_HINT_UNZOOM";
      break;
  }

  hud_prompt = newhudelem();
  hud_prompt.elemtype = "font";
  hud_prompt.font = "objective";
  hud_prompt.fontscale = 3.0;
  hud_prompt.horzalign = "center";
  hud_prompt.vertalign = "middle";
  hud_prompt.alignx = "center";
  hud_prompt.aligny = "middle";
  hud_prompt.y = 177;
  hud_prompt.sort = 2;
  hud_prompt.color = (1, 1, 1);
  hud_prompt.alpha = 0.7;
  hud_prompt.hidewheninmenu = 1;
  hud_prompt settext(str_msg);

  if(level.wiiu) {
    hud_prompt.y = 188;
    hud_prompt.fontscale = 2.1;
  }

  b_got_input = 0;

  while(!b_got_input) {
    v_lstick = level.player get_normalized_movement(1, 1);
    v_rstick = level.player get_normalized_camera_movement(1, 1);

    if(level.wiiu) {
      controllertype = level.player getcontrollertype();

      if(controllertype == "remote")
        v_rstick = level.player get_normalized_dpad_movement();
    }

    switch (str_input) {
      case "attack":
        if(level.player attackbuttonpressed())
          b_got_input = 1;

        break;
      case "melee":
        if(level.player meleebuttonpressed())
          b_got_input = 1;

        break;
      case "down":
        if(v_lstick[0] < -0.8 && v_rstick[0] < -0.8)
          b_got_input = 1;

        break;
      case "left":
        if(v_lstick[1] < -0.8 && v_rstick[1] < -0.8)
          b_got_input = 1;

        break;
      case "right":
        if(v_lstick[1] > 0.8 && v_rstick[1] > 0.8)
          b_got_input = 1;

        break;
      case "up":
        if(v_lstick[0] > 0.8 && v_rstick[0] > 0.8)
          b_got_input = 1;

        break;
      case "sprint":
        if(level.player sprintbuttonpressed())
          b_got_input = 1;

        break;
      case "use":
        if(level.player usebuttonpressed())
          b_got_input = 1;

        break;
      case "zoom":
        if(v_lstick[1] < -0.6 && v_rstick[1] > 0.6)
          b_got_input = 1;

        break;
      case "unzoom":
        if(v_lstick[1] > 0.6 && v_rstick[1] < -0.6)
          b_got_input = 1;

        break;
    }

    wait 0.05;
  }

  hud_prompt destroy();
}

trespasser_perk() {
  if(!level.player hasperk("specialty_trespasser")) {
    trigger_off("trespasser_reward_interact_trigger", "targetname");
    return;
  }

  set_objective_perk(level.obj_trespasser, getstruct("trespasser_obj_marker", "targetname"), undefined, getent("trespasser_volume", "targetname"));
  trigger_wait("trespasser_reward_interact_trigger");
  remove_objective_perk(level.obj_trespasser);
  level thread run_scene_and_delete("trespasser");
  level.player queue_dialog("sect_farid_they_have_us_0");
  level.player queue_dialog("sect_can_you_access_the_p_0");
  level.player queue_dialog("sect_on_my_mark_kill_the_0");
  level.player queue_dialog("fari_sure_what_do_you_n_0");
  maps\_glasses::add_visor_text("KARMA_TRESPASSER_DATA", 4, "default", "bright", 1, 0.25, 0.25);
  flag_set("trespasser_reward_enabled");
  level.player set_temp_stat(1, 1);

  foreach(ai_guy in getaiarray("axis")) {
    if(isalive(ai_guy))
      ai_guy thread maps\karma_util::turn_on_enemy_highlight();
  }
}