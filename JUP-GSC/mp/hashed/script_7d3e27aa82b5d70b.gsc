/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7d3e27aa82b5d70b.gsc
*************************************************/

#using scripts\engine\utility;
#namespace namespace_22b8ba12655bf3f2;

function function_40eca5c2157229bc(var_641ab1823a1b7739) {
  level.starting_health = [];
  level.var_42ae29d27de070cb = var_641ab1823a1b7739;
  registersharedfunc("zombie", "health_scaling_get_starting_health", &get_starting_health);
}

function get_starting_health(scriptbundle_name, current_round) {
  if(!isDefined(level.starting_health[scriptbundle_name])) {
    level.starting_health[scriptbundle_name] = [];
  }

  if(!isDefined(level.starting_health[scriptbundle_name][current_round])) {
    health_bundle = getscriptbundle("healthscalinground:" + scriptbundle_name);
    assert(isDefined(health_bundle));

    if(isDefined(health_bundle.basehealth)) {
      self.basehealth = health_bundle.basehealth;
    }

    var_fe0aad7efc61fcae = health_bundle.var_5fa2f1ef669d2826;
    base = default_to(self.basehealth, 100);
    max = default_to(health_bundle.maxhealth, base);
    var_3edf6b4eb93f6f0d = health_bundle.var_de69a4842af7b496;
    result_health = base;

    if(current_round > 1 && isDefined(var_fe0aad7efc61fcae)) {
      for(i = 0; i < var_fe0aad7efc61fcae.size; i++) {
        if(current_round >= var_fe0aad7efc61fcae[i].startround) {
          var_817124607074ae8c = var_fe0aad7efc61fcae[i].var_d9a25092bed9b107;

          if(isDefined(var_fe0aad7efc61fcae[i + 1]) && current_round >= var_fe0aad7efc61fcae[i + 1].startround) {
            health_rounds = var_fe0aad7efc61fcae[i + 1].startround - var_fe0aad7efc61fcae[i].startround;
          } else {
            health_rounds = current_round - var_fe0aad7efc61fcae[i].startround;
          }

          result_health += var_817124607074ae8c * health_rounds;
          continue;
        }

        break;
      }
    }

    if(result_health > max) {
      result_health = max;
    }

    num_players = default_to(level.var_42ae29d27de070cb, level.players.size);

    if(isDefined(var_3edf6b4eb93f6f0d) && num_players > 1) {
      result_health += result_health * (num_players - 1) * var_3edf6b4eb93f6f0d;
    }

    var_4f78eba89f55a51e = 10;

    if(level.starting_health[scriptbundle_name].size >= var_4f78eba89f55a51e) {
      level.starting_health[scriptbundle_name] = [];
    }

    level.starting_health[scriptbundle_name][current_round] = int(result_health);
  }

  return level.starting_health[scriptbundle_name][current_round];
}

function function_9102c548055a3813(scriptbundle_name, n_round) {
  health_bundle = getscriptbundle("healthscalinground:" + scriptbundle_name);
  assert(isDefined(health_bundle));
  var_fe0aad7efc61fcae = health_bundle.var_5fa2f1ef669d2826;
  base = default_to(self.basehealth, 100);
  max = default_to(health_bundle.maxhealth, base);
  var_3edf6b4eb93f6f0d = health_bundle.var_de69a4842af7b496;
  result_health = base;
  var_30d177f7b4f9f195 = 1;
  n_index = 0;

  while(var_30d177f7b4f9f195 < n_round) {
    if(isDefined(var_fe0aad7efc61fcae[n_index + 1].startround) && var_30d177f7b4f9f195 >= var_fe0aad7efc61fcae[n_index + 1].startround) {
      n_index++;
    }

    if(isDefined(var_fe0aad7efc61fcae[n_index].var_d9a25092bed9b107)) {
      result_health += var_fe0aad7efc61fcae[n_index].var_d9a25092bed9b107;
    }

    var_30d177f7b4f9f195++;
  }

  if(isDefined(max) && result_health > max) {
    result_health = max;
  }

  num_players = isDefined(level.var_42ae29d27de070cb) ? level.var_42ae29d27de070cb : level.players.size;

  if(isDefined(level.var_385ecf1850057d71)) {
    if([[level.var_385ecf1850057d71]](self)) {
      num_players = level.players.size;
    } else {
      num_players = isDefined(level.var_42ae29d27de070cb) ? level.var_42ae29d27de070cb : 1;
    }
  }

  if(isDefined(var_3edf6b4eb93f6f0d) && num_players > 1) {
    result_health += result_health * (num_players - 1) * var_3edf6b4eb93f6f0d;
  }

  return int(result_health);
}

function function_b7b826409f989600() {
  level.var_42ae29d27de070cb = undefined;
}

function function_d589c49c4b9b50a0(func) {
  level.var_385ecf1850057d71 = func;
}