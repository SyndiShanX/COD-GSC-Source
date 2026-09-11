/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\estate\estate_infil.gsc
***************************************************/

function estate_infil_precache() {
  precachemodel("weapon_wm_pi_golf21_clip");
  precachemodel("misc_coiled_rope");
  getEnt("new_rappel_node", "targetname") hide();
  getEnt("rappel_anim_struct", "targetname") delete();
  scripts\engine\sp\utility::add_hint_string("light_meter", &"ESTATE/LIGHT_METER");
  precachestring(&"ESTATE/RAPPEL_HINT");
  scripts\engine\sp\utility::add_hint_string("rappel_offhands", &"ESTATE/RAPPEL_OFFHANDS");
}

function ismoving() {
  return level.player getnormalizedmovement()[0] > 0;
}

function estate_infil_flags() {
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

function intro_start() {
  spawn_price_infill();
}

function intro_main() {
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
  level.player setclienttriggeraudiozone("estate_intro_mix", 5);
  level.player scripts\engine\utility::delaycall(12, &clearclienttriggeraudiozone, 1);
  var0 = scripts\engine\utility::getStruct("intro_animnode", "targetname");
  var1 = scripts\common\vehicle::spawn_vehicle_from_targetname("intro_technical");
  level.intro_technical = var1;

  foreach(var3 in ["left", "right"]) {
    playFXOnTag(scripts\engine\utility::getfx("vfx_estate_technical_headlight_intro_" + var3), var1, "tag_light_front_" + var3);
    playFXOnTag(scripts\engine\utility::getfx("vfx_estate_technical_brakelight_intro_" + var3), var1, "tag_light_back_" + var3);
  }

  var1 scripts\engine\sp\utility::assign_animtree("technical");
  var1.mgturret[0] delete();
  var5 = spawn("script_model", var1 gettagorigin("tag_turret"));
  var5 setModel("veh8_civ_lnd_decho_rebel_mg_armored_darkblue");
  var5 scripts\engine\sp\utility::assign_animtree("turret");
  var6 = spawn("script_model", var5 gettagorigin("tag_aim_animated"));
  var6 setModel("ee_electronics_mg_searchlight");
  var6 linkTo(var5, "tag_aim_animated", (0, 0, 0), (0, 0, 0));
  var7 = scripts\engine\utility::spawn_tag_origin(var6.origin, var6.angles);
  var7 linkTo(var6, "tag_origin", (7.5, -3.5, 2.5), (0, 0, 0));
  playFXOnTag(scripts\engine\utility::getfx("vfx_estate_technical_searchlight_intro"), var7, "tag_origin");
  var8 = scripts\engine\sp\utility::spawn_targetname("intro_technical_gunner");
  var8.animname = "gunner";
  var9 = getscriptablearray("intro_police_car", "targetname")[0];
  var9 scripts\engine\sp\utility::assign_animtree("police_car");
  var10 = scripts\engine\sp\utility::spawn_targetname("intro_kyle");
  var10.animname = "kyle";
  var11 = var0 scripts\sp\player_rig::link_player_to_rig("intro", "stand", 0, undefined, 1);
  var11 hide();
  var11.body = var10;
  level.player hidelegsandshadow();
  var12 = [var1, var5, var10, var8, var11, level.price];
  var0 scripts\common\anim::anim_first_frame(var12, "intro");
  var9.origin = getstartorigin(var0.origin, var0.angles, var9 scripts\engine\utility::getanim("intro"));
  var9.angles = getstartangles(var0.origin, var0.angles, var9 scripts\engine\utility::getanim("intro"));
  level.intro_ents = [var7, var6, var5, var1, var8, var10];
  thread skip_intro(var0, var9);
  var13 = level scripts\engine\utility::waittill_notify_or_timeout_return("intro_skipped", 3);

  if(var13 == "timeout") {
    level.intro_started = 1;
    thread scripts\sp\hud_util::fade_in(1, "black");
    var0 thread scripts\common\anim::anim_single([var1, var5, var8], "intro");
    var9 setanim(var9 scripts\engine\utility::getanim("intro"), 1);
    var0 thread scripts\common\anim::anim_single([var10, level.price], "intro");
    var0 scripts\common\anim::anim_single_solo(var11, "intro");
    scripts\sp\utility::userskip_stop();
    cleanup_intro_ents();
  } else {
    level.player_rig waittillmatch("single anim", "end");
  }

  level scripts\engine\sp\utility::dof_disable();
  level.price scripts\engine\sp\utility::dof_disable_autofocus();
  level.intro_technical = undefined;
  level.intro_started = undefined;
  scripts\sp\player_rig::unlink_player_from_rig();
  setsaveddvar("TLMMOPMSK", 0);
  setomnvar("ui_hide_weapon_info", 0);
}

function cleanup_intro_ents() {
  if(!isDefined(level.intro_ents)) {
    return;
  }

  foreach(var1 in level.intro_ents) {
    if(var1 scripts\common\vehicle::isvehicle()) {
      scripts\engine\utility::array_delete(var1.riders);
    }

    var1 delete();
  }

  level.intro_ents = undefined;
}

function skip_intro(var0, var1) {
  var2 = scripts\sp\utility::userskip_wait();

  if(!var2) {
    return;
  }

  level notify("intro_skipped");
  scripts\sp\hud_util::fade_out(0);
  cleanup_intro_ents();

  if(!isDefined(level.intro_started)) {
    var1 setanim(var1 scripts\engine\utility::getanim("intro"), 1);
    var0 thread scripts\common\anim::anim_single_solo(level.price, "intro");
    var0 thread scripts\common\anim::anim_single_solo(level.player_rig, "intro");
    waitframe();
  }

  var3 = level.price scripts\engine\utility::getanim("intro");
  var4 = getanimlength(var3);
  var5 = var4 - 1.5;
  level.price setanimtime(var3, var5 / var4);

  foreach(var7 in [level.player_rig, var1]) {
    var8 = var7 scripts\engine\utility::getanim("intro");
    var9 = getanimlength(var8);
    var7 setanimtime(var8, var5 / var9);
  }

  level.player lerpfovscalefactor(1, 0);
  level.player_rig show();
  getrandomnodedestination(0, 0);
  thread scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_intro_forest_10");
  scripts\engine\utility::delaythread(0.05, &scripts\sp\hud_util::fade_in, 0.05);
}

function intro_catchup() {}

function light_meter_hint(var0) {
  if(scripts\engine\utility::flag("did_light_meter_hint")) {
    return;
  }

  if(isDefined(var0)) {
    level thread scripts\engine\sp\utility::notify_delay("stop_light_meter_hint", var0);
    level endon("stop_light_meter_hint");
  }

  for(;;) {
    while(!scripts\sp\nvg\nvg_player::is_nvg_on()) {
      waitframe();
    }

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

function tall_grass_start() {
  spawn_price_infill();
  scripts\engine\sp\utility::set_start_location("tall_grass", [level.player, level.price]);
  level.player modifybasefov(50, 0.05);
}

function tall_grass_main() {
  thread infil_lightmeter();
  thread scripts\sp\maps\estate\estate_lighting::lerp_woods_sunlight();
  thread scripts\sp\maps\estate\estate_util::stealth_init();
  thread gate_light_watcher();
  thread scripts\engine\utility::exploder("millexit");
  scripts\engine\sp\objectives::objective_add("estate", "current", undefined, &"ESTATE/OBJ_DESC_FIND_ENTRANCE");
  setsaveddvar("MMLNNQSTTL", 0);
  thread tall_grass_birds();
  scripts\engine\sp\utility::flagwaitthread("price_poi", &toggle_price_poi, 1);
  var0 = scripts\engine\utility::getStructArray("tall_grass_spline_stayahead", "targetname");

  foreach(var2 in var0) {
    if(scripts\engine\utility::is_equal(var2.script_noteworthy, "price")) {
      level.price scripts\engine\utility::delaythread(2, &stayahead_values_tallgrass);
      level.price scripts\engine\utility::set_movement_speed(56);
      level.price thread scripts\sp\spawner::go_to_node(var2);
      break;
    }
  }

  level.price scripts\engine\sp\utility::disable_ai_color();
  thread vo_tall_grass();
  scripts\engine\sp\utility::autosave_by_name("tall_grass");
  scripts\engine\utility::flag_wait("at_woods");
  scripts\engine\utility::stop_exploder("millexit");
  thread scripts\sp\maps\estate\estate_util::delete_noteworthy_ents("tall_grass_ent");
}

function infil_lightmeter() {
  wait 0.15;
  setomnvar("ai_fulllight", 1);
  setomnvar("ai_nolight", 0.9);
}

function toggle_price_poi(var0) {
  if(var0) {
    level.price scripts\asm\shared\utility::toggle_poiauto(1, 35, 45, -5, 0);
    level.price.aimspeedoverride = 7;
    return;
  }

  level.price scripts\asm\shared\utility::toggle_poiauto(0);
  level.price.aimspeedoverride = undefined;
}

function tall_grass_birds() {
  scripts\engine\sp\utility::trigger_wait_targetname("tall_grass_birds");
  scripts\engine\utility::exploder("birdshoot");
  scripts\engine\utility::play_sound_in_space("scn_estate_birds_fly_up", (10726, 8459, 1294));
}

function tall_grass_catchup() {
  scripts\engine\sp\objectives::objective_add("estate", "current", undefined, &"ESTATE/OBJ_DESC_FIND_ENTRANCE");
  thread scripts\sp\maps\estate\estate_util::delete_noteworthy_ents("tall_grass_ent");

  if(!scripts\sp\starts::is_after_start("Woods")) {
    thread scripts\sp\maps\estate\estate_lighting::lerp_woods_sunlight();
  }

  if(!scripts\sp\starts::is_after_start("obj_room")) {
    thread scripts\sp\maps\estate\estate_util::stealth_init();
    return;
  }
}

function vo_tall_grass() {
  wait 1.5;
  scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_intro_forest_60");
  thread vo_keep_up_nags("flashlights_go");
  scripts\engine\utility::flag_wait("flashlights_go");
  scripts\sp\maps\estate\estate_util::kyle_line("dx_vom_kyle_intro_forest_20");
  scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_intro_forest_30");
  scripts\sp\maps\estate\estate_util::kyle_line("dx_vom_kyle_intro_forest_40");
  scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_intro_forest_50");
  thread vo_keep_up_nags("at_woods");
}

function vo_keep_up_nags(var0, var1) {
  level.player endon("death");

  if(isDefined(var1)) {
    level.keep_up_nags = var1;
    level.keep_up_nag_counter = 0;
  } else if(!isDefined(level.keep_up_nags)) {
    level.keep_up_nags = ["dx_vom_pri_woods_obj_100", "dx_vom_pri_woods_obj_110", "dx_vom_pri_woods_obj_120", "dx_vom_pri_woods_obj_130", "dx_vom_pri_woods_obj_140", "dx_vom_pri_woods_obj_150"];
    level.keep_up_nag_counter = 0;
  }

  level notify("stop_keep_up_nags");
  level endon("stop_keep_up_nags");
  wait 5;

  while(!scripts\engine\utility::flag(var0)) {
    var2 = vectorNormalize(level.price.velocity);

    if(distancesquared(level.player.origin, level.price.origin) < 90000 || vectordot(var2, level.player.origin - level.price.origin) > 0) {
      waitframe();
      continue;
    }

    thread scripts\sp\maps\estate\estate_util::price_line(level.keep_up_nags[scripts\sp\maps\estate\estate_util::abs_int(level.keep_up_nag_counter % level.keep_up_nags.size)]);
    level.keep_up_nag_counter++;
    scripts\engine\utility::flag_wait_or_timeout(var0, randomfloatrange(8, 13));
  }
}

function actor_die_when_shot(var0) {
  if(issubstr(self.animname, "ru")) {
    self endon("overboard");
  }

  if(isDefined(var0)) {
    scripts\engine\utility::waittill_any("damage", "shot");
  } else {
    self waittill("shot");
  }

  if(isDefined(self.magic_bullet_shield)) {
    scripts\common\ai::stop_magic_bullet_shield();
  }

  self.allowdeath = 1;
  self kill();
}

function price_kill(var0, var1) {
  level.price.ignoreall = 0;
  level.price.dontevershoot = 1;
  var2 = level.price.gunposeoverride;
  level.price scripts\common\ai::set_gunpose("disable");
  level.price scripts\engine\sp\utility::set_favoriteenemy(var0);
  level.price.baseaccuracy = 10;
  price_kill_logic(var0, var1);
  level.price.gunposeoverride = var2;
  level.price scripts\sp\utility::stop_aiming();
  level.price.baseaccuracy = 1;
}

function price_kill_logic(var0, var1) {
  if(!isalive(var0)) {
    return;
  }

  var0 endon("death");
  waittill_price_aims_or_guy_dies(var0);
  var2 = 1;

  if(istrue(var1)) {
    var2 = 0;
  }

  level.price scripts\sp\utility::aim_at(var0 getEye(), var2, "tag_laser", 0.5);
  level.price scripts\sp\utility::link_aim_to(var0, "tag_eye", (0, 0, 0));

  if(istrue(var1)) {
    while(!level.price cansee(var0)) {
      waitframe();
    }

    level.price thread scripts\sp\utility::aim_at_laser_on(1);
    wait 0.1;
  }

  level.price shoot(10, var0 getEye());
  level.price.aim_target unlink();
  waitframe();

  if(isDefined(var0.magic_bullet_shield)) {
    var0 scripts\common\ai::stop_magic_bullet_shield();
  }

  playFXOnTag(scripts\engine\utility::getfx("vfx_blood_sniper_shot"), var0, "tag_eye");
  var0 playsoundatviewheight("bullet_large_flesh_head_npc");
  waitframe();
  var0 kill(var0 getEye(), level.price);
}

function waittill_price_aims_or_guy_dies(var0, var1) {
  var0 endon("death");
  var2 = cos(10);
  var3 = 0;
  var4 = 0;
  var5 = 13;

  if(!isDefined(var1)) {
    var1 = ["j_mainroot", "j_spine4", "tag_eye"];
    goto LOC_00000047;
  }

  jumpiftrue(isarray(var1)) LOC_00000047;
  var1 = [var1];

  for(;;) {
    foreach(var7 in var1) {
      if(scripts\engine\utility::within_fov(level.price gettagorigin("tag_flash"), level.price gettagangles("tag_flash"), var0 gettagorigin(var7), var2)) {
        var4 = 1;
        break;
      }
    }

    if(var4 && !level.price.arriving) {
      var3++;

      if(var3 >= var5) {
        return 1;
      }
    } else {
      var3 = 0;
      var4 = 0;
    }

    waitframe();
  }
}

function woods_start() {
  thread infil_lightmeter();
  spawn_price_infill();
  level.price scripts\engine\sp\utility::disable_ai_color();
  scripts\engine\sp\utility::set_start_location("woods_start", [level.player, level.price]);
  thread gate_light_watcher();
  level.player modifybasefov(50, 0.05);
  stayahead_values_tallgrass(level.price);
  level.price thread scripts\sp\spawner::go_to_node(scripts\engine\utility::getStruct("friendly_woods_spline_stayahead", "targetname"));
  toggle_price_poi(1);
}

function woods_main() {
  thread woods_hide_moon();
  thread gate_chain_init();
  thread vo_woods();
  thread woods_price_nvgs();
  thread scripts\engine\sp\utility::autosave_by_name("woods");
  setsaveddvar("MMLNNQSTTL", 0);
  scripts\engine\sp\utility::flagwaitthread("woods_split", &spawn_infil_bodies);
  scripts\engine\sp\utility::flagwaitthread("woods_split", &toggle_price_poi, 0);
  var0 = getEnt("lerp_fov_trig", "targetname");
  var0 thread scripts\sp\maps\estate\estate_util::lerp_fov_over_distance_trigger();
  scripts\engine\utility::flag_wait("gate_approach");
  thread scripts\sp\maps\estate\estate_util::delete_noteworthy_ents("woods_ent");
  setomnvar("ai_fulllight", 0.0015);
  setomnvar("ai_nolight", 0.001);
}

function woods_hide_moon() {
  level waittill("hide_moon");
  scripts\engine\utility::array_call(getEntArray("moon", "targetname"), &hide);
}

function vo_light_nag_if_not_shot() {
  if(!scripts\engine\utility::flag("light_shot")) {
    scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_woods_traverse_100");
    return;
  }
}

function vo_woods() {
  scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_woods_obj_50");
  wait 0.2;
  scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_woods_obj_60");
  thread vo_keep_up_nags("woods_split");
  scripts\engine\utility::flag_wait("woods_split");
  thread woods_gate_enemy_audio();
  wait 1.5;
  scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_woods_obj_70");
  wait 2;
  scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_woods_obj_80");
  thread vo_keep_up_nags("gate_approach");
}

function woods_gate_enemy_audio() {
  thread scripts\engine\utility::play_sound_in_space("scn_estate_infil_ak_shots_fired", (8234, 6426, 1327));
}

function woods_price_nvgs() {
  scripts\engine\utility::flag_wait("woods_split");
  wait 1;
  level.price scripts\sp\utility::stayahead_disable_wait();
  level.price scripts\sp\utility::stayahead_pause(1);
  level.price scripts\engine\utility::set_movement_speed(110);
  level.price.visor_down = 0;
  var0 = undefined;

  while(!scripts\engine\utility::is_equal(var0, "gesture_finish") || !level.price.visor_down) {
    level.price scripts\asm\gesture::ai_request_gesture("nvg_on", undefined, 999999, "nvg_gesture");
    level.price waittill("nvg_gesture", var0);
  }

  level.price scripts\asm\asm_sp::asm_trynvgmodelswap();
  level.price scripts\sp\utility::stayahead_pause(0);
  level.price.nvgs_on = 1;
  level.price notify("nvgs_on");
}

function woods_catchup() {
  thread scripts\sp\maps\estate\estate_util::delete_noteworthy_ents("woods_ent");

  if(!scripts\sp\starts::is_after_start("rappel")) {
    level.price thread scripts\sp\maps\estate\estate_util::gesture_nvgs(1);
    level.price scripts\asm\asm_sp::asm_trynvgmodelswap();
    return;
  }
}

function gate_start() {
  spawn_price_infill();
  level.price.nvgs_on = 1;
  stayahead_values_tallgrass(level.price, 1);
  scripts\engine\sp\utility::set_start_location("bushes_start", [level.player, level.price]);
  thread gate_light_watcher();
  thread gate_chain_init();
  spawn_infil_bodies();
}

function gate_main() {
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
  var0 = scripts\engine\sp\utility::array_spawn_targetname("bushes_spawners", 1);

  foreach(var2 in var0) {
    scripts\engine\sp\utility::add_cleanup_ent(var2, "gate_ents");
    thread battlechatter_off_spawn_func();
    thread gate_enemy_goes_hot();
    var2 scripts\engine\sp\utility::set_grenadeweapon("molotov flash");
    var2 scripts\engine\sp\utility::set_grenadeammo(4);
  }

  scripts\engine\utility::array_thread(var0, &gate_enemy_react_to_sprinting);
  var4 = getscriptablearray("gate_enemy_spotlight", "targetname")[0];

  if(var4 getscriptablepartstate("onoff") != "on") {
    scripts\engine\utility::array_call(var0, &aieventlistenerevent, "light_killed", var4, var4.lightpos);
  }

  var0 = scripts\engine\sp\utility::array_spawn_targetname("body_poker", 1);
  scripts\engine\utility::array_thread(var0, &body_poker_think);
  scripts\engine\utility::array_thread(var0, &gate_enemy_react_to_sprinting);
  scripts\engine\utility::array_thread(var0, &scripts\engine\sp\utility::set_grenadeweapon, "molotov flash");
  scripts\engine\utility::array_thread(var0, &scripts\engine\sp\utility::set_grenadeammo, 4);
  thread vo_body_poking(var0);

  if(var4 getscriptablepartstate("onoff") != "on") {
    scripts\engine\utility::array_call(var0, &aieventlistenerevent, "light_killed", var4, var4.lightpos);
  }

  scripts\engine\sp\utility::flagwaitthread("bushes_exit_patrol_go", &scripts\engine\sp\utility::cleanup_ents_removing_bullet_shield, "gate_ents");
  scripts\engine\utility::flag_wait("nvg_off_bushes");
  thread price_stealth_reprimand();
  scripts\engine\utility::flag_set("body_drag_dumpster_go");
  scripts\engine\utility::flag_wait_any("price_gate_anim_done", "stealth_spotted");
  scripts\engine\utility::delaythread(2, &light_meter_hint);

  if(!scripts\engine\utility::flag("stealth_spotted")) {
    level.price scripts\engine\sp\utility::clear_force_color();
    level.price scripts\engine\sp\utility::set_force_color("p");
    level.price scripts\engine\sp\utility::set_goal_radius(60);
  }

  level.price_color_trigger = 3;
  scripts\engine\utility::flag_wait("price_behind_building");
}

function battlechatter_off_spawn_func() {
  self endon("death");

  while(!istrue(self.battlechatterallowed)) {
    wait 0.1;
  }

  scripts\engine\sp\utility::set_battlechatter(0);
}

function price_stealth_reprimand() {
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

  if(!istrue(level.price.speaking)) {
    scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_woods_traverse_420");
    return;
  }
}

function spawn_infil_bodies() {
  var0 = scripts\engine\utility::getStructArray("infil_body", "script_noteworthy");

  foreach(var2 in var0) {
    var3 = var2 scripts\sp\maps\estate\estate_util::spawn_dead_body();
    var3.animname = "body1";
    var3 scripts\engine\sp\utility::assign_animtree();
    var2 scripts\common\anim::anim_first_frame_solo(var3, var2.script_parameters);
    var2.body = var3;
  }
}

function body_poker_think() {
  self.animname = "alq1";
  thread gate_enemy_goes_hot();
  scripts\engine\sp\utility::add_cleanup_ent(self, "gate_ents");
  scripts\engine\sp\utility::set_battlechatter(0);
  var0 = self.target;
  self.target = undefined;
  scripts\engine\utility::flag_wait("nvg_off_bushes");

  while(isalive(self) && !self[[self.fnisinstealthidle]]()) {
    if(!self[[self.fnisinstealthinvestigate]]()) {
      return;
    }

    scripts\engine\utility::waittill_any("stealth_idle", "stealth_combat", "death");
  }

  jumpiftrue(isalive(self)) LOC_0000007b;
  return;
}

function vo_body_poking(var0) {
  foreach(var2 in var0) {
    var2 endon("stealth_combat");
    var2 endon("death");
  }

  scripts\engine\utility::flag_wait("nvg_off_bushes");
  wait randomfloatrange(0.3, 1.1);
  var4 = ["dx_vom_aq4_woods_traverse_150", "dx_vom_aq3_woods_traverse_160", "dx_vom_aq4_woods_traverse_170", "dx_vom_aq3_woods_traverse_180", "dx_vom_aq4_woods_traverse_190", "dx_vom_aq3_woods_traverse_200", "dx_vom_aq4_woods_traverse_210"];

  for(var5 = 0; var5 < var4.size; var5++) {
    var0[var5 % 2] scripts\engine\sp\utility::smart_dialogue_generic(var4[var5]);
    wait randomfloatrange(0.15, 0.25);
  }
}

function gate_enemy_react_to_sprinting() {
  scripts\engine\utility::ent_flag_wait("stealth_enabled");
  self.sprintfootstepradius = 400;
  scripts\stealth\utility::set_stealth_func("event_investigate", &gate_enemy_stealth_filter);
  scripts\stealth\utility::set_stealth_func("event_cover_blown", &gate_enemy_stealth_filter);
}

function gate_enemy_stealth_filter(var0) {
  if(var0.typeorig == "footstep_sprint") {
    if(!isDefined(self.footsteps_heard)) {
      self.footsteps_heard = 0;
    }

    self.footsteps_heard++;

    if(self.footsteps_heard > 5) {
      var0.type = "combat";
    }
  }

  return false;
}

function gate_enemy_goes_hot() {
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

function price_hot_or_not() {
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

    if(level.price isinscriptedstate()) {
      level.price scripts\engine\sp\utility::anim_stopanimScripted();
    }

    scripts\engine\utility::flag_waitopen("stealth_spotted");
    price_hot_cleanup();
  }
}

function price_hot_cleanup() {
  level.price scripts\engine\sp\utility::set_force_color("p");
  level.price.ignoreall = 1;
  level.price scripts\common\utility::demeanor_override("cqb");
  level.price.script_pushable = 0;
}

function price_color_trigger_set(var0) {
  var1 = getEnt("woods_color_trigger_" + var0, "targetname");
  var1 notify("trigger");
}

function vo_gate() {
  level endon("stealth_spotted");
  level waittill("cut_gate");
  scripts\engine\utility::delaythread(2, &scripts\sp\maps\estate\estate_util::price_line, "dx_vom_pri_woods_traverse_110");
  level waittill("gate_open");
  scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_woods_traverse_120");
  setmusicstate("mx_tmp_estate_burning_bodies");
  scripts\engine\utility::flag_wait("nvg_off_bushes");
  scripts\engine\utility::flag_wait("price_gate_anim_done");
  wait 1.3;
  scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_woods_traverse_230");
  var0 = ["dx_vom_pri_woods_traverse_231", "dx_vom_pri_woods_traverse_232", "dx_vom_pri_woods_traverse_233"];
  GscBinSkip4(0x35, "price_behind_building", var0);
}

#using_animtree("script_model");

function price_gate_anim() {
  level endon("stealth_spotted");
  var0 = scripts\engine\utility::getStruct("gl_walk_animnode", "targetname");

  if(!isDefined(level.price.nvgs_on)) {
    level.price waittill("nvgs_on");
  }

  level.price scripts\common\ai::set_gunpose("ready");
  thread price_approach_gate(var0);
  var1 = [level.price, level.cutters];
  var2 = initgate(scripts\engine\utility::getStruct("bushes_price_gate", "targetname"), "mill_gate", %est_li_040_chain_gate);
  level.price.disableplayeradsloscheck = 1;
  level.price.anglelerprate = 60;
  var0 scripts\sp\anim::anim_reach_solo(level.price, "infil_gate_arrival");
  level.price.disableplayeradsloscheck = 0;
  level.cutters unlink();
  var0 scripts\common\anim::anim_single(var1, "infil_gate_arrival");
  level.price.anglelerprate = 540;
  var0 = scripts\engine\utility::getStruct("bushes_price_gate", "targetname");

  if(!scripts\engine\utility::flag("light_shot")) {
    level.price thread scripts\sp\maps\estate\estate_util::notetrack_nag(["dx_vom_pri_woods_traverse_90", "dx_vom_pri_woods_gate_10", "dx_vom_pri_woods_gate_20", "dx_vom_pri_woods_gate_30"], "light_shot");
    var0 thread scripts\common\anim::anim_loop(var1, "infil_gate_idle", "stop_loop");
    level.price scripts\common\utility::lookatentity(level.player, 0);
    scripts\engine\utility::flag_wait("light_shot");
    level.price scripts\common\utility::lookatentity();
    level.price notify("stop_reaction_look");
    var0 notify("stop_loop");
  }

  level notify("cut_gate");
  var2.prop scripts\engine\utility::delaycall(1, &connectpaths);
  level scripts\engine\utility::delaythread(1, &relink_cutters_on_anim_end);
  var0 scripts\common\anim::anim_single([level.gate_chain, var2, level.price, level.cutters], "infil_gate_cut");
  level notify("gate_open");

  if(!scripts\engine\utility::flag("player_entered_bushes_gate")) {
    var0 thread scripts\common\anim::anim_loop_solo(level.price, "infil_gate_halfway_idle");
    thread stop_idle_on_spotted(var0, "stop_loop");
    scripts\engine\utility::flag_wait("player_entered_bushes_gate");
    var0 notify("stop_loop");
  }

  var0 scripts\common\anim::anim_single_solo(level.price, "infil_gate_halway_moveup");

  if(!scripts\engine\utility::flag("nvg_off_bushes")) {
    var0 thread scripts\common\anim::anim_loop_solo(level.price, "infil_bush_idle");
    thread stop_idle_on_spotted(var0, "stop_loop");
    scripts\engine\utility::flag_wait("nvg_off_bushes");
    var0 notify("stop_loop");
  }

  scripts\engine\utility::delaythread(0.2, &scripts\sp\maps\estate\estate_util::price_line, "dx_vom_pri_woods_traverse_220");
  var0 scripts\common\anim::anim_single_solo(level.price, "infil_bush_alert");
  scripts\engine\utility::flag_set("price_gate_anim_done");
  scripts\engine\sp\utility::flagwaitthread("rappel_start", &scripts\sp\maps\estate\estate_util::delete_at_distance_to_player, var2.origin, 1500, [var2, var2.prop, level.gate_chain]);
  var0 scripts\common\anim::anim_single_solo(level.price, "dumpster_walkby");
  level.price scripts\engine\sp\utility::enable_ai_color();
  level.price scripts\sp\utility::stayahead_pause(0);
  level.price scripts\common\ai::reset_gunpose();
}

function price_approach_gate(var0) {
  var1 = getstartorigin(var0.origin, var0.angles, level.price scripts\engine\utility::getanim("infil_gate_arrival"));
  waitframe();

  while(distancesquared(level.price.origin, var1) > 16384) {
    waitframe();
  }

  level.price scripts\sp\utility::stayahead_pause(1);
  level.price scripts\engine\utility::set_movement_speed(56);
  vo_light_nag_if_not_shot();
}

function gate_nvg_hint() {
  scripts\engine\utility::flag_wait("light_shot");
  wait 3;

  if(!scripts\sp\nvg\nvg_player::is_nvg_on()) {
    thread scripts\sp\nvg\nvg_player::nvg_on_hint(5);
    return;
  }
}

function gate_chain_init() {
  var0 = scripts\engine\utility::getStruct("bushes_price_gate", "targetname");
  level.gate_chain = scripts\engine\sp\utility::spawn_anim_model("gate_chain", var0.origin, var0.angles);
  var0 scripts\common\anim::anim_first_frame_solo(level.gate_chain, "infil_gate_cut");
}

function relink_cutters_on_anim_end() {
  level.cutters scripts\engine\utility::waittill_any("stop_sequencing_notetracks", "single anim");
  level.cutters linkTo(level.price, "tag_shield_back", (0, 0, 0), (0, 0, 0));
}

function stop_idle_on_spotted(var0, var1) {
  var0 endon(var1);
  scripts\engine\utility::flag_wait("stealth_spotted");
  var0 notify("death");
}

function initgate(var0, var1, var2, var3) {
  var4 = getstartorigin(var0.origin, var0.angles, var2);
  var5 = getstartangles(var0.origin, var0.angles, var2);
  var6 = scripts\engine\sp\utility::spawn_anim_model("gate_door", var4, var5);
  var7 = getEntArray(var1, "targetname");
  var8 = undefined;
  var9 = undefined;
  var10 = undefined;

  foreach(var12 in var7) {
    if(var12.classname == "script_brushmodel") {
      var8 = var12;
    }

    if(var12.classname == "script_model") {
      var10 = var12;
      continue;
    }

    if(var12.classname == "script_origin") {
      var9 = var12;
    }
  }

  if(isDefined(var10)) {
    var10 linkTo(var9);
  }

  var8 linkTo(var9);

  if(isDefined(var3)) {
    var9 linkTo(var6, "tag_origin", (0, 0, 0), (0, 0, 0));
  } else {
    var9 linkTo(var6);
  }

  var6.prop = var8;
  var6.geo = var10;
  return var6;
}

function gate_light_watcher() {
  waitframe();
  var0 = getEnt("lights_gate", "targetname");

  while(var0 getscriptablepartstate("onoff") != "death") {
    waitframe();
  }

  scripts\engine\utility::flag_set("light_shot");
}

function gate_catchup() {
  if(!scripts\sp\starts::is_after_start("fusebox_tut")) {
    thread price_hot_or_not();
    return;
  }
}

function fusebox_tut_start() {
  spawn_price_infill();
  stayahead_values_tallgrass(level.price, 1);
  scripts\engine\sp\utility::set_start_location("takedown_start", [level.player, level.price]);

  if(!scripts\sp\starts::is_after_start("Light")) {
    thread price_stealth_reprimand();
    return;
  }
}

#using_animtree("");

function fusebox_tut_main() {
  thread fusebox_switch();
  scripts\engine\utility::delaythread(0.1, &light_tut_light_watcher);
  level.price_color_trigger = 4;
  level.fusebox_animnode = scripts\engine\utility::getStruct("fusebox_tut_animnode", "targetname");
  setsaveddvar("MMLNNQSTTL", 0);
  var0 = initgate(level.fusebox_animnode, "light_tut_entrance_door", %est_li_050_fusebox_tuto_door, 1);
  var0.og_origin = var0.origin;
  var0.og_angles = var0.angles;
  level.light_entrance_gate = var0;
  scripts\engine\utility::flag_wait("move_to_fusebox");

  if(scripts\engine\utility::flag("stealth_spotted")) {
    price_hot_cleanup();
  }

  level.price_color_trigger = 5;
  thread fusebox_door_interact();
  thread fusebox_tut_price();
  thread fusebox_tut_victim();
  thread fusebox_tut_gate();
  thread fusebox_tut_cleanup();
}

function fusebox_tut_cleanup() {
  level waittill("fusebox_tut_complete");
  level.fusebox_animnode = undefined;
  thread scripts\sp\maps\estate\estate_util::delete_noteworthy_ents("melee_ent");
}

function fusebox_switch() {
  var0 = getscriptablearray(level.tut_fusebox.target, "targetname")[0];
  scripts\engine\utility::waittill_any_ents(level.tut_fusebox, "lightswitch_toggle", var0, "death");
  scripts\engine\utility::flag_set("player_used_fusebox");
  level.tut_fusebox scripts\sp\interactables\dynolight::lightswitch_disable(1);
  wait 0.5;

  if(istrue(level.tut_fusebox.destroyed) || var0 getscriptablepartstate("onoff") == "death") {
    level.price stopsounds();
    thread scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_stealth_doublekill_10");
    return;
  }
}

function fusebox_door_interact() {
  if(scripts\engine\utility::flag("player_used_fusebox") || scripts\engine\utility::flag("player_shot_door")) {
    return;
  }

  var0 = scripts\engine\utility::getStruct("fusebox_tut_doorknob", "targetname");
  var0 thread scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SCRIPT/DOOR_HINT_USE_NO_BASH");
  var0 thread scripts\sp\maps\estate\estate_util::door_interact_presentation();
  scripts\engine\utility::flag_wait_any("player_used_fusebox", "player_shot_door");
  scripts\engine\utility::flag_wait("fusebox_price_ready");
  wait 3;
  var0 scripts\sp\player\cursor_hint::remove_cursor_hint();
}

function fusebox_tut_price() {
  thread fusebox_tut_price_breakout();
  level.price endon("breakout");

  if(level.price isinscriptedstate()) {
    level.price waittillmatch("single anim", "end");
    waittillframeend();
  }

  level.price scripts\engine\sp\utility::disable_ai_color();
  level.price scripts\common\ai::set_gunpose("ads");
  level.price.disableplayeradsloscheck = 1;
  level.fusebox_animnode scripts\sp\anim::anim_reach_solo(level.price, "fusebox_tut_arrive");
  level.price.disableplayeradsloscheck = 0;
  thread vo_fusebox();
  level.price thread scripts\engine\utility::waittillmatch_notify("single anim", "end", "arrived");
  level.fusebox_animnode thread scripts\common\anim::anim_single_solo(level.price, "fusebox_tut_arrive");
  var0 = level.price scripts\engine\utility::waittill_any_return("arrived", "go_time");

  if(var0 == "arrived") {
    if(!scripts\engine\utility::flag("player_used_fusebox") && !scripts\engine\utility::flag("player_shot_door")) {
      level.fusebox_animnode thread scripts\common\anim::anim_loop_solo_with_nags(level.price, "fusebox_tut_idle", "stop_loop");
      level.price scripts\common\utility::lookatentity(level.player, 0);
    }

    scripts\engine\utility::flag_wait_any("player_used_fusebox", "player_shot_door");
    level.price scripts\common\utility::lookatentity();
    level.fusebox_animnode notify("stop_loop");
  } else {
    level.price scripts\engine\sp\utility::anim_stopanimScripted();
  }

  level.price scripts\common\ai::reset_gunpose();
  GscBinSkip4(0x35);
}

function vo_fusebox() {
  scripts\engine\utility::flag_wait("fusebox_price_ready");

  if(!scripts\engine\utility::flag("player_used_fusebox") && !scripts\engine\utility::flag("player_shot_door")) {
    level endon("player_used_fusebox");
    level endon("player_shot_door");

    if(distancesquared(level.player.origin, level.price.origin) > 90000) {
      scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_fusebox_tutorial_24");
      var0 = ["dx_vom_pri_fusebox_tutorial_22", "dx_vom_pri_fusebox_tutorial_23", "dx_vom_pri_fusebox_tutorial_24"];
      level.price thread scripts\sp\maps\estate\estate_util::notetrack_nag(var0, ["player_used_fusebox", "player_shot_door", "player_at_fusebox"]);

      while(distancesquared(level.player.origin, level.price.origin) > 90000) {
        waitframe();
      }

      level notify("player_at_fusebox");
    }

    scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_fusebox_tutorial_30");
    var0 = ["dx_vom_pri_fusebox_tutorial_10", "dx_vom_pri_fusebox_tutorial_20", "dx_vom_pri_fusebox_tutorial_21"];
    level.price thread scripts\sp\maps\estate\estate_util::notetrack_nag(var0, ["player_used_fusebox", "player_shot_door"]);
    return;
  }
}

function fusebox_tut_price_breakout() {
  level endon("fusebox_price_committed");
  scripts\engine\utility::flag_wait_any("player_used_fusebox", "player_shot_door");
  scripts\engine\utility::flag_wait("fusebox_price_ready");
  level.price notify("go_time");
  waittillframeend();
  level.fusebox_victim endon("first_pain");
  level.fusebox_victim waittill("breakout");
  level.price notify("breakout");
  level.price scripts\engine\sp\utility::anim_stopanimScripted();
  level.fusebox_animnode scripts\common\anim::anim_single_solo(level.price, "fusebox_tut_breakout");
  thread fusebox_tut_price_finish();
}

function fusebox_tutorial_temp_sounds() {
  level.price playSound("scn_estate_price_kill_door_foley");
  wait 4;
  thread scripts\engine\utility::play_sound_in_space("scn_estate_price_kill_door_barn_door", (6154, 5695, 1114));
  wait 1.8;
  thread scripts\engine\utility::play_sound_in_space("scn_estate_price_kill_door_barn_door_hit", (6217, 5738, 1117));
}

function fusebox_tut_price_finish() {
  var0 = scripts\engine\utility::getStruct("melee_exit_node", "targetname");

  if(!isDefined(level.price.completed_fusebox_tut_anim)) {
    level.price.disableplayeradsloscheck = 1;
    var0 scripts\sp\anim::anim_reach_and_approach_solo(level.price, "melee_exit_end");
    level.price.disableplayeradsloscheck = 0;
  }

  if(!scripts\engine\utility::flag("bushes_exit_patrol_go")) {
    var0 thread scripts\common\anim::anim_loop_solo(level.price, "melee_exit_end_idle");
    scripts\engine\utility::flag_wait("bushes_exit_patrol_go");
    var0 notify("stop_loop");
  }

  var0 thread scripts\common\anim::anim_single_solo(level.price, "melee_exit_end");
  wait 0.1;
  level.price scripts\common\utility::enable_cqbwalk();
  level.price scripts\engine\sp\utility::enable_ai_color();
  level.price scripts\common\ai::set_gunpose("ads");
  level notify("fusebox_tut_complete");
}

function fusebox_tut_victim() {
  scripts\engine\utility::flag_wait_any("player_used_fusebox", "player_shot_door");
  var0 = scripts\engine\sp\utility::spawn_targetname("fusebox_tut_victim", 1);
  level.fusebox_victim = var0;
  var0.shotsfired = 0;
  var0.noragdoll = 1;
  var0 scripts\engine\utility::ent_flag_init("first_pain");
  var0 thread scripts\common\ai::magic_bullet_shield();
  var0 scripts\sp\utility::context_melee_allow(0);
  var0.script_pushable = 0;
  thread victim_damage_monitor();
  var0 scripts\engine\utility::delaythread(1.2, &scripts\sp\anim::play_sound_at_viewheight, "dx_vom_aq4_fusebox_tutorial_40");
  var0 thread scripts\engine\utility::waittillmatch_notify("single anim", "end", "anim_complete");

  if(!scripts\engine\utility::flag("fusebox_price_ready")) {
    level.fusebox_animnode thread scripts\common\anim::anim_first_frame_solo(var0, "fusebox_tut_owned");
    scripts\engine\utility::flag_wait("fusebox_price_ready");
  }

  level.fusebox_animnode thread scripts\common\anim::anim_single_solo(var0, "fusebox_tut_owned");
  var1 = var0 scripts\engine\utility::waittill_any_return("anim_complete", "breakout");

  if(var1 == "breakout") {
    var0.deathanim = level.scr_anim["wrecked"]["fusebox_tut_breakout"];
    var0 scripts\engine\sp\utility::anim_stopanimScripted();
    thread victim_push_back();
  } else {
    var0.a.nodeath = 1;
  }

  if(isDefined(var0.magic_bullet_shield)) {
    var0 scripts\common\ai::stop_magic_bullet_shield();
  }

  var0.allowdeath = 1;
  var0 kill(var0 getEye(), level.price);
}

function victim_damage_monitor() {
  level endon("fusebox_price_committed");
  self endon("first_pain");

  for(;;) {
    self waittill("damage", var0, var1);

    if(var1 == level.player && scripts\engine\utility::flag("fusebox_tut_door_open")) {
      break;
    }
  }

  self notify("breakout");
}

function victim_push_back() {
  var0 = scripts\engine\utility::spawn_script_origin();
  self linkTo(var0);
  var1 = 1;
  var0 moveTo(self.origin - anglesToForward(self.angles) * 60, var1, 0.8, 0.2);
  wait var1;
  var0 delete();
}

function fusebox_tut_gate() {
  var0 = level.light_entrance_gate;
  thread gate_damage_monitor();
  scripts\engine\utility::flag_wait_any("player_used_fusebox", "player_shot_door");
  scripts\engine\utility::flag_wait("fusebox_price_ready");
  var0.prop connectpaths();
  level.fusebox_animnode scripts\common\anim::anim_single_solo(var0, "fusebox_tut_owned");
}

function gate_damage_monitor() {
  level endon("player_used_fusebox");
  self.geo setCanDamage(1);

  for(;;) {
    self.geo waittill("damage", var0, var1);

    if(var1 == level.player) {
      break;
    }
  }

  scripts\engine\utility::flag_set("player_shot_door");
  wait 0.5;

  if(scripts\engine\utility::flag("fusebox_price_ready")) {
    level.price stopsounds();
    thread scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_estate_stealth_60");
    return;
  }
}

function fusebox_tut_catchup() {
  thread scripts\sp\maps\estate\estate_util::delete_noteworthy_ents("melee_ent");
}

function light_tutorial_start() {
  spawn_price_infill();
  stayahead_values_tallgrass(level.price, 1);
  var0 = getEntArray("light_tut_entrance_door", "targetname");

  foreach(var2 in var0) {
    if(var2.classname == "script_brushmodel") {
      var2.origin += (0, 0, 100);
      var2 notsolid();
    }

    var2 delete();
  }

  scripts\engine\utility::delaythread(0.1, &light_tut_light_watcher);
  scripts\engine\sp\utility::set_start_location("light_tutorial_start", [level.player, level.price]);
  level.price_color_trigger = 7;
  price_color_trigger_set(level.price_color_trigger);
  level.price scripts\common\ai::set_gunpose("ads");
}

function light_tutorial_main() {
  scripts\engine\utility::flag_wait("bushes_exit_patrol_go");
  thread vo_light_tut();
  thread start_light_tut_on_player_view();
  scripts\engine\sp\utility::array_spawn_function_targetname("light_tutorial_spawners", &light_enemy_spawn_func);
  var0 = scripts\engine\sp\utility::array_spawn_targetname("light_tutorial_spawners", 1);
  thread light_tutorial_events_watcher();
  scripts\engine\sp\utility::flagwaitthread("stealth_spotted", &scripts\engine\sp\utility::battlechatter_on, "axis");
  thread transient_unload_light_tut();
  price_kills_right_side_light_enemies_then_goes_hot();
  scripts\engine\utility::flag_wait("light_enemies_dead");
  scripts\engine\sp\utility::autosave_by_name("light_tut_end");
  level.price scripts\common\ai::set_gunpose("ready");
  thread price_exits_light_tut();

  if(!scripts\engine\utility::flag("bushes_price_exit")) {
    thread vo_keep_up_nags("bushes_price_exit");
  }

  scripts\engine\utility::flag_wait("bushes_price_exit");
  thread scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_tut_lights_90");
  thread scripts\sp\maps\estate\estate_util::delete_noteworthy_ents("light_tut_ent");
}

function transient_unload_light_tut() {
  if(isDefined(level.light_entrance_gate)) {
    scripts\engine\utility::flag_wait("light_area_halfway");
    level.light_entrance_gate.origin = level.light_entrance_gate.og_origin;
    level.light_entrance_gate.angles = level.light_entrance_gate.og_angles;
    scripts\engine\sp\utility::transient_unload("estate_infil_start_tr");
    return;
  }
}

function price_shoots_light_timeout() {
  wait 20;

  if(scripts\engine\utility::flag("tutorial_light_shot") || scripts\engine\utility::flag("light_enemies_dead") || scripts\engine\utility::flag("light_tut_hot") || scripts\engine\utility::flag("light_enemy_killed")) {
    return;
  }

  scripts\engine\utility::flag_set("tutorial_light_shot");
  level.price stopsounds();
  waitframe();
  thread scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_tut_lights_25");
  level.price.dontevershoot = 1;
  level.price.ignoreall = 0;
  var0 = getEnt("light_tutorial_light", "targetname");
  level.price thread scripts\sp\utility::aim_at(var0.origin);

  while(!scripts\engine\utility::within_fov(level.price gettagorigin("tag_flash"), level.price gettagangles("tag_flash"), var0.origin, cos(5))) {
    waitframe();
  }

  magicbullet(level.price.rifle, level.price gettagorigin("tag_flash"), var0.origin);
  wait 0.15;
  level.price scripts\sp\utility::stop_aiming();
  var0.alive = 0;
  var0.intensity = 0;
  var0 setscriptablepartstate("onoff", "death");
}

function start_light_tut_on_player_view() {
  waitframe();
  var0 = scripts\stealth\utility::get_group("left");
  var1 = scripts\stealth\utility::get_group("right");
  thread set_flag_when_dead(var1, "light_right_enemies_dead");
  var2 = scripts\engine\utility::array_combine(var0, var1);
  thread vo_light_enemies_convo(var0, var1);

  for(;;) {
    foreach(var4 in var2) {
      if(scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var4 getEye(), cos(50)) && scripts\engine\trace::ray_trace_passed(level.player getEye(), var4 getEye(), [level.player, var4])) {
        scripts\engine\utility::flag_set("light_tutorial_start");
        return;
      }

      wait 0.05;
    }

    wait 0.05;
  }
}

function vo_light_enemies_convo(var0, var1) {
  level endon("tutorial_light_shot");
  var2 = "dx_vom_aq1_tut_aqlights_";
  var3 = 0;
  var4 = 1;
  var5 = var0;
  var6 = scripts\engine\utility::array_combine(var0, var1);

  foreach(var8 in var6) {
    var8 endon("shooting");
    var8 endon("death");
  }

  for(;;) {
    var3 += 10;
    var5[0] scripts\engine\sp\utility::smart_dialogue_generic(var2 + var3);

    if(var4) {
      var5 = var1;
      var2 = "dx_vom_aq2_tut_aqlights_";
      var4 = 0;
    } else {
      var5 = var0;
      var2 = "dx_vom_aq1_tut_aqlights_";
      var4 = 1;
    }

    if(var3 == 90) {
      return;
    }

    wait 0.15 + randomfloat(0.25);
  }
}

function light_tutorial_catchup() {
  thread scripts\sp\maps\estate\estate_util::delete_noteworthy_ents("light_tut_ent");
}

function vo_light_tut() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("light_tutorial_start");
  var0 = lookupsoundlength("dx_vom_pri_tut_lights_10");
  var1 = var0 % 50;

  if(var1 > 0) {
    var0 += 50 - var1;
  }

  var2 = var0 / 1000;
  var3 = getanimlength(level.scr_face["price"]["dx_vom_pri_tut_lights_10"]);
  var4 = max(var2, var3);
  thread scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_tut_lights_10");
  wait var4;
  scripts\engine\utility::flag_set("light_tut_price_clear_to_shoot");

  if(!scripts\engine\utility::flag("tutorial_light_shot") && !scripts\engine\utility::flag("light_enemy_killed") && !scripts\engine\utility::flag("stealth_spotted")) {
    thread price_shoots_light_timeout();
    level.price thread scripts\sp\maps\estate\estate_util::nags_til_notify(["dx_vom_pri_tut_lights_20", "dx_vom_pri_woods_traverse_90", "dx_vom_pri_woods_traverse_91"], "tutorial_light_shot", 1);
    thread stop_nags_on_combat();
  }

  scripts\engine\utility::flag_wait("light_enemies_dead");
  wait 1;
  thread scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_tut_lights_80");
}

function stop_nags_on_combat() {
  level endon("tutorial_light_shot");
  level.price scripts\engine\sp\utility::add_wait(&scripts\engine\sp\utility::waittill_msg, "shooting");
  level scripts\engine\sp\utility::add_wait(&scripts\engine\utility::flag_wait, "light_enemies_dead");
  scripts\engine\sp\utility::do_wait_any();

  if(!scripts\engine\utility::flag("tutorial_light_shot")) {
    scripts\engine\utility::flag_set("tutorial_light_shot");
    return;
  }
}

function vo_light_shot_enemy_chatter() {
  level endon("stealth_spotted");
  var0 = scripts\stealth\utility::get_group("left");

  if(var0.size < 2) {
    return;
  }

  var0[0] endon("death");
  var0[1] endon("death");
  var0[0] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq3_woods_traverse_300");
  wait 1.5;
  var0[0] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq3_woods_traverse_340");
  wait 0.15;
  var0[1] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq4_woods_traverse_350");
  wait 5;
  var0[0] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq4_woods_traverse_310");
  wait 0.15;
  var0[1] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq3_woods_traverse_320");
  wait 0.15;
  var0[0] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq4_woods_traverse_330");
  wait 4;
  var0[1] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq1_woods_traverse_360");
  wait 0.15;
  var0[0] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq2_woods_traverse_370");
  wait 0.15;
  var0[1] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq1_woods_traverse_380");
}

function light_tut_light_watcher() {
  var0 = getEnt("light_tutorial_light", "targetname");
  var0 waittill("death");
  wait 0.5;
  scripts\engine\utility::flag_set("tutorial_light_shot");
}

function light_tutorial_events_watcher() {
  level endon("light_enemies_dead");
  scripts\engine\utility::flag_wait("tutorial_light_shot");
  scripts\engine\utility::flag_wait("light_tutorial_start");
  setmusicstate("mx_tmp_estate_lightsout");
  thread vo_light_shot_enemy_chatter();
  var0 = getEnt("light_tutorial_light", "targetname");
  var1 = (5212.5, 5249.5, 1081);
  var2 = scripts\stealth\utility::get_group("left");

  foreach(var4 in var2) {
    var4 aieventlistenerevent("glass_destroyed", level.player, var1);
    wait 1.2;
  }

  scripts\engine\utility::array_thread(var2, &never_stop_investigating);
  var6 = 1;
  var2 = [];
  var7 = getEnt("light_tutorial_trigger", "targetname");
  var2 = var7 getistouchingentities(getaiarray("axis"));

  foreach(var9 in var2) {
    var9 endon("shooting");
    var9 endon("death");
  }

  if(var2.size > 3 && (!scripts\engine\utility::flag("light_tut_hot") || !scripts\engine\utility::flag("light_enemy_killed"))) {
    thread scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_tut_lights_30");
  }

  if(var2.size > 3) {
    while(var7 getistouchingentities(getaiarray("axis")).size > 3) {
      wait 0.05;
    }
  }

  if(var2.size > 2) {
    if(!scripts\engine\utility::flag("light_tut_hot") || !scripts\engine\utility::flag("light_enemy_killed")) {
      thread scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_tut_lights_40");
    }

    while(var7 getistouchingentities(getaiarray("axis")).size > 2) {
      wait 0.05;
    }
  }

  level.light_enemies_separated = 1;

  if(!scripts\engine\utility::flag("light_tut_hot") || !scripts\engine\utility::flag("light_enemy_killed")) {
    thread scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_tut_lights_50");
  }

  level.price thread scripts\sp\maps\estate\estate_util::nags_til_notify(["dx_vom_pri_tut_lights_51", "dx_vom_pri_tut_lights_52"], "stealth_spotted", 1, 10);
  scripts\engine\utility::flag_wait("light_right_enemies_dead");
  var2 = scripts\stealth\utility::get_group("left");
  scripts\engine\utility::array_thread(var2, &scripts\stealth\enemy::alertlevel_normal);
}

function never_stop_investigating() {
  self endon("death");
  self endon("stealth_combat");

  while(!isDefined(self.stealth.investigateendtime)) {
    waitframe();
  }

  for(;;) {
    self.stealth.investigateendtime = gettime() + 12000;
    wait 10;
  }
}

function set_flag_when_dead(var0, var1) {
  if(var0.size) {
    scripts\engine\sp\utility::waittill_dead_or_dying(var0);
  }

  scripts\engine\utility::flag_set(var1);
}

function price_kills_right_side_light_enemies_then_goes_hot() {
  var0 = scripts\stealth\utility::get_group("right");

  foreach(var2 in var0) {
    var2 scripts\engine\sp\utility::add_wait(&scripts\engine\utility::waittill_any, "stealth_investigate", "stealth_combat");
  }

  scripts\engine\sp\utility::add_wait(&scripts\engine\utility::flag_wait_any, "light_area_halfway", "light_enemy_killed");
  scripts\engine\sp\utility::do_wait_any();
  scripts\engine\utility::flag_wait("light_tut_price_clear_to_shoot");
  wait 0.25;

  foreach(var2 in var0) {
    if(isalive(var2)) {
      price_kill(var2);
      wait 0.2;
    }
  }

  var6 = scripts\stealth\utility::get_group("left");

  if(var6.size) {
    var7 = 0;

    foreach(var2 in var6) {
      if(var2[[var2.fnisinstealthcombat]]()) {
        var7 = 1;
        break;
      }
    }

    if(!var7) {
      foreach(var2 in var6) {
        var2.attackeraccuracy = 100;
        var2.health = 1;
        var2 scripts\engine\sp\utility::add_wait(&scripts\engine\sp\utility::waittill_msg, "stealth_combat");
      }

      scripts\engine\sp\utility::add_wait(&scripts\engine\sp\utility::timeout, 3);
      scripts\engine\sp\utility::do_wait_any();
    }

    scripts\engine\utility::flag_set("light_tut_hot");
    price_goes_hot(var6);
    return;
  }

  level.price allowedstances("crouch", "stand", "prone");
}

function price_goes_hot(var0) {
  var1 = 1;

  foreach(var3 in var0) {
    if(var3[[var3.fnisinstealthcombat]]()) {
      var1 = 0;
      break;
    }
  }

  if(var1) {
    thread scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_tut_lights_60");
  }

  setmusicstate("");
  level.price.ignoreall = 0;
  level.price.ignoreme = 1;
  level.price.dontevershoot = 1;
  level.price scripts\engine\sp\utility::disable_ai_color();
  var5 = getnode("price_cleanup", "targetname");
  level.price.goalradius = 40;
  level.price setgoalnode(var5);
  level.price allowedstances("crouch", "stand", "prone");
  wait 1;
  var0 = scripts\engine\utility::array_removeundefined(var0);

  if(!var0.size) {
    level.price.a.laseron = 0;
    level.price scripts\anim\shared::updatelaserstatus();
    return;
  }

  level.price scripts\common\utility::enable_cqbwalk();
  price_kills_left_guys(var0);
  level.price scripts\common\utility::disable_cqbwalk();
}

function price_exits_light_tut() {
  level.price scripts\engine\sp\utility::clear_force_color();
  level.price scripts\engine\sp\utility::set_force_color("p");
  level.price_color_trigger = 9;
  price_color_trigger_set(level.price_color_trigger);
  level.price.ignoreall = 1;
}

function price_kills_left_guys(var0) {
  for(;;) {
    foreach(var2 in var0) {
      if(isalive(var2) && level.price cansee(var2)) {
        price_kill(var2);
      }
    }

    var0 = scripts\engine\utility::array_removeundefined(var0);

    if(!var0.size) {
      return;
    }

    waitframe();
  }
}

function light_enemy_spawn_func() {
  self.attackeraccuracy = 3;
  self.baseaccuracy = 1.5;
  self.grenadeammo = 0;
  thread battlechatter_off_spawn_func();
  self.deathfunction = &light_enemy_deathfunc;

  while(!isDefined(self.stealth)) {
    waitframe();
  }

  self.stealth.funcs["event_investigate"] = &light_enemy_stealth_filter;
  self.stealth.funcs["event_cover_blown"] = &light_enemy_stealth_filter;
  self.stealth.funcs["event_combat"] = &light_enemy_stealth_filter;
  self waittill("stealth_combat");
  self.attackeraccuracy = 1;
}

function light_enemy_deathfunc() {
  scripts\engine\utility::flag_set("light_enemy_killed");
  return false;
}

function light_enemy_stealth_filter(var0) {
  if(scripts\engine\utility::flag("light_right_enemies_dead") && self.script_stealthgroup == "left") {
    return false;
  }

  var1 = ["unresponsive_teammate", "light_killed", "seek_backup"];

  if(scripts\engine\utility::array_contains(var1, var0.typeorig)) {
    return true;
  }

  if(istrue(level.light_enemies_separated) && scripts\engine\utility::is_equal(var0.typeorig, "ally_killed")) {
    scripts\engine\sp\utility::enable_dontevershoot();
    scripts\engine\utility::delaythread(2, &scripts\engine\sp\utility::disable_dontevershoot);
  }

  return false;
}

function estate_rappel_start() {
  spawn_price_infill();
  scripts\engine\sp\utility::set_start_location("rappel_start", [level.player, level.price]);
  scripts\engine\utility::flag_set("rappel_start");
  thread debug_player_fwd();
}

function estate_rappel_main() {
  disable_fire_triggers();
  scripts\engine\utility::exploder("fxglowrappel");
  scripts\engine\utility::exploder("vfxexp_gunfire_dist_a");
  level scripts\engine\utility::thread_on_notify("rappel_past_price", &scripts\engine\utility::stop_exploder, "fxglowrappel");
  level scripts\engine\utility::thread_on_notify("on_belay", &scripts\engine\utility::stop_exploder, "vfxexp_gunfire_dist_a");
  scripts\engine\sp\utility::flagwaitthread("rappel_start", &scripts\engine\utility::delaythread, 2, &destroy_service_fusebox);
  thread scripts\sp\maps\estate\estate_util::greenhouse_misters();
  thread rappel_anim();
  level waittill("on_belay");
  scripts\engine\sp\utility::autosave_by_name("rappel");
  setsaveddvar("MMLNNQSTTL", 10);
  var0 = getaiarray("axis");

  if(var0.size) {
    scripts\engine\utility::array_delete(var0);
  }

  level.price.ignoreall = 0;
  level.price.dontevershoot = 1;
  thread rappel_ground_anim();
  scripts\engine\utility::flag_wait("rappel_end");
  scripts\engine\utility::flag_wait("rappel_enemies_dead");
  level.animnodes["rappel_anim_struct"] = undefined;
  level.cutters delete();
  level.price delete();
  thread scripts\sp\maps\estate\estate_util::delete_noteworthy_ents("rappel_ent");
}

function disable_fire_triggers() {
  scripts\engine\sp\utility::disable_trigger_with_targetname("mansion_fire");
  scripts\engine\sp\utility::disable_trigger_with_targetname("obj_room_fire_a");
  scripts\engine\sp\utility::disable_trigger_with_targetname("obj_room_fire_b");
  scripts\engine\sp\utility::disable_trigger_with_targetname("obj_room_fire_c");
}

function destroy_service_fusebox() {
  foreach(var1 in level.fuseboxes) {
    if(scripts\engine\utility::is_equal(var1.script_parameters, "service")) {
      var1.noachievement = 1;
      var1.script_model scripts\sp\utility::do_damage(51, var1.script_model.origin);
      scripts\engine\utility::exploder("vfxexp_fusebox_dist_exp_a");
      var2 = getEnt("vistawindows_service", "targetname");
      var2 delete();
      break;
    }
  }
}

function estate_rappel_catchup() {
  scripts\engine\utility::flag_set("rappel_end");
  estate_objectives_create();
  var0 = getEnt("rappel_kill_trig", "targetname");

  if(isDefined(var0)) {
    var0 delete();
  }

  thread scripts\sp\maps\estate\estate_util::delete_noteworthy_ents("rappel_ent");
  thread scripts\sp\maps\estate\estate_util::greenhouse_misters();
  thread fake_vista_windows();
  scripts\engine\utility::delaythread(0.15, &destroy_service_fusebox);

  if(!scripts\sp\starts::is_after_start("heli_attack")) {
    disable_fire_triggers();
    return;
  }
}

function rappel_anim() {
  var0 = getEnt("new_rappel_node", "targetname");
  level.animnodes["rappel_anim_struct"] = var0;
  thread vo_rappel();
  level.price.disableplayeradsloscheck = 1;
  var0 scripts\sp\anim::anim_reach_solo(level.price, "fwd_rappel_price_enter");
  level.price.disableplayeradsloscheck = 0;
  level.rope unlink();
  var0 scripts\common\anim::anim_single([level.price, level.rope], "fwd_rappel_price_enter");
  level.price thread scripts\sp\maps\estate\estate_util::notetrack_nag(["dx_vom_pri_rappel_sitrep_20", "dx_vom_pri_rappel_sitrep_30", "dx_vom_pri_rappel_sitrep_40"], "rappel_objectives");
  var0 thread scripts\common\anim::anim_loop([level.price, level.rope], "fwd_rappel_price_enter_idle", "stop_price_loop");
  level.player.animarms = scripts\engine\sp\utility::spawn_anim_model("player_rig", level.player.origin, level.player.angles);
  level.player.animrope = scripts\engine\sp\utility::spawn_anim_model("player_rope", level.player.origin, level.player.angles);
  level.player.animropethrow = scripts\engine\sp\utility::spawn_anim_model("player_rope_throw", level.player.origin, level.player.angles);
  level.player.animarms hide();
  level.player.animrope hide();
  level.player.animropethrow hide();
  var0 scripts\common\anim::anim_first_frame_solo(level.player.animarms, "player_rappel_start");
  level.price scripts\engine\sp\utility::waittill_entity_in_range(level.player, 250);

  while(isDefined(level.price.speaking)) {
    waitframe();
  }

  wait 0.5;
  thread scripts\sp\maps\estate\estate_util::kyle_line("dx_vom_kyle_rappel_sitrep_50");
  thread estate_objectives_reveal();
  scripts\engine\utility::flag_set("rappel_objectives");
  var0 notify("stop_price_loop");
  scripts\engine\utility::delaythread(7, &scripts\engine\sp\utility::autosave_by_name, "player_can_rappel");
  scripts\engine\utility::delaythread(8, &let_player_rappel);
  var0 thread scripts\common\anim::anim_single([level.price, level.rope], "fwd_rappel_price_go");
  waitframe();
  var0 scripts\engine\sp\utility::add_wait(&scripts\engine\sp\utility::waittill_msg, "fwd_rappel_price_go");
  level scripts\engine\sp\utility::add_wait(&scripts\engine\utility::flag_wait, "rappel_started");
  scripts\engine\sp\utility::do_wait_any();

  if(!scripts\engine\utility::flag("rappel_started")) {
    level.price thread scripts\sp\maps\estate\estate_util::notetrack_nag(["dx_vom_pri_rappel_rope_40", "dx_vom_pri_rappel_rope_50", "dx_vom_pri_rappel_rope_60"], "rappel_started");
    var0 thread scripts\common\anim::anim_loop_solo_with_nags(level.price, "fwd_rappel_price_idle", "stop_price_loop");
    scripts\engine\utility::flag_wait("rappel_started");
    var0 notify("stop_price_loop");
  }

  thread scripts\sp\analytics::analytics_kleenex_update("intro to rappel");
  var1 = getEnt("rappel_kill_trig", "targetname");
  var1 delete();
  thread rappel_price();
  rappel_player();
  scripts\engine\utility::flag_wait("rappel_end");
}

function vo_rappel() {
  level.player endon("death");
  var0 = vo_rappel_ahead();

  if(istrue(var0)) {
    return;
  }

  if(isDefined(var0)) {
    level waittill("price_overlook_vo");
  }

  if(distancesquared(level.player.origin, level.price.origin) < squared(200)) {
    scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_rappel_sitrep_12");
  } else {
    scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_rappel_sitrep_10");
  }

  level waittill("on_belay");
  var1 = ["dx_vom_pri_rappel_rope_70", "dx_vom_pri_rappel_rope_80", "dx_vom_pri_rappel_rope_90"];
  var2 = 0;
  var3 = level.player.origin[2];

  for(;;) {
    wait randomfloatrange(8, 13);

    if(abs(var3 - level.player.origin[2]) > 50) {
      break;
    }

    thread scripts\sp\maps\estate\estate_util::price_line(var1[scripts\sp\maps\estate\estate_util::abs_int(var2 % var1.size)]);
    var2++;
  }
}

function vo_rappel_ahead() {
  level endon("price_overlook_vo");
  level.animnodes["rappel_anim_struct"] scripts\engine\sp\utility::waittill_entity_in_range(level.player, 150);

  if(distancesquared(level.player.origin, level.price.origin) < squared(200)) {
    return false;
  }

  thread scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_rappel_sitrep_11");
  return true;
}

function fake_vista_windows() {
  var0 = getEnt("vistawindows", "targetname");

  if(isDefined(var0)) {
    var0 delete();
  }

  var0 = getEnt("vistawindows_courtyard", "targetname");

  if(isDefined(var0)) {
    var0 delete();
  }

  var1 = getEntArray("rappelvistalights", "targetname");

  if(isDefined(var1)) {
    scripts\engine\utility::array_delete(var1);
    return;
  }
}

function overlook_interact() {
  level endon("stop_checking_overlook");
  self waittill("trigger");
  waitframe();
  level.rope scripts\sp\player\cursor_hint::remove_cursor_hint();
  level notify("stop_checking_overlook");
}

function waittill_player_exits() {
  level endon("stop_checking_overlook");

  while(level.player istouching(self)) {
    wait 0.05;
  }

  level notify("stop_checking_overlook");
}

function let_player_rappel() {
  var0 = scripts\engine\utility::getStruct("rappel_interact", "targetname");
  var0.origin = level.rope.origin;
  scripts\engine\sp\objectives::objective_add("rappel", "current", var0.origin + (0, 0, 10));
  var0 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, undefined, &"ESTATE/RAPPEL_HINT", undefined, 350, 150, 1, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 90);
  var0 scripts\engine\utility::waittill_either("trigger", "hint_destroyed");
  scripts\engine\utility::flag_set("rappel_started");
  scripts\engine\sp\objectives::objective_complete("rappel");
}

