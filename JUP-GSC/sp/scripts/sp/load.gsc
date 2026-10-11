/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\load.gsc
***********************************************/

#using script_1096bc9315122e88;
#using script_3798db193e76a866;
#using script_56dcb79837d451ee;
#using script_5f8bc60756b1eafb;
#using script_70ab2c8920597578;
#using scripts\asm\asm;
#using scripts\code\ai;
#using scripts\common\devgui;
#using scripts\common\exploder;
#using scripts\common\fx;
#using scripts\common\notetrack;
#using scripts\common\rockable_vehicles;
#using scripts\common\shellshock_utility;
#using scripts\common\utility;
#using scripts\engine\easing;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\smartobjects\utility;
#using scripts\sp\analytics;
#using scripts\sp\anim;
#using scripts\sp\art;
#using scripts\sp\audio;
#using scripts\sp\autosave;
#using scripts\sp\colors;
#using scripts\sp\createfx;
#using scripts\sp\damagefeedback;
#using scripts\sp\destructibles\destructible_vehicle;
#using scripts\sp\destructibles\log_pile;
#using scripts\sp\destructibles\oil_barrel;
#using scripts\sp\destructibles\red_barrel;
#using scripts\sp\destructibles\water_barrel;
#using scripts\sp\dialogue;
#using scripts\sp\door;
#using scripts\sp\endmission;
#using scripts\sp\equipment\offhands;
#using scripts\sp\equipment\tripwire;
#using scripts\sp\fakeactor_node;
#using scripts\sp\flags;
#using scripts\sp\footsteps;
#using scripts\sp\friendlyfire;
#using scripts\sp\gameskill;
#using scripts\sp\geo_mover;
#using scripts\sp\heartbeat_sp;
#using scripts\sp\hud;
#using scripts\sp\intelligence;
#using scripts\sp\interaction_manager;
#using scripts\sp\introscreen;
#using scripts\sp\lights;
#using scripts\sp\load_code;
#using scripts\sp\loot;
#using scripts\sp\mgturret;
#using scripts\sp\names;
#using scripts\sp\nvg\nvg_ai;
#using scripts\sp\outline;
#using scripts\sp\pausemenu;
#using scripts\sp\player;
#using scripts\sp\player\bullet_feedback;
#using scripts\sp\player\context_melee;
#using scripts\sp\player_death;
#using scripts\sp\scriptable;
#using scripts\sp\slowmo_init;
#using scripts\sp\spawner;
#using scripts\sp\starts;
#using scripts\sp\stealth\social;
#using scripts\sp\swim_sp;
#using scripts\sp\trigger;
#using scripts\sp\utility;
#using scripts\sp\vehicle;
#using scripts\sp\vehicle_interact;
#using scripts\sp\vision;
#using scripts\stealth\callbacks;
#namespace load;

