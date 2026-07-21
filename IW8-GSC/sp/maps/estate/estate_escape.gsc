/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\estate\estate_escape.gsc
***********************************************/

estate_escape_precache() {
  precachemodel("ee_door_wood_stained_int_01_keypad_unlocked");
  precacheitem("iw8_la_sidewinder");
  precacheitem("fighter_spotlight");
  precacheitem("iw8_mindia8_turret");
  precachemodel("veh8_mil_air_mindia8_spotlight");
  precacheitem("smoke_grenade");
  precachemodel("ee_door_wood_stained_int_01_est_hvt_dst");
  precachemodel("weapon_wm_me_soscar_knife");
  precachemodel("weapon_wm_la_juliet_missile");
  precachemodel("veh8_mil_air_mindia8_turret");
  precachestring(&"ESTATE/HELI_PLR_DEATH");
  setdvarifuninitialized("exfil_animated", 1);
  scripts\engine\sp\utility::add_hint_string("bash_hint", &"ESTATE/BASH_HINT");
  scripts\sp\maps\estate\estate_util.gsc::hide_ents("corridor_collapse");
  scripts\sp\maps\estate\estate_util.gsc::hide_ents("corridorshootblocker");
  scripts\sp\maps\estate\estate_util.gsc::hide_ents("collapse_blocker_a");
  scripts\sp\maps\estate\estate_util.gsc::hide_ents("collapse_blocker_b");
  getEnt("stairs_destroyed_window", "script_noteworthy") hide();
  var_0 = getEntArray("heli_pos_override", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\engine\sp\utility::add_trigger_function, ::heli_pos_override_trig);
}

checksprinting() {
  if(level.player issprinting() || level.player sprintbuttonPressed())
    return 1;

  return 0;
}

