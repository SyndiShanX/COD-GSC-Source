/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_descent.gsc
*********************************************/

func_00F9() {
  level.use_zombie_unresolved_collision = 1;
  level.pack_a_punc_pre_func = ::maps\mp\mp_zombie_descent_ee_main::raise_machine_to_unlock_pack_a_punch;
  level.var_8B96 = ::descent_player_ignore_extra;
  level.zmb_player_safe_teleport_on_perk_buy = 1;
  maps\mp\mp_zombie_descent_precache::func_F9();
  maps\createart\mp_zombie_descent_art::func_F9();
  maps\mp\mp_zombie_descent_fx::func_F9();
  maps\mp\_load::func_F9();
  maps\mp\mp_zombie_descent_lighting::func_F9();
  maps\mp\mp_zombie_descent_aud::func_F9();
  common_scripts\utility::func_3C87("flag_closet_to_basement_1");
  hack_swap_basement_cloest_door_flag();
  maps\mp\_compass::func_8A2F("compass_map_mp_zombie_descent");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.zmcharactervariantid = 1;
  level.var_6BB0 = ::on_game_start_descent;
  level.pairedmeleeclipwarningonce = 0;
  level.var_902A = ::maps\mp\mp_zombie_descent_utils::func_902A;
  level.pap_camo_ref_override = "camo_pap_04";
  level.var_AC71 = ::initdescentweapons;
  level.means_of_skipping_rounds_func = ::maps\mp\mp_zombie_nest_ee_wave_manipulation::skiproundwait2;
  level.door_data_out_of_date = 0;
  level.var_73BD = ::no_points_for_thule;
  level.usenavmeshforuber = 1;
  level.var_783F = 0;
  level.zombiespawnfxcount = 0;
  level thread maps\mp\zquests\zmb_secret_challenges_util::init_challenges_utility();
  level.var_AC2E = 8;
  level thread maps\mp\_utility::func_6F74(::mute_audio_on_intro);
  init_blood_plates();
  init_ice_blocks();
  initprecache();
  func_5375();
  func_5339();
  initflags();
  level thread door_death_fix();
  level.var_ABD3 = -3500;
  level thread maps\mp\zombies\_zombies_audio_dlc2::initdlc2audio();
  maps\mp\zombies\_zombies_money::func_D5();
  level thread maps\mp\zombies\_zombies_harmonic_kinetic_accelerator::func_D5();
  level thread maps\mp\zombies\_zombies_orbital_gravity_entangler::func_D5();
  level thread maps\mp\zombies\_zombies_blood_tubes::func_D5();
  level thread soundscripts\_snd_common_zmb_dlc4::snd_zmb_init_dlc4();
  level thread maps\mp\zquests\dlc4_secrets_mp_zombie_descent::init_dlc4_secrets_mp_zombie_descent();
  level thread maps\mp\zquests\dlc4_trophies_mp_zombie_descent::func_D5();
  maps\mp\mp_zombie_nest_ee_wave_manipulation::func_F9();
  level thread maps\mp\mp_zombie_descent_utils::vo_intro();
  level thread spawn_ice_breakers_on_door_open();
  level thread handle_door_orb_blockers();
  level thread maps\mp\zombies\zombie_corpse_eater::periodically_spawn_corpse_eaters();
  level thread handle_boss_battle_playtest();
  level thread setup_text_log_reveals();
  level thread handle_conditional_spawners();
  level thread maps\mp\_utility::func_6F74(::spawnfadein);
  level thread maps\mp\_utility::func_6F74(::player_clear_stuff_on_death);
}

no_points_for_thule(param_00, param_01) {
  if(common_scripts\utility::func_562E(param_01.iszombieking)) {
    return 0;
  }

  return 1;
}

spawnfadein() {
  self.var_6772 = newclienthudelem(self);
  self.var_6772 setshader("black", 640, 480);
  self.var_6772.ignoreme = 999;
  self.var_6772.var_C6 = "fullscreen";
  self.var_6772.var_1CA = "fullscreen";
  self.var_6772.var_A0 = 0;
  while(!level.var_3FA6) {
    wait 0.05;
  }

  thread animscripts\notetracks_common::do_fade_from_black(1.15);
}

player_clear_stuff_on_death() {
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    self waittill("death");
    wait 0.05;
    if(isDefined(self.isintrial)) {
      self.isintrial = undefined;
    }

    if(isDefined(self.inasneakyplace)) {
      self.inasneakyplace = 0;
    }

    if(isDefined(self.hitchingaride)) {
      self.hitchingaride = 0;
    }

    if(isDefined(self.isbloodtubemoonorbblocked)) {
      self.isbloodtubemoonorbblocked = undefined;
    }

    if(isDefined(self.forcedblooddest)) {
      self.forcedblooddest = 0;
    }

    if(isDefined(self.tryingtoleavepap)) {
      self.tryingtoleavepap = 0;
    }

    if(isDefined(self.isonpushcooldown)) {
      self.isonpushcooldown = 0;
    }

    if(isDefined(self.var_480F)) {
      self.var_480F = 0;
    }
  }
}

handle_conditional_spawners() {
  foreach(var_01 in common_scripts\utility::func_46B7("zombie_spawner", "script_noteworthy")) {
    if(isDefined(var_01.var_1A2)) {
      var_01.player_exclusion_zones = common_scripts\utility::func_46B7(var_01.var_1A2, "targetname");
      var_01 thread toggle_active();
    }
  }
}

toggle_active() {
  var_00 = self;
  while(!isDefined(level.var_744A) || level.var_744A.size == 0) {
    wait 0.05;
  }

  for(;;) {
    var_00.is_zombies_spawner_script_disabled = 0;
    foreach(var_02 in var_00.player_exclusion_zones) {
      if(isDefined(var_02.var_82EC)) {
        return;
      }

      foreach(var_04 in level.var_744A) {
        if(distance2d(var_04.var_116, var_02.var_116) < var_02.var_14F && abs(var_04.var_116[2] - var_02.var_116[2]) < var_02.var_BD) {
          var_00.is_zombies_spawner_script_disabled = 1;
          break;
        }
      }
    }

    lib_0547::func_A6F6();
  }
}

descent_player_ignore_extra(param_00) {
  if(common_scripts\utility::func_562E(param_00.is_in_side_ee_mini_game)) {
    return 1;
  }

  return 0;
}

mute_audio_on_intro() {
  self method_8626("intro_movie");
  while(!level.var_3FA6) {
    self freezecontrols(1);
    self method_812B(0);
    self method_8324();
    self method_84CB();
    wait 0.05;
  }

  self freezecontrols(0);
  self method_812B(1);
  self method_8325();
  self method_84CC();
  self method_8627("intro_movie");
}

