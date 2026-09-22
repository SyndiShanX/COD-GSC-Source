/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_ee_overcharge.gsc
************************************************************/

main() {
  for(var_0 = 1; var_0 <= 3; var_0++) {
    common_scripts\utility::flag_init("quest_item_blimp_uberschnelle_" + var_0);
  }

  var_1 = maps\mp\mp_zombie_nest_ee_util::_id_44C8("blimp_uberschnell_deposit");

  foreach(var_3 in var_1) {
    var_3 hide();
  }

  var_5 = _getEnt("lhog_control", "targetname");

  if(isDefined(var_5)) {
    var_5 thread maps\mp\mp_zombie_nest_ee_util::_id_4D77("off");
  }

  var_1[0] show();
  _playFXOnTag(level._effect["zmb_uberschnelle_charge"], var_1[0], "tag_origin");
  _id_0557::_id_7846("6B Left Hand overcharge", ::_id_6C9E, ["5 Right Hand fuses"], &"ZOMBIE_NEST_HINT_QUEST_OVERCHARGE", "ZOMBIE_NEST_HINT_QUEST_OVERCHARGE");
  _id_0557::_id_781E("6B Left Hand overcharge", "examine left hand", ::_id_7862, _id_0557::_id_30D8, &"ZOMBIE_NEST_STUDY_LEFT_HAND");
  _id_0557::_id_781E("6B Left Hand overcharge", "activate left hand", ::_id_7861, ::_id_714D, &"ZOMBIE_NEST_HINT_STEP_INTERACT_LEFT_HAND");
  _id_0557::_id_7848("6B Left Hand overcharge");
  _id_0557::_id_7846("6A Left Hand blimp parts", _id_0557::_id_30D8, ["5 Right Hand fuses"], &"ZOMBIE_NEST_HINT_QUEST_BLIMP", "ZOMBIE_NEST_HINT_QUEST_BLIMP");
  _id_0557::_id_781E("6A Left Hand blimp parts", "Blimp Battery Hunt", ::_id_784B, _id_0557::_id_30D8, &"ZOMBIE_NEST_BLIMP_ROAMING");
  _id_0557::_id_7848("6A Left Hand blimp parts");
}

_id_6C9E() {
  foreach(var_1 in level.players) {
    var_1 _id_054C::_id_AC23("lefthandofgod");
    var_1 _id_0378::_id_8D74("objective_complete", "lefthandofgod");
  }
}

_id_714D() {
  var_0 = _getEnt("left_hand_of_god_model", "targetname");
  _playFXOnTag(level._effect["zmb_lhog_init"], var_0, "tag_origin");
}

_id_7862() {
  level notify("nest_ee_fuses_complete");
  var_0 = _getEnt("overcharge_trig", "targetname");
  var_0._id_4D91 = _id_0559::_id_7BE3(var_0, "lhog");
  var_0 setHintString(&"ZOMBIES_SWITCH_HINT_GENERIC_EXAMINE");
  var_0._id_17A9 = 0;
  var_1 = _getEnt("left_hand_of_god_model", "targetname");
  var_2 = _getEnt("lhog_control", "targetname");

  if(isDefined(var_2)) {
    var_2 thread maps\mp\mp_zombie_nest_ee_util::_id_4D77("red");
  }

  if(1) {
    var_3 = _id_0557::_id_782F(undefined, [var_1]);
    _id_0557::_id_781D("6B Left Hand overcharge", var_3);
  }

  var_1 thread _id_20C7(var_0);
  var_4 = maps\mp\mp_zombie_nest_ee_util::_id_44C8("blimp_uberschnell_deposit");
  var_0 thread _id_8C24();

  while(var_0._id_17A9 < 3) {
    level thread _id_92B6(var_0);
    var_0 waittill("trigger", var_8);

    if(var_8 _id_0585::_id_9E12("Blimp Battery Hunt")) {
      var_0._id_17A9++;
      var_0 notify("blimp part was deposited");

      if(var_0._id_17A9 == 1) {
        thread _id_2E9C(1, var_8);
        _id_0557::_id_7822("6B Left Hand overcharge", &"ZOMBIE_NEST_HINT_STEP_MORE_BATTERIES");
      } else if(var_0._id_17A9 == 2)
        thread _id_2E9C(2, var_8);
      else if(var_0._id_17A9 == 3) {
        thread _id_2E9C(3, var_8);
      }

      var_4[var_0._id_17A9] show();
      _playFXOnTag(level._effect["zmb_uberschnelle_charge"], var_4[var_0._id_17A9], "tag_origin");
      _id_0378::_id_8D74("aud_uberschnelle_place_altar");
      _id_86A4();
      common_scripts\utility::flag_set("quest_item_blimp_uberschnelle_" + var_0._id_17A9);
    }
  }

  var_0 notify("stop_hide_show");
  waitframe();
  var_0 common_scripts\utility::_id_9DA3();
  _id_0557::_id_782D("6A Left Hand blimp parts", "Blimp Battery Hunt");
  _id_0557::_id_782D("6B Left Hand overcharge", "examine left hand");
}

