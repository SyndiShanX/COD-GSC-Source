/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_3d770662de554104.gsc
*************************************************/

#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\cap;
#using scripts\common\cap;
#namespace call_reinforcements;

function getfunction(funcid) {
  switch (funcid) {
    case #"hash_dab0d83df51da4d":
      return &onuserinit;
    case #"hash_722d767fd6d40f56":
      return &onuserterminate;
    case #"hash_256644959193a6c7":
      return &callreinforcements;
  }

  assertmsg("Missing function pointer for " + funcid);
}

function onuserinit(interactionid) {}

function onuserterminate(interactionid) {
  self clearbtgoal(1);
  self notify("endcallreinforcements");
}

function callreinforcements(statename, params) {
  self endon("death");
  self endon("endcallreinforcements");
  callreinforcementsbundle = getscriptbundle("ai_behavior_call_reinforcements:ai_behavior_call_reinforcements_default");

  if(!isDefined(callreinforcementsbundle)) {
    assertmsg("An AI is using the call reinforcements behavior but can't find the ai_behavior_call_reinforcements script bundle!");
    return;
  }

  self setbtgoalstationary(1);
  self setbtgoalRadius(1, 12);
  capname = "cap_call_reinforcements";

  if(self.asmname != capname) {
    scripts\common\cap::cap_start(capname, "caps/interactions/cap_call_reinforcements");
  }

  self playSound("dx_br_dbos_dbli_dbtp_bitr");
  thread function_6cdcfd04e3704a8a(callreinforcementsbundle.var_1f76883e524b41a5);
  self waittill("cap_exit_completed");
}

function function_6cdcfd04e3704a8a(calllength) {
  self endon("death");
  self endon("endcallreinforcements");
  wait calllength;

  if(isDefined(level.agent_funcs)) {
    spawnreinforcementsfunc = level.agent_funcs["spawn_reinforcements"];

    if(isDefined(spawnreinforcementsfunc)) {
      [[spawnreinforcementsfunc]](self.origin, 0, 1);
    }
  }

  asm_fireevent(self.asmname, "call_reinforcements_loop_end");
}

function callreinforcementschooseanim(asmname, statename, params) {
  sectionname = params;

  if(!isDefined(sectionname)) {
    assertmsg("Missing Reinforcements Anim section name ie start, loop, finish ");
    return;
  }

  stance = scripts\asm\asm_bb::bb_getrequestedstance();
  coverstate = scripts\asm\asm_bb::bb_getrequestedcoverstate();
  animname = "call_reinforcements";

  if(coverstate != "exposed") {
    covernode = scripts\asm\asm_bb::bb_getcovernode();

    if(isDefined(covernode)) {
      covertype = covernode.type;

      switch (covertype) {
        case #"hash_cd3ffe799551db82":
          animname += "_cover_right_" + stance;
          break;
        case #"hash_e1d8e1adebed5a61":
          animname += "_cover_left_" + stance;
          break;
        case #"hash_c3b74422dec48736":
          animname += "_cover_crouch";
          break;
        case #"hash_78b110033ccb68b0":
          animname += "_cover_stand";
          break;
      }
    }
  }

  animname += "_" + sectionname;
  alternativename = scripts\asm\cap::cap_lookupanimfromalias(statename, animname);
  return alternativename;
}