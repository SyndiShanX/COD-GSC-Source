/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\auto_ascender_solo.gsc
************************************************/

init() {
  level.ascendsolostarts = scripts\engine\utility::getStructArray("ascend_solo_begin", "script_noteworthy");
  level.descendsolostarts = scripts\engine\utility::getStructArray("descend_solo_begin", "script_noteworthy");
  level._id_BB91DEBCFC5A4BC2 = getEntArray("zipline_shine", "script_noteworthy");

  foreach(a in level.ascendsolostarts)
  scripts\cp_mp\auto_ascender::markupascenderstruct(a, 1);

  foreach(b in level.descendsolostarts)
  scripts\cp_mp\auto_ascender::markupascenderstruct(b, 0);

  foreach(a in level.ascendsolostarts) {
    foreach(b in level.descendsolostarts) {
      _id_7A117370745E5467 = distance2dsquared(a.origin, b.origin) < 10;

      if(istrue(level._id_FAB1CBF39A6A0E7D))
        _id_7A117370745E5467 = 1;

      if(!isDefined(b.sololink) && _id_7A117370745E5467) {
        a.sololink = b;
        b.sololink = a;
        break;
      }
    }

    foreach(c in level._id_BB91DEBCFC5A4BC2) {
      if(distance2dsquared(a.origin, c.origin) < 10) {
        a._id_CAE998A0647BD745 = c;
        a.sololink._id_CAE998A0647BD745 = c;
        break;
      }
    }
  }

  initanimtree();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("ascender_solo", ::ascendersoloscriptableused);
}

#using_animtree("script_model");

