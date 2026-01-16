/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\face.gsc
********************************/

initcharacterface() {
  if(!anim.usefacialanims) {
    return;
  }
  if(!isdefined(self.a.currentdialogimportance)) {
    self.a.currentdialogimportance = 0;
    self.a.idleface = anim.alertface;
    self.facewaiting = [];
    self.facelastnotifynum = 0;
  }
}

saygenericdialogue(var_0) {
  var_1 = undefined;

  switch (self.voice) {
    case "xslice":
    case "pmc":
    case "czech":
    case "french":
    case "taskforce":
    case "seal":
    case "american":
    case "delta":
      var_2 = "friendly";
      var_3 = anim.numfriendlyvoices;
      break;
    default:
      var_2 = "enemy";
      var_3 = anim.numenemyvoices;
  }

  var_1 = 1 + self getentitynumber() % var_3;
  var_2 = var_2 + "_" + var_1;
  var_4 = undefined;

  switch (var_0) {
    case "meleecharge":
    case "meleeattack":
      var_5 = 0.5;
      break;
    case "flashbang":
      var_5 = 0.7;
      break;
    case "pain":
      var_5 = 0.9;
      break;
    case "pain_small":
      var_5 = 0.9;
      break;
    case "melee_death":
    case "dogdeathlongplr":
    case "dogdeathshortplr":
    case "dogdeathlong":
    case "dogdeathshort":
    case "death":
      var_5 = 1.0;
      break;
    default:
      var_5 = 0.3;
      break;
  }

  var_6 = undefined;

  if(isdefined(self.generic_voice_override)) {
    var_6 = self.generic_voice_override + "_" + var_0 + "_" + var_2;

    if(!soundexists(var_6))
      var_6 = "generic_" + var_0 + "_" + var_2;
  } else
    var_6 = "generic_" + var_0 + "_" + var_2;

  thread playfacethread(var_4, var_6, var_5);
}

setidlefacedelayed(var_0) {
  animscripts\battlechatter::playbattlechatter();
  self.a.idleface = var_0;
}

setidleface(var_0) {
  if(!anim.usefacialanims) {
    return;
  }
  animscripts\battlechatter::playbattlechatter();
  self.a.idleface = var_0;
  playidleface();
}

sayspecificdialogue(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread playfacethread(var_0, var_1, var_2, var_3, var_4, var_5);
}

chooseanimfromset(var_0) {
  return;
}

playidleface() {
  return;
}

