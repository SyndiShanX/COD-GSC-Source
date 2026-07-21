/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\piccadilly\piccadilly_infil.gsc
***************************************************/

infil_init() {
  precachemodel("offhand_wm_smartphone");
  precachemodel("body_civ_western_girl_5_1");
  precachemodel("civ_london_female_3_2");
  scripts\engine\sp\utility::array_spawn_function_targetname("sicario_street_friendly", ::postspawn_ally);
  scripts\engine\sp\utility::array_spawn_function_targetname("car1_terry", ::postspawn_car1_terry);
  scripts\engine\sp\utility::array_spawn_function_targetname("car1_terries", ::postspawn_car1_terries);
  scripts\engine\sp\utility::array_spawn_function_targetname("car2_terry", ::postspawn_car2_terry);
  scripts\engine\sp\utility::array_spawn_function_targetname("intro_civs", ::postspawn_intro_civ);
  scripts\engine\utility::flag_init("intro_skipped");
  scripts\engine\utility::flag_init("intro_bink_done");
  scripts\engine\utility::flag_init("intro_civs_ready");
  scripts\engine\utility::flag_init("camera_move_done");
  scripts\engine\utility::flag_init("cars_ready");
  scripts\engine\utility::flag_init("boots_on_the_ground");
  scripts\engine\utility::flag_init("intro_sas_ready");
  scripts\engine\utility::flag_init("player_is_behind_ally");
  scripts\engine\utility::flag_init("player_at_standoff");
  scripts\engine\utility::flag_init("sas2_ready");
  scripts\engine\utility::flag_init("standoff_ready");
  scripts\engine\utility::flag_init("car2_guys_dead");
  scripts\engine\utility::flag_init("force_bomb_start");
  scripts\engine\utility::flag_init("player_golden_path_knockdown");
  scripts\engine\utility::flag_init("start_car2");
  scripts\engine\utility::flag_init("car2_detonation");
  scripts\engine\utility::flag_init("post_explosion");
  scripts\engine\utility::flag_init("player_is_up");
  scripts\engine\utility::flag_init("sicario_street_exit");
  scripts\engine\utility::flag_init("moving_cars_2");
  scripts\engine\utility::flag_init("weapons_free");
  scripts\engine\utility::flag_init("gun_raised");
  scripts\engine\utility::flag_init("standoff_complete");
  scripts\engine\utility::flag_init("standoff_vo_complete");
  thread setup_level_arrays();
  thread setup_civ_groups();
  var_0 = getEntArray("player_movement_clip", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 notsolid();
}

setup_level_arrays() {
  level.intro_windows["front"] = [];
  level.intro_windows["back"] = [];
  level.intro_windows["special1"] = [];
  thread setup_civ_types();
  level.background_civs["tele"] = [];
  level.background_civs["ai"] = [];
  level.background_civs["fake"] = [];
  level.scriptable_cleanup = [];
  level.stepback["g1"] = [];
  level.trailer_left_cars = [];
}

setup_civ_groups() {
  var_0 = [];
  level.skippable_ents = [];
  level.intro_civs = [];
  level.intro_civs["adult"] = var_0;
  level.intro_civs["male"] = var_0;
  level.intro_civs["female"] = var_0;
  level.intro_civs["kids"] = getspawnerarray("civilian_new_child");
  level.intro_civs["noStandoff"] = [];
  level.intro_civs["injured"] = [];
  level.intro_civs["oneOff"] = [];
  level.intro_civs["dead"] = [];
  level.intro_civs["post"] = [];

  foreach(var_2 in level.intro_civs["kids"]) {
    if(var_2.script_namenumber == "male") {
      level.intro_civs["boy"] = var_2;
      continue;
    }

    level.intro_civs["girl"] = var_2;
  }

  var_4 = getspawnerarray("civilians_intro");

  foreach(var_2 in var_4) {
    if(var_2.script_namenumber == "random") {
      level.intro_civs["adult"][level.intro_civs["adult"].size] = var_2;
      continue;
    }

    if(var_2.script_namenumber == "male") {
      level.intro_civs["male"][level.intro_civs["male"].size] = var_2;
      continue;
    }

    if(var_2.script_namenumber == "female")
      level.intro_civs["female"][level.intro_civs["female"].size] = var_2;
  }
}

postspawn_ally() {
  scripts\common\utility::enable_cqbwalk();
  scripts\common\ai::magic_bullet_shield();
  self.goalradius = 40;
  self.maxsightdistsqrd = 3610000;
  self.primaryweapon = isundefinedweapon();
  self.secondaryweapon = isundefinedweapon();
  var_0 = scripts\sp\utility::make_weapon_special("papa320_black_rain");
  scripts\anim\shared.gsc::forceuseweapon(var_0, "primary");

  if(scripts\sp\starts::is_after_start("post_bomb")) {
    scripts\engine\sp\utility::set_force_color("p");
    scripts\common\utility::disable_cqbwalk();
    scripts\common\ai::stop_magic_bullet_shield();
  }
}

postspawn_car1_terry() {
  self.dontmelee = 1;
  self.grenadeammo = 0;
  thread scripts\common\ai::magic_bullet_shield();
  scripts\engine\utility::disable_pain();
  scripts\engine\sp\utility::disable_surprise();
  scripts\sp\utility::context_melee_allow(0);
  self actoraimassistoff();
  thread terry_damage_monitor();

  if(self.animname == "car1_terry1")
    level.aq_soldier_3 = self;

  self allowedstances("stand");
  thread notify_whizby_from_player();
  swap_weapon_to("iw8_pi_mike1911");
  scripts\common\ai::gun_remove();
  scripts\engine\utility::flag_wait("car2_detonation");
  thread scripts\common\ai::stop_magic_bullet_shield();
  self actoraimassiston();
  scripts\common\ai::gun_recall();
  scripts\common\utility::clear_demeanor_override();
  self.dontevershoot = 0;
}

postspawn_car1_terries() {
  self.ignoreme = 1;
  self.health = 25;
  thread scripts\common\ai::magic_bullet_shield();
  swap_weapon_to("iw8_pi_mike1911");
  scripts\sp\utility::context_melee_allow(0);
  scripts\common\ai::gun_remove();
  scripts\engine\utility::disable_pain();
  self visiblenotsolid();
  self actoraimassistoff();
  thread terry_damage_monitor();

  if(self.animname == "car1_terry2")
    level.car1_terry2 = self;
  else
    level.car1_terry3 = self;

  scripts\engine\utility::flag_wait("car2_detonation");
  self actoraimassiston();
  scripts\common\ai::gun_recall();
  self visiblesolid();
  self endon("death");

  if(self.animname == "car1_terry2")
    wait 7.4;
  else
    wait 8;

  scripts\common\ai::stop_magic_bullet_shield();
  self.allowdeath = 1;
  self.skipdeathanim = 1;
}

postspawn_car2_terry() {
  self endon("death");
  self.grenadeammo = 0;
  self.dontevershoot = 1;
  self.ignoreme = 1;
  self.baseaccuracy = 0.25;
  self.combatmode = "no_cover";
  scripts\engine\sp\utility::set_attackeraccuracy(10);
  scripts\sp\utility::context_melee_allow(0);
  self actoraimassistoff();
  thread terry_damage_monitor();

  if(self.animname == "car2_terry1")
    level.aq_soldier_1 = self;

  if(self.animname == "car2_terry2")
    level.aq_soldier_2 = self;

  thread notify_whizby_from_player();
  swap_weapon_to("iw8_pi_mike1911");

  if(!scripts\engine\utility::flag("weapons_free"))
    scripts\common\utility::demeanor_override("casual");

  wait 0.1;
  self.ignoreall = 0;
  scripts\engine\utility::flag_wait("weapons_free");
  self actoraimassiston();
  scripts\common\ai::gun_recall();
  scripts\common\utility::clear_demeanor_override();
  self.dontevershoot = 0;
}

terry_damage_monitor() {
  level endon("car2_detonation");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);

    if(isDefined(var_1) && var_1 == level.player) {
      if(isDefined(var_4) && var_4 == "MOD_MELEE") {
        scripts\sp\player_death::set_custom_death_quote(88);
        scripts\sp\utility::missionfailedwrapper();
      }
    }
  }
}

swap_weapon_to(var_0) {
  self.primaryweapon = isundefinedweapon();
  self.secondaryweapon = isundefinedweapon();
  var_1 = scripts\sp\utility::make_weapon(var_0);
  scripts\anim\shared.gsc::forceuseweapon(var_1, "primary");
}

notify_whizby_from_player() {
  level endon("weapons_free");

  for(;;) {
    self waittill("bulletwhizby", var_0);

    if(scripts\engine\utility::is_equal(var_0, level.player))
      scripts\engine\utility::flag_set("weapons_free");
  }
}

postspawn_intro_civ() {
  self endon("death");
  self.goalradius = 40;
  scripts\asm\asm_bb::bb_setcivilianstate("casual");
  scripts\engine\utility::set_movement_speed(30 + randomint(30));

  if(scripts\engine\utility::is_equal(self.script_noteworthy, "teleport_closer"))
    level.background_civs["tele"][level.background_civs["tele"].size] = self;

  if(scripts\engine\utility::is_equal(self.script_noteworthy, "front")) {
    scripts\engine\utility::flag_wait("car2_detonation");
    wait 1;
    self delete();
  } else
    level.background_civs["ai"][level.background_civs["ai"].size] = self;
}

start() {
  scripts\sp\hud_util::fade_out(0);
}

main() {
  var_0 = scripts\engine\utility::getStruct("intro_slammzoom_node", "targetname");
  setglobalsoundcontext("dusty", "yes");
  var_1 = getDvar("OMNONNMOTP");
  setsaveddvar("OMNONNMOTP", "0.1 500 1.5 10000");
  thread skippable_intro();
  thread intro_london_bink();
  thread spawn_animated_intro_civs();
  thread intro_bus(var_0);
  scripts\engine\utility::delaythread(0.1, scripts\engine\sp\utility::battlechatter_off);
  thread sfx_piccadilly_intro_mix();
  thread vo_intro_walla();
  scripts\engine\sp\utility::array_spawn_targetname("intro_civs");
  level.street_friendlies = scripts\engine\sp\utility::array_spawn_targetname("sicario_street_friendly");

  foreach(var_3 in level.street_friendlies) {
    if(scripts\engine\utility::is_equal(var_3.script_friendname, "Sgt. Crowley")) {
      var_3 scripts\sp\maps\piccadilly\piccadilly_gap.gsc::set_friendname("Cst. Brooks", "Trojan 3-1");
      continue;
    }

    if(scripts\engine\utility::is_equal(var_3.script_friendname, "Cst. Brooks"))
      var_3 scripts\sp\maps\piccadilly\piccadilly_gap.gsc::set_friendname("Sgt. Crowley", "Sabre 2-4");
  }

  level.car1_terries = scripts\engine\sp\utility::array_spawn_targetname("car1_terries", 1);
  level.car2_terries = scripts\engine\sp\utility::array_spawn_targetname("car2_terry", 1);
  level.car1_terry = scripts\engine\sp\utility::spawn_targetname("car1_terry", 1);
  level.skippable_ents[level.skippable_ents.size] = level.car1_terry;
  level.player lerpfovscalefactor(0, 0);
  level.player modifybasefov(53, 0.01);
  intro_street_player_movement();
  level.scr_model["player_rig"] = "viewhands_fullbody_kyle_sas_urban";
  level.player_rig = scripts\engine\sp\utility::spawn_anim_model("player_rig", var_0.origin, var_0.angles);
  var_0 scripts\common\anim::anim_first_frame_solo(level.player_rig, "intro_slamzoom");
  level.skippable_ents[level.skippable_ents.size] = level.player_rig;
  level.kyledrone = scripts\engine\sp\utility::spawn_targetname("kyle", 1);
  level.kyledrone kyledrone_extras();
  level.skippable_ents[level.skippable_ents.size] = level.kyledrone;
  level.truck = setup_scriptable_car("sas_intro_decho");
  level.truck thread scripts\sp\maps\piccadilly\piccadilly_lighting.gsc::setup_truck_lighting();
  thread scripts\sp\maps\piccadilly\piccadilly_lighting.gsc::infil_start();
  level.cars_bomb["van"] = setup_scriptable_car("car2_bomb");
  level.cars_bomb["car1"] = setup_scriptable_car("car1_bomb");
  level.cars_bomb["ralfa"] = setup_scriptable_car("car3_bomb");
  level.cars_bomb["cab"] = setup_scriptable_car("car4_bomb");
  level.cars_bomb["van"] setup_temp_car_stuff();
  thread intro_background_traffic();
  thread show_aftermath_geo();
  scripts\engine\sp\objectives::objective_add("piccadilly_objective", "current", undefined, &"PICCADILLY/OBJ_INTRO");
  setmusicstate("mx_piccadilly_truckintro_os");
  thread attach_player_to_rig(level.player_rig);
  var_5 = scripts\engine\utility::array_combine(level.street_friendlies, level.car1_terries, [level.car1_terry]);
  scripts\engine\utility::array_thread(var_5, ::intro_anims_allies, var_0);
  var_6 = [level.player_rig, level.kyledrone];
  scripts\engine\utility::array_thread(var_6, ::intro_anims_non_ai, var_0);
  var_0 notify("start_bus");
  scripts\engine\utility::array_thread(level.car2_terries, ::intro_anims_car2, var_0);
  thread intro_car(var_0);
  scripts\engine\utility::flag_wait("boots_on_the_ground");
  level notify("vo_standoff_walla");
  setsaveddvar("OMNONNMOTP", var_1);
  scripts\engine\sp\objectives::objective_update("piccadilly_objective", "current", undefined, &"PICCADILLY/OBJ_APPROACH_VAN", &"PICCADILLY/CURSOR_TARGET");
  scripts\engine\sp\objectives::objective_set_on_entity("piccadilly_objective", "Target", level.cars_bomb["van"]);
  scripts\engine\sp\objectives::objective_set_z_offset("piccadilly_objective", 120);
  thread scripts\engine\sp\utility::autosave_now();
  thread player_speed_management_intro("car2_detonation");
  thread player_is_close_watcher();
  thread player_roe_check();
}

catchup() {
  scripts\engine\utility::flag_set("boots_on_the_ground");
  scripts\engine\utility::flag_set("camera_move_done");
  scripts\engine\utility::flag_set("intro_bink_done");
  scripts\engine\utility::flag_set("sas2_ready");
  var_0 = getEnt("intro_bus", "targetname");
  var_0 delete();
}

