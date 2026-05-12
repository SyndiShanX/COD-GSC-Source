/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_broadcaster.gsc
**********************************************/

func_00D5() {
  level.broadcasters = [];
}

func_1C8B() {
  if(!self method_8436()) {
    return;
  }

  if(!isai(self)) {
    level.broadcasters[self getentitynumber()] = self;
    thread func_1CAD();
  }
}

monitorpuckcolor(param_00) {
  var_01 = "mp/broadcasterColors.csv";
  var_02 = 2;
  var_03 = "broadcaster_" + self getentitynumber() + "_player_puck";
  for(;;) {
    self waittill("luinotifyserver", var_04, var_05);
    if(var_04 == "broadcaster_set_color_" + param_00) {
      var_06 = int(floor(var_05 / 100));
      if(var_06 == self getentitynumber()) {
        var_07 = var_05 % 100;
        var_08 = tablelookupbyrow(var_01, var_07 - 1, var_02);
        level.var_0611[var_03 + "_" + param_00] = loadfx("vfx/ui/" + var_08);
        break;
      }
    }
  }
}

monitorzoom() {
  for(;;) {
    self waittill("luinotifyserver", var_00, var_01);
    if(var_00 == "broadcaster_set_initial_zoom") {
      var_02 = int(floor(var_01 / 100));
      if(var_02 == self getentitynumber()) {
        var_03 = var_01 % 100;
        self.var_1E99.var_ACCB = var_03;
        break;
      }
    }
  }
}

initializeclientvalues() {
  if(!isDefined(level.var_0611["broadcaster_followed_player"])) {
    level.var_0611["broadcaster_followed_player"] = loadfx("vfx/ui/esports_ui_puck_selected");
  }

  thread monitorpuckcolor("allies");
  thread monitorpuckcolor("axis");
  thread monitorzoom();
  function_0226(&"broadcaster_request_client_values", 1, self getentitynumber());
  func_1CA2();
}

func_1CAD() {
  if(isbot(self)) {
    return;
  }

  setdvarifuninitialized("broadcaster_player_target_vfx", 0);
  setdvarifuninitialized("broadcaster_follower_killer", 1);
  setdvarifuninitialized("broadcaster_team_pucks", 1);
  self.var_01A7 = "spectator";
  self.var_0179 = "spectator";
  maps\mp\_utility::func_A165("spectator");
  maps\mp\gametypes\_spectating::func_872F();
  self allowspectateteam("allies", 1);
  self allowspectateteam("axis", 1);
  self allowspectateteam("freelook", 1);
  self allowspectateteam("none", 1);
  thread func_1C9D();
  thread initializeclientvalues();
  thread func_1C9B();
  func_1CA4();
  func_44DC();
  thread func_1C9C();
  thread func_1C91();
  thread func_1CA3();
  wait 0.05;
  self notify("broadcaster_view_set_sky_cam");
}

func_44DC() {
  level endon("game_ended");
  for(;;) {
    foreach(var_01 in level.var_744A) {
      if(!var_01 method_8436() && var_01.var_4B96) {
        wait(0.15);
        thread func_1CA7(var_01 getentitynumber());
        return;
      }
    }

    wait 0.05;
  }
}

func_1CA5() {
  if(self.var_1E99.var_77AC) {
    self.var_1E99.var_77AC = 0;
    self notify("broadcaster_stop_player_pucks");
    return;
  }

  self.var_1E99.var_77AC = 1;
  thread func_1CAA();
}

func_1CA2() {
  level endon("game_ended");
  for(;;) {
    level waittill("player_spawned", var_00);
    var_00 thread func_1CA9();
    if(isDefined(self.var_1E99.var_9815) && self.var_1E99.var_9815 == var_00) {
      thread func_1CA8(1);
    }
  }
}

