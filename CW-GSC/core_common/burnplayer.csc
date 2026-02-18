/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\burnplayer.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace burnplayer;

function private autoexec __init__system__() {
  system::register(#"burnplayer", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("allplayers", "burn", 1, 1, "int", &burning_callback, 0, 1);
  clientfield::register("allplayers", "burn_fx_3p", 11001, 1, "int", &function_3caf53f1, 0, 1);
  clientfield::register("playercorpse", "burned_effect", 1, 1, "int", &burning_corpse_callback, 0, 1);
  loadeffects();
  callback::on_localplayer_spawned(&on_localplayer_spawned);
  callback::on_localclient_connect(&on_local_client_connect);
}

function loadeffects() {
  level.burntags = [];
}

function on_local_client_connect(localclientnum) {}

function on_localplayer_spawned(localclientnum) {
  if(self function_21c0fa55() && self clientfield::get("burn") == 0 && self postfx::function_556665f2(#"pstfx_burn_loop")) {
    self postfx::stoppostfxbundle(#"pstfx_burn_loop");
  }
}

function burning_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self function_a6cb96f(fieldname);
    self function_adae7d84(fieldname);
    return;
  }

  self function_8227cec3(fieldname);
  self function_68a11df6(fieldname);
}

function function_3caf53f1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self function_adae7d84(fieldname, 1);
    return;
  }

  self function_68a11df6(fieldname);
}

function burning_corpse_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self set_corpse_burning(fieldname);
    return;
  }

  self function_8227cec3(fieldname);
  self function_68a11df6(fieldname);
}

function set_corpse_burning(localclientnum) {
  self thread _burnbody(localclientnum, 1);
}

function function_8227cec3(localclientnum) {
  if(self function_21c0fa55()) {
    if(self postfx::function_556665f2(#"pstfx_burn_loop")) {
      self postfx::stoppostfxbundle(#"pstfx_burn_loop");
    }

    if(is_true(self.var_bd048859)) {
      self playSound(0, #"hash_41520794c2fd8aa");
      self.var_bd048859 = 0;
    }
  }
}

function function_68a11df6(localclientnum) {
  self notify(#"burn_off");
}

function function_a6cb96f(localclientnum) {
  if(self function_21c0fa55() && !isthirdperson(localclientnum) && !self isremotecontrolling(localclientnum)) {
    self thread burn_on_postfx();
  }
}

function function_adae7d84(localclientnum, use_tagfxset = 0) {
  if(!self function_21c0fa55() || isthirdperson(localclientnum)) {
    self thread _burnbody(localclientnum, use_tagfxset);
  }
}

function burn_on_postfx() {
  self endon(#"burn_off");
  self endon(#"death");
  self notify(#"burn_on_postfx");
  self endon(#"burn_on_postfx");
  self playSound(0, #"hash_791f349cb716e078");
  self.var_bd048859 = 1;
  self thread postfx::playpostfxbundle(#"pstfx_burn_loop");
}

function private _burntag(localclientnum, tag, postfix) {
  if(isDefined(self) && self hasdobj(localclientnum)) {
    fxname = "burn_" + tag + postfix;

    if(isDefined(level._effect[fxname])) {
      return util::playFXOnTag(localclientnum, level._effect[fxname], self, tag);
    }
  }
}

function private _burntagson(localclientnum, tags, use_tagfxset) {
  if(!isDefined(self)) {
    return;
  }

  self endon(#"death");
  self endon(#"burn_off");
  self notify(#"burn_tags_on");
  self endon(#"burn_tags_on");

  if(use_tagfxset) {
    self util::waittill_dobj(localclientnum);
    activefx = playtagfxset(localclientnum, "weapon_hero_molotov_fire_3p", self);
  } else {
    activefx = [];

    for(i = 0; i < tags.size; i++) {
      activefx[activefx.size] = self _burntag(localclientnum, tags[i], "_loop");
    }
  }

  playSound(0, #"chr_ignite", self.origin);
  burnsound = self playLoopSound(#"chr_burn_loop_overlay", 0.5);
  self thread _burntagswatchend(localclientnum, activefx, burnsound);
  self thread _burntagswatchclear(localclientnum, activefx, burnsound);
}

function private _burnbody(localclientnum, use_tagfxset = 0) {
  self endon(#"death");
  self thread _burntagson(localclientnum, level.burntags, use_tagfxset);
}

function private _burntagswatchend(localclientnum, fxarray, burnsound) {
  self waittill(#"burn_off", #"death");

  if(isDefined(self) && isDefined(burnsound)) {
    self stoploopsound(burnsound, 1);
  }

  if(isDefined(fxarray)) {
    foreach(fx in fxarray) {
      stopfx(localclientnum, fx);
    }
  }
}

function private _burntagswatchclear(localclientnum, fxarray, burnsound) {
  self endon(#"burn_off");
  self waittill(#"death");

  if(isDefined(burnsound)) {
    stopsound(burnsound);
  }

  if(isDefined(fxarray)) {
    foreach(fx in fxarray) {
      stopfx(localclientnum, fx);
    }
  }
}