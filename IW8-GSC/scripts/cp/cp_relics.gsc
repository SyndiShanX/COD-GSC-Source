/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_relics.gsc
***********************************************/

function register_relics() {
  level.updateonkillrelicsfunc = &updateonkillrelics;
  level.updatepersistentrelicsfunc = &updatepersistentrelics;
  level.updateondamagerelicsfunc = &updateondamagerelics;
  level.ref_14000 = &ref_13fff;
  level.cp_relics = [];
  level.updaterecentkillsrelics_func = &updaterecentkills;
  level.ref_13fd4 = &ref_13fd3;
  level.relic_combos = load_relic_combos_from_table();
  level.modifyplayerdamage_relics = [];

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
  register_relic("passive_random_attachment", &init_passive_random_attachment, &set_passive_random_attachment, &unset_passive_random_attachment);
  register_relic("passive_scope_radar", &init_passive_scope_radar, &set_passive_scope_radar, &unset_passive_scope_radar);
  register_relic("passive_scorestreak_damage", &init_passive_scorestreak_damage, &set_passive_scorestreak_damage, &unset_passive_scorestreak_damage);
  register_relic("passive_scorestreak_damage_e", &init_passive_scorestreak_damage, &set_passive_scorestreak_damage, &unset_passive_scorestreak_damage);
  register_relic("relic_collat_dmg", &init_relic_collat_dmg, &set_relic_collat_dmg, &unset_relic_collat_dmg);
  register_relic("relic_catch", &init_relic_catch, &set_relic_catch, &unset_relic_catch);
  register_relic("relic_boom", &init_relic_boom, &set_relic_boom, &unset_relic_boom);
  register_relic("relic_swat", &init_relic_swat, &set_relic_swat, &unset_relic_swat);
  register_relic("relic_glasscannon", &init_relic_glasscannon, &set_relic_glasscannon, &unset_relic_glasscannon);
  register_relic("relic_aggressive_melee", &tac_rover_horn, &ref_130ae, &ref_13f36);
  register_relic("relic_focus_fire", &tacinsert_destroyuselistener, &ref_130bc, &ref_13f42);
  register_relic("relic_damage_from_above", &tac_rover_trail, &ref_130b3, &ref_13f3b);
  register_relic("relic_landlocked", &tacinsert_updatedestroyusability, &ref_130c3, &ref_13f49);
  register_relic("relic_martyrdom", &tacmapvo, &ref_130c7, &ref_13f4d);
  register_relic("relic_gas_martyr", &tacinsert_gamemode_callback, &ref_130bd, &ref_13f43);
  register_relic("relic_gun_game", &tacinsert_monitorupdatespawnposition, &ref_130bf, &ref_13f45);
  register_relic("relic_team_proximity", &take_intro_items, &ref_130d6, &ref_13f5b);
  register_relic("relic_squadlink", &take, &ref_130d3, &ref_13f59);
  register_relic("relic_dfa", &taccover_timeout, &ref_130b4, &ref_13f3c);
  register_relic("relic_shieldsonly", &taillightright, &ref_130d2, &ref_13f58);
  register_relic("relic_mythic", &tactical_boxes, &ref_130c8, &ref_13f4e);
  register_relic("relic_amped", &tac_rover_initdamage, &ref_130b1, &ref_13f39);
  register_relic("relic_thirdperson", &take_time_away_from_bomb_vest_timer, &ref_130d7, &ref_13f5c);
  register_relic("relic_dogtags", &taccovertriggerblockers, &ref_130b5, &ref_13f3d);
  register_relic("relic_lsmelee", &tacinserts, &ref_130c5, &ref_13f4b);
  register_relic("relic_hideobj", &tacinsert_tacinsertdestroyedfeedback, &ref_130c2, &ref_13f48);
  register_relic("relic_expldmg", &tacinsert_deleteontoofar, &ref_130ba, &ref_13f40);
  register_relic("relic_fastbleed", &tacinsert_destroyongameended, &ref_130bb, &ref_13f41);
  register_relic("relic_nuketimer", &tagautopickup, &ref_130ce, &ref_13f54);
  register_relic("relic_doubletap", &tacinsert_cachespawnposition, &ref_130b7, &ref_13f3f);
  register_relic("relic_vampire", &takelaststandtransitionweapon, &ref_130d9, &ref_13f5e);
  register_relic("relic_healthpacks", &tacinsert_pickuplistener, &ref_130c1, &ref_13f47);
  register_relic("relic_noregen", &tag_usb_with_head_icon, &ref_130cd, &ref_13f53);
  register_relic("relic_noks", &tag_convoy_with_objectives, &ref_130cb, &ref_13f51);
  register_relic("relic_no_ammo_mun", &tactical_crate_spawn, &ref_130c9, &ref_13f4f);
  register_relic("relic_lfo", &tacmapexplanation, &ref_130c6, &ref_13f4c);
  register_relic("relic_aitype_shotgun", undefined, &ref_1308d, &ref_13f2c);
  register_relic("relic_aitype_sniper", undefined, &ref_1308e, &ref_13f2d);
  register_relic("relic_aitype_riotshield", undefined, &ref_1308b, &ref_13f2a);
  register_relic("relic_aitype_suicidebomber", undefined, &ref_1308f, &ref_13f2e);
  register_relic("relic_aitype_rpg", undefined, &ref_1308c, &ref_13f2b);
  register_relic("relic_aitype_armored", undefined, &ref_1308a, &ref_13f30);
  register_relic("relic_bang_and_boom", &tac_rover_initomnvars, &ref_130b2, &ref_13f3a);
  register_relic("relic_noluck", &tag_to_shoot_from, &ref_130cc, &ref_13f52);
  register_relic("relic_doomslayer", &tacinsert_brrespawnsplash, &ref_130b6, &ref_13f3e);
  register_relic("relic_headbullets", &tacinsert_onjoinedteam, &ref_130c0, &ref_13f46);
  register_relic("relic_rocket_kill_ammo", &taillightleft, &ref_130d1, &ref_13f57);
  register_relic("relic_punchbullets", &tagtaken, &ref_130d0, &ref_13f56);
  register_relic("relic_grounded", &tacinsert_getspawnposition, &ref_130be, &ref_13f44);
  register_relic("relic_oneclip", &tags_used, &ref_130cf, &ref_13f55);
  register_relic("relic_laststand", &tacinsert_updatepickupusability, &ref_130c4, &ref_13f4a);
  register_relic("relic_steelballs", &take_ai_weapon, &ref_130d4, &ref_13f5a);
  register_relic("relic_nobulletdamage", &tactical_goal_in_action_thread, &ref_130ca, &ref_13f50);
  register_relic("relic_ammo_drain", &tac_rover_initcollision, &ref_130b0, &ref_13f38);
  register_relic("relic_trex", &takeaccesscardpickup, &ref_130d8, &ref_13f5d);
  level.select_bridge_three_spawners = [];
  level.select_bridge_three_spawners["relic_noks"] = &setupcirclepeek;
  level.select_bridge_three_spawners["relic_no_ammo_mun"] = &setup_comms_obj_b_goals_and_cover;
  level.select_bridge_three_spawners["relic_lfo"] = &setup_wave_spawn_zone_disable;
  level.select_bridge_three_spawners["relic_focus_fire"] = &setup_train_entarray;
  level.select_bridge_three_spawners["relic_mythic"] = &setupbrsquadleader;
  level.select_bridge_three_spawners["relic_dfa"] = &setup_next_advance;
  level.select_bridge_three_spawners["relic_swat"] = &getgamewinnerfunc;
  level.select_bridge_three_spawners["relic_aitype_shotgun"] = &complete_vault_assault_retrieve_saw;
  level.select_bridge_three_spawners["relic_aitype_sniper"] = &complete_vault_assault_retrieve_saw;
  level.select_bridge_three_spawners["relic_aitype_riotshield"] = &complete_vault_assault_retrieve_saw;
  level.select_bridge_three_spawners["relic_aitype_suicidebomber"] = &complete_vault_assault_retrieve_saw;
  level.select_bridge_three_spawners["relic_aitype_rpg"] = &complete_vault_assault_retrieve_saw;
  level.select_bridge_three_spawners["relic_aitype_armored"] = &complete_vault_assault_retrieve_saw;
  level.select_bridge_three_spawners["relic_team_proximity"] = &select_boss_one_spawners;
  level.select_bridge_three_spawners["relic_landlocked"] = &select_back_one_spawners;
  level.select_bridge_three_spawners["relic_healthpacks"] = &ref_12b79;
  level.select_bridge_three_spawners["relic_vampire"] = &ref_12bae;
  level.select_bridge_three_spawners["relic_squadlink"] = &select_back_two_spawners;
  level.select_bridge_three_spawners["relic_amped"] = &select_back_door_spawners;
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
  level.onkillrelics["relic_punchbullets"] = &setupblueprintpickupweapons;
  level.onkillrelics["relic_headbullets"] = &setup_trap_consoles;
  level.onkillrelics["relic_rocket_kill_ammo"] = &setuphumanpowers;
  level.onkillrelics["relic_steelballs"] = &setupboardroomcode;
  level.onkillrelics["relic_collat_dmg"] = &handlereliccollatdamage;
  level.onkillrelics["relic_catch"] = &handlereliccatch;
  level.onkillrelics["relic_boom"] = &handlerelicboom;
  level.onkillrelics["relic_martyrdom"] = &setuphelitimer;
  level.onkillrelics["relic_gas_martyr"] = &setuphqs;
  level.onkillrelics["relic_shieldsonly"] = &setuphudelemninfilblack;
  level.onkillrelics["relic_healthpacks"] = &ref_12b7a;
  level.onkillrelics["relic_amped"] = &setupglobalkillcount;
  level.persistentrelics = [];
  level.persistentrelics["passive_infinite_ammo"] = &handleinfiniteammopassive;
  level.persistentrelics["passive_fortified"] = &handlefortified;
  level.persistentrelics["relic_landlocked"] = &setupdom;
  level.persistentrelics["relic_team_proximity"] = &setupdomplates;
  level.persistentrelics["relic_gun_game"] = &setupdogtags;
  register_relic("relic_just_keep_moving", undefined, &ref_13099, &ref_13f34);
  level.persistentrelics["relic_just_keep_moving"] = &setup_bot_flag;
  level.ondamagerelics = [];
  level.ondamagerelics["passive_sonic"] = &handlepassivesonic;
  level.ondamagerelics["passive_minimap_damage"] = &updatepassiveminimapdamage;
  level.ondamagerelics["passive_cold_damage"] = &updatepassivecolddamage;
  level.ondamagerelics["relic_swat"] = &handlerelicswat;
  level.ondamagerelics["relic_collat_dmg"] = &ref_12016;
  level.ondamagerelics["relic_vampire"] = &ref_1201d;
  level.ondamagerelics["relic_lfo"] = &ref_1201a;
  level.ondamagerelics["relic_focus_fire"] = &ref_12018;
  level.ondamagerelics["relic_damage_from_above"] = &ref_12019;
  level.ondamagerelics["relic_steelballs"] = &ref_1201c;
  level.ondamagerelics["relic_doomslayer"] = &ref_12017;
  level.ondamagerelics["relic_squadlink"] = &ref_1201b;
  level.ondamagerelics["relic_nobulletdamage"] = &ref_12b87;
  level.ref_12015 = [];
  level.ref_12015["relic_focus_fire"] = &ref_12014;
  level.ref_12020 = [];
  level.ref_12020["relic_bang_and_boom"] = &ref_12b6d;
}

function load_relic_combos_from_table() {
  var0 = "cp/cp_relic_combos.csv";
  var1 = [];

  for(var2 = 1; var2 <= 10; var2++) {
    var3 = table_look_up(var0, var2, 1);

    if(var3 == "") {
      continue;
    }

    var1 = spawnStruct();
    var1[var2 - 1].scomboname = table_look_up(var0, var2, 1);
    var1[var2 - 1].srelicref1 = table_look_up(var0, var2, 2);
    var1[var2 - 1].srelicref2 = table_look_up(var0, var2, 3);
    var1[var2 - 1].srelicref3 = table_look_up(var0, var2, 4);
    var1[var2 - 1].srelicref4 = table_look_up(var0, var2, 5);
    var1[var2 - 1].srelicref5 = table_look_up(var0, var2, 6);
    var1[var2 - 1].srelicref6 = table_look_up(var0, var2, 7);
  }

  return var1;
}

function table_look_up(var0, var1, var2) {
  return tablelookup(var0, 0, var1, var2);
}

function init_passive_random_attachment(var0) {
  var1 = getweaponswithpassive(var0, "passive_random_attachment");
  var2 = [];

  foreach(var4 in var1) {
    var5 = scripts\cp\utility::getrawbaseweaponname(var4);
    var6 = scripts\cp\utility::getweaponrootname(var4);
    var7 = scripts\cp\utility::getweaponcamo(var6);
    var8 = scripts\cp\utility::getweaponcosmeticattachment(var6);
    var9 = scripts\cp\utility::getweaponreticle(var6);
    var10 = scripts\cp\utility::getweaponpaintjobid(var6);
    var0.weapon_build_models[var5] = scripts\cp\utility::mpbuildweaponname(var6, var2, var7, var9, scripts\cp\utility::get_weapon_variant_id(var0, var4), self getentitynumber(), self.clientid, var10, var8);
  }
}

function set_passive_random_attachment(var0) {}

function unset_passive_random_attachment(var0) {}

function getweaponswithpassive(var0, var1) {
  var2 = [];
  var3 = getarraykeys(var0.weapon_passives);

  foreach(var5 in var3) {
    for(var6 = 0; var6 < var0.weapon_passives[var5].size; var6++) {
      if(var0.weapon_passives[var5][var6].name == var1) {
        var2 = var5;
      }
    }
  }

  var2 = scripts\engine\utility::array_remove_duplicates(var2);
  return var2;
}

function init_passive_fast_melee(var0) {}

function set_passive_fast_melee(var0) {
  var0.increased_melee_damage = 150;
}

function unset_passive_fast_melee(var0) {
  var0.increased_melee_damage = undefined;
}

function init_extra_xp(var0) {
  var0.weapon_passive_xp_multiplier = 1;
  var0.kill_with_extra_xp_passive = 0;
}

function set_extra_xp(var0) {
  var0.weapon_passive_xp_multiplier = 1.25;
}

function unset_extra_xp(var0) {
  var0.weapon_passive_xp_multiplier = 1;
  var0.kill_with_extra_xp_passive = 0;
}

function init_passive_below_the_belt(var0) {
  var0.crotch_damage_multiplier = undefined;
}

function set_passive_below_the_belt(var0) {
  var0.crotch_damage_multiplier = 3.75;
}

function unset_passive_below_the_belt(var0) {
  var0.crotch_damage_multiplier = undefined;
}

function init_passive_move_speed(var0) {
  var0.weapon_passive_xp_multiplier = 1;
}

function set_passive_move_speed(var0) {
  var0.weaponpassivespeedmod = 0.05;
  var0[[level.move_speed_scale]]();
}

function unset_passive_move_speed(var0) {
  var0.weaponpassivespeedmod = undefined;
  var0[[level.move_speed_scale]]();
}

function init_passive_empty_reload_speed(var0) {}

function set_passive_empty_reload_speed(var0) {
  var0 scripts\cp\utility::_setperk("specialty_fastreload_empty");
}

function unset_passive_empty_reload_speed(var0) {
  var0 scripts\cp\utility::_unsetperk("specialty_fastreload_empty");
}

function init_passive_increased_scope_breath(var0) {}

function set_passive_increased_scope_breath(var0) {
  var0 scripts\cp\utility::_setperk("specialty_holdbreath");
}

function unset_passive_increased_scope_breath(var0) {
  var0 scripts\cp\utility::_unsetperk("specialty_holdbreath");
}

function init_snap_to_head(var0) {}

function set_snap_to_head(var0) {
  var0 scripts\cp\utility::_setperk("specialty_autoaimhead");
}

function unset_snap_to_head(var0) {
  var0 scripts\cp\utility::_unsetperk("specialty_autoaimhead");
}

function init_passive_hunter_killer(var0) {
  self.hunterkilleroutlines = 0;
}

function set_passive_hunter_killer(var0) {
  self endon("passive_hunter_killer_cancel");
  var1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  thread updatehunterkillerplayers(var1);
  thread hunterkillerlistenforconnect();

  foreach(var0 in var1) {
    thread hunterkillerlistenfordisconnect(var0);
    thread hunterkillerlistenfordamage(var0);
  }
}

function unset_passive_hunter_killer(var0) {
  self notify("passive_hunter_killer_cancel");

  foreach(var2 in self.hunterkillerids) {
    var0 = self.hunterkillerents[var2];
    scripts\cp\cp_outline::disable_outline_for_players(var0, level.players);
  }

  self.hunterkillerids = undefined;
  self.hunterkillerents = undefined;
}

function updatehunterkillerplayers(var0) {
  if(!isDefined(self.hunterkillerids)) {
    self.hunterkillerids = [];
  }

  if(!isDefined(self.hunterkillerents)) {
    self.hunterkillerents = [];
  }

  foreach(var2 in var0) {
    if(var2 == self || !isDefined(self) || !isDefined(self.team) || !isDefined(var2) || !isDefined(var2.team)) {
      continue;
    }

    var3 = gethunterkillerid(var2);

    if(level.teambased && self.team != var2.team && var2.health / var2.maxhealth <= 0.5 && var2.health > 0) {
      if(var3 < 0) {
        self.hunterkilleroutlines++;
        scripts\cp\cp_outline::enable_outline_for_player(var2, self, 1, 0, 1, "high");
        var4 = self.hunterkilleroutlines;
        self.hunterkillerids[self.hunterkillerids.size] = var4;
        self.hunterkillerents[var4] = var2;
        thread hunterkillerlistenforhealth(var2);
      }

      continue;
    }

    if(var3 >= 0) {
      var5 = [];
      var6 = [];
      scripts\cp\cp_outline::disable_outline_for_player(var2, self);

      foreach(var4 in self.hunterkillerids) {
        var8 = self.hunterkillerents[var4];

        if(var8 == var2) {
          continue;
        }

        var5 = var4;
        var6 = var8;
      }

      self.hunterkillerids = var5;
      self.hunterkillerents = var6;
      var2 notify("passive_hunter_killer_listen_cancel");
    }
  }
}

function hunterkillerlistenforhealth(var0) {
  self endon("passive_hunter_killer_cancel");
  var0 endon("passive_hunter_killer_listen_cancel");

  for(;;) {
    wait 1;
    thread updatehunterkillerplayer(var0);
  }
}

function gethunterkillerid(var0) {
  if(!isDefined(self.hunterkillerids) || !isDefined(self.hunterkillerents)) {
    return -1;
  }

  foreach(var2 in self.hunterkillerids) {
    var3 = self.hunterkillerents[var2];

    if(!isDefined(var3)) {
      continue;
    }

    if(var3 == var0) {
      return var2;
    }
  }

  return -1;
}

function hunterkillerlistenforconnect() {
  self endon("passive_hunter_killer_cancel");

  for(;;) {
    level waittill("agent_spawned", var0);
    thread updatehunterkillerplayer(var0);
    thread hunterkillerlistenfordamage(var0);
  }
}

function hunterkillerlistenfordisconnect(var0) {
  self endon("passive_hunter_killer_cancel");
  var0 waittill("disconnect");
  thread updatehunterkillerplayer(var0);
}

function hunterkillerlistenfordamage(var0) {
  self endon("passive_hunter_killer_cancel");

  for(;;) {
    var0 waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);
    thread updatehunterkillerplayer(var0);
  }
}

function updatehunterkillerplayer(var0) {
  var1 = [];
  GscBinSkip0(0x2e, var1.size, var0);
}

function init_passive_refresh(var0) {
  var0.nextpassiverefreshkills = 0;
}

function set_passive_refresh(var0) {
  var0.onkillrelics["passive_refresh"] = 1;
}

function unset_passive_refresh(var0) {
  var0.onkillrelics["passive_refresh"] = 0;
}

function handlepassiverefresh(var0, var1, var2, var3, var4, var5) {
  var1.nextpassiverefreshkills++;

  if(var1.nextpassiverefreshkills >= 50) {
    if(isDefined(level.power_adjustcharges)) {
      var1[[level.power_adjustcharges]](undefined, "primary", 1);
    }

    var1.nextpassiverefreshkills = 0;
    return;
  }
}

function init_passive_double_kill_reload(var0) {}

function set_passive_double_kill_reload(var0) {
  var0.onkillrelics["passive_double_kill_reload"] = 1;
}

function unset_passive_double_kill_reload(var0) {
  var0.onkillrelics["passive_double_kill_reload"] = 0;
}

function doublekillreloadwatcher(var0, var1, var2, var3, var4, var5) {
  if(var1.recentkillcount >= 4) {
    var0 = var1 getcurrentweapon();
    var6 = weaponclipsize(var0);
    var7 = var1 getweaponammostock(var0);
    var8 = var1 getweaponammoclip(var0);
    var9 = min(var6 - var8, var7);
    var10 = min(var8 + var9, var6);
    var1 setweaponammoclip(var0, int(var10));
    var1 setweaponammostock(var0, int(var7 - var9));

    if(var1 isdualwielding()) {
      var7 = var1 getweaponammostock(var0);
      var8 = var1 getweaponammoclip(var0, "left");
      var9 = min(var6 - var8, var7);
      var10 = min(var8 + var9, var6);
      var1 setweaponammoclip(var0, int(var10), "left");
      var1 setweaponammostock(var0, int(var7 - var9));
      return;
    }

    return;
  }
}

function init_passive_melee_kill(var0) {
  var0.passive_melee_kill_damage = 0;
}

function set_passive_melee_kill(var0) {
  var0.skip_weapon_check = 1;
  var0.passive_melee_kill_damage = 1000;
  var0.onkillrelics["passive_meleekill"] = 1;
}

function unset_passive_melee_kill(var0) {
  var0.skip_weapon_check = undefined;
  var0.passive_melee_kill_damage = 0;
  var0.onkillrelics["passive_meleekill"] = 0;
}

function handlemeleekillpassive(var0, var1, var2, var3, var4, var5) {
  level endon("game_ended");
  self endon("disconnect");

  if(var3 != "MOD_MELEE") {
    return;
  }

  thread handlegoreeffect(level);
  wait 0.05;
  var6 = var2 getcorpseentity();

  if(isDefined(var6)) {
    var6 hide();
    var6.permhidden = 1;
    return;
  }
}

function handlegoreeffect(var0) {
  var1 = var0 gettagorigin("j_spine4");
  playFX(level._effect["gore"], var1, (1, 0, 0));
  playsoundatpos(var1, "gib_fullbody");

  foreach(var3 in level.players) {
    var3 earthquakeforplayer(0.5, 1.5, var1, 120);
  }
}

function init_passive_gore(var0) {}

function set_passive_gore(var0) {
  var0.onkillrelics["passive_gore"] = 1;
}

function unset_passive_gore(var0) {
  var0.onkillrelics["passive_gore"] = 0;
}

function handlegorepassive(var0, var1, var2, var3, var4, var5) {
  level endon("game_ended");
  self endon("disconnect");
  var2 endon("diconnect");
  wait 0.05;
  var6 = var2 getcorpseentity();

  if(!isDefined(var6)) {
    return;
  }

  var7 = var6.origin;
  earthquake(0.5, 1.5, var7, 120);
  playFX(level._effect["corpse_pop"], var7 + (0, 0, 12));

  if(isDefined(var6)) {
    var6 hide();
    var6.permhidden = 1;
    return;
  }
}