handle_boss_battle_playtest() {
  if(!getdvarint("spv_dlc4_activate_boss_battle_on_start", 0)) {
    return;
  }

  while(!isDefined(level.var_A980)) {
    wait 0.05;
  }

  level.var_A980 = 18;
  level thread maps\mp\_utility::func_6F74(::give_all_boss_battle_perks);
  wait(1);
  var_00 = common_scripts\utility::func_7A33(level.var_744A);
  var_00 lib_057D::func_4766();
  wait(5);
  maps\mp\mp_zombie_descent_ee_main::get_available_players();
}

give_all_boss_battle_perks() {
  var_00 = self;
  var_00 endon("disconnect");
  wait(1);
  while(!isalive(var_00) || !var_00 method_8648()) {
    wait(1);
  }

  var_01 = var_00 getweaponslistprimaries();
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    if(function_01A9(var_01[var_02]) != "melee") {
      var_00 lib_0586::func_790(var_01[var_02]);
    }
  }

  foreach(var_04 in ["m1911_pap_zm", "svt40_pap_zm"]) {
    if(lib_0569::func_55D4(var_04)) {
      maps\mp\zombies\_zombies_magicbox::func_A7D6(var_00, var_00 lib_0586::func_78B(function_0337(var_04, "pap_")));
      continue;
    }

    maps\mp\zombies\_zombies_magicbox::func_A7D6(var_00, var_04);
  }

  var_00 lib_0586::func_78E("m1911_pap_zm");
  var_00 lib_056A::func_47B5();
  var_00 lib_056A::func_4784();
  var_00 lib_056A::cp_zmb_escape_init();
  var_00 lib_056A::func_47B1();
  var_00 lib_056A::func_47B8();
}

init_blood_plates() {
  var_00 = common_scripts\utility::func_46B7("blood_plate_struct", "targetname");
  var_01 = getEntArray("blood_pool", "targetname");
  level.blood_plates = [];
  foreach(var_03 in var_00) {
    if(isDefined(var_03.var_8260) && var_03.var_8260 == "plate_frontdoor") {
      level.blood_plates["first_door"] = var_03;
    }

    if(isDefined(var_03.var_8260) && var_03.var_8260 == "plate_trial_room") {
      level.blood_plates["trial"] = var_03;
      var_04 = var_01;
      var_04 = function_01AC(var_04, var_03.var_116, 150);
      if(isDefined(var_04[0])) {
        var_03.blood_pool = var_04[0];
        var_03.blood_pool.min_pos = var_03.blood_pool.var_116;
        var_03.blood_pool.max_pos = var_03.blood_pool.var_116 + (0, 0, 28);
      }
    }

    if(isDefined(var_03.var_8260) && var_03.var_8260 == "plate_boss_room") {
      level.blood_plates[level.blood_plates.size] = var_03;
      var_04 = var_01;
      var_04 = function_01AC(var_04, var_03.var_116, 150);
      if(isDefined(var_04[0])) {
        var_03.blood_pool = var_04[0];
        var_03.blood_pool.min_pos = var_03.blood_pool.var_116;
        var_03.blood_pool.max_pos = var_03.blood_pool.var_116 + (0, 0, 28);
      }
    }

    if(isDefined(var_03.var_8260) && var_03.var_8260 == "plate_bonus_room") {
      level.blood_plates["bonus"] = var_03;
      var_04 = var_01;
      var_04 = function_01AC(var_04, var_03.var_116, 150);
      if(isDefined(var_04[0])) {
        var_03.blood_pool = var_04[0];
        var_03.blood_pool.min_pos = var_03.blood_pool.var_116;
        var_03.blood_pool.max_pos = var_03.blood_pool.var_116 + (0, 0, 28);
      }
    }

    if(isDefined(var_03.var_8260) && var_03.var_8260 == "plate_shelf") {
      level.blood_plates["shelf"] = var_03;
      var_04 = var_01;
      var_04 = function_01AC(var_04, var_03.var_116, 150);
      if(isDefined(var_04[0])) {
        var_03.blood_pool = var_04[0];
        var_03.blood_pool.min_pos = var_03.blood_pool.var_116;
        var_03.blood_pool.max_pos = var_03.blood_pool.var_116 + (0, 0, 28);
      }
    }
  }

  foreach(var_08, var_07 in level.blood_plates) {
    var_07 setup_blood_plates(var_08);
  }

  level thread maps\mp\_utility::func_6F74(::pressure_plate_player_listen, level.blood_plates);
}

setup_blood_plates(param_00) {
  var_01 = self;
  if(isDefined(self.blood_pool)) {
    var_01.blood_pool moveto(var_01.blood_pool.var_116 + (0, 0, 30), 0.05);
  }

  var_02 = "flag_plate_filled_" + param_00;
  var_03 = "flag_plate_pressed_" + param_00;
  common_scripts\utility::func_3C87(var_02);
  common_scripts\utility::func_3C87(var_03);
  var_01.blood_health = 0;
  var_01.blood_health_max = 100;
  var_01.var_D4 = param_00;
  var_01.death_ping = "dig_blood_plate_ping" + param_00;
  var_01.filled_flagname = var_02;
  var_01.pressed_flagname = var_03;
  var_01.plate_name = var_01.var_8260;
  var_01.kill_count = 0;
  var_01.plate_failsafe_nodes = [];
  var_01.souls_max = 30;
  if(var_01 == level.blood_plates["first_door"] || var_01 == level.blood_plates["trial"]) {
    var_01.souls_max = 5;
  }

  if(var_01 == level.blood_plates["shelf"]) {
    var_01.souls_max = 6;
  }

  var_04 = common_scripts\utility::func_44BE(var_01.var_1A2, "targetname");
  foreach(var_06 in var_04) {
    var_07 = var_06.var_165;
    if(!isDefined(var_07)) {
      continue;
    }

    switch (var_07) {
      case "plate_clip":
        var_01.plate_clip = var_06;
        var_01.plate_clip.var_A045 = ::blood_plate_unresolved_collide;
        var_01.plate_clip.my_plate_struct = var_01;
        break;

      case "plate_failsafe_node":
        var_01.plate_failsafe_nodes = common_scripts\utility::func_F6F(var_01.plate_failsafe_nodes, var_06);
        break;

      case "plate_model":
        var_01.plate_model = var_06;
        var_01.model_start_origin = var_06.var_116;
        break;

      case "plate_trig":
        var_01.plate_trig = var_06;
        var_01.plate_trig.associated_struct = var_01;
        break;

      case "plate_damage_trig":
        var_01.plate_damage_trig = var_06;
        break;

      case "plate_hit_clip":
        var_06 notsolid();
        var_01.plate_hit_clip = var_06;
        break;

      case "plate_center_trig":
        var_01.plate_center_trig = var_06;
        break;
    }
  }

  var_01.plate_model.disable_end_sound = 1;
  var_01.plate_model.disable_auto_deregister = 1;
  var_01.isbloodempty = 1;
  var_01.isbloodfull = 0;
  var_01.souls_current = 0;
  var_01 common_scripts\utility::func_3799("plate_reserved");
  var_01 thread blood_fill_think();
}

