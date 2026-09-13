/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\aitypes.gsc
***********************************************/

_id_E364DBB1AD0A775B() {
  level.aitypes = [];
  level.random_aitype_list = ["ar", "smg", "shotgun"];
  scripts\cp\cp_spawning_util::create_agent_definition("actor_converted_vehicle_ai");
  _id_EF31E81F7AFFC71F = ["dx_cps_kama_callout_armored_spawning_10", "dx_cps_kama_callout_armored_spawning_20"];
  _id_26F957675F7A5578 = ["dx_cps_kama_callout_drone_thrower_spawning_10", "dx_cps_kama_callout_drone_thrower_spawning_20"];
  _id_8B8A36825962A05C = ["dx_cps_kama_callout_enemy_squad_spawning_10", "dx_cps_kama_callout_enemy_squad_spawning_20", "dx_cps_kama_callout_enemy_squad_spawning_30", "dx_cps_lass_callout_enemy_squad_spawning_10", "dx_cps_lass_callout_enemy_squad_spawning_20", "dx_cps_lass_callout_enemy_squad_spawning_30"];
  _id_EEDEAE274DD6AC1E = ["dx_cps_kama_callout_juggernaut_spawning_10", "dx_cps_kama_callout_juggernaut_spawning_20", "dx_cps_lass_callout_juggernaut_spawning_10", "dx_cps_lass_callout_juggernaut_spawning_10"];
  _id_7C2CCECDD941DEEE = ["dx_cps_kama_callout_sniper_spawning_10", "dx_cps_kama_callout_sniper_spawning_20", "dx_cps_kama_callout_sniper_spawning_30", "dx_cps_lass_callout_sniper_spawning_10", "dx_cps_lass_callout_sniper_spawning_20", "dx_cps_lass_callout_sniper_spawning_30"];
  _id_B2171B9BDA5C00DC = ["dx_cps_kama_callout_suicide_bomber_spawning_10", "dx_cps_kama_callout_suicide_bomber_spawning_20", "dx_cps_lass_callout_suicide_bomber_spawning_10", "dx_cbc_aq1_reaction_hostile_burst", "dx_cbc_aq2_reaction_hostile_burst", "dx_cbc_aq3_reaction_hostile_burst", "dx_cbc_aq4_reaction_hostile_burst", "dx_cps_lass_callout_suicide_bomber_spawning_20"];
  level._id_F8126E87C176D7F9 = 1;
  register_aitype_setup("soldier_lw", "actor_enemy_lw_base");
  register_aitype_setup("vehicle_ai", "actor_converted_vehicle_ai");
  register_aitype_setup("juggernaut", "enemy_cp_jugg_aq", undefined, ::set_juggernaut_flags, undefined, _id_EEDEAE274DD6AC1E);
  _id_C8F8A1D96F1DBEEE("enemy_cp_jugg_aq", 100);
  register_aitype_setup("smg", "enemy_cp_smg_tier1_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_smg_tier1_aq", 10);
  register_aitype_setup("smg_heavy", "enemy_cp_smg_tier2_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_smg_tier2_aq", 20);
  register_aitype_setup("smg", "enemy_cp_smg_tier1_nvg_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_smg_tier1_nvg_aq", 10);
  register_aitype_setup("smg_heavy", "enemy_cp_smg_tier2_nvg_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_smg_tier2_nvg_aq", 20);
  register_aitype_setup("ar", "enemy_cp_ar_tier1_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_ar_tier1_aq", 10);
  register_aitype_setup("ar_heavy", "enemy_cp_ar_tier2_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_ar_tier2_aq", 20);
  register_aitype_setup("ar_heavy_laser", "enemy_cp_ar_tier3_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_ar_tier3_aq", 30);
  register_aitype_setup("ar", "enemy_cp_ar_tier1_nvg_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_ar_tier1_nvg_aq", 10);
  register_aitype_setup("ar_heavy", "enemy_cp_ar_tier2_nvg_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_ar_tier2_nvg_aq", 20);
  register_aitype_setup("ar_heavy_laser", "enemy_cp_ar_tier3_nvg_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_ar_tier3_nvg_aq", 30);
  register_aitype_setup("shotgun", "enemy_cp_shotgun_tier1_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_shotgun_tier1_aq", 10);
  register_aitype_setup("shotgun_heavy", "enemy_cp_shotgun_tier2_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_shotgun_tier2_aq", 20);
  register_aitype_setup("suicidebomber", "enemy_cp_bomber", ::suicide_bomber_combat_func, ::cp_suicidebomber_init);
  register_aitype_setup("suicidebomber_heavy", "enemy_cp_bomber", ::suicide_bomber_combat_func, ::cp_suicidebomber_init);
  _id_C8F8A1D96F1DBEEE("actor_enemy_cp_alq_desert_bomber", 20);
  register_aitype_setup("rpg", "enemy_cp_rpg_tier1_aq", undefined, ::_id_9C044AFB98BA23F6, undefined, undefined);
  _id_C8F8A1D96F1DBEEE("enemy_cp_rpg_tier1_aq", 20);
  register_aitype_setup("rpg_heavy", "enemy_cp_rpg_tier2_aq", undefined, ::_id_9C044AFB98BA23F6, undefined, undefined);
  _id_C8F8A1D96F1DBEEE("enemy_cp_rpg_tier2_aq", 30);
  register_aitype_setup("riotshield", "enemy_cp_riotshield_tier1_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_riotshield_tier1_aq", 20);
  register_aitype_setup("riotshield_heavy", "enemy_cp_riotshield_tier2_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_riotshield_tier2_aq", 30);
  register_aitype_setup("sniper", "enemy_cp_sniper_tier1_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_sniper_tier1_aq", 10);
  register_aitype_setup("sniper_heavy", "enemy_cp_sniper_tier2_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_sniper_tier2_aq", 20);
  register_aitype_setup("sniper_laser", "enemy_cp_sniper_tier3_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_sniper_tier3_aq", 30);
  register_aitype_setup("lmg", "enemy_cp_lmg_tier1_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_lmg_tier1_aq", 10);
  register_aitype_setup("lmg_heavy", "enemy_cp_lmg_tier2_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_lmg_tier2_aq", 20);
  register_aitype_setup("lmg_heavy", "enemy_cp_lmg_tier3_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_lmg_tier3_aq", 30);
  register_aitype_setup("lmg_heavy", "enemy_cp_lmg_tier3_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_lmg_tier3_aq", 30);
  register_aitype_setup("hvt", "actor_enemy_cp_alq_desert_ar_hvt");
  register_aitype_setup("ally_ar", "actor_ally_cp_usmc_ar");
  register_aitype_setup("ar_gasmask", "enemy_cp_ar_tier2_aq");
  register_aitype_setup("lmg_gasmask", "enemy_cp_lmg_tier2_aq");
  register_aitype_setup("rpg_gasmask", "enemy_cp_rpg_tier2_aq");
  register_aitype_setup("shotgun_gasmask", "enemy_cp_shotgun_tier2_aq");
  register_aitype_setup("smg_gasmask", "enemy_cp_smg_tier2_aq");
  register_aitype_setup("sniper_gasmask", "enemy_cp_sniper_tier2_aq");
  register_aitype_setup("ar_laser", "enemy_cp_ar_tier2_aq");
  register_aitype_setup("lmg_laser", "enemy_cp_lmg_tier2_aq");
  register_aitype_setup("rpg_laser", "enemy_cp_rpg_tier2_aq");
  register_aitype_setup("shotgun_laser", "enemy_cp_shotgun_tier2_aq");
  register_aitype_setup("smg_laser", "enemy_cp_smg_tier2_aq");
  register_aitype_setup("sniper_laser", "enemy_cp_sniper_tier2_aq");
  register_aitype_setup("dog", "actor_enemy_cp_dog", undefined, ::_id_EC97EB7CF543044B, undefined, undefined);
  level._id_F8126E87C176D7F9 = undefined;
  _id_4B2F406429F657E3();
  _id_2585B1944B7884C0();
}

