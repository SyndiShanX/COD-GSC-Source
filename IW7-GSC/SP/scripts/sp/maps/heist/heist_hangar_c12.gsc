/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\heist\heist_hangar_c12.gsc
******************************************************/

_id_8A27() {
  scripts\sp\maps\heist\heist_util::_id_107BE();
  scripts\sp\maps\heist\heist_util::_id_106D9();
  scripts\sp\maps\heist\heist_util::_id_1074D();
  scripts\sp\maps\heist\heist_util::_id_1065E();
  scripts\sp\utility::_id_F5AF("start_hangar_c12", [level.player, level._id_EA2C, level._id_6754, level._id_A54E, level._id_30F6]);
  scripts\sp\maps\heist\heist_util::_id_968E();
  thread scripts\sp\maps\heist\heist_util::_id_10D16();
  scripts\sp\maps\heist\heist_lift::_id_3A73();
  scripts\sp\maps\heist\heist_hangar::_id_9613();
  scripts\sp\maps\heist\heist_hangar::_id_9612();
  thread scripts\sp\maps\heist\heist_util::_id_968F("hangar_shift_1", "start_hangar_shift_1", 0.05);
  thread scripts\sp\maps\heist\heist_util::_id_968F("hangar_shift_2", "start_hangar_shift_2", 0.05);
  scripts\engine\utility::flag_set("start_hangar_shift_1");
  scripts\engine\utility::flag_set("start_hangar_shift_2");
  scripts\engine\utility::flag_set("retreat_to_c12");
  scripts\engine\utility::delaythread(0.1, scripts\sp\maps\heist\heist_hangar::_id_426F, 1);
  scripts\engine\utility::delaythread(0.05, scripts\sp\utility::_id_15F3, "hangar_lift_end_big");

  foreach(var_1 in getEntArray("pathblocker_hangar_shift_2", "targetname")) {
    var_1 connectpaths();
    var_1 delete();
  }

  foreach(var_4 in getEntArray("pathblocker_hangar_shift_1_player", "targetname"))
  var_4 delete();

  foreach(var_4 in getEntArray("pathblocker_hangar_shift_1_main", "targetname"))
  var_4 solid();

  foreach(var_4 in getEntArray("pathblocker_hangar_shift_2_player", "targetname"))
  var_4 delete();

  foreach(var_4 in getEntArray("pathblocker_hangar_shift_2_main", "targetname"))
  var_4 solid();

  setsaveddvar("sm_roundRobinPrioritySpotShadows", 6);
}

