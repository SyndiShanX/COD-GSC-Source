/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\cheat.gsc
***********************************************/

#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#namespace cheat;

function private autoexec __init__system__() {
  system::register(#"cheat", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.var_62079b93 = [];
  level.var_6722c38a = [];
  level.var_8c80c829 = [];
  level flag::init("has_cheated");
  level thread death_monitor();
}

function player_init() {
  self thread function_ae608e1a();
}

function death_monitor() {
  function_e380068d();
}

function function_e380068d() {
  for(index = 0; index < level.var_8c80c829.size; index++) {
    setDvar(level.var_8c80c829[index], level.var_62079b93[level.var_8c80c829[index]]);
  }
}

function function_8fb30e85(var_db66e5f5, var_beef13ae) {
  setDvar(var_db66e5f5, 0);

  level.var_62079b93[var_db66e5f5] = getdvarint(var_db66e5f5, 0);
  level.var_6722c38a[var_db66e5f5] = var_beef13ae;

  if(level.var_62079b93[var_db66e5f5]) {
    [[var_beef13ae]](level.var_62079b93[var_db66e5f5]);
  }
}

function function_7f7b42b7(var_db66e5f5) {
  var_d8568d2f = getdvarint(var_db66e5f5, 0);

  if(level.var_62079b93[var_db66e5f5] == var_d8568d2f) {
    return;
  }

  if(var_d8568d2f) {
    level flag::set("has_cheated");
  }

  level.var_62079b93[var_db66e5f5] = var_d8568d2f;
  [[level.var_6722c38a[var_db66e5f5]]](var_d8568d2f);
}

function function_ae608e1a() {
  level endon(#"unloaded");
  function_8fb30e85("sf_use_ignoreammo", &function_b68f06ea);
  level.var_8c80c829 = getarraykeys(level.var_62079b93);

  for(;;) {
    for(index = 0; index < level.var_8c80c829.size; index++) {
      function_7f7b42b7(level.var_8c80c829[index]);
    }

    wait 0.5;
  }
}

function function_b68f06ea(var_d8568d2f) {
  if(var_d8568d2f) {
    setsaveddvar(#"player_sustainammo", 1);
    return;
  }

  setsaveddvar(#"player_sustainammo", 0);
}

function is_cheating() {
  return level flag::get("has_cheated");
}