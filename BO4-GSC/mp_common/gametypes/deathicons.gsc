/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\deathicons.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace deathicons;

autoexec __init__system__() {
  system::register(#"deathicons", &__init__, undefined, undefined);
}

__init__() {
  callback::on_start_gametype(&init);
  callback::on_connect(&on_player_connect);
}

init() {
  if(!isDefined(level.ragdoll_override)) {
    level.ragdoll_override = &ragdoll_override;
  }

  if(!level.teambased) {
    return;
  }
}

on_player_connect() {
  self.selfdeathicons = [];
}

update_enabled() {}

add(entity, dyingplayer, team) {
  if(!level.teambased) {
    return;
  }

  timeout = getdvarfloat(#"scr_deathicon_time", 5);
  iconorg = entity.origin;
  dyingplayer endon(#"spawned_player", #"disconnect");
  waitframe(1);
  util::waittillslowprocessallowed();
  assert(isDefined(level.teams[team]));
  assert(isDefined(level.teamindex[team]));

  if(getdvarint(#"ui_hud_showdeathicons", 1) == 0) {
    return;
  }

  if(level.hardcoremode) {
    return;
  }

  if(sessionmodeiswarzonegame()) {
    return;
  }

  objectivename = sessionmodeiswarzonegame() ? #"headicon_dead_wz" : #"headicon_dead";
  deathiconobjid = gameobjects::get_next_obj_id();
  objective_add(deathiconobjid, "active", iconorg, objectivename, dyingplayer);
  objective_setteam(deathiconobjid, team);
  function_3ae6fa3(deathiconobjid, team, 1);
  level thread destroy_slowly(timeout, deathiconobjid);
}

destroy_slowly(timeout, deathiconobjid) {
  wait timeout;
  objective_setstate(deathiconobjid, "done");
  wait 1;
  objective_delete(deathiconobjid);
  gameobjects::release_obj_id(deathiconobjid);
}

ragdoll_override(idamage, smeansofdeath, sweapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, ragdoll_jib, body) {
  if(smeansofdeath == "MOD_FALLING" && self isonground() == 1) {
    body startragdoll();

    if(!isDefined(self.switching_teams)) {
      thread add(body, self, self.team);
    }

    return true;
  }

  return false;
}