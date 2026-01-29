/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\228.gsc
**************************************/

main() {
  if(isDefined(level._id_1A52)) {
    return;
  }
  level._id_1A52 = 1;
  common_scripts\utility::flag_init("laststand_on");

  foreach(var_1 in level.players) {
    var_1 maps\_utility::_id_1402("laststand_downed");
    var_1 maps\_utility::_id_1402("laststand_pause_bleedout_timer");
    var_1 maps\_utility::_id_1402("laststand_proc_running");
    var_1._id_132B = spawnStruct();
    var_1._id_132B._id_1A53 = 0;
  }

  precachestring(&"SCRIPT_COOP_BLEEDING_OUT_PARTNER");
  precachestring(&"SCRIPT_COOP_BLEEDING_OUT");
  precachestring(&"SCRIPT_COOP_REVIVING_PARTNER");
  precachestring(&"SCRIPT_COOP_REVIVING");
  precachestring(&"SCRIPT_COOP_REVIVE");
  precacheshellshock("laststand_getup");
  precacheitem("fnfiveseven");
  common_scripts\utility::flag_set("laststand_on");
  level._id_1A54 = 75;

  if(!issplitscreen()) {
    level._id_1A54 = 120;

  }
  level._id_1A55 = 15;
  level._id_1A56 = 30;
  level._id_1A57 = [];
  thread _id_1A58();
}

_id_1A58() {
  level waittill("load_finished");

  if(_id_1AB9() == 2) {
    precacheshader("specialty_self_revive");

  }
  thread _id_1A59();

  if(common_scripts\utility::flag_exist("slamzoom_finished") && !common_scripts\utility::flag("slamzoom_finished")) {
    common_scripts\utility::flag_wait("slamzoom_finished");

  }
  thread _id_1A6B("laststand_player_state_changed");
  thread _id_1A63();
  thread _id_1A80();
  thread _id_1A88();
  thread _id_1AC2();
}

_id_1A59() {
  if(_id_1AB9() == 2) {
    maps\_utility::_id_1A5A("axis", ::_id_1AB4);
  }
}

