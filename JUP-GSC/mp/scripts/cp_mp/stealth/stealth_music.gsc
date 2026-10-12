/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\stealth\stealth_music.gsc
***************************************************/

#using scripts\cp_mp\stealth\utility;
#using scripts\engine\utility;
#using scripts\stealth\player;
#namespace stealth_music;

function main() {
  childthread stealth_combat_music_init();
}

function stealth_combat_music_init() {
  flag_wait("level_stealth_initialized");
  setDvar(@ "hash_4a4de8b30c5647a8", 1);
  level.music_array[0] = "a";
  level.music_array[1] = "b";
  level.music_array[2] = "c";

  if(getdvarint(@ "hash_f5740209893cdf46", 0) == 0) {
    level.stealth.fnthreatsightplayersightaudio = &threat_sight_player_sight_audio;
    level notify("threat_sight_audio_enabled");
  }

  level.hvts_identified = 0;

  if(scripts\engine\utility::issharedfuncdefined("stealth_music", "init")) {
    [[scripts\engine\utility::getsharedfunc("stealth_music", "init")]]();
  }
}

function function_9ff225017ef5ce19() {
  if(!isDefined(self.stealth)) {
    return;
  }

  player = self;

  if(istrue(player.processed_key)) {
    return;
  }

  if(getdvarint(@ "hash_f5740209893cdf46", 0)) {
    player thread function_f17fb237c7e883b2();
  }

  player.fnstealthmusictransition = &stealth_music_transition_cp;
  player.stealth.fnthreatsightplayersightaudio = &threat_sight_player_sight_audio;
  player ent_flag_init("player_in_combat");
  player thread scripts\stealth\player::combatstate_thread();
  player.processed_key = 1;
  player.stealth.combatstate.maxcombatdist = 2000;
  player.stealth_combat_music_state = player.stealth.combatstate.name;
  player.stealth_combat_music_state_type = player.stealth.combatstate.type;
  player.music_last_stealth_cue = "";
}

function function_9d95291bb222ad5f(message, delay) {
  self endon(message);
  wait delay;
  ent_flag_clear(message);
}

function stealth_music_transition_cp(aliasto) {
  self notify("stealth_music_transition_cp");
  self endon("stealth_music_transition_cp");
  self endon("disconnect");
  assert(isPlayer(self));

  if(!isDefined(self.stealth)) {
    thread scripts\stealth\player::main();
  }

  if(istrue(level.var_c04ee29c854b01b8)) {
    level.var_c04ee29c854b01b8 = undefined;
    return;
  }

  if(!isDefined(self.currentalias)) {
    self.currentalias = "init";
  }

  transitiontime = 1;
  frametime = 0.05;

  if(!isDefined(self.stealth.music_ent)) {
    self.stealth.music_ent = [];
  }

  alias = aliasto;

  if(!isDefined(aliasto)) {
    self setplayermusicstate("");
    self.currentalias = "";
    return;
  }

  if(aliasto != self.currentalias) {
    thread player_music_loop(alias);
    return;
  }

  self setplayermusicstate("");
  self.currentalias = "";
}

function player_music_loop(music_state) {
  self notify("player_music_loop");
  self endon("player_music_loop");
  self endon("disconnect");

  if(self.currentalias != "init" && music_state == "") {
    self setplayermusicstate("");
  }

  self.currentalias = music_state;

  if(isDefined(music_state) && music_state != "" && music_state != "init") {
    self setplayermusicstate(music_state);

    if(!istrue(level.var_4f2ab335ef95e1e3)) {
      wait 60;
      self setplayermusicstate("");
      self.currentalias = "";
    }
  }
}

