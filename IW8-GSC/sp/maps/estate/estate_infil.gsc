/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\estate\estate_infil.gsc
***********************************************/

estate_infil_precache() {
  precachemodel("weapon_wm_pi_golf21_clip");
  precachemodel("misc_coiled_rope");
  getEnt("new_rappel_node", "targetname") hide();
  getEnt("rappel_anim_struct", "targetname") delete();
  scripts\engine\sp\utility::add_hint_string("light_meter", &"ESTATE/LIGHT_METER");
  precachestring(&"ESTATE/RAPPEL_HINT");
  scripts\engine\sp\utility::add_hint_string("rappel_offhands", &"ESTATE/RAPPEL_OFFHANDS");
}

ismoving() {
  return level.player getnormalizedmovement()[0] > 0;
}

estate_infil_flags() {
  scripts\engine\utility::flag_init("tall_grass_enemies");
  scripts\engine\utility::flag_init("flashlights_go");
  scripts\engine\utility::flag_init("price_poi");
  scripts\engine\utility::flag_init("light_shot");
  scripts\engine\utility::flag_init("price_gate_anim_done");
  scripts\engine\utility::flag_init("did_light_meter_hint");
  scripts\engine\utility::flag_init("fusebox_price_ready");
  scripts\engine\utility::flag_init("player_used_fusebox");
  scripts\engine\utility::flag_init("player_shot_door");
  scripts\engine\utility::flag_init("fusebox_tut_door_open");
  scripts\engine\utility::flag_init("tutorial_light_shot");
  scripts\engine\utility::flag_init("light_enemy_killed");
  scripts\engine\utility::flag_init("light_right_enemies_dead");
  scripts\engine\utility::flag_init("light_tut_hot");
  scripts\engine\utility::flag_init("light_tut_price_clear_to_shoot");
  scripts\engine\utility::flag_init("rappel_objectives");
  scripts\engine\utility::flag_init("rappel_started");
  scripts\engine\utility::flag_init("rappel_enemies_dead");
  scripts\engine\utility::flag_init("rappel_end");
}

intro_start() {
  spawn_price_infill();
}

intro_main() {
  level.player setclienttriggeraudiozone("fade_to_black", 0.01);
  setsaveddvar("LMPKPQPRMK", 0.01);
  setsaveddvar("TLMMOPMSK", 1);
  setsaveddvar("MMLNNQSTTL", 0);
  setomnvar("ui_hide_weapon_info", 1);
  scripts\engine\utility::flag_set("lighting_intro");
  thread scripts\sp\hud_util::fade_out(0, "black");
  hidecinematicletterboxing(0, 0);
  level.player scripts\common\utility::allow_cinematic_motion(0);
  level.player modifybasefov(50, 0.05);
  level.player lerpfovscalefactor(0, 0);
  wait 0.15;
  level.player setclienttriggeraudiozone("estate_intro_mix", 5.0);
  level.player scripts\engine\utility::delaycall(12.0, ::clearclienttriggeraudiozone, 1.0);
  var_0 = scripts\engine\utility::getStruct("intro_animnode", "targetname");
  var_1 = scripts\common\vehicle::spawn_vehicle_from_targetname("intro_technical");
  level.intro_technical = var_1;

  foreach(var_3 in ["left", "right"]) {
    playFXOnTag(scripts\engine\utility::getfx("vfx_estate_technical_headlight_intro_" + var_3), var_1, "tag_light_front_" + var_3);
    playFXOnTag(scripts\engine\utility::getfx("vfx_estate_technical_brakelight_intro_" + var_3), var_1, "tag_light_back_" + var_3);
  }

  var_1 scripts\engine\sp\utility::assign_animtree("technical");
  var_1.mgturret[0] delete();
  var_5 = spawn("script_model", var_1 gettagorigin("tag_turret"));
  var_5 setModel("veh8_civ_lnd_decho_rebel_mg_armored_darkblue");
  var_5 scripts\engine\sp\utility::assign_animtree("turret");
  var_6 = spawn("script_model", var_5 gettagorigin("tag_aim_animated"));
  var_6 setModel("ee_electronics_mg_searchlight");
  var_6 linkTo(var_5, "tag_aim_animated", (0, 0, 0), (0, 0, 0));
  var_7 = scripts\engine\utility::spawn_tag_origin(var_6.origin, var_6.angles);
  var_7 linkTo(var_6, "tag_origin", (7.5, -3.5, 2.5), (0, 0, 0));
  playFXOnTag(scripts\engine\utility::getfx("vfx_estate_technical_searchlight_intro"), var_7, "tag_origin");
  var_8 = scripts\engine\sp\utility::spawn_targetname("intro_technical_gunner");
  var_8.animname = "gunner";
  var_9 = getscriptablearray("intro_police_car", "targetname")[0];
  var_9 scripts\engine\sp\utility::assign_animtree("police_car");
  var_10 = scripts\engine\sp\utility::spawn_targetname("intro_kyle");
  var_10.animname = "kyle";
  var_11 = var_0 scripts\sp\player_rig::link_player_to_rig("intro", "stand", 0, undefined, 1);
  var_11 hide();
  var_11.body = var_10;
  level.player hidelegsandshadow();
  var_12 = [var_1, var_5, var_10, var_8, var_11, level.price];
  var_0 scripts\common\anim::anim_first_frame(var_12, "intro");
  var_9.origin = getstartorigin(var_0.origin, var_0.angles, var_9 scripts\engine\utility::getanim("intro"));
  var_9.angles = getstartangles(var_0.origin, var_0.angles, var_9 scripts\engine\utility::getanim("intro"));
  level.intro_ents = [var_7, var_6, var_5, var_1, var_8, var_10];
  thread skip_intro(var_0, var_9);
  var_13 = level scripts\engine\utility::waittill_notify_or_timeout_return("intro_skipped", 3);

  if(var_13 == "timeout") {
    level.intro_started = 1;
    thread scripts\sp\hud_util::fade_in(1, "black");
    var_0 thread scripts\common\anim::anim_single([var_1, var_5, var_8], "intro");
    var_9 setanim(var_9 scripts\engine\utility::getanim("intro"), 1);
    var_0 thread scripts\common\anim::anim_single([var_10, level.price], "intro");
    var_0 scripts\common\anim::anim_single_solo(var_11, "intro");
    scripts\sp\utility::userskip_stop();
    cleanup_intro_ents();
  } else
    level.player_rig waittillmatch("single anim", "end");

  level scripts\engine\sp\utility::dof_disable();
  level.price scripts\engine\sp\utility::dof_disable_autofocus();
  level.intro_technical = undefined;
  level.intro_started = undefined;
  scripts\sp\player_rig::unlink_player_from_rig();
  setsaveddvar("TLMMOPMSK", 0);
  setomnvar("ui_hide_weapon_info", 0);
}

cleanup_intro_ents() {
  if(!isDefined(level.intro_ents)) {
    return;
  }
  foreach(var_1 in level.intro_ents) {
    if(var_1 scripts\common\vehicle::isvehicle())
      scripts\engine\utility::array_delete(var_1.riders);

    var_1 delete();
  }

  level.intro_ents = undefined;
}

skip_intro(var_0, var_1) {
  var_2 = scripts\sp\utility::userskip_wait();

  if(!var_2) {
    return;
  }
  level notify("intro_skipped");
  scripts\sp\hud_util::fade_out(0);
  cleanup_intro_ents();

  if(!isDefined(level.intro_started)) {
    var_1 setanim(var_1 scripts\engine\utility::getanim("intro"), 1);
    var_0 thread scripts\common\anim::anim_single_solo(level.price, "intro");
    var_0 thread scripts\common\anim::anim_single_solo(level.player_rig, "intro");
    waitframe();
  }

  var_3 = level.price scripts\engine\utility::getanim("intro");
  var_4 = getanimlength(var_3);
  var_5 = var_4 - 1.5;
  level.price setanimtime(var_3, var_5 / var_4);

  foreach(var_7 in [level.player_rig, var_1]) {
    var_8 = var_7 scripts\engine\utility::getanim("intro");
    var_9 = getanimlength(var_8);
    var_7 setanimtime(var_8, var_5 / var_9);
  }

  level.player lerpfovscalefactor(1, 0);
  level.player_rig show();
  getrandomnodedestination(0, 0);
  thread scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_intro_forest_10");
  scripts\engine\utility::delaythread(0.05, scripts\sp\hud_util::fade_in, 0.05);
}

intro_catchup() {}

light_meter_hint(var_0) {
  if(scripts\engine\utility::flag("did_light_meter_hint")) {
    return;
  }
  if(isDefined(var_0)) {
    level thread scripts\engine\sp\utility::notify_delay("stop_light_meter_hint", var_0);
    level endon("stop_light_meter_hint");
  }

  for(;;) {
    while(!scripts\sp\nvg\nvg_player::is_nvg_on())
      waitframe();

    wait 1;

    while(scripts\sp\nvg\nvg_player::is_nvg_on()) {
      if(scripts\engine\utility::flag("stealth_spotted")) {
        scripts\engine\utility::flag_waitopen("stealth_spotted");
        wait 2;
        continue;
      }

      if(isDefined(level.price) && istrue(level.price.speaking)) {
        level.price waittill("single dialogue");
        wait 2;
        continue;
      }

      thread scripts\engine\sp\utility::display_hint_forced("light_meter", 20);
      scripts\engine\utility::flag_set("did_light_meter_hint");
      return;
    }
  }
}

tall_grass_start() {
  spawn_price_infill();
  scripts\engine\sp\utility::set_start_location("tall_grass", [level.player, level.price]);
  level.player modifybasefov(50, 0.05);
}

tall_grass_main() {
  thread infil_lightmeter();
  thread scripts\sp\maps\estate\estate_lighting.gsc::lerp_woods_sunlight();
  thread scripts\sp\maps\estate\estate_util.gsc::stealth_init();
  thread gate_light_watcher();
  thread scripts\engine\utility::exploder("millexit");
  scripts\engine\sp\objectives::objective_add("estate", "current", undefined, &"ESTATE/OBJ_DESC_FIND_ENTRANCE");
  setsaveddvar("MMLNNQSTTL", 0);
  thread tall_grass_birds();
  scripts\engine\sp\utility::flagwaitthread("price_poi", ::toggle_price_poi, 1);
  var_0 = scripts\engine\utility::getStructArray("tall_grass_spline_stayahead", "targetname");

  foreach(var_2 in var_0) {
    if(scripts\engine\utility::is_equal(var_2.script_noteworthy, "price")) {
      level.price scripts\engine\utility::delaythread(2, ::stayahead_values_tallgrass);
      level.price scripts\engine\utility::set_movement_speed(56);
      level.price thread scripts\sp\spawner::go_to_node(var_2);
      break;
    }
  }

  level.price scripts\engine\sp\utility::disable_ai_color();
  thread vo_tall_grass();
  scripts\engine\sp\utility::autosave_by_name("tall_grass");
  scripts\engine\utility::flag_wait("at_woods");
  scripts\engine\utility::stop_exploder("millexit");
  thread scripts\sp\maps\estate\estate_util.gsc::delete_noteworthy_ents("tall_grass_ent");
}

infil_lightmeter() {
  wait 0.15;
  setomnvar("ai_fulllight", 1);
  setomnvar("ai_nolight", 0.9);
}

toggle_price_poi(var_0) {
  if(var_0) {
    level.price scripts\asm\shared\utility::toggle_poiauto(1, 35, 45, -5, 0);
    level.price.aimspeedoverride = 7;
  } else {
    level.price scripts\asm\shared\utility::toggle_poiauto(0);
    level.price.aimspeedoverride = undefined;
  }
}

tall_grass_birds() {
  scripts\engine\sp\utility::trigger_wait_targetname("tall_grass_birds");
  scripts\engine\utility::exploder("birdshoot");
  scripts\engine\utility::play_sound_in_space("scn_estate_birds_fly_up", (10726, 8459, 1294));
}

tall_grass_catchup() {
  scripts\engine\sp\objectives::objective_add("estate", "current", undefined, &"ESTATE/OBJ_DESC_FIND_ENTRANCE");
  thread scripts\sp\maps\estate\estate_util.gsc::delete_noteworthy_ents("tall_grass_ent");

  if(!scripts\sp\starts::is_after_start("Woods"))
    thread scripts\sp\maps\estate\estate_lighting.gsc::lerp_woods_sunlight();

  if(!scripts\sp\starts::is_after_start("obj_room"))
    thread scripts\sp\maps\estate\estate_util.gsc::stealth_init();
}

vo_tall_grass() {
  wait 1.5;
  scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_intro_forest_60");
  thread vo_keep_up_nags("flashlights_go");
  scripts\engine\utility::flag_wait("flashlights_go");
  scripts\sp\maps\estate\estate_util.gsc::kyle_line("dx_vom_kyle_intro_forest_20");
  scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_intro_forest_30");
  scripts\sp\maps\estate\estate_util.gsc::kyle_line("dx_vom_kyle_intro_forest_40");
  scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_intro_forest_50");
  thread vo_keep_up_nags("at_woods");
}

