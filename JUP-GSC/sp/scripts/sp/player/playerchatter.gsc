/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\player\playerchatter.gsc
***********************************************/



#using scripts\anim\battlechatter;
#using scripts\anim\battlechatter_ai;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace playerchatter;

function init_playerchatter() {
  anim.player.battlechatter = spawnStruct();
  anim.player.battlechatter.countryid = getplayernameid();
  anim.player.battlechatter.enemyclass = "soldier";
}

function getplayernameid() {}

function player_battlechatter_on_thread() {}

function player_update_allowed_callouts() {}

function player_battlechatter_off_thread() {}

function playerthreadthreader() {}

function playerdamagewaiter() {}

function playerdogfightwaiter() {}

function playervehiclewaiter() {}

function playeranimnameswitch() {
  human_player = getEntArray("player", "classname")[0];
  player_update_allowed_callouts();
  anim.player = human_player;

  if(!isDefined(anim.player.team)) {
    anim.player.team = "allies";
  }

  player_update_allowed_callouts();
  level.bcs_maxthreatdistsqrdfromplayer = squared(5000);
  level.bcs_maxtalkingdistsqrdfromplayer = squared(3000);
  level.bcs_maxstealthdistsqrdfromplayer = squared(1500);
  anim.teamthreatcalloutlimittimeout = 120000;
  init_playerchatter();
}

function player_battlechatter_cooldown_control() {
  anim.player.bcscooldown = 1;

  while(isalive(anim.player) && bcsenabled() && isDefined(anim.player.battlechatterallowed) && anim.player.battlechatterallowed) {
    if(anim.player.bcscooldown == 0) {
      cooldown_time = 10;
    } else {
      cooldown_time = anim.player.bcscooldown;
    }

    anim.player.battlechatter.isspeaking = 1;

    for(i = cooldown_time; i >= 0; i--) {
      anim.player.bcscooldown = i;
      wait 1;
    }

    anim.player.battlechatter.isspeaking = 0;
    level waittill("player_battlechatter_refresh");

    while(anim.player.battlechatter.isspeaking != 0) {
      wait 0.5;
    }
  }
}

function player_battlechatter_generic_event_check() {
  anim.player endon("death");
  level endon("player_battlechatter_off");
  last_event = "none";
  event_list = ["pc_ammocrate_pickup", "pc_equipcrate_pickup", "pc_weapon_scanned", "pc_armory_door", "pc_clear_last_event"];

  while(true) {
    event = waittill_any_in_array_return(event_list);

    if(event != last_event && event != "pc_clear_last_event") {
      last_event = event;
      thread player_battlechatter_event_clear();
    } else if(event == "pc_clear_last_event") {
      last_event = "none";
    }

    wait 1;
  }
}

function player_battlechatter_event_clear() {
  wait 10;
  level notify("pc_clear_last_event");
}

function player_battlechatter_check_for_crate_pickups() {
  anim.player endon("death");
  level endon("player_battlechatter_off");
}

function isvalidplayerevent(straction) {
  if(!isDefined(self.squad.ismembersaying[straction]) || !isDefined(anim.isteamsaying[self.team][straction])) {
    return true;
  }

  if(!self.squad.ismembersaying[straction] && !anim.isteamsaying[self.team][straction]) {
    return true;
  }

  return false;
}