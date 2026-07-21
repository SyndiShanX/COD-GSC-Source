/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_hud_util.gsc
***********************************************/

mt_getprogress(var_0) {
  return self getplayerdata("_encstr_850703B7D9", "_encstr_BAC20E3DE7F8488301E2ED5A92070273", var_0);
}

mt_getstate(var_0) {
  return self getplayerdata("_encstr_850703B7D9", "_encstr_882D0B6B599CA5E8D4D1B08E59", var_0);
}

mt_setprogress(var_0, var_1) {
  if(var_0 == "_encstr_BD0811933C91438BA7B2814B5B6F3E80B38E19") {
    var_2 = mt_getstate("_encstr_BD0811933C91438BA7B2814B5B6F3E80B38E19");
    var_3 = mt_gettarget("_encstr_BD0811933C91438BA7B2814B5B6F3E80B38E19", var_2);

    if(level.wave_num >= var_3)
      return self setplayerdata("_encstr_850703B7D9", "_encstr_BAC20E3DE7F8488301E2ED5A92070273", var_0, var_3);
  } else
    return self setplayerdata("_encstr_850703B7D9", "_encstr_BAC20E3DE7F8488301E2ED5A92070273", var_0, var_1);
}

mt_setstate(var_0, var_1) {
  return self setplayerdata("_encstr_850703B7D9", "_encstr_882D0B6B599CA5E8D4D1B08E59", var_0, var_1);
}

mt_gettarget(var_0, var_1) {
  return int(tablelookup("_encstr_8BA91663972D52A002388D7A10990751690B050D3AE327BB", 0, var_0, 10 + var_1 * 3));
}

playpainoverlay(var_0, var_1, var_2) {
  if(scripts\cp\utility::isusingremote() && istrue(self.vanguard_num)) {
    return;
  }
  var_3 = get_damage_direction(var_2);

  if(is_spitter_spit(var_1))
    play_spitter_pain_overlay(var_3);
  else if(is_spitter_gas(var_1))
    play_spitter_pain_overlay("_encstr_A5C407E1658D3339B3");
  else
    play_basic_pain_overlay(var_3);
}

get_damage_direction(var_0) {
  var_1 = 0.965;
  var_2 = ["_encstr_A5AD056A019C63", "_encstr_A5C407E1658D3339B3", "_encstr_8253060E2B5FE330"];

  if(!isDefined(var_0))
    return var_2[randomint(var_2.size)];

  var_0 = var_0 * -1;
  var_3 = anglesToForward(self.angles);
  var_4 = vectordot(var_0, var_3);

  if(var_4 > var_1)
    return "_encstr_A5C407E1658D3339B3";

  var_5 = anglestoright(self.angles);
  var_6 = vectordot(var_0, var_5);

  if(var_6 > 0)
    return "_encstr_8253060E2B5FE330";
  else
    return "_encstr_A5AD056A019C63";
}

is_spitter_spit(var_0) {
  if(!isDefined(var_0))
    return 0;

  return var_0 == "_encstr_ADEC0D3B2C7185B0BF90F9439157B0";
}

is_spitter_gas(var_0) {
  if(!isDefined(var_0))
    return 0;

  return var_0 == "_encstr_B65B110BD8B4B2376EE05A8ED7D92C9BBEB50E";
}

is_elite_attack(var_0) {
  if(!isDefined(var_0) || !var_0 scripts\cp\cp_agent_utils::is_alien_agent())
    return 0;

  return scripts\cp\cp_agent_utils::get_agent_type(var_0) == "_encstr_83AD06DDE1316B75";
}