_id_92B6(var_0) {
  var_0 notify("start zombie blocking behavior");
  var_0 endon("start zombie blocking behavior");
  var_0 endon("blimp part was deposited");
  level waittill("player grabbed uber battery");
  var_1 = common_scripts\utility::_id_46B7("zombie_spawner", "script_noteworthy");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.setgoalnode) && var_3.setgoalnode == "zombie_blimp_player_blocker") {
      var_3 childthread _id_179C();
    }
  }
}

_id_179C() {
  self._id_686D = randomint(3) + 1;

  if(isDefined(self.target)) {
    self._id_301B = common_scripts\utility::_id_46B5(self.target, "targetname");
  }

  while(self._id_686D > 0) {
    foreach(var_1 in level.players) {
      if(isDefined(self._id_301B)) {
        var_2 = distance(self._id_301B.origin, var_1.origin) < 150;
      } else {
        var_2 = distance(var_1.origin, self.origin) < 512;
      }

      if(var_1 _id_0586::_id_72C3() && var_2) {
        var_3 = self._id_686D;

        for(var_4 = 0; var_4 < var_3; var_4++) {
          var_5 = _id_054D::_id_90BA("zombie_generic", self, "blimp part blocker", 0, 1, 1);
          self._id_686D--;
          wait 2;
        }
      }
    }

    wait 0.125;
  }
}

_id_7861() {
  var_0 = _getEnt("left_hand_of_god_model", "targetname");
  var_1 = _getEnt("overcharge_trig", "targetname");
  var_1 setHintString(&"ZOMBIE_NEST_ENABLE_LEFT_HAND");

  if(1) {
    var_2 = undefined;

    if(isDefined(var_0)) {
      var_2 = _id_0557::_id_782F(undefined, [var_0]);
      _id_0557::_id_781D("6B Left Hand overcharge", var_2);
    }
  }

  wait 0.5;
  var_1 waittill("trigger", var_3);
  var_4 = _getEnt("lhog_control", "targetname");

  if(isDefined(var_4)) {
    var_4 thread maps\mp\mp_zombie_nest_ee_util::_id_4D76();
    var_4 thread maps\mp\mp_zombie_nest_ee_util::_id_4D77("green");
  }

  thread _id_2E73(var_3);
  var_1 common_scripts\utility::_id_9D9F();
  var_0 _id_0378::_id_8D74("aud_activate_left_hand_of_god");
  thread maps\mp\mp_zombie_nest_ee_util::_id_4D78(2);
  _id_0557::_id_782D("6B Left Hand overcharge", "activate left hand");
}

_id_8C24() {
  self endon("stop_hide_show");
  var_0 = self.origin;

  for(;;) {
    var_1 = 0;

    foreach(var_3 in level.players) {
      if(var_3 _id_0586::_id_72C3() && distance(var_3.origin, var_0) < 256) {
        var_1 = 1;
        break;
      }
    }

    if(var_1) {
      common_scripts\utility::_id_9DA3();
    } else {
      common_scripts\utility::_id_9D9F();
    }

    wait 0.5;
  }
}

_id_784B() {
  level._id_179A _id_0560::_id_AB83();
  var_0 = 0;

  while(!var_0) {
    foreach(var_2 in level.players) {
      if(var_2 maps\mp\mp_zombie_nest_ee_util::_id_740A()) {
        var_0 = 1;
        break;
      }
    }

    wait 1;
  }

  while(!isDefined(level._id_179A._id_6655)) {
    wait 1;
  }

  thread _id_86A7(level._id_179A._id_6655);
}

_id_40C0(var_0) {
  return "quest_item_blimp_uberschnelle_" + var_0;
}

_id_41E7() {
  return _id_0557::_id_7838("6B Left Hand overcharge", "activate left hand", 1);
}

_id_95F4() {
  level notify("nest_ee_overcharge_remove_uberschnell_hint");
  waitframe();
  self._id_65DF delete();
  self notify("blimp_part_deposited");
}

_id_2E9C(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  switch (var_0) {
    case 1:
      var_1 thread _id_0367::_id_8E3C("lefthandaltaruber1");
      break;
    case 2:
      var_1 thread _id_0367::_id_8E3C("lefthandaltaruber2");
      break;
    case 3:
      var_1 thread _id_0367::_id_8E3C("lefthandaltaruber3");
      break;
  }
}

_id_2E73(var_0) {
  var_0 thread _id_0367::_id_8E3C("lefthandaltaractivated");
}

