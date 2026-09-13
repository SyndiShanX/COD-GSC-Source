/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_390bb92b200e27fa.gsc
***********************************************/

_id_432CBDDDEB9A6775() {
  level._effect["door_c4"] = loadfx("vfx/iw8_mp/equipment/c4/vfx_gen_c4_exp_wall.vfx");
}

_id_B1E1270400324B2C() {
  _id_D17EB457D7BD3320();
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  level thread _id_7FD39867798AED21();
  level thread _id_57E41E96F46731E9();
  level thread _id_2F7435043948F679();
}

_id_2F7435043948F679() {
  _id_D7F22834BF5F1340 = scripts\engine\utility::getStructArray("c4_incursion_breach", "script_noteworthy");
  _id_E3FBD008D285B756 = scripts\engine\utility::getStructArray("cb_incursion_breach", "script_noteworthy");
  _id_FA7D92BDFE28224E = scripts\engine\utility::getStructArray("kb_incursion_breach", "script_noteworthy");
  _id_71332A5B74214116::registerinteraction("c4_incursion_breach", ::_id_80CBDEFCD9E9391D, ::_id_4591CB48BB5E6202, ::_id_443495314F438348, 0, "duration_none");
  _id_71332A5B74214116::registerinteraction("cb_incursion_breach", ::_id_3D68F9D0A1D034F3, ::_id_A7C516EA70551004, ::_id_F02011A8C9E45AAE, 0, "duration_none");
  _id_71332A5B74214116::registerinteraction("kb_incursion_breach", ::_id_60B5672ACE6C475B, ::_id_DD432BA689F3895C, ::_id_528253BD04AD4BF6, 0, "duration_none");
}

_id_BCE37EE8A1382987() {
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  wait 30;
  _id_7604F2462ED8F7AF = scripts\engine\utility::getStruct("test_traverse_point", "script_noteworthy");
}

_id_82A5DF146510814F(origin) {
  nodes = getnodesinradius(origin, 400, 0, 200);

  foreach(node in nodes) {
    if(scripts\engine\utility::is_equal(node.type, "Begin"))
      destroynavlink(node);
  }
}

_id_157F1B7EB35E8447(_id_BD16F0D97883FD8D) {
  level endon("game_ended");
  _id_BD16F0D97883FD8D endon("disable_breach_interaction");

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(!isDefined(player._id_6471A32E9012360A))
      player._id_6471A32E9012360A = [];

    _id_4AD171545578DA4C = istrue(player._id_6471A32E9012360A[_id_BD16F0D97883FD8D.script_parameters]);

    if(getdvarint("dvar_445A9F67C9BA0CAB", 0) <= 0 && !_id_4AD171545578DA4C) {
      continue;
    }
    self makeunusable();
    level notify("used_kb", player);
    player.usingobject = 1;
    result = 1;
    player forceplaygestureviewmodel("ges_magma_gas_mask_on");

    if(result) {
      scripts\engine\utility::ent_flag_set("kb_breached");
      player._id_6471A32E9012360A[_id_BD16F0D97883FD8D.script_parameters] = 0;
      level thread _id_E8F38804460DD287(self);
      player.usingobject = undefined;
      return;
    } else
      self makeusable();

    player.usingobject = undefined;
    actorplayer = undefined;
  }
}

_id_27D1D8A853B1697F(_id_BD16F0D97883FD8D) {
  level endon("game_ended");
  _id_BD16F0D97883FD8D endon("disable_breach_interaction");

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    _id_2BF2FB981C5CA61F = istrue(player._id_1FD57894D3F63B70);

    if(getdvarint("dvar_445A9F67C9BA0CAB", 0) <= 0 && !_id_2BF2FB981C5CA61F) {
      continue;
    }
    self makeunusable();
    level notify("used_cb", player);
    _id_CE174178F5680DFC = spawn("script_model", player gettagorigin("tag_accessory_right", 0));
    _id_CE174178F5680DFC.angles = player gettagangles("tag_accessory_right", 0);
    _id_CE174178F5680DFC setModel("halligan_tool_cp");
    _id_CE174178F5680DFC linkTo(player, "tag_accessory_right");
    player.usingobject = 1;
    actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, "player_rig_halligan", 1, 1);
    result = 0;

    if(istrue(player.isjuggernaut))
      result = self.scenenode scripts\cp_mp\anim_scene::anim_scene([actorplayer], "crowbar_breach", undefined, undefined, undefined, undefined, undefined, 1);
    else
      result = self.scenenode scripts\cp_mp\anim_scene::anim_scene([actorplayer], "crowbar_breach");

    if(result) {
      scripts\engine\utility::ent_flag_set("cb_breached");
      level thread _id_28BB903EF720F12F(self);

      if(isDefined(_id_CE174178F5680DFC))
        _id_CE174178F5680DFC delete();

      player.usingobject = undefined;
      return;
    } else {
      if(isDefined(_id_CE174178F5680DFC))
        _id_CE174178F5680DFC delete();

      self makeusable();
    }

    player.usingobject = undefined;
    actorplayer = undefined;
    _id_CE174178F5680DFC = undefined;
  }
}

_id_0A8274FD50E9AD09(ent) {}

_id_60B5672ACE6C475B(interaction, player) {
  if(istrue(interaction._id_3BB7A59939480F9D))
    return "";

  _id_CBEA26C2942E6961 = istrue(player.has_keycard);
  _id_732AD47BBBDE1F2D = istrue(_id_CBEA26C2942E6961) || getdvarint("dvar_445A9F67C9BA0CAB", 0) > 0;

  if(!istrue(_id_732AD47BBBDE1F2D))
    return &"CP_STRIKE/NO_KEYCARD";
  else
    return &"CP_STRIKE/BREACH_KEYCARD";
}

