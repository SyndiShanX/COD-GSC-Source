/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_54110734a7546551.gsc
*************************************************/

#using script_4b7698942d6f679a;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\hud_util;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\starts;
#using scripts\sp\statemachine;
#using scripts\sp\utility;
#namespace namespace_5835e6bd7a65b960;

function rappel_init() {
  setdvarifuninitialized(@ "hash_b24b76a70747f097", 0);
  setdvarifuninitialized(@ "hash_bd718329e2d1b5ca", 0);
}

function function_7c7d840719489953(var_81efc2bbfbf0442) {
  level.var_2d68df56a7dae25 = spawn_script_origin();
  level.var_2d68df56a7dae25 function_f0a2a1c924655499();
  level.player setcinematicmotionoverride("disabled");
  level.var_2d68df56a7dae25 thread function_63baad3b21b11b84(var_81efc2bbfbf0442);
}

function function_63baad3b21b11b84(var_81efc2bbfbf0442) {
  statearray = [["walking", &function_518bcff7ba89e178, &function_2687917d9bf702b7, &function_e42d7c146fa89096], ["player_death", &function_217d0d2ba695a5ea], ["delete", &rappel_delete], ["breach", &function_45f560ad90c3224d]];
  self.var_b1d2c4ac5adf1819 = getStructArray("rappel_anchor", "targetname");
  self.var_901f4ddf4c2dfb9f = undefined;
  self.playerforward = undefined;
  self.var_49a3d1504c9a5a7a = undefined;
  self.var_f0b2812c9ef48b1f = 1;
  self.var_f779d88903f20956 = 0;
  self.var_6004a25f18a72f0f = 1;
  self.var_aa123dc36994ce91 = 0;
  self.var_34adfdcdc640eb54 = [];
  self.var_6d7c459cbc01de21 = getEnt("window_entry", "targetname");
  setdvarifuninitialized(@ "hash_4dceb3e3532c8798", 180);
  self.var_726a393889051432 = newhudelem();
  self.var_726a393889051432.x = 320;
  self.var_726a393889051432.y = 350;
  self.var_726a393889051432.alignx = "center";
  self.var_726a393889051432.aligny = "middle";
  self.var_726a393889051432.sort = 1;
  self.var_726a393889051432.foreground = 1;
  self.var_726a393889051432.hidewheninmenu = 1;
  self.var_726a393889051432.alpha = 0;
  self.var_726a393889051432.fontscale = 1;
  self.var_726a393889051432.font = "objective";
  self.var_726a393889051432 settext(&"PLATFORM/MANTLE");
  self.var_b3a3db58f1578aa8 = getEntArray("safe_detach_region", "script_noteworthy");

  if(!isDefined(level.rappel_contents)) {
    content = ["physicscontents_edge", "physicscontents_glass", "physicscontents_water", "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicleclip", "physicscontents_itemclip", "physicscontents_clipshot", "physicscontents_characterproxy", "physicscontents_playerclip", "physicscontents_vehicle"];
    level.rappel_contents = physics_createcontents(content);
  }

  self.var_85567cc807666622 = 0;
  self.var_99cc2e08b2c8c37a = 0;
  self.var_cbb381d8f90c7471 = 0;
  self.var_dd06e6da3e8bcf5b = undefined;
  self.var_6ec81e1cd3335240 = undefined;
  self.var_3c6979d84eebd0fe = 0;
  self.var_7efdad0e8863716d = 0;
  self.var_ff5a83ecd2e90e62 = (0, 0, 0);
  self.var_98a8ca39ce2c139a = 0;
  self.currentvelocity = (0, 0, 0);
  self.states = statearray;
}