function init_passive_health_on_kill(var0) {
  var0.passive_regen_on_kill_count = 0;
}

function set_passive_health_on_kill(var0) {
  var0.onkillrelics["passive_health_on_kill"] = 1;
}

function unset_passive_health_on_kill(var0) {
  var0.onkillrelics["passive_health_on_kill"] = 0;
}

function handlehealthonkillpassive(var0, var1, var2, var3, var4, var5) {
  var1.passive_regen_on_kill_count++;

  if(var1.passive_regen_on_kill_count >= 2) {
    var1 notify("force_regeneration");
    var1.passive_regen_on_kill_count = 0;
    return;
  }
}

function init_passive_health_regen_on_kill(var0) {
  var0.passive_regen_on_kill_count = 0;
}

function set_passive_health_regen_on_kill(var0) {
  var0.onkillrelics["passive_health_regen_on_kill"] = 1;
}

function unset_passive_health_regen_on_kill(var0) {
  var0.onkillrelics["passive_health_regen_on_kill"] = 0;
}

function handlehealthregenonkillpassive(var0, var1, var2, var3, var4, var5) {
  if(var1.passive_regen_on_kill_count >= 2) {
    var1 notify("force_regeneration");
    var1.passive_regen_on_kill_count = 0;
    return;
  }

  var1.passive_regen_on_kill_count++;
}

function init_passive_move_speed_on_kill(var0) {
  var0.weaponpassivespeedonkillmod = 0;
}

function set_passive_move_speed_on_kill(var0) {
  var0.onkillrelics["passive_move_speed_on_kill"] = 1;
}

function unset_passive_move_speed_on_kill(var0) {
  var0.onkillrelics["passive_move_speed_on_kill"] = 0;
}

function handlemovespeedonkillpassive(var0, var1, var2, var3, var4, var5) {
  var6 = "passive_move_speed_on_kill";
  var1 notify(var6);
  var1 endon(var6);

  if(var1.weaponpassivespeedonkillmod != 0.075) {
    var1.weaponpassivespeedonkillmod = 0.075;
    var1[[level.move_speed_scale]]();
  }

  var1 scripts\engine\utility::ref_143ba(5, "death", "disconnect");

  if(!isDefined(var1)) {
    return;
  }

  var1.weaponpassivespeedonkillmod = 0;
  var1[[level.move_speed_scale]]();
}

function init_passive_score_bonus_kills(var0) {}

function set_passive_score_bonus_kills(var0) {
  var0.cash_scalar += 0.1;
  var0.cash_scalar_weapon = scripts\cp\utility::getrawbaseweaponname(var0 getcurrentweapon());
}

function unset_passive_score_bonus_kills(var0) {
  var0.cash_scalar -= 0.1;
  var0.cash_scalar_weapon = undefined;
}

function init_passive_hitman(var0) {}

function set_passive_hitman(var0) {
  var0.onkillrelics["passive_hitman"] = 1;
}

function unset_passive_hitman(var0) {
  var0.onkillrelics["passive_hitman"] = 0;
}

function handlehitmanpassive(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var1) || !var1 scripts\cp_mp\utility\player_utility::_isalive() || !isDefined(var2)) {
    return;
  }

  if(!isDefined(var1.hitmankills)) {
    var1.hitmankills = [];
  } else if(hitmankeyexists(var1, var2.birthtime)) {
    return;
  }

  thread resethitmanaftertimeout();
  var1.hitmankills[var1.hitmankills.size] = var2.birthtime;

  if(var1.hitmankills.size >= 10) {
    var1 notify("consumable_charge", 200);
    var1.hitmankills = [];
    return;
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

function hitmankeyexists(var0, var1) {
  if(!isDefined(var0.hitmankills)) {
    return false;
  }

  foreach(var3 in var0.hitmankills) {
    if(var3 == var1) {
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

function init_passive_nuke(var0) {
  var0.passivenukekillcount = 0;
  var0.lastpassivenukeactivation = 0;
  thread tracklaststandforpassivenuke(var0);
}

function set_passive_nuke(var0) {
  var0.onkillrelics["passive_nuke"] = 1;
}

function unset_passive_nuke(var0) {
  var0.onkillrelics["passive_nuke"] = 0;
}

function trackkillsforpassivenuke(var0, var1, var2, var3, var4, var5) {
  var1.passivenukekillcount++;

  if(var1.passivenukekillcount >= 3) {
    var6 = spawn("script_model", var1.origin);
    var6 thread scripts\cp\utility::delayentdelete(10);
    var7 = scripts\cp\cp_agent_utils::getactiveenemyagents("allies");
    var8 = 0;

    foreach(var10 in var7) {
      var10 kill();
    }

    var1.passivenukekillcount = 0;
    return;
  }
}

function tracklaststandforpassivenuke(var0) {
  level endon("game_ended");
  var0 endon("disconnect");

  for(;;) {
    var0 waittill("last_stand");
    var0.passivenukekillcount = 0;
  }
}

function init_headshot_ammo(var0) {}

function set_headshot_ammo(var0) {
  var0.onkillrelics["passive_headshot_ammo"] = 1;
}

function unset_headshot_ammo(var0) {
  var0.onkillrelics["passive_headshot_ammo"] = 0;
}

function handleheadshotammopassive(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var1) || !isDefined(var0)) {
    return;
  }

  if(!scripts\cp\utility::isheadshot(var0, var4, var3, var1)) {
    return;
  }

  var6 = weaponclipsize(var0);
  adjust_clip_ammo_from_stock(var1, var0, "right", var6);

  if(var1 isdualwielding()) {
    adjust_clip_ammo_from_stock(var1, var0, "left", var6);
    return;
  }
}

function adjust_clip_ammo_from_stock(var0, var1, var2, var3) {
  var4 = var0 getweaponammostock(var1);

  if(var4 < 1) {
    return;
  }

  var5 = var0 getweaponammoclip(var1, var2);
  var6 = var3 - var5;

  if(var4 >= var6) {
    var0 setweaponammostock(var1, var4 - var6);
  } else {
    var6 = var4;
    var0 setweaponammostock(var1, 0);
  }

  var7 = min(var5 + var6, var3);
  var0 setweaponammoclip(var1, int(var7), var2);
}

function init_passive_fortified(var0) {
  var0.has_fortified_passive = 0;
}

function set_passive_fortified(var0) {
  var0.persistentrelics["passive_fortified"] = 1;
  var0.has_fortified_passive = 1;
}

function unset_passive_fortified(var0) {
  var0.persistentrelics["passive_fortified"] = 0;
  var0.has_fortified_passive = 0;
}

function handlefortified(var0, var1, var2) {}

function init_passive_ninja(var0) {}

function set_passive_ninja(var0) {
  var0.persistentrelics["passive_ninja"] = 1;
}

function unset_passive_ninja(var0) {
  var0.persistentrelics["passive_ninja"] = 0;
}

function handleninjaonlastshot(var0, var1, var2) {
  if(!isDefined(var0) || !isDefined(var1)) {
    return;
  }

  var3 = weaponclipsize(var1);
  var4 = var0 getweaponammoclip(var1, "right");

  if(var4 == 0) {
    thread set_player_stealthed();
  }

  if(var4 == 0 && !scripts\engine\utility::array_contains(var0.stealth_used, "right")) {
    thread set_player_stealthed();
  } else if(var4 > 0) {
    var0.stealth_used = scripts\engine\utility::array_remove(var0.stealth_used, "right");
  }

  if(var0 isdualwielding()) {
    var5 = var0 getweaponammoclip(var1, "left");

    if(var5 == 0 && !scripts\engine\utility::array_contains(var0.stealth_used, "left")) {
      thread set_player_stealthed();
      return;
    }

    if(var5 > 0) {
      var0.stealth_used = scripts\engine\utility::array_remove(var0.stealth_used, "left");
      return;
    }

    return;
  }
}

function set_player_stealthed() {
  self notify("reset_stealth");
  self endon("reset_stealth");
  self endon("disconnect");

  if(!scripts\cp\utility::isignoremeenabled()) {
    scripts\cp\utility::allow_player_ignore_me(1);
  }

  playFX(level._effect["stimulus_glow_burst"], scripts\engine\utility::drop_to_ground(self.origin) - (0, 0, 30));
  scripts\engine\utility::play_sound_in_space("zmb_fnf_stimulus", scripts\engine\utility::drop_to_ground(self.origin));

  if(self isdualwielding()) {
    wait 3;
  } else {
    wait 4;
  }

  if(scripts\cp\utility::isignoremeenabled()) {
    scripts\cp\utility::allow_player_ignore_me(0);
    return;
  }
}

function init_passive_last_shots_ammo(var0) {}

function set_passive_last_shots_ammo(var0) {
  var0.onkillrelics["passive_last_shots_ammo"] = 1;
}

function unset_passive_last_shots_ammo(var0) {
  var0.onkillrelics["passive_last_shots_ammo"] = 0;
}

function handleammoonlastshotskill(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var1) || !isDefined(var0)) {
    return;
  }

  var6 = weaponclipsize(var0);
  var7 = var1 getweaponammoclip(var0, "right");

  if(var7 <= int(var6 * 0.2)) {
    adjust_clip_ammo_from_stock(var1, var0, "right", var6);
  }

  if(var1 isdualwielding()) {
    var7 = var1 getweaponammoclip(var0, "left");

    if(var7 <= int(var6 * 0.2)) {
      adjust_clip_ammo_from_stock(var1, var0, "left", var6);
      return;
    }

    return;
  }
}

function init_passive_railgun_overload(var0) {}

function set_passive_railgun_overload(var0) {
  var0.onkillrelics["passive_railgun_overload"] = 1;
}

function unset_passive_railgun_overload(var0) {
  var0.onkillrelics["passive_railgun_overload"] = 0;
}

function dolocalrailgundamage(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var2.hitbychargedshot)) {
    return 0;
  }

  if(!scripts\engine\utility::isbulletdamage(var3)) {
    return 0;
  }

  if(isDefined(var2.agent_type) && (var2.agent_type == "zombie_brute" || var2.agent_type == "zombie_grey" || var2.agent_type == "slasher" || var2.agent_type == "superslasher" || var2.agent_type == "zombie_sasquatch" || var2.agent_type == "lumberjack")) {
    return;
  }

  var6 = istrue(var2.is_suicide_bomber);
  var2.head_is_exploding = 1;
  var7 = var2 gettagorigin("j_spine4");
  playsoundatpos(var2.origin, "zmb_fnf_headpopper_explo");
  playFX(level._effect["bloody_death"], var7);

  if(isDefined(var2.headmodel)) {
    var2 detach(var2.headmodel);
  }

  if(!var6) {
    var2 setscriptablepartstate("head", "hide");
  }

  var2.hitbychargedshot radiusdamage(var2.origin, 64, var2.maxhealth, var2.maxhealth, var2.hitbychargedshot, "MOD_EXPLOSIVE", "iw7_zombieDoors_zm");
  var2.hitbychargedshot = undefined;
}

function init_headshot_super(var0) {
  var0.delayedsuperbonus = 0;
}

function set_headshot_super(var0) {
  var0.onkillrelics["passive_headshot_super"] = 1;
}

function unset_headshot_super(var0) {
  var0.onkillrelics["passive_headshot_super"] = 0;
}

function addvaluetocardmeter(var0, var1, var2, var3, var4, var5) {
  var1.delayedsuperbonus++;
  wait 0.05 * var1.delayedsuperbonus;
  var1.delayedsuperbonus--;

  if(var1.delayedsuperbonus < 0) {
    var1.delayedsuperbonus = 0;
  }

  var1 notify("consumable_charge", 10);
}

function init_passive_sonic(var0) {
  var0.sonictimer = 0;
}

function set_passive_sonic(var0) {
  var0.ondamagerelics["passive_sonic"] = 1;
}

function unset_passive_sonic(var0) {
  var0.ondamagerelics["passive_sonic"] = 0;
}

function handlepassivesonic(var0, var1, var2) {
  var3 = gettime();

  if(var2 scripts\cp\utility::agentisfnfimmune()) {
    return;
  }

  if(var3 <= var0.sonictimer) {
    return;
  }

  if(distance2dsquared(var0.origin, var2.origin) <= 62500) {
    thread scripts\cp\cp_weapon::fx_stun_damage(var2, var0);
  }

  var0.sonictimer = var3 + 1000;
}

function init_passive_crouch_move_speed(var0) {}

function set_passive_crouch_move_speed(var0) {
  thread adjust_move_speed_while_crouched(var0);
  thread adjust_move_speed_while_sliding(var0);
}

function unset_passive_crouch_move_speed(var0) {
  var0 notify("remove_crouch_speed_mod");
  var0.weaponpassivespeedmod = undefined;
}

function adjust_move_speed_while_sliding(var0) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 endon("remove_crouch_speed_mod");

  for(;;) {
    self waittill("sprint_slide_end");

    if(var0 getstance() == "crouch") {
      if(isDefined(level.move_speed_scale)) {
        var0.weaponpassivespeedmod = 0.5;
        var0[[level.move_speed_scale]]();
      }
    }

    while(var0 getstance() == "crouch") {
      wait 0.1;
    }

    var0.weaponpassivespeedmod = undefined;
    var0[[level.move_speed_scale]]();
  }
}

function adjust_move_speed_while_crouched(var0, var1) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 endon("remove_crouch_speed_mod");

  for(;;) {
    if(var0 getstance() == "crouch") {
      if(isDefined(level.move_speed_scale)) {
        var0.weaponpassivespeedmod = 0.5;
        var0[[level.move_speed_scale]]();
      }
    }

    while(var0 getstance() == "crouch") {
      wait 0.1;
    }

    var0.weaponpassivespeedmod = undefined;
    var0[[level.move_speed_scale]]();
    var0 waittill("adjustedStance");
  }
}

function init_passive_infinite_ammo(var0) {}

function set_passive_infinite_ammo(var0) {
  var0 scripts\cp\utility::enable_infinite_ammo(1);
  var0.persistentrelics["passive_infinite_ammo"] = 1;
}

function unset_passive_infinite_ammo(var0) {
  var0 scripts\cp\utility::enable_infinite_ammo(0);
  var0.persistentrelics["passive_infinite_ammo"] = 0;
  var0 notify("cleanup_watcher_threads_passive_infinite_ammo");
}

