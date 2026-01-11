/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_audio.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#include maps\_music;
#include maps\_busing;

audio_init() {
  level init_audio_aliases();
  level init_music_states();
  level thread init_audio_functions();
}

init_audio_aliases() {
  level.devil_vox = [];
  level.devil_vox["prefix"] = "zmb_vox_ann_";
  level.devil_vox["powerup"] = [];
  level.devil_vox["powerup"]["carpenter"] = "carpenter";
  level.devil_vox["powerup"]["insta_kill"] = "instakill";
  level.devil_vox["powerup"]["double_points"] = "doublepoints";
  level.devil_vox["powerup"]["nuke"] = "nuke";
  level.devil_vox["powerup"]["full_ammo"] = "maxammo";
  level.devil_vox["powerup"]["fire_sale"] = "firesale";
  level.devil_vox["powerup"]["fire_sale_short"] = "firesale_short";
  level.devil_vox["powerup"]["minigun"] = "death_machine";
  level.devil_vox["powerup"]["bonfire_sale"] = "bonfiresale";
  level.devil_vox["powerup"]["all_revive"] = undefined;
  level.devil_vox["powerup"]["tesla"] = "tesla";
  level.devil_vox["powerup"]["random_weapon"] = "random_weapon";
  level.devil_vox["powerup"]["bonus_points_player"] = "points_positive";
  level.devil_vox["powerup"]["bonus_points_team"] = "points_positive";
  level.devil_vox["powerup"]["lose_points_team"] = "points_negative";
  level.devil_vox["powerup"]["lose_perk"] = "powerup_negative";
  level.devil_vox["powerup"]["empty_clip"] = "powerup_negative";
  level.plr_vox = [];
  level.plr_vox["prefix"] = "vox_plr_";
  level.plr_vox["general"] = [];
  level.plr_vox["general"]["crawl_spawn"] = "spawn_crawl";
  level.plr_vox["general"]["crawl_spawn_response"] = "resp_spawn_crawl";
  level.plr_vox["general"]["dog_spawn"] = "spawn_dog";
  level.plr_vox["general"]["dog_spawn_response"] = undefined;
  level.plr_vox["general"]["quad_spawn"] = "spawn_quad";
  level.plr_vox["general"]["quad_spawn_response"] = undefined;
  level.plr_vox["general"]["ammo_low"] = "ammo_low";
  level.plr_vox["general"]["ammo_low_response"] = undefined;
  level.plr_vox["general"]["ammo_out"] = "ammo_out";
  level.plr_vox["general"]["ammo_out_response"] = undefined;
  level.plr_vox["general"]["door_deny"] = "nomoney";
  level.plr_vox["general"]["door_deny_response"] = undefined;
  level.plr_vox["general"]["perk_deny"] = "nomoney";
  level.plr_vox["general"]["perk_deny_response"] = undefined;
  level.plr_vox["general"]["intro"] = "level_start";
  level.plr_vox["general"]["intro_response"] = undefined;
  level.plr_vox["general"]["shoot_arm"] = "shoot_limb";
  level.plr_vox["general"]["shoot_arm_response"] = undefined;
  level.plr_vox["general"]["box_move"] = "box_move";
  level.plr_vox["general"]["box_move_response"] = undefined;
  level.plr_vox["general"]["no_money"] = "nomoney";
  level.plr_vox["general"]["no_money_response"] = undefined;
  level.plr_vox["general"]["oh_shit"] = "ohshit";
  level.plr_vox["general"]["oh_shit_response"] = "resp_ohshit";
  level.plr_vox["general"]["revive_down"] = "revive_down";
  level.plr_vox["general"]["revive_down_response"] = undefined;
  level.plr_vox["general"]["revive_up"] = "revive_up";
  level.plr_vox["general"]["revive_up_response"] = undefined;
  level.plr_vox["general"]["crawl_hit"] = "crawler_hit";
  level.plr_vox["general"]["crawl_hit_response"] = undefined;
  level.plr_vox["general"]["teleport_gersh"] = "teleport_gersh_device";
  level.plr_vox["general"]["teleport_gersh_response"] = undefined;
  level.plr_vox["general"]["monkey_spawn"] = "monkey_start";
  level.plr_vox["general"]["monkey_spawn_response"] = undefined;
  level.plr_vox["general"]["monkey_hit"] = "space_monkey_hit";
  level.plr_vox["general"]["monkey_hit_response"] = undefined;
  level.plr_vox["general"]["sigh"] = "sigh";
  level.plr_vox["general"]["sigh_response"] = undefined;
  level.plr_vox["general"]["zipline"] = "zipline";
  level.plr_vox["general"]["zipline_response"] = undefined;
  level.plr_vox["general"]["water_damage"] = "damage_water";
  level.plr_vox["general"]["water_damage_response"] = undefined;
  level.plr_vox["general"]["turret_active"] = "turret_active";
  level.plr_vox["general"]["turret_active_response"] = undefined;
  level.plr_vox["general"]["turret_inactive"] = "turret_inactive";
  level.plr_vox["general"]["turret_inactive_response"] = undefined;
  level.plr_vox["general"]["yes"] = "yes";
  level.plr_vox["general"]["yes_response"] = undefined;
  level.plr_vox["general"]["no"] = "no";
  level.plr_vox["general"]["no_response"] = undefined;
  level.plr_vox["general"]["uncertain"] = "uncertain";
  level.plr_vox["general"]["uncertain_response"] = undefined;
  level.plr_vox["general"]["hitmed"] = "gen_hitmed";
  level.plr_vox["general"]["hitmed_response"] = undefined;
  level.plr_vox["general"]["hitlrg"] = "gen_hitlrg";
  level.plr_vox["general"]["hitlrg_response"] = undefined;
  level.plr_vox["catapult"] = [];
  level.plr_vox["catapult"]["zombie"] = "catapult_zmb";
  level.plr_vox["catapult"]["zombie_response"] = undefined;
  level.plr_vox["catapult"]["ally"] = "catapult_ally";
  level.plr_vox["catapult"]["ally_response"] = undefined;
  level.plr_vox["catapult"]["rival"] = "catapult_rival";
  level.plr_vox["catapult"]["rival_response"] = undefined;
  level.plr_vox["catapult"]["self"] = "catapult_self";
  level.plr_vox["catapult"]["self_response"] = undefined;
  level.plr_vox["general"]["weather_good"] = "weather_good";
  level.plr_vox["general"]["weather_good_response"] = undefined;
  level.plr_vox["general"]["weather_bad"] = "weather_bad";
  level.plr_vox["general"]["weather_bad_response"] = undefined;
  level.plr_vox["director"] = [];
  level.plr_vox["director"]["anger"] = "director_anger";
  level.plr_vox["director"]["anger_response"] = undefined;
  level.plr_vox["director"]["weaken"] = "director_weaken";
  level.plr_vox["director"]["weaken_response"] = undefined;
  level.plr_vox["director"]["water"] = "director_water";
  level.plr_vox["director"]["water_response"] = undefined;
  level.plr_vox["director"]["exit"] = "director_exit";
  level.plr_vox["director"]["exit_response"] = undefined;
  level.plr_vox["general"]["round_5"] = "round_5";
  level.plr_vox["general"]["round_5_response"] = undefined;
  level.plr_vox["general"]["round_20"] = "round_20";
  level.plr_vox["general"]["round_20_response"] = undefined;
  level.plr_vox["general"]["round_10"] = "round_10";
  level.plr_vox["general"]["round_10_response"] = undefined;
  level.plr_vox["general"]["round_35"] = "round_35";
  level.plr_vox["general"]["round_35_response"] = undefined;
  level.plr_vox["general"]["round_50"] = "round_50";
  level.plr_vox["general"]["round_50_response"] = undefined;
  level.plr_vox["general"]["water_frozen"] = "damage_frozen";
  level.plr_vox["general"]["water_frozen_response"] = undefined;
  level.plr_vox["general"]["react_sparkers"] = "react_sparkers";
  level.plr_vox["general"]["react_sparkers_response"] = undefined;
  level.plr_vox["general"]["damage_shocked"] = "damage_shocked";
  level.plr_vox["general"]["damage_shocked_response"] = undefined;
  level.plr_vox["general"]["react_sprinters"] = "react_sprinters";
  level.plr_vox["general"]["react_sprinters_response"] = undefined;
  level.plr_vox["general"]["location_maze"] = "location_maze";
  level.plr_vox["general"]["location_maze_response"] = undefined;
  level.plr_vox["general"]["location_waterfall"] = "location_waterfall";
  level.plr_vox["general"]["location_waterfall_response"] = undefined;
  level.plr_vox["general"]["mine_see"] = "mine_see";
  level.plr_vox["general"]["mine_see_response"] = undefined;
  level.plr_vox["general"]["mine_ride"] = "mine_ride";
  level.plr_vox["general"]["mine_ride_response"] = undefined;
  level.plr_vox["general"]["spikes_close"] = "spikes_close";
  level.plr_vox["general"]["spikes_close_response"] = undefined;
  level.plr_vox["general"]["spikes_damage"] = "spikes_dmg";
  level.plr_vox["general"]["spikes_damage_response"] = undefined;
  level.plr_vox["general"]["geyser"] = "geyser";
  level.plr_vox["general"]["geyser_response"] = undefined;
  level.plr_vox["general"]["slide"] = "slide";
  level.plr_vox["general"]["slide_response"] = undefined;
  level.plr_vox["general"]["poweron"] = "power_on";
  level.plr_vox["general"]["poweron_response"] = undefined;
  level.plr_vox["general"]["sonic_spawn"] = "sonic_spawn";
  level.plr_vox["general"]["sonic_spawn_response"] = undefined;
  level.plr_vox["general"]["sonic_hit"] = "sonic_dmg";
  level.plr_vox["general"]["sonic_hit_response"] = undefined;
  level.plr_vox["general"]["napalm_spawn"] = "napalm_spawn";
  level.plr_vox["general"]["napalm_spawn_response"] = undefined;
  level.plr_vox["general"]["thief_steal"] = "thief_steal";
  level.plr_vox["general"]["thief_steal_response"] = undefined;
  level.plr_vox["general"]["start"] = "start";
  level.plr_vox["general"]["start_response"] = undefined;
  level.plr_vox["perk"] = [];
  level.plr_vox["perk"]["specialty_armorvest"] = "perk_jugga";
  level.plr_vox["perk"]["specialty_armorvest_response"] = undefined;
  level.plr_vox["perk"]["specialty_quickrevive"] = "perk_revive";
  level.plr_vox["perk"]["specialty_quickrevive_response"] = undefined;
  level.plr_vox["perk"]["specialty_fastreload"] = "perk_speed";
  level.plr_vox["perk"]["specialty_fastreload_response"] = undefined;
  level.plr_vox["perk"]["specialty_rof"] = "perk_doubletap";
  level.plr_vox["perk"]["specialty_rof_response"] = undefined;
  level.plr_vox["perk"]["specialty_longersprint"] = "perk_stamin";
  level.plr_vox["perk"]["specialty_longersprint_response"] = undefined;
  level.plr_vox["perk"]["specialty_flakjacket"] = "perk_phdflopper";
  level.plr_vox["perk"]["specialty_flakjacket_response"] = undefined;
  level.plr_vox["perk"]["specialty_deadshot"] = "perk_deadshot";
  level.plr_vox["perk"]["specialty_deadshot_response"] = undefined;
  level.plr_vox["perk"]["steal_specialty_armorvest"] = "perk_steal_jugga";
  level.plr_vox["perk"]["steal_specialty_armorvest_response"] = undefined;
  level.plr_vox["perk"]["steal_specialty_quickrevive"] = "perk_steal_revive";
  level.plr_vox["perk"]["steal_specialty_quickrevive_response"] = undefined;
  level.plr_vox["perk"]["steal_specialty_fastreload"] = "perk_steal_speed";
  level.plr_vox["perk"]["steal_specialty_fastreload_response"] = undefined;
  level.plr_vox["perk"]["steal_specialty_longersprint"] = "perk_steal_stamin";
  level.plr_vox["perk"]["steal_specialty_longersprint_response"] = undefined;
  level.plr_vox["perk"]["steal_specialty_flakjacket"] = "perk_steal_prone";
  level.plr_vox["perk"]["steal_specialty_flakjacket_response"] = undefined;
  level.plr_vox["powerup"] = [];
  level.plr_vox["powerup"]["nuke"] = "powerup_nuke";
  level.plr_vox["powerup"]["nuke_response"] = undefined;
  level.plr_vox["powerup"]["insta_kill"] = "powerup_insta";
  level.plr_vox["powerup"]["insta_kill_response"] = undefined;
  level.plr_vox["powerup"]["full_ammo"] = "powerup_ammo";
  level.plr_vox["powerup"]["full_ammo_response"] = undefined;
  level.plr_vox["powerup"]["double_points"] = "powerup_double";
  level.plr_vox["powerup"]["double_points_response"] = undefined;
  level.plr_vox["powerup"]["carpenter"] = "powerup_carp";
  level.plr_vox["powerup"]["carpenter_response"] = undefined;
  level.plr_vox["powerup"]["firesale"] = "powerup_firesale";
  level.plr_vox["powerup"]["firesale_response"] = undefined;
  level.plr_vox["powerup"]["minigun"] = "powerup_minigun";
  level.plr_vox["powerup"]["minigun_response"] = undefined;
  level.plr_vox["kill"] = [];
  level.plr_vox["kill"]["melee"] = "kill_melee";
  level.plr_vox["kill"]["melee_response"] = undefined;
  level.plr_vox["kill"]["melee_instakill"] = "kill_insta";
  level.plr_vox["kill"]["melee_instakill_response"] = undefined;
  level.plr_vox["kill"]["weapon_instakill"] = "kill_insta";
  level.plr_vox["kill"]["weapon_instakill_response"] = undefined;
  level.plr_vox["kill"]["closekill"] = "kill_close";
  level.plr_vox["kill"]["closekill_response"] = undefined;
  level.plr_vox["kill"]["damage"] = "kill_damaged";
  level.plr_vox["kill"]["damage_response"] = undefined;
  level.plr_vox["kill"]["streak"] = "kill_streak";
  level.plr_vox["kill"]["streak_response"] = undefined;
  level.plr_vox["kill"]["headshot"] = "kill_headshot";
  level.plr_vox["kill"]["headshot_response"] = "resp_kill_headshot";
  level.plr_vox["kill"]["explosive"] = "kill_explo";
  level.plr_vox["kill"]["explosive_response"] = undefined;
  level.plr_vox["kill"]["flame"] = "kill_flame";
  level.plr_vox["kill"]["flame_response"] = undefined;
  level.plr_vox["kill"]["raygun"] = "kill_ray";
  level.plr_vox["kill"]["raygun_response"] = undefined;
  level.plr_vox["kill"]["bullet"] = "kill_streak";
  level.plr_vox["kill"]["bullet_response"] = undefined;
  level.plr_vox["kill"]["tesla"] = "kill_tesla";
  level.plr_vox["kill"]["tesla_response"] = undefined;
  level.plr_vox["kill"]["monkey"] = "kill_monkey";
  level.plr_vox["kill"]["monkey_response"] = undefined;
  level.plr_vox["kill"]["thundergun"] = "kill_thunder";
  level.plr_vox["kill"]["thundergun_response"] = undefined;
  level.plr_vox["kill"]["freeze"] = "kill_freeze";
  level.plr_vox["kill"]["freeze_response"] = undefined;
  level.plr_vox["kill"]["crawler"] = "kill_crawler";
  level.plr_vox["kill"]["crawler_response"] = undefined;
  level.plr_vox["kill"]["hellhound"] = "kill_hellhound";
  level.plr_vox["kill"]["hellhound_response"] = undefined;
  level.plr_vox["kill"]["quad"] = "kill_quad";
  level.plr_vox["kill"]["quad_response"] = undefined;
  level.plr_vox["kill"]["space_monkey"] = "kill_space_monkey";
  level.plr_vox["kill"]["space_monkey_response"] = undefined;
  level.plr_vox["kill"]["gersh_device"] = "kill_gersh_device";
  level.plr_vox["kill"]["gersh_device_response"] = undefined;
  level.plr_vox["kill"]["sickle"] = "kill_sickle";
  level.plr_vox["kill"]["sickle_response"] = undefined;
  level.plr_vox["kill"]["human"] = "kill_human";
  level.plr_vox["kill"]["human_response"] = undefined;
  level.plr_vox["kill"]["ubersniper"] = "kill_ubersniper";
  level.plr_vox["kill"]["ubersniper_response"] = undefined;
  level.plr_vox["kill"]["dolls"] = "kill_dolls";
  level.plr_vox["kill"]["dolls_response"] = undefined;
  level.plr_vox["kill"]["claymore"] = "kill_claymore";
  level.plr_vox["kill"]["claymore_response"] = undefined;
  level.plr_vox["kill"]["sonic"] = "sonic_kill";
  level.plr_vox["kill"]["sonic_response"] = undefined;
  level.plr_vox["kill"]["napalm"] = "napalm_kill";
  level.plr_vox["kill"]["napalm_response"] = undefined;
  level.plr_vox["kill"]["shrink"] = "kill_shrink";
  level.plr_vox["kill"]["shrink_response"] = undefined;
  level.plr_vox["kill"]["shrunken"] = "kill_shrunken";
  level.plr_vox["kill"]["shrunken_response"] = undefined;
  level.plr_vox["kill"]["spikemore"] = "kill_spikemore";
  level.plr_vox["kill"]["spikemore_response"] = undefined;
  level.plr_vox["kill"]["thief"] = "kill_thief";
  level.plr_vox["kill"]["thief_response"] = undefined;
  level.plr_vox["weapon_pickup"] = [];
  level.plr_vox["weapon_pickup"]["pistol"] = "wpck_crappy";
  level.plr_vox["weapon_pickup"]["pistol_response"] = undefined;
  level.plr_vox["weapon_pickup"]["smg"] = "wpck_smg";
  level.plr_vox["weapon_pickup"]["smg_response"] = undefined;
  level.plr_vox["weapon_pickup"]["dualwield"] = "wpck_dual";
  level.plr_vox["weapon_pickup"]["dualwield_response"] = undefined;
  level.plr_vox["weapon_pickup"]["shotgun"] = "wpck_shotgun";
  level.plr_vox["weapon_pickup"]["shotgun_response"] = undefined;
  level.plr_vox["weapon_pickup"]["rifle"] = "wpck_sniper";
  level.plr_vox["weapon_pickup"]["rifle_response"] = undefined;
  level.plr_vox["weapon_pickup"]["burstrifle"] = "wpck_mg";
  level.plr_vox["weapon_pickup"]["burstrifle_response"] = undefined;
  level.plr_vox["weapon_pickup"]["assault"] = "wpck_mg";
  level.plr_vox["weapon_pickup"]["assault_response"] = undefined;
  level.plr_vox["weapon_pickup"]["sniper"] = "wpck_sniper";
  level.plr_vox["weapon_pickup"]["sniper_response"] = undefined;
  level.plr_vox["weapon_pickup"]["mg"] = "wpck_mg";
  level.plr_vox["weapon_pickup"]["mg_response"] = undefined;
  level.plr_vox["weapon_pickup"]["launcher"] = "wpck_launcher";
  level.plr_vox["weapon_pickup"]["launcher_response"] = undefined;
  level.plr_vox["weapon_pickup"]["grenade"] = "wpck_grenade";
  level.plr_vox["weapon_pickup"]["grenade_response"] = undefined;
  level.plr_vox["weapon_pickup"]["bowie"] = "wpck_bowie";
  level.plr_vox["weapon_pickup"]["bowie_response"] = undefined;
  level.plr_vox["weapon_pickup"]["sickle"] = "wpck_sickle";
  level.plr_vox["weapon_pickup"]["sickle_response"] = undefined;
  level.plr_vox["weapon_pickup"]["raygun"] = "wpck_raygun";
  level.plr_vox["weapon_pickup"]["raygun_response"] = undefined;
  level.plr_vox["weapon_pickup"]["monkey"] = "wpck_monkey";
  level.plr_vox["weapon_pickup"]["monkey_response"] = "resp_wpck_monkey";
  level.plr_vox["weapon_pickup"]["tesla"] = "wpck_tesla";
  level.plr_vox["weapon_pickup"]["tesla_response"] = undefined;
  level.plr_vox["weapon_pickup"]["thunder"] = "wpck_thunder";
  level.plr_vox["weapon_pickup"]["thunder_response"] = undefined;
  level.plr_vox["weapon_pickup"]["freezegun"] = "wpck_freeze";
  level.plr_vox["weapon_pickup"]["freezegun_response"] = undefined;
  level.plr_vox["weapon_pickup"]["crossbow"] = "wpck_launcher";
  level.plr_vox["weapon_pickup"]["crossbow_response"] = undefined;
  level.plr_vox["weapon_pickup"]["upgrade"] = "wpck_upgrade";
  level.plr_vox["weapon_pickup"]["upgrade_response"] = undefined;
  level.plr_vox["weapon_pickup"]["upgrade_wait"] = "wpck_upgrade_wait";
  level.plr_vox["weapon_pickup"]["upgrade_wait_response"] = undefined;
  level.plr_vox["weapon_pickup"]["favorite"] = "wpck_favorite";
  level.plr_vox["weapon_pickup"]["favorite_response"] = undefined;
  level.plr_vox["weapon_pickup"]["favorite_upgrade"] = "wpck_favorite_upgrade";
  level.plr_vox["weapon_pickup"]["favorite_upgrade_response"] = undefined;
  level.plr_vox["weapon_pickup"]["sickle"] = "wpck_sickle";
  level.plr_vox["weapon_pickup"]["sickle_response"] = undefined;
  level.plr_vox["weapon_pickup"]["dolls"] = "wpck_dolls";
  level.plr_vox["weapon_pickup"]["dolls_response"] = undefined;
  level.plr_vox["weapon_pickup"]["gersh"] = "wpck_gersh_device";
  level.plr_vox["weapon_pickup"]["gersh_response"] = undefined;
  level.plr_vox["weapon_pickup"]["human"] = "wpck_human";
  level.plr_vox["weapon_pickup"]["human_response"] = undefined;
  level.plr_vox["weapon_pickup"]["ubersniper"] = "wpck_ubersniper";
  level.plr_vox["weapon_pickup"]["ubersniper_response"] = undefined;
  level.plr_vox["weapon_pickup"]["shrink"] = "wpck_shrink";
  level.plr_vox["weapon_pickup"]["shrink_response"] = undefined;
  level.plr_vox["weapon_pickup"]["spikemore"] = "wpck_spikemore";
  level.plr_vox["weapon_pickup"]["spikemore_response"] = undefined;
  level.plr_vox["eggs"] = [];
  level.plr_vox["eggs"]["achievement"] = "achievement";
  level.plr_vox["eggs"]["music_activate"] = "secret";
  level.plr_vox["eggs"]["meteors"] = "egg_pedastool";
  level.plr_vox["eggs"]["room_screen"] = "egg_room_screen";
  level.plr_vox["eggs"]["room_dress"] = "egg_room_dress";
  level.plr_vox["eggs"]["room_lounge"] = "egg_room_lounge";
  level.plr_vox["eggs"]["room_rest"] = "egg_room_rest";
  level.plr_vox["eggs"]["room_alley"] = "egg_room_alley";
  level.plr_vox["eggs"]["portrait_dempsey"] = "egg_port_dempsey";
  level.plr_vox["eggs"]["portrait_nikolai"] = "egg_port_nikolai";
  level.plr_vox["eggs"]["portrait_takeo"] = "egg_port_takeo";
  level.plr_vox["eggs"]["portrait_richtofan"] = "egg_port_richtofan";
  level.plr_vox["eggs"]["portrait_empty"] = "egg_port_empty";
  level.plr_vox["eggs"]["gersh_response"] = "cosmo_egg";
  level.plr_vox["eggs"]["coast_response"] = "egg_response";
  level.plr_vox["eggs"]["dolls"] = "egg_dolls";
  level.plr_vox["eggs"]["quest1"] = "quest_step1";
  level.plr_vox["eggs"]["quest2"] = "quest_step2";
  level.plr_vox["eggs"]["quest3"] = "quest_step3";
  level.plr_vox["eggs"]["quest4"] = "quest_step4";
  level.plr_vox["eggs"]["quest5"] = "quest_step5";
  level.plr_vox["eggs"]["quest6"] = "quest_step6";
  level.plr_vox["eggs"]["quest7"] = "quest_step7";
  level.plr_vox["eggs"]["quest8"] = "quest_step8";
  level.plr_vox["eggs"]["rod"] = "rod";
  level.zmb_vox = [];
  level.zmb_vox["prefix"] = "zmb_vocals_";
  level.zmb_vox["zombie"] = [];
  level.zmb_vox["zombie"]["ambient"] = "zombie_ambience";
  level.zmb_vox["zombie"]["sprint"] = "zombie_sprint";
  level.zmb_vox["zombie"]["attack"] = "zombie_attack";
  level.zmb_vox["zombie"]["teardown"] = "zombie_teardown";
  level.zmb_vox["zombie"]["taunt"] = "zombie_taunt";
  level.zmb_vox["zombie"]["behind"] = "zombie_behind";
  level.zmb_vox["zombie"]["death"] = "zombie_death";
  level.zmb_vox["zombie"]["crawler"] = "zombie_crawler";
  level.zmb_vox["quad_zombie"] = [];
  level.zmb_vox["quad_zombie"]["ambient"] = "quad_ambience";
  level.zmb_vox["quad_zombie"]["sprint"] = "quad_sprint";
  level.zmb_vox["quad_zombie"]["attack"] = "quad_attack";
  level.zmb_vox["quad_zombie"]["behind"] = "quad_behind";
  level.zmb_vox["quad_zombie"]["death"] = "quad_death";
  level.zmb_vox["thief_zombie"] = [];
  level.zmb_vox["thief_zombie"]["ambient"] = "thief_ambience";
  level.zmb_vox["thief_zombie"]["sprint"] = "thief_sprint";
  level.zmb_vox["thief_zombie"]["steal"] = "thief_steal";
  level.zmb_vox["thief_zombie"]["death"] = "thief_death";
  level.zmb_vox["thief_zombie"]["anger"] = "thief_anger";
  level.zmb_vox["boss_zombie"] = [];
  level.zmb_vox["boss_zombie"]["ambient"] = "boss_ambience";
  level.zmb_vox["boss_zombie"]["sprint"] = "boss_sprint";
  level.zmb_vox["boss_zombie"]["attack"] = "boss_attack";
  level.zmb_vox["boss_zombie"]["behind"] = "boss_behind";
  level.zmb_vox["boss_zombie"]["death"] = "boss_death";
  level.zmb_vox["monkey_zombie"] = [];
  level.zmb_vox["monkey_zombie"]["ambient"] = "monkey_ambience";
  level.zmb_vox["monkey_zombie"]["sprint"] = "monkey_sprint";
  level.zmb_vox["monkey_zombie"]["attack"] = "monkey_attack";
  level.zmb_vox["monkey_zombie"]["behind"] = "monkey_behind";
  level.zmb_vox["monkey_zombie"]["death"] = "monkey_death";
  if(isDefined(level._audio_alias_override)) {
    level thread[[level._audio_alias_override]]();
  }
}