function function_3512d347bbdea2e9(anchor) {
  self.var_901f4ddf4c2dfb9f = anchor;
  self.var_5a0e0ad2a986b149 = anchor.origin[2] - anchor.min_z;
  self.var_d06b0563b96bd8eb = squared(self.var_5a0e0ad2a986b149);
  level notify("rappel_started");
  level.player allowprone(0);
  level.player allowsprint(0);
  level.player allowcrouch(0);
  level.player setstance("stand");
  self.rig function_be1ae05b7d09ca6c();
  self.rig show();
  self.toeup = 0;
  self.var_fd4cf7feb508d576 = 0;
  self.var_cd5a5f166cdb20fd = 0;

  if(self.var_901f4ddf4c2dfb9f.script_noteworthy == "toe_up") {
    self.toeup = 1;
  } else {
    self.toeup = 0;
  }

  self dontinterpolate();
  self.origin = self.rig.origin;
  self.angles = anchor.angles;
  self.rig dontinterpolate();
  self.rig.angles = self.angles;
  self.rig linkTo(self, "", (0, 0, 0), (0, 0, 0));
  waitframe();

  if(getdvarint(@ "hash_b24b76a70747f097")) {
    thread draw_ent_axis_forever();
  }

  setdvarifuninitialized(@ "hash_9b470d6dc86be173", 75);
  fov = getdvarfloat(@ "hash_9b470d6dc86be173");
  var_a3a4a7a4b42be6ad = anglesToForward(self.var_901f4ddf4c2dfb9f.angles);
  var_4186fee053eb71cd = anglestoup(self.var_901f4ddf4c2dfb9f.angles);
  var_561a423658fe1322 = anglestoright(self.var_901f4ddf4c2dfb9f.angles);
  self.var_b1b63ca2ea201b75 = vectortoangles(var_4186fee053eb71cd);
  self.var_8f41ede8a6b4d224 = vectortoangles(var_561a423658fe1322 * -1);
  self.wallnormal = var_4186fee053eb71cd;
  self.playerforward = var_a3a4a7a4b42be6ad;
  addangles = (80, 0, 0);
  function_c04871918f6f852f(addangles);
  function_43351586bf34dfb2(anchor.angles);
  level.var_2d68df56a7dae25 function_246dab869b35e1b3();
  level.var_2d68df56a7dae25 function_e004a7ce3cc5cea3();
  thread input_init();
  self.var_a3a4a7a4b42be6ad = var_a3a4a7a4b42be6ad;
  self.var_4186fee053eb71cd = var_4186fee053eb71cd;
  self.var_561a423658fe1322 = var_561a423658fe1322;
  self.var_f88c1366d46f77e0 = anchor.angles;
  self.var_726a393889051432.alpha = 0;
  self.var_602b3e3ea8438f2e = 0;
  self.var_b3be37f4e23a2362 = self.var_901f4ddf4c2dfb9f.origin;
  self.var_80661e2342308520 = self.var_901f4ddf4c2dfb9f.origin;
  self.var_8066212342308bb9 = self.var_901f4ddf4c2dfb9f.origin + anglestoup(var_4186fee053eb71cd) * 300;
  level.player.var_5d845f5108d98419 = &function_ed34d75820b69de6;

  if(self.toeup) {
    self.rig function_bfba35f28cc0844d("up");
  } else {
    self.rig function_bfba35f28cc0844d("down");
  }

  thread function_9f3dd4832f5530c4();
  begin_fsm(self.states, "walking");
}

function function_557cdb8e7b253cf8(anchor) {
  self.var_901f4ddf4c2dfb9f = anchor;
  self.var_5a0e0ad2a986b149 = anchor.origin[2] - anchor.min_z;
  self.var_d06b0563b96bd8eb = squared(self.var_5a0e0ad2a986b149);
  level notify("rappel_started");
  level.player allowprone(0);
  level.player allowsprint(0);
  level.player allowcrouch(0);
  level.player setstance("stand");
  self.rig function_be1ae05b7d09ca6c();
  self.rig show();
  self.toeup = 0;
  self.var_fd4cf7feb508d576 = 0;
  self.var_cd5a5f166cdb20fd = 0;

  if(self.var_901f4ddf4c2dfb9f.script_noteworthy == "toe_up") {
    self.toeup = 1;
  } else {
    self.toeup = 0;
  }

  self dontinterpolate();
  self.origin = self.rig.origin;
  self.angles = anchor.angles;
  self.rig dontinterpolate();
  self.rig.angles = self.angles;
  self.rig linkTo(self, "", (0, 0, 0), (0, 0, 0));
  waitframe();

  if(getdvarint(@ "hash_b24b76a70747f097")) {
    thread draw_ent_axis_forever();
  }

  setdvarifuninitialized(@ "hash_9b470d6dc86be173", 75);
  fov = getdvarfloat(@ "hash_9b470d6dc86be173");
  var_a3a4a7a4b42be6ad = anglesToForward(self.var_901f4ddf4c2dfb9f.angles);
  var_4186fee053eb71cd = anglestoup(self.var_901f4ddf4c2dfb9f.angles);
  var_561a423658fe1322 = anglestoright(self.var_901f4ddf4c2dfb9f.angles);
  self.var_b1b63ca2ea201b75 = vectortoangles(var_4186fee053eb71cd);
  self.var_8f41ede8a6b4d224 = vectortoangles(var_561a423658fe1322 * -1);
  self.wallnormal = var_4186fee053eb71cd;
  self.playerforward = var_a3a4a7a4b42be6ad;
  addangles = (80, 0, 0);
  function_c04871918f6f852f(addangles);
  function_43351586bf34dfb2(anchor.angles);
  level.var_2d68df56a7dae25 function_246dab869b35e1b3();
  level.var_2d68df56a7dae25 function_e004a7ce3cc5cea3();
  thread input_init();
  self.var_a3a4a7a4b42be6ad = var_a3a4a7a4b42be6ad;
  self.var_4186fee053eb71cd = var_4186fee053eb71cd;
  self.var_561a423658fe1322 = var_561a423658fe1322;
  self.var_f88c1366d46f77e0 = anchor.angles;
  self.var_726a393889051432.alpha = 0;
  self.var_602b3e3ea8438f2e = 0;
  self.var_b3be37f4e23a2362 = self.var_901f4ddf4c2dfb9f.origin;
  self.var_80661e2342308520 = self.var_901f4ddf4c2dfb9f.origin;
  self.var_8066212342308bb9 = self.var_901f4ddf4c2dfb9f.origin + anglestoup(var_4186fee053eb71cd) * 300;
  level.player.var_5d845f5108d98419 = &function_ed34d75820b69de6;

  if(self.toeup) {
    self.rig function_bfba35f28cc0844d("up");
  } else {
    self.rig function_bfba35f28cc0844d("down");
  }

  thread function_9f3dd4832f5530c4();
  begin_fsm(self.states, "walking");
  waitframe();
  function_1be052d58f788667();
}

