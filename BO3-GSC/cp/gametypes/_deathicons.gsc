/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\gametypes\_deathicons.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\gametypes\_globallogic_utils;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace deathicons;

function autoexec __init__sytem__() {
  system::register("deathicons", & __init__, undefined, undefined);
}

function __init__() {
  callback::on_start_gametype( & init);
  callback::on_connect( & on_player_connect);
}

function init() {
  if(!isdefined(level.ragdoll_override)) {
    level.ragdoll_override = & ragdoll_override;
  }
  if(!level.teambased) {
    return;
  }
}

function on_player_connect() {
  self.selfdeathicons = [];
}

function update_enabled() {}

function add(entity, dyingplayer, team, timeout) {
  if(!level.teambased || (isdefined(level.is_safehouse) && level.is_safehouse)) {
    return;
  }
  iconorg = entity.origin;
  dyingplayer endon("spawned_player");
  dyingplayer endon("disconnect");
  wait(0.05);
  util::waittillslowprocessallowed();
  assert(isdefined(level.teams[team]));
  if(getdvarstring("ui_hud_showdeathicons") == "0") {
    return;
  }
  if(level.hardcoremode) {
    return;
  }
  if(isdefined(self.lastdeathicon)) {
    self.lastdeathicon destroy();
  }
  newdeathicon = newteamhudelem(team);
  newdeathicon.x = iconorg[0];
  newdeathicon.y = iconorg[1];
  newdeathicon.z = iconorg[2] + 54;
  newdeathicon.alpha = 0.61;
  newdeathicon.archived = 1;
  if(level.splitscreen) {
    newdeathicon setshader("headicon_dead", 14, 14);
  } else {
    newdeathicon setshader("headicon_dead", 7, 7);
  }
  newdeathicon setwaypoint(1);
  self.lastdeathicon = newdeathicon;
  newdeathicon thread destroy_slowly(timeout);
}

function destroy_slowly(timeout) {
  self endon("death");
  wait(timeout);
  self fadeovertime(1);
  self.alpha = 0;
  wait(1);
  self destroy();
}

function ragdoll_override(idamage, smeansofdeath, sweapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, ragdoll_jib, body) {
  if(smeansofdeath == "MOD_FALLING" && self isonground() == 1) {
    body startragdoll();
    if(!isdefined(self.switching_teams)) {
      thread add(body, self, self.team, 5);
    }
    return true;
  }
  return false;
}