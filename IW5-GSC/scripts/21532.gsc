/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\21532.gsc
**************************************/

main() {
  _id_5402();
  _id_3DBB();
}

#using_animtree("generic_human");

_id_5402() {
  level._id_0C59["generic"]["patrol_turn180"] = % patrol_bored_2_walk_180turn;
  level._id_0C59["generic"]["_stealth_patrol_jog"] = % patrol_jog;
  level._id_0C59["generic"]["_stealth_patrol_walk"] = % patrol_bored_patrolwalk;
  level._id_0C59["generic"]["_stealth_combat_jog"] = % combat_jog;
  level._id_0C59["generic"]["_stealth_patrol_cqb"] = % walk_cqb_f;

  if(!isDefined(level._id_0C59["generic"]["_stealth_patrol_search_a"])) {
    level._id_0C59["generic"]["_stealth_patrol_search_a"] = % patrol_boredwalk_lookcycle_a;
    level._id_0C59["generic"]["_stealth_patrol_search_b"] = % patrol_boredwalk_lookcycle_b;
  }

  level._id_0C59["generic"]["_stealth_behavior_spotted_short"] = % exposed_idle_twitch_v4;
  level._id_0C59["generic"]["_stealth_behavior_spotted_long"] = % patrol_bored_react_walkstop_short;
  level._id_0C59["generic"]["_stealth_look_around"][0] = % patrol_bored_react_look_v1;
  level._id_0C59["generic"]["_stealth_look_around"][1] = % patrol_bored_react_look_v2;
  level._id_0C59["generic"]["_stealth_behavior_saw_corpse"] = % exposed_idle_twitch_v4;
  level._id_0C59["generic"]["_stealth_behavior_generic1"] = % patrol_bored_react_look_advance;
  level._id_0C59["generic"]["_stealth_behavior_generic2"] = % patrol_bored_react_look_retreat;
  level._id_0C59["generic"]["_stealth_behavior_generic3"] = % patrol_bored_react_walkstop;
  level._id_0C59["generic"]["_stealth_behavior_generic4"] = % patrol_bored_react_walkstop_short;
  level._id_0C59["generic"]["_stealth_find_jog"] = % patrol_boredjog_find;
  level._id_0C59["generic"]["_stealth_find_stand"] = % patrol_bored_react_look_v2;
  level._id_0C59["generic"]["_stealth_prone_idle"][0] = % prone_aim_idle;
  level._id_0C59["generic"]["_stealth_prone_stop"] = % prone_crawl_2_prone;
  level._id_0C59["generic"]["_stealth_prone_start"] = % prone_2_prone_crawl;
  level._id_0C59["generic"]["_stealth_prone_2_run_roll"] = % hunted_pronehide_2_stand_v4;
}

#using_animtree("dog");

_id_3DBB() {
  level._id_0C59["generic"]["_stealth_dog_sleeping"][0] = % german_shepherd_sleeping;
  level._id_0C59["generic"]["_stealth_dog_stop"] = % german_shepherd_run_stop;
  level._id_0C59["generic"]["_stealth_dog_find"] = % german_shepherd_run_flashbang_b;
  level._id_0C59["generic"]["_stealth_dog_howl"] = % german_shepherd_attackidle_bark;
  level._id_0C59["generic"]["_stealth_dog_saw_corpse"] = % german_shepherd_attackidle_bark;
  level._id_0C59["generic"]["_stealth_dog_growl"] = % german_shepherd_attackidle_growl;
  level._id_0C59["generic"]["_stealth_dog_wakeup_fast"] = % german_shepherd_wakeup_fast;
  level._id_0C59["generic"]["_stealth_dog_wakeup_slow"] = % german_shepherd_wakeup_slow;
}