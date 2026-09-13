/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_infilexfil.gsc
***********************************************/

infil_ended(_id_D47AC5A6CBDC6DCF) {
  level waittill("infil_started");
  _id_9964950B5DCA427F = 0;

  if(isDefined(level.extra_infil_time))
    _id_9964950B5DCA427F = level.extra_infil_time;

  wait(_id_D47AC5A6CBDC6DCF + _id_9964950B5DCA427F);
  level notify("prematch_over");

  if(scripts\engine\utility::flag_exist("infil_complete"))
    scripts\engine\utility::flag_set("infil_complete");
}

onplayerspawnedinfil() {
  self endon("game_ended");
  self endon("prematch_over");

  for(;;) {
    level waittill("player_spawned", player);
    player setclientomnvar("ui_hide_hud", 1);
    _id_BE4FBABEAFB491A7 = scripts\cp\infilexfil\infilexfil::get_spot_from_player(player);

    if(isDefined(_id_BE4FBABEAFB491A7))
      cp_player_free_spot(player, scripts\cp\utility::getotherteam(player.team));

    player cp_player_join_infil_cp();
  }
}

cponplayerdisconnectinfil() {
  self endon("prematch_over");
  self waittill("disconnect");
  cp_player_free_spot(self);
}

infil_is_type(_id_643BCFEC059B4AE2) {
  return self.script_noteworthy == _id_643BCFEC059B4AE2;
}

infil_is_subtype(_id_D099B99A4515F378) {
  return self.name == _id_D099B99A4515F378;
}

cp_infil_player_allow(_id_CD187E38E3DF8F36, _id_1B7F9D59A74FF1A1) {
  if(!isDefined(_id_1B7F9D59A74FF1A1))
    _id_1B7F9D59A74FF1A1 = 1;

  if(!_id_CD187E38E3DF8F36) {
    _id_3B64EB40368C1450::set("infil_player", "allow_movement", 0);
    _id_3B64EB40368C1450::set("infil_player", "prone", 0);
    _id_3B64EB40368C1450::set("infil_player", "crouch", 0);
    _id_3B64EB40368C1450::set("infil_player", "allow_jump", 0);

    if(_id_1B7F9D59A74FF1A1) {
      _id_3B64EB40368C1450::set("infil_player", "fire", 0);
      _id_3B64EB40368C1450::set("infil_player", "ads", 0);
      _id_3B64EB40368C1450::set("infil_player", "reload", 0);
    }

    _id_3B64EB40368C1450::set("infil_player", "sprint", 0);
    _id_3B64EB40368C1450::set("infil_player", "melee", 0);
    _id_3B64EB40368C1450::set("infil_player", "lean", 0);
    _id_3B64EB40368C1450::set("infil_player", "slide", 0);
    _id_3B64EB40368C1450::set("infil_player", "offhand_weapons", 0);
    _id_3B64EB40368C1450::set("infil_player", "weapon_switch", 0);
    _id_3B64EB40368C1450::set("infil_player", "usability", 0);
    scripts\cp\utility::_id_4CBAED764C116A25(1);
  } else {
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("infil_player");
    scripts\cp\utility::_id_4CBAED764C116A25(0);
  }
}

_id_A49AF99ADDCF2646(_id_CD187E38E3DF8F36) {
  cp_infil_player_allow(_id_CD187E38E3DF8F36, 0);
}

teamhasinfil(team) {
  if(!isDefined(game["infil"]))
    return 0;

  return isDefined(game["infil"][team]["lanes"]);
}

cp_player_free_spot(player, team) {
  if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  if(!isDefined(team))
    team = player.team;

  if(!isDefined(game["infil"][team]["spots"])) {}

  foreach(key, _id_0C3EA9B1A20FF199 in game["infil"][team]["spots"]) {
    if(scripts\cp\infilexfil\infilexfil::is_spot_taken(team, key) && _id_0C3EA9B1A20FF199["player"] == player) {
      game["infil"][team]["spots"][key]["player"] = undefined;
      player notify("player_free_spot");
      return;
    }
  }
}

