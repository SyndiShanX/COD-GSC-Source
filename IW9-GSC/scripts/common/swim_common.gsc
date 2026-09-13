/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\swim_common.gsc
***********************************************/

_id_E05AEEC06B7B52AA(_id_DC6DC154664CF0AA, _id_575E6F276810675E, _id_A1E7FB7B162A7323, _id_DD47832CD570074B, _id_BE3314F77FEF5D6B, _id_0F6C33CF49E7246E, _id_71106DD668C1BCAB, _id_230B60EF0852DCB8, _id_A699C74CE724A801, _id_E1B16133A0146153) {
  setdvarifuninitialized("dvar_2A4F08BC79265550", 0);
  level._id_C3A0F3B16CCE4CA9 = spawnStruct();
  level._id_C3A0F3B16CCE4CA9._id_DC6DC154664CF0AA = _id_DC6DC154664CF0AA;
  level._id_C3A0F3B16CCE4CA9._id_575E6F276810675E = _id_575E6F276810675E;
  level._id_C3A0F3B16CCE4CA9._id_A1E7FB7B162A7323 = _id_A1E7FB7B162A7323;
  level._id_C3A0F3B16CCE4CA9._id_DD47832CD570074B = _id_DD47832CD570074B;
  level._id_C3A0F3B16CCE4CA9._id_BE3314F77FEF5D6B = _id_BE3314F77FEF5D6B;
  level._id_C3A0F3B16CCE4CA9._id_0F6C33CF49E7246E = _id_0F6C33CF49E7246E;
  level._id_C3A0F3B16CCE4CA9._id_71106DD668C1BCAB = _id_71106DD668C1BCAB;
  level._id_C3A0F3B16CCE4CA9._id_230B60EF0852DCB8 = _id_230B60EF0852DCB8;
  level._id_C3A0F3B16CCE4CA9._id_A699C74CE724A801 = _id_A699C74CE724A801;
  level._id_C3A0F3B16CCE4CA9._id_E1B16133A0146153 = _id_E1B16133A0146153;
  level._id_C3A0F3B16CCE4CA9.sfx = _id_A1F804A91DB4E6C2();
  _id_76828BA8FDE01E05();
}