vo_keep_up_nags(var_0, var_1) {
  level.player endon("death");

  if(isDefined(var_1)) {
    level.keep_up_nags = var_1;
    level.keep_up_nag_counter = 0;
  } else if(!isDefined(level.keep_up_nags)) {
    level.keep_up_nags = ["dx_vom_pri_woods_obj_100", "dx_vom_pri_woods_obj_110", "dx_vom_pri_woods_obj_120", "dx_vom_pri_woods_obj_130", "dx_vom_pri_woods_obj_140", "dx_vom_pri_woods_obj_150"];
    level.keep_up_nag_counter = 0;
  }

  level notify("stop_keep_up_nags");
  level endon("stop_keep_up_nags");
  wait 5;

  while(!scripts\engine\utility::flag(var_0)) {
    var_2 = vectorNormalize(level.price.velocity);

    if(distancesquared(level.player.origin, level.price.origin) < 90000 || vectordot(var_2, level.player.origin - level.price.origin) > 0) {
      waitframe();
      continue;
    }

    thread scripts\sp\maps\estate\estate_util.gsc::price_line(level.keep_up_nags[scripts\sp\maps\estate\estate_util.gsc::abs_int(level.keep_up_nag_counter % level.keep_up_nags.size)]);
    level.keep_up_nag_counter++;
    scripts\engine\utility::flag_wait_or_timeout(var_0, randomfloatrange(8, 13));
  }
}

actor_die_when_shot(var_0) {
  if(issubstr(self.animname, "ru"))
    self endon("overboard");

  if(isDefined(var_0))
    scripts\engine\utility::waittill_any("damage", "shot");
  else
    self waittill("shot");

  if(isDefined(self.magic_bullet_shield))
    scripts\common\ai::stop_magic_bullet_shield();

  self.allowdeath = 1;
  self kill();
}

price_kill(var_0, var_1) {
  level.price.ignoreall = 0;
  level.price.dontevershoot = 1;
  var_2 = level.price.gunposeoverride;
  level.price scripts\common\ai::set_gunpose("disable");
  level.price scripts\engine\sp\utility::set_favoriteenemy(var_0);
  level.price.baseaccuracy = 10;
  price_kill_logic(var_0, var_1);
  level.price.gunposeoverride = var_2;
  level.price scripts\sp\utility::stop_aiming();
  level.price.baseaccuracy = 1;
}

price_kill_logic(var_0, var_1) {
  if(!isalive(var_0)) {
    return;
  }
  var_0 endon("death");
  waittill_price_aims_or_guy_dies(var_0);
  var_2 = 1;

  if(istrue(var_1))
    var_2 = 0;

  level.price scripts\sp\utility::aim_at(var_0 getEye(), var_2, "tag_laser", 0.5);
  level.price scripts\sp\utility::link_aim_to(var_0, "tag_eye", (0, 0, 0));

  if(istrue(var_1)) {
    while(!level.price cansee(var_0))
      waitframe();

    level.price thread scripts\sp\utility::aim_at_laser_on(1);
    wait 0.1;
  }

  level.price shoot(10, var_0 getEye());
  level.price.aim_target unlink();
  waitframe();

  if(isDefined(var_0.magic_bullet_shield))
    var_0 scripts\common\ai::stop_magic_bullet_shield();

  playFXOnTag(scripts\engine\utility::getfx("vfx_blood_sniper_shot"), var_0, "tag_eye");
  var_0 playsoundatviewheight("bullet_large_flesh_head_npc");
  waitframe();
  var_0 kill(var_0 getEye(), level.price);
}

waittill_price_aims_or_guy_dies(var_0, var_1) {
  var_0 endon("death");
  var_2 = cos(10);
  var_3 = 0;
  var_4 = 0;
  var_5 = 13;

  if(!isDefined(var_1))
    var_1 = ["j_mainroot", "j_spine4", "tag_eye"];
  else if(!isarray(var_1))
    var_1 = [var_1];

  for(;;) {
    foreach(var_7 in var_1) {
      if(scripts\engine\utility::within_fov(level.price gettagorigin("tag_flash"), level.price gettagangles("tag_flash"), var_0 gettagorigin(var_7), var_2)) {
        var_4 = 1;
        break;
      }
    }

    if(var_4 && !level.price.arriving) {
      var_3++;

      if(var_3 >= var_5)
        return 1;
    } else {
      var_3 = 0;
      var_4 = 0;
    }

    waitframe();
  }
}

woods_start() {
  thread infil_lightmeter();
  spawn_price_infill();
  level.price scripts\engine\sp\utility::disable_ai_color();
  scripts\engine\sp\utility::set_start_location("woods_start", [level.player, level.price]);
  thread gate_light_watcher();
  level.player modifybasefov(50, 0.05);
  level.price stayahead_values_tallgrass();
  level.price thread scripts\sp\spawner::go_to_node(scripts\engine\utility::getStruct("friendly_woods_spline_stayahead", "targetname"));
  toggle_price_poi(1);
}

woods_main() {
  thread woods_hide_moon();
  thread gate_chain_init();
  thread vo_woods();
  thread woods_price_nvgs();
  thread scripts\engine\sp\utility::autosave_by_name("woods");
  setsaveddvar("MMLNNQSTTL", 0);
  scripts\engine\sp\utility::flagwaitthread("woods_split", ::spawn_infil_bodies);
  scripts\engine\sp\utility::flagwaitthread("woods_split", ::toggle_price_poi, 0);
  var_0 = getEnt("lerp_fov_trig", "targetname");
  var_0 thread scripts\sp\maps\estate\estate_util.gsc::lerp_fov_over_distance_trigger();
  scripts\engine\utility::flag_wait("gate_approach");
  thread scripts\sp\maps\estate\estate_util.gsc::delete_noteworthy_ents("woods_ent");
  setomnvar("ai_fulllight", 0.0015);
  setomnvar("ai_nolight", 0.001);
}

woods_hide_moon() {
  level waittill("hide_moon");
  scripts\engine\utility::array_call(getEntArray("moon", "targetname"), ::hide);
}

vo_light_nag_if_not_shot() {
  if(!scripts\engine\utility::flag("light_shot"))
    scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_woods_traverse_100");
}

vo_woods() {
  scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_woods_obj_50");
  wait 0.2;
  scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_woods_obj_60");
  thread vo_keep_up_nags("woods_split");
  scripts\engine\utility::flag_wait("woods_split");
  thread woods_gate_enemy_audio();
  wait 1.5;
  scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_woods_obj_70");
  wait 2;
  scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_woods_obj_80");
  thread vo_keep_up_nags("gate_approach");
}

woods_gate_enemy_audio() {
  thread scripts\engine\utility::play_sound_in_space("scn_estate_infil_ak_shots_fired", (8234, 6426, 1327));
}

woods_price_nvgs() {
  scripts\engine\utility::flag_wait("woods_split");
  wait 1;
  level.price scripts\sp\utility::stayahead_disable_wait();
  level.price scripts\sp\utility::stayahead_pause(1);
  level.price scripts\engine\utility::set_movement_speed(110);
  level.price.visor_down = 0;
  var_0 = undefined;

  while(!scripts\engine\utility::is_equal(var_0, "gesture_finish") || !level.price.visor_down) {
    level.price scripts\asm\gesture::ai_request_gesture("nvg_on", undefined, 999999, "nvg_gesture");
    level.price waittill("nvg_gesture", var_0);
  }

  level.price scripts\asm\asm_sp::asm_trynvgmodelswap();
  level.price scripts\sp\utility::stayahead_pause(0);
  level.price.nvgs_on = 1;
  level.price notify("nvgs_on");
}

woods_catchup() {
  thread scripts\sp\maps\estate\estate_util.gsc::delete_noteworthy_ents("woods_ent");

  if(!scripts\sp\starts::is_after_start("rappel")) {
    level.price thread scripts\sp\maps\estate\estate_util.gsc::gesture_nvgs(1);
    level.price scripts\asm\asm_sp::asm_trynvgmodelswap();
  }
}

gate_start() {
  spawn_price_infill();
  level.price.nvgs_on = 1;
  level.price stayahead_values_tallgrass(1);
  scripts\engine\sp\utility::set_start_location("bushes_start", [level.player, level.price]);
  thread gate_light_watcher();
  thread gate_chain_init();
  spawn_infil_bodies();
}

gate_main() {
  scripts\engine\sp\utility::autosave_by_name("gate");
  thread price_gate_anim();
  thread gate_nvg_hint();
  thread vo_gate();
  thread price_hot_or_not();
  setsaveddvar("MMLNNQSTTL", 0);

  if(isDefined(level.stealth)) {
    level.stealth.detect.range["hidden"]["prone"] = 400;
    level.stealth.detect.range["hidden"]["crouch"] = 800;
    level.stealth.detect.range["hidden"]["stand"] = 1500;
  }

  scripts\engine\utility::flag_wait("player_entered_bushes_gate");
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("bushes_spawners", 1);

  foreach(var_2 in var_0) {
    scripts\engine\sp\utility::add_cleanup_ent(var_2, "gate_ents");
    var_2 thread battlechatter_off_spawn_func();
    var_2 thread gate_enemy_goes_hot();
    var_2 scripts\engine\sp\utility::set_grenadeweapon("molotov flash");
    var_2 scripts\engine\sp\utility::set_grenadeammo(4);
  }

  scripts\engine\utility::array_thread(var_0, ::gate_enemy_react_to_sprinting);
  var_4 = getscriptablearray("gate_enemy_spotlight", "targetname")[0];

  if(var_4 getscriptablepartstate("onoff") != "on")
    scripts\engine\utility::array_call(var_0, ::aieventlistenerevent, "light_killed", var_4, var_4.lightpos);

  var_0 = scripts\engine\sp\utility::array_spawn_targetname("body_poker", 1);
  scripts\engine\utility::array_thread(var_0, ::body_poker_think);
  scripts\engine\utility::array_thread(var_0, ::gate_enemy_react_to_sprinting);
  scripts\engine\utility::array_thread(var_0, scripts\engine\sp\utility::set_grenadeweapon, "molotov flash");
  scripts\engine\utility::array_thread(var_0, scripts\engine\sp\utility::set_grenadeammo, 4);
  thread vo_body_poking(var_0);

  if(var_4 getscriptablepartstate("onoff") != "on")
    scripts\engine\utility::array_call(var_0, ::aieventlistenerevent, "light_killed", var_4, var_4.lightpos);

  scripts\engine\sp\utility::flagwaitthread("bushes_exit_patrol_go", scripts\engine\sp\utility::cleanup_ents_removing_bullet_shield, "gate_ents");
  scripts\engine\utility::flag_wait("nvg_off_bushes");
  thread price_stealth_reprimand();
  scripts\engine\utility::flag_set("body_drag_dumpster_go");
  scripts\engine\utility::flag_wait_any("price_gate_anim_done", "stealth_spotted");
  scripts\engine\utility::delaythread(2, ::light_meter_hint);

  if(!scripts\engine\utility::flag("stealth_spotted")) {
    level.price scripts\engine\sp\utility::clear_force_color();
    level.price scripts\engine\sp\utility::set_force_color("p");
    level.price scripts\engine\sp\utility::set_goal_radius(60);
  }

  level.price_color_trigger = 3;
  scripts\engine\utility::flag_wait("price_behind_building");
}

battlechatter_off_spawn_func() {
  self endon("death");

  while(!istrue(self.battlechatterallowed))
    wait 0.1;

  scripts\engine\sp\utility::set_battlechatter(0);
}

price_stealth_reprimand() {
  level.player endon("death");
  level endon("tutorial_light_shot");
  level endon("rappel_started");

  for(;;) {
    scripts\engine\utility::flag_wait("stealth_spotted");
    wait 1;

    if(scripts\engine\utility::flag("stealth_spotted")) {
      break;
    }
  }

  scripts\engine\utility::flag_waitopen("stealth_spotted");
  wait 1;

  if(!istrue(level.price.speaking))
    scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_woods_traverse_420");
}

spawn_infil_bodies() {
  var_0 = scripts\engine\utility::getStructArray("infil_body", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_3 = var_2 scripts\sp\maps\estate\estate_util.gsc::spawn_dead_body();
    var_3.animname = "body1";
    var_3 scripts\engine\sp\utility::assign_animtree();
    var_2 scripts\common\anim::anim_first_frame_solo(var_3, var_2.script_parameters);
    var_2.body = var_3;
  }
}