_id_4B2F406429F657E3() {
  register_aitype_setup("cartel_shotgun", "iw9_enemy_cp_cartel_shotgun");
  register_aitype_setup("cartel_civ_shotgun", "iw9_enemy_cp_cartel_civ_shotgun");
  register_aitype_setup("cartel_pistol", "iw9_enemy_cp_cartel_pistol");
  register_aitype_setup("ar_t1_aq", "enemy_cp_ar_tier1_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_ar_tier1_aq", 10);
  register_aitype_setup("ar_t2_aq", "enemy_cp_ar_tier2_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_ar_tier2_aq", 20);
  register_aitype_setup("ar_t3_aq", "enemy_cp_ar_tier3_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_ar_tier3_aq", 30);
  register_aitype_setup("lmg_t1_aq", "enemy_cp_lmg_tier1_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_lmg_tier1_aq", 10);
  register_aitype_setup("lmg_t2_aq", "enemy_cp_lmg_tier2_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_lmg_tier2_aq", 20);
  register_aitype_setup("lmg_t3_aq", "enemy_cp_lmg_tier3_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_lmg_tier3_aq", 30);
  register_aitype_setup("shotgun_t1_aq", "enemy_cp_shotgun_tier1_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_shotgun_tier1_aq", 10);
  register_aitype_setup("shotgun_t2_aq", "enemy_cp_shotgun_tier2_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_shotgun_tier2_aq", 20);
  register_aitype_setup("shotgun_t3_aq", "enemy_cp_shotgun_tier3_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_shotgun_tier3_aq", 30);
  register_aitype_setup("smg_t1_aq", "enemy_cp_smg_tier1_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_smg_tier1_aq", 10);
  register_aitype_setup("smg_t2_aq", "enemy_cp_smg_tier2_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_smg_tier2_aq", 20);
  register_aitype_setup("smg_t3_aq", "enemy_cp_smg_tier3_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_smg_tier3_aq", 30);
  register_aitype_setup("sniper_t1_aq", "enemy_cp_sniper_tier1_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_sniper_tier1_aq", 10);
  register_aitype_setup("sniper_t2_aq", "enemy_cp_sniper_tier2_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_sniper_tier2_aq", 20);
  register_aitype_setup("sniper_t3_aq", "enemy_cp_sniper_tier3_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_sniper_tier3_aq", 30);
  register_aitype_setup("firebug_t1_aq", "enemy_cp_firebug_tier1_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_firebug_tier1_aq", 10);
  register_aitype_setup("firebug_t2_aq", "enemy_cp_firebug_tier2_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_firebug_tier2_aq", 20);
  register_aitype_setup("firebug_t3_aq", "enemy_cp_firebug_tier3_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_firebug_tier3_aq", 30);
  register_aitype_setup("riotshield_t1_aq", "enemy_cp_riotshield_tier1_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_riotshield_tier1_aq", 10);
  register_aitype_setup("riotshield_t2_aq", "enemy_cp_riotshield_tier2_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_riotshield_tier2_aq", 20);
  register_aitype_setup("riotshield_t3_aq", "enemy_cp_riotshield_tier3_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_riotshield_tier3_aq", 30);
  register_aitype_setup("rpg_t1_aq", "enemy_cp_rpg_tier1_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_rpg_tier1_aq", 10);
  register_aitype_setup("rpg_t2_aq", "enemy_cp_rpg_tier2_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_rpg_tier2_aq", 20);
  register_aitype_setup("rpg_t3_aq", "enemy_cp_rpg_tier3_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_rpg_tier3_aq", 30);
  register_aitype_setup("smg_t1_nvg_aq", "enemy_cp_smg_tier1_nvg_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_smg_tier1_nvg_aq", 10);
  register_aitype_setup("smg_t2_nvg_aq", "enemy_cp_smg_tier2_nvg_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_smg_tier2_nvg_aq", 20);
  register_aitype_setup("smg_t3_nvg_aq", "enemy_cp_smg_tier3_nvg_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_smg_tier3_nvg_aq", 30);
  register_aitype_setup("lmg_t1_nvg_aq", "enemy_cp_lmg_tier1_nvg_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_lmg_tier1_nvg_aq", 10);
  register_aitype_setup("lmg_t2_nvg_aq", "enemy_cp_lmg_tier2_nvg_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_lmg_tier2_nvg_aq", 20);
  register_aitype_setup("lmg_t3_nvg_aq", "enemy_cp_lmg_tier3_nvg_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_lmg_tier3_nvg_aq", 30);
  register_aitype_setup("ar_t1_nvg_aq", "enemy_cp_ar_tier1_nvg_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_ar_tier1_nvg_aq", 10);
  register_aitype_setup("ar_t2_nvg_aq", "enemy_cp_ar_tier2_nvg_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_ar_tier2_nvg_aq", 20);
  register_aitype_setup("ar_t3_nvg_aq", "enemy_cp_ar_tier3_nvg_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_ar_tier3_nvg_aq", 30);
  register_aitype_setup("shotgun_t1_nvg_aq", "enemy_cp_shotgun_tier1_nvg_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_shotgun_tier1_nvg_aq", 10);
  register_aitype_setup("shotgun_t2_nvg_aq", "enemy_cp_shotgun_tier2_nvg_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_shotgun_tier2_nvg_aq", 20);
  register_aitype_setup("shotgun_t3_nvg_aq", "enemy_cp_shotgun_tier3_nvg_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_shotgun_tier3_nvg_aq", 30);
  register_aitype_setup("riotshield_t1_nvg_aq", "enemy_cp_riotshield_tier1_nvg_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_riotshield_tier1_nvg_aq", 10);
  register_aitype_setup("riotshield_t2_nvg_aq", "enemy_cp_riotshield_tier2_nvg_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_riotshield_tier2_nvg_aq", 20);
  register_aitype_setup("riotshield_t3_nvg_aq", "enemy_cp_riotshield_tier3_nvg_aq");
  _id_C8F8A1D96F1DBEEE("enemy_cp_riotshield_tier3_nvg_aq", 30);
  register_aitype_setup("jugg_aq", "enemy_cp_jugg_aq", undefined, ::set_juggernaut_flags);
  _id_C8F8A1D96F1DBEEE("enemy_cp_jugg_aq", 100);
  register_aitype_setup("jugg_cartel", "enemy_cp_jugg_cartel", undefined, ::_id_AA669A6101DFC888);
  _id_C8F8A1D96F1DBEEE("enemy_cp_jugg_cartel", 100);
  register_aitype_setup("pyro_boss", "enemy_cp_boss_pyro", undefined, _id_756383447909CFAF::_id_4108074415ABC816);
  _id_C8F8A1D96F1DBEEE("enemy_cp_boss_pyro", 100);
  register_aitype_setup("new_civ", "civilian_iw9_me_cp");
  _id_C8F8A1D96F1DBEEE("civilian_iw9_me_cp", 30);
  register_aitype_setup("bomber_t1_aq", "enemy_cp_bomber", ::suicide_bomber_combat_func, ::cp_suicidebomber_init);
  _id_C8F8A1D96F1DBEEE("enemy_cp_bomber", 10);
  register_aitype_setup("boss_velikan", "enemy_cp_boss_velikan", undefined, ::_id_25A97465DD4606C0);
  _id_C8F8A1D96F1DBEEE("enemy_cp_boss_velikan", 30);
  register_aitype_setup("boss_velikan_raid_ep3", "enemy_cp_boss_velikan_raid_ep3", undefined, ::_id_25A97465DD4606C0);
  _id_C8F8A1D96F1DBEEE("enemy_cp_boss_velikan_raid_ep3", 30);
  register_aitype_setup("ar_t1_cartel", "enemy_cp_ar_tier1_cartel");
  _id_C8F8A1D96F1DBEEE("enemy_cp_ar_tier1_cartel", 10);
  register_aitype_setup("ar_t2_cartel", "enemy_cp_ar_tier2_cartel");
  _id_C8F8A1D96F1DBEEE("enemy_cp_ar_tier2_cartel", 20);
  register_aitype_setup("ar_t3_cartel", "enemy_cp_ar_tier3_cartel");
  _id_C8F8A1D96F1DBEEE("enemy_cp_ar_tier3_cartel", 30);
  register_aitype_setup("lmg_t1_cartel", "enemy_cp_lmg_tier1_cartel");
  _id_C8F8A1D96F1DBEEE("enemy_cp_lmg_tier1_cartel", 10);
  register_aitype_setup("lmg_t2_cartel", "enemy_cp_lmg_tier2_cartel");
  _id_C8F8A1D96F1DBEEE("enemy_cp_lmg_tier2_cartel", 10);
  register_aitype_setup("lmg_t3_cartel", "enemy_cp_lmg_tier3_cartel");
  _id_C8F8A1D96F1DBEEE("enemy_cp_lmg_tier3_cartel", 30);
  register_aitype_setup("riotshield_t1_cartel", "enemy_cp_riotshield_tier1_cartel");
  _id_C8F8A1D96F1DBEEE("enemy_cp_riotshield_tier1_cartel", 10);
  register_aitype_setup("riotshield_t2_cartel", "enemy_cp_riotshield_tier2_cartel");
  _id_C8F8A1D96F1DBEEE("enemy_cp_riotshield_tier2_cartel", 20);
  register_aitype_setup("riotshield_t3_cartel", "enemy_cp_riotshield_tier3_cartel");
  _id_C8F8A1D96F1DBEEE("enemy_cp_riotshield_tier3_cartel", 30);
  register_aitype_setup("riotshield_t1_cartel_pistol", "enemy_cp_riotshield_tier1_cartel_pistol");
  _id_C8F8A1D96F1DBEEE("enemy_cp_riotshield_tier1_cartel_pistol", 10);
  register_aitype_setup("riotshield_t2_cartel_pistol", "enemy_cp_riotshield_tier2_cartel_pistol");
  _id_C8F8A1D96F1DBEEE("enemy_cp_riotshield_tier2_cartel_pistol", 20);
  register_aitype_setup("rpg_t1_cartel", "enemy_cp_rpg_tier1_cartel");
  _id_C8F8A1D96F1DBEEE("enemy_cp_rpg_tier1_cartel", 10);
  register_aitype_setup("rpg_t2_cartel", "enemy_cp_rpg_tier2_cartel");
  _id_C8F8A1D96F1DBEEE("enemy_cp_rpg_tier2_cartel", 20);
  register_aitype_setup("rpg_t3_cartel", "enemy_cp_rpg_tier3_cartel");
  _id_C8F8A1D96F1DBEEE("enemy_cp_rpg_tier3_cartel", 30);
  register_aitype_setup("shotgun_t1_cartel", "enemy_cp_shotgun_tier1_cartel");
  _id_C8F8A1D96F1DBEEE("enemy_cp_shotgun_tier1_cartel", 10);
  register_aitype_setup("shotgun_t2_cartel", "enemy_cp_shotgun_tier2_cartel");
  _id_C8F8A1D96F1DBEEE("enemy_cp_shotgun_tier2_cartel", 20);
  register_aitype_setup("shotgun_t3_cartel", "enemy_cp_shotgun_tier3_cartel");
  _id_C8F8A1D96F1DBEEE("enemy_cp_shotgun_tier3_cartel", 30);
  register_aitype_setup("smg_t1_cartel", "enemy_cp_smg_tier1_cartel");
  _id_C8F8A1D96F1DBEEE("enemy_cp_smg_tier1_cartel", 10);
  register_aitype_setup("smg_t2_cartel", "enemy_cp_smg_tier2_cartel");
  _id_C8F8A1D96F1DBEEE("enemy_cp_smg_tier2_cartel", 20);
  register_aitype_setup("smg_t3_cartel", "enemy_cp_smg_tier3_cartel");
  _id_C8F8A1D96F1DBEEE("enemy_cp_smg_tier3_cartel", 30);
  register_aitype_setup("sniper_t1_cartel", "enemy_cp_sniper_tier1_cartel");
  _id_C8F8A1D96F1DBEEE("enemy_cp_sniper_tier1_cartel", 10);
  register_aitype_setup("sniper_t2_cartel", "enemy_cp_sniper_tier2_cartel");
  _id_C8F8A1D96F1DBEEE("enemy_cp_sniper_tier2_cartel", 20);
  register_aitype_setup("sniper_t3_cartel", "enemy_cp_sniper_tier3_cartel");
  _id_C8F8A1D96F1DBEEE("enemy_cp_sniper_tier3_cartel", 30);
}

