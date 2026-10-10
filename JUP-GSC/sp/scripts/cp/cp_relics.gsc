/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_relics.gsc
***********************************************/

#using scripts\anim\shared;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\agent_damage;
#using scripts\cp\agent_drops;
#using scripts\cp\armor;
#using scripts\cp\cp_agent_utils;
#using scripts\cp\cp_checkpoint;
#using scripts\cp\cp_grenade_crate;
#using scripts\cp\cp_hostmigration;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_objectives;
#using scripts\cp\cp_outline;
#using scripts\cp\cp_outline_utility;
#using scripts\cp\cp_relics;
#using scripts\cp\damage;
#using scripts\cp\damagefeedback;
#using scripts\cp\equipment\cp_gas_grenade;
#using scripts\cp\equipment\cp_thermite;
#using scripts\cp\killstreaks\gunship_cp;
#using scripts\cp\laststand;
#using scripts\cp\loadout;
#using scripts\cp\munitions;
#using scripts\cp\perks\cp_perks;
#using scripts\cp\persistence;
#using scripts\cp\pickups;
#using scripts\cp\powers\coop_molotov;
#using scripts\cp\spawning;
#using scripts\cp\utility;
#using scripts\cp\utility\cp_controlled_callbacks;
#using scripts\cp\utility\player;
#using scripts\cp\utility\spawn_event_aggregator;
#using scripts\cp\vo;
#using scripts\cp\weapon;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\killstreaks\nuke;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;
#namespace cp_relics;

function register_relics() {
  level.updateonkillrelicsfunc = &updateonkillrelics;
  level.updatepersistentrelicsfunc = &updatepersistentrelics;
  level.updateondamagerelicsfunc = &updateondamagerelics;
  level.updateondamagepredamagemodrelicsfunc = &updateondamagepredamagemodrelics;
  level.cp_relics = [];
  level.updaterecentkillsrelics_func = &updaterecentkills;
  level.updatedroprelicsfunc = &updatedroprelics;
  level.relic_combos = load_relic_combos_from_table();
  level.modifyplayerdamage_relics = [];

  if(!isDefined(level.var_6905e4b813093c94)) {
    level.var_6905e4b813093c94 = [];
  }

  if(!isDefined(level.perks)) {
    level.perks = ["perk_machine_tough", "perk_machine_revive", "perk_machine_flash", "perk_machine_more", "perk_machine_rat_a_tat", "perk_machine_run", "perk_machine_fwoosh", "perk_machine_smack", "perk_machine_zap", "perk_machine_boom"];
  }

  register_relic("passive_railgun_overload", &init_passive_railgun_overload, &set_passive_railgun_overload, &unset_passive_railgun_overload);
  register_relic("passive_last_shots_ammo", &init_passive_last_shots_ammo, &set_passive_last_shots_ammo, &unset_passive_last_shots_ammo);
  register_relic("passive_nuke", &init_passive_nuke, &set_passive_nuke, &unset_passive_nuke);
  register_relic("passive_headshot_ammo", &init_headshot_ammo, &set_headshot_ammo, &unset_headshot_ammo);
  register_relic("passive_headshot_super", &init_headshot_super, &set_headshot_super, &unset_headshot_super);
  register_relic("passive_refresh", &init_passive_refresh, &set_passive_refresh, &unset_passive_refresh);
  register_relic("passive_double_kill_reload", &init_passive_double_kill_reload, &set_passive_double_kill_reload, &unset_passive_double_kill_reload);
  register_relic("passive_gore", &init_passive_gore, &set_passive_gore, &unset_passive_gore);
  register_relic("passive_meleekill", &init_passive_melee_kill, &set_passive_melee_kill, &unset_passive_melee_kill);
  register_relic("passive_health_on_kill", &init_passive_health_on_kill, &set_passive_health_on_kill, &unset_passive_health_on_kill);
  register_relic("passive_health_regen_on_kill", &init_passive_health_regen_on_kill, &set_passive_health_regen_on_kill, &unset_passive_health_regen_on_kill);
  register_relic("passive_move_speed_on_kill", &init_passive_move_speed_on_kill, &set_passive_move_speed_on_kill, &unset_passive_move_speed_on_kill);
  register_relic("passive_hitman", &init_passive_hitman, &set_passive_hitman, &unset_passive_hitman);
  register_relic("passive_score_bonus_kills", &init_passive_score_bonus_kills, &set_passive_score_bonus_kills, &unset_passive_score_bonus_kills);
  register_relic("passive_scorestreak_pack", &init_passive_score_bonus_kills, &set_passive_score_bonus_kills, &unset_passive_score_bonus_kills);
  register_relic("passive_random_perks", &init_passive_random_perks, &set_passive_random_perks, &unset_passive_random_perks);
  register_relic("passive_visor_detonation", &init_passive_visor_detonation, &set_passive_visor_detonation, &unset_passive_visor_detonation);
  register_relic("passive_melee_super", &init_passive_melee_super, &set_passive_melee_super, &unset_passive_melee_super);
  register_relic("passive_jump_super", &init_passive_jump_super, &set_passive_jump_super, &unset_passive_jump_super);
  register_relic("passive_double_kill_super", &init_passive_double_kill_super, &set_passive_double_kill_super, &unset_passive_double_kill_super);
  register_relic("passive_mode_switch_score", &init_passive_mode_switch_score, &set_passive_mode_switch_score, &unset_passive_mode_switch_score);
  register_relic("passive_melee_cone_expl", &init_passive_melee_cone_expl, &set_passive_melee_cone_expl, &unset_passive_melee_cone_expl);
  register_relic("passive_berserk", &init_passive_berserk, &set_passive_berserk, &unset_passive_berserk);
  register_relic("passive_infinite_ammo", &init_passive_infinite_ammo, &set_passive_infinite_ammo, &unset_passive_infinite_ammo);
  register_relic("passive_crouch_move_speed", &init_passive_crouch_move_speed, &set_passive_crouch_move_speed, &unset_passive_crouch_move_speed);
  register_relic("passive_slide_blastshield", &init_passive_fortified, &set_passive_fortified, &unset_passive_fortified);
  register_relic("passive_cold_damage", &init_passive_cold_damage, &set_passive_cold_damage, &unset_passive_cold_damage);
  register_relic("passive_sonic", &init_passive_sonic, &set_passive_sonic, &unset_passive_sonic);
  register_relic("passive_below_the_belt", &init_passive_below_the_belt, &set_passive_below_the_belt, &unset_passive_below_the_belt);
  register_relic("passive_minimap_damage", &init_passive_minimap_damage, &set_passive_minimap_damage, &unset_passive_minimap_damage);
  register_relic("passive_extra_xp", &init_extra_xp, &set_extra_xp, &unset_extra_xp);
  register_relic("passive_fast_melee", &init_passive_fast_melee, &set_passive_fast_melee, &unset_passive_fast_melee);
  register_relic("coop_passive_snap_to_head", &init_snap_to_head, &set_snap_to_head, &unset_snap_to_head);
  register_relic("passive_empty_reload_speed", &init_passive_empty_reload_speed, &set_passive_empty_reload_speed, &unset_passive_empty_reload_speed);
  register_relic("passive_increased_scope_breath", &init_passive_increased_scope_breath, &set_passive_increased_scope_breath, &unset_passive_increased_scope_breath);
  register_relic("passive_hunter_killer", &init_passive_hunter_killer, &set_passive_hunter_killer, &unset_passive_hunter_killer);
  register_relic("passive_move_speed", &init_passive_move_speed, &set_passive_move_speed, &unset_passive_move_speed);
  register_relic("passive_miss_refund", &init_passive_miss_refund, &set_passive_miss_refund, &unset_passive_miss_refund);
  register_relic("passive_scoutping", &init_passive_scoutping, &set_passive_scoutping, &unset_passive_scoutping);
  register_relic("passive_scrambler", &init_passive_scrambler, &set_passive_scrambler, &unset_passive_scrambler);
  register_relic("passive_scope_radar", &init_passive_scope_radar, &set_passive_scope_radar, &unset_passive_scope_radar);
  register_relic("passive_scorestreak_damage", &init_passive_scorestreak_damage, &set_passive_scorestreak_damage, &unset_passive_scorestreak_damage);
  register_relic("passive_scorestreak_damage_e", &init_passive_scorestreak_damage, &set_passive_scorestreak_damage, &unset_passive_scorestreak_damage);
  register_relic("relic_collat_dmg", &init_relic_collat_dmg, &set_relic_collat_dmg, &unset_relic_collat_dmg);
  register_relic("relic_catch", &init_relic_catch, &set_relic_catch, &unset_relic_catch);
  register_relic("relic_boom", &init_relic_boom, &set_relic_boom, &unset_relic_boom);
  register_relic("relic_swat", &init_relic_swat, &set_relic_swat, &unset_relic_swat);
  register_relic("relic_glasscannon", &init_relic_glasscannon, &set_relic_glasscannon, &unset_relic_glasscannon);
  register_relic("relic_aggressive_melee", &init_relic_aggressive_melee, &set_relic_aggressive_melee, &unset_relic_aggressive_melee);
  register_relic("relic_focus_fire", &init_relic_focus_fire, &set_relic_focus_fire, &unset_relic_focus_fire);
  register_relic("relic_damage_from_above", &init_relic_damage_from_above, &set_relic_damage_from_above, &unset_relic_damage_from_above);
  register_relic("relic_landlocked", &init_relic_landlocked, &set_relic_landlocked, &unset_relic_landlocked);
  register_relic("relic_martyrdom", &init_relic_martyrdom, &set_relic_martyrdom, &unset_relic_martyrdom);
  register_relic("relic_gas_martyr", &init_relic_gas_martyr, &set_relic_gas_martyr, &unset_relic_gas_martyr);
  register_relic("relic_gun_game", &init_relic_gun_game, &set_relic_gun_game, &unset_relic_gun_game);
  register_relic("relic_team_proximity", &init_relic_team_proximity, &set_relic_team_proximity, &unset_relic_team_proximity);
  register_relic("relic_squadlink", &init_relic_squadlink, &set_relic_squadlink, &unset_relic_squadlink);
  register_relic("relic_dfa", &init_relic_dfa, &set_relic_dfa, &unset_relic_dfa);
  register_relic("relic_shieldsonly", &init_relic_shieldsonly, &set_relic_shieldsonly, &unset_relic_shieldsonly);
  register_relic("relic_mythic", &init_relic_mythic, &set_relic_mythic, &unset_relic_mythic);
  register_relic("relic_amped", &init_relic_amped, &set_relic_amped, &unset_relic_amped);
  register_relic("relic_thirdperson", &init_relic_thirdperson, &set_relic_thirdperson, &unset_relic_thirdperson);
  register_relic("relic_dogtags", &init_relic_dogtags, &set_relic_dogtags, &unset_relic_dogtags);
  register_relic("relic_lsmelee", &init_relic_laststandmelee, &set_relic_laststandmelee, &unset_relic_laststandmelee);
  register_relic("relic_hideobj", &init_relic_hideobjicons, &set_relic_hideobjicons, &unset_relic_hideobjicons);
  register_relic("relic_expldmg", &init_relic_explodedmg, &set_relic_explodedmg, &unset_relic_explodedmg);
  register_relic("relic_fastbleed", &init_relic_fastbleedout, &set_relic_fastbleedout, &unset_relic_fastbleedout);
  register_relic("relic_nuketimer", &init_relic_nuketimer, &set_relic_nuketimer, &unset_relic_nuketimer);
  register_relic("relic_doubletap", &init_relic_doubletap, &set_relic_doubletap, &unset_relic_doubletap);
  register_relic("relic_vampire", &init_relic_vampire, &set_relic_vampire, &unset_relic_vampire);
  register_relic("relic_healthpacks", &init_relic_healthpacks, &set_relic_healthpacks, &unset_relic_healthpacks);
  register_relic("relic_noregen", &init_relic_noregen, &set_relic_noregen, &unset_relic_noregen);
  register_relic("relic_noks", &init_relic_noks, &set_relic_noks, &unset_relic_noks);
  register_relic("relic_no_ammo_mun", &init_relic_no_ammo_mun, &set_relic_no_ammo_mun, &unset_relic_no_ammo_mun);
  register_relic("relic_lfo", &init_relic_lfo, &set_relic_lfo, &unset_relic_lfo);
  register_relic("relic_aitype_shotgun", undefined, &set_force_aitype_shotgun, &unset_force_aitype_shotgun);
  register_relic("relic_aitype_sniper", undefined, &set_force_aitype_sniper, &unset_force_aitype_sniper);
  register_relic("relic_aitype_riotshield", undefined, &set_force_aitype_riotshield, &unset_force_aitype_riotshield);
  register_relic("relic_aitype_suicidebomber", undefined, &set_force_aitype_suicidebomber, &unset_force_aitype_suicidebomber);
  register_relic("relic_aitype_rpg", undefined, &set_force_aitype_rpg, &unset_force_aitype_rpg);
  register_relic("relic_aitype_armored", undefined, &set_force_aitype_armored, &unset_forced_aitype_armored);
  register_relic("relic_bang_and_boom", &init_relic_bang_and_boom, &set_relic_bang_and_boom, &unset_relic_bang_and_boom);
  register_relic("relic_noluck", &init_relic_noluck, &set_relic_noluck, &unset_relic_noluck);
  register_relic("relic_doomslayer", &init_relic_doomslayer, &set_relic_doomslayer, &unset_relic_doomslayer);
  register_relic("relic_headbullets", &init_relic_headbullets, &set_relic_headbullets, &unset_relic_headbullets);
  register_relic("relic_rocket_kill_ammo", &init_relic_rocket_kill_ammo, &set_relic_rocket_kill_ammo, &unset_relic_rocket_kill_ammo);
  register_relic("relic_oneInTheChamber", &function_78e009b52b565ff5, &function_78d22d7754b8a60d, &function_1bd55bd951802eda);
  register_relic("relic_punchbullets", &init_relic_punchbullets, &set_relic_punchbullets, &unset_relic_punchbullets);
  register_relic("relic_grounded", &init_relic_grounded, &set_relic_grounded, &unset_relic_grounded);
  register_relic("relic_oneclip", &init_relic_oneclip, &set_relic_oneclip, &unset_relic_oneclip);
  register_relic("relic_laststand", &init_relic_laststand, &set_relic_laststand, &unset_relic_laststand);
  register_relic("relic_steelballs", &init_relic_steelballs, &set_relic_steelballs, &unset_relic_steelballs);
  register_relic("relic_nobulletdamage", &init_relic_nobulletdamage, &set_relic_nobulletdamage, &unset_relic_nobulletdamage);
  register_relic("relic_ammo_drain", &init_relic_ammo_drain, &set_relic_ammo_drain, &unset_relic_ammo_drain);
  register_relic("relic_trex", &init_relic_trex, &set_relic_trex, &unset_relic_trex);
  level.globalrelicsfunc = [];
  level.globalrelicsfunc["relic_noks"] = &handlenokillstreaks;
  level.globalrelicsfunc["relic_no_ammo_mun"] = &handle_no_ammo_mun;
  level.globalrelicsfunc["relic_lfo"] = &handlelfo;
  level.globalrelicsfunc["relic_focus_fire"] = &handlefocusfire;
  level.globalrelicsfunc["relic_mythic"] = &handlemythic;
  level.globalrelicsfunc["relic_dfa"] = &handledeathfromabove;
  level.globalrelicsfunc["relic_swat"] = &checkdamagesourcerelicswat;
  level.globalrelicsfunc["relic_aitype_shotgun"] = &blank_relic_func;
  level.globalrelicsfunc["relic_aitype_sniper"] = &blank_relic_func;
  level.globalrelicsfunc["relic_aitype_riotshield"] = &blank_relic_func;
  level.globalrelicsfunc["relic_aitype_suicidebomber"] = &blank_relic_func;
  level.globalrelicsfunc["relic_aitype_rpg"] = &blank_relic_func;
  level.globalrelicsfunc["relic_aitype_armored"] = &blank_relic_func;
  level.globalrelicsfunc["relic_team_proximity"] = &global_relic_team_prox_func;
  level.globalrelicsfunc["relic_landlocked"] = &global_relic_landlocked_func;
  level.globalrelicsfunc["relic_healthpacks"] = &relic_healthpacks_globalfunc;
  level.globalrelicsfunc["relic_vampire"] = &relic_vampire_globalfunc;
  level.globalrelicsfunc["relic_squadlink"] = &global_relic_squadlink_func;
  level.globalrelicsfunc["relic_amped"] = &global_relic_amped_func;
  level.globalrelicsfunc["relic_oneInTheChamber"] = &function_43474778d36c627b;
  level.onkillrelics = [];
  level.onkillrelics["passive_nuke"] = &trackkillsforpassivenuke;
  level.onkillrelics["passive_random_perks"] = &trackkillsforrandomperks;
  level.onkillrelics["passive_railgun_overload"] = &dolocalrailgundamage;
  level.onkillrelics["passive_headshot_ammo"] = &handleheadshotammopassive;
  level.onkillrelics["passive_headshot_super"] = &addvaluetocardmeter;
  level.onkillrelics["passive_refresh"] = &handlepassiverefresh;
  level.onkillrelics["passive_double_kill_reload"] = &doublekillreloadwatcher;
  level.onkillrelics["passive_gore"] = &handlegorepassive;
  level.onkillrelics["passive_health_regen_on_kill"] = &handlehealthregenonkillpassive;
  level.onkillrelics["passive_move_speed_on_kill"] = &handlemovespeedonkillpassive;
  level.onkillrelics["passive_hitman"] = &handlehitmanpassive;
  level.onkillrelics["passive_meleekill"] = &handlemeleekillpassive;
  level.onkillrelics["passive_health_on_kill"] = &handlehealthonkillpassive;
  level.onkillrelics["passive_last_shots_ammo"] = &handleammoonlastshotskill;
  level.onkillrelics["passive_visor_detonation"] = &handlevisordetonation;
  level.onkillrelics["passive_melee_super"] = &handlemeleesuper;
  level.onkillrelics["passive_jump_super"] = &handleairbornesuper;
  level.onkillrelics["passive_double_kill_super"] = &handledoublekillssuper;
  level.onkillrelics["passive_melee_cone_expl"] = &handlemeleeconeexplode;
  level.onkillrelics["passive_berserk"] = &handleberserk;
  level.onkillrelics["passive_ninja"] = &handleammoonlastshotskill;
  level.onkillrelics["relic_punchbullets"] = &handlemeleekillrewardbullets;
  level.onkillrelics["relic_headbullets"] = &handleheadshotkillrewardbullets;
  level.onkillrelics["relic_rocket_kill_ammo"] = &handlerocketkillsgiverockets;
  level.onkillrelics["relic_steelballs"] = &handlemeleekillsteelballs;
  level.onkillrelics["relic_collat_dmg"] = &handlereliccollatdamage;
  level.onkillrelics["relic_catch"] = &handlereliccatch;
  level.onkillrelics["relic_boom"] = &handlerelicboom;
  level.onkillrelics["relic_martyrdom"] = &handlerelicmartyrdomfrag;
  level.onkillrelics["relic_gas_martyr"] = &handlerelicmartyrdomgas;
  level.onkillrelics["relic_shieldsonly"] = &handlerelicshieldsonlyonkill;
  level.onkillrelics["relic_healthpacks"] = &relic_healthpacks_killfunc;
  level.onkillrelics["relic_amped"] = &handlerelicampedonkill;
  level.onkillrelics["relic_oneInTheChamber"] = &function_3a051d1fd67ae155;
  level.persistentrelics = [];
  level.persistentrelics["passive_infinite_ammo"] = &handleinfiniteammopassive;
  level.persistentrelics["passive_fortified"] = &handlefortified;
  level.persistentrelics["relic_landlocked"] = &handlepersistentlandlocked;
  level.persistentrelics["relic_team_proximity"] = &handlepersistentteamproximity;
  level.persistentrelics["relic_gun_game"] = &handlepersistentgungame;
  register_relic("relic_just_keep_moving", undefined, &set_just_keep_moving, &unset_just_keep_moving);
  level.persistentrelics["relic_just_keep_moving"] = &handle_just_keep_moving;
  level.ondamagerelics = [];
  level.ondamagerelics["passive_sonic"] = &handlepassivesonic;
  level.ondamagerelics["passive_minimap_damage"] = &updatepassiveminimapdamage;
  level.ondamagerelics["passive_cold_damage"] = &updatepassivecolddamage;
  level.ondamagerelics["relic_swat"] = &handlerelicswat;
  level.ondamagerelics["relic_collat_dmg"] = &ondamagereliccollatdmg;
  level.ondamagerelics["relic_vampire"] = &ondamagerelicvampire;
  level.ondamagerelics["relic_lfo"] = &ondamagereliclfo;
  level.ondamagerelics["relic_focus_fire"] = &ondamagerelicfocusfire;
  level.ondamagerelics["relic_damage_from_above"] = &ondamagerelicfromabove;
  level.ondamagerelics["relic_steelballs"] = &ondamagerelicsteelballs;
  level.ondamagerelics["relic_doomslayer"] = &ondamagerelicdoomslayer;
  level.ondamagerelics["relic_squadlink"] = &ondamagerelicsquadlink;
  level.ondamagerelics["relic_nobulletdamage"] = &empty;
  level.ondamagerelics["relic_oneInTheChamber"] = &function_c72ff7743ec64985;
  level.ondamagepredamagemodrelics = [];
  level.ondamagepredamagemodrelics["relic_focus_fire"] = &ondamagepredamagemodrelicfocusfire;
  level.ondroprelics = [];
  level.ondroprelics["relic_bang_and_boom"] = &relic_bang_and_boom_dropfunc;
}

function empty(victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc) {
  return idamage;
}

function load_relic_combos_from_table() {
  var_cab56b5d84a60595 = "cp/cp_relic_combos.csv";
  var_953f521a64b4e2bb = [];

  for(entryindex = 1; entryindex <= 10; entryindex++) {
    sname = table_look_up(var_cab56b5d84a60595, entryindex, 1);

    if(sname == "") {
      continue;
    }

    var_953f521a64b4e2bb[entryindex - 1] = spawnStruct();
    var_953f521a64b4e2bb[entryindex - 1].scomboname = table_look_up(var_cab56b5d84a60595, entryindex, 1);
    var_953f521a64b4e2bb[entryindex - 1].srelicref1 = table_look_up(var_cab56b5d84a60595, entryindex, 2);
    var_953f521a64b4e2bb[entryindex - 1].srelicref2 = table_look_up(var_cab56b5d84a60595, entryindex, 3);
    var_953f521a64b4e2bb[entryindex - 1].srelicref3 = table_look_up(var_cab56b5d84a60595, entryindex, 4);
    var_953f521a64b4e2bb[entryindex - 1].srelicref4 = table_look_up(var_cab56b5d84a60595, entryindex, 5);
    var_953f521a64b4e2bb[entryindex - 1].srelicref5 = table_look_up(var_cab56b5d84a60595, entryindex, 6);
    var_953f521a64b4e2bb[entryindex - 1].srelicref6 = table_look_up(var_cab56b5d84a60595, entryindex, 7);
  }

  return var_953f521a64b4e2bb;
}

function table_look_up(table, index, target_column) {
  return tablelookup(table, 0, index, target_column);
}

function init_passive_random_attachment(player) {}

function set_passive_random_attachment(player) {}

function unset_passive_random_attachment(player) {}

function getweaponswithpassive(player, passive) {
  temparray = [];
  var_8c788f3a616d44b5 = getarraykeys(player.weapon_passives);

  foreach(key in var_8c788f3a616d44b5) {
    for(i = 0; i < player.weapon_passives[key].size; i++) {
      if(player.weapon_passives[key][i].name == passive) {
        temparray[temparray.size] = key;
      }
    }
  }

  temparray = array_remove_duplicates(temparray);
  return temparray;
}

function init_passive_fast_melee(player) {}

function set_passive_fast_melee(player) {
  player.increased_melee_damage = 150;
}

function unset_passive_fast_melee(player) {
  player.increased_melee_damage = undefined;
}

function init_extra_xp(player) {
  player.weapon_passive_xp_multiplier = 1;
  player.kill_with_extra_xp_passive = 0;
}

function set_extra_xp(player) {
  player.weapon_passive_xp_multiplier = 1.25;
}

function unset_extra_xp(player) {
  player.weapon_passive_xp_multiplier = 1;
  player.kill_with_extra_xp_passive = 0;
}

function init_passive_below_the_belt(player) {
  player.crotch_damage_multiplier = undefined;
}

function set_passive_below_the_belt(player) {
  player.crotch_damage_multiplier = 3.75;
}

function unset_passive_below_the_belt(player) {
  player.crotch_damage_multiplier = undefined;
}

function init_passive_move_speed(player) {
  player.weapon_passive_xp_multiplier = 1;
}

function set_passive_move_speed(player) {
  player.weaponpassivespeedmod = 0.05;
  player[[level.move_speed_scale]]();
}

function unset_passive_move_speed(player) {
  player.weaponpassivespeedmod = undefined;
  player[[level.move_speed_scale]]();
}

function init_passive_empty_reload_speed(player) {}

function set_passive_empty_reload_speed(player) {
  player _setperk("specialty_fastreload_empty");
}

function unset_passive_empty_reload_speed(player) {
  player _unsetperk("specialty_fastreload_empty");
}

function init_passive_increased_scope_breath(player) {}

function set_passive_increased_scope_breath(player) {
  player _setperk("specialty_holdbreath");
}

function unset_passive_increased_scope_breath(player) {
  player _unsetperk("specialty_holdbreath");
}

function init_snap_to_head(player) {}

function set_snap_to_head(player) {
  player _setperk("specialty_autoaimhead");
}

function unset_snap_to_head(player) {
  player _unsetperk("specialty_autoaimhead");
}

function init_passive_hunter_killer(player) {
  self.hunterkilleroutlines = 0;
}

function set_passive_hunter_killer(player) {
  self endon("passive_hunter_killer_cancel");
  enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  thread updatehunterkillerplayers(enemies);
  thread hunterkillerlistenforconnect();

  foreach(player in enemies) {
    thread hunterkillerlistenfordisconnect(player);
    thread hunterkillerlistenfordamage(player);
  }
}

function unset_passive_hunter_killer(player) {
  self notify("passive_hunter_killer_cancel");

  foreach(outlineid in self.hunterkillerids) {
    player = self.hunterkillerents[outlineid];
    scripts\cp\cp_outline::disable_outline_for_players(player, level.players);
  }

  self.hunterkillerids = undefined;
  self.hunterkillerents = undefined;
}

function updatehunterkillerplayers(players) {
  if(!isDefined(self.hunterkillerids)) {
    self.hunterkillerids = [];
  }

  if(!isDefined(self.hunterkillerents)) {
    self.hunterkillerents = [];
  }

  foreach(player in players) {
    if(player == self || !isDefined(self) || !isDefined(self.team) || !isDefined(player) || !isDefined(player.team)) {
      continue;
    }

    hunterkillerid = gethunterkillerid(player);

    if(level.teambased && self.team != player.team && player.health / player.maxhealth <= 0.5 && player.health > 0) {
      if(hunterkillerid < 0) {
        self.hunterkilleroutlines++;
        scripts\cp\cp_outline::enable_outline_for_player(player, self, "outline_nodepth_red", "high");
        outlineid = self.hunterkilleroutlines;
        self.hunterkillerids[self.hunterkillerids.size] = outlineid;
        self.hunterkillerents[outlineid] = player;
        thread hunterkillerlistenforhealth(player);
      }

      continue;
    }

    if(hunterkillerid >= 0) {
      var_66b9f9ade3955af2 = [];
      var_e9ba97c24dd424a = [];
      scripts\cp\cp_outline::disable_outline_for_player(player, self);

      foreach(outlineid in self.hunterkillerids) {
        ent = self.hunterkillerents[outlineid];

        if(ent == player) {
          continue;
        }

        var_66b9f9ade3955af2[var_66b9f9ade3955af2.size] = outlineid;
        var_e9ba97c24dd424a[outlineid] = ent;
      }

      self.hunterkillerids = var_66b9f9ade3955af2;
      self.hunterkillerents = var_e9ba97c24dd424a;
      player notify("passive_hunter_killer_listen_cancel");
    }
  }
}

function hunterkillerlistenforhealth(player) {
  self endon("passive_hunter_killer_cancel");
  player endon("passive_hunter_killer_listen_cancel");

  while(true) {
    wait 1;
    thread updatehunterkillerplayer(player);
  }
}

function gethunterkillerid(player) {
  if(!isDefined(self.hunterkillerids) || !isDefined(self.hunterkillerents)) {
    return -1;
  }

  foreach(outlineid in self.hunterkillerids) {
    ent = self.hunterkillerents[outlineid];

    if(!isDefined(ent)) {
      continue;
    }

    if(ent == player) {
      return outlineid;
    }
  }

  return -1;
}

function hunterkillerlistenforconnect() {
  self endon("passive_hunter_killer_cancel");

  while(true) {
    level waittill("agent_spawned", player);
    thread updatehunterkillerplayer(player);
    thread hunterkillerlistenfordamage(player);
  }
}

function hunterkillerlistenfordisconnect(player) {
  self endon("passive_hunter_killer_cancel");
  player waittill("disconnect");
  thread updatehunterkillerplayer(player);
}

function hunterkillerlistenfordamage(player) {
  self endon("passive_hunter_killer_cancel");

  while(true) {
    player waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, weapon);
    thread updatehunterkillerplayer(player);
  }
}

function updatehunterkillerplayer(player) {
  players = [];
  players[players.size] = player;
  thread updatehunterkillerplayers(players);
}

function init_passive_refresh(player) {
  player.nextpassiverefreshkills = 0;
}

function set_passive_refresh(player) {
  player.onkillrelics["passive_refresh"] = 1;
}

function unset_passive_refresh(player) {
  player.onkillrelics["passive_refresh"] = 0;
}

function handlepassiverefresh(sweapon, player, victim, smeansofdeath, shitloc, time) {
  player.nextpassiverefreshkills++;

  if(player.nextpassiverefreshkills >= 50) {
    if(isDefined(level.power_adjustcharges)) {
      player[[level.power_adjustcharges]](undefined, "primary", 1);
    }

    player.nextpassiverefreshkills = 0;
  }
}

function init_passive_double_kill_reload(player) {}

function set_passive_double_kill_reload(player) {
  player.onkillrelics["passive_double_kill_reload"] = 1;
}

function unset_passive_double_kill_reload(player) {
  player.onkillrelics["passive_double_kill_reload"] = 0;
}

function doublekillreloadwatcher(sweapon, player, victim, smeansofdeath, shitloc, time) {
  if(player.recentkillcount >= 4) {
    sweapon = player getcurrentweapon();
    maxclipammo = weaponclipsize(sweapon);
    var_afea921d82329afb = player getweaponammostock(sweapon);
    var_fb6da439a30039cd = player getweaponammoclip(sweapon);
    var_d7724e7657d45522 = min(maxclipammo - var_fb6da439a30039cd, var_afea921d82329afb);
    var_94d2e0ad0368ab91 = min(var_fb6da439a30039cd + var_d7724e7657d45522, maxclipammo);
    player setweaponammoclip(sweapon, int(var_94d2e0ad0368ab91));
    player setweaponammostock(sweapon, int(var_afea921d82329afb - var_d7724e7657d45522));

    if(player isdualwielding()) {
      var_afea921d82329afb = player getweaponammostock(sweapon);
      var_fb6da439a30039cd = player getweaponammoclip(sweapon, "left");
      var_d7724e7657d45522 = min(maxclipammo - var_fb6da439a30039cd, var_afea921d82329afb);
      var_94d2e0ad0368ab91 = min(var_fb6da439a30039cd + var_d7724e7657d45522, maxclipammo);
      player setweaponammoclip(sweapon, int(var_94d2e0ad0368ab91), "left");
      player setweaponammostock(sweapon, int(var_afea921d82329afb - var_d7724e7657d45522));
    }
  }
}

