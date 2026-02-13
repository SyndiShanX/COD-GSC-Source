/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2658.gsc
*************************************************/

init() {
  scripts\mp\playeractions::_id_C23B("throwback_marker", ["usability", "gesture"]);
}

_id_F17C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = ::_id_F183;
  var_9 = ::_id_F185;
  var_10 = ::_id_F181;
  var_11 = ::_id_F187;
  var_0._id_F180 = var_1;
  var_0._id_F184 = var_3;
  var_0._id_F186 = var_4;
  var_0._id_F182 = var_5;
  var_0._id_F188 = var_7;
  var_12 = _id_09B9::_id_EA02(var_0, var_2, var_8, var_9, var_10, var_6, var_11);

  if(!istrue(var_12)) {
    return 0;
  }

  return 1;
}

_id_F183(var_0) {
  var_1 = 1;

  if(isDefined(var_0._id_F184)) {
    var_1 = level[[var_0._id_F184]](var_0);
  }

  return var_1;
}

_id_F185(var_0, var_1) {
  if(istrue(var_1)) {
    thread _id_F17E(var_0);
  }

  if(isDefined(var_0._id_F186)) {
    level thread[[var_0._id_F186]](var_0, var_1);
  }
}

_id_F17E(var_0) {
  self endon("disconnect");
  self notifyonplayercommand("cancel_deploy", "+actionslot 3");
  self notifyonplayercommand("cancel_deploy", "+actionslot 4");
  self notifyonplayercommand("cancel_deploy", "+actionslot 5");
  self notifyonplayercommand("cancel_deploy", "+actionslot 6");
  var_1 = scripts\engine\utility::_id_10897("cancel_deploy", "weapon_switch_started");

  if(!isDefined(var_1)) {
    return;
  }
  var_0 notify("killstreak_finished_with_deploy_weapon");
}

_id_F181(var_0, var_1, var_2) {
  var_3 = "success";
  level thread _id_F17D(var_0, var_2, self);
  level thread _id_F17F(var_0, var_2);

  if(isDefined(var_0._id_F182)) {
    var_3 = [[var_0._id_F182]](var_0, var_1, var_2);
  }

  return var_3;
}

_id_F17D(var_0, var_1, var_2) {
  level endon("game_ended");
  var_1 endon("trigger");
  var_1 waittill("explode", var_3);

  if(isDefined(var_0._id_F180)) {
    [[var_0._id_F180]](var_0, var_3, var_2);
  }
}

_id_F17F(var_0, var_1) {
  var_1 endon("fired_off");
  var_1 waittill("trigger", var_2);
  var_2 endon("death_or_disconnect");
  var_2 waittill("grenade_fire", var_3, var_4);
  level thread _id_F17D(var_0, var_3, var_2);
  level thread _id_F17F(var_0, var_3);
  var_2 thread _id_F17B(var_4);
}

_id_F17B(var_0) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_1 = 0;

  while(var_1 < 5) {
    if(self hasweapon(var_0)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    } else {
      var_1 = var_1 + 1;
    }

    wait 0.05;
  }
}

_id_F187(var_0) {
  if(isDefined(var_0._id_F188)) {
    [[var_0._id_F188]](var_0);
  }
}