playfacethread(var_0, var_1, var_2, var_3, var_4, var_5) {
  self.a.facialanimdone = 1;
  self.a.facialsounddone = 1;

  if(isdefined(var_3)) {
    if(isdefined(var_1)) {
      if(!soundexists(var_1)) {
        wait 0;
        self notify(var_3);
      }

      self playsoundatviewheight(var_1, "animscript facesound" + var_3, 1);
      thread waitforfacesound(var_3);
    }
  } else
    self playsoundatviewheight(var_1);

  if(!anim.usefacialanims) {
    return;
  }
  initcharacterface();

  if(!isdefined(var_0) && !isdefined(var_1)) {
    if(isdefined(var_3)) {
      wait 0;
      self.faceresult = "failed";
      self notify(var_3);
    }
  } else {
    self endon("death");

    if(isstring(var_2)) {
      switch (var_2) {
        case "any":
          var_2 = 0.1;
          break;
        case "pain":
          var_2 = 0.9;
          break;
        case "death":
          var_2 = 1.0;
          break;
      }
    }

    if(var_2 <= self.a.currentdialogimportance && (isdefined(var_4) && var_4 == "wait")) {
      var_6 = self.facewaiting.size;
      var_7 = self.facelastnotifynum + 1;
      self.facewaiting[var_6]["facialanim"] = var_0;
      self.facewaiting[var_6]["soundAlias"] = var_1;
      self.facewaiting[var_6]["importance"] = var_2;
      self.facewaiting[var_6]["notifyString"] = var_3;
      self.facewaiting[var_6]["waitOrNot"] = var_4;
      self.facewaiting[var_6]["timeToWait"] = var_5;
      self.facewaiting[var_6]["notifyNum"] = var_7;
      thread playface_waitfornotify("animscript face stop waiting " + self.facewaiting[var_6]["notifyNum"], "Face done waiting", "Face done waiting");

      if(isdefined(var_5))
        thread playface_waitfortime(var_5, "Face done waiting", "Face done waiting");

      self waittill("Face done waiting");
      var_6 = undefined;

      for (var_8 = 0; var_8 < self.facewaiting.size; var_8++) {
        if(self.facewaiting[var_8]["notifyNum"] == var_7) {
          var_6 = var_8;
          break;
        }
      }

      if(self.a.facewaitforresult == "notify")
        playfacethread(self.facewaiting[var_6]["facialanim"], self.facewaiting[var_6]["soundAlias"], self.facewaiting[var_6]["importance"], self.facewaiting[var_6]["notifyString"]);
      else if(isdefined(var_3)) {
        self.faceresult = "failed";
        self notify(var_3);
      }

      for (var_8 = var_6 + 1; var_8 < self.facewaiting.size; var_8++) {
        self.facewaiting[var_8 - 1]["facialanim"] = self.facewaiting[var_8]["facialanim"];
        self.facewaiting[var_8 - 1]["soundAlias"] = self.facewaiting[var_8]["soundAlias"];
        self.facewaiting[var_8 - 1]["importance"] = self.facewaiting[var_8]["importance"];
        self.facewaiting[var_8 - 1]["notifyString"] = self.facewaiting[var_8]["notifyString"];
        self.facewaiting[var_8 - 1]["waitOrNot"] = self.facewaiting[var_8]["waitOrNot"];
        self.facewaiting[var_8 - 1]["timeToWait"] = self.facewaiting[var_8]["timeToWait"];
        self.facewaiting[var_8 - 1]["notifyNum"] = self.facewaiting[var_8]["notifyNum"];
      }

      self.facewaiting[self.facewaiting.size - 1] = undefined;
    } else {
      if(var_2 >= self.a.currentdialogimportance) {
        self notify("end current face");
        self endon("end current face");

        if(isdefined(var_3)) {
          if(isdefined(self.a.currentdialognotifystring)) {
            self.faceresult = "interrupted";
            self notify(self.a.currentdialognotifystring);
          }
        }

        self.a.currentdialogimportance = var_2;
        self.a.currentdialogsound = var_1;
        self.a.currentdialognotifystring = var_3;
        self.a.facialanimdone = 1;
        self.a.facialsounddone = 1;

        if(isdefined(var_0)) {
          maps\_anim::disabledefaultfacialanims();
          self setflaggedanimknobrestart("animscript faceanim", var_0, 1, 0.1, 1);
          self.a.facialanimdone = 0;
          thread waitforfacialanim();
        } else
          maps\_anim::disabledefaultfacialanims(0);

        if(isdefined(var_1)) {
          self playsoundatviewheight(var_1, "animscript facesound", 1);
          self.a.facialsounddone = 0;
          thread waitforfacesound();
        }

        while (!self.a.facialanimdone || !self.a.facialsounddone)
          self waittill("animscript facedone");

        self.a.currentdialogimportance = 0;
        self.a.currentdialogsound = undefined;
        self.a.currentdialognotifystring = undefined;

        if(isdefined(var_3)) {
          self.faceresult = "finished";
          self notify(var_3);
        }

        if(isdefined(self.facewaiting) && self.facewaiting.size > 0) {
          var_9 = 0;
          var_10 = 1;

          for (var_8 = 0; var_8 < self.facewaiting.size; var_8++) {
            if(self.facewaiting[var_8]["importance"] > var_9) {
              var_9 = self.facewaiting[var_8]["importance"];
              var_10 = var_8;
            }
          }

          self notify("animscript face stop waiting " + self.facewaiting[var_10]["notifyNum"]);
          return;
        }

        if(isai(self)) {
          playidleface();
          return;
        }

        return;
        return;
      }

      if(isdefined(var_3)) {
        self.faceresult = "failed";
        self notify(var_3);
      }
    }
  }
}

waitforfacialanim() {
  self endon("death");
  self endon("end current face");
  animscripts\shared::donotetracks("animscript faceanim");
  self.a.facialanimdone = 1;
  self notify("animscript facedone");
  maps\_anim::disabledefaultfacialanims(0);
}

waitforfacesound(var_0) {
  self endon("death");
  self waittill("animscript facesound" + var_0);
  self notify(var_0);
}

playface_waitfornotify(var_0, var_1, var_2) {
  self endon("death");
  self endon(var_2);
  self waittill(var_0);
  self.a.facewaitforresult = "notify";
  self notify(var_1);
}

playface_waitfortime(var_0, var_1, var_2) {
  self endon("death");
  self endon(var_2);
  wait(var_0);
  self.a.facewaitforresult = "time";
  self notify(var_1);
}

initlevelface() {
  anim.numfriendlyvoices = 8;
  anim.numenemyvoices = 8;
  initfacialanims();
}

#using_animtree("generic_human");

