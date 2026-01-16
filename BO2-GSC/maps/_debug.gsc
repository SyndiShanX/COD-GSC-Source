/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_debug.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_endmission;
#include animscripts\utility;
#include animscripts\init;
#include maps\_createmenu;
#include animscripts\weaponlist;

maindebug() {
  level.animsound_hudlimit = 14;
  level.debugteamcolors = [];
  level.debugteamcolors["axis"] = (1, 0, 0);
  level.debugteamcolors["allies"] = (0, 1, 0);
  level.debugteamcolors["team3"] = (1, 1, 0);
  level.debugteamcolors["neutral"] = (1, 1, 1);
  thread lastsightposwatch();

  if(level.script != "background")
    thread camera();

  if(getdebugdvar("debug_corner") == "")
    setdvar("debug_corner", "off");
  else if(getdebugdvar("debug_corner") == "on")
    debug_corner();

  if(getdvar(#"_id_0F392C08") == "1")
    thread debugchains();

  if(getdebugdvar("debug_bayonet") == "")
    setdvar("debug_bayonet", "0");

  thread debug_bayonet();
  thread debugdvars();
  precacheshader("white");
  thread debugcolorfriendlies();
  thread watchminimap();

  if(getdvar(#"_id_2E717886") != "off")
    thread complete_me();

  if(getdvar(#"_id_3C98BCAE") != "off")
    maps\_endmission::force_all_complete();

  if(getdvar(#"_id_85A1539B") != "off")
    maps\_endmission::clearall();

  thread engagement_distance_debug_toggle();
}

debugchains() {
  nodes = getallnodes();
  fnodenum = 0;
  fnodes = [];

  for(i = 0; i < nodes.size; i++) {
    if(!nodes[i] has_spawnflag(2) && (isDefined(nodes[i].target) && getnodearray(nodes[i].target, "targetname").size > 0 || isDefined(nodes[i].targetname) && getnodearray(nodes[i].targetname, "target").size > 0)) {
      fnodes[fnodenum] = nodes[i];
      fnodenum++;
    }
  }

  while(true) {
    if(getdvar(#"_id_0F392C08") == "1") {
      for(i = 0; i < fnodes.size; i++) {
        players = get_players();

        if(distance(players[0] getorigin(), fnodes[i].origin) < 1500)
          print3d(fnodes[i].origin, "yo", (0.2, 0.8, 0.5), 0.45);
      }

      friends = getaiarray("allies");

      for(i = 0; i < friends.size; i++) {
        node = friends[i] animscripts\utility::getclaimednode();

        if(isDefined(node))
          line(friends[i].origin + vectorscale((0, 0, 1), 35.0), node.origin, (0.2, 0.5, 0.8), 0.5);
      }
    }

    wait 0.05;
  }

}

debug_enemypos(num) {
  ai = getaiarray();

  for(i = 0; i < ai.size; i++) {
    if(ai[i] getentitynumber() != num) {
      continue;
    }
    ai[i] thread debug_enemyposproc();
    break;
  }

}

debug_stopenemypos(num) {
  ai = getaiarray();

  for(i = 0; i < ai.size; i++) {
    if(ai[i] getentitynumber() != num) {
      continue;
    }
    ai[i] notify("stop_drawing_enemy_pos");
    break;
  }

}

debug_enemyposproc() {
  self endon("death");
  self endon("stop_drawing_enemy_pos");

  for(;;) {
    wait 0.05;

    if(isalive(self.enemy))
      line(self.origin + vectorscale((0, 0, 1), 70.0), self.enemy.origin + vectorscale((0, 0, 1), 70.0), (0.8, 0.2, 0.0), 0.5);

    if(!self animscripts\utility::hasenemysightpos()) {
      continue;
    }
    pos = animscripts\utility::getenemysightpos();
    line(self.origin + vectorscale((0, 0, 1), 70.0), pos, (0.9, 0.5, 0.3), 0.5);
  }

}

debug_enemyposreplay() {
  ai = getaiarray();
  guy = undefined;

  for(i = 0; i < ai.size; i++) {
    guy = ai[i];

    if(!isalive(guy)) {
      continue;
    }
    if(isDefined(guy.lastenemysightpos))
      line(guy.origin + vectorscale((0, 0, 1), 65.0), guy.lastenemysightpos, (1, 0, 1), 0.5);

    if(guy.goodshootposvalid) {
      if(guy.team == "axis")
        color = (1, 0, 0);
      else
        color = (0, 0, 1);

      nodeoffset = guy.origin + vectorscale((0, 0, 1), 54.0);

      if(isDefined(guy.node)) {
        if(guy.node.type == "Cover Left") {
          cornernode = 1;
          nodeoffset = anglestoright(guy.node.angles);
          nodeoffset = vectorscale(nodeoffset, -32);
          nodeoffset = (nodeoffset[0], nodeoffset[1], 64);
          nodeoffset = guy.node.origin + nodeoffset;
        } else if(guy.node.type == "Cover Right") {
          cornernode = 1;
          nodeoffset = anglestoright(guy.node.angles);
          nodeoffset = vectorscale(nodeoffset, 32);
          nodeoffset = (nodeoffset[0], nodeoffset[1], 64);
          nodeoffset = guy.node.origin + nodeoffset;
        }
      }

      draw_arrow(nodeoffset, guy.goodshootpos, color);
    }
  }

  if(1) {
    return;
  }
  if(!isalive(guy)) {
    return;
  }
  if(isalive(guy.enemy))
    line(guy.origin + vectorscale((0, 0, 1), 70.0), guy.enemy.origin + vectorscale((0, 0, 1), 70.0), (0.6, 0.2, 0.2), 0.5);

  if(isDefined(guy.lastenemysightpos))
    line(guy.origin + vectorscale((0, 0, 1), 65.0), guy.lastenemysightpos, (0, 0, 1), 0.5);

  if(isalive(guy.goodenemy))
    line(guy.origin + vectorscale((0, 0, 1), 50.0), guy.goodenemy.origin, (1, 0, 0), 0.5);

  if(!guy animscripts\utility::hasenemysightpos()) {
    return;
  }
  pos = guy animscripts\utility::getenemysightpos();
  line(guy.origin + vectorscale((0, 0, 1), 55.0), pos, (0.2, 0.2, 0.6), 0.5);

  if(guy.goodshootposvalid)
    line(guy.origin + vectorscale((0, 0, 1), 45.0), guy.goodshootpos, (0.2, 0.6, 0.2), 0.5);
}

drawenttag(num) {
  ai = getaiarray();

  for(i = 0; i < ai.size; i++) {
    if(ai[i] getentnum() != num) {
      continue;
    }
    ai[i] thread dragtaguntildeath(getdebugdvar("debug_tag"));
  }

  setdvar("debug_enttag", "");
}

drawtag(tag, opcolor) {
  org = self gettagorigin(tag);
  ang = self gettagangles(tag);
  drawarrow(org, ang, opcolor);
}

draworgforever(opcolor) {
  for(;;) {
    drawarrow(self.origin, self.angles, opcolor);
    wait 0.05;
  }

}

drawarrowforever(org, ang) {
  for(;;) {
    drawarrow(org, ang);
    wait 0.05;
  }

}

draworiginforever() {
  for(;;) {
    drawarrow(self.origin, self.angles);
    wait 0.05;
  }

}

drawarrow(org, ang, opcolor) {
  forward = anglestoforward(ang);
  forwardfar = vectorscale(forward, 50);
  forwardclose = vectorscale(forward, 50 * 0.8);
  right = anglestoright(ang);
  leftdraw = vectorscale(right, 50 * -0.2);
  rightdraw = vectorscale(right, 50 * 0.2);
  up = anglestoup(ang);
  right = vectorscale(right, 50);
  up = vectorscale(up, 50);
  red = (0.9, 0.2, 0.2);
  green = (0.2, 0.9, 0.2);
  blue = (0.2, 0.2, 0.9);

  if(isDefined(opcolor)) {
    red = opcolor;
    green = opcolor;
    blue = opcolor;
  }

  line(org, org + forwardfar, red, 0.9);
  line(org + forwardfar, org + forwardclose + rightdraw, red, 0.9);
  line(org + forwardfar, org + forwardclose + leftdraw, red, 0.9);
  line(org, org + right, blue, 0.9);
  line(org, org + up, green, 0.9);
}

drawplayerviewforever() {
  for(;;) {
    drawarrow(level.player.origin, level.player getplayerangles(), (1, 1, 1));
    wait 0.05;
  }

}

drawtagforever(tag, opcolor) {
  self endon("death");

  for(;;) {
    drawtag(tag, opcolor);
    wait 0.05;
  }

}

dragtaguntildeath(tag) {
  for(;;) {
    if(!isDefined(self.origin)) {
      break;
    }

    drawtag(tag);
    wait 0.05;
  }

}

viewtag(type, tag) {
  if(type == "ai") {
    ai = getaiarray();

    for(i = 0; i < ai.size; i++)
      ai[i] drawtag(tag);
  } else {
    vehicle = getentarray("script_vehicle", "classname");

    for(i = 0; i < vehicle.size; i++)
      vehicle[i] drawtag(tag);
  }

}

debug_corner() {
  players = get_players();

  for(i = 0; i < players.size; i++)
    players[i].ignoreme = 1;

  nodes = getallnodes();
  corners = [];

  for(i = 0; i < nodes.size; i++) {
    if(nodes[i].type == "Cover Left")
      corners[corners.size] = nodes[i];

    if(nodes[i].type == "Cover Right")
      corners[corners.size] = nodes[i];
  }

  ai = getaiarray();

  for(i = 0; i < ai.size; i++)
    ai[i] delete();

  level.debugspawners = getspawnerarray();
  level.activenodes = [];
  level.completednodes = [];

  for(i = 0; i < level.debugspawners.size; i++)
    level.debugspawners[i].targetname = "blah";

  covered = 0;

  for(i = 0; i < 30; i++) {
    if(i >= corners.size) {
      break;
    }

    corners[i] thread covertest();
    covered++;
  }

  if(corners.size <= 30) {
    return;
  }
  for(;;) {
    level waittill("debug_next_corner");

    if(covered >= corners.size)
      covered = 0;

    corners[covered] thread covertest();
    covered++;
  }

}

covertest() {
  coversetupanim();
}

coversetupanim() {
  spawn = undefined;
  spawner = undefined;

  for(;;) {
    for(i = 0; i < level.debugspawners.size; i++) {
      wait 0.05;
      spawner = level.debugspawners[i];
      nearactive = 0;

      for(p = 0; p < level.activenodes.size; p++) {
        if(distance(level.activenodes[p].origin, self.origin) > 250) {
          continue;
        }
        nearactive = 1;
        break;
      }

      if(nearactive) {
        continue;
      }
      completed = 0;

      for(p = 0; p < level.completednodes.size; p++) {
        if(level.completednodes[p] != self) {
          continue;
        }
        completed = 1;
        break;
      }

      if(completed) {
        continue;
      }
      level.activenodes[level.activenodes.size] = self;
      spawner.origin = self.origin;
      spawner.angles = self.angles;
      spawner.count = 1;
      spawn = spawner stalingradspawn();

      if(spawn_failed(spawn)) {
        removeactivespawner(self);
        continue;
      }

      break;
    }

    if(isalive(spawn)) {
      break;
    }
  }

  wait 1;

  if(isalive(spawn)) {
    spawn.ignoreme = 1;
    spawn.team = "neutral";
    spawn setgoalpos(spawn.origin);
    thread createline(self.origin);
    spawn thread debugorigin();
    thread createlineconstantly(spawn);
    spawn waittill("death");
  }

  removeactivespawner(self);
  level.completednodes[level.completednodes.size] = self;
}

removeactivespawner(spawner) {
  newspawners = [];

  for(p = 0; p < level.activenodes.size; p++) {
    if(level.activenodes[p] == spawner) {
      continue;
    }
    newspawners[newspawners.size] = level.activenodes[p];
  }

  level.activenodes = newspawners;
}

createline(org) {
  for(;;) {
    line(org + vectorscale((0, 0, 1), 35.0), org, (0.2, 0.5, 0.8), 0.5);
    wait 0.05;
  }

}

createlineconstantly(ent) {
  org = undefined;

  while(isalive(ent)) {
    org = ent.origin;
    wait 0.05;
  }

  for(;;) {
    line(org + vectorscale((0, 0, 1), 35.0), org, (1.0, 0.2, 0.1), 0.5);
    wait 0.05;
  }

}

debugmisstime() {
  self notify("stopdebugmisstime");
  self endon("stopdebugmisstime");
  self endon("death");

  for(;;) {
    if(self.a.misstime <= 0)
      print3d(self gettagorigin("TAG_EYE") + vectorscale((0, 0, 1), 15.0), "hit", (0.3, 1, 1), 1);
    else
      print3d(self gettagorigin("TAG_EYE") + vectorscale((0, 0, 1), 15.0), self.a.misstime / 20, (0.3, 1, 1), 1);

    wait 0.05;
  }

}

debugmisstimeoff() {
  self notify("stopdebugmisstime");
}

setemptydvar(dvar, setting) {
  if(getdebugdvar(dvar) == "")
    setdvar(dvar, setting);
}

debugjump(num) {
  ai = getaiarray();

  for(i = 0; i < ai.size; i++) {
    if(ai[i] getentnum() != num) {
      continue;
    }
    players = get_players();
    line(players[0].origin, ai[i].origin, (0.2, 0.3, 1.0));
    return;
  }

}

debugdvars() {
  precachemodel("test_sphere_silver");
  precachemodel("test_sphere_lambert");
  precachemodel("test_macbeth_chart");
  precachemodel("test_macbeth_chart_unlit");

  if(getdebugdvar("debug_vehiclesittags") == "")
    setdvar("debug_vehiclesittags", "off");

  if(getdvar(#"_id_2E717886") == "")
    setdvar("level_transition_test", "off");

  if(getdvar(#"_id_3C98BCAE") == "")
    setdvar("level_completeall", "off");

  if(getdvar(#"_id_85A1539B") == "")
    setdvar("level_clear_all", "off");

  setemptydvar("debug_accuracypreview", "off");

  if(getdebugdvar("debug_lookangle") == "")
    setdvar("debug_lookangle", "off");

  if(getdebugdvar("debug_grenademiss") == "")
    setdvar("debug_grenademiss", "off");

  if(getdebugdvar("debug_enemypos") == "")
    setdvar("debug_enemypos", "-1");

  if(getdebugdvar("debug_dotshow") == "")
    setdvar("debug_dotshow", "-1");

  if(getdebugdvar("debug_stopenemypos") == "")
    setdvar("debug_stopenemypos", "-1");

  if(getdebugdvar("debug_replayenemypos") == "")
    setdvar("debug_replayenemypos", "-1");

  if(getdebugdvar("debug_tag") == "")
    setdvar("debug_tag", "");

  if(getdebugdvar("debug_chatlook") == "")
    setdvar("debug_chatlook", "");

  if(getdebugdvar("debug_vehicletag") == "")
    setdvar("debug_vehicletag", "");

  if(getdebugdvar("debug_colorfriendlies") == "")
    setdvar("debug_colorfriendlies", "off");

  if(getdebugdvar("debug_goalradius") == "")
    setdvar("debug_goalradius", "off");

  if(getdebugdvar("debug_maxvisibledist") == "")
    setdvar("debug_maxvisibledist", "off");

  if(getdebugdvar("debug_health") == "")
    setdvar("debug_health", "off");

  if(getdebugdvar("debug_engagedist") == "")
    setdvar("debug_engagedist", "off");

  if(getdebugdvar("debug_animreach") == "")
    setdvar("debug_animreach", "off");

  if(getdebugdvar("debug_hatmodel") == "")
    setdvar("debug_hatmodel", "on");

  if(getdebugdvar("debug_trace") == "")
    setdvar("debug_trace", "off");

  level.debug_badpath = 0;

  if(getdebugdvar("debug_badpath") == "")
    setdvar("debug_badpath", "off");

  if(getdebugdvar("anim_lastsightpos") == "")
    setdvar("debug_lastsightpos", "off");

  if(getdebugdvar("debug_dog_sound") == "")
    setdvar("debug_dog_sound", "");

  if(getdvar(#"_id_55B12A1E") == "")
    setdvar("debug_nuke", "off");

  if(getdebugdvar("debug_deathents") == "on")
    setdvar("debug_deathents", "off");

  if(getdvar(#"_id_55AEF8E7") == "")
    setdvar("debug_jump", "");

  if(getdvar(#"_id_55ADE0CE") == "")
    setdvar("debug_hurt", "");

  if(getdebugdvar("animsound") == "")
    setdvar("animsound", "off");

  if(getdvar(#"_id_0B88AD41") == "")
    setdvar("tag", "");

  for(i = 1; i <= level.animsound_hudlimit; i++) {
    if(getdvar(#"_id_0B88AD41" + i) == "")
      setdvar("tag" + i, "");
  }

  if(getdebugdvar("animsound_save") == "")
    setdvar("animsound_save", "");

  if(getdvar(#"_id_0B18CA60") == "")
    setdvar("debug_depth", "");

  if(getdvarint(#"_id_1A89574D") > 0)
    setdvar("ai_debugColorNodes", 0);

  if(getdebugdvar("debug_reflection") == "")
    setdvar("debug_reflection", "0");

  if(getdebugdvar("debug_reflection_matte") == "")
    setdvar("debug_reflection_matte", "0");

  if(getdebugdvar("debug_color_pallete") == "")
    setdvar("debug_color_pallete", "0");

  if(getdebugdvar("debug_dynamic_ai_spawning") == "")
    setdvar("debug_dynamic_ai_spawning", "0");

  level.last_threat_debug = -23430;

  if(getdebugdvar("debug_threat") == "")
    setdvar("debug_threat", "-1");

  waittillframeend;
  red = (1, 0, 0);
  blue = (0, 0, 1);
  yellow = (1, 1, 0);
  cyan = (0, 1, 1);
  green = (0, 1, 0);
  purple = (1, 0, 1);
  orange = (1, 0.5, 0);
  level.color_debug["r"] = red;
  level.color_debug["b"] = blue;
  level.color_debug["y"] = yellow;
  level.color_debug["c"] = cyan;
  level.color_debug["g"] = green;
  level.color_debug["p"] = purple;
  level.color_debug["o"] = orange;
  black = (0, 0, 0);
  white = (1, 1, 1);
  magenta = (1, 0, 1);
  grey = vectorscale((1, 1, 1), 0.75);
  level.color_debug["red"] = red;
  level.color_debug["blue"] = blue;
  level.color_debug["yellow"] = yellow;
  level.color_debug["cyan"] = cyan;
  level.color_debug["green"] = green;
  level.color_debug["purple"] = purple;
  level.color_debug["orange"] = orange;
  level.color_debug["black"] = black;
  level.color_debug["white"] = white;
  level.color_debug["magenta"] = magenta;
  level.color_debug["grey"] = grey;
  level.debug_reflection = 0;
  level.debug_reflection_matte = 0;
  level.debug_color_pallete = 0;

  if(getdvar(#"_id_0E130E60") == "")
    setdvar("debug_character_count", "off");

  noanimscripts = getdvar(#"_id_2D9DA875") == "on";

  for(;;) {
    if(getdebugdvar("debug_jump") != "")
      debugjump(getdebugdvarint("debug_jump"));

    if(getdebugdvar("debug_tag") != "") {
      thread viewtag("ai", getdebugdvar("debug_tag"));

      if(getdebugdvarint("debug_enttag") > 0)
        thread drawenttag(getdebugdvarint("debug_enttag"));
    }

    if(getdebugdvar("debug_goalradius") == "on")
      level thread debug_goalradius();

    if(getdebugdvar("debug_maxvisibledist") == "on")
      level thread debug_maxvisibledist();

    if(getdebugdvar("debug_health") == "on")
      level thread debug_health();

    if(getdebugdvar("debug_engagedist") == "on")
      level thread debug_engagedist();

    if(getdebugdvar("debug_vehicletag") != "")
      thread viewtag("vehicle", getdebugdvar("debug_vehicletag"));

    if(getdvarint(#"_id_1A89574D") > 0)
      thread debug_colornodes();

    if(getdebugdvar("debug_vehiclesittags") != "off")
      thread debug_vehiclesittags();

    if(getdebugdvar("debug_replayenemypos") == "on")
      thread debug_enemyposreplay();

    thread debug_animsound();

    if(getdvar(#"_id_0B88AD41") != "")
      thread debug_animsoundtagselected();

    for(i = 1; i <= level.animsound_hudlimit; i++) {
      if(getdvar(#"_id_0B88AD41" + i) != "")
        thread debug_animsoundtag(i);
    }

    if(getdebugdvar("animsound_save") != "")
      thread debug_animsoundsave();

    if(getdvar(#"_id_55B12A1E") != "off")
      thread debug_nuke();

    if(getdvar(#"_id_4C406056") == "on") {
      setdvar("debug_misstime", "start");
      array_thread(getaiarray(), ::debugmisstime);
    } else if(getdvar(#"_id_4C406056") == "off") {
      setdvar("debug_misstime", "start");
      array_thread(getaiarray(), ::debugmisstimeoff);
    }

    if(getdvar(#"_id_A2C6B0AB") == "on")
      thread deathspawnerpreview();

    if(getdvar(#"_id_55ADE0CE") == "on") {
      setdvar("debug_hurt", "off");
      players = get_players();

      for(i = 0; i < players.size; i++)
        players[i] dodamage(50, (324234, 3423423, 2323));
    }

    if(getdvar(#"_id_55ADE0CE") == "on") {
      setdvar("debug_hurt", "off");
      players = get_players();

      for(i = 0; i < players.size; i++)
        players[i] dodamage(50, (324234, 3423423, 2323));
    }

    if(getdvar(#"_id_0B18CA60") == "on")
      thread fogcheck();

    if(getdebugdvar("debug_threat") != "-1" && getdebugdvar("debug_threat") != "")
      debugthreat();

    level.debug_badpath = getdebugdvar("debug_badpath") == "on";

    if(getdebugdvarint("debug_enemypos") != -1) {
      thread debug_enemypos(getdebugdvarint("debug_enemypos"));
      setdvar("debug_enemypos", "-1");
    }

    if(getdebugdvarint("debug_stopenemypos") != -1) {
      thread debug_stopenemypos(getdebugdvarint("debug_stopenemypos"));
      setdvar("debug_stopenemypos", "-1");
    }

    if(!noanimscripts && getdvar(#"_id_2D9DA875") == "on") {
      anim.defaultexception = animscripts\init::infiniteloop();
      noanimscripts = 1;
    }

    if(noanimscripts && getdvar(#"_id_2D9DA875") == "off") {
      anim.defaultexception = ::empty;
      anim notify("new exceptions");
      noanimscripts = 0;
    }

    if(getdebugdvar("debug_trace") == "on") {
      if(!isDefined(level.tracestart))
        thread showdebugtrace();

      players = get_players();
      level.tracestart = players[0] geteye();
      setdvar("debug_trace", "off");
    }

    if(getdebugdvar("debug_dynamic_ai_spawning") == "1" && (!isDefined(level.spawn_anywhere_active) || level.spawn_anywhere_active == 0)) {
      level.spawn_anywhere_active = 1;
      level.spawn_anywhere_friendly = getdebugdvar("debug_dynamic_ai_spawn_friendly");
      thread dynamic_ai_spawner();
    } else if(getdebugdvar("debug_dynamic_ai_spawning") == "0" && isDefined(level.spawn_anywhere_active) && level.spawn_anywhere_active == 1) {
      level.spawn_anywhere_active = 0;
      level notify("kill dynamic spawning");
    }

    if(isDefined(level.spawn_anywhere_active) && level.spawn_anywhere_active == 1 && getdebugdvar("debug_dynamic_ai_spawn_friendly") != level.spawn_anywhere_friendly) {
      level notify("kill dynamic spawning");
      level.spawn_anywhere_active = 0;
    }

    if(getdebugdvar("debug_ai_puppeteer") == "1" && (!isDefined(level.ai_puppeteer_active) || level.ai_puppeteer_active == 0)) {
      level.ai_puppeteer_active = 1;
      level notify("kill ai puppeteer");
      adddebugcommand("noclip");
      thread ai_puppeteer();
    } else if(getdebugdvar("debug_ai_puppeteer") == "0" && isDefined(level.ai_puppeteer_active) && level.ai_puppeteer_active == 1) {
      level.ai_puppeteer_active = 0;
      adddebugcommand("noclip");
      level notify("kill ai puppeteer");
    }

    debug_reflection();
    debug_reflection_matte();
    debug_color_pallete();
    wait 0.05;
  }

}

remove_reflection_objects() {
  if((level.debug_reflection == 2 || level.debug_reflection == 3) && isDefined(level.debug_reflection_objects)) {
    for(i = 0; i < level.debug_reflection_objects.size; i++)
      level.debug_reflection_objects[i] delete();

    level.debug_reflection_objects = undefined;
  }

  if(level.debug_reflection == 1 || level.debug_reflection == 3 || level.debug_reflection_matte == 1 || level.debug_color_pallete == 1 || level.debug_color_pallete == 2) {
    if(isDefined(level.debug_reflectionobject))
      level.debug_reflectionobject delete();
  }

}

create_reflection_objects() {
  reflection_locs = getreflectionlocs();

  for(i = 0; i < reflection_locs.size; i++) {
    level.debug_reflection_objects[i] = spawn("script_model", reflection_locs[i]);
    level.debug_reflection_objects[i] setmodel("test_sphere_silver");
  }

}

create_reflection_object(model) {
  if(!isDefined(model))
    model = "test_sphere_silver";

  if(isDefined(level.debug_reflectionobject))
    level.debug_reflectionobject delete();

  players = get_players();
  player = players[0];
  level.debug_reflectionobject = spawn("script_model", player geteye() + vectorscale(anglestoforward(player.angles), 100));
  level.debug_reflectionobject setmodel(model);
  level.debug_reflectionobject.origin = player geteye() + vectorscale(anglestoforward(player getplayerangles()), 100);
  level.debug_reflectionobject linkto(player);
  thread debug_reflection_buttons();
}

debug_reflection() {
  if(getdebugdvar("debug_reflection") == "2" && level.debug_reflection != 2 || getdebugdvar("debug_reflection") == "3" && level.debug_reflection != 3) {
    remove_reflection_objects();

    if(getdebugdvar("debug_reflection") == "2") {
      create_reflection_objects();
      level.debug_reflection = 2;
    } else {
      create_reflection_objects();
      create_reflection_object();
      level.debug_reflection = 3;
    }
  } else if(getdebugdvar("debug_reflection") == "1" && level.debug_reflection != 1) {
    setdvar("debug_reflection_matte", "0");
    setdvar("debug_color_pallete", "0");
    remove_reflection_objects();
    create_reflection_object();
    level.debug_reflection = 1;
  } else if(getdebugdvar("debug_reflection") == "0" && level.debug_reflection != 0) {
    remove_reflection_objects();
    level.debug_reflection = 0;
  }

}

debug_reflection_matte() {
  if(getdebugdvar("debug_reflection_matte") == "1" && level.debug_reflection_matte != 1) {
    setdvar("debug_reflection", "0");
    setdvar("debug_color_pallete", "0");
    remove_reflection_objects();
    create_reflection_object("test_sphere_lambert");
    level.debug_reflection_matte = 1;
  } else if(getdebugdvar("debug_reflection_matte") == "0" && level.debug_reflection_matte != 0) {
    remove_reflection_objects();
    level.debug_reflection_matte = 0;
  }

}

debug_color_pallete() {
  if(getdebugdvar("debug_color_pallete") == "1" && level.debug_color_pallete != 1) {
    setdvar("debug_reflection", "0");
    setdvar("debug_reflection_matte", "0");
    remove_reflection_objects();
    create_reflection_object("test_macbeth_chart");
    level.debug_color_pallete = 1;
  } else if(getdebugdvar("debug_color_pallete") == "2" && level.debug_color_pallete != 2) {
    remove_reflection_objects();
    create_reflection_object("test_macbeth_chart_unlit");
    level.debug_color_pallete = 2;
  } else if(getdebugdvar("debug_color_pallete") == "0" && level.debug_color_pallete != 0) {
    remove_reflection_objects();
    level.debug_color_pallete = 0;
  }

}

debug_reflection_buttons() {
  level notify("new_reflection_button_running");
  level endon("new_reflection_button_running");
  level.debug_reflectionobject endon("death");
  offset = 100;
  lastoffset = offset;

  while(getdebugdvar("debug_reflection") == "1" || getdebugdvar("debug_reflection") == "3" || getdebugdvar("debug_reflection_matte") == "1" || getdebugdvar("debug_color_pallete") == "1" || getdebugdvar("debug_color_pallete") == "2") {
    players = get_players();

    if(players[0] buttonpressed("BUTTON_X"))
      offset = offset + 50;

    if(players[0] buttonpressed("BUTTON_Y"))
      offset = offset - 50;

    if(offset > 1000)
      offset = 1000;

    if(offset < 64)
      offset = 64;

    level.debug_reflectionobject unlink();
    level.debug_reflectionobject.origin = players[0] geteye() + vectorscale(anglestoforward(players[0] getplayerangles()), offset);
    level.debug_reflectionobject.angles = flat_angle(vectortoangles(players[0].origin - level.debug_reflectionobject.origin));
    lastoffset = offset;
    line(level.debug_reflectionobject.origin, getreflectionorigin(level.debug_reflectionobject.origin), (1, 0, 0), 1, 1);
    wait 0.05;

    if(isDefined(level.debug_reflectionobject))
      level.debug_reflectionobject linkto(players[0]);
  }

}

showdebugtrace() {
  startoverride = undefined;
  endoverride = undefined;
  startoverride = (15.1859, -12.2822, 4.071);
  endoverride = (947.2, -10918, 64.9514);
  assert(!isDefined(level.traceend));

  for(;;) {
    players = get_players();
    wait 0.05;
    start = startoverride;
    end = endoverride;

    if(!isDefined(startoverride))
      start = level.tracestart;

    if(!isDefined(endoverride))
      end = players[0] geteye();

    trace = bullettrace(start, end, 0, undefined);
    line(start, trace["position"], (0.9, 0.5, 0.8), 0.5);
  }

}

hatmodel() {
  for(;;) {
    if(getdebugdvar("debug_hatmodel") == "off") {
      return;
    }
    nohat = [];
    ai = getaiarray();

    for(i = 0; i < ai.size; i++) {
      if(isDefined(ai[i].hatmodel)) {
        continue;
      }
      alreadyknown = 0;

      for(p = 0; p < nohat.size; p++) {
        if(nohat[p] != ai[i].classname) {
          continue;
        }
        alreadyknown = 1;
        break;
      }

      if(!alreadyknown)
        nohat[nohat.size] = ai[i].classname;
    }

    if(nohat.size) {
      println(" ");
      println("The following AI have no Hatmodel, so helmets can not pop off on head-shot death:");

      for(i = 0; i < nohat.size; i++)
        println("Classname: ", nohat[i]);

      println("To disable hatModel spam, type debug_hatmodel off");
    }

    wait 15;
  }

}

debug_nuke() {
  players = get_players();
  player = players[0];
  dvar = getdvar(#"_id_55B12A1E");

  if(dvar == "on") {
    ai = getaispeciesarray("axis", "all");

    for(i = 0; i < ai.size; i++)
      ai[i] dodamage(300, (0, 0, 0), player);
  } else if(dvar == "ai") {
    ai = getaiarray("axis");

    for(i = 0; i < ai.size; i++)
      ai[i] dodamage(300, (0, 0, 0), player);
  } else if(dvar == "dogs") {
    ai = getaispeciesarray("axis", "dog");

    for(i = 0; i < ai.size; i++)
      ai[i] dodamage(300, (0, 0, 0), player);
  }

  setdvar("debug_nuke", "off");
}

debug_misstime() {
}

camera() {
  wait 0.05;
  cameras = getentarray("camera", "targetname");

  for(i = 0; i < cameras.size; i++) {
    ent = getent(cameras[i].target, "targetname");
    cameras[i].origin2 = ent.origin;
    cameras[i].angles = vectortoangles(ent.origin - cameras[i].origin);
  }

  for(;;) {
    if(getdebugdvar("camera") != "on") {
      if(getdebugdvar("camera") != "off")
        setdvar("camera", "off");

      wait 1;
      continue;
    }

    ai = getaiarray("axis");

    if(!ai.size) {
      freeplayer();
      wait 0.5;
      continue;
    }

    camerawithenemy = [];

    for(i = 0; i < cameras.size; i++) {
      for(p = 0; p < ai.size; p++) {
        if(distance(cameras[i].origin, ai[p].origin) > 256) {
          continue;
        }
        camerawithenemy[camerawithenemy.size] = cameras[i];
        break;
      }
    }

    if(!camerawithenemy.size) {
      freeplayer();
      wait 0.5;
      continue;
    }

    camerawithplayer = [];

    for(i = 0; i < camerawithenemy.size; i++) {
      camera = camerawithenemy[i];
      start = camera.origin2;
      end = camera.origin;
      difference = vectortoangles((end[0], end[1], end[2]) - (start[0], start[1], start[2]));
      angles = (0, difference[1], 0);
      forward = anglestoforward(angles);
      players = get_players();
      difference = vectornormalize(end - players[0].origin);
      dot = vectordot(forward, difference);

      if(dot < 0.85) {
        continue;
      }
      camerawithplayer[camerawithplayer.size] = camera;
    }

    if(!camerawithplayer.size) {
      freeplayer();
      wait 0.5;
      continue;
    }

    players = get_players();
    dist = distance(players[0].origin, camerawithplayer[0].origin);
    newcam = camerawithplayer[0];

    for(i = 1; i < camerawithplayer.size; i++) {
      newdist = distance(players[0].origin, camerawithplayer[i].origin);

      if(newdist > dist) {
        continue;
      }
      newcam = camerawithplayer[i];
      dist = newdist;
    }

    setplayertocamera(newcam);
    wait 3;
  }

}

freeplayer() {
  setdvar("cl_freemove", "0");
}

setplayertocamera(camera) {
  setdvar("cl_freemove", "2");
  setdebugangles(camera.angles);
  setdebugorigin(camera.origin + vectorscale((0, 0, -1), 60.0));
}

deathspawnerpreview() {
  waittillframeend;

  for(i = 0; i < 50; i++) {
    if(!isDefined(level.deathspawnerents[i])) {
      continue;
    }
    array = level.deathspawnerents[i];

    for(p = 0; p < array.size; p++) {
      ent = array[p];

      if(isDefined(ent.truecount)) {
        print3d(ent.origin, i + ": " + ent.truecount, (0, 0.8, 0.6), 5);
        continue;
      }

      print3d(ent.origin, i + ": " + ".", (0, 0.8, 0.6), 5);
    }
  }

}

lastsightposwatch() {
  for(;;) {
    wait 0.05;
    num = getdvarint(#"_id_CCA59DEA");

    if(!num) {
      continue;
    }
    guy = undefined;
    ai = getaiarray();

    for(i = 0; i < ai.size; i++) {
      if(ai[i] getentnum() != num) {
        continue;
      }
      guy = ai[i];
      break;
    }

    if(!isalive(guy)) {
      continue;
    }
    if(guy animscripts\utility::hasenemysightpos())
      org = guy animscripts\utility::getenemysightpos();
    else
      org = undefined;

    for(;;) {
      newnum = getdvarint(#"_id_CCA59DEA");

      if(num != newnum) {
        break;
      }

      if(isalive(guy) && guy animscripts\utility::hasenemysightpos())
        org = guy animscripts\utility::getenemysightpos();

      if(!isDefined(org)) {
        wait 0.05;
        continue;
      }

      color = (0.2, 0.9, 0.8);
      line(org + (0, 0, 10), org + (0, 0, 10 * -1), color, 1.0);
      line(org + (10, 0, 0), org + (10 * -1, 0, 0), color, 1.0);
      line(org + (0, 10, 0), org + (0, 10 * -1, 0), color, 1.0);
      wait 0.05;
    }
  }

}

watchminimap() {
  precacheitem("defaultweapon");

  while(true) {
    updateminimapsetting();
    wait 0.25;
  }

}

updateminimapsetting() {
  requiredmapaspectratio = getdvarfloat(#"scr_RequiredMapAspectratio");

  if(!isDefined(level.minimapheight)) {
    setdvar("scr_minimap_height", "0");
    level.minimapheight = 0;
  }

  minimapheight = getdvarfloat(#"scr_minimap_height");

  if(minimapheight != level.minimapheight) {
    if(isDefined(level.minimaporigin)) {
      level.minimapplayer unlink();
      level.minimaporigin delete();
      level notify("end_draw_map_bounds");
    }

    if(minimapheight > 0) {
      level.minimapheight = minimapheight;
      players = get_players();
      player = players[0];
      corners = getentarray("minimap_corner", "targetname");

      if(corners.size == 2) {
        viewpos = corners[0].origin + corners[1].origin;
        viewpos = (viewpos[0] * 0.5, viewpos[1] * 0.5, viewpos[2] * 0.5);
        maxcorner = (corners[0].origin[0], corners[0].origin[1], viewpos[2]);
        mincorner = (corners[0].origin[0], corners[0].origin[1], viewpos[2]);

        if(corners[1].origin[0] > corners[0].origin[0])
          maxcorner = (corners[1].origin[0], maxcorner[1], maxcorner[2]);
        else
          mincorner = (corners[1].origin[0], mincorner[1], mincorner[2]);

        if(corners[1].origin[1] > corners[0].origin[1])
          maxcorner = (maxcorner[0], corners[1].origin[1], maxcorner[2]);
        else
          mincorner = (mincorner[0], corners[1].origin[1], mincorner[2]);

        viewpostocorner = maxcorner - viewpos;
        viewpos = (viewpos[0], viewpos[1], viewpos[2] + minimapheight);
        origin = spawn("script_origin", player.origin);
        northvector = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
        eastvector = (northvector[1], 0 - northvector[0], 0);
        disttotop = vectordot(northvector, viewpostocorner);

        if(disttotop < 0)
          disttotop = 0 - disttotop;

        disttoside = vectordot(eastvector, viewpostocorner);

        if(disttoside < 0)
          disttoside = 0 - disttoside;

        if(requiredmapaspectratio > 0) {
          mapaspectratio = disttoside / disttotop;

          if(mapaspectratio < requiredmapaspectratio) {
            incr = requiredmapaspectratio / mapaspectratio;
            disttoside = disttoside * incr;
            addvec = vecscale(eastvector, vectordot(eastvector, maxcorner - viewpos) * (incr - 1));
            mincorner = mincorner - addvec;
            maxcorner = maxcorner + addvec;
          } else {
            incr = mapaspectratio / requiredmapaspectratio;
            disttotop = disttotop * incr;
            addvec = vecscale(northvector, vectordot(northvector, maxcorner - viewpos) * (incr - 1));
            mincorner = mincorner - addvec;
            maxcorner = maxcorner + addvec;
          }
        }

        if(level.console) {
          aspectratioguess = 1.77778;
          angleside = 2 * atan(disttoside * 0.8 / minimapheight);
          angletop = 2 * atan(disttotop * aspectratioguess * 0.8 / minimapheight);
        } else {
          aspectratioguess = 1.33333;
          angleside = 2 * atan(disttoside * 1.05 / minimapheight);
          angletop = 2 * atan(disttotop * aspectratioguess * 1.05 / minimapheight);
        }

        if(angleside > angletop)
          angle = angleside;
        else
          angle = angletop;

        znear = minimapheight - 1000;

        if(znear < 16)
          znear = 16;

        if(znear > 10000)
          znear = 10000;

        player playerlinktoabsolute(origin);
        origin.origin = viewpos + vectorscale((0, 0, -1), 62.0);
        origin.angles = (90, getnorthyaw(), 0);
        player giveweapon("defaultweapon");
        player setclientdvar("cg_fov", angle);
        level.minimapplayer = player;
        level.minimaporigin = origin;
        thread drawminimapbounds(viewpos, mincorner, maxcorner);
      } else
        println("^1Error: There are not exactly 2 \"minimap_corner\" entities in the level.");
    }
  }

}

getchains() {
  chainarray = [];
  chainarray = getentarray("minimap_line", "script_noteworthy");
  array = [];

  for(i = 0; i < chainarray.size; i++)
    array[i] = chainarray[i] getchain();

  return array;
}

getchain() {
  array = [];
  ent = self;

  while(isDefined(ent)) {
    array[array.size] = ent;

    if(!isDefined(ent) || !isDefined(ent.target)) {
      break;
    }

    ent = getent(ent.target, "targetname");

    if(isDefined(ent) && ent == array[0]) {
      array[array.size] = ent;
      break;
    }
  }

  originarray = [];

  for(i = 0; i < array.size; i++)
    originarray[i] = array[i].origin;

  return originarray;
}

vecscale(vec, scalar) {
  return (vec[0] * scalar, vec[1] * scalar, vec[2] * scalar);
}

drawminimapbounds(viewpos, mincorner, maxcorner) {
  level notify("end_draw_map_bounds");
  level endon("end_draw_map_bounds");
  viewheight = viewpos[2] - maxcorner[2];
  diaglen = length(mincorner - maxcorner);
  mincorneroffset = mincorner - viewpos;
  mincorneroffset = vectornormalize((mincorneroffset[0], mincorneroffset[1], 0));
  mincorner = mincorner + vecscale(mincorneroffset, diaglen * 1 / 800 * 0);
  maxcorneroffset = maxcorner - viewpos;
  maxcorneroffset = vectornormalize((maxcorneroffset[0], maxcorneroffset[1], 0));
  maxcorner = maxcorner + vecscale(maxcorneroffset, diaglen * 1 / 800 * 0);
  north = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  diagonal = maxcorner - mincorner;
  side = vecscale(north, vectordot(diagonal, north));
  sidenorth = vecscale(north, abs(vectordot(diagonal, north)));
  corner0 = mincorner;
  corner1 = mincorner + side;
  corner2 = maxcorner;
  corner3 = maxcorner - side;
  toppos = vecscale(mincorner + maxcorner, 0.5) + vecscale(sidenorth, 0.51);
  textscale = diaglen * 0.003;
  chains = getchains();

  while(true) {
    line(corner0, corner1);
    line(corner1, corner2);
    line(corner2, corner3);
    line(corner3, corner0);
    array_ent_thread(chains, maps\_utility::plot_points);
    print3d(toppos, "This Side Up", (1, 1, 1), 1, textscale);
    wait 0.05;
  }

}

debug_vehiclesittags() {
  vehicles = getentarray("script_vehicle", "classname");
  type = "none";
  type = getdebugdvar("debug_vehiclesittags");

  for(i = 0; i < vehicles.size; i++) {
    if(!isDefined(level.vehicle_aianims[vehicles[i].vehicletype])) {
      continue;
    }
    anims = level.vehicle_aianims[vehicles[i].vehicletype];

    for(j = 0; j < anims.size; j++) {
      players = get_players();

      if(isDefined(anims[j].sittag)) {
        vehicles[i] thread drawtag(anims[j].sittag);
        org = vehicles[i] gettagorigin(anims[j].sittag);

        if(players[0] islookingatorigin(org))
          print3d(org + vectorscale((0, 0, 1), 16.0), anims[j].sittag, (1, 1, 1), 1, 1);
      }
    }
  }

}

islookingatorigin(origin) {
  normalvec = vectornormalize(origin - self getshootatpos());
  veccomp = vectornormalize(origin - vectorscale((0, 0, 1), 24.0) - self getshootatpos());
  insidedot = vectordot(normalvec, veccomp);
  anglevec = anglestoforward(self getplayerangles());
  vectordot = vectordot(anglevec, normalvec);

  if(vectordot > insidedot)
    return true;
  else
    return false;
}

debug_colornodes() {
  wait 0.05;
  ai = getaiarray();
  array = [];
  array["axis"] = [];
  array["allies"] = [];
  array["neutral"] = [];

  for(i = 0; i < ai.size; i++) {
    guy = ai[i];

    if(!isDefined(guy.currentcolorcode)) {
      continue;
    }
    array[guy.team][guy.currentcolorcode] = 1;
    color = (1, 1, 1);

    if(isDefined(guy.script_forcecolor))
      color = level.color_debug[guy.script_forcecolor];

    recordenttext(guy.currentcolorcode, guy, color, "Script");
    print3d(guy.origin + vectorscale((0, 0, 1), 25.0), guy.currentcolorcode, color, 1, 0.7);

    if(guy.team == "axis") {
      continue;
    }
    guy try_to_draw_line_to_node();
  }

  draw_colornodes(array, "allies");
  draw_colornodes(array, "axis");
}

draw_colornodes(array, team) {
  keys = getarraykeys(array[team]);

  for(i = 0; i < keys.size; i++) {
    color = (1, 1, 1);
    color = level.color_debug[getsubstr(keys[i], 0, 1)];

    if(isDefined(level.colornodes_debug_array[team][keys[i]])) {
      teamarray = level.colornodes_debug_array[team][keys[i]];

      for(p = 0; p < teamarray.size; p++) {
        print3d(teamarray[p].origin, "N-" + keys[i], color, 1, 0.7);

        if(getdvarint(#"_id_1A89574D") == 2 && isDefined(teamarray[p].script_color_allies_old)) {
          if(isDefined(teamarray[p].color_user) && isalive(teamarray[p].color_user) && isDefined(teamarray[p].color_user.script_forcecolor)) {
            print3d(teamarray[p].origin + vectorscale((0, 0, -1), 5.0), "N-" + teamarray[p].script_color_allies_old, level.color_debug[teamarray[p].color_user.script_forcecolor], 0.5, 0.4);
            continue;
          }

          print3d(teamarray[p].origin + vectorscale((0, 0, -1), 5.0), "N-" + teamarray[p].script_color_allies_old, color, 0.5, 0.4);
        }
      }
    }
  }

}

get_team_substr() {
  if(self.team == "allies") {
    if(!isDefined(self.node.script_color_allies_old)) {
      return;
    }
    return self.node.script_color_allies_old;
  }

  if(self.team == "axis") {
    if(!isDefined(self.node.script_color_axis_old)) {
      return;
    }
    return self.node.script_color_axis_old;
  }

}

try_to_draw_line_to_node() {
  if(!isDefined(self.node)) {
    return;
  }
  if(!isDefined(self.script_forcecolor)) {
    return;
  }
  substr = get_team_substr();

  if(!isDefined(substr)) {
    return;
  }
  if(!issubstr(substr, self.script_forcecolor)) {
    return;
  }
  recordline(self.origin + vectorscale((0, 0, 1), 25.0), self.node.origin, level.color_debug[self.script_forcecolor], "Script", self);
  line(self.origin + vectorscale((0, 0, 1), 25.0), self.node.origin, level.color_debug[self.script_forcecolor]);
}

fogcheck() {
  if(getdvar(#"_id_CA911A0F") == "")
    setdvar("depth_close", "0");

  if(getdvar(#"_id_6C527472") == "")
    setdvar("depth_far", "1500");

  close = getdvarint(#"_id_CA911A0F");
  far = getdvarint(#"_id_6C527472");
  setexpfog(close, far, 1, 1, 1, 0);
}

debugthreat() {
  level.last_threat_debug = gettime();
  thread debugthreatcalc();
}

debugthreatcalc() {
  ai = getaiarray();
  entnum = getdebugdvarint("debug_threat");
  entity = undefined;
  players = get_players();

  if(entnum == 0)
    entity = players[0];
  else {
    for(i = 0; i < ai.size; i++) {
      if(entnum != ai[i] getentnum()) {
        continue;
      }
      entity = ai[i];
      break;
    }
  }

  if(!isalive(entity)) {
    return;
  }
  entitygroup = entity getthreatbiasgroup();
  array_thread(ai, ::displaythreat, entity, entitygroup);
  players[0] thread displaythreat(entity, entitygroup);
}

displaythreat(entity, entitygroup) {
  self endon("death");

  if(self.team == entity.team) {
    return;
  }
  selfthreat = 0;
  selfthreat = selfthreat + self.threatbias;
  threat = 0;
  threat = threat + entity.threatbias;
  mygroup = undefined;

  if(isDefined(entitygroup)) {
    mygroup = self getthreatbiasgroup();

    if(isDefined(mygroup)) {
      threat = threat + getthreatbias(entitygroup, mygroup);
      selfthreat = selfthreat + getthreatbias(mygroup, entitygroup);
    }
  }

  if(entity.ignoreme || threat < -900000)
    threat = "Ignore";

  if(self.ignoreme || selfthreat < -900000)
    selfthreat = "Ignore";

  players = get_players();
  col = (1, 0.5, 0.2);
  col2 = (0.2, 0.5, 1);
  pacifist = self != players[0] && self.pacifist;

  for(i = 0; i <= 20; i++) {
    print3d(self.origin + vectorscale((0, 0, 1), 65.0), "Him to Me:", col, 3);
    print3d(self.origin + vectorscale((0, 0, 1), 50.0), threat, col, 5);

    if(isDefined(entitygroup))
      print3d(self.origin + vectorscale((0, 0, 1), 35.0), entitygroup, col, 2);

    print3d(self.origin + vectorscale((0, 0, 1), 15.0), "Me to Him:", col2, 3);
    print3d(self.origin + (0, 0, 0), selfthreat, col2, 5);

    if(isDefined(mygroup))
      print3d(self.origin + vectorscale((0, 0, -1), 15.0), mygroup, col2, 2);

    if(pacifist)
      print3d(self.origin + vectorscale((0, 0, 1), 25.0), "( Pacifist )", col2, 5);

    wait 0.05;
  }

}

debugcolorfriendlies() {
  level.debug_color_friendlies = [];
  level.debug_color_huds = [];
  level thread debugcolorfriendliestogglewatch();

  for(;;) {
    level waittill("updated_color_friendlies");
    draw_color_friendlies();
  }

}

debugcolorfriendliestogglewatch() {
  just_turned_on = 0;
  just_turned_off = 0;

  while(true) {
    if(getdebugdvar("debug_colorfriendlies") == "on" && !just_turned_on) {
      just_turned_on = 1;
      just_turned_off = 0;
      draw_color_friendlies();
    }

    if(getdebugdvar("debug_colorfriendlies") != "on" && !just_turned_off) {
      just_turned_off = 1;
      just_turned_on = 0;
      draw_color_friendlies();
    }

    wait 0.25;
  }

}

draw_color_friendlies() {
  level endon("updated_color_friendlies");
  keys = getarraykeys(level.debug_color_friendlies);
  colored_friendlies = [];
  colors = [];
  colors[colors.size] = "r";
  colors[colors.size] = "o";
  colors[colors.size] = "y";
  colors[colors.size] = "g";
  colors[colors.size] = "c";
  colors[colors.size] = "b";
  colors[colors.size] = "p";
  rgb = get_script_palette();

  for(i = 0; i < colors.size; i++)
    colored_friendlies[colors[i]] = 0;

  for(i = 0; i < keys.size; i++) {
    color = level.debug_color_friendlies[keys[i]];
    colored_friendlies[color]++;
  }

  for(i = 0; i < level.debug_color_huds.size; i++)
    level.debug_color_huds[i] destroy();

  level.debug_color_huds = [];

  if(getdebugdvar("debug_colorfriendlies") != "on") {
    return;
  }
  y = 365;

  for(i = 0; i < colors.size; i++) {
    if(colored_friendlies[colors[i]] <= 0) {
      continue;
    }
    for(p = 0; p < colored_friendlies[colors[i]]; p++) {
      overlay = newhudelem();
      overlay.x = 15 + 25 * p;
      overlay.y = y;
      overlay setshader("white", 16, 16);
      overlay.alignx = "left";
      overlay.aligny = "bottom";
      overlay.alpha = 1;
      overlay.color = rgb[colors[i]];
      level.debug_color_huds[level.debug_color_huds.size] = overlay;
    }

    y = y + 25;
  }

}

init_animsounds() {
  level.animsounds = [];
  level.animsound_aliases = [];
  waittillframeend;
  waittillframeend;
  animnames = getarraykeys(level.scr_notetrack);

  for(i = 0; i < animnames.size; i++)
    init_notetracks_for_animname(animnames[i]);

  animnames = getarraykeys(level.scr_animsound);

  for(i = 0; i < animnames.size; i++)
    init_animsounds_for_animname(animnames[i]);
}

init_notetracks_for_animname(animname) {
  notetracks = getarraykeys(level.scr_notetrack[animname]);

  for(i = 0; i < notetracks.size; i++) {
    soundalias = level.scr_notetrack[animname][i]["sound"];

    if(!isDefined(soundalias)) {
      continue;
    }
    anime = level.scr_notetrack[animname][i]["anime"];
    notetrack = level.scr_notetrack[animname][i]["notetrack"];
    level.animsound_aliases[animname][anime][notetrack]["soundalias"] = soundalias;

    if(isDefined(level.scr_notetrack[animname][i]["created_by_animSound"]))
      level.animsound_aliases[animname][anime][notetrack]["created_by_animSound"] = 1;
  }

}

init_animsounds_for_animname(animname) {
  animes = getarraykeys(level.scr_animsound[animname]);

  for(i = 0; i < animes.size; i++) {
    anime = animes[i];
    soundalias = level.scr_animsound[animname][anime];
    level.animsound_aliases[animname][anime]["#" + anime]["soundalias"] = soundalias;
    level.animsound_aliases[animname][anime]["#" + anime]["created_by_animSound"] = 1;
  }

}

add_hud_line(x, y, msg) {
  hudelm = newhudelem();
  hudelm.alignx = "left";
  hudelm.aligny = "middle";
  hudelm.x = x;
  hudelm.y = y;
  hudelm.alpha = 1;
  hudelm.fontscale = 1;
  hudelm.label = msg;
  level.animsound_hud_extralines[level.animsound_hud_extralines.size] = hudelm;
  return hudelm;
}

debug_animsound() {
  enabled = getdebugdvar("animsound") == "on";

  if(!isDefined(level.animsound_hud)) {
    if(!enabled) {
      return;
    }
    level.animsound_selected = 0;
    level.animsound_input = "none";
    level.animsound_hud = [];
    level.animsound_hud_timer = [];
    level.animsound_hud_alias = [];
    level.animsound_hud_extralines = [];
    level.animsound_locked = 0;
    level.animsound_locked_pressed = 0;
    level.animsound_hud_animname = add_hud_line(-30, 180, "Actor: ");
    level.animsound_hud_anime = add_hud_line(100, 180, "Anim: ");
    add_hud_line(10, 190, "Notetrack or label");
    add_hud_line(-30, 190, "Elapsed");
    add_hud_line(-30, 160, "Del: Delete selected soundalias");
    add_hud_line(-30, 150, "F12: Lock selection");
    add_hud_line(-30, 140, "Add a soundalias with /tag alias or /tag# alias");
    level.animsound_hud_locked = add_hud_line(-30, 170, "*LOCKED*");
    level.animsound_hud_locked.alpha = 0;

    for(i = 0; i < level.animsound_hudlimit; i++) {
      hudelm = newhudelem();
      hudelm.alignx = "left";
      hudelm.aligny = "middle";
      hudelm.x = 10;
      hudelm.y = 200 + i * 10;
      hudelm.alpha = 1;
      hudelm.fontscale = 1;
      hudelm.label = "";
      level.animsound_hud[level.animsound_hud.size] = hudelm;
      hudelm = newhudelem();
      hudelm.alignx = "right";
      hudelm.aligny = "middle";
      hudelm.x = -10;
      hudelm.y = 200 + i * 10;
      hudelm.alpha = 1;
      hudelm.fontscale = 1;
      hudelm.label = "";
      level.animsound_hud_timer[level.animsound_hud_timer.size] = hudelm;
      hudelm = newhudelem();
      hudelm.alignx = "right";
      hudelm.aligny = "middle";
      hudelm.x = 210;
      hudelm.y = 200 + i * 10;
      hudelm.alpha = 1;
      hudelm.fontscale = 1;
      hudelm.label = "";
      level.animsound_hud_alias[level.animsound_hud_alias.size] = hudelm;
    }

    level.animsound_hud[0].color = (1, 1, 0);
    level.animsound_hud_timer[0].color = (1, 1, 0);
  } else if(!enabled) {
    for(i = 0; i < level.animsound_hudlimit; i++) {
      level.animsound_hud[i] destroy();
      level.animsound_hud_timer[i] destroy();
      level.animsound_hud_alias[i] destroy();
    }

    for(i = 0; i < level.animsound_hud_extralines.size; i++)
      level.animsound_hud_extralines[i] destroy();

    level.animsound_hud = undefined;
    level.animsound_hud_timer = undefined;
    level.animsound_hud_alias = undefined;
    level.animsound_hud_extralines = undefined;
    level.animsounds = undefined;
    return;
  }

  if(!isDefined(level.animsound_tagged))
    level.animsound_locked = 0;

  if(level.animsound_locked)
    level.animsound_hud_locked.alpha = 1;
  else
    level.animsound_hud_locked.alpha = 0;

  if(!isDefined(level.animsounds))
    init_animsounds();

  level.animsounds_thisframe = [];
  level.animsounds = remove_undefined_from_array(level.animsounds);
  array_thread(level.animsounds, ::display_animsound);
  players = get_players();

  if(level.animsound_locked) {
    for(i = 0; i < level.animsounds_thisframe.size; i++) {
      animsound = level.animsounds_thisframe[i];
      animsound.animsound_color = vectorscale((1, 1, 1), 0.5);
    }
  } else if(players.size > 0) {
    dot = 0.85;
    forward = anglestoforward(players[0] getplayerangles());

    for(i = 0; i < level.animsounds_thisframe.size; i++) {
      animsound = level.animsounds_thisframe[i];
      animsound.animsound_color = (0.25, 1.0, 0.5);
      difference = vectornormalize(animsound.origin + vectorscale((0, 0, 1), 40.0) - (players[0].origin + vectorscale((0, 0, 1), 55.0)));
      newdot = vectordot(forward, difference);

      if(newdot < dot) {
        continue;
      }
      dot = newdot;
      level.animsound_tagged = animsound;
    }
  }

  if(isDefined(level.animsound_tagged))
    level.animsound_tagged.animsound_color = (1, 1, 0);

  is_tagged = isDefined(level.animsound_tagged);

  for(i = 0; i < level.animsounds_thisframe.size; i++) {
    animsound = level.animsounds_thisframe[i];
    msg = "*";

    if(level.animsound_locked)
      msg = "*LOCK";

    print3d(animsound.origin + vectorscale((0, 0, 1), 40.0), msg + animsound.animsounds.size, animsound.animsound_color, 1, 1);
  }

  if(is_tagged)
    draw_animsounds_in_hud();
}

draw_animsounds_in_hud() {
  guy = level.animsound_tagged;
  animsounds = guy.animsounds;
  animname = "generic";

  if(isDefined(guy.animname))
    animname = guy.animname;

  level.animsound_hud_animname.label = "Actor: " + animname;
  players = get_players();

  if(players[0] buttonpressed("f12")) {
    if(!level.animsound_locked_pressed) {
      level.animsound_locked = !level.animsound_locked;
      level.animsound_locked_pressed = 1;
    }
  } else
    level.animsound_locked_pressed = 0;

  if(players[0] buttonpressed("UPARROW")) {
    if(level.animsound_input != "up")
      level.animsound_selected--;

    level.animsound_input = "up";
  } else if(players[0] buttonpressed("DOWNARROW")) {
    if(level.animsound_input != "down")
      level.animsound_selected++;

    level.animsound_input = "down";
  } else
    level.animsound_input = "none";

  for(i = 0; i < level.animsound_hudlimit; i++) {
    hudelm = level.animsound_hud[i];
    hudelm.label = "";
    hudelm.color = (1, 1, 1);
    hudelm = level.animsound_hud_timer[i];
    hudelm.label = "";
    hudelm.color = (1, 1, 1);
    hudelm = level.animsound_hud_alias[i];
    hudelm.label = "";
    hudelm.color = (1, 1, 1);
  }

  keys = getarraykeys(animsounds);
  highest = -1;

  for(i = 0; i < keys.size; i++) {
    if(keys[i] > highest)
      highest = keys[i];
  }

  if(highest == -1) {
    return;
  }
  if(level.animsound_selected > highest)
    level.animsound_selected = highest;

  if(level.animsound_selected < 0)
    level.animsound_selected = 0;

  for(;;) {
    if(isDefined(animsounds[level.animsound_selected])) {
      break;
    }

    level.animsound_selected--;

    if(level.animsound_selected < 0)
      level.animsound_selected = highest;
  }

  level.animsound_hud_anime.label = "Anim: " + animsounds[level.animsound_selected].anime;
  level.animsound_hud[level.animsound_selected].color = (1, 1, 0);
  level.animsound_hud_timer[level.animsound_selected].color = (1, 1, 0);
  level.animsound_hud_alias[level.animsound_selected].color = (1, 1, 0);
  time = gettime();

  for(i = 0; i < keys.size; i++) {
    key = keys[i];
    animsound = animsounds[key];
    hudelm = level.animsound_hud[key];
    soundalias = get_alias_from_stored(animsound);
    hudelm.label = key + 1 + ". " + animsound.notetrack;
    hudelm = level.animsound_hud_timer[key];
    hudelm.label = int((time - (animsound.end_time - 60000)) * 0.001);

    if(isDefined(soundalias)) {
      hudelm = level.animsound_hud_alias[key];
      hudelm.label = soundalias;

      if(!is_from_animsound(animsound.animname, animsound.anime, animsound.notetrack))
        hudelm.color = vectorscale((1, 1, 1), 0.7);
    }
  }

  players = get_players();

  if(players[0] buttonpressed("del")) {
    animsound = animsounds[level.animsound_selected];
    soundalias = get_alias_from_stored(animsound);

    if(!isDefined(soundalias)) {
      return;
    }
    if(!is_from_animsound(animsound.animname, animsound.anime, animsound.notetrack)) {
      return;
    }
    level.animsound_aliases[animsound.animname][animsound.anime][animsound.notetrack] = undefined;
    debug_animsoundsave();
  }

}

get_alias_from_stored(animsound) {
  if(!isDefined(level.animsound_aliases[animsound.animname])) {
    return;
  }
  if(!isDefined(level.animsound_aliases[animsound.animname][animsound.anime])) {
    return;
  }
  if(!isDefined(level.animsound_aliases[animsound.animname][animsound.anime][animsound.notetrack])) {
    return;
  }
  return level.animsound_aliases[animsound.animname][animsound.anime][animsound.notetrack]["soundalias"];
}

is_from_animsound(animname, anime, notetrack) {
  return isDefined(level.animsound_aliases[animname][anime][notetrack]["created_by_animSound"]);
}

display_animsound() {
  players = get_players();

  if(distance(players[0].origin, self.origin) > 1500) {
    return;
  }
  level.animsounds_thisframe[level.animsounds_thisframe.size] = self;
}

debug_animsoundtag(tagnum) {
  tag = getdvar(#"_id_0B88AD41" + tagnum);

  if(tag == "") {
    iprintlnbold("Enter the soundalias with /tag# aliasname");
    return;
  }

  tag_sound(tag, tagnum - 1);
  setdvar("tag" + tagnum, "");
}

debug_animsoundtagselected() {
  tag = getdvar(#"_id_0B88AD41");

  if(tag == "") {
    iprintlnbold("Enter the soundalias with /tag aliasname");
    return;
  }

  tag_sound(tag, level.animsound_selected);
  setdvar("tag", "");
}

tag_sound(tag, tagnum) {
  if(!isDefined(level.animsound_tagged)) {
    return;
  }
  if(!isDefined(level.animsound_tagged.animsounds[tagnum])) {
    return;
  }
  animsound = level.animsound_tagged.animsounds[tagnum];
  soundalias = get_alias_from_stored(animsound);

  if(!isDefined(soundalias) || is_from_animsound(animsound.animname, animsound.anime, animsound.notetrack)) {
    level.animsound_aliases[animsound.animname][animsound.anime][animsound.notetrack]["soundalias"] = tag;
    level.animsound_aliases[animsound.animname][animsound.anime][animsound.notetrack]["created_by_animSound"] = 1;
    debug_animsoundsave();
  }

}

debug_animsoundsave() {
  filename = "createfx/" + level.script + "_audio.gsc";
  file = openfile(filename, "write");

  if(file == -1) {
    iprintlnbold("Couldn't write to " + filename + ", make sure it is open for edit.");
    return;
  }

  iprintlnbold("Saved to " + filename);
  print_aliases_to_file(file);
  saved = closefile(file);
  setdvar("animsound_save", "");
}

print_aliases_to_file(file) {
  tab = "";
  fprintln(file, "#include maps\\_anim;");
  fprintln(file, "main()");
  fprintln(file, "{");
  fprintln(file, tab + "// Autogenerated by AnimSounds. Threaded off so that it can be placed before _load( has to create level.scr_notetrack first ).");
  fprintln(file, tab + "thread init_animsounds();");
  fprintln(file, "}");
  fprintln(file, "");
  fprintln(file, "init_animsounds()");
  fprintln(file, "{");
  fprintln(file, tab + "waittillframeend;");
  animnames = getarraykeys(level.animsound_aliases);

  for(i = 0; i < animnames.size; i++) {
    animes = getarraykeys(level.animsound_aliases[animnames[i]]);

    for(p = 0; p < animes.size; p++) {
      anime = animes[p];
      notetracks = getarraykeys(level.animsound_aliases[animnames[i]][anime]);

      for(z = 0; z < notetracks.size; z++) {
        notetrack = notetracks[z];

        if(!is_from_animsound(animnames[i], anime, notetrack)) {
          continue;
        }
        alias = level.animsound_aliases[animnames[i]][anime][notetrack]["soundalias"];

        if(notetrack == "#" + anime)
          fprintln(file, tab + "addOnStart_animSound( " + tostr(animnames[i]) + ", " + tostr(anime) + ", " + tostr(alias) + " ); ");
        else
          fprintln(file, tab + "addNotetrack_animSound( " + tostr(animnames[i]) + ", " + tostr(anime) + ", " + tostr(notetrack) + ", " + tostr(alias) + " ); ");

        println("^1Saved alias ^4" + alias + "^1 to notetrack ^4" + notetrack);
      }
    }
  }

  fprintln(file, "}");
}

tostr(str) {
  newstr = "\"";

  for(i = 0; i < str.size; i++) {
    if(str[i] == "\"") {
      newstr = newstr + "\\";
      newstr = newstr + "\"";
      continue;
    }

    newstr = newstr + str[i];
  }

  newstr = newstr + "\"";
  return newstr;
}

drawdebuglineinternal(frompoint, topoint, color, durationframes) {
  for(i = 0; i < durationframes; i++) {
    line(frompoint, topoint, color);
    wait 0.05;
  }

}

drawdebugline(frompoint, topoint, color, durationframes) {
  thread drawdebuglineinternal(frompoint, topoint, color, durationframes);
}

drawdebugenttoentinternal(ent1, ent2, color, durationframes) {
  for(i = 0; i < durationframes; i++) {
    if(!isDefined(ent1) || !isDefined(ent2)) {
      return;
    }
    line(ent1.origin, ent2.origin, color);
    wait 0.05;
  }

}

drawdebuglineenttoent(ent1, ent2, color, durationframes) {
  thread drawdebugenttoentinternal(ent1, ent2, color, durationframes);
}

complete_me() {
  wait 7;
  nextmission();
}

debug_bayonet() {
}

new_hud(hud_name, msg, x, y, scale) {
  if(!isDefined(level.hud_array))
    level.hud_array = [];

  if(!isDefined(level.hud_array[hud_name]))
    level.hud_array[hud_name] = [];

  hud = maps\_createmenu::set_hudelem(msg, x, y, scale);
  level.hud_array[hud_name][level.hud_array[hud_name].size] = hud;
  return hud;
}

debug_show_viewpos() {
  wait_for_first_player();
  hud_title = newdebughudelem();
  hud_title.x = 10;
  hud_title.y = 300;
  hud_title.alpha = 0;
  hud_title.alignx = "left";
  hud_title.fontscale = 1.2;
  hud_title settext(&"DEBUG_POSITION");
  x_pos = hud_title.x + 50;
  hud_x = newdebughudelem();
  hud_x.x = x_pos;
  hud_x.y = 300;
  hud_x.alpha = 0;
  hud_x.alignx = "left";
  hud_x.fontscale = 1.2;
  hud_x setvalue(0);
  hud_y = newdebughudelem();
  hud_y.x = 10;
  hud_y.y = 300;
  hud_y.alpha = 0;
  hud_y.alignx = "left";
  hud_y.fontscale = 1.2;
  hud_y setvalue(0);
  hud_z = newdebughudelem();
  hud_z.x = 10;
  hud_z.y = 300;
  hud_z.alpha = 0;
  hud_z.alignx = "left";
  hud_z.fontscale = 1.2;
  hud_z setvalue(0);
  setdvar("debug_show_viewpos", "0");
  players = get_players();

  while(true) {
    if(getdvarint(#"debug_show_viewpos") > 0) {
      hud_title.alpha = 1;
      hud_x.alpha = 1;
      hud_y.alpha = 1;
      hud_z.alpha = 1;
      x = players[0].origin[0];
      y = players[0].origin[1];
      z = players[0].origin[2];
      spacing1 = (2 + number_before_decimal(x)) * 8 + 10;
      spacing2 = (2 + number_before_decimal(y)) * 8 + 10;
      hud_y.x = x_pos + spacing1;
      hud_z.x = x_pos + spacing1 + spacing2;
      hud_x setvalue(round_to(x, 100));
      hud_y setvalue(round_to(y, 100));
      hud_z setvalue(round_to(z, 100));
    } else {
      hud_title.alpha = 0;
      hud_x.alpha = 0;
      hud_y.alpha = 0;
      hud_z.alpha = 0;
    }

    wait 0.5;
  }

}

number_before_decimal(num) {
  abs_num = abs(num);
  count = 0;

  while(true) {
    abs_num = abs_num * 0.1;
    count = count + 1;

    if(abs_num < 1)
      return count;
  }

}

round_to(val, num) {
  return int(val * num) / num;
}

set_event_printname_thread(text, focus) {
  level notify("stop_event_name_thread");
  level endon("stop_event_name_thread");

  if(getdvarint(#"loc_warnings") > 0) {
    return;
  }
  if(!isDefined(focus))
    focus = 0;

  suffix = "";

  if(focus)
    suffix = " [Focus Event]";

  setdvar("cg_zoneName", text);
  text = "Event: " + text + suffix;

  if(!isDefined(level.event_hudelem)) {
    hud = newhudelem();
    hud.horzalign = "center";
    hud.alignx = "center";
    hud.aligny = "top";
    hud.foreground = 1;
    hud.fontscale = 1.5;
    hud.sort = 50;
    hud.alpha = 1;
    hud.y = 15;
    level.event_hudelem = hud;
  }

  if(focus)
    level.event_hudelem.color = (1, 1, 0);
  else
    level.event_hudelem.color = (1, 1, 1);

  if(getdvar(#"_id_B7E2EEBA") == "")
    setdvar("debug_draw_event", "1");

  level.event_hudelem settext(text);
  enabled = 1;

  while(true) {
    toggle = 0;

    if(getdvarint(#"_id_B7E2EEBA") < 1) {
      toggle = 1;
      enabled = 0;
    } else if(getdvarint(#"_id_B7E2EEBA") > 0) {
      toggle = 1;
      enabled = 1;
    }

    if(toggle && enabled)
      level.event_hudelem.alpha = 1;
    else if(toggle)
      level.event_hudelem.alpha = 0;

    wait 0.5;
  }

}

get_playerone() {
  return get_players()[0];
}

engagement_distance_debug_toggle() {
  level endon("kill_engage_dist_debug_toggle_watcher");
  laststate = getdebugdvarint("debug_engage_dists");

  while(true) {
    currentstate = getdebugdvarint("debug_engage_dists");

    if(dvar_turned_on(currentstate) && !dvar_turned_on(laststate)) {
      weapon_engage_dists_init();
      thread debug_realtime_engage_dist();
      thread debug_ai_engage_dist();
      laststate = currentstate;
    } else if(!dvar_turned_on(currentstate) && dvar_turned_on(laststate)) {
      level notify("kill_all_engage_dist_debug");
      laststate = currentstate;
    }

    wait 0.3;
  }

}

dvar_turned_on(val) {
  if(val <= 0)
    return false;
  else
    return true;
}

engagement_distance_debug_init() {
  level.debug_xpos = -50;
  level.debug_ypos = 250;
  level.debug_yinc = 18;
  level.debug_fontscale = 1.5;
  level.white = (1, 1, 1);
  level.green = (0, 1, 0);
  level.yellow = (1, 1, 0);
  level.red = (1, 0, 0);
  level.realtimeengagedist = newhudelem();
  level.realtimeengagedist.alignx = "left";
  level.realtimeengagedist.fontscale = level.debug_fontscale;
  level.realtimeengagedist.x = level.debug_xpos;
  level.realtimeengagedist.y = level.debug_ypos;
  level.realtimeengagedist.color = level.white;
  level.realtimeengagedist settext("Current Engagement Distance: ");
  xpos = level.debug_xpos + 207;
  level.realtimeengagedist_value = newhudelem();
  level.realtimeengagedist_value.alignx = "left";
  level.realtimeengagedist_value.fontscale = level.debug_fontscale;
  level.realtimeengagedist_value.x = xpos;
  level.realtimeengagedist_value.y = level.debug_ypos;
  level.realtimeengagedist_value.color = level.white;
  level.realtimeengagedist_value setvalue(0);
  xpos = xpos + 37;
  level.realtimeengagedist_middle = newhudelem();
  level.realtimeengagedist_middle.alignx = "left";
  level.realtimeengagedist_middle.fontscale = level.debug_fontscale;
  level.realtimeengagedist_middle.x = xpos;
  level.realtimeengagedist_middle.y = level.debug_ypos;
  level.realtimeengagedist_middle.color = level.white;
  level.realtimeengagedist_middle settext(" units, SHORT/LONG by ");
  xpos = xpos + 105;
  level.realtimeengagedist_offvalue = newhudelem();
  level.realtimeengagedist_offvalue.alignx = "left";
  level.realtimeengagedist_offvalue.fontscale = level.debug_fontscale;
  level.realtimeengagedist_offvalue.x = xpos;
  level.realtimeengagedist_offvalue.y = level.debug_ypos;
  level.realtimeengagedist_offvalue.color = level.white;
  level.realtimeengagedist_offvalue setvalue(0);
  hudobjarray = [];
  hudobjarray[0] = level.realtimeengagedist;
  hudobjarray[1] = level.realtimeengagedist_value;
  hudobjarray[2] = level.realtimeengagedist_middle;
  hudobjarray[3] = level.realtimeengagedist_offvalue;
  return hudobjarray;
}

engage_dist_debug_hud_destroy(hudarray, killnotify) {
  level waittill(killnotify);

  for(i = 0; i < hudarray.size; i++)
    hudarray[i] destroy();
}

weapon_engage_dists_init() {
  level.engagedists = [];
  genericpistol = spawnstruct();
  genericpistol.engagedistmin = 125;
  genericpistol.engagedistoptimal = 225;
  genericpistol.engagedistmulligan = 50;
  genericpistol.engagedistmax = 400;
  shotty = spawnstruct();
  shotty.engagedistmin = 50;
  shotty.engagedistoptimal = 200;
  shotty.engagedistmulligan = 75;
  shotty.engagedistmax = 350;
  genericsmg = spawnstruct();
  genericsmg.engagedistmin = 100;
  genericsmg.engagedistoptimal = 275;
  genericsmg.engagedistmulligan = 100;
  genericsmg.engagedistmax = 500;
  genericlmg = spawnstruct();
  genericlmg.engagedistmin = 325;
  genericlmg.engagedistoptimal = 550;
  genericlmg.engagedistmulligan = 150;
  genericlmg.engagedistmax = 850;
  genericriflesa = spawnstruct();
  genericriflesa.engagedistmin = 325;
  genericriflesa.engagedistoptimal = 550;
  genericriflesa.engagedistmulligan = 150;
  genericriflesa.engagedistmax = 850;
  genericriflebolt = spawnstruct();
  genericriflebolt.engagedistmin = 350;
  genericriflebolt.engagedistoptimal = 600;
  genericriflebolt.engagedistmulligan = 150;
  genericriflebolt.engagedistmax = 900;
  generichmg = spawnstruct();
  generichmg.engagedistmin = 390;
  generichmg.engagedistoptimal = 600;
  generichmg.engagedistmulligan = 100;
  generichmg.engagedistmax = 900;
  genericsniper = spawnstruct();
  genericsniper.engagedistmin = 950;
  genericsniper.engagedistoptimal = 1700;
  genericsniper.engagedistmulligan = 300;
  genericsniper.engagedistmax = 3000;
  engage_dists_add("pistol", genericpistol);
  engage_dists_add("smg", genericsmg);
  engage_dists_add("spread", shotty);
  engage_dists_add("mg", generichmg);
  engage_dists_add("rifle", genericriflesa);
  engage_dists_add("springfield_scoped", genericsniper);
  engage_dists_add("type99_rifle_scoped", genericsniper);
  engage_dists_add("mosin_rifle_scoped", genericsniper);
  engage_dists_add("kar98k_scoped", genericsniper);
  engage_dists_add("fg42_scoped", genericsniper);
  engage_dists_add("lee_enfield_scoped", genericsniper);
  level thread engage_dists_watcher();
}

engage_dists_add(weapontypestr, values) {
  level.engagedists[weapontypestr] = values;
}

get_engage_dists(weapontypestr) {
  if(isDefined(level.engagedists[weapontypestr]))
    return level.engagedists[weapontypestr];
  else
    return undefined;
}

engage_dists_watcher() {
  level endon("kill_all_engage_dist_debug");
  level endon("kill_engage_dists_watcher");

  while(true) {
    player = get_playerone();
    playerweapon = player getcurrentweapon();

    if(!isDefined(player.lastweapon))
      player.lastweapon = playerweapon;
    else if(player.lastweapon == playerweapon) {
      wait 0.05;
      continue;
    }

    values = get_engage_dists(weaponclass(playerweapon));

    if(isDefined(values))
      level.weaponengagedistvalues = values;
    else
      level.weaponengagedistvalues = undefined;

    player.lastweapon = playerweapon;
    wait 0.05;
  }

}

debug_realtime_engage_dist() {
  level endon("kill_all_engage_dist_debug");
  level endon("kill_realtime_engagement_distance_debug");
  hudobjarray = engagement_distance_debug_init();
  level thread engage_dist_debug_hud_destroy(hudobjarray, "kill_all_engage_dist_debug");
  level.debugrtengagedistcolor = level.green;
  player = get_playerone();

  while(true) {
    lasttracepos = (0, 0, 0);
    direction = player getplayerangles();
    direction_vec = anglestoforward(direction);
    eye = player geteye();
    trace = bullettrace(eye, eye + vectorscale(direction_vec, 10000), 1, player);
    tracepoint = trace["position"];
    tracenormal = trace["normal"];
    tracedist = int(distance(eye, tracepoint));

    if(tracepoint != lasttracepos) {
      lasttracepos = tracepoint;

      if(!isDefined(level.weaponengagedistvalues)) {
        hudobj_changecolor(hudobjarray, level.white);
        hudobjarray engagedist_hud_changetext("nodata", tracedist);
      } else {
        engagedistmin = level.weaponengagedistvalues.engagedistmin;
        engagedistoptimal = level.weaponengagedistvalues.engagedistoptimal;
        engagedistmulligan = level.weaponengagedistvalues.engagedistmulligan;
        engagedistmax = level.weaponengagedistvalues.engagedistmax;

        if(tracedist >= engagedistmin && tracedist <= engagedistmax) {
          if(tracedist >= engagedistoptimal - engagedistmulligan && tracedist <= engagedistoptimal + engagedistmulligan) {
            hudobjarray engagedist_hud_changetext("optimal", tracedist);
            hudobj_changecolor(hudobjarray, level.green);
          } else {
            hudobjarray engagedist_hud_changetext("ok", tracedist);
            hudobj_changecolor(hudobjarray, level.yellow);
          }
        } else if(tracedist < engagedistmin) {
          hudobj_changecolor(hudobjarray, level.red);
          hudobjarray engagedist_hud_changetext("short", tracedist);
        } else if(tracedist > engagedistmax) {
          hudobj_changecolor(hudobjarray, level.red);
          hudobjarray engagedist_hud_changetext("long", tracedist);
        }
      }
    }

    thread plot_circle_fortime(1, 5, 0.05, level.debugrtengagedistcolor, tracepoint, tracenormal);
    thread plot_circle_fortime(1, 1, 0.05, level.debugrtengagedistcolor, tracepoint, tracenormal);
    wait 0.05;
  }

}

hudobj_changecolor(hudobjarray, newcolor) {
  for(i = 0; i < hudobjarray.size; i++) {
    hudobj = hudobjarray[i];

    if(hudobj.color != newcolor) {
      hudobj.color = newcolor;
      level.debugrtengagedistcolor = newcolor;
    }
  }

}

engagedist_hud_changetext(engagedisttype, units) {
  if(!isDefined(level.lastdisttype))
    level.lastdisttype = "none";

  if(engagedisttype == "optimal") {
    self[1] setvalue(units);
    self[2] settext("units: OPTIMAL!");
    self[3].alpha = 0;
  } else if(engagedisttype == "ok") {
    self[1] setvalue(units);
    self[2] settext("units: OK!");
    self[3].alpha = 0;
  } else if(engagedisttype == "short") {
    amountunder = level.weaponengagedistvalues.engagedistmin - units;
    self[1] setvalue(units);
    self[3] setvalue(amountunder);
    self[3].alpha = 1;

    if(level.lastdisttype != engagedisttype)
      self[2] settext("units: SHORT by ");
  } else if(engagedisttype == "long") {
    amountover = units - level.weaponengagedistvalues.engagedistmax;
    self[1] setvalue(units);
    self[3] setvalue(amountover);
    self[3].alpha = 1;

    if(level.lastdisttype != engagedisttype)
      self[2] settext("units: LONG by ");
  } else if(engagedisttype == "nodata") {
    self[1] setvalue(units);
    self[2] settext(" units: (NO CURRENT WEAPON VALUES)");
    self[3].alpha = 0;
  }

  level.lastdisttype = engagedisttype;
}

debug_ai_engage_dist() {
  level endon("kill_all_engage_dist_debug");
  level endon("kill_ai_engagement_distance_debug");
  player = get_playerone();

  while(true) {
    axis = getaiarray("axis");

    if(isDefined(axis) && axis.size > 0) {
      playereye = player geteye();

      for(i = 0; i < axis.size; i++) {
        ai = axis[i];
        aieye = ai geteye();

        if(sighttracepassed(playereye, aieye, 0, player)) {
          dist = distance(playereye, aieye);
          drawcolor = level.white;
          drawstring = "-";

          if(!isDefined(level.weaponengagedistvalues))
            drawcolor = level.white;
          else {
            engagedistmin = level.weaponengagedistvalues.engagedistmin;
            engagedistoptimal = level.weaponengagedistvalues.engagedistoptimal;
            engagedistmulligan = level.weaponengagedistvalues.engagedistmulligan;
            engagedistmax = level.weaponengagedistvalues.engagedistmax;

            if(dist >= engagedistmin && dist <= engagedistmax) {
              if(dist >= engagedistoptimal - engagedistmulligan && dist <= engagedistoptimal + engagedistmulligan) {
                drawcolor = level.green;
                drawstring = "RAD";
              } else {
                drawcolor = level.yellow;
                drawstring = "MEH";
              }
            } else if(dist < engagedistmin) {
              drawcolor = level.red;
              drawstring = "BAD";
            } else if(dist > engagedistmax) {
              drawcolor = level.red;
              drawstring = "BAD";
            }
          }

          scale = dist / 525;
          print3d(ai.origin + vectorscale((0, 0, 1), 67.0), drawstring, drawcolor, 1, scale);
        }
      }
    }

    wait 0.05;
  }

}

plot_circle_fortime(radius1, radius2, time, color, origin, normal) {
  if(!isDefined(color))
    color = (0, 1, 0);

  circleres = 6;
  hemires = circleres / 2;
  circleinc = 360 / circleres;
  circleres++;
  plotpoints = [];
  rad = 0.0;
  timer = gettime() + time * 1000;
  radius = radius1;

  while(gettime() < timer) {
    radius = radius2;
    angletoplayer = vectortoangles(normal);

    for(i = 0; i < circleres; i++) {
      plotpoints[plotpoints.size] = origin + vectorscale(anglestoforward(angletoplayer + (rad, 90, 0)), radius);
      rad = rad + circleinc;
    }

    maps\_utility::plot_points(plotpoints, color[0], color[1], color[2], 0.05);
    plotpoints = [];
    wait 0.05;
  }

}

dynamic_ai_spawner() {
  if(!isDefined(level.debug_dynamic_ai_spawner)) {
    dynamic_ai_spawner_init();
    level.debug_dynamic_ai_spawner = 1;
  }

  spawnfriendly = 0;
  spawnfriendly = getdebugdvar("debug_dynamic_ai_spawn_friendly") == "1";

  if(spawnfriendly && isDefined(level.friendly_spawner))
    get_players()[0] thread spawn_guy_placement(level.friendly_spawner);
  else
    get_players()[0] thread spawn_guy_placement(level.enemy_spawner);

  level waittill("kill dynamic spawning");

  if(isDefined(level.dynamic_spawn_hud))
    level.dynamic_spawn_hud destroy();

  if(isDefined(level.dynamic_spawn_dummy_model))
    level.dynamic_spawn_dummy_model delete();
}

dynamic_ai_spawner_init() {
  dynamic_ai_spawner_find_spawners();

  if(!isDefined(level.enemy_spawner)) {
    return;
  }
}

dynamic_ai_spawner_find_spawners() {
  spawners = getspawnerarray();

  for(i = 0; i < spawners.size; i++) {
    if(isDefined(spawners[i].targetname) && issubstr(spawners[i].targetname, "debug_spawner")) {
      enemy_spawner = spawners[i];
      enemy_spawner.script_forcespawn = 1;
      level.enemy_spawner = enemy_spawner;
    }
  }

  for(i = 0; i < spawners.size; i++) {
    classname = tolower(spawners[i].classname);

    if(issubstr(classname, "dog")) {
      continue;
    }
    if(!isDefined(level.enemy_spawner) && (issubstr(classname, "_e_") || issubstr(classname, "_enemy_")))
      level.enemy_spawner = dynamic_ai_spawner_setup_spawner(spawners[i]);

    if(!isDefined(level.friendly_spawner) && (issubstr(classname, "_a_") || issubstr(classname, "_ally_")) && !issubstr(classname, "dog"))
      level.friendly_spawner = dynamic_ai_spawner_setup_spawner(spawners[i]);
  }

}

dynamic_ai_spawner_setup_spawner(spawner) {
  spawner.script_forcespawn = 1;
  tempspawn = spawner spawn_ai();

  if(!spawn_failed(tempspawn)) {
    spawner.debug_model = tempspawn.model;
    spawner.debug_headmodel = tempspawn.headmodel;
    tempspawn delete();
  }

  return spawner;
}

spawn_guy_placement(spawner) {
  level endon("kill dynamic spawning");

  if(!isDefined(spawner)) {
    assert(isDefined(spawner), "No spawners in the level!");
    return;
  }

  level.dynamic_spawn_hud = newclienthudelem(get_players()[0]);
  level.dynamic_spawn_hud.alignx = "right";
  level.dynamic_spawn_hud.x = 110;
  level.dynamic_spawn_hud.y = 225;
  level.dynamic_spawn_hud.fontscale = 2;
  level.dynamic_spawn_hud settext("Press X to spawn AI");
  level.dynamic_spawn_dummy_model = spawn("script_model", (0, 0, 0));

  if(isDefined(spawner.debug_model)) {
    level.dynamic_spawn_dummy_model setmodel(spawner.debug_model);

    if(isDefined(spawner.debug_headmodel))
      level.dynamic_spawn_dummy_model attach(spawner.debug_headmodel, "", 1);
  } else
    level.dynamic_spawn_dummy_model setmodel("defaultactor");

  wait 0.1;

  for(;;) {
    direction = self getplayerangles();
    direction_vec = anglestoforward(direction);
    eye = self geteye();
    trace = bullettrace(eye, eye + vectorscale(direction_vec, 8000), 0, undefined);
    dist = distance(eye, trace["position"]);
    position = eye + vectorscale(direction_vec, dist - 64);
    spawner.origin = position;
    spawner.angles = self.angles + vectorscale((0, 1, 0), 180.0);
    level.dynamic_spawn_dummy_model.origin = position;
    level.dynamic_spawn_dummy_model.angles = self.angles + vectorscale((0, 1, 0), 180.0);
    self spawn_anywhere(spawner);
    wait 0.05;
  }

}

spawn_anywhere(spawner) {
  level endon("kill dynamic spawning");

  if(self usebuttonpressed()) {
    spawn = spawner spawn_ai();

    if(spawn_failed(spawn)) {
      assert(0, "spawn failed from spawn anywhere guy");
      return;
    }

    spawn.ignoreme = getdebugdvar("debug_dynamic_ai_ignoreMe") == "1";
    spawn.ignoreall = getdebugdvar("debug_dynamic_ai_ignoreAll") == "1";
    spawn.pacifist = getdebugdvar("debug_dynamic_ai_pacifist") == "1";
    spawn.fixednode = 0;
    wait 0.4;
  }

  spawner.count = 50;
}

display_module_text() {
  wait 1;
  iprintlnbold("Please open and read " + level.script + ".gsc for complete understanding");
}

debug_goalradius() {
  guys = getaiarray();

  for(i = 0; i < guys.size; i++) {
    if(guys[i].team == "axis") {
      print3d(guys[i].origin + vectorscale((0, 0, 1), 70.0), string(guys[i].goalradius), (1, 0, 0), 1, 1, 1);
      record3dtext("" + guys[i].goalradius, guys[i].origin + vectorscale((0, 0, 1), 70.0), level.color_debug["red"], "Animscript");
      continue;
    }

    print3d(guys[i].origin + vectorscale((0, 0, 1), 70.0), string(guys[i].goalradius), (0, 1, 0), 1, 1, 1);
    record3dtext("" + guys[i].goalradius, guys[i].origin + vectorscale((0, 0, 1), 70.0), level.color_debug["green"], "Animscript");
  }

}

debug_maxvisibledist() {
  guys = getaiarray();

  for(i = 0; i < guys.size; i++)
    recordenttext(string(guys[i].maxvisibledist), guys[i], level.debugteamcolors[guys[i].team], "Animscript");

  recordenttext(string(level.player.maxvisibledist), level.player, level.debugteamcolors["allies"], "Animscript");
}

debug_health() {
  guys = getaiarray();

  for(i = 0; i < guys.size; i++)
    recordenttext(string(guys[i].health), guys[i], level.debugteamcolors[guys[i].team], "Animscript");

  vehicles = getvehiclearray();

  for(i = 0; i < vehicles.size; i++)
    recordenttext(string(vehicles[i].health), vehicles[i], level.debugteamcolors[vehicles[i].vteam], "Animscript");

  recordenttext(string(level.player.health), level.player, level.debugteamcolors["allies"], "Animscript");
}

debug_engagedist() {
  guys = getaiarray();

  for(i = 0; i < guys.size; i++) {
    diststring = guys[i].engageminfalloffdist + " - " + guys[i].engagemindist + " - " + guys[i].engagemaxdist + " - " + guys[i].engagemaxfalloffdist;
    recordenttext(diststring, guys[i], level.debugteamcolors[guys[i].team], "Animscript");
  }

}

ai_puppeteer() {
  ai_puppeteer_create_hud();
  level.ai_puppet_highlighting = 0;
  player = get_players()[0];
  player thread ai_puppet_cursor_tracker();
  player thread ai_puppet_manager();
  player.ignoreme = 1;
  level waittill("kill ai puppeteer");
  player.ignoreme = 0;
  ai_puppet_release(1);

  if(isDefined(level.ai_puppet_target))
    level.ai_puppet_target delete();

  ai_puppeteer_destroy_hud();
}

ai_puppet_manager() {
  level endon("kill ai puppeteer");
  self endon("death");

  while(true) {
    if(isDefined(level.playercursor["position"]) && isDefined(level.ai_puppet) && isDefined(level.ai_puppet.debuglookatenabled) && level.ai_puppet.debuglookatenabled == 1)
      level.ai_puppet lookatpos(level.playercursor["position"]);

    if(self buttonpressed("BUTTON_RSTICK")) {
      if(isDefined(level.ai_puppet)) {
        if(isDefined(level.ai_puppet_target)) {
          if(isai(level.ai_puppet_target)) {
            self thread ai_puppeteer_highlight_ai(level.ai_puppet_target, (1, 0, 0));
            level.ai_puppet clearentitytarget();
            level.ai_puppet_target = undefined;
          } else {
            self thread ai_puppeteer_highlight_point(level.ai_puppet_target.origin, level.ai_puppet_target_normal, anglestoforward(self getplayerangles()), (1, 0, 0));
            level.ai_puppet clearentitytarget();
            level.ai_puppet_target delete();
          }
        } else {
          if(isDefined(level.playercursorai)) {
            if(level.playercursorai != level.ai_puppet) {
              level.ai_puppet setentitytarget(level.playercursorai);
              level.ai_puppet_target = level.playercursorai;
              level.ai_puppet getperfectinfo(level.ai_puppet_target);
              self thread ai_puppeteer_highlight_ai(level.playercursorai, (1, 0, 0));
            }
          } else {
            level.ai_puppet_target = spawn("script_origin", level.playercursor["position"]);
            level.ai_puppet_target_normal = level.playercursor["normal"];
            level.ai_puppet setentitytarget(level.ai_puppet_target);
            self thread ai_puppeteer_highlight_point(level.ai_puppet_target.origin, level.ai_puppet_target_normal, anglestoforward(self getplayerangles()), (1, 0, 0));
          }

          level.ai_puppet animscripts\weaponlist::refillclip();
        }
      }

      wait 0.2;
    } else if(self buttonpressed("BUTTON_A")) {
      if(isDefined(level.ai_puppet)) {
        if(isDefined(level.playercursorai) && level.playercursorai != level.ai_puppet) {
          level.ai_puppet setgoalentity(level.playercursorai);
          level.ai_puppet.goalradius = 64;
          self thread ai_puppeteer_highlight_ai(level.playercursorai, (0, 1, 0));
        } else if(isDefined(level.playercursornode)) {
          level.ai_puppet setgoalnode(level.playercursornode);
          level.ai_puppet.goalradius = 16;
          self thread ai_puppeteer_highlight_node(level.playercursornode);
        } else {
          if(isDefined(level.ai_puppet.scriptenemy))
            to_target = level.ai_puppet.scriptenemy.origin - level.ai_puppet.origin;
          else
            to_target = level.playercursor["position"] - level.ai_puppet.origin;

          angles = vectortoangles(to_target);
          level.ai_puppet setgoalpos(level.playercursor["position"], angles);
          level.ai_puppet.goalradius = 16;
          self thread ai_puppeteer_highlight_point(level.playercursor["position"], level.playercursor["normal"], anglestoforward(self getplayerangles()), (0, 1, 0));
        }
      }

      wait 0.2;
    } else if(self buttonpressed("BUTTON_X")) {
      if(isDefined(level.playercursorai)) {
        if(isDefined(level.ai_puppet) && level.playercursorai == level.ai_puppet)
          ai_puppet_release(1);
        else {
          if(isDefined(level.ai_puppet))
            ai_puppet_release(0);

          ai_puppet_set();
          self thread ai_puppeteer_highlight_ai(level.ai_puppet, (0, 1, 1));
        }
      }

      wait 0.2;
    } else if(self buttonpressed("BUTTON_Y")) {
      if(isDefined(level.ai_puppet)) {
        if(!isDefined(level.ai_puppet.debuglookatenabled))
          level.ai_puppet.debuglookatenabled = 0;

        if(level.ai_puppet.debuglookatenabled == 2) {
          println("IK LookAt DISABLED");

          if(isDefined(level.puppeteer_hud_lookat))
            level.puppeteer_hud_lookat settext("Y for lookat (OFF)");

          level.ai_puppet lookatpos();
          level.ai_puppet.debuglookatenabled = 0;
        } else {
          level.ai_puppet.debuglookatenabled++;

          if(level.ai_puppet.debuglookatenabled == 1) {
            if(isDefined(level.puppeteer_hud_lookat))
              level.puppeteer_hud_lookat settext("Y for lookat (CURSOR)");

            println("IK LookAt ENABLED");
          } else {
            if(isDefined(level.puppeteer_hud_lookat))
              level.puppeteer_hud_lookat settext("Y for lookat (FIXED)");

            println("IK LookAt ENABLED (Target frozen)");
          }
        }
      }

      wait 0.2;
    }

    if(isDefined(level.ai_puppet)) {
      ai_puppeteer_render_ai(level.ai_puppet, (0, 1, 1));

      if(isDefined(level.ai_puppet.scriptenemy) && !level.ai_puppet_highlighting) {
        if(isai(level.ai_puppet.scriptenemy))
          ai_puppeteer_render_ai(level.ai_puppet.scriptenemy, (1, 0, 0));
        else if(isDefined(level.ai_puppet_target))
          self thread ai_puppeteer_render_point(level.ai_puppet_target.origin, level.ai_puppet_target_normal, anglestoforward(self getplayerangles()), (1, 0, 0));
      }
    }

    wait 0.05;
  }

}

ai_puppet_set() {
  level.ai_puppet = level.playercursorai;
  level.ai_puppet.old_goalradius = level.ai_puppet.goalradius;
  level.ai_puppet stopanimscripted();
}

ai_puppet_release(restore) {
  if(isDefined(level.ai_puppet)) {
    if(restore) {
      level.ai_puppet.goalradius = level.ai_puppet.old_goalradius;
      level.ai_puppet clearentitytarget();
    }

    level.ai_puppet = undefined;
  }

}

ai_puppet_cursor_tracker() {
  level endon("kill ai puppeteer");
  self endon("death");

  while(true) {
    forward = anglestoforward(self getplayerangles());
    forward_vector = vectorscale(forward, 4000);
    level.playercursor = bullettrace(self geteye(), self geteye() + forward_vector, 1, self);
    level.playercursorai = undefined;
    level.playercursornode = undefined;
    cursorcolor = (0, 1, 1);
    hitent = level.playercursor["entity"];

    if(isDefined(hitent) && isai(hitent)) {
      cursorcolor = (1, 0, 0);

      if(isDefined(level.ai_puppet) && level.ai_puppet != hitent) {
        if(!level.ai_puppet_highlighting)
          ai_puppeteer_render_ai(hitent, cursorcolor);
      }

      level.playercursorai = hitent;
    } else if(isDefined(level.ai_puppet)) {
      nodes = getanynodearray(level.playercursor["position"], 24);

      if(nodes.size > 0) {
        node = nodes[0];

        if(node.type != "Path" && distancesquared(node.origin, level.playercursor["position"]) < 576) {
          if(!level.ai_puppet_highlighting)
            ai_puppeteer_render_node(node, (0, 1, 1));

          level.playercursornode = node;
        }
      }
    }

    if(!level.ai_puppet_highlighting)
      ai_puppeteer_render_point(level.playercursor["position"], level.playercursor["normal"], forward, cursorcolor);

    wait 0.05;
  }

}

ai_puppeteer_create_hud() {
  level.puppeteer_hud_select = newdebughudelem();
  level.puppeteer_hud_select.x = 0;
  level.puppeteer_hud_select.y = 180;
  level.puppeteer_hud_select.fontscale = 1.5;
  level.puppeteer_hud_select.alignx = "left";
  level.puppeteer_hud_select.horzalign = "left";
  level.puppeteer_hud_select.color = (0, 0, 1);
  level.puppeteer_hud_goto = newdebughudelem();
  level.puppeteer_hud_goto.x = 0;
  level.puppeteer_hud_goto.y = 200;
  level.puppeteer_hud_goto.fontscale = 1.5;
  level.puppeteer_hud_goto.alignx = "left";
  level.puppeteer_hud_goto.horzalign = "left";
  level.puppeteer_hud_goto.color = (0, 1, 0);
  level.puppeteer_hud_lookat = newdebughudelem();
  level.puppeteer_hud_lookat.x = 0;
  level.puppeteer_hud_lookat.y = 220;
  level.puppeteer_hud_lookat.fontscale = 1.5;
  level.puppeteer_hud_lookat.alignx = "left";
  level.puppeteer_hud_lookat.horzalign = "left";
  level.puppeteer_hud_lookat.color = (0, 1, 1);
  level.puppeteer_hud_shoot = newdebughudelem();
  level.puppeteer_hud_shoot.x = 0;
  level.puppeteer_hud_shoot.y = 240;
  level.puppeteer_hud_shoot.fontscale = 1.5;
  level.puppeteer_hud_shoot.alignx = "left";
  level.puppeteer_hud_shoot.horzalign = "left";
  level.puppeteer_hud_shoot.color = (1, 1, 1);
  level.puppeteer_hud_select settext("X for select");
  level.puppeteer_hud_goto settext("A for goto");
  level.puppeteer_hud_lookat settext("Y for lookat (OFF)");
  level.puppeteer_hud_shoot settext("R-STICK for shoot");
}

ai_puppeteer_destroy_hud() {
  if(isDefined(level.puppeteer_hud_select))
    level.puppeteer_hud_select destroy();

  if(isDefined(level.puppeteer_hud_lookat))
    level.puppeteer_hud_lookat destroy();

  if(isDefined(level.puppeteer_hud_goto))
    level.puppeteer_hud_goto destroy();

  if(isDefined(level.puppeteer_hud_shoot))
    level.puppeteer_hud_shoot destroy();
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
  box(node.origin, vectorscale((-1, -1, 0), 16.0), vectorscale((1, 1, 1), 16.0), node.angles[1], color, 1, 1);
  nodeforward = anglestoforward(node.angles);
  nodeforward = vectorscale(nodeforward, 8);
  line(node.origin, node.origin + nodeforward, color, 1, 1);
}

ai_puppeteer_render_ai(ai, color) {
  circle(ai.origin + (0, 0, 1), 15, color, 0, 1);
}

ai_puppeteer_highlight_point(point, normal, forward, color) {
  level endon("kill ai puppeteer");
  self endon("death");
  level.ai_puppet_highlighting = 1;
  timer = 0;

  while(timer < 0.7) {
    ai_puppeteer_render_point(point, normal, forward, color);
    timer = timer + 0.15;
    wait 0.15;
  }

  level.ai_puppet_highlighting = 0;
}

ai_puppeteer_highlight_node(node) {
  level endon("kill ai puppeteer");
  self endon("death");
  level.ai_puppet_highlighting = 1;
  timer = 0;

  while(timer < 0.7) {
    ai_puppeteer_render_node(node, (0, 1, 0));
    timer = timer + 0.15;
    wait 0.15;
  }

  level.ai_puppet_highlighting = 0;
}

ai_puppeteer_highlight_ai(ai, color) {
  level endon("kill ai puppeteer");
  self endon("death");
  level.ai_puppet_highlighting = 1;
  timer = 0;

  while(timer < 0.7 && isDefined(ai)) {
    ai_puppeteer_render_ai(ai, color);
    timer = timer + 0.15;
    wait 0.15;
  }

  level.ai_puppet_highlighting = 0;
}

debug_sphere(origin, radius, color, alpha, time) {
  if(!isDefined(time))
    time = 1000;

  if(!isDefined(color))
    color = (1, 1, 1);

  sides = int(10 * (1 + int(radius) % 100));
  sphere(origin, radius, color, alpha, 1, sides, time);
}