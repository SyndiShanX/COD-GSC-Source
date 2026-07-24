/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3000.gsc
**************************************/

_id_7561(var_0, var_1, var_2, var_3) {
  scripts\sp\utility::_id_75CE();

  if(!isDefined(self._id_7560))
    self._id_7560 = [];

  var_4 = spawnStruct();
  var_4.tag = var_1;
  var_4.fx = var_2;
  var_4.on = 0;

  if(!isDefined(var_3))
    var_3 = "";

  var_4.state = var_3;

  if(isDefined(self._id_7560[var_0]))
    self._id_7560[var_0] = scripts\engine\utility::array_add(self._id_7560[var_0], var_4);
  else
    self._id_7560[var_0] = [var_4];
}

_id_7562(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = var_1;

  var_4 = 1;

  while(var_4 < 100) {
    var_5 = var_1 + "_" + var_4;

    if(issubstr(var_1, "00"))
      var_5 = var_1 + var_4;

    if(scripts\sp\utility::hastag(self.model, var_5)) {
      _id_7561(var_0, var_5, var_2, var_3);
      var_4++;
      continue;
    }

    break;
  }
}

_id_7564(var_0, var_1, var_2) {
  if(!isDefined(self._id_7560) || !isDefined(self._id_7560[var_0])) {
    return;
  }
  var_3 = 0;

  for(;;) {
    if(!isDefined(self._id_7560[var_0][var_3])) {
      break;
    }

    if(!self._id_7560[var_0][var_3].on == var_1)
      _id_119B9(var_0, var_3, var_1, var_2);

    var_3++;
  }
}

_id_7563(var_0, var_1) {
  if(!isDefined(self._id_7560) || !isDefined(self._id_7560[var_0])) {
    return;
  }
  var_2 = 0;

  for(;;) {
    if(!isDefined(self._id_7560[var_0][var_2])) {
      break;
    }

    if(var_1 != self._id_7560[var_0][var_2].state || !self._id_7560[var_0][var_2].on) {
      if(self._id_7560[var_0][var_2].on)
        _id_119B9(var_0, var_2, 0);

      self._id_7560[var_0][var_2].state = var_1;
      _id_119B9(var_0, var_2, 1);
    }

    var_2++;
  }
}

_id_119B9(var_0, var_1, var_2, var_3) {
  var_4 = self._id_7560[var_0][var_1].fx;

  if(isDefined(self._id_7560[var_0][var_1].state) && self._id_7560[var_0][var_1].state != "")
    var_4 = var_4 + "_" + self._id_7560[var_0][var_1].state;

  var_5 = self._id_7560[var_0][var_1].tag;

  if(!scripts\sp\utility::hastag(self.model, var_5)) {
    return;
  }
  if(var_2) {
    thread scripts\sp\utility::_id_75C4(var_4, var_5);
    self._id_7560[var_0][var_1].on = 1;
  } else {
    if(scripts\engine\utility::is_true(var_3))
      thread scripts\sp\utility::_id_75A0(var_4, var_5);
    else
      thread scripts\sp\utility::_id_75F8(var_4, var_5);

    self._id_7560[var_0][var_1].on = 0;
  }
}

_id_39D0(var_0, var_1) {
  switch (var_0) {
    case "off_kill":
      _id_7564("thrust_vert", 0, 1);
      break;
    case "off":
      _id_7564("thrust_vert", 0);
      break;
    case "idle":
      _id_7563("thrust_vert", "idle");
      break;
    case "heavy":
      _id_7563("thrust_vert", "heavy");
      break;
    case "launch":
      _id_7563("thrust_vert", "launch");
      break;
    case "mons_titan_initiate":
      _id_7563("thrust_vert", "initiate");
      break;
    case "ph_dust_damaged":
      _id_7563("thrust_vert", "damaged");
      break;
    case "hburst":
      _id_7563("thrust_vert", "hburst");
      break;
    default:
      break;
  }
}

