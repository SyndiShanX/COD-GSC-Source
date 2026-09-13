/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_440a6f7f2d90cc3c.gsc
***********************************************/

#using_animtree("mp_vehicles_always_loaded");

_id_3E3A73F1039CA16D() {
  level.scr_anim["cargo_delivery_extract"]["heli_in"] = % iw9_dmz_cargo_heli_in;
  level.scr_anim["cargo_delivery_extract"]["heli_loop"] = % iw9_dmz_cargo_heli_loop;
  level.scr_anim["cargo_delivery_extract"]["heli_out"] = % iw9_dmz_cargo_heli_out;
  _id_885B229AEE63B402();
}

#using_animtree("script_model");

_id_885B229AEE63B402() {
  level.scr_animtree["cargo_delivery_extract_props"] = #animtree;
  level.scr_anim["cargo_delivery_extract_props"]["rope_in"] = % iw9_dmz_cargo_heli_rope_in;
  level.scr_animname["cargo_delivery_extract_props"]["rope_in"] = "iw9_dmz_cargo_heli_rope_in";
  level.scr_anim["cargo_delivery_extract_props"]["rope_loop"] = % iw9_dmz_cargo_heli_rope_loop;
  level.scr_animname["cargo_delivery_extract_props"]["rope_loop"] = "iw9_dmz_cargo_heli_rope_loop";
  level.scr_anim["cargo_delivery_extract_props"]["rope_out"] = % iw9_dmz_cargo_heli_rope_out;
  level.scr_animname["cargo_delivery_extract_props"]["rope_out"] = "iw9_dmz_cargo_heli_rope_out";
  level.scr_anim["cargo_delivery_extract_props"]["hook_in"] = % iw9_dmz_cargo_heli_hook_in;
  level.scr_animname["cargo_delivery_extract_props"]["hook_in"] = "iw9_dmz_cargo_heli_hook_in";
  level.scr_anim["cargo_delivery_extract_props"]["hook_loop"] = % iw9_dmz_cargo_heli_hook_loop;
  level.scr_animname["cargo_delivery_extract_props"]["hook_loop"] = "iw9_dmz_cargo_heli_hook_loop";
  level.scr_anim["cargo_delivery_extract_props"]["hook_out"] = % iw9_dmz_cargo_heli_hook_out;
  level.scr_animname["cargo_delivery_extract_props"]["hook_out"] = "iw9_dmz_cargo_heli_hook_out";
}

_id_5A081E065A93BD08(_id_B4EF83E4CA39C8EC, offset) {
  extractgroundpos = getgroundposition(_id_B4EF83E4CA39C8EC, 1) + offset;
  _id_DB4ADBA9675A31AA = extractgroundpos + (0, 0, 4000);
  _id_CC089176A2D8AB71 = extractgroundpos + (0, 0, 8000);
  _id_7CE2EF2A1EFE71A6 = extractgroundpos + (0, 0, 850);
  flightyaw = 0;
  _id_FDA870B32AB92C1F = (0, 0, 0);
  flightyaw = _id_B89378E2E51CF825(_id_CC089176A2D8AB71, _id_DB4ADBA9675A31AA);
  _id_FDA870B32AB92C1F = (0, flightyaw, 0);
  _id_16CEDB94FAF4D596 = _id_CC089176A2D8AB71 - anglesToForward(_id_FDA870B32AB92C1F) * 20000;
  _id_87CEF10BF5729579 = 1;
  _id_1D4278103BA47A16 = vectortoangles(_id_DB4ADBA9675A31AA * (1, 1, 0) - _id_16CEDB94FAF4D596 * (1, 1, 0));
  spawndata = spawnStruct();
  spawndata.origin = _id_16CEDB94FAF4D596;
  spawndata.angles = _id_1D4278103BA47A16;
  heli = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_blima", spawndata);

  if(!isDefined(heli)) {
    return;
  }
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable(heli);
  heli _meth_247AD6A91F6A4FFE(1);
  heli vehphys_forcekeyframedmotion();
  heli.speed = 100;
  heli.accel = 125;
  heli.health = 999999;
  heli.maxhealth = heli.health;
  heli.lifeid = 0;
  heli.flaresreservecount = _id_87CEF10BF5729579;
  heli.enterpos = _id_16CEDB94FAF4D596;
  heli.descendpos = _id_DB4ADBA9675A31AA;
  heli.hoverpos = _id_7CE2EF2A1EFE71A6;
  heli.extractgroundpos = extractgroundpos;
  heli.sceneangles = _id_1D4278103BA47A16;
  heli.animname = "cargo_delivery_extract";
  heli scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  heli setmaxpitchroll(10, 25);
  heli vehicle_setspeed(heli.speed, heli.accel);
  heli sethoverparams(1, 1, 1);
  heli setturningability(0.05);
  heli setyawspeed(45, 25, 25, 0.5);

  if(isent(self)) {
    if(isDefined(self.team))
      heli.team = self.team;

    heli.owner = self;
    heli setotherent(self);
  }

  heli setscriptablepartstate("engine", "on");
  heli setscriptablepartstate("running_lights", "on");
  heli setscriptablepartstate("infil_lights", "on");
  heli.scenenode = spawn("script_model", _id_B4EF83E4CA39C8EC + (0, 0, -15) + offset);
  heli.scenenode.angles = heli.sceneangles;
  heli.scenenode setModel("tag_origin");
  heli.scenenode scripts\common\anim::anim_first_frame_solo(heli, "heli_in");
  level._id_F3B18A363AE14D7A = heli;
  _id_542344D67FB5EE7A(heli);
  heli thread _id_B525FA38BAF87839(_id_B4EF83E4CA39C8EC + offset);
  return heli;
}

