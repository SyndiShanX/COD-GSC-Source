/**************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\introscreen.gsc
**************************************/

func_9631() {
  scripts\engine\utility::flag_init("introscreen_complete");
}

main() {
  precacheshader("black");
  precacheshader("chyron_border_left");
  precacheshader("chyron_border_right");
  thread func_B23E();
}

func_B23E() {
  scripts\engine\utility::flag_wait("start_is_set");
  var_00 = 0;
  if(!isDefined(level.var_9AF3) || !scripts\sp\utility::func_9BB5() || var_00) {
    scripts\engine\utility::delaythread(0.05, ::scripts\engine\utility::flag_set, "introscreen_complete");
    return;
  }

  if(isDefined(level.var_9AF3.var_4C88)) {
    [[level.var_9AF3.var_4C88]]();
    return;
  }

  func_9AF3();
}

func_9AF7() {
  if(!isDefined(level.var_9AF3)) {
    return 0;
  }

  var_00 = level.var_9AF3.var_ACF2;
  var_01 = getarraykeys(var_00);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    var_03 = var_01[var_02];
    var_04 = 1;
    var_05 = var_02 * var_04 + 1;
    scripts\engine\utility::delaythread(var_05, ::introscreen_corner_line, var_00[var_03], var_00.size - var_02 - 1, var_04, var_03);
  }

  return 1;
}

func_9AF8(param_00, param_01, param_02) {
  func_9AF9("black", param_00, param_01, param_02);
}

func_9AF9(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_02)) {
    param_02 = 1.5;
  }

  if(!isDefined(param_03)) {
    scripts\sp\hud_util::func_10CCC();
  } else {
    scripts\sp\hud_util::func_6AA3(param_03);
  }

  wait(param_01);
  scripts\sp\hud_util::func_6A99(param_02);
  wait(param_02);
  setsaveddvar("com_cinematicEndInWhite", 0);
}

introscreen_corner_line(param_00, param_01, param_02, param_03) {
  level notify("new_introscreen_element");
  if(!isDefined(level.intro_offset)) {
    level.intro_offset = 0;
  } else {
    level.intro_offset++;
  }

  var_04 = cornerline_height();
  var_05 = newhudelem();
  var_05.x = 20;
  var_05.y = var_04;
  var_05.alignx = "left";
  var_05.aligny = "bottom";
  var_05.horzalign = "left";
  var_05.vertalign = "bottom";
  var_05.sort = 1;
  var_05.foreground = 1;
  var_05 settext(param_00);
  var_05.alpha = 0;
  var_05 fadeovertime(0.2);
  var_05.alpha = 1;
  var_05.hidewheninmenu = 1;
  var_05.fontscale = 2;
  var_05.color = (0.8, 1, 0.8);
  var_05.font = "default";
  var_05.objective_delete = (0.3, 0.6, 0.3);
  var_05.objective_current_nomessage = 1;
  var_06 = int(param_01 * param_02 * 1000 + 4000);
  var_05 setpulsefx(30, var_06, 700);
  thread hudelem_destroy(var_05);
}

cornerline_height() {
  return level.intro_offset * 20 - 82;
}

hudelem_destroy(param_00) {
  wait(16);
  param_00 notify("destroying");
  level.var_9AC9 = undefined;
  var_01 = 0.5;
  param_00 fadeovertime(var_01);
  param_00.alpha = 0;
  wait(var_01);
  param_00 notify("destroy");
  param_00 destroy();
}

func_C3C4() {
  level.player freezecontrols(1);
  thread func_9AF8(level.var_9AF3.var_4480, level.var_9AF3.var_6AAA, level.var_9AF3.var_6A9F);
  if(!func_9AF7()) {
    wait(0.05);
  }

  wait(level.var_9AF3.var_4480);
  scripts\engine\utility::flag_set("introscreen_complete");
  level.player freezecontrols(0);
}

