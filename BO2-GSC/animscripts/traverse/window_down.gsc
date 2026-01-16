/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\window_down.gsc
************************************************/

#include common_scripts\utility;
#include animscripts\traverse\shared;
#include animscripts\anims;
#include animscripts\utility;
#include animscripts\shared;
#include animscripts\run;
#using_animtree("generic_human");

main() {
  preparefortraverse();
  traverseanim = animarray("window_climb_start", "move");
  landanim = animarray("window_climb_end", "move");
  self.desired_anim_pose = "crouch";
  animscripts\utility::updateanimpose();
  self.old_anim_movement = self.a.movement;
  self endon("killanimscript");
  self traversemode("noclip");
  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self orientmode("face angle", startnode.angles[1]);
  realheight = startnode.traverse_height - startnode.origin[2];
  self setflaggedanimknoballrestart("traverse", traverseanim, % body, 1, 0.15, 1);
  thread animscripts\shared::donotetracksforever("traverse", "stop_traverse_notetracks");
  wait 1.5;
  angles = (0, startnode.angles[1], 0);
  forward = anglestoforward(angles);
  forward = vectorscale(forward, 85);
  trace = bullettrace(startnode.origin + forward, startnode.origin + forward + vectorscale((0, 0, -1), 500.0), 0, undefined);
  endheight = trace["position"][2];
  finaldif = startnode.origin[2] - endheight;
  heightchange = 0;

  for(i = 0; i < level.window_down_height.size; i++) {
    if(finaldif < level.window_down_height[i]) {
      continue;
    }
    heightchange = finaldif - level.window_down_height[i];
  }

  assert(heightchange > 0, "window_jump at " + startnode.origin + " is too high off the ground");
  self thread teleportthread(heightchange * -1);
  oldheight = self.origin[2];
  change = 0;
  level.traversefall = [];

  for(;;) {
    change = oldheight - self.origin[2];

    if(self.origin[2] - change < endheight) {
      break;
    }

    oldheight = self.origin[2];
    wait 0.05;
  }

  if(isDefined(self.groundtype))
    self playsound("Land_" + self.groundtype);

  self notify("stop_traverse_notetracks");
  self setflaggedanimknoballrestart("traverse", landanim, % body, 1, 0.15, 1);
  self traversemode("gravity");
  self animscripts\shared::donotetracks("traverse");
  self.a.movement = self.old_anim_movement;
  self setanimknoballrestart(animscripts\run::getrunanim(), % body, 1, 0.2, 1);
}

printer(org) {
  level notify("print_this_" + org);
  level endon("print_this_" + org);

  for(;;) {
    print3d(org, ".", (1, 1, 1), 5);

    wait 0.05;
  }
}

showline(start, end) {
  for(;;) {
    line(start, end + (-1, -1, -1), (1, 0, 0));

    wait 0.05;
  }
}

printerdebugger(msg, org) {
  level notify("prrint_this_" + org);
  level endon("prrint_this_" + org);

  for(;;) {
    print3d(org, msg, (1, 1, 1), 5);

    wait 0.05;
  }
}