/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2885.gsc
***************************************/

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

  if(!isDefined(level.func_9AF3) || !scripts\sp\utility::func_9BB5() || var_00)
    scripts\engine\utility::delaythread(0.05, scripts\engine\utility::flag_set, "introscreen_complete");
  else {
    if(isDefined(level.func_9AF3.func_4C88)) {
      [
        [level.func_9AF3.func_4C88]
      ]();
      return;
    }

    func_9AF3();
  }
}

func_9AF7() {
  if(!isDefined(level.func_9AF3))
    return 0;

  var_00 = level.func_9AF3.func_ACF2;
  var_01 = getarraykeys(var_00);

  for(var_02 = 0; var_02 < var_1.size; var_2++) {
    var_03 = var_1[var_02];
    var_04 = 1;
    var_05 = var_02 * var_04 + 1;
    scripts\engine\utility::delaythread(var_05, ::introscreen_corner_line, var_0[var_03], var_0.size - var_02 - 1, var_04, var_03);
  }

  return 1;
}

func_9AF8(var_00, var_01, var_02) {
  func_9AF9("black", var_00, var_01, var_02);
}

func_9AF9(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_02))
    var_02 = 1.5;

  if(!isDefined(var_03))
    scripts\sp\hud_util::func_10CCC();
  else
    scripts\sp\hud_util::func_6AA3(var_03);

  wait(var_01);
  scripts\sp\hud_util::func_6A99(var_02);
  wait(var_02);
  _setsaveddvar("com_cinematicEndInWhite", 0);
}

introscreen_corner_line(var_00, var_01, var_02, var_03) {
  level notify("new_introscreen_element");

  if(!isDefined(level.intro_offset))
    level.intro_offset = 0;
  else
    level.intro_offset++;

  var_04 = cornerline_height();
  var_05 = newhudelem();
  var_5.x = 20;
  var_5.y = var_04;
  var_5.alignx = "left";
  var_5.aligny = "bottom";
  var_5.horzalign = "left";
  var_5.vertalign = "bottom";
  var_5.sort = 1;
  var_5.foreground = 1;
  var_05 give_zap_perk(var_00);
  var_5.alpha = 0;
  var_05 fadeovertime(0.2);
  var_5.alpha = 1;
  var_5.hidewheninmenu = 1;
  var_5.fontscale = 2.0;
  var_5.color = (0.8, 1, 0.8);
  var_5.font = "default";
  var_5.glowcolor = (0.3, 0.6, 0.3);
  var_5.glowalpha = 1;
  var_06 = int(var_01 * var_02 * 1000 + 4000);
  var_05 setpulsefx(30, var_06, 700);
  thread hudelem_destroy(var_05);
}

cornerline_height() {
  return level.intro_offset * 20 - 82;
}

hudelem_destroy(var_00) {
  wait 16;
  var_00 notify("destroying");
  level.func_9AC9 = undefined;
  var_01 = 0.5;
  var_00 fadeovertime(var_01);
  var_0.alpha = 0;
  wait(var_01);
  var_00 notify("destroy");
  var_00 destroy();
}

func_C3C4() {
  level.player getroundswon(1);
  thread func_9AF8(level.func_9AF3.func_4480, level.func_9AF3.func_6AAA, level.func_9AF3.func_6A9F);

  if(!func_9AF7())
    wait 0.05;

  wait(level.func_9AF3.func_4480);
  scripts\engine\utility::flag_set("introscreen_complete");
  level.player getroundswon(0);
}

