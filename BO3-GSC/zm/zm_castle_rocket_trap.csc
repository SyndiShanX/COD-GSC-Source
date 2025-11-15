/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_castle_rocket_trap.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\audio_shared;
#using scripts\shared\clientfield_shared;
#namespace zm_castle_rocket_trap;

function main() {
  register_clientfields();
}

function register_clientfields() {
  clientfield::register("world", "rocket_trap_warning_smoke", 1, 1, "int", & rocket_trap_warning_smoke, 0, 0);
  clientfield::register("world", "rocket_trap_warning_fire", 1, 1, "int", & rocket_trap_warning_fire, 0, 0);
  clientfield::register("world", "sndRocketAlarm", 5000, 2, "int", & sndrocketalarm, 0, 0);
  clientfield::register("world", "sndRocketTrap", 5000, 3, "int", & sndrockettrap, 0, 0);
}

function rocket_trap_warning_smoke(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_52d911b7 = struct::get("rocket_trap_warning_smoke", "targetname");
  v_forward = anglesToForward(var_52d911b7.angles);
  v_up = anglestoup(var_52d911b7.angles);
  if(isDefined(var_52d911b7.a_fx_id)) {
    for(j = 0; j < var_52d911b7.a_fx_id.size; j++) {
      deletefx(localclientnum, var_52d911b7.a_fx_id[j], 0);
    }
    var_52d911b7.a_fx_id = [];
  }
  if(newval) {
    if(!isDefined(var_52d911b7.a_fx_id)) {
      var_52d911b7.a_fx_id = [];
    }
    var_52d911b7.a_fx_id[localclientnum] = playFX(localclientnum, level._effect["rocket_warning_smoke"], var_52d911b7.origin, v_forward, v_up, 0);
  }
}

function rocket_trap_warning_fire(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_52d911b7 = struct::get("rocket_trap_warning_fire", "targetname");
  v_forward = anglesToForward(var_52d911b7.angles);
  v_up = anglestoup(var_52d911b7.angles);
  if(isDefined(var_52d911b7.a_fx_id)) {
    for(j = 0; j < var_52d911b7.a_fx_id.size; j++) {
      deletefx(localclientnum, var_52d911b7.a_fx_id[j], 0);
    }
    var_52d911b7.a_fx_id = [];
  }
  if(newval) {
    if(!isDefined(var_52d911b7.a_fx_id)) {
      var_52d911b7.a_fx_id = [];
    }
    var_52d911b7.a_fx_id[localclientnum] = playFX(localclientnum, level._effect["rocket_warning_fire"], var_52d911b7.origin, v_forward, v_up, 0);
  } else {
    rocket_trap_blast(localclientnum);
  }
}

function rocket_trap_blast(localclientnum) {
  var_52d911b7 = struct::get("rocket_trap_blast", "targetname");
  v_forward = anglesToForward(var_52d911b7.angles);
  v_up = anglestoup(var_52d911b7.angles);
  n_fx_id = playFX(localclientnum, level._effect["rocket_side_blast"], var_52d911b7.origin, v_forward, v_up, 0);
  wait(0.4);
  var_a62b9cd7 = struct::get_array("rocket_trap_side_blast", "targetname");
  foreach(var_b25c0a2d in var_a62b9cd7) {
    var_b25c0a2d thread rocket_trap_side_blast(localclientnum);
  }
  wait(20);
  deletefx(localclientnum, n_fx_id, 0);
}

function rocket_trap_side_blast(localclientnum) {
  v_forward = anglesToForward(self.angles);
  v_up = anglestoup(self.angles);
  wait(randomfloatrange(0, 1));
  n_id = playFX(localclientnum, level._effect["rocket_side_blast"], self.origin, v_forward, v_up, 0);
  wait(20);
  deletefx(localclientnum, n_id, 0);
}

function sndrocketalarm(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(newval == 1) {
      audio::playloopat("evt_rocket_trap_alarm", (4202, -2096, -1438));
      audio::playloopat("evt_rocket_trap_alarm_dist", (4202, -2096, -1437));
    }
    if(newval == 2) {
      audio::stoploopat("evt_rocket_trap_alarm", (4202, -2096, -1438));
      audio::stoploopat("evt_rocket_trap_alarm_dist", (4202, -2096, -1437));
    }
  }
}

function sndrockettrap(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_dc3c5ca7 = (4202, -2249, -2127);
  if(newval) {
    if(newval == 1) {
      audio::playloopat("evt_rocket_trap_smoke", var_dc3c5ca7);
    }
    if(newval == 2) {
      audio::stoploopat("evt_rocket_trap_smoke", var_dc3c5ca7);
      audio::playloopat("evt_rocket_trap_ignite", var_dc3c5ca7);
      playSound(0, "evt_rocket_trap_ignite_one_shot", var_dc3c5ca7);
    }
    if(newval == 3) {
      audio::stoploopat("evt_rocket_trap_ignite", var_dc3c5ca7);
      audio::playloopat("evt_rocket_trap_burn", var_dc3c5ca7);
      playSound(0, "evt_rocket_trap_burn_one_shot", var_dc3c5ca7);
      audio::playloopat("evt_rocket_trap_burn_dist", var_dc3c5ca7 + vectorscale((0, 0, 1), 1000));
    }
    if(newval == 4) {
      audio::stoploopat("evt_rocket_trap_burn", var_dc3c5ca7);
      audio::stoploopat("evt_rocket_trap_burn_dist", var_dc3c5ca7 + vectorscale((0, 0, 1), 1000));
    }
  }
}