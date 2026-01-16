/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_music.csc
**************************************/

#include clientscripts\_utility;

music_init() {
  level.activemusicstate = "";
  level.nextmusicstate = "";
  level.musicstates = [];
  level.loopent = spawnfakeent(0);
  level.stingerent = spawnfakeent(0);
  thread updatemusic();
  thread musicsavewait();
  registersystem("musicCmd", ::musiccmdhandler);

  thread change_music_state_from_dvar();
}

musicsavewait() {
  for(;;) {
    level waittill("save_restore");

    if(level.nextmusicstate == "")
      level.nextmusicstate = level.activemusicstate;

    level.activemusicstate = "";

    println("resetting music state to " + level.nextmusicstate);

    states = getarraykeys(level.musicstates);

    for(i = 0; i < states.size; i++)
      stoploopsound(0, level.loopent, 0);

    thread updatemusic();
  }
}

change_music_state_from_dvar() {
  level endon("save_restore");
  print_msg = 0;

  while(true) {
    current_music_state = level.activemusicstate;
    next_music_state = level.nextmusicstate;
    new_music_state = getdvar(#"_id_39C93D95");

    if(new_music_state != "" && new_music_state != current_music_state && new_music_state != next_music_state) {
      if(!isDefined(level.musicstates[new_music_state])) {
        if(!print_msg)
          println("new music state entered '" + new_music_state + "' is not valid");

        print_msg = 1;
      } else {
        println("^5current music state: " + current_music_state + " new music state: " + new_music_state);
        musiccmdhandler(0, new_music_state, current_music_state);
        print_msg = 0;
      }
    }

    wait 1;
  }

}

musiccmdhandler(clientnum, state, oldstate) {
  if(clientnum != 0) {
    return;
  }
  level.nextmusicstate = state;

  println("music debug: got state '" + state + "'");

  level notify("new_music");
}

updatemusic() {
  level endon("save_restore");

  while(true) {
    if(level.activemusicstate == level.nextmusicstate)
      level waittill("new_music");

    if(level.activemusicstate == level.nextmusicstate) {
      continue;
    }
    active = level.activemusicstate;
    next = level.nextmusicstate;

    if(next != "" && !isDefined(level.musicstates[next])) {
      println("unknown music state '" + next + "'");

      wait 0.1;
      continue;
    }

    level.activemusicstate = next;

    if(active != "")
      thread transitionout(active, next);

    if(level.activemusicstate != level.nextmusicstate) {
      continue;
    }
    if(next != "")
      thread transitionin(active, next);
  }
}

fadeoutandstopsound(id, time) {
  rate = 0;

  if(isDefined(time) && time != 0)
    rate = 1.0 / time;

  setsoundvolumerate(id, rate);
  setsoundvolume(id, 0.0);
  wait(time);
  stopsound(id);
}

waitwithstatechangecheck(waittime) {
  endwait = getrealtime() + waittime * 1000;

  while(getrealtime() < endwait) {
    waitrealtime(0.01);

    if(level.activemusicstate != level.nextmusicstate)
      return false;
  }

  if(level.activemusicstate != level.nextmusicstate)
    return false;

  return true;
}

transitionout(previous, next) {
  if(previous == "") {
    return;
  }
  println("music transition out state " + next);

  if(!isDefined(level.musicstates[previous])) {
    println("unknown music state '" + previous + "'");
    wait 0.1;

    return;
  }

  ent = level.musicstates[previous].aliasent;
  loopalias = level.musicstates[previous].loopalias;
  oneshotalias = level.musicstates[previous].oneshotalias;
  fadeoutloop = level.musicstates[previous].fadeoutloop;
  waittilldone = level.musicstates[previous].waittilldone;
  waittilldelay = level.musicstates[previous].waittilldelay;
  stinger = level.musicstates[previous].stinger;
  id = level.musicstates[previous].id;
  startdelay = level.musicstates[previous].startdelay;
  loopdelay = level.musicstates[previous].loopdelay;
  fadeout = level.musicstates[previous].fadeout;
  forcestinger = level.musicstates[previous].forcestinger;
  level.musicstates[previous].stingerid = -1;
  samestate = 1;

  if(next == "") {
    nextloopalias = "";
    nextoneshotalias = "";
  } else {
    nextloopalias = level.musicstates[next].loopalias;
    nextoneshotalias = level.musicstates[next].oneshotalias;
  }

  stingerid = -1;
  loopmatches = loopalias == nextloopalias;
  haveoneshot = nextoneshotalias != "";

  if(stinger != "" && (!loopmatches || haveoneshot || forcestinger)) {
    stingerid = playsound(0, stinger, (0, 0, 0));
    level.musicstates[previous].stingerid = stingerid;
  }

  if(loopalias != "") {
    if(loopalias != nextloopalias || nextoneshotalias != "") {
      stoploopsound(0, level.loopent, fadeoutloop);

      if(waittilldone)
        samestate = waitwithstatechangecheck(fadeoutloop);
    } else {
    }
  }

  if(id != 0 && samestate) {
    if(waittilldone) {
      while(soundplaying(id)) {
        wait 0.01;

        if(level.activemusicstate != level.nextmusicstate) {
          samestate = 0;
          break;
        }
      }
    } else if(waittilldelay) {
      if(soundplaying(id)) {
        while(getrealtime() < level.musicstates[previous].loopdelayendtime - fadeout * 1000 && soundplaying(id) && getplaybacktime(id) < loopdelay * 1000 - fadeout * 1000) {
          wait 0.01;

          if(level.activemusicstate != level.nextmusicstate) {
            samestate = 0;
            break;
          }
        }

        if(!samestate)
          fadeout = 0.01;

        thread fadeoutandstopsound(id, fadeout);
      }
    } else
      thread fadeoutandstopsound(id, fadeout);
  }
}

transitionin(previous, next) {
  ent = level.musicstates[next].aliasent;
  loopalias = level.musicstates[next].loopalias;
  oneshotalias = level.musicstates[next].oneshotalias;
  fadein = level.musicstates[next].fadein;
  fadeinloop = level.musicstates[next].fadeinloop;
  loop = level.musicstates[next].loop;
  startdelay = 0;
  waittillstingerdone = 0;
  stingerid = -1;

  if(isDefined(previous) && previous != "") {
    startdelay = level.musicstates[previous].startdelay;
    waittillstingerdone = level.musicstates[previous].waittillstingerdone;
    stingerid = level.musicstates[previous].stingerid;
  }

  println("music transition in state " + next);

  if(previous == "") {
    oldloopalias = "";
    oldoneshotalias = "";
    oldid = -1;
  } else {
    oldloopalias = level.musicstates[previous].loopalias;
    oldoneshotalias = level.musicstates[previous].oneshotalias;
    oldid = level.musicstates[previous].loopid;
  }

  level.musicstates[next].loopdelayendtime = getrealtime() + level.musicstates[next].loopdelay * 1000;
  samestate = 1;

  if(startdelay > 0 && stingerid >= 0) {
    while(startdelay > 0 && soundplaying(stingerid) && getplaybacktime(stingerid) < startdelay * 1000 && level.activemusicstate == level.nextmusicstate)
      wait 0.01;

    samestate = level.activemusicstate == level.nextmusicstate;
  }

  if(waittillstingerdone && level.activemusicstate == level.nextmusicstate && stingerid >= 0) {
    while(soundplaying(stingerid) && level.activemusicstate == level.nextmusicstate)
      wait 0.01;

    level.musicstates[previous].stingerid = -1;
    samestate = level.activemusicstate == level.nextmusicstate;
  }

  if(oneshotalias != "" && samestate) {
    level.musicstates[next].id = playsound(0, oneshotalias, (0, 0, 0), 1.0, fadein);

    if(level.musicstates[next].loopdelay == 0) {
      if(loopalias != "") {
        while(soundplaying(level.musicstates[next].id)) {
          length = getknownlength(level.musicstates[next].id);
          time = 0;

          if(length != 0) {
            time = getplaybacktime(level.musicstates[next].id);

            if(length - time <= fadein * 1000) {
              break;
            }
          }

          wait 0.01;
        }
      }
    } else
      samestate = waitwithstatechangecheck(level.musicstates[next].loopdelay);
  }

  if(oldloopalias == loopalias && oldid != -1 && oneshotalias == "") {
    level.musicstates[next].loopid = level.musicstates[previous].loopid;
    level.musicstates[previous].loopid = -1;
  } else if(loopalias != "" && samestate)
    level.musicstates[next].loopid = playloopsound(0, level.loopent, loopalias, fadeinloop);
}

declaremusicstate(name) {
  if(isDefined(level.musicstates[name])) {
    return;
  }
  level.musicdeclarename = name;
  level.musicstates[name] = spawnstruct();
  level.musicstates[name].aliasent = spawnfakeent(0);
  level.musicstates[name].loopalias = "";
  level.musicstates[name].oneshotalias = "";
  level.musicstates[name].fadein = 0;
  level.musicstates[name].fadeinloop = 0;
  level.musicstates[name].fadeout = 0;
  level.musicstates[name].fadeoutloop = 0;
  level.musicstates[name].id = -1;
  level.musicstates[name].loopid = -1;
  level.musicstates[name].waittilldone = 0;
  level.musicstates[name].stinger = "";
  level.musicstates[name].waittillstingerdone = 0;
  level.musicstates[name].waittilldelay = 0;
  level.musicstates[name].startdelay = 0;
  level.musicstates[name].forcestinger = 0;
  level.musicstates[name].loopdelay = 0;
}

musicwaittilldone() {
  assert(isDefined(level.musicdeclarename));
  name = level.musicdeclarename;
  level.musicstates[name].waittilldone = 1;
}

musicwaittilldelay() {
  assert(isDefined(level.musicdeclarename));
  name = level.musicdeclarename;
  level.musicstates[name].waittilldelay = 1;
}

musicwaittillstingerdone() {
  assert(isDefined(level.musicdeclarename));
  name = level.musicdeclarename;
  level.musicstates[name].waittillstingerdone = 1;
}

musicstinger(stinger, delay, force) {
  assert(isDefined(level.musicdeclarename));

  if(!isDefined(delay))
    delay = 0;

  name = level.musicdeclarename;
  level.musicstates[name].stinger = stinger;
  level.musicstates[name].startdelay = delay;

  if(isDefined(force))
    level.musicstates[name].forcestinger = force;
}

_musicalias(alias, fadein, fadeout, loopdelay) {
  assert(isDefined(level.musicdeclarename));
  name = level.musicdeclarename;
  level.musicstates[name].oneshotalias = alias;
  level.musicstates[name].fadein = fadein;
  level.musicstates[name].fadeout = fadeout;
  assert(level.musicstates[name].loopdelay == 0);

  if(isDefined(loopdelay)) {
    assert(loopdelay > fadeout);
    level.musicstates[name].loopdelay = loopdelay;
  } else
    level.musicstates[name].loopdelay = 0;

  if(!isDefined(level.musicstates[name].fadein))
    level.musicstates[name].fadein = 0;

  if(!isDefined(level.musicstates[name].fadeout))
    level.musicstates[name].fadeout = 0;
}

_musicaliasloop(alias, fadein, fadeout) {
  assert(isDefined(level.musicdeclarename));
  name = level.musicdeclarename;
  level.musicstates[name].loopalias = alias;
  level.musicstates[name].fadeinloop = fadein;
  level.musicstates[name].fadeoutloop = fadeout;

  if(!isDefined(level.musicstates[name].fadeinloop))
    level.musicstates[name].fadeinloop = 0;

  if(!isDefined(level.musicstates[name].fadeoutloop))
    level.musicstates[name].fadeoutloop = 0;
}

musicaliasloop(alias, fadein, fadeout) {
  _musicaliasloop(alias, fadein, fadeout);
}

musicalias(alias, fadeout, fadein, loopdelay) {
  _musicalias(alias, fadein, fadeout, loopdelay);
}