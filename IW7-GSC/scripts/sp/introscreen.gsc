/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\sp\introscreen.gsc
*********************************************/

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
  var_0 = 0;
  if(!isDefined(level.var_9AF3) || !scripts\sp\utility::func_9BB5() || var_0) {
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

  var_0 = level.var_9AF3.var_ACF2;
  var_1 = getarraykeys(var_0);
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    var_4 = 1;
    var_5 = var_2 * var_4 + 1;
    scripts\engine\utility::delaythread(var_5, ::introscreen_corner_line, var_0[var_3], var_0.size - var_2 - 1, var_4, var_3);
  }

  return 1;
}

func_9AF8(var_0, var_1, var_2) {
  func_9AF9("black", var_0, var_1, var_2);
}

func_9AF9(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 1.5;
  }

  if(!isDefined(var_3)) {
    scripts\sp\hud_util::func_10CCC();
  } else {
    scripts\sp\hud_util::func_6AA3(var_3);
  }

  wait(var_1);
  scripts\sp\hud_util::func_6A99(var_2);
  wait(var_2);
  setsaveddvar("com_cinematicEndInWhite", 0);
}

introscreen_corner_line(var_0, var_1, var_2, var_3) {
  level notify("new_introscreen_element");
  if(!isDefined(level.intro_offset)) {
    level.intro_offset = 0;
  } else {
    level.intro_offset++;
  }

  var_4 = cornerline_height();
  var_5 = newhudelem();
  var_5.x = 20;
  var_5.y = var_4;
  var_5.alignx = "left";
  var_5.aligny = "bottom";
  var_5.horzalign = "left";
  var_5.vertalign = "bottom";
  var_5.sort = 1;
  var_5.foreground = 1;
  var_5 settext(var_0);
  var_5.alpha = 0;
  var_5 fadeovertime(0.2);
  var_5.alpha = 1;
  var_5.hidewheninmenu = 1;
  var_5.fontscale = 2;
  var_5.color = (0.8, 1, 0.8);
  var_5.font = "default";
  var_5.objective_delete = (0.3, 0.6, 0.3);
  var_5.objective_current_nomessage = 1;
  var_6 = int(var_1 * var_2 * 1000 + 4000);
  var_5 setpulsefx(30, var_6, 700);
  thread hudelem_destroy(var_5);
}

cornerline_height() {
  return level.intro_offset * 20 - 82;
}