function init_passive_melee_kill(player) {
  player.passive_melee_kill_damage = 0;
}

function set_passive_melee_kill(player) {
  player.skip_weapon_check = 1;
  player.passive_melee_kill_damage = 1000;
  player.onkillrelics["passive_meleekill"] = 1;
}

function unset_passive_melee_kill(player) {
  player.skip_weapon_check = undefined;
  player.passive_melee_kill_damage = 0;
  player.onkillrelics["passive_meleekill"] = 0;
}

function handlemeleekillpassive(sweapon, player, victim, smeansofdeath, shitloc, time) {
  level endon("game_ended");
  self endon("disconnect");

  if(smeansofdeath != "MOD_MELEE") {
    return;
  }

  level thread handlegoreeffect(victim);
  wait 0.05;
  corpse = victim getcorpseentity();

  if(isDefined(corpse)) {
    corpse hide();
    corpse.permhidden = 1;
  }
}

function handlegoreeffect(victim) {
  position = victim gettagorigin("j_spine4");
  playFX(level._effect["gore"], position, (1, 0, 0));
  playsoundatpos(position, "gib_fullbody");

  foreach(player in level.players) {
    player earthquakeforplayer(0.5, 1.5, position, 120);
  }
}

function init_passive_gore(player) {}

function set_passive_gore(player) {
  player.onkillrelics["passive_gore"] = 1;
}

function unset_passive_gore(player) {
  player.onkillrelics["passive_gore"] = 0;
}

function handlegorepassive(sweapon, player, victim, smeansofdeath, shitloc, time) {
  level endon("game_ended");
  self endon("disconnect");
  victim endon("diconnect");
  wait 0.05;
  corpse = victim getcorpseentity();

  if(!isDefined(corpse)) {
    return;
  }

  corpseorigin = corpse.origin;
  earthquake(0.5, 1.5, corpseorigin, 120);
  playFX(level._effect["corpse_pop"], corpseorigin + (0, 0, 12));

  if(isDefined(corpse)) {
    corpse hide();
    corpse.permhidden = 1;
  }
}

function init_passive_health_on_kill(player) {
  player.passive_regen_on_kill_count = 0;
}

function set_passive_health_on_kill(player) {
  player.onkillrelics["passive_health_on_kill"] = 1;
}

function unset_passive_health_on_kill(player) {
  player.onkillrelics["passive_health_on_kill"] = 0;
}

function handlehealthonkillpassive(sweapon, player, victim, smeansofdeath, shitloc, time) {
  player.passive_regen_on_kill_count++;

  if(player.passive_regen_on_kill_count >= 2) {
    player notify("force_regeneration");
    player.passive_regen_on_kill_count = 0;
  }
}

function init_passive_health_regen_on_kill(player) {
  player.passive_regen_on_kill_count = 0;
}

function set_passive_health_regen_on_kill(player) {
  player.onkillrelics["passive_health_regen_on_kill"] = 1;
}

function unset_passive_health_regen_on_kill(player) {
  player.onkillrelics["passive_health_regen_on_kill"] = 0;
}

function handlehealthregenonkillpassive(sweapon, player, victim, smeansofdeath, shitloc, time) {
  if(player.passive_regen_on_kill_count >= 2) {
    player notify("force_regeneration");
    player.passive_regen_on_kill_count = 0;
    return;
  }

  player.passive_regen_on_kill_count++;
}

function init_passive_move_speed_on_kill(player) {
  player.weaponpassivespeedonkillmod = 0;
}

function set_passive_move_speed_on_kill(player) {
  player.onkillrelics["passive_move_speed_on_kill"] = 1;
}

function unset_passive_move_speed_on_kill(player) {
  player.onkillrelics["passive_move_speed_on_kill"] = 0;
}

function handlemovespeedonkillpassive(sweapon, player, victim, smeansofdeath, shitloc, time) {
  message = "passive_move_speed_on_kill";
  player notify(message);
  player endon(message);

  if(player.weaponpassivespeedonkillmod != 0.075) {
    player.weaponpassivespeedonkillmod = 0.075;
    player[[level.move_speed_scale]]();
  }

  player waittill_any_timeout_2(5, "death", "disconnect");

  if(!isDefined(player)) {
    return;
  }

  player.weaponpassivespeedonkillmod = 0;
  player[[level.move_speed_scale]]();
}

function init_passive_score_bonus_kills(player) {}

function set_passive_score_bonus_kills(player) {
  player.cash_scalar += 0.1;
  player.cash_scalar_weapon = getrawbaseweaponname(player getcurrentweapon());
}

function unset_passive_score_bonus_kills(player) {
  player.cash_scalar -= 0.1;
  player.cash_scalar_weapon = undefined;
}

function init_passive_hitman(player) {}

function set_passive_hitman(player) {
  player.onkillrelics["passive_hitman"] = 1;
}

function unset_passive_hitman(player) {
  player.onkillrelics["passive_hitman"] = 0;
}

function handlehitmanpassive(sweapon, attacker, victim, smeansofdeath, shitloc, time) {
  if(!isDefined(attacker) || !attacker scripts\cp_mp\utility\player_utility::_isalive() || !isDefined(victim)) {
    return;
  }

  if(!isDefined(attacker.hitmankills)) {
    attacker.hitmankills = [];
  } else if(hitmankeyexists(attacker, victim.birthtime)) {
    return;
  }

  attacker thread resethitmanaftertimeout();
  attacker.hitmankills[attacker.hitmankills.size] = victim.birthtime;

  if(attacker.hitmankills.size >= 10) {
    attacker notify("consumable_charge", 200);
    attacker.hitmankills = [];
  }
}

function resethitmanaftertimeout() {
  self notify("hitman_timeout");
  self endon("hitman_timeout");
  self endon("death");
  level endon("game_ended");
  wait 10;
  self.hitmankills = [];
}

function hitmankeyexists(attacker, key) {
  if(!isDefined(attacker.hitmankills)) {
    return false;
  }

  foreach(var_33ad9477b6d709ac in attacker.hitmankills) {
    if(var_33ad9477b6d709ac == key) {
      return true;
    }
  }

  return false;
}

function hitmanpassivedeathwatcher() {
  self endon("disconnect");
  self waittill("death");
  self.hitmankills = undefined;
}

function init_passive_nuke(player) {
  player.passivenukekillcount = 0;
  player.lastpassivenukeactivation = 0;
  player thread tracklaststandforpassivenuke(player);
}

function set_passive_nuke(player) {
  player.onkillrelics["passive_nuke"] = 1;
}

function unset_passive_nuke(player) {
  player.onkillrelics["passive_nuke"] = 0;
}

function trackkillsforpassivenuke(sweapon, player, victim, smeansofdeath, shitloc, time) {
  player.passivenukekillcount++;

  if(player.passivenukekillcount >= 3) {
    var_b19d10a33613ef12 = spawn("script_model", player.origin);
    var_b19d10a33613ef12 thread delayentdelete(10);
    enemies = scripts\cp\cp_agent_utils::getactiveenemyagents("allies");
    amount = 0;

    foreach(guy in enemies) {
      guy kill();
    }

    player.passivenukekillcount = 0;
  }
}

function tracklaststandforpassivenuke(player) {
  level endon("game_ended");
  player endon("disconnect");

  while(true) {
    player waittill("last_stand");
    player.passivenukekillcount = 0;
  }
}

function init_headshot_ammo(player) {}

function set_headshot_ammo(player) {
  player.onkillrelics["passive_headshot_ammo"] = 1;
}

function unset_headshot_ammo(player) {
  player.onkillrelics["passive_headshot_ammo"] = 0;
}

function handleheadshotammopassive(sweapon, player, victim, smeansofdeath, shitloc, time) {
  if(!isDefined(player) || !isDefined(sweapon)) {
    return;
  }

  if(!isheadshot(sweapon, shitloc, smeansofdeath, player)) {
    return;
  }

  maxclipammo = weaponclipsize(sweapon);
  adjust_clip_ammo_from_stock(player, sweapon, "right", maxclipammo);

  if(player isdualwielding()) {
    adjust_clip_ammo_from_stock(player, sweapon, "left", maxclipammo);
  }
}

function adjust_clip_ammo_from_stock(player, sweapon, hand, maxclipammo) {
  currentstock = player getweaponammostock(sweapon);

  if(currentstock < 1) {
    return;
  }

  currammo = player getweaponammoclip(sweapon, hand);
  difference = maxclipammo - currammo;

  if(currentstock >= difference) {
    player setweaponammostock(sweapon, currentstock - difference);
  } else {
    difference = currentstock;
    player setweaponammostock(sweapon, 0);
  }

  newammo = min(currammo + difference, maxclipammo);
  player setweaponammoclip(sweapon, int(newammo), hand);
}

function init_passive_fortified(player) {
  player.has_fortified_passive = 0;
}

function set_passive_fortified(player) {
  player.persistentrelics["passive_fortified"] = 1;
  player.has_fortified_passive = 1;
}

function unset_passive_fortified(player) {
  player.persistentrelics["passive_fortified"] = 0;
  player.has_fortified_passive = 0;
}

function handlefortified(player, sweapon, victim) {}

function init_passive_ninja(player) {}

function set_passive_ninja(player) {
  player.persistentrelics["passive_ninja"] = 1;
}

function unset_passive_ninja(player) {
  player.persistentrelics["passive_ninja"] = 0;
}

function handleninjaonlastshot(player, sweapon, victim) {
  if(!isDefined(player) || !isDefined(sweapon)) {
    return;
  }

  maxclipammo = weaponclipsize(sweapon);
  var_4f39f1d30e0a5d4b = player getweaponammoclip(sweapon, "right");

  if(var_4f39f1d30e0a5d4b == 0) {
    player thread set_player_stealthed();
  }

  if(var_4f39f1d30e0a5d4b == 0 && !array_contains(player.stealth_used, "right")) {
    player thread set_player_stealthed();
  } else if(var_4f39f1d30e0a5d4b > 0) {
    player.stealth_used = array_remove(player.stealth_used, "right");
  }

  if(player isdualwielding()) {
    var_5f1e64f3e8613c52 = player getweaponammoclip(sweapon, "left");

    if(var_5f1e64f3e8613c52 == 0 && !array_contains(player.stealth_used, "left")) {
      player thread set_player_stealthed();
      return;
    }

    if(var_5f1e64f3e8613c52 > 0) {
      player.stealth_used = array_remove(player.stealth_used, "left");
    }
  }
}

function set_player_stealthed() {
  self notify("reset_stealth");
  self endon("reset_stealth");
  self endon("disconnect");

  if(!isignoremeenabled()) {
    allow_player_ignore_me(1);
  }

  playFX(level._effect["stimulus_glow_burst"], drop_to_ground(self.origin) - (0, 0, 30));
  play_sound_in_space("zmb_fnf_stimulus", drop_to_ground(self.origin));

  if(self isdualwielding()) {
    wait 3;
  } else {
    wait 4;
  }

  if(isignoremeenabled()) {
    allow_player_ignore_me(0);
  }
}

function init_passive_last_shots_ammo(player) {}

function set_passive_last_shots_ammo(player) {
  player.onkillrelics["passive_last_shots_ammo"] = 1;
}

function unset_passive_last_shots_ammo(player) {
  player.onkillrelics["passive_last_shots_ammo"] = 0;
}

function handleammoonlastshotskill(sweapon, player, victim, smeansofdeath, shitloc, time) {
  if(!isDefined(player) || !isDefined(sweapon)) {
    return;
  }

  maxclipammo = weaponclipsize(sweapon);
  currammo = player getweaponammoclip(sweapon, "right");

  if(currammo <= int(maxclipammo * 0.2)) {
    adjust_clip_ammo_from_stock(player, sweapon, "right", maxclipammo);
  }

  if(player isdualwielding()) {
    currammo = player getweaponammoclip(sweapon, "left");

    if(currammo <= int(maxclipammo * 0.2)) {
      adjust_clip_ammo_from_stock(player, sweapon, "left", maxclipammo);
    }
  }
}

function init_passive_railgun_overload(player) {}

function set_passive_railgun_overload(player) {
  player.onkillrelics["passive_railgun_overload"] = 1;
}

function unset_passive_railgun_overload(player) {
  player.onkillrelics["passive_railgun_overload"] = 0;
}

function dolocalrailgundamage(sweapon, player, victim, smeansofdeath, shitloc, time) {
  if(!isDefined(victim.hitbychargedshot)) {
    return 0;
  }

  if(!isbulletdamage(smeansofdeath)) {
    return 0;
  }

  if(isDefined(victim.agent_type) && (victim.agent_type == "zombie_brute" || victim.agent_type == "zombie_grey" || victim.agent_type == "slasher" || victim.agent_type == "superslasher" || victim.agent_type == "zombie_sasquatch" || victim.agent_type == "lumberjack")) {
    return;
  }

  var_5e5c37fced1bb8b = istrue(victim.is_suicide_bomber);
  victim.head_is_exploding = 1;
  org = victim gettagorigin("j_spine4");
  playsoundatpos(victim.origin, "zmb_fnf_headpopper_explo");
  playFX(level._effect["bloody_death"], org);

  if(isDefined(victim.headmodel)) {
    victim detach(victim.headmodel);
  }

  if(!var_5e5c37fced1bb8b) {
    victim setscriptablepartstate("head", "hide");
  }

  victim.hitbychargedshot radiusdamage(victim.origin, 64, victim.maxhealth, victim.maxhealth, victim.hitbychargedshot, "MOD_EXPLOSIVE", "iw7_zombieDoors_zm");
  victim.hitbychargedshot = undefined;
}

function init_headshot_super(player) {
  player.delayedsuperbonus = 0;
}

function set_headshot_super(player) {
  player.onkillrelics["passive_headshot_super"] = 1;
}

function unset_headshot_super(player) {
  player.onkillrelics["passive_headshot_super"] = 0;
}

function addvaluetocardmeter(sweapon, player, victim, smeansofdeath, shitloc, time) {
  player.delayedsuperbonus++;
  wait 0.05 * player.delayedsuperbonus;
  player.delayedsuperbonus--;

  if(player.delayedsuperbonus < 0) {
    player.delayedsuperbonus = 0;
  }

  player notify("consumable_charge", 10);
}

function init_passive_sonic(player) {
  player.sonictimer = 0;
}

function set_passive_sonic(player) {
  player.ondamagerelics["passive_sonic"] = 1;
}

function unset_passive_sonic(player) {
  player.ondamagerelics["passive_sonic"] = 0;
}

function handlepassivesonic(player, weapon, victim) {
  time = gettime();

  if(victim agentisfnfimmune()) {
    return;
  }

  if(time <= player.sonictimer) {
    return;
  }

  if(distance2dsquared(player.origin, victim.origin) <= 62500) {
    thread scripts\cp\weapon::fx_stun_damage(victim, player);
  }

  player.sonictimer = time + 1000;
}

function init_passive_crouch_move_speed(player) {}

function set_passive_crouch_move_speed(player) {
  player thread adjust_move_speed_while_crouched(player);
  player thread adjust_move_speed_while_sliding(player);
}

function unset_passive_crouch_move_speed(player) {
  player notify("remove_crouch_speed_mod");
  player.weaponpassivespeedmod = undefined;
}

function adjust_move_speed_while_sliding(player) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("remove_crouch_speed_mod");

  while(true) {
    self waittill("sprint_slide_end");

    if(player getstance() == "crouch") {
      if(isDefined(level.move_speed_scale)) {
        player.weaponpassivespeedmod = 0.5;
        player[[level.move_speed_scale]]();
      }
    }

    while(player getstance() == "crouch") {
      wait 0.1;
    }

    player.weaponpassivespeedmod = undefined;
    player[[level.move_speed_scale]]();
  }
}

function adjust_move_speed_while_crouched(player, weapon) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("remove_crouch_speed_mod");

  while(true) {
    if(player getstance() == "crouch") {
      if(isDefined(level.move_speed_scale)) {
        player.weaponpassivespeedmod = 0.5;
        player[[level.move_speed_scale]]();
      }
    }

    while(player getstance() == "crouch") {
      wait 0.1;
    }

    player.weaponpassivespeedmod = undefined;
    player[[level.move_speed_scale]]();
    player waittill("adjustedStance");
  }
}

function init_passive_infinite_ammo(player) {}

function set_passive_infinite_ammo(player) {
  player scripts\cp\utility::enable_infinite_ammo(1);
  player.persistentrelics["passive_infinite_ammo"] = 1;
}

function unset_passive_infinite_ammo(player) {
  player scripts\cp\utility::enable_infinite_ammo(0);
  player.persistentrelics["passive_infinite_ammo"] = 0;
  player notify("cleanup_watcher_threads_" + "passive_infinite_ammo");
}

function handleinfiniteammopassive(player, weapon) {
  player endon("disconnect");
  player endon("cleanup_watcher_threads_" + "passive_infinite_ammo");

  while(true) {
    player waittill("weapon_fired", objweapon);
    player thread listenforfirecomplete();
    cost = 4;
    ammo = self.health;

    if(ammo - cost < 1) {
      cost = 0;
    }

    if(cost > 0) {
      player dodamage(cost, player gettagorigin("j_wrist_ri"), player, undefined, "MOD_RIFLE_BULLET");
    }

    player updateinfiniteammopassive(objweapon);
  }
}

function listenforfirecomplete() {
  self endon("disconnect");
  self endon("last_stand");
  self notify("infinite_ammo_fire");
  self endon("infinite_ammo_fire");
  self.selfdamaging = 1;
  wait 0.2;
  self.selfdamaging = 0;
}

function updateinfiniteammopassive(weapon) {
  ammo = self.health;
  var_f543b5b38d564a8c = weaponclipsize(weapon);
  self setweaponammoclip(weapon, var_f543b5b38d564a8c);

  if(self isdualwielding()) {
    self setweaponammoclip(weapon, var_f543b5b38d564a8c, "left");
  }
}

function init_passive_miss_refund(player) {}

function set_passive_miss_refund(player) {
  weapon = player getcurrentweapon();
  player thread missrefundwatcher(weapon);
}

function unset_passive_miss_refund(player) {
  player notify("removeMissRefundPassive");
}

function missrefundwatcher(weapon) {
  assert(isweapon(weapon));
  self endon("death");
  self endon("disconnect");
  self endon("removeMissRefundPassive");

  while(true) {
    self waittill("shot_missed", objweapon);

    if(objweapon == weapon) {
      if(randomfloat(1) > 0.75) {
        var_afea921d82329afb = self getweaponammostock(weapon);
        self setweaponammostock(weapon, var_afea921d82329afb + 1);
      }
    }
  }
}

function init_passive_scrambler(player) {}

function set_passive_scrambler(player) {
  player thread handlepassivescrambler(player);
}

function unset_passive_scrambler(player) {
  player notify("handlePassiveScrambler");
}

function scrambler_executevisuals(ispeed) {
  level endon("game_ended");
  self endon("disconnect");
  fxent = spawn("script_model", self gettagorigin("tag_eye"));
  fxent setModel("prop_mp_optic_wave_scr");
  fxent.angles = self getplayerangles();
  fxent setotherent(self);
  fxent setscriptablepartstate("effects", "active", 0);
  endpoint = fxent.origin + anglesToForward(fxent.angles) * 256;
  fxent moveTo(endpoint, ispeed);
  waittill_any_timeout_2(ispeed, "last_stand", "death");

  if(isDefined(fxent)) {
    fxent delete();
  }
}

function handlepassivescrambler(player) {
  player notify("handlePassiveScrambler");
  player endon("handlePassiveScrambler");
  level endon("game_ended");
  player endon("disconnect");
  player endon("last_stand");
  player endon("death");

  while(true) {
    if(randomint(100) > 85) {
      enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
      closestenemies = get_array_of_closest(player.origin, enemies, undefined, 24, 256);
      count = 0;

      foreach(victim in closestenemies) {
        if(within_fov(player getEye(), player.angles, victim.origin, cos(65))) {
          if(!count) {
            player thread scrambler_executevisuals(0.8);
          }

          thread scrambler_stun_damage(victim, player);
          count++;
        }

        if(count >= 5) {
          break;
        }
      }
    }

    wait randomfloatrange(5, 10);
  }
}

function scrambler_stun_damage(victim, eattacker) {
  victim endon("death");

  if(isDefined(victim.stun_hit_time)) {
    if(gettime() > victim.stun_hit_time) {
      victim.allowpain = 1;
      victim.stun_hit_time = gettime() + 1000;
      victim.stunned = 1;
    } else {
      return;
    }
  } else {
    victim.allowpain = 1;
    victim.stun_hit_time = gettime() + 1000;
    victim.stunned = 1;
  }

  victim dodamage(1, victim.origin, eattacker, eattacker, "MOD_UNKNOWN", "iw7_scrambler_zm");
  victim thread addhealthback(victim);
  wait 1;
  victim.allowpain = 0;
  victim.stunned = undefined;
}

function addhealthback(victim) {
  victim endon("death");
  waittillframeend();

  if(victim.health < victim.maxhealth) {
    victim.health += 1;
  }
}

function init_passive_random_perks(player) {
  player.passiverandomperkskillcount = 0;
  player thread tracklaststandforpassiverandomperks(player);
}

function tracklaststandforpassiverandomperks(player) {
  level endon("game_ended");
  player endon("disconnect");

  while(true) {
    player waittill("last_stand");
    player.passiverandomperkskillcount = 0;
  }
}

function set_passive_random_perks(player) {
  player.onkillrelics["passive_random_perks"] = 1;
}

function trackkillsforrandomperks(sweapon, player, victim, smeansofdeath, shitloc, time) {
  player endon("disconnect");
  player endon("last_stand");
  player endon("death");
  player.passiverandomperkskillcount++;

  if(player.passiverandomperkskillcount >= 75) {
    var_b2fea2a31fb0c516 = level.perks;
    player.passiverandomperkskillcount = 0;

    if(!isDefined(player.zombies_perks) || player.zombies_perks.size < 5) {
      while(true) {
        perk = random(var_b2fea2a31fb0c516);

        if(!player has_zombie_perk(perk)) {
          player iprintln(" zombies_perk_machines is disabled for now!. Can be reenabled based on requirements. ");
          break;
        } else {
          var_b2fea2a31fb0c516 = array_remove(var_b2fea2a31fb0c516, perk);
        }

        waitframe();
      }
    }
  }
}

function unset_passive_random_perks(player) {
  player.onkillrelics["passive_random_perks"] = 0;
}

function init_passive_melee_super(player) {}

function set_passive_melee_super(player) {
  player.skip_weapon_check = 1;
  player.onkillrelics["passive_melee_super"] = 1;
}

function unset_passive_melee_super(player) {
  player.skip_weapon_check = undefined;
  player.onkillrelics["passive_melee_super"] = 0;
}

function handlemeleesuper(sweapon, player, victim, smeansofdeath, shitloc, time) {
  level endon("game_ended");
  player endon("disconnect");

  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_MELEE") {
    player notify("consumable_charge", 125);
  }
}

function init_passive_jump_super(player) {}

function set_passive_jump_super(player) {
  player.onkillrelics["passive_jump_super"] = 1;
  player.current_weapon_jump_super = getrawbaseweaponname(player getcurrentweapon());
}

function unset_passive_jump_super(player) {
  player.onkillrelics["passive_jump_super"] = 0;
  player.current_weapon_jump_super = undefined;
}

function handleairbornesuper(sweapon, player, victim, smeansofdeath, shitloc, time) {
  level endon("game_ended");
  player endon("disconnect");

  if(!player isonground() && isDefined(player.current_weapon_jump_super) && getrawbaseweaponname(sweapon) == player.current_weapon_jump_super) {
    player notify("consumable_charge", 75);
  }
}

function init_passive_double_kill_super(player) {}

function set_passive_double_kill_super(player) {
  player.onkillrelics["passive_double_kill_super"] = 1;
  player.current_weapon_double_super = getrawbaseweaponname(player getcurrentweapon());
}

function unset_passive_double_kill_super(player) {
  player.onkillrelics["passive_double_kill_super"] = 0;
  player.current_weapon_double_super = undefined;
}

function handledoublekillssuper(sweapon, player, victim, smeansofdeath, shitloc, time) {
  level endon("game_ended");
  player endon("disconnect");

  if(isDefined(player.recentkillcount) && isDefined(player.current_weapon_double_super) && getrawbaseweaponname(sweapon) == player.current_weapon_double_super) {
    if(player.recentkillcount == 2) {
      player notify("consumable_charge", 125);
    }
  }
}

function init_passive_mode_switch_score(player) {}

function set_passive_mode_switch_score(player) {
  player.alt_mode_passive = 1;
  player.cash_scalar_alt_weapon = getrawbaseweaponname(player getcurrentweapon());
  player.cash_scalar += 0.1;
}

function unset_passive_mode_switch_score(player) {
  player.cash_scalar -= 0.1;
  player.cash_scalar_alt_weapon = undefined;
  player.alt_mode_passive = 0;
}

function init_passive_visor_detonation(player) {}

function set_passive_visor_detonation(player) {
  player.onkillrelics["passive_visor_detonation"] = 1;
}

function unset_passive_visor_detonation(player) {
  player.onkillrelics["passive_visor_detonation"] = 0;
}

function handlevisordetonation(sweapon, player, victim, smeansofdeath, shitloc, time) {
  if(!isbulletdamage(smeansofdeath)) {
    return 0;
  }

  if(!isheadshot(sweapon, shitloc, smeansofdeath, player)) {
    return 0;
  }

  if(isDefined(victim.agent_type) && (victim.agent_type == "zombie_brute" || victim.agent_type == "zombie_grey" || victim.agent_type == "slasher" || victim.agent_type == "superslasher" || victim.agent_type == "zombie_sasquatch" || victim.agent_type == "lumberjack")) {
    return;
  }

  var_5e5c37fced1bb8b = istrue(victim.is_suicide_bomber);
  victim.head_is_exploding = 1;
  org = victim gettagorigin("j_spine4");
  playsoundatpos(victim.origin, "zmb_fnf_headpopper_explo");
  playFX(level._effect["bloody_death"], org);

  if(isDefined(victim.headmodel)) {
    victim detach(victim.headmodel);
  }

  if(!var_5e5c37fced1bb8b) {
    victim setscriptablepartstate("head", "hide");
  }
}

function passive_visor_detonation_activate() {
  self endon("death");
  self endon("disconnect");
  self endon("end_passive_visor_detonation");

  while(true) {
    self waittill("headshot_done_with_this_weapon", victim, einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, vpoint);
    waitframe();
  }
}

function init_passive_berserk(player) {}

function set_passive_berserk(player) {
  player.onkillrelics["passive_berserk"] = 1;
}

function unset_passive_berserk(player) {
  player.onkillrelics["passive_berserk"] = 0;
}

function handleberserk(sweapon, player, victim, smeansofdeath, shitloc, time) {
  if(!istrue(player.berserk)) {
    player.berserk = 1;
    player setfiretimescaleon(65);
    recoilscale = player player_getrecoilscale();

    if(recoilscale < 0) {
      recoilscale = 100;
    }

    recoilscale = max(recoilscale - 20, 0);
    player player_recoilscaleon(int(recoilscale));
  }

  player notify("stop_berserk_timer");
  player thread remove_berserk_after_timeout(2);
}

function remove_berserk_after_timeout(duration) {
  self endon("end_berserk");
  self endon("stop_berserk_timer");
  self endon("death");
  self endon("disconnect");
  thread listencancelberserk();
  wait duration;
  unset_berserk();
}

function listencancelberserk() {
  self endon("end_berserk");
  self endon("stop_berserk_timer");
  self endon("disconnect");
  waittill_any_2("death", "weapon_change");
  unset_berserk();
}

function unset_berserk() {
  if(istrue(self.berserk)) {
    self.berserk = 0;
    self setfiretimescaleoff();
    recoilscale = self player_getrecoilscale();
    recoilscale = min(recoilscale + 20, 100);
    self player_recoilscaleon(int(recoilscale));
    self notify("end_berserk");
  }
}

function unsetquadfeederpassive() {
  self notify("end_quadFeederEffect");
  self notify("end_quadFeederPassive");
  unset_berserk();
}

function init_passive_melee_cone_expl(player) {}

function set_passive_melee_cone_expl(player) {
  player.onkillrelics["passive_melee_cone_expl"] = 1;
  player.skip_weapon_check = 1;
}

function unset_passive_melee_cone_expl(player) {
  player.onkillrelics["passive_melee_cone_expl"] = 0;
  player.skip_weapon_check = undefined;
}

function handlemeleeconeexplode(sweapon, player, victim, smeansofdeath, shitloc, time) {
  if(smeansofdeath != "MOD_MELEE") {
    return;
  }

  if(!issubstr(sweapon, "meleervn") && !player isalternatemode(sweapon)) {
    return;
  }

  var_268c78654c980d1e = victim gettagorigin("j_spineupper");
  var_cc29543de9737588 = player getplayerangles();
  var_e566ea808842fd75 = anglesToForward(var_cc29543de9737588);
  var_a62e5218de1622b5 = anglestoup(var_cc29543de9737588);
  var_54dca92a8a182ec0 = var_268c78654c980d1e - var_e566ea808842fd75 * 128;
  var_833622e497a25855 = 384;
  playFX(level._effect["cone_expl_fx"], var_268c78654c980d1e + (0, 2, 0), var_e566ea808842fd75, var_a62e5218de1622b5);
  zombies = scripts\cp\cp_agent_utils::get_alive_enemies();

  foreach(zombie in zombies) {
    if(isDefined(zombie.flung) || isDefined(zombie.agent_type) && (zombie.agent_type == "zombie_brute" || zombie.agent_type == "zombie_ghost" || zombie.agent_type == "zombie_grey" || zombie.agent_type == "slasher" || zombie.agent_type == "superslasher")) {
      continue;
    }

    if(!pointvscone(zombie gettagorigin("tag_origin"), var_54dca92a8a182ec0, var_e566ea808842fd75, var_a62e5218de1622b5, var_833622e497a25855, 128, 12)) {
      continue;
    }

    if(zombie damageconetrace(var_268c78654c980d1e, player) <= 0) {
      continue;
    }

    damage = int(1500 * player scripts\cp\weapon::get_weapon_level(sweapon));
    wait 0.05;
    zombie dodamage(damage, var_268c78654c980d1e, player, player, "MOD_EXPLOSIVE", sweapon);
  }
}

function init_passive_minimap_damage(player) {}

function set_passive_minimap_damage(player) {
  player.ondamagerelics["passive_minimap_damage"] = 1;
}

function unset_passive_minimap_damage(player) {
  player.ondamagerelics["passive_minimap_damage"] = 0;
}

function updatepassiveminimapdamage(player, weapon, victim) {
  if(!isDefined(victim)) {
    return;
  }

  hudoutlineassetname = "outlinefill_depth_orange";

  if(isDefined(victim.var_91a6849f0ee39fe7)) {
    hudoutlineassetname = "<dev string:x1c>";
  }

  if(isDefined(victim.damaged_by_players)) {
    hudoutlineassetname = "outlinefill_depth_yellow";
  }

  if(isDefined(victim.marked_for_challenge)) {
    hudoutlineassetname = "outlinefill_depth_white";
  } else {
    hudoutlineassetname = "outlinefill_depth_orange";
  }

  level thread set_outline_passive_minimap_damage(player, victim, hudoutlineassetname);
}

function enable_outline_for_players(item, players, hudoutlineassetname, priority) {
  item hudoutlineenableforclients(players, hudoutlineassetname);
}

function set_outline_passive_minimap_damage(player, victim, hudoutlineassetname) {
  level endon("game_ended");
  level endon("outline_disabled");

  if(!isDefined(victim)) {
    return;
  }

  if(!isDefined(hudoutlineassetname)) {
    hudoutlineassetname = "outlinefill_depth_orange";
  }

  enable_outline_for_players(victim, level.players, hudoutlineassetname, "high");
  wait 10;
  unset_outline_passive_minimap_damage(victim);
}

function disable_outline_for_players(item, players) {
  item hudoutlinedisableforclients(players);
}

