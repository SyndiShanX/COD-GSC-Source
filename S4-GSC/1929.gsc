/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1929.gsc
*************************************************/

init() {
  setdvarifuninitialized("#x39fca73e956658afc", 360.0);
  setdvarifuninitialized("#x34add1d7c72c236ce", 460.0);
  setdvarifuninitialized("#x3b38d52e6a43a0ad0", 540.0);
  level._id_1C2C = scripts\engine\utility::getStructArray("ascend_begin", "script_noteworthy");
  level._id_480B = scripts\engine\utility::getStructArray("descend_begin", "script_noteworthy");
  level._id_1C2F = [];

  foreach(var_1 in level._id_1C2C) {
    _id_9B8B(var_1, 1);
  }

  foreach(var_1 in level._id_480B) {
    _id_9B8B(var_1, 0);
  }

  _id_8136();
  _id_07A1::_id_CECC("ascender", ::_id_1C29);
}

#using_animtree("script_model");

_id_8136() {
  level._id_CC34["player"] = #animtree;
  level._id_CC31["player"]["ascender_up_in"] = % vm_eq_ascender_up_get_on_plr;
  level._id_CC32["player"]["ascender_up_in"] = "vm_eq_ascender_up_get_on_plr";
  level._id_CC3B["player"]["ascender_up_in"] = "ascender_up_in";
  level._id_CC31["player"]["ascender_up_loop"] = % vm_eq_ascender_up_loop_plr;
  level._id_CC32["player"]["ascender_up_loop"] = "vm_eq_ascender_up_loop_plr";
  level._id_CC3B["player"]["ascender_up_loop"] = "ascender_up_loop";
  level._id_CC31["player"]["ascender_up_out"] = % vm_eq_ascender_up_get_off_plr;
  level._id_CC32["player"]["ascender_up_out"] = "vm_eq_ascender_up_get_off_plr";
  level._id_CC3B["player"]["ascender_up_out"] = "ascender_up_out";
  level._id_CC31["player"]["ascender_down_in"] = % vm_eq_ascender_down_get_on_plr;
  level._id_CC32["player"]["ascender_down_in"] = "vm_eq_ascender_down_get_on_plr";
  level._id_CC3B["player"]["ascender_down_in"] = "ascender_down_in";
  level._id_CC31["player"]["ascender_down_loop"] = % vm_eq_ascender_down_loop_plr;
  level._id_CC32["player"]["ascender_down_loop"] = "vm_eq_ascender_down_loop_plr";
  level._id_CC3B["player"]["ascender_down_loop"] = "ascender_down_loop";
  level._id_CC31["player"]["ascender_down_out"] = % vm_eq_ascender_down_get_off_plr;
  level._id_CC32["player"]["ascender_down_out"] = "vm_eq_ascender_down_get_off_plr";
  level._id_CC3B["player"]["ascender_down_out"] = "ascender_down_out";
  level._id_CC34["device"] = #animtree;
  level._id_CC31["device"]["ascender_up_in"] = % vm_eq_ascender_up_get_on_ascender;
  level._id_CC32["device"]["ascender_up_in"] = "vm_eq_ascender_up_get_on_ascender";
  level._id_CC3B["device"]["ascender_up_in"] = "ascender_up_in";
  level._id_CC31["device"]["ascender_up_loop"] = % vm_eq_ascender_up_loop_ascender;
  level._id_CC32["device"]["ascender_up_loop"] = "vm_eq_ascender_up_loop_ascender";
  level._id_CC3B["device"]["ascender_up_loop"] = "ascender_up_loop";
  level._id_CC31["device"]["ascender_up_out"] = % vm_eq_ascender_up_get_off_ascender;
  level._id_CC32["device"]["ascender_up_out"] = "vm_eq_ascender_up_get_off_ascender";
  level._id_CC3B["device"]["ascender_up_out"] = "ascender_up_out";
  level._id_CC31["device"]["ascender_down_in"] = % vm_eq_ascender_down_get_on_ascender;
  level._id_CC32["device"]["ascender_down_in"] = "vm_eq_ascender_down_get_on_ascender";
  level._id_CC3B["device"]["ascender_down_in"] = "ascender_down_in";
  level._id_CC31["device"]["ascender_down_loop"] = % vm_eq_ascender_down_loop_ascender;
  level._id_CC32["device"]["ascender_down_loop"] = "vm_eq_ascender_down_loop_ascender";
  level._id_CC3B["device"]["ascender_down_loop"] = "ascender_down_loop";
  level._id_CC31["device"]["ascender_down_out"] = % vm_eq_ascender_down_get_off_ascender;
  level._id_CC32["device"]["ascender_down_out"] = "vm_eq_ascender_down_get_off_ascender";
  level._id_CC3B["device"]["ascender_down_out"] = "ascender_down_out";
  level._id_CC34["device"] = #animtree;
  level._id_CC31["device"]["ascender_up_in_wm"] = % wm_eq_ascender_up_get_on_ascender;
  level._id_CC32["device"]["ascender_up_in_wm"] = "wm_eq_ascender_up_get_on_ascender";
  level._id_CC3B["device"]["ascender_up_in_wm"] = "ascender_up_in";
  level._id_CC31["device"]["ascender_up_loop_wm"] = % wm_eq_ascender_up_loop_ascender;
  level._id_CC32["device"]["ascender_up_loop_wm"] = "wm_eq_ascender_up_loop_ascender";
  level._id_CC3B["device"]["ascender_up_loop_wm"] = "ascender_up_loop";
  level._id_CC31["device"]["ascender_up_out_wm"] = % wm_eq_ascender_up_get_off_ascender;
  level._id_CC32["device"]["ascender_up_out_wm"] = "wm_eq_ascender_up_get_off_ascender";
  level._id_CC3B["device"]["ascender_up_out_wm"] = "ascender_up_out";
  level._id_CC31["device"]["ascender_down_in_wm"] = % wm_eq_ascender_down_get_on_ascender;
  level._id_CC32["device"]["ascender_down_in_wm"] = "wm_eq_ascender_down_get_on_ascender";
  level._id_CC3B["device"]["ascender_down_in_wm"] = "ascender_down_in";
  level._id_CC31["device"]["ascender_down_loop_wm"] = % wm_eq_ascender_down_loop_ascender;
  level._id_CC32["device"]["ascender_down_loop_wm"] = "wm_eq_ascender_down_loop_ascender";
  level._id_CC3B["device"]["ascender_down_loop_wm"] = "ascender_down_loop";
  level._id_CC31["device"]["ascender_down_out_wm"] = % wm_eq_ascender_down_get_off_ascender;
  level._id_CC32["device"]["ascender_down_out_wm"] = "wm_eq_ascender_down_get_off_ascender";
  level._id_CC3B["device"]["ascender_down_out_wm"] = "ascender_down_out";
}

