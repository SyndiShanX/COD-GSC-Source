/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_timer.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\system_shared;
#namespace zm_timer;

function autoexec __init__sytem__() {
  system::register("zm_timer", undefined, & __main__, undefined);
}

function __main__() {
  if(!isdefined(level.stopwatch_length_width)) {
    level.stopwatch_length_width = 96;
  }
}

function start_timer(time, stop_notify) {
  self notify("stop_prev_timer");
  self endon("stop_prev_timer");
  self endon("disconnect");
  if(!isdefined(self.stopwatch_elem)) {
    self.stopwatch_elem = newclienthudelem(self);
    self.stopwatch_elem.horzalign = "left";
    self.stopwatch_elem.vertalign = "top";
    self.stopwatch_elem.alignx = "left";
    self.stopwatch_elem.aligny = "top";
    self.stopwatch_elem.x = 10;
    self.stopwatch_elem.alpha = 0;
    self.stopwatch_elem.sort = 2;
    self.stopwatch_elem_glass = newclienthudelem(self);
    self.stopwatch_elem_glass.horzalign = "left";
    self.stopwatch_elem_glass.vertalign = "top";
    self.stopwatch_elem_glass.alignx = "left";
    self.stopwatch_elem_glass.aligny = "top";
    self.stopwatch_elem_glass.x = 10;
    self.stopwatch_elem_glass.alpha = 0;
    self.stopwatch_elem_glass.sort = 3;
    self.stopwatch_elem_glass setshader("zombie_stopwatch_glass", level.stopwatch_length_width, level.stopwatch_length_width);
  }
  self thread update_hud_position();
  if(isdefined(stop_notify)) {
    self thread wait_for_stop_notify(stop_notify);
  }
  if(time > 60) {
    time = 0;
  }
  self.stopwatch_elem setclock(time, 60, "zombie_stopwatch", level.stopwatch_length_width, level.stopwatch_length_width);
  self.stopwatch_elem.alpha = 1;
  self.stopwatch_elem_glass.alpha = 1;
  wait(time);
  self notify("countdown_finished");
  wait(1);
  self.stopwatch_elem.alpha = 0;
  self.stopwatch_elem_glass.alpha = 0;
}

function wait_for_stop_notify(stop_notify) {
  self endon("stop_prev_timer");
  self endon("countdown_finished");
  self waittill(stop_notify);
  self.stopwatch_elem.alpha = 0;
  self.stopwatch_elem_glass.alpha = 0;
}

function update_hud_position() {
  self endon("disconnect");
  self endon("stop_prev_timer");
  self endon("countdown_finished");
  while (true) {
    self.stopwatch_elem.y = 20;
    self.stopwatch_elem_glass.y = 20;
    wait(0.05);
  }
}