blood_fill_think() {
  var_00 = self;
  var_00 thread blood_state_think();
  for(;;) {
    var_00 waittill("blood_status_updated");
    if(lib_0547::func_5565(var_00.isbloodfull, 0)) {
      var_00 plate_enable_blood_collect();
    }

    if(lib_0547::func_5565(var_00.isbloodfull, 1)) {
      while(var_00.isbloodfull == 1) {
        wait 0.05;
      }

      if(var_00 common_scripts\utility::func_3794("plate_reserved")) {
        var_00 common_scripts\utility::func_37A1("plate_reserved");
      }
    }
  }
}

blood_state_think() {
  var_00 = self;
  while(isDefined(var_00)) {
    var_01 = var_00 get_blood_fill_frac();
    if(var_01 >= 1) {
      var_00.isbloodfull = 1;
      var_00.isbloodempty = 0;
      var_00 thread play_fx_blood_full();
    } else if(1 < var_01 > 0) {
      var_00.isbloodfull = 0;
      var_00.isbloodempty = 0;
      var_00 thread delete_fx_blood_full();
    } else {
      var_00.isbloodfull = 0;
      var_00.isbloodempty = 1;
      var_00 thread delete_fx_blood_full();
    }

    if(isDefined(self.blood_pool)) {
      thread blood_move_gutters(var_01);
    }

    var_00 notify("blood_status_updated");
    wait 0.05;
  }
}

get_blood_fill_frac() {
  var_00 = self;
  if(!isDefined(var_00.souls_current)) {
    var_01 = 0;
  } else {
    var_01 = var_01.souls_current / var_01.souls_max;
  }

  if(var_01 >= 1) {
    var_01 = 1;
  }

  return var_01;
}

blood_move_gutters(param_00) {
  if(lib_0547::func_5565(self.blood_pool.old_frac, param_00)) {
    return;
  }

  self.blood_pool moveto(self.blood_pool.min_pos + (0, 0, 28 * param_00), 0.05);
  self.blood_pool.old_frac = param_00;
}

plate_enable_blood_collect() {
  plate_blood_collect_think();
  if(isDefined(self.collector)) {
    self.collector.var_AC2C = 0;
    self.collector.var_AC2D = self.collector.var_AC2C;
    level notify(self.collector.var_695B);
  }
}

play_fx_blood_full() {
  if(isDefined(self.blood_full_fx)) {
    return;
  }

  self.blood_full_fx = spawnlinkedfx(common_scripts\utility::func_44F5("dlc_zmb_dec_blood_plates_full"), self.plate_model, "TAG_ORIGIN");
  triggerfx(self.blood_full_fx);
  self.blood_full_fx lib_0378::func_8D74("aud_blood_plate_full_lp");
}

delete_fx_blood_full() {
  if(!isDefined(self.blood_full_fx)) {
    return;
  }

  self.blood_full_fx delete();
}

plate_blood_collect_think() {
  var_00 = self;
  var_00 endon("blood_drain");
  var_00 endon("blood_empty");
  var_00.onzombiesacrificedfunc = ::on_zombie_soul_collected_func;
  var_00.optionaldisablearclightning = 1;
  var_00 thread maps\mp\mp_zombies_soul_collection::beginazombiesoulcollectionobjectiveonstruct(var_00.souls_max, 300, 60, "plate_blood_collect_" + var_00.var_D4, undefined, "TAG_ORIGIN", undefined, "TAG_ORIGIN", undefined, var_00.plate_model, (0, 0, 16), undefined, 1);
  while(var_00.isbloodfull != 1) {
    wait 0.05;
  }

  var_00 notify("blood_plate_full");
}

get_full_boss_blood_plates() {
  var_00 = [];
  foreach(var_02 in level.blood_plates) {
    if(common_scripts\utility::func_562E(var_02.isbloodfull) && lib_0547::func_5565(var_02.var_8260, "plate_boss_room")) {
      var_00[var_00.size] = var_02;
    }
  }

  return var_00;
}

get_not_full_boss_blood_plates() {
  var_00 = [];
  foreach(var_02 in level.blood_plates) {
    if(!common_scripts\utility::func_562E(var_02.isbloodfull) && lib_0547::func_5565(var_02.var_8260, "plate_boss_room")) {
      var_00[var_00.size] = var_02;
    }
  }

  return var_00;
}

func_A752(param_00, param_01) {
  self endon(param_00);
  wait(param_01);
}

blood_plate_boss_reserve(param_00) {
  var_01 = self;
  var_01 common_scripts\utility::func_379A("plate_reserved");
  if(isDefined(param_00)) {
    var_01 thread blood_plate_reserved_fx(param_00);
  }

  var_01 func_A752("release_plate", 25);
  var_01 blood_plate_boss_release();
}

blood_plate_boss_release() {
  var_00 = self;
  var_00 common_scripts\utility::func_3796("plate_reserved");
}

blood_plate_reserved_fx(param_00) {
  var_01 = self;
  var_02 = launchbeam("zmb_geistkraft_blood_beam_med", var_01.plate_model, "TAG_ORIGIN", param_00, "TAG_WEAPON_RIGHT");
  var_03 = launchbeam("zmb_geistkraft_blood_beam_med", var_01.plate_model, "TAG_ORIGIN", param_00, "j_elbow_le");
  var_04 = launchbeam("zmb_geistkraft_blood_beam_med", var_01.plate_model, "TAG_ORIGIN", param_00, "j_elbow_ri");
  var_05 = undefined;
  if(lib_0547::func_5565(level.zombie_king, param_00)) {
    var_05 = spawnlinkedfx(common_scripts\utility::func_44F5("dlc_zmb_dec_blood_plates_fullb"), self.plate_model, "TAG_ORIGIN");
    triggerfx(var_05);
  }

  while(var_01 common_scripts\utility::func_3794("plate_reserved")) {
    wait 0.05;
  }

  var_02 delete();
  var_03 delete();
  var_04 delete();
  if(isDefined(var_05)) {
    var_05 delete();
  }
}

