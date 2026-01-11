/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3000.gsc
***************************************/

func_7561(var_00, var_01, var_02, var_03) {
  scripts\sp\utility::func_75CE();

  if(!isDefined(self.func_7560))
    self.func_7560 = [];

  var_04 = spawnStruct();
  var_4.tag = var_01;
  var_4.fx = var_02;
  var_4.on = 0;

  if(!isDefined(var_03))
    var_03 = "";

  var_4.state = var_03;

  if(isDefined(self.func_7560[var_00]))
    self.func_7560[var_00] = ::scripts\engine\utility::array_add(self.func_7560[var_00], var_04);
  else
    self.func_7560[var_00] = [var_04];
}

func_7562(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_02))
    var_02 = var_01;

  var_04 = 1;

  while(var_04 < 100) {
    var_05 = var_01 + "_" + var_04;

    if(issubstr(var_01, "00"))
      var_05 = var_01 + var_04;

    if(scripts\sp\utility::hastag(self.model, var_05)) {
      func_7561(var_00, var_05, var_02, var_03);
      var_4++;
      continue;
    }

    break;
  }
}

func_7564(var_00, var_01, var_02) {
  if(!isDefined(self.func_7560) || !isDefined(self.func_7560[var_00])) {
    return;
  }
  var_03 = 0;

  for(;;) {
    if(!isDefined(self.func_7560[var_00][var_03])) {
      break;
    }
    if(!self.func_7560[var_00][var_03].on == var_01)
      func_119B9(var_00, var_03, var_01, var_02);

    var_3++;
  }
}

func_7563(var_00, var_01) {
  if(!isDefined(self.func_7560) || !isDefined(self.func_7560[var_00])) {
    return;
  }
  var_02 = 0;

  for(;;) {
    if(!isDefined(self.func_7560[var_00][var_02])) {
      break;
    }
    if(var_01 != self.func_7560[var_00][var_02].state || !self.func_7560[var_00][var_02].on) {
      if(self.func_7560[var_00][var_02].on)
        func_119B9(var_00, var_02, 0);

      self.func_7560[var_00][var_02].state = var_01;
      func_119B9(var_00, var_02, 1);
    }

    var_2++;
  }
}

func_119B9(var_00, var_01, var_02, var_03) {
  var_04 = self.func_7560[var_00][var_01].fx;

  if(isDefined(self.func_7560[var_00][var_01].state) && self.func_7560[var_00][var_01].state != "")
    var_04 = var_04 + "_" + self.func_7560[var_00][var_01].state;

  var_05 = self.func_7560[var_00][var_01].tag;

  if(!scripts\sp\utility::hastag(self.model, var_05)) {
    return;
  }
  if(var_02) {
    thread scripts\sp\utility::func_75C4(var_04, var_05);
    self.func_7560[var_00][var_01].on = 1;
  } else {
    if(scripts\engine\utility::is_true(var_03))
      thread scripts\sp\utility::func_75A0(var_04, var_05);
    else
      thread scripts\sp\utility::func_75F8(var_04, var_05);

    self.func_7560[var_00][var_01].on = 0;
  }
}

func_39D0(var_00, var_01) {
  switch (var_00) {
    case "off_kill":
      func_7564("thrust_vert", 0, 1);
      break;
    case "off":
      func_7564("thrust_vert", 0);
      break;
    case "idle":
      func_7563("thrust_vert", "idle");
      break;
    case "heavy":
      func_7563("thrust_vert", "heavy");
      break;
    case "launch":
      func_7563("thrust_vert", "launch");
      break;
    case "mons_titan_initiate":
      func_7563("thrust_vert", "initiate");
      break;
    case "ph_dust_damaged":
      func_7563("thrust_vert", "damaged");
      break;
    case "hburst":
      func_7563("thrust_vert", "hburst");
      break;
    default:
      break;
  }
}

