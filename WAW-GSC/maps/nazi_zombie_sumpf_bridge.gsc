/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nazi_zombie_sumpf_bridge.gsc
*********************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;

initBridgeRiser(bridge_location) {
  bridge_trigs = [];

  switch (bridge_location) {
    case "northwest":
      bridge_trigs = getEntArray("br_nw_buy_trigger", "targetname");
      array_thread(bridge_trigs, ::bridgeRiserThink, "br_nw");

      level.brVolumeNW = getent("br_nw_volume", "targetname");

      break;

    case "southeast":
      bridge_trigs = getEntArray("br_se_buy_trigger", "targetname");
      array_thread(bridge_trigs, ::bridgeRiserThink, "br_se");

      level.sgVolume = getent("br_se_volume", "targetname");

      break;

    case "southwest":
      bridge_trigs = getEntArray("br_sw_buy_trigger", "targetname");
      array_thread(bridge_trigs, ::bridgeRiserThink, "br_sw");

      level.brVolumeSW = getent("br_sw_volume", "targetname");

      break;

    default:
      AssertEx(0, "Invalid bridge location being initialized.");
  }
}
bridgeRiserThink(bridge_area_name) {
  self.is_available = undefined;
  self.in_use = 0;

  bridgeVolume = getent(bridge_area_name + "_volume", "targetname");
  bridgeTriggers = getEntArray(bridge_area_name + "_buy_trigger", "targetname");
  bridgeFX = getEntArray(bridge_area_name + "_fx", "targetname");

  while(1) {
    self waittill("trigger", who);

    if(who in_revive_trigger()) {
      continue;
    }

    if(is_player_valid(who)) {
      if(who.score >= self.zombie_cost) {
        if(!self.in_use) {
          self.in_use = 1;
          array_thread(bridgeTriggers, ::trigger_off);

          who maps\_zombiemode_score::minus_to_player_score(self.zombie_cost);
          play_sound_at_pos("purchase", self.origin);

          for(i = 0; i < bridgefx.size; i++) {
            playFX(level._effect["poltergeist"], bridgefx[i].origin);
          }

          junk = getEntArray(self.target, "targetname");
          for(i = 0; i < junk.size; i++) {
            junk[i] connectpaths();
            if(isDefined(junk[i].script_noteworthy)) {
              junk[i] notsolid();
              continue;
            }

            junk[i] thread bridgeBlockerGoAway();
          }

          delay_time = undefined;
          switch (bridge_area_name) {
            case "br_nw":
              delay_time = 20;
              break;

            case "br_sw":
              delay_time = 24;
              break;

            case "br_se":
              delay_time = 17;
              break;

            default:
              AssertEx(0, "Invalid delay time given for unknown bridge area.");
          }
          wait(delay_time);

          self thread checkBridgeVolume(bridgeVolume);

          self waittill(bridgeVolume.targetname + "_clear");

          for(i = 0; i < bridgefx.size; i++) {
            playFX(level._effect["poltergeist"], bridgefx[i].origin);
          }

          junk = getEntArray(self.target, "targetname");
          for(i = 0; i < junk.size; i++) {
            if(!isDefined(junk[i].script_noteworthy)) {
              junk[i] bridgeBlockerComeBack();
            } else {
              junk[i] solid();
            }

            junk[i] disconnectpaths();
          }

          array_thread(bridgeTriggers, ::trigger_on);
          self.in_use = 0;
        }
      }
    }
  }
}

bridgeBlockerGoAway() {
  self script_delay();
  self notsolid();

  self play_sound_on_ent("debris_move");

  self movez(82, 0.75);
}

checkBridgeVolume(bridge_volume_name) {
  playersOnBridge = true;
  players = get_players();

  while(playersOnBridge) {
    playersOnBridge = false;

    for(i = 0; i < players.size; i++) {
      if(IsAlive(players[i]) && players[i] IsTouching(bridge_volume_name)) {
        playersOnBridge = true;
        break;
      }
    }

    wait(0.1);
  }

  zombs = getaiarray("axis");
  for(i = 0; i < zombs.size; i++) {
    if(IsAlive(zombs[i]) && zombs[i] IsTouching(bridge_volume_name)) {
      zombs[i] thread force_instagib();
    }
  }

  wait(0.25);
  self notify(bridge_volume_name.targetname + "_clear");
}

#using_animtree("generic_human");
force_instagib() {
  if(!isDefined(self)) {
    return;
  }

  if(!self.gibbed) {
    direction = -1;
    if(randomintrange(0, 10) >= 5)
      direction = 1;

    self launchragdoll((randomintrange(-35, 35), randomintrange(75, 150) * direction, randomintrange(40, 60)));
    self.a.gib_ref = "head";
    self thread animscripts\death::do_gib();
    wait(1);
    self dodamage(self.health + 666, self.origin);
  }
}

bridgeBlockerComeBack() {
  self script_delay();
  self solid();

  self play_sound_on_ent("debris_move");

  self movez(-82, 0.2);
  self waittill("movedone");
}