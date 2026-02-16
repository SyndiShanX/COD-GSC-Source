/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2435.gsc
*************************************************/

_id_C0DC(var_0, var_1) {
  _id_0737::_id_C3C5(var_0);
  var_2 = 0;
  var_3 = scripts\cp\utility::_id_63D8(var_1.origin);
  var_4 = 5184;
  var_5 = anglesToForward(var_3.angles);
  var_5 = scripts\cp\utility::_id_FFD6(var_5, -200);
  var_6 = var_3.origin + var_5;
  var_1._id_C0DE = var_0;

  while(!level.gameended && isDefined(var_1) && scripts\cp\utility\player::isreallyalive(var_1) && (var_1 useButtonPressed() && (!isDefined(var_1._id_0271) || !var_1._id_0271))) {
    if(distancesquared(var_1.origin, var_0.origin) > var_4) {
      break;
    }

    var_7 = 10;
    var_8 = var_7;
    var_9 = var_3._id_2290._id_A74E < 6;

    if(isDefined(level._id_32FF)) {
      var_7 = 10 * level._id_32FF;

      if(level._id_32FF > 1) {
        var_8 = int(var_8 / 2);
      }
    }

    var_10 = _id_0999::_id_65DB(var_3);

    if(!isDefined(var_10)) {
      wait 0.5;
      break;
    }

    if(var_1 scripts\cp\utility::_id_8580("faster_window_reboard")) {
      var_7 = 50 * var_10 * level._id_32FF;
      var_8 = var_8 * var_10;
      level _id_C0E6(var_3);
      level notify("reboard", 1, var_1);

      for(var_11 = 0; var_11 < var_10; var_11++) {
        var_1 _id_0741::_id_BD77("mt_rebuild_barriers");
      }

      var_1 scripts\cp\utility::_id_A689("faster_window_reboard");
    } else {
      _id_0999::_id_D177(var_3, var_10 - 1, "repairing");
      _id_C0E3(var_3, var_10, var_6, var_0, var_1);
      level notify("reboard", 1, var_1);
      var_1 _id_0741::_id_BD77("mt_rebuild_barriers");
      _id_0999::_id_D177(var_3, var_10 - 1, "boarded");
    }

    var_1._id_C0DD = var_1._id_C0DD + var_8;

    if(isDefined(var_1._id_C0DD) && var_1._id_C0DD <= level._id_9C0A && var_9) {
      var_1 playlocalsound("purchase_generic");
      var_1 thread _id_076F::_id_F72D("reinforce_window", "zmb_comment_vo", "low", 10, 0, 0, 0, 10);
      var_2 = 1;
      var_1 _id_074E::_id_6F28(var_7);
    }

    var_3._id_2290._id_A74E++;

    if(var_3._id_2290._id_A74E > 6) {
      var_3._id_2290._id_A74E = 6;
    }

    if(!isDefined(_id_0999::_id_65DB(var_3))) {
      break;
    }
  }

  var_1._id_C0DE = undefined;

  if(var_3._id_2290._id_A74E == 6) {
    var_1 thread _id_076F::_id_F72D("reinforce_window", "zmb_comment_vo", "low", 10, 0, 0, 1, 25);
  }

  _id_0737::_id_1037(var_0);
}

_id_C0E1(var_0) {
  var_1 = _func_0204(level._id_10E3B, var_0.origin);

  foreach(var_3 in var_1) {
    if(scripts\cp\utility::_id_551B(var_3)) {
      continue;
    }
    level thread _id_C0E6(var_3);
    wait 0.5;
  }

  var_5 = 200;

  if(isDefined(level._id_32FF)) {
    var_5 = 200 * level._id_32FF;
  }

  foreach(var_7 in level.players) {
    if(istrue(var_7.inlaststand)) {
      continue;
    }
    var_7 _id_074E::_id_6F28(var_5, undefined, undefined, 1, "carpenter");
  }
}

_id_C0E6(var_0) {
  var_1 = anglesToForward(var_0.angles);
  var_1 = scripts\cp\utility::_id_FFD6(var_1, -200);
  var_2 = var_0.origin + var_1;
  var_3 = scripts\engine\utility::_id_6969(var_0.origin, level._id_417B);
  var_4 = 0;

  while(!scripts\cp\utility::_id_551B(var_0)) {
    if(scripts\cp\utility::_id_551B(var_0)) {
      return;
    }
    var_5 = _id_0999::_id_65DB(var_0);

    if(!isDefined(var_5)) {
      return;
    }
    _id_C0E4(var_0, var_5, var_2, var_3);
  }
}

_id_C0E4(var_0, var_1, var_2, var_3) {
  _id_0999::_id_D177(var_0, var_1 - 1, "boarded");
  var_0._id_2290 _id_0999::_id_D16E("board_" + var_1, "instant_repair");
  wait 0.25;
  var_0._id_2290._id_A74E++;

  if(var_0._id_2290._id_A74E > 6) {
    var_0._id_2290._id_A74E = 6;
  }
}

_id_C0E3(var_0, var_1, var_2, var_3, var_4) {
  if(var_4 scripts\cp\utility::_id_7531("perk_machine_flash")) {
    var_5 = 0.5;
    var_0._id_2290 _id_0999::_id_D16E("board_" + var_1, "fast_repair");
  } else {
    var_5 = 1;
    var_0._id_2290 _id_0999::_id_D16E("board_" + var_1, "repair");
  }

  wait(var_5);
}

_id_C1EF() {
  if(isDefined(level._id_C0DB)) {
    level._id_835D["secure_window"] = level._id_C0DB;
  } else {
    level._id_835D["secure_window"] = &"CP_ZMB_INTERACTIONS/SECURE_WINDOW";
  }

  _id_0737::_id_C1EE("secure_window", "window_board", 1, undefined, ::_id_C0DC, 0);
}