initanimtree() {
  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"]["ascender_ext_up_in"] = % vm_eq_ascender_ext_up_get_on_plr;
  level.scr_animname["player"]["ascender_ext_up_in"] = "vm_eq_ascender_ext_up_get_on_plr";
  level.scr_eventanim["player"]["ascender_ext_up_in"] = "ascender_ext_up_in";
  level.scr_anim["player"]["ascender_ext_up_loop"] = % vm_eq_ascender_ext_up_loop_plr;
  level.scr_animname["player"]["ascender_ext_up_loop"] = "vm_eq_ascender_ext_up_loop_plr";
  level.scr_eventanim["player"]["ascender_ext_up_loop"] = "ascender_ext_up_loop";
  level.scr_anim["player"]["ascender_ext_up_out"] = % vm_eq_ascender_ext_up_get_off_plr;
  level.scr_animname["player"]["ascender_ext_up_out"] = "vm_eq_ascender_ext_up_get_off_plr";
  level.scr_eventanim["player"]["ascender_ext_up_out"] = "ascender_ext_up_out";
  level.scr_anim["player"]["ascender_ext_down_in"] = % vm_eq_ascender_ext_down_get_on_plr;
  level.scr_animname["player"]["ascender_ext_down_in"] = "vm_eq_ascender_ext_down_get_on_plr";
  level.scr_eventanim["player"]["ascender_ext_down_in"] = "ascender_ext_down_in";
  level.scr_anim["player"]["ascender_ext_down_loop"] = % vm_eq_ascender_ext_down_loop_plr;
  level.scr_animname["player"]["ascender_ext_down_loop"] = "vm_eq_ascender_ext_down_loop_plr";
  level.scr_eventanim["player"]["ascender_ext_down_loop"] = "ascender_ext_down_loop";
  level.scr_anim["player"]["ascender_ext_down_out"] = % vm_eq_ascender_ext_down_get_off_plr;
  level.scr_animname["player"]["ascender_ext_down_out"] = "vm_eq_ascender_ext_down_get_off_plr";
  level.scr_eventanim["player"]["ascender_ext_down_out"] = "ascender_ext_down_out";
  level.scr_animtree["device"] = #animtree;
  level.scr_anim["device"]["ascender_ext_up_in"] = % vm_eq_ascender_ext_up_get_on_ascender;
  level.scr_animname["device"]["ascender_ext_up_in"] = "vm_eq_ascender_ext_up_get_on_ascender";
  level.scr_eventanim["device"]["ascender_ext_up_in"] = "ascender_ext_up_in";
  level.scr_anim["device"]["ascender_ext_up_loop"] = % vm_eq_ascender_ext_up_loop_ascender;
  level.scr_animname["device"]["ascender_ext_up_loop"] = "vm_eq_ascender_ext_up_loop_ascender";
  level.scr_eventanim["device"]["ascender_ext_up_loop"] = "ascender_ext_up_loop";
  level.scr_anim["device"]["ascender_ext_up_out"] = % vm_eq_ascender_ext_up_get_off_ascender;
  level.scr_animname["device"]["ascender_ext_up_out"] = "vm_eq_ascender_ext_up_get_off_ascender";
  level.scr_eventanim["device"]["ascender_ext_up_out"] = "ascender_ext_up_out";
  level.scr_anim["device"]["ascender_ext_down_in"] = % vm_eq_ascender_ext_down_get_on_ascender;
  level.scr_animname["device"]["ascender_ext_down_in"] = "vm_eq_ascender_ext_down_get_on_ascender";
  level.scr_eventanim["device"]["ascender_ext_down_in"] = "ascender_ext_down_in";
  level.scr_anim["device"]["ascender_ext_down_loop"] = % vm_eq_ascender_ext_down_loop_ascender;
  level.scr_animname["device"]["ascender_ext_down_loop"] = "vm_eq_ascender_ext_down_loop_ascender";
  level.scr_eventanim["device"]["ascender_ext_down_loop"] = "ascender_ext_down_loop";
  level.scr_anim["device"]["ascender_ext_down_out"] = % vm_eq_ascender_ext_down_get_off_ascender;
  level.scr_animname["device"]["ascender_ext_down_out"] = "vm_eq_ascender_ext_down_get_off_ascender";
  level.scr_eventanim["device"]["ascender_ext_down_out"] = "ascender_ext_down_out";
  level.scr_animtree["device"] = #animtree;
  level.scr_anim["device"]["ascender_ext_up_in_wm"] = % wm_eq_ascender_ext_up_get_on_ascender;
  level.scr_animname["device"]["ascender_ext_up_in_wm"] = "wm_eq_ascender_ext_up_get_on_ascender";
  level.scr_eventanim["device"]["ascender_ext_up_in_wm"] = "ascender_ext_up_in";
  level.scr_anim["device"]["ascender_ext_up_loop_wm"] = % wm_eq_ascender_ext_up_loop_ascender;
  level.scr_animname["device"]["ascender_ext_up_loop_wm"] = "wm_eq_ascender_ext_up_loop_ascender";
  level.scr_eventanim["device"]["ascender_ext_up_loop_wm"] = "ascender_ext_up_loop";
  level.scr_anim["device"]["ascender_ext_up_out_wm"] = % wm_eq_ascender_ext_up_get_off_ascender;
  level.scr_animname["device"]["ascender_ext_up_out_wm"] = "wm_eq_ascender_ext_up_get_off_ascender";
  level.scr_eventanim["device"]["ascender_ext_up_out_wm"] = "ascender_ext_up_out";
  level.scr_anim["device"]["ascender_ext_down_in_wm"] = % wm_eq_ascender_ext_down_get_on_ascender;
  level.scr_animname["device"]["ascender_ext_down_in_wm"] = "wm_eq_ascender_ext_down_get_on_ascender";
  level.scr_eventanim["device"]["ascender_ext_down_in_wm"] = "ascender_ext_down_in";
  level.scr_anim["device"]["ascender_ext_down_loop_wm"] = % wm_eq_ascender_ext_down_loop_ascender;
  level.scr_animname["device"]["ascender_ext_down_loop_wm"] = "wm_eq_ascender_ext_down_loop_ascender";
  level.scr_eventanim["device"]["ascender_ext_down_loop_wm"] = "ascender_ext_down_loop";
  level.scr_anim["device"]["ascender_ext_down_out_wm"] = % wm_eq_ascender_ext_down_get_off_ascender;
  level.scr_animname["device"]["ascender_ext_down_out_wm"] = "wm_eq_ascender_ext_down_get_off_ascender";
  level.scr_eventanim["device"]["ascender_ext_down_out_wm"] = "ascender_ext_down_out";
}

ascendersoloscriptableused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(state == "on") {
    if(istrue(player.usingascender)) {
      return;
    }
    thread ascenderuse(instance, player);
  }
}

endascenderanim(player, dir, ascendermodelview, ascendermodelworld) {
  player endon("death_or_disconnect");
  player endon("ascender_solo_cancel");
  player endon("last_stand_start");

  if(dir)
    _id_45AE85538855919B = "ascender_ext_up_out";
  else
    _id_45AE85538855919B = "ascender_ext_down_out";

  thread scripts\mp\anim::anim_player_solo(player, player.player_rig, _id_45AE85538855919B);
  scripts\common\anim::anim_single_solo(ascendermodelworld, _id_45AE85538855919B + "_wm");
}

spinafterdelay(_id_8003B0D4F9FBEE0E) {
  self endon("death_or_disconnect");
  self endon("ascender_solo_cancel");
  self endon("last_stand_start");
  wait 1.75;
  self rotateTo(_id_8003B0D4F9FBEE0E, 1.0, 0.1, 0.1);
}

