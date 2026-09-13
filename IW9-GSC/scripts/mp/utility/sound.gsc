/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\sound.gsc
***********************************************/

exploder_sound() {
  if(isDefined(self.script_delay))
    wait(self.script_delay);

  self playSound(level.scr_sound[self.script_sound]);
}

playsoundonplayers(sound, team, _id_21D6D994B0F4FAF1) {
  if(level.splitscreen) {
    if(isDefined(level.players[0]))
      level.players[0] playlocalsound(sound);
  } else if(isDefined(team)) {
    if(isDefined(_id_21D6D994B0F4FAF1)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
        player = level.players[_id_AC0E594AC96AA3A8];

        if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
          continue;
        }
        if(isDefined(player.pers["team"]) && player.pers["team"] == team && !scripts\engine\utility::array_contains(_id_21D6D994B0F4FAF1, player))
          player playlocalsound(sound);
      }

      return;
    }

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      player = level.players[_id_AC0E594AC96AA3A8];

      if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
        continue;
      }
      if(isDefined(player.pers["team"]) && player.pers["team"] == team)
        player playlocalsound(sound);
    }

    return;
  } else if(isDefined(_id_21D6D994B0F4FAF1)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      if(level.players[_id_AC0E594AC96AA3A8] issplitscreenplayer() && !level.players[_id_AC0E594AC96AA3A8] issplitscreenplayerprimary()) {
        continue;
      }
      if(!scripts\engine\utility::array_contains(_id_21D6D994B0F4FAF1, level.players[_id_AC0E594AC96AA3A8]))
        level.players[_id_AC0E594AC96AA3A8] playlocalsound(sound);
    }
  } else {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      if(level.players[_id_AC0E594AC96AA3A8] issplitscreenplayer() && !level.players[_id_AC0E594AC96AA3A8] issplitscreenplayerprimary()) {
        continue;
      }
      level.players[_id_AC0E594AC96AA3A8] playlocalsound(sound);
    }
  }
}

play_sound_on_entity(alias, _id_B426F32755673BA6) {
  play_sound_on_tag(alias);
}

play_sound_on_tag(alias, tag) {
  if(isDefined(tag))
    playsoundatpos(self gettagorigin(tag), alias);
  else
    playsoundatpos(self.origin, alias);
}

playdeathsound(meansofdeath) {
  if(istrue(level._id_9D615A366EC2FB6F) || meansofdeath == "MOD_EXECUTION") {
    return;
  }
  _id_00AE14C5A8B1B582 = randomintrange(1, 8);
  type = "generic";

  if(scripts\mp\utility\player::isfemale())
    type = "female";

  if(meansofdeath == "MOD_FALLING" || meansofdeath == "MOD_SUICIDE" && isPlayer(self)) {
    if(self.team == "axis")
      scripts\cp_mp\utility\player_utility::playplayerandnpcsounds(self, "plr_death_explosion", type + "_death_russian_" + _id_00AE14C5A8B1B582);
    else
      scripts\cp_mp\utility\player_utility::playplayerandnpcsounds(self, "plr_death_explosion", type + "_death_american_" + _id_00AE14C5A8B1B582);
  } else if(isPlayer(self)) {
    if(self.team == "axis")
      scripts\cp_mp\utility\player_utility::playplayerandnpcsounds(self, "plr_death_generic", type + "_death_russian_" + _id_00AE14C5A8B1B582);
    else
      scripts\cp_mp\utility\player_utility::playplayerandnpcsounds(self, "plr_death_generic", type + "_death_american_" + _id_00AE14C5A8B1B582);
  } else if(self.team == "axis")
    self playSound(type + "_death_russian_" + _id_00AE14C5A8B1B582);
  else
    self playSound(type + "_death_american_" + _id_00AE14C5A8B1B582);
}

_id_7CF31218D8D83AAF() {
  if(!isarray(level._id_30649350266F97C8))
    level._id_30649350266F97C8 = [];

  if(!isent(level._id_6F72B465B2081001))
    level._id_6F72B465B2081001 = spawn("sound_transient_soundbanks", (0, 0, 0));
}

_id_39467625717D8D27(name) {
  _id_7CF31218D8D83AAF();

  if(isDefined(level._id_30649350266F97C8[name])) {
    return;
  }
  level._id_6F72B465B2081001 settransientsoundbank(name + ".all", 1);
  level._id_30649350266F97C8[name] = level._id_30649350266F97C8.size;
  return;
}

_id_A6357559500EE9FE(name) {
  _id_7CF31218D8D83AAF();

  if(isDefined(level._id_30649350266F97C8[name])) {
    level._id_6F72B465B2081001 settransientsoundbank(name + ".all", 0);
    level._id_30649350266F97C8[name] = undefined;
  } else {}
}