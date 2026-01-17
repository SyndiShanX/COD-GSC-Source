/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_castle_ee_side.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\audio_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace zm_castle_ee_side;

function autoexec __init__sytem__() {
  system::register("zm_zod_ee_side", &__init__, undefined, undefined);
}

function __init__() {
  level._effect["clocktower_flash"] = "dlc1/castle/fx_lightning_strike_weathervane";
  level._effect["exploding_death"] = "dlc1/zmb_weapon/fx_ee_plunger_teleport_impact";
  clientfield::register("world", "clocktower_flash", 5000, 1, "counter", &clocktower_flash, 0, 0);
  clientfield::register("world", "sndUEB", 5000, 1, "int", &sndueb, 0, 0);
  clientfield::register("actor", "plunger_exploding_ai", 5000, 1, "int", &callback_exploding_death_fx, 0, 0);
  clientfield::register("toplayer", "plunger_charged_strike", 5000, 1, "counter", &plunger_charged_strike, 0, 0);
}

function clocktower_flash(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_1f1c6e96 = struct::get("ee_clocktower_lightning_rod", "targetname");
  playFX(localclientnum, level._effect["clocktower_flash"], var_1f1c6e96.origin);
}

function sndueb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playSound(0, "zmb_pyramid_energy_ball_start", (-1192, 2256, 320));
    audio::playloopat("zmb_pyramid_energy_ball_lp", (-1192, 2256, 320));
  } else {
    playSound(0, "zmb_pyramid_energy_ball_end", (-1192, 2256, 320));
    audio::stoploopat("zmb_pyramid_energy_ball_lp", (-1192, 2256, 320));
  }
}

function callback_exploding_death_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    v_pos = self gettagorigin("j_spine4");
    v_angles = self gettagangles("j_spine4");
    var_e6ddb5de = util::spawn_model(localclientnum, "tag_origin", v_pos, v_angles);
    playFXOnTag(localclientnum, level._effect["exploding_death"], var_e6ddb5de, "tag_origin");
    var_e6ddb5de playSound(localclientnum, "evt_ai_explode");
    waitrealtime(6);
    var_e6ddb5de delete();
  }
}

function plunger_charged_strike(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playviewmodelfx(localclientnum, level._effect["plunger_charge_1p"], "tag_fx");
  playFXOnTag(localclientnum, level._effect["plunger_charge_3p"], self, "tag_fx");
}