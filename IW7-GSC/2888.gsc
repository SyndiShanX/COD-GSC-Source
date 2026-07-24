/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2888.gsc
**************************************/

main() {
  _id_0A2F::_id_9789();
  scripts\sp\utility::_id_965C();
  _id_0B33::_id_95F3();
  _id_0B2F::_id_9752();
  scripts\sp\gameskill::_id_95F9();
  _id_0F18::_id_956A();
  scripts\sp\introscreen::_id_9631();
  scripts\sp\starts::_id_9766();

  if(scripts\sp\utility::_id_93A6()) {
    scripts\sp\specialist_MAYBE::init();
  }

  scripts\sp\load_code::_id_83DD();
  scripts\sp\load_code::_id_83DB();
  scripts\sp\load_code::_id_83D5();
  scripts\engine\utility::init_trigger_flags();
  scripts\engine\utility::struct_class_init();
  scripts\sp\colors::init_colors();
  _id_0B5F::_id_96D7();
  scripts\sp\mgturret::main();
  scripts\common\exploder::setupexploders();
  scripts\sp\pausemenu::main();
  _id_0B0A::main();
  scripts\sp\anim::init();
  scripts\common\fx::initfx();
  scripts\sp\createfx::createfx();
  scripts\sp\global_fx::main();
  _id_0B1D::init();
  scripts\sp\stinger::init();
  scripts\sp\lights::init();
  scripts\engine\utility::_id_D959();
  scripts\sp\names::_id_F9E6();
  _id_0B0B::init_audio();
  scripts\sp\trigger::_id_9726();
  setsaveddvar("ufoHitsTriggers", "0");
  scripts\sp\hud::init();
  scripts\sp\vision::_id_979C();
  scripts\sp\endmission::main();
  _id_0E2B::_id_C32F();
  _id_0E2D::_id_112B5();
  _id_0E26::_id_972B();
  _id_0E25::_id_95C4();
  scripts\sp\vehicle::_id_979A();
  _id_0B29::init();
  _id_0E21::_id_9527();
  _id_0E29::_id_8829();
  _id_0B2A::_id_66A1();
  scripts\sp\coverwall::_id_4761();
  precacheitem("frag_up1");
  precacheitem("frag_c6hug");
  _id_0E4B::_id_D5E3();
  scripts\sp\starts::_id_57C6();
  scripts\engine\utility::_id_C953();
  scripts\sp\autosave::main();
  anim._id_13086 = 0;
  scripts\sp\load_code::_id_F7C2();
  scripts\sp\introscreen::main();
  scripts\sp\damagefeedback::init();
  scripts\sp\friendlyfire::main();

  if(getdvarint("ai_iw7", 0) == 1) {
    scripts\asm\asm::asm_globalinit();
    scripts\aitypes\bt_util::init();
  }

  scripts\sp\fakeactor_node_MAYBE::_id_F97C();
  scripts\sp\load_code::_id_51C4();
  scripts\anim\traverse\shared::_id_F9C6();
  _id_0B04::_id_94F9();
  scripts\sp\intelligence::main();
  _id_0E44::_id_952C();
  _id_0B1F::_id_95B6();
  _id_0E20::_id_DE0F();
  _id_0E1F::_id_6137();
  _id_0E1C::_id_200A();
  _id_0E1E::_id_5374();
  _id_0B09::_id_952F();
  scripts\sp\utility::_id_9674();

  if(isDefined(level._id_83DF)) {
    [[level._id_83DF]]();
  }

  scripts\sp\load_code::_id_B3CD();
  _id_0B77::main();
  scripts\sp\utility::_id_48C1();
  _id_0B34::_id_95F7();
  scripts\sp\interaction_manager::_id_9A2F();
  thread scripts\sp\geo_mover::_id_409C();

  if(scripts\sp\utility::_id_93A6()) {
    if(scripts\sp\specialist_MAYBE::_id_2C8F()) {
      scripts\sp\specialist_MAYBE::_id_F2D2(1);
    } else {
      level._id_10964 thread scripts\sp\specialist_MAYBE::main();
    }
  }

  scripts\sp\load_code::_id_E810();
  setsettletime(scripts\sp\utility::_id_7F6E(level.script));
  var_0 = scripts\sp\utility::_id_7E2C(level.script);
  setomnvar("ui_client_settle_time", var_0);
  var_1 = scripts\sp\utility::_id_7F70(level.script);

  if(isDefined(var_1) && var_1 != "") {
    setomnvar("ui_transition_movie", var_1);
  } else {
    setomnvar("ui_transition_movie", "none");
  }

  scripts\sp\analytics::main();
}