/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\agents\scriptedagents.gsc
************************************************/

ai_init(behaviortreeasset, _id_1A1EED6344569893) {
  self.behaviortreeasset = behaviortreeasset;
  scripts\asm\asm::asm_init_blackboard();
  scripts\aitypes\bt_util::bt_init();
  scripts\asm\asm_mp::asm_init(_id_1A1EED6344569893, self.animationarchetype);
}

handleglobalnotetracks(_id_A234A65C378F3289, flagname, _id_ED9FB5D37A4C823E) {
  if(isDefined(anim.notetracks[_id_A234A65C378F3289]))
    return [[anim.notetracks[_id_A234A65C378F3289]]](_id_A234A65C378F3289, flagname);

  return undefined;
}

onenterstate(_id_71B1F73D9A1BE3A1, _id_7DBFB7362717CE21) {
  if(isDefined(self.onenteranimstate))
    self[[self.onenteranimstate]](_id_71B1F73D9A1BE3A1, _id_7DBFB7362717CE21);
}

ondeactivate() {
  self notify("killanimscript");
  self notify("terminate_ai_threads");
}

playanimuntilnotetrack(_id_E684FC6E068EE951, _id_17B87E142038DF7A, notetrack, _id_ED9FB5D37A4C823E) {
  playanimnuntilnotetrack(_id_E684FC6E068EE951, 0, _id_17B87E142038DF7A, notetrack, _id_ED9FB5D37A4C823E);
}

playanimnuntilnotetrack(_id_E684FC6E068EE951, animindex, _id_17B87E142038DF7A, notetrack, _id_ED9FB5D37A4C823E) {
  self setanimstate(_id_E684FC6E068EE951, animindex);

  if(!isDefined(notetrack))
    notetrack = "end";

  waituntilnotetrack(_id_17B87E142038DF7A, notetrack, _id_E684FC6E068EE951, animindex, _id_ED9FB5D37A4C823E);
}

playanimnatrateuntilnotetrack(_id_E684FC6E068EE951, animindex, _id_07B60BC0EAB3FD1E, _id_17B87E142038DF7A, notetrack, _id_ED9FB5D37A4C823E) {
  self setanimstate(_id_E684FC6E068EE951, animindex, _id_07B60BC0EAB3FD1E);

  if(!isDefined(notetrack))
    notetrack = "end";

  waituntilnotetrack(_id_17B87E142038DF7A, notetrack, _id_E684FC6E068EE951, animindex, _id_ED9FB5D37A4C823E);
}

waituntillnotetrack_internal(_id_A234A65C378F3289, notetrack, _id_E684FC6E068EE951, animindex, _id_ED9FB5D37A4C823E, animlength, starttime) {
  _id_EB5B1F36E255152D = undefined;

  if(isDefined(animlength))
    _id_EB5B1F36E255152D = (gettime() - starttime) * 0.001 / animlength;

  handleglobalnotetracks(_id_A234A65C378F3289, _id_E684FC6E068EE951, _id_ED9FB5D37A4C823E);

  if(isDefined(_id_E684FC6E068EE951) && isDefined(self.asm))
    scripts\asm\asm_mp::asm_handlenotetracks(_id_A234A65C378F3289, _id_E684FC6E068EE951, animindex, _id_EB5B1F36E255152D);

  if(!isDefined(animlength) || _id_EB5B1F36E255152D > 0) {
    if(_id_A234A65C378F3289 == notetrack || _id_A234A65C378F3289 == "end" || _id_A234A65C378F3289 == "anim_will_finish" || _id_A234A65C378F3289 == "finish")
      return 1;
  }

  if(isDefined(_id_ED9FB5D37A4C823E))
    [[_id_ED9FB5D37A4C823E]](_id_A234A65C378F3289, _id_E684FC6E068EE951, animindex, _id_EB5B1F36E255152D);

  return 0;
}

waituntilnotetrack(_id_17B87E142038DF7A, notetrack, _id_E684FC6E068EE951, animindex, _id_ED9FB5D37A4C823E) {
  starttime = gettime();
  animlength = undefined;

  if(isDefined(_id_E684FC6E068EE951) && isDefined(animindex))
    animlength = getanimlength(self getanimentry(_id_E684FC6E068EE951, animindex));

  _id_3CBA51F785093D95 = 0;

  while(!_id_3CBA51F785093D95) {
    self waittill(_id_17B87E142038DF7A, notes);

    if(isarray(notes)) {
      foreach(_id_A234A65C378F3289 in notes) {
        if(waituntillnotetrack_internal(_id_A234A65C378F3289, notetrack, _id_E684FC6E068EE951, animindex, _id_ED9FB5D37A4C823E, animlength, starttime))
          _id_3CBA51F785093D95 = 1;
      }

      continue;
    }

    _id_3CBA51F785093D95 = waituntillnotetrack_internal(notes, notetrack, _id_E684FC6E068EE951, animindex, _id_ED9FB5D37A4C823E, animlength, starttime);
  }
}

