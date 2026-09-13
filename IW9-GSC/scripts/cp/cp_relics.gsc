/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_relics.gsc
***********************************************/

register_relics() {
  level.updateonkillrelicsfunc = ::updateonkillrelics;
  level.updatepersistentrelicsfunc = ::updatepersistentrelics;
  level.updateondamagerelicsfunc = ::updateondamagerelics;
  level.updateondamagepredamagemodrelicsfunc = ::updateondamagepredamagemodrelics;
  level.cp_relics = [];
  level.updaterecentkillsrelics_func = ::updaterecentkills;
  level.updatedroprelicsfunc = ::updatedroprelics;
  level.relic_combos = load_relic_combos_from_table();
  level.modifyplayerdamage_relics = [];

  if(!isDefined(level._id_6905E4B813093C94))
    level._id_6905E4B813093C94 = [];

  if(!isDefined(level.perks))
    level.perks = ["perk_machine_tough", "perk_machine_revive", "perk_machine_flash", "perk_machine_more", "perk_machine_rat_a_tat", "perk_machine_run", "perk_machine_fwoosh", "perk_machine_smack", "perk_machine_zap", "perk_machine_boom"];

  register_relic("passive_railgun_overload", ::init_passive_railgun_overload, ::set_passive_railgun_overload, ::unset_passive_railgun_overload);
  register_relic("passive_last_shots_ammo", ::init_passive_last_shots_ammo, ::set_passive_last_shots_ammo, ::unset_passive_last_shots_ammo);
  register_relic("passive_nuke", ::init_passive_nuke, ::set_passive_nuke, ::unset_passive_nuke);
  register_relic("passive_headshot_ammo", ::init_headshot_ammo, ::set_headshot_ammo, ::unset_headshot_ammo);
  register_relic("passive_headshot_super", ::init_headshot_super, ::set_headshot_super, ::unset_headshot_super);
  register_relic("passive_refresh", ::init_passive_refresh, ::set_passive_refresh, ::unset_passive_refresh);
  register_relic("passive_double_kill_reload", ::init_passive_double_kill_reload, ::set_passive_double_kill_reload, ::unset_passive_double_kill_reload);
  register_relic("passive_gore", ::init_passive_gore, ::set_passive_gore, ::unset_passive_gore);
  register_relic("passive_meleekill", ::init_passive_melee_kill, ::set_passive_melee_kill, ::unset_passive_melee_kill);
  register_relic("passive_health_on_kill", ::init_passive_health_on_kill, ::set_passive_health_on_kill, ::unset_passive_health_on_kill);
  register_relic("passive_health_regen_on_kill", ::init_passive_health_regen_on_kill, ::set_passive_health_regen_on_kill, ::unset_passive_health_regen_on_kill);
  register_relic("passive_move_speed_on_kill", ::init_passive_move_speed_on_kill, ::set_passive_move_speed_on_kill, ::unset_passive_move_speed_on_kill);
  register_relic("passive_hitman", ::init_passive_hitman, ::set_passive_hitman, ::unset_passive_hitman);
  register_relic("passive_score_bonus_kills", ::init_passive_score_bonus_kills, ::set_passive_score_bonus_kills, ::unset_passive_score_bonus_kills);
  register_relic("passive_scorestreak_pack", ::init_passive_score_bonus_kills, ::set_passive_score_bonus_kills, ::unset_passive_score_bonus_kills);
  register_relic("passive_random_perks", ::init_passive_random_perks, ::set_passive_random_perks, ::unset_passive_random_perks);
  register_relic("passive_visor_detonation", ::init_passive_visor_detonation, ::set_passive_visor_detonation, ::unset_passive_visor_detonation);
  register_relic("passive_melee_super", ::init_passive_melee_super, ::set_passive_melee_super, ::unset_passive_melee_super);
  register_relic("passive_jump_super", ::init_passive_jump_super, ::set_passive_jump_super, ::unset_passive_jump_super);
  register_relic("passive_double_kill_super", ::init_passive_double_kill_super, ::set_passive_double_kill_super, ::unset_passive_double_kill_super);
  register_relic("passive_mode_switch_score", ::init_passive_mode_switch_score, ::set_passive_mode_switch_score, ::unset_passive_mode_switch_score);
  register_relic("passive_melee_cone_expl", ::init_passive_melee_cone_expl, ::set_passive_melee_cone_expl, ::unset_passive_melee_cone_expl);
  register_relic("passive_berserk", ::init_passive_berserk, ::set_passive_berserk, ::unset_passive_berserk);
  register_relic("passive_infinite_ammo", ::init_passive_infinite_ammo, ::set_passive_infinite_ammo, ::unset_passive_infinite_ammo);
  register_relic("passive_crouch_move_speed", ::init_passive_crouch_move_speed, ::set_passive_crouch_move_speed, ::unset_passive_crouch_move_speed);
  register_relic("passive_slide_blastshield", ::init_passive_fortified, ::set_passive_fortified, ::unset_passive_fortified);
  register_relic("passive_cold_damage", ::init_passive_cold_damage, ::set_passive_cold_damage, ::unset_passive_cold_damage);
  register_relic("passive_sonic", ::init_passive_sonic, ::set_passive_sonic, ::unset_passive_sonic);
  register_relic("passive_below_the_belt", ::init_passive_below_the_belt, ::set_passive_below_the_belt, ::unset_passive_below_the_belt);
  register_relic("passive_minimap_damage", ::init_passive_minimap_damage, ::set_passive_minimap_damage, ::unset_passive_minimap_damage);
  register_relic("passive_extra_xp", ::init_extra_xp, ::set_extra_xp, ::unset_extra_xp);
  register_relic("passive_fast_melee", ::init_passive_fast_melee, ::set_passive_fast_melee, ::unset_passive_fast_melee);
  register_relic("coop_passive_snap_to_head", ::init_snap_to_head, ::set_snap_to_head, ::unset_snap_to_head);
  register_relic("passive_empty_reload_speed", ::init_passive_empty_reload_speed, ::set_passive_empty_reload_speed, ::unset_passive_empty_reload_speed);
  register_relic("passive_increased_scope_breath", ::init_passive_increased_scope_breath, ::set_passive_increased_scope_breath, ::unset_passive_increased_scope_breath);
  register_relic("passive_hunter_killer", ::init_passive_hunter_killer, ::set_passive_hunter_killer, ::unset_passive_hunter_killer);
  register_relic("passive_move_speed", ::init_passive_move_speed, ::set_passive_move_speed, ::unset_passive_move_speed);
  register_relic("passive_miss_refund", ::init_passive_miss_refund, ::set_passive_miss_refund, ::unset_passive_miss_refund);
  register_relic("passive_scoutping", ::init_passive_scoutping, ::set_passive_scoutping, ::unset_passive_scoutping);
  register_relic("passive_scrambler", ::init_passive_scrambler, ::set_passive_scrambler, ::unset_passive_scrambler);
  register_relic("passive_scope_radar", ::init_passive_scope_radar, ::set_passive_scope_radar, ::unset_passive_scope_radar);
  register_relic("passive_scorestreak_damage", ::init_passive_scorestreak_damage, ::set_passive_scorestreak_damage, ::unset_passive_scorestreak_damage);
  register_relic("passive_scorestreak_damage_e", ::init_passive_scorestreak_damage, ::set_passive_scorestreak_damage, ::unset_passive_scorestreak_damage);
  register_relic("relic_collat_dmg", ::init_relic_collat_dmg, ::set_relic_collat_dmg, ::unset_relic_collat_dmg);
  register_relic("relic_catch", ::init_relic_catch, ::set_relic_catch, ::unset_relic_catch);
  register_relic("relic_boom", ::init_relic_boom, ::set_relic_boom, ::unset_relic_boom);
  register_relic("relic_swat", ::init_relic_swat, ::set_relic_swat, ::unset_relic_swat);
  register_relic("relic_glasscannon", ::init_relic_glasscannon, ::set_relic_glasscannon, ::unset_relic_glasscannon);
  register_relic("relic_aggressive_melee", ::init_relic_aggressive_melee, ::set_relic_aggressive_melee, ::unset_relic_aggressive_melee);
  register_relic("relic_focus_fire", ::init_relic_focus_fire, ::set_relic_focus_fire, ::unset_relic_focus_fire);
  register_relic("relic_damage_from_above", ::init_relic_damage_from_above, ::set_relic_damage_from_above, ::unset_relic_damage_from_above);
  register_relic("relic_landlocked", ::init_relic_landlocked, ::set_relic_landlocked, ::unset_relic_landlocked);
  register_relic("relic_martyrdom", ::init_relic_martyrdom, ::set_relic_martyrdom, ::unset_relic_martyrdom);
  register_relic("relic_gas_martyr", ::init_relic_gas_martyr, ::set_relic_gas_martyr, ::unset_relic_gas_martyr);
  register_relic("relic_gun_game", ::init_relic_gun_game, ::set_relic_gun_game, ::unset_relic_gun_game);
  register_relic("relic_team_proximity", ::init_relic_team_proximity, ::set_relic_team_proximity, ::unset_relic_team_proximity);
  register_relic("relic_squadlink", ::init_relic_squadlink, ::set_relic_squadlink, ::unset_relic_squadlink);
  register_relic("relic_dfa", ::init_relic_dfa, ::set_relic_dfa, ::unset_relic_dfa);
  register_relic("relic_shieldsonly", ::init_relic_shieldsonly, ::set_relic_shieldsonly, ::unset_relic_shieldsonly);
  register_relic("relic_mythic", ::init_relic_mythic, ::set_relic_mythic, ::unset_relic_mythic);
  register_relic("relic_amped", ::init_relic_amped, ::set_relic_amped, ::unset_relic_amped);
  register_relic("relic_thirdperson", ::init_relic_thirdperson, ::set_relic_thirdperson, ::unset_relic_thirdperson);
  register_relic("relic_dogtags", ::init_relic_dogtags, ::set_relic_dogtags, ::unset_relic_dogtags);
  register_relic("relic_lsmelee", ::init_relic_laststandmelee, ::set_relic_laststandmelee, ::unset_relic_laststandmelee);
  register_relic("relic_hideobj", ::init_relic_hideobjicons, ::set_relic_hideobjicons, ::unset_relic_hideobjicons);
  register_relic("relic_expldmg", ::init_relic_explodedmg, ::set_relic_explodedmg, ::unset_relic_explodedmg);
  register_relic("relic_fastbleed", ::init_relic_fastbleedout, ::set_relic_fastbleedout, ::unset_relic_fastbleedout);
  register_relic("relic_nuketimer", ::init_relic_nuketimer, ::set_relic_nuketimer, ::unset_relic_nuketimer);
  register_relic("relic_doubletap", ::init_relic_doubletap, ::set_relic_doubletap, ::unset_relic_doubletap);
  register_relic("relic_vampire", ::init_relic_vampire, ::set_relic_vampire, ::unset_relic_vampire);
  register_relic("relic_healthpacks", ::init_relic_healthpacks, ::set_relic_healthpacks, ::unset_relic_healthpacks);
  register_relic("relic_noregen", ::init_relic_noregen, ::set_relic_noregen, ::unset_relic_noregen);
  register_relic("relic_noks", ::init_relic_noks, ::set_relic_noks, ::unset_relic_noks);
  register_relic("relic_no_ammo_mun", ::init_relic_no_ammo_mun, ::set_relic_no_ammo_mun, ::unset_relic_no_ammo_mun);
  register_relic("relic_lfo", ::init_relic_lfo, ::set_relic_lfo, ::unset_relic_lfo);
  register_relic("relic_aitype_shotgun", undefined, ::set_force_aitype_shotgun, ::unset_force_aitype_shotgun);
  register_relic("relic_aitype_sniper", undefined, ::set_force_aitype_sniper, ::unset_force_aitype_sniper);
  register_relic("relic_aitype_riotshield", undefined, ::set_force_aitype_riotshield, ::unset_force_aitype_riotshield);
  register_relic("relic_aitype_suicidebomber", undefined, ::set_force_aitype_suicidebomber, ::unset_force_aitype_suicidebomber);
  register_relic("relic_aitype_rpg", undefined, ::set_force_aitype_rpg, ::unset_force_aitype_rpg);
  register_relic("relic_aitype_armored", undefined, ::set_force_aitype_armored, ::unset_forced_aitype_armored);
  register_relic("relic_bang_and_boom", ::init_relic_bang_and_boom, ::set_relic_bang_and_boom, ::unset_relic_bang_and_boom);
  register_relic("relic_noluck", ::init_relic_noluck, ::set_relic_noluck, ::unset_relic_noluck);
  register_relic("relic_doomslayer", ::init_relic_doomslayer, ::set_relic_doomslayer, ::unset_relic_doomslayer);
  register_relic("relic_headbullets", ::init_relic_headbullets, ::set_relic_headbullets, ::unset_relic_headbullets);
  register_relic("relic_rocket_kill_ammo", ::init_relic_rocket_kill_ammo, ::set_relic_rocket_kill_ammo, ::unset_relic_rocket_kill_ammo);
  register_relic("relic_oneInTheChamber", ::_id_78E009B52B565FF5, ::_id_78D22D7754B8A60D, ::_id_1BD55BD951802EDA);
  register_relic("relic_punchbullets", ::init_relic_punchbullets, ::set_relic_punchbullets, ::unset_relic_punchbullets);
  register_relic("relic_grounded", ::init_relic_grounded, ::set_relic_grounded, ::unset_relic_grounded);
  register_relic("relic_oneclip", ::init_relic_oneclip, ::set_relic_oneclip, ::unset_relic_oneclip);
  register_relic("relic_laststand", ::init_relic_laststand, ::set_relic_laststand, ::unset_relic_laststand);
  register_relic("relic_steelballs", ::init_relic_steelballs, ::set_relic_steelballs, ::unset_relic_steelballs);
  register_relic("relic_werewolf", ::_id_F9E166D7D6E08899, ::_id_6F59F0D90237A7D1, ::_id_DE81BA7857E0F32E);
  register_relic("relic_nobulletdamage", ::init_relic_nobulletdamage, ::set_relic_nobulletdamage, ::unset_relic_nobulletdamage);
  register_relic("relic_ammo_drain", ::init_relic_ammo_drain, ::set_relic_ammo_drain, ::unset_relic_ammo_drain);
  register_relic("relic_trex", ::init_relic_trex, ::set_relic_trex, ::unset_relic_trex);
  level.globalrelicsfunc = [];
  level.globalrelicsfunc["relic_noks"] = ::handlenokillstreaks;
  level.globalrelicsfunc["relic_no_ammo_mun"] = ::handle_no_ammo_mun;
  level.globalrelicsfunc["relic_lfo"] = ::handlelfo;
  level.globalrelicsfunc["relic_focus_fire"] = ::handlefocusfire;
  level.globalrelicsfunc["relic_mythic"] = ::handlemythic;
  level.globalrelicsfunc["relic_dfa"] = ::handledeathfromabove;
  level.globalrelicsfunc["relic_swat"] = ::checkdamagesourcerelicswat;
  level.globalrelicsfunc["relic_aitype_shotgun"] = ::blank_relic_func;
  level.globalrelicsfunc["relic_aitype_sniper"] = ::blank_relic_func;
  level.globalrelicsfunc["relic_aitype_riotshield"] = ::blank_relic_func;
  level.globalrelicsfunc["relic_aitype_suicidebomber"] = ::blank_relic_func;
  level.globalrelicsfunc["relic_aitype_rpg"] = ::blank_relic_func;
  level.globalrelicsfunc["relic_aitype_armored"] = ::blank_relic_func;
  level.globalrelicsfunc["relic_team_proximity"] = ::global_relic_team_prox_func;
  level.globalrelicsfunc["relic_landlocked"] = ::global_relic_landlocked_func;
  level.globalrelicsfunc["relic_healthpacks"] = ::relic_healthpacks_globalfunc;
  level.globalrelicsfunc["relic_vampire"] = ::relic_vampire_globalfunc;
  level.globalrelicsfunc["relic_squadlink"] = ::global_relic_squadlink_func;
  level.globalrelicsfunc["relic_amped"] = ::global_relic_amped_func;
  level.globalrelicsfunc["relic_oneInTheChamber"] = ::_id_43474778D36C627B;
  level.globalrelicsfunc["relic_werewolf"] = ::_id_9CEFAC9CBEB4C8FB;
  level.globalrelicsfunc["relic_noregen"] = ::_id_E80B26D34F0BCAA9;
  level.globalrelicsfunc["passive_health_regen_on_kill"] = ::_id_C6233B06B1387BAC;
  level.onkillrelics = [];
  level.onkillrelics["passive_nuke"] = ::trackkillsforpassivenuke;
  level.onkillrelics["passive_random_perks"] = ::trackkillsforrandomperks;
  level.onkillrelics["passive_railgun_overload"] = ::dolocalrailgundamage;
  level.onkillrelics["passive_headshot_ammo"] = ::handleheadshotammopassive;
  level.onkillrelics["passive_headshot_super"] = ::addvaluetocardmeter;
  level.onkillrelics["passive_refresh"] = ::handlepassiverefresh;
  level.onkillrelics["passive_double_kill_reload"] = ::doublekillreloadwatcher;
  level.onkillrelics["passive_gore"] = ::handlegorepassive;
  level.onkillrelics["passive_health_regen_on_kill"] = ::handlehealthregenonkillpassive;
  level.onkillrelics["passive_move_speed_on_kill"] = ::handlemovespeedonkillpassive;
  level.onkillrelics["passive_hitman"] = ::handlehitmanpassive;
  level.onkillrelics["passive_meleekill"] = ::handlemeleekillpassive;
  level.onkillrelics["passive_health_on_kill"] = ::handlehealthonkillpassive;
  level.onkillrelics["passive_last_shots_ammo"] = ::handleammoonlastshotskill;
  level.onkillrelics["passive_visor_detonation"] = ::handlevisordetonation;
  level.onkillrelics["passive_melee_super"] = ::handlemeleesuper;
  level.onkillrelics["passive_jump_super"] = ::handleairbornesuper;
  level.onkillrelics["passive_double_kill_super"] = ::handledoublekillssuper;
  level.onkillrelics["passive_melee_cone_expl"] = ::handlemeleeconeexplode;
  level.onkillrelics["passive_berserk"] = ::handleberserk;
  level.onkillrelics["passive_ninja"] = ::handleammoonlastshotskill;
  level.onkillrelics["relic_punchbullets"] = ::handlemeleekillrewardbullets;
  level.onkillrelics["relic_headbullets"] = ::handleheadshotkillrewardbullets;
  level.onkillrelics["relic_rocket_kill_ammo"] = ::handlerocketkillsgiverockets;
  level.onkillrelics["relic_steelballs"] = ::handlemeleekillsteelballs;
  level.onkillrelics["relic_collat_dmg"] = ::handlereliccollatdamage;
  level.onkillrelics["relic_catch"] = ::handlereliccatch;
  level.onkillrelics["relic_boom"] = ::handlerelicboom;
  level.onkillrelics["relic_martyrdom"] = ::handlerelicmartyrdomfrag;
  level.onkillrelics["relic_gas_martyr"] = ::handlerelicmartyrdomgas;
  level.onkillrelics["relic_shieldsonly"] = ::handlerelicshieldsonlyonkill;
  level.onkillrelics["relic_healthpacks"] = ::relic_healthpacks_killfunc;
  level.onkillrelics["relic_amped"] = ::handlerelicampedonkill;
  level.onkillrelics["relic_oneInTheChamber"] = ::_id_3A051D1FD67AE155;
  level.onkillrelics["relic_werewolf"] = ::_id_954B7F9F643B03A5;
  level.persistentrelics = [];
  level.persistentrelics["passive_infinite_ammo"] = ::handleinfiniteammopassive;
  level.persistentrelics["passive_fortified"] = ::handlefortified;
  level.persistentrelics["relic_landlocked"] = ::handlepersistentlandlocked;
  level.persistentrelics["relic_team_proximity"] = ::handlepersistentteamproximity;
  level.persistentrelics["relic_gun_game"] = ::handlepersistentgungame;
  register_relic("relic_just_keep_moving", undefined, ::set_just_keep_moving, ::unset_just_keep_moving);
  level.persistentrelics["relic_just_keep_moving"] = ::handle_just_keep_moving;
  level.ondamagerelics = [];
  level.ondamagerelics["passive_sonic"] = ::handlepassivesonic;
  level.ondamagerelics["passive_minimap_damage"] = ::updatepassiveminimapdamage;
  level.ondamagerelics["passive_cold_damage"] = ::updatepassivecolddamage;
  level.ondamagerelics["relic_swat"] = ::handlerelicswat;
  level.ondamagerelics["relic_collat_dmg"] = ::ondamagereliccollatdmg;
  level.ondamagerelics["relic_vampire"] = ::ondamagerelicvampire;
  level.ondamagerelics["relic_lfo"] = ::ondamagereliclfo;
  level.ondamagerelics["relic_focus_fire"] = ::ondamagerelicfocusfire;
  level.ondamagerelics["relic_damage_from_above"] = ::ondamagerelicfromabove;
  level.ondamagerelics["relic_steelballs"] = ::ondamagerelicsteelballs;
  level.ondamagerelics["relic_doomslayer"] = ::ondamagerelicdoomslayer;
  level.ondamagerelics["relic_squadlink"] = ::ondamagerelicsquadlink;
  level.ondamagerelics["relic_nobulletdamage"] = ::empty;
  level.ondamagerelics["relic_oneInTheChamber"] = ::_id_C72FF7743EC64985;
  level.ondamagerelics["relic_werewolf"] = ::empty;
  level.ondamagepredamagemodrelics = [];
  level.ondamagepredamagemodrelics["relic_focus_fire"] = ::ondamagepredamagemodrelicfocusfire;
  level.ondroprelics = [];
  level.ondroprelics["relic_bang_and_boom"] = ::relic_bang_and_boom_dropfunc;
}

empty(victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc) {
  return idamage;
}

load_relic_combos_from_table() {
  _id_CAB56B5D84A60595 = "cp/cp_relic_combos.csv";
  _id_953F521A64B4E2BB = [];

  for(_id_43348865D9126A85 = 1; _id_43348865D9126A85 <= 10; _id_43348865D9126A85++) {
    _id_2521725CD8132F65 = table_look_up(_id_CAB56B5D84A60595, _id_43348865D9126A85, 1);

    if(_id_2521725CD8132F65 == "") {
      continue;
    }
    _id_953F521A64B4E2BB[_id_43348865D9126A85 - 1] = spawnStruct();
    _id_953F521A64B4E2BB[_id_43348865D9126A85 - 1].scomboname = table_look_up(_id_CAB56B5D84A60595, _id_43348865D9126A85, 1);
    _id_953F521A64B4E2BB[_id_43348865D9126A85 - 1].srelicref1 = table_look_up(_id_CAB56B5D84A60595, _id_43348865D9126A85, 2);
    _id_953F521A64B4E2BB[_id_43348865D9126A85 - 1].srelicref2 = table_look_up(_id_CAB56B5D84A60595, _id_43348865D9126A85, 3);
    _id_953F521A64B4E2BB[_id_43348865D9126A85 - 1].srelicref3 = table_look_up(_id_CAB56B5D84A60595, _id_43348865D9126A85, 4);
    _id_953F521A64B4E2BB[_id_43348865D9126A85 - 1].srelicref4 = table_look_up(_id_CAB56B5D84A60595, _id_43348865D9126A85, 5);
    _id_953F521A64B4E2BB[_id_43348865D9126A85 - 1].srelicref5 = table_look_up(_id_CAB56B5D84A60595, _id_43348865D9126A85, 6);
    _id_953F521A64B4E2BB[_id_43348865D9126A85 - 1].srelicref6 = table_look_up(_id_CAB56B5D84A60595, _id_43348865D9126A85, 7);
  }

  return _id_953F521A64B4E2BB;
}

table_look_up(table, index, _id_0C64DA85CCB3C44B) {
  return tablelookup(table, 0, index, _id_0C64DA85CCB3C44B);
}

init_passive_random_attachment(player) {}

set_passive_random_attachment(player) {}

unset_passive_random_attachment(player) {}

getweaponswithpassive(player, _id_F8B2E6BF3F40AB02) {
  _id_50F783A5617F8940 = [];
  _id_8C788F3A616D44B5 = getarraykeys(player.weapon_passives);

  foreach(key in _id_8C788F3A616D44B5) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < player.weapon_passives[key].size; _id_AC0E594AC96AA3A8++) {
      if(player.weapon_passives[key][_id_AC0E594AC96AA3A8].name == _id_F8B2E6BF3F40AB02)
        _id_50F783A5617F8940[_id_50F783A5617F8940.size] = key;
    }
  }

  _id_50F783A5617F8940 = scripts\engine\utility::array_remove_duplicates(_id_50F783A5617F8940);
  return _id_50F783A5617F8940;
}

init_passive_fast_melee(player) {}

set_passive_fast_melee(player) {
  player.increased_melee_damage = 150;
}

unset_passive_fast_melee(player) {
  player.increased_melee_damage = undefined;
}

init_extra_xp(player) {
  player.weapon_passive_xp_multiplier = 1;
  player.kill_with_extra_xp_passive = 0;
}

set_extra_xp(player) {
  player.weapon_passive_xp_multiplier = 1.25;
}

unset_extra_xp(player) {
  player.weapon_passive_xp_multiplier = 1;
  player.kill_with_extra_xp_passive = 0;
}

init_passive_below_the_belt(player) {
  player.crotch_damage_multiplier = undefined;
}

set_passive_below_the_belt(player) {
  player.crotch_damage_multiplier = 3.75;
}

unset_passive_below_the_belt(player) {
  player.crotch_damage_multiplier = undefined;
}

init_passive_move_speed(player) {
  player.weapon_passive_xp_multiplier = 1;
}

set_passive_move_speed(player) {
  player.weaponpassivespeedmod = 0.05;
  player[[level.move_speed_scale]]();
}

unset_passive_move_speed(player) {
  player.weaponpassivespeedmod = undefined;
  player[[level.move_speed_scale]]();
}

init_passive_empty_reload_speed(player) {}

set_passive_empty_reload_speed(player) {
  player scripts\cp\utility::_setperk("specialty_fastreload_empty");
}

unset_passive_empty_reload_speed(player) {
  player scripts\cp\utility::_unsetperk("specialty_fastreload_empty");
}

init_passive_increased_scope_breath(player) {}

set_passive_increased_scope_breath(player) {
  player scripts\cp\utility::_setperk("specialty_holdbreath");
}

unset_passive_increased_scope_breath(player) {
  player scripts\cp\utility::_unsetperk("specialty_holdbreath");
}

init_snap_to_head(player) {}

set_snap_to_head(player) {
  player scripts\cp\utility::_setperk("specialty_autoaimhead");
}

unset_snap_to_head(player) {
  player scripts\cp\utility::_unsetperk("specialty_autoaimhead");
}

init_passive_hunter_killer(player) {
  self.hunterkilleroutlines = 0;
}

set_passive_hunter_killer(player) {
  self endon("passive_hunter_killer_cancel");
  enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  thread updatehunterkillerplayers(enemies);
  thread hunterkillerlistenforconnect();

  foreach(player in enemies) {
    thread hunterkillerlistenfordisconnect(player);
    thread hunterkillerlistenfordamage(player);
  }
}

unset_passive_hunter_killer(player) {
  self notify("passive_hunter_killer_cancel");

  foreach(outlineid in self.hunterkillerids) {
    player = self.hunterkillerents[outlineid];
    scripts\cp\cp_outline::disable_outline_for_players(player, level.players);
  }

  self.hunterkillerids = undefined;
  self.hunterkillerents = undefined;
}

updatehunterkillerplayers(players) {
  if(!isDefined(self.hunterkillerids))
    self.hunterkillerids = [];

  if(!isDefined(self.hunterkillerents))
    self.hunterkillerents = [];

  foreach(player in players) {
    if(player == self || !isDefined(self) || !isDefined(self.team) || !isDefined(player) || !isDefined(player.team)) {
      continue;
    }
    _id_A13DD9D84D8AD829 = gethunterkillerid(player);

    if(level.teambased && self.team != player.team && player.health / player.maxhealth <= 0.5 && player.health > 0) {
      if(_id_A13DD9D84D8AD829 < 0) {
        self.hunterkilleroutlines++;
        scripts\cp\cp_outline::enable_outline_for_player(player, self, 1, 0, 1, "high");
        outlineid = self.hunterkilleroutlines;
        self.hunterkillerids[self.hunterkillerids.size] = outlineid;
        self.hunterkillerents[outlineid] = player;
        thread hunterkillerlistenforhealth(player);
      }

      continue;
    }

    if(_id_A13DD9D84D8AD829 >= 0) {
      _id_66B9F9ADE3955AF2 = [];
      _id_0E9BA97C24DD424A = [];
      scripts\cp\cp_outline::disable_outline_for_player(player, self);

      foreach(outlineid in self.hunterkillerids) {
        ent = self.hunterkillerents[outlineid];

        if(ent == player) {
          continue;
        }
        _id_66B9F9ADE3955AF2[_id_66B9F9ADE3955AF2.size] = outlineid;
        _id_0E9BA97C24DD424A[outlineid] = ent;
      }

      self.hunterkillerids = _id_66B9F9ADE3955AF2;
      self.hunterkillerents = _id_0E9BA97C24DD424A;
      player notify("passive_hunter_killer_listen_cancel");
    }
  }
}

hunterkillerlistenforhealth(player) {
  self endon("passive_hunter_killer_cancel");
  player endon("passive_hunter_killer_listen_cancel");

  for(;;) {
    wait 1.0;
    thread updatehunterkillerplayer(player);
  }
}

gethunterkillerid(player) {
  if(!isDefined(self.hunterkillerids) || !isDefined(self.hunterkillerents))
    return -1;

  foreach(outlineid in self.hunterkillerids) {
    ent = self.hunterkillerents[outlineid];

    if(!isDefined(ent)) {
      continue;
    }
    if(ent == player)
      return outlineid;
  }

  return -1;
}

hunterkillerlistenforconnect() {
  self endon("passive_hunter_killer_cancel");

  for(;;) {
    level waittill("agent_spawned", player);
    thread updatehunterkillerplayer(player);
    thread hunterkillerlistenfordamage(player);
  }
}

hunterkillerlistenfordisconnect(player) {
  self endon("passive_hunter_killer_cancel");
  player waittill("disconnect");
  thread updatehunterkillerplayer(player);
}

hunterkillerlistenfordamage(player) {
  self endon("passive_hunter_killer_cancel");

  for(;;) {
    player waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, weapon);
    thread updatehunterkillerplayer(player);
  }
}

updatehunterkillerplayer(player) {
  players = [];
  players[players.size] = player;
  thread updatehunterkillerplayers(players);
}

init_passive_refresh(player) {
  player.nextpassiverefreshkills = 0;
}

set_passive_refresh(player) {
  player.onkillrelics["passive_refresh"] = 1;
}

unset_passive_refresh(player) {
  player.onkillrelics["passive_refresh"] = 0;
}

handlepassiverefresh(sweapon, player, victim, smeansofdeath, shitloc, time) {
  player.nextpassiverefreshkills++;

  if(player.nextpassiverefreshkills >= 50) {
    if(isDefined(level.power_adjustcharges))
      player[[level.power_adjustcharges]](undefined, "primary", 1);

    player.nextpassiverefreshkills = 0;
  }
}

init_passive_double_kill_reload(player) {}

set_passive_double_kill_reload(player) {
  player.onkillrelics["passive_double_kill_reload"] = 1;
}

unset_passive_double_kill_reload(player) {
  player.onkillrelics["passive_double_kill_reload"] = 0;
}

doublekillreloadwatcher(sweapon, player, victim, smeansofdeath, shitloc, time) {
  if(player.recentkillcount >= 4) {
    sweapon = player getcurrentweapon();
    _id_A7BE10E54A3A4B99 = weaponclipsize(sweapon);
    _id_AFEA921D82329AFB = player getweaponammostock(sweapon);
    _id_FB6DA439A30039CD = player getweaponammoclip(sweapon);
    _id_D7724E7657D45522 = min(_id_A7BE10E54A3A4B99 - _id_FB6DA439A30039CD, _id_AFEA921D82329AFB);
    _id_94D2E0AD0368AB91 = min(_id_FB6DA439A30039CD + _id_D7724E7657D45522, _id_A7BE10E54A3A4B99);
    player setweaponammoclip(sweapon, int(_id_94D2E0AD0368AB91));
    player setweaponammostock(sweapon, int(_id_AFEA921D82329AFB - _id_D7724E7657D45522));

    if(player isdualwielding()) {
      _id_AFEA921D82329AFB = player getweaponammostock(sweapon);
      _id_FB6DA439A30039CD = player getweaponammoclip(sweapon, "left");
      _id_D7724E7657D45522 = min(_id_A7BE10E54A3A4B99 - _id_FB6DA439A30039CD, _id_AFEA921D82329AFB);
      _id_94D2E0AD0368AB91 = min(_id_FB6DA439A30039CD + _id_D7724E7657D45522, _id_A7BE10E54A3A4B99);
      player setweaponammoclip(sweapon, int(_id_94D2E0AD0368AB91), "left");
      player setweaponammostock(sweapon, int(_id_AFEA921D82329AFB - _id_D7724E7657D45522));
    }
  }
}

init_passive_melee_kill(player) {
  player.passive_melee_kill_damage = 0;
}

set_passive_melee_kill(player) {
  player.skip_weapon_check = 1;
  player.passive_melee_kill_damage = 1000;
  player.onkillrelics["passive_meleekill"] = 1;
}

unset_passive_melee_kill(player) {
  player.skip_weapon_check = undefined;
  player.passive_melee_kill_damage = 0;
  player.onkillrelics["passive_meleekill"] = 0;
}

