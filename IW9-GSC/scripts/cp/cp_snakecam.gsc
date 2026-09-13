/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_snakecam.gsc
***********************************************/

init() {
  _id_2C075D80EC62E503::_id_53AB5DD012D67963();
}

init_camera_interaction() {
  script_model_anims();

  if(!isDefined(level._id_248DBA4332A49AD3))
    level._id_248DBA4332A49AD3 = ::_id_248DBA4332A49AD3;

  thread _id_5F077055EEE53D8C();
  scripts\engine\scriptable::scriptable_addusedcallback(::_id_216A48E2DBEC763F);
}

_id_248DBA4332A49AD3() {
  self endon("disconnect");
  player = self;

  if(istrue(player.enteredcamera)) {
    remove_player_from_cam(player);
    return 1;
  } else
    return 0;
}

_id_85ADC29814A88D9D() {
  level endon("game_ended");
  self endon("completed_snakecam_exit");

  for(;;) {
    self waittill("death");
    remove_player_from_cam(self);
  }
}

poke_the_player_after_faux_death() {
  self endon("disconnect");
  self endon("death");
  self endon("laststand");
  self waittill("completed_snakecam_exit");
  wait 0.1;

  if(!self.inlaststand)
    self suicide();
}

_id_216A48E2DBEC763F(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(isDefined(instance)) {
    if(instance.type == "snakecam_interaction") {
      if(!istrue(instance.isinuse)) {
        instance.isinuse = 1;
        _id_19D3F246D4FED2FE(instance);
        thread _id_D25799279EC14C4C(instance);
        snakecam_activate_func(instance._id_DF071553D0996FF9, player);
        _id_8CA93624EA5F3C01(instance);
      }
    }
  }
}

_id_8CA93624EA5F3C01(instance) {
  foreach(player in level.players)
  instance enablescriptableplayeruse(player);
}

_id_19D3F246D4FED2FE(instance) {
  foreach(player in level.players)
  instance disablescriptableplayeruse(player);
}

_id_3CCF13603AC68E58(waittime) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  wait(waittime);

  if(!istrue(self.isjuggernaut))
    self setclientomnvar("ui_snakecam", 1);
}

snakecam_hint_func(_id_DF071553D0996FF9, player) {
  return &"SNAKECAM/USE";
}

snakecam_activate_func(_id_DF071553D0996FF9, player) {
  if(!isPlayer(player) || istrue(_id_DF071553D0996FF9.isinuse)) {
    return;
  }
  _id_DF071553D0996FF9.isinuse = 1;

  if(istrue(_id_DF071553D0996FF9.disabled)) {
    return;
  }
  if(istrue(player.tablet_out)) {
    return;
  }
  player endon("disconnect");
  player thread _id_7F4E0FFC4558B72F(3);
  _id_DF071553D0996FF9.target_obj = scripts\engine\utility::getStruct(_id_DF071553D0996FF9.target, "targetname");

  if(!isDefined(_id_DF071553D0996FF9.target_obj.angles))
    _id_DF071553D0996FF9.target_obj.angles = (0, 0, 0);

  _id_8431FDE12E056D7F = player _meth_C1092F42B6BBE490();
  _id_D33961AFF90DFA24 = player getstance();
  tag = spawn("script_model", player.origin);
  tag setModel("tag_player");
  tag.origin = _id_DF071553D0996FF9.target_obj.origin;
  tag.angles = _id_DF071553D0996FF9.target_obj.angles;
  animtag = spawn("script_model", tag.origin);
  _id_6E155DC8C2FA9E2E = scripts\cp\utility::get_point_in_local_ent_space(tag, (-10, 0, 0));
  animtag.origin = scripts\engine\utility::drop_to_ground(_id_6E155DC8C2FA9E2E, 64);
  animtag.angles = tag.angles;
  player scripts\engine\utility::waittill_any_timeout_1(0.3, "swapped_to_gunless");
  player playlocalsound("cp_ui_snakecam_in_foly_plr");
  _id_1EE766CF65CD6B47 = 0.5;

  if(player getstance() == "prone")
    _id_1EE766CF65CD6B47 = 0.4;
  else if(player getstance() == "crouch")
    _id_1EE766CF65CD6B47 = 0.5;

  player thread _id_3CCF13603AC68E58(_id_1EE766CF65CD6B47);
  thread _id_0FB9891F994D3178(player, animtag, _id_8431FDE12E056D7F, _id_D33961AFF90DFA24);
  player waittill("entered_snakecam_anim");
  waitframe();
  player thread _id_85ADC29814A88D9D();
  player.enteredcamera = 1;
  player.nvg_was_on = 0;
  player.disable_map_tablet = 1;
  player notify("enter_cam");
  player.og_origin = player.origin;
  player.og_angles = player getplayerangles();
  player.og_stance = player getstance();
  fwd = anglesToForward(_id_DF071553D0996FF9.target_obj.angles);
  _id_01F7736673CDA8D6 = vectorNormalize(_id_DF071553D0996FF9.target_obj.origin - player getorigin());
  dot = vectordot(fwd, _id_01F7736673CDA8D6);
  put_player_on_cam(tag, player, _id_DF071553D0996FF9);
  level notify("snakecam_used", player);
  player playlocalsound("cp_ui_snakecam_in_plr");
  player thread snake_cam_control(tag);
  _id_DC1ABBAB0BC304F5 = "embassy_cctv_01";

  if(isDefined(level._id_5E3F92C109670A2E))
    _id_DC1ABBAB0BC304F5 = level._id_5E3F92C109670A2E;

  if(isDefined(_id_DF071553D0996FF9.script_parameters) && _id_DF071553D0996FF9.script_parameters != "default")
    _id_DC1ABBAB0BC304F5 = _id_DF071553D0996FF9.script_parameters;

  _id_DF071553D0996FF9.cam_hud = snake_door_cam_hud(player, _id_DC1ABBAB0BC304F5);
  _id_379B46B62FA2C9A3 = 0;
  _id_BFDA656E7B3CC1A0 = 90;
  _id_DF071553D0996FF9 thread waittill_player_exits_cam(player);
  _id_DF071553D0996FF9 scripts\engine\utility::waittill_any_timeout_1(_id_BFDA656E7B3CC1A0, "player_left_cam");
  _id_1B9B8DAF429DD199 = tag.origin + anglesToForward(tag.angles) * -20;
  player.enteredcamera = undefined;
  player.disable_map_tablet = 0;
  wait 0.25;
  player notify("leave_cam");

  foreach(_id_A0DDCCC8DA0CA6AB in _id_DF071553D0996FF9.cam_hud)
  _id_A0DDCCC8DA0CA6AB destroy();

  level thread scripts\cp\cp_puzzles_core::static_burst(0.55, player);
  player stoprumble("steady_rumble");
  player playlocalsound("cp_ui_snakecam_out_plr");
  level scripts\cp\utility::add_wait(scripts\cp\utility::waittill_msg, "static_faded_in");
  scripts\cp\utility::do_wait_any();
  scripts\cp\utility::outline_fade_alpha_for_index(6, 0.8, 0.5);
  level notify("vision_set_change_request", undefined, player, 0.05, _id_DC1ABBAB0BC304F5);
  wait 0.1;
  remove_player_from_cam(player);

  if(!istrue(player.isjuggernaut))
    player setclientomnvar("ui_snakecam", 0);

  scripts\cp\utility::outline_fade_alpha_for_index(6, 0, 9.0);
  player notify("completed_snakecam_exit");
  animtag scripts\engine\utility::waittill_any_timeout_1(5, "exit_anim_done");
  player thread takegunless();
  tag delete();
  animtag delete();
  _id_DF071553D0996FF9.isinuse = 0;
  _id_DF071553D0996FF9.scriptable.isinuse = 0;
}

