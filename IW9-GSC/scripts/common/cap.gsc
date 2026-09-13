/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\cap.gsc
***********************************************/

_id_136FB87AD4393EF8() {
  if(isDefined(level._id_A5407B03B3E5F39F)) {
    return;
  }
  level._id_A5407B03B3E5F39F = spawnStruct();
  level._id_A5407B03B3E5F39F._id_08BD091E21FBA9F3 = ::_id_C434AF0895CC147C;
  level._id_A5407B03B3E5F39F._id_55050A7CEBE72181 = ::_id_B6AF4ADE50626E90;
}

_id_C434AF0895CC147C(_id_3E38EE41DC326FDC, animset, animscripted) {
  self._id_8F0BD1E175F2CF51 = self.origin;
  self._id_394377B94EDABDDF = self.angles;

  if(!isai(self)) {
    self._blackboard = spawnStruct();
    self._blackboard.asm_events = [];
    self._blackboard.bfire = 0;
    _id_B69DB84955DF12E5(_id_3E38EE41DC326FDC, animset);
    return;
  } else
    self._blackboard._id_7460B96395361857 = undefined;

  self setoverridearchetype("animscript", animset, 0);
  self _meth_24EB7F77BC5E5950(_id_3E38EE41DC326FDC);
  _id_FB2E421E36C177A0(_id_3E38EE41DC326FDC);

  if(istrue(animscripted))
    scripts\asm\asm_bb::bb_setanimScripted();
}

_id_B69DB84955DF12E5(_id_B5DA6777BFE1ACE8, _id_5E1AB61C2C7FE69B) {
  if(_id_5E1AB61C2C7FE69B == "hero_salter" || _id_5E1AB61C2C7FE69B == "farah" || _id_5E1AB61C2C7FE69B == "soldier_female")
    scripts\asm\asm_bb::bb_setshort(1);

  self.asmname = _id_B5DA6777BFE1ACE8;

  if(!isDefined(self.asm)) {
    self.asm = spawnStruct();
    self.asm.animoverrides = [];
  }

  if(isDefined(_id_5E1AB61C2C7FE69B)) {
    self._id_AE3EA15396B65C1F = _id_5E1AB61C2C7FE69B;
    self.animationarchetype = undefined;
  }

  asmregistergenerichandler(_id_B5DA6777BFE1ACE8, scripts\asm\asm::asm_generichandler);
  self asminstantiate(_id_B5DA6777BFE1ACE8);

  if(!isDefined(level._id_6FDC536A33DE2D32)) {
    level._id_6FDC536A33DE2D32 = [];
    level thread _id_896667BF7F3ED3DC();
  }

  if(!scripts\engine\utility::array_contains(level._id_6FDC536A33DE2D32, self))
    level._id_6FDC536A33DE2D32[level._id_6FDC536A33DE2D32.size] = self;
}

_id_896667BF7F3ED3DC() {
  for(;;) {
    for(_id_89D86711A7226025 = 0; _id_89D86711A7226025 < level._id_6FDC536A33DE2D32.size; _id_89D86711A7226025++) {
      _id_44AD9FC1BB1EF07C = level._id_6FDC536A33DE2D32[_id_89D86711A7226025];

      if(isalive(_id_44AD9FC1BB1EF07C))
        _id_44AD9FC1BB1EF07C asmtick();
    }

    wait 0.05;
  }
}

_id_FB2E421E36C177A0(_id_F48B8938602F359B, _id_0388552599BFCB74) {
  self asmterminate();
  self notify("asm_terminated");
  self._id_A709FBD9FEA148F6 = undefined;

  if(!isDefined(_id_0388552599BFCB74))
    _id_0388552599BFCB74 = self._id_AE3EA15396B65C1F;

  self[[self.fnasm_init]](tolower(_id_F48B8938602F359B), _id_0388552599BFCB74);
}

