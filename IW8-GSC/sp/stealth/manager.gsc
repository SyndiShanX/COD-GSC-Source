/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\stealth\manager.gsc
***********************************************/

main() {
  scripts\stealth\manager::main();
  level.stealth.fnplayerlootenabled = scripts\sp\utility::playerlootenabled;
  level.stealth.fngetcorpseorigin = scripts\engine\sp\utility::get_corpse_origin;
  level.stealth.fnsetbattlechatter = scripts\engine\sp\utility::set_battlechatter;
  level.stealth.fnaddeventplaybcs = scripts\anim\battlechatter.gsc::addeventplaybcs;
  level.stealth.fnanimgenericcustomanimmode = scripts\sp\anim::anim_generic_custom_animmode;
  level.stealth.fnthreatsightsetstateparameters = ::threat_sight_set_state_parameters;
  level.stealth.fnthreatsightplayersightaudio = ::threat_sight_player_sight_audio;
  level.stealth.fnsetstealthmode = ::set_stealth_mode_sp;
  level.stealth.cantracetoaiignoreents = [level.player];
  scripts\game\sp\stealth\manager::init();
  scripts\anim\battlechatter_table.gsc::bctable_setfiles("stealth", "sp/stealth_chatter_base.csv", "sp/stealth_chatter_ambient.csv");
}

set_stealth_mode_sp(var_0, var_1, var_2) {
  if(var_0) {
    foreach(var_4 in level.players)
    var_4 thread scripts\sp\stealth\player::ambient_player_thread();
  } else {
    foreach(var_4 in level.players)
    var_4 thread scripts\sp\stealth\player::ambient_player_stop();
  }
}

threat_sight_set_state_parameters(var_0) {
  var_1 = 1.0;
  var_2 = 1.0;

  if(!isDefined(var_0))
    var_0 = self.stealth.threat_sight_state;

  if(isDefined(self.stealth.threatsightratescale))
    var_1 = var_1 * self.stealth.threatsightratescale;

  if(isDefined(self.stealth.threatsightdistscale))
    var_2 = var_2 * self.stealth.threatsightdistscale;

  if(isDefined(level.stealth.threatsightratescale))
    var_1 = var_1 * level.stealth.threatsightratescale;

  if(isDefined(level.stealth.threatsightdistscale))
    var_2 = var_2 * level.stealth.threatsightdistscale;

  switch (var_0) {
    case "flashlight_in_dark":
    case "investigate":
      self.threatsightdistmin = 256 * var_2;
      self.threatsightdistmax = 1024 * var_2;
      self.threatsightratemin = 1.333 * var_1;
      self.threatsightratemax = 0.8 * var_1;
      break;
    case "combat_hunt":
      self.threatsightdistmin = 64 * var_2;
      self.threatsightdistmax = 128 * var_2;
      self.threatsightratemin = 2.5 * var_1;
      self.threatsightratemax = 2.0 * var_1;
      break;
    default:
      self.threatsightdistmin = 256 * var_2;
      self.threatsightdistmax = 1024 * var_2;
      self.threatsightratemin = 1 * var_1;
      self.threatsightratemax = 0.4 * var_1;
      break;
  }
}

