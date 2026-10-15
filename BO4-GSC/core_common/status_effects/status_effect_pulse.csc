/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\status_effects\status_effect_pulse.csc
**************************************************************/

#include scripts\core_common\audio_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\filter_shared;
#include scripts\core_common\system_shared;

#namespace status_effect_pulse;

autoexec __init__system__() {
  system::register(#"status_effect_pulse", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("toplayer", "pulsed", 1, 1, "int", &on_pulsed_change, 0, 0);
}

on_pulsed_change(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  localplayer = function_5c10bd79(localclientnum);

  if(newval == 1) {
    self start_pulse_effects(localplayer);
    return;
  }

  self stop_pulse_effects(localplayer, oldval);
}

start_pulse_effects(localplayer, bwastimejump = 0) {
  filter::init_filter_tactical(localplayer);
  filter::enable_filter_tactical(localplayer, 2);
  filter::set_filter_tactical_amount(localplayer, 2, 1);

  if(!bwastimejump) {
    playSound(0, #"mpl_plr_emp_activate", (0, 0, 0));
  }

  audio::playloopat("mpl_plr_emp_looper", (0, 0, 0));
}

stop_pulse_effects(localplayer, oldval, bwastimejump = 0) {
  filter::init_filter_tactical(localplayer);
  filter::disable_filter_tactical(localplayer, 2);

  if(oldval != 0 && !bwastimejump) {
    playSound(0, #"mpl_plr_emp_deactivate", (0, 0, 0));
  }

  audio::stoploopat("mpl_plr_emp_looper", (0, 0, 0));
}