_id_542344D67FB5EE7A(heli) {
  rope = spawn("script_model", (0, 0, 0));
  rope setModel("misc_rapelling_rope_01_fiber_br");
  rope linkTo(heli, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
  rope notsolid();
  rope show();
  rope.animname = "cargo_delivery_extract_props";
  rope scripts\common\anim::setanimtree();
  heli scripts\common\anim::anim_first_frame_solo(rope, "rope_in", "origin_animate_jnt");
  crate = spawn("script_model", (0, 0, 0));
  crate setModel("construction_lattice_boom_crane_01_hook");
  crate linkTo(heli, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
  crate notsolid();
  crate show();
  crate.animname = "cargo_delivery_extract_props";
  crate scripts\common\anim::setanimtree();
  heli scripts\common\anim::anim_first_frame_solo(crate, "hook_in", "origin_animate_jnt");
  heli.rope = rope;
  heli.crate = crate;
}

_id_8A0F37EA918FA970(_id_C45865D4C48493C1, _id_88125F10D2B34AA3, _id_B2BDD90249635576) {
  _id_3D0EC1C05F1E1001 = _id_C45865D4C48493C1 * 0.0000157828;
  a = 0.5 * _id_B2BDD90249635576;
  b = _id_88125F10D2B34AA3;
  c = -1 * _id_3D0EC1C05F1E1001;
  flytime = (-1 * b + sqrt(b * b - 4 * a * c)) / (2 * a);
  flytime = flytime * 3600;
  flytime = flytime + 1.5;
  return flytime;
}

_id_63E41CE3A6457CC1(_id_625180CE8D2F8F77) {
  _id_5301EBED8D610FDB = _id_8A0F37EA918FA970(20000, 100, 125);
  _id_EB0FAE3483A10D88 = _id_8A0F37EA918FA970(_id_625180CE8D2F8F77, 25.0, 31.25);
  totaltime = _id_5301EBED8D610FDB + _id_EB0FAE3483A10D88;
  return totaltime;
}

_id_B525FA38BAF87839(_id_3D5095C68E5C2B99) {
  self endon("death");
  self endon("leaving");
  groundz = self.extractgroundpos[2];
  _id_625180CE8D2F8F77 = self.descendpos[2] - groundz;
  self.flytime = _id_63E41CE3A6457CC1(_id_625180CE8D2F8F77);
  thread _id_F5D7C70A275E3C17();
  self.preventleave = 1;
  _id_E3A16387941BBBC8();
  self.preventleave = undefined;
  self setscriptablepartstate("vector_field", "on");

  if(istrue(level.gameended)) {
    thread _id_ACD83BE80FF2E711();
    return;
  }

  thread _id_ACD83BE80FF2E711();
}

_id_B89378E2E51CF825(_id_E58119F7C6EB5B4D, _id_D3970A3E6C77212E) {
  _id_3FB4A86293ED25A6 = 10;
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 0, 1, 1, 0);
  _id_3674D96C61E2DD0D = 0;

  for(yaw = 0; yaw < 360; yaw = yaw + _id_3FB4A86293ED25A6) {
    _id_3674D96C61E2DD0D = _id_3674D96C61E2DD0D + yaw;
    _id_211FC11F4C8566F5 = (0, _id_3674D96C61E2DD0D, 0);
    _id_29006F80487A7787 = _id_E58119F7C6EB5B4D - anglesToForward(_id_211FC11F4C8566F5) * 20000;
    _id_DD77D0A6D708AC18 = _id_D3970A3E6C77212E;
    _id_D4EB961F60968A16 = scripts\engine\trace::sphere_trace(_id_29006F80487A7787, _id_DD77D0A6D708AC18, 100, undefined, contents, 1);

    if(_id_D4EB961F60968A16["fraction"] == 1)
      return _id_3674D96C61E2DD0D;

    if(yaw % 3 == 0)
      waitframe();
  }

  return _id_3674D96C61E2DD0D;
}

_id_4BBA7BF68035A122() {
  if(isDefined(self.rope))
    self.rope delete();

  if(isDefined(self.crate))
    self.crate delete();

  if(isDefined(self.scenenode))
    self.scenenode delete();
}

_id_4B7DD160447D4825() {
  _id_4BBA7BF68035A122();
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

_id_ACD83BE80FF2E711() {
  if(istrue(self.tryingtoleave) || istrue(self.leaving)) {
    return;
  }
  self endon("death");
  self notify("try_to_leave");
  self.tryingtoleave = 1;
  self waittill("ready_to_leave");
  self notify("leaving");
  self.leaving = 1;
  self.tryingtoleave = undefined;
  _id_DBEE990416F1879A = getanimlength(level.scr_anim[self.animname]["heli_out"]);
  self.scenenode thread scripts\common\anim::anim_single_solo(self, "heli_out");
  thread scripts\common\anim::anim_single_solo(self.rope, "rope_out", "origin_animate_jnt");
  thread scripts\common\anim::anim_single_solo(self.crate, "hook_out", "origin_animate_jnt");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_DBEE990416F1879A);
  self stoploopsound();
  self notify("heli_gone");
  _id_4B7DD160447D4825();
}

_id_E3A16387941BBBC8() {
  self endon("death");
  _id_228083B1CC503599 = getanimlength(level.scr_anim[self.animname]["heli_in"]);
  self.scenenode thread scripts\common\anim::anim_single_solo(self, "heli_in");
  thread scripts\common\anim::anim_single_solo(self.rope, "rope_in", "origin_animate_jnt");
  thread scripts\common\anim::anim_single_solo(self.crate, "hook_in", "origin_animate_jnt");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_228083B1CC503599);
  thread _id_F0F206969743BA63();
  thread _id_92A59E0004116C97();
  thread _id_106CAEBE9F0DD820();
}

