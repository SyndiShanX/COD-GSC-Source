/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\doa.gsc
***********************************************/

#using script_774302f762d76254;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\globallogic\globallogic_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\zm_gametype;
#namespace doa;

function autoexec function_aeb1baea() {
  level.var_f18a6bd6 = &function_5e443ed1;
  waittillframeend();
  level.var_f18a6bd6 = &function_5e443ed1;
}

function event_handler[gametype_init] main(eventstruct) {
  level.var_6877b1e9 = 1;
  zm_gametype::main();
  level.var_26be8a4f = 1;
  level.onspawnplayerunified = undefined;
  level.onspawnplayer = &spawning::onspawnplayer;
  level.onplayerdisconnect = &globallogic::blank;
  callback::on_spawned(&on_player_spawned);
  level thread namespace_4dae815d::init();
}

function function_5e443ed1() {
  level._loadstarted = 1;
  level.takelivesondeath = 0;
  level thread onallplayersready();
  level.aitriggerspawnflags = getaitriggerflags();
  level.vehicletriggerspawnflags = getvehicletriggerflags();
  level.var_82dda526 = 1;
  level.var_869c7fba = 1;
  level.teambased = 0;
  level.defaultclass = "CLASS_CUSTOM1";
  level.weaponnone = getweapon(#"none");
  level.weaponnull = getweapon(#"weapon_null");
  level.numlives = 1;
  level.custommayspawnlogic = &mayspawn;
  level.graceperiod = 1410065407;
  system::function_c11b0642();
  level flag::set(#"load_main_complete");
}

function mayspawn() {
  return true;
}

function onallplayersready() {
  level endon(#"game_ended");

  while(!getnumexpectedplayers(1)) {
    wait 0.1;
  }

  level.var_3fd55ae0 = 0;
  level.var_5c6783e9 = getnumexpectedplayers(1);
  player_count_actual = 0;

  while(player_count_actual < getnumexpectedplayers(1)) {
    players = getplayers();
    player_count_actual = 0;

    foreach(player in players) {
      player.var_200b0850 = 1;

      if((player.sessionstate == "playing" || player.sessionstate == "spectator") && !isbot(player)) {
        player_count_actual++;
      }
    }

    println("<dev string:x38>" + getnumconnectedplayers() + "<dev string:x52>" + getnumexpectedplayers(1));
    wait 0.1;
  }

  setinitialplayersconnected();
  level flag::set("all_players_connected");
  function_9a8ab40f();
  level util::streamer_wait();
  level flag::set("gameplay_started");
  level clientfield::set("gameplay_started", 1);
}

function function_d797f41f(n_waittime = 1) {
  wait n_waittime;
  music::setmusicstate("none");
}

function function_9a8ab40f() {
  do {
    wait 0.1;
    var_183929a8 = 0;
    a_players = getplayers();

    foreach(player in a_players) {
      if(!player isloadingcinematicplaying()) {
        var_183929a8++;
      }
    }
  }
  while(a_players.size > var_183929a8);
}

function on_player_spawned() {
  self val::reset(#"hash_5bb0dd6b277fc20c", "freezecontrols");
  self val::reset(#"hash_5bb0dd6b277fc20c", "disablegadgets");
}

function default_onspawnspectator(origin, angles) {
  if(isDefined(origin) && isDefined(angles)) {
    self spawn(origin, angles);
    return;
  }

  if(isDefined(level.doa.var_39e3fa99)) {
    spawnpoint = [[level.doa.var_39e3fa99]] - > getcenter();
  } else {
    arenas = struct::get_array("arena_center", "targetname");
    spawnpoint = arenas[0];
  }

  self spawn(spawnpoint.origin, spawnpoint.angles);
}