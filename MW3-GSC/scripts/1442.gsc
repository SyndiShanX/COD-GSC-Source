/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1442.gsc
**************************************/

move_player_to_start(var_0) {
  var_1 = common_scripts\utility::getstruct(var_0, "targetname");
  level.player setorigin(var_1.origin);
  var_2 = undefined;

  if(isDefined(var_1.target)) {
    var_2 = getent(var_1.target, "targetname");

  }
  if(isDefined(var_2)) {
    level.player setplayerangles(vectortoangles(var_2.origin - var_1.origin));
  } else {
    level.player setplayerangles(var_1.angles);
  }
}

_id_166B(var_0) {
  self endon("death");
  self endon("stop_random_tank_fire");
  var_1 = undefined;

  for(;;) {
    if(isDefined(var_1) && var_1.health > 0) {
      self setturrettargetent(var_1, (randomintrange(-64, 64), randomintrange(-64, 64), randomintrange(-16, 100)));

      if(sighttracepassed(self.origin + (0, 0, 100), var_1.origin + (0, 0, 40), 0, self)) {
        self._id_166C++;
        self fireweapon();

        if(self._id_166C >= 3) {
          if((!isDefined(var_1.damageshield) || var_1.damageshield == 0) && (!isDefined(var_1._id_0D04) || var_1._id_0D04 == 0)) {
            var_1 notify("death");
          }
        }

        wait(randomintrange(4, 10));
      } else {
        var_1 = undefined;
        wait 1;
      }
    } else {
      if(!isalive(self)) {
        break;
      }

      var_1 = _id_166D(var_0);
      self._id_166C = 0;
      wait 1;
    }

    wait(randomfloatrange(0.05, 0.5));
  }
}

_id_166D(var_0) {
  var_1 = getEntArray(var_0, "script_noteworthy");

  if(isDefined(var_1)) {
    var_2 = common_scripts\utility::random(var_1);

    if(isDefined(var_2) && !isspawner(var_2) && var_2.health > 0) {
      var_3 = var_2;
      self notify("new_target");
      return var_3;
    } else {
      return undefined;
    }
  }

  return undefined;
}

_id_166E(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 1;

  }
  var_4 = getEntArray(var_1, "script_noteworthy");
  var_5 = [];
  var_6 = 0;
  var_7 = [];

  foreach(var_9 in var_4) {
    if(isspawner(var_9)) {
      var_5[var_5.size] = var_9;
    }
  }

  var_11 = common_scripts\utility::getstruct(var_0, "targetname");
  var_12 = 0;

  foreach(var_14 in var_5) {
    var_15 = var_14 maps\_utility::_id_166F(1);

    if(var_2) {
      var_15 thread maps\_utility::_id_139E();

    }
    var_15 forceteleport(var_11.origin, var_11.angles);
    var_15 setgoalpos(var_15.origin);
    var_7 = maps\_utility::_id_0BC3(var_7, var_15);
    var_12++;

    if(isDefined(var_3) && var_12 >= var_3) {
      return var_7;
    }
  }

  return var_7;
}

_id_1670() {
  if(level.player isthrowinggrenade()) {
    wait 1.2;

  }
  level.player allowmelee(0);
  level.player disableoffhandweapons();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowsprint(0);

  if(level.player getstance() != "stand") {
    level.player setstance("stand");
    wait 0.4;
  }
}

_id_1671() {
  level.player allowsprint(1);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player enableoffhandweapons();
  level.player allowmelee(1);
}

_id_1672(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;

  }
  level._id_1673 = level.player getcurrentweapon();
  level.player giveweapon(level._id_1674);
  level.player givemaxammo(level._id_1674);
  level.player switchtoweaponimmediate(level._id_1674);

  if(var_0) {
    level.player enableweapons();

  }
  level.player disableweaponswitch();
}

_id_1675(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;

  }
  level.player takeweapon(level._id_1674);

  if(isDefined(level._id_1673)) {
    level.player switchtoweapon(level._id_1673);

  }
  if(var_0) {
    level.player enableweapons();
    level.player enableweaponswitch();
  }

  level._id_1673 = undefined;
}

_id_1676() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1._id_1678)) {
      var_1._id_1678 = var_1 maps\_hud_util::createserverclientfontstring("default", 1.75);
      var_1._id_1678.horzalign = "center";
      var_1._id_1678.vertalign = "top";
      var_1._id_1678.alignx = "center";
      var_1._id_1678.aligny = "top";
      var_1._id_1678.x = 0;
      var_1._id_1678.y = 20;
      var_1._id_1678 settext(&"VARIABLE_SCOPE_SNIPER_ZOOM");
      var_1._id_1678.alpha = 0;
      var_1._id_1678.sort = 0.5;
      var_1._id_1678.foreground = 1;
    }

    var_1._id_1679 = 1;
  }

  var_3 = 0;
  level.players[0]._id_167A = "cg_playerFovScale0";

  if(level.players.size == 2) {
    level.players[1]._id_167A = "cg_playerFovScale1";

  }
  foreach(var_1 in level.players) {
    var_1 thread _id_1680();
    var_1 thread _id_1681();
  }

  if(!isDefined(level.variable_scope_weapons)) {
    level.variable_scope_weapons = [];

  }
  var_6 = undefined;
  var_7 = undefined;

  for(;;) {
    var_8 = 0;
    var_7 = var_6;
    var_6 = undefined;

    foreach(var_10 in level.variable_scope_weapons) {
      foreach(var_1 in level.players) {
        if(var_1 getcurrentweapon() == var_10 && isalive(var_1)) {
          var_8 = 1;
          var_6 = var_1;
          break;
        }
      }

      if(var_8) {
        break;
      }
    }

    if(var_8 && !var_6 isreloading() && !var_6 isswitchingweapon()) {
      if(var_6 maps\_utility::_id_167C() && var_6 adsbuttonpressed()) {
        var_6 _id_167E(var_3);
        var_3 = 1;

        if(isDefined(level._id_167D)) {
          var_14 = undefined;
          var_15 = undefined;
          var_16 = anglesToForward(var_6 getplayerangles());
          var_17 = var_6.origin;

          foreach(var_19 in level._id_167D) {
            var_20 = anglesToForward(vectortoangles(var_19 - var_17));
            var_21 = vectordot(var_16, var_20);

            if(!isDefined(var_14) || var_21 > var_15) {
              var_14 = var_19;
              var_15 = var_21;
            }
          }

          if(isDefined(var_14)) {
            setsaveddvar("sm_sunShadowCenter", var_14);
          }
        }
      } else if(var_3) {
        var_3 = 0;

        if(isDefined(var_6)) {
          var_6 _id_167F();

        }
        setsaveddvar("sm_sunShadowCenter", "0 0 0");
      }
    } else if(var_3) {
      var_3 = 0;

      if(isDefined(var_7)) {
        var_7 _id_167F();

      }
      setsaveddvar("sm_sunShadowCenter", "0 0 0");
    }

    wait 0.05;
  }
}