handlemeleekillpassive(sweapon, player, victim, smeansofdeath, shitloc, time) {
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

handlegoreeffect(victim) {
  position = victim gettagorigin("j_spine4");
  playFX(level._effect["gore"], position, (1, 0, 0));
  playsoundatpos(position, "gib_fullbody");

  foreach(player in level.players)
  player earthquakeforplayer(0.5, 1.5, position, 120);
}

init_passive_gore(player) {}

set_passive_gore(player) {
  player.onkillrelics["passive_gore"] = 1;
}

unset_passive_gore(player) {
  player.onkillrelics["passive_gore"] = 0;
}

handlegorepassive(sweapon, player, victim, smeansofdeath, shitloc, time) {
  level endon("game_ended");
  self endon("disconnect");
  victim endon("diconnect");
  wait 0.05;
  corpse = victim getcorpseentity();

  if(!isDefined(corpse)) {
    return;
  }
  _id_A4F5FB62BA3A113B = corpse.origin;
  earthquake(0.5, 1.5, _id_A4F5FB62BA3A113B, 120);
  playFX(level._effect["corpse_pop"], _id_A4F5FB62BA3A113B + (0, 0, 12));

  if(isDefined(corpse)) {
    corpse hide();
    corpse.permhidden = 1;
  }
}

init_passive_health_on_kill(player) {
  player.passive_regen_on_kill_count = 0;
}

set_passive_health_on_kill(player) {
  player.onkillrelics["passive_health_on_kill"] = 1;
}

unset_passive_health_on_kill(player) {
  player.onkillrelics["passive_health_on_kill"] = 0;
}

handlehealthonkillpassive(sweapon, player, victim, smeansofdeath, shitloc, time) {
  player.passive_regen_on_kill_count++;

  if(player.passive_regen_on_kill_count >= 2) {
    player notify("force_regeneration");
    player.passive_regen_on_kill_count = 0;
  }
}

init_passive_health_regen_on_kill(player) {
  player.passive_regen_on_kill_count = 0;
}

set_passive_health_regen_on_kill(player) {
  player.onkillrelics["passive_health_regen_on_kill"] = 1;
}

_id_C6233B06B1387BAC() {
  setomnvar("ui_showhealthbar", 1);
}

unset_passive_health_regen_on_kill(player) {
  player.onkillrelics["passive_health_regen_on_kill"] = 0;
}

handlehealthregenonkillpassive(sweapon, player, victim, smeansofdeath, shitloc, time) {
  if(player.passive_regen_on_kill_count >= 2 || smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_EXECUTION") {
    player.healthregendisabled = 0;
    player notify("force_regeneration");
    player.passive_regen_on_kill_count = 0;
    wait 5;
    player.healthregendisabled = 1;
  } else
    player.passive_regen_on_kill_count++;
}

init_passive_move_speed_on_kill(player) {
  player.weaponpassivespeedonkillmod = 0;
}

set_passive_move_speed_on_kill(player) {
  player.onkillrelics["passive_move_speed_on_kill"] = 1;
}

unset_passive_move_speed_on_kill(player) {
  player.onkillrelics["passive_move_speed_on_kill"] = 0;
}

handlemovespeedonkillpassive(sweapon, player, victim, smeansofdeath, shitloc, time) {
  message = "passive_move_speed_on_kill";
  player notify(message);
  player endon(message);

  if(player.weaponpassivespeedonkillmod < 0.2) {
    player.weaponpassivespeedonkillmod = 0.2;
    player[[level.move_speed_scale]]();
  } else if(player.weaponpassivespeedonkillmod == 0.2) {
    player.weaponpassivespeedonkillmod = 0.4;
    player[[level.move_speed_scale]]();
  } else if(player.weaponpassivespeedonkillmod > 0.2) {
    player.weaponpassivespeedonkillmod = 0.5;
    player[[level.move_speed_scale]]();
  }

  player scripts\engine\utility::waittill_any_timeout_2(9, "death", "disconnect");

  if(!isDefined(player)) {
    return;
  }
  player.weaponpassivespeedonkillmod = 0;
  player[[level.move_speed_scale]]();
}

init_passive_score_bonus_kills(player) {}

set_passive_score_bonus_kills(player) {
  player.cash_scalar = player.cash_scalar + 0.1;
  player.cash_scalar_weapon = scripts\cp\utility::getrawbaseweaponname(player getcurrentweapon());
}

unset_passive_score_bonus_kills(player) {
  player.cash_scalar = player.cash_scalar - 0.1;
  player.cash_scalar_weapon = undefined;
}

init_passive_hitman(player) {}

set_passive_hitman(player) {
  player.onkillrelics["passive_hitman"] = 1;
}

unset_passive_hitman(player) {
  player.onkillrelics["passive_hitman"] = 0;
}

handlehitmanpassive(sweapon, attacker, victim, smeansofdeath, shitloc, time) {
  if(!isDefined(attacker) || !attacker scripts\cp_mp\utility\player_utility::_isalive() || !isDefined(victim)) {
    return;
  }
  if(!isDefined(attacker.hitmankills))
    attacker.hitmankills = [];
  else if(hitmankeyexists(attacker, victim.birthtime)) {
    return;
  }
  attacker thread resethitmanaftertimeout();
  attacker.hitmankills[attacker.hitmankills.size] = victim.birthtime;

  if(attacker.hitmankills.size >= 10) {
    attacker notify("consumable_charge", 200);
    attacker.hitmankills = [];
  }
}

resethitmanaftertimeout() {
  self notify("hitman_timeout");
  self endon("hitman_timeout");
  self endon("death");
  level endon("game_ended");
  wait 10;
  self.hitmankills = [];
}

hitmankeyexists(attacker, key) {
  if(!isDefined(attacker.hitmankills))
    return 0;

  foreach(_id_33AD9477B6D709AC in attacker.hitmankills) {
    if(_id_33AD9477B6D709AC == key)
      return 1;
  }

  return 0;
}

hitmanpassivedeathwatcher() {
  self endon("disconnect");
  self waittill("death");
  self.hitmankills = undefined;
}

init_passive_nuke(player) {
  player.passivenukekillcount = 0;
  player.lastpassivenukeactivation = 0;
  player thread tracklaststandforpassivenuke(player);
}

set_passive_nuke(player) {
  player.onkillrelics["passive_nuke"] = 1;
}

unset_passive_nuke(player) {
  player.onkillrelics["passive_nuke"] = 0;
}

trackkillsforpassivenuke(sweapon, player, victim, smeansofdeath, shitloc, time) {
  player.passivenukekillcount++;

  if(player.passivenukekillcount >= 3) {
    _id_B19D10A33613EF12 = spawn("script_model", player.origin);
    _id_B19D10A33613EF12 thread scripts\cp\utility::delayentdelete(10);
    enemies = scripts\cp\cp_agent_utils::getactiveenemyagents("allies");
    amount = 0;

    foreach(guy in enemies)
    guy kill();

    player.passivenukekillcount = 0;
  }
}

tracklaststandforpassivenuke(player) {
  level endon("game_ended");
  player endon("disconnect");

  for(;;) {
    player waittill("last_stand");
    player.passivenukekillcount = 0;
  }
}

init_headshot_ammo(player) {}

set_headshot_ammo(player) {
  player.onkillrelics["passive_headshot_ammo"] = 1;
}

unset_headshot_ammo(player) {
  player.onkillrelics["passive_headshot_ammo"] = 0;
}

handleheadshotammopassive(sweapon, player, victim, smeansofdeath, shitloc, time) {
  if(!isDefined(player) || !isDefined(sweapon)) {
    return;
  }
  if(!scripts\cp\utility::isheadshot(sweapon, shitloc, smeansofdeath, player)) {
    return;
  }
  _id_A7BE10E54A3A4B99 = weaponclipsize(sweapon);
  adjust_clip_ammo_from_stock(player, sweapon, "right", _id_A7BE10E54A3A4B99);

  if(player isdualwielding())
    adjust_clip_ammo_from_stock(player, sweapon, "left", _id_A7BE10E54A3A4B99);
}

adjust_clip_ammo_from_stock(player, sweapon, _id_A9F996CAF54DD68C, _id_A7BE10E54A3A4B99) {
  _id_DD2DECF8DB7E69B8 = player getweaponammostock(sweapon);

  if(_id_DD2DECF8DB7E69B8 < 1) {
    return;
  }
  _id_3DBC3B058135CBFB = player getweaponammoclip(sweapon, _id_A9F996CAF54DD68C);
  _id_2A83DF6C49112D96 = _id_A7BE10E54A3A4B99 - _id_3DBC3B058135CBFB;

  if(_id_DD2DECF8DB7E69B8 >= _id_2A83DF6C49112D96)
    player setweaponammostock(sweapon, _id_DD2DECF8DB7E69B8 - _id_2A83DF6C49112D96);
  else {
    _id_2A83DF6C49112D96 = _id_DD2DECF8DB7E69B8;
    player setweaponammostock(sweapon, 0);
  }

  _id_2AA9CAEF99C9AF77 = min(_id_3DBC3B058135CBFB + _id_2A83DF6C49112D96, _id_A7BE10E54A3A4B99);
  player setweaponammoclip(sweapon, int(_id_2AA9CAEF99C9AF77), _id_A9F996CAF54DD68C);
}

init_passive_fortified(player) {
  player.has_fortified_passive = 0;
}

set_passive_fortified(player) {
  player.persistentrelics["passive_fortified"] = 1;
  player.has_fortified_passive = 1;
}

unset_passive_fortified(player) {
  player.persistentrelics["passive_fortified"] = 0;
  player.has_fortified_passive = 0;
}

handlefortified(player, sweapon, victim) {}

init_passive_ninja(player) {}

set_passive_ninja(player) {
  player.persistentrelics["passive_ninja"] = 1;
}

unset_passive_ninja(player) {
  player.persistentrelics["passive_ninja"] = 0;
}

handleninjaonlastshot(player, sweapon, victim) {
  if(!isDefined(player) || !isDefined(sweapon)) {
    return;
  }
  _id_A7BE10E54A3A4B99 = weaponclipsize(sweapon);
  _id_4F39F1D30E0A5D4B = player getweaponammoclip(sweapon, "right");

  if(_id_4F39F1D30E0A5D4B == 0)
    player thread set_player_stealthed();

  if(_id_4F39F1D30E0A5D4B == 0 && !scripts\engine\utility::array_contains(player.stealth_used, "right"))
    player thread set_player_stealthed();
  else if(_id_4F39F1D30E0A5D4B > 0)
    player.stealth_used = scripts\engine\utility::array_remove(player.stealth_used, "right");

  if(player isdualwielding()) {
    _id_5F1E64F3E8613C52 = player getweaponammoclip(sweapon, "left");

    if(_id_5F1E64F3E8613C52 == 0 && !scripts\engine\utility::array_contains(player.stealth_used, "left"))
      player thread set_player_stealthed();
    else if(_id_5F1E64F3E8613C52 > 0)
      player.stealth_used = scripts\engine\utility::array_remove(player.stealth_used, "left");
  }
}

set_player_stealthed() {
  self notify("reset_stealth");
  self endon("reset_stealth");
  self endon("disconnect");

  if(!scripts\cp\utility::isignoremeenabled())
    scripts\cp\utility::allow_player_ignore_me(1);

  playFX(level._effect["stimulus_glow_burst"], scripts\engine\utility::drop_to_ground(self.origin) - (0, 0, 30));
  scripts\engine\utility::play_sound_in_space("zmb_fnf_stimulus", scripts\engine\utility::drop_to_ground(self.origin));

  if(self isdualwielding())
    wait 3.0;
  else
    wait 4.0;

  if(scripts\cp\utility::isignoremeenabled())
    scripts\cp\utility::allow_player_ignore_me(0);
}

init_passive_last_shots_ammo(player) {}

set_passive_last_shots_ammo(player) {
  player.onkillrelics["passive_last_shots_ammo"] = 1;
}

unset_passive_last_shots_ammo(player) {
  player.onkillrelics["passive_last_shots_ammo"] = 0;
}

handleammoonlastshotskill(sweapon, player, victim, smeansofdeath, shitloc, time) {
  if(!isDefined(player) || !isDefined(sweapon)) {
    return;
  }
  _id_A7BE10E54A3A4B99 = weaponclipsize(sweapon);
  _id_3DBC3B058135CBFB = player getweaponammoclip(sweapon, "right");

  if(_id_3DBC3B058135CBFB <= int(_id_A7BE10E54A3A4B99 * 0.2))
    adjust_clip_ammo_from_stock(player, sweapon, "right", _id_A7BE10E54A3A4B99);

  if(player isdualwielding()) {
    _id_3DBC3B058135CBFB = player getweaponammoclip(sweapon, "left");

    if(_id_3DBC3B058135CBFB <= int(_id_A7BE10E54A3A4B99 * 0.2))
      adjust_clip_ammo_from_stock(player, sweapon, "left", _id_A7BE10E54A3A4B99);
  }
}

init_passive_railgun_overload(player) {}

set_passive_railgun_overload(player) {
  player.onkillrelics["passive_railgun_overload"] = 1;
}

unset_passive_railgun_overload(player) {
  player.onkillrelics["passive_railgun_overload"] = 0;
}

dolocalrailgundamage(sweapon, player, victim, smeansofdeath, shitloc, time) {
  if(!isDefined(victim.hitbychargedshot))
    return 0;

  if(!scripts\engine\utility::isbulletdamage(smeansofdeath))
    return 0;

  if(isDefined(victim.agent_type) && (victim.agent_type == "zombie_brute" || victim.agent_type == "zombie_grey" || victim.agent_type == "slasher" || victim.agent_type == "superslasher" || victim.agent_type == "zombie_sasquatch" || victim.agent_type == "lumberjack")) {
    return;
  }
  _id_05E5C37FCED1BB8B = istrue(victim.is_suicide_bomber);
  victim.head_is_exploding = 1;
  org = victim gettagorigin("j_spine4");
  playsoundatpos(victim.origin, "zmb_fnf_headpopper_explo");
  playFX(level._effect["bloody_death"], org);

  if(isDefined(victim.headmodel))
    victim detach(victim.headmodel);

  if(!_id_05E5C37FCED1BB8B)
    victim setscriptablepartstate("head", "hide");

  victim.hitbychargedshot radiusdamage(victim.origin, 64, victim.maxhealth, victim.maxhealth, victim.hitbychargedshot, "MOD_EXPLOSIVE", "iw7_zombieDoors_zm");
  victim.hitbychargedshot = undefined;
}

init_headshot_super(player) {
  player.delayedsuperbonus = 0;
}

set_headshot_super(player) {
  player.onkillrelics["passive_headshot_super"] = 1;
}

unset_headshot_super(player) {
  player.onkillrelics["passive_headshot_super"] = 0;
}

addvaluetocardmeter(sweapon, player, victim, smeansofdeath, shitloc, time) {
  player.delayedsuperbonus++;
  wait(0.05 * player.delayedsuperbonus);
  player.delayedsuperbonus--;

  if(player.delayedsuperbonus < 0)
    player.delayedsuperbonus = 0;

  player notify("consumable_charge", 10);
}

init_passive_sonic(player) {
  player.sonictimer = 0;
}

set_passive_sonic(player) {
  player.ondamagerelics["passive_sonic"] = 1;
}

unset_passive_sonic(player) {
  player.ondamagerelics["passive_sonic"] = 0;
}

handlepassivesonic(player, weapon, victim) {
  time = gettime();

  if(victim scripts\cp\utility::agentisfnfimmune()) {
    return;
  }
  if(time <= player.sonictimer) {
    return;
  }
  if(distance2dsquared(player.origin, victim.origin) <= 62500)
    thread _id_74502A9E0EF1F19C::fx_stun_damage(victim, player);

  player.sonictimer = time + 1000;
}

init_passive_crouch_move_speed(player) {}

set_passive_crouch_move_speed(player) {
  player thread adjust_move_speed_while_crouched(player);
  player thread adjust_move_speed_while_sliding(player);
}

unset_passive_crouch_move_speed(player) {
  player notify("remove_crouch_speed_mod");
  player.weaponpassivespeedmod = undefined;
}

adjust_move_speed_while_sliding(player) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("remove_crouch_speed_mod");

  for(;;) {
    self waittill("sprint_slide_end");

    if(player getstance() == "crouch") {
      if(isDefined(level.move_speed_scale)) {
        player.weaponpassivespeedmod = 0.5;
        player[[level.move_speed_scale]]();
      }
    }

    while(player getstance() == "crouch")
      wait 0.1;

    player.weaponpassivespeedmod = undefined;
    player[[level.move_speed_scale]]();
  }
}

adjust_move_speed_while_crouched(player, weapon) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("remove_crouch_speed_mod");

  for(;;) {
    if(player getstance() == "crouch") {
      if(isDefined(level.move_speed_scale)) {
        player.weaponpassivespeedmod = 0.5;
        player[[level.move_speed_scale]]();
      }
    }

    while(player getstance() == "crouch")
      wait 0.1;

    player.weaponpassivespeedmod = undefined;
    player[[level.move_speed_scale]]();
    player waittill("adjustedStance");
  }
}

init_passive_infinite_ammo(player) {}

set_passive_infinite_ammo(player) {
  player scripts\cp\utility::enable_infinite_ammo(1);
  player.persistentrelics["passive_infinite_ammo"] = 1;
}

unset_passive_infinite_ammo(player) {
  player scripts\cp\utility::enable_infinite_ammo(0);
  player.persistentrelics["passive_infinite_ammo"] = 0;
  player notify("cleanup_watcher_threads_passive_infinite_ammo");
}

handleinfiniteammopassive(player, weapon) {
  player endon("disconnect");
  player endon("cleanup_watcher_threads_passive_infinite_ammo");

  for(;;) {
    player waittill("weapon_fired", objweapon);
    player thread listenforfirecomplete();
    cost = 4;
    ammo = self.health;

    if(ammo - cost < 1)
      cost = 0;

    if(cost > 0)
      player dodamage(cost, player gettagorigin("j_wrist_ri"), player, undefined, "MOD_RIFLE_BULLET");

    player updateinfiniteammopassive(objweapon);
  }
}

listenforfirecomplete() {
  self endon("disconnect");
  self endon("last_stand");
  self notify("infinite_ammo_fire");
  self endon("infinite_ammo_fire");
  self.selfdamaging = 1;
  wait 0.2;
  self.selfdamaging = 0;
}

updateinfiniteammopassive(weapon) {
  ammo = self.health;
  _id_F543B5B38D564A8C = weaponclipsize(weapon);
  self setweaponammoclip(weapon, _id_F543B5B38D564A8C);

  if(self isdualwielding())
    self setweaponammoclip(weapon, _id_F543B5B38D564A8C, "left");
}

init_passive_miss_refund(player) {}

set_passive_miss_refund(player) {
  weapon = player getcurrentweapon();
  player thread missrefundwatcher(weapon);
}

unset_passive_miss_refund(player) {
  player notify("removeMissRefundPassive");
}

missrefundwatcher(weapon) {
  self endon("death");
  self endon("disconnect");
  self endon("removeMissRefundPassive");

  for(;;) {
    self waittill("shot_missed", objweapon);

    if(objweapon == weapon) {
      if(randomfloat(1.0) > 0.75) {
        _id_AFEA921D82329AFB = self getweaponammostock(weapon);
        self setweaponammostock(weapon, _id_AFEA921D82329AFB + 1);
      }
    }
  }
}

init_passive_scrambler(player) {}

set_passive_scrambler(player) {
  player thread handlepassivescrambler(player);
}

unset_passive_scrambler(player) {
  player notify("handlePassiveScrambler");
}

scrambler_executevisuals(_id_31ED809382E5C603) {
  level endon("game_ended");
  self endon("disconnect");
  fxent = spawn("script_model", self gettagorigin("tag_eye"));
  fxent setModel("prop_mp_optic_wave_scr");
  fxent.angles = self getplayerangles();
  fxent setotherent(self);
  fxent setscriptablepartstate("effects", "active", 0);
  endpoint = fxent.origin + anglesToForward(fxent.angles) * 256;
  fxent moveTo(endpoint, _id_31ED809382E5C603);
  scripts\engine\utility::waittill_any_timeout_2(_id_31ED809382E5C603, "last_stand", "death");

  if(isDefined(fxent))
    fxent delete();
}

handlepassivescrambler(player) {
  player notify("handlePassiveScrambler");
  player endon("handlePassiveScrambler");
  level endon("game_ended");
  player endon("disconnect");
  player endon("last_stand");
  player endon("death");

  for(;;) {
    if(randomint(100) > 85) {
      enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
      closestenemies = scripts\engine\utility::get_array_of_closest(player.origin, enemies, undefined, 24, 256);
      count = 0;

      foreach(victim in closestenemies) {
        if(scripts\engine\utility::within_fov(player getEye(), player.angles, victim.origin, cos(65))) {
          if(!count)
            player thread scrambler_executevisuals(0.8);

          thread scrambler_stun_damage(victim, player);
          count++;
        }

        if(count >= 5) {
          break;
        }
      }
    }

    wait(randomfloatrange(5.0, 10.0));
  }
}

scrambler_stun_damage(victim, eattacker) {
  victim endon("death");

  if(isDefined(victim.stun_hit_time)) {
    if(gettime() > victim.stun_hit_time) {
      victim.allowpain = 1;
      victim.stun_hit_time = gettime() + 1000;
      victim.stunned = 1;
    } else
      return;
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

addhealthback(victim) {
  victim endon("death");
  waittillframeend;

  if(victim.health < victim.maxhealth)
    victim.health = victim.health + 1;
}

init_passive_random_perks(player) {
  player.passiverandomperkskillcount = 0;
  player thread tracklaststandforpassiverandomperks(player);
}

tracklaststandforpassiverandomperks(player) {
  level endon("game_ended");
  player endon("disconnect");

  for(;;) {
    player waittill("last_stand");
    player.passiverandomperkskillcount = 0;
  }
}

set_passive_random_perks(player) {
  player.onkillrelics["passive_random_perks"] = 1;
}

trackkillsforrandomperks(sweapon, player, victim, smeansofdeath, shitloc, time) {
  player endon("disconnect");
  player endon("last_stand");
  player endon("death");
  player.passiverandomperkskillcount++;

  if(player.passiverandomperkskillcount >= 75) {
    _id_B2FEA2A31FB0C516 = level.perks;
    player.passiverandomperkskillcount = 0;

    if(!isDefined(player.zombies_perks) || player.zombies_perks.size < 5) {
      for(;;) {
        perk = scripts\engine\utility::random(_id_B2FEA2A31FB0C516);

        if(!player scripts\cp\utility::has_zombie_perk(perk)) {
          player iprintln(" zombies_perk_machines is disabled for now!. Can be reenabled based on requirements. ");
          break;
        } else
          _id_B2FEA2A31FB0C516 = scripts\engine\utility::array_remove(_id_B2FEA2A31FB0C516, perk);

        waitframe();
      }
    }
  }
}

unset_passive_random_perks(player) {
  player.onkillrelics["passive_random_perks"] = 0;
}

init_passive_melee_super(player) {}

set_passive_melee_super(player) {
  player.skip_weapon_check = 1;
  player.onkillrelics["passive_melee_super"] = 1;
}

unset_passive_melee_super(player) {
  player.skip_weapon_check = undefined;
  player.onkillrelics["passive_melee_super"] = 0;
}

handlemeleesuper(sweapon, player, victim, smeansofdeath, shitloc, time) {
  level endon("game_ended");
  player endon("disconnect");

  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_MELEE")
    player notify("consumable_charge", 125);
}

init_passive_jump_super(player) {}

set_passive_jump_super(player) {
  player.onkillrelics["passive_jump_super"] = 1;
  player.current_weapon_jump_super = scripts\cp\utility::getrawbaseweaponname(player getcurrentweapon());
}

unset_passive_jump_super(player) {
  player.onkillrelics["passive_jump_super"] = 0;
  player.current_weapon_jump_super = undefined;
}

handleairbornesuper(sweapon, player, victim, smeansofdeath, shitloc, time) {
  level endon("game_ended");
  player endon("disconnect");

  if(!player isonground() && (isDefined(player.current_weapon_jump_super) && scripts\cp\utility::getrawbaseweaponname(sweapon) == player.current_weapon_jump_super))
    player notify("consumable_charge", 75);
}

init_passive_double_kill_super(player) {}

set_passive_double_kill_super(player) {
  player.onkillrelics["passive_double_kill_super"] = 1;
  player.current_weapon_double_super = scripts\cp\utility::getrawbaseweaponname(player getcurrentweapon());
}

unset_passive_double_kill_super(player) {
  player.onkillrelics["passive_double_kill_super"] = 0;
  player.current_weapon_double_super = undefined;
}

handledoublekillssuper(sweapon, player, victim, smeansofdeath, shitloc, time) {
  level endon("game_ended");
  player endon("disconnect");

  if(isDefined(player.recentkillcount) && (isDefined(player.current_weapon_double_super) && scripts\cp\utility::getrawbaseweaponname(sweapon) == player.current_weapon_double_super)) {
    if(player.recentkillcount == 2)
      player notify("consumable_charge", 125);
  }
}

init_passive_mode_switch_score(player) {}

set_passive_mode_switch_score(player) {
  player.alt_mode_passive = 1;
  player.cash_scalar_alt_weapon = scripts\cp\utility::getrawbaseweaponname(player getcurrentweapon());
  player.cash_scalar = player.cash_scalar + 0.1;
}

unset_passive_mode_switch_score(player) {
  player.cash_scalar = player.cash_scalar - 0.1;
  player.cash_scalar_alt_weapon = undefined;
  player.alt_mode_passive = 0;
}

init_passive_visor_detonation(player) {}

set_passive_visor_detonation(player) {
  player.onkillrelics["passive_visor_detonation"] = 1;
}

unset_passive_visor_detonation(player) {
  player.onkillrelics["passive_visor_detonation"] = 0;
}

handlevisordetonation(sweapon, player, victim, smeansofdeath, shitloc, time) {
  if(!scripts\engine\utility::isbulletdamage(smeansofdeath))
    return 0;

  if(!scripts\cp\utility::isheadshot(sweapon, shitloc, smeansofdeath, player))
    return 0;

  if(isDefined(victim.agent_type) && (victim.agent_type == "zombie_brute" || victim.agent_type == "zombie_grey" || victim.agent_type == "slasher" || victim.agent_type == "superslasher" || victim.agent_type == "zombie_sasquatch" || victim.agent_type == "lumberjack")) {
    return;
  }
  _id_05E5C37FCED1BB8B = istrue(victim.is_suicide_bomber);
  victim.head_is_exploding = 1;
  org = victim gettagorigin("j_spine4");
  playsoundatpos(victim.origin, "zmb_fnf_headpopper_explo");
  playFX(level._effect["bloody_death"], org);

  if(isDefined(victim.headmodel))
    victim detach(victim.headmodel);

  if(!_id_05E5C37FCED1BB8B)
    victim setscriptablepartstate("head", "hide");
}

passive_visor_detonation_activate() {
  self endon("death");
  self endon("disconnect");
  self endon("end_passive_visor_detonation");

  for(;;) {
    self waittill("headshot_done_with_this_weapon", victim, einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, vpoint);
    waitframe();
  }
}

init_passive_berserk(player) {}

set_passive_berserk(player) {
  player.onkillrelics["passive_berserk"] = 1;
}

unset_passive_berserk(player) {
  player.onkillrelics["passive_berserk"] = 0;
}

handleberserk(sweapon, player, victim, smeansofdeath, shitloc, time) {
  if(!istrue(player.berserk)) {
    player.berserk = 1;
    player setfiretimescaleon(65);
    recoilscale = player player_getrecoilscale();

    if(recoilscale < 0)
      recoilscale = 100;

    recoilscale = max(recoilscale - 20, 0);
    player player_recoilscaleon(int(recoilscale));
  }

  player notify("stop_berserk_timer");
  player thread remove_berserk_after_timeout(2);
}

remove_berserk_after_timeout(duration) {
  self endon("end_berserk");
  self endon("stop_berserk_timer");
  self endon("death");
  self endon("disconnect");
  thread listencancelberserk();
  wait(duration);
  unset_berserk();
}

listencancelberserk() {
  self endon("end_berserk");
  self endon("stop_berserk_timer");
  self endon("disconnect");
  scripts\engine\utility::waittill_any_2("death", "weapon_change");
  unset_berserk();
}

unset_berserk() {
  if(istrue(self.berserk)) {
    self.berserk = 0;
    self setfiretimescaleoff();
    recoilscale = self player_getrecoilscale();
    recoilscale = min(recoilscale + 20, 100);
    self player_recoilscaleon(int(recoilscale));
    self notify("end_berserk");
  }
}

unsetquadfeederpassive() {
  self notify("end_quadFeederEffect");
  self notify("end_quadFeederPassive");
  unset_berserk();
}

init_passive_melee_cone_expl(player) {}

set_passive_melee_cone_expl(player) {
  player.onkillrelics["passive_melee_cone_expl"] = 1;
  player.skip_weapon_check = 1;
}

unset_passive_melee_cone_expl(player) {
  player.onkillrelics["passive_melee_cone_expl"] = 0;
  player.skip_weapon_check = undefined;
}

handlemeleeconeexplode(sweapon, player, victim, smeansofdeath, shitloc, time) {
  if(smeansofdeath != "MOD_MELEE") {
    return;
  }
  if(!issubstr(sweapon, "meleervn") && !player isalternatemode(sweapon)) {
    return;
  }
  _id_268C78654C980D1E = victim gettagorigin("j_spineupper");
  _id_CC29543DE9737588 = player getplayerangles();
  _id_E566EA808842FD75 = anglesToForward(_id_CC29543DE9737588);
  _id_A62E5218DE1622B5 = anglestoup(_id_CC29543DE9737588);
  _id_54DCA92A8A182EC0 = _id_268C78654C980D1E - _id_E566EA808842FD75 * 128;
  _id_833622E497A25855 = 384;
  playFX(level._effect["cone_expl_fx"], _id_268C78654C980D1E + (0, 2, 0), _id_E566EA808842FD75, _id_A62E5218DE1622B5);
  _id_067D3D82C5097230 = scripts\cp\cp_agent_utils::get_alive_enemies();

  foreach(zombie in _id_067D3D82C5097230) {
    if(isDefined(zombie.flung) || isDefined(zombie.agent_type) && (zombie.agent_type == "zombie_brute" || zombie.agent_type == "zombie_ghost" || zombie.agent_type == "zombie_grey" || zombie.agent_type == "slasher" || zombie.agent_type == "superslasher")) {
      continue;
    }
    if(!scripts\engine\math::pointvscone(zombie gettagorigin("tag_origin"), _id_54DCA92A8A182EC0, _id_E566EA808842FD75, _id_A62E5218DE1622B5, _id_833622E497A25855, 128, 12)) {
      continue;
    }
    if(zombie damageconetrace(_id_268C78654C980D1E, player) <= 0) {
      continue;
    }
    damage = int(1500 * player _id_74502A9E0EF1F19C::get_weapon_level(sweapon));
    wait 0.05;
    zombie dodamage(damage, _id_268C78654C980D1E, player, player, "MOD_EXPLOSIVE", sweapon);
  }
}

init_passive_minimap_damage(player) {}

set_passive_minimap_damage(player) {
  player.ondamagerelics["passive_minimap_damage"] = 1;
}

unset_passive_minimap_damage(player) {
  player.ondamagerelics["passive_minimap_damage"] = 0;
}

updatepassiveminimapdamage(player, weapon, victim) {
  if(!isDefined(victim)) {
    return;
  }
  hudoutlineassetname = "outlinefill_depth_orange";

  if(isDefined(victim.damaged_by_players))
    hudoutlineassetname = "outlinefill_depth_yellow";

  if(isDefined(victim.marked_for_challenge))
    hudoutlineassetname = "outlinefill_depth_white";
  else
    hudoutlineassetname = "outlinefill_depth_orange";

  level thread set_outline_passive_minimap_damage(player, victim, hudoutlineassetname);
}

enable_outline_for_players(item, players, hudoutlineassetname, priority) {
  item hudoutlineenableforclients(players, hudoutlineassetname);
}

set_outline_passive_minimap_damage(player, victim, hudoutlineassetname) {
  level endon("game_ended");
  level endon("outline_disabled");

  if(!isDefined(victim)) {
    return;
  }
  if(!isDefined(hudoutlineassetname))
    hudoutlineassetname = "outlinefill_depth_orange";

  enable_outline_for_players(victim, level.players, hudoutlineassetname, "high");
  wait 10;
  unset_outline_passive_minimap_damage(victim);
}

disable_outline_for_players(item, players) {
  item hudoutlinedisableforclients(players);
}

unset_outline_passive_minimap_damage(victim) {
  if(!isDefined(victim)) {
    return;
  }
  scripts\cp\cp_outline::disable_outline_for_players(victim, level.players);
}

activate_adrenaline_boost(player) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("last_stand");
  player endon("death");
  player scripts\cp\utility::adddamagemodifier("health_boost", 0.2, 0);
  player notify("force_regeneration");
  player playlocalsound("breathing_heartbeat_alt");
  wait 5;
  player scripts\cp\utility::removedamagemodifier("health_boost", 0);
  player playlocalsound("breathing_limp");
}

adr_boost(player) {
  player notify("updatepassiveminimapdamage");
  level endon("game_ended");
  player endon("disconnect");
  player endon("last_stand");
  player endon("death");

  for(;;) {
    if(randomint(100) > 30) {
      thread run_adrenaline_visuals(player, 5);
      thread activate_adrenaline_boost(player);
    }

    wait(randomfloatrange(5.0, 15.0));
  }
}

remove_adrenaline_visuals(player) {
  player endon("disconnect");
  player endon("last_stand");
  player endon("death");
  player visionsetnakedforplayer("", 0.5);
}

run_adrenaline_visuals(player, _id_31ED809382E5C603) {
  player endon("disconnect");
  player endon("last_stand");
  player endon("death");
  player endon("remove_adrenaline_visuals");
  player visionsetnakedforplayer("missilecam", scripts\engine\utility::ter_op(1, 0.1, 0.0));
  player scripts\engine\utility::waittill_any_timeout_1(_id_31ED809382E5C603, "last_stand");
  player thread remove_adrenaline_visuals(player);
}

init_passive_cold_damage(player) {}

set_passive_cold_damage(player) {
  player.ondamagerelics["passive_cold_damage"] = 1;
  player.cold_weapon = player getcurrentweapon();
}

unset_passive_cold_damage(player) {
  player.ondamagerelics["passive_cold_damage"] = 0;
  player.cold_weapon = undefined;
}

updatepassivecolddamage(player, weapon, victim) {
  _id_7D843CCEDD2761F7 = isDefined(victim.agent_type) && victim.agent_type == "zombie_brute";
  _id_BFF0EF8C04D32552 = isDefined(victim.agent_type) && victim.agent_type == "zombie_grey";
  _id_62F91D5269545D20 = istrue(victim.is_suicide_bomber);

  if(_id_7D843CCEDD2761F7 || _id_BFF0EF8C04D32552 || _id_62F91D5269545D20) {
    return;
  }
  if(isDefined(player.cold_weapon)) {
    if(scripts\cp\utility::getrawbaseweaponname(player.cold_weapon) == scripts\cp\utility::getrawbaseweaponname(weapon)) {
      victim thread unsetslowmovementaftertime(victim, victim.movemode);
      victim.movemode = "slow_walk";
      victim scripts\asm\asm_bb::bb_requestmovetype("slow_walk");
    }
  }
}

unsetslowmovementaftertime(victim, _id_A29497B5A1296685) {
  level endon("game_ended");
  victim endon("death");
  wait 10;

  if(isDefined(_id_A29497B5A1296685)) {
    victim.movemode = _id_A29497B5A1296685;
    victim scripts\asm\asm_bb::bb_requestmovetype(_id_A29497B5A1296685);
  }
}

init_passive_scorestreak_damage(player) {}

set_passive_scorestreak_damage(player) {
  player.special_zombie_damage = 1.1;
}

unset_passive_scorestreak_damage(player) {
  player.special_zombie_damage = undefined;
}

init_passive_scope_radar(player) {
  player.activate_radar = 0;
  player notifyonplayercommand("scope_radar_ads_in", "+speed_throw");
  player notifyonplayercommand("scope_radar_ads_out", "-speed_throw");
}

set_passive_scope_radar(player) {
  player thread updatescoperadar(player);
}

unset_passive_scope_radar(player) {
  player notify("unsetScopeRadar");
  player thread cleanup_outlines(player);
}

updatescoperadar(player) {
  player notify("updateScopeRadar");
  player endon("updateScopeRadar");
  level endon("game_ended");
  player endon("death");
  player endon("disconnect");
  player endon("unsetScopeRadar");
  _id_31ED809382E5C603 = 2.4;
  _id_43E236FCB934E2BE = 1750;

  for(;;) {
    if(!player adsButtonPressed())
      result = player scripts\engine\utility::waittill_any_return_no_endon_death_5("scope_radar_ads_in", "scope_radar_ads_out", "last_stand", "death", "weapon_change");
    else
      result = "scope_radar_ads_in";

    if(result == "scope_radar_ads_in") {
      if(player isnightvisionon())
        runscoperadarinloop(player, _id_31ED809382E5C603, _id_43E236FCB934E2BE);
      else
        waitframe();
    }

    player thread remove_visuals(player);
  }
}

runscoperadarinloop(player, _id_31ED809382E5C603, _id_43E236FCB934E2BE) {
  level endon("game_ended");
  player notify("runScopeRadarInLoop");
  player endon("runScopeRadarInLoop");
  player endon("scope_radar_ads_out");
  player endon("last_stand");
  player endon("death");
  player endon("disconnect");
  _id_0EC415C373FBB512 = 0.75;

  while(player adsButtonPressed()) {
    if(player playerads() >= _id_0EC415C373FBB512) {
      player playlocalsound("uav_ping");
      triggerportableradarping(player.origin, player, 1080, 500);
      player thread scoperadar_executeping(player, _id_31ED809382E5C603, _id_43E236FCB934E2BE);
      player scoperadar_executevisuals(player, _id_31ED809382E5C603);
    }

    waitframe();
  }
}

scoperadar_executeping(player, _id_31ED809382E5C603, _id_43E236FCB934E2BE) {
  level endon("game_ended");
  player endon("death");
  player endon("scope_radar_ads_out");
  hit = 0;
  enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  closestenemies = scripts\engine\utility::get_array_of_closest(player.origin, enemies, undefined, 24, _id_43E236FCB934E2BE);
  player.closestenemies = closestenemies;
  count = 0;

  foreach(victim in player.closestenemies) {
    victim.is_outlined_from_scoperadar = 0;

    if(scripts\engine\utility::within_fov(player getEye(), player.angles, victim.origin, cos(65))) {
      count++;
      _id_340D59422336E85A = victim.origin - player.origin;

      if(1 && vectordot(anglesToForward(player.angles), _id_340D59422336E85A) < 0) {
        continue;
      }
      _id_F85C8A0556EDF077 = _id_43E236FCB934E2BE * _id_43E236FCB934E2BE;

      if(length2dsquared(_id_340D59422336E85A) > _id_F85C8A0556EDF077) {
        continue;
      }
      player thread outlineplayerbydistance(victim, player, distance2d(player.origin, victim.origin) / _id_43E236FCB934E2BE, _id_31ED809382E5C603);
      hit = 1;
    }
  }
}

enable_outline_for_player(item, player, hudoutlineassetname, priority) {
  item hudoutlineenableforclient(player, hudoutlineassetname);
}

outlineplayerbydistance(victim, player, delay, _id_31ED809382E5C603) {
  level endon("game_ended");
  player endon("scope_radar_ads_out");
  player endon("last_stand");
  player endon("death");
  player endon("disconnect");
  player endon("weapon_change");
  wait(_id_31ED809382E5C603 * delay);
  color = 1;
  victim.is_outlined_from_scoperadar = 1;
  enable_outline_for_player(victim, player, "snapshotgrenade", "high");
}

watchhighlightfadetime(player, ent, time) {
  player endon("disconnect");
  level endon("game_ended");
  player scripts\engine\utility::waittill_any_timeout_no_endon_death_1(time);

  if(isDefined(ent))
    disable_outline_for_player(ent, player);
}

disable_outline_for_player(item, player) {
  item hudoutlinedisableforclient(player);
}

scoperadar_executevisuals(player, _id_31ED809382E5C603) {
  level endon("game_ended");
  player endon("disconnect");
  player scripts\engine\utility::waittill_any_timeout_no_endon_death_5(_id_31ED809382E5C603, "last_stand", "death", "scope_radar_ads_out", "weapon_change", "unsetScopeRadar");

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

remove_visuals(player) {
  enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(victim in enemies) {
    if(isDefined(victim)) {
      if(istrue(victim.is_outlined_from_scoperadar)) {
        disable_outline_for_player(victim, player);
        victim.is_outlined_from_scoperadar = 0;
      }
    }
  }

  if(isDefined(player.fxent))
    player.fxent delete();
}

cleanup_outlines(player) {
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

init_passive_scoutping(player) {}

set_passive_scoutping(player) {
  player thread updatescoutping(player);
}

unset_passive_scoutping(player) {
  player notify("unsetScoutPing");
}

updatescoutping(player) {
  player endon("death");
  player endon("disconnect");
  player endon("unsetScoutPing");
  _id_1C1158E87E764422 = 1000;
  _id_B45893C03493D1F5 = 0.1;

  for(;;) {
    enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    _id_9F47268324F609B3 = _id_1C1158E87E764422;
    _id_FF9D6502D5D4DC7A = _id_B45893C03493D1F5;
    _id_9F47268324F609B3 = int(_id_9F47268324F609B3);
    _id_FF9D6502D5D4DC7A = float(_id_FF9D6502D5D4DC7A);

    if(isDefined(enemies))
      closestenemies = scripts\engine\utility::get_array_of_closest(player.origin, enemies, undefined, 24, _id_9F47268324F609B3);
    else {
      waitframe();
      continue;
    }

    if(closestenemies.size >= 1) {
      foreach(guy in closestenemies) {
        scripts\cp\cp_outline::enable_outline_for_players(guy, level.players, "outline_nodepth_red", "low");
        wait(_id_FF9D6502D5D4DC7A);
      }

      continue;
    }

    waitframe();
  }
}

updateonkillrelics(sweapon, player, victim, smeansofdeath, shitloc) {
  if(!isDefined(player.onkillrelics)) {
    return;
  }
  time = gettime();
  keys = getarraykeys(player.onkillrelics);

  if(!isDefined(keys)) {
    return;
  }
  foreach(key in keys) {
    if(istrue(player.onkillrelics[key]))
      thread[[level.onkillrelics[key]]](sweapon, player, victim, smeansofdeath, shitloc, time);
  }
}

updatepersistentrelics(player) {
  if(!isDefined(player.persistentrelics)) {
    return;
  }
  time = gettime();
  keys = getarraykeys(player.persistentrelics);

  if(!isDefined(keys)) {
    return;
  }
  foreach(key in keys) {
    if(istrue(player.persistentrelics[key]))
      player thread[[level.persistentrelics[key]]](player);
  }
}

updateondamagerelics(player, weapon, victim, smeansofdeath, shitloc, time) {
  _id_C6F09D77AC58260A = undefined;

  if(isPlayer(victim))
    _id_C6F09D77AC58260A = victim;
  else if(isPlayer(player))
    _id_C6F09D77AC58260A = player;

  if(!isDefined(_id_C6F09D77AC58260A)) {
    return;
  }
  if(!isDefined(_id_C6F09D77AC58260A.ondamagerelics)) {
    return;
  }
  time = gettime();
  keys = getarraykeys(_id_C6F09D77AC58260A.ondamagerelics);

  if(!isDefined(keys)) {
    return;
  }
  foreach(key in keys) {
    if(istrue(_id_C6F09D77AC58260A.ondamagerelics[key]))
      thread[[level.ondamagerelics[key]]](player, weapon, victim, smeansofdeath, shitloc, time);
  }
}

updateondamagepredamagemodrelics(player, weapon, victim, smeansofdeath, shitloc, time) {
  _id_C6F09D77AC58260A = undefined;

  if(isPlayer(victim))
    _id_C6F09D77AC58260A = victim;
  else if(isPlayer(player))
    _id_C6F09D77AC58260A = player;
  else if(isDefined(player.owner) && isPlayer(player.owner))
    _id_C6F09D77AC58260A = player.owner;

  if(!isDefined(_id_C6F09D77AC58260A)) {
    return;
  }
  if(!isDefined(_id_C6F09D77AC58260A.ondamagerelics)) {
    return;
  }
  time = gettime();
  keys = getarraykeys(_id_C6F09D77AC58260A.ondamagerelics);

  if(!isDefined(keys)) {
    return;
  }
  foreach(key in keys) {
    if(isDefined(_id_C6F09D77AC58260A.ondamagepredamagemodrelics)) {
      if(istrue(_id_C6F09D77AC58260A.ondamagepredamagemodrelics[key])) {
        if(isDefined(level.ondamagepredamagemodrelics[key]))
          thread[[level.ondamagepredamagemodrelics[key]]](player, weapon, victim, smeansofdeath, shitloc, time);
      }
    }
  }
}

updatedroprelics(position, _id_4D8D96D547DF2E9F) {
  player = undefined;

  if(!isPlayer(_id_4D8D96D547DF2E9F.eattacker)) {
    if(!isDefined(_id_4D8D96D547DF2E9F.eattacker.owner))
      return;
    else
      player = _id_4D8D96D547DF2E9F.eattacker.owner;
  } else
    player = _id_4D8D96D547DF2E9F.eattacker;

  if(!isDefined(player) || !isDefined(player.ondroprelics)) {
    return;
  }
  time = gettime();
  keys = getarraykeys(player.ondroprelics);

  if(!isDefined(keys)) {
    return;
  }
  foreach(key in keys) {
    if(istrue(player.ondroprelics[key]))
      thread[[level.ondroprelics[key]]](position, _id_4D8D96D547DF2E9F);
  }
}

init() {
  if(scripts\cp\utility::is_wave_gametype() || scripts\cp\utility::is_specops_gametype()) {
    return;
  }
  load_relics_vfx();
  register_relics();
  relics_monitor();
  level thread player_connect_monitor();
}

load_relics_vfx() {
  level._effect["headshot_explode"] = loadfx("vfx/iw8_cp/misc/vfx_cp_head_explode.vfx");
  level._effect["headshot_explode_jugg"] = loadfx("vfx/iw8_cp/misc/vfx_cp_head_explode_jug.vfx");
  level._effect["healthpack_pickup"] = loadfx("vfx/iw8_cp/vfx_healthpack_vanish.vfx");
  level._effect["healthpack_spawn"] = loadfx("vfx/iw8_cp/vfx_healthpack.vfx");
  level._effect["stump_landing"] = loadfx("vfx/iw9/killstreaks/smk_signal/vfx_carepkg_landing_dust.vfx");
}

player_connect_monitor() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);
    init_relic_vars(player);
    player thread relics_monitor_on_player();
  }
}

