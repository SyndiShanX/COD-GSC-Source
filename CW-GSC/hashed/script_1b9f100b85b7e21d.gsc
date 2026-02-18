/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1b9f100b85b7e21d.gsc
***********************************************/

#using script_3dc93ca9902a9cda;
#using scripts\cp_common\snd;
#namespace snd;

function function_9ae4fc6f(soundalias, targets) {
  return play(soundalias, targets);
}

function function_4286bd2c(soundobject, fadeoutseconds) {
  stop(soundobject, fadeoutseconds);
}

function function_2e9b6265(soundobject, levelnotifystring, fadeoutseconds) {
  function_d4e10f97(soundobject, levelnotifystring, fadeoutseconds);
}

function function_b33d1cfe(soundobject, volume, timeinseconds) {
  set_volume(soundobject, volume, timeinseconds);
}