skippable_intro() {
  var_0 = ["skippable_intro_ready", "skippable_civs_ready"];
  level scripts\engine\utility::waittill_all_in_array(var_0);
  var_1 = scripts\engine\utility::array_combine(level.intro_civs["injured"], level.intro_civs["dead"], level.intro_civs["noStandoff"], level.intro_civs["oneOff"], level.intro_civs["post"]);
  var_2 = scripts\engine\utility::array_combine(level.street_friendlies, level.skippable_ents, level.car1_terries, level.car2_terries);
  var_3 = scripts\engine\utility::array_combine(level.intro_cars, level.cars_bomb, [level.truck]);
  var_4 = scripts\engine\utility::array_combine(var_1, var_2, var_3);
  wait 1.5;
  var_5 = scripts\sp\utility::userskip_wait();
  setmusicstate("");

  if(!var_5) {
    return;
  }
  scripts\sp\hud_util::fade_out(0);
  var_6 = "intro_slamzoom";
  var_7 = scripts\engine\utility::getStruct("intro_slammzoom_node", "targetname");

  foreach(var_9 in var_4) {
    if(!isDefined(var_9)) {
      continue;
    }
    if(scripts\engine\utility::array_contains(var_3, var_9))
      var_9 thread skip_ahead_scriptable(var_7, 994.0);
    else if(isDefined(level.scr_anim[var_9.animname][var_6]))
      var_9 thread skip_ahead(var_6, 49.7);

    if(isDefined(var_9))
      var_9 stopsounds();
  }

  if(isDefined(level.intro_bus))
    level.intro_bus delete();

  waitframe();
  level notify("all_ents_are_ready");
  level.player stopsounds();
  level.player_rig stopsounds();
  getrandomnodedestination(0, 0);
  level.player clearcinematicmotionoverride();
  level.player dontinterpolate();
  level.player setOrigin(level.player_rig.origin);
  level.player setplayerangles(level.player_rig.origin);
  level.player playerlinktoabsolute(level.player_rig, "tag_player");
  level.player lerpfovscalefactor(1, 0);
  scripts\engine\utility::delaythread(0.25, scripts\sp\hud_util::fade_in, 0.05);
  scripts\sp\utility::userskip_stop();
  scripts\engine\utility::flag_set("intro_skipped");
  level.player clearclienttriggeraudiozone(2.5);
  setmusicstate("");

  if(!scripts\engine\utility::flag("intro_bink_done")) {
    if(iscinematicplaying())
      stopcinematicingame();

    setomnvar("ui_hide_hud", 0);
    level.player scripts\sp\utility::allow_cg_drawcrosshair(1);
    setomnvar("ui_hide_weapon_info", 0);
  }

  scripts\engine\utility::flag_set("camera_move_done");
  scripts\engine\utility::flag_set("intro_bink_done");
  scripts\engine\utility::exploder("rain_amb");
  visionsetnaked("", 1);
  level thread scripts\engine\sp\utility::dof_disable_autofocus();
  level.player_rig thread unlink_player_after_boots();
}

skip_ahead(var_0, var_1) {
  var_2 = getanimlength(scripts\engine\utility::getanim(var_0));

  if(var_2 <= var_1) {
    self stopsounds();
    waitframe();
    self delete();
    return;
  } else {
    level waittill("all_ents_are_ready");

    if(self.animname == "player_rig")
      var_1 = var_1 - 0.5;

    var_3 = (var_2 - var_1) / var_2;
    var_3 = 1 - var_3;
    self setanimtime(scripts\engine\utility::getanim(var_0), var_3);
  }
}

player_speed_management_intro(var_0) {
  scripts\sp\player::player_movement_state("creep");
  var_1 = 40;
  var_2 = 90;
  var_3 = 20;
  var_4 = 140;

  while(!scripts\engine\utility::flag(var_0)) {
    var_5 = sortbydistance(level.street_friendlies, level.player.origin)[0];
    var_6 = distance(var_5.origin, level.player.origin);
    var_7 = scripts\engine\math::normalize_value(var_3, var_4, var_6);
    var_8 = scripts\engine\math::factor_value(var_1, var_2, var_7);
    scripts\engine\sp\utility::player_speed_set(var_8);
    waitframe();
  }

  scripts\sp\player::player_movement_state("cqb");
}

kyledrone_extras() {
  level endon("death");
  level.kyledrone scripts\engine\sp\utility::enable_dontevershoot();
  level.kyledrone scripts\engine\sp\utility::set_ignoreall(1);
  level.kyledrone scripts\engine\sp\utility::set_ignoreme(1);
  level.kyledrone.script_friendname = "Sgt. Kyle Garrick";
  level.kyledrone.name = "Sgt. Kyle Garrick";
  level.kyledrone scripts\engine\sp\utility::name_hide();
}

sfx_piccadilly_intro_mix() {
  wait 0.1;
  level.player setclienttriggeraudiozonepartial("piccadilly_intro_mix", "mix");
}

intro_london_bink() {
  level endon("intro_skipped");
  childthread cine_letterboxing();
  setomnvar("ui_hide_hud", 1);
  level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
  setomnvar("ui_hide_weapon_info", 1);
  scripts\engine\utility::flag_wait("intro_civs_ready");
  wait 1.5;

  if(!iscinematicplaying()) {
    setsaveddvar("MMRNLMPPLT", "1");
    setsaveddvar("RKMNLRNS", "1");
    cinematicingame("sp_piccadilly_london_title");
  }

  wait 0.1;

  while(iscinematicplaying())
    waitframe();

  setomnvar("ui_hide_hud", 0);
  level.player scripts\sp\utility::allow_cg_drawcrosshair(1);
  setomnvar("ui_hide_weapon_info", 0);
  scripts\engine\utility::flag_set("intro_bink_done");
}

cine_letterboxing() {
  level.player setcinematicmotionoverride("disabled");
  hidecinematicletterboxing(0, 0);
  level waittill("cine_letterboxing");
  getrandomnodedestination(1.5, 0);
  level.player clearcinematicmotionoverride();
}

setup_scripted_car(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_1.animname = var_0;
  var_1 scripts\engine\sp\utility::assign_animtree();
  return var_1;
}

setup_scriptable_car(var_0) {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var_1 = getscriptablearray(var_0, "targetname");
  var_1[0].animname = var_0;
  var_1[0] scripts\engine\sp\utility::assign_animtree();
  var_1[0] thread setup_script_collision();
  var_1[0] setscriptablepartstate("lights_controller", "on_nolight");
  return var_1[0];
}

setup_temp_car_stuff() {
  var_0 = getEnt("truck_light", "targetname");
  var_0 linkTo(self, "tag_origin", (-20, -20, 90), (0, 0, 0));
  self.lightback = var_0;
  var_0 = getEnt("truck_light_driver", "targetname");
  var_0 linkTo(self, "tag_origin", (60, -5, 70), (0, 0, 0));
  self.lightfront = var_0;
  var_1 = [(-28, 15, 25), (0, 30, 25), (0, 0, 25)];
  var_2 = getEntArray("truck_bomb", "targetname");
  self.bombs = [];

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_2[var_3] linkTo(self, "tag_origin", var_1[var_3], (0, 0, 0));
    self.bombs[self.bombs.size] = var_2[var_3];
  }
}

setup_script_collision() {
  if(isDefined(self.script_noteworthy)) {
    switch (self.script_noteworthy) {
      case "bomb_car_coll":
      case "intro_slamzoom_car_r3":
      case "intro_slamzoom_car_r2":
      case "intro_slamzoom_car_r1":
        var_0 = sortbydistance(level.script_car_collision, self.origin)[0];
        self.scriptcoll = var_0;
        self.scriptcoll linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
        self.scriptcoll.trigger scripts\engine\utility::trigger_off();
        thread delete_my_script_collision();
        break;
      default:
        break;
    }
  }
}

delete_my_script_collision() {
  if(self.animname == "intro_car5")
    scripts\engine\utility::flag_wait("boots_on_the_ground");
  else
    scripts\engine\utility::flag_wait("combat_start");

  self.scriptcoll scripts\sp\maps\piccadilly\piccadilly_ambient.gsc::script_collision_delete();
}

car_civs() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  thread car_civs_intro();
}

car_civs_intro() {
  var_0 = getscriptablearray("intro_street_civ_car", "targetname");
  thread scripts\engine\utility::array_thread_amortized(var_0, ::scriptable_car_passenger, 0.1);
}

scriptable_car_passenger() {
  self.type = get_car_type();
  self.passengers = [];
  var_0 = "rf";
  var_1 = ["male", "female"];
  var_2 = randomintrange(0, 2);
  var_3 = scripts\sp\maps\piccadilly\piccadilly_civs.gsc::spawn_civ(var_1[var_2], 1);

  if(isDefined(var_3)) {
    self.passengers[self.passengers.size] = var_3;
    var_3.animname = self.type + "_" + var_0;
    var_3.seat = var_0;
    var_3 thread street_car_passenger(self);
    scripts\engine\sp\utility::add_cleanup_ent(var_3, "infil_ents");
  }
}

get_car_type() {
  var_0 = ["calfa", "ralfa", "skilo", "decho", "victor40"];

  foreach(var_2 in var_0) {
    if(issubstr(self.classname, var_2))
      return var_2;
  }

  return undefined;
}

street_car_passenger(var_0) {
  self endon("death");
  self endon("exiting_car");
  var_1 = [];
  var_2 = cos(18);
  self linkTo(var_0);
  var_0 thread scripts\common\anim::anim_loop_solo(self, "car_idle_" + self.seat, "stop_loop_" + self.animname);

  if(self.seat == "rf")
    var_1 = ["car_right_rf", "car_right_fwd_rf", "car_right_back_rf"];
  else
    var_1 = ["car_right_lf", "car_right_fwd_lf", "car_right_back_lf"];

  scripts\engine\utility::flag_wait("boots_on_the_ground");
  var_3 = gettime();
  var_4 = randomintrange(6000, 8000);

  for(;;) {
    if(in_player_fov(var_2)) {
      var_0 notify("stop_loop_" + self.animname);
      var_0 scripts\common\anim::anim_single_solo(self, "car_react_" + self.seat);
      var_0 thread scripts\common\anim::anim_loop_solo(self, "car_react_" + self.seat + "_idle", "stop_loop_" + self.animname);

      while(in_player_fov(var_2))
        waitframe();

      var_0 notify("stop_loop_" + self.animname);
      var_0 scripts\common\anim::anim_single_solo(self, "car_react_back_" + self.seat);
      var_0 thread scripts\common\anim::anim_loop_solo(self, "car_idle_" + self.seat, "stop_loop_" + self.animname);
      wait(randomfloatrange(1, 2.5));
      var_3 = gettime();
    } else if(gettime() > var_3 + var_4) {
      var_5 = randomintrange(0, 3);
      childthread cut_anim_short(var_2);
      var_0 notify("stop_loop_" + self.animname);
      var_0 scripts\common\anim::anim_single_solo(self, var_1[var_5]);
      self notify("player_is_looking_at_me");
      var_0 thread scripts\common\anim::anim_loop_solo(self, "car_idle_" + self.seat, "stop_loop_" + self.animname);
      var_3 = gettime();
      var_4 = randomintrange(6000, 8000);
    }

    wait 0.5;
  }
}

in_player_fov(var_0) {
  if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self gettagorigin("j_head"), var_0))
    return 1;
  else
    return 0;
}

cut_anim_short(var_0) {
  self endon("player_is_looking_at_me");

  while(!in_player_fov(var_0))
    waitframe();

  scripts\engine\sp\utility::anim_stopanimScripted();
}

intro_street_player_movement() {
  if(!scripts\engine\sp\utility::is_default_start())
    level.player modifybasefov(65, 0.05);
}

setup_vo_civs() {
  level.civ_type["male"][level.civ_type["male"].size] = 8;
  level.civ_type["female"][level.civ_type["female"].size] = 14;
  level.civ_type["male"][level.civ_type["male"].size] = 2;
  level.intro_vo_civs = [];
  level.intro_vo_civs[8] = "uk_civilian_male_1";
  level.intro_vo_civs[14] = "uk_civilian_female_1";
  level.intro_vo_civs[2] = "uk_civilian_male_2";
}

spawn_animated_intro_civs() {
  setup_vo_civs();

  for(var_0 = 1; var_0 < 36; var_0++) {
    if(var_0 != 30)
      thread intro_civ_setup(var_0);
  }

  level.intro_civs["injured"] thread intro_civ_anims(1, 1);
  level.intro_civs["dead"] thread intro_civ_anims(0, 1);
  level.intro_civs["noStandoff"] thread intro_civ_anims(0, 0);
  thread car_civs();
  thread intro_civ_background();
  scripts\engine\utility::flag_set("intro_civs_ready");
  scripts\engine\utility::delaythread(0.5, scripts\sp\hud_util::fade_in, 0.05);
  level.intro_civs["oneOff"] thread intro_civ_oneoff();

  for(var_0 = 36; var_0 < 54; var_0++)
    thread intro_civ_post_setup(var_0);

  level.intro_civs["post"] thread intro_civ_post_anims();
  wait 0.4;
  level notify("skippable_civs_ready");
}

intro_civ_background() {
  var_0 = scripts\engine\utility::getStructArray("background_civs_idle", "targetname");
  scripts\engine\utility::array_thread(var_0, ::intro_civ_background_idle);
  scripts\engine\utility::flag_wait("car2_detonation");
  wait 1;
  var_0 = scripts\engine\utility::getStructArray("post_explosion_run_to", "script_noteworthy");
  level.background_civs["fake"] = scripts\engine\utility::array_removedead(level.background_civs["fake"]);
  level.background_civs["fake"] = scripts\engine\utility::array_removeundefined(level.background_civs["fake"]);
  scripts\engine\utility::array_thread(level.background_civs["fake"], ::background_scatter_fake, var_0);
  var_1 = 0;

  foreach(var_3 in level.background_civs["ai"]) {
    if(isDefined(var_3)) {
      var_3 forceteleport(var_3.origin, (0, 0, 0));
      var_3 setgoalpos(var_3.origin);

      if(var_1 >= var_0.size)
        var_1 = 0;

      var_3 childthread background_scatter_runto(var_0[var_1]);
      var_1++;
    }
  }

  var_5 = scripts\engine\utility::getStructArray("teleport_closer", "script_noteworthy");

  foreach(var_3 in level.background_civs["tele"]) {
    if(isDefined(var_3)) {
      var_7 = var_5[0];
      var_5 = scripts\engine\utility::array_remove(var_5, var_5[0]);
      var_3 forceteleport(var_7.origin, (0, 0, 0));
      var_3 setgoalpos(var_7.origin);

      if(var_1 >= var_0.size)
        var_1 = 0;

      var_3 childthread background_scatter_runto(var_0[var_1]);
      var_1++;
    }
  }
}

intro_civ_background_idle() {
  var_0 = randomintrange(1, 5);
  var_1 = get_random_spawner(var_0);
  var_2 = scripts\engine\sp\utility::fakeactorspawn(var_1);
  var_2.animname = "generic";
  var_2.animnode = self;
  var_2.current_state = "idle";
  var_3 = randomfloatrange(0, 1.5);
  var_2 scripts\engine\utility::delaythread(var_3, ::civ_loop, self);
  level.background_civs["fake"][level.background_civs["fake"].size] = var_2;
  scripts\engine\sp\utility::add_cleanup_ent(var_2, "infil_ents");
}