init_audio_functions() {
  flag_wait("all_players_connected");
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] thread zombie_behind_vox();
    players[i] thread player_killstreak_timer();
    players[i] thread oh_shit_vox();
  }
}

zombie_behind_vox() {
  self endon("disconnect");
  self endon("death");
  if(!isDefined(level._zbv_vox_last_update_time)) {
    level._zbv_vox_last_update_time = 0;
    level._audio_zbv_shared_ent_list = GetAISpeciesArray("axis");
  }
  while(1) {
    wait(1);
    t = GetTime();
    if(t > level._zbv_vox_last_update_time + 1000) {
      level._zbv_vox_last_update_time = t;
      level._audio_zbv_shared_ent_list = GetAISpeciesArray("axis");
    }
    zombs = level._audio_zbv_shared_ent_list;
    played_sound = false;
    for(i = 0; i < zombs.size; i++) {
      if(!isDefined(zombs[i])) {
        continue;
      }
      if(zombs[i].isdog) {
        continue;
      }
      dist = 200;
      z_dist = 50;
      alias = level.vox_behind_zombie;
      if(isDefined(zombs[i].zombie_move_speed)) {
        switch (zombs[i].zombie_move_speed) {
          case "walk":
            dist = 200;
            break;
          case "run":
            dist = 250;
            break;
          case "sprint":
            dist = 275;
            break;
        }
      }
      if(distanceSquared(zombs[i].origin, self.origin) < dist * dist) {
        yaw = self animscripts\utility::GetYawToSpot(zombs[i].origin);
        z_diff = self.origin[2] - zombs[i].origin[2];
        if((yaw < -95 || yaw > 95) && abs(z_diff) < 50) {
          zombs[i] thread maps\_zombiemode_audio::do_zombies_playvocals("behind", zombs[i].animname);
          played_sound = true;
          break;
        }
      }
    }
    if(played_sound) {
      wait(5);
    }
  }
}

