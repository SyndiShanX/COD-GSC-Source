/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2015.gsc
*************************************************/

init() {
  level._id_7931 = 1;
  _id_0CB2();
  _id_81E3();
}

_id_0CB2() {
  level _id_000F::_id_990C("give_high_five", ::_id_0C13);
  level _id_000F::_id_990C("return_high_fives", ::_id_0CBF);
}

_id_D5D4(var_0, var_1) {
  if(getdvarint("#x3e4aa46e1de45f9a2", 0) == 1 && getdvarint("#x3d4534270f8931404") == 1 && _func_00BE("ui_hf_target_player") == -1) {
    if(var_1 > level._id_7931) {
      level._id_7931 = var_1;
      setomnvar("ui_hf_target_player", var_0 getentitynumber());
      setomnvar("ui_hf_trigger_event", level._id_7931);
    }
  }
}

_id_81E3() {
  if(getdvarint("#x3e4aa46e1de45f9a2", 0) == 0 || getdvarint("#x3d4534270f8931404") == 0) {
    return;
  }
  level._id_B7FD = undefined;
  setomnvar("ui_hf_target_player", -1);

  foreach(var_1 in level.players) {
    var_1._id_7573 = 0;
    var_1 setclientomnvar("ui_hf_offer_hf", 0);
    var_1 setclientomnvar("ui_hf_return_hf", 0);
    var_1 setclientomnvar("ui_hf_returned_hfs", 0);
    _func_01EB("ui_hf_given_hfs", var_1 getentitynumber(), 0);
  }

  level thread _id_7932();
}

_id_7932() {
  self endon("disconnect");
  var_0 = -1;

  while(_func_00BE("ui_hf_target_player") == var_0) {
    waitframe();
  }

  foreach(var_2 in level.players) {
    var_2._id_7573 = 0;
  }

  var_0 = _func_00BE("ui_hf_target_player");
  level._id_B7FD = _id_6965(var_0);

  if(!isDefined(level._id_B7FD)) {
    _id_81E3();
    return;
  }

  foreach(var_2 in level.players) {
    if(var_2 != level._id_B7FD) {
      var_2 thread _id_DCB3();
    }
  }

  level thread _id_6FA4();
}

_id_DCB3() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0 setclientomnvar("ui_hf_offer_hf", 1);
  var_0 scripts\engine\utility::waittill_any_2("high_five_given", "give_high_five_timer_elapsed");
  var_0 setclientomnvar("ui_hf_offer_hf", 0);
}

_id_6FA4() {
  level endon("disconnect");
  wait 3.5;
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(var_2 != level._id_B7FD) {
      if(getdvarint("#x3f8f1c766e74a7891") == 1) {
        var_2._id_7573 = 1;
        _func_01EB("ui_hf_given_hfs", var_2 getentitynumber(), 1);
      }

      if(var_2._id_7573) {
        var_0++;
      }

      var_2 notify("give_high_five_timer_elapsed");
    }
  }

  if(var_0 > 0) {
    level._id_B7FD thread _id_DCDF();
  } else {
    _id_81E3();
  }
}

_id_DCDF() {
  self endon("disconnect");
  var_0 = self;
  var_0 setclientomnvar("ui_hf_return_hf", 1);
  var_0 thread _id_C796();
  var_0 scripts\engine\utility::waittill_any_2("high_fives_returned", "return_high_five_timer_elapsed");
  var_0 setclientomnvar("ui_hf_return_hf", 0);
}

_id_C796() {
  var_0 = self;
  var_0 endon("high_fives_returned");
  level endon("disconnect");
  wait 3.5;

  if(getdvarint("#x3f8f1c766e74a7891") == 1) {
    level thread _id_DCB4();
    var_0 notify("high_fives_returned");
    return;
  }

  var_0 notify("return_high_five_timer_elapsed");
  _id_81E3();
}

_id_DCB4() {
  foreach(var_1 in level.players) {
    if(var_1._id_7573) {
      var_1 setclientomnvar("ui_hf_returned_hfs", 1);
    }
  }

  wait 3.5;

  foreach(var_1 in level.players) {
    if(var_1._id_7573) {
      var_1 setclientomnvar("ui_hf_returned_hfs", 0);
    }
  }

  _id_81E3();
}

_id_0C13(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_1._id_7573 = 1;
  var_1 notify("high_five_given");
  _func_01EB("ui_hf_given_hfs", var_1 getentitynumber(), 1);
}

_id_0CBF(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_1 notify("high_fives_returned");
  level thread _id_DCB4();
}

_id_6965(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(var_3 getentitynumber() == var_0) {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}