function unset_outline_passive_minimap_damage(victim) {
  if(!isDefined(victim)) {
    return;
  }

  scripts\cp\cp_outline::disable_outline_for_players(victim, level.players);
}

function activate_adrenaline_boost(player) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("last_stand");
  player endon("death");
  player adddamagemodifier("health_boost", 0.2, 0);
  player notify("force_regeneration");
  player playlocalsound("breathing_heartbeat_alt");
  wait 5;
  player removedamagemodifier("health_boost", 0);
  player playlocalsound("breathing_limp");
}

function adr_boost(player) {
  player notify("updatepassiveminimapdamage");
  level endon("game_ended");
  player endon("disconnect");
  player endon("last_stand");
  player endon("death");

  while(true) {
    if(randomint(100) > 30) {
      thread run_adrenaline_visuals(player, 5);
      thread activate_adrenaline_boost(player);
    }

    wait randomfloatrange(5, 15);
  }
}

function remove_adrenaline_visuals(player) {
  player endon("disconnect");
  player endon("last_stand");
  player endon("death");
  player visionsetnakedforplayer("", 0.5);
}

function run_adrenaline_visuals(player, ispeed) {
  player endon("disconnect");
  player endon("last_stand");
  player endon("death");
  player endon("remove_adrenaline_visuals");
  player visionsetnakedforplayer("missilecam", ter_op(1, 0.1, 0));
  player waittill_any_timeout_1(ispeed, "last_stand");
  player thread remove_adrenaline_visuals(player);
}

function init_passive_cold_damage(player) {}

function set_passive_cold_damage(player) {
  player.ondamagerelics["passive_cold_damage"] = 1;
  player.cold_weapon = player getcurrentweapon();
}

function unset_passive_cold_damage(player) {
  player.ondamagerelics["passive_cold_damage"] = 0;
  player.cold_weapon = undefined;
}

function updatepassivecolddamage(player, weapon, victim) {
  var_7d843ccedd2761f7 = isDefined(victim.agent_type) && victim.agent_type == "zombie_brute";
  var_bff0ef8c04d32552 = isDefined(victim.agent_type) && victim.agent_type == "zombie_grey";
  isexploder = istrue(victim.is_suicide_bomber);

  if(var_7d843ccedd2761f7 || var_bff0ef8c04d32552 || isexploder) {
    return;
  }

  if(isDefined(player.cold_weapon)) {
    if(getrawbaseweaponname(player.cold_weapon) == getrawbaseweaponname(weapon)) {
      victim thread unsetslowmovementaftertime(victim, victim.movemode);
      victim.movemode = "slow_walk";
      victim scripts\asm\asm_bb::bb_requestmovetype("slow_walk");
    }
  }
}

function unsetslowmovementaftertime(victim, var_a29497b5a1296685) {
  level endon("game_ended");
  victim endon("death");
  wait 10;

  if(isDefined(var_a29497b5a1296685)) {
    victim.movemode = var_a29497b5a1296685;
    victim scripts\asm\asm_bb::bb_requestmovetype(var_a29497b5a1296685);
  }
}

function init_passive_scorestreak_damage(player) {}

function set_passive_scorestreak_damage(player) {
  player.special_zombie_damage = 1.1;
}

function unset_passive_scorestreak_damage(player) {
  player.special_zombie_damage = undefined;
}

function init_passive_scope_radar(player) {
  player.activate_radar = 0;
  player notifyonplayercommand("scope_radar_ads_in", "+speed_throw");
  player notifyonplayercommand("scope_radar_ads_out", "-speed_throw");
}

function set_passive_scope_radar(player) {
  player thread updatescoperadar(player);
}

function unset_passive_scope_radar(player) {
  player notify("unsetScopeRadar");
  player thread cleanup_outlines(player);
}

function updatescoperadar(player) {
  player notify("updateScopeRadar");
  player endon("updateScopeRadar");
  level endon("game_ended");
  player endon("death");
  player endon("disconnect");
  player endon("unsetScopeRadar");
  ispeed = 2.4;
  iradius = 1750;

  while(true) {
    if(!player adsButtonPressed()) {
      result = player waittill_any_return_no_endon_death_5("scope_radar_ads_in", "scope_radar_ads_out", "last_stand", "death", "weapon_change");
    } else {
      result = "scope_radar_ads_in";
    }

    if(result == "scope_radar_ads_in") {
      if(player isnightvisionon()) {
        runscoperadarinloop(player, ispeed, iradius);
      } else {
        waitframe();
      }
    }

    player thread remove_visuals(player);
  }
}

function runscoperadarinloop(player, ispeed, iradius) {
  level endon("game_ended");
  player notify("runScopeRadarInLoop");
  player endon("runScopeRadarInLoop");
  player endon("scope_radar_ads_out");
  player endon("last_stand");
  player endon("death");
  player endon("disconnect");
  var_ec415c373fbb512 = 0.75;

  if(getDvar(@ "hash_b746d2ac592a572a", "<dev string:x32>") != "<dev string:x32>") {
    var_ec415c373fbb512 = float(getDvar(@ "hash_b746d2ac592a572a"));
  }

  while(player adsButtonPressed()) {
    if(player playerads() >= var_ec415c373fbb512) {
      player playlocalsound("uav_ping");
      triggerportableradarping(player.origin, player, 1080, 500);
      player thread scoperadar_executeping(player, ispeed, iradius);
      player scoperadar_executevisuals(player, ispeed);
    }

    waitframe();
  }
}

function scoperadar_executeping(player, ispeed, iradius) {
  level endon("game_ended");
  player endon("death");
  player endon("scope_radar_ads_out");
  hit = 0;
  enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  closestenemies = get_array_of_closest(player.origin, enemies, undefined, 24, iradius);
  player.closestenemies = closestenemies;
  count = 0;

  foreach(victim in player.closestenemies) {
    victim.is_outlined_from_scoperadar = 0;

    if(within_fov(player getEye(), player.angles, victim.origin, cos(65))) {
      count++;
      btwn = victim.origin - player.origin;

      if(1 && vectordot(anglesToForward(player.angles), btwn) < 0) {
        continue;
      }

      radiussqr = iradius * iradius;

      if(length2dsquared(btwn) > radiussqr) {
        continue;
      }

      player thread outlineplayerbydistance(victim, player, distance2d(player.origin, victim.origin) / iradius, ispeed);
      hit = 1;
    }
  }
}

function enable_outline_for_player(item, player, hudoutlineassetname, priority) {
  item hudoutlineenableforclient(player, hudoutlineassetname);
}

function outlineplayerbydistance(victim, player, delay, ispeed) {
  level endon("game_ended");
  player endon("scope_radar_ads_out");
  player endon("last_stand");
  player endon("death");
  player endon("disconnect");
  player endon("weapon_change");
  wait ispeed * delay;
  color = 1;
  victim.is_outlined_from_scoperadar = 1;
  enable_outline_for_player(victim, player, "snapshotgrenade", "high");
}

function watchhighlightfadetime(player, ent, time) {
  player endon("disconnect");
  level endon("game_ended");
  player waittill_any_timeout_no_endon_death_1(time);

  if(isDefined(ent)) {
    disable_outline_for_player(ent, player);
  }
}

function disable_outline_for_player(item, player) {
  item hudoutlinedisableforclient(player);
}

function scoperadar_executevisuals(player, ispeed) {
  level endon("game_ended");
  player endon("disconnect");
  player waittill_any_timeout_no_endon_death_5(ispeed, "last_stand", "death", "scope_radar_ads_out", "weapon_change", "unsetScopeRadar");

  if(isDefined(player.closestenemies)) {
    foreach(victim in player.closestenemies) {
      if(isDefined(victim)) {
        if(istrue(victim.is_outlined_from_scoperadar)) {
          disable_outline_for_player(victim, player);
          victim.is_outlined_from_scoperadar = 0;
        }
      }
    }
  }
}

function remove_visuals(player) {
  enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(victim in enemies) {
    if(isDefined(victim)) {
      if(istrue(victim.is_outlined_from_scoperadar)) {
        disable_outline_for_player(victim, player);
        victim.is_outlined_from_scoperadar = 0;
      }
    }
  }

  if(isDefined(player.fxent)) {
    player.fxent delete();
  }
}

function cleanup_outlines(player) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("last_stand");
  player endon("death");
  enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(victim in enemies) {
    if(isDefined(victim)) {
      if(istrue(victim.is_outlined_from_scoperadar)) {
        disable_outline_for_player(victim, player);
        victim.is_outlined_from_scoperadar = 0;
      }
    }
  }
}

function init_passive_scoutping(player) {}

function set_passive_scoutping(player) {
  player thread updatescoutping(player);
}

function unset_passive_scoutping(player) {
  player notify("unsetScoutPing");
}

function updatescoutping(player) {
  player endon("death");
  player endon("disconnect");
  player endon("unsetScoutPing");
  baseradius = 1000;
  var_b45893c03493d1f5 = 0.1;

  while(true) {
    enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    pingradius = baseradius;
    var_ff9d6502d5d4dc7a = var_b45893c03493d1f5;
    pingradius = int(pingradius);
    var_ff9d6502d5d4dc7a = float(var_ff9d6502d5d4dc7a);

    if(isDefined(enemies)) {
      closestenemies = get_array_of_closest(player.origin, enemies, undefined, 24, pingradius);
    } else {
      waitframe();
      continue;
    }

    if(closestenemies.size >= 1) {
      foreach(guy in closestenemies) {
        scripts\cp\cp_outline::enable_outline_for_players(guy, level.players, "outline_nodepth_red", "low");
        wait var_ff9d6502d5d4dc7a;
      }

      continue;
    }

    waitframe();
  }
}

function updateonkillrelics(sweapon, player, victim, smeansofdeath, shitloc) {
  if(!isDefined(player.onkillrelics)) {
    return;
  }

  time = gettime();
  keys = getarraykeys(player.onkillrelics);

  if(!isDefined(keys)) {
    return;
  }

  foreach(key in keys) {
    if(istrue(player.onkillrelics[key])) {
      thread[[level.onkillrelics[key]]](sweapon, player, victim, smeansofdeath, shitloc, time);
    }
  }
}

function updatepersistentrelics(player) {
  if(!isDefined(player.persistentrelics)) {
    return;
  }

  time = gettime();
  keys = getarraykeys(player.persistentrelics);

  if(!isDefined(keys)) {
    return;
  }

  foreach(key in keys) {
    if(istrue(player.persistentrelics[key])) {
      player thread[[level.persistentrelics[key]]](player);
    }
  }
}

function updateondamagerelics(player, weapon, victim, smeansofdeath, shitloc, time) {
  relic_user = undefined;

  if(isPlayer(victim)) {
    relic_user = victim;
  } else if(isPlayer(player)) {
    relic_user = player;
  }

  if(!isDefined(relic_user)) {
    return;
  }

  if(!isDefined(relic_user.ondamagerelics)) {
    return;
  }

  time = gettime();
  keys = getarraykeys(relic_user.ondamagerelics);

  if(!isDefined(keys)) {
    return;
  }

  foreach(key in keys) {
    if(istrue(relic_user.ondamagerelics[key])) {
      thread[[level.ondamagerelics[key]]](player, weapon, victim, smeansofdeath, shitloc, time);
    }
  }
}

function updateondamagepredamagemodrelics(player, weapon, victim, smeansofdeath, shitloc, time) {
  relic_user = undefined;

  if(isPlayer(victim)) {
    relic_user = victim;
  } else if(isPlayer(player)) {
    relic_user = player;
  } else if(isDefined(player.owner) && isPlayer(player.owner)) {
    relic_user = player.owner;
  }

  if(!isDefined(relic_user)) {
    return;
  }

  if(!isDefined(relic_user.ondamagerelics)) {
    return;
  }

  time = gettime();
  keys = getarraykeys(relic_user.ondamagerelics);

  if(!isDefined(keys)) {
    return;
  }

  foreach(key in keys) {
    if(isDefined(relic_user.ondamagepredamagemodrelics)) {
      if(istrue(relic_user.ondamagepredamagemodrelics[key])) {
        if(isDefined(level.ondamagepredamagemodrelics[key])) {
          thread[[level.ondamagepredamagemodrelics[key]]](player, weapon, victim, smeansofdeath, shitloc, time);
        }
      }
    }
  }
}

function updatedroprelics(position, var_4d8d96d547df2e9f) {
  player = undefined;

  if(!isPlayer(var_4d8d96d547df2e9f.eattacker)) {
    if(!isDefined(var_4d8d96d547df2e9f.eattacker.owner)) {
      return;
    } else {
      player = var_4d8d96d547df2e9f.eattacker.owner;
    }
  } else {
    player = var_4d8d96d547df2e9f.eattacker;
  }

  if(!isDefined(player) || !isDefined(player.ondroprelics)) {
    return;
  }

  time = gettime();
  keys = getarraykeys(player.ondroprelics);

  if(!isDefined(keys)) {
    return;
  }

  foreach(key in keys) {
    if(istrue(player.ondroprelics[key])) {
      thread[[level.ondroprelics[key]]](position, var_4d8d96d547df2e9f);
    }
  }
}

function init() {
  if(is_wave_gametype() || is_specops_gametype()) {
    return;
  }

  load_relics_vfx();
  register_relics();
  relics_monitor();
  level thread player_connect_monitor();
}

function load_relics_vfx() {
  level._effect["headshot_explode"] = loadfx("vfx/iw8_cp/misc/vfx_cp_head_explode.vfx");
  level._effect["headshot_explode_jugg"] = loadfx("vfx/iw8_cp/misc/vfx_cp_head_explode_jug.vfx");
  level._effect["healthpack_pickup"] = loadfx("vfx/iw8_cp/vfx_healthpack_vanish.vfx");
  level._effect["healthpack_spawn"] = loadfx("vfx/iw8_cp/vfx_healthpack.vfx");
  level._effect["stump_landing"] = loadfx("vfx/iw9/killstreaks/smk_signal/vfx_carepkg_landing_dust.vfx");
}

function player_connect_monitor() {
  level endon("game_ended");

  while(true) {
    level waittill("connected", player);
    init_relic_vars(player);
    player thread relics_monitor_on_player();
  }
}

function init_relic_vars(player) {
  player.onkillrelics = [];
  player.persistentrelics = [];
  player.ondamagerelics = [];
  player.relics = [];
}

function relics_monitor() {
  level endon("game_ended");
  load_relics_from_playlistdvars();
}

function relics_monitor_on_player() {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player notify("relics_monitor");
  player endon("relics_monitor");
  player.activated_relics = [];
  flag_wait("strike_init_done");
  player init_and_set_relics(player);

  while(true) {
    player waittill("relic_update", relic_name, bool);
    assertex(isDefined(bool), " the relic_update notify must be passed with a true or false parameter. Recheck script calls");
    assertex(isDefined(relic_name), " the relic_update notify must be passed with a relic name. Recheck script calls");

    if(isDefined(bool)) {
      if(!istrue(bool)) {
        unset_relics(player, relic_name);
        continue;
      }

      set_relics(player, relic_name);
    }
  }
}

function load_relics_from_playlistdvars() {
  level.set_relics = [];
  var_934386cae08481b2 = getDvar(@ "scr_set_relics", "");
  var_ce22ef601c001a14 = strtok(var_934386cae08481b2, ",");

  level thread load_relics_via_dvar();
  level thread unload_relics_via_dvar();

  foreach(new_relic in var_ce22ef601c001a14) {
    if(isDefined(new_relic) && new_relic != "") {
      level.set_relics[new_relic] = 1;
      level thread run_global_functions_for_relics(new_relic);
    }
  }
}

function run_global_functions_for_relics(relic_name) {
  if(isDefined(level.globalrelicsfunc[relic_name]) && isfunction(level.globalrelicsfunc[relic_name])) {
    level thread[[level.globalrelicsfunc[relic_name]]]();
  }
}

function load_relics_via_dvar() {
  level endon("game_ended");
  level.set_relics = [];

  while(true) {
    var_934386cae08481b2 = getDvar(@ "scr_set_relics", "");
    var_ce22ef601c001a14 = strtok(var_934386cae08481b2, ",");

    foreach(new_relic in var_ce22ef601c001a14) {
      if(istrue(level.set_relics[new_relic])) {
        waitframe();
        continue;
      }

      if(isDefined(new_relic) && new_relic != "") {
        level.set_relics[new_relic] = 1;

        foreach(player in level.players) {
          player notify("relic_update", new_relic, 1);
        }
      }
    }

    waitframe();
  }
}

function set_ui_omnvar_for_relics(relic_name) {
  player = self;

  if(!isDefined(player.relic_count)) {
    player.relic_count = 1;
  } else {
    player.relic_count += 1;
  }

  relic_index = tablelookup("cp/cp_relic_table.csv", 1, relic_name, 0);
  idx = int(relic_index);
  omnvar = "cp_relic_1";

  switch (player.relic_count) {
    case 1:
      omnvar = "cp_relic_1";
      break;
    case 2:
      omnvar = "cp_relic_2";
      break;
    case 3:
      omnvar = "cp_relic_3";
      break;
    case 4:
      omnvar = "cp_relic_4";
      break;
  }

  player setclientomnvar(omnvar, idx);
}

function unload_relics_via_dvar() {
  level endon("game_ended");

  while(true) {
    var_934386cae08481b2 = getDvar(@ "hash_f5b4dcfa3901b441", "");
    var_ce22ef601c001a14 = strtok(var_934386cae08481b2, ",");

    foreach(new_relic in var_ce22ef601c001a14) {
      if(istrue(level.set_relics[new_relic])) {
        if(isDefined(new_relic) && new_relic != "") {
          foreach(player in level.players) {
            player notify("relic_update", new_relic, 0);
          }

          level.set_relics[new_relic] = undefined;
        }
      }
    }

    waitframe();
  }
}

function debug_set_relic(player, new_relic) {
  if(isDefined(new_relic) && isDefined(level.cp_relics[new_relic])) {
    player.relics[new_relic] = level.cp_relics[new_relic];
    set_relics(player, new_relic);
  }
}

function debug_unset_relic(player, new_relic) {
  if(isDefined(new_relic) && isDefined(level.cp_relics[new_relic])) {
    player.relics[new_relic] = level.cp_relics[new_relic];
    unset_relics(player, new_relic);
  }
}

function init_and_set_relics(player) {
  foreach(relic_name, bool in level.set_relics) {
    relic_struct = level.cp_relics[relic_name];
    relic_name = relic_struct.name;
    set_relics(player, relic_name);
  }
}

function unset_relics(player, relic_name) {
  relic_info = level.cp_relics[relic_name];

  if(!isDefined(relic_info)) {
    return;
  }

  if(isDefined(relic_info)) {
    if(isDefined(relic_info) && isDefined(relic_info.unset_func)) {
      [[relic_info.unset_func]](player);
    }

    player iprintln("<dev string:x34>" + relic_info.name);

    player.activated_relics = array_remove(player.activated_relics, relic_info.name);
  }
}

function set_relics(player, relic_name) {
  relic_info = level.cp_relics[relic_name];

  if(!isDefined(relic_info)) {
    return;
  }

  if(isDefined(relic_info)) {
    if(isDefined(relic_info) && isDefined(relic_info.init_func)) {
      [[relic_info.init_func]](player);
    }
  }

  player iprintln("<dev string:x48>" + relic_info.name);

  if(isDefined(relic_info) && isDefined(relic_info.set_func)) {
    [[relic_info.set_func]](player);
  }

  if(isDefined(level.updatepersistentrelicsfunc)) {
    level thread[[level.updatepersistentrelicsfunc]](player);
  }

  player.activated_relics = array_add(player.activated_relics, relic_info.name);
  player set_ui_omnvar_for_relics(relic_info.name);
}

function register_relic(relic_name, init_func, set_func, unset_func) {
  relic_info = spawnStruct();
  relic_info.init_func = init_func;
  relic_info.set_func = set_func;
  relic_info.unset_func = unset_func;
  relic_info.name = relic_name;
  level.cp_relics[relic_name] = relic_info;
}

function function_f9afbe1c77e8330() {
  foreach(player in level.players) {
    println("<dev string:x5a>");
    println(player.name);
    println("<dev string:x8a>");

    foreach(active_relic in player.activated_relics) {
      println(active_relic);
    }

    println("<dev string:x5a>");
  }
}