init_relic_vars(player) {
  player.onkillrelics = [];
  player.persistentrelics = [];
  player.ondamagerelics = [];
  player.relics = [];
}

relics_monitor() {
  level endon("game_ended");
  load_relics_from_playlistdvars();
}

relics_monitor_on_player() {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player notify("relics_monitor");
  player endon("relics_monitor");
  player.activated_relics = [];
  scripts\engine\utility::flag_wait("strike_init_done");
  player init_and_set_relics(player);

  for(;;) {
    player waittill("relic_update", _id_B86FAB7ECCFE6B1E, _id_E3108E412AFB3811);

    if(isDefined(_id_E3108E412AFB3811)) {
      if(!istrue(_id_E3108E412AFB3811)) {
        unset_relics(player, _id_B86FAB7ECCFE6B1E);
        continue;
      }

      set_relics(player, _id_B86FAB7ECCFE6B1E);
    }
  }
}

load_relics_from_playlistdvars() {
  level.set_relics = [];
  _id_934386CAE08481B2 = getDvar("dvar_3D6CC59E7F693916", "");
  _id_CE22EF601C001A14 = strtok(_id_934386CAE08481B2, ",");

  foreach(_id_51B4FDBA55E239F5 in _id_CE22EF601C001A14) {
    if(isDefined(_id_51B4FDBA55E239F5) && _id_51B4FDBA55E239F5 != "") {
      level.set_relics[_id_51B4FDBA55E239F5] = 1;
      level thread run_global_functions_for_relics(_id_51B4FDBA55E239F5);
    }
  }
}

run_global_functions_for_relics(_id_B86FAB7ECCFE6B1E) {
  if(isDefined(level.globalrelicsfunc[_id_B86FAB7ECCFE6B1E]) && isfunction(level.globalrelicsfunc[_id_B86FAB7ECCFE6B1E]))
    level thread[[level.globalrelicsfunc[_id_B86FAB7ECCFE6B1E]]]();
}

load_relics_via_dvar() {
  level endon("game_ended");
  level.set_relics = [];

  for(;;) {
    _id_934386CAE08481B2 = getDvar("dvar_3D6CC59E7F693916", "");
    _id_CE22EF601C001A14 = strtok(_id_934386CAE08481B2, ",");

    foreach(_id_51B4FDBA55E239F5 in _id_CE22EF601C001A14) {
      if(istrue(level.set_relics[_id_51B4FDBA55E239F5])) {
        waitframe();
        continue;
      }

      if(isDefined(_id_51B4FDBA55E239F5) && _id_51B4FDBA55E239F5 != "") {
        level.set_relics[_id_51B4FDBA55E239F5] = 1;

        foreach(player in level.players)
        player notify("relic_update", _id_51B4FDBA55E239F5, 1);
      }
    }

    waitframe();
  }
}

set_ui_omnvar_for_relics(_id_B86FAB7ECCFE6B1E) {
  player = self;

  if(!isDefined(player.relic_count))
    player.relic_count = 1;
  else
    player.relic_count = player.relic_count + 1;

  _id_382474A05FA50063 = tablelookup("cp/cp_relic_table.csv", 1, _id_B86FAB7ECCFE6B1E, 0);
  _id_FE8F7703F6313ED4 = int(_id_382474A05FA50063);
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

  player setclientomnvar(omnvar, _id_FE8F7703F6313ED4);
}

unload_relics_via_dvar() {
  level endon("game_ended");

  for(;;) {
    _id_934386CAE08481B2 = getDvar("dvar_F5B4DCFA3901B441", "");
    _id_CE22EF601C001A14 = strtok(_id_934386CAE08481B2, ",");

    foreach(_id_51B4FDBA55E239F5 in _id_CE22EF601C001A14) {
      if(istrue(level.set_relics[_id_51B4FDBA55E239F5])) {
        if(isDefined(_id_51B4FDBA55E239F5) && _id_51B4FDBA55E239F5 != "") {
          foreach(player in level.players)
          player notify("relic_update", _id_51B4FDBA55E239F5, 0);

          level.set_relics[_id_51B4FDBA55E239F5] = undefined;
        }
      }
    }

    waitframe();
  }
}

debug_set_relic(player, _id_51B4FDBA55E239F5) {
  if(isDefined(_id_51B4FDBA55E239F5) && isDefined(level.cp_relics[_id_51B4FDBA55E239F5])) {
    player.relics[_id_51B4FDBA55E239F5] = level.cp_relics[_id_51B4FDBA55E239F5];
    set_relics(player, _id_51B4FDBA55E239F5);
  }
}

debug_unset_relic(player, _id_51B4FDBA55E239F5) {
  if(isDefined(_id_51B4FDBA55E239F5) && isDefined(level.cp_relics[_id_51B4FDBA55E239F5])) {
    player.relics[_id_51B4FDBA55E239F5] = level.cp_relics[_id_51B4FDBA55E239F5];
    unset_relics(player, _id_51B4FDBA55E239F5);
  }
}

init_and_set_relics(player) {
  foreach(_id_B86FAB7ECCFE6B1E, _id_E3108E412AFB3811 in level.set_relics) {
    _id_CF69AD1C1A0C0498 = level.cp_relics[_id_B86FAB7ECCFE6B1E];
    _id_B86FAB7ECCFE6B1E = _id_CF69AD1C1A0C0498.name;
    set_relics(player, _id_B86FAB7ECCFE6B1E);
  }
}

unset_relics(player, _id_B86FAB7ECCFE6B1E) {
  _id_2004669327B0A7ED = level.cp_relics[_id_B86FAB7ECCFE6B1E];

  if(!isDefined(_id_2004669327B0A7ED)) {
    return;
  }
  if(isDefined(_id_2004669327B0A7ED)) {
    if(isDefined(_id_2004669327B0A7ED) && isDefined(_id_2004669327B0A7ED.unset_func))
      [[_id_2004669327B0A7ED.unset_func]](player);

    player.activated_relics = scripts\engine\utility::array_remove(player.activated_relics, _id_2004669327B0A7ED.name);
  }
}

set_relics(player, _id_B86FAB7ECCFE6B1E) {
  _id_2004669327B0A7ED = level.cp_relics[_id_B86FAB7ECCFE6B1E];

  if(!isDefined(_id_2004669327B0A7ED)) {
    return;
  }
  if(isDefined(_id_2004669327B0A7ED)) {
    if(isDefined(_id_2004669327B0A7ED) && isDefined(_id_2004669327B0A7ED.init_func))
      [[_id_2004669327B0A7ED.init_func]](player);
  }

  if(isDefined(_id_2004669327B0A7ED) && isDefined(_id_2004669327B0A7ED.set_func))
    [[_id_2004669327B0A7ED.set_func]](player);

  if(isDefined(level.updatepersistentrelicsfunc))
    level thread[[level.updatepersistentrelicsfunc]](player);

  player.activated_relics = scripts\engine\utility::array_add(player.activated_relics, _id_2004669327B0A7ED.name);
  player set_ui_omnvar_for_relics(_id_2004669327B0A7ED.name);
}

register_relic(_id_B86FAB7ECCFE6B1E, init_func, set_func, unset_func) {
  _id_2004669327B0A7ED = spawnStruct();
  _id_2004669327B0A7ED.init_func = init_func;
  _id_2004669327B0A7ED.set_func = set_func;
  _id_2004669327B0A7ED.unset_func = unset_func;
  _id_2004669327B0A7ED.name = _id_B86FAB7ECCFE6B1E;
  level.cp_relics[_id_B86FAB7ECCFE6B1E] = _id_2004669327B0A7ED;
}

