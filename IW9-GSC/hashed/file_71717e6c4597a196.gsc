/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_71717e6c4597a196.gsc
***********************************************/

_id_15FE9620D04DBB58() {
  level._id_5A2AF420BC54EE97 = spawnStruct();
  level._id_5A2AF420BC54EE97._id_7C381FE62B0CDA6B = [];
  level._id_5A2AF420BC54EE97.interacts = [];
  level._id_5A2AF420BC54EE97._id_46E51D9C12FF301C = [];
  level thread init_cctv_anims();
}

#using_animtree("script_model");

init_cctv_anims() {
  if(isDefined(level.scr_animtree["plyr_cctv"])) {
    return;
  }
  level.scr_animtree["plyr_cctv"] = #animtree;
  level.scr_anim["plyr_cctv"]["cctv_in"] = % cp_raid_cctv_in;
  level.scr_animname["plyr_cctv"]["cctv_in"] = "cp_raid_cctv_in";
  level.scr_eventanim["plyr_cctv"]["cctv_in"] = "cp_raid_cctv_in";
  level.scr_anim["plyr_cctv"]["cctv_in_left"] = % cp_raid_cctv_in_l;
  level.scr_animname["plyr_cctv"]["cctv_in_left"] = "cp_raid_cctv_in_l";
  level.scr_eventanim["plyr_cctv"]["cctv_in_left"] = "cp_raid_cctv_in_l";
  level.scr_anim["plyr_cctv"]["cctv_in_right"] = % cp_raid_cctv_in_r;
  level.scr_animname["plyr_cctv"]["cctv_in_right"] = "cp_raid_cctv_in_r";
  level.scr_eventanim["plyr_cctv"]["cctv_in_right"] = "cp_raid_cctv_in_r";
  level.scr_anim["plyr_cctv"]["cctv_loop"] = % cp_raid_cctv_loop;
  level.scr_animname["plyr_cctv"]["cctv_loop"] = "cp_raid_cctv_loop";
  level.scr_eventanim["plyr_cctv"]["cctv_loop"] = "cp_raid_cctv_loop";
  level.scr_anim["plyr_cctv"]["cctv_activate"] = % cp_raid_cctv_activate;
  level.scr_animname["plyr_cctv"]["cctv_activate"] = "cp_raid_cctv_activate";
  level.scr_eventanim["plyr_cctv"]["cctv_activate"] = "cp_raid_cctv_activate";
  level.scr_anim["plyr_cctv"]["cctv_out"] = % cp_raid_cctv_out;
  level.scr_animname["plyr_cctv"]["cctv_out"] = "cp_raid_cctv_out";
  level.scr_eventanim["plyr_cctv"]["cctv_out"] = "cp_raid_cctv_out";
}

_id_23417F0A11657091(targetname, _id_8A6EAB26D0FF8858, _id_3AD395ADB242930C, _id_2312D6385AE695A8, _id_852EE311FD6A1727, _id_40D4D7A8AD6420E3, _id_EA9A8C2F23231171, _id_EF151A237939EC99, _id_C3C35B46BC1147F5, _id_958C70731DF26D05, _id_C3587ED8F87B2F6A, _id_103CDE63820542A7, _id_103CDD6382054074, _id_D53A92448497CEDC, _id_832C8988BCB60FB9) {
  scripts\engine\utility::flag_wait("level_ready_for_script");
  scripts\engine\utility::flag_wait("objective_table_parsed");
  scripts\engine\utility::flag_wait("strike_init_done");
  _id_BD16F0D97883FD8D = scripts\engine\utility::getStruct(targetname, "targetname");

  if(!isDefined(_id_BD16F0D97883FD8D.script_noteworthy) || _id_BD16F0D97883FD8D.script_noteworthy != "cctv_interaction") {
    return;
  }
  hintstring = undefined;

  if(isDefined(_id_832C8988BCB60FB9))
    hintstring = _id_832C8988BCB60FB9;
  else
    hintstring = &"CP_CCTV/INTERACT";

  if(!isDefined(_id_3AD395ADB242930C))
    _id_3AD395ADB242930C = 240;

  if(!isDefined(_id_2312D6385AE695A8))
    _id_2312D6385AE695A8 = 60;

  if(!isDefined(_id_852EE311FD6A1727))
    _id_852EE311FD6A1727 = 110;

  if(!isDefined(_id_40D4D7A8AD6420E3))
    _id_852EE311FD6A1727 = 40;

  if(!isDefined(_id_EA9A8C2F23231171))
    _id_EA9A8C2F23231171 = "duration_short";

  interact = spawnStruct();
  interact.name = targetname;
  interact._id_C5D3D8FF129F88BA = scripts\cp\utility::createhintobject(_id_BD16F0D97883FD8D.origin, "HINT_BUTTON", undefined, hintstring, undefined, _id_EA9A8C2F23231171, "hide", _id_3AD395ADB242930C, _id_852EE311FD6A1727, _id_2312D6385AE695A8, _id_40D4D7A8AD6420E3);
  interact thread _id_B85DB78C892E1B5A(interact.name, _id_8A6EAB26D0FF8858, _id_EA9A8C2F23231171, _id_EF151A237939EC99, _id_C3C35B46BC1147F5, _id_958C70731DF26D05, _id_C3587ED8F87B2F6A, _id_103CDE63820542A7, _id_103CDD6382054074, _id_D53A92448497CEDC, _id_832C8988BCB60FB9);
  interact _id_CB758D1BFFA656A0(_id_BD16F0D97883FD8D, _id_958C70731DF26D05);
  level._id_5A2AF420BC54EE97.interacts[level._id_5A2AF420BC54EE97.interacts.size] = interact;
  level._id_5A2AF420BC54EE97._id_46E51D9C12FF301C[level._id_5A2AF420BC54EE97._id_46E51D9C12FF301C.size] = interact._id_C5D3D8FF129F88BA;
}