function threat_sight_player_sight_audio(anycansee, maxthreat, willdebugprint) {
  var_1d73b1caa088a858 = 180;
  var_732bd773132e7010 = 0.01;
  var_37b64319146d2f02 = 0.05;
  var_bdd51df6b28827ee = 0.125;
  self endon("disconnect");
  self endon("death");
  self notify("threat_sight_player_sight_audio");
  self endon("threat_sight_player_sight_audio");
  level endon("threat_sight_audio_disabled");

  if(!isDefined(willdebugprint)) {
    willdebugprint = 0;
  }

  aliases = ["cp_stealth_threat_low", "cp_stealth_threat_med", "cp_stealth_threat_high"];
  rumble = "damage_light";

  if(!getdvarint(@ "hash_21b72d8c9ff7a1b3", 0)) {
    maxthreat = 0;
  }

  if(!isDefined(self.stealth.threat_sight_snd_ent) && anycansee && maxthreat > 0) {
    self.stealth.threat_sight_snd_ent = [];
    self.stealth.threat_sight_snd_vol = 0;
    self.stealth.threat_sight_snd_threat = 0;

    foreach(index, alias in aliases) {
      snd_ent = spawn("script_origin", self.origin);

      if(!isPlayer(self)) {
        thread scripts\engine\utility::delete_on_death(snd_ent);
      } else {
        snd_ent showonlytoplayer(self);
      }

      snd_ent linkTo(self);

      if(isPlayer(self)) {
        self setsoundsubmix(alias, 0, 1);
      }

      snd_ent.isplaying = 0;
      self.stealth.threat_sight_snd_ent[alias] = snd_ent;
    }
  }

  if(willdebugprint) {
    printtoscreen2d(32, 492, "<dev string:x1c>" + maxthreat + "<dev string:x2d>" + anycansee + "<dev string:x33>", (1, 1, 1), 1.5);
  }

  if(isDefined(self.stealth.threat_sight_snd_ent)) {
    self.stealth.threat_sight_snd_threat -= self.stealth.threat_sight_snd_threat * var_bdd51df6b28827ee;
    self.stealth.threat_sight_snd_threat += maxthreat * var_bdd51df6b28827ee;

    if(self.stealth.threat_sight_snd_threat < 0.0001) {
      self.stealth.threat_sight_snd_threat = 0;
    }

    maxthreat = self.stealth.threat_sight_snd_threat;
  }

  while(isDefined(self.stealth.threat_sight_snd_ent)) {
    index = 0;
    var_cfaeeea72851152d = 0;

    if(maxthreat > 0) {
      var_1cda86eccb821ec6 = function_8ba164c5a84fbb48(self);

      if(maxthreat < var_37b64319146d2f02) {
        threat_clamped = clamp(maxthreat, 0, var_37b64319146d2f02);
        mu = threat_clamped / var_37b64319146d2f02;
        vol_delta = 1 - var_732bd773132e7010;
        vol_lerp = var_732bd773132e7010 + vol_delta * mu;
        self.stealth.threat_sight_snd_vol = vol_lerp;
      } else {
        self.stealth.threat_sight_snd_vol = 1;
      }
    } else {
      self.stealth.threat_sight_snd_vol = 0;
      self.stealth.threat_sight_snd_threat = 0;
    }

    self.stealth.threat_sight_snd_vol = clamp(self.stealth.threat_sight_snd_vol, 0, 1);

    if(willdebugprint) {
      printtoscreen2d(32, 508, "<dev string:x38>" + self.stealth.threat_sight_snd_threat, (1, 1, 1), 1.5);
    }

    if(willdebugprint) {
      printtoscreen2d(32, 524, "<dev string:x49>" + self.stealth.threat_sight_snd_vol, (1, 1, 1), 1.5);
    }

    foreach(alias, snd_ent in self.stealth.threat_sight_snd_ent) {
      coef = 1;

      switch (index) {
        case 0:
          if(maxthreat < 0.75) {
            coef = cos(var_1d73b1caa088a858 * maxthreat * 0.666);
          } else {
            coef = 0;
          }

          break;
        case 1:
          if(maxthreat < 0.75) {
            coef = sin(var_1d73b1caa088a858 * maxthreat * 0.666);
          } else if(maxthreat < 1) {
            coef = sin(var_1d73b1caa088a858 * (1 - maxthreat) * 2);
          } else {
            coef = 0;
          }

          break;
        case 2:
          if(maxthreat < 0.75) {
            coef = 0;
          } else {
            coef = cos(var_1d73b1caa088a858 * (1 - maxthreat) * 2);
          }

          break;
      }

      vol = clamp(self.stealth.threat_sight_snd_vol * coef, 0, 1);

      if(anycansee) {
        var_cfaeeea72851152d = 1;

        if(snd_ent.isplaying == 0) {
          if(isPlayer(self)) {
            self setsoundsubmix(alias, 0, 1);
          }

          snd_ent scripts\engine\utility::delaycall(0.1, &playloopsound, alias);
          snd_ent.isplaying = 1;
          self playrumblelooponentity(rumble);
        }

        var_89c3e14196949443 = (vol - 1) * -1;

        if(isPlayer(self)) {
          self scalesoundsubmix(alias, var_89c3e14196949443);
        }
      } else if(snd_ent.isplaying == 1) {
        if(isPlayer(self)) {
          self setsoundsubmix(alias, 1, 1);
        }

        snd_ent scripts\engine\utility::delaycall(1, &stoploopsound);
        snd_ent.isplaying = 0;
        self stoprumble(rumble);
      }

      if(willdebugprint) {
        printtoscreen2d(32, 540 + index * 16, "<dev string:x5a>" + index + "<dev string:x64>" + vol, (1, 1, 1), 1.5);
      }

      if(willdebugprint) {
        printtoscreen2d(384, 540 + index * 16, "<dev string:x6e>" + coef, (1, 1, 1), 1.5);
      }

      index++;
    }

    if(!var_cfaeeea72851152d) {
      foreach(alias, snd_ent in self.stealth.threat_sight_snd_ent) {
        if(isPlayer(self)) {
          self setsoundsubmix(alias, 1, 1);
        }

        snd_ent scripts\engine\utility::delaycall(0.9, &stoploopsound);
        snd_ent scripts\engine\utility::delaycall(1, &delete);
      }

      self.stealth.threat_sight_snd_ent = undefined;
      self.stealth.threat_sight_snd_vol = undefined;
      self.stealth.threat_sight_snd_threat = undefined;
    }

    wait 0.25;
  }
}

function function_f17fb237c7e883b2() {
  level endon("kill_spotted_sound_thread");

  while(true) {
    self waittill("stealth_hud_updated");

    if(!istrue(self.var_27c032d9c1b0d6a2)) {
      self setplayermusicstate("mx_cp_hydro_stealth_hidden");
      self.var_27c032d9c1b0d6a2 = 1;

      while(flag("stealth_spotted")) {
        waitframe();
      }

      self.var_27c032d9c1b0d6a2 = undefined;
    }
  }
}