_id_1A5B() {
  if(!maps\_utility::_id_1A5C()) {
    return;
  }
  if(maps\_utility::_id_1008("laststand_proc_running")) {
    return;
  }
  if(!isDefined(self._id_1A5D)) {
    self._id_1A5D = self.maxhealth;

  }
  if(!common_scripts\utility::flag("laststand_on")) {
    return;
  }
  level endon("laststand_on");
  thread _id_1A62();

  switch (level.gameskill) {
    case 1:
    case 0:
      self._id_132B._id_132D = 120;
      level._id_132E = 0.5;
      level._id_1A5E = 0.25;
      break;
    case 2:
      self._id_132B._id_132D = 90;
      level._id_132E = 0.66;
      level._id_1A5E = 0.33;
      break;
    case 3:
      self._id_132B._id_132D = 60;
      level._id_132E = 0.5;
      level._id_1A5E = 0.25;
      break;
  }

  maps\_utility::_id_13DC("laststand_proc_running");
  self enabledeathshield(1);
  maps\_utility::_id_13DE("laststand_downed");
  maps\_utility::_id_13DE("laststand_pause_bleedout_timer");
  self endon("death");
  var_0 = self.unique_id;

  for(;;) {
    self waittill("deathshield", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(isDefined(self._id_1A5F) && self._id_1A5F) {
      continue;
    }
    if(maps\_utility::_id_1008("laststand_downed")) {
      continue;
    }
    if(isDefined(self._id_1A60) && gettime() - self._id_1A60 <= 1750.0) {
      continue;
    }
    var_11 = [];
    var_11["damage"] = var_1;
    var_11["player"] = self;

    if(maps\_utility::_id_12C1() && _id_1ABC()) {
      var_12 = maps\_utility::_id_133A(self);

      if(var_12 maps\_utility::_id_1008("laststand_downed")) {
        self._id_1886 = [];
        self._id_1886["attacker"] = var_2;
        self._id_1886["cause"] = var_5;
        self._id_1886["weapon_name"] = var_10;
      }
    }

    if(!maps\_utility::_id_12C1()) {
      self._id_1886 = [];
      self._id_1886["attacker"] = var_2;
      self._id_1886["cause"] = var_5;
      self._id_1886["weapon_name"] = var_10;
    }

    level._id_1A61[self.unique_id] = var_11;
    _id_1AC0(var_2, var_5);
    level notify("request_player_downed");
  }
}

_id_1A62() {
  self endon("death");
  common_scripts\utility::flag_waitopen("laststand_on");
  maps\_utility::_id_13DE("laststand_proc_running");
  self enabledeathshield(0);
}

_id_1A63() {
  if(maps\_utility::_id_12C1()) {
    thread _id_1A67();

  }
  level._id_1A64 = 0;

  for(;;) {
    level._id_1A61 = [];
    level waittill("request_player_downed");
    waittillframeend;
    var_0 = gettime();

    if(var_0 < level._id_1A64 + level._id_1A65 * 1000) {
      continue;
    }
    level._id_1A64 = var_0;
    var_1 = 0;
    var_2 = undefined;
    level._id_1A61 = maps\_utility::_id_0B53(level._id_1A61);

    foreach(var_5, var_4 in level._id_1A61) {
      if(var_4["damage"] >= var_1) {
        var_2 = var_4["player"];
      }
    }

    var_2 thread _id_1A6D();
    thread maps\_gameskill::_id_1A66();
  }
}

_id_1A67() {
  if(!maps\_utility::_id_12C1()) {
    return;
  }
  level._id_1A68 = getdvarint("player_useradius");
  level endon("special_op_terminated");
  level._id_1A69 = [];

  foreach(var_1 in level.players) {
    var_2 = spawn("script_model", var_1.origin + (0, 0, 28));
    var_2 setModel("tag_origin");
    var_2 linkto(var_1, "tag_origin", (0, 0, 28), (0, 0, 0));
    var_2 sethintstring(&"SCRIPT_COOP_REVIVE");
    level._id_1A69[var_1.unique_id] = var_2;
    var_1 thread _id_1A6E();
  }

  for(;;) {
    level waittill("laststand_player_state_changed");

    foreach(var_1 in level.players) {}
    var_1 _id_1AC6(maps\_utility::_id_1A43(var_1));

    if(maps\_utility::_id_1A6A().size == level.players.size) {
      setsaveddvar("player_useradius", level._id_1A68);
      continue;
    }

    setsaveddvar("player_useradius", 128);
  }
}

_id_1A6B(var_0) {
  level endon("special_op_terminated");

  foreach(var_2 in level.players) {}
  var_2 endon("death");

  for(;;) {
    foreach(var_2 in level.players) {}
    var_2 thread _id_1A6C("laststand_downed", var_0);

    level waittill(var_0);
  }
}

_id_1A6C(var_0, var_1) {
  level endon("special_op_terminated");
  level endon(var_1);
  self endon("death");

  if(maps\_utility::_id_1008(var_0)) {
    maps\_utility::_id_13DB(var_0);
  } else {
    maps\_utility::_id_1654(var_0);

  }
  level notify(var_1);
}

_id_1A6D() {
  if(!isalive(self)) {
    return;
  }
  level endon("special_op_terminated");
  self endon("death");
  _id_1A95();

  if(maps\_utility::_id_12C1()) {
    thread _id_1A76();
    thread _id_1A8E();
    thread _id_1A8F();
  }

  maps\_utility::_id_09C9(maps\_utility::_id_13DB, "laststand_downed");
  maps\_utility::_id_09C9(maps\_utility::_id_09CA, "coop_bled_out");
  maps\_utility::_id_09CB();
  self notify("end_func_player_laststand_downed_icon");

  if(maps\_utility::_id_1008("laststand_downed")) {
    _id_1ABF();
  } else {
    _id_1A97();
  }
}

_id_1A6E() {
  self endon("death");
  level endon("special_op_terminated");
  var_0 = _id_1AC7();
  var_1 = 0;

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(maps\_utility::_id_1A43(var_2)) {
      continue;
    }
    self._id_1A6F = var_2;

    if(maps\_utility::_id_1A43(self) && var_2 _id_1A71(self)) {
      _id_1A74(1, var_2, self);
      level._id_1A64 = 0;
      wait 0.1;

      if(!maps\_utility::_id_1A43(self) || !var_2 _id_1A71(self)) {
        var_2 _id_1A73(self);
        continue;
      }

      level._id_1A70 = [];
      level._id_1A70["p1"] = maps\_hud_util::createclientprogressbar(level.player, level._id_1A54 + level._id_1A55);
      level._id_1A70["p2"] = maps\_hud_util::createclientprogressbar(level._id_1337, level._id_1A54 + level._id_1A55);
      var_3 = randomfloat(1) > 0.33;

      if(var_3) {
        var_2 notify("so_reviving");

      }
      var_1 = 0;
      var_4 = 1.5;

      while(maps\_utility::_id_1A43(self) && !maps\_utility::_id_1A43(var_2) && var_2 _id_1A71(self)) {
        maps\_utility::_id_13DC("laststand_pause_bleedout_timer");

        foreach(var_6 in level._id_1A70) {}
        var_6 maps\_hud_util::updatebar(var_1 / var_4);

        wait 0.05;
        var_1 = var_1 + 0.05;

        if(maps\_utility::_id_1A43(self) && var_1 > var_4) {
          if(!var_3) {
            var_2 notify("so_revived");

          }
          var_2 notify("so_revive_success");
          _id_1A72();
          break;
        }
      }

      var_2 _id_1A73(self);
    }
  }
}

_id_1A71(var_0) {
  if(!self usebuttonpressed()) {
    return 0;

  }
  if(isDefined(var_0._id_1A6F) && var_0._id_1A6F == self) {
    return 1;

  }
  return 0;
}

_id_1A72() {
  self._id_1A60 = gettime();
  _id_1AB6();
  maps\_utility::_id_13DE("laststand_downed");
  self._id_1886 = undefined;
  thread maps\_gameskill::_id_1A66();
  self notify("revived");
}

