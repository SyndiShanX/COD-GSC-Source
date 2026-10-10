/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_4294ae5072ee7245.gsc
*************************************************/

#using script_53651341190c5aab;
#using scripts\engine\utility;
#namespace namespace_4c7d643e2ae3dc9b;

function startcap(statename, params) {
  namespace_f901a4f9d899be59::startcap(statename, params);
}

function processevent(originator, eventtype, eventorigin) {
  return eventtype == "footstep" || eventtype == "footstep_sprint" || eventtype == "footstep_walk";
}

function getfunction(funcid) {
  switch (funcid) {
    case #"hash_4d7ca12cb5ce1028":
      return &startcap;
    case #"hash_b541f16499b1633d":
      return &processevent;
  }

  return namespace_f901a4f9d899be59::function_efcea5d26798e5b6(funcid);
}