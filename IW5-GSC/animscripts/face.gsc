/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\face.gsc
**************************************/

initcharacterface() {
  if(!anim.usefacialanims) {
    return;
  }
  if(!isDefined(self.a.currentdialogimportance)) {
    self.a.currentdialogimportance = 0;
    self.a.idleface = anim.alertface;
    self.facewaiting = [];
    self.facelastnotifynum = 0;
  }
}

saygenericdialogue(var_0) {
  var_1 = undefined;

  switch (self.voice) {
    case "seal":
    case "taskforce":
    case "french":
    case "pmc":
    case "czech":
    case "delta":
    case "american":
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
    case "meleeattack":
    case "meleecharge":
      var_5 = 0.5;
      break;
    case "flashbang":
      var_5 = 0.7;
      break;
    case "pain":
      var_5 = 0.9;
      break;
    case "death":
      var_5 = 1.0;
      break;
    default:
      var_5 = 0.3;
      break;
  }

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

  if(isDefined(var_3)) {
    if(isDefined(var_1)) {
      self playsoundatviewheight(var_1, "animscript facesound" + var_3, 1);
      thread waitforfacesound(var_3);
    }
  } else {
    self playsoundatviewheight(var_1);
  }
  if(!anim.usefacialanims) {
    return;
  }
  initcharacterface();

  if(!isDefined(var_0) && !isDefined(var_1)) {
    if(isDefined(var_3)) {
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

    if(var_2 <= self.a.currentdialogimportance && (isDefined(var_4) && var_4 == "wait")) {
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

      if(isDefined(var_5)) {
        thread playface_waitfortime(var_5, "Face done waiting", "Face done waiting");
      }
      self waittill("Face done waiting");
      var_6 = undefined;

      for(var_8 = 0; var_8 < self.facewaiting.size; var_8++) {
        if(self.facewaiting[var_8]["notifyNum"] == var_7) {
          var_6 = var_8;
          break;
        }
      }

      if(self.a.facewaitforresult == "notify") {
        playfacethread(self.facewaiting[var_6]["facialanim"], self.facewaiting[var_6]["soundAlias"], self.facewaiting[var_6]["importance"], self.facewaiting[var_6]["notifyString"]);
      } else if(isDefined(var_3)) {
        self.faceresult = "failed";
        self notify(var_3);
      }

      for(var_8 = var_6 + 1; var_8 < self.facewaiting.size; var_8++) {
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

        if(isDefined(var_3)) {
          if(isDefined(self.a.currentdialognotifystring)) {
            self.faceresult = "interrupted";
            self notify(self.a.currentdialognotifystring);
          }
        }

        self.a.currentdialogimportance = var_2;
        self.a.currentdialogsound = var_1;
        self.a.currentdialognotifystring = var_3;
        self.a.facialanimdone = 1;
        self.a.facialsounddone = 1;

        if(isDefined(var_0)) {
          self setflaggedanimknobrestart("animscript faceanim", var_0, 1, 0.1, 1);
          self.a.facialanimdone = 0;
          thread waitforfacialanim();
        }

        if(isDefined(var_1)) {
          self playsoundatviewheight(var_1, "animscript facesound", 1);
          self.a.facialsounddone = 0;
          thread waitforfacesound();
        }

        while(!self.a.facialanimdone || !self.a.facialsounddone) {
          self waittill("animscript facedone");
        }
        self.a.currentdialogimportance = 0;
        self.a.currentdialogsound = undefined;
        self.a.currentdialognotifystring = undefined;

        if(isDefined(var_3)) {
          self.faceresult = "finished";
          self notify(var_3);
        }

        if(isDefined(self.facewaiting) && self.facewaiting.size > 0) {
          var_9 = 0;
          var_10 = 1;

          for(var_8 = 0; var_8 < self.facewaiting.size; var_8++) {
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

      if(isDefined(var_3)) {
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
}