parserelicstable() {
  if(!isDefined(level.lootpassivesstructs))
    level.lootpassivesstructs = [];

  _id_CB89110314447B2F = 0;

  for(;;) {
    id = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", _id_CB89110314447B2F, 0);

    if(id == "") {
      break;
    }

    _id_9F77FA0224FD3B6B = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", _id_CB89110314447B2F, 1);
    passivestringref = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", _id_CB89110314447B2F, 2);
    attachmentref = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", _id_CB89110314447B2F, 12);
    perkref = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", _id_CB89110314447B2F, 13);
    messageref = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", _id_CB89110314447B2F, 15);
    prdprobability = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", _id_CB89110314447B2F, 23);
    prdconstant = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", _id_CB89110314447B2F, 24);
    maxrolls = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", _id_CB89110314447B2F, 25);
    struct = spawnStruct();
    struct.name = _id_9F77FA0224FD3B6B;
    struct.passivestringref = passivestringref;
    struct.passiveindex = int(id);
    struct.weapontype = scripts\engine\utility::ter_op(tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", _id_CB89110314447B2F, 8) == "", 0, 1);
    struct.killstreaktype = scripts\engine\utility::ter_op(tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", _id_CB89110314447B2F, 9) == "", 0, 1);
    struct.lethaltype = scripts\engine\utility::ter_op(tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", _id_CB89110314447B2F, 10) == "", 0, 1);
    struct.tacticaltype = scripts\engine\utility::ter_op(tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", _id_CB89110314447B2F, 11) == "", 0, 1);

    if(attachmentref != "")
      struct.attachmentref = attachmentref;

    if(getDvar("ui_gametype") == "zombie" || getDvar("ui_gametype") == "cp_strike") {
      _id_4C1A232672DB4B7F = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", _id_CB89110314447B2F, 22);

      if(_id_4C1A232672DB4B7F != "")
        struct.attachmentref = _id_4C1A232672DB4B7F;
    }

    if(perkref != "")
      struct.perkref = perkref;

    if(messageref != "")
      struct.messageref = messageref;

    if(isDefined(prdprobability))
      struct.prdprobability = int(prdprobability);

    if(isDefined(prdconstant))
      struct.prdconstant = float(prdconstant);

    if(isDefined(maxrolls))
      struct.maxrolls = int(maxrolls);

    if(!isDefined(level.lootpassivesstructs[_id_9F77FA0224FD3B6B]))
      level.lootpassivesstructs[_id_9F77FA0224FD3B6B] = struct;

    _id_CB89110314447B2F++;
  }
}

updaterecentkills(victim, weapon) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentKills");
  self endon("updateRecentKills");
  self.recentkillcount++;
  _id_66B240BF0B2BAFF8 = getweaponbasename(weapon);

  if(!isDefined(self.killsperweaponlog[_id_66B240BF0B2BAFF8]))
    self.killsperweaponlog[_id_66B240BF0B2BAFF8] = 1;
  else
    self.killsperweaponlog[_id_66B240BF0B2BAFF8]++;

  if(!isDefined(self.recentkillsperweapon))
    self.recentkillsperweapon = [];

  if(!isDefined(self.recentkillsperweapon[_id_66B240BF0B2BAFF8]))
    self.recentkillsperweapon[_id_66B240BF0B2BAFF8] = 1;
  else
    self.recentkillsperweapon[_id_66B240BF0B2BAFF8]++;

  wait 3.5;
  self.recentkillcount = 0;
  self.recentkillsperweapon = undefined;
}

init_relic_collat_dmg(player) {}

set_relic_collat_dmg(player) {
  player.ondamagerelics["relic_collat_dmg"] = 1;
  level.explosivedamagemod = 0.4;
  player.onkillrelics["relic_collat_dmg"] = 1;
}

unset_relic_collat_dmg(player) {
  level.explosivedamagemod = undefined;
  player.ondamagerelics["relic_collat_dmg"] = 0;
  player.onkillrelics["relic_collat_dmg"] = 0;
}

ondamagereliccollatdmg(eattacker, sweapon, _id_E851FFA44B7E0D54, smeansofdeath, shitloc, timeoffset) {
  if(!isagent(_id_E851FFA44B7E0D54)) {
    return;
  }
  if(!scripts\cp\utility::isheadshot(sweapon, shitloc, smeansofdeath, eattacker) && (smeansofdeath != "MOD_MELEE" && smeansofdeath != "MOD_IMPACT")) {
    return;
  }
  _id_E851FFA44B7E0D54.nocorpse = 1;
}

handlereliccollatdamage(sweapon, player, victim, smeansofdeath, shitloc, time) {
  if(!scripts\cp\utility::isheadshot(sweapon, shitloc, smeansofdeath, player) && (smeansofdeath != "MOD_MELEE" && smeansofdeath != "MOD_IMPACT")) {
    return;
  }
  isjuggernaut = isDefined(victim.unittype) && victim.unittype == "juggernaut";
  vpoint = victim.origin;

  if(victim tagexists("j_head"))
    vpoint = victim gettagorigin("j_head");
  else if(victim tagexists("tag_eye"))
    vpoint = victim gettagorigin("tag_eye");

  victim.bdiedonce = 1;

  if(isjuggernaut) {
    radiusdamage(victim.origin + (0, 0, 60), 512, 666, 69, player, "MOD_RIFLE_BULLET");
    scripts\cp\utility\cp_controlled_callbacks::runcontrolledcallback("Earthquake", 1.0, 0.6, victim.origin, 84);
    playFX(level._effect["claymore_explode"], vpoint);
  } else {
    radiusdamage(victim.origin + (0, 0, 60), 333, 333, 33, player, "MOD_RIFLE_BULLET");
    scripts\cp\utility\cp_controlled_callbacks::runcontrolledcallback("Earthquake", 1.0, 0.6, victim.origin, 84);
    playFX(level._effect["claymore_explode"], vpoint);
  }

  if(isDefined(victim.deathsound) && soundexists(victim.deathsound))
    playsoundatpos(victim.origin, victim.deathsound);

  playrumbleonposition("grenade_rumble", victim.origin);
}

init_relic_catch(player) {
  level.grenade_drop_cooldown = [];
  level._id_A0D48F3F14B6015D = ["brloot_offhand_claymore", "brloot_offhand_gas", "brloot_offhand_frag", "brloot_offhand_molotov", "brloot_offhand_semtex", "brloot_offhand_thermite"];
  level._id_317452953C148027 = ::_id_D5153F326998F468;
  _id_703FDBB02501D31E::_id_6C38AF1AB38E980E("brloot_offhand_frag", _id_703FDBB02501D31E::_id_3EEB69D40AD71F2B, "equipment", 1, undefined, 100, 0);
  _id_703FDBB02501D31E::_id_6C38AF1AB38E980E("brloot_offhand_molotov", _id_703FDBB02501D31E::_id_3EEB69D40AD71F2B, "equipment", 1, undefined, 100, 0);
  _id_703FDBB02501D31E::_id_6C38AF1AB38E980E("brloot_offhand_semtex", _id_703FDBB02501D31E::_id_3EEB69D40AD71F2B, "equipment", 1, undefined, 100, 0);
  _id_703FDBB02501D31E::_id_6C38AF1AB38E980E("brloot_offhand_thermite", _id_703FDBB02501D31E::_id_3EEB69D40AD71F2B, "equipment", 1, undefined, 100, 0);
}

set_relic_catch(player) {
  player.onkillrelics["relic_catch"] = 1;
  _id_18A73A64992DD07D::add_global_spawn_function("axis", ::load_relic_catch_params);
}

unset_relic_catch(player) {
  player.onkillrelics["relic_catch"] = 0;
  _id_18A73A64992DD07D::remove_global_spawn_function("axis", ::load_relic_catch_params);
}

_id_D5153F326998F468() {
  _id_D49285246B443066 = scripts\engine\utility::array_randomize(level._id_A0D48F3F14B6015D)[0];
  _id_703FDBB02501D31E::_id_6FDBF71C8217CFC5(_id_D49285246B443066);
}

handlereliccatch(sweapon, player, victim, smeansofdeath, shitloc, time) {}

should_drop_grenade(_id_4D8D96D547DF2E9F) {
  _id_94C7BEB63EF70F85 = getdvarint("dvar_0796D3B42936BAA1");

  if(_id_94C7BEB63EF70F85)
    return 1;

  if(!isDefined(level.grenade_drop_cooldown))
    return 0;

  if(isDefined(self.unittype) && self.unittype == "suicidebomber")
    return 0;

  if(!isDefined(_id_4D8D96D547DF2E9F.eattacker))
    return 0;

  cooldown = 10;
  _id_4FB72B720667636B = gettime();
  _id_4269518899253F17 = _id_4D8D96D547DF2E9F.eattacker getentitynumber();

  if(!isDefined(level.grenade_drop_cooldown[_id_4269518899253F17])) {
    level.grenade_drop_cooldown[_id_4269518899253F17] = _id_4FB72B720667636B + cooldown * 1000;
    return 1;
  }

  if(_id_4FB72B720667636B > level.grenade_drop_cooldown[_id_4269518899253F17]) {
    level.grenade_drop_cooldown[_id_4269518899253F17] = _id_4FB72B720667636B + cooldown * 1000;
    return 1;
  }

  return 0;
}

load_relic_catch_params() {
  self.script_forcegrenade = 1;
  self.grenadeammo = 255;
  self.grenadesafedist = 64;
}

implement_cointoss(_id_A15426692301F3F0) {
  return scripts\engine\utility::cointoss();
}

init_relic_boom(player) {}

set_relic_boom(player) {
  player.onkillrelics["relic_boom"] = 1;
}

unset_relic_boom(player) {
  player.onkillrelics["relic_boom"] = 0;
}

handlerelicboom(sweapon, player, victim, smeansofdeath, shitloc, time) {
  grenade = magicgrenademanual("thermite_mp", victim.origin, (0, 0, 0));
  grenade.owner = victim;
  victim thread scripts\cp\equipment\cp_thermite::thermite_used(grenade);
}

init_relic_swat(player) {
  scripts\cp\utility\cp_controlled_callbacks::registercontrolledcallback("Earthquake", ::earthquake, 5, ::allow_earthquake, 0, 0, 0, 1, 1);
}

allow_earthquake(_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117, _id_D2806125E4C7F8E6) {
  return 1;
}

set_relic_swat(player) {
  player.ondamagerelics["relic_swat"] = 1;

  if(!scripts\engine\utility::array_contains(level.modifyplayerdamage_relics, ::relic_swat_modifyplayerdamage))
    level.modifyplayerdamage_relics = scripts\engine\utility::array_add(level.modifyplayerdamage_relics, ::relic_swat_modifyplayerdamage);
}

is_relic_swat_active() {
  return istrue(level.set_relics["relic_swat"]);
}

is_relic_collat_dmg_active() {
  return istrue(level.set_relics["relic_collat_dmg"]);
}

is_relic_active(_id_F51F7E151E0EE2F0) {
  if(isDefined(level.set_relics) && isDefined(level.set_relics[_id_F51F7E151E0EE2F0]))
    return istrue(level.set_relics[_id_F51F7E151E0EE2F0]);
  else
    return 0;
}

checkdamagesourcerelicswat() {
  if(!isDefined(level.should_do_damage_check_func_relics))
    level.should_do_damage_check_func_relics = [];

  level.should_do_damage_check_func_relics = scripts\engine\utility::array_add(level.should_do_damage_check_func_relics, ::validatedamagerelicswat);
}

validatedamagerelicswat(eattacker, idamage, smeansofdeath, objweapon, shitloc, victim) {
  if(!isDefined(eattacker))
    return 1;

  if(isDefined(eattacker.owner)) {
    if(!isPlayer(eattacker.owner))
      return 1;
  }

  if(!isPlayer(eattacker))
    return 1;

  _id_6F37D6DF94D21D0B = smeansofdeath == "MOD_IMPACT";
  _id_93DDA441E5C43170 = smeansofdeath == "MOD_EXPLOSIVE_BULLET" && (isDefined(shitloc) && shitloc == "none") || smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH";
  _id_F6FCAAA9C3B578A5 = smeansofdeath == "MOD_FIRE";
  _id_B4A897B1262EA17C = isDefined(eattacker.classname) && eattacker.classname == "script_vehicle" && isDefined(eattacker.owner) && isPlayer(eattacker.owner);
  _id_F3B5D704CA2A9B3D = _id_B4A897B1262EA17C && smeansofdeath == "MOD_CRUSH";
  _id_B2F70B31E5B3822F = isDefined(eattacker.classname) && eattacker.classname == "script_vehicle" && !isDefined(eattacker.owner);
  _id_565D1EE9D540FA9E = _id_B2F70B31E5B3822F && smeansofdeath == "MOD_CRUSH";
  _id_B826059690277749 = smeansofdeath == "MOD_CRUSH";
  _id_0099E18F2C5E98E1 = smeansofdeath == "MOD_EXECUTION";
  _id_375FDAA7D2C0E39F = smeansofdeath == "MOD_MELEE";
  _id_E716D999A313692E = _id_6F37D6DF94D21D0B || _id_93DDA441E5C43170 || _id_0099E18F2C5E98E1 || _id_375FDAA7D2C0E39F || _id_B826059690277749 || _id_B4A897B1262EA17C || _id_F3B5D704CA2A9B3D || _id_B2F70B31E5B3822F || _id_565D1EE9D540FA9E || is_killstreak_valid_for_swat(objweapon) || scripts\cp\utility::isheadshot(objweapon, shitloc, smeansofdeath, eattacker);

  if(_id_E716D999A313692E)
    return 1;

  if(isPlayer(eattacker) && isai(victim)) {
    if(_id_E716D999A313692E)
      return 1;
    else
      return 0;
  } else
    return 1;

  return 0;
}

unset_relic_swat(player) {
  player.ondamagerelics["relic_swat"] = 0;
  level.modifyplayerdamage_relics = scripts\engine\utility::array_remove(level.modifyplayerdamage_relics, ::relic_swat_modifyplayerdamage);
}

relic_swat_modifyplayerdamage(victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc) {
  if(validatedamagerelicswat(eattacker, idamage, smeansofdeath, objweapon, shitloc, victim))
    return idamage;
  else
    return 0;
}

is_killstreak_valid_for_swat(objweapon) {
  if(!isDefined(objweapon))
    return 0;

  switch (objweapon.basename) {
    case "cruise_proj_mp":
    case "nuke_mp":
      return 1;
    case "bradley_tow_proj_mp":
    case "bradley_tow_proj_ks_mp":
    case "iw8_la_kgolf_mp":
    case "iw8_la_rpapa7_mp":
    case "at_mine_mp":
    case "emp_drone_non_player_mp":
    case "emp_drone_non_player_direct_mp":
    case "iw8_la_gromeoks_mp":
    case "iw8_la_gromeo_mp":
    case "iw8_la_juliet_mp":
    case "iw9_la_gromeo_mp":
    case "chopper_gunner_proj_mp":
    case "fuelstrike_proj_mp":
    case "gunship_hellfire_mp":
    case "hover_jet_proj_mp":
    case "gunship_105mm_mp":
      return 1;
    case "hummer_mp":
    case "blima_mp":
    case "palfa_mp":
    case "pickup_2014_mp":
    case "cougar_mp":
    case "pwc_mp":
    case "sedan_hatchback_1985_hsk_mp":
    case "sedan_hatchback_1985_mp":
    case "chopped_pickup_mp":
    case "overland_2016_mp":
    case "suv_1996_mp":
    case "patrol_boat_wkd_mp":
    case "patrol_boat_mp":
    case "jltv_mg_hsk_mp":
    case "jltv_mg_mp":
    case "jltv_hsk_mp":
    case "jltv_mp":
    case "rhib_mp":
    case "lighttank_mp":
    case "hoopty_truck_mp":
    case "van_mp":
    case "mrap_mp":
    case "cargo_truck_mg_mp":
    case "cargo_truck_mp":
    case "med_transport_mp":
    case "hoopty_mp":
    case "pickup_truck_mp":
    case "cop_car_mp":
    case "apc_rus_mp":
    case "large_transport_mp":
    case "atv_mp":
    case "tac_rover_mp":
    case "little_bird_mg_mp":
    case "little_bird_mp":
    case "technical_mp":
    case "white_phosphorus_proj_mp":
    case "suv_1996_wrecked_mp":
    case "iw9_tur_light_tank_mp":
    case "iw9_mg_cougar_mp":
    case "iw9_tur_cougar_mp":
    case "gunship_40mm_mp":
    case "toma_proj_mp":
      return 1;
    case "semtex_mp":
    case "frag_grenade_mp":
    case "claymore_mp":
    case "at_mine_ap_mp":
    case "c4_mp":
    case "thermite_av_mp":
    case "gunship_25mm_mp":
    case "thermite_bolt_mp":
    case "pac_sentry_turret_mp":
    case "artillery_mp":
      return 1;
    default:
      return 0;
  }
}

handlerelicswat(eattacker, sweapon, _id_E851FFA44B7E0D54, smeansofdeath, shitloc, timeoffset) {
  if(isPlayer(eattacker))
    _id_E851FFA44B7E0D54 notify("hit_ai", eattacker);
}

init_relic_damage_from_above(player) {}

set_relic_damage_from_above(player) {
  player.ondamagerelics["relic_damage_from_above"] = 1;
  player.damage_from_above = 1;
}

unset_relic_damage_from_above(player) {
  player.ondamagerelics["relic_damage_from_above"] = undefined;
  player.damage_from_above = undefined;
}

init_relic_glasscannon(player) {}

set_relic_glasscannon(player) {
  while(!isDefined(player.gs))
    waitframe();

  player.og_health_value = player.maxhealth;
  player.og_health_regen_delay = player.gs.healthregendelay;
  player.og_health_regen_rate = player.gs.healthregenrate;
  player.maxhealth = 100;
  player.gs.healthregendelay = 1.5;
  player.gs.healthregenrate = 50;
}

unset_relic_glasscannon(player) {
  player.maxhealth = player.og_health_value;
  player.gs.healthregendelay = player.og_health_regen_delay;
  player.gs.healthregenrate = player.og_health_regen_rate;
}

handlepersistentteamproximity(player, sweapon, victim) {}

init_relic_team_proximity(player) {}

set_relic_team_proximity(player) {
  player.persistentrelics["relic_team_proximity"] = 1;
}

unset_relic_team_proximity(player) {
  player.persistentrelics["relic_team_proximity"] = 0;
}

global_relic_team_prox_func() {
  level thread relic_team_proximity_monitor(1000);
}

relic_team_proximity_monitor(_id_9E7480CF70643465) {
  level endon("game_ended");
  level waittill("player_spawned_with_loadout");

  for(;;) {
    players = level.players;

    if(players.size <= 1) {
      wait 3;
      continue;
    }

    foreach(player in players) {
      if(!is_player_valid_for_team_proximity(player)) {
        if(isDefined(player.is_far_from_team)) {
          if(isDefined(level.onteamproximitybecameinvalidplayer)) {
            foreach(func in level.onteamproximitybecameinvalidplayer)
            player thread[[func]](player);
          }
        }

        player.is_far_from_team = undefined;
        continue;
      }

      if(get_distance_to_closest_teammate(player) > _id_9E7480CF70643465) {
        if(!istrue(player.is_far_from_team)) {
          if(isDefined(level.onteamproximitysteppedfar)) {
            foreach(func in level.onteamproximitysteppedfar)
            player thread[[func]](player);
          }
        }

        player.is_far_from_team = 1;
        continue;
      }

      if(istrue(player.is_far_from_team)) {
        if(isDefined(level.onteamproximitysteppedclose)) {
          foreach(func in level.onteamproximitysteppedclose)
          player thread[[func]](player);
        }
      }

      player.is_far_from_team = 0;
    }

    waitframe();
  }
}

is_player_valid_for_team_proximity(player) {
  invalid = !isalive(player) || istrue(player.inlaststand) || istrue(player.bspawningviaac130) || istrue(player.ishotjoiningplayer);
  return !invalid;
}

get_distance_to_closest_teammate(player) {
  players = scripts\cp\utility::getplayersinteam(player.team);

  if(players.size <= 1)
    return 0;

  _id_AC7A7CABD87A4EBF = -1;

  foreach(_id_F0EA4030349A33D5 in players) {
    if(_id_F0EA4030349A33D5 == player) {
      continue;
    }
    _id_5C1EE5AB8012EA11 = distance2d(player.origin, _id_F0EA4030349A33D5.origin);

    if(_id_5C1EE5AB8012EA11 < _id_AC7A7CABD87A4EBF || _id_AC7A7CABD87A4EBF < 0)
      _id_AC7A7CABD87A4EBF = _id_5C1EE5AB8012EA11;
  }

  return _id_AC7A7CABD87A4EBF;
}

global_relic_amped_func() {
  scripts\cp\utility\cp_controlled_callbacks::registercontrolledcallback("Earthquake", ::earthquake, 5, ::allow_earthquake, 0, 0, 0, 1, 1);
  level thread relic_amped_monitor("allies");
}

init_relic_amped(player) {}

relic_amped_monitor(team) {
  level endon("game_ended");
  level notify("relic_amped_single_thread");
  level endon("relic_amped_single_thread");

  if(!isDefined(team))
    team = "allies";

  for(;;) {
    if(!isDefined(level.relic_amped_explosion_time)) {
      wait 0.2;
      continue;
    }

    if(!isDefined(level.relic_amped_victim) || !relic_amped_is_player_valid_to_explode(level.relic_amped_victim) || has_relic_amped_victim_filled_bar()) {
      if(istrue(has_relic_amped_victim_filled_bar()) && !istrue(relic_amped_is_there_valid_new_victim())) {
        relic_amped_clear_victim();
        relic_amped_pause(1);
        wait 3.0;
        relic_amped_pause(0);
        continue;
      } else {
        level.relic_amped_victim = relic_amped_pick_new_victim(team, 1);

        if(!isDefined(level.relic_amped_victim))
          level waittill("killed_enemy");
        else
          waitframe();

        continue;
      }
    }

    if(isDefined(level.ampeddelta) && level.ampeddelta <= 0) {
      victim = level.relic_amped_victim;

      if(isDefined(victim)) {
        level relic_amped_do_explosion(victim);
        relic_amped_pause(1);
        wait 3.0;
        relic_amped_pause(0);
      } else
        level waittill("killed_enemy");

      continue;
    }

    waitframe();
  }
}

relic_amped_monitor_beeps(team) {
  level endon("game_ended");
  level endon("relic_amped_stop_timer");
  level endon("relic_amped_explosion");
  level notify("relic_amped_beeps_single_thread");
  level endon("relic_amped_beeps_single_thread");

  if(!isDefined(team))
    team = "allies";

  for(;;) {
    if(!isDefined(level.relic_amped_explosion_time) || !isDefined(level.ampeddelta)) {
      waitframe();
      continue;
    }

    _id_F7DD536EB8B3D570 = 0.5;

    if(level.ampeddelta > 7500.0)
      _id_F7DD536EB8B3D570 = 0.5;
    else if(level.ampeddelta > 5000.0) {
      relic_amped_play_beep("breach_warning_beep_01", team);
      _id_F7DD536EB8B3D570 = 1;
    } else {
      relic_amped_play_beep("breach_warning_beep_02", team);
      _id_F7DD536EB8B3D570 = 0.2;
    }

    if(isDefined(level.relic_amped_victim) && level.ampeddelta <= -1500) {
      return;
    }
    wait(_id_F7DD536EB8B3D570);
  }
}

has_relic_amped_victim_filled_bar() {
  if(!isDefined(level.relic_amped_victim))
    return 1;

  return istrue(level.relic_amped_victim.has_filled_amped_bar);
}

has_relic_amped_victim_survived_time() {
  if(!isDefined(level.relic_amped_victim))
    return 1;

  if(!isDefined(level.relic_amped_victim.amped_victim_starttime)) {
    level.relic_amped_victim.amped_victim_starttime = gettime();
    return 0;
  }

  return gettime() - level.relic_amped_victim.amped_victim_starttime >= 15000;
}

relic_amped_debug_sim_kills(interval) {
  level endon("game_ended");
  level notify("relic_ampeddebug_single_thread");
  level endon("relic_ampeddebug_single_thread");
  level waittill("player_spawned_with_loadout");
  wait 3;

  for(;;) {
    wait(interval);
    relic_amped_on_ai_kill();
  }
}

relic_amped_on_ai_kill() {
  level notify("killed_enemy");

  if(!istrue(level.relic_amped_paused) && !istrue(level.relic_amped_in_warning)) {
    if(!isDefined(level.relic_amped_explosion_time)) {
      level.relic_amped_explosion_time = gettime() + 10000;
      _id_98346DF6B2C8F0A1 = level.relic_amped_explosion_time;
    } else
      _id_98346DF6B2C8F0A1 = level.relic_amped_explosion_time + 6000;

    maxtime = gettime() + 20000;
    level.relic_amped_last_kill_time = gettime();
    level.relic_amped_explosion_time = min(_id_98346DF6B2C8F0A1, maxtime);

    if(isDefined(level.relic_amped_victim) && _id_98346DF6B2C8F0A1 > maxtime)
      level.relic_amped_victim.has_filled_amped_bar = 1;
  }
}

relic_amped_show_timer(victim, _id_8D7CEF8BADD52C3D) {
  level endon("game_ended");
  level endon("relic_amped_stop_timer");
  level endon("relic_amped_explosion");
  victim endon("disconnect");
  victim endon("death");
  level notify("relic_ampedtimer_single_thread");
  level endon("relic_ampedtimer_single_thread");
  _id_49FE006C43B630AA = gettime();
  _id_4956F0C9EA4E725F = _id_49FE006C43B630AA + 2000;
  _id_484D2CAC8BBCE3AE = 0;
  level.relic_amped_in_warning = 1;

  if(isDefined(level.amped_wid))
    objective_setprogress(level.amped_wid, 0);

  while(_id_4956F0C9EA4E725F > gettime()) {
    _id_373BDFA57FC2EBEE = max(gettime() - _id_49FE006C43B630AA, 0.1);
    _id_484D2CAC8BBCE3AE = _id_373BDFA57FC2EBEE / 2000 / 2;

    if(isDefined(victim))
      victim setclientomnvar("ui_relic_meter_progress", _id_484D2CAC8BBCE3AE);

    waitframe();
  }

  level.relic_amped_in_warning = 0;

  if(istrue(_id_8D7CEF8BADD52C3D))
    level.relic_amped_explosion_time = gettime() + 10000;

  level thread relic_amped_monitor_beeps("allies");

  for(;;) {
    if(!isDefined(level.relic_amped_explosion_time)) {
      waitframe();
      continue;
    }

    level.ampeddelta = level.relic_amped_explosion_time - gettime();

    if(level.ampeddelta > 0) {
      victim setclientomnvar("ui_relic_meter_progress", level.ampeddelta / 20000);

      if(isDefined(level.amped_wid))
        objective_setprogress(level.amped_wid, level.ampeddelta / 20000);
    } else {
      victim setclientomnvar("ui_relic_meter_progress", 0);
      objective_setprogress(level.amped_wid, 0);
    }

    if(isDefined(level.relic_amped_victim) && level.ampeddelta <= -1500) {
      if(relic_amped_is_player_valid_to_explode(level.relic_amped_victim))
        level relic_amped_do_explosion(level.relic_amped_victim);

      relic_amped_pause(1);
      wait 3.0;
      relic_amped_pause(0);
      level notify("relic_amped_stop_timer");
    }

    waitframe();
  }
}

relic_amped_play_beep(alias, team) {
  if(!soundexists(alias)) {
    return;
  }
  if(isDefined(level.relic_amped_victim))
    level.relic_amped_victim playSound(alias);
}

relic_amped_is_there_valid_new_victim() {
  _id_D4AD5ED2E97B85D2 = level.relic_amped_victim;

  if(!isDefined(_id_D4AD5ED2E97B85D2))
    return 1;

  _id_CEB1FF9428033CFD = scripts\engine\utility::array_remove(scripts\cp\utility::getplayersinteam(_id_D4AD5ED2E97B85D2.team), _id_D4AD5ED2E97B85D2);

  if(_id_CEB1FF9428033CFD.size <= 0)
    return 0;

  foreach(player in _id_CEB1FF9428033CFD) {
    if(relic_amped_is_player_valid_to_explode(player))
      return 1;
  }

  return 0;
}

relic_amped_clear_victim() {
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

relic_amped_test_explode_other_player(interval) {
  for(;;) {
    player = undefined;

    if(level.players.size > 1) {
      player = level.players[1];
      player scripts\engine\utility::ent_flag_wait("player_spawned_with_loadout");
    }

    if(isDefined(player)) {
      player.receivingampeddamage = 1;
      player.shouldskipdeathsshield = 1;
      player dodamage(player.maxhealth + 100000, player.origin, player, undefined, "MOD_SUICIDE");
      player waittill("revived");
      wait(interval);
      continue;
    }

    wait 1;
  }
}

relic_amped_pick_new_victim(team, _id_8D7CEF8BADD52C3D) {
  _id_D4AD5ED2E97B85D2 = undefined;

  if(isDefined(level.relic_amped_victim)) {
    _id_D4AD5ED2E97B85D2 = level.relic_amped_victim;
    relic_amped_clear_victim();
  }

  victim = relic_amped_pick_random_valid_player(team, _id_D4AD5ED2E97B85D2);

  if(getdvarint("dvar_027284304096A567", 0) > 0 && level.players.size > 1 && relic_amped_is_player_valid_to_explode(level.players[0]))
    victim = level.players[0];

  if(!isDefined(victim)) {
    return;
  }
  level.relic_amped_victim = victim;
  level.relic_amped_victim.amped_victim_starttime = gettime();
  level.relic_amped_victim.has_filled_amped_bar = 0;
  relic_amped_set_head_objective(victim);

  if(!isDefined(_id_8D7CEF8BADD52C3D))
    _id_8D7CEF8BADD52C3D = 0;

  level.ampeddelta = undefined;
  level thread relic_amped_show_timer(victim, _id_8D7CEF8BADD52C3D);
  return victim;
}

relic_amped_pick_random_valid_player(team, _id_CAAEE13684C90FB8) {
  players = scripts\cp\utility::getplayersinteam(team);

  foreach(player in players) {
    if(!relic_amped_is_player_valid_to_explode(player))
      players = scripts\engine\utility::array_remove(players, player);
  }

  if(players.size <= 0)
    return undefined;

  if(isDefined(_id_CAAEE13684C90FB8) && scripts\engine\utility::array_contains(players, _id_CAAEE13684C90FB8) && players.size > 1)
    players = scripts\engine\utility::array_remove(players, _id_CAAEE13684C90FB8);

  return scripts\engine\utility::random(players);
}

relic_amped_set_head_objective(player) {
  if(!isDefined(level.amped_wid)) {
    _id_FA927B0338099D9F = scripts\cp\cp_objectives::requestworldid("ampedWID");
    level.amped_wid = _id_FA927B0338099D9F;
    objective_setplayintro(_id_FA927B0338099D9F, 0);
    objective_setplayoutro(_id_FA927B0338099D9F, 0);
    objective_state(_id_FA927B0338099D9F, "current");
    objective_icon(_id_FA927B0338099D9F, "icon_waypoint_timed");
    objective_setbackground(_id_FA927B0338099D9F, 0);
    objective_setshowoncompass(_id_FA927B0338099D9F, 1);
    objective_setshowprogress(_id_FA927B0338099D9F, 1);
    objective_setprogress(_id_FA927B0338099D9F, 0);
  }

  objective_onentity(level.amped_wid, player);
  objective_setzoffset(level.amped_wid, 90);
  objective_addalltomask(level.amped_wid);
  objective_showtoplayersinmask(level.amped_wid);
}

relic_amped_is_player_valid_to_explode(player) {
  _id_575BDB17A0A65BB1 = player scripts\engine\utility::ent_flag("player_spawned_with_loadout");
  invalid = !isalive(player) || istrue(player.inlaststand) || istrue(player.respawn_in_progress) || istrue(player.bspawningviaac130) || isDefined(player.super_invulnerable) || !istrue(_id_575BDB17A0A65BB1);
  return !invalid;
}

relic_amped_debug_explode_after_reviving() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  player = level.players[0];
  player endon("death");
  player waittill("started_revive");
  wait 4;
  player.receivingampeddamage = 1;
  player.shouldskipdeathsshield = 1;
  player dodamage(player.maxhealth + 100000, player.origin, player, undefined, "MOD_SUICIDE");
}

relic_amped_do_explosion(player) {
  level endon("game_ended");
  vpoint = player.origin;

  if(player tagexists("j_head"))
    vpoint = player gettagorigin("j_head");
  else if(player tagexists("tag_eye"))
    vpoint = player gettagorigin("tag_eye");

  _id_1A305763F670DCE9 = 3000;
  _id_9FA829C447BFA7C9 = gettime();

  while(istrue(player.invulnerable) && gettime() - _id_9FA829C447BFA7C9 <= _id_1A305763F670DCE9)
    waitframe();

  vehicle = player scripts\cp_mp\utility\player_utility::getvehicle();
  player.receivingampeddamage = 1;
  player.shouldskipdeathsshield = 1;
  player dodamage(player.maxhealth + 100000, player.origin, player, undefined, "MOD_SUICIDE");
  radiusdamage(player.origin + (0, 0, 60), 600, player.maxhealth, player.maxhealth, undefined, "MOD_RIFLE_BULLET");
  scripts\cp\utility\cp_controlled_callbacks::runcontrolledcallback("Earthquake", 1.0, 0.6, player.origin, 84);
  earthquake(1.0, 0.6, player.origin, 333);
  playFX(level._effect["headshot_explode"], vpoint);
  player playSound("gib_fullbody");

  if(isDefined(vehicle))
    vehicle dodamage(vehicle.maxhealth, (0, 0, 0), undefined, undefined);

  player.receivingampeddamage = 0;
  playrumbleonposition("grenade_rumble", player.origin);
  player setclientomnvar("ui_relic_meter_progress", 0);
  player.amped_victim_starttime = undefined;
  level notify("relic_amped_explosion");
  player thread relic_amped_reset_deathshield_on_revived(player);
}

relic_amped_reset_deathshield_on_revived(player) {
  level endon("game_ended");
  player endon("disconnect");

  while(!isalive(player) || istrue(player.inlaststand) || istrue(player.respawn_in_progress))
    wait 1;

  player scripts\engine\utility::waittill_any_2("revive", "death");
  player setclientomnvar("ui_relic_meter_progress", 0);
  player.shouldskipdeathsshield = 0;
  player.shouldskiplaststand = 0;
}

set_relic_amped(player) {
  player.onkillrelics["relic_amped"] = 1;
}

unset_relic_amped(player) {
  player.onkillrelics["relic_amped"] = 0;
}

relic_amped_pause(_id_41D8BF229CF29051) {
  level.relic_amped_paused = _id_41D8BF229CF29051;

  if(istrue(_id_41D8BF229CF29051)) {
    level notify("relic_amped_stop_timer");

    if(isDefined(level.amped_wid)) {
      objective_addalltomask(level.amped_wid);
      objective_hidefromplayersinmask(level.amped_wid);
    }

    if(isDefined(level.relic_amped_victim))
      level.relic_amped_victim = undefined;

    level.relic_amped_explosion_time = undefined;
    level.relic_amped_last_kill_time = undefined;
    level.ampeddelta = undefined;
  } else {}
}

handlerelicampedonkill(sweapon, player, victim, smeansofdeath, shitloc, time) {
  if(!isDefined(player) || !isai(victim)) {
    return;
  }
  if(!isDefined(level.relic_amped_victim)) {
    relic_amped_pick_new_victim(player.team, 1);
    relic_amped_on_ai_kill();
  } else if(level.relic_amped_victim == player)
    relic_amped_on_ai_kill();
}

init_relic_shieldsonly(player) {
  player thread relic_shieldsonly_set_player_stats_after_spawn(player);
}

relic_shieldsonly_set_player_stats_after_spawn(player) {
  level endon("game_ended");
  player endon("disconnect");
  player waittill("spawned_player");
  player.maxhealth = 1;
  scripts\cp\cp_armor::givearmor(player, 100, 1);
}

set_relic_shieldsonly(player) {
  player.onkillrelics["relic_shieldsonly"] = 1;
}

unset_relic_shieldsonly(player) {
  player.onkillrelics["relic_shieldsonly"] = 0;
}

handlerelicshieldsonlyonkill(sweapon, player, victim, smeansofdeath, shitloc, time) {
  if(!isDefined(player)) {
    return;
  }
  if(scripts\cp\cp_armor::player_have_full_armor(player)) {
    return;
  }
  _id_D5DB260BCF9E2170 = scripts\cp\cp_armor::get_player_armor_amount(player);
  _id_80454E38D2BB435C = int(clamp(_id_D5DB260BCF9E2170 + 50, 50, 100));
  scripts\cp\cp_armor::givearmor(player, _id_80454E38D2BB435C, 1);
}

relic_squadlink_init_vfx() {
  level._effect["vfx_squadlink_tunnelvision"] = loadfx("vfx/iw8_cp/misc/vfx_cp_tunnel_vision.vfx");
}

global_relic_squadlink_func() {
  level thread relic_team_proximity_monitor(666);

  if(!isDefined(level.onteamproximitysteppedfar))
    level.onteamproximitysteppedfar = [];

  if(!isDefined(level.onteamproximitysteppedclose))
    level.onteamproximitysteppedclose = [];

  if(!isDefined(level.onteamproximitybecameinvalidplayer))
    level.onteamproximitybecameinvalidplayer = [];

  level.onteamproximitysteppedclose = scripts\engine\utility::array_add(level.onteamproximitysteppedclose, ::relic_squadlink_onsteppedclose);
  level.onteamproximitysteppedfar = scripts\engine\utility::array_add(level.onteamproximitysteppedfar, ::relic_squadlink_onsteppedfar);
  level.onteamproximitybecameinvalidplayer = scripts\engine\utility::array_add(level.onteamproximitybecameinvalidplayer, ::relic_squadlink_onbecameinvalidplayer);

  if(!scripts\engine\utility::array_contains(level.modifyplayerdamage_relics, ::relic_squadlink_modifyplayerdamage))
    level.modifyplayerdamage_relics = scripts\engine\utility::array_add(level.modifyplayerdamage_relics, ::relic_squadlink_modifyplayerdamage);
}

handlepersistentrelicsquadlink(player, sweapon, victim) {}

relic_squadlink_onsteppedclose(player) {
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

relic_squadlink_onsteppedfar(player) {
  level endon("game_ended");
  player.relicsquadlink = 0;
  player notify("squadlink_stepped_too_far");
  player relic_squadlink_turn_team_headobjectives(player, 1);
  player thread relic_squadlink_toofar_hud_logic(player);

  if(getdvarint("dvar_AD06C12CB7279087", 0) != 0)
    player thread relic_squadlink_vision_debuff(player);
}

relic_squadlink_onbecameinvalidplayer(player) {
  level endon("game_ended");
  player setclientomnvar("ui_cp_relic_squad_link", 0);
}

relic_squadlink_flash_squadlink_icon(player, timer, _id_7A410E817719294E, _id_9FF3B5E66759EAA6) {
  level endon("game_ended");
  player endon(_id_7A410E817719294E);
  player endon("death");
  player endon("disconnect");
  player setclientomnvar("ui_cp_relic_squad_link", _id_9FF3B5E66759EAA6);
  wait(timer);
  player setclientomnvar("ui_cp_relic_squad_link", 0);
}

relic_squadlink_vision_debuff(player) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("squadlink_stepped_too_close");
  player endon("death");
  player endon("last_stand");
  player thread relic_squadlink_watch_for_visionset_end(player);
  player thread relic_squadlink_add_visionset(player);
}

relic_squadlink_watch_for_visionset_end(player) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("squadlink_stepped_too_close");
  player scripts\engine\utility::waittill_any_2("death", "last_stand");
  player relic_squadlink_remove_visionset(player);
}

relic_squadlink_add_visionset(player) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("squadlink_stepped_too_close");
  player visionsetnakedforplayer("nuke_deathblur", 0);
  player allowsupersprint(0);
  wait 5;
  playfxontagforclients(level._effect["vfx_squadlink_tunnelvision"], player, "tag_origin", player);
}

relic_squadlink_remove_visionset(player) {
  player visionsetnakedforplayer("", 0);
  player allowsupersprint(1);
  stopFXOnTag(level._effect["vfx_squadlink_tunnelvision"], player, "tag_origin");
}

relic_squadlink_toofar_hud_logic(player) {
  level endon("game_ended");
  player endon("death");
  player endon("disconnect");
  player endon("squadlink_stepped_too_close");

  for(;;) {
    time = 3;
    player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_BR_SYRK_OBJECTIVES/RELIC_SQUADLINK_FAR", time - 1);
    player thread relic_squadlink_flash_squadlink_icon(player, time - 1, "squadlink_stepped_too_close", 1);
    player playlocalsound("cp_computer_fail");
    wait(time);
  }
}

init_relic_squadlink(player) {}

set_relic_squadlink(player) {
  player.ondamagerelics["relic_squadlink"] = 1;
  player.ondamagepredamagemodrelics["relic_squadlink"] = 1;
  player setclientomnvar("ui_cp_relic_squad_link", 0);

  if(!isDefined(player.squadlink_wid)) {
    _id_FA927B0338099D9F = scripts\cp\cp_objectives::requestworldid(player.name + "_squadlinkWID");
    player.squadlink_wid = _id_FA927B0338099D9F;
    objective_setplayintro(_id_FA927B0338099D9F, 0);
    objective_setplayoutro(_id_FA927B0338099D9F, 0);
    objective_state(_id_FA927B0338099D9F, "current");
    objective_icon(_id_FA927B0338099D9F, "icon_waypoint_objective_general");
    objective_setbackground(_id_FA927B0338099D9F, 1);
    objective_setshowoncompass(_id_FA927B0338099D9F, 1);
    objective_onentity(_id_FA927B0338099D9F, player);
    objective_setzoffset(_id_FA927B0338099D9F, 70);
    objective_setshowdistance(_id_FA927B0338099D9F, 1);
    objective_addalltomask(_id_FA927B0338099D9F);
    objective_hidefromplayersinmask(_id_FA927B0338099D9F);
  }
}

unset_relic_squadlink(player) {
  player.ondamagerelics["relic_squadlink"] = 0;
  player.ondamagepredamagemodrelics["relic_squadlink"] = 0;
  player setclientomnvar("ui_cp_relic_squad_link", 0);

  if(isDefined(player.squadlink_wid)) {
    objective_delete(player.squadlink_wid);
    player.squadlink_wid = scripts\cp\cp_objectives::freeworldid(player.name + "_squadlinkWID");
    player.squadlink_wid = undefined;
  }
}

ondamagerelicsquadlink(eattacker, sweapon, _id_E851FFA44B7E0D54, smeansofdeath, shitloc, timeoffset) {
  return;
}

relic_squadlink_modifyplayerdamage(victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc) {
  damage_multiplier = 1;

  if(isDefined(eattacker) && isPlayer(eattacker)) {
    if(!istrue(eattacker.is_far_from_team))
      damage_multiplier = 4;
  } else if(isDefined(victim) && isPlayer(victim)) {
    if(!istrue(victim.is_far_from_team))
      damage_multiplier = 0.1;
  }

  return int(idamage * damage_multiplier);
}

relic_squadlink_outline_monitor(ai) {
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

relic_squadlink_turn_team_headobjectives(player, _id_41D8BF229CF29051) {
  _id_CEB1FF9428033CFD = scripts\cp\utility::getplayersinteam(player.team);
  _id_CEB1FF9428033CFD = scripts\engine\utility::array_remove(_id_CEB1FF9428033CFD, player);

  if(_id_CEB1FF9428033CFD.size <= 0) {
    return;
  }
  foreach(_id_F0EA4030349A33D5 in _id_CEB1FF9428033CFD) {
    if(isDefined(_id_F0EA4030349A33D5.squadlink_wid)) {
      if(istrue(_id_41D8BF229CF29051)) {
        objective_removeclientfrommask(_id_F0EA4030349A33D5.squadlink_wid, player);
        objective_hidefromplayersinmask(_id_F0EA4030349A33D5.squadlink_wid);
        continue;
      }

      objective_addclienttomask(_id_F0EA4030349A33D5.squadlink_wid, player);
      objective_hidefromplayersinmask(_id_F0EA4030349A33D5.squadlink_wid);
    }
  }
}

global_relic_landlocked_func() {
  scripts\cp\utility\cp_controlled_callbacks::registercontrolledcallback("Earthquake", ::earthquake, 5, ::allow_earthquake, 0, 0, 0, 1, 1);
}

init_relic_landlocked(player) {}

set_relic_landlocked(player) {
  player.persistentrelics["relic_landlocked"] = 1;
}

unset_relic_landlocked(player) {
  player.persistentrelics["relic_landlocked"] = 0;
}

handlepersistentlandlocked(player, sweapon, victim) {}

relic_landlocked_do_explosion(player) {
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

  if(player tagexists("j_head"))
    vpoint = player gettagorigin("j_head");
  else if(player tagexists("tag_eye"))
    vpoint = player gettagorigin("tag_eye");

  player notify("relic_landlocked_exploded");
  radiusdamage(player.origin + (0, 0, 60), 333, 333, 33, undefined, "MOD_RIFLE_BULLET");
  scripts\cp\utility\cp_controlled_callbacks::runcontrolledcallback("Earthquake", 1.0, 0.6, player.origin, 84);
  playFX(level._effect["headshot_explode"], vpoint);
  player playSound("gib_fullbody");
  playrumbleonposition("grenade_rumble", player.origin);
}

relic_landlocked_clear_message_on_player_return(player) {
  player endon("death");
  player endon("disconnect");
  level endon("game_ended");
  player endon("relic_landlocked_exploded");
  player endon("relic_landlocked_do_explosion");

  while(!isDefined(player.inhackring))
    waitframe();

  player notify("relic_landlocked_returned_safe");
}

init_relic_lfo(player) {}

set_relic_lfo(player) {
  player.ondamagerelics["relic_lfo"] = 1;
  player.sappliedstages = [];
  player thread manage_health_stage_allows();
}

unset_relic_lfo(player) {
  player.ondamagerelics["relic_lfo"] = 0;
}

handlelfo() {
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("LFO_1", ["slide", "sprint", "crouch", "prone", "mantle"]);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("LFO_2", ["slide", "sprint"]);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("LFO_3", ["slide", "sprint"]);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("LFO_4", ["slide", "sprint"]);
}

blank_relic_func(player) {}

set_force_aitype_shotgun(player) {
  if(!isDefined(level.forced_aitypes))
    level.forced_aitypes = [];

  level.forced_aitypes[level.forced_aitypes.size] = "shotgun";
}

set_force_aitype_sniper(player) {
  if(!isDefined(level.forced_aitypes))
    level.forced_aitypes = [];

  level.forced_aitypes[level.forced_aitypes.size] = "sniper";
}

set_force_aitype_riotshield(player) {
  if(!isDefined(level.forced_aitypes))
    level.forced_aitypes = [];

  level.forced_aitypes[level.forced_aitypes.size] = "riotshield";
}

set_force_aitype_suicidebomber(player) {
  if(!isDefined(level.forced_aitypes))
    level.forced_aitypes = [];

  level.forced_aitypes[level.forced_aitypes.size] = "suicidebomber";
}

set_force_aitype_rpg(player) {
  if(!isDefined(level.forced_aitypes))
    level.forced_aitypes = [];

  level.forced_aitypes[level.forced_aitypes.size] = "rpg";
}

unset_force_aitype_rpg(player) {
  if(isDefined(level.forced_aitypes) && scripts\engine\utility::array_contains(level.forced_aitypes, "rpg")) {
    level.forced_aitypes = scripts\engine\utility::array_remove(level.forced_aitypes, "rpg");

    if(level.forced_aitypes.size < 1)
      unset_forced_aitype();
  }
}

unset_force_aitype_shotgun(player) {
  if(isDefined(level.forced_aitypes) && scripts\engine\utility::array_contains(level.forced_aitypes, "shotgun")) {
    level.forced_aitypes = scripts\engine\utility::array_remove(level.forced_aitypes, "shotgun");

    if(level.forced_aitypes.size < 1)
      unset_forced_aitype();
  }
}

unset_force_aitype_sniper(player) {
  if(isDefined(level.forced_aitypes) && scripts\engine\utility::array_contains(level.forced_aitypes, "sniper")) {
    level.forced_aitypes = scripts\engine\utility::array_remove(level.forced_aitypes, "sniper");

    if(level.forced_aitypes.size < 1)
      unset_forced_aitype();
  }
}

unset_force_aitype_riotshield(player) {
  if(isDefined(level.forced_aitypes) && scripts\engine\utility::array_contains(level.forced_aitypes, "riotshield")) {
    level.forced_aitypes = scripts\engine\utility::array_remove(level.forced_aitypes, "riotshield");

    if(level.forced_aitypes.size < 1)
      unset_forced_aitype();
  }
}

unset_force_aitype_suicidebomber(player) {
  if(isDefined(level.forced_aitypes) && scripts\engine\utility::array_contains(level.forced_aitypes, "suicidebomber")) {
    level.forced_aitypes = scripts\engine\utility::array_remove(level.forced_aitypes, "suicidebomber");

    if(level.forced_aitypes.size < 1)
      unset_forced_aitype();
  }
}

unset_forced_aitype(player) {
  level.forced_aitypes = undefined;
}

set_force_aitype_armored(player) {
  level.forced_aitype_armored = 1;
  _id_18A73A64992DD07D::add_global_spawn_function("axis", ::_id_FA6EA7F830D64C9C);
}

unset_forced_aitype_armored(player) {
  level.forced_aitype_armored = undefined;
  _id_18A73A64992DD07D::remove_global_spawn_function("axis", ::_id_FA6EA7F830D64C9C);
}

_id_FA6EA7F830D64C9C() {
  if(_id_18A73A64992DD07D::is_juggernaut_aitype()) {
    return;
  }
  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  self attach("head_sp_opforce_al_qatala_tier_3_1", "", 1);
  self.headmodel = "head_sp_opforce_al_qatala_tier_3_1";
  _id_371B4C2AB5861E62::_id_DC01699146E5F9A2(self);
}

set_just_keep_moving(player) {
  player.persistentrelics["relic_just_keep_moving"] = 1;
  player.relic_disable_health_regen = 0;
}

unset_just_keep_moving(player) {
  player.persistentrelics["relic_just_keep_moving"] = 0;
  player.relic_disable_health_regen = undefined;
}

handle_just_keep_moving(player, sweapon, _id_97282C14346A7FCF) {
  level endon("game_ended");
  player endon("disconnect");

  for(;;) {
    if(!isDefined(player.velo_forward)) {
      wait 0.1;
      continue;
    }

    _id_DD6FBB1FF2A513C9 = player.velo_forward - player.origin;
    _id_DD6FBB1FF2A513C9 = (_id_DD6FBB1FF2A513C9[0], _id_DD6FBB1FF2A513C9[1], 0);
    _id_13B97A8DA9DFEA88 = length(_id_DD6FBB1FF2A513C9);

    if(_id_13B97A8DA9DFEA88 > 0)
      player.relic_disable_health_regen = 0;
    else if(isDefined(self.velo_forward_memory) && self.velo_forward_memory.size < 3)
      player.relic_disable_health_regen = 1;

    wait 0.25;
  }
}

manage_health_stage_allows() {
  self endon("disconnect");

  for(;;) {
    waitframe();

    if(_id_0AFB7E332AEE4BF2::player_in_laststand(self)) {
      continue;
    }
    _id_8174307463B4E86F = get_health_stage(self);

    foreach(stage in self.sappliedstages) {
      if(stage == _id_8174307463B4E86F)
        continue;
    }

    switch (_id_8174307463B4E86F) {
      case 2:
      case 1:
        if(scripts\engine\utility::array_contains(self.sappliedstages, _id_8174307463B4E86F)) {
          break;
        }

        self.sappliedstages = scripts\engine\utility::array_add(self.sappliedstages, _id_8174307463B4E86F);
        _id_3B64EB40368C1450::_id_3633B947164BE4F3("LFO_" + _id_8174307463B4E86F, 0);
        break;
      case 4:
      case 3:
        foreach(stage in self.sappliedstages) {
          _id_3B64EB40368C1450::_id_3633B947164BE4F3("LFO_" + stage, 1);
          self.sappliedstages = scripts\engine\utility::array_remove(self.sappliedstages, stage);
        }

        break;
      default:
        break;
    }
  }
}

ondamagereliclfo(eattacker, sweapon, _id_E851FFA44B7E0D54, smeansofdeath, shitloc, timeoffset) {
  if(!isPlayer(_id_E851FFA44B7E0D54)) {
    return;
  }
  player = _id_E851FFA44B7E0D54;

  if(_id_0AFB7E332AEE4BF2::player_in_laststand(player)) {
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
      break;
  }
}

ondamagerelicfromabove(eattacker, sweapon, _id_E851FFA44B7E0D54, smeansofdeath, shitloc, timeoffset) {}

get_health_stage(player) {
  _id_9E6EE1F61A6E0CBF = player.health / player.maxhealth;

  if(_id_9E6EE1F61A6E0CBF <= 0.33)
    return 1;
  else if(_id_9E6EE1F61A6E0CBF <= 0.66)
    return 2;
  else if(_id_9E6EE1F61A6E0CBF <= 1.0)
    return 3;
  else
    return 4;
}

init_relic_noks(player) {}

set_relic_noks(player) {}

unset_relic_noks(player) {}

handlenokillstreaks() {
  level.disable_map_munitions = 1;
  level.disable_loot_drop = 1;
  wait 10;
  _id_644C18834356D9DC::remove_munitions_globally();
}

init_relic_no_ammo_mun(player) {}

set_relic_no_ammo_mun(player) {
  player.no_enemy_weapon_drops = 1;
}

unset_relic_no_ammo_mun(player) {
  player.no_enemy_weapon_drops = undefined;
}

handle_no_ammo_mun() {
  level.disable_map_ammo_munitions = 1;
  wait 10;
  _id_644C18834356D9DC::remove_munitions_globally(["brloot_munition_ammo"]);
}

handlemythic() {
  _id_18A73A64992DD07D::add_global_spawn_function("axis", ::increase_hp_from_relic_mythic);

  if(!scripts\engine\utility::array_contains(level.modifyplayerdamage_relics, ::relic_mythic_modifyplayerdamage))
    level.modifyplayerdamage_relics = scripts\engine\utility::array_add(level.modifyplayerdamage_relics, ::relic_mythic_modifyplayerdamage);
}

relic_mythic_modifyplayerdamage(victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc) {
  process_should_do_pain(victim, eattacker, objweapon, shitloc, smeansofdeath);

  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_MELEE")
    return int(idamage * get_health_multiplier_relic_mythic());
  else
    return int(idamage);
}

process_should_do_pain(victim, eattacker, objweapon, shitloc, smeansofdeath) {
  if(isDefined(victim) && isPlayer(victim)) {
    return;
  }
  if(relic_mythic_should_bypass_pain_cooldown(objweapon)) {
    victim.relic_mythic_do_pain = 1;
    return;
  }

  _id_A3192D2F80ED4FF8 = scripts\engine\utility::isbulletdamage(smeansofdeath) || smeansofdeath == "MOD_EXPLOSIVE_BULLET" && shitloc != "none";
  headshot = _id_A3192D2F80ED4FF8 && scripts\cp\utility::isheadshot(objweapon, shitloc, smeansofdeath, eattacker);

  if(relic_mythic_should_do_pain(headshot, smeansofdeath)) {
    if(relic_mythic_can_do_pain(victim)) {
      victim.relic_mythic_do_pain = 1;
      return;
    }
  }
}

relic_mythic_can_do_pain(victim) {
  current_time = gettime();
  return current_time >= victim.relic_mythic_next_pain_time;
}

relic_mythic_should_do_pain(headshot, smeansofdeath) {
  if(istrue(headshot))
    return 1;

  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_MELEE")
    return 1;

  return 0;
}

relic_mythic_should_bypass_pain_cooldown(objweapon) {
  if(_id_6F1E07CE9FF97D5F::is_flashbang(objweapon.basename, objweapon, undefined))
    return 1;

  return 0;
}

increase_hp_from_relic_mythic() {
  _id_D36DB0E7D81F7AAA = self.maxhealth;
  _id_DC1E9E3C14D1E00B = get_health_multiplier_relic_mythic();
  _id_6D5B2972D828222F = _id_D36DB0E7D81F7AAA * _id_DC1E9E3C14D1E00B;
  self.relic_mythic_next_pain_time = gettime();
  self.fnshouldplaypainanim = ::relic_mythic_should_ai_play_pain;
}

relic_mythic_should_ai_play_pain() {
  if(istrue(self.relic_mythic_do_pain)) {
    self.relic_mythic_next_pain_time = gettime() + 2000;
    self.relic_mythic_do_pain = 0;
    return 1;
  } else
    return 0;
}

get_health_multiplier_relic_mythic() {
  if(getdvarint("dvar_C142FFCAF16B9A8A", 0) != 0)
    return int(getdvarint("dvar_C142FFCAF16B9A8A", 0));
  else
    return 10;
}

init_relic_mythic(player) {}

set_relic_mythic(player) {}

unset_relic_mythic(player) {
  if(scripts\engine\utility::array_contains(level.modifyplayerdamage_relics, ::relic_mythic_modifyplayerdamage))
    level.modifyplayerdamage_relics = scripts\engine\utility::array_remove(level.modifyplayerdamage_relics, ::relic_mythic_modifyplayerdamage);
}

handlefocusfire() {
  _id_18A73A64992DD07D::add_global_spawn_function("axis", ::set_focus_fire_params);

  if(!scripts\engine\utility::array_contains(level.modifyplayerdamage_relics, ::relic_focusfire_modifyplayerdamage))
    level.modifyplayerdamage_relics = scripts\engine\utility::array_add(level.modifyplayerdamage_relics, ::relic_focusfire_modifyplayerdamage);
}

set_focus_fire_params() {
  self.focus_fire_attackers = [];
}

is_player_in_focus_fire_attacker_list(_id_55BED569A266A992, ai) {
  return scripts\engine\utility::array_contains(ai.focus_fire_attackers, _id_55BED569A266A992);
}

add_player_to_focus_fire_attacker_list(_id_55BED569A266A992, ai) {
  ai.focus_fire_attackers = scripts\engine\utility::array_add(ai.focus_fire_attackers, _id_55BED569A266A992);
  update_focus_fire_heahicon(ai);

  if(focus_fire_outline_enabled()) {
    if(ai.focus_fire_attackers.size == 1)
      ai.focus_fire_outline_id = scripts\cp\cp_outline_utility::outlineenableforall(ai, "snapshotgrenade_longfade", "killstreak_personal");
  }
}

remove_player_from_focus_fire_attacker_list(_id_55BED569A266A992, ai) {
  ai.focus_fire_attackers = scripts\engine\utility::array_remove(ai.focus_fire_attackers, _id_55BED569A266A992);
  update_focus_fire_heahicon(ai);

  if(focus_fire_outline_enabled()) {
    if(has_no_focus_fire_attackers(ai)) {
      if(isDefined(ai.focus_fire_outline_id))
        scripts\cp\cp_outline_utility::outlinedisable(ai.focus_fire_outline_id, ai);
    }
  }
}

focus_fire_outline_enabled() {
  if(getdvarint("dvar_10558E252CEE3EBC", 0) != 0)
    return 1;

  return 0;
}

get_focus_fire_damage_multiplier(ai) {
  if(!focus_fire_is_activated(ai))
    return 1;
  else {
    _id_220DDF23D0E7C455 = get_base_focus_fire_multipler(ai);
    _id_B4B554E3519D26D6 = get_extra_focus_fire_multipler(ai);
    _id_D6F8EEBD4E7C2B80 = _id_220DDF23D0E7C455 + _id_B4B554E3519D26D6;
    return _id_D6F8EEBD4E7C2B80;
  }
}

get_extra_focus_fire_multipler(ai) {
  _id_ECE82887F0275A7E = 0;
  return _id_ECE82887F0275A7E * ai.focus_fire_attackers.size;
}

get_base_focus_fire_multipler(ai) {
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

focus_fire_attacker_timeout(player, _id_55BED569A266A992, ai) {
  ai endon("death");
  ai notify("focus_fire_attacker_" + _id_55BED569A266A992);
  ai endon("focus_fire_attacker_" + _id_55BED569A266A992);
  scripts\engine\utility::waittill_any_ents_or_timeout_return(4.5, player, "disconnect");
  remove_player_from_focus_fire_attacker_list(_id_55BED569A266A992, ai);
}

focus_fire_is_activated(ai) {
  return isDefined(ai.focus_fire_attackers);
}

update_focus_fire_objective(ai) {
  if(!should_show_icon()) {
    return;
  }
  if(has_no_focus_fire_attackers(ai))
    ai notify("delete_focus_fire_icon");
  else if(!has_focus_fire_objective(ai))
    make_focus_fire_objective(ai);
  else
    objective_icon(ai.focus_fire_icon_objective_id, get_focus_fire_icon_image(ai));
}

make_focus_fire_objective(ai) {
  _id_F4ECC554DAF3C4B8 = make_focus_fire_icon_anchor(ai);
  _id_F5737839F388C9E9 = ai getentitynumber();
  focus_fire_icon_objective_id = scripts\cp\cp_objectives::requestworldid("enemy_AI_focus_fire_ID_" + _id_F5737839F388C9E9, 22);
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
  objective_onentity(focus_fire_icon_objective_id, _id_F4ECC554DAF3C4B8);
  ai.focus_fire_icon_objective_id = focus_fire_icon_objective_id;
  _id_F4ECC554DAF3C4B8 thread focus_fire_icon_delete_think(_id_F4ECC554DAF3C4B8, ai, _id_F5737839F388C9E9, focus_fire_icon_objective_id);
}

focus_fire_icon_delete_think(_id_F4ECC554DAF3C4B8, ai, _id_F5737839F388C9E9, focus_fire_icon_objective_id) {
  _id_F4ECC554DAF3C4B8 endon("death");
  ai scripts\engine\utility::waittill_any_2("delete_focus_fire_icon", "death");
  scripts\cp\cp_objectives::freeworldid("enemy_AI_focus_fire_ID_" + _id_F5737839F388C9E9);
  objective_delete(focus_fire_icon_objective_id);
  ai.focus_fire_icon_objective_id = undefined;
  _id_F4ECC554DAF3C4B8 delete();
}

make_focus_fire_icon_anchor(ai) {
  _id_6DBD8E53A8E4F546 = (0, 0, 15);
  _id_76317715420E47C7 = (23, 8, 0);
  _id_71204963CE04088B = "j_neck";
  _id_441884BCC07443F1 = ai gettagorigin(_id_71204963CE04088B);
  _id_F4ECC554DAF3C4B8 = spawn("script_model", _id_441884BCC07443F1 + _id_6DBD8E53A8E4F546);
  _id_F4ECC554DAF3C4B8 setModel("tag_origin");
  _id_F4ECC554DAF3C4B8 linkTo(ai, _id_71204963CE04088B, _id_76317715420E47C7, (0, 0, 0));
  return _id_F4ECC554DAF3C4B8;
}

has_focus_fire_objective(ai) {
  return isDefined(ai.focus_fire_icon_objective_id);
}

update_focus_fire_heahicon(ai) {
  if(!should_show_icon()) {
    return;
  }
  if(has_no_focus_fire_attackers(ai)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(ai.focus_fire_headicon);
    ai.focus_fire_headicon = undefined;
  } else if(!has_focus_fire_headicon(ai))
    make_focus_fire_headicon(ai);
  else
    setheadiconimage(ai.focus_fire_headicon, get_focus_fire_icon_image(ai));
}

should_show_icon() {
  if(getdvarint("dvar_10A66E3DDCD7DE56", 0) != 0)
    return 0;

  return 1;
}

has_no_focus_fire_attackers(ai) {
  return ai.focus_fire_attackers.size == 0;
}

has_focus_fire_headicon(ai) {
  return isDefined(ai.focus_fire_headicon);
}

make_focus_fire_headicon(ai) {
  _id_FC21E35C84088F9E = get_focus_fire_icon_image(ai);
  ai.focus_fire_headicon = ai scripts\cp_mp\entityheadicons::setheadicon_singleimage("allies", _id_FC21E35C84088F9E, 10, 1, undefined, undefined, undefined, 0, 1);
}

get_focus_fire_icon_image(ai) {
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

ondamagerelicfocusfire(eattacker, sweapon, _id_E851FFA44B7E0D54, smeansofdeath, shitloc, timeoffset) {
  return;
}

ondamagepredamagemodrelicfocusfire(eattacker, sweapon, _id_E851FFA44B7E0D54, smeansofdeath, shitloc, timeoffset) {
  if(isDefined(_id_E851FFA44B7E0D54) && isPlayer(_id_E851FFA44B7E0D54)) {
    return;
  }
  if(isDefined(eattacker.owner) && isPlayer(eattacker.owner))
    eattacker = eattacker.owner;

  if(!(isDefined(eattacker) && isPlayer(eattacker))) {
    return;
  }
  _id_55BED569A266A992 = eattacker getentitynumber();

  if(!is_player_in_focus_fire_attacker_list(_id_55BED569A266A992, _id_E851FFA44B7E0D54))
    add_player_to_focus_fire_attacker_list(_id_55BED569A266A992, _id_E851FFA44B7E0D54);

  _id_E851FFA44B7E0D54 thread focus_fire_attacker_timeout(eattacker, _id_55BED569A266A992, _id_E851FFA44B7E0D54);
}

relic_focusfire_modifyplayerdamage(victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc) {
  _id_D8C170EF92755062 = get_focus_fire_damage_multiplier(victim);
  return int(idamage * _id_D8C170EF92755062);
}

init_relic_focus_fire(player) {}

set_relic_focus_fire(player) {
  player.ondamagerelics["relic_focus_fire"] = 1;
  player.ondamagepredamagemodrelics["relic_focus_fire"] = 1;
}

unset_relic_focus_fire(player) {
  player.ondamagerelics["relic_focus_fire"] = 0;
  player.ondamagepredamagemodrelics["relic_focus_fire"] = 0;

  if(scripts\engine\utility::array_contains(level.modifyplayerdamage_relics, ::relic_focusfire_modifyplayerdamage))
    level.modifyplayerdamage_relics = scripts\engine\utility::array_remove(level.modifyplayerdamage_relics, ::relic_focusfire_modifyplayerdamage);
}

init_relic_gas_martyr(player) {}

set_relic_gas_martyr(player) {
  player.onkillrelics["relic_gas_martyr"] = 1;
}

unset_relic_gas_martyr(player) {
  player.onkillrelics["relic_gas_martyr"] = 0;
}

handlerelicmartyrdomgas(sweapon, player, victim, smeansofdeath, shitloc, time) {
  handlerelicmartyrdom_common(sweapon, player, victim, smeansofdeath, shitloc, time, ::get_gas_martyr_grenade_types);
}

get_gas_martyr_grenade_types() {
  return ["gas_grenade_mp"];
}

init_relic_martyrdom(player) {}

set_relic_martyrdom(player) {
  player.onkillrelics["relic_martyrdom"] = 1;
}

unset_relic_martyrdom(player) {
  player.onkillrelics["relic_martyrdom"] = 0;
}

handlerelicmartyrdomfrag(sweapon, player, victim, smeansofdeath, shitloc, time) {
  handlerelicmartyrdom_common(sweapon, player, victim, smeansofdeath, shitloc, time, ::get_martyrdom_grenade_types);
}

handlerelicmartyrdom_common(sweapon, player, victim, smeansofdeath, shitloc, time, _id_342004C21E418DB6) {
  _id_C9E05AEB1EC982C9 = 147456;
  _id_300D2C8BDE1599A8 = "j_spine4";

  if(isDefined(victim.unittype) && victim.unittype == "suicidebomber") {
    return;
  }
  _id_9281F4D9E2F7F340 = 15;
  _id_574BD21B0CAFDAC9 = anglesToForward(victim.angles);
  _id_5D825B291EEF6A58 = victim gettagorigin(_id_300D2C8BDE1599A8) + _id_574BD21B0CAFDAC9 * _id_9281F4D9E2F7F340;
  grenade_types = [[_id_342004C21E418DB6]]();
  _id_768BCB94D2499F3D = victim;
  _id_A664AAD02EE98BD2 = scripts\engine\utility::random(grenade_types);
  grenade = _id_768BCB94D2499F3D launchgrenade(_id_A664AAD02EE98BD2, _id_5D825B291EEF6A58, _id_574BD21B0CAFDAC9 * get_grenade_force(_id_A664AAD02EE98BD2), get_grenade_fuse_time(_id_A664AAD02EE98BD2));

  if(_id_A664AAD02EE98BD2 == "concussion_grenade_mp")
    grenade.owner = victim;
  else {
    grenade.owner = spawnStruct();
    grenade.owner.team = "axis";
  }

  grenade.team = "neutral";

  switch (_id_A664AAD02EE98BD2) {
    case "frag_grenade_mp":
      level thread do_manual_splash_damage_when_frag_explodes(grenade, player);
      break;
    case "molotov_mp":
      level thread scripts\cp\powers\coop_molotov::ai_molotov_used(_id_768BCB94D2499F3D, grenade);
      break;
    case "gas_grenade_mp":
      _id_768BCB94D2499F3D thread scripts\cp\equipment\cp_gas_grenade::gas_watchexplode(grenade);
      break;
    case "concussion_grenade_mp":
      grenade thread _id_74502A9E0EF1F19C::watchconcussiongrenadeexplode();
      break;
  }
}

do_manual_splash_damage_when_frag_explodes(grenade, player) {
  grenade endon("trigger");
  grenade waittill("explode", origin);
  _id_FC9AC45209F959BB = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  if(_id_FC9AC45209F959BB.size > 0)
    radiusdamage(origin, 256, 140, 70, player, "MOD_GRENADE_SPLASH", makeweapon("frag_grenade_mp"));
  else
    radiusdamage(origin, 256, 140, 70, player, "MOD_GRENADE_SPLASH", makeweapon("frag_grenade_mp"));
}

get_martyrdom_grenade_types() {
  _id_63C9B3BF5E31443F = ["frag_grenade_mp"];
  _id_85B74463AF15B0BB = getDvar("martyrdom_grenade_types", "");

  if(_id_85B74463AF15B0BB != "")
    return generate_grenade_types_via_dvar(_id_85B74463AF15B0BB);
  else
    return _id_63C9B3BF5E31443F;
}

generate_grenade_types_via_dvar(_id_85B74463AF15B0BB) {
  _id_336E790F2C0DEE77 = strtok(_id_85B74463AF15B0BB, ",");
  result = [];

  foreach(_id_ECD569E8FCAC5F2A in _id_336E790F2C0DEE77)
  result = scripts\engine\utility::array_add(result, get_actual_grenade_name(_id_ECD569E8FCAC5F2A));

  return result;
}

get_actual_grenade_name(_id_ECD569E8FCAC5F2A) {
  switch (_id_ECD569E8FCAC5F2A) {
    case "frag":
      return "frag_grenade_mp";
    case "gas":
      return "gas_mp";
    case "molotov":
      return "molotov_mp";
    case "concussion":
      return "concussion_grenade_mp";
    default:
  }
}

get_grenade_force(_id_A664AAD02EE98BD2) {
  switch (_id_A664AAD02EE98BD2) {
    case "frag_grenade_mp":
      return 40;
    case "gas_mp":
      return 400;
    case "molotov_mp":
      return 400;
    case "concussion_grenade_mp":
      return 120;
    default:
      return 100;
  }
}

get_grenade_fuse_time(_id_A664AAD02EE98BD2) {
  switch (_id_A664AAD02EE98BD2) {
    case "frag_grenade_mp":
      return 1.5;
    case "flash_grenade_mp":
      return 1.0;
    default:
      return 1.5;
  }
}

init_relic_gun_game(player) {
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_16C27BD9C165F4D6", 1, 0);
  level._id_317452953C148027 = undefined;

  if(!isDefined(level._id_72BEADE6989B19B8))
    level._id_72BEADE6989B19B8 = getdvarint(_func_2EF675C13CA1C4AF("dvar_95615AC316FC8872"), 30);

  if(!istrue(level._id_3978BF00ED49711D)) {
    level._id_3978BF00ED49711D = 1;
    level.ladderindex = getdvarint(_func_2EF675C13CA1C4AF("ladderindex"), 2);
    setgunladder();
    setgunsfinal();
  }
}

set_relic_gun_game(player) {
  player.persistentrelics["relic_gun_game"] = 1;
  player.gungamegunindex = 0;
  player.gungameprevgunindex = 0;
  player loadweaponsforplayer(level._id_1A70639BF6482BC2, 1);
  scripts\cp\utility::_id_C0D2C91F2688ECE4(0);
  scripts\engine\utility::flag_wait("both_players_intro_binks_complete");

  if(istrue(level._id_EFE609BCE901CAA8) && !scripts\engine\utility::flag("infil_over"))
    scripts\engine\utility::flag_wait("infil_over");

  player thread player_gun_game_randomize_weapon_list_think(player);
  player thread player_gun_game_next_weapon_think(player);
  player _id_5D137D3132A633ED("kill");
  player thread refillammo();
  player thread refillsinglecountammo();
}

refillammo() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("unset_gun_game");

  for(;;) {
    self waittill("reload");

    if(!isDefined(self.primaryweapon))
      self.primaryweapon = self getcurrentweapon();

    _id_8A2ECC3A9D4C95DF = weaponstartammo(self.primaryweapon);
    clipammo = weaponclipsize(self.primaryweapon);
    stockammo = _id_8A2ECC3A9D4C95DF - clipammo;
    self setweaponammostock(self.primaryweapon, stockammo);
  }
}

refillsinglecountammo() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("unset_gun_game");

  for(;;) {
    if(scripts\cp\utility\player::isreallyalive(self) && self.team != "spectator" && isDefined(self.primaryweapon) && self getammocount(self.primaryweapon) == 0) {
      wait 2;
      self notify("reload");
      wait 1;
      continue;
    }

    waitframe();
  }
}

_id_614DE4F5A6A2452F(itemtype, _id_3793828403C6873E) {
  if(itemtype == 1) {
    if(_id_30D732F612695BA8() || is_relic_active("relic_oneInTheChamber")) {
      thread scripts\cp\cp_hud_message::showerrormessage("MP/CANNOT_USE_GENERIC");
      return 0;
    }

    if(is_relic_active("relic_oneInTheChamber")) {
      thread scripts\cp\cp_hud_message::showerrormessage("MP/CANNOT_USE_GENERIC");
      return 0;
    }
  }

  return 1;
}

setgunladder() {
  level.gun_guns = [];
  level.selectedweapons = [];
  level._id_71AFB87754F28AF8 = ::_id_614DE4F5A6A2452F;
  _id_2E08463451CF36EC();

  switch (level.ladderindex) {
    case 6:
    case 5:
    case 4:
    case 1:
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

getggweapontablelootvariants(_id_C27E2A04BAB78C1F) {
  _id_C0AA7602B6BBC954 = [];
  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(_id_C27E2A04BAB78C1F);
  _id_C0AA7602B6BBC954 = tablelookup("mp/gunGameWeapons.csv", 1, _id_AB501F397D3CD312, 6);
  return _id_C0AA7602B6BBC954;
}

setgunsfinal() {
  level.selectedweapons = [];
  _id_6B7AFEFDBEEEEC0A();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.gun_guns.size; _id_AC0E594AC96AA3A8++) {
    _id_B3BF8105D61A60E1 = level.gun_guns[_id_AC0E594AC96AA3A8];

    if(scripts\engine\utility::string_starts_with(_id_B3BF8105D61A60E1, "rand_")) {
      _id_BAE77D8848F4D84D = _id_05F97F15E9CA6CB6(_id_B3BF8105D61A60E1);

      if(isstring(_id_BAE77D8848F4D84D) && _id_BAE77D8848F4D84D == "none") {
        continue;
      }
      if(level.ladderindex == 4 || level.ladderindex == 5)
        level.gun_guns[_id_AC0E594AC96AA3A8] = _id_2669878CF5A1B6BC::buildweapon_blueprint(_id_BAE77D8848F4D84D["weapon"], undefined, undefined, _id_BAE77D8848F4D84D["variantID"], undefined, undefined, scripts\cp_mp\utility\game_utility::_id_D2D2B803A7B741A4());
      else
        level.gun_guns[_id_AC0E594AC96AA3A8] = _id_96D23570114BC7B6(_id_BAE77D8848F4D84D);

      continue;
    }

    _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(level.gun_guns[_id_AC0E594AC96AA3A8]);
    level.selectedweapons[_id_AB501F397D3CD312] = 1;
    _id_DD515FCF025B2E79 = _id_AB501F397D3CD312;
    _id_C8616C37BC30098B = 0;

    if(level.ladderindex == 4 || level.ladderindex == 5) {
      _id_9D519609E4FFDAA3 = getggweapontablelootvariants(_id_AB501F397D3CD312);
      variantid = table_parseweaponvariantidvalue(_id_AB501F397D3CD312, _id_9D519609E4FFDAA3);
      _id_DD515FCF025B2E79 = _id_2669878CF5A1B6BC::buildweapon_blueprint(_id_AB501F397D3CD312, undefined, undefined, variantid, undefined, undefined, scripts\cp_mp\utility\game_utility::isnightmap());
    } else {
      variantid = 0;

      if(level.ladderindex == 6) {
        _id_9D519609E4FFDAA3 = getggweapontablelootvariants(_id_AB501F397D3CD312);
        variantid = table_parseweaponvariantidvalue(_id_AB501F397D3CD312, _id_9D519609E4FFDAA3);
      }

      _id_DD515FCF025B2E79 = gun_createrandomweapon(_id_AB501F397D3CD312, _id_C8616C37BC30098B, variantid, scripts\cp_mp\utility\game_utility::isnightmap());
    }

    level.gun_guns[_id_AC0E594AC96AA3A8] = _id_DD515FCF025B2E79;
  }

  level.selectedweapons = undefined;
}

table_parseweaponvariantidvalue(rootweapon, value) {
  if(rootweapon == "none")
    return 0;

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
    _id_A6F6C01484BD5665 = getDvar("dvar_4CAA11CAEEBF587B", "");

    if(_id_A6F6C01484BD5665 != "") {
      _id_9C58C4F8ACC9CF26 = strtok(_id_A6F6C01484BD5665, ",");

      foreach(_id_9DA910194DABEABE in _id_9C58C4F8ACC9CF26) {
        _id_CBF22C9EDB76E72D = strtok(_id_9DA910194DABEABE, "|");

        if(_id_CBF22C9EDB76E72D.size == 2) {
          _id_34B5CB87E576C08A = _id_CBF22C9EDB76E72D[0];
          _id_D37AB34E1F353F3D = int(_id_CBF22C9EDB76E72D[1]);

          if(!isDefined(level.blockedvariantidsmap[_id_34B5CB87E576C08A]))
            level.blockedvariantidsmap[_id_34B5CB87E576C08A] = [];

          level.blockedvariantidsmap[_id_34B5CB87E576C08A][level.blockedvariantidsmap[_id_34B5CB87E576C08A].size] = _id_D37AB34E1F353F3D;
        }
      }
    }
  }

  _id_60EE6A5BAE11A91B = undefined;

  if(isDefined(level.blockedvariantidsmap[rootweapon]))
    _id_60EE6A5BAE11A91B = level.blockedvariantidsmap[rootweapon];

  variantid = 0;
  _id_B3A4D54288759D77 = getdvarint("dvar_C895AE760D4177D4", 0);

  if(_id_B3A4D54288759D77 == 1)
    variantid = _id_74502A9E0EF1F19C::getweaponrandomvariantid(rootweapon, _id_60EE6A5BAE11A91B);
  else {
    _id_2891E3DF80A13684 = strtok(value, " ");
    _id_C0AA7602B6BBC954 = [];

    foreach(_id_BE5507030B116D5B in _id_2891E3DF80A13684) {
      _id_FE5E8103F5FAC595 = int(_id_BE5507030B116D5B);

      if(!isDefined(_id_60EE6A5BAE11A91B) || !scripts\engine\utility::array_contains(_id_60EE6A5BAE11A91B, _id_FE5E8103F5FAC595))
        _id_C0AA7602B6BBC954[_id_C0AA7602B6BBC954.size] = _id_FE5E8103F5FAC595;
    }

    if(_id_C0AA7602B6BBC954.size != 0)
      variantid = _id_C0AA7602B6BBC954[randomint(_id_C0AA7602B6BBC954.size)];
  }

  if(variantid == -1)
    variantid = _id_74502A9E0EF1F19C::getweaponrandomvariantid(rootweapon, _id_60EE6A5BAE11A91B);

  _id_3F57E7EDDC8A4779 = _id_74502A9E0EF1F19C::weaponisValid(rootweapon, variantid);

  if(getdvarint("dvar_4F69E011A95E06A9", 0) != 0) {}

  if(!_id_3F57E7EDDC8A4779)
    variantid = 0;

  return variantid;
}

_id_6B7AFEFDBEEEEC0A() {
  level.weaponcategories = [];
  _id_CB89110314447B2F = 0;

  for(;;) {
    _id_22E2935C86B3B88E = tablelookupbyrow("mp/gunGameWeapons.csv", _id_CB89110314447B2F, 0);

    if(_id_22E2935C86B3B88E == "") {
      break;
    }

    if(!isDefined(level.weaponcategories[_id_22E2935C86B3B88E]))
      level.weaponcategories[_id_22E2935C86B3B88E] = [];

    _id_E1FB30830E39F39D = tablelookupbyrow("mp/gunGameWeapons.csv", _id_CB89110314447B2F, 5);

    if(_id_E1FB30830E39F39D == "" || getdvarint(_id_E1FB30830E39F39D, 0) == 1) {
      data = [];
      data["weapon"] = _id_2669878CF5A1B6BC::getweaponrootname(tablelookupbyrow("mp/gunGameWeapons.csv", _id_CB89110314447B2F, 1));
      data["min"] = int(tablelookupbyrow("mp/gunGameWeapons.csv", _id_CB89110314447B2F, 2));
      data["max"] = int(tablelookupbyrow("mp/gunGameWeapons.csv", _id_CB89110314447B2F, 3));
      data["perk"] = tablelookupbyrow("mp/gunGameWeapons.csv", _id_CB89110314447B2F, 4);
      data["allowed"] = int(tablelookupbyrow("mp/gunGameWeapons.csv", _id_CB89110314447B2F, 7));

      if((level.ladderindex == 4 || level.ladderindex == 6) && !data["allowed"]) {
        _id_CB89110314447B2F++;
        continue;
      }

      level.weaponcategories[_id_22E2935C86B3B88E][level.weaponcategories[_id_22E2935C86B3B88E].size] = data;
    }

    _id_CB89110314447B2F++;
  }
}

_id_05F97F15E9CA6CB6(_id_22E2935C86B3B88E) {
  weaponlist = level.weaponcategories[_id_22E2935C86B3B88E];

  if(isDefined(weaponlist) && weaponlist.size > 0) {
    _id_DD515FCF025B2E79 = "";
    data = undefined;
    loopcount = 0;

    for(;;) {
      index = randomintrange(0, weaponlist.size);
      data = weaponlist[index];
      _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(data["weapon"]);
      _id_AAA935A3EBF3FD7C = 1;

      if(level.ladderindex == 4 || level.ladderindex == 6)
        _id_AAA935A3EBF3FD7C = data["allowed"];

      if(!isDefined(level.selectedweapons[_id_AB501F397D3CD312]) && _id_AAA935A3EBF3FD7C || loopcount > weaponlist.size) {
        level.selectedweapons[_id_AB501F397D3CD312] = 1;

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.weaponcategories[_id_22E2935C86B3B88E].size; _id_AC0E594AC96AA3A8++) {
          if(level.weaponcategories[_id_22E2935C86B3B88E][_id_AC0E594AC96AA3A8]["weapon"] == data["weapon"]) {
            level.weaponcategories[_id_22E2935C86B3B88E] = scripts\engine\utility::array_remove_index(level.weaponcategories[_id_22E2935C86B3B88E], _id_AC0E594AC96AA3A8);
            break;
          }
        }

        break;
      }

      loopcount++;
    }

    if(level.ladderindex == 4 || level.ladderindex == 6) {
      _id_9D519609E4FFDAA3 = getggweapontablelootvariants(data["weapon"]);
      data["variantID"] = table_parseweaponvariantidvalue(data["weapon"], _id_9D519609E4FFDAA3);
    } else if(level.ladderindex == 5)
      data["variantID"] = table_parseweaponvariantidvalue(data["weapon"], "-1");

    return data;
  } else {
    if(getdvarint("dvar_4F69E011A95E06A9", 0) != 0) {}

    return "none";
  }
}

_id_96D23570114BC7B6(_id_BAE77D8848F4D84D) {
  _id_C8616C37BC30098B = randomintrange(_id_BAE77D8848F4D84D["min"], _id_BAE77D8848F4D84D["max"] + 1);
  _id_DD515FCF025B2E79 = gun_createrandomweapon(_id_BAE77D8848F4D84D["weapon"], _id_C8616C37BC30098B, _id_BAE77D8848F4D84D["variantID"], scripts\cp_mp\utility\game_utility::isnightmap());
  return _id_DD515FCF025B2E79;
}

getrandomgraverobberattachment(currentweapon, _id_79583F5B5010A954) {
  if(!isDefined(currentweapon))
    return undefined;

  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(currentweapon);
  _id_DFAF5DD7FB4C5238 = getweaponattachments(currentweapon);
  _id_0605B3BCE83E5F38 = [];

  if(isDefined(_id_79583F5B5010A954) && _id_79583F5B5010A954.size > 0)
    _id_0605B3BCE83E5F38 = _id_79583F5B5010A954;
  else
    _id_0605B3BCE83E5F38 = _id_74502A9E0EF1F19C::getallselectableattachments(_id_AB501F397D3CD312);

  if(!isDefined(_id_0605B3BCE83E5F38))
    return undefined;

  foreach(_id_A127B09A74E38DDE, _id_9721CB769B805C9B in _id_DFAF5DD7FB4C5238) {
    if(!_id_74502A9E0EF1F19C::attachmentisselectable(currentweapon, _id_9721CB769B805C9B)) {
      _id_DFAF5DD7FB4C5238[_id_A127B09A74E38DDE] = undefined;
      continue;
    }
  }

  _id_0605B3BCE83E5F38 = scripts\engine\utility::array_convert_keys_to_ints(_id_0605B3BCE83E5F38);
  _id_0605B3BCE83E5F38 = scripts\engine\utility::array_randomize(_id_0605B3BCE83E5F38);

  foreach(_id_9112261A40FB1B9B in _id_0605B3BCE83E5F38) {
    if(!isgraverobberattachment(_id_AB501F397D3CD312, _id_9112261A40FB1B9B)) {
      continue;
    }
    attachmentsconflict = 0;

    foreach(_id_9721CB769B805C9B in _id_DFAF5DD7FB4C5238) {
      if(_id_2669878CF5A1B6BC::attachmentsconflict(_id_9721CB769B805C9B, _id_9112261A40FB1B9B, currentweapon) != "") {
        attachmentsconflict = 1;
        break;
      }
    }

    if(attachmentsconflict) {
      continue;
    }
    return _id_9112261A40FB1B9B;
  }

  return undefined;
}

isgraverobberattachment(weapon, _id_55F8624E7216D9AA) {
  if(!_id_74502A9E0EF1F19C::attachmentisselectable(weapon, _id_55F8624E7216D9AA))
    return 0;

  switch (_id_55F8624E7216D9AA) {
    case "laserrange":
    case "laserbalanced":
    case "akimbo":
      return 0;
  }

  if(issubstr(_id_55F8624E7216D9AA, "thermal"))
    return 0;

  if(issubstr(_id_55F8624E7216D9AA, "burst"))
    return 0;

  if(getsubstr(_id_55F8624E7216D9AA, 0, 3) == "cal")
    return 0;

  return 1;
}

gun_createrandomweapon(_id_AB501F397D3CD312, _id_C8616C37BC30098B, variantid, _id_11A1FA68AEB971C0) {
  if(level.ladderindex == 6) {
    if(!isDefined(_id_C8616C37BC30098B))
      _id_C8616C37BC30098B = randomintrange(0, 0);

    _id_B8215055A946EEBB = _id_2669878CF5A1B6BC::buildweapon(_id_AB501F397D3CD312, undefined, undefined, undefined, undefined, undefined, undefined, undefined, _id_11A1FA68AEB971C0);
    _id_79583F5B5010A954 = gun_buildoverrideattachmentlist(_id_AB501F397D3CD312);
    _id_952F1674FA8D734F = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C8616C37BC30098B; _id_AC0E594AC96AA3A8++) {
      attachment = getrandomgraverobberattachment(_id_B8215055A946EEBB, _id_79583F5B5010A954);

      if(!isDefined(attachment)) {
        break;
      } else {
        _id_66B3DB972AC1531E = _id_74502A9E0EF1F19C::addattachmenttoweapon(_id_B8215055A946EEBB, attachment);

        if(isDefined(_id_66B3DB972AC1531E))
          _id_B8215055A946EEBB = _id_66B3DB972AC1531E;

        _id_952F1674FA8D734F[_id_952F1674FA8D734F.size] = attachment;
      }
    }

    _id_B8215055A946EEBB = _id_2669878CF5A1B6BC::buildweapon_blueprintwithcustomattachments(_id_AB501F397D3CD312, _id_952F1674FA8D734F, undefined, undefined, variantid, undefined, undefined, undefined, _id_11A1FA68AEB971C0);
    return _id_B8215055A946EEBB;
  } else {
    if(isDefined(variantid) && variantid != 0)
      _id_B8215055A946EEBB = _id_2669878CF5A1B6BC::buildweapon_blueprint(_id_AB501F397D3CD312, undefined, undefined, variantid, undefined, undefined, _id_11A1FA68AEB971C0);
    else
      _id_B8215055A946EEBB = _id_2669878CF5A1B6BC::buildweapon(_id_AB501F397D3CD312, undefined, undefined, undefined, undefined, undefined, undefined, undefined, _id_11A1FA68AEB971C0);

    if(!isDefined(_id_C8616C37BC30098B))
      _id_C8616C37BC30098B = randomintrange(0, 0);

    _id_79583F5B5010A954 = gun_buildoverrideattachmentlist(_id_B8215055A946EEBB);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C8616C37BC30098B; _id_AC0E594AC96AA3A8++) {
      attachment = getrandomgraverobberattachment(_id_B8215055A946EEBB, _id_79583F5B5010A954);

      if(!isDefined(attachment)) {
        break;
      }

      _id_66B3DB972AC1531E = _id_74502A9E0EF1F19C::addattachmenttoweapon(_id_B8215055A946EEBB, attachment);

      if(isDefined(_id_66B3DB972AC1531E))
        _id_B8215055A946EEBB = _id_66B3DB972AC1531E;
    }

    return _id_B8215055A946EEBB;
  }
}