function handleinfiniteammopassive(var0, var1) {
  var0 endon("disconnect");
  var0 endon("cleanup_watcher_threads_passive_infinite_ammo");

  for(;;) {
    var0 waittill("weapon_fired", var2);
    thread listenforfirecomplete();
    var3 = 4;
    var4 = self.health;

    if(var4 - var3 < 1) {
      var3 = 0;
    }

    if(var3 > 0) {
      var0 dodamage(var3, var0 gettagorigin("j_wrist_ri"), var0, undefined, "MOD_RIFLE_BULLET");
    }

    updateinfiniteammopassive(var0, var2);
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

function updateinfiniteammopassive(var0) {
  var1 = self.health;
  var2 = weaponclipsize(var0);
  self setweaponammoclip(var0, var2);

  if(self isdualwielding()) {
    self setweaponammoclip(var0, var2, "left");
    return;
  }
}

function init_passive_miss_refund(var0) {}

function set_passive_miss_refund(var0) {
  var1 = var0 getcurrentweapon();
  thread missrefundwatcher(var0);
}

function unset_passive_miss_refund(var0) {
  var0 notify("removeMissRefundPassive");
}

function missrefundwatcher(var0) {
  self endon("death");
  self endon("disconnect");
  self endon("removeMissRefundPassive");

  for(;;) {
    self waittill("shot_missed", var1);

    if(var1 == var0) {
      if(randomfloat(1) > 0.75) {
        var2 = self getweaponammostock(var0);
        self setweaponammostock(var0, var2 + 1);
      }
    }
  }
}

function init_passive_scrambler(var0) {}

function set_passive_scrambler(var0) {
  thread handlepassivescrambler(var0);
}

function unset_passive_scrambler(var0) {
  var0 notify("handlePassiveScrambler");
}

function scrambler_executevisuals(var0) {
  level endon("game_ended");
  self endon("disconnect");
  var1 = spawn("script_model", self gettagorigin("tag_eye"));
  var1 setModel("prop_mp_optic_wave_scr");
  var1.angles = self getplayerangles();
  var1 setotherent(self);
  var1 setscriptablepartstate("effects", "active", 0);
  var2 = var1.origin + anglesToForward(var1.angles) * 256;
  var1 moveTo(var2, var0);
  scripts\engine\utility::ref_143ba(var0, "last_stand", "death");

  if(isDefined(var1)) {
    var1 delete();
    return;
  }
}

function handlepassivescrambler(var0) {
  var0 notify("handlePassiveScrambler");
  var0 endon("handlePassiveScrambler");
  level endon("game_ended");
  var0 endon("disconnect");
  var0 endon("last_stand");
  var0 endon("death");

  for(;;) {
    if(randomint(100) > 85) {
      var1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
      var2 = scripts\engine\utility::get_array_of_closest(var0.origin, var1, undefined, 24, 256);
      var3 = 0;

      foreach(var5 in var2) {
        if(scripts\engine\utility::within_fov(var0 getEye(), var0.angles, var5.origin, cos(65))) {
          if(!var3) {
            thread scrambler_executevisuals(var0);
          }

          thread scrambler_stun_damage(var5, var0);
          var3++;
        }
      }
    }

    wait randomfloatrange(5, 10);
  }
}

function scrambler_stun_damage(var0, var1) {
  var0 endon("death");

  if(isDefined(var0.stun_hit_time)) {
    if(gettime() > var0.stun_hit_time) {
      var0.allowpain = 1;
      var0.stun_hit_time = gettime() + 1000;
      var0.stunned = 1;
    } else {
      return;
    }
  } else {
    var0.allowpain = 1;
    var0.stun_hit_time = gettime() + 1000;
    var0.stunned = 1;
  }

  var0 dodamage(1, var0.origin, var1, var1, "MOD_UNKNOWN", "iw7_scrambler_zm");
  thread addhealthback(var0);
  wait 1;
  var0.allowpain = 0;
  var0.stunned = undefined;
}

function addhealthback(var0) {
  var0 endon("death");
  waittillframeend();

  if(var0.health < var0.maxhealth) {
    var0.health += 1;
    return;
  }
}

function init_passive_random_perks(var0) {
  var0.passiverandomperkskillcount = 0;
  thread tracklaststandforpassiverandomperks(var0);
}

function tracklaststandforpassiverandomperks(var0) {
  level endon("game_ended");
  var0 endon("disconnect");

  for(;;) {
    var0 waittill("last_stand");
    var0.passiverandomperkskillcount = 0;
  }
}

function set_passive_random_perks(var0) {
  var0.onkillrelics["passive_random_perks"] = 1;
}

function trackkillsforrandomperks(var0, var1, var2, var3, var4, var5) {
  var1 endon("disconnect");
  var1 endon("last_stand");
  var1 endon("death");
  var1.passiverandomperkskillcount++;

  if(var1.passiverandomperkskillcount >= 75) {
    var6 = level.perks;
    var1.passiverandomperkskillcount = 0;

    if(!isDefined(var1.zombies_perks) || var1.zombies_perks.size < 5) {
      for(;;) {
        var7 = scripts\engine\utility::random(var6);

        if(!var1 scripts\cp\utility::has_zombie_perk(var7)) {
          var1 iprintln(" zombies_perk_machines is disabled for now!. Can be reenabled based on requirements. ");
          break;
        } else {
          var6 = scripts\engine\utility::array_remove(var6, var7);
        }

        waitframe();
      }

      return;
    }

    return;
  }
}

function unset_passive_random_perks(var0) {
  var0.onkillrelics["passive_random_perks"] = 0;
}

function init_passive_melee_super(var0) {}

function set_passive_melee_super(var0) {
  var0.skip_weapon_check = 1;
  var0.onkillrelics["passive_melee_super"] = 1;
}

function unset_passive_melee_super(var0) {
  var0.skip_weapon_check = undefined;
  var0.onkillrelics["passive_melee_super"] = 0;
}

function handlemeleesuper(var0, var1, var2, var3, var4, var5) {
  level endon("game_ended");
  var1 endon("disconnect");

  if(isDefined(var3) && var3 == "MOD_MELEE") {
    var1 notify("consumable_charge", 125);
    return;
  }
}

function init_passive_jump_super(var0) {}

function set_passive_jump_super(var0) {
  var0.onkillrelics["passive_jump_super"] = 1;
  var0.current_weapon_jump_super = scripts\cp\utility::getrawbaseweaponname(var0 getcurrentweapon());
}

function unset_passive_jump_super(var0) {
  var0.onkillrelics["passive_jump_super"] = 0;
  var0.current_weapon_jump_super = undefined;
}

function handleairbornesuper(var0, var1, var2, var3, var4, var5) {
  level endon("game_ended");
  var1 endon("disconnect");

  if(!var1 isonground() && isDefined(var1.current_weapon_jump_super) && scripts\cp\utility::getrawbaseweaponname(var0) == var1.current_weapon_jump_super) {
    var1 notify("consumable_charge", 75);
    return;
  }
}

function init_passive_double_kill_super(var0) {}

function set_passive_double_kill_super(var0) {
  var0.onkillrelics["passive_double_kill_super"] = 1;
  var0.current_weapon_double_super = scripts\cp\utility::getrawbaseweaponname(var0 getcurrentweapon());
}

function unset_passive_double_kill_super(var0) {
  var0.onkillrelics["passive_double_kill_super"] = 0;
  var0.current_weapon_double_super = undefined;
}

function handledoublekillssuper(var0, var1, var2, var3, var4, var5) {
  level endon("game_ended");
  var1 endon("disconnect");

  if(isDefined(var1.recentkillcount) && isDefined(var1.current_weapon_double_super) && scripts\cp\utility::getrawbaseweaponname(var0) == var1.current_weapon_double_super) {
    if(var1.recentkillcount == 2) {
      var1 notify("consumable_charge", 125);
      return;
    }

    return;
  }
}

function init_passive_mode_switch_score(var0) {}

function set_passive_mode_switch_score(var0) {
  var0.alt_mode_passive = 1;
  var0.cash_scalar_alt_weapon = scripts\cp\utility::getrawbaseweaponname(var0 getcurrentweapon());
  var0.cash_scalar += 0.1;
}

function unset_passive_mode_switch_score(var0) {
  var0.cash_scalar -= 0.1;
  var0.cash_scalar_alt_weapon = undefined;
  var0.alt_mode_passive = 0;
}

function init_passive_visor_detonation(var0) {}

function set_passive_visor_detonation(var0) {
  var0.onkillrelics["passive_visor_detonation"] = 1;
}

function unset_passive_visor_detonation(var0) {
  var0.onkillrelics["passive_visor_detonation"] = 0;
}

function handlevisordetonation(var0, var1, var2, var3, var4, var5) {
  if(!scripts\engine\utility::isbulletdamage(var3)) {
    return 0;
  }

  if(!scripts\cp\utility::isheadshot(var0, var4, var3, var1)) {
    return 0;
  }

  if(isDefined(var2.agent_type) && (var2.agent_type == "zombie_brute" || var2.agent_type == "zombie_grey" || var2.agent_type == "slasher" || var2.agent_type == "superslasher" || var2.agent_type == "zombie_sasquatch" || var2.agent_type == "lumberjack")) {
    return;
  }

  var6 = istrue(var2.is_suicide_bomber);
  var2.head_is_exploding = 1;
  var7 = var2 gettagorigin("j_spine4");
  playsoundatpos(var2.origin, "zmb_fnf_headpopper_explo");
  playFX(level._effect["bloody_death"], var7);

  if(isDefined(var2.headmodel)) {
    var2 detach(var2.headmodel);
  }

  if(!var6) {
    var2 setscriptablepartstate("head", "hide");
    return;
  }
}

function passive_visor_detonation_activate() {
  self endon("death");
  self endon("disconnect");
  self endon("end_passive_visor_detonation");

  for(;;) {
    self waittill("headshot_done_with_this_weapon", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);
    waitframe();
  }
}

function init_passive_berserk(var0) {}

function set_passive_berserk(var0) {
  var0.onkillrelics["passive_berserk"] = 1;
}

function unset_passive_berserk(var0) {
  var0.onkillrelics["passive_berserk"] = 0;
}

function handleberserk(var0, var1, var2, var3, var4, var5) {
  if(!istrue(var1.berserk)) {
    var1.berserk = 1;
    var1 setfiretimescaleon(65);
    var6 = var1 player_getrecoilscale();

    if(var6 < 0) {
      var6 = 100;
    }

    var6 = max(var6 - 20, 0);
    var1 player_recoilscaleon(int(var6));
  }

  var1 notify("stop_berserk_timer");
  thread remove_berserk_after_timeout(var1);
}

function remove_berserk_after_timeout(var0) {
  self endon("end_berserk");
  self endon("stop_berserk_timer");
  self endon("death");
  self endon("disconnect");
  thread listencancelberserk();
  wait var0;
  unset_berserk();
}

function listencancelberserk() {
  self endon("end_berserk");
  self endon("stop_berserk_timer");
  self endon("disconnect");
  scripts\engine\utility::ref_143a5("death", "weapon_change");
  unset_berserk();
}

function unset_berserk() {
  if(istrue(self.berserk)) {
    self.berserk = 0;
    self setfiretimescaleoff();
    var0 = self player_getrecoilscale();
    var0 = min(var0 + 20, 100);
    self player_recoilscaleon(int(var0));
    self notify("end_berserk");
    return;
  }
}

function unsetquadfeederpassive() {
  self notify("end_quadFeederEffect");
  self notify("end_quadFeederPassive");
  unset_berserk();
}

function init_passive_melee_cone_expl(var0) {}

function set_passive_melee_cone_expl(var0) {
  var0.onkillrelics["passive_melee_cone_expl"] = 1;
  var0.skip_weapon_check = 1;
}

function unset_passive_melee_cone_expl(var0) {
  var0.onkillrelics["passive_melee_cone_expl"] = 0;
  var0.skip_weapon_check = undefined;
}

function handlemeleeconeexplode(var0, var1, var2, var3, var4, var5) {
  if(var3 != "MOD_MELEE") {
    return;
  }

  if(!issubstr(var0, "meleervn") && !var1 isalternatemode(var0)) {
    return;
  }

  var6 = var2 gettagorigin("j_spineupper");
  var7 = var1 getplayerangles();
  var8 = anglesToForward(var7);
  var9 = anglestoup(var7);
  var10 = var6 - var8 * 128;
  var11 = 384;
  playFX(level._effect["cone_expl_fx"], var6 + (0, 2, 0), var8, var9);
  var12 = scripts\cp\cp_agent_utils::get_alive_enemies();

  foreach(var14 in var12) {
    if(isDefined(var14.flung) || isDefined(var14.agent_type) && (var14.agent_type == "zombie_brute" || var14.agent_type == "zombie_ghost" || var14.agent_type == "zombie_grey" || var14.agent_type == "slasher" || var14.agent_type == "superslasher")) {
      continue;
    }

    if(!scripts\engine\math::pointvscone(var14 gettagorigin("tag_origin"), var10, var8, var9, var11, 128, 12)) {
      continue;
    }

    if(var14 damageconetrace(var6, var1) <= 0) {
      continue;
    }

    var15 = int(1500 * var1 scripts\cp\cp_weapon::get_weapon_level(var0));
    wait 0.05;
    var14 dodamage(var15, var6, var1, var1, "MOD_EXPLOSIVE", var0);
  }
}

function init_passive_minimap_damage(var0) {}

function set_passive_minimap_damage(var0) {
  var0.ondamagerelics["passive_minimap_damage"] = 1;
}

function unset_passive_minimap_damage(var0) {
  var0.ondamagerelics["passive_minimap_damage"] = 0;
}

function updatepassiveminimapdamage(var0, var1, var2) {
  if(!isDefined(var2)) {
    return;
  }

  var3 = "outlinefill_depth_orange";

  if(isDefined(var2.damaged_by_players)) {
    var3 = "outlinefill_depth_yellow";
  }

  if(isDefined(var2.marked_for_challenge)) {
    var3 = "outlinefill_depth_white";
  } else {
    var3 = "outlinefill_depth_orange";
  }

  thread set_outline_passive_minimap_damage(level, var0, var2);
}

function enable_outline_for_players(var0, var1, var2, var3) {
  var0 hudoutlineenableforclients(var1, var2);
}

function set_outline_passive_minimap_damage(var0, var1, var2) {
  level endon("game_ended");
  level endon("outline_disabled");

  if(!isDefined(var1)) {
    return;
  }

  if(!isDefined(var2)) {
    var2 = "outlinefill_depth_orange";
  }

  enable_outline_for_players(var1, level.players, var2, "high");
  wait 10;
  unset_outline_passive_minimap_damage(var1);
}

function disable_outline_for_players(var0, var1) {
  var0 hudoutlinedisableforclients(var1);
}

function unset_outline_passive_minimap_damage(var0) {
  if(!isDefined(var0)) {
    return;
  }

  scripts\cp\cp_outline::disable_outline_for_players(var0, level.players);
}

function activate_adrenaline_boost(var0) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 endon("last_stand");
  var0 endon("death");
  var0 scripts\cp\utility::adddamagemodifier("health_boost", 0.2, 0);
  var0 notify("force_regeneration");
  var0 playlocalsound("breathing_heartbeat_alt");
  wait 5;
  var0 scripts\cp\utility::removedamagemodifier("health_boost", 0);
  var0 playlocalsound("breathing_limp");
}

function adr_boost(var0) {
  var0 notify("updatepassiveminimapdamage");
  level endon("game_ended");
  var0 endon("disconnect");
  var0 endon("last_stand");
  var0 endon("death");

  for(;;) {
    if(randomint(100) > 30) {
      thread run_adrenaline_visuals(var0, 5);
      thread activate_adrenaline_boost(var0);
    }

    wait randomfloatrange(5, 15);
  }
}

function remove_adrenaline_visuals(var0) {
  var0 endon("disconnect");
  var0 endon("last_stand");
  var0 endon("death");
  var0 visionsetnakedforplayer("", 0.5);
}

function run_adrenaline_visuals(var0, var1) {
  var0 endon("disconnect");
  var0 endon("last_stand");
  var0 endon("death");
  var0 endon("remove_adrenaline_visuals");
  var0 visionsetnakedforplayer("missilecam", scripts\engine\utility::ter_op(1, 0.1, 0));
  var0 scripts\engine\utility::ref_143b9(var1, "last_stand");
  thread remove_adrenaline_visuals(var0);
}

function init_passive_cold_damage(var0) {}

function set_passive_cold_damage(var0) {
  var0.ondamagerelics["passive_cold_damage"] = 1;
  var0.cold_weapon = var0 getcurrentweapon();
}

function unset_passive_cold_damage(var0) {
  var0.ondamagerelics["passive_cold_damage"] = 0;
  var0.cold_weapon = undefined;
}

function updatepassivecolddamage(var0, var1, var2) {
  var3 = isDefined(var2.agent_type) && var2.agent_type == "zombie_brute";
  var4 = isDefined(var2.agent_type) && var2.agent_type == "zombie_grey";
  var5 = istrue(var2.is_suicide_bomber);

  if(var3 || var4 || var5) {
    return;
  }

  if(isDefined(var0.cold_weapon)) {
    if(scripts\cp\utility::getrawbaseweaponname(var0.cold_weapon) == scripts\cp\utility::getrawbaseweaponname(var1)) {
      thread unsetslowmovementaftertime(var2, var2);
      var2.movemode = "slow_walk";
      var2 scripts\asm\asm_bb::bb_requestmovetype("slow_walk");
      return;
    }

    return;
  }
}

function unsetslowmovementaftertime(var0, var1) {
  level endon("game_ended");
  var0 endon("death");
  wait 10;

  if(isDefined(var1)) {
    var0.movemode = var1;
    var0 scripts\asm\asm_bb::bb_requestmovetype(var1);
    return;
  }
}

function init_passive_scorestreak_damage(var0) {}

function set_passive_scorestreak_damage(var0) {
  var0.special_zombie_damage = 1.1;
}

function unset_passive_scorestreak_damage(var0) {
  var0.special_zombie_damage = undefined;
}

function init_passive_scope_radar(var0) {
  var0.activate_radar = 0;
  var0 notifyonplayercommand("scope_radar_ads_in", "+speed_throw");
  var0 notifyonplayercommand("scope_radar_ads_out", "-speed_throw");
}

function set_passive_scope_radar(var0) {
  thread updatescoperadar(var0);
}

function unset_passive_scope_radar(var0) {
  var0 notify("unsetScopeRadar");
  thread cleanup_outlines(var0);
}

function updatescoperadar(var0) {
  var0 notify("updateScopeRadar");
  var0 endon("updateScopeRadar");
  level endon("game_ended");
  var0 endon("death");
  var0 endon("disconnect");
  var0 endon("unsetScopeRadar");
  var1 = 2.4;
  var2 = 1750;

  for(;;) {
    if(!var0 adsButtonPressed()) {
      var3 = var0 scripts\engine\utility::ref_143b7("scope_radar_ads_in", "scope_radar_ads_out", "last_stand", "death", "weapon_change");
    } else {
      var3 = "scope_radar_ads_in";
    }

    if(var3 == "scope_radar_ads_in") {
      runscoperadarinloop(var0, var1, var2);
    }

    thread remove_visuals(var0);
  }
}

function runscoperadarinloop(var0, var1, var2) {
  level endon("game_ended");
  var0 notify("runScopeRadarInLoop");
  var0 endon("runScopeRadarInLoop");
  var0 endon("scope_radar_ads_out");
  var0 endon("last_stand");
  var0 endon("death");
  var0 endon("disconnect");
  var3 = 0.75;

  while(var0 adsButtonPressed()) {
    if(var0 playerads() >= var3) {
      var0 playlocalsound("uav_ping");
      thread scoperadar_executeping(var0, var0, var1);
      scoperadar_executevisuals(var0, var0, var1);
    }

    waitframe();
  }
}

function scoperadar_executeping(var0, var1, var2) {
  level endon("game_ended");
  var0 endon("death");
  var0 endon("scope_radar_ads_out");
  var3 = 0;
  var4 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var5 = scripts\engine\utility::get_array_of_closest(var0.origin, var4, undefined, 24, var2);
  var0.closestenemies = var5;
  var6 = 0;

  foreach(var8 in var0.closestenemies) {
    var8.is_outlined_from_scoperadar = 0;

    if(scripts\engine\utility::within_fov(var0 getEye(), var0.angles, var8.origin, cos(65))) {
      var6++;
      var9 = var8.origin - var0.origin;

      if(1 && vectordot(anglesToForward(var0.angles), var9) < 0) {
        continue;
      }

      var10 = var2 * var2;

      if(length2dsquared(var9) > var10) {
        continue;
      }

      thread outlineplayerbydistance(var0, var8, var0, distance2d(var0.origin, var8.origin) / var2);
      var3 = 1;
    }
  }
}

function enable_outline_for_player(var0, var1, var2, var3) {
  var0 hudoutlineenableforclient(var1, var2);
}

function outlineplayerbydistance(var0, var1, var2, var3) {
  level endon("game_ended");
  var1 endon("scope_radar_ads_out");
  var1 endon("last_stand");
  var1 endon("death");
  var1 endon("disconnect");
  var1 endon("weapon_change");
  wait var3 * var2;
  var4 = 1;
  var0.is_outlined_from_scoperadar = 1;
  enable_outline_for_player(var0, var1, var4, 1, 1, "high");
}

function watchhighlightfadetime(var0, var1, var2) {
  var0 endon("disconnect");
  level endon("game_ended");
  var0 scripts\engine\utility::ref_143bf(var2);

  if(isDefined(var1)) {
    disable_outline_for_player(var1, var0);
    return;
  }
}

function disable_outline_for_player(var0, var1) {
  var0 hudoutlinedisableforclient(var1);
}

function scoperadar_executevisuals(var0, var1) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 visionsetnakedforplayer("opticwave_mp", 0.2);
  var0.fxent = spawn("script_model", var0 gettagorigin("tag_eye"));
  var0.fxent setModel("prop_mp_optic_wave_scr");
  var0.fxent.angles = var0 getplayerangles();
  var0.fxent setotherent(var0);
  var0.fxent setscriptablepartstate("effects", "active", 0);
  var2 = var0.fxent.origin + anglesToForward(var0.fxent.angles) * 1750;
  var0.fxent moveTo(var2, var1);
  var0 scripts\engine\utility::ref_143c3(var1, "last_stand", "death", "scope_radar_ads_out", "weapon_change", "unsetScopeRadar");

  if(isDefined(var0.closestenemies)) {
    foreach(var4 in var0.closestenemies) {
      if(isDefined(var4)) {
        if(istrue(var4.is_outlined_from_scoperadar)) {
          disable_outline_for_player(var4, var0);
          var4.is_outlined_from_scoperadar = 0;
        }
      }
    }
  }

  var0 visionsetnakedforplayer("", 0.1);

  if(isDefined(var0.fxent)) {
    var0.fxent delete();
    return;
  }
}

function remove_visuals(var0) {
  var1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(var3 in var1) {
    if(isDefined(var3)) {
      if(istrue(var3.is_outlined_from_scoperadar)) {
        disable_outline_for_player(var3, var0);
        var3.is_outlined_from_scoperadar = 0;
      }
    }
  }

  if(isDefined(var0.fxent)) {
    var0.fxent delete();
    return;
  }
}

function cleanup_outlines(var0) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 endon("last_stand");
  var0 endon("death");
  var1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(var3 in var1) {
    if(isDefined(var3)) {
      if(istrue(var3.is_outlined_from_scoperadar)) {
        disable_outline_for_player(var3, var0);
        var3.is_outlined_from_scoperadar = 0;
      }
    }
  }
}

function init_passive_scoutping(var0) {}

function set_passive_scoutping(var0) {
  thread updatescoutping(var0);
}

function unset_passive_scoutping(var0) {
  var0 notify("unsetScoutPing");
}

function updatescoutping(var0) {
  var0 endon("death");
  var0 endon("disconnect");
  var0 endon("unsetScoutPing");
  var1 = 1000;
  var2 = 0.1;

  for(;;) {
    var3 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var4 = var1;
    var5 = var2;
    var4 = int(var4);
    var5 = float(var5);

    if(isDefined(var3)) {
      var6 = scripts\engine\utility::get_array_of_closest(var0.origin, var3, undefined, 24, var4);
    } else {
      waitframe();
      continue;
    }

    if(var6.size >= 1) {
      foreach(var8 in var6) {
        scripts\cp\cp_outline::enable_outline_for_players(var8, level.players, "outline_nodepth_red", "low");
        wait var5;
      }

      continue;
    }

    waitframe();
  }
}

function updateonkillrelics(var0, var1, var2, var3, var4) {
  if(!isDefined(var1.onkillrelics)) {
    return;
  }

  var5 = gettime();
  var6 = getarraykeys(var1.onkillrelics);

  if(!isDefined(var6)) {
    return;
  }

  foreach(var8 in var6) {
    if(istrue(var1.onkillrelics[var8])) {
      GscBinSkip1(0x74, level.onkillrelics[var8], var0, var1, var2, var3, var4, var5);
    }
  }
}

function updatepersistentrelics(var0) {
  if(!isDefined(var0.persistentrelics)) {
    return;
  }

  var1 = gettime();
  var2 = getarraykeys(var0.persistentrelics);

  if(!isDefined(var2)) {
    return;
  }

  foreach(var4 in var2) {
    if(istrue(var0.persistentrelics[var4])) {
      var0 thread[[level.persistentrelics[var4]]](var0);
    }
  }
}

function updateondamagerelics(var0, var1, var2, var3, var4, var5) {
  var6 = undefined;

  if(isPlayer(var2)) {
    var6 = var2;
  } else if(isPlayer(var0)) {
    var6 = var0;
  }

  if(!isDefined(var6)) {
    return;
  }

  if(!isDefined(var6.ondamagerelics)) {
    return;
  }

  var5 = gettime();
  var7 = getarraykeys(var6.ondamagerelics);

  if(!isDefined(var7)) {
    return;
  }

  foreach(var9 in var7) {
    if(istrue(var6.ondamagerelics[var9])) {
      GscBinSkip1(0x74, level.ondamagerelics[var9], var0, var1, var2, var3, var4, var5);
    }
  }
}

function ref_13fff(var0, var1, var2, var3, var4, var5) {
  var6 = undefined;

  if(isPlayer(var2)) {
    var6 = var2;
  } else if(isPlayer(var0)) {
    var6 = var0;
  } else if(isDefined(var0.owner) && isPlayer(var0.owner)) {
    var6 = var0.owner;
  }

  if(!isDefined(var6)) {
    return;
  }

  if(!isDefined(var6.ondamagerelics)) {
    return;
  }

  var5 = gettime();
  var7 = getarraykeys(var6.ondamagerelics);

  if(!isDefined(var7)) {
    return;
  }

  foreach(var9 in var7) {
    if(isDefined(var6.ref_12015)) {
      if(istrue(var6.ref_12015[var9])) {
        if(isDefined(level.ref_12015[var9])) {
          GscBinSkip1(0x74, level.ref_12015[var9], var0, var1, var2, var3, var4, var5);
        }
      }
    }
  }
}

function ref_13fd3(var0, var1) {
  var2 = undefined;

  if(!isPlayer(var1.eattacker)) {
    if(!isDefined(var1.eattacker.owner)) {
      return;
    } else {
      var2 = var1.eattacker.owner;
    }
  } else {
    var2 = var1.eattacker;
  }

  if(!isDefined(var2) || !isDefined(var2.ref_12020)) {
    return;
  }

  var3 = gettime();
  var4 = getarraykeys(var2.ref_12020);

  if(!isDefined(var4)) {
    return;
  }

  foreach(var6 in var4) {
    if(istrue(var2.ref_12020[var6])) {
      GscBinSkip1(0x74, level.ref_12020[var6], var0, var1);
    }
  }
}

function init() {
  if(scripts\cp\utility::turn_off_sniper_laser() || scripts\cp\utility::tryingtoleave()) {
    return;
  }

  zombiepingrate();
  register_relics();
  relics_monitor();
  thread player_connect_monitor();
}

function zombiepingrate() {
  level._effect["headshot_explode"] = loadfx("vfx/iw8_cp/misc/vfx_cp_head_explode.vfx");
  level._effect["headshot_explode_jugg"] = loadfx("vfx/iw8_cp/misc/vfx_cp_head_explode_jug.vfx");
  level._effect["healthpack_pickup"] = loadfx("vfx/iw8_cp/vfx_healthpack_vanish.vfx");
  level._effect["healthpack_spawn"] = loadfx("vfx/iw8_cp/vfx_healthpack.vfx");
  level._effect["stump_landing"] = loadfx("vfx/iw8_mp/killstreak/vfx_carepkg_landing_dust.vfx");
}

function player_connect_monitor() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var0);
    taken_damage_for_molotov_achievement(var0);
    thread ref_12baf();
  }
}

function taken_damage_for_molotov_achievement(var0) {
  var0.onkillrelics = [];
  var0.persistentrelics = [];
  var0.ondamagerelics = [];
  var0.relics = [];
}

function relics_monitor() {
  level endon("game_ended");
  zombienumtoconsume();
}

function ref_12baf() {
  var0 = self;
  level endon("game_ended");
  var0 endon("disconnect");
  var0 notify("relics_monitor");
  var0 endon("relics_monitor");
  var0.activated_relics = [];
  scripts\engine\utility::flag_wait("create_script_initialized");
  init_and_set_relics(var0, var0);

  for(;;) {
    var0 waittill("relic_update", var1, var2);

    if(isDefined(var2)) {
      if(!istrue(var2)) {
        unset_relics(var0, var1);
        continue;
      }

      set_relics(var0, var1);
    }
  }
}

function zombienumtoconsume() {
  level.set_relics = [];
  var0 = getDvar("scr_set_relics", "");
  var1 = strtok(var0, ",");

  foreach(var3 in var1) {
    if(isDefined(var3) && var3 != "") {
      level.set_relics[var3] = 1;
      thread ref_12de4(level);
    }
  }
}

function ref_12de4(var0) {
  if(isDefined(level.select_bridge_three_spawners[var0]) && isbuiltinfunction(level.select_bridge_three_spawners[var0])) {
    level thread[[level.select_bridge_three_spawners[var0]]]();
    return;
  }
}

function load_relics_via_dvar() {
  level endon("game_ended");
  level.set_relics = [];

  for(;;) {
    var0 = getDvar("scr_set_relics", "");
    var1 = strtok(var0, ",");

    foreach(var3 in var1) {
      if(istrue(level.set_relics[var3])) {
        waitframe();
        continue;
      }

      if(isDefined(var3) && var3 != "") {
        level.set_relics[var3] = 1;

        foreach(var5 in level.players) {
          var5 notify("relic_update", var3, 1);
        }
      }
    }

    waitframe();
  }
}

function ref_130fd(var0) {
  var1 = self;

  if(!isDefined(var1.ref_12b71)) {
    var1.ref_12b71 = 1;
  } else {
    var1.ref_12b71 += 1;
  }

  var2 = tablelookup("cp/cp_relic_table.csv", 1, var0, 0);
  var3 = int(var2);
  var4 = "cp_relic_1";

  switch (var1.ref_12b71) {
    case 1:
      var4 = "cp_relic_1";
      break;
    case 2:
      var4 = "cp_relic_2";
      break;
    case 3:
      var4 = "cp_relic_3";
      break;
    case 4:
      var4 = "cp_relic_4";
      break;
  }

  var1 setclientomnvar(var4, var3);
}

function unload_relics_via_dvar() {
  level endon("game_ended");

  for(;;) {
    var0 = getDvar("scr_unset_relics", "");
    var1 = strtok(var0, ",");

    foreach(var3 in var1) {
      if(istrue(level.set_relics[var3])) {
        if(isDefined(var3) && var3 != "") {
          foreach(var5 in level.players) {
            var5 notify("relic_update", var3, 0);
          }

          level.set_relics[var3] = undefined;
        }
      }
    }

    waitframe();
  }
}