_id_C8F8A1D96F1DBEEE(agent_type, _id_A7A0977819F12710) {
  if(!isDefined(level.agent_definition))
    level.agent_definition = [];

  level.agent_definition[agent_type]["reward"] = _id_A7A0977819F12710;
  level.agent_definition[agent_type]["xp"] = _id_A7A0977819F12710;
}

register_aitype_setup(aitype, agent_type, combat_func, spawn_func, info_func, spawn_vo_lines) {
  struct = spawnStruct();
  struct.agent_type = agent_type;
  struct.combat_func = combat_func;
  struct.spawn_func = spawn_func;
  struct.info_func = info_func;
  struct.spawn_vo_lines = spawn_vo_lines;
  level.lastspawnvocallouttimes[aitype] = -99999;
  level.aitypes[aitype] = struct;
  _id_18A73A64992DD07D::registerambientgroup("AITYPE:0/ " + aitype, 0, 1, 1, 0.1, undefined, "cap_test", [::_id_CB88733D2F7DBEBD, aitype]);
}

_id_CB88733D2F7DBEBD(_id_F8E5E3AA5762A8E7, aitype) {
  _id_F8E5E3AA5762A8E7.aitype_override = [aitype];
  _id_F8E5E3AA5762A8E7.aitype_override_weights = [1];
}