_id_1A73(var_0) {
  level notify("revive_bars_killed");
  _id_1AC3();

  if(isDefined(var_0) && isalive(var_0)) {
    var_0._id_1A6F = undefined;
    var_0 maps\_utility::_id_13DE("laststand_pause_bleedout_timer");
  }

  if(isDefined(self) && isalive(self)) {
    _id_1A74(0, self, var_0);
  }
}

_id_1A74(var_0, var_1, var_2) {
  var_2 = maps\_utility::_id_133A(self);

  if(var_0) {
    var_1 freezecontrols(1);
    var_1 disableweapons();
    var_1 disableweaponswitch();
    var_2 freezecontrols(1);
    var_2 disableweapons();
  } else {
    var_1 freezecontrols(0);
    var_1 enableweapons();
    var_1 enableweaponswitch();
    var_2 freezecontrols(0);

    if(!maps\_utility::_id_1A75(var_2)) {
      var_2 enableweapons();
    }
  }
}

_id_1A76() {
  self endon("death");
  self endon("revived");
  level endon("special_op_terminated");
  wait 1.0;
  self notify("so_downed");
  thread _id_1A77(0.05);
}

_id_1A77(var_0) {
  self endon("death");
  self endon("revived");
  level endon("special_op_terminated");

  if(isDefined(var_0) && var_0 > 0) {
    wait(var_0);

  }
  self notifyonplayercommand("nag", "weapnext");

  for(;;) {
    if(!_id_1A7E()) {
      wait 0.05;
      continue;
    }

    if(_id_1A79()) {
      thread _id_1A7B();
      thread _id_1A7D();
    }

    var_1 = common_scripts\utility::waittill_any_timeout(level._id_1A33, "nag", "nag_cancel");

    if(var_1 == "nag") {
      self._id_1A78 = gettime();
      thread _id_1AC9();
      thread maps\_specialops_battlechatter::_id_1329();
    }

    wait 0.05;
  }
}

_id_1A79() {
  var_0 = level._id_1A33 * 1000;

  if(isDefined(self) && isDefined(self._id_1A7A)) {
    return 0;
  } else if(!isDefined(self._id_1A78)) {
    return 1;
  } else if(gettime() - self._id_1A78 < var_0) {
    return 0;

  }
  return 1;
}

_id_1A7B() {
  if(!isDefined(self)) {
    return;
  }
  self._id_1A7A = 1;
  var_0 = 0.05;
  var_1 = &"SPECIAL_OPS_REVIVE_NAG_HINT";
  var_2 = _id_1A7C();
  var_2.alpha = 0;
  var_2 settext(var_1);
  var_2 fadeovertime(var_0);
  var_2.alpha = 1;
  _id_1AC4();
  self._id_1A7A = undefined;
  var_2 fadeovertime(var_0);
  var_2.alpha = 0;
  var_2 common_scripts\utility::delaycall(var_0 + 0.05, ::destroy);
}

_id_1A7C() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 50;
  var_0.alignx = "center";
  var_0.aligny = "middle";
  var_0.horzalign = "center";
  var_0.vertalign = "middle";
  var_0.fontscale = 1;
  var_0.color = (1, 1, 1);
  var_0.font = "hudsmall";
  var_0.glowcolor = (0.3, 0.6, 0.3);
  var_0.glowalpha = 0;
  var_0.foreground = 1;
  var_0.hidewheninmenu = 1;
  var_0.hidewhendead = 1;
  return var_0;
}

_id_1A7D() {
  self endon("nag");

  while(maps\_utility::_id_1A43(self) && _id_1A7E()) {
    wait 0.05;

  }
  self notify("nag_cancel");
}

_id_1A7E() {
  if(isDefined(level._id_1A7F) && level._id_1A7F) {
    return 0;

  }
  var_0 = maps\_utility::_id_133A(self);

  if(var_0 _id_1A71(self)) {
    return 0;

  }
  if(!maps\_specialops_battlechatter::_id_132F()) {
    return 0;

  }
  return 1;
}

_id_1A80() {
  if(!maps\_utility::_id_12C1()) {
    return;
  }
  level endon("special_op_terminated");
  var_0 = [];

  foreach(var_2 in level.players) {}
  var_0[var_2.unique_id] = maps\_utility::_id_1A43(var_2);

  _id_1A85();

  for(;;) {
    level waittill("laststand_player_state_changed");
    waittillframeend;

    foreach(var_2 in level.players) {
      var_5 = maps\_utility::_id_133A(var_2);
      var_6 = var_2 _id_1A87(var_0);
      var_7 = var_5 _id_1A87(var_0);

      if(var_6) {
        if(maps\_utility::_id_1A43(var_2)) {
          var_2._id_1A81.alpha = 0;
          var_2._id_1A82.alpha = 0;
          var_2._id_1A83 thread maps\_specialops::_id_1851();
          var_2._id_1A84 thread maps\_specialops::_id_1851();
          var_2._id_1A83.alpha = 1;
          var_2._id_1A84.alpha = 1;
          var_2._id_1A83 thread maps\_specialops::_id_1848();
          var_2._id_1A84 thread maps\_specialops::_id_1848();
        } else if(maps\_utility::_id_1A43(var_5)) {
          var_2._id_1A83.alpha = 0;
          var_2._id_1A84.alpha = 0;
          var_2._id_1A81 thread maps\_specialops::_id_1851();
          var_2._id_1A82 thread maps\_specialops::_id_1851();
          var_2._id_1A81.alpha = 1;
          var_2._id_1A82.alpha = 1;
          var_2._id_1A81 thread maps\_specialops::_id_1848();
          var_2._id_1A82 thread maps\_specialops::_id_1848();
        } else {
          var_2 _id_1A86();
        }
      }

      if(var_7) {
        if(!maps\_utility::_id_1A43(var_2)) {
          if(maps\_utility::_id_1A43(var_5)) {
            var_2._id_1A83.alpha = 0;
            var_2._id_1A84.alpha = 0;
            var_2._id_1A81 thread maps\_specialops::_id_1851();
            var_2._id_1A82 thread maps\_specialops::_id_1851();
            var_2._id_1A81.alpha = 1;
            var_2._id_1A82.alpha = 1;
            var_2._id_1A81 thread maps\_specialops::_id_1848();
            var_2._id_1A82 thread maps\_specialops::_id_1848();
            continue;
          }

          var_2 _id_1A86();
        }
      }
    }

    foreach(var_2 in level.players) {}
    var_0[var_2.unique_id] = maps\_utility::_id_1A43(var_2);
  }
}

