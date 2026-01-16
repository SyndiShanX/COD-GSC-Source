/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_face_utility.csc
*******************************************/

setfaceroot(root) {
  if(!isDefined(level.facestates))
    level.facestates = [];

  if(!isDefined(level.facestates[self.face_anim_tree]))
    level.facestates[self.face_anim_tree] = [];

  level.facestates[self.face_anim_tree]["face_root"] = root;
}

buildfacestate(face_state, looping, timer, priority, statetype, animation_list) {
  if(!isDefined(animation_list))
    animation_list = array(undefined);

  level.facestates[self.face_anim_tree][face_state]["looping"] = looping;
  level.facestates[self.face_anim_tree][face_state]["timer"] = timer;
  level.facestates[self.face_anim_tree][face_state]["priority"] = priority;
  level.facestates[self.face_anim_tree][face_state]["statetype"] = statetype;
  level.facestates[self.face_anim_tree][face_state]["animation"] = animation_list;
}

addanimtofacestate(face_state, animation) {
  assert(isDefined(level.facestates[self.face_anim_tree][face_state]));
  assert(isDefined(level.facestates[self.face_anim_tree][face_state]["animation"]));
  curr_size = level.facestates[self.face_anim_tree][face_state]["animation"].size;
  level.facestates[self.face_anim_tree][face_state]["animation"][curr_size] = animation;
}