func_1CA8(param_00) {
  level endon("game_ended");
  var_01 = self.var_1E99.var_9815;
  if(isDefined(var_01) && self.var_1E99.var_A4A8 != "first_person") {
    if(isDefined(var_01.var_981E)) {
      if(!isDefined(var_01.var_981E[self getentitynumber()])) {
        var_01.var_981E[self getentitynumber()] = 0;
      } else if(var_01.var_981E[self getentitynumber()]) {
        return;
      } else if(isDefined(param_00)) {
        wait(0.1);
      }
    } else {
      var_01.var_981E = [];
    }

    if(var_01 method_8445("tag_origin") != -1) {
      playfxontagforclients(common_scripts\utility::func_44F5("broadcaster_followed_player"), var_01, "tag_origin", self);
      var_01.var_981E[self getentitynumber()] = 1;
    }

    thread func_1C9E(var_01);
    self waittill("broadcaster_stop_target_player_puck");
    if(var_01 method_8445("tag_origin") != -1) {
      function_0295(common_scripts\utility::func_44F5("broadcaster_followed_player"), var_01, "tag_origin", self);
      var_01.var_981E[self getentitynumber()] = 0;
    }
  }
}

func_1C9E(param_00) {
  level endon("game_ended");
  self endon("broadcaster_view_player_has_changed");
  self endon("broadcaster_stop_target_player_puck");
  param_00 waittill("death");
  self notify("broadcaster_stop_target_player_puck");
}

func_1CAA() {
  if(self.var_1E99.var_77AC) {
    foreach(var_01 in level.var_744A) {
      if(!var_01 method_8436()) {
        var_01 thread func_1CA9();
      }
    }
  }
}

func_1CA9() {
  level endon("game_ended");
  self endon("death");
  var_00 = self;
  foreach(var_02 in level.broadcasters) {
    if(isDefined(var_02.var_1E99) && isDefined(var_02.var_1E99.var_77AC) && var_02.var_1E99.var_77AC) {
      while(self.var_4B96 == 0) {
        wait 0.05;
      }

      wait(0.5);
      if(var_02.var_1E99.var_A4A8 == "first_person") {
        continue;
      }

      var_03 = "broadcaster_" + var_02 getentitynumber() + "_player_puck";
      var_04 = var_03 + "_allies";
      var_05 = var_03 + "_axis";
      if(var_00.var_01A7 == "allies" && common_scripts\utility::func_3F6F(var_04)) {
        playfxontagforclients(common_scripts\utility::func_44F5(var_04), var_00, "tag_origin", var_02);
      } else if(var_00.var_01A7 == "axis" && common_scripts\utility::func_3F6F(var_05)) {
        playfxontagforclients(common_scripts\utility::func_44F5(var_05), var_00, "tag_origin", var_02);
      }

      thread func_1C9F(var_02);
    }
  }

  thread func_1CA0();
  thread func_1CA1();
}

func_1CA1() {
  self endon("death");
  level waittill("game_ended");
  broadcasterkillteampuck();
}

func_1CA0() {
  level endon("game_ended");
  self waittill("death");
  broadcasterkillteampuck();
}

func_1C9F(param_00) {
  self endon("death");
  level endon("game_ended");
  param_00 waittill("broadcaster_stop_player_pucks");
  func_1CAB(param_00);
}

func_1CAB(param_00) {
  var_01 = "broadcaster_" + param_00 getentitynumber() + "_player_puck";
  var_02 = var_01 + "_allies";
  var_03 = var_01 + "_axis";
  if(self.var_01A7 == "allies" && common_scripts\utility::func_3F6F(var_02)) {
    function_0295(common_scripts\utility::func_44F5(var_02), self, "tag_origin", param_00);
    return;
  }

  if(self.var_01A7 == "axis" && common_scripts\utility::func_3F6F(var_03)) {
    function_0295(common_scripts\utility::func_44F5(var_03), self, "tag_origin", param_00);
  }
}

broadcasterkillteampuck() {
  foreach(var_01 in level.broadcasters) {
    if(isDefined(var_01)) {
      var_02 = "broadcaster_" + var_01 getentitynumber() + "_player_puck";
      var_03 = var_02 + "_allies";
      var_04 = var_02 + "_axis";
      if(self.var_01A7 == "allies" && common_scripts\utility::func_3F6F(var_03)) {
        function_0295(common_scripts\utility::func_44F5(var_03), self, "tag_origin", var_01);
      } else if(self.var_01A7 == "axis" && common_scripts\utility::func_3F6F(var_04)) {
        function_0295(common_scripts\utility::func_44F5(var_04), self, "tag_origin", var_01);
      }
    }
  }
}

func_1C91() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    var_00 = self getnormalizedmovement();
    self.var_1E99.var_5388 = var_00;
    wait 0.05;
  }
}

