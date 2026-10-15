/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\planemortar.gsc
***********************************************/

#include scripts\core_common\challenges_shared;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\killstreaks\planemortar_shared;
#include scripts\mp_common\gametypes\battlechatter;
#include scripts\mp_common\gametypes\globallogic_audio;
#include scripts\mp_common\util;

#namespace planemortar;

autoexec __init__system__() {
  system::register(#"planemortar", &__init__, undefined, #"killstreaks");
}

__init__() {
  init_shared();
  bundle = struct::get_script_bundle("killstreak", "killstreak_planemortar");
  killstreaks::register_bundle(bundle, &usekillstreakplanemortar);
  level.plane_mortar_bda_dialog = &plane_mortar_bda_dialog;
  level.planeawardscoreevent = &planeawardscoreevent;
  level.var_269fec2 = &function_269fec2;
  killstreaks::set_team_kill_penalty_scale("planemortar", level.teamkillreducedpenalty);
}

function_269fec2() {
  if(!isDefined(self.pers[#"mortarradarused"]) || !self.pers[#"mortarradarused"]) {
    otherteam = util::getotherteam(self.team);
    globallogic_audio::leader_dialog("enemyPlaneMortarUsed", otherteam);
  }

  if(isDefined(level.var_30264985)) {
    self notify(#"mortarradarused");
  }
}

plane_mortar_bda_dialog() {
  if(isDefined(self.planemortarbda)) {
    if(self.planemortarbda === 1) {
      bdadialog = "kill1";
      killconfirmed = "killConfirmed1_p";
    } else if(self.planemortarbda === 2) {
      bdadialog = "kill2";
      killconfirmed = "killConfirmed2_p";
    } else if(self.planemortarbda === 3) {
      bdadialog = "kill3";
      killconfirmed = "killConfirmed3_p";
    } else if(isDefined(self.planemortarbda) && self.planemortarbda > 3) {
      bdadialog = "killMultiple";
      killconfirmed = "killConfirmedMult_p";
    }

    self killstreaks::play_pilot_dialog(bdadialog, "planemortar", undefined, self.planemortarpilotindex);

    if(battlechatter::dialog_chance("taacomPilotKillConfirmChance")) {
      self killstreaks::play_taacom_dialog_response(killconfirmed, "planemortar", undefined, self.planemortarpilotindex);
    } else {
      self killstreaks::play_taacom_dialog_response("hitConfirmed_p", "planemortar", undefined, self.planemortarpilotindex);
    }
  } else {
    killstreaks::play_pilot_dialog("killNone", "planemortar", undefined, self.planemortarpilotindex);
    globallogic_audio::play_taacom_dialog("confirmMiss");
  }

  self.planemortarbda = undefined;
}

planeawardscoreevent(attacker, plane) {
  attacker endon(#"disconnect");
  attacker notify(#"planeawardscoreevent_singleton");
  attacker endon(#"planeawardscoreevent_singleton");
  waittillframeend();

  if(isDefined(attacker) && (!isDefined(plane.owner) || plane.owner util::isenemyplayer(attacker))) {
    challenges::destroyedaircraft(attacker, getweapon(#"emp"), 0, 1);
    scoreevents::processscoreevent(#"destroyed_plane_mortar", attacker, plane.owner, getweapon(#"emp"));
    attacker challenges::addflyswatterstat(getweapon(#"emp"), plane);
  }
}