func_9AF3(var_00, var_01) {
  if(!isDefined(var_00)) {
    var_00 = 0;
    var_02 = 1;
  }

  if(isDefined(var_01)) {
    var_00 = 1;
    scripts\sp\hud_util::func_10CCC();
    level.player getroundswon(1);
    level.player scripts\engine\utility::delaycall(var_01, ::getroundswon, 0);
    scripts\engine\utility::delaythread(var_01, scripts\sp\hud_util::func_6A99, 2);
  }

  level.func_3F69 = spawnStruct();
  level.func_3F69.func_91AF = [];
  level.func_3F69.func_11151 = [];
  level.func_3F69.func_A917 = [];
  level.func_3F69.func_22FD = [];
  level.func_3F69.func_11761 = 20;
  level.func_3F69.func_11762 = -82;
  level.func_3F69.func_1175D = 0;
  level.func_3F69.func_11152 = 0;
  level.func_3F69.func_10466 = spawn("script_origin", level.player.origin);
  level.func_3F69.func_10466 linkto(level.player);
  level.func_3F69.func_BFE0 = var_00;

  if(!var_00) {
    level.player getroundswon(1);
    scripts\sp\hud_util::func_10CCC();
    thread func_22FD(0);
  }

  func_3F6A(0, "ui_chyron_on");
  thread func_11151(0);
  var_03 = 0.4;
  thread func_DB9A(0, var_03);
  wait(var_03);
  func_119A5(level.func_9AF3.func_ACF2[0]);
  func_3F6A(0, "ui_chyron_firstline");
  func_111A1(level.func_9AF3.func_ACF2[1], 0);
  wait 2;
  var_04 = func_111A1(level.func_9AF3.func_ACF2[2], 1, "default", 1, 1);
  var_4.color = (0.68, 0.744, 0.736);
  var_05 = undefined;

  if(isDefined(level.func_9AF3.func_ACF2[3])) {
    var_05 = func_111A1(level.func_9AF3.func_ACF2[3], 2, "default", 1, 1);
    var_5.color = (0.68, 0.744, 0.736);
    level.func_3F69.func_91AF = scripts\engine\utility::array_remove(level.func_3F69.func_91AF, var_05);
  }

  wait 1;
  level.func_3F69.func_11152 = 1;
  wait 2;
  level.func_3F69.func_11152 = 0;

  if(isDefined(var_05))
    var_05 thread func_BE48();

  wait 1;
  func_6BAF(0, var_00);

  if(!var_00) {
    func_3F6A(0, "ui_chyron_off");
    thread scripts\sp\hud_util::func_6A99(2);
    level.player getroundswon(0);
  }

  scripts\engine\utility::flag_set("introscreen_complete");
  level notify("stop_chyron");
  level.func_3F69.func_10466 delete();
  level.func_3F69 = undefined;
}

func_BE48() {
  var_00 = self.color;
  var_01 = self.alpha;
  self notify("stop_quick_pulse");
  var_02 = 2;
  self.glowalpha = 1;
  self.glowcolor = (1, 1, 1);
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
  wait 2;
  self destroy();
}

func_6A98(var_00, var_01, var_02) {
  self endon("death");
  var_03 = var_02 * 20;
  var_04 = (var_00 - self.glowcolor) / var_03;
  var_05 = (var_01 - self.glowalpha) / var_03;

  for(var_06 = 0; var_06 < var_03; var_6++) {
    self.glowcolor = self.glowcolor + var_04;
    self.glowalpha = self.glowalpha + var_05;
    wait 0.05;
  }

  self.glowcolor = var_00;
  self.glowalpha = var_01;
}

func_3F6A(var_00, var_01) {
  if(var_00 == 0)
    level.func_3F69.func_10466 playSound(var_01);
  else
    level.func_7661.func_10466 playSound(var_01);
}

func_913E(var_00) {
  self endon("death");
  self fadeovertime(var_00);
  self.alpha = 0;
  wait(var_00);
  self destroy();
}

func_DB9A(var_00, var_01) {
  wait 0.5;
  var_02 = newhudelem();

  if(var_00 == 0) {
    var_2.x = level.func_3F69.func_11761 - 5;
    var_2.y = level.func_3F69.func_11762;
    var_2.vertalign = "bottom";
  } else {
    var_2.x = level.func_7661.func_11761 - 5;
    var_2.y = level.func_7661.func_11762;
    var_2.vertalign = "top";
  }

  var_2.fontscale = 3;
  var_2.horzalign = "left";
  var_2.sort = 1;
  var_2.foreground = 1;
  var_2.hidewheninmenu = 1;
  var_2.alpha = 0.8;
  var_02 setshader("white", 1, 35);
  var_2.color = (0.85, 0.93, 0.92);
  var_02 moveovertime(var_01);
  var_02 fadeovertime(var_01 * 0.5);
  var_2.alpha = 0;
  var_2.x = var_2.x + 300;
  wait 0.4;
  var_02 destroy();
}

func_22FD(var_00) {
  if(var_00 == 0)
    level endon("chyron_faze_out_text_intro");
  else
    level endon("chyron_faze_out_text_gamenotify");

  var_01 = [".", "-", "_", "|", "+"];
  var_02 = 0.7;

  for(var_03 = 0; var_03 < var_1.size; var_3++) {
    var_04 = func_48B3("");
    var_4.fontscale = var_02;
    var_4.alpha = 0;
    var_4.sort = 2;
    var_4.color = (0.75, 0.83, 0.89);
    var_4.func_DAE6 = 0;
    level.func_3F69.func_22FD[level.func_3F69.func_22FD.size] = var_04;
  }

  level.func_3F69.func_22FE = 0;
  thread func_22FC(var_00);
  var_05 = 0;
  var_06 = level.func_3F69.func_11762 - 10;

  for(;;) {
    var_07 = 0;
    var_01 = scripts\engine\utility::array_randomize(var_01);

    foreach(var_04 in level.func_3F69.func_22FD) {
      func_3F6A(var_00, "ui_chyron_plusminus");
      var_4.fontscale = var_02;

      if(var_1[var_07] == "+")
        var_4.fontscale = 0.55;

      var_04 give_zap_perk(var_1[var_07]);
      var_4.x = var_05 + randomint(200);
      var_4.y = var_06 + randomint(60);
      var_4.func_DAE6 = 1;
      var_7++;
      wait(randomfloatrange(0.05, 0.1));
    }

    wait(randomfloatrange(4, 7));
    level.func_3F69.func_22FE = 1;
    level waittill("chyron_artifact_faded");
  }
}