gun_buildoverrideattachmentlist(_id_72C4B0AF1A85887E) {
  _id_0605B3BCE83E5F38 = _id_74502A9E0EF1F19C::getallselectableattachments(_id_72C4B0AF1A85887E);
  _id_79583F5B5010A954 = [];

  foreach(attachment in _id_0605B3BCE83E5F38) {
    if(isstartstr(attachment, "gl") || isstartstr(attachment, "ub") || isstartstr(attachment, "thermal") || attachment == "hybrid3") {
      continue;
    }
    _id_79583F5B5010A954[_id_79583F5B5010A954.size] = attachment;
  }

  return _id_79583F5B5010A954;
}

attachmentcheck(attachment, _id_517683BAD763B676, _id_A71A84CDAD3A4EBB, weaponname) {
  _id_2C4FC9C24CCFDF3C = tablelookup(_id_A71A84CDAD3A4EBB, 0, attachment, 1);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_517683BAD763B676.size; _id_AC0E594AC96AA3A8++) {
    _id_E012C12F441A9C1D = tablelookup(_id_A71A84CDAD3A4EBB, 0, _id_517683BAD763B676[_id_AC0E594AC96AA3A8], 1);

    if(attachment == _id_517683BAD763B676[_id_AC0E594AC96AA3A8] || _id_2669878CF5A1B6BC::attachmentsconflict(attachment, _id_517683BAD763B676[_id_AC0E594AC96AA3A8], weaponname) != "" || _id_2C4FC9C24CCFDF3C == _id_E012C12F441A9C1D)
      return 0;
  }

  return 1;
}

_id_5D137D3132A633ED(type) {
  waittime = level._id_72BEADE6989B19B8;
  _id_9CC83556135DBEA7 = 0;

  if(type == "hit") {
    waittime = int((self._id_5F020CD300675CCB - gettime()) / 1000 + 1);

    if(waittime > level._id_72BEADE6989B19B8)
      waittime = level._id_72BEADE6989B19B8;
  } else if(type == "assist") {
    if(_id_9CC83556135DBEA7)
      waittime = int(min((self._id_5F020CD300675CCB - gettime()) / 1000 + level._id_72BEADE6989B19B8 * 0.25, level._id_72BEADE6989B19B8));
    else
      waittime = int(min((self._id_5F020CD300675CCB - gettime()) / 1000 + level._id_72BEADE6989B19B8 * 0.5, level._id_72BEADE6989B19B8));
  } else if(type == "friendly_tag")
    waittime = int(min((self._id_5F020CD300675CCB - gettime()) / 1000 + level._id_72BEADE6989B19B8 * 0.25, level._id_72BEADE6989B19B8));
  else if(_id_9CC83556135DBEA7) {
    if(isDefined(self._id_54B3C10FF987E34B) && self._id_54B3C10FF987E34B && isDefined(self._id_5F020CD300675CCB))
      waittime = int(min((self._id_5F020CD300675CCB - gettime()) / 1000 + level._id_72BEADE6989B19B8 * 0.5, level._id_72BEADE6989B19B8));
    else
      waittime = int(waittime * 0.5);
  } else
    waittime = level._id_72BEADE6989B19B8;

  endtime = waittime * 1000 + gettime();
  self setclientomnvar("ui_gungame_timer_end_milliseconds", endtime);
  self._id_5F020CD300675CCB = endtime;
  thread _id_85880D716B8AB09D();
  thread _id_4CCAB81FCDB158FD(waittime);
  thread _id_E5F947D60BF46F2B();
}

