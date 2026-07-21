/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\load.gsc
***********************************************/

main() {
  var_0 = gettime();
  scripts\sp\load_code::delete_on_load();
  scripts\sp\load_code::init_level();
  scripts\sp\load_code::init_global_variables();
  scripts\sp\load_code::init_global_precache();
  scripts\sp\load_code::init_global_dvars();
  scripts\sp\load_code::init_global_omnvars();
  scripts\engine\utility::init_trigger_flags();
  scripts\sp\load_code::init_objective_colors();
  scripts\engine\utility::init_struct_class();
  scripts\sp\load_code::init_funcs();
  scripts\common\fx::initfx();
  scripts\common\exploder::setupexploders();
  anim_earlyinit();
  scripts\sp\utility::createweapondefaultsarray();
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
  scripts\sp\global_fx::main();
  scripts\sp\lights::init();
  scripts\sp\scriptable::scriptable_spglobalcallback();
  scripts\sp\names::setup_names();
  scripts\sp\audio::init_audio();
  scripts\sp\trigger::init_script_triggers();
  scripts\sp\hud::init();
  scripts\sp\vision::init_vision();
  scripts\game\sp\outline::hudoutline_channels_init();
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
  scripts\smartobjects\utility::validate();
  scripts\sp\equipment\offhands::init();
  scripts\sp\equipment\tripwire::init();
  scripts\common\rockable_vehicles::init();
  scripts\sp\utility::fixplacedweapons(["mp", "sp"]);
  scripts\game\sp\load::main();
  scripts\sp\load_code::load_binks();
  scripts\sp\load_code::post_load_functions();

  if(scripts\common\utility::iswegameplatform())
    spawncorpsehider();
}

spawncorpsehider() {
  var_0 = 0;
  var_1 = 1;
  var_2 = 2;
  var_3 = 3;
  var_4 = 4;
  var_5 = "sp/hideCorpseTable.csv";
  var_6 = tolower(getDvar("mapname"));
  var_7 = tablelookupgetnumrows(var_5);

  for(var_8 = 0; var_8 < var_7; var_8++) {
    if(var_6 == tolower(tablelookupbyrow(var_5, var_8, var_1))) {
      var_9 = tablelookupbyrow(var_5, var_8, var_2);
      var_10 = strtok(tablelookupbyrow(var_5, var_8, var_3), "_");
      var_11 = strtok(tablelookupbyrow(var_5, var_8, var_4), "_");
      var_12 = spawn("script_model", (float(var_10[0]), float(var_10[1]), float(var_10[2])));
      var_12 setModel(var_9);
      var_12.angles = (float(var_11[0]), float(var_11[1]), float(var_11[2]));
    }
  }
}

anim_earlyinit() {
  scripts\sp\flags::init_sp_flags();
  scripts\sp\slowmo_init::slowmo_system_init();
  scripts\sp\player::init();
  scripts\sp\gameskill::init_gameskill();
}