_id_20D4410924E4363C(name) {
  foreach(interact in level._id_5A2AF420BC54EE97.interacts) {
    if(interact.name == name)
      return interact;
  }
}

_id_6589D41B59E2B3C2(targetname) {
  foreach(index, item in level._id_5A2AF420BC54EE97.interacts) {
    if(item.targetname == targetname) {
      item.cam_ent delete();
      item._id_C5D3D8FF129F88BA delete();
    }
  }
}

_id_34E54622B902890B() {
  if(!isDefined(level._id_5A2AF420BC54EE97) || !isDefined(level._id_5A2AF420BC54EE97.interacts)) {
    return;
  }
  foreach(item in level._id_5A2AF420BC54EE97.interacts) {
    if(isent(item.cam_ent))
      item.cam_ent delete();

    if(isent(item._id_C5D3D8FF129F88BA))
      item._id_C5D3D8FF129F88BA delete();
  }
}

_id_3A552AD0C6822236() {
  models = getEntArray("cctv_camera_base", "targetname");

  foreach(model in models) {
    if(isent(model))
      model delete();
  }
}

_id_330C2AB6D9B0CBE0() {
  if(!isDefined(level._id_5A2AF420BC54EE97) || !isDefined(level._id_5A2AF420BC54EE97.interacts)) {
    return;
  }
  foreach(item in level._id_5A2AF420BC54EE97.interacts) {
    if(isDefined(item.current_player))
      item.current_player notify("interact");

    if(isent(item.cam_ent))
      item.cam_ent delete();

    if(isent(item._id_C5D3D8FF129F88BA))
      item._id_C5D3D8FF129F88BA delete();
  }
}

_id_CB758D1BFFA656A0(_id_BD16F0D97883FD8D, _id_958C70731DF26D05) {
  self.cam_ent = spawn("script_model", _id_BD16F0D97883FD8D.origin);
  self.cam_ent setModel("tag_player");
  self.cam_ent.angles = _id_BD16F0D97883FD8D.angles;
  self._id_7C381FE62B0CDA6B = [];
  self._id_163F0EFAB64B2DDB = 0;
  _id_D68182D4B8C95F90 = scripts\engine\utility::getStructArray(_id_BD16F0D97883FD8D.target, "targetname");

  foreach(struct in _id_D68182D4B8C95F90) {
    if(isDefined(struct.script_index))
      struct.script_index = int(struct.script_index);

    if(isDefined(struct.script_objective))
      struct.script_objective = int(struct.script_objective);
  }

  _id_D1F68E041A0C1056 = [];
  _id_D1F68E041A0C1056 = scripts\engine\utility::array_sort_by_script_index(_id_D68182D4B8C95F90);

  foreach(_id_82535A2DD9393243 in _id_D1F68E041A0C1056) {
    _id_693EC2852A7DE810 = spawnStruct();

    if(isDefined(_id_82535A2DD9393243.script_noteworthy)) {
      _id_ECE7F61EF5366A03 = strtok(_id_82535A2DD9393243.script_noteworthy, ",");

      foreach(group in _id_ECE7F61EF5366A03) {
        _id_DF04F5EF50254776 = strtok(group, ":");

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_DF04F5EF50254776.size; _id_AC0E594AC96AA3A8++) {
          switch (_id_DF04F5EF50254776[_id_AC0E594AC96AA3A8]) {
            case "up":
              _id_693EC2852A7DE810._id_DF4C8BA3177E67AA = _id_DF04F5EF50254776[_id_AC0E594AC96AA3A8 + 1];
              break;
            case "down":
              _id_693EC2852A7DE810._id_DB22DD4AED76846B = _id_DF04F5EF50254776[_id_AC0E594AC96AA3A8 + 1];
              break;
            case "left":
              _id_693EC2852A7DE810._id_8AC6DA9207ED18D6 = _id_DF04F5EF50254776[_id_AC0E594AC96AA3A8 + 1];
              break;
            case "right":
              _id_693EC2852A7DE810._id_2CCD922254E0252B = _id_DF04F5EF50254776[_id_AC0E594AC96AA3A8 + 1];
              break;
          }
        }
      }
    }

    _id_693EC2852A7DE810.origin = _id_82535A2DD9393243.origin;
    _id_693EC2852A7DE810.angles = _id_82535A2DD9393243.angles;
    _id_693EC2852A7DE810.index = self._id_7C381FE62B0CDA6B.size;

    if(!istrue(_id_958C70731DF26D05))
      _id_693EC2852A7DE810 thread _id_0D5B7A221E0B616B();

    _id_693EC2852A7DE810._id_07340BAC65D53608 = _id_82535A2DD9393243.script_index;

    if(isDefined(_id_82535A2DD9393243.script_objective))
      _id_693EC2852A7DE810._id_86F1A7D124DC2A6D = _id_82535A2DD9393243.script_objective;

    level._id_5A2AF420BC54EE97._id_7C381FE62B0CDA6B[level._id_5A2AF420BC54EE97._id_7C381FE62B0CDA6B.size] = _id_693EC2852A7DE810;
    self._id_7C381FE62B0CDA6B[self._id_7C381FE62B0CDA6B.size] = _id_693EC2852A7DE810;
  }
}