body_poker_think() {
  self.animname = "alq1";
  thread gate_enemy_goes_hot();
  scripts\engine\sp\utility::add_cleanup_ent(self, "gate_ents");
  scripts\engine\sp\utility::set_battlechatter(0);
  var_0 = self.target;
  self.target = undefined;
  scripts\engine\utility::flag_wait("nvg_off_bushes");

  while(isalive(self) && !self[[self.fnisinstealthidle]]()) {
    if(!self[[self.fnisinstealthinvestigate]]()) {
      return;
    }
    scripts\engine\utility::waittill_any("stealth_idle", "stealth_combat", "death");
  }

  if(!isalive(self)) {
    return;
  }
  while(isDefined(var_0)) {
    var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
    var_2 = var_1.script_parameters;

    if(isDefined(var_2)) {
      var_3 = var_1.body;

      for(;;) {
        var_1 thread scripts\sp\anim::anim_reach_and_approach_solo(self, var_2);
        scripts\engine\utility::waittill_any("anim_reach_complete", "stealth_investigate", "stealth_combat", "death");

        if(isalive(self) && self[[self.fnisinstealthidle]]()) {
          break;
        }

        if(!isalive(self) || self[[self.fnisinstealthcombat]]()) {
          return;
        }
        scripts\sp\anim::anim_reach_cleanup_solo(self);
        scripts\engine\utility::waittill_any("stealth_idle", "stealth_combat", "death");

        if(!isalive(self) || self[[self.fnisinstealthcombat]]())
          return;
      }

      var_1 thread scripts\common\anim::anim_single([self, var_3], var_2);
      thread scripts\engine\utility::waittillmatch_notify("single anim", "end", "scene_end");
      scripts\engine\utility::waittill_any("scene_end", "stealth_investigate", "stealth_combat", "death");

      if(!isalive(self) || !self[[self.fnisinstealthidle]]()) {
        var_3 scripts\engine\sp\utility::anim_stopanimScripted();
        var_3 startragdoll();

        if(!isalive(self)) {
          return;
        }
        scripts\engine\sp\utility::anim_stopanimScripted();
      }
    } else {
      for(var_4 = undefined; isDefined(var_1.target); var_1 = var_5) {
        var_5 = scripts\engine\utility::getStruct(var_1.target, "targetname");

        if(isDefined(var_5.script_parameters)) {
          var_4 = var_1;
          break;
        }
      }

      if(!isDefined(var_4)) {
        self.target = var_0;
        thread scripts\sp\spawner::go_to_node();
        break;
      }

      thread scripts\sp\spawner::go_to_node(var_1);

      for(;;) {
        scripts\engine\utility::waittill_any_ents(var_4, "trigger", self, "stealth_investigate", self, "stealth_combat", self, "death");

        if(!isalive(self)) {
          return;
        }
        self notify("stop_going_to_node");

        if(self[[self.fnisinstealthcombat]]()) {
          return;
        }
        if(self[[self.fnisinstealthinvestigate]]()) {
          scripts\engine\utility::waittill_any("stealth_idle", "stealth_combat", "death");

          if(!isalive(self) || self[[self.fnisinstealthcombat]]()) {
            return;
          }
          thread scripts\sp\spawner::go_to_node(var_4);
          continue;
        }

        self notify("stop_going_to_node");
        break;
      }
    }

    var_0 = var_1.target;
  }

  if(scripts\engine\utility::is_equal(self.script_noteworthy, "flashlight"))
    self.flashlightoverride = 1;

  scripts\engine\sp\utility::set_battlechatter(1);
}

vo_body_poking(var_0) {
  foreach(var_2 in var_0) {
    var_2 endon("stealth_combat");
    var_2 endon("death");
  }

  scripts\engine\utility::flag_wait("nvg_off_bushes");
  wait(randomfloatrange(0.3, 1.1));
  var_4 = ["dx_vom_aq4_woods_traverse_150", "dx_vom_aq3_woods_traverse_160", "dx_vom_aq4_woods_traverse_170", "dx_vom_aq3_woods_traverse_180", "dx_vom_aq4_woods_traverse_190", "dx_vom_aq3_woods_traverse_200", "dx_vom_aq4_woods_traverse_210"];

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_0[var_5 % 2] scripts\engine\sp\utility::smart_dialogue_generic(var_4[var_5]);
    wait(randomfloatrange(0.15, 0.25));
  }
}

gate_enemy_react_to_sprinting() {
  scripts\engine\utility::ent_flag_wait("stealth_enabled");
  self.sprintfootstepradius = 400;
  scripts\stealth\utility::set_stealth_func("event_investigate", ::gate_enemy_stealth_filter);
  scripts\stealth\utility::set_stealth_func("event_cover_blown", ::gate_enemy_stealth_filter);
}

gate_enemy_stealth_filter(var_0) {
  if(var_0.typeorig == "footstep_sprint") {
    if(!isDefined(self.footsteps_heard))
      self.footsteps_heard = 0;

    self.footsteps_heard++;

    if(self.footsteps_heard > 5)
      var_0.type = "combat";
  }

  return 0;
}

gate_enemy_goes_hot() {
  self endon("death");
  self waittill("stealth_combat");
  self.baseaccuracy = 10;
  self.attackeraccuracy = 0.1;
  self.favoriteenemy = level.player;
  self.aggressivemode = 1;
  scripts\engine\sp\utility::set_battlechatter(1);

  for(;;) {
    self getenemyinfo(level.player);
    wait 1;
  }
}

price_hot_or_not() {
  level endon("move_to_fusebox");
  level.price.ignoreall = 1;
  level.price scripts\common\utility::demeanor_override("cqb");

  for(;;) {
    scripts\engine\utility::flag_wait("stealth_spotted");
    level.price scripts\engine\sp\utility::clear_force_color();
    level.price setgoalvolumeauto(level.goalvolumes["price_hot_gate"]);
    level.price laseroff();
    level.price.ignoreall = 0;
    level.price scripts\common\utility::demeanor_override("combat");
    level.price scripts\common\ai::reset_gunpose();
    level.price.script_pushable = 1;

    if(level.price isinscriptedstate())
      level.price scripts\engine\sp\utility::anim_stopanimScripted();

    scripts\engine\utility::flag_waitopen("stealth_spotted");
    price_hot_cleanup();
  }
}

price_hot_cleanup() {
  level.price scripts\engine\sp\utility::set_force_color("p");
  level.price.ignoreall = 1;
  level.price scripts\common\utility::demeanor_override("cqb");
  level.price.script_pushable = 0;
}

price_color_trigger_set(var_0) {
  var_1 = getEnt("woods_color_trigger_" + var_0, "targetname");
  var_1 notify("trigger");
}

vo_gate() {
  level endon("stealth_spotted");
  level waittill("cut_gate");
  scripts\engine\utility::delaythread(2, scripts\sp\maps\estate\estate_util.gsc::price_line, "dx_vom_pri_woods_traverse_110");
  level waittill("gate_open");
  scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_woods_traverse_120");
  setmusicstate("mx_tmp_estate_burning_bodies");
  scripts\engine\utility::flag_wait("nvg_off_bushes");
  scripts\engine\utility::flag_wait("price_gate_anim_done");
  wait 1.3;
  scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_woods_traverse_230");
  var_0 = ["dx_vom_pri_woods_traverse_231", "dx_vom_pri_woods_traverse_232", "dx_vom_pri_woods_traverse_233"];
  childthread vo_keep_up_nags("price_behind_building", var_0);
}

#using_animtree("script_model");

price_gate_anim() {
  level endon("stealth_spotted");
  var_0 = scripts\engine\utility::getStruct("gl_walk_animnode", "targetname");

  if(!isDefined(level.price.nvgs_on))
    level.price waittill("nvgs_on");

  level.price scripts\common\ai::set_gunpose("ready");
  thread price_approach_gate(var_0);
  var_1 = [level.price, level.cutters];
  var_2 = initgate(scripts\engine\utility::getStruct("bushes_price_gate", "targetname"), "mill_gate", %est_li_040_chain_gate);
  level.price.disableplayeradsloscheck = 1;
  level.price.anglelerprate = 60;
  var_0 scripts\sp\anim::anim_reach_solo(level.price, "infil_gate_arrival");
  level.price.disableplayeradsloscheck = 0;
  level.cutters unlink();
  var_0 scripts\common\anim::anim_single(var_1, "infil_gate_arrival");
  level.price.anglelerprate = 540;
  var_0 = scripts\engine\utility::getStruct("bushes_price_gate", "targetname");

  if(!scripts\engine\utility::flag("light_shot")) {
    level.price thread scripts\sp\maps\estate\estate_util.gsc::notetrack_nag(["dx_vom_pri_woods_traverse_90", "dx_vom_pri_woods_gate_10", "dx_vom_pri_woods_gate_20", "dx_vom_pri_woods_gate_30"], "light_shot");
    var_0 thread scripts\common\anim::anim_loop(var_1, "infil_gate_idle", "stop_loop");
    level.price scripts\common\utility::lookatentity(level.player, 0);
    scripts\engine\utility::flag_wait("light_shot");
    level.price scripts\common\utility::lookatentity();
    level.price notify("stop_reaction_look");
    var_0 notify("stop_loop");
  }

  level notify("cut_gate");
  var_2.prop scripts\engine\utility::delaycall(1, ::connectpaths);
  level scripts\engine\utility::delaythread(1, ::relink_cutters_on_anim_end);
  var_0 scripts\common\anim::anim_single([level.gate_chain, var_2, level.price, level.cutters], "infil_gate_cut");
  level notify("gate_open");

  if(!scripts\engine\utility::flag("player_entered_bushes_gate")) {
    var_0 thread scripts\common\anim::anim_loop_solo(level.price, "infil_gate_halfway_idle");
    thread stop_idle_on_spotted(var_0, "stop_loop");
    scripts\engine\utility::flag_wait("player_entered_bushes_gate");
    var_0 notify("stop_loop");
  }

  var_0 scripts\common\anim::anim_single_solo(level.price, "infil_gate_halway_moveup");

  if(!scripts\engine\utility::flag("nvg_off_bushes")) {
    var_0 thread scripts\common\anim::anim_loop_solo(level.price, "infil_bush_idle");
    thread stop_idle_on_spotted(var_0, "stop_loop");
    scripts\engine\utility::flag_wait("nvg_off_bushes");
    var_0 notify("stop_loop");
  }

  scripts\engine\utility::delaythread(0.2, scripts\sp\maps\estate\estate_util.gsc::price_line, "dx_vom_pri_woods_traverse_220");
  var_0 scripts\common\anim::anim_single_solo(level.price, "infil_bush_alert");
  scripts\engine\utility::flag_set("price_gate_anim_done");
  scripts\engine\sp\utility::flagwaitthread("rappel_start", scripts\sp\maps\estate\estate_util.gsc::delete_at_distance_to_player, var_2.origin, 1500, [var_2, var_2.prop, level.gate_chain]);
  var_0 scripts\common\anim::anim_single_solo(level.price, "dumpster_walkby");
  level.price scripts\engine\sp\utility::enable_ai_color();
  level.price scripts\sp\utility::stayahead_pause(0);
  level.price scripts\common\ai::reset_gunpose();
}

price_approach_gate(var_0) {
  var_1 = getstartorigin(var_0.origin, var_0.angles, level.price scripts\engine\utility::getanim("infil_gate_arrival"));
  waitframe();

  while(distancesquared(level.price.origin, var_1) > 16384)
    waitframe();

  level.price scripts\sp\utility::stayahead_pause(1);
  level.price scripts\engine\utility::set_movement_speed(56);
  vo_light_nag_if_not_shot();
}

gate_nvg_hint() {
  scripts\engine\utility::flag_wait("light_shot");
  wait 3;

  if(!scripts\sp\nvg\nvg_player::is_nvg_on())
    thread scripts\sp\nvg\nvg_player::nvg_on_hint(5);
}

gate_chain_init() {
  var_0 = scripts\engine\utility::getStruct("bushes_price_gate", "targetname");
  level.gate_chain = scripts\engine\sp\utility::spawn_anim_model("gate_chain", var_0.origin, var_0.angles);
  var_0 scripts\common\anim::anim_first_frame_solo(level.gate_chain, "infil_gate_cut");
}

relink_cutters_on_anim_end() {
  level.cutters scripts\engine\utility::waittill_any("stop_sequencing_notetracks", "single anim");
  level.cutters linkTo(level.price, "tag_shield_back", (0, 0, 0), (0, 0, 0));
}

stop_idle_on_spotted(var_0, var_1) {
  var_0 endon(var_1);
  scripts\engine\utility::flag_wait("stealth_spotted");
  var_0 notify("death");
}

initgate(var_0, var_1, var_2, var_3) {
  var_4 = getstartorigin(var_0.origin, var_0.angles, var_2);
  var_5 = getstartangles(var_0.origin, var_0.angles, var_2);
  var_6 = scripts\engine\sp\utility::spawn_anim_model("gate_door", var_4, var_5);
  var_7 = getEntArray(var_1, "targetname");
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;

  foreach(var_12 in var_7) {
    if(var_12.classname == "script_brushmodel")
      var_8 = var_12;

    if(var_12.classname == "script_model") {
      var_10 = var_12;
      continue;
    }

    if(var_12.classname == "script_origin")
      var_9 = var_12;
  }

  if(isDefined(var_10))
    var_10 linkTo(var_9);

  var_8 linkTo(var_9);

  if(isDefined(var_3))
    var_9 linkTo(var_6, "tag_origin", (0, 0, 0), (0, 0, 0));
  else
    var_9 linkTo(var_6);

  var_6.prop = var_8;
  var_6.geo = var_10;
  return var_6;
}

gate_light_watcher() {
  waitframe();
  var_0 = getEnt("lights_gate", "targetname");

  while(var_0 getscriptablepartstate("onoff") != "death")
    waitframe();

  scripts\engine\utility::flag_set("light_shot");
}

gate_catchup() {
  if(!scripts\sp\starts::is_after_start("fusebox_tut"))
    thread price_hot_or_not();
}

fusebox_tut_start() {
  spawn_price_infill();
  level.price stayahead_values_tallgrass(1);
  scripts\engine\sp\utility::set_start_location("takedown_start", [level.player, level.price]);

  if(!scripts\sp\starts::is_after_start("Light"))
    thread price_stealth_reprimand();
}