_id_528253BD04AD4BF6(interactions) {
  foreach(_id_BD16F0D97883FD8D in interactions) {
    _id_BB541A1DCFF7C6AD = spawnStruct();
    _id_CED0426E7E729ED5 = scripts\engine\utility::getStruct(_id_BD16F0D97883FD8D.target, "targetname");
    _id_BB541A1DCFF7C6AD.origin = _id_CED0426E7E729ED5.origin;
    _id_BB541A1DCFF7C6AD.angles = _id_CED0426E7E729ED5.angles;

    if(!isDefined(_id_BB541A1DCFF7C6AD.angles))
      _id_BB541A1DCFF7C6AD.angles = (0, 0, 0);

    _id_BD16F0D97883FD8D.scenenode = _id_BB541A1DCFF7C6AD;

    if(!isDefined(_id_CED0426E7E729ED5.target))
      _id_12B5DFA5A257F7A1 = undefined;
    else
      _id_12B5DFA5A257F7A1 = scripts\engine\utility::getStructArray(_id_CED0426E7E729ED5.target, "targetname");

    _id_BD16F0D97883FD8D._id_3D1B736FC1FB1C09 = _id_12B5DFA5A257F7A1;
    _id_BD16F0D97883FD8D._id_9D53C266D664E00A = 1;
    level thread _id_C92D9B66628A2D3F(1, _id_BD16F0D97883FD8D.origin);
  }
}

_id_DD432BA689F3895C(interaction, player) {
  if(!isDefined(player._id_6471A32E9012360A))
    player._id_6471A32E9012360A = [];

  _id_4AD171545578DA4C = istrue(player._id_6471A32E9012360A[interaction.script_parameters]);

  if(getdvarint("dvar_445A9F67C9BA0CAB", 0) <= 0 && !_id_4AD171545578DA4C) {
    return;
  }
  level notify("used_kb", player);
  player.usingobject = 1;
  result = 1;
  player forceplaygestureviewmodel("ges_magma_gas_mask_on");
  player.usingobject = undefined;

  if(result) {
    player._id_6471A32E9012360A[interaction.script_parameters] = 0;
    level thread _id_E8F38804460DD287(interaction);
    return;
  }
}

_id_11B97A4548324652(_id_BD16F0D97883FD8D) {
  if(isDefined(_id_BD16F0D97883FD8D)) {
    _id_ED1AE115523622BB = spawn("script_model", _id_BD16F0D97883FD8D.origin);
    _id_ED1AE115523622BB scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_STRIKE/BREACH_KEYCARD", 25, "duration_none", "hide", 250, 45, 70, 45);
    _id_BB541A1DCFF7C6AD = spawnStruct();
    _id_CED0426E7E729ED5 = scripts\engine\utility::getStruct(_id_BD16F0D97883FD8D.target, "targetname");
    _id_BB541A1DCFF7C6AD.origin = _id_CED0426E7E729ED5.origin;
    _id_BB541A1DCFF7C6AD.angles = _id_CED0426E7E729ED5.angles;

    if(isDefined(_id_BD16F0D97883FD8D.script_parameters))
      _id_ED1AE115523622BB.script_parameters = _id_BD16F0D97883FD8D.script_parameters;

    if(isDefined(_id_BD16F0D97883FD8D.targetname))
      _id_ED1AE115523622BB.targetname = _id_BD16F0D97883FD8D.targetname;

    if(!isDefined(_id_BB541A1DCFF7C6AD.angles))
      _id_BB541A1DCFF7C6AD.angles = (0, 0, 0);

    _id_ED1AE115523622BB.scenenode = _id_BB541A1DCFF7C6AD;
    _id_ED1AE115523622BB scripts\engine\utility::ent_flag_init("cb_breached");
    _id_BD16F0D97883FD8D._id_26FFC3A3E76A0E61 = _id_ED1AE115523622BB;

    if(isDefined(_id_ED1AE115523622BB)) {
      _id_ED1AE115523622BB thread _id_C92D9B66628A2D3F(1, _id_ED1AE115523622BB.origin);
      _id_ED1AE115523622BB thread _id_157F1B7EB35E8447(_id_BD16F0D97883FD8D);
    }

    return _id_ED1AE115523622BB;
  } else
    return undefined;
}

_id_3D68F9D0A1D034F3(interaction, player) {
  if(istrue(interaction._id_3BB7A59939480F9D))
    return "";

  _id_2BF2FB981C5CA61F = istrue(player._id_1FD57894D3F63B70);
  _id_732AD47BBBDE1F2D = istrue(_id_2BF2FB981C5CA61F) || getdvarint("dvar_445A9F67C9BA0CAB", 0) > 0;

  if(!istrue(_id_732AD47BBBDE1F2D))
    return &"CP_STRIKE/NO_HALLIGAN";
  else
    return &"CP_STRIKE/BREACH_HALLIGAN";
}