function parserelicstable() {
  if(!isDefined(level.lootpassivesstructs)) {
    level.lootpassivesstructs = [];
  }

  for(row = 0; true; row++) {
    id = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", row, 0);

    if(id == "") {
      break;
    }

    var_9f77fa0224fd3b6b = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", row, 1);
    passivestringref = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", row, 2);
    attachmentref = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", row, 12);
    perkref = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", row, 13);
    messageref = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", row, 15);
    prdprobability = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", row, 23);
    prdconstant = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", row, 24);
    maxrolls = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", row, 25);
    struct = spawnStruct();
    struct.name = var_9f77fa0224fd3b6b;
    struct.passivestringref = passivestringref;
    struct.passiveindex = int(id);
    struct.weapontype = ter_op(tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", row, 8) == "", 0, 1);
    struct.killstreaktype = ter_op(tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", row, 9) == "", 0, 1);
    struct.lethaltype = ter_op(tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", row, 10) == "", 0, 1);
    struct.tacticaltype = ter_op(tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", row, 11) == "", 0, 1);

    if(attachmentref != "") {
      struct.attachmentref = attachmentref;
    }

    if(getDvar(@ "ui_gametype") == "zombie" || getDvar(@ "ui_gametype") == "cp_strike") {
      var_4c1a232672db4b7f = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", row, 22);

      if(var_4c1a232672db4b7f != "") {
        struct.attachmentref = var_4c1a232672db4b7f;
      }
    }

    if(perkref != "") {
      struct.perkref = perkref;
    }

    if(messageref != "") {
      struct.messageref = messageref;
    }

    if(isDefined(prdprobability)) {
      struct.prdprobability = int(prdprobability);
    }

    if(isDefined(prdconstant)) {
      struct.prdconstant = float(prdconstant);
    }

    if(isDefined(maxrolls)) {
      struct.maxrolls = int(maxrolls);
    }

    if(!isDefined(level.lootpassivesstructs[var_9f77fa0224fd3b6b])) {
      level.lootpassivesstructs[var_9f77fa0224fd3b6b] = struct;
    }
  }
}

function updaterecentkills(victim, weapon) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentKills");
  self endon("updateRecentKills");
  self.recentkillcount++;
  currentweapon_name = getweaponbasename(weapon);

  if(!isDefined(self.killsperweaponlog[currentweapon_name])) {
    self.killsperweaponlog[currentweapon_name] = 1;
  } else {
    self.killsperweaponlog[currentweapon_name]++;
  }

  if(!isDefined(self.recentkillsperweapon)) {
    self.recentkillsperweapon = [];
  }

  if(!isDefined(self.recentkillsperweapon[currentweapon_name])) {
    self.recentkillsperweapon[currentweapon_name] = 1;
  } else {
    self.recentkillsperweapon[currentweapon_name]++;
  }

  wait 3.5;
  self.recentkillcount = 0;
  self.recentkillsperweapon = undefined;
}

function init_relic_collat_dmg(player) {}

function set_relic_collat_dmg(player) {
  player.ondamagerelics["relic_collat_dmg"] = 1;
  level.explosivedamagemod = 0.4;
  player.onkillrelics["relic_collat_dmg"] = 1;
}

function unset_relic_collat_dmg(player) {
  level.explosivedamagemod = undefined;
  player.ondamagerelics["relic_collat_dmg"] = 0;
  player.onkillrelics["relic_collat_dmg"] = 0;
}

function ondamagereliccollatdmg(eattacker, sweapon, evictim, smeansofdeath, shitloc, timeoffset) {
  if(!isagent(evictim)) {
    return;
  }

  if(!isheadshot(sweapon, shitloc, smeansofdeath, eattacker) && smeansofdeath != "MOD_MELEE" && smeansofdeath != "MOD_IMPACT") {
    return;
  }

  evictim.nocorpse = 1;
}

function handlereliccollatdamage(sweapon, player, victim, smeansofdeath, shitloc, time) {
  if(!isheadshot(sweapon, shitloc, smeansofdeath, player) && smeansofdeath != "MOD_MELEE" && smeansofdeath != "MOD_IMPACT") {
    return;
  }

  isjuggernaut = isDefined(victim.unittype) && victim.unittype == "juggernaut";
  vpoint = victim.origin;

  if(victim tagexists("j_head")) {
    vpoint = victim gettagorigin("j_head");
  } else if(victim tagexists("tag_eye")) {
    vpoint = victim gettagorigin("tag_eye");
  }

  victim.bdiedonce = 1;

  if(isjuggernaut) {
    radiusdamage(victim.origin + (0, 0, 60), 512, 666, 69, player, "MOD_RIFLE_BULLET");
    scripts\cp\utility\cp_controlled_callbacks::runcontrolledcallback("Earthquake", 1, 0.6, victim.origin, 84);
    playFX(level._effect["claymore_explode"], vpoint);
  } else {
    radiusdamage(victim.origin + (0, 0, 60), 333, 333, 33, player, "MOD_RIFLE_BULLET");
    scripts\cp\utility\cp_controlled_callbacks::runcontrolledcallback("Earthquake", 1, 0.6, victim.origin, 84);
    playFX(level._effect["claymore_explode"], vpoint);
  }

  if(isDefined(victim.deathsound) && soundexists(victim.deathsound)) {
    playsoundatpos(victim.origin, victim.deathsound);
  }

  playrumbleonposition("grenade_rumble", victim.origin);
}

function init_relic_catch(player) {
  level.grenade_drop_cooldown = [];
  level.var_a0d48f3f14b6015d = ["brloot_offhand_claymore", "brloot_offhand_gas", "brloot_offhand_frag", "brloot_offhand_molotov", "brloot_offhand_semtex", "brloot_offhand_thermite"];
  level.var_317452953c148027 = &function_d5153f326998f468;
  scripts\cp\agent_drops::function_6c38af1ab38e980e("brloot_offhand_frag", &scripts\cp\agent_drops::function_3eeb69d40ad71f2b, "equipment", 1, undefined, 100, 0);
  scripts\cp\agent_drops::function_6c38af1ab38e980e("brloot_offhand_molotov", &scripts\cp\agent_drops::function_3eeb69d40ad71f2b, "equipment", 1, undefined, 100, 0);
  scripts\cp\agent_drops::function_6c38af1ab38e980e("brloot_offhand_semtex", &scripts\cp\agent_drops::function_3eeb69d40ad71f2b, "equipment", 1, undefined, 100, 0);
  scripts\cp\agent_drops::function_6c38af1ab38e980e("brloot_offhand_thermite", &scripts\cp\agent_drops::function_3eeb69d40ad71f2b, "equipment", 1, undefined, 100, 0);
}

function set_relic_catch(player) {
  player.onkillrelics["relic_catch"] = 1;
  scripts\cp\spawning::add_global_spawn_function("axis", &load_relic_catch_params);
}

function unset_relic_catch(player) {
  player.onkillrelics["relic_catch"] = 0;
  scripts\cp\spawning::remove_global_spawn_function("axis", &load_relic_catch_params);
}

function function_d5153f326998f468() {
  drop_name = array_randomize(level.var_a0d48f3f14b6015d)[0];
  scripts\cp\agent_drops::function_6fdbf71c8217cfc5(drop_name);
}

function handlereliccatch(sweapon, player, victim, smeansofdeath, shitloc, time) {}

function should_drop_grenade(var_4d8d96d547df2e9f) {
  drop_test = getdvarint(@ "hash_796d3b42936baa1");

  if(drop_test) {
    return true;
  }

  if(!isDefined(level.grenade_drop_cooldown)) {
    return false;
  }

  if(isDefined(self.unittype) && self.unittype == "suicidebomber") {
    return false;
  }

  if(!isDefined(var_4d8d96d547df2e9f.eattacker)) {
    return false;
  }

  cooldown = 10;
  cur_time = gettime();
  player_num = var_4d8d96d547df2e9f.eattacker getentitynumber();

  if(!isDefined(level.grenade_drop_cooldown[player_num])) {
    level.grenade_drop_cooldown[player_num] = cur_time + cooldown * 1000;
    return true;
  }

  if(cur_time > level.grenade_drop_cooldown[player_num]) {
    level.grenade_drop_cooldown[player_num] = cur_time + cooldown * 1000;
    return true;
  }

  return false;
}

function load_relic_catch_params() {
  self.script_forcegrenade = 1;
  self.grenadeammo = 255;
  self.grenadesafedist = 64;
}

function implement_cointoss(throwingat) {
  return cointoss();
}

function init_relic_boom(player) {}

function set_relic_boom(player) {
  player.onkillrelics["relic_boom"] = 1;
}

function unset_relic_boom(player) {
  player.onkillrelics["relic_boom"] = 0;
}

function handlerelicboom(sweapon, player, victim, smeansofdeath, shitloc, time) {
  grenade = magicgrenademanual("thermite_mp", victim.origin, (0, 0, 0));
  grenade.owner = victim;
  victim thread scripts\cp\equipment\cp_thermite::thermite_used(grenade);
}

function init_relic_swat(player) {
  scripts\cp\utility\cp_controlled_callbacks::registercontrolledcallback("Earthquake", &earthquake, 5, &allow_earthquake, 0, 0, 0, 1, 1);
}

function allow_earthquake(var1, var2, var3, var4, var5, var6, var7, var8) {
  return true;
}

function set_relic_swat(player) {
  player.ondamagerelics["relic_swat"] = 1;

  if(!array_contains(level.modifyplayerdamage_relics, &relic_swat_modifyplayerdamage)) {
    level.modifyplayerdamage_relics = array_add(level.modifyplayerdamage_relics, &relic_swat_modifyplayerdamage);
  }
}

function is_relic_swat_active() {
  return istrue(level.set_relics["relic_swat"]);
}

function is_relic_collat_dmg_active() {
  return istrue(level.set_relics["relic_collat_dmg"]);
}

function is_relic_active(relic) {
  if(isDefined(level.set_relics) && isDefined(level.set_relics[relic])) {
    return istrue(level.set_relics[relic]);
  }

  return 0;
}

function checkdamagesourcerelicswat() {
  if(!isDefined(level.should_do_damage_check_func_relics)) {
    level.should_do_damage_check_func_relics = [];
  }

  level.should_do_damage_check_func_relics = array_add(level.should_do_damage_check_func_relics, &validatedamagerelicswat);
}

function validatedamagerelicswat(eattacker, idamage, smeansofdeath, objweapon, shitloc, victim) {
  if(!isDefined(eattacker)) {
    return true;
  }

  if(isDefined(eattacker.owner)) {
    if(!isPlayer(eattacker.owner)) {
      return true;
    }
  }

  if(!isPlayer(eattacker)) {
    return true;
  }

  var_6f37d6df94d21d0b = smeansofdeath == "MOD_IMPACT";
  isexplosive = smeansofdeath == "MOD_EXPLOSIVE_BULLET" && isDefined(shitloc) && shitloc == "none" || smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH";
  isfire = smeansofdeath == "MOD_FIRE";
  var_b4a897b1262ea17c = isDefined(eattacker.classname) && eattacker.classname == "script_vehicle" && isDefined(eattacker.owner) && isPlayer(eattacker.owner);
  var_f3b5d704ca2a9b3d = var_b4a897b1262ea17c && smeansofdeath == "MOD_CRUSH";
  var_b2f70b31e5b3822f = isDefined(eattacker.classname) && eattacker.classname == "script_vehicle" && !isDefined(eattacker.owner);
  var_565d1ee9d540fa9e = var_b2f70b31e5b3822f && smeansofdeath == "MOD_CRUSH";
  var_b826059690277749 = smeansofdeath == "MOD_CRUSH";
  var_99e18f2c5e98e1 = smeansofdeath == "MOD_EXECUTION";
  var_375fdaa7d2c0e39f = smeansofdeath == "MOD_MELEE";
  var_e716d999a313692e = var_6f37d6df94d21d0b || isexplosive || var_99e18f2c5e98e1 || var_375fdaa7d2c0e39f || var_b826059690277749 || var_b4a897b1262ea17c || var_f3b5d704ca2a9b3d || var_b2f70b31e5b3822f || var_565d1ee9d540fa9e || is_killstreak_valid_for_swat(objweapon) || isheadshot(objweapon, shitloc, smeansofdeath, eattacker);

  if(var_e716d999a313692e) {
    return true;
  }

  if(isPlayer(eattacker) && isai(victim)) {
    if(var_e716d999a313692e) {
      return true;
    } else {
      return false;
    }
  } else {
    return true;
  }

  return false;
}

function unset_relic_swat(player) {
  player.ondamagerelics["relic_swat"] = 0;
  level.modifyplayerdamage_relics = array_remove(level.modifyplayerdamage_relics, &relic_swat_modifyplayerdamage);
}

function relic_swat_modifyplayerdamage(victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc) {
  if(validatedamagerelicswat(eattacker, idamage, smeansofdeath, objweapon, shitloc, victim)) {
    return idamage;
  }

  return 0;
}

function is_killstreak_valid_for_swat(objweapon) {
  if(!isDefined(objweapon)) {
    return 0;
  }

  switch (objweapon.basename) {
    case #"hash_85ea99fcbe4116a4":
    case #"hash_aae52fc2913829d0":
      return 1;
    case #"hash_e704ecf8710c6f57":
    case #"hash_c5c19fe9ae40cd0c":
    case #"hash_7de9687a97e62d93":
    case #"hash_4f9064f9a7a4b7d1":
    case #"hash_72843fb4c039e5b6":
    case #"hash_fe08358bc8f9a34a":
    case #"hash_c124ad09158500e9":
    case #"hash_5cbb3a1a84d47f1d":
    case #"hash_5e8f81314553dd36":
    case #"hash_2f1a9d8e2f127205":
    case #"hash_7917bb9ef2886e20":
    case #"hash_a54e19ae2e8d865c":
    case #"hash_a9e31b8ffd42a67b":
    case #"hash_3e782fd775b72022":
    case #"hash_6b9700922cc910a9":
    case #"hash_f55c20924061bd15":
      return 1;
    case #"hash_79ee9dd492804fa":
    case #"hash_996455d7b14b362":
    case #"hash_12a2863ecf2eeecd":
    case #"hash_1ba6982534c8d1d6":
    case #"hash_1cb3f2dbe85b8540":
    case #"hash_1ee2bbd1bc80ea9a":
    case #"hash_254b6e155434f84d":
    case #"hash_259ae6e25d936c3e":
    case #"hash_25fc06d658620968":
    case #"hash_2654d1bcc59b62b6":
    case #"hash_3226ebed78234b14":
    case #"hash_33aef56fb95396fd":
    case #"hash_359ac460bda5f9b8":
    case #"hash_3f2944fd91792508":
    case #"hash_4e213f6d3f76b400":
    case #"hash_4fd5d83c1a7f06a7":
    case #"hash_51f4f5345b01f136":
    case #"hash_62a9688b69906271":
    case #"hash_708fb6e22f87a3a4":
    case #"hash_73b4956c8f4b5217":
    case #"hash_80ae90d284543935":
    case #"hash_82a5b9368f3f35ae":
    case #"hash_6ac8f418ee829465":
    case #"hash_91a48ebfd2d03a40":
    case #"hash_9386cafe3d8d6d59":
    case #"hash_a0bfc30978e56904":
    case #"hash_a622e958420b92a0":
    case #"hash_892911bfe6164871":
    case #"hash_a9e5050965551dca":
    case #"hash_acaf314732f4c8e4":
    case #"hash_aef479d2af969a2d":
    case #"hash_af540b603005b109":
    case #"hash_b1d4d0d68c2b0c0f":
    case #"hash_bac656916e53b91c":
    case #"hash_badacfdae124cc01":
    case #"hash_cd6b1f03c24c25ff":
    case #"hash_cf8515f17748a7d2":
    case #"hash_d1ffad9819388638":
    case #"hash_d30fa952a74e1642":
    case #"hash_d4532f8e0fa86548":
    case #"hash_d7f368cf53337cfd":
    case #"hash_e9ee40174ddfa406":
    case #"hash_ec580a77ee20c7bd":
    case #"hash_edf51f8e5118b630":
    case #"hash_f003a3dc14dbdf3f":
    case #"hash_f816d2efb1dcbed0":
    case #"hash_fbca161190fca27d":
    case #"hash_fc4c0a8ee31549bb":
    case #"hash_fd79e0693da4a728":
      return 1;
    case #"hash_5e4ccaa178cac19c":
    case #"hash_435258fc47768fa7":
    case #"hash_56ee829cc162271a":
    case #"hash_4b87af60037f526f":
    case #"hash_cce14c95e4764532":
    case #"hash_a49fac234083ff01":
    case #"hash_432644fc4753dde9":
    case #"hash_6a2e4f9c54756dc7":
    case #"hash_8fd6158eb96a1f15":
    case #"hash_996849dc6e47c18f":
    case #"hash_8c12df11df01f306":
    case #"hash_1e6ad4ef0904a0f1":
      return 1;
    default:
      return 0;
  }
}

function handlerelicswat(eattacker, sweapon, evictim, smeansofdeath, shitloc, timeoffset) {
  if(isPlayer(eattacker)) {
    evictim notify("hit_ai", eattacker);
  }
}

function init_relic_damage_from_above(player) {}

function set_relic_damage_from_above(player) {
  player.ondamagerelics["relic_damage_from_above"] = 1;
  player.damage_from_above = 1;
}

function unset_relic_damage_from_above(player) {
  player.ondamagerelics["relic_damage_from_above"] = undefined;
  player.damage_from_above = undefined;
}

function init_relic_glasscannon(player) {}

function set_relic_glasscannon(player) {
  while(!isDefined(player.gs)) {
    waitframe();
  }

  player.og_health_value = player.maxhealth;
  player.og_health_regen_delay = player.gs.healthregendelay;
  player.og_health_regen_rate = player.gs.healthregenrate;
  player.maxhealth = 100;
  player.gs.healthregendelay = 1.5;
  player.gs.healthregenrate = 50;
}

function unset_relic_glasscannon(player) {
  player.maxhealth = player.og_health_value;
  player.gs.healthregendelay = player.og_health_regen_delay;
  player.gs.healthregenrate = player.og_health_regen_rate;
}

function handlepersistentteamproximity(player, sweapon, victim) {}

function init_relic_team_proximity(player) {}

function set_relic_team_proximity(player) {
  player.persistentrelics["relic_team_proximity"] = 1;
}

function unset_relic_team_proximity(player) {
  player.persistentrelics["relic_team_proximity"] = 0;
}

function global_relic_team_prox_func() {
  level thread relic_team_proximity_monitor(1000);
}

function relic_team_proximity_monitor(max_distance) {
  level endon("game_ended");
  level waittill("player_spawned_with_loadout");

  while(true) {
    players = level.players;

    if(players.size <= 1) {
      wait 3;
      continue;
    }

    foreach(player in players) {
      if(!is_player_valid_for_team_proximity(player)) {
        if(isDefined(player.is_far_from_team)) {
          if(isDefined(level.onteamproximitybecameinvalidplayer)) {
            foreach(func in level.onteamproximitybecameinvalidplayer) {
              player thread[[func]](player);
            }
          }
        }

        player.is_far_from_team = undefined;
        continue;
      }

      if(get_distance_to_closest_teammate(player) > max_distance) {
        if(!istrue(player.is_far_from_team)) {
          if(isDefined(level.onteamproximitysteppedfar)) {
            foreach(func in level.onteamproximitysteppedfar) {
              player thread[[func]](player);
            }
          }
        }

        player.is_far_from_team = 1;
        continue;
      }

      if(istrue(player.is_far_from_team)) {
        if(isDefined(level.onteamproximitysteppedclose)) {
          foreach(func in level.onteamproximitysteppedclose) {
            player thread[[func]](player);
          }
        }
      }

      player.is_far_from_team = 0;
    }

    waitframe();
  }
}

function is_player_valid_for_team_proximity(player) {
  invalid = !isalive(player) || istrue(player.inlaststand) || istrue(player.bspawningviaac130) || istrue(player.ishotjoiningplayer);
  return !invalid;
}

function get_distance_to_closest_teammate(player) {
  players = getplayersinteam(player.team);

  if(players.size <= 1) {
    return 0;
  }

  var_ac7a7cabd87a4ebf = -1;

  foreach(teammate in players) {
    if(teammate == player) {
      continue;
    }

    newdist = distance2d(player.origin, teammate.origin);

    if(newdist < var_ac7a7cabd87a4ebf || var_ac7a7cabd87a4ebf < 0) {
      var_ac7a7cabd87a4ebf = newdist;
    }
  }

  return var_ac7a7cabd87a4ebf;
}

function global_relic_amped_func() {
  scripts\cp\utility\cp_controlled_callbacks::registercontrolledcallback("Earthquake", &earthquake, 5, &allow_earthquake, 0, 0, 0, 1, 1);
  level thread relic_amped_monitor("allies");
}

function init_relic_amped(player) {}

function relic_amped_monitor(team) {
  level endon("game_ended");
  level notify("relic_amped_single_thread");
  level endon("relic_amped_single_thread");

  if(!isDefined(team)) {
    team = "allies";
  }

  while(true) {
    if(!isDefined(level.relic_amped_explosion_time)) {
      wait 0.2;
      continue;
    }

    if(!isDefined(level.relic_amped_victim) || !relic_amped_is_player_valid_to_explode(level.relic_amped_victim) || has_relic_amped_victim_filled_bar()) {
      if(istrue(has_relic_amped_victim_filled_bar()) && !istrue(relic_amped_is_there_valid_new_victim())) {
        relic_amped_clear_victim();
        relic_amped_pause(1);
        wait 3;
        relic_amped_pause(0);
        continue;
      } else {
        level.relic_amped_victim = relic_amped_pick_new_victim(team, 1);

        if(!isDefined(level.relic_amped_victim)) {
          level waittill("killed_enemy");
        } else {
          waitframe();
        }

        continue;
      }
    }

    if(isDefined(level.ampeddelta) && level.ampeddelta <= 0) {
      victim = level.relic_amped_victim;

      if(isDefined(victim)) {
        level relic_amped_do_explosion(victim);
        relic_amped_pause(1);
        wait 3;
        relic_amped_pause(0);
      } else {
        level waittill("killed_enemy");
      }

      continue;
    }

    waitframe();
  }
}

function relic_amped_monitor_beeps(team) {
  level endon("game_ended");
  level endon("relic_amped_stop_timer");
  level endon("relic_amped_explosion");
  level notify("relic_amped_beeps_single_thread");
  level endon("relic_amped_beeps_single_thread");

  if(!isDefined(team)) {
    team = "allies";
  }

  while(true) {
    if(!isDefined(level.relic_amped_explosion_time) || !isDefined(level.ampeddelta)) {
      waitframe();
      continue;
    }

    var_f7dd536eb8b3d570 = 0.5;

    if(level.ampeddelta > 2500 * 3) {
      var_f7dd536eb8b3d570 = 0.5;
    } else if(level.ampeddelta > 5000) {
      relic_amped_play_beep("breach_warning_beep_01", team);
      var_f7dd536eb8b3d570 = 1;
    } else {
      relic_amped_play_beep("breach_warning_beep_02", team);
      var_f7dd536eb8b3d570 = 0.2;
    }

    if(isDefined(level.relic_amped_victim) && level.ampeddelta <= -1500) {
      return;
    }

    wait var_f7dd536eb8b3d570;
  }
}

function has_relic_amped_victim_filled_bar() {
  if(!isDefined(level.relic_amped_victim)) {
    return true;
  }

  return istrue(level.relic_amped_victim.has_filled_amped_bar);
}

function has_relic_amped_victim_survived_time() {
  if(!isDefined(level.relic_amped_victim)) {
    return true;
  }

  if(!isDefined(level.relic_amped_victim.amped_victim_starttime)) {
    level.relic_amped_victim.amped_victim_starttime = gettime();
    return false;
  }

  return gettime() - level.relic_amped_victim.amped_victim_starttime >= 15000;
}

function relic_amped_debug_sim_kills(interval) {
  level endon("game_ended");
  level notify("relic_ampeddebug_single_thread");
  level endon("relic_ampeddebug_single_thread");
  level waittill("player_spawned_with_loadout");
  wait 3;

  while(true) {
    wait interval;
    relic_amped_on_ai_kill();
  }
}

function relic_amped_on_ai_kill() {
  level notify("killed_enemy");

  if(!istrue(level.relic_amped_paused) && !istrue(level.relic_amped_in_warning)) {
    if(!isDefined(level.relic_amped_explosion_time)) {
      level.relic_amped_explosion_time = gettime() + 10000;
      var_98346df6b2c8f0a1 = level.relic_amped_explosion_time;
    } else {
      var_98346df6b2c8f0a1 = level.relic_amped_explosion_time + 6000;
    }

    maxtime = gettime() + 20000;
    level.relic_amped_last_kill_time = gettime();
    level.relic_amped_explosion_time = min(var_98346df6b2c8f0a1, maxtime);

    if(isDefined(level.relic_amped_victim) && var_98346df6b2c8f0a1 > maxtime) {
      level.relic_amped_victim.has_filled_amped_bar = 1;
    }
  }
}

function relic_amped_show_timer(victim, resettimer) {
  level endon("game_ended");
  level endon("relic_amped_stop_timer");
  level endon("relic_amped_explosion");
  victim endon("disconnect");
  victim endon("death");
  level notify("relic_ampedtimer_single_thread");
  level endon("relic_ampedtimer_single_thread");
  var_49fe006c43b630aa = gettime();
  var_4956f0c9ea4e725f = var_49fe006c43b630aa + 2000;
  var_484d2cac8bbce3ae = 0;
  level.relic_amped_in_warning = 1;

  if(isDefined(level.amped_wid)) {
    objective_setprogress(level.amped_wid, 0);
  }

  while(var_4956f0c9ea4e725f > gettime()) {
    timedelta = max(gettime() - var_49fe006c43b630aa, 0.1);
    var_484d2cac8bbce3ae = timedelta / 2000 / 2;

    if(isDefined(victim)) {
      victim setclientomnvar("ui_relic_meter_progress", var_484d2cac8bbce3ae);
    }

    waitframe();
  }

  level.relic_amped_in_warning = 0;

  if(istrue(resettimer)) {
    level.relic_amped_explosion_time = gettime() + 10000;
  }

  level thread relic_amped_monitor_beeps("allies");

  while(true) {
    if(!isDefined(level.relic_amped_explosion_time)) {
      waitframe();
      continue;
    }

    level.ampeddelta = level.relic_amped_explosion_time - gettime();

    if(level.ampeddelta > 0) {
      victim setclientomnvar("ui_relic_meter_progress", level.ampeddelta / 20000);

      if(isDefined(level.amped_wid)) {
        objective_setprogress(level.amped_wid, level.ampeddelta / 20000);
      }
    } else {
      victim setclientomnvar("ui_relic_meter_progress", 0);
      objective_setprogress(level.amped_wid, 0);
    }

    if(isDefined(level.relic_amped_victim) && level.ampeddelta <= -1500) {
      if(relic_amped_is_player_valid_to_explode(level.relic_amped_victim)) {
        level relic_amped_do_explosion(level.relic_amped_victim);
      }

      relic_amped_pause(1);
      wait 3;
      relic_amped_pause(0);
      level notify("relic_amped_stop_timer");
    }

    waitframe();
  }
}

function relic_amped_play_beep(alias, team) {
  if(!soundexists(alias)) {
    return;
  }

  if(isDefined(level.relic_amped_victim)) {
    level.relic_amped_victim playSound(alias);
  }
}

function relic_amped_is_there_valid_new_victim() {
  var_d4ad5ed2e97b85d2 = level.relic_amped_victim;

  if(!isDefined(var_d4ad5ed2e97b85d2)) {
    return true;
  }

  otherplayers = array_remove(getplayersinteam(var_d4ad5ed2e97b85d2.team), var_d4ad5ed2e97b85d2);

  if(otherplayers.size <= 0) {
    return false;
  }

  foreach(player in otherplayers) {
    if(relic_amped_is_player_valid_to_explode(player)) {
      return true;
    }
  }

  return false;
}

function relic_amped_clear_victim() {
  if(isDefined(level.relic_amped_victim)) {
    level.relic_amped_victim.has_filled_amped_bar = 0;
    level.relic_amped_victim.amped_victim_starttime = undefined;
    level.relic_amped_victim setclientomnvar("ui_relic_meter_progress", 0);
  }

  level.relic_amped_explosion_time = undefined;
  level.relic_amped_last_kill_time = undefined;
  level.relic_amped_victim = undefined;

  if(isDefined(level.amped_wid)) {
    objective_addalltomask(level.amped_wid);
    objective_hidefromplayersinmask(level.amped_wid);
  }
}

function relic_amped_test_explode_other_player(interval) {
  while(true) {
    player = undefined;

    if(level.players.size > 1) {
      player = level.players[1];
      player ent_flag_wait("player_spawned_with_loadout");
    }

    if(isDefined(player)) {
      player.receivingampeddamage = 1;
      player.shouldskipdeathsshield = 1;
      player dodamage(player.maxhealth + 100000, player.origin, player, undefined, "MOD_SUICIDE");
      player waittill("revived");
      wait interval;
      continue;
    }

    wait 1;
  }
}

function relic_amped_pick_new_victim(team, resettimer) {
  var_d4ad5ed2e97b85d2 = undefined;

  if(isDefined(level.relic_amped_victim)) {
    var_d4ad5ed2e97b85d2 = level.relic_amped_victim;
    relic_amped_clear_victim();
  }

  victim = relic_amped_pick_random_valid_player(team, var_d4ad5ed2e97b85d2);

  if(getdvarint(@ "hash_27284304096a567", 0) > 0 && level.players.size > 1 && relic_amped_is_player_valid_to_explode(level.players[0])) {
    victim = level.players[0];
  }

  if(!isDefined(victim)) {
    return;
  }

  level.relic_amped_victim = victim;
  level.relic_amped_victim.amped_victim_starttime = gettime();
  level.relic_amped_victim.has_filled_amped_bar = 0;
  relic_amped_set_head_objective(victim);

  if(!isDefined(resettimer)) {
    resettimer = 0;
  }

  level.ampeddelta = undefined;
  level thread relic_amped_show_timer(victim, resettimer);
  return victim;
}

function relic_amped_pick_random_valid_player(team, var_caaee13684c90fb8) {
  players = getplayersinteam(team);

  foreach(player in players) {
    if(!relic_amped_is_player_valid_to_explode(player)) {
      players = array_remove(players, player);
    }
  }

  if(players.size <= 0) {
    return undefined;
  }

  if(isDefined(var_caaee13684c90fb8) && array_contains(players, var_caaee13684c90fb8) && players.size > 1) {
    players = array_remove(players, var_caaee13684c90fb8);
  }

  return random(players);
}

function relic_amped_set_head_objective(player) {
  if(!isDefined(level.amped_wid)) {
    wid = scripts\cp\cp_objectives::requestworldid("ampedWID");
    level.amped_wid = wid;
    objective_setplayintro(wid, 0);
    objective_setplayoutro(wid, 0);
    objective_state(wid, "current");
    objective_icon(wid, "icon_waypoint_timed");
    objective_setbackground(wid, 0);
    objective_setshowoncompass(wid, 1);
    objective_setshowprogress(wid, 1);
    objective_setprogress(wid, 0);
  }

  objective_onentity(level.amped_wid, player);
  objective_setzoffset(level.amped_wid, 90);
  objective_addalltomask(level.amped_wid);
  objective_showtoplayersinmask(level.amped_wid);
}

function relic_amped_is_player_valid_to_explode(player) {
  spawned_with_loadout = player ent_flag("player_spawned_with_loadout");
  invalid = !isalive(player) || istrue(player.inlaststand) || istrue(player.respawn_in_progress) || istrue(player.bspawningviaac130) || isDefined(player.super_invulnerable) || !istrue(spawned_with_loadout);
  return !invalid;
}

function relic_amped_debug_explode_after_reviving() {
  level endon("game_ended");
  flag_wait("player_spawned_with_loadout");
  player = level.players[0];
  player endon("death");
  player waittill("started_revive");
  wait 4;
  player.receivingampeddamage = 1;
  player.shouldskipdeathsshield = 1;
  player dodamage(player.maxhealth + 100000, player.origin, player, undefined, "MOD_SUICIDE");
}

function relic_amped_do_explosion(player) {
  level endon("game_ended");
  vpoint = player.origin;

  if(player tagexists("j_head")) {
    vpoint = player gettagorigin("j_head");
  } else if(player tagexists("tag_eye")) {
    vpoint = player gettagorigin("tag_eye");
  }

  var_1a305763f670dce9 = 3000;
  var_9fa829c447bfa7c9 = gettime();

  while(istrue(player.invulnerable) && gettime() - var_9fa829c447bfa7c9 <= var_1a305763f670dce9) {
    waitframe();
  }

  vehicle = player scripts\cp_mp\utility\player_utility::getvehicle();
  player.receivingampeddamage = 1;
  player.shouldskipdeathsshield = 1;
  player dodamage(player.maxhealth + 100000, player.origin, player, undefined, "MOD_SUICIDE");
  radiusdamage(player.origin + (0, 0, 60), 600, player.maxhealth, player.maxhealth, undefined, "MOD_RIFLE_BULLET");
  scripts\cp\utility\cp_controlled_callbacks::runcontrolledcallback("Earthquake", 1, 0.6, player.origin, 84);
  earthquake(1, 0.6, player.origin, 333);
  playFX(level._effect["headshot_explode"], vpoint);
  player playSound("gib_fullbody");

  if(isDefined(vehicle)) {
    vehicle dodamage(vehicle.maxhealth, (0, 0, 0), undefined, undefined);
  }

  player.receivingampeddamage = 0;
  playrumbleonposition("grenade_rumble", player.origin);
  player setclientomnvar("ui_relic_meter_progress", 0);
  player.amped_victim_starttime = undefined;
  level notify("relic_amped_explosion");
  player thread relic_amped_reset_deathshield_on_revived(player);
}

function relic_amped_reset_deathshield_on_revived(player) {
  level endon("game_ended");
  player endon("disconnect");

  while(!isalive(player) || istrue(player.inlaststand) || istrue(player.respawn_in_progress)) {
    wait 1;
  }

  player waittill_any_2("revive", "death");
  player setclientomnvar("ui_relic_meter_progress", 0);
  player.shouldskipdeathsshield = 0;
  player.shouldskiplaststand = 0;
}

function set_relic_amped(player) {
  player.onkillrelics["relic_amped"] = 1;
}

function unset_relic_amped(player) {
  player.onkillrelics["relic_amped"] = 0;
}

function relic_amped_pause(toggle) {
  level.relic_amped_paused = toggle;

  if(istrue(toggle)) {
    level notify("relic_amped_stop_timer");

    if(isDefined(level.amped_wid)) {
      objective_addalltomask(level.amped_wid);
      objective_hidefromplayersinmask(level.amped_wid);
    }

    if(isDefined(level.relic_amped_victim)) {
      level.relic_amped_victim = undefined;
    }

    level.relic_amped_explosion_time = undefined;
    level.relic_amped_last_kill_time = undefined;
    level.ampeddelta = undefined;
  }
}

function handlerelicampedonkill(sweapon, player, victim, smeansofdeath, shitloc, time) {
  if(!isDefined(player) || !isai(victim)) {
    return;
  }

  if(!isDefined(level.relic_amped_victim)) {
    relic_amped_pick_new_victim(player.team, 1);
    relic_amped_on_ai_kill();
    return;
  }

  if(level.relic_amped_victim == player) {
    relic_amped_on_ai_kill();
  }
}

function init_relic_shieldsonly(player) {
  player thread relic_shieldsonly_set_player_stats_after_spawn(player);
}

function relic_shieldsonly_set_player_stats_after_spawn(player) {
  level endon("game_ended");
  player endon("disconnect");
  player waittill("spawned_player");
  player.maxhealth = 1;
  scripts\cp\armor::givearmor(player, 100, 1);
}

function set_relic_shieldsonly(player) {
  player.onkillrelics["relic_shieldsonly"] = 1;
}

function unset_relic_shieldsonly(player) {
  player.onkillrelics["relic_shieldsonly"] = 0;
}

function handlerelicshieldsonlyonkill(sweapon, player, victim, smeansofdeath, shitloc, time) {
  if(!isDefined(player)) {
    return;
  }

  if(scripts\cp\armor::player_have_full_armor(player)) {
    return;
  }

  var_d5db260bcf9e2170 = player scripts\cp\armor::function_8e297d719d663b78();
  var_80454e38d2bb435c = int(clamp(var_d5db260bcf9e2170 + 50, 50, 100));
  scripts\cp\armor::givearmor(player, var_80454e38d2bb435c, 1);
}

function relic_squadlink_init_vfx() {
  level._effect["vfx_squadlink_tunnelvision"] = loadfx("vfx/iw8_cp/misc/vfx_cp_tunnel_vision.vfx");
}

function global_relic_squadlink_func() {
  level thread relic_team_proximity_monitor(666);

  if(!isDefined(level.onteamproximitysteppedfar)) {
    level.onteamproximitysteppedfar = [];
  }

  if(!isDefined(level.onteamproximitysteppedclose)) {
    level.onteamproximitysteppedclose = [];
  }

  if(!isDefined(level.onteamproximitybecameinvalidplayer)) {
    level.onteamproximitybecameinvalidplayer = [];
  }

  level.onteamproximitysteppedclose = array_add(level.onteamproximitysteppedclose, &relic_squadlink_onsteppedclose);
  level.onteamproximitysteppedfar = array_add(level.onteamproximitysteppedfar, &relic_squadlink_onsteppedfar);
  level.onteamproximitybecameinvalidplayer = array_add(level.onteamproximitybecameinvalidplayer, &relic_squadlink_onbecameinvalidplayer);

  if(!array_contains(level.modifyplayerdamage_relics, &relic_squadlink_modifyplayerdamage)) {
    level.modifyplayerdamage_relics = array_add(level.modifyplayerdamage_relics, &relic_squadlink_modifyplayerdamage);
  }
}

function handlepersistentrelicsquadlink(player, sweapon, victim) {}

function relic_squadlink_onsteppedclose(player) {
  level endon("game_ended");
  player endon("death");
  player endon("last_stand");
  player endon("disconnect");
  player.relicsquadlink = 1;
  player notify("squadlink_stepped_too_close");
  player thread scripts\cp\cp_hud_message::tutorialprint("", 0.2);
  player thread relic_squadlink_flash_squadlink_icon(player, 2, "squadlink_stepped_too_far", 2);
  player relic_squadlink_turn_team_headobjectives(player, 0);
  player thread relic_squadlink_remove_visionset(player);
}

function relic_squadlink_onsteppedfar(player) {
  level endon("game_ended");
  player.relicsquadlink = 0;
  player notify("squadlink_stepped_too_far");
  player relic_squadlink_turn_team_headobjectives(player, 1);
  player thread relic_squadlink_toofar_hud_logic(player);

  if(getdvarint(@ "hash_ad06c12cb7279087", 0) != 0) {
    player thread relic_squadlink_vision_debuff(player);
  }
}

function relic_squadlink_onbecameinvalidplayer(player) {
  level endon("game_ended");
  player setclientomnvar("ui_cp_relic_squad_link", 0);
}

function relic_squadlink_flash_squadlink_icon(player, timer, endonmessage, var_9ff3b5e66759eaa6) {
  level endon("game_ended");
  player endon(endonmessage);
  player endon("death");
  player endon("disconnect");
  player setclientomnvar("ui_cp_relic_squad_link", var_9ff3b5e66759eaa6);
  wait timer;
  player setclientomnvar("ui_cp_relic_squad_link", 0);
}

function relic_squadlink_vision_debuff(player) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("squadlink_stepped_too_close");
  player endon("death");
  player endon("last_stand");
  player thread relic_squadlink_watch_for_visionset_end(player);
  player thread relic_squadlink_add_visionset(player);
}

function relic_squadlink_watch_for_visionset_end(player) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("squadlink_stepped_too_close");
  player waittill_any_2("death", "last_stand");
  player relic_squadlink_remove_visionset(player);
}

function relic_squadlink_add_visionset(player) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("squadlink_stepped_too_close");
  player visionsetnakedforplayer("nuke_deathblur", 0);
  player allowsupersprint(0);
  wait 5;
  playfxontagforclients(level._effect["vfx_squadlink_tunnelvision"], player, "tag_origin", player);
}

function relic_squadlink_remove_visionset(player) {
  player visionsetnakedforplayer("", 0);
  player allowsupersprint(1);
  stopFXOnTag(level._effect["vfx_squadlink_tunnelvision"], player, "tag_origin");
}

function relic_squadlink_toofar_hud_logic(player) {
  level endon("game_ended");
  player endon("death");
  player endon("disconnect");
  player endon("squadlink_stepped_too_close");

  while(true) {
    time = 3;
    player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_BR_SYRK_OBJECTIVES/RELIC_SQUADLINK_FAR", time - 1);
    player thread relic_squadlink_flash_squadlink_icon(player, time - 1, "squadlink_stepped_too_close", 1);
    player playlocalsound("cp_computer_fail");
    wait time;
  }
}

function init_relic_squadlink(player) {}

function set_relic_squadlink(player) {
  player.ondamagerelics["relic_squadlink"] = 1;
  player.ondamagepredamagemodrelics["relic_squadlink"] = 1;
  player setclientomnvar("ui_cp_relic_squad_link", 0);

  if(!isDefined(player.squadlink_wid)) {
    wid = scripts\cp\cp_objectives::requestworldid(player.name + "_squadlinkWID");
    player.squadlink_wid = wid;
    objective_setplayintro(wid, 0);
    objective_setplayoutro(wid, 0);
    objective_state(wid, "current");
    objective_icon(wid, "icon_waypoint_objective_general");
    objective_setbackground(wid, 1);
    objective_setshowoncompass(wid, 1);
    objective_onentity(wid, player);
    objective_setzoffset(wid, 70);
    objective_setshowdistance(wid, 1);
    objective_addalltomask(wid);
    objective_hidefromplayersinmask(wid);
  }
}

function unset_relic_squadlink(player) {
  player.ondamagerelics["relic_squadlink"] = 0;
  player.ondamagepredamagemodrelics["relic_squadlink"] = 0;
  player setclientomnvar("ui_cp_relic_squad_link", 0);

  if(isDefined(player.squadlink_wid)) {
    objective_delete(player.squadlink_wid);
    player.squadlink_wid = scripts\cp\cp_objectives::freeworldid(player.name + "_squadlinkWID");
    player.squadlink_wid = undefined;
  }
}

function ondamagerelicsquadlink(eattacker, sweapon, evictim, smeansofdeath, shitloc, timeoffset) {}

function relic_squadlink_modifyplayerdamage(victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc) {
  damage_multiplier = 1;

  if(isDefined(eattacker) && isPlayer(eattacker)) {
    if(!istrue(eattacker.is_far_from_team)) {
      damage_multiplier = 4;
    }
  } else if(isDefined(victim) && isPlayer(victim)) {
    if(!istrue(victim.is_far_from_team)) {
      damage_multiplier = 0.1;
    }
  }

  return int(idamage * damage_multiplier);
}

function relic_squadlink_outline_monitor(ai) {
  ai endon("death");
  level endon("game_ended");

  if(isDefined(ai.squadlink_outline_id)) {
    return;
  }

  ai.squadlink_outline_id = scripts\cp\cp_outline_utility::outlineenableforall(ai, "snapshotgrenade_longfade", "killstreak_personal");
  wait 2;
  scripts\cp\cp_outline_utility::outlinedisable(ai.squadlink_outline_id, ai);
  ai.squadlink_outline_id = undefined;
}

