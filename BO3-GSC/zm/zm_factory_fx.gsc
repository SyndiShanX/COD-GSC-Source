/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_factory_fx.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace zm_factory_fx;

function autoexec __init__sytem__() {
  system::register("zm_factory_fx", &__init__, undefined, undefined);
}

function __init__() {
  level thread run_door_fxanim("enter_outside_east", "fxanim_outside_east_door_snow", "door_snow_a_open");
  level thread run_door_fxanim("enter_outside_west", "fxanim_outside_west_door_snow", "door_snow_b_open");
  level thread run_door_fxanim("enter_tp_south", "fxanim_south_courtyard_door_lft_snow", "door_snow_c_open");
  level thread run_door_fxanim("enter_tp_south", "fxanim_south_courtyard_door_rt_snow");
  clientfield::register("clientuimodel", "player_lives", 1, 2, "int");
}

function main() {
  precache_scripted_fx();
  precache_createfx_fx();
}

function run_door_fxanim(str_flag, str_scene, str_exploder) {
  level waittill("start_zombie_round_logic");
  level flag::wait_till(str_flag);
  if(isDefined(str_scene)) {
    level thread scene::play(str_scene, "targetname");
  }
  if(isDefined(str_exploder)) {
    level thread exploder::exploder(str_exploder);
  }
}

function precache_scripted_fx() {
  level._effect["large_ceiling_dust"] = "_t6/maps/zombie/fx_dust_ceiling_impact_lg_mdbrown";
  level._effect["poltergeist"] = "zombie/fx_barrier_buy_zmb";
  level._effect["gasfire"] = "destructibles/fx_dest_fire_vert";
  level._effect["switch_sparks"] = "electric/fx_elec_sparks_directional_orange";
  level._effect["wire_sparks_oneshot"] = "electrical/fx_elec_wire_spark_dl_oneshot";
  level._effect["lght_marker"] = "zombie/fx_weapon_box_marker_zmb";
  level._effect["lght_marker_flare"] = "zombie/fx_weapon_box_marker_fl_zmb";
  level._effect["betty_explode"] = "weapon/fx_betty_exp";
  level._effect["betty_trail"] = "weapon/fx_betty_launch_dust";
  level._effect["zapper"] = "dlc0/factory/fx_elec_trap_factory";
  level._effect["zapper_light_ready"] = "maps/zombie/fx_zombie_light_glow_green";
  level._effect["zapper_light_notready"] = "maps/zombie/fx_zombie_light_glow_red";
  level._effect["elec_room_on"] = "fx_zombie_light_elec_room_on";
  level._effect["elec_md"] = "zombie/fx_elec_player_md_zmb";
  level._effect["elec_sm"] = "zombie/fx_elec_player_sm_zmb";
  level._effect["elec_torso"] = "zombie/fx_elec_player_torso_zmb";
  level._effect["elec_trail_one_shot"] = "electric/fx_elec_sparks_burst_sm_circuit_os";
  level._effect["wire_spark"] = "electric/fx_elec_sparks_burst_sm_circuit_os";
  level._effect["powerup_on"] = "zombie/fx_powerup_on_green_zmb";
}

function precache_createfx_fx() {
  level._effect["a_embers_falling_sm"] = "env/fire/fx_embers_falling_sm";
  level._effect["mp_smoke_stack"] = "zombie/fx_smk_stack_burning_zmb";
  level._effect["mp_elec_spark_fast_random"] = "electric/fx_elec_sparks_burst_sm_circuit_os";
  level._effect["zombie_elec_gen_idle"] = "zombie/fx_elec_gen_idle_zmb";
  level._effect["zombie_moon_eclipse"] = "zombie/fx_moon_eclipse_zmb";
  level._effect["zombie_clock_hand"] = "zombie/fx_clock_hand_zmb";
  level._effect["zombie_elec_pole_terminal"] = "zombie/fx_elec_pole_terminal_zmb";
  level._effect["mp_elec_broken_light_1shot"] = "electric/fx_elec_sparks_burst_sm_circuit_os";
  level._effect["electric_short_oneshot"] = "electric/fx_elec_sparks_burst_sm_circuit_os";
}