_id_F02011A8C9E45AAE(interactions) {
  foreach(_id_BD16F0D97883FD8D in interactions) {
    _id_17292B7D0A1CAB15 = spawnStruct();
    _id_CED0426E7E729ED5 = scripts\engine\utility::getStruct(_id_BD16F0D97883FD8D.target, "targetname");
    _id_17292B7D0A1CAB15.origin = _id_CED0426E7E729ED5.origin;
    _id_17292B7D0A1CAB15.angles = _id_CED0426E7E729ED5.angles;

    if(!isDefined(_id_17292B7D0A1CAB15.angles))
      _id_17292B7D0A1CAB15.angles = (0, 0, 0);

    _id_BD16F0D97883FD8D.scenenode = _id_17292B7D0A1CAB15;

    if(!isDefined(_id_CED0426E7E729ED5.target))
      _id_27AA6871A1B49AE9 = undefined;
    else
      _id_27AA6871A1B49AE9 = scripts\engine\utility::getStructArray(_id_CED0426E7E729ED5.target, "targetname");

    _id_BD16F0D97883FD8D._id_3D1B736FC1FB1C09 = _id_27AA6871A1B49AE9;
    _id_BD16F0D97883FD8D._id_9D53C266D664E00A = 1;
    level thread _id_C92D9B66628A2D3F(1, _id_BD16F0D97883FD8D.origin);
  }
}

_id_A7C516EA70551004(interaction, player) {
  _id_2BF2FB981C5CA61F = istrue(player._id_1FD57894D3F63B70);

  if(getdvarint("dvar_445A9F67C9BA0CAB", 0) <= 0 && !_id_2BF2FB981C5CA61F) {
    return;
  }
  level notify("used_cb", player);
  _id_CE174178F5680DFC = spawn("script_model", player gettagorigin("tag_accessory_right", 0));
  _id_CE174178F5680DFC.angles = player gettagangles("tag_accessory_right", 0);
  _id_CE174178F5680DFC setModel("halligan_tool_cp");
  _id_CE174178F5680DFC linkTo(player, "tag_accessory_right");
  player.usingobject = 1;
  actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, "player_rig_halligan", 1, 1);
  result = 0;

  if(istrue(player.isjuggernaut))
    result = interaction.scenenode scripts\cp_mp\anim_scene::anim_scene([actorplayer], "crowbar_breach", undefined, undefined, undefined, undefined, undefined, 1);
  else
    result = interaction.scenenode scripts\cp_mp\anim_scene::anim_scene([actorplayer], "crowbar_breach");

  if(result) {
    level thread _id_28BB903EF720F12F(interaction);

    if(isDefined(_id_CE174178F5680DFC))
      _id_CE174178F5680DFC delete();

    player.usingobject = undefined;
    return;
  } else if(isDefined(_id_CE174178F5680DFC))
    _id_CE174178F5680DFC delete();

  player.usingobject = undefined;
  actorplayer = undefined;
  _id_CE174178F5680DFC = undefined;
}

_id_11958A454809EECA(_id_BD16F0D97883FD8D) {
  if(isDefined(_id_BD16F0D97883FD8D)) {
    _id_CA244E9C9DA9C513 = spawn("script_model", _id_BD16F0D97883FD8D.origin);
    _id_CA244E9C9DA9C513 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_STRIKE/BREACH_HALLIGAN", 25, "duration_none", "hide", 250, 45, 70, 45);
    _id_17292B7D0A1CAB15 = spawnStruct();
    _id_CED0426E7E729ED5 = scripts\engine\utility::getStruct(_id_BD16F0D97883FD8D.target, "targetname");
    _id_17292B7D0A1CAB15.origin = _id_CED0426E7E729ED5.origin;
    _id_17292B7D0A1CAB15.angles = _id_CED0426E7E729ED5.angles;

    if(isDefined(_id_BD16F0D97883FD8D.script_parameters))
      _id_CA244E9C9DA9C513.script_parameters = _id_BD16F0D97883FD8D.script_parameters;

    if(isDefined(_id_BD16F0D97883FD8D.targetname))
      _id_CA244E9C9DA9C513.targetname = _id_BD16F0D97883FD8D.targetname;

    if(!isDefined(_id_17292B7D0A1CAB15.angles))
      _id_17292B7D0A1CAB15.angles = (0, 0, 0);

    _id_CA244E9C9DA9C513.scenenode = _id_17292B7D0A1CAB15;
    _id_CA244E9C9DA9C513 scripts\engine\utility::ent_flag_init("cb_breached");
    _id_BD16F0D97883FD8D._id_26FFC3A3E76A0E61 = _id_CA244E9C9DA9C513;

    if(!isDefined(_id_CED0426E7E729ED5.target))
      _id_27AA6871A1B49AE9 = undefined;
    else
      _id_27AA6871A1B49AE9 = scripts\engine\utility::getStructArray(_id_CED0426E7E729ED5.target, "targetname");

    _id_CA244E9C9DA9C513._id_3D1B736FC1FB1C09 = _id_27AA6871A1B49AE9;

    if(isDefined(_id_CA244E9C9DA9C513)) {
      _id_CA244E9C9DA9C513 thread _id_C92D9B66628A2D3F(1, _id_CA244E9C9DA9C513.origin);
      _id_CA244E9C9DA9C513 thread _id_27D1D8A853B1697F(_id_BD16F0D97883FD8D);
    }

    return _id_CA244E9C9DA9C513;
  } else
    return undefined;
}