escape_trig_logic() {
  self endon("death");
  wait 0.15;
  var_0 = undefined;

  if(isDefined(self.target))
    var_0 = scripts\engine\utility::getStructArray(self.target, "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  self waittill("trigger");
  var_1 = 0;

  foreach(var_3 in var_0) {
    var_3 scripts\engine\utility::script_delay();

    switch (var_3.script_noteworthy) {
      case "smoke":
        if(istrue(self.smoked)) {
          break;
        }

        var_3 scripted_smoke_gren();
        self.smoked = 1;
        break;
      default:
        break;
    }

    var_1++;

    if(var_1 >= 4) {
      wait 0.05;
      var_1 = 0;
    }
  }
}

scripted_smoke_gren() {
  playFX(scripts\engine\utility::getfx("vfx_est_smk_grenade_hero"), self.origin);
  thread scripts\engine\utility::play_sound_in_space("smoke_grenade_expl_trans", self.origin);
}

estate_escape_flags() {
  scripts\engine\utility::flag_init("lighting_fire_obj_room_hero");
  scripts\engine\utility::flag_init("grounds_cleared");
  scripts\engine\utility::flag_init("obj_scene_started");
  scripts\engine\utility::flag_init("spawn_escape_heli");
  scripts\engine\utility::flag_init("window_spotlight_sweep_done");
  scripts\engine\utility::flag_init("obj_room_vo_complete");
  scripts\engine\utility::flag_init("door_push_start");
  scripts\engine\utility::flag_init("explosion_scene");
  scripts\engine\utility::flag_init("explosion_scene_done");
  scripts\engine\utility::flag_init("escape_intro");
  scripts\engine\utility::flag_init("escape_begin");
  scripts\engine\utility::flag_init("tunnel_approach");
  scripts\engine\utility::flag_init("hadir_at_tunnel");
  scripts\engine\utility::flag_init("price_at_tunnel");
  scripts\engine\utility::flag_init("tunnel_open");
  scripts\engine\utility::flag_init("player_reached_drain_tunnel");
  scripts\engine\utility::flag_init("player_in_tunnel");
  scripts\engine\utility::flag_init("player_entered_tunnel_gate");
}

obj_room_start() {
  scripts\sp\maps\estate\estate_util.gsc::spawn_price();
  level.price.pushable = 0;
  scripts\engine\sp\utility::set_start_location("obj_room_start", [level.price, level.player]);
}

obj_room_main() {
  scripts\engine\sp\utility::flagwaitthread("door_opened", scripts\engine\sp\utility::autosave_by_name, "obj_room");
  level.animnodes["mcguffin_struct"] = scripts\engine\utility::getStruct("mcguffin_struct", "targetname");
  level.price thread price_door_nag();
  obj_door_setup();
  thread keypad_interact();
  thread obj_room_fov_change();
  scripts\sp\maps\estate\estate_util.gsc::spawn_hadir();
  level.hadir scripts\common\ai::gun_remove();
  level.animnodes["mcguffin_struct"] thread scripts\common\anim::anim_first_frame_solo(level.hadir, "obj_scene");
  scripts\engine\sp\utility::flagwaitthread("door_opened", scripts\engine\sp\objectives::objective_set_description, "estate", &"ESTATE/OBJ_DESC_HADIR");
  scripts\engine\sp\utility::flagwaitthread("door_opened", scripts\sp\analytics::analytics_kleenex_update, "reached 3rd floor keypad");
  thread obj_room_scene();
  scripts\engine\utility::flag_wait("obj_scene_started");
  scripts\engine\utility::delaythread(4, ::quietly_kill_all_axis);
  level scripts\engine\utility::thread_on_notify("all_axis_killed", scripts\sp\maps\estate\estate_util.gsc::post_grounds_cleanup);
  scripts\engine\utility::flag_wait("spawn_escape_heli");
}

obj_room_scene() {
  var_0 = level.animnodes["mcguffin_struct"];
  level waittill("keypad_interact");
  level.price scripts\common\utility::lookatentity(undefined);
  level.price stopsounds();
  scripts\engine\utility::delaythread(2, scripts\sp\maps\estate\estate_util.gsc::price_line, "dx_vom_pri_obj_room_ext_10");
  level.player scripts\common\utility::allow_death(0, "keypad");
  var_1 = var_0 scripts\sp\player_rig::link_player_to_rig("door_keypad", "stand", 1, 0.5, 0, 45, 45, 30, 15, 1, undefined, 1);
  var_0 thread scripts\common\anim::anim_single_solo(var_1, "door_keypad");
  var_1 thread scripts\engine\utility::waittillmatch_notify("single anim", "end", "unlink_player");
  var_1 scripts\engine\utility::thread_on_notify("unlink_player", scripts\sp\player_rig::unlink_player_from_rig, 0);
  var_1 scripts\engine\utility::thread_on_notify("unlink_player", scripts\common\utility::allow_death, 1, "keypad", level.player);
  scripts\engine\sp\utility::autosave_by_name("obj_room");
  scripts\engine\utility::flag_set("obj_scene_started");
  level.price.ignoreme = 1;
  level.price.ignoreall = 1;
  level.cutters hide();
  level.failonfriendlyfire = 1;
  var_2 = scripts\engine\sp\utility::spawn_anim_model("obj_plans", (0, 0, 0), (0, 0, 0));

  if(level.price isinscriptedstate()) {
    level.price notify("stop_loop_price");
    level.price scripts\engine\sp\utility::anim_stopanimScripted();
  }

  var_3 = [level.obj_door, level.price, level.hadir, var_2];
  var_0 scripts\common\anim::anim_single(var_3, "obj_scene");
  var_2 linkTo(level.price, "tag_stowed_back3");
}

obj_room_fov_change() {
  level waittill("keypad_interact");
  level.player modifybasefov(60, 2);
  level waittill("door_pushed");
  level.player modifybasefov(65, 2);
}

obj_door_setup() {
  var_0 = getEnt("obj_door", "targetname");
  var_0 thread obj_door_destroy();
  var_1 = scripts\engine\sp\utility::spawn_anim_model("obj_door", var_0.origin, var_0.angles);
  level.animnodes["mcguffin_struct"] scripts\common\anim::anim_first_frame_solo(var_1, "obj_scene");
  waittillframeend;
  var_1.clip = getEnt(var_0.target, "targetname");
  var_1.clip linkTo(var_0);
  var_1.script_model = var_0;
  var_0 linkTo(var_1);
  var_2 = var_0 scripts\engine\utility::get_linked_ent();
  var_2 linkTo(var_1);
  var_2 thread keypad_unlock();
  level.obj_door = var_1;
}

obj_door_destroy() {
  level waittill("heli_obj_room_start_shooting");

  while(level.escape_heli.minigun.target_ent.origin[0] - self.origin[0] > 15)
    waitframe();

  scripts\engine\utility::exploder("door_swap");
  self setModel("ee_door_wood_stained_int_01_est_hvt_dst");
  level notify("obj_door_destroyed");
}

keypad_unlock() {
  scripts\engine\utility::flag_wait("door_opened");
  self setModel("ee_door_wood_stained_int_01_keypad_unlocked");
  killfxontag(scripts\engine\utility::getfx("vfx_estate_keypad_light_red"), self.fx, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_estate_keypad_light_green"), self.fx, "tag_origin");
  level waittill("obj_door_destroyed");
  killfxontag(scripts\engine\utility::getfx("vfx_estate_keypad_light_green"), self.fx, "tag_origin");
  self.fx delete();
}

keypad_interact() {
  var_0 = scripts\engine\utility::getStruct("obj_interact", "targetname");
  var_0 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, undefined, undefined, undefined, undefined, undefined, 1);
  var_0 waittill("trigger");
  level notify("keypad_interact");

  if(scripts\engine\utility::flag("stealth_spotted"))
    scripts\engine\utility::delaythread(1, scripts\sp\maps\estate\estate_util.gsc::kyle_line, "dx_vom_kyle_obj_room_plans_33");
  else
    scripts\engine\utility::delaythread(1, scripts\sp\maps\estate\estate_util.gsc::kyle_line, "dx_vom_kyle_obj_room_plans_32");

  scripts\engine\sp\objectives::objective_complete("mansion");
}

price_door_nag() {
  level endon("keypad_interact");
  scripts\engine\utility::flag_wait("met_up_with_price");
  childthread price_door_lookats();

  if(level.price isinscriptedstate()) {
    level.price notify("stop_loop_price");
    level.price scripts\engine\sp\utility::anim_stopanimScripted();
  }

  var_0 = ["dx_vom_pri_objroom_exterior_30", "dx_vom_pri_objroom_exterior_20", "dx_vom_pri_objroom_exterior_10"];
  var_1 = ["dx_vom_pri_objroom_exterior_50", "dx_vom_pri_objroom_exterior_60", "dx_vom_pri_objroom_exterior_40"];

  if(scripts\engine\utility::flag("stealth_spotted")) {
    var_2 = var_1[0];
    thread scripts\sp\maps\estate\estate_util.gsc::price_line(var_2);
    var_1 = scripts\engine\utility::array_remove(var_1, var_2);
    var_1[var_1.size] = var_2;
  } else {
    var_2 = var_0[0];
    thread scripts\sp\maps\estate\estate_util.gsc::price_line(var_2);
    var_0 = scripts\engine\utility::array_remove(var_0, var_2);
    var_0[var_0.size] = var_2;
  }

  if(!level.price scripts\sp\maps\estate\estate_util.gsc::can_i_see_an_enemy_or_can_enemies_see_me()) {
    level.price thread scripts\common\anim::anim_loop_solo_with_nags(level.price, "obj_idle", "stop_loop_price");
    var_3 = undefined;

    while(!level.price scripts\sp\maps\estate\estate_util.gsc::can_i_see_an_enemy_or_can_enemies_see_me()) {
      if(!scripts\engine\utility::is_equal(var_3, scripts\engine\utility::flag("stealth_spotted"))) {
        var_3 = scripts\engine\utility::flag("stealth_spotted");
        level.price thread scripts\sp\maps\estate\estate_util.gsc::notetrack_nag(scripts\engine\utility::ter_op(var_3, var_1, var_0), ["keypad_interact", "stealth_spotted", "price_in_combat"]);
      }

      waitframe();
    }

    level notify("price_in_combat");
    level.price notify("stop_loop_price");
    level.price scripts\engine\sp\utility::anim_stopanimScripted();
    level.price scripts\common\utility::lookatentity();
  }

  wait 6;

  for(;;)
    scripts\sp\maps\estate\estate_util.gsc::nags_til_notify(scripts\engine\utility::ter_op(scripts\engine\utility::flag("stealth_spotted"), var_1, var_0), ["keypad_interact", "stealth_spotted"]);
}

price_door_lookats() {
  var_0 = [];

  foreach(var_2 in scripts\engine\utility::getStructArray("price_lookat_struct", "targetname"))
  var_0[var_0.size] = var_2 scripts\engine\utility::spawn_script_origin();

  level scripts\engine\utility::thread_on_notify("keypad_interact", scripts\engine\utility::array_delete, var_0);
  var_4 = 0;
  var_5 = level.player;
  var_6 = gettime() + 5000;

  for(;;) {
    if(gettime() >= var_6 && !level.price scripts\sp\maps\estate\estate_util.gsc::can_i_see_an_enemy_or_can_enemies_see_me()) {
      if(isPlayer(var_5)) {
        var_5 = var_0[scripts\sp\maps\estate\estate_util.gsc::abs_int(var_4 % var_0.size)];
        var_4++;
      } else
        var_5 = level.player;

      level.price glanceatentity(var_5, 1000, 0);
      var_6 = gettime() + 5000;
    }

    waitframe();
  }
}

obj_room_catchup() {
  thread scripts\sp\maps\estate\estate_util.gsc::post_grounds_cleanup();
  scripts\engine\sp\objectives::objective_complete("mansion");
  scripts\engine\sp\objectives::objective_set_description("estate", &"ESTATE/OBJ_DESC_HADIR");
  scripts\engine\utility::flag_set("spawn_escape_heli");
}

heli_attack_start() {
  scripts\sp\maps\estate\estate_util.gsc::spawn_friendlies();
  level.hadir scripts\common\ai::gun_remove();
  scripts\engine\sp\utility::set_start_location("heli_attack_start", [level.player]);
  level.animnodes["mcguffin_struct"] = scripts\engine\utility::getStruct("mcguffin_struct", "targetname");
  level.animnodes["mcguffin_struct"] thread scripts\common\anim::anim_single(level.friendlies, "obj_scene");
  var_0 = 0.773026;
  level.hadir scripts\engine\utility::delaycall(0.05, ::setanimtime, level.hadir scripts\engine\utility::getanim("obj_scene"), var_0);
  level.price scripts\engine\utility::delaycall(0.05, ::setanimtime, level.price scripts\engine\utility::getanim("obj_scene"), var_0);
  thread obj_door_setup();
  level.failonfriendlyfire = 1;
  scripts\engine\utility::flag_set("lighting_heli_attack");
}

heli_attack_main() {
  spawn_escape_heli();
  scripts\engine\sp\utility::autosave_by_name("heli_attack");
  thread vo_heli_attack();
  scripts\engine\sp\utility::flagwaitthread("window_spotlight_sweep_done", scripts\sp\maps\estate\estate_util.gsc::show_ents, "corridor_collapse");
  scripts\engine\sp\utility::flagwaitthread("window_spotlight_sweep_done", scripts\engine\utility::exploder, "stairdamage");
  scripts\engine\sp\utility::flagwaitthread("window_spotlight_sweep_done", scripts\engine\utility::exploder, "stairdamage_b");
  scripts\engine\sp\utility::flagwaitthread("window_spotlight_sweep_done", scripts\engine\utility::delaythread, 1, ::turn_off_lights);
  scripts\engine\sp\utility::flagwaitthread("window_spotlight_sweep_done", scripts\engine\utility::delaythread, 1, ::obj_room_explosion);
  scripts\engine\sp\utility::flagwaitthread("window_spotlight_sweep_done", scripts\engine\sp\utility::enable_trigger_with_targetname, "mansion_fire");
  scripts\engine\sp\utility::flagwaitthread("door_push_start", scripts\engine\sp\utility::autosave_by_name, "heli_attack");
  heli_attack_scene();
}

heli_attack_objective() {
  scripts\engine\sp\objectives::objective_set_description("estate", &"ESTATE/OBJ_DESC_ESCAPE");
}

heli_attack_scene() {
  level.hadir waittillmatch("single anim", "end");
  var_0 = level.animnodes["mcguffin_struct"];
  var_0 thread scripts\common\anim::anim_loop(level.friendlies, "heli_idle");
  level waittill("end_cover_loop");
  scripts\engine\utility::delaythread(4, ::player_door_wedge);
  var_0 notify("stop_loop");
  scripts\engine\utility::array_thread(level.friendlies, scripts\engine\sp\utility::anim_stopanimscripted);
  var_0 thread scripts\common\anim::anim_single(level.friendlies, "obj_scene_b");
  thread audio_start_obj_room_fires();
  scripts\engine\utility::flag_wait("door_push_start");
  thread friendlies_at_door(var_0);
  level.hadir playsoundatviewheight("dx_vom_had_meet_hadir_idle");
  level.price playsoundatviewheight("dx_vom_pri_meet_hadir_idle");
  level.failonfriendlyfire = undefined;
  scripts\sp\friendlyfire::turnoff();
  var_1 = getEnt("door_push_trigger", "targetname");
  var_2 = 0;
  var_3 = 1;

  for(;;) {
    waitframe();

    if(level.player istouching(var_1) && scripts\engine\math::get_dot(level.player.origin, level.player.angles, var_1.origin) > 0.5) {
      if(var_3) {
        level.player scripts\common\utility::allow_melee(0, "heli_attack");
        var_3 = 0;
      }

      if(!var_2) {
        scripts\engine\sp\utility::display_hint_forced("bash_hint", 5, 2, level, "door_pushed");
        var_2 = 1;
      }

      if(level.player meleeButtonPressed() || level.player issprinting()) {
        break;
      }
    } else if(!var_3) {
      level.player scripts\common\utility::allow_melee(1, "heli_attack");
      var_3 = 1;
    }
  }

  if(!var_3)
    level.player scripts\common\utility::allow_melee(1, "heli_attack");

  level.hadir stopsounds();
  level.price stopsounds();
  level notify("door_pushed");
  setup_hallway_scriptables();
  scripts\sp\player_rig::link_player_to_rig(undefined, "stand", 0, 0, 0, 0, 0, 0, 0, 1);
  var_0 thread scripts\sp\player_rig::anim_lerp_from_player_pos("door_push", 0.2, 0.2);
  thread unlink_player_from_rig_after_anim();
  level.player scripts\engine\utility::delaycall(0.2, ::lerpviewangleclamp, 1, 0.5, 0.5, 45, 45, 30, 10);
  var_0 notify("stop_loop");
  scripts\engine\utility::array_thread(level.friendlies, scripts\engine\sp\utility::anim_stopanimscripted);
  var_4 = [level.price, level.hadir, level.obj_door];
  var_0 scripts\common\anim::anim_single(var_4, "door_push");
  scripts\sp\friendlyfire::turnbackon();
  level.price.ignoreme = 0;
  level.price.ignoreall = 0;
  level.cutters show();
}

audio_start_obj_room_fires() {
  level.obj_room_fire_01 = spawn("script_origin", (602, 3081, 517));
  level.obj_room_fire_02 = spawn("script_origin", (607, 3272, 517));
  level.obj_room_fire_03 = spawn("script_origin", (367, 3277, 517));
  level.obj_room_fire_04 = spawn("script_origin", (325, 3038, 517));
  level.obj_room_fire_05 = spawn("script_origin", (460, 3476, 474));
  level.obj_room_fire_06 = spawn("script_origin", (196, 3322, 466));
  level.obj_room_fire_07 = spawn("script_origin", (17, 3378, 466));
  level.obj_room_fire_08 = spawn("script_origin", (-663, 3418, 271));
  level.obj_room_fire_09 = spawn("script_origin", (-586, 3341, 212));
  level.obj_room_fire_10 = spawn("script_origin", (-508, 3184, 86));
  level.obj_room_fire_11 = spawn("script_origin", (-463, 3241, 30));
  wait 0.2;
  level.obj_room_fire_01 playLoopSound("emt_fire_large_lp_01");
  wait 0.2;
  level.obj_room_fire_02 playLoopSound("emt_fire_med_lp_01");
  wait 0.2;
  level.obj_room_fire_03 playLoopSound("emt_fire_large_lp_02");
  wait 0.2;
  level.obj_room_fire_04 playLoopSound("emt_fire_med_lp_02");
  wait 0.2;
  level.obj_room_fire_05 playLoopSound("emt_fire_large_lp_01");
  wait 0.2;
  level.obj_room_fire_06 playLoopSound("emt_fire_small_lp_02");
  wait 0.2;
  level.obj_room_fire_07 playLoopSound("emt_fire_small_lp_01");
  wait 0.2;
  level.obj_room_fire_08 playLoopSound("emt_fire_large_lp_02");
  wait 0.2;
  level.obj_room_fire_09 playLoopSound("emt_fire_large_lp_01");
  wait 0.2;
  level.obj_room_fire_10 playLoopSound("emt_fire_med_lp_01");
  wait 0.2;
  level.obj_room_fire_11 playLoopSound("emt_fire_small_lp_01");
}

player_door_wedge() {
  var_0 = getEnt("player_door_wedge", "targetname");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_2 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  var_3 = var_1 scripts\engine\utility::spawn_tag_origin();
  var_0 linkTo(var_3);
  var_0 solid();
  var_3 moveTo(var_2.origin, 4);
  level waittill("door_pushed");
  var_3 delete();
  var_0 delete();
}

unlink_player_from_rig_after_anim() {
  level.player_rig waittillmatch("single anim", "end");
  scripts\sp\player_rig::unlink_player_from_rig();
}

friendlies_at_door(var_0) {
  level endon("door_pushed");
  level.price waittillmatch("single anim", "end");
  var_0 thread scripts\common\anim::anim_loop(level.friendlies, "door_push_idle");
}

vo_heli_attack() {
  waitframe();
  level.escape_heli.pilot scripts\engine\utility::delaythread(5, scripts\engine\sp\utility::smart_dialogue_generic, "dx_vom_ru2_heli_callout_50");
  scripts\engine\utility::delaythread(7, scripts\sp\maps\estate\estate_util.gsc::price_line, "dx_vom_pri_obj_room_plans_191");
  level waittill("end_cover_loop");
  wait 1;
  scripts\sp\maps\estate\estate_util.gsc::kyle_line("dx_vom_kyle_obj_room_plans_220");
  scripts\engine\utility::delaythread(2, ::heli_attack_objective);
  scripts\engine\utility::flag_set_delayed("obj_room_vo_complete", 5);
  scripts\engine\utility::flag_wait("door_push_start");
  level endon("door_pushed");
  level.player endon("death");
  var_0 = ["dx_vom_pri_obj_room_plans_295", "dx_vom_pri_obj_room_plans_290"];

  foreach(var_2 in var_0) {
    wait 5;
    scripts\sp\maps\estate\estate_util.gsc::price_line(var_2);
    wait 5;
  }
}

turn_off_lights() {
  foreach(var_1 in level.fuseboxes) {
    if(var_1.script_light_switch_state)
      var_1 scripts\sp\interactables\dynolight::lightswitch_toggle();

    var_1 scripts\sp\interactables\dynolight::lightswitch_disable(1);
  }

  scripts\sp\maps\estate\estate_util.gsc::turn_off_floodlights();
}

obj_room_explosion() {
  ambient_explosion();
  wait 1.5;
  ambient_explosion();
  wait 1;
}

heli_attack_fire_progression() {
  scripts\engine\utility::delaythread(3, scripts\engine\sp\utility::enable_trigger_with_targetname, "obj_room_fire_a");
  scripts\engine\utility::delaythread(6.5, scripts\engine\sp\utility::disable_trigger_with_targetname, "obj_room_fire_a");
  scripts\engine\utility::delaythread(6.5, scripts\engine\sp\utility::enable_trigger_with_targetname, "obj_room_fire_b");
  scripts\engine\utility::delaythread(30, scripts\engine\sp\utility::disable_trigger_with_targetname, "obj_room_fire_b");
  scripts\engine\utility::delaythread(30, scripts\engine\sp\utility::enable_trigger_with_targetname, "obj_room_fire_c");
  player_die_from_smoke_inhalation("door_pushed", 30);
}

player_die_from_smoke_inhalation(var_0, var_1) {
  var_2 = scripts\sp\hud_util::create_client_overlay("black", 0, level.player);
  player_die_from_smoke_inhalation_thread(var_0, var_1, var_2);

  if(!isalive(level.player)) {
    return;
  }
  var_2 fadeovertime(2);
  var_2.alpha = 0;
  var_2 scripts\engine\utility::delaycall(2.5, ::destroy);
}

player_die_from_smoke_inhalation_thread(var_0, var_1, var_2) {
  level.player endon("death");
  level endon(var_0);
  var_3 = ["ges_ph_cough_a", "ges_ph_cough_c", "ges_ph_cough_a", "ges_ph_cough_b", "ges_ph_cough_c"];
  var_4 = ["gas_player_cough_1", "gas_player_cough_3", "gas_player_cough_1", "gas_player_cough_3", "gas_player_cough_1"];
  var_5 = 0;
  var_6 = var_1;
  var_7 = gettime() + var_1 * 1000;

  while(gettime() < var_7) {
    var_2 fadeovertime(1);
    var_2.alpha = (1 - var_6 / var_1) * 0.75;
    var_6 = (var_7 - gettime()) / 1000;
    wait(max(var_6 * 0.25, 5));

    for(var_8 = 0; !var_8; var_8 = level.player forceplaygestureviewmodel(var_3[scripts\sp\maps\estate\estate_util.gsc::abs_int(var_5 % var_3.size)]))
      waitframe();

    level.player scripts\sp\anim::play_sound_at_viewheight(var_4[scripts\sp\maps\estate\estate_util.gsc::abs_int(var_5 % var_4.size)]);
    var_2 fadeovertime(1);

    if(var_7 - gettime() <= 1000) {
      break;
    }

    var_5++;
    var_2.alpha = 0.75;
    wait 1;
  }

  var_2.alpha = 1;
  level.player kill();
}

setup_hallway_scriptables() {
  scripts\engine\utility::flag_wait("scriptables_init_complete");
  var_0 = scripts\engine\utility::getStruct("hallway_run_dynlt_pointer", "targetname");
  scripts\engine\utility::array_call(var_0 scripts\engine\sp\utility::get_linked_scriptables(), ::setscriptablepartstate, "onoff", "hidden");

  foreach(var_2 in getscriptablearray("fall_chandelier", "targetname")) {
    var_2 show();
    var_2 setCanDamage(1);
  }
}

heli_attack_catchup() {
  level.animnodes["mcguffin_struct"] = scripts\engine\utility::getStruct("mcguffin_struct", "targetname");
  scripts\engine\utility::delaythread(0.05, scripts\sp\maps\estate\estate_util.gsc::show_ents, "corridor_collapse");
  scripts\engine\utility::delaythread(0.1, ::turn_off_lights);
  heli_attack_objective();
  scripts\engine\utility::exploder("stairdamage");

  if(!scripts\sp\starts::is_after_start("stairs_explosion"))
    scripts\engine\utility::exploder("stairdamage_b");

  var_0 = getEnt("player_door_wedge", "targetname");
  var_0 delete();
}

hallway_run_start() {
  level.animnodes["mcguffin_struct"] = scripts\engine\utility::getStruct("mcguffin_struct", "targetname");
  spawn_escape_heli();
  scripts\sp\maps\estate\estate_util.gsc::spawn_friendlies();
  level.hadir scripts\common\ai::gun_remove();
  var_0 = [level.price, level.player];
  scripts\engine\sp\utility::set_start_location("hallway_run_start", var_0);
  level.price.goalradius = 32;
  thread hallway_run_start_post_load();
  thread setup_hallway_scriptables();
  scripts\engine\utility::flag_set("lighting_fire_hallways");
  setsaveddvar("TLMMOPMSK", 1);
}

hallway_run_start_post_load() {
  waitframe();
  var_0 = scripts\engine\utility::getStruct("heli_at_side_window", "targetname");
  level.escape_heli vehicle_teleport(var_0.origin + (0, 0, 500), var_0.angles);
}

hallway_run_main() {
  level.player scripts\sp\player::set_player_max_health(300);
  thread player_die_from_smoke_inhalation("stairs_go", 15);
  thread scripts\sp\maps\estate\estate_util.gsc::show_ents("collapse_blocker_a");
  level.animnodes["explosion_scene"] = scripts\engine\utility::getStruct("explosion_scene", "targetname");
  scripts\engine\sp\utility::autosave_by_name("hallway_run");
  thread vo_hallway_run();
  thread scripts\sp\maps\estate\estate_infil.gsc::player_stay_behind_ai(100);
  scripts\engine\utility::array_thread(level.friendlies, scripts\common\utility::demeanor_override, "sprint");
  level.animnodes["mcguffin_struct"] thread scripts\common\anim::anim_single(level.friendlies, "hallway_exit");
  scripts\engine\utility::array_thread(level.friendlies, ::idle_at_stairs);
  scripts\engine\utility::flag_wait("stairs_go");
  level.player scripts\sp\player::set_player_max_health(level.player.maxhealth);
  scripts\engine\utility::array_thread(level.friendlies, scripts\common\utility::clear_demeanor_override);
}

idle_at_stairs() {
  self endon("explosion_scene_start");
  self waittillmatch("single anim", "end");

  if(self == level.price)
    thread scripts\sp\maps\estate\estate_util.gsc::notetrack_nag(["dx_vom_pri_objroom_heliatk_80", "dx_vom_pri_objroom_heliatk_95"], "explosion_scene");

  level.animnodes["explosion_scene"] thread scripts\common\anim::anim_loop_solo(self, "explosion_idle", "stop_loop_" + self.animname);
  self.in_position = 1;
}

vo_hallway_run() {
  scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_mansion_helistairs_15");
  wait 1.5;
  scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_objroom_heliatk_70");
  wait 0.65;
  scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_mansion_helistairs_20");

  if(!scripts\engine\utility::flag("stairs_go"))
    level.price thread scripts\sp\maps\estate\estate_util.gsc::nags_til_notify(["dx_vom_pri_objroom_heliatk_80", "dx_vom_pri_objroom_heliatk_95"], "stairs_go", 1, 5);

  scripts\engine\utility::flag_wait("stairs_go");
  scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_obj_room_plans_320");
}

hallway_run_catchup() {
  level.animnodes["explosion_scene"] = scripts\engine\utility::getStruct("explosion_scene", "targetname");
  thread scripts\sp\maps\estate\estate_util.gsc::show_ents("collapse_blocker_a");
}

stairs_attack_start() {
  spawn_escape_heli();
  scripts\sp\maps\estate\estate_util.gsc::spawn_friendlies();
  scripts\engine\sp\utility::set_start_location("stairs_attack_start", [level.player, level.price]);
  thread hallway_run_start_post_load();
  thread scripts\sp\maps\estate\estate_infil.gsc::player_stay_behind_ai(100);
  var_0 = scripts\engine\utility::getStruct("explosion_scene", "targetname");

  foreach(var_2 in level.friendlies) {
    var_0 thread scripts\common\anim::anim_loop_solo(var_2, "explosion_idle", "stop_loop_" + var_2.animname);
    var_2.in_position = 1;
  }

  thread hallway_run_start_post_load();
  scripts\engine\utility::flag_set("lighting_fire_hallways");
  setsaveddvar("TLMMOPMSK", 1);
}

stairs_attack_main() {
  scripts\engine\utility::exploder("corridorshoot");
  thread player_die_from_smoke_inhalation("explosion_scene", 15);
  thread stairs_explosion_scene();
  thread stairs_explosion_heli();
  scripts\engine\utility::flag_wait("explosion_scene");
  level.player scripts\engine\utility::delaycall(1.0, ::playsound, "escape_stairs_explo_lr");
  level.player scripts\engine\utility::delaycall(6.2, ::playsound, "escape_stairs_explo_debris_1_lr");
  level.player scripts\engine\utility::delaycall(7.3, ::playsound, "escape_stairs_explo_debris_2_lr");
  thread audio_stop_obj_room_fires();
  scripts\engine\utility::flag_wait("explosion_scene_done");
  level.player setmovespeedscale(1);
  setsaveddvar("OLMLOTTLRM", 1.4);
  thread scripts\sp\maps\estate\estate_infil.gsc::shutdown_player_stay_behind_ai();
}

audio_stop_obj_room_fires() {
  if(isDefined(level.obj_room_fire_01))
    level.obj_room_fire_01 thread scripts\engine\sp\utility::sound_fade_and_delete(5.0, 1);

  wait 0.2;

  if(isDefined(level.obj_room_fire_02))
    level.obj_room_fire_02 thread scripts\engine\sp\utility::sound_fade_and_delete(5.0, 1);

  wait 0.2;

  if(isDefined(level.obj_room_fire_03))
    level.obj_room_fire_03 thread scripts\engine\sp\utility::sound_fade_and_delete(5.0, 1);

  wait 0.2;

  if(isDefined(level.obj_room_fire_04))
    level.obj_room_fire_04 thread scripts\engine\sp\utility::sound_fade_and_delete(5.0, 1);

  wait 0.2;

  if(isDefined(level.obj_room_fire_05))
    level.obj_room_fire_05 thread scripts\engine\sp\utility::sound_fade_and_delete(5.0, 1);

  wait 0.2;

  if(isDefined(level.obj_room_fire_06))
    level.obj_room_fire_06 thread scripts\engine\sp\utility::sound_fade_and_delete(5.0, 1);

  wait 0.2;

  if(isDefined(level.obj_room_fire_07))
    level.obj_room_fire_07 thread scripts\engine\sp\utility::sound_fade_and_delete(5.0, 1);

  wait 0.2;

  if(isDefined(level.obj_room_fire_08))
    level.obj_room_fire_08 thread scripts\engine\sp\utility::sound_fade_and_delete(5.0, 1);

  level waittill("player_approaching_tunnel");

  if(isDefined(level.obj_room_fire_09))
    level.obj_room_fire_09 thread scripts\engine\sp\utility::sound_fade_and_delete(5.0, 1);

  wait 0.2;

  if(isDefined(level.obj_room_fire_10))
    level.obj_room_fire_10 thread scripts\engine\sp\utility::sound_fade_and_delete(5.0, 1);

  wait 0.2;

  if(isDefined(level.obj_room_fire_11))
    level.obj_room_fire_11 thread scripts\engine\sp\utility::sound_fade_and_delete(5.0, 1);
}

stairs_explosion_heli() {
  scripts\engine\sp\utility::flagwaitthread("player_in_3rdfloor_stairs", scripts\sp\maps\estate\estate_util.gsc::show_ents, "collapse_blocker_b");
  scripts\engine\sp\utility::flagwaitthread("player_in_3rdfloor_stairs", scripts\engine\utility::exploder, "vfxexp_stair_blocker");
  level.escape_heli heli_spotlight_toggle(1);
  var_0 = level.animnodes["explosion_scene"];
  var_1 = getstartorigin(var_0.origin, var_0.angles, level.scr_anim["hind"]["explosion_fire"]);
  var_2 = getstartangles(var_0.origin, var_0.angles, level.scr_anim["hind"]["explosion_fire"]);
  level.escape_heli nav_gotopos(var_1);
  level.escape_heli settargetyaw(var_2[1]);
  level.escape_heli heli_spotlight_sweep([level.player, var_0]);
}

stairs_explosion_scene() {
  var_0 = level.animnodes["explosion_scene"];
  var_1 = scripts\engine\sp\utility::spawn_anim_model("missile", var_0.origin, var_0.angles);
  var_2 = spawn("script_model", var_0.origin);
  var_2 linkTo(var_1, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_2 setModel("weapon_wm_la_juliet_missile");
  var_2 hide();
  var_0 scripts\common\anim::anim_first_frame_solo(var_1, "explosion_fire");
  scripts\engine\utility::flag_wait("explosion_scene");
  level.player scripts\common\utility::allow_mantle(0, "stairs_explosion");
  thread mus_heli_stairs();
  level.escape_heli heli_spotlight_toggle(0);
  scripts\engine\utility::flag_set("lighting_fire_collapse");
  level.price stopsounds();
  thread scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_estate_helo_11");
  thread stairs_explosion_price();
  var_2 show();
  thread stairs_scene_cowbell(var_2);
  scripts\engine\utility::delaythread(2.55, scripts\sp\maps\estate\estate_util.gsc::kyle_line, "dx_vom_plr_stairs_explosion_fall");
  var_0 thread scripts\common\anim::anim_single_solo(level.escape_heli, "explosion_fire");
  var_0 scripts\common\anim::anim_single_solo(var_1, "explosion_fire");
  var_3 = var_1.origin;
  var_1 delete();
  var_4 = [];

  for(var_5 = 1; var_5 <= 14; var_5++)
    var_4[var_4.size] = scripts\engine\sp\utility::spawn_anim_model("stairs_debris_" + var_5);

  var_0 thread scripts\common\anim::anim_single(var_4, "explosion_main");
  var_6 = scripts\engine\utility::getStruct("stairs_destroyed_pointer", "targetname");
  var_7 = var_6 scripts\engine\sp\utility::get_linked_scriptables();
  scripts\engine\utility::array_call(var_7, ::setscriptablepartstate, "onoff", "hidden");
  scripts\engine\utility::array_call(var_7, ::setcandamage, 0);

  foreach(var_9 in getscriptablearray("stairs_fall_chandelier", "targetname")) {
    var_9 show();
    var_9 setCanDamage(1);
    var_9 dodamage(100, var_3, level.escape_heli, undefined, "MOD_PROJECTILE", "iw8_la_sidewinder");
  }

  var_0 notify("stop_loop_" + level.hadir.animname);
  level.hadir scripts\engine\sp\utility::anim_stopanimScripted();
  level.hadir notify("explosion_scene_start");

  if(isDefined(level.hadir.in_position))
    var_0 thread scripts\common\anim::anim_single_solo(level.hadir, "explosion_main");

  if(distance2dsquared(level.escape_heli.origin, level.player.origin) < distance2dsquared(level.escape_heli.origin, level.price.origin)) {
    level.price hide();
    level.price scripts\engine\utility::delaycall(3, ::show);
  }

  level.player scripts\common\utility::allow_death(0);
  level.player.stairs_weapon = level.player getcurrentweapon();
  var_11 = scripts\sp\player_rig::link_player_to_rig(undefined, "stand", 0, 0, 0, 0, 0, 0, 0, 1);
  var_0 scripts\sp\player_rig::anim_lerp_from_player_pos("explosion_intro");
  stairs_explosion_player_hit(10);
  level.player lerpviewangleclamp(0.2, 0.1, 0.1, 25, 25, 15, 15);
  var_12 = getanimlength(var_11 scripts\engine\utility::getanim("explosion_main"));
  scripts\engine\utility::delaythread(var_12 - 1, ::stairs_explosion_player_hit, 100);
  level.player lerpfovscalefactor(0, 1.5);
  var_0 scripts\common\anim::anim_single_solo(var_11, "explosion_main");
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_music_and_dx", 0.3);
  setblur(100, 0);
  level.player_overlay = scripts\sp\hud_util::create_client_overlay("black", 1, level.player);
  stairs_explosion_player_hit(50);
  wait 0.2;
  var_13 = scripts\engine\utility::getStruct("escape_getup", "targetname");
  var_13 thread scripts\common\anim::anim_first_frame_solo(level.player_rig, "escape_getup");
  level.player clearclienttriggeraudiozone(6.0);

  if(level.player ispcplayer())
    setsaveddvar("OMNONNMOTP", "0.1 500 2.5 10000");

  wait 0.05;

  foreach(var_15 in var_4)
  var_15 delete();

  scripts\engine\utility::array_call(getEntArray("stairs_destroyed_animated", "script_noteworthy"), ::show);
  level.player scripts\common\utility::allow_death(1);
  level.escape_heli restart_rotors();
  scripts\engine\utility::flag_set("explosion_scene_done");
  level.price.disableplayeradsloscheck = 0;
  level.player scripts\common\utility::allow_mantle(1, "stairs_explosion");
}

stairs_explosion_player_hit(var_0) {
  level.player scripts\sp\utility::do_damage(var_0, level.player.origin - anglesToForward(level.player.angles) * 50, level.player, undefined, "MOD_IMPACT");
  earthquake(0.55, 0.5, level.player.origin, 400);
  playrumbleonposition("grenade_rumble", level.player.origin);
}

mus_heli_stairs() {
  setmusicstate("");
}

stairs_explosion_price() {
  level endon("explosion_scene_done");
  level.price notify("explosion_scene_start");
  level.animnodes["explosion_scene"] notify("stop_loop_" + level.price.animname);
  level.price scripts\engine\sp\utility::anim_stopanimScripted();

  if(isDefined(level.price.in_position))
    level.animnodes["explosion_scene"] scripts\common\anim::anim_single_solo(level.price, "explosion_fire");
  else {
    level.price.disableplayeradsloscheck = 1;
    level.animnodes["explosion_scene"] scripts\sp\anim::anim_reach_solo(level.price, "explosion_main");
    level.price.disableplayeradsloscheck = 0;
  }

  level.price.in_position = undefined;
  level.animnodes["explosion_scene"] scripts\common\anim::anim_single_solo(level.price, "explosion_main");
  level.price.stairs_scene_finished = 1;
}

slowmo_yes() {
  thread scripts\engine\sp\utility::player_speed_percent(30, 1);
  level.player enableslowaim(0.5, 0.5);
  level.player setpriorityclienttriggeraudiozonepartial("deathsdoor", "deathsdoor", "reverb");
  level.player setsoundsubmix("deaths_door_sp");
  scripts\engine\sp\utility::slowmo_lerp_in();
}

slowmo_no() {
  thread scripts\engine\sp\utility::player_speed_percent(100, 0.25);
  level.player disableslowaim();
  level.player clearpriorityclienttriggeraudiozone("deathsdoor");
  level.player clearsoundsubmix("deaths_door_sp");
  scripts\engine\sp\utility::slowmo_lerp_out();
}

restart_rotors() {
  self notify("suspend_drive_anims");
  waittillframeend;
  thread scripts\common\vehicle_code::animate_drive_idle();
}

stairs_scene_cowbell(var_0) {
  level waittill("missile_launch");
  thread scripts\engine\utility::play_sound_in_space("weap_estate_heli_proj_launch", var_0.origin);
  playFXOnTag(scripts\engine\utility::getfx("missile_muzzle"), level.escape_heli, "tag_origin");
  wait 0.15;
  playFXOnTag(scripts\engine\utility::getfx("missile_trail"), var_0, "tag_fx");
  wait 0.04;
  scripts\engine\utility::exploder("vfxexp_win_break");
  getEnt("stairs_pristine_window", "script_noteworthy") hide();
  getEnt("stairs_destroyed_window", "script_noteworthy") show();
  var_1 = getglassarray("breakglass");

  foreach(var_3 in var_1)
  destroyglass(var_3, anglesToForward((0, 360, 0)));

  var_5 = var_0 getlinkedparent();
  var_5 waittillmatch("single anim", "end");
  stopFXOnTag(scripts\engine\utility::getfx("missile_trail"), var_0, "tag_fx");
  scripts\engine\utility::exploder("collapse");
  thread scripts\engine\utility::play_sound_in_space("rocket_explode", var_0.origin);
  level.player scripts\sp\player::damagebloodoverlaydirectional(var_0.origin, "MOD_EXPLOSIVE");
  thread scripts\engine\sp\utility::earthquake_and_rumble(var_0.origin);
  playFX(scripts\engine\utility::getfx("missile_explode"), var_0.origin);
  var_0 delete();
  scripts\sp\maps\estate\estate_util.gsc::show_ents("stairs_destroyed", "stairs_destroyed_animated");
  scripts\sp\maps\estate\estate_util.gsc::hide_ents("stairs_pristine");
  scripts\engine\utility::exploder("collapseafter");
}

stairs_attack_catchup() {
  thread scripts\sp\maps\estate\estate_util.gsc::show_ents("collapse_blocker_b");
  thread scripts\sp\maps\estate\estate_util.gsc::show_ents("corridorshootblocker");
  scripts\engine\utility::delaythread(0.1, scripts\sp\maps\estate\estate_util.gsc::show_ents, "stairs_destroyed");
  scripts\engine\utility::delaythread(0.1, scripts\sp\maps\estate\estate_util.gsc::hide_ents, "stairs_pristine");
  scripts\engine\utility::exploder("corridorshoot");
  scripts\engine\utility::exploder("collapse");
  scripts\engine\utility::exploder("collapseafter");
}

escape_intro_start() {
  level.player_overlay = scripts\sp\hud_util::create_client_overlay("black", 1, level.player);
  setblur(100, 0);
  scripts\sp\maps\estate\estate_util.gsc::spawn_friendlies();
  thread spawn_escape_heli();
  level.player.stairs_weapon = level.player getweaponslistprimaries()[0];
  scripts\engine\utility::flag_set("lighting_escape");
  setsaveddvar("TLMMOPMSK", 1);
  var_0 = scripts\engine\utility::getStruct("escape_getup", "targetname");
  var_0 thread scripts\sp\player_rig::link_player_to_rig("escape_getup", "stand", 0, 0, 0, 10, 10, 5, 5, 1);
}

escape_intro_main() {
  scripts\engine\utility::kill_exploder("vfxexp_stair_blocker");
  scripts\engine\utility::kill_exploder("vfxexp_room_smoke");
  scripts\engine\utility::flag_set("escape_intro");
  scripts\engine\utility::flag_wait("grounds_cleared");
  scripts\engine\utility::array_thread(level.friendlies, scripts\engine\sp\utility::set_ignoreall, 1);
  scripts\engine\utility::delaythread(6.5, scripts\engine\utility::array_thread, level.friendlies, scripts\engine\sp\utility::set_ignoreall, 0);
  thread technical_cleanup();
  thread spawn_escape_weapons();
  scripts\engine\sp\utility::set_start_location("finale", scripts\engine\utility::array_add(level.friendlies, level.player));
  thread escape_scene_fadein();
  thread escape_intro_scene();
  thread track_player_indoors();
  scripts\engine\utility::flag_wait("escape_begin");
}

technical_cleanup() {
  if(isDefined(level.technical)) {
    if(isalive(level.technical)) {
      level.technical notify("gunner_defeated");
      level.technical.spotlight.tag delete();
      level.technical.spotlight delete();
      level.technical.mgturret[0] delete();
    } else
      level.technical.turret_dst delete();

    level.technical delete();
  }
}

escape_cine_dof(var_0) {
  level.price scripts\engine\utility::delaythread(0.1, scripts\engine\sp\utility::dof_enable_autofocus, 1.2, 4, undefined, undefined, "tag_eye", undefined, 1);
  level.price scripts\engine\utility::delaythread(11, scripts\engine\sp\utility::dof_enable_autofocus, 1.2, 3, undefined, undefined, "j_ball_ri", undefined, 1);
  var_0 scripts\engine\utility::delaythread(12, scripts\engine\sp\utility::dof_enable_autofocus, 0.7, 4, undefined, undefined, "tag_eye", undefined, 1);
  level.hadir scripts\engine\utility::delaythread(13.5, scripts\engine\sp\utility::dof_enable_autofocus, 0.7, 4, undefined, undefined, "tag_eye", undefined, 1);
  var_0 scripts\engine\utility::delaythread(15, scripts\engine\sp\utility::dof_enable_autofocus, 0.7, 6, undefined, undefined, "tag_eye", undefined, 1);
  level.price scripts\engine\utility::delaythread(17, scripts\engine\sp\utility::dof_enable_autofocus, 1.4, 3, undefined, undefined, "tag_eye", undefined, 1);
  level.hadir scripts\engine\utility::delaythread(20, scripts\engine\sp\utility::dof_enable_autofocus, 1.4, 3, undefined, undefined, "tag_eye", undefined, 1);
  level.price scripts\engine\utility::delaythread(23, scripts\engine\sp\utility::dof_enable_autofocus, 1.7, 500, undefined, undefined, "tag_eye", undefined, 1);
  level.hadir scripts\engine\utility::delaythread(30, scripts\engine\sp\utility::dof_enable_autofocus, 2, 500, undefined, undefined, "tag_eye", undefined, 1);
  level scripts\engine\utility::delaythread(32, scripts\engine\sp\utility::dof_disable_autofocus);
}

escape_intro_scene() {
  var_0 = scripts\engine\utility::getStruct("escape_getup", "targetname");
  var_1 = getanimlength(level.scr_anim["player_rig"]["escape_getup"]);
  var_2 = [];
  level.hadir.animname = "ally1";

  if(!isDefined(level.price.stairs_scene_finished)) {
    scripts\sp\anim::anim_reach_cleanup_solo(level.price);
    level.price scripts\engine\sp\utility::anim_stopanimScripted();
  } else
    level.price.stairs_scene_finished = undefined;

  var_3 = scripts\engine\sp\utility::spawn_anim_model("getup_debris", var_0.origin, var_0.angles);
  var_2[var_2.size] = var_3;
  var_4 = scripts\engine\sp\utility::spawn_anim_model("getup_board", var_0.origin, var_0.angles);
  var_2[var_2.size] = var_4;
  var_2 = scripts\engine\utility::array_combine([level.price, level.player_rig, level.hadir], var_2);
  var_5 = "iw8_ar_asierra12";
  var_6 = ["gripvert", "laserir", "reflex_east02"];
  var_7 = var_5;

  foreach(var_9 in var_6)
  var_7 = var_7 + ("+" + var_9);

  var_11 = scripts\engine\sp\utility::spawn_targetname("getup_enemy", 1);
  var_12 = getanimlength(var_11 scripts\engine\utility::getanim("escape_getup"));
  var_11 thread getupenemy_logic(var_12);
  var_11 scripts\anim\shared.gsc::forceuseweapon(var_7, "primary");
  var_11 scripts\sp\utility::context_melee_allow(0);
  level.getupenemy = var_11;
  var_11 attach("weapon_wm_me_soscar_knife", "tag_accessory_left");
  var_2[var_2.size] = var_11;
  var_13 = scripts\engine\sp\utility::spawn_targetname("getup_aq", 1);
  var_13.animname = "aq1";
  var_2[var_2.size] = var_13;
  level.player.ignoreme = 1;
  level.player enableinvulnerability();
  level.cutters scripts\engine\utility::delaycall(3, ::hide);
  level.cutters scripts\engine\utility::delaycall(var_1, ::show);
  var_3 scripts\engine\utility::delaycall(var_1, ::delete);
  var_4 scripts\engine\utility::delaycall(var_1, ::delete);
  level.player scripts\engine\utility::delaythread(var_1, ::player_post_getup);
  scripts\engine\utility::delaythread(var_1, ::escape_objective);
  scripts\engine\utility::delaythread(5, ::smoke_lasers);
  scripts\engine\utility::delaythread(var_1 - 3, scripts\engine\sp\utility::array_spawn_targetname, "escape_start_enemies", 1);
  scripts\engine\utility::delaythread(var_1, ::ally_equipment_init);
  scripts\engine\utility::delaythread(10.95, ::slam_price);
  thread escape_cine_dof(var_11);
  var_0 scripts\common\anim::anim_single(var_2, "escape_getup");
  level.hadir thread scripts\common\ai::gun_recall();
  scripts\engine\utility::flag_set("escape_begin");
  swap_player_ar(var_5, var_6);
  thread scripts\sp\maps\estate\estate_util.gsc::delete_at_distance_to_player(var_13.origin, 2000, [var_13]);

  foreach(var_15 in level.player getweaponslistprimaries()) {
    if(var_15.basename == "iw8_melee") {
      continue;
    }
    level.player scripts\engine\sp\utility::giveweaponmaxammo(var_15);
  }

  scripts\engine\utility::delaythread(2, scripts\engine\sp\utility::autosave_by_name, "escape");
}

slam_price() {
  level.price playRumbleOnEntity("heavy_1s");
  earthquake(0.75, 0.5, level.price.origin, 100);
  scripts\engine\utility::exploder("vfxexp_bodyslam");
  scripts\engine\utility::kill_exploder("stairdamage");
  scripts\engine\utility::kill_exploder("stairdamage_b");
}

getupenemy_logic(var_0) {
  spets_nvgs_on();
  wait(var_0 - 0.05);
  self.a.nodeath = 1;
  self.allowdeath = 1;
  scripts\common\ai::gun_remove();
  self kill();
}

player_post_getup() {
  level.player.ignoreme = 0;
  level.player disableinvulnerability();
  scripts\sp\player_rig::unlink_player_from_rig(0, "stand");
  scripts\engine\sp\utility::battlechatter_on();
  setmusicstate("mx_tmp_estate_grounds_infil");
  wait 35.0;
  setmusicstate("");
}

ally_equipment_init() {
  scripts\sp\maps\estate\estate_util.gsc::make_alias_group("flash_request", ["dx_vom_kyle_escape_offhand_10", "dx_vom_kyle_escape_offhand_30", "dx_vom_kyle_escape_offhand_50"]);
  scripts\sp\maps\estate\estate_util.gsc::make_alias_group("flash_response", ["dx_vom_pri_escape_offhand_20", "dx_vom_pri_escape_offhand_40", "dx_vom_pri_escape_offhand_60"]);
  scripts\sp\maps\estate\estate_util.gsc::make_alias_group("molotov_request", ["dx_vom_kyle_escape_offhand_90", "dx_vom_kyle_escape_offhand_110", "dx_vom_kyle_escape_offhand_70"]);
  scripts\sp\maps\estate\estate_util.gsc::make_alias_group("molotov_response", ["dx_vom_had_escape_offhand_80", "dx_vom_had_escape_offhand_100", "dx_vom_had_escape_offhand_120"]);
  level.player endon("death");
  level endon("player_approaching_tunnel");
  level.price childthread ally_equipment_think("flash", ::secondaryoffhandbuttonpressed, scripts\sp\maps\estate\estate_util.gsc::price_line);
  level.hadir childthread ally_equipment_think("molotov", ::fragbuttonpressed, scripts\sp\maps\estate\estate_util.gsc::hadir_line);
}

ally_equipment_think(var_0, var_1, var_2) {
  self.support_equipment = 0;
  self.next_equipment_time = 0;
  thread scripts\sp\player\ally_equipment::ally_equipment_backpack(self, var_0);

  for(;;) {
    if(istrue(self.refill_used)) {
      return;
    }
    if(gettime() >= self.next_equipment_time) {
      if(!level.player getweaponammoclip(var_0) && !self.support_equipment)
        childthread give_ally_equipment(var_0);

      if(level.player call[[var_1]]() && !level.player isthrowingbackgrenade()) {
        while(level.player call[[var_1]]())
          waitframe();

        if(level.player getweaponammoclip(var_0))
          level.player waittill("offhand_fired");

        if(!level.player getweaponammoclip(var_0)) {
          if(!self.support_equipment)
            childthread give_ally_equipment(var_0);

          scripts\sp\maps\estate\estate_util.gsc::kyle_line(scripts\sp\maps\estate\estate_util.gsc::get_next_alias_in_group(var_0 + "_request"));
          thread[[var_2]](scripts\sp\maps\estate\estate_util.gsc::get_next_alias_in_group(var_0 + "_response"));
          level.player notify("ally_equipment_notify");
          level.player.ally_equipment_force_ping = 1;
          wait 10;
        }
      }
    }

    waitframe();
    waittillframeend;
  }
}

give_ally_equipment(var_0) {
  self.support_equipment = 4;

  while(self.support_equipment)
    waitframe();

  self.next_equipment_time = gettime() + 30000;

  if(!isDefined(self.refill_used))
    self.refill_used = 0;
  else
    self.refill_used = 1;
}

swap_player_ar(var_0, var_1) {
  level.player takeweapon(level.player.stairs_weapon);
  var_2 = scripts\sp\utility::make_weapon(var_0, var_1);
  level.player giveweapon(var_2, 0, 0, 0, 1);
  level.player scripts\engine\sp\utility::giveweaponmaxammo(var_2);
  level.player switchtoweapon(var_2);
}

escape_objective() {
  var_0 = scripts\engine\utility::getStruct("tunnel_obj", "targetname");
  scripts\engine\sp\objectives::objective_set_position("estate", var_0.origin);
  scripts\engine\sp\objectives::objective_set_label("estate", &"ESTATE/OBJ_LBL_ESCAPE");
}

escape_intro_catchup() {
  scripts\engine\utility::flag_set("escape_intro");
  scripts\engine\utility::flag_set("escape_begin");
  escape_objective();

  if(!scripts\sp\starts::is_after_start("tunnel"))
    ally_equipment_init();

  scripts\engine\sp\utility::battlechatter_on();

  if(!scripts\sp\starts::is_after_start("escape"))
    thread track_player_indoors();
}

escape_start() {
  scripts\sp\maps\estate\estate_util.gsc::spawn_friendlies();
  thread spawn_escape_heli();
  level.player.stairs_weapon = level.player getweaponslistprimaries()[0];
  thread spawn_escape_weapons();
  scripts\engine\sp\utility::set_start_location("finale", scripts\engine\utility::array_add(level.friendlies, level.player));
  scripts\engine\sp\utility::array_spawn_targetname("escape_start_enemies", 1);
  scripts\engine\utility::flag_set("lighting_escape");
  setsaveddvar("TLMMOPMSK", 1);
}

escape_main() {
  var_0 = getEntArray("trigger_delete_recursive", "targetname");
  scripts\engine\utility::array_thread(var_0, ::trigger_delete_recursive);
  thread disable_exposed_nodes();
  var_1 = getEntArray("escape_trig", "script_noteworthy");
  scripts\engine\utility::array_thread(var_1, ::escape_trig_logic);
  var_2 = getEntArray("escape_color_trig", "script_noteworthy");
  scripts\engine\utility::array_thread(var_2, ::escape_color_trig_think);
  scripts\engine\utility::array_thread(level.friendlies, scripts\engine\sp\utility::set_force_color, "r");
  scripts\engine\utility::array_thread(level.friendlies, scripts\sp\maps\estate\estate_util.gsc::indoor_monitor);
  scripts\engine\utility::array_thread(level.friendlies, ::escape_demeanor_think);
  scripts\engine\utility::array_thread(level.friendlies, scripts\engine\sp\utility::set_battlechatter, 1);
  level.price.speedscalemult = 0.9;
  level.hadir.speedscalemult = 1.1;
  level.price.pushable = 1;
  level.hadir.pushable = 1;
  scripts\engine\utility::array_call(level.friendlies, ::setbackupcoverfrompos, scripts\engine\utility::getStruct("tunnel_obj", "targetname").origin);
  var_3 = getEnt("escape_goal_hint", "targetname");
  var_3 scripts\engine\sp\utility::add_trigger_function(::escape_goal_hint_trigger);
  wait 0.5;
  level.escape_heli scripts\engine\utility::ent_flag_set("ambient_attacking");
  thread heliattackwarning();
  thread unlock_all_doors_except_arena();
  thread montior_chopperkilling_player();
  var_4 = getEntArray("glass_house_heli_shield", "targetname");
  scripts\engine\utility::array_thread(var_4, ::heli_destructible_ceiling_logic);
  var_5 = getscriptablearray("scriptable_rp_propane_tank_long_01", "classname");
  scripts\engine\utility::array_thread(var_5, ::heli_destructible_propane_tank_logic);
  setsaveddvar("MSOOMPMPQS", 1);
  scripts\engine\utility::flag_wait("tunnel_approach");
  setsaveddvar("MSOOMPMPQS", 0);
}

escape_color_trig_think() {
  if(self.classname == "info_volume") {
    return;
  }
  level endon("tunnel_approach");
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);
    var_0.escape_trig = self;

    while(var_0 istouching(self))
      waitframe();

    var_1 = level.player.origin;
    scripts\engine\utility::trigger_off();
    wait 5;

    while(distancesquared(level.player.origin, var_1) < 40000)
      waitframe();

    scripts\engine\utility::trigger_on();
  }
}