civ_loop(var_0) {
  self endon("civ_stop_background_loop");
  self endon("death");

  for(;;) {
    var_1 = randomintrange(1, 5);
    var_0 scripts\common\anim::anim_single_solo(self, "background_idle" + var_1);
  }
}

background_scatter_fake(var_0) {
  self endon("death");
  wait 3;
  self notify("civ_stop_background_loop");
  scripts\engine\sp\utility::anim_stopanimScripted();
  self.animnode.node_claimed = [];
  self.current_node = self.animnode;
  var_1 = scripts\engine\utility::getStruct(self.animnode.target, "targetname");
  var_2 = scripts\sp\fakeactor_node::fakeactor_node_get_path(var_1, self.origin, scripts\sp\fakeactor::is_frantic(), 1);
  self.forced_node_path = var_2;
}

background_scatter_runto(var_0) {
  self endon("death");
  self notify("stop_going_to_node");
  scripts\engine\utility::set_movement_speed(scripts\sp\maps\piccadilly\piccadilly_util.gsc::get_random_civilian_speed());
  wait(randomfloatrange(2.5, 4.5));
  self setgoalpos(var_0.origin);
  wait 0.5;
  scripts\engine\utility::waittill_any("goal", "goal_reached");
  self delete();
}

attach_and_detach_phone() {
  self attach("offhand_wm_smartphone", "tag_accessory_right");
  level waittill("delete_phones");
  self detach("offhand_wm_smartphone", "tag_accessory_right");
}

setup_civ_types() {
  level.civ_type["girl"] = [51];
  level.civ_type["boy"] = [29, 31];
  level.civ_type["male"] = [1, 2, 5, 6, 7, 10, 13, 15, 17, 19, 24, 28, 32, 34, 35, 36, 37, 38, 39, 46, 47];
  level.civ_type["female"] = [3, 4, 8, 9, 11, 12, 14, 16, 18, 20, 21, 22, 23, 25, 26, 27, 26, 33, 40, 41, 42, 43, 44, 45, 48, 49, 50, 52, 53];
}

intro_civ_setup(var_0) {
  var_1 = get_random_spawner(var_0);
  var_2 = var_1 bodyonly_guy_setup(var_0);
  var_2 thread bodyonly_guy_damage_monitor();
  var_2 thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::acievement_monitor();
  scripts\engine\sp\utility::add_cleanup_ent(var_2, "infil_ents");

  if(var_0 == 22 || var_0 == 31)
    level.intro_civs["oneOff"][level.intro_civs["oneOff"].size] = var_2;
  else if(!isDefined(level.scr_anim["civ" + var_0]["intro_standoff"]))
    level.intro_civs["noStandoff"][level.intro_civs["noStandoff"].size] = var_2;
  else if(isDefined(level.scr_anim["civ" + var_0]["intro_idle"]))
    level.intro_civs["injured"][level.intro_civs["injured"].size] = var_2;
  else
    level.intro_civs["dead"][level.intro_civs["dead"].size] = var_2;

  var_2 intro_civ_alterations(var_0);

  if(isDefined(level.intro_vo_civs[var_0])) {
    var_3 = level.intro_vo_civs[var_0];
    level.intro_vo_civs[var_3] = var_2;
    level.intro_vo_civs[var_0] = undefined;
  }
}

intro_civ_alterations(var_0) {
  switch (var_0) {
    case 34:
    case 19:
      thread attach_and_detach_phone();
      break;
    case 8:
      civ_different_everything("body_civ_london_male_1_1", "head_sc_m_antoniazzi_civ");
      break;
    case 5:
      civ_different_everything("body_civ_london_male_10_1", "head_sc_m_androsov_civ_tint");
      break;
    case 1:
      civ_different_everything("body_civ_london_male_7_2", "head_sc_m_tang_civ");
      break;
    case 4:
      civ_different_everything("body_civ_london_female_8_1", "head_sc_f_rezaee");
      break;
    case 20:
      civ_different_everything("body_civ_london_female_4_1", "head_sc_f_eghbali_hair");
      break;
    case 14:
      civ_different_everything("body_civ_london_female_9_2", "head_sc_f_toyouri");
      break;
    case 16:
      civ_different_everything("body_civ_london_female_10_2", "head_sc_f_hoggard_civ");
      break;
    case 33:
      civ_different_everything("body_civ_london_female_6_1", "head_sc_f_cromwell");
      break;
    case 31:
      civ_different_everything("body_civ_western_boy_2_1", "head_sc_m_vozhyuk_child");
      break;
    case 29:
    case 26:
    case 6:
    case 2:
      thread hide_during_intro();
      break;
  }
}

civ_different_everything(var_0, var_1) {
  self setModel(var_0);
  self detach(self.headmodel);
  self.headmodel = var_1;
  self attach(self.headmodel);
}

hide_during_intro() {
  if(scripts\sp\starts::is_after_start("infil")) {
    return;
  }
  self hide();
  level scripts\engine\utility::waittill_any_timeout(20, "all_ents_are_ready", "intro_skipped");
  self show();
}

intro_civ_anims(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct("intro_slammzoom_node", "targetname");
  var_3 = "intro";
  var_4 = self;

  if(level.start_point == "infil") {
    foreach(var_6 in self)
    var_2 scripts\common\anim::anim_first_frame_solo(var_6, var_3 + "_slamzoom");

    scripts\engine\utility::flag_wait("intro_civs_ready");
    var_2 notify("stop_first_frame");

    foreach(var_6 in self)
    var_6 thread anim_single_then_loop_ent(var_2, var_3 + "_slamzoom", var_3, "stop_loop_intro");
  } else if(level.start_point == "infil_car1") {
    foreach(var_6 in self)
    var_2 thread scripts\common\anim::anim_loop_solo(var_6, var_3, "stop_loop_intro");
  }

  if(level.start_point == "infil_car1" || level.start_point == "infil") {
    if(var_1) {
      var_12 = [];
      scripts\engine\utility::flag_wait("standoff_ready");

      foreach(var_6 in self) {
        if(!var_6.play_out_intro)
          var_6 notify("anim_finished");
      }

      foreach(var_6 in self) {
        if(isDefined(var_6)) {
          if(var_6.play_out_intro) {
            if(var_6.animname == "civ20") {
              var_6 thread anim_wait_for_ent_flag(var_2, var_3);
              var_4 = scripts\engine\utility::array_remove(var_4, var_6);
            } else
              var_6 thread anim_wait_for_ent_flag(var_2, var_3);

            continue;
          }

          var_12[var_12.size] = var_6;
          var_6 scripts\engine\sp\utility::anim_stopanimScripted();
        }
      }

      var_2 notify("stop_loop_intro");
      var_2 scripts\common\anim::anim_single(var_12, var_3 + "_standoff");
    } else {
      scripts\engine\utility::flag_wait("force_bomb_start");
      level notify("intro_anim_finished");
      var_2 notify("stop_loop_intro");
    }
  }

  level scripts\engine\sp\utility::notify_delay("delete_phones", 0.1);
  var_2 scripts\common\anim::anim_single(var_4, var_3 + "_run");

  if(var_0) {
    var_2 notify("stop_loop_intro");

    foreach(var_6 in self) {
      if(isDefined(var_6) || isalive(var_6))
        var_2 thread scripts\common\anim::anim_loop_solo(var_6, var_3 + "_idle");
    }
  } else {
    foreach(var_6 in self)
    var_6 thread post_bomb_civ_death(var_2);
  }
}

anim_wait_for_ent_flag(var_0, var_1) {
  level endon("force_bomb_start");
  scripts\engine\utility::ent_flag_wait("this_anim_finished");
  self notify("anim_finished");
  var_0 scripts\common\anim::anim_single_solo(self, var_1 + "_standoff");
}

#using_animtree("generic_human");

post_bomb_civ_death(var_0) {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  self endon("death");

  if(isDefined(level.scr_anim[self.animname]["intro_last_frame"])) {
    var_0 scripts\common\anim::anim_first_frame_solo(self, "intro_last_frame");
    self notsolid();
    self clearanim(%head, 0.1);
    scripts\asm\shared\utility::setfacialindexfornonai("death");
  } else
    self delete();
}

intro_civ_oneoff() {
  if(level.start_point != "infil")
    scripts\engine\utility::array_call(self, ::delete);
  else {
    var_0 = scripts\engine\utility::getStruct("intro_slammzoom_node", "targetname");
    var_0 scripts\common\anim::anim_single(self, "intro_slamzoom");
    scripts\engine\utility::array_call(self, ::delete);
  }
}

get_random_spawner(var_0) {
  var_1 = undefined;

  if(scripts\engine\utility::array_contains(level.civ_type["girl"], var_0))
    var_1 = level.intro_civs["girl"];
  else if(scripts\engine\utility::array_contains(level.civ_type["boy"], var_0))
    var_1 = level.intro_civs["boy"];
  else if(scripts\engine\utility::array_contains(level.civ_type["male"], var_0))
    var_1 = get_random_spawner_type("male");
  else if(scripts\engine\utility::array_contains(level.civ_type["female"], var_0))
    var_1 = get_random_spawner_type("female");
  else
    var_1 = get_random_spawner_type("adult");

  if(var_0 == 3 || var_0 == 23 || var_0 == 44 || var_0 == 50)
    var_1.script_char_index = 5;
  else if(var_0 == 9 || var_0 == 49 || var_0 == 52)
    var_1.script_char_index = 6;
  else
    var_1.script_char_index = undefined;

  return var_1;
}

get_random_spawner_type(var_0) {
  var_1 = level.intro_civs[var_0][randomint(level.intro_civs[var_0].size)];
  return var_1;
}

bodyonly_guy_setup(var_0) {
  var_1 = scripts\engine\sp\utility::bodyonlyspawn(self);
  var_1.animname = "civ" + var_0;
  var_1.spawner = self;
  var_1.animationarchetype = "civilian";
  var_1.fakeactor_face_anim = 1;
  var_1 scripts\engine\utility::ent_flag_init("this_anim_finished");

  if(var_0 == 3 || var_0 == 6 || var_0 == 9 || var_0 == 10 || var_0 == 17 || var_0 == 20 || var_0 == 23 || var_0 == 24 || var_0 == 27 || var_0 == 28)
    var_1.play_out_intro = 1;
  else
    var_1.play_out_intro = 0;

  var_1 scripts\common\ai::magic_bullet_shield(1);
  var_1.team = "allies";
  level thread scripts\sp\friendlyfire::friendly_fire_think(var_1);

  if(!isai(var_1) && !istrue(var_1.script_fakeactor) && !isDefined(var_1.anim_getrootfunc))
    var_1.anim_getrootfunc = scripts\sp\maps\piccadilly\piccadilly.gsc::get_anim_model_root;

  return var_1;
}

bodyonly_guy_damage_monitor() {
  self endon("death");
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);

    if(isDefined(var_1)) {
      self.lastattacker = var_1;

      if(isPlayer(var_1)) {
        if(scripts\engine\utility::flag("car2_guys_dead") && isPlayer(var_1))
          scripts\sp\friendlyfire::missionfail(1);
        else if(!scripts\engine\utility::flag("gun_raised") && !scripts\engine\utility::flag("player_is_up") && isPlayer(var_1)) {
          scripts\sp\player_death::set_custom_death_quote(9);
          thread scripts\sp\utility::missionfailedwrapper();
        }

        break;
      }
    }
  }

  if(isDefined(self.magic_bullet_shield))
    scripts\common\ai::stop_magic_bullet_shield();

  self startragdoll();
  self notsolid();
}

intro_civ_post_setup(var_0) {
  var_1 = get_random_spawner(var_0);
  var_2 = var_1 bodyonly_guy_setup(var_0);
  var_2 thread bodyonly_guy_damage_monitor();

  if(var_0 == 41)
    var_2 thread attach_and_detach_phone();
  else if(var_0 == 48)
    var_2 setModel("civ_london_female_3_2");
  else if(var_0 == 51)
    var_2 setModel("body_civ_western_girl_5_1");
  else if(var_0 == 52)
    var_2 setModel("body_civ_london_female_4_1");

  scripts\engine\sp\utility::add_cleanup_ent(var_2, "post_bomb_ents");
  level.intro_civs["post"][level.intro_civs["post"].size] = var_2;
}

intro_civ_post_anims() {
  var_0 = scripts\engine\utility::getStruct("intro_civ_animnode", "targetname");
  var_1 = "intro";

  if(level.start_point == "infil" || level.start_point == "infil_car1") {
    foreach(var_3 in self)
    var_0 thread scripts\common\anim::anim_loop_solo(var_3, var_1, "stop_loop_post_intro");

    scripts\engine\utility::flag_wait_all("player_at_standoff", "intro_sas_ready");
    var_0 notify("stop_loop_post_intro");

    foreach(var_3 in self)
    var_3 thread anim_single_then_loop(var_0, var_1 + "_standoff", var_1 + "_standoff_idle", "stop_loop_post_intro_" + var_3.animname);

    scripts\engine\utility::flag_wait("start_car2");

    foreach(var_3 in self) {
      var_3 notify("anim_finished");
      var_3 scripts\engine\sp\utility::anim_stopanimScripted();
      var_0 notify("stop_loop_post_intro_" + var_3.animname);
      var_3 thread anim_single_then_last(var_0, var_1);
    }
  }
}

anim_single_then_loop(var_0, var_1, var_2, var_3) {
  self endon("anim_finished");
  var_0 scripts\common\anim::anim_single_solo(self, var_1);
  var_0 thread scripts\common\anim::anim_loop_solo(self, var_2, var_3);
}

anim_single_then_loop_ent(var_0, var_1, var_2, var_3) {
  self endon("anim_finished");
  scripts\engine\utility::ent_flag_clear("this_anim_finished");
  var_0 scripts\common\anim::anim_single_solo(self, var_1);
  scripts\engine\utility::ent_flag_set("this_anim_finished");
  var_0 thread scripts\common\anim::anim_loop_solo(self, var_2, var_3);
}

anim_single_then_last(var_0, var_1) {
  var_0 scripts\common\anim::anim_single_solo(self, var_1 + "_car");
  var_0 scripts\common\anim::anim_last_frame_solo(self, var_1 + "_car");
  scripts\engine\utility::flag_wait("car2_detonation");
  var_0 scripts\common\anim::anim_single_solo(self, var_1 + "_run");

  if(isDefined(level.scr_anim[self.animname][var_1 + "_run_idle"]))
    var_0 thread scripts\common\anim::anim_loop_solo(self, var_1 + "_run_idle");
  else
    thread post_bomb_civ_death(var_0);
}

intro_background_traffic() {
  thread spawn_cross_street_traffic();
  thread spawn_back_street_traffic();
  thread spawn_back_street_loop();
  thread setup_post_bomb_crash();
}

