/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\crib.gsc
*********************************************/

init() {
  precacheshellshock("frag_grenade_mp");
  func_DBDE();
  func_DBE3();
  func_1338C();
  player_init();
}

func_DBDE() {
  func_BF26("main", "player_view1_start", "player_view1_end");
  var_0 = func_BF25("main", "Primary Weapon", "radial_weapons_primary", ::func_157D);
  var_1 = func_BF25("main", "Secondary Weapon", "radial_weapons_secondary", ::func_157E);
  var_2 = func_BF25("main", "Gears", "radial_gears", ::func_1578);
  var_3 = func_BF25("main", "Kill Streaks", "radial_killstreaks", ::func_1579);
  var_4 = func_BF25("main", "Leaderboards", "radial_leaderboards", ::func_157A);
  func_BF26("gears", "player_view2_start", "player_view2_end");
  func_BF26("weapons_primary", "player_view3_start", "player_view3_end");
  func_BF26("weapons_secondary", "player_view3_start", "player_view3_end");
  func_BF26("killstreak", "player_view4_start", "player_view4_end");
  func_BF26("leaderboards", "player_view5_start", "player_view5_end");
}

func_DBE3() {
  foreach(var_1 in level.var_DBDF) {
    func_10417(var_1);
    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      if(isDefined(var_1[var_2 + 1])) {
        var_3 = func_7FB4(var_1[var_2].var_D69A, var_1[var_2 + 1].var_D69A);
        var_1[var_2].var_62A6 = var_3;
        var_1[var_2 + 1].var_10BA0 = var_3;
        continue;
      }

      var_3 = func_7FB4(var_1[var_2].var_D69A, var_1[0].var_D69A) + 180;
      if(var_3 > 360) {
        var_3 = var_3 - 360;
      }

      var_1[var_2].var_62A6 = var_3;
      var_1[0].var_10BA0 = var_3;
    }
  }

  thread func_12F12();
  thread func_13B36();
  thread func_139A7();
  thread func_4F2A();
}

func_4F2A() {
  level endon("game_ended");
  level.var_4A6B = 1;
  for(;;) {
    if(!isDefined(level.var_C2C8)) {
      wait(0.05);
      continue;
    }

    var_0 = 1;
    while(!level.var_C2C8 buttonpressed("BUTTON_Y")) {
      wait(0.05);
    }

    level.var_C2C8 playSound("mouse_click");
    if(var_0) {
      level.var_4A6B = level.var_4A6B * -1;
      var_0 = 0;
    }

    while(level.var_C2C8 buttonpressed("BUTTON_Y")) {
      wait(0.05);
    }
  }
}

player_init() {
  level thread onplayerconnect();
  level thread func_E459();
}

func_E459() {
  level waittill("game_ended");
  setdvar("cg_draw2d", 1);
}

onplayerconnect() {
  level waittill("connected", var_0);
  var_0 thread func_DD78();
  var_0 waittill("spawned_player");
  wait(1);
  var_0 takeallweapons();
  setdvar("cg_draw2d", 0);
  if(!isDefined(var_0)) {
    return;
  } else {
    level.var_C2C8 = var_0;
  }

  var_0 thread func_7C17();
  func_13FC9("main");
}

func_DD78() {
  self endon("disconnect");
  var_0 = "autoassign";
  while(!isDefined(self.pers["team"])) {
    wait(0.05);
  }

  self notify("menuresponse", game["menu_team"], var_0);
  wait(0.5);
  var_1 = getarraykeys(level.classmap);
  var_2 = [];
  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(!issubstr(var_1[var_3], "custom")) {
      var_2[var_2.size] = var_1[var_3];
    }
  }

  for(;;) {
    var_4 = var_2[0];
    self notify("menuresponse", "changeclass", var_4);
    self waittill("spawned_player");
    wait(0.1);
  }
}

func_7C17() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    var_0 = self getnormalizedmovement();
    var_1 = vectortoangles(var_0);
    level.var_E77B = int(var_1[1]);
    wait(0.05);
  }
}

