/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_ger_hub_post_cuba.gsc
***********************************************/

#using script_19971192452f4209;
#using script_4052585f7ae90f3a;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\cp_common\hint_tutorial;
#using scripts\cp_common\load;
#using scripts\cp_common\player_decision;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#namespace hub_post_cuba;

function starting(var_d3440450) {}

function main(var_d3440450, var_50cc0d4f) {
  level thread namespace_31c67f6d::function_f2cd5fc0();

  if(level.var_b28c2c3a == "dev_post_cuba_park_survived") {
    level.player player_decision::function_ff7e19cb(0);
  }

  if(level.var_b28c2c3a == "dev_post_cuba_lazar_survived") {
    level.player player_decision::function_ff7e19cb(1);
  }

  if(level.var_b28c2c3a == "dev_post_cuba_no_survivors") {
    level.player player_decision::function_ff7e19cb(2);
  }

  level namespace_31c67f6d::function_6194f34a("post_cuba", 1);
  level namespace_31c67f6d::init_notetracks_postcuba();
  level thread function_ff7cb1bd();
  level thread namespace_4ed3ce47::function_7edafa59(var_50cc0d4f + "_briefing");
  setlightingstate(3);
  level thread namespace_31c67f6d::function_29279de1("post_cuba");
  level thread namespace_31c67f6d::function_b0558ba2("7");
  level.player thread clientfield::set_to_player("set_hub_fov", 7);
  level function_107195fb();

  if(isDefined(var_50cc0d4f)) {
    skipto::function_4e3ab877(var_50cc0d4f);
  }

  skipto::function_1c2dfc20("cp_nam_prisoner");
}

function function_26282537() {
  level waittill(#"ambient_ext_override");
  level thread namespace_4ed3ce47::ambient_ext_override();
}

function function_eeb6e2e1() {
  level waittill(#"hash_6e37b7c047667b8e");
  level thread namespace_4ed3ce47::ambient_int_override();
}

function function_d2e1f6b8() {
  level waittill(#"ambient_override_return_to_normal");
  level thread namespace_4ed3ce47::ambient_override_return_to_normal();
}

function function_107195fb() {
  var_ea95c1e7 = namespace_31c67f6d::function_c9dc0e79();
  thread function_26282537();
  thread function_eeb6e2e1();
  thread function_d2e1f6b8();

  switch (var_ea95c1e7) {
    case # "park":
      function_276264f4("scene_hub_post_cuba_briefing_park_survived");
      break;
    case # "lazar":
      function_276264f4("scene_hub_post_cuba_briefing_lazar_survived");
      break;
    case # "sims":
      function_276264f4("scene_hub_post_cuba_briefing_no_survivor");
      break;
  }
}

function function_276264f4(str_scene) {
  level scene::init(str_scene);
  level flag::wait_till("level_is_go");

  while(!isDefined(level.player_connected) || isDefined(level.player_connected) && level.player_connected != 1) {
    waitframe(1);
  }

  level thread namespace_4ed3ce47::allies_init();
  wait 3;

  if(isDefined(level.var_d7d201ba) && isDefined(level.var_28c22d88)) {
    level.player flag::set(level.var_d7d201ba);
  }

  level flag::wait_till(#"gameplay_started");
  level thread namespace_31c67f6d::function_82743d25(isDefined(level.var_f5552371) ? level.var_f5552371 : "", 1);
  level thread scene::play(str_scene);
  level waittill(#"hash_475b36446c5bf12");
  level thread namespace_31c67f6d::pstfx_teleport(10, 1, 1, undefined, 5);
  wait 5;
}

function function_f50bc4b9() {
  level flag::init("flag_post_cuba_complete");
}

function function_ff7cb1bd() {
  level thread namespace_4ed3ce47::function_9ac95ec9();
  level thread namespace_4ed3ce47::function_d6c61f8();
  level thread namespace_4ed3ce47::function_b7c50de7();
}