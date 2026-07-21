/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\tunnels\zd30tunnels_infil.gsc
*************************************************/

postspawn_hero() {
  switch (self.animname) {
    case "price":
      level.price = self;
      var_0 = scripts\sp\utility::make_weapon("iw8_ar_mcharlie", ["reflex_west01", "silencer04"]);
      scripts\anim\shared.gsc::forceuseweapon(var_0, "primary");
      ignore_enabled();
      dynamic_run_setup();
      self.nvg_on = 0;
      self.nofacialfiller = 1;
      break;
  }

  scripts\common\ai::magic_bullet_shield();
  scripts\engine\sp\utility::enable_dontevershoot();
  self.goalradius = 0;
  level.cleanup[level.cleanup.size] = self;
}

postspawn_allies() {
  self.comloadout = undefined;

  switch (self.animname) {
    case "bravo1":
      level.bravo1 = self;
      ignore_enabled();
      self.comloadout = "ar";
      break;
    case "bravo2":
      level.bravo2 = self;
      ignore_enabled();
      self.comloadout = "shotgun";
      break;
    case "overwatch":
      level.overwatch = self;
      ignore_enabled();
      self.comloadout = "dmr";
      break;
    case "bravo4":
      level.bravo4 = self;
      ignore_enabled();
      self.comloadout = "ar";
      break;
    case "bravo5":
      level.bravo5 = self;
      ignore_enabled();
      self.comloadout = "smg";
      break;
    case "alpha2":
      level.alpha2 = self;
      ignore_enabled();
      self.comloadout = "ar";
      break;
    case "alpha3":
      level.alpha3 = self;
      ignore_enabled();
      self.comloadout = "smg";
      break;
    case "alpha4":
      level.alpha4 = self;
      ignore_enabled();
      self.comloadout = "ar";
      break;
    case "alpha5":
      level.alpha5 = self;
      self.comloadout = "smg";
      break;
    case "alpha6":
      level.alpha6 = self;
      ignore_enabled();
      self.comloadout = "shotgun";
      break;
  }

  switch (self.comloadout) {
    case "ar":
      var_0 = scripts\engine\utility::random(["reflex_west01", "holo_west01"]);
      var_1 = scripts\sp\utility::make_weapon("iw8_ar_mcharlie", [var_0, "silencer04"]);
      scripts\anim\shared.gsc::forceuseweapon(var_1, "primary");
      break;
    case "smg":
      var_0 = scripts\engine\utility::random(["reflex_west01", "holo_west01"]);
      var_1 = scripts\sp\utility::make_weapon("iw8_sm_mpapa5", [var_0, "silencersmg_west01"]);
      scripts\anim\shared.gsc::forceuseweapon(var_1, "primary");
      break;
    case "shotgun":
      var_1 = scripts\sp\utility::make_weapon("iw8_sh_romeo870");
      scripts\anim\shared.gsc::forceuseweapon(var_1, "primary");
      break;
    case "dmr":
      var_1 = scripts\sp\utility::make_weapon("iw8_sn_mike14", ["acog_west01", "silencerdmr04"]);
      scripts\anim\shared.gsc::forceuseweapon(var_1, "primary");
      break;
  }

  scripts\common\ai::magic_bullet_shield();
  scripts\engine\sp\utility::enable_dontevershoot();
  dynamic_run_setup();
  self.nvg_on = 0;
  self.goalradius = 0;
  level.cleanup[level.cleanup.size] = self;
}

postspawn_charlie() {
  switch (self.animname) {
    case "alex":
      level.alex = self;
      break;
    case "farah":
      level.prefarah = self;
      break;
    case "charlie3":
      level.charlie3 = self;
      break;
  }

  scripts\common\ai::magic_bullet_shield();
  scripts\engine\sp\utility::enable_dontevershoot();
  level.charlie[level.charlie.size] = self;
}

objective_control(var_0) {
  switch (var_0) {
    case "intro":
      scripts\engine\sp\objectives::objective_add("compound_objective", "current", undefined, &"ZD30/OBJ_LOCATE_WOLF");
      break;
    case "clear_building":
      var_1 = scripts\engine\utility::getStruct("clear_building", "targetname");

      if(scripts\engine\sp\objectives::objective_exists("compound_objective")) {
        scripts\engine\sp\objectives::objective_update("compound_objective", "current", undefined, &"ZD30/OBJ_CLEAR_BUILDING", &"ZD30/CLEAR");
        scripts\engine\sp\objectives::objective_add_location_position("compound_objective", "b1", var_1.origin);
      } else {
        scripts\engine\sp\objectives::objective_add("compound_objective", "current", undefined, &"ZD30/OBJ_CLEAR_BUILDING", &"ZD30/CLEAR");
        scripts\engine\sp\objectives::objective_add_location_position("compound_objective", "b1", var_1.origin);
      }

      break;
    case "breach_scene":
      var_1 = scripts\engine\utility::getStruct("breach_gate", "targetname");

      if(scripts\engine\sp\objectives::objective_exists("compound_objective")) {
        scripts\engine\sp\objectives::objective_remove_location("compound_objective", "b1");
        scripts\engine\sp\objectives::objective_update("compound_objective", "current", undefined, &"ZD30/OBJ_BREACH_GATE", &"ZD30/BREACH");
        scripts\engine\sp\objectives::objective_add_location_position("compound_objective", "breach", var_1.origin);
      } else {
        scripts\engine\sp\objectives::objective_add("compound_objective", "current", undefined, &"ZD30/OBJ_BREACH_GATE", &"ZD30/BREACH");
        scripts\engine\sp\objectives::objective_add_location_position("compound_objective", "breach", var_1.origin);
      }

      break;
    case "reach_main_house":
      var_1 = scripts\engine\utility::getStruct("reach_main_house", "targetname");

      if(scripts\engine\sp\objectives::objective_exists("compound_objective")) {
        scripts\engine\sp\objectives::objective_remove_location("compound_objective", "breach");
        scripts\engine\sp\objectives::objective_update("compound_objective", "current", undefined, &"ZD30/OBJ_REACH_MAIN_HOUSE", &"ZD30/FOLLOW");
        scripts\engine\sp\objectives::objective_set_on_entity("compound_objective", &"ZD30/FOLLOW", level.bravo4);
        scripts\engine\sp\objectives::objective_set_z_offset("compound_objective", 72);
      } else {
        scripts\engine\sp\objectives::objective_add("compound_objective", "current", undefined, &"ZD30/OBJ_REACH_MAIN_HOUSE", &"ZD30/FOLLOW");
        scripts\engine\sp\objectives::objective_set_on_entity("compound_objective", &"ZD30/FOLLOW", level.bravo4);
        scripts\engine\sp\objectives::objective_set_z_offset("compound_objective", 72);
      }

      break;
    case "locate_wolf":
      if(scripts\engine\sp\objectives::objective_exists("compound_objective"))
        scripts\engine\sp\objectives::objective_remove("compound_objective");

      scripts\engine\sp\objectives::objective_add("compound_objective", "current", undefined, &"ZD30/OBJ_LOCATE_WOLF");
      break;
    case "power":
      thread power_objective();
      break;
    case "2f_stairs":
      var_1 = scripts\engine\utility::getStruct("2f_stairs", "targetname");
      var_2 = var_1.origin + (0, 0, 25);

      if(scripts\engine\sp\objectives::objective_exists("compound_power"))
        scripts\engine\sp\objectives::objective_remove("compound_power");

      if(scripts\engine\sp\objectives::objective_exists("compound_objective")) {
        scripts\engine\sp\objectives::objective_update("compound_objective", "current", undefined, &"ZD30/OBJ_REACH_2F", &"ZD30/FOLLOW");
        scripts\engine\sp\objectives::objective_set_on_entity("compound_objective", &"ZD30/FOLLOW", level.price);
        scripts\engine\sp\objectives::objective_set_z_offset("compound_objective", 75);
      } else {
        scripts\engine\sp\objectives::objective_add("compound_objective", "current", undefined, &"ZD30/OBJ_REACH_2F", &"ZD30/FOLLOW");
        scripts\engine\sp\objectives::objective_set_on_entity("compound_objective", &"ZD30/FOLLOW", level.price);
        scripts\engine\sp\objectives::objective_set_z_offset("compound_objective", 75);
      }

      break;
    case "locate_wolf2":
      if(scripts\engine\sp\objectives::objective_exists("compound_objective"))
        scripts\engine\sp\objectives::objective_remove("compound_objective");

      scripts\engine\sp\objectives::objective_add("compound_objective", "current", undefined, &"ZD30/OBJ_LOCATE_WOLF");
      break;
    case "3f_stairs":
      if(scripts\engine\sp\objectives::objective_exists("compound_objective")) {
        scripts\engine\sp\objectives::objective_update("compound_objective", "current", undefined, &"ZD30/OBJ_REACH_3f", &"ZD30/FOLLOW");
        scripts\engine\sp\objectives::objective_set_on_entity("compound_objective", &"ZD30/FOLLOW", level.bravo1);
        scripts\engine\sp\objectives::objective_set_z_offset("compound_objective", 72);
      } else {
        scripts\engine\sp\objectives::objective_add("compound_objective", "current", undefined, &"ZD30/OBJ_REACH_3f", &"ZD30/FOLLOW");
        scripts\engine\sp\objectives::objective_set_on_entity("compound_objective", &"ZD30/FOLLOW", level.bravo1);
        scripts\engine\sp\objectives::objective_set_z_offset("compound_objective", 72);
      }

      break;
    case "locate_wolf3":
      if(scripts\engine\sp\objectives::objective_exists("compound_objective"))
        scripts\engine\sp\objectives::objective_remove("compound_objective");

      scripts\engine\sp\objectives::objective_add("compound_objective", "current", undefined, &"ZD30/OBJ_LOCATE_WOLF");
      break;
    case "3f_balcony":
      if(scripts\engine\sp\objectives::objective_exists("compound_objective"))
        scripts\engine\sp\objectives::objective_remove("compound_objective");

      scripts\engine\sp\objectives::objective_add("compound_objective", "current", undefined, &"ZD30/OBJ_REACH_BALCONY", "");
      break;
    case "3f_hostage":
      var_1 = scripts\engine\utility::getStruct("3f_hostage", "targetname");

      if(scripts\engine\sp\objectives::objective_exists("compound_objective")) {
        scripts\engine\sp\objectives::objective_update("compound_objective", "current", undefined, &"ZD30/OBJ_CLEAR_3F", "");
        scripts\engine\sp\objectives::objective_add_location_position("compound_objective", "3f_clear", var_1.origin);
      } else {
        scripts\engine\sp\objectives::objective_add("compound_objective", "current", undefined, &"ZD30/OBJ_CLEAR_3F", "");
        scripts\engine\sp\objectives::objective_add_location_position("compound_objective", "3f_clear", var_1.origin);
      }

      break;
    case "downstairs":
      var_1 = scripts\engine\utility::getStruct("hallway_fov", "targetname");

      if(scripts\engine\sp\objectives::objective_exists("compound_objective")) {
        scripts\engine\sp\objectives::objective_remove_location("compound_objective", "3f_clear");
        scripts\engine\sp\objectives::objective_update("compound_objective", "current", undefined, &"ZD30/OBJ_DOWNSTAIRS");
        scripts\engine\sp\objectives::objective_add_location_position("compound_objective", "hallway", var_1.origin);
      } else {
        scripts\engine\sp\objectives::objective_add("compound_objective", "current", undefined, &"ZD30/OBJ_DOWNSTAIRS");
        scripts\engine\sp\objectives::objective_add_location_position("compound_objective", "hallway", var_1.origin);
      }

      break;
    case "wait_for_price":
      if(scripts\engine\sp\objectives::objective_exists("compound_objective"))
        scripts\engine\sp\objectives::objective_remove("compound_objective");

      scripts\engine\sp\objectives::objective_add("compound_objective", "current", undefined, &"ZD30/OBJ_WAIT_PRICE");
      scripts\engine\sp\objectives::objective_set_on_entity("compound_objective", &"ZD30/FOLLOW", level.price);
      scripts\engine\sp\objectives::objective_set_z_offset("compound_objective", 75);
      break;
    case "tea_room":
      if(scripts\engine\sp\objectives::objective_exists("compound_objective"))
        scripts\engine\sp\objectives::objective_remove("compound_objective");

      scripts\engine\sp\objectives::objective_add("compound_objective", "current", undefined, &"ZD30/OBJ_TEA_ROOM", &"ZD30/FOLLOW");
      scripts\engine\sp\objectives::objective_set_on_entity("compound_objective", &"ZD30/FOLLOW", level.price);
      scripts\engine\sp\objectives::objective_set_z_offset("compound_objective", 72);
      break;
    case "lift_trap_door":
      var_1 = scripts\engine\utility::getStruct("tunnel_door", "targetname");
      var_2 = var_1.origin + (7, 4, 10);

      if(scripts\engine\sp\objectives::objective_exists("compound_objective"))
        scripts\engine\sp\objectives::objective_remove("compound_objective");

      scripts\engine\sp\objectives::objective_add("compound_objective", "current", var_2, &"ZD30/OBJ_TRAP_DOOR", "");
      break;
    case "clear_compound_obj":
      if(scripts\engine\sp\objectives::objective_exists("compound_objective"))
        scripts\engine\sp\objectives::objective_remove("compound_objective");

      scripts\engine\sp\objectives::objective_add("tunnels_search", "current", undefined, &"ZD30/OBJ_TUNNELS_SEARCH");
      break;
  }
}

power_objective() {
  level endon("power_is_off");
  var_0 = scripts\engine\utility::getStruct("power_switch", "targetname");

  if(scripts\engine\sp\objectives::objective_exists("compound_objective"))
    scripts\engine\sp\objectives::objective_remove("compound_objective");

  scripts\engine\sp\objectives::objective_add("compound_power", "current", undefined, &"ZD30/OBJ_POWER_OFF");
  scripts\engine\sp\objectives::objective_add_location_position("compound_power", "power_switch", var_0.origin);
}

heli_intro_anim() {
  level.all_heli_ents = [];
  level.intro_checks["first_trans_over"] = 0;
  level.intro_checks["first_anim_over"] = 0;
  thread show_hud(0);
  var_0 = scripts\engine\utility::getStruct("breach_animnode", "targetname");
  thread skippable_heli_intro();
  thread heli_intro_vo();
  thread heli_spawn_alpha(var_0);
  thread heli_spawn_bravo(var_0);
  thread heli_spawn_charlie(var_0);
  thread heli_interior_lights();
  thread b1_door_setup();
  thread b1_door_runner();
}

b1_door_runner() {
  level endon("heli_intro_skipped");
  var_0 = getspawner("b1_intro_guy", "script_noteworthy");
  level.b1_intro_guy = scripts\engine\sp\utility::spawn_script_noteworthy("b1_intro_guy");
  level.b1_intro_guy.animname = "b1_intro_guy";
  level.b1_intro_guy.allowdeath = 0;
  level.b1_intro_guy.mydeathanimebool = 0;
  level.b1_intro_guy.diequietly = 1;
  level.b1_intro_guy.dropweapon = 0;
  level.b1_intro_guy scripts\common\ai::gun_remove();
  level.b1_intro_guy scripts\common\ai::magic_bullet_shield();
  level endon("b1_intro_guy_dead");
  var_1 = scripts\engine\utility::getStruct("b1_intro_animnode", "targetname");
  var_1 scripts\common\anim::anim_first_frame_solo(level.b1_intro_guy, "b1_introA");
  wait 30.5;
  level.b1_intro_guy thread b1_intro_death_watcher();
  level.b1_intro_guy thread b1_door_quick_open();
  var_1 notify("stop_first_frame");
  var_1 thread scripts\common\anim::anim_single_solo(level.b1_intro_guy, "b1_introA");
  wait 3;
  level.b1_intro_guy notify("b1_intro_scene_done");
  level.b1_intro_guy scripts\engine\sp\utility::anim_stopanimScripted();

  if(isDefined(level.b1_intro_guy.magic_bullet_shield) && level.b1_intro_guy.magic_bullet_shield == 1)
    level.b1_intro_guy scripts\common\ai::stop_magic_bullet_shield();

  level.b1_intro_guy delete();
}

skippable_heli_intro() {
  var_0 = ["heli_alpha_ready", "heli_bravo_ready", "heli_charlie_ready"];
  level scripts\engine\utility::waittill_all_in_array(var_0);
  var_1 = scripts\sp\utility::userskip_wait();

  if(!var_1) {
    return;
  }
  scripts\sp\hud_util::fade_out(0);
  level notify("heli_intro_stop_vo");

  if(isDefined(level.vo_chatter))
    scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::terminate_chatter();

  var_2 = "heli_intro";
  var_3 = 15;

  foreach(var_5 in level.all_heli_ents) {
    if(!isDefined(var_5)) {
      continue;
    }
    if(level.intro_checks["first_anim_over"])
      var_5 thread skip_ahead(var_2, var_3);
    else {
      if(var_5.animname != "heli_bravo")
        var_5 scripts\engine\sp\utility::anim_stopanimScripted();

      var_5 scripts\engine\utility::delaythread(0.1, ::skip_ahead, var_2, var_3);
    }

    var_5 stopsounds();
  }

  if(isDefined(level.kyle))
    level.kyle delete();

  if(isDefined(level.b1_intro_guy)) {
    if(isDefined(level.b1_intro_guy.magic_bullet_shield) && level.b1_intro_guy.magic_bullet_shield == 1)
      level.b1_intro_guy scripts\common\ai::stop_magic_bullet_shield();

    level.b1_intro_guy delete();
  }

  scripts\engine\utility::flag_set("kill_lights");

  if(!level.player isnightvisionon())
    level.player nightvisiongogglesforceon();

  wait 0.15;
  scripts\engine\utility::delaythread(0.05, scripts\sp\hud_util::fade_in, 0.05);
  scripts\sp\utility::userskip_stop();
  getrandomnodedestination(0, 0);
  level.player clearcinematicmotionoverride();
  scripts\engine\utility::flag_set("start_fp_trans");
  scripts\engine\utility::flag_set("pre_anim_finished");
  scripts\engine\utility::flag_set("heli_intro_skipped");
  thread heli_ride_in_fx_skippable();
  thread objective_skip_check();
  var_7 = scripts\engine\utility::getStruct("breach_animnode", "targetname");
  scripts\engine\utility::array_thread(level.all_heli_ents, ::resume_idle_or_anim, var_7);
  thread screen_shake_landing();
  thread audio_music_intro();
  level.infil_heli_bravo thread scale_off_bravo_audio();
}

scale_off_bravo_audio() {
  wait 17;
  self.heli_bravo_main_snd_ent scalevolume(0.0, 20);
  self.heli_bravo_main_snd_ent scripts\engine\utility::delaycall(20, ::delete);
}

objective_skip_check() {
  wait 1;

  if(scripts\engine\sp\objectives::objective_exists("compound_objective"))
    scripts\engine\sp\objectives::objective_remove("compound_objective");

  objective_control("clear_building");
}

skip_ahead(var_0, var_1) {
  var_2 = getanimlength(scripts\engine\utility::getanim(var_0));
  var_3 = (var_2 - var_1) / var_2;
  var_3 = 1 - var_3;

  if(self.animname == "heli_bravo")
    var_3 = 0.572;

  self setanimtime(scripts\engine\utility::getanim(var_0), var_3);
}

resume_idle_or_anim(var_0) {
  if(isDefined(self.plays_single_anim)) {
    self waittillmatch("single anim", "end");

    if(self.plays_single_anim)
      loop_or_delete(var_0);
    else
      loop_or_anim(var_0);
  }
}

heli_intro_vo() {
  level endon("heli_intro_skipped");
  wait 6.7;
  level.price scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_pri_heli_infil_intro_60");
  level.player scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_alx_heli_infil_intro_70");
}

b1_door_quick_open() {
  wait 1.5;

  if(!scripts\engine\utility::flag("b1_intro_guy_dead")) {
    if(isalive(self))
      self.mydeathanimebool = 1;

    wait 0.2;
    var_0 = scripts\sp\door::get_interactive_door("building1_door");
    var_1 = spawn("script_origin", var_0.origin);
    var_1.angles = var_0.angles;
    waitframe();
    var_0 linkTo(var_1);
    var_1 rotateTo((0, 165, 0), 0.1, 0.05, 0);
    thread scripts\engine\utility::play_sound_in_space("zd30_infil_door_open_close", var_0.origin);
    wait 0.8;
    var_1 rotateTo((0, 225, 0), 0.1, 0.05, 0);
    wait 0.5;
    var_1 delete();
  }
}

b1_intro_death_watcher() {
  self endon("b1_intro_scene_done");
  var_0 = undefined;
  self waittill("damage", var_1, var_2, var_3, var_4);
  scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\engine\utility::flag_set("b1_intro_guy_dead");

  if(self.mydeathanimebool) {
    var_0 = spawn("script_origin", self.origin);
    var_0.angles = self.angles + (0, 45, 0);
    self.skipdeathanim = 1;
    var_0 scripts\common\anim::anim_single_solo(self, "b1_introA_deathA");
    self linkTo(var_0);
    var_0.origin = (-18, -823, 13);
    var_0 scripts\common\anim::anim_last_frame_solo(self, "b1_introA_deathA");
    self.allowdeath = 1;

    if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield == 1)
      scripts\common\ai::stop_magic_bullet_shield();

    self kill();
  } else {
    if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield == 1)
      scripts\common\ai::stop_magic_bullet_shield();

    scripts\sp\utility::do_damage(self.health + 100, var_4, var_2);
  }

  if(isDefined(var_0))
    var_0 delete();
}

temp_scriptablerotateTo(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_origin", self.origin);
  var_4.angles = self.angles;
  self linkTo(var_4);

  if(isDefined(var_2))
    var_4 rotateTo(var_0, var_1, var_2, var_3);
  else
    var_4 rotateTo(var_0, var_1);

  wait(var_1 + 0.05);
  var_4 delete();
}

heli_interior_lights() {
  scripts\engine\utility::flag_wait("kill_lights");
  var_0 = getEntArray("infil_heli_light", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 setlightintensity(0);
}

infil_heli_lights() {
  playFXOnTag(scripts\engine\utility::getfx("vfx_zd30_heli_interior_lights"), self, "tag_origin");
  scripts\engine\utility::flag_wait("kill_lights");
  thread scripts\common\vehicle::vehicle_lights_off();
  killfxontag(scripts\engine\utility::getfx("vfx_zd30_heli_interior_lights"), self, "tag_origin");
}

infil_heli_lights_alpha() {
  playFXOnTag(scripts\engine\utility::getfx("vfx_zd30_heli_interior_lights"), self, "tag_origin");
  scripts\engine\utility::flag_wait("kill_lights");
  thread scripts\common\vehicle::vehicle_lights_off();
  killfxontag(scripts\engine\utility::getfx("vfx_zd30_heli_interior_lights"), self, "tag_origin");
}

heli_spawn_alpha(var_0) {
  level.infil_heli_alpha = scripts\common\vehicle::spawn_vehicle_from_targetname("infil_heli_alpha");
  level.infil_heli_alpha scripts\engine\sp\utility::assign_animtree("heli_alpha");
  level.infil_heli_alpha vehicle_turnengineoff();
  level.infil_heli_alpha thread infil_heli_lights_alpha();
  level.infil_heli_alpha thread infil_heli_damage();
  scripts\engine\sp\utility::array_spawn_noteworthy("alpha");
  scripts\common\vehicle_build::build_treadfx("script_vehicle_iw8_lbravo_carrier", "default", "vfx/iw8/level/zd30/heli_dust_zd30.vfx");
  var_1 = 1;
  var_2 = [];
  var_3 = scripts\engine\sp\utility::get_spawner_array("alpha_pilot", "script_noteworthy");
  level.kyle = spawn_kyledrone();
  level.kyle thread scripts\sp\maps\tunnels\zd30tunnels_lighting.gsc::dof_kyledrone();

  foreach(var_5 in var_3) {
    var_6 = scripts\engine\sp\utility::bodyonlyspawn(var_5);
    var_6.animname = "alphaP" + var_1;
    var_1++;
    var_2[var_2.size] = var_6;
  }

  var_8 = var_0 link_player_to_rig_free_look("heli_intro", undefined, undefined, undefined, 0, 20, 25, 30, 22);
  level.player freezelookcontrols(1);
  level.player disableoffhandweapons();
  var_8.animweapon = var_8 thread anim_weapon_for_player();
  var_8.animweapon hide();
  thread screen_shake_infil();
  thread audio_zd30_intro_lbird_plr_heli();
  level.player allowmelee(0);
  level.player allowsprint(0);
  var_9 = [level.infil_heli_alpha, level.alpha5, level.alpha6];
  var_10 = scripts\engine\utility::array_combine(var_9, var_2);
  level.alpha6 attach("misc_wm_sledgehammer_scaled", "tag_accessory_right");
  level.kyle thread play_then_delete(var_0, var_8.animweapon);
  var_8 thread play_single_anim_player(var_0);
  scripts\engine\utility::array_thread(var_10, ::play_single_anim, var_0);
  scripts\engine\utility::delaythread(0.15, scripts\sp\hud_util::fade_in, 0.05);

  foreach(var_6 in var_9) {
    if(var_6.animname == "alpha5") {
      var_6.og_model = var_6.model;
      var_6 setModel("body_sas_woodland_ar_1_1_wind");
      continue;
    }

    if(var_6.animname == "alpha6") {
      var_6.og_model = var_6.model;
      var_6 setModel("body_sas_woodland_ar_4_1_wind");
    }
  }

  level.player scripts\engine\sp\utility::set_player_demeanor("relaxed");
  thread flappy_clothes();
  var_10 = scripts\engine\utility::array_add(var_10, var_8);
  thread heli_intro_anim_unlink_player(var_8);
  thread sort_allies(var_10, "heli_alpha_ready");
  scripts\engine\utility::flag_wait("kill_lights");
  var_13 = [level.alpha2, level.alpha3, level.alpha4, level.alpha6];
  var_13 thread allies_nvg_on(1);
  thread clip_delete("b1_sledge_clip", "sledge_anim_is_over");
  scripts\engine\utility::flag_wait_all("start_sledge", "sledge_ready");
  thread b1_sledge_intro();
}

infil_heli_damage() {
  self endon("entitydeleted");
  self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);

  if(isDefined(var_1) && isPlayer(var_1)) {
    thread scripts\sp\player_death::set_custom_death_quote(13);
    scripts\sp\utility::missionfailedwrapper();
  }
}

sort_allies(var_0, var_1, var_2) {
  if(isDefined(var_2))
    level waittill(var_2);

  foreach(var_4 in var_0)
  level.all_heli_ents[level.all_heli_ents.size] = var_4;

  wait 0.2;
  level notify(var_1);
}

