/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\auto_ascender.gsc
***********************************************/

init() {
  setdvarifuninitialized("dvar_01726C98446555F2", 360.0);
  setdvarifuninitialized("dvar_89E4C06F52246B50", 460.0);
  setdvarifuninitialized("dvar_23ED39C8F9324FFE", 540.0);
  level.ascendstarts = scripts\engine\utility::getStructArray("ascend_begin", "script_noteworthy");
  level.descendstarts = scripts\engine\utility::getStructArray("descend_begin", "script_noteworthy");
  level.ascendstructs = [];

  foreach(a in level.ascendstarts)
  markupascenderstruct(a, 1);

  foreach(a in level.descendstarts)
  markupascenderstruct(a, 0);

  initanimtree();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("ascender", ::ascenderscriptableused);
}

_id_68FE08D119BBD54F() {
  return 360.0;
}

_id_9412C45E2BC1218B() {
  return 460.0;
}

_id_F3C35AACFBE68158() {
  return 540.0;
}

_id_99E7D00E9D903C57() {
  return 0.4;
}

_id_CA18084BDCC82EA8() {
  return 0.15;
}

_id_211B63898BA23E96() {
  return 12100;
}

_id_9BB960F8F80F543F() {
  return 72;
}

#using_animtree("script_model");

initanimtree() {
  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"]["ascender_up_in"] = % vm_eq_ascender_up_get_on_plr;
  level.scr_animname["player"]["ascender_up_in"] = "vm_eq_ascender_up_get_on_plr";
  level.scr_eventanim["player"]["ascender_up_in"] = "ascender_up_in";
  level.scr_anim["player"]["ascender_up_loop"] = % vm_eq_ascender_up_loop_plr;
  level.scr_animname["player"]["ascender_up_loop"] = "vm_eq_ascender_up_loop_plr";
  level.scr_eventanim["player"]["ascender_up_loop"] = "ascender_up_loop";
  level.scr_anim["player"]["ascender_up_out"] = % vm_eq_ascender_up_get_off_plr;
  level.scr_animname["player"]["ascender_up_out"] = "vm_eq_ascender_up_get_off_plr";
  level.scr_eventanim["player"]["ascender_up_out"] = "ascender_up_out";
  level.scr_anim["player"]["ascender_down_in"] = % vm_eq_ascender_down_get_on_plr;
  level.scr_animname["player"]["ascender_down_in"] = "vm_eq_ascender_down_get_on_plr";
  level.scr_eventanim["player"]["ascender_down_in"] = "ascender_down_in";
  level.scr_anim["player"]["ascender_down_loop"] = % vm_eq_ascender_down_loop_plr;
  level.scr_animname["player"]["ascender_down_loop"] = "vm_eq_ascender_down_loop_plr";
  level.scr_eventanim["player"]["ascender_down_loop"] = "ascender_down_loop";
  level.scr_anim["player"]["ascender_down_out"] = % vm_eq_ascender_down_get_off_plr;
  level.scr_animname["player"]["ascender_down_out"] = "vm_eq_ascender_down_get_off_plr";
  level.scr_eventanim["player"]["ascender_down_out"] = "ascender_down_out";
  level.scr_animtree["device"] = #animtree;
  level.scr_anim["device"]["ascender_up_in"] = % vm_eq_ascender_up_get_on_ascender;
  level.scr_animname["device"]["ascender_up_in"] = "vm_eq_ascender_up_get_on_ascender";
  level.scr_eventanim["device"]["ascender_up_in"] = "ascender_up_in";
  level.scr_anim["device"]["ascender_up_loop"] = % vm_eq_ascender_up_loop_ascender;
  level.scr_animname["device"]["ascender_up_loop"] = "vm_eq_ascender_up_loop_ascender";
  level.scr_eventanim["device"]["ascender_up_loop"] = "ascender_up_loop";
  level.scr_anim["device"]["ascender_up_out"] = % vm_eq_ascender_up_get_off_ascender;
  level.scr_animname["device"]["ascender_up_out"] = "vm_eq_ascender_up_get_off_ascender";
  level.scr_eventanim["device"]["ascender_up_out"] = "ascender_up_out";
  level.scr_anim["device"]["ascender_down_in"] = % vm_eq_ascender_down_get_on_ascender;
  level.scr_animname["device"]["ascender_down_in"] = "vm_eq_ascender_down_get_on_ascender";
  level.scr_eventanim["device"]["ascender_down_in"] = "ascender_down_in";
  level.scr_anim["device"]["ascender_down_loop"] = % vm_eq_ascender_down_loop_ascender;
  level.scr_animname["device"]["ascender_down_loop"] = "vm_eq_ascender_down_loop_ascender";
  level.scr_eventanim["device"]["ascender_down_loop"] = "ascender_down_loop";
  level.scr_anim["device"]["ascender_down_out"] = % vm_eq_ascender_down_get_off_ascender;
  level.scr_animname["device"]["ascender_down_out"] = "vm_eq_ascender_down_get_off_ascender";
  level.scr_eventanim["device"]["ascender_down_out"] = "ascender_down_out";
  level.scr_animtree["device"] = #animtree;
  level.scr_anim["device"]["ascender_up_in_wm"] = % wm_eq_ascender_up_get_on_ascender;
  level.scr_animname["device"]["ascender_up_in_wm"] = "wm_eq_ascender_up_get_on_ascender";
  level.scr_eventanim["device"]["ascender_up_in_wm"] = "ascender_up_in";
  level.scr_anim["device"]["ascender_up_loop_wm"] = % wm_eq_ascender_up_loop_ascender;
  level.scr_animname["device"]["ascender_up_loop_wm"] = "wm_eq_ascender_up_loop_ascender";
  level.scr_eventanim["device"]["ascender_up_loop_wm"] = "ascender_up_loop";
  level.scr_anim["device"]["ascender_up_out_wm"] = % wm_eq_ascender_up_get_off_ascender;
  level.scr_animname["device"]["ascender_up_out_wm"] = "wm_eq_ascender_up_get_off_ascender";
  level.scr_eventanim["device"]["ascender_up_out_wm"] = "ascender_up_out";
  level.scr_anim["device"]["ascender_down_in_wm"] = % wm_eq_ascender_down_get_on_ascender;
  level.scr_animname["device"]["ascender_down_in_wm"] = "wm_eq_ascender_down_get_on_ascender";
  level.scr_eventanim["device"]["ascender_down_in_wm"] = "ascender_down_in";
  level.scr_anim["device"]["ascender_down_loop_wm"] = % wm_eq_ascender_down_loop_ascender;
  level.scr_animname["device"]["ascender_down_loop_wm"] = "wm_eq_ascender_down_loop_ascender";
  level.scr_eventanim["device"]["ascender_down_loop_wm"] = "ascender_down_loop";
  level.scr_anim["device"]["ascender_down_out_wm"] = % wm_eq_ascender_down_get_off_ascender;
  level.scr_animname["device"]["ascender_down_out_wm"] = "wm_eq_ascender_down_get_off_ascender";
  level.scr_eventanim["device"]["ascender_down_out_wm"] = "ascender_down_out";
}

