/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\cp\helicopter.gsc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\killstreaks\helicopter_shared;
#using scripts\killstreaks\killstreaks_shared;
#namespace helicopter;

function private autoexec __init__system__() {
  system::register(#"helicopter", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
    killstreaks::register_killstreak("killstreak_helicopter_comlink" + "_cp", &usekillstreakhelicopter);
  }

  init_shared();
}