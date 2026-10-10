/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3d770662de554104.gsc
*************************************************/

#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\cap;
#using scripts\common\cap;
#namespace call_reinforcements;

function getfunction(funcid) {
  switch (funcid) {
    case #"hash_dab0d83df51da4d":
      return &function_3dbd361f74b442f9;
    case #"hash_722d767fd6d40f56":
      return &function_a157fbbc31d9eb1a;
    case #"hash_256644959193a6c7":
      return &callreinforcements;
  }

  assertmsg("<dev string:x1c>" + funcid);
}

function function_3dbd361f74b442f9(interactionid) {}

function function_a157fbbc31d9eb1a(interactionid) {
  self clearbtgoal(1);
  self notify("endcallreinforcements");
}

function callreinforcements(statename, params) {
  self endon("death");
  self endon("endcallreinforcements");
  var_2f67a016c007b82b = getscriptbundle("ai_behavior_call_reinforcements:ai_behavior_call_reinforcements_default");

  if(!isDefined(var_2f67a016c007b82b)) {
    assertmsg("<dev string:x3d>");
    return;
  }

  self function_e64ea2b4e79c4b74(1);
  self setbtgoalRadius(1, 12);
  capname = "cap_call_reinforcements";

  if(self.asmname != capname) {
    scripts\common\cap::cap_start(capname, "caps/interactions/cap_call_reinforcements");
  }

  self playSound("dx_br_dbos_dbli_dbtp_bitr");
  thread function_6cdcfd04e3704a8a(var_2f67a016c007b82b.var_1f76883e524b41a5);
  self waittill("cap_exit_completed");
}

function function_6cdcfd04e3704a8a(calllength) {
  self endon("death");
  self endon("endcallreinforcements");
  wait calllength;

  if(isDefined(level.agent_funcs)) {
    var_65752f70ab196d34 = level.agent_funcs["spawn_reinforcements"];

    if(isDefined(var_65752f70ab196d34)) {
      [[var_65752f70ab196d34]](self.origin, 0, 1);
    }
  }

  asm_fireevent(self.asmname, "call_reinforcements_loop_end");
}

function function_73c90b8dc4dbc607(asmname, statename, params) {
  sectionname = params;

  if(!isDefined(sectionname)) {
    assertmsg("<dev string:xb2>");
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
  var_a2f6d22ed12031bf = scripts\asm\cap::function_18e6c36c02a94dbd(statename, animname);
  return var_a2f6d22ed12031bf;
}