_id_9C044AFB98BA23F6() {
  _id_703FDBB02501D31E::_id_6FDBF71C8217CFC5("brloot_ammo_rocket_rpg_ai");
}

cp_suicidebomber_init() {
  self.bombercanexplodebehindtarget = 1;
  self.bomberusegrenade = 0;
  self.combatmode = "no_cover";
  self.suicidebomberchants = 0;
  thread delay_set_bomber_traversals();
}

delay_set_bomber_traversals() {
  self endon("death");
  waitframe();

  if(istrue(level.bomber_shouldusetraversals))
    self enabletraversals(1, "soldier");
  else
    self enabletraversals(0, "soldier");
}

_id_AA669A6101DFC888() {
  self._id_8081D864DC563057 = 1;
  set_juggernaut_flags();
}

set_juggernaut_flags() {
  self.disablegrenaderesponse = 1;
  self.meleechargedistvsplayer = getdvarint("dvar_C4623FF30DDE6AE9", self.meleechargedistvsplayer);
  self.meleechargedist = getdvarint("dvar_F3B2DAA7C30B46E3", self.meleechargedist);
  self.meleestopattackdistsq = squared(getdvarint("dvar_6B6862DC32C4AD93", sqrt(self.meleestopattackdistsq)));
  self.meleedamageoverride = getdvarint("dvar_C36464367B65902A", self.meleedamageoverride);
  self.attackeraccuracy = getdvarint("dvar_27C356DD262C53EB", self.attackeraccuracy);
  self._id_7D606BEC79308EB5 = getdvarint("dvar_6F5088CC345089B0", self._id_7D606BEC79308EB5);
  self.minpaindamage = getdvarint("dvar_5212419A69489B1A", self.minpaindamage);
  self.maxhealth = getdvarint("dvar_93C7973E428C20D3", self.maxhealth);
  self.health = self.maxhealth;
  _id_47FC06D4BB326007::_id_A414FBF48AE645F4();
  self.immune_to_melee_damage = 1;
  self.recent_player_attackers = [];
  self allowedstances("stand");
  self setscriptablepartstate("loop_sounds", "music", 1);
  _id_371B4C2AB5861E62::_id_1C3709E864D4E8D5(1);
  self sethitlocdamagetable("mp_lochit_dmgtable");

  if(getdvarint("dvar_0749F54CE1EB4AE4", 1))
    scripts\engine\utility::disable_pain();

  _id_47FC06D4BB326007::_id_1CBB19FC0CAEAB00();

  if(isDefined(level._id_BF8AA3F39F981625)) {
    foreach(func in level._id_BF8AA3F39F981625)
    self thread[[func]]();
  }

  thread pain_threshold_watcher();
  thread jugg_music();
}