spawn_cross_street_traffic() {
  scripts\engine\utility::flag_wait_any("boots_on_the_ground", "intro_skipped");
  var_0 = scripts\common\vehicle::spawn_vehicles_from_targetname("moving_car");

  foreach(var_2 in var_0) {
    var_2 scripts\common\vehicle::vehicle_lights_on("headlights");
    var_2 scripts\common\vehicle::vehicle_lights_on("brakelights");
    scripts\engine\sp\utility::add_cleanup_ent(var_2, "cross_traffic");
  }

  var_4 = 0;
  var_5 = 1;

  while(var_5 < 4) {
    var_6 = getvehiclenode("moving_car_lane" + var_5, "targetname");
    var_0 thread cross_street_drive(var_6, var_4);
    var_5++;
    var_4 = var_4 + 2;
    wait 1;
  }
}

cross_street_drive(var_0, var_1) {
  level endon("car2_detonation");

  for(;;) {
    var_2 = randomfloatrange(0.5, 2.5);
    wait(var_2);
    self[var_1] scripts\common\vehicle::attach_vehicle_and_gopath(var_0);
    var_2 = randomfloatrange(4, 5.5);
    wait(var_2);
    self[var_1 + 1] scripts\common\vehicle::attach_vehicle_and_gopath(var_0);
    wait(var_2);
  }
}

spawn_back_street_traffic() {
  scripts\engine\utility::flag_wait("boots_on_the_ground");

  for(var_0 = 1; var_0 < 12; var_0++) {
    var_1 = scripts\common\vehicle::spawn_vehicle_from_targetname("car_leaving" + var_0);
    var_1 notsolid();
    var_1 thread back_street_traffic_drive(var_0);
  }
}

back_street_traffic_drive(var_0) {
  if(var_0 == 10)
    wait 1.8;
  else if(var_0 == 11)
    wait 2.2;

  scripts\common\vehicle_paths::gopath(self);
  self.script_vehicle_selfremove = 1;
}

spawn_back_street_loop() {
  var_0 = scripts\common\vehicle::spawn_vehicles_from_targetname("car_leaving_side");

  foreach(var_2 in var_0) {
    if(var_2.script_noteworthy == "1")
      var_0 = sortbydistance(var_0, var_2.origin);
  }

  var_4 = scripts\common\vehicle::spawn_vehicles_from_targetname("car_leaving_main");

  foreach(var_2 in var_4) {
    if(var_2.script_noteworthy == "1")
      var_4 = sortbydistance(var_4, var_2.origin);
  }

  var_7 = scripts\engine\utility::array_combine(var_0, var_4);

  foreach(var_2 in var_7) {
    scripts\engine\sp\utility::add_cleanup_ent(var_2, "background_cars");
    var_2 scripts\common\vehicle::vehicle_lights_on("headlights");
    var_2 scripts\common\vehicle::vehicle_lights_on("brakelights");
  }

  scripts\engine\utility::flag_wait("boots_on_the_ground");
  wait 6.7;
  var_10 = getvehiclenode("backstreet_endnode", "targetname");

  foreach(var_2 in var_4)
  var_2 thread back_street_drive(var_10);
}

back_street_drive(var_0) {
  level endon("car2_detonation");

  if(!isDefined(self.target)) {
    return;
  }
  thread delete_on_flag("car2_detonation");
  var_1 = getvehiclenode(self.target, "targetname");
  thread scripts\common\vehicle::attach_vehicle_and_gopath(var_1);
  wait 2;
  var_2 = squared(70);

  for(;;) {
    var_3 = distance2dsquared(self.origin, var_0.origin);

    if(var_3 <= var_2) {
      break;
    } else
      wait 0.1;
  }

  while(!scripts\engine\utility::flag("car2_detonation")) {
    var_1 = getvehiclenode("m6", "targetname");
    thread scripts\common\vehicle::attach_vehicle_and_gopath(var_1);
    wait 2;

    for(;;) {
      var_3 = distance2dsquared(self.origin, var_0.origin);

      if(var_3 <= var_2) {
        break;
      } else
        wait 0.1;
    }
  }
}

delete_on_flag(var_0) {
  self endon("death");
  self endon("entitydeleted");
  scripts\engine\utility::flag_wait("car2_detonation");
  self delete();
}

setup_post_bomb_crash() {
  var_0 = getscriptablearray("backend_car_crash", "targetname");
  level.scriptable_cleanup = scripts\engine\utility::array_combine(level.scriptable_cleanup, var_0);
  scripts\engine\utility::flag_wait("car2_detonation");
  wait 1;

  foreach(var_2 in var_0)
  var_2.origin = var_2.origin + (0, 0, 96);

  var_0[0] setscriptablepartstate("body", "light_smoke");
  var_0[1] setscriptablepartstate("body", "light_smoke");
  scripts\engine\utility::array_call(var_0, ::setscriptablepartstate, "lights_controller", "on_nolight");
}

show_aftermath_geo() {
  thread show_aftermath_cars();
  thread show_aftermath_windows();
  thread show_aftermath_debris();
  thread intro_lights_setup_omni();
  scripts\engine\utility::flag_wait("car2_detonation");
  thread carbomb_shop_windows();
  thread move_hole_clip();
  scripts\engine\utility::delaythread(0.5, ::dead_charred_bodies);
  scripts\engine\utility::delaythread(0.4, ::delete_storefront_signs);
  scripts\engine\utility::delaythread(0.5, ::intro_lights);
  scripts\engine\utility::delaythread(0.8, ::intro_street_lamps);
}

show_aftermath_cars() {
  var_0 = getEntArray("post_carbomb", "targetname");
  var_1 = getEnt("post_carbomb_clip", "targetname");
  scripts\engine\utility::array_call(var_0, ::hide);
  var_1 notsolid();
  scripts\engine\utility::flag_wait("car2_detonation");
  wait 0.1;
  scripts\engine\utility::array_call(var_0, ::show);
  var_1 solid();
}

show_aftermath_windows() {
  var_0 = getEnt("store_glass_break", "targetname");
  var_0 moveTo(var_0.origin + (0, 0, -250), 0.01);
  scripts\engine\utility::flag_wait("car2_detonation");
  wait 0.8;
  var_0 moveTo(var_0.origin + (0, 0, 250), 0.01);
}

show_aftermath_debris() {
  var_0 = getEnt("crater_debris", "targetname");
  var_1 = getEntArray("deadbody_crater", "targetname");
  var_0 moveTo(var_0.origin + (0, 0, -100), 0.01);

  foreach(var_3 in var_1)
  var_3 moveTo(var_3.origin + (0, 0, -100), 0.01);

  scripts\engine\utility::flag_wait("car2_detonation");
  wait 1;
  var_0 moveTo(var_0.origin + (0, 0, 100), 0.01);

  foreach(var_3 in var_1)
  var_3 moveTo(var_3.origin + (0, 0, 100), 0.01);

  var_7 = getscriptablearray("flag_destroyed", "script_noteworthy");
  var_7[0] setscriptablepartstate("base", "dead");
}

move_hole_clip() {
  var_0 = getEnt("intro_street_hole_clip", "targetname");
  var_0 delete();
}

dead_charred_bodies() {
  var_0 = scripts\engine\utility::getStructArray("intro_civ_dead_struct", "targetname");

  foreach(var_2 in var_0) {
    var_3 = level.intro_civs["adult"][0];
    var_4 = scripts\engine\sp\utility::bodyonlyspawn(var_3);
    var_4.animname = "male_rf";
    var_4.spawner = self;
    var_4 thread start_anim_death(var_2);
  }
}

start_anim_death(var_0) {
  var_0 scripts\common\anim::anim_single_solo(self, "skilo_death");
  self setModel("burntbody_male");
  var_0 scripts\common\anim::anim_last_frame_solo(self, "skilo_death");
  self notsolid();
}

delete_storefront_signs() {
  var_0 = getEnt("post_explosion_sign", "targetname");
  var_0 delete();
}

intro_lights_setup_omni() {
  var_0 = getEntArray("post_explosion", "targetname");

  foreach(var_2 in var_0) {
    if(var_2.classname == "light_omni" || !isDefined(var_2.script_type)) {
      var_2.og_intensity = var_2 getlightintensity();
      var_2 setlightintensity(0);
    }
  }
}

intro_lights() {
  scripts\engine\utility::flag_set("post_explosion");
  var_0 = getEntArray("post_explosion", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.og_intensity))
      var_2 setlightintensity(var_2.og_intensity);
  }

  var_4 = getEntArray("pre_explosion", "targetname");
  scripts\engine\utility::array_thread(var_4, ::intro_lights_cleanup);
}

intro_lights_cleanup() {
  self setlightintensity(0);
}

intro_street_lamps() {
  var_0 = undefined;
  var_1 = scripts\engine\utility::getStructArray("post_explosion_radius_dmg", "targetname");

  foreach(var_3 in var_1) {
    if(scripts\engine\utility::is_equal(var_3.script_noteworthy, "300")) {
      var_4 = randomfloatrange(0.9, 1.4);
      var_3 thread radius_damage(var_4);
      continue;
    }

    var_3 thread radius_damage();
  }
}

radius_damage(var_0) {
  if(isDefined(var_0))
    wait(var_0);

  var_1 = int(self.script_noteworthy);
  radiusdamage(self.origin, self.radius, var_1, var_1, undefined, "MOD_EXPLOSIVE", undefined, 1, 0);
}

attach_player_to_rig(var_0) {
  level endon("intro_skipped");
  level.player enableinvulnerability();
  level.player freezecontrols(1);
  level.player takeallweapons();
  level.player playerlinktoabsolute(var_0, "tag_player");
  level.player disableoffhandweapons();
  level.player allowsprint(0);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level waittill("fp_transition");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0 gettagorigin("tag_player"), var_0 gettagangles("tag_player"));
  level.player unlink();
  level.player playerlinktodelta(var_1, "tag_origin", 1, 24, 58, 20, 30);
  childthread stop_user_skip();
  level waittill("get_out_of_car");
  level.player unlink();
  level.player playerlinktoblend(var_0, "tag_player");
  var_0 childthread unlink_player_after_boots(var_1);
}