func_22FC(var_00) {
  if(var_00 == 0)
    level endon("chyron_faze_out_text_intro");
  else
    level endon("chyron_faze_out_text_gamenotify");

  var_01 = 0.6;
  var_02 = 1;

  for(;;) {
    if(level.func_3F69.func_22FE)
      var_01 = var_01 - 0.07;
    else {
      if(var_01 < 0.15 || var_01 > 0.6)
        var_02 = var_02 * -1;

      var_01 = var_01 + (0.02 + randomfloat(0.04)) * var_02;
    }

    var_01 = max(var_01, 0);

    foreach(var_04 in level.func_3F69.func_22FD) {
      if(var_4.func_DAE6) {
        if(var_01 == 0) {
          var_4.alpha = 0;
          continue;
        }

        var_4.alpha = randomfloatrange(var_01 * 0.6, var_01);
      }
    }

    if(var_01 == 0) {
      level notify("chyron_artifact_faded");
      var_01 = 0.8;
      level.func_3F69.func_22FE = 0;

      foreach(var_04 in level.func_3F69.func_22FD)
      var_4.func_DAE6 = 0;
    }

    wait 0.05;
  }
}

func_11151(var_00) {
  if(var_00 == 0)
    level endon("chyron_faze_out_text_intro");
  else
    level endon("chyron_faze_out_text_gamenotify");

  var_01 = 5;
  var_02 = 0;
  var_03 = 1;

  for(;;) {
    if(var_00 == 0 && level.func_3F69.func_11152 || var_00 == 1 && level.func_7661.func_11152) {
      wait 0.05;
      continue;
    }

    var_2++;
    var_04 = int(min(var_02, var_01));

    for(var_05 = 0; var_05 < var_04; var_5++) {
      thread func_495C(var_00);
      wait(randomfloatrange(0, 0.1));
    }

    if(var_00 == 0 && level.func_3F69.func_1175D || var_00 == 1 && level.func_7661.func_1175D) {
      wait 0.05;
      continue;
    }

    wait(randomfloatrange(var_03 * 0.5, var_03));
    var_03 = var_03 - 0.05;
    var_03 = max(var_03, 0.2);
  }
}

func_119A5(var_00, var_01) {
  var_02 = func_48B3(var_00);
  level.func_3F69.func_1175E = var_2.x;
  level.func_3F69.func_1175F = var_2.y;
  level.func_3F69.func_1175D = 1;
  wait 0.5;
  level.func_3F69.func_1175D = 0;
  var_03 = func_5F31(var_02, 1);
  var_04 = 4;
  var_3[0] thread location_dupes_thread(var_04);
  var_2.y = var_2.y - 10;
  var_2.glowalpha = 0.05;
  var_2.glowcolor = (0.425, 0.465, 0.46) * vehicle_setspeed();
  var_05 = 0.3;
  var_02 moveovertime(var_05);
  var_02 fadeovertime(var_05 * 3);
  var_2.y = var_2.y + 10;
  var_06 = 0.5;
  var_06 = var_06 - var_05;
  wait(var_05);
  var_02 thread func_DB9D(0);
  wait(var_06);

  if(randomint(100) > 10)
    var_02 thread func_C369(-30, 30, 20, -8, 8, 4);
}

func_C369(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = randomintrange(1, 2);

  for(var_07 = 0; var_07 < var_06; var_7++) {
    var_08 = func_DCB1(var_00, var_01, var_02);
    var_09 = func_DCB1(var_03, var_04, var_05);
    var_10[0] = [var_08, var_09];
    var_10[1] = [var_08 - 10, var_09];
    thread func_915B(var_10);
    wait(randomfloatrange(0.5, 1));
  }
}