startascenderanim(player, dir, ascendermodelview, ascendermodelworld, _id_8EA61C746773C4AE) {
  player endon("death_or_disconnect");
  player endon("ascender_solo_cancel");
  player endon("last_stand_start");
  player thread scripts\mp\utility\infilexfil::infil_player_rig_updated("player", player.origin, player.angles);
  ascendermodelview.animname = "device";
  ascendermodelview scripts\common\anim::setanimtree();
  ascendermodelworld.animname = "device";
  ascendermodelworld scripts\common\anim::setanimtree();
  _id_A08D86A9E7AAFC47 = (1, 0, 0);

  if(dir) {
    _id_9150BC085D41F530 = "TAG_ACCESSORY_RIGHT";
    _id_298EE9614AE698AE = "ascender_ext_up_in";
    _id_A08D86A9E7AAFC47 = rotatevector((-40.9464, 0, 0), self.angles);
  } else {
    _id_9150BC085D41F530 = "TAG_ACCESSORY_LEFT";
    _id_298EE9614AE698AE = "ascender_ext_down_in";
    _id_A08D86A9E7AAFC47 = rotatevector((-42.2388, 0, 0), self.angles);
  }

  player.player_rig moveTo(self.origin + _id_A08D86A9E7AAFC47, 0.4, 0.1, 0.1);
  fwd = vectorNormalize(_id_A08D86A9E7AAFC47 * -1);
  _id_8003B0D4F9FBEE0E = scripts\cp_mp\auto_ascender::vectortoanglessafe(fwd, (0, 0, 1));
  player.player_rig rotateTo(_id_8003B0D4F9FBEE0E, 0.4, 0.1, 0.1);

  if(_id_8EA61C746773C4AE > 0)
    thread spinafterdelay(self.angles + (0, _id_8EA61C746773C4AE * -1, 0));

  _id_CD9982ADB17761A8 = gettime();
  player scripts\cp_mp\utility\inventory_utility::_id_FC6A5B145563BE33();
  _id_698CC218E4ADE75F = gettime();
  _id_218F64CB035D54BE = 0.4 - (_id_698CC218E4ADE75F - _id_CD9982ADB17761A8) / 1000.0;
  waittime = max(0, _id_218F64CB035D54BE);
  wait(waittime);
  ascendermodelworld show();
  ascendermodelworld hidefromplayer(player);
  ascendermodelview show();
  ascendermodelview showonlytoplayer(player);
  player.player_rig linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  ascendermodelview linkTo(player.player_rig, _id_9150BC085D41F530, (0, 0, 0), (0, 0, 0));
  ascendermodelworld linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  _id_8431FDE12E056D7F = player _meth_C1092F42B6BBE490();

  if(!_id_8431FDE12E056D7F)
    player.player_rig showonlytoplayer(player);

  scripts\common\anim::anim_first_frame_solo(player.player_rig, _id_298EE9614AE698AE);
  thread scripts\mp\anim::anim_player_solo(player, player.player_rig, _id_298EE9614AE698AE);
  thread scripts\common\anim::anim_single_solo(ascendermodelworld, _id_298EE9614AE698AE + "_wm");
  _id_5018A9A0D40ED758 = getanimlength(level.scr_anim["player"][_id_298EE9614AE698AE]);
  wait(_id_5018A9A0D40ED758);
}

