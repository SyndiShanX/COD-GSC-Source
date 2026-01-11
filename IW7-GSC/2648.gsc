/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2648.gsc
***************************************/

mt_getprogress(var_00) {
  return self getrankedplayerdata("cp", "meritProgress", var_00);
}

mt_getstate(var_00) {
  return self getrankedplayerdata("cp", "meritState", var_00);
}

mt_setprogress(var_00, var_01) {
  if(var_00 == "mt_highest_round") {
    var_02 = mt_getstate("mt_highest_round");
    var_03 = mt_gettarget("mt_highest_round", var_02);

    if(level.wave_num >= var_03) {
      return self setrankedplayerdata("cp", "meritProgress", var_00, var_03);
    }
  } else
    return self setrankedplayerdata("cp", "meritProgress", var_00, var_01);
}

mt_setstate(var_00, var_01) {
  return self setrankedplayerdata("cp", "meritState", var_00, var_01);
}

mt_gettarget(var_00, var_01) {
  return int(tablelookup("cp\allMeritsTable.csv", 0, var_00, 10 + var_01 * 3));
}

playpainoverlay(var_00, var_01, var_02) {
  if(scripts\cp\utility::isusingremote() && scripts\engine\utility::is_true(self.vanguard_num)) {
    return;
  }
  var_03 = get_damage_direction(var_02);

  if(is_spitter_spit(var_01)) {
    play_spitter_pain_overlay(var_03);
  }
  else if(is_spitter_gas(var_01)) {
    play_spitter_pain_overlay("center");
  }
  else if(is_elite_attack(var_00)) {
    playfxontagforclients(level._effect["vfx_melee_blood_spray"], self, "tag_eye", self);
  }
  else {
    play_basic_pain_overlay(var_03);
  }
}

get_damage_direction(var_00) {
  var_01 = 0.965;
  var_02 = ["left", "center", "right"];

  if(!isDefined(var_00)) {
    return var_2[randomint(var_2.size)];
  }

  var_00 = var_00 * -1;
  var_03 = anglesToForward(self.angles);
  var_04 = vectordot(var_00, var_03);

  if(var_04 > var_01) {
    return "center";
  }

  var_05 = anglestoright(self.angles);
  var_06 = vectordot(var_00, var_05);

  if(var_06 > 0) {
    return "right";
  }
  else {
    return "left";
  }
}

is_spitter_spit(var_00) {
  if(!isDefined(var_00)) {
    return 0;
  }

  return var_00 == "alienspit_mp";
}

is_spitter_gas(var_00) {
  if(!isDefined(var_00)) {
    return 0;
  }

  return var_00 == "alienspit_gas_mp";
}

is_elite_attack(var_00) {
  if(!isDefined(var_00) || !var_00 scripts\cp\cp_agent_utils::is_alien_agent()) {
    return 0;
  }

  return scripts\cp\cp_agent_utils::get_agent_type(var_00) == "elite";
}

play_spitter_pain_overlay(var_00) {
  if(!scripts\cp\utility::has_tag(self.model, "tag_eye")) {
    return;
  }
  if(var_00 == "left") {
    playfxontagforclients(level._effect["vfx_alien_spitter_hit_left"], self, "tag_eye", self);
  }
  else if(var_00 == "center") {
    playfxontagforclients(level._effect["vfx_alien_spitter_hit_center"], self, "tag_eye", self);
  }
  else if(var_00 == "right") {
    playfxontagforclients(level._effect["vfx_alien_spitter_hit_right"], self, "tag_eye", self);
  }
  else {}
}

play_basic_pain_overlay(var_00) {
  var_01 = self;

  if(!isDefined(self.model) || self.model == "") {
    return;
  }
  if(!scripts\cp\utility::has_tag(self.model, "tag_eye")) {
    return;
  }
  if(var_00 == "left") {
    playfxontagforclients(level._effect["vfx_blood_hit_left"], var_01, "tag_eye", self);
  }
  else if(var_00 == "center") {
    playfxontagforclients(level._effect["vfx_melee_blood_spray"], var_01, "tag_eye", self);
  }
  else if(var_00 == "right") {
    playfxontagforclients(level._effect["vfx_blood_hit_right"], var_01, "tag_eye", self);
  }
  else {}
}

zom_player_damage_flash() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self setclientomnvarbit("player_damaged", 1, 1);
  wait 0.05;
  self setclientomnvarbit("player_damaged", 1, 0);
}

zom_player_health_overlay_watcher() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self setclientomnvarbit("player_damaged", 2, 0);
  var_00 = 0;
  var_01 = 1;

  for(;;) {
    if(self.health <= 45 && var_00 == 0) {
      if(!self issplitscreenplayer()) {
        self setclienttriggeraudiozonepartialwithfade("painvision_cp", 0.02, "mix", "reverb", "filter");
      }

      var_00 = 1;
    }

    if(var_00 && var_01) {
      if(!scripts\cp\cp_laststand::player_in_laststand(self)) {
        self setclientomnvarbit("player_damaged", 2, 1);
      }

      var_01 = 0;
    }

    if(var_00 && self.health > 45) {
      self clearclienttriggeraudiozone(0.3);
      var_00 = 0;
      self setclientomnvarbit("player_damaged", 2, 0);
      var_01 = 1;
    }

    wait 0.05;
  }
}

introscreen_corner_line(var_00, var_01) {
  if(!isDefined(level.intro_offset)) {
    level.intro_offset = 0;
  }
  else {
    level.intro_offset++;
  }

  var_02 = cornerline_height();
  var_03 = 1.6;

  if(level.splitscreen) {
    var_03 = 2;
  }

  var_04 = newhudelem();
  var_4.x = 20;
  var_4.y = var_02;
  var_4.alignx = "left";
  var_4.aligny = "bottom";
  var_4.horzalign = "left";
  var_4.vertalign = "bottom";
  var_4.sort = 3;
  var_4.foreground = 1;
  var_04 give_zap_perk(var_00);
  var_4.alpha = 1;
  var_4.hidewheninmenu = 1;
  var_4.fontscale = var_03;
  var_4.color = (0.8, 1, 0.8);
  var_4.font = "default";
  var_4.glowcolor = (0.3, 0.6, 0.3);
  var_4.glowalpha = 1;
  return var_04;
}

cornerline_height() {
  var_00 = -92;

  if(level.splitscreen) {
    var_00 = -110;
  }

  return level.intro_offset * 20 - 92;
}