/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_apothicon_fury.csc
*************************************************/

#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\util_shared;
#namespace apothiconfurybehavior;

function autoexec main() {
  ai::add_archetype_spawn_function("apothicon_fury", & apothiconspawnsetup);
  if(ai::shouldregisterclientfieldforarchetype("apothicon_fury")) {
    clientfield::register("actor", "fury_fire_damage", 15000, getminbitcountfornum(7), "counter", & apothiconfiredamageeffect, 0, 0);
    clientfield::register("actor", "furious_level", 15000, 1, "int", & apothiconfuriousmodeeffect, 0, 0);
    clientfield::register("actor", "bamf_land", 15000, 1, "counter", & apothiconbamflandeffect, 0, 0);
    clientfield::register("actor", "apothicon_fury_death", 15000, 2, "int", & apothiconfurydeath, 0, 0);
    clientfield::register("actor", "juke_active", 15000, 1, "int", & apothiconjukeactive, 0, 0);
  }
  level._effect["dlc4/genesis/fx_apothicon_fury_impact"] = "dlc4/genesis/fx_apothicon_fury_impact";
  level._effect["dlc4/genesis/fx_apothicon_fury_breath"] = "dlc4/genesis/fx_apothicon_fury_breath";
  level._effect["dlc4/genesis/fx_apothicon_fury_teleport_impact"] = "dlc4/genesis/fx_apothicon_fury_teleport_impact";
  level._effect["dlc4/genesis/fx_apothicon_fury_smk_body"] = "dlc4/genesis/fx_apothicon_fury_smk_body";
  level._effect["dlc4/genesis/fx_apothicon_fury_foot_amb"] = "dlc4/genesis/fx_apothicon_fury_foot_amb";
  level._effect["dlc4/genesis/fx_apothicon_fury_death"] = "dlc4/genesis/fx_apothicon_fury_death";
}

function apothiconspawnsetup(localclientnum) {
  self thread apothiconspawnshader(localclientnum);
  self apothiconstartloopingeffects(localclientnum);
}

function apothiconstartloopingeffects(localclientnum) {
  self.loopingeffects = [];
  self.loopingeffects[0] = playfxontag(localclientnum, level._effect["dlc4/genesis/fx_apothicon_fury_breath"], self, "j_head");
  self.loopingeffects[1] = playfxontag(localclientnum, level._effect["dlc4/genesis/fx_apothicon_fury_smk_body"], self, "j_spine4");
  self.loopingeffects[2] = playfxontag(localclientnum, level._effect["dlc4/genesis/fx_apothicon_fury_foot_amb"], self, "j_ball_le");
  self.loopingeffects[3] = playfxontag(localclientnum, level._effect["dlc4/genesis/fx_apothicon_fury_foot_amb"], self, "j_ball_ri");
  self.loopingeffects[4] = playfxontag(localclientnum, level._effect["dlc4/genesis/fx_apothicon_fury_foot_amb"], self, "j_wrist_le");
  self.loopingeffects[5] = playfxontag(localclientnum, level._effect["dlc4/genesis/fx_apothicon_fury_foot_amb"], self, "j_wrist_ri");
}

function apothiconstoploopingeffects(localclientnum) {
  foreach(fx in self.loopingeffects) {
    killfx(localclientnum, fx);
  }
}

function apothiconspawnshader(localclientnum) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isdefined(self)) {
    return;
  }
  s_timer = new_timer(localclientnum);
  n_phase_in = 1;
  do {
    util::server_wait(localclientnum, 0.11);
    n_current_time = s_timer get_time_in_seconds();
    n_delta_val = lerpfloat(0, 0.01, n_current_time / n_phase_in);
    self mapshaderconstant(localclientnum, 0, "scriptVector2", n_delta_val);
  }
  while (n_current_time < n_phase_in);
  s_timer notify("timer_done");
}

function apothiconjukeactive(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isdefined(self)) {
    return;
  }
  if(newval) {
    playsound(0, "zmb_fury_bamf_teleport_in", self.origin);
    self apothiconstartloopingeffects(localclientnum);
  } else {
    playsound(0, "zmb_fury_bamf_teleport_out", self.origin);
    self apothiconstoploopingeffects(localclientnum);
  }
}