unlink_player_after_boots(var_0) {
  scripts\engine\utility::flag_wait("boots_on_the_ground");
  level.player unlink();
  level.player disableinvulnerability();
  level.player enableoffhandweapons();
  level.player allowsprint(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  self delete();

  if(isDefined(var_0))
    var_0 delete();

  level.scr_model["player_rig"] = "viewhands_kyle_sas_urban";
  level thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::piccadilly_weapons();
}

stop_user_skip() {
  wait 13;
  scripts\sp\utility::userskip_stop();
}

player_is_close_watcher() {
  level endon("sas2_ready");
  var_0 = getEnt("player_is_close", "targetname");

  while(!level.player istouching(var_0))
    waitframe();

  scripts\engine\utility::flag_set("player_is_behind_ally");
}

intro_anims_car2(var_0, var_1) {
  self endon("death");
  var_2 = "intro_slamzoom";

  if(self.animname == "car2_terry_driver") {
    level.truck_driver = self;
    scripts\common\ai::gun_remove();
    var_0 scripts\common\anim::anim_single_solo(self, var_2);
    level.car2_terries = scripts\engine\utility::array_remove(level.car2_terries, self);
    self delete();
  } else {
    thread intro_anim_force_stop();
    var_0 scripts\common\anim::anim_single_solo(self, "intro_slamzoom");
    scripts\common\ai::gun_remove();
    var_0 thread scripts\common\anim::anim_loop_solo(self, var_2 + "_v1_idle", "stop_terry_intro_idle");
    self notify("intro_anim_done");
    scripts\engine\utility::flag_wait("intro_sas_ready");
    thread intro_anims_standoff(var_0);
  }
}

intro_anims_allies(var_0) {
  self endon("death");
  var_1 = "intro_slamzoom";
  var_2 = undefined;

  if(self.animname == "sas2") {
    var_3 = ["dx_vom_mick_infil_car1_street_70", "dx_vom_mick_infil_car1_street_80", "dx_vom_mick_infil_car1_street_90"];
    thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::notetrack_nag(var_3, "player_at_standoff");
  }

  var_0 scripts\common\anim::anim_single_solo(self, var_1);
  level notify(self.animname + "_in_position");

  if(self.animname == "car1_terry1" || self.animname == "car1_terry2" || self.animname == "car1_terry3") {
    var_0 scripts\common\anim::anim_last_frame_solo(self, var_1);
    scripts\engine\utility::flag_wait("sas2_ready");
  }

  if(scripts\engine\utility::flag("player_is_behind_ally")) {
    if(self.animname == "sas2") {
      scripts\engine\utility::flag_set("sas2_ready");
      scripts\engine\utility::flag_set("standoff_ready");
      level.cars_bomb["car1"] notify("start_car1_standoff_v2");
      level notify("start_intro_vo");
    }

    var_0 scripts\common\anim::anim_single_solo(self, var_1 + "_v2");
    self notify("intro_anim_done");

    if(self.animname == "sas1") {
      scripts\engine\utility::flag_set("player_at_standoff");
      scripts\engine\utility::flag_set("intro_sas_ready");
    }
  } else {
    if(self.animname == "sas2")
      scripts\engine\utility::flag_set("sas2_ready");

    if(self.animname == "car1_terry2" || self.animname == "car1_terry3") {
      var_0 thread scripts\common\anim::anim_loop_solo(self, var_1 + "_v1_idle", "stop_terry_intro_idle");
      scripts\engine\utility::flag_wait("standoff_ready");
    } else if(self.animname == "sas2") {
      var_2 = spawnStruct();
      var_2.origin = var_0.origin;
      var_0 scripts\common\anim::anim_single_solo(self, var_1 + "_v1_arrival");
      var_2 thread scripts\common\anim::anim_loop_solo_with_nags(self, var_1 + "_v1_sas2_idle", self.animname + "_intro_idle");
      level notify("v1_arrival_finished");
    } else {
      var_0 scripts\common\anim::anim_single_solo(self, var_1 + "_v1_arrival");
      var_0 thread scripts\common\anim::anim_loop_solo(self, var_1 + "_v1_idle", self.animname + "_intro_idle");
      level notify("v1_arrival_finished");
    }

    scripts\engine\utility::flag_wait("player_at_standoff");
    var_0 notify(self.animname + "_intro_idle");

    if(self.animname == "sas2") {
      var_2 notify(self.animname + "_intro_idle");
      level.cars_bomb["car1"] notify("start_car1_standoff_v1");
      scripts\engine\utility::flag_set("standoff_ready");
    }

    var_0 scripts\common\anim::anim_single_solo(self, var_1 + "_v1_exit");
    self notify("intro_anim_done");

    if(self.animname == "sas1")
      scripts\engine\utility::flag_set("intro_sas_ready");
  }

  thread intro_anims_standoff(var_0);
}

intro_standoff_nag() {
  level endon("player_at_standoff");
}

intro_anim_force_stop() {
  self endon("intro_anim_done");
  scripts\engine\utility::flag_wait("start_car2");
  scripts\engine\sp\utility::anim_stopanimScripted();
}

intro_anims_standoff(var_0) {
  scripts\engine\utility::flag_wait("player_at_standoff");
  var_0 notify("stop_terry_intro_idle");
  level notify("start_standoff_scene");
  self endon("start_car2_scene");
  thread intro_anims_car2_scene(var_0);
  var_0 scripts\common\anim::anim_single_solo(self, "standoff");

  if(!scripts\engine\utility::flag("start_car2"))
    scripts\engine\utility::flag_set("start_car2");
}

intro_anims_car2_scene(var_0) {
  scripts\engine\utility::flag_wait("start_car2");
  self notify("start_car2_scene");
  var_0 notify("stop_sas2_standoff_idle");
  var_1 = undefined;
  scripts\engine\sp\utility::anim_stopanimScripted();
  var_0 scripts\common\anim::anim_single_solo(self, "car2_drives_off");

  if(self.animname == "sas2" || self.animname == "car1_terry1") {
    if(self.animname == "sas2")
      scripts\engine\utility::delaythread(3, scripts\sp\maps\piccadilly\piccadilly_anim.gsc::drop_weapon_now, self);

    var_2 = scripts\engine\utility::getStruct("golden_spot_animnode", "targetname");
    var_0 = spawn("script_origin", var_2.origin);
    thread goldenpath_moveTo(var_0);
  } else if(self.animname == "car2_terry1" || self.animname == "car2_terry2" || self.animname == "car2_terry3" || self.animname == "car1_terry2" || self.animname == "car1_terry3") {
    self endon("death");
    self.allowdeath = 1;
  } else if(self.animname == "sas1" || self.animname == "sas3") {
    if(self.animname == "sas1")
      var_0 notify("start_car1_extras");

    thread allies_explosion_bullet_shield();
  }

  var_0 scripts\common\anim::anim_single_solo(self, "car_explosion");

  if(scripts\engine\utility::array_contains(level.street_friendlies, self)) {
    if(self.animname == "sas2") {
      var_0 scripts\common\anim::anim_last_frame_solo(self, "car_explosion");
      level.street_friendlies = scripts\engine\utility::array_remove(level.street_friendlies, self);
      self visiblenotsolid();
      scripts\engine\utility::flag_wait("combat_start");
      scripts\common\ai::stop_magic_bullet_shield();
      self delete();
    } else {
      if(self.animname == "sas1") {
        level.player thread scripts\engine\sp\utility::smart_dialogue("dx_vom_kyle_infil_car1_street_290");
        var_3 = distancesquared(level.player.origin, self.origin);

        if(var_3 > squared(150)) {
          var_4 = getanimlength(scripts\engine\utility::getanim("car_explosion_exit"));
          var_0 thread scripts\common\anim::anim_single_solo(self, "car_explosion_exit");
          wait(var_4 / 1.2);
        } else {
          var_0 scripts\common\anim::anim_single_solo(self, "car_explosion_enter");
          var_0 thread scripts\common\anim::anim_loop_solo(self, "car_explosion_idle", "stop_loop_" + self.animname);

          for(;;) {
            var_3 = distancesquared(level.player.origin, self.origin);

            if(var_3 > squared(150)) {
              break;
            } else
              waitframe();
          }

          var_0 notify("stop_loop_" + self.animname);
          var_0 thread scripts\common\anim::anim_single_solo(self, "car_explosion_idle_exit");
        }
      } else if(self.animname == "sas3") {
        self setgoalpos(self.origin);
        self.ignoreall = 1;

        if(isalive(level.car1_terry2))
          kill_target(level.car1_terry2);

        if(isalive(level.car1_terry)) {
          wait 1.3;
          kill_target(level.car1_terry);
        }

        self.ignoreall = 0;
      }

      scripts\engine\utility::flag_wait("car2_guys_dead");
      var_1 = scripts\engine\utility::getStruct("post_bomb_" + self.animname, "targetname");
      thread start_ally_stayahead_movement(var_1);
    }
  } else if(self.animname == "car2_terry1" || self.animname == "car2_terry2" || self.animname == "car2_terry3") {
    level.car2_terries = scripts\engine\utility::array_remove(level.car2_terries, self);
    self.skipdeathanim = 1;
    self kill();
  } else if(self.animname == "car1_terry2" || self.animname == "car1_terry3") {
    if(!isDefined(self)) {
      return;
    }
    self.allowdeath = 1;
    self.noragdoll = 1;
    self.skipdeathanim = 1;
    self kill();
  } else if(isDefined(self.animname == "car1_terry1")) {
    self endon("death");
    self.ignoreall = 0;
    self getenemyinfo(level.player);
    scripts\engine\sp\utility::set_favoriteenemy(level.player);
    scripts\engine\sp\utility::disable_dontevershoot();
  }
}

allies_explosion_bullet_shield() {
  self.no_friendly_fire_fail = 1;
  scripts\engine\utility::flag_wait("player_is_up");
  wait 5;
  self.no_friendly_fire_fail = 0;
}

goldenpath_moveTo(var_0) {
  self linkTo(var_0);
  level waittill("move_knockback_scene");
  scripts\engine\sp\utility::add_cleanup_ent(var_0, "script_origins");
}

kill_target(var_0) {
  self endon("death");

  if(!isalive(var_0)) {
    return;
  }
  var_0 endon("death");
  self shoot(1, var_0 gettagorigin("j_head"), 1, 1);
  wait 0.3;
  self shoot(1, var_0 gettagorigin("j_head"), 1, 1);

  if(isDefined(var_0.magic_bullet_shield) && var_0.magic_bullet_shield == 1)
    var_0 scripts\common\ai::stop_magic_bullet_shield();

  var_0 kill();
}

intro_anims_non_ai(var_0) {
  level endon("start_car2");
  var_1 = "intro_slamzoom";

  if(self.animname == "player_rig") {
    thread rain_exploder();
    thread infil_visionset();
    scripts\engine\utility::array_thread(level.street_friendlies, scripts\engine\sp\utility::name_hide);
    var_0 scripts\common\anim::anim_single_solo(self, var_1);
    scripts\engine\utility::flag_set("boots_on_the_ground");
    scripts\engine\utility::array_thread(level.street_friendlies, scripts\engine\sp\utility::name_show);
  } else {
    var_0 scripts\common\anim::anim_single_solo(self, var_1);

    if(isDefined(self))
      self delete();
  }
}

rain_exploder() {
  level endon("intro_skipped");
  wait 13;
  scripts\engine\utility::stop_exploder("rain_amb");
  wait 31;
  scripts\engine\utility::exploder("rain_amb");
}

infil_visionset() {
  level endon("intro_skipped");
  wait 12;
  visionsetnaked("piccadilly_infill", 1);
  wait 35;
  visionsetnaked("", 1);
}

intro_bus(var_0) {
  level endon("intro_skipped");
  level.intro_bus = setup_scripted_car("intro_bus");
  level.intro_bus endon("entitydeleted");
  var_0 scripts\common\anim::anim_first_frame_solo(level.intro_bus, "intro_slamzoom");
  var_0 waittill("start_bus");
  var_0 scripts\common\anim::anim_single_solo(level.intro_bus, "intro_slamzoom");
  level.intro_bus delete();
}

intro_car(var_0) {
  scripts\engine\utility::flag_wait("scriptables_ready");
  level.car_order = 1;
  var_1 = 1;

  if(level.start_point != "infil")
    var_1 = 100;

  get_intro_cars(var_0, var_1);
  level.truck thread intro_truck_anims(var_0, var_1);
  level.cars_bomb["van"] thread intro_car2_anims(var_0, var_1);
  level.cars_bomb["car1"] thread intro_car1_anims(var_0, var_1);
  level.cars_bomb["ralfa"] thread intro_cars_extra(var_0, var_1);
  level.cars_bomb["cab"] thread intro_cars_extra(var_0, var_1);
  thread player_hit_watcher();
  wait 0.3;
  level notify("skippable_intro_ready");
}

get_intro_cars(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct("intro_order_r1", "targetname");
  var_3 = getscriptablearray("intro_slamzoom_car_r1", "script_noteworthy");
  var_3 = sortbydistance(var_3, var_2.origin);
  var_2 = scripts\engine\utility::getStruct("intro_order_r2", "targetname");
  var_4 = getscriptablearray("intro_slamzoom_car_r2", "script_noteworthy");
  var_4 = sortbydistance(var_4, var_2.origin);
  var_2 = scripts\engine\utility::getStruct("intro_order_r3", "targetname");
  var_5 = getscriptablearray("intro_slamzoom_car_r3", "script_noteworthy");
  var_5 = sortbydistance(var_5, var_2.origin);
  level.intro_cars = scripts\engine\utility::array_combine(var_3, var_4, var_5);

  foreach(var_8, var_7 in level.intro_cars) {
    level.intro_cars[var_8] thread intro_car_anims(var_0, level.car_order, var_1);
    level.car_order++;
  }
}

play_quick_reaction(var_0) {
  scripts\engine\utility::flag_wait("car2_detonation");
  self notify("exiting_car");

  if(distancesquared(self.origin, level.player.origin) <= squared(175)) {
    scripts\common\ai::magic_bullet_shield();
    wait(randomfloatrange(1.25, 2.75));
    scripts\engine\sp\utility::anim_stopanimScripted();
    var_0 notify("stop_loop_" + self.animname);
    var_0 thread scripts\common\anim::anim_loop_solo(self, "car_react_rf_idle");
    scripts\common\ai::stop_magic_bullet_shield();
    thread bodyonly_guy_in_car_damage_monitor(var_0);
  } else {
    scripts\engine\sp\utility::anim_stopanimScripted();
    var_0 notify("stop_loop_" + self.animname);
    var_0 thread scripts\common\anim::anim_single_solo(self, "car_react_rf");
    wait 2;
    self delete();
  }
}

bodyonly_guy_in_car_damage_monitor(var_0) {
  self endon("death");
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(isDefined(var_2)) {
      self.lastattacker = var_2;

      if(isPlayer(var_2)) {
        scripts\sp\friendlyfire::missionfail(1);
        break;
      }
    }
  }

  if(isDefined(self.magic_bullet_shield))
    scripts\common\ai::stop_magic_bullet_shield();

  self startragdoll();
  self notsolid();
}

#using_animtree("scriptables");

intro_car_anims(var_0, var_1, var_2) {
  self.animname = "intro_car" + var_1;
  scripts\engine\sp\utility::assign_animtree();

  if(var_1 == 3 || var_1 == 4) {
    return;
  }
  if(var_1 == 8 || var_1 == 9)
    level.intro_windows["back"][level.intro_windows["back"].size] = self;
  else if(var_1 == 10)
    level.intro_windows["front"][level.intro_windows["front"].size] = self;
  else if(var_1 == 12)
    level.intro_windows["special1"][level.intro_windows["special1"].size] = self;
  else
    level.scriptable_cleanup[level.scriptable_cleanup.size] = self;

  self.intro_animation = scripts\engine\utility::getanim("intro_slamzoom");
  thread scripts\common\notetrack::start_notetrack_wait(self, "single anim", "intro_slamzoom", self.animname, self.intro_animation);
  thread scripts\sp\anim::animscriptdonotetracksthread(self, "single anim", "intro_slamzoom");
  setup_script_collision();
  var_3 = getstartorigin(var_0.origin, var_0.angles, self.intro_animation);
  var_4 = getstartangles(var_0.origin, var_0.angles, self.intro_animation);
  self.origin = var_3;
  self.angles = var_4;
  self setflaggedanimknoball("single anim", self.intro_animation, %root, 1, 0, var_2);
  var_5 = getanimlength(self.intro_animation);

  if(level.start_point == "infil" && (var_1 == 1 || var_1 == 2 || var_1 == 11 || var_1 == 12 || var_1 == 13)) {
    level.trailer_left_cars[level.trailer_left_cars.size] = self;

    if(var_1 != 13)
      self.tiresounds = "veh_piccadilly_wet_car_tires_lp_0" + level.trailer_left_cars.size;

    var_6 = getEnt("car" + var_1 + "_trigger", "targetname");
    var_6 enablelinkTo();
    var_6 linkTo(self, "tag_origin", (45, 0, 20), (0, 0, 0));
  }

  if(var_1 == 5) {
    if(!scripts\engine\utility::flag("boots_on_the_ground"))
      wait(var_5 / 1.5);

    childthread hide_intro_car();
  } else {
    if(var_1 == 11 || var_1 == 12)
      self setscriptablepartstate("lights_controller", "on");
    else
      self setscriptablepartstate("lights_controller", "on_nolight");

    if(var_1 == 1 || var_1 == 2 || var_1 == 11 || var_1 == 12)
      thread stop_loop_sound_after_anim();

    scripts\engine\utility::flag_wait("car2_detonation");

    if(isDefined(self.passengers))
      scripts\engine\utility::array_thread(self.passengers, ::play_quick_reaction, self);
  }
}

stop_loop_sound_after_anim() {
  level endon("car2_detonation");
  self waittillmatch("single anim", "end");
  self.tiresounds = undefined;
  self stoploopsound();
}

hide_intro_car() {
  if(isDefined(self) && isDefined(self.passengers)) {
    foreach(var_1 in self.passengers) {
      if(isDefined(var_1) && isalive(var_1))
        var_1 delete();
    }
  }

  wait 1;
  self setscriptablepartstate("hide_car", "hide_car");
}

debug_cars(var_0) {
  for(;;)
    wait 0.5;
}

player_hit_watcher() {
  level endon("car2_detonation");

  while(level.trailer_left_cars.size < 4)
    waitframe();

  var_0 = undefined;
  var_1 = getEnt("car11_trigger", "targetname");
  var_2 = getEnt("car1_trigger", "targetname");
  var_3 = getEnt("car13_trigger", "targetname");
  var_4 = getEnt("car2_trigger", "targetname");
  var_5 = [var_1, var_2, var_3, var_4];
  level scripts\engine\utility::waittill_any("get_out_of_car", "intro_skipped");

  foreach(var_7 in level.trailer_left_cars) {
    if(isDefined(var_7.tiresounds))
      var_7 playLoopSound(var_7.tiresounds);
  }

  thread stop_sounds_post_bomb();

  for(;;) {
    while(!level.player scripts\engine\sp\utility::is_touching_any(var_5))
      waitframe();

    if(level.player istouching(var_1))
      var_0 = [level.trailer_left_cars[2], level.trailer_left_cars[0], level.trailer_left_cars[4], level.trailer_left_cars[1]];
    else if(level.player istouching(var_2))
      var_0 = [level.trailer_left_cars[0], level.trailer_left_cars[4], level.trailer_left_cars[1]];
    else if(level.player istouching(var_3))
      var_0 = [level.trailer_left_cars[4], level.trailer_left_cars[1]];
    else if(level.player istouching(var_4))
      var_0 = [level.trailer_left_cars[1]];

    foreach(var_7 in var_0) {
      var_7 setscriptablepartstate("lights_controller", "taillights_braking");
      var_7 setanimrate(var_7.intro_animation, 0);
      var_7 scalevolume(0, 0.5);
    }

    while(level.player scripts\engine\sp\utility::is_touching_any(var_5))
      waitframe();

    wait 1;

    if(level.player scripts\engine\sp\utility::is_touching_any(var_5)) {
      return;
    }
    foreach(var_7 in var_0) {
      var_7 setscriptablepartstate("lights_controller", "taillights_on");
      var_7 setanimrate(var_7.intro_animation, 1);
      var_7 scalevolume(1, 0.5);
    }
  }
}