function main() {
  function_39528e3544b58a6c();
  level.teambased = 0;
  starttime = gettime();

  function_b265d5c7cc69cb92();

  level namespace_8b9b2769a8e84272::init();
  delete_on_load();
  init_level();
  init_global_variables();
  init_global_precache();
  init_global_dvars();
  init_global_omnvars();
  init_trigger_flags();
  init_objective_colors();
  init_struct_class();
  init_funcs();
  scripts\common\fx::initfx();
  scripts\common\exploder::setupexploders();
  anim_earlyinit();

  if(getdvarint(@ "hash_742caa13b3c2e685", 0)) {
    return;
  }

  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0)) {
    return;
  }

  namespace_d4b0db6f425eeb40::function_684874396c3776b3();
  scripts\common\devgui::init_devgui();

  scripts\code\ai::function_87dc2db63d1cfe13();
  scripts\engine\easing::ease_init();
  scripts\sp\player::main();
  scripts\sp\introscreen::init_introscreen();
  scripts\sp\colors::init_colors();
  scripts\sp\footsteps::default_footsteps();
  scripts\sp\player_death::init_player_death();
  scripts\sp\mgturret::main();
  scripts\sp\pausemenu::main();
  scripts\sp\art::main();
  scripts\sp\anim::init();
  scripts\sp\createfx::createfx();
  scripts\sp\lights::init();
  scripts\sp\scriptable::scriptable_spglobalcallback();
  scripts\sp\names::setup_names();
  scripts\sp\audio::init_audio();
  scripts\sp\trigger::init_script_triggers();
  scripts\sp\hud::init();
  scripts\sp\vision::init_vision();
  scripts\sp\outline::hudoutline_channels_init();
  scripts\sp\vehicle::init_vehicles();
  scripts\sp\starts::do_starts();
  scripts\sp\endmission::main();
  scripts\sp\autosave::main();
  scripts\sp\introscreen::main();
  scripts\sp\damagefeedback::init();
  scripts\sp\friendlyfire::main();
  scripts\sp\fakeactor_node::setup_fakeactor_nodes();
  scripts\sp\intelligence::main();
  scripts\sp\destructibles\red_barrel::red_barrel_init();
  scripts\sp\destructibles\water_barrel::water_barrel_init();
  scripts\sp\destructibles\oil_barrel::oil_barrel_init();
  scripts\sp\destructibles\log_pile::log_pile_init();
  scripts\sp\destructibles\destructible_vehicle::destructible_vehicle_init();
  scripts\engine\sp\utility::init_manipulate_ent();
  scripts\sp\spawner::main();
  scripts\engine\sp\utility::create_corpses();
  scripts\sp\interaction_manager::interaction_manager_init();
  scripts\sp\door::init();
  scripts\sp\loot::init();
  scripts\sp\nvg\nvg_ai::nvg_ai_init();
  scripts\sp\analytics::main();
  scripts\sp\vehicle_interact::init_vehicle_interact();
  scripts\sp\geo_mover::init_mover_candidates();
  scripts\sp\player\bullet_feedback::bullet_feedback_init();
  scripts\stealth\callbacks::init_callbacks();
  scripts\sp\stealth\social::init();
  scripts\smartobjects\utility::validate();
  scripts\sp\equipment\offhands::init();
  scripts\sp\equipment\tripwire::init();
  scripts\common\rockable_vehicles::init();
  scripts\common\notetrack::function_11f8c6d6f5ba948();
  utility::fixplacedweapons();
  namespace_2032e3f42315b9b2::init();

  thread scripts\sp\autosave::function_4574815d2a5a1376();

  scripts\sp\dialogue::init();
  setdvarifuninitialized(@ "hash_fa7c16b886c722ed", 1);

  if(getdvarint(@ "hash_fa7c16b886c722ed", 0)) {
    namespace_8938ef39370f4a55::init();
  } else {
    scripts\sp\player\context_melee::main();
  }

  setsaveddvar(@ "mount_enable", default_to(level.gamemodebundle.mountenable, 1));
  anim.stowsidearmpositiondefault = undefined;
  scripts\common\shellshock_utility::init();
  namespace_6d3783f7267c4bca::init();
  load_binks();
  post_load_functions();
  thread post_cl_pregame();

  function_165238c37df21055();

  assertex(gettime() == starttime, "<dev string:x1c>");
  utility::spawncorpsehider();
}

function function_39528e3544b58a6c() {
  level.projectbundle = getprojectscriptbundle();
  level.gamemodebundle = getgamemodescriptbundle();
  level.gametypebundle = getgametypescriptbundle();
  level.mapbundle = getmapscriptbundle();
}

function anim_earlyinit() {
  function_39528e3544b58a6c();
  scripts\sp\load_code::init_values();
  scripts\sp\flags::init_sp_flags();
  scripts\sp\slowmo_init::slowmo_system_init();
  scripts\sp\swim_sp::main();
  scripts\sp\heartbeat_sp::main();
  scripts\sp\player::init();
  scripts\sp\gameskill::init_gameskill();

  if(!isDefined(level.framedurationseconds)) {
    level.framedurationseconds = level.frameduration / 1000;
  }
}