setup_c4(_id_BD16F0D97883FD8D) {
  if(isDefined(_id_BD16F0D97883FD8D)) {
    _id_01523AF5F3C759F1 = spawn("script_model", _id_BD16F0D97883FD8D.origin);
    _id_01523AF5F3C759F1 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", "hud_icon_c4_plant", &"CP_STRIKE/PLANT_EXPLOSIVE", 25, "duration_none", "hide", 250, 45, 70, 45);
    _id_25A494915AA2C2D7 = spawnStruct();
    _id_98A87AA837CF6113 = scripts\engine\utility::getStruct(_id_BD16F0D97883FD8D.target, "targetname");
    _id_25A494915AA2C2D7.origin = _id_98A87AA837CF6113.origin;
    _id_25A494915AA2C2D7.angles = _id_98A87AA837CF6113.angles;

    if(isDefined(_id_BD16F0D97883FD8D.script_parameters))
      _id_01523AF5F3C759F1.script_parameters = _id_BD16F0D97883FD8D.script_parameters;

    if(isDefined(_id_BD16F0D97883FD8D.targetname))
      _id_01523AF5F3C759F1.targetname = _id_BD16F0D97883FD8D.targetname;

    if(!isDefined(_id_25A494915AA2C2D7.angles))
      _id_25A494915AA2C2D7.angles = (0, 0, 0);

    _id_01523AF5F3C759F1.scenenode = _id_25A494915AA2C2D7;

    if(!isDefined(_id_98A87AA837CF6113.target))
      _id_F5441D6C16E1171B = undefined;
    else
      _id_F5441D6C16E1171B = scripts\engine\utility::getStructArray(_id_98A87AA837CF6113.target, "targetname");

    _id_01523AF5F3C759F1._id_3D1B736FC1FB1C09 = _id_F5441D6C16E1171B;
    _id_01523AF5F3C759F1 scripts\engine\utility::ent_flag_init("c4_planted");
    _id_01523AF5F3C759F1 scripts\engine\utility::ent_flag_init("c4_exploded");
    _id_BD16F0D97883FD8D._id_26FFC3A3E76A0E61 = _id_01523AF5F3C759F1;

    if(isDefined(_id_01523AF5F3C759F1)) {
      _id_01523AF5F3C759F1 thread _id_C92D9B66628A2D3F(1, _id_01523AF5F3C759F1.origin);
      _id_01523AF5F3C759F1 thread c4_breach_think(_id_BD16F0D97883FD8D);
    }

    return _id_01523AF5F3C759F1;
  } else
    return undefined;
}

_id_80CBDEFCD9E9391D(interaction, player) {
  if(istrue(interaction._id_3BB7A59939480F9D))
    return "";

  if(istrue(level._id_FC3D8E513C281E49))
    return &"CP_STRIKE/PLANT_EXPLOSIVE";

  if(_id_612B1317613FCD5F(player) <= 0 && getdvarint("dvar_445A9F67C9BA0CAB", 0) <= 0) {
    return;
  }
  return &"CP_STRIKE/PLANT_EXPLOSIVE";
  return;
}

_id_612B1317613FCD5F(player) {
  if(!isDefined(player._id_ECDAD53F119BE384))
    player._id_ECDAD53F119BE384 = 0;

  return player._id_ECDAD53F119BE384;
}

_id_443495314F438348(interactions) {
  foreach(_id_BD16F0D97883FD8D in interactions) {
    _id_01523AF5F3C759F1 = spawn("script_model", _id_BD16F0D97883FD8D.origin);
    _id_01523AF5F3C759F1 scripts\engine\utility::ent_flag_init("c4_planted");
    _id_01523AF5F3C759F1 scripts\engine\utility::ent_flag_init("c4_exploded");
    _id_BD16F0D97883FD8D._id_26FFC3A3E76A0E61 = _id_01523AF5F3C759F1;
    _id_25A494915AA2C2D7 = spawnStruct();
    _id_BD16F0D97883FD8D.custom_search_dist = 16384;
    _id_BD16F0D97883FD8D.equipment = "c4_inc_breach";
    _id_BD16F0D97883FD8D._id_8DBA14B341E25DEB = 1;
    _id_BD16F0D97883FD8D._id_10653A9B07EE3ECE = 0;
    _id_98A87AA837CF6113 = scripts\engine\utility::getStruct(_id_BD16F0D97883FD8D.target, "targetname");
    _id_25A494915AA2C2D7.origin = _id_98A87AA837CF6113.origin;
    _id_25A494915AA2C2D7.angles = _id_98A87AA837CF6113.angles;

    if(isDefined(_id_BD16F0D97883FD8D.script_parameters))
      _id_01523AF5F3C759F1.script_parameters = _id_BD16F0D97883FD8D.script_parameters;

    if(!isDefined(_id_25A494915AA2C2D7.angles))
      _id_25A494915AA2C2D7.angles = (0, 0, 0);

    _id_BD16F0D97883FD8D.scenenode = _id_25A494915AA2C2D7;

    if(!isDefined(_id_98A87AA837CF6113.target))
      _id_F5441D6C16E1171B = undefined;
    else
      _id_F5441D6C16E1171B = scripts\engine\utility::getStructArray(_id_98A87AA837CF6113.target, "targetname");

    _id_BD16F0D97883FD8D._id_3D1B736FC1FB1C09 = _id_F5441D6C16E1171B;
    _id_BD16F0D97883FD8D._id_9D53C266D664E00A = 1;
    level thread _id_C92D9B66628A2D3F(1, _id_BD16F0D97883FD8D.origin);
  }

  _id_780514F14B1134ED::_id_22D4DBFE8C0A69D2(interactions);
}