function debug_set_relic(var0, var1) {
  if(isDefined(var1) && isDefined(level.cp_relics[var1])) {
    var0.relics[var1] = level.cp_relics[var1];
    set_relics(var0, var1);
    return;
  }
}

function debug_unset_relic(var0, var1) {
  if(isDefined(var1) && isDefined(level.cp_relics[var1])) {
    var0.relics[var1] = level.cp_relics[var1];
    unset_relics(var0, var1);
    return;
  }
}

function init_and_set_relics(var0) {
  foreach(var4, var2 in level.set_relics) {
    var3 = level.cp_relics[var4];
    var4 = var3.name;
    set_relics(var0, var4);
  }
}

function unset_relics(var0, var1) {
  var2 = level.cp_relics[var1];

  if(!isDefined(var2)) {
    return;
  }

  if(isDefined(var2)) {
    if(isDefined(var2) && isDefined(var2.unset_func)) {
      [[var2.unset_func]](var0);
    }

    var0.activated_relics = scripts\engine\utility::array_remove(var0.activated_relics, var2.name);
    return;
  }
}

function set_relics(var0, var1) {
  var2 = level.cp_relics[var1];

  if(!isDefined(var2)) {
    return;
  }

  if(isDefined(var2)) {
    if(isDefined(var2) && isDefined(var2.init_func)) {
      [[var2.init_func]](var0);
    }
  }

  if(isDefined(var2) && isDefined(var2.set_func)) {
    [[var2.set_func]](var0);
  }

  if(isDefined(level.updatepersistentrelicsfunc)) {
    level thread[[level.updatepersistentrelicsfunc]](var0);
  }

  var0.activated_relics = scripts\engine\utility::array_add(var0.activated_relics, var2.name);
  ref_130fd(var0, var2.name);
}

function register_relic(var0, var1, var2, var3) {
  var4 = spawnStruct();
  var4.init_func = var1;
  var4.set_func = var2;
  var4.unset_func = var3;
  var4.name = var0;
  level.cp_relics[var0] = var4;
}

function parserelicstable() {
  if(!isDefined(level.lootpassivesstructs)) {
    level.lootpassivesstructs = [];
  }

  for(var0 = 0;; var0++) {
    var1 = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var0, 0);

    if(var1 == "") {
      break;
    }

    var2 = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var0, 1);
    var3 = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var0, 2);
    var4 = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var0, 12);
    var5 = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var0, 13);
    var6 = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var0, 15);
    var7 = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var0, 23);
    var8 = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var0, 24);
    var9 = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var0, 25);
    var10 = spawnStruct();
    var10.name = var2;
    var10.passivestringref = var3;
    var10.passiveindex = int(var1);
    var10.weapontype = scripts\engine\utility::ter_op(tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var0, 8) == "", 0, 1);
    var10.killstreaktype = scripts\engine\utility::ter_op(tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var0, 9) == "", 0, 1);
    var10.lethaltype = scripts\engine\utility::ter_op(tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var0, 10) == "", 0, 1);
    var10.tacticaltype = scripts\engine\utility::ter_op(tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var0, 11) == "", 0, 1);

    if(var4 != "") {
      var10.attachmentref = var4;
    }

    if(getDvar("MOLPOSLOMO") == "zombie" || getDvar("MOLPOSLOMO") == "cp_strike") {
      var11 = tablelookupbyrow("cp/zombies/loot_Weapons_Passivetable.csv", var0, 22);

      if(var11 != "") {
        var10.attachmentref = var11;
      }
    }

    if(var5 != "") {
      var10.perkref = var5;
    }

    if(var6 != "") {
      var10.messageref = var6;
    }

    if(isDefined(var7)) {
      var10.prdprobability = int(var7);
    }

    if(isDefined(var8)) {
      var10.prdconstant = float(var8);
    }

    if(isDefined(var9)) {
      var10.maxrolls = int(var9);
    }

    if(!isDefined(level.lootpassivesstructs[var2])) {
      level.lootpassivesstructs[var2] = var10;
    }
  }
}

function updaterecentkills(var0, var1) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentKills");
  self endon("updateRecentKills");
  self.recentkillcount++;
  var2 = getweaponbasename(var1);

  if(!isDefined(self.killsperweaponlog[var2])) {
    self.killsperweaponlog[var2] = 1;
  } else {
    self.killsperweaponlog[var2]++;
  }

  if(!isDefined(self.recentkillsperweapon)) {
    self.recentkillsperweapon = [];
  }

  if(!isDefined(self.recentkillsperweapon[var2])) {
    self.recentkillsperweapon[var2] = 1;
  } else {
    self.recentkillsperweapon[var2]++;
  }

  wait 3.5;
  self.recentkillcount = 0;
  self.recentkillsperweapon = undefined;
}

function init_relic_collat_dmg(var0) {}

function set_relic_collat_dmg(var0) {
  var0.ondamagerelics["relic_collat_dmg"] = 1;
  level.explosivedamagemod = 0.4;
  var0.onkillrelics["relic_collat_dmg"] = 1;
}

function unset_relic_collat_dmg(var0) {
  level.explosivedamagemod = undefined;
  var0.ondamagerelics["relic_collat_dmg"] = 0;
  var0.onkillrelics["relic_collat_dmg"] = 0;
}

function ref_12016(var0, var1, var2, var3, var4, var5) {
  if(!isagent(var2)) {
    return;
  }

  if(!scripts\cp\utility::isheadshot(var1, var4, var3, var0) && var3 != "MOD_MELEE" && var3 != "MOD_IMPACT") {
    return;
  }

  var2.nocorpse = 1;
}

function handlereliccollatdamage(var0, var1, var2, var3, var4, var5) {
  if(!scripts\cp\utility::isheadshot(var0, var4, var3, var1) && var3 != "MOD_MELEE" && var3 != "MOD_IMPACT") {
    return;
  }

  var6 = isDefined(var2.unittype) && var2.unittype == "juggernaut";
  var7 = var2.origin;

  if(var2 tagexists("j_head")) {
    var7 = var2 gettagorigin("j_head");
  } else if(var2 tagexists("tag_eye")) {
    var7 = var2 gettagorigin("tag_eye");
  }

  var2.clear_keypad_currentdisplay_models = 1;

  if(var6) {
    radiusdamage(var2.origin + (0, 0, 60), 512, 666, 69, undefined, "MOD_RIFLE_BULLET");
    scripts\mp\vehicles\vehicle_compass_mp::ref_12e0b("Earthquake", 1, 0.6, var2.origin, 84);
    playFX(level._effect["headshot_explode_jugg"], var7);
    var2 playSound("gib_fullbody");
  } else {
    radiusdamage(var2.origin + (0, 0, 60), 333, 333, 33, undefined, "MOD_RIFLE_BULLET");
    scripts\mp\vehicles\vehicle_compass_mp::ref_12e0b("Earthquake", 1, 0.6, var2.origin, 84);
    playFX(level._effect["headshot_explode"], var7);
    var2 playSound("gib_fullbody");
  }

  playrumbleonposition("grenade_rumble", var2.origin);
}

function init_relic_catch(var0) {
  level.grenade_drop_cooldown = [];
}

function set_relic_catch(var0) {
  var0.onkillrelics["relic_catch"] = 1;
  scripts\cp\cp_agent_damage::register_drop_func("grenade", &drop_grenade, &should_drop_grenade, 0);
}

function unset_relic_catch(var0) {
  var0.onkillrelics["relic_catch"] = 0;
}

function handlereliccatch(var0, var1, var2, var3, var4, var5) {}

function drop_grenade(var0, var1, var2) {
  var3 = scripts\engine\utility::drop_to_ground(self.origin + (0, 0, 32), 90) + (0, 0, 2);

  if(isDefined(var1)) {
    var3 = var1;
  }

  var4 = "offhand_wm_grenade_mike67";

  if(isDefined(level.blueprintextract_shouldgivereward)) {
    var4 = level.blueprintextract_shouldgivereward;
  }

  var5 = 1;

  if(isDefined(level.blueprintextract_trygetreward)) {
    var5 = level.blueprintextract_trygetreward;
  }

  var6 = 200;

  if(isDefined(level.blueprintextractchance)) {
    var6 = level.blueprintextractchance;
  }

  var7 = &"COOP_GAME_PLAY/PICK_GRENADE";

  if(isDefined(level.blueprintextractspawns)) {
    var7 = level.blueprintextractspawns;
  }

  var8 = spawn("script_model", var3);
  var8 setModel(var4);
  var8.headicon = var8 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.players, "cp_crate_icon_lethalrefill", 7, 0, 128, 128, undefined, 0, 0, undefined, undefined);
  var8.trigger = spawn("trigger_rotatable_radius", var3, 0, 32, 32);
  var8 thread scripts\cp\utility::delayentdelete(30);
  var8.trigger thread scripts\cp\utility::delayentdelete(30);
  thread activate_grenade_object();
}

function activate_grenade_object() {
  self endon("death");

  for(;;) {
    self.trigger waittill("trigger", var0);

    if(!isPlayer(var0)) {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var0)) {
      continue;
    }

    if(scripts\cp\cp_powers::ref_1281c(var0)) {
      var0 thread scripts\cp\utility::hint_prompt("max_grenades", 1, 1);
      continue;
    }

    if(!nullweapon(var0 getcurrentweapon())) {
      var0 forceplaygestureviewmodel("ges_pickup");
    }

    var0 playlocalsound("weap_ammo_pickup");

    foreach(var2 in var0.powers) {
      if(isDefined(level.bmoendgameot)) {
        var3 = 0;

        if(isDefined(var0.powers[level.bmoendgameot])) {
          var3 = var0.powers[level.bmoendgameot].charges;
        }

        var4 = var0 scripts\cp\cp_loadout::get_num_of_charges_for_power(var0, "primary");

        if(var3 >= var4) {
          var3 = var4 - 1;
        }

        var0 scripts\cp\cp_powers::givepower(level.bmoendgameot, "primary", undefined, undefined, undefined, 0, 0, var3 + 1);
      } else {
        var0 notify("pickup_equipment", var2.weaponuse);
      }

      waitframe();
    }

    if(isDefined(self.trigger)) {
      self.trigger delete();
    }

    self delete();
  }
}

function should_drop_grenade(var0) {
  var1 = getdvarint("scr_force_grenade_drop");

  if(var1) {
    return true;
  }

  if(!isDefined(level.grenade_drop_cooldown)) {
    return false;
  }

  if(isDefined(self.unittype) && self.unittype == "suicidebomber") {
    return false;
  }

  if(!isDefined(var0.eattacker)) {
    return false;
  }

  var2 = 10;
  var3 = gettime();
  var4 = var0.eattacker getentitynumber();

  if(!isDefined(level.grenade_drop_cooldown[var4])) {
    level.grenade_drop_cooldown[var4] = var3 + var2 * 1000;
    return true;
  }

  if(var3 > level.grenade_drop_cooldown[var4]) {
    level.grenade_drop_cooldown[var4] = var3 + var2 * 1000;
    return true;
  }

  return false;
}

function load_relic_catch_params() {
  self.script_forcegrenade = 1;
  self.grenadeammo = 255;
  self.fngrenadecooldownelapsedoverride = &start_coop_bomb_case_defusal;
  self.grenadesafedist = 64;
}

function start_coop_bomb_case_defusal(var0) {
  return scripts\engine\utility::cointoss();
}

function init_relic_boom(var0) {}

function set_relic_boom(var0) {
  var0.onkillrelics["relic_boom"] = 1;
}

function unset_relic_boom(var0) {
  var0.onkillrelics["relic_boom"] = 0;
}

function handlerelicboom(var0, var1, var2, var3, var4, var5) {
  var6 = magicgrenademanual("thermite_mp", var2.origin, (0, 0, 0));
  var6.owner = var2;
  var2 thread scripts\cp\equipment\cp_thermite::thermite_used(var6);
}

function init_relic_swat(var0) {
  scripts\mp\vehicles\vehicle_compass_mp::ref_12b16("Earthquake", &earthquake, 5, &brjugg_initpostmain, 0, 0, 0, 1, 1);
}

function brjugg_initpostmain(var0, var1, var2, var3, var4, var5, var6, var7) {
  return true;
}

function set_relic_swat(var0) {
  var0.ondamagerelics["relic_swat"] = 1;

  if(!scripts\engine\utility::array_contains(level.modifyplayerdamage_relics, &relic_swat_modifyplayerdamage)) {
    level.modifyplayerdamage_relics = scripts\engine\utility::array_add(level.modifyplayerdamage_relics, &relic_swat_modifyplayerdamage);
    return;
  }
}

function try_to_do_first_passby_room_logic() {
  return istrue(level.set_relics["relic_swat"]);
}

function try_to_do_first_entry_room_logic() {
  return istrue(level.set_relics["relic_collat_dmg"]);
}

function try_start_fake_infil_chopper(var0) {
  if(isDefined(level.set_relics) && isDefined(level.set_relics[var0])) {
    return istrue(level.set_relics[var0]);
  }

  return 0;
}

function getgamewinnerfunc() {
  if(!isDefined(level.ref_132c6)) {
    level.ref_132c6 = [];
  }

  level.ref_132c6 = scripts\engine\utility::array_add(level.ref_132c6, &ref_140cb);
}

function ref_140cb(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var0)) {
    return true;
  }

  if(isDefined(var0.owner)) {
    if(!isPlayer(var0.owner)) {
      return true;
    }
  }

  if(!isPlayer(var0)) {
    return true;
  }

  var6 = var2 == "MOD_IMPACT";
  var7 = var2 == "MOD_EXPLOSIVE_BULLET" && isDefined(var4) && var4 == "none" || var2 == "MOD_EXPLOSIVE" || var2 == "MOD_GRENADE_SPLASH" || var2 == "MOD_PROJECTILE" || var2 == "MOD_PROJECTILE_SPLASH";
  var8 = var2 == "MOD_FIRE";
  var9 = isDefined(var0.classname) && var0.classname == "script_vehicle" && isDefined(var0.owner) && isPlayer(var0.owner);
  var10 = var9 && var2 == "MOD_CRUSH";
  var11 = isDefined(var0.classname) && var0.classname == "script_vehicle" && !isDefined(var0.owner);
  var12 = var11 && var2 == "MOD_CRUSH";
  var13 = var2 == "MOD_CRUSH";
  var14 = var2 == "MOD_EXECUTION";
  var15 = var2 == "MOD_MELEE";
  var16 = var6 || var7 || var14 || var15 || var13 || var9 || var10 || var11 || var12 || tripwire_trackachievementboom(var3) || scripts\cp\utility::isheadshot(var3, var4, var2, var0);

  if(var16) {
    return true;
  }

  if(!scripts\cp\pvpe\pvpe::pvpe_enabled()) {
    if(isPlayer(var0) && isai(var5)) {
      if(var16) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  } else if(var16) {
    return true;
  } else {
    return false;
  }

  return false;
}

function unset_relic_swat(var0) {
  var0.ondamagerelics["relic_swat"] = 0;
  level.modifyplayerdamage_relics = scripts\engine\utility::array_remove(level.modifyplayerdamage_relics, &relic_swat_modifyplayerdamage);
}

function relic_swat_modifyplayerdamage(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(ref_140cb(var1, var2, var3, var4, var7, var0)) {
    return var2;
  }

  return 0;
}

function tripwire_trackachievementboom(var0) {
  if(!isDefined(var0)) {
    return 0;
  }

  switch (var0.basename) {
    case "cruise_proj_mp":
    case "nuke_mp":
      return 1;
    case "bradley_tow_proj_ks_mp":
    case "emp_drone_non_player_direct_mp":
    case "hover_jet_proj_mp":
    case "iw8_la_rpapa7_mp":
    case "fuelstrike_proj_mp":
    case "iw8_la_kgolf_mp":
    case "apache_proj_mp":
    case "iw8_la_juliet_mp":
    case "iw8_la_gromeo_mp":
    case "iw8_la_gromeoks_mp":
    case "bradley_tow_proj_mp":
    case "ac130_105mm_mp":
    case "emp_drone_non_player_mp":
    case "at_mine_mp":
      return 1;
    case "white_phosphorus_proj_mp":
    case "ac130_40mm_mp":
    case "toma_proj_mp":
    case "apc_rus_mp":
    case "large_transport_mp":
    case "lighttank_tur_ks_mp":
    case "lighttank_mp":
    case "lighttank_tur_mp":
    case "hoopty_truck_mp":
    case "van_mp":
    case "cargo_truck_mg_mp":
    case "cargo_truck_mp":
    case "med_transport_mp":
    case "hoopty_mp":
    case "pickup_truck_mp":
    case "big_bird_mp":
    case "cop_car_mp":
    case "atv_mp":
    case "tac_rover_mp":
    case "little_bird_mg_mp":
    case "little_bird_mp":
    case "technical_mp":
      return 1;
    case "artillery_mp":
    case "thermite_bolt_mp":
    case "at_mine_ap_mp":
    case "ac130_25mm_mp":
    case "pac_sentry_turret_mp":
    case "claymore_mp":
    case "c4_mp_p":
    case "frag_grenade_mp":
    case "semtex_mp":
    case "thermite_av_mp":
      return 1;
    default:
      return 0;
  }
}

function handlerelicswat(var0, var1, var2, var3, var4, var5) {
  if(isPlayer(var0)) {
    var2 notify("hit_ai", var0);
    return;
  }
}

function tac_rover_trail(var0) {}

function ref_130b3(var0) {
  var0.ondamagerelics["relic_damage_from_above"] = 1;
  var0.is_available_for_hack = 1;
}

function ref_13f3b(var0) {
  var0.ondamagerelics["relic_damage_from_above"] = undefined;
  var0.is_available_for_hack = undefined;
}

function init_relic_glasscannon(var0) {}

function set_relic_glasscannon(var0) {
  while(!isDefined(var0.gs)) {
    waitframe();
  }

  var0.og_health_value = var0.maxhealth;
  var0.og_health_regen_delay = var0.gs.healthregendelay;
  var0.og_health_regen_rate = var0.gs.healthregenrate;
  var0.maxhealth = 100;
  var0.gs.healthregendelay = 1.5;
  var0.gs.healthregenrate = 50;
}

function unset_relic_glasscannon(var0) {
  var0.maxhealth = var0.og_health_value;
  var0.gs.healthregendelay = var0.og_health_regen_delay;
  var0.gs.healthregenrate = var0.og_health_regen_rate;
}

function setupdomplates(var0, var1, var2) {}

function take_intro_items(var0) {}

function ref_130d6(var0) {
  var0.persistentrelics["relic_team_proximity"] = 1;
}

function ref_13f5b(var0) {
  var0.persistentrelics["relic_team_proximity"] = 0;
}

function select_boss_one_spawners() {
  thread ref_12baa(level);
}

function ref_12baa(var0) {
  level endon("game_ended");
  level waittill("player_spawned_with_loadout");

  for(;;) {
    var1 = level.players;

    if(var1.size <= 1) {
      wait 3;
      continue;
    }

    foreach(var3 in var1) {
      if(!truckdoorrightcol(var3)) {
        if(isDefined(var3.triggered_module_spawn_cancel)) {
          if(isDefined(level.ref_120a1)) {
            foreach(var5 in level.ref_120a1) {
              var3 thread[[var5]](var3);
            }
          }
        }

        var3.triggered_module_spawn_cancel = undefined;
        continue;
      }

      if(proper_damage(var3) > var0) {
        if(!istrue(var3.triggered_module_spawn_cancel)) {
          if(isDefined(level.ref_120a3)) {
            foreach(var5 in level.ref_120a3) {
              var3 thread[[var5]](var3);
            }
          }
        }

        var3.triggered_module_spawn_cancel = 1;
        continue;
      }

      if(istrue(var3.triggered_module_spawn_cancel)) {
        if(isDefined(level.ref_120a2)) {
          foreach(var5 in level.ref_120a2) {
            var3 thread[[var5]](var3);
          }
        }
      }

      var3.triggered_module_spawn_cancel = 0;
    }

    waitframe();
  }
}

function truckdoorrightcol(var0) {
  var1 = !isalive(var0) || istrue(var0.inlaststand) || istrue(var0.bspawningviaac130) || istrue(var0.unset_relic_oneclip);
  return !var1;
}

function proper_damage(var0) {
  var1 = scripts\cp\utility::getplayersinteam(var0.team);

  if(var1.size <= 1) {
    return 0;
  }

  var2 = -1;

  foreach(var4 in var1) {
    if(var4 == var0) {
      continue;
    }

    var5 = distance2d(var0.origin, var4.origin);

    if(var5 < var2 || var2 < 0) {
      var2 = var5;
    }
  }

  return var2;
}

function select_back_door_spawners() {
  scripts\mp\vehicles\vehicle_compass_mp::ref_12b16("Earthquake", &earthquake, 5, &brjugg_initpostmain, 0, 0, 0, 1, 1);
  thread ref_12b5c(level);
}

function tac_rover_initdamage(var0) {}

function ref_12b5c(var0) {
  level endon("game_ended");
  level notify("relic_amped_single_thread");
  level endon("relic_amped_single_thread");
  jumpiftrue(isDefined(var0)) LOC_00000024;
  var0 = "allies";

  for(;;) {
    if(!isDefined(level.ref_12b57)) {
      wait 0.2;
      continue;
    }

    if(!isDefined(level.ref_12b68) || !ref_12b59(level.ref_12b68) || shocklevel()) {
      if(istrue(shocklevel()) && !istrue(ref_12b5a())) {
        ref_12b53();
        ref_12b5f(1);
        wait 3;
        ref_12b5f(0);
        continue;
      } else {
        level.ref_12b68 = ref_12b61(var0, 1);

        if(!isDefined(level.ref_12b68)) {
          level waittill("killed_enemy");
        } else {
          waitframe();
        }

        continue;
      }
    }

    if(isDefined(level.bufferedammoboxdata) && level.bufferedammoboxdata <= 0) {
      var1 = level.ref_12b68;

      if(isDefined(var1)) {
        ref_12b56(level, var1);
        ref_12b5f(1);
        wait 3;
        ref_12b5f(0);
      } else {
        level waittill("killed_enemy");
      }

      continue;
    }

    waitframe();
  }
}

function ref_12b5d(var0) {
  level endon("game_ended");
  level endon("relic_amped_stop_timer");
  level endon("relic_amped_explosion");
  level notify("relic_amped_beeps_single_thread");
  level endon("relic_amped_beeps_single_thread");
  jumpiftrue(isDefined(var0)) LOC_00000032;
  var0 = "allies";

  for(;;) {
    if(!isDefined(level.ref_12b57) || !isDefined(level.bufferedammoboxdata)) {
      waitframe();
      continue;
    }

    var1 = 0.5;

    if(level.bufferedammoboxdata > 7500) {
      var1 = 0.5;
    } else if(level.bufferedammoboxdata > 5000) {
      ref_12b63("breach_warning_beep_01", var0);
      var1 = 1;
    } else {
      ref_12b63("breach_warning_beep_02", var0);
      var1 = 0.2;
    }

    if(isDefined(level.ref_12b68) && level.bufferedammoboxdata <= -1500) {
      return;
    }

    wait var1;
  }
}

function shocklevel() {
  if(!isDefined(level.ref_12b68)) {
    return true;
  }

  return istrue(level.ref_12b68.sfx_revive_lp);
}