func_6BAF(var_00, var_01) {
  var_02 = undefined;

  if(!var_01) {
    var_02 = newhudelem();

    if(var_00 == 0) {
      var_2.x = level.func_3F69.func_11761 + 60;
      var_2.y = level.func_3F69.func_11762 + 30;
      var_2.vertalign = "bottom";
    } else {
      var_2.x = level.func_7661.func_11761 + 60;
      var_2.y = level.func_7661.func_11762 + 10;
      var_2.vertalign = "top";
    }

    var_2.alignx = "center";
    var_2.aligny = "middle";
    var_2.horzalign = "left";
    var_2.sort = 1;
    var_2.foreground = 1;
    var_2.hidewheninmenu = 1;
    var_2.alpha = 0;
    var_02 setshader("white", 1, 60);
    var_2.color = (0.85, 0.93, 0.92);
    var_02 fadeovertime(0.25);
    var_2.alpha = 0.1;
    var_02 scaleovertime(0.1, 2000, 60);
    wait 0.1;
  }

  var_03 = 0.15;
  func_6AA9(var_00, var_03 * 0.4);

  if(!var_01) {
    var_02 fadeovertime(0.25);
    var_2.alpha = 0.2;
    var_2.color = (1, 1, 1);
    var_02 scaleovertime(var_03, 2000, 2);
    wait(var_03);
    var_03 = 0.15;
    var_02 scaleovertime(var_03, 2, 2);
    var_02 thread func_6BB0(var_03);
  }
}

func_6BB0(var_00) {
  self fadeovertime(var_00);
  self.alpha = 0;
  wait(var_00);
  self destroy();
}

func_6AA9(var_00, var_01) {
  if(var_00 == 0) {
    level notify("chyron_faze_out_text_intro");

    foreach(var_03 in level.func_3F69.func_91AF) {
      if(!isDefined(var_03)) {
        continue;
      }
      var_03 thread func_913E(var_01);
    }

    foreach(var_03 in level.func_3F69.func_11151)
    var_03 thread func_913E(var_01);
  } else {
    level notify("chyron_faze_out_text_gamenotify");

    foreach(var_03 in level.func_7661.func_91AF) {
      if(!isDefined(var_03)) {
        continue;
      }
      var_03 thread func_913E(var_01);
    }

    foreach(var_03 in level.func_7661.func_11151)
    var_03 thread func_913E(var_01);
  }
}

func_111A1(var_00, var_01, var_02, var_03, var_04) {
  var_05 = func_48B3(var_00);
  var_5.y = var_5.y + (20 + var_01 * 15);

  if(isDefined(var_02))
    var_5.font = var_02;

  var_5.fontscale = 1;

  if(isDefined(var_03))
    var_5.fontscale = var_03;

  level.func_3F69.func_1175E = var_5.x;
  level.func_3F69.func_1175F = var_5.y;
  level.func_3F69.func_1175D = 1;
  wait 0.5;
  var_5.glowalpha = 0.05;
  var_5.glowcolor = (0.425, 0.465, 0.46) * vehicle_setspeed();
  var_05 thread func_DB9D(0, var_04);
  var_5.alpha = 1;

  if(isDefined(var_04))
    var_5.alpha = var_04;

  var_05 setpulsefx(30, 50000, 700);

  if(randomint(100) > 70)
    var_05 scripts\engine\utility::delaythread(2, ::func_C369, -7, 7, 3, -5, 5, 3);

  level.func_3F69.func_1175D = 0;
  return var_05;
}

vehicle_setspeed() {
  var_00 = 1;

  if(isDefined(level.func_3F69) && level.func_3F69.func_BFE0)
    var_00 = 0.3;

  return var_00;
}

func_915B(var_00) {
  var_01 = self.x;
  var_02 = self.y;

  foreach(var_04 in var_00) {
    self.x = var_01 + var_4[0];
    self.y = var_02 + var_4[1];
    wait(randomfloatrange(0.05, 0.2));
  }

  self.x = var_01;
  self.y = var_02;
}

func_DB9D(var_00, var_01) {
  self endon("death");
  self endon("stop_quick_pulse");

  if(var_00 == 0)
    level endon("chyron_faze_out_text_intro");
  else
    level endon("chyron_faze_out_text_gamenotify");

  if(!isDefined(var_01))
    var_01 = 1;

  for(;;) {
    wait 0.05;
    self.alpha = randomfloatrange(var_01 * 0.7, var_01);
  }
}