function relic_squadlink_turn_team_headobjectives(player, toggle) {
  otherplayers = getplayersinteam(player.team);
  otherplayers = array_remove(otherplayers, player);

  if(otherplayers.size <= 0) {
    return;
  }

  foreach(teammate in otherplayers) {
    if(isDefined(teammate.squadlink_wid)) {
      if(istrue(toggle)) {
        objective_removeclientfrommask(teammate.squadlink_wid, player);
        objective_hidefromplayersinmask(teammate.squadlink_wid);
        continue;
      }

      objective_addclienttomask(teammate.squadlink_wid, player);
      objective_hidefromplayersinmask(teammate.squadlink_wid);
    }
  }
}

function global_relic_landlocked_func() {
  scripts\cp\utility\cp_controlled_callbacks::registercontrolledcallback("Earthquake", &earthquake, 5, &allow_earthquake, 0, 0, 0, 1, 1);
}

function init_relic_landlocked(player) {}

function set_relic_landlocked(player) {
  player.persistentrelics["relic_landlocked"] = 1;
}

function unset_relic_landlocked(player) {
  player.persistentrelics["relic_landlocked"] = 0;
}

function handlepersistentlandlocked(player, sweapon, victim) {}

function relic_landlocked_do_explosion(player) {
  player endon("death");
  player endon("disconnect");
  level endon("game_ended");
  player endon("relic_landlocked_returned_safe");
  player notify("relic_landlocked_do_explosion");
  player endon("relic_landlocked_do_explosion");
  player thread relic_landlocked_clear_message_on_player_return(player);
  player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_BR_SYRK_OBJECTIVES/RELIC_LANDLOCKED_MSG", 2);
  wait 2;
  vpoint = player.origin;

  if(player tagexists("j_head")) {
    vpoint = player gettagorigin("j_head");
  } else if(player tagexists("tag_eye")) {
    vpoint = player gettagorigin("tag_eye");
  }

  player notify("relic_landlocked_exploded");
  radiusdamage(player.origin + (0, 0, 60), 333, 333, 33, undefined, "MOD_RIFLE_BULLET");
  scripts\cp\utility\cp_controlled_callbacks::runcontrolledcallback("Earthquake", 1, 0.6, player.origin, 84);
  playFX(level._effect["headshot_explode"], vpoint);
  player playSound("gib_fullbody");
  playrumbleonposition("grenade_rumble", player.origin);
}

function relic_landlocked_clear_message_on_player_return(player) {
  player endon("death");
  player endon("disconnect");
  level endon("game_ended");
  player endon("relic_landlocked_exploded");
  player endon("relic_landlocked_do_explosion");

  while(!isDefined(player.inhackring)) {
    waitframe();
  }

  player notify("relic_landlocked_returned_safe");
}

function init_relic_lfo(player) {}

function set_relic_lfo(player) {
  player.ondamagerelics["relic_lfo"] = 1;
  player.sappliedstages = [];
  player thread manage_health_stage_allows();
}

function unset_relic_lfo(player) {
  player.ondamagerelics["relic_lfo"] = 0;
}

function handlelfo() {
  val::group_register("LFO_1", ["slide", "sprint", "crouch", "prone", "mantle"]);
  val::group_register("LFO_2", ["slide", "sprint"]);
  val::group_register("LFO_3", ["slide", "sprint"]);
  val::group_register("LFO_4", ["slide", "sprint"]);
}

function blank_relic_func(player) {}

function set_force_aitype_shotgun(player) {
  if(!isDefined(level.forced_aitypes)) {
    level.forced_aitypes = [];
  }

  level.forced_aitypes[level.forced_aitypes.size] = "shotgun";
}

function set_force_aitype_sniper(player) {
  if(!isDefined(level.forced_aitypes)) {
    level.forced_aitypes = [];
  }

  level.forced_aitypes[level.forced_aitypes.size] = "sniper";
}

function set_force_aitype_riotshield(player) {
  if(!isDefined(level.forced_aitypes)) {
    level.forced_aitypes = [];
  }

  level.forced_aitypes[level.forced_aitypes.size] = "riotshield";
}

function set_force_aitype_suicidebomber(player) {
  if(!isDefined(level.forced_aitypes)) {
    level.forced_aitypes = [];
  }

  level.forced_aitypes[level.forced_aitypes.size] = "suicidebomber";
}

function set_force_aitype_rpg(player) {
  if(!isDefined(level.forced_aitypes)) {
    level.forced_aitypes = [];
  }

  level.forced_aitypes[level.forced_aitypes.size] = "rpg";
}

function unset_force_aitype_rpg(player) {
  if(isDefined(level.forced_aitypes) && array_contains(level.forced_aitypes, "rpg")) {
    level.forced_aitypes = array_remove(level.forced_aitypes, "rpg");

    if(level.forced_aitypes.size < 1) {
      unset_forced_aitype();
    }
  }
}

function unset_force_aitype_shotgun(player) {
  if(isDefined(level.forced_aitypes) && array_contains(level.forced_aitypes, "shotgun")) {
    level.forced_aitypes = array_remove(level.forced_aitypes, "shotgun");

    if(level.forced_aitypes.size < 1) {
      unset_forced_aitype();
    }
  }
}

function unset_force_aitype_sniper(player) {
  if(isDefined(level.forced_aitypes) && array_contains(level.forced_aitypes, "sniper")) {
    level.forced_aitypes = array_remove(level.forced_aitypes, "sniper");

    if(level.forced_aitypes.size < 1) {
      unset_forced_aitype();
    }
  }
}

function unset_force_aitype_riotshield(player) {
  if(isDefined(level.forced_aitypes) && array_contains(level.forced_aitypes, "riotshield")) {
    level.forced_aitypes = array_remove(level.forced_aitypes, "riotshield");

    if(level.forced_aitypes.size < 1) {
      unset_forced_aitype();
    }
  }
}

function unset_force_aitype_suicidebomber(player) {
  if(isDefined(level.forced_aitypes) && array_contains(level.forced_aitypes, "suicidebomber")) {
    level.forced_aitypes = array_remove(level.forced_aitypes, "suicidebomber");

    if(level.forced_aitypes.size < 1) {
      unset_forced_aitype();
    }
  }
}

function unset_forced_aitype(player) {
  level.forced_aitypes = undefined;
}

function set_force_aitype_armored(player) {
  level.forced_aitype_armored = 1;
  scripts\cp\spawning::add_global_spawn_function("axis", &function_fa6ea7f830d64c9c);
}

function unset_forced_aitype_armored(player) {
  level.forced_aitype_armored = undefined;
  scripts\cp\spawning::remove_global_spawn_function("axis", &function_fa6ea7f830d64c9c);
}

function function_fa6ea7f830d64c9c() {
  if(scripts\cp\spawning::is_juggernaut_aitype()) {
    return;
  }

  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
  }

  self attach("head_sp_opforce_al_qatala_tier_3_1", "", 1);
  self.headmodel = "head_sp_opforce_al_qatala_tier_3_1";
  scripts\cp_mp\agents\agent_utils::overridetier3(self);
}

function set_just_keep_moving(player) {
  player.persistentrelics["relic_just_keep_moving"] = 1;
  player.relic_disable_health_regen = 0;
}

function unset_just_keep_moving(player) {
  player.persistentrelics["relic_just_keep_moving"] = 0;
  player.relic_disable_health_regen = undefined;
}

function handle_just_keep_moving(player, sweapon, unused) {
  level endon("game_ended");
  player endon("disconnect");

  while(true) {
    if(!isDefined(player.velo_forward)) {
      wait 0.1;
      continue;
    }

    var_dd6fbb1ff2a513c9 = player.velo_forward - player.origin;
    var_dd6fbb1ff2a513c9 = (var_dd6fbb1ff2a513c9[0], var_dd6fbb1ff2a513c9[1], 0);
    var_13b97a8da9dfea88 = length(var_dd6fbb1ff2a513c9);

    if(var_13b97a8da9dfea88 > 0) {
      player.relic_disable_health_regen = 0;
    } else if(isDefined(self.velo_forward_memory) && self.velo_forward_memory.size < 3) {
      player.relic_disable_health_regen = 1;
    }

    wait 0.25;
  }
}

function manage_health_stage_allows() {
  self endon("disconnect");

  while(true) {
    waitframe();

    if(scripts\cp\laststand::player_in_laststand(self)) {
      continue;
    }

    current_stage = get_health_stage(self);

    foreach(stage in self.sappliedstages) {
      if(stage == current_stage) {}
    }

    switch (current_stage) {
      case 1:
      case 2:
        if(array_contains(self.sappliedstages, current_stage)) {
          continue;
        }

        self.sappliedstages = array_add(self.sappliedstages, current_stage);
        val::group_set("LFO_" + current_stage, 0);
        break;
      case 3:
      case 4:
        foreach(stage in self.sappliedstages) {
          val::group_set("LFO_" + stage, 1);
          self.sappliedstages = array_remove(self.sappliedstages, stage);
        }

        break;
      default:
        assertmsg("<dev string:xba>");
        break;
    }
  }
}

function ondamagereliclfo(eattacker, sweapon, evictim, smeansofdeath, shitloc, timeoffset) {
  if(!isPlayer(evictim)) {
    return;
  }

  player = evictim;

  if(scripts\cp\laststand::player_in_laststand(player)) {
    return;
  }

  switch (get_health_stage(player)) {
    case 1:
      break;
    case 2:
      break;
    case 3:
      break;
    case 4:
      break;
    default:
      assertmsg("<dev string:xba>");
      break;
  }
}

function ondamagerelicfromabove(eattacker, sweapon, evictim, smeansofdeath, shitloc, timeoffset) {}

function get_health_stage(player) {
  health_ratio = player.health / player.maxhealth;

  if(health_ratio <= 0.33) {
    return 1;
  }

  if(health_ratio <= 0.66) {
    return 2;
  }

  if(health_ratio <= 1) {
    return 3;
  }

  return 4;
}

function init_relic_noks(player) {}

function set_relic_noks(player) {}

function unset_relic_noks(player) {}

function handlenokillstreaks() {
  level.disable_map_munitions = 1;
  level.disable_loot_drop = 1;
  wait 10;
  scripts\cp\munitions::remove_munitions_globally();
}

function init_relic_no_ammo_mun(player) {}

function set_relic_no_ammo_mun(player) {
  player.no_enemy_weapon_drops = 1;
}

function unset_relic_no_ammo_mun(player) {
  player.no_enemy_weapon_drops = undefined;
}

function handle_no_ammo_mun() {
  level.disable_map_ammo_munitions = 1;
  wait 10;
  scripts\cp\munitions::remove_munitions_globally(["brloot_munition_ammo"]);
}

function handlemythic() {
  scripts\cp\spawning::add_global_spawn_function("axis", &increase_hp_from_relic_mythic);

  if(!array_contains(level.modifyplayerdamage_relics, &relic_mythic_modifyplayerdamage)) {
    level.modifyplayerdamage_relics = array_add(level.modifyplayerdamage_relics, &relic_mythic_modifyplayerdamage);
  }
}

function relic_mythic_modifyplayerdamage(victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc) {
  process_should_do_pain(victim, eattacker, objweapon, shitloc, smeansofdeath);

  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_MELEE") {
    return int(idamage * get_health_multiplier_relic_mythic());
  }

  return int(idamage);
}

function process_should_do_pain(victim, eattacker, objweapon, shitloc, smeansofdeath) {
  if(isDefined(victim) && isPlayer(victim)) {
    return;
  }

  if(relic_mythic_should_bypass_pain_cooldown(objweapon)) {
    victim.relic_mythic_do_pain = 1;
    return;
  }

  bulletdamage = scripts\engine\utility::isbulletdamage(smeansofdeath) || smeansofdeath == "MOD_EXPLOSIVE_BULLET" && shitloc != "none";
  headshot = bulletdamage && scripts\cp\utility::isheadshot(objweapon, shitloc, smeansofdeath, eattacker);

  if(relic_mythic_should_do_pain(headshot, smeansofdeath)) {
    if(relic_mythic_can_do_pain(victim)) {
      victim.relic_mythic_do_pain = 1;
      return;
    }
  }
}

function relic_mythic_can_do_pain(victim) {
  current_time = gettime();
  return current_time >= victim.relic_mythic_next_pain_time;
}

function relic_mythic_should_do_pain(headshot, smeansofdeath) {
  if(istrue(headshot)) {
    return true;
  }

  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_MELEE") {
    return true;
  }

  return false;
}

function relic_mythic_should_bypass_pain_cooldown(objweapon) {
  if(scripts\cp\agent_damage::is_flashbang(objweapon.basename, objweapon, undefined)) {
    return true;
  }

  return false;
}

function increase_hp_from_relic_mythic() {
  var_d36db0e7d81f7aaa = self.maxhealth;
  health_multiplier = get_health_multiplier_relic_mythic();
  var_6d5b2972d828222f = var_d36db0e7d81f7aaa * health_multiplier;
  scripts\mp\mp_agent::set_agent_health(var_6d5b2972d828222f);
  self.relic_mythic_next_pain_time = gettime();
  self.fnshouldplaypainanim = &relic_mythic_should_ai_play_pain;
}

function relic_mythic_should_ai_play_pain() {
  if(istrue(self.relic_mythic_do_pain)) {
    self.relic_mythic_next_pain_time = gettime() + 2000;
    self.relic_mythic_do_pain = 0;
    return 1;
  }

  return 0;
}

function get_health_multiplier_relic_mythic() {
  if(getdvarint(@ "hash_c142ffcaf16b9a8a", 0) != 0) {
    return int(getdvarint(@ "hash_c142ffcaf16b9a8a", 0));
  }

  return 10;
}

function init_relic_mythic(player) {}

function set_relic_mythic(player) {}

function unset_relic_mythic(player) {
  if(array_contains(level.modifyplayerdamage_relics, &relic_mythic_modifyplayerdamage)) {
    level.modifyplayerdamage_relics = array_remove(level.modifyplayerdamage_relics, &relic_mythic_modifyplayerdamage);
  }
}

function handlefocusfire() {
  scripts\cp\spawning::add_global_spawn_function("axis", &set_focus_fire_params);

  if(!array_contains(level.modifyplayerdamage_relics, &relic_focusfire_modifyplayerdamage)) {
    level.modifyplayerdamage_relics = array_add(level.modifyplayerdamage_relics, &relic_focusfire_modifyplayerdamage);
  }
}

function set_focus_fire_params() {
  self.focus_fire_attackers = [];
}

function is_player_in_focus_fire_attacker_list(player_name, ai) {
  return scripts\engine\utility::array_contains(ai.focus_fire_attackers, player_name);
}

function add_player_to_focus_fire_attacker_list(player_name, ai) {
  ai.focus_fire_attackers = scripts\engine\utility::array_add(ai.focus_fire_attackers, player_name);
  update_focus_fire_heahicon(ai);

  if(focus_fire_outline_enabled()) {
    if(ai.focus_fire_attackers.size == 1) {
      ai.focus_fire_outline_id = scripts\cp\cp_outline_utility::outlineenableforall(ai, "snapshotgrenade_longfade", "killstreak_personal");
    }
  }
}

function remove_player_from_focus_fire_attacker_list(player_name, ai) {
  ai.focus_fire_attackers = scripts\engine\utility::array_remove(ai.focus_fire_attackers, player_name);
  update_focus_fire_heahicon(ai);

  if(focus_fire_outline_enabled()) {
    if(has_no_focus_fire_attackers(ai)) {
      if(isDefined(ai.focus_fire_outline_id)) {
        scripts\cp\cp_outline_utility::outlinedisable(ai.focus_fire_outline_id, ai);
      }
    }
  }
}

function focus_fire_outline_enabled() {
  if(getdvarint(@ "hash_10558e252cee3ebc", 0) != 0) {
    return true;
  }

  return false;
}

function get_focus_fire_damage_multiplier(ai) {
  if(!focus_fire_is_activated(ai)) {
    return 1;
  }

  base_focus_fire_multipler = get_base_focus_fire_multipler(ai);
  extra_focus_fire_multipler = get_extra_focus_fire_multipler(ai);
  var_d6f8eebd4e7c2b80 = base_focus_fire_multipler + extra_focus_fire_multipler;
  return var_d6f8eebd4e7c2b80;
}

function get_extra_focus_fire_multipler(ai) {
  var_ece82887f0275a7e = 0;

  if(getdvarfloat(@ "hash_775c537ab00693e3", 0) != 0) {
    var_ece82887f0275a7e = getdvarfloat(@ "hash_775c537ab00693e3");
  }

  return var_ece82887f0275a7e * ai.focus_fire_attackers.size;
}

function get_base_focus_fire_multipler(ai) {
  switch (ai.focus_fire_attackers.size) {
    case 1:
      return 1;
    case 2:
      return 8;
    case 3:
      return 27;
    case 4:
      return 64;
    default:
      return 64;
  }
}

function focus_fire_attacker_timeout(player, player_name, ai) {
  ai endon("death");
  ai notify("focus_fire_attacker_" + player_name);
  ai endon("focus_fire_attacker_" + player_name);
  scripts\engine\utility::waittill_any_ents_or_timeout_return(4.5, player, "disconnect");
  remove_player_from_focus_fire_attacker_list(player_name, ai);
}

function focus_fire_is_activated(ai) {
  return isDefined(ai.focus_fire_attackers);
}

function update_focus_fire_objective(ai) {
  if(!should_show_icon()) {
    return;
  }

  if(has_no_focus_fire_attackers(ai)) {
    ai notify("delete_focus_fire_icon");
    return;
  }

  if(!has_focus_fire_objective(ai)) {
    make_focus_fire_objective(ai);
    return;
  }

  objective_icon(ai.focus_fire_icon_objective_id, get_focus_fire_icon_image(ai));
}

function make_focus_fire_objective(ai) {
  focus_fire_icon_anchor = make_focus_fire_icon_anchor(ai);
  var_f5737839f388c9e9 = ai getentitynumber();
  focus_fire_icon_objective_id = scripts\cp\cp_objectives::requestworldid("enemy_AI_focus_fire_ID_" + var_f5737839f388c9e9, 22);
  objective_state(focus_fire_icon_objective_id, "current");
  objective_icon(focus_fire_icon_objective_id, get_focus_fire_icon_image(ai));
  objective_setbackground(focus_fire_icon_objective_id, 1);
  objective_addalltomask(focus_fire_icon_objective_id);
  objective_showtoplayersinmask(focus_fire_icon_objective_id);
  objective_setplayintro(focus_fire_icon_objective_id, 0);
  objective_setplayoutro(focus_fire_icon_objective_id, 0);
  objective_setshowdistance(focus_fire_icon_objective_id, 0);
  objective_setshowprogress(focus_fire_icon_objective_id, 0);
  objective_setfadedisabled(focus_fire_icon_objective_id, 1);
  objective_sethot(focus_fire_icon_objective_id, 1);
  objective_setpulsate(focus_fire_icon_objective_id, 0);
  objective_setshowoncompass(focus_fire_icon_objective_id, 0);
  objective_onentity(focus_fire_icon_objective_id, focus_fire_icon_anchor);
  ai.focus_fire_icon_objective_id = focus_fire_icon_objective_id;
  focus_fire_icon_anchor thread focus_fire_icon_delete_think(focus_fire_icon_anchor, ai, var_f5737839f388c9e9, focus_fire_icon_objective_id);
}

function focus_fire_icon_delete_think(focus_fire_icon_anchor, ai, var_f5737839f388c9e9, focus_fire_icon_objective_id) {
  focus_fire_icon_anchor endon("death");
  ai scripts\engine\utility::waittill_any_2("delete_focus_fire_icon", "death");
  scripts\cp\cp_objectives::freeworldid("enemy_AI_focus_fire_ID_" + var_f5737839f388c9e9);
  objective_delete(focus_fire_icon_objective_id);
  ai.focus_fire_icon_objective_id = undefined;
  focus_fire_icon_anchor delete();
}

function make_focus_fire_icon_anchor(ai) {
  var_3a70c1fc70465bda = (0, 0, 15);
  var_29bc20a32f4c0e7b = (23, 8, 0);
  var_2e6eaff9143cc4f = "j_neck";
  assertex(ai tagexists("<dev string:x111>"), "<dev string:x118>" + ai.model);
  anchor_pos = ai gettagorigin(var_2e6eaff9143cc4f);
  focus_fire_icon_anchor = spawn("script_model", anchor_pos + var_3a70c1fc70465bda);
  focus_fire_icon_anchor setModel("tag_origin");
  focus_fire_icon_anchor linkTo(ai, var_2e6eaff9143cc4f, var_29bc20a32f4c0e7b, (0, 0, 0));
  return focus_fire_icon_anchor;
}

function has_focus_fire_objective(ai) {
  return isDefined(ai.focus_fire_icon_objective_id);
}

function update_focus_fire_heahicon(ai) {
  if(!should_show_icon()) {
    return;
  }

  if(has_no_focus_fire_attackers(ai)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(ai.focus_fire_headicon);
    ai.focus_fire_headicon = undefined;
    return;
  }

  if(!has_focus_fire_headicon(ai)) {
    make_focus_fire_headicon(ai);
    return;
  }

  setheadiconimage(ai.focus_fire_headicon, get_focus_fire_icon_image(ai));
}

function should_show_icon() {
  if(getdvarint(@ "hash_10a66e3ddcd7de56", 0) != 0) {
    return false;
  }

  return true;
}

function has_no_focus_fire_attackers(ai) {
  return ai.focus_fire_attackers.size == 0;
}

function has_focus_fire_headicon(ai) {
  return isDefined(ai.focus_fire_headicon);
}

function make_focus_fire_headicon(ai) {
  icon_image = get_focus_fire_icon_image(ai);
  ai.focus_fire_headicon = ai scripts\cp_mp\entityheadicons::setheadicon_singleimage("allies", icon_image, 10, 1, undefined, undefined, undefined, 0, 1);
}

function get_focus_fire_icon_image(ai) {
  switch (ai.focus_fire_attackers.size) {
    case 1:
      return "hud_icon_focus_fire_bonus_level_one";
    case 2:
      return "hud_icon_focus_fire_bonus_level_two";
    case 3:
      return "hud_icon_focus_fire_bonus_level_three";
    case 4:
      return "hud_icon_focus_fire_bonus_level_four";
  }
}

function ondamagerelicfocusfire(eattacker, sweapon, evictim, smeansofdeath, shitloc, timeoffset) {}

function ondamagepredamagemodrelicfocusfire(eattacker, sweapon, evictim, smeansofdeath, shitloc, timeoffset) {
  if(isDefined(evictim) && isPlayer(evictim)) {
    return;
  }

  if(isDefined(eattacker.owner) && isPlayer(eattacker.owner)) {
    eattacker = eattacker.owner;
  }

  if(!(isDefined(eattacker) && isPlayer(eattacker))) {
    return;
  }

  player_name = eattacker getentitynumber();

  if(!is_player_in_focus_fire_attacker_list(player_name, evictim)) {
    add_player_to_focus_fire_attacker_list(player_name, evictim);
  }

  evictim thread focus_fire_attacker_timeout(eattacker, player_name, evictim);
}

function relic_focusfire_modifyplayerdamage(victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc) {
  var_d8c170ef92755062 = get_focus_fire_damage_multiplier(victim);
  return int(idamage * var_d8c170ef92755062);
}

function init_relic_focus_fire(player) {}

function set_relic_focus_fire(player) {
  player.ondamagerelics["relic_focus_fire"] = 1;
  player.ondamagepredamagemodrelics["relic_focus_fire"] = 1;
}

function unset_relic_focus_fire(player) {
  player.ondamagerelics["relic_focus_fire"] = 0;
  player.ondamagepredamagemodrelics["relic_focus_fire"] = 0;

  if(array_contains(level.modifyplayerdamage_relics, &relic_focusfire_modifyplayerdamage)) {
    level.modifyplayerdamage_relics = array_remove(level.modifyplayerdamage_relics, &relic_focusfire_modifyplayerdamage);
  }
}

function init_relic_gas_martyr(player) {}

function set_relic_gas_martyr(player) {
  player.onkillrelics["relic_gas_martyr"] = 1;
}

function unset_relic_gas_martyr(player) {
  player.onkillrelics["relic_gas_martyr"] = 0;
}

function handlerelicmartyrdomgas(sweapon, player, victim, smeansofdeath, shitloc, time) {
  handlerelicmartyrdom_common(sweapon, player, victim, smeansofdeath, shitloc, time, &get_gas_martyr_grenade_types);
}

function get_gas_martyr_grenade_types() {
  return ["gas_grenade_mp"];
}

function init_relic_martyrdom(player) {}

function set_relic_martyrdom(player) {
  player.onkillrelics["relic_martyrdom"] = 1;
}

function unset_relic_martyrdom(player) {
  player.onkillrelics["relic_martyrdom"] = 0;
}

function handlerelicmartyrdomfrag(sweapon, player, victim, smeansofdeath, shitloc, time) {
  handlerelicmartyrdom_common(sweapon, player, victim, smeansofdeath, shitloc, time, &get_martyrdom_grenade_types);
}

function handlerelicmartyrdom_common(sweapon, player, victim, smeansofdeath, shitloc, time, var_342004c21e418db6) {
  var_edaf3404678865e5 = 147456;
  var_1b7e6c4f6eeda5cc = "j_spine4";

  if(isDefined(victim.unittype) && victim.unittype == "suicidebomber") {
    return;
  }

  var_30587d786639993c = 15;
  grenade_velocity = anglesToForward(victim.angles);
  grenade_pos = victim gettagorigin(var_1b7e6c4f6eeda5cc) + grenade_velocity * var_30587d786639993c;
  grenade_types = [[var_342004c21e418db6]]();
  grenade_owner = victim;
  grenade_type = scripts\engine\utility::random(grenade_types);
  grenade = grenade_owner launchgrenade(grenade_type, grenade_pos, grenade_velocity * get_grenade_force(grenade_type), get_grenade_fuse_time(grenade_type));

  if(grenade_type == "concussion_grenade_mp") {
    grenade.owner = victim;
  } else {
    grenade.owner = spawnStruct();
    grenade.owner.team = "axis";
  }

  grenade.team = "neutral";

  switch (grenade_type) {
    case #"hash_5e4ccaa178cac19c":
      level thread do_manual_splash_damage_when_frag_explodes(grenade, player);
      break;
    case #"hash_ab3485fa6834de47":
      level thread scripts\cp\powers\coop_molotov::ai_molotov_used(grenade_owner, grenade);
      break;
    case #"hash_cac2107b8e726d9d":
      grenade_owner thread scripts\cp\equipment\cp_gas_grenade::gas_watchexplode(grenade);
      break;
    case #"hash_34e7a4cd11aed6bc":
      grenade thread scripts\cp\weapon::watchconcussiongrenadeexplode();
      break;
  }
}

function do_manual_splash_damage_when_frag_explodes(grenade, player) {
  grenade endon("trigger");
  grenade waittill("explode", origin);
  all_enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  if(all_enemies.size > 0) {
    radiusdamage(origin, 256, 140, 70, player, "MOD_GRENADE_SPLASH", makeweapon("frag_grenade_mp"));
    return;
  }

  radiusdamage(origin, 256, 140, 70, player, "MOD_GRENADE_SPLASH", makeweapon("frag_grenade_mp"));
}

function get_martyrdom_grenade_types() {
  var_63c9b3bf5e31443f = ["frag_grenade_mp"];
  var_85b74463af15b0bb = getDvar(@ "martyrdom_grenade_types", "");

  if(var_85b74463af15b0bb != "") {
    return generate_grenade_types_via_dvar(var_85b74463af15b0bb);
  }

  return var_63c9b3bf5e31443f;
}

function generate_grenade_types_via_dvar(var_85b74463af15b0bb) {
  var_336e790f2c0dee77 = strtok(var_85b74463af15b0bb, ",");
  result = [];

  foreach(var_ecd569e8fcac5f2a in var_336e790f2c0dee77) {
    result = scripts\engine\utility::array_add(result, get_actual_grenade_name(var_ecd569e8fcac5f2a));
  }

  return result;
}

function get_actual_grenade_name(var_ecd569e8fcac5f2a) {
  switch (var_ecd569e8fcac5f2a) {
    case #"hash_a8e4a914fb03a4d5":
      return "frag_grenade_mp";
    case #"hash_fb36696c0708bf42":
      return "gas_mp";
    case #"hash_c9a436974fe60919":
      return "molotov_mp";
    case #"hash_bed536fdef5df5":
      return "concussion_grenade_mp";
    default:
      assertmsg("Unsupported debug grenade type: " + var_ecd569e8fcac5f2a);
      break;
  }
}

function get_grenade_force(grenade_type) {
  switch (grenade_type) {
    case #"hash_5e4ccaa178cac19c":
      return 40;
    case #"hash_4cd748aa3895508a":
      return 400;
    case #"hash_ab3485fa6834de47":
      return 400;
    case #"hash_34e7a4cd11aed6bc":
      return 120;
    default:
      return 100;
  }
}

function get_grenade_fuse_time(grenade_type) {
  switch (grenade_type) {
    case #"hash_5e4ccaa178cac19c":
      return 1.5;
    case #"hash_d072a0adddda0068":
      return 1;
    default:
      return 1.5;
  }
}

function init_relic_gun_game(player) {
  function_c72ff775cd61b11(@ "hash_16c27bd9c165f4d6", 1, 0);
  level.var_317452953c148027 = undefined;

  if(!isDefined(level.var_72beade6989b19b8)) {
    level.var_72beade6989b19b8 = getdvarint(hashcat(@ "hash_95615ac316fc8872"), 30);
  }

  if(!istrue(level.var_3978bf00ed49711d)) {
    level.var_3978bf00ed49711d = 1;
    level.ladderindex = getdvarint(hashcat(@ "ladderindex"), 2);
    setgunladder();
    setgunsfinal();
  }
}

function set_relic_gun_game(player) {
  player.persistentrelics["relic_gun_game"] = 1;
  player.gungamegunindex = 0;
  player.gungameprevgunindex = 0;
  player loadweaponsforplayer(level.var_1a70639bf6482bc2, 1);
  scripts\cp\utility::function_c0d2c91f2688ece4(0);
  flag_wait("both_players_intro_binks_complete");

  if(istrue(level.var_efe609bce901caa8) && !flag("infil_over")) {
    flag_wait("infil_over");
  }

  player thread player_gun_game_randomize_weapon_list_think(player);
  player thread player_gun_game_next_weapon_think(player);
  player function_5d137d3132a633ed("kill");
  player thread refillammo();
  player thread refillsinglecountammo();
}

function refillammo() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("unset_gun_game");

  while(true) {
    self waittill("reload");

    if(!isDefined(self.primaryweapon)) {
      self.primaryweapon = self getcurrentweapon();
    }

    startingammo = weaponstartammo(self.primaryweapon);
    clipammo = weaponclipsize(self.primaryweapon);
    stockammo = startingammo - clipammo;
    self setweaponammostock(self.primaryweapon, stockammo);
  }
}

function refillsinglecountammo() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("unset_gun_game");

  while(true) {
    if(scripts\cp\utility\player::isreallyalive(self) && self.team != "spectator" && isDefined(self.primaryweapon) && self getammocount(self.primaryweapon) == 0) {
      wait 2;
      self notify("reload");
      wait 1;
      continue;
    }

    waitframe();
  }
}

function function_614de4f5a6a2452f(itemtype, itemindex) {
  if(itemtype == 1) {
    if(scripts\cp\cp_relics::function_30d732f612695ba8()) {
      thread scripts\cp\cp_hud_message::showerrormessage("MP/CANNOT_USE_GENERIC");
      return false;
    }
  }

  return true;
}

