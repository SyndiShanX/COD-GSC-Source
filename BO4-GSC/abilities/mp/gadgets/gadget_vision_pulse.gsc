/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\mp\gadgets\gadget_vision_pulse.gsc
********************************************************/

#include scripts\abilities\gadgets\gadget_vision_pulse;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\gametypes\battlechatter;
#include scripts\mp_common\util;

#namespace gadget_vision_pulse;

autoexec __init__system__() {
  system::register(#"gadget_vision_pulse", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
  function_f5632baf(&function_fc3478b7);
  level.var_392ddea = &awardscore;
}

function_aad9199e(pulsedenemy) {
  pulsedenemy notify(#"hash_7dc65ec6fe251daf");
  pulsedenemy endon(#"hash_7dc65ec6fe251daf", #"death", #"disconnect");
  wait float(level.weaponvisionpulse.var_9d776ba6) / 1000;

  if(isDefined(pulsedenemy)) {
    pulsedenemy.ispulsed = 0;
    pulsedenemy.var_5379bee8 = undefined;
  }
}

function_fc3478b7(pulsedenemy) {
  self battlechatter::function_bd715920(getweapon(#"gadget_vision_pulse"), pulsedenemy, pulsedenemy.origin, self, 2);
  pulsedenemy.ispulsed = 1;
  pulsedenemy.var_5379bee8 = self;
  thread function_aad9199e(pulsedenemy);
}

function_c0520f6f(victim, waittime) {
  self endon(#"disconnect", #"death", #"emp_vp_jammed");
  wait float(waittime) / 1000;

  if(isalive(victim)) {
    scoreevents::processscoreevent(#"hash_5fa940b319171088", self, victim, level.weaponvisionpulse);
  }
}

awardscore() {
  self endon(#"disconnect", #"death", #"emp_vp_jammed");
  waittime = level.weaponvisionpulse.gadget_pulse_duration / 3;
  radius = level.weaponvisionpulse.gadget_pulse_max_range;

  for(i = 0; i < 3; i++) {
    enemyteam = getplayers("all", self.origin, radius);

    if(isarray(enemyteam)) {
      foreach(enemy in enemyteam) {
        if(!util::isenemyplayer(enemy)) {
          continue;
        }

        if(isalive(enemy)) {
          var_bf11ed35 = distance2d(self.origin, enemy.origin);

          if(var_bf11ed35 > level.weaponvisionpulse.gadget_pulse_max_range) {
            continue;
          }

          timetotarget = var_bf11ed35 / level.weaponvisionpulse.var_f9eec1ec;
          self thread function_c0520f6f(enemy, timetotarget);
        }
      }
    }

    wait float(waittime) / 1000;
  }
}