_id_0D5B7A221E0B616B(_id_BD16F0D97883FD8D) {
  self._id_5CF5D11F62C8D616 = spawn("script_model", self.origin);
  self._id_5CF5D11F62C8D616 setModel("uk_security_camera_redlight_head_01");
  self._id_5CF5D11F62C8D616.angles = self.angles;
  self._id_5CF5D11F62C8D616.targetname = "cctv_camera_head";
}

_id_B85DB78C892E1B5A(name, _id_8A6EAB26D0FF8858, _id_EA9A8C2F23231171, _id_EF151A237939EC99, _id_C3C35B46BC1147F5, _id_958C70731DF26D05, _id_C3587ED8F87B2F6A, _id_103CDE63820542A7, _id_103CDD6382054074, _id_D53A92448497CEDC, _id_832C8988BCB60FB9) {
  for(;;) {
    self._id_C5D3D8FF129F88BA waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(istrue(self._id_C5D3D8FF129F88BA.locked)) {
      continue;
    }
    self._id_C5D3D8FF129F88BA _id_F0E3B8ED90BBFEC2(1, _id_EA9A8C2F23231171, _id_832C8988BCB60FB9);
    self.current_player = player;
    player._id_C35BC0EFA0ED35F1 = 1;
    player._id_B43304D686D36553 = player.angles;
    _id_440F22FE5C37E088 = "security_camera_active_" + name;
    _id_F6092C815D8E47FB = "cctv_camera_exit_" + name;
    player _id_1FFACB9D065A4F8F(self._id_C5D3D8FF129F88BA, _id_F6092C815D8E47FB, _id_440F22FE5C37E088, _id_EA9A8C2F23231171);
    player _id_4A1BCA4E19AE51EF(1, _id_440F22FE5C37E088, "security_camera", _id_D53A92448497CEDC);
    player._id_EDAB10CE7BDB9C99 = "dx_radio_2d";
    level notify("cctv_camera_enter", player, self);
    player playlocalsound("cp_ui_cctv_in_plr");
    player setsoundsubmix("cp_raid1_cctv_mix", 0.3);
    player thread _id_1F5C256E23D972C9(self, _id_F6092C815D8E47FB, _id_8A6EAB26D0FF8858, _id_EF151A237939EC99, _id_C3C35B46BC1147F5, _id_958C70731DF26D05);
    player thread _id_8090D3578E3372F7(self, _id_F6092C815D8E47FB, _id_8A6EAB26D0FF8858, undefined, _id_EA9A8C2F23231171, _id_C3587ED8F87B2F6A, _id_103CDE63820542A7, _id_103CDD6382054074, _id_832C8988BCB60FB9);
    level waittill(_id_F6092C815D8E47FB);

    if(isPlayer(player))
      player _id_4A1BCA4E19AE51EF(0, _id_440F22FE5C37E088, "security_camera", _id_D53A92448497CEDC);

    self.current_player = undefined;
  }
}