markupascenderstruct(struct, dir) {
  if(!isDefined(struct.targetname)) {
    msg = "auto_ascender.gsc::markupAscenderStruct() passed struct with no targetname at posx:" + struct.origin[0] + " y:" + struct.origin[1] + " z:" + struct.origin[2];
    scripts\engine\utility::error(msg);
    return;
  }

  _id_D0697AF2ECA83D63 = scripts\engine\utility::getStruct(struct.target, "targetname");
  _id_EDD7DFCCCAD431F8 = scripts\engine\utility::getStruct(_id_D0697AF2ECA83D63.target, "targetname");
  level.ascendstructs[struct.targetname] = struct;
  struct.ascendstructend = _id_D0697AF2ECA83D63;
  struct.ascendstructout = _id_EDD7DFCCCAD431F8;
  struct.inuse = 0;
  struct.exitangle = struct.angles + (0, 180, 0);
  struct.startangle = struct.angles;
  struct.dir = dir;

  if(struct.targetname == "pf57045_auto38" || struct.targetname == "pf57045_auto41") {
    struct.origin = struct.origin + (0, 0, 8);
    _id_D0697AF2ECA83D63.origin = _id_D0697AF2ECA83D63.origin + (0, 0, 8);
    _id_EDD7DFCCCAD431F8.origin = _id_EDD7DFCCCAD431F8.origin + (0, 0, 8);
  }
}

