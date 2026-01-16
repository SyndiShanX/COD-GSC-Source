/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\nicaragua_amb.csc
*******************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_audio;
#include clientscripts\_music;

main() {
  declareambientroom("nicaragua_outside", 1);
  setambientroomtone("nicaragua_outside", "amb_wind_bg_2d", 0.5, 0.5);
  setambientroomreverb("nicaragua_outside", "spl_yemen_hills", 1, 1);
  setambientroomcontext("nicaragua_outside", "ringoff_plr", "outdoor");
  declareambientpackage("nicaragua_outside");
  declareambientroom("nic_shed_open_sml");
  setambientroomreverb("nic_shed_open_sml", "gen_smallroom", 1, 1);
  setambientroomcontext("nic_shed_open_sml", "ringoff_plr", "outdoor");
  declareambientpackage("nic_shed_open_sml");
  declareambientroom("nic_shed_med");
  setambientroomreverb("nic_shed_med", "gen_mediumroom", 1, 1);
  setambientroomcontext("nic_shed_med", "ringoff_plr", "indoor");
  declareambientpackage("nic_shed_med");
  declareambientroom("nic_shed_sml");
  setambientroomreverb("nic_shed_sml", "gen_smallroom", 1, 1);
  setambientroomcontext("nic_shed_sml", "ringoff_plr", "indoor");
  declareambientpackage("nic_shed_sml");
  declareambientroom("nic_villa_hangover");
  setambientroomreverb("nic_villa_hangover", "gen_smallroom", 1, 1);
  setambientroomcontext("nic_villa_hangover", "ringoff_plr", "outdoor");
  declareambientpackage("nic_villa_hangover");
  declareambientroom("nic_villa_arch");
  setambientroomreverb("nic_villa_arch", "gen_smallroom", 1, 1);
  setambientroomcontext("nic_villa_arch", "ringoff_plr", "indoor");
  declareambientpackage("nic_villa_arch");
  declareambientroom("nic_villa_room_sml");
  setambientroomreverb("nic_villa_room_sml", "gen_smallroom", 1, 1);
  setambientroomcontext("nic_villa_room_sml", "ringoff_plr", "indoor");
  declareambientpackage("nic_villa_room_sml");
  declareambientroom("nic_brick_house_sml");
  setambientroomreverb("nic_brick_house_sml", "gen_smallroom", 1, 1);
  setambientroomcontext("nic_brick_house_sml", "ringoff_plr", "indoor");
  declareambientpackage("nic_brick_house_sml");
  declareambientroom("nic_wood_sml");
  setambientroomreverb("nic_wood_sml", "gen_smallroom", 1, 1);
  setambientroomcontext("nic_wood_sml", "ringoff_plr", "outdoor");
  declareambientpackage("nic_wood_sml");
  declareambientroom("nic_stables");
  setambientroomreverb("nic_stables", "gen_largeroom", 1, 1);
  setambientroomcontext("nic_stables", "ringoff_plr", "indoor");
  declareambientpackage("nic_stables");
  declareambientroom("nic_market_room");
  setambientroomreverb("nic_market_room", "gen_smallroom", 1, 1);
  setambientroomcontext("nic_market_room", "ringoff_plr", "indoor");
  declareambientpackage("nic_market_room");
  declareambientroom("nic_tile_room");
  setambientroomreverb("nic_tile_room", "gen_smallroom", 1, 1);
  setambientroomcontext("nic_tile_room", "ringoff_plr", "indoor");
  declareambientpackage("nic_tile_room");
  declareambientroom("nic_villa_stairs_prt");
  setambientroomreverb("nic_villa_stairs_prt", "gen_smallroom", 1, 1);
  setambientroomcontext("nic_villa_stairs_prt", "ringoff_plr", "outdoor");
  declareambientpackage("nic_villa_stairs_prt");
  declareambientroom("nic_villa_circle_inside");
  setambientroomreverb("nic_villa_circle_inside", "gen_smallroom", 1, 1);
  setambientroomcontext("nic_villa_circle_inside", "ringoff_plr", "indoor");
  declareambientpackage("nic_villa_circle_inside");
  declareambientroom("nic_villa_circle_out");
  setambientroomreverb("nic_villa_circle_out", "gen_smallroom", 1, 1);
  setambientroomcontext("nic_villa_circle_out", "ringoff_plr", "outdoor");
  declareambientpackage("nic_villa_circle_out");
  declareambientroom("nic_mission_room_sml");
  setambientroomreverb("nic_mission_room_sml", "gen_stoneroom", 1, 1);
  setambientroomcontext("nic_mission_room_sml", "ringoff_plr", "indoor");
  declareambientpackage("nic_mission_room_sml");
  declareambientroom("nic_mission_archways");
  setambientroomreverb("nic_mission_archways", "gen_smallroom", 1, 1);
  setambientroomcontext("nic_mission_archways", "ringoff_plr", "indoor");
  declareambientpackage("nic_mission_archways");
  declareambientroom("nic_mission_archways_open");
  setambientroomreverb("nic_mission_archways_open", "gen_smallroom", 1, 1);
  setambientroomcontext("nic_mission_archways_open", "ringoff_plr", "outdoor");
  declareambientpackage("nic_mission_archways_open");
  declareambientroom("nic_mission_main_rm");
  setambientroomreverb("nic_mission_main_rm", "gen_mediumroom", 1, 1);
  setambientroomcontext("nic_mission_main_rm", "ringoff_plr", "indoor");
  declareambientpackage("nic_mission_main_rm");
  declareambientroom("nic_mission_side_rm");
  setambientroomreverb("nic_mission_side_rm", "gen_smallroom", 1, 1);
  setambientroomcontext("nic_mission_side_rm", "ringoff_plr", "indoor");
  declareambientpackage("nic_mission_side_rm");
  declareambientroom("nic_mission_hallway");
  setambientroomreverb("nic_mission_hallway", "gen_smallroom", 1, 1);
  setambientroomcontext("nic_mission_hallway", "ringoff_plr", "indoor");
  declareambientpackage("nic_mission_hallway");
  declareambientroom("nic_hut_open_sml");
  setambientroomreverb("nic_hut_open_sml", "gen_smallroom", 1, 1);
  setambientroomcontext("nic_hut_open_sml", "ringoff_plr", "outdoor");
  declareambientpackage("nic_hut_open_sml");
  declareambientroom("nic_garage_open");
  setambientroomreverb("nic_garage_open", "gen_smallroom", 1, 1);
  setambientroomcontext("nic_garage_open", "ringoff_plr", "outdoor");
  declareambientpackage("nic_garage_open");
  declareambientroom("nic_mission_bell_tower");
  setambientroomreverb("nic_mission_bell_tower", "gen_smallroom", 1, 1);
  setambientroomcontext("nic_mission_bell_tower", "ringoff_plr", "indoor");
  declareambientpackage("nic_mission_bell_tower");
  declareambientroom("nic_mission_bell_tower_top");
  setambientroomreverb("nic_mission_bell_tower_top", "gen_smallroom", 1, 1);
  setambientroomcontext("nic_mission_bell_tower_top", "ringoff_plr", "outdoor");
  declareambientpackage("nic_mission_bell_tower_top");
  declareambientroom("nic_hatch_room");
  setambientroomreverb("nic_hatch_room", "gen_smallroom", 1, 1);
  setambientroomcontext("nic_hatch_room", "ringoff_plr", "indoor");
  declareambientpackage("nic_hatch_room");
  declareambientroom("nic_drug_lab_ent");
  setambientroomreverb("nic_drug_lab_ent", "gen_stoneroom", 1, 1);
  setambientroomcontext("nic_drug_lab_ent", "ringoff_plr", "indoor");
  declareambientpackage("nic_drug_lab_ent");
  declareambientroom("nic_drug_lab_mtl_rm");
  setambientroomreverb("nic_drug_lab_mtl_rm", "gen_cave", 1, 1);
  setambientroomcontext("nic_drug_lab_mtl_rm", "ringoff_plr", "indoor");
  declareambientpackage("nic_drug_lab_mtl_rm");
  declareambientroom("nic_drug_security");
  setambientroomreverb("nic_drug_security", "gen_cave", 1, 1);
  setambientroomcontext("nic_drug_security", "ringoff_plr", "indoor");
  declareambientpackage("nic_drug_security");
  declareambientroom("nic_drug_lab_hallway");
  setambientroomreverb("nic_drug_lab_hallway", "gen_cave", 1, 1);
  setambientroomcontext("nic_drug_lab_hallway", "ringoff_plr", "indoor");
  declareambientpackage("nic_drug_lab_hallway");
  declareambientroom("nic_drug_lab");
  setambientroomreverb("nic_drug_lab", "gen_cave", 1, 1);
  setambientroomcontext("nic_drug_lab", "ringoff_plr", "indoor");
  declareambientpackage("nic_drug_lab");
  declareambientroom("nic_drug_lab_office");
  setambientroomreverb("nic_drug_lab_office", "gen_cave", 1, 1);
  setambientroomcontext("nic_drug_lab_office", "ringoff_plr", "indoor");
  declareambientpackage("nic_drug_lab_office");
  declareambientroom("rage_mode_high");
  setambientroomreverb("rage_mode_high", "rage_echo", 1, 1);
  setambientroomcontext("rage_mode_high", "ringoff_plr", "outdoor");
  declareambientpackage("rage_mode_high");
  declaremusicstate("NIC_INTRO");
  musicaliasloop("mus_intro", 0, 15);
  declaremusicstate("NIC_MENENDEZ_SINGS");
  musicalias("mus_nina_precioso_menendez", 0, 1);
  declaremusicstate("NIC_MENENDEZ_ATTACKED");
  musicalias("mus_menendez_attacked", 0, 0);
  musicaliasloop("mus_intro", 0, 2);
  declaremusicstate("NIC_RAGE");
  musicaliasloop("mus_rage_mode", 0, 4);
  musicstinger("mus_rage_end_stg", 14, 1);
  declaremusicstate("NIC_RAGE_OVER");
  musicaliasloop("null", 2, 2);
  declaremusicstate("NIC_INTRO_2");
  musicaliasloop("mus_intro", 2, 2);
  declaremusicstate("NIC_RAID_BATTLE");
  musicaliasloop("mus_raid_battle", 0, 2);
  declaremusicstate("NIC_WOODS_FREAKS");
  musicalias("mus_woods_freaks", 6, 0);
  declaremusicstate("NIC_RAID_BATTLE_2");
  musicaliasloop("mus_raid_battle", 2, 2);
  declaremusicstate("NIC_COURTYARD_COMPLETE");
  musicaliasloop("mus_intro", 2, 2);
  declaremusicstate("NIC_RAID_BUNKER_AMBIENCE");
  musicaliasloop("mus_intro", 2, 2);
  declaremusicstate("NIC_RAID_BUNKER_ALERTED");
  musicaliasloop("mus_raid_battle", 0, 2);
  musicstinger("mus_rage_end_stg", 14, 1);
  declaremusicstate("NIC_WOODS_FATEFUL_GRENADE");
  musicaliasloop("mus_intro", 2, 2);
  thread snd_play_loopers();
  level thread setup_ambient_fx_sounds();
  thread snd_exploders();
  thread church_bells();
  thread ransack_walla();
  level thread snapshot_woods_freak();
  level thread snapshot_woods_default();
  level thread lab_fire();
}