_id_A1F804A91DB4E6C2() {
  sfx = spawnStruct();
  sfx _id_AA21B4352CA3B832(["sfx", "surface", "slow", "quiet", "plr"], "mvmt_swim_surfacing_plr_slow");
  sfx _id_AA21B4352CA3B832(["sfx", "surface", "slow", "quiet", "npc"], "mvmt_swim_surfacing_npc_slow");
  sfx _id_AA21B4352CA3B832(["sfx", "surface", "slow", "breath", "plr"], "mvmt_swim_surfacing_plr_slow_gasping");
  sfx _id_AA21B4352CA3B832(["sfx", "surface", "slow", "breath", "npc"], "mvmt_swim_surfacing_npc_slow_gasping");
  sfx _id_AA21B4352CA3B832(["sfx", "surface", "slow", "gasp", "plr"], "mvmt_swim_surfacing_plr_slow_gasping");
  sfx _id_AA21B4352CA3B832(["sfx", "surface", "slow", "gasp", "npc"], "mvmt_swim_surfacing_npc_slow_gasping");
  sfx _id_AA21B4352CA3B832(["sfx", "surface", "fast", "quiet", "plr"], "mvmt_swim_surfacing_plr_sprint");
  sfx _id_AA21B4352CA3B832(["sfx", "surface", "fast", "quiet", "npc"], "mvmt_swim_surfacing_npc_sprint");
  sfx _id_AA21B4352CA3B832(["sfx", "surface", "fast", "breath", "plr"], "mvmt_swim_surfacing_plr_sprint_gasping");
  sfx _id_AA21B4352CA3B832(["sfx", "surface", "fast", "breath", "npc"], "mvmt_swim_surfacing_npc_sprint_gasping");
  sfx _id_AA21B4352CA3B832(["sfx", "surface", "fast", "gasp", "plr"], "mvmt_swim_surfacing_plr_sprint_gasping");
  sfx _id_AA21B4352CA3B832(["sfx", "surface", "fast", "gasp", "npc"], "mvmt_swim_surfacing_npc_sprint_gasping");
  sfx _id_AA21B4352CA3B832(["sfx", "descend", "slow", "quiet", "plr"], "mvmt_swim_plunging_plr_slow");
  sfx _id_AA21B4352CA3B832(["sfx", "descend", "slow", "quiet", "npc"], "mvmt_swim_plunging_npc_slow");
  sfx _id_AA21B4352CA3B832(["sfx", "descend", "slow", "breath", "plr"], "mvmt_swim_plunging_plr_slow_inhaling");
  sfx _id_AA21B4352CA3B832(["sfx", "descend", "slow", "breath", "npc"], "mvmt_swim_plunging_npc_slow_inhaling");
  sfx _id_AA21B4352CA3B832(["sfx", "descend", "slow", "gasp", "plr"], "mvmt_swim_plunging_plr_slow_inhaling");
  sfx _id_AA21B4352CA3B832(["sfx", "descend", "slow", "gasp", "npc"], "mvmt_swim_plunging_npc_slow_inhaling");
  sfx _id_AA21B4352CA3B832(["sfx", "descend", "fast", "quiet", "plr"], "mvmt_swim_plunging_plr_sprint");
  sfx _id_AA21B4352CA3B832(["sfx", "descend", "fast", "quiet", "npc"], "mvmt_swim_plunging_npc_sprint");
  sfx _id_AA21B4352CA3B832(["sfx", "descend", "fast", "breath", "plr"], "mvmt_swim_plunging_plr_sprint_inhaling");
  sfx _id_AA21B4352CA3B832(["sfx", "descend", "fast", "breath", "npc"], "mvmt_swim_plunging_npc_sprint_inhaling");
  sfx _id_AA21B4352CA3B832(["sfx", "descend", "fast", "gasp", "plr"], "mvmt_swim_plunging_plr_sprint_inhaling");
  sfx _id_AA21B4352CA3B832(["sfx", "descend", "fast", "gasp", "npc"], "mvmt_swim_plunging_npc_sprint_inhaling");
  sfx _id_AA21B4352CA3B832(["dlg", "surface", "slow", "quiet", "plr"], "plr_breath_swim_surface_inh");
  sfx _id_AA21B4352CA3B832(["dlg", "surface", "slow", "quiet", "npc"], "npc_breath_swim_surface_inh");
  sfx _id_AA21B4352CA3B832(["dlg", "surface", "slow", "breath", "plr"], "plr_breath_swim_surface_gasp_inh");
  sfx _id_AA21B4352CA3B832(["dlg", "surface", "slow", "breath", "npc"], "npc_breath_swim_surface_gasp_inh");
  sfx _id_AA21B4352CA3B832(["dlg", "surface", "slow", "gasp", "plr"], "plr_breath_swim_surface_gasp_inh");
  sfx _id_AA21B4352CA3B832(["dlg", "surface", "slow", "gasp", "npc"], "npc_breath_swim_surface_gasp_inh");
  sfx _id_AA21B4352CA3B832(["dlg", "surface", "fast", "quiet", "plr"], "plr_breath_swim_surface_inh");
  sfx _id_AA21B4352CA3B832(["dlg", "surface", "fast", "quiet", "npc"], "npc_breath_swim_surface_inh");
  sfx _id_AA21B4352CA3B832(["dlg", "surface", "fast", "breath", "plr"], "plr_breath_swim_surface_gasp_sprint_inh");
  sfx _id_AA21B4352CA3B832(["dlg", "surface", "fast", "breath", "npc"], "npc_breath_swim_surface_gasp_sprint_inh");
  sfx _id_AA21B4352CA3B832(["dlg", "surface", "fast", "gasp", "plr"], "plr_breath_swim_surface_gasp_sprint_inh");
  sfx _id_AA21B4352CA3B832(["dlg", "surface", "fast", "gasp", "npc"], "npc_breath_swim_surface_gasp_sprint_inh");
  sfx _id_AA21B4352CA3B832(["dlg", "descend", "slow", "quiet", "plr"], "plr_breath_swim_descend_inh");
  sfx _id_AA21B4352CA3B832(["dlg", "descend", "slow", "quiet", "npc"], "npc_breath_swim_descend_inh");
  sfx _id_AA21B4352CA3B832(["dlg", "descend", "slow", "breath", "plr"], "plr_breath_swim_descend_gasp_inh");
  sfx _id_AA21B4352CA3B832(["dlg", "descend", "slow", "breath", "npc"], "npc_breath_swim_descend_gasp_inh");
  sfx _id_AA21B4352CA3B832(["dlg", "descend", "slow", "gasp", "plr"], "plr_breath_swim_descend_gasp_inh");
  sfx _id_AA21B4352CA3B832(["dlg", "descend", "slow", "gasp", "npc"], "npc_breath_swim_descend_gasp_inh");
  sfx _id_AA21B4352CA3B832(["dlg", "descend", "fast", "quiet", "plr"], "plr_breath_swim_descend_inh");
  sfx _id_AA21B4352CA3B832(["dlg", "descend", "fast", "quiet", "npc"], "npc_breath_swim_descend_inh");
  sfx _id_AA21B4352CA3B832(["dlg", "descend", "fast", "breath", "plr"], "plr_breath_swim_descend_gasp_sprint_inh");
  sfx _id_AA21B4352CA3B832(["dlg", "descend", "fast", "breath", "npc"], "npc_breath_swim_descend_gasp_sprint_inh");
  sfx _id_AA21B4352CA3B832(["dlg", "descend", "fast", "gasp", "plr"], "plr_breath_swim_descend_gasp_sprint_inh");
  sfx _id_AA21B4352CA3B832(["dlg", "descend", "fast", "gasp", "npc"], "npc_breath_swim_descend_gasp_sprint_inh");
  return sfx;
}

_id_76828BA8FDE01E05() {
  level._effect["swim_bubbles_light"] = loadfx("vfx/iw9/core/swimming/vfx_swim_gasp_bubbles_0.vfx");
  level._effect["swim_gasp_bubbles"] = loadfx("vfx/iw9/core/swimming/vfx_swim_gasp_bubbles_1.vfx");
  level._effect["swim_drowning_bubbles"] = loadfx("vfx/iw9/core/swimming/vfx_swim_gasp_bubbles_2.vfx");
}

_id_AA21B4352CA3B832(keys, sfx) {
  _id_AC0E594AC96AA3A8 = 0;
  _id_43E0B9317508501B = self;

  for(;;) {
    if(keys.size > _id_AC0E594AC96AA3A8 + 1)
      _id_43E0B9317508501B _id_CF9CEBE58C49F708(keys[_id_AC0E594AC96AA3A8]);
    else {
      _id_43E0B9317508501B _id_E3E506E52AACFB27(keys[_id_AC0E594AC96AA3A8], sfx);
      break;
    }

    _id_43E0B9317508501B = _id_43E0B9317508501B.array[keys[_id_AC0E594AC96AA3A8]];
    _id_AC0E594AC96AA3A8++;
  }
}

_id_8C913C3634F4A84E(keys) {
  _id_43E0B9317508501B = level._id_C3A0F3B16CCE4CA9.sfx;
  _id_AC0E594AC96AA3A8 = 0;

  foreach(key in keys) {
    if(keys.size > _id_AC0E594AC96AA3A8 + 1)
      _id_43E0B9317508501B = _id_43E0B9317508501B.array[key];
    else
      return _id_43E0B9317508501B.array[key];

    _id_AC0E594AC96AA3A8++;
  }
}