function function_518bcff7ba89e178() {
  self.var_7b4782edb6cbc048 = 1;
}

function function_2687917d9bf702b7() {
  if(istrue(self.var_860cf18185dc9b2e)) {
    return;
  }

  if(!isDefined(self.var_bc485412426034de)) {
    self.var_bc485412426034de = 0;
    self.nextswitchtime = 2000;
  }

  if(self.var_7b4782edb6cbc048) {
    if(level.player.button_pressed["jump_pressed"]) {
      rappel_jump();
      return;
    } else if(self.nextswitchtime < gettime() && level.player.button_pressed["stance_pressed"]) {
      function_1be052d58f788667();
      return;
    }
  }

  function_c6941300903df2e7();

  if(self.var_1213b7b8bf2ccd0a == (0, 0, 0)) {
    self.var_602b3e3ea8438f2e = 0;
    function_16d1f1d0149bbc79(self.origin);
    return;
  }

  if(self.var_602b3e3ea8438f2e < 1) {
    self.var_602b3e3ea8438f2e += 0.1;
    self.var_602b3e3ea8438f2e = min(self.var_602b3e3ea8438f2e, 1);
  }

  self.var_1213b7b8bf2ccd0a *= self.var_602b3e3ea8438f2e;
  var_f18bbc38e052346c = self.var_1213b7b8bf2ccd0a * 3.5;

  if(length(var_f18bbc38e052346c) > 3.5) {
    dir = vectorNormalize(var_f18bbc38e052346c);
    var_f18bbc38e052346c = dir * 3.5;
  }

  if(level.player sprintbuttonPressed()) {
    desiredposition = self.origin + var_f18bbc38e052346c * 2;
  } else {
    desiredposition = self.origin + var_f18bbc38e052346c;
  }

  var_10227e7aa7d0df6e = distancesquared(desiredposition, self.var_901f4ddf4c2dfb9f.origin);

  if(var_10227e7aa7d0df6e > self.var_d06b0563b96bd8eb) {
    var_bec37858599761da = pointonsegmentnearesttopoint(self.var_80661e2342308520, self.var_8066212342308bb9, desiredposition);

    if(distancesquared(desiredposition, var_bec37858599761da) > self.var_d06b0563b96bd8eb) {
      desiredposition = var_bec37858599761da + vectorNormalize(desiredposition - var_bec37858599761da) * self.var_5a0e0ad2a986b149;
    }
  }

  tracestart = desiredposition + self.wallnormal * 27;
  traceend = desiredposition + self.wallnormal * -39;
  walltrace = sphere_trace(tracestart, traceend, 15, level.player, level.rappel_contents);

  if(walltrace["fraction"] == 0) {
    var_e3eddf6241953a23 = vectorcross(walltrace["normal"], self.var_d93f1ea18c55b731["up"]);
    dist = vectordot(desiredposition - self.origin, var_e3eddf6241953a23);
    desiredposition = self.origin + var_e3eddf6241953a23 * dist;
    tracestart = desiredposition + self.wallnormal * 12;
    traceend = desiredposition + self.wallnormal * -24;
    walltrace = sphere_trace(tracestart, traceend, 15, level.player, level.rappel_contents);

    if(walltrace["fraction"] == 0) {
      return;
    }

    desiredposition = walltrace["shape_position"];
  } else {
    desiredposition = walltrace["shape_position"];
  }

  groundtrace = ray_trace(desiredposition, desiredposition + self.wallnormal * -15, level.player, level.rappel_contents);
  desiredposition = groundtrace["position"];
  function_16d1f1d0149bbc79(desiredposition);
  self.origin = desiredposition;
}

function function_16d1f1d0149bbc79(pos) {
  function_96e8908605c86308(pos);
  function_e33df51f6e4b0642();
}