function shoot_at_apc() {
  if(!isDefined(level.ref_12b68)) {
    return true;
  }

  if(!isDefined(level.ref_12b68.bshouldreturnvalue)) {
    level.ref_12b68.bshouldreturnvalue = gettime();
    return false;
  }

  return gettime() - level.ref_12b68.bshouldreturnvalue >= 15000;
}

function ref_12b55(var0) {
  level endon("game_ended");
  level notify("relic_ampeddebug_single_thread");
  level endon("relic_ampeddebug_single_thread");
  level waittill("player_spawned_with_loadout");
  wait 3;

  for(;;) {
    wait var0;
    ref_12b5e();
  }
}

function ref_12b5e() {
  level notify("killed_enemy");

  if(!istrue(level.ref_12b60) && !istrue(level.ref_12b58)) {
    if(!isDefined(level.ref_12b57)) {
      level.ref_12b57 = gettime() + 10000;
      var0 = level.ref_12b57;
    } else {
      var0 = level.ref_12b57 + 6000;
    }

    var1 = gettime() + 20000;
    level.ref_12b5b = gettime();
    level.ref_12b57 = min(var0, var1);

    if(isDefined(level.ref_12b68) && var0 > var1) {
      level.ref_12b68.sfx_revive_lp = 1;
      return;
    }

    return;
  }
}

function ref_12b66(var0, var1) {
  level endon("game_ended");
  level endon("relic_amped_stop_timer");
  level endon("relic_amped_explosion");
  var0 endon("disconnect");
  var0 endon("death");
  level notify("relic_ampedtimer_single_thread");
  level endon("relic_ampedtimer_single_thread");
  var2 = gettime();
  var3 = var2 + 2000;
  var4 = 0;
  level.ref_12b58 = 1;
  jumpiffalse(isDefined(level.buddyspawnplayer)) LOC_0000005f;
  objective_setprogress(level.buddyspawnplayer, 0);

  while(var3 > gettime()) {
    var5 = max(gettime() - var2, 0.1);
    var4 = var5 / 2000 / 2;

    if(isDefined(var0)) {
      var0 setclientomnvar("ui_relic_meter_progress", var4);
    }

    waitframe();
  }

  level.ref_12b58 = 0;

  if(istrue(var1)) {
    level.ref_12b57 = gettime() + 10000;
  }

  thread ref_12b5d(level);

  for(;;) {
    if(!isDefined(level.ref_12b57)) {
      waitframe();
      continue;
    }

    level.bufferedammoboxdata = level.ref_12b57 - gettime();

    if(level.bufferedammoboxdata > 0) {
      var0 setclientomnvar("ui_relic_meter_progress", level.bufferedammoboxdata / 20000);

      if(isDefined(level.buddyspawnplayer)) {
        objective_setprogress(level.buddyspawnplayer, level.bufferedammoboxdata / 20000);
      }
    } else {
      var0 setclientomnvar("ui_relic_meter_progress", 0);
      objective_setprogress(level.buddyspawnplayer, 0);
    }

    if(isDefined(level.ref_12b68) && level.bufferedammoboxdata <= -1500) {
      if(ref_12b59(level.ref_12b68)) {
        ref_12b56(level, level.ref_12b68);
      }

      ref_12b5f(1);
      wait 3;
      ref_12b5f(0);
      level notify("relic_amped_stop_timer");
    }

    waitframe();
  }
}

function ref_12b63(var0, var1) {
  if(!soundexists(var0)) {
    return;
  }

  if(isDefined(level.ref_12b68)) {
    level.ref_12b68 playSound(var0);
    return;
  }
}

function ref_12b5a() {
  var0 = level.ref_12b68;

  if(!isDefined(var0)) {
    return true;
  }

  var1 = scripts\engine\utility::array_remove(scripts\cp\utility::getplayersinteam(var0.team), var0);

  if(var1.size <= 0) {
    return false;
  }

  foreach(var3 in var1) {
    if(ref_12b59(var3)) {
      return true;
    }
  }

  return false;
}

function ref_12b53() {
  if(isDefined(level.ref_12b68)) {
    level.ref_12b68.sfx_revive_lp = 0;
    level.ref_12b68.bshouldreturnvalue = undefined;
    level.ref_12b68 setclientomnvar("ui_relic_meter_progress", 0);
  }

  level.ref_12b57 = undefined;
  level.ref_12b5b = undefined;
  level.ref_12b68 = undefined;

  if(isDefined(level.buddyspawnplayer)) {
    objective_addalltomask(level.buddyspawnplayer);
    objective_hidefromplayersinmask(level.buddyspawnplayer);
    return;
  }
}

function ref_12b67(var0) {
  for(;;) {
    var1 = undefined;

    if(level.players.size > 1) {
      var1 = level.players[1];
      var1 scripts\engine\utility::ent_flag_wait("player_spawned_with_loadout");
    }

    if(isDefined(var1)) {
      var1.ref_12a7e = 1;
      var1.shouldskipdeathsshield = 1;
      var1 dodamage(var1.maxhealth + 100000, var1.origin, var1, undefined, "MOD_SUICIDE");
      var1 waittill("revived");
      wait var0;
      continue;
    }

    wait 1;
  }
}

function ref_12b61(var0, var1) {
  var2 = undefined;

  if(isDefined(level.ref_12b68)) {
    var2 = level.ref_12b68;
    ref_12b53();
  }

  var3 = ref_12b62(var0, var2);

  if(getdvarint("scr_test_amped", 0) > 0 && level.players.size > 1 && ref_12b59(level.players[0])) {
    var3 = level.players[0];
  }

  if(!isDefined(var3)) {
    return;
  }

  level.ref_12b68 = var3;
  level.ref_12b68.bshouldreturnvalue = gettime();
  level.ref_12b68.sfx_revive_lp = 0;
  ref_12b65(var3);

  if(!isDefined(var1)) {
    var1 = 0;
  }

  level.bufferedammoboxdata = undefined;
  thread ref_12b66(level, var3);
  return var3;
}

function ref_12b62(var0, var1) {
  var2 = scripts\cp\utility::getplayersinteam(var0);

  foreach(var4 in var2) {
    if(!ref_12b59(var4)) {
      var2 = scripts\engine\utility::array_remove(var2, var4);
    }
  }

  if(var2.size <= 0) {
    return undefined;
  }

  if(isDefined(var1) && scripts\engine\utility::array_contains(var2, var1) && var2.size > 1) {
    var2 = scripts\engine\utility::array_remove(var2, var1);
  }

  return scripts\engine\utility::random(var2);
}

function ref_12b65(var0) {
  if(!isDefined(level.buddyspawnplayer)) {
    var1 = scripts\cp\cp_objectives::requestworldid("ampedWID");
    level.buddyspawnplayer = var1;
    objective_setplayintro(var1, 0);
    objective_setplayoutro(var1, 0);
    objective_state(var1, "current");
    objective_icon(var1, "icon_waypoint_timed");
    objective_setbackground(var1, 0);
    objective_setshowoncompass(var1, 1);
    objective_setshowprogress(var1, 1);
    objective_setprogress(var1, 0);
  }

  objective_onentity(level.buddyspawnplayer, var0);
  objective_setzoffset(level.buddyspawnplayer, 90);
  objective_addalltomask(level.buddyspawnplayer);
  objective_showtoplayersinmask(level.buddyspawnplayer);
}

function ref_12b59(var0) {
  var1 = var0 scripts\engine\utility::ent_flag("player_spawned_with_loadout");
  var2 = !isalive(var0) || istrue(var0.inlaststand) || istrue(var0.respawn_in_progress) || istrue(var0.bspawningviaac130) || isDefined(var0.super_invulnerable) || !istrue(var1);
  return !var2;
}

function ref_12b54() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  var0 = level.players[0];
  var0 endon("death");
  var0 waittill("started_revive");
  wait 4;
  var0.ref_12a7e = 1;
  var0.shouldskipdeathsshield = 1;
  var0 dodamage(var0.maxhealth + 100000, var0.origin, var0, undefined, "MOD_SUICIDE");
}

function ref_12b56(var0) {
  level endon("game_ended");
  var1 = var0.origin;

  if(var0 tagexists("j_head")) {
    var1 = var0 gettagorigin("j_head");
  } else if(var0 tagexists("tag_eye")) {
    var1 = var0 gettagorigin("tag_eye");
  }

  var2 = 3000;
  var3 = gettime();

  while(istrue(var0.invulnerable) && gettime() - var3 <= var2) {
    waitframe();
  }

  var4 = var0 scripts\cp_mp\utility\player_utility::getvehicle();
  var0.ref_12a7e = 1;
  var0.shouldskipdeathsshield = 1;
  var0 dodamage(var0.maxhealth + 100000, var0.origin, var0, undefined, "MOD_SUICIDE");
  radiusdamage(var0.origin + (0, 0, 60), 600, var0.maxhealth, var0.maxhealth, undefined, "MOD_RIFLE_BULLET");
  scripts\mp\vehicles\vehicle_compass_mp::ref_12e0b("Earthquake", 1, 0.6, var0.origin, 84);
  earthquake(1, 0.6, var0.origin, 333);
  playFX(level._effect["headshot_explode"], var1);
  var0 playSound("gib_fullbody");

  if(isDefined(var4)) {
    var4 dodamage(var4.maxhealth, (0, 0, 0), undefined, undefined);
  }

  var0.ref_12a7e = 0;
  playrumbleonposition("grenade_rumble", var0.origin);
  var0 setclientomnvar("ui_relic_meter_progress", 0);
  var0.bshouldreturnvalue = undefined;
  level notify("relic_amped_explosion");
  thread ref_12b64(var0);
}

function ref_12b64(var0) {
  level endon("game_ended");
  var0 endon("disconnect");

  while(!isalive(var0) || istrue(var0.inlaststand) || istrue(var0.respawn_in_progress)) {
    wait 1;
  }

  var0 scripts\engine\utility::ref_143a5("revive", "death");
  var0.shouldskipdeathsshield = 0;
  var0.shouldskiplaststand = 0;
}

function ref_130b1(var0) {
  var0.onkillrelics["relic_amped"] = 1;
}

function ref_13f39(var0) {
  var0.onkillrelics["relic_amped"] = 0;
}

function ref_12b5f(var0) {
  level.ref_12b60 = var0;

  if(istrue(var0)) {
    level notify("relic_amped_stop_timer");

    if(isDefined(level.buddyspawnplayer)) {
      objective_addalltomask(level.buddyspawnplayer);
      objective_hidefromplayersinmask(level.buddyspawnplayer);
    }

    if(isDefined(level.ref_12b68)) {
      level.ref_12b68 = undefined;
    }

    level.ref_12b57 = undefined;
    level.ref_12b5b = undefined;
    level.bufferedammoboxdata = undefined;
    return;
  }
}

function setupglobalkillcount(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var1) || !isai(var2)) {
    return;
  }

  if(!isDefined(level.ref_12b68)) {
    ref_12b61(var1.team, 1);
    ref_12b5e();
    return;
  }

  if(level.ref_12b68 == var1) {
    ref_12b5e();
    return;
  }
}

function taillightright(var0) {
  thread ref_12b96(var0);
}

function ref_12b96(var0) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 waittill("spawned_player");
  var0.maxhealth = 1;
  scripts\cp\cp_armor::givearmor(var0, 100, 1);
}

function ref_130d2(var0) {
  var0.onkillrelics["relic_shieldsonly"] = 1;
}

function ref_13f58(var0) {
  var0.onkillrelics["relic_shieldsonly"] = 0;
}

function setuphudelemninfilblack(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var1)) {
    return;
  }

  if(scripts\cp\cp_armor::player_have_full_armor(var1)) {
    return;
  }

  var6 = scripts\cp\cp_armor::get_player_armor_amount(var1);
  var7 = int(clamp(var6 + 50, 50, 100));
  scripts\cp\cp_armor::givearmor(var1, var7, 1);
}

function ref_12b99() {
  level._effect["vfx_squadlink_tunnelvision"] = loadfx("vfx/iw8_cp/misc/vfx_cp_tunnel_vision.vfx");
}

function select_back_two_spawners() {
  thread ref_12baa(level);

  if(!isDefined(level.ref_120a3)) {
    level.ref_120a3 = [];
  }

  if(!isDefined(level.ref_120a2)) {
    level.ref_120a2 = [];
  }

  if(!isDefined(level.ref_120a1)) {
    level.ref_120a1 = [];
  }

  level.ref_120a2 = scripts\engine\utility::array_add(level.ref_120a2, &ref_12b9c);
  level.ref_120a3 = scripts\engine\utility::array_add(level.ref_120a3, &ref_12b9d);
  level.ref_120a1 = scripts\engine\utility::array_add(level.ref_120a1, &ref_12b9b);

  if(!scripts\engine\utility::array_contains(level.modifyplayerdamage_relics, &ref_12b9a)) {
    level.modifyplayerdamage_relics = scripts\engine\utility::array_add(level.modifyplayerdamage_relics, &ref_12b9a);
    return;
  }
}

function setupdomendflag(var0, var1, var2) {}

function ref_12b9c(var0) {
  level endon("game_ended");
  var0 endon("death");
  var0 endon("last_stand");
  var0 endon("disconnect");
  var0.ref_12bb0 = 1;
  var0 notify("squadlink_stepped_too_close");
  var0 thread scripts\cp\cp_hud_message::tutorialprint("", 0.2);
  thread ref_12b98(var0, var0, 2, "squadlink_stepped_too_far");
  ref_12ba1(var0, var0, 0);
  thread ref_12b9f(var0);
}

function ref_12b9d(var0) {
  level endon("game_ended");
  var0.ref_12bb0 = 0;
  var0 notify("squadlink_stepped_too_far");
  ref_12ba1(var0, var0, 1);
  thread ref_12ba0(var0);
  thread ref_12ba2(var0);
}

function ref_12b9b(var0) {
  level endon("game_ended");
  var0 setclientomnvar("ui_cp_relic_squad_link", 0);
}

function ref_12b98(var0, var1, var2, var3) {
  level endon("game_ended");
  var0 endon(var2);
  var0 endon("death");
  var0 endon("disconnect");
  var0 setclientomnvar("ui_cp_relic_squad_link", var3);
  wait var1;
  var0 setclientomnvar("ui_cp_relic_squad_link", 0);
}

function ref_12ba2(var0) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 endon("squadlink_stepped_too_close");
  var0 endon("death");
  var0 endon("last_stand");
  thread ref_12ba3(var0);
  thread ref_12b97(var0);
}

function ref_12ba3(var0) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 endon("squadlink_stepped_too_close");
  var0 scripts\engine\utility::ref_143a5("death", "last_stand");
  ref_12b9f(var0, var0);
}

function ref_12b97(var0) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 endon("squadlink_stepped_too_close");
  var0 visionsetnakedforplayer("nuke_deathblur", 0);
  var0 allowsupersprint(0);
  wait 5;
  playfxontagforclients(level._effect["vfx_squadlink_tunnelvision"], var0, "tag_origin", var0);
}

function ref_12b9f(var0) {
  var0 visionsetnakedforplayer("", 0);
  var0 allowsupersprint(1);
  stopFXOnTag(level._effect["vfx_squadlink_tunnelvision"], var0, "tag_origin");
}

function ref_12ba0(var0) {
  level endon("game_ended");
  var0 endon("death");
  var0 endon("disconnect");
  var0 endon("squadlink_stepped_too_close");

  for(;;) {
    var1 = 3;
    var0 thread scripts\cp\cp_hud_message::tutorialprint(&"CP_BR_SYRK_OBJECTIVES/RELIC_SQUADLINK_FAR", var1 - 1);
    thread ref_12b98(var0, var0, var1 - 1, "squadlink_stepped_too_close");
    var0 playlocalsound("cp_computer_fail");
    wait var1;
  }
}

function take(var0) {}

function ref_130d3(var0) {
  var0.ondamagerelics["relic_squadlink"] = 1;
  var0.ref_12015["relic_squadlink"] = 1;
  var0 setclientomnvar("ui_cp_relic_squad_link", 0);

  if(!isDefined(var0.ref_13741)) {
    var1 = scripts\cp\cp_objectives::requestworldid(var0.name + "_squadlinkWID");
    var0.ref_13741 = var1;
    objective_setplayintro(var1, 0);
    objective_setplayoutro(var1, 0);
    objective_state(var1, "current");
    objective_icon(var1, "icon_waypoint_objective_general");
    objective_setbackground(var1, 1);
    objective_setshowoncompass(var1, 1);
    objective_onentity(var1, var0);
    objective_setzoffset(var1, 70);
    objective_setshowdistance(var1, 1);
    objective_addalltomask(var1);
    objective_hidefromplayersinmask(var1);
    return;
  }
}

function ref_13f59(var0) {
  var0.ondamagerelics["relic_squadlink"] = 0;
  var0.ref_12015["relic_squadlink"] = 0;
  var0 setclientomnvar("ui_cp_relic_squad_link", 0);

  if(isDefined(var0.ref_13741)) {
    objective_delete(var0.ref_13741);
    var0.ref_13741 = scripts\cp\cp_objectives::freeworldid(var0.name + "_squadlinkWID");
    var0.ref_13741 = undefined;
    return;
  }
}

function ref_1201b(var0, var1, var2, var3, var4, var5) {}

function ref_12b9a(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = 1;

  if(isDefined(var1) && isPlayer(var1)) {
    if(!istrue(var1.triggered_module_spawn_cancel)) {
      var8 = 2;
    }
  } else if(isDefined(var0) && isPlayer(var0)) {
    if(!istrue(var0.triggered_module_spawn_cancel)) {
      var8 = 0.5;
    }
  }

  return int(var2 * var8);
}

function ref_12b9e(var0) {
  var0 endon("death");
  level endon("game_ended");

  if(isDefined(var0.ref_13740)) {
    return;
  }

  var0.ref_13740 = scripts\cp\cp_outline_utility::outlineenableforall(var0, "snapshotgrenade_longfade", "killstreak_personal");
  wait 2;
  scripts\cp\cp_outline_utility::outlinedisable(var0.ref_13740, var0);
  var0.ref_13740 = undefined;
}

function ref_12ba1(var0, var1) {
  var2 = scripts\cp\utility::getplayersinteam(var0.team);
  var2 = scripts\engine\utility::array_remove(var2, var0);

  if(var2.size <= 0) {
    return;
  }

  foreach(var4 in var2) {
    if(isDefined(var4.ref_13741)) {
      if(istrue(var1)) {
        objective_removeclientfrommask(var4.ref_13741, var0);
        objective_hidefromplayersinmask(var4.ref_13741);
        continue;
      }

      objective_addclienttomask(var4.ref_13741, var0);
      objective_hidefromplayersinmask(var4.ref_13741);
    }
  }
}

function select_back_one_spawners() {
  scripts\mp\vehicles\vehicle_compass_mp::ref_12b16("Earthquake", &earthquake, 5, &brjugg_initpostmain, 0, 0, 0, 1, 1);
}

function tacinsert_updatedestroyusability(var0) {}

function ref_130c3(var0) {
  var0.persistentrelics["relic_landlocked"] = 1;
}

function ref_13f49(var0) {
  var0.persistentrelics["relic_landlocked"] = 0;
}

function setupdom(var0, var1, var2) {}

function ref_12b7e(var0) {
  var0 endon("death");
  var0 endon("disconnect");
  level endon("game_ended");
  var0 endon("relic_landlocked_returned_safe");
  var0 notify("relic_landlocked_do_explosion");
  var0 endon("relic_landlocked_do_explosion");
  thread ref_12b7d(var0);
  var0 thread scripts\cp\cp_hud_message::tutorialprint(&"CP_BR_SYRK_OBJECTIVES/RELIC_LANDLOCKED_MSG", 2);
  wait 2;
  var1 = var0.origin;

  if(var0 tagexists("j_head")) {
    var1 = var0 gettagorigin("j_head");
  } else if(var0 tagexists("tag_eye")) {
    var1 = var0 gettagorigin("tag_eye");
  }

  var0 notify("relic_landlocked_exploded");
  radiusdamage(var0.origin + (0, 0, 60), 333, 333, 33, undefined, "MOD_RIFLE_BULLET");
  scripts\mp\vehicles\vehicle_compass_mp::ref_12e0b("Earthquake", 1, 0.6, var0.origin, 84);
  playFX(level._effect["headshot_explode"], var1);
  var0 playSound("gib_fullbody");
  playrumbleonposition("grenade_rumble", var0.origin);
}

function ref_12b7d(var0) {
  var0 endon("death");
  var0 endon("disconnect");
  level endon("game_ended");
  var0 endon("relic_landlocked_exploded");
  var0 endon("relic_landlocked_do_explosion");

  while(!isDefined(var0.inhackring)) {
    waitframe();
  }

  var0 notify("relic_landlocked_returned_safe");
}

function tacmapexplanation(var0) {}

function ref_130c6(var0) {
  var0.ondamagerelics["relic_lfo"] = 1;
  var0.ref_12e85 = [];
  thread ref_11aa6();
}

function ref_13f4c(var0) {
  var0.ondamagerelics["relic_lfo"] = 0;
}

function setup_wave_spawn_zone_disable() {
  scripts\mp\playeractions::registeractionset("LFO_1", ["slide", "sprint", "crouch", "prone", "mantle"]);
  scripts\mp\playeractions::registeractionset("LFO_2", ["slide", "sprint"]);
  scripts\mp\playeractions::registeractionset("LFO_3", ["slide", "sprint"]);
  scripts\mp\playeractions::registeractionset("LFO_4", ["slide", "sprint"]);
}

function complete_vault_assault_retrieve_saw(var0) {}

function ref_1308d(var0) {
  if(!isDefined(level.playerisprop)) {
    level.playerisprop = [];
  }

  level.playerisprop[level.playerisprop.size] = "shotgun";
}

function ref_1308e(var0) {
  if(!isDefined(level.playerisprop)) {
    level.playerisprop = [];
  }

  level.playerisprop[level.playerisprop.size] = "sniper";
}

function ref_1308b(var0) {
  if(!isDefined(level.playerisprop)) {
    level.playerisprop = [];
  }

  level.playerisprop[level.playerisprop.size] = "riotshield";
}

function ref_1308f(var0) {
  if(!isDefined(level.playerisprop)) {
    level.playerisprop = [];
  }

  level.playerisprop[level.playerisprop.size] = "suicidebomber";
}

function ref_1308c(var0) {
  if(!isDefined(level.playerisprop)) {
    level.playerisprop = [];
  }

  level.playerisprop[level.playerisprop.size] = "rpg";
}

function ref_13f2b(var0) {
  if(isDefined(level.playerisprop) && scripts\engine\utility::array_contains(level.playerisprop, "rpg")) {
    level.playerisprop = scripts\engine\utility::array_remove(level.playerisprop, "rpg");

    if(level.playerisprop.size < 1) {
      ref_13f2f();
      return;
    }

    return;
  }
}

function ref_13f2c(var0) {
  if(isDefined(level.playerisprop) && scripts\engine\utility::array_contains(level.playerisprop, "shotgun")) {
    level.playerisprop = scripts\engine\utility::array_remove(level.playerisprop, "shotgun");

    if(level.playerisprop.size < 1) {
      ref_13f2f();
      return;
    }

    return;
  }
}

function ref_13f2d(var0) {
  if(isDefined(level.playerisprop) && scripts\engine\utility::array_contains(level.playerisprop, "sniper")) {
    level.playerisprop = scripts\engine\utility::array_remove(level.playerisprop, "sniper");

    if(level.playerisprop.size < 1) {
      ref_13f2f();
      return;
    }

    return;
  }
}