snapshot_woods_freak() {
  level waittill("wfo");
  snd_set_snapshot("spl_nic_woods_freak");
}

snapshot_woods_default() {
  level waittill("wdfo");
  snd_set_snapshot("default");
}

snd_play_loopers() {
  clientscripts\_audio::playloopat("amb_ransack_walla", (-4978, 7439, 1347));
  clientscripts\_audio::playloopat("amb_ransack_walla", (-7227, 3176, 1724));
}

setup_ambient_fx_sounds() {
  playloopat("amb_fireplace", (-2028, -3664, 2011));
  snd_play_auto_fx("fx_fire_line_md", "amb_fire_med", 0, 0, 0, 1, 200, 2, "amb_fire_lrg");
  snd_play_auto_fx("fx_fire_ceiling_md", "amb_fire_med", 0, 0, 0, 1, 200, 2, "amb_fire_lrg");
  snd_play_auto_fx("fx_fire_column_creep_sm", "amb_fire_med", 0, 0, 0, 1, 200, 2, "amb_fire_lrg");
  level waittill("fr_on");
  snd_play_auto_fx("fx_fire_line_xsm_pole", "amb_fire_sml", 0, 0, 0, 1, 200, 2, "amb_fire_med");
  snd_play_auto_fx("fx_fire_line_sm", "amb_fire_sml", 0, 0, 0, 1, 200, 2, "amb_fire_med");
  snd_play_auto_fx("fx_fire_line_sm_pole", "amb_fire_sml", 0, 0, 0, 1, 200, 2, "amb_fire_med");
  snd_play_auto_fx("fx_fire_eaves_md", "amb_fire_med", 0, 0, 0, 1, 200, 2, "amb_fire_lrg");
  snd_play_auto_fx("fx_fire_eaves_md_right", "amb_fire_med", 0, 0, 0, 1, 200, 2, "amb_fire_lrg");
  snd_play_auto_fx("fx_fire_edge_windblown", "amb_fire_med", 0, 0, 0, 1, 200, 2, "amb_fire_lrg");
  snd_play_auto_fx("fx_fire_edge_windblown_md", "amb_fire_med", 0, 0, 0, 1, 200, 2, "amb_fire_lrg");
  snd_play_auto_fx("fx_fire_pole_md_long", "amb_fire_sml", 0, 0, 0, 1, 200, 2, "amb_fire_med");
  snd_play_auto_fx("fx_fire_xsm", "amb_fire_sml", 0, 0, 0, 1, 200, 2, "amb_fire_med");
  snd_play_auto_fx("fx_fire_sm_smolder", "amb_fire_sml", 0, 0, 0, 1, 200, 2, "amb_fire_med");
  snd_play_auto_fx("fx_nic_fire_building_md", "amb_fire_med", 0, 0, 0, 1, 200, 2, "amb_fire_lrg");
  snd_play_auto_fx("fx_nic_fire_wall_josefina_md", "amb_fire_lrg", 0, 0, 0, 1, 200, 2, "amb_fire_lrg");
  snd_play_auto_fx("fx_fire_ceiling_rafter_md", "amb_fire_lrg", 0, 0, 0, 1, 200, 2, "amb_fire_lrg");
}