anim_weapon_for_player() {
  var_0 = spawn("script_model", level.player.origin);
  var_0 scripts\common\utility::make_weapon_model("iw8_ar_mcharlie", ["semi_ar", "reflex_west01", "silencer04", "laserir", "rec_mcharlie|1", "back_mcharlie|1", "barshort_mcharlie|1", "mag_mcharlie|1"]);
  var_0 linkTo(self, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
  return var_0;
}

spawn_kyledrone() {
  var_0 = getspawner("kyle", "targetname");
  var_0.count++;
  var_1 = scripts\engine\sp\utility::spawn_targetname("kyle");
  var_1 scripts\engine\sp\utility::name_hide();
  var_1 setModel("body_hero_kyle_woodland_wind");
  return var_1;
}

play_then_delete(var_0, var_1) {
  var_0 scripts\common\anim::anim_single_solo(self, "heli_pre_intro");
  var_1 scripts\engine\utility::delaycall(2, ::delete);
}

b1_door_nag(var_0) {}

audio_zd30_intro_lbird_plr_heli() {
  level endon("heli_intro_skipped");
  wait 0.15;
  var_0 = spawn("script_origin", level.infil_heli_alpha.origin);
  var_0 linkTo(level.infil_heli_alpha);
  var_1 = spawn("script_origin", level.infil_heli_alpha.origin);
  var_1 linkTo(level.infil_heli_alpha);
  var_0 scripts\engine\sp\utility::sound_fade_in("scn_zd30_intro_heli_alpha_main_lp", 0.25, 0.25, 1);
  var_0 scripts\engine\utility::delaycall(4.5, ::scalevolume, 1.0, 2.5);
  var_0 scripts\engine\utility::delaycall(7.3, ::scalevolume, 0.55, 1.8);
  var_1 scalevolume(0.0, 0.0);
  var_1 playLoopSound("scn_zd30_intro_heli_alpha_int_lp");
  var_1 scalevolume(1.0, 0.25);
  var_1 scripts\engine\utility::delaycall(5.8, ::scalevolume, 0.25, 2.1);
  level.infil_heli_alpha thread scripts\engine\sp\utility::play_sound_on_entity("scn_zd30_intro_heli_alpha_mtl_rattle");
  level.player scripts\engine\utility::delaythread(5.0, scripts\engine\sp\utility::play_sound_on_entity, "scn_zd30_intro_heli_alpha_dirt_winds_lr");
  childthread audio_zd30_intro_lbird_plr_heli_kill_entities(var_0, var_1);
}

audio_zd30_intro_lbird_plr_heli_kill_entities(var_0, var_1) {
  wait 24.0;
  var_1 scalevolume(0.0, 5);
  var_1 scripts\engine\utility::delaycall(5, ::delete);
  wait 5.0;
  var_2 = spawn("script_origin", level.infil_heli_alpha.origin);
  var_2 linkTo(level.infil_heli_alpha);
  var_2 thread scripts\engine\sp\utility::play_sound_on_entity("scn_zd30_intro_heli_alpha_descent_take_off_away");
  wait 1.25;
  level.player thread scripts\engine\sp\utility::play_sound_on_entity("scn_zd30_intro_heli_alpha_debris_kick_up_lr");
  wait 1.75;
  var_0 scalevolume(0.0, 5);
  var_0 scripts\engine\utility::delaycall(5, ::delete);
  wait 35.0;
  var_2 scalevolume(0.0, 15);
  var_2 scripts\engine\utility::delaycall(15, ::delete);
}

screen_shake_infil() {
  level endon("heli_intro_skipped");
  level.shakes = 1;
  var_0 = 0.5;
  var_1 = 5;
  var_2 = 0.5;
  var_3 = 1.8;
  var_4 = 1;
  var_5 = 100;
  var_6 = 17;
  thread screen_shake_pre_infil();
  wait 5.7;
  level.player screenshakeonentity(0.5, 1, 0.5, 1.5, 1, 0, 1000, 5, 1.8, 100);
  wait 1.5;

  for(;;) {
    level.player screenshakeonentity(rand_num(var_0, 0.15), var_4, rand_num(var_2, 0.3), 1, 0, 0, 1000, rand_num(var_1, 1), var_3, var_5);
    wait 1;

    if(!level.shakes) {
      break;
    }
  }

  scripts\sp\utility::userskip_stop();
  screen_shake_landing();
}

screen_shake_landing() {
  var_0 = [0.5, 0.7, 0.4];
  var_1 = [5, 7, 5];
  var_2 = [0.5, 0.5, 0.3];
  var_3 = [1.8, 1.8, 1.8];
  var_4 = [1, 1, 0.5];
  var_5 = [100, 100, 50];
  var_6 = [17, 3.2, 2.5];
  level.player screenshakeonentity(var_0[1], var_4[1], var_2[1], var_6[1], 0, 0, 1000, var_1[1], var_3[1], var_5[1]);
  wait(var_6[1]);
  level.player screenshakeonentity(var_0[2], var_4[2], var_2[2], var_6[2], 0, 0, 1000, var_1[2], var_3[2], var_5[2]);
  wait(var_6[2]);
  screenshake(level.player.origin, 0.3, 0.3, 1, 3, 0, 1, 600, 2, 1, 100);
}

screen_shake_pre_infil() {
  scripts\engine\utility::flag_wait("pre_anim_finished");
  wait 17;
  level.shakes = 0;
}

rand_num(var_0, var_1) {
  var_2 = randomfloatrange(var_0 - var_1, var_0 + var_1);
  return var_2;
}

heli_spawn_bravo(var_0) {
  level.infil_heli_bravo = scripts\common\vehicle::spawn_vehicle_from_targetname("infil_heli_bravo");
  level.infil_heli_bravo scripts\engine\sp\utility::assign_animtree("heli_bravo");
  level.infil_heli_bravo vehicle_turnengineoff();
  level.infil_heli_bravo thread infil_heli_lights();
  level.infil_heli_bravo thread infil_heli_damage();
  var_1 = scripts\engine\sp\utility::array_spawn_noteworthy("bravo");
  scripts\engine\sp\utility::spawn_script_noteworthy("price");
  scripts\common\vehicle_build::build_treadfx("script_vehicle_iw8_lbravo_carrier", "default", "vfx/iw8/level/zd30/heli_dust_zd30.vfx");
  var_2 = 1;
  var_3 = [];
  var_4 = scripts\engine\sp\utility::get_spawner_array("alpha_pilot", "script_noteworthy");

  foreach(var_6 in var_4) {
    var_7 = scripts\engine\sp\utility::bodyonlyspawn(var_6);
    var_7.animname = "bravoP" + var_2;
    var_2++;
    var_3[var_3.size] = var_7;
  }

  var_9 = [level.price, level.overwatch, level.bravo2];
  var_10 = [level.bravo1, level.bravo4, level.bravo5];
  var_11 = scripts\engine\utility::array_combine([level.infil_heli_bravo], var_3);
  setup_heli_tags_bravo();
  level.infil_heli_bravo thread audio_zd30_intro_lbird_bravo_heli();
  scripts\engine\utility::array_thread(var_11, ::play_single_anim, var_0);
  scripts\engine\utility::array_thread(var_9, ::play_multi_anim, var_0, level.infil_heli_bravo);
  scripts\engine\utility::array_thread(var_10, ::play_multi_anim, var_0, level.infil_heli_bravo);

  foreach(var_7 in var_1) {
    var_7.og_model = var_7.model;
    var_7 setModel("body_sas_woodland_ar_1_1_wind");
  }

  var_11 = scripts\engine\utility::array_combine(var_11, var_9, var_10);
  thread sort_allies(var_11, "heli_bravo_ready", "heli_alpha_ready");
  scripts\engine\utility::flag_wait("kill_lights");
  var_14 = [level.price, level.bravo1, level.bravo2, level.overwatch, level.bravo4, level.bravo5];
  var_14 thread allies_nvg_on(1);
  thread b1_breach_intro();
}

setup_heli_tags_bravo() {
  level.price.introtag = "tag_passenger6";
  level.overwatch.introtag = "tag_passenger4";
  level.bravo2.introtag = "tag_passenger5";
  level.bravo1.introtag = "tag_passenger1";
  level.bravo4.introtag = "tag_passenger2";
  level.bravo5.introtag = "tag_passenger3";
}

audio_zd30_intro_lbird_bravo_heli() {
  level endon("heli_intro_skipped");
  wait 0.15;
  self.heli_bravo_main_snd_ent = spawn("script_origin", level.infil_heli_bravo.origin);
  self.heli_bravo_main_snd_ent linkTo(level.infil_heli_bravo);
  self.heli_bravo_main_snd_ent scripts\engine\sp\utility::sound_fade_in("scn_zd30_intro_heli_bravo_main_lp", 1.0, 0.25, 1);
  wait 28.3;
  level.infil_heli_bravo scripts\engine\sp\utility::play_sound_on_entity("scn_zd30_intro_heli_bravo_hard_clear");
  self.heli_bravo_main_snd_ent scalevolume(0.0, 20);
  self.heli_bravo_main_snd_ent scripts\engine\utility::delaycall(20, ::delete);
}

heli_spawn_charlie(var_0) {
  var_1 = scripts\common\vehicle::spawn_vehicle_from_targetname("infil_heli_charlie");
  var_1 scripts\engine\sp\utility::assign_animtree("heli_charlie");
  var_1 vehicle_turnengineoff();
  var_1 thread infil_heli_lights();
  var_1 thread infil_heli_damage();
  var_2 = [];
  var_3 = 1;
  var_4 = scripts\engine\sp\utility::get_spawner_array("charlie_infil", "script_noteworthy");
  scripts\common\vehicle_build::build_treadfx("script_vehicle_iw8_lbravo_carrier", "default", "vfx/iw8/level/zd30/heli_dust_zd30.vfx");

  foreach(var_6 in var_4) {
    var_7 = scripts\engine\sp\utility::bodyonlyspawn(var_6);

    if(var_6.classname == "actor_ally_hero_farah_urban")
      var_7.animname = "farah";
    else if(var_6.classname == "actor_ally_hero_alex_desert")
      var_7.animname = "alex";
    else {
      var_7.animname = "charlie" + var_3;
      var_3++;
    }

    var_2[var_2.size] = var_7;
  }

  var_9 = scripts\engine\utility::array_combine(var_2, [var_1]);
  scripts\engine\utility::array_thread(var_9, ::play_single_anim, var_0);
  thread sort_allies(var_9, "heli_charlie_ready", "heli_bravo_ready");
}

heli_intro_anim_unlink_player(var_0) {
  scripts\engine\utility::flag_wait("start_fp_trans");
  var_0 hidepart("j_clavicle_le");
  var_0 hidepart("j_wrist_ri");
  thread show_hud(1);
  level.player showviewmodel();
  level.player freezelookcontrols(0);
  scripts\engine\utility::delaythread(0.1, ::nvg_hint_display);
  level.intro_checks["first_trans_over"] = 1;
  scripts\engine\utility::flag_wait("pre_anim_finished");
  wait 2;
  var_0 thread scripts\engine\utility::waittillmatch_notify("single anim", "end", "anim_end");
  scripts\engine\utility::waittill_any_ents(var_0, "anim_end", level.player, "damage");
  unlink_player_from_rig_free_look(1);
  level.player allowmelee(1);
  level.player enableoffhandweapons();
  scripts\engine\utility::flag_wait("sledge_ready");
  level.player allowsprint(1);
}

nvg_hint_display() {
  if(!level.player isnightvisionon())
    thread scripts\sp\nvg\nvg_player::nvg_on_hint(8);
}

show_hud(var_0) {
  if(var_0) {
    level.player enableweapons();
    setomnvar("ui_hide_dpad_hud", 0);
    level.player scripts\sp\utility::allow_cg_drawcrosshair(1);
    setomnvar("ui_hide_weapon_info", 0);
    setomnvar("ui_hide_hud", 0);
  } else {
    level.player hideviewmodel();
    setomnvar("ui_hide_dpad_hud", 1);
    level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
    setomnvar("ui_hide_weapon_info", 1);
    setomnvar("ui_hide_hud", 1);
    level.player disableweapons();
  }
}

b1_door_setup() {
  level endon("start_sledge");

  if(!scripts\engine\utility::flag("scriptables_ready"))
    scripts\engine\utility::flag_wait("scriptables_ready");

  var_0 = scripts\sp\door::get_interactive_door("building1_door");
  var_0 scripts\engine\utility::ent_flag_wait("initialized");
  var_0 scripts\sp\door::remove_open_ability();
  var_0 scripts\game\sp\door::remove_door_snake_cam_ability();
  var_0.locked = 1;
  var_0.bashed = 1;
  var_0 scripts\sp\utility::do_damage(5, var_0.origin);
  wait 0.2;
  var_0 waittill("damage");
  scripts\engine\utility::flag_set("start_sledge");
}

nag_enter_b1() {
  if(istrue(level.testingthings)) {}

  level.testingthings = 1;
  level endon("b1_all_clear");
  var_0 = ["dx_vom_pri_heli_unload_guardhouse_30", "dx_vom_pri_heli_unload_guardhouse_70"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0);
  childthread player_in_b1_watcher();

  for(;;)
    nag_enter_b1_internal(var_1);
}

nag_enter_b1_internal(var_0) {
  level endon("start_sledge");
  level endon("b1_start_2nd_guy");
  level endon("ai_killed");

  for(;;) {
    wait 12;
    level.price scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::nagtill("player_inside_b1", var_0, 15);
    scripts\engine\utility::flag_waitopen("player_inside_b1");
  }
}

player_in_b1_watcher() {
  var_0 = getEnt("b1_nag_trigger", "targetname");

  for(;;) {
    var_0 waittill("trigger");
    scripts\engine\utility::flag_set("player_inside_b1");

    while(level.player istouching(var_0))
      waitframe();

    scripts\engine\utility::flag_clear("player_inside_b1");
  }
}

heli_ride_intro_extras() {
  level endon("heli_intro_stop_vo");
  scripts\engine\utility::flag_wait("pre_anim_finished");
  thread heli_ride_in_fx();
  thread heli_ride_in_vo();
  wait 6.4;
  scripts\engine\utility::flag_set("kill_lights");
  scripts\engine\sp\utility::delaychildthread(7, ::objective_control, "clear_building");
  scripts\engine\sp\utility::delaychildthread(10, ::audio_music_intro);
}

audio_music_intro() {
  setmusicstate("mx_zd30_heli_infil");
  scripts\engine\utility::flag_wait("moveup_building1");
  wait 1;
  setmusicstate("");
}

heli_ride_in_vo() {
  level endon("heli_intro_stop_vo");
  level childthread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_c1p_heli_infil_intro_10");
  level.price childthread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_pri_heli_infil_intro_20");
  wait 11;
  level.price childthread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_pri_heli_infil_intro_80");
  level childthread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_s11_heli_infil_intro_90");
  wait 5;
  level scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_s11_1st_floor_interior_50");
}

heli_ride_in_fx() {
  level endon("heli_intro_skipped");
  wait 8;
  scripts\engine\utility::exploder("heli_fx");
  wait 9;
  playmayhem("vfx_mayh_zd30_clothesline_a");
}

heli_ride_in_fx_skippable() {
  scripts\engine\utility::exploder("heli_fx");
  wait 1;
  playmayhem("vfx_mayh_zd30_clothesline_a");
}

setup_alpha_sledge_team() {
  thread clip_delete("b1_sledge_clip", "sledge_anim_is_over");
  var_0 = [level.alpha5, level.alpha6];
  var_1 = scripts\engine\utility::getStruct("breach_animnode", "targetname");

  foreach(var_3 in var_0)
  var_1 thread scripts\common\anim::anim_loop_solo(var_3, "heli_intro_idle", "stop_heli_intro_" + var_3.animname);

  scripts\engine\utility::flag_wait("start_sledge");
  thread b1_sledge_intro();
}

b1_sledge_intro() {
  var_0 = scripts\sp\door::get_interactive_door("building1_door");
  scripts\engine\utility::exploder("door_fx");
  var_1 = [level.alpha5, level.alpha6];
  var_2 = scripts\engine\utility::getStruct("breach_animnode", "targetname");

  foreach(var_4 in var_1)
  var_2 notify("stop_heli_intro_" + var_4.animname);

  var_2 thread anim_door(var_0, "sledge_intro");
  var_0 thread scripts\engine\sp\utility::play_sound_on_tag("scn_zd30_door1_breach_sledge_door", "tag_door_handle");
  level.alpha5 thread b1_alpha5_action(var_2);
  level.alpha6 thread b1_alpha6_action(var_2);
  scripts\engine\utility::flag_wait("player_in_1st_building");

  foreach(var_4 in var_1)
  var_4.uprightcqbidle = 1;
}

flappy_clothes() {
  scripts\engine\utility::flag_wait("lb_landed");
  var_0 = [level.bravo1, level.bravo2, level.overwatch, level.bravo4, level.bravo5, level.alpha5, level.alpha6];

  foreach(var_2 in var_0)
  var_2 setModel(var_2.og_model);
}

b1_alpha5_action(var_0) {
  var_0 scripts\common\anim::anim_single_solo(self, "sledge_intro");
  self setgoalnode(getnode("alpha6_backoff_node", "targetname"));
}

b1_alpha6_action(var_0) {
  var_1 = scripts\engine\utility::getStruct("b1_gesture_door", "targetname");
  level thread scripts\engine\sp\utility::notify_delay("sledge_anim_is_over", 1.2);
  var_0 scripts\common\anim::anim_single_solo(self, "sledge_intro");
  scripts\common\ai::set_gunpose("gun_down");
  self setgoalpos(self.origin);
  scripts\common\utility::lookatentity(level.player);
  scripts\engine\utility::delaythread(2, scripts\common\utility::lookatentity);
  scripts\asm\gesture::ai_request_gesture("beckon", var_1);
  wait 13;

  while(!scripts\engine\utility::flag("player_in_1st_building")) {
    var_2 = scripts\engine\utility::random([self, level.alpha5]);
    var_2 scripts\common\utility::lookatentity(level.player);
    var_2 scripts\engine\utility::delaythread(2, scripts\common\utility::lookatentity);
    var_2 scripts\asm\gesture::ai_request_gesture("beckon", var_1);
    wait 13;
  }
}

b1_breach_intro() {
  scripts\engine\utility::flag_wait("lb_landed");
  var_0 = [level.alpha2, level.alpha3, level.alpha4];

  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::getStruct("infil_" + var_2.animname, "targetname");
    var_2 forceteleport(var_3.origin, var_3.angles);
  }

  thread setup_alpha_breach_approach();
}

setup_alpha_breach_approach() {
  var_0 = [level.alpha2, level.alpha3, level.alpha4];
  var_1 = scripts\engine\utility::getStruct("breach_animnode", "targetname");
  thread check_if_guys_are_ready();

  foreach(var_3 in var_0) {
    if(var_3.animname == "alpha3")
      var_3 attach("offhand_wm_c4_bomb_sp", "tag_accessory_right");

    var_3 thread breach_anims(var_1);
  }

  thread setup_alpha_breach_team(var_1);
}

check_if_guys_are_ready() {
  level scripts\engine\utility::waittill_multiple("alpha2_br_ready", "alpha3_br_ready", "alpha4_br_ready");
  scripts\engine\utility::flag_set("allies_and_doors_ready");
}

setup_alpha_breach_jumpto() {
  var_0 = [level.alpha2, level.alpha3, level.alpha4];
  var_1 = scripts\engine\utility::getStruct("breach_animnode", "targetname");
  thread check_if_guys_are_ready();

  foreach(var_3 in var_0) {
    if(var_3.animname == "alpha3") {
      var_3 attach("offhand_wm_c4_bomb_sp", "tag_accessory_right");
      var_3 attach("offhand_vm_clacker_tactical", "tag_accessory_left");
    }

    var_3 thread breach_anims_jumpto(var_1);
  }

  thread setup_alpha_breach_team(var_1);
}

setup_alpha_breach_team(var_0) {
  var_1 = compound_door_setup("breach_gate_l");
  var_1[0] scripts\engine\sp\utility::assign_animtree("gate_l");
  var_2 = compound_door_setup("breach_gate_r");
  var_2[0] scripts\engine\sp\utility::assign_animtree("gate_r");
  var_3 = [var_1[0], var_2[0]];
  var_0 scripts\common\anim::anim_first_frame(var_3, "breach");
  scripts\engine\utility::flag_wait_all("breach_gate", "allies_and_doors_ready");
  var_0 notify("stop_first_frame");
  scripts\sp\player::player_movement_state("cqb");
  thread compound_lights_sequence();
  thread breach_good_vo();
  var_0 scripts\common\anim::anim_single(var_3, "breach");
  var_0 scripts\common\anim::anim_last_frame_solo(var_1[0], "breach");
  var_0 scripts\common\anim::anim_last_frame_solo(var_2[0], "breach");
}

breach_anims(var_0) {
  if(self.animname == "alpha3" && !scripts\sp\starts::is_after_start("heli_unload")) {
    self attach("offhand_vm_clacker_tactical", "tag_accessory_left");
    var_0 scripts\sp\anim::anim_reach_solo(self, "breach_setup");
    var_0 scripts\common\anim::anim_single_solo(self, "breach_setup");
    scripts\engine\utility::flag_set("breacher_set");
  } else {
    var_1 = "cover_right";

    if(self.animname == "alpha4")
      var_1 = "cover_left";

    var_0 scripts\sp\anim::anim_reach_and_arrive(self, "breach_idle", undefined, var_1);
  }

  var_0 thread scripts\common\anim::anim_loop_solo(self, "breach_idle", "stop_breach_loop");
  level notify(self.animname + "_br_ready");
  scripts\engine\utility::flag_wait_all("breach_gate", "allies_and_doors_ready");
  var_0 notify("stop_breach_loop");
  var_0 scripts\common\anim::anim_single_solo(self, "breach");

  if(self.animname == "alpha3")
    self detach("offhand_vm_clacker_tactical", "tag_accessory_left");

  if(!scripts\engine\utility::flag("breach_finished"))
    scripts\engine\utility::flag_set("breach_finished");
}

breach_anims_jumpto(var_0) {
  var_0 thread scripts\common\anim::anim_loop_solo(self, "breach_idle", "stop_breach_loop");

  if(self.animname == "alpha3")
    scripts\engine\utility::flag_set("breacher_set");

  level notify(self.animname + "_br_ready");
  scripts\engine\utility::flag_wait_all("breach_gate", "allies_and_doors_ready");
  var_0 notify("stop_breach_loop");

  if(self.animname == "alpha3")
    self detach("offhand_wm_c4_bomb_sp", "tag_accessory_right");

  var_0 scripts\common\anim::anim_single_solo(self, "breach");

  if(self.animname == "alpha3")
    self detach("offhand_vm_clacker_tactical", "tag_accessory_left");

  if(!scripts\engine\utility::flag("breach_finished"))
    scripts\engine\utility::flag_set("breach_finished");
}

breach_gate_nag(var_0) {
  level endon(var_0);
  level waittill("b1_all_clear");
  var_1 = ["dx_vom_b63_heli_unload_guardhouse_210", "dx_vom_b63_heli_unload_guardhouse_220", "dx_vom_pri_heli_unload_guardhouse_230"];
  level.alpha4 thread nag_system(var_0, var_1, 13, 13);
}

breach_gate() {
  wait 3;
  scripts\engine\utility::flag_set("breach_gate");
}

breach_good_vo() {
  wait 2.1;
  level.bravo4 scripts\engine\sp\utility::smart_dialogue("dx_vom_b63_breached_gate_courtyard_20");
  objective_control("reach_main_house");
  var_0 = getEnt("infil_caged_dog", "targetname");
  thread dog_kill_and_main_house_vo(var_0);
  wait 0.15;
  scripts\engine\utility::flag_set("allies_front_door_setup");
}

dog_kill_and_main_house_vo(var_0) {
  scripts\engine\utility::flag_wait("set_yard_targets");
  level.price scripts\engine\utility::delaythread(3, scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter, "dx_vom_pri_breached_gate_courtyard_120");
  var_1 = undefined;

  if(isalive(var_0))
    var_0 waittill("death", var_1);

  if(isDefined(var_1) && var_1 == level.player) {
    wait 1;
    level.player scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_kyle_breached_gate_courtyard_80");
  }

  if(scripts\engine\utility::flag("1f_ambush")) {
    return;
  }
  level endon("1f_ambush");
  wait 5;
  level.bravo5 scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_b62_1st_floor_entry_40");
}

compound_lights_sequence() {
  scripts\engine\utility::flag_wait("allies_front_door_setup");
  var_0 = ["3f_bedroom_light"];
  compound_lights_on(var_0);
  wait 1.8;
  var_0 = ["2f_dataroom_light"];
  compound_lights_on(var_0);
  wait 3;
  setsaveddvar("LKOLRONRNQ", 1500);
  var_0 = ["1f_light"];
  compound_lights_on(var_0);
  wait 3;
  setsaveddvar("LKOLRONRNQ", 400);
}

postspawn_infil_dogs() {
  self endon("death");
  self.allowdeath = 1;
  level.death_origin = self.origin;
  self.noragdoll = 1;
  thread audio_zd30_dog_kill_handler();
  var_0 = scripts\engine\utility::getStruct(self.animname + "_animnode", "targetname");
  waitframe();
  var_0 thread scripts\common\anim::anim_loop_solo(self, "introA_idle", "stop_dog_loop");
  scripts\engine\utility::flag_wait("set_yard_targets");
  thread infil_dog1_watcher();
  level.bravo5 scripts\common\ai::poi_enable(0);
  level.bravo5 ignore_disabled();
  level.bravo5 scripts\engine\sp\utility::set_favoriteenemy(self);
  var_0 notify("stop_dog_loop");
  var_0 scripts\common\anim::anim_single_solo(self, "introA");
  scripts\common\anim::anim_single_solo(self, "introB");
  scripts\common\anim::anim_single_solo(self, "introC");
  level.death_origin = self.origin;
  thread scripts\common\anim::anim_loop_solo(self, "introC_idle");
}

infil_dog1_watcher() {
  level.bravo5 thread dog_is_killed(self);
  self endon("death");

  for(;;) {
    var_0 = distance(level.bravo5.origin, self.origin);

    if(var_0 < 320) {
      level.bravo5 laser_discipline_kill(self);
      break;
    } else
      waitframe();
  }
}

laser_discipline_kill(var_0) {
  scripts\common\ai::set_gunpose("ads");
  wait 0.25;
  self.a.laseron = 1;
  scripts\anim\shared.gsc::updatelaserstatus();
  waitframe();

  if(isalive(var_0))
    magicbullet(self.weapon, self gettagorigin("tag_flash"), var_0 gettagorigin("j_spine4"));

  if(isalive(var_0))
    var_0 scripts\sp\utility::do_damage(var_0.health + 1000, self.origin, self, self, "MOD_RIFLE_BULLET", self.weapon);
}

dog_is_killed(var_0) {
  var_0 scripts\engine\utility::waittill_any("damage", "death");

  if(isalive(var_0))
    var_0 kill();

  thread audio_zd30_dog_kill_handler();
  ignore_enabled();
  wait 0.2;
  self.a.laseron = 0;
  scripts\anim\shared.gsc::updatelaserstatus();
  wait 0.5;
  scripts\common\ai::reset_gunpose();
}

audio_zd30_dog_kill_handler() {
  thread scripts\engine\utility::play_sound_in_space("bullet_large_flesh_torso_npc_to_npc", level.death_origin);
  scripts\engine\utility::play_sound_in_space("anml_dog_death", level.death_origin);
}

infil_spawn_building1_runner() {
  var_0 = scripts\engine\sp\utility::array_spawn_noteworthy("building1_runner");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.animname) && var_2.animname == "building1_runner") {
      var_2 thread b1_runner_action();
      continue;
    }

    var_2.animname = "building1_girl";
    var_2.allowdeath = 0;
    var_2.no_friendly_fire_fail = 1;
    var_2.skipdeathanim = 1;
    var_2.isinposition = "no";
    var_2.nothreat = 0;
    var_2 scripts\common\ai::magic_bullet_shield();
    var_2 thread b1_girl_action();
  }
}

b1_open_door() {
  if(!scripts\engine\utility::flag("scriptables_ready"))
    scripts\engine\utility::flag_wait("scriptables_ready");

  var_0 = scripts\sp\door::get_interactive_door("building1_door");
  var_0 scripts\engine\utility::ent_flag_wait("initialized");
  var_0 scripts\sp\door::door_open_completely(level.alpha6, 0.2);
  var_0 scripts\sp\door::remove_open_ability();
  var_0 scripts\game\sp\door::remove_door_snake_cam_ability();
  level notify("building1_door_open");
}

b1_runner_action() {
  self.goalradius = 0;
  self.grenadeammo = 0;
  self.allowdeath = 1;
  self.balwayscoverexposed = 1;
  self._blackboard.forcestrafe = 1;
  self.canbeflashbanged = 1;
  self getenemyinfo(level.player);
  scripts\engine\sp\utility::set_favoriteenemy(level.player);
  thread b1_runner_watcher();
  level.b1_runner = self;
  self endon("death");
  var_0 = scripts\engine\utility::getStruct("b1_girl_animnode", "targetname");
  var_0 scripts\common\anim::anim_first_frame_solo(self, "b1_scared");
  level waittill("sledge_impact");
  var_0 scripts\common\anim::anim_single_solo(self, "b1_scared");
  self setgoalpos(self.origin);
  ignore_disabled();
  wait 0.5;
  var_1 = scripts\engine\utility::getStructArray("b1_fire_nodes", "targetname");
  var_2 = 0;
  var_3 = 5;
  var_4 = scripts\engine\utility::spawn_script_origin();
  var_5 = cos(65);

  for(;;) {
    var_6 = randomintrange(0, 3);
    var_7 = var_1[var_6];

    if(self cansee(level.player)) {
      if(!scripts\engine\utility::flag("b1_runner_start")) {
        self clearentitytarget();
        scripts\engine\utility::flag_set("b1_runner_start");
        self setgoalnode(getnode("building1_runner_start", "targetname"));
      }

      break;
    } else if(scripts\engine\utility::within_fov(self getEye(), self.angles, var_7.origin, var_5)) {
      if(!scripts\engine\utility::flag("b1_runner_start")) {
        self setentitytarget(var_4);
        var_4.origin = var_7.origin;
      }

      if(!isDefined(self.enemyflashed))
        self shoot(0.9, var_7.origin);

      var_2++;
      wait 0.1;
    }

    if(var_2 >= var_3) {
      var_8 = randomintrange(5, 8);
      var_9 = randomfloatrange(0.75, 1.3);
      var_2 = 0;
      var_3 = var_8;
      wait(var_9);
      continue;
    }

    waitframe();
  }
}

b1_runner_watcher() {
  scripts\engine\utility::waittill_any_ents(self, "death", level, "player_in_building1_back_room");
  scripts\engine\utility::flag_set("b1_runner_dead");

  if(isalive(self))
    self kill();
}

b1_girl_action() {
  var_0 = scripts\engine\utility::getStruct("b1_girl_animnode", "targetname");
  level.alpha5 thread alpha5_secure(var_0);
  level.alpha6 thread b1_mom_child_nag("building1_mom_dead");
  thread b1_girl_damage_watcher(var_0);
  level endon("b1_girl_dead");
  var_0 scripts\common\anim::anim_first_frame_solo(self, "b1_scared");
  level waittill("sledge_impact");
  var_0 notify("stop_first_frame");
  thread b1_girl_ads_watcher(var_0);
  var_0 scripts\common\anim::anim_single_solo(self, "b1_scared");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "b1_scared_idle", "stop_loop_" + self.animname);
  self.nothreat = 1;
  scripts\engine\utility::flag_set("b1_girl_ready");
  scripts\engine\utility::flag_wait("player_in_1st_building");
  level notify("start_b1_secure");
  var_0 notify("stop_loop_" + self.animname);
  scripts\engine\sp\utility::anim_stopanimScripted();
  childthread waittill_player_leaves_b1();
  self.ziptie = scripts\engine\sp\utility::spawn_anim_model("ziptie");
  var_0 scripts\common\anim::anim_single([self, self.ziptie], "b1_secure");
  var_0 thread scripts\common\anim::anim_loop([self, self.ziptie], "b1_secure_idle");
}

waittill_player_leaves_b1() {
  scripts\engine\utility::flag_wait("building1_mom_dead");
  var_0 = squared(100);
  var_1 = (-270, -697, 20);

  for(;;) {
    var_2 = distance2dsquared(level.player.origin, var_1);

    if(var_2 <= var_0) {
      break;
    }

    waitframe();
  }

  scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aqf1_heli_unload_guardhouse_144");
}

