/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3000.gsc
***************************************/

func_7561(var_0, var_1, var_2, var_3) {
  scripts\sp\utility::func_75CE();

  if(!isDefined(self.var_7560)) {
    self.var_7560 = [];
  }

  var_4 = spawnStruct();
  var_4.tag = var_1;
  var_4.fx = var_2;
  var_4.on = 0;

  if(!isDefined(var_3)) {
    var_3 = "";
  }

  var_4.state = var_3;

  if(isDefined(self.var_7560[var_0])) {
    self.var_7560[var_0] = ::scripts\engine\utility::array_add(self.var_7560[var_0], var_4);
  } else {
    self.var_7560[var_0] = [var_4];
  }
}

func_7562(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = var_1;
  }

  var_4 = 1;

  while(var_4 < 100) {
    var_5 = var_1 + "_" + var_4;

    if(issubstr(var_1, "00")) {
      var_5 = var_1 + var_4;
    }

    if(scripts\sp\utility::hastag(self.model, var_5)) {
      func_7561(var_0, var_5, var_2, var_3);
      var_4++;
      continue;
    }

    break;
  }
}

func_7564(var_0, var_1, var_2) {
  if(!isDefined(self.var_7560) || !isDefined(self.var_7560[var_0])) {
    return;
  }
  var_3 = 0;

  for(;;) {
    if(!isDefined(self.var_7560[var_0][var_3])) {
      break;
    }
    if(!self.var_7560[var_0][var_3].on == var_1) {
      func_119B9(var_0, var_3, var_1, var_2);
    }

    var_3++;
  }
}

func_7563(var_0, var_1) {
  if(!isDefined(self.var_7560) || !isDefined(self.var_7560[var_0])) {
    return;
  }
  var_2 = 0;

  for(;;) {
    if(!isDefined(self.var_7560[var_0][var_2])) {
      break;
    }
    if(var_1 != self.var_7560[var_0][var_2].state || !self.var_7560[var_0][var_2].on) {
      if(self.var_7560[var_0][var_2].on) {
        func_119B9(var_0, var_2, 0);
      }

      self.var_7560[var_0][var_2].state = var_1;
      func_119B9(var_0, var_2, 1);
    }

    var_2++;
  }
}

func_119B9(var_0, var_1, var_2, var_3) {
  var_4 = self.var_7560[var_0][var_1].fx;

  if(isDefined(self.var_7560[var_0][var_1].state) && self.var_7560[var_0][var_1].state != "") {
    var_4 = var_4 + "_" + self.var_7560[var_0][var_1].state;
  }

  var_5 = self.var_7560[var_0][var_1].tag;

  if(!scripts\sp\utility::hastag(self.model, var_5)) {
    return;
  }
  if(var_2) {
    thread scripts\sp\utility::func_75C4(var_4, var_5);
    self.var_7560[var_0][var_1].on = 1;
  } else {
    if(scripts\engine\utility::is_true(var_3)) {
      thread scripts\sp\utility::func_75A0(var_4, var_5);
    } else {
      thread scripts\sp\utility::func_75F8(var_4, var_5);
    }

    self.var_7560[var_0][var_1].on = 0;
  }
}

