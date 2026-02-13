/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2450.gsc
*************************************************/

init() {}

_id_106AF(var_0, var_1, var_2) {
  if(istrue(level._id_204A)) {
    return 0;
  }

  var_3 = scripts\cp\utility::_id_6C5C();
  var_3 = scripts\engine\utility::array_remove(var_3, var_0);
  var_4 = 0;

  if(var_3.size > 0 || var_4) {
    level._id_204A = 1;

    if(isDefined(level._id_EC5B)) {
      level._id_EC5B sethintstring("");
    }

    var_5 = spawnStruct();
    var_5._id_50DB = var_0;
    var_5._id_0DE9 = [];
    var_5._id_0DEA = [];
    var_5.header_type = var_1;
    var_5._id_E9DD = var_2;
    level._id_CAB8 = var_5;
    _id_06CB::_id_AA65(::_id_0E49);
    _id_06CB::_id_AA51(::_id_3155);

    if(!var_4) {
      var_0 thread _id_0E49(var_5, 1);
    } else {
      var_3 = scripts\cp\utility::_id_6C5C();
    }

    level thread vote_initiated_sfx();

    foreach(var_7 in var_3) {
      var_7 thread _id_0E49(var_5);
    }

    var_5 thread _id_106B0();
    var_9 = var_5 _id_10739();
    level._id_204A = 0;

    if(istrue(var_9)) {
      var_5 notify("vote_passed");
    } else {
      var_9 = 0;

      if(isDefined(level._id_EC5B)) {
        level._id_EC5B sethintstring(level._id_EC5B._id_E9E6);
      }
    }

    _id_06CB::_id_C41D(::_id_0E49);
    _id_06CB::_id_C41B(::_id_3155);
    wait 1.5;

    foreach(var_7 in scripts\cp\utility::_id_6C5C()) {
      var_7 setclientomnvar("ui_zm_vote_prompt_show", 0);
      var_7 _id_079F::_id_CF63("vote_prompt");
    }

    level._id_CAB8 = undefined;
  } else
    var_9 = 1;

  return var_9;
}

_id_10739() {
  self endon("vote_canceled");

  for(;;) {
    var_0 = scripts\cp\utility::_id_6C5C().size;
    var_1 = scripts\cp\utility::_id_6C5C();

    switch (var_0) {
      case 2:
        var_2 = 2;
        break;
      case 3:
        var_2 = 2;
        break;
      case 4:
        var_2 = 3;
        break;
      case 5:
        var_2 = 3;
        break;
      default:
        var_2 = 1;
        break;
    }

    self._id_0DE9 = scripts\engine\utility::_id_1BCA(self._id_0DE9);
    self._id_0DEA = scripts\engine\utility::_id_1BCA(self._id_0DEA);
    var_3 = var_2 - self._id_0DE9.size;

    foreach(var_5 in scripts\cp\utility::_id_6C5C()) {
      var_5 setclientomnvar("ui_zm_vote_prompt_num_players_needed", int(clamp(var_3, 0, var_0)));
    }

    if(var_3 <= 0) {
      wait 0.5;
      return 1;
    } else if(var_0 - (self._id_0DE9.size + self._id_0DEA.size) < var_3) {
      foreach(var_5 in scripts\cp\utility::_id_6C5C()) {
        var_5 setclientomnvar("ui_zm_vote_prompt_num_players_needed", -1);
      }

      wait 0.5;
      return 0;
    }

    waitframe();
  }
}

show_vote_prompt(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_AE3F = var_0;
  var_2._id_E747 = var_1;
  _id_079F::_id_CF62("vote_prompt", "scripted_widget_zm_vote_prompt", var_2);
}

_id_106B0() {
  self endon("delete");
  self endon("death");
  self endon("vote_passed");
  self endon("vote_canceled");
  wait 15;
  self notify("vote_canceled");
  _id_079F::_id_CF63("vote_prompt");
}

vote_initiated_sfx() {
  level endon("game_ended");

  if(_func_0205("zmb_ui_vote_alert")) {
    foreach(var_1 in level.players) {
      var_1 playsoundtoplayer("zmb_ui_vote_alert", var_1);
    }
  }
}

_id_0E49(var_0, var_1) {
  var_0 = scripts\cp\utility::_id_459B(var_0, level._id_CAB8);
  var_1 = scripts\cp\utility::_id_459B(var_1, 0);

  if(!isDefined(var_0)) {
    return;
  }
  if(!isPlayer(var_0._id_50DB)) {
    return;
  }
  if(_id_079F::_id_CF64("vote_prompt")) {
    return;
  }
  self notify("accept_vote_prompt_think");
  self endon("accept_vote_prompt_think");
  var_0 endon("vote_passed");
  var_0 endon("vote_canceled");
  self endon("disconnect");
  self setclientomnvar("ui_zm_vote_prompt_starter", var_0._id_50DB getentitynumber());
  var_2 = 0;

  if(var_1 || isbot(self)) {
    var_2 = 1;
  }

  self setclientomnvar("ui_zm_vote_prompt_status", var_2);
  self setclientomnvar("ui_zm_vote_prompt_show", var_0.header_type);
  show_vote_prompt();

  while(var_2 == 0) {
    self waittill("luinotifyserver", var_3, var_4);

    if(var_3 == "zm_vote_prompt") {
      if(scripts\engine\utility::is_equal(var_4, 1)) {
        var_2 = 1;
        self setclientomnvar("ui_zm_vote_prompt_status", var_2);
        continue;
      }

      if(scripts\engine\utility::is_equal(var_4, 0)) {
        var_2 = 2;
        self setclientomnvar("ui_zm_vote_prompt_status", var_2);
      }
    }
  }

  if(scripts\engine\utility::is_equal(var_2, 1)) {
    var_0._id_0DE9 = scripts\cp\utility::_id_1B8C(var_0._id_0DE9, self);
  } else if(scripts\engine\utility::is_equal(var_2, 2)) {
    var_0._id_0DEA = scripts\cp\utility::_id_1B8C(var_0._id_0DEA, self);
  }
}

_id_3155() {
  var_0 = level._id_CAB8;
  var_0 notify("vote_canceled");
}