_id_39CD(var_0, var_1) {
  switch (var_0) {
    case "off_kill":
      _id_7564("thrust_rear", 0, 1);
      break;
    case "off":
      _id_7564("thrust_rear", 0);
      break;
    case "idle":
      _id_7563("thrust_rear", "idle");
      break;
    case "idle_light":
      _id_7563("thrust_rear", "idle_light");
      break;
    case "heavy":
      _id_7563("thrust_rear", "heavy");
      break;
    case "launch":
      _id_7563("thrust_rear", "launch");
      break;
    case "burst":
      _id_7563("thrust_rear", "burst");
      break;
    default:
      break;
  }
}

_id_39CE(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  switch (var_0) {
    case "off_kill":
      _id_7564("light_lod_high", 0, 1);
      break;
    case "off":
      _id_7564("light_lod_high", 0);
      break;
    case "low":
      _id_7564("light_lod_high", 0);
      break;
    case "med":
      _id_7564("light_lod_high", 0);
      break;
    case "high":
      _id_7564("light_lod_high", 1);
      break;
    default:
  }
}

_id_39CC(var_0) {
  switch (var_0) {
    case "none":
      _id_7564("damage_state", 0);
      break;
    case "heavy_fire":
      _id_7561("damage_state", "tag_origin", "damage_heavy_fire");
      _id_7564("damage_state", 1);
      break;
    default:
  }
}

_id_398C(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(self._id_7482) || !isDefined(self._id_748F)) {
    self show();
    _id_0BB6::_id_39EE(0);
    _id_39D0(var_0);
    _id_39CD(var_1);
    _id_39CE(var_2);
    _id_397E();
    _id_39C8();
    thread _id_749C();
    return;
  }

  if(!isDefined(var_0))
    var_0 = "idle";

  if(!isDefined(var_1))
    var_1 = "idle";

  if(!isDefined(var_2))
    var_2 = "high";

  var_5 = self.origin;
  var_6 = self.angles;

  if(isDefined(var_3)) {
    var_5 = var_3.origin;
    var_6 = var_3.angles;
  }

  var_7 = scripts\sp\utility::_id_10639("ftl_model", var_5, var_6);
  var_8 = self._id_7482 + "_pre";

  if(isDefined(self._id_7483))
    var_8 = self._id_7483;

  playFXOnTag(level._effect[var_8], var_7, "tag_ftl_ship_origin");

  if(isDefined(self._id_7475))
    wait(self._id_7475);
  else {
    wait 2;
    var_7 scripts\sp\anim::_id_1F35(var_7, "ftl_in");
    wait 0.1;
  }

  if(isDefined(self._id_7499) && isDefined(self._id_749A)) {
    wait(self._id_749A);
    playFXOnTag(level._effect[self._id_7499], var_7, "tag_ftl_ship_origin");
  }

  if(isDefined(self.script_team) && self.script_team == "allies") {
    if(soundexists("capitalship_npc_ally_ftl_in")) {
      if(isDefined(var_3))
        var_3 playSound("capitalship_npc_ally_ftl_in");
      else
        self playSound("capitalship_npc_ally_ftl_in");
    }
  } else if(soundexists("capitalship_npc_enemy_ftl_in")) {
    if(isDefined(var_3))
      var_3 playSound("capitalship_npc_enemy_ftl_in");
    else
      self playSound("capitalship_npc_enemy_ftl_in");
  }

  if(isDefined(var_3))
    self vehicle_teleport(var_5, var_6);

  self show();
  _id_0BB6::_id_39EE(0);
  _id_39D0(var_0);
  _id_39CD(var_1);
  _id_39CE(var_2);
  _id_397E();
  _id_39C8();
  self notify("ftl_show_moment");
  thread _id_749C(var_4);
  var_7 thread _id_4080(0.7);

  if(isDefined(level._effect[self._id_7482 + "_in"]))
    playFXOnTag(level._effect[self._id_7482 + "_in"], self, "tag_origin");

  if(isDefined(level._effect[var_8 + "_post"]))
    playFXOnTag(level._effect[var_8 + "_post"], self, "tag_origin");
}

