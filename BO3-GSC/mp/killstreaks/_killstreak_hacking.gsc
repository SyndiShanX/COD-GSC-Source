/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\killstreaks\_killstreak_hacking.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\mp\killstreaks\_killstreak_bundles;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\shared\clientfield_shared;
#using scripts\shared\killstreaks_shared;
#using scripts\shared\popups_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#namespace killstreak_hacking;

function enable_hacking(killstreakname, prehackfunction, posthackfunction) {
  killstreak = self;
  level.challenge_scorestreaksenabled = 1;
  killstreak.challenge_isscorestreak = 1;
  killstreak.killstreak_hackedcallback = &_hacked_callback;
  killstreak.killstreakprehackfunction = prehackfunction;
  killstreak.killstreakposthackfunction = posthackfunction;
  killstreak.hackertoolinnertimems = killstreak killstreak_bundles::get_hack_tool_inner_time();
  killstreak.hackertooloutertimems = killstreak killstreak_bundles::get_hack_tool_outer_time();
  killstreak.hackertoolinnerradius = killstreak killstreak_bundles::get_hack_tool_inner_radius();
  killstreak.hackertoolouterradius = killstreak killstreak_bundles::get_hack_tool_outer_radius();
  killstreak.hackertoolradius = killstreak.hackertoolouterradius;
  killstreak.killstreakhackloopfx = killstreak killstreak_bundles::get_hack_loop_fx();
  killstreak.killstreakhackfx = killstreak killstreak_bundles::get_hack_fx();
  killstreak.killstreakhackscoreevent = killstreak killstreak_bundles::get_hack_scoreevent();
  killstreak.killstreakhacklostlineofsightlimitms = killstreak killstreak_bundles::get_lost_line_of_sight_limit_msec();
  killstreak.killstreakhacklostlineofsighttimems = killstreak killstreak_bundles::get_hack_tool_no_line_of_sight_time();
  killstreak.killstreak_hackedprotection = killstreak killstreak_bundles::get_hack_protection();
}

function disable_hacking() {
  killstreak = self;
  killstreak.killstreak_hackedcallback = undefined;
}

function hackerfx() {
  killstreak = self;
  if(isDefined(killstreak.killstreakhackfx) && killstreak.killstreakhackfx != "") {
    playFXOnTag(killstreak.killstreakhackfx, killstreak, "tag_origin");
  }
}

function hackerloopfx() {
  killstreak = self;
  if(isDefined(killstreak.killstreakloophackfx) && killstreak.killstreakloophackfx != "") {
    playFXOnTag(killstreak.killstreakloophackfx, killstreak, "tag_origin");
  }
}

function private _hacked_callback(hacker) {
  killstreak = self;
  originalowner = killstreak.owner;
  if(isDefined(killstreak.killstreakhackscoreevent)) {
    scoreevents::processscoreevent(killstreak.killstreakhackscoreevent, hacker, originalowner, level.weaponhackertool);
  }
  if(isDefined(killstreak.killstreakprehackfunction)) {
    killstreak thread[[killstreak.killstreakprehackfunction]](hacker);
  }
  killstreak killstreaks::configure_team_internal(hacker, 1);
  killstreak clientfield::set("enemyvehicle", 2);
  if(isDefined(killstreak.killstreakhackfx)) {
    killstreak thread hackerfx();
  }
  if(isDefined(killstreak.killstreakhackloopfx)) {
    killstreak thread hackerloopfx();
  }
  if(isDefined(killstreak.killstreakposthackfunction)) {
    killstreak thread[[killstreak.killstreakposthackfunction]](hacker);
  }
  killstreaktype = killstreak.killstreaktype;
  if(isDefined(killstreak.hackedkillstreakref)) {
    killstreaktype = killstreak.hackedkillstreakref;
  }
  level thread popups::displaykillstreakhackedteammessagetoall(killstreaktype, hacker);
  killstreak _update_health(hacker);
}

function override_hacked_killstreak_reference(killstreakref) {
  killstreak = self;
  killstreak.hackedkillstreakref = killstreakref;
}

function get_hacked_timeout_duration_ms() {
  killstreak = self;
  timeout = killstreak killstreak_bundles::get_hack_timeout();
  if(!isDefined(timeout) || timeout <= 0) {
    /
    #
    assertmsg(("" + killstreak.killstreaktype) + "");
    return;
  }
  return timeout * 1000;
}

function set_vehicle_drivable_time_starting_now(killstreak, duration_ms = -1) {
  if(duration_ms == -1) {
    duration_ms = killstreak get_hacked_timeout_duration_ms();
  }
  return self vehicle::set_vehicle_drivable_time_starting_now(duration_ms);
}

function _update_health(hacker) {
  killstreak = self;
  if(isDefined(killstreak.hackedhealthupdatecallback)) {
    killstreak[[killstreak.hackedhealthupdatecallback]](hacker);
  } else {
    if(issentient(killstreak)) {
      hackedhealth = killstreak_bundles::get_hacked_health(killstreak.killstreaktype);
      assert(isDefined(hackedhealth));
      if(self.health > hackedhealth) {
        self.health = hackedhealth;
      }
    } else {
      hacker iprintlnbold("");
    }
  }
}

function killstreak_switch_team_end() {
  killstreakentity = self;
  killstreakentity notify("killstreak_switch_team_end");
}

function killstreak_switch_team(owner) {
  killstreakentity = self;
  killstreakentity notify("killstreak_switch_team_singleton");
  killstreakentity endon("killstreak_switch_team_singleton");
  killstreakentity endon("death");
  setDvar("", "");
  while(true) {
    wait(0.5);
    devgui_int = getdvarint("");
    if(devgui_int != 0) {
      team = "";
      if(isDefined(level.getenemyteam) && isDefined(owner) && isDefined(owner.team)) {
        team = [[level.getenemyteam]](owner.team);
      }
      if(isDefined(level.devongetormakebot)) {
        player = [[level.devongetormakebot]](team);
      }
      if(!isDefined(player)) {
        println("");
        wait(1);
        continue;
      }
      if(!isDefined(killstreakentity.killstreak_hackedcallback)) {
        iprintlnbold("");
        return;
      }
      killstreakentity notify("killstreak_hacked", player);
      killstreakentity.previouslyhacked = 1;
      killstreakentity[[killstreakentity.killstreak_hackedcallback]](player);
      wait(0.5);
      setDvar("", "");
      return;
    }
  }
}