escape_demeanor_think() {
  level endon("tunnel_approach");

  for(;;) {
    scripts\engine\utility::ent_flag_wait("indoors");
    scripts\common\utility::demeanor_override("combat");
    scripts\engine\utility::ent_flag_waitopen("indoors");
    scripts\common\utility::demeanor_override("sprint");
  }
}

trigger_delete_recursive() {
  self waittill("trigger");
  recursive_delete_targets();
}

recursive_delete_targets() {
  if(isDefined(self.target)) {
    var_0 = getEntArray(self.target, "targetname");

    foreach(var_2 in var_0) {
      if(isai(var_2)) {
        continue;
      }
      var_2 thread recursive_delete_targets();
    }
  }

  self delete();
}

disable_exposed_nodes() {
  level.exposed_nodes = [];
  var_0 = 1;

  foreach(var_2 in getallnodes()) {
    if(var_0 % 10 == 0)
      waitframe();

    var_0++;

    if(var_2.type != "Exposed") {
      continue;
    }
    var_3 = 1;

    foreach(var_5 in level.interior_volumes) {
      if(ispointinvolume(var_2.origin, var_5)) {
        var_3 = 0;
        break;
      }
    }

    if(!var_3) {
      continue;
    }
    var_2 disconnectnode();
    level.exposed_nodes[level.exposed_nodes.size] = var_2;
  }

  scripts\engine\utility::flag_wait("tunnel_approach");

  foreach(var_2 in level.exposed_nodes)
  var_2 connectnode();

  level.exposed_nodes = undefined;
}