_id_D63C50E6896930EA(_id_F3C168134A5DDAE7) {
  level._id_5E3F92C109670A2E = _id_F3C168134A5DDAE7;
}

_id_9EB975A126BFE444(_id_0FA9BFA35A863FA9, _id_E99BE672BC67AEB0, loopanim) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  wait(_id_0FA9BFA35A863FA9);
  self._id_EA741C5B7B9EDA80 show();
  wait(_id_E99BE672BC67AEB0);
  self._id_24C22D4AEAB7EF2F show();
  self._id_24C22D4AEAB7EF2F scriptmodelclearanim();
  self._id_24C22D4AEAB7EF2F scriptmodelplayanim(loopanim);
}

#using_animtree("script_model");

_id_0FB9891F994D3178(player, _id_C7DDD9229F6512A3, _id_DD1D08B0C203D5CE, _id_D33961AFF90DFA24) {
  level endon("game_ended");
  player endon("death");
  player endon("disconnect");

  if(!isDefined(_id_DD1D08B0C203D5CE))
    _id_DD1D08B0C203D5CE = player _meth_C1092F42B6BBE490();

  if(!isDefined(_id_D33961AFF90DFA24))
    _id_D33961AFF90DFA24 = player getstance();

  animalias = undefined;

  switch (_id_D33961AFF90DFA24) {
    case "stand":
    default:
      animalias = "stand_enter";
      loopanim = % iw9_mp_equip_snakecam_loop;
      _id_457A0F528BFF306C = "stand_exit";
      break;
    case "crouch":
      animalias = "crouch_enter";
      loopanim = % iw9_mp_equip_snakecam_loop;
      _id_457A0F528BFF306C = "crouch_exit";
      break;
    case "prone":
      player.anim_scene_stance_override = "prone";
      animalias = "prone_enter";
      loopanim = % iw9_mp_equip_snakecam_loop_prone;
      _id_457A0F528BFF306C = "prone_exit";
      break;
  }

  anim_array = [];

  if(isDefined(player)) {
    actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, "snakecam", 1);
    actorplayer scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "snakecam", 1);
    anim_array[anim_array.size] = actorplayer;
  }

  cam = spawn("script_model", player gettagorigin("tag_weapon_right"));
  cam hide();
  cam.angles = player gettagangles("tag_weapon_right");
  cam dontinterpolate();
  cam linkTo(player, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
  cam setModel("misc_vm_snakecam_v0");
  tablet = spawn("script_model", player gettagorigin("tag_accessory_left"));
  tablet hide();
  tablet.angles = player gettagangles("tag_accessory_left");
  tablet linkTo(player, "tag_accessory_left", (0, 0, 0), (0, 0, 0));
  tablet setModel("offhand2h_tablet_static_v0");
  player._id_24C22D4AEAB7EF2F = cam;
  player._id_EA741C5B7B9EDA80 = tablet;

  if(anim_array.size > 0) {
    player thread _id_9EB975A126BFE444(1, 0.1, loopanim);
    result = _id_C7DDD9229F6512A3 scripts\cp_mp\anim_scene::anim_scene(anim_array, animalias, 1, 1, undefined, 0, 0.5);
  }

  player notify("entered_snakecam_anim");
  waitframe();

  if(!isDefined(player.model) || !isDefined(player.headmodel)) {
    return;
  }
  body = spawn("script_model", player.origin);
  body.angles = player.angles;
  body setModel(player getcustomizationbody());
  head = spawn("script_model", player.origin);
  head.angles = player.angles;
  head setModel(player getcustomizationhead());
  head linkTo(body, "j_neck", (-9, 1, 0), (0, 0, 0));
  body.head = head;

  if(!istrue(_id_DD1D08B0C203D5CE)) {
    foreach(_id_6EE5484560EC747C in level.players) {
      if(_id_6EE5484560EC747C == player) {
        body hidefromplayer(_id_6EE5484560EC747C);
        head hidefromplayer(_id_6EE5484560EC747C);
        continue;
      }

      body showtoplayer(_id_6EE5484560EC747C);
      head showtoplayer(_id_6EE5484560EC747C);
    }
  }

  player scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
  player setsolid(0);
  thread _id_2FE064DFEFD94529(player, body, _id_C7DDD9229F6512A3, loopanim);
  player scripts\engine\utility::waittill_any_2("leave_cam", "completed_snakecam_exit");
  thread _id_DDC7967C675A6D0F(player, body, _id_C7DDD9229F6512A3, _id_457A0F528BFF306C);
}

_id_2FE064DFEFD94529(player, body, _id_C7DDD9229F6512A3, loopanim) {
  level endon("game_ended");
  player endon("death");
  player endon("disconnect");
  player endon("leave_cam");
  player endon("completed_snakecam_exit");
  body endon("death");
  player._id_EA741C5B7B9EDA80 unlink();
  player._id_EA741C5B7B9EDA80 linkTo(body, "tag_accessory_left", (0, 0, 0), (0, 0, 0));

  for(;;) {
    body scriptmodelclearanim();
    body scriptmodelplayanim(loopanim);
    player._id_24C22D4AEAB7EF2F scriptmodelclearanim();
    player._id_24C22D4AEAB7EF2F scriptmodelplayanim(loopanim);
    wait(getanimlength(loopanim));
  }
}

