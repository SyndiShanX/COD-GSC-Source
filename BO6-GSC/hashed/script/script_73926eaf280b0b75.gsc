/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_73926eaf280b0b75.gsc
*****************************************************/

#using script_16ea1b94f0f381b3;
#using script_5a4a5d9ba343ff8f;
#using scripts\common\callbacks;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#namespace effect_burn;

function burn(durations, damage, damage_cooldowns, attacker, unique_id, var_73f0860b41bbe58e, inflictor, element_type) {
  if(!istrue(self.aisettings.var_76c31c940263ebc3)) {
    return false;
  }

  burn_effect = status_effects::function_1c3c4f0aa9a6109a("\x9d\xd1\xde\xa4", durations, unique_id, &start_burn, &end_burn, element_type);
  burn_effect.var_73f0860b41bbe58e = var_73f0860b41bbe58e;
  burn_effect.damage = damage;
  burn_effect.damage_cooldowns = damage_cooldowns;
  burn_effect.attacker = attacker;
  burn_effect.inflictor = inflictor;
  burn_effect.var_a5ded3408cb8d91d = gettime();

  if(isDefined(burn_effect.inflictor) && isDefined(burn_effect.inflictor.weapon_name) && issubstr(burn_effect.inflictor.weapon_name, "\x8cX\xc9[\xf5aet\xa1\xac\xc9")) {
    burn_effect.str_variant = "&u\xb8,\x1b0\x17";
  }

  if(isPlayer(attacker) && element_type == "\xcciN\xca") {
    if(!isDefined(unique_id) || !status_effects::function_94a7f44187606b85("\x9d\xd1\xde\xa4", unique_id)) {
      attacker namespace_bc7cdace2d7445a5::doscoreeventsharedfunc(#"ignited");
    }
  }

  return status_effects::start_effect(burn_effect);
}

function private start_burn(var_a7061771933941b) {
  thread tick_burns(var_a7061771933941b);

  if(isDefined(var_a7061771933941b.var_73f0860b41bbe58e) && var_a7061771933941b.var_73f0860b41bbe58e == "Y\xdb\xe2D\xce\x86u") {
    utility::ent_flag_set("\xd5\a\xda\xad\t\xe0\xe4\x1c\x9b\xa6\xa0A\x85");
    callback::callback("\xd5\a\xda\xad\t\xe0\xe4\x1c\x9b\xa6\xa0A\x85", var_a7061771933941b);
    return;
  }

  str_variant = var_a7061771933941b.str_variant ?? "";
  utility::ent_flag_set("\xdd\x9bqI\xad\x83" + str_variant);
  callback::callback("\xdd\x9bqI\xad\x83", var_a7061771933941b);
}

function private end_burn(var_a7061771933941b) {
  if(!status_effects::function_49f84c53a7f39086("\x9d\xd1\xde\xa4")) {
    if(isDefined(var_a7061771933941b.var_73f0860b41bbe58e) && var_a7061771933941b.var_73f0860b41bbe58e == "Y\xdb\xe2D\xce\x86u") {
      utility::ent_flag_clear("\xd5\a\xda\xad\t\xe0\xe4\x1c\x9b\xa6\xa0A\x85");
      callback::callback("\x0e\xc5\xcc\xbe\"o\xfb:\xce\xaeJLY\xfc\xb6\xc2\x1e", var_a7061771933941b);
    } else {
      utility::ent_flag_clear("\xdd\x9bqI\xad\x83");
      callback::callback("E\xcf}\xcb\x8a\xe4\xb2!\x12\xdf", var_a7061771933941b);
    }
  }

  self.var_c7be24b6392fb80d = undefined;
}

function private tick_burns(effect) {
  self notify("\xdc\x8e\xb0\x93\x1d\xbes\x1d\xb0\xa3\xae\xdc\xf5Y\x99\xcc\xb2\xd8\xa3\xd71\xea\xc97\xaft\xd2cm");
  self endon("\xdc\x8e\xb0\x93\x1d\xbes\x1d\xb0\xa3\xae\xdc\xf5Y\x99\xcc\xb2\xd8\xa3\xd71\xea\xc97\xaft\xd2cm");
  self endon("\x1e\xfd\xd1\xa2\a");

  while(self.status_effects["\x9d\xd1\xde\xa4"].size > 0) {
    foreach(burn_effect in self.status_effects["\x9d\xd1\xde\xa4"]) {
      now = gettime();

      if(now < burn_effect.end_time && now >= burn_effect.var_a5ded3408cb8d91d) {
        burn_effect.var_a5ded3408cb8d91d += utility::function_fe771e2bf31fa2fc(burn_effect.damage_cooldowns);
        damage_amount = burn_effect.damage;
        callback::callback("\x98\xab\xc9n\xaf\x8e-6\xd6", effect);

        if(self.health - damage_amount < 1 && isDefined(effect.var_73f0860b41bbe58e)) {
          self.var_953519ca90831e0a = effect.var_73f0860b41bbe58e;
        }

        the_attacker = undefined;

        if(isent(burn_effect.attacker)) {
          the_attacker = burn_effect.attacker;
        }

        inflictor = the_attacker;

        if(isDefined(burn_effect.inflictor)) {
          inflictor = burn_effect.inflictor;
        }

        self.var_4310699a6abf8741 = gettime();
        self dodamage(damage_amount, self.origin, the_attacker, inflictor, "\bP\xb2h\\\xd7\x04\b\xcb\x87\v\xce\xec\xdaI\xb4\x98\xdf", "\x1b\x98\xbc\n\x19\xb4[\x18\xd6D0C\xb5\xb0`\xaa\"\xcf\xf1\xb9", "\r+x5", undefined, 4259840);
      }

      throttle::function_33b7d60bed350fee(function_c2ba1da5a60c25d3(), self);
    }
  }
}

function private function_c2ba1da5a60c25d3() {
  if(!isDefined(level.var_17a954fe923705e7)) {
    level.var_17a954fe923705e7 = throttle::throttle_initialize("=)\x8a\xdb\xf3\x04Py\x99v\xda\xa1\xd3\f\xa3\xc1\x19r", 2);
  }

  return level.var_17a954fe923705e7;
}