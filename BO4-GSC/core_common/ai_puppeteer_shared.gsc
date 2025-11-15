/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai_puppeteer_shared.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\core_common\values_shared;

#namespace ai_puppeteer;

autoexec __init__system__() {
  system::register(#"ai_puppeteer", &__init__, undefined, undefined);
}

__init__() {
  level thread ai_puppeteer_think();
}

ai_puppeteer_think() {
  while(true) {
    if(getdvar(#"debug_ai_puppeteer", 0) && !(isDefined(level.ai_puppeteer_active) && level.ai_puppeteer_active)) {
      level.ai_puppeteer_active = 1;
      level notify(#"kill ai puppeteer");
      adddebugcommand("<dev string:x38>");
      thread ai_puppeteer();
    } else if(!getdvar(#"debug_ai_puppeteer", 0) && isDefined(level.ai_puppeteer_active) && level.ai_puppeteer_active) {
      level.ai_puppeteer_active = 0;
      adddebugcommand("<dev string:x38>");
      level notify(#"kill ai puppeteer");
    }

    waitframe(1);
  }
}

ai_puppeteer() {
  player = undefined;

  while(!isplayer(player)) {
    player = getplayers()[0];
    waitframe(1);
  }

  ai_puppeteer_create_hud();
  level.ai_puppet_highlighting = 0;
  player thread ai_puppet_cursor_tracker();
  player thread ai_puppet_manager();
  player val::set(#"ai_puppeteer", "<dev string:x41>", 1);
  level waittill(#"kill ai puppeteer");
  player val::reset(#"ai_puppeteer", "<dev string:x41>");
  ai_puppet_release(1);

  if(isDefined(level.ai_puppet_target)) {
    level.ai_puppet_target delete();
  }

  ai_puppeteer_destroy_hud();
}

ai_puppet_manager() {
  level endon(#"kill ai puppeteer");
  self endon(#"death");

  while(true) {
    if(isDefined(level.playercursor[#"position"]) && isDefined(level.ai_puppet) && isDefined(level.ai_puppet.debuglookatenabled) && level.ai_puppet.debuglookatenabled == 1) {
      level.ai_puppet lookatpos(level.playercursor[#"position"]);
    }

    if(self buttonpressed("<dev string:x4c>") && self buttonpressed("<dev string:x5c>")) {
      if(isDefined(level.ai_puppet)) {
        level.ai_puppet forceteleport(level.playercursor[#"position"], level.ai_puppet.angles);
      }

      wait 0.2;
    } else if(self buttonpressed("<dev string:x4c>")) {
      if(isDefined(level.ai_puppet)) {
        if(isDefined(level.ai_puppet_target)) {
          if(isai(level.ai_puppet_target)) {
            self thread ai_puppeteer_highlight_ai(level.ai_puppet_target, (1, 0, 0));
            level.ai_puppet clearentitytarget();
            level.ai_puppet_target = undefined;
          } else {
            self thread ai_puppeteer_highlight_point(level.ai_puppet_target.origin, level.ai_puppet_target_normal, anglesToForward(self getplayerangles()), (1, 0, 0));
            level.ai_puppet clearentitytarget();
            level.ai_puppet_target delete();
          }
        } else if(isDefined(level.playercursorai)) {
          if(level.playercursorai != level.ai_puppet) {
            level.ai_puppet setentitytarget(level.playercursorai);
            level.ai_puppet_target = level.playercursorai;
            level.ai_puppet getperfectinfo(level.ai_puppet_target);
            self thread ai_puppeteer_highlight_ai(level.playercursorai, (1, 0, 0));
          }
        } else {
          level.ai_puppet_target = spawn("<dev string:x6c>", level.playercursor[#"position"]);
          level.ai_puppet_target makesentient();
          level.ai_puppet_target.health = 10000;
          level.ai_puppet_target_normal = level.playercursor[#"normal"];
          level.ai_puppet setentitytarget(level.ai_puppet_target);
          self thread ai_puppeteer_highlight_point(level.ai_puppet_target.origin, level.ai_puppet_target_normal, anglesToForward(self getplayerangles()), (1, 0, 0));
        }
      }

      wait 0.2;
    } else if(self buttonpressed("<dev string:x7b>")) {
      if(isDefined(level.ai_puppet)) {
        if(isDefined(level.ai_puppet) && isusingnavvolume(level.ai_puppet)) {
          var_8d9fdff6 = vectornormalize(level.playercursor[#"position"] - self.origin);
          level.playercursor[#"position"] = self.origin + vectorscale(var_8d9fdff6, 1000);
          level.playercursor[#"position"] = level.ai_puppet getclosestpointonnavvolume(level.playercursor[#"position"], 400);
        }

        if(isDefined(level.playercursorai) && level.playercursorai != level.ai_puppet) {
          level.ai_puppet setgoal(level.playercursorai);
          level.ai_puppet.goalradius = 64;
          level.ai_puppet.goalheight = level.ai_puppet.goalradius;

          if(isusingnavvolume(level.ai_puppet)) {
            level.ai_puppet.goalradius = level.ai_puppet.radius;
            level.ai_puppet.goalheight = level.ai_puppet.goalradius;
          }

          self thread ai_puppeteer_highlight_ai(level.playercursorai, (0, 1, 0));
        } else if(isDefined(level.playercursornode)) {
          level.ai_puppet setgoal(level.playercursornode);
          self thread ai_puppeteer_highlight_node(level.playercursornode);
        } else {
          if(isDefined(level.ai_puppet.scriptenemy)) {
            to_target = level.ai_puppet.scriptenemy.origin - level.ai_puppet.origin;
          } else {
            to_target = level.playercursor[#"position"] - level.ai_puppet.origin;
          }

          angles = vectortoangles(to_target);
          level.ai_puppet setgoal(level.playercursor[#"position"]);
          self thread ai_puppeteer_highlight_point(level.playercursor[#"position"], level.playercursor[#"normal"], anglesToForward(self getplayerangles()), (0, 1, 0));
        }
      }

      wait 0.2;
    } else if(self buttonpressed("<dev string:x86>") && self buttonpressed("<dev string:x91>")) {
      if(isDefined(level.ai_puppet)) {
        if(isusingnavvolume(level.ai_puppet)) {
          var_8d9fdff6 = vectornormalize(level.playercursor[#"position"] - self.origin);
          level.playercursor[#"position"] = self.origin + vectorscale(var_8d9fdff6, 1000);
          level.playercursor[#"position"] = level.ai_puppet getclosestpointonnavvolume(level.playercursor[#"position"], 400);
        }

        if(isDefined(level.playercursorai) && level.playercursorai != level.ai_puppet) {
          level.ai_puppet setgoal(level.playercursorai);
          level.ai_puppet.goalradius = 64;
          level.ai_puppet.goalheight = level.ai_puppet.goalradius;

          if(isusingnavvolume(level.ai_puppet)) {
            level.ai_puppet.goalradius = level.ai_puppet.radius;
            level.ai_puppet.goalheight = level.ai_puppet.goalradius;
          }

          self thread ai_puppeteer_highlight_ai(level.playercursorai, (0, 1, 0));
        } else if(isDefined(level.playercursornode)) {
          if(isusingnavvolume(level.ai_puppet)) {
            level.ai_puppet.goalradius = level.ai_puppet.radius;
            level.ai_puppet.goalheight = level.ai_puppet.goalradius;
          }

          level.ai_puppet setgoal(level.playercursornode, 1);
          self thread ai_puppeteer_highlight_node(level.playercursornode);
        } else {
          if(isusingnavvolume(level.ai_puppet)) {
            level.ai_puppet.goalradius = level.ai_puppet.radius;
            level.ai_puppet.goalheight = level.ai_puppet.goalradius;
          }

          if(isDefined(level.ai_puppet.scriptenemy)) {
            to_target = level.ai_puppet.scriptenemy.origin - level.ai_puppet.origin;
          } else {
            to_target = level.playercursor[#"position"] - level.ai_puppet.origin;
          }

          angles = vectortoangles(to_target);
          level.ai_puppet setgoal(level.playercursor[#"position"], 1);
          self thread ai_puppeteer_highlight_point(level.playercursor[#"position"], level.playercursor[#"normal"], anglesToForward(self getplayerangles()), (0, 1, 0));
        }
      }

      wait 0.2;
    } else if(self buttonpressed("<dev string:x9c>")) {
      if(isDefined(level.playercursorai)) {
        if(isDefined(level.ai_puppet) && level.playercursorai == level.ai_puppet) {
          ai_puppet_release(1);
        } else {
          if(isDefined(level.ai_puppet)) {
            ai_puppet_release(0);
          }

          ai_puppet_set();
          self thread ai_puppeteer_highlight_ai(level.ai_puppet, (0, 1, 1));
        }
      }

      wait 0.2;
    } else if(self buttonpressed("<dev string:x91>")) {
      if(isDefined(level.ai_puppet)) {
        level.ai_puppet clearforcedgoal();
      }

      wait 0.2;
    }

    if(isDefined(level.ai_puppet)) {
      ai_puppeteer_render_ai(level.ai_puppet, (0, 1, 1));

      if(isDefined(level.ai_puppet.scriptenemy) && !level.ai_puppet_highlighting) {
        if(isai(level.ai_puppet.scriptenemy)) {
          ai_puppeteer_render_ai(level.ai_puppet.scriptenemy, (1, 0, 0));
        } else if(isDefined(level.ai_puppet_target)) {
          self thread ai_puppeteer_render_point(level.ai_puppet_target.origin, level.ai_puppet_target_normal, anglesToForward(self getplayerangles()), (1, 0, 0));
        }
      }
    }

    if(isDefined(level.ai_puppet)) {
      if(self buttonpressed("<dev string:xa7>")) {
        level.ai_puppet.goalradius += 64;
        level.ai_puppet.goalheight = level.ai_puppet.goalradius;
      } else if(self buttonpressed("<dev string:xb1>")) {
        radius = level.ai_puppet.goalradius - 64;

        if(radius < 16) {
          radius = 16;
        }

        if(isusingnavvolume(level.ai_puppet) && radius < level.ai_puppet.radius) {
          radius = level.ai_puppet.radius;
        }

        level.ai_puppet.goalradius = radius;
        level.ai_puppet.goalheight = level.ai_puppet.goalradius;
      } else if(self buttonpressed("<dev string:xbd>")) {
        level.ai_puppet.goalradius = 16;

        if(isusingnavvolume(level.ai_puppet)) {
          level.ai_puppet.goalradius = level.ai_puppet.radius;
        }

        level.ai_puppet.goalheight = level.ai_puppet.goalradius;
      }
    }

    if(isDefined(level.ai_puppet)) {
      level.ai_puppet.fixednode = 0;
    }

    waitframe(1);
  }
}

ai_puppet_set() {
  level.ai_puppet = level.playercursorai;
  level.ai_puppet.ispuppet = 1;
  level.ai_puppet.old_goalradius = level.ai_puppet.goalradius;
  level.ai_puppet.goalradius = 16;
  level.ai_puppet.goalheight = level.ai_puppet.goalradius;
  level.ai_puppet.disabletargetservice = 1;

  if(isusingnavvolume(level.ai_puppet)) {
    level.ai_puppet.goalradius = level.ai_puppet.radius;
    level.ai_puppet.goalheight = level.ai_puppet.goalradius;
  }

  level.ai_puppet stopanimscripted();
}

ai_puppet_release(restore) {
  if(isDefined(level.ai_puppet)) {
    if(restore) {
      level.ai_puppet.goalradius = level.ai_puppet.old_goalradius;
      level.ai_puppet.ispuppet = 0;
      level.ai_puppet clearentitytarget();
      level.ai_puppet.disabletargetservice = 0;
    }

    level.ai_puppet = undefined;
  }
}

ai_puppet_cursor_tracker() {
  level endon(#"kill ai puppeteer");
  self endon(#"death");

  while(true) {
    forward = anglesToForward(self getplayerangles());
    forward_vector = vectorscale(forward, 4000);
    level.playercursor = physicstrace(self getEye(), self getEye() + forward_vector, (0, 0, 0), (0, 0, 0), self, 8 | 2);
    level.playercursorai = undefined;
    level.playercursornode = undefined;
    cursorcolor = (0, 1, 1);
    hitent = level.playercursor[#"entity"];

    if(!isDefined(hitent)) {
      bullettrace = bulletTrace(self getEye(), self getEye() + forward_vector, 1, self);
      hitent = bullettrace[#"entity"];
    }

    if(isDefined(hitent) && (isai(hitent) || isbot(hitent) || isvehicle(hitent))) {
      cursorcolor = (1, 0, 0);

      if(isDefined(level.ai_puppet) && level.ai_puppet != hitent) {
        if(!level.ai_puppet_highlighting) {
          ai_puppeteer_render_ai(hitent, cursorcolor);
        }
      }

      level.playercursorai = hitent;
    } else if(isDefined(level.ai_puppet)) {
      nodes = getanynodearray(level.playercursor[#"position"], 24);

      if(nodes.size > 0) {
        node = nodes[0];

        if(node.type != #"path" && distancesquared(node.origin, level.playercursor[#"position"]) < 576) {
          if(!level.ai_puppet_highlighting) {
            ai_puppeteer_render_node(node, (0, 1, 1));
          }

          level.playercursornode = node;
        }
      }
    }

    if(!level.ai_puppet_highlighting) {
      ai_puppeteer_render_point(level.playercursor[#"position"], level.playercursor[#"normal"], forward, cursorcolor);
    }

    waitframe(1);
  }
}

ai_puppeteer_create_hud() {
  level.puppeteer_hud_select = newdebughudelem();
  level.puppeteer_hud_select.x = 0;
  level.puppeteer_hud_select.y = 180;
  level.puppeteer_hud_select.fontscale = 1;
  level.puppeteer_hud_select.alignx = "<dev string:xc9>";
  level.puppeteer_hud_select.horzalign = "<dev string:xc9>";
  level.puppeteer_hud_select.color = (0, 0, 1);
  level.puppeteer_hud_goto = newdebughudelem();
  level.puppeteer_hud_goto.x = 0;
  level.puppeteer_hud_goto.y = 200;
  level.puppeteer_hud_goto.fontscale = 1;
  level.puppeteer_hud_goto.alignx = "<dev string:xc9>";
  level.puppeteer_hud_goto.horzalign = "<dev string:xc9>";
  level.puppeteer_hud_goto.color = (0, 1, 0);
  level.puppeteer_hud_lookat = newdebughudelem();
  level.puppeteer_hud_lookat.x = 0;
  level.puppeteer_hud_lookat.y = 220;
  level.puppeteer_hud_lookat.fontscale = 1;
  level.puppeteer_hud_lookat.alignx = "<dev string:xc9>";
  level.puppeteer_hud_lookat.horzalign = "<dev string:xc9>";
  level.puppeteer_hud_lookat.color = (0, 1, 1);
  level.puppeteer_hud_shoot = newdebughudelem();
  level.puppeteer_hud_shoot.x = 0;
  level.puppeteer_hud_shoot.y = 240;
  level.puppeteer_hud_shoot.fontscale = 1;
  level.puppeteer_hud_shoot.alignx = "<dev string:xc9>";
  level.puppeteer_hud_shoot.horzalign = "<dev string:xc9>";
  level.puppeteer_hud_shoot.color = (1, 1, 1);
  level.puppeteer_hud_teleport = newdebughudelem();
  level.puppeteer_hud_teleport.x = 0;
  level.puppeteer_hud_teleport.y = 260;
  level.puppeteer_hud_teleport.fontscale = 1;
  level.puppeteer_hud_teleport.alignx = "<dev string:xc9>";
  level.puppeteer_hud_teleport.horzalign = "<dev string:xc9>";
  level.puppeteer_hud_teleport.color = (1, 0, 0);
  level.puppeteer_hud_select settext("<dev string:xd0>");
  level.puppeteer_hud_goto settext("<dev string:xfa>");
  level.puppeteer_hud_lookat settext("<dev string:x107>");
  level.puppeteer_hud_shoot settext("<dev string:x132>");
  level.puppeteer_hud_teleport settext("<dev string:x146>");
}

ai_puppeteer_destroy_hud() {
  if(isDefined(level.puppeteer_hud_select)) {
    level.puppeteer_hud_select destroy();
  }

  if(isDefined(level.puppeteer_hud_lookat)) {
    level.puppeteer_hud_lookat destroy();
  }

  if(isDefined(level.puppeteer_hud_goto)) {
    level.puppeteer_hud_goto destroy();
  }

  if(isDefined(level.puppeteer_hud_shoot)) {
    level.puppeteer_hud_shoot destroy();
  }
}

ai_puppeteer_render_point(point, normal, forward, color) {
  surface_vector = vectorcross(forward, normal);
  surface_vector = vectornormalize(surface_vector);
  line(point, point + vectorscale(surface_vector, 5), color, 1, 1);
  line(point, point + vectorscale(surface_vector, -5), color, 1, 1);
  surface_vector = vectorcross(normal, surface_vector);
  surface_vector = vectornormalize(surface_vector);
  line(point, point + vectorscale(surface_vector, 5), color, 1, 1);
  line(point, point + vectorscale(surface_vector, -5), color, 1, 1);
}

ai_puppeteer_render_node(node, color) {
  print3d(node.origin, node.type, color, 1, 0.35);
  box(node.origin, (-16, -16, 0), (16, 16, 16), node.angles[1], color, 1, 1);
  nodeforward = anglesToForward(node.angles);
  nodeforward = vectorscale(nodeforward, 8);
  line(node.origin, node.origin + nodeforward, color, 1, 1);
}

ai_puppeteer_render_ai(ai, color) {
  if(isDefined(ai) && isDefined(ai.goalpos)) {
    if(isusingnavvolume(ai)) {
      circle(ai.goalpos + (0, 0, ai.goalheight / 2), ai.goalradius, color, 0, 1);
      circle(ai.goalpos + (0, 0, ai.goalheight * -1 / 2), ai.goalradius, color, 0, 1);
    } else {
      circle(ai.goalpos + (0, 0, 1), ai.goalradius, color, 0, 1);
    }

    circle(ai.origin + (0, 0, 1), ai getpathfindingradius(), (1, 0, 0), 0, 1);
    line(ai.goalpos, ai.origin, color, 1, 1);
  }
}

ai_puppeteer_highlight_point(point, normal, forward, color) {
  level endon(#"kill ai puppeteer");
  self endon(#"death");
  level.ai_puppet_highlighting = 1;
  timer = 0;

  while(timer < 0.7) {
    ai_puppeteer_render_point(point, normal, forward, color);
    timer += 0.15;
    wait 0.15;
  }

  level.ai_puppet_highlighting = 0;
}

ai_puppeteer_highlight_node(node) {
  level endon(#"kill ai puppeteer");
  self endon(#"death");
  level.ai_puppet_highlighting = 1;
  timer = 0;

  while(timer < 0.7) {
    ai_puppeteer_render_node(node, (0, 1, 0));
    timer += 0.15;
    wait 0.15;
  }

  level.ai_puppet_highlighting = 0;
}

ai_puppeteer_highlight_ai(ai, color) {
  level endon(#"kill ai puppeteer");
  self endon(#"death");
  level.ai_puppet_highlighting = 1;
  timer = 0;

  while(timer < 0.7 && isDefined(ai)) {
    ai_puppeteer_render_ai(ai, color);
    timer += 0.15;
    wait 0.15;
  }

  level.ai_puppet_highlighting = 0;
}

