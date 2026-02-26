/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\supplydrop_shared.csc
***********************************************/

#using script_324d329b31b9b4ec;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace supplydrop;

function init_shared() {
  if(!isDefined(level.var_ba8d5308)) {
    level.var_ba8d5308 = {};
    ir_strobe::init_shared();
    params = getscriptbundle("killstreak_helicopter_guard");
    level._effect[#"heli_guard_light"][#"friendly"] = params.var_667eb0de;
    level._effect[#"heli_guard_light"][#"enemy"] = params.var_1d8c24a8;
    clientfield::register("vehicle", "supplydrop_care_package_state", 1, 1, "int", &supplydrop_care_package_state, 0, 0);
    clientfield::register("vehicle", "supplydrop_ai_tank_state", 1, 1, "int", &supplydrop_ai_tank_state, 0, 0);
    clientfield::register("vehicle", "" + # "hash_e4eb5c0853abab8", 6000, 1, "int", &function_feeeb71b, 0, 0);
    clientfield::register("scriptmover", "crate_landed", 1, 1, "int", &function_4559c532, 0, 0);

    if(sessionmodeismultiplayergame() && is_false(getgametypesetting(#"useitemspawns"))) {
      clientfield::register("scriptmover", "supply_drop_parachute_rob", 1, 1, "int", &supply_drop_parachute, 0, 0);
    }

    level.var_835198ed = getscriptbundle("killstreak_supply_drop");
  }
}

function function_4559c532(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    localplayer = function_5c10bd79(fieldname);

    if(localplayer !== self.owner) {
      self function_1f0c7136(2);
    }

    if(localplayer hasperk(fieldname, #"specialty_showscorestreakicons") || self.team == localplayer.team) {
      self setcompassicon(level.var_835198ed.var_cb98fbf7);
      self function_5e00861(isDefined(level.var_835198ed.var_c3e4af00) ? level.var_835198ed.var_c3e4af00 : 0);
      var_b13727dd = getgametypesetting("compassAnchorScorestreakIcons");
      self function_dce2238(var_b13727dd);
    }
  }
}

function function_724944f0(localclientnum) {
  player = self;
  player.markerfx = undefined;

  if(isDefined(player.markerobj)) {
    player.markerobj delete();
  }

  if(isDefined(player.markerfxhandle)) {
    killfx(localclientnum, player.markerfxhandle);
    player.markerfxhandle = undefined;
  }
}

function setupanimtree() {
  if(self hasanimtree() == 0) {
    self useanimtree("generic");
  }
}

function supplydrop_care_package_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(bwastimejump == 1) {}
}

function supplydrop_ai_tank_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self setupanimtree();

  if(bwastimejump == 1) {}
}

function updatemarkerthread(localclientnum) {
  self endoncallback(&function_724944f0, #"death");
  player = self;
  killstreakcorebundle = getscriptbundle("killstreak_core");

  while(isDefined(player.markerobj)) {
    viewangles = getlocalclientangles(localclientnum);
    forwardvector = vectorscale(anglesToForward(viewangles), killstreakcorebundle.ksmaxairdroptargetrange);
    results = bulletTrace(player getEye(), player getEye() + forwardvector, 0, player);
    player.markerobj.origin = results[#"position"];
    waitframe(1);
  }
}

function stopcrateeffects(localclientnum) {
  crate = self;

  if(isDefined(crate.thrusterfxhandle0)) {
    stopfx(localclientnum, crate.thrusterfxhandle0);
  }

  if(isDefined(crate.thrusterfxhandle1)) {
    stopfx(localclientnum, crate.thrusterfxhandle1);
  }

  if(isDefined(crate.thrusterfxhandle2)) {
    stopfx(localclientnum, crate.thrusterfxhandle2);
  }

  if(isDefined(crate.thrusterfxhandle3)) {
    stopfx(localclientnum, crate.thrusterfxhandle3);
  }

  crate.thrusterfxhandle0 = undefined;
  crate.thrusterfxhandle1 = undefined;
  crate.thrusterfxhandle2 = undefined;
  crate.thrusterfxhandle3 = undefined;
}

function cleanupthrustersthread(localclientnum) {
  crate = self;
  crate notify(#"cleanupthrustersthread_singleton");
  crate endon(#"cleanupthrustersthread_singleton");
  crate waittill(#"death");
  crate stopcrateeffects(localclientnum);
}

function supply_drop_parachute(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self playrenderoverridebundle(#"hash_336cece53ae2342f");
    return;
  }

  self stoprenderoverridebundle(#"hash_336cece53ae2342f");
}

function marker_state_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  player = self;
  killstreakcorebundle = getscriptbundle("killstreak_core");

  if(bwastimejump == 1) {
    player.markerfx = killstreakcorebundle.fxvalidlocation;
  } else if(bwastimejump == 2) {
    player.markerfx = killstreakcorebundle.fxinvalidlocation;
  } else {
    player.markerfx = undefined;
  }

  if(isDefined(player.markerobj) && !player.markerobj hasdobj(fieldname)) {
    return;
  }

  if(isDefined(player.markerfxhandle)) {
    killfx(fieldname, player.markerfxhandle);
    player.markerfxhandle = undefined;
  }

  if(isDefined(player.markerfx)) {
    if(!isDefined(player.markerobj)) {
      player.markerobj = spawn(fieldname, (0, 0, 0), "script_model");
      player.markerobj.angles = (270, 0, 0);
      player.markerobj setModel(#"wpn_t7_none_world");
      player.markerobj util::waittill_dobj(fieldname);
      player thread updatemarkerthread(fieldname);
    }

    player.markerfxhandle = util::playFXOnTag(fieldname, player.markerfx, player.markerobj, "tag_origin");
    return;
  }

  if(isDefined(player.markerobj)) {
    player.markerobj delete();
  }
}

function function_feeeb71b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self.var_7246dab7 = util::playFXOnTag(fieldname, #"hash_5677371ed9b935dd", self, "tag_body");
    return;
  }

  if(isDefined(self.var_7246dab7)) {
    killfx(fieldname, self.var_7246dab7);
    self.var_7246dab7 = undefined;
  }
}