func_39CD(var_00, var_01) {
  switch (var_00) {
    case "off_kill":
      func_7564("thrust_rear", 0, 1);
      break;
    case "off":
      func_7564("thrust_rear", 0);
      break;
    case "idle":
      func_7563("thrust_rear", "idle");
      break;
    case "idle_light":
      func_7563("thrust_rear", "idle_light");
      break;
    case "heavy":
      func_7563("thrust_rear", "heavy");
      break;
    case "launch":
      func_7563("thrust_rear", "launch");
      break;
    case "burst":
      func_7563("thrust_rear", "burst");
      break;
    default:
      break;
  }
}

func_39CE(var_00) {
  if(!isDefined(var_00)) {
    return;
  }
  switch (var_00) {
    case "off_kill":
      func_7564("light_lod_high", 0, 1);
      break;
    case "off":
      func_7564("light_lod_high", 0);
      break;
    case "low":
      func_7564("light_lod_high", 0);
      break;
    case "med":
      func_7564("light_lod_high", 0);
      break;
    case "high":
      func_7564("light_lod_high", 1);
      break;
    default:
  }
}

func_39CC(var_00) {
  switch (var_00) {
    case "none":
      func_7564("damage_state", 0);
      break;
    case "heavy_fire":
      func_7561("damage_state", "tag_origin", "damage_heavy_fire");
      func_7564("damage_state", 1);
      break;
    default:
  }
}

func_398C(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(self.func_7482) || !isDefined(self.func_748F)) {
    self show();
    func_0BB6::func_39EE(0);
    func_39D0(var_00);
    func_39CD(var_01);
    func_39CE(var_02);
    func_397E();
    func_39C8();
    thread func_749C();
    return;
  }

  if(!isDefined(var_00))
    var_00 = "idle";

  if(!isDefined(var_01))
    var_01 = "idle";

  if(!isDefined(var_02))
    var_02 = "high";

  var_05 = self.origin;
  var_06 = self.angles;

  if(isDefined(var_03)) {
    var_05 = var_3.origin;
    var_06 = var_3.angles;
  }

  var_07 = scripts\sp\utility::func_10639("ftl_model", var_05, var_06);
  var_08 = self.func_7482 + "_pre";

  if(isDefined(self.func_7483))
    var_08 = self.func_7483;

  playFXOnTag(level._effect[var_08], var_07, "tag_ftl_ship_origin");

  if(isDefined(self.func_7475))
    wait(self.func_7475);
  else {
    wait 2;
    var_07 scripts\sp\anim::func_1F35(var_07, "ftl_in");
    wait 0.1;
  }

  if(isDefined(self.func_7499) && isDefined(self.func_749A)) {
    wait(self.func_749A);
    playFXOnTag(level._effect[self.func_7499], var_07, "tag_ftl_ship_origin");
  }

  if(isDefined(self.script_team) && self.script_team == "allies") {
    if(soundexists("capitalship_npc_ally_ftl_in")) {
      if(isDefined(var_03))
        var_03 playSound("capitalship_npc_ally_ftl_in");
      else
        self playSound("capitalship_npc_ally_ftl_in");
    }
  } else if(soundexists("capitalship_npc_enemy_ftl_in")) {
    if(isDefined(var_03))
      var_03 playSound("capitalship_npc_enemy_ftl_in");
    else
      self playSound("capitalship_npc_enemy_ftl_in");
  }

  if(isDefined(var_03))
    self vehicle_teleport(var_05, var_06);

  self show();
  func_0BB6::func_39EE(0);
  func_39D0(var_00);
  func_39CD(var_01);
  func_39CE(var_02);
  func_397E();
  func_39C8();
  self notify("ftl_show_moment");
  thread func_749C(var_04);
  var_07 thread func_4080(0.7);

  if(isDefined(level._effect[self.func_7482 + "_in"]))
    playFXOnTag(level._effect[self.func_7482 + "_in"], self, "tag_origin");

  if(isDefined(level._effect[var_08 + "_post"]))
    playFXOnTag(level._effect[var_08 + "_post"], self, "tag_origin");
}