hudelem_destroy(var_0) {
  wait(16);
  var_0 notify("destroying");
  level.var_9AC9 = undefined;
  var_1 = 0.5;
  var_0 fadeovertime(var_1);
  var_0.alpha = 0;
  wait(var_1);
  var_0 notify("destroy");
  var_0 destroy();
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

func_9AF3(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
    var_2 = 1;
  }

  if(isDefined(var_1)) {
    var_0 = 1;
    scripts\sp\hud_util::func_10CCC();
    level.player freezecontrols(1);
    level.player scripts\engine\utility::delaycall(var_1, ::freezecontrols, 0);
    scripts\engine\utility::delaythread(var_1, ::scripts\sp\hud_util::func_6A99, 2);
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
  level.var_3F69.var_BFE0 = var_0;
  if(!var_0) {
    level.player freezecontrols(1);
    scripts\sp\hud_util::func_10CCC();
    thread func_22FD(0);
  }

  func_3F6A(0, "ui_chyron_on");
  thread func_11151(0);
  var_3 = 0.4;
  thread func_DB9A(0, var_3);
  wait(var_3);
  func_119A5(level.var_9AF3.var_ACF2[0]);
  func_3F6A(0, "ui_chyron_firstline");
  func_111A1(level.var_9AF3.var_ACF2[1], 0);
  wait(2);
  var_4 = func_111A1(level.var_9AF3.var_ACF2[2], 1, "default", 1, 1);
  var_4.color = (0.68, 0.744, 0.736);
  var_5 = undefined;
  if(isDefined(level.var_9AF3.var_ACF2[3])) {
    var_5 = func_111A1(level.var_9AF3.var_ACF2[3], 2, "default", 1, 1);
    var_5.color = (0.68, 0.744, 0.736);
    level.var_3F69.var_91AF = scripts\engine\utility::array_remove(level.var_3F69.var_91AF, var_5);
  }

  wait(1);
  level.var_3F69.var_11152 = 1;
  wait(2);
  level.var_3F69.var_11152 = 0;
  if(isDefined(var_5)) {
    var_5 thread func_BE48();
  }

  wait(1);
  func_6BAF(0, var_0);
  if(!var_0) {
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
  var_0 = self.color;
  var_1 = self.alpha;
  self notify("stop_quick_pulse");
  var_2 = 2;
  self.objective_current_nomessage = 1;
  self.objective_delete = (1, 1, 1);
  thread func_6A98((0.10625, 0.11625, 0.115), 0.1, var_2);
  self.color = (1, 1, 1);
  self.alpha = 1;
  self fadeovertime(var_2);
  self.color = var_0;
  self.alpha = 0.8;
  var_2 = 4;
  self moveovertime(var_2 * 3);
  self changefontscaleovertime(var_2 * 1.5);
  self.x = self.x + randomintrange(5, 10);
  self.y = self.y - randomintrange(3, 12);
  self.fontscale = self.fontscale * randomfloatrange(1.2, 1.3);
  wait(var_2);
  self fadeovertime(2);
  self.alpha = 0;
  wait(2);
  self destroy();
}

func_6A98(var_0, var_1, var_2) {
  self endon("death");
  var_3 = var_2 * 20;
  var_4 = var_0 - self.objective_delete / var_3;
  var_5 = var_1 - self.objective_current_nomessage / var_3;
  for(var_6 = 0; var_6 < var_3; var_6++) {
    self.objective_delete = self.objective_delete + var_4;
    self.objective_current_nomessage = self.objective_current_nomessage + var_5;
    wait(0.05);
  }

  self.objective_delete = var_0;
  self.objective_current_nomessage = var_1;
}

func_3F6A(var_0, var_1) {
  if(var_0 == 0) {
    level.var_3F69.var_10466 playSound(var_1);
    return;
  }

  level.var_7661.var_10466 playSound(var_1);
}

func_913E(var_0) {
  self endon("death");
  self fadeovertime(var_0);
  self.alpha = 0;
  wait(var_0);
  self destroy();
}

func_DB9A(var_0, var_1) {
  wait(0.5);
  var_2 = newhudelem();
  if(var_0 == 0) {
    var_2.x = level.var_3F69.var_11761 - 5;
    var_2.y = level.var_3F69.var_11762;
    var_2.vertalign = "bottom";
  } else {
    var_2.x = level.var_7661.var_11761 - 5;
    var_2.y = level.var_7661.var_11762;
    var_2.vertalign = "top";
  }

  var_2.fontscale = 3;
  var_2.horzalign = "left";
  var_2.sort = 1;
  var_2.foreground = 1;
  var_2.hidewheninmenu = 1;
  var_2.alpha = 0.8;
  var_2 setshader("white", 1, 35);
  var_2.color = (0.85, 0.93, 0.92);
  var_2 moveovertime(var_1);
  var_2 fadeovertime(var_1 * 0.5);
  var_2.alpha = 0;
  var_2.x = var_2.x + 300;
  wait(0.4);
  var_2 destroy();
}

func_22FD(var_0) {
  if(var_0 == 0) {
    level endon("chyron_faze_out_text_intro");
  } else {
    level endon("chyron_faze_out_text_gamenotify");
  }

  var_1 = [".", "-", "_", "|", "+"];
  var_2 = 0.7;
  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_4 = func_48B3("");
    var_4.fontscale = var_2;
    var_4.alpha = 0;
    var_4.sort = 2;
    var_4.color = (0.75, 0.83, 0.89);
    var_4.var_DAE6 = 0;
    level.var_3F69.var_22FD[level.var_3F69.var_22FD.size] = var_4;
  }

  level.var_3F69.var_22FE = 0;
  thread func_22FC(var_0);
  var_5 = 0;
  var_6 = level.var_3F69.var_11762 - 10;
  for(;;) {
    var_7 = 0;
    var_1 = scripts\engine\utility::array_randomize(var_1);
    foreach(var_4 in level.var_3F69.var_22FD) {
      func_3F6A(var_0, "ui_chyron_plusminus");
      var_4.fontscale = var_2;
      if(var_1[var_7] == "+") {
        var_4.fontscale = 0.55;
      }

      var_4 settext(var_1[var_7]);
      var_4.x = var_5 + randomint(200);
      var_4.y = var_6 + randomint(60);
      var_4.var_DAE6 = 1;
      var_7++;
      wait(randomfloatrange(0.05, 0.1));
    }

    wait(randomfloatrange(4, 7));
    level.var_3F69.var_22FE = 1;
    level waittill("chyron_artifact_faded");
  }
}

func_22FC(var_0) {
  if(var_0 == 0) {
    level endon("chyron_faze_out_text_intro");
  } else {
    level endon("chyron_faze_out_text_gamenotify");
  }

  var_1 = 0.6;
  var_2 = 1;
  for(;;) {
    if(level.var_3F69.var_22FE) {
      var_1 = var_1 - 0.07;
    } else {
      if(var_1 < 0.15 || var_1 > 0.6) {
        var_2 = var_2 * -1;
      }

      var_1 = var_1 + 0.02 + randomfloat(0.04) * var_2;
    }

    var_1 = max(var_1, 0);
    foreach(var_4 in level.var_3F69.var_22FD) {
      if(var_4.var_DAE6) {
        if(var_1 == 0) {
          var_4.alpha = 0;
          continue;
        }

        var_4.alpha = randomfloatrange(var_1 * 0.6, var_1);
      }
    }

    if(var_1 == 0) {
      level notify("chyron_artifact_faded");
      var_1 = 0.8;
      level.var_3F69.var_22FE = 0;
      foreach(var_4 in level.var_3F69.var_22FD) {
        var_4.var_DAE6 = 0;
      }
    }

    wait(0.05);
  }
}

func_11151(var_0) {
  if(var_0 == 0) {
    level endon("chyron_faze_out_text_intro");
  } else {
    level endon("chyron_faze_out_text_gamenotify");
  }

  var_1 = 5;
  var_2 = 0;
  var_3 = 1;
  for(;;) {
    if((var_0 == 0 && level.var_3F69.var_11152) || var_0 == 1 && level.var_7661.var_11152) {
      wait(0.05);
      continue;
    }

    var_2++;
    var_4 = int(min(var_2, var_1));
    for(var_5 = 0; var_5 < var_4; var_5++) {
      thread func_495C(var_0);
      wait(randomfloatrange(0, 0.1));
    }

    if((var_0 == 0 && level.var_3F69.var_1175D) || var_0 == 1 && level.var_7661.var_1175D) {
      wait(0.05);
      continue;
    }

    wait(randomfloatrange(var_3 * 0.5, var_3));
    var_3 = var_3 - 0.05;
    var_3 = max(var_3, 0.2);
  }
}

func_119A5(var_0, var_1) {
  var_2 = func_48B3(var_0);
  level.var_3F69.var_1175E = var_2.x;
  level.var_3F69.var_1175F = var_2.y;
  level.var_3F69.var_1175D = 1;
  wait(0.5);
  level.var_3F69.var_1175D = 0;
  var_3 = func_5F31(var_2, 1);
  var_4 = 4;
  var_3[0] thread location_dupes_thread(var_4);
  var_2.y = var_2.y - 10;
  var_2.objective_current_nomessage = 0.05;
  var_2.objective_delete = (0.425, 0.465, 0.46) * vehicle_setspeed();
  var_5 = 0.3;
  var_2 moveovertime(var_5);
  var_2 fadeovertime(var_5 * 3);
  var_2.y = var_2.y + 10;
  var_6 = 0.5;
  var_6 = var_6 - var_5;
  wait(var_5);
  var_2 thread func_DB9D(0);
  wait(var_6);
  if(randomint(100) > 10) {
    var_2 thread func_C369(-30, 30, 20, -8, 8, 4);
  }
}

func_C369(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = randomintrange(1, 2);
  for(var_7 = 0; var_7 < var_6; var_7++) {
    var_8 = func_DCB1(var_0, var_1, var_2);
    var_9 = func_DCB1(var_3, var_4, var_5);
    var_0A[0] = [var_8, var_9];
    var_0A[1] = [var_8 - 10, var_9];
    thread func_915B(var_0A);
    wait(randomfloatrange(0.5, 1));
  }
}

func_6BAF(var_0, var_1) {
  var_2 = undefined;
  if(!var_1) {
    var_2 = newhudelem();
    if(var_0 == 0) {
      var_2.x = level.var_3F69.var_11761 + 60;
      var_2.y = level.var_3F69.var_11762 + 30;
      var_2.vertalign = "bottom";
    } else {
      var_2.x = level.var_7661.var_11761 + 60;
      var_2.y = level.var_7661.var_11762 + 10;
      var_2.vertalign = "top";
    }

    var_2.alignx = "center";
    var_2.aligny = "middle";
    var_2.horzalign = "left";
    var_2.sort = 1;
    var_2.foreground = 1;
    var_2.hidewheninmenu = 1;
    var_2.alpha = 0;
    var_2 setshader("white", 1, 60);
    var_2.color = (0.85, 0.93, 0.92);
    var_2 fadeovertime(0.25);
    var_2.alpha = 0.1;
    var_2 scaleovertime(0.1, 2000, 60);
    wait(0.1);
  }

  var_3 = 0.15;
  func_6AA9(var_0, var_3 * 0.4);
  if(!var_1) {
    var_2 fadeovertime(0.25);
    var_2.alpha = 0.2;
    var_2.color = (1, 1, 1);
    var_2 scaleovertime(var_3, 2000, 2);
    wait(var_3);
    var_3 = 0.15;
    var_2 scaleovertime(var_3, 2, 2);
    var_2 thread func_6BB0(var_3);
  }
}

func_6BB0(var_0) {
  self fadeovertime(var_0);
  self.alpha = 0;
  wait(var_0);
  self destroy();
}

func_6AA9(var_0, var_1) {
  if(var_0 == 0) {
    level notify("chyron_faze_out_text_intro");
    foreach(var_3 in level.var_3F69.var_91AF) {
      if(!isDefined(var_3)) {
        continue;
      }

      var_3 thread func_913E(var_1);
    }

    foreach(var_3 in level.var_3F69.var_11151) {
      var_3 thread func_913E(var_1);
    }

    return;
  }

  level notify("chyron_faze_out_text_gamenotify");
  foreach(var_3 in level.var_7661.var_91AF) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_3 thread func_913E(var_1);
  }

  foreach(var_3 in level.var_7661.var_11151) {
    var_3 thread func_913E(var_1);
  }
}