attack_vox_network_choke() {
  while(1) {
    level._num_attack_vox = 0;
    wait_network_frame();
  }
}

do_zombies_playvocals(alias_type, zombie_type) {
  self endon("death");
  if(!isDefined(zombie_type)) {
    zombie_type = "zombie";
  }
  if(is_true(self.shrinked)) {
    return;
  }
  if(!isDefined(self.talking)) {
    self.talking = false;
  }
  if(!isDefined(level.zmb_vox[zombie_type])) {
    return;
  }
  if(!isDefined(level.zmb_vox[zombie_type][alias_type])) {
    return;
  }
  if(alias_type == "attack") {
    if(!isDefined(level._num_attack_vox)) {
      level thread attack_vox_network_choke();
    }
    if(level._num_attack_vox > 4) {
      return;
    }
    level._num_attack_vox++;
  }
  alias = level.zmb_vox["prefix"] + level.zmb_vox[zombie_type][alias_type];
  if(alias_type == "attack" || alias_type == "behind" || alias_type == "death" || alias_type == "anger" || alias_type == "steal") {
    self playSound(alias);
  } else if(!self.talking) {
    self.talking = true;
    self playSound(alias, "sounddone");
    self waittill("sounddone");
    self.talking = false;
  }
}

oh_shit_vox() {
  self endon("disconnect");
  self endon("death");
  while(1) {
    wait(1);
    players = getplayers();
    zombs = GetAISpeciesArray("axis");
    if(players.size > 1) {
      close_zombs = 0;
      for(i = 0; i < zombs.size; i++) {
        if(distanceSquared(zombs[i].origin, self.origin) < 250 * 250) {
          close_zombs++;
        }
      }
      if(close_zombs > 4) {
        if(randomintrange(0, 20) < 5) {
          self create_and_play_dialog("general", "oh_shit");
          wait(4);
        }
      }
    }
  }
}

