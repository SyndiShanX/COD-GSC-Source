/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\animmode.gsc
**************************************/

main() {
  self endon("death");
  self endon("stop_animmode");
  self notify("killanimscript");
  self._id_0C5B endon(self._id_0C5A);

  if(isDefined(self._id_0C5C)) {
    self thread[[self._id_0C5C]]();
    self._id_0C5C = undefined;
  }

  var_0 = isDefined(self._id_0C5D) && self._id_0C5D;

  if(var_0) {
    self endon("stop_loop");
    self._id_0C5D = undefined;
  } else {
    thread _id_0C63(self._id_0C5A);
  }
  var_1 = self._id_0C5A;
  self._id_0C5A = undefined;
  var_2 = 0;

  if(var_0) {
    var_2 = level._id_0C59[self._id_0C58][var_1].size;
    var_3 = level._id_0C59[self._id_0C58][var_1][randomint(var_2)];
  } else {
    var_3 = level._id_0C59[self._id_0C58][var_1];
  }
  var_4 = getstartorigin(self._id_0C5B.origin, self._id_0C5B.angles, var_3);
  var_5 = getstartangles(self._id_0C5B.origin, self._id_0C5B.angles, var_3);
  var_6 = self getdroptofloorposition(var_4);

  if(isDefined(var_6)) {
    var_4 = var_6;
  } else {}

  if(!isDefined(self._id_0C5E)) {
    self teleport(var_4, var_5);
  }
  self.pushable = 0;
  var_7 = 0.3;
  var_8 = 0.2;

  if(isDefined(self._id_0C5F)) {
    var_7 = self._id_0C5F;
    var_8 = self._id_0C5F;
  }

  self animmode(self._id_0C60);
  self clearanim(self._id_0C56, var_7);
  self orientmode("face angle", var_5[1]);
  var_9 = "custom_animmode";
  self setflaggedanimrestart(var_9, var_3, 1, var_8, 1);
  self._id_0C5B thread maps\_anim::_id_0C61(self, var_9, var_1, self._id_0C58);
  self._id_0C5B thread maps\_anim::_id_0C62(self, var_9, var_1);
  var_10 = self._id_0C5B;
  self._id_0C5B = undefined;
  self._id_0C60 = undefined;
  self endon("killanimscript");
  var_11 = "end";

  if(!var_0) {
    if(animhasnotetrack(var_3, "finish")) {
      var_11 = "finish";
    } else if(animhasnotetrack(var_3, "stop anim")) {
      var_11 = "stop anim";
    }
  }

  for(;;) {
    self waittillmatch(var_9, var_11);

    if(var_0) {
      var_3 = level._id_0C59[self._id_0C58][var_1][randomint(var_2)];
      self setflaggedanimknoblimitedrestart(var_9, var_3, 1, 0.2, 1);

      if(isDefined(var_10)) {
        var_10 thread maps\_anim::_id_0C61(self, var_9, var_1, self._id_0C58);
        var_10 thread maps\_anim::_id_0C62(self, var_9, var_1);
      }

      continue;
    }

    break;
  }

  if(var_11 != "end") {
    self orientmode("face motion");
  }
  self notify("finished_custom_animmode" + var_1);
}

_id_0C63(var_0) {
  self endon("death");
  self endon("finished_custom_animmode" + var_0);
  self waittill("killanimscript");
  self notify("finished_custom_animmode" + var_0);
}