function setgunladder() {
  level.gun_guns = [];
  level.selectedweapons = [];
  level.var_71afb87754f28af8 = &function_614de4f5a6a2452f;
  function_2e08463451cf36ec();

  switch (level.ladderindex) {
    case 1:
    case 4:
    case 5:
    case 6:
      level.gun_guns[0] = "rand_pistol";
      level.gun_guns[1] = "rand_shotgun";
      level.gun_guns[2] = "rand_smg";
      level.gun_guns[3] = "rand_assault";
      level.gun_guns[4] = "rand_lmg";
      level.gun_guns[5] = "rand_sniper";
      level.gun_guns[6] = "rand_smg";
      level.gun_guns[7] = "rand_assault";
      level.gun_guns[8] = "rand_lmg";
      level.gun_guns[9] = "rand_launcher";
      level.gun_guns[10] = "rand_shotgun";
      level.gun_guns[11] = "rand_smg";
      level.gun_guns[12] = "rand_assault";
      level.gun_guns[13] = "rand_pistol";
      level.gun_guns[14] = "rand_assault";
      level.gun_guns[15] = "rand_sniper";
      level.gun_guns[16] = "rand_pistol";
      level.gun_guns[17] = "rand_knife_end";
      break;
    case 2:
      level.gun_guns[0] = "rand_pistol";
      level.gun_guns[1] = "rand_shotgun";
      level.gun_guns[2] = "rand_smg";
      level.gun_guns[3] = "rand_assault";
      level.gun_guns[4] = "rand_pistol";
      level.gun_guns[5] = "rand_shotgun";
      level.gun_guns[6] = "rand_smg";
      level.gun_guns[7] = "rand_assault";
      level.gun_guns[8] = "rand_pistol";
      level.gun_guns[9] = "rand_shotgun";
      level.gun_guns[10] = "rand_smg";
      level.gun_guns[11] = "rand_assault";
      level.gun_guns[12] = "rand_pistol";
      level.gun_guns[13] = "rand_shotgun";
      level.gun_guns[14] = "rand_smg";
      level.gun_guns[15] = "rand_assault";
      level.gun_guns[16] = "rand_pistol";
      level.gun_guns[17] = "rand_knife_end";
      break;
    case 3:
      level.gun_guns[0] = "rand_pistol";
      level.gun_guns[1] = "rand_assault";
      level.gun_guns[2] = "rand_lmg";
      level.gun_guns[3] = "rand_launcher";
      level.gun_guns[4] = "rand_sniper";
      level.gun_guns[5] = "rand_assault";
      level.gun_guns[6] = "rand_lmg";
      level.gun_guns[7] = "rand_launcher";
      level.gun_guns[8] = "rand_sniper";
      level.gun_guns[9] = "rand_assault";
      level.gun_guns[10] = "rand_lmg";
      level.gun_guns[11] = "rand_launcher";
      level.gun_guns[12] = "rand_sniper";
      level.gun_guns[13] = "rand_assault";
      level.gun_guns[14] = "rand_sniper";
      level.gun_guns[15] = "rand_assault";
      level.gun_guns[16] = "rand_pistol";
      level.gun_guns[17] = "rand_knife_end";
      break;
  }
}

function getggweapontablelootvariants(weapname) {
  variantids = [];
  rootname = scripts\cp_mp\weapon::getweaponrootname(weapname);
  variantids = tablelookup("mp/gunGameWeapons.csv", 1, rootname, 6);
  return variantids;
}

function setgunsfinal() {
  level.selectedweapons = [];
  function_6b7afefdbeeeec0a();

  for(i = 0; i < level.gun_guns.size; i++) {
    curgun = level.gun_guns[i];

    if(string_starts_with(curgun, "rand_")) {
      weapondata = function_5f97f15e9ca6cb6(curgun);

      if(isstring(weapondata) && weapondata == "none") {
        continue;
      }

      if(level.ladderindex == 4 || level.ladderindex == 5) {
        level.gun_guns[i] = buildweapon_blueprint(weapondata["weapon"], undefined, undefined, weapondata["variantID"], undefined, undefined, scripts\cp_mp\utility\game_utility::function_d2d2b803a7b741a4());
      } else {
        level.gun_guns[i] = function_96d23570114bc7b6(weapondata);
      }

      continue;
    }

    rootname = getweaponrootname(level.gun_guns[i]);
    level.selectedweapons[rootname] = 1;
    newweapon = rootname;
    numattachments = 0;

    if(level.ladderindex == 4 || level.ladderindex == 5) {
      variants = getggweapontablelootvariants(rootname);
      variantid = table_parseweaponvariantidvalue(rootname, variants);
      newweapon = buildweapon_blueprint(rootname, undefined, undefined, variantid, undefined, undefined, scripts\cp_mp\utility\game_utility::isnightmap());
    } else {
      variantid = 0;

      if(level.ladderindex == 6) {
        variants = getggweapontablelootvariants(rootname);
        variantid = table_parseweaponvariantidvalue(rootname, variants);
      }

      newweapon = gun_createrandomweapon(rootname, numattachments, variantid, scripts\cp_mp\utility\game_utility::isnightmap());
    }

    level.gun_guns[i] = newweapon;
  }

  level.selectedweapons = undefined;
}

function table_parseweaponvariantidvalue(rootweapon, value) {
  if(rootweapon == "none") {
    return 0;
  }

  if(!isDefined(level.blockedvariantidsmap)) {
    level.blockedvariantidsmap = [];
    level.blockedvariantidsmap["iw8_ar_tango21"] = [1];
    level.blockedvariantidsmap["iw8_ar_mike4"] = [5];
    level.blockedvariantidsmap["iw8_ar_kilo433"] = [3];
    level.blockedvariantidsmap["iw8_ar_scharlie"] = [3];
    level.blockedvariantidsmap["iw8_sm_uzulu"] = [4];
    level.blockedvariantidsmap["iw8_sh_romeo870"] = [5];
    level.blockedvariantidsmap["iw8_sh_dpapa12"] = [3];
    level.blockedvariantidsmap["iw8_lm_mgolf34"] = [4];
    level.blockedvariantidsmap["iw8_sn_kilo98"] = [16];
    level.blockedvariantidsmap["iw8_sn_alpha50"] = [2];
    level.blockedvariantidsmap["iw8_sn_hdromeo"] = [4];
    level.blockedvariantidsmap["iw8_pi_golf21"] = [3];
    level.blockedvariantidsmap["iw8_pi_cpapa"] = [15];
    var_a6f6c01484bd5665 = getDvar(@ "hash_4caa11caeebf587b", "");

    if(var_a6f6c01484bd5665 != "") {
      var_9c58c4f8acc9cf26 = strtok(var_a6f6c01484bd5665, ",");

      foreach(weaponvariant in var_9c58c4f8acc9cf26) {
        pair = strtok(weaponvariant, "|");

        if(pair.size == 2) {
          weaponblock = pair[0];
          idblock = int(pair[1]);

          if(!isDefined(level.blockedvariantidsmap[weaponblock])) {
            level.blockedvariantidsmap[weaponblock] = [];
          }

          level.blockedvariantidsmap[weaponblock][level.blockedvariantidsmap[weaponblock].size] = idblock;
        }
      }
    }
  }

  blockedids = undefined;

  if(isDefined(level.blockedvariantidsmap[rootweapon])) {
    blockedids = level.blockedvariantidsmap[rootweapon];
  }

  variantid = 0;
  forcerandom = getdvarint(@ "hash_c895ae760d4177d4", 0);

  if(forcerandom == 1) {
    variantid = scripts\cp\weapon::getweaponrandomvariantid(rootweapon, blockedids);
  } else {
    var_2891e3df80a13684 = strtok(value, " ");
    variantids = [];

    foreach(sid in var_2891e3df80a13684) {
      iid = int(sid);

      if(!isDefined(blockedids) || !array_contains(blockedids, iid)) {
        variantids[variantids.size] = iid;
      }
    }

    if(variantids.size != 0) {
      variantid = variantids[randomint(variantids.size)];
    }
  }

  if(variantid == -1) {
    variantid = scripts\cp\weapon::getweaponrandomvariantid(rootweapon, blockedids);
  }

  validweapon = scripts\cp\weapon::weaponisValid(rootweapon, variantid);

  if(getdvarint(@ "hash_4f69e011a95e06a9", 0) != 0) {
    assertex(validweapon, "getWeaponVariantFromTableValue() found invalid weapon: " + rootweapon + "|" + variantid);
  }

  if(!validweapon) {
    variantid = 0;
  }

  return variantid;
}

function function_6b7afefdbeeeec0a() {
  level.weaponcategories = [];

  for(row = 0; true; row++) {
    categoryname = tablelookupbyrow("mp/gunGameWeapons.csv", row, 0);

    if(categoryname == "") {
      break;
    }

    if(!isDefined(level.weaponcategories[categoryname])) {
      level.weaponcategories[categoryname] = [];
    }

    requiredpack = tablelookupbyrow("mp/gunGameWeapons.csv", row, 5);

    if(requiredpack == "" || getdvarint(requiredpack, 0) == 1) {
      data = [];
      data["weapon"] = getweaponrootname(tablelookupbyrow("mp/gunGameWeapons.csv", row, 1));
      data["min"] = int(tablelookupbyrow("mp/gunGameWeapons.csv", row, 2));
      data["max"] = int(tablelookupbyrow("mp/gunGameWeapons.csv", row, 3));
      data["perk"] = tablelookupbyrow("mp/gunGameWeapons.csv", row, 4);
      data["allowed"] = int(tablelookupbyrow("mp/gunGameWeapons.csv", row, 7));

      if((level.ladderindex == 4 || level.ladderindex == 6) && !data["allowed"]) {
        row++;
        continue;
      }

      level.weaponcategories[categoryname][level.weaponcategories[categoryname].size] = data;
    }
  }
}

function function_5f97f15e9ca6cb6(categoryname) {
  weaponlist = level.weaponcategories[categoryname];

  if(isDefined(weaponlist) && weaponlist.size > 0) {
    newweapon = "";
    data = undefined;

    for(loopcount = 0; true; loopcount++) {
      index = randomintrange(0, weaponlist.size);
      data = weaponlist[index];
      rootname = getweaponrootname(data["weapon"]);
      var_aaa935a3ebf3fd7c = 1;

      if(level.ladderindex == 4 || level.ladderindex == 6) {
        var_aaa935a3ebf3fd7c = data["allowed"];
      }

      if(!isDefined(level.selectedweapons[rootname]) && var_aaa935a3ebf3fd7c || loopcount > weaponlist.size) {
        level.selectedweapons[rootname] = 1;

        for(i = 0; i < level.weaponcategories[categoryname].size; i++) {
          if(level.weaponcategories[categoryname][i]["weapon"] == data["weapon"]) {
            level.weaponcategories[categoryname] = array_remove_index(level.weaponcategories[categoryname], i);
            break;
          }
        }

        break;
      }
    }

    if(level.ladderindex == 4 || level.ladderindex == 6) {
      variants = getggweapontablelootvariants(data["weapon"]);
      data["variantID"] = table_parseweaponvariantidvalue(data["weapon"], variants);
    } else if(level.ladderindex == 5) {
      data["variantID"] = table_parseweaponvariantidvalue(data["weapon"], "-1");
    }

    return data;
  }

  if(getdvarint(@ "hash_4f69e011a95e06a9", 0) != 0) {
    assertmsg("Unknown weapon category name " + categoryname);
  }

  return "none";
}

function function_96d23570114bc7b6(weapondata) {
  numattachments = randomintrange(weapondata["min"], weapondata["max"] + 1);
  newweapon = gun_createrandomweapon(weapondata["weapon"], numattachments, weapondata["variantID"], scripts\cp_mp\utility\game_utility::isnightmap());
  return newweapon;
}

function getrandomgraverobberattachment(currentweapon, var_79583f5b5010a954) {
  if(!isDefined(currentweapon)) {
    return undefined;
  }

  rootname = getweaponrootname(currentweapon);
  currentattachments = getweaponattachments(currentweapon);
  possibleattachments = [];

  if(isDefined(var_79583f5b5010a954) && var_79583f5b5010a954.size > 0) {
    possibleattachments = var_79583f5b5010a954;
  } else {
    possibleattachments = scripts\cp\weapon::getallselectableattachments(rootname);
  }

  if(!isDefined(possibleattachments)) {
    return undefined;
  }

  foreach(currentattachment in currentattachments) {
    if(!scripts\cp\weapon::attachmentisselectable(currentweapon, currentattachment)) {
      currentattachments[_index] = undefined;
    }
  }

  possibleattachments = array_convert_keys_to_ints(possibleattachments);
  possibleattachments = array_randomize(possibleattachments);

  foreach(var_9112261a40fb1b9b in possibleattachments) {
    if(!isgraverobberattachment(rootname, var_9112261a40fb1b9b)) {
      continue;
    }

    attachmentsconflict = 0;

    foreach(currentattachment in currentattachments) {
      if(attachmentsconflict(currentattachment, var_9112261a40fb1b9b, currentweapon) != "") {
        attachmentsconflict = 1;
        break;
      }
    }

    if(attachmentsconflict) {
      continue;
    }

    return var_9112261a40fb1b9b;
  }

  return undefined;
}

function isgraverobberattachment(weapon, attachmentbasename) {
  if(!scripts\cp\weapon::attachmentisselectable(weapon, attachmentbasename)) {
    return false;
  }

  switch (attachmentbasename) {
    case #"hash_46abc44d4b683c0c":
    case #"hash_ae7694515b4b215c":
    case #"hash_cace574b66d79951":
      return false;
  }

  if(issubstr(attachmentbasename, "thermal")) {
    return false;
  }

  if(issubstr(attachmentbasename, "burst")) {
    return false;
  }

  if(getsubstr(attachmentbasename, 0, 3) == "cal") {
    return false;
  }

  return true;
}

function gun_createrandomweapon(rootname, numattachments, variantid, hasnvg) {
  if(level.ladderindex == 6) {
    if(!isDefined(numattachments)) {
      numattachments = randomintrange(0, 0);
    }

    var_b8215055a946eebb = buildweapon(rootname, undefined, undefined, undefined, undefined, undefined, undefined, undefined, hasnvg);
    var_79583f5b5010a954 = gun_buildoverrideattachmentlist(rootname);
    var_952f1674fa8d734f = [];

    for(i = 0; i < numattachments; i++) {
      attachment = getrandomgraverobberattachment(var_b8215055a946eebb, var_79583f5b5010a954);

      if(!isDefined(attachment)) {
        break;
      }

      newweaponobj = scripts\cp\weapon::addattachmenttoweapon(var_b8215055a946eebb, attachment);

      if(isDefined(newweaponobj)) {
        var_b8215055a946eebb = newweaponobj;
      }

      var_952f1674fa8d734f[var_952f1674fa8d734f.size] = attachment;
    }

    var_b8215055a946eebb = buildweapon_blueprintwithcustomattachments(rootname, var_952f1674fa8d734f, undefined, undefined, variantid, undefined, undefined, undefined, hasnvg);
    return var_b8215055a946eebb;
  }

  if(isDefined(variantid) && variantid != 0) {
    var_b8215055a946eebb = buildweapon_blueprint(rootname, undefined, undefined, variantid, undefined, undefined, hasnvg);
  } else {
    var_b8215055a946eebb = buildweapon(rootname, undefined, undefined, undefined, undefined, undefined, undefined, undefined, hasnvg);
  }

  if(!isDefined(numattachments)) {
    numattachments = randomintrange(0, 0);
  }

  var_79583f5b5010a954 = gun_buildoverrideattachmentlist(var_b8215055a946eebb);

  for(i = 0; i < numattachments; i++) {
    attachment = getrandomgraverobberattachment(var_b8215055a946eebb, var_79583f5b5010a954);

    if(!isDefined(attachment)) {
      break;
    }

    newweaponobj = scripts\cp\weapon::addattachmenttoweapon(var_b8215055a946eebb, attachment);

    if(isDefined(newweaponobj)) {
      var_b8215055a946eebb = newweaponobj;
    }
  }

  return var_b8215055a946eebb;
}

function gun_buildoverrideattachmentlist(randomweapon) {
  possibleattachments = scripts\cp\weapon::getallselectableattachments(randomweapon);
  var_79583f5b5010a954 = [];

  foreach(attachment in possibleattachments) {
    if(isstartstr(attachment, "gl") || isstartstr(attachment, "ub") || isstartstr(attachment, "thermal") || attachment == "hybrid3") {
      continue;
    }

    var_79583f5b5010a954[var_79583f5b5010a954.size] = attachment;
  }

  return var_79583f5b5010a954;
}

function attachmentcheck(attachment, var_517683bad763b676, var_a71a84cdad3a4ebb, weaponname) {
  attachmentcategory = tablelookup(var_a71a84cdad3a4ebb, 0, attachment, 1);

  for(i = 0; i < var_517683bad763b676.size; i++) {
    var_e012c12f441a9c1d = tablelookup(var_a71a84cdad3a4ebb, 0, var_517683bad763b676[i], 1);

    if(attachment == var_517683bad763b676[i] || attachmentsconflict(attachment, var_517683bad763b676[i], weaponname) != "" || attachmentcategory == var_e012c12f441a9c1d) {
      return false;
    }
  }

  return true;
}

function function_5d137d3132a633ed(type) {
  waittime = level.var_72beade6989b19b8;
  var_9cc83556135dbea7 = 0;

  if(type == "hit") {
    waittime = int((self.var_5f020cd300675ccb - gettime()) / 1000 + 1);

    if(waittime > level.var_72beade6989b19b8) {
      waittime = level.var_72beade6989b19b8;
    }
  } else if(type == "assist") {
    if(var_9cc83556135dbea7) {
      waittime = int(min((self.var_5f020cd300675ccb - gettime()) / 1000 + level.var_72beade6989b19b8 * 0.25, level.var_72beade6989b19b8));
    } else {
      waittime = int(min((self.var_5f020cd300675ccb - gettime()) / 1000 + level.var_72beade6989b19b8 * 0.5, level.var_72beade6989b19b8));
    }
  } else if(type == "friendly_tag") {
    waittime = int(min((self.var_5f020cd300675ccb - gettime()) / 1000 + level.var_72beade6989b19b8 * 0.25, level.var_72beade6989b19b8));
  } else if(var_9cc83556135dbea7) {
    if(isDefined(self.gungame) && self.gungame && isDefined(self.var_5f020cd300675ccb)) {
      waittime = int(min((self.var_5f020cd300675ccb - gettime()) / 1000 + level.var_72beade6989b19b8 * 0.5, level.var_72beade6989b19b8));
    } else {
      waittime = int(waittime * 0.5);
    }
  } else {
    waittime = level.var_72beade6989b19b8;
  }

  endtime = waittime * 1000 + gettime();
  self setclientomnvar("ui_gungame_timer_end_milliseconds", endtime);
  self.var_5f020cd300675ccb = endtime;
  thread function_85880d716b8ab09d();
  thread function_4ccab81fcdb158fd(waittime);
  thread function_e5f947d60bf46f2b();
}

function function_85880d716b8ab09d() {
  self notify("watchGunGameHostMigration");
  self endon("watchGunGameHostMigration");
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("stop_gungame");
  level waittill("host_migration_begin");
  timepassed = scripts\cp\cp_hostmigration::waittillhostmigrationdone();

  if(timepassed > 0) {
    self setclientomnvar("ui_gungame_timer_end_milliseconds", self.var_5f020cd300675ccb + timepassed);
    return;
  }

  self setclientomnvar("ui_gungame_timer_end_milliseconds", self.var_5f020cd300675ccb);
}

function function_e5f947d60bf46f2b() {
  self notify("watchEndGame");
  self endon("watchEndGame");
  self endon("death_or_disconnect");
  self endon("stop_gungame");

  while(true) {
    if(game["state"] == "postgame" || level.gameended) {
      self setclientomnvar("ui_gungame_timer_end_milliseconds", 0);
      break;
    }

    wait 0.1;
  }
}

function function_4ccab81fcdb158fd(waittime) {
  self notify("watchBombTimer");
  self endon("watchBombTimer");
  self endon("disconnect");
  level endon("game_ended");
  self endon("stop_gungame");
  thread function_a4215ef9d63d48df(waittime);
  countdown_time = 5;
  var_8440421626c8b0cf = waittime - countdown_time - 1;

  if(var_8440421626c8b0cf > 0) {
    scripts\cp\cp_hostmigration::waitlongdurationwithgameendtimeupdate(var_8440421626c8b0cf);
    scripts\cp\cp_hostmigration::waitlongdurationwithgameendtimeupdate(1);
  }

  while(countdown_time > 0) {
    scripts\cp\cp_hostmigration::waitlongdurationwithgameendtimeupdate(1);
    countdown_time--;
  }

  if(isDefined(self) && scripts\cp\utility\player::isreallyalive(self) && getgametype() != "tdef") {
    self notify("gun_game_next_weapon");
    function_5d137d3132a633ed("kill");
  }
}

function function_a4215ef9d63d48df(waittime) {
  self endon("death");
  self notify("refreshGunGameUIProgress");
  self endon("refreshGunGameUIProgress");
  currenttimelimitdelay = 0;
  updaterate = 0;

  if(waittime != level.var_72beade6989b19b8) {
    currenttimelimitdelay = level.var_72beade6989b19b8 - waittime;
  }

  while(true) {
    currenttimelimitdelay += 0.05;
    progress = clamp(1 - currenttimelimitdelay / level.var_72beade6989b19b8, 0, 1);
    self setclientomnvar("ui_gungame_timer", progress);
    wait 0.05;
  }
}