_id_B6AF4ADE50626E90() {
  if(self.asmname == self._id_A942DD31D55102C9) {
    return;
  }
  if(scripts\asm\asm_bb::bb_isanimScripted())
    scripts\asm\asm_bb::bb_clearanimScripted();

  self._id_A709FBD9FEA148F6 = undefined;
  self _meth_73DEC7A4D991183E();
  self._id_30452AD282AFCD76 = undefined;

  if(isDefined(self._id_34DF90223221B7A6))
    _id_5A9987F1E5BBD641();

  _id_3327078DAA3ECD38();
  self notify("cap_exit_completed");
}

_id_A996F137B4EF05ED() {
  self endon("entitydeleted");
  self endon("cap_exit_completed");

  if(self.team == "axis")
    scripts\engine\utility::waittill_either("death", scripts\common\utility::_id_A1260C3B5F229F69());
  else
    self waittill("death");

  if(scripts\asm\asm_bb::bb_isanimScripted())
    scripts\asm\asm_bb::bb_clearanimScripted();

  self stopanimScripted();
  self clearoverridearchetype("animscript");
  self _meth_24EB7F77BC5E5950(undefined);
  _id_FB2E421E36C177A0(self._id_A942DD31D55102C9);

  if(isDefined(self._id_34DF90223221B7A6))
    _id_5A9987F1E5BBD641();

  _id_3327078DAA3ECD38();
  self notify("cap_exit_completed");
}

_id_B58F0A57ADF2948E(origin, _id_3E38EE41DC326FDC, animset, _id_9E6DCF179D658229) {
  self endon("death");

  if(isDefined(_id_9E6DCF179D658229) && _id_9E6DCF179D658229) {
    self._id_0CC9DA6F81DD0068 = self.scriptgoalpos;
    self.oldgoalradius = self.goalradius;
  }

  self setgoalpos(origin, 1);
  self waittill("goal");
  _id_C434AF0895CC147C(_id_3E38EE41DC326FDC, animset);
  self waittill("cap_exit_completed");

  if(isDefined(self._id_0CC9DA6F81DD0068)) {
    self setgoalpos(self._id_0CC9DA6F81DD0068, self.oldgoalradius);
    self._id_0CC9DA6F81DD0068 = undefined;
    self.oldgoalradius = undefined;
  }
}

_id_3A8BC84C604F9755() {
  msg = scripts\engine\utility::waittill_any_return_2("cap_reach_and_arrive", "bseq_user_deleted");

  if(isDefined(self.scriptedarrivalent))
    self.scriptedarrivalent delete();

  if(isDefined(self._id_DDAD29BBDECD1671))
    self._id_DDAD29BBDECD1671 = undefined;

  if(isDefined(msg)) {
    self finishcoverarrival("Custom");
    self clearbtgoal(1);

    if(msg == "bseq_user_deleted") {
      if(self._id_A942DD31D55102C9 != self.asmname)
        _id_B6AF4ADE50626E90();
    }
  }
}