_id_CF9CEBE58C49F708(key) {
  if(!isDefined(self.array))
    self.array = [];

  if(!isDefined(self.array[key]))
    self.array[key] = spawnStruct();
}

_id_E3E506E52AACFB27(key, sfx) {
  if(!isDefined(self.array))
    self.array = [];

  if(!isDefined(self.array[key]))
    self.array[key] = sfx;
}

_id_FC7D07D4CC7AE9F1() {
  if(isDefined(self._id_C3A0F3B16CCE4CA9)) {
    return;
  }
  self._id_C3A0F3B16CCE4CA9 = spawnStruct();
  self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43 = 100;
  self._id_C3A0F3B16CCE4CA9.underwater = 0;
  self._id_C3A0F3B16CCE4CA9._id_57E7CD6A22985C6C = 0;
  self._id_C3A0F3B16CCE4CA9._id_F18247B2B3A09AD2 = 0;
  self._id_C3A0F3B16CCE4CA9._id_3551FAF33545C897 = 0;
  self._id_C3A0F3B16CCE4CA9.sprinting = 0;
  self._id_C3A0F3B16CCE4CA9._id_7FB1B36BDC873CAB = 0;
  self._id_C3A0F3B16CCE4CA9._id_82DFB94E8914EDAD = "none";
  _id_5BCF4E2BD107536F();
  thread _id_D2C67316E3340D42();
  thread deathcleanup();
  self endon("death");
  self endon("disconnect");
  self endon("showing_final_killcam");
  _id_EF73345010F390F4();
  childthread _id_0D126E1E30AAE39F();
  childthread _id_0DD2AF15C9306838();
}

_id_0D126E1E30AAE39F() {
  for(;;) {
    scripts\engine\utility::waittill_any_6("swim_begin", "swim_end", "swim_breathing_disabled_end", "swim_breathing_disabled_begin", "vehicle_enter", "vehicle_exit");
    _id_EF73345010F390F4();
  }
}

_id_EF73345010F390F4() {
  _id_C5B59EA2A6C2A709 = self _meth_E40102956C887F7C();
  _id_C490CB7A034DFC0A = self _meth_7EE20CF3C0390E21();

  if(_id_C490CB7A034DFC0A)
    _id_9A01935A05B613E4();
  else if(_id_C5B59EA2A6C2A709 && !_id_C490CB7A034DFC0A)
    _id_4594E9DCEBF2C645();
  else
    _id_0B66C4E6D072630C(1.5);

  if(_id_D3DB8FC9B08A281E() && !self._id_C3A0F3B16CCE4CA9.underwater)
    childthread _id_178428152F0B5E74();

  if(!_id_D3DB8FC9B08A281E() && self._id_C3A0F3B16CCE4CA9.underwater)
    childthread _id_8173A7A676C2AA00();

  self setclientomnvar("swim_under_water", self._id_C3A0F3B16CCE4CA9.underwater);
}

_id_D3DB8FC9B08A281E() {
  return self _meth_7EE20CF3C0390E21();
}

_id_0DD2AF15C9306838() {
  for(;;) {
    scripts\engine\utility::waittill_any_4("swim_begin", "swim_end", "vehicle_enter", "vehicle_exit");
    _id_4F0C9995F869868A();
  }
}

_id_4F0C9995F869868A() {
  if(_id_D59269BC793FE756() && !self._id_C3A0F3B16CCE4CA9._id_57E7CD6A22985C6C)
    childthread _id_4186D69A94FE93D9();

  if(!_id_D59269BC793FE756() && self._id_C3A0F3B16CCE4CA9._id_57E7CD6A22985C6C)
    childthread _id_1A0FCD6BAE3D2370();
}

_id_D59269BC793FE756() {
  return self _meth_E40102956C887F7C();
}

_id_D2C67316E3340D42() {
  _id_946B001669DE27FB = [self._id_C3A0F3B16CCE4CA9._id_18FE76D95D79D75F, self._id_C3A0F3B16CCE4CA9._id_28A9DBF4CE30FA86];
  _id_946B001669DE27FB = [self._id_C3A0F3B16CCE4CA9._id_18FE76D95D79D75F];
  scripts\engine\utility::waittill_any_3("death", "disconnect", "showing_final_killcam");

  foreach(_id_BED6393FB2E34B6A in _id_946B001669DE27FB) {
    if(isDefined(_id_BED6393FB2E34B6A))
      _id_BED6393FB2E34B6A destroy();
  }
}

deathcleanup() {
  self endon("disconnect");
  scripts\engine\utility::waittill_any_2("death", "showing_final_killcam");
  _id_3B00A7C45356A6E1();
}

_id_3B00A7C45356A6E1() {
  _id_40D220AFD2EB67B5();
  _id_179CDCE690151AD6();
  _id_38FE3B60E5ADF79C();
  _id_0AA183CA1083D279();
  self._id_C3A0F3B16CCE4CA9 = undefined;
}

_id_40D220AFD2EB67B5() {
  self setclientomnvar("swim_breath_meter_hide", 1);
}

_id_179CDCE690151AD6() {
  _id_0B66C4E6D072630C(0.05);
}

_id_38FE3B60E5ADF79C() {
  self setscriptablepartstate("swimDebris", "aboveWater");
  self setscriptablepartstate("swimBubbles", "aboveWater");
}

_id_8173A7A676C2AA00() {
  self notify("scr_change_breath_state");
  self endon("scr_change_breath_state");
  self._id_C3A0F3B16CCE4CA9.underwater = 0;
  childthread _id_39BC9721E2DA8F9C();
  childthread _id_458135EDD51D48B8();
  childthread _id_A3B4435C21F67884();
  childthread _id_DA4D3D2E5560FE3A();
  _id_0AA183CA1083D279();
  _id_542ADD828C78E976();
  self childthread[[level._id_C3A0F3B16CCE4CA9._id_0F6C33CF49E7246E]]();
}

