/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\stealth\manager.gsc
***********************************************/

function main() {
  scripts\stealth\manager::main();
  level.stealth.fnplayerlootenabled = &scripts\sp\utility::playerlootenabled;
  level.stealth.fngetcorpseorigin = &scripts\engine\sp\utility::get_corpse_origin;
  level.stealth.fnsetbattlechatter = &scripts\engine\sp\utility::set_battlechatter;
  level.stealth.fnaddeventplaybcs = &scripts\anim\battlechatter::addeventplaybcs;
  level.stealth.fnanimgenericcustomanimmode = &scripts\sp\anim::anim_generic_custom_animmode;
  level.stealth.fnthreatsightsetstateparameters = &threat_sight_set_state_parameters;
  level.stealth.fnthreatsightplayersightaudio = &threat_sight_player_sight_audio;
  level.stealth.fnsetstealthmode = &set_stealth_mode_sp;
  level.stealth.cantracetoaiignoreents = [level.player];
  scripts\game\sp\stealth\manager::init();
  scripts\anim\battlechatter_table::bctable_setfiles("stealth", "sp/stealth_chatter_base.csv", "sp/stealth_chatter_ambient.csv");
}

function set_stealth_mode_sp(var0, var1, var2) {
  jumpiffalse(var0) LOC_00000038;

  foreach(var4 in level.players) {
    var4 thread scripts\sp\stealth\player::ambient_player_thread();
  }

  return;
}

function threat_sight_set_state_parameters(var0) {
  var1 = 1;
  var2 = 1;

  if(!isDefined(var0)) {
    var0 = self.stealth.threat_sight_state;
  }

  if(isDefined(self.stealth.threatsightratescale)) {
    var1 *= self.stealth.threatsightratescale;
  }

  if(isDefined(self.stealth.threatsightdistscale)) {
    var2 *= self.stealth.threatsightdistscale;
  }

  if(isDefined(level.stealth.threatsightratescale)) {
    var1 *= level.stealth.threatsightratescale;
  }

  if(isDefined(level.stealth.threatsightdistscale)) {
    var2 *= level.stealth.threatsightdistscale;
  }

  switch (var0) {
    case "flashlight_in_dark":
    case "investigate":
      self.threatsightdistmin = 256 * var2;
      self.threatsightdistmax = 1024 * var2;
      self.threatsightratemin = 1.333 * var1;
      self.threatsightratemax = 0.8 * var1;
      break;
    case "combat_hunt":
      self.threatsightdistmin = 64 * var2;
      self.threatsightdistmax = 128 * var2;
      self.threatsightratemin = 2.5 * var1;
      self.threatsightratemax = 2 * var1;
      break;
    default:
      self.threatsightdistmin = 256 * var2;
      self.threatsightdistmax = 1024 * var2;
      self.threatsightratemin = 1 * var1;
      self.threatsightratemax = 0.4 * var1;
      break;
  }
}

function threat_sight_player_sight_audio(var0, var1, var2) {
  var3 = 180;
  var4 = 0.01;
  var5 = 0.05;
  var6 = 0.125;
  self endon("disconnect");
  self endon("death");
  self notify("threat_sight_player_sight_audio");
  self endon("threat_sight_player_sight_audio");
  var7 = ["ui_stealth_threat_low_lp", "ui_stealth_threat_med_lp", "ui_stealth_threat_high_lp"];

  if(!getdvarint("scr_ai_threatsightaudio", 0)) {
    var1 = 0;
  }

  if(!isDefined(self.stealth.threat_sight_snd_ent) && var0 && var1 > 0) {
    self.stealth.threat_sight_snd_ent = [];
    self.stealth.threat_sight_snd_vol = 0;
    self.stealth.threat_sight_snd_threat = 0;

    foreach(var11, var9 in var7) {
      var10 = spawn("script_origin", self.origin);

      if(!isPlayer(self)) {
        thread scripts\engine\utility::delete_on_death(var10);
      }

      var10 linkTo(self);
      var10 scalevolume(0, 0);
      var10.isplaying = 0;
      self.stealth.threat_sight_snd_ent[var9] = var10;
    }
  }

  jumpiffalse(isDefined(self.stealth.threat_sight_snd_ent)) LOC_00000199;
  self.stealth.threat_sight_snd_threat -= self.stealth.threat_sight_snd_threat * var6;
  self.stealth.threat_sight_snd_threat += var1 * var6;

  if(self.stealth.threat_sight_snd_threat < 0.0001) {
    self.stealth.threat_sight_snd_threat = 0;
  }

  var1 = self.stealth.threat_sight_snd_threat;

  while(isDefined(self.stealth.threat_sight_snd_ent)) {
    var11 = 0;
    var12 = 0;

    if(var1 > 0) {
      if(isDefined(self.stealth.maxthreat_enemy)) {
        self.stealth.maxthreat_enemy thread scripts\stealth\utility::addeventplaybcs("stealth", "announce3", "sighted_warning" + randomintrange(1, 5));
      }

      if(var1 < var5) {
        var13 = clamp(var1, 0, var5);
        var14 = var13 / var5;
        var15 = 1 - var4;
        var16 = var4 + var15 * var14;
        self.stealth.threat_sight_snd_vol = var16;
      } else {
        self.stealth.threat_sight_snd_vol = 1;
      }
    } else {
      self.stealth.threat_sight_snd_vol = 0;
      self.stealth.threat_sight_snd_threat = 0;
    }

    self.stealth.threat_sight_snd_vol = clamp(self.stealth.threat_sight_snd_vol, 0, 1);

    foreach(var9, var10 in self.stealth.threat_sight_snd_ent) {
      var18 = 1;

      switch (var11) {
        case 0:
          if(var1 < 0.75) {
            var18 = cos(var3 * var1 * 0.666);
          } else {
            var18 = 0;
          }

          break;
        case 1:
          if(var1 < 0.75) {
            var18 = sin(var3 * var1 * 0.666);
          } else if(var1 < 1) {
            var18 = sin(var3 * (1 - var1) * 2);
          } else {
            var18 = 0;
          }

          break;
        case 2:
          if(var1 < 0.75) {
            var18 = 0;
          } else {
            var18 = cos(var3 * (1 - var1) * 2);
          }

          break;
      }

      var19 = clamp(self.stealth.threat_sight_snd_vol * var18, 0, 1);

      if(var19 > 0) {
        var12 = 1;

        if(var10.isplaying == 0) {
          var10 scalevolume(0, 0);
          var10 scripts\engine\utility::delaycall(0.05, &playloopsound, var9);
          var10.isplaying = 1;
        }

        var10 scalevolume(var19, 0.05);
        var10 scripts\engine\utility::delaycall(0, &scalevolume, var19, 0.05);
      } else if(var10.isplaying == 1) {
        var10 scalevolume(0, 0.05);
        var10 scripts\engine\utility::delaycall(0.05, &stoploopsound);
        var10.isplaying = 0;
      }

      var11++;
    }

    if(!var12) {
      foreach(var9, var10 in self.stealth.threat_sight_snd_ent) {
        var10 scalevolume(0, 0.05);
        var10 stoploopsound();
        var10 scripts\engine\utility::delaycall(0.05, &delete);
      }

      self.stealth.threat_sight_snd_ent = undefined;
      self.stealth.threat_sight_snd_vol = undefined;
      self.stealth.threat_sight_snd_threat = undefined;
    }

    wait 0.05;
  }
}