_id_85880D716B8AB09D() {
  self notify("watchGunGameHostMigration");
  self endon("watchGunGameHostMigration");
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("stop_gungame");
  level waittill("host_migration_begin");
  _id_3B5803E733581858 = scripts\cp\cp_hostmigration::waittillhostmigrationdone();

  if(_id_3B5803E733581858 > 0)
    self setclientomnvar("ui_gungame_timer_end_milliseconds", self._id_5F020CD300675CCB + _id_3B5803E733581858);
  else
    self setclientomnvar("ui_gungame_timer_end_milliseconds", self._id_5F020CD300675CCB);
}

_id_E5F947D60BF46F2B() {
  self notify("watchEndGame");
  self endon("watchEndGame");
  self endon("death_or_disconnect");
  self endon("stop_gungame");

  for(;;) {
    if(game["state"] == "postgame" || level.gameended) {
      self setclientomnvar("ui_gungame_timer_end_milliseconds", 0);
      break;
    }

    wait 0.1;
  }
}

_id_4CCAB81FCDB158FD(waittime) {
  self notify("watchBombTimer");
  self endon("watchBombTimer");
  self endon("disconnect");
  level endon("game_ended");
  self endon("stop_gungame");
  thread _id_A4215EF9D63D48DF(waittime);
  _id_928B160C136333A8 = 5;
  _id_8440421626C8B0CF = waittime - _id_928B160C136333A8 - 1;

  if(_id_8440421626C8B0CF > 0) {
    scripts\cp\cp_hostmigration::waitlongdurationwithgameendtimeupdate(_id_8440421626C8B0CF);
    scripts\cp\cp_hostmigration::waitlongdurationwithgameendtimeupdate(1.0);
  }

  while(_id_928B160C136333A8 > 0) {
    scripts\cp\cp_hostmigration::waitlongdurationwithgameendtimeupdate(1.0);
    _id_928B160C136333A8--;
  }

  if(isDefined(self) && scripts\cp\utility\player::isreallyalive(self) && scripts\cp\utility::getgametype() != "tdef") {
    self notify("gun_game_next_weapon");
    _id_5D137D3132A633ED("kill");
  }
}

_id_A4215EF9D63D48DF(waittime) {
  self endon("death");
  self notify("refreshGunGameUIProgress");
  self endon("refreshGunGameUIProgress");
  currenttimelimitdelay = 0;
  _id_038FC7BD1495C4B2 = 0;

  if(waittime != level._id_72BEADE6989B19B8)
    currenttimelimitdelay = level._id_72BEADE6989B19B8 - waittime;

  for(;;) {
    currenttimelimitdelay = currenttimelimitdelay + 0.05;
    progress = clamp(1.0 - currenttimelimitdelay / level._id_72BEADE6989B19B8, 0.0, 1.0);
    self setclientomnvar("ui_gungame_timer", progress);
    wait 0.05;
  }
}

takeweaponwhensafegungame(weapon, _id_2AF5EEDF0B55AC7E) {
  self endon("death_or_disconnect");

  for(;;) {
    if(!scripts\cp_mp\utility\inventory_utility::iscurrentweapon(weapon)) {
      break;
    }

    waitframe();
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(weapon);

  if(_id_2AF5EEDF0B55AC7E)
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("spawn_weapon");
}

_id_7915E88A08F28705() {
  if(getDvar("dvar_3D6CC59E7F693916", "") == "")
    return 0;

  return 1;
}

_id_30D732F612695BA8() {
  if(istrue(level._id_3978BF00ED49711D))
    return 1;

  _id_934386CAE08481B2 = getDvar("dvar_3D6CC59E7F693916", "");
  _id_CE22EF601C001A14 = strtok(_id_934386CAE08481B2, ",");

  foreach(_id_F51F7E151E0EE2F0 in _id_CE22EF601C001A14) {
    if(_id_F51F7E151E0EE2F0 == "relic_gun_game")
      return 1;
  }

  return 0;
}

_id_7380668EAB6114E9() {
  if(istrue(level._id_C24AD87FD6F55BF2))
    return 1;

  _id_934386CAE08481B2 = getDvar("dvar_3D6CC59E7F693916", "");
  _id_CE22EF601C001A14 = strtok(_id_934386CAE08481B2, ",");

  foreach(_id_F51F7E151E0EE2F0 in _id_CE22EF601C001A14) {
    if(_id_F51F7E151E0EE2F0 == "passive_health_regen_on_kill")
      return 1;
  }

  return 0;
}

_id_0BDD2D00AAE756FB() {
  if(istrue(level._id_8C92AD3F28E2D246))
    return 1;

  _id_934386CAE08481B2 = getDvar("dvar_3D6CC59E7F693916", "");
  _id_CE22EF601C001A14 = strtok(_id_934386CAE08481B2, ",");

  foreach(_id_F51F7E151E0EE2F0 in _id_CE22EF601C001A14) {
    if(_id_F51F7E151E0EE2F0 == "relic_rocket_kill_ammo")
      return 1;
  }

  return 0;
}

player_gun_game_next_weapon_think(player) {
  player endon("disconnect");
  player notify("player_gun_game_next_weapon_think");
  player endon("player_gun_game_next_weapon_think");
  player endon("unset_gun_game");
  player.gun_game_primary_weapon = player.primaryweaponobj;

  for(;;) {
    player waittill("gun_game_next_weapon");
    scripts\engine\utility::flag_wait("both_players_intro_binks_complete");

    if(istrue(level._id_EFE609BCE901CAA8) && !scripts\engine\utility::flag("infil_over"))
      scripts\engine\utility::flag_wait("infil_over");

    while(istrue(player.insertingarmorplate) || player secondaryoffhandbuttonPressed() || player isthrowinggrenade() || player isthrowingbackgrenade() || player fragButtonPressed() || player _meth_415FE9EECA7B2E2B() || istrue(player.inlaststand) || istrue(player.iscarrying) || istrue(player.bgivensentry) || player isswitchingweapon() || player scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress())
      waitframe();

    player notify("equip_deploy_cancel");
    _id_91DB6B49624FD568 = get_random_primary_weapon_obj(player);
    player scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_91DB6B49624FD568, undefined, undefined, undefined);
    player setweaponammoclip(_id_91DB6B49624FD568, weaponclipsize(_id_91DB6B49624FD568));
    _id_811ABFDB6C33F17F = _id_66122A002AFF5D57::br_ammo_type_for_weapon(_id_91DB6B49624FD568);

    if(isDefined(_id_811ABFDB6C33F17F)) {
      _id_AB0EE360900BCB85 = weaponmaxammo(_id_91DB6B49624FD568);

      if(isDefined(_id_AB0EE360900BCB85))
        _id_66122A002AFF5D57::br_ammo_give_type(player, _id_811ABFDB6C33F17F, _id_AB0EE360900BCB85);
    }

    player.pers["primaryWeapon"] = _id_91DB6B49624FD568.basename;
    player.primaryweapon = _id_91DB6B49624FD568.basename;
    player.primaryweaponobj = _id_91DB6B49624FD568;
    player setspawnweapon(_id_91DB6B49624FD568, 1);
    player scripts\cp_mp\utility\inventory_utility::_switchtoweapon(_id_91DB6B49624FD568);

    foreach(weapon in self.weaponlist) {
      if(weapon != _id_91DB6B49624FD568 && weapon != player._id_88350DAC5063D94E)
        player thread scripts\cp_mp\utility\inventory_utility::takeweaponwhensafe(weapon);
    }

    currentweapon = player.lastdroppableweaponobj;
    player thread takeweaponwhensafegungame(currentweapon, 1);
    player.gun_game_primary_weapon = _id_91DB6B49624FD568;
  }
}

_id_DFEF4A2E716402CE(_id_6EB7362DC307D4C6) {
  player = self;

  for(;;) {
    self waittill("weapon_change", _id_66B3DB972AC1531E);

    if(_id_74502A9E0EF1F19C::isprimaryweapon(_id_66B3DB972AC1531E)) {
      continue;
    }
    self iprintln(_id_6EB7362DC307D4C6.basename);

    if(_id_66B3DB972AC1531E.basename == _id_6EB7362DC307D4C6.basename) {
      break;
    }
  }
}

_id_2894ACA863446B64(sweapon, eattacker, victim, smeansofdeath, shitloc, time) {
  if(!isPlayer(eattacker)) {
    return;
  }
  eattacker notify("gun_game_next_weapon");
}

handlepersistentgungame(player, weapon) {
  player endon("disconnect");
  player notify("handlePersistentGunGame");
  player endon("handlePersistentGunGame");
  player endon("unset_gun_game");

  if(getdvarint("dvar_ECC8E20C7C40EE41", 1) != 0) {
    return;
  }
  for(;;) {
    player waittill("weapon_fired", objweapon);

    if(isDefined(player.gun_game_primary_weapon) && !_id_0AFB7E332AEE4BF2::player_in_laststand(player)) {
      _id_D8C1A9B6F71F67D1 = player getweaponammoclip(player.gun_game_primary_weapon) + player getweaponammostock(player.gun_game_primary_weapon);

      if(_id_D8C1A9B6F71F67D1 == 0)
        player notify("gun_game_next_weapon");

      if(!player hasweapon(player.gun_game_primary_weapon))
        player notify("gun_game_next_weapon");
    }
  }
}

player_gun_game_randomize_weapon_list_think(player) {
  player endon("disconnect");
  player notify("player_gun_game_randomize_weapon_list_think");
  player endon("player_gun_game_randomize_weapon_list_think");
  player endon("unset_gun_game");

  for(;;) {
    if(!player scripts\engine\utility::ent_flag_exist("player_spawned_with_loadout"))
      player scripts\engine\utility::ent_flag_init("player_spawned_with_loadout");

    player scripts\engine\utility::ent_flag_wait("player_spawned_with_loadout");

    if(!istrue(player._id_462062384567C594)) {
      wait 2;
      player._id_462062384567C594 = 1;
    }

    if(isDefined(player.secondaryweaponobj)) {
      if(player.secondaryweaponobj != level._id_0BCD25CD23011249["fists"]) {
        player takeweapon(player.secondaryweaponobj);
        _id_B958FC6E0FF72244(player);
      }
    } else
      _id_B958FC6E0FF72244(player);

    player setweaponammoclip(player.primaryweaponobj, weaponclipsize(player.primaryweaponobj));
    player setweaponammostock(player.primaryweaponobj, weaponmaxammo(player.primaryweaponobj));
    generate_randomized_primary_weapon_objs(player);
    return;
  }
}

_id_B958FC6E0FF72244(player) {
  if(_id_29381B5C03BAA877(player)) {
    player._id_88350DAC5063D94E = level._id_0BCD25CD23011249["fists"];
    player scripts\cp_mp\utility\inventory_utility::_giveweapon(player._id_88350DAC5063D94E);
  }
}

_id_29381B5C03BAA877(player) {
  if(!self hasweapon(level._id_0BCD25CD23011249["fists"]))
    return 1;

  return 0;
}

get_random_primary_weapon_obj(player) {
  result = player.randomized_primary_weapon_objs[player.randomized_primary_weapon_index];

  if(!isDefined(result))
    return player.randomized_primary_weapon_objs[player.randomized_primary_weapon_index];

  player.randomized_primary_weapon_index++;

  if(player.randomized_primary_weapon_index == player.randomized_primary_weapon_objs.size) {
    player.randomized_primary_weapon_index = 0;
    player.randomized_primary_weapon_objs = scripts\engine\utility::array_randomize(level._id_1A70639BF6482BC2);
  } else {}

  return result;
}

generate_randomized_primary_weapon_objs(player) {
  player.randomized_primary_weapon_index = 0;
  player.randomized_primary_weapon_objs = scripts\engine\utility::array_randomize(level._id_1A70639BF6482BC2);
}

_id_2E08463451CF36EC() {
  if(isDefined(level._id_1A70639BF6482BC2)) {
    return;
  }
  level._id_1A70639BF6482BC2 = [];
  level._id_1A70639BF6482BC2[level._id_1A70639BF6482BC2.size] = _id_2669878CF5A1B6BC::buildweapon("iw9_pi_decho_mp", scripts\engine\utility::array_combine(_func_6527364C1ECCA6C6("iw9_pi_decho_mp"), ["ammo_50p", "bar_pi_hvylong_p25", "comp_decho_01", "mag_pi_large_p25", "stockno_pi_p25", "trigger_p25"]));
  level._id_1A70639BF6482BC2[level._id_1A70639BF6482BC2.size] = _id_2669878CF5A1B6BC::buildweapon("iw9_pi_papa220_mp", scripts\engine\utility::array_combine(_func_6527364C1ECCA6C6("iw9_pi_papa220_mp"), ["silencer01_pi", "iw9_minireddot01_pstl"]));
  level._id_1A70639BF6482BC2[level._id_1A70639BF6482BC2.size] = _id_2669878CF5A1B6BC::buildweapon("iw9_pi_golf17_mp", scripts\engine\utility::array_combine(_func_6527364C1ECCA6C6("iw9_pi_golf17_mp"), ["mag_pi_xlarge_p24"]));
  level._id_1A70639BF6482BC2[level._id_1A70639BF6482BC2.size] = _id_2669878CF5A1B6BC::buildweapon("iw9_pi_swhiskey_mp", scripts\engine\utility::array_combine(_func_6527364C1ECCA6C6("iw9_pi_swhiskey_mp"), ["akimbo_swhiskey"]));
  level._id_1A70639BF6482BC2[level._id_1A70639BF6482BC2.size] = _id_2669878CF5A1B6BC::buildweapon("iw9_sh_mbravo_mp", _func_6527364C1ECCA6C6("iw9_sh_mbravo_mp"));
  level._id_1A70639BF6482BC2[level._id_1A70639BF6482BC2.size] = _id_2669878CF5A1B6BC::buildweapon("iw9_sh_mike1014_mp", _func_6527364C1ECCA6C6("iw9_sh_mike1014_mp"));
  level._id_1A70639BF6482BC2[level._id_1A70639BF6482BC2.size] = _id_2669878CF5A1B6BC::buildweapon("iw9_sh_mviktor_mp", _func_6527364C1ECCA6C6("iw9_sh_mviktor_mp"));
  level._id_1A70639BF6482BC2[level._id_1A70639BF6482BC2.size] = _id_2669878CF5A1B6BC::buildweapon("iw9_sm_papa90_mp", _func_6527364C1ECCA6C6("iw9_sm_papa90_mp"));
  level._id_1A70639BF6482BC2[level._id_1A70639BF6482BC2.size] = _id_2669878CF5A1B6BC::buildweapon("iw9_sm_beta_mp", scripts\engine\utility::array_combine(_func_6527364C1ECCA6C6("iw9_sm_beta_mp"), ["holo01", "pgrip_p04"]));
  level._id_1A70639BF6482BC2[level._id_1A70639BF6482BC2.size] = _id_2669878CF5A1B6BC::buildweapon("iw9_br_msecho_mp", _func_6527364C1ECCA6C6("iw9_br_msecho_mp"));
  level._id_1A70639BF6482BC2[level._id_1A70639BF6482BC2.size] = _id_2669878CF5A1B6BC::buildweapon("iw9_br_soscar14_mp", scripts\engine\utility::array_combine(_func_6527364C1ECCA6C6("iw9_br_soscar14_mp"), ["arscope01"]));
  level._id_1A70639BF6482BC2[level._id_1A70639BF6482BC2.size] = _id_2669878CF5A1B6BC::buildweapon("iw9_ar_scharlie_mp", _func_6527364C1ECCA6C6("iw9_ar_scharlie_mp"));
  level._id_1A70639BF6482BC2[level._id_1A70639BF6482BC2.size] = _id_2669878CF5A1B6BC::buildweapon("iw9_dm_mike24_mp", _func_6527364C1ECCA6C6("iw9_dm_mike24_mp"));
  level._id_1A70639BF6482BC2[level._id_1A70639BF6482BC2.size] = _id_2669878CF5A1B6BC::buildweapon("iw9_lm_rkilo_mp", scripts\engine\utility::array_combine(_func_6527364C1ECCA6C6("iw9_lm_rkilo_mp"), ["bipod_rkilo", "fourx02"]));
  level._id_1A70639BF6482BC2[level._id_1A70639BF6482BC2.size] = _id_2669878CF5A1B6BC::buildweapon("iw9_lm_slima_mp", _func_6527364C1ECCA6C6("iw9_lm_slima_mp"));
  level._id_1A70639BF6482BC2[level._id_1A70639BF6482BC2.size] = _id_2669878CF5A1B6BC::buildweapon("iw9_dm_sbeta_mp", scripts\engine\utility::array_combine(_func_6527364C1ECCA6C6("iw9_dm_sbeta_mp"), ["dmscope01", "lever_heavy_p19"]));
  level._id_1A70639BF6482BC2[level._id_1A70639BF6482BC2.size] = _id_2669878CF5A1B6BC::buildweapon("iw9_sn_limax_mp", scripts\engine\utility::array_combine(_func_6527364C1ECCA6C6("iw9_sn_limax_mp"), ["ammo_50b"]));
  level._id_1A70639BF6482BC2[level._id_1A70639BF6482BC2.size] = _id_2669878CF5A1B6BC::buildweapon("iw9_la_rpapa7_mp", _func_6527364C1ECCA6C6("iw9_la_rpapa7_mp"));
  level._id_1A70639BF6482BC2[level._id_1A70639BF6482BC2.size] = _id_2669878CF5A1B6BC::buildweapon("iw9_la_mike32_mp", _func_6527364C1ECCA6C6("iw9_la_mike32_mp"));
  level._id_1A70639BF6482BC2[level._id_1A70639BF6482BC2.size] = _id_2669878CF5A1B6BC::buildweapon("iw9_lm_dblmg2_cp", scripts\engine\utility::array_combine(_func_6527364C1ECCA6C6("iw9_lm_dblmg2_cp"), ["dynamic_null_dblmg", "laserads_bright_dblmg"]));
  level._id_1A70639BF6482BC2[level._id_1A70639BF6482BC2.size] = _id_2669878CF5A1B6BC::buildweapon("iw9_sn_mromeo_mp", _func_6527364C1ECCA6C6("iw9_sn_mromeo_mp"));
  level._id_1A70639BF6482BC2[level._id_1A70639BF6482BC2.size] = _id_2669878CF5A1B6BC::buildweapon("iw9_dm_la700_mp", scripts\engine\utility::array_combine(_func_6527364C1ECCA6C6("iw9_dm_la700_mp"), ["fourxtherm01", "xmag_sn_p20", "bar_sn_p20_la700"]));
  level._id_1A70639BF6482BC2[level._id_1A70639BF6482BC2.size] = _id_2669878CF5A1B6BC::buildweapon("iw9_sm_victor_mp", scripts\engine\utility::array_combine(_func_6527364C1ECCA6C6("iw9_sm_victor_mp"), ["lasercyl_hip03", "drum_p10", "holo01", "grip_vert04"]));
}

create_primary_weapon_obj_from_custom_loadout(player, custom_loadout_index) {
  struct = spawnStruct();
  _id_D0EF877013D341AF = player _id_12E2FB553EC1605E::loadout_updateclasscustom(struct, custom_loadout_index);
  _id_91DB6B49624FD568 = _id_2669878CF5A1B6BC::buildweapon(_id_D0EF877013D341AF.loadoutprimary, _id_D0EF877013D341AF.loadoutprimaryattachments, _id_D0EF877013D341AF.loadoutprimarycamo, _id_D0EF877013D341AF.loadoutprimaryreticle, _id_D0EF877013D341AF.loadoutprimaryvariantid, _id_D0EF877013D341AF.loadoutprimaryattachmentids, _id_D0EF877013D341AF.loadoutprimarycosmeticattachment, _id_D0EF877013D341AF.loadoutprimarystickers, istrue(_id_D0EF877013D341AF.loadouthasnvg));
  _id_91DB6B49624FD568 = _id_12E2FB553EC1605E::give_weapon_alt_clip_ammo_hack(player, _id_91DB6B49624FD568);
  return _id_91DB6B49624FD568;
}

unset_relic_gun_game(player) {
  player.persistentrelics["relic_gun_game"] = 0;
  level._id_3978BF00ED49711D = undefined;
  scripts\cp\utility::_id_C0D2C91F2688ECE4(1);
  player notify("unset_gun_game");
}

init_relic_dfa(player) {}

set_relic_dfa(player) {
  player.stealthtimeelapsed = 0.0;
}

unset_relic_dfa(player) {
  player.stealthtimeelapsed = undefined;
}

handledeathfromabove() {
  level thread start_death_from_above_sequence();
}

start_death_from_above_sequence(_id_B4A73EF4935724BE) {
  wait 45;
  level.disableannouncer = undefined;

  switch (level.script) {
    case "cp_arms_dealer":
      level thread scripts\cp\killstreaks\gunship_cp::enemygunship_spawngunship(75, undefined, (-18750.2, 9332.44, 0), 40000, 15000, _id_B4A73EF4935724BE);
      break;
    case "cp_smuggler":
      level thread scripts\cp\killstreaks\gunship_cp::enemygunship_spawngunship(45, undefined, undefined, 40000, 15000, _id_B4A73EF4935724BE);
      break;
    case "cp_landlord_2":
      level thread scripts\cp\killstreaks\gunship_cp::enemygunship_spawngunship(45, undefined, (3289.02, 45965.8, 0), 40000, 15000, _id_B4A73EF4935724BE);
      break;
    default:
      level thread scripts\cp\killstreaks\gunship_cp::enemygunship_spawngunship(45, undefined, undefined, undefined, undefined, _id_B4A73EF4935724BE);
      break;
  }
}

init_relic_aggressive_melee(player) {}

set_relic_aggressive_melee(player) {
  _id_18A73A64992DD07D::add_global_spawn_function("axis", ::set_relic_aggressive_melee_params);

  foreach(guy in level.spawned_enemies)
  guy set_relic_aggressive_melee_params();
}

unset_relic_aggressive_melee(player) {
  _id_18A73A64992DD07D::remove_global_spawn_function("axis", ::set_relic_aggressive_melee_params);

  foreach(guy in level.spawned_enemies)
  guy unset_relic_aggressive_melee_params();
}

set_relic_aggressive_melee_params() {
  thread aggressively_chase_down_target(self);
  self._id_BA227281DE712E68 = 1;
  self._id_384C9CC6CD2605D0 = 1;

  if(self.meleechargedistvsplayer < 3000) {
    self.aggressive_melee_active = 1;
    self.original_meleechargedistvsplayer = self.meleechargedistvsplayer;
    self.meleechargedistvsplayer = 3000;
  }
}

unset_relic_aggressive_melee_params() {
  self._id_BA227281DE712E68 = 0;
  self._id_384C9CC6CD2605D0 = 0;
  self notify("stop_aggressively_chase_down_target");

  if(istrue(self.aggressive_melee_active)) {
    self.meleechargedistvsplayer = self.original_meleechargedistvsplayer;
    self.original_meleechargedistvsplayer = undefined;
    self.aggressive_melee_active = undefined;
  }
}

aggressively_chase_down_target(_id_CD977BE97BC0FC1E) {
  _id_CD977BE97BC0FC1E endon("death");
  _id_CD977BE97BC0FC1E endon("stop_aggressively_chase_down_target");

  for(;;) {
    if(isDefined(_id_CD977BE97BC0FC1E.enemy) && isPlayer(_id_CD977BE97BC0FC1E.enemy)) {
      _id_831198D90CF1BDF4 = getclosestpointonnavmesh(_id_CD977BE97BC0FC1E.enemy.origin);
      _id_CD977BE97BC0FC1E setgoalpos(_id_831198D90CF1BDF4);
    }

    wait 1;
  }
}

init_relic_thirdperson(player) {
  player.relic_third_person = 1;
  player setcamerathirdperson(1);
}

set_relic_thirdperson(player) {
  player.relic_third_person = 1;
  player thread set_thirdperson();
}

set_thirdperson() {
  self endon("death");
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;
  self setcamerathirdperson(1);
}

unset_relic_thirdperson(player) {
  player.relic_third_person = undefined;
  player setcamerathirdperson(0);
}

init_relic_noregen(player) {
  level.healthregendisabled = 1;
}

_id_E80B26D34F0BCAA9() {
  setomnvar("ui_showhealthbar", 1);
}

set_relic_noregen(player) {
  level.healthregendisabled = 1;
}

unset_relic_noregen(player) {
  level.healthregendisabled = undefined;
}

init_relic_vampire(player) {
  player thread update_health_on_spawn();
}

relic_vampire_globalfunc() {
  level.relic_vampire = 1;
  setomnvar("ui_showhealthbar", 1);
}

set_relic_vampire(player) {
  player.ondamagerelics["relic_vampire"] = 1;
}

unset_relic_vampire(player) {
  level.relic_vampire = 0;
}

ondamagerelicvampire(eattacker, sweapon, _id_E851FFA44B7E0D54, smeansofdeath, shitloc, timeoffset) {
  if(!isagent(_id_E851FFA44B7E0D54)) {
    return;
  }
  player = undefined;

  if(!isPlayer(eattacker)) {
    if(!isDefined(eattacker.owner))
      return;
    else
      player = eattacker.owner;
  } else
    player = eattacker;

  if(isDefined(player) && !istrue(player.inlaststand)) {
    if(player.health + 5 > player.maxhealth)
      player _id_25845ACA699D038D::set_normalhealth(player.maxhealth / player.maxhealth);
    else
      player _id_25845ACA699D038D::set_normalhealth((player.health + 5) / player.maxhealth);

    if(!isDefined(player.last_vampire_feedback))
      player.last_vampire_feedback = 0;

    if(gettime() < player.last_vampire_feedback) {
      return;
    }
    player.last_vampire_feedback = gettime() + 300;
    player thread relic_vampire_feedback();
  }
}

relic_vampire_feedback() {
  self endon("last_stand");
  self endon("disconnect");
  wait 0.25;
  self setclientomnvar("damage_feedback_icon", "hitadrenaline");
  self setclientomnvar("damage_feedback_icon_notify", gettime());

  if(!isDefined(self.last_vampire_sound))
    self.last_vampire_sound = 0;

  if(gettime() < self.last_vampire_sound) {
    return;
  }
  self playlocalsound("cp_hacking_success");
  self.last_vampire_sound = gettime() + 500;
}

init_relic_healthpacks(player) {
  player thread update_health_on_spawn();
}

relic_healthpacks_globalfunc() {
  level.relic_healthpacks = 1;
  setomnvar("ui_showhealthbar", 1);
  level.healthpack_health = getdvarint("dvar_27042FAEADC74C6C", 25);
}

set_relic_healthpacks(player) {
  player.onkillrelics["relic_healthpacks"] = 1;
}

unset_relic_healthpacks(player) {
  player.onkillrelics["relic_healthpacks"] = 0;
}

relic_healthpacks_killfunc(sweapon, player, victim, smeansofdeath, shitloc, time) {
  if(!isDefined(level.active_healthpacks))
    level.active_healthpacks = [];

  if(level.active_healthpacks.size >= 20) {
    level.active_healthpacks[0].trigger.fx delete();
    level.active_healthpacks[0].trigger delete();
    level.active_healthpacks[0] delete();
    waitframe();
  }

  while(isDefined(victim) && isDefined(victim.a) && istrue(victim scripts\engine\utility::doinglongdeath()))
    wait 0.1;

  pos = getgroundposition(victim.origin, 4, 10);
  trigger = spawn("trigger_radius", pos, 0, 72, 72);
  trigger.fx = spawnfx(level._effect["healthpack_spawn"], pos + (0, 0, 25));
  triggerfx(trigger.fx);
  trigger thread relic_healthpacks_think();
}

relic_healthpacks_think() {
  self endon("pickedup");
  self endon("death");
  thread relic_healthpacks_wait_for_pickup();
  _id_C2BA0CD135BF2843 = gettime() + 20000;

  while(gettime() < _id_C2BA0CD135BF2843)
    wait 0.05;

  playsoundatpos(self.origin, "mp_killconfirm_tags_pickup");
  playFX(level._effect["healthpack_pickup"], self.origin + (0, 0, 25));
  self.fx delete();
  self delete();
}

relic_healthpacks_wait_for_pickup() {
  self endon("death");

  for(;;) {
    self waittill("trigger", ent);

    if(!isPlayer(ent) || !ent scripts\cp\utility::is_valid_player() || ent.health == ent.maxhealth)
      continue;
    else {
      if(scripts\cp\utility::_id_F620E996A1D7D81A()) {
        ent notify("healthpack");
        self.fx delete();
        self delete();
        return;
      }

      self notify("pickedup");
      ent playlocalsound("mp_killconfirm_tags_pickup");
      playFX(level._effect["healthpack_pickup"], self.origin);
      _id_9511FFFEC55BA283 = ent getnormalhealth();

      if(_id_9511FFFEC55BA283 + int(level.healthpack_health / 100))
        ent _id_25845ACA699D038D::set_normalhealth(1);
      else
        ent _id_25845ACA699D038D::set_normalhealth(_id_9511FFFEC55BA283 + int(level.healthpack_health / 100));

      self.fx delete();
      self delete();
      return;
    }
  }
}

init_relic_bang_and_boom(player) {}

set_relic_bang_and_boom(player) {
  level.relic_bang_and_boom = 1;
  player.ondroprelics["relic_bang_and_boom"] = 1;
  player.no_enemy_weapon_drops = 1;
}

unset_relic_bang_and_boom(player) {
  level.relic_bang_and_boom = 0;
  player.ondroprelics["relic_bang_and_boom"] = 0;
  player.no_enemy_weapon_drops = undefined;
}

relic_bang_and_boom_dropfunc(pos, _id_4D8D96D547DF2E9F) {
  if(!isDefined(level.active_relic_bang_and_boom))
    level.active_relic_bang_and_boom = [];

  if(level.active_relic_bang_and_boom.size >= 20) {
    level.active_relic_bang_and_boom[0].trigger delete();
    level.active_relic_bang_and_boom[0] delete();
    waitframe();
  }

  drop_type = get_type_to_drop(_id_4D8D96D547DF2E9F);

  if(!isDefined(drop_type)) {
    return;
  }
  trigger = spawn("trigger_radius", pos, 0, 72, 72);

  if(drop_type == "ammo")
    trigger.drop_type = "ammo";
  else
    trigger.drop_type = "grenade";

  playsoundatpos(pos, "mp_killconfirm_tags_drop");
  trigger thread relic_bang_and_boom_think();
}

get_type_to_drop(_id_4D8D96D547DF2E9F) {
  _id_0E86180E07331051 = undefined;

  switch (_id_4D8D96D547DF2E9F.smeansofdeath) {
    case "MOD_PROJECTILE":
    case "MOD_PISTOL_BULLET":
    case "MOD_RIFLE_BULLET":
      _id_0E86180E07331051 = "grenade";
      break;
    case "MOD_EXPLOSIVE_BULLET":
    case "MOD_GRENADE":
    case "MOD_IMPACT":
    case "MOD_FIRE":
    case "MOD_PROJECTILE_SPLASH":
    case "MOD_EXPLOSIVE":
    case "MOD_GRENADE_SPLASH":
      _id_0E86180E07331051 = "ammo";
      break;
  }

  return _id_0E86180E07331051;
}

relic_bang_and_boom_think() {
  self endon("pickedup");
  self endon("death");
  thread relic_bang_and_boom_wait_for_pickup();
  _id_C2BA0CD135BF2843 = gettime() + 20000;

  while(gettime() < _id_C2BA0CD135BF2843)
    wait 0.05;

  deleteheadicon(self.headicon);
  self delete();
}