fusebox_tut_main() {
  thread fusebox_switch();
  scripts\engine\utility::delaythread(0.1, ::light_tut_light_watcher);
  level.price_color_trigger = 4;
  level.fusebox_animnode = scripts\engine\utility::getStruct("fusebox_tut_animnode", "targetname");
  setsaveddvar("MMLNNQSTTL", 0);
  var_0 = initgate(level.fusebox_animnode, "light_tut_entrance_door", %est_li_050_fusebox_tuto_door, 1);
  var_0.og_origin = var_0.origin;
  var_0.og_angles = var_0.angles;
  level.light_entrance_gate = var_0;
  scripts\engine\utility::flag_wait("move_to_fusebox");

  if(scripts\engine\utility::flag("stealth_spotted"))
    price_hot_cleanup();

  level.price_color_trigger = 5;
  thread fusebox_door_interact();
  thread fusebox_tut_price();
  thread fusebox_tut_victim();
  thread fusebox_tut_gate();
  thread fusebox_tut_cleanup();
}

fusebox_tut_cleanup() {
  level waittill("fusebox_tut_complete");
  level.fusebox_animnode = undefined;
  thread scripts\sp\maps\estate\estate_util.gsc::delete_noteworthy_ents("melee_ent");
}

fusebox_switch() {
  var_0 = getscriptablearray(level.tut_fusebox.target, "targetname")[0];
  scripts\engine\utility::waittill_any_ents(level.tut_fusebox, "lightswitch_toggle", var_0, "death");
  scripts\engine\utility::flag_set("player_used_fusebox");
  level.tut_fusebox scripts\sp\interactables\dynolight::lightswitch_disable(1);
  wait 0.5;

  if(istrue(level.tut_fusebox.destroyed) || var_0 getscriptablepartstate("onoff") == "death") {
    level.price stopsounds();
    thread scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_stealth_doublekill_10");
  }
}

fusebox_door_interact() {
  if(scripts\engine\utility::flag("player_used_fusebox") || scripts\engine\utility::flag("player_shot_door")) {
    return;
  }
  var_0 = scripts\engine\utility::getStruct("fusebox_tut_doorknob", "targetname");
  var_0 thread scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SCRIPT/DOOR_HINT_USE_NO_BASH");
  var_0 thread scripts\sp\maps\estate\estate_util.gsc::door_interact_presentation();
  scripts\engine\utility::flag_wait_any("player_used_fusebox", "player_shot_door");
  scripts\engine\utility::flag_wait("fusebox_price_ready");
  wait 3;
  var_0 scripts\sp\player\cursor_hint::remove_cursor_hint();
}

fusebox_tut_price() {
  thread fusebox_tut_price_breakout();
  level.price endon("breakout");

  if(level.price isinscriptedstate()) {
    level.price waittillmatch("single anim", "end");
    waittillframeend;
  }

  level.price scripts\engine\sp\utility::disable_ai_color();
  level.price scripts\common\ai::set_gunpose("ads");
  level.price.disableplayeradsloscheck = 1;
  level.fusebox_animnode scripts\sp\anim::anim_reach_solo(level.price, "fusebox_tut_arrive");
  level.price.disableplayeradsloscheck = 0;
  thread vo_fusebox();
  level.price thread scripts\engine\utility::waittillmatch_notify("single anim", "end", "arrived");
  level.fusebox_animnode thread scripts\common\anim::anim_single_solo(level.price, "fusebox_tut_arrive");
  var_0 = level.price scripts\engine\utility::waittill_any_return("arrived", "go_time");

  if(var_0 == "arrived") {
    if(!scripts\engine\utility::flag("player_used_fusebox") && !scripts\engine\utility::flag("player_shot_door")) {
      level.fusebox_animnode thread scripts\common\anim::anim_loop_solo_with_nags(level.price, "fusebox_tut_idle", "stop_loop");
      level.price scripts\common\utility::lookatentity(level.player, 0);
    }

    scripts\engine\utility::flag_wait_any("player_used_fusebox", "player_shot_door");
    level.price scripts\common\utility::lookatentity();
    level.fusebox_animnode notify("stop_loop");
  } else
    level.price scripts\engine\sp\utility::anim_stopanimScripted();

  level.price scripts\common\ai::reset_gunpose();
  childthread fusebox_tutorial_temp_sounds();
  level.fusebox_animnode scripts\common\anim::anim_single_solo(level.price, "fusebox_tut_owned");
  level.price.completed_fusebox_tut_anim = 1;
  thread fusebox_tut_price_finish();
}

vo_fusebox() {
  scripts\engine\utility::flag_wait("fusebox_price_ready");

  if(!scripts\engine\utility::flag("player_used_fusebox") && !scripts\engine\utility::flag("player_shot_door")) {
    level endon("player_used_fusebox");
    level endon("player_shot_door");

    if(distancesquared(level.player.origin, level.price.origin) > 90000) {
      scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_fusebox_tutorial_24");
      var_0 = ["dx_vom_pri_fusebox_tutorial_22", "dx_vom_pri_fusebox_tutorial_23", "dx_vom_pri_fusebox_tutorial_24"];
      level.price thread scripts\sp\maps\estate\estate_util.gsc::notetrack_nag(var_0, ["player_used_fusebox", "player_shot_door", "player_at_fusebox"]);

      while(distancesquared(level.player.origin, level.price.origin) > 90000)
        waitframe();

      level notify("player_at_fusebox");
    }

    scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_fusebox_tutorial_30");
    var_0 = ["dx_vom_pri_fusebox_tutorial_10", "dx_vom_pri_fusebox_tutorial_20", "dx_vom_pri_fusebox_tutorial_21"];
    level.price thread scripts\sp\maps\estate\estate_util.gsc::notetrack_nag(var_0, ["player_used_fusebox", "player_shot_door"]);
  }
}

fusebox_tut_price_breakout() {
  level endon("fusebox_price_committed");
  scripts\engine\utility::flag_wait_any("player_used_fusebox", "player_shot_door");
  scripts\engine\utility::flag_wait("fusebox_price_ready");
  level.price notify("go_time");
  waittillframeend;
  level.fusebox_victim endon("first_pain");
  level.fusebox_victim waittill("breakout");
  level.price notify("breakout");
  level.price scripts\engine\sp\utility::anim_stopanimScripted();
  level.fusebox_animnode scripts\common\anim::anim_single_solo(level.price, "fusebox_tut_breakout");
  thread fusebox_tut_price_finish();
}

fusebox_tutorial_temp_sounds() {
  level.price playSound("scn_estate_price_kill_door_foley");
  wait 4;
  thread scripts\engine\utility::play_sound_in_space("scn_estate_price_kill_door_barn_door", (6154, 5695, 1114));
  wait 1.8;
  thread scripts\engine\utility::play_sound_in_space("scn_estate_price_kill_door_barn_door_hit", (6217, 5738, 1117));
}

fusebox_tut_price_finish() {
  var_0 = scripts\engine\utility::getStruct("melee_exit_node", "targetname");

  if(!isDefined(level.price.completed_fusebox_tut_anim)) {
    level.price.disableplayeradsloscheck = 1;
    var_0 scripts\sp\anim::anim_reach_and_approach_solo(level.price, "melee_exit_end");
    level.price.disableplayeradsloscheck = 0;
  }

  if(!scripts\engine\utility::flag("bushes_exit_patrol_go")) {
    var_0 thread scripts\common\anim::anim_loop_solo(level.price, "melee_exit_end_idle");
    scripts\engine\utility::flag_wait("bushes_exit_patrol_go");
    var_0 notify("stop_loop");
  }

  var_0 thread scripts\common\anim::anim_single_solo(level.price, "melee_exit_end");
  wait 0.1;
  level.price scripts\common\utility::enable_cqbwalk();
  level.price scripts\engine\sp\utility::enable_ai_color();
  level.price scripts\common\ai::set_gunpose("ads");
  level notify("fusebox_tut_complete");
}

fusebox_tut_victim() {
  scripts\engine\utility::flag_wait_any("player_used_fusebox", "player_shot_door");
  var_0 = scripts\engine\sp\utility::spawn_targetname("fusebox_tut_victim", 1);
  level.fusebox_victim = var_0;
  var_0.shotsfired = 0;
  var_0.noragdoll = 1;
  var_0 scripts\engine\utility::ent_flag_init("first_pain");
  var_0 thread scripts\common\ai::magic_bullet_shield();
  var_0 scripts\sp\utility::context_melee_allow(0);
  var_0.script_pushable = 0;
  var_0 thread victim_damage_monitor();
  var_0 scripts\engine\utility::delaythread(1.2, scripts\sp\anim::play_sound_at_viewheight, "dx_vom_aq4_fusebox_tutorial_40");
  var_0 thread scripts\engine\utility::waittillmatch_notify("single anim", "end", "anim_complete");

  if(!scripts\engine\utility::flag("fusebox_price_ready")) {
    level.fusebox_animnode thread scripts\common\anim::anim_first_frame_solo(var_0, "fusebox_tut_owned");
    scripts\engine\utility::flag_wait("fusebox_price_ready");
  }

  level.fusebox_animnode thread scripts\common\anim::anim_single_solo(var_0, "fusebox_tut_owned");
  var_1 = var_0 scripts\engine\utility::waittill_any_return("anim_complete", "breakout");

  if(var_1 == "breakout") {
    var_0.deathanim = level.scr_anim["wrecked"]["fusebox_tut_breakout"];
    var_0 scripts\engine\sp\utility::anim_stopanimScripted();
    var_0 thread victim_push_back();
  } else
    var_0.a.nodeath = 1;

  if(isDefined(var_0.magic_bullet_shield))
    var_0 scripts\common\ai::stop_magic_bullet_shield();

  var_0.allowdeath = 1;
  var_0 kill(var_0 getEye(), level.price);
}

victim_damage_monitor() {
  level endon("fusebox_price_committed");
  self endon("first_pain");

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(var_1 == level.player && scripts\engine\utility::flag("fusebox_tut_door_open")) {
      break;
    }
  }

  self notify("breakout");
}

victim_push_back() {
  var_0 = scripts\engine\utility::spawn_script_origin();
  self linkTo(var_0);
  var_1 = 1;
  var_0 moveTo(self.origin - anglesToForward(self.angles) * 60, var_1, 0.8, 0.2);
  wait(var_1);
  var_0 delete();
}

fusebox_tut_gate() {
  var_0 = level.light_entrance_gate;
  var_0 thread gate_damage_monitor();
  scripts\engine\utility::flag_wait_any("player_used_fusebox", "player_shot_door");
  scripts\engine\utility::flag_wait("fusebox_price_ready");
  var_0.prop connectpaths();
  level.fusebox_animnode scripts\common\anim::anim_single_solo(var_0, "fusebox_tut_owned");
}

gate_damage_monitor() {
  level endon("player_used_fusebox");
  self.geo setCanDamage(1);

  for(;;) {
    self.geo waittill("damage", var_0, var_1);

    if(var_1 == level.player) {
      break;
    }
  }

  scripts\engine\utility::flag_set("player_shot_door");
  wait 0.5;

  if(scripts\engine\utility::flag("fusebox_price_ready")) {
    level.price stopsounds();
    thread scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_estate_stealth_60");
  }
}

fusebox_tut_catchup() {
  thread scripts\sp\maps\estate\estate_util.gsc::delete_noteworthy_ents("melee_ent");
}

light_tutorial_start() {
  spawn_price_infill();
  level.price stayahead_values_tallgrass(1);
  var_0 = getEntArray("light_tut_entrance_door", "targetname");

  foreach(var_2 in var_0) {
    if(var_2.classname == "script_brushmodel") {
      var_2.origin = var_2.origin + (0, 0, 100);
      var_2 notsolid();
    }

    var_2 delete();
  }

  scripts\engine\utility::delaythread(0.1, ::light_tut_light_watcher);
  scripts\engine\sp\utility::set_start_location("light_tutorial_start", [level.player, level.price]);
  level.price_color_trigger = 7;
  price_color_trigger_set(level.price_color_trigger);
  level.price scripts\common\ai::set_gunpose("ads");
}

light_tutorial_main() {
  scripts\engine\utility::flag_wait("bushes_exit_patrol_go");
  thread vo_light_tut();
  thread start_light_tut_on_player_view();
  scripts\engine\sp\utility::array_spawn_function_targetname("light_tutorial_spawners", ::light_enemy_spawn_func);
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("light_tutorial_spawners", 1);
  thread light_tutorial_events_watcher();
  scripts\engine\sp\utility::flagwaitthread("stealth_spotted", scripts\engine\sp\utility::battlechatter_on, "axis");
  thread transient_unload_light_tut();
  price_kills_right_side_light_enemies_then_goes_hot();
  scripts\engine\utility::flag_wait("light_enemies_dead");
  scripts\engine\sp\utility::autosave_by_name("light_tut_end");
  level.price scripts\common\ai::set_gunpose("ready");
  thread price_exits_light_tut();

  if(!scripts\engine\utility::flag("bushes_price_exit"))
    thread vo_keep_up_nags("bushes_price_exit");

  scripts\engine\utility::flag_wait("bushes_price_exit");
  thread scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_tut_lights_90");
  thread scripts\sp\maps\estate\estate_util.gsc::delete_noteworthy_ents("light_tut_ent");
}