blood_plate_subtract() {
  self notify("blood_drain");
  self.souls_current = self.souls_current - 1;
  if(self.souls_current < 0) {
    self.souls_current = 0;
  }
}

blood_plate_empty() {
  self notify("blood_empty");
  self.souls_current = 0;
}

blood_plate_empty_first_door() {
  self.souls_max = 30;
  self notify("blood_empty");
  self.souls_current = 0;
}

blood_plate_unresolved_collide(param_00) {
  self.var_A048 = blood_plate_get_unresolved_collision_locs(self.my_plate_struct, param_00);
  maps\mp\_movers::func_A047(param_00, 0);
}

blood_plate_get_unresolved_collision_locs(param_00, param_01) {
  var_02 = [];
  if(isDefined(param_00)) {
    var_02[var_02.size] = param_00;
  }

  if(isDefined(param_00.plate_failsafe_nodes) && isarray(param_00.plate_failsafe_nodes)) {
    var_02 = common_scripts\utility::func_F73(var_02, param_00.plate_failsafe_nodes);
  }

  if(isDefined(level.var_9068.var_9090) && isarray(level.var_9068.var_9090)) {
    var_02 = common_scripts\utility::func_F73(var_02, level.var_9068.var_9090);
  }

  return var_02;
}

on_zombie_soul_collected_func(param_00) {
  if(!isDefined(level.blood_plate_zombie_souls_on_field)) {
    level.blood_plate_zombie_souls_on_field = 0;
  }

  plate_souls_incriment(param_00.var_116);
  if(level.blood_plate_zombie_souls_on_field < level.zmb_max_soul_collection_beams) {
    thread blood_plate_soul_fx(param_00);
  }

  maps\mp\mp_zombies_soul_collection::try_play_scripted_soul_suck_anim("scripted_blood_plate");
}

plate_souls_incriment(param_00) {
  var_01 = common_scripts\utility::func_4461(param_00, level.blood_plates, 325);
  if(!isDefined(var_01)) {
    return;
  }

  if(!lib_0547::func_5565(var_01.isbloodfull, 1)) {
    var_01.souls_current = var_01.souls_current + 1;
  }
}

blood_plate_soul_fx(param_00) {
  lib_0378::func_8D74("aud_blood_plate_absorb", param_00);
  if(!isDefined(level.blood_plate_zombie_souls_on_field)) {
    level.blood_plate_zombie_souls_on_field = 0;
  }

  self waittill("body_spawned", var_01);
  if(!isDefined(var_01)) {
    return;
  }

  if(!isDefined(param_00)) {
    return;
  }

  var_02 = param_00;
  var_03 = param_00.var_2E37;
  var_04 = param_00.var_2DA5;
  var_05 = param_00.var_2DA6;
  level.blood_plate_zombie_souls_on_field++;
  var_06 = launchbeam("zmb_geistkraft_blood_beam_med", var_02, var_03, var_01, "j_neck");
  if(isDefined(var_04)) {
    var_07 = var_03;
    if(isDefined(var_05)) {
      var_07 = var_05;
    }

    playFXOnTag(level.var_611[var_04], param_00, var_07);
  }

  wait(1);
  if(isDefined(var_06)) {
    var_06 delete();
  }

  level.blood_plate_zombie_souls_on_field--;
}

pressure_plate_player_listen(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  level endon("disable_plate_movement");
  var_02 = [];
  foreach(var_04 in param_00) {
    var_02 = common_scripts\utility::func_F6F(var_02, var_04.plate_trig);
  }

  for(;;) {
    var_06 = undefined;
    var_04 = undefined;
    foreach(var_08 in var_02) {
      if(var_01 istouching(var_08)) {
        var_06 = var_08;
      }
    }

    if(isDefined(var_06)) {
      var_04 = var_06.associated_struct;
      var_0A = 1;
      if(common_scripts\utility::func_3C77(var_04.pressed_flagname)) {
        var_0A = 0;
      }

      if(isDefined(var_04.pressing_player)) {
        var_0A = 0;
      }

      if(common_scripts\utility::func_562E(var_0A)) {
        if(!lib_0547::func_5565(var_01.pressed_plate, var_04)) {
          var_01.pressed_plate = var_04;
        }

        var_04 thread pressure_plate_press(var_01);
      }
    } else {
      var_01.pressed_plate = undefined;
      foreach(var_08 in var_02) {
        var_04 = var_08.associated_struct;
        if(lib_0547::func_5565(var_04.pressing_player, var_01)) {
          var_04 thread pressure_plate_release();
        }
      }
    }

    wait 0.05;
  }
}

pressure_plate_press(param_00) {
  var_01 = self;
  if(isDefined(param_00)) {
    var_01.pressing_player = param_00;
  }

  common_scripts\utility::func_3C8F(var_01.pressed_flagname);
  level notify("plate_pressed", var_01.plate_name);
  lib_0378::func_8D74("aud_blood_plate_press", var_01.plate_model);
  var_01.plate_model moveto(var_01.model_start_origin + (0, 0, -5), 1, 0.25, 0.25);
  wait(1);
}

pressure_plate_release() {
  var_00 = self;
  var_00.pressing_player = undefined;
  common_scripts\utility::func_3C7B(var_00.pressed_flagname);
  level notify("plate_unpressed", var_00.plate_name);
  lib_0378::func_8D74("aud_blood_plate_release", var_00.plate_model);
  var_00.plate_model moveto(var_00.model_start_origin, 1, 0.25, 0.25);
  wait(1);
}

init_ice_blocks() {
  level.ice_blocks = getEntArray("org_ice_block", "targetname");
  foreach(var_01 in level.ice_blocks) {
    var_01.is_ice_block = 1;
    var_01.ice_health = 100;
    var_01.drop_distance = 112;
    var_02 = getEntArray(var_01.var_1A2, "targetname");
    foreach(var_04 in var_02) {
      switch (var_04.var_165) {
        case "mdl_ice_block":
          var_01.mdl = var_04;
          break;

        case "mdl_ice_block_broken":
          var_01.mdl_broke = var_04;
          var_04 method_805C();
          break;

        case "clip_ice_block":
          var_01.var_241F = var_04;
          break;

        case "clip_ice_block_broke":
          var_04 notsolid();
          var_01.clip_broke = var_04;
          break;

        case "trig_damage_check":
          var_01.damage_trig = var_04;
          var_05 = var_04 method_8216(0, 0, -1);
          var_06 = var_04 method_8216(1, 1, 1);
          var_01.var_8302 = var_06[2] - var_05[2];
          var_01.var_8303 = distance2d(var_05, var_06);
          break;

        default:
          break;
      }
    }
  }
}