_id_F0E3B8ED90BBFEC2(_id_41D8BF229CF29051, _id_EA9A8C2F23231171, _id_832C8988BCB60FB9) {
  if(istrue(_id_41D8BF229CF29051)) {
    self.locked = 1;
    hintstring = &"CP_CCTV/IN_USE";
    self setHintString(hintstring);
    self setuseholdduration("duration_none");
    self _meth_DFB78B3E724AD620(1);
  } else {
    if(!isDefined(_id_EA9A8C2F23231171))
      _id_EA9A8C2F23231171 = "duration_short";

    self.locked = 0;
    hintstring = undefined;

    if(isDefined(_id_832C8988BCB60FB9))
      hintstring = _id_832C8988BCB60FB9;
    else
      hintstring = &"CP_CCTV/INTERACT";

    self setHintString(hintstring);
    self setuseholdduration(_id_EA9A8C2F23231171);
    self _meth_DFB78B3E724AD620(1);
  }
}

_id_1FFACB9D065A4F8F(_id_351F10248CC32755, _id_F6092C815D8E47FB, _id_8F8A23A42D332144, _id_EA9A8C2F23231171) {
  scenenodes = scripts\engine\utility::getStructArray("cctv_scenenode", "targetname");

  if(!isDefined(scenenodes) || scenenodes.size == 0) {
    return;
  }
  _id_351F10248CC32755.scenenode = scripts\engine\utility::getclosest(_id_351F10248CC32755.origin, scenenodes, 500);

  if(!isDefined(_id_351F10248CC32755.scenenode)) {
    return;
  }
  _id_0E4731409BD255E0 = "";
  _id_16290C9DDA466BCE = vectorNormalize(self.origin - _id_351F10248CC32755.scenenode.origin);

  if(vectordot(_id_16290C9DDA466BCE, anglestoleft(_id_351F10248CC32755.scenenode.angles)) > 0.5)
    _id_0E4731409BD255E0 = "_left";
  else if(vectordot(_id_16290C9DDA466BCE, anglestoright(_id_351F10248CC32755.scenenode.angles)) > 0.5)
    _id_0E4731409BD255E0 = "_right";

  actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(self, "plyr_cctv", 1, 1);
  thread _id_8B14756E9477683F();
  started = _id_351F10248CC32755.scenenode scripts\cp_mp\anim_scene::anim_scene([actorplayer], "cctv_in" + _id_0E4731409BD255E0, 1, 0) && scripts\cp_mp\utility\player_utility::_isalive();
  _id_351F10248CC32755.scenenode thread _id_EC295422CE7C308E(self, actorplayer, _id_8F8A23A42D332144);
  level thread _id_0869B5553B2B8694(_id_351F10248CC32755, self, actorplayer, _id_EA9A8C2F23231171);
}

_id_8B14756E9477683F() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  wait 1;
  self playSound("cp_raid_cctv_in");
}

_id_EC295422CE7C308E(player, actorplayer, _id_8F8A23A42D332144) {
  player endon("exit_cctv");
  player endon("death_or_disconnect");
  scripts\engine\utility::flag_wait(_id_8F8A23A42D332144);

  while(player scripts\cp_mp\utility\player_utility::_isalive() && istrue(player._id_D5AF94588739718C))
    scripts\cp_mp\anim_scene::anim_scene([actorplayer], "cctv_loop", 0, 0);
}

_id_0869B5553B2B8694(_id_351F10248CC32755, player, actorplayer, _id_EA9A8C2F23231171) {
  player endon("death_or_disconnect");
  player waittill("exit_cctv");
  player playerlinktoblend(actorplayer.player_rig, "tag_player", 0.1);
  player thread _id_FF752F827C6ED3A8();
  _id_351F10248CC32755.scenenode scripts\cp_mp\anim_scene::anim_scene([actorplayer], "cctv_out", 0, 1);

  if(isent(_id_351F10248CC32755))
    _id_351F10248CC32755 _id_F0E3B8ED90BBFEC2(0, _id_EA9A8C2F23231171);
}

_id_FF752F827C6ED3A8() {
  self playSound("cp_raid_cctv_out");
}