location_dupes_thread(var_00, var_01) {
  if(!isDefined(var_01))
    var_01 = 0;

  self endon("death");
  var_02 = self.x;
  var_03 = self.y;
  var_04 = 0.15;

  if(!var_01) {
    self.x = self.x + randomintrange(-30, -10);
    self.y = self.y + randomintrange(10, 20);
    self moveovertime(var_04);
    self.x = var_02;
    self.y = var_03;
    self fadeovertime(var_04);
    self.alpha = 0.1;
    wait(var_04);
  }

  self moveovertime(var_00);
  self.x = self.x + randomintrange(15, 20);
  self.y = self.y + randomintrange(-4, 4);
  wait(var_00);
  var_04 = 0.05;
  self moveovertime(var_04);
  self.x = var_02;
  self.y = var_03;
  wait(var_04);
  self fadeovertime(var_04);
  self.alpha = 0;
}

func_DCB1(var_00, var_01, var_02) {
  var_03 = randomintrange(var_00, var_01);
  var_04 = 1;

  if(var_03 < 0)
    var_04 = -1;

  var_03 = max(abs(var_03), var_02);
  return var_03 * var_04;
}

func_48B3(var_00, var_01, var_02) {
  if(!isDefined(var_01))
    var_01 = level.func_3F69.func_11761;

  if(!isDefined(var_02))
    var_02 = level.func_3F69.func_11762;

  var_03 = newhudelem();
  var_3.x = var_01;
  var_3.y = var_02;
  var_3.horzalign = "left";
  var_3.vertalign = "bottom";
  var_3.aligny = "bottom";
  var_3.sort = 3;
  var_3.foreground = 1;
  var_03 give_zap_perk(var_00);
  var_3.text = var_00;
  var_3.alpha = 0;
  var_3.hidewheninmenu = 1;
  var_3.fontscale = 1.4;

  if(level.console)
    var_3.fontscale = 1.2;

  var_3.color = (0.85, 0.93, 0.92);
  var_3.font = "default";

  if(isDefined(level.func_3F69))
    level.func_3F69.func_91AF[level.func_3F69.func_91AF.size] = var_03;

  return var_03;
}

func_7CBA(var_00) {
  var_01 = spawnStruct();
  var_02 = 0;
  var_03 = 0;
  var_04 = 0;

  if(var_00 == 0) {
    var_05 = -85;
    var_02 = level.func_3F69.func_1175D;
    var_03 = level.func_3F69.func_1175E;
    var_04 = level.func_3F69.func_1175F;
  } else {
    var_05 = 0;
    var_02 = level.func_7661.func_1175D;
    var_03 = level.func_7661.func_1175E;
    var_04 = level.func_7661.func_1175F;
  }

  var_06 = 200;
  var_07 = 60;
  var_1.width = randomintrange(20, var_06);
  var_08 = [5, 10, 15];
  var_1.height = var_8[randomint(var_8.size)];
  var_1.x = randomintrange(0, var_06 - var_1.width);
  var_1.y = var_05 + randomint(var_07 - var_1.height);
  var_1.alpha = randomfloatrange(0.3, 0.7);
  var_1.color = func_7CB9();
  var_1.time = randomfloatrange(0.05, 0.1);

  if(var_02) {
    var_1.x = int(var_03 + randomintrange(-1, 1));
    var_1.y = int(var_04 + randomintrange(0, 7));
    var_1.width = randomintrange(100, var_06);
    var_1.height = randomintrange(10, 15);
    var_1.color = (0.85, 0.93, 0.92) * randomfloatrange(0.2, 0.4);
  }

  return var_01;
}

func_7CB9() {
  var_00 = [];
  var_0[var_0.size] = (0.15, 0.14, 0.22);
  var_0[var_0.size] = (0.09, 0.11, 0.13);
  var_0[var_0.size] = (0.34, 0.22, 0.22);
  var_0[var_0.size] = (0.29, 0.34, 0.22);
  return var_0[randomint(var_0.size)];
}