ascenderscriptableused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(state == "on") {
    if(istrue(player.usingascender)) {
      return;
    }
    thread ascenderuse(instance, player);
  }
}

_id_3AF132AED5F667C5() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("denyAscendMessage");
  self endon("denyAscendMessage");
  self playsoundtoplayer("ui_select_purchase_deny", self);

  if(isDefined(level.ascendermsgfunc))
    self[[level.ascendermsgfunc]]("ascender_blocked_generic", 4);
  else {
    scripts\mp\utility\lower_message::setlowermessageomnvar("ascender_blocked_generic");
    wait 4;
    scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  }
}

denyascendmessagelaststand() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("denyAscendMessageLastStand");
  self endon("denyAscendMessageLastStand");
  self playsoundtoplayer("ui_select_purchase_deny", self);

  if(isDefined(level.ascendermsgfunc))
    self[[level.ascendermsgfunc]]("ascender_blocked_laststand", 4);
  else {
    scripts\mp\utility\lower_message::setlowermessageomnvar("ascender_blocked_laststand");
    wait 4;
    scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  }
}

denyascendmessage() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("denyAscendMessage");
  self endon("denyAscendMessage");
  self playsoundtoplayer("ui_select_purchase_deny", self);

  if(isDefined(level.ascendermsgfunc))
    self[[level.ascendermsgfunc]]("ascender_blocked", 4);
  else {
    scripts\mp\utility\lower_message::setlowermessageomnvar("ascender_blocked");
    wait 4;
    scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  }
}

ascenddeathlistener(_id_DA39C6D2E190D5C9) {
  level endon("game_ended");
  self endon("ascend_complete");
  self endon("ascend_solo_complete");
  self endon("ascender_cancel");
  scripts\engine\utility::waittill_any_2("death_or_disconnect", "last_stand_start");

  if(isDefined(self))
    self stopanimscriptsceneevent();

  _id_DA39C6D2E190D5C9 cleanupascenduse(self);
}

endascenderanim(player, dir, ascendermodelview, ascendermodelworld) {
  player endon("death_or_disconnect");
  player endon("ascender_cancel");

  if(dir)
    _id_45AE85538855919B = "ascender_up_out";
  else
    _id_45AE85538855919B = "ascender_down_out";

  thread scripts\mp\anim::anim_player_solo(player, player.player_rig, _id_45AE85538855919B);
  scripts\common\anim::anim_single_solo(ascendermodelworld, _id_45AE85538855919B + "_wm");
}