_id_9B8B(var_0, var_1) {
  var_2 = scripts\engine\utility::getstruct(var_0.target, "targetname");
  var_3 = scripts\engine\utility::getstruct(var_2.target, "targetname");
  level._id_1C2F[var_0._id_0481] = var_0;
  var_0._id_1C2D = var_2;
  var_0._id_1C2E = var_3;
  var_0._id_84EF = 0;
  var_0._id_5773 = var_0.angles + (0, 180, 0);
  var_0._id_E679 = var_0.angles;
  var_0._id_49C1 = var_1;

  if(var_0._id_0481 == "pf57045_auto38" || var_0._id_0481 == "pf57045_auto41") {
    var_0.origin = var_0.origin + (0, 0, 8);
    var_2.origin = var_2.origin + (0, 0, 8);
    var_3.origin = var_3.origin + (0, 0, 8);
  }
}

_id_1C29(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_2 == "on") {
    if(istrue(var_3._id_FF04)) {
      return;
    }
    _id_1C2B(var_0, var_3);
  }
}

_id_47C5() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("denyAscendMessageLastStand");
  self endon("denyAscendMessageLastStand");

  if(isDefined(level._id_1C27)) {
    self[[level._id_1C27]]("ascender_blocked_laststand", 4);
  } else {
    _id_0A99::_id_D5EA(55);
    wait 4;
    _id_0A99::_id_D5EA(0);
  }
}

_id_47C4() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("denyAscendMessageJugg");
  self endon("denyAscendMessageJugg");

  if(isDefined(level._id_1C27)) {
    self[[level._id_1C27]]("ascender_blocked_jugg", 4);
  } else {
    _id_0A99::_id_D5EA(54);
    wait 4;
    _id_0A99::_id_D5EA(0);
  }
}

_id_47C3() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("denyAscendMessage");
  self endon("denyAscendMessage");

  if(isDefined(level._id_1C27)) {
    self[[level._id_1C27]]("ascender_blocked", 4);
  } else {
    _id_0A99::_id_D5EA(43);
    wait 4;
    _id_0A99::_id_D5EA(0);
  }
}