_id_DDC7967C675A6D0F(player, body, _id_C7DDD9229F6512A3, _id_457A0F528BFF306C) {
  level endon("game_ended");
  player endon("death");
  player endon("disconnect");
  anim_array = [];

  if(isDefined(player)) {
    actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, "snakecam", 1);
    actorplayer scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "snakecam", 1);
    anim_array[anim_array.size] = actorplayer;
  }

  player._id_EA741C5B7B9EDA80 unlink();
  player._id_EA741C5B7B9EDA80 linkTo(player, "tag_accessory_left", (0, 0, 0), (0, 0, 0));
  body.head delete();
  body delete();
  player scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();
  player setsolid(1);

  if(anim_array.size > 0) {
    player._id_24C22D4AEAB7EF2F scriptmodelclearanim();
    player._id_24C22D4AEAB7EF2F scriptmodelplayanim("iw9_mp_equip_snakecam_out_stand");
    result = _id_C7DDD9229F6512A3 scripts\cp_mp\anim_scene::anim_scene(anim_array, _id_457A0F528BFF306C);
  }

  player.anim_scene_stance_override = undefined;

  if(isDefined(player._id_24C22D4AEAB7EF2F))
    player._id_24C22D4AEAB7EF2F delete();

  if(isDefined(player._id_EA741C5B7B9EDA80))
    player._id_EA741C5B7B9EDA80 delete();

  _id_C7DDD9229F6512A3 notify("exit_anim_done");
}

_id_78DB7BBCC9B65FB3(player, _id_C7DDD9229F6512A3, _id_38F563E00311EE1B, _id_93EE2CC09F74798E) {
  level endon("game_ended");
  player endon("death");
  player endon("disconnect");

  if(isDefined(_id_93EE2CC09F74798E))
    level endon(_id_93EE2CC09F74798E);

  anim_array = [];

  if(isDefined(player)) {
    actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, "snakecam", 1);
    actorplayer scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "snakecam", 1);
    anim_array[anim_array.size] = actorplayer;
  }

  if(anim_array.size > 0)
    result = _id_C7DDD9229F6512A3 scripts\cp_mp\anim_scene::anim_scene(anim_array, "snakecam_in");
}

_id_92DF319CCFCAC315(streakinfo) {
  self waittill("completed_snakecam_exit");
}

_id_D78527C235E0C208() {
  level endon("game_ended");
  self endon("death");
  gunless = makeweapon("iw9_gunless_quickdrop_mp");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(gunless, undefined, undefined, 1);
  scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless, 0);
  self.gunnlessweapon = gunless;
  self notify("swapped_to_gunless");
}

takegunless() {
  level endon("game_ended");
  self endon("death");

  if(isDefined(self.gunnlessweapon)) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gunnlessweapon);
    scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
    self.gunnlessweapon = undefined;
  }
}

_id_DB2FC31C8B3C4EC1() {
  self._id_D05D227B98586982 = self.primaryweapons;
  _id_66122A002AFF5D57::takeweaponsdefaultfunc();
}

restoreweaponsdefaultfunc() {
  self clearaccessory();

  if(isDefined(self.primaryweaponobj)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(self.primaryweaponobj, undefined, undefined, 0);

    if(isDefined(self.primaryweaponclipammo)) {
      self setweaponammoclip(self.primaryweaponobj, self.primaryweaponclipammo);
      _id_66122A002AFF5D57::_id_4906C10C3FFDD4CA(self.primaryweaponobj, self.primaryweaponstockammo);
    }
  }

  if(isDefined(self.secondaryweaponobj)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(self.secondaryweaponobj, undefined, undefined, 1);

    if(isDefined(self.secondaryweaponclipammo))
      _id_66122A002AFF5D57::_id_4906C10C3FFDD4CA(self.secondaryweaponobj, self.secondaryweaponstockammo);
  }

  self.weaponlist = self._id_D05D227B98586982;

  if(isDefined(self.weaponlist[0]))
    scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.weaponlist[0]);

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[0]))
    self.primaryweaponobj = self.weaponlist[0];

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[1]))
    self.secondaryweaponobj = self.weaponlist[1];

  if(isDefined(self.gunnlessweapon))
    scripts\cp_mp\utility\inventory_utility::_id_9897D143C3FEEE05();
}

snakecam_delay_visionsetchange() {
  wait 0.05;
  level notify("vision_set_change_request", undefined, self, 0.05, "cp_lab_zero");
  wait 1.45;
  level notify("vision_set_change_request", undefined, self, 0.05, "cp_lab_zero");
}

_id_5F077055EEE53D8C() {
  precacheshader("nightvision_overlay_goggles_grain");
  precacherumble("cp_wheelson_rumble");
  _id_25EEC91EDEF511DD = scripts\engine\utility::getStructArray("snakecam_interaction", "script_noteworthy");

  foreach(_id_DF071553D0996FF9 in _id_25EEC91EDEF511DD) {
    _id_DF071553D0996FF9.p_ent_skip_fov = 1;
    _id_AA8AC5C98F3A9029 = scripts\engine\utility::getStruct(_id_DF071553D0996FF9.target, "targetname");
    _id_AA8AC5C98F3A9029.script_noteworthy = _id_DF071553D0996FF9.script_noteworthy;
    _id_DF071553D0996FF9.scriptable = spawnscriptable("snakecam_interaction", _id_DF071553D0996FF9.origin, _id_DF071553D0996FF9.angles);
    _id_DF071553D0996FF9.scriptable._id_DF071553D0996FF9 = _id_DF071553D0996FF9;
    _id_DF071553D0996FF9.scriptable._id_AA8AC5C98F3A9029 = _id_AA8AC5C98F3A9029;
    _id_DF071553D0996FF9.scriptable._id_AA8AC5C98F3A9029 thread _id_94D8D166D09B75A5();
    _id_AA8AC5C98F3A9029 thread _id_62D9AEE42FFDFCEC();
  }
}

snakecam_init_func(_id_25EEC91EDEF511DD) {
  level endon("game_ended");
  precacheshader("nightvision_overlay_goggles_grain");
  precacherumble("cp_wheelson_rumble");

  foreach(_id_DF071553D0996FF9 in _id_25EEC91EDEF511DD) {
    _id_DF071553D0996FF9.p_ent_skip_fov = 1;
    _id_AA8AC5C98F3A9029 = scripts\engine\utility::getStruct(_id_DF071553D0996FF9.target, "targetname");
    _id_AA8AC5C98F3A9029.script_noteworthy = _id_DF071553D0996FF9.script_noteworthy;
    _id_DF071553D0996FF9.scriptable = spawnscriptable("snakecam_interaction", _id_DF071553D0996FF9.origin, _id_DF071553D0996FF9.angles);
    _id_DF071553D0996FF9.scriptable._id_DF071553D0996FF9 = _id_DF071553D0996FF9;
    _id_DF071553D0996FF9.scriptable._id_AA8AC5C98F3A9029 = _id_AA8AC5C98F3A9029;
    _id_DF071553D0996FF9.scriptable._id_AA8AC5C98F3A9029 thread _id_94D8D166D09B75A5();
    _id_AA8AC5C98F3A9029 thread _id_62D9AEE42FFDFCEC();
  }
}