church_bells() {
  while(true) {
    level waittill("chc_bls");
    wait 2;
    playsound(0, "amb_church_bells", (-4144, -1455, 2635));
  }
}

hallwaysnap() {
  snd_set_snapshot("spl_nica_menendez_hallway_end");
}

masonintrosnapandloop() {
  snd_set_snapshot("spl_nica_mason_intro");
  ent = spawn(0, (0, 0, 0), "script_origin");
  ent playloopsound("evt_mason_fake_amb_front", 3);
  level waittill("stopIntroSnap");
  snd_set_snapshot("default");
  ent stoploopsound(14);
  wait 14;
  ent delete();
}

snd_exploders() {
  snd_add_exploder_alias(50, "wpn_mortar_fire");
  snd_add_exploder_alias(668, "evt_gas_ignite");
}

levelintrosnapandloop() {
  wait 7;
  snd_set_snapshot("spl_nica_intro");
  ent = spawn(0, (0, 0, 0), "script_origin");
  ent playloopsound("evt_mason_fake_amb_front", 1.75);
  level waittill("stopLevelIntroSnap");
  snd_set_snapshot("spl_nica_transition");
  ent delete();
  wait 1.5;
  snd_set_snapshot("default");
}

ransack_walla() {
  level waittill("off_frst_walla");
  stoploopat("amb_ransack_walla", (-4978, 7439, 1347));
  level waittill("trn_off_walla");
  stoploopat("amb_ransack_walla", (-7227, 3176, 1724));
}

sndsnapshotintro() {
  snd_set_snapshot("spl_nicaragua_snap");
}

hallway_fire() {
  snd_set_snapshot("spl_nica_shattered");
  level waittill("snd_shattered");
  snd_set_snapshot("default");
}

lab_fire() {
  level waittill("frs_on");
  wait 1;
  playloopat("amb_fire_med", (-1306, -3398, 1629));
  playloopat("amb_fire_med", (-1470, -3425, 1633));
  playloopat("amb_fire_med", (-1598, -3344, 1633));
  playloopat("amb_fire_sml", (-1636, -3117, 1633));
}

shattered2() {
  snd_set_snapshot("spl_nica_shattered_2");
  level waittill("snd_shattered_2");
  snd_set_snapshot("default");
  wait 1;
  snd_set_snapshot("spl_nica_outro");
  level waittill("outro_fade_white");
  wait 1;
  snd_set_snapshot("cmn_fade_out");
}