_id_167E(var_0) {
  self disableoffhandweapons();
  setsaveddvar(self._id_167A, self._id_1679);
  self._id_1678.alpha = 1;

  if(!var_0) {
    level notify("variable_sniper_hud_enter");
  }
}

_id_167F() {
  level notify("variable_sniper_hud_exit");
  self enableoffhandweapons();
  setsaveddvar(self._id_167A, 1);
  self._id_1678.alpha = 0;
}

_id_1680() {
  notifyoncommand("mag_cycle", "+melee_zoom");
  notifyoncommand("mag_cycle", "+sprint_zoom");

  for(;;) {
    self waittill("mag_cycle");

    if(self._id_1678.alpha) {
      if(self._id_1679 == 0.5) {
        self._id_1679 = 1;
        continue;
      }

      self._id_1679 = 0.5;
    }
  }
}

_id_1681() {
  self waittill("death");
  _id_167F();
}

_id_1682(var_0) {
  if(var_0 == 0.5) {
    return 10;

  }
  if(var_0 == 1) {
    return 5;

  }
  return 5;
}

_id_1683(var_0) {
  var_1 = var_0 - self.origin;
  return (vectordot(var_1, anglesToForward(self.angles)), -1.0 * vectordot(var_1, anglestoright(self.angles)), vectordot(var_1, anglestoup(self.angles)));
}

_id_1684(var_0, var_1) {
  return (var_0[1] * var_1[2] - var_0[2] * var_1[1], var_0[2] * var_1[0] - var_0[0] * var_1[2], var_0[0] * var_1[1] - var_0[1] * var_1[0]);
}

_id_1685(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 2.0;

  if(isDefined(var_5)) {
    var_6 = var_5;

  }
  var_7 = level.player maps\_hud_util::createserverclientfontstring("default", var_6);
  var_7.x = var_1;
  var_7.y = var_2;
  var_7.sort = 1;
  var_7.horzalign = "fullscreen";
  var_7.vertalign = "fullscreen";
  var_7.alpha = 1.0;

  if(!isDefined(var_3)) {
    var_3 = (1, 1, 1);

  }
  var_7.color = var_3;

  if(isDefined(var_4)) {
    var_7.label = var_4;

  }
  level._id_1686[var_0] = var_7;
}

_id_1687(var_0, var_1) {
  level._id_1686[var_0] setvalue(var_1);
}

_id_1688(var_0, var_1) {
  level._id_1686[var_0] settext(var_1);
}

_id_1689(var_0, var_1) {
  level._id_1686[var_0].color = var_1;
}

_id_168A(var_0) {
  level._id_1686[var_0] destroy();
  level._id_1686[var_0] = undefined;
}

_id_168B(var_0, var_1, var_2, var_3, var_4) {
  level endon("stop_reminders");
  level endon("missionfailed");
  var_5 = undefined;

  if(!isDefined(var_3)) {
    var_3 = 10;

  }
  if(!isDefined(var_4)) {
    var_4 = 20;

  }
  while(!common_scripts\utility::flag(var_1)) {
    var_6 = randomfloatrange(var_3, var_4);
    var_7 = common_scripts\utility::random(var_2);

    if(isDefined(var_5) && var_7 == var_5) {
      continue;
    } else {
      var_5 = var_7;
      wait(var_6);

      if(!common_scripts\utility::flag(var_1)) {
        if(isstring(var_0) && var_0 == "radio") {
          _id_168D();
          maps\_utility::_id_11F4(var_7);
          _id_168E();
          continue;
        }

        _id_168D();
        var_0 maps\_utility::_id_168C(var_7);
        _id_168E();
      }
    }
  }
}

_id_168D() {
  if(!common_scripts\utility::flag_exist("flag_conversation_in_progress")) {
    common_scripts\utility::flag_init("flag_conversation_in_progress");

  }
  common_scripts\utility::flag_waitopen("flag_conversation_in_progress");
  common_scripts\utility::flag_set("flag_conversation_in_progress");
}

_id_168E() {
  common_scripts\utility::flag_clear("flag_conversation_in_progress");
}

_id_168F(var_0, var_1) {
  foreach(var_4, var_3 in var_0) {
    if(var_3 == var_1) {
      return var_4;
    }
  }

  return undefined;
}

_id_1690(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(!isDefined(_id_168F(var_2, var_4))) {
      var_2[var_2.size] = var_4;
    }
  }

  foreach(var_4 in var_1) {
    if(!isDefined(_id_168F(var_2, var_4))) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_1691(var_0) {
  var_1 = getEntArray();

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_1692) && common_scripts\utility::string_starts_with(var_3._id_1692, var_0)) {
      var_3._id_1693 = 1;
    }
  }
}