func_9AF3(param_00, param_01) {
  if(!isDefined(param_00)) {
    param_00 = 0;
    var_02 = 1;
  }

  if(isDefined(param_01)) {
    param_00 = 1;
    scripts\sp\hud_util::func_10CCC();
    level.player freezecontrols(1);
    level.player scripts\engine\utility::delaycall(param_01, ::freezecontrols, 0);
    scripts\engine\utility::delaythread(param_01, ::scripts\sp\hud_util::func_6A99, 2);
  }

  level.var_3F69 = spawnStruct();
  level.var_3F69.var_91AF = [];
  level.var_3F69.var_11151 = [];
  level.var_3F69.var_A917 = [];
  level.var_3F69.var_22FD = [];
  level.var_3F69.var_11761 = 20;
  level.var_3F69.var_11762 = -82;
  level.var_3F69.var_1175D = 0;
  level.var_3F69.var_11152 = 0;
  level.var_3F69.var_10466 = spawn("script_origin", level.player.origin);
  level.var_3F69.var_10466 linkto(level.player);
  level.var_3F69.var_BFE0 = param_00;
  if(!param_00) {
    level.player freezecontrols(1);
    scripts\sp\hud_util::func_10CCC();
    thread func_22FD(0);
  }

  func_3F6A(0, "ui_chyron_on");
  thread func_11151(0);
  var_03 = 0.4;
  thread func_DB9A(0, var_03);
  wait(var_03);
  func_119A5(level.var_9AF3.var_ACF2[0]);
  func_3F6A(0, "ui_chyron_firstline");
  func_111A1(level.var_9AF3.var_ACF2[1], 0);
  wait(2);
  var_04 = func_111A1(level.var_9AF3.var_ACF2[2], 1, "default", 1, 1);
  var_04.color = (0.68, 0.744, 0.736);
  var_05 = undefined;
  if(isDefined(level.var_9AF3.var_ACF2[3])) {
    var_05 = func_111A1(level.var_9AF3.var_ACF2[3], 2, "default", 1, 1);
    var_05.color = (0.68, 0.744, 0.736);
    level.var_3F69.var_91AF = scripts\engine\utility::array_remove(level.var_3F69.var_91AF, var_05);
  }

  wait(1);
  level.var_3F69.var_11152 = 1;
  wait(2);
  level.var_3F69.var_11152 = 0;
  if(isDefined(var_05)) {
    var_05 thread func_BE48();
  }

  wait(1);
  func_6BAF(0, param_00);
  if(!param_00) {
    func_3F6A(0, "ui_chyron_off");
    thread scripts\sp\hud_util::func_6A99(2);
    level.player freezecontrols(0);
  }

  scripts\engine\utility::flag_set("introscreen_complete");
  level notify("stop_chyron");
  level.var_3F69.var_10466 delete();
  level.var_3F69 = undefined;
}

func_BE48() {
  var_00 = self.color;
  var_01 = self.alpha;
  self notify("stop_quick_pulse");
  var_02 = 2;
  self.objective_current_nomessage = 1;
  self.objective_delete = (1, 1, 1);
  thread func_6A98((0.10625, 0.11625, 0.115), 0.1, var_02);
  self.color = (1, 1, 1);
  self.alpha = 1;
  self fadeovertime(var_02);
  self.color = var_00;
  self.alpha = 0.8;
  var_02 = 4;
  self moveovertime(var_02 * 3);
  self changefontscaleovertime(var_02 * 1.5);
  self.x = self.x + randomintrange(5, 10);
  self.y = self.y - randomintrange(3, 12);
  self.fontscale = self.fontscale * randomfloatrange(1.2, 1.3);
  wait(var_02);
  self fadeovertime(2);
  self.alpha = 0;
  wait(2);
  self destroy();
}

func_6A98(param_00, param_01, param_02) {
  self endon("death");
  var_03 = param_02 * 20;
  var_04 = param_00 - self.objective_delete / var_03;
  var_05 = param_01 - self.objective_current_nomessage / var_03;
  for(var_06 = 0; var_06 < var_03; var_06++) {
    self.objective_delete = self.objective_delete + var_04;
    self.objective_current_nomessage = self.objective_current_nomessage + var_05;
    wait(0.05);
  }

  self.objective_delete = param_00;
  self.objective_current_nomessage = param_01;
}

func_3F6A(param_00, param_01) {
  if(param_00 == 0) {
    level.var_3F69.var_10466 playSound(param_01);
    return;
  }

  level.var_7661.var_10466 playSound(param_01);
}

func_913E(param_00) {
  self endon("death");
  self fadeovertime(param_00);
  self.alpha = 0;
  wait(param_00);
  self destroy();
}

func_DB9A(param_00, param_01) {
  wait(0.5);
  var_02 = newhudelem();
  if(param_00 == 0) {
    var_02.x = level.var_3F69.var_11761 - 5;
    var_02.y = level.var_3F69.var_11762;
    var_02.vertalign = "bottom";
  } else {
    var_02.x = level.var_7661.var_11761 - 5;
    var_02.y = level.var_7661.var_11762;
    var_02.vertalign = "top";
  }

  var_02.fontscale = 3;
  var_02.horzalign = "left";
  var_02.sort = 1;
  var_02.foreground = 1;
  var_02.hidewheninmenu = 1;
  var_02.alpha = 0.8;
  var_02 setshader("white", 1, 35);
  var_02.color = (0.85, 0.93, 0.92);
  var_02 moveovertime(param_01);
  var_02 fadeovertime(param_01 * 0.5);
  var_02.alpha = 0;
  var_02.x = var_02.x + 300;
  wait(0.4);
  var_02 destroy();
}

