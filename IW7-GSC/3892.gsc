/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3892.gsc
**************************************/

main() {
  level _id_13AA();
  _id_13EDC();
}

_id_13AA() {
  level._effect["zerog_jetpack_thruster_large"] = loadfx("vfx/iw7/core/mechanics/zerog/zerog_jetpack_thruster_sm.vfx");
  level._effect["zerog_jetpack_thruster_large_allies"] = loadfx("vfx/iw7/core/mechanics/zerog/zerog_jetpack_thruster_sm_allies.vfx");
  level._id_13EE8 = ::_id_CD6B;
  level._effect["zerog_jetpack_thruster_small"] = loadfx("vfx/iw7/core/mechanics/zerog/zerog_jetpack_thruster_sm_turn.vfx");
  level._effect["zerog_jetpack_thruster_small_allies"] = loadfx("vfx/iw7/core/mechanics/zerog/zerog_jetpack_thruster_sm_turn_allies.vfx");
  level._id_13EE9 = ::_id_CE13;
  level._id_1248["zerog_jetpack_thruster_large_allies"] = "zero_g_npc_mvmt_turn";
  level._id_1248["zerog_jetpack_thruster_small_allies"] = "zero_g_npc_mvmt_turn";
  level._effect["zerog_jetpack_thruster_idle"] = loadfx("vfx/iw7/core/mechanics/zerog/zerog_jetpack_thruster_sm_idle.vfx");
  level._effect["zerog_jetpack_thruster_idle_allies"] = loadfx("vfx/iw7/core/mechanics/zerog/zerog_jetpack_thruster_sm_idle_allies.vfx");
  level._id_13EEA = ::_id_CE5F;
  level._effect["zerog_jetpack_thruster_idle_light"] = loadfx("vfx/iw7/core/mechanics/zerog/zerog_jetpack_thruster_sm_idle_light.vfx");
  level._effect["zerog_jetpack_thruster_idle_light_allies"] = loadfx("vfx/iw7/core/mechanics/zerog/zerog_jetpack_thruster_sm_idle_allies_light.vfx");
  level._id_13EEB = ::_id_CE60;
  level._effect["zerog_jetpack_death"] = loadfx("vfx/iw7/core/mechanics/zerog/zerog_jetpack_thruster_death.vfx");
  level._effect["spacesuit_leak"] = loadfx("vfx/iw7/core/impact/custom/vfx_imp_cstm_spacesuit_leak.vfx");
  level._effect["spacesuit_burst"] = loadfx("vfx/iw7/core/impact/custom/vfx_imp_cstm_spacesuit_burst.vfx");
}

_id_CD6B(var_0) {
  return _id_CCF2("zerog_jetpack_thruster_large", "zerog_jetpack_thruster_large_allies", var_0);
}

_id_CE13(var_0) {
  return _id_CCF2("zerog_jetpack_thruster_small", "zerog_jetpack_thruster_small_allies", var_0);
}

_id_CE5F(var_0) {
  return _id_CCF2("zerog_jetpack_thruster_idle", "zerog_jetpack_thruster_idle_allies", var_0);
}

_id_CE60(var_0) {
  return _id_CCF2("zerog_jetpack_thruster_idle_light", "zerog_jetpack_thruster_idle_light_allies", var_0);
}

_id_CCF2(var_0, var_1, var_2) {
  if(self.team == "neutral") {
    return undefined;
  }

  var_3 = self.team;

  if(var_3 == "dead") {
    var_3 = self._id_C733;
  }

  var_4 = undefined;

  if(var_3 == "axis") {
    var_4 = scripts\engine\utility::getfx(var_0);
  } else if(var_3 == "allies") {
    var_4 = scripts\engine\utility::getfx(var_1);
  }

  playFXOnTag(var_4, self, var_2);

  if(isDefined(level._id_1248[var_1])) {
    var_5 = level._id_1248[var_1];

    if(soundexists(var_5)) {
      self playSound(var_5);
    }
  }

  return [var_4, var_2];
}

#using_animtree("generic_human");