create_and_play_dialog(category, type, response, force_variant, override) {
  waittime = .25;
  if(!isDefined(level.plr_vox[category][type])) {
    return;
  }
  if(self maps\_laststand::player_is_in_laststand() && (type != "revive_down" || type != "revive_up")) {
    return;
  }
  alias_suffix = level.plr_vox[category][type];
  if(isDefined(response)) {
    alias_suffix = response + alias_suffix;
  }
  index = maps\_zombiemode_weapons::get_player_index(self);
  if(is_true(level.player_4_vox_override) && index == 3) {
    index = 4;
  }
  prefix = level.plr_vox["prefix"] + index + "_";
  if(!isDefined(self.sound_dialog)) {
    self.sound_dialog = [];
    self.sound_dialog_available = [];
  }
  if(!isDefined(self.sound_dialog[alias_suffix])) {
    num_variants = maps\_zombiemode_spawner::get_number_variants(prefix + alias_suffix);
    if(num_variants <= 0) {
      return;
    }
    for(i = 0; i < num_variants; i++) {
      self.sound_dialog[alias_suffix][i] = i;
    }
    self.sound_dialog_available[alias_suffix] = [];
  }
  if(self.sound_dialog_available[alias_suffix].size <= 0) {
    self.sound_dialog_available[alias_suffix] = self.sound_dialog[alias_suffix];
  }
  variation = random(self.sound_dialog_available[alias_suffix]);
  self.sound_dialog_available[alias_suffix] = array_remove(self.sound_dialog_available[alias_suffix], variation);
  if(isDefined(force_variant)) {
    variation = force_variant;
  }
  if(!isDefined(override)) {
    override = false;
  }
  sound_to_play = alias_suffix + "_" + variation;
  if(isDefined(level._audio_custom_player_playvox)) {
    self thread[[level._audio_custom_player_playvox]](prefix, index, sound_to_play, waittime, category, type, override);
  } else {
    self thread do_player_playvox(prefix, index, sound_to_play, waittime, category, type, override);
  }
}