function function_1be052d58f788667() {
  level.player endon("death");
  level.player lerpviewangleclamp(0.4, 0.2, 0.2, 95, 95, 60, 30);
  viewangles = combineangles(level.player.groundrefent.angles, level.player getplayerangles());
  forward = anglesToForward(viewangles);
  right = anglestoright(self.angles);
  dot = vectordot(right, forward);

  if(dot > 0) {
    turnright = 1;
  } else {
    turnright = 0;
  }

  anims = function_5aa77ff515b2cb3c(turnright);
  anime = anims["body"];
  gesture = anims["gesture"];
  self.rig function_11845bd49184469a();
  self.rig function_31209c7c5b780c89();
  self.rig unlink();
  level.player allowads(0);
  level.player allowreload(0);
  gestureplayed = level.player forceplaygestureviewmodel(gesture, undefined, 0.2, undefined, 1);
  anim_single_solo(self.rig, anime);
  level.player allowads(1);
  level.player allowreload(1);
  self.rig thread function_db4bb2b5db7e7cf1();
  self.rig.state = "turn";
  self.angles = combineangles(self.angles, (0, 180, 0));
  self.rig linkTo(self);
  function_43351586bf34dfb2(self.angles);
  self.nextswitchtime = gettime() + 2000;
  self.toeup = !self.toeup;

  if(self.toeup) {
    self.rig function_bfba35f28cc0844d("up");
  } else {
    self.rig function_bfba35f28cc0844d("down");
  }

  self.rig function_4aa4a54a278b4c08(self.toeup);
  function_74a9602a19d02a8a();
  level.player notify("rappel_switch");
}

function function_5aa77ff515b2cb3c(turnright) {
  if(turnright) {
    if(self.toeup) {
      anime = "toeup_turnright";
      gesture = "iw9_ges_rappel_turn_r_tu";
    } else {
      anime = "toedown_turnright";
      gesture = "iw9_ges_rappel_turn_r_td";
    }
  } else if(self.toeup) {
    anime = "toeup_turnleft";
    gesture = "iw9_ges_rappel_turn_l_tu";
  } else {
    anime = "toedown_turnleft";
    gesture = "iw9_ges_rappel_turn_l_td";
  }

  anims = [];
  anims["body"] = anime;
  anims["gesture"] = gesture;
  return anims;
}

function function_43351586bf34dfb2(angles) {
  self.moveangles = angles;
  self.var_d93f1ea18c55b731 = anglestoaxis(angles);
}

function function_c6941300903df2e7() {
  var_ff99c4fde1caa810 = level.player getnormalizedmovement(0.2, 0.1);
  var_bd837da502678594 = var_ff99c4fde1caa810[0];
  var_df78441a978e79e3 = var_ff99c4fde1caa810[1];

  if(getdvarint(@ "hash_b24b76a70747f097")) {
    playerangles = combineangles(self.moveangles, level.player getplayerangles(1));
    playerforward = anglesToForward(playerangles);
    line(self.origin, self.origin + playerforward * 5);
  }

  if(var_bd837da502678594 == 0 && var_df78441a978e79e3 == 0) {
    self.var_1213b7b8bf2ccd0a = (0, 0, 0);
    return;
  }

  playerangles = combineangles(self.moveangles, level.player getplayerangles(1));
  playerforward = anglesToForward(playerangles);
  playerright = anglestoright(playerangles);
  movementvector = playerforward * var_bd837da502678594 + playerright * var_df78441a978e79e3;
  self.var_1213b7b8bf2ccd0a = movementvector;
}

function rappel_jump() {
  level.player endon("death");
  self endon("death");
  self.var_7b4782edb6cbc048 = 0;
  time = 0.05;
  var_1da502d0ac9e2225 = 6000;
  down = self.wallnormal * -1;
  var_851285556739a2d9 = 0.5 * var_1da502d0ac9e2225 * squared(time);
  var_2ad583c8daddf071 = down * var_851285556739a2d9;
  var_d6bf386d1f2d121d = 2400;
  gravity = 0.5 * var_d6bf386d1f2d121d * squared(time);
  var_c36952c47dec21d9 = (0, 0, -1) * gravity;
  var_df3275f8f1380a4a = 100;
  trajectory = self.wallnormal * var_df3275f8f1380a4a;
  pos = undefined;
  var_27b8ba22c234bea4 = 5;
  self.rig.state = "jump";
  self.rig thread function_c4ebaaaeea14bd49(self.toeup);

  while(true) {
    function_c6941300903df2e7();
    var_393455d40a089205 = time * trajectory + self.var_1213b7b8bf2ccd0a * 2.2;
    var_27b8ba22c234bea4--;

    if(var_27b8ba22c234bea4 < 0) {
      start = self.origin + self.wallnormal * 16;
      end = self.origin + var_393455d40a089205;
      walltrace = sphere_trace(start, end, 15, level.player, level.rappel_contents);

      if(walltrace["fraction"] == 0) {
        start = self.origin + self.wallnormal * 50;
        end = self.origin + self.wallnormal * -100;
        walltrace = sphere_trace(start, end, 15, level.player, level.rappel_contents);
        pos = walltrace["shape_position"];
        break;
      }
    }

    self.origin += var_393455d40a089205 + var_c36952c47dec21d9;
    function_e33df51f6e4b0642();
    waitframe();
    trajectory += var_2ad583c8daddf071;
  }

  self.rig.state = "jump_land";
  self.origin = pos;
  self.rig function_38781b6e7a61f82b(self.toeup);
  self.var_7b4782edb6cbc048 = 1;
}

function function_e42d7c146fa89096() {
  self.var_726a393889051432.alpha = 0;
}

function function_ed34d75820b69de6() {
  level.var_2d68df56a7dae25 goto_state("player_death");
  level waittill("rappel_player_death_done");
}

