/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\face.gsc
**************************************/

_id_0C3A() {
  if(!anim._id_0C3B) {
    return;
  }
  if(!isDefined(self.a._id_0C3C)) {
    self.a._id_0C3C = 0;
    self.a._id_0C3E = anim._id_0C3D;
    self._id_0C3F = [];
    self._id_0C40 = 0;
  }
}

_id_0C41(var_0) {
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
      var_3 = anim._id_0C42;
      break;
    default:
      var_2 = "enemy";
      var_3 = anim._id_0C43;
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
  thread _id_0C49(var_4, var_6, var_5);
}

_id_0C44(var_0) {
  animscripts\battlechatter::_id_0ABF();
  self.a._id_0C3E = var_0;
}

_id_0C45(var_0) {
  if(!anim._id_0C3B) {
    return;
  }
  animscripts\battlechatter::_id_0ABF();
  self.a._id_0C3E = var_0;
  _id_0C48();
}

_id_0C46(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread _id_0C49(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_0C47(var_0) {
  return;
}

_id_0C48() {
  return;
}

_id_0C49(var_0, var_1, var_2, var_3, var_4, var_5) {
  self.a._id_0C4A = 1;
  self.a._id_0C4B = 1;

  if(isDefined(var_3)) {
    if(isDefined(var_1)) {
      self playsoundatviewheight(var_1, "animscript facesound" + var_3, 1);
      thread _id_0C52(var_3);
    }
  } else {
    self playsoundatviewheight(var_1);
  }
  if(!anim._id_0C3B) {
    return;
  }
  _id_0C3A();

  if(!isDefined(var_0) && !isDefined(var_1)) {
    if(isDefined(var_3)) {
      wait 0;
      self._id_0C4C = "failed";
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

    if(var_2 <= self.a._id_0C3C && (isDefined(var_4) && var_4 == "wait")) {
      var_6 = self._id_0C3F.size;
      var_7 = self._id_0C40 + 1;
      self._id_0C3F[var_6]["facialanim"] = var_0;
      self._id_0C3F[var_6]["soundAlias"] = var_1;
      self._id_0C3F[var_6]["importance"] = var_2;
      self._id_0C3F[var_6]["notifyString"] = var_3;
      self._id_0C3F[var_6]["waitOrNot"] = var_4;
      self._id_0C3F[var_6]["timeToWait"] = var_5;
      self._id_0C3F[var_6]["notifyNum"] = var_7;
      thread _id_0C53("animscript face stop waiting " + self._id_0C3F[var_6]["notifyNum"], "Face done waiting", "Face done waiting");

      if(isDefined(var_5)) {
        thread _id_0C54(var_5, "Face done waiting", "Face done waiting");
      }
      self waittill("Face done waiting");
      var_6 = undefined;

      for(var_8 = 0; var_8 < self._id_0C3F.size; var_8++) {
        if(self._id_0C3F[var_8]["notifyNum"] == var_7) {
          var_6 = var_8;
          break;
        }
      }

      if(self.a._id_0C4D == "notify") {
        _id_0C49(self._id_0C3F[var_6]["facialanim"], self._id_0C3F[var_6]["soundAlias"], self._id_0C3F[var_6]["importance"], self._id_0C3F[var_6]["notifyString"]);
      } else if(isDefined(var_3)) {
        self._id_0C4C = "failed";
        self notify(var_3);
      }

      for(var_8 = var_6 + 1; var_8 < self._id_0C3F.size; var_8++) {
        self._id_0C3F[var_8 - 1]["facialanim"] = self._id_0C3F[var_8]["facialanim"];
        self._id_0C3F[var_8 - 1]["soundAlias"] = self._id_0C3F[var_8]["soundAlias"];
        self._id_0C3F[var_8 - 1]["importance"] = self._id_0C3F[var_8]["importance"];
        self._id_0C3F[var_8 - 1]["notifyString"] = self._id_0C3F[var_8]["notifyString"];
        self._id_0C3F[var_8 - 1]["waitOrNot"] = self._id_0C3F[var_8]["waitOrNot"];
        self._id_0C3F[var_8 - 1]["timeToWait"] = self._id_0C3F[var_8]["timeToWait"];
        self._id_0C3F[var_8 - 1]["notifyNum"] = self._id_0C3F[var_8]["notifyNum"];
      }

      self._id_0C3F[self._id_0C3F.size - 1] = undefined;
    } else {
      if(var_2 >= self.a._id_0C3C) {
        self notify("end current face");
        self endon("end current face");

        if(isDefined(var_3)) {
          if(isDefined(self.a._id_0C4E)) {
            self._id_0C4C = "interrupted";
            self notify(self.a._id_0C4E);
          }
        }

        self.a._id_0C3C = var_2;
        self.a._id_0C4F = var_1;
        self.a._id_0C4E = var_3;
        self.a._id_0C4A = 1;
        self.a._id_0C4B = 1;

        if(isDefined(var_0)) {
          self setflaggedanimknobrestart("animscript faceanim", var_0, 1, 0.1, 1);
          self.a._id_0C4A = 0;
          thread _id_0C50();
        }

        if(isDefined(var_1)) {
          self playsoundatviewheight(var_1, "animscript facesound", 1);
          self.a._id_0C4B = 0;
          thread _id_0C52();
        }

        while(!self.a._id_0C4A || !self.a._id_0C4B) {
          self waittill("animscript facedone");
        }
        self.a._id_0C3C = 0;
        self.a._id_0C4F = undefined;
        self.a._id_0C4E = undefined;

        if(isDefined(var_3)) {
          self._id_0C4C = "finished";
          self notify(var_3);
        }

        if(isDefined(self._id_0C3F) && self._id_0C3F.size > 0) {
          var_9 = 0;
          var_10 = 1;

          for(var_8 = 0; var_8 < self._id_0C3F.size; var_8++) {
            if(self._id_0C3F[var_8]["importance"] > var_9) {
              var_9 = self._id_0C3F[var_8]["importance"];
              var_10 = var_8;
            }
          }

          self notify("animscript face stop waiting " + self._id_0C3F[var_10]["notifyNum"]);
          return;
        }

        if(isai(self)) {
          _id_0C48();
          return;
        }

        return;
        return;
      }

      if(isDefined(var_3)) {
        self._id_0C4C = "failed";
        self notify(var_3);
      }
    }
  }
}

_id_0C50() {
  self endon("death");
  self endon("end current face");
  animscripts\shared::_id_0C51("animscript faceanim");
  self.a._id_0C4A = 1;
  self notify("animscript facedone");
}

_id_0C52(var_0) {
  self endon("death");
  self waittill("animscript facesound" + var_0);
  self notify(var_0);
}

_id_0C53(var_0, var_1, var_2) {
  self endon("death");
  self endon(var_2);
  self waittill(var_0);
  self.a._id_0C4D = "notify";
  self notify(var_1);
}

_id_0C54(var_0, var_1, var_2) {
  self endon("death");
  self endon(var_2);
  wait(var_0);
  self.a._id_0C4D = "time";
  self notify(var_1);
}

_id_0C55() {
  anim._id_0C42 = 8;
  anim._id_0C43 = 8;
}