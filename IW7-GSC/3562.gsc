/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3562.gsc
************************/

func_8841() {
  self.var_907C = undefined;
}

func_1181C(param_00, param_01) {
  param_01.var_1E8E = param_00.angles;
}

func_1181B(param_00, param_01, param_02) {
  if(isDefined(param_02) && isDefined(param_01)) {
    if(isplayer(param_01) && param_01 != param_02) {
      if(!level.teambased || param_02.team != param_01.team) {
        param_02 func_E7FC(param_00, param_01, param_02);
      }
    }
  }

  if(isDefined(param_00)) {
    param_00 delete();
  }
}

func_8840(param_00, param_01) {
  if(isDefined(param_00)) {
    param_00 playlocalsound("bs_shield_explo");
  }

  param_01 playsoundtoteam("bs_shield_explo_npc", "axis", param_00);
  param_01 playsoundtoteam("bs_shield_explo_npc", "allies", param_00);
  playFX(scripts\engine\utility::getfx("hackKnife_impactWorld"), param_01.origin, anglesToForward(param_01.angles), anglestoup(param_01.angles));
}

func_E7FC(param_00, param_01, param_02) {
  if(isDefined(param_02.var_907C)) {
    func_8842(param_02.var_907C);
  }

  var_03 = func_53C9(param_01);
  self.var_907C = [];
  if(isDefined(var_03)) {
    for(var_04 = 0; var_04 < 1; var_04++) {
      param_02.var_907C[var_04] = func_8843(var_03[var_04], param_00.var_1E8E);
      param_02.var_907C[var_04] func_883F(param_01);
    }
  }

  self playlocalsound("ghost_prism_activate");
  self waittill("death");
  thread func_8842(param_02.var_907C);
}

func_53C9(param_00) {
  var_01 = getclosestpointonnavmesh(param_00.origin + anglesToForward(param_00.angles) * 64);
  var_02 = [];
  var_02 = getnodesinradius(var_01, 128, 64, 64);
  return var_02;
}

func_8842(param_00) {
  if(isDefined(param_00)) {
    foreach(var_02 in param_00) {
      playsoundatpos(var_02.origin, "ghost_prism_deactivate");
      var_02 notify("death");
      var_02 suicide();
    }
  }
}

func_8843(param_00, param_01) {
  if(scripts\mp\agents\agent_utility::getnumactiveagents("squadmate") >= 5) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AGENT_MAX");
    return 0;
  }

  if(scripts\mp\agents\agent_utility::getnumownedactiveagents(self) >= 2) {
    return 0;
  }

  if(!isDefined(param_00)) {
    param_00 = scripts\mp\agents\agent_utility::getvalidspawnpathnodenearplayer(1, 1);
  }

  var_02 = scripts\mp\agents\_agents::add_humanoid_agent("squadmate", self.team, "reconAgent", param_00.origin, param_01, self, 0, 0, "hardened");
  if(!isDefined(var_02)) {
    return 0;
  }

  var_02.killstreaktype = "agent";
  return var_02;
}

func_883F(param_00) {
  if(isDefined(self.headmodel)) {
    self detach(self.headmodel, "");
    self.headmodel = undefined;
  }

  self setModel(param_00.model);
  self takeallweapons();
  self giveweapon(param_00.primaryweapon);
  if(param_00.secondaryweapon != "none") {
    self giveweapon(param_00.secondaryweapon);
  }

  scripts\mp\utility::_switchtoweapon(param_00.primaryweapon);
  self botsetflag("disable_attack", 0);
  self.health = 50;
  thread func_1903();
  var_01 = param_00.origin + anglesToForward(param_00.angles) * 64 * 5;
  var_02 = scripts\common\trace::ray_trace(param_00.origin, var_01, level.players);
  if(!isDefined(var_02)) {
    var_02["position"] = var_01;
  } else {
    var_02 = var_02["position"];
  }

  var_03 = getclosestpointonnavmesh(var_02);
  var_03 = getclosestnodeinsight(var_03);
  self botsetscriptgoalnode(var_03, "objective");
}

func_1903() {
  self waittill("death");
  var_00 = self.origin;
  var_01 = self _meth_8113();
  var_01 hide();
}

func_68D5() {
  self endon("death");
  for(;;) {
    wait(0.75);
    playFXOnTag(level.var_CAA3["shimmer"], self, "j_spineupper");
  }
}

func_13BAD(param_00) {
  self endon("death");
  for(;;) {
    if(param_00 isonladder()) {
      wait(0.1);
      continue;
    }

    var_01 = param_00 getcurrentweapon();
    self giveweapon(var_01);
    scripts\mp\utility::_switchtoweapon(var_01);
    param_00 waittill("weapon_change");
  }
}