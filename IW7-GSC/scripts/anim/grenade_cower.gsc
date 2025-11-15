/******************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\grenade_cower.gsc
******************************************/

main() {
  if(getdvarint("ai_iw7", 0) == 1) {
    scripts\asm\asm::asm_fireephemeralevent("grenade response", "avoid");
    self endon("killanimscript");
    self endon("death");
    self waittill("killanimscript");
  }

  self endon("killanimscript");
  scripts\anim\utility::func_9832("grenadecower");
  if(isDefined(self.setnavlayer)) {
    self[[self.setnavlayer]]();
    return;
  }

  if(self.a.pose == "prone") {
    scripts\anim\stop::main();
    return;
  }

  self animmode("zonly_physics");
  self orientmode("face angle", self.angles[1]);
  var_00 = 0;
  if(isDefined(self.objective_position)) {
    var_00 = angleclamp180(vectortoangles(self.objective_position.origin - self.origin)[1] - self.angles[1]);
  } else {
    var_00 = self.angles[1];
  }

  if(self.a.pose == "stand") {
    if(isDefined(self.objective_position) && func_12895(var_00)) {
      return;
    }

    self _meth_82E4("cowerstart", scripts\anim\utility::func_B027("grenade", "cower_squat"), % body, 1, 0.2);
    scripts\anim\shared::donotetracks("cowerstart");
  }

  self.a.pose = "crouch";
  self.a.movement = "stop";
  self _meth_82E4("cower", scripts\anim\utility::func_B027("grenade", "cower_squat_idle"), % body, 1, 0.2);
  scripts\anim\shared::donotetracks("cower");
  self waittill("never");
}

end_script() {
  self.navtrace = 1;
}

func_12895(param_00) {
  if(randomint(2) == 0) {
    return 0;
  }

  if(self.getcsplinepointtargetname != "none") {
    return 0;
  }

  var_01 = undefined;
  if(abs(param_00) > 90) {
    var_01 = scripts\anim\utility::func_B027("grenade", "cower_dive_back");
  } else {
    var_01 = scripts\anim\utility::func_B027("grenade", "cower_dive_front");
  }

  var_02 = getmovedelta(var_01, 0, 0.5);
  var_03 = self gettweakablevalue(var_02);
  if(!self maymovetopoint(var_03)) {
    return 0;
  }

  self.navtrace = 0;
  self _meth_82E4("cowerstart", var_01, % body, 1, 0.2);
  scripts\anim\shared::donotetracks("cowerstart");
  self.navtrace = 1;
  return 1;
}