func_111A1(var_0, var_1, var_2, var_3, var_4) {
  var_5 = func_48B3(var_0);
  var_5.y = var_5.y + 20 + var_1 * 15;
  if(isDefined(var_2)) {
    var_5.font = var_2;
  }

  var_5.fontscale = 1;
  if(isDefined(var_3)) {
    var_5.fontscale = var_3;
  }

  level.var_3F69.var_1175E = var_5.x;
  level.var_3F69.var_1175F = var_5.y;
  level.var_3F69.var_1175D = 1;
  wait(0.5);
  var_5.objective_current_nomessage = 0.05;
  var_5.objective_delete = (0.425, 0.465, 0.46) * vehicle_setspeed();
  var_5 thread func_DB9D(0, var_4);
  var_5.alpha = 1;
  if(isDefined(var_4)) {
    var_5.alpha = var_4;
  }

  var_5 setpulsefx(30, -15536, 700);
  if(randomint(100) > 70) {
    var_5 scripts\engine\utility::delaythread(2, ::func_C369, -7, 7, 3, -5, 5, 3);
  }

  level.var_3F69.var_1175D = 0;
  return var_5;
}

vehicle_setspeed() {
  var_0 = 1;
  if(isDefined(level.var_3F69) && level.var_3F69.var_BFE0) {
    var_0 = 0.3;
  }

  return var_0;
}