function ref_13f2a(var0) {
  if(isDefined(level.playerisprop) && scripts\engine\utility::array_contains(level.playerisprop, "riotshield")) {
    level.playerisprop = scripts\engine\utility::array_remove(level.playerisprop, "riotshield");

    if(level.playerisprop.size < 1) {
      ref_13f2f();
      return;
    }

    return;
  }
}

function ref_13f2e(var0) {
  if(isDefined(level.playerisprop) && scripts\engine\utility::array_contains(level.playerisprop, "suicidebomber")) {
    level.playerisprop = scripts\engine\utility::array_remove(level.playerisprop, "suicidebomber");

    if(level.playerisprop.size < 1) {
      ref_13f2f();
      return;
    }

    return;
  }
}

function ref_13f2f(var0) {
  level.playerisprop = undefined;
}

function ref_1308a(var0) {
  level.playerismatchpending = 1;
}

function ref_13f30(var0) {
  level.playerismatchpending = undefined;
}

function ref_13099(var0) {
  var0.persistentrelics["relic_just_keep_moving"] = 1;
  var0.ref_12b72 = 0;
}

function ref_13f34(var0) {
  var0.persistentrelics["relic_just_keep_moving"] = 0;
  var0.ref_12b72 = undefined;
}

function setup_bot_flag(var0, var1, var2) {
  level endon("game_ended");
  var0 endon("disconnect");

  for(;;) {
    if(!isDefined(var0.velo_forward)) {
      wait 0.1;
      continue;
    }

    var3 = var0.velo_forward - var0.origin;
    var3 = (var3[0], var3[1], 0);
    var4 = length(var3);

    if(var4 > 0) {
      var0.ref_12b72 = 0;
    } else if(isDefined(self.ref_14288) && self.ref_14288.size < 3) {
      var0.ref_12b72 = 1;
    }

    wait 0.25;
  }
}

function ref_11aa6() {
  self endon("disconnect");

  for(;;) {
    waitframe();

    if(scripts\cp\cp_laststand::player_in_laststand(self)) {
      continue;
    }

    var0 = propwhistle(self);

    foreach(var2 in self.ref_12e85) {
      if(var2 == var0) {}
    }

    switch (var0) {
      case 2:
      case 1:
        if(scripts\engine\utility::array_contains(self.ref_12e85, var0)) {
          break;
        }

        self.ref_12e85 = scripts\engine\utility::array_add(self.ref_12e85, var0);
        scripts\mp\playeractions::allowactionset("LFO_" + var0, 0);
        break;
      case 4:
      case 3:
        foreach(var2 in self.ref_12e85) {
          scripts\mp\playeractions::allowactionset("LFO_" + var2, 1);
          self.ref_12e85 = scripts\engine\utility::array_remove(self.ref_12e85, var2);
        }

        break;
      default:
        break;
    }
  }
}