_id_E85F29F7EB1C5529(scriptednode, _id_3E38EE41DC326FDC, animset, _id_26B7B68BEE5A2349) {
  self notify("cap_reach_and_arrive");
  self endon("cap_reach_and_arrive");
  thread _id_3A8BC84C604F9755();
  self endon("bseq_user_deleted");

  if(!isDefined(self.scriptedarrivalent))
    self.scriptedarrivalent = spawn("script_origin", scriptednode.origin);

  self.scriptedarrivalent.angles = scriptednode.angles;
  self.scriptedarrivalent.origin = scriptednode.origin;
  self.scriptedarrivalent.type = "Custom";
  _id_2D3B08E66235831C = "cap_arrival";

  if(isDefined(_id_26B7B68BEE5A2349))
    _id_2D3B08E66235831C = _id_26B7B68BEE5A2349;

  _id_28E3F014AE0041E6 = self.pushable;
  self.pushable = 0;
  goalpos = getclosestpointonnavmesh(scriptednode.origin, self);
  _id_4EB801042B324702 = distancesquared(goalpos, scriptednode.origin);

  if(_id_4EB801042B324702 >= 10000) {
    _id_8EEFCDE993E5AE9D = 32;
    self setbtgoalRadius(1, _id_8EEFCDE993E5AE9D);
    self setbtgoalpos(1, scriptednode.origin);
  } else {
    _id_8EEFCDE993E5AE9D = 4;
    self setbtgoalRadius(1, _id_8EEFCDE993E5AE9D);
    self setbtgoalpos(1, goalpos);
  }

  scripts\asm\asm::asm_fireephemeralevent("path_chosen", "end");
  self._id_A57082FDF62BC898 = _id_2D3B08E66235831C;
  self._id_33B4C07D1F388776 = animset;
  self._id_0A41EDF45BB0FF97 = scriptednode.angles;
  self._id_171120E99DF3E286 = 1;
  self._id_DDAD29BBDECD1671 = ::_id_0E1C21B37D95134A;
  self._id_B4C85F2BC7ABB407 = spawnStruct();
  self._id_B4C85F2BC7ABB407.arrivalangles = scriptednode.angles;
  self._id_B4C85F2BC7ABB407.asmname = _id_3E38EE41DC326FDC;
  self._id_B4C85F2BC7ABB407._id_74C9B1F78857273D = 0;
  self waittill("bt_goal");

  if(istrue(self._id_B4C85F2BC7ABB407._id_74C9B1F78857273D)) {
    self waittill("custom_arrival_handler_done");
    _id_C1754C51B6A54C56();
  } else {
    _id_C1754C51B6A54C56();
    _id_C434AF0895CC147C(_id_3E38EE41DC326FDC, animset);
  }

  scripts\asm\asm::asm_fireephemeralevent("move", "end");
  self.pushable = _id_28E3F014AE0041E6;
  self._id_B4C85F2BC7ABB407 = undefined;
  self notify("cap_reach_and_arrive");
}

_id_0E1C21B37D95134A() {
  self endon("death");
  self endon("cap_exit_completed");
  self._id_B4C85F2BC7ABB407._id_74C9B1F78857273D = 1;
  _id_C434AF0895CC147C(self._id_B4C85F2BC7ABB407.asmname, self._id_33B4C07D1F388776);
  _id_4900381BB16AAFC0 = self asmgetcurrentstate(self.asmname);
  self asmsetstate(self.asmname, self._id_A57082FDF62BC898);
  timeouttime = gettime() + 5000;

  while(!scripts\asm\asm::asm_eventfired(self.asmname, "end") && gettime() < timeouttime)
    waitframe();

  self._id_B4C85F2BC7ABB407._id_74C9B1F78857273D = 0;
  self asmsetstate(self.asmname, _id_4900381BB16AAFC0);
  self notify("custom_arrival_handler_done");
}

_id_C1754C51B6A54C56(statename, params) {
  self endon("death");
  self endon("lerp_arrive_finished");

  if(!isDefined(self._id_718D80100704CC82) || !isDefined(self._id_A70672E669CA7F00)) {
    return;
  }
  startorigin = self.origin;
  startangles = self.angles;
  groundpos = scripts\engine\utility::drop_to_ground(self._id_718D80100704CC82, 10, -200);
  dist = distance2d(startorigin, groundpos);
  _id_077B9E4B599269EB = anglesdelta(startangles, self._id_A70672E669CA7F00);
  _id_3E031DE3D5B91D1C = dist * level.frameduration;
  _id_510D3EE194B1526F = gettime() + _id_3E031DE3D5B91D1C;
  _id_0786B023CE979687 = _id_077B9E4B599269EB / 10 * level.frameduration;
  _id_4D4FE2E8313ED865 = gettime() + _id_0786B023CE979687;

  while(_id_510D3EE194B1526F > gettime() || _id_4D4FE2E8313ED865 > gettime()) {
    _id_6C53D859D582A421 = self.origin;

    if(_id_510D3EE194B1526F > gettime()) {
      _id_19CD9E7E23E7097F = 1.0 - (_id_510D3EE194B1526F - gettime()) / _id_3E031DE3D5B91D1C;
      _id_6C53D859D582A421 = vectorlerp(startorigin, groundpos, _id_19CD9E7E23E7097F);
    }

    _id_B98CF035C97EDEE9 = self.angles;

    if(_id_4D4FE2E8313ED865 > gettime()) {
      _id_760E1991B2913A56 = 1.0 - (_id_4D4FE2E8313ED865 - gettime()) / _id_0786B023CE979687;
      _id_B98CF035C97EDEE9 = anglelerpquatfrac(startangles, self._id_A70672E669CA7F00, _id_760E1991B2913A56);
    }

    self forceteleport(_id_6C53D859D582A421, _id_B98CF035C97EDEE9);
    waitframe();
  }

  self notify("lerp_arrive_finished");
}