_id_1694(var_0) {
  var_1 = getEntArray();

  foreach(var_3 in var_1) {
    if(isDefined(var_3.classname) && var_3.classname == var_0) {
      var_3._id_1693 = 1;
    }
  }
}

_id_1695(var_0) {
  var_0 endon("remove_laser_targeting_device");
  var_0._id_1696 = undefined;
  var_0._id_1697 = 0;
  var_0 setweaponhudiconoverride("actionslot4", "dpad_laser_designator");
  var_0 thread _id_169C();
  var_0 notifyonplayercommand("use_laser", "+actionslot 4");
  var_0 notifyonplayercommand("fired_laser", "+attack");
  var_0 notifyonplayercommand("fired_laser", "+attack_akimbo_accessible");
  var_0._id_1698 = 1;
  var_0._id_1699 = 20;
  var_0 childthread _id_169D();

  for(;;) {
    var_0 waittill("use_laser");

    if(var_0._id_1697 || !var_0._id_1698 || var_0 _id_169A()) {
      var_0 notify("cancel_laser");
      var_0 laserforceoff();
      var_0._id_1697 = 0;
      var_0 allowads(1);
      wait 0.2;
      var_0 allowfire(1);
      continue;
    }

    var_0 laserforceon();
    var_0 allowfire(0);
    var_0._id_1697 = 1;
    var_0 allowads(0);
    var_0 thread _id_169E();
  }
}

_id_169A() {
  var_0 = self getcurrentweapon();

  if(var_0 == "rpg") {
    return 1;

  }
  if(common_scripts\utility::string_starts_with(var_0, "gl")) {
    return 1;

  }
  if(isDefined(level._id_169B) && isarray(level._id_169B)) {
    foreach(var_2 in level._id_169B) {
      if(var_0 == var_2) {
        return 1;
      }
    }
  }

  if(self isreloading()) {
    return 1;

  }
  if(self isthrowinggrenade()) {
    return 1;

  }
  return 0;
}

_id_169C() {
  self waittill("remove_laser_targeting_device");
  self setweaponhudiconoverride("actionslot4", "none");
  self notify("cancel_laser");
  self laserforceoff();
  self._id_1697 = undefined;
  self allowfire(1);
  self allowads(1);
}

_id_169D() {
  for(;;) {
    if(_id_169A() && isDefined(self._id_1697) && self._id_1697) {
      self notify("use_laser");
      wait 2.0;
    }

    wait 0.05;
  }
}

_id_169E() {
  self endon("cancel_laser");

  for(;;) {
    self waittill("fired_laser");
    var_0 = _id_16A2();
    var_1 = var_0["position"];
    var_2 = var_0["entity"];
    level notify("laser_coordinates_received");
    var_3 = undefined;

    if(isDefined(level._id_169F) && isDefined(var_2) && maps\_utility::_id_0AD1(level._id_169F, var_2)) {
      var_3 = var_2;
      level._id_169F = common_scripts\utility::array_remove(level._id_169F, var_2);
    } else {
      var_3 = _id_16A0(var_1);

    }
    if(isDefined(var_3)) {
      thread _id_16A3(var_3);
      level notify("laser_target_painted");
      wait 0.5;
      self notify("use_laser");
    }
  }
}

_id_16A0(var_0) {
  if(!isDefined(level._id_16A1) || level._id_16A1.size == 0) {
    return undefined;

  }
  foreach(var_2 in level._id_16A1) {
    var_3 = distance2d(var_0, var_2.origin);
    var_4 = var_0[2] - var_2.origin[2];

    if(!isDefined(var_2.radius)) {
      continue;
    }
    if(!isDefined(var_2.height)) {
      continue;
    }
    if(var_3 <= var_2.radius && var_4 <= var_2.height && var_4 >= 0) {
      level._id_16A1 = common_scripts\utility::array_remove(level._id_16A1, var_2);
      return getent(var_2.target, "script_noteworthy");
    }
  }

  return undefined;
}

_id_16A2() {
  var_0 = self getEye();
  var_1 = self getplayerangles();
  var_2 = anglesToForward(var_1);
  var_3 = var_0 + var_2 * 7000;
  var_4 = bulletTrace(var_0, var_3, 1, self);
  var_5 = var_4["entity"];

  if(isDefined(var_5)) {
    var_4["position"] = var_5.origin;

  }
  return var_4;
}

_id_16A3(var_0) {
  level.player endon("remove_laser_targeting_device");
  level.player._id_1698 = 0;
  self setweaponhudiconoverride("actionslot4", "dpad_killstreak_hellfire_missile_inactive");
  maps\_utility::_id_16A4("allies");
  var_1 = level.player;
  wait 2.5;

  if(!isDefined(var_0._id_16A5)) {
    var_0._id_16A5 = 99;

  }
  wait 1;

  if(isDefined(var_0._id_16A6)) {
    var_2 = _id_16A7("geo_before", var_0._id_16A6);

    if(var_2.size > 0) {
      common_scripts\utility::array_call(var_2, ::hide);

    }
    var_3 = _id_16A7("geo_after", var_0._id_16A6);

    if(var_3.size > 0) {
      common_scripts\utility::array_call(var_3, ::show);
    }
  }

  wait(level.player._id_1699);
  level.player._id_1698 = 1;
  self setweaponhudiconoverride("actionslot4", "dpad_laser_designator");
}

_id_16A7(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(isDefined(var_5._id_16A6) && var_5._id_16A6 == var_1) {
      var_3[var_3.size] = var_5;
    }
  }

  return var_3;
}