_id_4591CB48BB5E6202(interaction, player) {
  if(!isPlayer(player) || istrue(interaction._id_3BB7A59939480F9D)) {
    return;
  }
  if(player _id_71332A5B74214116::can_purchase_interaction(interaction, interaction.cost)) {
    player _id_70C3660758C8833E(1);
    level notify("equipment_purchase", interaction, player);
    _id_71332A5B74214116::_id_9A2E153E21F32208(interaction, player);
    _id_142708E1E477DA79(interaction);
  } else
    interaction.interaction_trigger setHintString(&"CP_WEAPON_BUY/NO_PURCHASE");

  _id_3483795B0A68EB95 = _id_612B1317613FCD5F(player);
  _id_C0337D5AAC18D7E8 = player._id_ECDAD53F119BE384 > 0;

  if(istrue(_id_C0337D5AAC18D7E8))
    _id_3483795B0A68EB95 = player._id_ECDAD53F119BE384;

  _id_DA7C67A5AFCDD98C = istrue(_id_C0337D5AAC18D7E8) && _id_3483795B0A68EB95 > 0;

  if(!istrue(_id_DA7C67A5AFCDD98C) && getdvarint("dvar_445A9F67C9BA0CAB", 0) <= 0) {
    return;
  }
  interaction._id_3BB7A59939480F9D = 1;
  level notify("used_c4", player);

  if(istrue(interaction.bskipplantsequence)) {
    if(isDefined(level.alternate_breach_anim_func))
      interaction[[level.alternate_breach_anim_func]](player);

    return;
  }

  level thread c4_placing_bc(player);
  c4 = spawn("script_model", interaction.scenenode.origin);
  c4.angles = interaction.scenenode.angles;
  c4 setModel("offhand_2h_wm_c4_v0");
  player.usingobject = 1;
  actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, "player_rig", 1);
  _id_2CE69F8431572669 = scripts\cp_mp\anim_scene::anim_scene_create_actor(c4, "c4_prop");
  _id_2CE69F8431572669 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "c4_plant", 1);
  c4 scripts\common\anim::anim_first_frame_solo(c4, "c4_plant");
  result = 0;

  if(istrue(player.isjuggernaut)) {
    c4 show();
    result = interaction.scenenode scripts\cp_mp\anim_scene::anim_scene([actorplayer, _id_2CE69F8431572669], "c4_plant", undefined, undefined, undefined, undefined, undefined, 1);
  } else
    result = interaction.scenenode scripts\cp_mp\anim_scene::anim_scene([actorplayer, _id_2CE69F8431572669], "c4_plant");

  if(result) {
    interaction._id_26FFC3A3E76A0E61 scripts\engine\utility::ent_flag_set("c4_planted");
    level thread c4_explode(interaction, c4, player);
    level thread c4_placed_bc(player);

    if(getdvarint("dvar_445A9F67C9BA0CAB", 0) <= 0)
      player._id_ECDAD53F119BE384--;

    if(player._id_ECDAD53F119BE384 == 0) {
      if(isDefined(player._id_C1C897BD5219A540))
        player scripts\cp\utility::_id_98F7CA3781DAC77C(player, player._id_C1C897BD5219A540.carry_ref);

      player._id_C1C897BD5219A540 = undefined;
    }

    player.usingobject = undefined;
    return;
  } else {
    if(isDefined(c4))
      c4 delete();

    self makeusable();
  }

  player.usingobject = undefined;
  actorplayer = undefined;
  _id_2CE69F8431572669 = undefined;
}

c4_breach_think(_id_BD16F0D97883FD8D) {
  level endon("game_ended");
  _id_BD16F0D97883FD8D endon("disable_breach_interaction");

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(!isDefined(player._id_ECDAD53F119BE384))
      player._id_ECDAD53F119BE384 = 0;

    _id_C0337D5AAC18D7E8 = player._id_ECDAD53F119BE384;
    _id_3483795B0A68EB95 = 0;

    if(istrue(_id_C0337D5AAC18D7E8))
      _id_3483795B0A68EB95 = player._id_ECDAD53F119BE384;

    _id_DA7C67A5AFCDD98C = istrue(_id_C0337D5AAC18D7E8) && _id_3483795B0A68EB95 > 0;

    if(!istrue(_id_DA7C67A5AFCDD98C) && getdvarint("dvar_445A9F67C9BA0CAB", 0) <= 0) {
      continue;
    }
    self makeunusable();
    level notify("used_c4", player);

    if(istrue(self.bskipplantsequence)) {
      if(isDefined(level.alternate_breach_anim_func))
        self[[level.alternate_breach_anim_func]](player);

      return;
    }

    level thread c4_placing_bc(player);
    c4 = spawn("script_model", self.scenenode.origin);
    c4.angles = self.scenenode.angles;
    c4 setModel("offhand_2h_wm_c4_v0");
    player.usingobject = 1;
    actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, "player_rig", 1);
    _id_2CE69F8431572669 = scripts\cp_mp\anim_scene::anim_scene_create_actor(c4, "c4_prop");
    _id_2CE69F8431572669 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "c4_plant", 1);
    c4 scripts\common\anim::anim_first_frame_solo(c4, "c4_plant");
    result = 0;

    if(istrue(player.isjuggernaut)) {
      c4 show();
      result = self.scenenode scripts\cp_mp\anim_scene::anim_scene([actorplayer, _id_2CE69F8431572669], "c4_plant", undefined, undefined, undefined, undefined, undefined, 1);
    } else
      result = self.scenenode scripts\cp_mp\anim_scene::anim_scene([actorplayer, _id_2CE69F8431572669], "c4_plant");

    if(result) {
      scripts\engine\utility::ent_flag_set("c4_planted");
      level thread c4_explode(self, c4);
      level thread c4_placed_bc(player);

      if(getdvarint("dvar_445A9F67C9BA0CAB", 0) <= 0)
        player._id_ECDAD53F119BE384--;

      if(player._id_ECDAD53F119BE384 == 0) {
        if(isDefined(player._id_C1C897BD5219A540))
          player scripts\cp\utility::_id_98F7CA3781DAC77C(player, player._id_C1C897BD5219A540.carry_ref);

        player._id_C1C897BD5219A540 = undefined;
      }

      player.usingobject = undefined;
      return;
    } else {
      if(isDefined(c4))
        c4 delete();

      self makeusable();
    }

    player.usingobject = undefined;
    actorplayer = undefined;
    _id_2CE69F8431572669 = undefined;
  }
}