do_player_playvox(prefix, index, sound_to_play, waittime, category, type, override) {
  players = getplayers();
  if(!isDefined(level.player_is_speaking)) {
    level.player_is_speaking = 0;
  }
  if(is_true(level.skit_vox_override) && !override) {
    return;
  }
  if(level.player_is_speaking != 1) {
    level.player_is_speaking = 1;
    self playSound(prefix + sound_to_play, "sound_done" + sound_to_play);
    self waittill("sound_done" + sound_to_play);
    wait(waittime);
    level.player_is_speaking = 0;
    if(!flag("solo_game") && (isDefined(level.plr_vox[category][type + "_response"]))) {
      if(isDefined(level._audio_custom_response_line)) {
        level thread[[level._audio_custom_response_line]](self, index, category, type);
      } else {
        level thread setup_response_line(self, index, category, type);
      }
    }
  }
}

setup_response_line(player, index, category, type) {
  Dempsey = 0;
  Nikolai = 1;
  Takeo = 2;
  Richtofen = 3;
  switch (player.entity_num) {
    case 0:
      level setup_hero_rival(player, Nikolai, Richtofen, category, type);
      break;
    case 1:
      level setup_hero_rival(player, Richtofen, Takeo, category, type);
      break;
    case 2:
      level setup_hero_rival(player, Dempsey, Nikolai, category, type);
      break;
    case 3:
      level setup_hero_rival(player, Takeo, Dempsey, category, type);
      break;
  }
  return;
}

