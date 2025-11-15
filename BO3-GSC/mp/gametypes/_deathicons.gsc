/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\_deathicons.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\gametypes\_globallogic_utils;
#using scripts\shared\callbacks_shared;
#using scripts\shared\gameobjects_shared;
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
  if(!isDefined(level.ragdoll_override)) {
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
  if(!level.teambased) {
    return;
  }
  iconorg = entity.origin;
  dyingplayer endon("spawned_player");
  dyingplayer endon("disconnect");
  wait(0.05);
  util::waittillslowprocessallowed();
  assert(isDefined(level.teams[team]));
  assert(isDefined(level.teamindex[team]));
  if(getdvarstring("ui_hud_showdeathicons") == "0") {
    return;
  }
  if(level.hardcoremode) {
    return;
  }
  deathiconobjid = gameobjects::get_next_obj_id();
  objective_add(deathiconobjid, "active", iconorg, & "headicon_dead");
  objective_team(deathiconobjid, team);
  level thread destroy_slowly(timeout, deathiconobjid);
}

function destroy_slowly(timeout, deathiconobjid) {
  wait(timeout);
  objective_state(deathiconobjid, "done");
  wait(1);
  objective_delete(deathiconobjid);
  gameobjects::release_obj_id(deathiconobjid);
}

function ragdoll_override(idamage, smeansofdeath, sweapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, ragdoll_jib, body) {
  if(smeansofdeath == "MOD_FALLING" && self isonground() == 1) {
    body startragdoll();
    if(!isDefined(self.switching_teams)) {
      thread add(body, self, self.team, 5);
    }
    return true;
  }
  return false;
}