_id_13EDC() {
  level._id_126C8 = getnodearray("zg_traversal", "script_noteworthy");
  level._id_EC85["generic"]["hm_zg_red_exposed_traversal_step_01"] = % hm_zg_red_exposed_traversal_step_01;
  level._id_EC85["generic"]["hm_zg_red_exposed_traversal_thread_01"] = % hm_zg_red_exposed_traversal_thread_01;
  level._id_EC85["generic"]["hm_zg_red_exposed_traversal_thread_02"] = % hm_zg_red_exposed_traversal_thread_02;
}

_id_13E86(var_0) {
  self notify("find_traversal");
  self endon("find_traversal");
  self endon("death");

  if(!isDefined(var_0)) {
    var_0 = 10;
  }

  var_1 = gettime() + var_0 * 1000;

  while(gettime() <= var_1) {
    var_2 = _id_13E87();

    if(isDefined(var_2)) {
      thread _id_13EAF(var_2);
      return;
    } else
      wait 1.0;
  }
}

_id_13E87(var_0, var_1, var_2) {
  self notify("zg_find_new_traversal");
  self endon("zg_find_new_traversal");

  if(scripts\engine\utility::is_true(self._id_93AD)) {
    return undefined;
  }

  if(scripts\asm\asm_bb::bb_isanimScripted()) {
    return undefined;
  }

  if(!isDefined(var_0)) {
    var_0 = 1024;
  }

  if(!isDefined(var_1)) {
    var_1 = 0.7;
  }

  if(!isDefined(var_2)) {
    var_2 = 0.7;
  }

  var_3 = 10000;

  if(isDefined(self.goalpos)) {
    var_0 = distance(self.origin, self.goalpos);
    var_4 = vectorNormalize(self.goalpos - self.origin);
    var_5 = self.goalpos;
  } else {
    var_4 = anglesToForward(self.angles);
    var_5 = self.origin + anglesToForward(self.angles) * var_0;
  }

  var_6 = var_0 * var_0;
  var_7 = 0;
  var_8 = undefined;

  foreach(var_10 in level._id_126C8) {
    if(scripts\engine\utility::is_true(var_10.in_use)) {
      continue;
    }
    if(isDefined(var_10._id_A922) && gettime() - var_10._id_A922 <= var_3) {
      continue;
    }
    if(distancesquared(self.origin, var_10.origin) > var_6) {
      continue;
    }
    var_11 = vectorNormalize(var_10.origin - self.origin);
    var_12 = vectordot(var_4, var_11);

    if(var_12 > var_1) {
      var_13 = vectordot(vectorNormalize(var_5 - var_10.origin), anglesToForward(var_10.angles));

      if(var_13 > var_2 && var_13 > var_7) {
        var_7 = var_13;
        var_8 = var_10;
      }
    }
  }

  return var_8;
}

_id_13EAF(var_0) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon("grapple_kill");

  if(scripts\engine\utility::is_true(self._id_93AD)) {
    return;
  }
  var_0.in_use = 1;
  var_1 = 0;

  if(scripts\sp\utility::_id_8B6C()) {
    scripts\sp\utility::_id_54F7();
    var_1 = 1;
  }

  self._id_1FBB = "generic";
  var_2 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_3 = var_2.animation;
  var_4 = scripts\engine\utility::spawn_tag_origin(var_2.origin, var_2.angles);
  var_5 = self.goalnode;
  var_6 = self.goalpos;
  var_7 = self.ignoreall;
  self.ignoreall = 1;
  scripts\sp\utility::_id_F2A8(1);
  self[[self._id_72D0]](var_0.angles);
  self._id_93AD = 1;
  var_4 scripts\sp\anim::_id_1F17(self, var_3);

  if(distancesquared(self.origin, var_0.origin) < 100) {
    var_4 scripts\sp\anim::_id_1F37(self, var_3);
  }

  self.ignoreall = var_7;
  self[[self._id_41AF]]();
  var_0.in_use = 0;
  var_0._id_A922 = gettime();

  if(isDefined(var_5)) {
    self _meth_82EE(var_5);
  } else if(isDefined(var_6)) {
    self setgoalpos(var_6);
  } else {
    self setgoalpos(self.origin);
  }

  if(var_1) {
    scripts\sp\utility::_id_61C7();
  }

  self._id_93AD = 0;
}