func_495C(var_00) {
  if(var_00 == 0) {
    level endon("chyron_faze_out_text_intro");

    if(level.func_3F69.func_11151.size < 8) {
      var_01 = newhudelem();
      var_1.func_13438 = 0;
      level.func_3F69.func_11151[level.func_3F69.func_11151.size] = var_01;
    }

    var_02 = undefined;

    foreach(var_04 in level.func_3F69.func_11151) {
      if(var_4.func_13438) {
        continue;
      }
      var_02 = var_04;
    }

    if(!isDefined(var_02)) {
      return;
    }
    var_06 = func_7CBA(var_00);

    if(!level.func_3F69.func_1175D) {
      if(level.func_3F69.func_A917.size > 0 && level.func_3F69.func_A917.size < 3 && randomint(100) > 10) {
        var_07 = level.func_3F69.func_A917[level.func_3F69.func_A917.size - 1];
        var_6.x = var_7.x;
        var_6.y = var_7.y + var_7.height;

        if(scripts\engine\utility::cointoss())
          var_6.y = var_7.y - var_6.height;
      } else
        level.func_3F69.func_A917 = [];

      level.func_3F69.func_A917[level.func_3F69.func_A917.size] = var_02;
    }
  } else {
    level endon("chyron_faze_out_text_gamenotify");

    if(level.func_7661.func_11151.size < 8) {
      var_01 = newhudelem();
      var_1.func_13438 = 0;
      level.func_7661.func_11151[level.func_7661.func_11151.size] = var_01;
    }

    var_02 = undefined;

    foreach(var_04 in level.func_7661.func_11151) {
      if(var_4.func_13438) {
        continue;
      }
      var_02 = var_04;
    }

    if(!isDefined(var_02)) {
      return;
    }
    var_06 = func_7CBA(var_00);

    if(!level.func_7661.func_1175D) {
      if(level.func_7661.func_A917.size > 0 && level.func_7661.func_A917.size < 3 && randomint(100) > 10) {
        var_07 = level.func_7661.func_A917[level.func_7661.func_A917.size - 1];
        var_6.x = var_7.x;
        var_6.y = var_7.y + var_7.height;

        if(scripts\engine\utility::cointoss())
          var_6.y = var_7.y - var_6.height;
      } else
        level.func_7661.func_A917 = [];

      level.func_7661.func_A917[level.func_7661.func_A917.size] = var_02;
    }
  }

  var_2.x = var_6.x;
  var_2.y = var_6.y;
  var_2.width = var_6.width;
  var_2.height = var_6.height;
  var_02 setshader("white", var_6.width, var_6.height);
  var_2.alpha = var_6.alpha;
  var_2.color = var_6.color;

  if(var_2.alpha > 0.6)
    func_3F6A(var_00, "ui_chyron_line_static");

  var_2.horzalign = "left";
  var_2.vertalign = "bottom";

  if(var_00 == 1)
    var_2.vertalign = "top";

  var_2.sort = 1;
  var_2.foreground = 1;
  var_2.hidewheninmenu = 1;
  var_2.func_13438 = 1;
  wait(var_6.time);
  var_2.alpha = 0;
  var_2.func_13438 = 0;
}

func_5F31(var_00, var_01) {
  var_02 = [];

  for(var_03 = 0; var_03 < var_01; var_3++)
    var_2[var_2.size] = func_48B3(var_0.text);

  return var_02;
}

func_7661() {
  level.func_7661 = spawnStruct();
  level.func_7661.active = 0;
  level.func_7661.func_11760 = [];
  level thread func_7660("chyron_message1");
  level thread func_7660("chyron_message2");
  level thread func_7660("chyron_message3");
}

func_7660(var_00) {
  for(;;) {
    _assertdemo(9010);
    _assertdemo(var_00);
    level waittill(var_00, var_01, var_02);
    _assertdemo(9009);
    func_765E(var_01);
  }
}

func_765E(var_00) {
  level.func_7661.func_11760[level.func_7661.func_11760.size] = var_00;

  if(!level.func_7661.active)
    level thread func_7662();
}

func_7664() {
  level.func_7661.active = 1;
  level.func_7661.func_1175D = 0;
  level.func_7661.func_11152 = 0;
  level.func_7661.func_11761 = 6;
  level.func_7661.func_11762 = 10;
  level.func_7661.func_91AF = [];
  level.func_7661.func_11151 = [];
  level.func_7661.func_A917 = [];
  level.func_7661.func_22FD = [];
  level.func_7661.func_10466 = spawn("script_origin", level.player.origin);
  level.func_7661.func_10466 linkto(level.player);
}

func_7663() {
  level.func_7661.func_10466 delete();
  level.func_7661 = spawnStruct();
  level.func_7661.active = 0;
  level.func_7661.func_11760 = [];
}

func_7662() {
  func_7664();
  func_3F6A(1, "ui_chyron_on");
  thread func_11151(1);
  var_00 = 0.4;
  thread func_DB9A(1, var_00);
  wait(var_00);

  for(var_01 = 0; level.func_7661.func_11760.size; level.func_7661.func_11760 = scripts\sp\utility::array_remove_index(level.func_7661.func_11760, 0)) {
    level thread func_765F(level.func_7661.func_11760[0], var_01);
    var_1++;
    wait 0.5;
  }

  level.func_7661.func_1175D = 0;
  wait 1;
  level.func_7661.func_11152 = 1;
  wait 2;
  level.func_7661.func_11152 = 0;
  wait 1;
  func_3F6A(1, "ui_chyron_off");
  func_6BAF(1, 0);

  if(level.func_7661.func_11760.size) {
    level.func_7661.func_10466 delete();
    thread func_7662();
    return;
  }

  func_7663();
}