function takeweaponwhensafegungame(weapon, allowswitch) {
  self endon("death_or_disconnect");

  while(true) {
    if(!scripts\cp_mp\utility\inventory_utility::iscurrentweapon(weapon)) {
      break;
    }

    waitframe();
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(weapon);

  if(allowswitch) {
    val::reset_all("spawn_weapon");
  }
}

function function_7915e88a08f28705() {
  if(getDvar(@ "scr_set_relics", "") == "") {
    return false;
  }

  return true;
}

function function_30d732f612695ba8() {
  if(istrue(level.var_3978bf00ed49711d)) {
    return true;
  }

  var_934386cae08481b2 = getDvar(@ "scr_set_relics", "");
  var_ce22ef601c001a14 = strtok(var_934386cae08481b2, ",");

  foreach(relic in var_ce22ef601c001a14) {
    if(relic == "relic_gun_game") {
      return true;
    }
  }

  return false;
}

function player_gun_game_next_weapon_think(player) {
  player endon("disconnect");
  player notify("player_gun_game_next_weapon_think");
  player endon("player_gun_game_next_weapon_think");
  player endon("unset_gun_game");
  player.gun_game_primary_weapon = player.primaryweaponobj;

  while(true) {
    player waittill("gun_game_next_weapon");
    flag_wait("both_players_intro_binks_complete");

    if(istrue(level.var_efe609bce901caa8) && !flag("infil_over")) {
      flag_wait("infil_over");
    }

    while(player secondaryoffhandbuttonPressed() || player isthrowinggrenade() || player isthrowingbackgrenade() || player fragButtonPressed() || player ishanging() || istrue(player.inlaststand) || istrue(player.iscarrying) || istrue(player.bgivensentry) || player isswitchingweapon() || player scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress()) {
      waitframe();
    }

    player notify("equip_deploy_cancel");
    primary_weapon_obj = get_random_primary_weapon_obj(player);
    player scripts\cp_mp\utility\inventory_utility::_giveweapon(primary_weapon_obj, undefined, undefined, undefined);
    player setweaponammoclip(primary_weapon_obj, weaponclipsize(primary_weapon_obj));
    weaponammotype = scripts\cp\pickups::br_ammo_type_for_weapon(primary_weapon_obj);

    if(isDefined(weaponammotype)) {
      maxstock = weaponmaxammo(primary_weapon_obj);

      if(isDefined(maxstock)) {
        scripts\cp\pickups::br_ammo_give_type(player, weaponammotype, maxstock);
      }
    }

    player.pers["primaryWeapon"] = primary_weapon_obj.basename;
    player.primaryweapon = primary_weapon_obj.basename;
    player.primaryweaponobj = primary_weapon_obj;
    player setspawnweapon(primary_weapon_obj, 1);
    player scripts\cp_mp\utility\inventory_utility::_switchtoweapon(primary_weapon_obj);

    foreach(weapon in self.weaponlist) {
      if(weapon != primary_weapon_obj && weapon != player.var_88350dac5063d94e) {
        player thread scripts\cp_mp\utility\inventory_utility::takeweaponwhensafe(weapon);
      }
    }

    currentweapon = player.lastdroppableweaponobj;
    player thread takeweaponwhensafegungame(currentweapon, 1);
    player.gun_game_primary_weapon = primary_weapon_obj;
  }
}

function function_dfef4a2e716402ce(var_6eb7362dc307d4c6) {
  player = self;

  while(true) {
    self waittill("weapon_change", newweaponobj);

    if(scripts\cp\weapon::isprimaryweapon(newweaponobj)) {
      continue;
    }

    self iprintln(var_6eb7362dc307d4c6.basename);

    if(newweaponobj.basename == var_6eb7362dc307d4c6.basename) {
      break;
    }
  }
}

function function_2894aca863446b64(sweapon, eattacker, victim, smeansofdeath, shitloc, time) {
  if(!isPlayer(eattacker)) {
    return;
  }

  eattacker notify("gun_game_next_weapon");
}

function handlepersistentgungame(player, weapon) {
  player endon("disconnect");
  player notify("handlePersistentGunGame");
  player endon("handlePersistentGunGame");
  player endon("unset_gun_game");

  if(getdvarint(@ "hash_ecc8e20c7c40ee41", 1) != 0) {
    return;
  }

  while(true) {
    player waittill("weapon_fired", objweapon);

    if(isDefined(player.gun_game_primary_weapon) && !scripts\cp\laststand::player_in_laststand(player)) {
      var_d8c1a9b6f71f67d1 = player getweaponammoclip(player.gun_game_primary_weapon) + player getweaponammostock(player.gun_game_primary_weapon);

      if(var_d8c1a9b6f71f67d1 == 0) {
        player notify("gun_game_next_weapon");
      }

      if(!player hasweapon(player.gun_game_primary_weapon)) {
        player notify("gun_game_next_weapon");
      }
    }
  }
}

function player_gun_game_randomize_weapon_list_think(player) {
  player endon("disconnect");
  player notify("player_gun_game_randomize_weapon_list_think");
  player endon("player_gun_game_randomize_weapon_list_think");
  player endon("unset_gun_game");

  while(true) {
    if(!player ent_flag_exist("player_spawned_with_loadout")) {
      player ent_flag_init("player_spawned_with_loadout");
    }

    player ent_flag_wait("player_spawned_with_loadout");

    if(!istrue(player.var_462062384567c594)) {
      wait 2;
      player.var_462062384567c594 = 1;
    }

    if(isDefined(player.secondaryweaponobj)) {
      if(player.secondaryweaponobj != level.var_bcd25cd23011249["fists"]) {
        player takeweapon(player.secondaryweaponobj);
        function_b958fc6e0ff72244(player);
      }
    } else {
      function_b958fc6e0ff72244(player);
    }

    player setweaponammoclip(player.primaryweaponobj, weaponclipsize(player.primaryweaponobj));
    player setweaponammostock(player.primaryweaponobj, weaponmaxammo(player.primaryweaponobj));
    generate_randomized_primary_weapon_objs(player);
    return;
  }
}

function function_b958fc6e0ff72244(player) {
  if(function_29381b5c03baa877(player)) {
    player.var_88350dac5063d94e = level.var_bcd25cd23011249["fists"];
    player scripts\cp_mp\utility\inventory_utility::_giveweapon(player.var_88350dac5063d94e);
  }
}

function function_29381b5c03baa877(player) {
  if(!self hasweapon(level.var_bcd25cd23011249["fists"])) {
    return true;
  }

  return false;
}

function get_random_primary_weapon_obj(player) {
  result = player.randomized_primary_weapon_objs[player.randomized_primary_weapon_index];
  assertex(isDefined(result), " Result undefined for index: ^1" + player.randomized_primary_weapon_index);

  if(!isDefined(result)) {
    return player.randomized_primary_weapon_objs[player.randomized_primary_weapon_index];
  }

  player.randomized_primary_weapon_index++;

  if(player.randomized_primary_weapon_index == player.randomized_primary_weapon_objs.size) {
    player.randomized_primary_weapon_index = 0;
    player.randomized_primary_weapon_objs = array_randomize(level.var_1a70639bf6482bc2);

    player iprintln("<dev string:x13b>");
  } else {
    player iprintln("<dev string:x157>" + player.randomized_primary_weapon_index);
  }

  return result;
}

function generate_randomized_primary_weapon_objs(player) {
  player.randomized_primary_weapon_index = 0;
  player.randomized_primary_weapon_objs = array_randomize(level.var_1a70639bf6482bc2);
}

function function_2e08463451cf36ec() {
  if(isDefined(level.var_1a70639bf6482bc2)) {
    return;
  }

  level.var_1a70639bf6482bc2 = [];
  level.var_1a70639bf6482bc2[level.var_1a70639bf6482bc2.size] = buildweapon("iw9_pi_decho_mp", array_combine(function_6527364c1ecca6c6("iw9_pi_decho_mp"), ["ammo_50p", "bar_pi_hvylong_p25", "comp_decho_01", "mag_pi_large_p25", "stockno_pi_p25", "trigger_p25"]));
  level.var_1a70639bf6482bc2[level.var_1a70639bf6482bc2.size] = buildweapon("iw9_pi_papa220_mp", array_combine(function_6527364c1ecca6c6("iw9_pi_papa220_mp"), ["silencer01_pi", "iw9_minireddot01_pstl"]));
  level.var_1a70639bf6482bc2[level.var_1a70639bf6482bc2.size] = buildweapon("iw9_pi_golf17_mp", array_combine(function_6527364c1ecca6c6("iw9_pi_golf17_mp"), ["mag_pi_xlarge_p24"]));
  level.var_1a70639bf6482bc2[level.var_1a70639bf6482bc2.size] = buildweapon("iw9_pi_swhiskey_mp", array_combine(function_6527364c1ecca6c6("iw9_pi_swhiskey_mp"), ["akimbo_swhiskey"]));
  level.var_1a70639bf6482bc2[level.var_1a70639bf6482bc2.size] = buildweapon("iw9_sh_mbravo_mp", function_6527364c1ecca6c6("iw9_sh_mbravo_mp"));
  level.var_1a70639bf6482bc2[level.var_1a70639bf6482bc2.size] = buildweapon("iw9_sh_mike1014_mp", function_6527364c1ecca6c6("iw9_sh_mike1014_mp"));
  level.var_1a70639bf6482bc2[level.var_1a70639bf6482bc2.size] = buildweapon("iw9_sh_mviktor_mp", function_6527364c1ecca6c6("iw9_sh_mviktor_mp"));
  level.var_1a70639bf6482bc2[level.var_1a70639bf6482bc2.size] = buildweapon("iw9_sm_papa90_mp", function_6527364c1ecca6c6("iw9_sm_papa90_mp"));
  level.var_1a70639bf6482bc2[level.var_1a70639bf6482bc2.size] = buildweapon("iw9_sm_beta_mp", array_combine(function_6527364c1ecca6c6("iw9_sm_beta_mp"), ["holo01", "pgrip_p04"]));
  level.var_1a70639bf6482bc2[level.var_1a70639bf6482bc2.size] = buildweapon("iw9_br_msecho_mp", function_6527364c1ecca6c6("iw9_br_msecho_mp"));
  level.var_1a70639bf6482bc2[level.var_1a70639bf6482bc2.size] = buildweapon("iw9_br_soscar14_mp", array_combine(function_6527364c1ecca6c6("iw9_br_soscar14_mp"), ["arscope01"]));
  level.var_1a70639bf6482bc2[level.var_1a70639bf6482bc2.size] = buildweapon("iw9_ar_scharlie_mp", function_6527364c1ecca6c6("iw9_ar_scharlie_mp"));
  level.var_1a70639bf6482bc2[level.var_1a70639bf6482bc2.size] = buildweapon("iw9_dm_mike24_mp", function_6527364c1ecca6c6("iw9_dm_mike24_mp"));
  level.var_1a70639bf6482bc2[level.var_1a70639bf6482bc2.size] = buildweapon("iw9_lm_rkilo_mp", array_combine(function_6527364c1ecca6c6("iw9_lm_rkilo_mp"), ["bipod_rkilo", "fourx02"]));
  level.var_1a70639bf6482bc2[level.var_1a70639bf6482bc2.size] = buildweapon("iw9_lm_slima_mp", function_6527364c1ecca6c6("iw9_lm_slima_mp"));
  level.var_1a70639bf6482bc2[level.var_1a70639bf6482bc2.size] = buildweapon("iw9_dm_sbeta_mp", array_combine(function_6527364c1ecca6c6("iw9_dm_sbeta_mp"), ["dmscope01", "lever_heavy_p19"]));
  level.var_1a70639bf6482bc2[level.var_1a70639bf6482bc2.size] = buildweapon("iw9_sn_limax_mp", array_combine(function_6527364c1ecca6c6("iw9_sn_limax_mp"), ["ammo_50b"]));
  level.var_1a70639bf6482bc2[level.var_1a70639bf6482bc2.size] = buildweapon("iw9_la_rpapa7_mp", function_6527364c1ecca6c6("iw9_la_rpapa7_mp"));
  level.var_1a70639bf6482bc2[level.var_1a70639bf6482bc2.size] = buildweapon("iw9_la_mike32_mp", function_6527364c1ecca6c6("iw9_la_mike32_mp"));
  level.var_1a70639bf6482bc2[level.var_1a70639bf6482bc2.size] = buildweapon("iw9_lm_dblmg2_cp", array_combine(function_6527364c1ecca6c6("iw9_lm_dblmg2_cp"), ["dynamic_null_dblmg", "laserads_bright_dblmg"]));
  level.var_1a70639bf6482bc2[level.var_1a70639bf6482bc2.size] = buildweapon("iw9_sn_mromeo_mp", function_6527364c1ecca6c6("iw9_sn_mromeo_mp"));
  level.var_1a70639bf6482bc2[level.var_1a70639bf6482bc2.size] = buildweapon("iw9_dm_la700_mp", array_combine(function_6527364c1ecca6c6("iw9_dm_la700_mp"), ["fourxtherm01", "xmag_sn_p20", "bar_sn_p20_la700"]));
  level.var_1a70639bf6482bc2[level.var_1a70639bf6482bc2.size] = buildweapon("iw9_sm_victor_mp", array_combine(function_6527364c1ecca6c6("iw9_sm_victor_mp"), ["lasercyl_hip03", "drum_p10", "holo01", "grip_vert04"]));
}

function create_primary_weapon_obj_from_custom_loadout(player, custom_loadout_index) {
  struct = spawnStruct();
  var_d0ef877013d341af = player scripts\cp\loadout::loadout_updateclasscustom(struct, custom_loadout_index);
  primary_weapon_obj = scripts\cp_mp\weapon::buildweapon(var_d0ef877013d341af.loadoutprimary, var_d0ef877013d341af.loadoutprimaryattachments, var_d0ef877013d341af.loadoutprimarycamo, var_d0ef877013d341af.loadoutprimaryreticle, var_d0ef877013d341af.loadoutprimaryvariantid, var_d0ef877013d341af.loadoutprimaryattachmentids, var_d0ef877013d341af.loadoutprimarycosmeticattachment, var_d0ef877013d341af.loadoutprimarystickers, istrue(var_d0ef877013d341af.loadouthasnvg));
  primary_weapon_obj = scripts\cp\loadout::give_weapon_alt_clip_ammo_hack(player, primary_weapon_obj);
  return primary_weapon_obj;
}

function unset_relic_gun_game(player) {
  player.persistentrelics["relic_gun_game"] = 0;
  level.var_3978bf00ed49711d = undefined;
  scripts\cp\utility::function_c0d2c91f2688ece4(1);
  player notify("unset_gun_game");
}

function init_relic_dfa(player) {}

function set_relic_dfa(player) {
  player.stealthtimeelapsed = 0;
}

function unset_relic_dfa(player) {
  player.stealthtimeelapsed = undefined;
}

function handledeathfromabove() {
  level thread start_death_from_above_sequence();
}

function start_death_from_above_sequence(var_b4a73ef4935724be) {
  wait 45;
  level.disableannouncer = undefined;

  switch (level.script) {
    case #"hash_a810885500a2bb04":
      level thread scripts\cp\killstreaks\gunship_cp::enemygunship_spawngunship(75, undefined, (-18750.2, 9332.44, 0), 40000, 15000, var_b4a73ef4935724be);
      break;
    case #"hash_7344128ff773082f":
      level thread scripts\cp\killstreaks\gunship_cp::enemygunship_spawngunship(45, undefined, undefined, 40000, 15000, var_b4a73ef4935724be);
      break;
    case #"hash_5ecfbef1b5de6c84":
      level thread scripts\cp\killstreaks\gunship_cp::enemygunship_spawngunship(45, undefined, (3289.02, 45965.8, 0), 40000, 15000, var_b4a73ef4935724be);
      break;
    default:
      level thread scripts\cp\killstreaks\gunship_cp::enemygunship_spawngunship(45, undefined, undefined, undefined, undefined, var_b4a73ef4935724be);
      break;
  }
}

function init_relic_aggressive_melee(player) {}

function set_relic_aggressive_melee(player) {
  scripts\cp\spawning::add_global_spawn_function("axis", &set_relic_aggressive_melee_params);

  foreach(guy in level.spawned_enemies) {
    guy set_relic_aggressive_melee_params();
  }
}

function unset_relic_aggressive_melee(player) {
  scripts\cp\spawning::remove_global_spawn_function("axis", &set_relic_aggressive_melee_params);

  foreach(guy in level.spawned_enemies) {
    guy unset_relic_aggressive_melee_params();
  }
}

function set_relic_aggressive_melee_params() {
  thread aggressively_chase_down_target(self);
  self.var_ba227281de712e68 = 1;
  self.var_384c9cc6cd2605d0 = 1;

  if(self.meleechargedistvsplayer < 3000) {
    self.aggressive_melee_active = 1;
    self.original_meleechargedistvsplayer = self.meleechargedistvsplayer;
    self.meleechargedistvsplayer = 3000;
  }
}

function unset_relic_aggressive_melee_params() {
  self.var_ba227281de712e68 = 0;
  self.var_384c9cc6cd2605d0 = 0;
  self notify("stop_aggressively_chase_down_target");

  if(istrue(self.aggressive_melee_active)) {
    self.meleechargedistvsplayer = self.original_meleechargedistvsplayer;
    self.original_meleechargedistvsplayer = undefined;
    self.aggressive_melee_active = undefined;
  }
}

function aggressively_chase_down_target(enemy_ai) {
  enemy_ai endon("death");
  enemy_ai endon("stop_aggressively_chase_down_target");

  while(true) {
    if(isDefined(enemy_ai.enemy) && isPlayer(enemy_ai.enemy)) {
      var_831198d90cf1bdf4 = getclosestpointonnavmesh(enemy_ai.enemy.origin);
      enemy_ai setgoalpos(var_831198d90cf1bdf4);
    }

    wait 1;
  }
}

function init_relic_thirdperson(player) {
  player.relic_third_person = 1;
  player setcamerathirdperson(1);
}

function set_relic_thirdperson(player) {
  player.relic_third_person = 1;
  player thread set_thirdperson();
}

function set_thirdperson() {
  self endon("death");
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;
  self setcamerathirdperson(1);
}

function unset_relic_thirdperson(player) {
  player.relic_third_person = undefined;
  player setcamerathirdperson(0);
}

function init_relic_noregen(player) {
  player.disable_health_regen = 1;
}

function set_relic_noregen(player) {
  player.disable_health_regen = 1;
}

function unset_relic_noregen(player) {
  player.disable_health_regen = undefined;
}

function init_relic_vampire(player) {
  player thread update_health_on_spawn();
}

function relic_vampire_globalfunc() {
  level.relic_vampire = 1;
  setomnvar("ui_showhealthbar", 1);
}

function set_relic_vampire(player) {
  player.ondamagerelics["relic_vampire"] = 1;
}

function unset_relic_vampire(player) {
  level.relic_vampire = 0;
}

function ondamagerelicvampire(eattacker, sweapon, evictim, smeansofdeath, shitloc, timeoffset) {
  if(!isagent(evictim)) {
    return;
  }

  player = undefined;

  if(!isPlayer(eattacker)) {
    if(!isDefined(eattacker.owner)) {
      return;
    } else {
      player = eattacker.owner;
    }
  } else {
    player = eattacker;
  }

  if(isDefined(player) && !istrue(player.inlaststand)) {
    if(player.health + 5 > player.maxhealth) {
      player scripts\cp\damage::set_normalhealth(player.maxhealth / player.maxhealth);
    } else {
      player scripts\cp\damage::set_normalhealth((player.health + 5) / player.maxhealth);
    }

    if(!isDefined(player.last_vampire_feedback)) {
      player.last_vampire_feedback = 0;
    }

    if(gettime() < player.last_vampire_feedback) {
      return;
    }

    player.last_vampire_feedback = gettime() + 300;
    player thread relic_vampire_feedback();
  }
}

function relic_vampire_feedback() {
  self endon("last_stand");
  self endon("disconnect");
  wait 0.25;
  self setclientomnvar("damage_feedback_icon", "hitadrenaline");
  self setclientomnvar("damage_feedback_icon_notify", gettime());

  if(!isDefined(self.last_vampire_sound)) {
    self.last_vampire_sound = 0;
  }

  if(gettime() < self.last_vampire_sound) {
    return;
  }

  self playlocalsound("cp_hacking_success");
  self.last_vampire_sound = gettime() + 500;
}

function init_relic_healthpacks(player) {
  player thread update_health_on_spawn();
}

function relic_healthpacks_globalfunc() {
  level.relic_healthpacks = 1;
  setomnvar("ui_showhealthbar", 1);
  level.healthpack_health = getdvarint(@ "hash_27042faeadc74c6c", 25);
}

function set_relic_healthpacks(player) {
  player.onkillrelics["relic_healthpacks"] = 1;
}

function unset_relic_healthpacks(player) {
  player.onkillrelics["relic_healthpacks"] = 0;
}

function relic_healthpacks_killfunc(sweapon, player, victim, smeansofdeath, shitloc, time) {
  if(!isDefined(level.active_healthpacks)) {
    level.active_healthpacks = [];
  }

  if(level.active_healthpacks.size >= 20) {
    level.active_healthpacks[0].trigger.fx delete();
    level.active_healthpacks[0].trigger delete();
    level.active_healthpacks[0] delete();
    waitframe();
  }

  while(isDefined(victim) && isDefined(victim.a) && istrue(victim doinglongdeath())) {
    wait 0.1;
  }

  pos = getgroundposition(victim.origin, 4, 10);
  trigger = spawn("trigger_radius", pos, 0, 72, 72);
  trigger.fx = spawnfx(level._effect["healthpack_spawn"], pos + (0, 0, 25));
  triggerfx(trigger.fx);
  trigger thread relic_healthpacks_think();
}

function relic_healthpacks_think() {
  self endon("pickedup");
  self endon("death");
  thread relic_healthpacks_wait_for_pickup();
  var_c2ba0cd135bf2843 = gettime() + 20000;

  while(gettime() < var_c2ba0cd135bf2843) {
    wait 0.05;
  }

  playsoundatpos(self.origin, "mp_killconfirm_tags_pickup");
  playFX(level._effect["healthpack_pickup"], self.origin + (0, 0, 25));
  self.fx delete();
  self delete();
}

function relic_healthpacks_wait_for_pickup() {
  self endon("death");

  while(true) {
    self waittill("trigger", ent);

    if(!isPlayer(ent) || !ent is_valid_player() || ent.health == ent.maxhealth) {
      continue;
    }

    if(function_f620e996a1d7d81a()) {
      ent notify("healthpack");
      self.fx delete();
      self delete();
      return;
    }

    self notify("pickedup");
    ent playlocalsound("mp_killconfirm_tags_pickup");
    playFX(level._effect["healthpack_pickup"], self.origin);
    curhealth = ent getnormalhealth();

    if(curhealth + int(level.healthpack_health / 100)) {
      ent scripts\cp\damage::set_normalhealth(1);
    } else {
      ent scripts\cp\damage::set_normalhealth(curhealth + int(level.healthpack_health / 100));
    }

    self.fx delete();
    self delete();
    return;
  }
}

function init_relic_bang_and_boom(player) {}

function set_relic_bang_and_boom(player) {
  level.relic_bang_and_boom = 1;
  player.ondroprelics["relic_bang_and_boom"] = 1;
  player.no_enemy_weapon_drops = 1;
}

function unset_relic_bang_and_boom(player) {
  level.relic_bang_and_boom = 0;
  player.ondroprelics["relic_bang_and_boom"] = 0;
  player.no_enemy_weapon_drops = undefined;
}

function relic_bang_and_boom_dropfunc(pos, var_4d8d96d547df2e9f) {
  if(!isDefined(level.active_relic_bang_and_boom)) {
    level.active_relic_bang_and_boom = [];
  }

  if(level.active_relic_bang_and_boom.size >= 20) {
    level.active_relic_bang_and_boom[0].trigger delete();
    level.active_relic_bang_and_boom[0] delete();
    waitframe();
  }

  drop_type = get_type_to_drop(var_4d8d96d547df2e9f);

  if(!isDefined(drop_type)) {
    return;
  }

  trigger = spawn("trigger_radius", pos, 0, 72, 72);

  if(drop_type == "ammo") {
    trigger.drop_type = "ammo";
  } else {
    trigger.drop_type = "grenade";
  }

  playsoundatpos(pos, "mp_killconfirm_tags_drop");
  trigger thread relic_bang_and_boom_think();
}

function get_type_to_drop(var_4d8d96d547df2e9f) {
  damage_type = undefined;

  switch (var_4d8d96d547df2e9f.smeansofdeath) {
    case #"hash_571e46e17a3cf2e3":
    case #"hash_5f1054c48d66fd1c":
    case #"hash_966768b3f0c94767":
      damage_type = "grenade";
      break;
    case #"hash_3c20f39c73a1422b":
    case #"hash_66cb246f3e55fbe2":
    case #"hash_a86d8c43482948a4":
    case #"hash_a911a1880d996edb":
    case #"hash_b1078ff213fddba6":
    case #"hash_c22b13f81bed11f0":
    case #"hash_d8646db4e6ee3658":
      damage_type = "ammo";
      break;
  }

  return damage_type;
}

function relic_bang_and_boom_think() {
  self endon("pickedup");
  self endon("death");
  thread relic_bang_and_boom_wait_for_pickup();
  var_c2ba0cd135bf2843 = gettime() + 20000;

  while(gettime() < var_c2ba0cd135bf2843) {
    wait 0.05;
  }

  deleteheadicon(self.headicon);
  self delete();
}

function relic_bang_and_boom_wait_for_pickup() {
  self endon("death");
  self.headicon = createheadiconatorigin(self.origin + (0, 0, 14));

  if(self.drop_type == "ammo") {
    setheadiconimage(self.headicon, "hud_icon_ammo");
  } else {
    setheadiconimage(self.headicon, "hud_icon_equipment_frag");
  }

  setheadiconmaxdistance(self.headicon, 29000);
  setheadiconnaturaldistance(self.headicon, 10);
  setheadiconzoffset(self.headicon, 10);

  while(true) {
    self waittill("trigger", ent);

    if(!isPlayer(ent) || !ent is_valid_player()) {
      continue;
    }

    success = 0;

    if(self.drop_type == "ammo") {
      ent playlocalsound("weap_ammo_pickup");
      success = ent scripts\cp\agent_damage::give_ammo_to_stock();
    } else {
      ent playlocalsound("weap_ammo_pickup");

      if(ent should_give_grenades()) {
        success = 1;
        ent thread scripts\cp\cp_grenade_crate::healthbox_onusedeployable();
      }
    }

    if(success) {
      self notify("pickedup");
      playFX(level._effect["dogtag_pickup"], self.origin);
      deleteheadicon(self.headicon);
      self delete();
      return;
    }
  }
}

function should_give_grenades() {
  grenade_full = 1;
  projectile_full = 1;
  primary_weapons = self getweaponslistprimaries();

  foreach(weapon in primary_weapons) {
    if(weapontype(weapon) == "projectile") {
      if(weapon.basename == "iw8_la_mike32_mp") {
        if(self.gl_proj_override == "thermite") {
          continue;
        }
      }

      if(!scripts\cp\cp_grenade_crate::max_projectile_check(weapon)) {
        projectile_full = 0;
      }
    }

    if(weapon.inventorytype == "altmode" && isDefined(weapon.underbarrel) && weapon.underbarrel == "ubshtgn") {
      if(!scripts\cp\cp_grenade_crate::max_projectile_check(weapon)) {
        projectile_full = 0;
      }
    }
  }

  foreach(pwr_struct in self.powers) {
    if(pwr_struct.charges < pwr_struct.maxcharges) {
      grenade_full = 0;
    }
  }

  if(!grenade_full || !projectile_full) {
    return true;
  }

  return false;
}

function init_relic_noluck(player) {}

function set_relic_noluck(player) {
  player.no_enemy_weapon_drops = 1;
}

function unset_relic_noluck(player) {
  player.no_enemy_weapon_drops = undefined;
}

function init_relic_laststand(player) {}

function set_relic_laststand(player) {
  if(!array_contains(level.modifyplayerdamage_relics, &relic_laststand_modifyplayerdamage)) {
    level.modifyplayerdamage_relics = array_add(level.modifyplayerdamage_relics, &relic_laststand_modifyplayerdamage);
  }
}

function unset_relic_laststand(player) {
  level.modifyplayerdamage_relics = array_remove(level.modifyplayerdamage_relics, &relic_laststand_modifyplayerdamage);
}

function relic_laststand_modifyplayerdamage(victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc) {
  damage_multiplier = 1;

  if(isDefined(eattacker) && isPlayer(eattacker)) {
    foreach(player in level.players) {
      if(isDefined(player) && scripts\cp\laststand::player_in_laststand(player)) {
        damage_multiplier++;
      }
    }
  }

  final_damage = int(idamage * damage_multiplier);

  if(damage_multiplier > 1 && isDefined(victim) && !isPlayer(victim) && victim.health <= final_damage) {
    print3d(victim getEye() + (0, 0, 6), "<dev string:x17a>" + damage_multiplier, (1, 0, 0), 1, 0.5, 20, 1);
  }

  return final_damage;
}

function init_relic_doomslayer(player) {}

function set_relic_doomslayer(player) {
  player.ondamagerelics["relic_doomslayer"] = 1;
  player.no_enemy_weapon_drops = 1;
}

function unset_relic_doomslayer(player) {
  player.ondamagerelics["relic_doomslayer"] = 0;
  player.no_enemy_weapon_drops = 0;
}

function ondamagerelicdoomslayer(player, weapon, victim, meansofdeath, shitloc, time) {
  level endon("game_ended");
  player endon("disconnect");

  if(!isDefined(player) || !isalive(player)) {
    return;
  }

  if(isDefined(meansofdeath) && (meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_EXECUTION")) {
    player.no_enemy_weapon_drops = 0;
    return;
  }

  player.no_enemy_weapon_drops = 1;
}

function init_relic_rocket_kill_ammo(player) {}

function set_relic_rocket_kill_ammo(player) {
  player.onkillrelics["relic_rocket_kill_ammo"] = 1;
}

function unset_relic_rocket_kill_ammo(player) {
  player.onkillrelics["relic_rocket_kill_ammo"] = 0;
  player setclientomnvar("ui_cp_relic_ammo_reward", 0);
}

function handlerocketkillsgiverockets(weapon, player, victim, meansofdeath, shitloc, time) {
  level endon("game_ended");
  player endon("disconnect");

  if(!isDefined(player) || !isalive(player)) {
    return;
  }

  if(!isDefined(weapon) || weapontype(weapon) != "projectile" || !player hasweapon(weapon)) {
    return;
  }

  cur_count = player getammocount(weapon);
  max_clip = weaponclipsize(weapon);
  player setweaponammoclip(weapon, max_clip);
  player setweaponammostock(weapon, cur_count - max_clip + 1);
  player scripts\cp\cp_relics::relic_bullet_reward_hud_display(max_clip);
}

function init_relic_headbullets(player) {}

function set_relic_headbullets(player) {
  player.onkillrelics["relic_headbullets"] = 1;
}

function unset_relic_headbullets(player) {
  player.onkillrelics["relic_headbullets"] = 0;
  player setclientomnvar("ui_cp_relic_ammo_reward", 0);
}

function handleheadshotkillrewardbullets(weapon, player, victim, meansofdeath, shitloc, time) {
  level endon("game_ended");
  player endon("disconnect");

  if(!isDefined(player) || !isalive(player)) {
    return;
  }

  if(!isheadshot(weapon, shitloc, meansofdeath, player)) {
    return;
  }

  if(!isDefined(weapon) || weapontype(weapon) != "bullet" || !player hasweapon(weapon)) {
    return;
  }

  while(player isreloading()) {
    wait 0.05;
  }

  max_clip = weaponclipsize(weapon);
  ammo_award = int(max_clip * 0.25);
  ammo_award = int(clamp(ammo_award, 1, 10));
  player thread relic_award_bullets(weapon, ammo_award);
}

function function_43474778d36c627b() {
  level endon("game_ended");
  scripts\cp\cp_relics::function_c861c37e30cde168(&function_dd919137e61b4dc9);
  scripts\cp\loadout::function_e2d370937c694c58("iw9_dm_xmike2010_mp", ["silencer", "laser"], "iw9_pi_decho_mp", ["silencer", "laserpstl_ads01"]);
  level scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(&function_a18d22b26d61ca19);
  wait 0.05;
  level.var_49cb48689488ef07 = level.var_5966c39cb60075f1;
  level.var_5966c39cb60075f1 = &function_a430c30ecadedcfe;
  wait 0.05;
  function_c0d2c91f2688ece4(0, 1);
  level.var_317452953c148027 = undefined;
  level.var_ad799295a6692b29 = 1;
  level.oitc = 1;
}

function function_dd919137e61b4dc9(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  if(is_relic_active("relic_oneInTheChamber") && isPlayer(eattacker)) {
    isjuggernaut = isDefined(self.unittype) && self.unittype == "juggernaut";
    eattacker scripts\cp_mp\damagefeedback::hudicontype("br_ammo");
    eattacker playsoundtoplayer("scavenger_pack_pickup", eattacker);

    if(getdvarint(@ "hash_2c3cc4b994e1477c", 1)) {
      if(self isinexecutionvictim()) {
        eattacker.var_fe05a02fc63eca30 += 2;
      } else if(isheadshot(objweapon, shitloc, smeansofdeath, eattacker)) {
        eattacker.var_fe05a02fc63eca30++;
      }
    }

    modifier = 1;

    if(isjuggernaut) {
      modifier = getdvarint(@ "hash_d1d9818a5d516c6", level.players.size + 1);
    }

    if(getdvarint(@ "hash_c0834db3c7f1de7f", 1)) {
      if(isjuggernaut) {
        self.armorhealth -= int(self.maxarmorhealth / modifier);
        self.helmethealth -= int(self.var_cfc69e5588a5bed6 / modifier);
      } else {
        self.armorhealth = 0;
        self.helmethealth = undefined;
      }
    }

    return int(self.maxhealth / modifier);
  }

  return idamage;
}

function function_78e009b52b565ff5(player) {
  player thread function_145297f3e93394e();
  player disable_backpack_inventory(1);
  player.var_fe05a02fc63eca30 = 1;
}

function function_a430c30ecadedcfe() {
  self endon("disconnect");
  waitframe();
  self.perk_data["weapons_have_full_ammo"] = undefined;
  scripts\cp\pickups::br_ammo_player_clear();
  weapons = self.primaryweapons;

  for(i = 0; i < weapons.size; i++) {
    self setweaponammoclip(weapons[i], 1);
    weaponammotype = scripts\cp\pickups::br_ammo_type_for_weapon(weapons[i]);
    scripts\cp\pickups::br_ammo_give_type(self, weaponammotype, 0, 0, 1);
  }

  if(isDefined(level.var_49cb48689488ef07)) {
    self[[level.var_49cb48689488ef07]]();
  }
}

function function_78d22d7754b8a60d(player) {
  player.onkillrelics["relic_oneInTheChamber"] = 1;
}

function function_a18d22b26d61ca19() {
  val::set("OITC", "weapon_switch_clip", 0);
  self unsetperk("specialty_pistoldraw", 1);
}

function function_1bd55bd951802eda(player) {
  player.onkillrelics["relic_oneInTheChamber"] = 0;
  player disable_backpack_inventory(0);
  player val::set("OITC", "weapon_switch_clip", 1);
  player setperk("specialty_pistoldraw", 1);
  player notify("unset_one_in_the_chamber");

  if(isDefined(level.var_49cb48689488ef07)) {
    level.var_5966c39cb60075f1 = level.var_49cb48689488ef07;
    level.var_49cb48689488ef07 = undefined;
  }

  scripts\cp\cp_relics::function_6c47231521c88e7a(&function_dd919137e61b4dc9);
}

function function_145297f3e93394e() {
  self endon("unset_one_in_the_chamber");
  self endon("disconnect");

  while(true) {
    self waittill("weapon_taken", var_5e7231028b58c498);
    self setweaponammoclip(var_5e7231028b58c498, 1);
    weaponammotype = scripts\cp\pickups::br_ammo_type_for_weapon(var_5e7231028b58c498);
    scripts\cp\pickups::br_ammo_give_type(self, weaponammotype, 0, 0, 1);
  }
}

function function_3a051d1fd67ae155(sweapon, player, victim, smeansofdeath, shitloc, time) {
  weapon = player.currentprimaryweapon;

  if(smeansofdeath == "MOD_EXECUTION") {
    if(!scripts\cp\weapon::isdroppableweapon(weapon)) {
      weapon = player.lastdroppableweaponobj;
    }
  }

  clip = player getweaponammoclip(weapon);
  player setweaponammoclip(weapon, clip + player.var_fe05a02fc63eca30);
  player scripts\cp\cp_relics::relic_bullet_reward_hud_display(player.var_fe05a02fc63eca30);
  player.var_fe05a02fc63eca30 = 1;
}

function function_c72ff7743ec64985(player, weapon, victim) {
  test = 1;
}

function init_relic_punchbullets(player) {}

function set_relic_punchbullets(player) {
  player.onkillrelics["relic_punchbullets"] = 1;
  player thread relic_punchbullets_track_previous_bullet_weapon();
}

function unset_relic_punchbullets(player) {
  player.onkillrelics["relic_punchbullets"] = 0;
  player setclientomnvar("ui_cp_relic_ammo_reward", 0);
  player notify("relic_punchbullets_ender");
  player.previous_bullet_weapon = undefined;
}

function relic_punchbullets_fire_fists() {
  flag_wait("player_spawned_with_loadout");
  wait 1;
  self takeallweapons();
  self giveweapon("iw9_me_fists_mp");
  self switchtoweapon("iw9_me_fists_mp");
  self disableweaponpickup();
  wait 1;
  self setscriptablepartstate("equipMtovFXWorld", "neutral", 0);
  self setscriptablepartstate("equipMtovFXView", "active", 0);
  self setscriptablepartstate("burning", "active");
  wait 0.5;
  self setscriptablepartstate("equipMtovFXWorld", "active", 0);
}

function relic_punchbullets_track_previous_bullet_weapon() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("relic_punchbullets_ender");

  while(true) {
    weapon = self getcurrentweapon();

    if(isDefined(weapon) && weapontype(weapon) == "bullet") {
      self.previous_bullet_weapon = weapon;
    } else if(isDefined(self.previous_bullet_weapon) && !self hasweapon(self.previous_bullet_weapon)) {
      self.previous_bullet_weapon = undefined;
    }

    self waittill("weapon_change");
  }
}

function handlemeleekillrewardbullets(weapon, player, victim, meansofdeath, shitloc, time) {
  level endon("game_ended");
  player endon("death_or_disconnect");

  if(!isDefined(player) || !isalive(player)) {
    return;
  }

  if(!isDefined(meansofdeath) || meansofdeath != "MOD_MELEE" && meansofdeath != "MOD_EXECUTION") {
    return;
  }

  if(meansofdeath == "MOD_EXECUTION" && isDefined(player.previous_bullet_weapon)) {
    weapon = player.previous_bullet_weapon;
  }

  if(!isDefined(weapon) || weapontype(weapon) != "bullet" || !player hasweapon(weapon)) {
    return;
  }

  while(player isreloading()) {
    wait 0.05;
  }

  max_clip = weaponclipsize(weapon);
  ammo_award = int(max_clip * 0.25);
  ammo_award = int(clamp(ammo_award, 1, 10));
  player thread relic_award_bullets(weapon, ammo_award);
}

function relic_award_bullets(weapon, ammo_award, var_356362f791136ab4) {
  level endon("game_ended");
  self endon("disconnect");
  player = self;
  wait 0.75;

  if(!isDefined(weapon) || weapontype(weapon) != "bullet" || !player hasweapon(weapon)) {
    return;
  }

  if(!isDefined(var_356362f791136ab4)) {
    var_356362f791136ab4 = 1;
  }

  clip_only = is_relic_active("relic_oneclip");
  max_ammo = weaponclipsize(weapon);
  has_ammo = player getweaponammoclip(weapon);

  if(!istrue(clip_only)) {
    max_ammo += weaponmaxammo(weapon);
    has_ammo += player getweaponammostock(weapon);
  }

  ammo_award = int(min(max_ammo - has_ammo, ammo_award));

  if(ammo_award == 0) {
    return;
  }

  var_471d039e2f07d3d8 = player getcurrentweapon() == weapon || player isinexecutionattack();

  if(var_471d039e2f07d3d8) {
    player thread relic_bullet_reward_hud_display(ammo_award);
  }

  if(var_471d039e2f07d3d8 && var_356362f791136ab4) {
    while(ammo_award > 0) {
      result = player thread relic_award_one_bullet(weapon, clip_only);

      if(istrue(result)) {
        player notify("ammo_awarded");
      } else {
        break;
      }

      wait 0.2;
      ammo_award--;
    }

    return;
  }

  max_clip = weaponclipsize(weapon);
  cur_clip = player getweaponammoclip(weapon);
  delta_clip = max_clip - cur_clip;

  if(delta_clip >= ammo_award) {
    player setweaponammoclip(weapon, cur_clip + ammo_award);
  } else {
    player setweaponammoclip(weapon, max_clip);

    if(!istrue(clip_only)) {
      max_stock = weaponmaxammo(weapon);
      cur_stock = player getweaponammostock(weapon);
      ammo_award -= delta_clip;
      new_stock = int(min(max_stock, cur_stock + ammo_award));
      player setweaponammostock(weapon, new_stock);
    }
  }

  player notify("ammo_awarded");
}

function relic_award_one_bullet(weapon, clip_only) {
  player = self;

  if(!isDefined(weapon) || weapontype(weapon) != "bullet" || !player hasweapon(weapon)) {
    return;
  }

  cur_clip = player getweaponammoclip(weapon);

  if(istrue(clip_only) || cur_clip < weaponclipsize(weapon)) {
    player setweaponammoclip(weapon, cur_clip + 1);
    player playlocalsound("weap_ammo_pickup");
    return 1;
  } else {
    cur_stock = player getweaponammostock(weapon);

    if(cur_stock < weaponmaxammo(weapon)) {
      player setweaponammostock(weapon, cur_stock + 1);
      player playlocalsound("weap_ammo_pickup");
      return 1;
    }
  }

  return 0;
}

function relic_bullet_reward_hud_display(ammo_award) {
  self notify("relic_punchbullets_reward_hud_display");
  self endon("relic_punchbullets_reward_hud_display");
  self endon("disconnect");
  level endon("game_ended");
  self setclientomnvar("ui_cp_relic_ammo_reward", 0);
  wait 0.25;
  self setclientomnvar("ui_cp_relic_ammo_reward", ammo_award);
  wait 1.75;
  self setclientomnvar("ui_cp_relic_ammo_reward", 0);
}

function init_relic_steelballs(player) {}

function set_relic_steelballs(player) {
  player.onkillrelics["relic_steelballs"] = 1;
  player.ondamagerelics["relic_steelballs"] = 1;
  player thread relic_steelballs_dash();
  player thread relic_steelballs_slide();
  player thread relic_steelballs_stump();
  player thread set_relic_steelballs_perks(player);
}

function set_relic_steelballs_perks(player) {
  flag_wait("player_spawned_with_loadout");
  spawned_origin = player.origin;

  while(player.origin == spawned_origin) {
    wait 0.25;
  }

  player scripts\cp\utility::giveperk("specialty_extendedMelee");
  player scripts\cp\utility::giveperk("specialty_hardmelee");
  wait 0.05;
  player.perk_data["melee_scalar"] = 3;
}

function unset_relic_steelballs(player) {
  player scripts\cp\perks\cp_perks::removeperk("specialty_extendedMelee");
  player scripts\cp\perks\cp_perks::removeperk("specialty_hardmelee");
  player.onkillrelics["relic_steelballs"] = 0;
  player.ondamagerelics["relic_steelballs"] = 0;

  if(isDefined(player.slide_trig)) {
    player.slide_trig delete();
  }

  player notify("relic_steelballs_ender");
}

function handlemeleekillsteelballs(weapon, player, victim, meansofdeath, shitloc, time) {
  if(!isDefined(player) || !isalive(player)) {
    return;
  }

  if(!isDefined(meansofdeath) || meansofdeath != "MOD_MELEE") {
    return;
  }

  player thread relic_steelballs_health_boost();
  player playSound("gib_fullbody");
}

function ondamagerelicsteelballs(player, weapon, victim, meansofdeath, shitloc, time) {
  if(!isDefined(victim)) {
    return;
  }

  victim.forceexplosivedeath = undefined;
  victim.shouldhelmetpop = undefined;

  if(isDefined(victim.original_disablelongdeath)) {
    victim.var_98add129a7ecb962 = victim.var_56ada34122c13f70;
  }

  if(!isDefined(player) || !isalive(player)) {
    return;
  }

  if(!isDefined(meansofdeath) || meansofdeath != "MOD_MELEE") {
    return;
  }

  victim.forceexplosivedeath = 1;
  victim.shouldhelmetpop = 1;
  victim.var_56ada34122c13f70 = victim.var_98add129a7ecb962;
  victim.var_98add129a7ecb962 = 0;
}

function relic_steelballs_health_boost() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  player = self;
  new_health = clamp(self.health + 90, 0, self.maxhealth);
  scripts\cp\damage::set_normalhealth(new_health / self.maxhealth);
}

