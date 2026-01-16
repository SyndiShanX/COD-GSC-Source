/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_castle.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\mechz;
#using scripts\shared\audio_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_electroball_grenade;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_ai_dogs;
#using scripts\zm\_zm_ai_mechz;
#using scripts\zm\_zm_perk_additionalprimaryweapon;
#using scripts\zm\_zm_perk_deadshot;
#using scripts\zm\_zm_perk_doubletap2;
#using scripts\zm\_zm_perk_electric_cherry;
#using scripts\zm\_zm_perk_juggernaut;
#using scripts\zm\_zm_perk_quick_revive;
#using scripts\zm\_zm_perk_random;
#using scripts\zm\_zm_perk_sleight_of_hand;
#using scripts\zm\_zm_perk_staminup;
#using scripts\zm\_zm_perk_widows_wine;
#using scripts\zm\_zm_powerup_carpenter;
#using scripts\zm\_zm_powerup_castle_demonic_rune;
#using scripts\zm\_zm_powerup_castle_tram_token;
#using scripts\zm\_zm_powerup_double_points;
#using scripts\zm\_zm_powerup_fire_sale;
#using scripts\zm\_zm_powerup_free_perk;
#using scripts\zm\_zm_powerup_full_ammo;
#using scripts\zm\_zm_powerup_insta_kill;
#using scripts\zm\_zm_powerup_nuke;
#using scripts\zm\_zm_powerup_weapon_minigun;
#using scripts\zm\_zm_trap_electric;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weap_bouncingbetty;
#using scripts\zm\_zm_weap_castle_rocketshield;
#using scripts\zm\_zm_weap_cymbal_monkey;
#using scripts\zm\_zm_weap_elemental_bow;
#using scripts\zm\_zm_weap_elemental_bow_demongate;
#using scripts\zm\_zm_weap_elemental_bow_rune_prison;
#using scripts\zm\_zm_weap_elemental_bow_storm;
#using scripts\zm\_zm_weap_elemental_bow_wolf_howl;
#using scripts\zm\_zm_weap_gravityspikes;
#using scripts\zm\_zm_weapons;
#using scripts\zm\craftables\_zm_craft_shield;
#using scripts\zm\craftables\_zm_craftables;
#using scripts\zm\zm_castle_amb;
#using scripts\zm\zm_castle_craftables;
#using scripts\zm\zm_castle_death_ray_trap;
#using scripts\zm\zm_castle_ee;
#using scripts\zm\zm_castle_ee_bossfight;
#using scripts\zm\zm_castle_ee_side;
#using scripts\zm\zm_castle_ffotd;
#using scripts\zm\zm_castle_flingers;
#using scripts\zm\zm_castle_fx;
#using scripts\zm\zm_castle_low_grav;
#using scripts\zm\zm_castle_pap_quest;
#using scripts\zm\zm_castle_perks;
#using scripts\zm\zm_castle_rocket_trap;
#using scripts\zm\zm_castle_teleporter;
#using scripts\zm\zm_castle_tram;
#using scripts\zm\zm_castle_weap_quest;
#using scripts\zm\zm_castle_weap_quest_upgrade;
#namespace zm_castle;

function autoexec opt_in() {
  level.aat_in_use = 1;
  level.bgb_in_use = 1;
  level.var_18402cb = [];
  level._effect["zm_bgb_machine_available"] = "dlc1/castle/fx_bgb_machine_available_castle";
  level._effect["zm_bgb_machine_bulb_away"] = "dlc1/castle/fx_bgb_machine_bulb_away_castle";
  level._effect["zm_bgb_machine_bulb_available"] = "dlc1/castle/fx_bgb_machine_bulb_available_castle";
  level._effect["zm_bgb_machine_bulb_activated"] = "dlc1/castle/fx_bgb_machine_bulb_activated_castle";
  level._effect["zm_bgb_machine_bulb_event"] = "dlc1/castle/fx_bgb_machine_bulb_event_castle";
  level._effect["zm_bgb_machine_bulb_rounds"] = "dlc1/castle/fx_bgb_machine_bulb_rounds_castle";
  level._effect["zm_bgb_machine_bulb_time"] = "dlc1/castle/fx_bgb_machine_bulb_time_castle";
}