relic_bang_and_boom_wait_for_pickup() {
  self endon("death");
  self.headicon = createheadiconatorigin(self.origin + (0, 0, 14));

  if(self.drop_type == "ammo")
    setheadiconimage(self.headicon, "hud_icon_ammo");
  else
    setheadiconimage(self.headicon, "hud_icon_equipment_frag");

  setheadiconmaxdistance(self.headicon, 29000);
  setheadiconnaturaldistance(self.headicon, 10);
  setheadiconzoffset(self.headicon, 10);

  for(;;) {
    self waittill("trigger", ent);

    if(!isPlayer(ent) || !ent scripts\cp\utility::is_valid_player())
      continue;
    else {
      success = 0;

      if(self.drop_type == "ammo") {
        ent playlocalsound("weap_ammo_pickup");
        success = ent _id_6F1E07CE9FF97D5F::give_ammo_to_stock();
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
}

should_give_grenades() {
  _id_3BDA1622A11CF39B = 1;
  _id_C351B07CFBE3C36E = 1;
  primary_weapons = self getweaponslistprimaries();

  foreach(weapon in primary_weapons) {
    if(weapontype(weapon) == "projectile") {
      if(weapon.basename == "iw8_la_mike32_mp") {
        if(self.gl_proj_override == "thermite")
          continue;
      }

      if(!scripts\cp\cp_grenade_crate::max_projectile_check(weapon))
        _id_C351B07CFBE3C36E = 0;
    }

    if(weapon.inventorytype == "altmode" && isDefined(weapon.underbarrel) && weapon.underbarrel == "ubshtgn") {
      if(!scripts\cp\cp_grenade_crate::max_projectile_check(weapon))
        _id_C351B07CFBE3C36E = 0;
    }
  }

  foreach(_id_A025330C35D8D47E in self.powers) {
    if(_id_A025330C35D8D47E.charges < _id_A025330C35D8D47E.maxcharges)
      _id_3BDA1622A11CF39B = 0;
  }

  if(!_id_3BDA1622A11CF39B || !_id_C351B07CFBE3C36E)
    return 1;

  return 0;
}

init_relic_noluck(player) {}

set_relic_noluck(player) {
  player.no_enemy_weapon_drops = 1;
}

unset_relic_noluck(player) {
  player.no_enemy_weapon_drops = undefined;
}

init_relic_laststand(player) {}

set_relic_laststand(player) {
  if(!scripts\engine\utility::array_contains(level.modifyplayerdamage_relics, ::relic_laststand_modifyplayerdamage))
    level.modifyplayerdamage_relics = scripts\engine\utility::array_add(level.modifyplayerdamage_relics, ::relic_laststand_modifyplayerdamage);
}

unset_relic_laststand(player) {
  level.modifyplayerdamage_relics = scripts\engine\utility::array_remove(level.modifyplayerdamage_relics, ::relic_laststand_modifyplayerdamage);
}

relic_laststand_modifyplayerdamage(victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc) {
  damage_multiplier = 1;

  if(isDefined(eattacker) && isPlayer(eattacker)) {
    foreach(player in level.players) {
      if(isDefined(player) && _id_0AFB7E332AEE4BF2::player_in_laststand(player))
        damage_multiplier++;
    }
  }

  _id_039B044B5C4BFBE5 = int(idamage * damage_multiplier);
  return _id_039B044B5C4BFBE5;
}

init_relic_doomslayer(player) {}

set_relic_doomslayer(player) {
  player.ondamagerelics["relic_doomslayer"] = 1;
  player.no_enemy_weapon_drops = 1;
}

unset_relic_doomslayer(player) {
  player.ondamagerelics["relic_doomslayer"] = 0;
  player.no_enemy_weapon_drops = 0;
}

ondamagerelicdoomslayer(player, weapon, victim, meansofdeath, shitloc, time) {
  level endon("game_ended");
  player endon("disconnect");

  if(!isDefined(player) || !isalive(player)) {
    return;
  }
  if(isDefined(meansofdeath) && (meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_EXECUTION"))
    player.no_enemy_weapon_drops = 0;
  else
    player.no_enemy_weapon_drops = 1;
}

init_relic_rocket_kill_ammo(player) {}

set_relic_rocket_kill_ammo(player) {
  player.onkillrelics["relic_rocket_kill_ammo"] = 1;
  level.explosivedamagemod = 0.4;
  self.perk_data["friendly_explosive_damage_reduction"] = 0.1;
}

unset_relic_rocket_kill_ammo(player) {
  player.onkillrelics["relic_rocket_kill_ammo"] = 0;
  player setclientomnvar("ui_cp_relic_ammo_reward", 0);
  level.explosivedamagemod = undefined;
  self.perk_data["friendly_explosive_damage_reduction"] = undefined;
}

handlerocketkillsgiverockets(weapon, player, victim, meansofdeath, shitloc, time) {
  level endon("game_ended");
  player endon("disconnect");

  if(!isDefined(player) || !isalive(player)) {
    return;
  }
  if(!isDefined(weapon) || _id_25845ACA699D038D::_id_E20F17E2A9D0C792(meansofdeath) == 0) {
    return;
  }
  if(_id_25845ACA699D038D::_id_E20F17E2A9D0C792(meansofdeath)) {
    if(player.currentweapon.type == "projectile")
      weapon = player.currentweapon.basename;
    else if(player.currentweapon.type != "projectile" && player.weaponlist[0].type == "projectile")
      weapon = player.weaponlist[0].basename;
    else if(player.currentweapon.type != "projectile" && player.weaponlist[1].type == "projectile")
      weapon = player.weaponlist[1].basename;
  }

  _id_2CFF6B48EEA96941 = player getammocount(weapon);
  _id_C56BBE615F626CC8 = weaponclipsize(weapon);
  player setweaponammoclip(weapon, _id_C56BBE615F626CC8);
  player setweaponammostock(weapon, _id_2CFF6B48EEA96941 - _id_C56BBE615F626CC8 + 1);
  player relic_bullet_reward_hud_display(_id_C56BBE615F626CC8);
}

init_relic_headbullets(player) {}

set_relic_headbullets(player) {
  player.onkillrelics["relic_headbullets"] = 1;
}

unset_relic_headbullets(player) {
  player.onkillrelics["relic_headbullets"] = 0;
  player setclientomnvar("ui_cp_relic_ammo_reward", 0);
}

handleheadshotkillrewardbullets(weapon, player, victim, meansofdeath, shitloc, time) {
  level endon("game_ended");
  player endon("disconnect");

  if(!isDefined(player) || !isalive(player)) {
    return;
  }
  if(!scripts\cp\utility::isheadshot(weapon, shitloc, meansofdeath, player)) {
    return;
  }
  if(!isDefined(weapon) || weapontype(weapon) != "bullet" || !player hasweapon(weapon)) {
    return;
  }
  while(player isreloading())
    wait 0.05;

  _id_C56BBE615F626CC8 = weaponclipsize(weapon);
  _id_98C0435FAAF14D2D = int(_id_C56BBE615F626CC8 * 0.25);
  _id_98C0435FAAF14D2D = int(clamp(_id_98C0435FAAF14D2D, 1, 10));
  player thread relic_award_bullets(weapon, _id_98C0435FAAF14D2D);
}

_id_43474778D36C627B() {
  level endon("game_ended");
  _id_C861C37E30CDE168(::_id_DD919137E61B4DC9);
  _id_12E2FB553EC1605E::_id_E2D370937C694C58("iw9_dm_xmike2010_mp", ["silencer", "laser"], "iw9_pi_decho_mp", ["silencer", "laserpstl_ads01"]);
  level scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::_id_A18D22B26D61CA19);
  wait 0.05;
  level._id_49CB48689488EF07 = level._id_5966C39CB60075F1;
  level._id_5966C39CB60075F1 = ::_id_A430C30ECADEDCFE;
  wait 0.05;
  scripts\cp\utility::_id_C0D2C91F2688ECE4(0, 1);
  level._id_317452953C148027 = undefined;
  level._id_AD799295A6692B29 = 1;
  level._id_0E1A563FAB1E2EEC = 1;
  level._id_71AFB87754F28AF8 = ::_id_614DE4F5A6A2452F;
}

_id_DD919137E61B4DC9(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  if(is_relic_active("relic_oneInTheChamber") && isPlayer(eattacker)) {
    isjuggernaut = isDefined(self.unittype) && self.unittype == "juggernaut";
    eattacker _id_5762AC2F22202BA2::hudicontype("br_ammo");
    eattacker playsoundtoplayer("scavenger_pack_pickup", eattacker);

    if(getdvarint("dvar_2C3CC4B994E1477C", 1)) {
      if(self isinexecutionvictim())
        eattacker._id_FE05A02FC63ECA30 = eattacker._id_FE05A02FC63ECA30 + 2;
      else if(scripts\cp\utility::isheadshot(objweapon, shitloc, smeansofdeath, eattacker))
        eattacker._id_FE05A02FC63ECA30++;
    }

    modifier = 1;

    if(isjuggernaut)
      modifier = getdvarint("dvar_0D1D9818A5D516C6", level.players.size + 1);

    if(getdvarint("dvar_C0834DB3C7F1DE7F", 1)) {
      if(isjuggernaut) {
        self.armorhealth = self.armorhealth - int(self._id_8790C077C95DB752 / modifier);
        self.helmethealth = self.helmethealth - int(self._id_CFC69E5588A5BED6 / modifier);
      } else {
        self.armorhealth = 0;
        self.helmethealth = undefined;
      }
    }

    return int(self.maxhealth / modifier);
  } else
    return idamage;
}

_id_78E009B52B565FF5(player) {
  player thread _id_0145297F3E93394E();
  player scripts\cp\utility::_id_4CBAED764C116A25(1);
  player._id_FE05A02FC63ECA30 = 1;
}

_id_A430C30ECADEDCFE() {
  self endon("disconnect");
  waitframe();
  self.perk_data["weapons_have_full_ammo"] = undefined;
  _id_66122A002AFF5D57::br_ammo_player_clear();
  weapons = self.primaryweapons;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < weapons.size; _id_AC0E594AC96AA3A8++) {
    self setweaponammoclip(weapons[_id_AC0E594AC96AA3A8], 1);
    _id_811ABFDB6C33F17F = _id_66122A002AFF5D57::br_ammo_type_for_weapon(weapons[_id_AC0E594AC96AA3A8]);
    _id_66122A002AFF5D57::br_ammo_give_type(self, _id_811ABFDB6C33F17F, 0, 0, 1);
  }

  if(isDefined(level._id_49CB48689488EF07))
    self[[level._id_49CB48689488EF07]]();
}

_id_78D22D7754B8A60D(player) {
  player.onkillrelics["relic_oneInTheChamber"] = 1;
}

_id_A18D22B26D61CA19() {
  _id_3B64EB40368C1450::set("OITC", "weapon_switch_clip", 0);
  self unsetperk("specialty_pistoldraw", 1);
}

_id_1BD55BD951802EDA(player) {
  player.onkillrelics["relic_oneInTheChamber"] = 0;
  player scripts\cp\utility::_id_4CBAED764C116A25(0);
  player _id_3B64EB40368C1450::set("OITC", "weapon_switch_clip", 1);
  player setperk("specialty_pistoldraw", 1);
  player notify("unset_one_in_the_chamber");

  if(isDefined(level._id_49CB48689488EF07)) {
    level._id_5966C39CB60075F1 = level._id_49CB48689488EF07;
    level._id_49CB48689488EF07 = undefined;
  }

  _id_6C47231521C88E7A(::_id_DD919137E61B4DC9);
}

_id_0145297F3E93394E() {
  self endon("unset_one_in_the_chamber");
  self endon("disconnect");

  for(;;) {
    self waittill("weapon_taken", _id_5E7231028B58C498);
    self setweaponammoclip(_id_5E7231028B58C498, 1);
    _id_811ABFDB6C33F17F = _id_66122A002AFF5D57::br_ammo_type_for_weapon(_id_5E7231028B58C498);
    _id_66122A002AFF5D57::br_ammo_give_type(self, _id_811ABFDB6C33F17F, 0, 0, 1);
  }
}

_id_3A051D1FD67AE155(sweapon, player, victim, smeansofdeath, shitloc, time) {
  weapon = player.currentprimaryweapon;

  if(smeansofdeath == "MOD_EXECUTION") {
    if(!_id_74502A9E0EF1F19C::isdroppableweapon(weapon))
      weapon = player.lastdroppableweaponobj;
  }

  clip = player getweaponammoclip(weapon);
  player setweaponammoclip(weapon, clip + player._id_FE05A02FC63ECA30);
  player relic_bullet_reward_hud_display(player._id_FE05A02FC63ECA30);
  player._id_FE05A02FC63ECA30 = 1;
}

_id_C72FF7743EC64985(player, weapon, victim) {
  test = 1;
}

init_relic_punchbullets(player) {}

set_relic_punchbullets(player) {
  player.onkillrelics["relic_punchbullets"] = 1;
  player thread relic_punchbullets_track_previous_bullet_weapon();
}

unset_relic_punchbullets(player) {
  player.onkillrelics["relic_punchbullets"] = 0;
  player setclientomnvar("ui_cp_relic_ammo_reward", 0);
  player notify("relic_punchbullets_ender");
  player.previous_bullet_weapon = undefined;
}

relic_punchbullets_fire_fists() {
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
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

relic_punchbullets_track_previous_bullet_weapon() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("relic_punchbullets_ender");

  for(;;) {
    weapon = self getcurrentweapon();

    if(isDefined(weapon) && weapontype(weapon) == "bullet")
      self.previous_bullet_weapon = weapon;
    else if(isDefined(self.previous_bullet_weapon) && !self hasweapon(self.previous_bullet_weapon))
      self.previous_bullet_weapon = undefined;

    self waittill("weapon_change");
  }
}

handlemeleekillrewardbullets(weapon, player, victim, meansofdeath, shitloc, time) {
  level endon("game_ended");
  player endon("death_or_disconnect");

  if(!isDefined(player) || !isalive(player)) {
    return;
  }
  if(!isDefined(meansofdeath) || meansofdeath != "MOD_MELEE" && meansofdeath != "MOD_EXECUTION") {
    return;
  }
  if(meansofdeath == "MOD_EXECUTION" && isDefined(player.previous_bullet_weapon))
    weapon = player.previous_bullet_weapon;

  if(!isDefined(weapon) || weapontype(weapon) != "bullet" || !player hasweapon(weapon)) {
    return;
  }
  while(player isreloading())
    wait 0.05;

  _id_C56BBE615F626CC8 = weaponclipsize(weapon);
  _id_98C0435FAAF14D2D = int(_id_C56BBE615F626CC8 * 0.25);
  _id_98C0435FAAF14D2D = int(clamp(_id_98C0435FAAF14D2D, 1, 10));
  player thread relic_award_bullets(weapon, _id_98C0435FAAF14D2D);
}

relic_award_bullets(weapon, _id_98C0435FAAF14D2D, _id_356362F791136AB4) {
  level endon("game_ended");
  self endon("disconnect");
  player = self;
  wait 0.75;

  if(!isDefined(weapon) || weapontype(weapon) != "bullet" || !player hasweapon(weapon)) {
    return;
  }
  if(!isDefined(_id_356362F791136AB4))
    _id_356362F791136AB4 = 1;

  _id_B83E926DFDBC7AA2 = is_relic_active("relic_oneclip");
  _id_8529009219E1AD48 = weaponclipsize(weapon);
  has_ammo = player getweaponammoclip(weapon);

  if(!istrue(_id_B83E926DFDBC7AA2)) {
    _id_8529009219E1AD48 = _id_8529009219E1AD48 + weaponmaxammo(weapon);
    has_ammo = has_ammo + player getweaponammostock(weapon);
  }

  _id_98C0435FAAF14D2D = int(min(_id_8529009219E1AD48 - has_ammo, _id_98C0435FAAF14D2D));

  if(_id_98C0435FAAF14D2D == 0) {
    return;
  }
  _id_471D039E2F07D3D8 = player getcurrentweapon() == weapon || player isinexecutionattack();

  if(_id_471D039E2F07D3D8)
    player thread relic_bullet_reward_hud_display(_id_98C0435FAAF14D2D);

  if(_id_471D039E2F07D3D8 && _id_356362F791136AB4) {
    while(_id_98C0435FAAF14D2D > 0) {
      result = player thread relic_award_one_bullet(weapon, _id_B83E926DFDBC7AA2);

      if(istrue(result))
        player notify("ammo_awarded");
      else
        break;

      wait 0.2;
      _id_98C0435FAAF14D2D--;
    }
  } else {
    _id_C56BBE615F626CC8 = weaponclipsize(weapon);
    _id_A153D989920D03BC = player getweaponammoclip(weapon);
    _id_B565C7BCFD7B0438 = _id_C56BBE615F626CC8 - _id_A153D989920D03BC;

    if(_id_B565C7BCFD7B0438 >= _id_98C0435FAAF14D2D)
      player setweaponammoclip(weapon, _id_A153D989920D03BC + _id_98C0435FAAF14D2D);
    else {
      player setweaponammoclip(weapon, _id_C56BBE615F626CC8);

      if(!istrue(_id_B83E926DFDBC7AA2)) {
        _id_0A862B844906A7C8 = weaponmaxammo(weapon);
        _id_02422F12C129670C = player getweaponammostock(weapon);
        _id_98C0435FAAF14D2D = _id_98C0435FAAF14D2D - _id_B565C7BCFD7B0438;
        _id_749FFCD446F2CFA0 = int(min(_id_0A862B844906A7C8, _id_02422F12C129670C + _id_98C0435FAAF14D2D));
        player setweaponammostock(weapon, _id_749FFCD446F2CFA0);
      }
    }

    player notify("ammo_awarded");
  }
}

relic_award_one_bullet(weapon, _id_B83E926DFDBC7AA2) {
  player = self;

  if(!isDefined(weapon) || weapontype(weapon) != "bullet" || !player hasweapon(weapon)) {
    return;
  }
  _id_A153D989920D03BC = player getweaponammoclip(weapon);

  if(istrue(_id_B83E926DFDBC7AA2) || _id_A153D989920D03BC < weaponclipsize(weapon)) {
    player setweaponammoclip(weapon, _id_A153D989920D03BC + 1);
    player playlocalsound("weap_ammo_pickup");
    return 1;
  } else {
    _id_02422F12C129670C = player getweaponammostock(weapon);

    if(_id_02422F12C129670C < weaponmaxammo(weapon)) {
      player setweaponammostock(weapon, _id_02422F12C129670C + 1);
      player playlocalsound("weap_ammo_pickup");
      return 1;
    }
  }

  return 0;
}

relic_bullet_reward_hud_display(_id_98C0435FAAF14D2D) {
  self notify("relic_punchbullets_reward_hud_display");
  self endon("relic_punchbullets_reward_hud_display");
  self endon("disconnect");
  level endon("game_ended");
  self setclientomnvar("ui_cp_relic_ammo_reward", 0);
  wait 0.25;
  self setclientomnvar("ui_cp_relic_ammo_reward", _id_98C0435FAAF14D2D);
  wait 1.75;
  self setclientomnvar("ui_cp_relic_ammo_reward", 0);
}

init_relic_steelballs(player) {}

set_relic_steelballs(player) {
  player.onkillrelics["relic_steelballs"] = 1;
  player.ondamagerelics["relic_steelballs"] = 1;
  player thread relic_steelballs_dash();
  player thread relic_steelballs_slide();
  player thread relic_steelballs_stump();
  player thread set_relic_steelballs_perks(player);
}

set_relic_steelballs_perks(player) {
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  _id_0092814129F0F670 = player.origin;

  while(player.origin == _id_0092814129F0F670)
    wait 0.25;

  player scripts\cp\utility::giveperk("specialty_extendedMelee");
  player scripts\cp\utility::giveperk("specialty_hardmelee");
  wait 0.05;
  player.perk_data["melee_scalar"] = 3;
}

unset_relic_steelballs(player) {
  player scripts\cp\perks\cp_perks::removeperk("specialty_extendedMelee");
  player scripts\cp\perks\cp_perks::removeperk("specialty_hardmelee");
  player.onkillrelics["relic_steelballs"] = 0;
  player.ondamagerelics["relic_steelballs"] = 0;

  if(isDefined(player.slide_trig))
    player.slide_trig delete();

  player notify("relic_steelballs_ender");
}

handlemeleekillsteelballs(weapon, player, victim, meansofdeath, shitloc, time) {
  if(!isDefined(player) || !isalive(player)) {
    return;
  }
  if(!isDefined(meansofdeath) || meansofdeath != "MOD_MELEE") {
    return;
  }
  player thread relic_steelballs_health_boost();
  player playSound("gib_fullbody");
}

ondamagerelicsteelballs(player, weapon, victim, meansofdeath, shitloc, time) {
  if(!isDefined(victim)) {
    return;
  }
  victim.forceexplosivedeath = undefined;
  victim.shouldhelmetpop = undefined;

  if(isDefined(victim.original_disablelongdeath))
    victim._id_98ADD129A7ECB962 = victim._id_56ADA34122C13F70;

  if(!isDefined(player) || !isalive(player)) {
    return;
  }
  if(!isDefined(meansofdeath) || meansofdeath != "MOD_MELEE") {
    return;
  }
  victim.forceexplosivedeath = 1;
  victim.shouldhelmetpop = 1;
  victim._id_56ADA34122C13F70 = victim._id_98ADD129A7ECB962;
  victim._id_98ADD129A7ECB962 = 0;
}

relic_steelballs_health_boost() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  player = self;
  _id_916912DFCF4BCBB4 = clamp(self.health + 90, 0, self.maxhealth);
  _id_25845ACA699D038D::set_normalhealth(_id_916912DFCF4BCBB4 / self.maxhealth);
}

relic_steelballs_slide() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("relic_steelballs_ender");

  while(!isDefined(self.model) || self.model == "")
    wait 0.05;

  wait 1;
  pos = self gettagorigin("j_ball_le");
  slide_trig = spawn("trigger_radius", pos, 0, 32, 48);
  slide_trig enablelinkTo();
  slide_trig linkTo(self, "j_ball_le", (0, 0, 0), (0, 0, 0));
  self.slide_trig = slide_trig;
  slide_trig endon("death");

  for(;;) {
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

relic_steelballs_dodamage(victim, player, _id_AEF81D3EA261589A, _id_C3B50B04C7DCA6A8) {
  victim.explosivemodoverride = 1;
  victim.shouldhelmetpop = 1;
  original_health = victim.health;
  radiusdamage(victim.origin + (0, 0, 8), _id_AEF81D3EA261589A, _id_C3B50B04C7DCA6A8, _id_C3B50B04C7DCA6A8 - 1, player, "MOD_MELEE");
  player.lasthitmarkertime = undefined;
  player _id_354C862768CFE202::updatedamagefeedback("hitcritical");
}

relic_steelballs_dash() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("relic_steelballs_ender");

  for(;;) {
    self waittill("melee_swipe_start");
    _id_B0CC4A040611C3A9 = 250;
    _id_CFB60F884591DAD1 = anglesToForward(self getplayerangles(1));
    enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    closestenemies = scripts\engine\utility::get_array_of_closest(self.origin, enemies, undefined, undefined, 128);

    if(isDefined(closestenemies) && closestenemies.size > 0) {
      victim = closestenemies[0];
      _id_B16FE075D78158C7 = victim getEye() - (0, 0, 12);
      is_looking_at = self worldpointinreticle_circle(_id_B16FE075D78158C7, 70, 300);
      _id_A49FE39FE684C761 = sighttracepassed(victim getEye(), self getEye(), 0, victim);

      if(is_looking_at && _id_A49FE39FE684C761) {
        _id_CFB60F884591DAD1 = scripts\engine\utility::flatten_vector(victim.origin - self.origin);
        _id_B0CC4A040611C3A9 = 350;
      } else {}
    }

    self knockback(_id_CFB60F884591DAD1, _id_B0CC4A040611C3A9);
    wait 0.5;
  }
}

relic_steelballs_stump() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("relic_steelballs_ender");
  childthread relic_steelballs_stump_monitor();

  for(;;) {
    self waittill("stump_damage", _id_2CF70ACA23622FDD, _id_20520E06DC84DF35, _id_D148813AD40029C9);
    radiusdamage(self.origin, 64, 150, 149, self, "MOD_MELEE");
    playFX(level._effect["stump_landing"], self.origin);
    self playRumbleOnEntity("artillery_rumble");
    playrumbleonposition("slide_collision", self.origin);
    earthquake(0.5, 1.5, self.origin, 100);
  }
}

relic_steelballs_stump_monitor() {
  for(;;) {
    while(self isonground())
      wait 0.05;

    _id_1E54F25462D06DE1 = gettime();
    _id_20520E06DC84DF35 = self.origin[2];

    while(!self isonground()) {
      if(self.origin[2] > _id_20520E06DC84DF35)
        _id_20520E06DC84DF35 = self.origin[2];

      wait 0.05;
    }

    _id_D148813AD40029C9 = max(0, _id_20520E06DC84DF35 - self.origin[2]);

    if(_id_D148813AD40029C9 < 128) {
      continue;
    }
    _id_2CF70ACA23622FDD = (gettime() - _id_1E54F25462D06DE1) / 1000;
    self notify("stump_damage", _id_2CF70ACA23622FDD, _id_20520E06DC84DF35, _id_D148813AD40029C9);
  }
}

init_relic_oneclip(player) {}

set_relic_oneclip(player) {
  player thread relic_oneclip_monitor();
}

unset_relic_oneclip(player) {
  player notify("set_relic_oneclip_ender");
  player setclientomnvar("ui_cp_relic_ammo_reward", 0);
}

relic_oneclip_monitor() {
  self endon("death_or_disconnect");
  self endon("set_relic_oneclip_ender");
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  wait 0.5;
  thread relic_oneclip_stock_adjustment_monitor();

  for(;;) {
    _id_2622298F62890966 = self getweaponslistprimaries();

    foreach(weapon in _id_2622298F62890966) {
      if(!isDefined(weapon) || weapontype(weapon) != "bullet") {
        continue;
      }
      stock_ammo = self getweaponammostock(weapon);

      if(stock_ammo > 0) {
        _id_C56BBE615F626CC8 = weaponclipsize(weapon);
        clip_ammo = self getweaponammoclip(weapon);

        if(clip_ammo < _id_C56BBE615F626CC8) {
          _id_593414C56F149A50 = int(min(_id_C56BBE615F626CC8, clip_ammo + stock_ammo));
          thread relic_award_bullets(weapon, _id_593414C56F149A50 - clip_ammo);
        }

        self setweaponammostock(weapon, 0);
      }
    }

    scripts\engine\utility::waittill_any_5("ammo_pickup", "weapon_change", "weapon_swap", "ammo_awarded", "ammo_stock_not_empty");
  }
}

relic_oneclip_stock_adjustment_monitor() {
  self endon("death_or_disconnect");
  self endon("set_relic_oneclip_ender");

  for(;;) {
    wait 0.05;
    weapon = self getcurrentweapon();

    if(!isDefined(weapon) || weapontype(weapon) != "bullet") {
      continue;
    }
    if(self getweaponammostock(weapon) > 0)
      self notify("ammo_stock_not_empty");
  }
}

init_relic_grounded(player) {}

set_relic_grounded(player) {
  player thread relic_grounded_reload_monitor();
}

relic_grounded_reload_monitor() {
  self endon("death_or_disconnect");
  self endon("set_relic_grounded_ender");

  for(;;) {
    self waittill("reload_start");
    weapon = self getcurrentweapon();

    if(!isDefined(weapon) || weapontype(weapon) != "bullet") {
      continue;
    }
    _id_A153D989920D03BC = self getweaponammoclip(weapon);
    self setweaponammoclip(weapon, 0);
    _id_02422F12C129670C = self getweaponammostock(weapon);

    while(_id_02422F12C129670C == self getweaponammostock(weapon)) {
      if(!self hasweapon(weapon)) {
        break;
      }

      if(!self isreloading() || self getcurrentweapon() != weapon) {
        self setweaponammoclip(weapon, _id_A153D989920D03BC);
        break;
      }

      wait 0.05;
    }
  }
}

unset_relic_grounded(player) {
  player notify("set_relic_grounded_ender");
}

init_relic_nobulletdamage(player) {
  _id_C861C37E30CDE168(::relic_nobulletdamage_modifyplayerdamage);
}

set_relic_nobulletdamage(player) {
  player.ondamagerelics["relic_nobulletdamage"] = 1;
}

unset_relic_nobulletdamage(player) {
  player.ondamagerelics["relic_nobulletdamage"] = 0;
}

relic_nobulletdamage_modifyplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  victim = self;

  if(!isDefined(eattacker))
    return idamage;

  if(!isent(eattacker))
    return idamage;

  if(isDefined(eattacker.owner)) {
    if(!isPlayer(eattacker.owner))
      return idamage;
  }

  if(!isPlayer(eattacker))
    return idamage;

  _id_A3192D2F80ED4FF8 = scripts\engine\utility::isbulletdamage(smeansofdeath) || smeansofdeath == "MOD_EXPLOSIVE_BULLET" && shitloc != "none";

  if(_id_A3192D2F80ED4FF8) {
    if(istrue(objweapon.isdragonsbreath))
      _id_A3192D2F80ED4FF8 = 0;
  }

  if(isPlayer(eattacker) && isai(victim)) {
    if(!_id_A3192D2F80ED4FF8)
      return idamage;
    else {
      eattacker thread _id_354C862768CFE202::updatedamagefeedback("hitnobulletdamage");
      return 0;
    }
  } else
    return idamage;
}

init_relic_trex(player) {
  level.persistentrelics["relic_trex"] = ::handletrex;
}

set_relic_trex(player) {
  player.persistentrelics["relic_trex"] = 1;
}

unset_relic_trex(player) {
  player.persistentrelics["relic_trex"] = 0;
}

handletrex(player) {
  self notify("handleTRex");
  self endon("handleTRex");
  self endon("stop_trex");
  level endon("game_ended");

  for(;;) {
    wait 0.05;

    if(!can_trex_apply_to_player(player)) {
      continue;
    }
    _id_87E06701670C4F0E = player getvelocity();
    speed = length(_id_87E06701670C4F0E);

    if(speed < 5) {
      player scripts\cp\utility::allow_player_ignore_me(1);
      player.bistrexactive = 1;
      player thread check_for_trexremoval(player);
    }
  }
}

check_for_trexremoval(player) {
  self notify("check_for_TrexRemoval");
  self endon("check_for_TrexRemoval");

  for(;;) {
    waitframe();
    _id_87E06701670C4F0E = player getvelocity();
    speed = length(_id_87E06701670C4F0E);

    if(speed >= 5) {
      player scripts\cp\utility::allow_player_ignore_me(0);
      player.bistrexactive = undefined;
      break;
    }
  }
}

can_trex_apply_to_player(player) {
  if(istrue(player.inlaststand))
    return 0;

  if(istrue(player.bistrexactive))
    return 0;

  return 1;
}

init_relic_ammo_drain(player) {
  player.has_ammo_drain_passive = 0;
}

set_relic_ammo_drain(player) {
  player.has_ammo_drain_passive = 1;
  player thread relic_ammo_drain_take_ammo();
}

unset_relic_ammo_drain(player) {
  player.has_ammo_drain_passive = 0;
  player notify("stop_ammo_drain");
}

relic_ammo_drain_take_ammo() {
  level endon("game_ended");
  self endon("stop_ammo_drain");

  for(;;) {
    if(!scripts\cp\utility::is_valid_player()) {
      wait 1;
      continue;
    }

    weapon = self getcurrentprimaryweapon();

    if(!isDefined(weapon)) {
      wait 1;
      continue;
    }

    fail = 0;
    _id_1903A4E1B4C39DE1 = weaponclipsize(weapon);

    if(!isDefined(_id_1903A4E1B4C39DE1))
      _id_1903A4E1B4C39DE1 = 22.5;

    if(_id_1903A4E1B4C39DE1 < 1)
      _id_1903A4E1B4C39DE1 = 22.5;

    if(weapontype(weapon) == "riotshield")
      fail = 1;

    if(istrue(weapon.ismelee))
      fail = 1;

    if(isDefined(weapon.classname)) {
      if(weapon.classname == "none")
        fail = 1;

      if(weapon.classname == "grenade")
        fail = 1;

      if(weapon.classname == "rocketlauncher")
        fail = 1;
    }

    if(self isreloading())
      fail = 1;

    if(_id_74502A9E0EF1F19C::is_incompatible_weapon(weapon))
      fail = 1;

    if(!fail) {
      if(isDefined(self.last_weapon) && self.last_weapon == weapon) {
        if(weapon.inventorytype == "altmode") {
          if(isDefined(weapon.underbarrel) && weapon.underbarrel == "ubshtgn") {
            _id_337043BBA3301B3C = self getweaponammoclip(weapon);
            _id_4D0726F4DA08B500 = int(max(0, _id_337043BBA3301B3C - 1));
            self setweaponammoclip(weapon, _id_4D0726F4DA08B500);
            self setweaponammostock(weapon, 0);
            self notify("ammo_drained");
            thread relic_bullet_reward_hud_display(-1);
            break;
          }
        } else {
          if(weapon._id_318338AA880DFAC6) {
            leftclip = self getweaponammoclip(weapon, "left");
            rightclip = self getweaponammoclip(weapon, "right");

            if(!isDefined(self.last_akimbo_ammo_taken))
              self.last_akimbo_ammo_taken = "left";

            if(self.last_akimbo_ammo_taken == "left") {
              _id_4D0726F4DA08B500 = int(max(0, leftclip - 1));
              self setweaponammoclip(weapon, _id_4D0726F4DA08B500, "left");
              self.last_akimbo_ammo_taken = "right";
            } else {
              _id_4D0726F4DA08B500 = int(max(0, rightclip - 1));
              self setweaponammoclip(weapon, _id_4D0726F4DA08B500, "right");
              self.last_akimbo_ammo_taken = "left";
            }
          } else {
            _id_337043BBA3301B3C = self getweaponammoclip(weapon);
            _id_4D0726F4DA08B500 = int(max(0, _id_337043BBA3301B3C - 1));
            self setweaponammoclip(weapon, _id_4D0726F4DA08B500);
          }

          self notify("ammo_drained");
          thread relic_bullet_reward_hud_display(-1);
        }
      }

      wait_time = max(45 / _id_1903A4E1B4C39DE1, 0.4);
      self.last_weapon = weapon;
      scripts\engine\utility::waittill_any_timeout_1(wait_time, "weapon_change");
      continue;
    }

    wait 1;
  }
}

init_relic_dogtags(player) {}

set_relic_dogtags(player) {
  level.relic_dogtags = 1;
  level.disable_hotjoin_via_ac130 = 1;
  level.dogtag_revive = 1;
}

unset_relic_dogtags(player) {
  level.relic_dogtags = 0;
  level.disable_hotjoin_via_ac130 = 0;
  level.dogtag_revive = 0;
}

init_relic_laststandmelee(player) {}

set_relic_laststandmelee(player) {
  _id_3184653FDF31DB44 = _id_2669878CF5A1B6BC::buildweapon("iw9_me_fists_mp", [], "none", "none", -1);
  player.forced_laststand_weapon = _id_3184653FDF31DB44;
}

unset_relic_laststandmelee(player) {
  player.forced_laststand_weapon = undefined;
}

init_relic_fastbleedout(player) {}

set_relic_fastbleedout(player) {
  level.get_bleed_out_time = ::relic_fastbleedout_returnfunc;
}

relic_fastbleedout_returnfunc() {
  return 7;
}

unset_relic_fastbleedout(player) {
  level.get_bleed_out_time = undefined;
}

init_relic_nuketimer(player) {}

set_relic_nuketimer(player) {
  level thread relic_nuketimer_globalthread();
}

unset_relic_nuketimer(player) {
  level notify("relic_nuketimer_end");
}

relic_nuketimer_globalthread() {
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
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  wait 0.5;
  _id_6C0983906BC06EAA = "safehouse_door_opened";
  _id_90ED145EFA706EDD = "obj_extract_informant_started";
  _id_2F04724AFC0DBC44 = "players_go_to_safehouse";
  _id_D9D3000B553FA249 = 60;
  _id_160F83E240EB105F = "player_entered_safehouse_vol";
  mapname = tolower(getDvar("mapname"));

  switch (mapname) {
    case "cp_hydro":
      _id_6C0983906BC06EAA = "hydro_fire_early";
      level thread scripts\cp\utility::notify_delay(_id_6C0983906BC06EAA, 10);
      break;
    case "cp_scaletest":
      _id_6C0983906BC06EAA = "scaletest_fire_early";
      level thread scripts\cp\utility::notify_delay(_id_6C0983906BC06EAA, 10);
      break;
    case "cp_smuggler":
      level.relic_nuketimer.failstringsetup = 1;
      _id_6C0983906BC06EAA = "safehouse_door_opened";
      _id_90ED145EFA706EDD = "obj_extract_informant_started";
      _id_2F04724AFC0DBC44 = "players_go_to_safehouse";
      _id_D9D3000B553FA249 = 60;
      _id_160F83E240EB105F = "player_entered_safehouse_vol";
      checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

      if(isDefined(checkpoint) && checkpoint == "tow_p1") {
        _id_6C0983906BC06EAA = "smuggler_fire_early";
        level thread scripts\cp\utility::notify_delay(_id_6C0983906BC06EAA, 5);
      }

      break;
  }

  level waittill(_id_6C0983906BC06EAA);
  level thread relic_nuketimer_timer_init();
  level thread relic_nuketimer_waitforobjectives();
  level thread relic_nuketimer_waitforcompleteobjectives(_id_90ED145EFA706EDD, _id_2F04724AFC0DBC44, _id_160F83E240EB105F, _id_D9D3000B553FA249);
  waitframe();
  level waittill("relic_nuke_explode");
  _id_8552241A89A7D70A = level.relic_nuketimer.nuke_clockobject.origin;
  _id_5097873650010998 = spawn("script_model", _id_8552241A89A7D70A);
  _id_5097873650010998 setModel("tag_origin");
  _id_5097873650010998.team = "axis";
  _id_5097873650010998.pers = [];
  _id_5097873650010998.pers["team"] = "axis";
  _id_5097873650010998.owner = _id_5097873650010998;
  streakinfo = _id_5097873650010998 scripts\cp_mp\utility\killstreak_utility::createstreakinfo("nuke", _id_5097873650010998);
  _id_5097873650010998 thread scripts\cp_mp\killstreaks\nuke::nuke_start(streakinfo);
  level waittill("nuke_detonated");
  wait 5;

  if(istrue(level.relic_nuketimer.failstringsetup))
    scripts\cp\cp_objectives::prepare_mission_failed_text("obj_nuke_ending");

  enemies = scripts\cp\cp_agent_utils::getactiveenemyagents("allies");

  foreach(guy in enemies)
  guy suicide();

  foreach(player in level.players)
  player dodamage(player.health + 1000, player.origin, player);

  wait 4;
  _id_31D3B78126C9501E = 0;

  foreach(player in level.players) {
    if(player scripts\cp_mp\utility\player_utility::_isalive())
      _id_31D3B78126C9501E = 1;
  }

  if(_id_31D3B78126C9501E)
    level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
}

relic_nuketimer_timer_init() {
  level endon("game_ended");
  level endon("relic_nuketimer_end");
  level.relic_nuketimer.timeramount = 0;
  level.relic_nuketimer.timeramount = relic_nuketimer_gettimeformission();
  override = getDvar("dvar_F2F901D5DEA53A00", 0);

  if(int(override) > 5)
    level.relic_nuketimer.timeramount = int(override);

  if(soundexists("iw8_nuke_alarm"))
    level.relic_nuketimer.nuke_clockobject playSound("iw8_nuke_alarm");

  level thread relic_nuketimer_timerloop();
}

relic_nuketimer_timerloop() {
  level endon("relic_nuketimer_end");
  setomnvar("ui_nuke_end_milliseconds", gettime() + level.relic_nuketimer.timeramount * 1000);
  setomnvar("ui_nuke_countdown_active", 1);
  setomnvar("ui_nuke_timer_type", 1);

  while(level.relic_nuketimer.timeramount > level.relic_nuketimer.point_of_no_return) {
    if(level.relic_nuketimer.timeramount % 2 == 0 && soundexists("iw8_nuke_countdown"))
      level.relic_nuketimer.nuke_clockobject playSound("iw8_nuke_countdown");

    _id_18F2BB0DD309974C = scripts\cp\utility::getoverlordaliasfortimeleft(level.relic_nuketimer.timeramount - 1, 1);

    if(isDefined(_id_18F2BB0DD309974C))
      level thread _id_166B4F052DA169A7::try_to_play_vo_on_team(_id_18F2BB0DD309974C, "allies");

    level.relic_nuketimer.timeramount = level.relic_nuketimer.timeramount - 1;
    wait 1;
  }

  level.relic_nuketimer.finale = 1;
  level notify("relic_nuke_explode");
}

relic_nuketimer_waitforcompleteobjectives(_id_90ED145EFA706EDD, _id_2F04724AFC0DBC44, _id_160F83E240EB105F, _id_D9D3000B553FA249) {
  level endon("nuke_detonated");
  level waittill(_id_90ED145EFA706EDD);
  level notify("relic_nuketimer_end");
  scripts\cp_mp\killstreaks\nuke::nuke_cancel();
  setomnvar("ui_nuke_countdown_active", 0);

  if(isDefined(_id_2F04724AFC0DBC44) && isDefined(_id_160F83E240EB105F)) {
    if(!isDefined(_id_D9D3000B553FA249))
      _id_D9D3000B553FA249 = 60;

    level waittill(_id_2F04724AFC0DBC44);

    if(level.relic_nuketimer.timeramount > _id_D9D3000B553FA249) {
      level thread relic_nuketimer_timerloop();
      level thread relic_nuketimer_waitforcompleteobjectives(_id_160F83E240EB105F);
    }
  }
}