func_BF26(var_0, var_1, var_2) {
  if(isDefined(level.var_DBDF) && level.var_DBDF.size) {}

  var_3 = getent(var_2, "targetname");
  var_4 = vectornormalize(anglesToForward(var_3.angles)) * 40;
  level.var_DBDF[var_0] = [];
  level.radial_button_group[var_0]["view_start"] = var_1;
  level.radial_button_group[var_0]["view_pos"] = var_3.origin + var_4;
  level.radial_button_group[var_0]["player_view_pos"] = var_3.origin;
  level.radial_button_group[var_0]["view_angles"] = var_3.angles;
}

func_BF25(var_0, var_1, var_2, var_3) {
  var_4 = getent(var_2, "targetname");
  var_5 = disableweaponpickup(var_0, var_4);
  var_6 = spawnStruct();
  var_6.pos = var_4.origin;
  var_6.label = var_1;
  var_6.var_724E = 1;
  var_6.var_724D = (0.5, 0.5, 1);
  var_6.var_D69A = var_5;
  var_6.var_1577 = var_3;
  var_6.var_DC07 = 8;
  level.var_DBDF[var_0][level.var_DBDF[var_0].size] = var_6;
  return var_6;
}

func_12F12() {
  level endon("game_ended");
  for(;;) {
    if(!isDefined(level.var_DBDD)) {
      wait(0.05);
      continue;
    }

    var_0 = level.var_1622;
    foreach(var_2 in level.var_DBDF[level.var_DBDD]) {
      if(func_9E4E(var_2.var_10BA0, var_2.var_62A6)) {
        level.var_1622 = var_2;
        continue;
      }

      var_2.var_724D = (0.5, 0.5, 1);
    }

    if(isDefined(level.var_1622)) {
      level.var_1622.var_724D = (1, 1, 0.5);
      if(isDefined(var_0) && var_0 != level.var_1622) {
        level.var_C2C8 playSound("mouse_over");
      }
    }

    wait(0.05);
  }
}

func_13B36() {
  level endon("game_ended");
  for(;;) {
    if(!isDefined(level.var_C2C8)) {
      wait(0.05);
      continue;
    }

    var_0 = 1;
    while(!level.var_C2C8 buttonpressed("BUTTON_A")) {
      wait(0.05);
    }

    level.var_C2C8 playSound("mouse_click");
    if(isDefined(level.var_1622) && var_0) {
      level.var_1622 notify("select_button_pressed");
      [[level.var_1622.var_1577]]();
      var_0 = 0;
    }

    while(level.var_C2C8 buttonpressed("BUTTON_A")) {
      wait(0.05);
    }
  }
}

func_139A7() {
  level endon("game_ended");
  for(;;) {
    if(!isDefined(level.var_C2C8)) {
      wait(0.05);
      continue;
    }

    var_0 = 1;
    while(!level.var_C2C8 buttonpressed("BUTTON_X")) {
      wait(0.05);
    }

    level.var_C2C8 playSound("mouse_click");
    if(var_0) {
      func_1576();
      var_0 = 0;
    }

    while(level.var_C2C8 buttonpressed("BUTTON_X")) {
      wait(0.05);
    }
  }
}

func_10417(var_0) {
  for(var_1 = 0; var_1 < var_0.size - 1; var_1++) {
    for(var_2 = 0; var_2 < var_0.size - 1 - var_1; var_2++) {
      if(var_0[var_2 + 1].var_D69A < var_0[var_2].var_D69A) {
        button_sound(var_0[var_2], var_0[var_2 + 1]);
      }
    }
  }
}

button_sound(var_0, var_1) {
  var_2 = var_0.pos;
  var_3 = var_0.label;
  var_4 = var_0.var_D69A;
  var_5 = var_0.var_1577;
  var_6 = var_0.var_DC07;
  var_0.pos = var_1.pos;
  var_0.label = var_1.label;
  var_0.var_D69A = var_1.var_D69A;
  var_0.var_1577 = var_1.var_1577;
  var_0.var_DC07 = var_1.var_DC07;
  var_1.pos = var_2;
  var_1.label = var_3;
  var_1.var_D69A = var_4;
  var_1.var_1577 = var_5;
  var_1.var_DC07 = var_6;
}

