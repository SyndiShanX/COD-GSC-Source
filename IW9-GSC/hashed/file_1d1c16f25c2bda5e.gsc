/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1d1c16f25c2bda5e.gsc
***********************************************/

teleportthread(_id_51304DDED8F135AC) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");
  _id_3CACBBC5D5637F2D = 5;
  offset = (0, 0, _id_51304DDED8F135AC / _id_3CACBBC5D5637F2D);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3CACBBC5D5637F2D; _id_AC0E594AC96AA3A8++) {
    self forceteleport(self.origin + offset);
    wait 0.05;
  }
}

teleportthreadex(_id_51304DDED8F135AC, delay, _id_1AAD8F38CB38F703, _id_07B60BC0EAB3FD1E) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");

  if(_id_51304DDED8F135AC == 0 || _id_1AAD8F38CB38F703 <= 0) {
    return;
  }
  if(delay > 0)
    wait(delay);

  offset = (0, 0, _id_51304DDED8F135AC / _id_1AAD8F38CB38F703);

  if(isDefined(_id_07B60BC0EAB3FD1E) && _id_07B60BC0EAB3FD1E < 1.0)
    self _meth_9EAE9CF347EAC025("traverseAnim", self.traverseanim, self.traverseanimroot, 1, 0.2, _id_07B60BC0EAB3FD1E);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1AAD8F38CB38F703; _id_AC0E594AC96AA3A8++) {
    self forceteleport(self.origin + offset);
    wait 0.05;
  }

  if(isDefined(_id_07B60BC0EAB3FD1E) && _id_07B60BC0EAB3FD1E < 1.0)
    self _meth_9EAE9CF347EAC025("traverseAnim", self.traverseanim, self.traverseanimroot, 1, 0.2, 1.0);
}

dotraverse(_id_AEB119A0ED15E45F) {}

handletraversenotetracks(_id_A234A65C378F3289) {
  if(_id_A234A65C378F3289 == "traverse_death")
    return handletraversedeathnotetrack();
  else if(_id_A234A65C378F3289 == "traverse_align")
    return handletraversealignment();
  else if(_id_A234A65C378F3289 == "traverse_drop")
    return handletraversedrop();
}

handletraversedeathnotetrack() {
  if(isDefined(self.traversedeathanim)) {
    _id_D2565459C0E88749 = self.traversedeathanim[self.traversedeathindex];
    scripts\common\ai::set_deathanim(_id_D2565459C0E88749[randomint(_id_D2565459C0E88749.size)]);
    self.traversedeathindex++;
  }
}

handletraversealignment() {
  self animmode("noclip");
  _id_256CA46D1EFFDD41 = undefined;

  if(self._id_32A34987EE1B3095 == "nodeless" || self._id_32A34987EE1B3095 == "linkless")
    _id_256CA46D1EFFDD41 = self._id_64B933AF90EDC53C.traverse_height;
  else
    _id_256CA46D1EFFDD41 = self.traversestartnode.traverse_height;

  if(isDefined(self.traverseheight) && isDefined(_id_256CA46D1EFFDD41)) {
    _id_C96A4BFB26396AA5 = _id_256CA46D1EFFDD41 - self.traversestartz;
    thread teleportthread(_id_C96A4BFB26396AA5 - self.traverseheight);
  }
}

handletraversedrop() {
  startpos = self.origin + (0, 0, 32);
  endpos = physicstrace(startpos, self.origin + (0, 0, -512));
  dist = distance(startpos, endpos);
  _id_E365C44CBF1472AB = dist - 32 - 0.5;
  _id_09C41C6BCE074794 = self getanimtime(self.traverseanim);
  _id_472176E97AA175C8 = getmovedelta(self.traverseanim, _id_09C41C6BCE074794, 1.0);
  _id_524AF19A4F9D376A = getanimlength(self.traverseanim);
  _id_0FB6F770A5D1925E = 0 - _id_472176E97AA175C8[2];
  _id_726BAF9860A60E6B = _id_0FB6F770A5D1925E - _id_E365C44CBF1472AB;

  if(_id_0FB6F770A5D1925E < _id_E365C44CBF1472AB)
    _id_07B60BC0EAB3FD1E = _id_0FB6F770A5D1925E / _id_E365C44CBF1472AB;
  else
    _id_07B60BC0EAB3FD1E = 1;

  _id_05A9DADADD41366E = (_id_524AF19A4F9D376A - _id_09C41C6BCE074794) / 3.0;
  _id_7E3211AE44B15B55 = ceil(_id_05A9DADADD41366E * 20);
  thread teleportthreadex(_id_726BAF9860A60E6B, 0, _id_7E3211AE44B15B55, _id_07B60BC0EAB3FD1E);
  thread finishtraversedrop(endpos[2]);
}

finishtraversedrop(_id_BA8D57C006AB035B) {
  self endon("killanimscript");
  _id_BA8D57C006AB035B = _id_BA8D57C006AB035B + 4.0;

  for(;;) {
    if(self.origin[2] < _id_BA8D57C006AB035B) {
      self animmode("gravity");
      break;
    }

    wait 0.05;
  }
}

donothingfunc() {
  self animmode("zonly_physics");
  self waittill("killanimscript");
}

dog_jump_down(_id_1AAD8F38CB38F703, rate, _id_D0527D58BB610197, _id_5A11F5D9304A0C83) {}

seeker_traversal() {
  self waittill("killanimscript");
}