pain_threshold_watcher() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    _id_7F4B5AC6B201321A = get_jugg_minpaindamage();
    self waittill("damage", damage, player);
    players = level.players.size;

    if(isDefined(player) && player scripts\cp\utility::is_valid_player() && players > 0) {
      self.recent_player_attackers[player.name] = 1;
      thread remove_player_from_attacker_list(player);
      _id_595058A326945465 = getdvarint("dvar_2DF212783E0BF84F", 75);
      _id_1271E4A73DE480B6 = self.recent_player_attackers.size;
      _id_6302CA9978061647 = int(max(1, _id_7F4B5AC6B201321A * (players / _id_1271E4A73DE480B6) - (_id_1271E4A73DE480B6 - 1) * _id_595058A326945465));
      self.minpaindamage = _id_6302CA9978061647;
    }
  }
}

remove_player_from_attacker_list(player) {
  player notify("remove_player_from_attacker_list");
  player endon("remove_player_from_attacker_list");
  player endon("disconnect");
  self endon("death");
  self.recent_player_attackers[player.name] = 1;
  wait(getdvarfloat("dvar_150E3B3C1B10762A", 0.5));
  self.recent_player_attackers[player.name] = undefined;

  if(self.recent_player_attackers.size < 1)
    self.minpaindamage = get_jugg_minpaindamage();
}

