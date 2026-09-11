/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\estate\estate_escape.gsc
****************************************************/

function estate_escape_precache() {
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
  scripts\sp\maps\estate\estate_util::hide_ents("corridor_collapse");
  scripts\sp\maps\estate\estate_util::hide_ents("corridorshootblocker");
  scripts\sp\maps\estate\estate_util::hide_ents("collapse_blocker_a");
  scripts\sp\maps\estate\estate_util::hide_ents("collapse_blocker_b");
  getEnt("stairs_destroyed_window", "script_noteworthy") hide();
  var0 = getEntArray("heli_pos_override", "targetname");
  scripts\engine\utility::array_thread(var0, &scripts\engine\sp\utility::add_trigger_function, &heli_pos_override_trig);
}

function checksprinting() {
  if(level.player issprinting() || level.player sprintbuttonPressed()) {
    return true;
  }

  return false;
}

function escape_trig_logic() {
  self endon("death");
  wait 0.15;
  var0 = undefined;

  if(isDefined(self.target)) {
    var0 = scripts\engine\utility::getStructArray(self.target, "targetname");
  }

  if(!isDefined(var0)) {
    return;
  }

  self waittill("trigger");
  var1 = 0;

  foreach(var3 in var0) {
    var3 scripts\engine\utility::script_delay();

    switch (var3.script_noteworthy) {
      case "smoke":
        if(istrue(self.smoked)) {
          break;
        }

        scripted_smoke_gren(var3);
        self.smoked = 1;
        break;
      default:
        break;
    }

    var1++;

    if(var1 >= 4) {
      wait 0.05;
      var1 = 0;
    }
  }
}

function scripted_smoke_gren() {
  playFX(scripts\engine\utility::getfx("vfx_est_smk_grenade_hero"), self.origin);
  thread scripts\engine\utility::play_sound_in_space("smoke_grenade_expl_trans", self.origin);
}