_id_4A1BCA4E19AE51EF(enabled, _id_9C79B94FDF1ABF9E, _id_D4CC29E776820C4C, _id_D53A92448497CEDC) {
  self endon("death_or_disconnect");

  if(enabled) {
    level scripts\engine\utility::flag_set(_id_9C79B94FDF1ABF9E);
    self._id_D5AF94588739718C = enabled;
    _id_3B64EB40368C1450::set(_id_D4CC29E776820C4C, "allow_jump", !enabled);
    _id_3B64EB40368C1450::set(_id_D4CC29E776820C4C, "crouch", !enabled);
    _id_3B64EB40368C1450::set(_id_D4CC29E776820C4C, "prone", !enabled);
    _id_3B64EB40368C1450::set(_id_D4CC29E776820C4C, "slide", !enabled);
    _id_3B64EB40368C1450::set(_id_D4CC29E776820C4C, "mantle", !enabled);
    _id_3B64EB40368C1450::set(_id_D4CC29E776820C4C, "sprint", !enabled);
    _id_3B64EB40368C1450::set(_id_D4CC29E776820C4C, "mount_side", !enabled);
    _id_3B64EB40368C1450::set(_id_D4CC29E776820C4C, "mount_top", !enabled);
    _id_3B64EB40368C1450::set(_id_D4CC29E776820C4C, "allow_movement", !enabled);
    _id_3B64EB40368C1450::set(_id_D4CC29E776820C4C, "fire", !enabled);
    _id_3B64EB40368C1450::set(_id_D4CC29E776820C4C, "offhand_weapons", !enabled);
    _id_3B64EB40368C1450::set(_id_D4CC29E776820C4C, "reload", !enabled);
    _id_3B64EB40368C1450::set(_id_D4CC29E776820C4C, "autoreload", !enabled);
    _id_3B64EB40368C1450::set(_id_D4CC29E776820C4C, "weapon_pickup", !enabled);
    _id_3B64EB40368C1450::set(_id_D4CC29E776820C4C, "weapon_first_raise_anims", !enabled);
    _id_3B64EB40368C1450::set(_id_D4CC29E776820C4C, "weapon_switch", !enabled);
    _id_3B64EB40368C1450::set(_id_D4CC29E776820C4C, "weapon", !enabled);
    self disableemptyclipweaponswitch(enabled);
    self setclientomnvar("ui_cctv_active", 1);

    if(!isDefined(_id_D53A92448497CEDC))
      _id_D53A92448497CEDC = "prison_cctv";

    level notify("vision_set_change_request", _id_D53A92448497CEDC, self, 0.05);
  } else {
    level scripts\engine\utility::flag_clear(_id_9C79B94FDF1ABF9E);
    self._id_D5AF94588739718C = undefined;
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00(_id_D4CC29E776820C4C);
    self disableemptyclipweaponswitch(enabled);
    self setclientomnvar("ui_cctv_active", 0);

    if(!isDefined(_id_D53A92448497CEDC))
      _id_D53A92448497CEDC = "prison_cctv";

    level notify("vision_set_change_request", "", self, 0.05, _id_D53A92448497CEDC);
  }
}

_id_8090D3578E3372F7(interact, _id_9E27EB5BA6F8F0F6, _id_8A6EAB26D0FF8858, _id_11FFA7781C19591F, _id_EA9A8C2F23231171, _id_C3587ED8F87B2F6A, _id_103CDE63820542A7, _id_103CDD6382054074, _id_832C8988BCB60FB9) {
  self endon("disconnect");
  level endon(_id_8A6EAB26D0FF8858);
  wait 1.0;
  self notifyonplayercommand("stance_change", "+stance");
  self notifyonplayercommand("stance_change", "+movedown");
  self notifyonplayercommand("stance_change", "+prone");
  self notifyonplayercommand("interact", "+activate");

  if(isDefined(_id_11FFA7781C19591F))
    scripts\engine\utility::flag_wait(_id_11FFA7781C19591F);

  if(!isDefined(_id_C3587ED8F87B2F6A))
    _id_C3587ED8F87B2F6A = "blank";

  if(!isDefined(_id_103CDE63820542A7))
    _id_103CDE63820542A7 = "blank_2";

  if(!isDefined(_id_103CDD6382054074))
    _id_103CDD6382054074 = "blank_3";

  msg = scripts\engine\utility::waittill_any_return_6("stance_change", "interact", "death_or_disconnect", _id_C3587ED8F87B2F6A, _id_103CDE63820542A7, _id_103CDD6382054074);
  self._id_EDAB10CE7BDB9C99 = undefined;
  self stoplocalsound("cp_ui_cctv_in_plr");
  self playlocalsound("cp_ui_cctv_out_plr");
  self clearsoundsubmix("cp_raid1_cctv_mix", 0.3);
  self cameraunlink();
  self unlink();
  self controlsunlink();

  if(isDefined(self._id_B43304D686D36553))
    self setplayerangles(self._id_B43304D686D36553);

  self._id_B43304D686D36553 = undefined;

  if(isDefined(self._id_E51D7BC24734785F))
    self lerpfov(self._id_E51D7BC24734785F);
  else
    self lerpfovbypreset("default");

  self setclientomnvar("ui_hide_hud", 0);
  self lerpfovscalefactor(1.0, 0.0);
  self notify("exit_cctv");

  if(!isDefined(msg) || msg == "death_or_disconnect" || !isDefined(interact._id_C5D3D8FF129F88BA.scenenode)) {
    if(isent(interact._id_C5D3D8FF129F88BA))
      interact._id_C5D3D8FF129F88BA _id_F0E3B8ED90BBFEC2(0, _id_EA9A8C2F23231171, _id_832C8988BCB60FB9);
  }

  if(isDefined(msg) && (msg == _id_C3587ED8F87B2F6A || msg == _id_103CDE63820542A7)) {
    if(isent(interact._id_C5D3D8FF129F88BA))
      interact._id_C5D3D8FF129F88BA _id_F0E3B8ED90BBFEC2(1, _id_EA9A8C2F23231171, _id_832C8988BCB60FB9);
  }

  _id_266E0A9B20004E84();
  _id_44F128FB3327A0D1(interact, 0);
  level notify(_id_9E27EB5BA6F8F0F6);
}