_id_A788(var_0, var_1) {
  if(common_scripts\utility::_id_562E(level._id_1CBA)) {
    return;
  }
  var_1 thread _id_A787(var_0);
  level waittill(var_0, var_1);

  if(!common_scripts\utility::_id_562E(var_1._id_73E3)) {
    _id_86A5(var_1);
  }
}

_id_A787(var_0) {
  level endon(var_0);

  for(;;) {
    var_1 = common_scripts\utility::_id_4461(self.origin, level.players, 200);

    if(isDefined(var_1)) {
      break;
    } else
      wait 1;
  }

  _id_86A5(self);
  self._id_73E3 = 1;
}

_id_86A7(var_0) {
  if(common_scripts\utility::_id_562E(level._id_1CBA)) {
    return;
  }
  var_1 = undefined;

  if(0) {
    var_1 = _id_0557::_id_782F(undefined, [var_0]);
    _id_0557::_id_781D("6A Left Hand blimp parts", var_1);
  }

  _id_0557::_id_7822("6A Left Hand blimp parts", &"ZOMBIE_NEST_SHOOT_BLIMP_GUN");
  level common_scripts\utility::_id_A70A("destroyed_blimp_gun", "blimp_ee_look_for_battery");

  if(0) {
    _id_0557::_id_7847("6A Left Hand blimp parts", var_1);
  }
}

_id_86A4() {
  if(common_scripts\utility::_id_562E(level._id_1CBA)) {
    return;
  }
  _id_0557::_id_7822("6A Left Hand blimp parts", &"ZOMBIE_NEST_FINISH_ZEPPELIN_ZOMBIE_ROUND");
}

_id_86A6() {
  if(common_scripts\utility::_id_562E(level._id_1CBA)) {
    return;
  }
  level notify("blimp_ee_look_for_battery");
  _id_0557::_id_7822("6A Left Hand blimp parts", &"ZOMBIE_NEST_FIND_DROPPED_BATTERY");
}

_id_86A5(var_0) {
  if(common_scripts\utility::_id_562E(level._id_1CBA)) {
    return;
  }
  var_1 = undefined;

  if(0) {
    var_1 = _id_0557::_id_782F(undefined, [var_0]);
    _id_0557::_id_781D("6A Left Hand blimp parts", var_1);
  }

  _id_0557::_id_7822("6A Left Hand blimp parts", &"ZOMBIE_NEST_BLIMP_KILL_ZOMBIES");
  level waittill("nest_ee_overcharge_remove_uberschnell_hint");

  if(0) {
    _id_0557::_id_7847("6A Left Hand blimp parts", var_1);
  }
}

_id_86A3() {
  if(common_scripts\utility::_id_562E(level._id_1CBA)) {
    return;
  }
  _id_0557::_id_7822("6A Left Hand blimp parts", &"ZOMBIE_NEST_BRING_BATTERY_TO_ALTER");
}

_id_8C89() {
  if(common_scripts\utility::_id_562E(level._id_1CBA) || common_scripts\utility::_id_562E(level._id_5C6A)) {
    return;
  }
  level._id_5C6A = 0;
  var_0 = _getEnt("overcharge_trig", "targetname");
  var_0 notify("bypassed");
}

_id_20C7(var_0) {
  if(common_scripts\utility::_id_562E(level._id_1CBA)) {
    return;
  }
  var_0 thread _id_2EB0();
  var_0 thread _id_2E8D();
  var_0 common_scripts\utility::_id_A70A("trigger", "soft_triggered", "bypassed");
  _id_0557::_id_7822("6B Left Hand overcharge", &"ZOMBIE_NEST_HINT_STEP_BATTERIES");
  var_0 setHintString(&"ZOMBIE_NEST_PLACE_UBER");
  var_0 notify("discovered");
}

_id_2E8D() {
  self endon("discovered");
  self waittill("trigger", var_0);
  var_0 thread _id_0367::_id_8E3C("lefthandaltarclue");
}

_id_2EB0() {
  if(common_scripts\utility::_id_562E(level._id_1CBA)) {
    return;
  }
  self endon("discovered");
  var_0 = 0;
  var_1 = 0.7;
  var_2 = 0.05;
  var_3 = undefined;

  for(;;) {
    var_4 = 0;

    foreach(var_6 in level.players) {
      if(distance(var_6.origin, self.origin) < 64) {
        var_4 = 1;
        var_3 = var_6;
      }
    }

    if(var_4) {
      var_0 = var_0 + var_2;
    } else {
      var_0 = 0;
    }

    if(var_0 >= var_1) {
      if(isDefined(var_3)) {
        var_3 thread _id_0367::_id_8E3C("lefthandaltarclue");
      }

      self notify("soft_triggered");
      break;
    }

    wait(var_2);
  }
}