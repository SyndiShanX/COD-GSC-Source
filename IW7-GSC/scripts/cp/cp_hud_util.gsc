/**************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\cp_hud_util.gsc
**************************************/

mt_getprogress(param_00) {
  return self getplayerdata("cp", "meritProgress", param_00);
}

mt_getstate(param_00) {
  return self getplayerdata("cp", "meritState", param_00);
}

mt_setprogress(param_00, param_01) {
  if(param_00 == "mt_highest_round") {
    var_02 = mt_getstate("mt_highest_round");
    var_03 = mt_gettarget("mt_highest_round", var_02);
    if(level.wave_num >= var_03) {
      return self setplayerdata("cp", "meritProgress", param_00, var_03);
    }

    return;
  }

  return self setplayerdata("cp", "meritProgress", var_02, var_03);
}

mt_setstate(param_00, param_01) {
  return self setplayerdata("cp", "meritState", param_00, param_01);
}

mt_gettarget(param_00, param_01) {
  return int(tablelookup("cp\allMeritsTable.csv", 0, param_00, 10 + param_01 * 3));
}

playpainoverlay(param_00, param_01, param_02) {
  if(scripts\cp\utility::isusingremote() && scripts\engine\utility::istrue(self.vanguard_num)) {
    return;
  }

  var_03 = get_damage_direction(param_02);
  if(is_spitter_spit(param_01)) {
    play_spitter_pain_overlay(var_03);
    return;
  }

  if(is_spitter_gas(param_01)) {
    play_spitter_pain_overlay("center");
    return;
  }

  if(is_elite_attack(param_00)) {
    playfxontagforclients(level._effect["vfx_melee_blood_spray"], self, "tag_eye", self);
    return;
  }

  play_basic_pain_overlay(var_03);
}

get_damage_direction(param_00) {
  var_01 = 0.965;
  var_02 = ["left", "center", "right"];
  if(!isDefined(param_00)) {
    return var_02[randomint(var_02.size)];
  }

  param_00 = param_00 * -1;
  var_03 = anglesToForward(self.angles);
  var_04 = vectordot(param_00, var_03);
  if(var_04 > var_01) {
    return "center";
  }

  var_05 = anglestoright(self.angles);
  var_06 = vectordot(param_00, var_05);
  if(var_06 > 0) {
    return "right";
  }

  return "left";
}

is_spitter_spit(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  return param_00 == "alienspit_mp";
}

is_spitter_gas(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  return param_00 == "alienspit_gas_mp";
}

is_elite_attack(param_00) {
  if(!isDefined(param_00) || !param_00 scripts\cp\cp_agent_utils::is_alien_agent()) {
    return 0;
  }

  return scripts\cp\cp_agent_utils::get_agent_type(param_00) == "elite";
}

play_spitter_pain_overlay(param_00) {
  if(!scripts\cp\utility::has_tag(self.model, "tag_eye")) {
    return;
  }

  if(param_00 == "left") {
    playfxontagforclients(level._effect["vfx_alien_spitter_hit_left"], self, "tag_eye", self);
    return;
  }

  if(param_00 == "center") {
    playfxontagforclients(level._effect["vfx_alien_spitter_hit_center"], self, "tag_eye", self);
    return;
  }

  if(param_00 == "right") {
    playfxontagforclients(level._effect["vfx_alien_spitter_hit_right"], self, "tag_eye", self);
    return;
  }
}

play_basic_pain_overlay(param_00) {
  var_01 = self;
  if(!isDefined(self.model) || self.model == "") {
    return;
  }

  if(!scripts\cp\utility::has_tag(self.model, "tag_eye")) {
    return;
  }

  if(param_00 == "left") {
    playfxontagforclients(level._effect["vfx_blood_hit_left"], var_01, "tag_eye", self);
    return;
  }

  if(param_00 == "center") {
    playfxontagforclients(level._effect["vfx_melee_blood_spray"], var_01, "tag_eye", self);
    return;
  }

  if(param_00 == "right") {
    playfxontagforclients(level._effect["vfx_blood_hit_right"], var_01, "tag_eye", self);
    return;
  }
}

zom_player_damage_flash() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self setclientomnvarbit("player_damaged", 1, 1);
  wait(0.05);
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

    wait(0.05);
  }
}

introscreen_corner_line(param_00, param_01) {
  if(!isDefined(level.intro_offset)) {
    level.intro_offset = 0;
  } else {
    level.intro_offset++;
  }

  var_02 = cornerline_height();
  var_03 = 1.6;
  if(level.splitscreen) {
    var_03 = 2;
  }

  var_04 = newhudelem();
  var_04.x = 20;
  var_04.y = var_02;
  var_04.alignx = "left";
  var_04.aligny = "bottom";
  var_04.horzalign = "left";
  var_04.vertalign = "bottom";
  var_04.sort = 3;
  var_04.foreground = 1;
  var_04 settext(param_00);
  var_04.alpha = 1;
  var_04.hidewheninmenu = 1;
  var_04.fontscale = var_03;
  var_04.color = (0.8, 1, 0.8);
  var_04.font = "default";
  var_04.objective_delete = (0.3, 0.6, 0.3);
  var_04.objective_current_nomessage = 1;
  return var_04;
}

cornerline_height() {
  var_00 = -92;
  if(level.splitscreen) {
    var_00 = -110;
  }

  return level.intro_offset * 20 - 92;
}