func_1C9D() {
  level endon("game_ended");
  var_00 = 0.5;
  for(;;) {
    self waittill("luinotifyserver", var_01, var_02);
    var_03 = int(floor(var_02 / 10000));
    var_04 = int(floor(var_02 % 10000 / 100));
    if(var_01 == "broadcaster_view_notify" || var_01 == "broadcaster_camera_input" || var_01 == "broadcaster_client_change" || var_01 == "broadcaster_toggle_ball_cam" || var_01 == "broadcaster_set_color_allies" || var_01 == "broadcaster_set_color_axis") {
      var_05 = level.broadcasters[var_04];
      var_06 = var_02 % 100;
      if(self getentitynumber() != var_04) {
        continue;
      }

      switch (var_01) {
        case "broadcaster_view_notify":
          switch (var_06) {
            case 1:
              thread func_1C93();
              break;

            case 2:
              self notify("broadcaster_view_set_first_person");
              break;

            case 3:
              self notify("broadcaster_view_set_sky_cam");
              break;

            case 4:
              self.var_1E99.var_ACCB = var_03;
              break;

            case 5:
              thread func_1C97();
              break;

            case 6:
              thread func_1CA5();
              break;

            case 7:
              thread func_1CA6();
              break;

            case 8:
              func_1CAC();
              break;
          }
          break;

        case "broadcaster_camera_input":
          self.var_1E99.var_1C92 = var_06 == 1;
          break;

        case "broadcaster_client_change":
          thread func_1CA7(var_06);
          break;

        case "broadcaster_toggle_ball_cam":
          self.var_1E99.broadcasterballcamenabled = var_06 == 1;
          if(!self.var_1E99.broadcasterballcamenabled) {
            thread broadcasterkillballcam();
          } else if(self.var_1E99.var_A4A8 == "first_person") {
            thread broadcasterstartballcam();
          }
          break;

        case "broadcaster_set_color_allies":
          level.broadcastercolorindexallies = var_06;
          break;

        case "broadcaster_set_color_axis":
          level.broadcastercolorindexaxis = var_06;
          break;
      }
    }
  }
}

func_1C9C() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    level waittill("broadcasterLoadoutChanged", var_00);
    var_01 = getomnvar("ui_broadcaster_client_num");
    if(isDefined(var_00) && var_00 == var_01) {
      var_02 = self getplayerbyclientid(var_00);
      func_A0E8(var_02);
    }
  }
}

func_1CA6() {
  self.var_1E99.var_53C0 = 0;
  self.var_1E99.var_53C1 = 0;
  self.var_1E99.var_164B = 0;
}

func_1CAC() {
  self.var_1E99.var_164B = !common_scripts\utility::func_562E(self.var_1E99.var_164B);
}

func_1CA7(param_00) {
  self endon("broadcaster_view_player_has_changed");
  self.var_1E99.var_164B = 0;
  var_01 = maps\mp\gametypes\_playerlogic::func_4622(param_00);
  if(isDefined(self.var_1E99.var_9815) && var_01 == self.var_1E99.var_9815) {
    return;
  }

  if(self.var_1E99.var_A4A8 == "first_person") {
    self.var_009F = param_00;
    self waittill("forced_spectator_client_loaded");
  }

  self.var_1E99.var_9815 = var_01;
  self setclientomnvar("ui_broadcaster_client_num", param_00);
  var_02 = self getplayerbyclientid(param_00);
  func_A0E8(var_02);
  self notify("broadcaster_stop_target_player_puck");
  if(self.var_1E99.var_A4A8 != "first_person") {
    thread func_1CA8();
  }

  thread func_1C96();
  self notify("broadcaster_view_player_has_changed");
}

func_A0E9(param_00, param_01) {
  var_02 = 0;
  var_03 = undefined;
  var_04 = "ui_broadcaster_loadout_";
  if(isDefined(param_00) && param_00 != var_02) {
    var_05 = "mp/statstable.csv";
    var_06 = 18;
    var_07 = maps\mp\_utility::unsignedint_to_hexstring_fixed(param_00);
    var_03 = tablelookuprownum(var_05, var_06, var_07);
  } else {
    var_03 = 0;
  }

  self setclientomnvar(var_04 + param_01, var_03);
}