play_spitter_pain_overlay(var_0) {
  if(!scripts\cp\utility::has_tag(self.model, "_encstr_A130084D2FDAD8AA8F62")) {
    return;
  }
  if(var_0 == "_encstr_A5AD056A019C63")
    playfxontagforclients(level._effect["_encstr_95E31BCECCC3D7C21BD2B273F537C15AE84756C9FA34B4D1FAD8B2338E"], self, "_encstr_A130084D2FDAD8AA8F62", self);
  else if(var_0 == "_encstr_A5C407E1658D3339B3")
    playfxontagforclients(level._effect["_encstr_B8B71DB3CCF0EB2CD84B5937BECD0ED2473A594EF50DA5A3FAD8CAE68E95C9"], self, "_encstr_A130084D2FDAD8AA8F62", self);
  else if(var_0 == "_encstr_8253060E2B5FE330")
    playfxontagforclients(level._effect["_encstr_935F1CB39987D72C1B4BB2CDEBDCC1D2D13AB293D71A4BE8BE39D23BA13A"], self, "_encstr_A130084D2FDAD8AA8F62", self);
  else {}
}

play_basic_pain_overlay(var_0) {
  var_1 = self;

  if(!isDefined(self.model) || self.model == "_encstr_B40101") {
    return;
  }
  if(!scripts\cp\utility::has_tag(self.model, "_encstr_A130084D2FDAD8AA8F62"))
    return;
}

_id_12480() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self setclientomnvar("_encstr_93EF107FE046D4A2630F1F97782B8B9DC8B0", self.damageeventcount);
}

zom_player_health_overlay_watcher() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_0 = 0;
  var_1 = 1;

  for(;;) {
    if(self.health <= 45 && var_0 == 0) {
      if(!self issplitscreenplayer()) {
        self setclienttriggeraudiozonepartialwithfade("_encstr_AD760B37569AD5CB6937B8905B", 0.02, "_encstr_AB1904853B28", "_encstr_BD940712ABD03FA35E", "_encstr_A9A80769FCC4081D93");
        self stoplocalsound("_encstr_8EC410035B3FCBE018966FB588C80FB28DC1");
        self playlocalsound("_encstr_AA6A0F3B8081C4325F10DF1560051991C8");
      }

      var_0 = 1;
    }

    if(var_0 && var_1) {
      if(!scripts\cp\cp_laststand::player_in_laststand(self)) {}

      var_1 = 0;
    }

    if(var_0 && self.health > 45) {
      self clearclienttriggeraudiozone(0.3);
      self playlocalsound("_encstr_8EC410035B3FCBE018966FB588C80FB28DC1");
      self stoplocalsound("_encstr_AA6A0F3B8081C4325F10DF1560051991C8");
      var_0 = 0;
      var_1 = 1;
    }

    wait 0.05;
  }
}

introscreen_corner_line(var_0, var_1) {
  if(!isDefined(level.intro_offset))
    level.intro_offset = 0;
  else
    level.intro_offset++;

  var_2 = cornerline_height();
  var_3 = 1.6;

  if(level.splitscreen)
    var_3 = 2;

  var_4 = newhudelem();
  var_4.x = 20;
  var_4.y = var_2;
  var_4.alignx = "_encstr_A5AD056A019C63";
  var_4.aligny = "_encstr_A146078E65FB5158DD";
  var_4.horzalign = "_encstr_A5AD056A019C63";
  var_4.vertalign = "_encstr_A146078E65FB5158DD";
  var_4.sort = 3;
  var_4.foreground = 1;
  var_4 settext(var_0);
  var_4.alpha = 1;
  var_4.hidewheninmenu = 1;
  var_4.fontscale = var_3;
  var_4.color = (0.8, 1, 0.8);
  var_4.font = "_encstr_8B1608EC43B8D647A113";
  var_4.glowcolor = (0.3, 0.6, 0.3);
  var_4.glowalpha = 1;
  return var_4;
}

cornerline_height() {
  var_0 = -92;

  if(level.splitscreen)
    var_0 = -110;

  return level.intro_offset * 20 - 92;
}

teamplayercardsplash(var_0, var_1, var_2, var_3, var_4) {
  if(level.hardcoremode) {
    return;
  }
  foreach(var_6 in level.players) {
    if(isDefined(var_2) && var_6.team != var_2) {
      continue;
    }
    if(!isPlayer(var_6)) {
      continue;
    }
    if(!isDefined(var_4))
      var_6 thread scripts\cp\cp_hud_message::showsplash(var_0, var_3, var_1);
  }
}