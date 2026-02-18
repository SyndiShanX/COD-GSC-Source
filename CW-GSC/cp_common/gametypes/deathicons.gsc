/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\gametypes\deathicons.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace deathicons;

function private autoexec __init__system__() {
  system::register(#"deathicons", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_start_gametype(&init);
  callback::on_connect(&on_player_connect);
}

function init() {
  if(!isDefined(level.ragdoll_override)) {
    level.ragdoll_override = &ragdoll_override;
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
  dyingplayer endon(#"spawned_player", #"disconnect");
  waitframe(1);
  util::waittillslowprocessallowed();
  assert(isDefined(level.teams[team]));
  assert(isDefined(level.teamindex[team]));

  if(!getdvarint(#"ui_hud_showdeathicons", 1)) {
    return;
  }

  if(level.hardcoremode) {
    return;
  }

  deathiconobjid = gameobjects::get_next_obj_id();
  objective_add(deathiconobjid, "active", iconorg, #"headicon_dead");
  objective_setteam(deathiconobjid, team);
  level thread destroy_slowly(timeout, deathiconobjid);
}

function destroy_slowly(timeout, deathiconobjid) {
  wait timeout;
  objective_setstate(deathiconobjid, "done");
  wait 1;
  objective_delete(deathiconobjid);
  gameobjects::release_obj_id(deathiconobjid);
}

function ragdoll_override(idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, ragdoll_jib, body) {
  if(ragdoll_jib == "MOD_FALLING" && self isonground() == 1) {
    body startragdoll();

    if(!isDefined(self.switching_teams)) {
      thread add(body, self, self.team, 5);
    }

    return true;
  }

  return false;
}