func_765F(var_00, var_01) {
  var_02 = func_48F3(var_00, var_01);
  level.func_7661.func_1175E = var_2.x;
  level.func_7661.func_1175F = var_2.y;
  level.func_7661.func_1175D = 1;
  var_02 thread func_DB9D(1);
  var_2.alpha = 1;
  var_02 setpulsefx(30, 50000, 700);

  if(randomint(100) < 10)
    var_02 scripts\engine\utility::delaythread(2, ::func_C369, -7, 7, 3, -5, 5, 3);
}

func_48F3(var_00, var_01) {
  var_02 = newhudelem();
  var_2.x = level.func_7661.func_11761;
  var_2.y = level.func_7661.func_11762 + var_01 * 20;
  var_2.horzalign = "left";
  var_2.vertalign = "top";
  var_2.sort = 3;
  var_2.foreground = 1;
  var_02 give_zap_perk(var_00);
  var_2.text = var_00;
  var_2.alpha = 0;
  var_2.hidewheninmenu = 1;
  var_2.font = "default";
  var_2.fontscale = 1.25;

  if(level.console)
    var_2.fontscale = 1;

  var_2.color = (0.85, 0.93, 0.92);
  var_2.glowalpha = 0;
  level.func_7661.func_91AF[level.func_7661.func_91AF.size] = var_02;
  return var_02;
}

func_111A0(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  var_07 = func_48B3(var_00, var_02, var_03);
  var_7.fontscale = 2;
  var_7.horzalign = "subleft";
  var_7.vertalign = "subtop";
  var_7.aligny = "middle";
  var_7.alignx = "center";
  var_7.alpha = 1;
  var_7.sort = 3;

  if(isDefined(var_05))
    var_7.glowcolor = var_05;

  if(!isDefined(var_06))
    var_06 = 20;

  var_07 setpulsefx(var_06, 50000, 700);
  var_08 = [var_07];
  var_09 = func_5F33(var_07, 2);

  foreach(var_11 in var_09) {
    var_11.alpha = 0;
    var_11 thread func_9130(randomfloatrange(0.5, 1.5), randomfloatrange(0.05, 0.2), var_01 - 0.5);
  }

  var_07 thread func_DB9D(0);
  var_08 = scripts\engine\utility::array_combine(var_09, var_08);
  return var_08;
}

func_9130(var_00, var_01, var_02) {
  wait(var_00);
  self.alpha = var_01;
  thread location_dupes_thread(var_02 - 0.5, 1);
}

func_5F33(var_00, var_01) {
  var_02 = [];

  for(var_03 = 0; var_03 < var_01; var_3++) {
    var_04 = newhudelem();
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
    var_04 give_zap_perk(var_0.text);
    var_2[var_2.size] = var_04;
  }

  return var_02;
}

func_1119F(var_00, var_01, var_02, var_03) {
  var_04 = newhudelem();
  var_4.x = var_01;
  var_4.y = var_02 + (var_03 - 1) * 10;
  var_4.alignx = "center";
  var_4.aligny = "middle";
  var_4.horzalign = "subleft";
  var_4.vertalign = "subtop";
  var_4.sort = 1;
  var_4.foreground = 1;
  var_4.hidewheninmenu = 1;
  var_4.alpha = 0;
  var_05 = var_03 * 40 + 20;
  var_04 setshader("white", 1, var_05);
  var_4.color = (0.85, 0.93, 0.92);
  var_04 fadeovertime(0.25);
  var_4.alpha = 0.1;
  var_04 scaleovertime(0.1, 2000, var_05);
  wait 0.1;
  scripts\engine\utility::array_thread(var_00, ::func_913E, 0.1);
  var_06 = 0.15;
  var_04 fadeovertime(0.25);
  var_4.alpha = 0.2;
  var_4.color = (1, 1, 1);
  var_04 scaleovertime(var_06, 2000, 2);
  wait(var_06);
  var_04 scaleovertime(var_06, 2, 2);
  var_04 fadeovertime(var_06);
  var_4.alpha = 0;
  wait(var_06);
  var_04 destroy();
}

