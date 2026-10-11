/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_73926eaf280b0b75.gsc
*************************************************/

#using script_5a4a5d9ba343ff8f;
#using scripts\common\callbacks;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#namespace effect_burn;

function burn(durations, damage_percent, damage_cooldowns, attacker, unique_id, kiastring, inflictor, incendiary_rounds, idamage) {
  if(!istrue(self.aisettings.var_994ad2292fc29de6)) {
    return 0;
  }

  burn_effect = function_108973a907c11ca7("burn", durations, unique_id, &start_burn, &end_burn);
  burn_effect.kiastring = kiastring;
  burn_effect.damage_percent = damage_percent;
  burn_effect.damage_cooldowns = damage_cooldowns;
  burn_effect.attacker = attacker;
  burn_effect.inflictor = inflictor;
  burn_effect.var_51357609845cf128 = gettime();
  burn_effect.incendiary_rounds = incendiary_rounds;
  burn_effect.idamage = idamage;
  return start_effect(burn_effect);
}

function private start_burn(var_12c084a213d7ad2) {
  thread tick_burns(var_12c084a213d7ad2);

  if(isDefined(var_12c084a213d7ad2.kiastring) && var_12c084a213d7ad2.kiastring == "napalmburst_kill") {
    ent_flag_set("napalm_burned");
    callback::callback("napalm_burned", var_12c084a213d7ad2);
    return;
  }

  ent_flag_set("burned");
  callback::callback("burned", var_12c084a213d7ad2);
}

function private end_burn(var_12c084a213d7ad2) {
  if(!function_8ce7894f1a52fb77("burn")) {
    if(isDefined(var_12c084a213d7ad2.kiastring) && var_12c084a213d7ad2.kiastring == "napalmburst_kill") {
      ent_flag_clear("napalm_burned");
      callback::callback("napalm_burned_end", var_12c084a213d7ad2);
      return;
    }

    ent_flag_clear("burned");
    callback::callback("burned_end", var_12c084a213d7ad2);
  }
}

function private tick_burns(effect) {
  self notify("start_status_effect_burn_tick");
  self endon("start_status_effect_burn_tick");
  self endon("death");

  while(self.status_effects["burn"].size > 0) {
    foreach(burn_effect in self.status_effects["burn"]) {
      now = gettime();

      if(now < burn_effect.end_time && now >= burn_effect.var_51357609845cf128) {
        burn_effect.var_51357609845cf128 += function_a5b14435e3229bed(burn_effect.damage_cooldowns);

        if(isDefined(burn_effect.incendiary_rounds) && istrue(burn_effect.incendiary_rounds)) {
          damage_amount = max(burn_effect.idamage * burn_effect.damage_percent, 10);
        } else {
          damage_amount = self.maxhealth * burn_effect.damage_percent;
        }

        if(self.health - damage_amount < 1 && isDefined(effect.kiastring)) {
          if(isPlayer(burn_effect.attacker)) {
            scoreeventparams = spawnStruct();
            scoreeventparams.scoreevent = effect.kiastring;
            scoreeventparams.reason = #"kill";
            burn_effect.attacker callback::callback("zombie_score_event", scoreeventparams);
          }
        }

        the_attacker = undefined;

        if(isent(burn_effect.attacker)) {
          the_attacker = burn_effect.attacker;
        }

        inflictor = the_attacker;

        if(isDefined(burn_effect.inflictor)) {
          inflictor = burn_effect.inflictor;
        }

        self dodamage(damage_amount, self.origin, the_attacker, inflictor, "MOD_UNKNOWN", "none", "none", undefined, 65536);
      }

      function_f632348cbb773537(function_b46aef18c1b91ade(), self);
    }
  }
}

function private function_b46aef18c1b91ade() {
  if(!isDefined(level.var_9f85bc34217a22a6)) {
    level.var_9f85bc34217a22a6 = throttle_initialize("status_effect_burn", 2);
  }

  return level.var_9f85bc34217a22a6;
}