function function_217d0d2ba695a5ea() {
  viewangles = combineangles(level.player.groundrefent.angles, level.player getplayerangles());
  tempent = spawn_script_origin(level.player.origin, viewangles);
  level.player playersetgroundreferenceent(undefined);
  level.player playerlinktoabsolute(tempent, "");
  fall_time = 2;
  vel = level.var_2d68df56a7dae25.var_4186fee053eb71cd * 100 + level.var_2d68df56a7dae25.currentvelocity;
  tempent movegravity(vel, fall_time + 1);
  level.player forceplaygestureviewmodel("vm_death_fire_01", undefined, 0.15, undefined, 1, 1);
  fall_halftime = fall_time * 0.5;
  wait fall_halftime;
  thread scripts\sp\hud_util::fade_out(fall_halftime);
  wait fall_halftime;
  level notify("rappel_player_death_done");
}

function function_b16c600950bf7b3f(origin, angles, color) {
  forward = anglesToForward(angles);
  end = origin + forward * 100;
  line(origin, end, color, 1, 0, 10000);
}

function input_init() {
  level.player.button_pressed["stance_pressed"] = 0;
  level.player.button_pressed["jump_pressed"] = 0;

  foreach(_ in level.player.button_pressed) {
    thread function_4839feba8501ea14(key);
  }
}

function function_4839feba8501ea14(msg) {
  self endon("death");
  level.player endon("death");
  level.player endon("stop_rappel_button_pressed");

  while(true) {
    level.player waittill(msg);
    level.player.button_pressed[msg] = 1;
    waitframe();
    waittillframeend();
    level.player.button_pressed[msg] = 0;
  }
}

function input_cleanup() {
  level.player notify("stop_rappel_button_pressed");
  level.player.button_pressed = undefined;
}

function function_ecf63a220d11561f(state) {
  goto_state(state);
}

function rappel_delete() {
  level.player.var_5d845f5108d98419 = undefined;

  if(isDefined(self.rope)) {
    self.rope delete();
  }

  if(isDefined(self.rig)) {
    if(isDefined(self.rig.playerlinkent)) {
      self.rig.playerlinkent delete();
    }

    if(isDefined(self.rig.var_e44dfd16357e0909)) {
      self.rig.var_e44dfd16357e0909 delete();
    }

    self.rig delete();
  }

  if(isDefined(self.groundrefent)) {
    level.player playersetgroundreferenceent(undefined);
    self.groundrefent delete();
  }

  self delete();
}

function function_f0a2a1c924655499() {
  rig = spawn_anim_model("player_rappel_rig", self.origin);
  rig.angles = self.angles;
  rig dontcastshadows();
  rig.origin = self.origin;
  rig linkTo(self, "", (0, 0, 0), (0, 0, 0));
  rig.state = "ready_to_idle";
  rig.var_83918575d24f54ea = "none";
  rig.prevspeed = 0;
  rig.prevyaw = 0;
  self.rig = rig;
  thread function_4fea809b18da0a25();
}

function function_4fea809b18da0a25() {
  while(true) {
    if(getunarchiveddebugdvar(@ "hash_bd718329e2d1b5ca") == "<dev string:x1c>") {
      function_8146b3cc915c65a4();
    }

    waitframe();
  }
}

function function_bc1dd8a02e7bedcb() {
  return level.var_2d68df56a7dae25.rig;
}

function function_a4163572d280c17d() {
  self setModel(getmodel("player_rig"));
}

function function_be1ae05b7d09ca6c() {
  self setModel(getmodel("player_rappel_rig"));
}

#using_animtree("player_rappel_rig");

function function_96e8908605c86308(neworigin) {
  if(!isDefined(self.rig)) {
    return;
  }

  rig = self.rig;

  if(self.rig.state == "jump") {
    return;
  }

  delta = neworigin - self.origin;
  speed = length(delta);

  if(speed == 0) {
    if(rig.state != "idle") {
      rig.state = "idle";
      rig function_11845bd49184469a();
      animation = function_88ce414a7143caa8();
      rig setanimknoball(animation, %root, 1, 0.2);
    }

    rig.prevyaw = 0;
    rig.prevspeed = 0;
    return;
  }

  if(rig.state != "walking") {
    rig.state = "walking";
    rig setanim(rig.var_fc35334980e50360, 1, 0.2);
    rig function_31209c7c5b780c89();
  }

  vec = rotatevectorinverted(delta, self.moveangles);
  yaw = angleclamp180(vectortoangles(vec)[1]);
  yaw = rig.prevyaw + (yaw - rig.prevyaw) * 0.5;
  rig setcustomnodegameparameter("yaw", yaw);
  rig setcustomnodegameparameter("speed", speed * 20);
  rig.prevyaw = yaw;
  rig.prevspeed = speed;
}

