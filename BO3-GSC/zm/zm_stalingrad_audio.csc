/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_stalingrad_audio.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\audio_shared;
#using scripts\shared\beam_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace zm_stalingrad_audio;

function autoexec __init__sytem__() {
  system::register("zm_stalingrad_audio", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "ee_anthem_pa", 12000, 1, "int", & function_a50e0efb, 0, 0);
  clientfield::register("scriptmover", "ee_ballerina", 12000, 2, "int", & function_41eaf8b8, 0, 0);
  level._effect["ee_anthem_pa_appear"] = "dlc3/stalingrad/fx_main_anomoly_emp_pulse";
  level._effect["ee_anthem_pa_explode"] = "dlc3/stalingrad/fx_main_impact_success";
  level._effect["ee_ballerina_appear"] = "dlc3/stalingrad/fx_main_impact_success";
  level._effect["ee_ballerina_disappear"] = "dlc3/stalingrad/fx_main_impact_success";
}

function function_a50e0efb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFX(localclientnum, level._effect["ee_anthem_pa_appear"], self.origin);
    audio::playloopat("zmb_nikolai_mus_pa_anthem_lp", self.origin);
    wait(randomfloatrange(0.05, 0.35));
    playSound(0, "zmb_nikolai_mus_pa_anthem_start", self.origin);
  } else {
    playFX(localclientnum, level._effect["ee_anthem_pa_explode"], self.origin);
    audio::stoploopat("zmb_nikolai_mus_pa_anthem_lp", self.origin);
  }
}

function function_41eaf8b8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(newval == 1) {
      playFX(localclientnum, level._effect["ee_ballerina_appear"], self.origin);
      playSound(0, "zmb_sam_egg_appear", self.origin);
    }
  } else {
    playFX(localclientnum, level._effect["ee_ballerina_disappear"], self.origin);
    playSound(0, "zmb_sam_egg_disappear", self.origin);
  }
}