_id_1A85() {
  foreach(var_1 in level.players) {
    var_1._id_1A83 = var_1 maps\_hud_util::createserverclientfontstring("hudsmall", 1.0);
    var_1._id_1A83 maps\_hud_util::setpoint("CENTER", undefined, 0, level._id_1A54);
    var_1._id_1A83 settext(&"SCRIPT_COOP_BLEEDING_OUT");
    var_1._id_1A81 = var_1 maps\_hud_util::createserverclientfontstring("hudsmall", 1.0);
    var_1._id_1A81 maps\_hud_util::setpoint("CENTER", undefined, 0, level._id_1A54);
    var_1._id_1A81 settext(&"SCRIPT_COOP_BLEEDING_OUT_PARTNER");
    var_1._id_1A84 = var_1 maps\_hud_util::createclienttimer("hudsmall", 1.2);
    var_1._id_1A84 maps\_hud_util::setpoint("CENTER", undefined, 0, level._id_1A54 + level._id_1A55);
    var_1._id_1A82 = var_1 maps\_hud_util::createclienttimer("hudsmall", 1.2);
    var_1._id_1A82 maps\_hud_util::setpoint("CENTER", undefined, 0, level._id_1A54 + level._id_1A55);
    var_1 _id_1A86();
    level._id_1A57[level._id_1A57.size] = var_1._id_1A83;
    level._id_1A57[level._id_1A57.size] = var_1._id_1A81;
    level._id_1A57[level._id_1A57.size] = var_1._id_1A84;
    level._id_1A57[level._id_1A57.size] = var_1._id_1A82;
  }
}

_id_1A86() {
  self._id_1A83.alpha = 0;
  self._id_1A81.alpha = 0;
  self._id_1A84.alpha = 0;
  self._id_1A82.alpha = 0;
}

_id_1A87(var_0) {
  var_1 = maps\_utility::_id_1A43(self);
  var_2 = var_0[self.unique_id];
  return var_1 != var_2;
}

_id_1A88() {
  if(_id_1AB9() != 2) {
    return;
  }
  foreach(var_1 in level.players) {}
  var_1._id_1A89 = 0;

  _id_1A8A();
}

_id_1A8A() {
  foreach(var_1 in level.players) {
    var_2 = level._id_1A54 + level._id_1A56;
    var_1._id_1A8B = maps\_hud_util::createclientprogressbar(var_1, var_2, "white", "black", 130, 12);
    var_1 _id_1AAE(0.5);
    level._id_1A57[level._id_1A57.size] = var_1._id_1A8B;
    var_1._id_1A8C = newclienthudelem(var_1);
    var_1._id_1A8C.hidden = 0;
    var_1._id_1A8C.elemtype = "icon";
    var_1._id_1A8C.hidewheninmenu = 1;
    var_1._id_1A8C.archived = 0;
    var_1._id_1A8C.x = -93.0;
    var_1._id_1A8C.y = var_2;
    var_1._id_1A8C.alignx = "center";
    var_1._id_1A8C.aligny = "middle";
    var_1._id_1A8C.horzalign = "center";
    var_1._id_1A8C.vertalign = "middle";
    var_1._id_1A8C.children = [];
    var_1._id_1A8C.elemtype = "icon";
    var_1._id_1A8C setshader("specialty_self_revive", 28, 28);
    level._id_1A57[level._id_1A57.size] = var_1._id_1A8C;
    var_1._id_1A8B maps\_hud_util::hidebar(1);
    var_1._id_1A8C.alpha = 0.0;
  }
}