function estate_escape_flags() {
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

function obj_room_start() {
  scripts\sp\maps\estate\estate_util::spawn_price();
  level.price.pushable = 0;
  scripts\engine\sp\utility::set_start_location("obj_room_start", [level.price, level.player]);
}

function obj_room_main() {
  scripts\engine\sp\utility::flagwaitthread("door_opened", &scripts\engine\sp\utility::autosave_by_name, "obj_room");
  level.animnodes["mcguffin_struct"] = scripts\engine\utility::getStruct("mcguffin_struct", "targetname");
  thread price_door_nag();
  obj_door_setup();
  thread keypad_interact();
  thread obj_room_fov_change();
  scripts\sp\maps\estate\estate_util::spawn_hadir();
  level.hadir scripts\common\ai::gun_remove();
  level.animnodes["mcguffin_struct"] thread scripts\common\anim::anim_first_frame_solo(level.hadir, "obj_scene");
  scripts\engine\sp\utility::flagwaitthread("door_opened", &scripts\engine\sp\objectives::objective_set_description, "estate", &"ESTATE/OBJ_DESC_HADIR");
  scripts\engine\sp\utility::flagwaitthread("door_opened", &scripts\sp\analytics::analytics_kleenex_update, "reached 3rd floor keypad");
  thread obj_room_scene();
  scripts\engine\utility::flag_wait("obj_scene_started");
  scripts\engine\utility::delaythread(4, &quietly_kill_all_axis);
  level scripts\engine\utility::thread_on_notify("all_axis_killed", &scripts\sp\maps\estate\estate_util::post_grounds_cleanup);
  scripts\engine\utility::flag_wait("spawn_escape_heli");
}

function obj_room_scene() {
  var0 = level.animnodes["mcguffin_struct"];
  level waittill("keypad_interact");
  level.price scripts\common\utility::lookatentity(undefined);
  level.price stopsounds();
  scripts\engine\utility::delaythread(2, &scripts\sp\maps\estate\estate_util::price_line, "dx_vom_pri_obj_room_ext_10");
  level.player scripts\common\utility::allow_death(0, "keypad");
  var1 = var0 scripts\sp\player_rig::link_player_to_rig("door_keypad", "stand", 1, 0.5, 0, 45, 45, 30, 15, 1, undefined, 1);
  var0 thread scripts\common\anim::anim_single_solo(var1, "door_keypad");
  var1 thread scripts\engine\utility::waittillmatch_notify("single anim", "end", "unlink_player");
  var1 scripts\engine\utility::thread_on_notify("unlink_player", &scripts\sp\player_rig::unlink_player_from_rig, 0);
  var1 scripts\engine\utility::thread_on_notify("unlink_player", &scripts\common\utility::allow_death, 1, "keypad", level.player);
  scripts\engine\sp\utility::autosave_by_name("obj_room");
  scripts\engine\utility::flag_set("obj_scene_started");
  level.price.ignoreme = 1;
  level.price.ignoreall = 1;
  level.cutters hide();
  level.failonfriendlyfire = 1;
  var2 = scripts\engine\sp\utility::spawn_anim_model("obj_plans", (0, 0, 0), (0, 0, 0));

  if(level.price isinscriptedstate()) {
    level.price notify("stop_loop_price");
    level.price scripts\engine\sp\utility::anim_stopanimScripted();
  }

  var3 = [level.obj_door, level.price, level.hadir, var2];
  var0 scripts\common\anim::anim_single(var3, "obj_scene");
  var2 linkTo(level.price, "tag_stowed_back3");
}

function obj_room_fov_change() {
  level waittill("keypad_interact");
  level.player modifybasefov(60, 2);
  level waittill("door_pushed");
  level.player modifybasefov(65, 2);
}

function obj_door_setup() {
  var0 = getEnt("obj_door", "targetname");
  thread obj_door_destroy();
  var1 = scripts\engine\sp\utility::spawn_anim_model("obj_door", var0.origin, var0.angles);
  level.animnodes["mcguffin_struct"] scripts\common\anim::anim_first_frame_solo(var1, "obj_scene");
  waittillframeend();
  var1.clip = getEnt(var0.target, "targetname");
  var1.clip linkTo(var0);
  var1.script_model = var0;
  var0 linkTo(var1);
  var2 = var0 scripts\engine\utility::get_linked_ent();
  var2 linkTo(var1);
  thread keypad_unlock();
  level.obj_door = var1;
}

function obj_door_destroy() {
  level waittill("heli_obj_room_start_shooting");

  while(level.escape_heli.minigun.target_ent.origin[0] - self.origin[0] > 15) {
    waitframe();
  }

  scripts\engine\utility::exploder("door_swap");
  self setModel("ee_door_wood_stained_int_01_est_hvt_dst");
  level notify("obj_door_destroyed");
}

function keypad_unlock() {
  scripts\engine\utility::flag_wait("door_opened");
  self setModel("ee_door_wood_stained_int_01_keypad_unlocked");
  killfxontag(scripts\engine\utility::getfx("vfx_estate_keypad_light_red"), self.fx, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_estate_keypad_light_green"), self.fx, "tag_origin");
  level waittill("obj_door_destroyed");
  killfxontag(scripts\engine\utility::getfx("vfx_estate_keypad_light_green"), self.fx, "tag_origin");
  self.fx delete();
}

function keypad_interact() {
  var0 = scripts\engine\utility::getStruct("obj_interact", "targetname");
  var0 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, undefined, undefined, undefined, undefined, undefined, 1);
  var0 waittill("trigger");
  level notify("keypad_interact");

  if(scripts\engine\utility::flag("stealth_spotted")) {
    scripts\engine\utility::delaythread(1, &scripts\sp\maps\estate\estate_util::kyle_line, "dx_vom_kyle_obj_room_plans_33");
  } else {
    scripts\engine\utility::delaythread(1, &scripts\sp\maps\estate\estate_util::kyle_line, "dx_vom_kyle_obj_room_plans_32");
  }

  scripts\engine\sp\objectives::objective_complete("mansion");
}

function price_door_nag() {
  level endon("keypad_interact");
  scripts\engine\utility::flag_wait("met_up_with_price");
  GscBinSkip4(0x35);
}

function price_door_lookats() {
  var0 = [];

  foreach(var2 in scripts\engine\utility::getStructArray("price_lookat_struct", "targetname")) {
    var0 = var2 scripts\engine\utility::spawn_script_origin();
  }

  level scripts\engine\utility::thread_on_notify("keypad_interact", &scripts\engine\utility::array_delete, var0);
  var4 = 0;
  var5 = level.player;
  var6 = gettime() + 5000;

  for(;;) {
    if(gettime() >= var6 && !level.price scripts\sp\maps\estate\estate_util::can_i_see_an_enemy_or_can_enemies_see_me()) {
      if(isPlayer(var5)) {
        var5 = var0[scripts\sp\maps\estate\estate_util::abs_int(var4 % var0.size)];
        var4++;
      } else {
        var5 = level.player;
      }

      level.price glanceatentity(var5, 1000, 0);
      var6 = gettime() + 5000;
    }

    waitframe();
  }
}

function obj_room_catchup() {
  thread scripts\sp\maps\estate\estate_util::post_grounds_cleanup();
  scripts\engine\sp\objectives::objective_complete("mansion");
  scripts\engine\sp\objectives::objective_set_description("estate", &"ESTATE/OBJ_DESC_HADIR");
  scripts\engine\utility::flag_set("spawn_escape_heli");
}

function heli_attack_start() {
  scripts\sp\maps\estate\estate_util::spawn_friendlies();
  level.hadir scripts\common\ai::gun_remove();
  scripts\engine\sp\utility::set_start_location("heli_attack_start", [level.player]);
  level.animnodes["mcguffin_struct"] = scripts\engine\utility::getStruct("mcguffin_struct", "targetname");
  level.animnodes["mcguffin_struct"] thread scripts\common\anim::anim_single(level.friendlies, "obj_scene");
  var0 = 0.773026;
  level.hadir scripts\engine\utility::delaycall(0.05, &setanimtime, level.hadir scripts\engine\utility::getanim("obj_scene"), var0);
  level.price scripts\engine\utility::delaycall(0.05, &setanimtime, level.price scripts\engine\utility::getanim("obj_scene"), var0);
  thread obj_door_setup();
  level.failonfriendlyfire = 1;
  scripts\engine\utility::flag_set("lighting_heli_attack");
}

function heli_attack_main() {
  spawn_escape_heli();
  scripts\engine\sp\utility::autosave_by_name("heli_attack");
  thread vo_heli_attack();
  scripts\engine\sp\utility::flagwaitthread("window_spotlight_sweep_done", &scripts\sp\maps\estate\estate_util::show_ents, "corridor_collapse");
  scripts\engine\sp\utility::flagwaitthread("window_spotlight_sweep_done", &scripts\engine\utility::exploder, "stairdamage");
  scripts\engine\sp\utility::flagwaitthread("window_spotlight_sweep_done", &scripts\engine\utility::exploder, "stairdamage_b");
  scripts\engine\sp\utility::flagwaitthread("window_spotlight_sweep_done", &scripts\engine\utility::delaythread, 1, &turn_off_lights);
  scripts\engine\sp\utility::flagwaitthread("window_spotlight_sweep_done", &scripts\engine\utility::delaythread, 1, &obj_room_explosion);
  scripts\engine\sp\utility::flagwaitthread("window_spotlight_sweep_done", &scripts\engine\sp\utility::enable_trigger_with_targetname, "mansion_fire");
  scripts\engine\sp\utility::flagwaitthread("door_push_start", &scripts\engine\sp\utility::autosave_by_name, "heli_attack");
  heli_attack_scene();
}

function heli_attack_objective() {
  scripts\engine\sp\objectives::objective_set_description("estate", &"ESTATE/OBJ_DESC_ESCAPE");
}

function heli_attack_scene() {
  level.hadir waittillmatch("single anim", "end");
  var0 = level.animnodes["mcguffin_struct"];
  var0 thread scripts\common\anim::anim_loop(level.friendlies, "heli_idle");
  level waittill("end_cover_loop");
  scripts\engine\utility::delaythread(4, &player_door_wedge);
  var0 notify("stop_loop");
  scripts\engine\utility::array_thread(level.friendlies, &scripts\engine\sp\utility::anim_stopanimscripted);
  var0 thread scripts\common\anim::anim_single(level.friendlies, "obj_scene_b");
  thread audio_start_obj_room_fires();
  scripts\engine\utility::flag_wait("door_push_start");
  thread friendlies_at_door(var0);
  level.hadir playsoundatviewheight("dx_vom_had_meet_hadir_idle");
  level.price playsoundatviewheight("dx_vom_pri_meet_hadir_idle");
  level.failonfriendlyfire = undefined;
  scripts\sp\friendlyfire::turnoff();
  var1 = getEnt("door_push_trigger", "targetname");
  var2 = 0;

  for(var3 = 1;; var3 = 1) {
    waitframe();

    if(level.player istouching(var1) && scripts\engine\math::get_dot(level.player.origin, level.player.angles, var1.origin) > 0.5) {
      if(var3) {
        level.player scripts\common\utility::allow_melee(0, "heli_attack");
        var3 = 0;
      }

      if(!var2) {
        scripts\engine\sp\utility::display_hint_forced("bash_hint", 5, 2, level, "door_pushed");
        var2 = 1;
      }

      if(level.player meleeButtonPressed() || level.player issprinting()) {
        break;
      }

      continue;
    }

    if(!var3) {
      level.player scripts\common\utility::allow_melee(1, "heli_attack");
    }
  }

  if(!var3) {
    level.player scripts\common\utility::allow_melee(1, "heli_attack");
  }

  level.hadir stopsounds();
  level.price stopsounds();
  level notify("door_pushed");
  setup_hallway_scriptables();
  scripts\sp\player_rig::link_player_to_rig(undefined, "stand", 0, 0, 0, 0, 0, 0, 0, 1);
  var0 thread scripts\sp\player_rig::anim_lerp_from_player_pos("door_push", 0.2, 0.2);
  thread unlink_player_from_rig_after_anim();
  level.player scripts\engine\utility::delaycall(0.2, &lerpviewangleclamp, 1, 0.5, 0.5, 45, 45, 30, 10);
  var0 notify("stop_loop");
  scripts\engine\utility::array_thread(level.friendlies, &scripts\engine\sp\utility::anim_stopanimscripted);
  var4 = [level.price, level.hadir, level.obj_door];
  var0 scripts\common\anim::anim_single(var4, "door_push");
  scripts\sp\friendlyfire::turnbackon();
  level.price.ignoreme = 0;
  level.price.ignoreall = 0;
  level.cutters show();
}

function audio_start_obj_room_fires() {
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

function player_door_wedge() {
  var0 = getEnt("player_door_wedge", "targetname");
  var1 = scripts\engine\utility::getStruct(var0.target, "targetname");
  var2 = scripts\engine\utility::getStruct(var1.target, "targetname");
  var3 = var1 scripts\engine\utility::spawn_tag_origin();
  var0 linkTo(var3);
  var0 solid();
  var3 moveTo(var2.origin, 4);
  level waittill("door_pushed");
  var3 delete();
  var0 delete();
}

function unlink_player_from_rig_after_anim() {
  level.player_rig waittillmatch("single anim", "end");
  scripts\sp\player_rig::unlink_player_from_rig();
}

function friendlies_at_door(var0) {
  level endon("door_pushed");
  level.price waittillmatch("single anim", "end");
  var0 thread scripts\common\anim::anim_loop(level.friendlies, "door_push_idle");
}

function vo_heli_attack() {
  waitframe();
  level.escape_heli.pilot scripts\engine\utility::delaythread(5, &scripts\engine\sp\utility::smart_dialogue_generic, "dx_vom_ru2_heli_callout_50");
  scripts\engine\utility::delaythread(7, &scripts\sp\maps\estate\estate_util::price_line, "dx_vom_pri_obj_room_plans_191");
  level waittill("end_cover_loop");
  wait 1;
  scripts\sp\maps\estate\estate_util::kyle_line("dx_vom_kyle_obj_room_plans_220");
  scripts\engine\utility::delaythread(2, &heli_attack_objective);
  scripts\engine\utility::flag_set_delayed("obj_room_vo_complete", 5);
  scripts\engine\utility::flag_wait("door_push_start");
  level endon("door_pushed");
  level.player endon("death");
  var0 = ["dx_vom_pri_obj_room_plans_295", "dx_vom_pri_obj_room_plans_290"];

  foreach(var2 in var0) {
    wait 5;
    scripts\sp\maps\estate\estate_util::price_line(var2);
    wait 5;
  }
}

function turn_off_lights() {
  foreach(var1 in level.fuseboxes) {
    if(var1.script_light_switch_state) {
      var1 scripts\sp\interactables\dynolight::lightswitch_toggle();
    }

    var1 scripts\sp\interactables\dynolight::lightswitch_disable(1);
  }

  scripts\sp\maps\estate\estate_util::turn_off_floodlights();
}

function obj_room_explosion() {
  ambient_explosion();
  wait 1.5;
  ambient_explosion();
  wait 1;
}

function heli_attack_fire_progression() {
  scripts\engine\utility::delaythread(3, &scripts\engine\sp\utility::enable_trigger_with_targetname, "obj_room_fire_a");
  scripts\engine\utility::delaythread(6.5, &scripts\engine\sp\utility::disable_trigger_with_targetname, "obj_room_fire_a");
  scripts\engine\utility::delaythread(6.5, &scripts\engine\sp\utility::enable_trigger_with_targetname, "obj_room_fire_b");
  scripts\engine\utility::delaythread(30, &scripts\engine\sp\utility::disable_trigger_with_targetname, "obj_room_fire_b");
  scripts\engine\utility::delaythread(30, &scripts\engine\sp\utility::enable_trigger_with_targetname, "obj_room_fire_c");
  player_die_from_smoke_inhalation("door_pushed", 30);
}

function player_die_from_smoke_inhalation(var0, var1) {
  var2 = scripts\sp\hud_util::create_client_overlay("black", 0, level.player);
  player_die_from_smoke_inhalation_thread(var0, var1, var2);

  if(!isalive(level.player)) {
    return;
  }

  var2 fadeovertime(2);
  var2.alpha = 0;
  var2 scripts\engine\utility::delaycall(2.5, &destroy);
}

function player_die_from_smoke_inhalation_thread(var0, var1, var2) {
  level.player endon("death");
  level endon(var0);
  var3 = ["ges_ph_cough_a", "ges_ph_cough_c", "ges_ph_cough_a", "ges_ph_cough_b", "ges_ph_cough_c"];
  var4 = ["gas_player_cough_1", "gas_player_cough_3", "gas_player_cough_1", "gas_player_cough_3", "gas_player_cough_1"];
  var5 = 0;
  var6 = var1;
  var7 = gettime() + var1 * 1000;

  while(gettime() < var7) {
    var2 fadeovertime(1);
    var2.alpha = (1 - var6 / var1) * 0.75;
    var6 = (var7 - gettime()) / 1000;
    wait max(var6 * 0.25, 5);

    for(var8 = 0; !var8; var8 = level.player forceplaygestureviewmodel(var3[scripts\sp\maps\estate\estate_util::abs_int(var5 % var3.size)])) {
      waitframe();
    }

    level.player scripts\sp\anim::play_sound_at_viewheight(var4[scripts\sp\maps\estate\estate_util::abs_int(var5 % var4.size)]);
    var2 fadeovertime(1);

    if(var7 - gettime() <= 1000) {
      break;
    }

    var5++;
    var2.alpha = 0.75;
    wait 1;
  }

  var2.alpha = 1;
  level.player kill();
}

function setup_hallway_scriptables() {
  scripts\engine\utility::flag_wait("scriptables_init_complete");
  var0 = scripts\engine\utility::getStruct("hallway_run_dynlt_pointer", "targetname");
  scripts\engine\utility::array_call(var0 scripts\engine\sp\utility::get_linked_scriptables(), &setscriptablepartstate, "onoff", "hidden");

  foreach(var2 in getscriptablearray("fall_chandelier", "targetname")) {
    var2 show();
    var2 setCanDamage(1);
  }
}

function heli_attack_catchup() {
  level.animnodes["mcguffin_struct"] = scripts\engine\utility::getStruct("mcguffin_struct", "targetname");
  scripts\engine\utility::delaythread(0.05, &scripts\sp\maps\estate\estate_util::show_ents, "corridor_collapse");
  scripts\engine\utility::delaythread(0.1, &turn_off_lights);
  heli_attack_objective();
  scripts\engine\utility::exploder("stairdamage");

  if(!scripts\sp\starts::is_after_start("stairs_explosion")) {
    scripts\engine\utility::exploder("stairdamage_b");
  }

  var0 = getEnt("player_door_wedge", "targetname");
  var0 delete();
}

function hallway_run_start() {
  level.animnodes["mcguffin_struct"] = scripts\engine\utility::getStruct("mcguffin_struct", "targetname");
  spawn_escape_heli();
  scripts\sp\maps\estate\estate_util::spawn_friendlies();
  level.hadir scripts\common\ai::gun_remove();
  var0 = [level.price, level.player];
  scripts\engine\sp\utility::set_start_location("hallway_run_start", var0);
  level.price.goalradius = 32;
  thread hallway_run_start_post_load();
  thread setup_hallway_scriptables();
  scripts\engine\utility::flag_set("lighting_fire_hallways");
  setsaveddvar("TLMMOPMSK", 1);
}

function hallway_run_start_post_load() {
  waitframe();
  var0 = scripts\engine\utility::getStruct("heli_at_side_window", "targetname");
  level.escape_heli vehicle_teleport(var0.origin + (0, 0, 500), var0.angles);
}

function hallway_run_main() {
  level.player scripts\sp\player::set_player_max_health(300);
  thread player_die_from_smoke_inhalation("stairs_go", 15);
  thread scripts\sp\maps\estate\estate_util::show_ents("collapse_blocker_a");
  level.animnodes["explosion_scene"] = scripts\engine\utility::getStruct("explosion_scene", "targetname");
  scripts\engine\sp\utility::autosave_by_name("hallway_run");
  thread vo_hallway_run();
  thread scripts\sp\maps\estate\estate_infil::player_stay_behind_ai(100);
  scripts\engine\utility::array_thread(level.friendlies, &scripts\common\utility::demeanor_override, "sprint");
  level.animnodes["mcguffin_struct"] thread scripts\common\anim::anim_single(level.friendlies, "hallway_exit");
  scripts\engine\utility::array_thread(level.friendlies, &idle_at_stairs);
  scripts\engine\utility::flag_wait("stairs_go");
  level.player scripts\sp\player::set_player_max_health(level.player.maxhealth);
  scripts\engine\utility::array_thread(level.friendlies, &scripts\common\utility::clear_demeanor_override);
}

function idle_at_stairs() {
  self endon("explosion_scene_start");
  self waittillmatch("single anim", "end");

  if(self == level.price) {
    thread scripts\sp\maps\estate\estate_util::notetrack_nag(["dx_vom_pri_objroom_heliatk_80", "dx_vom_pri_objroom_heliatk_95"], "explosion_scene");
  }

  level.animnodes["explosion_scene"] thread scripts\common\anim::anim_loop_solo(self, "explosion_idle", "stop_loop_" + self.animname);
  self.in_position = 1;
}

function vo_hallway_run() {
  scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_mansion_helistairs_15");
  wait 1.5;
  scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_objroom_heliatk_70");
  wait 0.65;
  scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_mansion_helistairs_20");

  if(!scripts\engine\utility::flag("stairs_go")) {
    level.price thread scripts\sp\maps\estate\estate_util::nags_til_notify(["dx_vom_pri_objroom_heliatk_80", "dx_vom_pri_objroom_heliatk_95"], "stairs_go", 1, 5);
  }

  scripts\engine\utility::flag_wait("stairs_go");
  scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_obj_room_plans_320");
}

function hallway_run_catchup() {
  level.animnodes["explosion_scene"] = scripts\engine\utility::getStruct("explosion_scene", "targetname");
  thread scripts\sp\maps\estate\estate_util::show_ents("collapse_blocker_a");
}

function stairs_attack_start() {
  spawn_escape_heli();
  scripts\sp\maps\estate\estate_util::spawn_friendlies();
  scripts\engine\sp\utility::set_start_location("stairs_attack_start", [level.player, level.price]);
  thread hallway_run_start_post_load();
  thread scripts\sp\maps\estate\estate_infil::player_stay_behind_ai(100);
  var0 = scripts\engine\utility::getStruct("explosion_scene", "targetname");

  foreach(var2 in level.friendlies) {
    var0 thread scripts\common\anim::anim_loop_solo(var2, "explosion_idle", "stop_loop_" + var2.animname);
    var2.in_position = 1;
  }

  thread hallway_run_start_post_load();
  scripts\engine\utility::flag_set("lighting_fire_hallways");
  setsaveddvar("TLMMOPMSK", 1);
}

function stairs_attack_main() {
  scripts\engine\utility::exploder("corridorshoot");
  thread player_die_from_smoke_inhalation("explosion_scene", 15);
  thread stairs_explosion_scene();
  thread stairs_explosion_heli();
  scripts\engine\utility::flag_wait("explosion_scene");
  level.player scripts\engine\utility::delaycall(1, &playsound, "escape_stairs_explo_lr");
  level.player scripts\engine\utility::delaycall(6.2, &playsound, "escape_stairs_explo_debris_1_lr");
  level.player scripts\engine\utility::delaycall(7.3, &playsound, "escape_stairs_explo_debris_2_lr");
  thread audio_stop_obj_room_fires();
  scripts\engine\utility::flag_wait("explosion_scene_done");
  level.player setmovespeedscale(1);
  setsaveddvar("OLMLOTTLRM", 1.4);
  thread scripts\sp\maps\estate\estate_infil::shutdown_player_stay_behind_ai();
}

function audio_stop_obj_room_fires() {
  if(isDefined(level.obj_room_fire_01)) {
    level.obj_room_fire_01 thread scripts\engine\sp\utility::sound_fade_and_delete(5, 1);
  }

  wait 0.2;

  if(isDefined(level.obj_room_fire_02)) {
    level.obj_room_fire_02 thread scripts\engine\sp\utility::sound_fade_and_delete(5, 1);
  }

  wait 0.2;

  if(isDefined(level.obj_room_fire_03)) {
    level.obj_room_fire_03 thread scripts\engine\sp\utility::sound_fade_and_delete(5, 1);
  }

  wait 0.2;

  if(isDefined(level.obj_room_fire_04)) {
    level.obj_room_fire_04 thread scripts\engine\sp\utility::sound_fade_and_delete(5, 1);
  }

  wait 0.2;

  if(isDefined(level.obj_room_fire_05)) {
    level.obj_room_fire_05 thread scripts\engine\sp\utility::sound_fade_and_delete(5, 1);
  }

  wait 0.2;

  if(isDefined(level.obj_room_fire_06)) {
    level.obj_room_fire_06 thread scripts\engine\sp\utility::sound_fade_and_delete(5, 1);
  }

  wait 0.2;

  if(isDefined(level.obj_room_fire_07)) {
    level.obj_room_fire_07 thread scripts\engine\sp\utility::sound_fade_and_delete(5, 1);
  }

  wait 0.2;

  if(isDefined(level.obj_room_fire_08)) {
    level.obj_room_fire_08 thread scripts\engine\sp\utility::sound_fade_and_delete(5, 1);
  }

  level waittill("player_approaching_tunnel");

  if(isDefined(level.obj_room_fire_09)) {
    level.obj_room_fire_09 thread scripts\engine\sp\utility::sound_fade_and_delete(5, 1);
  }

  wait 0.2;

  if(isDefined(level.obj_room_fire_10)) {
    level.obj_room_fire_10 thread scripts\engine\sp\utility::sound_fade_and_delete(5, 1);
  }

  wait 0.2;

  if(isDefined(level.obj_room_fire_11)) {
    level.obj_room_fire_11 thread scripts\engine\sp\utility::sound_fade_and_delete(5, 1);
    return;
  }
}

function stairs_explosion_heli() {
  scripts\engine\sp\utility::flagwaitthread("player_in_3rdfloor_stairs", &scripts\sp\maps\estate\estate_util::show_ents, "collapse_blocker_b");
  scripts\engine\sp\utility::flagwaitthread("player_in_3rdfloor_stairs", &scripts\engine\utility::exploder, "vfxexp_stair_blocker");
  heli_spotlight_toggle(level.escape_heli, 1);
  var0 = level.animnodes["explosion_scene"];
  var1 = getstartorigin(var0.origin, var0.angles, level.scr_anim["hind"]["explosion_fire"]);
  var2 = getstartangles(var0.origin, var0.angles, level.scr_anim["hind"]["explosion_fire"]);
  nav_gotopos(level.escape_heli, var1);
  level.escape_heli settargetyaw(var2[1]);
  heli_spotlight_sweep(level.escape_heli, [level.player, var0]);
}

function stairs_explosion_scene() {
  var0 = level.animnodes["explosion_scene"];
  var1 = scripts\engine\sp\utility::spawn_anim_model("missile", var0.origin, var0.angles);
  var2 = spawn("script_model", var0.origin);
  var2 linkTo(var1, "tag_origin", (0, 0, 0), (0, 0, 0));
  var2 setModel("weapon_wm_la_juliet_missile");
  var2 hide();
  var0 scripts\common\anim::anim_first_frame_solo(var1, "explosion_fire");
  scripts\engine\utility::flag_wait("explosion_scene");
  level.player scripts\common\utility::allow_mantle(0, "stairs_explosion");
  thread mus_heli_stairs();
  heli_spotlight_toggle(level.escape_heli, 0);
  scripts\engine\utility::flag_set("lighting_fire_collapse");
  level.price stopsounds();
  thread scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_estate_helo_11");
  thread stairs_explosion_price();
  var2 show();
  thread stairs_scene_cowbell(var2);
  scripts\engine\utility::delaythread(2.55, &scripts\sp\maps\estate\estate_util::kyle_line, "dx_vom_plr_stairs_explosion_fall");
  var0 thread scripts\common\anim::anim_single_solo(level.escape_heli, "explosion_fire");
  var0 scripts\common\anim::anim_single_solo(var1, "explosion_fire");
  var3 = var1.origin;
  var1 delete();
  var4 = [];

  for(var5 = 1; var5 <= 14; var5++) {
    var4 = scripts\engine\sp\utility::spawn_anim_model("stairs_debris_" + var5);
  }

  var0 thread scripts\common\anim::anim_single(var4, "explosion_main");
  var6 = scripts\engine\utility::getStruct("stairs_destroyed_pointer", "targetname");
  var7 = var6 scripts\engine\sp\utility::get_linked_scriptables();
  scripts\engine\utility::array_call(var7, &setscriptablepartstate, "onoff", "hidden");
  scripts\engine\utility::array_call(var7, &setcandamage, 0);

  foreach(var9 in getscriptablearray("stairs_fall_chandelier", "targetname")) {
    var9 show();
    var9 setCanDamage(1);
    var9 dodamage(100, var3, level.escape_heli, undefined, "MOD_PROJECTILE", "iw8_la_sidewinder");
  }

  var0 notify("stop_loop_" + level.hadir.animname);
  level.hadir scripts\engine\sp\utility::anim_stopanimScripted();
  level.hadir notify("explosion_scene_start");

  if(isDefined(level.hadir.in_position)) {
    var0 thread scripts\common\anim::anim_single_solo(level.hadir, "explosion_main");
  }

  if(distance2dsquared(level.escape_heli.origin, level.player.origin) < distance2dsquared(level.escape_heli.origin, level.price.origin)) {
    level.price hide();
    level.price scripts\engine\utility::delaycall(3, &show);
  }

  level.player scripts\common\utility::allow_death(0);
  level.player.stairs_weapon = level.player getcurrentweapon();
  var11 = scripts\sp\player_rig::link_player_to_rig(undefined, "stand", 0, 0, 0, 0, 0, 0, 0, 1);
  var0 scripts\sp\player_rig::anim_lerp_from_player_pos("explosion_intro");
  stairs_explosion_player_hit(10);
  level.player lerpviewangleclamp(0.2, 0.1, 0.1, 25, 25, 15, 15);
  var12 = getanimlength(var11 scripts\engine\utility::getanim("explosion_main"));
  scripts\engine\utility::delaythread(var12 - 1, &stairs_explosion_player_hit, 100);
  level.player lerpfovscalefactor(0, 1.5);
  var0 scripts\common\anim::anim_single_solo(var11, "explosion_main");
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_music_and_dx", 0.3);
  setblur(100, 0);
  level.player_overlay = scripts\sp\hud_util::create_client_overlay("black", 1, level.player);
  stairs_explosion_player_hit(50);
  wait 0.2;
  var13 = scripts\engine\utility::getStruct("escape_getup", "targetname");
  var13 thread scripts\common\anim::anim_first_frame_solo(level.player_rig, "escape_getup");
  level.player clearclienttriggeraudiozone(6);

  if(level.player ispcplayer()) {
    setsaveddvar("OMNONNMOTP", "0.1 500 2.5 10000");
  }

  wait 0.05;

  foreach(var15 in var4) {
    var15 delete();
  }

  scripts\engine\utility::array_call(getEntArray("stairs_destroyed_animated", "script_noteworthy"), &show);
  level.player scripts\common\utility::allow_death(1);
  restart_rotors(level.escape_heli);
  scripts\engine\utility::flag_set("explosion_scene_done");
  level.price.disableplayeradsloscheck = 0;
  level.player scripts\common\utility::allow_mantle(1, "stairs_explosion");
}

function stairs_explosion_player_hit(var0) {
  level.player scripts\sp\utility::do_damage(var0, level.player.origin - anglesToForward(level.player.angles) * 50, level.player, undefined, "MOD_IMPACT");
  earthquake(0.55, 0.5, level.player.origin, 400);
  playrumbleonposition("grenade_rumble", level.player.origin);
}

function mus_heli_stairs() {
  setmusicstate("");
}

function stairs_explosion_price() {
  level endon("explosion_scene_done");
  level.price notify("explosion_scene_start");
  level.animnodes["explosion_scene"] notify("stop_loop_" + level.price.animname);
  level.price scripts\engine\sp\utility::anim_stopanimScripted();

  if(isDefined(level.price.in_position)) {
    level.animnodes["explosion_scene"] scripts\common\anim::anim_single_solo(level.price, "explosion_fire");
  } else {
    level.price.disableplayeradsloscheck = 1;
    level.animnodes["explosion_scene"] scripts\sp\anim::anim_reach_solo(level.price, "explosion_main");
    level.price.disableplayeradsloscheck = 0;
  }

  level.price.in_position = undefined;
  level.animnodes["explosion_scene"] scripts\common\anim::anim_single_solo(level.price, "explosion_main");
  level.price.stairs_scene_finished = 1;
}

function slowmo_yes() {
  thread scripts\engine\sp\utility::player_speed_percent(30, 1);
  level.player enableslowaim(0.5, 0.5);
  level.player setpriorityclienttriggeraudiozonepartial("deathsdoor", "deathsdoor", "reverb");
  level.player setsoundsubmix("deaths_door_sp");
  scripts\engine\sp\utility::slowmo_lerp_in();
}

function slowmo_no() {
  thread scripts\engine\sp\utility::player_speed_percent(100, 0.25);
  level.player disableslowaim();
  level.player clearpriorityclienttriggeraudiozone("deathsdoor");
  level.player clearsoundsubmix("deaths_door_sp");
  scripts\engine\sp\utility::slowmo_lerp_out();
}

function restart_rotors() {
  self notify("suspend_drive_anims");
  waittillframeend();
  thread scripts\common\vehicle_code::animate_drive_idle();
}

function stairs_scene_cowbell(var0) {
  level waittill("missile_launch");
  thread scripts\engine\utility::play_sound_in_space("weap_estate_heli_proj_launch", var0.origin);
  playFXOnTag(scripts\engine\utility::getfx("missile_muzzle"), level.escape_heli, "tag_origin");
  wait 0.15;
  playFXOnTag(scripts\engine\utility::getfx("missile_trail"), var0, "tag_fx");
  wait 0.04;
  scripts\engine\utility::exploder("vfxexp_win_break");
  getEnt("stairs_pristine_window", "script_noteworthy") hide();
  getEnt("stairs_destroyed_window", "script_noteworthy") show();
  var1 = getglassarray("breakglass");

  foreach(var3 in var1) {
    destroyglass(var3, anglesToForward((0, 360, 0)));
  }

  var5 = var0 getlinkedparent();
  var5 waittillmatch("single anim", "end");
  stopFXOnTag(scripts\engine\utility::getfx("missile_trail"), var0, "tag_fx");
  scripts\engine\utility::exploder("collapse");
  thread scripts\engine\utility::play_sound_in_space("rocket_explode", var0.origin);
  level.player scripts\sp\player::damagebloodoverlaydirectional(var0.origin, "MOD_EXPLOSIVE");
  thread scripts\engine\sp\utility::earthquake_and_rumble(var0.origin);
  playFX(scripts\engine\utility::getfx("missile_explode"), var0.origin);
  var0 delete();
  scripts\sp\maps\estate\estate_util::show_ents("stairs_destroyed", "stairs_destroyed_animated");
  scripts\sp\maps\estate\estate_util::hide_ents("stairs_pristine");
  scripts\engine\utility::exploder("collapseafter");
}

function stairs_attack_catchup() {
  thread scripts\sp\maps\estate\estate_util::show_ents("collapse_blocker_b");
  thread scripts\sp\maps\estate\estate_util::show_ents("corridorshootblocker");
  scripts\engine\utility::delaythread(0.1, &scripts\sp\maps\estate\estate_util::show_ents, "stairs_destroyed");
  scripts\engine\utility::delaythread(0.1, &scripts\sp\maps\estate\estate_util::hide_ents, "stairs_pristine");
  scripts\engine\utility::exploder("corridorshoot");
  scripts\engine\utility::exploder("collapse");
  scripts\engine\utility::exploder("collapseafter");
}

function escape_intro_start() {
  level.player_overlay = scripts\sp\hud_util::create_client_overlay("black", 1, level.player);
  setblur(100, 0);
  scripts\sp\maps\estate\estate_util::spawn_friendlies();
  thread spawn_escape_heli();
  level.player.stairs_weapon = level.player getweaponslistprimaries()[0];
  scripts\engine\utility::flag_set("lighting_escape");
  setsaveddvar("TLMMOPMSK", 1);
  var0 = scripts\engine\utility::getStruct("escape_getup", "targetname");
  var0 thread scripts\sp\player_rig::link_player_to_rig("escape_getup", "stand", 0, 0, 0, 10, 10, 5, 5, 1);
}

function escape_intro_main() {
  scripts\engine\utility::kill_exploder("vfxexp_stair_blocker");
  scripts\engine\utility::kill_exploder("vfxexp_room_smoke");
  scripts\engine\utility::flag_set("escape_intro");
  scripts\engine\utility::flag_wait("grounds_cleared");
  scripts\engine\utility::array_thread(level.friendlies, &scripts\engine\sp\utility::set_ignoreall, 1);
  scripts\engine\utility::delaythread(6.5, &scripts\engine\utility::array_thread, level.friendlies, &scripts\engine\sp\utility::set_ignoreall, 0);
  thread technical_cleanup();
  thread spawn_escape_weapons();
  scripts\engine\sp\utility::set_start_location("finale", scripts\engine\utility::array_add(level.friendlies, level.player));
  thread escape_scene_fadein();
  thread escape_intro_scene();
  thread track_player_indoors();
  scripts\engine\utility::flag_wait("escape_begin");
}

function technical_cleanup() {
  if(isDefined(level.technical)) {
    if(isalive(level.technical)) {
      level.technical notify("gunner_defeated");
      level.technical.spotlight.tag delete();
      level.technical.spotlight delete();
      level.technical.mgturret[0] delete();
    } else {
      level.technical.turret_dst delete();
    }

    level.technical delete();
    return;
  }
}

function escape_cine_dof(var0) {
  level.price scripts\engine\utility::delaythread(0.1, &scripts\engine\sp\utility::dof_enable_autofocus, 1.2, 4, undefined, undefined, "tag_eye", undefined, 1);
  level.price scripts\engine\utility::delaythread(11, &scripts\engine\sp\utility::dof_enable_autofocus, 1.2, 3, undefined, undefined, "j_ball_ri", undefined, 1);
  var0 scripts\engine\utility::delaythread(12, &scripts\engine\sp\utility::dof_enable_autofocus, 0.7, 4, undefined, undefined, "tag_eye", undefined, 1);
  level.hadir scripts\engine\utility::delaythread(13.5, &scripts\engine\sp\utility::dof_enable_autofocus, 0.7, 4, undefined, undefined, "tag_eye", undefined, 1);
  var0 scripts\engine\utility::delaythread(15, &scripts\engine\sp\utility::dof_enable_autofocus, 0.7, 6, undefined, undefined, "tag_eye", undefined, 1);
  level.price scripts\engine\utility::delaythread(17, &scripts\engine\sp\utility::dof_enable_autofocus, 1.4, 3, undefined, undefined, "tag_eye", undefined, 1);
  level.hadir scripts\engine\utility::delaythread(20, &scripts\engine\sp\utility::dof_enable_autofocus, 1.4, 3, undefined, undefined, "tag_eye", undefined, 1);
  level.price scripts\engine\utility::delaythread(23, &scripts\engine\sp\utility::dof_enable_autofocus, 1.7, 500, undefined, undefined, "tag_eye", undefined, 1);
  level.hadir scripts\engine\utility::delaythread(30, &scripts\engine\sp\utility::dof_enable_autofocus, 2, 500, undefined, undefined, "tag_eye", undefined, 1);
  level scripts\engine\utility::delaythread(32, &scripts\engine\sp\utility::dof_disable_autofocus);
}

function escape_intro_scene() {
  var0 = scripts\engine\utility::getStruct("escape_getup", "targetname");
  var1 = getanimlength(level.scr_anim["player_rig"]["escape_getup"]);
  var2 = [];
  level.hadir.animname = "ally1";

  if(!isDefined(level.price.stairs_scene_finished)) {
    scripts\sp\anim::anim_reach_cleanup_solo(level.price);
    level.price scripts\engine\sp\utility::anim_stopanimScripted();
  } else {
    level.price.stairs_scene_finished = undefined;
  }

  var3 = scripts\engine\sp\utility::spawn_anim_model("getup_debris", var0.origin, var0.angles);
  var2 = var3;
  var4 = scripts\engine\sp\utility::spawn_anim_model("getup_board", var0.origin, var0.angles);
  var2 = var4;
  var2 = scripts\engine\utility::array_combine([level.price, level.player_rig, level.hadir], var2);
  var5 = "iw8_ar_asierra12";
  var6 = ["gripvert", "laserir", "reflex_east02"];
  var7 = var5;

  foreach(var9 in var6) {
    var7 += "+" + var9;
  }

  var11 = scripts\engine\sp\utility::spawn_targetname("getup_enemy", 1);
  var12 = getanimlength(var11 scripts\engine\utility::getanim("escape_getup"));
  thread getupenemy_logic(var11);
  var11 scripts\anim\shared::forceuseweapon(var7, "primary");
  var11 scripts\sp\utility::context_melee_allow(0);
  level.getupenemy = var11;
  var11 attach("weapon_wm_me_soscar_knife", "tag_accessory_left");
  var2 = var11;
  var13 = scripts\engine\sp\utility::spawn_targetname("getup_aq", 1);
  var13.animname = "aq1";
  var2 = var13;
  level.player.ignoreme = 1;
  level.player enableinvulnerability();
  level.cutters scripts\engine\utility::delaycall(3, &hide);
  level.cutters scripts\engine\utility::delaycall(var1, &show);
  var3 scripts\engine\utility::delaycall(var1, &delete);
  var4 scripts\engine\utility::delaycall(var1, &delete);
  level.player scripts\engine\utility::delaythread(var1, &player_post_getup);
  scripts\engine\utility::delaythread(var1, &escape_objective);
  scripts\engine\utility::delaythread(5, &smoke_lasers);
  scripts\engine\utility::delaythread(var1 - 3, &scripts\engine\sp\utility::array_spawn_targetname, "escape_start_enemies", 1);
  scripts\engine\utility::delaythread(var1, &ally_equipment_init);
  scripts\engine\utility::delaythread(10.95, &slam_price);
  thread escape_cine_dof(var11);
  var0 scripts\common\anim::anim_single(var2, "escape_getup");
  level.hadir thread scripts\common\ai::gun_recall();
  scripts\engine\utility::flag_set("escape_begin");
  swap_player_ar(var5, var6);
  thread scripts\sp\maps\estate\estate_util::delete_at_distance_to_player(var13.origin, 2000, [var13]);

  foreach(var15 in level.player getweaponslistprimaries()) {
    level.player scripts\engine\sp\utility::giveweaponmaxammo(var15);
    LOC_000002c1:
  }

  scripts\engine\utility::delaythread(2, &scripts\engine\sp\utility::autosave_by_name, "escape");
}

function slam_price() {
  level.price playRumbleOnEntity("heavy_1s");
  earthquake(0.75, 0.5, level.price.origin, 100);
  scripts\engine\utility::exploder("vfxexp_bodyslam");
  scripts\engine\utility::kill_exploder("stairdamage");
  scripts\engine\utility::kill_exploder("stairdamage_b");
}

function getupenemy_logic(var0) {
  spets_nvgs_on();
  wait var0 - 0.05;
  self.a.nodeath = 1;
  self.allowdeath = 1;
  scripts\common\ai::gun_remove();
  self kill();
}

function player_post_getup() {
  level.player.ignoreme = 0;
  level.player disableinvulnerability();
  scripts\sp\player_rig::unlink_player_from_rig(0, "stand");
  scripts\engine\sp\utility::battlechatter_on();
  setmusicstate("mx_tmp_estate_grounds_infil");
  wait 35;
  setmusicstate("");
}

function ally_equipment_init() {
  scripts\sp\maps\estate\estate_util::make_alias_group("flash_request", ["dx_vom_kyle_escape_offhand_10", "dx_vom_kyle_escape_offhand_30", "dx_vom_kyle_escape_offhand_50"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("flash_response", ["dx_vom_pri_escape_offhand_20", "dx_vom_pri_escape_offhand_40", "dx_vom_pri_escape_offhand_60"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("molotov_request", ["dx_vom_kyle_escape_offhand_90", "dx_vom_kyle_escape_offhand_110", "dx_vom_kyle_escape_offhand_70"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("molotov_response", ["dx_vom_had_escape_offhand_80", "dx_vom_had_escape_offhand_100", "dx_vom_had_escape_offhand_120"]);
  level.player endon("death");
  level endon("player_approaching_tunnel");
  GscBinSkip4(0x6e, level.price, "flash", &secondaryoffhandbuttonpressed, &scripts\sp\maps\estate\estate_util::price_line);
}

function ally_equipment_think(var0, var1, var2) {
  self.support_equipment = 0;
  self.next_equipment_time = 0;
  thread scripts\sp\player\ally_equipment::ally_equipment_backpack(self, var0);

  for(;;) {
    if(istrue(self.refill_used)) {
      return;
    }

    if(gettime() >= self.next_equipment_time) {
      if(!level.player getweaponammoclip(var0) && !self.support_equipment) {
        GscBinSkip4(0x35, var0);
      }

      if(level.player builtin[[var1]]() && !level.player isthrowingbackgrenade()) {
        while(level.player builtin[[var1]]()) {
          waitframe();
        }

        if(level.player getweaponammoclip(var0)) {
          level.player waittill("offhand_fired");
        }

        if(!level.player getweaponammoclip(var0)) {
          if(!self.support_equipment) {
            GscBinSkip4(0x35, var0);
          }

          scripts\sp\maps\estate\estate_util::kyle_line(scripts\sp\maps\estate\estate_util::get_next_alias_in_group(var0 + "_request"));
          GscBinSkip1(0x74, var2, scripts\sp\maps\estate\estate_util::get_next_alias_in_group(var0 + "_response"));
        }
      }
    }

    waitframe();
    waittillframeend();
  }
}

function give_ally_equipment(var0) {
  self.support_equipment = 4;

  while(self.support_equipment) {
    waitframe();
  }

  self.next_equipment_time = gettime() + 30000;

  if(!isDefined(self.refill_used)) {
    self.refill_used = 0;
    return;
  }

  self.refill_used = 1;
}

function swap_player_ar(var0, var1) {
  level.player takeweapon(level.player.stairs_weapon);
  var2 = scripts\sp\utility::make_weapon(var0, var1);
  level.player giveweapon(var2, 0, 0, 0, 1);
  level.player scripts\engine\sp\utility::giveweaponmaxammo(var2);
  level.player switchtoweapon(var2);
}

function escape_objective() {
  var0 = scripts\engine\utility::getStruct("tunnel_obj", "targetname");
  scripts\engine\sp\objectives::objective_set_position("estate", var0.origin);
  scripts\engine\sp\objectives::objective_set_label("estate", &"ESTATE/OBJ_LBL_ESCAPE");
}

function escape_intro_catchup() {
  scripts\engine\utility::flag_set("escape_intro");
  scripts\engine\utility::flag_set("escape_begin");
  escape_objective();

  if(!scripts\sp\starts::is_after_start("tunnel")) {
    ally_equipment_init();
  }

  scripts\engine\sp\utility::battlechatter_on();

  if(!scripts\sp\starts::is_after_start("escape")) {
    thread track_player_indoors();
    return;
  }
}

function escape_start() {
  scripts\sp\maps\estate\estate_util::spawn_friendlies();
  thread spawn_escape_heli();
  level.player.stairs_weapon = level.player getweaponslistprimaries()[0];
  thread spawn_escape_weapons();
  scripts\engine\sp\utility::set_start_location("finale", scripts\engine\utility::array_add(level.friendlies, level.player));
  scripts\engine\sp\utility::array_spawn_targetname("escape_start_enemies", 1);
  scripts\engine\utility::flag_set("lighting_escape");
  setsaveddvar("TLMMOPMSK", 1);
}

function escape_main() {
  var0 = getEntArray("trigger_delete_recursive", "targetname");
  scripts\engine\utility::array_thread(var0, &trigger_delete_recursive);
  thread disable_exposed_nodes();
  var1 = getEntArray("escape_trig", "script_noteworthy");
  scripts\engine\utility::array_thread(var1, &escape_trig_logic);
  var2 = getEntArray("escape_color_trig", "script_noteworthy");
  scripts\engine\utility::array_thread(var2, &escape_color_trig_think);
  scripts\engine\utility::array_thread(level.friendlies, &scripts\engine\sp\utility::set_force_color, "r");
  scripts\engine\utility::array_thread(level.friendlies, &scripts\sp\maps\estate\estate_util::indoor_monitor);
  scripts\engine\utility::array_thread(level.friendlies, &escape_demeanor_think);
  scripts\engine\utility::array_thread(level.friendlies, &scripts\engine\sp\utility::set_battlechatter, 1);
  level.price.speedscalemult = 0.9;
  level.hadir.speedscalemult = 1.1;
  level.price.pushable = 1;
  level.hadir.pushable = 1;
  scripts\engine\utility::array_call(level.friendlies, &setbackupcoverfrompos, scripts\engine\utility::getStruct("tunnel_obj", "targetname").origin);
  var3 = getEnt("escape_goal_hint", "targetname");
  var3 scripts\engine\sp\utility::add_trigger_function(&escape_goal_hint_trigger);
  wait 0.5;
  level.escape_heli scripts\engine\utility::ent_flag_set("ambient_attacking");
  thread heliattackwarning();
  thread unlock_all_doors_except_arena();
  thread montior_chopperkilling_player();
  var4 = getEntArray("glass_house_heli_shield", "targetname");
  scripts\engine\utility::array_thread(var4, &heli_destructible_ceiling_logic);
  var5 = getscriptablearray("scriptable_rp_propane_tank_long_01", "classname");
  scripts\engine\utility::array_thread(var5, &heli_destructible_propane_tank_logic);
  setsaveddvar("MSOOMPMPQS", 1);
  scripts\engine\utility::flag_wait("tunnel_approach");
  setsaveddvar("MSOOMPMPQS", 0);
}

function escape_color_trig_think() {
  if(self.classname == "info_volume") {
    return;
  }

  level endon("tunnel_approach");
  self endon("death");

  for(;;) {
    self waittill("trigger", var0);
    var0.escape_trig = self;

    while(var0 istouching(self)) {
      waitframe();
    }

    var1 = level.player.origin;
    scripts\engine\utility::trigger_off();
    wait 5;

    while(distancesquared(level.player.origin, var1) < 40000) {
      waitframe();
    }

    scripts\engine\utility::trigger_on();
  }
}

function escape_demeanor_think() {
  level endon("tunnel_approach");

  for(;;) {
    scripts\engine\utility::ent_flag_wait("indoors");
    scripts\common\utility::demeanor_override("combat");
    scripts\engine\utility::ent_flag_waitopen("indoors");
    scripts\common\utility::demeanor_override("sprint");
  }
}

function trigger_delete_recursive() {
  self waittill("trigger");
  recursive_delete_targets();
}

function recursive_delete_targets() {
  if(isDefined(self.target)) {
    var0 = getEntArray(self.target, "targetname");

    foreach(var2 in var0) {
      if(isai(var2)) {
        continue;
      }

      thread recursive_delete_targets();
    }
  }

  self delete();
}

function disable_exposed_nodes() {
  level.exposed_nodes = [];
  var0 = 1;

  foreach(var2 in getallnodes()) {
    if(var0 % 10 == 0) {
      waitframe();
    }

    var0++;

    if(var2.type != "Exposed") {
      continue;
    }

    var3 = 1;

    foreach(var5 in level.interior_volumes) {
      if(ispointinvolume(var2.origin, var5)) {
        var3 = 0;
        break;
      }
    }

    if(!var3) {
      continue;
    }

    var2 disconnectnode();
    level.exposed_nodes[level.exposed_nodes.size] = var2;
  }

  scripts\engine\utility::flag_wait("tunnel_approach");

  foreach(var2 in level.exposed_nodes) {
    var2 connectnode();
  }

  level.exposed_nodes = undefined;
}

function unlock_all_doors_except_arena() {
  scripts\engine\utility::flag_wait("interactive_doors_ready");

  foreach(var1 in level.interactive_doors.ents) {
    if(scripts\engine\utility::is_equal(var1.targetname, "launcher_shed_door") || scripts\engine\utility::is_equal(var1.targetname, "heli_house_front")) {
      continue;
    }

    if(var1.locked) {
      var1 scripts\sp\door::unlock_door(1);
    }
  }
}

function track_player_indoors() {
  level.player endon("death");
  level endon("tunnel_approach");
  var0 = 1;
  GscBinSkip4(0x35);
}

function vo_escape_outdoors() {
  scripts\sp\maps\estate\estate_util::make_alias_group("heli_cover", ["dx_vom_pri_heli_cover_10", "dx_vom_pri_heli_cover_20", "dx_vom_pri_heli_cover_30", "dx_vom_pri_heli_cover_40", "dx_vom_pri_heli_cover_50"]);

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

      scripts\sp\maps\estate\estate_util::price_line(scripts\sp\maps\estate\estate_util::get_next_alias_in_group("heli_cover"));
      wait 10;
    }
  }
}

function vo_escape_indoors() {
  scripts\sp\maps\estate\estate_util::make_alias_group("escape_move", ["dx_vom_pri_tunnel_push_60", "dx_vom_pri_tunnel_push_70"]);
  scripts\sp\maps\estate\estate_util::make_alias_group("escape_move_ahead", ["dx_vom_pri_tunnel_push_10", "dx_vom_pri_tunnel_push_20", "dx_vom_pri_tunnel_push_30"]);
  var0 = scripts\engine\utility::getStruct("tunnel_obj", "targetname").origin;
  var1 = 1;

  for(;;) {
    level.player scripts\engine\utility::ent_flag_wait("indoors");
    var2 = 0;
    var3 = undefined;

    for(;;) {
      waitframe();

      if(!level.player scripts\engine\utility::ent_flag("indoors")) {
        break;
      }

      var4 = getaiarray("axis");

      if(var4.size) {
        var5 = 1;

        foreach(var7 in level.interior_volumes) {
          if(level.player istouching(var7)) {
            foreach(var9 in var4) {
              if(var9 istouching(var7)) {
                var5 = 0;
                break;
              }
            }

            break;
          }
        }

        if(!var5) {
          var2 = gettime();
          continue;
        }
      }

      if(!scripts\engine\utility::is_equal(var3, level.player.escape_trig)) {
        var2 = gettime();
        var3 = level.player.escape_trig;
        continue;
      }

      if(scripts\engine\utility::time_has_passed(var2, 10)) {
        var12 = distance(level.player.origin, var0);
        var13 = undefined;

        if(var12 - distance(level.price.origin, var0) > 128 && var12 - distance(level.hadir.origin, var0) > 128) {
          if(var1) {
            scripts\sp\maps\estate\estate_util::hadir_line("dx_vom_had_tunnel_push_40");
            var13 = "dx_vom_pri_tunnel_push_50";
            var1 = 0;
          } else {
            var13 = scripts\sp\maps\estate\estate_util::get_next_alias_in_group("escape_move_ahead");
          }
        } else {
          var13 = scripts\sp\maps\estate\estate_util::get_next_alias_in_group("escape_move");
        }

        scripts\sp\maps\estate\estate_util::price_line(var13);
        var2 = gettime();
      }
    }
  }
}

function escape_goal_hint_trigger(var0) {
  level endon("tunnel_approach");

  for(;;) {
    if(var0 istouching(self)) {
      level.player thread scripts\sp\player::focus_display_hint(0, 7);
    }

    wait 15;
  }
}

function vo_heli_sees_player(var0) {
  level.player endon("indoors");
  wait 2;

  if(var0) {
    var1 = scripts\engine\utility::random(["dx_vom_ru2_heli_callout_10", "dx_vom_ru2_heli_callout_20", "dx_vom_ru2_heli_callout_40"]);
  } else {
    var1 = scripts\engine\utility::random(["dx_vom_ru2_heli_callout_60", "dx_vom_ru2_heli_callout_70", "dx_vom_ru2_heli_callout_80"]);
  }

  level.escape_heli.pilot scripts\engine\sp\utility::smart_dialogue_generic(var1);
}

function montior_chopperkilling_player() {
  level endon("tunnel_approach");
  level.player waittill("death", var0, var1, var2, var3, var4);
  var5 = 0;

  if(scripts\engine\utility::is_equal(var0, level.escape_heli.minigun) || scripts\engine\utility::is_equal(var4, level.escape_heli.minigun)) {
    var5 = 1;
  }

  if(isDefined(var0) && scripts\engine\utility::is_equal(var0.classname, "worldspawn")) {
    var5 = 1;
  }

  if(var5) {
    scripts\sp\player_death::set_custom_death_quote(56);
    return;
  }
}

function smoke_lasers() {
  scripts\engine\utility::exploder("mansionsmokegren");
}

function spawn_escape_weapons() {
  var0 = undefined;

  foreach(var2 in scripts\engine\utility::getStructArray("escape_weapon", "targetname")) {
    if(scripts\engine\utility::is_equal(var2.script_noteworthy, "player")) {
      var0 = "weapon_" + createheadicon(level.player.stairs_weapon);
    } else {
      var0 = "weapon_iw8_ar_akilo47+back_akilo47+front_akilo47+laserir_bar+mag_akilo47+rec_akilo47";
    }

    var3 = spawn(var0, var2.origin, 1);
    var3.angles = var2.angles;
  }
}

function display_enemy_count() {
  var0 = (1, 1, 0);
  var1 = (0, 1, 0);
  var2 = (1, 0, 0);

  for(;;) {
    var3 = getaiarray("axis").size;

    if(var3 < 5) {
      var4 = var1;
    } else if(var3 < 15) {
      var4 = var0;
    } else {
      var4 = var2;
    }

    wait 0.05;
  }
}

function escape_scene_fadein() {
  level.player lerpviewangleclamp(0, 0, 0, 0, 0, 0, 0);
  setblur(0, 1);
  level.player_overlay fadeovertime(1);
  level.player_overlay.alpha = 0;
  level.player scripts\engine\utility::delaycall(5, &lerpviewangleclamp, 2, 0.5, 0.5, 45, 20, 45, 20);
  level.player shellshock("explosion_estate", 6);
  level.player scripts\engine\utility::delaycall(5, &fadeoutshellshock);
  level.player scripts\engine\utility::delaycall(28, &lerpviewangleclamp, 0.5, 0.2, 0.2, 0, 0, 0, 0);
  level.price scripts\engine\utility::delaycall(28.15, &playrumbleonentity, "light_1s");
}

function escape_catchup() {
  scripts\engine\utility::flag_set("tunnel_approach");
  thread display_enemy_count();
  thread unlock_all_doors_except_arena();
  var0 = getEntArray("trigger_delete_recursive", "targetname");
  scripts\engine\utility::array_thread(var0, &recursive_delete_targets);
}

function tunnel_start() {
  spawn_escape_heli();
  scripts\engine\utility::delaythread(0.1, &place_heli_over_player);
  scripts\sp\maps\estate\estate_util::spawn_friendlies();
  scripts\engine\sp\utility::set_start_location("tunnel_start", scripts\engine\utility::array_add(level.friendlies, level.player));
  scripts\engine\utility::array_thread(level.friendlies, &scripts\engine\sp\utility::set_force_color, "r");
  level.price.speedscalemult = 1;
  level.hadir.speedscalemult = 1.1;
  scripts\engine\utility::flag_set("lighting_escape");
  setsaveddvar("TLMMOPMSK", 1);
}

function tunnel_main() {
  thread save_after_rockets();
  level.tunnel_struct = scripts\engine\utility::getStruct("tunnel_obj", "targetname");
  thread vo_tunnel_callout();
  thread player_approach_tunnel();
  level waittill("player_approaching_tunnel");
  thread scripts\engine\sp\utility::ai_delete_when_out_of_sight(getaiarray("axis"), 500);
  var0 = getEntArray("trigger_delete_recursive", "targetname");
  scripts\engine\utility::array_thread(var0, &recursive_delete_targets);
  level.price.pushable = 0;
  level.hadir.pushable = 0;
  scripts\engine\utility::array_thread(level.friendlies, &scripts\engine\sp\utility::clear_force_color);
  scripts\engine\utility::array_thread(level.friendlies, &scripts\common\utility::demeanor_override, "sprint");
  scripts\engine\utility::array_thread(level.friendlies, &scripts\engine\sp\utility::set_ignoreall, 1);
  scripts\engine\utility::array_thread(level.friendlies, &scripts\engine\sp\utility::set_battlechatter, 0);
  scripts\engine\utility::array_thread(level.friendlies, &scripts\engine\utility::send_notify, "remove_equipment");
  scripts\engine\utility::array_call(level.friendlies, &pushplayer, 1);
  level.tunnel_animnode = scripts\engine\utility::getStruct("tunnel_animnode", "targetname");
  thread hadir_tunnel_think();
  thread price_tunnel_think();
  thread dont_let_player_die_in_tunnel();
  thread tunnel_collapse_think();
  tunnel_scene();
  level.cutters delete();
}

function vo_tunnel_callout() {
  level endon("hadir_sees_tunnel");
  level endon("start_tunnel_open");
  var0 = spawnStruct();
  var0.origin = (4629, 1799, 20);
  var0 scripts\engine\sp\utility::waittill_player_lookat(0.77, 1);
  scripts\sp\maps\estate\estate_util::kyle_line("dx_vom_kyle_tunnel_spotted_10");
}

function player_approach_tunnel() {
  level.player endon("death");
  level.player scripts\engine\sp\utility::waittill_in_range(level.tunnel_struct.origin, level.tunnel_struct.radius);
  level.player scripts\engine\utility::ent_flag_waitopen("indoors");
  level notify("player_approaching_tunnel");
}

function save_after_rockets() {
  level endon("player_reached_drain_tunnel");

  while(istrue(level.escape_heli.trying_rockets)) {
    waitframe();
  }

  scripts\engine\sp\utility::autosave_by_name("drain_tunnel");
}

function tunnel_scene() {
  scripts\engine\utility::flag_wait_all("hadir_at_tunnel", "price_at_tunnel");
  scripts\engine\sp\utility::autosave_by_name("tunnel");
  level.tunnel_animnode notify("stop_loop");
  level.hadir scripts\engine\sp\utility::anim_stopanimScripted();
  var0 = getEnt("tunnel_gate", "targetname");
  var1 = var0 scripts\engine\utility::spawn_tag_origin();
  var1 scripts\engine\sp\utility::assign_animtree("tunnel_gate");
  var0 linkTo(var1);
  level.cutters unlink();
  level notify("start_tunnel_open");
  setmusicstate("mx_estate_tunnel_escape");
  var2 = getEnt("tunnel_chain", "targetname");
  level.tunnel_animnode scripts\common\anim::anim_single(scripts\engine\utility::array_combine(level.friendlies, [level.cutters, var1, var2]), "tunnel_open");
  level.tunnel_animnode thread scripts\common\anim::anim_loop_solo_with_nags(level.price, "tunnel_open_idle");
  scripts\engine\utility::flag_wait("player_in_tunnel");
  level waittill("tunnel_collapse");
  level.player playSound("scn_estate_tunnel_collapse_lr");
  level.player setclienttriggeraudiozone("zr_estate_tunnel_end_scene_shock", 0.5);
  level.tunnel_animnode notify("stop_loop");
  scripts\engine\utility::array_thread(level.friendlies, &scripts\engine\sp\utility::anim_stopanimscripted);
  level.tunnel_animnode thread scripts\common\anim::anim_single(level.friendlies, "tunnel_collapse");
  scripts\sp\player_rig::link_player_to_rig(undefined, "stand", 0, 0, 1);
  level.tunnel_animnode scripts\sp\player_rig::anim_lerp_from_player_pos("tunnel_collapse", undefined, 0.5);
  scripts\engine\utility::flag_set("lighting_tunnel");
}

function hadir_tunnel_think() {
  thread vo_hadir_tunnel();
  thread try_tunnel_teleport();
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

function vo_hadir_tunnel() {
  var0 = getstartorigin(level.tunnel_animnode.origin, level.tunnel_animnode.angles, level.hadir scripts\engine\utility::getanim("tunnel_approach"));
  level.hadir scripts\engine\sp\utility::waittill_in_range(var0, 128);
  var1 = distance(level.hadir.origin, level.tunnel_struct.origin);
  var2 = distance(level.player.origin, level.tunnel_struct.origin);

  if(var2 - var1 > 128) {
    level notify("hadir_sees_tunnel");
    scripts\sp\maps\estate\estate_util::hadir_line("dx_vom_had_tunnel_spotted_50");
    return;
  }
}

function price_tunnel_think() {
  thread try_tunnel_teleport(level.price);
  var0 = getnode("price_tunnel_node", "targetname");
  level.price.goalradius = 16;
  level.price.fixednode = 1;
  level.price setgoalnode(var0);
  scripts\engine\utility::flag_wait("hadir_at_tunnel");
  level.price.dontavoidplayer = 1;
  level.price.disableplayeradsloscheck = 1;
  level.tunnel_animnode scripts\sp\anim::anim_reach_solo(level.price, "tunnel_open");
  level.price.disableplayeradsloscheck = 0;
  scripts\engine\utility::flag_set("price_at_tunnel");
  level endon("tunnel_collapse");
  scripts\engine\utility::flag_wait("tunnel_open");

  if(scripts\engine\utility::flag("player_reached_drain_tunnel")) {
    scripts\engine\utility::flag_wait("player_in_tunnel");
  } else {
    thread vo_tunnel_nags();
  }

  level.tunnel_animnode notify("stop_loop");
  level.price scripts\engine\sp\utility::anim_stopanimScripted();
  level.tunnel_animnode scripts\common\anim::anim_single_solo(level.price, "tunnel_enter");
  level.tunnel_animnode thread scripts\common\anim::anim_loop_solo_with_nags(level.price, "tunnel_enter_idle");
}

function try_tunnel_teleport(var0) {
  level.player scripts\engine\sp\utility::waittill_in_range(level.tunnel_struct.origin, 800);

  if(isDefined(var0)) {
    wait var0;
  }

  var1 = distancesquared(self.origin, level.tunnel_struct.origin);

  if(var1 > distancesquared(level.player.origin, level.tunnel_struct.origin)) {
    if(!scripts\engine\math::within_fov_2d(level.player.origin, level.player.angles, self.origin, 0)) {
      var2 = scripts\engine\utility::getStructArray("tunnel_teleport_struct", "targetname");
      var2 = sortbydistance(var2, level.player.origin);
      var3 = undefined;

      foreach(var5 in var2) {
        if(scripts\engine\math::within_fov_2d(level.player.origin, level.player.angles, var5.origin, 0)) {
          continue;
        }

        if(var1 <= distancesquared(var5.origin, level.tunnel_struct.origin)) {
          continue;
        }

        var3 = var5;
        break;
      }

      if(isDefined(var3)) {
        self asmsetstate(self.asmname, "exposed_idle");
        self forceteleport(var3.origin, var3.angles, 99999);
        return;
      }

      return;
    }

    return;
  }
}

function vo_tunnel_nags() {
  level endon("tunnel_collapse");
  scripts\sp\maps\estate\estate_util::make_alias_group("tunnel_nags", ["dx_vom_pri_tunnel_spotted_80", "dx_vom_pri_tunnel_spotted_90", "dx_vom_pri_tunnel_spotted_100"]);

  for(;;) {
    level waittill("price_nag");

    if(!scripts\engine\utility::flag("player_reached_drain_tunnel") && !scripts\engine\utility::flag("player_in_tunnel")) {
      scripts\sp\maps\estate\estate_util::price_line(scripts\sp\maps\estate\estate_util::get_next_alias_in_group("tunnel_nags"));
    }
  }
}

function dont_let_player_die_in_tunnel() {
  level endon("tunnel_collapse");
  scripts\engine\utility::flag_wait("tunnel_open");

  for(;;) {
    scripts\engine\utility::flag_wait("player_in_tunnel");
    level.player scripts\common\utility::allow_death(0, "tunnel_escape");
    scripts\engine\utility::flag_waitopen("player_in_tunnel");
    level.player scripts\common\utility::allow_death(1, "tunnel_escape");
  }
}

function tunnel_collapse_think() {
  level waittill("tunnel_collapse");
  scripts\sp\maps\estate\estate_util::show_ents("tunnel_destruction");
  var0 = scripts\engine\utility::getStruct("tunnel_collapse_missile_target", "targetname");
  earthquake(1, 2, var0.origin, 1500);
}

function tunnel_catchup() {
  scripts\sp\maps\estate\estate_util::show_ents("tunnel_destruction");
}

function arrest_start() {
  scripts\sp\maps\estate\estate_util::spawn_friendlies();
  scripts\engine\sp\utility::set_start_location("arrest_start", scripts\engine\utility::array_add(level.friendlies, level.player));
  level.tunnel_animnode = scripts\engine\utility::getStruct("tunnel_animnode", "targetname");
  scripts\engine\utility::flag_set("lighting_tunnel");
}

function arrest_main() {
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
  scripts\engine\utility::delaythread(1.4, &scripts\engine\sp\objectives::objective_set_description, "estate", &"ESTATE/OBJ_DESC_HADIR");
  var0 = 1;
  arrest_scene(var0);
  scripts\engine\sp\objectives::objective_complete("estate");
  end_level(var0);
  level waittill("never");
}

function arrest_scene(var0) {
  var1 = level.tunnel_animnode scripts\sp\player_rig::link_player_to_rig("arrest_hadir", "stand", 0, undefined, 0, 10, 10, 5, 5, 1);
  level.price.name = "";
  level.hadir.name = "";
  level.hadir scripts\common\ai::gun_remove();
  var2 = getanimlength(var1 scripts\engine\utility::getanim("arrest_hadir"));
  level.player lerpfovscalefactor(0, 0.05);
  level.player fadeoutshellshock();
  level.player scripts\engine\utility::delaycall(3, &stopshellshock);
  level.player clearclienttriggeraudiozone(6);
  scripts\engine\utility::delaythread(0.4, &scripts\sp\hud_util::fade_in, 1, "black");
  scripts\engine\utility::delaythread(var2 - 21.5, &outro_letterbox);
  level.hadir scripts\engine\utility::delaycall(8.85, &playrumbleonentity, "light_1s");
  thread cine_dof();
  level.tunnel_animnode thread scripts\common\anim::anim_single(scripts\engine\utility::array_add(level.friendlies, var1), "arrest_hadir");
  wait var2 - var0;
}

function outro_letterbox() {
  level.player modifybasefov(52, 4);
  level.player lerpviewangleclamp(0.75, 0, 0, 0, 0, 0, 0);
  hidecinematicletterboxing(2, 0);
  level.player scripts\common\utility::allow_cinematic_motion(0);
}

function cine_dof() {
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

function skip_outro() {
  var0 = scripts\sp\utility::userskip_wait();

  if(!var0) {
    return;
  }

  end_level(0);
}

function end_level(var0) {
  level.player setclienttriggeraudiozone("fade_to_black", var0 + 1);
  thread scripts\sp\hud_util::fade_out(var0, "black");
  levelsoundfade(0, var0);

  if(var0 > 0) {
    wait var0 + 3;
  }

  scripts\engine\sp\utility::nextmission();
}

function spets_spawn_func() {
  self endon("death");
  self.noloot = 1;

  if(!issubstr(self.classname, "shotgun")) {
    thread scripts\sp\maps\estate\estate_util::laser_discipline();
  }

  spets_nvgs_on();

  if(isDefined(self.target)) {
    self waittill("goal");
  }

  if(istrue(self.fixednode)) {
    return;
  }

  var0 = level.interior_volumes[self.script_parameters];

  for(;;) {
    self.goalradius = self.engagemaxfalloffdist;

    while(level.player istouching(var0)) {
      self setgoalpos(level.player.origin);
      wait 5;
    }

    self setgoalvolumeauto(var0);

    while(!level.player istouching(var0)) {
      waitframe();
    }
  }
}

function spets_nvgs_on() {
  scripts\sp\maps\estate\estate_util::gesture_nvgs(1);
}

function player_is_ahead_of_me(var0) {
  var1 = distance2d(self.origin, var0);
  var2 = distance2d(level.player.origin, var0);
  return var2 < var1;
}

function stagger_ai_to_pos(var0, var1) {
  level notify("stagger_ai_to_pos");
  level endon("stagger_ai_to_pos");

  foreach(var3 in var0) {
    if(isalive(var3)) {
      thread send_to_goal_open_goalRadius(var3);
      wait 1;
    }
  }
}

function send_to_goal_open_goalRadius(var0) {
  self endon("death");
  self notify("new_merc_pos");
  self endon("new_merc_pos");
  waitframe();
  self cleargoalvolume();
  self.goalradius = randomintrange(700, 900);
  var1 = getclosestpointonnavmesh(var0);
  self setgoalpos(var1);
  self waittill("goal");
  self.goalradius = 1000;
}

function spawn_escape_heli() {
  scripts\common\vehicle::spawn_vehicle_from_targetname("enemy_heli");
}

function escape_heli_spawn_func() {
  scripts\engine\utility::ent_flag_init("ambient_attacking");
  heli_spotlight_create();
  heli_mg_create();
  self setneargoalnotifydist(400);
  self sethoverparams(25, 15, 10);
  var0 = 1000 + self.mg_z_offset;
  var1 = 2000;
  var2 = anglesToForward(level.player getplayerangles());
  var3 = var2 * var1;
  var4 = level.player.origin + var3;
  var5 = (var4[0], var4[1], var4[2] + var0);
  self.move_override = 0;
  self.is_shooting = 0;
  self.noshooting = 0;
  self.shoot_override = 0;
  level.player.target_ent = spawn("script_origin", var5);
  level.player.target_ent linkTo(level.player);
  self.godmode = 1;
  self.curr_projectile_hits = 0;
  self.animname = "hind";
  self.script_team = "axis";
  self setvehicleteam("axis");
  var6 = ["tag_missile_l_1", "tag_missile_l_2", "tag_missile_l_3", "tag_missile_l_4"];
  var7 = ["tag_missile_r_1", "tag_missile_r_2", "tag_missile_r_3", "tag_missile_r_4"];
  self.missile_laser_tags["left"] = [];
  self.missile_laser_tags["right"] = [];

  foreach(var9 in var6) {
    var10 = spawn("script_model", self gettagorigin(var9));
    var10.angles = self gettagangles(var9);
    var10 linkTo(self);
    var10 setModel("tag_laser");
    var10 setmoverlaserweapon("iw8_mindia8_turret");
    self.missile_laser_tags["left"][var9] = var10;
  }

  foreach(var9 in var7) {
    var10 = spawn("script_model", self gettagorigin(var9));
    var10.angles = self gettagangles(var9);
    var10 linkTo(self);
    var10 setModel("tag_laser");
    var10 setmoverlaserweapon("iw8_mindia8_turret");
    self.missile_laser_tags["right"][var9] = var10;
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

function heli_logic() {
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

function heli_event_obj_room() {
  level.escape_heli scalevolume(0, 0);
  waittillframeend();
  level.escape_heli scalevolume(1, 5);
  var0 = scripts\engine\utility::getStruct("front_light_start", "targetname");
  var1 = scripts\engine\utility::getStruct(var0.target, "targetname");
  level.escape_heli.spotlight.target_ent.origin = var0.origin;
  level.escape_heli.spotlight snaptotargetentity(level.escape_heli.spotlight.target_ent);
  var2 = scripts\engine\utility::getStruct("heli_at_window", "targetname");
  thread nav_gotopos(level.escape_heli, var2.origin);

  while(!scripts\engine\utility::within_fov(level.escape_heli.origin, level.escape_heli.angles, level.player.origin, 0.5)) {
    waitframe();
  }

  setsaveddvar("TLMMOPMSK", 1);
  heli_spotlight_toggle(level.escape_heli, 1);
  level.escape_heli waittill("nav_goal");
  level.escape_heli settargetyaw(var2.angles[1]);
  level.escape_heli.minigun startbarrelspin();
  wait 2;
  thread heli_spotlight_sweep(level.escape_heli, [var0, var1]);
  wait 0.1;
  heli_shoot_obj_room(level.escape_heli);
  heli_spotlight_toggle(level.escape_heli, 0);
  scripts\engine\utility::flag_set("window_spotlight_sweep_done");
  var2 = scripts\engine\utility::getStruct("heli_over_house", "targetname");
  nav_gotopos(level.escape_heli, var2.origin);
  scripts\engine\utility::flag_wait("obj_room_vo_complete");
}

function heli_shoot_obj_room() {
  var0 = scripts\engine\utility::getStruct("front_light_start", "targetname");
  var1 = scripts\engine\utility::getStruct(var0.target, "targetname");
  var2 = scripts\engine\utility::spawn_script_origin(var0.origin, (0, 0, 0));
  self.minigun.target_ent.origin = var0.origin;
  self.minigun snaptotargetentity(self.minigun.target_ent, (0, 0, 0));
  self.minigun settargetentity(self.minigun.target_ent);
  self.minigun.target_ent playLoopSound("scn_escape_minigun_impact_bullets_interior_lp");
  self.minigun.target_ent playLoopSound("scn_escape_minigun_impact_debris_interior_lp");
  var3 = distance(var0.origin, var1.origin);
  var4 = scripts\engine\sp\utility::mph_travel_time(2.5, var3);
  level scripts\engine\utility::delaythread(var4 - 2, &scripts\engine\utility::send_notify, "end_cover_loop");
  var2 moveTo(var1.origin, var4);
  var5 = gettime() + var4 * 1000;
  scripts\engine\utility::exploder("room_scriptables");
  scripts\engine\utility::exploder("vfxexp_room_smoke");
  scripts\engine\utility::flag_set("lighting_fire_obj_room");
  scripts\engine\utility::flag_set("lighting_fire_hallways");
  thread heli_attack_fire_progression();
  level notify("heli_obj_room_start_shooting");

  while(gettime() < var5) {
    self.minigun.target_ent.origin = var2.origin + (0, 0, randomfloatrange(0, 20));
    self.minigun shootturret();
    wait 0.05;
  }

  thread scripts\engine\utility::play_sound_in_space("scn_escape_minigun_impact_debris_interior_tail", self.minigun.target_ent.origin);
  self.minigun.target_ent stoploopsound("scn_escape_minigun_impact_bullets_interior_lp");
  self.minigun.target_ent stoploopsound("scn_escape_minigun_impact_debris_interior_lp");
  var2 delete();
  self.minigun cleartargetentity(self.minigun.target_ent);
  self.noshooting = 0;
  self.minigun stopbarrelspin();
}

function obj_room_attack_cowbell(var0) {
  wait 0.1;
  var1 = [level._effect["vfx_book_stack_expl"], level._effect["vfx_book_shelf_expl_new_single"]];
  level endon("stop_obj_room_attack");
  level thread scripts\engine\sp\utility::notify_delay("stop_obj_room_attack", var0);

  for(;;) {
    var2 = vectortoangles(self.minigun.target_ent.origin - level.player.origin);
    var3 = level.player.origin + anglesToForward(var2) * randomintrange(40, 100);
    playworldsound("bullet_explode", var3);

    foreach(var5 in var1) {
      playFX(var5, var3 + scripts\engine\utility::randomvector(20));
      wait 0.05;
    }

    wait randomfloatrange(0.15, 0.25);
  }
}

function ambient_explosion() {
  var0 = randomintrange(1500, 2300);
  var1 = randomintrange(0, 1000);
  thread scripts\engine\utility::play_sound_in_space("breach_c4_expl_trans", level.player.origin + (var0, var1, 70));
  earthquake(0.7, 1, level.player.origin, 500);
  level.player playRumbleOnEntity("heavy_1s");
}

function heli_event_hallway_run() {
  var0 = scripts\engine\utility::getStruct("heli_at_side_window", "targetname");
  nav_gotopos(level.escape_heli, var0.origin);
  level.escape_heli settargetyaw(var0.angles[1]);
  scripts\engine\utility::flag_wait("player_in_spetsnaz_hallway");
  setmusicstate("mx_tmp_estate_hallwayrun");

  if(isDefined(level.player_rig)) {
    level.player_rig waittillmatch("single anim", "end");
  }

  var0 = scripts\engine\utility::getStruct("side_light_start", "targetname");
  level.escape_heli.spotlight.target_ent.origin = var0.origin;
  heli_spotlight_toggle(level.escape_heli, 1);
  thread heli_shoots_hallway();
  scripts\engine\utility::flag_wait("stairs_go");

  if(level.escape_heli.minigun.target_ent islinked()) {
    level.escape_heli.minigun.target_ent unlink();
  }

  level.escape_heli notify("hallway_shooting_done");
  heli_spotlight_toggle(level.escape_heli, 0);
  stopshooting(level.escape_heli);
  thread scripts\engine\utility::play_sound_in_space("scn_escape_minigun_impact_debris_interior_tail", self.minigun.target_ent.origin);
  self.minigun.target_ent stoploopsound("scn_escape_minigun_impact_bullets_interior_lp");
  self.minigun.target_ent stoploopsound("scn_escape_minigun_impact_debris_interior_lp");
}

function heli_shoots_hallway() {
  level endon("stairs_go");
  level.escape_heli.spotlight.target_ent.origin = scripts\engine\utility::getStruct("hallway_spotlight", "targetname").origin;
  level.escape_heli.minigun startbarrelspin();
  var0 = scripts\engine\utility::getStruct("hallway_mg_shoot_start", "targetname");
  level.escape_heli.minigun.target_ent.origin = var0.origin;
  level.escape_heli.minigun snaptotargetentity(level.escape_heli.minigun.target_ent, (0, 0, 0));
  wait 1;
  self.minigun.target_ent playLoopSound("scn_escape_minigun_impact_bullets_interior_lp");
  self.minigun.target_ent playLoopSound("scn_escape_minigun_impact_debris_interior_lp");
  scripts\engine\utility::delaythread(1.5, &scripts\sp\maps\estate\estate_util::show_ents, "corridorshootblocker");
  scripts\engine\utility::exploder("hallway_scriptables");
  scripts\engine\utility::exploder("hallway_fakeimpacts");
  GscBinSkip4(0x35);
}

function heli_murder_player_in_hallway() {
  for(;;) {
    scripts\engine\utility::flag_wait("player_in_heli_death_zone");
    level.escape_heli.minigun.target_ent linkTo(level.player, "tag_origin", (0, 0, 30), (0, 0, 0));
    scripts\engine\utility::flag_waitopen("player_in_heli_death_zone");
    level.escape_heli.minigun.target_ent unlink();
    level notify("hallway_mover_done");
  }
}

function heli_hallway_mover(var0, var1, var2) {
  level endon("player_in_heli_death_zone");
  var3 = scripts\engine\utility::spawn_script_origin(var0.origin, (0, 0, 0));
  self.minigun.target_ent.origin = var0.origin;
  self.minigun snaptotargetentity(self.minigun.target_ent, (0, 0, 0));

  while(!scripts\engine\utility::flag("stairs_go") && isDefined(var0.target)) {
    var4 = scripts\engine\utility::getStruct(var0.target, "targetname");
    var5 = distance(var0.origin, var4.origin);
    var6 = scripts\engine\sp\utility::mph_travel_time(var2, var5);
    var3 moveTo(var4.origin, var6);
    var7 = gettime() + var6 * 1000;
    var8 = (0, 0, 0);

    while(gettime() < var7) {
      var8 = (0, 0, randomfloatrange(0, var1));
      self.minigun.target_ent.origin = var3.origin + var8;
      waitframe();
    }

    var0 = var4;
  }

  var3 delete();
  self notify("hallway_mover_done");
}

function heli_minigun_shoot_til_notify(var0, var1) {
  self endon(var0);

  while(isalive(level.player)) {
    if(istrue(var1) && isDefined(self.minigun.target_ent)) {
      magicbullet("iw8_mindia8_turret", self.minigun gettagorigin("tag_flash"), self.minigun.target_ent.origin);
    } else {
      self.minigun shootturret();
    }

    wait 0.05;
  }

  stopshooting();
}

function heli_event_stairs_explosion() {
  scripts\engine\utility::flag_wait("explosion_scene_done");
}

function heli_event_escape() {
  level.escape_heli.minigun settargetentity(self.minigun.target_ent);
  thread heli_movement_escape();
  GscBinSkip4(0x35);
}

function heli_spotlight_escape() {
  level endon("player_reached_drain_tunnel");
  level.player endon("death");
  self.spotlight endon("death");
  wait 1;
  heli_spotlight_toggle(1);
  var0 = 0;

  for(;;) {
    while(self.move_override) {
      wait 0.05;
    }

    escape_player_hidden();

    if(!var0) {
      thread scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_heli_light_10");
      var0 = 1;
    }

    escape_player_exposed();
    self.noshooting = 1;
  }
}

function escape_player_hidden() {
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
    wait randomfloatrange(3, 6);

    if(self.move_override) {
      return;
    }
  }
}

function escape_player_exposed() {
  if(level.player scripts\engine\utility::ent_flag("indoors")) {
    return;
  }

  level.player endon("indoors");
  self.noshooting = 1;
  var0 = 450;
  var1 = 2;
  var2 = level.player.origin + anglesToForward(level.player.angles) * var0;
  self.spotlight.target_ent moveTo(var2, var1, var1 * 0.5, var1 * 0.5);
  wait var1;
  var3 = 0;

  for(;;) {
    if(istrue(self.spotlight.override)) {
      wait 0.05;
      continue;
    }

    var0 -= 15;
    var4 = vectortoangles(self.spotlight.target_ent.origin - level.player.origin);
    var2 = level.player.origin + anglesToForward(var4) * var0;
    self.spotlight.target_ent.origin = var2;

    if(var0 < 50) {
      var0 = randomintrange(30, 50);

      if(!var3) {
        var3 = 1;
        self setlookatent(level.player);
        self.noshooting = 0;
      }
    }

    wait 0.05;
  }
}

function escape_player_attack_think() {
  self setlookatent(level.player);
  level.player scripts\engine\utility::ent_flag_wait("indoors");
  var0 = gettime();
  var1 = gettime();

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

    if(gettime() - var0 > 8500) {
      thread vo_heli_threaten_player();
      var0 = gettime();
    }

    if(gettime() - var1 > 15000) {
      var2 = get_destructible_heli_target(900);

      if(!isDefined(var2)) {
        var2 = get_closest_car_in_front_of_player(900);
      }

      if(isDefined(var2)) {
        if(scripts\engine\utility::is_equal(var2.script_noteworthy, "rocket")) {
          var3 = heli_try_rockets(var2, 0, "dx_vom_pri_estate_helo_11");

          if(!istrue(var3)) {
            continue;
          }
        } else {
          shootambienttarget(var2);
        }

        var4 = gettime();
        level.used_destructible_targets[level.used_destructible_targets.size] = var2;
        continue;
      }
    }

    if(!istrue(self.move_override)) {
      self setlookatent(level.player);

      if(!heliisfacing(level.player)) {
        continue;
      }
    }

    if(!self.spotlight.isdead) {
      var3 = heli_try_rockets(level.player);

      if(!istrue(var3)) {
        heli_spotlight_toggle(1);

        if(level.player scripts\engine\utility::ent_flag("indoors")) {
          continue;
        }

        level notify("warn_player");
        shoottokill();
      }
    } else {
      hurtplayer();
    }

    escape_player_attack_wait();
  }
}

function vo_heli_threaten_player() {
  level.escape_heli.pilot scripts\engine\sp\utility::smart_dialogue_generic(scripts\engine\utility::random(["dx_vom_ru2_heli_callout_90", "dx_vom_ru2_heli_callout_100"]));
}

function heli_movement_escape() {
  level endon("tunnel_approach");
  scripts\engine\utility::flag_wait("escape_begin");

  for(;;) {
    while(self.move_override) {
      wait 0.1;
    }

    scripts\sp\maps\estate\estate_util::waittill_player_stops_rotating_or_timeout(5);

    while(self.move_override) {
      wait 0.1;
    }

    self notify("new_goal");
    var0 = get_ideal_heli_spot();

    if(!level.player scripts\engine\utility::ent_flag("indoors")) {
      var0 = adjustposforvisibility(var0);
    }

    if(!self.move_override) {
      heli_movetopos_and_idle(var0);
    }

    wait 0.05;
  }
}

function heli_spotlight_heli_return() {
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
    while(self.move_override) {
      waitframe();
    }

    if(level.player scripts\engine\utility::ent_flag("indoors")) {
      heli_return_spotlight_player_hidden();
    }

    heli_return_spotlight_player_exposed();
    self.noshooting = 1;
  }
}

function heli_return_spotlight_player_hidden() {
  level.player endon("indoors");

  if(!self.move_override) {
    self clearlookatent();
  }

  self.spotlight.target_ent unlink();

  for(;;) {
    if(istrue(self.spotlight.override)) {
      waitframe();
      continue;
    }

    heli_spotlight_toggle(1);
    heli_spotlight_hunt(20);
    wait randomfloatrange(1, 3);
  }
}

function heli_return_spotlight_player_exposed() {
  level.player endon("indoors");
  var0 = 800;
  var1 = level.player.origin + anglesToForward(level.player.angles) * var0;

  if(self.spotlight.active) {
    var2 = 2;
    self.spotlight.target_ent moveTo(var1, var2, var2 * 0.5, var2 * 0.5);
    wait var2;
  } else {
    self.spotlight.target_ent.origin = var1;
    wait 0.15;
    heli_spotlight_toggle(1);
  }

  var3 = 0;

  for(;;) {
    var4 = level.player.origin;
    var0 -= 15;
    var5 = vectortoangles(self.spotlight.target_ent.origin - var4);
    var1 = var4 + anglesToForward(var5) * var0;
    self.spotlight.target_ent.origin = var1;

    if(var0 < 50) {
      var0 = randomintrange(0, 50);

      if(!var3) {
        var3 = 1;
        self setlookatent(level.player);
        self.noshooting = 0;
      }
    }

    waitframe();
  }
}

function heli_spotlight_killed_heli_return() {
  self endon("death");
  level endon("start_tunnel_collapse");

  if(self.spotlight.isdead) {
    return;
  }

  self.spotlight waittill("death");
  self.noshooting = 0;
}

function heli_attack_player_heli_return() {
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

      while(!heliisfacing(level.player)) {
        wait 0.1;
      }
    }

    missplayer();
    wait randomfloatrange(3, 4);
  }
}

function heli_event_tunnel() {
  var0 = scripts\engine\utility::getStruct("heli_tunnel_struct", "targetname");
  thread assign_heli_positions(scripts\engine\utility::getStructArray(var0.target, "targetname"));
  thread heli_spotlight_heli_return();
  thread heli_spotlight_killed_heli_return();
  thread heli_attack_player_heli_return();
  level waittill("player_approaching_tunnel");
  self.noshooting = 1;
  self.shoot_override = 1;
  stopshooting();
  self notify("stop_trying_rockets");
  level.tunnel_struct scripts\engine\sp\utility::waittill_player_lookat(0.77, 0, 1, 2);
  var1 = level.player.origin + vectorNormalize(level.tunnel_struct.origin - level.player.origin) * 600;
  var2 = scripts\engine\utility::spawn_script_origin(scripts\engine\utility::drop_to_ground(var1), (0, 0, 0));
  heli_try_rockets(var2, 1);
  self.noshooting = 0;
  self.shoot_override = 0;
  scripts\engine\utility::flag_wait("tunnel_open");
  scripts\engine\utility::flag_wait("player_reached_drain_tunnel");

  if(!scripts\engine\utility::within_fov(level.player getEye(), level.player getgunangles(), level.hadir gettagorigin("j_spine4"), 0.8)) {
    waittill_player_moves_or_timeout(2);
  }

  level notify("start_tunnel_collapse");
  level.player.disabletakecoverwarning = 1;
  self.noshooting = 1;
  self.shoot_override = 1;
  stopshooting();
  var2 = scripts\engine\utility::getStruct("tunnel_collapse_missile_target", "targetname");
  thread heli_try_rockets(var2, 1, "dx_vom_pri_chopper_reattack_95", "player_entered_tunnel_gate");
  self waittill("missile_fired", var3);
  self waittill("missile_fired", var4);
  var3 waittill("death");
  scripts\engine\utility::exploder("vfxexplotunnel");
  var4 waittill("death");

  if(!scripts\engine\utility::flag("player_in_tunnel")) {
    scripts\engine\utility::exploder("vfxexpl_tunnelfail");

    if(scripts\engine\utility::flag("player_reached_drain_tunnel")) {
      level.player scripts\sp\utility::do_damage(9999, var2.origin, level.escape_heli);
    } else {
      scripts\sp\player_death::set_custom_death_quote(47);
      scripts\sp\utility::missionfailedwrapper();
    }
  }

  level notify("tunnel_collapse");
}

function waittill_player_moves_or_timeout(var0) {
  level scripts\engine\utility::delaythread(var0, &scripts\engine\utility::send_notify, "player_move_timeout");
  level endon("player_move_timeout");
  var1 = level.player.origin;

  while(level.player.origin == var1) {
    waitframe();
  }
}

function heli_damage_death() {
  scripts\engine\utility::flag_wait("escape_begin");
  scripts\sp\maps\estate\estate_util::make_alias_group("heli_damage", ["dx_vom_pri_escape_helo_10", "dx_vom_pri_escape_helo_20", "dx_vom_pri_escape_helo_30"]);

  for(;;) {
    self waittill("damage", var0, var1);

    if(scripts\engine\utility::is_equal(var1, level.player)) {
      if(shoulddoweaponnag()) {
        self.last_weapon_nag = gettime();
        thread scripts\sp\maps\estate\estate_util::price_line(scripts\sp\maps\estate\estate_util::get_next_alias_in_group("heli_damage"));
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

function shoulddoweaponnag() {
  if(!isDefined(self.last_weapon_nag)) {
    return true;
  }

  if(isDefined(self.last_weapon_nag) && gettime() - self.last_weapon_nag > 15000) {
    return true;
  }

  return false;
}

function force_save() {
  if(isDefined(level.isforcesaving)) {
    return;
  }

  level.isforcesaving = 1;
  var0 = 0;
  var1 = 10;
  var2 = level.curautosave;

  for(;;) {
    var0++;
    scripts\engine\sp\utility::autosave_by_name_thread("forceSave");

    if(level.curautosave == var2 && var0 <= var1) {
      iprintln("autosave attempt " + var0 + " failed - trying again in 1 second!");
      wait 1;
      continue;
    }

    break;
  }

  if(level.curautosave == var2) {
    iprintln("Failed to save after " + var1 + " tries! This is bad.");
  } else {
    iprintln("Save success after " + var0 + " attempts ");
  }

  level.isforcesaving = undefined;
}

function heli_pos_override_trig(var0) {
  if(!scripts\engine\utility::flag("escape_begin")) {
    return;
  }

  if(scripts\engine\utility::flag("tunnel_approach")) {
    return;
  }

  if(scripts\engine\utility::is_equal(var0, level.player)) {
    level.escape_heli.move_override = 1;
    level notify("player_moved");
    var1 = scripts\engine\utility::getStructArray(self.target, "targetname");

    if(var1.size > 1) {
      thread assign_heli_positions(level.escape_heli);
    } else {
      nav_gotopos(level.escape_heli, var1[0].origin);
      level.escape_heli settargetyaw(var1[0].angles[1]);
    }

    while(var0 istouching(self)) {
      wait 0.05;
    }

    level.escape_heli.move_override = 0;
    return;
  }
}

function assign_heli_positions(var0) {
  self notify("new_heli_positions");
  self endon("new_heli_positions");

  if(!isarray(var0)) {
    var0 = [var0];
  }

  if(var0.size == 1) {
    nav_gotopos(var0[0].origin, 47, 1);
    return;
  }

  var0 = scripts\engine\utility::array_randomize(var0);

  for(;;) {
    foreach(var2 in var0) {
      nav_gotopos(var2.origin, 50, 1);
      self setlookatent(level.player);
      var3 = randomfloatrange(3, 5);
      scripts\engine\utility::waittill_notify_or_timeout("damage", var3);
      player_fired_recently_delay();
    }
  }
}

function player_fired_recently_delay() {
  if(isDefined(level.player.last_misile_fire_time) && gettime() - level.player.last_misile_fire_time < 2500) {
    wait 2;
    return;
  }
}

function get_ideal_heli_spot() {
  var0 = scripts\engine\utility::getStruct("tunnel_obj", "targetname").origin;
  var1 = vectortoangles(var0 - level.player.origin);
  var2 = level.player.origin + anglesToForward(var1) * 2000;
  var3 = "heli_lane";
  var4 = scripts\engine\utility::getStructArray(var3, "targetname");
  var5 = [];

  foreach(var7 in var4) {
    var8 = scripts\engine\utility::getStruct(var7.target, "targetname");
    var9 = spawnStruct();
    var9.origin = pointonsegmentnearesttopoint(var7.origin, var8.origin, var2);
    var5 = var9;
  }

  var11 = sortbydistance(var5, var2)[0];
  return (var11.origin[0], var11.origin[1], level.player.target_ent.origin[2]);
}

function monitor_player_moves() {
  level.escape_heli endon("new_goal");

  for(var0 = level.player.origin;; var0 = level.player.origin) {
    wait 0.05;
    var1 = distancesquared(level.player.origin, var0);

    if(var1 > squared(150)) {
      level notify("player_moved");
    }
  }
}

function heli_movetopos_and_idle(var0) {
  thread monitor_player_moves();
  level endon("player_moved");
  nav_gotopos(var0);
  wait 4;
}

function nav_gotopos(var0, var1, var2) {
  if(!istrue(var2)) {
    self notify("new_heli_positions");
  }

  self notify("nav_new_path");
  self endon("nav_new_path");
  var3 = findpath3d(self.origin, var0);

  if(!isDefined(var3)) {
    iprintlnbold("No nav3d data for heli! Heli flying will be bad .");
    return;
  }

  var4 = 0;
  var1 = scripts\engine\utility::ter_op(isDefined(var1), var1, 37);
  self vehicle_setspeed(var1, var1 * 0.5, var1 * 0.5);

  foreach(var6 in var3) {
    if(var7 == var3.size - 1) {
      var4 = 1;
    }

    self setvehgoalpos(var6, var4);
    scripts\engine\utility::waittill_any("near_goal", "goal");
  }

  self notify("nav_goal");
}

function adjustposforvisibility(var0, var1) {
  var1 = scripts\engine\utility::ter_op(isDefined(var1), var1, level.player);

  if(var1 scripts\sp\maps\estate\estate_util::has_ceiling()) {
    var2 = 1760;
  } else {
    var2 = 2500;
  }

  var3 = scripts\engine\utility::flatten_vector(var2.origin - var1);
  var4 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0, 1, 1);

  for(;;) {
    if(!scripts\engine\trace::ray_trace_passed(var1 - (0, 0, self.mg_z_offset), var2.origin + (0, 0, 18), [self, self.minigun, self.spotlight, level.player], var4)) {
      if(var1[2] + 100 <= var2) {
        var1 += (0, 0, 100);
      } else if(distance2dsquared(var1 + var3 * 50, var2.origin) >= 250000) {
        var1 += var3 * 50;
      } else {
        return var1;
      }
    } else {
      return var1;
    }

    wait 0.05;
  }
}

function canshoottargetfrompos(var0, var1, var2) {
  if(!istrue(var2) && self.noshooting) {
    return 0;
  }

  if(isPlayer(var1) || isai(var1)) {
    var3 = var1 getEye();
  } else {
    var3 = var2.origin;
  }

  var4 = sighttracepassed(var1 - (0, 0, self.mg_z_offset), var3, 0, self);
  return var4;
}

function heli_spotlight_create() {
  var0 = "tag_spotlight";
  var1 = (0, -5, 0);
  var2 = self gettagorigin(var0);
  self.spotlight = spawnturret("misc_turret", var2, "fighter_spotlight");
  self.spotlight.angles = self gettagangles(var0);
  self.spotlight setModel("veh8_mil_air_mindia8_spotlight");
  self.spotlight linkTo(self, var0, var1, (0, 0, 0));
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

function heli_spotlight_damage_death() {
  self endon("death");
  var0 = self.spotlight;
  wait 1;

  for(;;) {
    var0 waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);

    if(scripts\engine\utility::is_equal(var2, level.player)) {
      var11 = undefined;

      if(isDefined(var10)) {
        var11 = var10.classname;
      }

      if(!isDefined(var11)) {
        continue;
      }

      if(var11 == "grenade" || var11 == "rocketlauncher") {
        if(gettime() - self.lastrocketdmgtime > 250) {
          self notify("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);
        }
      }

      heli_spotlight_toggle(0);
      self.spotlight notify("death");
      self.spotlight.isdead = 1;

      if(!self.shoot_override) {
        self.noshooting = 0;
      }

      playFXOnTag(level._effect["vfx_estate_heli_sparks"], self, "tag_spotlight");
      return;
    }
  }
}

function heli_mg_create() {
  var0 = "tag_turret";
  var1 = (-64, 0, 0);
  var2 = self gettagorigin(var0);
  self.minigun = spawnturret("misc_turret", var2, "iw8_mindia8_turret");
  self.minigun.angles = self gettagangles(var0);
  self.minigun setModel("veh8_mil_air_mindia8_turret");
  self.minigun linkTo(self, var0, (0, 0, 0), (0, 0, 0));
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

function heli_spotlight_toggle(var0) {
  if(self.spotlight.isdead) {
    var0 = 0;
  }

  if(var0 && !self.spotlight.active) {
    playFXOnTag(scripts\engine\utility::getfx("vfx_estate_chopper_enemy_spotlight_01"), self.spotlight, "tag_flash");
    self.spotlight.active = 1;
    return;
  }

  if(!var0 && self.spotlight.active) {
    stopFXOnTag(scripts\engine\utility::getfx("vfx_estate_chopper_enemy_spotlight_01"), self.spotlight, "tag_flash");
    self.spotlight.active = 0;
    return;
  }
}

function heliisfacing(var0) {
  self endon("death");
  self endon("leaving");
  var1 = 10;
  var2 = anglesToForward(self.angles);
  var3 = var0.origin - self.origin;
  var2 *= (1, 1, 0);
  var3 *= (1, 1, 0);
  var3 = vectorNormalize(var3);
  var2 = vectorNormalize(var2);
  var4 = vectordot(var3, var2);
  var5 = cos(var1);

  if(var4 >= var5) {
    return 1;
  }

  return 0;
}

function escape_player_attack_wait() {
  self endon("reattack");
  var0 = gettime();
  var1 = 5;
  var2 = 0;
  var3 = 20;

  if(scripts\engine\utility::flag("tunnel_approach")) {
    return;
  }

  while(gettime() < var0 + var1 * 1000) {
    if(level.player sprintbuttonPressed() || level.player issprinting()) {
      wait 0.25;
      continue;
    } else {
      var2++;

      if(var2 >= var3) {
        return;
      }
    }

    wait 0.05;
  }
}

function heli_spotlight_hunt(var0) {
  var1 = undefined;

  if(self.spotlight.isdead) {
    return;
  }

  var1 = getallyhelitarget();

  if(!isDefined(var1)) {
    var1 = getcovernodehelitarget();
  }

  if(isDefined(var1) && !self.spotlight.override) {
    heli_spotlight_sweep([var1], var0);
    return;
  }
}

function getcovernodehelitarget(var0, var1) {
  if(!isDefined(var0)) {
    var0 = 1500;
  }

  if(!isDefined(var1)) {
    var1 = 500;
  }

  var2 = getnodesinradius(level.player.origin, var0, var1);
  var2 = scripts\engine\utility::array_randomize(var2);

  foreach(var4 in var2) {
    if(scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var4.origin, cos(60)) && sighttracepassed(self.origin, var4.origin, 0, self)) {
      return var4;
    }
  }

  return undefined;
}

function getallyhelitarget() {
  foreach(var1 in getaiarray("allies")) {
    if(sighttracepassed(self.origin, var1.origin, 0, self)) {
      return var1;
    }
  }

  return undefined;
}

function heli_spotlight_sweep(var0, var1) {
  self notify("stop_spotlight_sweep");
  self endon("stop_spotlight_sweep");
  self.spotlight endon("death");

  if(self.spotlight.isdead) {
    return;
  }

  if(!isarray(var0)) {
    var0 = [var0];
  }

  if(var0.size > 1 && !isDefined(var1)) {
    var0 = scripts\engine\utility::array_randomize(var0);
  }

  var2 = 1;

  foreach(var4 in var0) {
    if(!isDefined(var4)) {
      waitframe();
      continue;
    }

    if(var2 && var0.size > 1) {
      self.spotlight.target_ent.origin = var4.origin;
      var2 = 0;
      continue;
    }

    var5 = distance(self.spotlight.target_ent.origin, var4.origin);

    if(!var5) {
      continue;
    }

    var6 = scripts\engine\utility::ter_op(isDefined(var1), var1, 40);
    var7 = scripts\engine\sp\utility::mph_travel_time(var6, var5);

    if(!isDefined(var1)) {
      if(var7 <= 0) {
        var7 = 1;
      } else if(var7 > 1.5) {
        var7 = 1.5;
      }
    }

    self.spotlight.target_ent moveTo(var4.origin, var7, var7 * 0.8, var7 * 0.2);
    wait var7 + randomfloatrange(0.8, 1.5);
  }
}

function heliattackwarning() {
  level endon("tunnel_approach");
  scripts\sp\maps\estate\estate_util::make_alias_group("heli_attack_warning", ["dx_vom_pri_estate_helo_14", "dx_vom_pri_estate_helo_15", "dx_vom_pri_estate_helo_16", "dx_vom_pri_estate_helo_17"]);

  for(;;) {
    level waittill("warn_player");
    scripts\sp\maps\estate\estate_util::price_line(scripts\sp\maps\estate\estate_util::get_next_alias_in_group("heli_attack_warning"));
    wait 10;
  }
}

function stopshooting() {
  self.minigun stopbarrelspin();

  if(self.is_shooting) {
    self notify("stop_shooting");
    self.shooting_target = undefined;
    self.is_shooting = 0;
    return;
  }
}

function shootambienttarget(var0) {
  if(isalive(var0)) {
    var0 endon("death");
  }

  if(self.noshooting) {
    return;
  }

  self endon("stop_shooting");
  self.is_shooting = 1;
  self.spotlight.override = 1;
  heli_spotlight_toggle(1);
  self.minigun startbarrelspin();
  wait 1.5;

  if(isDefined(var0.target)) {
    shootambient_targetspline(var0);
    return;
  }

  thread heli_spotlight_sweep([var0]);

  if(isDefined(var0.angles)) {
    var1 = 200;
    self.minigun.target_ent.origin = var0.origin + anglesToForward(var0.angles) * var1;
    self.minigun snaptotargetentity(self.minigun.target_ent, (0, 0, 0));

    for(;;) {
      var1 -= 20;
      self.minigun.target_ent.origin = var0.origin + anglesToForward(var0.angles) * var1;
      self.minigun shootturret();
      wait 0.05;

      if(distance(var0.origin, self.minigun.target_ent.origin) < 50) {
        break;
      }
    }
  }

  if(isai(var0)) {
    var2 = anglesToForward(var0.angles);
    var3 = var2 * 400;
    var4 = var3 + scripts\engine\utility::randomvector(50);
    var5 = randomintrange(30, 45);
    self.minigun startbarrelspin();
    wait 1.5;

    for(var6 = 0; var6 < var5; var6++) {
      var4 = var3 + scripts\engine\utility::randomvector(50);
      self.minigun settargetentity(var0, var4);
      self.minigun shootturret();
      wait 0.05;
    }
  } else {
    self.minigun.target_ent.origin = var6.origin;
    self.minigun snaptotargetentity(self.minigun.target_ent, (0, 0, 0));
    var5 = randomintrange(25, 35);

    for(var6 = 0; var6 < var5; var6++) {
      self.minigun shootturret();
      wait 0.05;
    }
  }

  self.minigun stopbarrelspin();
  self.is_shooting = 0;
  self.spotlight.override = 0;
}

function shootambient_targetspline(var0) {
  self.spotlight.override = 1;
  self.spotlight.target_ent.origin = var0.origin;
  self.minigun cleartargetentity();
  self.minigun snaptotargetentity(self.spotlight.target_ent, (0, 0, 0));
  waittillframeend();
  var1 = scripts\engine\utility::getStruct(var0.target, "targetname");
  thread heli_minigun_shoot_til_notify("stop_shooting_ambient_spine");
  heli_spotlight_toggle(1);
  thread scripts\engine\sp\utility::draw_line_from_ent_to_ent_for_time(self, self.spotlight.target_ent, 1, 1, 0, 5);

  for(;;) {
    var2 = scripts\engine\sp\utility::mph_travel_time(10, distance(var0.origin, var1.origin));
    self.spotlight.target_ent moveTo(var1.origin, var2);
    wait var2;
    var0 = var1;

    if(isDefined(var0.target)) {
      var1 = scripts\engine\utility::getStruct(var0.target, "targetname");
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

function missplayer() {
  if(self.noshooting) {
    return;
  }

  self endon("stop_shooting");
  self.is_shooting = 1;
  self.minigun startbarrelspin();
  wait 1.5;
  var0 = 400;
  var1 = var0 + 450;
  self.minigun.target_ent.origin = level.player.origin + anglesToForward(level.player.angles) * var1;
  self.minigun snaptotargetentity(self.minigun.target_ent, (0, 0, 0));

  for(;;) {
    var1 -= 20;
    self.minigun.target_ent.origin = level.player.origin + anglesToForward(level.player.angles) * var1;

    if(distancesquared(level.player.origin, self.minigun.target_ent.origin) < var0 * var0) {
      break;
    }

    var2 = 1;

    foreach(var4 in level.friendlies) {
      if(distancesquared(self.minigun.target_ent.origin, var4.origin) < 3600) {
        var2 = 0;
        break;
      }
    }

    if(var2) {
      var6 = scripts\engine\trace::ray_trace(self.minigun gettagorigin("tag_flash"), self.minigun.target_ent.origin, [self, self.minigun]);

      if(isDefined(var6["entity"]) && scripts\engine\utility::array_contains(level.friendlies, var6["entity"])) {
        var2 = 0;
      } else if(isDefined(var6["position"])) {
        foreach(var4 in level.friendlies) {
          if(distancesquared(var6["position"], var4.origin) < 3600) {
            var2 = 0;
            break;
          }
        }
      }
    }

    if(!var2) {
      break;
    }

    self.minigun shootturret();
    waitframe();
  }

  var9 = anglesToForward(level.player.angles);
  var10 = var9 * var0;
  var11 = var10 + scripts\engine\utility::randomvector(50);
  var12 = randomintrange(20, 30);

  for(var13 = 0; var13 < var12; var13++) {
    var11 = var10 + scripts\engine\utility::randomvector(50);
    self.minigun settargetentity(level.player, var11);
    self.minigun shootturret();
    wait 0.05;
  }

  self.minigun stopbarrelspin();
  self.is_shooting = 0;
}

function shoottokill(var0) {
  heli_shoot_player(375, 20, 120, 30, 0.25, 0.1, 0, var0);
}

function hurtplayer() {
  heli_shoot_player(500, 20, 60, 50, 0.1, 0.01, 1);
}

function heli_shoot_player(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(!istrue(var7) && self.noshooting) {
    return;
  }

  self endon("death");
  self endon("stop_shooting");
  self.minigun startbarrelspin();
  self.is_shooting = 1;
  self.shooting_target = level.player;
  wait 1.5;
  GscBinSkip4(0x35);
}

function update_target_offset() {
  self.target_offset = (0, 0, 20);
  var0 = 10;

  while(self.is_shooting) {
    waitframe();

    if(scripts\engine\trace::ray_trace_passed(self.minigun gettagorigin("tag_flash"), level.player.origin + self.target_offset, [self, self.minigun, self.spotlight, level.player])) {
      continue;
    }

    self.target_offset += (0, 0, var0);

    if(self.target_offset[2] + var0 > 60 || self.target_offset[2] + var0 < 10) {
      var0 *= -1;
    }
  }
}

function safe_to_shoot_missiles(var0) {
  if(isPlayer(var0)) {
    if(self vehicle_getspeed() > 25 || !scripts\engine\utility::within_fov(self.origin, self.angles, level.player getEye(), cos(90)) || !scripts\engine\utility::within_fov(level.player.origin, level.player.angles, self.origin, cos(65)) || distance2d(self.origin, level.player.origin) < 800) {
      return false;
    }
  } else if(isai(var0)) {
    if(!isalive(var0) || self vehicle_getspeed() > 25 || !scripts\engine\utility::within_fov(self.origin, self.angles, var0 getEye(), cos(90)) || distance2d(self.origin, var0.origin) < 800) {
      return false;
    }
  } else if(self vehicle_getspeed() > 25 || !scripts\engine\utility::within_fov(self.origin, self.angles, var0.origin, cos(90))) {
    return false;
  }

  return true;
}

function heli_try_rockets(var0, var1, var2, var3) {
  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(!var1) {
    if(self.noshooting) {
      return;
    }

    if(istrue(self.trying_rockets)) {
      return;
    }

    if(isDefined(self.last_rocket_time) && !scripts\engine\utility::time_has_passed(self.last_rocket_time, 15)) {
      return;
    }

    if(!scripts\engine\utility::time_has_passed(level.player.outdoor_time, 2)) {
      return;
    }
  }

  self.trying_rockets = 1;
  self.rockets_target = var0;
  self endon("stop_trying_rockets");
  thread cleanup_heli_rockets();

  if(!var1) {
    var4 = scripts\engine\utility::ter_op(isPlayer(var0), 5, 2);
    var5 = gettime();
    var6 = 0;

    while(gettime() < var5 + var4 * 1000) {
      var6 = safe_to_shoot_missiles(var0);

      if(var6) {
        break;
      }

      wait 0.05;
    }

    if(!var6) {
      self notify("stop_trying_rockets");
      return;
    }
  }

  var7 = scripts\engine\utility::random(["dx_vom_ru2_heli_callout_10", "dx_vom_ru2_heli_callout_20", "dx_vom_ru2_heli_callout_40"]);
  level.escape_heli.pilot thread scripts\engine\sp\utility::smart_dialogue_generic(var7);
  var8 = getrockettargetpos(var0);
  var9 = 0;

  if(!var1) {
    var10 = sortbydistance(getaiarray("axis"), var8);

    if(isDefined(var10[0]) && distancesquared(var10[0].origin, var8) < squared(400)) {
      var9 = 1;
    }
  }

  var11 = scripts\engine\utility::array_combine(level.friendlies, [self, self.minigun, self.spotlight, level.player]);
  var12 = [];

  foreach(var14 in self.missile_laser_tags) {
    foreach(var17, var16 in var14) {
      if(var1 || scripts\engine\trace::ray_trace_passed(self gettagorigin(var17), var8, var11)) {
        var12 = var16;
        break;
      }
    }
  }

  if(!var12.size || var9) {
    self notify("stop_trying_rockets");
    return;
  }

  var19 = 1.5;
  self.badplace = createnavbadplacebybounds(var8, (200, 200, 200), (0, 0, 0));
  self.spotlight.power_override = 1;
  heli_spotlight_toggle(0);
  scripts\engine\utility::delaythread(0.5, &vo_warn_missiles, var2);

  foreach(var17, var16 in var12) {
    var16 laserforceon();
    thread updatelaserangles(var16, var0, var17, var19);
  }

  if(isDefined(var3)) {
    level scripts\engine\utility::waittill_notify_or_timeout(var3, var19);
  } else {
    wait var19;
  }

  foreach(var17, var16 in var12) {
    var16 laserforceoff();
    var16 linkTo(level.escape_heli, var17);
  }

  var22 = 0;
  var23 = 0;
  var8 = getrockettargetpos(var0);

  if(!var1 && self.noshooting) {
    self notify("stop_trying_rockets");
    return;
  }

  foreach(var14 in self.missile_laser_tags) {
    foreach(var17, var16 in var14) {
      if(var1 || scripts\engine\trace::ray_trace_passed(self gettagorigin(var17), var8, var11)) {
        heli_fire_missile(var17, var8);
        var23++;
        var22 = 1;
        break;
      }
    }

    if(var22) {
      wait 0.3;
      var22 = 0;
    }
  }

  self notify("shot_rockets");
  destroynavobstacle(self.badplace);
  self.attack_turns = 0;
  self.spotlight.power_override = 0;
  self.rockets_target = undefined;
  self.trying_rockets = 0;

  if(var23) {
    self.last_rocket_time = gettime();
  }

  return 1;
}

function heli_fire_missile(var0, var1) {
  playFXOnTag(scripts\engine\utility::getfx("vfx_muz_heli_missile_single"), self, var0);
  var2 = magicbullet("iw8_la_sidewinder", self gettagorigin(var0) + anglesToForward(self.angles) * 100, var1);
  thread scripts\engine\utility::playsoundontag("weap_estate_heli_proj_launch", var0);
  thread missile_earthquakerumble();
  self notify("missile_fired", var2);
}

function cleanup_heli_rockets() {
  self endon("shot_rockets");
  self waittill("stop_trying_rockets");

  foreach(var1 in self.missile_laser_tags) {
    foreach(var3 in var1) {
      var3 laserforceoff();

      if(!var3 islinked()) {
        var3 linkTo(level.escape_heli, var4);
      }
    }
  }

  if(isDefined(self.badplace)) {
    destroynavobstacle(self.badplace);
  }

  self.spotlight.power_override = 0;
  self.rockets_target = undefined;
  self.trying_rockets = 0;
}

function vo_warn_missiles(var0) {
  if(!isDefined(var0)) {
    if(!scripts\sp\maps\estate\estate_util::alias_group_exists("warn_missiles")) {
      scripts\sp\maps\estate\estate_util::make_alias_group("warn_missiles", ["dx_vom_pri_chopper_reattack_95", "dx_vom_pri_chopper_reattack_85", "dx_vom_pri_estate_helo_11"]);
    }

    var0 = scripts\sp\maps\estate\estate_util::get_next_alias_in_group("warn_missiles");
  }

  scripts\sp\maps\estate\estate_util::price_line(var0);
}

function getrockettargetpos(var0) {
  if(isPlayer(var0)) {
    return (var0.origin + anglesToForward(var0.angles) * 50 + (0, 0, 18));
  }

  return var0.origin;
}

function updatelaserangles(var0, var1, var2, var3) {
  var4 = gettime() + var2 * 1000;
  self unlink();

  if(isalive(var0)) {
    var0 endon("death");
  }

  if(isDefined(var3)) {
    level endon(var3);
  }

  while(gettime() - var4) {
    self.origin = level.escape_heli gettagorigin(var1);
    self.angles = vectortoangles(getrockettargetpos(var0) - self.origin);
    waitframe();
  }
}

function missile_earthquakerumble() {
  var0 = self.origin;

  while(isDefined(self)) {
    var0 = self.origin;
    wait 0.1;
  }

  earthquake(0.5, 0.7, var0, 1200);
  playrumbleonposition("heavy_2s", var0);

  if(distancesquared(var0, level.player.origin) < squared(400)) {
    if(scripts\engine\utility::flag("tunnel_open")) {
      level.player shellshock("estate_heli_missile_alt", 5);
      return;
    }

    level.player shellshock("estate_heli_missile", 5);
    return;
  }
}

function get_destructible_heli_target(var0, var1) {
  var2 = scripts\engine\utility::getStructArray("heli_destructible_target", "targetname");
  var2 = sortbydistance(var2, level.player.origin);

  foreach(var4 in var2) {
    if(distancesquared(var4.origin, level.player.origin) > squared(var0)) {
      break;
    }

    if(should_shoot_destructible_target(var4, var1)) {
      return var4;
    }
  }

  return undefined;
}

function get_closest_car_in_front_of_player(var0, var1) {
  var2 = getscriptablearray();
  var3 = [];
  var4 = undefined;

  foreach(var6 in var2) {
    if(isDefined(var6.model) && issubstr(var6.model, "veh8") && var6.health > -250) {
      var3 = var6;
    }
  }

  var3 = sortbydistance(var3, level.player.origin);

  if(var3.size) {
    foreach(var9 in var3) {
      if(distancesquared(var9.origin, level.player.origin) > squared(var0)) {
        break;
      }

      if(should_shoot_destructible_target(var9, var1)) {
        return var9;
      }
    }
  }

  return undefined;
}

function should_shoot_destructible_target(var0, var1) {
  if(scripts\engine\utility::array_contains(level.used_destructible_targets, var0)) {
    return false;
  }

  if(!scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var0.origin, cos(65))) {
    return false;
  }

  if(!istrue(var1) && !canshoottargetfrompos(self.origin, var0)) {
    return false;
  }

  return true;
}

function heli_destructible_ceiling_logic() {
  self setCanDamage(1);
  self.script_health = 30000;

  for(;;) {
    self waittill("damage", var0, var1, var2, var2, var2, var2, var2, var3, var2, var4);
    self.script_health -= var0;

    if(self.script_health <= 0) {
      self delete();
      return;
    }
  }
}

function heli_destructible_propane_tank_logic() {
  while(scripts\engine\utility::is_equal(self getscriptablepartstate("base", 1), "pristine")) {
    self waittill("damage", var0, var1);

    if(var1 == level.escape_heli.minigun) {
      self setscriptablepartstate("base", "explode_estate");
      return;
    }
  }

  self setscriptablepartstate("base", "explode_estate");
}

function place_heli_over_player() {
  level.escape_heli vehicle_teleport(level.player.origin + (0, 0, 1500), level.player.angles);
}

function quietly_kill_all_axis() {
  var0 = 0;

  foreach(var2 in getaiarray("axis")) {
    var2 delete();
    var0++;

    if(var0 == 3) {
      var0 = 0;
      wait 0.05;
    }
  }

  waitframe();
  scripts\sp\maps\estate\estate_util::cleanup_all_dropped_loot();
  clearallcorpses();
  level notify("all_axis_killed");
}