/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\zombies\_face_utility_zm.csc
*************************************************************/

#include clientscripts\mp\_utility;

get_face_callback() {
  self waittill("face", value);

  if(is_true(self.zombie_face))
    value = "zombie_" + value;

  return value;
}

setfaceroot(root) {
  if(!isDefined(level.facestates))
    level.facestates = [];

  if(!isDefined(level.facestates))
    level.facestates = [];

  level.facestates["face_root"] = root;
}

buildfacestate(face_state, looping, timer, priority, statetype, animlist) {
  if(!isDefined(level.facestates))
    level.facestates = [];

  if(!isDefined(level.facestates))
    level.facestates = [];

  level.facestates[face_state]["looping"] = looping;
  level.facestates[face_state]["timer"] = timer;
  level.facestates[face_state]["priority"] = priority;
  level.facestates[face_state]["statetype"] = statetype;
  level.facestates[face_state]["animation"] = [];
  level.facestates[face_state]["animation"] = animlist;
}

addanimtofacestate(face_state, animation) {
  assert(isDefined(level.facestates[face_state]));
  assert(isDefined(level.facestates[face_state]["animation"]));
  curr_size = level.facestates[face_state]["animation"].size;
  level.facestates[face_state]["animation"][curr_size] = animation;
}

waitforanypriorityreturn(prevstate) {
  level endon("demo_jump");
  self endon("entityshutdown");
  self endon("stop_facial_anims");
  previouspriority = -1;

  if(isDefined(level.facestates[prevstate]))
    previouspriority = level.facestates[prevstate]["priority"];

  while(true) {
    newstate = get_face_callback();

    if(isDefined(newstate) && isDefined(level.facestates[newstate]) && level.facestates[newstate]["priority"] > previouspriority) {
      break;
    }
  }

  return newstate;
}

waitforfaceeventrepeat(base_time) {
  level endon("demo_jump");
  self endon("entityshutdown");
  self endon("stop_face_anims");
  self endon("new_face_event");
  self endon("face_timer_expired");
  state = self.face_curr_event;

  while(true) {
    newstate = get_face_callback();

    if(newstate == state)
      self.face_timer = base_time;
  }
}

