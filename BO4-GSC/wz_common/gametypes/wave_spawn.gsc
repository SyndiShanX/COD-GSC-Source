/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\gametypes\wave_spawn.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\death_circle;
#include scripts\core_common\infection;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\system_shared;
#include scripts\wz_common\spawn;

#namespace wave_spawn;

autoexec __init__system__() {
  system::register(#"wave_spawn", &__init__, undefined, undefined);
}

__init__() {
  level.wave_spawn = isDefined(getgametypesetting(#"wzenablewaverespawn")) ? getgametypesetting(#"wzenablewaverespawn") : 0;

  if(level.wave_spawn) {
    level.takelivesondeath = 1;
    level.var_a5f54d9f = 1;
    level callback::add_callback(#"hash_e702d557e24bb6", &function_a7ed6d54);
    level callback::add_callback(#"hash_3be1213f454fa90e", &function_301b775b);
    level callback::add_callback(#"hash_7fc21de2eaebdb3b", &function_832ecb3d);
    level callback::add_callback(#"hash_405e46788e83af41", &function_1540761c);
    level callback::add_callback(#"hash_7912e21750e4010d", &function_a27362d0);
    level callback::on_player_killed(&function_14a68e0b);
  }
}

function_301b775b() {
  if(clientfield::can_set("hudItems.warzone.waveRespawnTimer")) {
    time = int(gettime() + int(level.waverespawndelay * 1000));
    level clientfield::set_world_uimodel("hudItems.warzone.waveRespawnTimer", time);
  }
}

private function_a27362d0(params) {
  if(level.deathcircleindex >= level.deathcircles.size - 2) {
    foreach(player in getplayers()) {
      if(isDefined(player) && !infection::function_74650d7()) {
        player clientfield::set_player_uimodel("hudItems.playerCanRedeploy", 0);
      }

      player thread function_ca1398a7();
    }
  }
}

function_ca1398a7() {
  if(!isplayer(self)) {
    return;
  }

  self endon(#"disconnect");

  if(!isDefined(self.pers) || !isDefined(self.pers[#"lives"])) {
    return;
  }

  weapon = getweapon(#"bare_hands");
  count = 0;
  lives = self.pers[#"lives"] - 1;

  while(count < lives && isDefined(self)) {
    count++;
    scoreevents::processscoreevent(#"redeploy_bonus", self, undefined, weapon);
  }
}

function_1540761c(params) {
  if(!level.var_d8958e58 || level.deathcircles.size <= 0) {
    return;
  }

  if(infection::function_74650d7()) {
    return;
  }

  time = death_circle::function_49443399();
  level.var_75db41a7 = gettime() + int((time - level.waverespawndelay) * 1000);
}

function_832ecb3d(params) {
  foreach(player in getplayers()) {
    player clientfield::set_player_uimodel("hudItems.playerCanRedeploy", 0);
  }
}

function_a7ed6d54(params) {
  player = params.player;

  if(isDefined(player) && isDefined(player.pers) && isDefined(player.pers[#"lives"])) {
    player spawn::function_1390f875(player.pers[#"lives"]);
  }
}

private function_14a68e0b() {
  if(isDefined(level.var_1766510) && level.var_1766510) {
    return;
  }

  level.var_1766510 = 1;
  wavedelay = level.waverespawndelay;

  if(wavedelay) {
    foreach(team, _ in level.teams) {
      level.wavedelay[team] = wavedelay;
      level.lastwave[team] = 0;
    }

    level thread[[level.wavespawntimer]]();
    level clientfield::set_world_uimodel("hudItems.warzone.collapseCount", level.deathcircles.size - 1);
  }
}