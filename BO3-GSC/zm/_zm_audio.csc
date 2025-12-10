/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_audio.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace zm_audio;

function autoexec __init__sytem__() {
  system::register("zm_audio", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("allplayers", "charindex", 1, 3, "int", &charindex_cb, 0, 1);
  clientfield::register("toplayer", "isspeaking", 1, 1, "int", &isspeaking_cb, 0, 1);
  if(!isDefined(level.exert_sounds)) {
    level.exert_sounds = [];
  }
  level.exert_sounds[0]["playerbreathinsound"] = "vox_exert_generic_inhale";
  level.exert_sounds[0]["playerbreathoutsound"] = "vox_exert_generic_exhale";
  level.exert_sounds[0]["playerbreathgaspsound"] = "vox_exert_generic_exhale";
  level.exert_sounds[0]["falldamage"] = "vox_exert_generic_pain";
  level.exert_sounds[0]["mantlesoundplayer"] = "vox_exert_generic_mantle";
  level.exert_sounds[0]["meleeswipesoundplayer"] = "vox_exert_generic_knifeswipe";
  level.exert_sounds[0]["dtplandsoundplayer"] = "vox_exert_generic_pain";
  level thread gameover_snapshot();
  callback::on_spawned(&on_player_spawned);
}

function on_player_spawned(localclientnum) {}

function delay_set_exert_id(newval) {
  self endon("entityshutdown");
  self endon("sndendexertoverride");
  wait(0.5);
  self.player_exert_id = newval;
}

function charindex_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!bnewent) {
    self.player_exert_id = newval;
    self._first_frame_exert_id_recieved = 1;
    self notify("sndendexertoverride");
  } else if(!isDefined(self._first_frame_exert_id_recieved)) {
    self._first_frame_exert_id_recieved = 1;
    self thread delay_set_exert_id(newval);
  }
}

function isspeaking_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!bnewent) {
    self.isspeaking = newval;
  } else {
    self.isspeaking = 0;
  }
}

function zmbmuslooper() {
  ent = spawn(0, (0, 0, 0), "script_origin");
  playSound(0, "mus_zmb_gamemode_start", (0, 0, 0));
  wait(10);
  ent playLoopSound("mus_zmb_gamemode_loop", 0.05);
  ent thread waitfor_music_stop();
}

function waitfor_music_stop() {
  level waittill("stpm");
  self stopallloopsounds(0.1);
  playSound(0, "mus_zmb_gamemode_end", (0, 0, 0));
  wait(1);
  self delete();
}

function playerfalldamagesound(client_num, firstperson) {
  self playerexert(client_num, "falldamage");
}

function clientvoicesetup() {
  callback::on_localclient_connect(&audio_player_connect);
  players = getlocalplayers();
  for(i = 0; i < players.size; i++) {
    thread audio_player_connect(i);
  }
}

function audio_player_connect(localclientnum) {
  thread sndvonotifyplain(localclientnum, "playerbreathinsound");
  thread sndvonotifyplain(localclientnum, "playerbreathoutsound");
  thread sndvonotifyplain(localclientnum, "playerbreathgaspsound");
  thread sndvonotifyplain(localclientnum, "mantlesoundplayer");
  thread sndvonotifyplain(localclientnum, "meleeswipesoundplayer");
  thread sndvonotifydtp(localclientnum, "dtplandsoundplayer");
}

function playerexert(localclientnum, exert) {
  if(isDefined(self.isspeaking) && self.isspeaking == 1) {
    return;
  }
  if(isDefined(self.beast_mode) && self.beast_mode) {
    return;
  }
  id = level.exert_sounds[0][exert];
  if(isarray(level.exert_sounds[0][exert])) {
    id = array::random(level.exert_sounds[0][exert]);
  }
  if(isDefined(self.player_exert_id)) {
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

function sndvonotifydtp(localclientnum, notifystring) {
  level notify(("kill_sndVoNotifyDTP" + localclientnum) + notifystring);
  level endon(("kill_sndVoNotifyDTP" + localclientnum) + notifystring);
  player = undefined;
  while(!isDefined(player)) {
    player = getnonpredictedlocalplayer(localclientnum);
    wait(0.05);
  }
  player endon("disconnect");
  for(;;) {
    player waittill(notifystring, surfacetype);
    player playerexert(localclientnum, notifystring);
  }
}

function sndmeleeswipe(localclientnum, notifystring) {
  player = undefined;
  while(!isDefined(player)) {
    player = getnonpredictedlocalplayer(localclientnum);
    wait(0.05);
  }
  player endon("disconnect");
  for(;;) {
    player waittill(notifystring);
    currentweapon = getcurrentweapon(localclientnum);
    if(isDefined(level.sndnomeleeonclient) && level.sndnomeleeonclient) {
      return;
    }
    if(isDefined(player.is_player_zombie) && player.is_player_zombie) {
      playSound(0, "zmb_melee_whoosh_zmb_plr", player.origin);
      continue;
    }
    if(currentweapon.name == "bowie_knife") {
      playSound(0, "zmb_bowie_swing_plr", player.origin);
      continue;
    }
    if(currentweapon.name == "spoon_zm_alcatraz") {
      playSound(0, "zmb_spoon_swing_plr", player.origin);
      continue;
    }
    if(currentweapon.name == "spork_zm_alcatraz") {
      playSound(0, "zmb_spork_swing_plr", player.origin);
      continue;
    }
    playSound(0, "zmb_melee_whoosh_plr", player.origin);
  }
}

function sndvonotifyplain(localclientnum, notifystring) {
  level notify(("kill_sndVoNotifyPlain" + localclientnum) + notifystring);
  level endon(("kill_sndVoNotifyPlain" + localclientnum) + notifystring);
  player = undefined;
  while(!isDefined(player)) {
    player = getnonpredictedlocalplayer(localclientnum);
    wait(0.05);
  }
  player endon("disconnect");
  for(;;) {
    player waittill(notifystring);
    if(isDefined(player.is_player_zombie) && player.is_player_zombie) {
      continue;
    }
    player playerexert(localclientnum, notifystring);
  }
}

function end_gameover_snapshot() {
  level util::waittill_any("demo_jump", "demo_player_switch", "snd_clear_script_duck");
  wait(1);
  audio::snd_set_snapshot("default");
  level thread gameover_snapshot();
}

function gameover_snapshot() {
  level waittill("zesn");
  audio::snd_set_snapshot("zmb_game_over");
  level thread end_gameover_snapshot();
}

function sndsetzombiecontext(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self setsoundentcontext("grass", "no_grass");
  } else {
    self setsoundentcontext("grass", "in_grass");
  }
}

function sndzmblaststand(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playSound(localclientnum, "chr_health_laststand_enter", (0, 0, 0));
    self.inlaststand = 1;
    setsoundcontext("laststand", "active");
    if(!issplitscreen()) {
      forceambientroom("sndHealth_LastStand");
    }
  } else {
    if(isDefined(self.inlaststand) && self.inlaststand) {
      playSound(localclientnum, "chr_health_laststand_exit", (0, 0, 0));
      self.inlaststand = 0;
      if(!issplitscreen()) {
        forceambientroom("");
      }
    }
    setsoundcontext("laststand", "");
  }
}