setup_hero_rival(player, hero, rival, category, type) {
  players = getplayers();
  playHero = false;
  playRival = false;
  hero_player = undefined;
  rival_player = undefined;
  for(i = 0; i < players.size; i++) {
    if(players[i].entity_num == hero) {
      playHero = true;
      hero_player = players[i];
    }
    if(players[i].entity_num == rival) {
      playRival = true;
      rival_player = players[i];
    }
  }
  if(playHero && playRival) {
    if(randomfloatrange(0, 1) < .5) {
      playRival = false;
    } else {
      playHero = false;
    }
  }
  if(playHero && isDefined(hero_player)) {
    if(distancesquared(player.origin, hero_player.origin) < 500 * 500) {
      hero_player create_and_play_dialog(category, type + "_response", "hr_");
    } else if(isDefined(rival_player)) {
      playRival = true;
    }
  }
  if(playRival && isDefined(rival_player)) {
    if(distancesquared(player.origin, rival_player.origin) < 500 * 500) {
      rival_player create_and_play_dialog(category, type + "_response", "riv_");
    }
  }
}

do_announcer_playvox(category) {
  if(!isDefined(category)) {
    return;
  }
  if(!isDefined(level.devil_is_speaking)) {
    level.devil_is_speaking = 0;
  }
  alias = level.devil_vox["prefix"] + category;
  if(level.devil_is_speaking == 0) {
    level.devil_is_speaking = 1;
    level play_sound_2D(alias);
    wait 2.0;
    level.devil_is_speaking = 0;
  }
}

