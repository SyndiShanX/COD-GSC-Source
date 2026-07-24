/****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\shipcrib_moon\shipcrib_moon_code.gsc
****************************************************************/

_id_49FE(var_0, var_1, var_2) {
  var_3 = scripts\sp\utility::_id_10639("door_player_rig");
  var_0 thread scripts\sp\anim::_id_1EC3(var_3, var_1);

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(var_2) {
    var_3 hide();
  }

  return var_3;
}

_id_BCD8(var_0) {
  _id_CF95(var_0, "tag_player", 4, 5, 30);
}

_id_CF95(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_AD0F();
  level.player _meth_823C(var_0, var_1, var_2, var_2 * 0.25, var_2 * 0.25);
  wait(var_2);
  level.player playerlinktodelta(var_0, var_1, 0, var_3, var_3, var_3, var_3);
  level.player setviewangleresistance(var_4, var_4, var_4, var_4);
  var_5 delete();
}

_id_AD0F() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0.origin = level.player.origin;
  var_0.angles = level.player getplayerangles();
  level.player _meth_823B(var_0, "tag_origin");
  scripts\engine\utility::waitframe();
  return var_0;
}

_id_5569() {
  level.player freezecontrols(1);
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowsprint(0);
}

_id_6229() {
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player allowsprint(1);
}

_id_5B35(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "tag_origin";
  }

  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  _id_0E46::_id_48C4(var_0, var_1, &"SHIPCRIB_USETERMINAL");
  _id_0E46::_id_9016();
}

_id_137D5(var_0) {
  while(distance(self.origin, level.player.origin) > var_0) {
    wait 0.1;
  }
}

_id_DD33(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 256;
  }

  while(!scripts\engine\utility::flag(var_2)) {
    scripts\engine\utility::waitframe();

    if(distance(level.player.origin, var_0.origin) < var_3) {
      thread[[var_1]]();
      break;
    }
  }
}

_id_DD34(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 256;
  }

  var_4 = var_0.origin + (0, 0, 64);

  while(!scripts\engine\utility::flag(var_2)) {
    scripts\engine\utility::waitframe();

    if(distance(level.player.origin, var_0.origin) < var_3) {
      if(level.player scripts\sp\utility::_id_3849(var_4, 0)) {
        thread[[var_1]]();
        break;
      }
    }
  }
}

_id_F70A(var_0, var_1) {
  self waittill(var_1);
  scripts\engine\utility::flag_set(var_0);
}

_id_F709(var_0, var_1) {
  while(distance(level.player.origin, self.origin) > var_1) {
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_set(var_0);
}

_id_49E5(var_0, var_1, var_2) {}

_id_E851(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = level;
  }

  var_2 waittill(var_1);
  [[var_0]]();
}

#using_animtree("generic_human");

_id_DEC2() {
  level._id_EC85["omar"]["elevator_nativity"] = % hm_grnd_grn_kneel_idle_01;
  level._id_EC85["brooks"]["elevator_nativity"] = % hm_grnd_grn_kneel_idle_01;
  level._id_EC85["kash"]["elevator_nativity"] = % hm_grnd_grn_kneel_idle_01;
  level._id_EC85["nunez"]["elevator_nativity"] = % hm_grnd_grn_kneel_idle_01;
  level._id_EC85["marcus"]["elevator_nativity"] = % shipcrib_marine_idle_07_sleeping_01;
  level._id_EC85["salter"]["elevator_nativity"] = % moon_intro_ally_a_idle;
}