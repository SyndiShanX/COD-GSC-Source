/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\sound.gsc
***********************************************/

function exploder_sound() {
  if(isDefined(self.script_delay)) {
    wait self.script_delay;
  }

  self playSound(level.scr_sound[self.script_sound]);
}

function playsoundonplayers(var_0, var_1, var_2) {
  if(level.splitscreen) {
    if(isDefined(level.players[0])) {
      level.players[0] playlocalsound(var_0);
      return;
    }

    return;
  }

  if(isDefined(var_1)) {
    if(isDefined(var_2)) {
      for(var_3 = 0; var_3 < level.players.size; var_3++) {
        var_4 = level.players[var_3];

        if(var_4 issplitscreenplayer() && !var_4 issplitscreenplayerprimary()) {
          continue;
        }

        if(isDefined(var_4.pers["team"]) && var_4.pers["team"] == var_1 && !scripts\engine\utility::array_contains(var_2, var_4)) {
          var_4 playlocalsound(var_0);
        }
      }

      return;
    }

    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      var_4 = level.players[var_3];

      if(var_4 issplitscreenplayer() && !var_4 issplitscreenplayerprimary()) {
        continue;
      }

      if(isDefined(var_4.pers["team"]) && var_4.pers["team"] == var_3) {
        var_4 playlocalsound(var_2);
      }
    }

    return;
  }

  if(isDefined(var_3)) {
    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      if(level.players[var_3] issplitscreenplayer() && !level.players[var_3] issplitscreenplayerprimary()) {
        continue;
      }

      if(!scripts\engine\utility::array_contains(var_3, level.players[var_3])) {
        level.players[var_3] playlocalsound(var_3);
      }
    }

    return;
  }

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    if(level.players[var_3] issplitscreenplayer() && !level.players[var_3] issplitscreenplayerprimary()) {
      continue;
    }

    level.players[var_3] playlocalsound(var_4);
  }
}

function play_sound_on_entity(var_0, var_1) {
  play_sound_on_tag(var_0);
}

function play_sound_on_tag(var_0, var_1) {
  if(isDefined(var_1)) {
    playsoundatpos(self gettagorigin(var_1), var_0);
    return;
  }

  playsoundatpos(self.origin, var_0);
}

function playplayerandnpcsounds(var_0, var_1, var_2) {
  var_0 playlocalsound(var_1);
  var_0 playSound(var_2, var_0);
}

function playdeathsound(var_0) {
  if(istrue(level.ref_133B4) || var_0 == "MOD_EXECUTION") {
    return;
  }

  var_1 = randomintrange(1, 8);
  var_2 = "generic";

  if(scripts\mp\utility\player::isfemale()) {
    var_2 = "female";
  }

  if(var_0 == "MOD_FALLING" || var_0 == "MOD_SUICIDE" && isPlayer(self)) {
    if(self.team == "axis") {
      playplayerandnpcsounds(self, "plr_death_explosion", var_2 + "_death_russian_" + var_1);
      return;
    }

    playplayerandnpcsounds(self, "plr_death_explosion", var_2 + "_death_american_" + var_1);
    return;
  }

  if(istrue(self.iszombie) || istrue(level.setplayerselfrevivingextrainfo) && level.gametype == "infect" && self.team == "axis") {
    playplayerandnpcsounds(self, "zmb_death_generic", "zmb_npc_death_generic");
    return;
  }

  if(isPlayer(self)) {
    if(self.team == "axis") {
      playplayerandnpcsounds(self, "plr_death_generic", var_2 + "_death_russian_" + var_1);
      return;
    }

    playplayerandnpcsounds(self, "plr_death_generic", var_2 + "_death_american_" + var_1);
    return;
  }

  if(self.team == "axis") {
    self playSound(var_2 + "_death_russian_" + var_1);
    return;
  }

  self playSound(var_2 + "_death_american_" + var_1);
}

function any_player_nearby_same_floor() {
  if(!isarray(level.amounttotal)) {
    level.amounttotal = [];
  }

  if(!isent(level.ammotype)) {
    level.ammotype = spawn("sound_transient_soundbanks", (0, 0, 0));
    return;
  }
}

function besttime(var_0) {
  any_player_nearby_same_floor();

  if(isDefined(level.amounttotal[var_0])) {
    return;
  }

  level.ammotype settransientsoundbank(var_0 + ".all", 1);
  level.amounttotal[var_0] = level.amounttotal.size;
}

function ref_12C2A(var_0) {
  any_player_nearby_same_floor();

  if(isDefined(level.amounttotal[var_0])) {
    level.ammotype settransientsoundbank(var_0 + ".all", 0);
    level.amounttotal[var_0] = undefined;
    return;
  }
}