unlock_all_doors_except_arena() {
  scripts\engine\utility::flag_wait("interactive_doors_ready");

  foreach(var_1 in level.interactive_doors.ents) {
    if(scripts\engine\utility::is_equal(var_1.targetname, "launcher_shed_door") || scripts\engine\utility::is_equal(var_1.targetname, "heli_house_front")) {
      continue;
    }
    if(var_1.locked)
      var_1 scripts\sp\door::unlock_door(1);
  }
}

track_player_indoors() {
  level.player endon("death");
  level endon("tunnel_approach");
  var_0 = 1;
  childthread vo_escape_outdoors();
  childthread vo_escape_indoors();

  for(;;) {
    level.player scripts\engine\utility::ent_flag_wait("indoors");

    if(!var_0)
      thread vo_heli_sees_player(0);

    if(!scripts\engine\utility::flag("tunnel_approach"))
      thread scripts\sp\maps\estate\estate_util.gsc::try_indoor_save();

    level.player scripts\engine\utility::ent_flag_waitopen("indoors");
    level.player.outdoor_time = gettime();

    if(var_0) {
      var_0 = 0;
      level.escape_heli.pilot thread scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_ru2_heli_callout_30");
      continue;
    }

    thread vo_heli_sees_player(1);
  }
}

vo_escape_outdoors() {
  scripts\sp\maps\estate\estate_util.gsc::make_alias_group("heli_cover", ["dx_vom_pri_heli_cover_10", "dx_vom_pri_heli_cover_20", "dx_vom_pri_heli_cover_30", "dx_vom_pri_heli_cover_40", "dx_vom_pri_heli_cover_50"]);

  for(;;) {
    level.player scripts\engine\utility::ent_flag_waitopen("indoors");
    wait 3;

    if(level.player scripts\engine\utility::ent_flag("indoors")) {
      continue;
    }
    while(!level.player scripts\engine\utility::ent_flag("indoors")) {
      if(istrue(level.price.speaking)) {
        wait 2;
        continue;
      }

      scripts\sp\maps\estate\estate_util.gsc::price_line(scripts\sp\maps\estate\estate_util.gsc::get_next_alias_in_group("heli_cover"));
      wait 10;
    }
  }
}

vo_escape_indoors() {
  scripts\sp\maps\estate\estate_util.gsc::make_alias_group("escape_move", ["dx_vom_pri_tunnel_push_60", "dx_vom_pri_tunnel_push_70"]);
  scripts\sp\maps\estate\estate_util.gsc::make_alias_group("escape_move_ahead", ["dx_vom_pri_tunnel_push_10", "dx_vom_pri_tunnel_push_20", "dx_vom_pri_tunnel_push_30"]);
  var_0 = scripts\engine\utility::getStruct("tunnel_obj", "targetname").origin;
  var_1 = 1;

  for(;;) {
    level.player scripts\engine\utility::ent_flag_wait("indoors");
    var_2 = 0;
    var_3 = undefined;

    for(;;) {
      waitframe();

      if(!level.player scripts\engine\utility::ent_flag("indoors")) {
        break;
      }

      var_4 = getaiarray("axis");

      if(var_4.size) {
        var_5 = 1;

        foreach(var_7 in level.interior_volumes) {
          if(level.player istouching(var_7)) {
            foreach(var_9 in var_4) {
              if(var_9 istouching(var_7)) {
                var_5 = 0;
                break;
              }
            }

            break;
          }
        }

        if(!var_5) {
          var_2 = gettime();
          continue;
        }
      }

      if(!scripts\engine\utility::is_equal(var_3, level.player.escape_trig)) {
        var_2 = gettime();
        var_3 = level.player.escape_trig;
        continue;
      }

      if(scripts\engine\utility::time_has_passed(var_2, 10)) {
        var_12 = distance(level.player.origin, var_0);
        var_13 = undefined;

        if(var_12 - distance(level.price.origin, var_0) > 128 && var_12 - distance(level.hadir.origin, var_0) > 128) {
          if(var_1) {
            scripts\sp\maps\estate\estate_util.gsc::hadir_line("dx_vom_had_tunnel_push_40");
            var_13 = "dx_vom_pri_tunnel_push_50";
            var_1 = 0;
          } else
            var_13 = scripts\sp\maps\estate\estate_util.gsc::get_next_alias_in_group("escape_move_ahead");
        } else
          var_13 = scripts\sp\maps\estate\estate_util.gsc::get_next_alias_in_group("escape_move");

        scripts\sp\maps\estate\estate_util.gsc::price_line(var_13);
        var_2 = gettime();
      }
    }
  }
}

escape_goal_hint_trigger(var_0) {
  level endon("tunnel_approach");

  for(;;) {
    if(var_0 istouching(self))
      level.player thread scripts\sp\player::focus_display_hint(0, 7);

    wait 15;
  }
}

vo_heli_sees_player(var_0) {
  level.player endon("indoors");
  wait 2;

  if(var_0)
    var_1 = scripts\engine\utility::random(["dx_vom_ru2_heli_callout_10", "dx_vom_ru2_heli_callout_20", "dx_vom_ru2_heli_callout_40"]);
  else
    var_1 = scripts\engine\utility::random(["dx_vom_ru2_heli_callout_60", "dx_vom_ru2_heli_callout_70", "dx_vom_ru2_heli_callout_80"]);

  level.escape_heli.pilot scripts\engine\sp\utility::smart_dialogue_generic(var_1);
}

montior_chopperkilling_player() {
  level endon("tunnel_approach");
  level.player waittill("death", var_0, var_1, var_2, var_3, var_4);
  var_5 = 0;

  if(scripts\engine\utility::is_equal(var_0, level.escape_heli.minigun) || scripts\engine\utility::is_equal(var_4, level.escape_heli.minigun))
    var_5 = 1;

  if(isDefined(var_0) && scripts\engine\utility::is_equal(var_0.classname, "worldspawn"))
    var_5 = 1;

  if(var_5)
    scripts\sp\player_death::set_custom_death_quote(56);
}

smoke_lasers() {
  scripts\engine\utility::exploder("mansionsmokegren");
}

spawn_escape_weapons() {
  var_0 = undefined;

  foreach(var_2 in scripts\engine\utility::getStructArray("escape_weapon", "targetname")) {
    if(scripts\engine\utility::is_equal(var_2.script_noteworthy, "player"))
      var_0 = "weapon_" + createheadicon(level.player.stairs_weapon);
    else
      var_0 = "weapon_iw8_ar_akilo47+back_akilo47+front_akilo47+laserir_bar+mag_akilo47+rec_akilo47";

    var_3 = spawn(var_0, var_2.origin, 1);
    var_3.angles = var_2.angles;
  }
}

display_enemy_count() {
  var_0 = (1, 1, 0);
  var_1 = (0, 1, 0);
  var_2 = (1, 0, 0);

  for(;;) {
    var_3 = getaiarray("axis").size;

    if(var_3 < 5)
      var_4 = var_1;
    else if(var_3 < 15)
      var_4 = var_0;
    else
      var_4 = var_2;

    wait 0.05;
  }
}

escape_scene_fadein() {
  level.player lerpviewangleclamp(0, 0, 0, 0, 0, 0, 0);
  setblur(0, 1);
  level.player_overlay fadeovertime(1);
  level.player_overlay.alpha = 0;
  level.player scripts\engine\utility::delaycall(5, ::lerpviewangleclamp, 2, 0.5, 0.5, 45, 20, 45, 20);
  level.player shellshock("explosion_estate", 6);
  level.player scripts\engine\utility::delaycall(5, ::fadeoutshellshock);
  level.player scripts\engine\utility::delaycall(28, ::lerpviewangleclamp, 0.5, 0.2, 0.2, 0, 0, 0, 0);
  level.price scripts\engine\utility::delaycall(28.15, ::playrumbleonentity, "light_1s");
}

escape_catchup() {
  scripts\engine\utility::flag_set("tunnel_approach");
  thread display_enemy_count();
  thread unlock_all_doors_except_arena();
  var_0 = getEntArray("trigger_delete_recursive", "targetname");
  scripts\engine\utility::array_thread(var_0, ::recursive_delete_targets);
}

tunnel_start() {
  spawn_escape_heli();
  scripts\engine\utility::delaythread(0.1, ::place_heli_over_player);
  scripts\sp\maps\estate\estate_util.gsc::spawn_friendlies();
  scripts\engine\sp\utility::set_start_location("tunnel_start", scripts\engine\utility::array_add(level.friendlies, level.player));
  scripts\engine\utility::array_thread(level.friendlies, scripts\engine\sp\utility::set_force_color, "r");
  level.price.speedscalemult = 1;
  level.hadir.speedscalemult = 1.1;
  scripts\engine\utility::flag_set("lighting_escape");
  setsaveddvar("TLMMOPMSK", 1);
}

tunnel_main() {
  thread save_after_rockets();
  level.tunnel_struct = scripts\engine\utility::getStruct("tunnel_obj", "targetname");
  thread vo_tunnel_callout();
  thread player_approach_tunnel();
  level waittill("player_approaching_tunnel");
  thread scripts\engine\sp\utility::ai_delete_when_out_of_sight(getaiarray("axis"), 500);
  var_0 = getEntArray("trigger_delete_recursive", "targetname");
  scripts\engine\utility::array_thread(var_0, ::recursive_delete_targets);
  level.price.pushable = 0;
  level.hadir.pushable = 0;
  scripts\engine\utility::array_thread(level.friendlies, scripts\engine\sp\utility::clear_force_color);
  scripts\engine\utility::array_thread(level.friendlies, scripts\common\utility::demeanor_override, "sprint");
  scripts\engine\utility::array_thread(level.friendlies, scripts\engine\sp\utility::set_ignoreall, 1);
  scripts\engine\utility::array_thread(level.friendlies, scripts\engine\sp\utility::set_battlechatter, 0);
  scripts\engine\utility::array_thread(level.friendlies, scripts\engine\utility::send_notify, "remove_equipment");
  scripts\engine\utility::array_call(level.friendlies, ::pushplayer, 1);
  level.tunnel_animnode = scripts\engine\utility::getStruct("tunnel_animnode", "targetname");
  thread hadir_tunnel_think();
  thread price_tunnel_think();
  thread dont_let_player_die_in_tunnel();
  thread tunnel_collapse_think();
  tunnel_scene();
  level.cutters delete();
}

vo_tunnel_callout() {
  level endon("hadir_sees_tunnel");
  level endon("start_tunnel_open");
  var_0 = spawnStruct();
  var_0.origin = (4629, 1799, 20);
  var_0 scripts\engine\sp\utility::waittill_player_lookat(0.77, 1);
  scripts\sp\maps\estate\estate_util.gsc::kyle_line("dx_vom_kyle_tunnel_spotted_10");
}

player_approach_tunnel() {
  level.player endon("death");
  level.player scripts\engine\sp\utility::waittill_in_range(level.tunnel_struct.origin, level.tunnel_struct.radius);
  level.player scripts\engine\utility::ent_flag_waitopen("indoors");
  level notify("player_approaching_tunnel");
}

