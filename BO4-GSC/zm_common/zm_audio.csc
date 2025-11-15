/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_audio.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\audio_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace zm_audio;

autoexec __init__system__() {
  system::register(#"zm_audio", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("allplayers", "charindex", 1, 4, "int", &charindex_cb, 0, 1);
  clientfield::register("toplayer", "isspeaking", 1, 1, "int", &isspeaking_cb, 0, 1);

  if(!isDefined(level.exert_sounds)) {
    level.exert_sounds = [];
  }

  level.exert_sounds[0][#"playerbreathinsound"] = "vox_exert_generic_inhale";
  level.exert_sounds[0][#"playerbreathoutsound"] = "vox_exert_generic_exhale";
  level.exert_sounds[0][#"playerbreathgaspsound"] = "vox_exert_generic_exhale";
  level.exert_sounds[0][#"falldamage"] = "vox_exert_generic_pain";
  level.exert_sounds[0][#"mantlesoundplayer"] = "vox_exert_generic_mantle";
  level.exert_sounds[0][#"meleeswipesoundplayer"] = "vox_exert_generic_knifeswipe";
  level.exert_sounds[0][#"dtplandsoundplayer"] = "vox_exert_generic_pain";
  callback::on_spawned(&on_player_spawned);
}

on_player_spawned(localclientnum) {}

delay_set_exert_id(newval) {
  self endon(#"death");
  self endon(#"sndendexertoverride");
  wait 0.5;
  self.player_exert_id = newval;
}

charindex_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!bnewent) {
    self.player_exert_id = newval;
    self._first_frame_exert_id_recieved = 1;
    self notify(#"sndendexertoverride");
    return;
  }

  if(!isDefined(self._first_frame_exert_id_recieved)) {
    self._first_frame_exert_id_recieved = 1;
    self thread delay_set_exert_id(newval);
  }
}

isspeaking_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!bnewent) {
    self.isspeaking = newval;
    return;
  }

  self.isspeaking = 0;
}

zmbmuslooper() {
  ent = spawn(0, (0, 0, 0), "script_origin");
  playSound(0, #"mus_zmb_gamemode_start", (0, 0, 0));
  wait 10;
  ent playLoopSound(#"mus_zmb_gamemode_loop", 0.05);
  ent thread waitfor_music_stop();
}

waitfor_music_stop() {
  level waittill(#"stpm");
  self stopallloopsounds(0.1);
  playSound(0, #"mus_zmb_gamemode_end", (0, 0, 0));
  wait 1;
  self delete();
}

playerfalldamagesound(client_num, firstperson) {
  self playerexert(client_num, "falldamage");
}

clientvoicesetup() {
  localclientnum = self getlocalclientnumber();
  self thread audio_player_connect(localclientnum);
}

audio_player_connect(localclientnum) {
  var_3d2dc382 = array("playerbreathinsound", "playerbreathoutsound", "playerbreathgaspsound", "mantlesoundplayer", "meleeswipesoundplayer");
  self thread sndvonotifyplain(localclientnum, var_3d2dc382);
  self thread sndvonotifydtp(localclientnum, "dtplandsoundplayer");
}

sndvonotifyplain(localclientnum, var_3d2dc382) {
  self notify("68e9879d130dec7b");
  self endon("68e9879d130dec7b");
  self endon(#"death");

  while(true) {
    s_result = self waittill(var_3d2dc382);

    if(isDefined(self.is_player_zombie) && self.is_player_zombie) {
      continue;
    }

    self playerexert(localclientnum, s_result._notify);
  }
}

playerexert(localclientnum, exert) {
  if(isDefined(self.isspeaking) && self.isspeaking == 1) {
    return;
  }

  if(isDefined(self.beast_mode) && self.beast_mode) {
    return;
  }

  if(exert === "meleeswipesoundplayer") {
    if(function_42e50d5()) {
      return;
    }
  }

  id = level.exert_sounds[0][exert];

  if(isarray(level.exert_sounds[0][exert])) {
    id = array::random(level.exert_sounds[0][exert]);
  }

  if(isDefined(self.player_exert_id) && isarray(level.exert_sounds) && isarray(level.exert_sounds[self.player_exert_id])) {
    if(isarray(level.exert_sounds[self.player_exert_id][exert])) {
      id = array::random(level.exert_sounds[self.player_exert_id][exert]);
    } else {
      id = level.exert_sounds[self.player_exert_id][exert];
    }
  }

  if(isDefined(id)) {
    self playSound(localclientnum, id);
  }
}

function_42e50d5() {
  if(isDefined(self.weapon)) {
    switch (self.weapon.name) {
      case #"hero_scepter_lv3":
      case #"hero_scepter_lv2":
      case #"hero_scepter_lv1":
        return true;
    }
  }

  return false;
}

sndvonotifydtp(localclientnum, notifystring) {
  self notify("50ec137dd0562c2");
  self endon("50ec137dd0562c2");
  self endon(#"death");

  while(true) {
    self waittill(notifystring);
    self playerexert(localclientnum, notifystring);
  }
}

sndmeleeswipe(localclientnum, notifystring) {
  self endon(#"death");

  for(;;) {
    self waittill(notifystring);
    currentweapon = getcurrentweapon(localclientnum);

    if(isDefined(level.sndnomeleeonclient) && level.sndnomeleeonclient) {
      return;
    }

    if(isDefined(self.is_player_zombie) && self.is_player_zombie) {
      playSound(0, #"zmb_melee_whoosh_zmb_plr", self.origin);
      continue;
    }

    if(currentweapon.statname === #"bowie_knife") {
      playSound(0, #"zmb_bowie_swing_plr", self.origin);
      continue;
    }

    if(currentweapon.name == "spoon_zm_alcatraz") {
      playSound(0, #"zmb_spoon_swing_plr", self.origin);
      continue;
    }

    if(currentweapon.name == "spork_zm_alcatraz") {
      playSound(0, #"zmb_spork_swing_plr", self.origin);
      continue;
    }

    playSound(0, #"zmb_melee_whoosh_plr", self.origin);
  }
}

end_gameover_snapshot() {
  level waittill(#"demo_jump", #"demo_player_switch", #"snd_clear_script_duck");
  wait 1;
  audio::snd_set_snapshot("default");
  level thread gameover_snapshot();
}

gameover_snapshot() {
  level waittill(#"zesn");
  audio::snd_set_snapshot("zmb_game_over");
  level thread end_gameover_snapshot();
}

sndzmblaststand(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playSound(localclientnum, #"hash_5e980fdf2497d9a1", (0, 0, 0));
    self.var_63de16a = self playLoopSound(#"hash_7b41cf42e1b9847b");
    self.inlaststand = 1;
    return;
  }

  if(isDefined(self.inlaststand) && self.inlaststand) {
    playSound(localclientnum, #"hash_1526662237d7780f", (0, 0, 0));
    self stoploopsound(self.var_63de16a);
    self.inlaststand = 0;
  }
}