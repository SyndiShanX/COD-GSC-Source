/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\globallogic_actor.gsc
*****************************************************/

#include scripts\core_common\ai\systems\destructible_character;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\challenges_shared;
#include scripts\core_common\globallogic\globallogic_player;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\struct;
#include scripts\zm_common\bb;
#include scripts\zm_common\gametypes\globallogic_player;
#include scripts\zm_common\gametypes\globallogic_utils;

#namespace globallogic_actor;

callback_actorspawned(spawner) {
  self thread spawner::spawn_think(spawner);
  bb::logaispawn(self, spawner);
}

callback_actorcloned(original) {
  destructserverutils::copydestructstate(original, self);
  gibserverutils::copygibstate(original, self);
}