save_after_rockets() {
  level endon("player_reached_drain_tunnel");

  while(istrue(level.escape_heli.trying_rockets))
    waitframe();

  scripts\engine\sp\utility::autosave_by_name("drain_tunnel");
}

tunnel_scene() {
  scripts\engine\utility::flag_wait_all("hadir_at_tunnel", "price_at_tunnel");
  scripts\engine\sp\utility::autosave_by_name("tunnel");
  level.tunnel_animnode notify("stop_loop");
  level.hadir scripts\engine\sp\utility::anim_stopanimScripted();
  var_0 = getEnt("tunnel_gate", "targetname");
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_1 scripts\engine\sp\utility::assign_animtree("tunnel_gate");
  var_0 linkTo(var_1);
  level.cutters unlink();
  level notify("start_tunnel_open");
  setmusicstate("mx_estate_tunnel_escape");
  var_2 = getEnt("tunnel_chain", "targetname");
  level.tunnel_animnode scripts\common\anim::anim_single(scripts\engine\utility::array_combine(level.friendlies, [level.cutters, var_1, var_2]), "tunnel_open");
  level.tunnel_animnode thread scripts\common\anim::anim_loop_solo_with_nags(level.price, "tunnel_open_idle");
  scripts\engine\utility::flag_wait("player_in_tunnel");
  level waittill("tunnel_collapse");
  level.player playSound("scn_estate_tunnel_collapse_lr");
  level.player setclienttriggeraudiozone("zr_estate_tunnel_end_scene_shock", 0.5);
  level.tunnel_animnode notify("stop_loop");
  scripts\engine\utility::array_thread(level.friendlies, scripts\engine\sp\utility::anim_stopanimscripted);
  level.tunnel_animnode thread scripts\common\anim::anim_single(level.friendlies, "tunnel_collapse");
  scripts\sp\player_rig::link_player_to_rig(undefined, "stand", 0, 0, 1);
  level.tunnel_animnode scripts\sp\player_rig::anim_lerp_from_player_pos("tunnel_collapse", undefined, 0.5);
  scripts\engine\utility::flag_set("lighting_tunnel");
}

hadir_tunnel_think() {
  thread vo_hadir_tunnel();
  level.hadir thread try_tunnel_teleport();
  level.hadir.disableplayeradsloscheck = 1;
  level.tunnel_animnode scripts\sp\anim::anim_reach_solo(level.hadir, "tunnel_approach");
  level.hadir.disableplayeradsloscheck = 0;
  level.tunnel_animnode scripts\common\anim::anim_single_solo(level.hadir, "tunnel_approach");
  level.tunnel_animnode thread scripts\common\anim::anim_loop_solo(level.hadir, "tunnel_approach_idle");
  scripts\engine\utility::flag_set("hadir_at_tunnel");
  level endon("tunnel_collapse");
  scripts\engine\utility::flag_wait("tunnel_open");
  level.hadir waittillmatch("single anim", "end");
  level.tunnel_animnode scripts\common\anim::anim_single_solo(level.hadir, "tunnel_enter");
  level.tunnel_animnode thread scripts\common\anim::anim_loop_solo(level.hadir, "tunnel_enter_idle");
}

vo_hadir_tunnel() {
  var_0 = getstartorigin(level.tunnel_animnode.origin, level.tunnel_animnode.angles, level.hadir scripts\engine\utility::getanim("tunnel_approach"));
  level.hadir scripts\engine\sp\utility::waittill_in_range(var_0, 128);
  var_1 = distance(level.hadir.origin, level.tunnel_struct.origin);
  var_2 = distance(level.player.origin, level.tunnel_struct.origin);

  if(var_2 - var_1 > 128) {
    level notify("hadir_sees_tunnel");
    scripts\sp\maps\estate\estate_util.gsc::hadir_line("dx_vom_had_tunnel_spotted_50");
  }
}

price_tunnel_think() {
  level.price thread try_tunnel_teleport(1);
  var_0 = getnode("price_tunnel_node", "targetname");
  level.price.goalradius = 16;
  level.price.fixednode = 1;
  level.price setgoalnode(var_0);
  scripts\engine\utility::flag_wait("hadir_at_tunnel");
  level.price.dontavoidplayer = 1;
  level.price.disableplayeradsloscheck = 1;
  level.tunnel_animnode scripts\sp\anim::anim_reach_solo(level.price, "tunnel_open");
  level.price.disableplayeradsloscheck = 0;
  scripts\engine\utility::flag_set("price_at_tunnel");
  level endon("tunnel_collapse");
  scripts\engine\utility::flag_wait("tunnel_open");

  if(scripts\engine\utility::flag("player_reached_drain_tunnel"))
    scripts\engine\utility::flag_wait("player_in_tunnel");
  else
    thread vo_tunnel_nags();

  level.tunnel_animnode notify("stop_loop");
  level.price scripts\engine\sp\utility::anim_stopanimScripted();
  level.tunnel_animnode scripts\common\anim::anim_single_solo(level.price, "tunnel_enter");
  level.tunnel_animnode thread scripts\common\anim::anim_loop_solo_with_nags(level.price, "tunnel_enter_idle");
}

try_tunnel_teleport(var_0) {
  level.player scripts\engine\sp\utility::waittill_in_range(level.tunnel_struct.origin, 800);

  if(isDefined(var_0))
    wait(var_0);

  var_1 = distancesquared(self.origin, level.tunnel_struct.origin);

  if(var_1 > distancesquared(level.player.origin, level.tunnel_struct.origin)) {
    if(!scripts\engine\math::within_fov_2d(level.player.origin, level.player.angles, self.origin, 0)) {
      var_2 = scripts\engine\utility::getStructArray("tunnel_teleport_struct", "targetname");
      var_2 = sortbydistance(var_2, level.player.origin);
      var_3 = undefined;

      foreach(var_5 in var_2) {
        if(scripts\engine\math::within_fov_2d(level.player.origin, level.player.angles, var_5.origin, 0)) {
          continue;
        }
        if(var_1 <= distancesquared(var_5.origin, level.tunnel_struct.origin)) {
          continue;
        }
        var_3 = var_5;
        break;
      }

      if(isDefined(var_3)) {
        self asmsetstate(self.asmname, "exposed_idle");
        self forceteleport(var_3.origin, var_3.angles, 99999);
      }
    }
  }
}

vo_tunnel_nags() {
  level endon("tunnel_collapse");
  scripts\sp\maps\estate\estate_util.gsc::make_alias_group("tunnel_nags", ["dx_vom_pri_tunnel_spotted_80", "dx_vom_pri_tunnel_spotted_90", "dx_vom_pri_tunnel_spotted_100"]);

  for(;;) {
    level waittill("price_nag");

    if(!scripts\engine\utility::flag("player_reached_drain_tunnel") && !scripts\engine\utility::flag("player_in_tunnel"))
      scripts\sp\maps\estate\estate_util.gsc::price_line(scripts\sp\maps\estate\estate_util.gsc::get_next_alias_in_group("tunnel_nags"));
  }
}

dont_let_player_die_in_tunnel() {
  level endon("tunnel_collapse");
  scripts\engine\utility::flag_wait("tunnel_open");

  for(;;) {
    scripts\engine\utility::flag_wait("player_in_tunnel");
    level.player scripts\common\utility::allow_death(0, "tunnel_escape");
    scripts\engine\utility::flag_waitopen("player_in_tunnel");
    level.player scripts\common\utility::allow_death(1, "tunnel_escape");
  }
}

tunnel_collapse_think() {
  level waittill("tunnel_collapse");
  scripts\sp\maps\estate\estate_util.gsc::show_ents("tunnel_destruction");
  var_0 = scripts\engine\utility::getStruct("tunnel_collapse_missile_target", "targetname");
  earthquake(1, 2, var_0.origin, 1500);
}

tunnel_catchup() {
  scripts\sp\maps\estate\estate_util.gsc::show_ents("tunnel_destruction");
}

arrest_start() {
  scripts\sp\maps\estate\estate_util.gsc::spawn_friendlies();
  scripts\engine\sp\utility::set_start_location("arrest_start", scripts\engine\utility::array_add(level.friendlies, level.player));
  level.tunnel_animnode = scripts\engine\utility::getStruct("tunnel_animnode", "targetname");
  scripts\engine\utility::flag_set("lighting_tunnel");
}

arrest_main() {
  if(isDefined(level.escape_heli)) {
    level.escape_heli notify("new_heli_positions");
    level.escape_heli delete();
  }

  thread scripts\sp\analytics::analytics_kleenex_update("3rd floor to escape");
  setmusicstate("mx_estate_tunnel_capture");
  thread scripts\sp\hud_util::fade_out(0, "black");
  setomnvar("ui_hide_hud", 1);
  setomnvar("ui_hide_weapon_info", 1);
  level.player scripts\engine\sp\utility::allow_nvg(0, undefined, 1);
  level.player enableinvulnerability();
  level.player freezecontrols(1);
  getEnt("tunnel_gate", "targetname") delete();
  scripts\sp\utility::delete_live_grenades();
  thread skip_outro();
  wait 2;
  scripts\engine\utility::delaythread(1.4, scripts\engine\sp\objectives::objective_set_description, "estate", &"ESTATE/OBJ_DESC_HADIR");
  var_0 = 1;
  arrest_scene(var_0);
  scripts\engine\sp\objectives::objective_complete("estate");
  end_level(var_0);
  level waittill("never");
}

arrest_scene(var_0) {
  var_1 = level.tunnel_animnode scripts\sp\player_rig::link_player_to_rig("arrest_hadir", "stand", 0, undefined, 0, 10, 10, 5, 5, 1);
  level.price.name = "";
  level.hadir.name = "";
  level.hadir scripts\common\ai::gun_remove();
  var_2 = getanimlength(var_1 scripts\engine\utility::getanim("arrest_hadir"));
  level.player lerpfovscalefactor(0, 0.05);
  level.player fadeoutshellshock();
  level.player scripts\engine\utility::delaycall(3, ::stopshellshock);
  level.player clearclienttriggeraudiozone(6.0);
  scripts\engine\utility::delaythread(0.4, scripts\sp\hud_util::fade_in, 1, "black");
  scripts\engine\utility::delaythread(var_2 - 21.5, ::outro_letterbox);
  level.hadir scripts\engine\utility::delaycall(8.85, ::playrumbleonentity, "light_1s");
  thread cine_dof();
  level.tunnel_animnode thread scripts\common\anim::anim_single(scripts\engine\utility::array_add(level.friendlies, var_1), "arrest_hadir");
  wait(var_2 - var_0);
}

outro_letterbox() {
  level.player modifybasefov(52, 4);
  level.player lerpviewangleclamp(0.75, 0, 0, 0, 0, 0, 0);
  hidecinematicletterboxing(2, 0);
  level.player scripts\common\utility::allow_cinematic_motion(0);
}

cine_dof() {
  level.price scripts\engine\sp\utility::dof_enable_autofocus(2.8, 30, undefined, undefined, "tag_eye");
  wait 7;
  level.hadir scripts\engine\sp\utility::dof_enable_autofocus(2.8, 30, undefined, undefined, "tag_eye");
  wait 7;
  level.price scripts\engine\sp\utility::dof_enable_autofocus(2.8, 6, undefined, undefined, "tag_eye");
  wait 5;
  level.hadir scripts\engine\sp\utility::dof_enable_autofocus(4, 2, undefined, undefined, "tag_eye");
  wait 2;
  level.price scripts\engine\sp\utility::dof_enable_autofocus(2.8, 8, undefined, undefined, "tag_eye");
  wait 5.5;
  level.hadir scripts\engine\sp\utility::dof_enable_autofocus(2.8, 3, undefined, undefined, "tag_eye");
  wait 4.5;
  scripts\engine\sp\utility::dof_disable();
}

skip_outro() {
  var_0 = scripts\sp\utility::userskip_wait();

  if(!var_0) {
    return;
  }
  end_level(0);
}

end_level(var_0) {
  level.player setclienttriggeraudiozone("fade_to_black", var_0 + 1);
  thread scripts\sp\hud_util::fade_out(var_0, "black");
  levelsoundfade(0, var_0);

  if(var_0 > 0)
    wait(var_0 + 3);

  scripts\engine\sp\utility::nextmission();
}

spets_spawn_func() {
  self endon("death");
  self.noloot = 1;

  if(!issubstr(self.classname, "shotgun"))
    thread scripts\sp\maps\estate\estate_util.gsc::laser_discipline();

  spets_nvgs_on();

  if(isDefined(self.target))
    self waittill("goal");

  if(istrue(self.fixednode)) {
    return;
  }
  var_0 = level.interior_volumes[self.script_parameters];

  for(;;) {
    self.goalradius = self.engagemaxfalloffdist;

    while(level.player istouching(var_0)) {
      self setgoalpos(level.player.origin);
      wait 5;
    }

    self setgoalvolumeauto(var_0);

    while(!level.player istouching(var_0))
      waitframe();
  }
}

spets_nvgs_on() {
  scripts\sp\maps\estate\estate_util.gsc::gesture_nvgs(1);
}

player_is_ahead_of_me(var_0) {
  var_1 = distance2d(self.origin, var_0);
  var_2 = distance2d(level.player.origin, var_0);
  return var_2 < var_1;
}

stagger_ai_to_pos(var_0, var_1) {
  level notify("stagger_ai_to_pos");
  level endon("stagger_ai_to_pos");

  foreach(var_3 in var_0) {
    if(isalive(var_3)) {
      var_3 thread send_to_goal_open_goalRadius(var_1);
      wait 1;
    }
  }
}

send_to_goal_open_goalRadius(var_0) {
  self endon("death");
  self notify("new_merc_pos");
  self endon("new_merc_pos");
  waitframe();
  self cleargoalvolume();
  self.goalradius = randomintrange(700, 900);
  var_1 = getclosestpointonnavmesh(var_0);
  self setgoalpos(var_1);
  self waittill("goal");
  self.goalradius = 1000;
}

spawn_escape_heli() {
  scripts\common\vehicle::spawn_vehicle_from_targetname("enemy_heli");
}

escape_heli_spawn_func() {
  scripts\engine\utility::ent_flag_init("ambient_attacking");
  heli_spotlight_create();
  heli_mg_create();
  self setneargoalnotifydist(400);
  self sethoverparams(25, 15, 10);
  var_0 = 1000 + self.mg_z_offset;
  var_1 = 2000;
  var_2 = anglesToForward(level.player getplayerangles());
  var_3 = var_2 * var_1;
  var_4 = level.player.origin + var_3;
  var_5 = (var_4[0], var_4[1], var_4[2] + var_0);
  self.move_override = 0;
  self.is_shooting = 0;
  self.noshooting = 0;
  self.shoot_override = 0;
  level.player.target_ent = spawn("script_origin", var_5);
  level.player.target_ent linkTo(level.player);
  self.godmode = 1;
  self.curr_projectile_hits = 0;
  self.animname = "hind";
  self.script_team = "axis";
  self setvehicleteam("axis");
  var_6 = ["tag_missile_l_1", "tag_missile_l_2", "tag_missile_l_3", "tag_missile_l_4"];
  var_7 = ["tag_missile_r_1", "tag_missile_r_2", "tag_missile_r_3", "tag_missile_r_4"];
  self.missile_laser_tags["left"] = [];
  self.missile_laser_tags["right"] = [];

  foreach(var_9 in var_6) {
    var_10 = spawn("script_model", self gettagorigin(var_9));
    var_10.angles = self gettagangles(var_9);
    var_10 linkTo(self);
    var_10 setModel("tag_laser");
    var_10 setmoverlaserweapon("iw8_mindia8_turret");
    self.missile_laser_tags["left"][var_9] = var_10;
  }

  foreach(var_9 in var_7) {
    var_10 = spawn("script_model", self gettagorigin(var_9));
    var_10.angles = self gettagangles(var_9);
    var_10 linkTo(self);
    var_10 setModel("tag_laser");
    var_10 setmoverlaserweapon("iw8_mindia8_turret");
    self.missile_laser_tags["right"][var_9] = var_10;
  }

  level.escape_heli = self;

  if(isDefined(self.riders) && istrue(self.riders.size)) {
    self.pilot = self.riders[0];
    self.pilot thread scripts\common\ai::magic_bullet_shield();
    self.pilot.team = "team3";
    self.pilot.ignoreall = 1;
    self.pilot.ignoreme = 1;
  }

  playFXOnTag(scripts\engine\utility::getfx("vfx_estate_heli_dash_light"), self, "tag_pilot1");
  self setyawspeedbyname("faster");
  self.last_rocket_time = gettime();
  thread heli_damage_death();
  thread heli_logic();
  level.used_destructible_targets = [];
}

heli_logic() {
  switch (level.start_point) {
    case "gate":
    case "heli_attack":
    case "obj_room":
    case "goto_obj":
    case "find_hvt_3":
    case "find_hvt_2":
    case "find_hvt_1":
    case "rappel":
    case "fusebox_tut":
    case "tall_grass":
    case "intro":
    case "woods":
    case "light":
      heli_event_obj_room();
    case "hallway_run":
      heli_event_hallway_run();
    case "stairs_explosion":
      heli_event_stairs_explosion();
    case "escape_intro":
    case "escape":
      heli_event_escape();
    case "tunnel":
      heli_event_tunnel();
    case "arrest":
      break;
    default:
      iprintlnbold("HELI LOGIC NOT RUNNING CORRECTLY FOR START POINT " + level.start_point);
      break;
  }
}

