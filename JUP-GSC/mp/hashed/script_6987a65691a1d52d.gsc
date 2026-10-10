/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6987a65691a1d52d.gsc
*************************************************/

#using script_4222a2c4ca8b1fae;
#using script_4b28cf746311da43;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#namespace namespace_90db378d21a2e5e2;

function autoexec init() {
  level callback::add("ob_season_main", &main);
}

function main(params) {
  mapname = getmapname();

  if(getdvarint(@ "hash_9a36e5985ae07814", 0)) {
    switch (mapname) {
      case #"hash_2a218509d1620d9d":
      case #"hash_9ae3f9a4f2372775":
        namespace_ef93494119003805::main();
        namespace_c6fb841ce5c974f2::function_852f483c0266f8aa();
        break;
    }
  }

  level callback::remove("ob_season_main", &main);
}