_id_8A26() {
  scripts\sp\utility::_id_2669("c12");
  var_0 = getEnt("hangar_lift_end_big", "script_noteworthy");
  var_0 thread scripts\sp\maps\heist\heist_hangar::_id_1072C("hanger_elevator_03");
  var_1 = scripts\engine\utility::getStruct("big_lift", "script_noteworthy");
  var_2 = squared(1100);

  while(!isDefined(level._id_8A26)) {
    if(!level.player scripts\sp\utility::_id_65DB("is_hacked_robot")) {
      if(scripts\engine\utility::flag("retreat_to_c12") || scripts\engine\utility::flag("early_final_retreat")) {
        if(distance2dsquared(level.player.origin, var_1.origin) <= var_2) {
          if(level.player scripts\sp\utility::_id_D1DF(var_1.origin + (0, 0, 64), 0.65))
            var_0 scripts\engine\utility::delaythread(1, scripts\sp\utility::_id_F225, "trigger");
        }
      }
    }

    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_set("hangar_shift_2");
  level._id_8A26 thread _id_35E6();
  scripts\sp\maps\heist\heist_hangar::_id_4084();
  var_3 = scripts\engine\utility::array_remove(getaiarray("axis"), level._id_8A26);
  var_4 = getEntArray("enemy_hangar_c12_runners", "script_noteworthy");
  var_3 = scripts\engine\utility::array_remove_array(var_3, var_4);

  if(var_3.size < 8) {
    var_5 = getspawnerarray("c12_backup");
    var_6 = min(8 - var_3.size, var_5.size);

    for(var_7 = 0; var_7 < var_6; var_7++)
      var_3[var_3.size] = var_5[var_7] scripts\sp\utility::_id_10619();
  }

  foreach(var_9 in var_3)
  var_9.threatbias = 500;

  var_11 = spawnStruct();
  var_11._id_3508 = level._id_8A26;
  _id_0A05::_id_35A8(getEntArray("c12fight_lockon_pickup", "targetname"), var_11, &"hud_interaction_prompt_center_heavy", "c12_dialogue_ended");
  var_12 = getEntArray("weapon_iw7_lockon+lockonscope", "classname");

  foreach(var_14 in var_12) {
    if(!isDefined(var_14.targetname) || var_14.targetname != "c12fight_lockon_pickup")
      var_14 delete();
  }

  var_16 = getEntArray("c12_fight_trick_crate_trig", "targetname");
  scripts\engine\utility::array_thread(var_16, ::_id_1270E, level._id_8A26);
  wait 2;
  _id_5450();
  level notify("c12_dialogue_ended");
  scripts\engine\utility::array_thread([level._id_EA2C, level._id_A54E], scripts\sp\utility::_id_F3B5, "o");
  scripts\engine\utility::array_thread([level._id_30F6, level._id_6754], scripts\sp\utility::_id_F3B5, "y");
  scripts\sp\utility::_id_13754([level._id_8A26]);
  scripts\engine\utility::flag_clear("obj_killc12");
  setmusicstate("");
  thread scripts\sp\maps\heist\heist_util::_id_1103D();
  _id_3513();
  wait 1;

  foreach(var_18 in getEntArray("trigger_multiple_friendly", "classname")) {
    if(isDefined(var_18._id_EE52) && var_18._id_EE52 == "allytrig_hangar_c12")
      var_18 scripts\engine\utility::trigger_off();
  }

  wait 0.1;
  scripts\engine\utility::array_thread(level.allies, scripts\sp\utility::_id_F3B5, "r");
  scripts\sp\utility::_id_15F5("allytrig_elevator_bottom");
  var_20 = scripts\engine\utility::getStruct("ethan_lift_door", "targetname");
  _id_138FE(level.allies, var_20.origin);
  thread _id_5451();
  var_21 = scripts\engine\utility::spawn_tag_origin(var_20.origin + (10, 0, 0), var_20.angles);
  thread lift_physics();
  var_20 scripts\sp\anim::_id_1F17(level._id_6754, "elevator_panel");
  scripts\engine\utility::delaythread(3.5, scripts\sp\maps\heist\heist_util::_id_C5F0, "door_lift_lower_outer_left", "door_lift_lower_outer_right", 1);
  scripts\engine\utility::delaythread(5.0, scripts\sp\maps\heist\heist_util::_id_C5F0, "door_lift_lower_left", "door_lift_lower_right", 1);
  level._id_6754 scripts\engine\utility::delaythread(3.0, scripts\sp\utility::_id_10346, "heist_eth_gettotheelevato");
  scripts\engine\utility::delaythread(4, scripts\engine\utility::flag_set, "obj_getonlift");
  level._id_6754 scripts\sp\utility::_id_51E1("casual_gun");
  var_20 scripts\sp\anim::_id_1F35(level._id_6754, "elevator_panel");
  wait 3;
  level._id_6754 scripts\sp\utility::_id_51E1("combat");
}

lift_physics() {
  var_0 = physics_volumecreate(level._id_AC77.origin, 300);
  var_0 physics_volumesetasdirectionalforce(1, (0, 0, 10), 1);
  var_0 physics_volumeenable(1);
  wait 2;
  var_0 delete();
}

_id_35E6() {
  self._id_1FBB = "c12";
  scripts\sp\anim::_id_1EC3(self, "c12_reveal");
  wait 1.5;

  if(!isalive(self)) {
    return;
  }
  thread _id_35CD();
  self playSound("vox_c12_threatdetected");
  self playSound("scn_europa_c12_unfold");
  scripts\sp\anim::_id_1F35(self, "c12_reveal");
}

_id_35CD() {
  wait 1;
  setmusicstate("mx_96_c12_combat");
}

_id_3513() {
  var_0 = getaiarray("axis");
  thread scripts\sp\utility::_id_1938(var_0, 128);

  while(var_0.size > 0) {
    foreach(var_2 in level.allies) {
      if(!isDefined(var_2.favoriteenemy)) {
        var_3 = scripts\sp\utility::_id_78AA(var_2.origin, "axis", [level._id_8A26]);

        if(!isDefined(var_3)) {
          return;
        }
        var_2 thread _id_350B(var_3);
      }
    }

    scripts\engine\utility::waitframe();
    var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);
  }
}

_id_350B(var_0) {
  var_1 = self._id_2894;
  self.favoriteenemy = var_0;
  self._id_2894 = 9000;

  while(isDefined(var_0) && isalive(var_0))
    scripts\engine\utility::waitframe();

  self.favoriteenemy = undefined;
  self._id_2894 = var_1;
}