_id_16A8(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(self.inuse) || self.inuse == 0) {
    self.inuse = 1;
  } else {
    wait 0.05;
    return 0;
  }

  var_8 = 0;

  if(!isDefined(var_2)) {
    var_2 = 3;

  }
  var_9 = 57;
  var_10 = maps\_hud_util::createclientprogressbar(var_0, var_9);
  var_0 playerlinkto(self);
  var_0 playerlinkedoffsetenable();
  var_0 disableweapons();
  var_0 disableoffhandweapons();
  var_0 allowmelee(0);
  var_11 = undefined;

  if(isDefined(var_3)) {
    var_11 = var_0 maps\_hud_util::createserverclientfontstring("default", 1.2);
    var_11 maps\_hud_util::setpoint("CENTER", undefined, 0, 45);
    var_11 settext(var_3);
  }

  var_12 = 0;

  while(var_0 usebuttonpressed()) {
    var_10 maps\_hud_util::updatebar(var_8 / var_2);
    wait 0.05;
    var_8 = var_8 + 0.05;

    if(var_8 > var_2) {
      if(isDefined(var_4)) {
        thread _id_16AD(var_0, var_4);

      }
      if(isDefined(var_1)) {
        [[var_1]]();

      }
      var_12 = 1;
      break;
    }

    if(var_0.laststand == 1) {
      break;
    }

    if(isDefined(var_7) && common_scripts\utility::flag(var_7)) {
      break;
    }

    if(common_scripts\utility::flag("missionfailed")) {
      break;
    }
  }

  if(!var_12) {
    if(isDefined(var_6)) {
      thread _id_16AB(var_0, var_6);

    }
    if(isDefined(var_5)) {
      [[var_5]]();
    }
  }

  var_0 allowmelee(1);
  var_0 enableoffhandweapons();

  if(!(isDefined(var_7) && var_7 == "dog_attack" && common_scripts\utility::flag("dog_attack"))) {
    var_0 enableweapons();
    var_0 unlink();
  }

  self.inuse = 0;

  if(isDefined(var_11)) {
    var_11 maps\_hud_util::destroyelem();

  }
  var_10 maps\_hud_util::destroyelem();
  return var_12;
}

_id_16AA(var_0, var_1, var_2, var_3) {
  if(isDefined(self)) {
    self playSound(var_3, "sound_played", 1);

  }
  var_4 = newclienthudelem(var_0);
  var_4.alignx = "center";
  var_4.aligny = "middle";
  var_4.horzalign = "center";
  var_4.vertalign = "middle";
  var_4.font = "hudsmall";
  var_4.foreground = 1;
  var_4.hidewheninmenu = 1;
  var_4.hidewhendead = 1;
  var_4.sort = 2;
  var_4.label = var_1;
  var_4[[var_2]]();
  var_4 thread _id_16AF();
  wait 2;
  var_4 notify("stop_blink");
  wait 0.05;
  var_4 destroy();
}

_id_16AB(var_0, var_1) {
  _id_16AA(var_0, var_1, maps\_specialops::_id_16AC, "so_sample_not_collected");
}

_id_16AD(var_0, var_1) {
  _id_16AA(var_0, var_1, maps\_specialops::_id_16AE, "arcademode_2x");
}

_id_16AF(var_0) {
  self endon("stop_blink");
  self endon("death");
  var_1 = 0.1;
  var_2 = 0.5;

  for(;;) {
    self fadeovertime(var_1);
    self.alpha = 1;
    wait(var_2);
    self fadeovertime(var_1);
    self.alpha = 0;
    wait(var_2);
  }
}

_id_16B0() {
  var_0 = getEntArray("shg_vision_multiple_trigger", "targetname");

  foreach(var_2 in var_0) {}
  var_2 thread _id_16B1();
}

_id_16B1() {
  var_0 = common_scripts\utility::getstructarray(self.target, "targetname");

  foreach(var_2 in var_0) {
    var_3 = vectornormalize(self.origin - var_2.origin);
    var_2._id_16B2 = var_3;
  }

  for(;;) {
    self waittill("trigger", var_5);

    if(isplayer(var_5)) {
      var_6 = anglesToForward(var_5 getplayerangles());
      var_7 = undefined;
      var_8 = 0;

      foreach(var_2 in var_0) {
        var_10 = vectordot(var_6, var_2._id_16B2);

        if(!isDefined(var_7) || var_10 < var_8) {
          var_7 = var_2;
          var_8 = var_10;
        }
      }

      var_12 = 1;

      if(isDefined(var_7._id_1662)) {
        var_12 = var_7._id_1662;

      }
      var_7 maps\_lights::_id_1663(var_12);
      wait(var_12);
    }
  }
}

_id_16B3(var_0) {
  self setModel(var_0);
  _id_16B4(self.weapon);
}

_id_16B4(var_0, var_1) {
  if(isDefined(var_0) && var_0 != "none") {
    var_2 = getweaponhidetags(var_0);
    var_3 = 0;
    var_4 = getweaponmodel(var_0, var_3);

    if(isDefined(var_1)) {
      var_4 = var_1;

    }
    for(var_5 = 0; var_5 < var_2.size; var_5++) {
      self hidepart(var_2[var_5], var_4);
    }
  }
}

_id_16B5(var_0, var_1, var_2) {
  if(issplitscreen()) {
    if(self == level.player) {
      var_0 = var_0 + 2;

    }
    var_0 = var_0 / 2;
  }

  return maps\_specialops::_id_16B6(var_0, var_1, var_2, self);
}

_id_16B7(var_0, var_1, var_2, var_3, var_4, var_5) {
  level._id_16B8 = "award_positive";
  level._id_16B9 = "award_positive";
  level._id_16BA = _id_16BE(var_0, var_1, var_2);
  level._id_16BB = _id_16BE(var_3, var_4, var_5);
  common_scripts\utility::array_thread(level.players, ::_id_16BF);
  level._id_16BC = 1;
  level._id_16BD = ::_id_16C2;
  _id_16D5();
}

