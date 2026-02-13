/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1846.gsc
*************************************************/

_id_7E2E(var_0) {
  level waittill("infil_started");
  var_1 = 0;

  if(isDefined(level._id_580A)) {
    var_1 = level._id_580A;
  }

  wait(var_0 + var_1);
  level notify("prematch_over");

  if(scripts\engine\utility::_id_5C0C("infil_complete")) {
    scripts\engine\utility::_id_5C1B("infil_complete");
  }
}

_id_AB7A() {
  self endon("game_ended");
  self endon("prematch_over");

  for(;;) {
    level waittill("player_spawned", var_0);
    var_0 setclientomnvar("ui_hide_hud", 1);
    var_1 = _id_0929::_id_677D(var_0);

    if(isDefined(var_1)) {
      _id_3E17(var_0, scripts\cp\utility::_id_6BE2(var_0.team));
    }

    if(!scripts\engine\utility::_id_5C00("infil_started")) {
      var_0 _id_3E18();
      continue;
    }
  }
}

_id_3E29() {
  self endon("prematch_over");
  self waittill("disconnect");
  _id_3E17(self);
}

_id_7E48(var_0) {
  return self._id_039B == var_0;
}

_id_7E47(var_0) {
  return self.name == var_0;
}

_id_3E10(var_0) {
  self allowmovement(var_0);
  scripts\common\utility::_id_1570(var_0);
  scripts\common\utility::_id_1530(var_0);
  scripts\common\utility::_id_154E(var_0);
  scripts\common\utility::_id_153E(var_0);
  scripts\common\utility::_id_151F(var_0);
  scripts\common\utility::_id_1581(var_0);
  scripts\common\utility::_id_1554(var_0);
  scripts\common\utility::_id_1575(var_0);
  scripts\common\utility::_id_1551(var_0);
  scripts\common\utility::_id_157F(var_0);
  scripts\common\utility::_id_1562(var_0);
  scripts\common\utility::_id_1593(var_0);
  scripts\common\utility::_id_158A(var_0);
}

_id_EF76(var_0) {
  if(!isDefined(game["infil"])) {
    return 0;
  }

  return isDefined(game["infil"][var_0]["lanes"]);
}

_id_3E17(var_0, var_1) {
  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = var_0.team;
  }

  if(!isDefined(game["infil"][var_1]["spots"])) {}

  foreach(var_4, var_3 in game["infil"][var_1]["spots"]) {
    if(_id_0929::_id_86CE(var_1, var_4) && var_3["player"] == var_0) {
      game["infil"][var_1]["spots"][var_4]["player"] = undefined;
      var_0 notify("player_free_spot");
      return;
    }
  }
}

_id_3E0F(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in game["infil"][var_0]["spots"]) {
    if(!_id_0929::_id_86CE(var_0, var_4)) {
      var_1[var_1.size] = var_4;
    }
  }

  if(var_1.size == 0) {
    return undefined;
  }

  var_5 = getdvarint("#x3e4a368269dd5f893", -1);

  if(scripts\engine\utility::array_contains(var_1, var_5)) {
    return var_5;
  }

  var_6 = undefined;
  var_7 = -1;

  foreach(var_3 in var_1) {
    var_9 = game["infil"][var_0]["spots"][var_3]["priority"];

    if(!isDefined(var_6) || var_9 < var_7) {
      var_6 = var_3;
      var_7 = var_9;
    }
  }

  return var_6;
}

_id_3E18() {
  if(game["infil"][self.team].size == 0) {
    return;
  }
  var_0 = 0;
  var_1 = game["infil"][self.team]["spots"][0]["priority"] != -1;

  if(level.gametype == "tac_ops" && isDefined(self._id_ED18._id_50B4)) {
    var_2 = _id_66E4(self.team, self._id_ED18._id_50B4);
  } else if(var_0) {
    var_2 = _id_0929::_id_677F(self.team);
  } else if(var_1) {
    var_2 = _id_3E0F(self.team);
  } else {
    var_2 = _id_0929::_id_66E3(self.team);
  }

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = _id_0929::_id_B56A(self, var_2);
  var_3["infil"] thread _id_7E50(self);
  self notify("player_added_to_infil");
  self thread[[var_3["callback"]]](var_3["infil"], var_3["seat"]);
  thread _id_3E29();
}

_id_66E4(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in game["infil"][var_0]["spots"]) {
    if(var_5["infil"] != var_1) {
      continue;
    }
    if(!_id_0929::_id_86CE(var_0, var_5)) {
      var_2[var_2.size] = var_5;
    }
  }

  if(var_2.size == 0) {}

  var_4 = scripts\engine\utility::random(var_2);
  return var_4;
}

_id_7E50(var_0) {
  self endon("death");
  self.players = scripts\engine\utility::array_add(self.players, var_0);
  var_0 scripts\engine\utility::_id_108C5("death", "disconnect");
  self.players = scripts\engine\utility::array_remove(self.players, var_0);
}