func_22FD(param_00) {
  if(param_00 == 0) {
    level endon("chyron_faze_out_text_intro");
  } else {
    level endon("chyron_faze_out_text_gamenotify");
  }

  var_01 = [".", "-", "_", "|", "+"];
  var_02 = 0.7;
  for(var_03 = 0; var_03 < var_01.size; var_03++) {
    var_04 = func_48B3("");
    var_04.fontscale = var_02;
    var_04.alpha = 0;
    var_04.sort = 2;
    var_04.color = (0.75, 0.83, 0.89);
    var_04.var_DAE6 = 0;
    level.var_3F69.var_22FD[level.var_3F69.var_22FD.size] = var_04;
  }

  level.var_3F69.var_22FE = 0;
  thread func_22FC(param_00);
  var_05 = 0;
  var_06 = level.var_3F69.var_11762 - 10;
  for(;;) {
    var_07 = 0;
    var_01 = scripts\engine\utility::array_randomize(var_01);
    foreach(var_04 in level.var_3F69.var_22FD) {
      func_3F6A(param_00, "ui_chyron_plusminus");
      var_04.fontscale = var_02;
      if(var_01[var_07] == "+") {
        var_04.fontscale = 0.55;
      }

      var_04 settext(var_01[var_07]);
      var_04.x = var_05 + randomint(200);
      var_04.y = var_06 + randomint(60);
      var_04.var_DAE6 = 1;
      var_07++;
      wait(randomfloatrange(0.05, 0.1));
    }

    wait(randomfloatrange(4, 7));
    level.var_3F69.var_22FE = 1;
    level waittill("chyron_artifact_faded");
  }
}

func_22FC(param_00) {
  if(param_00 == 0) {
    level endon("chyron_faze_out_text_intro");
  } else {
    level endon("chyron_faze_out_text_gamenotify");
  }

  var_01 = 0.6;
  var_02 = 1;
  for(;;) {
    if(level.var_3F69.var_22FE) {
      var_01 = var_01 - 0.07;
    } else {
      if(var_01 < 0.15 || var_01 > 0.6) {
        var_02 = var_02 * -1;
      }

      var_01 = var_01 + 0.02 + randomfloat(0.04) * var_02;
    }

    var_01 = max(var_01, 0);
    foreach(var_04 in level.var_3F69.var_22FD) {
      if(var_04.var_DAE6) {
        if(var_01 == 0) {
          var_04.alpha = 0;
          continue;
        }

        var_04.alpha = randomfloatrange(var_01 * 0.6, var_01);
      }
    }

    if(var_01 == 0) {
      level notify("chyron_artifact_faded");
      var_01 = 0.8;
      level.var_3F69.var_22FE = 0;
      foreach(var_04 in level.var_3F69.var_22FD) {
        var_04.var_DAE6 = 0;
      }
    }

    wait(0.05);
  }
}

func_11151(param_00) {
  if(param_00 == 0) {
    level endon("chyron_faze_out_text_intro");
  } else {
    level endon("chyron_faze_out_text_gamenotify");
  }

  var_01 = 5;
  var_02 = 0;
  var_03 = 1;
  for(;;) {
    if((param_00 == 0 && level.var_3F69.var_11152) || param_00 == 1 && level.var_7661.var_11152) {
      wait(0.05);
      continue;
    }

    var_02++;
    var_04 = int(min(var_02, var_01));
    for(var_05 = 0; var_05 < var_04; var_05++) {
      thread func_495C(param_00);
      wait(randomfloatrange(0, 0.1));
    }

    if((param_00 == 0 && level.var_3F69.var_1175D) || param_00 == 1 && level.var_7661.var_1175D) {
      wait(0.05);
      continue;
    }

    wait(randomfloatrange(var_03 * 0.5, var_03));
    var_03 = var_03 - 0.05;
    var_03 = max(var_03, 0.2);
  }
}

func_119A5(param_00, param_01) {
  var_02 = func_48B3(param_00);
  level.var_3F69.var_1175E = var_02.x;
  level.var_3F69.var_1175F = var_02.y;
  level.var_3F69.var_1175D = 1;
  wait(0.5);
  level.var_3F69.var_1175D = 0;
  var_03 = func_5F31(var_02, 1);
  var_04 = 4;
  var_03[0] thread location_dupes_thread(var_04);
  var_02.y = var_02.y - 10;
  var_02.objective_current_nomessage = 0.05;
  var_02.objective_delete = (0.425, 0.465, 0.46) * vehicle_setspeed();
  var_05 = 0.3;
  var_02 moveovertime(var_05);
  var_02 fadeovertime(var_05 * 3);
  var_02.y = var_02.y + 10;
  var_06 = 0.5;
  var_06 = var_06 - var_05;
  wait(var_05);
  var_02 thread func_DB9D(0);
  wait(var_06);
  if(randomint(100) > 10) {
    var_02 thread func_C369(-30, 30, 20, -8, 8, 4);
  }
}

func_C369(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = randomintrange(1, 2);
  for(var_07 = 0; var_07 < var_06; var_07++) {
    var_08 = func_DCB1(param_00, param_01, param_02);
    var_09 = func_DCB1(param_03, param_04, param_05);
    var_0A[0] = [var_08, var_09];
    var_0A[1] = [var_08 - 10, var_09];
    thread func_915B(var_0A);
    wait(randomfloatrange(0.5, 1));
  }
}