c4_placing_bc(player) {}

c4_placed_bc(player) {}

c4_explode(interaction, c4, _id_741F82E1A668A329) {
  c4 setscriptablepartstate("effects", "plant", 0);
  currenttime = gettime();
  _id_F28399727742EB23 = int(currenttime + 5000);
  _id_C301D652D9A73075 = _id_F28399727742EB23 - currenttime;

  if(istrue(interaction.bskipplantsequence))
    _id_C301D652D9A73075 = 0;

  while(_id_C301D652D9A73075 > 0) {
    currenttime = gettime();
    _id_C301D652D9A73075 = _id_F28399727742EB23 - currenttime;

    if(_id_C301D652D9A73075 < 1500) {
      if(_id_C301D652D9A73075 <= 250) {
        if(soundexists("breach_warning_beep_05"))
          c4 playSound("breach_warning_beep_05");
      } else if(_id_C301D652D9A73075 < 500) {
        if(soundexists("breach_warning_beep_04"))
          c4 playSound("breach_warning_beep_04");
      } else if(_id_C301D652D9A73075 < 1500) {
        if(soundexists("breach_warning_beep_03"))
          c4 playSound("breach_warning_beep_03");
      } else if(soundexists("breach_warning_beep_02"))
        c4 playSound("breach_warning_beep_02");

      wait 0.25;
    } else if(_id_C301D652D9A73075 < 3500) {
      if(soundexists("breach_warning_beep_02"))
        c4 playSound("breach_warning_beep_02");

      wait 0.5;
    } else {
      if(soundexists("breach_warning_beep_01"))
        c4 playSound("breach_warning_beep_01");

      wait 1.0;
    }

    if(_id_C301D652D9A73075 < 0) {
      break;
    }
  }

  if(!istrue(interaction.bskipplantsequence)) {
    physicsexplosionsphere(c4.origin, 200, 100, 3);
    c4 setscriptablepartstate("effects", "explodeWall");
    c4._id_5E935525BB5BC608 = spawnfx(scripts\engine\utility::getfx("door_c4"), c4.origin);
  }

  interaction._id_26FFC3A3E76A0E61 scripts\engine\utility::ent_flag_set("c4_exploded");
  level notify("c4_exploded", c4.origin, _id_741F82E1A668A329);
  level thread _id_CE4CFFF75D2D5785(interaction);
}

_id_CE4CFFF75D2D5785(_id_3032FC918BFE72D2) {
  _id_49996EBEBBBBF375 = _id_3032FC918BFE72D2.script_parameters;
  _id_8275132686444104 = _id_3032FC918BFE72D2.script_parameters;

  if(isDefined(_id_49996EBEBBBBF375))
    scripts\engine\utility::flag_set(_id_49996EBEBBBBF375);

  _id_48DF711E143EAE26 = [];

  if(isDefined(_id_8275132686444104))
    _id_48DF711E143EAE26 = _id_E5BD3562DD8134CD(_id_8275132686444104);

  foreach(_id_32595262B98E6F31 in _id_48DF711E143EAE26) {
    if(distance(_id_32595262B98E6F31.origin, _id_3032FC918BFE72D2.origin) <= 128) {
      _id_32595262B98E6F31 notsolid();
      _id_32595262B98E6F31 connectpaths();
    }
  }

  _id_3DA9994BC5B80710 = getEntArray("incursion_breach_univblocker", "targetname");

  foreach(_id_32595262B98E6F31 in _id_3DA9994BC5B80710) {
    if(_id_32595262B98E6F31.script_noteworthy == _id_8275132686444104)
      _id_32595262B98E6F31 notsolid();
  }

  _id_142708E1E477DA79(_id_3032FC918BFE72D2);
  level thread _id_C92D9B66628A2D3F(0, _id_3032FC918BFE72D2.origin);
  _id_316FD8977A44FB1E = _id_C437EDDC9D971768(_id_49996EBEBBBBF375, _id_3032FC918BFE72D2.origin);

  foreach(ent in _id_316FD8977A44FB1E)
  ent delete();

  if(isDefined(_id_3032FC918BFE72D2._id_3D1B736FC1FB1C09) && _id_3032FC918BFE72D2._id_3D1B736FC1FB1C09.size > 0) {
    foreach(_id_DDA3F6480ACD84A0 in _id_3032FC918BFE72D2._id_3D1B736FC1FB1C09)
    _id_82A5DF146510814F(_id_DDA3F6480ACD84A0.origin);
  }
}

_id_142708E1E477DA79(_id_3032FC918BFE72D2) {
  _id_49996EBEBBBBF375 = _id_3032FC918BFE72D2.script_parameters;
  interactions = _id_DF22A6D0B721DAB3(_id_49996EBEBBBBF375, 1);

  foreach(interaction in interactions) {
    if(interaction != _id_3032FC918BFE72D2 && distance(interaction.origin, _id_3032FC918BFE72D2.origin) <= 512) {
      interaction notify("disable_breach_interaction");
      interaction._id_3BB7A59939480F9D = 1;
      _id_71332A5B74214116::remove_from_current_interaction_list(interaction);
      continue;
    }

    if(interaction == _id_3032FC918BFE72D2) {
      interaction notify("disable_breach_interaction");
      interaction._id_3BB7A59939480F9D = 1;
      _id_71332A5B74214116::remove_from_current_interaction_list(interaction);
    }
  }
}