_id_1270E(var_0) {
  var_0 endon("death");
  wait 3.2;
  var_1 = var_0.goalradius;
  var_2 = var_0.goalpos;

  for(;;) {
    self waittill("trigger");

    if(var_0 scripts\asm\asm_bb::ispartdismembered("right_leg") || var_0 scripts\asm\asm_bb::ispartdismembered("left_leg")) {
      break;
    }

    if(!var_0 _id_0C08::_id_9F5B("right")) {
      break;
    }

    var_3 = getnode(self.target, "targetname");

    if(level.player scripts\sp\utility::_id_CFAC(var_0) || level.player scripts\sp\utility::_id_D1DF(var_3.origin, 0)) {
      continue;
    }
    var_0 _id_0A05::_id_3551(0);
    var_0.ignoreall = 1;

    if(!var_0 scripts\asm\asm_bb::bb_canrodeo("left") && (!isDefined(var_0._id_30E9) || !var_0._id_30E9)) {
      var_0 _meth_80F1(var_3.origin, var_3.angles);
      scripts\engine\utility::waitframe();
    }

    var_0.goalradius = var_3.radius;
    var_0 _meth_82EE(var_3);

    while(!var_0 _meth_84BA() && level.player istouching(self))
      scripts\engine\utility::waitframe();

    var_0.ignoreall = 0;

    if(!level.player istouching(self)) {
      var_0.goalradius = var_1;
      var_0 setgoalpos(var_2);
      var_0 _id_0A05::_id_3551(1);
      continue;
    }

    var_0._id_11B06 = 1;
    var_0 _id_0A05::_id_360D("right", [level.player], undefined, 0);
    var_4 = 0;

    while(level.player istouching(self)) {
      var_0 waittill("rocket_fired", var_5);
      var_6 = level._id_8A35[self._id_EE52];

      if(self.script_parameters == "front")
        var_7 = (var_6.front_left.origin + var_6.front_right.origin) / 2;
      else
        var_7 = (var_6._id_0057.origin + var_6._id_005A.origin) / 2;

      while(!var_4 && isDefined(var_5)) {
        var_4 = distance2dsquared(var_5.origin, var_7) <= squared(64);
        scripts\engine\utility::waitframe();
      }

      if(!var_4) {
        continue;
      }
      var_0 scripts\sp\maps\heist\heist_hangar::_id_52A3(self._id_EE52, self.script_parameters);
      playFX(scripts\engine\utility::getfx("vfx_heist_crate_explosion"), var_7);
      break;
    }

    var_0.goalradius = var_1;
    var_0 setgoalpos(var_2);
    wait 5;
    var_0 _id_0A05::_id_352D("right");
    var_0 _id_0A05::_id_3551(1);

    if(var_4) {
      break;
    }
  }
}

_id_138FE(var_0, var_1) {
  var_2 = sortbydistance(getnodesinradius(var_1, 1024, 0, 128), var_1);

  foreach(var_4 in var_0) {
    if(distance(level.player.origin, var_4.origin) < 512) {
      continue;
    }
    if(level.player scripts\sp\utility::_id_CFAC(var_4)) {
      continue;
    }
    foreach(var_6 in var_2) {
      if(!level.player scripts\sp\utility::_id_D1DF(var_6.origin, 0.5, 1)) {
        var_4 _meth_80F1(var_6.origin, var_6.angles);
        var_2 = scripts\engine\utility::array_remove(var_2, var_6);
        break;
      }
    }
  }

  scripts\engine\utility::waitframe();
}

_id_5450() {
  wait 1.5;
  level._id_EA2C scripts\sp\utility::_id_10346("heist_slt_c12mega");
  var_0 = _id_137E9();

  if(isDefined(var_0))
    level.player scripts\sp\utility::_id_1034D("heist_plr_iseehim");

  scripts\engine\utility::flag_set("obj_killc12");
  wait 0.15;
  level._id_6754 scripts\sp\utility::_id_10346("heist_eth_destroyitcaptai");

  if(!isDefined(var_0)) {
    var_0 = _id_137E9();

    if(!isDefined(var_0)) {
      level._id_30F6 scripts\sp\utility::_id_10346("UN_brk_inform_incoming_c12");
      var_0 = _id_137E9();

      if(isDefined(var_0))
        level.player scripts\sp\utility::_id_1034D("heist_plr_iseehim");
    }
  }
}

_id_137E9() {
  level endon("stop_waiting_for_player_see_c12");
  level thread scripts\sp\utility::_id_C12D("stop_waiting_for_player_see_c12", 5);

  while(isalive(level._id_8A26)) {
    if(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), level._id_8A26.origin, cos(40))) {
      if(_id_0B1D::_id_385C(level.player getEye(), level._id_8A26))
        return 1;
    }

    wait 0.1;
  }
}

_id_5451() {
  scripts\sp\utility::_id_CF8B();
  scripts\sp\utility::_id_28D7("allies");
  scripts\sp\utility::_id_28D7("axis");
  wait 1;
  level._id_EA2C scripts\sp\utility::_id_10346("heist_slt_megasdown");
  level._id_A54E scripts\sp\utility::_id_10346("heist_ksh_wereclear");
  level._id_30F6 scripts\sp\utility::_id_10346("heist_brk_allclear");
  scripts\engine\utility::flag_clear("obj_securethehangar");
  level._id_EA2C scripts\sp\utility::_id_10346("heist_slt_dragassletsgo");
}