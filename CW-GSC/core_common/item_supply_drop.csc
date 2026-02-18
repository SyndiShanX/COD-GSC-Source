/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\item_supply_drop.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_world_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace item_supply_drop;

function private autoexec __init__system__() {
  system::register(#"item_supply_drop", &preinit, undefined, undefined, #"item_world");
}

function private preinit() {
  if(!item_world_util::use_item_spawns() || util::get_game_type() === # "zsurvival") {
    return;
  }

  clientfield::register("scriptmover", "supply_drop_fx", 1, 1, "int", &supply_drop_fx, 0, 0);
  clientfield::register("scriptmover", "supply_drop_parachute_rob", 1, 1, "int", &supply_drop_parachute, 0, 0);
  clientfield::register("scriptmover", "supply_drop_portal_fx", 1, 1, "int", &supply_drop_portal_fx, 0, 0);
  clientfield::register("vehicle", "supply_drop_vehicle_landed", 1, 1, "counter", &supply_drop_vehicle_landed, 0, 0);
}

function supply_drop_parachute(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self playrenderoverridebundle(#"hash_336cece53ae2342f");
    return;
  }

  self stoprenderoverridebundle(#"hash_336cece53ae2342f");
}

function function_81431153(localclientnum) {
  self waittill(#"death");

  if(isDefined(self.supplydropfx)) {
    stopfx(localclientnum, self.supplydropfx);
  }
}

function supply_drop_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.supplydropfx = playFX(fieldname, "smoke/fx9_gamemode_fireteam_elim_signal", self.origin);
    self.var_3a55f5cf = 1;
    self thread function_81431153(fieldname);
    return;
  }

  if(isDefined(self.supplydropfx)) {
    stopfx(fieldname, self.supplydropfx);
  }
}

function supply_drop_portal_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    player = function_5c10bd79(fieldname);

    if(isDefined(self.var_227361c6)) {
      stopfx(fieldname, self.var_227361c6);
    }

    self.startpos = self.origin;
    self.var_227361c6 = playFX(fieldname, #"hash_28b5c6ccaabb4afe", self.startpos);
    return;
  }

  if(isDefined(self.var_227361c6)) {
    stopfx(fieldname, self.var_227361c6);
  }

  var_752d14c2 = self.origin;

  if(isDefined(self.startpos)) {
    var_752d14c2 = self.startpos;
  }

  self.var_227361c6 = playFX(fieldname, #"hash_45086f1ffcabbf47", var_752d14c2);
}

function supply_drop_vehicle_landed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self playrumbleonentity(bwastimejump, #"hash_6ee3e7be4dd47bed");
  self playSound(0, #"hash_531aa4857265e186");
}