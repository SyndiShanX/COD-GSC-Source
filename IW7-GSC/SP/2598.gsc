/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2598.gsc
**************************************/

_id_3ED1(var_0, var_1, var_2) {
  if(!scripts\asm\asm::asm_hasalias(var_1, self.a.pose))
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, self.a.pose);
}

_id_10073(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm_bb::bb_selfdestructnow())
    return 1;

  return 0;
}

_id_C875(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm::_id_232B(var_1, "end") && scripts\asm\asm_bb::bb_isselfdestruct();
}

_id_337F(var_0, var_1, var_2, var_3) {
  return _id_0A0B::_id_2040();
}

_id_33AC(var_0, var_1, var_2, var_3) {
  _id_0C60::_id_11043();
  self playSound("shield_death_c6_1");
  _id_3368();
  scripts\anim\shared::_id_5D1A();
  var_4 = vectorNormalize(self.origin - level.player.origin + (0, 0, 30));

  if(self.damageweapon == "iw7_c6hack_melee" || self.damageweapon == "iw7_c6worker_fists")
    var_4 = vectorNormalize(self.origin - level.player.origin + (0, 0, 30) + anglestoright(level.player.angles) * 50);

  self _meth_82B1(_id_0A1E::_id_2342(), 0);

  if(isDefined(self._id_71C8))
    self[[self._id_71C8]]();

  self _meth_839B("torso_upper", var_4 * 2400);
  level.player _meth_8244("damage_heavy");
  earthquake(0.5, 1, level.player.origin, 100);
  level.player scripts\engine\utility::delaycall(0.25, ::stoprumble, "damage_heavy");
  wait 1;
  _id_0C60::_id_4E36();
}

_id_3368() {
  if(!isDefined(self._id_4D5D)) {
    return;
  }
  foreach(var_5, var_1 in self._id_4D5D) {
    if(var_5 == "head" && self _meth_850C(var_5) <= 0) {
      continue;
    }
    foreach(var_4, var_3 in self._id_4D5D[var_5].partnerheli) {
      if(!isDefined(self)) {
        return;
      }
      self setscriptablepartstate(var_5, "dmg_" + var_4 + "_both", 1);
    }
  }
}

_id_3361(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_A709)) {
    return;
  }
  self._id_A709 = 1;
  var_4 = undefined;
  level.player _meth_8244("damage_heavy");
  earthquake(0.5, 1, level.player.origin, 100);
  thread _id_0B0A::_id_583F(0, 1, 0.02, 203, 211, 3, 0.05);

  if(self.asmname == "c6_worker")
    var_4 = "pain_shock";
  else if(self.a.pose == "stand")
    var_4 = "shock_loop_stand";
  else if(self.a.pose == "crouch")
    var_4 = "shock_loop_crouch";

  thread _id_3368();
  playFXOnTag(level._id_7649["c6_death"], self, "j_spine4");

  if(soundexists("emp_shock_short"))
    playworldsound("shock_knife_blast", level.player getEye());

  thread _id_0C66::_id_FE4E(self.asmname, var_4, 0.02, 1, 0, 1);
  wait 0.5;
  self notify(var_4 + "_finished");
  self stopsounds();
  level.player stoprumble("damage_heavy");
  thread _id_0B0A::_id_583D(0.5);
  scripts\anim\shared::_id_5D1A();

  if(isDefined(self._id_71C8))
    self[[self._id_71C8]]();

  self _meth_839B("torso_upper", vectorNormalize(self.origin - level.player.origin + (0, 0, 10)) * 2200);
  wait 0.1;
  var_5 = _id_0A1E::asm_getbodyknob();
  self clearanim(var_5, 0.05);
  _id_0C60::_id_4E36();
}