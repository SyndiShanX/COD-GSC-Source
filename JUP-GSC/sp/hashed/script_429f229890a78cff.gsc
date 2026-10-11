/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_429f229890a78cff.gsc
*************************************************/

#using script_53651341190c5aab;
#using scripts\asm\cap;
#using scripts\engine\utility;
#namespace soldier_conversation;

function getfunction(funcid) {
  switch (funcid) {
    case #"hash_4d7ca12cb5ce1028":
      return &startcap;
    case #"hash_2265dc8309b4f346":
      return &onusertermindated;
  }

  return namespace_f901a4f9d899be59::function_efcea5d26798e5b6(funcid);
}

function onusertermindated(interactionid) {
  if(!isalive(self)) {
    users = getbsequsers(interactionid);
    statename = "friend_down";
    alias = "friend_down_anim";

    foreach(user in users) {
      if(scripts\asm\cap::cap_hasalias(statename, alias)) {
        user._blackboard.bseqphase = "friend_down";
      }
    }

    return;
  }

  if(isDefined(self.stealth) && self.stealth_bsmstate != 0 || isDefined(self.var_fd01ad49b4e38ae8)) {
    self._blackboard.bseqphase = "react";
    return;
  }

  self._blackboard.bseqphase = "end";
}

function startcap(statename, params) {
  namespace_f901a4f9d899be59::startcap(statename, params);
}