heli_event_obj_room() {
  level.escape_heli scalevolume(0, 0);
  waittillframeend;
  level.escape_heli scalevolume(1, 5);
  var_0 = scripts\engine\utility::getStruct("front_light_start", "targetname");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  level.escape_heli.spotlight.target_ent.origin = var_0.origin;
  level.escape_heli.spotlight snaptotargetentity(level.escape_heli.spotlight.target_ent);
  var_2 = scripts\engine\utility::getStruct("heli_at_window", "targetname");
  level.escape_heli thread nav_gotopos(var_2.origin, 90);

  while(!scripts\engine\utility::within_fov(level.escape_heli.origin, level.escape_heli.angles, level.player.origin, 0.5))
    waitframe();

  setsaveddvar("TLMMOPMSK", 1);
  level.escape_heli heli_spotlight_toggle(1);
  level.escape_heli waittill("nav_goal");
  level.escape_heli settargetyaw(var_2.angles[1]);
  level.escape_heli.minigun startbarrelspin();
  wait 2;
  level.escape_heli thread heli_spotlight_sweep([var_0, var_1], 2.5);
  wait 0.1;
  level.escape_heli heli_shoot_obj_room();
  level.escape_heli heli_spotlight_toggle(0);
  scripts\engine\utility::flag_set("window_spotlight_sweep_done");
  var_2 = scripts\engine\utility::getStruct("heli_over_house", "targetname");
  level.escape_heli nav_gotopos(var_2.origin);
  scripts\engine\utility::flag_wait("obj_room_vo_complete");
}

heli_shoot_obj_room() {
  var_0 = scripts\engine\utility::getStruct("front_light_start", "targetname");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_2 = scripts\engine\utility::spawn_script_origin(var_0.origin, (0, 0, 0));
  self.minigun.target_ent.origin = var_0.origin;
  self.minigun snaptotargetentity(self.minigun.target_ent, (0, 0, 0));
  self.minigun settargetentity(self.minigun.target_ent);
  self.minigun.target_ent playLoopSound("scn_escape_minigun_impact_bullets_interior_lp");
  self.minigun.target_ent playLoopSound("scn_escape_minigun_impact_debris_interior_lp");
  var_3 = distance(var_0.origin, var_1.origin);
  var_4 = scripts\engine\sp\utility::mph_travel_time(2.5, var_3);
  level scripts\engine\utility::delaythread(var_4 - 2, scripts\engine\utility::send_notify, "end_cover_loop");
  var_2 moveTo(var_1.origin, var_4);
  var_5 = gettime() + var_4 * 1000;
  scripts\engine\utility::exploder("room_scriptables");
  scripts\engine\utility::exploder("vfxexp_room_smoke");
  scripts\engine\utility::flag_set("lighting_fire_obj_room");
  scripts\engine\utility::flag_set("lighting_fire_hallways");
  thread heli_attack_fire_progression();
  level notify("heli_obj_room_start_shooting");

  while(gettime() < var_5) {
    self.minigun.target_ent.origin = var_2.origin + (0, 0, randomfloatrange(0, 20));
    self.minigun shootturret();
    wait 0.05;
  }

  thread scripts\engine\utility::play_sound_in_space("scn_escape_minigun_impact_debris_interior_tail", self.minigun.target_ent.origin);
  self.minigun.target_ent stoploopsound("scn_escape_minigun_impact_bullets_interior_lp");
  self.minigun.target_ent stoploopsound("scn_escape_minigun_impact_debris_interior_lp");
  var_2 delete();
  self.minigun cleartargetentity(self.minigun.target_ent);
  self.noshooting = 0;
  self.minigun stopbarrelspin();
}

obj_room_attack_cowbell(var_0) {
  wait 0.1;
  var_1 = [level._effect["vfx_book_stack_expl"], level._effect["vfx_book_shelf_expl_new_single"]];
  level endon("stop_obj_room_attack");
  level thread scripts\engine\sp\utility::notify_delay("stop_obj_room_attack", var_0);

  for(;;) {
    var_2 = vectortoangles(self.minigun.target_ent.origin - level.player.origin);
    var_3 = level.player.origin + anglesToForward(var_2) * randomintrange(40, 100);
    playworldsound("bullet_explode", var_3);

    foreach(var_5 in var_1) {
      playFX(var_5, var_3 + scripts\engine\utility::randomvector(20));
      wait 0.05;
    }

    wait(randomfloatrange(0.15, 0.25));
  }
}

ambient_explosion() {
  var_0 = randomintrange(1500, 2300);
  var_1 = randomintrange(0, 1000);
  thread scripts\engine\utility::play_sound_in_space("breach_c4_expl_trans", level.player.origin + (var_0, var_1, 70));
  earthquake(0.7, 1, level.player.origin, 500);
  level.player playRumbleOnEntity("heavy_1s");
}

heli_event_hallway_run() {
  var_0 = scripts\engine\utility::getStruct("heli_at_side_window", "targetname");
  level.escape_heli nav_gotopos(var_0.origin);
  level.escape_heli settargetyaw(var_0.angles[1]);
  scripts\engine\utility::flag_wait("player_in_spetsnaz_hallway");
  setmusicstate("mx_tmp_estate_hallwayrun");

  if(isDefined(level.player_rig))
    level.player_rig waittillmatch("single anim", "end");

  var_0 = scripts\engine\utility::getStruct("side_light_start", "targetname");
  level.escape_heli.spotlight.target_ent.origin = var_0.origin;
  level.escape_heli heli_spotlight_toggle(1);
  thread heli_shoots_hallway();
  scripts\engine\utility::flag_wait("stairs_go");

  if(level.escape_heli.minigun.target_ent islinked())
    level.escape_heli.minigun.target_ent unlink();

  level.escape_heli notify("hallway_shooting_done");
  level.escape_heli heli_spotlight_toggle(0);
  level.escape_heli stopshooting();
  thread scripts\engine\utility::play_sound_in_space("scn_escape_minigun_impact_debris_interior_tail", self.minigun.target_ent.origin);
  self.minigun.target_ent stoploopsound("scn_escape_minigun_impact_bullets_interior_lp");
  self.minigun.target_ent stoploopsound("scn_escape_minigun_impact_debris_interior_lp");
}

heli_shoots_hallway() {
  level endon("stairs_go");
  level.escape_heli.spotlight.target_ent.origin = scripts\engine\utility::getStruct("hallway_spotlight", "targetname").origin;
  level.escape_heli.minigun startbarrelspin();
  var_0 = scripts\engine\utility::getStruct("hallway_mg_shoot_start", "targetname");
  level.escape_heli.minigun.target_ent.origin = var_0.origin;
  level.escape_heli.minigun snaptotargetentity(level.escape_heli.minigun.target_ent, (0, 0, 0));
  wait 1;
  self.minigun.target_ent playLoopSound("scn_escape_minigun_impact_bullets_interior_lp");
  self.minigun.target_ent playLoopSound("scn_escape_minigun_impact_debris_interior_lp");
  scripts\engine\utility::delaythread(1.5, scripts\sp\maps\estate\estate_util.gsc::show_ents, "corridorshootblocker");
  scripts\engine\utility::exploder("hallway_scriptables");
  scripts\engine\utility::exploder("hallway_fakeimpacts");
  childthread heli_murder_player_in_hallway();
  var_1 = 1;

  for(;;) {
    if(!scripts\engine\utility::flag("player_in_heli_death_zone"))
      level.escape_heli thread heli_hallway_mover(var_0, scripts\engine\utility::ter_op(var_1, 10, 20), scripts\engine\utility::ter_op(var_1, 5, 2.5));

    level.escape_heli thread heli_minigun_shoot_til_notify("hallway_shooting_done", 1);
    level.escape_heli waittill("hallway_mover_done");
    level.escape_heli notify("hallway_shooting_done");
    wait 1;

    if(var_1) {
      var_0 = scripts\engine\utility::getStruct("hallway_mg_shoot_spline", "targetname");
      var_1 = 0;
    }
  }
}

heli_murder_player_in_hallway() {
  for(;;) {
    scripts\engine\utility::flag_wait("player_in_heli_death_zone");
    level.escape_heli.minigun.target_ent linkTo(level.player, "tag_origin", (0, 0, 30), (0, 0, 0));
    scripts\engine\utility::flag_waitopen("player_in_heli_death_zone");
    level.escape_heli.minigun.target_ent unlink();
    level notify("hallway_mover_done");
  }
}

heli_hallway_mover(var_0, var_1, var_2) {
  level endon("player_in_heli_death_zone");
  var_3 = scripts\engine\utility::spawn_script_origin(var_0.origin, (0, 0, 0));
  self.minigun.target_ent.origin = var_0.origin;
  self.minigun snaptotargetentity(self.minigun.target_ent, (0, 0, 0));

  while(!scripts\engine\utility::flag("stairs_go") && isDefined(var_0.target)) {
    var_4 = scripts\engine\utility::getStruct(var_0.target, "targetname");
    var_5 = distance(var_0.origin, var_4.origin);
    var_6 = scripts\engine\sp\utility::mph_travel_time(var_2, var_5);
    var_3 moveTo(var_4.origin, var_6);
    var_7 = gettime() + var_6 * 1000;
    var_8 = (0, 0, 0);

    while(gettime() < var_7) {
      var_8 = (0, 0, randomfloatrange(0, var_1));
      self.minigun.target_ent.origin = var_3.origin + var_8;
      waitframe();
    }

    var_0 = var_4;
  }

  var_3 delete();
  self notify("hallway_mover_done");
}

heli_minigun_shoot_til_notify(var_0, var_1) {
  self endon(var_0);

  while(isalive(level.player)) {
    if(istrue(var_1) && isDefined(self.minigun.target_ent))
      magicbullet("iw8_mindia8_turret", self.minigun gettagorigin("tag_flash"), self.minigun.target_ent.origin);
    else
      self.minigun shootturret();

    wait 0.05;
  }

  stopshooting();
}

heli_event_stairs_explosion() {
  scripts\engine\utility::flag_wait("explosion_scene_done");
}

heli_event_escape() {
  level.escape_heli.minigun settargetentity(self.minigun.target_ent);
  thread heli_movement_escape();
  childthread heli_spotlight_escape();
  childthread escape_player_attack_think();
  scripts\engine\utility::flag_wait("tunnel_approach");
}

heli_spotlight_escape() {
  level endon("player_reached_drain_tunnel");
  level.player endon("death");
  self.spotlight endon("death");
  wait 1;
  heli_spotlight_toggle(1);
  var_0 = 0;

  for(;;) {
    while(self.move_override)
      wait 0.05;

    escape_player_hidden();

    if(!var_0) {
      thread scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_heli_light_10");
      var_0 = 1;
    }

    escape_player_exposed();
    self.noshooting = 1;
  }
}

escape_player_hidden() {
  if(!level.player scripts\engine\utility::ent_flag("indoors")) {
    return;
  }
  level.player endon("indoors");
  self.spotlight.target_ent unlink();

  for(;;) {
    if(istrue(self.spotlight.override)) {
      wait 0.05;
      continue;
    }

    heli_spotlight_hunt();
    wait(randomfloatrange(3, 6));

    if(self.move_override)
      return;
  }
}

escape_player_exposed() {
  if(level.player scripts\engine\utility::ent_flag("indoors")) {
    return;
  }
  level.player endon("indoors");
  self.noshooting = 1;
  var_0 = 450;
  var_1 = 2;
  var_2 = level.player.origin + anglesToForward(level.player.angles) * var_0;
  self.spotlight.target_ent moveTo(var_2, var_1, var_1 * 0.5, var_1 * 0.5);
  wait(var_1);
  var_3 = 0;

  for(;;) {
    if(istrue(self.spotlight.override)) {
      wait 0.05;
      continue;
    }

    var_0 = var_0 - 15;
    var_4 = vectortoangles(self.spotlight.target_ent.origin - level.player.origin);
    var_2 = level.player.origin + anglesToForward(var_4) * var_0;
    self.spotlight.target_ent.origin = var_2;

    if(var_0 < 50) {
      var_0 = randomintrange(30, 50);

      if(!var_3) {
        var_3 = 1;
        self setlookatent(level.player);
        self.noshooting = 0;
      }
    }

    wait 0.05;
  }
}

escape_player_attack_think() {
  self setlookatent(level.player);
  level.player scripts\engine\utility::ent_flag_wait("indoors");
  var_0 = gettime();
  var_1 = gettime();

  while(!scripts\engine\utility::flag("tunnel_approach")) {
    waitframe();

    if(istrue(self.retaliate)) {
      self.retaliate = undefined;
      self setlookatent(level.player);

      if(!self.spotlight.isdead) {
        self notify("stop_spotlight_sweep");
        self.spotlight.override = 1;
        self.spotlight.target_ent.origin = level.player.origin;
        heli_spotlight_toggle(1);
      }

      shoottokill(1);
      self.spotlight.override = 0;
      continue;
    }

    if(self.noshooting) {
      continue;
    }
    if(level.player scripts\engine\utility::ent_flag("indoors")) {
      continue;
    }
    if(!canshoottargetfrompos(self.origin, level.player)) {
      continue;
    }
    if(gettime() - var_0 > 8500) {
      thread vo_heli_threaten_player();
      var_0 = gettime();
    }

    if(gettime() - var_1 > 15000) {
      var_2 = get_destructible_heli_target(900);

      if(!isDefined(var_2))
        var_2 = get_closest_car_in_front_of_player(900);

      if(isDefined(var_2)) {
        if(scripts\engine\utility::is_equal(var_2.script_noteworthy, "rocket")) {
          var_3 = heli_try_rockets(var_2, 0, "dx_vom_pri_estate_helo_11");

          if(!istrue(var_3))
            continue;
        } else
          shootambienttarget(var_2);

        var_4 = gettime();
        level.used_destructible_targets[level.used_destructible_targets.size] = var_2;
        continue;
      }
    }

    if(!istrue(self.move_override)) {
      self setlookatent(level.player);

      if(!heliisfacing(level.player))
        continue;
    }

    if(!self.spotlight.isdead) {
      var_3 = heli_try_rockets(level.player);

      if(!istrue(var_3)) {
        heli_spotlight_toggle(1);

        if(level.player scripts\engine\utility::ent_flag("indoors")) {
          continue;
        }
        level notify("warn_player");
        shoottokill();
      }
    } else
      hurtplayer();

    escape_player_attack_wait();
  }
}

vo_heli_threaten_player() {
  level.escape_heli.pilot scripts\engine\sp\utility::smart_dialogue_generic(scripts\engine\utility::random(["dx_vom_ru2_heli_callout_90", "dx_vom_ru2_heli_callout_100"]));
}

heli_movement_escape() {
  level endon("tunnel_approach");
  scripts\engine\utility::flag_wait("escape_begin");

  for(;;) {
    while(self.move_override)
      wait 0.1;

    scripts\sp\maps\estate\estate_util.gsc::waittill_player_stops_rotating_or_timeout(5);

    while(self.move_override)
      wait 0.1;

    self notify("new_goal");
    var_0 = get_ideal_heli_spot();

    if(!level.player scripts\engine\utility::ent_flag("indoors"))
      var_0 = adjustposforvisibility(var_0);

    if(!self.move_override)
      heli_movetopos_and_idle(var_0);

    wait 0.05;
  }
}

heli_spotlight_heli_return() {
  level endon("start_tunnel_collapse");
  level.player endon("death");
  self.spotlight endon("death");

  if(self.spotlight.isdead) {
    return;
  }
  wait 1;
  heli_spotlight_toggle(1);
  self.noshooting = 1;

  for(;;) {
    while(self.move_override)
      waitframe();

    if(level.player scripts\engine\utility::ent_flag("indoors"))
      heli_return_spotlight_player_hidden();

    heli_return_spotlight_player_exposed();
    self.noshooting = 1;
  }
}

heli_return_spotlight_player_hidden() {
  level.player endon("indoors");

  if(!self.move_override)
    self clearlookatent();

  self.spotlight.target_ent unlink();

  for(;;) {
    if(istrue(self.spotlight.override)) {
      waitframe();
      continue;
    }

    heli_spotlight_toggle(1);
    heli_spotlight_hunt(20);
    wait(randomfloatrange(1, 3));
  }
}

heli_return_spotlight_player_exposed() {
  level.player endon("indoors");
  var_0 = 800;
  var_1 = level.player.origin + anglesToForward(level.player.angles) * var_0;

  if(self.spotlight.active) {
    var_2 = 2;
    self.spotlight.target_ent moveTo(var_1, var_2, var_2 * 0.5, var_2 * 0.5);
    wait(var_2);
  } else {
    self.spotlight.target_ent.origin = var_1;
    wait 0.15;
    heli_spotlight_toggle(1);
  }

  var_3 = 0;

  for(;;) {
    var_4 = level.player.origin;
    var_0 = var_0 - 15;
    var_5 = vectortoangles(self.spotlight.target_ent.origin - var_4);
    var_1 = var_4 + anglesToForward(var_5) * var_0;
    self.spotlight.target_ent.origin = var_1;

    if(var_0 < 50) {
      var_0 = randomintrange(0, 50);

      if(!var_3) {
        var_3 = 1;
        self setlookatent(level.player);
        self.noshooting = 0;
      }
    }

    waitframe();
  }
}

heli_spotlight_killed_heli_return() {
  self endon("death");
  level endon("start_tunnel_collapse");

  if(self.spotlight.isdead) {
    return;
  }
  self.spotlight waittill("death");
  self.noshooting = 0;
}

heli_attack_player_heli_return() {
  level endon("start_tunnel_collapse");

  for(;;) {
    waitframe();

    if(self.shoot_override) {
      continue;
    }
    if(istrue(self.retaliate)) {
      self.retaliate = undefined;
      self setlookatent(level.player);

      if(!self.spotlight.isdead) {
        self notify("stop_spotlight_sweep");
        self.spotlight.override = 1;
        self.spotlight.target_ent.origin = level.player.origin;
        heli_spotlight_toggle(1);
      }

      shoottokill(1);
      self.spotlight.override = 0;
      continue;
    }

    if(istrue(self.trying_rockets)) {
      continue;
    }
    if(self.noshooting) {
      continue;
    }
    if(!canshoottargetfrompos(self.origin, level.player)) {
      continue;
    }
    if(!istrue(self.move_override)) {
      self setlookatent(level.player);

      while(!heliisfacing(level.player))
        wait 0.1;
    }

    missplayer();
    wait(randomfloatrange(3, 4));
  }
}

