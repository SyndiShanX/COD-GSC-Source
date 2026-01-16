/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\sound_shared.gsc
***********************************************/

#include scripts\core_common\util_shared;

#namespace sound;

loop_fx_sound(alias, origin, ender) {
  org = spawn("script_origin", (0, 0, 0));

  if(isDefined(ender)) {
    thread loop_delete(ender, org);
    self endon(ender);
  }

  org.origin = origin;
  org playLoopSound(alias);
}

loop_delete(ender, ent) {
  ent endon(#"death");
  self waittill(ender);
  ent delete();
}

play_in_space(alias, origin, master) {
  org = spawn("script_origin", (0, 0, 1));

  if(!isDefined(origin)) {
    origin = self.origin;
  }

  org.origin = origin;
  org playsoundwithnotify(alias, "sounddone");
  org waittill(#"sounddone");

  if(isDefined(org)) {
    org delete();
  }
}

loop_on_tag(alias, tag, bstopsoundondeath) {
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

play_on_tag(alias, tag, ends_on_death) {
  org = spawn("script_origin", (0, 0, 0));
  org endon(#"death");
  thread delete_on_death_wait(org, "sounddone");

  if(isDefined(tag)) {
    org.origin = self gettagorigin(tag);
    org linkto(self, tag, (0, 0, 0), (0, 0, 0));
  } else {
    org.origin = self.origin;
    org.angles = self.angles;
    org linkto(self);
  }

  org playsoundwithnotify(alias, "sounddone");

  if(isDefined(ends_on_death)) {
    assert(ends_on_death, "<dev string:x38>");
    wait_for_sounddone_or_death(org);
    waitframe(1);
  } else {
    org waittill(#"sounddone");
  }

  org delete();
}

play_on_entity(alias) {
  play_on_tag(alias);
}

wait_for_sounddone_or_death(org) {
  self endon(#"death");
  org waittill(#"sounddone");
}

stop_loop_on_entity(alias) {
  self notify("stop sound" + alias);
}

loop_on_entity(alias, offset) {
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

loop_in_space(alias, origin, ender) {
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

delete_on_death_wait(ent, sounddone) {
  ent endon(#"death");
  self waittill(#"death");

  if(isDefined(ent)) {
    ent delete();
  }
}

play_on_players(sound, team) {
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

      if(isDefined(player.pers[#"team"]) && player.pers[#"team"] == team) {
        player playlocalsound(sound);
      }
    }

    return;
  }

  for(i = 0; i < level.players.size; i++) {
    level.players[i] playlocalsound(sound);
  }
}