_id_178428152F0B5E74() {
  self notify("scr_change_breath_state");
  self endon("scr_change_breath_state");
  self._id_C3A0F3B16CCE4CA9.underwater = 1;
  childthread _id_5D9E116115D3C60D();
  childthread _id_3B40F73C6038A3B0();
  childthread _id_FB5BFD7783364F80();
  childthread _id_E8C44B4B292C651D();
  childthread _id_3A7925B414E10C37();
  self childthread[[level._id_C3A0F3B16CCE4CA9._id_71106DD668C1BCAB]]();
}

_id_4186D69A94FE93D9() {
  self notify("scr_change_swim_state");
  self endon("scr_change_swim_state");
  self._id_C3A0F3B16CCE4CA9._id_57E7CD6A22985C6C = 1;
  self childthread[[level._id_C3A0F3B16CCE4CA9._id_DD47832CD570074B]]();
}

_id_1A0FCD6BAE3D2370() {
  self notify("scr_change_swim_state");
  self endon("scr_change_swim_state");
  self._id_C3A0F3B16CCE4CA9._id_57E7CD6A22985C6C = 0;
  self childthread[[level._id_C3A0F3B16CCE4CA9._id_BE3314F77FEF5D6B]]();
}

_id_1CF18F5E612E68C5() {
  return isDefined(self._id_C3A0F3B16CCE4CA9) && self._id_C3A0F3B16CCE4CA9.underwater;
}

_id_C5B59EA2A6C2A709() {
  return isDefined(self._id_C3A0F3B16CCE4CA9) && self._id_C3A0F3B16CCE4CA9._id_57E7CD6A22985C6C;
}

_id_0B66C4E6D072630C(time) {
  if(self._id_C3A0F3B16CCE4CA9._id_82DFB94E8914EDAD == "none") {
    return;
  }
  self._id_C3A0F3B16CCE4CA9._id_82DFB94E8914EDAD = "none";
  self clearsoundsubmix("player_swimming_underwater", 0.5);
  self clearsoundsubmix("iw9_player_drowning", 0);
  self clearsoundsubmix("iw9_underwater_vo", 1);
  self setentitysoundcontext("atmosphere", "");
  self clearclienttriggeraudiozone(time);
  _id_89613AD9DE3EF7E6();
}

_id_4594E9DCEBF2C645() {
  if(self._id_C3A0F3B16CCE4CA9._id_82DFB94E8914EDAD == "surface") {
    return;
  }
  self._id_C3A0F3B16CCE4CA9._id_82DFB94E8914EDAD = "surface";
  self clearsoundsubmix("player_swimming_underwater", 0.5);
  self clearsoundsubmix("iw9_player_drowning", 0);
  self clearsoundsubmix("iw9_underwater_vo", 1);
  self setentitysoundcontext("atmosphere", "water_surface");
  self clearclienttriggeraudiozone(1);
  _id_89613AD9DE3EF7E6();
}

_id_9A01935A05B613E4() {
  if(self._id_C3A0F3B16CCE4CA9._id_82DFB94E8914EDAD == "submerged") {
    return;
  }
  self._id_C3A0F3B16CCE4CA9._id_82DFB94E8914EDAD = "submerged";
  self setsoundsubmix("iw9_underwater_vo");
  self setsoundsubmix("player_swimming_underwater", 0.1);
  self setentitysoundcontext("atmosphere", "underwater");
  self setclienttriggeraudiozone("underwater", 0.1);
}

_id_2E58C560F3D8E570() {
  _id_23EEAA8C13B1CB24 = "mvmt_swim_gagging_plr_bubbles";
  _id_EFD3348B30946966 = "plr_breath_swim_pain_gag";

  if(soundexists(_id_23EEAA8C13B1CB24))
    self[[level._id_C3A0F3B16CCE4CA9._id_230B60EF0852DCB8]](_id_23EEAA8C13B1CB24);

  if(soundexists(_id_EFD3348B30946966))
    self[[level._id_C3A0F3B16CCE4CA9._id_230B60EF0852DCB8]](_id_EFD3348B30946966);
}

_id_57108400022FB733() {
  _id_23EEAA8C13B1CB24 = "mvmt_swim_plr_bubbles_light";
  _id_EFD3348B30946966 = "";

  if(_id_23EEAA8C13B1CB24 != "") {
    if(soundexists(_id_23EEAA8C13B1CB24))
      self[[level._id_C3A0F3B16CCE4CA9._id_230B60EF0852DCB8]](_id_23EEAA8C13B1CB24);
  }

  if(_id_EFD3348B30946966 != "") {
    if(soundexists(_id_EFD3348B30946966))
      self[[level._id_C3A0F3B16CCE4CA9._id_230B60EF0852DCB8]](_id_EFD3348B30946966);
  }
}

_id_38F601B8026C2203() {
  _id_23EEAA8C13B1CB24 = "mvmt_swim_gagging_plr_bubbles_critical";
  _id_EFD3348B30946966 = "plr_breath_swim_pain_choke";

  if(randomintrange(0, 1))
    _id_EFD3348B30946966 = "plr_breath_swim_pain_gag";

  if(soundexists(_id_23EEAA8C13B1CB24))
    self[[level._id_C3A0F3B16CCE4CA9._id_230B60EF0852DCB8]](_id_23EEAA8C13B1CB24);

  if(soundexists(_id_EFD3348B30946966))
    self[[level._id_C3A0F3B16CCE4CA9._id_230B60EF0852DCB8]](_id_EFD3348B30946966);
}

_id_89613AD9DE3EF7E6() {
  if(isDefined(level._id_C3A0F3B16CCE4CA9._id_B6064226993B9C1D))
    self[[level._id_C3A0F3B16CCE4CA9._id_B6064226993B9C1D]]();
}