_id_1F5C256E23D972C9(interact, _id_F6092C815D8E47FB, _id_8A6EAB26D0FF8858, _id_EF151A237939EC99, _id_C3C35B46BC1147F5, _id_958C70731DF26D05) {
  self endon("disconnect");
  level endon(_id_8A6EAB26D0FF8858);
  level endon(_id_F6092C815D8E47FB);
  self notifyonplayercommand("camera_cycle", "+actionslot 3");
  self notifyonplayercommand("camera_cycle", "+moveleft");
  _id_A9ACC124CB8CE211(interact);
  _id_50571D305502D6C3(interact, _id_F6092C815D8E47FB, _id_C3C35B46BC1147F5, _id_958C70731DF26D05);

  if(!istrue(_id_EF151A237939EC99))
    level thread _id_BFA1A0E476615052(self);

  self._id_74CD7962F11BE6A8 = interact._id_7C381FE62B0CDA6B[0];

  for(;;) {
    self waittill("camera_cycle", _id_A24D960FCA9740EF);
    self playlocalsound("cp_ui_cctv_switch_plr");

    if(!istrue(_id_EF151A237939EC99))
      level thread _id_BFA1A0E476615052(self);

    _id_44F128FB3327A0D1(interact, _id_A24D960FCA9740EF);
    self._id_74CD7962F11BE6A8 = interact._id_7C381FE62B0CDA6B[interact._id_163F0EFAB64B2DDB];
    level notify("switched_cctv_cam", self, interact);
    _id_A9ACC124CB8CE211(interact);
    _id_50571D305502D6C3(interact, _id_F6092C815D8E47FB, _id_C3C35B46BC1147F5, _id_958C70731DF26D05);
    wait 1.0;
  }
}

_id_44F128FB3327A0D1(interact, _id_A24D960FCA9740EF) {
  if(!isDefined(_id_A24D960FCA9740EF)) {
    interact._id_163F0EFAB64B2DDB++;

    if(interact._id_163F0EFAB64B2DDB > interact._id_7C381FE62B0CDA6B.size - 1)
      interact._id_163F0EFAB64B2DDB = 0;
  } else
    interact._id_163F0EFAB64B2DDB = _id_A24D960FCA9740EF;
}

_id_A9BBD2B317E2FEC9(_id_B85C8C7BB0C50B52) {
  if(!isDefined(self.current_player)) {
    return;
  }
  _id_8F1E31CBA94019B7 = scripts\engine\utility::getclosest(_id_B85C8C7BB0C50B52.origin, self._id_7C381FE62B0CDA6B);

  if(self.current_player._id_74CD7962F11BE6A8.index == _id_8F1E31CBA94019B7.index) {
    return;
  }
  self.current_player notify("camera_cycle", _id_8F1E31CBA94019B7.index);
}

_id_50571D305502D6C3(interact, _id_F6092C815D8E47FB, _id_C3C35B46BC1147F5, _id_958C70731DF26D05) {
  _id_CBDA0765AA6DDC04 = interact._id_7C381FE62B0CDA6B[interact._id_163F0EFAB64B2DDB];
  interact.cam_ent.origin = _id_CBDA0765AA6DDC04.origin;
  interact.cam_ent.angles = _id_CBDA0765AA6DDC04.angles;
  self dontinterpolate();
  interact.cam_ent dontinterpolate();
  self setclientomnvar("ui_hide_hud", 1);
  self cameraunlink();
  self cameralinkTo(interact.cam_ent, "tag_player", 1, 1);

  if(istrue(_id_C3C35B46BC1147F5)) {
    if(isDefined(_id_CBDA0765AA6DDC04._id_86F1A7D124DC2A6D)) {
      self._id_E51D7BC24734785F = self playergetzoomfov();
      self lerpfov(_id_CBDA0765AA6DDC04._id_86F1A7D124DC2A6D);
      self lerpfovscalefactor(0.0, 0.0);
    } else {
      self._id_E51D7BC24734785F = self playergetzoomfov();
      self lerpfov(110);
      self lerpfovscalefactor(0.0, 0.0);
    }
  }

  if(!istrue(_id_958C70731DF26D05)) {
    self _meth_47933F5EB9F65AFE(interact.cam_ent.origin);
    level thread _id_4E186F141649DF00(_id_F6092C815D8E47FB, _id_CBDA0765AA6DDC04, self, interact.cam_ent);
  }
}