func_A0E8(param_00) {
  var_01 = 3;
  var_02 = param_00.var_90E4;
  if(isDefined(var_02)) {
    func_A0E9(var_02.var_7709.var_48CA, "primary_weapon");
    func_A0E9(var_02.var_835D.var_48CA, "secondary_weapon");
    for(var_03 = 0; var_03 < 4; var_03++) {
      func_A0E9(var_02.var_76F3[var_03], "primary_attachment_" + var_03);
      if(var_03 < 2) {
        func_A0E9(var_02.var_8353[var_03], "secondary_attachment_" + var_03);
      }
    }

    var_04 = maps\mp\_utility::func_4604();
    var_05 = 0;
    var_06 = var_02.var_6F69[var_01];
    var_07 = undefined;
    if(isDefined(var_06) && var_06 != var_05) {
      var_08 = maps\mp\_utility::func_452B(var_06);
      var_07 = tablelookuprownum(var_04, 1, var_08);
    } else {
      var_07 = var_05;
    }

    self setclientomnvar("ui_broadcaster_loadout_training", var_07);
    self setclientomnvar("ui_broadcaster_loadout_division", var_02.var_0079);
    if(var_02.var_37FE.var_48CA != var_05) {
      func_A0E9(var_02.var_37FE.var_48CA, "equipment_0");
    } else {
      func_A0E9(undefined, "equipment_0");
    }

    if(var_02.var_69AD.var_48CA != var_05) {
      func_A0E9(var_02.var_69AD.var_48CA, "equipment_1");
      return;
    }

    func_A0E9(undefined, "equipment_1");
  }
}

func_1C93() {
  if(self.var_1E99.var_A4A8 == "first_person") {
    return;
  }

  var_00 = self.var_1E99;
  var_01 = var_00.var_9815;
  var_02 = bulletTrace(var_00.var_0116, var_00.var_0116 + anglesToForward(var_00.var_001D) * 5000, 0);
  var_03 = 1000;
  foreach(var_05 in level.var_744A) {
    if(var_05 != var_00.var_9815 && !var_05 method_8436()) {
      var_06 = distance(var_05.var_0116, var_02["position"]);
      if(var_06 < var_03 && isalive(var_05)) {
        var_03 = var_06;
        var_01 = var_05;
      }
    }
  }

  if(var_01 == var_00.var_9815) {
    return;
  }

  func_1CA7(var_01 getentitynumber());
}

func_1CA4() {
  var_00 = self;
  var_01 = getent("mp_global_intermission", "classname");
  var_02 = var_01.var_0116;
  var_03 = var_01.var_001D;
  var_04 = spawn("script_model", var_02);
  var_04.var_001D = var_03;
  var_04 setModel("tag_player");
  var_04.var_92F0 = var_02;
  var_04.var_92B8 = var_03;
  var_04.var_8066 = (0, 0, 0);
  var_04.var_9815 = undefined;
  var_04.var_A4A8 = "third_person";
  var_04.var_ACCB = 0;
  var_04.var_3DC2 = 0;
  var_04.var_77AC = 1;
  var_04.broadcasterballcamenabled = 1;
  var_00 setorigin(var_04.var_0116);
  var_00 setangles(var_04.var_001D);
  var_00 playerlinkto(var_04, "tag_player");
  var_00 method_81E2(var_04, "tag_player");
  var_00 method_812B(0);
  var_00.var_1E99 = var_04;
  var_04.var_721C = var_00;
  var_00 visionsetnakedforplayer("airplane", 5);
}

func_1CA3() {
  level endon("game_ended");
  var_00 = 0.5;
  for(;;) {
    self waittill("broadcaster_view_set_sky_cam");
    func_1C9A(var_00);
    self waittill("broadcaster_view_set_first_person");
    func_1C99(var_00);
  }
}

func_1C9A(param_00) {
  self.var_009F = self getentitynumber();
  maps\mp\gametypes\_spectating::func_872F();
  self.var_1E99.var_A4A8 = "third_person";
  function_0327(&"broadcaster_view_skycam_applied", 1, self getentitynumber());
  level notify("broadcaster_ball_end", self.var_9815);
  self notify("changeGoalFx");
  wait 0.05;
  self method_81E2(self.var_1E99, "tag_player");
  thread func_1CAA();
  thread func_1CA8();
  if(isDefined(level.var_AC7C) && isDefined(level.var_AC7C.broadcastermesh)) {
    level.var_AC7C.broadcastermesh showtoclient(self);
  }

  self.var_1E99 method_8472();
  self.var_1E99 thread func_1C8C(param_00);
  self visionsetnakedforplayer("airplane", param_00);
  wait(param_00);
  if(isDefined(level.bomboutlineactive) && level.bomboutlineactive && isDefined(level.var_8330)) {
    level.var_8330 hudoutlineenableforclient(self, maps\mp\_utility::func_46D4(game["attackers"]), 0);
  }
}