_id_A3B4435C21F67884() {
  if(!_id_C2BE12529B0F0AD2()) {
    return;
  }
  self setscriptablepartstate("swimDebris", "aboveWater");
  self setscriptablepartstate("swimBubbles", "aboveWater");
}

_id_E8C44B4B292C651D() {
  if(!_id_C2BE12529B0F0AD2()) {
    return;
  }
  self setscriptablepartstate("swimDebris", "underWater");
  self setscriptablepartstate("swimBubbles", "bubblesEnter");
}

_id_3A2421785A1B420F() {
  thread _id_6932EC8F82987EE5("swim_gasp_bubbles", "swim_breathing_disabled_end", 3);
  self setscriptablepartstate("swimBubbles", "bubblesHeavy");
}

_id_110BE15783D6C5E2() {
  thread _id_6932EC8F82987EE5("swim_bubbles_light", "swim_breathing_disabled_end", 3);
}

_id_22D90D196EFBB4A8() {
  thread _id_6932EC8F82987EE5("swim_drowning_bubbles", "swim_breathing_disabled_end", 3);
}

_id_C15A079C936C458A(_id_23EEAA8C13B1CB24, _id_45210A8A70C2FAAB, _id_232AA0A9F1E032DD) {
  self[[level._id_C3A0F3B16CCE4CA9._id_230B60EF0852DCB8]](_id_23EEAA8C13B1CB24, _id_45210A8A70C2FAAB, _id_232AA0A9F1E032DD);
}

_id_6932EC8F82987EE5(vfx, _id_E0D4DC037C2D3FD9, timeout) {
  self endon("disconnect");
  playfxontagforclients(level._effect[vfx], self, "tag_eye", self);

  if(isDefined(_id_E0D4DC037C2D3FD9)) {
    _id_1CF86AF6F8A0266D(_id_E0D4DC037C2D3FD9, "death", timeout);
    killfxontag(level._effect[vfx], self, "tag_eye");
  }
}

_id_DA4D3D2E5560FE3A() {
  if(!_id_C2BE12529B0F0AD2()) {
    return;
  }
  _id_13C5657C0AF9C302();
}

_id_3A7925B414E10C37() {
  _id_7AB2D9E99262446F();
}

_id_13C5657C0AF9C302() {
  if(!isDefined(level.dyndof))
    self disablephysicaldepthoffieldscripting();
}

_id_7AB2D9E99262446F() {
  if(!isDefined(level.dyndof)) {
    self enablephysicaldepthoffieldscripting(1);
    self setphysicaldepthoffield(1.0, 200, 100);
    self setphysicalviewmodeldepthoffield(6.0, 100);
  }
}

_id_458135EDD51D48B8() {
  self._id_C3A0F3B16CCE4CA9._id_18FE76D95D79D75F fadeovertime(1);
  self._id_C3A0F3B16CCE4CA9._id_18FE76D95D79D75F.alpha = 0;
}

_id_3B40F73C6038A3B0() {
  self._id_C3A0F3B16CCE4CA9._id_18FE76D95D79D75F fadeovertime(0.05);

  for(;;) {
    waittillframeend;

    if(_id_C2BE12529B0F0AD2()) {
      _id_657CF180826FBB0B();
      _id_66CD16083CC71A78();
    }

    wait 0.05;
  }
}

_id_FB5BFD7783364F80() {
  _id_6FCFEDC89A8DC3D5 = 0;
  _id_21C40030C467A5F6 = _id_D4A3E79CC1808058();

  for(;;) {
    waittillframeend;

    if(_id_EA8199F09C110522()) {
      pulsetime = self._id_7FB1B36BDC873CAB.pulsetime;
      time = gettime();

      if(pulsetime > 0.9 && !_id_6FCFEDC89A8DC3D5) {
        if(_id_C2BE12529B0F0AD2()) {
          _id_CCBBA16287668F0A = scripts\engine\math::normalize_value(0, _id_21C40030C467A5F6, self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43);

          if(_id_CCBBA16287668F0A > 0.66)
            _id_7FB1B36BDC873CAB = "heartbeatLight";
          else if(_id_CCBBA16287668F0A > 0.33)
            _id_7FB1B36BDC873CAB = "heartbeatMed";
          else
            _id_7FB1B36BDC873CAB = "heartbeatHeavy";

          childthread _id_15047AF555F1F9A0::_id_B7C36A804415225B(_id_7FB1B36BDC873CAB);
        }

        _id_6FCFEDC89A8DC3D5 = 1;
      } else if(pulsetime < 0.5 && _id_6FCFEDC89A8DC3D5)
        _id_6FCFEDC89A8DC3D5 = 0;
    }

    wait 0.05;
  }
}