func_915B(var_0) {
  var_1 = self.x;
  var_2 = self.y;
  foreach(var_4 in var_0) {
    self.x = var_1 + var_4[0];
    self.y = var_2 + var_4[1];
    wait(randomfloatrange(0.05, 0.2));
  }

  self.x = var_1;
  self.y = var_2;
}

func_DB9D(var_0, var_1) {
  self endon("death");
  self endon("stop_quick_pulse");
  if(var_0 == 0) {
    level endon("chyron_faze_out_text_intro");
  } else {
    level endon("chyron_faze_out_text_gamenotify");
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  for(;;) {
    wait(0.05);
    self.alpha = randomfloatrange(var_1 * 0.7, var_1);
  }
}

location_dupes_thread(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  self endon("death");
  var_2 = self.x;
  var_3 = self.y;
  var_4 = 0.15;
  if(!var_1) {
    self.x = self.x + randomintrange(-30, -10);
    self.y = self.y + randomintrange(10, 20);
    self moveovertime(var_4);
    self.x = var_2;
    self.y = var_3;
    self fadeovertime(var_4);
    self.alpha = 0.1;
    wait(var_4);
  }

  self moveovertime(var_0);
  self.x = self.x + randomintrange(15, 20);
  self.y = self.y + randomintrange(-4, 4);
  wait(var_0);
  var_4 = 0.05;
  self moveovertime(var_4);
  self.x = var_2;
  self.y = var_3;
  wait(var_4);
  self fadeovertime(var_4);
  self.alpha = 0;
}

func_DCB1(var_0, var_1, var_2) {
  var_3 = randomintrange(var_0, var_1);
  var_4 = 1;
  if(var_3 < 0) {
    var_4 = -1;
  }

  var_3 = max(abs(var_3), var_2);
  return var_3 * var_4;
}

func_48B3(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = level.var_3F69.var_11761;
  }

  if(!isDefined(var_2)) {
    var_2 = level.var_3F69.var_11762;
  }

  var_3 = newhudelem();
  var_3.x = var_1;
  var_3.y = var_2;
  var_3.horzalign = "left";
  var_3.vertalign = "bottom";
  var_3.aligny = "bottom";
  var_3.sort = 3;
  var_3.foreground = 1;
  var_3 settext(var_0);
  var_3.text = var_0;
  var_3.alpha = 0;
  var_3.hidewheninmenu = 1;
  var_3.fontscale = 1.4;
  if(level.console) {
    var_3.fontscale = 1.2;
  }

  var_3.color = (0.85, 0.93, 0.92);
  var_3.font = "default";
  if(isDefined(level.var_3F69)) {
    level.var_3F69.var_91AF[level.var_3F69.var_91AF.size] = var_3;
  }

  return var_3;
}