b1_girl_damage_watcher(var_0) {
  level endon("civs_moved_to_main_house");

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(isDefined(var_10) && var_10.basename == "flash") {
      continue;
    }
    break;
  }

  scripts\engine\utility::flag_set("b1_girl_dead");

  if(isDefined(self.ziptie))
    self.ziptie delete();

  if(isDefined(self.nothreat) && self.nothreat) {
    thread scripts\sp\hud_util::fade_out(0);
    self stopsounds();
    var_11 = [48, 49];

    if(self.isinposition == "secured")
      var_11 = [25, 26];

    var_12 = scripts\engine\utility::array_randomize(var_11);
    var_13 = var_12[0];
    scripts\sp\player_death::set_custom_death_quote(var_13);
    scripts\sp\utility::missionfailedwrapper();
  } else if(self.isinposition == "yes") {
    thread unarmed_enemy_check();
    self.noragdoll = 1;
    self.skipdeathanim = 1;
    var_0 scripts\common\anim::anim_single_solo(self, "b1_settle_death");
    var_0 scripts\common\anim::anim_last_frame_solo(self, "b1_settle_death");
  } else {
    thread unarmed_enemy_check();
    scripts\common\ai::stop_magic_bullet_shield();
    self.allowdeath = 1;
    self kill();
  }
}

b1_girl_ads_watcher(var_0) {
  level endon("b1_girl_dead");
  level endon("start_b1_secure");
  level scripts\engine\utility::waittill_multiple("b1_runner_dead", "building1_guy_dead");
  scripts\engine\utility::flag_wait("b1_girl_ready");
  var_0 notify("stop_loop_" + self.animname);
  var_0 scripts\common\anim::anim_single_solo(self, "b1_settle");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "b1_settle_idle", "stop_loop_" + self.animname);
  var_1 = 0;
  var_2 = cos(18);
  var_3 = cos(28);

  for(;;) {
    if(in_player_fov(var_2)) {
      var_0 notify("stop_loop_" + self.animname);
      self notify("scared_reaction_started");
      var_0 scripts\common\anim::anim_single_solo(self, "b1_settle_react");
      var_1++;

      if(!in_player_fov(var_2)) {
        var_0 scripts\common\anim::anim_single_solo(self, "b1_settle_react_back");
        var_0 thread scripts\common\anim::anim_loop_solo(self, "b1_settle_idle", "stop_loop_" + self.animname);
      } else {
        var_0 thread scripts\common\anim::anim_loop_solo(self, "b1_settle_react_idle", "stop_loop_" + self.animname);

        while(in_player_fov(var_3))
          waitframe();

        wait 1.5;
        var_0 notify("stop_loop_" + self.animname);
        var_0 scripts\common\anim::anim_single_solo(self, "b1_settle_react_back");
        var_0 thread scripts\common\anim::anim_loop_solo(self, "b1_settle_idle", "stop_loop_" + self.animname);
      }

      if(var_1 >= 3) {
        var_4 = randomfloatrange(4, 6);
        wait(var_4);
      }
    }

    waitframe();
  }
}

alpha5_secure(var_0) {
  thread alpha5_b1_girl_is_dead(var_0);
  thread alpha5_b1_girl_secure(var_0);
  level.alpha6 thread b1_moveup_alpha6();
}

alpha5_b1_girl_is_dead(var_0) {
  level endon("b1_girl_secure");
  scripts\engine\utility::flag_wait("b1_girl_dead");
  scripts\engine\utility::flag_wait("player_in_1st_building");
  var_0 notify("stop_loop_cleanup");
  scripts\engine\sp\utility::anim_stopanimScripted();
  var_0 scripts\sp\anim::anim_reach_and_arrive(self, "b1_secure_idle", undefined, "exposed");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "b1_secure_idle", "stop_loop_cleanup");

  if(!scripts\engine\utility::flag("breach_gate"))
    thread lookat_random("breach_gate");

  level notify("start_b1_mom_nag");
}

alpha5_b1_girl_secure(var_0) {
  level endon("b1_girl_dead");
  level waittill("start_b1_secure");
  var_0 scripts\common\anim::anim_single_solo(self, "b1_secure");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "b1_secure_idle", "stop_loop_cleanup");
  level notify("b1_girl_secure");

  if(!scripts\engine\utility::flag("breach_gate"))
    thread lookat_random("breach_gate");

  level notify("start_b1_mom_nag");
}

b1_mom_child_nag(var_0) {
  level endon(var_0);
  level waittill("start_b1_mom_nag");
  var_1 = getnode("dad_node", "targetname");
  var_2 = ["dx_vom_b26_heli_unload_guardhouse_94", "dx_vom_b26_heli_unload_guardhouse_95"];

  for(;;) {
    scripts\engine\utility::flag_wait("player_inside_b1");
    nag_system("player_inside_b1", var_2, 10, 13, level.player, var_1, 1);
  }
}

overwatch_setup() {
  level endon("3f_cleared");
  var_0 = getnode(self.target, "targetname");
  self forceteleport(var_0.origin, var_0.angles);
  self setgoalnode(var_0);
  self.a.laseron = 1;
  scripts\anim\shared.gsc::updatelaserstatus();
  var_1 = scripts\engine\utility::getStruct("overwatch_poi", "targetname");
  scripts\common\ai::poi_enable(1, var_1);
  scripts\engine\utility::flag_wait_any("power_is_off", "player_at_2f_stairs", "player_at_3f_stairs");
  self.a.laseron = 0;
  scripts\anim\shared.gsc::updatelaserstatus();
}

setup_bravo_roof() {
  var_0 = [level.price, level.bravo2];
  var_1 = scripts\engine\utility::getStruct("breach_animnode", "targetname");

  foreach(var_3 in var_0)
  var_1 thread scripts\common\anim::anim_loop_solo(var_3, "heli_intro_idle", "stop_heli_intro_" + var_3.animname);
}

b1_flashbang_watcher() {
  level endon("breach_gate");
  var_0 = getEnt("b1_flash_trigger", "targetname");
  var_0 setCanDamage(1);

  for(;;) {
    var_0 waittill("flashbang", var_1, var_2, var_3, var_4);

    if(isDefined(level.b1_guy) && isalive(level.b1_guy) && isDefined(level.b1_guy.canbeflashbanged))
      level.b1_guy thread force_flash_enemy();

    if(isDefined(level.b1_runner) && isalive(level.b1_runner) && isDefined(level.b1_runner.canbeflashbanged))
      level.b1_runner thread force_flash_enemy();
  }
}

force_flash_enemy() {
  self endon("death");
  self.enemyflashed = 1;
  scripts\engine\sp\utility::anim_stopanimScripted();
  waitframe();
  scripts\anim\combat_utility.gsc::flashbangstart(3);
  wait 3;
  self.enemyflashed = undefined;
}

b1_setup() {
  var_0 = scripts\engine\sp\utility::array_spawn_noteworthy("building1");

  foreach(var_2 in var_0) {
    if(var_2.animname == "building1_guy") {
      var_2 thread b1_guy_setup();
      continue;
    }

    if(var_2.animname == "building1_mom") {
      var_2 thread b1_mom_setup();
      thread b1_back_room_vo(var_2);
      continue;
    }

    if(var_2.animname == "building1_child")
      var_2 thread b1_child_fail();
  }

  thread tv_image();
  scripts\engine\utility::flag_wait_all("b1_runner_dead", "building1_guy_dead", "building1_mom_dead");
  scripts\engine\utility::flag_set("moveup_building1");
  thread b1_clear_vo();
}

b1_guy_setup() {
  thread scripts\engine\sp\utility::flag_on_death("building1_guy_dead");
  self endon("death");
  self.goalradius = 45;
  self.grenadeammo = 0;
  self.accuracy = 0.9;
  self.allowdeath = 1;
  self.balwayscoverexposed = 1;
  self.canbeflashbanged = undefined;
  scripts\engine\sp\utility::disable_surprise();
  level.b1_guy = self;
  var_0 = scripts\engine\utility::getStruct("b1_girl_animnode", "targetname");
  var_0 scripts\common\anim::anim_first_frame_solo(self, "b1_scared");
  scripts\engine\utility::flag_wait("b1_start_2nd_guy");
  wait 0.3;
  self getenemyinfo(level.player);
  var_0 notify("stop_first_frame");
  self.canbeflashbanged = 1;
  childthread cut_short_if_player_enters_quickly();
  var_0 scripts\common\anim::anim_single_solo(self, "b1_scared");
  self setgoalpos(self.origin);
}

cut_short_if_player_enters_quickly() {
  wait 1;
  scripts\engine\utility::flag_wait("player_in_1st_building");
  scripts\engine\sp\utility::anim_stopanimScripted();
}

b1_mom_setup() {
  self.noragdoll = 1;
  self.skipdeathanim = 1;
  self.dontmelee = 1;
  self.diequietly = 1;
  self.disablepistol = 1;
  self.enemywasmeleed = 0;
  self.grenadeammo = 0;
  self.goalradius = 0;
  self.mydeathanime = "protect_death_altA";
  scripts\sp\utility::context_melee_allow(0);
  scripts\common\ai::magic_bullet_shield();
  scripts\engine\sp\utility::disable_surprise();
  var_0 = scripts\sp\utility::make_weapon("iw8_pi_golf21");
  scripts\anim\shared.gsc::forceuseweapon(var_0, "primary");
  waitframe();
  var_1 = [self, level.b1_child];
  var_2 = scripts\engine\utility::getStruct("b1_animnode", "targetname");
  var_2 thread scripts\common\anim::anim_loop_solo(self, "protect_idle", "b1_mom_stop_loop");
  var_2 thread scripts\common\anim::anim_loop_solo(level.b1_child, "protect_idle", "b1_child_stop_loop");
  thread b1_mom_damage_tracker(var_2, var_1);
  scripts\engine\utility::flag_wait_any("player_in_building1_back_room", "mom_isflashed");
  thread b1_mom_vo();
  thread b1_mom_action(var_2);
  level.b1_child thread b1_child_action(var_2);
}

b1_mom_vo() {
  scripts\engine\utility::flag_wait("building1_mom_dead");
  self stopsounds();
}

b1_mom_damage_tracker(var_0, var_1) {
  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(isDefined(var_6) && var_6 == "MOD_IMPACT")
      continue;
    else {
      if(isDefined(var_11) && var_11.basename == "flash") {
        scripts\engine\utility::flag_set("mom_isflashed");
        var_0 notify("b1_mom_stop_loop");
        scripts\engine\sp\utility::anim_stopanimScripted();
        self forceteleport(var_0.origin, var_0.angles);
        thread b1_mom_flashed();
        continue;
      }

      break;
    }
  }

  if(isDefined(var_6) && var_6 == "MOD_MELEE")
    self.enemywasmeleed = 1;

  self actoraimassistoff();

  if(scripts\engine\utility::is_equal(self.mydeathanime, "protect_death_altA")) {
    var_0 notify("b1_mom_stop_loop");
    scripts\engine\utility::flag_set("building1_mom_dead");
    scripts\engine\sp\utility::anim_stopanimScripted();
    var_0 scripts\common\anim::anim_single_solo(self, "protect_death_altA");
    var_0 scripts\common\anim::anim_first_frame_solo(self, "protect_death_altB");

    if(!level.b1_child.isready)
      waitframe();

    var_0 notify("stop_first_frame");
    var_0 notify("b1_child_stop_loop");
    level.b1_child thread animation_single_then_loop(var_0);
    var_0 scripts\common\anim::anim_single_solo(self, "protect_death_altB");
    var_0 thread scripts\common\anim::anim_loop_solo(self, "protect_death_idle", "b1_child_stop_loop");
  } else {
    var_0 notify("b1_mom_stop_loop");
    var_0 notify("b1_child_stop_loop");
    scripts\engine\utility::flag_set("building1_mom_dead");
    scripts\engine\sp\utility::anim_stopanimScripted();

    if(!level.b1_child.isready)
      waitframe();

    var_0 scripts\common\anim::anim_single(var_1, "protect_death");
    var_0 thread scripts\common\anim::anim_loop(var_1, "protect_death_idle", "b1_child_stop_loop");
  }

  if(!scripts\engine\utility::flag("breacher_set"))
    level.alpha3 scripts\engine\sp\utility::anim_stopanimScripted();

  var_0 waittill("b1_child_stop_loop");
  scripts\common\ai::stop_magic_bullet_shield();
  self delete();
}

animation_single_then_loop(var_0) {
  var_0 scripts\common\anim::anim_single_solo(self, "protect_death");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "protect_death_idle", "b1_child_stop_loop");
}

b1_mom_action(var_0) {
  level endon("building1_mom_dead");

  if(!scripts\engine\utility::flag("mom_isflashed")) {
    var_0 notify("b1_mom_stop_loop");
    var_0 scripts\common\anim::anim_single_solo(self, "protect_react");
  }

  self setgoalpos(self.origin);
  self getenemyinfo(level.player);
  scripts\engine\sp\utility::set_favoriteenemy(level.player);
}

b1_mom_flashed() {
  level endon("building1_mom_dead");
  waitframe();
  self.mydeathanime = "protect_death";
  scripts\anim\combat_utility.gsc::flashbangstart(3);
  self getenemyinfo(level.player);
}

b1_child_action(var_0) {
  if(scripts\engine\utility::flag("mom_isflashed")) {
    scripts\engine\sp\utility::anim_stopanimScripted();
    var_0 notify("b1_child_stop_loop");
    var_0 scripts\common\anim::anim_single_solo(self, "protect_react");
    var_0 thread scripts\common\anim::anim_loop_solo(self, "protect_react_idle", "b1_child_stop_loop");
    self.isready = 1;
  } else {
    var_0 notify("b1_child_stop_loop");
    var_0 scripts\common\anim::anim_single_solo(self, "protect_react");
    var_0 thread scripts\common\anim::anim_loop_solo(self, "protect_react_idle", "b1_child_stop_loop");
    self.isready = 1;
  }
}

b1_child_fail() {
  level.b1_child = self;
  self.allowdeath = 1;
  self.noragdoll = 1;
  self.skipdeathanim = 1;
  self.isready = 0;
  scripts\common\ai::magic_bullet_shield();
  self setModel("body_civ_syrkistan_boy_4_1");
  level endon("civs_moved_to_main_house");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_9) && var_9.basename == "flash") {
      continue;
    }
    break;
  }

  thread scripts\sp\hud_util::fade_out(0);
  var_10 = [22, 23];
  var_11 = scripts\engine\utility::array_randomize(var_10);
  var_12 = var_11[0];
  scripts\sp\player_death::set_custom_death_quote(var_12);
  scripts\sp\utility::missionfailedwrapper();
}

b1_moveup_alpha6() {
  scripts\engine\utility::flag_wait("player_in_1st_building");
  scripts\engine\utility::flag_set("building1_guy_moveup");
  wait 2.5;
  var_0 = getnode(self.animname + "_b1_node", "targetname");
  self setgoalnode(var_0);

  if(!scripts\engine\utility::flag("building1_guy_dead")) {
    scripts\engine\sp\utility::disable_surprise();
    scripts\engine\utility::set_movement_speed(80);
    ignore_disabled();
    wait 0.3;
    scripts\common\ai::set_gunpose("ads");

    if(!scripts\engine\utility::flag("building1_guy_dead"))
      thread kill_b1_guy();

    scripts\engine\utility::flag_wait("building1_guy_dead");
    ignore_enabled();
    scripts\engine\sp\utility::enable_dontevershoot();
    wait 0.3;
    scripts\common\ai::set_gunpose("gun_down");
  }

  scripts\engine\utility::flag_wait("player_in_building1_back_room");
  var_1 = getnode(var_0.target, "targetname");
  self setgoalnode(var_1);
  scripts\engine\utility::flag_wait("moveup_building1");
  scripts\engine\utility::flag_clear("player_in_1st_building");
  waitframe();
  scripts\engine\utility::flag_wait("player_in_1st_building");
  scripts\engine\utility::set_movement_speed(80);
  thread b1_alpha6_lookat();
  var_2 = getnode(var_1.target, "targetname");
  self setgoalnode(var_2);
}

kill_b1_guy() {
  level endon("building1_guy_dead");

  while(!scripts\engine\trace::ray_trace_passed(self gettagorigin("tag_eye"), level.b1_guy gettagorigin("tag_eye"), [self, level.b1_guy]))
    wait 0.1;

  scripts\engine\sp\utility::disable_dontevershoot();
  self getenemyinfo(level.b1_guy);
  scripts\engine\sp\utility::set_favoriteenemy(level.b1_guy);
  self waittill("weapon_fired");
  wait 0.2;

  if(isalive(level.b1_guy))
    level.b1_guy kill();
}

b1_alpha5_lookat() {
  level endon("1f_ambush");
  thread b1_alpha5_vo();
  var_0 = cos(25);

  for(;;) {
    var_1 = distance(level.player.origin, self.origin);

    if(var_1 < 185 && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self gettagorigin("j_head"), var_0) && scripts\engine\trace::ray_trace_passed(level.player getEye(), self gettagorigin("j_head"), [self, level.player])) {
      level notify("b1_alpha5_vo");
      break;
    }

    waitframe();
  }

  scripts\common\utility::lookatentity(level.player);
  wait 2;
  scripts\common\utility::lookatentity();
}

b1_alpha5_vo() {
  level endon("b1_alpha6_vo");
  level waittill("b1_alpha5_vo");
  wait 0.2;
}

b1_alpha6_lookat() {
  level endon("1f_ambush");
  thread b1_alpha6_vo();

  for(;;) {
    var_0 = distance(level.player.origin, self.origin);
    var_1 = cos(25);

    if(var_0 < 185 && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self gettagorigin("j_head"), var_1) && scripts\engine\trace::ray_trace_passed(level.player getEye(), self gettagorigin("j_head"), [self, level.player])) {
      level notify("b1_alpha6_vo");
      break;
    }

    waitframe();
  }

  scripts\common\utility::lookatentity(level.player);
  wait 2;
  scripts\common\utility::lookatentity();
}

b1_alpha6_vo() {
  level endon("b1_alpha5_vo");
  level waittill("b1_alpha6_vo");
  wait 0.2;
}

tv_image() {
  setsaveddvar("MMRNLMPPLT", "0");
  cinematicingameloop("sp_embassy_soccer_tv", 1);
}

b1_back_room_vo(var_0) {
  b1_back_room_approach_vo(var_0);
  b1_child_reaction_vo();
}

b1_back_room_approach_vo(var_0) {
  level endon("player_in_building1_back_room");
  scripts\engine\utility::flag_wait("player_in_1st_building");

  for(;;) {
    var_0 scripts\engine\utility::delaythread(0.35, scripts\engine\sp\utility::smart_dialogue, "dx_vom_aqf1_heli_unload_guardhouse_110");
    level.b1_child scripts\engine\sp\utility::smart_dialogue("dx_vom_ccm1_heli_unload_guardhouse_132");
  }
}

b1_child_reaction_vo() {
  level endon("building1_mom_dead");
  wait(0.3 + lookupsoundlength("dx_vom_ccm1_heli_unload_guardhouse_133") / 1000);
}

b1_clear_vo() {
  wait 1;
  level.player scripts\engine\sp\utility::set_player_demeanor("relaxed");
  wait(scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::wait_combat_cooldown(0.3, 1));

  while(level.player get_is_looking_at(level.b1_child, undefined, "j_head"))
    waitframe();

  objective_control("breach_scene");
  wait 0.1;
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_3rd_floor_hostage_50");
  wait 0.6;
  level.alpha5 scripts\engine\sp\utility::smart_dialogue("dx_vom_b26_heli_unload_guardhouse_194");
  level notify("b1_all_clear");
}

teleport_bravo_midway() {
  var_0 = scripts\engine\utility::getStruct("breach_animnode", "targetname");
  var_1 = [level.price, level.bravo4, level.bravo5];

  foreach(var_3 in var_1) {
    var_0 notify("stop_heli_intro_" + var_3.animname);
    var_3 scripts\engine\sp\utility::anim_stopanimScripted();
    var_3 thread bravo_midway_anims();
  }

  var_1 = [level.bravo1, level.bravo2];

  foreach(var_3 in var_1) {
    var_0 notify("stop_heli_intro_" + var_3.animname);
    var_3 scripts\engine\sp\utility::anim_stopanimScripted();
    var_6 = getnode(var_3.animname + "_compound_setup", "targetname");
    var_3 forceteleport(var_6.origin, var_6.angles);
    var_3 setgoalnode(var_6);
    var_3 scripts\engine\sp\utility::set_goal_radius(0);
  }
}

bravo_midway_anims() {
  var_0 = getnode(self.animname + "_approach_compound", "targetname");
  self setgoalnode(var_0);
  self forceteleport(var_0.origin, var_0.angles);
}

postspawn_1f_runner() {
  self endon("death");
  level.runner_1f = self;
  self.iskilled = 0;
  self.allowdeath = 0;
  self.mydeathanime = undefined;
  self.dontmelee = 1;
  self.goalradius = 0;
  self.enemyflashed = undefined;
  scripts\sp\utility::context_melee_allow(0);
  scripts\common\ai::magic_bullet_shield();
  thread scripts\engine\sp\utility::flag_on_death("1f_runner_dead");
  self actoraimassistoff();
  var_0 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
  scripts\anim\shared.gsc::forceuseweapon(var_0, "primary");
  var_1 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  var_1 scripts\common\anim::anim_first_frame_solo(self, "1f_civ_run");
  var_2 = cos(70);

  for(;;) {
    if(scripts\engine\utility::flag("1f_runner_start")) {
      break;
    } else if(in_player_fov(var_2)) {
      break;
    }

    waitframe();
  }

  thread runner_temp_death(var_1);
  thread runner_flashbang_watcher();
  self.allowdeath = 1;
  var_1 notify("stop_first_frame");
  var_1 scripts\common\anim::anim_single_solo(self, "1f_civ_run");
  var_3 = distance(level.player.origin, self.origin);

  if(var_3 < 120) {
    self.unarmed = 0;
    var_1 scripts\common\anim::anim_single_solo(self, "1f_civ_sceneA");
    self setgoalpos(self.origin);
    self getenemyinfo(level.player);
  } else {
    var_1 scripts\common\anim::anim_single_solo(self, "1f_civ_sceneB");
    var_1 thread scripts\common\anim::anim_loop_solo(self, "1f_civ_sceneB_idle", "stop_civ04_loop");
    scripts\engine\utility::flag_wait("compound_side_door_breach");

    for(;;) {
      if(scripts\engine\sp\utility::player_looking_at(self gettagorigin("j_head")) || scripts\engine\utility::flag("player_in_1f_back_room") || self cansee(level.player)) {
        break;
      } else
        waitframe();
    }

    self.unarmed = 0;
    var_1 notify("stop_civ04_loop");
    var_1 scripts\common\anim::anim_single_solo(self, "1f_civ_sceneC");
    self.mydeathanime = "1f_civ_sceneC_death";
    var_1 thread scripts\common\anim::anim_loop_solo(self, "1f_civ_sceneC_idle");
  }

  wait 0.2;
  self.accuracy = 0.9;
}

runner_flashbang_watcher() {
  self endon("death");
  var_0 = getEnt("1f_backroom_flash_trigger", "targetname");
  var_0 setCanDamage(1);

  for(;;) {
    var_0 waittill("flashbang", var_1, var_2, var_3, var_4);
    thread turn_off_firing_while_flashed();
  }
}

turn_off_firing_while_flashed() {
  self endon("death");
  self notify("enemy_is_flashed");
  self endon("enemy_is_flashed");
  self.enemyflashed = 1;
  wait 3;
  self.enemyflashed = undefined;
}

runner_temp_death(var_0, var_1) {
  self.allowdeath = 0;

  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);

    if(isDefined(var_11) && var_11.basename == "flash") {
      continue;
    }
    break;
  }

  self.iskilled = 1;
  self stopsounds();
  thread unarmed_enemy_check();

  if(isDefined(self.mydeathanime)) {
    self.diequietly = 1;
    self.allowdeath = 0;

    if(self.mydeathanime == "1f_civ_sceneA_death" || self.mydeathanime == "1f_civ_sceneB_death") {
      self.noragdoll = undefined;
      self.skipdeathanim = 1;
      var_0 scripts\common\anim::anim_single_solo(self, self.mydeathanime);
    } else {
      self.noragdoll = 1;
      self.skipdeathanim = undefined;
      self.deathanim = scripts\engine\utility::getanim(self.mydeathanime);
    }
  }

  self.allowdeath = 1;
  scripts\common\ai::stop_magic_bullet_shield();
  self kill();
}

side_breach_1f_vo() {
  scripts\engine\utility::flag_wait("compound_side_door_breach");

  if(isalive(level.runner_1f)) {
    var_0 = level.runner_1f scripts\engine\utility::waittill_any_return("damage", "civ04_started_yelling") == "damage";

    if(!var_0) {
      var_1 = lookupsoundlength("dx_vom_cvf1_1st_floor_interior_237") / 1000;
      level.runner_1f scripts\engine\utility::waittill_notify_or_timeout("damage", var_1);
    }
  } else
    wait 1;

  wait 0.5;
  level scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_b64_1st_floor_interior_230");
}

setup_1f_main_door_arrival() {
  var_0 = [level.price, level.bravo4, level.bravo5];
  var_1 = scripts\engine\utility::getStruct("1f_animnode", "targetname");

  foreach(var_3 in var_0) {
    var_3 thread approach_fd_and_idle(var_1);
    var_3.a.laseron = 1;
    var_3 scripts\anim\shared.gsc::updatelaserstatus();
  }

  thread setup_1f_main_door(var_1);
}

approach_fd_and_idle(var_0) {
  var_0 scripts\sp\anim::anim_reach_solo(self, "door_arrival");

  if(self.animname == "bravo5") {
    self.a.laseron = 0;
    scripts\anim\shared.gsc::updatelaserstatus();
  }

  var_0 scripts\common\anim::anim_single_solo(self, "door_arrival");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "door_arrival_idle", "stop_door_arrival_idle_" + self.animname);

  if(self.animname == "bravo5") {
    scripts\engine\utility::flag_set("bravo5_in_position");
    self.a.laseron = 0;
    scripts\anim\shared.gsc::updatelaserstatus();
  } else {
    self.a.laseron = 0;
    scripts\anim\shared.gsc::updatelaserstatus();
  }

  var_0 notify(self.animname + "_fd_ready");
}

setup_1f_main_door(var_0) {
  thread clip_delete("1f_main_door_clip", "main_door_clip");
  thread clip_delete("1f_hallway_midway_clip", "power_is_off");
  thread clip_delete("1f_hallway_end_curve", "remove_1f_hallway_clip");
  thread clip_delete("1f_hallway_end_clip", "power_is_off");
  var_0 scripts\engine\utility::waittill_multiple("price_fd_ready", "bravo4_fd_ready");

  if(!scripts\engine\utility::flag("1f_ambush"))
    thread main_door_nag("main_door_nag_end");

  scripts\engine\utility::flag_wait("1f_ambush");
  thread ambush_1f_vo();
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  scripts\sp\player::player_movement_state("cqb");
  thread spawn_1f_civ_left();
  thread scripts\engine\sp\utility::autosave_now();
  scripts\engine\utility::delaythread(2, ::objective_control, "locate_wolf");
  level notify("main_door_nag_end");
  var_1 = [level.price, level.bravo4];

  foreach(var_3 in var_1)
  var_0 notify("stop_door_arrival_idle_" + var_3.animname);

  var_5 = door_guy_spawn();
  level.bravo4 thread hallway_1f_nag("1f_runner_start");
  var_1 = [level.price, level.bravo4, var_5];
  level.maindoor = getscriptablearray("compound_door", "targetname");
  level.maindoorcleanup = [];
  var_0 thread anim_scriptable(level.maindoor[0], "main_door_open");

  foreach(var_3 in var_1)
  var_3 thread door_react_anim(var_0);

  thread open_1f_runner_door();
  scripts\engine\utility::flag_wait("1f_runner_start");
  thread clip_delete("1f_price_door_wait_clip", "price_infront_of_door");
  var_1 = [level.price, level.bravo5];
  var_1 thread allies_nvg_on(0);
  level.bravo5 bravo5_anim_check(var_0);
  var_0 notify("stop_loop_react_idle");
  var_0 thread scripts\common\anim::anim_single_solo(level.bravo5, "door_react_exit");
  var_0 scripts\common\anim::anim_single_solo(level.price, "door_react_exit");

  if(!scripts\engine\utility::flag("player_in_1f_back_room")) {
    level.price setgoalpos(level.price.origin);
    level.price.uprightcqbidle = 1;
    level.price.script_pushable = 0;
  }

  level.price scripts\common\ai::set_gunpose("gun_down");
  level notify("price_infront_of_door");
}

setup_main_door_jumpto_damage() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  level.maindoor = getscriptablearray("compound_door", "targetname");
  level.maindoor[0] thread maindoor_damage_watcher();
}

maindoor_damage_watcher() {
  level endon("disable_light_fx");
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(isDefined(var_4) && var_4 == "MOD_MELEE")
      continue;
    else if(isDefined(var_9) && var_9.basename != "flash") {
      if(isDefined(var_1) && (isPlayer(var_1) || var_1 == level.bravo4))
        thread play_light_fx_on_door(var_3);
    }
  }
}

play_light_fx_on_door(var_0) {
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0 + (0, 1.4, 0), (0, 0, 0));
  var_1 linkTo(self, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_door_wooden_panel_rl_01_cine"), var_1, "tag_origin");
  level scripts\engine\utility::waittill_any_timeout(4, "disable_light_fx");
  killfxontag(scripts\engine\utility::getfx("vfx_door_wooden_panel_rl_01_cine"), var_1, "tag_origin");
  waitframe();
  var_1 delete();
}

ambush_1f_vo() {
  wait 1;
  level.price scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_pri_1st_floor_entry_20");
}