_id_5D9E116115D3C60D() {
  if(getdvarint("dvar_042DEEB1FB385C72", 1) == 1 && !_id_E03AB781FBC71E19())
    self setclientomnvar("swim_breath_meter_hide", 0);

  _id_4AB9ECB27B15881D = _id_90C418D9BAE08D74(0.66);
  _id_4AB9E9B27B158184 = _id_90C418D9BAE08D74(0.33);
  starttime = gettime();
  godmode = 0;

  for(;;) {
    while(self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43 > 0) {
      godmode = 0;
      _id_FD9F67F7FB502BD3 = [[_id_706E311766A84377()]]();

      if(getdvarint("dvar_2A4F08BC79265550"))
        self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43 = 100;
      else {
        if(istrue(self._id_5239162658BE30D6) && istrue(self.gasmaskequipped))
          self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43 = 100;

        if(!_id_9B65944D3CE0F852()) {
          self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43 = self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43 - 100 / _id_FD9F67F7FB502BD3 * 0.05;
          self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43 = clamp(self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43, 0, 100);
        }
      }

      if(self _meth_635E39FC16A64657() && !self._id_C3A0F3B16CCE4CA9.sprinting) {
        self setclientomnvar("swim_breath_meter_sprint", 1);
        self._id_C3A0F3B16CCE4CA9.sprinting = 1;
      } else if(!self _meth_635E39FC16A64657() && self._id_C3A0F3B16CCE4CA9.sprinting) {
        self setclientomnvar("swim_breath_meter_sprint", 0);
        self._id_C3A0F3B16CCE4CA9.sprinting = 0;
      }

      if(!_id_4AB9ECB27B15881D && _id_90C418D9BAE08D74(0.66)) {
        _id_9400BC0468CD1C5E();
        _id_4AB9ECB27B15881D = 1;
      }

      if(!_id_4AB9E9B27B158184 && _id_90C418D9BAE08D74(0.33)) {
        _id_9400BC0468CD1C5E();
        _id_4AB9E9B27B158184 = 1;
      }

      if(!_id_7E903535100A53F3() && _id_3776BACC92B445D3())
        _id_F53F052EC435E9C5();

      if(!_id_EA8199F09C110522() && _id_E40B04D1193AA8C3()) {
        _id_2635B692C9C491B4();
        _id_1BB8793F81F3DD35();
      }

      self setclientomnvar("swim_breath_meter_percent", int(self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43));
      self _meth_746D32FAC66E0B73(int(self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43));
      wait 0.05;
    }

    godmode = _id_B647FD6FEBD8E530(godmode);
  }
}

_id_B647FD6FEBD8E530(_id_3A2752E045B138AB) {
  self endon("swim_stop_drowning");
  self notify("swim_start_drowning");
  _id_CECFCB613CCBACBA = undefined;

  if(_id_3A2752E045B138AB)
    wait 0.5;
  else {
    _id_9AB56EFF95D3D9B7();

    if(1) {
      self setclienttriggeraudiozone("underwater_deathsdoor", 4);

      if(isDefined(level._id_372A9EAB717E5D8D))
        _id_66C1FA3CB97E511D = level._id_372A9EAB717E5D8D;
      else
        _id_66C1FA3CB97E511D = "drowning";

      self[[level._id_C3A0F3B16CCE4CA9._id_A699C74CE724A801]](_id_66C1FA3CB97E511D, 3.6);
      childthread _id_40DE065884E608BF(4);
    }

    starttime = gettime();

    for(;;) {
      waitframe();

      if(gettime() - starttime > 4000) {
        break;
      }
    }

    _id_4D1EAA072369AD4B();
    _id_CECFCB613CCBACBA = self[[level._id_C3A0F3B16CCE4CA9._id_E1B16133A0146153]]();
  }

  self dodamage(self.health + 10000, self.origin, self, self, "MOD_SUICIDE", _id_CECFCB613CCBACBA, "torso_upper");
  return 1;
}

_id_9368FFF2B3156346(_id_E2A66DD8A90FBD3F) {
  if(!isDefined(self._id_C3A0F3B16CCE4CA9)) {
    return;
  }
  self._id_C3A0F3B16CCE4CA9._id_6D1E5466170AC355 = scripts\engine\utility::ter_op(_id_E2A66DD8A90FBD3F, 1, undefined);
}

_id_9B65944D3CE0F852() {
  if(!isDefined(self._id_C3A0F3B16CCE4CA9))
    return 0;

  return istrue(self._id_C3A0F3B16CCE4CA9._id_6D1E5466170AC355);
}

_id_F295BD882C3D52F5(_id_E2A66DD8A90FBD3F) {
  if(!isDefined(self._id_C3A0F3B16CCE4CA9)) {
    return;
  }
  self._id_C3A0F3B16CCE4CA9._id_4DEA8364F3A0EC2E = scripts\engine\utility::ter_op(_id_E2A66DD8A90FBD3F, 1, undefined);
}

_id_E03AB781FBC71E19() {
  if(!isDefined(self._id_C3A0F3B16CCE4CA9))
    return 0;

  return istrue(self._id_C3A0F3B16CCE4CA9._id_4DEA8364F3A0EC2E);
}

_id_40DE065884E608BF(timer) {
  self endon("death_or_disconnect");
  level endon("mission_fail");
  level endon("game_ended");
  _id_AD2608B0A1F1873D = 0.6;

  for(;;) {
    _id_21DAFDBA97771DE8();
    waittime = randomfloatrange(0.8, 1.15) + _id_AD2608B0A1F1873D;
    wait(waittime);
    timer = timer - waittime;

    if(self getclientomnvar("swim_breath_meter_critical") == 3 || !self._id_C3A0F3B16CCE4CA9._id_3551FAF33545C897 || timer <= 0) {
      break;
    }

    _id_AD2608B0A1F1873D = _id_AD2608B0A1F1873D - 0.3;
    _id_AD2608B0A1F1873D = clamp(_id_AD2608B0A1F1873D, 0, 1);
  }
}

_id_A05DE828303D4BED() {
  if(_id_BAB53C4F3C6062B9()) {
    if(1)
      childthread _id_7A964640CF87F4FA();

    self._id_C3A0F3B16CCE4CA9._id_3551FAF33545C897 = 0;
    self notify("swim_stop_drowning");
  }
}

_id_7A964640CF87F4FA() {
  self endon("swim_start_drowning");
  self[[level._id_C3A0F3B16CCE4CA9._id_A699C74CE724A801]]("drowning_cleared", 1);
  wait 1.05;
  self[[level._id_C3A0F3B16CCE4CA9._id_A699C74CE724A801]]("", 1);
}

_id_39BC9721E2DA8F9C() {
  while(self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43 < 100) {
    self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43 = self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43 + 0.05 / [[level._id_C3A0F3B16CCE4CA9._id_A1E7FB7B162A7323]]() * 100;
    self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43 = clamp(self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43, 1, 100);
    self setclientomnvar("swim_breath_meter_percent", int(self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43));
    self _meth_746D32FAC66E0B73(int(self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43));
    wait 0.05;
  }

  self setclientomnvar("swim_breath_meter_hide", 1);
}