loopwaitanim(scenenode, ascendermodelview, ascendermodelworld, dir) {
  self endon("death_or_disconnect");
  self endon("ascender_solo_loop_done");
  self endon("ascender_solo_cancel");
  self endon("last_stand_start");

  if(dir)
    _id_B164EBCED1CBE96C = "ascender_ext_up_loop";
  else
    _id_B164EBCED1CBE96C = "ascender_ext_down_loop";

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

ascenderuse(instance, player) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("ascender_solo_cancel");

  if(!scripts\cp_mp\auto_ascender::_id_3070AAB95202A0E6(instance, player)) {
    return;
  }
  _id_DA39C6D2E190D5C9 = level.ascendstructs[instance.target];

  if(isDefined(_id_DA39C6D2E190D5C9._id_CAE998A0647BD745))
    _id_DA39C6D2E190D5C9._id_CAE998A0647BD745 hide();

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
  _id_1C86FED9265B1179 = anglesToForward(_id_DA39C6D2E190D5C9.angles);
  _id_E227374D9D756C2D = anglesToForward(player.angles);
  dot = vectordot(_id_E227374D9D756C2D, _id_1C86FED9265B1179);
  _id_8EA61C746773C4AE = 0;

  if(dot < 0.5) {
    _id_775361D05A790917 = vectorcross(_id_E227374D9D756C2D, _id_1C86FED9265B1179);

    if(_id_775361D05A790917[2] < 0)
      _id_8EA61C746773C4AE = 120;
    else
      _id_8EA61C746773C4AE = 240;
  }

  angleoffset = (0, _id_8EA61C746773C4AE, 0);
  _id_B1F6E33C254D1D38 = _id_DA39C6D2E190D5C9.ascendstructend;
  _id_21315F3BBB4A8A3D = _id_DA39C6D2E190D5C9.ascendstructout;
  _id_DA39C6D2E190D5C9.ascender dontinterpolate();
  _id_DA39C6D2E190D5C9.ascender.origin = _id_DA39C6D2E190D5C9.origin;
  _id_DA39C6D2E190D5C9.ascender.angles = _id_DA39C6D2E190D5C9.angles + angleoffset;
  ascendermodelview = spawn("script_model", _id_DA39C6D2E190D5C9.origin);

  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
    ascendermodelview setModel("misc_vm_ascender");
  else
    ascendermodelview setModel("misc_wm_ascender");

  ascendermodelview hide();
  ascendermodelworld = spawn("script_model", _id_DA39C6D2E190D5C9.origin);
  ascendermodelworld setModel("misc_wm_ascender");
  ascendermodelworld hide();
  player.ascenderstart = _id_DA39C6D2E190D5C9;
  player.ascendermodelview = ascendermodelview;
  player.ascendermodelworld = ascendermodelworld;
  player thread scripts\cp_mp\auto_ascender::ascenddeathlistener(_id_DA39C6D2E190D5C9);
  _id_DA39C6D2E190D5C9.ascender startascenderanim(player, _id_DA39C6D2E190D5C9.dir, ascendermodelview, ascendermodelworld, _id_8EA61C746773C4AE);
  _id_DA39C6D2E190D5C9.ascender playLoopSound("br_auto_ascender_device_lp_npc");
  player thread loopwaitanim(_id_DA39C6D2E190D5C9.ascender, ascendermodelview, ascendermodelworld, _id_DA39C6D2E190D5C9.dir);
  _id_6C29CCC8D58C68E3 = distance(_id_B1F6E33C254D1D38.origin, _id_DA39C6D2E190D5C9.origin);

  if(!_id_DA39C6D2E190D5C9.dir) {
    if(scripts\common\utility::iscp())
      _id_2451A07ACA478BF6 = getdvarfloat("dvar_23ED39C8F9324FFE", scripts\cp_mp\auto_ascender::_id_F3C35AACFBE68158());
    else
      _id_2451A07ACA478BF6 = getdvarfloat("dvar_89E4C06F52246B50", scripts\cp_mp\auto_ascender::_id_9412C45E2BC1218B());
  } else
    _id_2451A07ACA478BF6 = getdvarfloat("dvar_01726C98446555F2", scripts\cp_mp\auto_ascender::_id_68FE08D119BBD54F());

  _id_6BBA8AD63924E722 = _id_6C29CCC8D58C68E3 / _id_2451A07ACA478BF6;
  _id_E1085FBF185D9D57 = scripts\cp_mp\auto_ascender::_id_99E7D00E9D903C57() * _id_6BBA8AD63924E722;
  _id_6AA5B76B245AB989 = scripts\cp_mp\auto_ascender::_id_CA18084BDCC82EA8() * _id_6BBA8AD63924E722;
  _id_DA39C6D2E190D5C9.ascender moveTo(_id_B1F6E33C254D1D38.origin, _id_6BBA8AD63924E722, _id_E1085FBF185D9D57, _id_6AA5B76B245AB989);
  wait(_id_6BBA8AD63924E722);
  _id_DA39C6D2E190D5C9.ascender scripts\engine\utility::delaycall(0.1, ::stoploopsound, "br_auto_ascender_device_lp_npc");
  player notify("ascender_solo_loop_done");
  _id_DA39C6D2E190D5C9.ascender endascenderanim(player, _id_DA39C6D2E190D5C9.dir, ascendermodelview, ascendermodelworld);

  if(isDefined(_id_DA39C6D2E190D5C9._id_CAE998A0647BD745))
    _id_DA39C6D2E190D5C9._id_CAE998A0647BD745 show();

  _id_DA39C6D2E190D5C9 scripts\cp_mp\auto_ascender::cleanupascenduse(player);
  player notify("ascend_solo_complete");
}

ispointnearsoloascenderline(point) {
  foreach(a in level.ascendsolostarts) {
    if(distance2dsquared(a.origin, point) < scripts\cp_mp\auto_ascender::_id_211B63898BA23E96()) {
      if(isDefined(a.sololink)) {
        if(abs(point[2] - a.origin[2]) < scripts\cp_mp\auto_ascender::_id_9BB960F8F80F543F() || abs(point[2] - a.sololink.origin[2]) < scripts\cp_mp\auto_ascender::_id_9BB960F8F80F543F())
          return 1;
      }
    }
  }

  return 0;
}