player_notes_1f_civs() {
  level endon("remove_1f_hallway_clip");
  self endon("death");

  while(!level.player get_is_looking_at(self, 220, "j_head"))
    waitframe();

  wait 0.2;
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_1st_floor_interior_150");
  level.overwatch scripts\engine\sp\utility::smart_dialogue("dx_vom_s11_1st_floor_interior_170");
}

main_door_nag(var_0) {
  level endon(var_0);
  var_1 = ["dx_vom_pri_breached_gate_courtyard_180", "dx_vom_pri_breached_gate_courtyard_200"];
  level.price thread nag_system(var_0, var_1, 10, 13, level.player);
}

door_guy_spawn() {
  var_0 = scripts\engine\sp\utility::spawn_script_noteworthy("1f_door_guy");
  var_0 ignore_enabled();
  var_0.skipdeathanim = 1;
  var_0.noragdoll = 1;
  var_0.diequietly = 1;
  return var_0;
}

bravo5_anim_check(var_0) {
  var_0 notify("stop_door_arrival_idle_" + self.animname);
}

door_react_anim(var_0) {
  var_0 scripts\common\anim::anim_single_solo(self, "door_react");

  if(self.animname == "price")
    var_0 thread scripts\common\anim::anim_loop_solo(self, "door_react_idle", "stop_loop_react_idle");
  else if(self.animname == "bravo4") {
    self notify("bravo4_hallway_nag_start");
    self setgoalpos(self.origin);
    self.uprightcqbidle = 1;
    self.script_pushable = 0;
    thread hallway_1f_poi();
  } else if(self.animname == "bravo5")
    var_0 thread scripts\common\anim::anim_last_frame_solo(self, "door_react");
}

alpha_moveup_post_breach() {
  level.alpha_trailers = [];
  level scripts\engine\utility::waittill_multiple("alpha3_is_ready", "alpha4_is_ready");

  foreach(var_1 in level.alpha_trailers) {
    var_1.nodeidle = getnode(var_1.animname + "_idle_node", "targetname");
    var_1.nodeend = getnode(var_1.animname + "_tea_room_node", "targetname");
  }

  scripts\engine\utility::flag_wait("dog_moveup");
  var_3 = getEnt("compound_moveup_player_check", "targetname");

  while(level.player istouching(var_3))
    waitframe();

  foreach(var_1 in level.alpha_trailers) {
    var_5 = scripts\engine\utility::getStruct("yard_poi2_" + var_1.animname, "targetname");

    if(var_1.animname == "alpha3") {
      var_1 scripts\engine\utility::delaythread(1.5, ::set_goal_node_and_poi, var_1.nodeend, var_5);
      continue;
    }

    var_1 set_goal_node_and_poi(var_1.nodeend, var_5);
  }
}

moveto_midway() {
  if(self.animname == "bravo4") {
    var_0 = scripts\engine\utility::getStruct(self.animname + "_setup_compound", "targetname");
    var_0 scripts\sp\anim::anim_reach_solo(self, "moveup_arrival_idle");
  } else {
    var_0 = scripts\engine\utility::getStruct(self.animname + "_approach_compound", "targetname");
    var_0 scripts\sp\anim::anim_reach_solo(self, "moveup_arrival");
    var_0 scripts\common\anim::anim_single_solo(self, "moveup_arrival");
  }

  thread scripts\common\anim::anim_loop_solo(self, "moveup_arrival_idle", "stop_arrival_idle_" + self.animname);
  scripts\engine\utility::flag_set(self.animname + "_approach_finished");
}

moveto_compound(var_0, var_1) {
  self.disableplayeradsloscheck = 1;

  if(self.animname == "price" || self.animname == "bravo4" || self.animname == "bravo5") {
    if(self.animname == "price")
      wait 0.2;
    else if(self.animname == "bravo5")
      wait 0.6;

    self notify("stop_arrival_idle_" + self.animname);
    var_2 = scripts\engine\utility::getStruct(self.animname + "_setup_compound", "targetname");
    moveto_intro_anim(var_2);
  }

  var_3 = scripts\engine\utility::getStruct(self.animname + "_moveup_compound", "script_noteworthy");
  scripts\sp\anim::anim_reach_cleanup_solo(self);

  if(istrue(var_1))
    thread scripted_movement(var_3, 1);
  else
    thread scripted_movement(var_3);

  if(self.animname == "alpha3" || self.animname == "alpha4") {
    level.alpha_trailers[level.alpha_trailers.size] = self;
    scripts\engine\utility::waittill_any("goal", "goal_reached");
    scripts\common\ai::poi_enable(0);
    level notify(self.animname + "_is_ready");
  } else {
    wait 3;
    self waittillmatch("single anim", "end");
    scripts\common\ai::poi_enable(0);
    scripts\common\ai::enable_arrivals();
    scripts\common\ai::enable_exits();
  }

  if(scripts\engine\utility::flag("compound_side_door_breach"))
    var_0 notify("stop_door_arrival_idle_" + self.animname);

  self.a.laseron = 0;
  scripts\anim\shared.gsc::updatelaserstatus();
  self.disableplayeradsloscheck = 0;

  if(self.animname == "price" || self.animname == "bravo4")
    var_0 notify(self.animname + "_fd_ready");
}

hallway_1f_nag(var_0) {
  level endon(var_0);
  self waittill("bravo4_hallway_nag_start");
  var_1 = ["dx_vom_pri_1st_floor_interior_60", "dx_vom_b63_1st_floor_interior_70"];
  var_2 = scripts\engine\utility::getStruct("1f_hallway_nag_struct", "targetname");
  level.bravo4 thread nag_system(var_0, var_1, 8, 10, var_2);
}

hallway_1f_poi() {
  var_0 = scripts\engine\utility::getStruct("1f_hallway_poi", "targetname");
  scripts\common\ai::poi_enable(1, var_0);
  scripts\engine\utility::flag_wait("player_back_in_hallway");
  scripts\common\ai::poi_enable(0);
}

moveto_intro_anim(var_0) {
  var_0 notify("stop_first_frame");
  var_0 scripts\common\anim::anim_single_solo(self, "moveup_start");
}

open_1f_runner_door() {
  var_0 = scripts\sp\door::double_doors_init_targetname("1f_runner_door");
  var_0 scripts\engine\utility::array_thread(var_0, scripts\game\sp\door::remove_door_snake_cam_ability);
  var_0[0] door_waittill_open(25, "1f_runner_start");
  var_0[0] door_waittill_open(30, "1f_civ_reaction");
}

setup_1f_side_door_arrival() {
  var_0 = [level.bravo1, level.bravo2, level.alpha2];
  var_1 = scripts\engine\utility::getStruct("1f_animnode", "targetname");

  foreach(var_3 in var_0)
  var_3 thread setup_1f_side_door_anim(var_1);
}

setup_1f_side_door_anim(var_0) {
  level endon("compound_side_door_breach");
  var_0 scripts\sp\anim::anim_reach_solo(self, "door_arrival");
  var_0 scripts\common\anim::anim_single_solo(self, "door_arrival");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "door_arrival_idle", "stop_door_arrival_idle_" + self.animname);
}

setup_1f_side_door(var_0) {
  scripts\engine\utility::flag_wait("compound_side_door_breach");
  thread compound_open_side_door();
  var_1 = [level.bravo1, level.bravo2, level.alpha2];

  foreach(var_3 in var_1) {
    var_0 notify("stop_door_arrival_idle_" + var_3.animname);
    var_3 scripts\engine\sp\utility::anim_stopanimScripted();
    var_3 scripts\engine\sp\utility::set_goalRadius(0);
    var_3 thread side_window_moveup();

    if(var_3.animname == "bravo2") {
      if(isDefined(var_3.clackerattached))
        var_3 detach("offhand_vm_clacker_tactical", "tag_accessory_right");
    }
  }
}

side_window_moveup() {
  self endon("death");
  var_0 = scripts\engine\utility::getStruct(self.animname + "_sd_animnode", "targetname");
  var_0 scripts\common\anim::anim_first_frame_solo(self, "1f_windowA");
  scripts\engine\utility::flag_wait("player_in_1f_back_room");
  self enableavoidance(0);

  if(self.animname == "bravo1") {
    wait 1;
    var_0 notify("stop_first_frame");
    scripts\engine\sp\utility::anim_stopanimScripted();
    var_0 thread scripts\common\anim::anim_single_solo(self, "1f_windowA");
    waitframe();
    self setanimrate(scripts\engine\utility::getanim("1f_windowA"), 0.7);
    self waittillmatch("single anim", "end");
    scripts\common\anim::anim_single_solo(self, "1f_windowB");
    thread setup_2f_bravo1();
  } else if(self.animname == "alpha2") {
    var_0 notify("stop_first_frame");
    scripts\engine\sp\utility::anim_stopanimScripted();
    var_0 scripts\common\anim::anim_single_solo(self, "1f_windowA");
    var_1 = spawnStruct();
    var_1.origin = self.origin;
    var_1.angles = self.angles;
    self setgoalpos(self.origin);
    self.a.laseron = 1;
    scripts\anim\shared.gsc::updatelaserstatus();
    var_2 = scripts\engine\utility::getStruct("side_window_poi", "targetname");
    var_3 = spawn("script_origin", var_2.origin);
    side_window_target(var_3, var_2, var_1);
    thread setup_1f_kitchen_scene();
  } else {
    wait 1;
    var_0 notify("stop_first_frame");
    scripts\engine\sp\utility::anim_stopanimScripted();
    var_0 scripts\common\anim::anim_single_solo(self, "1f_windowA");
    scripts\common\anim::anim_single_solo(self, "1f_windowB");
    self waittillmatch("single anim", "end");
    var_0 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
    var_0 thread scripts\common\anim::anim_loop_solo(self, "1f_hallway_open_idle", "stop_loop_hallway");
  }

  self enableavoidance(1);
}

side_window_target(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  var_4 = gettime();
  self setentitytarget(var_0);
  ignore_disabled();

  if(isalive(level.runner_1f) && !istrue(level.runner_1f.iskilled)) {
    var_0 moveTo(level.runner_1f gettagorigin("j_head"), 0.3);
    var_0 linkTo(level.runner_1f, "j_head");
  }

  scripts\engine\utility::delaythread(1, ::side_window_kill_target);

  for(;;) {
    if(istrue(level.runner_1f.iskilled) || !isalive(level.runner_1f)) {
      scripts\common\ai::poi_enable(1, var_1);
      break;
    } else
      waitframe();
  }

  while(gettime() <= var_4 + 3000)
    waitframe();

  scripts\common\ai::poi_enable(0);
  self clearentitytarget();
  ignore_enabled();
  var_0 delete();
  self.a.laseron = 0;
  scripts\anim\shared.gsc::updatelaserstatus();
  level endon("power_is_off");
  var_2 scripts\common\anim::anim_single_solo(self, "1f_windowB");
  scripts\common\anim::anim_single_solo(self, "1f_windowC");
}

side_window_kill_target() {
  while(isalive(level.runner_1f) && !level.runner_1f.iskilled) {
    self shoot(1, level.runner_1f);
    wait 0.2;
    self shoot(1, level.runner_1f);
    level.runner_1f scripts\sp\utility::do_damage(1, self getEye());
    break;
  }
}

waittill_player_looks_at_hallway(var_0) {
  var_0 scripts\common\anim::anim_first_frame_solo(level.bravo4, "1f_hallway");
  level.bravo5 thread bravo5_in_door(var_0);
  level.price thread price_move_midway(var_0);
  level.bravo4 waittill_struct_within_fov("hallway_fov", "player_in_1f_backroom_trigger");
  scripts\engine\utility::flag_set("player_back_in_hallway");
}

bravo5_in_door(var_0) {
  scripts\engine\utility::flag_wait("player_back_in_hallway");
  self.a.laseron = 0;
  scripts\anim\shared.gsc::updatelaserstatus();
  self.goalradius = 0;
  var_1 = scripts\engine\utility::getStruct("1f_tele_bravo5_midway", "targetname");
  self forceteleport(var_1.origin, var_1.angles);
  self setgoalnode(getnode("1f_guard_civs", "targetname"));
  self.uprightcqbidle = 1;
  self.script_pushable = 0;
  scripts\common\ai::set_gunpose("gun_down");
  var_2 = cos(15);

  for(;;) {
    var_3 = distance(level.player.origin, self.origin);

    if(scripts\engine\utility::flag("power_is_off")) {
      break;
    } else if(var_3 < 60 && scripts\engine\utility::within_fov(level.player getEye(), level.player.angles, self gettagorigin("j_head"), var_2)) {
      scripts\common\utility::lookatentity(level.player);
      wait 2;
      scripts\common\utility::lookatentity();
      break;
    } else
      waitframe();
  }
}

price_move_midway(var_0) {
  scripts\engine\sp\utility::anim_stopanimScripted();
  var_1 = getnode("1f_price_midway", "targetname");
  self forceteleport(var_1.origin, var_1.angles);
  self setgoalnode(var_1);
  self.uprightcqbidle = 1;
  self.script_pushable = 0;
  scripts\engine\utility::flag_wait("player_back_in_hallway");
  var_0 scripts\common\anim::anim_single_solo(self, "door_react_moveup");
  self setgoalpos(self.origin);
  self.uprightcqbidle = 1;
  self.script_pushable = 0;
}

compound_open_side_door() {
  var_0 = getEnt("1f_side_door_target", "targetname");
  var_0 playexplosionsound("scn_zd30_side_door_breach", "exp");
  screenshake(level.player.origin, 5, 1, 2, 0.5);
  var_1 = getEnt("compound_door_breach", "targetname");
  var_2 = getEnt("compound_door_breach_clip", "targetname");
  var_2 linkTo(var_1);
  var_1 setModel("door_industrial_metal_sp_01_dmg");
  var_1 rotateYaw(40, 0.2);
}

spawn_1f_civ_jumpto() {
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("1f_civ_left_room");
  var_1 = scripts\engine\utility::getStruct("1f_animnode", "targetname");

  foreach(var_3 in var_0) {
    var_1 thread scripts\common\anim::anim_loop_solo(var_3, "1f_civ_idleB", "stop_loop_" + var_3.animname);
    level.civs[level.civs.size] = var_3;

    if(var_3.animname == "civ03")
      var_3 setModel("body_civ_syrkistan_boy_1_1");
  }
}

spawn_1f_civ_left() {
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("1f_civ_left_room");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.animname == "civ01") {
      var_1["mom"] = var_3;
      continue;
    }

    if(var_3.animname == "civ02") {
      var_1["girl"] = var_3;
      continue;
    }

    if(var_3.animname == "civ03")
      var_1["boy"] = var_3;
  }

  foreach(var_3 in var_0) {
    var_3.allowdeath = 1;
    var_3.health = 10;
    level.civs[level.civs.size] = var_3;

    if(var_3.animname == "civ01") {
      var_3.no_friendly_fire_fail = 1;
      var_3.deathanim = var_3 scripts\engine\utility::getanim("1f_civ_death01");
      var_3.noragdoll = 1;
      var_3 thread civ01_1f_setup();
      continue;
    }

    if(var_3.animname == "civ02") {
      var_3.no_friendly_fire_fail = 1;
      var_3.skipdeathanim = 1;
      var_3 thread civ02_1f_setup();
      continue;
    }

    if(var_3.animname == "civ03") {
      var_3.deathanim = var_3 scripts\engine\utility::getanim("1f_civ_death01");
      var_3.no_friendly_fire_fail = 1;
      var_3.allowdeath = 1;
      var_3.noragdoll = 1;
      var_3 setModel("body_civ_syrkistan_boy_1_1");
      var_3 thread civ03_1f_setup();
    }
  }
}

approach_1f_civ_vo() {
  self endon("death");
  self endon("civ_just_died");
  level endon("1f_civ_reaction");

  for(;;)
    scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf2_1st_floor_interior_73");
}

civ01_1f_setup() {
  self endon("death");
  self endon("civ_just_died");
  level endon("3f_cleared");
  var_0 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "1f_civ_idleA", "stop_loop_" + self.animname);
  thread civ01_deathwatch(var_0);
  thread civ01_death();
  thread approach_1f_civ_vo();
  scripts\engine\utility::flag_wait("1f_civ_reaction");
  thread player_notes_1f_civs();

  for(;;) {
    if(scripts\engine\utility::flag("player_in_left_room")) {
      break;
    } else if(scripts\engine\sp\utility::player_looking_at(self gettagorigin("j_head"))) {
      scripts\engine\utility::flag_set("player_in_left_room");
      break;
    }

    waitframe();
  }

  var_0 notify("stop_loop_" + self.animname);
  var_0 scripts\common\anim::anim_single_solo(self, "1f_civ_react");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "1f_civ_idleB", "stop_loop_" + self.animname);
  var_1 = cos(35);
  var_2 = cos(25);

  for(;;) {
    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self gettagorigin("j_head"), var_1)) {
      if(scripts\engine\sp\utility::player_looking_at(self gettagorigin("j_head")) && level.player scripts\engine\sp\utility::isads()) {
        break;
      } else if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self gettagorigin("j_head"), var_2) && scripts\engine\trace::ray_trace_passed(level.player getEye(), self gettagorigin("j_head"), [self, level.player])) {
        scripts\engine\utility::flag_set("1f_civs_ads");
        break;
      }
    }

    waitframe();
  }

  var_0 notify("stop_loop_" + self.animname);
  var_0 scripts\common\anim::anim_single_solo(self, "1f_civ_ads_react");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "1f_civ_idleB", "stop_loop_" + self.animname);
}

civ01_deathwatch(var_0) {
  self endon("death");
  level endon("3f_cleared");
  scripts\engine\utility::flag_wait_any("civ02_dies", "civ03_dies");
  wait 0.4;
  self notify("civ_just_died");
  var_0 notify("stop_loop_" + self.animname);
  var_0 scripts\common\anim::anim_single_solo(self, "1f_civ_death_react");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "1f_civ_death_react_idle", "stop_loop_" + self.animname);
}

civ01_death() {
  level endon("civs_moved_to_main_house");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_9) && var_9.basename == "flash") {
      continue;
    }
    break;
  }

  scripts\engine\utility::flag_set("civ01_dies");
  thread scripts\sp\hud_util::fade_out(0);
  self stopsounds();
  self kill();
  var_10 = [48, 49];
  var_11 = scripts\engine\utility::array_randomize(var_10);
  var_12 = var_11[0];
  scripts\sp\player_death::set_custom_death_quote(var_12);
  scripts\sp\utility::missionfailedwrapper();
}

civ02_1f_setup() {
  self endon("death");
  self endon("civ_just_died");
  level endon("3f_cleared");
  var_0 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "1f_civ_idleA", "stop_loop_" + self.animname);
  thread civ02_deathwatch(var_0);
  thread civ02_death();
  scripts\engine\utility::flag_wait("1f_civ_reaction");

  for(;;) {
    if(scripts\engine\utility::flag("player_in_left_room")) {
      break;
    } else if(scripts\engine\sp\utility::player_looking_at(self gettagorigin("j_head")))
      scripts\engine\utility::flag_set("player_in_left_room");

    waitframe();
  }

  var_0 notify("stop_loop_" + self.animname);
  var_0 scripts\common\anim::anim_single_solo(self, "1f_civ_react");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "1f_civ_idleB", "stop_loop_" + self.animname);
  scripts\engine\utility::flag_wait("1f_civs_ads");
  var_0 notify("stop_loop_" + self.animname);
  var_0 scripts\common\anim::anim_single_solo(self, "1f_civ_ads_react");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "1f_civ_idleB", "stop_loop_" + self.animname);
}

civ02_deathwatch(var_0) {
  self endon("death");
  level endon("civ02_stop_react");
  level endon("3f_cleared");
  scripts\engine\utility::flag_wait_any("civ01_dies", "civ03_dies");
  wait 0.4;
  self notify("civ_just_died");
  var_0 notify("stop_loop_" + self.animname);
  var_0 scripts\common\anim::anim_single_solo(self, "1f_civ_death_react");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "1f_civ_death_react_idle", "stop_loop_" + self.animname);
}

civ02_death() {
  level endon("tunnels_transition");
  self waittill("death");
  self stopsounds();
  scripts\engine\utility::flag_set("civ02_dies");
  thread unarmed_enemy_check();
}

civ03_1f_setup() {
  self endon("death");
  self endon("civ_just_died");
  level endon("3f_cleared");
  var_0 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "1f_civ_idleA", "stop_loop_" + self.animname);
  thread civ03_deathwatch(var_0);
  thread civ03_death();
  thread react_1f_vo("dx_vom_ccm1_heli_unload_guardhouse_132");
  scripts\engine\utility::flag_wait("1f_civ_reaction");

  for(;;) {
    if(scripts\engine\utility::flag("player_in_left_room")) {
      break;
    } else if(!scripts\engine\sp\utility::player_looking_at(self gettagorigin("j_head")))
      scripts\engine\utility::flag_set("player_in_left_room");

    waitframe();
  }

  var_0 notify("stop_loop_" + self.animname);
  var_0 scripts\common\anim::anim_single_solo(self, "1f_civ_react");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "1f_civ_idleB", "stop_loop_" + self.animname);
  scripts\engine\utility::flag_wait("1f_civs_ads");
  var_0 notify("stop_loop_" + self.animname);
  var_0 scripts\common\anim::anim_single_solo(self, "1f_civ_ads_react");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "1f_civ_idleB", "stop_loop_" + self.animname);
}

civ03_deathwatch(var_0) {
  self endon("death");
  level endon("3f_cleared");
  scripts\engine\utility::flag_wait_any("civ01_dies", "civ02_dies");
  wait 0.4;
  self notify("civ_just_died");
  var_0 notify("stop_loop_" + self.animname);
  self stopsounds();
  scripts\engine\utility::delaythread(0.1, scripts\engine\sp\utility::smart_dialogue, "dx_vom_ccm1_heli_unload_guardhouse_133");
  var_0 scripts\common\anim::anim_single_solo(self, "1f_civ_death_react");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "1f_civ_death_react_idle", "stop_loop_" + self.animname);
}

civ03_death() {
  level endon("civs_moved_to_main_house");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_9) && var_9.basename == "flash") {
      continue;
    }
    break;
  }

  scripts\engine\utility::flag_set("civ03_dies");
  thread scripts\sp\hud_util::fade_out(0);
  self stopsounds();
  self kill();
  var_10 = [22, 23];
  var_11 = scripts\engine\utility::array_randomize(var_10);
  var_12 = var_11[0];
  scripts\sp\player_death::set_custom_death_quote(var_12);
  scripts\sp\utility::missionfailedwrapper();
}

react_1f_vo(var_0) {
  self endon("death");
  scripts\engine\utility::waittill_any_ents(level, "1f_civ_reaction", self, "civ_just_died");
  self stopsounds();
  waitframe();
  thread scripts\engine\sp\utility::smart_dialogue(var_0);
}

moveup_1f_hallway(var_0) {
  wait 1.2;
  scripts\engine\utility::flag_set("remove_1f_hallway_clip");
  level.bravo4 scripts\engine\sp\utility::smart_dialogue("dx_vom_b63_1st_floor_power_10");
  wait 0.35;
  level.bravo1 scripts\engine\sp\utility::smart_dialogue("dx_vom_b64_1st_floor_power_20");
}

moveto_unbreachable_door(var_0) {
  scripts\common\ai::reset_gunpose();
  self.inanim = 1;
  var_0 scripts\common\anim::anim_single_solo(self, "1f_hallway");
  self.inanim = 0;
}

open_1f_hallway_door(var_0) {
  var_0 scripts\common\anim::anim_single_solo(self, "1f_hallway_open");
  var_0 scripts\common\anim::anim_last_frame_solo(self, "1f_hallway_open");
}

stairs_2f_nag(var_0) {
  level endon(var_0);
  var_1 = ["dx_vom_pri_2nd_floor_stairs_32", "dx_vom_pri_1st_floor_stairs_20", "dx_vom_b63_1st_floor_stairs_30"];
  level.price thread nag_system(var_0, var_1, 13, 13, level.player);
}

power_interact() {
  var_0 = getscriptablearray("power_switch_led", "targetname");
  var_0[0] setscriptablepartstate("onoff", "on");
  var_1 = getEnt("power_switch", "targetname");
  var_1 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (7, 4, 7), &"ZD30/POWER_SWITCH", 100, 60, 35, 1);
  var_1 waittill("trigger");

  while(level.player ismeleeing())
    waitframe();

  setsaveddvar("NLOTLQMORR", 0);
  scripts\engine\utility::flag_set("power_is_off");
  level.bravo4 stopsounds();
  level.bravo1 stopsounds();
  level.player thread scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_1st_floor_power_90");
  thread nvg_vision_power();
  thread scripts\engine\utility::delaythread(1.3, ::power_down_electronics);
  level.player scripts\engine\sp\utility::set_player_demeanor("relaxed");
  thread spawn_glowstick_on_struct("comp_glowstick1");
  scripts\sp\player::player_movement_state("creep");

  if(isDefined(level.bravo4.inanim) && level.bravo4.inanim)
    level.bravo4 scripts\engine\sp\utility::anim_stopanimScripted();
}

power_handle_down(var_0) {
  var_0 notify("handle_down");
  var_1 = getscriptablearray("power_switch_led", "targetname");
  var_1[0] setscriptablepartstate("onoff", "off_blink");
  var_2 = ["3f_bedroom_light", "2f_dataroom_light", "1f_light"];
  compound_lights_off(var_2);
  setsaveddvar("NLOTLQMORR", 1);
}

power_down_electronics() {
  var_0 = getscriptablearray("compound_electronics", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(var_2.classname == "scriptable_equipment_box_fan") {
      if(var_2.model != "equipment_box_fan_destr")
        var_2 setscriptablepartstate("base", "power_off");

      continue;
    }

    if(var_2.classname == "scriptable_un_office_server_rack_01" || var_2.classname == "scriptable_un_office_server_rack_large_01") {
      var_3 = var_2 getscriptablepartstate("base");

      if(!scripts\engine\utility::is_equal(var_3, "destroyed"))
        var_2 setscriptablepartstate("base", "power_off");

      continue;
    }

    if(var_2.classname == "scriptable_equipment_tv_01") {
      if(var_2.model != "equipment_tv_01_destr")
        var_2 setscriptablepartstate("tv", "power_off");
    }
  }
}

power_on_electronics() {
  var_0 = getscriptablearray("compound_electronics", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(var_2.classname == "scriptable_desktop_fan_fn_01" || var_2.classname == "scriptable_equipment_box_fan") {
      if(var_2.model != "desktop_fan_fn_01_destr" || var_2.model != "equipment_box_fan_destr" || var_2.model != "equipment_box_fan_anim")
        var_2 setscriptablepartstate("base", "idle");

      continue;
    }

    if(var_2.classname == "scriptable_un_office_server_rack_01" || var_2.classname == "scriptable_un_office_server_rack_large_01") {
      var_3 = var_2 getscriptablepartstate("base");

      if(!scripts\engine\utility::is_equal(var_3, "destroyed"))
        var_2 setscriptablepartstate("base", "power_on");

      continue;
    }

    if(var_2.classname == "scriptable_equipment_tv_01") {
      if(var_2.model != "equipment_tv_01_destr")
        var_2 setscriptablepartstate("tv", "power_on");
    }
  }
}

nvg_vision_power() {
  wait 2;

  if(level.player scripts\sp\nvg\nvg_player::is_nvg_off())
    scripts\engine\sp\utility::display_hint("nvg_on");

  thread scripts\engine\sp\utility::autosave_now();
}

setup_2f_bravo1(var_0) {
  var_0 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "1f_hallway_open_idle", "ready_2f_ascend");
}

setup_2f_price(var_0) {
  scripts\common\ai::reset_gunpose();
  var_0 scripts\common\anim::anim_first_frame_solo(self, "1f_hallway_open");

  while(!level.player isnightvisionon())
    waitframe();

  waittill_struct_within_fov("hallway_fov", "player_in_1f_backroom_trigger");
}

setup_2f_stairs_vo() {
  level.player wait_near(level.price, 75);
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_2nd_floor_stairs_30");
  var_0 = (297.908, 1247.18, 122.454);
  level.player wait_near(var_0, 40);
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_2nd_floor_stairs_50");
  wait 2.35;
  thread data_room_2f_enemy_vo();
  wait 1.8;
  level.overwatch scripts\engine\sp\utility::smart_dialogue("dx_vom_s11_2nd_floor_stairs_60");
  scripts\engine\utility::flag_wait("price_kick_in_door");
  wait 2.65;
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_2nd_floor_hallway_40");
  wait 2.75;

  if(scripts\engine\utility::flag("dataCiv_is_dead")) {
    return;
  }
  level endon("dataCiv_is_dead");
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_2nd_floor_hallway_45");

  while(!level.player get_is_looking_at(level.price, undefined, "j_head", 1))
    waitframe();

  if(scripts\engine\utility::flag("2f_pre_bedroom_save")) {
    return;
  }
  level endon("2f_pre_bedroom_save");
  wait 0.1;
  level.dataciv thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf2_1st_floor_interior_75");
  wait 3.4;
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_2nd_floor_hallway_60");
  level.player scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_a33_2nd_floor_hallway_70");

  if(level.player get_is_looking_at(level.price, undefined, "j_head", 1))
    level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_2nd_floor_hallway_80");
}

data_room_2f_enemy_vo() {
  var_0 = undefined;
  var_1 = undefined;

  foreach(var_3 in level.dataenemies) {
    if(isalive(var_3) && var_3.animname == "data_enemy1") {
      var_0 = var_3;
      continue;
    }

    if(isalive(var_3) && var_3.animname == "data_enemy2")
      var_1 = var_3;
  }

  if(isalive(var_0))
    var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aqm2_2nd_floor_hallway_22");

  if(isalive(var_1))
    var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aqm3_2nd_floor_hallway_23");

  if(isalive(var_0))
    var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aqm2_2nd_floor_hallway_24");
}

