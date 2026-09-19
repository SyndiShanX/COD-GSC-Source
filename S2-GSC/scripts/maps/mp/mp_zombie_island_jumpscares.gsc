/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_island_jumpscares.gsc
***********************************************************/

init() {
  thread manage_possums();
}

manage_possums() {
  level endon("game_ended");
  wait 1;
  var_3 = common_scripts\utility::_id_46B7("feign_death_struct", "targetname");

  foreach(var_5 in var_3) {
    var_5 initialize_feign_death();
    var_5.scare_zone = _id_055A::getzoneclosesttopoint(var_5._id_0186.origin, 0);
  }

  var_7 = gettime();
  wait_for_cycle();

  for(;;) {
    var_8 = undefined;

    foreach(var_10 in common_scripts\utility::array_randomize(var_3)) {
      var_11 = var_10.scare_zone;
      var_12 = _id_055A::_id_4626(var_11, 1);

      if(var_12.size == 0 && common_scripts\utility::_id_562E(level._id_AC80._id_ACB3[var_11]._id_556E)) {
        var_8 = var_10;
        break;
      }
    }

    if(isDefined(var_8)) {
      var_14 = level._id_A980 + _func_0A4(2, 5);
      wait_for_jscare_complete(var_8);

      while(level._id_A980 < var_14)
        wait 0.125;
    } else {}

    var_15 = gettime();
    var_16 = (var_15 - var_7) / 1000;
    var_17 = clamp(180 - var_16, 5, 180);
    wait_for_cycle(var_17);
  }
}

wait_for_jscare_complete(var_0) {
  if(isDefined(var_0)) {
    var_1 = gettime();
    var_0 reset_feign_death();
    var_2 = spawn("script_model", var_0._id_0186.origin);
    var_0 thread do_feign_death(var_2);
    var_3 = 90;
    var_4 = var_2 common_scripts\utility::_id_A71A(var_3, "do_jumpscare", "jscare_zombie_unfrozen");

    if(var_4 != "do_jumpscare") {
      for(var_5 = _id_055A::_id_4626(var_0.scare_zone, 0); var_5.size != 0 && var_4 != "do_jumpscare"; var_5 = _id_055A::_id_4626(var_0.scare_zone, 0))
        var_4 = var_2 common_scripts\utility::_id_A71A(1, "do_jumpscare");

      if(var_4 != "do_jumpscare") {
        var_0 notify("end_possum");
        var_2 notify("end_possum");
        var_2 delete();
      }
    }
  }
}

wait_for_cycle(var_0) {
  var_1 = 0;
  var_2 = 5;

  if(!isDefined(var_0))
    var_0 = 180;

  while(var_1 < var_0) {
    wait(var_2);
    var_1 = var_1 + var_2;
  }
}

#using_animtree("animated_props_zombies_DLC1");

initialize_feign_death() {
  var_0 = [];
  var_0["s2_zom_core_feign_death_scare_idle_v1"] = % s2_zom_core_feign_death_scare_idle_v1;
  var_0["s2_zom_core_feign_death_scare_idle_v2"] = % s2_zom_core_feign_death_scare_idle_v2;
  var_0["s2_zom_core_feign_death_scare_idle_v3"] = % s2_zom_core_feign_death_scare_idle_v3;
  var_0["s2_zom_core_feign_death_scare_idle_v4"] = % s2_zom_core_feign_death_scare_idle_v4;
  var_1 = [];
  var_1["s2_zom_core_feign_death_scare_v1"] = % s2_zom_core_feign_death_scare_v1;
  var_1["s2_zom_core_feign_death_scare_v2"] = % s2_zom_core_feign_death_scare_v2;
  var_1["s2_zom_core_feign_death_scare_v3"] = % s2_zom_core_feign_death_scare_v3;
  var_1["s2_zom_core_feign_death_scare_v4"] = % s2_zom_core_feign_death_scare_v4;
  var_2 = common_scripts\utility::_id_44BE(self.target, "targetname");

  foreach(var_4 in var_2) {
    switch (var_4._id_0165) {
      case "zombie_spawner":
        self._id_0186 = var_4;
        break;
      case "feign_death_trigger":
        self._id_9D65 = var_4;
        break;
    }
  }

  self._id_5049 = var_0;
  self.scare_anims = var_1;
  reset_feign_death();
}

reset_feign_death() {
  var_0 = _func_0A4(1, 5);
  self.anim_sel = var_0;

  if(isDefined(self._id_81E1))
    self.anim_sel = self._id_81E1;
}

do_feign_death(var_0) {
  self endon("end_possum");
  var_1 = "scripted_feign_death_scare_" + self.anim_sel;
  var_0 childthread execute_ground_scare(self, var_1);
  wait_for_player_close();
  var_0 notify("do_jumpscare");
}

wait_for_player_close() {
  self endon("end_possum");

  for(;;) {
    foreach(var_1 in level.players) {
      if(distance(var_1.origin, self._id_0186.origin) > 220) {
        continue;
      }
      if(!_func_07F(var_1 getEye(), self._id_0186.origin + (0, 0, 8), 0, undefined)) {
        continue;
      }
      return;
    }

    waitframe();
  }
}

execute_ground_scare(var_0, var_1) {
  var_2 = _id_054D::_id_90BA("zombie_generic", var_0._id_0186, "jumpscare", 0, 1, 1, "possum");
  var_2._id_6816 = 1;
  var_2 execute_frozen_state(var_0._id_0186, self, var_1);

  if(isDefined(self))
    self notify("jscare_zombie_unfrozen");
}

execute_frozen_state(var_0, var_1, var_2) {
  self endon("death");
  var_3 = var_2;
  var_4 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_3);
  var_5 = self _meth_83DB(var_4);
  var_6 = randomint(var_5);
  self _meth_83A2(1);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, var_3);
  maps\mp\_utility::_id_2CED(0.5, ::setpossumgoal);
  self _meth_839B("face angle abs", self.angles);
  self _meth_839C("anim deltas");
  self.frozen = 1;
  thread maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_4, var_6, 0.0, "scripted_anim", undefined, undefined, 0.0);
  var_7 = 90;
  common_scripts\utility::_id_A70D(var_7, var_1, "do_jumpscare");
  var_1 notify("do_jumpscare");
  _id_0378::_id_8D74("js_corpse_becomes_zombie");
  self.frozen = 0;
  self notify("scripted_anim", "end");
  childthread setfacingenemy();
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_4, var_6, 1.0, "scripted_anim");
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, var_3);
  self _meth_83A2(0);
}

setfacingenemy() {
  wait 0.25;
  self _meth_839B("face enemy");
}

setpossumgoal() {
  self _meth_8395(self.origin);
}