playanimfortime(_id_E684FC6E068EE951, time) {
  playanimnfortime(_id_E684FC6E068EE951, 0, time);
}

playanimnfortime(_id_E684FC6E068EE951, animindex, time) {
  self setanimstate(_id_E684FC6E068EE951, animindex);
  wait(time);
}

playanimnwithnotetracksfortime(_id_E684FC6E068EE951, animindex, _id_17B87E142038DF7A, time, _id_ED9FB5D37A4C823E) {
  self setanimstate(_id_E684FC6E068EE951, animindex);
  thread playanimnwithnotetracksfortime_helper(_id_E684FC6E068EE951, animindex, _id_17B87E142038DF7A, _id_ED9FB5D37A4C823E);
  wait(time);
  self notify(_id_E684FC6E068EE951 + animindex);
}

playanimnwithnotetracksfortime_helper(_id_E684FC6E068EE951, animindex, _id_17B87E142038DF7A, _id_ED9FB5D37A4C823E) {
  self notify(_id_E684FC6E068EE951 + animindex);
  self endon(_id_E684FC6E068EE951 + animindex);
  _id_3CBA51F785093D95 = 0;
  xanim = self getanimentry(_id_E684FC6E068EE951, animindex);
  animlength = getanimlength(xanim);
  starttime = gettime();

  while(!_id_3CBA51F785093D95) {
    self waittill(_id_17B87E142038DF7A, notes);

    if(!isarray(notes))
      notes = [notes];

    foreach(_id_A234A65C378F3289 in notes) {
      if(waituntillnotetrack_internal(_id_A234A65C378F3289, "end", _id_E684FC6E068EE951, animindex, _id_ED9FB5D37A4C823E, animlength, starttime))
        _id_3CBA51F785093D95 = 1;
    }
  }
}

playanimnatratefortime(_id_E684FC6E068EE951, animindex, _id_07B60BC0EAB3FD1E, time) {
  self setanimstate(_id_E684FC6E068EE951, animindex, _id_07B60BC0EAB3FD1E);
  wait(time);
}

getanimscalefactors(_id_3777ECE6A73EADA5, _id_95ABCCFE668F369A, _id_2C46A6BD43FDEC21) {
  _id_D21F1356118D7C7A = length2d(_id_3777ECE6A73EADA5);
  _id_7F285E83902C604D = _id_3777ECE6A73EADA5[2];
  _id_2CCB1DD08FCE285F = length2d(_id_95ABCCFE668F369A);
  _id_E29EB269DCC9D1C2 = _id_95ABCCFE668F369A[2];
  _id_42B2AFED38718FBA = 1;
  _id_B7AB30868F553F8D = 1;

  if(isDefined(_id_2C46A6BD43FDEC21) && _id_2C46A6BD43FDEC21) {
    _id_B440ACB6FF3F6694 = (_id_95ABCCFE668F369A[0], _id_95ABCCFE668F369A[1], 0);
    _id_8C938C76EE9A0D61 = vectorNormalize(_id_B440ACB6FF3F6694);

    if(vectordot(_id_8C938C76EE9A0D61, _id_3777ECE6A73EADA5) < 0)
      _id_42B2AFED38718FBA = 0;
    else if(_id_2CCB1DD08FCE285F > 0)
      _id_42B2AFED38718FBA = _id_D21F1356118D7C7A / _id_2CCB1DD08FCE285F;
  } else if(_id_2CCB1DD08FCE285F > 0)
    _id_42B2AFED38718FBA = _id_D21F1356118D7C7A / _id_2CCB1DD08FCE285F;

  if(abs(_id_E29EB269DCC9D1C2) > 0.001 && _id_E29EB269DCC9D1C2 * _id_7F285E83902C604D >= 0)
    _id_B7AB30868F553F8D = _id_7F285E83902C604D / _id_E29EB269DCC9D1C2;

  _id_DDBDC4364B93E58F = spawnStruct();
  _id_DDBDC4364B93E58F.xy = _id_42B2AFED38718FBA;
  _id_DDBDC4364B93E58F.z = _id_B7AB30868F553F8D;
  return _id_DDBDC4364B93E58F;
}

