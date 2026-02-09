/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3562.gsc
*********************************************/

func_8841() {
  self.var_907C = undefined;
}

func_1181C(var_0, var_1) {
  var_1.var_1E8E = var_0.angles;
}

func_1181B(var_0, var_1, var_2) {
  if(isDefined(var_2) && isDefined(var_1)) {
    if(isPlayer(var_1) && var_1 != var_2) {
      if(!level.teambased || var_2.team != var_1.team) {
        var_2 func_E7FC(var_0, var_1, var_2);
      }
    }
  }

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

func_8840(var_0, var_1) {
  if(isDefined(var_0)) {
    var_0 playlocalsound("bs_shield_explo");
  }

  var_1 playsoundtoteam("bs_shield_explo_npc", "axis", var_0);
  var_1 playsoundtoteam("bs_shield_explo_npc", "allies", var_0);
  playFX(scripts\engine\utility::getfx("hackKnife_impactWorld"), var_1.origin, anglesToForward(var_1.angles), anglestoup(var_1.angles));
}

func_E7FC(var_0, var_1, var_2) {
  if(isDefined(var_2.var_907C)) {
    func_8842(var_2.var_907C);
  }

  var_3 = func_53C9(var_1);
  self.var_907C = [];
  if(isDefined(var_3)) {
    for(var_4 = 0; var_4 < 1; var_4++) {
      var_2.var_907C[var_4] = func_8843(var_3[var_4], var_0.var_1E8E);
      var_2.var_907C[var_4] func_883F(var_1);
    }
  }

  self playlocalsound("ghost_prism_activate");
  self waittill("death");
  thread func_8842(var_2.var_907C);
}

func_53C9(var_0) {
  var_1 = getclosestpointonnavmesh(var_0.origin + anglesToForward(var_0.angles) * 64);
  var_2 = [];
  var_2 = getnodesinradius(var_1, 128, 64, 64);
  return var_2;
}

func_8842(var_0) {
  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      playsoundatpos(var_2.origin, "ghost_prism_deactivate");
      var_2 notify("death");
      var_2 suicide();
    }
  }
}

func_8843(var_0, var_1) {
  if(scripts\mp\agents\agent_utility::getnumactiveagents("squadmate") >= 5) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AGENT_MAX");
    return 0;
  }

  if(scripts\mp\agents\agent_utility::getnumownedactiveagents(self) >= 2) {
    return 0;
  }

  if(!isDefined(var_0)) {
    var_0 = scripts\mp\agents\agent_utility::getvalidspawnpathnodenearplayer(1, 1);
  }

  var_2 = scripts\mp\agents\_agents::add_humanoid_agent("squadmate", self.team, "reconAgent", var_0.origin, var_1, self, 0, 0, "hardened");
  if(!isDefined(var_2)) {
    return 0;
  }

  var_2.killstreaktype = "agent";
  return var_2;
}

func_883F(var_0) {
  if(isDefined(self.headmodel)) {
    self detach(self.headmodel, "");
    self.headmodel = undefined;
  }

  self setModel(var_0.model);
  self takeallweapons();
  self giveweapon(var_0.primaryweapon);
  if(var_0.secondaryweapon != "none") {
    self giveweapon(var_0.secondaryweapon);
  }

  scripts\mp\utility::_switchtoweapon(var_0.primaryweapon);
  self botsetflag("disable_attack", 0);
  self.health = 50;
  thread func_1903();
  var_1 = var_0.origin + anglesToForward(var_0.angles) * 64 * 5;
  var_2 = scripts\common\trace::ray_trace(var_0.origin, var_1, level.players);
  if(!isDefined(var_2)) {
    var_2["position"] = var_1;
  } else {
    var_2 = var_2["position"];
  }

  var_3 = getclosestpointonnavmesh(var_2);
  var_3 = getclosestnodeinsight(var_3);
  self botsetscriptgoalnode(var_3, "objective");
}

func_1903() {
  self waittill("death");
  var_0 = self.origin;
  var_1 = self func_8113();
  var_1 hide();
}

func_68D5() {
  self endon("death");
  for(;;) {
    wait(0.75);
    playFXOnTag(level.var_CAA3["shimmer"], self, "j_spineupper");
  }
}

func_13BAD(var_0) {
  self endon("death");
  for(;;) {
    if(var_0 isonladder()) {
      wait(0.1);
      continue;
    }

    var_1 = var_0 getcurrentweapon();
    self giveweapon(var_1);
    scripts\mp\utility::_switchtoweapon(var_1);
    var_0 waittill("weapon_change");
  }
}