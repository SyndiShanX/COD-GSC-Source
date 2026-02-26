/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_279a5d4e51c06d1a.gsc
***********************************************/

#using script_268625b0934ee2ce;
#using script_2d443451ce681a;
#using script_35ae72be7b4fec10;
#using script_3626f1b2cf51a99c;
#using script_3919f386abede84;
#using script_3c70d86dfe255354;
#using script_3dc93ca9902a9cda;
#using script_549b1f81e7dfe241;
#using script_6f92dbd09c4e8204;
#using script_708fc8496e63a128;
#using script_758226507b1afa11;
#using script_86ebb5dd573a003;
#using script_9bfd3d8a6a89e5e;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\districts;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flashlight;
#using scripts\core_common\math_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\enemy;
#using scripts\core_common\stealth\player;
#using scripts\core_common\stealth\threat_sight;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\teleport_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp\cp_ger_stakeout_fx;
#using scripts\cp_common\collectibles;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hint_tutorial;
#using scripts\cp_common\note_display;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\player_decision;
#using scripts\cp_common\skipto;
#using scripts\cp_common\spawn_manager;
#using scripts\cp_common\ui\ent_name;
#using scripts\cp_common\util;
#using scripts\weapons\cp\spy_camera;
#namespace namespace_4dc9a074;

function function_4bf845e0() {}

function function_9de162de(str_objective) {
  player = getplayers()[0];
  player setmovespeedscale(0.8);
  player namespace_979752dc::set_disguised(1);
  player setcinematicmotionoverride("cinematicmotion_kgb");
  level thread namespace_dd1bf157::function_7691a965();
  doors::lock("bar_bathroom_door");
}

function function_b3837ddc(str_objective, var_50cc0d4f) {
  player = getplayers()[0];

  if(var_50cc0d4f) {
    namespace_5ceacc03::music("6.0_incoming_skipto");
    namespace_11998b8f::stakeout_stow_weapon();
    level thread function_da707a70();
    level scene::init("scene_z_stk_bar_amb");
    level battlechatter::function_2ab9360b(0);
  }

  level.var_4e5a623b = 0;
  level namespace_979752dc::function_2324f175(1);
  level flag::set("flag_show_vista_tower_02");
  exploder::stop_exploder("fx_exp_vista_tower1");
  exploder::exploder("fx_exp_vista_tower2");
  level thread function_341ad0ec();
  var_ea53aa29 = getEntArray("copcar02_lights", "script_noteworthy");
  var_e1029787 = getEntArray("copcar03_lights", "script_noteworthy");
  array::thread_all(var_ea53aa29, &function_430ffbdf);
  array::thread_all(var_e1029787, &function_430ffbdf);
  level thread function_2855eba1();
  level thread scene::add_scene_func("scene_z_stk_bar_alley", &function_897a03dd, "play");
  level thread scene::play("scene_z_stk_bar_alley");
  level thread namespace_3e1df757::function_b8875614();
  level thread function_92e02d40();
  doors::waittill_door_opened("alley_1_tutorial_door");
  level.var_df76ece5 = spawner::simple_spawn_single("alley_1_shop_enemy", &function_f84a2038);
  level flag::wait_till("alley_1_clear_stealth");
  level.var_df76ece5 thread function_86fa401d();
  level.var_df76ece5 thread function_22b1287a();
  level thread function_effdd8b5();
  level thread function_f1d4ab4b();
  scene::add_scene_func("scene_z_stk_ambient_cower", &function_b160d694);
  level thread scene::play("scene_z_stk_ambient_cower", "start_loop");

  if(scene::is_active("scene_z_stk_bar_alley")) {
    level scene::stop("scene_z_stk_bar_alley");
  }

  if(isDefined(level.var_469d2832)) {
    level.var_469d2832 deletedelay();
  }

  if(isDefined(level.var_346203bc)) {
    level.var_346203bc deletedelay();
  }

  level flag::wait_till("alley_1_done");
  skipto::function_4e3ab877(str_objective);
}

function function_4f2cda6a(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  if(player) {
    level flag::set("flag_show_vista_tower_02");
    exploder::stop_exploder("fx_exp_vista_tower1");
    exploder::exploder("fx_exp_vista_tower2");
    level flag::set("alley_1_done");
    trigger::use("cleanup_street_spawners", "targetname", undefined, 0);
  }
}