_id_62D9AEE42FFDFCEC() {
  if(!scripts\engine\utility::flag_exist("create_script_initialized"))
    scripts\engine\utility::flag_init("create_script_initialized");

  scripts\engine\utility::flag_wait("create_script_initialized");
  wait 10;

  if(getdvarint("dvar_0ACD3891A0644E00", 0) != 0) {
    return;
  }
  foreach(player in level.players)
  player thread _id_2EAF387169EA8236(self);
}

_id_2EAF387169EA8236(ent) {
  self endon("disconnect");
  self endon("end_hints");
  self notify("show_snakecam_hint");
  self endon("show_snakecam_hint");
  player = self;

  if(!isDefined(level._id_9C4C07601EA6B6CD))
    level._id_9C4C07601EA6B6CD = 1;

  ent.counter = "snakecam_" + level._id_9C4C07601EA6B6CD;
  self notify("show_snakecam_hint" + ent.counter);
  self endon("show_snakecam_hint" + ent.counter);

  if(!isDefined(level.showhint))
    level.showhint = [];

  level.showhint[ent.counter] = 0;
  level._id_9C4C07601EA6B6CD++;
  player._id_0F7BB0A7E41CB6E5 = 0;

  for(;;) {
    if(_func_EAC0CD99C9C6D8EE() == "spotted") {
      wait 2;
      continue;
    }

    _id_F25430617AB002F8 = distance2dsquared(player.origin, ent.origin);

    if(isDefined(_id_F25430617AB002F8) && _id_F25430617AB002F8 <= 262144) {
      if(istrue(player.isusingcamera)) {
        wait 3;
        continue;
      }

      if(istrue(player._id_4935C7889506B68C)) {
        wait 3;
        continue;
      }

      if(player._id_0F7BB0A7E41CB6E5 >= 2) {
        return;
      }
      if(!istrue(level.showhint[ent.counter])) {
        level.showhint[ent.counter] = 1;
        num = randomintrange(1, 8);
        player._id_4935C7889506B68C = 1;
        player._id_0F7BB0A7E41CB6E5++;
        self sethudtutorialmessage(&"SNAKECAM/USE_SNAKECAM_HINT_1", 1);
        ent thread _id_D522DBAEBCB26E26(16 * player._id_0F7BB0A7E41CB6E5, self);
      }
    } else if(istrue(level.showhint[ent.counter]))
      level.showhint[ent.counter] = 0;

    wait 3;
  }
}

_id_D522DBAEBCB26E26(delay, player) {
  wait(delay / 3);
  player clearhudtutorialmessage();
  wait(delay / 6);
  player._id_4935C7889506B68C = undefined;
  level.showhint[self.counter] = undefined;
}

p_ent_snake_cam(ent, struct, _id_851006497C31432D, player) {}

_id_7F4E0FFC4558B72F(_id_74B5B12BB6514385) {
  self endon("death_or_disconnect");
  self freezecontrols(1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_74B5B12BB6514385);
  self freezecontrols(0);
}

put_player_on_cam(tag, player, _id_DF071553D0996FF9) {
  _id_1B9B8DAF429DD199 = tag.origin + anglesToForward(tag.angles) * 12 - (0, 0, 55);
  player.cam_ent = tag;
  player.isusingcamera = 1;
  player.currentcamera = _id_DF071553D0996FF9.target_obj;
  player.cameratarget = _id_DF071553D0996FF9.target_obj.targetname;
  player notify("end_hints");
  player _id_3B64EB40368C1450::set("cam", "fire", 0);
  player cameraunlink();
  player cameralinkTo(player.cam_ent, "tag_player", 1);
  player playerlinkweaponviewtodelta(player.cam_ent, "tag_player", 1, 75, 75, 24, 0);
  player setviewangleresistance(90, 90, 130, 10);
  player playerlinkedsetviewznear(0);
  player setplayerangles(tag.angles);
  player _id_3B64EB40368C1450::set("cam", "weapon", 0);
  player _id_3B64EB40368C1450::set("cam", "stand", 0);
  player _id_3B64EB40368C1450::set("cam", "crouch", 0);
  player _id_3B64EB40368C1450::set("cam", "usability", 0);
  player setclientomnvar("ui_snakecam", 1);
}

remove_player_from_cam(player) {
  player unlink();
  player cameraunlink();
  player controlsunlink();
  player setstance(player.og_stance);
  player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("cam");
  player.isusingcamera = 0;
  player.cameraused = undefined;
  player.cameratarget = undefined;
  player._id_C1617124D4EE7E97 = undefined;
  player setclientomnvar("ui_snakecam", 0);
}

snake_door_cam_hud(player, _id_0728DCF36EEB7616) {
  crosshair = newclienthudelem(player);
  crosshair.archived = 0;
  crosshair.location = 0;
  crosshair.alignx = "center";
  crosshair.aligny = "middle";
  crosshair.foreground = 1;
  crosshair.fontscale = 1;
  crosshair.sort = 20;
  crosshair.alpha = 0.7;
  crosshair.y = 233;
  crosshair settext(&"SNAKECAM/CROSSHAIR");
  overlay = newclienthudelem(player);
  overlay.x = 292;
  overlay.y = 60;
  overlay.alignx = "center";
  overlay.aligny = "middle";
  overlay.font = "hudsmall";
  overlay.fontscale = 0.75;
  overlay settext(&"SNAKECAM/CONTROLS");
  _id_083A337B15031DAB = scripts\cp\utility::create_client_overlay("nightvision_overlay_goggles_grain", 1, player);

  if(!isDefined(_id_0728DCF36EEB7616))
    level notify("vision_set_change_request", "embassy_cctv_01", player, 0.05);
  else
    level notify("vision_set_change_request", _id_0728DCF36EEB7616, player, 0.05);

  return [crosshair, _id_083A337B15031DAB, overlay];
}