function function_9f3dd4832f5530c4() {
  level.player endon("death");
  self endon("death");
  self endon("stop_rig_twist");
  var_ecbbdfd012f53d98 = % twr_global_rappel_td_twist_l;
  var_e57ccdd72b78bc4f = % twr_global_rappel_td_twist_r;
  var_5041e2447a41e42f = % twr_global_rappel_tu_twist_l;
  var_eafdd6f791ed5fc2 = % twr_global_rappel_tu_twist_r;
  var_fffa5e625a3093f8 = % upper_torso_twist_left;
  var_f329174993fa8e75 = % upper_torso_twist_right;
  var_c8b125d3ca691307 = 0.826352;
  rig = self.rig;
  rig setanimlimited(var_5041e2447a41e42f, 1, 0.2);
  rig setanimlimited(var_eafdd6f791ed5fc2, 1, 0.2);
  rig setanimlimited(var_ecbbdfd012f53d98, 1, 0.2);
  rig setanimlimited(var_e57ccdd72b78bc4f, 1, 0.2);
  var_de8d73723bb9a415 = -1;

  while(true) {
    viewangles = combineangles(level.player.groundrefent.angles, level.player getplayerangles());
    forward = anglesToForward(viewangles);
    right = anglestoright(self.angles);
    dot = vectordot(right, forward);
    weight = abs(dot / var_c8b125d3ca691307);
    weight = clamp(weight, 0, 1);

    if(var_de8d73723bb9a415 != self.toeup) {
      if(self.toeup) {
        rig setanimlimited(var_5041e2447a41e42f, 1, 1);
        rig setanimlimited(var_eafdd6f791ed5fc2, 1, 1);
        rig setanimlimited(var_ecbbdfd012f53d98, 0, 1);
        rig setanimlimited(var_e57ccdd72b78bc4f, 0, 1);
      } else {
        rig setanimlimited(var_5041e2447a41e42f, 0, 1);
        rig setanimlimited(var_eafdd6f791ed5fc2, 0, 1);
        rig setanimlimited(var_ecbbdfd012f53d98, 1, 1);
        rig setanimlimited(var_e57ccdd72b78bc4f, 1, 1);
      }

      var_de8d73723bb9a415 = self.toeup;
    }

    if(dot > 0) {
      rig setanimlimited(var_fffa5e625a3093f8, 0, 0.1, 1);
      rig setanimlimited(var_f329174993fa8e75, weight, 0.1, 1);
    } else {
      rig setanimlimited(var_f329174993fa8e75, 0, 0.1, 1);
      rig setanimlimited(var_fffa5e625a3093f8, weight, 0.1, 1);
    }

    waitframe();
  }
}

function function_88ce414a7143caa8() {
  if(self.toeup) {
    array = level.scr_anim[self.rig.animname]["toeup_idle"];
  } else {
    array = level.scr_anim[self.rig.animname]["toedown_idle"];
  }

  return array[randomint(array.size)];
}

function function_c4ebaaaeea14bd49(toeup) {
  self endon("death");
  level.player endon("death");

  if(self.var_83918575d24f54ea == "jumping") {
    return;
  }

  function_31209c7c5b780c89();
  function_11845bd49184469a();
  self.var_83918575d24f54ea = "jumping";

  if(toeup) {
    anime = "toeup_jump";
  } else {
    anime = "toedown_jump";
  }

  self setanim(getanim(anime), 1, 0.2);
  time = getanimlength(getanim(anime));
  wait time - 0.2;
  self clearanim(getanim(anime), 0.2);

  if(toeup) {
    anime = "toeup_jump_inair";
  } else {
    anime = "toedown_jump_inair";
  }

  self setanim(getanim(anime), 1, 0.2);
}

function function_38781b6e7a61f82b(toeup) {
  level.player endon("death");

  if(self.var_83918575d24f54ea == "landing") {
    return;
  }

  self.var_83918575d24f54ea = "landing";

  if(toeup) {
    anime = "toeup_jump_inair";
  } else {
    anime = "toedown_jump_inair";
  }

  self clearanim(getanim(anime), 0.2);

  if(toeup) {
    anime = "toeup_jump_land";
  } else {
    anime = "toedown_jump_land";
  }

  self setanim(getanim(anime), 1, 0.2);
  time = getanimlength(getanim(anime));
  wait time - 0.2;
  self clearanim(getanim(anime), 0.2);
  self.var_83918575d24f54ea = "none";
  self.state = "jumping_done";
}

function function_bfba35f28cc0844d(direction) {
  if(direction == "up") {
    self.var_fc35334980e50360 = % rappel_move_up;
    return;
  }

  if(direction == "down") {
    self.var_fc35334980e50360 = % rappel_move_down;
  }
}

function function_11845bd49184469a() {
  self setanim(%rappel_move_up, 0, 0.2);
  self setanim(%rappel_move_down, 0, 0.2);
}

function function_31209c7c5b780c89() {
  self setanim(%rappel_idles, 0, 0.2);
}

function function_db4bb2b5db7e7cf1() {
  waitframe();
  animation = getanim("toeup_turnleft");
  self setanim(animation, 0, 0.2);
  animation = getanim("toeup_turnright");
  self setanim(animation, 0, 0.2);
  animation = getanim("toedown_turnleft");
  self setanim(animation, 0, 0.2);
  animation = getanim("toedown_turnright");
  self setanim(animation, 0, 0.2);
}