func_6BAF(param_00, param_01) {
  var_02 = undefined;
  if(!param_01) {
    var_02 = newhudelem();
    if(param_00 == 0) {
      var_02.x = level.var_3F69.var_11761 + 60;
      var_02.y = level.var_3F69.var_11762 + 30;
      var_02.vertalign = "bottom";
    } else {
      var_02.x = level.var_7661.var_11761 + 60;
      var_02.y = level.var_7661.var_11762 + 10;
      var_02.vertalign = "top";
    }

    var_02.alignx = "center";
    var_02.aligny = "middle";
    var_02.horzalign = "left";
    var_02.sort = 1;
    var_02.foreground = 1;
    var_02.hidewheninmenu = 1;
    var_02.alpha = 0;
    var_02 setshader("white", 1, 60);
    var_02.color = (0.85, 0.93, 0.92);
    var_02 fadeovertime(0.25);
    var_02.alpha = 0.1;
    var_02 scaleovertime(0.1, 2000, 60);
    wait(0.1);
  }

  var_03 = 0.15;
  func_6AA9(param_00, var_03 * 0.4);
  if(!param_01) {
    var_02 fadeovertime(0.25);
    var_02.alpha = 0.2;
    var_02.color = (1, 1, 1);
    var_02 scaleovertime(var_03, 2000, 2);
    wait(var_03);
    var_03 = 0.15;
    var_02 scaleovertime(var_03, 2, 2);
    var_02 thread func_6BB0(var_03);
  }
}

func_6BB0(param_00) {
  self fadeovertime(param_00);
  self.alpha = 0;
  wait(param_00);
  self destroy();
}

func_6AA9(param_00, param_01) {
  if(param_00 == 0) {
    level notify("chyron_faze_out_text_intro");
    foreach(var_03 in level.var_3F69.var_91AF) {
      if(!isDefined(var_03)) {
        continue;
      }

      var_03 thread func_913E(param_01);
    }

    foreach(var_03 in level.var_3F69.var_11151) {
      var_03 thread func_913E(param_01);
    }

    return;
  }

  level notify("chyron_faze_out_text_gamenotify");
  foreach(var_03 in level.var_7661.var_91AF) {
    if(!isDefined(var_03)) {
      continue;
    }

    var_03 thread func_913E(param_01);
  }

  foreach(var_03 in level.var_7661.var_11151) {
    var_03 thread func_913E(param_01);
  }
}

func_111A1(param_00, param_01, param_02, param_03, param_04) {
  var_05 = func_48B3(param_00);
  var_05.y = var_05.y + 20 + param_01 * 15;
  if(isDefined(param_02)) {
    var_05.font = param_02;
  }

  var_05.fontscale = 1;
  if(isDefined(param_03)) {
    var_05.fontscale = param_03;
  }

  level.var_3F69.var_1175E = var_05.x;
  level.var_3F69.var_1175F = var_05.y;
  level.var_3F69.var_1175D = 1;
  wait(0.5);
  var_05.objective_current_nomessage = 0.05;
  var_05.objective_delete = (0.425, 0.465, 0.46) * vehicle_setspeed();
  var_05 thread func_DB9D(0, param_04);
  var_05.alpha = 1;
  if(isDefined(param_04)) {
    var_05.alpha = param_04;
  }

  var_05 setpulsefx(30, -15536, 700);
  if(randomint(100) > 70) {
    var_05 scripts\engine\utility::delaythread(2, ::func_C369, -7, 7, 3, -5, 5, 3);
  }

  level.var_3F69.var_1175D = 0;
  return var_05;
}

vehicle_setspeed() {
  var_00 = 1;
  if(isDefined(level.var_3F69) && level.var_3F69.var_BFE0) {
    var_00 = 0.3;
  }

  return var_00;
}

func_915B(param_00) {
  var_01 = self.x;
  var_02 = self.y;
  foreach(var_04 in param_00) {
    self.x = var_01 + var_04[0];
    self.y = var_02 + var_04[1];
    wait(randomfloatrange(0.05, 0.2));
  }

  self.x = var_01;
  self.y = var_02;
}

func_DB9D(param_00, param_01) {
  self endon("death");
  self endon("stop_quick_pulse");
  if(param_00 == 0) {
    level endon("chyron_faze_out_text_intro");
  } else {
    level endon("chyron_faze_out_text_gamenotify");
  }

  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  for(;;) {
    wait(0.05);
    self.alpha = randomfloatrange(param_01 * 0.7, param_01);
  }
}