droppostoground(position, _id_463494A5F1200722) {
  radius = 15;
  height = 45;

  if(isDefined(self.radius))
    radius = self.radius;

  if(isDefined(self.height))
    height = self.height;

  if(!isDefined(_id_463494A5F1200722))
    _id_463494A5F1200722 = 18;

  startpos = position + (0, 0, _id_463494A5F1200722);
  endpos = position + (0, 0, _id_463494A5F1200722 * -1);
  _id_3627F3C8C6351D4D = self aiphysicstrace(startpos, endpos, self.radius, self.height, 1);

  if(abs(_id_3627F3C8C6351D4D[2] - startpos[2]) < 0.1)
    return undefined;

  if(abs(_id_3627F3C8C6351D4D[2] - endpos[2]) < 0.1)
    return undefined;

  return _id_3627F3C8C6351D4D;
}

canmovepointtopoint(startpos, endpos, _id_EF05B67E242818FA, radius) {
  if(!isDefined(_id_EF05B67E242818FA))
    _id_EF05B67E242818FA = 6;

  if(!isDefined(radius))
    radius = self.radius;

  _id_E53677BBC487B2B7 = (0, 0, 1) * _id_EF05B67E242818FA;
  _id_1381504F4F4A31AB = startpos + _id_E53677BBC487B2B7;
  _id_6CF5F2094D846DB8 = endpos + _id_E53677BBC487B2B7;
  return self aiphysicstracepassed(_id_1381504F4F4A31AB, _id_6CF5F2094D846DB8, radius, self.height - _id_EF05B67E242818FA, 1);
}

getvalidpointtopointmovelocation(startpos, endpos, _id_EF05B67E242818FA) {
  if(!isDefined(_id_EF05B67E242818FA))
    _id_EF05B67E242818FA = 6;

  _id_E53677BBC487B2B7 = (0, 0, 1) * _id_EF05B67E242818FA;
  _id_1381504F4F4A31AB = startpos + _id_E53677BBC487B2B7;
  _id_6CF5F2094D846DB8 = endpos + _id_E53677BBC487B2B7;
  return self aiphysicstrace(_id_1381504F4F4A31AB, _id_6CF5F2094D846DB8, self.radius + 4, self.height - _id_EF05B67E242818FA, 1);
}

getsafeanimmovedeltapercentage(_id_0D02EEA0F6367895) {
  _id_773BBE3E674F23B7 = getmovedelta(_id_0D02EEA0F6367895);
  endpos = self localtoworldcoords(_id_773BBE3E674F23B7);
  _id_2CC08A3D86A448EF = getvalidpointtopointmovelocation(self.origin, endpos);
  _id_EFBAADEB85F1C3F7 = distance(self.origin, _id_2CC08A3D86A448EF);
  _id_40E426C264B27FB3 = distance(self.origin, endpos);
  return min(1.0, _id_EFBAADEB85F1C3F7 / _id_40E426C264B27FB3);
}

safelyplayanimuntilnotetrack(_id_E684FC6E068EE951, _id_17B87E142038DF7A, notetrack, _id_ED9FB5D37A4C823E) {
  animindex = getrandomanimentry(_id_E684FC6E068EE951);
  safelyplayanimnuntilnotetrack(_id_E684FC6E068EE951, animindex, _id_17B87E142038DF7A, notetrack, _id_ED9FB5D37A4C823E);
}

safelyplayanimatrateuntilnotetrack(_id_E684FC6E068EE951, _id_07B60BC0EAB3FD1E, _id_17B87E142038DF7A, notetrack, _id_ED9FB5D37A4C823E) {
  animindex = getrandomanimentry(_id_E684FC6E068EE951);
  safelyplayanimnatrateuntilnotetrack(_id_E684FC6E068EE951, animindex, _id_07B60BC0EAB3FD1E, _id_17B87E142038DF7A, notetrack, _id_ED9FB5D37A4C823E);
}

safelyplayanimnatrateuntilnotetrack(_id_E684FC6E068EE951, animindex, _id_07B60BC0EAB3FD1E, _id_17B87E142038DF7A, notetrack, _id_ED9FB5D37A4C823E) {
  self setanimstate(_id_E684FC6E068EE951, animindex, _id_07B60BC0EAB3FD1E);
  safelyplayanimnuntilnotetrack(_id_E684FC6E068EE951, animindex, _id_17B87E142038DF7A, notetrack, _id_ED9FB5D37A4C823E);
}