function ref_1201a(var0, var1, var2, var3, var4, var5) {
  if(!isPlayer(var2)) {
    return;
  }

  var6 = var2;

  if(scripts\cp\cp_laststand::player_in_laststand(var6)) {
    return;
  }

  switch (propwhistle(var6)) {
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

function ref_12019(var0, var1, var2, var3, var4, var5) {}

function propwhistle(var0) {
  var1 = var0.health / var0.maxhealth;

  if(var1 <= 0.33) {
    return 1;
  }

  if(var1 <= 0.66) {
    return 2;
  }

  if(var1 <= 1) {
    return 3;
  }

  return 4;
}

function tag_convoy_with_objectives(var0) {}

function ref_130cb(var0) {}

function ref_13f51(var0) {}

function setupcirclepeek() {
  level.little_bird_mg_cp_spawncallback = 1;
  level.disable_loot_drop = 1;
  wait 10;
  scripts\cp\cp_munitions::ref_12be0();
}

function tactical_crate_spawn(var0) {}

function ref_130c9(var0) {
  var0.ref_11e8e = 1;
}

function ref_13f4f(var0) {
  var0.ref_11e8e = undefined;
}

function setup_comms_obj_b_goals_and_cover() {
  level.little_bird_mg_cp_onexitvehicle = 1;
  wait 10;
  scripts\cp\cp_munitions::ref_12be0(["brloot_munition_ammo"]);
}

function setupbrsquadleader() {
  scripts\cp\cp_modular_spawning::add_global_spawn_function("axis", &start_hack);

  if(!scripts\engine\utility::array_contains(level.modifyplayerdamage_relics, &ref_12b82)) {
    level.modifyplayerdamage_relics = scripts\engine\utility::array_add(level.modifyplayerdamage_relics, &ref_12b82);
    return;
  }
}

function ref_12b82(var0, var1, var2, var3, var4, var5, var6, var7) {
  ref_128a2(var0, var1, var4, var7, var3);

  if(isDefined(var3) && var3 == "MOD_MELEE") {
    return int(var2 * propwatchprematchsettings());
  }

  return int(var2);
}

function ref_128a2(var0, var1, var2, var3, var4) {
  if(isDefined(var0) && isPlayer(var0)) {
    return;
  }

  if(ref_12b85(var2)) {
    var0.ref_12b81 = 1;
    return;
  }

  var5 = scripts\engine\utility::isbulletdamage(var4) || var4 == "MOD_EXPLOSIVE_BULLET" && var3 != "none";
  var6 = var5 && scripts\cp\utility::isheadshot(var2, var3, var4, var1);

  if(ref_12b86(var6, var4)) {
    if(ref_12b80(var0)) {
      var0.ref_12b81 = 1;
      return;
    }

    return;
  }
}

function ref_12b80(var0) {
  var1 = gettime();
  return var1 >= var0.ref_12b83;
}

function ref_12b86(var0, var1) {
  if(istrue(var0)) {
    return true;
  }

  if(isDefined(var1) && var1 == "MOD_MELEE") {
    return true;
  }

  return false;
}

function ref_12b85(var0) {
  if(scripts\cp\cp_agent_damage::is_flashbang(var0.basename, var0, undefined)) {
    return true;
  }

  return false;
}

function start_hack() {
  var0 = self.maxhealth;
  var1 = propwatchprematchsettings();
  var2 = var0 * var1;
  scripts\mp\mp_agent::set_agent_health(var2);
  self.ref_12b83 = gettime();
  self.fnshouldplaypainanim = &ref_12b84;
}

function ref_12b84() {
  if(istrue(self.ref_12b81)) {
    self.ref_12b83 = gettime() + 2000;
    self.ref_12b81 = 0;
    return 1;
  }

  return 0;
}

function propwatchprematchsettings() {
  if(getdvarint("relic_mythic_multiplier", 0) != 0) {
    return int(getdvarint("relic_mythic_multiplier", 0));
  }

  return 10;
}

function tactical_boxes(var0) {}

function ref_130c8(var0) {}

function ref_13f4e(var0) {
  if(scripts\engine\utility::array_contains(level.modifyplayerdamage_relics, &ref_12b82)) {
    level.modifyplayerdamage_relics = scripts\engine\utility::array_remove(level.modifyplayerdamage_relics, &ref_12b82);
    return;
  }
}

function setup_train_entarray() {
  scripts\cp\cp_modular_spawning::add_global_spawn_function("axis", &ref_13085);

  if(!scripts\engine\utility::array_contains(level.modifyplayerdamage_relics, &ref_12b76)) {
    level.modifyplayerdamage_relics = scripts\engine\utility::array_add(level.modifyplayerdamage_relics, &ref_12b76);
    return;
  }
}

function ref_13085() {
  self.playerforcespawn = [];
}

function truckcollision(var0, var1) {
  return scripts\engine\utility::array_contains(var1.playerforcespawn, var0);
}

function backtruck(var0, var1) {
  var1.playerforcespawn = scripts\engine\utility::array_add(var1.playerforcespawn, var0);
  ref_13f82(var1);

  if(playergetbestrespawnteammate()) {
    if(var1.playerforcespawn.size == 1) {
      var1.playergetlaststandpistol = scripts\cp\cp_outline_utility::outlineenableforall(var1, "snapshotgrenade_longfade", "killstreak_personal");
      return;
    }

    return;
  }
}

function ref_12be9(var0, var1) {
  var1.playerforcespawn = scripts\engine\utility::array_remove(var1.playerforcespawn, var0);
  ref_13f82(var1);

  if(playergetbestrespawnteammate()) {
    if(shipment_spawnpatchtriggers(var1)) {
      if(isDefined(var1.playergetlaststandpistol)) {
        scripts\cp\cp_outline_utility::outlinedisable(var1.playergetlaststandpistol, var1);
        return;
      }

      return;
    }

    return;
  }
}

function playergetbestrespawnteammate() {
  if(getdvarint("show_focus_fire_outline", 0) != 0) {
    return true;
  }

  return false;
}

function propsetclonesleft(var0) {
  if(!playergetbestrespawnmissionorigin(var0)) {
    return 1;
  }

  var1 = primesneeded(var0);
  var2 = propnumflashes(var0);
  var3 = var1 + var2;
  return var3;
}

function propnumflashes(var0) {
  var1 = 0;
  return var1 * var0.playerforcespawn.size;
}

function primesneeded(var0) {
  switch (var0.playerforcespawn.size) {
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

function playerfakesplash(var0, var1, var2) {
  var2 endon("death");
  var2 notify("focus_fire_attacker_" + var1);
  var2 endon("focus_fire_attacker_" + var1);
  scripts\engine\utility::waittill_any_ents_or_timeout_return(4.5, var0, "disconnect");
  ref_12be9(var1, var2);
}

function playergetbestrespawnmissionorigin(var0) {
  return isDefined(var0.playerforcespawn);
}

function ref_13f83(var0) {
  if(!ref_132d9()) {
    return;
  }

  if(shipment_spawnpatchtriggers(var0)) {
    var0 notify("delete_focus_fire_icon");
    return;
  }

  if(!sg_removequestinstance(var0)) {
    ref_11a84(var0);
    return;
  }

  objective_icon(var0.playergetbestdropbagorigin, propsetflashesleft(var0));
}

function ref_11a84(var0) {
  var1 = ref_11a83(var0);
  var2 = var0 getentitynumber();
  var3 = scripts\cp\cp_objectives::requestworldid("enemy_AI_focus_fire_ID_" + var2, 22);
  objective_state(var3, "current");
  objective_icon(var3, propsetflashesleft(var0));
  objective_setbackground(var3, 1);
  objective_addalltomask(var3);
  objective_showtoplayersinmask(var3);
  objective_setplayintro(var3, 0);
  objective_setplayoutro(var3, 0);
  objective_setshowdistance(var3, 0);
  objective_setshowprogress(var3, 0);
  objective_setfadedisabled(var3, 1);
  objective_sethot(var3, 1);
  objective_setpulsate(var3, 0);
  objective_setshowoncompass(var3, 0);
  objective_onentity(var3, var1);
  var0.playergetbestdropbagorigin = var3;
  thread playerfriendlyto(var1, var1, var0, var2);
}

function playerfriendlyto(var0, var1, var2, var3) {
  var0 endon("death");
  var1 scripts\engine\utility::ref_143a5("delete_focus_fire_icon", "death");
  scripts\cp\cp_objectives::freeworldid("enemy_AI_focus_fire_ID_" + var2);
  objective_delete(var3);
  var1.playergetbestdropbagorigin = undefined;
  var0 delete();
}

function ref_11a83(var0) {
  var1 = (0, 0, 15);
  var2 = (23, 8, 0);
  var3 = "j_neck";
  var4 = var0 gettagorigin(var3);
  var5 = spawn("script_model", var4 + var1);
  var5 setModel("tag_origin");
  var5 linkTo(var0, var3, var2, (0, 0, 0));
  return var5;
}

function sg_removequestinstance(var0) {
  return isDefined(var0.playergetbestdropbagorigin);
}

function ref_13f82(var0) {
  if(!ref_132d9()) {
    return;
  }

  if(shipment_spawnpatchtriggers(var0)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var0.playerforcespectatorclientwait);
    var0.playerforcespectatorclientwait = undefined;
    return;
  }

  if(!sg_playerdisconnect(var0)) {
    ref_11a82(var0);
    return;
  }

  setheadiconfriendlyimage(var0.playerforcespectatorclientwait, propsetflashesleft(var0));
}

function ref_132d9() {
  if(getdvarint("hide_focus_fire_icon", 0) != 0) {
    return false;
  }

  return true;
}

function shipment_spawnpatchtriggers(var0) {
  return var0.playerforcespawn.size == 0;
}

function sg_playerdisconnect(var0) {
  return isDefined(var0.playerforcespectatorclientwait);
}

function ref_11a82(var0) {
  var1 = propsetflashesleft(var0);
  var0.playerforcespectatorclientwait = var0 scripts\cp_mp\entityheadicons::setheadicon_singleimage("allies", var1, 10, 1, undefined, undefined, undefined, 0, 1);
}

function propsetflashesleft(var0) {
  switch (var0.playerforcespawn.size) {
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

function ref_12018(var0, var1, var2, var3, var4, var5) {}

function ref_12014(var0, var1, var2, var3, var4, var5) {
  if(isDefined(var2) && isPlayer(var2)) {
    return;
  }

  if(isDefined(var0.owner) && isPlayer(var0.owner)) {
    var0 = var0.owner;
  }

  if(!(isDefined(var0) && isPlayer(var0))) {
    return;
  }

  var6 = var0 getentitynumber();

  if(!truckcollision(var6, var2)) {
    backtruck(var6, var2);
  }

  thread playerfakesplash(var2, var0, var6);
}

function ref_12b76(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = propsetclonesleft(var0);
  return int(var2 * var8);
}

function tacinsert_destroyuselistener(var0) {}

function ref_130bc(var0) {
  var0.ondamagerelics["relic_focus_fire"] = 1;
  var0.ref_12015["relic_focus_fire"] = 1;
}

function ref_13f42(var0) {
  var0.ondamagerelics["relic_focus_fire"] = 0;
  var0.ref_12015["relic_focus_fire"] = 0;

  if(scripts\engine\utility::array_contains(level.modifyplayerdamage_relics, &ref_12b76)) {
    level.modifyplayerdamage_relics = scripts\engine\utility::array_remove(level.modifyplayerdamage_relics, &ref_12b76);
    return;
  }
}

function tacinsert_gamemode_callback(var0) {}

function ref_130bd(var0) {
  var0.onkillrelics["relic_gas_martyr"] = 1;
}

function ref_13f43(var0) {
  var0.onkillrelics["relic_gas_martyr"] = 0;
}

function setuphqs(var0, var1, var2, var3, var4, var5) {
  setuphelilandingposition(var0, var1, var2, var3, var4, var5, &propwaitminigamebuttonwatch);
}

function propwaitminigamebuttonwatch() {
  return ["gas_mp"];
}

function tacmapvo(var0) {}

function ref_130c7(var0) {
  var0.onkillrelics["relic_martyrdom"] = 1;
}

function ref_13f4d(var0) {
  var0.onkillrelics["relic_martyrdom"] = 0;
}

function setuphelitimer(var0, var1, var2, var3, var4, var5) {
  setuphelilandingposition(var0, var1, var2, var3, var4, var5, &putinlaststand);
}

function setuphelilandingposition(var0, var1, var2, var3, var4, var5, var6) {
  var7 = 147456;
  var8 = "j_spine4";

  if(isDefined(var2.unittype) && var2.unittype == "suicidebomber") {
    return;
  }

  var9 = 15;
  var10 = anglesToForward(var2.angles);
  var11 = var2 gettagorigin(var8) + var10 * var9;
  var12 = [[var6]]();
  var13 = var2;
  var14 = scripts\engine\utility::random(var12);
  var15 = var13 launchgrenade(var14, var11, var10 * propwaitminigamecleanuponplayernotify(var14), propwaitminigamefalltimer(var14));

  if(var14 == "concussion_grenade_mp") {
    var15.owner = var2;
  } else {
    var15.owner = spawnStruct();
    var15.owner.team = "axis";
  }

  var15.team = "axis";

  switch (var14) {
    case "frag_grenade_mp":
      thread lootsource(level);
      break;
    case "molotov_mp":
      level thread scripts\cp\powers\coop_molotov::bomber_shouldusetraversals(var13, var15);
      break;
    case "gas_mp":
      var13 thread scripts\cp\equipment\cp_gas_grenade::gas_used(var15);
      break;
    case "concussion_grenade_mp":
      var15 thread scripts\cp\cp_weapon::watchconcussiongrenadeexplode();
      break;
  }
}

function lootsource(var0) {
  var0 endon("trigger");
  var0 waittill("explode", var1);
  var2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  if(var2.size > 0) {
    var3 = scripts\engine\utility::getclosest(var1, var2);
    var3 radiusdamage(var1, 256, 140, 70, var3, "MOD_GRENADE_SPLASH", getcompleteweaponname("frag_grenade_mp"));
    return;
  }

  radiusdamage(var1, 256, 140, 70, undefined, "MOD_GRENADE_SPLASH", getcompleteweaponname("frag_grenade_mp"));
}

function putinlaststand() {
  var0 = ["frag_grenade_mp"];
  var1 = getDvar("martyrdom_grenade_types", "");

  if(var1 != "") {
    return powered_on_model(var1);
  }

  return var0;
}

function powered_on_model(var0) {
  var1 = strtok(var0, ",");
  var2 = [];

  foreach(var4 in var1) {
    var2 = scripts\engine\utility::array_add(var2, prematchinfinitammo(var4));
  }

  return var2;
}

function prematchinfinitammo(var0) {
  switch (var0) {
    case "frag":
      return "frag_grenade_mp";
    case "gas":
      return "gas_mp";
    case "molotov":
      return "molotov_mp";
    case "concussion":
      return "concussion_grenade_mp";
    default:
      break;
  }
}

function propwaitminigamecleanuponplayernotify(var0) {
  switch (var0) {
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

function propwaitminigamefalltimer(var0) {
  switch (var0) {
    case "frag_grenade_mp":
      return 1.5;
    case "flash_grenade_mp":
      return 1;
    default:
      return 1.5;
  }
}

function tacinsert_monitorupdatespawnposition(var0) {}

function ref_130bf(var0) {
  var0.persistentrelics["relic_gun_game"] = 1;
  thread ref_124a9(var0);
  thread ref_124a8(var0);
}

function ref_124a8(var0) {
  var0 endon("disconnect");
  var0 notify("player_gun_game_next_weapon_think");
  var0 endon("player_gun_game_next_weapon_think");
  var0 endon("unset_gun_game");
  var0 waittill("player_spawned_with_loadout");
  var0.set_stealth_enabled = var0.primaryweaponobj;

  for(;;) {
    var0 waittill("gun_game_next_weapon");
    var1 = race_ui_show_record(var0);
    var0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var1, undefined, undefined, 1);
    var0 givemaxammo(var1);
    var2 = var0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var1, 0);
    var0 scripts\engine\utility::ref_143b9(1, "weapon_change");
    var0 takeweapon(var0.set_stealth_enabled);
    var0.set_stealth_enabled = var1;
  }
}

function setupdogtags(var0, var1) {
  var0 endon("disconnect");
  var0 notify("handlePersistentGunGame");
  var0 endon("handlePersistentGunGame");
  var0 endon("unset_gun_game");

  for(;;) {
    var0 waittill("weapon_fired", var2);

    if(isDefined(var0.set_stealth_enabled) && !scripts\cp\cp_laststand::player_in_laststand(var0)) {
      var3 = var0 getweaponammoclip(var0.set_stealth_enabled) + var0 getweaponammostock(var0.set_stealth_enabled);

      if(var3 == 0) {
        var0 notify("gun_game_next_weapon");
      }

      if(!var0 hasweapon(var0.set_stealth_enabled)) {
        var0 notify("gun_game_next_weapon");
      }
    }
  }
}

function ref_124a9(var0) {
  var0 endon("disconnect");
  var0 notify("player_gun_game_randomize_weapon_list_think");
  var0 endon("player_gun_game_randomize_weapon_list_think");
  var0 endon("unset_gun_game");

  for(;;) {
    var0 waittill("luinotifyserver", var1, var2);

    if(var1 == "class_select" || var1 == "class_edit" || var1 == "class_menu_closed") {
      break;
    }
  }

  for(;;) {
    var0 waittill("player_spawned_with_loadout");

    if(isDefined(var0.secondaryweaponobj)) {
      var0 takeweapon(var0.secondaryweaponobj);
    }

    powerscooldown(var0);
  }
}

function race_ui_show_record(var0) {
  var1 = var0.ref_12a04[var0.ref_12a03];
  var0.ref_12a03++;

  if(var0.ref_12a03 == var0.ref_12a04.size) {
    var0.ref_12a03 = 0;
  }

  return var1;
}

function powerscooldown(var0) {
  var1 = [];

  for(var2 = 0; var2 < 10; var2++) {
    if(isDefined(var0.intro_drive_along_path) && var2 == var0.intro_drive_along_path) {
      continue;
    }

    var3 = init_intro_anims(var0, var2);
    var1 = var3;
  }

  for(var4 = 0; var4 < 10; var4++) {
    var1 = scripts\engine\utility::array_randomize(var1);
  }

  if(isDefined(var0.intro_drive_along_path)) {
    var3 = init_intro_anims(var0, var0.intro_drive_along_path);
    var1 = var3;
  }

  var0.ref_12a03 = 0;
  var0.ref_12a04 = var1;
}

function init_intro_anims(var0, var1) {
  var2 = spawnStruct();
  var3 = var0 scripts\cp\cp_loadout::loadout_updateclasscustom(var2, var1);
  var4 = scripts\cp\cp_weapon::buildweapon(var3.loadoutprimary, var3.loadoutprimaryattachments, var3.loadoutprimarycamo, var3.loadoutprimaryreticle, var3.loadoutprimaryvariantid, var3.loadoutprimaryattachmentids, var3.loadoutprimarycosmeticattachment, var3.loadoutprimarystickers, istrue(var3.loadouthasnvg));
  var4 = scripts\cp\cp_loadout::scriptable_door_get_in_radius(var0, var4);
  return var4;
}

function ref_13f45(var0) {
  var0.persistentrelics["relic_gun_game"] = 0;
  var0 notify("unset_gun_game");
}

function taccover_timeout(var0) {}

function ref_130b4(var0) {
  var0.ref_1389a = 0;
}

function ref_13f3c(var0) {
  var0.ref_1389a = undefined;
}

function setup_next_advance() {
  thread ref_137a2();
}

function ref_137a2(var0) {
  wait 45;
  level.little_bird_mg_mp_init = undefined;

  switch (level.script) {
    case "cp_arms_dealer":
      level thread scripts\cp\killstreaks\gunship_cp::notcanon(75, undefined, (-18750.2, 9332.44, 0), 40000, 15000, var0);
      break;
    case "cp_smuggler":
      level thread scripts\cp\killstreaks\gunship_cp::notcanon(45, undefined, undefined, 40000, 15000, var0);
      break;
    case "cp_landlord_2":
      level thread scripts\cp\killstreaks\gunship_cp::notcanon(45, undefined, (3289.02, 45965.8, 0), 40000, 15000, var0);
      break;
    default:
      level thread scripts\cp\killstreaks\gunship_cp::notcanon(45, undefined, undefined, undefined, undefined, var0);
      break;
  }
}

function tac_rover_horn(var0) {}

function ref_130ae(var0) {
  scripts\cp\cp_modular_spawning::add_global_spawn_function("axis", &ref_130af);

  foreach(var2 in level.spawned_enemies) {
    ref_130af(var2);
  }
}

function ref_13f36(var0) {
  scripts\cp\cp_modular_spawning::remove_global_spawn_function("axis", &ref_130af);

  foreach(var2 in level.spawned_enemies) {
    ref_13f37(var2);
  }
}

function ref_130af() {
  thread bistrexactive(self);
  self.fnmeleecharge_init = &bisthread;

  if(self.meleechargedistvsplayer < 3000) {
    self.bisoverwatch = 1;
    self.ref_12146 = self.meleechargedistvsplayer;
    self.meleechargedistvsplayer = 3000;
    return;
  }
}

function ref_13f37() {
  self.fnmeleecharge_init = undefined;
  self notify("stop_aggressively_chase_down_target");

  if(istrue(self.bisoverwatch)) {
    self.meleechargedistvsplayer = self.ref_12146;
    self.ref_12146 = undefined;
    self.bisoverwatch = undefined;
    return;
  }
}

function bisthread(var0) {
  self.melee.bignoretimeout = 1;
  self.melee.bignoretargetflee = 1;
}

function bistrexactive(var0) {
  var0 endon("death");
  var0 endon("stop_aggressively_chase_down_target");

  for(;;) {
    if(isDefined(var0.enemy) && isPlayer(var0.enemy)) {
      var1 = getclosestpointonnavmesh(var0.enemy.origin);
      var0 setgoalpos(var1);
    }

    wait 1;
  }
}

function take_time_away_from_bomb_vest_timer(var0) {
  var0.ref_12bab = 1;
  var0 setcamerathirdperson(1);
}

function ref_130d7(var0) {
  var0.ref_12bab = 1;
  thread ref_130f4();
}

function ref_130f4() {
  self endon("death");
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;
  self setcamerathirdperson(1);
}

function ref_13f5c(var0) {
  var0.ref_12bab = undefined;
  var0 setcamerathirdperson(0);
}

function tag_usb_with_head_icon(var0) {
  var0.little_bird = 1;
}

function ref_130cd(var0) {
  var0.little_bird = 1;
}

function ref_13f53(var0) {
  var0.little_bird = undefined;
}

function takelaststandtransitionweapon(var0) {
  thread ref_13f8f();
}

function ref_12bae() {
  level.ref_12bac = 1;
  setomnvar("ui_showhealthbar", 1);
}

function ref_130d9(var0) {
  var0.ondamagerelics["relic_vampire"] = 1;
}

function ref_13f5e(var0) {
  level.ref_12bac = 0;
}

function ref_1201d(var0, var1, var2, var3, var4, var5) {
  if(!isagent(var2)) {
    return;
  }

  var6 = undefined;

  if(!isPlayer(var0)) {
    if(!isDefined(var0.owner)) {
      return;
    } else {
      var6 = var0.owner;
    }
  } else {
    var6 = var0;
  }

  if(isDefined(var6) && !istrue(var6.inlaststand)) {
    if(var6.health + 5 > var6.maxhealth) {
      var6 scripts\cp\cp_damage::set_normalhealth(var6.maxhealth / var6.maxhealth);
    } else {
      var6 scripts\cp\cp_damage::set_normalhealth((var6.health + 5) / var6.maxhealth);
    }

    if(!isDefined(var6.waittill_player_completes_assassination_contract)) {
      var6.waittill_player_completes_assassination_contract = 0;
    }

    if(gettime() < var6.waittill_player_completes_assassination_contract) {
      return;
    }

    var6.waittill_player_completes_assassination_contract = gettime() + 300;
    thread ref_12bad();
    return;
  }
}

function ref_12bad() {
  self endon("last_stand");
  self endon("disconnect");
  wait 0.25;
  self setclientomnvar("damage_feedback_icon", "hitadrenaline");
  self setclientomnvar("damage_feedback_icon_notify", gettime());

  if(!isDefined(self.waittill_player_completes_scavenger_contract)) {
    self.waittill_player_completes_scavenger_contract = 0;
  }

  if(gettime() < self.waittill_player_completes_scavenger_contract) {
    return;
  }

  self playlocalsound("cp_hacking_success");
  self.waittill_player_completes_scavenger_contract = gettime() + 500;
}

function tacinsert_pickuplistener(var0) {
  thread ref_13f8f();
}

function ref_12b79() {
  level.ref_12b78 = 1;
  setomnvar("ui_showhealthbar", 1);
  level.showsplashtoallexceptteam = getdvarint("relic_healthpack_health", 25);
}

function ref_130c1(var0) {
  var0.onkillrelics["relic_healthpacks"] = 1;
}

function ref_13f47(var0) {
  var0.onkillrelics["relic_healthpacks"] = 0;
}

function ref_12b7a(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(level.audio_fade_in_ext_walla)) {
    level.audio_fade_in_ext_walla = [];
  }

  if(level.audio_fade_in_ext_walla.size >= 20) {
    level.audio_fade_in_ext_walla[0].trigger.fx delete();
    level.audio_fade_in_ext_walla[0].trigger delete();
    level.audio_fade_in_ext_walla[0] delete();
    waitframe();
  }

  while(isDefined(var2) && isDefined(var2.a) && istrue(var2 scripts\engine\utility::doinglongdeath())) {
    wait 0.1;
  }

  var6 = getgroundposition(var2.origin, 4, 10);
  var7 = spawn("trigger_radius", var6, 0, 72, 72);
  var7.fx = spawnfx(level._effect["healthpack_spawn"], var6 + (0, 0, 25));
  triggerfx(var7.fx);
  thread ref_12b7b();
}

function ref_12b7b() {
  self endon("pickedup");
  self endon("death");
  thread ref_12b7c();
  var0 = gettime() + 20000;

  while(gettime() < var0) {
    wait 0.05;
  }

  playsoundatpos(self.origin, "mp_killconfirm_tags_pickup");
  playFX(level._effect["healthpack_pickup"], self.origin + (0, 0, 25));
  self.fx delete();
  self delete();
}

function ref_12b7c() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var0);

    if(!isPlayer(var0) || !var0 scripts\cp\utility::is_valid_player() || var0.health == var0.maxhealth) {
      continue;
    }

    self notify("pickedup");
    var0 playlocalsound("mp_killconfirm_tags_pickup");
    playFX(level._effect["healthpack_pickup"], self.origin);
    var1 = var0 getnormalhealth();

    if(var1 + int(level.showsplashtoallexceptteam / 100)) {
      var0 scripts\cp\cp_damage::set_normalhealth(1);
    } else {
      var0 scripts\cp\cp_damage::set_normalhealth(var1 + int(level.showsplashtoallexceptteam / 100));
    }

    self.fx delete();
    self delete();
    return;
  }
}

function tac_rover_initomnvars(var0) {}

function ref_130b2(var0) {
  level.ref_12b6c = 1;
  var0.ref_12020["relic_bang_and_boom"] = 1;
  var0.ref_11e8e = 1;
}

function ref_13f3a(var0) {
  level.ref_12b6c = 0;
  var0.ref_12020["relic_bang_and_boom"] = 0;
  var0.ref_11e8e = undefined;
}

function ref_12b6d(var0, var1) {
  if(!isDefined(level.audio_gauntlet_leave_sfx_transition)) {
    level.audio_gauntlet_leave_sfx_transition = [];
  }

  if(level.audio_gauntlet_leave_sfx_transition.size >= 20) {
    level.audio_gauntlet_leave_sfx_transition[0].trigger delete();
    level.audio_gauntlet_leave_sfx_transition[0] delete();
    waitframe();
  }

  var2 = redbuttonused(var1);

  if(!isDefined(var2)) {
    return;
  }

  var3 = spawn("trigger_radius", var0, 0, 72, 72);

  if(var2 == "ammo") {
    var3.minigun_sweep_to_loc_safe = "ammo";
  } else {
    var3.minigun_sweep_to_loc_safe = "grenade";
  }

  playsoundatpos(var0, "mp_killconfirm_tags_drop");
  thread ref_12b6e();
}

function redbuttonused(var0) {
  var1 = undefined;

  switch (var0.smeansofdeath) {
    case "MOD_PROJECTILE":
    case "MOD_PISTOL_BULLET":
    case "MOD_RIFLE_BULLET":
      var1 = "grenade";
      break;
    case "MOD_EXPLOSIVE_BULLET":
    case "MOD_FIRE":
    case "MOD_EXPLOSIVE":
    case "MOD_GRENADE_SPLASH":
    case "MOD_GRENADE":
    case "MOD_PROJECTILE_SPLASH":
    case "MOD_IMPACT":
      var1 = "ammo";
      break;
  }

  return var1;
}

function ref_12b6e() {
  self endon("pickedup");
  self endon("death");
  thread ref_12b6f();
  var0 = gettime() + 20000;

  while(gettime() < var0) {
    wait 0.05;
  }

  setheadiconimage(self.headicon);
  self delete();
}

function ref_12b6f() {
  self endon("death");
  self.headicon = setheadicondrawinmap(self.origin + (0, 0, 14));

  if(self.minigun_sweep_to_loc_safe == "ammo") {
    setheadiconfriendlyimage(self.headicon, "hud_icon_ammo");
  } else {
    setheadiconfriendlyimage(self.headicon, "hud_icon_equipment_frag");
  }

  setheadiconsnaptoedges(self.headicon, 29000);
  setheadiconmaxdistance(self.headicon, 10);
  addclienttoheadiconmask(self.headicon, 10);

  for(;;) {
    self waittill("trigger", var0);

    if(!isPlayer(var0) || !var0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    var1 = 0;

    if(self.minigun_sweep_to_loc_safe == "ammo") {
      var0 playlocalsound("weap_ammo_pickup");
      var1 = var0 scripts\cp\cp_agent_damage::score_spawner_relative_to_objective();
    } else {
      var0 playlocalsound("weap_ammo_pickup");

      if(ref_132d2(var0)) {
        var1 = 1;
        var0 thread scripts\cp\cp_grenade_crate::healthbox_onusedeployable();
      }
    }

    if(var1) {
      self notify("pickedup");
      playFX(level._effect["dogtag_pickup"], self.origin);
      setheadiconimage(self.headicon);
      self delete();
      return;
    }
  }
}

function ref_132d2() {
  var0 = 1;
  var1 = 1;
  var2 = self getweaponslistprimaries();

  foreach(var4 in var2) {
    if(weapontype(var4) == "projectile") {
      if(var4.basename == "iw8_la_mike32_mp") {
        if(self.gl_proj_override == "thermite") {
          continue;
        }
      }

      if(!scripts\cp\cp_grenade_crate::ref_11b4a(var4)) {
        var1 = 0;
      }
    }

    if(var4.inventorytype == "altmode" && isDefined(var4.underbarrel) && var4.underbarrel == "ubshtgn") {
      if(!scripts\cp\cp_grenade_crate::ref_11b4a(var4)) {
        var1 = 0;
      }
    }
  }

  foreach(var7 in self.powers) {
    if(var7.charges < var7.maxcharges) {
      var0 = 0;
    }
  }

  if(!var0 || !var1) {
    return true;
  }

  return false;
}

function tag_to_shoot_from(var0) {}

function ref_130cc(var0) {
  var0.ref_11e8e = 1;
}

function ref_13f52(var0) {
  var0.ref_11e8e = undefined;
}

function tacinsert_updatepickupusability(var0) {}

function ref_130c4(var0) {
  if(!scripts\engine\utility::array_contains(level.modifyplayerdamage_relics, &ref_12b7f)) {
    level.modifyplayerdamage_relics = scripts\engine\utility::array_add(level.modifyplayerdamage_relics, &ref_12b7f);
    return;
  }
}

function ref_13f4a(var0) {
  level.modifyplayerdamage_relics = scripts\engine\utility::array_remove(level.modifyplayerdamage_relics, &ref_12b7f);
}

function ref_12b7f(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = 1;

  if(isDefined(var1) && isPlayer(var1)) {
    foreach(var10 in level.players) {
      if(isDefined(var10) && scripts\cp\cp_laststand::player_in_laststand(var10)) {
        var8++;
      }
    }
  }

  var12 = int(var2 * var8);
  return var12;
}

function tacinsert_brrespawnsplash(var0) {}

function ref_130b6(var0) {
  var0.ondamagerelics["relic_doomslayer"] = 1;
  var0.ref_11e8e = 1;
}

function ref_13f3e(var0) {
  var0.ondamagerelics["relic_doomslayer"] = 0;
  var0.ref_11e8e = 0;
}

function ref_12017(var0, var1, var2, var3, var4, var5) {
  level endon("game_ended");
  var0 endon("disconnect");

  if(!isDefined(var0) || !isalive(var0)) {
    return;
  }

  if(isDefined(var3) && (var3 == "MOD_MELEE" || var3 == "MOD_EXECUTION")) {
    var0.ref_11e8e = 0;
    return;
  }

  var0.ref_11e8e = 1;
}

function taillightleft(var0) {}

function ref_130d1(var0) {
  var0.onkillrelics["relic_rocket_kill_ammo"] = 1;
}

function ref_13f57(var0) {
  var0.onkillrelics["relic_rocket_kill_ammo"] = 0;
  var0 setclientomnvar("ui_cp_relic_ammo_reward", 0);
}

function setuphumanpowers(var0, var1, var2, var3, var4, var5) {
  level endon("game_ended");
  var1 endon("disconnect");

  if(!isDefined(var1) || !isalive(var1)) {
    return;
  }

  if(!isDefined(var0) || weapontype(var0) != "projectile" || !var1 hasweapon(var0)) {
    return;
  }

  var6 = var1 getammocount(var0);
  var7 = weaponclipsize(var0);
  var1 setweaponammoclip(var0, var7);
  var1 setweaponammostock(var0, var6 - var7 + 1);
}

function tacinsert_onjoinedteam(var0) {}

function ref_130c0(var0) {
  var0.onkillrelics["relic_headbullets"] = 1;
}

function ref_13f46(var0) {
  var0.onkillrelics["relic_headbullets"] = 0;
  var0 setclientomnvar("ui_cp_relic_ammo_reward", 0);
}

function setup_trap_consoles(var0, var1, var2, var3, var4, var5) {
  level endon("game_ended");
  var1 endon("disconnect");

  if(!isDefined(var1) || !isalive(var1)) {
    return;
  }

  if(!scripts\cp\utility::isheadshot(var0, var4, var3, var1)) {
    return;
  }

  if(!isDefined(var0) || weapontype(var0) != "bullet" || !var1 hasweapon(var0)) {
    return;
  }

  while(var1 isreloading()) {
    wait 0.05;
  }

  var6 = weaponclipsize(var0);
  var7 = int(var6 * 0.25);
  var7 = int(clamp(var7, 1, 10));
  thread ref_12b6a(var1, var0);
}

function tagtaken(var0) {}

function ref_130d0(var0) {
  var0.onkillrelics["relic_punchbullets"] = 1;
  thread ref_12b95();
}

function ref_13f56(var0) {
  var0.onkillrelics["relic_punchbullets"] = 0;
  var0 setclientomnvar("ui_cp_relic_ammo_reward", 0);
  var0 notify("relic_punchbullets_ender");
  var0.ref_1287f = undefined;
}

function ref_12b94() {
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  wait 1;
  self takeallweapons();
  self giveweapon("iw8_fists_mp");
  self switchtoweapon("iw8_fists_mp");
  self disableweaponpickup();
  wait 1;
  self setscriptablepartstate("equipMtovFXWorld", "neutral", 0);
  self setscriptablepartstate("equipMtovFXView", "active", 0);
  self setscriptablepartstate("burning", "active");
  wait 0.5;
  self setscriptablepartstate("equipMtovFXWorld", "active", 0);
}

function ref_12b95() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("relic_punchbullets_ender");

  for(;;) {
    var0 = self getcurrentweapon();

    if(isDefined(var0) && weapontype(var0) == "bullet") {
      self.ref_1287f = var0;
    } else if(isDefined(self.ref_1287f) && !self hasweapon(self.ref_1287f)) {
      self.ref_1287f = undefined;
    }

    self waittill("weapon_change");
  }
}

function setupblueprintpickupweapons(var0, var1, var2, var3, var4, var5) {
  level endon("game_ended");
  var1 endon("death_or_disconnect");

  if(!isDefined(var1) || !isalive(var1)) {
    return;
  }

  if(!isDefined(var3) || var3 != "MOD_MELEE" && var3 != "MOD_EXECUTION") {
    return;
  }

  if(var3 == "MOD_EXECUTION" && isDefined(var1.ref_1287f)) {
    var0 = var1.ref_1287f;
  }

  if(!isDefined(var0) || weapontype(var0) != "bullet" || !var1 hasweapon(var0)) {
    return;
  }

  while(var1 isreloading()) {
    wait 0.05;
  }

  var6 = weaponclipsize(var0);
  var7 = int(var6 * 0.25);
  var7 = int(clamp(var7, 1, 10));
  thread ref_12b6a(var1, var0);
}

function ref_12b6a(var0, var1, var2) {
  level endon("game_ended");
  self endon("disconnect");
  var3 = self;
  wait 0.75;

  if(!isDefined(var0) || weapontype(var0) != "bullet" || !var3 hasweapon(var0)) {
    return;
  }

  if(!isDefined(var2)) {
    var2 = 1;
  }

  var4 = try_start_fake_infil_chopper("relic_oneclip");
  var5 = weaponclipsize(var0);
  var6 = var3 getweaponammoclip(var0);

  if(!istrue(var4)) {
    var5 += weaponmaxammo(var0);
    var6 += var3 getweaponammostock(var0);
  }

  var1 = int(min(var5 - var6, var1));

  if(var1 == 0) {
    return;
  }

  var7 = var3 getcurrentweapon() == var0 || var3 isinexecutionattack();

  if(var7) {
    thread ref_12b70(var3);
  }

  if(var7 && var2) {
    while(var1 > 0) {
      var8 = thread ref_12b6b(var3, var0);

      if(istrue(var8)) {
        var3 notify("ammo_awarded");
      } else {
        break;
      }

      wait 0.2;
      var1--;
    }

    return;
  }

  var9 = weaponclipsize(var0);
  var10 = var3 getweaponammoclip(var0);
  var11 = var9 - var10;

  if(var11 >= var1) {
    var3 setweaponammoclip(var0, var10 + var1);
  } else {
    var3 setweaponammoclip(var0, var9);

    if(!istrue(var4)) {
      var12 = weaponmaxammo(var0);
      var13 = var3 getweaponammostock(var0);
      var1 -= var11;
      var14 = int(min(var12, var13 + var1));
      var3 setweaponammostock(var0, var14);
    }
  }

  var3 notify("ammo_awarded");
}

function ref_12b6b(var0, var1) {
  var2 = self;

  if(!isDefined(var0) || weapontype(var0) != "bullet" || !var2 hasweapon(var0)) {
    return;
  }

  var3 = var2 getweaponammoclip(var0);

  if(istrue(var1) || var3 < weaponclipsize(var0)) {
    var2 setweaponammoclip(var0, var3 + 1);
    var2 playlocalsound("weap_ammo_pickup");
    return 1;
  } else {
    var4 = var2 getweaponammostock(var0);

    if(var4 < weaponmaxammo(var0)) {
      var2 setweaponammostock(var0, var4 + 1);
      var2 playlocalsound("weap_ammo_pickup");
      return 1;
    }
  }

  return 0;
}

function ref_12b70(var0) {
  self notify("relic_punchbullets_reward_hud_display");
  self endon("relic_punchbullets_reward_hud_display");
  self endon("disconnect");
  level endon("game_ended");
  self setclientomnvar("ui_cp_relic_ammo_reward", 0);
  wait 0.25;
  self setclientomnvar("ui_cp_relic_ammo_reward", var0);
  wait 1.75;
  self setclientomnvar("ui_cp_relic_ammo_reward", 0);
}

function take_ai_weapon(var0) {}

function ref_130d4(var0) {
  var0.onkillrelics["relic_steelballs"] = 1;
  var0.ondamagerelics["relic_steelballs"] = 1;
  thread ref_12ba4();
  thread ref_12ba7();
  thread ref_12ba8();
  thread ref_130d5(var0);
}

function ref_130d5(var0) {
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  var1 = var0.origin;

  while(var0.origin == var1) {
    wait 0.25;
  }

  var0 scripts\cp\utility::giveperk("specialty_extendedMelee");
  var0 scripts\cp\utility::giveperk("specialty_hardmelee");
  wait 0.05;
  var0.perk_data["melee_scalar"] = 3;
}

function ref_13f5a(var0) {
  var0 scripts\cp\perks\cp_perks::removeperk("specialty_extendedMelee");
  var0 scripts\cp\perks\cp_perks::removeperk("specialty_hardmelee");
  var0.onkillrelics["relic_steelballs"] = 0;
  var0.ondamagerelics["relic_steelballs"] = 0;

  if(isDefined(var0.ref_13413)) {
    var0.ref_13413 delete();
  }

  var0 notify("relic_steelballs_ender");
}

function setupboardroomcode(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var1) || !isalive(var1)) {
    return;
  }

  if(!isDefined(var3) || var3 != "MOD_MELEE") {
    return;
  }

  thread ref_12ba6();
  var1 playSound("gib_fullbody");
}

function ref_1201c(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var2)) {
    return;
  }

  var2.playerlootleadervalidity = undefined;
  var2.shouldhelmetpop = undefined;

  if(isDefined(var2.ref_12144) && isDefined(var2.a)) {
    var2.a.disablelongdeath = var2.ref_12144;
  }

  if(!isDefined(var0) || !isalive(var0)) {
    return;
  }

  if(!isDefined(var3) || var3 != "MOD_MELEE") {
    return;
  }

  var2.playerlootleadervalidity = 1;
  var2.shouldhelmetpop = 1;

  if(isDefined(var2.a)) {
    if(isDefined(var2.a.disablelongdeath)) {
      var2.ref_12144 = var2.a.disablelongdeath;
    }

    var2.a.disablelongdeath = 1;
    return;
  }
}

function ref_12ba6() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  var0 = self;
  var1 = clamp(self.health + 90, 0, self.maxhealth);
  scripts\cp\cp_damage::set_normalhealth(var1 / self.maxhealth);
}