_id_16BE(var_0, var_1, var_2) {
  var_3 = [];

  if(isDefined(var_0)) {
    var_3["value"] = var_1;
    var_3["description"] = var_0;
    var_3["max_successes"] = var_2;
  } else {
    var_3["value"] = 0;
    var_3["description"] = "";
    var_3["max_successes"] = undefined;
  }

  return var_3;
}

_id_16BF() {
  if(!isDefined(self._id_16C0)) {
    self._id_16C0 = 0;

  }
  if(!isDefined(self._id_16C1)) {
    self._id_16C1 = 0;
  }
}

_id_16C2() {
  if(issplitscreen()) {
    setdvar("ui_hide_hint", 1);

  }
  if(!level._id_16C9) {
    setdvar("ui_hide_hint", 1);

  }
  level._id_16C3 = _id_16CA();
  level._id_16C4 = 0;

  foreach(var_1 in level.players) {
    var_1._id_16C5 = _id_16CD(var_1);
    level._id_16C4 = level._id_16C4 + var_1._id_16C5["kill_score"];
    level._id_16C4 = level._id_16C4 + var_1._id_16C5["challenge_1"];
    level._id_16C4 = level._id_16C4 + var_1._id_16C5["challenge_2"];
  }

  level._id_16C4 = level._id_16C4 + level.players[0]._id_16C5["gameskill_score"];
  level._id_16C4 = level._id_16C4 + level.players[0]._id_16C5["time_score"];
  level._id_16C4 = int(level._id_16C4);

  foreach(var_1 in level.players) {
    var_1 maps\_specialops::_id_17FE(level._id_16C4);

    if(maps\_utility::_id_12C1()) {
      var_4 = maps\_utility::_id_133A(var_1);
      var_1 maps\_utility::_id_16C7("", "@SPECIAL_OPS_PERFORMANCE_YOU", "@SPECIAL_OPS_PERFORMANCE_PARTNER");
      var_1 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_DIFFICULTY", var_1._id_16C5["difficulty"], var_4._id_16C5["difficulty"]);
      var_1 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_KILLS", var_1._id_16C5["kills_num"], var_4._id_16C5["kills_num"]);
      var_1 maps\_utility::_id_16C7(level._id_16BA["description"], var_1._id_16C5["ch_1_tally"], var_4._id_16C5["ch_1_tally"]);

      if(level._id_16BB["value"] > 0) {
        var_1 maps\_utility::_id_16C7(level._id_16BB["description"], var_1._id_16C5["ch_2_tally"], var_4._id_16C5["ch_2_tally"]);

      }
      var_1 maps\_utility::_id_16C7(var_1._id_16C5["t_message"], "", var_4._id_16C5["time_string"]);

      if(level._id_16BB["value"] <= 0 || !issplitscreen()) {
        var_1 maps\_utility::_id_16C8();

      }
      if(!level._id_16C9) {
        var_1 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_SCORE", "", level._id_16C4);

      }
      continue;
    }

    if(!level._id_16C9) {
      var_1 maps\_utility::_id_16C7("", "", "@SPECIAL_OPS_POINTS");
      var_1 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_DIFFICULTY", var_1._id_16C5["difficulty"], var_1._id_16C5["gameskill_score"]);
      var_1 maps\_utility::_id_16C7(var_1._id_16C5["t_message"], var_1._id_16C5["time_string"], var_1._id_16C5["time_score"]);
      var_1 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_KILLS", var_1._id_16C5["kills_num"], var_1._id_16C5["kill_score"]);
      var_1 maps\_utility::_id_16C7(level._id_16BA["description"], var_1._id_16C5["ch_1_tally"], var_1._id_16C5["challenge_1"]);

      if(level._id_16BB["value"] > 0) {
        var_1 maps\_utility::_id_16C7(level._id_16BB["description"], var_1._id_16C5["ch_2_tally"], var_1._id_16C5["challenge_2"]);

      }
      if(level._id_16BB["value"] <= 0 || !issplitscreen()) {
        var_1 maps\_utility::_id_16C8();

      }
      var_1 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_SCORE", " ", level._id_16C4);
      continue;
    }

    var_1 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_DIFFICULTY", "", var_1._id_16C5["difficulty"]);
    var_1 maps\_utility::_id_16C7(var_1._id_16C5["t_message"], "", var_1._id_16C5["time_string"]);
    var_1 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_KILLS", "", var_1._id_16C5["kills_num"]);
    var_1 maps\_utility::_id_16C7(level._id_16BA["description"], "", var_1._id_16C5["ch_1_tally"]);

    if(level._id_16BB["value"] > 0) {
      var_1 maps\_utility::_id_16C7(level._id_16BB["description"], "", var_1._id_16C5["ch_2_tally"]);
    }
  }
}

_id_16CA() {
  if(!isDefined(level._id_16CB)) {
    level._id_16CB = 420000;

  }
  if(!isDefined(level._id_4412)) {
    level._id_4412 = 0;

  }
  if(!isDefined(level._id_16C3)) {
    level._id_16CC = 0;
    level._id_16C3 = level._id_16CB;
  } else {
    level._id_16CC = 1;

  }
  level._id_4413 = level._id_16CB - level._id_4412;
  return level._id_16C3;
}