stop_sounds_post_bomb() {
  scripts\engine\utility::flag_wait("car2_detonation");

  foreach(var_1 in level.trailer_left_cars) {
    if(isDefined(var_1.tiresounds))
      var_1 stoploopsound(var_1.tiresounds);
  }
}

intro_truck_anims(var_0, var_1) {
  var_2 = scripts\engine\utility::getanim("intro_slamzoom");
  thread scripts\common\notetrack::start_notetrack_wait(self, "single anim", "intro_slamzoom", self.animname, var_2);
  thread scripts\sp\anim::animscriptdonotetracksthread(self, "single anim", "intro_slamzoom");
  var_3 = getstartorigin(var_0.origin, var_0.angles, var_2);
  var_4 = getstartangles(var_0.origin, var_0.angles, var_2);
  self.origin = var_3;
  self.angles = var_4;
  thread intro_truck_fx();
  self setflaggedanimknoball("single anim", var_2, %root, 1, 0, var_1);
}

intro_truck_fx() {
  playFXOnTag(scripts\engine\utility::getfx("vfx_pic_window_drips"), self, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_pic_window_drips_rear_passenger"), self, "tag_window_front_right");
  playFXOnTag(scripts\engine\utility::getfx("vfx_pic_window_drips_rear_passenger"), self, "tag_window_back_right");
}

play_scriptable_car_with_notetracks(var_0, var_1, var_2) {
  thread scripts\common\notetrack::start_notetrack_wait(self, "single anim", "intro_slamzoom", self.animname, var_2);
  thread scripts\sp\anim::animscriptdonotetracksthread(self, "single anim", "intro_slamzoom");
  var_3 = getstartorigin(var_0.origin, var_0.angles, var_2);
  var_4 = getstartangles(var_0.origin, var_0.angles, var_2);
  self.origin = var_3;
  self.angles = var_4;
  self setflaggedanimknoball("single anim", var_2, %root, 1, 0, var_1);
}

intro_car2_anims(var_0, var_1) {
  var_2 = scripts\engine\utility::getanim("intro_slamzoom");
  play_scriptable_car_with_notetracks(var_0, var_1, var_2);
  scripts\engine\utility::flag_wait_all("intro_sas_ready", "player_at_standoff");
  var_2 = scripts\engine\utility::getanim("standoff");
  thread scripts\common\notetrack::start_notetrack_wait(self, "car2_standoff", "standoff", self.animname, var_2);
  thread scripts\sp\anim::animscriptdonotetracksthread(self, "car2_standoff", "standoff");
  self setanimknoball(scripts\engine\utility::getanim("standoff"), %root, 1, 0, 1);
  scripts\engine\utility::flag_wait("start_car2");
  var_2 = scripts\engine\utility::getanim("car2_drives_off");
  thread car2_delete_extras(var_2);
  thread scripts\common\notetrack::start_notetrack_wait(self, "car2_drives", "car2_drives_off", self.animname, var_2);
  thread scripts\sp\anim::animscriptdonotetracksthread(self, "car2_drives", "car2_drives_off");
  thread scripts\engine\sp\utility::autosave_now();
  self setflaggedanimknoball("car2_drives", var_2, %root, 1, 0, 1);
  scripts\engine\utility::flag_wait("car2_detonation");
  scripts\engine\utility::delaythread(0.4, scripts\engine\sp\utility::cleanup_ents, "cross_traffic");
}

car2_delete_extras(var_0) {
  var_1 = getanimlength(var_0);
  wait(var_1);
  scripts\engine\utility::flag_set("force_bomb_start");
  self.lightback setlightintensity(0);
  self.lightfront setlightintensity(0);
  scripts\engine\utility::array_delete(self.bombs);
}

intro_car1_anims(var_0, var_1) {
  var_2 = scripts\engine\utility::getanim("intro_slamzoom");
  play_scriptable_car_with_notetracks(var_0, var_1, var_2);
  thread intro_car1_version1(var_0);
  thread intro_car1_version2(var_0);
}

intro_car1_version1(var_0) {
  self endon("start_car1_standoff_v2");
  var_1 = scripts\engine\utility::getanim("intro_slamzoom_v1_exit");
  var_2 = getanimlength(var_1);
  thread scripts\common\notetrack::start_notetrack_wait(self, "car1_slamzoom_v1_exit", "intro_slamzoom_v1_exit", self.animname, var_1);
  thread scripts\sp\anim::animscriptdonotetracksthread(self, "car1_slamzoom_v1_exit", "intro_slamzoom_v1_exit");
  self waittill("start_car1_standoff_v1");
  self setanimknoball(var_1, %root, 1, 0, 1);
  var_3 = scripts\engine\utility::getanim("intro_standoff");
  thread scripts\common\notetrack::start_notetrack_wait(self, "car1_intro_standoff", "intro_standoff", self.animname, var_3);
  thread scripts\sp\anim::animscriptdonotetracksthread(self, "car1_intro_standoff", "intro_standoff");
  wait(var_2);
  self setanim(var_3, 1, 0, 1);
  self clearanim(var_1, 0);
  var_0 waittill("start_car1_extras");
  thread clip_delete("car1_door_clip", "forever");
  wait 3.3;
  self setanimknoball(scripts\engine\utility::getanim("car_explosion"), %root, 1, 0, 1);
}

intro_car1_version2(var_0) {
  self endon("start_car1_standoff_v1");
  var_1 = scripts\engine\utility::getanim("intro_slamzoom_v2");
  var_2 = getanimlength(var_1);
  thread scripts\common\notetrack::start_notetrack_wait(self, "car1_slamzoom_v2", "intro_slamzoom_v2", self.animname, var_1);
  thread scripts\sp\anim::animscriptdonotetracksthread(self, "car1_slamzoom_v2", "intro_slamzoom_v2");
  self waittill("start_car1_standoff_v2");
  self setanimknoball(var_1, %root, 1, 0, 1);
  var_3 = scripts\engine\utility::getanim("intro_standoff");
  thread scripts\common\notetrack::start_notetrack_wait(self, "car1_intro_standoff", "intro_standoff", self.animname, var_3);
  thread scripts\sp\anim::animscriptdonotetracksthread(self, "car1_intro_standoff", "intro_standoff");
  wait(var_2);
  self setanimknoball(var_3, %root, 1, 0, 1);
  var_0 waittill("start_car1_extras");
  thread clip_delete("car1_door_clip", "forever");
  wait 3.3;
  self setanimknoball(scripts\engine\utility::getanim("car_explosion"), %root, 1, 0, 1);
}

intro_cars_extra(var_0, var_1) {
  var_2 = scripts\engine\utility::getanim("intro_slamzoom");
  play_scriptable_car_with_notetracks(var_0, var_1, var_2);
  scripts\engine\utility::flag_wait("start_car2");
  self setanimknoball(scripts\engine\utility::getanim("car2_drives_off"), %root, 1, 0, 1);
  scripts\engine\utility::flag_wait("car2_detonation");
  var_3 = getscriptablearray("extra_car_eos", "targetname");
  wait 0.12;
  self setscriptablepartstate("Piccadilly_Death", "picc_death", 1);
  wait 0.2;
  var_3[0] setscriptablepartstate("Piccadilly_Death", "picc_death", 1);
}

player_roe_check() {
  level endon("car2_detonation");
  thread player_fire_check();
  scripts\engine\utility::flag_wait("weapons_free");

  if(!scripts\engine\utility::flag("gun_raised")) {
    scripts\sp\player_death::set_custom_death_quote(88);
    scripts\sp\utility::missionfailedwrapper();
  }
}

player_fire_check() {
  level.player scripts\engine\utility::waittill_any("weapon_fired", "grenade_fire");
  scripts\engine\utility::flag_set("weapons_free");
}

intro_slamzoom() {
  var_0 = scripts\engine\utility::getStruct("intro_slamzoom", "targetname");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  level.player enableinvulnerability();
  level.player playerdisabletriggers();
  level.player cleardamageindicators();
  level.player freezecontrols(1);
  level.player takeallweapons();
  level.player hidelegsandshadow();
  var_2 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_2.angles = var_2.angles + (80, 0, 0);
  level.player playersetgroundreferenceent(var_2);
  level.player playerlinktoabsolute(var_2, "tag_origin");
  wait 0.05;
  level.player playerenabletriggers();
  var_3 = 1.85;
  level.player playSound("slomo_whoosh");
  var_2 moveTo(var_1.origin, var_3, var_3 * 0.9, var_3 * 0.1);
  wait(var_3 * 0.5);
  var_2 rotateTo(var_1.angles, var_3 * 0.5, var_3 * 0.25, var_3 * 0.25);
  wait(var_3 * 0.5);
  level.player unlink();
  level.player playersetgroundreferenceent(undefined);
  level.player disableinvulnerability();
  level.player showlegsandshadow();
  level.player freezecontrols(0);
  var_2 delete();
  level thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::piccadilly_weapons();
}

infil_car1_start() {
  thread spawn_animated_intro_civs();
  scripts\engine\sp\utility::array_spawn_targetname("intro_civs");
  level.street_friendlies = scripts\engine\sp\utility::array_spawn_targetname("sicario_street_friendly");
  level.car1_terry = scripts\engine\sp\utility::spawn_targetname("car1_terry");
  level.car1_terries = scripts\engine\sp\utility::array_spawn_targetname("car1_terries", 1);
  level.car2_terries = scripts\engine\sp\utility::array_spawn_targetname("car2_terry", 1);
  var_0 = scripts\engine\utility::array_combine(level.street_friendlies, level.car2_terries, level.car1_terries, [level.car1_terry]);
  var_1 = scripts\engine\utility::getStruct("intro_slammzoom_node", "targetname");
  scripts\engine\utility::array_thread(var_0, ::setup_intro_idles, var_1);
  level.truck = setup_scriptable_car("sas_intro_decho");
  level.cars_bomb["van"] = setup_scriptable_car("car2_bomb");
  level.cars_bomb["car1"] = setup_scriptable_car("car1_bomb");
  level.cars_bomb["ralfa"] = setup_scriptable_car("car3_bomb");
  level.cars_bomb["cab"] = setup_scriptable_car("car4_bomb");
  level.cars_bomb["van"] thread setup_temp_car_stuff();
  setglobalsoundcontext("dusty", "yes");
  scripts\engine\sp\objectives::objective_add("piccadilly_objective", "current", undefined, &"PICCADILLY/OBJ_APPROACH_VAN", &"PICCADILLY/CURSOR_TARGET");
  scripts\engine\sp\objectives::objective_set_on_entity("piccadilly_objective", "Target", level.cars_bomb["van"]);
  scripts\engine\sp\objectives::objective_set_z_offset("piccadilly_objective", 120);
  scripts\engine\sp\utility::set_start_location("sicario_street", [level.player]);
  thread player_roe_check();
  thread spawn_cross_street_traffic();
  thread show_aftermath_geo();
  thread intro_car(var_1);
  intro_street_player_movement();
  thread player_speed_management_intro("car2_detonation");
}

infil_car1_main() {
  scripts\sp\utility::nvidiaansel_allowduringcinematic(1);
  thread clip_delete("temp_block_ally_clip", "car2_detonation");
  thread clip_delete("temp_standoff_clip", "car2_detonation");
  thread temp_approach_standoff_vo();
  scripts\engine\utility::flag_wait("player_at_standoff");
  setsaveddvar("LTQMSPKRKO", 4);
  scripts\engine\sp\objectives::objective_remove("piccadilly_objective");
  scripts\engine\sp\objectives::objective_add("piccadilly_objective", "current", undefined, &"PICCADILLY/OBJ_MAINTAIN_ROE");
  thread intro_standoff();
  var_0 = getEnt("out_of_bounds_2", "targetname");
  thread scripts\sp\trigger::trigger_outofbounds(var_0);
}

infil_car1_catchup() {
  scripts\engine\utility::flag_set("standoff_complete");
  scripts\engine\utility::flag_set("car2_detonation");
  scripts\engine\utility::flag_set("car2_guys_dead");
  level.player modifybasefov(65, 0.05);

  if(!scripts\sp\starts::is_after_start("gap"))
    thread scripts\sp\maps\piccadilly\piccadilly_ambient.gsc::ambient_combat_popo();

  var_0 = getEnt("out_of_bounds_2", "targetname");
  thread scripts\sp\trigger::trigger_outofbounds(var_0);
  thread intro_lights();
  thread delete_storefront_signs();
}

clip_delete(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");
  var_2 solid();

  if(scripts\engine\utility::flag_exist(var_1))
    scripts\engine\utility::flag_wait(var_1);
  else
    level waittill(var_1);

  var_2 delete();
}

van_anim_jumpto(var_0) {
  var_0 waittill("stop_terry_intro_idle");
  var_0 scripts\common\anim::anim_single_solo(self, "standoff");
}

setup_intro_idles(var_0) {
  var_1 = undefined;

  if(self.animname == "car2_terry_driver") {
    level.car2_terries = scripts\engine\utility::array_remove(level.car2_terries, self);
    self delete();
  } else {
    if(self.animname == "sas2") {
      var_1 = spawnStruct();
      var_1.origin = var_0.origin;
      var_2 = ["dx_vom_mick_infil_car1_street_70", "dx_vom_mick_infil_car1_street_80", "dx_vom_mick_infil_car1_street_90"];
      thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::notetrack_nag(var_2, "player_at_standoff");
      var_1 thread scripts\common\anim::anim_loop_solo_with_nags(self, "intro_slamzoom_v1_sas2_idle", "stop_terry_intro_idle");
    } else
      var_0 thread scripts\common\anim::anim_loop_solo(self, "intro_slamzoom_v1_idle", "stop_terry_intro_idle");

    if(self.animname == "sas1" || self.animname == "sas2" || self.animname == "sas3" || self.animname == "car1_terry1" || self.animname == "car1_terry2" || self.animname == "car1_terry3") {
      scripts\engine\utility::flag_wait("player_at_standoff");
      var_0 notify("stop_terry_intro_idle");

      if(self.animname == "sas2") {
        var_1 notify("stop_terry_intro_idle");
        scripts\engine\utility::flag_set("standoff_ready");
      }

      var_0 scripts\common\anim::anim_single_solo(self, "intro_slamzoom_v1_exit");
      scripts\engine\utility::flag_set("intro_sas_ready");
      thread intro_anims_standoff(var_0);
      return;
    }

    scripts\engine\utility::flag_wait("intro_sas_ready");
    thread intro_anims_standoff(var_0);
  }
}

standoff_terry_vo() {}

temp_approach_standoff_vo() {
  thread post_car_vo();
  level scripts\engine\utility::waittill_either("player_at_standoff", "start_intro_vo");
  level.player scripts\engine\sp\utility::smart_player_dialogue_interrupt("dx_vom_kyle_infil_car1_street_20");
  thread car2_taking_off_vo();
  wait 1.5;
  thread standoff_terry_vo();
}

post_car_vo() {
  wait 1;
  level.street_friendlies[1] scripts\engine\sp\utility::smart_dialogue("dx_vom_mick_infil_car1_street_10");
  wait 0.65;

  if(!scripts\engine\utility::flag("player_at_standoff"))
    standoff_nag_vo();

  level.intro_vo_civs = undefined;
}

standoff_nag_vo() {
  level endon("player_at_standoff");
  level.intro_vo_civs["uk_civilian_male_1"] scripts\engine\sp\utility::smart_dialogue("dx_vom_ucm1_infil_car1_street_30");
  level.intro_vo_civs["uk_civilian_female_1"] scripts\engine\sp\utility::smart_dialogue("dx_vom_ucf1_infil_car1_street_40");
  level.intro_vo_civs["uk_civilian_male_2"] scripts\engine\sp\utility::smart_dialogue("dx_vom_ucm2_infil_car1_street_50");
  level.street_friendlies[0] scripts\engine\sp\utility::smart_dialogue("dx_vom_s26_infil_car1_street_60");
}

car2_taking_off_vo() {
  scripts\engine\utility::flag_wait("start_car2");
  wait 3.65;
  level.player_dialogue_emitter delete();
  wait 1.05;
  level thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::say("dx_vom_gfc_infil_car1_street_240");
  wait 2.1;
  level.street_friendlies[0] scripts\sp\maps\piccadilly\piccadilly_util.gsc::say("dx_vom_s26_infil_car1_street_250");
  wait 0.45;

  if(scripts\engine\utility::flag("player_golden_path_knockdown"))
    level.player scripts\engine\sp\utility::smart_dialogue("dx_vom_kyle_infil_car1_street_260");
  else {
    level.street_friendlies[0] scripts\sp\maps\piccadilly\piccadilly_util.gsc::say("dx_vom_s26_infil_car1_street_270");
    level.street_friendlies[0] scripts\sp\maps\piccadilly\piccadilly_util.gsc::say("dx_vom_s26_infil_car1_street_280");
  }

  scripts\common\anim::addnotetrack_flag("sas1", "standoff_vo_complete", "standoff_vo_complete", "car_explosion_enter");
  scripts\common\anim::addnotetrack_flag("sas1", "standoff_vo_complete", "standoff_vo_complete", "car_explosion_exit");
}

intro_standoff() {
  scripts\engine\utility::flag_wait_or_timeout("weapons_free", 3);
  scripts\engine\utility::flag_wait("force_bomb_start");
  thread scripts\engine\sp\utility::autosave_by_name("standoff_complete");
  thread carbomb_main();
  thread carbomb_player_react();
  thread scripts\sp\maps\piccadilly\piccadilly_ambient.gsc::ambient_combat_popo();
  thread scripts\sp\maps\piccadilly\piccadilly_combat.gsc::police_vignette();
  wait 1.7;

  if(!scripts\engine\utility::flag("weapons_free"))
    scripts\engine\utility::flag_set("weapons_free");

  var_0 = scripts\engine\sp\utility::get_closest_to_player_view(level.car2_terries, level.player, 1);
  var_0.ignoreme = 1;
  var_0.ignoreall = 0;
  var_0 scripts\engine\utility::delaythread(5, scripts\engine\sp\utility::set_ignoreme, 0);

  foreach(var_2 in level.street_friendlies) {
    var_2.ignoreall = 0;
    var_2.ignoreme = 0;
    var_2.dontevershoot = 0;
  }

  wait 2.6;
  scripts\engine\utility::flag_set("standoff_complete");
}

carbomb_shop_windows() {
  wait 0.25;
  var_0 = 1;

  for(var_1 = anglesToForward((0, 360, 0)); var_0 < 7; var_0++) {
    var_2 = getglassarray("intro_glass" + var_0);
    var_2 thread glass_management(var_1);
    wait 0.25;
  }
}

glass_management(var_0) {
  foreach(var_2 in self)
  destroyglass(var_2, var_0);

  wait 0.3;

  foreach(var_2 in self)
  deleteglass(var_2);
}

carbomb_main() {
  if(level.start_point == "post_bomb") {
    level.player modifybasefov(65, 0.15);
    scripts\engine\utility::exploder("aftermath");
    thread aftermath_ambience();
  } else {
    thread car2_detonates();
    thread car_windows_break();
  }

  thread post_explosion_visionset();
  var_0 = scripts\engine\utility::getStructArray("civ_stunned", "targetname");
  thread scripts\sp\maps\piccadilly\piccadilly_combat.gsc::fake_civ_stream("aftermath_fake_civs", "combat_start");
  level.street_friendlies = scripts\engine\utility::array_removedead(level.street_friendlies);
  level.street_friendlies = scripts\engine\utility::array_removeundefined(level.street_friendlies);
}

post_explosion_visionset() {
  waitframe();
  visionsetalternate(1, 0.5);
}

car2_detonates() {
  scripts\engine\utility::flag_set("car2_detonation");
  level.player scripts\engine\utility::delaythread(0.2, scripts\engine\sp\utility::play_sound_on_entity, "dx_vom_plr_explosion_efforts");
  wait 0.25;
  setglobalsoundcontext("dusty", "");
  level.player modifybasefov(65, 0.15);
  wait 1.2;
  thread aftermath_ambience();
}

aftermath_ambience() {
  level endon("sicario_street_exit");
  level notify("vo_post_expl_walla");
  var_0 = scripts\engine\utility::getStruct("carbomb_det", "targetname");
  thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::crowd_screams(var_0.origin);
  scripts\engine\utility::delaythread(5, scripts\engine\utility::play_sound_in_space, "pdilly_first_explosion_car_accident", (-1371, -980, 155));
  scripts\engine\utility::delaythread(9, scripts\sp\maps\piccadilly\piccadilly_util.gsc::crowd_screams, var_0.origin);
}

car_windows_break() {
  wait 0.25;
  var_0 = scripts\engine\utility::getStruct("carbomb_det", "targetname");
  var_1 = scripts\engine\utility::array_combine(level.intro_windows["front"], level.intro_windows["back"], level.intro_windows["special1"]);
  var_1 = sortbydistance(var_1, var_0.origin);
  var_2 = [0, 1, 0, 0];
  var_3 = 0;

  foreach(var_5 in var_1) {
    var_5 setscriptablepartstate("Window_Blast", "destroyed", 1);

    if(scripts\engine\utility::array_contains(level.intro_windows["front"], var_5))
      var_5 setscriptablepartstate("Damage_Blast", "front", 1);
    else if(scripts\engine\utility::array_contains(level.intro_windows["special1"], var_5))
      var_5 setscriptablepartstate("Damage_Blast", "special1", 1);
    else
      var_5 setscriptablepartstate("Damage_Blast", "back", 1);

    if(!scripts\engine\utility::is_equal(var_2[var_3], 1))
      wait 0.5;

    var_3++;
  }
}

carbomb_player_react() {
  level.scr_model["player_rig"] = "viewhands_fullbody_kyle_sas_urban";
  level.knockdownanime = ["car_explosion", "crouch"];
  level.touching = setup_player_animnode();
  var_0 = spawn("script_origin", level.player.origin);
  var_0.angles = level.player.angles;
  scripts\engine\sp\utility::add_cleanup_ent(var_0, "script_origins");

  if(!level.player isonground() && level.knockdownanime[0] == "car_explosion_short") {
    var_1 = scripts\common\utility::groundpos(var_0.origin);
    var_0 moveTo(var_1, 0.3, 0.2);
  }

  var_2 = var_0 scripts\sp\player_rig::link_player_to_rig(level.knockdownanime[0], "stand", 1, 0.2, 1);
  var_0 thread scripts\common\anim::anim_single_solo(var_2, level.knockdownanime[0]);
  var_2 show();
  var_3 = var_2 thread anim_weapon_for_player();
  var_2 thread player_damage_based_on_dist();
  var_2 linkTo(var_0);

  if(level.knockdownanime[0] != "car_explosion_short")
    var_0 rotateTo((0, 0, 0), 0.2);

  level.player thread carbomb_player_extras();

  if(level.touching) {
    scripts\engine\utility::flag_set("player_golden_path_knockdown");
    wait 1;

    if(isDefined(level.intro_origin))
      var_0.origin = level.intro_origin;
    else if(isDefined(level.intro_animnode))
      var_0.origin = level.intro_animnode.origin;
  }

  var_2 waittillmatch("single anim", "end");
  level.player showviewmodel();
  var_3 delete();
  scripts\sp\player_rig::unlink_player_from_rig(0, level.knockdownanime[1], 1);
  scripts\engine\utility::flag_set("player_is_up");
  var_4 = scripts\engine\utility::getStruct("circle_objective_struct", "targetname");
  scripts\engine\sp\objectives::objective_remove_all_locations("piccadilly_objective");
  scripts\engine\sp\objectives::objective_update("piccadilly_objective", "current", undefined, &"PICCADILLY/OBJ_INVESTIGATE");
  scripts\engine\sp\objectives::objective_add_location_position("piccadilly_objective", "smoke_reveal", var_4.origin);
  thread player_speed_post_bomb();
  level.scr_model["player_rig"] = "viewhands_kyle_sas_urban";
}

anim_weapon_for_player() {
  var_0 = spawn("script_model", level.player.origin);
  var_0 scripts\common\utility::make_weapon_model("iw8_pi_papa320", ["rec_papa320_r", "mag_papa320_r", "slide_papa320_r"]);
  var_0 linkTo(self, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  return var_0;
}

setup_player_animnode() {
  var_0 = getEnt("standoff_golden_spot", "targetname");
  var_1 = getEntArray("golden_spots", "targetname");
  var_2 = getEnt("golden_spot_car", "targetname");

  if(level.player istouching(var_0)) {
    var_3 = scripts\engine\utility::getStruct("golden_spot_node_plr", "targetname");
    var_4 = scripts\engine\utility::getStruct(var_3.target, "targetname");
    level.intro_origin = pointonsegmentnearesttopoint(var_3.origin, var_4.origin, level.player.origin);
    return 1;
  } else if(level.player istouching(var_2)) {
    var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");
    var_4 = scripts\engine\utility::getStruct(var_3.target, "targetname");
    level.intro_origin = pointonsegmentnearesttopoint(var_3.origin, var_4.origin, level.player.origin);
  } else {
    foreach(var_6 in var_1) {
      if(level.player istouching(var_6)) {
        var_7 = scripts\engine\utility::getStructArray(var_6.target, "targetname");
        level.intro_animnode = scripts\engine\utility::getclosest(level.player.origin, var_7);

        if(isDefined(var_6.script_noteworthy) && var_6.script_noteworthy == "left")
          level.knockdownanime = ["car_explosion_left", "crouch"];

        return 1;
      }
    }

    var_9 = scripts\engine\utility::getStructArray("golden_spot_node", "script_noteworthy");
    level.intro_animnode = scripts\engine\utility::getclosest(level.player.origin, var_9);
  }

  level.knockdownanime = ["car_explosion_short", "stand"];
  return 0;
}

player_damage_based_on_dist() {
  var_0 = scripts\engine\utility::getStruct("carbomb_det", "targetname");
  var_1 = distance2dsquared(level.player.origin, var_0.origin);
  var_2 = squared(600);
  var_3 = squared(750);

  if(var_1 <= var_2) {
    wait 0.3;
    level.player kill();
    wait 0.4;
    scripts\engine\sp\utility::anim_stopanimScripted();
  } else if(var_1 <= var_3) {
    wait 0.3;
    level.player scripts\sp\utility::do_damage(80, var_0.origin);
  }
}

carbomb_player_extras() {
  var_0 = 3.5;

  if(level.knockdownanime[0] == "car_explosion")
    wait 0.7;
  else if(level.knockdownanime[0] == "car_explosion_short") {
    wait 0.4;
    var_0 = 2;
  } else if(level.knockdownanime[0] == "car_explosion_left") {
    wait 0.5;
    var_0 = 3;
  }

  self playSound("plr_breath_pain_init");
  scripts\engine\utility::delaycall(2.3, ::playsound, "breathing_better");
  var_1 = self gettagorigin("j_head");
  earthquake(0.5, 0.7, var_1, 200);
  screenshake(var_1, 2, 0, 0, 0.5);
  playrumbleonposition("grenade_rumble", var_1);
  wait 0.5;
  self shellshock("explosion", var_0);
  scripts\engine\utility::delaycall(var_0 - 1, ::fadeoutshellshock);
}

player_speed_post_bomb() {
  scripts\sp\player::player_movement_state("cqb");
  scripts\engine\utility::flag_wait("combat_approach");
  scripts\sp\player::player_movement_state("default");
}

post_bomb_start() {
  thread spawn_animated_intro_civs();
  thread vo_post_bomb_walla();
  level.street_friendlies = scripts\engine\sp\utility::array_spawn_targetname("sicario_street_friendly");

  foreach(var_1 in level.street_friendlies) {
    if(var_1.animname == "sas2") {
      level.street_friendlies = scripts\engine\utility::array_remove(level.street_friendlies, var_1);
      var_1 scripts\common\ai::stop_magic_bullet_shield();
      var_1 delete();
      continue;
    }

    var_2 = scripts\engine\utility::getStruct("post_bomb_" + var_1.animname, "targetname");
    var_1 forceteleport(var_2.origin, var_2.angles);
    var_1 thread start_ally_stayahead_movement(var_2);
  }

  var_4 = scripts\engine\utility::getStruct("intro_slammzoom_node", "targetname");
  level.truck = setup_scriptable_car("sas_intro_decho");
  level.cars_bomb["van"] = setup_scriptable_car("car2_bomb");
  level.cars_bomb["car1"] = setup_scriptable_car("car1_bomb");
  level.cars_bomb["ralfa"] = setup_scriptable_car("car3_bomb");
  level.cars_bomb["cab"] = setup_scriptable_car("car4_bomb");
  thread intro_car(var_4);
  thread carbomb_main();
  level.cars_bomb["van"] setup_temp_car_stuff();
  level.cars_bomb["van"].lightback setlightintensity(0);
  level.cars_bomb["van"].lightfront setlightintensity(0);
  scripts\engine\utility::array_delete(level.cars_bomb["van"].bombs);
  level.cars_bomb["van"] scripts\engine\utility::delaycall(1, ::hide);
  thread scripts\sp\maps\piccadilly\piccadilly_combat.gsc::police_vignette();
  var_5 = scripts\engine\utility::getStruct("circle_objective_struct", "targetname");
  scripts\engine\sp\objectives::objective_add("piccadilly_objective", "current", undefined, &"PICCADILLY/OBJ_INVESTIGATE");
  scripts\engine\sp\objectives::objective_add_location_position("piccadilly_objective", "standoff", var_5.origin);
  scripts\engine\sp\utility::set_start_location("carbomb", [level.player]);
}

post_bomb_main() {
  level thread scripts\sp\maps\piccadilly\piccadilly_combat.gsc::car_jumper();
  thread post_bomb_vo();
  thread post_bomb_ambient();
  scripts\engine\utility::flag_wait("sicario_street_exit");
  thread street_cleanup_ents();
  scripts\engine\utility::flag_wait("combat_approach");
  thread street_cleanup_approach();
  scripts\engine\utility::flag_wait("combat_start");
  thread street_cleanup_combat();
}

post_bomb_catchup() {
  scripts\engine\utility::flag_set("standoff_complete");
  scripts\engine\utility::flag_set("combat_approach");
  thread scripts\sp\maps\piccadilly\piccadilly_ambient.gsc::main();
  thread post_explosion_visionset();
}

post_bomb_ambient() {
  scripts\engine\utility::flag_wait_any("combat_approach", "car2_guys_dead");

  if(scripts\engine\utility::flag("car2_guys_dead"))
    wait 3.5;

  thread scripts\sp\maps\piccadilly\piccadilly_ambient.gsc::main();
  scripts\engine\sp\utility::battlechatter_on("axis");
}

start_ally_stayahead_movement(var_0) {
  if(!scripts\engine\utility::flag("combat_start")) {
    var_1 = scripts\engine\utility::getStruct("post_bomb_poi_" + self.animname, "targetname");
    scripts\common\ai::poi_enable(1, var_1);

    if(self.animname == "sas1") {
      level.infil_leader = self;
      scripts\sp\utility::set_stayahead_values(2, 140, 150, 0.1);
      scripts\sp\utility::set_stayahead_values(3, 120, 25, 0.2);
      scripts\sp\utility::set_stayahead_values(4, 80, -100, 0.1);
      scripts\sp\utility::set_stayahead_wait_values(-200, 2, 1);
      var_2 = scripts\engine\utility::getStructArray("street_wait_node_" + self.animname, "targetname");
      scripts\sp\utility::set_stayahead_wait_nodes(var_2);
      scripts\sp\utility::enable_stayahead(level.player);
    } else {
      var_2 = scripts\engine\utility::getStructArray("street_wait_node_" + self.animname, "targetname");
      scripts\sp\utility::set_stayahead_wait_nodes(var_2, 1);
      level wait_to_create_team(self);
    }

    thread scripts\sp\spawner::go_to_node(var_0);
    self.ignoreall = 1;
    scripts\engine\utility::flag_wait_or_timeout("combat_start", 7);
    scripts\sp\utility::disable_stayahead(165, 1);
    scripts\common\ai::poi_enable(0);

    if(!scripts\engine\utility::flag("combat_start"))
      scripts\engine\utility::flag_wait("combat_start");
  }

  scripts\engine\sp\utility::set_force_color("y");
  scripts\engine\sp\utility::enable_ai_color();
  scripts\common\utility::disable_cqbwalk();
  scripts\engine\sp\utility::activate_trigger_with_targetname("friendly_combat_color_start");
}

wait_to_create_team(var_0) {
  while(!isDefined(level.infil_leader))
    waitframe();

  level.infil_leader scripts\sp\utility::stayahead_add_to_team(var_0, 180, 125, 50);
}

street_cleanup_ents() {
  if(isDefined(level.cleanup_ents) && isDefined(level.cleanup_ents["background_cars"]))
    scripts\engine\sp\utility::cleanup_ents("background_cars");
}

street_cleanup_approach() {
  if(isDefined(level.truck))
    level.truck hide();

  wait 0.1;

  if(isDefined(level.cleanup_ents) && isDefined(level.cleanup_ents["infil_ents"]))
    scripts\engine\sp\utility::cleanup_ents("infil_ents");

  wait 0.1;

  if(isDefined(level.cleanup_ents) && isDefined(level.cleanup_ents["script_origins"]))
    scripts\engine\sp\utility::cleanup_ents("script_origins");
}

street_cleanup_combat() {
  var_0 = getEntArray("sicario_street_ents", "script_noteworthy");

  if(istrue(var_0.size))
    scripts\engine\utility::array_delete(var_0);

  wait 0.2;

  if(isDefined(level.scriptable_cleanup)) {
    scripts\engine\utility::array_call(level.scriptable_cleanup, ::setscriptablepartstate, "lights_controller", "off");
    waitframe();
    scripts\engine\utility::array_call(level.scriptable_cleanup, ::hide);
  }

  scripts\engine\utility::flag_wait_any("middle_road", "going_left_side", "going_right_side");

  if(isDefined(level.cleanup_ents) && isDefined(level.cleanup_ents["post_bomb_ents"]))
    scripts\engine\sp\utility::cleanup_ents("post_bomb_ents");
}

combat_ambience() {
  level endon("combat_start");
  var_0 = getspawnerarray("aftermath_fake_civs");
  var_1 = sortbydistance(var_0, level.player.origin)[0];
  thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::crowd_screams(var_1.origin);
  var_2 = scripts\engine\utility::getStruct("carbomb_det", "targetname");
  scripts\engine\utility::delaythread(1.6, scripts\sp\maps\piccadilly\piccadilly_util.gsc::crowd_screams, var_2.origin);
  var_3 = gettime();

  for(;;) {
    var_4 = randomintrange(10, 20);

    for(var_5 = 0; var_5 < var_4; var_5++) {
      magicbullet("iw8_ar_akilo47", var_1.origin + (0, 0, 70), var_1.origin);
      wait(randomfloatrange(0.1, 0.2));
    }

    if(gettime() - var_3 > 7000) {
      thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::crowd_screams(var_1.origin);
      var_3 = gettime();
    }

    wait(randomfloatrange(2, 4));
  }
}

post_bomb_background_vo() {
  level scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_gfc_infil_car1_street_320");
  level.player scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_kyle_infil_car1_street_330");
  level.player scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_kyle_infil_car1_street_360");
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_uk51_post_bomb_street_10", 100);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_uk52_post_bomb_street_20", 100);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_gfc_post_bomb_street_30", 200);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_uk51_post_bomb_street_90", 300);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_gfc_post_bomb_street_100", 400);

  if(scripts\engine\utility::flag("combat_start")) {
    return;
  }
  level endon("combat_start");

  if(!isDefined(level.sas))
    level.sas = level.street_friendlies;

  level.sas[0] thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_s26_infil_car1_street_430");
  level.player scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_kyle_infil_car1_street_440");
  var_0 = ["dx_vom_s26_infil_car1_street_400", "dx_vom_s26_infil_car1_street_410", "dx_vom_s26_infil_car1_street_420"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0);

  for(;;) {
    level.sas[0] thread scripts\asm\gesture::ai_request_gesture("military_point", level.carjumper);
    level.sas[0] scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter(var_1 scripts\engine\sp\utility::deck_draw());
    wait(randomfloatrange(8, 12));
  }
}