func_398E(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(var_04))
    var_04 = 0;

  var_05 = getent(var_00, "targetname");
  var_06 = var_05 func_3990(var_01, var_02, var_03, var_04);
  return var_06;
}

func_3990(var_00, var_01, var_02, var_03) {
  var_04 = scripts\sp\utility::func_10808();
  var_04 func_39CD("off");
  var_04 func_39D0("off");
  var_04 func_39CE("off");
  var_04 func_0BB6::func_39EE(1);
  var_04 func_397D();
  var_04 func_39C6();
  var_04 hide();
  var_04 func_398C(var_00, var_01, var_02, undefined, var_03);

  if(isDefined(var_4.target) && isDefined(getvehiclenode(var_4.target, "targetname")))
    var_04 startpath();

  if(!isDefined(var_4.turrets) || isDefined(var_4.turrets) && var_4.turrets.size == 0)
    var_04 func_0BB6::func_39E8();

  return var_04;
}

func_3991(var_00) {
  if(!isDefined(self.func_7482) || !isDefined(self.func_748F)) {
    self notify("ftl_out");
    thread func_7491();
    thread func_749C();
    return;
  }

  self notify("ftl_out");
  var_01 = scripts\sp\utility::func_10639("ftl_model", self.origin, self.angles);
  var_01 linkto(self);
  var_02 = self.func_7482 + "_out";
  playFXOnTag(level._effect[var_02], self, "tag_origin");
  wait 3.0;
  self notify("ftl_complete");
  thread func_7491();
  thread func_749C();

  if(!scripts\engine\utility::is_true(var_00)) {
    if(soundexists("capitalship_npc_ally_ftl_out"))
      self playSound("capitalship_npc_ally_ftl_out");
    else {}
  }

  var_01 thread func_4080(1);
}

func_7491() {
  if(scripts\engine\utility::is_true(self.func_7479))
    _killfxontag(level._effect["vfx_vehicle_mons_warp_out_ftldrive_core"], self, "TAG_ORIGIN");

  func_39CD("off_kill");
  func_39D0("off_kill");
  func_39CE("off_kill");

  if(isDefined(self.func_10381)) {
    foreach(var_01 in self.func_10381) {
      if(isDefined(var_01)) {
        _killfxontag(scripts\engine\utility::getfx(var_1.func_10380), var_01, "tag_origin");
        var_01 delete();
      }
    }
  }

  if(isDefined(self.func_B55A))
    self.func_B55A hide();

  func_0BB6::func_39EE(1);
  func_397D();
  func_39C6();
  self hide();
}

func_749C(var_00) {
  if(!isDefined(var_00))
    var_00 = 0;

  if(isDefined(self.func_749D))
    self[[self.func_749D]]();
  else {
    earthquake(0.8, 0.5, level.player.origin, 5000);

    if(var_00) {
      return;
    }
    visionsetnaked("ftl_3rd_person_flash", 0.1);
    wait 0.4;

    if(isDefined(level.func_7495)) {
      visionsetnaked(level.func_7495, 0.4);
      return;
    }

    visionsetnaked("", 0.4);
  }
}

func_4080(var_00) {
  wait(var_00);
  self delete();
}

func_398F(var_00, var_01) {
  if(!isDefined(var_01))
    var_01 = 0;

  var_02 = scripts\sp\utility::func_10808();
  var_02 func_39CD("off");
  var_02 func_39D0("off");
  var_02 func_39CE("off");
  var_02 func_0BB6::func_39EE(0);
  var_02 hide();
  var_2.func_74A6 = 1;

  if(isDefined(var_00))
    var_02 scripts\engine\utility::delaythread(var_00, ::func_398D, var_01);
  else
    var_02 thread func_398D(var_01);

  return var_02;
}

