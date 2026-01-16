/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_324d329b31b9b4ec.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;

#namespace ir_strobe;

init_shared() {
  if(!isDefined(level.var_90058911)) {
    level.var_90058911 = {};
    clientfield::register("toplayer", "marker_state", 1, 2, "int", &marker_state_changed, 0, 0);
    level.var_9c4cdb79 = [];
  }

  forcestreamxmodel(#"hash_5f05548d8aa53dc1");
  forcestreamxmodel(#"hash_5770a33506bee5a4");
}

updatemarkerthread(localclientnum) {
  self endon(#"death");
  player = self;
  localplayer = function_27673a7(localclientnum);

  if(player != localplayer) {
    return;
  }

  killstreakcorebundle = struct::get_script_bundle("killstreak", "killstreak_core");

  while(isDefined(player.markerobj)) {
    viewangles = getlocalclientangles(localclientnum);
    forwardvector = vectorscale(anglesToForward(viewangles), killstreakcorebundle.ksmaxairdroptargetrange);
    results = bulletTrace(player getEye(), player getEye() + forwardvector, 0, player);
    player.markerobj.origin = results[#"position"];
    waitframe(1);
  }
}

marker_state_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  player = self;
  killstreakcorebundle = struct::get_script_bundle("killstreak", "killstreak_core");

  if(newval > 0) {
    if(!isDefined(level.var_9c4cdb79[localclientnum])) {
      spawn_previs(localclientnum);
    }
  }

  if(newval > 0) {
    player thread previs(localclientnum, newval - 1);
  } else {
    player notify(#"stop_previs");
  }

  if(isDefined(player.markerobj) && !player.markerobj hasdobj(localclientnum)) {
    return;
  }
}

function_6f798989(var_a27f7ab4) {
  if(function_9d295a8c(self.localclientnum)) {
    localclientnum = self.localclientnum;
  } else {
    localclientnum = self getlocalclientnumber();
  }

  if(isDefined(localclientnum) && isDefined(level.var_9c4cdb79[localclientnum])) {
    level.var_9c4cdb79[localclientnum] hide();
  }
}

previs(localclientnum, invalid) {
  self notify(#"stop_previs");
  self endoncallback(&function_6f798989, #"death", #"weapon_change", #"stop_previs");
  level.var_9c4cdb79[localclientnum] show();
  function_3e8d9b27(!invalid, localclientnum);

  while(true) {
    update_previs(localclientnum, invalid);
    waitframe(1);
  }
}

spawn_previs(localclientnum) {
  localplayer = function_5c10bd79(localclientnum);
  level.var_9c4cdb79[localclientnum] = spawn(localclientnum, (0, 0, 0), "script_model", localplayer getentitynumber());
}

update_previs(localclientnum, invalid) {
  player = self;
  facing_angles = getlocalclientangles(localclientnum);
  forward = anglesToForward(facing_angles);
  up = anglestoup(facing_angles);
  weapon = getweapon("ir_strobe");
  velocity = function_711c258(forward, up, weapon);
  eye_pos = getlocalclienteyepos(localclientnum);

  if(isDefined(level.var_4970b0af) && level.var_4970b0af) {
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

function_3e8d9b27(validlocation, localclientnum) {
  if(validlocation) {
    level.var_9c4cdb79[localclientnum] setModel(#"hash_5f05548d8aa53dc1");

    if(isDefined(level.var_5af693e8)) {
      stopfx(localclientnum, level.var_5af693e8);
    }

    level.var_5af693e8 = function_239993de(localclientnum, "killstreaks/fx8_tankrobot_previs_valid", level.var_9c4cdb79[localclientnum], "tag_fx");
  } else {
    level.var_9c4cdb79[localclientnum] setModel(#"hash_5770a33506bee5a4");

    if(isDefined(level.var_5af693e8)) {
      stopfx(localclientnum, level.var_5af693e8);
    }

    level.var_5af693e8 = function_239993de(localclientnum, "killstreaks/fx8_tankrobot_previs_invalid", level.var_9c4cdb79[localclientnum], "tag_fx");
  }

  level.var_9c4cdb79[localclientnum] notsolid();
}