_id_8C3428AEB7C8B1F4(amount, _id_3918DD3A9B1B12A9) {
  self endon("scr_change_breath_state");
  _id_2AE11B9A5459E669 = level._id_C3A0F3B16CCE4CA9._id_A1E7FB7B162A7323;

  if(isDefined(_id_3918DD3A9B1B12A9))
    _id_2AE11B9A5459E669 = _id_3918DD3A9B1B12A9;

  while(self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43 <= amount) {
    self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43 = self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43 + 0.05 / [[_id_2AE11B9A5459E669]]() * amount;
    self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43 = clamp(self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43, 1, 100);
    self setclientomnvar("swim_breath_meter_percent", int(self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43));
    self _meth_746D32FAC66E0B73(int(self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43));
    _id_21C40030C467A5F6 = _id_D4A3E79CC1808058();

    if(self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43 > _id_21C40030C467A5F6 && _id_EA8199F09C110522()) {
      _id_0AA183CA1083D279();
      self clearsoundsubmix("iw9_player_drowning", 0);
      self setclienttriggeraudiozone("underwater", 5);
    }

    _id_F4B8BED767C66786 = _id_75A367E461C6389A();

    if(self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43 > _id_F4B8BED767C66786 && _id_7E903535100A53F3())
      _id_542ADD828C78E976();

    wait 0.05;
  }
}

_id_1BB8793F81F3DD35() {
  if(!_id_C2BE12529B0F0AD2()) {
    return;
  }
  _id_2E58C560F3D8E570();
  _id_3A2421785A1B420F();
}

_id_9400BC0468CD1C5E() {
  _id_57108400022FB733();
  _id_110BE15783D6C5E2();
}

_id_21DAFDBA97771DE8() {
  if(!_id_C2BE12529B0F0AD2()) {
    return;
  }
  _id_38F601B8026C2203();
  _id_22D90D196EFBB4A8();
}

_id_657CF180826FBB0B() {
  _id_21C40030C467A5F6 = _id_D4A3E79CC1808058();

  if(isDefined(level._id_19D38DEC02A818CE) && [[level._id_19D38DEC02A818CE]]("player", "updateSwimOverlayColor")) {
    _id_83F38CC857568F42 = [[level._id_49B393A31D0B0B95]]("player", "updateSwimOverlayColor");
    color = [[_id_83F38CC857568F42]](self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43, _id_EA8199F09C110522(), _id_21C40030C467A5F6, 100);
    self._id_C3A0F3B16CCE4CA9._id_18FE76D95D79D75F.color = color;
  } else {
    if(_id_EA8199F09C110522()) {
      _id_DD54D673ACB97122 = (0.2, 0.1, 0.1);
      _id_DD31E073AC933F68 = (0.25, 0.05, 0.05);
      _id_CCBBA16287668F0A = scripts\engine\math::normalize_value(0, _id_21C40030C467A5F6, self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43);
    } else {
      _id_DD54D673ACB97122 = (0.2, 0.2, 0.2);
      _id_DD31E073AC933F68 = (0.1, 0.1, 0.1);
      _id_CCBBA16287668F0A = scripts\engine\math::normalize_value(_id_21C40030C467A5F6, 100, self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43);
    }

    color = scripts\engine\math::factor_value(_id_DD31E073AC933F68, _id_DD54D673ACB97122, _id_CCBBA16287668F0A);
    self._id_C3A0F3B16CCE4CA9._id_18FE76D95D79D75F.color = color;
  }
}

_id_66CD16083CC71A78() {
  _id_21C40030C467A5F6 = _id_D4A3E79CC1808058();

  if(_id_EA8199F09C110522()) {
    _id_BB45E9E6F61E1633 = 0.1;
    _id_E3C581A803BD0FA5 = 0.2;
    _id_3179113A20B106B9 = 0.5;
    _id_1E4A3810E3CCE69F = 0.75;
    _id_CCBBA16287668F0A = scripts\engine\math::normalize_value(0, _id_21C40030C467A5F6, self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43);
  } else {
    _id_BB45E9E6F61E1633 = 0.0;
    _id_E3C581A803BD0FA5 = 0.3;
    _id_3179113A20B106B9 = 0.2;
    _id_1E4A3810E3CCE69F = 0.6;
    _id_CCBBA16287668F0A = scripts\engine\math::normalize_value(_id_21C40030C467A5F6, 100, self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43);
  }

  maxalpha = scripts\engine\math::factor_value(_id_1E4A3810E3CCE69F, _id_3179113A20B106B9, _id_CCBBA16287668F0A);
  _id_E26B36A6DF3106DD = scripts\engine\math::factor_value(_id_E3C581A803BD0FA5, _id_BB45E9E6F61E1633, _id_CCBBA16287668F0A);
  self._id_C3A0F3B16CCE4CA9._id_18FE76D95D79D75F.alpha = scripts\engine\math::factor_value(_id_E26B36A6DF3106DD, maxalpha, self._id_7FB1B36BDC873CAB.pulsetime);
}

_id_3776BACC92B445D3() {
  if(!isDefined(self._id_C3A0F3B16CCE4CA9))
    return 0;

  _id_62F2A5497A3C2C34 = _id_75A367E461C6389A();
  return self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43 < _id_62F2A5497A3C2C34;
}

_id_EA8199F09C110522() {
  return self._id_C3A0F3B16CCE4CA9._id_F18247B2B3A09AD2;
}

_id_BAB53C4F3C6062B9() {
  return self._id_C3A0F3B16CCE4CA9._id_3551FAF33545C897;
}

_id_7E903535100A53F3() {
  return self._id_C3A0F3B16CCE4CA9._id_7FB1B36BDC873CAB;
}