safelyplayanimnuntilnotetrack(_id_E684FC6E068EE951, animindex, _id_17B87E142038DF7A, notetrack, _id_ED9FB5D37A4C823E) {
  _id_85DE4B2384EA1FE3 = self getanimentry(_id_E684FC6E068EE951, animindex);
  _id_106E031C779CC672 = getsafeanimmovedeltapercentage(_id_85DE4B2384EA1FE3);
  playanimnuntilnotetrack(_id_E684FC6E068EE951, animindex, _id_17B87E142038DF7A, notetrack, _id_ED9FB5D37A4C823E);
}

getrandomanimentry(state) {
  count = self getanimentrycount(state);
  return randomint(count);
}

getangleindexfromselfyaw(_id_A7C61B8EEA2709C3) {
  targetangles = vectortoangles(_id_A7C61B8EEA2709C3);
  _id_077B9E4B599269EB = angleclamp180(targetangles[1] - self.angles[1]);
  return getangleindex(_id_077B9E4B599269EB);
}

set_anim_state(_id_E684FC6E068EE951, animindex, _id_07B60BC0EAB3FD1E) {
  if(isDefined(_id_07B60BC0EAB3FD1E))
    self setanimstate(_id_E684FC6E068EE951, animindex, _id_07B60BC0EAB3FD1E);
  else if(isDefined(animindex))
    self setanimstate(_id_E684FC6E068EE951, animindex);
  else
    self setanimstate(_id_E684FC6E068EE951);
}

isstatelocked() {
  if(!isDefined(self.statelocked))
    return 0;

  return self.statelocked;
}

setstatelocked(set, cause) {
  self.statelocked = set;
}

playanimnuntilnotetrack_safe(_id_E684FC6E068EE951, animindex, _id_17B87E142038DF7A, notetrack, _id_337BF53C6767D89C) {
  playanimnatrateuntilnotetrack_safe(_id_E684FC6E068EE951, animindex, 1.0, _id_17B87E142038DF7A, notetrack, _id_337BF53C6767D89C);
}

waituntilnotetrack_safe(_id_17B87E142038DF7A, notetrack, timeout) {
  self endon("death_or_disconnect");

  if(isDefined(timeout))
    childthread notetrack_timeout(_id_17B87E142038DF7A, timeout, notetrack);

  waituntilnotetrack(_id_17B87E142038DF7A, notetrack);
  self notify("Notetrack_Timeout");
}

playanimnatrateuntilnotetrack_safe(_id_E684FC6E068EE951, animindex, _id_07B60BC0EAB3FD1E, _id_17B87E142038DF7A, notetrack, _id_337BF53C6767D89C) {
  self endon("death_or_disconnect");

  if(isDefined(_id_E684FC6E068EE951)) {
    if(isDefined(animindex))
      animlength = getanimlength(self getanimentry(_id_E684FC6E068EE951, animindex));
    else
      animlength = getanimlength(self getanimentry(_id_E684FC6E068EE951, 0));

    childthread notetrack_timeout(_id_17B87E142038DF7A, animlength * (1.0 / _id_07B60BC0EAB3FD1E), notetrack);
  }

  playanimnatrateuntilnotetrack(_id_E684FC6E068EE951, animindex, _id_07B60BC0EAB3FD1E, _id_17B87E142038DF7A, notetrack, _id_337BF53C6767D89C);
  self notify("Notetrack_Timeout");
}

notetrack_timeout(_id_17B87E142038DF7A, _id_996B994B521B006F, notetrack) {
  self notify("Notetrack_Timeout");
  self endon("Notetrack_Timeout");
  _id_996B994B521B006F = max(0.05, _id_996B994B521B006F);
  wait(_id_996B994B521B006F);

  if(isDefined(notetrack))
    self notify(_id_17B87E142038DF7A, notetrack);
  else
    self notify(_id_17B87E142038DF7A, "end");
}