func_5B5C(var_0) {
  foreach(var_2 in level.var_DBDF[var_0]) {
    var_2 thread func_5B5B(var_0);
  }
}

func_5B5B(var_0) {
  level endon("game_ended");
  self endon("remove_button");
  var_1 = level.radial_button_group[var_0]["view_pos"];
  var_2 = var_1 + func_DBDA(self.var_D69A, 4);
  for(;;) {
    var_3 = (1, 0, 0);
    if(func_9E4E(self.var_10BA0, self.var_62A6)) {
      var_3 = (1, 1, 0);
    }

    if(isDefined(level.var_4A6B) && level.var_4A6B > 0) {
      var_4 = var_1 + func_DBDA(level.var_E77B, 2);
    }

    wait(0.05);
  }
}

func_13FC9(var_0, var_1) {
  level.var_1622 = undefined;
  if(isDefined(level.var_DBDD) && level.var_DBDD != "") {
    level.var_DBE1 = level.var_DBDD;
  } else {
    level.var_DBE1 = "main";
    level.var_DBDD = "main";
  }

  foreach(var_3 in level.var_DBDF[level.var_DBE1]) {
    var_3 notify("remove_button");
  }

  if(isDefined(var_1) && var_1) {
    level.var_C2C8 func_83FD(level.radial_button_group[level.var_DBE1]["view_start"], var_0);
  } else {
    level.var_C2C8 func_83FC(level.radial_button_group[var_0]["view_start"]);
  }

  level thread func_5B5C(var_0);
  level.var_DBDD = var_0;
}

disableweaponpickup(var_0, var_1) {
  var_2 = level.radial_button_group[var_0]["view_angles"];
  var_3 = level.radial_button_group[var_0]["view_pos"];
  var_3 = var_3 + vectornormalize(anglesToForward(var_2)) * 40;
  var_4 = anglesToForward(var_2);
  var_5 = vectornormalize(anglestoup(var_2));
  var_6 = var_1.angles;
  var_7 = var_1.origin;
  var_8 = vectornormalize(vectorfromlinetopoint(var_3, var_3 + var_4, var_7));
  var_9 = acos(vectordot(var_8, var_5));
  if(vectordot(anglestoright(var_2), var_8) < 0) {
    var_9 = 360 - var_9;
  }

  return var_9;
}

func_DBDA(var_0, var_1) {
  var_2 = (270 - var_0, 0, 0);
  var_3 = anglesToForward(var_2);
  var_4 = vectornormalize(var_3);
  var_5 = var_4 * var_1;
  return var_5;
}

func_7FB4(var_0, var_1) {
  var_2 = var_0 + var_1 + 720 / 2 - 360;
  return var_2;
}

func_9E4E(var_0, var_1) {
  var_2 = level.var_E77B > var_0 && level.var_E77B < 360;
  var_3 = level.var_E77B > 0 && level.var_E77B < var_1;
  if(var_0 > var_1) {
    var_4 = var_2 || var_3;
  } else {
    var_4 = level.var_E77B > var_1 && level.var_E77B < var_2;
  }

  return var_4;
}

func_1576() {
  if(isDefined(level.var_DBDD) && level.var_DBDD != "main") {
    func_13FC9("main", 1);
    return;
  }
}

func_157D() {
  iprintlnbold("action_weapons_primary");
  func_13FC9("weapons_primary");
}

func_157E() {
  iprintlnbold("action_weapons_secondary");
  func_13FC9("weapons_secondary");
}

func_1578() {
  iprintlnbold("action_gears");
  func_13FC9("gears");
}

func_1579() {
  iprintlnbold("action_killstreak");
  func_13FC9("killstreak");
}

func_157A() {
  iprintlnbold("action_leaderboards");
  func_13FC9("leaderboards");
}