setup_text_log_reveals() {
  var_00 = getEntArray("lore_primary", "script_noteworthy");
  common_scripts\utility::func_3C87("flag_force_log_reveal");
  foreach(var_02 in var_00) {
    var_03 = getEntArray(var_02.var_1A2, "targetname");
    var_02.trigs = var_03;
    var_04 = function_0337(var_02.var_8260, "lore");
    common_scripts\utility::func_3C87("flag_log_reveal_" + var_04);
    var_02 thread text_log_reveal_think("flag_log_reveal_" + var_04);
  }
}

text_log_reveal_think(param_00) {
  if(lib_0547::func_5565(self.var_8260, "lore31")) {
    return;
  }

  level thread maps\mp\_utility::func_6F74(::text_log_disable, self);
  if(lib_0547::func_5565(self.var_8260, "lore32")) {
    common_scripts\utility::func_3CA2("flag_boss_complete", "flag_force_log_reveal");
    level thread maps\mp\_utility::func_6F74(::text_log_enable, self);
    return;
  }

  common_scripts\utility::func_3CA2(param_00, "flag_force_log_reveal", "flag_boss_complete");
  thread text_log_enable_when_unseen();
}

text_log_enable_when_unseen() {
  for(;;) {
    var_00 = 0;
    foreach(var_02 in level.var_744A) {
      if(text_log_player_near_or_looking(var_02, self)) {
        var_00 = 1;
      }
    }

    if(!var_00) {
      break;
    } else {
      wait(5);
    }
  }

  var_04 = self.trigs[0].var_5F13;
  var_05 = var_04.var_24D2;
  level thread maps\mp\_utility::func_6F74(::text_log_enable, self);
}

text_log_player_near_or_looking(param_00, param_01) {
  var_02 = distancesquared(param_00.var_116, param_01.var_116);
  if(var_02 < 16384) {
    return 1;
  }

  if(var_02 > 250000) {
    return 0;
  }

  if(!sighttracepassed(param_00.var_116, param_01.var_116, 0, param_01, param_00)) {
    return 0;
  }

  var_03 = param_00 getEye();
  var_04 = param_00 geteyeangles();
  var_05 = anglesToForward(var_04);
  var_06 = vectornormalize(param_01.var_116 - var_03);
  if(vectordot(var_05, var_06) > 0.766) {
    return 1;
  }

  return 0;
}

text_log_enable(param_00) {
  param_00.trigs[0] common_scripts\utility::func_9DA3();
  lib_054F::func_5F11(param_00.trigs[0]);
}

text_log_disable(param_00) {
  param_00.trigs[0] common_scripts\utility::func_9D9F();
  param_00 method_805C();
}

handle_door_orb_blockers() {
  while(!isDefined(level.var_AC1D)) {
    wait 0.05;
  }

  var_00 = getEntArray("door_orb_blocker", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread door_orb_blocker_wait_for_door_open(var_02.var_165);
  }
}

door_orb_blocker_wait_for_door_open(param_00) {
  if(!isDefined(param_00)) {
    self delete();
  }

  common_scripts\utility::func_3C9F(param_00);
  self delete();
}

spawn_ice_breakers_on_door_open() {
  lib_0547::func_A6F6();
  var_00 = lib_053F::func_44A6("flag_limbo_to_cave_1");
  var_00 waittill("scriptable_door_open");
  level.ice_breaker_sacrifices = [];
  var_01 = common_scripts\utility::func_46B7("zone_cave_spawners_ce_reveal", "targetname");
  foreach(var_03 in var_01) {
    var_04 = lib_054D::func_90BA("zombie_generic", var_03, "zombie ce spawn", 1, 1, 1);
    var_04 lib_0547::func_84CB();
    level.ice_breaker_sacrifices = common_scripts\utility::func_F6F(level.ice_breaker_sacrifices, var_04);
  }

  var_06 = common_scripts\utility::func_4461(var_01[0].var_116, level.var_744A);
  if(isPlayer(var_06)) {
    var_06 maps\mp\_utility::func_2CED(4, ::maps\mp\mp_zombie_descent_utils::vo_see_corpse_eater);
  }

  wait(0.5);
  spawn_ice_breakers();
}

player_trial_vision_test() {
  foreach(var_01 in level.var_744A) {
    var_01 thread maps\mp\mp_zombie_descent_ee_main::run_weapon_trial_vision();
    var_01.istrialvisiontest = 1;
    var_01 thread disable_trial_vision_test();
  }
}

disable_trial_vision_test() {
  wait(10);
  self.istrialvisiontest = undefined;
}

spawn_ice_breakers(param_00) {
  var_01 = getEntArray("org_ice_block_scripted", "targetname");
  foreach(var_03 in var_01) {
    var_04 = getEntArray(var_03.var_1A2, "targetname");
    foreach(var_06 in var_04) {
      switch (var_06.var_165) {
        case "mdl_ice_block":
          var_03.mdl = var_06;
          break;

        case "mdl_ice_block_broken":
          var_03.mdl_broke = var_06;
          var_06 method_805C();
          break;

        case "clip_ice_block":
          var_03.var_241F = var_06;
          break;

        case "clip_ice_block_broke":
          var_06 notsolid();
          var_03.clip_broke = var_06;
          break;

        default:
          break;
      }
    }
  }

  var_09 = common_scripts\utility::func_46B5("spawn_cave_ice_breaker_main", "targetname");
  var_0A = lib_054D::func_90BA("zombie_dlc4", var_09, "corpse_eater", 0, 1, 0);
  maps\mp\_utility::func_2CED(0.5, ::spawn_ice_breaker_ice, var_0A);
  var_0A.startcorpseeater = 1;
  var_0A.cenerfedexplosion = 1;
  wait(0.5);
  playFX(level.var_611["zmb_desc_ice_falling"], var_09.var_116);
  if(level.var_744A.size >= 3 || common_scripts\utility::func_562E(param_00)) {
    var_0B = common_scripts\utility::func_46B5("spawn_cave_ice_breaker_main_2", "targetname");
    var_0C = lib_054D::func_90BA("zombie_dlc4", var_0B, "corpse_eater", 0, 1, 0);
    maps\mp\_utility::func_2CED(0.15, ::spawn_ice_breaker_ice, var_0C);
    var_0C.startcorpseeater = 1;
  }

  wait(0.25);
  if(level.var_744A.size >= 4 || common_scripts\utility::func_562E(param_00)) {
    var_0D = common_scripts\utility::func_46B5("spawn_cave_ice_breaker_main_3", "targetname");
    var_0E = lib_054D::func_90BA("zombie_dlc4", var_0D, "corpse_eater", 0, 1, 0);
    thread spawn_ice_breaker_ice(var_0E);
    var_0E.startcorpseeater = 1;
    foreach(var_03 in var_01) {
      var_03 maps\mp\mp_zombie_descent_ee_main::ice_block_break();
    }
  }
}

