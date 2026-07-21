/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_infilexfil.gsc
***********************************************/

infil_ended(var_0) {
  level waittill("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  var_1 = 0;

  if(isDefined(level.extra_infil_time))
    var_1 = level.extra_infil_time;

  wait(var_0 + var_1);
  level notify("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");

  if(scripts\engine\utility::flag_exist("_encstr_A2D20FE4880D52A426C867576878654BD3"))
    scripts\engine\utility::flag_set("_encstr_A2D20FE4880D52A426C867576878654BD3");
}

onplayerspawnedinfil() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");

  for(;;) {
    level waittill("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23", var_0);
    var_0 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);
    var_1 = scripts\cp\infilexfil\infilexfil::get_spot_from_player(var_0);

    if(isDefined(var_1))
      cp_player_free_spot(var_0, scripts\cp\utility::getotherteam(var_0.team));

    if(!scripts\engine\utility::flag("_encstr_8C0D0E8410E8B112602F133F559DCAF4")) {
      var_0 cp_player_join_infil_cp();
      continue;
    }
  }
}

cponplayerdisconnectinfil() {
  self endon("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  self waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  cp_player_free_spot(self);
}

infil_is_type(var_0) {
  return self.script_noteworthy == var_0;
}

infil_is_subtype(var_0) {
  return self.name == var_0;
}

cp_infil_player_allow(var_0) {
  self allowmovement(var_0);
  scripts\common\utility::allow_prone(var_0);
  scripts\common\utility::allow_crouch(var_0);
  scripts\common\utility::allow_jump(var_0);
  scripts\common\utility::allow_fire(var_0);
  scripts\common\utility::allow_ads(var_0);
  scripts\common\utility::allow_sprint(var_0);
  scripts\common\utility::allow_melee(var_0);
  scripts\common\utility::allow_reload(var_0);
  scripts\common\utility::allow_lean(var_0);
  scripts\common\utility::allow_slide(var_0);
  scripts\common\utility::allow_offhand_weapons(var_0);
  scripts\common\utility::allow_weapon_switch(var_0);
  scripts\common\utility::allow_usability(var_0);
}

teamhasinfil(var_0) {
  if(!isDefined(game["_encstr_9B8F06A38D72C380"]))
    return 0;

  return isDefined(game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_99EC06E297A25BEE"]);
}

cp_player_free_spot(var_0, var_1) {
  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = var_0.team;

  if(!isDefined(game["_encstr_9B8F06A38D72C380"][var_1]["_encstr_B18A065E98576317"])) {}

  foreach(var_4, var_3 in game["_encstr_9B8F06A38D72C380"][var_1]["_encstr_B18A065E98576317"]) {
    if(scripts\cp\infilexfil\infilexfil::is_spot_taken(var_1, var_4) && var_3["_encstr_8BB007E03658CBCAE4"] == var_0) {
      game["_encstr_9B8F06A38D72C380"][var_1]["_encstr_B18A065E98576317"][var_4]["_encstr_8BB007E03658CBCAE4"] = undefined;
      var_0 notify("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
      return;
    }
  }
}

cp_get_spot_by_priority(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"]) {
    if(!scripts\cp\infilexfil\infilexfil::is_spot_taken(var_0, var_4))
      var_1[var_1.size] = var_4;
  }

  if(var_1.size == 0)
    return undefined;

  var_5 = getdvarint("_encstr_8ABA15EB69853FC3B008F0ACF72A128B8BBFE762B97F7D", -1);

  if(scripts\engine\utility::array_contains(var_1, var_5))
    return var_5;

  var_6 = undefined;
  var_7 = -1;

  foreach(var_3 in var_1) {
    var_9 = game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"][var_3]["_encstr_978C092BB8FBFDEB302D69"];

    if(!isDefined(var_6) || var_9 < var_7) {
      var_6 = var_3;
      var_7 = var_9;
    }
  }

  return var_6;
}

cp_player_join_infil_cp() {
  if(game["_encstr_9B8F06A38D72C380"][self.team].size == 0) {
    return;
  }
  var_0 = 0;
  var_1 = game["_encstr_9B8F06A38D72C380"][self.team]["_encstr_B18A065E98576317"][0]["_encstr_978C092BB8FBFDEB302D69"] != -1;

  if(level.gametype == "_encstr_A53E0883E976B715503F" && isDefined(self.tacopsmapselectedarea.dynamicent))
    var_2 = get_random_spot_in_infil(self.team, self.tacopsmapselectedarea.dynamicent);
  else if(var_0)
    var_2 = scripts\cp\infilexfil\infilexfil::get_spot_taken_count(self.team);
  else if(var_1)
    var_2 = cp_get_spot_by_priority(self.team);
  else
    var_2 = scripts\cp\infilexfil\infilexfil::get_random_spot(self.team);

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = scripts\cp\infilexfil\infilexfil::player_on_spot(self, var_2);
  var_3["_encstr_9B8F06A38D72C380"] thread infil_player_array_handler(self);
  self notify("_encstr_AA2C160B1D69C0BD3367E3E1A36A75A914B596A005D688E1");
  self thread[[var_3["_encstr_A7AA09C616D81B26586CB5"]]](var_3["_encstr_9B8F06A38D72C380"], var_3["_encstr_82180596773AC1"]);
  thread cponplayerdisconnectinfil();
}

get_random_spot_in_infil(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_B18A065E98576317"]) {
    if(var_5["_encstr_9B8F06A38D72C380"] != var_1) {
      continue;
    }
    if(!scripts\cp\infilexfil\infilexfil::is_spot_taken(var_0, var_5))
      var_2[var_2.size] = var_5;
  }

  if(var_2.size == 0) {}

  var_4 = scripts\engine\utility::random(var_2);
  return var_4;
}

infil_player_array_handler(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self.players = scripts\engine\utility::array_add(self.players, var_0);
  var_0 scripts\engine\utility::waittill_either("_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC");
  self.players = scripts\engine\utility::array_remove(self.players, var_0);
}

alwaysgamemodeclass() {
  var_0 = self getclantag();

  if(var_0 == "_encstr_AD07034839")
    var_1 = "_encstr_A5450947E0B60E5060CB6B";
  else if(var_0 == "_encstr_BE1904D49A1D")
    var_1 = "_encstr_8345096F85A579A798F922";
  else if(var_0 == "_encstr_9A190462A9A3")
    var_1 = "_encstr_8B45098A61FC578BB809DB";
  else {
    var_2 = [];
    var_2[0] = "_encstr_A5450947E0B60E5060CB6B";
    var_2[1] = "_encstr_8345096F85A579A798F922";
    var_2[2] = "_encstr_8B45098A61FC578BB809DB";
    var_1 = scripts\engine\utility::random(var_2);
  }

  self.pers["_encstr_959506B911C79707"] = var_1;
  self.pers["_encstr_92690A5B078ED325F539E25E"] = "_encstr_B40101";
  self.class = self.pers["_encstr_959506B911C79707"];
  self.lastclass = self.pers["_encstr_92690A5B078ED325F539E25E"];
  return var_1;
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");

infil_player_rig(var_0, var_1, var_2) {
  self.animname = var_0;
  self predictstreampos(self.origin);
  var_3 = spawn("_encstr_BEFE0C2FAB5A88876B4181EB4A5F", self.origin, 0, 0, self);
  var_3.angles = self.angles;
  var_3.player = self;
  self.player_rig = var_3;
  self.player_rig hide(1);
  self.player_rig.animname = var_0;
  self.player_rig useanimtree(#animtree);
  self playerlinktodelta(self.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", 1.0, 0, 0, 0, 0, 1);

  if(isDefined(var_2) && var_2)
    self playersetgroundreferenceent(self.player_rig);

  self notify("_encstr_A9920CF579D7F1B6CBAAD963B24B");

  if(!isDefined(level.prematchallowfunc))
    level.prematchallowfunc = ::cp_infil_player_allow;

  self[[level.prematchallowfunc]](0);
  scripts\engine\utility::_id_143A6("_encstr_BE840BF2FFD8B0A4DB6EE31FA1", "_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A", "_encstr_AD75063D571AE108");
  self[[level.prematchallowfunc]](1);

  if(isDefined(var_2) && var_2)
    self playersetgroundreferenceent(undefined);

  if(isDefined(self))
    self unlink();

  if(isDefined(var_3))
    var_3 delete();
}

infil_play_sound_func(var_0, var_1, var_2) {
  foreach(var_4 in self.players)
  var_4 playsoundtoplayer(var_0, var_4);
}

infil_wait_for_players() {
  wait 5;
  scripts\engine\utility::flag_set("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
}

infil_scene_fade_in(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(!isDefined(var_1))
    var_1 = 2.0;

  if(!isDefined(var_2))
    var_2 = "_encstr_8C0D0E8410E8B112602F133F559DCAF4";

  var_3 = newclienthudelem(self);
  var_3.x = 0;
  var_3.y = 0;
  var_3.alignx = "_encstr_A5AD056A019C63";
  var_3.aligny = "_encstr_AC190479FF92";
  var_3.sort = 1;
  var_3.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_3.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_3.alpha = 1;
  var_3.foreground = 1;
  var_3 setshader("_encstr_83AB065EE1391A7B", 640, 480);
  var_3 endon("_encstr_AD75063D571AE108");
  scripts\engine\utility::_id_143A6(var_2, "_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A", "_encstr_8D820B49520F0EC02DDE6367EC");
  wait(var_0);
  var_3 fadeovertime(var_1);
  var_3.alpha = 0;
  wait(var_1);
  var_3 destroy();
}

givegunlesscp() {
  var_0 = getcompleteweaponname("_encstr_9A0D0C4B54606F8F63C84B8B53EE");
  self.post_infil_weapon = self getcurrentprimaryweapon();
  scripts\cp\utility::_giveweapon(var_0, undefined, undefined, 1);

  if(!scripts\common\utility::is_script_weapon_switch_allowed())
    scripts\common\utility::allow_script_weapon_switch(1);

  var_1 = 1;
  self switchtoweapon(var_0);

  if(var_1) {
    self.gunnlessweapon = var_0;
    scripts\common\utility::allow_weapon_switch(0);
  } else
    self takeweapon(var_0);

  return var_1;
}

takegunlesscp() {
  if(!isDefined(self.gunnlessweapon) || !self hasweapon(self.gunnlessweapon)) {
    return;
  }
  self notify("_encstr_8170161C95DD07077F47A3B9B96335AA6957FBAFA71015BD");
  waitframe();
  self.takinggunless = 1;
  scripts\common\utility::allow_weapon_switch(1);
  self takeweapon(self.gunnlessweapon);
  self.takinggunless = 0;
  self.gunnlessweapon = undefined;
  scripts\common\utility::allow_weapon_switch(0);
}

handleweaponstatenotetrackcp(var_0) {
  switch (var_0) {
    case "_encstr_84660547ED28E0":
      self.player setdemeanorviewmodel("_encstr_820E07FAE8780B3A4C");
      wait 0.1;
      self.player givegunlesscp();
      break;
    case "_encstr_A3110693D34B8A30":
      self.player takegunlesscp();

      if(isDefined(self.player.post_infil_weapon))
        self.player switchtoweapon(self.player.post_infil_weapon);

      self.player.post_infil_weapon = undefined;
      break;
    case "_encstr_B418059B8533CA":
      self.player setdemeanorviewmodel("_encstr_B418059B8533CA");
      break;
    case "_encstr_820E07FAE8780B3A4C":
      self.player setdemeanorviewmodel("_encstr_820E07FAE8780B3A4C");
      break;
    case "_encstr_BD78059C33C543":
      self.player scripts\common\utility::allow_fire(1);
      self.player scripts\common\utility::allow_ads(1);
      self.player scripts\common\utility::allow_reload(1);
      break;
    case "_encstr_B6CC0586B78D46":
      self.player scripts\common\utility::allow_fire(0);
      self.player scripts\common\utility::allow_ads(0);
      self.player scripts\common\utility::allow_reload(0);
      break;
  }
}