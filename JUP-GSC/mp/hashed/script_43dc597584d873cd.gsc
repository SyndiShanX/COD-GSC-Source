/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_43dc597584d873cd.gsc
*************************************************/

#using script_7edf952f8921aa6b;
#using scripts\common\callbacks;
#namespace namespace_4c529715eb90d593;

function precache(params) {
  function_366ff0166111a095();
}

function private function_366ff0166111a095() {
  if(isDefined(level.var_b0f7eeee086e2345)) {
    return;
  }

  level.var_b0f7eeee086e2345 = 1;
  level callback::add("set_region_difficulty_manager_speed", &function_f2e9708e3badc502);
}

function private function_f2e9708e3badc502(params) {
  ai = params.ai;

  if(!issubstr(ai.subclass, "zombie_hellhound")) {
    return;
  }

  speed_str = "run";
  archetype = ai getbasearchetype();
  var_2a1d46d92ea44a14 = isDefined(getanimspeedthreshold(archetype, "sprint"));

  if(var_2a1d46d92ea44a14) {
    switch (params.difficulty) {
      case #"hash_7bb2cd766703d463":
        speed_str = "run";
        break;
      case #"hash_af83e47edfa8900a":
        speed_str = "run";
        break;
      case #"hash_5343b465e56ec9a4":
        speed_str = "run";

        if(randomint(100) <= getdvarint(@ "hash_46afd6b17cc032a9", 100)) {
          speed_str = "sprint";
        }

        break;
      case #"hash_651f76c0ad6741ec":
        speed_str = "sprint";
        break;
    }
  }

  ai function_f1e5805da192a1ef(speed_str, params.id, params.priority);
}