func_39D0(var_0, var_1) {
  switch (var_0) {
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

func_39CD(var_0, var_1) {
  switch (var_0) {
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

func_39CE(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  switch (var_0) {
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

func_39CC(var_0) {
  switch (var_0) {
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

func_398C(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(self.var_7482) || !isDefined(self.var_748F)) {
    self show();
    func_0BB6::func_39EE(0);
    func_39D0(var_0);
    func_39CD(var_1);
    func_39CE(var_2);
    func_397E();
    func_39C8();
    thread func_749C();
    return;
  }

  if(!isDefined(var_0)) {
    var_0 = "idle";
  }

  if(!isDefined(var_1)) {
    var_1 = "idle";
  }

  if(!isDefined(var_2)) {
    var_2 = "high";
  }

  var_5 = self.origin;
  var_6 = self.angles;

  if(isDefined(var_3)) {
    var_5 = var_3.origin;
    var_6 = var_3.angles;
  }

  var_7 = scripts\sp\utility::func_10639("ftl_model", var_5, var_6);
  var_8 = self.var_7482 + "_pre";

  if(isDefined(self.var_7483)) {
    var_8 = self.var_7483;
  }

  playFXOnTag(level._effect[var_8], var_7, "tag_ftl_ship_origin");

  if(isDefined(self.var_7475)) {
    wait(self.var_7475);
  } else {
    wait 2;
    var_7 scripts\sp\anim::func_1F35(var_7, "ftl_in");
    wait 0.1;
  }

  if(isDefined(self.var_7499) && isDefined(self.var_749A)) {
    wait(self.var_749A);
    playFXOnTag(level._effect[self.var_7499], var_7, "tag_ftl_ship_origin");
  }

  if(isDefined(self.script_team) && self.script_team == "allies") {
    if(soundexists("capitalship_npc_ally_ftl_in")) {
      if(isDefined(var_3)) {
        var_3 playSound("capitalship_npc_ally_ftl_in");
      } else {
        self playSound("capitalship_npc_ally_ftl_in");
      }
    }
  } else if(soundexists("capitalship_npc_enemy_ftl_in")) {
    if(isDefined(var_3)) {
      var_3 playSound("capitalship_npc_enemy_ftl_in");
    } else {
      self playSound("capitalship_npc_enemy_ftl_in");
    }
  }

  if(isDefined(var_3)) {
    self vehicle_teleport(var_5, var_6);
  }

  self show();
  func_0BB6::func_39EE(0);
  func_39D0(var_0);
  func_39CD(var_1);
  func_39CE(var_2);
  func_397E();
  func_39C8();
  self notify("ftl_show_moment");
  thread func_749C(var_4);
  var_7 thread func_4080(0.7);

  if(isDefined(level._effect[self.var_7482 + "_in"])) {
    playFXOnTag(level._effect[self.var_7482 + "_in"], self, "tag_origin");
  }

  if(isDefined(level._effect[var_8 + "_post"])) {
    playFXOnTag(level._effect[var_8 + "_post"], self, "tag_origin");
  }
}

func_398E(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  var_5 = getent(var_0, "targetname");
  var_6 = var_5 func_3990(var_1, var_2, var_3, var_4);
  return var_6;
}

func_3990(var_0, var_1, var_2, var_3) {
  var_4 = scripts\sp\utility::func_10808();
  var_4 func_39CD("off");
  var_4 func_39D0("off");
  var_4 func_39CE("off");
  var_4 func_0BB6::func_39EE(1);
  var_4 func_397D();
  var_4 func_39C6();
  var_4 hide();
  var_4 func_398C(var_0, var_1, var_2, undefined, var_3);

  if(isDefined(var_4.target) && isDefined(getvehiclenode(var_4.target, "targetname"))) {
    var_4 startpath();
  }

  if(!isDefined(var_4.turrets) || isDefined(var_4.turrets) && var_4.turrets.size == 0) {
    var_4 func_0BB6::func_39E8();
  }

  return var_4;
}

func_3991(var_0) {
  if(!isDefined(self.var_7482) || !isDefined(self.var_748F)) {
    self notify("ftl_out");
    thread func_7491();
    thread func_749C();
    return;
  }

  self notify("ftl_out");
  var_1 = scripts\sp\utility::func_10639("ftl_model", self.origin, self.angles);
  var_1 linkto(self);
  var_2 = self.var_7482 + "_out";
  playFXOnTag(level._effect[var_2], self, "tag_origin");
  wait 3.0;
  self notify("ftl_complete");
  thread func_7491();
  thread func_749C();

  if(!scripts\engine\utility::is_true(var_0)) {
    if(soundexists("capitalship_npc_ally_ftl_out")) {
      self playSound("capitalship_npc_ally_ftl_out");
    }
  }

  var_1 thread func_4080(1);
}

func_7491() {
  if(scripts\engine\utility::is_true(self.var_7479)) {
    _killfxontag(level._effect["vfx_vehicle_mons_warp_out_ftldrive_core"], self, "TAG_ORIGIN");
  }

  func_39CD("off_kill");
  func_39D0("off_kill");
  func_39CE("off_kill");

  if(isDefined(self.var_10381)) {
    foreach(var_1 in self.var_10381) {
      if(isDefined(var_1)) {
        _killfxontag(scripts\engine\utility::getfx(var_1.var_10380), var_1, "tag_origin");
        var_1 delete();
      }
    }
  }

  if(isDefined(self.var_B55A)) {
    self.var_B55A hide();
  }

  func_0BB6::func_39EE(1);
  func_397D();
  func_39C6();
  self hide();
}

func_749C(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(isDefined(self.var_749D)) {
    self[[self.var_749D]]();
  } else {
    earthquake(0.8, 0.5, level.player.origin, 5000);

    if(var_0) {
      return;
    }
    visionsetnaked("ftl_3rd_person_flash", 0.1);
    wait 0.4;

    if(isDefined(level.var_7495)) {
      visionsetnaked(level.var_7495, 0.4);
      return;
    }

    visionsetnaked("", 0.4);
  }
}

func_4080(var_0) {
  wait(var_0);
  self delete();
}

func_398F(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = scripts\sp\utility::func_10808();
  var_2 func_39CD("off");
  var_2 func_39D0("off");
  var_2 func_39CE("off");
  var_2 func_0BB6::func_39EE(0);
  var_2 hide();
  var_2.var_74A6 = 1;

  if(isDefined(var_0)) {
    var_2 scripts\engine\utility::delaythread(var_0, ::func_398D, var_1);
  } else {
    var_2 thread func_398D(var_1);
  }

  return var_2;
}

func_398D(var_0) {
  var_1 = 4000;
  var_2 = 3.0;
  var_3 = anglesToForward(self.angles);

  if(!var_0) {
    self.var_74A8 = scripts\engine\utility::spawn_script_origin();
    self linkto(self.var_74A8);
    self.var_74A8.origin = self.origin + var_3 * var_1 * -1;
  }

  var_4 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);

  if(isDefined(self.script_team) && self.script_team == "allies") {
    if(soundexists("capitalship_npc_ally_ftl_in")) {
      self playSound("capitalship_npc_ally_ftl_in");
    }
  } else if(soundexists("capitalship_npc_enemy_ftl_in"))
    self playSound("capitalship_npc_enemy_ftl_in");

  thread func_749C();
  wait 0.25;
  playFXOnTag(scripts\engine\utility::getfx(self.var_7482 + "_pre"), var_4, "tag_origin");
  wait 0.28;
  self show();
  self.var_74A6 = undefined;
  func_0BB6::func_39EE(0);
  func_39D0("idle");
  func_39CD("heavy");
  scripts\engine\utility::delaythread(0.7, ::func_39CD, "idle");
  func_39CE("high");
  func_397E();
  func_39C8();

  if(!var_0) {
    var_5 = self.origin + var_3 * var_1;
    self.var_74A8 moveto(var_5, var_2, 0.0, var_2);
    var_4 delete();
    wait(var_2);
    self.var_74A8 delete();
    self notify("ftl_complete");
  } else {
    var_4 delete();
    self notify("ftl_complete");
  }
}

func_397F(var_0, var_1) {
  if(!isDefined(self.var_539B) && (var_0 || var_1)) {
    return;
  }
  if(isDefined(var_0) && var_0 && isDefined(self.var_539B[0])) {
    thread func_16C4(self.var_539B[0], 0);
  }

  if(isDefined(var_1) && var_1) {
    if(isDefined(self.var_EF3C) && isDefined(self.var_539B[2])) {
      thread func_16C4(self.var_539B[2], 2);
    } else if(isDefined(self.var_539B[1])) {
      thread func_16C4(self.var_539B[1], 1);
    }
  }
}

func_39AE() {
  if(isDefined(self.var_539A)) {
    thread func_16C4(self.var_539A, 4);
  }
}

func_16C4(var_0, var_1) {
  if(!isDefined(self.var_539C)) {
    self.var_539C = [];
  }

  if(isDefined(self.var_539C[var_1])) {
    return;
  }
  self attach(var_0, "TAG_ORIGIN");
  self.var_539C[var_1] = var_0;
}

func_397C() {
  if(!isDefined(self.var_539C)) {
    return;
  }
  foreach(var_2, var_1 in self.var_539C) {
    self detach(var_1, "TAG_ORIGIN");
    self.var_539C[var_2] = undefined;
  }

  self.var_539C = [];
}

func_397D() {
  self _meth_8184();
}

func_397E() {
  self showallparts();
}

func_39C5() {
  if(!isDefined(self.var_EF3C)) {
    return;
  }
  foreach(var_1 in self.var_EF3C) {
    var_1 delete();
  }
}

func_39C6() {
  if(!isDefined(self.var_EF3C)) {
    return;
  }
  foreach(var_1 in self.var_EF3C) {
    var_1 hide();
  }
}

func_39C8() {
  if(!isDefined(self.var_EF3C)) {
    return;
  }
  foreach(var_1 in self.var_EF3C) {
    var_1 show();
  }
}

func_9B82() {
  if(scripts\engine\utility::is_true(self.var_9B82)) {
    return 1;
  }

  return 0;
}

func_39BB() {
  self notsolid();

  foreach(var_1 in self.var_8B4F) {
    foreach(var_3 in var_1) {
      if(isDefined(var_3) && !_isstruct(var_3)) {
        var_3 notsolid();
      }
    }
  }
}

func_3980() {
  self dontcastshadows();

  if(isDefined(self.var_EF3C)) {
    foreach(var_1 in self.var_EF3C) {
      var_1 dontcastshadows();
    }
  }

  if(isDefined(self.var_539C)) {
    foreach(var_4 in self.var_539C) {
      var_4 dontcastshadows();
    }
  }

  foreach(var_7 in self.var_8B4F) {
    foreach(var_9 in var_7) {
      if(isDefined(var_9) && !_isstruct(var_9)) {
        var_9 dontcastshadows();
      }
    }
  }
}