_id_E8F38804460DD287(_id_C119FDCF563D30D5) {
  _id_49996EBEBBBBF375 = _id_C119FDCF563D30D5.script_parameters;
  _id_8275132686444104 = _id_C119FDCF563D30D5.script_parameters;

  if(isDefined(_id_49996EBEBBBBF375))
    scripts\engine\utility::flag_set(_id_49996EBEBBBBF375);

  _id_48DF711E143EAE26 = [];

  if(isDefined(_id_8275132686444104))
    _id_48DF711E143EAE26 = _id_E5BD3562DD8134CD(_id_8275132686444104);

  foreach(_id_32595262B98E6F31 in _id_48DF711E143EAE26) {
    _id_32595262B98E6F31 notsolid();
    _id_32595262B98E6F31 connectpaths();
  }

  interactions = _id_DF22A6D0B721DAB3(_id_49996EBEBBBBF375, 1);

  foreach(interaction in interactions) {
    if(interaction != _id_C119FDCF563D30D5 && distance(interaction.origin, _id_C119FDCF563D30D5.origin) <= 512) {
      interaction notify("disable_breach_interaction");
      continue;
    }

    if(interaction == _id_C119FDCF563D30D5) {
      level thread _id_C92D9B66628A2D3F(0, interaction.origin);
      interaction notify("disable_breach_interaction");
    }
  }

  _id_316FD8977A44FB1E = _id_C437EDDC9D971768(_id_49996EBEBBBBF375);

  foreach(ent in _id_316FD8977A44FB1E)
  ent delete();
}

_id_28BB903EF720F12F(_id_AC479D6273C7AA6D) {
  _id_49996EBEBBBBF375 = _id_AC479D6273C7AA6D.script_parameters;
  _id_8275132686444104 = _id_AC479D6273C7AA6D.script_parameters;

  if(isDefined(_id_49996EBEBBBBF375))
    scripts\engine\utility::flag_set(_id_49996EBEBBBBF375);

  _id_48DF711E143EAE26 = [];

  if(isDefined(_id_8275132686444104))
    _id_48DF711E143EAE26 = _id_E5BD3562DD8134CD(_id_8275132686444104);

  foreach(_id_32595262B98E6F31 in _id_48DF711E143EAE26) {
    if(distance(_id_32595262B98E6F31.origin, _id_AC479D6273C7AA6D.origin) <= 512) {
      _id_32595262B98E6F31 notsolid();
      _id_32595262B98E6F31 connectpaths();
    }
  }

  interactions = _id_DF22A6D0B721DAB3(_id_49996EBEBBBBF375, 1);

  foreach(interaction in interactions) {
    if(interaction != _id_AC479D6273C7AA6D && distance(interaction.origin, _id_AC479D6273C7AA6D.origin) <= 512) {
      interaction notify("disable_breach_interaction");
      continue;
    }

    if(interaction == _id_AC479D6273C7AA6D) {
      level thread _id_C92D9B66628A2D3F(0, interaction.origin);
      interaction notify("disable_breach_interaction");
    }
  }

  _id_316FD8977A44FB1E = _id_C437EDDC9D971768(_id_49996EBEBBBBF375);

  foreach(ent in _id_316FD8977A44FB1E)
  ent delete();

  if(isDefined(_id_AC479D6273C7AA6D._id_3D1B736FC1FB1C09) && _id_AC479D6273C7AA6D._id_3D1B736FC1FB1C09.size > 0) {
    foreach(_id_DDA3F6480ACD84A0 in _id_AC479D6273C7AA6D._id_3D1B736FC1FB1C09)
    _id_82A5DF146510814F(_id_DDA3F6480ACD84A0.origin);
  }
}

_id_E5BD3562DD8134CD(_id_8275132686444104) {
  if(!isDefined(level._id_DF8A256EE1D486BF))
    return undefined;

  _id_48DF711E143EAE26 = [];

  foreach(_id_32595262B98E6F31 in level._id_DF8A256EE1D486BF) {
    if(isDefined(_id_32595262B98E6F31.script_noteworthy) && _id_32595262B98E6F31.script_noteworthy == _id_8275132686444104)
      _id_48DF711E143EAE26[_id_48DF711E143EAE26.size] = _id_32595262B98E6F31;
  }

  return _id_48DF711E143EAE26;
}

_id_DF22A6D0B721DAB3(_id_965955A16971E8BF, _id_D21A610853EFA331) {
  _id_FC5F2A34682D6157 = scripts\engine\utility::getStructArray("c4_incursion_breach", "script_noteworthy");
  _id_28919A2C8D8741ED = scripts\engine\utility::getStructArray("cb_incursion_breach", "script_noteworthy");
  _id_BA81FAF6C93D0536 = scripts\cp\utility::array_merge(_id_FC5F2A34682D6157, _id_28919A2C8D8741ED);
  _id_3E71AA08E65B1058 = [];

  foreach(struct in _id_BA81FAF6C93D0536) {
    if(isDefined(struct.script_parameters) && struct.script_parameters == _id_965955A16971E8BF) {
      if(istrue(_id_D21A610853EFA331)) {
        _id_3E71AA08E65B1058[_id_3E71AA08E65B1058.size] = struct;
        continue;
      }

      _id_3E71AA08E65B1058[_id_3E71AA08E65B1058.size] = struct._id_26FFC3A3E76A0E61;
    }
  }

  return _id_3E71AA08E65B1058;
}