get_jugg_minpaindamage() {
  return getdvarint("dvar_5212419A69489B1A", 200);
}

jugg_music() {
  _id_4CF58793CC4F1AD6 = spawn("script_origin", self.origin);
  _id_4CF58793CC4F1AD6 linkTo(self);
  wait 0.1;
  _id_4CF58793CC4F1AD6 setModel("juggernaut_scriptable");
  scripts\engine\utility::waittill_any_3("juggernaut_end", "disconnect", "death");
  _id_4CF58793CC4F1AD6 delete();
}

_id_25A97465DD4606C0() {
  body = "body_mp_eastern_velikan_1_1";
  head = "head_mp_eastern_velikan_1_1";
  mapname = getDvar("g_mapname");

  if(scripts\common\utility::iscp() && mapname == "cp_lone") {
    body = "body_sp_opforce_cartel_tier_3_1_1";
    head = "head_sp_opforce_cartel_tier_3_1_1";
    scripts\common\utility::set_battlechatter(0);
    self setclothtype("leather");
    self _meth_8ABE5A968CC3C220("millghtgr");
  }

  if(scripts\common\utility::iscp() && (mapname == "cp_raid1_boss1" || mapname == "cp_jugg_maze")) {
    body = "body_sp_opforce_al_qatala_boss_pyro";
    head = "head_sp_opforce_al_qatala_boss_pyro";
    scripts\common\utility::set_battlechatter(0);
  }

  weapon = _id_2669878CF5A1B6BC::buildweapon("iw9_la_mike32biolab_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
  _id_A664AAD02EE98BD2 = "flash_grenade_mp";
  grenadeammo = 4;
  self._id_857FF4A1E09042D4 = _id_2669878CF5A1B6BC::buildweapon("iw9_la_mike32_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");

  if(!istrue(level._id_ED42A79A82EED1E4)) {
    self._id_AD799295A6692B29 = 1;
    self.dropweapon = 0;
  }

  armor = 1000;
  helmet = level._id_6855C201495094B6["jugg"];
  _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(body, head, weapon, _id_A664AAD02EE98BD2, grenadeammo, armor, helmet, 0);
  self._id_F2A62F02827DAAA5 = 1.0;
  self.aggressivemode = 1;
  self.suppressionthreshold = 0.4;
  self.suppressiondecrement = 0.2;
  self._id_2A4784C6CC07CA59 = 0.05;
  self._id_CBD87A0BC497B778 = 1;
  self.baseaccuracy = getdvarfloat("dvar_298D4EA8B0934E31", 1.2);
}

_id_38084F83D390A611(group_name, func) {
  thread _id_43678D7BEC207335();
  scripts\common\utility::set_battlechatter(0);
}

_id_43678D7BEC207335() {
  level endon("game_ended");
  self endon("death");
  _id_18A73A64992DD07D::set_goal_radius(1300);

  if(!istrue(level._id_C1081D7C7E56BDF7))
    self enabletraversals(0, "soldier");

  foreach(player in level.players)
  self getenemyinfo(player);

  _id_636C8575D7A7768B = 1048576;

  for(;;) {
    wait 5;

    if(!scripts\cp\utility::any_player_nearby(self.origin, _id_636C8575D7A7768B)) {
      nearbyplayer = scripts\cp\utility::get_closest_living_player();

      if(isDefined(nearbyplayer))
        _id_18A73A64992DD07D::set_goal_pos(self getclosestreachablepointonnavmesh(nearbyplayer.origin));
    }

    foreach(player in level.players)
    self getenemyinfo(player);
  }
}

suicide_bomber_combat_func(param1) {
  thread start_chants_on_movement();

  if(isDefined(level.suicide_bomber_combat_func))
    self thread[[level.suicide_bomber_combat_func]]();
  else
    thread default_suicidebomber_combat();
}

start_chants_on_movement() {
  self endon("death");
  self.suicidebomberchants = 0;
  wait 3;
  startpos = self.origin;

  while(distance(startpos, self.origin) < 750) {
    self.suicidebomberchants = 0;
    wait 0.5;
  }

  self.suicidebomberchants = 1;
  thread scripts\aitypes\suicidebomber\combat::dochants();
}

default_suicidebomber_combat() {
  self endon("death");

  for(;;) {
    _id_18A73A64992DD07D::get_all_players_enemy_info_new();

    if(isDefined(self.enemy)) {
      if(isDefined(self.enemy.vehicle_riding_on))
        self.bombertarget = self.enemy.vehicle_riding_on;
      else
        self.bombertarget = undefined;
    }

    wait 1;
  }
}

_id_EC97EB7CF543044B(_id_08FF461430089F2B) {
  self.fnstealthgotonode = _id_5938B1C7E9CF6DDD::go_to_node;
}

_id_2585B1944B7884C0() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("pyro", "molotov_used", scripts\cp\powers\coop_molotov::molotov_used);
}