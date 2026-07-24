/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\animmode.gsc
**************************************/

main() {
  self endon("death");
  self endon("stop_animmode");
  self notify("killanimscript");
  self._id_141C endon(self._id_117E);

  if(isDefined(self._id_11BC)) {
    self thread[[self._id_11BC]]();
    self._id_11BC = undefined;
  }

  var_0 = isDefined(self._id_11BB) && self._id_11BB;

  if(var_0) {
    self endon("stop_loop");
    self._id_11BB = undefined;
  } else
    thread _id_C141(self._id_117E);

  var_1 = self._id_117E;
  self._id_117E = undefined;
  var_2 = 0;

  if(var_0) {
    var_2 = level._id_EC85[self._id_1180][var_1].size;
    var_3 = level._id_EC85[self._id_1180][var_1][randomint(var_2)];
  } else
    var_3 = level._id_EC85[self._id_1180][var_1];

  var_4 = getstartorigin(self._id_141C.origin, self._id_141C.angles, var_3);
  var_5 = getstartangles(self._id_141C.origin, self._id_141C.angles, var_3);
  var_6 = self _meth_811F(var_4);

  if(isDefined(var_6))
    var_4 = var_6;
  else {}

  if(!isDefined(self._id_C0C1))
    self _meth_83B9(var_4, var_5);

  self.pushable = 0;
  var_7 = 0.3;
  var_8 = 0.2;

  if(isDefined(self._id_1EA2)) {
    var_7 = self._id_1EA2;
    var_8 = self._id_1EA2;
  }

  self animmode(self._id_117F);

  if(getdvarint("ai_iw7") == 1)
    self clearanim(_id_0A1E::_id_2342(), 0.3);
  else
    self clearanim(self._id_E6E6, var_7);

  self orientmode("face angle", var_5[1]);
  var_9 = "custom_animmode";
  self _meth_82EA(var_9, var_3, 1, var_8, 1);
  self._id_141C thread scripts\sp\anim::_id_10CBF(self, var_9, var_1, self._id_1180, var_3);
  self._id_141C thread scripts\sp\anim::_id_1FCA(self, var_9, var_1);
  var_10 = self._id_141C;
  self._id_141C = undefined;
  self._id_117F = undefined;
  self endon("killanimscript");
  var_11 = "end";

  if(!var_0) {
    if(animhasnotetrack(var_3, "finish"))
      var_11 = "finish";
    else if(animhasnotetrack(var_3, "stop anim"))
      var_11 = "stop anim";
  }

  for(;;) {
    self waittillmatch(var_9, var_11);

    if(var_0) {
      var_3 = level._id_EC85[self._id_1180][var_1][randomint(var_2)];
      self _meth_82E6(var_9, var_3, 1, 0.2, 1);

      if(isDefined(var_10)) {
        var_10 thread scripts\sp\anim::_id_10CBF(self, var_9, var_1, self._id_1180, var_3);
        var_10 thread scripts\sp\anim::_id_1FCA(self, var_9, var_1);
      }

      continue;
    }

    break;
  }

  if(var_11 != "end")
    self orientmode("face motion");

  self notify("finished_custom_animmode" + var_1);
}

_id_C141(var_0) {
  self endon("death");
  self endon("finished_custom_animmode" + var_0);
  self waittill("killanimscript");
  self notify("finished_custom_animmode" + var_0);
}