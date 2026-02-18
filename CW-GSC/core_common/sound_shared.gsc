/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\sound_shared.gsc
***********************************************/

#using scripts\core_common\ai_shared;
#using scripts\core_common\util_shared;
#namespace sound;

function loop_fx_sound(alias, origin, ender) {
  org = spawn("script_origin", (0, 0, 0));

  if(isDefined(ender)) {
    thread loop_delete(ender, org);
    self endon(ender);
  }

  org.origin = origin;
  org playLoopSound(alias);
}

function loop_delete(ender, ent) {
  ent endon(#"death");
  self waittill(ender);
  ent delete();
}

function play_in_space(alias, origin, master) {
  org = spawn("script_origin", (0, 0, 1));

  if(!isDefined(master)) {
    master = self.origin;
  }

  org.origin = master;
  org playsoundwithnotify(origin, "sounddone");
  org waittill(#"sounddone");

  if(isDefined(org)) {
    org deletedelay();
  }
}

function loop_on_tag(alias, tag, bstopsoundondeath) {
  org = spawn("script_origin", (0, 0, 0));
  org endon(#"death");

  if(!isDefined(bstopsoundondeath)) {
    bstopsoundondeath = 1;
  }

  if(bstopsoundondeath) {
    thread util::delete_on_death(org);
  }

  if(isDefined(tag)) {
    org linkto(self, tag, (0, 0, 0), (0, 0, 0));
  } else {
    org.origin = self.origin;
    org.angles = self.angles;
    org linkto(self);
  }

  org playLoopSound(alias);
  self waittill("stop sound" + alias);
  org stoploopsound(alias);
  org delete();
}

function play_on_tag(alias, tag, ends_on_death, var_50bba55f, radio_dialog) {
  if(self ai::is_dead_sentient()) {
    return;
  }

  org = spawn("script_origin", self.origin);
  org endon(#"death");
  thread delete_on_death_wait_sound(org, "sounddone");

  if(isDefined(ends_on_death)) {
    org linkto(self, ends_on_death, (0, 0, 0), (0, 0, 0));
  } else {
    org.origin = self.origin;
    org.angles = self.angles;
    org linkto(self);
  }

  if(self === level.player_radio_emitter) {
    println("<dev string:x38>" + tag);
  }

  org playsoundwithnotify(tag, "sounddone");

  if(isDefined(var_50bba55f)) {
    assert(var_50bba55f, "<dev string:x5a>");

    if(!isDefined(wait_for_sounddone_or_death(org))) {
      org stopsounds();
    }

    waitframe(1);
  } else {
    org waittill(#"sounddone");
  }

  if(isDefined(radio_dialog)) {
    self notify(radio_dialog);
  }

  org delete();
}

function wait_for_sounddone_or_death(org, other) {
  if(isDefined(other)) {
    other endon(#"death");
  }

  self endon(#"death");
  org waittill(#"sounddone");
  return true;
}

function delete_on_death_wait_sound(ent, sounddone) {
  ent endon(#"death");
  self waittill(#"death");

  if(isDefined(ent)) {
    if(ent iswaitingonsound()) {
      ent waittill(sounddone);
    }

    ent deletedelay();
  }
}

function play_on_entity(alias) {
  play_on_tag(alias);
}

function stop_loop_on_entity(alias) {
  self notify("stop sound" + alias);
}

function loop_on_entity(alias, offset) {
  org = spawn("script_origin", (0, 0, 0));
  org endon(#"death");
  thread util::delete_on_death(org);

  if(isDefined(offset)) {
    org.origin = self.origin + offset;
    org.angles = self.angles;
    org linkto(self);
  } else {
    org.origin = self.origin;
    org.angles = self.angles;
    org linkto(self);
  }

  org playLoopSound(alias);
  self waittill("stop sound" + alias);
  org stoploopsound(0.1);
  org delete();
}

function loop_in_space(alias, origin, ender) {
  org = spawn("script_origin", (0, 0, 1));

  if(!isDefined(origin)) {
    origin = self.origin;
  }

  org.origin = origin;
  org playLoopSound(alias);
  level waittill(ender);
  org stoploopsound();
  wait 0.1;
  org delete();
}

function delete_on_death_wait(ent, sounddone) {
  sounddone endon(#"death");
  self waittill(#"death");

  if(isDefined(sounddone)) {
    sounddone delete();
  }
}

function play_on_players(sound, team) {
  assert(isDefined(level.players));

  if(level.splitscreen) {
    if(isDefined(level.players[0])) {
      level.players[0] playlocalsound(sound);
    }

    return;
  }

  if(isDefined(team)) {
    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];

      if(isDefined(player.pers[# "team"]) && player.pers[# "team"] == team) {
        player playlocalsound(sound);
      }
    }

    return;
  }

  for(i = 0; i < level.players.size; i++) {
    level.players[i] playlocalsound(sound);
  }
}