_id_16CD(var_0, var_1, var_2) {
  var_0._id_16C5 = [];
  var_0._id_16C5["final_score"] = 0;
  var_0._id_16C5["level_time"] = level._id_16CE - level._id_16CF;

  if(level._id_16C3 > var_0._id_16C5["level_time"]) {
    var_0._id_16C5["t_message"] = _id_16D4("bonus");
    var_0._id_16C5["remaining_time"] = int(level._id_16C3 - var_0._id_16C5["level_time"]);

    if(!level._id_16C9) {}

    if(!level._id_16CC) {
      if(level._id_4412 <= var_0._id_16C5["level_time"]) {
        var_0._id_16C5["time_percent"] = max((level._id_4413 - (var_0._id_16C5["level_time"] - level._id_4412)) / level._id_4413, 0.0);
      } else {
        var_0._id_16C5["time_percent"] = 1;
      }
    } else if(level._id_4412 >= var_0._id_16C5["remaining_time"]) {
      var_0._id_16C5["time_percent"] = max(var_0._id_16C5["remaining_time"] / level._id_4413, 0.0);
    } else {
      var_0._id_16C5["time_percent"] = 1;

    }
    var_0._id_16C5["time_score"] = int(var_0._id_16C5["time_percent"] * 5000);

    if(level._id_16CC) {
      var_0._id_16C5["time_string"] = maps\_utility::_id_16D0(var_0._id_16C5["remaining_time"] * 0.001, 1);
    } else {
      var_0._id_16C5["time_string"] = maps\_utility::_id_16D0(var_0._id_16C5["level_time"] * 0.001, 1);

    }
    var_0._id_16C5["final_score"] = var_0._id_16C5["final_score"] + var_0._id_16C5["time_score"];
  } else {
    var_0._id_16C5["t_message"] = _id_16D4("no_bonus");
    var_0._id_16C5["time_string"] = maps\_utility::_id_16D0(var_0._id_16C5["level_time"] * 0.001, 1);
    var_0._id_16C5["time_score"] = 0;
  }

  var_0._id_16C5["gameskill_low"] = level._id_16D1;
  var_0._id_16C5["gameskill_score"] = max(10000 * var_0._id_16C5["gameskill_low"], 0);
  var_0._id_16C5["final_score"] = var_0._id_16C5["final_score"] + var_0._id_16C5["gameskill_score"];

  if(isDefined(level._id_16BA["max_successes"])) {
    var_0._id_16C5["challenge_1"] = min(level._id_16BA["value"] * var_0._id_16C0, level._id_16BA["value"] * level._id_16BA["max_successes"]);
  } else {
    var_0._id_16C5["challenge_1"] = level._id_16BA["value"] * var_0._id_16C0;

  }
  if(isDefined(level._id_16BB["max_successes"])) {
    var_0._id_16C5["challenge_2"] = min(level._id_16BB["value"] * var_0._id_16C1, level._id_16BB["value"] * level._id_16BB["max_successes"]);
  } else {
    var_0._id_16C5["challenge_2"] = level._id_16BB["value"] * var_0._id_16C1;

  }
  var_0._id_16C5["final_score"] = var_0._id_16C5["final_score"] + var_0._id_16C5["challenge_1"] + var_0._id_16C5["challenge_2"];
  var_0._id_16C5["ch_1_tally"] = _id_16D3(var_0._id_16C0, level._id_16BA["max_successes"]);
  var_0._id_16C5["ch_2_tally"] = _id_16D3(var_0._id_16C1, level._id_16BB["max_successes"]);
  var_0._id_16C5["kills_num"] = var_0.stats["kills"];
  var_0._id_16C5["kill_score"] = min(var_0.stats["kills"] * 25, 2500);
  var_0._id_16C5["final_score"] = var_0._id_16C5["final_score"] + var_0._id_16C5["kill_score"];
  var_0._id_16C5["final_score"] = _id_16E0(var_0, var_0._id_16C5["final_score"], var_0._id_16C5["gameskill_score"]);
  var_0._id_16C5["difficulty"] = maps\_specialops::_id_16D2(var_0.gameskill);
  return var_0._id_16C5;
}

_id_16D3(var_0, var_1) {
  if(!isDefined(var_1) && var_0 > 0) {
    return var_0;

  }
  if(!isDefined(var_1) && var_0 == 0) {
    return "@SPECIAL_OPS_UI_CHALLENGE_FAIL";

  }
  if(isDefined(var_1) && var_1 == 1 && var_0 >= 1) {
    return "@SPECIAL_OPS_UI_CHALLENGE_COMPLETE";

  }
  if(isDefined(var_1) && var_0 == 0) {
    return "@SPECIAL_OPS_UI_CHALLENGE_FAIL";

  }
  if(isDefined(var_1) && var_0 > var_1) {
    var_0 = var_1;

  }
  if(maps\_utility::_id_12C1()) {
    return var_0;
  } else {
    return var_0 + " / " + var_1;
  }
}

_id_16D4(var_0) {
  if(var_0 == "bonus") {
    return "@SPECIAL_OPS_UI_TIME";

  }
  if(var_0 == "no_bonus") {
    return "@SPECIAL_OPS_UI_TIME";
  }
}

_id_16D5(var_0) {
  foreach(var_2 in level.players) {}
  var_2 thread _id_16D6(level._id_16BA["value"], level._id_16BB["value"]);
}

_id_16D6(var_0, var_1) {
  self._id_16D8 = _id_16DB(1, level._id_16BA, level._id_16B8, var_0, level._id_16D7);
  self._id_16DA = _id_16DB(2, level._id_16BB, level._id_16B9, var_1, level._id_16D9);
  thread _id_16DF();
  thread _id_16E1(self._id_16D8);
  thread _id_16E2(self._id_16DA);
  thread _id_12A9();
}

_id_12A9(var_0) {
  var_1 = self._id_16C0;
  var_2 = self._id_16C1;

  for(;;) {
    if(self._id_16C0 != var_1) {
      _id_16DD(self._id_16D8, var_1, 1);
      var_1 = self._id_16C0;
    }

    if(self._id_16C1 != var_2) {
      _id_16DD(self._id_16DA, var_2, 2);
      var_2 = self._id_16C1;
    }

    wait 0.05;
  }
}

_id_16DB(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_5["value"] = var_3;
  var_5["number"] = var_0;
  var_5["max"] = var_1["max_successes"];
  var_5["shader"] = var_2;
  var_5["text"] = var_4;
  return var_5;
}

_id_16DC(var_0) {
  if(var_0 == 1) {
    return self._id_16C0;

  }
  if(var_0 == 2) {
    return self._id_16C1;
  }
}