threat_sight_player_sight_audio(var_0, var_1, var_2) {
  var_3 = 180.0;
  var_4 = 0.01;
  var_5 = 0.05;
  var_6 = 0.125;
  self endon("disconnect");
  self endon("death");
  self notify("threat_sight_player_sight_audio");
  self endon("threat_sight_player_sight_audio");
  var_7 = ["ui_stealth_threat_low_lp", "ui_stealth_threat_med_lp", "ui_stealth_threat_high_lp"];

  if(!getdvarint("scr_ai_threatsightaudio", 0))
    var_1 = 0;

  if(!isDefined(self.stealth.threat_sight_snd_ent) && var_0 && var_1 > 0) {
    self.stealth.threat_sight_snd_ent = [];
    self.stealth.threat_sight_snd_vol = 0.0;
    self.stealth.threat_sight_snd_threat = 0.0;

    foreach(var_11, var_9 in var_7) {
      var_10 = spawn("script_origin", self.origin);

      if(!isPlayer(self))
        thread scripts\engine\utility::delete_on_death(var_10);

      var_10 linkTo(self);
      var_10 scalevolume(0, 0.0);
      var_10.isplaying = 0;
      self.stealth.threat_sight_snd_ent[var_9] = var_10;
    }
  }

  if(isDefined(self.stealth.threat_sight_snd_ent)) {
    self.stealth.threat_sight_snd_threat = self.stealth.threat_sight_snd_threat - self.stealth.threat_sight_snd_threat * var_6;
    self.stealth.threat_sight_snd_threat = self.stealth.threat_sight_snd_threat + var_1 * var_6;

    if(self.stealth.threat_sight_snd_threat < 0.0001)
      self.stealth.threat_sight_snd_threat = 0.0;

    var_1 = self.stealth.threat_sight_snd_threat;
  }

  while(isDefined(self.stealth.threat_sight_snd_ent)) {
    var_11 = 0;
    var_12 = 0;

    if(var_1 > 0) {
      if(isDefined(self.stealth.maxthreat_enemy))
        self.stealth.maxthreat_enemy thread scripts\stealth\utility::addeventplaybcs("stealth", "announce3", "sighted_warning" + randomintrange(1, 5));

      if(var_1 < var_5) {
        var_13 = clamp(var_1, 0, var_5);
        var_14 = var_13 / var_5;
        var_15 = 1.0 - var_4;
        var_16 = var_4 + var_15 * var_14;
        self.stealth.threat_sight_snd_vol = var_16;
      } else
        self.stealth.threat_sight_snd_vol = 1.0;
    } else {
      self.stealth.threat_sight_snd_vol = 0.0;
      self.stealth.threat_sight_snd_threat = 0.0;
    }

    self.stealth.threat_sight_snd_vol = clamp(self.stealth.threat_sight_snd_vol, 0.0, 1.0);

    foreach(var_9, var_10 in self.stealth.threat_sight_snd_ent) {
      var_18 = 1.0;

      switch (var_11) {
        case 0:
          if(var_1 < 0.75)
            var_18 = cos(var_3 * var_1 * 0.666);
          else
            var_18 = 0.0;

          break;
        case 1:
          if(var_1 < 0.75)
            var_18 = sin(var_3 * var_1 * 0.666);
          else if(var_1 < 1.0)
            var_18 = sin(var_3 * (1 - var_1) * 2.0);
          else
            var_18 = 0.0;

          break;
        case 2:
          if(var_1 < 0.75)
            var_18 = 0.0;
          else
            var_18 = cos(var_3 * (1 - var_1) * 2.0);

          break;
      }

      var_19 = clamp(self.stealth.threat_sight_snd_vol * var_18, 0.0, 1.0);

      if(var_19 > 0) {
        var_12 = 1;

        if(var_10.isplaying == 0) {
          var_10 scalevolume(0, 0.0);
          var_10 scripts\engine\utility::delaycall(0.05, ::playloopsound, var_9);
          var_10.isplaying = 1;
        }

        var_10 scalevolume(var_19, 0.05);
        var_10 scripts\engine\utility::delaycall(0.0, ::scalevolume, var_19, 0.05);
      } else if(var_10.isplaying == 1) {
        var_10 scalevolume(0, 0.05);
        var_10 scripts\engine\utility::delaycall(0.05, ::stoploopsound);
        var_10.isplaying = 0;
      }

      var_11++;
    }

    if(!var_12) {
      foreach(var_9, var_10 in self.stealth.threat_sight_snd_ent) {
        var_10 scalevolume(0, 0.05);
        var_10 stoploopsound();
        var_10 scripts\engine\utility::delaycall(0.05, ::delete);
      }

      self.stealth.threat_sight_snd_ent = undefined;
      self.stealth.threat_sight_snd_vol = undefined;
      self.stealth.threat_sight_snd_threat = undefined;
    }

    wait 0.05;
  }
}