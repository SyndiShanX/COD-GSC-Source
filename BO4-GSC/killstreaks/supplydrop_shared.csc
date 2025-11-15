/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\supplydrop_shared.csc
***********************************************/

#include script_324d329b31b9b4ec;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;

#namespace supplydrop;

init_shared() {
  if(!isDefined(level.var_ba8d5308)) {
    level.var_ba8d5308 = {};
    ir_strobe::init_shared();
    level.chopper_fx[#"damage"][#"light_smoke"] = "destruct/fx8_atk_chppr_smk_trail";
    level.chopper_fx[#"damage"][#"heavy_smoke"] = "destruct/fx8_atk_chppr_exp_trail";
    level._effect[#"qrdrone_prop"] = #"hash_6cd811fe548313ca";
    level._effect[#"heli_guard_light"][#"friendly"] = #"killstreaks/fx_sc_lights_grn";
    level._effect[#"heli_guard_light"][#"enemy"] = #"killstreaks/fx_sc_lights_red";
    level._effect[#"heli_comlink_light"][#"common"] = #"killstreaks/fx_drone_hunter_lights";
    level._effect[#"heli_gunner_light"][#"friendly"] = #"killstreaks/fx_vtol_lights_grn";
    level._effect[#"heli_gunner_light"][#"enemy"] = #"killstreaks/fx_vtol_lights_red";
    level._effect[#"heli_gunner"][#"vtol_fx"] = #"killstreaks/fx_vtol_thruster";
    level._effect[#"heli_gunner"][#"vtol_fx_ft"] = #"killstreaks/fx_vtol_thruster";
    clientfield::register("vehicle", "supplydrop_care_package_state", 1, 1, "int", &supplydrop_care_package_state, 0, 0);
    clientfield::register("vehicle", "supplydrop_ai_tank_state", 1, 1, "int", &supplydrop_ai_tank_state, 0, 0);
    clientfield::register("scriptmover", "supplydrop_thrusters_state", 1, 1, "int", &setsupplydropthrustersstate, 0, 0);
    clientfield::register("scriptmover", "aitank_thrusters_state", 1, 1, "int", &setaitankhrustersstate, 0, 0);
  }
}

function_724944f0(localclientnum) {
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

setupanimtree() {
  if(self hasanimtree() == 0) {
    self useanimtree("generic");
  }
}

supplydrop_care_package_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self setupanimtree();

  if(newval == 1) {
    self setanim(#"o_drone_supply_care_idle", 1, 0, 1);
    return;
  }

  self setanim(#"o_drone_supply_care_drop", 1, 0, 0.3);
}

supplydrop_ai_tank_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self setupanimtree();

  if(newval == 1) {}
}

updatemarkerthread(localclientnum) {
  self endoncallback(&function_724944f0, #"death");
  player = self;
  killstreakcorebundle = struct::get_script_bundle("killstreak", "killstreak_core");

  while(isDefined(player.markerobj)) {
    viewangles = getlocalclientangles(localclientnum);
    forwardvector = vectorscale(anglesToForward(viewangles), killstreakcorebundle.ksmaxairdroptargetrange);
    results = bulletTrace(player getEye(), player getEye() + forwardvector, 0, player);
    player.markerobj.origin = results[#"position"];
    waitframe(1);
  }
}

stopcrateeffects(localclientnum) {
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

cleanupthrustersthread(localclientnum) {
  crate = self;
  crate notify(#"cleanupthrustersthread_singleton");
  crate endon(#"cleanupthrustersthread_singleton");
  crate waittill(#"death");
  crate stopcrateeffects(localclientnum);
}

setsupplydropthrustersstate(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  crate = self;
  params = struct::get_script_bundle("killstreak", "killstreak_supply_drop");

  if(newval != oldval && isDefined(params.ksthrusterfx)) {
    if(newval == 1) {
      crate stopcrateeffects(localclientnum);
      crate.thrusterfxhandle0 = util::playFXOnTag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_01");
      crate.thrusterfxhandle1 = util::playFXOnTag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_02");
      crate.thrusterfxhandle2 = util::playFXOnTag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_03");
      crate.thrusterfxhandle3 = util::playFXOnTag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_04");
      crate thread cleanupthrustersthread(localclientnum);
      return;
    }

    crate stopcrateeffects(localclientnum);
  }
}

setaitankhrustersstate(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  crate = self;
  params = struct::get_script_bundle("killstreak", "killstreak_tank_robot");

  if(newval != oldval && isDefined(params.ksthrusterfx)) {
    if(newval == 1) {
      crate stopcrateeffects(localclientnum);
      crate.thrusterfxhandle0 = util::playFXOnTag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_01");
      crate.thrusterfxhandle1 = util::playFXOnTag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_02");
      crate.thrusterfxhandle2 = util::playFXOnTag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_03");
      crate.thrusterfxhandle3 = util::playFXOnTag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_04");
      crate thread cleanupthrustersthread(localclientnum);
      return;
    }

    crate stopcrateeffects(localclientnum);
  }
}

marker_state_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  player = self;
  killstreakcorebundle = struct::get_script_bundle("killstreak", "killstreak_core");

  if(newval == 1) {
    player.markerfx = killstreakcorebundle.fxvalidlocation;
  } else if(newval == 2) {
    player.markerfx = killstreakcorebundle.fxinvalidlocation;
  } else {
    player.markerfx = undefined;
  }

  if(isDefined(player.markerobj) && !player.markerobj hasdobj(localclientnum)) {
    return;
  }

  if(isDefined(player.markerfxhandle)) {
    killfx(localclientnum, player.markerfxhandle);
    player.markerfxhandle = undefined;
  }

  if(isDefined(player.markerfx)) {
    if(!isDefined(player.markerobj)) {
      player.markerobj = spawn(localclientnum, (0, 0, 0), "script_model");
      player.markerobj.angles = (270, 0, 0);
      player.markerobj setModel(#"wpn_t7_none_world");
      player.markerobj util::waittill_dobj(localclientnum);
      player thread updatemarkerthread(localclientnum);
    }

    player.markerfxhandle = util::playFXOnTag(localclientnum, player.markerfx, player.markerobj, "tag_origin");
    return;
  }

  if(isDefined(player.markerobj)) {
    player.markerobj delete();
  }
}