_id_C437EDDC9D971768(_id_965955A16971E8BF, origin) {
  _id_A2FCE1A0DAA1830A = getEntArray("incursion_breach_ent", "script_noteworthy");
  _id_316FD8977A44FB1E = [];

  foreach(ent in _id_A2FCE1A0DAA1830A) {
    if(isDefined(ent.struct) && isDefined(ent.struct.script_parameters) && ent.struct.script_parameters == _id_965955A16971E8BF) {
      if(isDefined(origin) && distance(ent.origin, origin) > 512)
        continue;
      else
        _id_316FD8977A44FB1E[_id_316FD8977A44FB1E.size] = ent;

      continue;
    }

    if(isent(ent) && isDefined(ent.script_parameters) && ent.script_parameters == _id_965955A16971E8BF) {
      if(isDefined(origin) && distance(ent.origin, origin) > 512)
        continue;
      else
        _id_316FD8977A44FB1E[_id_316FD8977A44FB1E.size] = ent;
    }
  }

  return _id_316FD8977A44FB1E;
}

_id_C92D9B66628A2D3F(closed, pos, _id_16066B342854A767) {
  _id_2A140C28069BB952 = ["scriptable_door_wooden_panel_mp_01", "scriptable_ee_door_wooden_entrance_01", "scriptable_door_wooden_hollow_mp_01", "scriptable_door_metal_single_b_02_grey", "scriptable_construction_doors_metal_b_02_mp", "scriptable_door_metal_04_flat_painted_mp_tan"];
  _id_786FD7C325A6D910 = [];

  foreach(doortype in _id_2A140C28069BB952)
  _id_786FD7C325A6D910 = scripts\cp\utility::array_merge(_id_786FD7C325A6D910, getentitylessscriptablearray("scriptable_" + doortype, "classname", pos, 256));

  foreach(_id_26BAEFB3804B52C3 in _id_786FD7C325A6D910) {
    if(_id_26BAEFB3804B52C3 scriptableisdoor()) {
      if(closed) {
        timeout = 0;
        _id_26BAEFB3804B52C3 scriptabledoorclose();

        while(!_id_26BAEFB3804B52C3 scriptabledoorisclosed() && timeout < 10) {
          wait 0.1;
          timeout++;
        }

        _id_26BAEFB3804B52C3 scriptabledoorfreeze(1);
        continue;
      }

      _id_26BAEFB3804B52C3 scriptabledoorfreeze(0);

      if(!istrue(_id_16066B342854A767))
        _id_26BAEFB3804B52C3 scriptabledooropen("away", pos);
    }
  }
}

_id_70C3660758C8833E(amount) {
  player = self;

  if(!isDefined(player._id_ECDAD53F119BE384))
    player._id_ECDAD53F119BE384 = 0;

  if(!isDefined(amount) || amount > 1) {
    player._id_ECDAD53F119BE384 = int(min(player._id_ECDAD53F119BE384 + 3, 3));
    player._id_C1C897BD5219A540 = scripts\cp\utility::set_carry_item(self, "c4_breach_charge");
  } else
    player._id_ECDAD53F119BE384 = amount;
}

_id_7FD39867798AED21() {
  _id_D7F22834BF5F1340 = scripts\engine\utility::getStructArray("c4_incursion_breach", "script_noteworthy");
  _id_E3FBD008D285B756 = scripts\engine\utility::getStructArray("cb_incursion_breach", "script_noteworthy");
  _id_F18CCD69CE4F0916 = scripts\cp\utility::array_merge(_id_D7F22834BF5F1340, _id_E3FBD008D285B756);

  foreach(ent in _id_F18CCD69CE4F0916) {
    if(isDefined(ent.script_parameters) && ent.script_parameters != "")
      scripts\engine\utility::flag_init(ent.script_parameters);
  }
}

_id_57E41E96F46731E9() {
  level._id_DF8A256EE1D486BF = getEntArray("incursion_breach_blocker", "targetname");

  foreach(_id_32595262B98E6F31 in level._id_DF8A256EE1D486BF)
  _id_32595262B98E6F31 disconnectPaths();
}

#using_animtree("script_model");

_id_D17EB457D7BD3320() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_anim["player_rig"]["c4_plant"] = % wm_equip_c4_attach;
  level.scr_animname["player_rig"]["c4_plant"] = "wm_equip_c4_attach";
  level.scr_eventanim["player_rig"]["c4_plant"] = "equip_c4_attach";
  level.scr_animtree["c4_prop"] = #animtree;
  level.scr_anim["c4_prop"]["c4_plant"] = % wm_equip_c4_attach_c4;
  level.scr_animname["c4_prop"]["c4_plant"] = "wm_equip_c4_attach_c4";
  level.scr_anim["player_rig_halligan"]["crowbar_breach"] = % cp_scripted_halligan_enter;
  level.scr_animname["player_rig_halligan"]["crowbar_breach"] = "cp_scripted_halligan_enter";
  level.scr_eventanim["player_rig_halligan"]["crowbar_breach"] = "equip_halligan_breach";
  scripts\common\anim::addnotetrack_customfunction("player_rig_halligan", "cp_halligan_open_door", ::_id_0A8274FD50E9AD09);
}