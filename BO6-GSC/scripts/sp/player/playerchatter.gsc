/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\player\playerchatter.gsc
***********************************************/

#using scripts\anim\battlechatter;
#using scripts\engine\utility;
#namespace playerchatter;

function init_playerchatter() {
  anim.player.battlechatter = spawnStruct();
  anim.player.battlechatter.countryid = getplayernameid();
  anim.player.battlechatter.enemyclass = "\xb9\xdb6d-\xb2\xc9";
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
  human_player = getEntArray("K_p\x84a\x01", #classname)[0];
  player_update_allowed_callouts();
  anim.player = human_player;

  if(!isDefined(anim.player.team)) {
    anim.player.team = "O\x15\x1b\xad\x9ff";
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

  while(isalive(anim.player) && battlechatter::bcsenabled() && isDefined(anim.player.battlechatterallowed) && anim.player.battlechatterallowed) {
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
    level waittill("\x87\xccbI\xfctq\xacy\xd1\x05\xad\x94\xee\x05\x8a\x1dq9\xe6M\xfa\x8d\x19=F#$");

    while(anim.player.battlechatter.isspeaking != 0) {
      wait 0.5;
    }
  }
}

function player_battlechatter_generic_event_check() {
  anim.player endon("\x1e\xfd\xd1\xa2\a");
  level endon("r\xce\xe8\xad?-@\xab\xcb\x15\x9f9\x94\xe8\xfaP\xf3\xc6\xe0\xfa[\xc5\xbc\x1b");
  last_event = "\r+x5";
  event_list = ["\xa4M\xad2\xaf\x1aWgzel\xaaZK-w2U\xee", "@\b\x8e\xcc\x12*\b\xf3\xc1I\x1f\x82\x17 d\xca\xa5*4A", "\xea?\xdf\x80\x8e\x8a\xed\xe3\xa2\xbe\xd7\xac\x1f\xcdY\xc6h", "E\x1a\x1e\x15\x19\x1d\xc07\xfbf\x87\x17\x9c\xea", "\xf7\aG\xe2\rP\xbaJ\x1e\xe7\xf4wg|\xe2\x1fD\b\xe6"];

  while(true) {
    event = utility::waittill_any_in_array_return(event_list);

    if(event != last_event && event != "\xf7\aG\xe2\rP\xbaJ\x1e\xe7\xf4wg|\xe2\x1fD\b\xe6") {
      last_event = event;
      thread player_battlechatter_event_clear();
    } else if(event == "\xf7\aG\xe2\rP\xbaJ\x1e\xe7\xf4wg|\xe2\x1fD\b\xe6") {
      last_event = "\r+x5";
    }

    wait 1;
  }
}

function player_battlechatter_event_clear() {
  wait 10;
  level notify("\xf7\aG\xe2\rP\xbaJ\x1e\xe7\xf4wg|\xe2\x1fD\b\xe6");
}

function player_battlechatter_check_for_crate_pickups() {
  anim.player endon("\x1e\xfd\xd1\xa2\a");
  level endon("r\xce\xe8\xad?-@\xab\xcb\x15\x9f9\x94\xe8\xfaP\xf3\xc6\xe0\xfa[\xc5\xbc\x1b");
}

function isvalidplayerevent(straction) {
  if(!(isDefined(self.squad.ismembersaying[straction]) && isDefined(anim.isteamsaying[self.team][straction]))) {
    return true;
  }

  if(!self.squad.ismembersaying[straction] && !anim.isteamsaying[self.team][straction]) {
    return true;
  }

  return false;
}