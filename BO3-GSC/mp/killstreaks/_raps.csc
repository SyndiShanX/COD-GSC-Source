/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\killstreaks\_raps.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\vehicles\_raps;
#namespace raps_mp;

function autoexec __init__sytem__() {
  system::register("raps_mp", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("vehicle", "monitor_raps_drop_landing", 1, 1, "int", & monitor__drop_landing_changed, 0, 0);
  clientfield::register("vehicle", "raps_heli_low_health", 1, 1, "int", & heli_low_health_fx, 0, 0);
  clientfield::register("vehicle", "raps_heli_extra_low_health", 1, 1, "int", & heli_extra_low_health_fx, 0, 0);
}

function heli_low_health_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 0) {
    return;
  }
  self endon("entityshutdown");
  vehicle::wait_for_dobj(localclientnum);
  playFXOnTag(localclientnum, "killstreaks/fx_heli_raps_exp_trail", self, "tag_fx_engine_left_front");
}

function heli_extra_low_health_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 0) {
    return;
  }
  self endon("entityshutdown");
  vehicle::wait_for_dobj(localclientnum);
  playFXOnTag(localclientnum, "killstreaks/fx_heli_raps_exp_trail", self, "tag_fx_engine_right_back");
}

function monitor__drop_landing_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!newval) {
    return;
  }
  self thread monitor_drop_landing(localclientnum);
}

function monitor_drop_landing(localclientnum) {
  self endon("entityshutdown");
  self notify("monitor_drop_landing_entity_singleton");
  self endon("monitor_drop_landing_entity_singleton");
  a_trace = bulletTrace(self.origin + (vectorscale((0, 0, -1), 200)), self.origin + (vectorscale((0, 0, -1), 5000)), 0, self, 1);
  v_ground = a_trace["position"];
  wait(0.5);
  whoosh_distance = 0;
  if(isDefined(v_ground)) {
    not_close_enough_to_ground = 1;
    while(not_close_enough_to_ground) {
      velocity = self getvelocity();
      whoosh_distance = max(whoosh_distance, (abs(velocity[2]) * 0.15) + ((193.044 * 0.15) * 0.15));
      whoosh_distance_squared = whoosh_distance * whoosh_distance;
      distance_squared = distancesquared(self.origin, v_ground);
      not_close_enough_to_ground = distance_squared > whoosh_distance_squared;
      if(not_close_enough_to_ground) {
        wait((distance_squared > (whoosh_distance_squared * 4) ? 0.1 : 0.05));
      }
    }
    self playSound(localclientnum, "veh_raps_first_land");
  }
  while(distancesquared(self.origin, v_ground) > 576 || velocity[2] <= 0) {
    velocity = self getvelocity();
    wait(0.016);
  }
  bundle = struct::get_script_bundle("killstreak", "killstreak_" + "raps");
  if(isDefined(bundle) && isDefined(bundle.ksdropdeploylandsurfacefxtable) && isDefined(a_trace["surfacetype"])) {
    fx_to_play = getfxfromsurfacetable(bundle.ksdropdeploylandsurfacefxtable, a_trace["surfacetype"]);
    if(isDefined(fx_to_play)) {
      playFX(localclientnum, fx_to_play, self.origin);
    }
  }
  if(isDefined(bundle) && isDefined(bundle.ksdropdeploylandfx)) {
    playFX(localclientnum, bundle.ksdropdeploylandfx, self.origin);
  }
  playrumbleonposition(localclientnum, "raps_land", self.origin);
}