startascenderanim(player, dir, ascendermodelview, ascendermodelworld) {
  player endon("death_or_disconnect");
  player endon("ascender_cancel");
  player thread scripts\mp\utility\infilexfil::infil_player_rig_updated("player", player.origin, player.angles);
  ascendermodelview.animname = "device";
  ascendermodelview scripts\common\anim::setanimtree();
  ascendermodelworld.animname = "device";
  ascendermodelworld scripts\common\anim::setanimtree();
  ascendermodelworld hide();
  _id_A08D86A9E7AAFC47 = (1, 0, 0);

  if(dir) {
    _id_9150BC085D41F530 = "TAG_ACCESSORY_RIGHT";
    _id_298EE9614AE698AE = "ascender_up_in";
    _id_A08D86A9E7AAFC47 = rotatevector((-40.9464, 22.9807, 0), self.angles);
  } else {
    _id_9150BC085D41F530 = "TAG_ACCESSORY_LEFT";
    _id_298EE9614AE698AE = "ascender_down_in";
    _id_A08D86A9E7AAFC47 = rotatevector((-42.2388, -23.4915, 0), self.angles);
  }

  player.player_rig moveTo(self.origin + _id_A08D86A9E7AAFC47, 0.4, 0.1, 0.1);
  fwd = vectorNormalize(_id_A08D86A9E7AAFC47 * -1);
  _id_8003B0D4F9FBEE0E = vectortoanglessafe(fwd, (0, 0, 1));
  player.player_rig rotateTo(_id_8003B0D4F9FBEE0E, 0.4, 0.1, 0.1);
  _id_CD9982ADB17761A8 = gettime();
  player scripts\cp_mp\utility\inventory_utility::_id_FC6A5B145563BE33();
  _id_698CC218E4ADE75F = gettime();
  _id_218F64CB035D54BE = 0.4 - (_id_698CC218E4ADE75F - _id_CD9982ADB17761A8) / 1000.0;
  waittime = max(0, _id_218F64CB035D54BE);
  wait(waittime);
  ascendermodelworld show();
  ascendermodelworld hidefromplayer(player);
  player.player_rig linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  ascendermodelview linkTo(player.player_rig, _id_9150BC085D41F530, (0, 0, 0), (0, 0, 0));
  ascendermodelworld linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  player.player_rig showonlytoplayer(player);
  scripts\common\anim::anim_first_frame_solo(player.player_rig, _id_298EE9614AE698AE);
  thread scripts\mp\anim::anim_player_solo(player, player.player_rig, _id_298EE9614AE698AE);
  thread scripts\common\anim::anim_single_solo(ascendermodelworld, _id_298EE9614AE698AE + "_wm");
  _id_5018A9A0D40ED758 = getanimlength(level.scr_anim["player"][_id_298EE9614AE698AE]);
  wait(_id_5018A9A0D40ED758);
}

loopwaitanim(scenenode, ascendermodelview, ascendermodelworld, dir) {
  self endon("death_or_disconnect");
  self endon("ascender_loop_done");
  self endon("ascender_cancel");

  if(dir)
    _id_B164EBCED1CBE96C = "ascender_up_loop";
  else
    _id_B164EBCED1CBE96C = "ascender_down_loop";

  animlength = getanimlength(level.scr_anim["player"][_id_B164EBCED1CBE96C]);

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    scenenode thread scripts\mp\anim::anim_player_solo(self, self.player_rig, _id_B164EBCED1CBE96C);
    scenenode scripts\common\anim::anim_single_solo(ascendermodelworld, _id_B164EBCED1CBE96C + "_wm");

    if(!isDefined(animlength) || animlength == 0) {
      break;
    }

    wait(animlength);
  }
}

_id_3070AAB95202A0E6(instance, player) {
  if(player isswitchingweapon()) {
    player thread _id_3AF132AED5F667C5();
    return 0;
  }

  if(player scripts\cp_mp\utility\player_utility::isinvehicle()) {
    player thread _id_3AF132AED5F667C5();
    return 0;
  }

  if(istrue(player.insertingarmorplate)) {
    player thread _id_3AF132AED5F667C5();
    return 0;
  }

  if(istrue(player.inlaststand)) {
    player thread denyascendmessagelaststand();
    return 0;
  }

  if(istrue(player.isreviving))
    return 0;

  if(!player _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("ascender_use")) {
    player thread _id_3AF132AED5F667C5();
    return 0;
  }

  if(player isskydiving())
    return 0;

  _id_DA39C6D2E190D5C9 = level.ascendstructs[instance.target];

  if(!isDefined(_id_DA39C6D2E190D5C9))
    return 0;

  if(_id_DA39C6D2E190D5C9.inuse) {
    player thread denyascendmessage();
    return 0;
  }

  if(isDefined(_id_DA39C6D2E190D5C9.sololink) && istrue(_id_DA39C6D2E190D5C9.sololink.inuse)) {
    player thread denyascendmessage();
    return 0;
  }

  return 1;
}

