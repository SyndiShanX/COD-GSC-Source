/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_audio.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace zm_audio;

function private autoexec __init__system__() {
  system::register(#"zm_audio", &preinit, undefined, undefined, undefined);
}

function private preinit() {
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

function on_player_spawned(localclientnum) {}

function delay_set_exert_id(newval) {
  self endon(#"death");
  self endon(#"sndendexertoverride");
  wait 0.5;
  self.player_exert_id = newval;
}

function charindex_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!bwastimejump) {
    self.player_exert_id = fieldname;
    self.var_164a7bad = 1;
    self notify(#"sndendexertoverride");
    return;
  }

  if(!isDefined(self.var_164a7bad)) {
    self.var_164a7bad = 1;
    self thread delay_set_exert_id(fieldname);
  }
}

function isspeaking_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!bwastimejump) {
    self.isspeaking = fieldname;
    return;
  }

  self.isspeaking = 0;
}

function zmbmuslooper() {
  ent = spawn(0, (0, 0, 0), "script_origin");
  playSound(0, #"mus_zmb_gamemode_start", (0, 0, 0));
  wait 10;
  ent playLoopSound(#"mus_zmb_gamemode_loop", 0.05);
  ent thread waitfor_music_stop();
}

function waitfor_music_stop() {
  level waittill(#"stpm");
  self stopallloopsounds(0.1);
  playSound(0, #"mus_zmb_gamemode_end", (0, 0, 0));
  wait 1;
  self delete();
}

function playerfalldamagesound(client_num, firstperson) {
  self playerexert(firstperson, "falldamage");
}

function clientvoicesetup() {
  localclientnum = self getlocalclientnumber();
  self thread audio_player_connect(localclientnum);
}

function audio_player_connect(localclientnum) {
  var_3d2dc382 = array("playerbreathinsound", "playerbreathoutsound", "playerbreathgaspsound", "mantlesoundplayer", "meleeswipesoundplayer");
  self thread sndvonotifyplain(localclientnum, var_3d2dc382);
  self thread sndvonotifydtp(localclientnum, "dtplandsoundplayer");
}

function sndvonotifyplain(localclientnum, var_3d2dc382) {
  self notify("40aeb1ec9ae5d129");
  self endon("40aeb1ec9ae5d129");
  self endon(#"death");

  while(true) {
    s_result = self waittill(var_3d2dc382);

    if(is_true(self.is_player_zombie)) {
      continue;
    }

    self playerexert(localclientnum, s_result._notify);
  }
}

function playerexert(localclientnum, exert) {
  if(isDefined(self.isspeaking) && self.isspeaking == 1) {
    return;
  }

  if(is_true(self.beast_mode)) {
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

function function_42e50d5() {
  if(isDefined(self.weapon)) {
    switch (self.weapon.name) {
      case # "hero_scepter_lv3":
      case # "hero_scepter_lv2":
      case # "hero_scepter_lv1":
        return true;
    }
  }

  return false;
}

function sndvonotifydtp(localclientnum, notifystring) {
  self notify("77d556968f9c1b4");
  self endon("77d556968f9c1b4");
  self endon(#"death");

  while(true) {
    self waittill(notifystring);
    self playerexert(localclientnum, notifystring);
  }
}

function sndmeleeswipe(localclientnum, notifystring) {
  self endon(#"death");

  for(;;) {
    self waittill(notifystring);
    currentweapon = getcurrentweapon(localclientnum);

    if(is_true(level.sndnomeleeonclient)) {
      return;
    }

    if(is_true(self.is_player_zombie)) {
      playSound(0, #"zmb_melee_whoosh_zmb_plr", self.origin);
      continue;
    }

    if(currentweapon.statname === # "bowie_knife") {
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

function end_gameover_snapshot() {
  level waittill(#"demo_jump", #"demo_player_switch", #"snd_clear_script_duck");
  wait 1;
  audio::snd_set_snapshot("default");
  level thread gameover_snapshot();
}

function gameover_snapshot() {
  level waittill(#"zesn");
  audio::snd_set_snapshot("zmb_game_over");
  level thread end_gameover_snapshot();
}

function sndzmblaststand(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    playSound(fieldname, #"hash_5e980fdf2497d9a1", (0, 0, 0));
    self.var_63de16a = self playLoopSound(#"hash_7b41cf42e1b9847b");
    self.inlaststand = 1;
    return;
  }

  if(is_true(self.inlaststand)) {
    playSound(fieldname, #"hash_1526662237d7780f", (0, 0, 0));
    self stoploopsound(self.var_63de16a);
    self.inlaststand = 0;
  }
}