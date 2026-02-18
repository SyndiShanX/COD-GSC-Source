/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\scriptmodels_shared.gsc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace scriptmodels;

function private autoexec __init__system__() {
  system::register(#"scriptmodels", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  a_script_models = getentarraybytype(6);

  foreach(model in a_script_models) {
    function_9abee270(model);
  }
}

function private function_9abee270(model) {
  assert(isDefined(model));

  if(model.classname != "script_model" && model.classname != "script_brushmodel") {
    return;
  }

  if(isDefined(model.script_health)) {
    model.health = model.script_health;
    model.maxhealth = model.script_health;
    model.takedamage = 1;
  }

  if(is_true(model.var_3ee8e0e2)) {
    model util::make_sentient();
  }

  if(is_true(model.var_5d16ec51)) {
    model function_619a5c20();
  }

  if(isDefined(model.script_team) && model.script_team != "none") {
    model.team = model.script_team;
    model setteam(model.script_team);
  }
}