func_1C99(param_00) {
  self.var_1E99 thread func_1C95(param_00);
  if(self.var_1E99.broadcasterballcamenabled) {
    thread broadcasterstartballcam();
  }

  self notify("broadcaster_stop_player_pucks");
  self notify("broadcaster_stop_target_player_puck");
  self notify("broadcaster_stop_zoom");
  function_0327(&"broadcaster_view_fps_applied", 1, self getentitynumber());
  wait(param_00);
  if(isDefined(level.var_AC7C) && isDefined(level.var_AC7C.broadcastermesh)) {
    level.var_AC7C.broadcastermesh hidefromclient(self);
  }

  self allowspectateteam("allies", 1);
  self allowspectateteam("axis", 1);
  self.var_009F = self.var_1E99.var_9815 getentitynumber();
  setDvar("scr_game_lockspectatorpov", 1);
  self forcespectatepov(self getxuid(), "first_person");
  self.var_1E99.var_A4A8 = "first_person";
  if(isDefined(level.bomboutlineactive) && level.bomboutlineactive && isDefined(level.var_8330)) {
    level.var_8330 hudoutlinedisableforclient(self);
  }
}

func_1C8D(param_00, param_01) {
  var_02 = 0.05;
  var_03 = 0;
  var_04 = self.var_9815;
  var_05 = anglesToForward(var_04.var_001D);
  var_06 = self.var_0116 - var_04.var_0116 + var_05 * -100 + param_01;
  var_07 = self.var_001D;
  var_08 = 0;
  for(;;) {
    var_09 = var_04.var_0116 + param_01;
    var_0A = var_03 / param_00;
    var_03 = var_03 + var_02;
    if(var_0A >= 1) {
      break;
    }

    if(!var_08) {
      var_0B = 1.25;
      var_0C = min(var_0A * var_0B, 1);
      var_0C = 0.5 * 1 - cos(var_0C * 180);
      var_0D = var_09 - self.var_0116;
      var_0E = axistoangles(var_0D, vectorcross(var_0D, (0, 0, 1)), (0, 0, 1));
      self.var_001D = angleslerp(var_07, var_0E, var_0C);
      if(var_0C >= 1) {
        self settargetingflag(var_04, "fixedoffset", param_01);
        var_08 = 1;
      }
    }

    var_0A = 0.5 * 1 - cos(var_0A * 180);
    var_05 = anglesToForward(var_04.var_001D);
    self.var_0116 = var_09 + var_05 * -100 + var_06 * 1 - var_0A;
    wait 0.05;
  }
}

func_1C95(param_00) {
  self notify("end_follows");
  self.var_9815 endon("disconnect");
  self.var_721C endon("disconnect");
  level endon("game_ended");
  self endon("end_follows");
  var_01 = self.var_9815;
  var_02 = (0, 0, 100);
  var_03 = var_01;
  func_1C8D(param_00, var_02);
  for(;;) {
    var_01 = self.var_9815;
    if(var_01 != var_03) {
      self settargetingflag(var_01, "fixedoffset", var_02);
    }

    var_04 = anglesToForward(var_01.var_001D);
    var_05 = var_01.var_0116 + var_04 * -100 + var_02;
    self.var_0116 = var_05;
    var_03 = var_01;
    wait 0.05;
  }
}

func_1C8F(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.var_9815)) {
    return;
  }

  var_04 = 0.05;
  var_05 = 0;
  var_06 = self.var_0116 - self.var_9815.var_0116;
  var_07 = self.var_9815.var_001D;
  for(;;) {
    var_08 = self.var_9815.var_0116;
    var_09 = var_05 / param_00;
    var_05 = var_05 + var_04;
    if(var_09 >= 1) {
      break;
    }

    var_0A = 3;
    var_0B = min(var_09 * var_0A, 1);
    var_0B = 0.5 * 1 - cos(var_0B * 180);
    self.var_001D = angleslerp(var_07, param_03, var_0B);
    var_09 = 0.5 * 1 - cos(var_09 * 180);
    var_0C = (var_08[0], var_08[1] + param_02 * var_09, var_08[2] + param_01 * var_09);
    var_0C = var_0C + var_06 * 1 - var_09;
    self.var_0116 = var_0C;
    wait 0.05;
  }
}