heli_event_tunnel() {
  var_0 = scripts\engine\utility::getStruct("heli_tunnel_struct", "targetname");
  thread assign_heli_positions(scripts\engine\utility::getStructArray(var_0.target, "targetname"));
  thread heli_spotlight_heli_return();
  thread heli_spotlight_killed_heli_return();
  thread heli_attack_player_heli_return();
  level waittill("player_approaching_tunnel");
  self.noshooting = 1;
  self.shoot_override = 1;
  stopshooting();
  self notify("stop_trying_rockets");
  level.tunnel_struct scripts\engine\sp\utility::waittill_player_lookat(0.77, 0, 1, 2);
  var_1 = level.player.origin + vectorNormalize(level.tunnel_struct.origin - level.player.origin) * 600;
  var_2 = scripts\engine\utility::spawn_script_origin(scripts\engine\utility::drop_to_ground(var_1), (0, 0, 0));
  heli_try_rockets(var_2, 1);
  self.noshooting = 0;
  self.shoot_override = 0;
  scripts\engine\utility::flag_wait("tunnel_open");
  scripts\engine\utility::flag_wait("player_reached_drain_tunnel");

  if(!scripts\engine\utility::within_fov(level.player getEye(), level.player getgunangles(), level.hadir gettagorigin("j_spine4"), 0.8))
    waittill_player_moves_or_timeout(2);

  level notify("start_tunnel_collapse");
  level.player.disabletakecoverwarning = 1;
  self.noshooting = 1;
  self.shoot_override = 1;
  stopshooting();
  var_2 = scripts\engine\utility::getStruct("tunnel_collapse_missile_target", "targetname");
  thread heli_try_rockets(var_2, 1, "dx_vom_pri_chopper_reattack_95", "player_entered_tunnel_gate");
  self waittill("missile_fired", var_3);
  self waittill("missile_fired", var_4);
  var_3 waittill("death");
  scripts\engine\utility::exploder("vfxexplotunnel");
  var_4 waittill("death");

  if(!scripts\engine\utility::flag("player_in_tunnel")) {
    scripts\engine\utility::exploder("vfxexpl_tunnelfail");

    if(scripts\engine\utility::flag("player_reached_drain_tunnel"))
      level.player scripts\sp\utility::do_damage(9999, var_2.origin, level.escape_heli);
    else {
      scripts\sp\player_death::set_custom_death_quote(47);
      scripts\sp\utility::missionfailedwrapper();
    }
  }

  level notify("tunnel_collapse");
}

waittill_player_moves_or_timeout(var_0) {
  level scripts\engine\utility::delaythread(var_0, scripts\engine\utility::send_notify, "player_move_timeout");
  level endon("player_move_timeout");
  var_1 = level.player.origin;

  while(level.player.origin == var_1)
    waitframe();
}

heli_damage_death() {
  scripts\engine\utility::flag_wait("escape_begin");
  scripts\sp\maps\estate\estate_util.gsc::make_alias_group("heli_damage", ["dx_vom_pri_escape_helo_10", "dx_vom_pri_escape_helo_20", "dx_vom_pri_escape_helo_30"]);

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(scripts\engine\utility::is_equal(var_1, level.player)) {
      if(shoulddoweaponnag()) {
        self.last_weapon_nag = gettime();
        thread scripts\sp\maps\estate\estate_util.gsc::price_line(scripts\sp\maps\estate\estate_util.gsc::get_next_alias_in_group("heli_damage"));
      }

      if(self.shoot_override) {
        continue;
      }
      if(scripts\engine\utility::is_equal(self.shooting_target, level.player)) {
        continue;
      }
      if(scripts\engine\utility::is_equal(self.rockets_target, level.player)) {
        continue;
      }
      if(!canshoottargetfrompos(self.origin, level.player, 1)) {
        continue;
      }
      self.retaliate = 1;
      stopshooting();
      self notify("stop_trying_rockets");
      self notify("reattack");
    }
  }
}

shoulddoweaponnag() {
  if(!isDefined(self.last_weapon_nag))
    return 1;

  if(isDefined(self.last_weapon_nag) && gettime() - self.last_weapon_nag > 15000)
    return 1;

  return 0;
}

force_save() {
  if(isDefined(level.isforcesaving)) {
    return;
  }
  level.isforcesaving = 1;
  var_0 = 0;
  var_1 = 10;
  var_2 = level.curautosave;

  for(;;) {
    var_0++;
    scripts\engine\sp\utility::autosave_by_name_thread("forceSave");

    if(level.curautosave == var_2 && var_0 <= var_1) {
      iprintln("autosave attempt " + var_0 + " failed - trying again in 1 second!");
      wait 1;
      continue;
    }

    break;
  }

  if(level.curautosave == var_2)
    iprintln("Failed to save after " + var_1 + " tries! This is bad.");
  else
    iprintln("Save success after " + var_0 + " attempts ");

  level.isforcesaving = undefined;
}

heli_pos_override_trig(var_0) {
  if(!scripts\engine\utility::flag("escape_begin")) {
    return;
  }
  if(scripts\engine\utility::flag("tunnel_approach")) {
    return;
  }
  if(scripts\engine\utility::is_equal(var_0, level.player)) {
    level.escape_heli.move_override = 1;
    level notify("player_moved");
    var_1 = scripts\engine\utility::getStructArray(self.target, "targetname");

    if(var_1.size > 1)
      level.escape_heli thread assign_heli_positions(var_1);
    else {
      level.escape_heli nav_gotopos(var_1[0].origin);
      level.escape_heli settargetyaw(var_1[0].angles[1]);
    }

    while(var_0 istouching(self))
      wait 0.05;

    level.escape_heli.move_override = 0;
  }
}

assign_heli_positions(var_0) {
  self notify("new_heli_positions");
  self endon("new_heli_positions");

  if(!isarray(var_0))
    var_0 = [var_0];

  if(var_0.size == 1) {
    nav_gotopos(var_0[0].origin, 47, 1);
    return;
  }

  var_0 = scripts\engine\utility::array_randomize(var_0);

  for(;;) {
    foreach(var_2 in var_0) {
      nav_gotopos(var_2.origin, 50, 1);
      self setlookatent(level.player);
      var_3 = randomfloatrange(3, 5);
      scripts\engine\utility::waittill_notify_or_timeout("damage", var_3);
      player_fired_recently_delay();
    }
  }
}

player_fired_recently_delay() {
  if(isDefined(level.player.last_misile_fire_time) && gettime() - level.player.last_misile_fire_time < 2500)
    wait 2;
}

get_ideal_heli_spot() {
  var_0 = scripts\engine\utility::getStruct("tunnel_obj", "targetname").origin;
  var_1 = vectortoangles(var_0 - level.player.origin);
  var_2 = level.player.origin + anglesToForward(var_1) * 2000;
  var_3 = "heli_lane";
  var_4 = scripts\engine\utility::getStructArray(var_3, "targetname");
  var_5 = [];

  foreach(var_10, var_7 in var_4) {
    var_8 = scripts\engine\utility::getStruct(var_7.target, "targetname");
    var_9 = spawnStruct();
    var_9.origin = pointonsegmentnearesttopoint(var_7.origin, var_8.origin, var_2);
    var_5[var_5.size] = var_9;
  }

  var_11 = sortbydistance(var_5, var_2)[0];
  return (var_11.origin[0], var_11.origin[1], level.player.target_ent.origin[2]);
}

monitor_player_moves() {
  level.escape_heli endon("new_goal");
  var_0 = level.player.origin;

  for(;;) {
    wait 0.05;
    var_1 = distancesquared(level.player.origin, var_0);

    if(var_1 > squared(150)) {
      level notify("player_moved");
      var_0 = level.player.origin;
    }
  }
}

heli_movetopos_and_idle(var_0) {
  level thread monitor_player_moves();
  level endon("player_moved");
  nav_gotopos(var_0);
  wait 4;
}

nav_gotopos(var_0, var_1, var_2) {
  if(!istrue(var_2))
    self notify("new_heli_positions");

  self notify("nav_new_path");
  self endon("nav_new_path");
  var_3 = findpath3d(self.origin, var_0);

  if(!isDefined(var_3)) {
    iprintlnbold("No nav3d data for heli! Heli flying will be bad .");
    return;
  }

  var_4 = 0;
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 37);
  self vehicle_setspeed(var_1, var_1 * 0.5, var_1 * 0.5);

  foreach(var_7, var_6 in var_3) {
    if(var_7 == var_3.size - 1)
      var_4 = 1;

    self setvehgoalpos(var_6, var_4);
    scripts\engine\utility::waittill_any("near_goal", "goal");
  }

  self notify("nav_goal");
}

adjustposforvisibility(var_0, var_1) {
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.player);

  if(var_1 scripts\sp\maps\estate\estate_util.gsc::has_ceiling())
    var_2 = 1760;
  else
    var_2 = 2500;

  var_3 = scripts\engine\utility::flatten_vector(var_1.origin - var_0);
  var_4 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0, 1, 1);

  for(;;) {
    if(!scripts\engine\trace::ray_trace_passed(var_0 - (0, 0, self.mg_z_offset), var_1.origin + (0, 0, 18), [self, self.minigun, self.spotlight, level.player], var_4)) {
      if(var_0[2] + 100 <= var_2)
        var_0 = var_0 + (0, 0, 100);
      else if(distance2dsquared(var_0 + var_3 * 50, var_1.origin) >= 250000)
        var_0 = var_0 + var_3 * 50;
      else
        return var_0;
    } else
      return var_0;

    wait 0.05;
  }
}

canshoottargetfrompos(var_0, var_1, var_2) {
  if(!istrue(var_2) && self.noshooting)
    return 0;

  if(isPlayer(var_1) || isai(var_1))
    var_3 = var_1 getEye();
  else
    var_3 = var_1.origin;

  var_4 = sighttracepassed(var_0 - (0, 0, self.mg_z_offset), var_3, 0, self);
  return var_4;
}

heli_spotlight_create() {
  var_0 = "tag_spotlight";
  var_1 = (0, -5, 0);
  var_2 = self gettagorigin(var_0);
  self.spotlight = spawnturret("misc_turret", var_2, "fighter_spotlight");
  self.spotlight.angles = self gettagangles(var_0);
  self.spotlight setModel("veh8_mil_air_mindia8_spotlight");
  self.spotlight linkTo(self, var_0, var_1, (0, 0, 0));
  self.spotlight makeunusable();
  self.spotlight setmode("manual");
  self.spotlight setdefaultdroppitch(0);
  self.spotlight setleftarc(180);
  self.spotlight setrightarc(180);
  self.spotlight settoparc(180);
  self.spotlight setbottomarc(180);
  self.spotlight setconvergencetime(0.05, "yaw");
  self.spotlight setconvergencetime(0.05, "pitch");
  self.spotlight.target_ent = scripts\engine\utility::spawn_tag_origin();
  self.spotlight settargetentity(self.spotlight.target_ent);
  self.spotlight.override = 0;
  self.spotlight.power_override = 0;
  self.spotlight.active = 0;
  self.spotlight setCanDamage(1);
  self.spotlight.isdead = 0;
  thread scripts\engine\utility::delete_on_death(self.spotlight.target_ent);
  thread heli_spotlight_damage_death();
}

heli_spotlight_damage_death() {
  self endon("death");
  var_0 = self.spotlight;
  wait 1;

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(scripts\engine\utility::is_equal(var_2, level.player)) {
      var_11 = undefined;

      if(isDefined(var_10))
        var_11 = var_10.classname;

      if(!isDefined(var_11)) {
        continue;
      }
      if(var_11 == "grenade" || var_11 == "rocketlauncher") {
        if(gettime() - self.lastrocketdmgtime > 250)
          self notify("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
      }

      heli_spotlight_toggle(0);
      self.spotlight notify("death");
      self.spotlight.isdead = 1;

      if(!self.shoot_override)
        self.noshooting = 0;

      playFXOnTag(level._effect["vfx_estate_heli_sparks"], self, "tag_spotlight");
      return;
    }
  }
}

heli_mg_create() {
  var_0 = "tag_turret";
  var_1 = (-64, 0, 0);
  var_2 = self gettagorigin(var_0);
  self.minigun = spawnturret("misc_turret", var_2, "iw8_mindia8_turret");
  self.minigun.angles = self gettagangles(var_0);
  self.minigun setModel("veh8_mil_air_mindia8_turret");
  self.minigun linkTo(self, var_0, (0, 0, 0), (0, 0, 0));
  self.minigun makeunusable();
  self.minigun setmode("manual");
  self.minigun setdefaultdroppitch(0);
  self.minigun setleftarc(180);
  self.minigun setrightarc(180);
  self.minigun settoparc(180);
  self.minigun setbottomarc(180);
  self.minigun setconvergencetime(0.05, "yaw");
  self.minigun setconvergencetime(0.05, "pitch");
  self.minigun.target_ent = scripts\engine\utility::spawn_tag_origin();
  self.minigun.chopper = self;
  self.mg_z_offset = self.origin[2] - self.minigun gettagorigin("tag_flash")[2];
  thread scripts\engine\utility::delete_on_death(self.minigun.target_ent);
}

heli_spotlight_toggle(var_0) {
  if(self.spotlight.isdead)
    var_0 = 0;

  if(var_0 && !self.spotlight.active) {
    playFXOnTag(scripts\engine\utility::getfx("vfx_estate_chopper_enemy_spotlight_01"), self.spotlight, "tag_flash");
    self.spotlight.active = 1;
  } else if(!var_0 && self.spotlight.active) {
    stopFXOnTag(scripts\engine\utility::getfx("vfx_estate_chopper_enemy_spotlight_01"), self.spotlight, "tag_flash");
    self.spotlight.active = 0;
  }
}

heliisfacing(var_0) {
  self endon("death");
  self endon("leaving");
  var_1 = 10;
  var_2 = anglesToForward(self.angles);
  var_3 = var_0.origin - self.origin;
  var_2 = var_2 * (1, 1, 0);
  var_3 = var_3 * (1, 1, 0);
  var_3 = vectorNormalize(var_3);
  var_2 = vectorNormalize(var_2);
  var_4 = vectordot(var_3, var_2);
  var_5 = cos(var_1);

  if(var_4 >= var_5)
    return 1;
  else
    return 0;
}

escape_player_attack_wait() {
  self endon("reattack");
  var_0 = gettime();
  var_1 = 5;
  var_2 = 0;
  var_3 = 20;

  if(scripts\engine\utility::flag("tunnel_approach")) {
    return;
  }
  while(gettime() < var_0 + var_1 * 1000) {
    if(level.player sprintbuttonPressed() || level.player issprinting()) {
      wait 0.25;
      continue;
    } else {
      var_2++;

      if(var_2 >= var_3)
        return;
    }

    wait 0.05;
  }
}

heli_spotlight_hunt(var_0) {
  var_1 = undefined;

  if(self.spotlight.isdead) {
    return;
  }
  var_1 = getallyhelitarget();

  if(!isDefined(var_1))
    var_1 = getcovernodehelitarget();

  if(isDefined(var_1) && !self.spotlight.override)
    heli_spotlight_sweep([var_1], var_0);
}

getcovernodehelitarget(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 1500;

  if(!isDefined(var_1))
    var_1 = 500;

  var_2 = getnodesinradius(level.player.origin, var_0, var_1);
  var_2 = scripts\engine\utility::array_randomize(var_2);

  foreach(var_4 in var_2) {
    if(scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_4.origin, cos(60)) && sighttracepassed(self.origin, var_4.origin, 0, self))
      return var_4;
  }

  return undefined;
}

getallyhelitarget() {
  foreach(var_1 in getaiarray("allies")) {
    if(sighttracepassed(self.origin, var_1.origin, 0, self))
      return var_1;
  }

  return undefined;
}

heli_spotlight_sweep(var_0, var_1) {
  self notify("stop_spotlight_sweep");
  self endon("stop_spotlight_sweep");
  self.spotlight endon("death");

  if(self.spotlight.isdead) {
    return;
  }
  if(!isarray(var_0))
    var_0 = [var_0];

  if(var_0.size > 1 && !isDefined(var_1))
    var_0 = scripts\engine\utility::array_randomize(var_0);

  var_2 = 1;

  foreach(var_8, var_4 in var_0) {
    if(!isDefined(var_4)) {
      waitframe();
      continue;
    }

    if(var_2 && var_0.size > 1) {
      self.spotlight.target_ent.origin = var_4.origin;
      var_2 = 0;
      continue;
    }

    var_5 = distance(self.spotlight.target_ent.origin, var_4.origin);

    if(!var_5) {
      continue;
    }
    var_6 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 40);
    var_7 = scripts\engine\sp\utility::mph_travel_time(var_6, var_5);

    if(!isDefined(var_1)) {
      if(var_7 <= 0)
        var_7 = 1;
      else if(var_7 > 1.5)
        var_7 = 1.5;
    }

    self.spotlight.target_ent moveTo(var_4.origin, var_7, var_7 * 0.8, var_7 * 0.2);
    wait(var_7 + randomfloatrange(0.8, 1.5));
  }
}

heliattackwarning() {
  level endon("tunnel_approach");
  scripts\sp\maps\estate\estate_util.gsc::make_alias_group("heli_attack_warning", ["dx_vom_pri_estate_helo_14", "dx_vom_pri_estate_helo_15", "dx_vom_pri_estate_helo_16", "dx_vom_pri_estate_helo_17"]);

  for(;;) {
    level waittill("warn_player");
    scripts\sp\maps\estate\estate_util.gsc::price_line(scripts\sp\maps\estate\estate_util.gsc::get_next_alias_in_group("heli_attack_warning"));
    wait 10;
  }
}

stopshooting() {
  self.minigun stopbarrelspin();

  if(self.is_shooting) {
    self notify("stop_shooting");
    self.shooting_target = undefined;
    self.is_shooting = 0;
  }
}

