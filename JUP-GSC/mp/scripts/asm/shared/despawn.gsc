/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\shared\despawn.gsc
***********************************************/

#using scripts\asm\asm;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#namespace despawn;

function terminatedespawn(asmname, statename) {
  thread queue_despawn();
}

function queue_despawn() {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(level.despawnthrottle)) {
    level.despawnthrottle = throttle_initialize("despawnThrottle", getdvarint(@ "hash_31df6612d8150a09", 3), level.framedurationseconds);
  }

  function_f632348cbb773537(level.despawnthrottle, self);
  self.nocorpse = 1;
  self kill();
}