function function_2dab66226d4341b() {
  self setanim(%upper_torso_twist_left, 0, 0.2);
  self setanim(%upper_torso_twist_right, 0, 0.2);
}

function function_74a9602a19d02a8a() {
  if(self.toeup) {
    self.rope show();
    self.rig.var_e44dfd16357e0909 hide();
    return;
  }

  self.rope hide();
  self.rig.var_e44dfd16357e0909 show();
}

function function_8146b3cc915c65a4() {
  if(isDefined(self.rig)) {
    self.rig function_c34abf6c97a13070("<dev string:x1e>", "<dev string:x29>");

    if(isDefined(self.groundrefent)) {
      line(self.rig.origin, self.groundrefent.origin, (0.5, 0.5, 0.5), 0.5);
      self.groundrefent function_c34abf6c97a13070("<dev string:x1e>", "<dev string:x34>");
    }

    if(isDefined(self.rig.playerlinkent)) {
      line(self.rig.playerlinkent.origin, self.groundrefent.origin, (0.5, 0.5, 0.5), 0.5);
      self.rig.playerlinkent function_c34abf6c97a13070("<dev string:x1e>", "<dev string:x4e>");
    }
  }
}

function function_c34abf6c97a13070(tag, label, color) {
  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  if(tag == "tag_origin") {
    origin = self.origin;
    angles = self.angles;
  } else {
    origin = self gettagorigin(tag);
    angles = self gettagangles(tag);
  }

  print3d(origin, label, color, 0.7, 0.1);

  draw_axis(origin, angles);
}

function draw_axis(origin, angles) {
  axis = anglestoaxis(angles);
  forward = anglesToForward(angles);
  right = anglestoright(angles);
  up = anglestoup(angles);
  range = 5;
  line(origin, origin + axis["<dev string:x5c>"] * range, (1, 0, 0), 1);
  line(origin, origin + axis["<dev string:x64>"] * range, (0, 1, 0), 1);
  line(origin, origin + axis["<dev string:x6a>"] * range, (0, 0, 1), 1);
}

function function_246dab869b35e1b3() {
  rope = spawn("script_model", self.var_901f4ddf4c2dfb9f.origin);
  rope notsolid();
  rope setModel("misc_rapelling_rope_sim_fiber_long");

  if(!self.toeup) {
    rope hide();
  }

  self.rope = rope;
}

function function_e33df51f6e4b0642() {
  if(!isDefined(self.rope)) {
    return;
  }

  rope = self.rope;
  waittillframeend();
  up = anglestoup(self.rig.angles);
  pos = self.origin + up * 30;
  rope.angles = vectortoangles(pos - rope.origin);
}

function function_e004a7ce3cc5cea3() {
  rig = self.rig;
  rig.var_e44dfd16357e0909 = spawn_anim_model("dangling_rope", rig.origin);
  rig.var_e44dfd16357e0909 notsolid();
  rig.var_e44dfd16357e0909 linkTo(rig, "TAG_ACCESSORY_LEFT", (0, 0, 0), (0, 0, 0));

  if(self.toeup) {
    rig.var_e44dfd16357e0909 hide();
  }
}

function function_c04871918f6f852f(angleoffset) {
  rig = self.rig;

  if(isDefined(level.player.groundrefent)) {
    ent = level.player.groundrefent;
    ent unlink();
  } else {
    ent = spawn_script_origin(level.player.origin);
  }

  tagorigin = rig gettagorigin("tag_player");
  tagangles = rig gettagangles("tag_player");
  up = anglestoup(tagangles);
  ent.origin = tagorigin + up * 60;
  ent.angles = combineangles(tagangles, angleoffset);
  up = anglestoup(ent.angles);
  origin = ent.origin + up * -60;
  playerlinkent = spawn_script_origin(origin, ent.angles);
  playerlinkent linkTo(ent);
  ent linkTo(self.rig, "tag_player");
  rig.playerlinkent = playerlinkent;
  self.groundrefent = ent;
  level.player.groundrefent = ent;
  level.player playersetgroundreferenceent(ent);
  waitframe();
  array = function_2630d4fb6c685672(self.toeup);
  level.player playerlinktodelta(playerlinkent, "", 1, array[0], array[1], array[2], array[3]);
}

function function_12fdc6e3aed7e824() {
  while(true) {
    axis = anglestoaxis(self.angles);
    duration = 1;
    scale = 10;
    line(self.origin, self.origin + axis["<dev string:x5c>"] * scale, (1, 0, 0), 1, 0, duration);
    line(self.origin, self.origin + axis["<dev string:x64>"] * scale, (0, 1, 0), 1, 0, duration);
    line(self.origin, self.origin + axis["<dev string:x6a>"] * scale, (0, 0, 1), 1, 0, duration);
    waitframe();
  }
}

function function_2630d4fb6c685672(var_90db8de11f53ccea) {
  array = [];

  if(var_90db8de11f53ccea) {
    array[0] = 95;
    array[1] = 95;
    array[2] = 80;
    array[3] = 40;
  } else {
    array[0] = 95;
    array[1] = 95;
    array[2] = 80;
    array[3] = 30;
  }

  return array;
}

