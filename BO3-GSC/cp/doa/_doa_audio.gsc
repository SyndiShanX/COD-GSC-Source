/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\doa\_doa_audio.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\doa\_doa_arena;
#using scripts\cp\doa\_doa_player_utility;
#using scripts\cp\doa\_doa_utility;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\music_shared;
#using scripts\shared\util_shared;
#namespace namespace_b5c133c;

function init() {
  function_4bbc3ecf();
  level thread musicsystem();
}

function musicsystem() {
  musicent = spawn("script_origin", (0, 0, 0));
  while(true) {
    level waittill("hash_ba37290e", type);
    if(!isDefined(type)) {
      type = namespace_3ca3c537::function_d2d75f5d();
      level thread function_1a5a0c78();
    }
    if(!isDefined(level.var_d068d66e[type])) {
      continue;
    }
    music::setmusicstate(level.var_d068d66e[type]);
  }
}

function function_4bbc3ecf() {
  function_2f2996ee("island", "slight_chance_of_zombies");
  function_2f2996ee("dock", "poison_mushroom");
  function_2f2996ee("farm", "clockwork_squares");
  function_2f2996ee("graveyard", "cominghome");
  function_2f2996ee("temple", "abra_macabre");
  function_2f2996ee("safehouse", "death_on_the_dancefloor");
  function_2f2996ee("blood", "twilight");
  function_2f2996ee("cave", "temple");
  function_2f2996ee("vengeance", "raining_teddybears");
  function_2f2996ee("sgen", "slasher_flick");
  function_2f2996ee("apartments", "laughing_corpses");
  function_2f2996ee("sector", "abra_macabre");
  function_2f2996ee("metro", "clockwork_squares");
  function_2f2996ee("clearing", "poison_mushroom");
  function_2f2996ee("newworld", "cominghome");
  function_2f2996ee("boss", "raining_teddybears");
  function_2f2996ee("fate", "voices");
  function_2f2996ee("armory", "laughing_corpses");
  function_2f2996ee("bomb_storage", "laughing_corpses");
  function_2f2996ee("hangar", "laughing_corpses");
  function_2f2996ee("coop", "laughing_corpses");
  function_2f2996ee("vault", "laughing_corpses");
  function_2f2996ee("mystic_armory", "laughing_corpses");
  function_2f2996ee("mine", "laughing_corpses");
  function_2f2996ee("wolfhole", "laughing_corpses");
  function_2f2996ee("challenge", "115_riddles");
  function_2f2996ee("truck_soccer", "115_riddles");
  function_2f2996ee("tankmaze", "115_riddles");
  function_2f2996ee("spiral", "115_riddles");
  function_2f2996ee("redins", "115_riddles");
  function_2f2996ee("bossbattle", "boss");
  function_2f2996ee("righteous", "boss");
  function_2f2996ee("arenatransition", "level_transition");
  function_2f2996ee("gameover", "zombies_dont_surf");
}

function function_2f2996ee(var_82a18d17, state) {
  if(!isDefined(level.var_d068d66e)) {
    level.var_d068d66e = array();
  }
  level.var_d068d66e[var_82a18d17] = state;
}

function function_1a5a0c78() {
  if(!isDefined(level.var_7f30be2b)) {
    level.var_7f30be2b = 0;
  }
  if(level.var_7f30be2b >= 3) {
    return;
  }
  unlockname = undefined;
  switch (level.var_7f30be2b) {
    case 0: {
      unlockname = "mus_poison_mushroom_oneshot_intro";
      break;
    }
    case 1: {
      unlockname = "mus_115_riddles_oneshot_intro";
      break;
    }
    case 2: {
      unlockname = "mus_clockwork_squares_oneshot_intro";
      break;
    }
  }
  if(isDefined(unlockname)) {
    level thread audio::unlockfrontendmusic(unlockname);
  }
  level.var_7f30be2b++;
}