snake_cam_control(_id_693EC2852A7DE810, _id_F55FE461499F0E19) {
  self endon("leave_cam");
  og_angles = _id_693EC2852A7DE810.angles;
  _id_DDB680F3984C4777 = -24;
  _id_A5337F8300110201 = 0;
  _id_CB6680317BE1E374 = 55;
  _id_183D5EEC52A67366 = og_angles[1] - _id_CB6680317BE1E374;
  _id_3C5DF5BF59ED9678 = og_angles[1] + _id_CB6680317BE1E374;
  _id_F7DC3A5FD9572B94 = og_angles[2] - 15;
  _id_2EC0815DFA0F672E = og_angles[2] + 15;
  _id_827ABACD5CA8F6B3 = 20;
  _id_594240552B896878 = 10;
  _id_440EBEEB83BD05A8 = 0.6;
  _id_75EB1524AFEB7F2B = 0.8;
  _id_C9FF6EEAAF645CEE = 10;
  _id_2FCA29730A69EE8A = 4;
  _id_E47AE22EC47FCEDB = 1.2;
  _id_D296B0EAF4A6B00F = [0, 0];
  _id_D5E6310914396AC3 = 0.2;
  _id_848E35F763CE65B0 = 0.2;
  _id_91AB80BC6772504D = 0;
  _id_9DBC893FB4BE54F2 = self.angles;

  while(istrue(self.isusingcamera)) {
    _id_B4F55166F66361E9 = _id_693EC2852A7DE810.angles + (0, -90, 0);
    input = self getplayerangles();
    _id_98EA5AFB293A76A2 = 0;
    _id_0FED6E82D22BB75E = length(_id_9DBC893FB4BE54F2 - input);
    _id_9DBC893FB4BE54F2 = input;
    _id_4D8CD161A8EAADC2 = scripts\engine\math::factor_value(0.0, 0.165, _id_0FED6E82D22BB75E);
    rumble = scripts\engine\math::factor_value(0.0, 0.08, _id_0FED6E82D22BB75E);

    if(_id_4D8CD161A8EAADC2 > 0.165)
      _id_4D8CD161A8EAADC2 = 0.165;

    if(_id_4D8CD161A8EAADC2 > 0.005)
      self earthquakeforplayer(_id_4D8CD161A8EAADC2, 0.07, self.origin, 2000);

    if(rumble > 0.0001)
      thread play_cam_rumble_once();

    height = 1 - rumble;
    height = height * 1000;
    wait 0.05;
  }
}

play_cam_rumble_once() {
  if(!istrue(self.playing_rumble)) {
    self.playing_rumble = 1;
    self playrumblelooponentity("cp_wheelson_rumble");
    self playlocalsound("cp_ui_snakecam_move_plr");
    wait 0.1;
    self stoprumble("cp_wheelson_rumble");
    wait 0.1;
    self.playing_rumble = undefined;
  }
}

waittill_player_exits_cam(player) {
  player endon("disconnect");
  wait 2;

  for(;;) {
    if(player_is_trying_to_exit_camera(player)) {
      break;
    } else if(!istrue(player.enteredcamera)) {
      break;
    } else if(istrue(self._id_E05E65264655B8C0)) {
      break;
    } else if(istrue(self.disabled)) {
      break;
    } else if(_id_0AFB7E332AEE4BF2::player_in_laststand(player)) {
      break;
    } else if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
      break;
    } else if(istrue(player._id_C1617124D4EE7E97)) {
      break;
    } else
      waitframe();
  }

  self notify("player_left_cam");
}

player_is_trying_to_exit_camera(player) {
  return player buttonPressed("C") || player buttonPressed("LCTRL") || player fragButtonPressed() || player stancebuttonPressed() || player meleeButtonPressed() || player buttonPressed("BUTTON_B") || player jumpbuttonPressed() || player buttonPressed("BUTTON_LSTICK") || player buttonPressed("BUTTON_RSTICK");
}

get_snakecam_interactions_by_target(_id_CFF90AD7FC089C91) {
  if(isDefined(_id_CFF90AD7FC089C91)) {
    _id_46A0BF001612E712 = scripts\engine\utility::getStructArray(_id_CFF90AD7FC089C91, "target");
    return _id_46A0BF001612E712;
  }

  return undefined;
}

disable_snakecams_by_target(_id_CFF90AD7FC089C91) {
  interactions = get_snakecam_interactions_by_target(_id_CFF90AD7FC089C91);

  foreach(interaction in interactions) {
    if(istrue(interaction.disabled)) {
      continue;
    }
    interaction.disabled = 1;

    if(isDefined(interaction.fxtoplay))
      interaction.fxtoplay delete();
  }
}

enable_snakecams_by_target(_id_CFF90AD7FC089C91) {
  interactions = get_snakecam_interactions_by_target(_id_CFF90AD7FC089C91);

  foreach(interaction in interactions)
  interaction.disabled = 0;
}

refresh_nearby_playerhints(_id_2BE051A42DD398EB) {
  if(!isDefined(_id_2BE051A42DD398EB))
    _id_2BE051A42DD398EB = 150;

  _id_2BE051A42DD398EB = _id_2BE051A42DD398EB * _id_2BE051A42DD398EB;

  foreach(player in level.players) {
    if(distance2dsquared(player.origin, self.origin) <= _id_2BE051A42DD398EB) {
      if(isDefined(player.isusingcamera))
        player.last_interaction_point = undefined;
    }

    wait 0.05;
  }
}

is_player_using_snakecam(player) {
  if(istrue(player.isusingcamera))
    return 1;

  return 0;
}

toggle_dynamically_from_doors(_id_707E36DD51FF2144) {
  wait 2;

  foreach(door in _id_707E36DD51FF2144) {
    door thread snakecam_toggle_waittill();
    wait 0.05;
  }
}

snakecam_toggle_waittill() {
  if(!isDefined(self)) {
    return;
  }
  _id_E53595ED1321C340 = scripts\engine\utility::getStructArray("snakecam_interaction", "script_noteworthy");
  maxdist = 200;
  _id_CDC5DD6C28C9709D = maxdist * maxdist;
  _id_6DB508A257162414 = 2;
  self.nearbysnakecams = [];

  foreach(snakecam in _id_E53595ED1321C340) {
    if(distance2dsquared(snakecam.origin, self.origin) <= _id_CDC5DD6C28C9709D)
      self.nearbysnakecams[self.nearbysnakecams.size] = snakecam;
  }

  if(self.nearbysnakecams.size == 0) {
    return;
  }
  wait 2;

  for(;;) {
    self waittill("door_toggled");

    foreach(snakecam in self.nearbysnakecams) {
      if(istrue(snakecam.disabled)) {
        snakecam thread snakecam_toggle_enable_on_delay(_id_6DB508A257162414, 1);
        continue;
      }

      snakecam thread snakecam_toggle_enable_on_delay(_id_6DB508A257162414, 0);
    }

    wait 0.05;
  }
}

snakecam_toggle_enable_on_delay(_id_BC73FD9D4818BDE6, _id_41D8BF229CF29051) {
  if(istrue(self.disable_delay)) {
    return;
  }
  self.disable_delay = 1;

  if(istrue(_id_41D8BF229CF29051))
    self.disabled = 0;
  else
    self.disabled = 1;

  wait(_id_BC73FD9D4818BDE6);
  self.disable_delay = 0;
}

enable_snake_cams() {
  wait 5;
  _id_49C15445FDCB75EE = scripts\engine\utility::getStructArray("snakecam_interaction", "script_noteworthy");

  foreach(_id_AA8AC5C98F3A9029 in _id_49C15445FDCB75EE)
  _id_AA8AC5C98F3A9029 thread _id_94D8D166D09B75A5();
}

