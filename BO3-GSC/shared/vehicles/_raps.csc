/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\vehicles\_raps.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\vehicle_shared;
#namespace raps;

function autoexec main() {
  clientfield::register("vehicle", "raps_side_deathfx", 1, 1, "int", & do_side_death_fx, 0, 0);
}

function adjust_side_death_dir_if_trace_fail(origin, side_dir, fxlength, up_dir) {
  end = origin + (side_dir * fxlength);
  trace = bullettrace(origin, end, 0, self, 1);
  if(trace["fraction"] < 1) {
    new_side_dir = vectornormalize(side_dir + up_dir);
    end = origin + (new_side_dir * fxlength);
    new_trace = bullettrace(origin, end, 0, self, 1);
    if(new_trace["fraction"] > trace["fraction"]) {
      side_dir = new_side_dir;
    }
  }
  return side_dir;
}

function do_side_death_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  vehicle::wait_for_dobj(localclientnum);
  radius = 1;
  fxlength = 40;
  fxtag = "tag_body";
  if(newval && !binitialsnap) {
    if(!isdefined(self.settings)) {
      self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    }
    forward_direction = anglestoforward(self.angles);
    up_direction = anglestoup(self.angles);
    origin = self gettagorigin(fxtag);
    if(!isdefined(origin)) {
      origin = self.origin + vectorscale((0, 0, 1), 15);
    }
    right_direction = vectorcross(forward_direction, up_direction);
    right_direction = vectornormalize(right_direction);
    right_start = origin + (right_direction * radius);
    right_direction = adjust_side_death_dir_if_trace_fail(right_start, right_direction, fxlength, up_direction);
    left_direction = right_direction * -1;
    left_start = origin + (left_direction * radius);
    left_direction = adjust_side_death_dir_if_trace_fail(left_start, left_direction, fxlength, up_direction);
    if(isdefined(self.settings.sideexplosionfx)) {
      playfx(localclientnum, self.settings.sideexplosionfx, right_start, right_direction);
      playfx(localclientnum, self.settings.sideexplosionfx, left_start, left_direction);
    }
    if(isdefined(self.settings.killedexplosionfx)) {
      playfx(localclientnum, self.settings.killedexplosionfx, origin, (0, 0, 1));
    }
    self playsound(localclientnum, self.deathfxsound);
    if(isdefined(self.deathquakescale) && self.deathquakescale > 0) {
      self earthquake(self.deathquakescale, self.deathquakeduration, origin, self.deathquakeradius);
    }
  }
}