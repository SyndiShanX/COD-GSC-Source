/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3861.gsc
**************************************/

_id_FA78(var_0, var_1, var_2) {
  _id_12BF0();
  _id_12BF1();
  _id_12BF2();
  var_3 = [];
  level.player freezecontrols(1);
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowsprint(0);
  level.player _meth_80D1();
  level.player disableweapons();
  var_4 = _id_0BBF::_id_106B8(var_0);
  var_4 _id_0BBF::_id_106BA();
  var_4 notify("stop_monitor_player_in_dropship");
  var_4 notify("player_exited_dropship");
  var_4 thread _id_0BBF::_id_F459(1);
  var_4 _id_0BBF::_id_5E02(var_2);
  var_5 = scripts\sp\utility::_id_10639("player_arms", (0, 0, 0), (0, 0, 0));
  var_5._id_12BEF = var_4;
  var_3[var_3.size] = var_5;
  var_6 = [];
  var_7 = [];

  if(isDefined(var_4._id_4D94._id_F08B["left_01"])) {
    var_8 = var_4 _id_0BBF::_id_796D("left_01");
    var_8._id_1FBB = "left_01";
    var_7[var_7.size] = var_8;
  }

  if(isDefined(var_1)) {
    var_6 = [];

    foreach(var_10 in var_1) {
      var_11 = var_10 scripts\sp\utility::_id_10619(1);
      var_6[var_6.size] = var_11;
    }

    var_13 = 1;
    var_14 = [];

    foreach(var_11 in var_6) {
      if(isDefined(var_11._id_EEC9)) {
        var_14[var_14.size] = var_11;
      }
    }

    if(var_14.size == var_6.size) {
      foreach(var_11 in var_6) {
        if(isDefined(var_4._id_4D94._id_F08B["right_0" + var_11._id_EEC9])) {
          var_8 = var_4 _id_0BBF::_id_796D("right_0" + var_11._id_EEC9);
          var_8._id_1FBB = "right_0" + var_11._id_EEC9;
          var_7[var_7.size] = var_8;
          var_11._id_1FBB = "infil_ally_" + var_11._id_EEC9;
          var_3 = scripts\engine\utility::array_add(var_3, var_11);
        }
      }
    } else {
      foreach(var_11 in var_6) {
        var_11._id_1FBB = "infil_ally_" + var_13;
        var_3 = scripts\engine\utility::array_add(var_3, var_11);

        if(isDefined(var_4._id_4D94._id_F08B["right_0" + var_13])) {
          var_8 = var_4 _id_0BBF::_id_796D("right_0" + var_13);
          var_8._id_1FBB = "right_0" + var_13;
          var_7[var_7.size] = var_8;
        }

        var_13++;
      }
    }
  }

  var_3 = scripts\engine\utility::array_combine(var_3, var_7);

  foreach(var_22 in var_3) {
    var_22 linkTo(var_4, "TAG_SEAT_LEFT_01");
  }

  var_4 thread scripts\sp\anim::_id_1EE7(var_3, "infil_loop", "stop_infil_loop", "TAG_SEAT_LEFT_01");
  level.player _meth_823B(var_5, "tag_player");
  scripts\engine\utility::waitframe();
  level.player playerlinktodelta(var_5, "tag_player", 0.5, 90, 90, 30, 30, 1);

  if(!isDefined(level._id_12BCE)) {
    var_4 thread _id_12BCD(var_3, var_5, var_6);
  } else {
    var_4 thread[[level._id_12BCE]](var_3, var_5, var_6);
  }

  return var_4;
}

_id_12BCD(var_0, var_1, var_2) {
  self waittill("stop_infil_loop");
  level.player lerpviewangleclamp(0.75, 0.25, 0.5, 0, 0, 0, 0);
  wait 0.05;
  thread scripts\sp\anim::_id_1F2C(var_0, "infil_exit", "TAG_SEAT_LEFT_01");
  scripts\engine\utility::array_thread(var_2, ::_id_12BAB);
  var_1 waittillmatch("single anim", "end");
  level.player unlink();
  level.player allowsprint(1);
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player _meth_80A1();
  var_1 delete();
  level.player notify("player_unloaded_from_drop_ship");
  thread _id_0BBC::_id_4265(["right"], 1);
}