_id_398E(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4))
    var_4 = 0;

  var_5 = getEnt(var_0, "targetname");
  var_6 = var_5 _id_3990(var_1, var_2, var_3, var_4);
  return var_6;
}

_id_3990(var_0, var_1, var_2, var_3) {
  var_4 = scripts\sp\utility::_id_10808();
  var_4 _id_39CD("off");
  var_4 _id_39D0("off");
  var_4 _id_39CE("off");
  var_4 _id_0BB6::_id_39EE(1);
  var_4 _id_397D();
  var_4 _id_39C6();
  var_4 hide();
  var_4 _id_398C(var_0, var_1, var_2, undefined, var_3);

  if(isDefined(var_4.target) && isDefined(getvehiclenode(var_4.target, "targetname")))
    var_4 startpath();

  if(!isDefined(var_4.turrets) || isDefined(var_4.turrets) && var_4.turrets.size == 0)
    var_4 _id_0BB6::_id_39E8();

  return var_4;
}

_id_3991(var_0) {
  if(!isDefined(self._id_7482) || !isDefined(self._id_748F)) {
    self notify("ftl_out");
    thread _id_7491();
    thread _id_749C();
    return;
  }

  self notify("ftl_out");
  var_1 = scripts\sp\utility::_id_10639("ftl_model", self.origin, self.angles);
  var_1 linkTo(self);
  var_2 = self._id_7482 + "_out";
  playFXOnTag(level._effect[var_2], self, "tag_origin");
  wait 3.0;
  self notify("ftl_complete");
  thread _id_7491();
  thread _id_749C();

  if(!scripts\engine\utility::is_true(var_0)) {
    if(soundexists("capitalship_npc_ally_ftl_out"))
      self playSound("capitalship_npc_ally_ftl_out");
    else {}
  }

  var_1 thread _id_4080(1);
}

_id_7491() {
  if(scripts\engine\utility::is_true(self._id_7479))
    killfxontag(level._effect["vfx_vehicle_mons_warp_out_ftldrive_core"], self, "TAG_ORIGIN");

  _id_39CD("off_kill");
  _id_39D0("off_kill");
  _id_39CE("off_kill");

  if(isDefined(self._id_10381)) {
    foreach(var_1 in self._id_10381) {
      if(isDefined(var_1)) {
        killfxontag(scripts\engine\utility::getfx(var_1._id_10380), var_1, "tag_origin");
        var_1 delete();
      }
    }
  }

  if(isDefined(self._id_B55A))
    self._id_B55A hide();

  _id_0BB6::_id_39EE(1);
  _id_397D();
  _id_39C6();
  self hide();
}

_id_749C(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(isDefined(self._id_749D))
    self[[self._id_749D]]();
  else {
    earthquake(0.8, 0.5, level.player.origin, 5000);

    if(var_0) {
      return;
    }
    visionsetnaked("ftl_3rd_person_flash", 0.1);
    wait 0.4;

    if(isDefined(level._id_7495)) {
      visionsetnaked(level._id_7495, 0.4);
      return;
    }

    visionsetnaked("", 0.4);
  }
}

_id_4080(var_0) {
  wait(var_0);
  self delete();
}

_id_398F(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = scripts\sp\utility::_id_10808();
  var_2 _id_39CD("off");
  var_2 _id_39D0("off");
  var_2 _id_39CE("off");
  var_2 _id_0BB6::_id_39EE(0);
  var_2 hide();
  var_2._id_74A6 = 1;

  if(isDefined(var_0))
    var_2 scripts\engine\utility::delaythread(var_0, ::_id_398D, var_1);
  else
    var_2 thread _id_398D(var_1);

  return var_2;
}