_id_1C20(var_0) {
  level endon("game_ended");
  self endon("ascend_complete");
  self endon("ascender_cancel");
  self waittill("death_or_disconnect");
  var_0 _id_3872(self);
}

_id_52E0(var_0, var_1, var_2, var_3) {
  var_0 endon("death_or_disconnect");
  var_0 endon("ascender_cancel");

  if(var_1) {
    var_4 = "ascender_up_out";
  } else {
    var_4 = "ascender_down_out";
  }

  thread _id_07AA::_id_17FD(var_0, var_0._id_B5A4, var_4);
  _id_06C6::_id_1845(var_3, var_4 + "_wm");
}

_id_E67F(var_0, var_1, var_2, var_3) {
  var_0 endon("death_or_disconnect");
  var_0 endon("ascender_cancel");
  var_0 thread _id_0A94::_id_7E52("player", var_0.origin, var_0.angles);
  var_2._id_18AF = "device";
  var_2 _id_06C6::_id_D47B();
  var_3._id_18AF = "device";
  var_3 _id_06C6::_id_D47B();
  var_3 hide();
  var_4 = (1, 0, 0);

  if(var_1) {
    var_5 = "TAG_ACCESSORY_RIGHT";
    var_6 = "ascender_up_in";
    var_4 = rotatevector((-40.9464, 22.9807, 0), self.angles);
  } else {
    var_5 = "TAG_ACCESSORY_LEFT";
    var_6 = "ascender_down_in";
    var_4 = rotatevector((-42.2388, -23.4915, 0), self.angles);
  }

  var_0._id_B5A4 moveto(self.origin + var_4, 0.4, 0.1, 0.1);
  var_7 = vectornormalize(var_4 * -1);
  var_8 = _id_FFE3(var_7, (0, 0, 1));
  var_0._id_B5A4 rotateto(var_8, 0.4, 0.1, 0.1);
  var_9 = gettime();
  var_0 _id_0A94::_id_6FA0();
  var_10 = gettime();
  var_11 = 0.4 - (var_10 - var_9) / 1000.0;
  var_12 = max(0, var_11);
  wait(var_12);
  var_3 show();
  var_3 hidefromplayer(var_0);
  var_0._id_B5A4 linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_2 linkto(var_0._id_B5A4, var_5, (0, 0, 0), (0, 0, 0));
  var_3 linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_0._id_B5A4 _meth_83CA(var_0);
  _id_06C6::_id_17C2(var_0._id_B5A4, var_6);
  thread _id_07AA::_id_17FD(var_0, var_0._id_B5A4, var_6);
  thread _id_06C6::_id_1845(var_3, var_6 + "_wm");
  var_13 = _func_0079(level._id_CC31["player"][var_6]);
  wait(var_13);
}

_id_984A(var_0, var_1, var_2, var_3) {
  self endon("death_or_disconnect");
  self endon("ascender_loop_done");
  self endon("ascender_cancel");

  if(var_3) {
    var_4 = "ascender_up_loop";
  } else {
    var_4 = "ascender_down_loop";
  }

  var_5 = _func_0079(level._id_CC31["player"][var_4]);

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    var_0 thread _id_07AA::_id_17FD(self, self._id_B5A4, var_4);
    var_0 _id_06C6::_id_1845(var_2, var_4 + "_wm");

    if(!isDefined(var_5) || var_5 == 0) {
      break;
    }

    wait(var_5);
  }
}

