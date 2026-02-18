/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\dialogue.gsc
***********************************************/

#using scripts\core_common\ai\systems\face;
#using scripts\core_common\ai_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\util_shared;
#namespace dialogue;

function queue(alias, timeout, var_bcc3bb15) {
  if(getdvarint(#"hash_c994d2af0329db3", 0) != 0) {
    var_88f2fd1a = function_9119c373(alias, "<dev string:x38>");

    if(isstring(var_88f2fd1a) && var_88f2fd1a != "<dev string:x43>") {
      txt = "<dev string:x49>" + alias + "<dev string:x70>";
      iprintlnbold(txt);
      println(txt);
    }
  }

  if(isDefined(self)) {
    if(is_true(var_bcc3bb15)) {
      self function_47b06180();
    }

    if(!isDefined(timeout)) {
      self util::function_stack(&function_8026ba41, alias);
      return;
    }

    self util::function_stack_timeout(timeout, &function_8026ba41, alias);
  }
}

function function_47b06180() {
  if(isscriptfunctionptr(level.var_4ceaaaf5)) {
    self thread[[level.var_4ceaaaf5]]();
    return;
  }

  self util::function_stack_clear();
  self notify(#"cancel speaking");
}

function radio(alias, timeout, var_1ccdc84c, var_bcc3bb15) {
  if(getdvarint(#"hash_c994d2af0329db3", 0) != 0) {
    var_88f2fd1a = function_9119c373(alias, "<dev string:x38>");

    if(isstring(var_88f2fd1a) && var_88f2fd1a != "<dev string:x87>") {
      txt = "<dev string:x8d>" + alias + "<dev string:xb4>";
      iprintlnbold(txt);
      println(txt);
    }
  }

  if(is_true(var_bcc3bb15)) {
    self function_9e580f95();
    waitframe(1);
  }

  notifystring = "dialogue::radio " + alias;

  if(isscriptfunctionptr(level.var_94934cfc)) {
    self[[level.var_94934cfc]](alias, notifystring);
    return;
  }

  player_radio_emitter = self function_dc8dd8fa();

  if(!isDefined(player_radio_emitter)) {
    return;
  }

  if(is_true(var_1ccdc84c)) {
    player_radio_emitter sound::play_on_tag(alias, undefined, 1, notifystring);
    return;
  }

  if(!isDefined(timeout)) {
    player_radio_emitter util::function_stack(&sound::play_on_tag, alias, undefined, 1, notifystring);
    return;
  }

  player_radio_emitter util::function_stack_timeout(timeout, &sound::play_on_tag, alias, undefined, 1, notifystring);
}

function function_9e580f95() {
  if(isscriptfunctionptr(level.var_4ceaaaf5)) {
    self thread[[level.var_4ceaaaf5]]();
    return;
  }

  player_radio_emitter = self function_dc8dd8fa();

  if(!isDefined(player_radio_emitter)) {
    return;
  }

  var_90c2cde7 = player_radio_emitter getlinkedchildren(1);

  foreach(ent in var_90c2cde7) {
    ent thread function_d708473a();
  }

  player_radio_emitter thread function_d708473a();
}

function private function_d708473a() {
  self endon(#"death");
  self stopsounds();
  waitframe(1);
  self delete();
}

function function_dcdd0cb6() {
  player_radio_emitter = self function_dc8dd8fa();

  if(!isDefined(player_radio_emitter)) {
    return;
  }

  player_radio_emitter util::function_stack_clear();
}

function radio_safe(alias) {
  return radio(alias, float(function_60d95f53()) / 1000);
}

function function_96171f6d(alias, timeout, var_bcc3bb15) {
  player_gesture(alias, 0, undefined, undefined, undefined, timeout, var_bcc3bb15);
}

function player_gesture(alias, sounddelay, gestures, gesturedelays, targetents, timeout, var_bcc3bb15) {
  if(is_true(var_bcc3bb15)) {
    self function_3db52a33();
  }

  player_dialogue_emitter = self function_7ddb5aa3();

  if(!isDefined(player_dialogue_emitter)) {
    return;
  }

  if(!isDefined(timeout)) {
    player_dialogue_emitter util::function_stack(&_play_player_dialogue, alias, sounddelay, gestures, gesturedelays, targetents);
    return;
  }

  player_dialogue_emitter util::function_stack_timeout(timeout, &_play_player_dialogue, alias, sounddelay, gestures, gesturedelays, targetents);
}

function function_3db52a33() {
  player_dialogue_emitter = self function_7ddb5aa3();

  if(!isDefined(player_dialogue_emitter)) {
    return;
  }

  var_6ceb99a = player_dialogue_emitter getlinkedchildren(1);

  foreach(ent in var_6ceb99a) {
    ent thread function_d708473a();
  }

  player_dialogue_emitter thread function_d708473a();
}

function function_d37e4893() {
  player_dialogue_emitter = self function_7ddb5aa3();

  if(!isDefined(player_dialogue_emitter)) {
    return;
  }

  player_dialogue_emitter util::function_stack_clear();
}

function private _play_player_dialogue(alias, sounddelay, gestures, gesturedelays, gesturetargets) {
  if(ai::is_dead_sentient()) {
    return;
  }

  org = spawn("script_origin", (0, 0, 0));
  org endon(#"death");
  org.origin = self.origin;
  org.angles = self.angles;
  org linkto(self);
  player = self function_bbd6c05b();
  player_dialogue_emitter = self function_7ddb5aa3();

  if(isDefined(player_dialogue_emitter) && self == player_dialogue_emitter) {
    println("<dev string:xcb>" + alias);
  }

  if(sounddelay > 0) {
    org util::delay(sounddelay, undefined, &playsoundwithnotify, alias, "sounddone");
  } else {
    org playsoundwithnotify(alias, "sounddone");
  }

  if(isDefined(gestures)) {
    assert(isDefined(gesturedelays), "<dev string:xee>");

    if(isarray(gestures)) {
      assert(gestures.size == gesturedelays.size, "<dev string:x141>");

      for(i = 0; i < gestures.size; i++) {
        if(isDefined(gesturetargets) && isDefined(gesturetargets[i])) {
          player util::delay(gesturedelays[i], undefined, &function_ef63262c, gestures[i], gesturetargets[i]);
          continue;
        }

        player util::delay(gesturedelays[i], undefined, &function_ef63262c, gestures[i]);
      }
    } else if(isDefined(gesturetargets)) {
      player util::delay(gesturedelays, undefined, &function_ef63262c, gestures, gesturetargets);
    } else {
      player util::delay(gesturedelays, undefined, &function_ef63262c, gestures);
    }
  }

  if(sounddelay > 0) {
    wait sounddelay;
  }

  if(!isDefined(sound::wait_for_sounddone_or_death(org, player))) {
    org stopsounds();
  }

  wait 0.05;
  org delete();
}

function function_ef63262c(gesturename, lookatent) {
  assert(self == level.player, "<dev string:x1a1>");
  self endon(#"death");
  gestureplayed = 0;
  blendtime = undefined;
  canceltransition = 0;

  if(isDefined(lookatent) && isentity(lookatent)) {
    gestureplayed = self playgestureviewmodel(gesturename, lookatent, 1, blendtime);
  } else {
    gestureplayed = self playgestureviewmodel(gesturename, undefined, 1, blendtime);
  }

  if(gestureplayed) {}

  return gestureplayed;
}

function private function_8026ba41(alias) {
  if(isDefined(getscriptbundle(alias))) {
    self thread scene::play(alias, self);
  }

  if(soundexists(alias)) {
    self face::playfacethread(undefined, alias, 1);
  }
}

function private function_bbd6c05b() {
  if(isPlayer(self)) {
    return self;
  }

  players = getplayers();

  if(players.size > 0) {
    return players[0];
  }

  return undefined;
}

function private function_7ddb5aa3() {
  player = self function_bbd6c05b();

  if(isDefined(player)) {
    if(!isDefined(player.player_dialogue_emitter)) {
      ent = spawn("script_origin", player.origin);
      ent linkto(player, "", (0, 0, 0), (0, 0, 0));
      player.player_dialogue_emitter = ent;
    }

    return player.player_dialogue_emitter;
  }

  return undefined;
}

function private function_dc8dd8fa() {
  player = self function_bbd6c05b();

  if(isDefined(player)) {
    if(!isDefined(player.player_radio_emitter)) {
      ent = spawn("script_origin", player getplayercamerapos());
      ent linkto(player, "", (0, 0, 0), (0, 0, 0));
      player.player_radio_emitter = ent;
    }

    return player.player_radio_emitter;
  }

  return undefined;
}