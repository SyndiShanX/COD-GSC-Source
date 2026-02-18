/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\sound_shared.csc
***********************************************/

#using script_71463f7d72636705;
#namespace sound;

function loop_fx_sound(clientnum, alias, origin, ender) {
  sound_entity = spawn(clientnum, origin, "script_origin");

  if(isDefined(ender)) {
    thread loop_delete(ender, sound_entity);
    self endon(ender);
  }

  sound_entity playLoopSound(alias);
}

function play_in_space(localclientnum, alias, origin) {
  playSound(localclientnum, alias, origin);
}

function loop_delete(ender, sound_entity) {
  self waittill(ender);
  sound_entity delete();
}

function play_on_client(sound_alias) {
  players = level.localplayers;
  playSound(0, sound_alias, players[0].origin);
}

function loop_on_client(sound_alias, min_delay, max_delay, end_on) {
  players = level.localplayers;

  if(isDefined(end_on)) {
    level endon(end_on);
  }

  for(;;) {
    play_on_client(sound_alias);
    wait min_delay + randomfloat(max_delay);
  }
}