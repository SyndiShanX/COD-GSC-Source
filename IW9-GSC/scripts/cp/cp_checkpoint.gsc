/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_checkpoint.gsc
***********************************************/

checkpoints_init() {
  if(isDefined(level.registered_checkpoints)) {
    return;
  }
  if(!isDefined(game["checkpoint_attempts"]))
    game["checkpoint_attempts"] = [];

  level.registered_checkpoints = [];
  _id_047589CD2789C1A5 = [];
  _id_313CC72DE0C10CDE = [];

  if(isDefined(level.checkpoint_player_spawns_func))
    _id_047589CD2789C1A5 = [[level.checkpoint_player_spawns_func]]();

  if(isDefined(level.checkpoint_carepkg_spawns_func))
    _id_313CC72DE0C10CDE = [[level.checkpoint_carepkg_spawns_func]]();

  if(_id_047589CD2789C1A5.size < 1 && _id_313CC72DE0C10CDE.size < 1) {
    return;
  }
  items = scripts\engine\utility::array_combine(_id_047589CD2789C1A5, _id_313CC72DE0C10CDE);

  foreach(index, item in items) {
    if(!isDefined(level.registered_checkpoints[item.checkpoint]))
      level.registered_checkpoints[item.checkpoint] = [];

    level.registered_checkpoints[item.checkpoint][index] = item;
  }
}

checkpoint_register(checkpoint, func) {
  if(!isDefined(level.registered_checkpoint_funcs))
    level.registered_checkpoint_funcs = [];

  level.registered_checkpoint_funcs[checkpoint] = func;
}

_id_17660E9C061A06DB() {
  _id_ABB77A43D0EEA9F2 = undefined;
  start = getDvar("start");
  keys = getarraykeys(level._id_2A02072872CCD8A1);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < keys.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(level._id_2A02072872CCD8A1[keys[_id_AC0E594AC96AA3A8]].starts)) {
      _id_AC0E5C4AC96AAA41 = 0;

      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < level._id_2A02072872CCD8A1[keys[_id_AC0E594AC96AA3A8]].starts.size; _id_AC0E5C4AC96AAA41++) {
        if(start == level._id_2A02072872CCD8A1[keys[_id_AC0E594AC96AA3A8]].starts[_id_AC0E5C4AC96AAA41]) {
          _id_ABB77A43D0EEA9F2 = keys[_id_AC0E594AC96AA3A8];
          break;
        }
      }
    }
  }

  return _id_ABB77A43D0EEA9F2;
}

_id_D4CDC242233C15B3() {
  start = getDvar("start");
  _id_ABB77A43D0EEA9F2 = _id_17660E9C061A06DB();
  checkpoint = _id_9EED75023A958C18();

  if(isDefined(checkpoint) && checkpoint != "" && isDefined(level.registered_checkpoint_funcs[checkpoint])) {
    if(isDefined(level._id_2A02072872CCD8A1) && isDefined(_id_ABB77A43D0EEA9F2) && isDefined(level._id_2A02072872CCD8A1[_id_ABB77A43D0EEA9F2])) {
      _id_B62E28E3FBDFAC20 = level._id_2A02072872CCD8A1[_id_ABB77A43D0EEA9F2];

      if(isDefined(_id_B62E28E3FBDFAC20._id_761C3A588103E918) && isDefined(_id_B62E28E3FBDFAC20._id_761C3A588103E918[checkpoint]) && isDefined(_id_B62E28E3FBDFAC20._id_761C3A588103E918[checkpoint]._id_23C5A6352CE4150E))
        level.default_player_spawns = _id_B62E28E3FBDFAC20._id_761C3A588103E918[checkpoint]._id_23C5A6352CE4150E;
    }

    level thread[[level.registered_checkpoint_funcs[checkpoint]]]();
  } else if(isDefined(_id_ABB77A43D0EEA9F2))
    _id_EBC288FCC6CABBE4(_id_ABB77A43D0EEA9F2);
}