location_dupes_thread(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  self endon("death");
  var_02 = self.x;
  var_03 = self.y;
  var_04 = 0.15;
  if(!param_01) {
    self.x = self.x + randomintrange(-30, -10);
    self.y = self.y + randomintrange(10, 20);
    self moveovertime(var_04);
    self.x = var_02;
    self.y = var_03;
    self fadeovertime(var_04);
    self.alpha = 0.1;
    wait(var_04);
  }

  self moveovertime(param_00);
  self.x = self.x + randomintrange(15, 20);
  self.y = self.y + randomintrange(-4, 4);
  wait(param_00);
  var_04 = 0.05;
  self moveovertime(var_04);
  self.x = var_02;
  self.y = var_03;
  wait(var_04);
  self fadeovertime(var_04);
  self.alpha = 0;
}

func_DCB1(param_00, param_01, param_02) {
  var_03 = randomintrange(param_00, param_01);
  var_04 = 1;
  if(var_03 < 0) {
    var_04 = -1;
  }

  var_03 = max(abs(var_03), param_02);
  return var_03 * var_04;
}

func_48B3(param_00, param_01, param_02) {
  if(!isDefined(param_01)) {
    param_01 = level.var_3F69.var_11761;
  }

  if(!isDefined(param_02)) {
    param_02 = level.var_3F69.var_11762;
  }

  var_03 = newhudelem();
  var_03.x = param_01;
  var_03.y = param_02;
  var_03.horzalign = "left";
  var_03.vertalign = "bottom";
  var_03.aligny = "bottom";
  var_03.sort = 3;
  var_03.foreground = 1;
  var_03 settext(param_00);
  var_03.text = param_00;
  var_03.alpha = 0;
  var_03.hidewheninmenu = 1;
  var_03.fontscale = 1.4;
  if(level.console) {
    var_03.fontscale = 1.2;
  }

  var_03.color = (0.85, 0.93, 0.92);
  var_03.font = "default";
  if(isDefined(level.var_3F69)) {
    level.var_3F69.var_91AF[level.var_3F69.var_91AF.size] = var_03;
  }

  return var_03;
}

func_7CBA(param_00) {
  var_01 = spawnStruct();
  var_02 = 0;
  var_03 = 0;
  var_04 = 0;
  if(param_00 == 0) {
    var_05 = -85;
    var_02 = level.var_3F69.var_1175D;
    var_03 = level.var_3F69.var_1175E;
    var_04 = level.var_3F69.var_1175F;
  } else {
    var_05 = 0;
    var_02 = level.var_7661.var_1175D;
    var_03 = level.var_7661.var_1175E;
    var_04 = level.var_7661.var_1175F;
  }

  var_06 = 200;
  var_07 = 60;
  var_01.width = randomintrange(20, var_06);
  var_08 = [5, 10, 15];
  var_01.height = var_08[randomint(var_08.size)];
  var_01.x = randomintrange(0, var_06 - var_01.width);
  var_01.y = var_05 + randomint(var_07 - var_01.height);
  var_01.alpha = randomfloatrange(0.3, 0.7);
  var_01.color = func_7CB9();
  var_01.time = randomfloatrange(0.05, 0.1);
  if(var_02) {
    var_01.x = int(var_03 + randomintrange(-1, 1));
    var_01.y = int(var_04 + randomintrange(0, 7));
    var_01.width = randomintrange(100, var_06);
    var_01.height = randomintrange(10, 15);
    var_01.color = (0.85, 0.93, 0.92) * randomfloatrange(0.2, 0.4);
  }

  return var_01;
}

func_7CB9() {
  var_00 = [];
  var_00[var_00.size] = (0.15, 0.14, 0.22);
  var_00[var_00.size] = (0.09, 0.11, 0.13);
  var_00[var_00.size] = (0.34, 0.22, 0.22);
  var_00[var_00.size] = (0.29, 0.34, 0.22);
  return var_00[randomint(var_00.size)];
}

