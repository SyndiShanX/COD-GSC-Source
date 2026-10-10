/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_4ea8877a7b6a718.gsc
************************************************/

#using script_53651341190c5aab;
#using scripts\asm\asm_bb;
#namespace namespace_5a3b74f5fb73d362;

function startcap(statename, params) {
  walkspeed = 50;
  scripts\asm\asm_bb::bb_setcivilianstate("casual");
  scripts\asm\asm_bb::bb_civilianrequestspeed(walkspeed);
  namespace_f901a4f9d899be59::startcap(statename, params);
}

function getfunction(funcid) {
  if(funcid == "start_cap") {
    return &startcap;
  }

  return namespace_f901a4f9d899be59::function_efcea5d26798e5b6(funcid);
}