_id_16DD(var_0, var_1, var_2) {
  var_3 = _id_16DC(var_2);

  if(isDefined(var_0["max"]) && var_3 < var_0["max"]) {
    _id_16DE(var_0, var_1, var_2);
  } else if(!isDefined(var_0["max"])) {
    _id_16DE(var_0, var_1, var_2);
  }
}

_id_16DE(var_0, var_1, var_2) {
  var_3 = _id_16DC(var_2);

  for(var_4 = 0; var_4 < var_3 - var_1; var_4++) {
    if(var_2 == 1) {
      self notify("bonus1_achieved");
    } else {
      self notify("bonus2_achieved");

    }
    self notify("bonus_achieved");
  }
}

_id_16DF() {
  for(;;) {
    self waittill("bonus_achieved");
    thread common_scripts\utility::play_sound_in_space("arcademode_2x", self getEye());
    wait 0.5;
  }
}

_id_16E0(var_0, var_1, var_2) {
  var_3 = var_2 + 29999;
  var_1 = int(min(var_1, var_3));
  return var_1;
}

_id_16E1(var_0) {
  for(;;) {
    self waittill("bonus1_achieved");
    _id_16E3(150, 115, 1, var_0);
  }
}

_id_16E2(var_0) {
  for(;;) {
    self waittill("bonus2_achieved");
    _id_16E3(170, 135, 2, var_0);
  }
}

_id_16E3(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3["text"])) {
    var_4["bar"] = _id_16E6(59, var_0, "right", 0);
    var_4["bar"] _id_16E5(18);
    var_5 = [];
    var_5["text"] = _id_16E7(76, var_1, "right", 2);
    var_5["text"] settext(var_3["text"]);
    var_5["text"] thread _id_16E4();
    var_5["num"] = _id_16E7(76, var_1, "left", 2);
    var_5["num"] thread _id_16E4();
    var_6 = _id_16DC(var_2);

    for(var_7 = 0; var_7 < 90.0; var_7++) {
      var_8 = _id_16DC(var_2);
      var_9 = _id_16D3(var_8, var_3["max"]);
      var_5["num"] settext(" " + var_9);

      if(var_6 != var_8) {
        var_6 = var_8;
        var_5["num"] thread _id_16E4();
      }

      wait 0.05;
    }

    if(isDefined(var_4["bar"])) {
      var_4["bar"] destroy();

    }
    if(isDefined(var_5["text"])) {
      var_5["text"] destroy();

    }
    if(isDefined(var_5["num"])) {
      var_5["num"] destroy();
    }
  }
}

_id_16E4() {
  for(var_0 = 0; var_0 < 2; var_0++) {
    if(isDefined(self)) {
      self changefontscaleovertime(0.25);
      self.fontscale = 0.9;
      self.color = (0.65, 1, 0.65);
      wait 0.25;
    }

    if(isDefined(self)) {
      self changefontscaleovertime(0.25);
      self.fontscale = 0.75;
      self.color = (1, 1, 1);
      wait 0.25;
    }
  }
}

_id_16E5(var_0) {
  self scaleovertime(0.25, 100, var_0);
  wait 0.25;
}

_id_16E6(var_0, var_1, var_2, var_3) {
  var_4 = newclienthudelem(self);
  var_4 = _id_16E8(var_4, 59, var_1, "right", 0);
  var_4 setshader("hud_white_box", 100, 1);
  var_4.alpha = 0.5;
  var_4.color = (0.7, 0.8, 0.7);
  return var_4;
}

_id_16E7(var_0, var_1, var_2, var_3) {
  var_4 = maps\_hud_util::createserverclientfontstring("hudsmall", 0.75);
  var_4 = _id_16E8(var_4, 76, var_1, var_2, 2);
  return var_4;
}

_id_16E8(var_0, var_1, var_2, var_3, var_4) {
  var_0.x = var_1;
  var_0.y = var_2;
  var_0.alignx = var_3;
  var_0.aligny = "middle";
  var_0.foreground = 1;
  var_0.font = "hudsmall";
  var_0.hidewheninmenu = 1;
  var_0.hidewhendead = 1;
  var_0.sort = var_4;
  return var_0;
}

_id_16E9(var_0) {
  maps\_utility::_id_16EA();

  if(isDefined(self._id_1253)) {
    maps\_utility::_id_1254(self._id_1253, 0.5);

  }
  var_1 = [];
  var_1[0] = [self, 0];
  maps\_utility::_id_1255(::_id_16EB, var_1, var_0);

  if(isalive(self)) {
    self._id_1253 = gettime();
  }
}