post_bomb_vo() {
  if(level.start_point != "post_bomb")
    scripts\engine\utility::flag_wait("standoff_vo_complete");

  thread post_bomb_background_vo();
  scripts\engine\utility::flag_wait("combat_approach");

  if(!isDefined(level.sas))
    level.sas = level.street_friendlies;

  wait 0.3;
  level.sas[0] scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_s151_post_bomb_street_60");
  wait 0.2;
  level.sas[1] scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter("dx_vom_s152_post_bomb_street_70");
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_gfc_post_bomb_street_40", 400);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_uk51_post_bomb_street_50", 400);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_uk52_post_bomb_street_80", 400);
  level.player scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_kyle_combat_ext_20", 400);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::add_to_chatter("dx_vom_gfc_combat_ext_30", 400);
}

standoff_start() {
  thread spawn_animated_trailer_civs();
  scripts\engine\sp\utility::array_spawn_targetname("intro_civs");
  level.street_friendlies = scripts\engine\sp\utility::array_spawn_targetname("sicario_street_friendly");
  level.car2_terries = scripts\engine\sp\utility::array_spawn_targetname("car2_terry", 1);
  var_0 = scripts\engine\utility::array_combine(level.street_friendlies, level.car2_terries);
  var_1 = scripts\engine\utility::getStruct("intro_slammzoom_node", "targetname");
  scripts\engine\utility::array_thread(var_0, ::standoff_trailer_setup, var_1);
  level.truck = setup_scriptable_car("sas_intro_decho");
  level.cars_bomb["van"] = setup_scriptable_car("car2_bomb");
  level.cars_bomb["car1"] = setup_scriptable_car("car1_bomb");
  level.cars_bomb["ralfa"] = setup_scriptable_car("car3_bomb");
  level.cars_bomb["cab"] = setup_scriptable_car("car4_bomb");
  level.cars_bomb["van"] thread setup_temp_car_stuff();
  setglobalsoundcontext("dusty", "yes");
  scripts\engine\sp\objectives::objective_add("intro", "current", undefined, &"PICCADILLY/OBJ_APPROACH_VAN");
  scripts\engine\sp\objectives::objective_set_on_entity("intro", "Target", level.cars_bomb["van"]);
  scripts\engine\sp\objectives::objective_set_z_offset("intro", 120);
  scripts\engine\sp\utility::set_start_location("sicario_street", [level.player]);
  thread intro_car(var_1);
}