function main() {
  zm_castle_ffotd::main_start();
  level.setupcustomcharacterexerts = & setup_personality_character_exerts;
  level._effect["animscript_gibtrail_fx"] = "trail/fx_trail_blood_streak";
  level._effect["animscript_gib_fx"] = "weapon/bullet/fx_flesh_gib_fatal_01";
  level._effect["bloodspurt"] = "misc/fx_zombie_bloodspurt";
  level._effect["eye_glow"] = "dlc1/castle/fx_glow_eye_orange_castle";
  level._effect["headshot"] = "impacts/fx_flesh_hit";
  level._effect["headshot_nochunks"] = "misc/fx_zombie_bloodsplat";
  level._effect["snow"] = "dlc1/castle/fx_snow_player_castle";
  level._uses_sticky_grenades = 1;
  level._uses_taser_knuckles = 1;
  level.debug_keyline_zombies = 0;
  register_clientfields();
  thread zm_castle_weap_quest_upgrade::main();
  include_weapons();
  zm_castle_craftables::include_craftables();
  zm_castle_craftables::init_craftables();
  zm_castle_perks::init();
  zm_castle_death_ray_trap::main();
  zm_castle_rocket_trap::main();
  zm_castle_flingers::main();
  zm_castle_low_grav::main();
  level thread zm_castle_ee::main();
  load::main();
  zm_castle_fx::main();
  _zm_weap_cymbal_monkey::init();
  level thread zm_castle_amb::main();
  level thread zm_castle_weap_quest::main();
  util::waitforclient(0);
  thread function_893a7cdd();
  level thread function_a81bfac6();
  zm_castle_ffotd::main_end();
}

function function_a81bfac6() {
  if(getdvarint("splitscreen_playerCount") > 2) {
    wait(0.5);
    level thread scene::stop("fxanim_diff_engine_zone_c2", "targetname", 1);
  }
}

function include_weapons() {
  zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_castle_weapons.csv", 1);
  zm_weapons::autofill_wallbuys_init();
}

function register_clientfields() {
  clientfield::register("toplayer", "player_snow_fx", 5000, 1, "counter", & callback_player_snow_fx_logic, 0, 0);
  clientfield::register("clientuimodel", "zmInventory.widget_shield_parts", 1, 1, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", "zmInventory.widget_fuses", 1, 1, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", "zmInventory.player_crafted_shield", 1, 1, "int", undefined, 0, 0);
  clientfield::register("world", "snd_low_gravity_state", 5000, 2, "int", & snd_low_gravity_state, 0, 0);
  clientfield::register("world", "castle_fog_bank_switch", 1, 1, "int", & castle_fog_bank_switch, 0, 0);
}

function function_893a7cdd() {
  forcestreamxmodel("p7_fxanim_zm_castle_rocket_01_mod");
  forcestreamxmodel("p7_fxanim_zm_castle_tram_car_01_mod");
  forcestreamxmodel("p7_zm_vending_revive");
  wait(20);
  stopforcestreamingxmodel("p7_fxanim_zm_castle_rocket_01_mod");
  stopforcestreamingxmodel("p7_fxanim_zm_castle_tram_car_01_mod");
  forcestreamxmodel("p7_zm_vending_revive");
}