setup_2f_data_enemies() {
  var_0 = scripts\engine\utility::getStruct("2f_animnode", "targetname");

  foreach(var_2 in self)
  var_0 scripts\common\anim::anim_first_frame_solo(var_2, "2f_data_scene");
}

setup_1f_kitchen_scene() {
  var_0 = scripts\engine\sp\utility::spawn_script_noteworthy("dead_kitchen");
  var_0.allowdeath = 0;
  var_0.skipdeathanim = 1;
  var_0.diequietly = 1;
  var_0 scripts\engine\sp\utility::set_battlechatter(0);
  var_0 ignore_enabled();
  var_0 scripts\common\ai::magic_bullet_shield();
  scripts\common\utility::demeanor_override("casual_gun");
  self.script_pushable = 0;
  var_1 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  var_2 = [self, var_0];

  foreach(var_4 in var_2)
  var_4 thread kitchen_scene_speedup(var_1);

  scripts\engine\utility::flag_wait("player_at_2f_stairs");
  var_6 = cos(30);

  for(;;) {
    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0 gettagorigin("j_head"), var_6) && scripts\engine\trace::ray_trace_passed(level.player getEye(), var_0 gettagorigin("j_head"), [var_0, level.player, level.bravo2])) {
      break;
    } else if(scripts\engine\utility::flag("player_at_top_2f_stairs")) {
      break;
    }

    waitframe();
  }

  foreach(var_4 in var_2)
  var_4 setanimrate(var_4.tempanim, 1);

  var_0 waittillmatch("single anim", "end");
  var_1 scripts\common\anim::anim_last_frame_solo(var_0, "1f_hallway_open");
  self setgoalpos(self.origin);
  scripts\engine\utility::flag_wait("player_midway_in_2f_hallway");
  var_0 scripts\common\ai::stop_magic_bullet_shield();
  var_0 delete();
}

kitchen_scene_speedup(var_0) {
  self.tempanim = scripts\engine\utility::getanim("1f_hallway_open");
  var_0 thread scripts\common\anim::anim_single_solo(self, "1f_hallway_open");
  waitframe();
  self setanimtime(self.tempanim, 0.47);
  self setanimrate(self.tempanim, 0);
}

spawn_2f_civ_jumpto() {
  var_0 = scripts\engine\utility::getStruct("2f_animnode", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_script_noteworthy("2f_data_room_civ");
  var_0 thread scripts\common\anim::anim_loop_solo(var_1, "2f_data_scene_idle", "stop_loop_cleanup");
}

postspawn_2f_data() {
  self.allowdeath = 0;
  self.noragdoll = 1;
  self.diequietly = 1;
  self.skipdeathanim = 1;
  ignore_enabled();
  scripts\engine\sp\utility::set_battlechatter(0);
  scripts\sp\utility::context_melee_allow(0);
  scripts\common\ai::magic_bullet_shield();
  scripts\common\ai::gun_remove();
  self actoraimassistoff();
}

postspawn_2f_dataciv() {
  self endon("death");
  level endon("3f_scene_done");
  level.dataciv = self;
  self.allowdeath = 1;
  self.skipdeathanim = 1;
  self.no_friendly_fire_fail = 1;
  self.nothreat = 0;
  ignore_enabled();
  scripts\engine\sp\utility::set_battlechatter(0);
  scripts\sp\utility::context_melee_allow(0);
  thread dataciv_death_watcher();
  level.civs[level.civs.size] = self;
}

dataciv_death_watcher() {
  level endon("civs_moved_to_main_house");
  self waittill("damage");
  scripts\engine\utility::flag_set("dataCiv_is_dead");

  if(isDefined(self.nothreat) && self.nothreat) {
    thread scripts\sp\hud_util::fade_out(0);
    self stopsounds();
    var_0 = [25, 26];
    var_1 = scripts\engine\utility::array_randomize(var_0);
    var_2 = var_1[0];
    scripts\sp\player_death::set_custom_death_quote(var_2);
    scripts\sp\utility::missionfailedwrapper();
  } else
    thread unarmed_enemy_check();
}

postspawn_2f_enemies() {
  var_0 = scripts\engine\utility::getStruct("2f_animnode", "targetname");
  scripts\engine\sp\utility::set_battlechatter(0);

  if(self.animname == "bed_enemy")
    thread bed_enemy_2f_action(var_0);
  else if(self.animname == "bed_civ")
    thread bed_civ_2f_action(var_0);
  else if(self.animname == "balcony_enemy")
    thread balcony_enemy_2f_action(var_0);
}

bed_enemy_2f_action(var_0) {
  level notify("spawned_2f_enemies");
  thread watcher_2f_clear();
  thread bed_enemy_watcher();
  thread bed_enemy_flash_watcher();
  level thread temp_bed_enemy_shooting(self);
  thread disable_if_player_close();
  self endon("death");
  ignore_enabled();
  self.grenadeammo = 0;
  self.goalradius = 32;
  self.disablepistol = 1;
  self.deathanim = scripts\engine\utility::getanim("bathroom_death");
  scripts\sp\utility::context_melee_allow(0);
  scripts\engine\utility::set_cautious_navigation(1);
  scripts\engine\utility::disable_pain();
  var_1 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
  scripts\anim\shared.gsc::forceuseweapon(var_1, "primary");
  scripts\engine\utility::flag_wait("2f_pre_bedroom_save");
  thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aqm1_2nd_floor_bedroom_10");
  thread bathroom_2f_guy_breathing();
  scripts\engine\utility::flag_wait("player_near_bed_guy");
  self stopsounds();
  scripts\engine\utility::delaythread(0.1, scripts\engine\sp\utility::smart_dialogue, "dx_vom_aqm1_2nd_floor_bedroom_80");
  ignore_disabled();
  self getenemyinfo(level.player);
  wait 0.2;

  for(;;) {
    if(self cansee(level.player)) {
      break;
    } else if(level.player playermount() > 0.5 && scripts\engine\trace::ray_trace_passed(level.player gettagorigin("j_chest"), self gettagorigin("tag_eye"), [level.player, self])) {
      break;
    }

    waitframe();
  }

  var_2 = cos(35);

  if(!in_player_fov(var_2)) {
    var_3 = scripts\engine\utility::getStruct("2f_bathroom_fire", "targetname");
    var_4 = 0;
    var_5 = 0;
    var_6 = [0, -8, -15, -18];
    var_7 = [0, 7, 3, 5];

    for(;;) {
      if(in_player_fov(var_2)) {
        break;
      } else if(var_4 >= 1) {
        break;
      } else if(self cansee(level.player))
        self shoot(1, level.player);
      else if(level.player playermount() > 0.5 && scripts\engine\trace::ray_trace_passed(level.player gettagorigin("j_chest"), self gettagorigin("tag_eye"), [level.player, self]))
        self shoot(1, level.player);
      else {
        if(level.player getstance() == "crouch")
          var_5 = -23;
        else
          var_5 = -3;

        var_5 = (0, var_6[var_4], var_7[var_4] + var_5);
        self shoot(1, var_3.origin + var_5);
      }

      var_4++;
      wait 0.1;
    }
  }

  var_8 = undefined;
  var_9 = getEnt("2f_bathroom_player_clear", "targetname");
  var_10 = [getnode("bathroom_node_right", "targetname"), getnode("bathroom_node_left", "targetname")];

  for(;;) {
    if(!self cansee(level.player) && !scripts\engine\trace::ray_trace_passed(level.player gettagorigin("j_chest"), self gettagorigin("tag_eye"), [level.player, self])) {
      if(!isDefined(var_8))
        var_8 = gettime();

      if(gettime() >= var_8 + 2500) {
        while(level.player istouching(var_9))
          waitframe();

        break;
      } else if(self cansee(level.player))
        var_8 = undefined;
    }

    waitframe();
  }

  level notify("stop_temp_firing");
  self clearentitytarget();
  self getenemyinfo(level.player);
  scripts\engine\sp\utility::set_favoriteenemy(level.player);
  self.deathanim = undefined;
  var_11 = scripts\engine\utility::getclosest(level.player.origin, var_10);
  self.allowdeath = 1;
  var_0 = scripts\engine\utility::getStruct(var_11.script_noteworthy + "_animnode", "targetname");
  var_0 scripts\common\anim::anim_single_solo(self, var_11.script_noteworthy);
  self setgoalpos(self.origin);
}

disable_if_player_close() {
  self endon("death");
  var_0 = squared(60);

  for(;;) {
    var_1 = distancesquared(level.player.origin, self.origin);

    if(var_1 < var_0) {
      break;
    }

    waitframe();
  }

  level notify("stop_temp_firing");
  self clearentitytarget();
  scripts\engine\sp\utility::set_favoriteenemy(level.player);
  self.deathanim = undefined;
}

bed_civ_2f_action(var_0) {
  level.bedciv = self;
  thread spawn_glowstick_on_struct("comp_glowstick2");
  thread bedroom_girl_watcher();
  thread bedroom_girl_stunned();
  self endon("death");
  ignore_enabled();
  self.no_friendly_fire_fail = 1;
  self.allowdeath = 1;
  self.skipdeathanim = 1;
  self.goalradius = 16;
  self.nothreat = 0;
  var_0 thread scripts\common\anim::anim_single_solo(self, "light_run");
  waitframe();
  var_1 = scripts\engine\utility::getanim("light_run");
  self setanimtime(var_1, 0.5);
  self setanimrate(var_1, 0);
  level.bravo1 thread swap_3f_anim();
  scripts\engine\utility::flag_wait("start_shadow");
  thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf4_2nd_floor_bedroom_20");
  thread bedroom_2f_woman_breathing();
  self setanimrate(var_1, 1);
  self waittillmatch("single anim", "end");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "light_run_idle", "stop_loop_" + self.animname);
  thread anim_gun_react_and_idle(var_0, "light_run_ads", "light_run_idle", 18, "start_downstairs_sequence");
}

balcony_enemy_2f_action(var_0) {
  level.balcony_enemy = self;
  self.grenadeammo = 0;
  self.goalradius = 0;
  self.allowdeath = 1;
  self.dontmelee = 1;
  scripts\sp\utility::context_melee_allow(0);
  self actoraimassistoff();
  ignore_enabled();
  thread balcony_damage_watcher();
  thread balcony_watcher();
  thread balcony_sees_player();
  thread balcony_force_open_door();
  var_1 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
  scripts\anim\shared.gsc::forceuseweapon(var_1, "primary");
  self endon("death");
  var_0 scripts\common\anim::anim_single_solo(self, "2f_hallway");
  thread scripts\common\anim::anim_single_solo(self, "2f_hallway_turn");
  wait 1.1;
  scripts\engine\sp\utility::anim_stopanimScripted();
  self setgoalpos(self.origin);
  self.goalradius = 0;
}

bathroom_2f_guy_breathing() {
  level endon("player_near_bed_guy");
  self endon("death");

  for(;;)
    scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say("dx_vom_aqm1_2nd_floor_bedroom_50");
}

bedroom_2f_woman_breathing() {
  level endon("bedroom_girl_seen");
  self endon("death");

  for(;;)
    scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say("dx_vom_aqf4_2nd_floor_bedroom_60");
}

bed_enemy_watcher() {
  self waittill("death");
  self stopsounds();
  scripts\engine\utility::flag_set("bathroom_guy_dead");
}

bed_enemy_flash_watcher() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_9) && var_9.basename == "flash") {
      scripts\engine\utility::enable_pain();
      scripts\engine\sp\utility::anim_stopanimScripted();
      thread scripts\anim\combat_utility.gsc::flashbangstart(2);
      waitframe();
      scripts\engine\utility::disable_pain();
    }
  }
}

temp_bed_enemy_shooting(var_0) {
  level endon("stop_temp_firing");
  var_1 = scripts\engine\utility::getStruct("bed_enemy_shoot_line", "targetname");
  var_2 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  var_3 = vectorNormalize(var_2.origin - var_1.origin);
  var_4 = var_1.origin + var_3 * 7;
  var_5 = var_2.origin;
  var_6 = vectortoangles(var_5 - var_4);
  var_7 = anglestoleft(var_6);
  var_8 = create_aiment(var_4);
  var_9 = 0;
  var_10 = 0;

  while(isalive(var_0)) {
    waitframe();

    if(gettime() > var_10 && (!var_0 cansee(level.player) || var_0 canshoot(var_8.origin) || var_0 canshoot(level.player gettagorigin("j_chest")))) {
      if(var_9) {
        var_9 = 0;
        var_0 clearentitytarget();
        var_0.favoriteenemy = undefined;
      }

      var_8.origin = var_4 + (0, 0, -100);
      continue;
    }

    var_11 = level.player getEye();
    var_12 = var_0 getEye();
    var_13 = var_11 - var_12;
    var_14 = vectorNormalize(var_13);

    if(vectordot(var_7, var_14) == 0) {
      continue;
    }
    var_15 = (vectordot(var_7, var_4) - vectordot(var_7, var_12)) / vectordot(var_7, var_14);
    var_16 = var_12 + var_14 * var_15;

    if(var_16[1] < var_4[1])
      var_16 = (var_16[0], var_4[1], var_16[2]);
    else if(var_16[1] > var_5[1])
      var_16 = (var_16[0], var_5[1], var_16[2]);

    var_8.origin = var_16;

    if(!var_9) {
      var_9 = 1;
      var_0 setentitytarget(var_8);
      var_0.favoriteenemy = var_8;
      var_10 = gettime() + 1500;
    }
  }
}

create_aiment(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1 setModel("tag_origin_only_collision");
  var_1 notsolid();
  var_1 hide();
  return var_1;
}

balcony_damage_watcher() {
  self endon("death");
  self endon("stop_flash_watcher");
  wait 2.3;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_9) && var_9.basename == "flash")
      scripts\engine\sp\utility::anim_stopanimScripted();
  }
}

balcony_watcher() {
  self waittill("death");
  self stopsounds();
  scripts\engine\utility::flag_set("balcony_guy_dead");
}

bedroom_girl_watcher() {
  var_0 = scripts\engine\utility::waittill_any_return("scared_reaction_started", "death");
  scripts\engine\utility::flag_set("bedroom_girl_seen");

  if(var_0 == "scared_reaction_started") {
    thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf4_2nd_floor_bedroom_70");
    self waittill("death");
    waitframe();
    self stopsounds();
  } else
    self stopsounds();
}

bedroom_girl_stunned() {
  level endon("civs_moved_to_main_house");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(self.nothreat) && self.nothreat) {
      thread scripts\sp\hud_util::fade_out(0);
      self stopsounds();
      var_10 = [48, 49];
      var_11 = scripts\engine\utility::array_randomize(var_10);
      var_12 = var_11[0];
      scripts\sp\player_death::set_custom_death_quote(var_12);
      scripts\sp\utility::missionfailedwrapper();
    } else if(!isalive(self)) {
      thread unarmed_enemy_check();
      break;
    }

    if(isDefined(var_9) && var_9.basename == "flash")
      self.iamflashed = 1;
  }
}

watcher_2f_clear() {
  scripts\engine\utility::flag_wait_all("bathroom_guy_dead", "balcony_guy_dead", "bedroom_girl_seen");
  scripts\engine\utility::flag_clear("player_at_3f_stairs");
  scripts\engine\utility::flag_set("3f_ready");
  level notify("backtracking_nag_end");
  thread scripts\engine\sp\utility::autosave_now();
}

balcony_sees_player() {
  self endon("death");
  scripts\engine\utility::flag_wait("player_2f_balcony");
  ignore_disabled();
  self getenemyinfo(level.player);
}

balcony_force_open_door() {
  interactive_double_door_force_open("2f_runner_door");
  wait 1;
  thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aq2_basement_tunnel_leftpath_40");
}

swap_3f_anim() {
  scripts\engine\utility::flag_wait_any("start_shadow", "bathroom_guy_dead");
  var_0 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  var_0 notify("swap_2f_stance");
  var_1 = scripts\engine\utility::getStruct("3f_animnode", "targetname");
  var_1 thread scripts\common\anim::anim_loop_solo(self, "3f_stairs_intro", "stop_3f_stairs");
}

data_room_nag(var_0) {
  level endon(var_0);
  var_1 = ["dx_vom_pri_2nd_floor_dataroom_50", "dx_vom_pri_2nd_floor_dataroom_60", "dx_vom_pri_2nd_floor_hallway_80"];
  level.price thread nag_system(var_0, var_1, 13, 13, level.player);
}

backtracking_2f_nag(var_0) {
  level endon("3f_ready");
  var_1 = getEnt("2f_nag_trigger", "targetname");

  for(;;) {
    if(level.player istouching(var_1)) {
      scripts\engine\utility::flag_clear("player_midway_in_2f_hallway");
      var_2 = ["Finish Clearing the 2nd Floor", "You need to secure the 2nd floor"];
      scripts\engine\utility::flag_wait("player_midway_in_2f_hallway");
      level notify("backtracking_nag_end");
    }

    waitframe();
  }
}

start_2f_data() {
  self waittill("stairtrain_end");
  var_0 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  var_0 notify("player_at_top_2f_stairs");
  thread scripts\engine\sp\utility::autosave_now();
  var_0 = scripts\engine\utility::getStruct("2f_animnode", "targetname");
  var_0 notify("stop_first_frame");
  var_1 = scripts\engine\utility::array_add(level.dataenemies, level.dataciv);
  scripts\engine\utility::array_thread(var_1, ::play_2f_data_anim, var_0);
  scripts\engine\utility::delaythread(0.1, ::price_dataciv_is_dead, var_0);
  var_0 scripts\common\anim::anim_single_solo(self, "2f_data_scene");

  if(!scripts\engine\utility::flag("dataCiv_is_dead"))
    var_0 thread scripts\common\anim::anim_loop_solo(self, "2f_data_scene_idle", "stop_loop_cleanup");

  if(!scripts\engine\utility::flag("player_midway_in_2f_hallway"))
    thread data_room_nag("data_room_nag_end");

  scripts\engine\utility::flag_wait("player_midway_in_2f_hallway");
  level notify("data_room_nag_end");
  thread backtracking_2f_nag("backtracking_nag_end");
}

price_dataciv_is_dead(var_0) {
  level endon("dataCiv_is_secured");
  level waittill("check_dataCiv_status");
  scripts\engine\utility::flag_wait("dataCiv_is_dead");
  var_0 notify("stop_loop_cleanup");
  scripts\engine\sp\utility::anim_stopanimScripted();
  var_0 scripts\sp\anim::anim_reach_and_arrive(self, "2f_data_scene_idle");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "2f_data_scene_idle", "stop_loop_cleanup");
}

play_2f_data_anim(var_0) {
  var_0 scripts\common\anim::anim_single_solo(self, "2f_data_scene");

  if(self.animname == "data_civ") {
    if(isalive(self))
      var_0 thread scripts\common\anim::anim_loop_solo(self, "2f_data_scene_idle", "stop_loop_cleanup");
  } else
    var_0 thread scripts\common\anim::anim_last_frame_solo(self, "2f_data_scene");
}

bravo1_2f_idle() {
  self waittill("stairtrain_end");
  var_0 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "2f_stairs_ascend_idle", "swap_2f_stance");
}

setup_2f_bedroom() {
  var_0 = scripts\sp\door::double_doors_init_targetname("2f_hallway_door");
  var_0 scripts\engine\utility::array_thread(var_0, scripts\game\sp\door::remove_door_snake_cam_ability);
  var_0[0] thread interactive_door_lock_one_side("2f_lock_trigger");
  var_0[0].disable_bounceback = 1;
  var_0[1].disable_bounceback = 1;
  scripts\engine\utility::flag_wait("2f_pre_bedroom_save");
  thread scripts\engine\sp\utility::autosave_now();
  var_0[0] thread hallway_2f_door_check();
  scripts\engine\utility::flag_wait("bathroom_guy_dead");
  thread all_secure_check();

  if(isalive(level.balcony_enemy)) {
    var_1 = scripts\engine\utility::getStruct("2f_balcony_deathB_struct", "targetname");
    var_1 scripts\common\anim::anim_first_frame_solo(level.balcony_enemy, "2f_balcony_deathB");
    level.balcony_enemy failsafe_2f_balcony_setup(var_0, var_1);
  }
}

all_secure_check() {
  scripts\engine\utility::flag_wait("bedroom_girl_seen");
  wait 1;

  if(scripts\engine\utility::flag("balcony_guy_dead")) {
    level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_2nd_floor_bedroom_110");
    wait 0.1;
  }

  if(isDefined(level.bedciv) && isalive(level.bedciv)) {
    level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_2nd_floor_bedroom_130");
    level.alpha3 scripts\engine\sp\utility::smart_dialogue("dx_vom_a33_2nd_floor_bedroom_100");
  } else {
    if(scripts\engine\utility::flag("balcony_guy_dead"))
      level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_2nd_floor_bedroom_140");
    else
      level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_2nd_floor_bedroom_120");

    level.alpha3 scripts\engine\sp\utility::smart_dialogue("dx_vom_a33_2nd_floor_bedroom_150");
  }
}

failsafe_2f_balcony_setup(var_0, var_1) {
  scripts\engine\utility::flag_clear("start_shadow");
  var_0[0] thread door_waittill_open(30, "2f_hallway_door_opened");
  scripts\engine\utility::flag_wait_any("2f_hallway_door_opened", "start_shadow");
  self notify("stop_flash_watcher");
  var_2 = cos(20);

  for(;;) {
    var_3 = distance(level.player.origin, level.bravo4.origin);

    if(scripts\engine\utility::flag("start_shadow")) {
      break;
    } else if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), level.bravo4 gettagorigin("j_head"), var_2) && scripts\engine\trace::ray_trace_passed(level.player getEye(), level.bravo4 gettagorigin("j_head"), [level.bravo4, level.player])) {
      break;
    } else if(var_3 < 92) {
      break;
    }

    waitframe();
  }

  scripts\common\ai::magic_bullet_shield();
  var_4 = undefined;

  if(scripts\engine\utility::flag("start_shadow")) {
    var_4 = "2f_balcony_deathB";
    var_5 = scripts\engine\utility::getStruct(var_4 + "_struct", "targetname");
  } else {
    var_4 = "2f_balcony_deathA";
    var_5 = scripts\engine\utility::getStruct(var_4 + "_struct", "targetname");
    var_5 scripts\common\anim::anim_first_frame_solo(self, var_4);
  }

  wait 0.5;
  level.bravo4 shoot(1, self);
  thread failsafe_2f_balcony_death(var_5, var_4);
  wait 0.15;
  level.bravo4 shoot(1, self);
  wait 0.8;
}

hallway_2f_door_check() {
  level endon("stairs_2f_nag_end");
  door_waittill_open(20);

  if(!scripts\engine\utility::flag("bedroom_girl_seen"))
    scripts\engine\utility::flag_set("bedroom_girl_seen");
}

failsafe_2f_balcony_death(var_0, var_1) {
  self.diequietly = 1;
  self.skipdeathanim = 1;
  self.noragdoll = 1;
  var_0 notify("stop_first_frame");
  scripts\engine\utility::delaythread(1, scripts\engine\utility::flag_set, "balcony_guy_dead");
  var_0 scripts\common\anim::anim_single_solo(self, var_1);
  scripts\common\ai::stop_magic_bullet_shield();
  self.noragdoll = undefined;
  self kill();
}

scriptable_watcher(var_0, var_1, var_2) {
  level endon("tunnels_transition");
  scripts\engine\utility::flag_wait("scriptables_ready");
  var_3 = getscriptablearray(var_0, "targetname");
  var_4 = getEnt(var_1, "targetname");
  var_3[0] waittill("scriptableNotification", var_5);

  if(var_5 == var_2)
    var_4 setlightintensity(0);
}

interactive_door_lock_one_side(var_0) {
  self endon("first_interact");
  self endon("bashed");
  level endon("tunnels_transition");
  var_1 = getEnt(var_0, "targetname");
  var_2 = undefined;

  if(isDefined(self.doubledoors) && self.doubledoors[0] == self)
    var_2 = scripts\sp\door::get_interactive_door(self.targetname + "_right");

  for(;;) {
    while(!level.player istouching(var_1))
      waitframe();

    scripts\sp\door::lock_door();
    self.bashed = 1;

    if(isDefined(var_2))
      var_2.bashed = 1;

    while(level.player istouching(var_1))
      waitframe();

    scripts\sp\door::unlock_door();
    self.bashed = 0;

    if(isDefined(var_2))
      var_2.bashed = 0;
  }
}

bravo4_movements() {
  scripts\engine\sp\utility::anim_stopanimScripted();
  self.script_pushable = 0;
  scripts\common\utility::demeanor_override("cqb");
  scripts\engine\utility::set_movement_speed(40);
  scripts\engine\utility::set_cautious_navigation(1);
  self enableavoidance(0);
  self allowedstances("stand");
  self forceteleport((304, 1325.5, 149), (0, 0, 0));
  self setgoalpos(self.origin);

  while(self.currentpose != "stand")
    waitframe();

  var_0 = getnode("2f_off_stairs_node", "targetname");
  self setgoalnode(var_0);
  var_1 = squared(20);

  for(;;) {
    var_2 = distancesquared(self.origin, var_0.origin);

    if(var_2 <= var_1) {
      break;
    }

    waitframe();
  }

  self allowedstances("crouch");
  scripts\engine\utility::flag_wait("start_shadow");
  var_3 = scripts\engine\utility::getStruct("temp_2f_animnode2", "targetname");
  var_3 notify("stop_loop_bravo4");
  self allowedstances("stand");
  scripts\asm\asm_bb::bb_requeststance("stand");

  while(self.currentpose != "stand")
    waitframe();

  var_3 thread scripts\common\anim::anim_loop_solo(self, "2f_hallway_idle", "stop_loop_hallway_bravo4");
  self enableavoidance(1);
  scripts\engine\utility::flag_wait("3f_ready");

  for(;;) {
    var_2 = distance(self.origin, level.player.origin);

    if(var_2 < 92) {
      break;
    } else
      waitframe();
  }

  var_3 notify("stop_loop_hallway_bravo4");
  var_3 scripts\common\anim::anim_single_solo(self, "2f_hallway_post");

  if(!scripts\engine\utility::flag("ready_3f_ascend")) {
    var_4 = ["dx_vom_b64_2nd_floor_exit_80", "dx_vom_b64_2nd_floor_exit_80", "dx_vom_b64_2nd_floor_exit_80"];
    thread notetrack_nag(var_4, "ready_3f_ascend", "3f_stairtrain_end");
  }

  var_3 thread scripts\common\anim::anim_loop_solo_with_nags(self, "2f_hallway_post_idle", "stop_loop_cleanup");
}

setup_3f_bravo1(var_0) {
  scripts\engine\utility::delaythread(1, ::objective_control, "3f_balcony");
  scripts\engine\utility::delaythread(3, scripts\sp\player::player_movement_state, "cqb");
  var_0 scripts\common\anim::anim_single_solo(self, "3f_stairs");
  var_0 notify("stop_loop_3f_stairs_idle");

  if(!scripts\engine\utility::flag("player_in_3f_bedroom_balcony")) {
    var_1 = ["dx_vom_b64_3rd_floor_balcony_50", "dx_vom_b64_3rd_floor_balcony_60", "dx_vom_b64_3rd_floor_stairs_110"];

    if(!scripts\engine\utility::flag("player_near_3f_balcony") || !scripts\engine\utility::flag("player_is_breaching_hallway"))
      thread notetrack_nag(var_1, "player_near_3f_balcony", "player_is_breaching_hallway");

    var_0 thread scripts\common\anim::anim_loop_solo_with_nags(self, "3f_stairs_idle", "stop_loop_3f_stairs_idle");
  }
}

spawn_3f_stairs_enemy(var_0) {
  var_1 = scripts\engine\sp\utility::spawn_targetname("dead_enemy");
  var_1.health = 10000;
  var_1.allowdeath = 0;
  var_1.skipdeathanim = 1;
  var_1.noragdoll = 1;
  var_1.diequietly = 1;
  var_1 scripts\engine\sp\utility::set_battlechatter(0);
  var_1 scripts\common\ai::gun_remove();
  var_1 scripts\sp\utility::context_melee_allow(0);
  var_1 actoraimassistoff();
  var_0 scripts\common\anim::anim_first_frame_solo(var_1, "3f_stairs_start");
  return var_1;
}

stairs_3f_enemy_vo() {
  wait 0.2;
  thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aqm2_3rd_floor_stairs_20");
  self waittill("damage");
  self stopsounds();
}

stairs_3f_enemy(var_0) {
  self waittill("stairtrain_end");
  self visiblenotsolid();
  var_0 scripts\common\anim::anim_last_frame_solo(self, "3f_stairs_start");
}

balcony_3f_door() {
  var_0 = scripts\sp\door::double_doors_init_targetname("3f_balcony_door");
  var_0 scripts\engine\utility::array_thread(var_0, scripts\game\sp\door::remove_door_snake_cam_ability);
  var_0[0] thread door_waittill_open(25, "player_is_breaching_balcony");
  return var_0[0];
}

bedroom_3f_door() {
  var_0 = scripts\sp\door::double_doors_init_targetname("3f_bedroom_door");
  var_0 scripts\engine\utility::array_thread(var_0, scripts\game\sp\door::remove_door_snake_cam_ability);
  var_0[0] thread door_waittill_open(25, "player_is_breaching_hallway");
  return var_0[0];
}

