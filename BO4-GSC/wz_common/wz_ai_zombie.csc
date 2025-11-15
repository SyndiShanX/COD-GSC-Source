/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_ai_zombie.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace wz_ai_zombie;

autoexec __init__system__() {
  system::register(#"wz_ai_zombie", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("actor", "zombie_riser_fx", 1, 1, "int", &handle_zombie_risers, 1, 1);
  clientfield::register("actor", "zombie_has_eyes_col", 13000, 2, "int", &zombie_eyes_clientfield_cb, 0, 0);
  clientfield::register("actor", "zombie_has_microwave", 1, 1, "int", &function_bee29da4, 0, 0);
  clientfield::register("toplayer", "zombie_vehicle_shake", 19000, 1, "counter", &function_3acc8ce4, 0, 0);
  level._effect[#"rise_burst"] = #"zombie/fx_spawn_dirt_hand_burst_zmb";
  level._effect[#"rise_billow"] = #"zombie/fx_spawn_dirt_body_billowing_zmb";
  level._effect[#"eye_glow"] = #"zm_ai/fx8_zombie_eye_glow_orange";
  level._effect[#"eye_glow_blue"] = #"wz/fx8_zombie_eye_glow_blue_wz";
  level._effect[#"eye_glow_green"] = #"wz/fx8_zombie_eye_glow_green_wz";
  level._effect[#"microwave_attack"] = #"hash_6b67cc3e876119c1";
}

handle_zombie_risers(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(newval) {
    localplayers = level.localplayers;
    playSound(0, #"zmb_zombie_spawn", self.origin);
    burst_fx = level._effect[#"rise_burst"];
    billow_fx = level._effect[#"rise_billow"];

    for(i = 0; i < localplayers.size; i++) {
      self thread rise_dust_fx(localclientnum, billow_fx, burst_fx);
    }
  }
}

rise_dust_fx(clientnum, billow_fx, burst_fx) {
  self endon(#"death");
  dust_tag = "J_SpineUpper";

  if(isDefined(burst_fx)) {
    playFX(clientnum, burst_fx, self.origin + (0, 0, randomintrange(5, 10)));
  }

  wait 0.25;

  if(isDefined(billow_fx)) {
    playFX(clientnum, billow_fx, self.origin + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(5, 10)));
  }
}

zombie_eyes_clientfield_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.eye_rob)) {
    self stoprenderoverridebundle(self.eye_rob, "j_head");
  }

  if(isDefined(self.var_3231a850)) {
    stopfx(localclientnum, self.var_3231a850);
    self.var_3231a850 = undefined;
  }

  if(newval > 0) {
    if(newval == 2) {
      self.eye_rob = "rob_zm_eyes_blue";
      var_d40cd873 = "eye_glow_blue";
    } else if(newval == 3) {
      self.eye_rob = "rob_zm_eyes_green";
      var_d40cd873 = "eye_glow_green";
    } else {
      self.eye_rob = "rob_zm_eyes_red";
      var_d40cd873 = "eye_glow";
      self playrenderoverridebundle(self.eye_rob, "j_head");
    }

    self.var_3231a850 = util::playFXOnTag(localclientnum, level._effect[var_d40cd873], self, "j_eyeball_le");
    self enableonradar();
  }
}

function_bee29da4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_165c58d7)) {
    stopfx(localclientnum, self.var_165c58d7);
    self.var_165c58d7 = undefined;
  }

  if(newval) {
    self.var_165c58d7 = util::playFXOnTag(localclientnum, level._effect[#"microwave_attack"], self, "j_head");
  }
}

function_3acc8ce4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  id = earthquake(localclientnum, 0.3, 1, self.origin, 1000);
  playrumbleonposition(localclientnum, "grenade_rumble", self.origin);
}