func_1C8E(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.var_9815)) {
    return;
  }

  var_04 = 0.05;
  var_05 = 0;
  var_06 = self.var_9815;
  for(;;) {
    var_07 = var_05 / param_00;
    var_05 = var_05 + var_04;
    if(var_07 >= 1) {
      self.var_53C0 = 0;
      self.var_53C1 = 0;
      break;
    }

    var_08 = var_06.var_0116;
    var_09 = (var_08[0], var_08[1] + param_02, var_08[2] + param_01);
    var_0A = param_03.var_0116;
    var_0B = (var_0A[0] + self.var_53C0, var_0A[1] + self.var_53C1 + param_02, var_0A[2] + param_01);
    var_07 = sin(var_07 * 90);
    self.var_0116 = vectorlerp(var_0B, var_09, var_07);
    wait 0.05;
  }
}

func_1C8C(param_00) {
  self notify("end_follows");
  self.var_721C endon("disconnect");
  level endon("game_ended");
  self endon("end_follows");
  var_01 = self.var_9815;
  if(!isDefined(self.var_9815)) {
    return;
  }

  self.var_9815 endon("disconnect");
  var_02 = undefined;
  self.var_53C0 = 0;
  self.var_53C1 = 0;
  self.var_164B = 0;
  var_03 = (70, 270, 0);
  self.var_1C92 = 1;
  if(!isDefined(level.var_5FF0)) {
    level.var_5FF0 = 1024;
  }

  for(;;) {
    var_01 = self.var_9815;
    var_04 = 2000 + self.var_ACCB * 250;
    var_05 = var_04 / 2;
    if(!isDefined(var_02)) {
      func_1C8F(param_00, var_04, var_05, var_03);
    } else if(var_02 != var_01) {
      func_1C8E(param_00, var_04, var_05, var_02);
    }

    if(self.var_1C92) {
      var_06 = self.var_5388[1];
      var_07 = self.var_5388[0];
    } else {
      var_06 = 0;
      var_07 = 0;
    }

    var_08 = self.var_53C0 - 150 * var_06;
    var_09 = self.var_53C1 - 150 * var_07;
    if(self.var_164B && isDefined(self.var_7436)) {
      var_0A = level.var_5FF0;
      var_0B = level.var_5FEB;
      var_08 = clamp(var_08 + self.var_7436[0] - var_0B[0], var_0A * -1, var_0A) - self.var_7436[0] + var_0B[0];
      var_09 = clamp(var_09 + self.var_7436[1] - var_0B[1], var_0A * -1, var_0A) - self.var_7436[1] + var_0B[1];
    } else {
      self.var_7436 = var_01.var_0116;
      var_08 = clamp(var_08, -1000, 1000);
      var_09 = clamp(var_09, -1000, 1000);
    }

    self.var_53C0 = var_08;
    self.var_53C1 = var_09;
    self.var_0116 = (self.var_7436[0] + var_08, self.var_7436[1] + var_09 + var_05, max(self.var_7436[2] + var_04, var_01.var_9092[2] + var_05));
    self.var_001D = var_03;
    wait 0.05;
    var_02 = var_01;
  }
}

func_1C96() {
  if(self.var_1E99.var_3DC2 == 0) {
    return;
  }

  level endon("game_ended");
  self endon("broadcaster_view_player_has_changed");
  self endon("broadcaster_follow_killer_stop");
  var_00 = self.var_1E99.var_9815;
  var_00 waittill("death");
  thread func_1CA7(var_00.var_00E6 getentitynumber());
}

func_1C97() {
  if(self.var_1E99.var_3DC2) {
    self.var_1E99.var_3DC2 = 0;
    self notify("broadcaster_follow_killer_stop");
    return;
  }

  self.var_1E99.var_3DC2 = 1;
  thread func_1C96();
}

broadcastermoveballcam(param_00, param_01) {
  var_02 = (0, 0, 30);
  var_02 = var_02 + -80 * param_01;
  return param_00 + var_02;
}