func_398D(var_00) {
  var_01 = 4000;
  var_02 = 3.0;
  var_03 = anglesToForward(self.angles);

  if(!var_00) {
    self.func_74A8 = scripts\engine\utility::spawn_script_origin();
    self linkto(self.func_74A8);
    self.func_74A8.origin = self.origin + var_03 * var_01 * -1;
  }

  var_04 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);

  if(isDefined(self.script_team) && self.script_team == "allies") {
    if(soundexists("capitalship_npc_ally_ftl_in"))
      self playSound("capitalship_npc_ally_ftl_in");
  } else if(soundexists("capitalship_npc_enemy_ftl_in"))
    self playSound("capitalship_npc_enemy_ftl_in");

  thread func_749C();
  wait 0.25;
  playFXOnTag(scripts\engine\utility::getfx(self.func_7482 + "_pre"), var_04, "tag_origin");
  wait 0.28;
  self show();
  self.func_74A6 = undefined;
  func_0BB6::func_39EE(0);
  func_39D0("idle");
  func_39CD("heavy");
  scripts\engine\utility::delaythread(0.7, ::func_39CD, "idle");
  func_39CE("high");
  func_397E();
  func_39C8();

  if(!var_00) {
    var_05 = self.origin + var_03 * var_01;
    self.func_74A8 moveto(var_05, var_02, 0.0, var_02);
    var_04 delete();
    wait(var_02);
    self.func_74A8 delete();
    self notify("ftl_complete");
  } else {
    var_04 delete();
    self notify("ftl_complete");
  }
}

func_397F(var_00, var_01) {
  if(!isDefined(self.func_539B) && (var_00 || var_01)) {
    return;
  }
  if(isDefined(var_00) && var_00 && isDefined(self.func_539B[0]))
    thread func_16C4(self.func_539B[0], 0);

  if(isDefined(var_01) && var_01) {
    if(isDefined(self.func_EF3C) && isDefined(self.func_539B[2]))
      thread func_16C4(self.func_539B[2], 2);
    else if(isDefined(self.func_539B[1]))
      thread func_16C4(self.func_539B[1], 1);
  }
}

func_39AE() {
  if(isDefined(self.func_539A))
    thread func_16C4(self.func_539A, 4);
}

func_16C4(var_00, var_01) {
  if(!isDefined(self.func_539C))
    self.func_539C = [];

  if(isDefined(self.func_539C[var_01])) {
    return;
  }
  self attach(var_00, "TAG_ORIGIN");
  self.func_539C[var_01] = var_00;
}

func_397C() {
  if(!isDefined(self.func_539C)) {
    return;
  }
  foreach(var_02, var_01 in self.func_539C) {
    self detach(var_01, "TAG_ORIGIN");
    self.func_539C[var_02] = undefined;
  }

  self.func_539C = [];
}

func_397D() {
  self _meth_8184();
}

func_397E() {
  self showallparts();
}

func_39C5() {
  if(!isDefined(self.func_EF3C)) {
    return;
  }
  foreach(var_01 in self.func_EF3C)
  var_01 delete();
}

func_39C6() {
  if(!isDefined(self.func_EF3C)) {
    return;
  }
  foreach(var_01 in self.func_EF3C)
  var_01 hide();
}

func_39C8() {
  if(!isDefined(self.func_EF3C)) {
    return;
  }
  foreach(var_01 in self.func_EF3C)
  var_01 show();
}

func_9B82() {
  if(scripts\engine\utility::is_true(self.func_9B82))
    return 1;

  return 0;
}

func_39BB() {
  self notsolid();

  foreach(var_01 in self.func_8B4F) {
    foreach(var_03 in var_01) {
      if(isDefined(var_03) && !_isstruct(var_03))
        var_03 notsolid();
    }
  }
}

func_3980() {
  self dontcastshadows();

  if(isDefined(self.func_EF3C)) {
    foreach(var_01 in self.func_EF3C)
    var_01 dontcastshadows();
  }

  if(isDefined(self.func_539C)) {
    foreach(var_04 in self.func_539C)
    var_04 dontcastshadows();
  }

  foreach(var_07 in self.func_8B4F) {
    foreach(var_09 in var_07) {
      if(isDefined(var_09) && !_isstruct(var_09))
        var_09 dontcastshadows();
    }
  }
}