function rappel_price() {
  level.animnodes["rappel_anim_struct"] scripts\common\anim::anim_single_solo(level.price, "fwd_rappel_price_outro");
  level.animnodes["rappel_anim_struct"] thread scripts\common\anim::anim_loop_solo(level.price, "fwd_rappel_price_outro_idle", "stop_price_loop");
}

function rappel_player() {
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  level.player playSound("scn_estate_rappel_hookup_lerp_plr");
  link_player_to_rappel_scene(level);
  level.player scripts\common\utility::allow_melee(0, "rappel");
  var0 = level.animnodes["rappel_anim_struct"];
  level.player.animrope show();
  level.player.animropethrow show();
  var0 thread scripts\common\anim::anim_single_solo(level.player.animropethrow, "player_rappel_start");
  var0 scripts\common\anim::anim_single([level.player.animarms, level.player.animrope, level.rope], "player_rappel_start");
  level.player.animropethrow delete();
  var1 = level.scr_anim["player_rig"]["player_rappel"];
  var2 = level.scr_anim["player_rope"]["player_rappel"];
  level.player scripts\common\utility::allow_melee(1, "rappel");
  var3 = % est_li_060_fwd_rappel_rope_plr_add1;
  var4 = % estate_rope_additive;
  level.player.animarms hide();
  level.rope delete();
  var0 thread scripts\common\anim::anim_single([level.player.animarms, level.player.animrope], "player_rappel");
  var5 = 0.001;
  var6 = var5;
  var7 = 0.18;
  var8 = 0.035;
  var9 = 0.5;
  var10 = 1;
  var11 = 0.18;
  var12 = 0.04;
  var13 = var9;
  var14 = 0;
  level.player.animrope setanim(var3);
  var15 = getanimlength(var1);
  level.player scripts\common\utility::allow_weapon(1, "rappel");
  level.player.animarms setanimrate(var1, 0);
  level.player.animrope setanimrate(var2, 0);
  doinjuredgesture(1);
  thread rappel_reloading();
  thread rappel_nvgs();
  thread rappel_offhands();
  var16 = level.player scripts\engine\utility::spawn_script_origin();
  var16 linkTo(level.player);
  var17 = 1;
  var18 = 0.1;
  var19 = 0.8;
  var20 = var19;
  var21 = 0;
  level.player lerpviewangleclamp(1, 0.5, 0.5, 45, 45, 50, 40);
  level notify("on_belay");
  level.audio_loop_state = 0;

  for(;;) {
    if(scripts\engine\utility::flag("rappel_enemies_dead")) {
      var20 = 1.67;
    } else {
      var20 = var19;
    }

    var22 = level.player getnormalizedmovement()[0];
    var22 = clamp(var22, 0, 1);
    var23 = scripts\engine\math::factor_value(0, var20, var22);
    var17 += (var23 - var17) * var18;

    if(var22 > 0) {
      thread rappelfootstep(var16);
      thread player_rappel_sound_loop_on();
      level.player.animarms setanimrate(var1, var17);
      level.player.animrope setanimrate(var2, var17);

      if(!var21) {
        var21 = 1;
      }
    } else {
      thread player_rappel_sound_loop_off();
      level.player.animarms setanimrate(var1, 0);
      level.player.animrope setanimrate(var2, 0);
    }

    if(var22 > var6) {
      var24 = var11;
      var25 = var7;
    } else {
      var24 = var12;
      var25 = var8;
    }

    var14 = scripts\engine\math::lerp(var14, var22, var24);
    var13 = scripts\engine\math::factor_value(var9, var10, var14);
    var6 = scripts\engine\math::lerp(var6, var22, var25);
    var6 = clamp(var6, var5, 1);
    level.player.animrope setanim(var4, var6, 0, var13);
    var26 = level.player.animarms getanimtime(var1);

    if(var26 >= 0.93) {
      level.player playSound("scn_estate_rappel_dismount_plr");
      level.player playSound("scn_estate_rappel_dismount_plr_rope");
      level.player playSound("scn_estate_rappel_dismount_plr_land");
      scripts\engine\utility::delaythread(0.5, &fake_vista_windows);
      level.player lerpviewangleclamp(1, 0.5, 0.5, 0, 0, 0, 0);
      level.player.animarms setanimrate(var1, 1, 0.25);
      level.player.animrope setanimrate(var2, 1, 0.25);

      while(level.player.animarms getanimtime(var1) < 1) {
        wait 0.05;
      }

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
  level.player.animrope setanim(var4, 0, 0);
  var16 delete();
  playworldsound("slide_start_plr", level.player.origin);
  scripts\engine\utility::flag_set("rappel_end");
  level.player.animarms delete();
  level.player.dof_ref_ent = undefined;
  level.player scripts\common\utility::allow_crouch(1, "rappel");
  level.player scripts\common\utility::allow_prone(1, "rappel");
}

function choose_rappel_weapon(var0) {
  var1 = undefined;
  var2 = level.player getweaponslistprimaries();

  foreach(var4 in var2) {
    if(issubstr(var4.basename, "_pi_") && has_ammo(var4)) {
      var1 = var4;
      var5 = level.player getweaponammoclip(var1);
      var6 = level.player getweaponammostock(var1);
      level.player takeweapon(var1);
      level.player giveweapon(var1);
      level.player setweaponammoclip(var1, var5);
      level.player setweaponammostock(var1, var6);
      break;
    }
  }

  if(!isDefined(var1)) {
    foreach(var4 in var2) {
      if(var4 hasattachment("silenc", 1) && has_ammo(var4)) {
        var1 = var4;
        break;
      }
    }

    if(!isDefined(var1)) {
      foreach(var4 in var2) {
        if(has_ammo(var4)) {
          var1 = var4;

          if(var1 == var0) {
            break;
          }
        }
      }

      if(!isDefined(var1)) {
        var1 = var0;
      }
    }
  }

  if(var0 != var1) {
    level.player.storedweapon = var0;
  }

  return var1;
}

function has_ammo() {
  return level.player getweaponammoclip(self) || level.player getweaponammostock(self);
}

function player_rappel_weapon_switch(var0) {
  var1 = choose_rappel_weapon(var0);
  level.player switchtoweaponimmediate(var1);

  if(!issubstr(var1.basename, "_pi_")) {
    level.player scripts\common\utility::allow_ads(0, "rappel");
  }

  level.player scripts\common\utility::allow_weapon_switch(0, "rappel");
  level.player scripts\common\utility::allow_offhand_weapons(0, "rappel");
  level.player scripts\common\utility::allow_sprint(0, "rappel");
}

function restore_replaced_weapon() {
  var0 = level.player getcurrentweapon();

  if(!issubstr(var0.basename, "_pi_")) {
    level.player scripts\common\utility::allow_ads(1, "rappel");
  }

  level.player scripts\common\utility::allow_weapon_switch(1, "rappel");
  level.player scripts\common\utility::allow_offhand_weapons(1, "rappel");
  level.player scripts\common\utility::allow_sprint(1, "rappel");

  if(isDefined(level.player.storedweapon)) {
    level.player switchtoweapon(level.player.storedweapon);
    level.player.storedweapon = undefined;

    while(nullweapon(level.player getcurrentweapon())) {
      waitframe();
    }

    return;
  }
}

function player_rappel_sound_loop_on() {
  if(level.audio_loop_state == 0) {
    level.audio_loop_state = 1;
    level.player playSound("scn_estate_rappel_start_plr");
    level.player playSound("scn_estate_rappel_start_plr_lyr");
    wait 0.25;
    self playLoopSound("scn_estate_rappel_loop_plr");
    return;
  }
}

function player_rappel_sound_loop_off() {
  if(level.audio_loop_state == 1) {
    level.player playSound("scn_estate_rappel_stop_plr");
    self stoploopsound();
    level.audio_loop_state = 0;
    return;
  }
}

function debug_player_fwd() {
  level endon("rappel_end");
  level.player endon("death");

  for(;;) {
    scripts\sp\debug::drawarrow(level.player.origin, level.player getplayerangles(), (1, 1, 0), 1);
    wait 0.05;
  }
}

function rappelfootstep(var0) {
  if(istrue(self.isplaying) || var0 < 0.3) {
    return;
  }

  self.isplaying = 1;
  var1 = randomfloatrange(1, 1.35);
  level.player screenshakeonentity(randomfloatrange(0.8, 1.3), 0, 0, var1, -1, -1);
  var2 = "scn_estate_rappel_step_plr_lyr";
  thread rappel_bump(lookupsoundlength(var2) / 1000);
  level.player scripts\engine\utility::delaythread(randomfloat(0.15), &scripts\engine\sp\utility::play_sound_on_entity, "scn_estate_rappel_step_plr");
  level.player scripts\engine\utility::delaythread(randomfloat(0.45), &scripts\engine\sp\utility::play_sound_on_entity, "scn_estate_rappel_step_plr_rocks_fall");
  self playSound(var2, "done");
  self waittill("done");
  self.isplaying = undefined;
}

function doinjuredgesture(var0) {
  while(nullweapon(level.player getcurrentweapon())) {
    waitframe();
  }

  var1 = 0.3;
  var2 = 0.4;
  var3 = level.player getcurrentweapon();

  if(istrue(var0) && issubstr(var3.basename, "_pi_")) {
    wait 0.6;
    var2 = 0.2;
  }

  var4 = 0;

  while(!var4) {
    var4 = level.player forceplaygestureviewmodel("ges_drophand", undefined, var1, var2, 1, 0);
    wait 0.05;
  }
}

function link_player_to_rappel_scene() {
  level.player scripts\common\utility::allow_crouch(0, "rappel");
  level.player scripts\common\utility::allow_prone(0, "rappel");
  level.player setstance("stand");
  level.player hidelegsandshadow();
  level.player enablequickweaponswitch(1);
  var0 = level.player getcurrentweapon();
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
  player_rappel_weapon_switch(var0);
}

function rappel_ground_anim() {
  var0 = level.player.origin[2];

  while(abs(var0 - level.player.origin[2]) < 70) {
    wait 0.25;
  }

  level.rappel_guys = [];
  var1 = scripts\engine\sp\utility::spawn_script_noteworthy("alq05", 1);
  level.rappel_guys["alq05"] = var1;
  var2 = scripts\engine\sp\utility::spawn_script_noteworthy("alq06", 1);
  level.rappel_guys["alq06"] = var2;
  var3 = scripts\engine\sp\utility::spawn_script_noteworthy("russ01", 1);
  level.rappel_guys["russ01"] = var3;
  waitframe();
  var4 = scripts\engine\sp\utility::spawn_script_noteworthy("russ02", 1);
  level.rappel_guys["russ02"] = var4;
  var5 = scripts\engine\utility::getStruct("rappel_anim_struct_base", "targetname");
  var5.origin += (0, 0, -5);
  var6 = [];
  var7 = [];

  foreach(var9 in level.rappel_guys) {
    var9.animname = var9.script_noteworthy;
    var9.allowdeath = 1;
    var9.health = 1;
    var9.damage_functions[0] = &rappel_actor_dmg_func;
    var9 scripts\engine\utility::ent_flag_init("shot");

    if(var9.animname == "alq05" || var9.animname == "alq06") {
      thread rappel_alq_logic();
      var9 thread scripts\common\ai::magic_bullet_shield();
      thread actor_die_when_shot();
      var9 scripts\stealth\utility::set_stealth_func("event_cover_blown", &rappel_actor_stealth_filter);
      var6 = var9;
      continue;
    }

    var9.no_friendly_fire_fail = 1;
    var9 thread scripts\common\ai::magic_bullet_shield();
    var9 scripts\common\ai::gun_remove();
    var7 = var9;
  }

  thread vo_price_take_em_out(var6);
  level.rappel_guys["russ01"] scripts\engine\utility::delaythread(3.3, &rappel_victim_death, level.rappel_guys["alq05"]);
  level.rappel_guys["russ02"] scripts\engine\utility::delaythread(2.4, &rappel_victim_death, level.rappel_guys["alq06"]);
  thread rappel_scene_vo(var6, var7);
  thread price_kills_rappel_enemies(var6);
  var5 thread scripts\common\anim::anim_single(level.rappel_guys, "fwd_rappel_ground");
  scripts\engine\sp\utility::waittill_dead_or_dying(level.rappel_guys);
  scripts\engine\utility::delaythread(0.5, &scripts\sp\maps\estate\estate_util::price_line, "dx_vom_pri_rappel_interrogation_70");
  scripts\engine\utility::flag_set("rappel_enemies_dead");
}

function rappel_actor_stealth_filter(var0) {
  if(var0.typeorig == "saw_corpse" || var0.typeorig == "found_corpse") {
    return true;
  }

  return false;
}

function rappel_actor_dmg_func(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(isDefined(var9) && var9.basename == "flash") {
    return;
  }

  if(isDefined(var1)) {
    if(isai(var1) || isPlayer(var1)) {
      scripts\engine\utility::ent_flag_set("shot");
      return;
    }
  }

  if(isDefined(var9)) {
    if(weaponclass(var9) == "rifle") {
      scripts\engine\utility::ent_flag_set("shot");
      return;
    }

    return;
  }
}

function vo_price_take_em_out(var0) {
  level endon("rappel_actors_engaged");
  wait 5;
  var0 = scripts\engine\utility::array_removedead(var0);

  if(var0.size) {
    scripts\sp\maps\estate\estate_util::price_line("dx_vom_pri_rappel_interrogation_60");
    return;
  }
}

function rappel_alq_logic() {
  self endon("death");
  level endon("rappel_actors_engaged");
  self waittillmatch("single anim", "end");
  self.goalradius = 32;
  self setgoalpos(self.origin);
}

function rappel_victim_death(var0) {
  var1 = randomintrange(2, 3);

  for(var2 = 0; var2 < var1; var2++) {
    if(isalive(var0)) {
      magicbullet(var0.weapon.basename, var0 gettagorigin("tag_flash"), self getEye());
      wait 0.1;
    }
  }

  wait 0.8;

  if(isalive(self)) {
    self.a.nodeath = 1;
    scripts\common\ai::stop_magic_bullet_shield();
    self.allowdeath = 1;
    scripts\engine\sp\utility::die();
    return;
  }
}

function rappel_scene_vo(var0, var1) {
  level endon("rappel_actors_engaged");
  var1[0] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_ru1_rappel_interrogation_30");
  wait 0.25;
  var0[0] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq1_rappel_interrogation_40");
}

function price_kills_rappel_enemies(var0) {
  var1 = 0;

  while(!var1) {
    var0 = scripts\engine\utility::array_removedead(var0);

    if(!var0.size) {
      return;
    }

    foreach(var3 in var0) {
      if(scripts\engine\utility::can_trace_to_ai(level.player getEye(), var3, [level.player])) {
        var1 = 1;
      }
    }

    wait 0.05;
  }

  level.player scripts\engine\sp\utility::add_wait(&scripts\engine\sp\utility::waittill_msg, "weapon_fired");
  scripts\engine\sp\utility::add_wait(&scripts\engine\utility::flag_wait_any, "rappel_past_price", "stealth_spotted");
  scripts\engine\sp\utility::do_wait_any();
  level notify("rappel_actors_engaged");
  var5 = (4041.5, 5182.5, 111);

  foreach(var7 in var0) {
    if(isalive(var7)) {
      var7 scripts\engine\sp\utility::battlechatter_on();
      var7 scripts\engine\sp\utility::anim_stopanimScripted();
      var7 thread scripts\stealth\utility::set_patrol_react(var5, "med");
    }

    wait 0.3;
  }

  wait 0.6;

  foreach(var7 in var0) {
    if(isalive(var7)) {
      var10 = level.price gettagorigin("tag_flash");

      if(!scripts\engine\trace::ray_trace_passed(var10, var7 getEye(), [level.price, var7])) {
        var10 += anglesToForward(level.price gettagorigin("tag_flash")) * 50;
      }

      magicbullet(level.price.rifle, var10, var7 getEye());
      waitframe();

      if(isalive(var7)) {
        if(isDefined(var7.magic_bullet_shield)) {
          var7 scripts\common\ai::stop_magic_bullet_shield();
        }

        playFXOnTag(scripts\engine\utility::getfx("vfx_blood_sniper_shot"), var7, "tag_eye");
        var7 playsoundatviewheight("bullet_large_flesh_head_npc");
        wait 0.05;
        var7 kill(var7 getEye(), level.price);
      }

      wait 1;
    }
  }
}

function estate_objectives_reveal() {
  wait 3;
  thread estate_objectives_create();
  level.player scripts\sp\player::focus_display_hint(2, 7);
}

function estate_objectives_create() {
  scripts\engine\sp\objectives::objective_set_description("estate", &"ESTATE/OBJ_DESC_FIND_HVT");
  var0 = scripts\engine\utility::getStructArray("landmark", "targetname");

  foreach(var2 in var0) {
    var3 = undefined;

    switch (var2.script_noteworthy) {
      case "church":
        var3 = &"ESTATE/OBJ_LBL_CHURCH";
        break;
      case "courtyard":
        var3 = &"ESTATE/OBJ_LBL_COURTYARD";
        break;
      case "pool":
        var3 = &"ESTATE/OBJ_LBL_POOL";
        break;
      default:
        continue;
    }

    scripts\engine\sp\objectives::objective_add(var2.script_noteworthy + "_hvt", "current", var2.origin, undefined, var3);
  }
}

function rappel_reloading() {
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

function rappel_reload_internal() {
  level endon("rappel_end");
  GscBinSkip4(0x35);
}

function reloadonempty() {
  for(;;) {
    waitframe();

    if(!level.player getcurrentweaponclipammo()) {
      level.player notify("reload_pressed");
      wait 0.15;
    }
  }
}

function reloadifneeded() {
  var0 = level.player getcurrentprimaryweapon();
  var1 = weaponclass(var0);

  if(!canrappelreload(var1)) {
    return;
  }

  var2 = level.player getgestureanimlength("ges_left_arm_damage_reload");
  var3 = level.player getweaponammoclip(var0);
  var4 = weaponclipsize(var0);

  if(var3 < var4) {
    var5 = level.player getammocount(var0);
    var5 -= var3;

    if(var5 <= 0) {
      return;
    }

    level.player.rappel_reloading = 1;
    level.player scripts\common\utility::allow_fire(0, "rappel");
    level.player scripts\common\utility::allow_ads(0, "rappel");
    level.player scripts\common\utility::allow_melee(0, "rappel");
    var6 = getsubstr(var0.basename, 4);
    var7 = "";

    foreach(var9 in ["xmag", "toprailcust", "drum"]) {
      if(var0 hasattachment(var9, 1)) {
        var7 = "_" + var9;
        break;
      }
    }

    var11 = "wfoly_plr_" + var6 + "_reload_empty_fast" + var7 + "_01";
    level.player playSound(var11);
    level.player screenshakeonentity(1, 0, 0, 1.1);
    scripts\engine\utility::delaythread(0.8, &tossclip, var0);
    level.player stopgestureviewmodel("ges_drophand", 0.7);
    level.player forceplaygestureviewmodel("ges_left_arm_damage_reload", undefined, 0.2, 0, 1, 1);
    wait 1.1;
    var11 = "wfoly_plr_" + var6 + "_reload_empty_fast" + var7 + "_02";
    level.player playRumbleOnEntity("damage_heavy");
    level.player screenshakeonentity(1, 1, 1, 0.9);
    level.player playSound(var11);
    level.player setweaponammoclip(var0, var4);
    var12 = var4 - var3;
    var5 -= var12;
    level.player setweaponammostock(var0, var5);
    wait 0.3;
    var11 = "wfoly_plr_" + var6 + "_reload_empty_fast" + var7 + "_04";
    level.player playSound(var11);
    wait 0.6;
    level.player stopgestureviewmodel("ges_left_arm_damage_reload", 0.7);
    doinjuredgesture();
    wait 0.25;
    level.player scripts\common\utility::allow_ads(1, "rappel");
    level.player scripts\common\utility::allow_fire(1, "rappel");
    level.player scripts\common\utility::allow_melee(1, "rappel");
    level.player.rappel_reloading = undefined;
    return;
  }
}

function canrappelreload(var0) {
  GscBinSkip1(0x45, "rifle", 1);
}

function tossclip(var0) {
  if(!issubstr(var0.basename, "_pi_")) {
    return;
  }

  var1 = "weapon_wm_pi_golf21_clip";
  var2 = spawn("script_model", level.player.origin + anglesToForward(level.player.angles) * 20);
  var2 setModel(var1);
  var2.angles = level.player.angles + (randomintrange(-20, 20), randomintrange(-20, 20), randomintrange(-20, 20));
  var3 = anglesToForward(level.player.angles) * -1;
  var3 *= 80;
  var4 = var3[0];
  var5 = var3[1];
  var6 = 90;
  var2 physicslaunchserver(var2.origin, (var4, var5, var6));
  var2 scripts\engine\utility::delaycall(6, &delete);
}

function rappel_nvgs() {
  level endon("rappel_end");

  for(;;) {
    level.player scripts\engine\utility::waittill_either("night_vision_on", "night_vision_off");

    if(!isDefined(level.player.rappel_reloading)) {
      wait 0.3;
      doinjuredgesture();
    }
  }
}

function rappel_offhands() {
  level endon("rappel_end");

  for(;;) {
    level.player waittill("smoke_pressed");
    var0 = 5;
    scripts\engine\sp\utility::display_hint("rappel_offhands", var0, undefined, level, "rappel_end");
    wait var0;
  }
}

function rappel_bump(var0) {
  playFX(scripts\engine\utility::getfx("vfx_estate_cliff_stones_01"), level.player.origin + anglesToForward(level.player.animarms.angles) * -15);
  level.player playrumblelooponentity("tank_rumble");
  wait var0;
  level.player stoprumble("tank_rumble");
  level.player playRumbleOnEntity("damage_heavy");
  wait 0.25;
}

function spawn_price_infill() {
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
  thread nvg_eyelights_thread();
  level.price.rifle = scripts\sp\maps\estate\estate_util::make_price_rifle();
  level.price scripts\anim\shared::forceuseweapon(level.price.rifle, "primary");
  level.price.sidearm = scripts\sp\maps\estate\estate_util::make_price_pistol(1);
  level.price scripts\common\utility::initweapon(level.price.sidearm);
  level.price scripts\anim\shared::placeweaponon(level.price.sidearm, "thigh");
  var0 = scripts\sp\maps\estate\estate_util::make_price_ar();
  level.price scripts\common\utility::initweapon(var0);
  level.price scripts\anim\shared::placeweaponon(var0, "back");
  setdvarifuninitialized("debug_cutters", 0);
  level.cutters = scripts\engine\sp\utility::spawn_anim_model("bolt_cutters", level.price.origin);
  level.cutters linkTo(level.price, "tag_shield_back", (0, 0, 0), (0, 0, 0));
  thread debug_cutters();
  level.rope = scripts\engine\sp\utility::spawn_anim_model("rope", level.price.origin);
  level.rope linkTo(level.price, "tag_stowed_hip_rear", (0, 0, 0), (0, 0, 0));
}

function nvg_eyelights_thread() {
  self endon("death");
  var0 = scripts\engine\utility::getfx("nvg_eyelights");

  for(var1 = 0;; var1 = self.visor_down) {
    waitframe();

    if(!isDefined(self.visor_down)) {
      continue;
    }

    if(self.visor_down == var1) {
      continue;
    }

    if(self.visor_down) {
      wait 0.4;
      playFXOnTag(var0, self, "j_nvg");
      continue;
    }

    stopFXOnTag(var0, self, "j_nvg");
  }
}

function stayahead_values_tallgrass(var0) {
  scripts\sp\utility::set_stayahead_values(1, 220, 50, 0.2);
  scripts\sp\utility::set_stayahead_values(2, 170, 0, 0.1);
  scripts\sp\utility::set_stayahead_values(3, 120, -150, 0.2);
  scripts\sp\utility::set_stayahead_values(4, 120, -250, 0.2);

  if(!istrue(var0)) {
    scripts\sp\utility::set_stayahead_wait_values(-350, 1.5);
    scripts\sp\utility::set_stayahead_wait_nodes(getnodearray("tall_grass_wait", "targetname"));
  }

  scripts\sp\utility::enable_stayahead(level.player);
}

function cutters_stress_test() {
  for(;;) {
    wait 2;
    level.cutters unlink();
    wait 2;
    level.cutters linkTo(level.price, "tag_shield_back", (0, 0, 0), (0, 0, 0));
  }
}

function debug_cutters() {
  level.cutters endon("death");

  for(;;) {
    if(getdvarint("debug_cutters")) {
      level.price thread scripts\sp\debug::drawtag("tag_shield_back");
    }

    waitframe();
  }
}

function player_stay_behind_ai(var0) {
  level endon("stop_player_stay_behind");
  setsaveddvar("OLMLOTTLRM", 1.15);
  var1 = scripts\engine\utility::ter_op(!isDefined(var0), 22500, var0 * var0);
  var2 = 0.5;
  var3 = 0.7;
  jumpiftrue(isDefined(level.player.movespeedscale)) LOC_00000053;
  level.player.movespeedscale = 1;

  for(;;) {
    var4 = sortbydistance(level.friendlies, level.player.origin)[0];
    var5 = distancesquared(level.player.origin, var4.origin);
    var6 = scripts\engine\math::normalize_value(0, var1, var5);
    var6 = clamp(var6, var3, 1);
    var7 = var6 - level.player.movespeedscale;
    var8 = var7 * var2;
    var9 = level.player.movespeedscale + var8;
    level.player setmovespeedscale(var9);
    level.player.movespeedscale = var9;
    wait 0.05;
  }
}

function shutdown_player_stay_behind_ai() {
  setsaveddvar("OLMLOTTLRM", 1.4);
  level notify("stop_player_stay_behind");
  thread scripts\engine\sp\utility::blend_movespeedscale_default(1);
}