_id_627B6C50A3E708A5() {
  _id_EAA7250AA6C397A2 = ["scriptable_door_metal_04_flat_painted_mp_tan", "scriptable_door_metal_panel_03_right_mp", "door_wooden_hollow_mp_01_rnd", "scriptable_door_wooden_panel_03_painted_mp", "scriptable_door_metal_panel_03_left_mp", "scriptable_door_wooden_panel_mp_01_white", "scriptable_construction_doors_metal_b_02_mp", "scriptable_door_wooden_office_01_mp", "scriptable_door_metal_single_b_02_grey", "scriptable_door_wooden_hollow_mp_01", "scriptable_door_wooden_panel_mp_01", "scriptable_door_wooden_panel_03_painted_mp_tint", "scriptable_door_wood_ornate_01_green_double_r", "scriptable_door_wood_ornate_01_green_double_l"];
  _id_8C73C4ADD30BB4B2 = [];
  _id_8C73C4ADD30BB4B2 = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(self.origin, 100);
  return _id_8C73C4ADD30BB4B2;
}

_id_D25799279EC14C4C(_id_AA8AC5C98F3A9029) {
  _id_8C73C4ADD30BB4B2 = _id_AA8AC5C98F3A9029 _id_627B6C50A3E708A5();

  foreach(_id_26BAEFB3804B52C3 in _id_8C73C4ADD30BB4B2) {
    if(_id_26BAEFB3804B52C3 scriptableisdoor())
      _id_26BAEFB3804B52C3 scriptabledoorfreeze(1);
  }

  wait 2.5;

  foreach(_id_26BAEFB3804B52C3 in _id_8C73C4ADD30BB4B2) {
    if(_id_26BAEFB3804B52C3 scriptableisdoor())
      _id_26BAEFB3804B52C3 scriptabledoorfreeze(0);
  }
}

_id_94D8D166D09B75A5() {
  _id_8C73C4ADD30BB4B2 = _id_627B6C50A3E708A5();
  self._id_8C73C4ADD30BB4B2 = _id_8C73C4ADD30BB4B2;
  thread _id_B7BA2558645C3BBA();
}

_id_B7BA2558645C3BBA() {
  self notify("single_disable_nearby_snake_cam_after_open");
  self endon("single_disable_nearby_snake_cam_after_open");
  _id_6905E1CF687A2FD9 = 0;
  _id_2C2CE74038F7C6CC = undefined;

  while(!istrue(_id_6905E1CF687A2FD9)) {
    _id_6905E1CF687A2FD9 = 0;

    foreach(door in self._id_8C73C4ADD30BB4B2) {
      if(!door scriptabledoorisclosed()) {
        _id_6905E1CF687A2FD9 = 1;
        _id_2C2CE74038F7C6CC = door;
        continue;
      }
    }

    waitframe();
  }

  if(!isDefined(_id_2C2CE74038F7C6CC))
    _id_2C2CE74038F7C6CC = self._id_8C73C4ADD30BB4B2[0];

  nearbyplayer = scripts\cp\utility::give_closest_player_nearby(_id_2C2CE74038F7C6CC.origin, 14400);

  if(isDefined(nearbyplayer))
    level notify("door_event", _id_2C2CE74038F7C6CC.origin, nearbyplayer);
  else
    level notify("door_event", _id_2C2CE74038F7C6CC.origin);

  _id_BE00C97A9AE50349 = scripts\engine\utility::get_array_of_closest(_id_2C2CE74038F7C6CC.origin, scripts\engine\utility::getStructArray("snakecam_interaction", "script_noteworthy"), [], 8, 256);

  if(isDefined(_id_BE00C97A9AE50349)) {
    foreach(_id_1D4D2FD74B4D40E0 in _id_BE00C97A9AE50349)
    _id_1D4D2FD74B4D40E0._id_E05E65264655B8C0 = 1;
  }

  _id_CB5D60A767DB7015 = getentitylessscriptablearray("snakecam_interaction", undefined, self.origin, 128);

  foreach(snakecam in _id_CB5D60A767DB7015) {
    snakecam._id_DF071553D0996FF9._id_E05E65264655B8C0 = 1;
    _id_9F2B37DDE1EDA465(snakecam);
  }

  thread _id_896FBDDF3C463B8B(self._id_8C73C4ADD30BB4B2);
}

_id_896FBDDF3C463B8B(_id_B8D92AE3E433B054) {
  self notify("single_watch_for_door_closed");
  self endon("single_watch_for_door_closed");
  _id_7E7B1EF3E4957761 = 0;

  while(!istrue(_id_7E7B1EF3E4957761)) {
    _id_7E7B1EF3E4957761 = 1;

    foreach(door in _id_B8D92AE3E433B054) {
      if(!door scriptabledoorisclosed()) {
        _id_7E7B1EF3E4957761 = 0;
        continue;
      }
    }

    wait 0.5;
  }

  nearbyplayer = scripts\cp\utility::give_closest_player_nearby(self.origin, 17689);

  if(isDefined(nearbyplayer))
    level notify("door_event", self.origin, nearbyplayer);
  else
    level notify("door_event", self.origin);

  _id_BE00C97A9AE50349 = scripts\engine\utility::get_array_of_closest(self.origin, scripts\engine\utility::getStructArray("snakecam_interaction", "script_noteworthy"), [], 8, 256);

  if(isDefined(_id_BE00C97A9AE50349)) {
    foreach(_id_1D4D2FD74B4D40E0 in _id_BE00C97A9AE50349)
    _id_1D4D2FD74B4D40E0._id_E05E65264655B8C0 = undefined;
  }

  _id_CB5D60A767DB7015 = getentitylessscriptablearray("snakecam_interaction", undefined, self.origin, 128);

  foreach(snakecam in _id_CB5D60A767DB7015) {
    snakecam._id_DF071553D0996FF9._id_E05E65264655B8C0 = undefined;
    _id_8CBC97CE93BB87F8(snakecam);
  }

  thread _id_B7BA2558645C3BBA();
}

_id_4697C6C047891C62(_id_B3BA2D13FC1D315C) {
  self endon("death");
  _id_FBC7CCE627CB4D4F = 2000;
  _id_B8CF204DD62D457F = gettime() + _id_FBC7CCE627CB4D4F;

  while(_id_B8CF204DD62D457F > gettime()) {
    if(!scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(!self useButtonPressed())
      return 0;

    wait 0.05;
  }

  return 1;
}

_ontabletgiven(streakinfo, _id_41BF9BF4918115AC) {
  _toggletabletallows(1);
  thread _id_1DB8D0E02A99C5E2::_cleanuptabletallows();
  thread _id_1DB8D0E02A99C5E2::_cancelputawayonuseend(streakinfo);
  return 1;
}

_ontabletputaway(streakinfo) {}

_waituntilinteractfinished(streakinfo) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  interactstate = streakinfo.interactstate;

  if(interactstate.state != 0) {
    return;
  }
  self waittill("interact_finished");

  if(interactstate.state == 2) {
    _id_3504D7A7F76AD9D5 = 2;
    wait(_id_3504D7A7F76AD9D5);
  }

  self setclientomnvar("ui_tablet_usb", 0);
}