_id_1A8E() {
  self endon("end_func_player_laststand_downed_icon");
  self endon("death");
  self endon("revived");
  level endon("special_op_terminated");

  foreach(var_1 in level.players) {
    if(var_1 == self) {
      var_1._id_1A84 settimer(self._id_132B._id_132D - 1);
      continue;
    }

    var_1._id_1A82 settimer(self._id_132B._id_132D - 1);
  }

  thread _id_1A90(self._id_132B._id_132D);
  var_3 = self._id_132B._id_132D;

  foreach(var_1 in level.players) {
    if(var_1 == self) {
      var_1._id_1A83.color = self._id_1A83.color;
      var_1._id_1A84.color = self._id_1A83.color;
      continue;
    }

    var_1._id_1A81.color = var_1._id_1A83.color;
    var_1._id_1A82.color = var_1._id_1A83.color;
  }

  waittillframeend;

  while(var_3) {
    foreach(var_1 in level.players) {
      if(var_1 == self) {
        var_7 = var_1._id_1A83;
        var_8 = var_1._id_1A84;
      } else {
        var_7 = var_1._id_1A81;
        var_8 = var_1._id_1A82;
      }

      var_9 = var_7.color;
      var_10 = _id_1A91(self._id_132B._id_132C, self._id_132B._id_132D, 0, var_1 == self);
      var_7.color = var_10;
      var_8.color = var_10;

      if(distance(var_10, var_9) > 0.001) {
        if(distance(var_10, var_1._id_1A39) <= 0.001) {
          var_7._id_184B = 1;
          var_8._id_184B = 1;
        }

        var_7 thread maps\_specialops::_id_1848();
        var_8 thread maps\_specialops::_id_1848();
      }
    }

    wait 1.0;
    var_3 = var_3 - 1.0;
  }
}

_id_1A8F() {
  self endon("end_func_player_laststand_downed_icon");
  self endon("death");
  self endon("revived");
  level endon("special_op_terminated");
  waittillframeend;
  var_0 = maps\_utility::_id_133A(self);
  var_0 maps\_coop::_id_1A4D();

  while(self._id_132B._id_132C > 0) {
    maps\_utility::_id_13DB("laststand_pause_bleedout_timer");
    var_0 maps\_coop::_id_1A4E(_id_1A91(self._id_132B._id_132C, self._id_132B._id_132D));
    wait 0.05;
  }
}

_id_1A90(var_0) {
  self endon("death");
  self endon("revived");
  level endon("special_op_terminated");

  for(self._id_132B._id_132C = var_0; self._id_132B._id_132C > 0; self._id_132B._id_132C = self._id_132B._id_132C - 0.05) {
    if(maps\_utility::_id_1008("laststand_pause_bleedout_timer")) {
      foreach(var_2 in level.players) {
        if(var_2 == self) {
          var_2._id_1A84.alpha = 0;
          continue;
        }

        var_2._id_1A82.alpha = 0;
      }

      maps\_utility::_id_13DB("laststand_pause_bleedout_timer");

      if(self._id_132B._id_132C >= 1) {
        foreach(var_2 in level.players) {
          if(var_2 == self) {
            var_2._id_1A84 settimer(self._id_132B._id_132C - 1);
            continue;
          }

          var_2._id_1A82 settimer(self._id_132B._id_132C - 1);
        }
      }
    } else {
      foreach(var_2 in level.players) {
        if(var_2 == self) {
          var_2._id_1A84.alpha = 1;
          continue;
        }

        if(!maps\_utility::_id_1A43(var_2)) {
          var_2._id_1A82.alpha = 1;
        }
      }
    }

    wait 0.05;
  }

  self._id_132B._id_132C = 0;
  maps\_specialops::_id_183F("@DEADQUOTE_SO_BLED_OUT", "ui_bled_out");
  thread maps\_specialops::_id_1879();
  self notify("coop_bled_out");
}

_id_1A91(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3) && var_3) {
    var_4 = self;
  } else {
    var_4 = maps\_utility::_id_133A(self);

  }
  if(!isDefined(var_2)) {
    var_2 = 1;

  }
  if(var_2 && _id_1A93()) {
    if(self._id_1A92 == 1) {
      return var_4._id_1A3A;
    }
  }

  if(var_0 < var_1 * level._id_1A5E) {
    return var_4._id_1A39;

  }
  if(var_0 < var_1 * level._id_132E) {
    return var_4._id_1A38;

  }
  return var_4._id_1A36;
}

_id_1A93() {
  var_0 = maps\_utility::_id_133A(self);

  if(var_0 _id_1A71(self)) {
    return 0;

  }
  if(isDefined(self._id_1A78)) {
    if(gettime() - self._id_1A78 < level._id_1A31 * 1000) {
      return 1;
    }
  }

  return 0;
}

_id_1A94() {
  if(isDefined(level._id_1A57)) {
    foreach(var_1 in level._id_1A57) {
      if(isDefined(var_1)) {
        var_1 notify("destroying");
        var_1 maps\_hud_util::destroyelem();
      }
    }
  }

  level._id_1A57 = undefined;
}

_id_1A95() {
  self endon("death");
  self notify("player_downed");
  self.ignorerandombulletdamage = 1;
  self enableinvulnerability();
  maps\_utility::_id_13DC("laststand_downed");
  self.laststand = 1;
  self.health = 2;
  self.maxhealth = self._id_1A5D;
  self.ignoreme = 1;
  self disableusability();
  self disableweaponswitch();
  self disableoffhandweapons();
  self disableweapons();

  if(!isDefined(self._id_023C)) {
    self._id_023C = 1;
  } else {
    self._id_023C++;

  }
  if(isDefined(self._id_1A96)) {
    self notify("sentry_placement_canceled");

  }
  thread _id_1AA0();

  if(_id_1ABC()) {
    _id_1ABF();
  } else {
    thread _id_1AA2();
  }
}