function apothiconfiredamageeffect(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isdefined(self)) {
    return;
  }
  tag = undefined;
  if(newval == 6) {
    tag = array::random(array("J_Hip_RI", "J_Knee_RI"));
  }
  if(newval == 7) {
    tag = array::random(array("J_Hip_LE", "J_Knee_LE"));
  } else {
    if(newval == 4) {
      tag = array::random(array("J_Shoulder_RI", "J_Shoulder_RI_tr", "J_Elbow_RI"));
    } else {
      if(newval == 5) {
        tag = array::random(array("J_Shoulder_LE", "J_Shoulder_LE_tr", "J_Elbow_LE"));
      } else {
        if(newval == 3) {
          tag = array::random(array("J_MainRoot"));
        } else {
          if(newval == 2) {
            tag = array::random(array("J_SpineUpper", "J_Clavicle_RI", "J_Clavicle_LE"));
          } else {
            tag = array::random(array("J_Neck", "J_Head", "J_Helmet"));
          }
        }
      }
    }
  }
  fx = playfxontag(localclientnum, level._effect["dlc4/genesis/fx_apothicon_fury_impact"], self, tag);
}

function apothiconfurydeath(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isdefined(self)) {
    return;
  }
  if(newval == 1) {
    s_timer = new_timer(localclientnum);
    n_phase_in = 1;
    self.removingfireshader = 1;
    do {
      util::server_wait(localclientnum, 0.11);
      n_current_time = s_timer get_time_in_seconds();
      n_delta_val = lerpfloat(1, 0.1, n_current_time / n_phase_in);
      self mapshaderconstant(localclientnum, 0, "scriptVector2", n_delta_val);
    }
    while (n_current_time < n_phase_in);
    s_timer notify("timer_done");
    self.removingfireshader = 0;
  } else if(newval == 2) {
    if(!isdefined(self)) {
      return;
    }
    playfxontag(localclientnum, level._effect["dlc4/genesis/fx_apothicon_fury_death"], self, "j_spine4");
    self apothiconstoploopingeffects(localclientnum);
    n_phase_in = 0.3;
    s_timer = new_timer(localclientnum);
    stoptime = gettime() + (n_phase_in * 1000);
    do {
      util::server_wait(localclientnum, 0.11);
      n_current_time = s_timer get_time_in_seconds();
      n_delta_val = lerpfloat(1, 0, n_current_time / n_phase_in);
      self mapshaderconstant(localclientnum, 0, "scriptVector0", n_delta_val);
    }
    while (n_current_time < n_phase_in && gettime() <= stoptime);
    s_timer notify("timer_done");
    self mapshaderconstant(localclientnum, 0, "scriptVector0", 0);
  }
}

function apothiconfuriousmodeeffect(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isdefined(self)) {
    return;
  }
  if(newval) {
    s_timer = new_timer(localclientnum);
    n_phase_in = 2;
    do {
      util::server_wait(localclientnum, 0.11);
      n_current_time = s_timer get_time_in_seconds();
      n_delta_val = lerpfloat(0.1, 1, n_current_time / n_phase_in);
      self mapshaderconstant(localclientnum, 0, "scriptVector2", n_delta_val);
    }
    while (n_current_time < n_phase_in);
    s_timer notify("timer_done");
  }
}

function new_timer(localclientnum) {
  s_timer = spawnstruct();
  s_timer.n_time_current = 0;
  s_timer thread timer_increment_loop(localclientnum, self);
  return s_timer;
}

function timer_increment_loop(localclientnum, entity) {
  entity endon("entityshutdown");
  self endon("timer_done");
  while (isdefined(self)) {
    util::server_wait(localclientnum, 0.016);
    self.n_time_current = self.n_time_current + 0.016;
  }
}

function get_time() {
  return self.n_time_current * 1000;
}

function get_time_in_seconds() {
  return self.n_time_current;
}

function reset_timer() {
  self.n_time_current = 0;
}

function apothiconbamflandeffect(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isdefined(self)) {
    return;
  }
  if(newval) {
    playfxontag(localclientnum, level._effect["dlc4/genesis/fx_apothicon_fury_teleport_impact"], self, "tag_origin");
  }
  player = getlocalplayer(localclientnum);
  player earthquake(0.5, 1.4, self.origin, 375);
  playrumbleonposition(localclientnum, "apothicon_fury_land", self.origin);
}