func_7CBA(var_0) {
  var_1 = spawnStruct();
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  if(var_0 == 0) {
    var_5 = -85;
    var_2 = level.var_3F69.var_1175D;
    var_3 = level.var_3F69.var_1175E;
    var_4 = level.var_3F69.var_1175F;
  } else {
    var_5 = 0;
    var_2 = level.var_7661.var_1175D;
    var_3 = level.var_7661.var_1175E;
    var_4 = level.var_7661.var_1175F;
  }

  var_6 = 200;
  var_7 = 60;
  var_1.width = randomintrange(20, var_6);
  var_8 = [5, 10, 15];
  var_1.height = var_8[randomint(var_8.size)];
  var_1.x = randomintrange(0, var_6 - var_1.width);
  var_1.y = var_5 + randomint(var_7 - var_1.height);
  var_1.alpha = randomfloatrange(0.3, 0.7);
  var_1.color = func_7CB9();
  var_1.time = randomfloatrange(0.05, 0.1);
  if(var_2) {
    var_1.x = int(var_3 + randomintrange(-1, 1));
    var_1.y = int(var_4 + randomintrange(0, 7));
    var_1.width = randomintrange(100, var_6);
    var_1.height = randomintrange(10, 15);
    var_1.color = (0.85, 0.93, 0.92) * randomfloatrange(0.2, 0.4);
  }

  return var_1;
}

func_7CB9() {
  var_0 = [];
  var_0[var_0.size] = (0.15, 0.14, 0.22);
  var_0[var_0.size] = (0.09, 0.11, 0.13);
  var_0[var_0.size] = (0.34, 0.22, 0.22);
  var_0[var_0.size] = (0.29, 0.34, 0.22);
  return var_0[randomint(var_0.size)];
}