_id_398D(var_0) {
  var_1 = 4000;
  var_2 = 3.0;
  var_3 = anglesToForward(self.angles);

  if(!var_0) {
    self._id_74A8 = scripts\engine\utility::spawn_script_origin();
    self linkTo(self._id_74A8);
    self._id_74A8.origin = self.origin + var_3 * var_1 * -1;
  }

  var_4 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);

  if(isDefined(self.script_team) && self.script_team == "allies") {
    if(soundexists("capitalship_npc_ally_ftl_in"))
      self playSound("capitalship_npc_ally_ftl_in");
  } else if(soundexists("capitalship_npc_enemy_ftl_in"))
    self playSound("capitalship_npc_enemy_ftl_in");

  thread _id_749C();
  wait 0.25;
  playFXOnTag(scripts\engine\utility::getfx(self._id_7482 + "_pre"), var_4, "tag_origin");
  wait 0.28;
  self show();
  self._id_74A6 = undefined;
  _id_0BB6::_id_39EE(0);
  _id_39D0("idle");
  _id_39CD("heavy");
  scripts\engine\utility::delaythread(0.7, ::_id_39CD, "idle");
  _id_39CE("high");
  _id_397E();
  _id_39C8();

  if(!var_0) {
    var_5 = self.origin + var_3 * var_1;
    self._id_74A8 moveTo(var_5, var_2, 0.0, var_2);
    var_4 delete();
    wait(var_2);
    self._id_74A8 delete();
    self notify("ftl_complete");
  } else {
    var_4 delete();
    self notify("ftl_complete");
  }
}

_id_397F(var_0, var_1) {
  if(!isDefined(self._id_539B) && (var_0 || var_1)) {
    return;
  }
  if(isDefined(var_0) && var_0 && isDefined(self._id_539B[0]))
    thread _id_16C4(self._id_539B[0], 0);

  if(isDefined(var_1) && var_1) {
    if(isDefined(self._id_EF3C) && isDefined(self._id_539B[2]))
      thread _id_16C4(self._id_539B[2], 2);
    else if(isDefined(self._id_539B[1]))
      thread _id_16C4(self._id_539B[1], 1);
  }
}

_id_39AE() {
  if(isDefined(self._id_539A))
    thread _id_16C4(self._id_539A, 4);
}

_id_16C4(var_0, var_1) {
  if(!isDefined(self._id_539C))
    self._id_539C = [];

  if(isDefined(self._id_539C[var_1])) {
    return;
  }
  self attach(var_0, "TAG_ORIGIN");
  self._id_539C[var_1] = var_0;
}

_id_397C() {
  if(!isDefined(self._id_539C)) {
    return;
  }
  foreach(var_2, var_1 in self._id_539C) {
    self detach(var_1, "TAG_ORIGIN");
    self._id_539C[var_2] = undefined;
  }

  self._id_539C = [];
}

_id_397D() {
  self _meth_8184();
}

_id_397E() {
  self showallparts();
}

_id_39C5() {
  if(!isDefined(self._id_EF3C)) {
    return;
  }
  foreach(var_1 in self._id_EF3C)
  var_1 delete();
}

_id_39C6() {
  if(!isDefined(self._id_EF3C)) {
    return;
  }
  foreach(var_1 in self._id_EF3C)
  var_1 hide();
}

_id_39C8() {
  if(!isDefined(self._id_EF3C)) {
    return;
  }
  foreach(var_1 in self._id_EF3C)
  var_1 show();
}

_id_9B82() {
  if(scripts\engine\utility::is_true(self._id_9B82))
    return 1;

  return 0;
}

_id_39BB() {
  self notsolid();

  foreach(var_1 in self._id_8B4F) {
    foreach(var_3 in var_1) {
      if(isDefined(var_3) && !isstruct(var_3))
        var_3 notsolid();
    }
  }
}

_id_3980() {
  self dontcastshadows();

  if(isDefined(self._id_EF3C)) {
    foreach(var_1 in self._id_EF3C)
    var_1 dontcastshadows();
  }

  if(isDefined(self._id_539C)) {
    foreach(var_4 in self._id_539C)
    var_4 dontcastshadows();
  }

  foreach(var_7 in self._id_8B4F) {
    foreach(var_9 in var_7) {
      if(isDefined(var_9) && !isstruct(var_9))
        var_9 dontcastshadows();
    }
  }
}