_id_EBC288FCC6CABBE4(_id_79B0DEAB13945AED) {
  _id_B7CCDEF52750BFDB = level._id_2A02072872CCD8A1[_id_79B0DEAB13945AED];

  if(isDefined(_id_B7CCDEF52750BFDB._id_097D01EEF320789E))
    level.default_player_spawns = _id_B7CCDEF52750BFDB._id_097D01EEF320789E;

  _id_B7CCDEF52750BFDB.start = getDvar("start");
  _id_B7CCDEF52750BFDB.checkpoint = _id_9EED75023A958C18();
  _id_B7CCDEF52750BFDB thread[[_id_B7CCDEF52750BFDB._id_E0C23E69910A3EA0]]();
}

_id_9DF80FF2F32ED96D(_id_79B0DEAB13945AED, _id_D400F734A98FD7D7, _id_E0C23E69910A3EA0, _id_7064A1A61989F0F5) {
  if(!isDefined(level._id_2A02072872CCD8A1))
    level._id_2A02072872CCD8A1 = [];

  struct = spawnStruct();
  struct.starts = _id_D400F734A98FD7D7;
  struct._id_761C3A588103E918 = [];
  struct._id_E0C23E69910A3EA0 = _id_E0C23E69910A3EA0;
  struct._id_097D01EEF320789E = _id_7064A1A61989F0F5;
  level._id_2A02072872CCD8A1[_id_79B0DEAB13945AED] = struct;
}

_id_A83214EC9CBF5BC8(_id_79B0DEAB13945AED, checkpoint, _id_90705AD3DA93AA0A, _id_49DC719A8AEA08C8) {
  if(!isDefined(level._id_2A02072872CCD8A1) || !isDefined(level._id_2A02072872CCD8A1[_id_79B0DEAB13945AED])) {
    return;
  }
  _id_B62E28E3FBDFAC20 = level._id_2A02072872CCD8A1[_id_79B0DEAB13945AED];
  _id_66397695E709CAD6 = spawnStruct();
  _id_66397695E709CAD6._id_A0AB64DB3B95A0A5 = _id_90705AD3DA93AA0A;
  _id_66397695E709CAD6._id_23C5A6352CE4150E = _id_49DC719A8AEA08C8;
  _id_B62E28E3FBDFAC20._id_761C3A588103E918[checkpoint] = _id_66397695E709CAD6;
  checkpoint_register(checkpoint, _id_90705AD3DA93AA0A);
}

_id_C506F6B5C63E776C() {
  return isDefined(game["restart_checkpoint"]);
}

checkpoint_set(checkpoint, _id_8C5B2EE4DFDFC600) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "checkpoint_set")) {
    _id_EA847593E957F2B0 = scripts\cp_mp\utility\script_utility::getsharedfunc("game", "checkpoint_set");
    [[_id_EA847593E957F2B0]](checkpoint);
  }

  game["restart_checkpoint"] = checkpoint;

  if(checkpoint == "")
    game["restart_checkpoint"] = undefined;

  _id_4A0D987AC61BBA3B = getDvar(_func_2EF675C13CA1C4AF("dvar_287B3B75F2C14FE9", level.mapname));

  if(isDefined(_id_4A0D987AC61BBA3B) && _id_4A0D987AC61BBA3B != "")
    setDvar(_func_2EF675C13CA1C4AF("dvar_287B3B75F2C14FE9", level.mapname), "");

  if(checkpoint != "") {
    setomnvar("ui_cp_checkpoint", 1);

    if(!isDefined(game["checkpoint_attempts"][checkpoint])) {
      game["checkpoint_attempts"][checkpoint] = 1;
      _id_116171939929AF39::_id_E41A5E1DEE804551(level._id_E6997D1DB0CB5E47, game["checkpoint_attempts"][checkpoint]);
    }
  }

  foreach(player in level.players) {
    player.pers["counting_stats"]["kills"] = player _id_3BCAA2CBAF54ABDD::_id_00C0480DC3A45EF6("kills");
    player.pers["counting_stats"]["downs"] = player _id_3BCAA2CBAF54ABDD::_id_00C0480DC3A45EF6("downs");
    player.pers["counting_stats"]["revives"] = player _id_3BCAA2CBAF54ABDD::_id_00C0480DC3A45EF6("revives");

    if(checkpoint != "" && !istrue(_id_8C5B2EE4DFDFC600))
      player thread _id_12E2FB553EC1605E::_id_7DA7BD24B280D295();
  }

  scripts\cp\cp_gameskill::_id_FFEF4CFD9FEC2E5B();
}

