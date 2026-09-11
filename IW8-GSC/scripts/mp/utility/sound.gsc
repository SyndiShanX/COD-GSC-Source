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

function playsoundonplayers(var0, var1, var2) {
  if(level.splitscreen) {
    if(isDefined(level.players[0])) {
      level.players[0] playlocalsound(var0);
      return;
    }

    return;
  }

  if(isDefined(var1)) {
    if(isDefined(var2)) {
      for(var3 = 0; var3 < level.players.size; var3++) {
        var4 = level.players[var3];

        if(var4 issplitscreenplayer() && !var4 issplitscreenplayerprimary()) {
          continue;
        }

        if(isDefined(var4.pers["team"]) && var4.pers["team"] == var1 && !scripts\engine\utility::array_contains(var2, var4)) {
          var4 playlocalsound(var0);
        }
      }

      return;
    }

    for(var3 = 0; var3 < level.players.size; var3++) {
      var4 = level.players[var3];

      if(var4 issplitscreenplayer() && !var4 issplitscreenplayerprimary()) {
        continue;
      }

      if(isDefined(var4.pers["team"]) && var4.pers["team"] == var3) {
        var4 playlocalsound(var2);
      }
    }

    return;
  }

  if(isDefined(var3)) {
    for(var3 = 0; var3 < level.players.size; var3++) {
      if(level.players[var3] issplitscreenplayer() && !level.players[var3] issplitscreenplayerprimary()) {
        continue;
      }

      if(!scripts\engine\utility::array_contains(var3, level.players[var3])) {
        level.players[var3] playlocalsound(var3);
      }
    }

    return;
  }

  for(var3 = 0; var3 < level.players.size; var3++) {
    if(level.players[var3] issplitscreenplayer() && !level.players[var3] issplitscreenplayerprimary()) {
      continue;
    }

    level.players[var3] playlocalsound(var4);
  }
}

function play_sound_on_entity(var0, var1) {
  play_sound_on_tag(var0);
}

function play_sound_on_tag(var0, var1) {
  if(isDefined(var1)) {
    playsoundatpos(self gettagorigin(var1), var0);
    return;
  }

  playsoundatpos(self.origin, var0);
}

function playplayerandnpcsounds(var0, var1, var2) {
  var0 playlocalsound(var1);
  var0 playSound(var2, var0);
}

function playdeathsound(var0) {
  if(istrue(level.ref_133b4) || var0 == "MOD_EXECUTION") {
    return;
  }

  var1 = randomintrange(1, 8);
  var2 = "generic";

  if(scripts\mp\utility\player::isfemale()) {
    var2 = "female";
  }

  if(var0 == "MOD_FALLING" || var0 == "MOD_SUICIDE" && isPlayer(self)) {
    if(self.team == "axis") {
      playplayerandnpcsounds(self, "plr_death_explosion", var2 + "_death_russian_" + var1);
      return;
    }

    playplayerandnpcsounds(self, "plr_death_explosion", var2 + "_death_american_" + var1);
    return;
  }

  if(istrue(self.iszombie) || istrue(level.setplayerselfrevivingextrainfo) && level.gametype == "infect" && self.team == "axis") {
    playplayerandnpcsounds(self, "zmb_death_generic", "zmb_npc_death_generic");
    return;
  }

  if(isPlayer(self)) {
    if(self.team == "axis") {
      playplayerandnpcsounds(self, "plr_death_generic", var2 + "_death_russian_" + var1);
      return;
    }

    playplayerandnpcsounds(self, "plr_death_generic", var2 + "_death_american_" + var1);
    return;
  }

  if(self.team == "axis") {
    self playSound(var2 + "_death_russian_" + var1);
    return;
  }

  self playSound(var2 + "_death_american_" + var1);
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

function besttime(var0) {
  any_player_nearby_same_floor();

  if(isDefined(level.amounttotal[var0])) {
    return;
  }

  level.ammotype settransientsoundbank(var0 + ".all", 1);
  level.amounttotal[var0] = level.amounttotal.size;
}

function ref_12c2a(var0) {
  any_player_nearby_same_floor();

  if(isDefined(level.amounttotal[var0])) {
    level.ammotype settransientsoundbank(var0 + ".all", 0);
    level.amounttotal[var0] = undefined;
    return;
  }
}