standoff_main() {
  setomnvar("ui_hide_hud", 1);
  level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
  setomnvar("ui_hide_weapon_info", 1);
  level.player modifybasefov(50, 0.1);
  level.player waittill("melee_pressed");
  level.cars_bomb["van"] trailer_car_drive_off();
  level notify("start_trailer_scene");
  thread post_explosion_visionset();
  wait 1;
  scripts\engine\utility::exploder("aftermath");
  level waittill("forever");
}

standoff_trailer_setup(var_0) {
  if(self.animname == "car2_terry_driver") {
    self delete();
    return;
  }

  var_0 scripts\common\anim::anim_first_frame_solo(self, "car_explosion");
  level waittill("start_trailer_scene");
  var_0 scripts\common\anim::anim_single_solo(self, "car_explosion");
  var_0 scripts\common\anim::anim_last_frame_solo(self, "car_explosion");
}

spawn_animated_trailer_civs() {
  var_0 = scripts\engine\utility::getStruct("intro_slammzoom_node", "targetname");

  for(var_1 = 1; var_1 < 36; var_1++) {
    if(var_1 != 30)
      thread trailer_civ_setup(var_1, var_0);
  }

  var_0 = scripts\engine\utility::getStruct("intro_civ_animnode", "targetname");

  for(var_1 = 36; var_1 < 54; var_1++)
    thread trailer_civ_setup(var_1, var_0);

  level.intro_civs["post"] thread intro_civ_post_anims();
}

trailer_civ_setup(var_0, var_1) {
  var_2 = get_random_spawner(var_0);
  var_3 = var_2 bodyonly_guy_setup(var_0);

  if(!isDefined(level.scr_anim[var_3.animname]["intro_run"])) {
    var_3 delete();
    return;
  }

  var_1 scripts\common\anim::anim_first_frame_solo(var_3, "intro_run");
  level waittill("start_trailer_scene");
  var_1 scripts\common\anim::anim_single_solo(var_3, "intro_run");
  var_1 scripts\common\anim::anim_last_frame_solo(var_3, "intro_run");
}

trailer_car_drive_off() {
  var_0 = scripts\engine\utility::getanim("car2_drives_off");
  var_1 = getanimlength(var_0);
  thread car2_delete_extras(var_0);
  thread scripts\common\notetrack::start_notetrack_wait(self, "car2_drives", "car2_drives_off", self.animname, var_0);
  thread scripts\sp\anim::animscriptdonotetracksthread(self, "car2_drives", "car2_drives_off");
  self setflaggedanimknoball("car2_drives", var_0, %root, 1, 0, 1);
  wait(var_1 / 1.1);
}

skip_ahead_scriptable(var_0, var_1) {
  if(scripts\engine\utility::is_equal(self.animname, "intro_car3") || scripts\engine\utility::is_equal(self.animname, "intro_car4")) {
    return;
  }
  if(scripts\engine\utility::is_equal(self.animname, "intro_car5")) {
    self clearanim(%root, 0);
    var_2 = scripts\engine\utility::getanim("intro_slamzoom");
    var_3 = getstartorigin(var_0.origin, var_0.angles, var_2);
    var_4 = getstartangles(var_0.origin, var_0.angles, var_2);
    self.origin = var_3;
    self.angles = var_4;
    self setflaggedanimknoballrestart("single anim", var_2, %root, 1, 0, 1100);
    waitframe();
    thread hide_intro_car();
    return;
  } else {
    self clearanim(%root, 0);
    var_2 = scripts\engine\utility::getanim("intro_slamzoom");
    var_3 = getstartorigin(var_0.origin, var_0.angles, var_2);
    var_4 = getstartangles(var_0.origin, var_0.angles, var_2);
    self.origin = var_3;
    self.angles = var_4;
    level waittill("all_ents_are_ready");
    self setflaggedanimknoballrestart("single anim", var_2, %root, 1, 0, 1050);
    waitframe();
    self setanimrate(var_2, 1);
  }

  self stopsounds();
}

vo_intro_walla() {
  level waittill("vo_standoff_walla");
  var_0 = level.player.origin;
  var_1 = spawn("script_origin", (-2626, -3381, 60));
  var_2 = spawn("script_origin", (-2694, -3728, 60));
  var_1 playLoopSound("scn_piccadilly_standoff_walla_left_lp");
  var_2 playLoopSound("scn_piccadilly_standoff_walla_right_lp");
  level waittill("vo_pre_expl_walla");
  thread scripts\engine\utility::play_sound_in_space("scn_piccadilly_pre_expl_walla_left", (-2626, -3381, 60));
  var_1 scripts\engine\sp\utility::sound_fade_and_delete(1.5, 1);
  wait 0.1;
  thread scripts\engine\utility::play_sound_in_space("scn_piccadilly_pre_expl_walla_right", (-2694, -3728, 60));
  var_2 scripts\engine\sp\utility::sound_fade_and_delete(1.5, 1);
  level waittill("vo_expl_walla");
  wait 0.4;
  thread scripts\engine\utility::play_sound_in_space("scn_piccadilly_expl_walla_left", (-2626, -3381, 60));
  thread scripts\engine\utility::play_sound_in_space("scn_piccadilly_expl_walla_right", (-2694, -3728, 60));
  level waittill("vo_post_expl_walla");
  wait 2;
  thread vo_post_bomb_walla();
}

vo_post_bomb_walla() {
  thread scripts\engine\utility::play_loopsound_in_space("scn_piccadilly_streets_injured_grp_04_lp", (-2557, -3388, 60));
  thread scripts\engine\utility::play_loopsound_in_space("scn_piccadilly_streets_injured_grp_02_lp", (-2394, -3406, 60));
  thread scripts\engine\utility::play_loopsound_in_space("scn_piccadilly_streets_injured_grp_01_lp", (-2088, -3394, 60));
  thread scripts\engine\utility::play_loopsound_in_space("scn_piccadilly_streets_injured_grp_03_lp", (-1904, -3819, 60));
  thread scripts\engine\utility::play_loopsound_in_space("scn_piccadilly_streets_injured_grp_04_lp", (-2124, -3793, 60));
}