_toggletabletallows(_id_DA3010AF8F6BE463) {
  if(isalive(self)) {
    if(_id_DA3010AF8F6BE463) {
      _id_3B64EB40368C1450::set("tablet", "allow_movement", 0);
      _id_3B64EB40368C1450::set("tablet", "allow_jump", 0);
      _id_3B64EB40368C1450::set("tablet", "usability", 0);
      _id_3B64EB40368C1450::set("tablet", "melee", 0);
      _id_3B64EB40368C1450::set("tablet", "offhand_weapons", 0);
      _id_3B64EB40368C1450::set("tablet", "killstreaks", 0);
    } else
      _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("tablet");
  }
}

_id_9F2B37DDE1EDA465(snakecam) {
  foreach(player in level.players)
  snakecam disablescriptableplayeruse(player);
}

_id_8CBC97CE93BB87F8(snakecam) {
  foreach(player in level.players)
  snakecam enablescriptableplayeruse(player);
}

_id_45DA058B481F8049(streakinfo, _id_BDFFC63C4171C131, _id_8FD4D93DD619DA88, _id_91F739C2C51347D4, _id_0D55D8445518099B, _id_F6A32DCC4B19AAD9, _id_67A06B4EA269058E, waittime) {
  level endon("game_ended");
  self endon("disconnect");
  _id_5C3F9357F11D2223 = "ks_remote_device_mp";

  if(isDefined(_id_F6A32DCC4B19AAD9))
    _id_5C3F9357F11D2223 = _id_F6A32DCC4B19AAD9;

  weaponobj = makeweapon(_id_5C3F9357F11D2223);
  _id_5F6056D7176B7103 = % vm_ks_tablet_tap_raise;
  _id_2ED8C4E06182FD14 = getanimlength(_id_5F6056D7176B7103) - 1.5;

  if(isDefined(waittime))
    _id_2ED8C4E06182FD14 = waittime;

  scripts\cp_mp\killstreaks\killstreakdeploy::ondeploystart(streakinfo);
  _id_3B64EB40368C1450::set("snakecam", "allow_movement", 0);
  _id_3B64EB40368C1450::set("snakecam", "allow_jump", 0);
  _id_3B64EB40368C1450::set("snakecam", "usability", 0);
  _id_3B64EB40368C1450::set("snakecam", "melee", 0);
  _id_3B64EB40368C1450::set("snakecam", "offhand_weapons", 0);
  _id_3B64EB40368C1450::set("snakecam", "killstreaks", 0);
  _id_41BF9BF4918115AC = scripts\cp_mp\killstreaks\killstreakdeploy::switchtodeployweapon(weaponobj, streakinfo, scripts\cp_mp\killstreaks\killstreakdeploy::waituntilfinishedwithdeployweapon, _id_BDFFC63C4171C131, _id_8FD4D93DD619DA88, _id_91F739C2C51347D4, _id_0D55D8445518099B);

  if(isDefined(self) && scripts\cp_mp\utility\player_utility::_isalive())
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("snakecam");

  if(!istrue(_id_41BF9BF4918115AC)) {
    scripts\cp_mp\killstreaks\killstreakdeploy::ondeployfinished(streakinfo);

    if(isDefined(self))
      _id_18288294B05CFD9F(0, 1);

    return 0;
  }

  _id_0EABF81B5BE8DDB5 = _id_2FE0097FB626C353(streakinfo, _id_2ED8C4E06182FD14, _id_67A06B4EA269058E);
  scripts\cp_mp\killstreaks\killstreakdeploy::ondeployfinished(streakinfo);
  return istrue(_id_0EABF81B5BE8DDB5);
}

_id_97BB37170A0AC241(streakname, _id_EFC34E190209C88D) {
  self playlocalsound("iw9_snakecam_tablet");
  self setclientomnvar("ui_snakecam", 1);

  if(isDefined(_id_EFC34E190209C88D))
    thread scripts\cp_mp\utility\killstreak_utility::tabletdofset(_id_EFC34E190209C88D);
}

_id_18288294B05CFD9F(_id_00375181444841AD, _id_137355B56D092B3B) {
  self setclientomnvar("ui_snakecam", 0);
  thread scripts\cp_mp\utility\killstreak_utility::tabletdofset(_id_00375181444841AD, 1);
}

_id_2FE0097FB626C353(streakinfo, animlength, _id_67A06B4EA269058E) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(_id_67A06B4EA269058E))
    _id_67A06B4EA269058E = 1;

  scripts\cp\utility::_freezecontrols(1, undefined, "killstreakDeploy");
  thread scripts\cp_mp\killstreaks\killstreakdeploy::watchweapontabletstop(streakinfo);
  thread scripts\cp_mp\killstreaks\killstreakdeploy::watchweapontabletcallinpos();
  _id_97BB37170A0AC241(streakinfo.streakname, 0.75);
  result = scripts\engine\utility::waittill_any_timeout_3(animlength, "death", "weapon_change", "cancel_all_killstreak_deployments");
  _id_18288294B05CFD9F(0.325);
  self notify("ks_freeze_end");
  scripts\cp\utility::_freezecontrols(0, undefined, "killstreakDeploy");

  if(!isDefined(result) || result != "timeout" || !self isonground() || self isonladder()) {
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    self stoplocalsound("mp_killstreak_tablet_gear");
    self notify("cancel_remote_sequence");
    return 0;
  }

  self notify("deploy_weapon_anim_successful");
  return 1;
}

_id_D81A74D075FE9A18(_id_3702CBA57F844507) {
  self endon("disconnect");
  result = scripts\engine\utility::waittill_any_timeout_1(_id_3702CBA57F844507, "cancel_remote_sequence");

  if(!isDefined(result) || result == "cancel_remote_sequence") {
    return;
  }
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0.3);
    result = scripts\engine\utility::waittill_any_timeout_1(0.7, "death");
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0.3);
  }
}