relic_nuketimer_waitforobjectives() {
  level endon("game_ended");
  level endon("relic_nuketimer_end");

  for(;;) {
    level waittill("give_objective_xp_to_all_players", type);

    if(level.relic_nuketimer.timeramount > level.relic_nuketimer.point_of_no_return + 1) {
      if(type == "stat_B4B6F2BA2523025E")
        relic_nuketimer_addtotimer(15);
      else
        relic_nuketimer_addtotimer(30);

      if(istrue(level.relic_nuketimer.finale)) {
        scripts\cp_mp\killstreaks\nuke::nuke_cancel();
        level.relic_nuketimer.finale = 0;
        waitframe();
        level thread relic_nuketimer_timerloop();
      }
    }
  }
}

relic_nuketimer_addtotimer(_id_811FA87B007B001C) {
  if(level.gameskill < 3)
    _id_811FA87B007B001C = _id_811FA87B007B001C * 2;

  level.relic_nuketimer.timeramount = level.relic_nuketimer.timeramount + _id_811FA87B007B001C;
  setomnvar("ui_nuke_end_milliseconds", gettime() + level.relic_nuketimer.timeramount * 1000);
}

relic_nuketimer_gettimeformission() {
  _id_EE521ED5DDB09C37 = 900;
  mapname = tolower(getDvar("mapname"));

  switch (mapname) {
    case "cp_scaletest":
      _id_EE521ED5DDB09C37 = 80;
      level scripts\engine\utility::delaythread(61, scripts\cp\cp_objectives::give_objective_xp_to_all_players, "stat_B4B6F2BA2523025E");
      break;
    case "cp_smuggler":
      checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

      if(isDefined(checkpoint) && checkpoint == "tow_p1") {
        if(level.gameskill < 3)
          _id_EE521ED5DDB09C37 = 300;
        else
          _id_EE521ED5DDB09C37 = 240;
      } else if(level.gameskill < 3)
        _id_EE521ED5DDB09C37 = 960;
      else
        _id_EE521ED5DDB09C37 = 720;

      break;
  }

  return _id_EE521ED5DDB09C37;
}

init_relic_hideobjicons(player) {}

set_relic_hideobjicons(player) {
  level endon("game_ended");
  level endon("relic_hideobjicons_ender");

  for(;;) {
    level scripts\engine\utility::waittill_any_2("worldObjIDPool_requested", "objective_minimapUpdate");

    foreach(_id_F90358454413407F in level.worldobjidpool.active)
    objective_state(_id_F90358454413407F.objid, "active");
  }
}

unset_relic_hideobjicons(player) {
  level notify("relic_hideobjicons_ender");
}

init_relic_explodedmg(player) {}

set_relic_explodedmg(player) {
  level.explosivedamagemod = 7;
}

unset_relic_explodedmg(player) {
  level.explosivedamagemod = undefined;
}

are_relics_active() {
  if(getDvar("dvar_3D6CC59E7F693916", "") != "")
    return 1;

  if(scripts\cp\utility::is_wave_gametype() || scripts\cp\utility::is_specops_gametype())
    return 0;

  return 0;
}

init_relic_doubletap(player) {}

set_relic_doubletap(player) {
  _id_18A73A64992DD07D::add_global_spawn_function("axis", ::set_relic_doubletap_params);

  foreach(guy in level.spawned_enemies)
  guy set_relic_doubletap_params();
}

unset_relic_doubletap(player) {
  _id_18A73A64992DD07D::remove_global_spawn_function("axis", ::set_relic_doubletap_params);

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

      if(isDefined(guy.a))
        guy.force_num_crawls = 0;
    }
  }
}

set_relic_doubletap_params() {
  thread set_relic_doubletap_params_internal();
}

set_relic_doubletap_params_internal() {
  self endon("death");
  self endon("relic_doubletap_ender");

  if(scripts\cp\utility::isjuggernaut()) {
    return;
  }
  if(isDefined(self.unittype) && self.unittype == "suicidebomber") {
    return;
  }
  original_health = self.health;
  wait 0.05;
  _id_A307EBF5105B3643 = self.weapon;

  if(!isDefined(self.weapon) || !isweapon(self.weapon)) {
    _id_003A9E0157B54BC7 = self getweaponslistprimaries();

    if(isDefined(_id_003A9E0157B54BC7) && _id_003A9E0157B54BC7.size > 0)
      _id_A307EBF5105B3643 = _id_003A9E0157B54BC7[0];
  }

  for(counter = 3; counter > 0; counter--) {
    _id_00E9D23416578C11 = original_health;
    self.health = original_health + _id_00E9D23416578C11;
    meansofdeath = undefined;

    while(_id_00E9D23416578C11 > 0) {
      self waittill("damage", amount, attacker, direction_vec, dmgpoint, meansofdeath);

      if(isDefined(attacker) && isPlayer(attacker))
        _id_00E9D23416578C11 = _id_00E9D23416578C11 - amount;
    }

    if(_id_18A73A64992DD07D::is_riding_vehicle() || istrue(self.playing_skit) || !self._id_98ADD129A7ECB962 || istrue(self.attempting_teleport) || istrue(self.bhasriotshieldattached) || isDefined(meansofdeath) && meansofdeath == "MOD_FIRE" || isDefined(self.script) && (self.script == "scripted" || self.script == "<custom>") || istrue(self._blackboard.animscriptedactive)) {
      self.health = 1;
      return;
    }

    self.invulnerable = 1;
    self.health = 1000;

    if(!isDefined(self.asm.longdeathanims))
      self.asm.longdeathanims = spawnStruct();

    childthread relic_doubletap_helper();
    wait 0.05;
    self asmsetstate(self.asmname, "choose_long_death");
    wait 0.8;
    self.invulnerable = 0;
    self.health = original_health;
    wait 3;
    self notify("kill_long_death");
    self notify("dying_crawl_finished");
    self notify("relic_doubletap_helper_reset");
    self.doinglongdeath = 0;
    scripts\asm\asm::asm_setstate("exposed_prone_to_stand");

    if(!isDefined(_id_A307EBF5105B3643)) {
      _id_003A9E0157B54BC7 = self getweaponslistprimaries();

      if(isDefined(_id_003A9E0157B54BC7) && _id_003A9E0157B54BC7.size > 0)
        _id_A307EBF5105B3643 = _id_003A9E0157B54BC7[0];
    }

    if(isDefined(_id_A307EBF5105B3643)) {
      self takeweapon(_id_A307EBF5105B3643);
      self giveweapon(_id_A307EBF5105B3643);
      _id_3433EE6B63C7E243::forceuseweapon(_id_A307EBF5105B3643, "primary");
    }
  }
}

relic_doubletap_helper() {
  self endon("death");
  self endon("relic_doubletap_ender");
  self endon("relic_doubletap_helper_reset");
  self.force_num_crawls = 3;
  self.skipdyingbackcrawl = 1;
  self.forcelongdeath = 3;
  self.longdeathnoncombat = 1;

  for(;;) {
    self._id_4AD177AB3DDDE8FD = undefined;
    self.desiredtimeofdeath = gettime() + 1000;
    self.bulletsinclip = 0;
    wait 0.05;
  }
}

_id_9CEFAC9CBEB4C8FB(player) {}

_id_F9E166D7D6E08899(player) {
  _id_C861C37E30CDE168(::_id_6918C29091F9933B);

  if(!isDefined(level._id_BF8AA3F39F981625))
    _id_251F071833394C68::_id_2FCE2F81588A2462();

  level._id_BF8AA3F39F981625[level._id_BF8AA3F39F981625.size] = ::_id_E295A6CB67691C7C;
}

_id_6F59F0D90237A7D1(player) {
  player.onkillrelics["relic_werewolf"] = 1;
  player thread _id_D45FD98510D7B7E9();
}

_id_DE81BA7857E0F32E(player) {
  player.onkillrelics["relic_werewolf"] = 0;
}

_id_6918C29091F9933B(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  victim = self;

  if(!isDefined(eattacker))
    return idamage;

  if(!isent(eattacker))
    return idamage;

  if(isDefined(eattacker.owner)) {
    if(!isPlayer(eattacker.owner))
      return idamage;
  }

  if(!isPlayer(eattacker))
    return idamage;

  _id_A3192D2F80ED4FF8 = scripts\engine\utility::isbulletdamage(smeansofdeath) || smeansofdeath == "MOD_EXPLOSIVE_BULLET" && shitloc != "none";
  _id_D3AB98BC63E38BD6 = scripts\engine\utility::ismeleedamage(smeansofdeath);

  if(isPlayer(eattacker) && isai(victim)) {
    if(_id_D3AB98BC63E38BD6) {
      _id_55C126A8463294B0 = idamage * 6;

      if(victim.health <= _id_55C126A8463294B0) {
        _id_ADF3664B12362142 = 350;
        velocity = anglesToForward(victim.angles) * -100;
        victim.do_immediate_ragdoll = 1;
        victim.ragdollhitloc = "torso_upper";
        victim.ragdollimpactvector = (victim.origin - eattacker.origin) * _id_ADF3664B12362142 + velocity;
      }

      if(isDefined(victim.aitype)) {
        if(victim.aitype == "jugg_cartel")
          return _id_55C126A8463294B0 * 25;
        else if(victim.aitype == "boss_velikan")
          return _id_55C126A8463294B0 * 20;
        else {
          if(isDefined(victim.armorhealth))
            victim.armorhealth = 0;

          return _id_55C126A8463294B0;
        }
      }
    }

    if(!_id_A3192D2F80ED4FF8)
      return idamage;

    if(scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, eattacker))
      return idamage;
    else
      return idamage * 0.7;
  } else
    return idamage;
}

_id_954B7F9F643B03A5(sweapon, player, victim, smeansofdeath, shitloc, time) {
  if(smeansofdeath != "MOD_MELEE") {
    return;
  }
  player _id_DBBF64242C92D7C0();

  if(isDefined(player.maxhealth))
    player.health = player.maxhealth;

  if(isDefined(player.armorhealth)) {
    _id_815F2CEE6F7F75CD = player.armorhealth;
    player _id_07C40FA80892A721::_id_AC7803D45979135C(_id_815F2CEE6F7F75CD + 50, 1);
  }

  if(player.weaponpassivespeedonkillmod != 0.2) {
    player _id_AECDB40D562735CC();
    wait 1;
  }

  player scripts\engine\utility::waittill_any_timeout_2(8, "death", "disconnect");

  if(!isDefined(player)) {
    return;
  }
  player _id_3D2AD55F13EB6487();
  player setscriptablepartstate("battleRageVfx", "off", 0);
  player visionsetnakedforplayer("", 0.5);
}

_id_E295A6CB67691C7C() {
  if(isDefined(level._id_6905E4B813093C94))
    self unsetperk("specialty_melee_invulnerable", 1);
}

update_health_on_spawn() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    wait 1;
    thread update_health_think();
  }
}

update_health_think() {
  self endon("disconnect");
  self endon("death");
  broadcast_health(self);

  for(;;) {
    self.old_health = self.health;
    self.old_maxhealth = self.maxhealth;
    wait 0.1;

    if(self.health != self.old_health || self.maxhealth != self.old_maxhealth)
      broadcast_health(self);
  }
}

broadcast_health(player) {
  _id_1DAB4A6BAD01C509 = player getentitynumber();
  playerhealth = int(player.health);
  playermaxhealth = player.maxhealth;

  if(istrue(player.inlaststand))
    health = 0;

  _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "playerMaxHealth", playermaxhealth);
  _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "playerHealth", playerhealth);
}

_id_C861C37E30CDE168(callback) {
  if(!isDefined(level._id_6905E4B813093C94))
    level._id_6905E4B813093C94 = [];

  level._id_6905E4B813093C94[level._id_6905E4B813093C94.size] = callback;
}

_id_6C47231521C88E7A(_id_99B0CBEEC73DD75D) {
  _id_6D906809844C7CB1 = [];

  foreach(callback in level._id_6905E4B813093C94) {
    if(_id_99B0CBEEC73DD75D != callback)
      _id_6D906809844C7CB1[_id_6D906809844C7CB1.size] = callback;
  }

  level._id_6905E4B813093C94 = _id_6D906809844C7CB1;
}

_id_CA2CB402BF88A284(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  foreach(callback in level._id_6905E4B813093C94)
  idamage = self[[callback]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);

  return idamage;
}

_id_AECDB40D562735CC() {
  scripts\cp\utility::giveperk("specialty_tac_resist");
  scripts\cp\utility::giveperk("specialty_stalker");
  scripts\cp\utility::giveperk("specialty_hustle");
  scripts\cp\utility::giveperk("specialty_quick_revive");
}

_id_3D2AD55F13EB6487() {
  _id_6E09A830FAB9468F::removeperk("specialty_tac_resist");
  _id_6E09A830FAB9468F::removeperk("specialty_hustle");
  _id_6E09A830FAB9468F::removeperk("specialty_stalker");
  _id_6E09A830FAB9468F::removeperk("specialty_fastreload");
  _id_6E09A830FAB9468F::removeperk("specialty_tactical_recon");
  _id_6E09A830FAB9468F::removeperk("specialty_quickswap");
  _id_6E09A830FAB9468F::removeperk("specialty_pistoldraw");
  _id_6E09A830FAB9468F::removeperk("specialty_fastoffhand");
  _id_6E09A830FAB9468F::removeperk("specialty_fastreload");
  _id_6E09A830FAB9468F::removeperk("specialty_reducedsway");
  _id_6E09A830FAB9468F::removeperk("specialty_fast_health_regen");

  if(isDefined(self._id_698900C6211CC03C._id_1C7DBF040C780003) && self._id_698900C6211CC03C._id_1C7DBF040C780003 != "kitMedic")
    _id_6E09A830FAB9468F::removeperk("specialty_quick_revive");
}

_id_D45FD98510D7B7E9() {
  _id_F7B6CC6C062A7A43 = "super_high_jump_activate";
  _id_EF7579BE51267BDB = "super_high_jump";

  if(getdvarint("dvar_A6321FC4DC1000D7", 1))
    _id_F7B6CC6C062A7A43 = _id_F7B6CC6C062A7A43 + "_alt";

  _id_6C9D93D4584E15F7 = spawnStruct();
  _id_AF06892358A3C2F4 = 200;
  _id_6C9D93D4584E15F7.cooldownsec = getdvarint("dvar_E45CB58AA0483DCF", 4);
  _id_6C9D93D4584E15F7.ref = "super_jump";
  _id_B7C365B268301285 = getdvarint("dvar_2A0C18157B681884", 0);

  if(!_id_B7C365B268301285)
    self setclientomnvar("ui_super_high_jump_progress", 0);

  self._id_6C9D93D4584E15F7 = _id_6C9D93D4584E15F7;
  _id_81BCD427F4C45B5D = scripts\cp_mp\utility\player_utility::_id_44D612709F857370;
  thread _id_6A991BFD08EA6FC5();
  thread _id_856A49AD2900CFF6();
  thread _id_1D0959EE0D38E083(_id_81BCD427F4C45B5D);
  thread _id_2A8B83E2773640C0();
  thread _id_E4470E4135F2AACC();
  return 1;
}

_id_1D0959EE0D38E083(_id_81BCD427F4C45B5D) {
  self endon("superJump_end");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    if(self[[_id_81BCD427F4C45B5D]]() && !istrue(self._id_6C9D93D4584E15F7.incooldown)) {
      _id_567BDE1E6ACC007B(undefined, undefined, _id_81BCD427F4C45B5D);
      continue;
    }

    waitframe();
  }
}

_id_567BDE1E6ACC007B(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB, _id_81BCD427F4C45B5D) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  _id_943D5ECBD9A29E50 = getdvarint("dvar_1801DE087AF2D296", 0);
  _id_57BD73D0ECAEE169 = getdvarfloat("dvar_D4022FE71CCC5B86", 0.2);
  _id_EEC1CA5327266614 = getdvarfloat("dvar_077B187BE241DBAA", 0.2);
  _id_E5482B00771C4909 = getdvarint("dvar_698142CEBC1F5C75", 1);
  _id_6B00AA3867C7F0D9 = getdvarint("dvar_D4E68695867CFE4B", -1.0);
  _id_F71D03F58AF1672A = getdvarfloat("dvar_691E52162872E904", 1000);
  _id_B7C365B268301285 = getdvarint("dvar_2A0C18157B681884", 0);

  while(!self[[_id_81BCD427F4C45B5D]]())
    waitframe();

  _id_FFDFC86379CFC071 = getdvarint("dvar_EAC3CD896BEA3ABB", 0);

  if(_id_FFDFC86379CFC071) {
    self._id_C561B8C04B423CBD = spawn("script_model", self.origin);
    self._id_C561B8C04B423CBD setModel("tag_player");
    self playerlinkTo(self._id_C561B8C04B423CBD, "tag_player");
  }

  self._id_19191156B87B7CD4 = 1;
  _id_3D3F9FB3BC8C8626 = undefined;

  if(_id_B7C365B268301285)
    _id_3D3F9FB3BC8C8626 = self._id_6C9D93D4584E15F7._id_94480E1669B7FF0D.barelem;

  fraction = 0.0;
  up = 1;
  _id_715D7709363E068C = undefined;
  holdtime = 0;

  while(self[[_id_81BCD427F4C45B5D]]()) {
    wait 0.05;
    holdtime = holdtime + 0.05;

    if(holdtime >= 0.2) {
      if(_id_B7C365B268301285)
        _id_3D3F9FB3BC8C8626 scripts\cp\utility::updatebar(fraction, 0);
      else
        self setclientomnvar("ui_super_high_jump_progress", fraction);

      _id_9D6D9B43B9128E64 = fraction;

      if(up && _id_D2667047A1186849()) {
        if(_id_EDA9454EFB18ADFE()) {
          self setscriptablepartstate("heroDiveVfx", "charge_pause", 0);
          waitframe();
          continue;
        } else if(_id_6653AD92A0329507())
          up = 0;
        else {
          self playRumbleOnEntity("heavy_1s");
          fraction = fraction + _id_57BD73D0ECAEE169;

          if(fraction >= 1) {
            fraction = 1.0;

            if(_id_943D5ECBD9A29E50)
              up = 0;
            else if(_id_6B00AA3867C7F0D9 >= 0) {
              if(!isDefined(_id_715D7709363E068C)) {
                _id_715D7709363E068C = gettime() + _id_6B00AA3867C7F0D9 * 1000;
                thread playerzombiejumpmaxholdwarning(_id_EF7579BE51267BDB, _id_6B00AA3867C7F0D9);
              }

              if(gettime() >= _id_715D7709363E068C) {
                break;
              }
            }
          }

          if(_id_9D6D9B43B9128E64 < _id_EEC1CA5327266614 && fraction >= _id_EEC1CA5327266614 && _id_B7C365B268301285)
            _id_3D3F9FB3BC8C8626.bar.color = (0, 1, 0);
        }
      } else {
        self setscriptablepartstate("heroDiveVfx", "charge_fail", 0);
        fraction = fraction - _id_57BD73D0ECAEE169;

        if(fraction <= 0) {
          fraction = 0.0;
          up = 1;
        }

        if(_id_B7C365B268301285 && _id_9D6D9B43B9128E64 > _id_EEC1CA5327266614 && fraction <= _id_EEC1CA5327266614)
          _id_3D3F9FB3BC8C8626.bar.color = (1, 1, 1);
      }

      waitframe();
    }
  }

  self notify("jumpChargeEnd");

  if(_id_FFDFC86379CFC071)
    self unlink();

  _id_CB0C533702ADEE19 = _id_D2667047A1186849();

  if(fraction >= _id_EEC1CA5327266614 && _id_CB0C533702ADEE19) {
    if(fraction < 0.33)
      self setscriptablepartstate("heroDiveVfx", "jump_begin_small", 0);
    else if(fraction < 0.66)
      self setscriptablepartstate("heroDiveVfx", "jump_begin_med", 0);
    else
      self setscriptablepartstate("heroDiveVfx", "jump_begin_lrg", 0);

    _id_DEE6508B0BA437C5 = self getplayerangles();
    self setscriptablepartstate("heroDiveVfx", "jump_begin_small", 0);
    playerapplyjumpvelocity(_id_DEE6508B0BA437C5, _id_F71D03F58AF1672A, fraction);
  } else {
    self setscriptablepartstate("heroDiveVfx", "charge_fail", 0);

    if(_id_E5482B00771C4909) {
      if(_id_B7C365B268301285)
        _id_3D3F9FB3BC8C8626.bar.frac = 0;
      else {
        self setclientomnvar("ui_super_high_jump_progress", 0);
        self setclientomnvar("ui_super_jump_cooldown", 0);
      }
    }
  }

  _id_D59D137D348A395D(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB, 1);
}

playerapplyjumpvelocity(_id_44AAE8E966034513, _id_F71D03F58AF1672A, fraction) {
  _id_BF0F04DD3597A019 = 1;
  _id_DEE6508B0BA437C5 = _id_44AAE8E966034513;
  _id_A6F73A56325293DB = vectorNormalize(self getvelocity());
  _id_68FD30DB511477F5 = anglesToForward(self.angles);
  dot = vectordot(_id_A6F73A56325293DB, _id_68FD30DB511477F5);
  _id_0441B8B8D8D1BBE0 = dot > 0.875 || dot == 0;

  if(!_id_0441B8B8D8D1BBE0) {
    _id_5A2182BEDEBA5ED9 = vectortoangles(_id_A6F73A56325293DB);
    _id_DEE6508B0BA437C5 = (_id_DEE6508B0BA437C5[0], _id_5A2182BEDEBA5ED9[1], _id_5A2182BEDEBA5ED9[2]);
  }

  if(getdvarint("dvar_CE6D7D66848CDBCC", _id_BF0F04DD3597A019)) {
    _id_AA4EA3B3807E1650 = get_ground_normal();

    if(!isDefined(_id_AA4EA3B3807E1650))
      _id_AA4EA3B3807E1650 = (0, 0, 1);

    _id_0A2A227242F2C364 = (0, _id_DEE6508B0BA437C5[1], 0);
    right = anglestoright(_id_0A2A227242F2C364);
    fwd = vectorcross(_id_AA4EA3B3807E1650, right);
    _id_19AE114150BFC887 = vectortoangles(fwd);
    _id_B184911D23195923 = _id_19AE114150BFC887[0];
    _id_98B04C3F8A107752 = -85;
    _id_5A112B1311CF05E5 = _id_DEE6508B0BA437C5[0];

    if(_id_B184911D23195923 > 90 || _id_B184911D23195923 < -90)
      _id_B184911D23195923 = -90 - _id_B184911D23195923 % 90 * -1;

    _id_9D83796E5DFB9A1C = _id_B184911D23195923;

    if(_id_5A112B1311CF05E5 > _id_B184911D23195923)
      _id_5A112B1311CF05E5 = _id_B184911D23195923;

    _id_E6BC250926C6D64D = getdvarfloat("dvar_9EC479015407C245", -45.0);
    _id_E6980F09269E2B33 = getdvarfloat("dvar_9EE78301542E1FFB", 0.0);
    frac = (_id_5A112B1311CF05E5 - _id_98B04C3F8A107752) / (_id_9D83796E5DFB9A1C - _id_98B04C3F8A107752);
    _id_AEE49E405BF58492 = _id_E6980F09269E2B33 + frac * (_id_E6BC250926C6D64D - _id_E6980F09269E2B33);
    _id_DEE6508B0BA437C5 = (_id_5A112B1311CF05E5 + _id_AEE49E405BF58492, _id_DEE6508B0BA437C5[1], _id_DEE6508B0BA437C5[2]);
  }

  _id_179DB9ACB8F30E85 = getdvarfloat("dvar_CF56037C34EA141F", 0.0);

  if(_id_179DB9ACB8F30E85 != 0.0)
    _id_DEE6508B0BA437C5 = (_id_DEE6508B0BA437C5[0] + _id_179DB9ACB8F30E85, _id_DEE6508B0BA437C5[1], _id_DEE6508B0BA437C5[2]);

  dir = anglesToForward(_id_DEE6508B0BA437C5);
  velocity = dir * fraction * _id_F71D03F58AF1672A;
  self setOrigin(self.origin + (0, 0, 20));
  self setvelocity(velocity);
  wait 0.1;
  _id_C8D506CA0BBC49E5();
}

_id_C8D506CA0BBC49E5() {
  self endon("disconnect");
  self endon("death");

  while(!self isonground())
    waitframe();

  self notify("perform_hero_drop_local");
}

_id_EDA9454EFB18ADFE() {
  if(self ismantling())
    return 1;

  if(self getstance() == "prone")
    return 1;

  return 0;
}

_id_6653AD92A0329507() {
  if(self isinexecutionattack() || self isinexecutionvictim())
    return 1;

  if(self _meth_415FE9EECA7B2E2B())
    return 1;

  if(self isonladder())
    return 1;

  if(self _meth_E40102956C887F7C())
    return 1;

  if(!_id_AD443BBCDCF37B85(self))
    return 1;

  if(self _meth_9CC921A57FF4DEB5())
    return 1;

  if(isDefined(self.carryobject))
    return 1;

  return 0;
}

playerzombiejumpmaxholdwarning(_id_EF7579BE51267BDB, time) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("playerZombieJumpStop");
  self endon("jumpChargeEnd");

  if(time <= 0) {
    return;
  }
  _id_3D3F9FB3BC8C8626 = self._id_6C9D93D4584E15F7._id_94480E1669B7FF0D.barelem;
  _id_2C728360E4C9326A = 5;
  color = 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2C728360E4C9326A.size; _id_AC0E594AC96AA3A8++) {
    if(color)
      _id_3D3F9FB3BC8C8626.bar.color = (1, 0, 0);
    else
      _id_3D3F9FB3BC8C8626.bar.color = (0, 1, 0);

    wait(_id_2C728360E4C9326A[_id_AC0E594AC96AA3A8]);
    color = !color;
  }
}

_id_D2667047A1186849() {
  if(self isinexecutionattack() || self isinexecutionvictim())
    return 0;

  if(self ismantling())
    return 0;

  if(self _meth_9CC921A57FF4DEB5())
    return 0;

  if(self isonladder())
    return 0;

  if(self _meth_415FE9EECA7B2E2B())
    return 0;

  if(self isjumping())
    return 0;

  if(self _meth_E40102956C887F7C())
    return 0;

  if(!_id_AD443BBCDCF37B85(self))
    return 0;

  if(scripts\cp\utility::isjuggernaut())
    return 0;

  if(self getstance() == "prone")
    return 0;

  if(isDefined(self.carryobject))
    return 0;

  if(self isskydiving() || self isinfreefall() || self isparachuting())
    return 0;

  if(scripts\cp_mp\utility\player_utility::_id_B7869F6D9D4242E3(self))
    return 0;

  if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("allow_super_jump"))
    return 0;

  _id_E880AF5898EC6FD1 = getstancetop();
  radius = getdvarint("dvar_947314490033F015", 14);
  _id_4E18BF6F5EEEE2F0 = getstancetop() + anglestoup(self.angles) * 100;
  contents = scripts\engine\trace::create_default_contents(1);

  if(!scripts\engine\trace::sphere_trace_passed(_id_E880AF5898EC6FD1, _id_4E18BF6F5EEEE2F0, radius, self, contents))
    return 0;

  return 1;
}

_id_D59D137D348A395D(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB, _id_1FC7E7DDBA5D5771) {
  if(isDefined(self._id_C561B8C04B423CBD))
    self._id_C561B8C04B423CBD delete();

  self._id_19191156B87B7CD4 = undefined;
}

get_ground_normal(_id_31CAEF840B7AC074, debug) {
  if(!isDefined(_id_31CAEF840B7AC074))
    ignore = self;
  else
    ignore = _id_31CAEF840B7AC074;

  if(!isDefined(debug))
    debug = 0;

  ignorelist = [ignore];
  _id_D895C679F6A927E5 = [self.origin];

  for(_id_AC0E594AC96AA3A8 = -1.0; _id_AC0E594AC96AA3A8 <= 1.0; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 2.0) {
    for(_id_AC0E5C4AC96AAA41 = -1.0; _id_AC0E5C4AC96AAA41 <= 1.0; _id_AC0E5C4AC96AAA41 = _id_AC0E5C4AC96AAA41 + 2.0) {
      _id_4E6D9BE609009734 = ignore getpointinbounds(_id_AC0E594AC96AA3A8, _id_AC0E5C4AC96AAA41, 0.0);
      _id_4E6D9BE609009734 = (_id_4E6D9BE609009734[0], _id_4E6D9BE609009734[1], self.origin[2]);
      _id_D895C679F6A927E5[_id_D895C679F6A927E5.size] = _id_4E6D9BE609009734;
    }
  }

  _id_F863280C4EB41018 = (0, 0, 0);
  _id_97D8F5A9EB04C1F2 = 0;

  foreach(point in _id_D895C679F6A927E5) {
    trace = scripts\engine\trace::_bullet_trace(point + (0, 0, 4), point + (0, 0, -16), 0, ignorelist);
    _id_B68850986D4C6C13 = trace["fraction"] > 0.0 && trace["fraction"] < 1;

    if(_id_B68850986D4C6C13) {
      _id_F863280C4EB41018 = _id_F863280C4EB41018 + trace["normal"];
      _id_97D8F5A9EB04C1F2++;
    }
  }

  if(_id_97D8F5A9EB04C1F2 > 0) {
    _id_F863280C4EB41018 = _id_F863280C4EB41018 / _id_97D8F5A9EB04C1F2;
    return _id_F863280C4EB41018;
  } else
    return undefined;
}

_id_AD443BBCDCF37B85(player) {
  return isDefined(player);
}

getstancetop(_id_2EEA482C1A2F43A9) {
  _id_6497396FB64EA3B9 = self getstance();

  if(isDefined(_id_2EEA482C1A2F43A9))
    _id_6497396FB64EA3B9 = _id_2EEA482C1A2F43A9;

  if(_id_6497396FB64EA3B9 == "crouch")
    top = self.origin + (0, 0, 48);
  else if(_id_6497396FB64EA3B9 == "prone")
    top = self.origin + (0, 0, 20);
  else
    top = self.origin + (0, 0, 64);

  return top;
}

playerpowerstartcooldown(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("assassin_unset");
  self endon("assassin_set");
  self endon("disableCooldown");
  _id_D671E5BEFA0CFAE3 = self.powershud[_id_EF7579BE51267BDB].barelem;

  if(_id_D671E5BEFA0CFAE3.bar.frac > 0) {
    self.powershud[_id_EF7579BE51267BDB].incooldown = 1;
    cooldownsec = _id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB].cooldownsec;
    _id_B1F7CE0445D66AC9 = _func_2EF675C13CA1C4AF("dvar_10968C493AE2E9CE", _id_EF7579BE51267BDB);

    if(getdvarint(_id_B1F7CE0445D66AC9, 0) != 0)
      cooldownsec = getdvarint(_id_B1F7CE0445D66AC9, 0);

    fraction = _id_D671E5BEFA0CFAE3.bar.frac;
    cooldownsec = cooldownsec * fraction;
    _id_D671E5BEFA0CFAE3.bar.color = (1, 0.6, 0);
    _id_D671E5BEFA0CFAE3.bar scaleovertime(cooldownsec, 0, _id_D671E5BEFA0CFAE3.height);
    wait(cooldownsec);
    self.powershud[_id_EF7579BE51267BDB].incooldown = 0;
  } else
    _id_D671E5BEFA0CFAE3 scripts\cp\utility::updatebar(0, 0);

  _id_D671E5BEFA0CFAE3.bar.color = (1, 1, 1);

  if(isDefined(_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_7939D347ADE41DA0))
    self[[_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_7939D347ADE41DA0]](_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);
}

_id_BD0E084AFB0D192F(isactive) {
  if(isactive)
    _id_3B64EB40368C1450::set("jump_superpower", "allow_jump", 0);
  else
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("jump_superpower");
}

_id_2A8B83E2773640C0() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("superJump_end");

  for(;;) {
    self waittill("perform_hero_drop_local");
    self radiusdamage(self.origin, 256, _id_751F1FE07D7BF833(), 50, self, "MOD_MELEE");
    thread _id_F5F070B3D96A1C1E();
  }
}

_id_751F1FE07D7BF833() {
  if(!isDefined(self._id_6C9D93D4584E15F7) || !isDefined(self._id_6C9D93D4584E15F7._id_501056BCDA9531C2))
    return 50;

  _id_4CA7B6A31270C32A = getdvarfloat("dvar_710B8F0737994439", 3);
  _id_8A3EBC608BE39514 = clamp(self._id_6C9D93D4584E15F7._id_501056BCDA9531C2 / _id_4CA7B6A31270C32A, 0, 1);
  return 500 * _id_8A3EBC608BE39514;
}

_id_F5F070B3D96A1C1E() {
  self endon("disconnect");
  level endon("game_ended");
  self setscriptablepartstate("heroDiveVfx", "impact", 0);
  wait 1;
  self setscriptablepartstate("heroDiveVfx", "off", 0);
}

_id_E4470E4135F2AACC() {
  self endon("disconnect");
  level endon("game_ended");

  if(!self isonground() && !self _meth_E40102956C887F7C()) {
    self._id_B6AA5954BF6A457A = 1;

    while(_id_AD443BBCDCF37B85(self)) {
      if(self isonground()) {
        waitframe();
        break;
      }

      waitframe();
    }
  }

  self._id_B6AA5954BF6A457A = undefined;
}

_id_6A991BFD08EA6FC5() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("superJump_end");
  self endon("temp_v_finished");

  if(getdvarint("dvar_A6321FC4DC1000D7", 1)) {
    return;
  }
  for(;;) {
    if(self isonladder() || self _meth_415FE9EECA7B2E2B())
      _id_BD0E084AFB0D192F(0);
    else
      _id_BD0E084AFB0D192F(1);

    waitframe();
  }
}

_id_856A49AD2900CFF6() {
  self endon("death_or_disconnect");
  self endon("superJump_end");
  level endon("game_ended");

  if(!isDefined(self._id_6C9D93D4584E15F7)) {
    return;
  }
  self._id_6C9D93D4584E15F7._id_501056BCDA9531C2 = 0;
  _id_9337100AA8DE2451 = 0;
  _id_62601C1642480674 = 0;

  while(isDefined(self._id_6C9D93D4584E15F7)) {
    if(self isonground() || self isparachuting()) {
      if(self isonground() && !_id_62601C1642480674) {
        _id_62601C1642480674 = 1;
        _id_3B64EB40368C1450::set("jump_superpower", "usability", 1);
        _id_3B64EB40368C1450::set("jump_superpower", "allow_jump", 1);
      }

      if(self._id_6C9D93D4584E15F7._id_501056BCDA9531C2 > 0) {
        if(_id_9337100AA8DE2451 >= 3)
          self._id_6C9D93D4584E15F7._id_501056BCDA9531C2 = 0;
        else
          _id_9337100AA8DE2451++;

        waitframe();
        continue;
      }
    } else {
      _id_9337100AA8DE2451 = 0;
      self._id_6C9D93D4584E15F7._id_501056BCDA9531C2 = self._id_6C9D93D4584E15F7._id_501056BCDA9531C2 + level.framedurationseconds;

      if(_id_62601C1642480674) {
        _id_62601C1642480674 = 0;
        _id_3B64EB40368C1450::set("jump_superpower", "usability", 0);
      }
    }

    waitframe();
  }

  if(!getdvarint("dvar_A6321FC4DC1000D7", 1))
    _id_BD0E084AFB0D192F(0);
}

_id_95ADB84C5CA51C36() {
  return isDefined(self._id_6C9D93D4584E15F7) && isDefined(self._id_6C9D93D4584E15F7.ref) && istrue(self._id_6C9D93D4584E15F7.ref == "super_jump");
}

_id_3A307FD8EB4F27EB() {
  if(self isskydiving())
    self skydive_interrupt();

  self notify("perform_hero_drop");
  return 0;
}

_id_DBBF64242C92D7C0() {
  player = self;

  if(!isDefined(player._id_5F9F7AF65FF5E009)) {
    player._id_5F9F7AF65FF5E009 = newclienthudelem(player);
    player._id_5F9F7AF65FF5E009.sort = 1;
    player._id_5F9F7AF65FF5E009.x = 0;
    player._id_5F9F7AF65FF5E009.y = 0;
    player._id_5F9F7AF65FF5E009.alignx = "left";
    player._id_5F9F7AF65FF5E009.aligny = "top";
    player._id_5F9F7AF65FF5E009.foreground = 0;
    player._id_5F9F7AF65FF5E009.lowresbackground = 1;
    player._id_5F9F7AF65FF5E009.horzalign = "fullscreen";
    player._id_5F9F7AF65FF5E009.vertalign = "fullscreen";
    player._id_5F9F7AF65FF5E009.alpha = 0;
    player._id_5F9F7AF65FF5E009 setshader("Black", 640, 480);
  }
}