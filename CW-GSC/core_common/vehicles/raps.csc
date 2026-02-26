/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\raps.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace raps;

function private autoexec __init__system__() {
  system::register(#"raps", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("vehicle", "raps_side_deathfx", 1, 1, "int", &do_side_death_fx, 0, 0);
}

function adjust_side_death_dir_if_trace_fail(origin, side_dir, fxlength, up_dir) {
  end = origin + side_dir * fxlength;
  trace = bulletTrace(origin, end, 0, self);

  if(trace[#"fraction"] < 1) {
    new_side_dir = vectornormalize(side_dir + up_dir);
    end = origin + new_side_dir * fxlength;
    new_trace = bulletTrace(origin, end, 0, self);

    if(new_trace[#"fraction"] > trace[#"fraction"]) {
      side_dir = new_side_dir;
    }
  }

  return side_dir;
}

function do_side_death_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  util::waittill_dobj(binitialsnap);
  radius = 1;
  fxlength = 40;
  fxtag = "tag_body";

  if(fieldname && !bwastimejump) {
    if(!isDefined(self.settings)) {
      self.settings = getscriptbundle(self.scriptbundlesettings);
    }

    forward_direction = anglesToForward(self.angles);
    up_direction = anglestoup(self.angles);
    origin = self gettagorigin(fxtag);

    if(!isDefined(origin)) {
      origin = self.origin + (0, 0, 15);
    }

    right_direction = vectorcross(forward_direction, up_direction);
    right_direction = vectornormalize(right_direction);
    right_start = origin + right_direction * radius;
    right_direction = adjust_side_death_dir_if_trace_fail(right_start, right_direction, fxlength, up_direction);
    left_direction = right_direction * -1;
    left_start = origin + left_direction * radius;
    left_direction = adjust_side_death_dir_if_trace_fail(left_start, left_direction, fxlength, up_direction);

    if(isDefined(self.settings.sideexplosionfx)) {
      playFX(binitialsnap, self.settings.sideexplosionfx, right_start, right_direction);
      playFX(binitialsnap, self.settings.sideexplosionfx, left_start, left_direction);
    }

    if(isDefined(self.settings.killedexplosionfx)) {
      playFX(binitialsnap, self.settings.killedexplosionfx, origin, (0, 0, 1));
    }

    self playSound(binitialsnap, self.deathfxsound);

    if(isDefined(self.deathquakescale) && self.deathquakescale > 0) {
      earthquake(binitialsnap, self.deathquakescale, self.deathquakeduration, origin, self.deathquakeradius);
    }
  }
}