func_1338C() {
  level.var_1338D = [];
  func_31AD("player_view1_start");
  func_31AD("player_view2_start");
  func_31AD("player_view3_start");
  func_31AD("player_view4_start");
  func_31AD("player_view5_start");
}

func_31AD(var_0) {
  level.var_1338D[var_0] = [];
  var_1 = getent(var_0, "targetname");
  level.var_1338D[var_0][level.var_1338D[var_0].size] = var_1;
  while(isDefined(var_1) && isDefined(var_1.target)) {
    var_2 = getent(var_1.target, "targetname");
    level.var_1338D[var_0][level.var_1338D[var_0].size] = var_2;
    var_1 = var_2;
  }
}

func_83FC(var_0) {
  if(!isDefined(level.var_5F21)) {
    var_1 = level.var_1338D[var_0][0];
    level.var_5F21 = spawn("script_model", var_1.origin);
    level.var_5F21.angles = var_1.angles;
    self setorigin(level.var_5F21.origin - (0, 0, 65));
    self linkto(level.var_5F21);
    wait(0.05);
    self setplayerangles(level.var_5F21.angles);
    thread func_7284();
  }

  var_2 = 1;
  var_3 = abs(distance(level.var_5F21.origin, level.var_1338D[var_0][level.var_1338D[var_0].size - 1].origin));
  var_2 = var_2 * var_3 / 1200;
  var_2 = max(var_2, 0.1);
  var_4 = var_2;
  if(!1) {
    var_4 = var_4 * var_2 * level.var_1338D[var_0].size + 1;
  }

  thread func_2BD8(3, var_4);
  foreach(var_7, var_6 in level.var_1338D[var_0]) {
    if(1) {
      if(var_7 != level.var_1338D[var_0].size - 1) {
        continue;
      }
    }

    level.var_5F21 moveto(var_6.origin, var_2, var_2 * 0.5, 0);
    level.var_5F21 rotateto(var_6.angles, var_2, var_2 * 0.5, 0);
    wait(var_2);
  }
}

func_83FD(var_0, var_1) {
  var_2 = 1;
  var_3 = abs(distance(level.var_5F21.origin, level.radial_button_group[var_1]["player_view_pos"]));
  var_2 = var_2 * var_3 / 1200;
  var_2 = max(var_2, 0.1);
  var_4 = var_2;
  if(!1) {
    var_4 = var_4 * var_2 * level.var_1338D[var_0].size + 1;
  }

  thread func_2BD8(3, var_4);
  if(!1) {
    for(var_5 = level.var_1338D[var_0].size - 1; var_5 >= 0; var_5--) {
      var_6 = level.var_1338D[var_0][var_5];
      level.var_5F21 moveto(var_6.origin, var_2);
      level.var_5F21 rotateto(var_6.angles, var_2);
      wait(var_2);
    }
  }

  thread func_2BD8(3, var_2);
  var_7 = level.radial_button_group[var_1]["player_view_pos"];
  var_8 = level.radial_button_group[var_1]["view_angles"];
  level.var_5F21 moveto(var_7, var_2, var_2 * 0.5, 0);
  level.var_5F21 rotateto(var_8, var_2, var_2 * 0.5, 0);
  wait(var_2);
}

func_126C0(var_0) {
  self setblurforplayer(20, var_0 + 0.2 / 2);
  self setblurforplayer(0, var_0 + 0.2 / 2);
  self shellshock("frag_grenade_mp", var_0 + 0.2);
}

func_2BD8(var_0, var_1) {
  var_2 = int(var_1 / 0.05);
  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = var_3 / var_2;
    var_5 = sin(180 * var_4);
    var_6 = var_0 * var_5;
    setdvar("r_blur", var_6);
    wait(0.05);
  }

  setdvar("r_blur", 0);
}

func_7284() {
  level endon("game_ended");
  self endon("disconnect");
  level.var_5F21 endon("remove_dummy");
  for(;;) {
    self setplayerangles(level.var_5F21.angles);
    wait(0.05);
  }
}