setup_3f_scene(var_0) {
  var_0.enemyfiring = 0;
  var_1 = spawn_3f_enemy2();
  var_2 = spawn_3f_enemy1();
  var_3 = spawn_3f_hostage();
  var_3.animnode = var_0;
  var_3.partner = var_2;
  var_2.partner = var_3;
  var_2.delaykill = 0;
  var_2.enemyflashed = 0;
  var_0 thread scripts\common\anim::anim_loop_solo(var_3, "3f_favella_idle", "stop_hostage_loop");
  var_0 thread scripts\common\anim::anim_loop_solo(var_2, "3f_favella_idle", "stop_favella_loop");
  var_4 = thread scripts\sp\door::double_doors_init_targetname("3f_favela_door");
  var_5 = scripts\sp\door::get_interactive_door("3f_favela_door_right");
  var_6 = scripts\sp\door::get_interactive_door("3f_favela_door");
  var_7 = scripts\sp\door::get_interactive_door("3f_bedroom_door_right");
  var_8 = scripts\sp\door::get_interactive_door("3f_bedroom_door");
  var_1 thread enter_3f_vo();
  var_1 thread bedroom_3f_death();
  var_2 thread enemy_3f_death(var_0, var_3, var_6, var_5);
  scripts\engine\utility::flag_wait_any("player_in_3f_bedroom_balcony", "player_is_breaching_hallway");
  objective_control("3f_hostage");

  if(scripts\engine\utility::flag("player_is_breaching_hallway")) {
    if(isalive(var_1))
      var_1 thread enemy_3f_door_action();

    scripts\engine\utility::flag_wait("start_3f_favela_door");
    scripts\engine\utility::flag_set("bravo1_anim_finished");
    var_0 notify("stop_favella_loop");

    if(!scripts\engine\utility::flag("3f_favela_guy_dead")) {
      var_0 thread anim_door(var_6, "3f_favella_l");
      var_0 thread anim_door(var_5, "3f_favella_r");
      var_0 scripts\common\anim::anim_single_solo(var_2, "3f_favella");
    }
  } else if(scripts\engine\utility::flag("player_in_3f_bedroom_balcony")) {
    var_0 notify("stop_favella_loop");
    var_0 thread anim_door(var_7, "3f_ally_ar");
    var_0 thread anim_door(var_8, "3f_ally_al");

    if(!scripts\engine\utility::flag("3f_favela_guy_dead")) {
      var_2 thread delay_until_first_shot();
      var_0 thread anim_door(var_6, "3f_ally_fl");
      var_0 thread anim_door(var_5, "3f_ally_fr");
      level.bravo1 thread bravo1_enters_3f_room(var_0);
      var_0 scripts\common\anim::anim_single_solo(var_2, "3f_ally");
    } else
      scripts\engine\utility::flag_set("bravo1_anim_finished");
  }

  for(;;) {
    var_9 = randomfloatrange(0.5, 1.5);

    if(!scripts\engine\utility::flag("3f_favela_guy_dead")) {
      var_0 thread scripts\common\anim::anim_loop_solo(var_2, "3f_favella_idle", "stop_favella_loop");

      if(!scripts\engine\utility::flag("3f_favela_guy_dead")) {
        if(var_2.enemyflashed) {
          var_9 = 3.5;
          var_2.enemyflashed = 0;
        }

        wait(var_9);

        if(var_2.enemyflashed) {
          wait 3;
          var_2.enemyflashed = 0;
        }

        var_0 notify("stop_favella_loop");
      } else
        break;
    } else
      break;

    if(!scripts\engine\utility::flag("3f_favela_guy_dead") && !var_2.enemyflashed) {
      var_0 scripts\common\anim::anim_single_solo(var_2, "3f_favella_shoot");
      continue;
    }

    break;
  }

  var_10 = scripts\engine\utility::getStruct("3f_hostage", "targetname");
  var_11 = gettime();
  scripts\engine\utility::flag_clear("player_in_3f_hallway");
  var_12 = cos(20);

  for(;;) {
    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_10.origin, var_12) && scripts\engine\trace::ray_trace_passed(level.player getEye(), var_10.origin, level.player)) {
      break;
    } else if(scripts\engine\utility::flag("3f_hostage_dead") || scripts\engine\utility::flag("player_in_3f_hallway") || scripts\engine\utility::flag("start_3f_favela_door")) {
      if(scripts\engine\utility::flag("3f_hostage_dead")) {
        scripts\engine\utility::flag_wait("3f_favela_guy_dead");
        wait 0.5;
      } else if(scripts\engine\utility::flag("start_3f_favela_door")) {
        scripts\engine\utility::flag_wait_any("3f_hostage_dead", "start_3f_react", "player_in_3f_hallway");
        wait 0.5;
      }

      break;
    } else if(gettime() >= var_11 + 8000) {
      break;
    }

    waitframe();
  }

  scripts\engine\utility::flag_wait_all("3f_bedroom_guy_dead", "3f_favela_guy_dead");
  scripts\engine\utility::flag_set("3f_cleared");
  level.bravo1 thread bravo1_3f_ending(var_0);
  thread comp_3f_finished_vo();
  var_0 notify("stop_last_frame");
  scripts\engine\utility::flag_set("3f_scene_done");
  level.heli_charlie = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("heli_charlie");
  level.heli_charlie.animname = "heli_charlie_end";
  level.heli_charlie scripts\engine\sp\utility::assign_animtree("heli_charlie_end");
  level.heli_charlie thread charlie_heli_lights();
  scripts\common\vehicle_build::build_treadfx("script_vehicle_iw8_lbravo_carrier", "default", "vfx/code/tread/heli_dust_default.vfx");
  level.heli_charlie scalevolume(0.0, 0.0);
  level.heli_charlie scripts\engine\utility::delaycall(3.5, ::scalevolume, 0.7, 15.0);
  thread setup_gear_alex();
}

charlie_heli_lights() {
  playFXOnTag(scripts\engine\utility::getfx("vfx_zd30_heli_interior_lights"), self, "tag_origin");
}

setup_gear_alex() {
  while(!isDefined(level.alex))
    wait 0.1;

  var_0 = scripts\sp\utility::make_weapon("iw8_sh_romeo870", ["reflex_west01"]);
  level.alex scripts\anim\shared.gsc::forceuseweapon(var_0, "primary");
}

delay_until_first_shot() {
  self.delaykill = 1;
  wait 1.4;
  self.delaykill = 0;
}

enter_3f_vo() {
  level.bravo1 waittill("stairtrain_end");
  scripts\engine\sp\utility::smart_dialogue("dx_vom_aqm3_3rd_floor_stairs_60");
  wait 4.35;

  if(level.player get_is_looking_at(level.bravo1, undefined, "j_head", 1))
    level.bravo1 thread scripts\engine\sp\utility::smart_dialogue("dx_vom_b64_3rd_floor_stairs_110");

  thread enter_through_3f_balcony_vo();
}

enter_through_3f_balcony_vo() {
  level endon("player_is_breaching_hallway");
  scripts\engine\utility::flag_wait("player_is_breaching_balcony");
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_3rd_floor_hostage_21");
  level.bravo1 scripts\engine\sp\utility::smart_dialogue("dx_vom_b64_3rd_floor_hostage_22");
}

spawn_3f_enemy1() {
  var_0 = scripts\engine\sp\utility::spawn_targetname("3f_enemy");
  var_0 scripts\sp\utility::context_melee_allow(0);
  var_0 scripts\engine\sp\utility::set_battlechatter(0);
  var_0 scripts\common\ai::magic_bullet_shield();
  var_0.allowdeath = 0;
  var_0.noragdoll = 1;
  var_0.skipdeathanim = 1;
  var_0.diequietly = 1;
  var_0.fakehealth = var_0.maxhealth;
  var_0 thread weapon_fire_3f_enemy1_vo();
  return var_0;
}

weapon_fire_3f_enemy1_vo() {
  self endon("death");
  var_0 = ["dx_vom_aqm1_3rd_floor_hostage_23", "dx_vom_aqm1_3rd_floor_hostage_27", "dx_vom_aqm1_3rd_floor_hostage_28", "dx_vom_aqm1_3rd_floor_hostage_29"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0);

  for(;;) {
    self waittill("weapon_fired");
    var_2 = var_1 scripts\engine\sp\utility::deck_draw();
    scripts\engine\sp\utility::smart_dialogue(var_2);
  }
}

spawn_3f_enemy2() {
  setsaveddvar("MTTSOONN", 1);
  var_0 = scripts\engine\sp\utility::spawn_targetname("3f_enemy_door");
  var_0 scripts\sp\utility::context_melee_allow(0);
  var_0 scripts\engine\sp\utility::set_battlechatter(0);
  var_0.goalradius = 16;
  var_0.dontmelee = 1;
  var_0 ignore_enabled();
  var_0 setgoalnode(getnode("3f_enemy_node", "targetname"));
  var_0 thread weapon_fire_3f_enemy2_vo();
  var_0 thread temp_ignore();
  return var_0;
}

weapon_fire_3f_enemy2_vo() {
  self endon("death");
  self waittill("weapon_fired");
  scripts\engine\sp\utility::smart_dialogue("dx_vom_aqm4_3rd_floor_balcony_70");
}

bedroom_3f_death() {
  self waittill("death");
  self stopsounds();
  scripts\engine\utility::flag_set("3f_bedroom_guy_dead");
  setsaveddvar("MTTSOONN", 0);
}

temp_ignore() {
  level waittill("close_3f_door");
  wait 4;
  ignore_disabled();
}

spawn_3f_hostage() {
  var_0 = scripts\engine\sp\utility::spawn_targetname("3f_hostage");
  var_0.allowdeath = 1;
  var_0.skipdeathanim = 1;
  var_0.health = 1;
  var_0.no_friendly_fire_fail = 1;
  var_0.nothreat = 0;
  var_0.altdeath = 0;
  var_0 detach(var_0.headmodel);
  var_0.headmodel = "head_sc_f_rezaee";
  var_0 attach(var_0.headmodel);
  var_0 scripts\common\ai::magic_bullet_shield();
  var_0 thread hostage_3f_death();
  var_0 thread hostage_3f_reaction_vo();
  return var_0;
}

hostage_3f_reaction_vo() {
  scripts\engine\utility::flag_wait("3f_bedroom_guy_dead");
  wait 1;
  scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf5_3rd_floor_hostage_30");
}

hostage_3f_death() {
  level endon("civs_moved_to_main_house");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(isDefined(var_9) && var_9.basename == "flash") {
      continue;
    }
    self stopsounds();
    scripts\engine\utility::flag_set("3f_hostage_dead");

    if(isDefined(self.nothreat) && self.nothreat) {
      thread scripts\sp\hud_util::fade_out(0);
      self stopsounds();
      scripts\common\ai::stop_magic_bullet_shield();
      scripts\sp\utility::do_damage(self.health + 1000, var_1.origin, var_1, var_1, var_4, var_9);
      var_14 = [48, 49];
      var_15 = scripts\engine\utility::array_randomize(var_14);
      var_16 = var_15[0];
      scripts\sp\player_death::set_custom_death_quote(var_16);
      scripts\sp\utility::missionfailedwrapper();
      break;
    } else {
      if(isDefined(self.altdeath) && self.altdeath == 1) {
        self.partner.altdeath = 1;
        self.animnode notify("stop_favella_loop");
        thread unarmed_enemy_check();
        self visiblenotsolid();
        self.partner visiblenotsolid();
        self.animnode thread scripts\common\anim::anim_single_solo(self.partner, "3f_favella_death_alt");
        self.animnode scripts\common\anim::anim_single_solo(self, "3f_favella_death_alt");
        self.animnode scripts\common\anim::anim_last_frame_solo(self, "3f_favella_death_alt");

        if(isalive(self.partner))
          self.partner thread kill_partner_altdeath();
      } else {
        scripts\common\ai::stop_magic_bullet_shield();
        scripts\sp\utility::do_damage(self.health + 1000, var_1.origin, var_1, var_1, var_4, var_9);
        thread unarmed_enemy_check();
      }

      break;
    }
  }
}

kill_partner_altdeath() {
  self endon("death");
  self.allowdeath = 1;

  if(scripts\engine\utility::is_equal(self.magic_bullet_shield, 1))
    scripts\common\ai::stop_magic_bullet_shield();

  self kill();
}

enemy_3f_door_action() {
  self endon("death");
  var_0 = 0;
  var_1 = 5;
  var_2 = scripts\engine\utility::getStruct("3f_shoot_door01", "targetname");
  var_3 = spawn("script_origin", var_2.origin);

  for(;;) {
    if(self cansee(level.player) && !scripts\engine\utility::isflashed()) {
      break;
    } else if(!scripts\engine\utility::isflashed()) {
      var_4 = randomintrange(1, 4);
      var_3 = scripts\engine\utility::getStruct("3f_shoot_door0" + var_4, "targetname");
      self shoot(0.9, var_3.origin);
      var_0++;
      wait 0.1;
    } else
      waitframe();

    if(var_0 >= var_1) {
      var_5 = randomintrange(5, 8);
      var_6 = randomfloatrange(0.4, 0.8);
      var_0 = 0;
      var_1 = var_5;
      wait(var_6);
    }
  }

  self getenemyinfo(level.player);
}

bravo1_enters_3f_room(var_0) {
  thread bravo1_3f_shot_at_vo();
  var_0 notify("stop_loop_3f_stairs_idle");
  var_0 scripts\common\anim::anim_single_solo(self, "3f_ally");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "3f_ally_idle", "stop_loop_3f_stairs_idle");
  self.enteredroom = 1;
  scripts\engine\utility::flag_set("bravo1_anim_finished");
}

bravo1_3f_shot_at_vo() {
  if(scripts\engine\utility::flag("player_is_breaching_hallway")) {
    return;
  }
  wait 1.35;
  level.bravo1 scripts\engine\sp\utility::smart_dialogue("dx_vom_b64_3rd_floor_hostage_24");

  if(scripts\engine\utility::flag("3f_favela_guy_dead")) {
    return;
  }
  level endon("3f_favela_guy_dead");
  wait 2.35;
  level.bravo1 scripts\engine\sp\utility::smart_dialogue("dx_vom_b64_3rd_floor_hostage_25");
}

bravo1_3f_ending(var_0) {
  self endon("death");
  scripts\engine\utility::flag_wait_all("bravo1_anim_finished", "3f_cleared");
  self.script_pushable = 0;
  self allowedstances("stand");
  self forceteleport(self.origin, self.angles);
  self enableavoidance(0);
  wait 3.5;
  var_0 notify("stop_loop_3f_stairs_idle");
  scripts\common\utility::demeanor_override("casual_gun");

  if(!isDefined(self.enteredroom)) {
    var_0 thread scripts\common\anim::anim_loop_solo(self, "3f_stairs_idle_end", "stop_loop_3f_stairs_idle");
    var_1 = squared(85);

    for(;;) {
      var_2 = distancesquared(self.origin, level.player.origin);

      if(var_2 >= var_1) {
        break;
      }

      waitframe();
    }

    var_0 notify("stop_loop_3f_stairs_idle");
    var_3 = self.origin + (15, 0, 0) + anglesToForward(level.player.angles) * -30;
    self setgoalpos(var_3);
    var_1 = squared(10);

    for(;;) {
      var_2 = distancesquared(self.origin, var_3);

      if(var_2 <= var_1) {
        break;
      }

      waitframe();
    }
  } else
    wait 1.5;

  self enableavoidance(1);
  scripts\asm\gesture::ai_request_gesture("nvg_off", undefined, 999999, "gesture_finished");
  self playSound("scn_zd30_nvg_up_npc");
  self waittill("gesture_finished");
  var_4 = scripts\engine\utility::getfx("nvg_eyelights");
  stopFXOnTag(var_4, self, "j_nvg");
  var_5 = getnode("bravo1_post_hostage", "targetname");
  self setgoalnode(var_5);
  var_1 = squared(25);

  for(;;) {
    var_2 = distancesquared(self.origin, var_5.origin);

    if(var_2 <= var_1) {
      break;
    }

    waitframe();
  }

  wait 3;
  thread look_at_player_3f();
}

enemy_3f_death(var_0, var_1, var_2, var_3) {
  var_4 = getEnt("3f_favela_weap_clip", "targetname");
  thread enemy_3f_damage(var_0);
  thread enemy_3f_weap_clip(var_4);

  while(self.fakehealth > 0 || self.delaykill)
    waitframe();

  self stopsounds();
  var_4 delete();
  scripts\engine\utility::flag_set("3f_favela_guy_dead");
  var_0 notify("stop_hostage_loop");
  var_0 notify("stop_favella_loop");
  scripts\engine\sp\utility::anim_stopanimScripted();

  if(isalive(var_1))
    var_1 scripts\engine\sp\utility::anim_stopanimScripted();

  thread death_scene_3f(var_0, var_1, var_2, var_3);
}

enemy_3f_damage(var_0) {
  level endon("3f_favela_guy_dead");

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(isDefined(var_5) && var_5 == "MOD_IMPACT")
      continue;
    else if(isDefined(var_10) && var_10.basename == "flash") {
      self.enemyflashed = 1;
      scripts\engine\sp\utility::anim_stopanimScripted();
      self playSound("generic_flashbang_enemy_1");
    }

    self.fakehealth = self.fakehealth - var_1;
  }
}

enemy_3f_weap_clip(var_0) {
  level endon("3f_favela_guy_dead");
  var_0 setCanDamage(1);

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(isDefined(var_5) && var_5 != "MOD_MELEE") {
      var_11 = min(100, var_1);
      self.fakehealth = self.fakehealth - var_11;
    }
  }
}

death_scene_3f(var_0, var_1, var_2, var_3) {
  var_0 notify("stop_favella_loop");
  var_0 notify("stop_first_frame");
  var_0 thread anim_door(var_2, "3f_favella_death_l");
  var_0 thread anim_door(var_3, "3f_favella_death_r");

  if(isalive(var_1))
    var_1 thread death_scene_enemy(var_0);

  var_0 scripts\common\anim::anim_single_solo(self, "3f_favella_death");

  if(!isDefined(self.altdeath))
    var_0 thread scripts\common\anim::anim_loop_solo(self, "3f_favella_death_idle", "stop_favella_loop");

  var_4 = cos(35);
  var_5 = squared(100);

  for(;;) {
    if(isalive(var_1) && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_1.origin, var_4)) {
      break;
    } else if(isalive(var_1) && distancesquared(level.player.origin, var_1.origin) <= var_5) {
      break;
    } else if(distancesquared(level.player.origin, self.origin) <= var_5) {
      break;
    } else if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin, var_4)) {
      break;
    } else
      waitframe();
  }

  scripts\engine\utility::flag_set("start_3f_react");
  var_0 notify("stop_favella_loop");

  if(!isDefined(self.altdeath)) {
    self visiblenotsolid();
    var_0 scripts\common\anim::anim_single_solo(self, "3f_favella_react");
    self.allowdeath = 1;

    if(scripts\engine\utility::is_equal(self.magic_bullet_shield, 1))
      scripts\common\ai::stop_magic_bullet_shield();

    self kill();
  }
}

death_scene_enemy(var_0) {
  level endon("3f_hostage_dead");
  var_0 scripts\common\anim::anim_single_solo(self, "3f_favella_death");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "3f_favella_death_idle", "stop_favella_loop");
  scripts\engine\utility::flag_wait("start_3f_react");
  var_0 notify("stop_favella_loop");
  var_0 scripts\common\anim::anim_single_solo(self, "3f_favella_react");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "3f_favella_react_idle", "stop_loop_" + self.animname);
  self.nothreat = 1;
  thread anim_gun_react(var_0, "3f_favella_react_ads", "3f_favella_react_idle", 18, "start_downstairs_sequence");
  self.deathanim = scripts\engine\utility::getanim("3f_favella_react_death");
  self.disabledeathorient = 1;
  self.noragdoll = 1;
  self.skipdeathanim = undefined;
}

comp_3f_finished_vo() {
  thread scripts\engine\sp\utility::autosave_by_name("3f_cleared_out");
  level.player scripts\engine\utility::delaythread(0.65, scripts\engine\sp\utility::set_player_demeanor, "relaxed");
  thread non_hall_3f_cleared_vo();
}

non_hall_3f_cleared_vo() {
  wait 0.25;
  level.player scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_kyle_3rd_floor_hostage_60");
  level.price scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_pri_3rd_floor_hostage_80");

  if(!scripts\engine\utility::flag("player_at_top_3f_stairs"))
    extra_vo();
  else
    wait 0.1;

  level.bravo2 thread scripts\engine\sp\utility::smart_dialogue("dx_vom_b65_3rd_floor_rally_20");
  wait 0.2;
  thread lights_on_3f();
  level endon("player_at_top_2f_stairs");
  wait 2;

  if(scripts\engine\utility::cointoss())
    level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_3rd_floor_rally_25");
  else
    level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_3rd_floor_rally_30");

  if(!scripts\engine\utility::flag("downstairs_2f")) {
    level endon("downstairs_2f");
    wait 0.5;
    level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_3rd_floor_rally_50");
    level.alex scripts\engine\sp\utility::smart_dialogue("dx_vom_alx_3rd_floor_rally_60");
    level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_3rd_floor_rally_70");
    level.alex scripts\engine\sp\utility::smart_dialogue("dx_vom_alx_3rd_floor_rally_80");
    wait 12;
    level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_downstairs_interrogation_50");
  }
}

extra_vo() {
  level.price scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_pri_3rd_floor_rally_10");

  if(!scripts\engine\utility::flag("player_at_top_3f_stairs"))
    wait 0.65;
}

smart_dialogue_tracked(var_0) {
  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::wait_for_break_in_chatter();
  thread track_dialogue(var_0);
  self endon("dialogue_started");
  self waittill("dialogue_finished", var_0);
}

track_dialogue(var_0, var_1) {
  self.speaking = 1;
  self notify("dialogue_started");
  self endon("dialogue_started");

  if(self == level.player)
    scripts\engine\sp\utility::smart_player_dialogue(var_0);
  else
    scripts\engine\sp\utility::smart_dialogue(var_0);

  self.speaking = 0;
  self notify("dialogue_finished", var_0);
}

wait_finish_speaking() {
  if(istrue(self.speaking))
    self waittill("dialogue_finished");
}

lights_on_3f() {
  thread scripts\engine\utility::play_sound_in_space("scn_zd30_lights_back_on", (360, 1330, 337));
  setsaveddvar("NLOTLQMORR", 0.2);
  var_0 = ["3f_bedroom_light", "2f_dataroom_light", "1f_light", "compound_light", "lgt_outside"];
  thread compound_lights_on(var_0);
  thread power_on_electronics();
  wait 0.2;

  if(level.player scripts\sp\nvg\nvg_player::is_nvg_on())
    thread scripts\sp\nvg\nvg_player::nvg_off_hint(15, 2, undefined, "stop_nvg_off_hint");

  wait 2;
  setsaveddvar("NLOTLQMORR", 0.9);
}

look_at_player_3f() {
  scripts\engine\utility::waittill_any("goal", "goal_reached");
  var_0 = scripts\engine\utility::getStruct("3f_shoot", "targetname");
  var_1 = cos(20);
  wait 1.5;

  for(;;) {
    var_2 = distance(level.player.origin, self.origin);

    if(scripts\engine\utility::flag("downstairs_2f")) {
      break;
    } else {
      if(var_2 <= 160 && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self gettagorigin("j_head"), var_1)) {
        scripts\common\utility::lookatentity(level.player);
        wait 1;
        scripts\asm\gesture::ai_request_gesture("casual_point", var_0);
        wait 2;
        scripts\common\utility::lookatentity();
        wait 11;
        continue;
      }

      waitframe();
    }
  }
}

setup_downstairs_pillage() {
  scripts\engine\utility::flag_clear("player_in_3f_hallway");
  scripts\engine\utility::flag_clear("downstairs_2f");
  scripts\engine\utility::flag_clear("player_at_top_2f_stairs");
  scripts\engine\utility::flag_clear("player_at_2f_stairs");
  scripts\engine\utility::flag_clear("downstairs_1f");
  scripts\engine\utility::flag_clear("player_in_1f_back_room");
  scripts\engine\utility::flag_clear("1f_ambush");
  scripts\engine\utility::flag_clear("tunnels_entrance");
  scripts\engine\utility::flag_clear("player_at_top_3f_stairs");
  var_0 = [level.bravo2, level.bravo4, level.alpha3];
  var_1 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  var_2 = scripts\engine\utility::getStruct("2f_animnode", "targetname");
  var_3 = scripts\engine\utility::getStruct("temp_2f_animnode2", "targetname");
  var_4 = scripts\engine\utility::getStruct("b1_animnode", "targetname");
  var_5 = scripts\engine\utility::getStruct("b1_girl_animnode", "targetname");
  thread fail_for_wild_firing_charlie();
  thread spawn_2f_bags(var_2);
  var_2 scripts\common\anim::anim_first_frame(var_0, "2f_cleanup");
  var_1 scripts\common\anim::anim_first_frame_solo(level.price, "tunnel_stairs_intro");
  var_0 = [level.bravo2, level.bravo4, level.alpha3];
  var_0 thread allies_nvg_on(0);
  scripts\engine\utility::flag_waitopen("downstairs_2f");
  scripts\engine\utility::flag_wait("downstairs_2f");
  level notify("3f_ready_flags_cleared");
  setmusicstate("mx_zd30_exfil_tunnell");
  level notify("start_downstairs_sequence");
  var_1 notify("stop_first_frame");
  var_1 notify("stop_loop_cleanup");
  var_2 notify("stop_first_frame");
  var_2 notify("stop_loop_cleanup");
  var_2 notify("stop_loop_bed_civ");
  var_3 notify("stop_loop_cleanup");
  var_4 notify("b1_child_stop_loop");
  var_5 notify("stop_loop_cleanup");
  thread downstairs_clip_management();
  thread spawn_2f_bodies(var_2);
  var_0 thread cleanup_2f(var_2);
  var_6 = getEntArray("price_bty", "targetname");

  foreach(var_8 in var_6)
  var_8 setlightintensity(var_8.og_intensity);

  thread corpse_cleanup();
  thread comp_cleared_pillage_vo();
  walkto_tunnels(var_1);
}

downstairs_clip_management() {
  thread clip_delete("sse_duffle_clip", "tunnels_transition");
  thread clip_delete("sse_blocker_clip", "tunnels_transition");
  thread clip_delete("1f_interrogation_clip", "player_at_2f_stairs");
  thread clip_delete("1f_price_wait_clip", "stop_landing_price");
  thread clip_delete("1f_price_stairs_clip", "price_on_the_move");
  thread clip_delete("1f_side_breach_clip", "tunnels_transition");
  thread clip_delete("1f_right_room_clip", "tunnels_transition");
  thread clip_delete("1f_hallway_price_walk1_clip", "delete_first_clip");
  thread clip_delete("1f_hallway_price_walk2_clip", "delete_second_clip");
}

fail_for_wild_firing_charlie() {
  level endon("tunnels_transition");
  level endon("start_next_wild_fire");
  var_0 = cos(45);
  var_1 = 0;

  for(;;) {
    level.player scripts\engine\utility::waittill_any("weapon_fired", "player_flash", "player_frag");

    foreach(var_3 in level.charlie) {
      if(isDefined(var_3) && var_3 in_player_fov(var_0))
        var_1 = 1;
    }

    if(var_1) {
      break;
    }
  }

  wait 0.5;
  thread scripts\sp\player_death::set_custom_death_quote(13);
  scripts\sp\utility::missionfailedwrapper();
}

fail_for_wild_firing(var_0) {
  level endon("tunnels_transition");
  level notify("start_next_wild_fire");
  var_1 = [level.bravo2, level.bravo4, level.alpha3, level.overwatch, level.alpha5, level.alpha2, level.prefarah, level.alex];
  var_2 = scripts\engine\utility::array_combine(var_0, level.charlie, var_1);
  var_3 = cos(45);
  var_4 = 0;

  for(;;) {
    level.player scripts\engine\utility::waittill_any("weapon_fired", "player_flash", "player_frag");

    foreach(var_6 in var_2) {
      if(isDefined(var_6) && var_6 in_player_fov(var_3))
        var_4 = 1;
    }

    if(var_4) {
      break;
    }
  }

  wait 0.5;
  thread scripts\sp\player_death::set_custom_death_quote(13);
  scripts\sp\utility::missionfailedwrapper();
}

cleanup_2f(var_0) {
  thread animate_2f_extras(var_0);

  foreach(var_2 in self) {
    var_2 thread flash_allies(var_0);
    var_2 scripts\common\ai::reset_gunpose();
    var_2 thread cleanup_2f_anim(var_0);
  }
}

flash_allies(var_0) {
  level endon("transition");
  self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

  if(isDefined(var_10) && var_10.basename == "flash") {
    wait 0.2;
    scripts\sp\player_death::set_custom_death_quote(10);
    scripts\sp\utility::missionfailedwrapper();
  }
}

cleanup_2f_anim(var_0) {
  level endon("tunnels_transition");
  self endon("stop_sse_anims");
  scripts\common\utility::demeanor_override("casual_gun");
  var_0 scripts\common\anim::anim_single_solo(self, "2f_cleanup");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "2f_cleanup_idle", "stop_loop_" + self.animname);
  thread lookat_random("tunnels_transition");
}

corpse_cleanup() {
  var_0 = scripts\engine\utility::getStruct("1f_tele_bravo5_midway", "targetname");
  var_1 = squared(100);
  var_2 = getcorpsearray();

  foreach(var_4 in var_2) {
    var_5 = var_4 scripts\engine\sp\utility::get_corpse_origin();

    if(distancesquared(var_0.origin, var_5) < var_1)
      var_4 delete();
  }
}

spawn_2f_bodies(var_0) {
  var_0 notify("stop_last_frame");

  foreach(var_2 in level.dataenemies) {
    var_2 visiblenotsolid();
    var_3 = scripts\engine\utility::getStruct(var_2.animname + "_2f_cleanup_struct", "targetname");
    var_3 scripts\common\anim::anim_first_frame_solo(var_2, "2f_cleanup");
  }
}