ishigherpriority(new_state, old_state) {
  if(new_state == old_state && level.facestates[self.face_anim_tree][old_state]["looping"])
    return false;

  if(level.facestates[self.face_anim_tree][new_state]["priority"] >= level.facestates[self.face_anim_tree][old_state]["priority"]) {
    if(getdvarint(#"_id_B5C61264") != 0)
      println("FaceState " + new_state + " is higher priority than " + old_state + " for entity " + self getentitynumber());

    return true;
  }

  if(getdvarint(#"_id_B5C61264") != 0)
    println("FaceState " + new_state + " is not higher priority than " + old_state + " for entity " + self getentitynumber());

  return false;
}

faceframeendnotify() {
  self endon("entityshutdown");
  self endon("stop_facial_anims");
  waittillframeend;
  self notify("face", "frameend");
}

waitforanypriorityreturn(prevstate) {
  self endon("entityshutdown");
  self endon("stop_facial_anims");

  if(getdvarint(#"_id_B5C61264") != 0)
    println("Waiting for priority return for " + prevstate + " for entity " + self getentitynumber());

  while(true) {
    self waittill("face", newstate);

    if(ishigherpriority(newstate, prevstate)) {
      break;
    }
  }

  self thread faceframeendnotify();

  while(true) {
    self waittill("face", tempstate);

    if(tempstate == "frameend") {
      break;
    }

    if(ishigherpriority(tempstate, newstate))
      newstate = tempstate;
  }

  return newstate;
}

waitforfaceeventrepeat(base_time) {
  self endon("entityshutdown");
  self endon("stop_face_anims");
  self endon("new_face_event");
  self endon("face_timer_expired");
  state = self.face_curr_event;

  while(true) {
    self waittill("face", newstate);

    if(newstate == state)
      self.face_timer = base_time;
  }
}

waitforfaceeventcomplete() {
  self notify("new_face_event");
  self endon("entityshutdown");
  self endon("stop_face_anims");
  self endon("new_face_event");
  currevent = self.face_curr_event;
  curridx = self.face_curr_event_idx;

  if(getdvarint(#"_id_B5C61264") != 0)
    println("Trying to get animation for state " + currevent + " # " + curridx + " for entity " + self getentitynumber());

  assert(isDefined(level.facestates[self.face_anim_tree][self.face_curr_event]["animation"][self.face_curr_event_idx]));

  if(isDefined(level.facestates[self.face_anim_tree][self.face_curr_event]["timer"]) && level.facestates[self.face_anim_tree][self.face_curr_event]["timer"] > 0)
    self.face_timer = level.facestates[self.face_anim_tree][self.face_curr_event]["timer"];
  else
    self.face_timer = getanimlength(level.facestates[self.face_anim_tree][self.face_curr_event]["animation"][self.face_curr_event_idx]);

  base_time = self.face_timer;

  if(level.facestates[self.face_anim_tree][self.face_curr_event]["looping"])
    self thread waitforfaceeventrepeat(self.face_timer);

  wait(self.face_timer);
  self notify("face_timer_expired");

  if(getdvarint(#"_id_B5C61264") != 0)
    println("Timing out face state " + currevent + " # " + curridx + " for entity " + self getentitynumber() + " after " + base_time);

  self.face_curr_event = undefined;
  self.face_curr_event_idx = undefined;
  self setanimknob(level.facestates[self.face_anim_tree][self.face_curr_base]["animation"][self.face_curr_base_idx], 1.0, 0.1, 1.0);
  self notify("face", "face_advance");
}

shouldplayfaceevent(player, face_state) {
  if(level.facestates[self.face_anim_tree][face_state]["statetype"] == "exitstate")
    return true;

  if(isDefined(player) && distancesquared(self.origin, player.origin) < 40000.0 && vectordot(anglestoforward(player.angles), vectornormalize(self.origin - player.origin)) >= cos(35))
    return true;

  return false;
}

processfaceevents(localclientnum) {
  self endon("entityshutdown");
  state = "face_alert";
  self.face_curr_base = "face_alert";
  numanims = level.facestates[self.face_anim_tree][state]["animation"].size;
  self.face_curr_base_idx = randomint(numanims);

  if(getdvarint(#"_id_B5C61264") != 0) {
    println("Starting entity " + self getentitynumber() + " in state face_alert");
    println("Found " + numanims + " anims for state face_alert for entity " + self getentitynumber());
    println("Selected anim " + self.face_curr_base_idx + " for entity " + self getentitynumber());
  }

  self setanimknob(level.facestates[self.face_anim_tree][self.face_curr_base]["animation"][self.face_curr_base_idx], 1.0, 0.0, 1.0);

  if(isDefined(self.face_death) && self.face_death)
    state = "face_death";

  self.face_state = state;

  self thread showstate();

  self thread watchfor_death();

  while(true) {
    if(getdvarint(#"_id_B5C61264") != 0) {
      if(!isDefined(level.facestates))
        println("No face state array!\\n");
      else if(!isDefined(self.face_anim_tree))
        println("No face anim tree for entity " + self getentitynumber());
      else if(!isDefined(state))
        println("No face state for entity " + self getentitynumber());
      else if(!isDefined(level.facestates[self.face_anim_tree]))
        println("No face state array for anim tree " + self.face_anim_tree + " used by entity " + self getentitynumber());
      else if(!isDefined(level.facestates[self.face_anim_tree][state]))
        println("No face state array entry for state " + state + " in anim tree " + self.face_anim_tree + " for entity " + self getentitynumber());
    }

    if(getdvarint(#"_id_B5C61264") != 0)
      println("Found " + numanims + " anims for state " + state + " for entity " + self getentitynumber());

    if(isDefined(self.face_disable) && self.face_disable) {
      if(getdvarint(#"_id_B5C61264") != 0)
        println("Disabling face anims for entity " + self getentitynumber());

      setfacestate("face_disabled");
      self clearanim(level.facestates[self.face_anim_tree]["face_root"], 0);
      self notify("stop_face_anims");
      self.face_curr_event = undefined;
      self.face_curr_event_idx = undefined;

      while(self.face_disable)
        wait 0.05;
    }

    player = getlocalplayers()[0];

    if(shouldplayfaceevent(player, state)) {
      numanims = level.facestates[self.face_anim_tree][state]["animation"].size;
      setfacestate(state);

      switch (level.facestates[self.face_anim_tree][state]["statetype"]) {
        case "nullstate":
          if(isDefined(self.face_curr_event))
            self setanimknob(level.facestates[self.face_anim_tree][self.face_curr_event]["animation"][self.face_curr_event_idx], 1.0, 0.1, 1.0);
          else if(isDefined(self.face_curr_base))
            self setanimknob(level.facestates[self.face_anim_tree][self.face_curr_base]["animation"][self.face_curr_base_idx], 1.0, 0.1, 1.0);

          break;
        case "exitstate":

          if(getdvarint(#"_id_B5C61264") != 0)
            println("Exitstate found, returning for entity " + self getentitynumber());

          self setanimknob(level.facestates[self.face_anim_tree][state]["animation"][randomint(numanims)], 1.0, 0.1, 1.0);
          self notify("stop_face_anims");
          self.face_curr_event = undefined;
          self.face_curr_event_idx = undefined;
          return;
        case "basestate":
          if(!isDefined(self.face_curr_base) || self.face_curr_base != state) {
            self.face_curr_base = state;
            self.face_curr_base_idx = randomint(numanims);

            if(getdvarint(#"_id_B5C61264") != 0)
              println("New base face anim state " + self.face_curr_base + " anim # " + self.face_curr_base_idx + "for entity " + self getentitynumber());

            if(!isDefined(self.face_curr_event)) {
              if(getdvarint(#"_id_B5C61264") != 0)
                println("trying to play animation for state " + self.face_curr_base + " w/ index " + self.face_curr_base_idx + " for entity " + self getentitynumber());

              self setanimknob(level.facestates[self.face_anim_tree][self.face_curr_base]["animation"][self.face_curr_base_idx], 1.0, 0.1, 1.0);
            }
          }

          break;
        case "eventstate":
          if(!isDefined(self.face_curr_event) || !level.facestates[self.face_anim_tree][self.face_curr_event]["looping"] || self.face_curr_event != state) {
            self.face_curr_event = state;
            self.face_curr_event_idx = randomint(numanims);

            if(getdvarint(#"_id_B5C61264") != 0)
              println("New face anim event " + self.face_curr_event + " anim # " + self.face_curr_event_idx + " for entity " + self getentitynumber());

            self setflaggedanimknob("face_event", level.facestates[self.face_anim_tree][self.face_curr_event]["animation"][self.face_curr_event_idx], 1.0, 0.1, 1.0);
            self thread waitforfaceeventcomplete();
          }

          break;
      }
    }

    if(isDefined(self.face_curr_event))
      state = self waitforanypriorityreturn(self.face_curr_event);
    else
      state = self waitforanypriorityreturn(self.face_curr_base);
  }
}

showstate(state) {
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

    wait 0.01667;
  }

}

setfacestate(state) {
  if(state == "face_advance") {
    if(isDefined(self.face_curr_event))
      self.face_state = self.face_curr_event;
    else if(isDefined(self.face_curr_base))
      self.face_state = self.face_curr_base;

    return;
  }

  self.face_state = state;
}

watchfor_death() {
  self endon("entityshutdown");

  if(!isDefined(self.face_death)) {
    self waittillmatch("face", "face_death");
    self.face_death = 1;
  }
}