/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\planemortar.gsc
***********************************************/

#using script_396f7d71538c9677;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreak_dialog;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\planemortar_shared;
#using scripts\mp_common\util;
#namespace planemortar;

function private autoexec __init__system__() {
  system::register(#"planemortar", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  init_shared();
  bundlename = "killstreak_planemortar";

  if(sessionmodeiswarzonegame()) {
    bundlename += "_wz";
  }

  killstreaks::register_killstreak(bundlename, &usekillstreakplanemortar);
  level.killstreaks["inventory_" + getscriptbundle(bundlename).kstype].var_33807ea0 = 1;
  level.plane_mortar_bda_dialog = &plane_mortar_bda_dialog;
  level.planeawardscoreevent = &planeawardscoreevent;
  level.var_269fec2 = &function_269fec2;
}

function function_269fec2() {
  if(isDefined(level.var_30264985)) {
    self notify(#"mortarradarused");
  }

  if((isDefined(self.var_17b726b7) ? self.var_17b726b7 : 0) < gettime()) {
    globallogic_audio::leader_dialog_for_other_teams("enemyPlaneMortarUsed", self.team);
    self.var_17b726b7 = gettime() + int(battlechatter::mpdialog_value("planeMortarCooldown", 7) * 1000);
  }
}

function plane_mortar_bda_dialog() {
  if(isDefined(self.planemortarbda)) {
    if(self.planemortarbda === 1) {
      bdadialog = "kill1";
    } else if(self.planemortarbda === 2) {
      bdadialog = "kill2";
    } else if(self.planemortarbda === 3) {
      bdadialog = "kill3";
    } else if(self.planemortarbda > 3) {
      bdadialog = "killMultiple";
    }

    self killstreak_dialog::play_pilot_dialog(bdadialog, "planemortar", undefined, self.planemortarpilotindex);
    self killstreak_dialog::play_taacom_dialog("confirmHit");
  } else if(is_true(self.("planemortar" + "_hitconfirmed"))) {
    self killstreak_dialog::play_pilot_dialog("hitConfirmed_p0", "planemortar", undefined, self.planemortarpilotindex);
    self killstreak_dialog::play_taacom_dialog("confirmHit");
  } else {
    self killstreak_dialog::play_pilot_dialog("killNone", "planemortar", undefined, self.planemortarpilotindex);
    self killstreak_dialog::play_taacom_dialog("confirmMiss");
  }

  self.planemortarbda = undefined;
  self.("planemortar" + "_hitconfirmed") = undefined;
  self.var_6e5974d2 = undefined;
  self.planemortarpilotindex = undefined;
}

function planeawardscoreevent(attacker, plane) {
  attacker endon(#"disconnect");
  attacker notify(#"planeawardscoreevent_singleton");
  attacker endon(#"planeawardscoreevent_singleton");
  waittillframeend();

  if(isDefined(attacker) && (!isDefined(plane.owner) || plane.owner util::isenemyplayer(attacker))) {
    challenges::destroyedaircraft(attacker, getweapon(#"emp"), 0, plane);
    scoreevents::processscoreevent(#"destroyed_plane_mortar", attacker, plane.owner, getweapon(#"emp"));
    attacker challenges::addflyswatterstat(getweapon(#"emp"), plane);
  }
}