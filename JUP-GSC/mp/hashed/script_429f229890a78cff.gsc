/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_429f229890a78cff.gsc
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
      return &function_8190fffc19bdbc2a;
  }

  return namespace_f901a4f9d899be59::function_efcea5d26798e5b6(funcid);
}

function function_8190fffc19bdbc2a(interactionid) {
  if(!isalive(self)) {
    users = function_adf0d34ff483c35a(interactionid);
    statename = "friend_down";
    alias = "friend_down_anim";

    foreach(user in users) {
      if(scripts\asm\cap::function_f179ede0989e6734(statename, alias)) {
        user._blackboard.var_7460b96395361857 = "friend_down";
      }
    }

    return;
  }

  if(isDefined(self.stealth) && self.var_fe5ebefa740c7106 != 0 || isDefined(self.var_fd01ad49b4e38ae8)) {
    self._blackboard.var_7460b96395361857 = "react";
    return;
  }

  self._blackboard.var_7460b96395361857 = "end";
}

function startcap(statename, params) {
  namespace_f901a4f9d899be59::startcap(statename, params);
}