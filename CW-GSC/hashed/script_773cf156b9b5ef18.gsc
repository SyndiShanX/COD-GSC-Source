/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_773cf156b9b5ef18.gsc
***********************************************/

#using script_4d0e7ced9714e7d4;
#using script_63ae018f589c2e64;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\cp_common\ending;
#using scripts\cp_common\skipto;
#namespace safehouse_burns;

function starting(str_objective) {}

function main(str_objective, b_skipto) {
  level thread lui::screen_fade_out(0, "black", undefined, 1);
  level scene::init("scene_hub_safehouse_burns");
  level namespace_ac5221d7::function_7c927add(#"hash_2b307838febf78c8");
  level thread lui::screen_fade_in(0.5);
  level function_1f4ed1b4("dev_burn_safehouse");
  level thread function_49369331();
  level thread function_b0558ba2("1");

  while(!isDefined(level.player_connected) || isDefined(level.player_connected) && level.player_connected != 1) {
    waitframe(1);
  }

  if(isDefined(level.var_d7d201ba) && isDefined(level.var_28c22d88)) {
    level.player flag::set(level.var_d7d201ba);
  }

  setDvar(#"hash_4d452c56afa2dc6", 0.4);
  setDvar(#"hash_182aeeccdf113c9f", 3);
  setlightingstate(1);
  animation::add_notetrack_func("hub_post_prisoner::burn_pstfx", &function_95b1e0d9);
  thread function_374843a();
  thread function_62a6be7();
  scene::play("scene_hub_safehouse_burns");
  level ending::function_103cd64c();
  skipto::function_4e3ab877(b_skipto);
  skipto::function_f02f0c63();
  skipto::function_1c2dfc20();
}

function cleanup(name, starting, direct, player) {}

function function_49369331() {
  level thread namespace_e1ccb37b::function_7f23d560();
  level thread namespace_e1ccb37b::function_ef8c9b18();
}

function function_95b1e0d9(player) {
  level.player clientfield::set_to_player("clf_pstfx_burn_safehouse", 1);
}

function function_374843a() {
  level waittill(#"hash_32de83776213afe5");
  namespace_e1ccb37b::function_89070bfe();
}

function function_62a6be7() {
  level waittill(#"hash_50e95b22fb132786");
  namespace_e1ccb37b::function_8d5b23ae();
}

function function_1f4ed1b4(var_8ced85ea) {
  level thread scene::play("scene_hub_env_fan_box");
  level thread scene::play("scene_hub_env_desk_fan");
  a_mdls = [];

  switch (var_8ced85ea) {
    case # "post_takedown":
      a_mdls = level function_23128418(a_mdls);
      mdl = getent("hub_mdl_maptable_briefcase_01", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_maptable_mug_01", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_maptable_mug_02", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_maptable_ashtray_01", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_maptable_lighter_01", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_maptable_folder_01", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_maptable_tape_01", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_maptable_papers_01", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_maptable_papers_02", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_maptable_recorder_01", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_maptable_case_01", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_maptable_passport_01", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_maptable_passport_02", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_maptable_amp_01", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_maptable_snack_01", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_computer_tarp_01", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("mdl_hub_dark_room_photo_line_post_td_01", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_lamp_off_post_am", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_lamp_on_post_td", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_projector_away", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_projector_away_cart", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_projector_away_clip", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_office_light_on_1", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_office_light_on_2", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_hallway_light_on_1", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_hallway_light_on_2", "script_noteworthy");
      array::add(a_mdls, mdl);
      break;
    case # "post_armada":
      a_mdls = level function_23128418(a_mdls);
      mdl = getent("hub_mdl_puddle_01", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_puddle_02", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_puddle_03", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_puddle_04", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_bucket_01", "script_noteworthy");
      array::add(a_mdls, mdl);
      var_23917641 = getEntArray("post_armada_desk_set", "script_noteworthy");
      a_mdls = arraycombine(a_mdls, var_23917641);
      mdl = getent("mdl_hub_dark_room_photo_line_post_td_01", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_lamp_on_post_am", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_lamp_off_post_td", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_projector_away", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_projector_away_cart", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_projector_away_clip", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_office_light_on_1", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_office_light_off_2", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_hallway_light_on_1", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_hallway_light_on_2", "script_noteworthy");
      array::add(a_mdls, mdl);
      break;
    case # "post_yamantau":
      a_mdls = level function_31d12195(a_mdls);
      post_yamantau_only_models = getEntArray("post_yamantau_only_models", "script_noteworthy");
      a_mdls = arraycombine(a_mdls, post_yamantau_only_models);
      post_yamantau_desk_set = getEntArray("post_yamantau_desk_set", "script_noteworthy");
      a_mdls = arraycombine(a_mdls, post_yamantau_desk_set);
      post_yamantau_work_cart_mdl = getEntArray("post_yamantau_work_cart_mdl", "script_noteworthy");
      a_mdls = arraycombine(a_mdls, post_yamantau_work_cart_mdl);
      mdl = getent("hub_mdl_car_01_clip", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("mdl_hub_dark_room_photo_line_post_stk_01", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("mdl_hub_dark_room_photo_line_post_at_01", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_lamp_off_post_am", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_lamp_off_post_td", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_projector_away", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_projector_away_cart", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_projector_away_clip", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_office_light_off_1", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_office_light_off_2", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_hallway_light_off_1", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_hallway_light_off_2", "script_noteworthy");
      array::add(a_mdls, mdl);
      break;
    case # "post_kgb":
      a_mdls = level function_31d12195(a_mdls);
      hub_mdl_van_01_clip = getEntArray("hub_mdl_van_01_clip", "script_noteworthy");
      a_mdls = arraycombine(a_mdls, hub_mdl_van_01_clip);
      mdl = getent("mdl_hub_dark_room_photo_line_post_stk_01", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("mdl_hub_dark_room_photo_line_post_at_01", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_lamp_off_post_am", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_lamp_off_post_td", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_projector_in_use", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_projector_in_use_cart", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_projector_in_use_clip", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_office_light_off_1", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_office_light_off_2", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_hallway_light_on_1", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_hallway_light_on_2", "script_noteworthy");
      array::add(a_mdls, mdl);
      break;
    case # "post_cuba":
      a_mdls = level function_31d12195(a_mdls);
      mdl = getent("mdl_hub_dark_room_photo_line_post_stk_01", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("mdl_hub_dark_room_photo_line_post_at_01", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_lamp_off_post_am", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_lamp_off_post_td", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_projector_away", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_projector_away_cart", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_projector_away_clip", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_office_light_on_1", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_office_light_on_2", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_hallway_light_on_1", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_hallway_light_on_2", "script_noteworthy");
      array::add(a_mdls, mdl);
      break;
    case # "post_prisoner":
      a_mdls = level function_31d12195(a_mdls);
      mdl = getent("mdl_hub_dark_room_photo_line_post_stk_01", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("mdl_hub_dark_room_photo_line_post_at_01", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_lamp_off_post_am", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_lamp_off_post_td", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_projector_away", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_projector_away_cart", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_projector_away_clip", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_office_light_off_1", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_office_light_off_2", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_hallway_light_on_1", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_hallway_light_on_2", "script_noteworthy");
      array::add(a_mdls, mdl);
      break;
    case # "dev_burn_safehouse":
      a_mdls = level function_31d12195(a_mdls);
      mdl = getent("mdl_hub_dark_room_photo_line_post_stk_01", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("mdl_hub_dark_room_photo_line_post_at_01", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_lamp_off_post_am", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_lamp_off_post_td", "script_noteworthy");
      array::add(a_mdls, mdl);
      burn_models = getEntArray("burn_models", "script_noteworthy");
      a_mdls = arraycombine(a_mdls, burn_models);
      clientfield::set("dmg_models_and_vol_decals_burning", 1);
      mdl = getent("hub_mdl_projector_away", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_projector_away_cart", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_projector_away_clip", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_office_light_off_1", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_office_light_off_2", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_hallway_light_on_1", "script_noteworthy");
      array::add(a_mdls, mdl);
      mdl = getent("hub_mdl_hallway_light_on_2", "script_noteworthy");
      array::add(a_mdls, mdl);
      break;
  }

  foreach(mdl in a_mdls) {
    mdl show();
  }
}

function function_b0558ba2(var_690057e6) {
  var_c8d10663 = getent("model_clock1", "targetname");
  var_fa9a69f5 = getent("model_clock2", "targetname");
  var_581b24f5 = getent("model_clock3", "targetname");
  var_c8d10663 useanimtree("generic");
  var_fa9a69f5 useanimtree("generic");
  var_581b24f5 useanimtree("generic");
  var_c8d10663 thread function_42655283("t9_hub_env_clock_sh" + var_690057e6 + "_germany", randomfloatrange(0.05, 0.15));
  var_fa9a69f5 thread function_42655283("t9_hub_env_clock_sh" + var_690057e6 + "_moscow", randomfloatrange(0.55, 0.75));
  var_581b24f5 thread function_42655283("t9_hub_env_clock_sh" + var_690057e6 + "_wash_dc", randomfloatrange(0.25, 0.45));
  var_2eb7eec2 = getEntArray("model_clock_amb", "targetname");

  foreach(var_d96c2e88 in var_2eb7eec2) {
    var_d96c2e88 useanimtree("generic");
    var_d96c2e88 thread function_42655283("t9_hub_env_clock_sh" + var_690057e6 + "_germany", randomfloatrange(0.05, 0.25));
  }
}

function function_42655283(var_85d8359e, n_start_time) {
  self animation::play(var_85d8359e, undefined, undefined, undefined, undefined, undefined, undefined, n_start_time);
}

function function_23128418(a_mdls) {
  mdl = getent("hub_mdl_tarp_01", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_tarp_02", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_sheet_01", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_boxing_worklight", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_computer_01", "script_noteworthy");
  level.var_b8e8fb10 = mdl;
  array::add(a_mdls, mdl);
  mdl = getent("hub_tv1", "script_noteworthy");
  array::add(a_mdls, mdl);
  return a_mdls;
}

function function_31d12195(a_mdls) {
  mdl = getent("hub_mdl_lounge_chair", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_lounge_chair_clip", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_evidence_box_01", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_evidence_box_02", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_evidence_box_03", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_liquor_01", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_station_chair_01", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_station_chair_02", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_computer_01", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_floodlight_01", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_floodlight_02", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_paper_bag_01", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_rifle_01", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_pistol_01", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_pistol_02", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_food_container_01", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_food_container_02", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_crushed_can_01", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_trash_01", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_trash_02", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_trash_03", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_backroom_cart_01", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_backroom_tapes_01", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_backroom_tape_01", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_backroom_tv_01", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_backroom_papers_01", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_backroom_vcr_01", "script_noteworthy");
  array::add(a_mdls, mdl);
  mdl = getent("hub_mdl_backroom_supplies_01", "script_noteworthy");
  array::add(a_mdls, mdl);
  return a_mdls;
}