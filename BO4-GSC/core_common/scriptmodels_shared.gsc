/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\scriptmodels_shared.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace scriptmodels;

autoexec __init__system__() {
  system::register(#"scriptmodels", &__init__, undefined, undefined);
}

__init__() {
  a_script_models = getentarraybytype(6);

  foreach(model in a_script_models) {
    function_9abee270(model);
  }
}

private function_9abee270(model) {
  assert(isDefined(model));

  if(model.classname != "script_model" && model.classname != "script_brushmodel") {
    return;
  }

  if(isDefined(model.script_health)) {
    model.health = model.script_health;
    model.maxhealth = model.script_health;
    model.takedamage = 1;
  }

  if(isDefined(model.script_makesentient) && model.script_makesentient) {
    model util::make_sentient();
  }

  if(isDefined(model.script_team) && model.script_team != "none") {
    model.team = model.script_team;
    model setteam(model.script_team);
  }
}