waitforfaceeventcomplete(localclientnum) {
  level endon("demo_jump");
  self endon("entityshutdown");
  self endon("stop_face_anims");
  self endon("new_face_event");

  if(getdvarint(#"_id_B5C61264") != 0)
    println("Trying to get animation for state " + self.face_curr_event + " # " + self.face_curr_event_idx);

  assert(isDefined(level.facestates[self.face_curr_event]["animation"][self.face_curr_event_idx]));
  self.face_timer = getanimlength(level.facestates[self.face_curr_event]["animation"][self.face_curr_event_idx]);

  if(level.facestates[self.face_curr_event]["looping"])
    self thread waitforfaceeventrepeat(self.face_timer);

  if(getdvarint(#"_id_B5C61264") != 0)
    println("faceTime is " + self.face_timer + "\\n");

  if(!isDefined(self)) {
    return;
  }
  waitrealtime(self.face_timer);
  self notify("face_timer_expired");

  if(getdvarint(#"_id_B5C61264") != 0)
    println("face_timer_expired");

  self.face_curr_event = undefined;
  self.face_curr_event_idx = undefined;

  if(getdvarint(#"_id_B5C61264") != 0)
    println("waiting on dobj");

  self waittill_dobj(localclientnum);

  if(!isDefined(self)) {
    return;
  }
  if(getdvarint(#"_id_B5C61264") != 0)
    println("setAnimKnob Back To base state " + self.face_curr_base);

  if(isDefined(level.facestates[self.face_curr_base]["animation"][self.face_curr_base_idx]))
    self setanimknob(level.facestates[self.face_curr_base]["animation"][self.face_curr_base_idx], 1.0, 0.1, 1.0);

  self notify("face", "face_advance");
}

processfaceevents(localclientnum) {
  level endon("demo_jump");
  self endon("entityshutdown");
  state = "face_alert";
  self.face_curr_base = "face_alert";

  if(is_true(self.zombie_face)) {
    self.face_curr_base = "zombie_" + self.face_curr_base;
    state = "zombie_" + state;
  }

  numanims = level.facestates[state]["animation"].size;
  self.face_curr_base_idx = randomint(numanims);

  if(getdvarint(#"_id_B5C61264") != 0)
    println("setAnimKnobProcessFaceEvents");

  self waittill_dobj(localclientnum);

  if(!isDefined(self)) {
    return;
  }
  self setanimknob(level.facestates[self.face_curr_base]["animation"][self.face_curr_base_idx], 1.0, 0.0, 1.0);

  if(isDefined(self.face_disable) && self.face_disable)
    state = "face_disable";
  else if(isDefined(self.face_death) && self.face_death)
    state = "face_death";

  if(!isDefined(self)) {
    return;
  }
  self.face_state = state;

  self thread showstate();

  self thread watchfor_death();

  while(true) {
    if(getdvarint(#"_id_B5C61264") != 0) {
      if(!isDefined(state))
        println("state undefined\\n");

      if(!isDefined(level.facestates))
        println("level.faceStates undefined\\n");

      if(!isDefined(level.facestates))
        println("level.faceStates undefined\\n");

      if(!isDefined(level.facestates[state]))
        println("level.faceStates[state] undefined\\n");

      if(!isDefined(level.facestates[state])) {
        facestatesarray = getarraykeys(level.facestates);
        println(state + " undefined\\n");

        for(i = 0; i < facestatesarray.size; i++) {
          println(i + ":");
          println(facestatesarray[i] + "\\n");
        }
      }
    }

    if(state == "face_disable")
      numanims = 0;
    else
      numanims = level.facestates[state]["animation"].size;

    if(getdvarint(#"_id_B5C61264") != 0)
      println("Found " + numanims + " anims for state " + state);

    if(isDefined(self.face_disable) && self.face_disable == 1) {
      if(getdvarint(#"_id_B5C61264") != 0)
        println("Disabling face anims");

      setfacestate("face_disabled");
      self clearanim(level.facestates["face_root"], 0);
      self notify("stop_face_anims");

      while(self.face_disable)
        wait 0.05;
    }

    if(getdvarint(#"_id_B5C61264") != 0) {
      if(!isDefined(state))
        println("state undefined\\n");

      if(!isDefined(level.facestates))
        println("level.faceStates undefined\\n");

      if(!isDefined(level.facestates))
        println("level.faceStates undefined\\n");

      if(!isDefined(level.facestates[state]))
        println("level.faceStates[state] undefined\\n");

      if(!isDefined(level.facestates[state])) {
        facestatesarray = getarraykeys(level.facestates);
        println(state + " undefined\\n");

        for(i = 0; i < facestatesarray.size; i++) {
          println(i + ":");
          println(facestatesarray[i] + "\\n");
        }
      }
    }

    setfacestate(state);

    if(level.facestates[state]["statetype"] == "exitstate") {
      if(getdvarint(#"_id_B5C61264") != 0)
        println("Exitstate found, returning, anim tree:" + level.face_anim_tree);

      self waittill_dobj(localclientnum);

      if(!isDefined(self)) {
        return;
      }
      if(getdvarint(#"_id_B5C61264") != 0)
        println("setAnimKnob286");

      self setanimknob(level.facestates[state]["animation"][randomint(numanims)], 1.0, 0.1, 1.0);
      self notify("stop_face_anims");
      self.curr_face_base = undefined;
      self.curr_face_event = undefined;
      return;
    } else if(level.facestates[state]["statetype"] == "basestate") {
      if(!isDefined(self.face_curr_base) || self.face_curr_base != state) {
        self.face_curr_base = state;
        self.face_curr_base_idx = randomint(numanims);

        if(getdvarint(#"_id_B5C61264") != 0)
          println("New base face anim state " + self.face_curr_base + " anim # " + self.face_curr_base_idx);

        if(!isDefined(self.face_curr_event)) {
          if(getdvarint(#"_id_B5C61264") != 0)
            println("trying to play animation for state " + self.face_curr_base + " w/ index " + self.face_curr_base_idx);

          self waittill_dobj(localclientnum);

          if(!isDefined(self)) {
            return;
          }
          self setanimknob(level.facestates[self.face_curr_base]["animation"][self.face_curr_base_idx], 1.0, 0.1, 1.0);
        }
      }
    } else if(level.facestates[state]["statetype"] == "eventstate") {
      if(!isDefined(self.face_curr_event) || !isDefined(level.facestates[self.face_curr_event]) || !level.facestates[self.face_curr_event]["looping"] || self.face_curr_event != state) {
        self.face_curr_event = state;
        self.face_curr_event_idx = randomint(numanims);

        if(getdvarint(#"_id_B5C61264") != 0)
          println("New face anim event " + self.face_curr_event + " anim # " + self.face_curr_event_idx);

        self waittill_dobj(localclientnum);

        if(!isDefined(self)) {
          return;
        }
        self setflaggedanimknob("face_event", level.facestates[self.face_curr_event]["animation"][self.face_curr_event_idx], 1.0, 0.1, 1.0);
        self thread waitforfaceeventcomplete(localclientnum);
      }
    } else if(level.facestates[state]["statetype"] == "nullstate") {
      if(isDefined(self.face_curr_event) && isDefined(level.facestates[self.face_curr_event]))
        self setanimknob(level.facestates[self.face_curr_event]["animation"][self.face_curr_event_idx], 1.0, 0.1, 1.0);
      else if(isDefined(self.face_curr_base) && isDefined(level.facestates[self.face_curr_base]["animation"][self.face_curr_base_idx]))
        self setanimknob(level.facestates[self.face_curr_base]["animation"][self.face_curr_base_idx], 1.0, 0.1, 1.0);
    }

    if(isDefined(self.face_curr_event))
      state = self waitforanypriorityreturn(self.face_curr_event);
    else
      state = self waitforanypriorityreturn(self.face_curr_base);
  }
}

showstate(state) {
  level endon("demo_jump");
  self endon("entityshutdown");

  while(true) {
    if(getdvarint(#"_id_B5C61264") != 0) {
      if(isDefined(self.face_state) && isDefined(self.origin)) {
        entnum = self getentitynumber();

        if(!isDefined(entnum))
          entnum = "?";

        if(isDefined(self.face_disable) && self.face_disable)
          disablechar = "-";
        else
          disablechar = "+";

        if(isDefined(self.face_death) && self.face_death)
          deathchar = "D";
        else
          deathchar = "A";

        print3d(self.origin + vectorscale((0, 0, 1), 72.0), disablechar + deathchar + "[" + entnum + "]" + self.face_state, (1, 1, 1), 1, 0.25);
      }
    }

    wait 0.01;
  }

}

setfacestate(state) {
  if(state == "face_advance" || state == "zombie_face_advance") {
    if(isDefined(self.face_curr_event)) {
      if(is_true(self.zombie_face) && !issubstr(self.face_curr_event, "zombie_"))
        self.face_curr_event = "zombie_" + self.face_curr_event;
      else if(!is_true(self.zombie_face) && issubstr(self.face_curr_event, "zombie_")) {
        self.face_curr_base = "face_alert";
        self.face_state = self.face_curr_base;
        return;
      }

      self.face_state = self.face_curr_event;
    } else if(isDefined(self.face_curr_base)) {
      if(is_true(self.zombie_face) && !issubstr(self.face_curr_base, "zombie_"))
        self.face_curr_base = "zombie_" + self.face_curr_base;
      else if(!is_true(self.zombie_face) && issubstr(self.face_curr_base, "zombie_"))
        self.face_curr_base = "face_alert";

      self.face_state = self.face_curr_base;
    }

    return;
  }

  self.face_state = state;
}

watchfor_death() {
  level endon("demo_jump");
  self endon("entityshutdown");

  if(!isDefined(self.face_death)) {
    self waittillmatch("face", "face_death");
    self.face_death = 1;
  }
}