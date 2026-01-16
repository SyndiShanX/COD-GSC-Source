/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\equipment\phase_split.gsc
************************************************/

init() {
  level.var_CAA3 = [];
  level.var_CAA3["spawn"] = loadfx("vfx\iw7\_requests\mp\vfx_phasesplit_holo_spawn");
  level.var_CAA3["death"] = loadfx("vfx\iw7\_requests\mp\vfx_phasesplit_holo_death");
  level.var_CAA3["shimmer"] = loadfx("vfx\iw7\_requests\mp\vfx_phasesplit_holo_shimmer");
}

func_CAC1() {
  func_CABB();
}

func_CAC2() {
  if(!func_CAB5()) {
    return 0;
  }

  thread func_CAC4();
  return 1;
}

func_CAC4(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("phaseSplit_end");
  self.var_CAB1 = 1;
  var_1 = anglestoright(self.angles) * cos(90) + anglesToForward(self.angles) * sin(90);
  var_2 = var_1 * 64;
  var_3 = self.origin + var_2;
  var_3 = getclosestpointonnavmesh(var_3);
  var_4 = getnodesinradius(var_3, 64, 0, 128);
  var_5 = var_4[0];
  var_6 = 9999999;
  foreach(var_8 in var_4) {
    var_9 = lengthsquared(var_8.origin - var_3);
    if(var_9 < var_6) {
      var_5 = var_8;
      var_6 = var_9;
    }
  }

  thread func_CAC8();
  var_11 = func_CAC0(var_5);
  var_11 thread func_CAB4();
  var_11 thread func_CAB3();
  var_11 thread func_CAB6();
  scripts\mp\powers::func_4575(10, "power_phaseSplit_update", "phaseSplit_end");
  thread func_CABB(1);
}

func_CAC8() {
  self endon("death");
  self endon("disconnect");
  self endon("phaseSplit_end");
  while(!scripts\mp\killstreaks\emp_common::isemped()) {
    scripts\engine\utility::waitframe();
  }

  thread func_CABB();
}

func_CABB(var_0) {
  if(!isDefined(self.var_CAB1)) {
    return;
  }

  self.var_CAB1 = undefined;
  self notify("phaseSplit_end");
  if(!isDefined(var_0) || !var_0) {
    self notify("powers_phaseSplit_update", 0);
  }
}

func_CAC0(var_0) {
  if(!isDefined(var_0)) {
    var_0 = scripts\mp\agents\agent_utility::getvalidspawnpathnodenearplayer(1, 1);
  }

  var_1 = scripts\mp\agents\_agents::add_humanoid_agent("phaseSplitAgent", self.team, "callback", var_0.origin, self.angles, self, 0, 0, "veteran", ::func_CAB2);
  if(!isDefined(var_1)) {
    thread func_CABB();
    return;
  }

  if(isDefined(var_1.headmodel)) {
    var_1 detach(self.headmodel, "");
    var_1.headmodel = undefined;
  }

  var_1 setModel(var_1.owner.model);
  var_1.health = 25;
  var_1 botsetflag("disable_attack", 1);
  var_2 = var_1.origin + anglesToForward(var_1.angles) * 500;
  var_3 = scripts\common\trace::ray_trace(var_1.origin, var_2, level.players);
  if(!isDefined(var_3)) {
    var_3["position"] = var_2;
  } else {
    var_3 = var_3["position"];
  }

  var_4 = getclosestpointonnavmesh(var_3);
  var_4 = getclosestnodeinsight(var_4);
  var_1 botsetscriptgoalnode(var_4, "objective");
  self playlocalsound("ghost_prism_activate");
  playFX(level.var_CAA3["spawn"], var_1.origin, anglesToForward(var_1.angles), anglestoup(var_1.angles));
  return var_1;
}

func_CAB6() {
  self endon("death");
  for(;;) {
    wait(0.75);
    playFXOnTag(level.var_CAA3["shimmer"], self, "j_spineupper");
  }
}

func_CAB4() {
  self waittill("death");
  var_0 = self func_8113();
  var_0 hide();
  playFX(level.var_CAA3["death"], var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
  if(isDefined(self.owner)) {
    self.owner func_CABB();
    if(scripts\mp\utility::isreallyalive(self.owner)) {
      self.owner iprintlnbold("Clone Destroyed");
    }
  }
}

func_CAB3() {
  self endon("death");
  self.owner scripts\engine\utility::waittill_any("death", "disconnect", "phaseSplit_end");
  self suicide();
}

func_CAB5() {
  var_0 = scripts\mp\agents\agent_utility::getnumownedactiveagents(self);
  if(var_0 >= 2) {
    return 0;
  }

  return 1;
}

func_CAC9() {
  level.agent_funcs["phaseSplitAgent"] = level.agent_funcs["player"];
  level.agent_funcs["phaseSplitAgent"]["think"] = ::scripts\mp\killstreaks\_agent_killstreak::squadmate_agent_think;
  level.agent_funcs["phaseSplitAgent"]["on_killed"] = ::func_CACA;
  level.agent_funcs["phaseSplitAgent"]["on_damaged"] = ::scripts\mp\agents\_agents::on_agent_player_damaged;
  level.agent_funcs["phaseSplitAgent"]["gametype_update"] = ::scripts\mp\killstreaks\_agent_killstreak::no_gametype_update;
}

func_CACA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  scripts\mp\agents\_agents::on_humanoid_agent_killed_common(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0);
  if(isplayer(var_1) && isDefined(self.owner) && var_1 != self.owner) {
    self.owner scripts\mp\utility::leaderdialogonplayer("squad_killed");
  }

  scripts\mp\agents\agent_utility::deactivateagent();
}

func_CAB2() {
  var_0 = self.owner;
  var_1 = [];
  var_2 = var_0 getweaponslistprimaries();
  var_3 = [];
  if(var_2.size > 0 && var_2[0] != "none") {
    for(var_4 = 0; var_4 < var_2.size; var_4++) {
      if(!scripts\mp\weapons::isaltmodeweapon(var_2[var_4])) {
        var_3[var_3.size] = var_2[var_4];
      }
    }
  }

  var_2 = var_3;
  if(var_2.size > 0 && var_2[0] != "none") {
    var_5 = var_2[0];
    var_1["loadoutPrimary"] = ::scripts\mp\utility::getweaponrootname(var_5);
    var_6 = getweaponattachments(var_5);
    for(var_4 = 0; var_4 < var_6.size; var_4++) {
      var_7 = scripts\engine\utility::ter_op(var_4 > 0, "loadoutPrimaryAttachment" + var_4 + 1, "loadoutPrimaryAttachment");
      var_1[var_7] = var_6[var_4];
    }

    var_1["loadoutPrimaryCamo"] = getweaponcamoname(var_5);
  }

  if(var_2.size > 0 && var_2[1] != "none") {
    var_5 = var_2[1];
    var_1["loadoutSecondary"] = ::scripts\mp\utility::getweaponrootname(var_5);
    var_6 = getweaponattachments(var_5);
    for(var_4 = 0; var_4 < var_6.size; var_4++) {
      var_7 = scripts\engine\utility::ter_op(var_4 > 0, "loadoutSecondaryAttachment1" + var_4, "loadoutSecondaryAttachment");
      var_1[var_7] = var_6[var_4];
    }

    var_1["loadoutSecondaryCamo"] = getweaponcamoname(var_5);
  }

  return var_1;
}