cp_get_spot_by_priority(team) {
  _id_F9B2403B4571D886 = [];

  foreach(key, _id_0C3EA9B1A20FF199 in game["infil"][team]["spots"]) {
    if(!scripts\cp\infilexfil\infilexfil::is_spot_taken(team, key))
      _id_F9B2403B4571D886[_id_F9B2403B4571D886.size] = key;
  }

  if(_id_F9B2403B4571D886.size == 0)
    return undefined;

  _id_2849F873DF400420 = getdvarint("dvar_E6526B9EF05103AD", -1);

  if(scripts\engine\utility::array_contains(_id_F9B2403B4571D886, _id_2849F873DF400420))
    return _id_2849F873DF400420;

  _id_F60DD12C7B65AE3B = undefined;
  _id_5C49327452EF41BB = -1;

  foreach(_id_0C3EA9B1A20FF199 in _id_F9B2403B4571D886) {
    priority = game["infil"][team]["spots"][_id_0C3EA9B1A20FF199]["priority"];

    if(!isDefined(_id_F60DD12C7B65AE3B) || priority < _id_5C49327452EF41BB) {
      _id_F60DD12C7B65AE3B = _id_0C3EA9B1A20FF199;
      _id_5C49327452EF41BB = priority;
    }
  }

  return _id_F60DD12C7B65AE3B;
}

cp_player_join_infil_cp() {
  if(game["infil"][self.team].size == 0) {
    return;
  }
  _id_AD497B2F2391DFE1 = 0;
  _id_047691436552AC69 = game["infil"][self.team]["spots"][0]["priority"] != -1;

  if(_id_AD497B2F2391DFE1)
    _id_E4B9CD561C7C0DE6 = scripts\cp\infilexfil\infilexfil::get_spot_taken_count(self.team);
  else if(_id_047691436552AC69)
    _id_E4B9CD561C7C0DE6 = cp_get_spot_by_priority(self.team);
  else
    _id_E4B9CD561C7C0DE6 = scripts\cp\infilexfil\infilexfil::get_random_spot(self.team);

  if(!isDefined(_id_E4B9CD561C7C0DE6)) {
    return;
  }
  _id_0C3EA9B1A20FF199 = scripts\cp\infilexfil\infilexfil::player_on_spot(self, _id_E4B9CD561C7C0DE6);
  _id_0C3EA9B1A20FF199["infil"] thread infil_player_array_handler(self);
  self notify("player_added_to_infil");
  self thread[[_id_0C3EA9B1A20FF199["callback"]]](_id_0C3EA9B1A20FF199["infil"], _id_0C3EA9B1A20FF199["seat"]);
  thread cponplayerdisconnectinfil();
}

get_random_spot_in_infil(team, infil) {
  _id_F9B2403B4571D886 = [];

  foreach(key, _id_0C3EA9B1A20FF199 in game["infil"][team]["spots"]) {
    if(key["infil"] != infil) {
      continue;
    }
    if(!scripts\cp\infilexfil\infilexfil::is_spot_taken(team, key))
      _id_F9B2403B4571D886[_id_F9B2403B4571D886.size] = key;
  }

  if(_id_F9B2403B4571D886.size == 0) {}

  _id_0C3EA9B1A20FF199 = scripts\engine\utility::random(_id_F9B2403B4571D886);
  return _id_0C3EA9B1A20FF199;
}

infil_player_array_handler(player) {
  self endon("death");
  self.players = scripts\engine\utility::array_add(self.players, player);
  player scripts\engine\utility::waittill_either("death", "disconnect");
  self.players = scripts\engine\utility::array_remove(self.players, player);
}

alwaysgamemodeclass() {
  clantag = self getclantag();

  if(clantag == "AR")
    class = "default1";
  else if(clantag == "SMG")
    class = "default2";
  else if(clantag == "LMG")
    class = "default3";
  else {
    _id_5570CB3187DBA152 = [];
    _id_5570CB3187DBA152[0] = "default1";
    _id_5570CB3187DBA152[1] = "default2";
    _id_5570CB3187DBA152[2] = "default3";
    class = scripts\engine\utility::random(_id_5570CB3187DBA152);
  }

  self.pers["class"] = class;
  self.pers["lastClass"] = "";
  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];
  return class;
}

#using_animtree("script_model");