ascenderuse(instance, player) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("ascender_cancel");

  if(getdvarint("dvar_A24172489F2B8A69", 0) > 0)
    player endon("last_stand");

  if(!_id_3070AAB95202A0E6(instance, player)) {
    return;
  }
  _id_DA39C6D2E190D5C9 = level.ascendstructs[instance.target];

  if(getdvarint("dvar_A24172489F2B8A69", 0) <= 0)
    player.shouldskiplaststand = 1;

  _id_DA39C6D2E190D5C9.ascender = spawn("script_model", _id_DA39C6D2E190D5C9.origin);
  _id_DA39C6D2E190D5C9.ascender setModel("tag_origin");
  _id_DA39C6D2E190D5C9.scriptable = instance;

  if(player getstance() != "stand")
    player setstance("stand");

  player _id_3B64EB40368C1450::set("ascender", "melee", 0);
  player _id_3B64EB40368C1450::set("ascender", "ads", 0);
  player _id_3B64EB40368C1450::set("ascender", "fire", 0);

  if(istrue(player.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "canUseWeaponPickups")) {
      _id_32593FDCD227DBD9 = player[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "canUseWeaponPickups")]]();

      if(istrue(_id_32593FDCD227DBD9))
        player _id_3B64EB40368C1450::set("ascender", "weapon_switch", 0);
    }
  } else {
    player _id_3B64EB40368C1450::set("ascender", "offhand_weapons", 0);
    player _id_3B64EB40368C1450::set("ascender", "killstreaks", 0);
    player _id_3B64EB40368C1450::set("ascender", "weapon_switch", 0);
  }

  _id_DA39C6D2E190D5C9.ascender scripts\cp_mp\ent_manager::registerspawncount(2);
  _id_DA39C6D2E190D5C9.inuse = 1;
  player.usingascender = 1;
  player _id_3B64EB40368C1450::set("ascender", "usability", 0);
  _id_B1F6E33C254D1D38 = _id_DA39C6D2E190D5C9.ascendstructend;
  _id_21315F3BBB4A8A3D = _id_DA39C6D2E190D5C9.ascendstructout;
  _id_DA39C6D2E190D5C9.ascender dontinterpolate();
  _id_DA39C6D2E190D5C9.ascender.origin = _id_DA39C6D2E190D5C9.origin;
  _id_DA39C6D2E190D5C9.ascender.angles = _id_DA39C6D2E190D5C9.angles;
  ascendermodelview = spawn("script_model", _id_DA39C6D2E190D5C9.origin);
  ascendermodelview setModel("misc_wm_ascender");
  ascendermodelview showonlytoplayer(player);
  ascendermodelworld = spawn("script_model", _id_DA39C6D2E190D5C9.origin);
  ascendermodelworld setModel("misc_wm_ascender");
  ascendermodelworld hidefromplayer(player);
  player.ascenderstart = _id_DA39C6D2E190D5C9;
  player.ascendermodelview = ascendermodelview;
  player.ascendermodelworld = ascendermodelworld;
  player _meth_75BCEB766D71DD0A(1);
  player thread ascenddeathlistener(_id_DA39C6D2E190D5C9);
  _id_DA39C6D2E190D5C9.ascender startascenderanim(player, _id_DA39C6D2E190D5C9.dir, ascendermodelview, ascendermodelworld);
  _id_DA39C6D2E190D5C9.ascender playLoopSound("br_auto_ascender_device_lp_npc");
  player thread loopwaitanim(_id_DA39C6D2E190D5C9.ascender, ascendermodelview, ascendermodelworld, _id_DA39C6D2E190D5C9.dir);
  _id_6C29CCC8D58C68E3 = distance(_id_B1F6E33C254D1D38.origin, _id_DA39C6D2E190D5C9.origin);

  if(!_id_DA39C6D2E190D5C9.dir) {
    if(scripts\common\utility::iscp())
      _id_2451A07ACA478BF6 = getdvarfloat("dvar_23ED39C8F9324FFE", _id_F3C35AACFBE68158());
    else
      _id_2451A07ACA478BF6 = getdvarfloat("dvar_89E4C06F52246B50", _id_9412C45E2BC1218B());
  } else
    _id_2451A07ACA478BF6 = getdvarfloat("dvar_01726C98446555F2", _id_68FE08D119BBD54F());

  _id_6BBA8AD63924E722 = _id_6C29CCC8D58C68E3 / _id_2451A07ACA478BF6;
  _id_E1085FBF185D9D57 = _id_99E7D00E9D903C57() * _id_6BBA8AD63924E722;
  _id_6AA5B76B245AB989 = _id_CA18084BDCC82EA8() * _id_6BBA8AD63924E722;
  _id_DA39C6D2E190D5C9.ascender moveTo(_id_B1F6E33C254D1D38.origin, _id_6BBA8AD63924E722, _id_E1085FBF185D9D57, _id_6AA5B76B245AB989);
  wait(_id_6BBA8AD63924E722);
  _id_DA39C6D2E190D5C9.ascender scripts\engine\utility::delaycall(0.1, ::stoploopsound, "br_auto_ascender_device_lp_npc");
  player notify("ascender_loop_done");
  _id_DA39C6D2E190D5C9.ascender endascenderanim(player, _id_DA39C6D2E190D5C9.dir, ascendermodelview, ascendermodelworld);
  _id_DA39C6D2E190D5C9 cleanupascenduse(player);
  player notify("ascend_complete");
  player _meth_75BCEB766D71DD0A(0);
}

