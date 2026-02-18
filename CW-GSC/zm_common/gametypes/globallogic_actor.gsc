/*****************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\globallogic_actor.gsc
*****************************************************/

#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\globallogic\globallogic_player;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\zm_common\bb;
#using scripts\zm_common\gametypes\globallogic_player;
#using scripts\zm_common\gametypes\globallogic_utils;
#namespace globallogic_actor;

function callback_actorspawned(spawner) {
  self thread spawner::spawn_think(spawner);
  bb::logaispawn(self, spawner);
}

function callback_actorcloned(original) {
  destructserverutils::copydestructstate(original, self);
  gibserverutils::copygibstate(original, self);
}