func_495C(var_0) {
  if(var_0 == 0) {
    level endon("chyron_faze_out_text_intro");
    if(level.var_3F69.var_11151.size < 8) {
      var_1 = newhudelem();
      var_1.var_13438 = 0;
      level.var_3F69.var_11151[level.var_3F69.var_11151.size] = var_1;
    }

    var_2 = undefined;
    foreach(var_4 in level.var_3F69.var_11151) {
      if(var_4.var_13438) {
        continue;
      }

      var_2 = var_4;
    }

    if(!isDefined(var_2)) {
      return;
    }

    var_6 = func_7CBA(var_0);
    if(!level.var_3F69.var_1175D) {
      if(level.var_3F69.var_A917.size > 0 && level.var_3F69.var_A917.size < 3 && randomint(100) > 10) {
        var_7 = level.var_3F69.var_A917[level.var_3F69.var_A917.size - 1];
        var_6.x = var_7.x;
        var_6.y = var_7.y + var_7.height;
        if(scripts\engine\utility::cointoss()) {
          var_6.y = var_7.y - var_6.height;
        }
      } else {
        level.var_3F69.var_A917 = [];
      }

      level.var_3F69.var_A917[level.var_3F69.var_A917.size] = var_2;
    }
  } else {
    level endon("chyron_faze_out_text_gamenotify");
    if(level.var_7661.var_11151.size < 8) {
      var_1 = newhudelem();
      var_1.var_13438 = 0;
      level.var_7661.var_11151[level.var_7661.var_11151.size] = var_1;
    }

    var_2 = undefined;
    foreach(var_4 in level.var_7661.var_11151) {
      if(var_4.var_13438) {
        continue;
      }

      var_2 = var_4;
    }

    if(!isDefined(var_2)) {
      return;
    }

    var_6 = func_7CBA(var_0);
    if(!level.var_7661.var_1175D) {
      if(level.var_7661.var_A917.size > 0 && level.var_7661.var_A917.size < 3 && randomint(100) > 10) {
        var_7 = level.var_7661.var_A917[level.var_7661.var_A917.size - 1];
        var_6.x = var_7.x;
        var_6.y = var_7.y + var_7.height;
        if(scripts\engine\utility::cointoss()) {
          var_6.y = var_7.y - var_6.height;
        }
      } else {
        level.var_7661.var_A917 = [];
      }

      level.var_7661.var_A917[level.var_7661.var_A917.size] = var_2;
    }
  }

  var_2.x = var_6.x;
  var_2.y = var_6.y;
  var_2.width = var_6.width;
  var_2.height = var_6.height;
  var_2 setshader("white", var_6.width, var_6.height);
  var_2.alpha = var_6.alpha;
  var_2.color = var_6.color;
  if(var_2.alpha > 0.6) {
    func_3F6A(var_0, "ui_chyron_line_static");
  }

  var_2.horzalign = "left";
  var_2.vertalign = "bottom";
  if(var_0 == 1) {
    var_2.vertalign = "top";
  }

  var_2.sort = 1;
  var_2.foreground = 1;
  var_2.hidewheninmenu = 1;
  var_2.var_13438 = 1;
  wait(var_6.time);
  var_2.alpha = 0;
  var_2.var_13438 = 0;
}

func_5F31(var_0, var_1) {
  var_2 = [];
  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_2[var_2.size] = func_48B3(var_0.text);
  }

  return var_2;
}

func_7661() {
  level.var_7661 = spawnStruct();
  level.var_7661.var_19 = 0;
  level.var_7661.var_11760 = [];
  level thread func_7660("chyron_message1");
  level thread func_7660("chyron_message2");
  level thread func_7660("chyron_message3");
}

func_7660(var_0) {
  for(;;) {
    assertdemo(9010);
    assertdemo(var_0);
    level waittill(var_0, var_1, var_2);
    assertdemo(9009);
    func_765E(var_1);
  }
}