_id_16EB(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = [];

  foreach(var_7, var_6 in var_0) {}
  var_4[var_7] = var_6[0];

  foreach(var_9 in var_4) {
    if(!isDefined(var_9)) {
      continue;
    }
    if(!isDefined(var_9._id_0BA3)) {
      var_9._id_0BA3 = 0;

    }
    var_9._id_0BA3++;
  }

  var_11 = maps\_anim::_id_1202(var_2);
  var_12 = var_11["origin"];
  var_13 = var_11["angles"];
  var_14 = "single anim";
  var_15 = spawnStruct();
  var_16 = 0;

  foreach(var_7, var_9 in var_4) {
    var_18 = 0;
    var_19 = 0;
    var_20 = 0;
    var_21 = 0;
    var_22 = undefined;
    var_23 = undefined;
    var_24 = var_9._id_1032;

    if(isDefined(level._id_11B7[var_24]) && isDefined(level._id_11B7[var_24][var_1])) {
      var_18 = 1;
      var_23 = level._id_11B7[var_24][var_1];
    }

    if(isDefined(level.scr_sound[var_24]) && isDefined(level.scr_sound[var_24][var_1])) {
      var_19 = 1;
      var_22 = level.scr_sound[var_24][var_1];
    }

    if(isDefined(level._id_0C59[var_24]) && isDefined(level._id_0C59[var_24][var_1]) && (!isai(var_9) || !var_9 maps\_utility::_id_0D69())) {
      var_20 = 1;

    }
    if(isDefined(level._id_11B9[var_24]) && isDefined(level._id_11B9[var_24][var_1])) {
      var_9 playSound(level._id_11B9[var_24][var_1]);

    }
    if(var_20) {
      var_9 maps\_anim::_id_1282();

      if(isplayer(var_9)) {
        var_25 = level._id_0C59[var_24]["root"];
        var_9 setanim(var_25, 0, 0.2);
        var_26 = level._id_0C59[var_24][var_1];
        var_9 setflaggedanim(var_14, var_26, 1, 0.2);
      } else if(var_9.code_classname == "misc_turret") {
        var_26 = level._id_0C59[var_24][var_1];
        var_9 setflaggedanim(var_14, var_26, 1, 0.2);
      } else {
        var_9 animscripted(var_14, var_12, var_13, level._id_0C59[var_24][var_1]);

      }
      thread maps\_anim::_id_0C61(var_9, var_14, var_1, var_24);
      thread maps\_anim::_id_0C62(var_9, var_14, var_1);
    }

    if(var_18 || var_19) {
      if(var_18) {
        if(var_19) {
          var_9 thread _id_16F0(var_1, var_18, var_22, level._id_11B7[var_24][var_1]);

        }
        thread maps\_anim::_id_1269(var_9, var_1, level._id_11B7[var_24][var_1]);
      } else if(isai(var_9)) {
        if(var_20) {
          var_9 animscripts\face::_id_0C46(var_23, var_22, 1.0);
        } else {
          var_9 thread maps\_anim::_id_0BDB("single dialogue");
          var_9 animscripts\face::_id_0C46(var_23, var_22, 1.0, "single dialogue");
        }
      } else {
        var_9 thread maps\_utility::play_sound_on_entity(var_22, "single dialogue");
      }
    }

    if(var_20) {
      var_27 = getanimlength(level._id_0C59[var_24][var_1]);
      var_15 thread _id_16EC(var_9, var_1);
      var_15 thread _id_16EF(var_9, var_1, var_27, var_0[var_7][1]);
      var_16++;
      continue;
    }

    if(var_18) {
      var_15 thread _id_16EC(var_9, var_1);
      var_15 thread _id_16ED(var_9, var_1, var_23);
      var_16++;
      continue;
    }

    if(var_19) {
      var_15 thread _id_16EC(var_9, var_1);
      var_15 thread _id_16EE(var_9, var_1);
      var_16++;
    }
  }

  while(var_16 > 0) {
    var_15 waittill(var_1, var_9);
    var_16--;

    if(!isDefined(var_9)) {
      continue;
    }
    if(isplayer(var_9)) {
      var_24 = var_9._id_1032;

      if(isDefined(level._id_0C59[var_24][var_1])) {
        var_25 = level._id_0C59[var_24]["root"];
        var_9 setanim(var_25, 1, 0.2);
        var_26 = level._id_0C59[var_24][var_1];
        var_9 clearanim(var_26, 0.2);
      }
    }

    var_9._id_0BA3--;
    var_9._id_11BE = gettime();
  }

  self notify(var_1);
}

_id_16EC(var_0, var_1) {
  var_0 endon("kill_anim_end_notify_" + var_1);
  var_0 waittill("death");
  self notify(var_1, var_0);
  var_0 notify("kill_anim_end_notify_" + var_1);
}

_id_16ED(var_0, var_1, var_2) {
  var_0 endon("kill_anim_end_notify_" + var_1);
  var_3 = getanimlength(var_2);
  wait(var_3);
  self notify(var_1, var_0);
  var_0 notify("kill_anim_end_notify_" + var_1);
}

_id_16EE(var_0, var_1) {
  var_0 endon("kill_anim_end_notify_" + var_1);
  var_0 waittill("single dialogue");
  self notify(var_1, var_0);
  var_0 notify("kill_anim_end_notify_" + var_1);
}

_id_16EF(var_0, var_1, var_2, var_3) {
  var_0 endon("kill_anim_end_notify_" + var_1);
  var_2 = var_2 - var_3;

  if(var_3 > 0 && var_2 > 0) {
    var_0 maps\_utility::_id_11E4("single anim", "end", var_2);
    var_0 stopanimscripted();
  } else {
    var_0 waittillmatch("single anim", "end");

  }
  var_0 notify("anim_ended");
  self notify(var_1, var_0);
  var_0 notify("kill_anim_end_notify_" + var_1);
}

_id_16F0(var_0, var_1, var_2, var_3) {
  if(var_1) {
    thread _id_16F1(var_0);
    thread _id_16F2(var_0);
    thread _id_16F3(var_0);
    var_4 = [];

    if(!isarray(var_2)) {
      var_4[0] = var_2;
    } else {
      var_4 = var_2;

    }
    foreach(var_6 in var_4) {
      self waittillmatch("face_done_" + var_0, "dialogue_line");
      animscripts\face::_id_0C46(undefined, var_6, 1.0);
    }

    self notify("all_facial_lines_done");
  } else {
    animscripts\face::_id_0C46(undefined, var_2, 1.0, "single dialogue");
  }
}

_id_16F1(var_0) {
  self endon("death");
  self waittillmatch("face_done_" + var_0, "end");
  self notify("facial_anim_end_" + var_0);
}

_id_16F2(var_0) {
  self endon("death");
  self endon("all_facial_lines_done");
  self waittill("facial_anim_end_" + var_0);
}

_id_16F3(var_0) {
  self endon("death");
  self endon("facial_anim_end_" + var_0);
  self waittill("all_facial_lines_done");
  self waittillmatch("face_done_" + var_0, "dialogue_line");
}