infil_player_rig(animname, _id_486DB5FA512A3B6B, _id_40A4287D8D2E7EF9) {
  self.animname = animname;
  self _meth_B88C89BB7CD1AB8E(self.origin);
  player_rig = spawn("script_arms", self.origin, 0, 0, self);
  player_rig.angles = self.angles;
  player_rig.player = self;
  self.player_rig = player_rig;
  self.player_rig hide(1);
  self.player_rig.animname = animname;
  self.player_rig useanimtree(#animtree);
  self playerlinktodelta(self.player_rig, "tag_player", 1.0, 0, 0, 0, 0, 1);

  if(isDefined(_id_40A4287D8D2E7EF9) && _id_40A4287D8D2E7EF9)
    self playersetgroundreferenceent(self.player_rig);

  self notify("rig_created");

  if(!isDefined(level.prematchallowfunc))
    level.prematchallowfunc = ::cp_infil_player_allow;

  self[[level.prematchallowfunc]](0);
  scripts\engine\utility::waittill_any_3("remove_rig", "player_free_spot", "death");
  self[[level.prematchallowfunc]](1);

  if(isDefined(_id_40A4287D8D2E7EF9) && _id_40A4287D8D2E7EF9)
    self playersetgroundreferenceent(undefined);

  if(isDefined(self))
    self unlink();

  if(isDefined(player_rig))
    player_rig delete();
}

infil_play_sound_func(alias, _id_EA3E3B2121E6713A, _id_9A0AFE8FF3D2508F) {
  foreach(player in self.players)
  player playsoundtoplayer(alias, player);
}

infil_wait_for_players() {
  wait 5;
  scripts\engine\utility::flag_set("infil_started");
}

infil_scene_fade_in(delay_time, _id_C82EABB722C361A7, _id_FC787F4D3BF1501B) {
  if(!isDefined(delay_time))
    delay_time = 0;

  if(!isDefined(_id_C82EABB722C361A7))
    _id_C82EABB722C361A7 = 2.0;

  if(!isDefined(_id_FC787F4D3BF1501B))
    _id_FC787F4D3BF1501B = "infil_started";

  overlay = newclienthudelem(self);
  overlay.x = 0;
  overlay.y = 0;
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.sort = 1;
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.alpha = 1;
  overlay.foreground = 1;
  overlay setshader("black", 640, 480);
  overlay endon("death");
  scripts\engine\utility::waittill_any_3(_id_FC787F4D3BF1501B, "player_free_spot", "disconnect");
  wait(delay_time);
  overlay fadeovertime(_id_C82EABB722C361A7);
  overlay.alpha = 0;
  wait(_id_C82EABB722C361A7);
  overlay destroy();
}

givegunlesscp() {
  gunless = makeweapon("iw8_gunless_infil");
  self.post_infil_weapon = self getcurrentprimaryweapon();
  scripts\cp\utility::_giveweapon(gunless, undefined, undefined, 1);

  if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("script_weapon_switch"))
    _id_3B64EB40368C1450::set("gunless_cp", "script_weapon_switch", 1);

  success = 1;
  self switchtoweapon(gunless);

  if(success) {
    self.gunnlessweapon = gunless;
    _id_3B64EB40368C1450::set("gunless_cp", "weapon_switch", 0);
  } else
    self takeweapon(gunless);

  return success;
}

takegunlesscp() {
  if(!isDefined(self.gunnlessweapon) || !self hasweapon(self.gunnlessweapon)) {
    return;
  }
  self notify("get_post_infil_weapon");
  waitframe();
  self.takinggunless = 1;
  _id_3B64EB40368C1450::set("gunless_cp", "weapon_switch", 1);
  self takeweapon(self.gunnlessweapon);
  self.takinggunless = 0;
  self.gunnlessweapon = undefined;
  _id_3B64EB40368C1450::set("gunless_cp", "weapon_switch", 0);
}

handleweaponstatenotetrackcp(state) {
  switch (state) {
    case "drop":
      self.player setdemeanorviewmodel("normal");
      wait 0.1;
      self.player givegunlesscp();
      break;
    case "raise":
      self.player takegunlesscp();

      if(isDefined(self.player.post_infil_weapon))
        self.player switchtoweapon(self.player.post_infil_weapon);

      self.player.post_infil_weapon = undefined;
      break;
    case "safe":
      self.player setdemeanorviewmodel("safe");
      break;
    case "normal":
      self.player setdemeanorviewmodel("normal");
      break;
    case "free":
      self.player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("WeaponStateNotetrack");
      break;
    case "hold":
      self.player _id_3B64EB40368C1450::set("WeaponStateNotetrack", "fire", 0);
      self.player _id_3B64EB40368C1450::set("WeaponStateNotetrack", "ads", 0);
      self.player _id_3B64EB40368C1450::set("WeaponStateNotetrack", "reload", 0);
      break;
  }
}