_id_1A97() {
  self.ignorerandombulletdamage = 0;
  maps\_utility::_id_13DE("laststand_downed");
  self.laststand = 0;
  self._id_1A98 = undefined;
  self._id_1A99 = undefined;

  if(maps\_utility::_id_12C1()) {
    var_0 = maps\_utility::_id_133A(self);
    var_0 maps\_coop::_id_1A4B();
  }

  self disableweapons();
  _id_1A9A();
  self.health = self.maxhealth;
  self.ignoreme = 0;
  self setstance("stand");
  self enableusability();
  self enableoffhandweapons();
  self enableweaponswitch();
  self enableweapons();
  self notify("not_in_last_stand");
  wait 1.0;
  self disableinvulnerability();
}

_id_1A9A() {
  if(isDefined(self._id_1A9B)) {
    self takeweapon(self._id_1A9B);
    self._id_1A9B = undefined;
  }

  if(isDefined(self._id_1A9C)) {
    self setweaponammoclip(self._id_1A9C, self._id_1A9D);
    self setweaponammostock(self._id_1A9C, self._id_1A9E);
  }

  if(_id_1AC5(self._id_1A9F)) {
    self switchtoweapon(self._id_1A9F);
  } else {
    var_0 = self getweaponslistprimaries();
    self switchtoweapon(var_0[0]);
  }

  self._id_1A9F = undefined;
}

_id_1AA0() {
  self endon("revived");
  self endon("death");
  level endon("special_op_terminated");

  if(common_scripts\utility::flag("special_op_terminated")) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  for(;;) {
    var_0 = vehicle_getarray();

    foreach(var_2 in var_0) {
      if(isDefined(var_2._id_1AA1) && var_2._id_1AA1) {
        continue;
      }
      var_3 = var_2 vehicle_getspeed();

      if(abs(var_3) == 0) {
        continue;
      }
      if(self istouching(var_2)) {
        var_2 maps\_specialops::_id_1885(self, "MOD_CRUSH");
        return;
      }
    }

    wait 0.05;
  }
}

_id_1AA2() {
  self endon("revived");
  self endon("death");
  level endon("special_op_terminated");

  if(_id_1AB9() != 2) {
    wait 0.3;

  }
  thread _id_1AB0();

  if(_id_1AB9() == 2) {
    if(_id_1ABD() > 0) {
      if(!isDefined(self._id_1AA3)) {
        self._id_1AA3 = 1;
      } else {
        self._id_1AA3++;

      }
      if(self._id_1AA3 <= 9999) {
        thread _id_1AA4();
        self waittill("laststand_getup_failed");
      }

      if(!maps\_utility::_id_12C1() || maps\_utility::_id_1A75(maps\_utility::_id_133A(self))) {
        _id_1ABF();
        return;
      }
    } else {
      waittillframeend;
    }
  } else {
    wait 0.25;
    self disableinvulnerability();
    thread _id_1AB3();
    self waittill("damage");
  }

  thread _id_1AAF();
}

_id_1AA4() {
  self endon("revived");
  self endon("death");
  self endon("laststand_getup_failed");
  level endon("special_op_terminated");
  thread _id_1AA6();
  thread _id_1AAA();
  thread _id_1AAB();
  thread _id_1AAC();
  thread _id_1AB7();
  thread _id_1AA9();
  var_0 = (self._id_1AA3 - 1) * 0.0;
  var_1 = max(0.5 - var_0, 0.2);
  _id_1AAE(var_1);
  self._id_1A8B maps\_hud_util::hidebar(0);
  self._id_1A8C.alpha = 1.0;
  wait 2.0;
  self disableinvulnerability();
  self._id_1AA5 = gettime();

  for(;;) {
    var_2 = 0;

    if(isDefined(self._id_1A89) && self._id_1A89) {
      var_2 = 1;
    } else if(gettime() - self._id_1AA5 > 3000.0) {
      var_2 = 1;

    }
    var_3 = common_scripts\utility::ter_op(var_2, 0.01, 0.0025);
    _id_1AAD(var_3);
    wait 0.05;
  }
}

_id_1AA6() {
  level endon("special_op_terminated");
  self endon("death");
  var_0 = common_scripts\utility::waittill_any_return("player_down_and_out", "revived");

  if(isDefined(var_0) && var_0 == "player_down_and_out") {
    self.ignoreme = 1;

  }
  _id_1ABE(0);
  thread _id_1AA8(0.5);
  self._id_1A89 = 0;

  if(isDefined(self._id_1AA7)) {
    badplace_delete(self._id_1AA7);
    self._id_1AA7 = undefined;
  }
}

_id_1AA8(var_0) {
  level endon("special_op_terminated");
  self endon("player_downed");
  wait(var_0);
  self._id_1A8B maps\_hud_util::hidebar(1);
  self._id_1A8C.alpha = 0.0;
}

_id_1AA9() {
  self endon("revived");
  self endon("death");
  self endon("laststand_getup_failed");
  level endon("special_op_terminated");
  self.ignoreme = 1;
  wait 0.25;
  self.ignoreme = 0;
}