initfacialanims() {
  anim.facial = [];
  anim.facial["pain"] = [ % facial_pain_1, % facial_pain_2, % facial_pain_3, % facial_pain_4];
  anim.facial["aim"] = [ % facial_aim_1, % facial_aim_2];
  anim.facial["run"] = [ % facial_run_1, % facial_run_2];
  anim.facial["corner_stand_L"] = [ % facial_corner_stand_l_1, % facial_corner_stand_l_2];
  anim.facial["corner_stand_R"] = [ % facial_corner_stand_r_1, % facial_corner_stand_r_2];
  anim.facial["death"] = [ % facial_death_1, % facial_death_2, % facial_death_3, % facial_death_4];
  anim.facial["idle"] = [ % facial_idle_1, % facial_idle_2, % facial_idle_3];
  anim.facial["pain_blend"] = [ % facial_pain_blend_1, % facial_pain_blend_2, % facial_pain_blend_3, % facial_pain_blend_4];
  anim.facial["aim_blend"] = [ % facial_aim_blend_1, % facial_aim_blend_2];
  anim.facial["run_blend"] = [ % facial_run_blend_1, % facial_run_blend_2];
  anim.facial["corner_stand_L_blend"] = [ % facial_corner_stand_l_blend_1, % facial_corner_stand_l_blend_2];
  anim.facial["corner_stand_R_blend"] = [ % facial_corner_stand_r_blend_1, % facial_corner_stand_r_blend_2];
  anim.facial["death_blend"] = [ % facial_death_blend_1, % facial_death_blend_2, % facial_death_blend_3, % facial_death_blend_4];
  anim.facial["idle_blend"] = [ % facial_idle_blend_1, % facial_idle_blend_2, % facial_idle_blend_3];
}

animhasfacialoverride(var_0) {
  return animhasnotetrack(var_0, "facial_override");
}

clearfacialanim() {
  self clearanim( % head, 0.2);
}

playfacialanim(var_0, var_1, var_2) {
  if(!isdefined(self.facialidlemonitor))
    thread facial_idle_monitor_thread();

  if(isdefined(self.bdisabledefaultfacialanims) && self.bdisabledefaultfacialanims)
    self clearanim( % head, 0.2);
  else {
    if(isdefined(var_0) && animhasfacialoverride(var_0)) {
      self clearanim( % head, 0.2);
      return;
    }

    if(self hasblendshapes())
      var_1 = var_1 + "_blend";

    if(!isdefined(anim.facial[var_1])) {
      return;
    }
    if(isdefined(var_2) && var_2 >= 0 && var_2 < anim.facial[var_1].size)
      var_3 = var_2;
    else
      var_3 = randomint(anim.facial[var_1].size);

    var_4 = anim.facial[var_1][var_3];
    self setanimknob(var_4);

    if(var_1 == "death") {
      if(isdefined(var_0))
        thread end_facial_on_death(getanimlength(var_0));
      else
        thread end_facial_on_death();
    }
  }
}

end_facial_on_death(var_0) {
  var_1 = 1.0;
  var_2 = 0.2;

  if(isdefined(var_0))
    var_1 = clamp(var_0, var_2 + 0.5, var_1 + var_2) - var_2;

  wait(var_1);

  if(isdefined(self))
    self clearanim( % head, var_2);
}

get_eye_relative_dir() {
  if(self gettagindex("jnt_eyelid_TL") == -1 || self gettagindex("tag_eye") == -1) {
    return;
  }
  if(self gettagindex("jnt_eyelid_TR") == -1) {
    return;
  }
  var_0 = self gettagangles("tag_eye");
  var_1 = self gettagangles("jnt_eyelid_TR");
  var_2 = self gettagangles("jnt_eyelid_TL");
  var_3 = angleclamp180(abs(var_0[0] - var_1[0]));
  var_4 = angleclamp180(abs(var_0[0] - var_2[0]));

  if(!isdefined(self.prev_eyel_diff))
    self.prev_eyel_diff = var_3;

  if(!isdefined(self.prev_eyer_diff))
    self.prev_eyer_diff = var_4;

  if(!isdefined(self.eye_move_counter))
    self.eye_move_counter = 0;

  if(angleclamp180(var_3 - self.prev_eyel_diff) > 5 || angleclamp180(var_4 - self.prev_eyer_diff) > 5) {
    self.prev_eyel_diff = var_3;
    self.prev_eyer_diff = var_4;
  } else
    self.eye_move_counter++;

  if(isdefined(self.eye_move_counter) && self.eye_move_counter > 4 && isdefined(self.script) && self.script != "scripted" && self.script != "death") {
    var_5 = playfacialanim(undefined, "idle", undefined);

    if(isdefined(var_5))
      wait(getanimlength(anim.facial["idle"][var_5]));

    self.eye_move_counter = 0;
  }
}

facial_idle_monitor_thread() {
  self endon("death");
  self endon("killanimscript");
  self.facialidlemonitor = 1;

  for (;;) {
    get_eye_relative_dir();
    wait 0.35;
  }
}