_id_9EED75023A958C18() {
  if(getdvarint("dvar_F1981B3F0CB1F449"))
    return "";

  if(isDefined(game["restart_checkpoint"]))
    return game["restart_checkpoint"];
  else
    return "";
}

checkpoint_get_item(checkpoint, item_type) {
  _id_0E7C8F9864CC0E30 = level.registered_checkpoints[checkpoint];

  if(!isDefined(_id_0E7C8F9864CC0E30))
    return undefined;

  foreach(item in _id_0E7C8F9864CC0E30) {
    if(item.type != item_type) {
      continue;
    }
    if(item.checkpoint != checkpoint) {
      continue;
    }
    if(isDefined(item.inuse)) {
      continue;
    }
    switch (item_type) {
      case "player_spawn":
        item.inuse = 1;
        return item;
      case "carepackage":
      case "carepackage_munitions":
        return item;
    }
  }
}

checkpoint_release_spawnpoint(player) {
  player scripts\engine\utility::waittill_any_2("spawned_player", "disconnect");

  while(scripts\cp\utility::any_player_nearby(self.origin, 64))
    wait 1;

  self.inuse = undefined;
}

checkpoint_create_carepackage(checkpoint) {
  level endon("game_ended");

  if(!isDefined(level.registered_checkpoint_funcs[checkpoint])) {
    return;
  }
  spawnpoint = checkpoint_get_item(checkpoint, "carepackage");
  care_pkg = spawn("script_model", spawnpoint.origin);
  care_pkg.angles = spawnpoint.angles;
  care_pkg setModel("military_carepackage_01_friendly");
  brushmodel = getEnt("care_package_col", "targetname");
  _id_D6FE430ED5379CF8 = spawn("script_model", spawnpoint.origin);
  _id_D6FE430ED5379CF8.angles = spawnpoint.angles;
  _id_D6FE430ED5379CF8 clonebrushmodeltoscriptmodel(brushmodel);
  _id_D6FE430ED5379CF8 linkTo(care_pkg);
  _id_E88F6961175998CE = spawn("script_model", spawnpoint.origin + (0, 0, 35));
  _id_E88F6961175998CE setModel("tag_origin");
  _id_E88F6961175998CE scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_STRIKE/EDIT_LOADOUT", 25, "duration_short", "hide", 256, 75, 128, 75);
  _id_E88F6961175998CE.headicon = createheadicon(care_pkg);
  setheadiconimage(_id_E88F6961175998CE.headicon, "hud_icon_survival_weapon");
  setheadiconsnaptoedges(_id_E88F6961175998CE.headicon, 0);
  setheadiconmaxdistance(_id_E88F6961175998CE.headicon, 1024);
  setheadiconnaturaldistance(_id_E88F6961175998CE.headicon, 256);
  setheadiconzoffset(_id_E88F6961175998CE.headicon, -5);
  care_pkg.collision = _id_D6FE430ED5379CF8;
  care_pkg.interaction = _id_E88F6961175998CE;
  _id_E88F6961175998CE thread checkpoint_carepackage_think(care_pkg);
  return care_pkg;
}

checkpoint_carepackage_think(_id_F471430A28CF8270) {
  self endon("death");
  _id_F471430A28CF8270 endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    player thread checkpoint_edit_loadout(self);
  }
}

