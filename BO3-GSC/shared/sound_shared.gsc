/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\sound_shared.gsc
*************************************************/

#using scripts\shared\util_shared;
#namespace sound;

function loop_fx_sound(alias, origin, ender) {
  org = spawn("script_origin", (0, 0, 0));
  if(isdefined(ender)) {
    thread loop_delete(ender, org);
    self endon(ender);
  }
  org.origin = origin;
  org playloopsound(alias);
}

function loop_delete(ender, ent) {
  ent endon("death");
  self waittill(ender);
  ent delete();
}

function play_in_space(alias, origin, master) {
  org = spawn("script_origin", (0, 0, 1));
  if(!isdefined(origin)) {
    origin = self.origin;
  }
  org.origin = origin;
  org playsoundwithnotify(alias, "sounddone");
  org waittill("sounddone");
  if(isdefined(org)) {
    org delete();
  }
}

function loop_on_tag(alias, tag, bstopsoundondeath) {
  org = spawn("script_origin", (0, 0, 0));
  org endon("death");
  if(!isdefined(bstopsoundondeath)) {
    bstopsoundondeath = 1;
  }
  if(bstopsoundondeath) {
    thread util::delete_on_death(org);
  }
  if(isdefined(tag)) {
    org linkto(self, tag, (0, 0, 0), (0, 0, 0));
  } else {
    org.origin = self.origin;
    org.angles = self.angles;
    org linkto(self);
  }
  org playloopsound(alias);
  self waittill("stop sound" + alias);
  org stoploopsound(alias);
  org delete();
}

function play_on_tag(alias, tag, ends_on_death) {
  org = spawn("script_origin", (0, 0, 0));
  org endon("death");
  thread delete_on_death_wait(org, "sounddone");
  if(isdefined(tag)) {
    org.origin = self gettagorigin(tag);
    org linkto(self, tag, (0, 0, 0), (0, 0, 0));
  } else {
    org.origin = self.origin;
    org.angles = self.angles;
    org linkto(self);
  }
  org playsoundwithnotify(alias, "sounddone");
  if(isdefined(ends_on_death)) {
    assert(ends_on_death, "");
    wait_for_sounddone_or_death(org);
    wait(0.05);
  } else {
    org waittill("sounddone");
  }
  org delete();
}

function play_on_entity(alias) {
  play_on_tag(alias);
}

function wait_for_sounddone_or_death(org) {
  self endon("death");
  org waittill("sounddone");
}

function stop_loop_on_entity(alias) {
  self notify("stop sound" + alias);
}

function loop_on_entity(alias, offset) {
  org = spawn("script_origin", (0, 0, 0));
  org endon("death");
  thread util::delete_on_death(org);
  if(isdefined(offset)) {
    org.origin = self.origin + offset;
    org.angles = self.angles;
    org linkto(self);
  } else {
    org.origin = self.origin;
    org.angles = self.angles;
    org linkto(self);
  }
  org playloopsound(alias);
  self waittill("stop sound" + alias);
  org stoploopsound(0.1);
  org delete();
}

function loop_in_space(alias, origin, ender) {
  org = spawn("script_origin", (0, 0, 1));
  if(!isdefined(origin)) {
    origin = self.origin;
  }
  org.origin = origin;
  org playloopsound(alias);
  level waittill(ender);
  org stoploopsound();
  wait(0.1);
  org delete();
}

function delete_on_death_wait(ent, sounddone) {
  ent endon("death");
  self waittill("death");
  if(isdefined(ent)) {
    ent delete();
  }
}

function play_on_players(sound, team) {
  assert(isdefined(level.players));
  if(level.splitscreen) {
    if(isdefined(level.players[0])) {
      level.players[0] playlocalsound(sound);
    }
  } else {
    if(isdefined(team)) {
      for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        if(isdefined(player.pers["team"]) && player.pers["team"] == team) {
          player playlocalsound(sound);
        }
      }
    } else {
      for (i = 0; i < level.players.size; i++) {
        level.players[i] playlocalsound(sound);
      }
    }
  }
}