function function_897a03dd(a_ents) {
  level.var_d171f280 = a_ents[#"hash_2be22c6d5eea9d0c"];
  level.var_c338560d = a_ents[#"hash_2be22f6d5eeaa225"];
  level.var_469d2832 = a_ents[#"civ1"];
  level.var_346203bc = a_ents[#"civ2"];
  level.var_dcd38aa1 = a_ents[#"flashlight"];
  level.var_d171f280 thread function_a1c3157d("alley_1_stasi_1_node");
  level.var_c338560d thread function_a1c3157d("alley_1_stasi_2_node");
  level.var_469d2832 thread namespace_11998b8f::function_df4cd546();
  level.var_469d2832 setModel(#"hash_4268ef6ef4bf2c21");
  level.var_346203bc thread namespace_11998b8f::function_df4cd546();
  level.var_346203bc setModel(#"hash_426c746ef4c243f7");
  level.var_dcd38aa1 thread function_e70b3411();
  level.var_dcd38aa1 thread function_9c8bff5();
  var_f430b579 = level function_953d6fd0();

  if(isDefined(var_f430b579)) {
    level flag::wait_till("alley_1_start_harass_vo");
    level thread function_aad87078(level.var_d171f280, level.var_469d2832, level.var_346203bc, var_f430b579);
  }
}

function function_953d6fd0() {
  var_f430b579 = [];
  voline = spawnStruct();
  voline.alias = "vox_cp_stkt_07110_gmc3_mybuildingisrig_33";
  voline.ent = level.var_469d2832;
  voline.postdelay = 0.5;
  var_f430b579[var_f430b579.size] = voline;
  voline = spawnStruct();
  voline.alias = "vox_cp_stkt_07110_gms2_andyou_cf";
  voline.ent = level.var_d171f280;
  voline.postdelay = 1.5;
  var_f430b579[var_f430b579.size] = voline;
  voline = spawnStruct();
  voline.alias = "vox_cp_stkt_07110_gmc1_iamstayingwithm_ab";
  voline.ent = level.var_346203bc;
  voline.postdelay = 1;
  var_f430b579[var_f430b579.size] = voline;
  voline = spawnStruct();
  voline.alias = "vox_cp_stkt_07110_gms2_yourpapersbotho_d5";
  voline.ent = level.var_d171f280;
  voline.postdelay = 1;
  var_f430b579[var_f430b579.size] = voline;
  voline = spawnStruct();
  voline.alias = "vox_cp_stkt_07110_gmc3_finefinebutyouc_17";
  voline.ent = level.var_469d2832;
  voline.postdelay = 1.5;
  var_f430b579[var_f430b579.size] = voline;
  voline = spawnStruct();
  voline.alias = "vox_cp_stkt_07110_gms2_iwontaskyouagai_56";
  voline.ent = level.var_d171f280;
  voline.postdelay = 1;
  var_f430b579[var_f430b579.size] = voline;
  return var_f430b579;
}

function function_aad87078(guard, guy1, guy2, var_f430b579) {
  guard endon(#"death", #"hash_81580761b9ce6a5");
  guy1 endon(#"death", #"hash_81580761b9ce6a5");
  guy2 endon(#"death", #"hash_81580761b9ce6a5");

  foreach(var_1b73eecc in var_f430b579) {
    if(!isDefined(var_1b73eecc.ent)) {
      return;
    }

    voline = snd::play(var_1b73eecc.alias, [var_1b73eecc.ent, "j_head"]);
    snd::function_2fdc4fb(voline);
    wait var_1b73eecc.postdelay;
  }
}

function function_7b061d58() {
  self waittill(#"stealth_combat", #"damage", #"death", #"set_alert_level");
  level flag::set("alley_1_stealth_broken");
}

function function_a1c3157d(node) {
  self endon(#"death");
  self.var_c681e4c1 = 1;
  self.delete_on_path_end = 1;
  self.var_c5553760 = 1;
  self thread function_7b061d58();
  level flag::wait_till_any(array("alley_1_stealth_broken", "alley_1_clear_stealth"));

  if(level flag::get("alley_1_clear_stealth")) {
    self deletedelay();
    return;
  }

  if(level scene::is_active("scene_z_stk_bar_alley")) {
    level scene::stop("scene_z_stk_bar_alley");
  }

  self notify(#"hash_81580761b9ce6a5");
  self dialogue::function_47b06180();
  self namespace_979752dc::enable_stealth_for_ai(0);
  goal = getnode(node, "targetname");
  self spawner::go_to_node(goal);
  level flag::wait_till("alley_1_clear_stealth");

  if(level flag::get("stealth_spotted")) {
    namespace_979752dc::function_740dbf99();
  }

  self ai::set_behavior_attribute("demeanor", "cqb");
  self ai::set_behavior_attribute("sprint", 1);
}

function function_e70b3411() {
  self endon(#"death");
  self clientfield::set("sewer_exit_flashlight_fx", 1);
  level flag::wait_till("alley_1_stealth_broken");
  self setModel(#"com_flashlight_on_xforward_no_tag_weapon_off");
  self clientfield::set("sewer_exit_flashlight_fx", 0);

  if(level scene::is_active("scene_z_stk_bar_alley")) {
    level scene::stop("scene_z_stk_bar_alley");
  }

  self physicslaunch(self.origin, (1, 2, 2));
}

function function_9c8bff5() {
  level flag::wait_till("alley_1_clear_stealth");
  self clientfield::set("sewer_exit_flashlight_fx", 0);

  if(isDefined(self)) {
    self delete();
  }
}

function function_2855eba1() {
  player = getplayers()[0];
  bar_bathroom_window_cursor_hint_org = struct::get("bar_bathroom_window_cursor_hint_org");
  bar_bathroom_window_cursor_hint_org util::create_cursor_hint(undefined, (0, 0, -32), #"hash_65c0b59d247abbb7");
  level scene::init("cin_stakeout_alley1_bar_alley");
  bar_bathroom_window_cursor_hint_org waittill(#"trigger");
  player clearcinematicmotionoverride();
  namespace_5ceacc03::music("deactivate_6.0_incoming", 3);
  level thread namespace_5ceacc03::function_d494f15();
  level scene::play("cin_stakeout_alley1_bar_alley");
  exploder::stop_exploder("fx_exp_bar_window_rain");
  player val::reset("alley1", "allow_melee");
  player val::reset("alley1", "allow_sprint");
  wait 0.75;
  level thread hint_tutorial::function_4c2d4fc4(#"hash_61ebb02e310a3103", #"hash_249532bf0905ba7", 1, undefined, 1, 3);
  level thread hint_tutorial::pause(undefined, undefined, undefined, undefined, "continue");
  level waittill(#"continue");
  level flag::set("get_to_safehouse_meetup_breadcrumb_01_org_reached");
  namespace_5ceacc03::music("8.0_low_profile");
  wait 1.25;
  namespace_11998b8f::function_a73e6a64();
  player util::blend_movespeedscale_default(0.2);
  player namespace_979752dc::set_disguised(0);
  var_2922a5d = getweapon(#"pistol_semiauto_t9", "suppressed");

  if(player hasweapon(var_2922a5d)) {
    player switchtoweapon(var_2922a5d, 1);
  } else {
    a_weapons = player getweaponslistprimaries();

    if(a_weapons.size > 1) {
      for(i = 1; i < a_weapons.size; i++) {
        player takeweapon(a_weapons[i]);
      }
    }

    player giveweapon(var_2922a5d);
    player givemaxammo(var_2922a5d);
    player switchtoweapon(var_2922a5d, 1);
  }

  player spy_camera::function_6de171e9();
  level flag::clear("stop_supressed_hint");
  level thread namespace_11998b8f::function_81fce913();
  level thread function_c5a860f1();
  wait 1;

  if(level scene::is_active("scene_z_stk_bar_amb")) {
    level scene::stop("scene_z_stk_bar_amb");
  }

  if(isDefined(level.var_221cd219)) {
    level.var_221cd219 delete();
  }

  if(isDefined(level.var_305cee99)) {
    level.var_305cee99 delete();
  }
}

function function_92e02d40() {
  dialogue::radio("vox_cp_stkt_06400_adlr_belltheyreflood_31");
  level flag::wait_till("get_to_safehouse_meetup_breadcrumb_01_org_reached");
  wait 3.25;
  dialogue::radio("vox_cp_stkt_07100_adlr_changeofplansbe_67");
  wait 1;
  dialogue::radio("vox_cp_stkt_07100_adlr_rallyupwithlaza_97");
  wait 1.75;

  if(!level flag::get("alley_1_clear_stealth")) {
    level flag::wait_till("alley_1_clear_stealth");
    dialogue::radio("vox_cp_stkt_07200_lazr_carefulbellthes_39");
  }
}

function function_86fa401d() {
  self endon(#"death");
  player = getplayers()[0];
  player endon(#"takedown_active");
  self dialogue::queue("vox_cp_stkt_07715_gms2_comeoutiknowyou_d6");
  wait 5;
  self dialogue::queue("vox_cp_stkt_07715_gms2_iwonthurtyouiju_fb");
  wait 5;
  self dialogue::queue("vox_cp_stkt_07715_gms2_thelongeryoumak_75");
  wait 5;
  self dialogue::queue("vox_cp_stkt_07715_gms2_comeoutnowiwont_a9");
}

function function_b160d694(a_ents) {
  level.var_518a1ea7 = a_ents[#"guy1"];
}

function function_effdd8b5() {
  level.var_df76ece5 waittill(#"death");
  wait 1.5;
  level.var_518a1ea7 dialogue::queue("vox_cp_stkt_07715_gmc1_ishegone_b1");
  wait 1.25;
  level.var_518a1ea7 dialogue::queue("vox_cp_stkt_07715_gmc1_thankyousomuchi_a5");
}

function function_f84a2038() {
  self endon(#"death");
  self val::set("tailor_shop", "ignoreme", 1);
  self actions::function_df6077("body_shield", 0);
  self.var_c5553760 = 1;
  self.var_210e35f8 = 0;
  doors::waittill_door_opened("alley_rooftop_door");
  self val::reset("tailor_shop", "ignoreme");
}

function function_22b1287a() {
  player = getplayers()[0];
  player endon(#"death");
  wait 1;
  self util::waittill_any_ents(self, "stealth_combat", self, "set_alert_level", self, "stealth_investigate", self, "damage", self, "death", player, "takedown_active");
  self stopsounds();
}

function function_341ad0ec() {
  var_355c4095 = getEntArray("rotating_fan", "targetname");

  if(isDefined(var_355c4095)) {
    array::thread_all(var_355c4095, &namespace_11998b8f::function_638d18a, "alley_2_done", 2);
  }
}

function function_2d6c81be(str_objective) {
  level flag::set("force_informant_objective_active");
  doors::unlock("alley_1_tutorial_door");
  doors::open("alley_1_tutorial_door");
  level thread function_f1d4ab4b();
}

function function_34ee80b8(str_objective, var_50cc0d4f) {
  player = getplayers()[0];

  if(var_50cc0d4f) {
    level thread function_c5a860f1(1);
    level thread function_da707a70(1);
    level battlechatter::function_2ab9360b(0);
    level thread namespace_11998b8f::function_81fce913();
    level thread function_341ad0ec();
    var_ea53aa29 = getEntArray("copcar02_lights", "script_noteworthy");
    var_e1029787 = getEntArray("copcar03_lights", "script_noteworthy");
    array::thread_all(var_ea53aa29, &function_430ffbdf);
    array::thread_all(var_e1029787, &function_430ffbdf);
  }

  level.var_4e5a623b = 0;
  level namespace_979752dc::function_2324f175(1);
  level.stealth.stealth_spotted_delay = 1.25;
  level flag::set("alley_2_begin");
  level thread namespace_11998b8f::function_489032c9();
  level thread function_2bebd40b();
  level thread function_5f26b0d6();
  level flag::wait_till("flag_spawn_alley_2");
  level thread function_2470214();
  level thread function_fa0e91cf();
  level thread function_1340adc1();
  wait 0.1;
  level thread function_3e93882();
  level thread function_b75e3865();
  level thread function_9f5019a();
  level thread namespace_11998b8f::function_91a7f501("alley_2_ambient_harass_loop", "alley_2_done");
  level thread namespace_11998b8f::function_a34d0dd3("alley_2_one_off", "alley_2_done");
  var_184d8d2 = getent("alley_2_police_car_static", "targetname");
  var_184d8d2 thread function_78f01844("light_copcar01_");
  var_184d8d2 thread function_a3e65ec0(undefined, "copcar01_lights");
  var_364e83ee = spawner::simple_spawn("alley_2_enemies_hunt", &function_8ed10706);
  doors::waittill_door_opened("alley_rooftop_door");
  level battlechatter::function_2ab9360b(1);
  level.var_364e83ee = getaiteamarray("axis");
  array::thread_all(level.var_364e83ee, &function_f7f311b1);
  level thread function_1b5a6cdf();
  level thread function_dee5c2a0();
  level thread function_e192b067();
  level thread function_b9a028e4("alley_bldg_01_door_01", "flag_alley_2_right_stasi_door");
  level thread function_b9a028e4("alley_bldg_01_door_02", "flag_alley_2_right_stasi_door");
  level thread function_67faeb63();
  level thread function_b73565a9();
  level thread function_deb70deb();
  level flag::wait_till("alley_2_done");
  player namespace_6cecf2d8::function_9fa1a484();
  player thread spy_camera::function_c11bdcc0();
  level thread function_d7595334();
  skipto::function_4e3ab877(str_objective);
}

function function_821fcf7c(str_objective, var_50cc0d4f, var_aa1a6455, player) {}

function function_d2de5ec5(scenedef) {
  if(level scene::is_active(scenedef)) {
    level scene::stop(scenedef, 1);
  }
}

function function_5f26b0d6() {
  a_weapons = getEntArray("alley_weapons", "targetname");

  foreach(weapon in a_weapons) {
    weapon hide();
  }

  level flag::wait_till("alley_2_police_cars_stopped");

  foreach(weapon in a_weapons) {
    weapon show();
  }
}

function function_f7f311b1() {
  level endon(#"alley_2_stealth_was_broken", #"alley_2_done");
  self endon(#"death");
  self waittill(#"stealth_investigate");
  level flag::set("flag_alley_2_investigate");
}

function function_d7595334() {
  level flag::wait_till("flag_alley_3_lazar_close_door");
  waitframe(1);
  level.stealth.stealth_spotted_delay = undefined;
  function_1eaaceab(level.var_364e83ee);
  level thread function_d2de5ec5("scene_z_stk_alley_harass_police_arrival_first_car");
  level thread function_d2de5ec5("scene_z_stk_alley_harass_police_arrival_civs");

  foreach(enemy in level.var_364e83ee) {
    if(!enemy scene::function_c935c42()) {
      enemy delete();
    }
  }

  if(isDefined(level.var_cac5e635)) {
    array::delete_all(level.var_cac5e635);
  }

  if(isDefined(level.informant_enemies)) {
    array::delete_all(level.informant_enemies);
  }

  if(isDefined(level.informant)) {
    level.informant delete();
  }

  ai = getaiteamarray("axis");

  foreach(guy in ai) {
    if(guy scene::function_c935c42()) {
      guy scene::stop();
    }

    guy delete();
  }

  waitframe(1);
  namespace_979752dc::function_740dbf99();
}

function function_67faeb63() {
  level endon(#"alley_2_done");
  player = getplayers()[0];
  player endon(#"death");
  level flag::wait_till("stealth_spotted");
  e_vol = getent("vol_tailor_shop", "targetname");
  start_time = undefined;

  while(flag::get("stealth_spotted")) {
    if(player istouching(e_vol)) {
      start_time = gettime();

      for(cur_time = gettime(); player istouching(e_vol); cur_time = gettime()) {
        if(cur_time > start_time + 7000) {
          reinforcements = spawner::simple_spawn("alley_2_enemies_tailor_shop", &function_6d36d51);
          level.var_364e83ee = arraycombine(level.var_364e83ee, reinforcements, 0, 0);
          break;
        }

        waitframe(1);
      }

      continue;
    }

    while(!player istouching(e_vol)) {
      waitframe(1);
    }
  }
}

function function_b73565a9() {
  level endon(#"alley_2_done");
  player = getplayers()[0];
  player endon(#"death");
  var_20ffd2a = level.var_364e83ee.size;
  level flag::wait_till("stealth_spotted");
  level flag::set("alley_2_stealth_was_broken");
  var_d98f08de = getEntArray("alley_2_combat_volumes", "targetname");
  player_loc = undefined;
  var_b077f50d = getEntArray("vol_cooldown_area", "targetname");

  foreach(var_c6e544e in var_b077f50d) {
    if(player istouching(var_c6e544e)) {
      foreach(vol in var_d98f08de) {
        if(vol.script_noteworthy == "south") {
          player_loc = vol;
        }
      }
    }
  }

  if(!isDefined(player_loc)) {
    player_loc = player function_d5e510c4(var_d98f08de);
  }

  function_1eaaceab(level.var_364e83ee);

  foreach(enemy in level.var_364e83ee) {
    enemy thread function_1f109c27(player_loc, var_d98f08de, var_20ffd2a);
  }

  rusher = array::random(level.var_364e83ee);
  rusher thread function_6a2ab90();
  level thread ai::function_b0bd06fa("alley_enemies", 15, "flag_alley_combat_started");
  level thread ai::function_b0bd06fa("alley_enemies", 12, "flag_alley_retreat_to_mid");
  level flag::wait_till("flag_alley_retreat_to_mid");

  var_6a85ff6f = [];
  function_1eaaceab(level.var_364e83ee);

  foreach(enemy in level.var_364e83ee) {
    if(randomint(100) < 35 && var_6a85ff6f.size < 3) {
      enemy thread function_6a2ab90();
      array::add(var_6a85ff6f, enemy);
      continue;
    }

    enemy thread function_4c05f374(var_d98f08de);
  }

  level thread function_6220c1cb();
  level thread ai::function_b0bd06fa("alley_enemies", 11, "flag_alley_combat_enable_end");
  level thread ai::function_b0bd06fa("alley_enemies", 6, "flag_alley_retreat_to_end");
  level flag::wait_till("flag_alley_retreat_to_end");

  var_c6e544e = getent("alley_2_end_volume", "targetname");
  var_34b493cd = [];
  function_1eaaceab(level.var_364e83ee);

  foreach(enemy in level.var_364e83ee) {
    if(var_34b493cd.size < 3) {
      enemy thread function_6a2ab90();
      array::add(var_34b493cd, enemy);
      continue;
    }

    if(isDefined(var_c6e544e)) {
      enemy setgoal(var_c6e544e);
    }
  }
}

function function_6a2ab90() {
  self endon(#"death");

  if(level flag::get_any(array("flag_alley_retreat_to_end", "alley_2_spawn_lazar"))) {
    return;
  }

  goal_radius = 256;
  self.ignoresuppression = 1;
  self setgoal(getplayers()[0], 0, goal_radius);
  self thread function_9df23ee0();
  level flag::wait_till("flag_alley_retreat_to_end");

  if(isDefined(self) && isalive(self)) {
    self.ignoresuppression = 0;
    vol = getent("alley_2_end_volume", "targetname");

    if(isDefined(vol)) {
      self setgoal(vol, 1);
    }
  }
}

function function_9df23ee0() {
  self endon(#"death");
  level flag::wait_till("alley_2_spawn_lazar");

  if(isDefined(self) && isalive(self)) {
    self.ignoresuppression = 0;
    vol = getent("alley_2_end_volume", "targetname");

    if(isDefined(vol)) {
      self setgoal(vol, 1);
    }
  }
}

function function_d5e510c4(var_d98f08de) {
  var_3b349c1 = [];

  foreach(vol in var_d98f08de) {
    if(self istouching(vol)) {
      if(!isDefined(var_3b349c1)) {
        var_3b349c1 = [];
      } else if(!isarray(var_3b349c1)) {
        var_3b349c1 = array(var_3b349c1);
      }

      var_3b349c1[var_3b349c1.size] = vol;
    }
  }

  if(var_3b349c1.size == 0 || var_3b349c1.size == 1) {
    return var_3b349c1[0];
  }

  array::sort_by_script_int(var_3b349c1, 1);
  return var_3b349c1[0];
}

function function_1f109c27(player_loc, var_d98f08de, var_20ffd2a) {
  self endon(#"death");
  player = getplayers()[0];

  if(!isDefined(player_loc) && !isDefined(player_loc.script_noteworthy)) {
    return;
  }

  self.var_9d593aa3 = 1;
  var_ff276e82 = undefined;
  var_789316a3 = undefined;
  var_9e2a9e1 = undefined;
  var_37cc4e07 = undefined;
  var_1f176f29 = undefined;
  var_46921b42 = undefined;
  var_b7deadbf = undefined;

  foreach(volume in var_d98f08de) {
    if(isDefined(volume.script_noteworthy)) {
      if(volume.script_noteworthy == "north") {
        var_ff276e82 = volume;
      }

      if(volume.script_noteworthy == "middle") {
        var_789316a3 = volume;
      }

      if(volume.script_noteworthy == "east") {
        var_9e2a9e1 = volume;

        if(isDefined(var_9e2a9e1.linkto)) {
          var_46921b42 = getent(var_9e2a9e1.linkto, "linkname");
        }
      }

      if(volume.script_noteworthy == "west") {
        var_37cc4e07 = volume;

        if(isDefined(var_37cc4e07.linkto)) {
          var_b7deadbf = getent(var_37cc4e07.linkto, "linkname");
        }
      }

      if(volume.script_noteworthy == "south") {
        var_1f176f29 = volume;
      }
    }
  }

  if(isDefined(self.targetname) && self.targetname == "alley_2_enemies_intro") {
    while(self flag::get("in_car")) {
      waitframe(1);
    }
  }

  var_f8da3f2c = self function_d5e510c4(var_d98f08de);

  if(!isDefined(var_f8da3f2c)) {
    return;
  }

  function_1eaaceab(level.var_364e83ee);

  if(player_loc.script_noteworthy == "north" && level.var_364e83ee.size >= var_20ffd2a - 3) {
    self setgoal(var_f8da3f2c);
    return;
  }

  if(player_loc.script_noteworthy == "north" || player_loc.script_noteworthy == "middle") {
    switch (var_f8da3f2c.script_noteworthy) {
      case # "north":
        self setgoal(var_789316a3);
        break;
      default:
        self setgoal(var_f8da3f2c);
        break;
    }

    return;
  }

  if(player_loc.script_noteworthy == "east") {
    switch (var_f8da3f2c.script_noteworthy) {
      case # "north":
        self setgoal(var_789316a3);
        break;
      case # "east":
        if(self istouching(var_46921b42)) {
          if(player istouching(var_46921b42)) {
            self setgoal(var_46921b42);
          } else {
            self setgoal(var_789316a3);
          }
        } else {
          self setgoal(var_f8da3f2c);
        }

        break;
      default:
        self setgoal(var_f8da3f2c);
        break;
    }

    return;
  }

  if(player_loc.script_noteworthy == "west") {
    switch (var_f8da3f2c.script_noteworthy) {
      case # "north":
        self setgoal(var_789316a3);
        break;
      case # "west":
        if(self istouching(var_b7deadbf)) {
          if(player istouching(var_b7deadbf)) {
            self setgoal(var_b7deadbf);
          } else {
            self setgoal(var_789316a3);
          }
        } else {
          self setgoal(var_f8da3f2c);
        }

        break;
      default:
        self setgoal(var_f8da3f2c);
        break;
    }

    return;
  }

  switch (var_f8da3f2c.script_noteworthy) {
    case # "north":
      num = randomint(3);

      if(num == 0) {
        self setgoal(var_37cc4e07);
      }

      if(num == 1) {
        self setgoal(var_789316a3);
      } else {
        self setgoal(var_9e2a9e1);
      }

      break;
    default:
      self setgoal(var_f8da3f2c);
      break;
  }
}

function function_4c05f374(var_d98f08de) {
  self endon(#"death");
  var_ff276e82 = undefined;
  var_789316a3 = undefined;
  var_9e2a9e1 = undefined;
  var_37cc4e07 = undefined;
  var_1f176f29 = undefined;
  var_46921b42 = undefined;
  var_b7deadbf = undefined;

  foreach(volume in var_d98f08de) {
    if(isDefined(volume.script_noteworthy)) {
      if(volume.script_noteworthy == "north") {
        var_ff276e82 = volume;
      }

      if(volume.script_noteworthy == "middle") {
        var_789316a3 = volume;
      }

      if(volume.script_noteworthy == "east") {
        var_9e2a9e1 = volume;

        if(isDefined(var_9e2a9e1.linkto)) {
          var_46921b42 = getent(var_9e2a9e1.linkto, "linkname");
        }
      }

      if(volume.script_noteworthy == "west") {
        var_37cc4e07 = volume;

        if(isDefined(var_37cc4e07.linkto)) {
          var_b7deadbf = getent(var_37cc4e07.linkto, "linkname");
        }
      }

      if(volume.script_noteworthy == "south") {
        var_1f176f29 = volume;
      }
    }
  }

  var_f8da3f2c = self function_d5e510c4(var_d98f08de);

  if(!isDefined(var_f8da3f2c)) {
    return;
  }

  if(var_f8da3f2c.script_noteworthy == "north") {
    self setgoal(var_789316a3);
    return;
  }

  if(var_f8da3f2c.script_noteworthy == "east") {
    if(self istouching(var_46921b42)) {
      self setgoal(var_789316a3);
    }

    return;
  }

  if(var_f8da3f2c.script_noteworthy == "west") {
    if(self istouching(var_b7deadbf)) {
      self setgoal(var_789316a3);
    }
  }
}

function function_6220c1cb() {
  level endon(#"alley_2_done");
  player = getplayers()[0];
  level flag::set("alley_reinforcements_active");
  flag_return = level flag::wait_till_any(array("alley_reinforcements_west", "alley_reinforcements_east", "alley_reinforcements_middle"));
  triggers = getEntArray("alley_reinforcement_triggers", "targetname");
  array::delete_all(triggers);
  var_d2137f27 = doors::function_73f09315("alley_2_end_door");
  a_vols = getEntArray("vol_cooldown_area", "targetname");

  if(var_d2137f27 doors::is_open()) {
    return;
  }

  foreach(e_vol in a_vols) {
    if(player istouching(e_vol)) {
      return;
    }
  }

  if(flag_return._notify == "alley_reinforcements_west") {
    spawn_manager::enable("alley_2_reinforcement_west");
  }

  if(flag_return._notify == "alley_reinforcements_east") {
    spawn_manager::enable("alley_2_reinforcement_east");
  }

  if(flag_return._notify == "alley_reinforcements_middle") {
    spawn_manager::enable("alley_2_reinforcement_middle");
  }

  level.var_364e83ee = getaiteamarray("axis");
}

function function_8ed10706() {
  if(self.archetype == # "civilian") {
    return;
  }

  if(self.script_parameters === "flashlight") {
    self.flashlightoverride = 1;
  }

  if(self.team == "axis") {
    self.goalradius = 32;
    self namespace_979752dc::set_default_patrol_style("alert");
    self.var_9d593aa3 = 1;
  }
}

function function_6d36d51() {
  self.goalradius = 32;
}

function function_16cb86fb() {
  if(!isDefined(level.var_cac5e635)) {
    level.var_cac5e635 = [];
  } else if(!isarray(level.var_cac5e635)) {
    level.var_cac5e635 = array(level.var_cac5e635);
  }

  level.var_cac5e635[level.var_cac5e635.size] = self;
}

function function_b75e3865() {
  level endon(#"stealth_spotted");
  scene::add_scene_func("scene_z_stk_courtyard_harass", &namespace_11998b8f::function_e24505b7, "init");
  level.alley_2_enemies_harass_intro = spawner::simple_spawn("alley_2_enemies_harass_intro", &function_8ed10706);
  level scene::init("scene_z_stk_courtyard_harass", level.alley_2_enemies_harass_intro);
  doors::waittill_door_opened("alley_rooftop_door");
  level thread scene::play("scene_z_stk_courtyard_harass", level.alley_2_enemies_harass_intro);
}

function function_9f5019a() {
  scene::add_scene_func("scene_z_stk_alley_harass_police_arrival", &namespace_11998b8f::function_c1bc96cf, "play");
  scene::add_scene_func("scene_z_stk_alley_harass_police_arrival", &function_1b2bbf03, "play");
  scene::add_scene_func("scene_z_stk_alley_harass_police_arrival", &function_7c0934c5, "play");
  scene::add_scene_func("scene_z_stk_alley_harass_police_arrival_first_car", &namespace_11998b8f::function_f0338b42, "play");
  scene::add_scene_func("scene_z_stk_alley_harass_police_arrival_first_car", &function_1b2bbf03, "play");
  scene::add_scene_func("scene_z_stk_alley_harass_police_arrival_first_car", &function_7c0934c5, "play");
  scene::add_scene_func("scene_z_stk_alley_harass_police_arrival_civs", &namespace_11998b8f::function_3e251a37, "play");
  level.var_ded3c3a4 = spawner::simple_spawn("alley_2_enemies_intro", &function_8ed10706);
  var_b1244cc9 = vehicle::simple_spawn("alley_2_police_cars");
  var_a29118e6 = undefined;

  foreach(car in var_b1244cc9) {
    if(isDefined(car.animname) && car.animname == "policecar2") {
      var_a29118e6 = car;
    }
  }

  var_698135a2 = arraycombine(level.var_ded3c3a4, var_b1244cc9, 0, 0);
  level scene::init("scene_z_stk_alley_harass_police_arrival", var_698135a2);
  level.var_46aae738 = spawner::simple_spawn("alley_2_enemies_intro_1", &function_8ed10706);
  e_car = vehicle::simple_spawn_single("alley_2_police_car_1");
  var_83406920 = arraycombine(level.var_46aae738, array(e_car), 0, 0);
  level scene::init("scene_z_stk_alley_harass_police_arrival_first_car", var_83406920);
  level.var_74ae8632 = spawner::simple_spawn("alley_2_civs_intro");
  level scene::init("scene_z_stk_alley_harass_police_arrival_civs", level.var_74ae8632);
  doors::waittill_door_opened("alley_rooftop_door");
  thread namespace_5ceacc03::function_7aaa5ad4();
  wait 0.75;
  level thread namespace_11998b8f::function_87ee13bb();
  level thread scene::play("scene_z_stk_alley_harass_police_arrival_first_car", var_83406920);
  level thread scene::play("scene_z_stk_alley_harass_police_arrival_civs", level.var_74ae8632);
  level scene::play("scene_z_stk_alley_harass_police_arrival", "stasi_arrival", var_698135a2);

  if(isDefined(var_a29118e6)) {
    level scene::play("scene_z_stk_alley_harass_police_arrival", "end_loop", var_a29118e6);
  }

  level flag::wait_till("flag_alley_3_lazar_close_door");
  array::delete_all(var_b1244cc9);

  if(isDefined(e_car)) {
    e_car delete();
  }
}

function function_78f01844(var_60f29f4a) {
  self thread function_f240c973("headlight_left_broken", var_60f29f4a + "headlight_driver");
  self thread function_f240c973("headlight_right_broken", var_60f29f4a + "headlight_passenger");
  self thread function_f240c973("foglight_left_broken", var_60f29f4a + "fog_driver");
  self thread function_f240c973("foglight_right_broken", var_60f29f4a + "fog_passenger");
  self thread function_f240c973("taillight_left_broken", var_60f29f4a + "brake_driver");
  self thread function_f240c973("taillight_right_broken", var_60f29f4a + "brake_passenger");
  self thread function_f240c973("siren_left_broken", var_60f29f4a + "flashing_driver");
  self thread function_f240c973("siren_right_broken", var_60f29f4a + "flashing_passenger");
}

function function_f240c973(wait_notify, var_85c397ce) {
  while(true) {
    waitresult = self waittill(#"broken", #"death", #"destructible_car_explosion");

    if(waitresult._notify == "death" || waitresult.type == "destructible_car_explosion") {
      lights = getEntArray(var_85c397ce, "targetname");

      if(lights.size == 0) {
        return;
      }

      if(!self flag::get("car_death")) {
        self flag::set("car_death");
      } else {
        return;
      }

      var_41332d43 = undefined;

      foreach(e_light in lights) {
        if(isDefined(e_light.script_noteworthy)) {
          var_41332d43 = getEntArray(e_light.script_noteworthy, "script_noteworthy");
          break;
        }
      }

      if(isDefined(var_41332d43)) {
        foreach(e_light in var_41332d43) {
          e_light setlightintensity(0);
        }
      }

      return;
    }

    if(waitresult.type == wait_notify) {
      lights = getEntArray(var_85c397ce, "targetname");

      if(lights.size == 0) {
        return;
      }

      foreach(e_light in lights) {
        e_light setlightintensity(0);
      }

      return;
    }

    waitframe(1);
  }
}

function function_7c0934c5(a_ents) {
  foreach(ent in a_ents) {
    if(isDefined(ent.script_animname) && ent.script_animname == "policecar1") {
      ent thread function_c3335c5(undefined, "z_stk_alley_harass_police_arrival_enter_car1");
    }

    if(isDefined(ent.script_animname) && ent.script_animname == "policecar2") {
      ent thread function_c3335c5("light_copcar02_", "z_stk_alley_harass_police_arrival_enter_car2");
    }

    if(isDefined(ent.script_animname) && ent.script_animname == "policecar3") {
      ent thread function_c3335c5("light_copcar03_", "z_stk_alley_harass_police_arrival_enter_car3");
    }
  }
}

function function_c3335c5(var_85dcce9, animation) {
  self clientfield::set("constraint_toggle_field", 1);
  self waittill(#"stop_lights");

  if(isDefined(animation)) {
    self thread function_78f01844(animation);
  }

  self waittill(#"hash_45e4d42f90c914c9");
  new_origin = self.origin;
  new_angles = self.angles;
  self flag::wait_till_clear(#"scriptedanim");
  self.origin = new_origin;
  self.angles = new_angles;
}

function function_1b2bbf03(a_ents) {
  foreach(ent in a_ents) {
    if(isDefined(ent.script_animname) && ent.script_animname == "policecar1") {
      ent thread function_153e6d97(1, 1, "stop_lights");
    }

    if(isDefined(ent.script_animname) && ent.script_animname == "policecar2") {
      ent thread function_153e6d97(1, 1, "stop_lights");
      ent thread function_a3e65ec0("stop_lights", "copcar02_lights", 1);
    }

    if(isDefined(ent.script_animname) && ent.script_animname == "policecar3") {
      ent thread function_153e6d97(1, 1, "stop_lights");
      ent thread function_a3e65ec0("stop_lights", "copcar03_lights", 1);
    }
  }
}

function function_153e6d97(lights, var_686a32c8, var_3e3521f8, var_ae14ed6b) {
  if(is_true(lights)) {
    self thread cp_ger_stakeout_fx::function_93e3e68a(1);
  }

  if(is_true(var_686a32c8)) {
    self thread cp_ger_stakeout_fx::function_ad03f35b(1);
  }

  if(isDefined(var_3e3521f8)) {
    self waittill(var_3e3521f8);
  }

  if(isDefined(var_ae14ed6b)) {
    level waittill(var_ae14ed6b);
  }

  if(is_true(lights)) {
    self thread cp_ger_stakeout_fx::function_93e3e68a();
  }

  if(is_true(var_686a32c8)) {
    self thread cp_ger_stakeout_fx::function_ad03f35b();
  }
}

function function_a3e65ec0(var_ad04d74, var_4f28206f, lights_on) {
  if(isDefined(var_ad04d74)) {
    self waittill(var_ad04d74);
  }

  var_85c397ce = getEntArray(var_4f28206f, "script_noteworthy");
  array::thread_all(var_85c397ce, &function_cb6db640, self, lights_on);
}

function function_cb6db640(car, lights_on) {
  if(isDefined(self.targetname) && isDefined(car) && isDefined(car.model)) {
    if(issubstr(self.targetname, "headlight_driver")) {
      self linkto(car, "tag_fx_headlight_left", (2, 0, 0), (15, 0, 0));
    }

    if(issubstr(self.targetname, "headlight_passenger")) {
      self linkto(car, "tag_fx_headlight_right", (2, 0, 0), (15, 0, 0));
    }

    if(issubstr(self.targetname, "fog_driver")) {
      self linkto(car, "tag_fx_foglight_left", (3, 0, 0), (0, 0, 0));
    }

    if(issubstr(self.targetname, "fog_passenger")) {
      self linkto(car, "tag_fx_foglight_right", (3, 0, 0), (0, 0, 0));
    }

    if(issubstr(self.targetname, "brake_driver")) {
      self linkto(car, "tag_fx_tail_light_left", (3, 0, 0), (30, 0, 0));
    }

    if(issubstr(self.targetname, "brake_passenger")) {
      self linkto(car, "tag_fx_tail_light_right", (3, 0, 0), (30, 0, 0));
    }

    if(issubstr(self.targetname, "flashing_driver")) {
      self linkto(car, "tag_siren_glass_left_d0");
    }

    if(issubstr(self.targetname, "flashing_passenger")) {
      self linkto(car, "tag_siren_glass_right_d0");
    }
  }

  if(is_true(lights_on)) {
    if(isDefined(self.default_intensity)) {
      self setlightintensity(self.default_intensity);
      return;
    }

    self setlightintensity(1);
  }
}

function function_430ffbdf() {
  self.default_intensity = self getlightintensity();
  waitframe(1);
  self setlightintensity(0);
}

function function_f1d4ab4b() {
  scene::add_scene_func("scene_z_stk_amb_curtain_close", &function_83c96fe5, "init");
  scene::add_scene_func("scene_z_stk_amb_window_peek", &function_65090e11, "play");
  waitframe(1);
  level thread scene::play("scene_z_stk_amb_window_peek");
  level scene::init("scene_z_stk_amb_curtain_close");
  level flag::wait_till("flag_alley_2_close_curtains");
  level scene::play("scene_z_stk_amb_curtain_close");
}

function function_83c96fe5(a_ents) {
  level flag::wait_till("alley_2_done");

  if(isDefined(a_ents[#"civ"])) {
    level scene::stop("scene_z_stk_amb_curtain_close");
    a_ents[#"civ"] delete();
  }

  if(isDefined(a_ents[#"curtains"])) {
    a_ents[#"curtains"] delete();
  }
}

function function_65090e11(a_ents) {
  a_ents[#"civ1"] thread namespace_11998b8f::function_a6affb6a();
  a_ents[#"civ2"] thread namespace_11998b8f::function_a6affb6a();
  level flag::wait_till("alley_2_done");

  if(level scene::is_active("scene_z_stk_amb_window_peek")) {
    level scene::stop("scene_z_stk_amb_window_peek");
  }

  if(isDefined(a_ents[#"civ1"])) {
    a_ents[#"civ1"] delete();
  }

  if(isDefined(a_ents[#"civ2"])) {
    a_ents[#"civ2"] delete();
  }
}

function function_b9a028e4(door, flag) {
  if(!isDefined(door)) {
    return;
  }

  doors::waittill_door_opened(door);

  if(!isDefined(flag)) {
    return;
  }

  level flag::set(flag);
}

function function_e192b067() {
  level flag::wait_till("flag_alley_gunshots");
  exploder::exploder("fx_exp_alley_gunshot");
  snd::play("evt_indoor_gunfire", (-1265, 7511, 215));
  wait 2;
  exploder::exploder("fx_exp_alley_gunshot");
  snd::play("evt_indoor_gunfire", (-1265, 7511, 215));
  wait 0.2;
  exploder::exploder("fx_exp_alley_gunshot");
  snd::play("evt_indoor_gunfire", (-1265, 7511, 215));
}

function function_1b5a6cdf() {
  level endon(#"alley_2_done", #"stealth_spotted");
  wait 3;
  player = getplayers()[0];
  player thread spy_camera::function_69190c4e();
  player util::show_hint_text(#"hash_781598921bc9b69e", undefined, undefined, 4);
  player waittill(#"hash_59b80e9e535f9788");
  player util::hide_hint_text();
  wait 2;
  player util::show_hint_text(#"hash_15f6e99dbddd12f3", undefined, undefined, 4);
}

function function_2470214() {
  doors::waittill_door_opened("alley_rooftop_door");
  dialogue::radio("vox_cp_stkt_07200_lazr_meetmeattheapar_13");
  level flag::set("alley_2_ping_lazar");
  wait 1;
  dialogue::radio("vox_cp_stkt_07200_lazr_illprovideoverw_93");
}

function function_fa0e91cf() {
  player = getplayers()[0];
  player endon(#"death");
  level flag::wait_till("start_alley_2_mid_team_checkin_vo");
  dialogue::radio("vox_cp_stkt_07286_adlr_parkgimmeasitre_4f");
  dialogue::radio("vox_cp_stkt_07286_park_krausjustarrive_28");
  dialogue::radio("vox_cp_stkt_07286_adlr_thestasiarecomb_8d");
  dialogue::radio("vox_cp_stkt_07286_adlr_bellgettoparkan_22");
}

function function_1340adc1() {
  while(!isDefined(level.var_b86d4e0)) {
    waitframe(1);
  }

  level.var_b86d4e0 endon(#"death");
  level flag::wait_till("alley_2_knocking_vo");
  wait 3;

  if(isDefined(level.var_b86d4e0)) {
    level.var_b86d4e0 dialogue::queue("vox_cp_stkt_07160_gms3_hello_33");
  }
}

function function_2bebd40b() {
  level endon(#"hash_5d918db7108403b2");
  level thread function_fdfb1e97();
  var_9a690256 = getent("collectible_reel", "targetname");

  if(isDefined(var_9a690256)) {
    if(collectibles::function_ab921f3d(2)) {
      var_9a690256 delete();
      return;
    }

    var_9a690256 util::create_cursor_hint("tag_origin", (0, 0, 4), #"hash_7993f62965290e3a");
    var_9a690256 collectibles::function_d06c5a39();
    var_9a690256 waittill(#"trigger");
    snd::play("evt_ledger_pickup", level.player);
    level.player playgestureviewmodel("ges_stk_intel_inspect_tape_reel");
    wait 0.4;
    var_9a690256 delete();
    collectibles::function_6cd091d2(2);
  }
}

function private function_fdfb1e97() {
  self notify("22b98fdf68d1bab2");
  self endon("22b98fdf68d1bab2");

  while(true) {
    level waittill(#"save_restore");

    if(collectibles::function_ab921f3d(2)) {
      level notify(#"hash_5d918db7108403b2");
      var_9a690256 = getent("collectible_reel", "targetname");

      if(isDefined(var_9a690256)) {
        var_9a690256 util::remove_cursor_hint();
        var_9a690256 delete();
      }
    }
  }
}

function function_5e8eb7c1(skipto) {
  if(!is_true(skipto)) {
    level flag::wait_till("alley_1_done");
  }

  if(isDefined(objectives::function_285e460(#"hash_d3429885cbd2853"))) {
    position = struct::get("alley_stasi_field_house_obj_org_01", "targetname");
    objectives::show(#"hash_d3429885cbd2853");
    objectives::update_position(#"hash_d3429885cbd2853", position.origin);
    objectives::function_67f87f80(#"hash_d3429885cbd2853", undefined, #"hash_3f0ff8958b0e0afa");
    level thread function_d5bb4d12();
  }

  level thread function_b6b34597();
  level thread function_51bd3310();
  level flag::set("informant_not_found");
  level flag::wait_till("flag_alley_3_lazar_close_door");

  if(level flag::get("informant_not_found")) {
    objectives::remove(#"hash_d3429885cbd2853");
  }
}

function function_d5bb4d12() {
  level endon(#"alley_2_done", #"informant_released", #"informant_killed");

  while(true) {
    level flag::wait_till("alley_stasi_field_house_reached");

    if(isDefined(objectives::function_285e460(#"hash_d3429885cbd2853"))) {
      objectives::update_position(#"hash_d3429885cbd2853", level.informant.origin + (0, 0, 64));
    }

    level flag::wait_till_clear("alley_stasi_field_house_reached");

    if(isDefined(objectives::function_285e460(#"hash_d3429885cbd2853"))) {
      position = struct::get("alley_stasi_field_house_obj_org_01", "targetname");
      objectives::update_position(#"hash_d3429885cbd2853", position.origin);
    }
  }
}

function function_51bd3310() {
  player = getplayers()[0];
  player endon(#"death");
  stasi_field_house_note_01 = getent("stasi_field_house_note_01", "targetname");
  stasi_field_house_note_01 util::create_cursor_hint(undefined, (0, 0, 2), #"hash_278936de1fc46bb3");

  while(true) {
    stasi_field_house_note_01 waittill(#"trigger");
    level.player note_display::function_97c69304(#"hash_fc621cb1d8856f8", 1, 2, undefined, undefined, 2);
    level flag::clear("informant_choice_05_note_not_found");
    level flag::set("informant_choice_04_note_found");
    player stats::function_dad108fa(#"hash_2e8136ca701b3dad", 1);
  }
}

function function_b6b34597() {
  level flag::wait_till("flag_spawn_informant_room");
  level thread function_c58eb80a();
  level.informant_enemies = spawner::simple_spawn("informant_enemies", &function_d29b9236);
  level.informant = spawner::simple_spawn_single("informant", &function_dfd339e4);
  doors::waittill_door_opened("informant_door");
  level thread savegame::checkpoint_save();
  level flag::wait_till("flag_exit_informant_room");
  level thread savegame::checkpoint_save();
}

function function_d29b9236() {
  self.original_health = self.health;
  self.health = 50;
  self.var_c681e4c1 = 1;
  self.var_c5553760 = 1;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "sleeping") {
    self setModel(#"hash_1d0241ab77617dc7");
  }

  self namespace_979752dc::function_2324f175(0);
  self thread function_82101426();
}

function function_82101426() {
  self endon(#"death", #"damage");
  level endon(#"alley_2_done");
  self waittill(#"stealth_combat", #"set_alert_level", #"alert_level_increase", #"stealth_investigate");

  if(isDefined(self.original_health)) {
    self.health = self.original_health;
  }
}

function function_c58eb80a() {
  vol = getent("informant_gv", "targetname");
  vol endon(#"death");
  player = getplayers()[0];

  while(!flag::get("alley_2_done")) {
    while(!player istouching(vol)) {
      waitframe(1);
    }

    setDvar(#"bg_friendlyfiremode", 0);

    while(player istouching(vol)) {
      waitframe(1);
    }

    setDvar(#"bg_friendlyfiremode", 1);
    waitframe(1);
  }
}

function function_dfd339e4() {
  level endon(#"mission_failed");
  self endon(#"death");
  level flag::clear("informant_not_found");
  self.targetname = "actor_informant";
  old_model = # "c_t9_cp_ger_civ_male_informant_body";
  new_model = # "c_t9_cp_ger_civ_male_informant_body_tape";
  self detach(old_model);
  self attach(new_model);
  self setteam(#"allies");
  self setCanDamage(1);
  self.var_c681e4c1 = 1;
  self.skipdeath = 1;
  self.pushable = 0;
  self pushplayer(1);
  self.var_2609b537 = 1;
  self.health = 100000;
  level scene::init("aib_vign_stakeout_alley2_informant");
  self thread function_4c53321a();
  self thread function_1bad6781();
  self thread function_761b250d();

  if(!level flag::get("informant_released")) {
    self thread function_1b6d2916();
  }

  self waittill(#"hash_4d9e21fd0dcc04a9");
  level thread function_35612e24();
  self thread function_90382186();
  self setCanDamage(1);
  self.pushable = 0;
  self pushplayer(1);
  self.skipdeath = 0;
  self.health = 10;
  self.favoriteenemy = getplayers()[0];
  self waittill(#"released");
  self thread function_e92085b3();
  self thread function_5b6b3eb1();
  self util::auto_delete(undefined, undefined, 1000);
}

function function_4c53321a() {
  self endon(#"death", #"informant_death");
  level endon(#"hash_3712ad2f725e964d", #"informant_enemies_stealth_spotted", #"informant_enemies_cleared");
  doors::waittill_door_opened("informant_door");
  wait 0.8;
  self dialogue::queue("vox_cp_stkt_07300_info_cough_67");
  wait 1.4;
  self dialogue::queue("vox_cp_stkt_07300_info_justletmego_21");
  wait 1;
  self dialogue::queue("vox_cp_stkt_07300_info_cough_67_1");
  self dialogue::queue("vox_cp_stkt_07300_info_please_88");
  wait 2;
  self dialogue::queue("vox_cp_stkt_07300_info_itoldyouimnotwh_e1");
}

function function_5b6b3eb1() {
  self endon(#"death");
  var_f6c40dcd = getent("informant_gv", "targetname");
  wait 8;
  player = getplayers()[0];

  if(player istouching(var_f6c40dcd)) {
    self dialogue::queue("vox_cp_stkt_07300_info_goaheadillbefin_36");
  }
}

function function_90382186() {
  self endon(#"death");
  level waittill(#"hash_53933f4c3658c33c");
  self.fixednode = 1;
  var_f6c40dcd = getent("informant_gv", "targetname");

  if(isDefined(var_f6c40dcd)) {
    self setgoal(var_f6c40dcd);
  }
}

function function_35612e24() {
  if(isDefined(objectives::function_285e460(#"hash_d3429885cbd2853"))) {
    objectives::complete(#"hash_d3429885cbd2853");
  }

  level flag::set("informant_released");
  level thread music::function_edda155f("9.0_informant_safehouse_stinger");
}

function function_1bad6781() {
  self endon(#"death", #"hash_4d9e21fd0dcc04a9");
  s_result = self waittill(#"damage");
  self dialogue::function_47b06180();
  level flag::set("informant_shot");
  self notify(#"informant_death");
  self ai::function_603b970a();
  self val::set("informant_death", "takedamage", 0);
  level scene::play("aib_vign_stakeout_alley2_informant", "death");

  iprintlnbold("<dev string:x38>");
}

function function_eb384519() {
  self endon(#"released");
  self waittill(#"damage", #"death");
  self dialogue::function_47b06180();
  self ai::function_603b970a();

  if(self scene::function_c935c42()) {
    self scene::stop();
  }
}

function function_e92085b3() {
  self endon(#"death");

  while(true) {
    s_result = self waittill(#"damage");
    self ai::function_603b970a();

    if(isPlayer(s_result.attacker)) {
      self dialogue::function_47b06180();
      self.var_2e3fa910 = 1;
      self.favoriteenemy = s_result.attacker;
      self val::reset_radiant("ignoreall");
      self val::reset_radiant("ignoreme");
      self.skipdeath = 0;
      return;
    }
  }
}

function function_761b250d() {
  player = getplayers()[0];
  s_result = self waittill(#"death", #"informant_death");
  self ai::function_603b970a();

  if(!level flag::get("informant_shot") && (isDefined(self.health) ? self.health : 0) > 0) {
    level flag::set("informant_deleted");
  }

  waitframe(1);

  if(level flag::get("informant_deleted")) {
    if(level flag::get("informant_released")) {
      player_decision::function_83bb4d9c(0);
      getplayers()[0] stats::function_dad108fa(#"hash_3d9eacd5207117df", 1);
      player_decision::function_8c0836dd(4);
    } else {
      level flag::set("informant_killed");
      player_decision::function_83bb4d9c(1);
      level flag::clear("informant_released");

      if(isDefined(objectives::function_285e460(#"hash_d3429885cbd2853"))) {
        objectives::remove(#"hash_d3429885cbd2853");
      }
    }

    return;
  }

  level flag::set("informant_killed");
  player_decision::function_83bb4d9c(1);
  getplayers()[0] stats::function_dad108fa(#"hash_40745959404663d3", 1);
  player_decision::function_8c0836dd(3);
  level flag::clear("informant_released");

  if(isDefined(objectives::function_285e460(#"hash_d3429885cbd2853"))) {
    objectives::complete(#"hash_d3429885cbd2853");
  }
}

function function_1b6d2916() {
  self endon(#"death");
  self thread function_9dd751e9();
  level flag::set("informant_choice_05_note_not_found");
  var_6e695d6d = # "hash_534ff4023162856c";
  var_314be333 = # "hash_534ff70231628a85";
  var_41dc8454 = # "hash_534ff602316288d2";
  var_3194e3c1 = # "hash_534ff10231628053";
  var_e66718e1 = # "hash_7356b7b9ea5fd343";
  var_43558742 = # "hash_534ff00231627ea0";
  var_f98ce627 = # "hash_656b6f2304158027";
  var_d1de180 = # "hash_11f0e4dd5bf7075b";
  var_87b83dca = dialog_tree::new_tree(&function_88724c2d, undefined, 1, 0, "aib_vign_stakeout_alley2_informant");
  var_87b83dca thread dialog_tree::function_a3a3ea7d(var_d1de180, "informant_enemies_cleared");
  var_dfc957f2 = var_87b83dca dialog_tree::add_option(var_6e695d6d, "vox_cp_stkt_07300_info_ivebeenmonitori_73", undefined, undefined, 0, undefined, undefined, &function_9a8402c8);
  var_87b83dca dialog_tree::function_da884b08(var_dfc957f2, "informant_dialog_choice_01_finished", var_314be333, undefined, undefined, undefined, 1, undefined, "forever", &function_ac42a645);
  var_87b83dca dialog_tree::function_da884b08(var_dfc957f2, "informant_dialog_choice_01_finished", var_41dc8454, "vox_cp_stkt_07300_info_pleasedontkillm_35", undefined, undefined, 1, undefined, "forever", &function_2c76269e);
  var_87b83dca dialog_tree::function_da884b08(var_dfc957f2, "informant_choice_04_note_found", var_3194e3c1, "vox_cp_stkt_07300_info_whatwhatdidthat_b0", undefined, undefined, 0, undefined, undefined, &function_1816fdec);
  var_87b83dca dialog_tree::function_da884b08(var_dfc957f2, "informant_dialog_choice_04_finished", var_e66718e1, "vox_cp_stkt_07300_info_idontevenknowwh_f7", undefined, undefined, 0, undefined, undefined, &function_fde9b9a6);
  var_87b83dca dialog_tree::function_da884b08(var_dfc957f2, "informant_choice_05_note_not_found", var_43558742, "vox_cp_stkt_07300_info_volkovhesawfuld_b5", undefined, undefined, 0, undefined, undefined, &function_e1d39166);
  var_87b83dca dialog_tree::add_option(var_f98ce627, undefined, undefined, undefined, 1, undefined, "forever", &function_52cc8d82);

  while(true) {
    if(!isalive(level.informant)) {
      return;
    }

    if(level flag::get_any(array("informant_released", "informant_killed", "informant_shot"))) {
      return;
    }

    self dialog_tree::function_cfa96cee(var_87b83dca, undefined, undefined, "informant_death", undefined, undefined, undefined, undefined, 1);
    wait 0.1;
  }
}

function function_9dd751e9() {
  level.player endon(#"death");
  self endon(#"death", #"informant_death", #"delete", #"released");
  level flag::wait_till_any(array("informant_enemies_stealth_spotted", "informant_enemies_cleared"));
  self ai::look_at(level.player, 0, undefined, 600);
  self dialogue::queue("vox_cp_stkt_07300_info_youiveseenyourp_59");
}

function function_88724c2d() {
  level.informant ai::function_603b970a();
  level scene::play("aib_vign_stakeout_alley2_informant_player", "enter");
  level thread scene::play("aib_vign_stakeout_alley2_informant_player", "loop");
}

function function_9a8402c8() {
  level flag::set("informant_dialog_choice_01_finished");
}

function function_e97a2940() {}

function function_ac42a645() {
  level.informant endon(#"death");
  level.informant notify(#"hash_4d9e21fd0dcc04a9");
  old_model = # "c_t9_cp_ger_civ_male_informant_body_tape";
  new_model = # "c_t9_cp_ger_civ_male_informant_body";
  level.informant detach(old_model);
  level.informant attach(new_model);
  level.informant util::delay(0.2, "death", &dialogue::queue, "vox_cp_stkt_07300_info_thankyouforsavi_ee");
  level.informant thread function_eb384519();
  level.informant thread function_67df588d();
}

function function_67df588d() {
  self endon(#"death");
  level thread scene::play("aib_vign_stakeout_alley2_informant_player", "exit");
  level scene::play("aib_vign_stakeout_alley2_informant", "release");
  self notify(#"released");
  level.informant ai::look_at(level.player, 0, undefined, 600);
}

function function_2c76269e() {
  level thread scene::play("aib_vign_stakeout_alley2_informant_player", "exit");
}

function function_1816fdec() {
  level flag::set("informant_dialog_choice_04_finished");
}

function function_fde9b9a6() {}

function function_e1d39166() {}

function function_52cc8d82() {
  level scene::play("aib_vign_stakeout_alley2_informant_player", "exit");
  level.informant ai::look_at(level.player, 0, undefined, 600);
}

function function_8262abe1(str_objective) {
  doors::unlock("alley_1_tutorial_door");
  doors::open("alley_1_tutorial_door");
}

function function_b4ae0031(str_objective, var_50cc0d4f) {
  player = getplayers()[0];

  if(var_50cc0d4f) {
    level thread function_c5a860f1(1);
    level thread namespace_11998b8f::function_81fce913();
    level function_3e93882(var_50cc0d4f);
  }

  level.var_351720cf = getent("alley_3_courtyard_door_blocker", "targetname");
  level.var_351720cf hide();
  level thread function_b76115bc();
  level thread namespace_11998b8f::function_d81925f5("vol_alley_3_body_drop", "alley_3_done");
  level thread function_750fe887();
  level thread function_fe7e195a();
  level thread scene::add_scene_func("scene_z_stk_lazar_meetup", &function_66196fef, "door_start_loop");
  level thread scene::play("scene_z_stk_lazar_meetup", "door_start_loop");
  level scene::play("scene_z_stk_lazar_meetup", "open_door");

  if(!level flag::get("flag_alley_3_lazar_close_door")) {
    level thread scene::play("scene_z_stk_lazar_meetup", "open_door_loop");
    level flag::wait_till("flag_alley_3_lazar_close_door");
  }

  if(!var_50cc0d4f) {
    if(!level flag::get("alley_2_stealth_was_broken")) {
      player stats::function_dad108fa(#"hash_36d0e0af1bd1b8c7", 1);
    }
  }

  level thread function_9f4c9a02();
  level thread function_26f625c();
  level notify(#"hash_14fdb20a5044c32e");
  level scene::play("scene_z_stk_lazar_meetup", "hall_walk");

  if(level flag::get("flag_alley_3_courtyard_door")) {
    thread namespace_5ceacc03::function_7e88a33b(1.4);
    level scene::play("scene_z_stk_lazar_meetup", "courtyard_branch");
  } else {
    level scene::play("scene_z_stk_lazar_meetup", "lazar_traversal");
    level thread scene::play("scene_z_stk_lazar_meetup", "courtyard_door_loop");
    level flag::wait_till("flag_alley_3_courtyard_door");
    thread namespace_5ceacc03::function_7e88a33b(0.7);
    level scene::play("scene_z_stk_lazar_meetup", "enter_courtyard");
  }

  savegame::checkpoint_save();
  level thread function_af6b3208();
  level thread function_e4fbeb15();
  player namespace_979752dc::set_disguised(1);
  level thread namespace_11998b8f::function_de88eefd();
  level thread namespace_fba81a7f::function_37acd633();
  level scene::play("scene_z_stk_lazar_meetup", "courtyard_walk");

  if(level flag::get("flag_go_in_store")) {
    thread namespace_5ceacc03::function_8a2f9a04();
    level scene::play("scene_z_stk_electronics_store", "rr_door_lazar_branch");
  } else {
    level scene::play("scene_z_stk_electronics_store", "rr_ext");
    level thread scene::play("scene_z_stk_electronics_store", "rr_wait_loop");
    level flag::wait_till("flag_go_in_store");
    thread namespace_5ceacc03::function_8a2f9a04();
    level scene::play("scene_z_stk_electronics_store", "repair_room_enter");
  }

  level flag::set("alley_3_done");
  level skipto::function_4e3ab877(str_objective);
}

function function_750fe887() {
  player = getplayers()[0];
  player endon(#"death");
  door_blocker = getent("alley_3_player_blocker", "targetname");
  door_blocker movez(-5000, 0.1);
  var_54d36352 = getent("alley_3_player_blocker_temp", "targetname");
  var_54d36352 movez(-5000, 0.1);
  level flag::wait_till("flag_alley_3_lazar_close_door");
  player util::function_749362d7(1);
  door_blocker movez(5000, 0.05);
  var_54d36352 movez(5000, 0.05);
  level flag::wait_till("remove_alley_3_door_blocker");

  if(isDefined(var_54d36352)) {
    var_54d36352 delete();
  }
}

function function_66196fef(a_ents) {
  level.var_3c0c4db = a_ents[#"hash_396147c0fe01eab9"];
  level.var_94a0e669 = a_ents[#"hash_396161c0fe0216e7"];
}

function function_b76115bc() {
  level flag::wait_till("flag_alley_3_lazar_close_door");
  districts::function_930f8c81(["streets", "tailor_and_alley"]);
  districts::function_a7d79fcb(["electronics", "apartment_street"]);
  level thread function_1c00ad1f();
  level flag::wait_till("flag_go_in_store");
  districts::function_a7d79fcb(["apartment"]);
}

function function_1c00ad1f() {
  level flag::wait_till("flag_close_alley_3_doors");

  while(true) {
    if(!level.player cansee(level.var_3c0c4db)) {
      level thread scene::play("scene_z_stk_lazar_meetup", "door_start_loop");
      level.var_351720cf show();
      districts::function_930f8c81(["alley"]);
      districts::function_a7d79fcb(["apartment"]);
      return;
    }

    waitframe(1);
  }
}

function function_26f625c() {
  scene::add_scene_func("scene_z_stk_electronics_store", &namespace_afd0968c::function_9df174aa, "init");
  level scene::init("scene_z_stk_electronics_store");
  level waittill(#"hash_51f4f52c3f966e9e");
  namespace_979752dc::function_740dbf99();
  wait 0.5;
  level thread namespace_fba81a7f::function_47620ece();
}

function function_e73c0be(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  if(player) {
    trigger::use("cleanup_alley_spawners", "targetname", undefined, 0);
  }
}

function function_3e93882(var_50cc0d4f) {
  if(!is_true(var_50cc0d4f)) {
    level flag::wait_till("alley_2_spawn_lazar");
  }

  util::function_268bdf4f("lazar", &namespace_11998b8f::function_2f0f0a84);
  level.lazar val::set("alley_3", "ignoreme", 1);
  level.lazar val::set("alley_3", "ignoreall", 1);
  level.lazar.holdfire = 1;
  level.lazar.goalradius = 32;
  level scene::init("scene_z_stk_lazar_meetup");
}

function function_fe7e195a() {
  level waittill(#"hash_2b937901ed36ac46");

  if(!level flag::get("alley_2_stealth_was_broken")) {
    level.lazar dialogue::queue("vox_cp_stkt_07300_lazr_niceworkbellfol_e2");
    return;
  }

  level.lazar dialogue::queue("vox_cp_stkt_07300_lazr_ifthatsyourlowp_1e");
  thread namespace_5ceacc03::function_6757a0b0();
}

function function_af6b3208() {
  level flag::wait_till("flag_alley_3_vista_car");
  level thread namespace_11998b8f::function_973a721b("alley_3_car_1");
}

function function_e4fbeb15() {
  level flag::wait_till("flag_go_in_store");
  level thread namespace_11998b8f::function_973a721b("alley_3_car");
}

function function_c5a860f1(skipto) {
  var_8a7843d = struct::get("get_to_safehouse_meetup_breadcrumb_02_org", "targetname");
  position = struct::get("get_to_safehouse_meetup_obj_org", "targetname");
  position2 = struct::get("get_to_safehouse_meetup_obj_org_2", "targetname");

  if(is_true(skipto)) {
    if(!isDefined(objectives::function_285e460(#"hash_3e6960719d61e4c7"))) {
      objectives::goto(#"hash_3e6960719d61e4c7", position.origin, #"hash_4c52ece55785d7cd", 1, 0);
      objectives::function_67f87f80(#"hash_3e6960719d61e4c7", undefined, #"hash_31d26c6e0c54bbbc");
    }
  } else {
    if(!isDefined(objectives::function_285e460(#"hash_3e6960719d61e4c7"))) {
      objectives::goto(#"hash_3e6960719d61e4c7", var_8a7843d.origin, #"hash_4c52ece55785d7cd", 1, 0);
      objectives::function_67f87f80(#"hash_3e6960719d61e4c7", undefined, #"hash_31d26c6e0c54bbbc");
    }

    level flag::wait_till("update_lazar_obj_position");
    objectives::update_position(#"hash_3e6960719d61e4c7", position.origin);
  }

  level flag::wait_till("alley_2_ping_lazar");
  player = getplayers()[0];
  player thread objectives_ui::show_objectives(1);
  doors::waittill_door_opened("alley_2_end_door");
  objectives::update_position(#"hash_3e6960719d61e4c7", position2.origin);
}

function function_da707a70(skipto) {
  if(!isDefined(objectives::function_285e460(#"hash_d3429885cbd2853"))) {
    objectives::goto(#"hash_d3429885cbd2853", undefined, #"hash_e6075ef87c0c55b", 1, 0);
    objectives::function_572778b9(#"hash_d3429885cbd2853");
  }

  if(!is_true(skipto)) {
    objectives::hide(#"hash_d3429885cbd2853");
  }

  level thread function_5e8eb7c1(skipto);
}

function function_dee5c2a0() {
  level flag::wait_till("flag_alley_ping_hint");
  player = getplayers()[0];
  player util::hide_hint_text();
  waitframe(1);

  if(!level flag::get_all(array("alley_2_stealth_was_broken", "flag_alley_2_investigate"))) {
    objectives_ui::function_49ebaad2();
  }
}

function function_deb70deb() {
  level flag::wait_till("flag_exit_informant_room_ping");
  player = getplayers()[0];
  player thread objectives_ui::show_objectives(1);
}

function function_9f4c9a02() {
  objectives::hide(#"hash_3e6960719d61e4c7");

  if(!isDefined(objectives::function_285e460(#"hash_11648e1e0d758de7", level.lazar))) {
    objectives::follow(#"hash_11648e1e0d758de7", level.lazar, undefined, 0, 0);
  }

  level flag::wait_till("alley_3_done");
  objectives::complete(#"hash_11648e1e0d758de7", level.lazar);
  objectives::complete(#"hash_3e6960719d61e4c7");
}