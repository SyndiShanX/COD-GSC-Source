/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\load.gsc
***********************************************/

function main() {
  var0 = gettime();
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

  if(scripts\common\utility::iswegameplatform()) {
    spawncorpsehider();
    return;
  }
}

function spawncorpsehider() {
  var0 = 0;
  var1 = 1;
  var2 = 2;
  var3 = 3;
  var4 = 4;
  var5 = "sp/hideCorpseTable.csv";
  var6 = tolower(getDvar("mapname"));
  var7 = tablelookupgetnumrows(var5);

  for(var8 = 0; var8 < var7; var8++) {
    if(var6 == tolower(tablelookupbyrow(var5, var8, var1))) {
      var9 = tablelookupbyrow(var5, var8, var2);
      var10 = strtok(tablelookupbyrow(var5, var8, var3), "_");
      var11 = strtok(tablelookupbyrow(var5, var8, var4), "_");
      var12 = spawn("script_model", (float(var10[0]), float(var10[1]), float(var10[2])));
      var12 setModel(var9);
      var12.angles = (float(var11[0]), float(var11[1]), float(var11[2]));
    }
  }
}

function anim_earlyinit() {
  scripts\sp\flags::init_sp_flags();
  scripts\sp\slowmo_init::slowmo_system_init();
  scripts\sp\player::init();
  scripts\sp\gameskill::init_gameskill();
}