_id_4E186F141649DF00(_id_F6092C815D8E47FB, _id_CBDA0765AA6DDC04, player, cam_ent) {
  level endon(_id_F6092C815D8E47FB);
  player endon("camera_cycle");
  player endon("death_or_disconnect");
  level thread _id_1FECEE2B2E655B37(_id_F6092C815D8E47FB, _id_CBDA0765AA6DDC04, player);
  waittillframeend;

  if(cam_ent.angles != _id_CBDA0765AA6DDC04._id_5CF5D11F62C8D616.angles) {
    cam_ent dontinterpolate();
    cam_ent.angles = _id_CBDA0765AA6DDC04._id_5CF5D11F62C8D616.angles;
  }

  _id_2B0B945E7E3CC35A = 3;
  _id_DF4C8BA3177E67AA = 0;
  _id_DB22DD4AED76846B = 0;
  _id_8AC6DA9207ED18D6 = 0;
  _id_2CCD922254E0252B = 0;

  if(isDefined(_id_CBDA0765AA6DDC04._id_DF4C8BA3177E67AA))
    _id_DF4C8BA3177E67AA = float(_id_CBDA0765AA6DDC04._id_DF4C8BA3177E67AA);

  if(isDefined(_id_CBDA0765AA6DDC04._id_DB22DD4AED76846B))
    _id_DB22DD4AED76846B = float(_id_CBDA0765AA6DDC04._id_DB22DD4AED76846B);

  if(isDefined(_id_CBDA0765AA6DDC04._id_8AC6DA9207ED18D6))
    _id_8AC6DA9207ED18D6 = float(_id_CBDA0765AA6DDC04._id_8AC6DA9207ED18D6);

  if(isDefined(_id_CBDA0765AA6DDC04._id_2CCD922254E0252B))
    _id_2CCD922254E0252B = float(_id_CBDA0765AA6DDC04._id_2CCD922254E0252B);

  _id_680B1B81DA757760 = _id_CBDA0765AA6DDC04.angles[0] - _id_DF4C8BA3177E67AA;
  _id_61995681F6255869 = _id_CBDA0765AA6DDC04.angles[0] + _id_DB22DD4AED76846B;
  _id_A4148764135B7C98 = _id_CBDA0765AA6DDC04.angles[1] + _id_8AC6DA9207ED18D6;
  _id_D25FA17E79EE5A01 = _id_CBDA0765AA6DDC04.angles[1] - _id_2CCD922254E0252B;

  for(;;) {
    _id_E096D9982BE6A83C = vectorNormalize((player _meth_3B2B92C8275A3238(), player _meth_3B2B93C8275A346B(), 0));
    _id_4C0427351CBA550E = _id_E096D9982BE6A83C[0] * _id_2B0B945E7E3CC35A * 0.5;
    _id_CBB72196D9A3597B = clamp(cam_ent.angles[0] + _id_4C0427351CBA550E, _id_680B1B81DA757760, _id_61995681F6255869);
    _id_22AD6195BBEC5B63 = _id_E096D9982BE6A83C[1] * _id_2B0B945E7E3CC35A;
    goal_yaw = clamp(cam_ent.angles[1] + _id_22AD6195BBEC5B63, _id_D25FA17E79EE5A01, _id_A4148764135B7C98);
    _id_7E664C89001A4A4F = (_id_CBB72196D9A3597B, goal_yaw, 0);

    if(_id_7E664C89001A4A4F != cam_ent.angles)
      cam_ent.angles = _id_7E664C89001A4A4F;

    if(cam_ent.angles != _id_CBDA0765AA6DDC04._id_5CF5D11F62C8D616.angles)
      _id_CBDA0765AA6DDC04._id_5CF5D11F62C8D616.angles = cam_ent.angles;

    wait 0.05;
  }
}

_id_1FECEE2B2E655B37(_id_F6092C815D8E47FB, _id_CBDA0765AA6DDC04, player) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  _id_CBDA0765AA6DDC04._id_5CF5D11F62C8D616 hidefromplayer(player);
  _id_80EDD2C1E4DC4D91 = undefined;
  _id_5EC3172363C49F83 = getEntArray("cctv_camera_base", "targetname");

  if(_id_5EC3172363C49F83.size > 0) {
    _id_80EDD2C1E4DC4D91 = scripts\engine\utility::getclosest(_id_CBDA0765AA6DDC04.origin, _id_5EC3172363C49F83);
    _id_80EDD2C1E4DC4D91 hidefromplayer(player);
  }

  level scripts\engine\utility::waittill_any_2("camera_cycle", _id_F6092C815D8E47FB);
  _id_CBDA0765AA6DDC04._id_5CF5D11F62C8D616 showtoplayer(player);

  if(isDefined(_id_80EDD2C1E4DC4D91))
    _id_80EDD2C1E4DC4D91 showtoplayer(player);
}