cleanupascenduse(player) {
  self.inuse = 0;

  if(isDefined(player)) {
    player.usingascender = 0;
    player.lastascenderusetime = gettime();
    player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("ascender");

    if(getdvarint("dvar_A24172489F2B8A69", 0) <= 0)
      player.shouldskiplaststand = undefined;

    if(isDefined(player.ascendermodelview)) {
      player.ascendermodelview unlink();
      player.ascendermodelview delete();
    }

    if(isDefined(player.ascendermodelworld)) {
      player.ascendermodelworld unlink();
      player.ascendermodelworld delete();
    }
  }

  self.ascender.angles = self.startangle;
  self.ascender scripts\cp_mp\ent_manager::deregisterspawn();
  self.ascender delete();

  if(isDefined(player)) {
    if(isDefined(player.ascenderstart.sololink))
      self.scriptable setscriptablepartstate("ascender_solo", "on");
    else
      self.scriptable setscriptablepartstate("ascender", "on");

    player.ascenderstart = undefined;
    player.ascendermodelview = undefined;
    player.ascendermodelworld = undefined;
    player.player_rig unlink();
  } else if(isDefined(self.sololink))
    self.scriptable setscriptablepartstate("ascender_solo", "on");
  else
    self.scriptable setscriptablepartstate("ascender", "on");

  waitframe();

  if(isDefined(player)) {
    player thread scripts\cp_mp\utility\inventory_utility::_id_9897D143C3FEEE05();
    player notify("remove_rig");
  }
}

ascenderinstantstop() {
  player = self;

  if(!istrue(player.usingascender)) {
    return;
  }
  startorigin = player.ascenderstart.ascendstructout.origin;
  startangles = player.ascenderstart.ascendstructout.angles;
  player.ascenderstart cleanupascenduse(player);
  player setOrigin(startorigin);
  player setplayerangles(startangles);
  player notify("ascender_cancel");
  player notify("ascender_solo_cancel");
  player stopanimscriptsceneevent();
}

vectortoanglessafe(forward, up) {
  right = vectorcross(forward, up);
  up = vectorcross(right, forward);
  angles = axistoangles(forward, right, up);
  return angles;
}

_id_FF57F9ACF27BBC3C(point) {
  foreach(a in level.ascendstructs) {
    if(distance2dsquared(a.origin, point) < _id_211B63898BA23E96()) {
      if(abs(point[2] - a.origin[2]) < _id_9BB960F8F80F543F())
        return 1;
    }
  }

  return 0;
}