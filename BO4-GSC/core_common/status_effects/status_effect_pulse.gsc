/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\status_effects\status_effect_pulse.gsc
**************************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\system_shared;

#namespace status_effect_pulse;

autoexec __init__system__() {
  system::register(#"status_effect_pulse", &__init__, undefined, undefined);
}

__init__() {
  status_effect::register_status_effect_callback_apply(9, &pulse_apply);
  status_effect::function_5bae5120(9, &pulse_end);
  status_effect::function_6f4eaf88(getstatuseffect("pulse"));
  clientfield::register("toplayer", "pulsed", 1, 1, "int");
  callback::on_spawned(&on_player_spawned);
}

on_player_spawned() {}

pulse_apply(var_756fda07, weapon, applicant) {
  self.owner clientfield::set_to_player("pulsed", 1);
  shutdownpulserebootindicatormenu();
  pulserebootmenu = self.owner openluimenu("EmpRebootIndicator");
  self.owner setluimenudata(pulserebootmenu, #"endtime", int(self.endtime));
  self.owner setluimenudata(pulserebootmenu, #"starttime", int(self.endtime - self.duration));
  self thread pulse_rumble_loop(0.75);
  self.owner setempjammed(1);
}

private pulse_rumble_loop(duration) {
  self endon(#"pulse_rumble_loop");
  self notify(#"pulse_rumble_loop");
  self endon(#"endstatuseffect");
  goaltime = gettime() + int(duration * 1000);

  while(gettime() < goaltime) {
    self.owner playrumbleonentity("damage_heavy");
    waitframe(1);
  }
}

pulse_end() {
  if(isDefined(self)) {
    shutdownpulserebootindicatormenu();

    if(isDefined(level.emp_shared.enemyempactivefunc)) {
      if(self[[level.emp_shared.enemyempactivefunc]]()) {
        return;
      }
    }

    self.owner setempjammed(0);
    self.owner clientfield::set_to_player("pulsed", 0);
  }
}

shutdownpulserebootindicatormenu() {
  emprebootmenu = self.owner getluimenu("EmpRebootIndicator");

  if(isDefined(emprebootmenu)) {
    self.owner closeluimenu(emprebootmenu);
  }
}