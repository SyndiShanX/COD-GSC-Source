/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\zm\planemortar.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\planemortar_shared;
#using scripts\killstreaks\zm\airsupport;
#namespace planemortar;

function private autoexec __init__system__() {
  system::register(#"planemortar", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  init_shared();
  clientfield::register("scriptmover", "planemortar_contrail", 1, 1, "int", &planemortar_contrail, 0, 0);
  clientfield::register("scriptmover", "planemortar_marker_on", 1, 2, "int", &planemortar_marker_on, 0, 0);
  namespace_bf7415ae::function_fc85e1a("planemortar", &function_85f3e359, &function_e72f1d06, &show_marker, &function_4362abef);
}

function planemortar_contrail(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  params = getscriptbundle("killstreak_planemortar");
  util::waittill_dobj(fieldname);

  if(bwastimejump) {
    self.fx = util::playFXOnTag(fieldname, params.var_dcbb40c5, self, params.var_d678978c);
    self.fx = util::playFXOnTag(fieldname, params.var_2375a152, self, params.var_e5082065);
  }
}

function planemortar_marker_on(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    player = function_27673a7(fieldname);

    if(!is_true(self.allocated)) {
      namespace_bf7415ae::function_9cb260fd(fieldname, "planemortar", self);
      self.allocated = 1;
    }

    if(isPlayer(player) && isDefined(self.var_595cc3a1)) {
      player postfx::function_c8b5f318("pstfx_artillery_strike_bundle", #"hash_1dc8a3cb360b2900" + self.var_595cc3a1, 4);
    }

    return;
  }

  if(bwastimejump == 2) {
    player = function_27673a7(fieldname);

    if(isPlayer(player) && isDefined(self.var_595cc3a1)) {
      self notify(#"hash_6cb3344e363fe563");
      player postfx::function_c8b5f318("pstfx_artillery_strike_bundle", #"hash_1dc8a3cb360b2900" + self.var_595cc3a1, 4);

      if(isDefined(self.markerfx)) {
        stopfx(fieldname, self.markerfx);
      }

      player function_f43fb0d3(self);
      self.markerfx = function_239993de(fieldname, "sr/fx9_kill_streak_marker_activate", self, "tag_origin");
    }

    return;
  }

  if(bwastimejump == 3) {
    player = function_27673a7(fieldname);

    if(!is_true(self.allocated)) {
      namespace_bf7415ae::function_9cb260fd(fieldname, "planemortar", self);
      self.allocated = 1;
    }

    if(isPlayer(player) && isDefined(self.var_595cc3a1)) {
      player postfx::function_c8b5f318("pstfx_artillery_strike_bundle", #"hash_1dc8a3cb360b2900" + self.var_595cc3a1, 3);
    }

    return;
  }

  namespace_bf7415ae::function_f06fadf2(fieldname, "planemortar", self);

  if(isDefined(self.markerfx)) {
    stopfx(fieldname, self.markerfx);
  }
}

function function_85f3e359(localclientnum) {
  player = function_27673a7(localclientnum);

  if(isPlayer(player) && !player function_d2cb869e("pstfx_artillery_strike_bundle")) {
    player codeplaypostfxbundle("pstfx_artillery_strike_bundle");
  }
}

function function_e72f1d06(localclientnum) {
  player = function_27673a7(localclientnum);

  if(isPlayer(player) && player function_d2cb869e("pstfx_artillery_strike_bundle")) {
    player codestoppostfxbundle("pstfx_artillery_strike_bundle");
  }
}

function show_marker(localclientnum, marker) {
  level thread function_6a08eb03(localclientnum, marker);
  player = function_27673a7(localclientnum);

  if(isPlayer(player)) {
    player postfx::function_c8b5f318("pstfx_artillery_strike_bundle", #"hash_1dc8a3cb360b2900" + marker.var_595cc3a1, 4);
    player postfx::function_c8b5f318("pstfx_artillery_strike_bundle", #"radius " + marker.var_595cc3a1, 64);
  }
}

function function_4362abef(localclientnum, marker) {
  level notify(#"hash_29465a022d1a0d3d" + marker.var_595cc3a1);
  player = function_27673a7(localclientnum);

  if(isPlayer(player)) {
    player postfx::function_c8b5f318("pstfx_artillery_strike_bundle", #"hash_1dc8a3cb360b2900" + marker.var_595cc3a1, 0);
  }
}

function private function_f43fb0d3(marker) {
  if(isDefined(marker.origin) && isDefined(marker.var_595cc3a1)) {
    viewpos = marker.origin;
    self function_116b95e5("pstfx_artillery_strike_bundle", "Position " + marker.var_595cc3a1, viewpos[0], viewpos[1], viewpos[2]);
  }
}

function function_6a08eb03(localclientnum, marker) {
  level endon(#"end_game", #"hash_29465a022d1a0d3d" + marker.var_595cc3a1);
  marker endon(#"death", #"marker_locked");

  while(true) {
    player = function_27673a7(localclientnum);

    if(isPlayer(player)) {
      player function_f43fb0d3(marker);
    }

    waitframe(1);
  }
}