function relic_steelballs_slide() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("relic_steelballs_ender");

  while(!isDefined(self.model) || self.model == "") {
    wait 0.05;
  }

  wait 1;
  pos = self gettagorigin("j_ball_le");
  slide_trig = spawn("trigger_radius", pos, 0, 32, 48);
  slide_trig enablelinkTo();
  slide_trig linkTo(self, "j_ball_le", (0, 0, 0), (0, 0, 0));
  self.slide_trig = slide_trig;
  slide_trig endon("death");

  while(true) {
    self waittill("sprint_slide_begin");
    wait 0.3;

    while(self issprintsliding()) {
      self.slide_trig waittill("trigger", ent);
      earthquake(0.2, 0.25, self.origin, 100);
      self playRumbleOnEntity("slide_loop");

      if(isDefined(ent) && !isPlayer(ent) && (isai(ent) || isagent(ent)) && self issprintsliding()) {
        relic_steelballs_dodamage(ent, self, 32, 285);
        physicsexplosionsphere(self.origin, 68, 48, 2.5);
        self playRumbleOnEntity("artillery_rumble");
        playrumbleonposition("slide_collision", self.origin);
        earthquake(0.5, 0.5, self.origin, 100);

        while(self issprintsliding()) {
          earthquake(0.2, 0.25, self.origin, 100);
          self playRumbleOnEntity("slide_loop");
          wait 0.05;
        }
      }
    }
  }
}

function relic_steelballs_dodamage(victim, player, dmg_radius, dmg_amount) {
  victim.explosivemodoverride = 1;
  victim.shouldhelmetpop = 1;
  original_health = victim.health;
  radiusdamage(victim.origin + (0, 0, 8), dmg_radius, dmg_amount, dmg_amount - 1, player, "MOD_MELEE");
  player.lasthitmarkertime = undefined;
  player scripts\cp\damagefeedback::updatedamagefeedback("hitcritical");
}

function relic_steelballs_dash() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("relic_steelballs_ender");

  while(true) {
    self waittill("melee_swipe_start");
    dash_force = 250;
    player_vec = anglesToForward(self getplayerangles(1));
    enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    closestenemies = get_array_of_closest(self.origin, enemies, undefined, undefined, 128);

    if(isDefined(closestenemies) && closestenemies.size > 0) {
      victim = closestenemies[0];
      look_at_point = victim getEye() - (0, 0, 12);
      is_looking_at = self worldpointinreticle_circle(look_at_point, 70, 300);
      var_a49fe39fe684c761 = sighttracepassed(victim getEye(), self getEye(), 0, victim);

      if(is_looking_at && var_a49fe39fe684c761) {
        player_vec = flatten_vector(victim.origin - self.origin);
        dash_force = 350;
      }
    }

    self knockback(player_vec, dash_force);
    wait 0.5;
  }
}

function relic_steelballs_stump() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("relic_steelballs_ender");
  childthread relic_steelballs_stump_monitor();

  while(true) {
    self waittill("stump_damage", air_time, max_height, drop_dist);
    radiusdamage(self.origin, 64, 150, 149, self, "MOD_MELEE");
    playFX(level._effect["stump_landing"], self.origin);
    self playRumbleOnEntity("artillery_rumble");
    playrumbleonposition("slide_collision", self.origin);
    earthquake(0.5, 1.5, self.origin, 100);
  }
}

function relic_steelballs_stump_monitor() {
  while(true) {
    while(self isonground()) {
      wait 0.05;
    }

    t_mark = gettime();
    max_height = self.origin[2];

    while(!self isonground()) {
      if(self.origin[2] > max_height) {
        max_height = self.origin[2];
      }

      wait 0.05;
    }

    drop_dist = max(0, max_height - self.origin[2]);

    if(drop_dist < 128) {
      continue;
    }

    air_time = (gettime() - t_mark) / 1000;
    self notify("stump_damage", air_time, max_height, drop_dist);
  }
}

function init_relic_oneclip(player) {}

function set_relic_oneclip(player) {
  player thread relic_oneclip_monitor();
}

function unset_relic_oneclip(player) {
  player notify("set_relic_oneclip_ender");
  player setclientomnvar("ui_cp_relic_ammo_reward", 0);
}

function relic_oneclip_monitor() {
  self endon("death_or_disconnect");
  self endon("set_relic_oneclip_ender");
  flag_wait("player_spawned_with_loadout");
  wait 0.5;
  thread relic_oneclip_stock_adjustment_monitor();

  while(true) {
    all_weapons = self getweaponslistprimaries();

    foreach(weapon in all_weapons) {
      if(!isDefined(weapon) || weapontype(weapon) != "bullet") {
        continue;
      }

      stock_ammo = self getweaponammostock(weapon);

      if(stock_ammo > 0) {
        max_clip = weaponclipsize(weapon);
        clip_ammo = self getweaponammoclip(weapon);

        if(clip_ammo < max_clip) {
          new_clip = int(min(max_clip, clip_ammo + stock_ammo));
          thread relic_award_bullets(weapon, new_clip - clip_ammo);
        }

        self setweaponammostock(weapon, 0);
      }
    }

    waittill_any_5("ammo_pickup", "weapon_change", "weapon_swap", "ammo_awarded", "ammo_stock_not_empty");
  }
}

function relic_oneclip_stock_adjustment_monitor() {
  self endon("death_or_disconnect");
  self endon("set_relic_oneclip_ender");

  while(true) {
    wait 0.05;
    weapon = self getcurrentweapon();

    if(!isDefined(weapon) || weapontype(weapon) != "bullet") {
      continue;
    }

    if(self getweaponammostock(weapon) > 0) {
      self notify("ammo_stock_not_empty");
    }
  }
}

function init_relic_grounded(player) {}

function set_relic_grounded(player) {
  player thread relic_grounded_reload_monitor();
}

function relic_grounded_reload_monitor() {
  self endon("death_or_disconnect");
  self endon("set_relic_grounded_ender");

  while(true) {
    self waittill("reload_start");
    weapon = self getcurrentweapon();

    if(!isDefined(weapon) || weapontype(weapon) != "bullet") {
      continue;
    }

    cur_clip = self getweaponammoclip(weapon);
    self setweaponammoclip(weapon, 0);
    cur_stock = self getweaponammostock(weapon);

    while(cur_stock == self getweaponammostock(weapon)) {
      if(!self hasweapon(weapon)) {
        break;
      }

      if(!self isreloading() || self getcurrentweapon() != weapon) {
        self setweaponammoclip(weapon, cur_clip);
        break;
      }

      wait 0.05;
    }
  }
}

function unset_relic_grounded(player) {
  player notify("set_relic_grounded_ender");
}

function init_relic_nobulletdamage(player) {
  scripts\cp\cp_relics::function_c861c37e30cde168(&relic_nobulletdamage_modifyplayerdamage);
}

function set_relic_nobulletdamage(player) {
  player.ondamagerelics["relic_nobulletdamage"] = 1;
}

function unset_relic_nobulletdamage(player) {
  player.ondamagerelics["relic_nobulletdamage"] = 0;
}

function relic_nobulletdamage_modifyplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  victim = self;

  if(!isDefined(eattacker)) {
    return idamage;
  }

  if(!isent(eattacker)) {
    return idamage;
  }

  if(isDefined(eattacker.owner)) {
    if(!isPlayer(eattacker.owner)) {
      return idamage;
    }
  }

  if(!isPlayer(eattacker)) {
    return idamage;
  }

  bulletdamage = isbulletdamage(smeansofdeath) || smeansofdeath == "MOD_EXPLOSIVE_BULLET" && shitloc != "none";

  if(bulletdamage) {
    if(istrue(objweapon.isdragonsbreath)) {
      bulletdamage = 0;
    }
  }

  if(isPlayer(eattacker) && isai(victim)) {
    if(!bulletdamage) {
      return idamage;
    } else {
      return 0;
    }

    return;
  }

  return idamage;
}

function init_relic_trex(player) {
  level.persistentrelics["relic_trex"] = &handletrex;
}

function set_relic_trex(player) {
  player.persistentrelics["relic_trex"] = 1;
}

function unset_relic_trex(player) {
  player.persistentrelics["relic_trex"] = 0;
}

function handletrex(player) {
  self notify("handleTRex");
  self endon("handleTRex");
  self endon("stop_trex");
  level endon("game_ended");

  while(true) {
    wait 0.05;

    if(!can_trex_apply_to_player(player)) {
      continue;
    }

    player_velocity = player getvelocity();
    speed = length(player_velocity);

    if(speed < 5) {
      player scripts\cp\utility::allow_player_ignore_me(1);
      player.bistrexactive = 1;
      player thread check_for_trexremoval(player);
    }
  }
}

function check_for_trexremoval(player) {
  self notify("check_for_TrexRemoval");
  self endon("check_for_TrexRemoval");

  while(true) {
    waitframe();
    player_velocity = player getvelocity();
    speed = length(player_velocity);

    if(speed >= 5) {
      player scripts\cp\utility::allow_player_ignore_me(0);
      player.bistrexactive = undefined;
      break;
    }
  }
}

function can_trex_apply_to_player(player) {
  if(istrue(player.inlaststand)) {
    return false;
  }

  if(istrue(player.bistrexactive)) {
    return false;
  }

  return true;
}

function init_relic_ammo_drain(player) {
  player.has_ammo_drain_passive = 0;
}

function set_relic_ammo_drain(player) {
  player.has_ammo_drain_passive = 1;
  player thread relic_ammo_drain_take_ammo();
}

function unset_relic_ammo_drain(player) {
  player.has_ammo_drain_passive = 0;
  player notify("stop_ammo_drain");
}

function relic_ammo_drain_take_ammo() {
  level endon("game_ended");
  self endon("stop_ammo_drain");

  while(true) {
    if(!is_valid_player()) {
      wait 1;
      continue;
    }

    weapon = self getcurrentprimaryweapon();

    if(!isDefined(weapon)) {
      wait 1;
      continue;
    }

    fail = 0;
    clip_size = weaponclipsize(weapon);

    if(!isDefined(clip_size)) {
      clip_size = 22.5;
    }

    if(clip_size < 1) {
      clip_size = 22.5;
    }

    if(weapontype(weapon) == "riotshield") {
      fail = 1;
    }

    if(istrue(weapon.ismelee)) {
      fail = 1;
    }

    if(isDefined(weapon.classname)) {
      if(weapon.classname == "none") {
        fail = 1;
      }

      if(weapon.classname == "grenade") {
        fail = 1;
      }

      if(weapon.classname == "rocketlauncher") {
        fail = 1;
      }
    }

    if(self isreloading()) {
      fail = 1;
    }

    if(scripts\cp\weapon::is_incompatible_weapon(weapon)) {
      fail = 1;
    }

    if(!fail) {
      if(isDefined(self.last_weapon) && self.last_weapon == weapon) {
        if(weapon.inventorytype == "altmode") {
          if(isDefined(weapon.underbarrel) && weapon.underbarrel == "ubshtgn") {
            cur_ammo = self getweaponammoclip(weapon);
            new_ammo = int(max(0, cur_ammo - 1));
            self setweaponammoclip(weapon, new_ammo);
            self setweaponammostock(weapon, 0);
            self notify("ammo_drained");
            thread relic_bullet_reward_hud_display(-1);
            break;
          }
        } else {
          if(weapon.isdualwield) {
            leftclip = self getweaponammoclip(weapon, "left");
            rightclip = self getweaponammoclip(weapon, "right");

            if(!isDefined(self.last_akimbo_ammo_taken)) {
              self.last_akimbo_ammo_taken = "left";
            }

            if(self.last_akimbo_ammo_taken == "left") {
              new_ammo = int(max(0, leftclip - 1));
              self setweaponammoclip(weapon, new_ammo, "left");
              self.last_akimbo_ammo_taken = "right";
            } else {
              new_ammo = int(max(0, rightclip - 1));
              self setweaponammoclip(weapon, new_ammo, "right");
              self.last_akimbo_ammo_taken = "left";
            }
          } else {
            cur_ammo = self getweaponammoclip(weapon);
            new_ammo = int(max(0, cur_ammo - 1));
            self setweaponammoclip(weapon, new_ammo);
          }

          self notify("ammo_drained");
          thread relic_bullet_reward_hud_display(-1);
        }
      }

      wait_time = max(45 / clip_size, 0.4);
      self.last_weapon = weapon;
      waittill_any_timeout_1(wait_time, "weapon_change");
      continue;
    }

    wait 1;
  }
}

function init_relic_dogtags(player) {}

function set_relic_dogtags(player) {
  level.relic_dogtags = 1;
  level.disable_hotjoin_via_ac130 = 1;
  level.dogtag_revive = 1;
}

function unset_relic_dogtags(player) {
  level.relic_dogtags = 0;
  level.disable_hotjoin_via_ac130 = 0;
  level.dogtag_revive = 0;
}

function init_relic_laststandmelee(player) {}

function set_relic_laststandmelee(player) {
  fistsweapon = scripts\cp_mp\weapon::buildweapon("iw9_me_fists_mp", [], "none", "none", -1);
  player.forced_laststand_weapon = fistsweapon;
}

function unset_relic_laststandmelee(player) {
  player.forced_laststand_weapon = undefined;
}

function init_relic_fastbleedout(player) {}

function set_relic_fastbleedout(player) {
  level.get_bleed_out_time = &relic_fastbleedout_returnfunc;
}

function relic_fastbleedout_returnfunc() {
  return 7;
}

function unset_relic_fastbleedout(player) {
  level.get_bleed_out_time = undefined;
}

function init_relic_nuketimer(player) {}

function set_relic_nuketimer(player) {
  level thread relic_nuketimer_globalthread();
}

function unset_relic_nuketimer(player) {
  level notify("relic_nuketimer_end");
}

function relic_nuketimer_globalthread() {
  level endon("game_ended");
  level endon("relic_nuketimer_end");

  if(isDefined(level.relic_nuketimer)) {
    return;
  }

  level.relic_nuketimer = spawnStruct();
  level.relic_nuketimer.point_of_no_return = 16;
  level.relic_nuketimer.nuke_clockobject = spawn("script_origin", (0, 0, 100));
  level.relic_nuketimer.nuke_clockobject dontinterpolate();
  level.relic_nuketimer.nuke_clockobject hide();
  level.relic_nuketimer.nuke_explposstruct = spawnStruct();
  level.relic_nuketimer.nuke_explposstruct.targetname = "nuke_expl_pos";
  level.relic_nuketimer.nuke_explposstruct.origin = level.relic_nuketimer.nuke_clockobject.origin;
  level.nuke_expl_struct = level.relic_nuketimer.nuke_explposstruct;
  flag_wait("player_spawned_with_loadout");
  wait 0.5;
  var_6c0983906bc06eaa = "safehouse_door_opened";
  var_90ed145efa706edd = "obj_extract_informant_started";
  var_2f04724afc0dbc44 = "players_go_to_safehouse";
  var_d9d3000b553fa249 = 60;
  var_160f83e240eb105f = "player_entered_safehouse_vol";
  mapname = tolower(getDvar(@ "mapname"));

  switch (mapname) {
    case #"hash_d9c138fad5b09bff":
      var_6c0983906bc06eaa = "hydro_fire_early";
      level thread notify_delay(var_6c0983906bc06eaa, 10);
      break;
    case #"hash_354398f7f22b30a7":
      var_6c0983906bc06eaa = "scaletest_fire_early";
      level thread notify_delay(var_6c0983906bc06eaa, 10);
      break;
    case #"hash_7344128ff773082f":
      level.relic_nuketimer.failstringsetup = 1;
      var_6c0983906bc06eaa = "safehouse_door_opened";
      var_90ed145efa706edd = "obj_extract_informant_started";
      var_2f04724afc0dbc44 = "players_go_to_safehouse";
      var_d9d3000b553fa249 = 60;
      var_160f83e240eb105f = "player_entered_safehouse_vol";
      checkpoint = scripts\cp\cp_checkpoint::checkpoint_get();

      if(isDefined(checkpoint) && checkpoint == "tow_p1") {
        var_6c0983906bc06eaa = "smuggler_fire_early";
        level thread notify_delay(var_6c0983906bc06eaa, 5);
      }

      break;
  }

  level waittill(var_6c0983906bc06eaa);
  level thread relic_nuketimer_timer_init();
  level thread relic_nuketimer_waitforobjectives();
  level thread relic_nuketimer_waitforcompleteobjectives(var_90ed145efa706edd, var_2f04724afc0dbc44, var_160f83e240eb105f, var_d9d3000b553fa249);
  waitframe();
  level waittill("relic_nuke_explode");
  var_8552241a89a7d70a = level.relic_nuketimer.nuke_clockobject.origin;
  nuke_owner = spawn("script_model", var_8552241a89a7d70a);
  nuke_owner setModel("tag_origin");
  nuke_owner.team = "axis";
  nuke_owner.pers = [];
  nuke_owner.pers["team"] = "axis";
  nuke_owner.owner = nuke_owner;
  streakinfo = nuke_owner scripts\cp_mp\utility\killstreak_utility::createstreakinfo("nuke", nuke_owner);
  nuke_owner thread scripts\cp_mp\killstreaks\nuke::nuke_start(streakinfo);
  level waittill("nuke_detonated");
  wait 5;

  if(istrue(level.relic_nuketimer.failstringsetup)) {
    scripts\cp\cp_objectives::prepare_mission_failed_text("obj_nuke_ending");
  }

  enemies = scripts\cp\cp_agent_utils::getactiveenemyagents("allies");

  foreach(guy in enemies) {
    guy suicide();
  }

  foreach(player in level.players) {
    player dodamage(player.health + 1000, player.origin, player);
  }

  wait 4;
  stillalive = 0;

  foreach(player in level.players) {
    if(player scripts\cp_mp\utility\player_utility::_isalive()) {
      stillalive = 1;
    }
  }

  if(stillalive) {
    level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
  }
}

function relic_nuketimer_timer_init() {
  level endon("game_ended");
  level endon("relic_nuketimer_end");
  level.relic_nuketimer.timeramount = 0;
  level.relic_nuketimer.timeramount = relic_nuketimer_gettimeformission();
  override = getDvar(@ "hash_f2f901d5dea53a00", 0);

  if(int(override) > 5) {
    level.relic_nuketimer.timeramount = int(override);
  }

  if(soundexists("iw8_nuke_alarm")) {
    level.relic_nuketimer.nuke_clockobject playSound("iw8_nuke_alarm");
  }

  level thread relic_nuketimer_timerloop();
}

function relic_nuketimer_timerloop() {
  level endon("relic_nuketimer_end");
  setomnvar("ui_nuke_end_milliseconds", gettime() + level.relic_nuketimer.timeramount * 1000);
  setomnvar("ui_nuke_countdown_active", 1);
  setomnvar("ui_nuke_timer_type", 1);

  while(level.relic_nuketimer.timeramount > level.relic_nuketimer.point_of_no_return) {
    if(level.relic_nuketimer.timeramount % 2 == 0 && soundexists("iw8_nuke_countdown")) {
      level.relic_nuketimer.nuke_clockobject playSound("iw8_nuke_countdown");
    }

    vo_ref = getoverlordaliasfortimeleft(level.relic_nuketimer.timeramount - 1, 1);

    if(isDefined(vo_ref)) {
      level thread scripts\cp\vo::try_to_play_vo_on_team(vo_ref, "allies");
    }

    level.relic_nuketimer.timeramount -= 1;
    wait 1;
  }

  level.relic_nuketimer.finale = 1;
  level notify("relic_nuke_explode");
}

function relic_nuketimer_waitforcompleteobjectives(var_90ed145efa706edd, var_2f04724afc0dbc44, var_160f83e240eb105f, var_d9d3000b553fa249) {
  level endon("nuke_detonated");
  level waittill(var_90ed145efa706edd);
  level notify("relic_nuketimer_end");
  scripts\cp_mp\killstreaks\nuke::nuke_cancel();
  setomnvar("ui_nuke_countdown_active", 0);

  if(isDefined(var_2f04724afc0dbc44) && isDefined(var_160f83e240eb105f)) {
    if(!isDefined(var_d9d3000b553fa249)) {
      var_d9d3000b553fa249 = 60;
    }

    level waittill(var_2f04724afc0dbc44);

    if(level.relic_nuketimer.timeramount > var_d9d3000b553fa249) {
      level thread relic_nuketimer_timerloop();
      level thread relic_nuketimer_waitforcompleteobjectives(var_160f83e240eb105f);
    }
  }
}

function relic_nuketimer_waitforobjectives() {
  level endon("game_ended");
  level endon("relic_nuketimer_end");

  while(true) {
    level waittill("give_objective_xp_to_all_players", type);

    if(level.relic_nuketimer.timeramount > level.relic_nuketimer.point_of_no_return + 1) {
      if(type == #"minor_objective") {
        relic_nuketimer_addtotimer(15);
      } else {
        relic_nuketimer_addtotimer(30);
      }

      if(istrue(level.relic_nuketimer.finale)) {
        scripts\cp_mp\killstreaks\nuke::nuke_cancel();
        level.relic_nuketimer.finale = 0;
        waitframe();
        level thread relic_nuketimer_timerloop();
      }
    }
  }
}

function relic_nuketimer_addtotimer(to_add) {
  if(level.gameskill < 3) {
    to_add *= 2;
  }

  level.relic_nuketimer.timeramount += to_add;
  setomnvar("ui_nuke_end_milliseconds", gettime() + level.relic_nuketimer.timeramount * 1000);
}

function relic_nuketimer_gettimeformission() {
  var_ee521ed5ddb09c37 = 900;
  mapname = tolower(getDvar(@ "mapname"));

  switch (mapname) {
    case #"hash_354398f7f22b30a7":
      var_ee521ed5ddb09c37 = 80;
      level delaythread(61, &scripts\cp\cp_objectives::give_objective_xp_to_all_players, #"minor_objective");
      break;
    case #"hash_7344128ff773082f":
      checkpoint = scripts\cp\cp_checkpoint::checkpoint_get();

      if(isDefined(checkpoint) && checkpoint == "tow_p1") {
        if(level.gameskill < 3) {
          var_ee521ed5ddb09c37 = 300;
        } else {
          var_ee521ed5ddb09c37 = 240;
        }
      } else if(level.gameskill < 3) {
        var_ee521ed5ddb09c37 = 960;
      } else {
        var_ee521ed5ddb09c37 = 720;
      }

      break;
  }

  return var_ee521ed5ddb09c37;
}

function init_relic_hideobjicons(player) {}

function set_relic_hideobjicons(player) {
  level endon("game_ended");
  level endon("relic_hideobjicons_ender");

  while(true) {
    level waittill_any_2("worldObjIDPool_requested", "objective_minimapUpdate");

    foreach(entry in level.worldobjidpool.active) {
      objective_state(entry.objid, "active");
    }
  }
}

function unset_relic_hideobjicons(player) {
  level notify("relic_hideobjicons_ender");
}

function init_relic_explodedmg(player) {}

function set_relic_explodedmg(player) {
  level.explosivedamagemod = 7;
}

function unset_relic_explodedmg(player) {
  level.explosivedamagemod = undefined;
}

function are_relics_active() {
  if(getDvar(@ "scr_set_relics", "") != "") {
    return true;
  }

  if(is_wave_gametype() || is_specops_gametype()) {
    return false;
  }

  return false;
}

function init_relic_doubletap(player) {}

function set_relic_doubletap(player) {
  scripts\cp\spawning::add_global_spawn_function("axis", &set_relic_doubletap_params);

  foreach(guy in level.spawned_enemies) {
    guy set_relic_doubletap_params();
  }
}

function unset_relic_doubletap(player) {
  scripts\cp\spawning::remove_global_spawn_function("axis", &set_relic_doubletap_params);

  foreach(guy in level.spawned_enemies) {
    if(isDefined(guy)) {
      guy notify("relic_doubletap_ender");
      guy notify("relic_doubletap_helper_reset");

      if(guy scripts\engine\utility::doinglongdeath()) {
        guy longdeathkillme();
        continue;
      }

      guy.forcelongdeath = 0;
      guy.longdeathnoncombat = 0;
      guy.invulnerable = 0;
      guy.health = guy.maxhealth;
      guy.skipdyingbackcrawl = 0;

      if(isDefined(guy.a)) {
        guy.force_num_crawls = 0;
      }
    }
  }
}

function set_relic_doubletap_params() {
  thread set_relic_doubletap_params_internal();
}

function set_relic_doubletap_params_internal() {
  self endon("death");
  self endon("relic_doubletap_ender");

  if(isjuggernaut()) {
    return;
  }

  if(isDefined(self.unittype) && self.unittype == "suicidebomber") {
    return;
  }

  original_health = self.health;
  wait 0.05;
  original_weapon = self.weapon;

  if(!isDefined(self.weapon) || !isweapon(self.weapon)) {
    weapons_list = self getweaponslistprimaries();

    if(isDefined(weapons_list) && weapons_list.size > 0) {
      original_weapon = weapons_list[0];
    }
  }

  for(counter = 3; counter > 0; counter--) {
    var_e9d23416578c11 = original_health;
    self.health = original_health + var_e9d23416578c11;
    meansofdeath = undefined;

    while(var_e9d23416578c11 > 0) {
      self waittill("damage", amount, attacker, direction_vec, dmgpoint, meansofdeath);

      if(isDefined(attacker) && isPlayer(attacker)) {
        var_e9d23416578c11 -= amount;
      }
    }

    if(scripts\cp\spawning::is_riding_vehicle() || istrue(self.playing_skit) || !self.var_98add129a7ecb962 || istrue(self.attempting_teleport) || istrue(self.bhasriotshieldattached) || isDefined(meansofdeath) && meansofdeath == "MOD_FIRE" || isDefined(self.script) && (self.script == "scripted" || self.script == "<custom>") || istrue(self._blackboard.animscriptedactive)) {
      self.health = 1;
      return;
    }

    self.invulnerable = 1;
    self.health = 1000;

    if(!isDefined(self.asm.longdeathanims)) {
      self.asm.longdeathanims = spawnStruct();
    }

    childthread relic_doubletap_helper();
    wait 0.05;
    self asmsetstate(self.asmname, "choose_long_death");

    print3d(self getEye() + (0, 0, 4), "<dev string:x17d>", (1, 1, 0), 1, 0.25, 40, 1);

    wait 0.8;
    self.invulnerable = 0;
    self.health = original_health;
    wait 3;
    self notify("kill_long_death");
    self notify("dying_crawl_finished");

    print3d(self getEye() + (0, 0, 4), "<dev string:x180>" + 3 - counter + "<dev string:x18c>" + self.health + "<dev string:x192>", (0, 1, 0), 1, 0.25, 60, 1);

    self notify("relic_doubletap_helper_reset");
    self.doinglongdeath = 0;
    scripts\asm\asm::asm_setstate("exposed_prone_to_stand");

    if(!isDefined(original_weapon)) {
      weapons_list = self getweaponslistprimaries();

      if(isDefined(weapons_list) && weapons_list.size > 0) {
        original_weapon = weapons_list[0];
      }
    }

    if(isDefined(original_weapon)) {
      self takeweapon(original_weapon);
      self giveweapon(original_weapon);
      scripts\anim\shared::forceuseweapon(original_weapon, "primary");
    }
  }
}

function relic_doubletap_helper() {
  self endon("death");
  self endon("relic_doubletap_ender");
  self endon("relic_doubletap_helper_reset");
  self.force_num_crawls = 3;
  self.skipdyingbackcrawl = 1;
  self.forcelongdeath = 3;
  self.longdeathnoncombat = 1;

  while(true) {
    self.var_4ad177ab3ddde8fd = undefined;
    self.desiredtimeofdeath = gettime() + 1000;
    self.bulletsinclip = 0;
    wait 0.05;
  }
}

function update_health_on_spawn() {
  self endon("disconnect");

  while(true) {
    self waittill("spawned_player");
    wait 1;
    thread update_health_think();
  }
}

function update_health_think() {
  self endon("disconnect");
  self endon("death");
  broadcast_health(self);

  while(true) {
    self.old_health = self.health;
    self.old_maxhealth = self.maxhealth;
    wait 0.1;

    if(self.health != self.old_health || self.maxhealth != self.old_maxhealth) {
      broadcast_health(self);
    }
  }
}

function broadcast_health(player) {
  entity_num = player getentitynumber();
  playerhealth = int(player.health);
  playermaxhealth = player.maxhealth;

  if(istrue(player.inlaststand)) {
    health = 0;
  }

  scripts\cp\persistence::setcoopplayerdata_for_everyone("EoGPlayer", entity_num, "playerMaxHealth", playermaxhealth);
  scripts\cp\persistence::setcoopplayerdata_for_everyone("EoGPlayer", entity_num, "playerHealth", playerhealth);
}

function function_c861c37e30cde168(callback) {
  if(!isDefined(level.var_6905e4b813093c94)) {
    level.var_6905e4b813093c94 = [];
  }

  level.var_6905e4b813093c94[level.var_6905e4b813093c94.size] = callback;
}

function function_6c47231521c88e7a(remove_callback) {
  temp_array = [];

  foreach(callback in level.var_6905e4b813093c94) {
    if(remove_callback != callback) {
      temp_array[temp_array.size] = callback;
    }
  }

  level.var_6905e4b813093c94 = temp_array;
}

function function_ca2cb402bf88a284(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  foreach(callback in level.var_6905e4b813093c94) {
    idamage = self[[callback]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
  }

  return idamage;
}