func_A03D(var_00) {
  level.player getroundswon(1);
  scripts\sp\hud_util::func_10CCC();
  var_01 = newhudelem();
  level.func_3F2B = spawnStruct();
  wait 1;
  var_02 = func_48C0("left");
  wait 0.1;
  var_03 = func_48C0("right");
  var_3.func_C39F = var_3.x;
  var_03 func_2B9E(2);
  wait 0.2;
  var_04 = func_490F(var_00);
  var_05 = var_4[var_4.size - 1].x;
  var_03 moveovertime(0.2);
  var_3.x = var_05 - 4;
  var_06 = spawnStruct();
  var_6.count = var_4.size;

  foreach(var_08 in var_04)
  var_06 thread func_6AB6(var_08);

  var_06 waittill("fadein_letter_done");
  wait 0.3;
  var_02 thread func_2BA0(3);
  var_03 thread func_2BA0(3);
  wait 2;
  var_02 thread func_2BA1(3);
  var_03 thread func_2BA1(3);
  wait 0.3;
  var_10 = 0.4;
  var_03 moveovertime(var_10);
  var_3.x = var_3.func_C39F;
  var_10 = var_10 / var_4.size;

  for(var_11 = var_4.size - 1; var_11 >= 0; var_11--) {
    var_08 = var_4[var_11];
    var_08 fadeovertime((var_4.size - var_11) * var_10);
    var_8.alpha = 0;
  }

  wait(var_10 + 0.3);
  var_02 thread func_2BA0(3);
  var_03 thread func_2BA0(3);
  wait 1;
  scripts\engine\utility::array_call(var_04, ::destroy);
  var_03 destroy();
  var_02 destroy();
}

func_6AB6(var_00) {
  var_01 = randomfloatrange(0.1, 0.3);
  var_02 = randomfloatrange(0.45, 0.8);
  var_00 func_2B9E(2, 0.2, 0.5, 0.8);

  if(randomint(100) < 30)
    var_00 func_2B9E(2, 0.05, 0.1, 0.8);

  self.count--;

  if(self.count == 0)
    self notify("fadein_letter_done");
}

func_2BA0(var_00, var_01, var_02, var_03) {
  func_2B9E(var_00, var_01, var_02, var_03);

  if(!isDefined(var_01))
    var_01 = 0.05;

  if(!isDefined(var_02))
    var_02 = 0.1;

  var_04 = randomfloatrange(var_01, var_02);
  self fadeovertime(var_04);
  self.alpha = 0;
}

func_2BA1(var_00, var_01, var_02, var_03) {
  func_2B9E(var_00, var_01, var_02, var_03);

  if(!isDefined(var_01))
    var_01 = 0.05;

  if(!isDefined(var_02))
    var_02 = 0.1;

  if(!isDefined(var_03))
    var_03 = 0.8;

  var_04 = randomfloatrange(var_01, var_02);
  self fadeovertime(var_04);
  self.alpha = var_03;
}

func_2B9E(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_01))
    var_01 = 0.05;

  if(!isDefined(var_02))
    var_02 = 0.1;

  if(!isDefined(var_03))
    var_03 = 0.8;

  for(var_04 = 0; var_04 < var_00; var_4++) {
    var_05 = randomfloatrange(var_01, var_02);
    self fadeovertime(var_05);

    if(var_04 % 2)
      var_06 = var_03;
    else
      var_06 = randomfloatrange(0.05, 0.2);

    self.alpha = var_06;
    wait(var_05);
  }

  var_05 = randomfloatrange(var_01, var_02);
  self fadeovertime(var_05);
  self.alpha = var_03;
}

func_490F(var_00) {
  var_01 = [];
  var_02 = undefined;

  for(var_03 = 0; var_03 < var_0.size; var_3++) {
    var_04 = var_0[var_03];
    var_05 = func_490E(var_04);
    var_5.alpha = 0;
    var_06 = 20;

    if(isDefined(var_02)) {
      if(var_2.text == "'")
        var_06 = 10;
      else if(var_2.text == "M")
        var_06 = 24;
      else if(var_2.text == "E")
        var_06 = 18;
      else if(var_2.text == "T")
        var_06 = 18;
      else if(var_2.text == " ")
        var_06 = 14;
    }

    if(isDefined(var_02))
      var_5.x = var_2.x + var_06;

    var_1[var_1.size] = var_05;
    var_02 = var_05;
  }

  return var_01;
}

func_490E(var_00) {
  var_01 = newhudelem();
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
  var_1.text = var_00;
  var_01 give_zap_perk(var_00);
  return var_01;
}

func_48C0(var_00) {
  var_01 = newhudelem();
  var_1.x = 397;
  var_1.y = 400;
  var_1.alignx = "left";
  var_1.aligny = "middle";
  var_1.sort = 1;
  var_1.foreground = 1;
  var_1.hidewheninmenu = 1;
  var_1.alpha = 0.8;
  var_1.func_C377 = var_1.alpha;
  var_1.color = (0.925, 0.933, 0.957);
  var_02 = "chyron_border_" + var_00;
  var_01 setshader(var_02, 22, 22);
  return var_01;
}