function function_4aa4a54a278b4c08(var_90db8de11f53ccea, time) {
  if(!isDefined(time)) {
    time = 0.5;
  }

  array = function_2630d4fb6c685672(var_90db8de11f53ccea);

  if(var_90db8de11f53ccea) {
    level.player lerpviewangleclamp(time, 0.2, 0.2, array[0], array[1], array[2], array[3]);
    return;
  }

  level.player lerpviewangleclamp(time, 0.2, 0.2, array[0], array[1], array[2], array[3]);
}

function rappel_breach(node) {
  level.var_2d68df56a7dae25.var_e6a5c3c74728b8 = node;
  level.var_2d68df56a7dae25 function_ecf63a220d11561f("breach");
}

function function_45f560ad90c3224d() {
  level.player disableweapons();
  level.player allowmelee(0);
  level.player allowfire(0);
  level.player allowads(0);
  level.player allowstand(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  node = self.var_e6a5c3c74728b8;
  origin = getstartorigin(node.origin, node.angles, self.rig getanim("breach_swing"));
  self notify("stop_rig_twist");
  self.rig function_2dab66226d4341b();
  thread function_631bda4c092cbca8(origin);
  gravity = 300;
  movetime = 1.5;

  if(!self.toeup) {
    gravity = 300;
    movetime = 2;
  }

  var_613b8a724cf6bdde = level.var_2d68df56a7dae25.wallnormal * -1;
  velocity = function_1eec3ee5febd09cb(origin, movetime, gravity, var_613b8a724cf6bdde);
  level.player.groundrefent rotatetolinked((10, 0, 0), 1);
  level.player lerpviewangleclamp(1, 0.25, 0.25, 30, 30, 20, 20);
  scripted_movegravity(velocity, movetime, gravity, var_613b8a724cf6bdde);
  thread function_7d9d96a901c790b8();
  self.rig unlink();
  node anim_single_solo(self.rig, "breach_swing");
  level.player enableweapons();
  level.player allowmelee(1);
  level.player allowfire(1);
  level.player allowads(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowstand(1);
  level.player allowsprint(1);
  level.player enableoffhandweapons();
  function_ecf63a220d11561f("delete");
}

function function_631bda4c092cbca8(landorigin) {
  self endon("death");
  level.player endon("death");
  rig = self.rig;
  rig function_31209c7c5b780c89();
  rig function_11845bd49184469a();

  if(self.toeup) {
    anime = "toeup_jump";
  } else {
    right = anglestoright(self.moveangles);
    normal = vectorNormalize(landorigin - self.origin);
    dot = vectordot(normal, right);

    if(dot > 0) {
      anime = "toedown_breach_jump_right";
    } else {
      anime = "toedown_breach_jump_left";
    }
  }

  anim_single_solo(self.rig, anime);
  anime = "toeup_jump_inair";
  self.rig setanim(self.rig getanim(anime), 1, 0.2);
}

function function_7d9d96a901c790b8() {
  var_c0019a9457edb4fd = level.player.groundrefent;
  tag = "tag_camera";
  tagorigin = self.rig gettagorigin(tag);
  tagangles = self.rig gettagorigin(tag);
  ent = spawn_script_origin(tagorigin, tagangles);
  var_c0019a9457edb4fd rotatetolinked((-80, 0, 0), 1);
  ent linkTo(self.rig, tag, (0, 0, 0), (0, 0, 0));
  level.player playersetgroundreferenceent(ent);
  time = 1;
  level.player lerpviewangleclamp(time, time * 0.25, time * 0.25, 0, 0, 0, 0);
  level.player.groundrefent = ent;
}

function function_1eec3ee5febd09cb(end, movetime, gravity, var_613b8a724cf6bdde) {
  delta = end - self.origin;
  drop = 0.5 * gravity * squared(movetime);
  drop *= var_613b8a724cf6bdde;
  vel = (delta - drop) / movetime;
  return vel;
}

function scripted_movegravity(velocity, movetime, gravity, var_613b8a724cf6bdde) {
  trajectory = velocity;
  starttime = gettime();
  start = self.origin;
  endtime = gettime() + movetime * 1000;

  while(gettime() < endtime) {
    deltatime = (gettime() - starttime) * 0.001;
    var_6dace08f2345d65c = var_613b8a724cf6bdde * 0.5 * gravity * squared(deltatime);
    self.origin = start + deltatime * trajectory + var_6dace08f2345d65c;
    waitframe();
  }
}

function function_748561bc08229435() {
  anime = "rappel_exit_up";
  var_ef630df77a557c8e = spawn_anim_model("player_rig", self.origin);
  animation = var_ef630df77a557c8e getanim("rappel_exit_up");
  thread anim_single_solo(var_ef630df77a557c8e, anime);
  waitframe();
  var_ef630df77a557c8e setanimtime(animation, 0.25);
  var_ef630df77a557c8e setanimrate(animation, 0);
  return var_ef630df77a557c8e;
}