function setup_personality_character_exerts() {
  level.exert_sounds[1]["playerbreathinsound"][0] = "vox_plr_0_exert_inhale_0";
  level.exert_sounds[2]["playerbreathinsound"][0] = "vox_plr_1_exert_inhale_0";
  level.exert_sounds[3]["playerbreathinsound"][0] = "vox_plr_2_exert_inhale_0";
  level.exert_sounds[4]["playerbreathinsound"][0] = "vox_plr_3_exert_inhale_0";
  level.exert_sounds[1]["playerbreathoutsound"][0] = "vox_plr_0_exert_exhale_0";
  level.exert_sounds[2]["playerbreathoutsound"][0] = "vox_plr_1_exert_exhale_0";
  level.exert_sounds[3]["playerbreathoutsound"][0] = "vox_plr_2_exert_exhale_0";
  level.exert_sounds[4]["playerbreathoutsound"][0] = "vox_plr_3_exert_exhale_0";
  level.exert_sounds[1]["playerbreathgaspsound"][0] = "vox_plr_0_exert_exhale_0";
  level.exert_sounds[2]["playerbreathgaspsound"][0] = "vox_plr_1_exert_exhale_0";
  level.exert_sounds[3]["playerbreathgaspsound"][0] = "vox_plr_2_exert_exhale_0";
  level.exert_sounds[4]["playerbreathgaspsound"][0] = "vox_plr_3_exert_exhale_0";
  level.exert_sounds[1]["falldamage"][0] = "vox_plr_0_exert_pain_0";
  level.exert_sounds[1]["falldamage"][1] = "vox_plr_0_exert_pain_1";
  level.exert_sounds[1]["falldamage"][2] = "vox_plr_0_exert_pain_2";
  level.exert_sounds[1]["falldamage"][3] = "vox_plr_0_exert_pain_3";
  level.exert_sounds[1]["falldamage"][4] = "vox_plr_0_exert_pain_4";
  level.exert_sounds[2]["falldamage"][0] = "vox_plr_1_exert_pain_0";
  level.exert_sounds[2]["falldamage"][1] = "vox_plr_1_exert_pain_1";
  level.exert_sounds[2]["falldamage"][2] = "vox_plr_1_exert_pain_2";
  level.exert_sounds[2]["falldamage"][3] = "vox_plr_1_exert_pain_3";
  level.exert_sounds[3]["falldamage"][0] = "vox_plr_2_exert_pain_0";
  level.exert_sounds[3]["falldamage"][1] = "vox_plr_2_exert_pain_1";
  level.exert_sounds[3]["falldamage"][2] = "vox_plr_2_exert_pain_2";
  level.exert_sounds[3]["falldamage"][3] = "vox_plr_2_exert_pain_3";
  level.exert_sounds[3]["falldamage"][4] = "vox_plr_2_exert_pain_4";
  level.exert_sounds[4]["falldamage"][0] = "vox_plr_3_exert_pain_0";
  level.exert_sounds[4]["falldamage"][1] = "vox_plr_3_exert_pain_1";
  level.exert_sounds[4]["falldamage"][2] = "vox_plr_3_exert_pain_2";
  level.exert_sounds[4]["falldamage"][3] = "vox_plr_3_exert_pain_3";
  level.exert_sounds[1]["mantlesoundplayer"][0] = "vox_plr_0_exert_grunt_0";
  level.exert_sounds[1]["mantlesoundplayer"][1] = "vox_plr_0_exert_grunt_1";
  level.exert_sounds[1]["mantlesoundplayer"][2] = "vox_plr_0_exert_grunt_2";
  level.exert_sounds[1]["mantlesoundplayer"][3] = "vox_plr_0_exert_grunt_3";
  level.exert_sounds[1]["mantlesoundplayer"][4] = "vox_plr_0_exert_grunt_4";
  level.exert_sounds[1]["mantlesoundplayer"][5] = "vox_plr_0_exert_grunt_5";
  level.exert_sounds[1]["mantlesoundplayer"][6] = "vox_plr_0_exert_grunt_6";
  level.exert_sounds[2]["mantlesoundplayer"][0] = "vox_plr_1_exert_grunt_0";
  level.exert_sounds[2]["mantlesoundplayer"][1] = "vox_plr_1_exert_grunt_1";
  level.exert_sounds[2]["mantlesoundplayer"][2] = "vox_plr_1_exert_grunt_2";
  level.exert_sounds[2]["mantlesoundplayer"][3] = "vox_plr_1_exert_grunt_3";
  level.exert_sounds[2]["mantlesoundplayer"][4] = "vox_plr_1_exert_grunt_4";
  level.exert_sounds[2]["mantlesoundplayer"][5] = "vox_plr_1_exert_grunt_5";
  level.exert_sounds[2]["mantlesoundplayer"][6] = "vox_plr_1_exert_grunt_6";
  level.exert_sounds[3]["mantlesoundplayer"][0] = "vox_plr_2_exert_grunt_0";
  level.exert_sounds[3]["mantlesoundplayer"][1] = "vox_plr_2_exert_grunt_1";
  level.exert_sounds[3]["mantlesoundplayer"][2] = "vox_plr_2_exert_grunt_2";
  level.exert_sounds[3]["mantlesoundplayer"][3] = "vox_plr_2_exert_grunt_3";
  level.exert_sounds[3]["mantlesoundplayer"][4] = "vox_plr_2_exert_grunt_4";
  level.exert_sounds[3]["mantlesoundplayer"][5] = "vox_plr_2_exert_grunt_5";
  level.exert_sounds[3]["mantlesoundplayer"][6] = "vox_plr_2_exert_grunt_6";
  level.exert_sounds[4]["mantlesoundplayer"][0] = "vox_plr_3_exert_grunt_0";
  level.exert_sounds[4]["mantlesoundplayer"][1] = "vox_plr_3_exert_grunt_1";
  level.exert_sounds[4]["mantlesoundplayer"][2] = "vox_plr_3_exert_grunt_2";
  level.exert_sounds[4]["mantlesoundplayer"][3] = "vox_plr_3_exert_grunt_3";
  level.exert_sounds[4]["mantlesoundplayer"][4] = "vox_plr_3_exert_grunt_4";
  level.exert_sounds[4]["mantlesoundplayer"][5] = "vox_plr_3_exert_grunt_5";
  level.exert_sounds[4]["mantlesoundplayer"][6] = "vox_plr_3_exert_grunt_6";
  level.exert_sounds[1]["meleeswipesoundplayer"][0] = "vox_plr_0_exert_knife_swipe_0";
  level.exert_sounds[1]["meleeswipesoundplayer"][1] = "vox_plr_0_exert_knife_swipe_1";
  level.exert_sounds[1]["meleeswipesoundplayer"][2] = "vox_plr_0_exert_knife_swipe_2";
  level.exert_sounds[1]["meleeswipesoundplayer"][3] = "vox_plr_0_exert_knife_swipe_3";
  level.exert_sounds[1]["meleeswipesoundplayer"][4] = "vox_plr_0_exert_knife_swipe_4";
  level.exert_sounds[2]["meleeswipesoundplayer"][0] = "vox_plr_1_exert_knife_swipe_0";
  level.exert_sounds[2]["meleeswipesoundplayer"][1] = "vox_plr_1_exert_knife_swipe_1";
  level.exert_sounds[2]["meleeswipesoundplayer"][2] = "vox_plr_1_exert_knife_swipe_2";
  level.exert_sounds[2]["meleeswipesoundplayer"][3] = "vox_plr_1_exert_knife_swipe_3";
  level.exert_sounds[2]["meleeswipesoundplayer"][4] = "vox_plr_1_exert_knife_swipe_4";
  level.exert_sounds[3]["meleeswipesoundplayer"][0] = "vox_plr_2_exert_knife_swipe_0";
  level.exert_sounds[3]["meleeswipesoundplayer"][1] = "vox_plr_2_exert_knife_swipe_1";
  level.exert_sounds[3]["meleeswipesoundplayer"][2] = "vox_plr_2_exert_knife_swipe_2";
  level.exert_sounds[3]["meleeswipesoundplayer"][3] = "vox_plr_2_exert_knife_swipe_3";
  level.exert_sounds[3]["meleeswipesoundplayer"][4] = "vox_plr_2_exert_knife_swipe_4";
  level.exert_sounds[4]["meleeswipesoundplayer"][0] = "vox_plr_3_exert_knife_swipe_0";
  level.exert_sounds[4]["meleeswipesoundplayer"][1] = "vox_plr_3_exert_knife_swipe_1";
  level.exert_sounds[4]["meleeswipesoundplayer"][2] = "vox_plr_3_exert_knife_swipe_2";
  level.exert_sounds[4]["meleeswipesoundplayer"][3] = "vox_plr_3_exert_knife_swipe_3";
  level.exert_sounds[4]["meleeswipesoundplayer"][4] = "vox_plr_3_exert_knife_swipe_4";
  level.exert_sounds[1]["dtplandsoundplayer"][0] = "vox_plr_0_exert_pain_0";
  level.exert_sounds[1]["dtplandsoundplayer"][1] = "vox_plr_0_exert_pain_1";
  level.exert_sounds[1]["dtplandsoundplayer"][2] = "vox_plr_0_exert_pain_2";
  level.exert_sounds[1]["dtplandsoundplayer"][3] = "vox_plr_0_exert_pain_3";
  level.exert_sounds[2]["dtplandsoundplayer"][0] = "vox_plr_1_exert_pain_0";
  level.exert_sounds[2]["dtplandsoundplayer"][1] = "vox_plr_1_exert_pain_1";
  level.exert_sounds[2]["dtplandsoundplayer"][2] = "vox_plr_1_exert_pain_2";
  level.exert_sounds[2]["dtplandsoundplayer"][3] = "vox_plr_1_exert_pain_3";
  level.exert_sounds[3]["dtplandsoundplayer"][0] = "vox_plr_2_exert_pain_0";
  level.exert_sounds[3]["dtplandsoundplayer"][1] = "vox_plr_2_exert_pain_1";
  level.exert_sounds[3]["dtplandsoundplayer"][2] = "vox_plr_2_exert_pain_2";
  level.exert_sounds[3]["dtplandsoundplayer"][3] = "vox_plr_2_exert_pain_3";
  level.exert_sounds[4]["dtplandsoundplayer"][0] = "vox_plr_3_exert_pain_0";
  level.exert_sounds[4]["dtplandsoundplayer"][1] = "vox_plr_3_exert_pain_1";
  level.exert_sounds[4]["dtplandsoundplayer"][2] = "vox_plr_3_exert_pain_2";
  level.exert_sounds[4]["dtplandsoundplayer"][3] = "vox_plr_3_exert_pain_3";
}