_id_1AAA() {
  self endon("revived");
  self endon("death");
  self endon("laststand_getup_failed");
  level endon("special_op_terminated");

  for(;;) {
    self waittill("revive_kill");
    _id_1AAD(1.0);
  }
}

_id_1AAB() {
  self endon("revived");
  self endon("death");
  self endon("laststand_getup_failed");
  level endon("special_op_terminated");

  for(;;) {
    common_scripts\utility::waittill_any("damage", "deathshield");
    _id_1AAD(-0.1);
    self._id_1AA5 = gettime();
    wait 0.2;
  }
}

_id_1AAC() {
  self endon("revived");
  self endon("death");
  self endon("laststand_getup_failed");
  level endon("special_op_terminated");
  self._id_1AA7 = self.unique_id + "_ls_badplace";

  for(;;) {
    badplace_cylinder(self._id_1AA7, 90.0, self.origin, 120, 120, "axis");
    wait 90.0;
    badplace_delete(self._id_1AA7);
  }
}

_id_1AAD(var_0) {
  var_0 = clamp(var_0, -1.0, 1.0);
  var_1 = clamp(self._id_1A8B.bar.frac + var_0, 0.0, 1.0);
  _id_1AAE(var_1);

  if(var_1 == 1.0) {
    _id_1A72();
  } else if(var_1 == 0.0) {
    self notify("laststand_getup_failed");
  }
}

_id_1AAE(var_0) {
  var_1 = (1, 0.4, 0.4);
  var_2 = (1, 0, 0);
  self._id_1A8B.bar.color = vectorlerp(var_2, var_1, var_0);
  self._id_1A8B maps\_hud_util::updatebar(var_0);
}

_id_1AAF() {
  self._id_1A99 = 1;
  self notify("player_down_and_out");
  self disableweapons();
  thread _id_1AB5();
  self.ignoreme = 1;
  self.ignorerandombulletdamage = 1;
  self enableinvulnerability();
}

_id_1AB0() {
  self._id_1A9F = self getcurrentweapon();
  var_0 = _id_1AC1();
  self._id_1A9C = undefined;
  self._id_1A9E = 0;
  self._id_1A9D = 0;
  var_1 = undefined;

  if(isDefined(var_0)) {
    self._id_1A9C = var_0;
    self._id_1A9E = self getweaponammostock(var_0);
    self._id_1A9D = self getweaponammoclip(var_0);
    var_1 = var_0;
  } else if(isDefined(level._id_1AB1)) {
    var_2 = isDefined(level._id_1AB1) && self hasweapon(level._id_1AB1);

    if(!var_2) {
      self._id_1A9B = level._id_1AB1;
      self giveweapon(level._id_1AB1);
    } else {
      self._id_1A9C = level._id_1AB1;
      self._id_1A9E = self getweaponammostock(var_0);
      self._id_1A9D = self getweaponammoclip(var_0);
    }

    var_1 = level._id_1AB1;
  } else {
    var_1 = "fnfiveseven";
    self._id_1A9B = var_1;
    self giveweapon(var_1);
  }

  self setweaponammoclip(var_1, weaponclipsize(var_1));
  self setweaponammostock(var_1, weaponmaxammo(var_1));
  thread _id_1AB2();
  self switchtoweapon(var_1);
  self enableweapons();
}

_id_1AB2() {
  level endon("special_op_terminated");
  self endon("death");
  self endon("player_down_and_out");
  self endon("not_in_last_stand");
  self endon("revived");
  self endon("weapon_change");

  for(;;) {
    self waittill("reload");
    var_0 = self getcurrentweapon();
    self setweaponammostock(var_0, weaponmaxammo(var_0));
  }
}

_id_1AB3() {
  self endon("death");
  self endon("revived");
  self endon("damage");
  notifyoncommand("draw_attention", "+attack");
  notifyoncommand("draw_attention", "+attack_akimbo_accessible");
  common_scripts\utility::waittill_any_timeout(4, "draw_attention", "player_down_and_out");

  if(maps\_utility::_id_1A75(self)) {
    return;
  }
  self.ignoreme = 0;
  self.ignorerandombulletdamage = 0;
}

_id_1AB4() {
  level endon("special_op_terminated");
  self waittill("death", var_0, var_1, var_2);
  var_3 = 0;

  if(isDefined(var_0) && isalive(var_0) && isplayer(var_0) && maps\_utility::_id_1A43(var_0)) {
    if(isDefined(var_2) && weaponclass(var_2) == "pistol") {
      var_3 = 1;
    } else if(isDefined(var_1) && var_1 == "MOD_MELEE") {
      var_3 = 1;
    }
  }

  if(var_3) {
    var_0 notify("revive_kill");
  }
}

_id_1AB5() {
  self endon("death");
  self endon("revived");

  if(!maps\_utility::_id_133C("laststand_dying_effect")) {
    maps\_utility::_id_1402("laststand_dying_effect");
  } else if(maps\_utility::_id_1008("laststand_dying_effect")) {
    return;
  }
  maps\_utility::_id_13DC("laststand_dying_effect");
  _id_1AB8("default", 60, 1);
}

