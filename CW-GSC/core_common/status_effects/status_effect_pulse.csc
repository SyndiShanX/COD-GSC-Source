/**************************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\status_effects\status_effect_pulse.csc
**************************************************************/

#using scripts\core_common\audio_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace status_effect_pulse;

function private autoexec __init__system__() {
  system::register(#"status_effect_pulse", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("toplayer", "pulsed", 1, 1, "int", &on_pulsed_change, 0, 0);
}

function on_pulsed_change(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  localplayer = function_5c10bd79(binitialsnap);

  if(bwastimejump == 1) {
    self start_pulse_effects(localplayer);
    return;
  }

  self stop_pulse_effects(localplayer, fieldname);
}

function start_pulse_effects(localplayer, bwastimejump = 0) {
  if(!bwastimejump) {
    playSound(0, #"mpl_plr_emp_activate", (0, 0, 0));
  }

  audio::playloopat("mpl_plr_emp_looper", (0, 0, 0));
}

function stop_pulse_effects(localplayer, oldval, bwastimejump = 0) {
  if(oldval != 0 && !bwastimejump) {
    playSound(0, #"mpl_plr_emp_deactivate", (0, 0, 0));
  }

  audio::stoploopat("mpl_plr_emp_looper", (0, 0, 0));
}