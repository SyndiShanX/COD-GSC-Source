/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\cp\weaponobjects.gsc
***********************************************/

#using script_6b221588ece2c4aa;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\weapons\weaponobjects;
#namespace weaponobjects;

function private autoexec __init__system__() {
  system::register(#"weaponobjects", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
  callback::on_start_gametype(&start_gametype);
}

function start_gametype() {
  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
  function_e6400478(#"hash_493ab450d6d8d4fa", &function_50d4198b, 1);
}

function on_player_spawned() {
  for(watcher = 0; watcher < self.weaponobjectwatcherarray.size; watcher++) {
    if(self.weaponobjectwatcherarray[watcher].name == # "spike_charge") {
      arrayremoveindex(self.weaponobjectwatcherarray, watcher);
    }
  }

  self createwatcher("spike_launcher", &createspikelauncherwatcher, 1);
}