dotraversalwithflexibleheight(_id_E684FC6E068EE951, animindex, _id_FE955022D7616EA0, _id_17B87E142038DF7A, _id_E5AEFC352A22ACA2, _id_D2FD6E73FE47FD81, _id_E1F32A9CA006465A, _id_E26232D596806F5A) {
  if(_id_E5AEFC352A22ACA2 != "highest_point")
    playanimnuntilnotetrack(_id_E684FC6E068EE951, animindex, _id_17B87E142038DF7A, _id_E5AEFC352A22ACA2, _id_E26232D596806F5A);

  if(_id_E1F32A9CA006465A) {
    _id_0ED04898BA5F6FDB = self.endnodepos;
    _id_AA200010A21ECD1A = 1;
  } else {
    _id_0ED04898BA5F6FDB = scripts\engine\utility::getStruct(self.endnode.target, "targetname");
    _id_0ED04898BA5F6FDB = _id_0ED04898BA5F6FDB.origin;
    _id_E9A85E46F68A9CD2 = getnotetracktimes(_id_FE955022D7616EA0, "highest_point");
    _id_AA200010A21ECD1A = _id_E9A85E46F68A9CD2[0];
  }

  dotraversalwithflexibleheight_internal(_id_E684FC6E068EE951, animindex, _id_17B87E142038DF7A, _id_FE955022D7616EA0, _id_E5AEFC352A22ACA2, _id_D2FD6E73FE47FD81, _id_0ED04898BA5F6FDB, _id_AA200010A21ECD1A, _id_E26232D596806F5A);
}

dotraversalwithflexibleheight_internal(_id_E684FC6E068EE951, animindex, _id_17B87E142038DF7A, _id_FE955022D7616EA0, _id_E5AEFC352A22ACA2, _id_D2FD6E73FE47FD81, _id_577413F819643488, _id_215459DFF2DC12CC, _id_E26232D596806F5A) {
  _id_6A7D78A1630C3BCB = abs(self.origin[2] - _id_577413F819643488[2]);
  _id_58DF0A31A12DF550 = getnotetracktimes(_id_FE955022D7616EA0, _id_E5AEFC352A22ACA2);
  start_time = _id_58DF0A31A12DF550[0];
  _id_1108217E59EED9F5 = start_time;
  _id_6F2F40F39E8E95B1 = getnotetracktimes(_id_FE955022D7616EA0, _id_D2FD6E73FE47FD81);
  end_time = _id_6F2F40F39E8E95B1[0];
  _id_215459DFF2DC12CC = end_time;
  _id_FE9B9F108FE4E400 = "flex_height_up_top";
  _id_B4954D8E5404203D = getnotetracktimes(_id_FE955022D7616EA0, _id_FE9B9F108FE4E400);
  _id_A9E9BE991C4884D7 = "flex_height_down_top";
  _id_62FD34167A46D726 = getnotetracktimes(_id_FE955022D7616EA0, _id_A9E9BE991C4884D7);
  _id_2E0BC1422A39A0EB = "flex_height_down_bottom";
  _id_69E50BF6DB82D69A = getnotetracktimes(_id_FE955022D7616EA0, _id_2E0BC1422A39A0EB);

  if(_id_E5AEFC352A22ACA2 == "flex_height_up_start" && _id_B4954D8E5404203D.size > 0)
    _id_215459DFF2DC12CC = _id_B4954D8E5404203D[0];

  if(_id_E5AEFC352A22ACA2 == "flex_height_down_start") {
    if(_id_62FD34167A46D726.size > 0)
      _id_1108217E59EED9F5 = _id_B4954D8E5404203D[0];

    if(_id_69E50BF6DB82D69A.size > 0)
      _id_215459DFF2DC12CC = _id_69E50BF6DB82D69A[0];
  }

  _id_E635223ADA445A58 = getmovedelta(_id_FE955022D7616EA0, _id_1108217E59EED9F5, _id_215459DFF2DC12CC);
  _id_E1E7A2B5445420B5 = abs(_id_E635223ADA445A58[2]);
  _id_E9381FE239340756 = getmovedelta(_id_FE955022D7616EA0, start_time, end_time);
  _id_ACB957B5767E0051 = abs(_id_E9381FE239340756[2]);

  if(_id_ACB957B5767E0051 < 1)
    _id_FD5897B916AA531D = 1;
  else {
    _id_0358FC70DFB71A23 = _id_E1E7A2B5445420B5 - _id_ACB957B5767E0051;

    if(_id_6A7D78A1630C3BCB <= _id_0358FC70DFB71A23)
      _id_FD5897B916AA531D = (_id_0358FC70DFB71A23 - _id_6A7D78A1630C3BCB) / _id_ACB957B5767E0051;
    else
      _id_FD5897B916AA531D = (_id_6A7D78A1630C3BCB - _id_0358FC70DFB71A23) / _id_ACB957B5767E0051;
  }

  _id_35A0F5AFB933E47B = clamp(1 / _id_FD5897B916AA531D, 0.33, 3.0);
  playanimnatrateuntilnotetrack(_id_E684FC6E068EE951, animindex, _id_35A0F5AFB933E47B, _id_17B87E142038DF7A, _id_D2FD6E73FE47FD81, _id_E26232D596806F5A);
}