checkpoint_edit_loadout(interaction) {
  self endon("disconnect");
  self endon("last_stand");
  level endon("game_ended");
  interaction disableplayeruse(self);
  level thread scripts\cp\utility\cp_safehouse_util::_id_54DAC17E1C475546(self, interaction);
  self setclientomnvar("cp_open_cac", -1);
  self setclientomnvar("ui_options_menu", 2);
  scripts\engine\utility::waittill_any_2("loadout_given", "loadout_menu_closed");
  wait 1;
  self setclientomnvar("cp_open_cac", -2);
  interaction enableplayeruse(self);
}

checkpoint_create_carepackage_munitions(checkpoint, _id_A4C65DFCAF9E25E0, _id_04A727EA336A56CB, use_milcrate) {
  level endon("game_ended");
  _id_9F925F5509626DF1 = 0;

  if(istrue(level.disable_map_munitions)) {
    switch (checkpoint) {
      case "tow_p1":
      case "arms_race_p1":
      case "apce_p1":
      case "ml_p3":
      case "ml_p2":
      case "ml_p1":
      case "convoy4_secure_tower":
      case "tmtyl_p1":
        _id_9F925F5509626DF1 = 1;
        break;
    }

    if(_id_9F925F5509626DF1)
      return;
  }

  spawnpoint = checkpoint_get_item(checkpoint, "carepackage_munitions");

  if(!isDefined(spawnpoint) || !isDefined(spawnpoint.origin)) {
    return;
  }
  care_pkg = spawn("script_model", spawnpoint.origin);
  care_pkg.angles = spawnpoint.angles;
  _id_0C2722C653E3E4E3 = (0, 0, 35);
  _id_F1B21D47F7E81F45 = "show";
  _id_1FADB16C673C2C10 = undefined;
  _id_FD0B63C63D9FCC8C = undefined;

  if(!istrue(use_milcrate)) {
    care_pkg setModel("military_carepackage_01_uk");
    brushmodel = getEnt("care_package_col", "targetname");
    _id_D6FE430ED5379CF8 = spawn("script_model", spawnpoint.origin);
    _id_D6FE430ED5379CF8.angles = spawnpoint.angles;
    _id_D6FE430ED5379CF8 clonebrushmodeltoscriptmodel(brushmodel);
    _id_D6FE430ED5379CF8 linkTo(care_pkg);
    care_pkg.collision = _id_D6FE430ED5379CF8;

    if(isDefined(checkpoint) && checkpoint == "strongbox") {
      level.checkpoint = "strongbox";
      _id_0C2722C653E3E4E3 = _id_0C2722C653E3E4E3 + (-10, 25, 0);
      _id_1FADB16C673C2C10 = (10, -25, 35);
    }
  } else {
    care_pkg setModel("military_hq_crate_01_proxy_cp_spawnable");
    care_pkg setscriptablepartstate("main", "on");
    care_pkg.use_milcrate = 1;
    _id_0C2722C653E3E4E3 = _id_0C2722C653E3E4E3 + rotatevector((18.5, 16.6, 2), care_pkg.angles);
    _id_F1B21D47F7E81F45 = "hide";
    _id_1FADB16C673C2C10 = (0, 0, 35) + rotatevector((18.5, -14.6, 2), care_pkg.angles);
  }

  level thread checkpoint_carepackage_munitions_role_init(_id_1FADB16C673C2C10, spawnpoint, care_pkg, _id_A4C65DFCAF9E25E0, _id_04A727EA336A56CB, use_milcrate, _id_F1B21D47F7E81F45);
  _id_E88F6961175998CE = spawn("script_model", spawnpoint.origin + _id_0C2722C653E3E4E3);
  _id_E88F6961175998CE setModel("tag_origin");
  _id_E88F6961175998CE scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_STRIKE/EDIT_MUNITIONS", 1, "duration_short", _id_F1B21D47F7E81F45, 256, 75, 128, 75);
  care_pkg.interaction = _id_E88F6961175998CE;
  _id_E88F6961175998CE.care_pkg = care_pkg;
  _id_E88F6961175998CE.munitions_override_waittill = _id_A4C65DFCAF9E25E0;
  _id_E88F6961175998CE.munitions_override_time = _id_04A727EA336A56CB;
  _id_E88F6961175998CE.use_milcrate = use_milcrate;
  _id_E88F6961175998CE thread checkpoint_carepackage_munitions_think(care_pkg);
  return care_pkg;
}