shootambienttarget(var_0) {
  if(isalive(var_0))
    var_0 endon("death");

  if(self.noshooting) {
    return;
  }
  self endon("stop_shooting");
  self.is_shooting = 1;
  self.spotlight.override = 1;
  heli_spotlight_toggle(1);
  self.minigun startbarrelspin();
  wait 1.5;

  if(isDefined(var_0.target)) {
    shootambient_targetspline(var_0);
    return;
  }

  thread heli_spotlight_sweep([var_0]);

  if(isDefined(var_0.angles)) {
    var_1 = 200;
    self.minigun.target_ent.origin = var_0.origin + anglesToForward(var_0.angles) * var_1;
    self.minigun snaptotargetentity(self.minigun.target_ent, (0, 0, 0));

    for(;;) {
      var_1 = var_1 - 20;
      self.minigun.target_ent.origin = var_0.origin + anglesToForward(var_0.angles) * var_1;
      self.minigun shootturret();
      wait 0.05;

      if(distance(var_0.origin, self.minigun.target_ent.origin) < 50) {
        break;
      }
    }
  }

  if(isai(var_0)) {
    var_2 = anglesToForward(var_0.angles);
    var_3 = var_2 * 400;
    var_4 = var_3 + scripts\engine\utility::randomvector(50);
    var_5 = randomintrange(30, 45);
    self.minigun startbarrelspin();
    wait 1.5;

    for(var_6 = 0; var_6 < var_5; var_6++) {
      var_4 = var_3 + scripts\engine\utility::randomvector(50);
      self.minigun settargetentity(var_0, var_4);
      self.minigun shootturret();
      wait 0.05;
    }
  } else {
    self.minigun.target_ent.origin = var_0.origin;
    self.minigun snaptotargetentity(self.minigun.target_ent, (0, 0, 0));
    var_5 = randomintrange(25, 35);

    for(var_6 = 0; var_6 < var_5; var_6++) {
      self.minigun shootturret();
      wait 0.05;
    }
  }

  self.minigun stopbarrelspin();
  self.is_shooting = 0;
  self.spotlight.override = 0;
}

shootambient_targetspline(var_0) {
  self.spotlight.override = 1;
  self.spotlight.target_ent.origin = var_0.origin;
  self.minigun cleartargetentity();
  self.minigun snaptotargetentity(self.spotlight.target_ent, (0, 0, 0));
  waittillframeend;
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  thread heli_minigun_shoot_til_notify("stop_shooting_ambient_spine");
  heli_spotlight_toggle(1);
  thread scripts\engine\sp\utility::draw_line_from_ent_to_ent_for_time(self, self.spotlight.target_ent, 1, 1, 0, 5);

  for(;;) {
    var_2 = scripts\engine\sp\utility::mph_travel_time(10, distance(var_0.origin, var_1.origin));
    self.spotlight.target_ent moveTo(var_1.origin, var_2);
    wait(var_2);
    var_0 = var_1;

    if(isDefined(var_0.target)) {
      var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
      continue;
    }

    break;
  }

  self notify("stop_shooting_ambient_spine");
  self.spotlight.override = 0;
  heli_spotlight_toggle(0);
  self.minigun cleartargetentity();
  self.minigun settargetentity(self.minigun.target_ent);
}

missplayer() {
  if(self.noshooting) {
    return;
  }
  self endon("stop_shooting");
  self.is_shooting = 1;
  self.minigun startbarrelspin();
  wait 1.5;
  var_0 = 400;
  var_1 = var_0 + 450;
  self.minigun.target_ent.origin = level.player.origin + anglesToForward(level.player.angles) * var_1;
  self.minigun snaptotargetentity(self.minigun.target_ent, (0, 0, 0));

  for(;;) {
    var_1 = var_1 - 20;
    self.minigun.target_ent.origin = level.player.origin + anglesToForward(level.player.angles) * var_1;

    if(distancesquared(level.player.origin, self.minigun.target_ent.origin) < var_0 * var_0) {
      break;
    }

    var_2 = 1;

    foreach(var_4 in level.friendlies) {
      if(distancesquared(self.minigun.target_ent.origin, var_4.origin) < 3600) {
        var_2 = 0;
        break;
      }
    }

    if(var_2) {
      var_6 = scripts\engine\trace::ray_trace(self.minigun gettagorigin("tag_flash"), self.minigun.target_ent.origin, [self, self.minigun]);

      if(isDefined(var_6["entity"]) && scripts\engine\utility::array_contains(level.friendlies, var_6["entity"]))
        var_2 = 0;
      else if(isDefined(var_6["position"])) {
        foreach(var_4 in level.friendlies) {
          if(distancesquared(var_6["position"], var_4.origin) < 3600) {
            var_2 = 0;
            break;
          }
        }
      }
    }

    if(!var_2) {
      break;
    }

    self.minigun shootturret();
    waitframe();
  }

  var_9 = anglesToForward(level.player.angles);
  var_10 = var_9 * var_0;
  var_11 = var_10 + scripts\engine\utility::randomvector(50);
  var_12 = randomintrange(20, 30);

  for(var_13 = 0; var_13 < var_12; var_13++) {
    var_11 = var_10 + scripts\engine\utility::randomvector(50);
    self.minigun settargetentity(level.player, var_11);
    self.minigun shootturret();
    wait 0.05;
  }

  self.minigun stopbarrelspin();
  self.is_shooting = 0;
}

shoottokill(var_0) {
  heli_shoot_player(375, 20, 120, 30, 0.25, 0.1, 0, var_0);
}

hurtplayer() {
  heli_shoot_player(500, 20, 60, 50, 0.1, 0.01, 1);
}

heli_shoot_player(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!istrue(var_7) && self.noshooting) {
    return;
  }
  self endon("death");
  self endon("stop_shooting");
  self.minigun startbarrelspin();
  self.is_shooting = 1;
  self.shooting_target = level.player;
  wait 1.5;
  childthread update_target_offset();
  var_8 = var_0;
  var_9 = get_destructible_heli_target(var_8, 1);

  if(!isDefined(var_9))
    var_9 = get_closest_car_in_front_of_player(var_8, 1);

  if(isDefined(var_9)) {
    level.used_destructible_targets[level.used_destructible_targets.size] = var_9;
    self.minigun.target_ent.origin = level.player.origin + vectorNormalize(var_9.origin - level.player.origin) * var_8;
  } else
    self.minigun.target_ent.origin = level.player.origin + anglesToForward(level.player.angles) * var_8;

  self.minigun snaptotargetentity(self.minigun.target_ent, (0, 0, 0));

  for(;;) {
    self.minigun.target_ent.origin = level.player.origin + anglesToForward(level.player.angles) * var_8;
    self.minigun shootturret();
    wait 0.05;

    if(distance(level.player.origin, self.minigun.target_ent.origin) < 50) {
      break;
    }

    var_8 = var_8 - var_1;
  }

  var_10 = undefined;

  for(var_11 = 0; var_11 < var_2; var_11++) {
    if(level.player scripts\engine\utility::ent_flag("indoors")) {
      if(!isDefined(var_10))
        var_10 = gettime() + 1000;
      else if(gettime() >= var_10) {
        break;
      }
    } else
      var_10 = undefined;

    var_12 = 1;

    if(var_11 % (1 / var_4) == 0 && !level.player issprinting() || var_11 % (1 / var_5) == 0 && level.player issprinting())
      var_12 = 0;

    if(istrue(var_6) && level.player.health <= 40 && checksprinting())
      var_12 = 1;

    if(var_12) {
      var_13 = scripts\engine\utility::ter_op(randomint(2), 1, -1);
      var_14 = scripts\engine\utility::ter_op(randomint(2), 1, -1);
      var_15 = (var_13 * (var_3 + randomfloat(var_3)), var_14 * (var_3 + randomfloat(var_3)), 0);
      self.minigun snaptotargetentity(level.player, var_15);
    } else
      self.minigun snaptotargetentity(level.player, self.target_offset);

    self.minigun shootturret();

    if(var_11 == var_2 * 0.5) {
      wait 0.3;
      continue;
    }

    wait 0.05;
  }

  self.minigun stopbarrelspin();
  self.shooting_target = undefined;
  self.is_shooting = 0;
}

update_target_offset() {
  self.target_offset = (0, 0, 20);
  var_0 = 10;

  while(self.is_shooting) {
    waitframe();

    if(scripts\engine\trace::ray_trace_passed(self.minigun gettagorigin("tag_flash"), level.player.origin + self.target_offset, [self, self.minigun, self.spotlight, level.player])) {
      continue;
    }
    self.target_offset = self.target_offset + (0, 0, var_0);

    if(self.target_offset[2] + var_0 > 60 || self.target_offset[2] + var_0 < 10)
      var_0 = var_0 * -1;
  }
}

safe_to_shoot_missiles(var_0) {
  if(isPlayer(var_0)) {
    if(self vehicle_getspeed() > 25 || !scripts\engine\utility::within_fov(self.origin, self.angles, level.player getEye(), cos(90)) || !scripts\engine\utility::within_fov(level.player.origin, level.player.angles, self.origin, cos(65)) || distance2d(self.origin, level.player.origin) < 800)
      return 0;
  } else if(isai(var_0)) {
    if(!isalive(var_0) || self vehicle_getspeed() > 25 || !scripts\engine\utility::within_fov(self.origin, self.angles, var_0 getEye(), cos(90)) || distance2d(self.origin, var_0.origin) < 800)
      return 0;
  } else if(self vehicle_getspeed() > 25 || !scripts\engine\utility::within_fov(self.origin, self.angles, var_0.origin, cos(90)))
    return 0;

  return 1;
}

heli_try_rockets(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = 0;

  if(!var_1) {
    if(self.noshooting) {
      return;
    }
    if(istrue(self.trying_rockets)) {
      return;
    }
    if(isDefined(self.last_rocket_time) && !scripts\engine\utility::time_has_passed(self.last_rocket_time, 15)) {
      return;
    }
    if(!scripts\engine\utility::time_has_passed(level.player.outdoor_time, 2))
      return;
  }

  self.trying_rockets = 1;
  self.rockets_target = var_0;
  self endon("stop_trying_rockets");
  thread cleanup_heli_rockets();

  if(!var_1) {
    var_4 = scripts\engine\utility::ter_op(isPlayer(var_0), 5, 2);
    var_5 = gettime();
    var_6 = 0;

    while(gettime() < var_5 + var_4 * 1000) {
      var_6 = safe_to_shoot_missiles(var_0);

      if(var_6) {
        break;
      }

      wait 0.05;
    }

    if(!var_6) {
      self notify("stop_trying_rockets");
      return;
    }
  }

  var_7 = scripts\engine\utility::random(["dx_vom_ru2_heli_callout_10", "dx_vom_ru2_heli_callout_20", "dx_vom_ru2_heli_callout_40"]);
  level.escape_heli.pilot thread scripts\engine\sp\utility::smart_dialogue_generic(var_7);
  var_8 = getrockettargetpos(var_0);
  var_9 = 0;

  if(!var_1) {
    var_10 = sortbydistance(getaiarray("axis"), var_8);

    if(isDefined(var_10[0]) && distancesquared(var_10[0].origin, var_8) < squared(400))
      var_9 = 1;
  }

  var_11 = scripts\engine\utility::array_combine(level.friendlies, [self, self.minigun, self.spotlight, level.player]);
  var_12 = [];

  foreach(var_14 in self.missile_laser_tags) {
    foreach(var_17, var_16 in var_14) {
      if(var_1 || scripts\engine\trace::ray_trace_passed(self gettagorigin(var_17), var_8, var_11)) {
        var_12[var_17] = var_16;
        break;
      }
    }
  }

  if(!var_12.size || var_9)
    self notify("stop_trying_rockets");
  else {
    var_19 = 1.5;
    self.badplace = createnavbadplacebybounds(var_8, (200, 200, 200), (0, 0, 0));
    self.spotlight.power_override = 1;
    heli_spotlight_toggle(0);
    scripts\engine\utility::delaythread(0.5, ::vo_warn_missiles, var_2);

    foreach(var_17, var_16 in var_12) {
      var_16 laserforceon();
      var_16 thread updatelaserangles(var_0, var_17, var_19, var_3);
    }

    if(isDefined(var_3))
      level scripts\engine\utility::waittill_notify_or_timeout(var_3, var_19);
    else
      wait(var_19);

    foreach(var_17, var_16 in var_12) {
      var_16 laserforceoff();
      var_16 linkTo(level.escape_heli, var_17);
    }

    var_22 = 0;
    var_23 = 0;
    var_8 = getrockettargetpos(var_0);

    if(!var_1 && self.noshooting) {
      self notify("stop_trying_rockets");
      return;
    }

    foreach(var_14 in self.missile_laser_tags) {
      foreach(var_17, var_16 in var_14) {
        if(var_1 || scripts\engine\trace::ray_trace_passed(self gettagorigin(var_17), var_8, var_11)) {
          heli_fire_missile(var_17, var_8);
          var_23++;
          var_22 = 1;
          break;
        }
      }

      if(var_22) {
        wait 0.3;
        var_22 = 0;
      }
    }

    self notify("shot_rockets");
    destroynavobstacle(self.badplace);
    self.attack_turns = 0;
    self.spotlight.power_override = 0;
    self.rockets_target = undefined;
    self.trying_rockets = 0;

    if(var_23)
      self.last_rocket_time = gettime();
  }
}

heli_fire_missile(var_0, var_1) {
  playFXOnTag(scripts\engine\utility::getfx("vfx_muz_heli_missile_single"), self, var_0);
  var_2 = magicbullet("iw8_la_sidewinder", self gettagorigin(var_0) + anglesToForward(self.angles) * 100, var_1);
  thread scripts\engine\utility::playsoundontag("weap_estate_heli_proj_launch", var_0);
  var_2 thread missile_earthquakerumble();
  self notify("missile_fired", var_2);
}

cleanup_heli_rockets() {
  self endon("shot_rockets");
  self waittill("stop_trying_rockets");

  foreach(var_1 in self.missile_laser_tags) {
    foreach(var_4, var_3 in var_1) {
      var_3 laserforceoff();

      if(!var_3 islinked())
        var_3 linkTo(level.escape_heli, var_4);
    }
  }

  if(isDefined(self.badplace))
    destroynavobstacle(self.badplace);

  self.spotlight.power_override = 0;
  self.rockets_target = undefined;
  self.trying_rockets = 0;
}

vo_warn_missiles(var_0) {
  if(!isDefined(var_0)) {
    if(!scripts\sp\maps\estate\estate_util.gsc::alias_group_exists("warn_missiles"))
      scripts\sp\maps\estate\estate_util.gsc::make_alias_group("warn_missiles", ["dx_vom_pri_chopper_reattack_95", "dx_vom_pri_chopper_reattack_85", "dx_vom_pri_estate_helo_11"]);

    var_0 = scripts\sp\maps\estate\estate_util.gsc::get_next_alias_in_group("warn_missiles");
  }

  scripts\sp\maps\estate\estate_util.gsc::price_line(var_0);
}

getrockettargetpos(var_0) {
  if(isPlayer(var_0))
    return var_0.origin + anglesToForward(var_0.angles) * 50 + (0, 0, 18);
  else
    return var_0.origin;
}

updatelaserangles(var_0, var_1, var_2, var_3) {
  var_4 = gettime() + var_2 * 1000;
  self unlink();

  if(isalive(var_0))
    var_0 endon("death");

  if(isDefined(var_3))
    level endon(var_3);

  while(gettime() - var_4) {
    self.origin = level.escape_heli gettagorigin(var_1);
    self.angles = vectortoangles(getrockettargetpos(var_0) - self.origin);
    waitframe();
  }
}

missile_earthquakerumble() {
  var_0 = self.origin;

  while(isDefined(self)) {
    var_0 = self.origin;
    wait 0.1;
  }

  earthquake(0.5, 0.7, var_0, 1200);
  playrumbleonposition("heavy_2s", var_0);

  if(distancesquared(var_0, level.player.origin) < squared(400)) {
    if(scripts\engine\utility::flag("tunnel_open"))
      level.player shellshock("estate_heli_missile_alt", 5);
    else
      level.player shellshock("estate_heli_missile", 5);
  }
}

get_destructible_heli_target(var_0, var_1) {
  var_2 = scripts\engine\utility::getStructArray("heli_destructible_target", "targetname");
  var_2 = sortbydistance(var_2, level.player.origin);

  foreach(var_4 in var_2) {
    if(distancesquared(var_4.origin, level.player.origin) > squared(var_0)) {
      break;
    }

    if(should_shoot_destructible_target(var_4, var_1))
      return var_4;
  }

  return undefined;
}

get_closest_car_in_front_of_player(var_0, var_1) {
  var_2 = getscriptablearray();
  var_3 = [];
  var_4 = undefined;

  foreach(var_6 in var_2) {
    if(isDefined(var_6.model) && issubstr(var_6.model, "veh8") && var_6.health > -250)
      var_3[var_3.size] = var_6;
  }

  var_3 = sortbydistance(var_3, level.player.origin);

  if(var_3.size) {
    foreach(var_9 in var_3) {
      if(distancesquared(var_9.origin, level.player.origin) > squared(var_0)) {
        break;
      }

      if(should_shoot_destructible_target(var_9, var_1))
        return var_9;
    }
  }

  return undefined;
}

should_shoot_destructible_target(var_0, var_1) {
  if(scripts\engine\utility::array_contains(level.used_destructible_targets, var_0))
    return 0;

  if(!scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_0.origin, cos(65)))
    return 0;

  if(!istrue(var_1) && !canshoottargetfrompos(self.origin, var_0))
    return 0;

  return 1;
}

heli_destructible_ceiling_logic() {
  self setCanDamage(1);
  self.script_health = 30000;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_2, var_2, var_2, var_2, var_3, var_2, var_4);
    self.script_health = self.script_health - var_0;

    if(self.script_health <= 0) {
      self delete();
      return;
    }
  }
}

heli_destructible_propane_tank_logic() {
  while(scripts\engine\utility::is_equal(self getscriptablepartstate("base", 1), "pristine")) {
    self waittill("damage", var_0, var_1);

    if(var_1 == level.escape_heli.minigun) {
      self setscriptablepartstate("base", "explode_estate");
      return;
    }
  }

  self setscriptablepartstate("base", "explode_estate");
}

place_heli_over_player() {
  level.escape_heli vehicle_teleport(level.player.origin + (0, 0, 1500), level.player.angles);
}

quietly_kill_all_axis() {
  var_0 = 0;

  foreach(var_2 in getaiarray("axis")) {
    var_2 delete();
    var_0++;

    if(var_0 == 3) {
      var_0 = 0;
      wait 0.05;
    }
  }

  waitframe();
  scripts\sp\maps\estate\estate_util.gsc::cleanup_all_dropped_loot();
  clearallcorpses();
  level notify("all_axis_killed");
}