_id_1AB6() {
  if(maps\_utility::_id_133C("laststand_dying_effect")) {
    maps\_utility::_id_13DE("laststand_dying_effect");

  }
  self stopshellshock();
}

_id_1AB7() {
  self endon("death");
  self endon("revived");
  self endon("player_down_and_out");
  self notify("laststand_effect");
  self endon("laststand_effect");
  _id_1AB8("laststand_getup", 60, 1);
}

_id_1AB8(var_0, var_1, var_2, var_3) {
  self endon("death");
  level endon("special_op_terminated");

  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  if(isDefined(var_3)) {
    var_4 = strtok(var_3, " ");

    foreach(var_6 in var_4) {}
    self endon(var_6);
  }

  for(;;) {
    self shellshock(var_0, var_1);
    wait(var_1);

    if(isDefined(var_2) && !var_2) {
      break;
    }
  }
}

_id_1AB9() {
  var_0 = isDefined(level._id_1ABA) && level._id_1ABA == 0 || level._id_1ABA == 1 || level._id_1ABA == 2;

  if(var_0) {
    return level._id_1ABA;
  } else {
    return 0;
  }
}

_id_1ABB() {
  return _id_1AB9() == 2 && _id_1ABD() > 0;
}

_id_1ABC() {
  if(maps\_utility::_id_12C1()) {
    var_0 = maps\_utility::_id_133A(self);
    var_1 = maps\_utility::_id_1A43(var_0) && !var_0 _id_1ABB() || maps\_utility::_id_1A75(var_0);

    if(var_1 && !_id_1ABB()) {
      return 1;

    }
    return 0;
  } else {
    if(!_id_1ABB()) {
      return 1;

    }
    return 0;
  }
}

_id_1ABD() {
  if(_id_1AB9() == 2 && isDefined(self._id_132B._id_1A53)) {
    return max(0, self._id_132B._id_1A53);

  }
  return 0;
}

_id_1ABE(var_0) {
  var_0 = common_scripts\utility::ter_op(isDefined(var_0), var_0, 0);
  self._id_132B._id_1A53 = max(0, common_scripts\utility::ter_op(var_0, self._id_132B._id_1A53 + 1, self._id_132B._id_1A53 - 1));
  self notify("laststand_lives_updated");
}

_id_1ABF() {
  level endon("special_op_terminated");
  thread _id_1AB6();
  self enabledeathshield(0);
  self disableinvulnerability();
  self enablehealthshield(0);
  self._id_1A98 = undefined;
  waittillframeend;
  self kill();
}

_id_1AC0(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0._id_1AA1) && var_0._id_1AA1) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  if(var_1 != "MOD_CRUSH") {
    return;
  }
  if(isDefined(var_0.vehicletype)) {
    var_2 = var_0 vehicle_getspeed();

    if(abs(var_2) == 0) {
      return;
    }
  }

  if(common_scripts\utility::flag("special_op_terminated")) {
    return;
  }
  var_0 maps\_specialops::_id_1885(self, var_1);
}

_id_1AC1(var_0) {
  var_1 = self getweaponslistprimaries();

  if(isDefined(var_0)) {
    foreach(var_3 in var_1) {
      if(var_3 == var_0) {
        return var_3;
      }
    }
  }

  var_5 = self getcurrentweapon();

  if(weaponclass(var_5) == "pistol") {
    return var_5;

  }
  foreach(var_3 in var_1) {
    if(weaponclass(var_3) == "pistol") {
      return var_3;
    }
  }

  return undefined;
}

_id_1AC2() {
  level waittill("special_op_terminated");
  _id_1AC8();
  _id_1AC3();
  _id_1A94();
}

_id_1AC3() {
  if(isDefined(level._id_1A70)) {
    foreach(var_1 in level._id_1A70) {
      if(isDefined(var_1)) {
        var_1 notify("destroying");
        var_1 maps\_hud_util::destroyelem();
      }
    }

    level._id_1A70 = undefined;
  }
}

_id_1AC4() {
  level endon("special_op_terminated");
  common_scripts\utility::waittill_any("nag", "nag_cancel", "death", "revived");
}

_id_1AC5(var_0) {
  if(!isDefined(var_0)) {
    return 0;

  }
  if(var_0 == "none") {
    return 0;

  }
  if(!self hasweapon(var_0)) {
    return 0;

  }
  return 1;
}

_id_1AC6(var_0) {
  var_1 = _id_1AC7();

  if(var_0) {
    var_1 makeusable();
  } else {
    var_1 makeunusable();

  }
  return var_1;
}

_id_1AC7() {
  return level._id_1A69[self.unique_id];
}

_id_1AC8() {
  if(isDefined(level._id_1A69)) {
    foreach(var_1 in level._id_1A69) {}
    var_1 delete();
  }
}

_id_1AC9() {
  self notify("player_downed_hud_blinkstate");
  self endon("player_downed_hud_blinkstate");
  self endon("death");
  self endon("revived");
  self._id_1A92 = 1;

  for(;;) {
    wait(level._id_1A32);

    if(self._id_1A92 == 1) {
      self._id_1A92 = 0;
      continue;
    }

    self._id_1A92 = 1;
  }
}