func_765E(var_0) {
  level.var_7661.var_11760[level.var_7661.var_11760.size] = var_0;
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
  var_0 = 0.4;
  thread func_DB9A(1, var_0);
  wait(var_0);
  var_1 = 0;
  while(level.var_7661.var_11760.size) {
    level thread func_765F(level.var_7661.var_11760[0], var_1);
    var_1++;
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

func_765F(var_0, var_1) {
  var_2 = func_48F3(var_0, var_1);
  level.var_7661.var_1175E = var_2.x;
  level.var_7661.var_1175F = var_2.y;
  level.var_7661.var_1175D = 1;
  var_2 thread func_DB9D(1);
  var_2.alpha = 1;
  var_2 setpulsefx(30, -15536, 700);
  if(randomint(100) < 10) {
    var_2 scripts\engine\utility::delaythread(2, ::func_C369, -7, 7, 3, -5, 5, 3);
  }
}

func_48F3(var_0, var_1) {
  var_2 = newhudelem();
  var_2.x = level.var_7661.var_11761;
  var_2.y = level.var_7661.var_11762 + var_1 * 20;
  var_2.horzalign = "left";
  var_2.vertalign = "top";
  var_2.sort = 3;
  var_2.foreground = 1;
  var_2 settext(var_0);
  var_2.text = var_0;
  var_2.alpha = 0;
  var_2.hidewheninmenu = 1;
  var_2.font = "default";
  var_2.fontscale = 1.25;
  if(level.console) {
    var_2.fontscale = 1;
  }

  var_2.color = (0.85, 0.93, 0.92);
  var_2.objective_current_nomessage = 0;
  level.var_7661.var_91AF[level.var_7661.var_91AF.size] = var_2;
  return var_2;
}

func_111A0(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = func_48B3(var_0, var_2, var_3);
  var_7.fontscale = 2;
  var_7.horzalign = "subleft";
  var_7.vertalign = "subtop";
  var_7.aligny = "middle";
  var_7.alignx = "center";
  var_7.alpha = 1;
  var_7.sort = 3;
  if(isDefined(var_5)) {
    var_7.objective_delete = var_5;
  }

  if(!isDefined(var_6)) {
    var_6 = 20;
  }

  var_7 setpulsefx(var_6, -15536, 700);
  var_8 = [var_7];
  var_9 = func_5F33(var_7, 2);
  foreach(var_0B in var_9) {
    var_0B.alpha = 0;
    var_0B thread func_9130(randomfloatrange(0.5, 1.5), randomfloatrange(0.05, 0.2), var_1 - 0.5);
  }

  var_7 thread func_DB9D(0);
  var_8 = scripts\engine\utility::array_combine(var_9, var_8);
  return var_8;
}

func_9130(var_0, var_1, var_2) {
  wait(var_0);
  self.alpha = var_1;
  thread location_dupes_thread(var_2 - 0.5, 1);
}

func_5F33(var_0, var_1) {
  var_2 = [];
  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_4 = newhudelem();
    var_4.x = var_0.x;
    var_4.y = var_0.y;
    var_4.alpha = var_0.alpha;
    var_4.aligny = var_0.aligny;
    var_4.alignx = var_0.alignx;
    var_4.horzalign = var_0.horzalign;
    var_4.vertalign = var_0.vertalign;
    var_4.foreground = var_0.foreground;
    var_4.hidewheninmenu = var_0.hidewheninmenu;
    var_4.fontscale = var_0.fontscale;
    var_4.sort = var_0.sort;
    var_4.color = var_0.color;
    var_4 settext(var_0.text);
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

func_1119F(var_0, var_1, var_2, var_3) {
  var_4 = newhudelem();
  var_4.x = var_1;
  var_4.y = var_2 + var_3 - 1 * 10;
  var_4.alignx = "center";
  var_4.aligny = "middle";
  var_4.horzalign = "subleft";
  var_4.vertalign = "subtop";
  var_4.sort = 1;
  var_4.foreground = 1;
  var_4.hidewheninmenu = 1;
  var_4.alpha = 0;
  var_5 = var_3 * 40 + 20;
  var_4 setshader("white", 1, var_5);
  var_4.color = (0.85, 0.93, 0.92);
  var_4 fadeovertime(0.25);
  var_4.alpha = 0.1;
  var_4 scaleovertime(0.1, 2000, var_5);
  wait(0.1);
  scripts\engine\utility::array_thread(var_0, ::func_913E, 0.1);
  var_6 = 0.15;
  var_4 fadeovertime(0.25);
  var_4.alpha = 0.2;
  var_4.color = (1, 1, 1);
  var_4 scaleovertime(var_6, 2000, 2);
  wait(var_6);
  var_4 scaleovertime(var_6, 2, 2);
  var_4 fadeovertime(var_6);
  var_4.alpha = 0;
  wait(var_6);
  var_4 destroy();
}

func_A03D(var_0) {
  level.player freezecontrols(1);
  scripts\sp\hud_util::func_10CCC();
  var_1 = newhudelem();
  level.var_3F2B = spawnStruct();
  wait(1);
  var_2 = func_48C0("left");
  wait(0.1);
  var_3 = func_48C0("right");
  var_3.var_C39F = var_3.x;
  var_3 func_2B9E(2);
  wait(0.2);
  var_4 = func_490F(var_0);
  var_5 = var_4[var_4.size - 1].x;
  var_3 moveovertime(0.2);
  var_3.x = var_5 - 4;
  var_6 = spawnStruct();
  var_6.var_C1 = var_4.size;
  foreach(var_8 in var_4) {
    var_6 thread func_6AB6(var_8);
  }

  var_6 waittill("fadein_letter_done");
  wait(0.3);
  var_2 thread func_2BA0(3);
  var_3 thread func_2BA0(3);
  wait(2);
  var_2 thread func_2BA1(3);
  var_3 thread func_2BA1(3);
  wait(0.3);
  var_0A = 0.4;
  var_3 moveovertime(var_0A);
  var_3.x = var_3.var_C39F;
  var_0A = var_0A / var_4.size;
  for(var_0B = var_4.size - 1; var_0B >= 0; var_0B--) {
    var_8 = var_4[var_0B];
    var_8 fadeovertime(var_4.size - var_0B * var_0A);
    var_8.alpha = 0;
  }

  wait(var_0A + 0.3);
  var_2 thread func_2BA0(3);
  var_3 thread func_2BA0(3);
  wait(1);
  scripts\engine\utility::array_call(var_4, ::destroy);
  var_3 destroy();
  var_2 destroy();
}

func_6AB6(var_0) {
  var_1 = randomfloatrange(0.1, 0.3);
  var_2 = randomfloatrange(0.45, 0.8);
  var_0 func_2B9E(2, 0.2, 0.5, 0.8);
  if(randomint(100) < 30) {
    var_0 func_2B9E(2, 0.05, 0.1, 0.8);
  }

  self.var_C1--;
  if(self.var_C1 == 0) {
    self notify("fadein_letter_done");
  }
}

func_2BA0(var_0, var_1, var_2, var_3) {
  func_2B9E(var_0, var_1, var_2, var_3);
  if(!isDefined(var_1)) {
    var_1 = 0.05;
  }

  if(!isDefined(var_2)) {
    var_2 = 0.1;
  }

  var_4 = randomfloatrange(var_1, var_2);
  self fadeovertime(var_4);
  self.alpha = 0;
}

func_2BA1(var_0, var_1, var_2, var_3) {
  func_2B9E(var_0, var_1, var_2, var_3);
  if(!isDefined(var_1)) {
    var_1 = 0.05;
  }

  if(!isDefined(var_2)) {
    var_2 = 0.1;
  }

  if(!isDefined(var_3)) {
    var_3 = 0.8;
  }

  var_4 = randomfloatrange(var_1, var_2);
  self fadeovertime(var_4);
  self.alpha = var_3;
}

func_2B9E(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = 0.05;
  }

  if(!isDefined(var_2)) {
    var_2 = 0.1;
  }

  if(!isDefined(var_3)) {
    var_3 = 0.8;
  }

  for(var_4 = 0; var_4 < var_0; var_4++) {
    var_5 = randomfloatrange(var_1, var_2);
    self fadeovertime(var_5);
    if(var_4 % 2) {
      var_6 = var_3;
    } else {
      var_6 = randomfloatrange(0.05, 0.2);
    }

    self.alpha = var_6;
    wait(var_5);
  }

  var_5 = randomfloatrange(var_1, var_2);
  self fadeovertime(var_5);
  self.alpha = var_3;
}

func_490F(var_0) {
  var_1 = [];
  var_2 = undefined;
  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];
    var_5 = func_490E(var_4);
    var_5.alpha = 0;
    var_6 = 20;
    if(isDefined(var_2)) {
      if(var_2.text == "\'") {
        var_6 = 10;
      } else if(var_2.text == "M") {
        var_6 = 24;
      } else if(var_2.text == "E") {
        var_6 = 18;
      } else if(var_2.text == "T") {
        var_6 = 18;
      } else if(var_2.text == " ") {
        var_6 = 14;
      }
    }

    if(isDefined(var_2)) {
      var_5.x = var_2.x + var_6;
    }

    var_1[var_1.size] = var_5;
    var_2 = var_5;
  }

  return var_1;
}

func_490E(var_0) {
  var_1 = newhudelem();
  var_1.x = 400;
  var_1.y = 400;
  var_1.alignx = "left";
  var_1.aligny = "middle";
  var_1.sort = 1;
  var_1.foreground = 1;
  var_1.hidewheninmenu = 1;
  var_1.alpha = 1;
  var_1.color = (0.925, 0.933, 0.957);
  var_1.fontscale = 2;
  var_1.font = "objective";
  var_1.text = var_0;
  var_1 settext(var_0);
  return var_1;
}

func_48C0(var_0) {
  var_1 = newhudelem();
  var_1.x = 397;
  var_1.y = 400;
  var_1.alignx = "left";
  var_1.aligny = "middle";
  var_1.sort = 1;
  var_1.foreground = 1;
  var_1.hidewheninmenu = 1;
  var_1.alpha = 0.8;
  var_1.var_C377 = var_1.alpha;
  var_1.color = (0.925, 0.933, 0.957);
  var_2 = "chyron_border_" + var_0;
  var_1 setshader(var_2, 22, 22);
  return var_1;
}