checkpoint_carepackage_munitions_role_init(_id_1FADB16C673C2C10, spawnpoint, care_pkg, _id_A4C65DFCAF9E25E0, _id_04A727EA336A56CB, use_milcrate, _id_F1B21D47F7E81F45) {
  level endon("game_ended");

  if(isDefined(_id_1FADB16C673C2C10)) {
    _id_4BEF6B7F5A69864F = spawn("script_model", spawnpoint.origin + _id_1FADB16C673C2C10);
    _id_4BEF6B7F5A69864F setModel("tag_origin");

    if(!isDefined(_id_F1B21D47F7E81F45))
      _id_F1B21D47F7E81F45 = "hide";

    _id_4BEF6B7F5A69864F scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_STRIKE/EDIT_ROLE", 1, "duration_short", _id_F1B21D47F7E81F45, 256, 75, 128, 75);
    care_pkg.role_interaction = _id_4BEF6B7F5A69864F;
    _id_4BEF6B7F5A69864F.care_pkg = care_pkg;
    _id_4BEF6B7F5A69864F.munitions_override_waittill = _id_A4C65DFCAF9E25E0;
    _id_4BEF6B7F5A69864F.munitions_override_time = _id_04A727EA336A56CB;
    _id_4BEF6B7F5A69864F.use_milcrate = use_milcrate;
    _id_4BEF6B7F5A69864F thread checkpoint_carepackage_munitions_role_think(care_pkg);
  }
}

checkpoint_carepackage_munitions_think(_id_F471430A28CF8270) {
  self endon("death");
  _id_F471430A28CF8270 endon("death");
  thread checkpoint_edit_munitions_icon_init();
  thread checkpoint_edit_munitions_limit_init();

  for(;;) {
    self waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(istrue(player.disable_purchase_munitions)) {
      continue;
    }
    player thread checkpoint_edit_munitions(self);
  }
}

checkpoint_carepackage_munitions_role_think(_id_F471430A28CF8270, type) {
  self endon("death");
  _id_F471430A28CF8270 endon("death");
  thread checkpoint_edit_role_limiter();

  for(;;) {
    self waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(istrue(player.disable_purchase_munitions)) {
      continue;
    }
    player thread checkpoint_edit_role(self);
  }
}

checkpoint_edit_role_limiter() {
  level endon("game_ended");
  level waittill("close_munitions_store");
  self makeunusable();
}

checkpoint_edit_munitions_limit_init() {
  level endon("game_ended");
  level endon("close_munitions_store");

  for(;;) {
    level waittill("player_spawned", player);
    level thread checkpoint_edit_munitions_limiter(player, self);
  }
}