spawn_ice_breaker_ice(param_00) {
  playFX(common_scripts\utility::func_44F5("ice_destruct_chunk"), param_00.var_116, anglesToForward(param_00.var_1D), anglestoup(param_00.var_1D));
}

on_game_start_descent() {
  maps\mp\zombies\zombie_sizzler::func_D5();
  maps\mp\zombies\zombie_corpse_eater::func_D5();
  maps\mp\zombies\zombie_king::func_D5();
  thread maps\mp\mp_zombie_descent_utils::initwavestories();
  thread traps_init();
  level.roundstartfuncgeneric = ::descent_round_start;
  level.roundendfuncgeneric = ::descent_round_end;
  maps\mp\zombies\_zombies_magicbox::func_7CEA("stg44_zm");
  maps\mp\zombies\_zombies_magicbox::func_7CEA("svt40_zm");
  maps\mp\zombies\_zombies_magicbox::func_7CEA("greasegun_zm");
  maps\mp\zombies\_zombies_magicbox::func_7CEA("svt40_zm");
  maps\mp\zombies\_zombies_magicbox::func_7CEA("mp40_zm");
  maps\mp\zombies\_zombies_magicbox::func_7CEA("mp28_zm");
  maps\mp\zombies\_zombies_magicbox::func_7CEA("fg42_zm");
  maps\mp\zombies\_zombies_magicbox::func_7CEA("ppsh41_zm");
}

descent_round_start() {}

descent_round_end() {
  thread descent_attempt_wave_story();
  if(level.var_A980 >= 3) {
    common_scripts\utility::func_3C8F("flag_log_reveal_24");
  }

  if(level.var_A980 >= 5) {
    common_scripts\utility::func_3C8F("flag_log_reveal_25");
  }

  if(level.var_A980 >= 7) {
    common_scripts\utility::func_3C8F("flag_log_reveal_26");
  }

  if(level.var_A980 >= 9) {
    common_scripts\utility::func_3C8F("flag_log_reveal_27");
  }

  if(level.var_A980 >= 11) {
    common_scripts\utility::func_3C8F("flag_log_reveal_28");
  }

  if(level.var_A980 >= 13) {
    common_scripts\utility::func_3C8F("flag_log_reveal_29");
  }

  if(level.var_A980 >= 15) {
    common_scripts\utility::func_3C8F("flag_log_reveal_30");
  }
}

descent_attempt_wave_story() {
  wait(randomintrange(1, 3));
  if(level.var_A980 >= 3 && !common_scripts\utility::func_562E(level.has_played_radio_convo_1) && common_scripts\utility::func_562E(maps\mp\mp_zombie_descent_utils::vo_can_play_radio_convo())) {
    level thread maps\mp\mp_zombie_descent_utils::vo_radio_convo_map_start();
    return;
  }

  if(common_scripts\utility::func_24A6()) {
    if(!common_scripts\utility::func_562E(level.bossceremonyactive)) {
      level thread maps\mp\zombies\_zombies_audio_dlc2::playnextwavestory();
      return;
    }
  }
}

initprecache() {
  precacherumble("damage_heavy");
}

initdescentweapons() {
  thread lib_057D::func_5162();
  level thread lib_0580::func_D5();
  maps\mp\zombies\weapons\_zombie_dlc4_melee::func_D5();
  maps\mp\mp_zombie_descent_utils::vo_init_weapon_whispers();
}

func_5375() {
  lib_055A::func_D5();
  lib_055A::func_530A("zone_crash", 1);
  lib_055A::func_530A("zone_cave");
  lib_055A::func_530A("zone_archives");
  lib_055A::func_530A("zone_archives_closet");
  lib_055A::func_530A("zone_archives_basement");
  lib_055A::func_530A("zone_bridge");
  lib_055A::func_530A("zone_storage");
  lib_055A::func_530A("zone_gallery");
  lib_055A::func_530A("zone_alter");
  lib_055A::func_530A("zone_citadel");
  lib_055A::func_530A("zone_lost", 1, 0);
  lib_055A::func_530A("zone_trials_d", 1, 0);
  lib_055A::func_530A("zone_trials_b", 1, 0);
  lib_055A::func_530A("zone_trials_s", 1, 0);
  lib_055A::func_530A("zone_trials_m", 1, 0);
  lib_055A::func_530A("zone_sewers", 1, 0);
  lib_055A::func_993("zone_crash", "zone_cave", "flag_limbo_to_cave_1");
  lib_055A::func_993("zone_cave", "zone_archives", "flag_cave_to_archives_1");
  lib_055A::func_993("zone_cave", "zone_storage", "flag_cave_to_storage_1");
  lib_055A::func_993("zone_archives", "zone_archives_closet", "flag_archives_to_closet_1");
  lib_055A::func_993("zone_archives", "zone_archives_basement", "flag_archives_to_basement_1");
  lib_055A::func_993("zone_archives_closet", "zone_archives_basement", "flag_closet_to_basement_1");
  lib_055A::func_993("zone_archives", "zone_bridge", "flag_archives_to_bridge_1");
  lib_055A::func_993("zone_storage", "zone_bridge", "flag_storage_to_bridge_1");
  lib_055A::func_993("zone_gallery", "zone_storage", "flag_gallery_to_storage_1");
  lib_055A::func_993("zone_gallery", "zone_alter", "flag_gallery_to_alter_1");
  lib_055A::func_993("zone_gallery", "zone_bridge", "flag_gallery_to_bridge_1");
  lib_053F::func_7BE6(&"ZOMBIE_DLC4_AREA_CRASH", "flag_limbo_to_cave_1", 0);
  lib_053F::func_7BE6(&"ZOMBIE_DLC4_AREA_CAVES", "flag_limbo_to_cave_1", 1);
  lib_053F::func_7BE6(&"ZOMBIE_DLC4_AREA_CAVES", "flag_cave_to_archives_1", 0);
  lib_053F::func_7BE6(&"ZOMBIE_DLC4_AREA_ARCHIVES", "flag_cave_to_archives_1", 1);
  lib_053F::func_7BE6(&"ZOMBIE_DLC4_AREA_CAVES", "flag_cave_to_storage_1", 0);
  lib_053F::func_7BE6(&"ZOMBIE_DLC4_AREA_STORAGE", "flag_cave_to_storage_1", 1);
  lib_053F::func_7BE6(&"ZOMBIE_DLC4_AREA_CLOSET", "flag_archives_to_closet_1", 0);
  lib_053F::func_7BE6(&"ZOMBIE_DLC4_AREA_ARCHIVES", "flag_archives_to_closet_1", 1);
  lib_053F::func_7BE6(&"ZOMBIE_DLC4_AREA_ARCHIVES", "flag_archives_to_basement_1", 0);
  lib_053F::func_7BE6(&"ZOMBIE_DLC4_AREA_BASEMENT", "flag_archives_to_basement_1", 1);
  lib_053F::func_7BE6(&"ZOMBIE_DLC4_AREA_BASEMENT", "flag_closet_to_basement_1", 0);
  lib_053F::func_7BE6(&"ZOMBIE_DLC4_AREA_CLOSET", "flag_closet_to_basement_1", 1);
  lib_053F::func_7BE6(&"ZOMBIE_DLC4_AREA_ARCHIVES", "flag_archives_to_basement_1", 0);
  lib_053F::func_7BE6(&"ZOMBIE_DLC4_AREA_BASEMENT", "flag_archives_to_basement_1", 1);
  lib_053F::func_7BE6(&"ZOMBIE_DLC4_AREA_ARCHIVES", "flag_archives_to_bridge_1", 0);
  lib_053F::func_7BE6(&"ZOMBIE_DLC4_AREA_BRIDGE", "flag_archives_to_bridge_1", 1);
  lib_053F::func_7BE6(&"ZOMBIE_DLC4_AREA_STORAGE", "flag_gallery_to_storage_1", 0);
  lib_053F::func_7BE6(&"ZOMBIE_DLC4_AREA_GALLERY", "flag_gallery_to_storage_1", 1);
  lib_053F::func_7BE6(&"ZOMBIE_DLC4_AREA_GALLERY", "flag_gallery_to_alter_1", 0);
  lib_053F::func_7BE6(&"ZOMBIE_DLC4_AREA_ALTER", "flag_gallery_to_alter_1", 1);
  lib_053F::func_7BE6(&"ZOMBIE_DLC4_AREA_BRIDGE", "flag_gallery_to_bridge_1", 0);
  lib_053F::func_7BE6(&"ZOMBIE_DLC4_AREA_GALLERY", "flag_gallery_to_bridge_1", 1);
  lib_055A::func_88A();
}