transient_unload_light_tut() {
  if(isDefined(level.light_entrance_gate)) {
    scripts\engine\utility::flag_wait("light_area_halfway");
    level.light_entrance_gate.origin = level.light_entrance_gate.og_origin;
    level.light_entrance_gate.angles = level.light_entrance_gate.og_angles;
    scripts\engine\sp\utility::transient_unload("estate_infil_start_tr");
  }
}

price_shoots_light_timeout() {
  wait 20;

  if(scripts\engine\utility::flag("tutorial_light_shot") || scripts\engine\utility::flag("light_enemies_dead") || scripts\engine\utility::flag("light_tut_hot") || scripts\engine\utility::flag("light_enemy_killed")) {
    return;
  }
  scripts\engine\utility::flag_set("tutorial_light_shot");
  level.price stopsounds();
  waitframe();
  thread scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_tut_lights_25");
  level.price.dontevershoot = 1;
  level.price.ignoreall = 0;
  var_0 = getEnt("light_tutorial_light", "targetname");
  level.price thread scripts\sp\utility::aim_at(var_0.origin);

  while(!scripts\engine\utility::within_fov(level.price gettagorigin("tag_flash"), level.price gettagangles("tag_flash"), var_0.origin, cos(5)))
    waitframe();

  magicbullet(level.price.rifle, level.price gettagorigin("tag_flash"), var_0.origin);
  wait 0.15;
  level.price scripts\sp\utility::stop_aiming();
  var_0.alive = 0;
  var_0.intensity = 0;
  var_0 setscriptablepartstate("onoff", "death");
}

start_light_tut_on_player_view() {
  waitframe();
  var_0 = scripts\stealth\utility::get_group("left");
  var_1 = scripts\stealth\utility::get_group("right");
  thread set_flag_when_dead(var_1, "light_right_enemies_dead");
  var_2 = scripts\engine\utility::array_combine(var_0, var_1);
  thread vo_light_enemies_convo(var_0, var_1);

  for(;;) {
    foreach(var_4 in var_2) {
      if(scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_4 getEye(), cos(50)) && scripts\engine\trace::ray_trace_passed(level.player getEye(), var_4 getEye(), [level.player, var_4])) {
        scripts\engine\utility::flag_set("light_tutorial_start");
        return;
      }

      wait 0.05;
    }

    wait 0.05;
  }
}

vo_light_enemies_convo(var_0, var_1) {
  level endon("tutorial_light_shot");
  var_2 = "dx_vom_aq1_tut_aqlights_";
  var_3 = 0;
  var_4 = 1;
  var_5 = var_0;
  var_6 = scripts\engine\utility::array_combine(var_0, var_1);

  foreach(var_8 in var_6) {
    var_8 endon("shooting");
    var_8 endon("death");
  }

  for(;;) {
    var_3 = var_3 + 10;
    var_5[0] scripts\engine\sp\utility::smart_dialogue_generic(var_2 + var_3);

    if(var_4) {
      var_5 = var_1;
      var_2 = "dx_vom_aq2_tut_aqlights_";
      var_4 = 0;
    } else {
      var_5 = var_0;
      var_2 = "dx_vom_aq1_tut_aqlights_";
      var_4 = 1;
    }

    if(var_3 == 90) {
      return;
    }
    wait(0.15 + randomfloat(0.25));
  }
}

light_tutorial_catchup() {
  thread scripts\sp\maps\estate\estate_util.gsc::delete_noteworthy_ents("light_tut_ent");
}

vo_light_tut() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("light_tutorial_start");
  var_0 = lookupsoundlength("dx_vom_pri_tut_lights_10");
  var_1 = var_0 % 50;

  if(var_1 > 0)
    var_0 = var_0 + (50 - var_1);

  var_2 = var_0 / 1000;
  var_3 = getanimlength(level.scr_face["price"]["dx_vom_pri_tut_lights_10"]);
  var_4 = max(var_2, var_3);
  thread scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_tut_lights_10");
  wait(var_4);
  scripts\engine\utility::flag_set("light_tut_price_clear_to_shoot");

  if(!scripts\engine\utility::flag("tutorial_light_shot") && !scripts\engine\utility::flag("light_enemy_killed") && !scripts\engine\utility::flag("stealth_spotted")) {
    thread price_shoots_light_timeout();
    level.price thread scripts\sp\maps\estate\estate_util.gsc::nags_til_notify(["dx_vom_pri_tut_lights_20", "dx_vom_pri_woods_traverse_90", "dx_vom_pri_woods_traverse_91"], "tutorial_light_shot", 1);
    thread stop_nags_on_combat();
  }

  scripts\engine\utility::flag_wait("light_enemies_dead");
  wait 1;
  thread scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_tut_lights_80");
}

stop_nags_on_combat() {
  level endon("tutorial_light_shot");
  level.price scripts\engine\sp\utility::add_wait(scripts\engine\sp\utility::waittill_msg, "shooting");
  level scripts\engine\sp\utility::add_wait(scripts\engine\utility::flag_wait, "light_enemies_dead");
  scripts\engine\sp\utility::do_wait_any();

  if(!scripts\engine\utility::flag("tutorial_light_shot"))
    scripts\engine\utility::flag_set("tutorial_light_shot");
}

vo_light_shot_enemy_chatter() {
  level endon("stealth_spotted");
  var_0 = scripts\stealth\utility::get_group("left");

  if(var_0.size < 2) {
    return;
  }
  var_0[0] endon("death");
  var_0[1] endon("death");
  var_0[0] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq3_woods_traverse_300");
  wait 1.5;
  var_0[0] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq3_woods_traverse_340");
  wait 0.15;
  var_0[1] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq4_woods_traverse_350");
  wait 5;
  var_0[0] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq4_woods_traverse_310");
  wait 0.15;
  var_0[1] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq3_woods_traverse_320");
  wait 0.15;
  var_0[0] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq4_woods_traverse_330");
  wait 4;
  var_0[1] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq1_woods_traverse_360");
  wait 0.15;
  var_0[0] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq2_woods_traverse_370");
  wait 0.15;
  var_0[1] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq1_woods_traverse_380");
}

light_tut_light_watcher() {
  var_0 = getEnt("light_tutorial_light", "targetname");
  var_0 waittill("death");
  wait 0.5;
  scripts\engine\utility::flag_set("tutorial_light_shot");
}

light_tutorial_events_watcher() {
  level endon("light_enemies_dead");
  scripts\engine\utility::flag_wait("tutorial_light_shot");
  scripts\engine\utility::flag_wait("light_tutorial_start");
  setmusicstate("mx_tmp_estate_lightsout");
  thread vo_light_shot_enemy_chatter();
  var_0 = getEnt("light_tutorial_light", "targetname");
  var_1 = (5212.5, 5249.5, 1081);
  var_2 = scripts\stealth\utility::get_group("left");

  foreach(var_4 in var_2) {
    var_4 aieventlistenerevent("glass_destroyed", level.player, var_1);
    wait 1.2;
  }

  scripts\engine\utility::array_thread(var_2, ::never_stop_investigating);
  var_6 = 1;
  var_2 = [];
  var_7 = getEnt("light_tutorial_trigger", "targetname");
  var_2 = var_7 getistouchingentities(getaiarray("axis"));

  foreach(var_9 in var_2) {
    var_9 endon("shooting");
    var_9 endon("death");
  }

  if(var_2.size > 3 && (!scripts\engine\utility::flag("light_tut_hot") || !scripts\engine\utility::flag("light_enemy_killed")))
    thread scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_tut_lights_30");

  if(var_2.size > 3) {
    while(var_7 getistouchingentities(getaiarray("axis")).size > 3)
      wait 0.05;
  }

  if(var_2.size > 2) {
    if(!scripts\engine\utility::flag("light_tut_hot") || !scripts\engine\utility::flag("light_enemy_killed"))
      thread scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_tut_lights_40");

    while(var_7 getistouchingentities(getaiarray("axis")).size > 2)
      wait 0.05;
  }

  level.light_enemies_separated = 1;

  if(!scripts\engine\utility::flag("light_tut_hot") || !scripts\engine\utility::flag("light_enemy_killed"))
    thread scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_tut_lights_50");

  level.price thread scripts\sp\maps\estate\estate_util.gsc::nags_til_notify(["dx_vom_pri_tut_lights_51", "dx_vom_pri_tut_lights_52"], "stealth_spotted", 1, 10);
  scripts\engine\utility::flag_wait("light_right_enemies_dead");
  var_2 = scripts\stealth\utility::get_group("left");
  scripts\engine\utility::array_thread(var_2, scripts\stealth\enemy::alertlevel_normal);
}

never_stop_investigating() {
  self endon("death");
  self endon("stealth_combat");

  while(!isDefined(self.stealth.investigateendtime))
    waitframe();

  for(;;) {
    self.stealth.investigateendtime = gettime() + 12000;
    wait 10;
  }
}

set_flag_when_dead(var_0, var_1) {
  if(var_0.size)
    scripts\engine\sp\utility::waittill_dead_or_dying(var_0);

  scripts\engine\utility::flag_set(var_1);
}

price_kills_right_side_light_enemies_then_goes_hot() {
  var_0 = scripts\stealth\utility::get_group("right");

  foreach(var_2 in var_0)
  var_2 scripts\engine\sp\utility::add_wait(scripts\engine\utility::waittill_any, "stealth_investigate", "stealth_combat");

  scripts\engine\sp\utility::add_wait(scripts\engine\utility::flag_wait_any, "light_area_halfway", "light_enemy_killed");
  scripts\engine\sp\utility::do_wait_any();
  scripts\engine\utility::flag_wait("light_tut_price_clear_to_shoot");
  wait 0.25;

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      price_kill(var_2);
      wait 0.2;
    }
  }

  var_6 = scripts\stealth\utility::get_group("left");

  if(var_6.size) {
    var_7 = 0;

    foreach(var_2 in var_6) {
      if(var_2[[var_2.fnisinstealthcombat]]()) {
        var_7 = 1;
        break;
      }
    }

    if(!var_7) {
      foreach(var_2 in var_6) {
        var_2.attackeraccuracy = 100;
        var_2.health = 1;
        var_2 scripts\engine\sp\utility::add_wait(scripts\engine\sp\utility::waittill_msg, "stealth_combat");
      }

      scripts\engine\sp\utility::add_wait(scripts\engine\sp\utility::timeout, 3);
      scripts\engine\sp\utility::do_wait_any();
    }

    scripts\engine\utility::flag_set("light_tut_hot");
    price_goes_hot(var_6);
  } else
    level.price allowedstances("crouch", "stand", "prone");
}

price_goes_hot(var_0) {
  var_1 = 1;

  foreach(var_3 in var_0) {
    if(var_3[[var_3.fnisinstealthcombat]]()) {
      var_1 = 0;
      break;
    }
  }

  if(var_1)
    thread scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_tut_lights_60");

  setmusicstate("");
  level.price.ignoreall = 0;
  level.price.ignoreme = 1;
  level.price.dontevershoot = 1;
  level.price scripts\engine\sp\utility::disable_ai_color();
  var_5 = getnode("price_cleanup", "targetname");
  level.price.goalradius = 40;
  level.price setgoalnode(var_5);
  level.price allowedstances("crouch", "stand", "prone");
  wait 1;
  var_0 = scripts\engine\utility::array_removeundefined(var_0);

  if(!var_0.size) {
    level.price.a.laseron = 0;
    level.price scripts\anim\shared.gsc::updatelaserstatus();
    return;
  }

  level.price scripts\common\utility::enable_cqbwalk();
  price_kills_left_guys(var_0);
  level.price scripts\common\utility::disable_cqbwalk();
}

price_exits_light_tut() {
  level.price scripts\engine\sp\utility::clear_force_color();
  level.price scripts\engine\sp\utility::set_force_color("p");
  level.price_color_trigger = 9;
  price_color_trigger_set(level.price_color_trigger);
  level.price.ignoreall = 1;
}

price_kills_left_guys(var_0) {
  for(;;) {
    foreach(var_2 in var_0) {
      if(isalive(var_2) && level.price cansee(var_2))
        price_kill(var_2);
    }

    var_0 = scripts\engine\utility::array_removeundefined(var_0);

    if(!var_0.size) {
      return;
    }
    waitframe();
  }
}

light_enemy_spawn_func() {
  self.attackeraccuracy = 3;
  self.baseaccuracy = 1.5;
  self.grenadeammo = 0;
  thread battlechatter_off_spawn_func();
  self.deathfunction = ::light_enemy_deathfunc;

  while(!isDefined(self.stealth))
    waitframe();

  self.stealth.funcs["event_investigate"] = ::light_enemy_stealth_filter;
  self.stealth.funcs["event_cover_blown"] = ::light_enemy_stealth_filter;
  self.stealth.funcs["event_combat"] = ::light_enemy_stealth_filter;
  self waittill("stealth_combat");
  self.attackeraccuracy = 1;
}

light_enemy_deathfunc() {
  scripts\engine\utility::flag_set("light_enemy_killed");
  return 0;
}