func_495C(param_00) {
  if(param_00 == 0) {
    level endon("chyron_faze_out_text_intro");
    if(level.var_3F69.var_11151.size < 8) {
      var_01 = newhudelem();
      var_01.var_13438 = 0;
      level.var_3F69.var_11151[level.var_3F69.var_11151.size] = var_01;
    }

    var_02 = undefined;
    foreach(var_04 in level.var_3F69.var_11151) {
      if(var_04.var_13438) {
        continue;
      }

      var_02 = var_04;
    }

    if(!isDefined(var_02)) {
      return;
    }

    var_06 = func_7CBA(param_00);
    if(!level.var_3F69.var_1175D) {
      if(level.var_3F69.var_A917.size > 0 && level.var_3F69.var_A917.size < 3 && randomint(100) > 10) {
        var_07 = level.var_3F69.var_A917[level.var_3F69.var_A917.size - 1];
        var_06.x = var_07.x;
        var_06.y = var_07.y + var_07.height;
        if(scripts\engine\utility::cointoss()) {
          var_06.y = var_07.y - var_06.height;
        }
      } else {
        level.var_3F69.var_A917 = [];
      }

      level.var_3F69.var_A917[level.var_3F69.var_A917.size] = var_02;
    }
  } else {
    level endon("chyron_faze_out_text_gamenotify");
    if(level.var_7661.var_11151.size < 8) {
      var_01 = newhudelem();
      var_01.var_13438 = 0;
      level.var_7661.var_11151[level.var_7661.var_11151.size] = var_01;
    }

    var_02 = undefined;
    foreach(var_04 in level.var_7661.var_11151) {
      if(var_04.var_13438) {
        continue;
      }

      var_02 = var_04;
    }

    if(!isDefined(var_02)) {
      return;
    }

    var_06 = func_7CBA(param_00);
    if(!level.var_7661.var_1175D) {
      if(level.var_7661.var_A917.size > 0 && level.var_7661.var_A917.size < 3 && randomint(100) > 10) {
        var_07 = level.var_7661.var_A917[level.var_7661.var_A917.size - 1];
        var_06.x = var_07.x;
        var_06.y = var_07.y + var_07.height;
        if(scripts\engine\utility::cointoss()) {
          var_06.y = var_07.y - var_06.height;
        }
      } else {
        level.var_7661.var_A917 = [];
      }

      level.var_7661.var_A917[level.var_7661.var_A917.size] = var_02;
    }
  }

  var_02.x = var_06.x;
  var_02.y = var_06.y;
  var_02.width = var_06.width;
  var_02.height = var_06.height;
  var_02 setshader("white", var_06.width, var_06.height);
  var_02.alpha = var_06.alpha;
  var_02.color = var_06.color;
  if(var_02.alpha > 0.6) {
    func_3F6A(param_00, "ui_chyron_line_static");
  }

  var_02.horzalign = "left";
  var_02.vertalign = "bottom";
  if(param_00 == 1) {
    var_02.vertalign = "top";
  }

  var_02.sort = 1;
  var_02.foreground = 1;
  var_02.hidewheninmenu = 1;
  var_02.var_13438 = 1;
  wait(var_06.time);
  var_02.alpha = 0;
  var_02.var_13438 = 0;
}

func_5F31(param_00, param_01) {
  var_02 = [];
  for(var_03 = 0; var_03 < param_01; var_03++) {
    var_02[var_02.size] = func_48B3(param_00.text);
  }

  return var_02;
}

func_7661() {
  level.var_7661 = spawnStruct();
  level.var_7661.var_19 = 0;
  level.var_7661.var_11760 = [];
  level thread func_7660("chyron_message1");
  level thread func_7660("chyron_message2");
  level thread func_7660("chyron_message3");
}

func_7660(param_00) {
  for(;;) {
    assertdemo(9010);
    assertdemo(param_00);
    level waittill(param_00, var_01, var_02);
    assertdemo(9009);
    func_765E(var_01);
  }
}

func_765E(param_00) {
  level.var_7661.var_11760[level.var_7661.var_11760.size] = param_00;
  if(!level.var_7661.var_19) {
    level thread func_7662();
  }
}

func_7664() {
  level.var_7661.var_19 = 1;
  level.var_7661.var_1175D = 0;
  level.var_7661.var_11152 = 0;
  level.var_7661.var_11761 = 6;
  level.var_7661.var_11762 = 10;
  level.var_7661.var_91AF = [];
  level.var_7661.var_11151 = [];
  level.var_7661.var_A917 = [];
  level.var_7661.var_22FD = [];
  level.var_7661.var_10466 = spawn("script_origin", level.player.origin);
  level.var_7661.var_10466 linkto(level.player);
}

func_7663() {
  level.var_7661.var_10466 delete();
  level.var_7661 = spawnStruct();
  level.var_7661.var_19 = 0;
  level.var_7661.var_11760 = [];
}

func_7662() {
  func_7664();
  func_3F6A(1, "ui_chyron_on");
  thread func_11151(1);
  var_00 = 0.4;
  thread func_DB9A(1, var_00);
  wait(var_00);
  var_01 = 0;
  while(level.var_7661.var_11760.size) {
    level thread func_765F(level.var_7661.var_11760[0], var_01);
    var_01++;
    wait(0.5);
    level.var_7661.var_11760 = scripts\sp\utility::array_remove_index(level.var_7661.var_11760, 0);
  }

  level.var_7661.var_1175D = 0;
  wait(1);
  level.var_7661.var_11152 = 1;
  wait(2);
  level.var_7661.var_11152 = 0;
  wait(1);
  func_3F6A(1, "ui_chyron_off");
  func_6BAF(1, 0);
  if(level.var_7661.var_11760.size) {
    level.var_7661.var_10466 delete();
    thread func_7662();
    return;
  }

  func_7663();
}

func_765F(param_00, param_01) {
  var_02 = func_48F3(param_00, param_01);
  level.var_7661.var_1175E = var_02.x;
  level.var_7661.var_1175F = var_02.y;
  level.var_7661.var_1175D = 1;
  var_02 thread func_DB9D(1);
  var_02.alpha = 1;
  var_02 setpulsefx(30, -15536, 700);
  if(randomint(100) < 10) {
    var_02 scripts\engine\utility::delaythread(2, ::func_C369, -7, 7, 3, -5, 5, 3);
  }
}

