/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_324d329b31b9b4ec.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#namespace ir_strobe;

function init_shared() {
  if(!isDefined(level.var_90058911)) {
    level.var_90058911 = {};
    clientfield::register("toplayer", "marker_state", 1, 2, "int", &marker_state_changed, 0, 0);
    level.var_9c4cdb79 = [];
  }

  forcestreamxmodel(#"wpn_t9_eqp_smoke_grenade_world_yellow");
  forcestreamxmodel(#"wpn_t9_eqp_smoke_grenade_world_red");
}

function updatemarkerthread(localclientnum) {
  self endon(#"death");
  player = self;
  localplayer = function_27673a7(localclientnum);

  if(player != localplayer) {
    return;
  }

  killstreakcorebundle = getscriptbundle("killstreak_core");

  while(isDefined(player.markerobj)) {
    viewangles = getlocalclientangles(localclientnum);
    forwardvector = vectorscale(anglesToForward(viewangles), killstreakcorebundle.ksmaxairdroptargetrange);
    results = bulletTrace(player getEye(), player getEye() + forwardvector, 0, player);
    player.markerobj.origin = results[#"position"];
    waitframe(1);
  }
}

function marker_state_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  player = self;
  killstreakcorebundle = getscriptbundle("killstreak_core");

  if(bwastimejump > 0) {
    if(!isDefined(level.var_9c4cdb79[fieldname])) {
      spawn_previs(fieldname);
    }
  }

  if(bwastimejump > 0) {
    player thread previs(fieldname, bwastimejump - 1);
  } else {
    player notify(#"stop_previs");
  }

  if(isDefined(player.markerobj) && !player.markerobj hasdobj(fieldname)) {
    return;
  }
}

function function_2b804e42(localclientnum) {
  self waittill(#"death", #"weapon_change", #"stop_previs");

  if(isDefined(level.var_9c4cdb79[localclientnum])) {
    level.var_9c4cdb79[localclientnum] hide();
  }
}

function previs(localclientnum, invalid) {
  self notify(#"stop_previs");
  self endon(#"death", #"weapon_change", #"stop_previs");
  level.var_9c4cdb79[localclientnum] show();
  self thread function_2b804e42(localclientnum);
  function_3e8d9b27(!invalid, localclientnum);

  while(true) {
    update_previs(localclientnum, invalid);
    waitframe(1);
  }
}

function spawn_previs(localclientnum) {
  localplayer = function_5c10bd79(localclientnum);
  level.var_9c4cdb79[localclientnum] = spawn(localclientnum, (0, 0, 0), "script_model", localplayer getentitynumber());
}

function update_previs(localclientnum, invalid) {
  player = self;
  facing_angles = getlocalclientangles(localclientnum);
  forward = anglesToForward(facing_angles);
  up = anglestoup(facing_angles);
  weapon = getweapon("ir_strobe");
  velocity = function_711c258(forward, up, weapon);
  eye_pos = getlocalclienteyepos(localclientnum);

  if(is_true(level.var_4970b0af)) {
    radius = 10;
    trace1 = bulletTrace(eye_pos, eye_pos + vectorscale(forward, 300), 0, player, 1);

    if(trace1[#"fraction"] >= 1) {
      trace1 = bulletTrace(trace1[#"position"], trace1[#"position"] + (0, 0, -1000), 0, player, 1);
    }
  } else {
    trace1 = projectiletrace(eye_pos, velocity, 0, weapon);
  }

  level.var_9c4cdb79[localclientnum].origin = trace1[#"position"] + vectorscale(trace1[#"normal"], 7);
  level.var_9c4cdb79[localclientnum].angles = (0, vectortoangles(forward)[1] + 90, 0);
  level.var_9c4cdb79[localclientnum].hitent = trace1[#"entity"];

  if(invalid) {
    player function_bf191832(0, (0, 0, 0), (0, 0, 0));
    return;
  }

  player function_bf191832(1, level.var_9c4cdb79[localclientnum].origin, level.var_9c4cdb79[localclientnum].angles);
}

function function_3e8d9b27(validlocation, localclientnum) {
  if(validlocation) {
    level.var_9c4cdb79[localclientnum] setModel(#"wpn_t9_eqp_smoke_grenade_world_yellow");

    if(isDefined(level.var_5af693e8)) {
      stopfx(localclientnum, level.var_5af693e8);
    }

    level.var_5af693e8 = function_239993de(localclientnum, "killstreaks/fx8_tankrobot_previs_valid", level.var_9c4cdb79[localclientnum], "tag_fx");
  } else {
    level.var_9c4cdb79[localclientnum] setModel(#"wpn_t9_eqp_smoke_grenade_world_red");

    if(isDefined(level.var_5af693e8)) {
      stopfx(localclientnum, level.var_5af693e8);
    }

    level.var_5af693e8 = function_239993de(localclientnum, "killstreaks/fx8_tankrobot_previs_invalid", level.var_9c4cdb79[localclientnum], "tag_fx");
  }

  level.var_9c4cdb79[localclientnum] notsolid();
}