light_enemy_stealth_filter(var_0) {
  if(scripts\engine\utility::flag("light_right_enemies_dead") && self.script_stealthgroup == "left")
    return 0;

  var_1 = ["unresponsive_teammate", "light_killed", "seek_backup"];

  if(scripts\engine\utility::array_contains(var_1, var_0.typeorig))
    return 1;

  if(istrue(level.light_enemies_separated) && scripts\engine\utility::is_equal(var_0.typeorig, "ally_killed")) {
    scripts\engine\sp\utility::enable_dontevershoot();
    scripts\engine\utility::delaythread(2, scripts\engine\sp\utility::disable_dontevershoot);
  }

  return 0;
}

estate_rappel_start() {
  spawn_price_infill();
  scripts\engine\sp\utility::set_start_location("rappel_start", [level.player, level.price]);
  scripts\engine\utility::flag_set("rappel_start");
  thread debug_player_fwd();
}

estate_rappel_main() {
  disable_fire_triggers();
  scripts\engine\utility::exploder("fxglowrappel");
  scripts\engine\utility::exploder("vfxexp_gunfire_dist_a");
  level scripts\engine\utility::thread_on_notify("rappel_past_price", scripts\engine\utility::stop_exploder, "fxglowrappel");
  level scripts\engine\utility::thread_on_notify("on_belay", scripts\engine\utility::stop_exploder, "vfxexp_gunfire_dist_a");
  scripts\engine\sp\utility::flagwaitthread("rappel_start", scripts\engine\utility::delaythread, 2, ::destroy_service_fusebox);
  thread scripts\sp\maps\estate\estate_util.gsc::greenhouse_misters();
  thread rappel_anim();
  level waittill("on_belay");
  scripts\engine\sp\utility::autosave_by_name("rappel");
  setsaveddvar("MMLNNQSTTL", 10);
  var_0 = getaiarray("axis");

  if(var_0.size)
    scripts\engine\utility::array_delete(var_0);

  level.price.ignoreall = 0;
  level.price.dontevershoot = 1;
  thread rappel_ground_anim();
  scripts\engine\utility::flag_wait("rappel_end");
  scripts\engine\utility::flag_wait("rappel_enemies_dead");
  level.animnodes["rappel_anim_struct"] = undefined;
  level.cutters delete();
  level.price delete();
  thread scripts\sp\maps\estate\estate_util.gsc::delete_noteworthy_ents("rappel_ent");
}

disable_fire_triggers() {
  scripts\engine\sp\utility::disable_trigger_with_targetname("mansion_fire");
  scripts\engine\sp\utility::disable_trigger_with_targetname("obj_room_fire_a");
  scripts\engine\sp\utility::disable_trigger_with_targetname("obj_room_fire_b");
  scripts\engine\sp\utility::disable_trigger_with_targetname("obj_room_fire_c");
}

destroy_service_fusebox() {
  foreach(var_1 in level.fuseboxes) {
    if(scripts\engine\utility::is_equal(var_1.script_parameters, "service")) {
      var_1.noachievement = 1;
      var_1.script_model scripts\sp\utility::do_damage(51, var_1.script_model.origin);
      scripts\engine\utility::exploder("vfxexp_fusebox_dist_exp_a");
      var_2 = getEnt("vistawindows_service", "targetname");
      var_2 delete();
      break;
    }
  }
}

estate_rappel_catchup() {
  scripts\engine\utility::flag_set("rappel_end");
  estate_objectives_create();
  var_0 = getEnt("rappel_kill_trig", "targetname");

  if(isDefined(var_0))
    var_0 delete();

  thread scripts\sp\maps\estate\estate_util.gsc::delete_noteworthy_ents("rappel_ent");
  thread scripts\sp\maps\estate\estate_util.gsc::greenhouse_misters();
  thread fake_vista_windows();
  scripts\engine\utility::delaythread(0.15, ::destroy_service_fusebox);

  if(!scripts\sp\starts::is_after_start("heli_attack"))
    disable_fire_triggers();
}

rappel_anim() {
  var_0 = getEnt("new_rappel_node", "targetname");
  level.animnodes["rappel_anim_struct"] = var_0;
  thread vo_rappel();
  level.price.disableplayeradsloscheck = 1;
  var_0 scripts\sp\anim::anim_reach_solo(level.price, "fwd_rappel_price_enter");
  level.price.disableplayeradsloscheck = 0;
  level.rope unlink();
  var_0 scripts\common\anim::anim_single([level.price, level.rope], "fwd_rappel_price_enter");
  level.price thread scripts\sp\maps\estate\estate_util.gsc::notetrack_nag(["dx_vom_pri_rappel_sitrep_20", "dx_vom_pri_rappel_sitrep_30", "dx_vom_pri_rappel_sitrep_40"], "rappel_objectives");
  var_0 thread scripts\common\anim::anim_loop([level.price, level.rope], "fwd_rappel_price_enter_idle", "stop_price_loop");
  level.player.animarms = scripts\engine\sp\utility::spawn_anim_model("player_rig", level.player.origin, level.player.angles);
  level.player.animrope = scripts\engine\sp\utility::spawn_anim_model("player_rope", level.player.origin, level.player.angles);
  level.player.animropethrow = scripts\engine\sp\utility::spawn_anim_model("player_rope_throw", level.player.origin, level.player.angles);
  level.player.animarms hide();
  level.player.animrope hide();
  level.player.animropethrow hide();
  var_0 scripts\common\anim::anim_first_frame_solo(level.player.animarms, "player_rappel_start");
  level.price scripts\engine\sp\utility::waittill_entity_in_range(level.player, 250);

  while(isDefined(level.price.speaking))
    waitframe();

  wait 0.5;
  thread scripts\sp\maps\estate\estate_util.gsc::kyle_line("dx_vom_kyle_rappel_sitrep_50");
  thread estate_objectives_reveal();
  scripts\engine\utility::flag_set("rappel_objectives");
  var_0 notify("stop_price_loop");
  scripts\engine\utility::delaythread(7, scripts\engine\sp\utility::autosave_by_name, "player_can_rappel");
  scripts\engine\utility::delaythread(8, ::let_player_rappel);
  var_0 thread scripts\common\anim::anim_single([level.price, level.rope], "fwd_rappel_price_go");
  waitframe();
  var_0 scripts\engine\sp\utility::add_wait(scripts\engine\sp\utility::waittill_msg, "fwd_rappel_price_go");
  level scripts\engine\sp\utility::add_wait(scripts\engine\utility::flag_wait, "rappel_started");
  scripts\engine\sp\utility::do_wait_any();

  if(!scripts\engine\utility::flag("rappel_started")) {
    level.price thread scripts\sp\maps\estate\estate_util.gsc::notetrack_nag(["dx_vom_pri_rappel_rope_40", "dx_vom_pri_rappel_rope_50", "dx_vom_pri_rappel_rope_60"], "rappel_started");
    var_0 thread scripts\common\anim::anim_loop_solo_with_nags(level.price, "fwd_rappel_price_idle", "stop_price_loop");
    scripts\engine\utility::flag_wait("rappel_started");
    var_0 notify("stop_price_loop");
  }

  thread scripts\sp\analytics::analytics_kleenex_update("intro to rappel");
  var_1 = getEnt("rappel_kill_trig", "targetname");
  var_1 delete();
  thread rappel_price();
  rappel_player();
  scripts\engine\utility::flag_wait("rappel_end");
}

vo_rappel() {
  level.player endon("death");
  var_0 = vo_rappel_ahead();

  if(istrue(var_0)) {
    return;
  }
  if(isDefined(var_0))
    level waittill("price_overlook_vo");

  if(distancesquared(level.player.origin, level.price.origin) < squared(200))
    scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_rappel_sitrep_12");
  else
    scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_rappel_sitrep_10");

  level waittill("on_belay");
  var_1 = ["dx_vom_pri_rappel_rope_70", "dx_vom_pri_rappel_rope_80", "dx_vom_pri_rappel_rope_90"];
  var_2 = 0;
  var_3 = level.player.origin[2];

  for(;;) {
    wait(randomfloatrange(8, 13));

    if(abs(var_3 - level.player.origin[2]) > 50) {
      break;
    }

    thread scripts\sp\maps\estate\estate_util.gsc::price_line(var_1[scripts\sp\maps\estate\estate_util.gsc::abs_int(var_2 % var_1.size)]);
    var_2++;
  }
}

vo_rappel_ahead() {
  level endon("price_overlook_vo");
  level.animnodes["rappel_anim_struct"] scripts\engine\sp\utility::waittill_entity_in_range(level.player, 150);

  if(distancesquared(level.player.origin, level.price.origin) < squared(200))
    return 0;

  thread scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_rappel_sitrep_11");
  return 1;
}

fake_vista_windows() {
  var_0 = getEnt("vistawindows", "targetname");

  if(isDefined(var_0))
    var_0 delete();

  var_0 = getEnt("vistawindows_courtyard", "targetname");

  if(isDefined(var_0))
    var_0 delete();

  var_1 = getEntArray("rappelvistalights", "targetname");

  if(isDefined(var_1))
    scripts\engine\utility::array_delete(var_1);
}

overlook_interact() {
  level endon("stop_checking_overlook");
  self waittill("trigger");
  waitframe();
  level.rope scripts\sp\player\cursor_hint::remove_cursor_hint();
  level notify("stop_checking_overlook");
}

waittill_player_exits() {
  level endon("stop_checking_overlook");

  while(level.player istouching(self))
    wait 0.05;

  level notify("stop_checking_overlook");
}

let_player_rappel() {
  var_0 = scripts\engine\utility::getStruct("rappel_interact", "targetname");
  var_0.origin = level.rope.origin;
  scripts\engine\sp\objectives::objective_add("rappel", "current", var_0.origin + (0, 0, 10));
  var_0 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, undefined, &"ESTATE/RAPPEL_HINT", undefined, 350, 150, 1, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 90);
  var_0 scripts\engine\utility::waittill_either("trigger", "hint_destroyed");
  scripts\engine\utility::flag_set("rappel_started");
  scripts\engine\sp\objectives::objective_complete("rappel");
}

rappel_price() {
  level.animnodes["rappel_anim_struct"] scripts\common\anim::anim_single_solo(level.price, "fwd_rappel_price_outro");
  level.animnodes["rappel_anim_struct"] thread scripts\common\anim::anim_loop_solo(level.price, "fwd_rappel_price_outro_idle", "stop_price_loop");
}

rappel_player() {
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  level.player playSound("scn_estate_rappel_hookup_lerp_plr");
  level link_player_to_rappel_scene();
  level.player scripts\common\utility::allow_melee(0, "rappel");
  var_0 = level.animnodes["rappel_anim_struct"];
  level.player.animrope show();
  level.player.animropethrow show();
  var_0 thread scripts\common\anim::anim_single_solo(level.player.animropethrow, "player_rappel_start");
  var_0 scripts\common\anim::anim_single([level.player.animarms, level.player.animrope, level.rope], "player_rappel_start");
  level.player.animropethrow delete();
  var_1 = level.scr_anim["player_rig"]["player_rappel"];
  var_2 = level.scr_anim["player_rope"]["player_rappel"];
  level.player scripts\common\utility::allow_melee(1, "rappel");
  var_3 = % est_li_060_fwd_rappel_rope_plr_add1;
  var_4 = % estate_rope_additive;
  level.player.animarms hide();
  level.rope delete();
  var_0 thread scripts\common\anim::anim_single([level.player.animarms, level.player.animrope], "player_rappel");
  var_5 = 0.001;
  var_6 = var_5;
  var_7 = 0.18;
  var_8 = 0.035;
  var_9 = 0.5;
  var_10 = 1;
  var_11 = 0.18;
  var_12 = 0.04;
  var_13 = var_9;
  var_14 = 0;
  level.player.animrope setanim(var_3);
  var_15 = getanimlength(var_1);
  level.player scripts\common\utility::allow_weapon(1, "rappel");
  level.player.animarms setanimrate(var_1, 0);
  level.player.animrope setanimrate(var_2, 0);
  doinjuredgesture(1);
  thread rappel_reloading();
  thread rappel_nvgs();
  thread rappel_offhands();
  var_16 = level.player scripts\engine\utility::spawn_script_origin();
  var_16 linkTo(level.player);
  var_17 = 1;
  var_18 = 0.1;
  var_19 = 0.8;
  var_20 = var_19;
  var_21 = 0;
  level.player lerpviewangleclamp(1, 0.5, 0.5, 45, 45, 50, 40);
  level notify("on_belay");
  level.audio_loop_state = 0;

  for(;;) {
    if(scripts\engine\utility::flag("rappel_enemies_dead"))
      var_20 = 1.67;
    else
      var_20 = var_19;

    var_22 = level.player getnormalizedmovement()[0];
    var_22 = clamp(var_22, 0, 1);
    var_23 = scripts\engine\math::factor_value(0, var_20, var_22);
    var_17 = var_17 + (var_23 - var_17) * var_18;

    if(var_22 > 0) {
      var_16 thread rappelfootstep(var_17);
      var_16 thread player_rappel_sound_loop_on();
      level.player.animarms setanimrate(var_1, var_17);
      level.player.animrope setanimrate(var_2, var_17);

      if(!var_21)
        var_21 = 1;
    } else {
      var_16 thread player_rappel_sound_loop_off();
      level.player.animarms setanimrate(var_1, 0);
      level.player.animrope setanimrate(var_2, 0);
    }

    if(var_22 > var_6) {
      var_24 = var_11;
      var_25 = var_7;
    } else {
      var_24 = var_12;
      var_25 = var_8;
    }

    var_14 = scripts\engine\math::lerp(var_14, var_22, var_24);
    var_13 = scripts\engine\math::factor_value(var_9, var_10, var_14);
    var_6 = scripts\engine\math::lerp(var_6, var_22, var_25);
    var_6 = clamp(var_6, var_5, 1);
    level.player.animrope setanim(var_4, var_6, 0, var_13);
    var_26 = level.player.animarms getanimtime(var_1);

    if(var_26 >= 0.93) {
      level.player playSound("scn_estate_rappel_dismount_plr");
      level.player playSound("scn_estate_rappel_dismount_plr_rope");
      level.player playSound("scn_estate_rappel_dismount_plr_land");
      scripts\engine\utility::delaythread(0.5, ::fake_vista_windows);
      level.player lerpviewangleclamp(1, 0.5, 0.5, 0, 0, 0, 0);
      level.player.animarms setanimrate(var_1, 1, 0.25);
      level.player.animrope setanimrate(var_2, 1, 0.25);

      while(level.player.animarms getanimtime(var_1) < 1)
        wait 0.05;

      break;
    }

    wait 0.05;
  }

  restore_replaced_weapon();
  level.player unlink();
  scripts\sp\utility::nvidiaansel_scriptdisable(0);
  level.player forceplaygestureviewmodel("ges_stumble_1", undefined, 0.05, 3);
  earthquake(0.3, 0.5, level.player.origin, 300);
  level.player playRumbleOnEntity("damage_heavy");
  level.player playersetgroundreferenceent(undefined);
  level.player.groundrefent delete();
  level.player stopshellshock();
  level.player.animrope setanim(var_4, 0, 0);
  var_16 delete();
  playworldsound("slide_start_plr", level.player.origin);
  scripts\engine\utility::flag_set("rappel_end");
  level.player.animarms delete();
  level.player.dof_ref_ent = undefined;
  level.player scripts\common\utility::allow_crouch(1, "rappel");
  level.player scripts\common\utility::allow_prone(1, "rappel");
}