_id_A9ACC124CB8CE211(interact) {
  level notify("cctv_camera_update");
  _id_266E0A9B20004E84();
  self._id_977539DEBDC4190F = [];

  switch (interact._id_163F0EFAB64B2DDB) {
    case 0:
      _id_447493DFB4C69696 = &"CP_CCTV/INDEX_1";
      break;
    case 1:
      _id_447493DFB4C69696 = &"CP_CCTV/INDEX_2";
      break;
    case 2:
      _id_447493DFB4C69696 = &"CP_CCTV/INDEX_3";
      break;
    case 3:
      _id_447493DFB4C69696 = &"CP_CCTV/INDEX_4";
      break;
    case 4:
      _id_447493DFB4C69696 = &"CP_CCTV/INDEX_5";
      break;
    default:
      _id_447493DFB4C69696 = &"CP_CCTV/INDEX_1";
      break;
  }

  if(isDefined(interact.name)) {
    if(interact.name == "cctv_interact_2") {
      self setclientomnvar("ui_cctv_zone_index", interact._id_163F0EFAB64B2DDB);
      self setclientomnvar("ui_cctv_camera_index", interact._id_163F0EFAB64B2DDB);
    } else if(interact.name == "cctv_interact_3") {
      self setclientomnvar("ui_cctv_zone_index", 10 + interact._id_163F0EFAB64B2DDB);
      self setclientomnvar("ui_cctv_camera_index", 10 + interact._id_163F0EFAB64B2DDB);
    } else {
      if(level.script == "cp_jugg_maze")
        self setclientomnvar("ui_cctv_zone_index", interact._id_7C381FE62B0CDA6B[interact._id_163F0EFAB64B2DDB]._id_07340BAC65D53608);
      else
        self setclientomnvar("ui_cctv_zone_index", 5 + interact._id_163F0EFAB64B2DDB);

      self setclientomnvar("ui_cctv_camera_index", 5 + interact._id_163F0EFAB64B2DDB);
    }
  }
}

_id_1E2259A9E41051E4(player, _id_3F5F22D135255820, _id_3F5F25D135255EB9) {
  if(istrue(player._id_C35BC0EFA0ED35F1)) {
    self fadeovertime(0.1);
    self.alpha = 1;
    wait 0.1;
  }

  msg = level scripts\engine\utility::waittill_any_return_2(_id_3F5F22D135255820, _id_3F5F25D135255EB9);

  if(msg == _id_3F5F22D135255820) {
    self fadeovertime(0.1);
    self.alpha = 0;
    wait 0.1;
  }

  self destroy();
}

_id_BFA1A0E476615052(player, fade_time) {
  _id_B6615BC48F72A828 = newclienthudelem(player);
  _id_B6615BC48F72A828.x = 0;
  _id_B6615BC48F72A828.y = 0;
  _id_B6615BC48F72A828 setshader("overlay_static", 640, 480);
  _id_B6615BC48F72A828.alignx = "left";
  _id_B6615BC48F72A828.aligny = "top";
  _id_B6615BC48F72A828.sort = 1;
  _id_B6615BC48F72A828.horzalign = "fullscreen";
  _id_B6615BC48F72A828.vertalign = "fullscreen";
  _id_B6615BC48F72A828.alpha = 1;
  _id_B6615BC48F72A828.foreground = 1;

  if(!isDefined(fade_time))
    fade_time = 1.1;

  wait 0.4;
  _id_B6615BC48F72A828 fadeovertime(fade_time);
  _id_B6615BC48F72A828.alpha = 0;
  wait(fade_time);
  _id_B6615BC48F72A828 destroy();
}

_id_266E0A9B20004E84() {
  if(isDefined(self._id_977539DEBDC4190F)) {
    foreach(overlay in self._id_977539DEBDC4190F)
    overlay destroy();

    self._id_977539DEBDC4190F = [];
  }
}

_id_C27CFEC68011401E() {
  level endon("game_ended");
  wait 1;
  scripts\engine\utility::flag_wait("strike_init_done");
  wait 5;
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Raid Intro / Put P1 on CCTV\" \"set scr_raidintrocctv 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_795AAB9BE5D24D17", ::_id_773A2F4E0BC37E0E);
}

_id_773A2F4E0BC37E0E() {
  _id_C5D3D8FF129F88BA = scripts\engine\utility::getclosest(level.player.origin, level._id_5A2AF420BC54EE97._id_46E51D9C12FF301C);
  _id_C5D3D8FF129F88BA notify("trigger", level.player);
}