func_48F3(param_00, param_01) {
  var_02 = newhudelem();
  var_02.x = level.var_7661.var_11761;
  var_02.y = level.var_7661.var_11762 + param_01 * 20;
  var_02.horzalign = "left";
  var_02.vertalign = "top";
  var_02.sort = 3;
  var_02.foreground = 1;
  var_02 settext(param_00);
  var_02.text = param_00;
  var_02.alpha = 0;
  var_02.hidewheninmenu = 1;
  var_02.font = "default";
  var_02.fontscale = 1.25;
  if(level.console) {
    var_02.fontscale = 1;
  }

  var_02.color = (0.85, 0.93, 0.92);
  var_02.objective_current_nomessage = 0;
  level.var_7661.var_91AF[level.var_7661.var_91AF.size] = var_02;
  return var_02;
}

func_111A0(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = func_48B3(param_00, param_02, param_03);
  var_07.fontscale = 2;
  var_07.horzalign = "subleft";
  var_07.vertalign = "subtop";
  var_07.aligny = "middle";
  var_07.alignx = "center";
  var_07.alpha = 1;
  var_07.sort = 3;
  if(isDefined(param_05)) {
    var_07.objective_delete = param_05;
  }

  if(!isDefined(param_06)) {
    param_06 = 20;
  }

  var_07 setpulsefx(param_06, -15536, 700);
  var_08 = [var_07];
  var_09 = func_5F33(var_07, 2);
  foreach(var_0B in var_09) {
    var_0B.alpha = 0;
    var_0B thread func_9130(randomfloatrange(0.5, 1.5), randomfloatrange(0.05, 0.2), param_01 - 0.5);
  }

  var_07 thread func_DB9D(0);
  var_08 = scripts\engine\utility::array_combine(var_09, var_08);
  return var_08;
}

func_9130(param_00, param_01, param_02) {
  wait(param_00);
  self.alpha = param_01;
  thread location_dupes_thread(param_02 - 0.5, 1);
}

func_5F33(param_00, param_01) {
  var_02 = [];
  for(var_03 = 0; var_03 < param_01; var_03++) {
    var_04 = newhudelem();
    var_04.x = param_00.x;
    var_04.y = param_00.y;
    var_04.alpha = param_00.alpha;
    var_04.aligny = param_00.aligny;
    var_04.alignx = param_00.alignx;
    var_04.horzalign = param_00.horzalign;
    var_04.vertalign = param_00.vertalign;
    var_04.foreground = param_00.foreground;
    var_04.hidewheninmenu = param_00.hidewheninmenu;
    var_04.fontscale = param_00.fontscale;
    var_04.sort = param_00.sort;
    var_04.color = param_00.color;
    var_04 settext(param_00.text);
    var_02[var_02.size] = var_04;
  }

  return var_02;
}

func_1119F(param_00, param_01, param_02, param_03) {
  var_04 = newhudelem();
  var_04.x = param_01;
  var_04.y = param_02 + param_03 - 1 * 10;
  var_04.alignx = "center";
  var_04.aligny = "middle";
  var_04.horzalign = "subleft";
  var_04.vertalign = "subtop";
  var_04.sort = 1;
  var_04.foreground = 1;
  var_04.hidewheninmenu = 1;
  var_04.alpha = 0;
  var_05 = param_03 * 40 + 20;
  var_04 setshader("white", 1, var_05);
  var_04.color = (0.85, 0.93, 0.92);
  var_04 fadeovertime(0.25);
  var_04.alpha = 0.1;
  var_04 scaleovertime(0.1, 2000, var_05);
  wait(0.1);
  scripts\engine\utility::array_thread(param_00, ::func_913E, 0.1);
  var_06 = 0.15;
  var_04 fadeovertime(0.25);
  var_04.alpha = 0.2;
  var_04.color = (1, 1, 1);
  var_04 scaleovertime(var_06, 2000, 2);
  wait(var_06);
  var_04 scaleovertime(var_06, 2, 2);
  var_04 fadeovertime(var_06);
  var_04.alpha = 0;
  wait(var_06);
  var_04 destroy();
}