_id_F0F206969743BA63() {
  self endon("death");
  self.scenenode endon("death");
  _id_EB5B1F36E255152D = getanimlength(level.scr_anim[self.animname]["heli_loop"]);

  for(;;) {
    self.scenenode thread scripts\common\anim::anim_single_solo(self, "heli_loop");
    wait(_id_EB5B1F36E255152D);

    if(istrue(self.readytoleave) && !istrue(self.preventleave)) {
      self notify("ready_to_leave");
      break;
    }
  }
}

_id_92A59E0004116C97() {
  self endon("death");
  _id_EB5B1F36E255152D = getanimlength(level.scr_anim[self.rope.animname]["rope_loop"]);

  for(;;) {
    thread scripts\common\anim::anim_single_solo(self.rope, "rope_loop", "origin_animate_jnt");
    wait(_id_EB5B1F36E255152D);

    if(istrue(self.readytoleave)) {
      break;
    }
  }
}

_id_106CAEBE9F0DD820() {
  self endon("death");
  _id_EB5B1F36E255152D = getanimlength(level.scr_anim[self.crate.animname]["hook_loop"]);

  for(;;) {
    thread scripts\common\anim::anim_single_solo(self.crate, "hook_loop", "origin_animate_jnt");
    wait(_id_EB5B1F36E255152D);

    if(istrue(self.readytoleave)) {
      break;
    }
  }
}

_id_F5D7C70A275E3C17() {
  self endon("death");
  self endon("try_to_leave");
  level waittill("game_ended");
  thread _id_ACD83BE80FF2E711();
}