checkpoint_edit_munitions_icon_init() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("objectives_registered");
  scripts\engine\utility::flag_wait("strike_init_done");
  _id_4C87400544DC7457 = 38;

  if(istrue(self.use_milcrate))
    _id_4C87400544DC7457 = 22;

  self.objicon = scripts\cp\cp_objectives::requestworldid("munitions_purchase", 25);
  objective_setplayintro(self.objicon, 0);
  objective_setbackground(self.objicon, 1);
  objective_state(self.objicon, "invisible");
  objective_icon(self.objicon, "hud_icon_survival_killstreak_small");
  org = self.origin;

  if(isDefined(level.checkpoint) && level.checkpoint == "strongbox") {
    _id_4C87400544DC7457 = 75;
    org = self.care_pkg.origin;
  }

  objective_position(self.objicon, org + (0, 0, _id_4C87400544DC7457));
  objective_setshowdistance(self.objicon, 0);
  objective_sethot(self.objicon, 0);
  objective_setpinned(self.objicon, 0);
  objective_hidefromplayersinmask(self.objicon);
  objective_removeallfrommask(self.objicon);
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  wait 2.5;
  progress = 1;
  _id_D19E041C9E06ACBE = 60;
  waittime = 0.1;

  if(isDefined(self.munitions_override_time))
    _id_D19E041C9E06ACBE = self.munitions_override_time;

  _id_9A856EA56A94E11E = waittime / _id_D19E041C9E06ACBE;

  if(isDefined(self.munitions_override_waittill))
    level waittill(self.munitions_override_waittill);

  objective_showprogressforteam(self.objicon, "allies");

  while(progress > 0) {
    objective_setprogress(self.objicon, progress);
    wait(waittime);
    progress = progress - _id_9A856EA56A94E11E;

    if(progress < 0)
      progress = 0;
  }

  level notify("close_munitions_store");
  self makeunusable();

  foreach(player in level.players) {
    if(player getclientomnvar("cp_open_cac") == 3)
      player setclientomnvar("cp_open_cac", -2);
  }

  if(istrue(self.use_milcrate))
    self.care_pkg setscriptablepartstate("main", "off");
  else {
    self.care_pkg setscriptablepartstate("anims", "capture", 0);
    self.care_pkg setscriptablepartstate("capture", "start", 0);
    self.care_pkg.collision delete();
  }

  scripts\cp\cp_objectives::freeworldid("munitions_purchase");
}

checkpoint_edit_munitions_limiter(player, _id_16A8B2D5CA83A123) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  level endon("close_munitions_store");

  if(istrue(player.tracking_munitions_purchase)) {
    return;
  }
  player.tracking_munitions_purchase = 1;
  wait 3;

  for(;;) {
    _id_1652CE42E6FCF832 = distance2dsquared(player.origin, _id_16A8B2D5CA83A123.origin);

    if(isDefined(_id_1652CE42E6FCF832) && _id_1652CE42E6FCF832 > 262144) {
      if(!istrue(player.hiding_munitions_purchase)) {
        objective_addclienttomask(_id_16A8B2D5CA83A123.objicon, player);
        player.hiding_munitions_purchase = 1;
      }
    } else if(isDefined(_id_1652CE42E6FCF832) && _id_1652CE42E6FCF832 <= 262144) {
      if(isDefined(player.hiding_munitions_purchase)) {
        objective_removeclientfrommask(_id_16A8B2D5CA83A123.objicon, player);
        player.hiding_munitions_purchase = undefined;
      }
    }

    wait 0.5;
  }
}

checkpoint_edit_munitions(interaction) {
  self endon("disconnect");
  self endon("last_stand");
  level endon("game_ended");
  level endon("close_munitions_store");
  interaction disableplayeruse(self);
  self setclientomnvar("cp_open_cac", 3);
  wait 1;
  interaction enableplayeruse(self);
}

checkpoint_edit_role(interaction) {
  self endon("disconnect");
  self endon("last_stand");
  level endon("game_ended");
  level endon("close_munitions_store");
  interaction disableplayeruse(self);
  self.role_edit = 1;
  self setclientomnvar("cp_open_cac", 5);
  wait 1;
  interaction enableplayeruse(self);
}

checkpoint_add_spawnpoint(checkpoint, origin, angles) {
  s = spawnStruct();
  s.origin = origin;
  s.angles = angles;
  s.type = "player_spawn";
  s.checkpoint = checkpoint;
  return s;
}

checkpoint_add_carepackage(checkpoint, origin, angles) {
  s = spawnStruct();
  s.origin = origin;
  s.angles = angles;
  s.type = "carepackage";
  s.checkpoint = checkpoint;
  return s;
}

checkpoint_add_carepackage_munitions(checkpoint, origin, angles) {
  s = spawnStruct();
  s.origin = origin;
  s.angles = angles;
  s.type = "carepackage_munitions";
  s.checkpoint = checkpoint;
  return s;
}