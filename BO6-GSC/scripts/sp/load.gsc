/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\load.gsc
**************************************/

#using script_1096bc9315122e88;
#using script_70ab2c8920597578;
#using scripts\code\ai;
#using scripts\common\devgui;
#using scripts\common\exploder;
#using scripts\common\fx;
#using scripts\common\notetrack;
#using scripts\common\rockable_vehicles;
#using scripts\common\shellshock_utility;
#using scripts\common\targetmarkergroups;
#using scripts\common\utility;
#using scripts\common\whizby;
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
#using scripts\sp\fakeactor_node;
#using scripts\sp\flags;
#using scripts\sp\footsteps;
#using scripts\sp\friendlyfire;
#using scripts\sp\gameskill;
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
#using scripts\sp\player_death;
#using scripts\sp\scriptable;
#using scripts\sp\slowmo_init;
#using scripts\sp\spawner;
#using scripts\sp\starts;
#using scripts\sp\stealth\social;
#using scripts\sp\swim_sp;
#using scripts\sp\trigger;
#using scripts\sp\vehicle;
#using scripts\sp\vehicle_interact;
#using scripts\sp\vision;
#using scripts\stealth\callbacks;
#namespace load;

function main() {
  level.teambased = 0;
  starttime = gettime();

  load_code::function_6bc77ce6df91d9e7();

  level namespace_b45fb163fb1def48::init();
  load_code::delete_on_load();
  load_code::init_level();
  load_code::init_global_variables();
  load_code::init_global_precache();
  load_code::init_global_dvars();
  load_code::init_global_omnvars();
  utility::init_trigger_flags();
  load_code::init_objective_colors();
  utility::init_struct_class();
  load_code::init_funcs();
  fx::initfx();
  exploder::setupexploders();
  anim_earlyinit();

  if(getdvarint(@ "hash_742caa13b3c2e685", 0)) {
    return;
  }

  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0)) {
    return;
  }

  devgui::init_devgui();

  ai::function_7bf47ca2cb7d8b2a();
  easing::ease_init();
  player_sp::main();
  introscreen::init_introscreen();
  colors::init_colors();
  footsteps::default_footsteps();
  player_death::init_player_death();
  mgturret::main();
  pausemenu::main();
  art::main();
  anim_sp::init();
  createfx::createfx();
  lights::init();
  scriptable::scriptable_spglobalcallback();
  names::setup_names();
  audio::init_audio();
  trigger::init_script_triggers();
  hud::init();
  vision::init_vision();
  outline::hudoutline_channels_init();
  vehicle::init_vehicles();
  starts::do_starts();
  endmission::main();
  autosave::main();
  introscreen::main();
  damagefeedback::init();
  friendlyfire::main();
  fakeactor_node::setup_fakeactor_nodes();
  intelligence::main();
  red_barrel::red_barrel_init();
  water_barrel::water_barrel_init();
  oil_barrel::oil_barrel_init();
  log_pile::function_4d6af4877a912d0c();
  destructible_vehicle::destructible_vehicle_init();
  utility_sp::init_manipulate_ent();
  spawner::main();
  utility_sp::create_corpses();
  interaction_manager::interaction_manager_init();
  door_sp::init();
  loot::init();
  nvg_ai::nvg_ai_init();
  analytics::main();
  vehicle_interact::init_vehicle_interact();
  whizby::init();
  callbacks::init_callbacks();
  social::init();
  utility::validate();
  offhands::init();
  rockable_vehicles::init();
  notetrack::function_a3ed3823d2dc0925();
  utility::fixplacedweapons();
  targetmarkergroups::init();

  thread autosave::function_49fdd89300af9173();

  dialogue::init();
  setsaveddvar(@ "mount_enable", level.gamemodebundle.mountenable ?? 1);
  setsaveddvar(@ "hash_6c4f77cd2fcb7585", level.gamemodebundle.var_a4cf26462a90c093 ?? 0);

  if(isDefined(level.gamemodebundle) && istrue(level.gamemodebundle.var_754e9fa0c472dfff)) {
    setsaveddvar(@ "hash_ced27e4a42ca91a1", 0);
  }

  anim.stowsidearmpositiondefault = undefined;
  shellshock_utility::init();
  namespace_2bea2dead016342c::init();
  load_code::post_load_functions();
  thread load_code::post_cl_pregame();

  load_code::function_bb2be304a375da74();

  assert(gettime() == starttime, "<dev string:x24>");
  utility::spawncorpsehider();
}

function anim_earlyinit() {
  load_code::init_values();
  flags::init_sp_flags();
  slowmo_init::slowmo_system_init();
  swim_sp::main();
  heartbeat_sp::main();
  player_sp::init();
  gameskill::init_gameskill();

  if(!isDefined(level.framedurationseconds)) {
    level.framedurationseconds = level.frameduration / 1000;
  }
}