_id_A1ED6AE80ED92596(group) {
  if(!isDefined(level._id_6961D0344027496F))
    level._id_6961D0344027496F = [];

  _id_DC40AFDD39573C9A = level._id_6961D0344027496F.size;
  level._id_6961D0344027496F[_id_DC40AFDD39573C9A] = group;

  foreach(ent in group)
  ent._id_34DF90223221B7A6 = _id_DC40AFDD39573C9A;
}

_id_5A9987F1E5BBD641() {
  level._id_6961D0344027496F[self._id_34DF90223221B7A6] scripts\engine\utility::array_remove(level._id_6961D0344027496F[self._id_34DF90223221B7A6], self);

  if(level._id_6961D0344027496F[self._id_34DF90223221B7A6].size == 0)
    scripts\engine\utility::array_remove(self._id_34DF90223221B7A6, level._id_6961D0344027496F);
}

_id_3327078DAA3ECD38() {
  if(isDefined(level._id_BA6BE00A0C2658CC) && scripts\engine\utility::_id_A6025442A4E1C649(level._id_BA6BE00A0C2658CC, self)) {
    level notify("player_look_at_process");

    if(isDefined(level._id_F62B6E59C0E00D48._id_90EC46DE988E0068))
      level._id_F62B6E59C0E00D48._id_90EC46DE988E0068 = 0;

    if(isDefined(level._id_BA6BE00A0C2658CC))
      level._id_BA6BE00A0C2658CC = undefined;
  }

  if(isDefined(level._id_03FE0ABFD459C8D0) && scripts\engine\utility::_id_A6025442A4E1C649(level._id_03FE0ABFD459C8D0, self)) {
    level notify("civilian_process_eye_look_at");

    if(isDefined(level._id_F62B6E59C0E00D48._id_C02D69C3F71770BD))
      level._id_F62B6E59C0E00D48._id_C02D69C3F71770BD = 0;

    if(isDefined(level._id_03FE0ABFD459C8D0))
      level._id_03FE0ABFD459C8D0 = undefined;
  }
}

_id_8E7E29E55F6BE1E1(_id_3E38EE41DC326FDC, animset) {
  self.asmname = _id_3E38EE41DC326FDC;

  if(!isDefined(self.asm)) {
    self.asm = spawnStruct();
    self.asm.animoverrides = [];
  }

  self._id_AE3EA15396B65C1F = animset;
  self.animationarchetype = undefined;
}

_id_882C76A8F1F5F9A6(states, _id_B4C3697A9D2ED329) {
  self._id_F457C1616037EA52 = [];

  if(!isarray(states))
    states = [states];

  foreach(state in states)
  self._id_F457C1616037EA52[state] = 0.0;

  if(isDefined(_id_B4C3697A9D2ED329))
    self._id_DCF5E86549620338 = _id_B4C3697A9D2ED329;
}

_id_A05F4D85F33E9EEA(states) {
  if(!isarray(states))
    states = [states];

  self._id_1836CD6BC75A5CE3 = states;
}