script_model_anims() {
  level.scr_animtree["snakecam"] = #animtree;
  level.scr_animtree["snakecam_prop"] = #animtree;
  level.scr_anim["snakecam_prop"]["stand_enter"] = % iw9_mp_equip_snakecam_in_stand;
  level.scr_animname["snakecam_prop"]["stand_enter"] = "iw9_mp_equip_snakecam_in_stand";
  level.scr_anim["snakecam_prop"]["stand_exit"] = % iw9_mp_equip_snakecam_out_stand;
  level.scr_animname["snakecam_prop"]["stand_exit"] = "iw9_mp_equip_snakecam_out_stand";
  level.scr_anim["snakecam_prop"]["crouch_enter"] = % iw9_mp_equip_snakecam_in_crouch;
  level.scr_animname["snakecam_prop"]["crouch_enter"] = "iw9_mp_equip_snakecam_in_crouch";
  level.scr_anim["snakecam_prop"]["crouch_exit"] = % iw9_mp_equip_snakecam_out_crouch;
  level.scr_animname["snakecam_prop"]["crouch_exit"] = "iw9_mp_equip_snakecam_out_crouch";
  level.scr_anim["snakecam_prop"]["prone_enter"] = % iw9_mp_equip_snakecam_in_prone;
  level.scr_animname["snakecam_prop"]["prone_enter"] = "iw9_mp_equip_snakecam_in_prone";
  level.scr_anim["snakecam_prop"]["prone_exit"] = % iw9_mp_equip_snakecam_out_prone;
  level.scr_animname["snakecam_prop"]["prone_exit"] = "iw9_mp_equip_snakecam_out_prone";
  level.scr_anim["snakecam_prop"]["crouch_idle"] = % iw9_mp_equip_snakecam_loop;
  level.scr_animname["snakecam_prop"]["crouch_idle"] = "iw9_mp_equip_snakecam_loop";
  level.scr_anim["snakecam_prop"]["prone_idle"] = % iw9_mp_equip_snakecam_loop_prone;
  level.scr_animname["snakecam_prop"]["prone_idle"] = "iw9_mp_equip_snakecam_loop_prone";
  level.scr_anim["snakecam"]["stand_enter"] = % iw9_mp_equip_snakecam_in_stand;
  level.scr_animname["snakecam"]["stand_enter"] = "iw9_mp_equip_snakecam_in_stand";
  level.scr_eventanim["snakecam"]["stand_enter"] = "snakecam_stand_enter";
  level.scr_anim["snakecam"]["stand_exit"] = % iw9_mp_equip_snakecam_out_stand;
  level.scr_animname["snakecam"]["stand_exit"] = "iw9_mp_equip_snakecam_out_stand";
  level.scr_eventanim["snakecam"]["stand_exit"] = "snakecam_stand_exit";
  level.scr_anim["snakecam"]["crouch_enter"] = % iw9_mp_equip_snakecam_in_crouch;
  level.scr_animname["snakecam"]["crouch_enter"] = "iw9_mp_equip_snakecam_in_crouch";
  level.scr_eventanim["snakecam"]["crouch_enter"] = "snakecam_crouch_enter";
  level.scr_anim["snakecam"]["crouch_exit"] = % iw9_mp_equip_snakecam_out_crouch;
  level.scr_animname["snakecam"]["crouch_exit"] = "iw9_mp_equip_snakecam_out_crouch";
  level.scr_eventanim["snakecam"]["crouch_exit"] = "snakecam_crouch_exit";
  level.scr_anim["snakecam"]["prone_enter"] = % iw9_mp_equip_snakecam_in_prone;
  level.scr_animname["snakecam"]["prone_enter"] = "iw9_mp_equip_snakecam_in_prone";
  level.scr_eventanim["snakecam"]["prone_enter"] = "snakecam_prone_enter";
  level.scr_anim["snakecam"]["prone_exit"] = % iw9_mp_equip_snakecam_out_prone;
  level.scr_animname["snakecam"]["prone_exit"] = "iw9_mp_equip_snakecam_out_prone";
  level.scr_eventanim["snakecam"]["prone_exit"] = "snakecam_prone_exit";
  level.scr_anim["snakecam"]["crouch_idle"] = % iw9_mp_equip_snakecam_loop;
  level.scr_animname["snakecam"]["crouch_idle"] = "iw9_mp_equip_snakecam_loop";
  level.scr_eventanim["snakecam"]["crouch_idle"] = "snakecam_crouch_idle";
  level.scr_anim["snakecam"]["prone_idle"] = % iw9_mp_equip_snakecam_loop_prone;
  level.scr_animname["snakecam"]["prone_idle"] = "iw9_mp_equip_snakecam_loop_prone";
  level.scr_eventanim["snakecam"]["prone_idle"] = "snakecam_prone_idle";
}

_id_37B3487E37675CDA(player) {
  player endon("death_or_disconnect");
  player endon("interact_interrupt");
  player scripts\cp\cp_anim::anim_player_solo(player, player.player_rig, "snakecam_start");
}

_id_0D6B74BDC3C9E74F(player, instance) {
  player endon("death_or_disconnect");
  player endon("interact_begin_exit");
  player endon("interact_cancelled");

  while(scripts\cp\utility\player::isreallyalive(player))
    player scripts\cp\cp_anim::anim_player_solo(player, player.player_rig, "snakecam_idle");
}

_id_35EAF8086190479A(player) {
  player endon("death_or_disconnect");
  player endon("interact_interrupt");

  if(scripts\cp\utility\player::isreallyalive(player))
    player scripts\cp\cp_anim::anim_player_solo(player, player.player_rig, "snakecam_exit");
}

_id_796D1DA742E2A88A(player) {
  player endon("interact_cancelled");
  player endon("interact_finished");
  player scripts\engine\utility::waittill_any_2("death_or_disconnect", "last_stand_start");
  player notify("interact_interrupt");
  player stopanimscriptsceneevent();

  if(isDefined(player.linktoent)) {
    player unlink();
    player.linktoent delete();
    player.linktoent = undefined;
  }

  player notify("remove_rig");
  player _id_F7CDC23E1C9C520F(1);
}

_id_F7CDC23E1C9C520F(_id_BD138DE99B3B3507) {
  if(!_id_BD138DE99B3B3507) {
    _id_3B64EB40368C1450::set("snakecam", "allow_jump", 0);
    _id_3B64EB40368C1450::set("snakecam", "gesture", 0);
    _id_3B64EB40368C1450::set("snakecam", "melee", 0);
    _id_3B64EB40368C1450::set("snakecam", "mantle", 0);
    _id_3B64EB40368C1450::set("snakecam", "offhand_weapons", 0);
    _id_3B64EB40368C1450::set("snakecam", "allow_movement", 0);
    _id_3B64EB40368C1450::set("snakecam", "sprint", 0);
    _id_3B64EB40368C1450::set("snakecam", "fire", 0);
    _id_3B64EB40368C1450::set("snakecam", "reload", 0);
    _id_3B64EB40368C1450::set("snakecam", "weapon_pickup", 0);
    _id_3B64EB40368C1450::set("snakecam", "weapon_switch", 0);
    _id_3B64EB40368C1450::set("snakecam", "killstreaks", 0);
    self _meth_35501B42058D4DE9();
  } else {
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("typing");
    self _meth_BB04491D50D9E43E();
  }
}