hack_swap_basement_cloest_door_flag() {
  var_00 = undefined;
  var_01 = [];
  var_02 = [];
  var_03 = "flag_archives_to_basement_1";
  var_04 = (820, -116, 1388);
  var_05 = undefined;
  var_01 = common_scripts\utility::func_46B7("door", "targetname");
  var_06 = [];
  foreach(var_08 in var_01) {
    if(lib_0547::func_5565(var_08.var_819A, var_03)) {
      var_02[var_02.size] = var_08;
    }
  }

  foreach(var_08 in var_02) {
    if(distance(var_04, var_08.var_116) < 150) {
      var_05 = var_08;
      var_06 = getEntArray(var_08.var_1A2, "targetname");
    }
  }

  if(isDefined(var_05)) {
    var_05.var_819A = "flag_closet_to_basement_1";
    foreach(var_0D in var_06) {
      var_0D.var_819A = "flag_closet_to_basement_1";
    }
  }
}

func_5339() {
  lib_0557::func_786C();
  maps\mp\mp_zombie_descent_ee_main::func_D5();
  maps\mp\mp_zombie_descent_ee_side::func_D5();
  maps\mp\mp_zombie_descent_ee_boss_fight::func_D5();
  thread initquestnotebook();
}

initflags() {
  common_scripts\utility::func_3C87("flag_boss_complete");
  common_scripts\utility::func_3C87("flag_radio_picked_up");
  common_scripts\utility::func_3C87("flag_blood_pool_0");
  common_scripts\utility::func_3C87("flag_blood_pool_1");
  common_scripts\utility::func_3C87("flag_blood_pool_2");
}

initquestnotebook() {
  var_00 = [lib_0557::func_7838("quest_firstdoor", "quest_firstdoor_bloodpool"), lib_0557::func_7838("quest_pap", "quest_pap_1"), lib_0557::func_7838("quest_deathraven", "quest_deathraven_activate_rush"), lib_0557::func_7838("quest_deathraven", "quest_deathraven_pickup_weap"), "deathraven_spine_collected", "deathraven_metal_collected", lib_0557::func_7838("quest_deathraven", "quest_deathraven_assemble_weap"), lib_0557::func_7838("quest_deathraven", "quest_deathraven_fuse_weap"), lib_0557::func_7838("quest_deathraven", "quest_deathraven_enter_trial"), "flag_blood_pool_0", "flag_blood_pool_1", "stopper_collected", "flag_blood_pool_2", lib_0557::func_7838("quest_bloodraven", "quest_bloodraven_acquire_sheild"), "flag_radio_picked_up", lib_0557::func_7838("quest_bloodraven", "quest_bloodraven_complete_trial"), "flag_stormraven_stopper_1_collected", "flag_stormraven_stopper_2_collected", "flag_stormraven_stopper_3_collected", "flag_stormraven_stopper_4_collected", "flag_stormraven_stoppers_placed", "flag_stormraven_runes_charged", "flag_stormraven_hammer_picked_up", "flag_stormraven_charge_puzzle_activated", "flag_stormraven_charge_puzzle_stage_three_complete", lib_0557::func_7838("quest_stormraven", "step_stormraven_trial"), "moonraven_key_collected_01", "moonraven_key_collected_02", lib_0557::func_7838("quest_moonraven", "quest_moonraven_reveal_chart"), "flag_gears_collected_1", "flag_gears_collected_2", "flag_gears_collected_3", "moonraven_gears_all_placed", lib_0557::func_7838("quest_moonraven", "quest_moonraven_power_orrery"), lib_0557::func_7838("quest_moonraven", "quest_moonraven_acquire_scepter"), "moon_constellation_1_complete", "moon_constellation_2_complete", "moon_constellation_3_complete", lib_0557::func_7838("quest_moonraven", "quest_moonraven_unlock_trial"), lib_0557::func_7838("quest_moonraven", "quest_moonraven_enter_trial"), "flag_plinth_all_weapons_placed", lib_0557::func_7838("quest_bossfight", "quest_bossfight_start")];
  for(var_01 = 0; !all_flags_exist(var_00); var_01++) {
    wait 0.05;
  }

  foreach(var_03 in var_00) {
    lib_0557::func_AB8C(var_03);
  }
}