choose_rappel_weapon(var_0) {
  var_1 = undefined;
  var_2 = level.player getweaponslistprimaries();

  foreach(var_4 in var_2) {
    if(issubstr(var_4.basename, "_pi_") && var_4 has_ammo()) {
      var_1 = var_4;
      var_5 = level.player getweaponammoclip(var_1);
      var_6 = level.player getweaponammostock(var_1);
      level.player takeweapon(var_1);
      level.player giveweapon(var_1);
      level.player setweaponammoclip(var_1, var_5);
      level.player setweaponammostock(var_1, var_6);
      break;
    }
  }

  if(!isDefined(var_1)) {
    foreach(var_4 in var_2) {
      if(var_4 hasattachment("silenc", 1) && var_4 has_ammo()) {
        var_1 = var_4;
        break;
      }
    }

    if(!isDefined(var_1)) {
      foreach(var_4 in var_2) {
        if(var_4 has_ammo()) {
          var_1 = var_4;

          if(var_1 == var_0) {
            break;
          }
        }
      }

      if(!isDefined(var_1))
        var_1 = var_0;
    }
  }

  if(var_0 != var_1)
    level.player.storedweapon = var_0;

  return var_1;
}

has_ammo() {
  return level.player getweaponammoclip(self) || level.player getweaponammostock(self);
}

player_rappel_weapon_switch(var_0) {
  var_1 = choose_rappel_weapon(var_0);
  level.player switchtoweaponimmediate(var_1);

  if(!issubstr(var_1.basename, "_pi_"))
    level.player scripts\common\utility::allow_ads(0, "rappel");

  level.player scripts\common\utility::allow_weapon_switch(0, "rappel");
  level.player scripts\common\utility::allow_offhand_weapons(0, "rappel");
  level.player scripts\common\utility::allow_sprint(0, "rappel");
}

restore_replaced_weapon() {
  var_0 = level.player getcurrentweapon();

  if(!issubstr(var_0.basename, "_pi_"))
    level.player scripts\common\utility::allow_ads(1, "rappel");

  level.player scripts\common\utility::allow_weapon_switch(1, "rappel");
  level.player scripts\common\utility::allow_offhand_weapons(1, "rappel");
  level.player scripts\common\utility::allow_sprint(1, "rappel");

  if(isDefined(level.player.storedweapon)) {
    level.player switchtoweapon(level.player.storedweapon);
    level.player.storedweapon = undefined;

    while(nullweapon(level.player getcurrentweapon()))
      waitframe();
  }
}

player_rappel_sound_loop_on() {
  if(level.audio_loop_state == 0) {
    level.audio_loop_state = 1;
    level.player playSound("scn_estate_rappel_start_plr");
    level.player playSound("scn_estate_rappel_start_plr_lyr");
    wait 0.25;
    self playLoopSound("scn_estate_rappel_loop_plr");
  }
}

player_rappel_sound_loop_off() {
  if(level.audio_loop_state == 1) {
    level.player playSound("scn_estate_rappel_stop_plr");
    self stoploopsound();
    level.audio_loop_state = 0;
  }
}

debug_player_fwd() {
  level endon("rappel_end");
  level.player endon("death");

  for(;;) {
    scripts\sp\debug::drawarrow(level.player.origin, level.player getplayerangles(), (1, 1, 0), 1);
    wait 0.05;
  }
}

rappelfootstep(var_0) {
  if(istrue(self.isplaying) || var_0 < 0.3) {
    return;
  }
  self.isplaying = 1;
  var_1 = randomfloatrange(1, 1.35);
  level.player screenshakeonentity(randomfloatrange(0.8, 1.3), 0, 0, var_1, -1, -1);
  var_2 = "scn_estate_rappel_step_plr_lyr";
  thread rappel_bump(lookupsoundlength(var_2) / 1000);
  level.player scripts\engine\utility::delaythread(randomfloat(0.15), scripts\engine\sp\utility::play_sound_on_entity, "scn_estate_rappel_step_plr");
  level.player scripts\engine\utility::delaythread(randomfloat(0.45), scripts\engine\sp\utility::play_sound_on_entity, "scn_estate_rappel_step_plr_rocks_fall");
  self playSound(var_2, "done");
  self waittill("done");
  self.isplaying = undefined;
}

doinjuredgesture(var_0) {
  while(nullweapon(level.player getcurrentweapon()))
    waitframe();

  var_1 = 0.3;
  var_2 = 0.4;
  var_3 = level.player getcurrentweapon();

  if(istrue(var_0) && issubstr(var_3.basename, "_pi_")) {
    wait 0.6;
    var_2 = 0.2;
  }

  var_4 = 0;

  while(!var_4) {
    var_4 = level.player forceplaygestureviewmodel("ges_drophand", undefined, var_1, var_2, 1, 0);
    wait 0.05;
  }
}

link_player_to_rappel_scene() {
  level.player scripts\common\utility::allow_crouch(0, "rappel");
  level.player scripts\common\utility::allow_prone(0, "rappel");
  level.player setstance("stand");
  level.player hidelegsandshadow();
  level.player enablequickweaponswitch(1);
  var_0 = level.player getcurrentweapon();
  level.player scripts\common\utility::allow_weapon(0, "rappel");
  level.player playerlinktoblend(level.player.animarms, "tag_player", 0.75);
  wait 0.75;
  level.player.animarms show();
  level.player.groundrefent = scripts\engine\utility::spawn_tag_origin((0, 0, 0));
  level.player.groundrefent linkTo(level.player.animarms, "tag_player", (0, 0, 0), (0, 0, 0));
  level.player playersetgroundreferenceent(level.player.groundrefent);
  level.player playerlinktodelta(level.player.animarms, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player lerpviewangleclamp(1, 0.5, 0.5, 10, 10, 10, 10);
  level.player.dof_ref_ent = level.player.animarms;
  wait 0.15;
  level.player enablequickweaponswitch(0);
  player_rappel_weapon_switch(var_0);
}

rappel_ground_anim() {
  var_0 = level.player.origin[2];

  while(abs(var_0 - level.player.origin[2]) < 70)
    wait 0.25;

  level.rappel_guys = [];
  var_1 = scripts\engine\sp\utility::spawn_script_noteworthy("alq05", 1);
  level.rappel_guys["alq05"] = var_1;
  var_2 = scripts\engine\sp\utility::spawn_script_noteworthy("alq06", 1);
  level.rappel_guys["alq06"] = var_2;
  var_3 = scripts\engine\sp\utility::spawn_script_noteworthy("russ01", 1);
  level.rappel_guys["russ01"] = var_3;
  waitframe();
  var_4 = scripts\engine\sp\utility::spawn_script_noteworthy("russ02", 1);
  level.rappel_guys["russ02"] = var_4;
  var_5 = scripts\engine\utility::getStruct("rappel_anim_struct_base", "targetname");
  var_5.origin = var_5.origin + (0, 0, -5);
  var_6 = [];
  var_7 = [];

  foreach(var_9 in level.rappel_guys) {
    var_9.animname = var_9.script_noteworthy;
    var_9.allowdeath = 1;
    var_9.health = 1;
    var_9.damage_functions[0] = ::rappel_actor_dmg_func;
    var_9 scripts\engine\utility::ent_flag_init("shot");

    if(var_9.animname == "alq05" || var_9.animname == "alq06") {
      var_9 thread rappel_alq_logic();
      var_9 thread scripts\common\ai::magic_bullet_shield();
      var_9 thread actor_die_when_shot();
      var_9 scripts\stealth\utility::set_stealth_func("event_cover_blown", ::rappel_actor_stealth_filter);
      var_6[var_6.size] = var_9;
      continue;
    }

    var_9.no_friendly_fire_fail = 1;
    var_9 thread scripts\common\ai::magic_bullet_shield();
    var_9 scripts\common\ai::gun_remove();
    var_7[var_7.size] = var_9;
  }

  thread vo_price_take_em_out(var_6);
  level.rappel_guys["russ01"] scripts\engine\utility::delaythread(3.3, ::rappel_victim_death, level.rappel_guys["alq05"]);
  level.rappel_guys["russ02"] scripts\engine\utility::delaythread(2.4, ::rappel_victim_death, level.rappel_guys["alq06"]);
  thread rappel_scene_vo(var_6, var_7);
  thread price_kills_rappel_enemies(var_6);
  var_5 thread scripts\common\anim::anim_single(level.rappel_guys, "fwd_rappel_ground");
  scripts\engine\sp\utility::waittill_dead_or_dying(level.rappel_guys);
  scripts\engine\utility::delaythread(0.5, scripts\sp\maps\estate\estate_util.gsc::price_line, "dx_vom_pri_rappel_interrogation_70");
  scripts\engine\utility::flag_set("rappel_enemies_dead");
}

rappel_actor_stealth_filter(var_0) {
  if(var_0.typeorig == "saw_corpse" || var_0.typeorig == "found_corpse")
    return 1;

  return 0;
}

rappel_actor_dmg_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_9) && var_9.basename == "flash") {
    return;
  }
  if(isDefined(var_1)) {
    if(isai(var_1) || isPlayer(var_1)) {
      scripts\engine\utility::ent_flag_set("shot");
      return;
    }
  }

  if(isDefined(var_9)) {
    if(weaponclass(var_9) == "rifle") {
      scripts\engine\utility::ent_flag_set("shot");
      return;
    }
  }
}

vo_price_take_em_out(var_0) {
  level endon("rappel_actors_engaged");
  wait 5;
  var_0 = scripts\engine\utility::array_removedead(var_0);

  if(var_0.size)
    scripts\sp\maps\estate\estate_util.gsc::price_line("dx_vom_pri_rappel_interrogation_60");
}

rappel_alq_logic() {
  self endon("death");
  level endon("rappel_actors_engaged");
  self waittillmatch("single anim", "end");
  self.goalradius = 32;
  self setgoalpos(self.origin);
}

rappel_victim_death(var_0) {
  var_1 = randomintrange(2, 3);

  for(var_2 = 0; var_2 < var_1; var_2++) {
    if(isalive(var_0)) {
      magicbullet(var_0.weapon.basename, var_0 gettagorigin("tag_flash"), self getEye());
      wait 0.1;
    }
  }

  wait 0.8;

  if(isalive(self)) {
    self.a.nodeath = 1;
    scripts\common\ai::stop_magic_bullet_shield();
    self.allowdeath = 1;
    scripts\engine\sp\utility::die();
  }
}

rappel_scene_vo(var_0, var_1) {
  level endon("rappel_actors_engaged");
  var_1[0] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_ru1_rappel_interrogation_30");
  wait 0.25;
  var_0[0] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq1_rappel_interrogation_40");
}