func_A03D(param_00) {
  level.player freezecontrols(1);
  scripts\sp\hud_util::func_10CCC();
  var_01 = newhudelem();
  level.var_3F2B = spawnStruct();
  wait(1);
  var_02 = func_48C0("left");
  wait(0.1);
  var_03 = func_48C0("right");
  var_03.var_C39F = var_03.x;
  var_03 func_2B9E(2);
  wait(0.2);
  var_04 = func_490F(param_00);
  var_05 = var_04[var_04.size - 1].x;
  var_03 moveovertime(0.2);
  var_03.x = var_05 - 4;
  var_06 = spawnStruct();
  var_06.var_C1 = var_04.size;
  foreach(var_08 in var_04) {
    var_06 thread func_6AB6(var_08);
  }

  var_06 waittill("fadein_letter_done");
  wait(0.3);
  var_02 thread func_2BA0(3);
  var_03 thread func_2BA0(3);
  wait(2);
  var_02 thread func_2BA1(3);
  var_03 thread func_2BA1(3);
  wait(0.3);
  var_0A = 0.4;
  var_03 moveovertime(var_0A);
  var_03.x = var_03.var_C39F;
  var_0A = var_0A / var_04.size;
  for(var_0B = var_04.size - 1; var_0B >= 0; var_0B--) {
    var_08 = var_04[var_0B];
    var_08 fadeovertime(var_04.size - var_0B * var_0A);
    var_08.alpha = 0;
  }

  wait(var_0A + 0.3);
  var_02 thread func_2BA0(3);
  var_03 thread func_2BA0(3);
  wait(1);
  scripts\engine\utility::array_call(var_04, ::destroy);
  var_03 destroy();
  var_02 destroy();
}

func_6AB6(param_00) {
  var_01 = randomfloatrange(0.1, 0.3);
  var_02 = randomfloatrange(0.45, 0.8);
  param_00 func_2B9E(2, 0.2, 0.5, 0.8);
  if(randomint(100) < 30) {
    param_00 func_2B9E(2, 0.05, 0.1, 0.8);
  }

  self.var_C1--;
  if(self.var_C1 == 0) {
    self notify("fadein_letter_done");
  }
}

func_2BA0(param_00, param_01, param_02, param_03) {
  func_2B9E(param_00, param_01, param_02, param_03);
  if(!isDefined(param_01)) {
    param_01 = 0.05;
  }

  if(!isDefined(param_02)) {
    param_02 = 0.1;
  }

  var_04 = randomfloatrange(param_01, param_02);
  self fadeovertime(var_04);
  self.alpha = 0;
}

func_2BA1(param_00, param_01, param_02, param_03) {
  func_2B9E(param_00, param_01, param_02, param_03);
  if(!isDefined(param_01)) {
    param_01 = 0.05;
  }

  if(!isDefined(param_02)) {
    param_02 = 0.1;
  }

  if(!isDefined(param_03)) {
    param_03 = 0.8;
  }

  var_04 = randomfloatrange(param_01, param_02);
  self fadeovertime(var_04);
  self.alpha = param_03;
}

func_2B9E(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_01)) {
    param_01 = 0.05;
  }

  if(!isDefined(param_02)) {
    param_02 = 0.1;
  }

  if(!isDefined(param_03)) {
    param_03 = 0.8;
  }

  for(var_04 = 0; var_04 < param_00; var_04++) {
    var_05 = randomfloatrange(param_01, param_02);
    self fadeovertime(var_05);
    if(var_04 % 2) {
      var_06 = param_03;
    } else {
      var_06 = randomfloatrange(0.05, 0.2);
    }

    self.alpha = var_06;
    wait(var_05);
  }

  var_05 = randomfloatrange(param_01, param_02);
  self fadeovertime(var_05);
  self.alpha = param_03;
}

func_490F(param_00) {
  var_01 = [];
  var_02 = undefined;
  for(var_03 = 0; var_03 < param_00.size; var_03++) {
    var_04 = param_00[var_03];
    var_05 = func_490E(var_04);
    var_05.alpha = 0;
    var_06 = 20;
    if(isDefined(var_02)) {
      if(var_02.text == "\'") {
        var_06 = 10;
      } else if(var_02.text == "M") {
        var_06 = 24;
      } else if(var_02.text == "E") {
        var_06 = 18;
      } else if(var_02.text == "T") {
        var_06 = 18;
      } else if(var_02.text == " ") {
        var_06 = 14;
      }
    }

    if(isDefined(var_02)) {
      var_05.x = var_02.x + var_06;
    }

    var_01[var_01.size] = var_05;
    var_02 = var_05;
  }

  return var_01;
}

func_490E(param_00) {
  var_01 = newhudelem();
  var_01.x = 400;
  var_01.y = 400;
  var_01.alignx = "left";
  var_01.aligny = "middle";
  var_01.sort = 1;
  var_01.foreground = 1;
  var_01.hidewheninmenu = 1;
  var_01.alpha = 1;
  var_01.color = (0.925, 0.933, 0.957);
  var_01.fontscale = 2;
  var_01.font = "objective";
  var_01.text = param_00;
  var_01 settext(param_00);
  return var_01;
}

func_48C0(param_00) {
  var_01 = newhudelem();
  var_01.x = 397;
  var_01.y = 400;
  var_01.alignx = "left";
  var_01.aligny = "middle";
  var_01.sort = 1;
  var_01.foreground = 1;
  var_01.hidewheninmenu = 1;
  var_01.alpha = 0.8;
  var_01.var_C377 = var_01.alpha;
  var_01.color = (0.925, 0.933, 0.957);
  var_02 = "chyron_border_" + param_00;
  var_01 setshader(var_02, 22, 22);
  return var_01;
}