spawn_2f_extras(var_0) {
  level.sse_bags = [];
  level.sse_items = [];
  var_1 = 42;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = "sse" + var_2;

    if(var_3 == "sse1" || var_3 == "sse2" || var_3 == "sse5" || var_3 == "sse6" || var_3 == "sse9" || var_3 == "sse10") {
      level.sse_bags[level.sse_bags.size] = var_3;
      continue;
    }

    var_4 = scripts\engine\sp\utility::spawn_anim_model(var_3);
    var_0 scripts\common\anim::anim_first_frame_solo(var_4, "2f_cleanup");
    level.sse_items[level.sse_items.size] = var_4;
  }
}

spawn_2f_bags(var_0) {
  foreach(var_2 in level.sse_bags) {
    var_3 = scripts\engine\sp\utility::spawn_anim_model(var_2);
    var_0 scripts\common\anim::anim_first_frame_solo(var_3, "2f_cleanup");
    level.sse_items[level.sse_items.size] = var_3;
  }
}

animate_2f_extras(var_0) {
  var_0 notify("stop_first_frame");
  var_0 thread scripts\common\anim::anim_single(level.sse_items, "2f_cleanup");
}

comp_cleared_pillage_vo() {
  level endon("player_at_top_2f_stairs");
  level.bravo4 scripts\engine\sp\utility::smart_dialogue("dx_vom_a33_downstairs_sse_10");
  wait 1.2;
  level.bravo2 scripts\engine\sp\utility::smart_dialogue("dx_vom_a36_downstairs_sse_20");
  wait 1.8;
  level.alpha3 scripts\engine\sp\utility::smart_dialogue("dx_vom_a35_downstairs_sse_30");
  wait 3.35;
  level.bravo2 scripts\engine\sp\utility::smart_dialogue("dx_vom_a36_downstairs_sse_80");
  wait 2.65;
  level.alpha3 scripts\engine\sp\utility::smart_dialogue("dx_vom_a35_downstairs_sse_90");
  wait 2.8;
  level.bravo4 scripts\engine\sp\utility::smart_dialogue("dx_vom_a33_downstairs_sse_100");
  wait 0.6;
  level.bravo2 scripts\engine\sp\utility::smart_dialogue("dx_vom_a36_downstairs_sse_110");
}

show_targetnames() {
  for(;;) {
    var_0 = getaiarray();
    var_1 = getEntArray();
    var_2 = scripts\engine\utility::array_combine(var_0, var_1);

    foreach(var_4 in var_2) {
      if(isDefined(var_4.targetname)) {}
    }

    waitframe();
  }
}

background_civ_vo() {
  level.walkto_mom scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf1_downstairs_interrogation_120");
  level.walkto_boy scripts\engine\sp\utility::smart_dialogue("dx_vom_aqby_downstairs_interrogation_130");
  level.walkto_mom = undefined;
  level.walkto_boy = undefined;
}

comp_cleared_price_stairs_vo() {
  thread background_civ_vo();
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_downstairs_interrogation_90");
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_downstairs_interrogation_100");
  scripts\engine\utility::flag_wait("player_at_2f_stairs");
  level.aq_female_1 = level.player;
  var_0 = getEntArray("1f_civ_left_room", "targetname");

  foreach(var_2 in var_0) {
    if(var_2.animname == "kid1")
      level.aq_boy_1 = var_2;
  }

  level waittill("stop_landing_price");
}

child_fail_watcher() {
  level endon("tunnels_transition");
  self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  if(isDefined(var_9) && var_9.basename == "flash") {
    wait 0.2;
    scripts\sp\player_death::set_custom_death_quote(10);
    scripts\sp\utility::missionfailedwrapper();
  } else {
    thread scripts\sp\hud_util::fade_out(0);
    var_10 = [22, 23];
    var_11 = scripts\engine\utility::array_randomize(var_10);
    var_12 = var_11[0];
    scripts\sp\player_death::set_custom_death_quote(var_12);
    scripts\sp\utility::missionfailedwrapper();
  }
}

adult_fail_watcher() {
  level endon("tunnels_transition");
  self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  if(isDefined(var_9) && var_9.basename == "flash") {
    wait 0.2;
    scripts\sp\player_death::set_custom_death_quote(10);
    scripts\sp\utility::missionfailedwrapper();
  } else {
    thread scripts\sp\hud_util::fade_out(0);
    self stopsounds();
    var_10 = [48, 49];
    var_11 = scripts\engine\utility::array_randomize(var_10);
    var_12 = var_11[0];
    scripts\sp\player_death::set_custom_death_quote(var_12);
    scripts\sp\utility::missionfailedwrapper();
  }
}

walkto_tunnels(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = [];
  var_4 = 2;
  var_5 = scripts\engine\utility::array_removedead([level.dataciv, level.bedciv, level.b1_child]);
  var_6 = scripts\engine\sp\utility::get_living_ai_array("1f_civ_left_room", "targetname");
  var_7 = scripts\engine\utility::array_combine(var_5, var_6);

  foreach(var_9 in var_7) {
    if(var_9.animname == "civ03") {
      var_0 notify("stop_loop_" + var_9.animname);
      var_9.animname = "kid1";
      var_3[var_3.size] = var_9;
      level.walkto_boy = var_9;
      var_9 thread child_fail_watcher();
      continue;
    }

    if(var_9.animname == "building1_child") {
      var_0 notify("stop_loop_" + var_9.animname);
      var_9.animname = "kid2";
      var_9 thread child_fail_watcher();
      continue;
    }

    var_0 notify("stop_loop_" + var_9.animname);

    if(scripts\engine\utility::is_equal(var_9.animname, "civ01")) {
      var_9.animname = "civ1";
      var_3[var_3.size] = var_9;
      level.walkto_mom = var_9;
    } else {
      var_9.animname = "civ" + var_4;
      var_4++;
    }

    var_9 thread adult_fail_watcher();
  }

  level notify("civs_moved_to_main_house");
  var_11 = [level.alpha4, level.alpha6, level.bravo5];
  var_12 = scripts\engine\utility::array_combine(var_11, var_7, [level.price]);

  if(var_3.size < 2) {
    var_13 = scripts\engine\sp\utility::spawn_targetname("1f_civ_backup1", 1);
    var_13.animname = "civ1";
    var_13.allowdeath = 1;
    var_13.skipdeathanim = 1;
    var_13 ignore_enabled();
    var_13 scripts\engine\sp\utility::set_battlechatter(0);
    var_13 scripts\sp\utility::context_melee_allow(0);
    var_3[var_3.size] = var_13;
    var_12 = scripts\engine\utility::array_add(var_12, var_13);
  }

  foreach(var_9 in var_12) {
    if(isDefined(level.scr_anim[var_9.animname]["tunnel_intro"])) {
      var_0 scripts\common\anim::anim_first_frame_solo(var_9, "tunnel_intro");
      var_1[var_1.size] = var_9;
      continue;
    }

    var_0 thread scripts\common\anim::anim_loop_solo(var_9, "tunnel_intro_idle", "stop_tunnel_intro_loop");
  }

  thread fail_for_wild_firing(var_12);
  var_11 thread allies_nvg_on(0);
  level.price thread walkto_1f_price_anims(var_0);
  thread scripts\engine\sp\utility::autosave_now();
  thread extra_sas_guys();
  var_0 notify("stop_first_frame");
  var_16 = [level.alpha4, level.alpha6, var_3[0], var_3[1]];
  scripts\engine\utility::array_thread(var_16, ::walkto_1f_anims, var_0);
  level waittill("price_finished_stairs_move");
  scripts\engine\utility::flag_wait("player_at_2f_stairs");
  var_0 notify("stop_1f_loop_scene");
  var_0 notify("stop_last_frame");
  thread delete_clip_during_walk();
  scripts\engine\utility::array_thread(var_1, ::walkto_door_anims, var_0);
  objective_control("wait_for_price");
  level waittill("price_finished_hallway_move");
  thread audio_heli_fade_up();
  scripts\engine\utility::flag_clear("1f_ambush");
  scripts\engine\utility::flag_wait("1f_ambush");
  setup_kyledrone(var_0);
  level notify("stop_landing_price");
  var_0 notify("stop_landing_price");
  thread audio_heli_end_fade_out();
  objective_control("tea_room");
  thread teahouse_walk_vo();
  thread trap_door_plywood(var_0);
  scripts\engine\utility::array_call(level.charlie, ::unlink);
  level.revealrope = scripts\engine\sp\utility::spawn_anim_model("reveal_rope");
  var_12 = scripts\engine\utility::array_combine(level.charlie, [level.price, level.heli_charlie, level.revealrope]);
  scripts\engine\utility::array_thread(var_12, ::walkto_tunnels_anim, var_0);
  wait 10;
  objective_control("lift_trap_door");
}

audio_heli_fade_up() {
  level.heli_charlie scalevolume(1.0, 4.0);
}

audio_heli_end_fade_out() {
  wait 12;
  level.heli_charlie scalevolume(0.0, 12.0);
}

delete_clip_during_walk() {
  level thread scripts\engine\sp\utility::notify_delay("delete_first_clip", 5.1);
  level thread scripts\engine\sp\utility::notify_delay("delete_second_clip", 6.2);
}

extra_sas_guys() {
  var_0 = getnodearray("tea_room_extra", "targetname");
  var_1 = [level.overwatch, level.alpha5, level.alpha2];
  var_1 thread allies_nvg_on(0);
  var_2 = 0;

  foreach(var_4 in var_1) {
    var_4 forceteleport(var_0[var_2].origin, var_0[var_2].angles);
    var_4 scripts\common\utility::demeanor_override("casual_gun");
    var_4 setgoalnode(var_0[var_2]);
    var_4.script_pushable = 0;
    var_2++;
  }
}

teahouse_walk_vo() {
  if(scripts\engine\utility::flag("trap_door_interacted")) {
    return;
  }
  level endon("trap_door_interacted");
  wait 1;
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_downstairs_interrogation_280");
  wait 2;
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_downstairs_teahouse_128");
  var_0 = [];
  var_0[var_0.size] = [level.price, "dx_vom_pri_downstairs_teahouse_130"];
  var_0[var_0.size] = [level.price, "dx_vom_pri_downstairs_teahouse_140"];
  var_0[var_0.size] = [level.alex, "dx_vom_alx_downstairs_teahouse_150"];

  foreach(var_2 in var_0) {
    var_2[0] scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say(var_2[1]);
    wait(randomfloatrange(6, 12));
  }
}

trap_door_scene() {
  var_0 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  var_1 = [level.price, level.alex, level.prefarah, level.kyledrone, level.revealrope];
  var_2 = scripts\engine\utility::getStruct("tunnel_door", "targetname");
  var_2.angles = (0, 125, 0);
  var_2 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 7), &"ZD30/LIFT", 250, 180, 80, 1, undefined, undefined, undefined, undefined, undefined, undefined, 65, 70);
  var_2 waittill("trigger");
  level notify("tunnel_door_triggered");
  trap_door_nvg_reset();
  thread trap_door_extras();
  level.player hidelegs();
  level.player thread tunnels_door_player_extras();
  var_3 = getDvar("OMNONNMOTP");
  setsaveddvar("OMNONNMOTP", "0.1 500 1 10000");
  var_4 = var_0 scripts\sp\player_rig::link_player_to_rig("entrance", undefined, 1, 0.2, 1, 0, 0, 0, 0);
  var_0 notify("stop_landing_charlie");
  thread cinematic_camera_settings_tea_house();
  thread audio_zd30_transition_to_tunnels();
  var_5 = scripts\engine\utility::array_combine(var_1, [var_4, level.tunnel_door[0]]);
  scripts\engine\utility::delaythread(1, ::skippable_tunnels_transition, var_5);
  thread tunnels_door_anim(var_0);
  var_0 thread scripts\common\anim::anim_single_solo(var_4, "entrance");
  var_0 scripts\common\anim::anim_single(var_1, "entrance");
  scripts\sp\utility::userskip_stop();
  level.player freezelookcontrols(0);
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  level notify("tunnels_transition");
  setsaveddvar("OMNONNMOTP", var_3);
  thread scripts\sp\analytics::analytics_kleenex_update("Compound");
}

trap_door_nvg_reset() {
  var_0 = scripts\common\input_allow::allow_input_internal("NVG", 0, "zd30Tunnels");
  level.player setactionslot(2, "");

  if(level.player isnightvisionon()) {
    level.player nightvisionviewoff();
    wait 0.4;
  }

  thread trap_door_nvg_reset_catch();
}

trap_door_nvg_reset_catch() {
  wait 2;

  if(level.player isnightvisionon())
    level.player nightvisiongogglesforceoff();
}

audio_zd30_transition_to_tunnels() {}

skippable_tunnels_transition(var_0) {
  var_1 = scripts\sp\utility::userskip_wait();

  if(!var_1) {
    return;
  }
  scripts\sp\hud_util::fade_out(0);
  var_2 = "entrance";
  var_3 = 1.1;

  foreach(var_5 in var_0) {
    if(!isDefined(var_5)) {
      continue;
    }
    if(var_5.animname == "tunnel_door") {
      var_5 delete();
      continue;
    }

    var_6 = getanimlength(var_5 scripts\engine\utility::getanim(var_2));
    var_7 = (var_6 - var_3) / var_6;
    var_5 setanimtime(var_5 scripts\engine\utility::getanim(var_2), var_7);
    var_5 stopsounds();
  }

  if(isDefined(level.kyle))
    level.kyle delete();

  var_3 = 1;
  level.player modifybasefov(65, 0.05);
  level.player lerpfovscalefactor(1, var_3);
  scripts\engine\utility::flag_set("tunnels_transiton_skipped");
  level.player clearcinematicmotionoverride();
  setomnvar("ui_hide_hud", 0);
  level.player unlink();
  level.player_rig hide();
}

tunnels_door_anim(var_0) {
  level endon("userskipped");
  var_0 scripts\common\anim::anim_single_solo(level.tunnel_door[0], "entrance");
  var_0 scripts\common\anim::anim_last_frame_solo(level.tunnel_door[0], "entrance");
}

cinematic_camera_settings_tea_house() {
  scripts\engine\sp\utility::dof_enable(12, 25);
  wait 6;
  scripts\engine\sp\utility::dof_enable(2.8, 300);
  wait 6;
  level.alex scripts\engine\sp\utility::dof_enable_autofocus(4, 3, undefined, undefined, "tag_eye", undefined, 1);
  wait 7;
  scripts\engine\sp\utility::dof_disable();
}

trap_door_extras() {
  scripts\engine\utility::flag_set("trap_door_interacted");
  objective_control("clear_compound_obj");
  thread enter_trap_door_vo();
  thread trap_door_fx();
  thread mus_tunnel_discover();
}

trap_door_plywood(var_0) {
  level.tunnel_door = compound_door_setup("tunnel_door");
  level.tunnel_door[0] scripts\engine\sp\utility::assign_animtree("tunnel_door");
  var_0 scripts\common\anim::anim_first_frame_solo(level.tunnel_door[0], "entrance");
}

mus_tunnel_discover() {
  wait 1;
  setmusicstate("");
}

trap_door_rock(var_0) {
  var_1 = scripts\engine\sp\utility::spawn_anim_model("rock");
  var_0 scripts\common\anim::anim_single_solo(var_1, "entrance");
}

trap_door_fx() {
  scripts\engine\utility::delaythread(19.8, scripts\engine\utility::exploder, "rock_to_black");
}

setup_fake_bomber(var_0) {
  var_1 = scripts\engine\utility::getStruct("tunnel_bomber", "targetname");
  var_2 = scripts\engine\sp\utility::spawn_targetname("fake_bomber");
  var_2 scripts\engine\sp\utility::set_battlechatter(0);
  wait 0.2;
  var_1 scripts\common\anim::anim_first_frame_solo(var_2, "tunnels_bomber");
  wait 18;
  var_1 thread scripts\common\anim::anim_single_solo(var_2, "tunnels_bomber");
  var_3 = var_2 scripts\engine\utility::getanim("tunnels_bomber");
  var_2 setanimrate(var_3, 0.7);
  var_2 waittillmatch("single anim", "end");
  var_1 scripts\common\anim::anim_last_frame_solo(var_2, "tunnels_bomber");
  wait 2;
  var_2 delete();
}

enter_trap_door_vo() {
  level endon("userskipped");
  wait 15;
  var_0 = spawnStruct();
  var_0.origin = level.alex.origin;
  wait 4;
  level.prefarah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_downstairs_teahouse_220");
  scripts\engine\utility::play_sound_in_space("dx_vom_alx_downstairs_teahouse_230", var_0.origin);
}

setup_kyledrone(var_0) {
  level.kyledrone = scripts\engine\sp\utility::spawn_targetname("kyle");
  var_0 scripts\common\anim::anim_first_frame_solo(level.kyledrone, "entrance");
  level.kyledrone hide();
}

walkto_1f_price_anims(var_0) {
  scripts\engine\utility::flag_wait("downstairs_2f");
  wait 0.7;

  if(!level.player issprinting())
    wait 0.8;

  var_0 scripts\common\anim::anim_single_solo(self, "tunnel_stairs_intro");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "tunnel_stairs_intro_idle", "stop_loop_" + self.animname);
  scripts\engine\utility::flag_wait("player_at_top_2f_stairs");
  thread comp_cleared_price_stairs_vo();
  wait 0.7;
  level notify("price_on_the_move");
  var_0 notify("stop_loop_" + self.animname);
  var_0 scripts\common\anim::anim_single_solo(self, "tunnel_stairs");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "tunnel_stairs_idle", "stop_1f_loop_scene");
  level notify("price_finished_stairs_move");
}

price_nvg_check() {
  var_0 = [level.price];
  var_0 thread allies_nvg_on(0);
}

walkto_1f_anims(var_0) {
  if(!scripts\engine\utility::flag("player_at_2f_stairs"))
    var_0 scripts\common\anim::anim_loop_solo(self, "tunnel_stairs_idle", "stop_1f_loop_scene");
}

walkto_door_anims(var_0) {
  level endon("tunnels_transition");
  var_0 scripts\common\anim::anim_single_solo(self, "tunnel_intro");

  if(self.animname == "price") {
    var_0 thread scripts\common\anim::anim_loop_solo(self, "tunnel_intro_idle", "stop_landing_price");
    level notify("price_finished_hallway_move");
  } else if(isDefined(self) && isalive(self))
    var_0 thread scripts\common\anim::anim_loop_solo(self, "tunnel_intro_idle", "stop_tunnel_intro");
}

walkto_tunnels_anim(var_0) {
  if(self.animname == "heli_charlie")
    scripts\common\utility::vehicle_detachfrompath();

  if(self.animname == "price" || self.animname == "kyle" || self.animname == "alex" || self.animname == "farah")
    level endon("tunnel_door_triggered");

  var_0 scripts\common\anim::anim_single_solo(self, "landing");

  if(isDefined(level.scr_anim[self.animname]["landing_idle"]))
    var_0 thread scripts\common\anim::anim_loop_solo(self, "landing_idle", "stop_landing_charlie");
  else if(self.animname == "heli_charlie")
    self delete();
  else {
    if(isDefined(self.magic_bullet_shield))
      scripts\common\ai::stop_magic_bullet_shield();

    if(isDefined(self))
      self delete();
  }
}

greenlight_end(var_0) {
  if(getdvarint("greenlight") == 1) {
    var_0 thread scripts\common\anim::anim_single_solo(level.price, "tunnel_intro");
    wait 7.5;
    level.player setclienttriggeraudiozone("fade_to_black", 3);
    thread scripts\sp\hud_util::fade_out(3, "black");
    wait 3;
    thread scripts\sp\hud_util::fade_in(0.1, "black");
    waitframe();
    setculldist(1);
    levelsoundfade(0, 0.1);
    level.player disableweapons();
    setomnvar("ui_hide_dpad_hud", 1);
    level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
    setomnvar("ui_hide_weapon_info", 1);
    setomnvar("ui_hide_hud", 1);
    var_1 = scripts\sp\hud_util::create_client_overlay("black", 1);
    scripts\engine\utility::flag_wait("forever");
  }
}

tunnels_door_player_extras() {
  level.player freezelookcontrols(1);
  level.player scripts\engine\utility::delaycall(3.2, ::modifybasefov, 80, 4);
  level.player scripts\engine\utility::delaycall(16.3, ::modifybasefov, 55, 3.5);
  scripts\engine\utility::delaythread(17.6, ::fake_bomber_audio);
}

fake_bomber_audio() {
  var_0 = scripts\engine\utility::getStructArray("tunnel_fireball_fx", "targetname");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0[0].origin, var_0[0].angles);
  var_1 scripts\engine\utility::playsoundonentity("generic_falldeath_enemy_6");
}

dynamic_run_setup() {
  if(self.animname == "bravo5" || self.animname == "alpha3" || self.animname == "alpha6")
    scripts\common\utility::demeanor_override("cqb");
  else
    scripts\engine\sp\utility::enable_dynamic_run_speed(level.player, 125, 205, 250);
}

ignore_enabled() {
  self.ignoreme = 1;
  self.ignoreall = 1;
}

ignore_disabled() {
  self.ignoreme = 0;
  self.ignoreall = 0;
}

unarmed_enemy_check() {
  if(isDefined(self.unarmed) && !self.unarmed) {
    return;
  }
  var_0 = cos(70);
  var_1 = spawnStruct();
  var_1.origin = self.origin;
  level.unarmedkilled++;

  if(level.unarmedkilled >= 3) {
    scripts\engine\utility::flag_clear("can_save");
    scripts\sp\player_death::set_custom_death_quote(50);
    scripts\sp\utility::missionfailedwrapper();
  }

  wait 0.6;
  level endon("3f_scene_done");
  var_1 scripts\engine\sp\utility::waittill_player_lookat(0.8);
  var_2 = get_unarmed_response();
  level.player scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter(var_2, 0, 0.2);
}

get_unarmed_response() {
  if(isDefined(level.player.unarmed_responses))
    return level.player.unarmed_responses scripts\engine\sp\utility::deck_draw();

  var_0 = [];
  var_0[var_0.size] = "dx_vom_kyle_civkill_reactions_10";
  var_0[var_0.size] = "dx_vom_kyle_civkill_reactions_20";
  var_0[var_0.size] = "dx_vom_kyle_civkill_reactions_30";
  var_0[var_0.size] = "dx_vom_kyle_civkill_reactions_40";
  var_0[var_0.size] = "dx_vom_kyle_civkill_reactions_50";
  var_0[var_0.size] = "dx_vom_kyle_civkill_reactions_60";
  level.player.unarmed_responses = scripts\engine\sp\utility::create_deck(var_0, 0);
  return level.player.unarmed_responses scripts\engine\sp\utility::deck_draw();
}

link_player_to_rig_free_look(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = scripts\sp\player_rig::get_player_rig(1);

  if(isDefined(var_10))
    var_11[[var_10]]();

  var_11 hide();
  thread scripts\common\anim::anim_first_frame_solo(var_11, var_0);
  var_11.ogstance = level.player getstance();

  if(!isDefined(var_1))
    var_1 = "stand";

  var_11.stance = var_1;

  switch (var_1) {
    case "stand":
      level.player scripts\common\utility::allow_crouch(0, "player_rig");
      level.player scripts\common\utility::allow_prone(0, "player_rig");
      break;
    case "crouch":
      level.player scripts\common\utility::allow_stand(0, "player_rig");
      level.player scripts\common\utility::allow_prone(0, "player_rig");
      break;
    case "prone":
      level.player scripts\common\utility::allow_stand(0, "player_rig");
      level.player scripts\common\utility::allow_crouch(0, "player_rig");
      break;
  }

  level.player setstance(var_1);

  if(!isDefined(var_2))
    var_2 = 1;

  if(var_2) {
    if(!isDefined(var_3))
      var_3 = 0.2;

    level.player playerlinktoblend(var_11, "tag_player", var_3);
    wait(var_3);
  }

  if(istrue(var_4))
    level.player playerlinktoabsolute(var_11, "tag_player");
  else {
    if(!isDefined(var_5))
      var_5 = 45;

    if(!isDefined(var_6))
      var_6 = 45;

    if(!isDefined(var_7))
      var_7 = 35;

    if(!isDefined(var_8))
      var_8 = 35;

    if(!isDefined(var_9))
      var_9 = 0;

    level.player playerlinktodelta(var_11, "tag_player", 1, var_5, var_6, var_7, var_8, var_9);
  }

  return var_11;
}

unlink_player_from_rig_free_look(var_0, var_1) {
  var_2 = level.player_rig;

  if(!scripts\engine\utility::is_equal(level.player getlinkedparent(), var_2)) {
    return;
  }
  scripts\engine\utility::flag_set("lb_landed");
  level.player unlink();

  switch (var_2.stance) {
    case "stand":
      level.player scripts\common\utility::allow_crouch(1, "player_rig");
      level.player scripts\common\utility::allow_prone(1, "player_rig");
      break;
    case "crouch":
      level.player scripts\common\utility::allow_stand(1, "player_rig");
      level.player scripts\common\utility::allow_prone(1, "player_rig");
      break;
    case "prone":
      level.player scripts\common\utility::allow_stand(1, "player_rig");
      level.player scripts\common\utility::allow_crouch(1, "player_rig");
      break;
  }

  if(istrue(var_0))
    level.player setstance(var_2.ogstance);
  else if(isDefined(var_1))
    level.player setstance(var_1);

  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  var_2 delete();
}

allies_nvg_on(var_0) {
  if(var_0) {
    foreach(var_2 in self) {
      if(!istrue(var_2.nvg_on)) {
        var_2.nvg_on = 1;
        var_2 thread ai_nvg_down();
      }
    }
  } else {
    foreach(var_2 in self) {
      if(istrue(var_2.nvg_on)) {
        var_2.nvg_on = 0;
        var_2 thread ai_nvg_up();
      }
    }
  }
}

#using_animtree("generic_human");

ai_nvg_up(var_0, var_1) {
  var_2 = self getanimweight(%sdr_ges_nvg_lower_nvg);

  if(var_2 > 0)
    self clearanim(%sdr_ges_nvg_lower_nvg, 0);

  self setanim(%sdr_ges_nvg_raise_nvg, 1, 0, 1.0);
  var_3 = scripts\engine\utility::getfx("nvg_eyelights");

  if(self.animname == "price")
    var_3 = scripts\engine\utility::getfx("nvg_eyelights_price");

  self.visor_down = 0;
  scripts\asm\asm_sp::asm_trynvgmodelswap();
  stopFXOnTag(var_3, self, "j_nvg");
}

ai_nvg_down(var_0, var_1) {
  var_2 = self getanimweight(%sdr_ges_nvg_raise_nvg);

  if(var_2 > 0)
    self clearanim(%sdr_ges_nvg_raise_nvg, 0);

  self setanim(%sdr_ges_nvg_lower_nvg, 1, 0, 1.0);
  wait 0.4;
  self.visor_down = 1;
  scripts\asm\asm_sp::asm_trynvgmodelswap();
  var_3 = scripts\engine\utility::getfx("nvg_eyelights");

  if(self.animname == "price")
    var_3 = scripts\engine\utility::getfx("nvg_eyelights_price");

  playFXOnTag(var_3, self, "j_nvg");
}

start_point_nvg_on_hint() {
  wait 1;

  if(level.player scripts\sp\nvg\nvg_player::is_nvg_off())
    thread scripts\sp\nvg\nvg_player::nvg_on_hint(8);
}

spawn_glowstick_on_struct(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  playFX(level._effect["vfx_interior_glow_stick"], var_1.origin, anglesToForward(var_1.angles), anglestoright(var_1.angles));
}

notetrack_nag(var_0, var_1, var_2) {
  level endon(var_1);

  if(isDefined(var_2))
    level endon(var_2);

  for(;;) {
    foreach(var_4 in var_0) {
      self waittill("nag");
      scripts\engine\sp\utility::smart_dialogue(var_4);
    }

    level.player thread scripts\sp\player::focus_display_hint(undefined, 6);
  }
}

lookat_random(var_0) {
  level endon(var_0);
  var_1 = 0.1;
  var_2 = 0.5;
  var_3 = 3;
  var_4 = 5;
  var_5 = squared(70);
  var_6 = squared(100);
  var_7 = gettime() + randomfloatrange(2, 5) * 1000;
  var_8 = self getEye() + anglesToForward(self gettagangles("tag_eye")) * 20;
  var_9 = var_8 + anglestoleft(self gettagangles("tag_eye")) * 20;
  var_10 = var_8 + anglestoright(self gettagangles("tag_eye")) * 20;
  self.stop_lookat_random = 0;
  var_11 = [var_9, var_10];

  for(;;) {
    var_12 = scripts\engine\utility::array_randomize(var_11);

    if(istrue(self.stop_lookat_random)) {
      break;
    }

    foreach(var_14 in var_12) {
      var_15 = var_14 + (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-12, 12));
      scripts\common\utility::lookatpos(var_15);
      var_16 = randomfloatrange(var_3, var_4);
      var_16 = gettime() + var_16 * 1000;

      while(gettime() < var_16) {
        if(distancesquared(level.player.origin, self.origin) < var_5) {
          var_7 = 0;
          break;
        }

        wait 0.1;
      }

      if(gettime() > var_7 && distancesquared(level.player.origin, self.origin) < var_6) {
        var_7 = gettime() + randomfloatrange(5, 7) * 1000;
        var_17 = randomfloatrange(var_3, var_4);
        scripts\common\utility::lookatentity(level.player);

        while(distancesquared(level.player.origin, self.origin) < var_6) {
          wait(randomfloatrange(2, 3.5));
          scripts\common\utility::lookatentity();
          wait(randomfloatrange(6, 9));
          scripts\common\utility::lookatentity(level.player);
        }

        waitframe();
        scripts\common\utility::lookatentity();
      }
    }

    waitframe();
  }

  scripts\common\utility::lookatentity();
  scripts\common\utility::lookatpos();
}

