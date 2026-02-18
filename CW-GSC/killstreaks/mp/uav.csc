/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\uav.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\system_shared;
#namespace uav;

function private autoexec __init__system__() {
  system::register(#"uav", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  clientfield::register("scriptmover", "uav", 1, 1, "int", &spawned, 0, 0);
  clientfield::register("scriptmover", "uav_fx", 1, 1, "int", &function_5a528883, 0, 0);
  level.uav_bundle = getscriptbundle(function_6fe2ffad());
  level.var_ac260ded = [];
}

function spawned(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    function_1877b7a1(fieldname, self getentitynumber(), level.uav_bundle.var_dd0e1146, level.uav_bundle.var_dd0e1146);
    self thread uav_think(fieldname);
    self renderoverridebundle::function_f4eab437(fieldname, 1, #"rob_sonar_set_enemy");
    return;
  }

  self notify(#"uav_off");
}

function private function_6fe2ffad() {
  if(sessionmodeiswarzonegame()) {
    return "killstreak_uav_wz";
  }

  return "killstreak_uav";
}

function uav_think(localclientnum) {
  arrayremovevalue(level.var_ac260ded, undefined, 0);
  level.var_ac260ded[level.var_ac260ded.size] = self;
  self waittill(#"death", #"uav_off");
  function_74ef482c(localclientnum, self getentitynumber());
  arrayremovevalue(level.var_ac260ded, self, 0);
}

function function_9784b3bf() {
  self endon(#"death", #"uav_off");
  level waittill(#"new_uav");

  if(isDefined(self)) {
    self function_811196d1(1);
  }
}

function function_5a528883(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.killstreakbundle)) {
    self.killstreakbundle = level.uav_bundle;
  }

  if(!self function_ca024039()) {
    if(bwastimejump) {
      self.var_2695439d = self playLoopSound(#"veh_uav_engine_loop", 1);
      self thread fx_think(fieldname);
      self.killstreakbundle = level.uav_bundle;
      self setcompassicon(self.killstreakbundle.var_cb98fbf7);
      self function_dce2238(1);
      self function_8e04481f();
      self function_27351ff6();
      level notify(#"new_uav");
      self thread function_9784b3bf();
      return;
    }

    self notify(#"hash_780b1fb5c050cdc0");
  }
}

function fx_think(localclientnum) {
  self waittill(#"death", #"hash_780b1fb5c050cdc0");
  self stoploopsound(self.var_2695439d);
}