player_killstreak_timer() {
  self endon("disconnect");
  self endon("death");
  if(getDvar("zombie_kills") == "") {
    setdvar("zombie_kills", "7");
  }
  if(getDvar("zombie_kill_timer") == "") {
    setdvar("zombie_kill_timer", "5");
  }
  kills = GetDvarInt(#"zombie_kills");
  time = GetDvarInt(#"zombie_kill_timer");
  if(!isDefined(self.timerIsrunning)) {
    self.timerIsrunning = 0;
  }
  while(1) {
    self waittill("zom_kill", zomb);
    if(isDefined(zomb._black_hole_bomb_collapse_death) && zomb._black_hole_bomb_collapse_death == 1) {
      continue;
    }
    if(is_true(zomb.microwavegun_death)) {
      continue;
    }
    self.killcounter++;
    if(self.timerIsrunning != 1) {
      self.timerIsrunning = 1;
      self thread timer_actual(kills, time);
    }
  }
}

player_zombie_kill_vox(hit_location, player, mod, zombie) {
  weapon = player GetCurrentWeapon();
  dist = distanceSquared(player.origin, zombie.origin);
  if(!isDefined(level.zombie_vars["zombie_insta_kill"])) {
    level.zombie_vars["zombie_insta_kill"] = 0;
  }
  instakill = level.zombie_vars["zombie_insta_kill"];
  death = get_mod_type(hit_location, mod, weapon, zombie, instakill, dist, player);
  chance = get_mod_chance(death);
  if(!isDefined(player.force_wait_on_kill_line)) {
    player.force_wait_on_kill_line = false;
  }
  if((chance > RandomIntRange(1, 100)) && player.force_wait_on_kill_line == false) {
    player.force_wait_on_kill_line = true;
    player create_and_play_dialog("kill", death);
    wait(2);
    player.force_wait_on_kill_line = false;
  }
}

get_mod_chance(meansofdeath) {
  chance = undefined;
  switch (meansofdeath) {
    case "sickle":
      chance = 40;
      break;
    case "melee":
      chance = 40;
      break;
    case "melee_instakill":
      chance = 99;
      break;
    case "weapon_instakill":
      chance = 10;
      break;
    case "explosive":
      chance = 60;
      break;
    case "flame":
      chance = 60;
      break;
    case "raygun":
      chance = 75;
      break;
    case "headshot":
      chance = 99;
      break;
    case "crawler":
      chance = 30;
      break;
    case "quad":
      chance = 30;
      break;
    case "astro":
      chance = 99;
      break;
    case "closekill":
      chance = 15;
      break;
    case "bullet":
      chance = 10;
      break;
    case "claymore":
      chance = 99;
      break;
    case "dolls":
      chance = 99;
      break;
    case "default":
      chance = 1;
      break;
  }
  return chance;
}

get_mod_type(impact, mod, weapon, zombie, instakill, dist, player) {
  close_dist = 64 * 64;
  far_dist = 400 * 400;
  if(isDefined(zombie._black_hole_bomb_collapse_death) && zombie._black_hole_bomb_collapse_death == 1) {
    return "default";
  }
  if(is_placeable_mine(weapon)) {
    if(!instakill) {
      return "claymore";
    }
    else {
      return "weapon_instakill";
    }
  }
  if((mod == "MOD_MELEE" ||
      mod == "MOD_BAYONET" ||
      mod == "MOD_UNKNOWN") &&
    dist < close_dist) {
    if(!instakill) {
      if(player hasWeapon("sickle_knife_zm")) {
        return "sickle";
      }
      else {
        return "melee";
      }
    } else
      return "melee_instakill";
  }
  if(isDefined(zombie.damageweapon) && zombie.damageweapon == "zombie_nesting_doll_single") {
    if(!instakill) {
      return "dolls";
    }
    else {
      return "weapon_instakill";
    }
  }
  if((mod == "MOD_GRENADE" ||
      mod == "MOD_GRENADE_SPLASH" ||
      mod == "MOD_PROJECTILE_SPLASH" ||
      mod == "MOD_EXPLOSIVE") &&
    weapon != "ray_gun_zm") {
    if(!instakill) {
      return "explosive";
    }
    else {
      return "weapon_instakill";
    }
  }
  if((IsSubStr(weapon, "flame") ||
      IsSubStr(weapon, "molotov_") ||
      IsSubStr(weapon, "napalmblob_")) &&
    (mod == "MOD_BURNED" ||
      mod == "MOD_GRENADE" ||
      mod == "MOD_GRENADE_SPLASH")) {
    if(!instakill) {
      return "flame";
    }
    else {
      return "weapon_instakill";
    }
  }
  if(weapon == "ray_gun_zm" &&
    dist > far_dist) {
    if(!instakill) {
      return "raygun";
    }
    else {
      return "weapon_instakill";
    }
  }
  if((mod == "MOD_RIFLE_BULLET" ||
      mod == "MOD_PISTOL_BULLET") &&
    (impact == "head" &&
      dist > far_dist &&
      !instakill)) {
    return "headshot";
  }
  if(mod != "MOD_MELEE" &&
    impact != "head" &&
    zombie.animname == "quad_zombie" &&
    !instakill) {
    return "quad";
  }
  if(mod != "MOD_MELEE" &&
    impact != "head" &&
    zombie.animname == "astro_zombie" &&
    !instakill) {
    return "astro";
  }
  if(mod != "MOD_MELEE" &&
    impact != "head" &&
    !zombie.has_legs &&
    !instakill) {
    return "crawler";
  }
  if(mod != "MOD_BURNED" &&
    dist < close_dist &&
    !instakill) {
    return "closekill";
  }
  if(mod == "MOD_RIFLE_BULLET" ||
    mod == "MOD_PISTOL_BULLET") {
    if(!instakill) {
      return "bullet";
    }
    else {
      return "weapon_instakill";
    }
  }
  return "default";
}

timer_actual(kills, time) {
  self endon("disconnect");
  self endon("death");
  timer = gettime() + (time * 1000);
  while(getTime() < timer) {
    if(self.killcounter > kills) {
      self create_and_play_dialog("kill", "streak");
      wait(1);
      self.killcounter = 0;
      timer = -1;
    }
    wait(0.1);
  }
  self.killcounter = 0;
  self.timerIsrunning = 0;
}

perks_a_cola_jingle_timer() {
  self endon("death");
  self thread play_random_broken_sounds();
  while(1) {
    wait(randomfloatrange(31, 45));
    if(randomInt(100) < 15) {
      self thread play_jingle_or_stinger(self.script_sound);
    }
  }
}

play_jingle_or_stinger(perksacola) {
  playsoundatposition("evt_electrical_surge", self.origin);
  if(!isDefined(self.jingle_is_playing)) {
    self.jingle_is_playing = 0;
  }
  if(isDefined(perksacola)) {
    if(self.jingle_is_playing == 0 && level.music_override == false) {
      self.jingle_is_playing = 1;
      self playSound(perksacola, "sound_done");
      self waittill("sound_done");
      self.jingle_is_playing = 0;
    }
  }
}

play_random_broken_sounds() {
  self endon("death");
  level endon("jingle_playing");
  if(!isDefined(self.script_sound)) {
    self.script_sound = "null";
  }
  if(self.script_sound == "mus_perks_revive_jingle") {
    while(1) {
      wait(randomfloatrange(7, 18));
      playsoundatposition("zmb_perks_broken_jingle", self.origin);
      playsoundatposition("evt_electrical_surge", self.origin);
    }
  } else {
    while(1) {
      wait(randomfloatrange(7, 18));
      playsoundatposition("evt_electrical_surge", self.origin);
    }
  }
}

perk_vox(perk) {
  self endon("death");
  self endon("disconnect");
  wait(1.5);
  if(!isDefined(level.plr_vox["perk"][perk])) {
    return;
  }
  self create_and_play_dialog("perk", perk);
}

dialog_debugger(category, type) {}
init_music_states() {
  level.music_override = false;
  level.music_round_override = false;
  level.old_music_state = undefined;
  level.zmb_music_states = [];
  level.zmb_music_states["round_start"] = spawnStruct();
  level.zmb_music_states["round_start"].music = "mus_zombie_round_start";
  level.zmb_music_states["round_start"].is_alias = true;
  level.zmb_music_states["round_start"].override = true;
  level.zmb_music_states["round_start"].round_override = true;
  level.zmb_music_states["round_start"].musicstate = "WAVE";
  level.zmb_music_states["round_end"] = spawnStruct();
  level.zmb_music_states["round_end"].music = "mus_zombie_round_over";
  level.zmb_music_states["round_end"].is_alias = true;
  level.zmb_music_states["round_end"].override = true;
  level.zmb_music_states["round_end"].round_override = true;
  level.zmb_music_states["round_end"].musicstate = "SILENCE";
  level.zmb_music_states["wave_loop"] = spawnStruct();
  level.zmb_music_states["wave_loop"].music = "WAVE";
  level.zmb_music_states["wave_loop"].is_alias = false;
  level.zmb_music_states["wave_loop"].override = true;
  level.zmb_music_states["game_over"] = spawnStruct();
  level.zmb_music_states["game_over"].music = "mus_zombie_game_over";
  level.zmb_music_states["game_over"].is_alias = true;
  level.zmb_music_states["game_over"].override = false;
  level.zmb_music_states["game_over"].musicstate = "SILENCE";
  level.zmb_music_states["dog_start"] = spawnStruct();
  level.zmb_music_states["dog_start"].music = "mus_zombie_dog_start";
  level.zmb_music_states["dog_start"].is_alias = true;
  level.zmb_music_states["dog_start"].override = true;
  level.zmb_music_states["dog_end"] = spawnStruct();
  level.zmb_music_states["dog_end"].music = "mus_zombie_dog_end";
  level.zmb_music_states["dog_end"].is_alias = true;
  level.zmb_music_states["dog_end"].override = true;
  level.zmb_music_states["egg"] = spawnStruct();
  level.zmb_music_states["egg"].music = "EGG";
  level.zmb_music_states["egg"].is_alias = false;
  level.zmb_music_states["egg"].override = false;
  level.zmb_music_states["egg_safe"] = spawnStruct();
  level.zmb_music_states["egg_safe"].music = "EGG_SAFE";
  level.zmb_music_states["egg_safe"].is_alias = false;
  level.zmb_music_states["egg_safe"].override = false;
  level.zmb_music_states["egg_a7x"] = spawnStruct();
  level.zmb_music_states["egg_a7x"].music = "EGG_A7X";
  level.zmb_music_states["egg_a7x"].is_alias = false;
  level.zmb_music_states["egg_a7x"].override = false;
  level.zmb_music_states["sam_reveal"] = spawnStruct();
  level.zmb_music_states["sam_reveal"].music = "SAM";
  level.zmb_music_states["sam_reveal"].is_alias = false;
  level.zmb_music_states["sam_reveal"].override = false;
}

change_zombie_music(state) {
  wait(.05);
  m = level.zmb_music_states[state];
  if(!isDefined(m)) {
    return;
  }
  do_logic = true;
  if(!isDefined(level.old_music_state)) {
    do_logic = false;
  }
  if(do_logic) {
    if(level.old_music_state == m) {
      return;
    } else if(level.old_music_state.music == "mus_zombie_game_over") {
      return;
    }
  }
  if(!isDefined(m.round_override)) {
    m.round_override = false;
  }
  if(m.override == true && level.music_override == true) {
    return;
  }
  if(m.round_override == true && level.music_round_override == true) {
    return;
  }
  if(m.is_alias) {
    if(isDefined(m.musicstate)) {
      setmusicstate(m.musicstate);
    }
    play_sound_2d(m.music);
  } else {
    setmusicstate(m.music);
  }
  level.old_music_state = m;
}

weapon_toggle_vox(alias, weapon) {
  self notify("audio_activated_trigger");
  self endon("audio_activated_trigger");
  prefix = "vox_pa_switcher_";
  sound_to_play = prefix + alias;
  type = undefined;
  if(isDefined(weapon)) {
    type = get_weapon_num(weapon);
    if(!isDefined(type)) {
      return;
    }
  }
  self StopSounds();
  wait(.05);
  if(isDefined(type)) {
    self playSound(prefix + "weapon_" + type, "sounddone");
    self waittill("sounddone");
  }
  self playSound(sound_to_play + "_0");
}

get_weapon_num(weapon) {
  weapon_num = undefined;
  switch (weapon) {
    case "humangun_zm":
      weapon_num = 0;
      break;
    case "sniper_explosive_zm":
      weapon_num = 1;
      break;
    case "tesla_gun_zm":
      weapon_num = 2;
      break;
  }
  return weapon_num;
}