all_flags_exist(param_00) {
  foreach(var_02 in param_00) {
    if(!common_scripts\utility::func_3C83(var_02)) {
      return 0;
    }
  }

  return 1;
}

__________________traps__________________() {}

traps_init() {
  thread trap_archives_spikes();
}

trap_archives_spikes() {
  level.var_9CFB = 1;
  level.var_62B5 = 1;
  level.var_611["trap_ready"] = loadfx("vfx/zombie/zmb_trap_light_orange_small");
  level.var_611["trap_not_ready"] = loadfx("vfx/zombie/zmb_trap_light_orange_blink_small");
  level.var_9CD1["ready_to_active"] = undefined;
  level.var_9CD1["active_to_cooldown"] = undefined;
  level.var_9CD1["cooldown_to_active"] = undefined;
  var_00 = common_scripts\utility::func_46B5("trap_archives_spikes", "script_noteworthy");
  thread maps\mp\zombies\_zombies_traps::func_9CC6("trap_archives_spikes", "active", ::trap_archives_spikes_run);
}

trap_archives_spikes_run(param_00) {
  level.traparchivespikes = param_00 common_scripts\utility::func_8FFC();
  level.traparchivespikes.var_9CBB = "trap_archives_spikes";
  level.traparchivespikes.var_9C92 = param_00;
  param_00 trap_archives_spikes_handle_damage();
  param_00.var_565F = 0;
}

trap_archives_spikes_handle_damage() {
  self.var_565F = 1;
  thread trap_archives_spikes_check_for_end();
  var_00 = common_scripts\utility::func_46B7("archives_spike_trap_fx_point", "script_noteworthy");
  var_01 = [];
  foreach(var_03 in var_00) {
    var_04 = lib_0547::func_9470(var_03.var_8260);
    var_01[var_04] = var_03;
  }

  while(self.var_565F) {
    for(var_06 = 0; var_06 < var_01.size; var_06++) {
      var_07 = spawnfx(common_scripts\utility::func_44F5("spikeTrap"), var_01[var_06].var_116, anglesToForward(var_01[var_06].var_1D));
      triggerfx(var_07);
      thread trap_archives_spikes_damage_zombies(var_01[var_06]);
      thread trap_archives_spikes_damage_players(var_01[var_06]);
      lib_0378::func_8D74("aud_trap_spikes", var_01[var_06]);
      wait(0.5);
      var_07 delete();
    }

    for(var_06 = var_01.size - 1; var_06 >= 0; var_06--) {
      var_07 = spawnfx(common_scripts\utility::func_44F5("spikeTrap"), var_01[var_06].var_116, anglesToForward(var_01[var_06].var_1D));
      triggerfx(var_07);
      thread trap_archives_spikes_damage_zombies(var_01[var_06]);
      thread trap_archives_spikes_damage_players(var_01[var_06]);
      lib_0378::func_8D74("aud_trap_spikes", var_01[var_06]);
      wait(0.5);
      var_07 delete();
    }

    wait 0.05;
  }
}

trap_archives_spikes_check_for_end() {
  common_scripts\utility::knock_off_battery("cooldown", "no_power", "ready", "deactivate");
  self.var_565F = 0;
}

trap_archives_spikes_damage_zombies(param_00) {
  var_01 = lib_0547::func_408F();
  foreach(var_03 in var_01) {
    var_04 = distance2d(var_03.var_116, param_00.var_116);
    if(var_04 < 100 && var_03.var_116[2] < self.var_116[2]) {
      if(isalive(var_03) && var_03.var_BA4 != "traverse") {
        if(var_03 lib_0547::func_580A()) {
          var_03 dodamage(var_03.var_BC * 0.1, self.var_116, level.traparchivespikes, level.traparchivespikes, "MOD_EXPLOSIVE", "trap_zm_mp");
          continue;
        }

        var_03 dodamage(var_03.var_BC + 666, self.var_116, level.traparchivespikes, level.traparchivespikes, "MOD_EXPLOSIVE", "trap_zm_mp");
        if(!isDefined(var_03.hitbytrap)) {
          foreach(var_06 in level.var_744A) {
            var_06 maps\mp\gametypes\zombies::func_47C7("kill_trap");
            var_03.hitbytrap = 1;
          }
        }
      }
    }
  }
}

trap_archives_spikes_damage_players(param_00) {
  var_01 = level.var_744A;
  foreach(var_03 in var_01) {
    if(!isalive(var_03)) {
      continue;
    }

    if(lib_0547::func_577E(var_03)) {
      continue;
    }

    var_04 = distance2d(var_03.var_116, param_00.var_116);
    if(var_04 < 100 && var_03.var_116[2] < self.var_116[2]) {
      if(isalive(var_03) && !lib_0547::func_577E(var_03)) {
        var_03 dodamage(5, self.var_116, undefined, undefined, "MOD_CRUSH");
      }
    }
  }
}

door_death_fix() {
  while(!isDefined(level.var_AC1D)) {
    wait 0.05;
  }

  add_zombie_door_collision_handling("flag_gallery_to_bridge_1", 1, 1);
}

add_zombie_door_collision_handling(param_00, param_01, param_02) {
  var_03 = get_zombie_door(param_00);
  foreach(var_05 in var_03.var_64C5) {
    var_03 thread assign_collision_handling(var_05, param_01, param_02);
  }
}

get_zombie_door(param_00) {
  foreach(var_02 in level.var_AC1D) {
    if(lib_0547::func_5565(var_02.var_819A, param_00)) {
      return var_02;
    }
  }
}

assign_collision_handling(param_00, param_01, param_02) {
  param_00.var_A048 = [];
  var_03 = 2;
  foreach(var_05 in self.var_8301) {
    if(common_scripts\utility::func_562E(param_01)) {
      param_00 assign_door_collision_node(var_05, 1);
    }

    if(common_scripts\utility::func_562E(param_02)) {
      param_00 assign_door_collision_node(var_05, 0);
    }
  }

  param_00.var_A045 = ::zmd_door_collision_handler;
}

assign_door_collision_node(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.var_116 = getclosestpointonnavmesh(param_00.var_116 + pow(-1, !common_scripts\utility::func_562E(param_01)) * 32 * vectornormalize(anglestoright(param_00.var_1D)));
  self.var_A048 = common_scripts\utility::func_F6F(self.var_A048, var_02);
}

zmd_door_collision_handler(param_00) {
  maps\mp\_movers::func_A047(param_00, 0);
}