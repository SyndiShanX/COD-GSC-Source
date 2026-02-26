/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\killstreaks.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreak_detect;
#using scripts\killstreaks\killstreak_vehicle;
#using scripts\killstreaks\killstreaks_shared;
#namespace killstreaks;

function private autoexec __init__system__() {
  system::register(#"killstreaks", &preinit, undefined, undefined, #"renderoverridebundle");
}

function private preinit() {
  init_shared();
  killstreak_vehicle::init();
  killstreak_detect::init_shared();
  function_f1707039();
}

function private function_f1707039() {
  level.var_4b42d599 = [];

  for(i = 0; i < 4; i++) {
    level.var_4b42d599[i] = "killstreaks.killstreak" + i + ".inUse";
    clientfield::register_clientuimodel(level.var_4b42d599[i], #"killstreak_rewards", [#"killstreak" + (isDefined(i) ? "" + i : ""), #"inuse"], 1, 1, "int", undefined, 0, 0);
  }

  level.var_46b33f90 = [];
  level.var_ce69c3cb = [];
  level.var_a0d81b28 = max(8, 4);

  for(i = 0; i < level.var_a0d81b28; i++) {
    level.var_46b33f90[i] = "killstreaks.killstreak" + i + ".spaceFull";
    clientfield::register_clientuimodel(level.var_46b33f90[i], #"killstreak_rewards", [#"killstreak" + (isDefined(i) ? "" + i : ""), #"spacefull"], 1, 1, "int", undefined, 0, 0);
    level.var_ce69c3cb[i] = "killstreaks.killstreak" + i + ".noTargets";
    clientfield::register_clientuimodel(level.var_ce69c3cb[i], #"killstreak_rewards", [#"killstreak" + (isDefined(i) ? "" + i : ""), #"notargets"], 1, 1, "int", undefined, 0, 0);
  }
}