_id_1659() {
  var_0 = self _meth_8587();

  if(var_0 == "AR") {
    var_1 = "default1";
  } else if(var_0 == "SMG") {
    var_1 = "default2";
  } else if(var_0 == "LMG") {
    var_1 = "default3";
  } else {
    var_2 = [];
    var_2[0] = "default1";
    var_2[1] = "default2";
    var_2[2] = "default3";
    var_1 = scripts\engine\utility::random(var_2);
  }

  self.pers["class"] = var_1;
  self.pers["lastClass"] = "";
  self.class = self.pers["class"];
  self._id_8FAF = self.pers["lastClass"];
  return var_1;
}

#using_animtree("script_model");

_id_7E51(var_0, var_1, var_2) {
  self._id_18AF = var_0;
  self _meth_8282(self.origin);
  var_3 = spawn("script_arms", self.origin, 0, 0, self);
  var_3.angles = self.angles;
  var_3.player = self;
  self._id_B5A4 = var_3;
  self._id_B5A4 hide(1);
  self._id_B5A4._id_18AF = var_0;
  self._id_B5A4 useanimtree(#animtree);
  self playerlinktodelta(self._id_B5A4, "tag_player", 1.0, 0, 0, 0, 0, 1);

  if(isDefined(var_2) && var_2) {
    self _meth_8272(self._id_B5A4);
  }

  self notify("rig_created");

  if(!isDefined(level._id_BB9F)) {
    level._id_BB9F = ::_id_3E10;
  }

  self[[level._id_BB9F]](0);
  scripts\engine\utility::waittill_any_3("remove_rig", "player_free_spot", "death");
  self[[level._id_BB9F]](1);

  if(isDefined(var_2) && var_2) {
    self _meth_8272(undefined);
  }

  if(isDefined(self)) {
    self unlink();
  }

  if(isDefined(var_3)) {
    var_3 delete();
  }
}

_id_7E4D(var_0, var_1, var_2) {
  foreach(var_4 in self.players) {
    var_4 playsoundtoplayer(var_0, var_4);
  }
}

_id_7E61() {
  wait 5;
  scripts\engine\utility::_id_5C1B("infil_started");
}

_id_7E58(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 2.0;
  }

  if(!isDefined(var_2)) {
    var_2 = "infil_started";
  }

  var_3 = newclienthudelem(self);
  var_3.x = 0;
  var_3.y = 0;
  var_3.alignx = "left";
  var_3.aligny = "top";
  var_3.sort = 1;
  var_3.horzalign = "fullscreen";
  var_3.vertalign = "fullscreen";
  var_3.alpha = 1;
  var_3._id_01D6 = 1;
  var_3 setshader("black", 640, 480);
  var_3 endon("death");
  scripts\engine\utility::waittill_any_3(var_2, "player_free_spot", "disconnect");
  wait(var_0);
  var_3 fadeovertime(var_1);
  var_3.alpha = 0;
  wait(var_1);
  var_3 destroy();
}

_id_6FA1() {
  var_0 = makeweapon("s4_gunless");
  self._id_BA28 = self getcurrentprimaryweapon();
  scripts\cp\utility::_giveweapon(var_0, undefined, undefined, 1);

  if(!scripts\common\utility::_id_86AC()) {
    scripts\common\utility::_id_157A(1);
  }

  var_1 = 1;
  self switchtoweapon(var_0);

  if(var_1) {
    self._id_72C3 = var_0;
    scripts\common\utility::_id_1593(0);
  } else
    self takeweapon(var_0);

  return var_1;
}

_id_EDC4() {
  if(!isDefined(self._id_72C3) || !self hasweapon(self._id_72C3)) {
    return;
  }
  self notify("get_post_infil_weapon");
  waitframe();
  self._id_EDE2 = 1;
  scripts\common\utility::_id_1593(1);
  self takeweapon(self._id_72C3);
  self._id_EDE2 = 0;
  self._id_72C3 = undefined;
  scripts\common\utility::_id_1593(0);
}

_id_74B5(var_0) {
  switch (var_0) {
    case "drop":
      self.player _meth_84AC("normal");
      wait 0.1;
      self.player _id_6FA1();
      break;
    case "raise":
      self.player _id_EDC4();

      if(isDefined(self.player._id_BA28)) {
        self.player switchtoweapon(self.player._id_BA28);
      }

      self.player._id_BA28 = undefined;
      break;
    case "safe":
      self.player _meth_84AC("safe");
      break;
    case "normal":
      self.player _meth_84AC("normal");
      break;
    case "free":
      self.player scripts\common\utility::_id_153E(1);
      self.player scripts\common\utility::_id_151F(1);
      self.player scripts\common\utility::_id_1575(1);
      break;
    case "hold":
      self.player scripts\common\utility::_id_153E(0);
      self.player scripts\common\utility::_id_151F(0);
      self.player scripts\common\utility::_id_1575(0);
      break;
  }
}