price_kills_rappel_enemies(var_0) {
  var_1 = 0;

  while(!var_1) {
    var_0 = scripts\engine\utility::array_removedead(var_0);

    if(!var_0.size) {
      return;
    }
    foreach(var_3 in var_0) {
      if(scripts\engine\utility::can_trace_to_ai(level.player getEye(), var_3, [level.player]))
        var_1 = 1;
    }

    wait 0.05;
  }

  level.player scripts\engine\sp\utility::add_wait(scripts\engine\sp\utility::waittill_msg, "weapon_fired");
  scripts\engine\sp\utility::add_wait(scripts\engine\utility::flag_wait_any, "rappel_past_price", "stealth_spotted");
  scripts\engine\sp\utility::do_wait_any();
  level notify("rappel_actors_engaged");
  var_5 = (4041.5, 5182.5, 111);

  foreach(var_7 in var_0) {
    if(isalive(var_7)) {
      var_7 scripts\engine\sp\utility::battlechatter_on();
      var_7 scripts\engine\sp\utility::anim_stopanimScripted();
      var_7 thread scripts\stealth\utility::set_patrol_react(var_5, "med");
    }

    wait 0.3;
  }

  wait 0.6;

  foreach(var_7 in var_0) {
    if(isalive(var_7)) {
      var_10 = level.price gettagorigin("tag_flash");

      if(!scripts\engine\trace::ray_trace_passed(var_10, var_7 getEye(), [level.price, var_7]))
        var_10 = var_10 + anglesToForward(level.price gettagorigin("tag_flash")) * 50;

      magicbullet(level.price.rifle, var_10, var_7 getEye());
      waitframe();

      if(isalive(var_7)) {
        if(isDefined(var_7.magic_bullet_shield))
          var_7 scripts\common\ai::stop_magic_bullet_shield();

        playFXOnTag(scripts\engine\utility::getfx("vfx_blood_sniper_shot"), var_7, "tag_eye");
        var_7 playsoundatviewheight("bullet_large_flesh_head_npc");
        wait 0.05;
        var_7 kill(var_7 getEye(), level.price);
      }

      wait 1;
    }
  }
}

estate_objectives_reveal() {
  wait 3;
  thread estate_objectives_create();
  level.player scripts\sp\player::focus_display_hint(2, 7);
}

estate_objectives_create() {
  scripts\engine\sp\objectives::objective_set_description("estate", &"ESTATE/OBJ_DESC_FIND_HVT");
  var_0 = scripts\engine\utility::getStructArray("landmark", "targetname");

  foreach(var_2 in var_0) {
    var_3 = undefined;

    switch (var_2.script_noteworthy) {
      case "church":
        var_3 = &"ESTATE/OBJ_LBL_CHURCH";
        break;
      case "courtyard":
        var_3 = &"ESTATE/OBJ_LBL_COURTYARD";
        break;
      case "pool":
        var_3 = &"ESTATE/OBJ_LBL_POOL";
        break;
      default:
        continue;
    }

    scripts\engine\sp\objectives::objective_add(var_2.script_noteworthy + "_hvt", "current", var_2.origin, undefined, var_3);
  }
}

rappel_reloading() {
  level.player allowreload(0);
  level.player disableautoreload();
  level.player disableemptyclipweaponswitch(1);
  rappel_reload_internal();

  if(istrue(level.player.rappel_reloading)) {
    level.player scripts\common\utility::allow_ads(1, "rappel");
    level.player scripts\common\utility::allow_fire(1, "rappel");
    level.player scripts\common\utility::allow_melee(1, "rappel");
    level.player.rappel_reloading = undefined;
  }

  level.player disableemptyclipweaponswitch(0);
  level.player enableautoreload();
  level.player allowreload(1);
  level.player stopgestureviewmodel("ges_drophand", 0.7);
}

rappel_reload_internal() {
  level endon("rappel_end");
  childthread reloadonempty();

  for(;;) {
    level.player waittill("reload_pressed");
    reloadifneeded();
    wait 0.15;
  }
}

reloadonempty() {
  for(;;) {
    waitframe();

    if(!level.player getcurrentweaponclipammo()) {
      level.player notify("reload_pressed");
      wait 0.15;
    }
  }
}

reloadifneeded() {
  var_0 = level.player getcurrentprimaryweapon();
  var_1 = weaponclass(var_0);

  if(!canrappelreload(var_1)) {
    return;
  }
  var_2 = level.player getgestureanimlength("ges_left_arm_damage_reload");
  var_3 = level.player getweaponammoclip(var_0);
  var_4 = weaponclipsize(var_0);

  if(var_3 < var_4) {
    var_5 = level.player getammocount(var_0);
    var_5 = var_5 - var_3;

    if(var_5 <= 0) {
      return;
    }
    level.player.rappel_reloading = 1;
    level.player scripts\common\utility::allow_fire(0, "rappel");
    level.player scripts\common\utility::allow_ads(0, "rappel");
    level.player scripts\common\utility::allow_melee(0, "rappel");
    var_6 = getsubstr(var_0.basename, 4);
    var_7 = "";

    foreach(var_9 in ["xmag", "toprailcust", "drum"]) {
      if(var_0 hasattachment(var_9, 1)) {
        var_7 = "_" + var_9;
        break;
      }
    }

    var_11 = "wfoly_plr_" + var_6 + "_reload_empty_fast" + var_7 + "_01";
    level.player playSound(var_11);
    level.player screenshakeonentity(1, 0, 0, 1.1);
    scripts\engine\utility::delaythread(0.8, ::tossclip, var_0);
    level.player stopgestureviewmodel("ges_drophand", 0.7);
    level.player forceplaygestureviewmodel("ges_left_arm_damage_reload", undefined, 0.2, 0, 1, 1);
    wait 1.1;
    var_11 = "wfoly_plr_" + var_6 + "_reload_empty_fast" + var_7 + "_02";
    level.player playRumbleOnEntity("damage_heavy");
    level.player screenshakeonentity(1, 1, 1, 0.9);
    level.player playSound(var_11);
    level.player setweaponammoclip(var_0, var_4);
    var_12 = var_4 - var_3;
    var_5 = var_5 - var_12;
    level.player setweaponammostock(var_0, var_5);
    wait 0.3;
    var_11 = "wfoly_plr_" + var_6 + "_reload_empty_fast" + var_7 + "_04";
    level.player playSound(var_11);
    wait 0.6;
    level.player stopgestureviewmodel("ges_left_arm_damage_reload", 0.7);
    doinjuredgesture();
    wait 0.25;
    level.player scripts\common\utility::allow_ads(1, "rappel");
    level.player scripts\common\utility::allow_fire(1, "rappel");
    level.player scripts\common\utility::allow_melee(1, "rappel");
    level.player.rappel_reloading = undefined;
  }
}

canrappelreload(var_0) {
  var_1["rifle"] = 1;
  var_1["smg"] = 1;
  var_1["spread"] = 1;
  var_1["sniper"] = 1;
  var_1["pistol"] = 1;
  return isDefined(var_1[var_0]);
}

tossclip(var_0) {
  if(!issubstr(var_0.basename, "_pi_")) {
    return;
  }
  var_1 = "weapon_wm_pi_golf21_clip";
  var_2 = spawn("script_model", level.player.origin + anglesToForward(level.player.angles) * 20);
  var_2 setModel(var_1);
  var_2.angles = level.player.angles + (randomintrange(-20, 20), randomintrange(-20, 20), randomintrange(-20, 20));
  var_3 = anglesToForward(level.player.angles) * -1;
  var_3 = var_3 * 80;
  var_4 = var_3[0];
  var_5 = var_3[1];
  var_6 = 90;
  var_2 physicslaunchserver(var_2.origin, (var_4, var_5, var_6));
  var_2 scripts\engine\utility::delaycall(6, ::delete);
}

rappel_nvgs() {
  level endon("rappel_end");

  for(;;) {
    level.player scripts\engine\utility::waittill_either("night_vision_on", "night_vision_off");

    if(!isDefined(level.player.rappel_reloading)) {
      wait 0.3;
      doinjuredgesture();
    }
  }
}

rappel_offhands() {
  level endon("rappel_end");

  for(;;) {
    level.player waittill("smoke_pressed");
    var_0 = 5;
    scripts\engine\sp\utility::display_hint("rappel_offhands", var_0, undefined, level, "rappel_end");
    wait(var_0);
  }
}

rappel_bump(var_0) {
  playFX(scripts\engine\utility::getfx("vfx_estate_cliff_stones_01"), level.player.origin + anglesToForward(level.player.animarms.angles) * -15);
  level.player playrumblelooponentity("tank_rumble");
  wait(var_0);
  level.player stoprumble("tank_rumble");
  level.player playRumbleOnEntity("damage_heavy");
  wait 0.25;
}

spawn_price_infill() {
  level.price = scripts\engine\sp\utility::spawn_targetname("price_mill_spawner", 1);
  level.price.animname = "price";
  level.price scripts\common\ai::magic_bullet_shield(1);
  level.price scripts\common\utility::demeanor_override("cqb");
  level.price.ignoreall = 1;
  level.price.name = "Captain Price";
  level.price scripts\engine\sp\utility::set_force_color("p");
  level.price.pushable = 0;
  level.price.script_pushable = 0;
  level.price.nvgmodel_off = level.price.hatmodel;
  level.price.nvgmodel_on = scripts\engine\sp\utility::getmodel("price_nvgs_on");
  level.price thread nvg_eyelights_thread();
  level.price.rifle = scripts\sp\maps\estate\estate_util.gsc::make_price_rifle();
  level.price scripts\anim\shared.gsc::forceuseweapon(level.price.rifle, "primary");
  level.price.sidearm = scripts\sp\maps\estate\estate_util.gsc::make_price_pistol(1);
  level.price scripts\common\utility::initweapon(level.price.sidearm);
  level.price scripts\anim\shared.gsc::placeweaponon(level.price.sidearm, "thigh");
  var_0 = scripts\sp\maps\estate\estate_util.gsc::make_price_ar();
  level.price scripts\common\utility::initweapon(var_0);
  level.price scripts\anim\shared.gsc::placeweaponon(var_0, "back");
  setdvarifuninitialized("debug_cutters", 0);
  level.cutters = scripts\engine\sp\utility::spawn_anim_model("bolt_cutters", level.price.origin);
  level.cutters linkTo(level.price, "tag_shield_back", (0, 0, 0), (0, 0, 0));
  thread debug_cutters();
  level.rope = scripts\engine\sp\utility::spawn_anim_model("rope", level.price.origin);
  level.rope linkTo(level.price, "tag_stowed_hip_rear", (0, 0, 0), (0, 0, 0));
}

nvg_eyelights_thread() {
  self endon("death");
  var_0 = scripts\engine\utility::getfx("nvg_eyelights");
  var_1 = 0;

  for(;;) {
    waitframe();

    if(!isDefined(self.visor_down)) {
      continue;
    }
    if(self.visor_down == var_1) {
      continue;
    }
    if(self.visor_down) {
      wait 0.4;
      playFXOnTag(var_0, self, "j_nvg");
    } else
      stopFXOnTag(var_0, self, "j_nvg");

    var_1 = self.visor_down;
  }
}

stayahead_values_tallgrass(var_0) {
  scripts\sp\utility::set_stayahead_values(1, 220, 50, 0.2);
  scripts\sp\utility::set_stayahead_values(2, 170, 0, 0.1);
  scripts\sp\utility::set_stayahead_values(3, 120, -150, 0.2);
  scripts\sp\utility::set_stayahead_values(4, 120, -250, 0.2);

  if(!istrue(var_0)) {
    scripts\sp\utility::set_stayahead_wait_values(-350, 1.5);
    scripts\sp\utility::set_stayahead_wait_nodes(getnodearray("tall_grass_wait", "targetname"));
  }

  scripts\sp\utility::enable_stayahead(level.player);
}

cutters_stress_test() {
  for(;;) {
    wait 2;
    level.cutters unlink();
    wait 2;
    level.cutters linkTo(level.price, "tag_shield_back", (0, 0, 0), (0, 0, 0));
  }
}

debug_cutters() {
  level.cutters endon("death");

  for(;;) {
    if(getdvarint("debug_cutters"))
      level.price thread scripts\sp\debug::drawtag("tag_shield_back");

    waitframe();
  }
}

player_stay_behind_ai(var_0) {
  level endon("stop_player_stay_behind");
  setsaveddvar("OLMLOTTLRM", 1.15);
  var_1 = scripts\engine\utility::ter_op(!isDefined(var_0), 22500, var_0 * var_0);
  var_2 = 0.5;
  var_3 = 0.7;

  if(!isDefined(level.player.movespeedscale))
    level.player.movespeedscale = 1;

  for(;;) {
    var_4 = sortbydistance(level.friendlies, level.player.origin)[0];
    var_5 = distancesquared(level.player.origin, var_4.origin);
    var_6 = scripts\engine\math::normalize_value(0, var_1, var_5);
    var_6 = clamp(var_6, var_3, 1);
    var_7 = var_6 - level.player.movespeedscale;
    var_8 = var_7 * var_2;
    var_9 = level.player.movespeedscale + var_8;
    level.player setmovespeedscale(var_9);
    level.player.movespeedscale = var_9;
    wait 0.05;
  }
}

shutdown_player_stay_behind_ai() {
  setsaveddvar("OLMLOTTLRM", 1.4);
  level notify("stop_player_stay_behind");
  thread scripts\engine\sp\utility::blend_movespeedscale_default(1);
}