_id_12BAB() {
  self waittillmatch("single anim", "end");
  self unlink();
  self notify("unloaded_from_drop_ship");
}

#using_animtree("generic_human");

_id_12BF0() {
  level._id_EC87["generic"] = #animtree;
  level._id_EC85["infil_ally_1"]["infil_loop"][0] = % hm_zg_un_dropship_infil_ally1_loop;
  level._id_EC85["infil_ally_1"]["infil_exit"] = % hm_zg_un_dropship_infil_ally1_exit;
  level._id_EC85["infil_ally_2"]["infil_loop"][0] = % hm_zg_un_dropship_infil_ally2_loop;
  level._id_EC85["infil_ally_2"]["infil_exit"] = % hm_zg_un_dropship_infil_ally2_exit;
  level._id_EC85["infil_ally_3"]["infil_loop"][0] = % hm_zg_un_dropship_infil_ally3_loop;
  level._id_EC85["infil_ally_3"]["infil_exit"] = % hm_zg_un_dropship_infil_ally3_exit;
}

#using_animtree("player");

_id_12BF1() {
  level._id_EC87["player_arms"] = #animtree;
  level._id_EC8C["player_arms"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["player_arms"]["infil_loop"][0] = % vm_zg_un_dropship_infil_loop;
  level._id_EC85["player_arms"]["infil_exit"] = % vm_zg_un_dropship_infil_exit;
  scripts\sp\anim::_id_17F6("player_arms", "open_door", ::_id_C5ED, "infil_exit");
  scripts\sp\anim::_id_17F6("player_arms", "gun_up", ::_id_DC49, "infil_exit");
}

#using_animtree("script_model");

_id_12BF2() {
  level._id_EC87["left_01"] = #animtree;
  level._id_EC8C["left_01"] = "veh_mil_air_un_dropship_seat";
  level._id_EC85["left_01"]["infil_loop"][0] = % vh_zg_un_dropship_infil_seatplr_loop;
  level._id_EC85["left_01"]["infil_exit"] = % vh_zg_un_dropship_infil_seatplr_exit;
  level._id_EC87["right_01"] = #animtree;
  level._id_EC8C["right_01"] = "veh_mil_air_un_dropship_seat";
  level._id_EC85["right_01"]["infil_loop"][0] = % vh_zg_un_dropship_infil_seat1_loop;
  level._id_EC85["right_01"]["infil_exit"] = % vh_zg_un_dropship_infil_seat1_exit;
  level._id_EC87["right_02"] = #animtree;
  level._id_EC8C["right_02"] = "veh_mil_air_un_dropship_seat";
  level._id_EC85["right_02"]["infil_loop"][0] = % vh_zg_un_dropship_infil_seat2_loop;
  level._id_EC85["right_02"]["infil_exit"] = % vh_zg_un_dropship_infil_seat2_exit;
  level._id_EC87["right_03"] = #animtree;
  level._id_EC8C["right_03"] = "veh_mil_air_un_dropship_seat";
  level._id_EC85["right_03"]["infil_loop"][0] = % vh_zg_un_dropship_infil_seat3_loop;
  level._id_EC85["right_03"]["infil_exit"] = % vh_zg_un_dropship_infil_seat3_exit;
}

_id_DC49(var_0) {
  level.player enableweapons();
}

_id_C5ED(var_0) {
  var_0._id_12BEF _id_0BBC::_id_C5F1(["right"]);

  if(isDefined(var_0._id_12BEF._id_4D94._id_5A27._id_4348)) {
    var_0._id_12BEF._id_4D94._id_5A27._id_4348 thread _id_0F00::_id_5DBA();
  }
}