_id_E40B04D1193AA8C3() {
  if(!isDefined(self._id_C3A0F3B16CCE4CA9))
    return 0;

  _id_21C40030C467A5F6 = _id_D4A3E79CC1808058();
  return self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43 < _id_21C40030C467A5F6;
}

_id_90C418D9BAE08D74(_id_BB85A75787C26D48) {
  if(!isDefined(self._id_C3A0F3B16CCE4CA9))
    return 0;

  _id_62CF7F9CE94B7F89 = _id_0317E02DCA870DFF(_id_BB85A75787C26D48);
  return self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43 < _id_62CF7F9CE94B7F89;
}

_id_0AA183CA1083D279() {
  self setclientomnvar("swim_breath_meter_critical", 0);

  if(isDefined(self._id_C3A0F3B16CCE4CA9)) {
    self._id_C3A0F3B16CCE4CA9._id_F18247B2B3A09AD2 = 0;
    _id_A05DE828303D4BED();
  }
}

_id_2635B692C9C491B4() {
  self setclienttriggeraudiozone("underwater_drowning", 5);
  self setsoundsubmix("iw9_player_drowning", 5);
  self._id_C3A0F3B16CCE4CA9._id_F18247B2B3A09AD2 = 1;
  self setclientomnvar("swim_breath_meter_critical", 1);
}

_id_542ADD828C78E976() {
  self._id_C3A0F3B16CCE4CA9._id_7FB1B36BDC873CAB = 0;
}

_id_F53F052EC435E9C5() {
  self._id_C3A0F3B16CCE4CA9._id_7FB1B36BDC873CAB = 1;
  self notify("startHeartbeatPulse");
}

_id_9AB56EFF95D3D9B7() {
  self._id_C3A0F3B16CCE4CA9._id_3551FAF33545C897 = 1;
  self setclientomnvar("swim_breath_meter_critical", 2);
}

_id_4D1EAA072369AD4B() {
  self setclientomnvar("swim_breath_meter_critical", 3);
}

_id_102C01B146EEDC7D() {
  if(!isDefined(self._id_C3A0F3B16CCE4CA9))
    return 0;

  _id_F4B8BED767C66786 = _id_75A367E461C6389A();
  return self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43 < _id_F4B8BED767C66786;
}

_id_75A367E461C6389A() {
  _id_FD9F67F7FB502BD3 = [[_id_706E311766A84377()]]();
  _id_80574E7BBDE66C18 = _id_FD9F67F7FB502BD3 - 6;
  return _id_80574E7BBDE66C18 / _id_FD9F67F7FB502BD3 * 100;
}

_id_D4A3E79CC1808058() {
  _id_FD9F67F7FB502BD3 = [[_id_706E311766A84377()]]();
  _id_647E0301D37AEBF7 = [[level._id_C3A0F3B16CCE4CA9._id_575E6F276810675E]]();
  return _id_647E0301D37AEBF7 / _id_FD9F67F7FB502BD3 * 100;
}

_id_0317E02DCA870DFF(_id_BB85A75787C26D48) {
  _id_FD9F67F7FB502BD3 = [[_id_706E311766A84377()]]();
  _id_647E0301D37AEBF7 = [[level._id_C3A0F3B16CCE4CA9._id_575E6F276810675E]]();
  _id_71C2D4C5700674F7 = _id_647E0301D37AEBF7 + _id_BB85A75787C26D48 * (_id_FD9F67F7FB502BD3 - _id_647E0301D37AEBF7);
  return _id_71C2D4C5700674F7 / _id_FD9F67F7FB502BD3 * 100;
}

_id_B1B34805F6F1B18F() {
  _id_FD9F67F7FB502BD3 = [[_id_706E311766A84377()]]();
  return _id_FD9F67F7FB502BD3 * (self._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43 / 100);
}

_id_5BCF4E2BD107536F() {
  self._id_C3A0F3B16CCE4CA9._id_18FE76D95D79D75F = newclienthudelem(self);
  self._id_C3A0F3B16CCE4CA9._id_18FE76D95D79D75F.sort = 1;
  self._id_C3A0F3B16CCE4CA9._id_18FE76D95D79D75F.x = 0;
  self._id_C3A0F3B16CCE4CA9._id_18FE76D95D79D75F.y = 0;
  self._id_C3A0F3B16CCE4CA9._id_18FE76D95D79D75F.alignx = "left";
  self._id_C3A0F3B16CCE4CA9._id_18FE76D95D79D75F.aligny = "top";
  self._id_C3A0F3B16CCE4CA9._id_18FE76D95D79D75F.foreground = 0;
  self._id_C3A0F3B16CCE4CA9._id_18FE76D95D79D75F.lowresbackground = 1;
  self._id_C3A0F3B16CCE4CA9._id_18FE76D95D79D75F.horzalign = "fullscreen";
  self._id_C3A0F3B16CCE4CA9._id_18FE76D95D79D75F.vertalign = "fullscreen";
  self._id_C3A0F3B16CCE4CA9._id_18FE76D95D79D75F.alpha = 0;
  self._id_C3A0F3B16CCE4CA9._id_18FE76D95D79D75F setshader("hud_swim_vignette", 640, 480);
}

_id_1CF86AF6F8A0266D(_id_FBF2C60DF6D0D655, _id_FBF2C30DF6D0CFBC, timer) {
  self endon(_id_FBF2C60DF6D0D655);
  self endon(_id_FBF2C30DF6D0CFBC);
  wait(timer);
}

_id_C2BE12529B0F0AD2() {
  return !isDefined(self.usingremote);
}

_id_706E311766A84377() {
  if(isDefined(self._id_DC6DC154664CF0AA))
    return self._id_DC6DC154664CF0AA;
  else
    return level._id_C3A0F3B16CCE4CA9._id_DC6DC154664CF0AA;
}