function callback_player_snow_fx_logic(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isdefined(level.var_18402cb[localclientnum])) {
    deletefx(localclientnum, level.var_18402cb[localclientnum], 1);
    level.var_18402cb[localclientnum] = undefined;
  }
  level.var_18402cb[localclientnum] = playfxontag(localclientnum, level._effect["snow"], self, "tag_origin");
  setfxoutdoor(localclientnum, level.var_18402cb[localclientnum]);
}

function snd_low_gravity_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    audio::playloopat("zmb_low_grav_room_loop", (-1188, 2255, 261));
    audio::playloopat("zmb_low_grav_machine_loop", (-1188, 2255, 261));
    playsound(0, "zmb_low_grav_machine_start", (-1188, 2255, 261));
  }
  if(newval == 2) {
    audio::stoploopat("zmb_low_grav_machine_loop", (-1188, 2255, 261));
    playsound(0, "zmb_low_grav_machine_stop", (-1188, 2255, 261));
  } else {
    audio::stoploopat("zmb_low_grav_room_loop", (-1188, 2255, 261));
  }
}

function castle_fog_bank_switch(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    for (localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
      setlitfogbank(localclientnum, -1, 1, -1);
      setworldfogactivebank(localclientnum, 2);
    }
  } else {
    for (localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
      setlitfogbank(localclientnum, -1, 0, -1);
      setworldfogactivebank(localclientnum, 1);
    }
  }
}