lookat_random_lite(var_0) {
  level endon(var_0);
  var_1 = 0.1;
  var_2 = 0.5;
  var_3 = 3;
  var_4 = 5;
  var_5 = squared(70);
  var_6 = squared(100);
  var_7 = gettime() + randomfloatrange(2, 5) * 1000;
  self.stop_lookat_random = 0;

  for(;;) {
    if(istrue(self.stop_lookat_random)) {
      break;
    }

    var_8 = randomfloatrange(var_3, var_4);
    var_8 = gettime() + var_8 * 1000;

    while(gettime() < var_8) {
      if(distancesquared(level.player.origin, self.origin) < var_5) {
        var_7 = 0;
        break;
      }

      wait 0.1;
    }

    if(gettime() > var_7 && distancesquared(level.player.origin, self.origin) < var_6) {
      var_7 = gettime() + randomfloatrange(5, 7) * 1000;
      var_9 = randomfloatrange(var_3, var_4);
      scripts\common\utility::lookatentity(level.player);

      while(distancesquared(level.player.origin, self.origin) < var_6) {
        wait(randomfloatrange(2, 3.5));
        scripts\common\utility::lookatentity();
        wait(randomfloatrange(6, 9));
        scripts\common\utility::lookatentity(level.player);
      }

      waitframe();
      scripts\common\utility::lookatentity();
    }

    waitframe();
  }

  scripts\common\utility::lookatentity();
}

play_single_anim_player(var_0) {
  self.plays_single_anim = 1;
  self.intronode = spawn("script_origin", level.infil_heli_alpha getorigin("body_animate_jnt"));
  self.intronode linkTo(level.infil_heli_alpha, "body_animate_jnt", (0, 0, 0), (0, 0, 0));
  self linkTo(self.intronode);
  level endon("heli_intro_skipped");
  self.intronode scripts\common\anim::anim_single_solo(self, "heli_pre_intro");
  scripts\engine\utility::flag_set("pre_anim_finished");
  level.intro_checks["first_anim_over"] = 1;
  self.intronode scripts\common\anim::anim_single_solo(self, "heli_intro");
  self showpart("j_clavicle_le");
  self showpart("j_wrist_ri");
}

play_single_anim(var_0) {
  self.plays_single_anim = 1;
  level endon("heli_intro_skipped");
  var_0 scripts\common\anim::anim_single_solo(self, "heli_pre_intro");
  var_0 scripts\common\anim::anim_single_solo(self, "heli_intro");
  childthread loop_or_delete(var_0);
}

loop_or_delete(var_0) {
  if(isDefined(level.scr_anim[self.animname]["heli_intro_idle"])) {
    var_0 thread scripts\common\anim::anim_loop_solo(self, "heli_intro_idle", "stop_heli_intro_" + self.animname);

    if(self.animname == "alpha5")
      scripts\engine\utility::flag_set("sledge_ready");
  } else if(self.animname == "alphaP1" || self.animname == "alphaP2" || self.animname == "bravoP1" || self.animname == "bravoP2" || self.animname == "charlie1" || self.animname == "charlie2" || self.animname == "charlie3" || self.animname == "charlie4" || self.animname == "farah" || self.animname == "alex")
    self delete();
  else if(self.animname == "heli_bravo" || self.animname == "heli_alpha" || self.animname == "heli_charlie")
    self delete();
}

play_multi_anim(var_0, var_1) {
  self.plays_single_anim = 0;
  self.intronode = spawn("script_origin", var_1 getorigin(self.introtag));
  self.intronode linkTo(var_1, self.introtag, (0, 0, 0), (0, 0, 0));
  self linkTo(self.intronode);
  level endon("heli_intro_skipped");
  self.intronode scripts\common\anim::anim_single_solo(self, "heli_pre_intro");
  self.intronode scripts\common\anim::anim_single_solo(self, "heli_intro");
  childthread loop_or_anim(var_0);
}

loop_or_anim(var_0) {
  self unlink();
  var_0 scripts\common\anim::anim_single_solo(self, "heli_unload");

  if(self.animname == "overwatch")
    thread overwatch_setup();
  else if(isDefined(level.scr_anim[self.animname]["heli_intro_idle"])) {
    var_0 thread scripts\common\anim::anim_loop_solo(self, "heli_intro_idle", "stop_heli_intro_" + self.animname);

    if(self.animname == "alpha5")
      scripts\engine\utility::flag_set("sledge_ready");
  }

  if(isDefined(self.intronode))
    self.intronode delete();
}

anim_gun_react(var_0, var_1, var_2, var_3, var_4) {
  level endon(var_4);
  self endon("death");
  var_5 = 0;
  var_6 = cos(var_3);
  var_7 = cos(var_3 + 10);

  for(;;) {
    if(in_player_fov(var_6)) {
      var_0 notify("stop_loop_" + self.animname);
      var_0 scripts\common\anim::anim_single_solo(self, var_1);
      var_5++;
      var_0 thread scripts\common\anim::anim_loop_solo(self, var_2, "stop_loop_" + self.animname);

      while(in_player_fov(var_7))
        waitframe();

      wait 1.5;
    }

    if(var_5 >= 3) {
      var_8 = randomfloatrange(4, 6);
      wait(var_8);
    }

    waitframe();
  }
}

anim_gun_react_and_idle(var_0, var_1, var_2, var_3, var_4) {
  level endon(var_4);
  self endon("death");
  var_5 = 0;
  self.iamflashed = 0;
  var_6 = cos(var_3);
  var_7 = cos(var_3 + 10);

  for(;;) {
    if(self.iamflashed) {
      var_0 notify("stop_loop_" + self.animname);
      self notify("scared_reaction_started");
      var_0 scripts\common\anim::anim_single_solo(self, var_1);
      var_0 thread scripts\common\anim::anim_loop_solo(self, var_1 + "_idle", "stop_loop_" + self.animname);
      self.nothreat = 1;
      wait 3;
      var_0 notify("stop_loop_" + self.animname);
      var_0 thread scripts\common\anim::anim_loop_solo(self, var_2, "stop_loop_" + self.animname);
      self.iamflashed = 0;
    } else if(in_player_fov(var_6)) {
      var_0 notify("stop_loop_" + self.animname);
      self notify("scared_reaction_started");
      var_0 scripts\common\anim::anim_single_solo(self, var_1);
      self.nothreat = 1;
      var_5++;

      if(isDefined(var_2) && !in_player_fov(var_6))
        var_0 thread scripts\common\anim::anim_loop_solo(self, var_2, "stop_loop_" + self.animname);
      else {
        var_0 thread scripts\common\anim::anim_loop_solo(self, var_1 + "_idle", "stop_loop_" + self.animname);

        while(in_player_fov(var_7))
          waitframe();

        wait 1.5;
        var_0 notify("stop_loop_" + self.animname);
        var_0 thread scripts\common\anim::anim_loop_solo(self, var_2, "stop_loop_" + self.animname);
      }

      if(var_5 >= 3) {
        var_8 = randomfloatrange(4, 6);
        wait(var_8);
      }
    }

    waitframe();
  }
}

in_player_fov(var_0) {
  if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self gettagorigin("j_head"), var_0) && scripts\engine\trace::ray_trace_passed(level.player getEye(), self gettagorigin("j_head"), [self, level.player]))
    return 1;
  else
    return 0;
}

get_is_looking_at(var_0, var_1, var_2, var_3) {
  if(isent(var_0) && isDefined(var_2))
    var_4 = var_0 gettagorigin(var_2);
  else if(isent(var_0))
    var_4 = var_0.origin;
  else
    var_4 = var_0;

  var_5 = self worldpointtoscreenpos(var_4, getdvarint("MRNKTKLLKP"));

  if(!isDefined(var_5))
    return 0;

  if(isDefined(var_1) && length2d(var_5) > var_1)
    return 0;

  if(!isDefined(var_3) || var_3) {
    if(isent(var_0))
      var_6 = [self, var_0];
    else
      var_6 = [self];

    var_7 = scripts\engine\trace::ray_trace_passed(self getEye(), var_4, var_6);
  } else
    var_7 = 1;

  return var_7;
}

wait_near(var_0, var_1) {
  var_2 = var_1 * var_1;
  var_3 = var_0;

  for(;;) {
    if(isent(var_0))
      var_3 = var_0.origin;

    if(distance2dsquared(self.origin, var_3) < var_2) {
      break;
    }

    waitframe();
  }
}

set_goal_node_and_poi(var_0, var_1) {
  scripts\common\ai::poi_enable(1, var_1);
  self setgoalnode(var_0);
  wait 3;
  scripts\common\ai::poi_enable(0);
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

compound_door_setup(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_2 = getEnt(var_0 + "_clip", "targetname");
  var_2 linkTo(var_1);
  var_3 = [var_1, var_2];
  return var_3;
}

compound_lights_on(var_0) {
  var_1 = [];
  var_2 = [];
  waitframe();

  foreach(var_4 in var_0) {
    var_5 = getEntArray(var_4, "script_noteworthy");
    var_1 = scripts\engine\utility::array_combine(var_1, var_5);
    var_6 = getscriptablearray(var_4, "script_noteworthy");
    var_2 = scripts\engine\utility::array_combine(var_2, var_6);
  }

  wait 0.15;
  var_8 = 0.5;
  scripts\engine\utility::array_thread(var_1, ::turn_lights_onoff, var_2, "on");
  wait(var_8);
}

compound_lights_off(var_0) {
  var_1 = [];
  var_2 = [];
  waitframe();

  foreach(var_4 in var_0) {
    var_5 = getEntArray(var_4, "script_noteworthy");
    var_1 = scripts\engine\utility::array_combine(var_1, var_5);
    var_6 = getscriptablearray(var_4, "script_noteworthy");
    var_2 = scripts\engine\utility::array_combine(var_2, var_6);
  }

  wait 0.15;
  var_8 = 0.5;
  scripts\engine\utility::array_thread(var_1, ::turn_lights_onoff, var_2, "off");
  wait(var_8);
}

turn_lights_onoff(var_0, var_1) {
  if(scripts\engine\utility::array_contains(var_0, self)) {
    if(light_not_destroyed())
      self setscriptablepartstate("onoff", var_1);
  } else {
    if(!isDefined(self.og_intensity))
      self.og_intensity = self getlightintensity();

    if(var_1 == "on")
      self setlightintensity(self.og_intensity);
    else
      self setlightintensity(0);

    if(isDefined(self.target)) {
      var_2 = getscriptablearray(self.target, "targetname");

      foreach(var_4 in var_2)
      var_4 setscriptablepartstate("onoff", var_1);
    }
  }
}

light_not_destroyed() {
  if(scripts\engine\utility::is_equal(self.model, "ee_light_fixture_lamp_short_02_shade"))
    return 0;
  else if(scripts\engine\utility::is_equal(self.model, "light_ceiling_bulb_02_rb"))
    return 0;
  else if(scripts\engine\utility::is_equal(self.model, "light_interior_wall_sconce_01_destr"))
    return 0;
  else if(scripts\engine\utility::is_equal(self.model, "me_lighting_fixture_ceiling_ornate_01_destr"))
    return 0;

  return 1;
}

anim_door(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  var_3 scripts\engine\sp\utility::assign_animtree("door");
  var_3 scripts\common\anim::anim_first_frame_solo(var_3, var_1);
  var_0 linkTo(var_3);
  var_0.bashed = 1;

  if(!isDefined(var_2)) {
    var_0 scripts\sp\door::remove_open_prompts();
    var_0 scripts\game\sp\door::remove_door_snake_cam_ability();
  }

  scripts\common\anim::anim_single_solo(var_3, var_1);

  if(!isDefined(var_2)) {
    var_0 scripts\sp\door::updatenavobstacle();
    var_0 scripts\sp\door::clear_navobstacle();
  }

  var_3 delete();
}

anim_scriptable(var_0, var_1) {
  var_0.temp = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  var_0.temp scripts\engine\sp\utility::assign_animtree("door");
  var_0.temp scripts\common\anim::anim_first_frame_solo(var_0.temp, var_1);
  var_0 enablelinkTo();
  var_0 linkTo(var_0.temp);
  scripts\common\anim::anim_single_solo(var_0.temp, var_1);
  var_0.temp delete();
}

open_main_door() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var_0 = getscriptablearray("compound_door", "targetname");
  var_1 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  var_1 anim_scriptable(var_0[0], "main_door_open");
}

interactive_double_door_force_open(var_0) {
  if(!scripts\engine\utility::flag("scriptables_ready"))
    scripts\engine\utility::flag_wait("scriptables_ready");

  var_1 = undefined;
  var_2 = scripts\sp\door::get_interactive_door(var_0);
  var_3 = scripts\sp\door::get_interactive_door(var_0 + "_right");

  if(isDefined(self))
    var_1 = self;
  else
    var_1 = level.player;

  var_2 thread interactive_door_force_open(var_1);
  var_3 thread interactive_door_force_open(var_1);
}

interactive_door_force_open(var_0) {
  if(!scripts\engine\utility::flag("scriptables_ready"))
    scripts\engine\utility::flag_wait("scriptables_ready");

  scripts\engine\utility::ent_flag_wait("initialized");
  scripts\sp\door::remove_open_prompts();
  scripts\game\sp\door::remove_door_snake_cam_ability();
  scripts\sp\door::door_open_completely(var_0, 0.2);
}

door_waittill_open(var_0, var_1) {
  self endon("entitydeleted");

  if(!isDefined(var_0))
    var_0 = 45;

  var_2 = angleclamp180(self.angles[1]);

  while(abs(angleclamp180(self.angles[1]) - var_2) < var_0)
    waitframe();

  if(isDefined(var_1))
    scripts\engine\utility::flag_set(var_1);

  return self.angles[1] - var_2;
}

force_open_doors(var_0, var_1, var_2, var_3) {
  scripts\engine\utility::flag_wait("interactive_doors_ready");

  if(isDefined(var_0))
    level.player interactive_double_door_force_open(var_0);

  if(isDefined(var_1))
    level.player interactive_double_door_force_open(var_1);

  if(isDefined(var_2))
    level.player interactive_double_door_force_open(var_2);
}

waittill_struct_within_fov(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_3 = getEnt(var_1, "targetname");
  var_4 = cos(43);

  for(;;) {
    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_2.origin, var_4) && level.player istouching(var_3)) {
      break;
    } else
      waitframe();
  }
}

waittill_struct_or_self_within_fov(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_3 = getEnt(var_1, "targetname");
  var_4 = cos(35);

  for(;;) {
    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_2.origin, var_4) && level.player istouching(var_3)) {
      break;
    } else if(in_player_fov(var_4)) {
      break;
    } else
      waitframe();
  }
}

flashbang_watcher() {
  level endon("tunnels_transition");
  var_0 = squared(200);

  for(;;) {
    var_1 = [];
    var_2 = 0;
    level.player waittill("grenade_fire", var_3, var_4);

    if(var_4.basename == "flash") {
      var_3 waittill("explode", var_5);
      var_6 = getaiarray("axis", "allies");
      wait 0.3;

      foreach(var_8 in var_6) {
        if(!isalive(var_8)) {
          continue;
        }
        if(distance2dsquared(var_5, var_8.origin) < var_0) {
          if(var_8.team == "axis" && scripts\engine\trace::ray_trace_passed(var_5, var_8 gettagorigin("tag_eye"), [var_8])) {
            var_2 = 1;
            continue;
          }

          if(var_8.team == "allies" && scripts\engine\trace::ray_trace_passed(var_5, var_8 gettagorigin("tag_eye"), [var_8]))
            var_1[var_1.size] = var_8;
        }
      }

      if(!var_2 && isDefined(var_1) && var_1.size > 0) {
        if(level.player scripts\engine\utility::isflashed())
          wait 1.7;
        else
          wait 0.7;

        var_10 = scripts\engine\utility::getclosest(level.player.origin, var_1);

        if(var_10.animname == "price")
          var_10 scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_react_flash_10");
        else
          var_10 scripts\engine\sp\utility::smart_dialogue("dx_vom_a12_react_flash_30");
      }
    }

    waitframe();
  }
}

setup_tea_room() {
  tea_room_change("before");
  level waittill("3f_ready_flags_cleared");
  tea_room_change("after", 1);
}

tea_room_change(var_0, var_1) {
  var_2 = getEntArray("tea_room_before", "script_noteworthy");
  var_3 = getEntArray("tea_room_after", "script_noteworthy");
  var_4 = getEntArray("tea_room_after_clip", "script_noteworthy");

  switch (var_0) {
    case "before":
      foreach(var_6 in var_3)
      var_6 hide();

      foreach(var_6 in var_4)
      var_6 notsolid();

      break;
    case "after":
      foreach(var_6 in var_3)
      var_6 show();

      foreach(var_6 in var_4)
      var_6 solid();

      foreach(var_6 in var_2)
      var_6 delete();

      var_16 = compound_door_setup("tr_room_door");
      var_16[0] rotateYaw(-110, 0.1);
      var_16[0] moveTo(var_16[0].origin + (-2, 2, 0), 0.1);
      var_16[1] connectpaths();
      break;
  }
}

nag_system(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level endon(var_0);
  wait(var_2);
  var_7 = min(2, var_1.size - 1);

  for(;;) {
    var_8 = 0;

    for(var_8 = 0; var_8 < var_1.size; var_8++) {
      if(isDefined(var_4)) {
        if(isent(var_4)) {
          scripts\common\utility::lookatentity(var_4);
          scripts\engine\utility::delaythread(2, scripts\common\utility::lookatentity);
        } else if(isstruct(var_4)) {
          scripts\common\utility::lookatpos(var_4.origin);
          scripts\engine\utility::delaythread(2, scripts\common\utility::lookatpos);
        }
      }

      thread scripts\engine\sp\utility::smart_dialogue(var_1[var_8]);

      if(isDefined(var_6) && var_8 == var_7)
        level.player thread scripts\sp\player::focus_display_hint(undefined, 6);

      if(isDefined(var_5))
        scripts\engine\utility::delaythread(0.5, scripts\asm\gesture::ai_request_gesture, "casual_point", var_5);

      wait(var_3);
    }
  }
}

scripted_movement(var_0, var_1) {
  self endon("stop_scripted_movement");

  if(isDefined(var_1) && var_1)
    self forceteleport(var_0.origin, var_0.angles);

  self.post_wait_func = ::scripted_movement_post_wait;
  scripts\sp\spawner::go_to_node(var_0, ::scripted_movement_arrival);
}

scripted_movement_post_wait() {
  if(isDefined(self.scripted_movement_idle))
    self.scripted_animnode notify("stop_" + self.scripted_anime + "_idle_" + self.animname);
}

scripted_movement_arrival(var_0) {
  if(isDefined(self.scripted_movement_idle))
    self.scripted_animnode notify("stop_" + self.scripted_anime + "_idle_" + self.animname);

  if(isDefined(var_0.script_ent_flag_set))
    scripts\engine\utility::ent_flag_set(var_0.script_ent_flag_set);

  if(isDefined(var_0.script_flag_set))
    scripts\engine\utility::flag_set(var_0.script_flag_set);

  if(isDefined(var_0.animation))
    script_movement_anim(var_0);

  if(!isDefined(var_0.script_function)) {
    return;
  }
  var_1 = get_scripted_movement_arrivefuncs();

  if(!isDefined(var_1[var_0.script_function])) {
    return;
  }
  self[[var_1[var_0.script_function]]](var_0);
}

script_movement_anim(var_0) {
  var_1 = var_0.animation;
  var_0.origin = scripts\engine\utility::drop_to_ground(var_0.origin, 10, -100);
  var_2 = var_0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;

  if(isDefined(var_0.script_parameters)) {
    if(var_0.script_parameters == "no_anim_reach")
      var_3 = 1;
    else if(var_0.script_parameters == "anim_reach_arrive")
      var_4 = 1;
    else if(var_0.script_parameters == "anim_reach_approach")
      var_5 = 1;
    else {
      var_6 = scripts\engine\utility::getStruct(var_0.script_parameters, "targetname");
      self setentitytarget(var_6);
    }
  }

  if(isDefined(var_0.script_animnode))
    var_2 = scripts\engine\utility::getStruct(var_0.script_animnode, "targetname");

  var_7 = 0;

  if(isDefined(level.scr_anim["generic"][var_1]))
    var_7 = 1;

  if(!var_3) {
    if(var_7)
      var_2 scripts\sp\anim::anim_generic_reach(self, var_1);
    else if(var_4)
      var_2 scripts\sp\anim::anim_reach_and_arrive(self, var_1);
    else if(var_5)
      var_2 scripts\sp\anim::anim_reach_and_approach_solo(self, var_1);
    else
      var_2 scripts\sp\anim::anim_reach_solo(self, var_1);
  }

  var_8 = undefined;

  if(var_7) {
    if(isDefined(level.scr_anim["generic"][var_1 + "_idle"]))
      var_8 = 1;
  } else if(isDefined(level.scr_anim[self.animname][var_1 + "_idle"]))
    var_8 = 1;

  self.scripted_movement_idle = undefined;
  self.scripted_anime = undefined;
  self.scripted_animnode = undefined;

  if(isDefined(var_8)) {
    self.scripted_movement_idle = 1;
    self.scripted_anime = var_1;
    self.scripted_animnode = var_2;
  }

  if(var_7) {
    if(isDefined(var_8))
      var_2 thread anim_then_loop_solo(self, var_1, var_1 + "_idle", "stop_" + var_1 + "_idle_" + self.animname, 1);
    else
      var_2 thread scripts\common\anim::anim_generic(self, var_1);
  } else if(isDefined(var_8))
    var_2 thread anim_then_loop_solo(self, var_1, var_1 + "_idle", "stop_" + var_1 + "_idle_" + self.animname);
  else
    var_2 thread scripts\common\anim::anim_single_solo(self, var_1);

  self notify("laser_toggle");

  if(isDefined(var_0.script_type)) {
    if(var_0.script_type == "anim_wait")
      self waittillmatch("single anim", "end");
  }
}

get_scripted_movement_arrivefuncs() {
  var_0 = [];

  if(isDefined(level.scripted_movement_arrivefuncs)) {
    foreach(var_2 in level.scripted_movement_arrivefuncs) {
      foreach(var_5, var_4 in var_2)
      var_0[var_5] = var_4;
    }
  }

  return var_0;
}

anim_then_loop_solo(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("stop_anim_then_loop");

  if(!isDefined(var_2))
    var_2 = var_1 + "_loop";

  var_5 = spawnStruct();
  var_5.loopendernotified = 0;

  if(isDefined(var_4))
    scripts\common\anim::anim_generic(var_0, var_1);
  else
    scripts\common\anim::anim_single_solo(var_0, var_1);

  if(var_5.loopendernotified) {
    return;
  }
  if(isai(var_0) && !isalive(var_0)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_4))
    thread scripts\common\anim::anim_generic_loop(var_0, var_2, var_3);
  else
    thread scripts\common\anim::anim_loop_solo(var_0, var_2, var_3);
}

stairtrain_1f() {
  stairtrain_1f_setup();
  level.price thread start_2f_data();
  level.bravo1 thread bravo1_2f_idle();
}

stairtrain_1f_setup() {
  if(!isDefined(level.temp_stairtrain_count))
    level.temp_stairtrain_count = 0;

  var_0 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  scripts\engine\utility::flag_wait("player_at_2f_stairs");
  level notify("stairs_2f_nag_end");
  var_1 = [level.price, level.bravo1];
  var_0 notify("stop_first_frame");
  var_0 notify("ready_2f_ascend");

  foreach(var_3 in var_1) {
    var_3.animnode = var_0;
    var_3 scripts\engine\sp\utility::anim_stopanimScripted();
    var_3 thread scripts\asm\asm_sp::asm_animcustom(::stairtrain_1f_animcustom);
  }
}

stairtrain_1f_animcustom() {
  if(self.animname == "price")
    level.stairtrain_rearguy = self;

  var_0 = spawnStruct();
  var_0.animnode = self.animnode;
  var_0.base_anime = "2f_stairs_ascend";
  var_0.base_anim = scripts\engine\utility::getanim(var_0.base_anime);
  var_0.additive_branch = scripts\engine\utility::getanim(var_0.base_anime + "_additive_branch");
  var_0.additive_anim = scripts\engine\utility::getanim(var_0.base_anime + "_additive");
  var_0.settle_anim = scripts\engine\utility::getanim(var_0.base_anime + "_settle");
  var_0.minplayerdist = 55;
  var_0.maxplayerdist = 90;
  var_0.minplayerspeeddist = 36;
  var_0.maxplayerspeeddist = 60;
  var_0.fnadditive_twitch_get = scripts\sp\maps\tunnels\zd30tunnels_anim.gsc::stairtrain_twitch_get;

  if(scripts\engine\utility::hasanim(var_0.base_anime + "_nag"))
    var_0.nag_anim = scripts\engine\utility::getanim(var_0.base_anime + "_nag");

  self clearanim(scripts\asm\asm::asm_getbodyknob(), 0.2);
  self animmode("noclip");
  scripts\sp\stairtrain::stairtrain_thread(var_0, "stairtrain_1f_path");
}

stairtrain_2f(var_0) {
  stairtrain_2f_setup();
  thread clip_delete("3f_stairs_action_clip", "3f_stairs_clip");
  self waittill("stairtrain_end");
  level notify("3f_stairtrain_end");
  setup_3f_bravo1(var_0);
}

stairtrain_2f_setup() {
  if(!isDefined(level.temp_stairtrain_count))
    level.temp_stairtrain_count = 0;

  var_0 = scripts\engine\utility::getStruct("3f_animnode", "targetname");
  var_1 = scripts\engine\utility::getStruct("3f_stairs_start", "targetname");
  var_2 = spawn_3f_stairs_enemy(var_0);
  scripts\engine\utility::flag_wait("player_at_3f_stairs");
  var_3 = cos(20);

  for(;;) {
    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_1.origin, var_3) && scripts\engine\trace::ray_trace_passed(level.player getEye(), var_1.origin, [level.bravo1, level.player])) {
      break;
    }

    waitframe();
  }

  var_0 notify("stop_3f_stairs");
  var_0 notify("stop_first_frame");
  var_0 notify("ready_3f_ascend");
  scripts\engine\utility::flag_set("ready_3f_ascend");
  var_2 thread stairs_3f_enemy_vo();
  var_2 thread stairs_3f_enemy(var_0);
  var_4 = [level.bravo1, var_2];
  scripts\engine\utility::delaythread(3, scripts\engine\utility::play_sound_in_space, "zd30c_3f_hallway_run_away_01", (360, 1298, 375));
  scripts\engine\utility::delaythread(3, scripts\engine\utility::play_sound_in_space, "zd30c_3f_hallway_run_away_02", (360, 1298, 375));
  scripts\engine\utility::delaythread(5, scripts\engine\utility::play_sound_in_space, "zd30c_3f_hallway_run_away_03_door", (360, 1298, 375));
  level.overwatch scripts\engine\utility::delaythread(5, scripts\engine\sp\utility::smart_dialogue, "dx_vom_s11_3rd_floor_stairs_40");

  foreach(var_6 in var_4) {
    var_6.animnode = var_0;
    var_6 scripts\engine\sp\utility::anim_stopanimScripted();
    var_6 thread scripts\asm\asm_sp::asm_animcustom(::stairtrain_2f_animcustom);
  }
}

stairtrain_2f_animcustom() {
  if(self.animname == "bravo1")
    level.stairtrain_rearguy = self;

  var_0 = spawnStruct();
  var_0.animnode = self.animnode;
  var_0.base_anime = "3f_stairs_start";
  var_0.base_anim = scripts\engine\utility::getanim(var_0.base_anime);

  if(self.animname == "bravo1") {
    var_0.additive_branch = scripts\engine\utility::getanim(var_0.base_anime + "_additive_branch");
    var_0.additive_anim = scripts\engine\utility::getanim(var_0.base_anime + "_additive");
    var_0.settle_anim = scripts\engine\utility::getanim(var_0.base_anime + "_settle");
  }

  var_0.minplayerdist = 45;
  var_0.maxplayerdist = 90;
  var_0.minplayerspeeddist = 36;
  var_0.maxplayerspeeddist = 60;

  if(self.animname == "bravo1")
    var_0.fnadditive_twitch_get = scripts\sp\maps\tunnels\zd30tunnels_anim.gsc::stairtrain_twitch_get;

  if(scripts\engine\utility::hasanim(var_0.base_anime + "_nag"))
    var_0.nag_anim = scripts\engine\utility::getanim(var_0.base_anime + "_nag");

  self clearanim(scripts\asm\asm::asm_getbodyknob(), 0.2);
  self animmode("noclip");
  scripts\sp\stairtrain::stairtrain_thread(var_0, "stairtrain_2f_path");
}

#using_animtree("script_model");

power_interact_anim(var_0) {
  scripts\engine\utility::flag_wait("power_is_off");
  level.player allowmelee(0);
  level.player scripts\engine\utility::delaycall(0.2, ::playsound, "scn_estate_fusebox_lever_off_plr");
  level.scr_model["player_rig"] = "viewmodel_arms_kyle_woodland";
  var_1 = var_0 scripts\sp\player_rig::link_player_to_rig("power_interact", "stand", 1, 0.3, 1);
  var_0 thread scripts\common\anim::anim_single_solo(self, "power_interact");
  var_0 scripts\common\anim::anim_single_solo(var_1, "power_interact");
  scripts\sp\player_rig::unlink_player_from_rig(1);
  level.player allowmelee(1);
  scripts\engine\utility::flag_wait("3f_scene_done");
  self clearanim(%zd30_vm_fusebox_handle, 0);
  waitframe();
  var_0 scripts\common\anim::anim_first_frame_solo(self, "power_interact");
  var_2 = getscriptablearray("power_switch_led", "targetname");
  var_2[0] setscriptablepartstate("onoff", "on");
}