function ref_12ba7() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("relic_steelballs_ender");

  while(!isDefined(self.model) || self.model == "") {
    wait 0.05;
  }

  wait 1;
  var0 = self gettagorigin("j_ball_le");
  var1 = spawn("trigger_radius", var0, 0, 32, 48);
  var1 enablelinkTo();
  var1 linkTo(self, "j_ball_le", (0, 0, 0), (0, 0, 0));
  self.ref_13413 = var1;
  var1 endon("death");

  for(;;) {
    self waittill("sprint_slide_begin");
    wait 0.3;

    while(self issprintsliding()) {
      self.ref_13413 waittill("trigger", var2);
      earthquake(0.2, 0.25, self.origin, 100);
      self playRumbleOnEntity("slide_loop");

      if(isDefined(var2) && !isPlayer(var2) && (isai(var2) || isagent(var2)) && self issprintsliding()) {
        ref_12ba5(var2, self, 32, 285);
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

function ref_12ba5(var0, var1, var2, var3) {
  var0.open_close_loop = 1;
  var0.shouldhelmetpop = 1;
  var4 = var0.health;
  radiusdamage(var0.origin + (0, 0, 8), var2, var3, var3 - 1, var1, "MOD_MELEE");
  var1.lasthitmarkertime = undefined;
  var1 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitcritical");
}

function ref_12ba4() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("relic_steelballs_ender");

  for(;;) {
    self waittill("melee_swipe_start");
    var0 = 250;
    var1 = anglesToForward(self getplayerangles(1));
    var2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var3 = scripts\engine\utility::get_array_of_closest(self.origin, var2, undefined, undefined, 128);

    if(isDefined(var3) && var3.size > 0) {
      var4 = var3[0];
      var5 = var4 getEye() - (0, 0, 12);
      var6 = self worldpointinreticle_circle(var5, 70, 300);
      var7 = sighttracepassed(var4 getEye(), self getEye(), 0, var4);

      if(var6 && var7) {
        var1 = scripts\engine\utility::flatten_vector(var4.origin - self.origin);
        var0 = 350;
      }
    }

    self knockback(var1, var0);
    wait 0.5;
  }
}

function ref_12ba8() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("relic_steelballs_ender");
  GscBinSkip4(0x35);
}

function ref_12ba9() {
  for(;;) {
    while(self isonground()) {
      wait 0.05;
    }

    var0 = gettime();
    var1 = self.origin[2];

    while(!self isonground()) {
      if(self.origin[2] > var1) {
        var1 = self.origin[2];
      }

      wait 0.05;
    }

    var2 = max(0, var1 - self.origin[2]);

    if(var2 < 128) {
      continue;
    }

    var3 = (gettime() - var0) / 1000;
    self notify("stump_damage", var3, var1, var2);
  }
}

function tags_used(var0) {}

function ref_130cf(var0) {
  thread ref_12b92();
}

function ref_13f55(var0) {
  var0 notify("set_relic_oneclip_ender");
  var0 setclientomnvar("ui_cp_relic_ammo_reward", 0);
}

function ref_12b92() {
  self endon("death_or_disconnect");
  self endon("set_relic_oneclip_ender");
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  wait 0.5;
  thread ref_12b93();

  for(;;) {
    var0 = self getweaponslistprimaries();

    foreach(var2 in var0) {
      if(!isDefined(var2) || weapontype(var2) != "bullet") {
        continue;
      }

      var3 = self getweaponammostock(var2);

      if(var3 > 0) {
        var4 = weaponclipsize(var2);
        var5 = self getweaponammoclip(var2);

        if(var5 < var4) {
          var6 = int(min(var4, var5 + var3));
          thread ref_12b6a(var2, var6 - var5);
        }

        self setweaponammostock(var2, 0);
      }
    }

    scripts\engine\utility::ref_143a8("ammo_pickup", "weapon_change", "weapon_swap", "ammo_awarded", "ammo_stock_not_empty");
  }
}

function ref_12b93() {
  self endon("death_or_disconnect");
  self endon("set_relic_oneclip_ender");

  for(;;) {
    wait 0.05;
    var0 = self getcurrentweapon();

    if(!isDefined(var0) || weapontype(var0) != "bullet") {
      continue;
    }

    if(self getweaponammostock(var0) > 0) {
      self notify("ammo_stock_not_empty");
    }
  }
}

function tacinsert_getspawnposition(var0) {}

function ref_130be(var0) {
  thread ref_12b77();
}

function ref_12b77() {
  self endon("death_or_disconnect");
  self endon("set_relic_grounded_ender");

  for(;;) {
    self waittill("reload_start");
    var0 = self getcurrentweapon();

    if(!isDefined(var0) || weapontype(var0) != "bullet") {
      continue;
    }

    var1 = self getweaponammoclip(var0);
    self setweaponammoclip(var0, 0);
    var2 = self getweaponammostock(var0);

    while(var2 == self getweaponammostock(var0)) {
      if(!self hasweapon(var0)) {
        break;
      }

      if(!self isreloading() || self getcurrentweapon() != var0) {
        self setweaponammoclip(var0, var1);
        break;
      }

      wait 0.05;
    }
  }
}

function ref_13f44(var0) {
  var0 notify("set_relic_grounded_ender");
}

function tactical_goal_in_action_thread(var0) {}

function ref_130ca(var0) {
  var0.ondamagerelics["relic_nobulletdamage"] = 1;

  if(!scripts\engine\utility::array_contains(level.modifyplayerdamage_relics, &ref_12b87)) {
    level.modifyplayerdamage_relics = scripts\engine\utility::array_add(level.modifyplayerdamage_relics, &ref_12b87);
    return;
  }
}

function ref_13f50(var0) {
  var0.ondamagerelics["relic_nobulletdamage"] = 0;
  level.modifyplayerdamage_relics = scripts\engine\utility::array_remove(level.modifyplayerdamage_relics, &ref_12b87);
}

function ref_12b87(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(!isDefined(var1)) {
    return var2;
  }

  if(!isent(var1)) {
    return var2;
  }

  if(isDefined(var1.owner)) {
    if(!isPlayer(var1.owner)) {
      return var2;
    }
  }

  if(!isPlayer(var1)) {
    return var2;
  }

  var8 = scripts\engine\utility::isbulletdamage(var3) || var3 == "MOD_EXPLOSIVE_BULLET" && var7 != "none";

  if(var8) {
    if(istrue(var4.unlockableindex)) {
      var8 = 0;
    }
  }

  if(!scripts\cp\pvpe\pvpe::pvpe_enabled()) {
    if(isPlayer(var1) && isai(var0)) {
      if(!var8) {
        return var2;
      }

      return 0;
    }

    return var2;
  }

  if(!var8) {
    return var2;
  }

  return 0;
}

function takeaccesscardpickup(var0) {
  level.persistentrelics["relic_trex"] = &setupoptimalreadinghint;
}

function ref_130d8(var0) {
  var0.persistentrelics["relic_trex"] = 1;
}

function ref_13f5d(var0) {
  var0.persistentrelics["relic_trex"] = 0;
}

function setupoptimalreadinghint(var0) {
  self notify("handleTRex");
  self endon("handleTRex");
  self endon("stop_trex");
  level endon("game_ended");

  for(;;) {
    wait 0.05;

    if(!generate_cypher(var0)) {
      continue;
    }

    var1 = var0 getvelocity();
    var2 = length(var1);

    if(var2 < 5) {
      var0 scripts\cp\utility::allow_player_ignore_me(1);
      var0.comparescriptindexobscuredspawns = 1;
      thread getcpscriptedhelidropheight(var0);
    }
  }
}

function getcpscriptedhelidropheight(var0) {
  self notify("check_for_TrexRemoval");
  self endon("check_for_TrexRemoval");

  for(;;) {
    waitframe();
    var1 = var0 getvelocity();
    var2 = length(var1);

    if(var2 >= 5) {
      var0 scripts\cp\utility::allow_player_ignore_me(0);
      var0.comparescriptindexobscuredspawns = undefined;
      break;
    }
  }
}

function generate_cypher(var0) {
  if(istrue(var0.inlaststand)) {
    return false;
  }

  if(istrue(var0.comparescriptindexobscuredspawns)) {
    return false;
  }

  return true;
}

function tac_rover_initcollision(var0) {
  var0.setvalidreviveposition = 0;
}

function ref_130b0(var0) {
  var0.setvalidreviveposition = 1;
  thread ref_12b52();
}

function ref_13f38(var0) {
  var0.setvalidreviveposition = 0;
  var0 notify("stop_ammo_drain");
}

function ref_12b52() {
  level endon("game_ended");
  self endon("stop_ammo_drain");

  for(;;) {
    if(!scripts\cp\utility::is_valid_player()) {
      wait 1;
      continue;
    }

    var0 = self getcurrentprimaryweapon();

    if(!isDefined(var0)) {
      wait 1;
      continue;
    }

    var1 = 0;
    var2 = weaponclipsize(var0);

    if(!isDefined(var2)) {
      var2 = 22.5;
    }

    if(var2 < 1) {
      var2 = 22.5;
    }

    if(weapontype(var0) == "riotshield") {
      var1 = 1;
    }

    if(istrue(var0.ismelee)) {
      var1 = 1;
    }

    if(isDefined(var0.classname)) {
      if(var0.classname == "none") {
        var1 = 1;
      }

      if(var0.classname == "grenade") {
        var1 = 1;
      }

      if(var0.classname == "rocketlauncher") {
        var1 = 1;
      }
    }

    if(self isreloading()) {
      var1 = 1;
    }

    if(scripts\cp\cp_weapon::is_incompatible_weapon(var0)) {
      var1 = 1;
    }

    if(!var1) {
      if(isDefined(self.last_weapon) && self.last_weapon == var0) {
        if(var0.inventorytype == "altmode") {
          if(isDefined(var0.underbarrel) && var0.underbarrel == "ubshtgn") {
            var3 = self getweaponammoclip(var0);
            var4 = int(max(0, var3 - 1));
            self setweaponammoclip(var0, var4);
            self setweaponammostock(var0, 0);
            self notify("ammo_drained");
            thread ref_12b70(-1);
            break;
          }
        } else {
          if(var0 hasattachment("akimbo", 1)) {
            var5 = self getweaponammoclip(var0, "left");
            var6 = self getweaponammoclip(var0, "right");

            if(!isDefined(self.waittill_any_return_no_endon_death_3)) {
              self.waittill_any_return_no_endon_death_3 = "left";
            }

            if(self.waittill_any_return_no_endon_death_3 == "left") {
              var4 = int(max(0, var5 - 1));
              self setweaponammoclip(var0, var4, "left");
              self.waittill_any_return_no_endon_death_3 = "right";
            } else {
              var4 = int(max(0, var6 - 1));
              self setweaponammoclip(var0, var4, "right");
              self.waittill_any_return_no_endon_death_3 = "left";
            }
          } else {
            var3 = self getweaponammoclip(var0);
            var4 = int(max(0, var3 - 1));
            self setweaponammoclip(var0, var4);
          }

          self notify("ammo_drained");
          thread ref_12b70(-1);
        }
      }

      var7 = max(45 / var2, 0.4);
      self.last_weapon = var0;
      scripts\engine\utility::ref_143b9(var7, "weapon_change");
      continue;
    }

    wait 1;
  }
}

function taccovertriggerblockers(var0) {}

function ref_130b5(var0) {
  level.ref_12b73 = 1;
  level.disable_hotjoin_via_ac130 = 1;
  level.dogtag_revive = 1;
}

function ref_13f3d(var0) {
  level.ref_12b73 = 0;
  level.disable_hotjoin_via_ac130 = 0;
  level.dogtag_revive = 0;
}

function tacinserts(var0) {}

function ref_130c5(var0) {
  var1 = scripts\cp\cp_weapon::buildweapon("iw8_fists_mp", [], "none", "none", -1);
  var0.playerjailtimeout = var1;
}

function ref_13f4b(var0) {
  var0.playerjailtimeout = undefined;
}

function tacinsert_destroyongameended(var0) {}

function ref_130bb(var0) {
  level.get_bleed_out_time = &ref_12b75;
}

function ref_12b75() {
  return 7;
}

function ref_13f41(var0) {
  level.get_bleed_out_time = undefined;
}

function tagautopickup(var0) {}

function ref_130ce(var0) {
  thread ref_12b8b();
}

function ref_13f54(var0) {
  level notify("relic_nuketimer_end");
}

function ref_12b8b() {
  level endon("game_ended");
  level endon("relic_nuketimer_end");

  if(isDefined(level.ref_12b88)) {
    return;
  }

  level.ref_12b88 = spawnStruct();
  level.ref_12b88.point_of_no_return = 16;
  level.ref_12b88.nuke_clockobject = spawn("script_origin", (0, 0, 100));
  level.ref_12b88.nuke_clockobject dontinterpolate();
  level.ref_12b88.nuke_clockobject hide();
  level.ref_12b88.ref_11ee9 = spawnStruct();
  level.ref_12b88.ref_11ee9.targetname = "nuke_expl_pos";
  level.ref_12b88.ref_11ee9.origin = level.ref_12b88.nuke_clockobject.origin;
  level.nuke_expl_struct = level.ref_12b88.ref_11ee9;
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  wait 0.5;
  var0 = "safehouse_door_opened";
  var1 = "obj_extract_informant_started";
  var2 = "players_go_to_safehouse";
  var3 = 60;
  var4 = "player_entered_safehouse_vol";
  var5 = tolower(getDvar("mapname"));

  switch (var5) {
    case "cp_scaletest":
      var0 = "scaletest_fire_early";
      level thread scripts\cp\utility::notify_delay(var0, 10);
      break;
    case "cp_smuggler":
      level.ref_12b88.patrolzone = 1;
      var0 = "safehouse_door_opened";
      var1 = "obj_extract_informant_started";
      var2 = "players_go_to_safehouse";
      var3 = 60;
      var4 = "player_entered_safehouse_vol";
      var6 = getDvar("restart_checkpoint", "");

      if(isDefined(var6) && var6 == "tow_p1") {
        var0 = "smuggler_fire_early";
        level thread scripts\cp\utility::notify_delay(var0, 5);
      }

      break;
  }

  level waittill(var0);
  thread ref_12b8e();
  thread ref_12b91();
  thread ref_12b90(level, var1, var2, var4);
  waitframe();
  level waittill("relic_nuke_explode");
  var7 = level.ref_12b88.nuke_clockobject.origin;
  var8 = spawn("script_model", var7);
  var8 setModel("tag_origin");
  var8.team = "axis";
  var8.pers = [];
  var8.pers["team"] = "axis";
  var8.owner = var8;
  var9 = var8 scripts\cp_mp\utility\killstreak_utility::createstreakinfo("nuke", var8);
  var8 thread _calloutmarkerping_handleluinotify_acknowledged::nuke_start(var9);
  level waittill("nuke_detonated");
  wait 5;

  if(istrue(level.ref_12b88.patrolzone)) {
    scripts\cp\cp_objectives::ref_12868("obj_nuke_ending");
  }

  var10 = scripts\cp\cp_agent_utils::getactiveenemyagents("allies");

  foreach(var12 in var10) {
    var12 suicide();
  }

  foreach(var15 in level.players) {
    var15 dodamage(var15.health + 1000, var15.origin, var15);
  }

  wait 4;
  var17 = 0;

  foreach(var15 in level.players) {
    if(var15 scripts\cp_mp\utility\player_utility::_isalive()) {
      var17 = 1;
    }
  }

  if(var17) {
    level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
    return;
  }
}

function ref_12b8e() {
  level endon("game_ended");
  level endon("relic_nuketimer_end");
  level.ref_12b88.ref_13b8a = 0;
  level.ref_12b88.ref_13b8a = ref_12b8a();
  var0 = getDvar("scr_relicnuketimerset", 0);

  if(int(var0) > 5) {
    level.ref_12b88.ref_13b8a = int(var0);
  }

  if(soundexists("iw8_nuke_alarm")) {
    level.ref_12b88.nuke_clockobject playSound("iw8_nuke_alarm");
  }

  thread ref_12b8f();
}

function ref_12b8f() {
  level endon("relic_nuketimer_end");
  setomnvar("ui_nuke_end_milliseconds", gettime() + level.ref_12b88.ref_13b8a * 1000);
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 11, 1, 1);
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 9, 2, 1);

  while(level.ref_12b88.ref_13b8a > level.ref_12b88.point_of_no_return) {
    if(level.ref_12b88.ref_13b8a % 2 == 0 && soundexists("iw8_nuke_countdown")) {
      level.ref_12b88.nuke_clockobject playSound("iw8_nuke_countdown");
    }

    var0 = scripts\cp\utility::respawn_flare_wavesv_used_playereffects(level.ref_12b88.ref_13b8a - 1, 1);

    if(isDefined(var0)) {
      level thread scripts\cp\cp_vo::try_to_play_vo_on_team(var0, "allies");
    }

    level.ref_12b88.ref_13b8a -= 1;
    wait 1;
  }

  level.ref_12b88.play_onboard_plane_vo = 1;
  level notify("relic_nuke_explode");
}

function ref_12b90(var0, var1, var2, var3) {
  level endon("nuke_detonated");
  level waittill(var0);
  level notify("relic_nuketimer_end");
  _calloutmarkerping_handleluinotify_acknowledged::ref_11ede();
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 11, 1, 0);

  if(isDefined(var1) && isDefined(var2)) {
    if(!isDefined(var3)) {
      var3 = 60;
    }

    level waittill(var1);

    if(level.ref_12b88.ref_13b8a > var3) {
      thread ref_12b8f();
      thread ref_12b90(level);
      return;
    }

    return;
  }
}

function ref_12b91() {
  level endon("game_ended");
  level endon("relic_nuketimer_end");

  for(;;) {
    level waittill("give_objective_xp_to_all_players", var0);

    if(level.ref_12b88.ref_13b8a > level.ref_12b88.point_of_no_return + 1) {
      if(var0 == "minor_objective") {
        ref_12b89(15);
      } else {
        ref_12b89(30);
      }

      if(istrue(level.ref_12b88.play_onboard_plane_vo)) {
        _calloutmarkerping_handleluinotify_acknowledged::ref_11ede();
        level.ref_12b88.play_onboard_plane_vo = 0;
        waitframe();
        thread ref_12b8f();
      }
    }
  }
}

function ref_12b89(var0) {
  if(level.gameskill < 3) {
    var0 *= 2;
  }

  level.ref_12b88.ref_13b8a += var0;
  setomnvar("ui_nuke_end_milliseconds", gettime() + level.ref_12b88.ref_13b8a * 1000);
}

function ref_12b8a() {
  var0 = 900;
  var1 = tolower(getDvar("mapname"));

  switch (var1) {
    case "cp_scaletest":
      var0 = 80;
      level scripts\engine\utility::delaythread(61, &scripts\cp\cp_objectives::screenent_c, "minor_objective");
      break;
    case "cp_smuggler":
      var2 = getDvar("restart_checkpoint", "");

      if(isDefined(var2) && var2 == "tow_p1") {
        if(level.gameskill < 3) {
          var0 = 300;
        } else {
          var0 = 240;
        }
      } else if(level.gameskill < 3) {
        var0 = 960;
      } else {
        var0 = 720;
      }

      break;
  }

  return var0;
}

function tacinsert_tacinsertdestroyedfeedback(var0) {}

function ref_130c2(var0) {
  level endon("game_ended");
  level endon("relic_hideobjicons_ender");

  for(;;) {
    level scripts\engine\utility::ref_143a5("worldObjIDPool_requested", "objective_minimapUpdate");

    foreach(var2 in level.worldobjidpool.active) {
      objective_state(var2.objid, "active");
    }
  }
}

function ref_13f48(var0) {
  level notify("relic_hideobjicons_ender");
}

function tacinsert_deleteontoofar(var0) {}

function ref_130ba(var0) {
  level.explosivedamagemod = 7;
}

function ref_13f40(var0) {
  level.explosivedamagemod = undefined;
}

function calldropbag() {
  if(scripts\cp\utility::turn_off_sniper_laser() || scripts\cp\utility::tryingtoleave()) {
    return false;
  }

  if(getDvar("scr_set_relics", "") != "") {
    return true;
  }

  return false;
}

function tacinsert_cachespawnposition(var0) {}

function ref_130b7(var0) {
  scripts\cp\cp_modular_spawning::add_global_spawn_function("axis", &ref_130b8);

  foreach(var2 in level.spawned_enemies) {
    ref_130b8(var2);
  }
}

function ref_13f3f(var0) {
  scripts\cp\cp_modular_spawning::remove_global_spawn_function("axis", &ref_130b8);

  foreach(var2 in level.spawned_enemies) {
    if(isDefined(var2)) {
      var2 notify("relic_doubletap_ender");
      var2 notify("relic_doubletap_helper_reset");

      if(istrue(var2.a.doinglongdeath)) {
        var2 scripts\asm\soldier\long_death::longdeathkillme();
        continue;
      }

      var2.forcelongdeath = undefined;
      var2.longdeathnoncombat = undefined;
      var2.invulnerable = 0;
      var2.health = var2.maxhealth;
      var2.skipdyingbackcrawl = undefined;

      if(isDefined(var2.a)) {
        var2.a.force_num_crawls = undefined;
      }
    }
  }
}

function ref_130b8() {
  thread ref_130b9();
}

function ref_130b9() {
  self endon("death");
  self endon("relic_doubletap_ender");

  if(scripts\cp\utility::isjuggernaut()) {
    return;
  }

  if(isDefined(self.unittype) && self.unittype == "suicidebomber") {
    return;
  }

  var0 = self.health;
  wait 0.05;
  var1 = self.weapon;

  if(!isDefined(self.weapon) || !issameweapon(self.weapon)) {
    var2 = self getweaponslistprimaries();

    if(isDefined(var2) && var2.size > 0) {
      var1 = var2[0];
    }
  }

  var3 = 3;

  if(var3 > 0) {
    var4 = var0;
    self.health = var0 + var4;
    var5 = undefined;

    while(var4 > 0) {
      self waittill("damage", var6, var7, var8, var9, var5);

      if(isDefined(var7) && isPlayer(var7)) {
        var4 -= var6;
      }
    }

    if(scripts\cp\cp_modular_spawning::is_riding_vehicle() || istrue(self.playing_skit) || istrue(self.a.disablelongdeath) || istrue(self.attempting_teleport) || istrue(self.clearsoundsubmixmpbrinfilanim) || isDefined(var5) && var5 == "MOD_FIRE" || isDefined(self.script) && (self.script == "scripted" || self.script == "<custom>") || istrue(self._blackboard.animscriptedactive)) {
      self.health = 1;
      return;
    }

    self.invulnerable = 1;
    self.health = 1000;

    if(!isDefined(self.asm.longdeathanims)) {
      self.asm.longdeathanims = spawnStruct();
    }

    GscBinSkip4(0x35);
  }
}

function ref_12b74() {
  self endon("death");
  self endon("relic_doubletap_ender");
  self endon("relic_doubletap_helper_reset");
  self.a.force_num_crawls = 3;
  self.skipdyingbackcrawl = 1;
  self.forcelongdeath = 3;
  self.longdeathnoncombat = 1;

  for(;;) {
    self.asm.longdeathanims.earlyfinishtime = undefined;
    self.desiredtimeofdeath = gettime() + 1000;
    self.bulletsinclip = 0;
    wait 0.05;
  }
}

function ref_13f8f() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    wait 1;
    thread ref_13f90();
  }
}

function ref_13f90() {
  self endon("disconnect");
  self endon("death");
  elevator_silo_lights(self);

  for(;;) {
    self.ref_11fc1 = self.health;
    self.ref_11fc4 = self.maxhealth;
    wait 0.1;

    if(self.health != self.ref_11fc1 || self.maxhealth != self.ref_11fc4) {
      elevator_silo_lights(self);
    }
  }
}

function elevator_silo_lights(var0) {
  var1 = var0 getentitynumber();
  var2 = int(var0.health);
  var3 = var0.maxhealth;

  if(istrue(var0.inlaststand)) {
    var4 = 0;
  }

  scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("EoGPlayer", var1, "tickettotal", var3);
  scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("EoGPlayer", var1, "playerHealth", var2);
}