broadcasterkillballcam() {
  self notify("broadcaster_kill_ballcam");
  function_0226(&"broadcaster_stop_ballcam", 1, self getentitynumber());
  if(self.var_1E99.var_A4A8 == "first_person") {
    self.var_1E99.watchedball = undefined;
    self allowspectateteam("allies", 1);
    self allowspectateteam("axis", 1);
    self.var_009F = self.var_1E99.var_9815 getentitynumber();
    setDvar("scr_game_lockspectatorpov", 1);
    self forcespectatepov(self getxuid(), "first_person");
    self.var_1E99 func_1C95(0.5);
  }
}

broadcasterstartballcam() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("broadcaster_kill_ballcam");
  for(;;) {
    level waittill("broadcaster_throw_ball", var_00, var_01, var_02);
    if(!self.var_1E99.broadcasterballcamenabled || self.var_1E99.var_A4A8 == "third_person" || self.var_1E99.var_9815 != var_00) {
      continue;
    }

    self.var_1E99 notify("end_follows");
    self notify("changeGoalFx");
    self.var_1E99.watchedball = var_01.var_A582[0];
    self.var_009F = self getentitynumber();
    wait 0.05;
    self method_81E2(self.var_1E99, "tag_player", 1);
    self.var_1E99 method_8472();
    var_03 = broadcastermoveballcam(self.var_1E99.watchedball.var_0116, var_02);
    self.var_1E99 moveto(var_03, 10.5, 5.25, 5.25);
    self.var_1E99.var_001D = vectortoangles(var_02);
    self.var_1E99 thread updateballcam();
    thread broadcasterstopballcam();
  }
}

broadcasterstopballcam() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("broadcaster_view_set_sky_cam");
  self endon("broadcaster_kill_ballcam");
  self.var_1E99.watchedball endon("drop_object");
  self.var_1E99.watchedball endon("death");
  for(;;) {
    level waittill("broadcaster_ball_end", var_00, var_01);
    if(isDefined(self.var_1E99.watchedball) && self.var_1E99.watchedball != var_00) {
      continue;
    }

    self.var_1E99.watchedball = undefined;
    if(var_01) {
      function_0226(&"broadcaster_stop_ballcam", 1, self getentitynumber());
    }

    self allowspectateteam("allies", 1);
    self allowspectateteam("axis", 1);
    self.var_009F = self.var_1E99.var_9815 getentitynumber();
    setDvar("scr_game_lockspectatorpov", 1);
    self forcespectatepov(self getxuid(), "first_person");
    self.var_1E99 func_1C95(0.5);
    break;
  }
}

updateballcam() {
  self.var_721C endon("disconnect");
  self.var_721C endon("game_ended");
  self.var_721C endon("broadcaster_view_set_sky_cam");
  self.var_721C endon("broadcaster_kill_ballcam");
  self.var_721C endon("broadcaster_view_player_has_changed");
  level endon("broadcaster_ball_end");
  for(;;) {
    if(!isDefined(self.watchedball)) {
      break;
    }

    var_00 = self.watchedball.var_0116;
    var_01 = self.var_0116;
    var_02 = distance2d(var_00, var_01);
    var_03 = var_00 - var_01;
    var_04 = (var_03[0], var_03[1], 0);
    var_04 = vectornormalize(var_04);
    var_05 = broadcastermoveballcam(var_00, var_04);
    if(var_02 > 600) {
      self.var_0116 = var_05;
    } else {
      self moveto(var_05, 0.5, 0, 0.2);
    }

    self.var_001D = vectortoangles(var_03);
    wait 0.05;
  }
}

func_1C9B() {
  var_00 = getEntArray();
  var_01 = 0;
  setomnvar("lighting_state", var_01);
  if(!getdvarint("233")) {
    foreach(var_03 in var_00) {
      if(isDefined(var_03.var_5D56) && isDefined(var_03.var_003A) && var_03.var_003A == "script_brushmodel" || var_03.var_003A == "script_model") {
        if(var_03.var_5D56 == 0) {
          continue;
        }

        if(var_03.var_5D56 == var_01) {
          var_03 common_scripts\utility::func_8BE0();
          var_03 allowriotshieldplant();
          continue;
        }

        var_03 notify("hidingLightingState");
        var_03 hidefromclient(self);
      }
    }
  }
}

resetforplayofthegamecam() {}