_id_1C2B(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("death_or_disconnect");
  var_1 endon("ascender_cancel");
  var_2 = level._id_1C2F[var_0.target];

  if(var_1 isswitchingweapon()) {
    var_1 thread _id_47C3();
    return;
  }

  if(var_1 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    var_1 thread _id_47C3();
    return;
  }

  if(var_2._id_84EF) {
    var_1 thread _id_47C3();
    return;
  }

  if(istrue(var_1._id_82E8)) {
    var_1 thread _id_47C3();
    return;
  }

  if(istrue(var_1._id_88DF)) {
    var_1 thread _id_47C4();
    return;
  }

  if(istrue(self.inlaststand)) {
    var_1 thread _id_47C5();
    return;
  }

  if(istrue(var_1._id_8A07)) {
    return;
  }
  var_1._id_DBD8 = 1;
  var_2._id_1C21 = spawn("script_model", var_2.origin);
  var_2._id_1C21 setModel("tag_origin");
  var_2._id_03A9 = var_0;

  if(var_1 getstance() != "stand") {
    var_1 setstance("stand");
  }

  var_1 disableoffhandweapons();
  var_1 allowmelee(0);
  var_1 allowads(0);
  var_1 allowfire(0);
  var_1 scripts\common\utility::_id_154F(0);
  var_1 disableweaponswitch();
  var_2._id_1C21 _id_078E::_id_C2B6(2);
  var_2._id_84EF = 1;
  var_1._id_FF04 = 1;
  var_1 scripts\common\utility::_id_158A(0);
  var_3 = var_2._id_1C2D;
  var_4 = var_2._id_1C2E;
  var_2._id_1C21 dontinterpolate();
  var_2._id_1C21.origin = var_2.origin;
  var_2._id_1C21.angles = var_2.angles;
  var_5 = spawn("script_model", var_2.origin);
  var_5 setModel("misc_wm_ascender");
  var_5 _meth_83CA(var_1);
  var_6 = spawn("script_model", var_2.origin);
  var_6 setModel("misc_wm_ascender");
  var_6 hidefromplayer(var_1);
  var_1._id_1C2A = var_2;
  var_1._id_1C25 = var_5;
  var_1._id_1C26 = var_6;
  var_1 thread _id_1C20(var_2);
  var_2._id_1C21 _id_E67F(var_1, var_2._id_49C1, var_5, var_6);
  var_2._id_1C21 playLoopSound("br_auto_ascender_device_lp_npc");
  var_1 thread _id_984A(var_2._id_1C21, var_5, var_6, var_2._id_49C1);
  var_7 = distance(var_3.origin, var_2.origin);

  if(!var_2._id_49C1) {
    if(scripts\common\utility::iscp()) {
      var_8 = getdvarfloat("#x3b38d52e6a43a0ad0", 540.0);
    } else {
      var_8 = getdvarfloat("#x34add1d7c72c236ce", 460.0);
    }
  } else
    var_8 = getdvarfloat("#x39fca73e956658afc", 360.0);

  var_9 = var_7 / var_8;
  var_10 = 0.4 * var_9;
  var_11 = 0.15 * var_9;
  var_2._id_1C21 moveto(var_3.origin, var_9, var_10, var_11);
  wait(var_9);
  var_2._id_1C21 stoploopsound("br_auto_ascender_device_lp_npc");
  var_1 notify("ascender_loop_done");
  var_2._id_1C21 _id_52E0(var_1, var_2._id_49C1, var_5, var_6);
  var_2 _id_3872(var_1);
  var_1 notify("ascend_complete");
}

_id_3872(var_0) {
  self._id_84EF = 0;
  var_0._id_FF04 = 0;
  var_0._id_8F8E = gettime();
  var_0 scripts\common\utility::_id_158A(1);
  var_0._id_DBD8 = undefined;
  var_0 enableoffhandweapons();
  var_0 allowmelee(1);
  var_0 allowads(1);
  var_0 allowfire(1);
  var_0 scripts\common\utility::_id_154F(1);
  var_0 enableweaponswitch();
  var_0._id_1C25 unlink();
  var_0._id_1C25 delete();
  var_0._id_1C26 unlink();
  var_0._id_1C26 delete();
  self._id_1C21.angles = self._id_E679;
  self._id_1C21 _id_078E::_id_4807();
  self._id_1C21 delete();
  self._id_03A9 setscriptablepartstate("ascender", "on");
  var_0._id_1C2A = undefined;
  var_0._id_1C25 = undefined;
  var_0._id_1C26 = undefined;
  var_0._id_B5A4 unlink();
  var_0 thread _id_0A94::_id_EDC3();
  var_0 notify("remove_rig");
}

_id_1C24() {
  var_0 = self;

  if(!istrue(var_0._id_FF04)) {
    return;
  }
  var_1 = var_0._id_1C2A._id_1C2E.origin;
  var_2 = var_0._id_1C2A._id_1C2E.angles;
  var_0._id_1C2A _id_3872(var_0);
  var_0 setorigin(var_1);
  var_0 setplayerangles(var_2);
  var_0 notify("ascender_cancel");
}

_id_FFE3(var_0, var_1) {
  var_2 = _func_025B(var_0, var_1);
  var_1 = _func_025B(var_2, var_0);
  var_3 = _func_0017(var_0, var_2, var_1);
  return var_3;
}