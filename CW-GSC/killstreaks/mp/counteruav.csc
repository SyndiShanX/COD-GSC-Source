/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\counteruav.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\system_shared;
#namespace counteruav;

function private autoexec __init__system__() {
  system::register(#"counteruav", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  clientfield::register("scriptmover", "counteruav", 1, 1, "int", &enabled, 0, 0);
  clientfield::register("scriptmover", "counteruav_fx", 1, 1, "int", &function_5a528883, 0, 0);
  level.var_8c4291cb = [];
  level.var_a03cd507 = getscriptbundle(function_df836293());
  level.counteruavs = [];
}

function private function_df836293() {
  if(sessionmodeiswarzonegame()) {
    return "killstreak_counteruav_wz";
  }

  return "killstreak_counteruav";
}

function enabled(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self renderoverridebundle::function_f4eab437(fieldname, 1, #"rob_sonar_set_enemy");
    function_e5a9ae33(fieldname, self getentitynumber(), level.var_a03cd507.var_c23de6e6);
    self thread function_c2aa1607(fieldname);
    self.killstreakbundle = level.var_a03cd507;
    return;
  }

  self notify(#"counteruav_off");
}

function function_c2aa1607(localclientnum) {
  arrayremovevalue(level.counteruavs, undefined, 0);
  level.counteruavs[level.counteruavs.size] = self;
  self waittill(#"death", #"counteruav_off");
  function_4236032b(localclientnum, self getentitynumber());
  arrayremovevalue(level.counteruavs, self, 0);
}

function function_d8f4d00d() {
  self endon(#"death", #"counteruav_off");
  level waittill("new_cuav_" + self.team);

  if(isDefined(self)) {
    self function_811196d1(1);
  }
}

function function_5a528883(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.killstreakbundle)) {
    self.killstreakbundle = level.var_a03cd507;
  }

  if(!self function_ca024039()) {
    if(bwastimejump) {
      self.var_2695439d = self playLoopSound(#"veh_uav_engine_loop", 1);
      self thread fx_think(fieldname);
    } else {
      self notify(#"hash_286d0c022220571a");
    }
  }

  if(bwastimejump) {
    self setcompassicon(self.killstreakbundle.var_cb98fbf7);
    self function_dce2238(1);
    self function_8e04481f();
    level notify("new_cuav_" + self.team);
    self thread function_d8f4d00d();
  }
}

function fx_think(localclientnum) {
  self waittill(#"death", #"hash_286d0c022220571a");
  self stoploopsound(self.var_2695439d);
}