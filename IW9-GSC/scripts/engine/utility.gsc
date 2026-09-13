/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\engine\utility.gsc
***********************************************/

noself_func(func, parm1, parm2, parm3, parm4) {
  if(!isDefined(level.func)) {
    return;
  }
  if(!isDefined(level.func[func])) {
    return;
  }
  if(!isDefined(parm1)) {
    call[[level.func[func]]]();
    return;
  }

  if(!isDefined(parm2)) {
    call[[level.func[func]]](parm1);
    return;
  }

  if(!isDefined(parm3)) {
    call[[level.func[func]]](parm1, parm2);
    return;
  }

  if(!isDefined(parm4)) {
    call[[level.func[func]]](parm1, parm2, parm3);
    return;
  }

  call[[level.func[func]]](parm1, parm2, parm3, parm4);
}

noself_func_return(func, parm1, parm2, parm3, parm4) {
  if(!isDefined(level.func))
    return undefined;

  if(!isDefined(level.func[func]))
    return undefined;

  if(!isDefined(parm1))
    return call[[level.func[func]]]();

  if(!isDefined(parm2))
    return call[[level.func[func]]](parm1);

  if(!isDefined(parm3))
    return call[[level.func[func]]](parm1, parm2);

  if(!isDefined(parm4))
    return call[[level.func[func]]](parm1, parm2, parm3);

  return call[[level.func[func]]](parm1, parm2, parm3, parm4);
}

self_func(func, parm1, parm2, parm3, parm4) {
  if(!isDefined(level.func[func])) {
    return;
  }
  if(!isDefined(parm1)) {
    self call[[level.func[func]]]();
    return;
  }

  if(!isDefined(parm2)) {
    self call[[level.func[func]]](parm1);
    return;
  }

  if(!isDefined(parm3)) {
    self call[[level.func[func]]](parm1, parm2);
    return;
  }

  if(!isDefined(parm4)) {
    self call[[level.func[func]]](parm1, parm2, parm3);
    return;
  }

  self call[[level.func[func]]](parm1, parm2, parm3, parm4);
}

script_func(func, parm1, parm2, parm3, parm4) {
  if(!isDefined(level.func[func])) {
    return;
  }
  if(!isDefined(parm1))
    return self[[level.func[func]]]();
  else if(!isDefined(parm2))
    return self[[level.func[func]]](parm1);
  else if(!isDefined(parm3))
    return self[[level.func[func]]](parm1, parm2);
  else if(!isDefined(parm4))
    return self[[level.func[func]]](parm1, parm2, parm3);

  return self[[level.func[func]]](parm1, parm2, parm3, parm4);
}

randomvector(num) {
  return (randomfloat(num) - num * 0.5, randomfloat(num) - num * 0.5, randomfloat(num) - num * 0.5);
}

randomvectorrange(_id_C9A3B79B12AEF49C, _id_C980A59B1288854E) {
  x = randomfloatrange(_id_C9A3B79B12AEF49C, _id_C980A59B1288854E);

  if(randomint(2) == 0)
    x = x * -1;

  y = randomfloatrange(_id_C9A3B79B12AEF49C, _id_C980A59B1288854E);

  if(randomint(2) == 0)
    y = y * -1;

  z = randomfloatrange(_id_C9A3B79B12AEF49C, _id_C980A59B1288854E);

  if(randomint(2) == 0)
    z = z * -1;

  return (x, y, z);
}

sign(x) {
  if(x >= 0)
    return 1;

  return -1;
}

randomonunitsphere() {
  _id_F157E2C858DD6237 = randomfloat(180);
  _id_B201B10302D5E138 = randomfloat(360);
  x = cos(_id_B201B10302D5E138) * cos(_id_F157E2C858DD6237);
  y = cos(_id_B201B10302D5E138) * sin(_id_F157E2C858DD6237);
  z = sin(_id_B201B10302D5E138);
  return (x, y, z);
}

_id_6174330574A2A273() {
  angle = randomfloat(360);
  dist = randomfloat(1);
  x = cos(angle) * dist;
  y = sin(angle) * dist;
  return (x, y, 0);
}

_id_D553466CF817A4DA() {
  for(;;) {
    x = randomfloatrange(-1, 1);
    y = randomfloatrange(-1, 1);

    if(x * x + y * y < 1)
      return (x, y, 0);
  }
}

mod(_id_A860076E6B45DB06, _id_F1563935AEEB5199) {
  _id_AC0E414AC96A6EE0 = int(_id_A860076E6B45DB06 / _id_F1563935AEEB5199);

  if(_id_A860076E6B45DB06 * _id_F1563935AEEB5199 < 0)
    _id_AC0E414AC96A6EE0 = _id_AC0E414AC96A6EE0 - 1;

  return _id_A860076E6B45DB06 - _id_AC0E414AC96A6EE0 * _id_F1563935AEEB5199;
}

get_enemy_team(team) {
  teams = [];
  teams["axis"] = "allies";
  teams["allies"] = "axis";
  return teams[team];
}

clear_exception(type) {
  self.exception[type] = anim.defaultexception;
}

cointoss() {
  return randomint(100) >= 50;
}

_id_51D76700600CEBE3(_id_7E1B02C65B1197C8) {
  return randomfloat(100) < _id_7E1B02C65B1197C8;
}

choose_from_weighted_array(values, weights) {
  _id_73C0BD15F57DB725 = randomint(weights[weights.size - 1] + 1);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < weights.size; _id_AC0E594AC96AA3A8++) {
    if(_id_73C0BD15F57DB725 <= weights[_id_AC0E594AC96AA3A8])
      return values[_id_AC0E594AC96AA3A8];
  }
}

waittill_string(msg, ent) {
  if(msg != "death")
    self endon("death");

  ent endon("die");
  self waittill(msg);
  ent notify("returned", msg);
}

waittillmatch_string(anim_name, msg, ent) {
  if(msg != "death")
    self endon("death");

  ent endon("die");
  self waittillmatch(anim_name, msg);
  ent notify("returned", msg);
}

waittill_string_no_endon_death(msg, ent) {
  ent endon("die");
  self waittill(msg);
  ent notify("returned", msg);
}

waittill_multiple(_id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD, _id_0E7860AE7BE34848, _id_0E7861AE7BE34A7B) {
  self endon("death");
  ent = spawnStruct();
  ent.threads = 0;

  if(isDefined(_id_0E7865AE7BE35347)) {
    childthread waittill_string(_id_0E7865AE7BE35347, ent);
    ent.threads++;
  }

  if(isDefined(_id_0E7866AE7BE3557A)) {
    childthread waittill_string(_id_0E7866AE7BE3557A, ent);
    ent.threads++;
  }

  if(isDefined(_id_0E7867AE7BE357AD)) {
    childthread waittill_string(_id_0E7867AE7BE357AD, ent);
    ent.threads++;
  }

  if(isDefined(_id_0E7860AE7BE34848)) {
    childthread waittill_string(_id_0E7860AE7BE34848, ent);
    ent.threads++;
  }

  if(isDefined(_id_0E7861AE7BE34A7B)) {
    childthread waittill_string(_id_0E7861AE7BE34A7B, ent);
    ent.threads++;
  }

  while(ent.threads) {
    ent waittill("returned");
    ent.threads--;
  }

  ent notify("die");
}

waittill_2(_id_0E7865AE7BE35347, _id_0E7866AE7BE3557A) {
  self endon("death");
  ent = spawnStruct();
  ent.threads = 0;

  if(isDefined(_id_0E7865AE7BE35347)) {
    childthread waittill_string(_id_0E7865AE7BE35347, ent);
    ent.threads++;
  }

  if(isDefined(_id_0E7866AE7BE3557A)) {
    childthread waittill_string(_id_0E7866AE7BE3557A, ent);
    ent.threads++;
  }

  while(ent.threads) {
    ent waittill("returned");
    ent.threads--;
  }

  ent notify("die");
}

waittillmatch_notify(anim_name, _id_5D74DAEC5CE18458, _id_BF850ADA23F636B0) {
  self endon("death");
  self waittillmatch(anim_name, _id_5D74DAEC5CE18458);
  self notify(_id_BF850ADA23F636B0);
}

waittill_any_return_1(_id_0E7865AE7BE35347) {
  if(!isDefined(_id_0E7865AE7BE35347) || _id_0E7865AE7BE35347 != "death")
    self endon("death");

  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string(_id_0E7865AE7BE35347, ent);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_return_2(_id_0E7865AE7BE35347, _id_0E7866AE7BE3557A) {
  if((!isDefined(_id_0E7865AE7BE35347) || _id_0E7865AE7BE35347 != "death") && (!isDefined(_id_0E7866AE7BE3557A) || _id_0E7866AE7BE3557A != "death"))
    self endon("death");

  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_0E7866AE7BE3557A))
    childthread waittill_string(_id_0E7866AE7BE3557A, ent);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_return_3(_id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD) {
  if((!isDefined(_id_0E7865AE7BE35347) || _id_0E7865AE7BE35347 != "death") && (!isDefined(_id_0E7866AE7BE3557A) || _id_0E7866AE7BE3557A != "death") && (!isDefined(_id_0E7867AE7BE357AD) || _id_0E7867AE7BE357AD != "death"))
    self endon("death");

  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_0E7866AE7BE3557A))
    childthread waittill_string(_id_0E7866AE7BE3557A, ent);

  if(isDefined(_id_0E7867AE7BE357AD))
    childthread waittill_string(_id_0E7867AE7BE357AD, ent);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_return_4(_id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD, _id_0E7860AE7BE34848) {
  if((!isDefined(_id_0E7865AE7BE35347) || _id_0E7865AE7BE35347 != "death") && (!isDefined(_id_0E7866AE7BE3557A) || _id_0E7866AE7BE3557A != "death") && (!isDefined(_id_0E7867AE7BE357AD) || _id_0E7867AE7BE357AD != "death") && (!isDefined(_id_0E7860AE7BE34848) || _id_0E7860AE7BE34848 != "death"))
    self endon("death");

  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_0E7866AE7BE3557A))
    childthread waittill_string(_id_0E7866AE7BE3557A, ent);

  if(isDefined(_id_0E7867AE7BE357AD))
    childthread waittill_string(_id_0E7867AE7BE357AD, ent);

  if(isDefined(_id_0E7860AE7BE34848))
    childthread waittill_string(_id_0E7860AE7BE34848, ent);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_return_5(_id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD, _id_0E7860AE7BE34848, _id_0E7861AE7BE34A7B) {
  if((!isDefined(_id_0E7865AE7BE35347) || _id_0E7865AE7BE35347 != "death") && (!isDefined(_id_0E7866AE7BE3557A) || _id_0E7866AE7BE3557A != "death") && (!isDefined(_id_0E7867AE7BE357AD) || _id_0E7867AE7BE357AD != "death") && (!isDefined(_id_0E7860AE7BE34848) || _id_0E7860AE7BE34848 != "death") && (!isDefined(_id_0E7861AE7BE34A7B) || _id_0E7861AE7BE34A7B != "death"))
    self endon("death");

  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_0E7866AE7BE3557A))
    childthread waittill_string(_id_0E7866AE7BE3557A, ent);

  if(isDefined(_id_0E7867AE7BE357AD))
    childthread waittill_string(_id_0E7867AE7BE357AD, ent);

  if(isDefined(_id_0E7860AE7BE34848))
    childthread waittill_string(_id_0E7860AE7BE34848, ent);

  if(isDefined(_id_0E7861AE7BE34A7B))
    childthread waittill_string(_id_0E7861AE7BE34A7B, ent);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_return_6(_id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD, _id_0E7860AE7BE34848, _id_0E7861AE7BE34A7B, _id_0E7862AE7BE34CAE) {
  if((!isDefined(_id_0E7865AE7BE35347) || _id_0E7865AE7BE35347 != "death") && (!isDefined(_id_0E7866AE7BE3557A) || _id_0E7866AE7BE3557A != "death") && (!isDefined(_id_0E7867AE7BE357AD) || _id_0E7867AE7BE357AD != "death") && (!isDefined(_id_0E7860AE7BE34848) || _id_0E7860AE7BE34848 != "death") && (!isDefined(_id_0E7861AE7BE34A7B) || _id_0E7861AE7BE34A7B != "death") && (!isDefined(_id_0E7862AE7BE34CAE) || _id_0E7862AE7BE34CAE != "death"))
    self endon("death");

  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_0E7866AE7BE3557A))
    childthread waittill_string(_id_0E7866AE7BE3557A, ent);

  if(isDefined(_id_0E7867AE7BE357AD))
    childthread waittill_string(_id_0E7867AE7BE357AD, ent);

  if(isDefined(_id_0E7860AE7BE34848))
    childthread waittill_string(_id_0E7860AE7BE34848, ent);

  if(isDefined(_id_0E7861AE7BE34A7B))
    childthread waittill_string(_id_0E7861AE7BE34A7B, ent);

  if(isDefined(_id_0E7862AE7BE34CAE))
    childthread waittill_string(_id_0E7862AE7BE34CAE, ent);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_return_7(_id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD, _id_0E7860AE7BE34848, _id_0E7861AE7BE34A7B, _id_0E7862AE7BE34CAE, _id_0E7863AE7BE34EE1) {
  if((!isDefined(_id_0E7865AE7BE35347) || _id_0E7865AE7BE35347 != "death") && (!isDefined(_id_0E7866AE7BE3557A) || _id_0E7866AE7BE3557A != "death") && (!isDefined(_id_0E7867AE7BE357AD) || _id_0E7867AE7BE357AD != "death") && (!isDefined(_id_0E7860AE7BE34848) || _id_0E7860AE7BE34848 != "death") && (!isDefined(_id_0E7861AE7BE34A7B) || _id_0E7861AE7BE34A7B != "death") && (!isDefined(_id_0E7862AE7BE34CAE) || _id_0E7862AE7BE34CAE != "death") && (!isDefined(_id_0E7863AE7BE34EE1) || _id_0E7863AE7BE34EE1 != "death"))
    self endon("death");

  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_0E7866AE7BE3557A))
    childthread waittill_string(_id_0E7866AE7BE3557A, ent);

  if(isDefined(_id_0E7867AE7BE357AD))
    childthread waittill_string(_id_0E7867AE7BE357AD, ent);

  if(isDefined(_id_0E7860AE7BE34848))
    childthread waittill_string(_id_0E7860AE7BE34848, ent);

  if(isDefined(_id_0E7861AE7BE34A7B))
    childthread waittill_string(_id_0E7861AE7BE34A7B, ent);

  if(isDefined(_id_0E7862AE7BE34CAE))
    childthread waittill_string(_id_0E7862AE7BE34CAE, ent);

  if(isDefined(_id_0E7863AE7BE34EE1))
    childthread waittill_string(_id_0E7863AE7BE34EE1, ent);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_return(_id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD, _id_0E7860AE7BE34848, _id_0E7861AE7BE34A7B, _id_0E7862AE7BE34CAE, _id_0E7863AE7BE34EE1, _id_0E785CAE7BE33F7C) {
  if((!isDefined(_id_0E7865AE7BE35347) || _id_0E7865AE7BE35347 != "death") && (!isDefined(_id_0E7866AE7BE3557A) || _id_0E7866AE7BE3557A != "death") && (!isDefined(_id_0E7867AE7BE357AD) || _id_0E7867AE7BE357AD != "death") && (!isDefined(_id_0E7860AE7BE34848) || _id_0E7860AE7BE34848 != "death") && (!isDefined(_id_0E7861AE7BE34A7B) || _id_0E7861AE7BE34A7B != "death") && (!isDefined(_id_0E7862AE7BE34CAE) || _id_0E7862AE7BE34CAE != "death") && (!isDefined(_id_0E7863AE7BE34EE1) || _id_0E7863AE7BE34EE1 != "death") && (!isDefined(_id_0E785CAE7BE33F7C) || _id_0E785CAE7BE33F7C != "death"))
    self endon("death");

  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_0E7866AE7BE3557A))
    childthread waittill_string(_id_0E7866AE7BE3557A, ent);

  if(isDefined(_id_0E7867AE7BE357AD))
    childthread waittill_string(_id_0E7867AE7BE357AD, ent);

  if(isDefined(_id_0E7860AE7BE34848))
    childthread waittill_string(_id_0E7860AE7BE34848, ent);

  if(isDefined(_id_0E7861AE7BE34A7B))
    childthread waittill_string(_id_0E7861AE7BE34A7B, ent);

  if(isDefined(_id_0E7862AE7BE34CAE))
    childthread waittill_string(_id_0E7862AE7BE34CAE, ent);

  if(isDefined(_id_0E7863AE7BE34EE1))
    childthread waittill_string(_id_0E7863AE7BE34EE1, ent);

  if(isDefined(_id_0E785CAE7BE33F7C))
    childthread waittill_string(_id_0E785CAE7BE33F7C, ent);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittillmatch_any_return(_id_65DC1767352C19CD, _id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD, _id_0E7860AE7BE34848, _id_0E7861AE7BE34A7B, _id_0E7862AE7BE34CAE) {
  if((!isDefined(_id_0E7865AE7BE35347) || _id_0E7865AE7BE35347 != "death") && (!isDefined(_id_0E7866AE7BE3557A) || _id_0E7866AE7BE3557A != "death") && (!isDefined(_id_0E7867AE7BE357AD) || _id_0E7867AE7BE357AD != "death") && (!isDefined(_id_0E7860AE7BE34848) || _id_0E7860AE7BE34848 != "death") && (!isDefined(_id_0E7861AE7BE34A7B) || _id_0E7861AE7BE34A7B != "death") && (!isDefined(_id_0E7862AE7BE34CAE) || _id_0E7862AE7BE34CAE != "death"))
    self endon("death");

  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittillmatch_string(_id_65DC1767352C19CD, _id_0E7865AE7BE35347, ent);

  if(isDefined(_id_0E7866AE7BE3557A))
    childthread waittillmatch_string(_id_65DC1767352C19CD, _id_0E7866AE7BE3557A, ent);

  if(isDefined(_id_0E7867AE7BE357AD))
    childthread waittillmatch_string(_id_65DC1767352C19CD, _id_0E7867AE7BE357AD, ent);

  if(isDefined(_id_0E7860AE7BE34848))
    childthread waittillmatch_string(_id_65DC1767352C19CD, _id_0E7860AE7BE34848, ent);

  if(isDefined(_id_0E7861AE7BE34A7B))
    childthread waittillmatch_string(_id_65DC1767352C19CD, _id_0E7861AE7BE34A7B, ent);

  if(isDefined(_id_0E7862AE7BE34CAE))
    childthread waittillmatch_string(_id_65DC1767352C19CD, _id_0E7862AE7BE34CAE, ent);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_return_no_endon_death_1(_id_0E7865AE7BE35347) {
  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string_no_endon_death(_id_0E7865AE7BE35347, ent);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_return_no_endon_death_2(_id_0E7865AE7BE35347, _id_0E7866AE7BE3557A) {
  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string_no_endon_death(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_0E7866AE7BE3557A))
    childthread waittill_string_no_endon_death(_id_0E7866AE7BE3557A, ent);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_return_no_endon_death_3(_id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD) {
  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string_no_endon_death(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_0E7866AE7BE3557A))
    childthread waittill_string_no_endon_death(_id_0E7866AE7BE3557A, ent);

  if(isDefined(_id_0E7867AE7BE357AD))
    childthread waittill_string_no_endon_death(_id_0E7867AE7BE357AD, ent);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_return_no_endon_death_4(_id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD, _id_0E7860AE7BE34848) {
  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string_no_endon_death(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_0E7866AE7BE3557A))
    childthread waittill_string_no_endon_death(_id_0E7866AE7BE3557A, ent);

  if(isDefined(_id_0E7867AE7BE357AD))
    childthread waittill_string_no_endon_death(_id_0E7867AE7BE357AD, ent);

  if(isDefined(_id_0E7860AE7BE34848))
    childthread waittill_string_no_endon_death(_id_0E7860AE7BE34848, ent);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_return_no_endon_death_5(_id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD, _id_0E7860AE7BE34848, _id_0E7861AE7BE34A7B) {
  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string_no_endon_death(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_0E7866AE7BE3557A))
    childthread waittill_string_no_endon_death(_id_0E7866AE7BE3557A, ent);

  if(isDefined(_id_0E7867AE7BE357AD))
    childthread waittill_string_no_endon_death(_id_0E7867AE7BE357AD, ent);

  if(isDefined(_id_0E7860AE7BE34848))
    childthread waittill_string_no_endon_death(_id_0E7860AE7BE34848, ent);

  if(isDefined(_id_0E7861AE7BE34A7B))
    childthread waittill_string_no_endon_death(_id_0E7861AE7BE34A7B, ent);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_return_no_endon_death_6(_id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD, _id_0E7860AE7BE34848, _id_0E7861AE7BE34A7B, _id_0E7862AE7BE34CAE) {
  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string_no_endon_death(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_0E7866AE7BE3557A))
    childthread waittill_string_no_endon_death(_id_0E7866AE7BE3557A, ent);

  if(isDefined(_id_0E7867AE7BE357AD))
    childthread waittill_string_no_endon_death(_id_0E7867AE7BE357AD, ent);

  if(isDefined(_id_0E7860AE7BE34848))
    childthread waittill_string_no_endon_death(_id_0E7860AE7BE34848, ent);

  if(isDefined(_id_0E7861AE7BE34A7B))
    childthread waittill_string_no_endon_death(_id_0E7861AE7BE34A7B, ent);

  if(isDefined(_id_0E7862AE7BE34CAE))
    childthread waittill_string_no_endon_death(_id_0E7862AE7BE34CAE, ent);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

_id_EFE4706DF8361219(_id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD, _id_0E7860AE7BE34848, _id_0E7861AE7BE34A7B, _id_0E7862AE7BE34CAE, _id_0E7863AE7BE34EE1) {
  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string_no_endon_death(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_0E7866AE7BE3557A))
    childthread waittill_string_no_endon_death(_id_0E7866AE7BE3557A, ent);

  if(isDefined(_id_0E7867AE7BE357AD))
    childthread waittill_string_no_endon_death(_id_0E7867AE7BE357AD, ent);

  if(isDefined(_id_0E7860AE7BE34848))
    childthread waittill_string_no_endon_death(_id_0E7860AE7BE34848, ent);

  if(isDefined(_id_0E7861AE7BE34A7B))
    childthread waittill_string_no_endon_death(_id_0E7861AE7BE34A7B, ent);

  if(isDefined(_id_0E7862AE7BE34CAE))
    childthread waittill_string_no_endon_death(_id_0E7862AE7BE34CAE, ent);

  if(isDefined(_id_0E7863AE7BE34EE1))
    childthread waittill_string_no_endon_death(_id_0E7863AE7BE34EE1, ent);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_return_no_endon_death(_id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD, _id_0E7860AE7BE34848, _id_0E7861AE7BE34A7B, _id_0E7862AE7BE34CAE) {
  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string_no_endon_death(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_0E7866AE7BE3557A))
    childthread waittill_string_no_endon_death(_id_0E7866AE7BE3557A, ent);

  if(isDefined(_id_0E7867AE7BE357AD))
    childthread waittill_string_no_endon_death(_id_0E7867AE7BE357AD, ent);

  if(isDefined(_id_0E7860AE7BE34848))
    childthread waittill_string_no_endon_death(_id_0E7860AE7BE34848, ent);

  if(isDefined(_id_0E7861AE7BE34A7B))
    childthread waittill_string_no_endon_death(_id_0E7861AE7BE34A7B, ent);

  if(isDefined(_id_0E7862AE7BE34CAE))
    childthread waittill_string_no_endon_death(_id_0E7862AE7BE34CAE, ent);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

_id_5ADCA43F839A3CCE(_id_AB9868B0589A6052) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_AB9868B0589A6052.size - 1; _id_AC0E594AC96AA3A8++)
    self endon(_id_AB9868B0589A6052[_id_AC0E594AC96AA3A8]);

  self waittill(_id_AB9868B0589A6052[_id_AB9868B0589A6052.size - 1]);
}

waittill_any_in_array_return(_id_AB9868B0589A6052) {
  ent = spawnStruct();
  hasdeath = 0;

  foreach(string in _id_AB9868B0589A6052) {
    childthread waittill_string(string, ent);

    if(string == "death")
      hasdeath = 1;
  }

  if(!hasdeath)
    self endon("death");

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_in_array_return_no_endon_death(_id_AB9868B0589A6052) {
  ent = spawnStruct();

  foreach(string in _id_AB9868B0589A6052)
  childthread waittill_string_no_endon_death(string, ent);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_in_array_or_timeout(_id_AB9868B0589A6052, timeout) {
  ent = spawnStruct();
  hasdeath = 0;

  foreach(string in _id_AB9868B0589A6052) {
    childthread waittill_string(string, ent);

    if(string == "death")
      hasdeath = 1;
  }

  if(!hasdeath)
    self endon("death");

  ent childthread _id_2C91B6C857AA73CC(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_in_array_or_timeout_no_endon_death(_id_AB9868B0589A6052, timeout) {
  ent = spawnStruct();

  foreach(string in _id_AB9868B0589A6052)
  childthread waittill_string_no_endon_death(string, ent);

  ent thread _id_2C91B6C857AA73CC(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_all_in_array(_id_AB9868B0589A6052) {
  while(_id_AB9868B0589A6052.size) {
    msg = waittill_any_in_array_return(_id_AB9868B0589A6052);
    _id_AB9868B0589A6052 = array_remove(_id_AB9868B0589A6052, msg);
  }
}

waittill_any_timeout_1(timeout, _id_0E7865AE7BE35347) {
  if(!isDefined(_id_0E7865AE7BE35347) || _id_0E7865AE7BE35347 != "death")
    self endon("death");

  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string(_id_0E7865AE7BE35347, ent);

  ent childthread _id_2C91B6C857AA73CC(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_timeout_2(timeout, _id_0E7865AE7BE35347, _id_0E7866AE7BE3557A) {
  if((!isDefined(_id_0E7865AE7BE35347) || _id_0E7865AE7BE35347 != "death") && (!isDefined(_id_0E7866AE7BE3557A) || _id_0E7866AE7BE3557A != "death"))
    self endon("death");

  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_0E7866AE7BE3557A))
    childthread waittill_string(_id_0E7866AE7BE3557A, ent);

  ent childthread _id_2C91B6C857AA73CC(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_timeout_3(timeout, _id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD) {
  if((!isDefined(_id_0E7865AE7BE35347) || _id_0E7865AE7BE35347 != "death") && (!isDefined(_id_0E7866AE7BE3557A) || _id_0E7866AE7BE3557A != "death") && (!isDefined(_id_0E7867AE7BE357AD) || _id_0E7867AE7BE357AD != "death"))
    self endon("death");

  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_0E7866AE7BE3557A))
    childthread waittill_string(_id_0E7866AE7BE3557A, ent);

  if(isDefined(_id_0E7867AE7BE357AD))
    childthread waittill_string(_id_0E7867AE7BE357AD, ent);

  ent childthread _id_2C91B6C857AA73CC(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_timeout_4(timeout, _id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD, _id_0E7860AE7BE34848) {
  if((!isDefined(_id_0E7865AE7BE35347) || _id_0E7865AE7BE35347 != "death") && (!isDefined(_id_0E7866AE7BE3557A) || _id_0E7866AE7BE3557A != "death") && (!isDefined(_id_0E7867AE7BE357AD) || _id_0E7867AE7BE357AD != "death") && (!isDefined(_id_0E7860AE7BE34848) || _id_0E7860AE7BE34848 != "death"))
    self endon("death");

  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_0E7866AE7BE3557A))
    childthread waittill_string(_id_0E7866AE7BE3557A, ent);

  if(isDefined(_id_0E7867AE7BE357AD))
    childthread waittill_string(_id_0E7867AE7BE357AD, ent);

  if(isDefined(_id_0E7860AE7BE34848))
    childthread waittill_string(_id_0E7860AE7BE34848, ent);

  ent childthread _id_2C91B6C857AA73CC(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_timeout_5(timeout, _id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD, _id_0E7860AE7BE34848, _id_0E7861AE7BE34A7B) {
  if((!isDefined(_id_0E7865AE7BE35347) || _id_0E7865AE7BE35347 != "death") && (!isDefined(_id_0E7866AE7BE3557A) || _id_0E7866AE7BE3557A != "death") && (!isDefined(_id_0E7867AE7BE357AD) || _id_0E7867AE7BE357AD != "death") && (!isDefined(_id_0E7860AE7BE34848) || _id_0E7860AE7BE34848 != "death") && (!isDefined(_id_0E7861AE7BE34A7B) || _id_0E7861AE7BE34A7B != "death"))
    self endon("death");

  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_0E7866AE7BE3557A))
    childthread waittill_string(_id_0E7866AE7BE3557A, ent);

  if(isDefined(_id_0E7867AE7BE357AD))
    childthread waittill_string(_id_0E7867AE7BE357AD, ent);

  if(isDefined(_id_0E7860AE7BE34848))
    childthread waittill_string(_id_0E7860AE7BE34848, ent);

  if(isDefined(_id_0E7861AE7BE34A7B))
    childthread waittill_string(_id_0E7861AE7BE34A7B, ent);

  ent childthread _id_2C91B6C857AA73CC(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_timeout_6(timeout, _id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD, _id_0E7860AE7BE34848, _id_0E7861AE7BE34A7B, _id_0E7862AE7BE34CAE) {
  if((!isDefined(_id_0E7865AE7BE35347) || _id_0E7865AE7BE35347 != "death") && (!isDefined(_id_0E7866AE7BE3557A) || _id_0E7866AE7BE3557A != "death") && (!isDefined(_id_0E7867AE7BE357AD) || _id_0E7867AE7BE357AD != "death") && (!isDefined(_id_0E7860AE7BE34848) || _id_0E7860AE7BE34848 != "death") && (!isDefined(_id_0E7861AE7BE34A7B) || _id_0E7861AE7BE34A7B != "death") && (!isDefined(_id_0E7862AE7BE34CAE) || _id_0E7862AE7BE34CAE != "death"))
    self endon("death");

  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_0E7866AE7BE3557A))
    childthread waittill_string(_id_0E7866AE7BE3557A, ent);

  if(isDefined(_id_0E7867AE7BE357AD))
    childthread waittill_string(_id_0E7867AE7BE357AD, ent);

  if(isDefined(_id_0E7860AE7BE34848))
    childthread waittill_string(_id_0E7860AE7BE34848, ent);

  if(isDefined(_id_0E7861AE7BE34A7B))
    childthread waittill_string(_id_0E7861AE7BE34A7B, ent);

  if(isDefined(_id_0E7862AE7BE34CAE))
    childthread waittill_string(_id_0E7862AE7BE34CAE, ent);

  ent childthread _id_2C91B6C857AA73CC(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_timeout(timeout, _id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD, _id_0E7860AE7BE34848, _id_0E7861AE7BE34A7B, _id_0E7862AE7BE34CAE) {
  if((!isDefined(_id_0E7865AE7BE35347) || _id_0E7865AE7BE35347 != "death") && (!isDefined(_id_0E7866AE7BE3557A) || _id_0E7866AE7BE3557A != "death") && (!isDefined(_id_0E7867AE7BE357AD) || _id_0E7867AE7BE357AD != "death") && (!isDefined(_id_0E7860AE7BE34848) || _id_0E7860AE7BE34848 != "death") && (!isDefined(_id_0E7861AE7BE34A7B) || _id_0E7861AE7BE34A7B != "death") && (!isDefined(_id_0E7862AE7BE34CAE) || _id_0E7862AE7BE34CAE != "death"))
    self endon("death");

  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_0E7866AE7BE3557A))
    childthread waittill_string(_id_0E7866AE7BE3557A, ent);

  if(isDefined(_id_0E7867AE7BE357AD))
    childthread waittill_string(_id_0E7867AE7BE357AD, ent);

  if(isDefined(_id_0E7860AE7BE34848))
    childthread waittill_string(_id_0E7860AE7BE34848, ent);

  if(isDefined(_id_0E7861AE7BE34A7B))
    childthread waittill_string(_id_0E7861AE7BE34A7B, ent);

  if(isDefined(_id_0E7862AE7BE34CAE))
    childthread waittill_string(_id_0E7862AE7BE34CAE, ent);

  ent childthread _id_2C91B6C857AA73CC(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

_id_2C91B6C857AA73CC(delay) {
  self endon("die");
  wait(delay);
  self notify("returned", "timeout");
}

waittill_any_timeout_no_endon_death_1(timeout, _id_0E7865AE7BE35347) {
  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string_no_endon_death(_id_0E7865AE7BE35347, ent);

  ent childthread _id_2C91B6C857AA73CC(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_timeout_no_endon_death_2(timeout, _id_0E7865AE7BE35347, _id_0E7866AE7BE3557A) {
  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string_no_endon_death(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_0E7866AE7BE3557A))
    childthread waittill_string_no_endon_death(_id_0E7866AE7BE3557A, ent);

  ent childthread _id_2C91B6C857AA73CC(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_timeout_no_endon_death_3(timeout, _id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD) {
  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string_no_endon_death(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_0E7866AE7BE3557A))
    childthread waittill_string_no_endon_death(_id_0E7866AE7BE3557A, ent);

  if(isDefined(_id_0E7867AE7BE357AD))
    childthread waittill_string_no_endon_death(_id_0E7867AE7BE357AD, ent);

  ent childthread _id_2C91B6C857AA73CC(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_timeout_no_endon_death_4(timeout, _id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD, _id_0E7860AE7BE34848) {
  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string_no_endon_death(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_0E7866AE7BE3557A))
    childthread waittill_string_no_endon_death(_id_0E7866AE7BE3557A, ent);

  if(isDefined(_id_0E7867AE7BE357AD))
    childthread waittill_string_no_endon_death(_id_0E7867AE7BE357AD, ent);

  if(isDefined(_id_0E7860AE7BE34848))
    childthread waittill_string_no_endon_death(_id_0E7860AE7BE34848, ent);

  ent childthread _id_2C91B6C857AA73CC(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_timeout_no_endon_death_5(timeout, _id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD, _id_0E7860AE7BE34848, _id_0E7861AE7BE34A7B) {
  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string_no_endon_death(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_0E7866AE7BE3557A))
    childthread waittill_string_no_endon_death(_id_0E7866AE7BE3557A, ent);

  if(isDefined(_id_0E7867AE7BE357AD))
    childthread waittill_string_no_endon_death(_id_0E7867AE7BE357AD, ent);

  if(isDefined(_id_0E7860AE7BE34848))
    childthread waittill_string_no_endon_death(_id_0E7860AE7BE34848, ent);

  if(isDefined(_id_0E7861AE7BE34A7B))
    childthread waittill_string_no_endon_death(_id_0E7861AE7BE34A7B, ent);

  ent childthread _id_2C91B6C857AA73CC(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_timeout_no_endon_death(timeout, _id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD, _id_0E7860AE7BE34848, _id_0E7861AE7BE34A7B) {
  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread waittill_string_no_endon_death(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_0E7866AE7BE3557A))
    childthread waittill_string_no_endon_death(_id_0E7866AE7BE3557A, ent);

  if(isDefined(_id_0E7867AE7BE357AD))
    childthread waittill_string_no_endon_death(_id_0E7867AE7BE357AD, ent);

  if(isDefined(_id_0E7860AE7BE34848))
    childthread waittill_string_no_endon_death(_id_0E7860AE7BE34848, ent);

  if(isDefined(_id_0E7861AE7BE34A7B))
    childthread waittill_string_no_endon_death(_id_0E7861AE7BE34A7B, ent);

  ent childthread _id_2C91B6C857AA73CC(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_2(_id_0E7865AE7BE35347, _id_0E7866AE7BE3557A) {
  if(isDefined(_id_0E7866AE7BE3557A))
    self endon(_id_0E7866AE7BE3557A);

  self waittill(_id_0E7865AE7BE35347);
}

waittill_any_3(_id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD) {
  if(isDefined(_id_0E7866AE7BE3557A))
    self endon(_id_0E7866AE7BE3557A);

  if(isDefined(_id_0E7867AE7BE357AD))
    self endon(_id_0E7867AE7BE357AD);

  self waittill(_id_0E7865AE7BE35347);
}

waittill_any_4(_id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD, _id_0E7860AE7BE34848) {
  if(isDefined(_id_0E7866AE7BE3557A))
    self endon(_id_0E7866AE7BE3557A);

  if(isDefined(_id_0E7867AE7BE357AD))
    self endon(_id_0E7867AE7BE357AD);

  if(isDefined(_id_0E7860AE7BE34848))
    self endon(_id_0E7860AE7BE34848);

  self waittill(_id_0E7865AE7BE35347);
}

waittill_any_5(_id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD, _id_0E7860AE7BE34848, _id_0E7861AE7BE34A7B) {
  if(isDefined(_id_0E7866AE7BE3557A))
    self endon(_id_0E7866AE7BE3557A);

  if(isDefined(_id_0E7867AE7BE357AD))
    self endon(_id_0E7867AE7BE357AD);

  if(isDefined(_id_0E7860AE7BE34848))
    self endon(_id_0E7860AE7BE34848);

  if(isDefined(_id_0E7861AE7BE34A7B))
    self endon(_id_0E7861AE7BE34A7B);

  self waittill(_id_0E7865AE7BE35347);
}

waittill_any_6(_id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD, _id_0E7860AE7BE34848, _id_0E7861AE7BE34A7B, _id_0E7862AE7BE34CAE) {
  if(isDefined(_id_0E7866AE7BE3557A))
    self endon(_id_0E7866AE7BE3557A);

  if(isDefined(_id_0E7867AE7BE357AD))
    self endon(_id_0E7867AE7BE357AD);

  if(isDefined(_id_0E7860AE7BE34848))
    self endon(_id_0E7860AE7BE34848);

  if(isDefined(_id_0E7861AE7BE34A7B))
    self endon(_id_0E7861AE7BE34A7B);

  if(isDefined(_id_0E7862AE7BE34CAE))
    self endon(_id_0E7862AE7BE34CAE);

  self waittill(_id_0E7865AE7BE35347);
}

waittill_any_7(_id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD, _id_0E7860AE7BE34848, _id_0E7861AE7BE34A7B, _id_0E7862AE7BE34CAE, _id_0E7863AE7BE34EE1) {
  if(isDefined(_id_0E7866AE7BE3557A))
    self endon(_id_0E7866AE7BE3557A);

  if(isDefined(_id_0E7867AE7BE357AD))
    self endon(_id_0E7867AE7BE357AD);

  if(isDefined(_id_0E7860AE7BE34848))
    self endon(_id_0E7860AE7BE34848);

  if(isDefined(_id_0E7861AE7BE34A7B))
    self endon(_id_0E7861AE7BE34A7B);

  if(isDefined(_id_0E7862AE7BE34CAE))
    self endon(_id_0E7862AE7BE34CAE);

  if(isDefined(_id_0E7863AE7BE34EE1))
    self endon(_id_0E7863AE7BE34EE1);

  self waittill(_id_0E7865AE7BE35347);
}

waittill_any_8(_id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD, _id_0E7860AE7BE34848, _id_0E7861AE7BE34A7B, _id_0E7862AE7BE34CAE, _id_0E7863AE7BE34EE1, _id_0E785CAE7BE33F7C) {
  if(isDefined(_id_0E7866AE7BE3557A))
    self endon(_id_0E7866AE7BE3557A);

  if(isDefined(_id_0E7867AE7BE357AD))
    self endon(_id_0E7867AE7BE357AD);

  if(isDefined(_id_0E7860AE7BE34848))
    self endon(_id_0E7860AE7BE34848);

  if(isDefined(_id_0E7861AE7BE34A7B))
    self endon(_id_0E7861AE7BE34A7B);

  if(isDefined(_id_0E7862AE7BE34CAE))
    self endon(_id_0E7862AE7BE34CAE);

  if(isDefined(_id_0E7863AE7BE34EE1))
    self endon(_id_0E7863AE7BE34EE1);

  if(isDefined(_id_0E785CAE7BE33F7C))
    self endon(_id_0E785CAE7BE33F7C);

  self waittill(_id_0E7865AE7BE35347);
}

waittill_any(_id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD, _id_0E7860AE7BE34848, _id_0E7861AE7BE34A7B, _id_0E7862AE7BE34CAE, _id_0E7863AE7BE34EE1, _id_0E785CAE7BE33F7C) {
  if(isDefined(_id_0E7866AE7BE3557A))
    self endon(_id_0E7866AE7BE3557A);

  if(isDefined(_id_0E7867AE7BE357AD))
    self endon(_id_0E7867AE7BE357AD);

  if(isDefined(_id_0E7860AE7BE34848))
    self endon(_id_0E7860AE7BE34848);

  if(isDefined(_id_0E7861AE7BE34A7B))
    self endon(_id_0E7861AE7BE34A7B);

  if(isDefined(_id_0E7862AE7BE34CAE))
    self endon(_id_0E7862AE7BE34CAE);

  if(isDefined(_id_0E7863AE7BE34EE1))
    self endon(_id_0E7863AE7BE34EE1);

  if(isDefined(_id_0E785CAE7BE33F7C))
    self endon(_id_0E785CAE7BE33F7C);

  self waittill(_id_0E7865AE7BE35347);
}

waittill_any_two(_id_0E7865AE7BE35347, _id_0E7866AE7BE3557A) {
  if(isDefined(_id_0E7866AE7BE3557A))
    self endon(_id_0E7866AE7BE3557A);

  self waittill(_id_0E7865AE7BE35347);
}

waittill_any_ents(_id_6848D0559BA20855, _id_0E7865AE7BE35347, _id_6848CD559BA201BC, _id_0E7866AE7BE3557A, _id_6848CE559BA203EF, _id_0E7867AE7BE357AD, _id_6848CB559BA1FD56, _id_0E7860AE7BE34848, _id_6848CC559BA1FF89, _id_0E7861AE7BE34A7B, _id_6848C9559BA1F8F0, _id_0E7862AE7BE34CAE, _id_6848CA559BA1FB23, _id_0E7863AE7BE34EE1) {
  if(isDefined(_id_6848CD559BA201BC) && isDefined(_id_0E7866AE7BE3557A))
    _id_6848CD559BA201BC endon(_id_0E7866AE7BE3557A);

  if(isDefined(_id_6848CE559BA203EF) && isDefined(_id_0E7867AE7BE357AD))
    _id_6848CE559BA203EF endon(_id_0E7867AE7BE357AD);

  if(isDefined(_id_6848CB559BA1FD56) && isDefined(_id_0E7860AE7BE34848))
    _id_6848CB559BA1FD56 endon(_id_0E7860AE7BE34848);

  if(isDefined(_id_6848CC559BA1FF89) && isDefined(_id_0E7861AE7BE34A7B))
    _id_6848CC559BA1FF89 endon(_id_0E7861AE7BE34A7B);

  if(isDefined(_id_6848C9559BA1F8F0) && isDefined(_id_0E7862AE7BE34CAE))
    _id_6848C9559BA1F8F0 endon(_id_0E7862AE7BE34CAE);

  if(isDefined(_id_6848CA559BA1FB23) && isDefined(_id_0E7863AE7BE34EE1))
    _id_6848CA559BA1FB23 endon(_id_0E7863AE7BE34EE1);

  _id_6848D0559BA20855 waittill(_id_0E7865AE7BE35347);
}

_id_CF308F348D516C65(delay, _id_6848D0559BA20855, _id_0E7865AE7BE35347, _id_6848CD559BA201BC, _id_0E7866AE7BE3557A, _id_6848CE559BA203EF, _id_0E7867AE7BE357AD, _id_6848CB559BA1FD56, _id_0E7860AE7BE34848, _id_6848CC559BA1FF89, _id_0E7861AE7BE34A7B, _id_6848C9559BA1F8F0, _id_0E7862AE7BE34CAE, _id_6848CA559BA1FB23, _id_0E7863AE7BE34EE1) {
  _id_6848D0559BA20855 endon(_id_0E7865AE7BE35347);

  if(isDefined(_id_6848CD559BA201BC) && isDefined(_id_0E7866AE7BE3557A))
    _id_6848CD559BA201BC endon(_id_0E7866AE7BE3557A);

  if(isDefined(_id_6848CE559BA203EF) && isDefined(_id_0E7867AE7BE357AD))
    _id_6848CE559BA203EF endon(_id_0E7867AE7BE357AD);

  if(isDefined(_id_6848CB559BA1FD56) && isDefined(_id_0E7860AE7BE34848))
    _id_6848CB559BA1FD56 endon(_id_0E7860AE7BE34848);

  if(isDefined(_id_6848CC559BA1FF89) && isDefined(_id_0E7861AE7BE34A7B))
    _id_6848CC559BA1FF89 endon(_id_0E7861AE7BE34A7B);

  if(isDefined(_id_6848C9559BA1F8F0) && isDefined(_id_0E7862AE7BE34CAE))
    _id_6848C9559BA1F8F0 endon(_id_0E7862AE7BE34CAE);

  if(isDefined(_id_6848CA559BA1FB23) && isDefined(_id_0E7863AE7BE34EE1))
    _id_6848CA559BA1FB23 endon(_id_0E7863AE7BE34EE1);

  wait(delay);
}

waittill_any_ents_return(_id_6848D0559BA20855, _id_0E7865AE7BE35347, _id_6848CD559BA201BC, _id_0E7866AE7BE3557A, _id_6848CE559BA203EF, _id_0E7867AE7BE357AD, _id_6848CB559BA1FD56, _id_0E7860AE7BE34848, _id_6848CC559BA1FF89, _id_0E7861AE7BE34A7B, _id_6848C9559BA1F8F0, _id_0E7862AE7BE34CAE, _id_6848CA559BA1FB23, _id_0E7863AE7BE34EE1) {
  self endon("death");
  ent = spawnStruct();
  _id_6848D0559BA20855 childthread waittill_string(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_6848CD559BA201BC) && isDefined(_id_0E7866AE7BE3557A))
    _id_6848CD559BA201BC childthread waittill_string(_id_0E7866AE7BE3557A, ent);

  if(isDefined(_id_6848CE559BA203EF) && isDefined(_id_0E7867AE7BE357AD))
    _id_6848CE559BA203EF childthread waittill_string(_id_0E7867AE7BE357AD, ent);

  if(isDefined(_id_6848CB559BA1FD56) && isDefined(_id_0E7860AE7BE34848))
    _id_6848CB559BA1FD56 childthread waittill_string(_id_0E7860AE7BE34848, ent);

  if(isDefined(_id_6848CC559BA1FF89) && isDefined(_id_0E7861AE7BE34A7B))
    _id_6848CC559BA1FF89 childthread waittill_string(_id_0E7861AE7BE34A7B, ent);

  if(isDefined(_id_6848C9559BA1F8F0) && isDefined(_id_0E7862AE7BE34CAE))
    _id_6848C9559BA1F8F0 childthread waittill_string(_id_0E7862AE7BE34CAE, ent);

  if(isDefined(_id_6848CA559BA1FB23) && isDefined(_id_0E7863AE7BE34EE1))
    _id_6848CA559BA1FB23 childthread waittill_string(_id_0E7863AE7BE34EE1, ent);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

_id_7B9E0E7CA4B3B940(_id_6848D0559BA20855, _id_0E7865AE7BE35347, _id_6848CD559BA201BC, _id_0E7866AE7BE3557A, _id_6848CE559BA203EF, _id_0E7867AE7BE357AD, _id_6848CB559BA1FD56, _id_0E7860AE7BE34848, _id_6848CC559BA1FF89, _id_0E7861AE7BE34A7B, _id_6848C9559BA1F8F0, _id_0E7862AE7BE34CAE, _id_6848CA559BA1FB23, _id_0E7863AE7BE34EE1) {
  self endon("death");
  ent = spawnStruct();
  _id_6848D0559BA20855 childthread waittill_string_no_endon_death(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_6848CD559BA201BC) && isDefined(_id_0E7866AE7BE3557A))
    _id_6848CD559BA201BC childthread waittill_string_no_endon_death(_id_0E7866AE7BE3557A, ent);

  if(isDefined(_id_6848CE559BA203EF) && isDefined(_id_0E7867AE7BE357AD))
    _id_6848CE559BA203EF childthread waittill_string_no_endon_death(_id_0E7867AE7BE357AD, ent);

  if(isDefined(_id_6848CB559BA1FD56) && isDefined(_id_0E7860AE7BE34848))
    _id_6848CB559BA1FD56 childthread waittill_string_no_endon_death(_id_0E7860AE7BE34848, ent);

  if(isDefined(_id_6848CC559BA1FF89) && isDefined(_id_0E7861AE7BE34A7B))
    _id_6848CC559BA1FF89 childthread waittill_string_no_endon_death(_id_0E7861AE7BE34A7B, ent);

  if(isDefined(_id_6848C9559BA1F8F0) && isDefined(_id_0E7862AE7BE34CAE))
    _id_6848C9559BA1F8F0 childthread waittill_string_no_endon_death(_id_0E7862AE7BE34CAE, ent);

  if(isDefined(_id_6848CA559BA1FB23) && isDefined(_id_0E7863AE7BE34EE1))
    _id_6848CA559BA1FB23 childthread waittill_string_no_endon_death(_id_0E7863AE7BE34EE1, ent);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_ents_array(ents, _id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD, _id_0E7860AE7BE34848, _id_0E7861AE7BE34A7B, _id_0E7862AE7BE34CAE, _id_0E7863AE7BE34EE1) {
  foreach(ent in ents) {
    if(ent != ents[0])
      ent endon(_id_0E7865AE7BE35347);

    if(isDefined(_id_0E7866AE7BE3557A))
      ent endon(_id_0E7866AE7BE3557A);

    if(isDefined(_id_0E7867AE7BE357AD))
      ent endon(_id_0E7867AE7BE357AD);

    if(isDefined(_id_0E7860AE7BE34848))
      ent endon(_id_0E7860AE7BE34848);

    if(isDefined(_id_0E7861AE7BE34A7B))
      ent endon(_id_0E7861AE7BE34A7B);

    if(isDefined(_id_0E7862AE7BE34CAE))
      ent endon(_id_0E7862AE7BE34CAE);

    if(isDefined(_id_0E7863AE7BE34EE1))
      ent endon(_id_0E7863AE7BE34EE1);
  }

  ents[0] waittill(_id_0E7865AE7BE35347);
}

wait_time_in_ms(_id_8911F71726832879) {
  _id_754110404C0D574F = gettime() + _id_8911F71726832879;

  while(gettime() < _id_754110404C0D574F)
    waitframe();
}

script_delay() {
  if(isDefined(self.script_delay)) {
    wait(self.script_delay);
    return 1;
  } else if(isDefined(self.script_delay_min) && isDefined(self.script_delay_max)) {
    wait(randomfloatrange(self.script_delay_min, self.script_delay_max));
    return 1;
  }

  return 0;
}

script_wait() {
  starttime = gettime();

  if(isDefined(self.script_wait)) {
    wait(self.script_wait);

    if(isDefined(self.script_wait_add))
      self.script_wait = self.script_wait + self.script_wait_add;
  } else if(isDefined(self.script_wait_min) && isDefined(self.script_wait_max)) {
    wait(randomfloatrange(self.script_wait_min, self.script_wait_max));

    if(isDefined(self.script_wait_add)) {
      self.script_wait_min = self.script_wait_min + self.script_wait_add;
      self.script_wait_max = self.script_wait_max + self.script_wait_add;
    }
  }

  return gettime() - starttime;
}

_id_06C71C72547BB931(point) {
  _id_2649564EBA242B56 = [];
  return physics_querypoint(point, 0, physics_createcontents(["physicscontents_water"]), _id_2649564EBA242B56, "physicsquery_any");
}

isflashed() {
  if(!isDefined(self.flashendtime))
    return 0;

  return gettime() < self.flashendtime;
}

flag_exist(message) {
  if(!isDefined(level.flag))
    return 0;

  return isDefined(level.flag[message]);
}

flag(message) {
  return flag_exist(message) && level.flag[message];
}

flag_init(message) {
  if(!isDefined(level.flag))
    scripts\engine\flags::init_flags();

  level.flag[message] = 0;
  init_trigger_flags();

  if(!isDefined(level.trigger_flags[message]))
    level.trigger_flags[message] = [];
}

empty_init_func(empty) {}

flag_set(message, _id_AC9510CD03AF7E12) {
  if(!flag_exist(message))
    flag_init(message);

  level.flag[message] = 1;
  set_trigger_flag_permissions(message);

  if(isDefined(_id_AC9510CD03AF7E12))
    level notify(message, _id_AC9510CD03AF7E12);
  else
    level notify(message);
}

flag_wait(msg) {
  other = undefined;

  while(!flag(msg)) {
    other = undefined;
    level waittill(msg, other);
  }

  if(isDefined(other))
    return other;
}

flag_clear(message) {
  if(!flag(message)) {
    return;
  }
  level.flag[message] = 0;
  set_trigger_flag_permissions(message);
  level notify(message);
}

flag_waitopen(msg) {
  while(flag(msg))
    level waittill(msg);
}

waittill_either(_id_FBF2C60DF6D0D655, _id_FBF2C30DF6D0CFBC) {
  self endon(_id_FBF2C60DF6D0D655);
  self waittill(_id_FBF2C30DF6D0CFBC);
  return _id_FBF2C30DF6D0CFBC;
}

trigger_on(name, type) {
  if(isDefined(name) && isDefined(type)) {
    ents = getEntArray(name, type);
    array_thread(ents, ::trigger_on_proc);
  } else
    trigger_on_proc();
}

trigger_on_proc() {
  self triggerenable();
  self.trigger_off = undefined;
}

trigger_off(name, type) {
  if(isDefined(name) && isDefined(type)) {
    ents = getEntArray(name, type);
    array_thread(ents, ::trigger_off_proc);
  } else
    trigger_off_proc();
}

trigger_off_proc() {
  if(issubstr(self.classname, "trigger"))
    self triggerdisable();

  self.trigger_off = 1;
  self notify("trigger_off");
}

set_trigger_flag_permissions(msg) {
  if(!isDefined(level.trigger_flags)) {
    return;
  }
  level.trigger_flags[msg] = array_removeundefined(level.trigger_flags[msg]);
  array_thread(level.trigger_flags[msg], ::update_trigger_based_on_flags);
}

update_trigger_based_on_flags() {
  _id_E8CE0529F413D6AB = 1;

  if(isDefined(self.script_flag_true)) {
    _id_E8CE0529F413D6AB = 0;
    _id_67F14F8315CB0F2F = create_flags_and_return_tokens(self.script_flag_true);

    foreach(_id_E921CD2D3FB29B66 in _id_67F14F8315CB0F2F) {
      if(flag(_id_E921CD2D3FB29B66)) {
        _id_E8CE0529F413D6AB = 1;
        break;
      }
    }
  }

  _id_26505C7F46041D9C = 1;

  if(isDefined(self.script_flag_false)) {
    _id_67F14F8315CB0F2F = create_flags_and_return_tokens(self.script_flag_false);

    foreach(_id_E921CD2D3FB29B66 in _id_67F14F8315CB0F2F) {
      if(flag(_id_E921CD2D3FB29B66)) {
        _id_26505C7F46041D9C = 0;
        break;
      }
    }
  }

  [[level.trigger_func[_id_E8CE0529F413D6AB && _id_26505C7F46041D9C]]]();
}

create_flags_and_return_tokens(flags) {
  _id_67F14F8315CB0F2F = strtok(flags, " ");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_67F14F8315CB0F2F.size; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(level.flag[_id_67F14F8315CB0F2F[_id_AC0E594AC96AA3A8]]))
      flag_init(_id_67F14F8315CB0F2F[_id_AC0E594AC96AA3A8]);
  }

  return _id_67F14F8315CB0F2F;
}

init_trigger_flags() {
  if(!add_init_script("trigger_flags", ::init_trigger_flags)) {
    return;
  }
  level.trigger_flags = [];
  level.trigger_func[1] = ::trigger_on;
  level.trigger_func[0] = ::trigger_off;
}

_id_1F6C1A9B7564DC61(struct) {
  if(isDefined(struct.targetname)) {
    if(!isDefined(level.struct_class_names["targetname"][struct.targetname]))
      level.struct_class_names["targetname"][struct.targetname] = [];

    _id_A61C75B156FC1EE0 = level.struct_class_names["targetname"][struct.targetname].size;
    level.struct_class_names["targetname"][struct.targetname][_id_A61C75B156FC1EE0] = struct;
  }

  if(isDefined(struct.target)) {
    if(!isDefined(level.struct_class_names["target"][struct.target]))
      level.struct_class_names["target"][struct.target] = [];

    _id_A61C75B156FC1EE0 = level.struct_class_names["target"][struct.target].size;
    level.struct_class_names["target"][struct.target][_id_A61C75B156FC1EE0] = struct;
  }

  if(isDefined(struct.script_noteworthy)) {
    if(!isDefined(level.struct_class_names["script_noteworthy"][struct.script_noteworthy]))
      level.struct_class_names["script_noteworthy"][struct.script_noteworthy] = [];

    _id_A61C75B156FC1EE0 = level.struct_class_names["script_noteworthy"][struct.script_noteworthy].size;
    level.struct_class_names["script_noteworthy"][struct.script_noteworthy][_id_A61C75B156FC1EE0] = struct;
  }

  if(isDefined(struct.script_linkname)) {
    if(!isDefined(level.struct_class_names["script_linkname"][struct.script_linkname]))
      level.struct_class_names["script_linkname"][struct.script_linkname] = [];

    _id_A61C75B156FC1EE0 = level.struct_class_names["script_linkname"][struct.script_linkname].size;
    level.struct_class_names["script_linkname"][struct.script_linkname][_id_A61C75B156FC1EE0] = struct;
  }

  if(isDefined(struct._id_13DF181474836A29)) {
    if(!isDefined(level.struct_class_names["variantname"][struct._id_13DF181474836A29]))
      level.struct_class_names["variantname"][struct._id_13DF181474836A29] = [];

    _id_A61C75B156FC1EE0 = level.struct_class_names["variantname"][struct._id_13DF181474836A29].size;
    level.struct_class_names["variantname"][struct._id_13DF181474836A29][_id_A61C75B156FC1EE0] = struct;
  }
}

getStruct(name, type) {
  array = level.struct_class_names[type][name];

  if(!isDefined(array))
    return undefined;

  if(array.size > 1)
    return undefined;

  return array[0];
}

getStructArray(name, type) {
  if(!isDefined(level.struct_class_names))
    return [];

  if(!isDefined(type) || !isDefined(name))
    return [];

  array = level.struct_class_names[type][name];

  if(!isDefined(array))
    return [];

  return array;
}

add_smartobject_point(struct) {
  if(!isDefined(anim.smartobjectpoints))
    anim.smartobjectpoints = [];

  anim.smartobjectpoints[anim.smartobjectpoints.size] = struct;
  _id_EDCA2D230A0013AA = _func_6BF2B684ED87AD5E(struct.origin);

  if(!isDefined(_id_EDCA2D230A0013AA)) {
    return;
  }
  if(!isDefined(anim._id_463C0093DFF0F81C))
    anim._id_463C0093DFF0F81C = [];

  if(!isDefined(anim._id_463C0093DFF0F81C[_id_EDCA2D230A0013AA]))
    anim._id_463C0093DFF0F81C[_id_EDCA2D230A0013AA] = [];

  anim._id_463C0093DFF0F81C[_id_EDCA2D230A0013AA][anim._id_463C0093DFF0F81C[_id_EDCA2D230A0013AA].size] = struct;
}

store_linked_smartobjects() {
  if(!isDefined(anim.smartobjectpoints)) {
    return;
  }
  foreach(obj in anim.smartobjectpoints) {
    if(isDefined(obj.script_linkto)) {
      _id_9E4E1482CB40C9C5 = obj get_linked_structs();

      foreach(_id_FF1398C2BBAE4C1D in _id_9E4E1482CB40C9C5) {
        if(_id_FF1398C2BBAE4C1D == obj) {
          continue;
        }
        if(!isDefined(_id_FF1398C2BBAE4C1D.script_smartobject)) {
          continue;
        }
        if(!isDefined(obj.linkedsmartobjects))
          obj.linkedsmartobjects = [];

        obj.linkedsmartobjects[obj.linkedsmartobjects.size] = _id_FF1398C2BBAE4C1D;
      }
    }
  }
}

init_struct_class() {
  if(!add_init_script("struct_classes", ::init_struct_class)) {
    return;
  }
  level.struct_class_names = [];
  level.struct_class_names["target"] = [];
  level.struct_class_names["targetname"] = [];
  level.struct_class_names["script_noteworthy"] = [];
  level.struct_class_names["script_linkname"] = [];
  level.struct_class_names["variantname"] = [];
  level._id_AFB53D6348C4FC39 = [];
  level._id_D5043478289AF856 = [];
  level._id_F99B1D319E65854C = [];
  level._id_A0B4EB1703BE349A = [];
  _id_7DE0EFBF334063A9 = level.struct_filter;
  _id_C276B6AA8EB8993B = isDefined(_id_7DE0EFBF334063A9);

  foreach(index, struct in level.struct) {
    if(istrue(struct._id_D63B146DB6138E15)) {
      continue;
    }
    if(isDefined(struct.script_smartobject))
      add_smartobject_point(struct);

    if(_id_C276B6AA8EB8993B && ![[_id_7DE0EFBF334063A9]](struct)) {
      continue;
    }
    if(isDefined(struct.targetname) && struct.targetname == "delete_on_load") {
      continue;
    }
    if(isDefined(struct.script_prefab_exploder) || isDefined(struct.script_exploder))
      level._id_AFB53D6348C4FC39[level._id_AFB53D6348C4FC39.size] = struct;

    if(isDefined(struct.script_fakeactor_node))
      level._id_D5043478289AF856[level._id_D5043478289AF856.size] = struct;

    if(isDefined(struct._id_8AC77218F7A34E3E)) {
      level._id_F99B1D319E65854C[level._id_F99B1D319E65854C.size] = struct._id_8AC77218F7A34E3E;
      level._id_A0B4EB1703BE349A[level._id_A0B4EB1703BE349A.size] = struct;
    }

    _id_1F6C1A9B7564DC61(struct);
    level.struct[index] = undefined;
  }

  level.struct = undefined;

  if(isDefined(level._id_B32E30F2A469BC5C)) {
    level thread[[level._id_B32E30F2A469BC5C]]();
    level._id_B32E30F2A469BC5C = undefined;
  }

  store_linked_smartobjects();
}

deletestructarray(value, key, delay) {
  _id_9E4E1482CB40C9C5 = getStructArray(value, key);
  deletestructarray_ref(_id_9E4E1482CB40C9C5, delay);
}

deletestruct_ref(struct) {
  if(!isDefined(struct)) {
    return;
  }
  value = struct.script_linkname;

  if(isDefined(value) && isDefined(level.struct_class_names["script_linkname"]) && isDefined(level.struct_class_names["script_linkname"][value])) {
    foreach(_id_AC0E594AC96AA3A8, _id_77D5EB5728C83CAF in level.struct_class_names["script_linkname"][value]) {
      if(isDefined(_id_77D5EB5728C83CAF) && struct == _id_77D5EB5728C83CAF)
        level.struct_class_names["script_linkname"][value][_id_AC0E594AC96AA3A8] = undefined;
    }

    if(level.struct_class_names["script_linkname"][value].size == 0)
      level.struct_class_names["script_linkname"][value] = undefined;
  }

  value = struct.script_noteworthy;

  if(isDefined(value) && isDefined(level.struct_class_names["script_noteworthy"]) && isDefined(level.struct_class_names["script_noteworthy"][value])) {
    foreach(_id_AC0E594AC96AA3A8, _id_77D5EB5728C83CAF in level.struct_class_names["script_noteworthy"][value]) {
      if(isDefined(_id_77D5EB5728C83CAF) && struct == _id_77D5EB5728C83CAF)
        level.struct_class_names["script_noteworthy"][value][_id_AC0E594AC96AA3A8] = undefined;
    }

    if(level.struct_class_names["script_noteworthy"][value].size == 0)
      level.struct_class_names["script_noteworthy"][value] = undefined;
  }

  value = struct.target;

  if(isDefined(value) && isDefined(level.struct_class_names["target"]) && isDefined(level.struct_class_names["target"][value])) {
    foreach(_id_AC0E594AC96AA3A8, _id_77D5EB5728C83CAF in level.struct_class_names["target"][value]) {
      if(isDefined(_id_77D5EB5728C83CAF) && struct == _id_77D5EB5728C83CAF)
        level.struct_class_names["target"][value][_id_AC0E594AC96AA3A8] = undefined;
    }

    if(level.struct_class_names["target"][value].size == 0)
      level.struct_class_names["target"][value] = undefined;
  }

  value = struct.targetname;

  if(isDefined(value) && isDefined(level.struct_class_names["targetname"]) && isDefined(level.struct_class_names["targetname"][value])) {
    foreach(_id_AC0E594AC96AA3A8, _id_77D5EB5728C83CAF in level.struct_class_names["targetname"][value]) {
      if(isDefined(_id_77D5EB5728C83CAF) && struct == _id_77D5EB5728C83CAF)
        level.struct_class_names["targetname"][value][_id_AC0E594AC96AA3A8] = undefined;
    }

    if(level.struct_class_names["targetname"][value].size == 0)
      level.struct_class_names["targetname"][value] = undefined;
  }
}

deletestructarray_ref(_id_9E4E1482CB40C9C5, delay) {
  if(!isDefined(_id_9E4E1482CB40C9C5) || !isarray(_id_9E4E1482CB40C9C5) || _id_9E4E1482CB40C9C5.size == 0) {
    return;
  }
  delay = ter_op(isDefined(delay), delay, 0);
  delay = ter_op(delay > 0, delay, 0);

  if(delay > 0) {
    foreach(struct in _id_9E4E1482CB40C9C5) {
      deletestruct_ref(struct);
      wait(delay);
    }
  } else {
    foreach(struct in _id_9E4E1482CB40C9C5)
    deletestruct_ref(struct);
  }
}

getstructarray_delete(value, key, delay) {
  _id_9E4E1482CB40C9C5 = getStructArray(value, key);
  deletestructarray_ref(_id_9E4E1482CB40C9C5, delay);
  return _id_9E4E1482CB40C9C5;
}

getent_or_struct(name, key) {
  ent = getEnt(name, key);

  if(isDefined(ent))
    return ent;

  return getStruct(name, key);
}

fileprint_start(_id_65DC0399D91B7F97) {}

fileprint_map_start() {}

fileprint_map_header(_id_CC6395D01814CC20) {
  if(!isDefined(_id_CC6395D01814CC20))
    _id_CC6395D01814CC20 = 0;
}

fileprint_map_keypairprint(key1, key2) {}

fileprint_map_entity_start() {}

fileprint_map_entity_end() {}

fileprint_radiant_vec(_id_16290C9DDA466BCE) {}

call_on_notify_no_endon_death(notifystring, _id_3EAA9F644DBE7834, param1, param2) {
  childthread call_on_notify_proc(notifystring, _id_3EAA9F644DBE7834, param1, param2);
}

call_on_notify(notifystring, _id_3EAA9F644DBE7834, param1, param2, param3) {
  self endon("death");
  childthread call_on_notify_proc(notifystring, _id_3EAA9F644DBE7834, param1, param2, param3);
}

call_on_notify_proc(notifystring, _id_3EAA9F644DBE7834, param1, param2, param3) {
  self waittill(notifystring);

  if(isDefined(param3))
    self call[[_id_3EAA9F644DBE7834]](param1, param2, param3);
  else if(isDefined(param2))
    self call[[_id_3EAA9F644DBE7834]](param1, param2);
  else if(isDefined(param1))
    self call[[_id_3EAA9F644DBE7834]](param1);
  else
    self call[[_id_3EAA9F644DBE7834]]();
}

thread_on_notify_no_endon_death(notifystring, function, param1, param2, ent) {
  childthread thread_on_notify_proc(notifystring, function, param1, param2, ent);
}

thread_on_notify(notifystring, function, param1, param2, ent, _id_D136CF00DA26018C, _id_F63C23B8EC55B127) {
  self endon("death");

  if(isDefined(_id_D136CF00DA26018C) && isDefined(_id_F63C23B8EC55B127)) {
    if(!isarray(_id_D136CF00DA26018C))
      _id_D136CF00DA26018C = [_id_D136CF00DA26018C];

    if(!isarray(_id_F63C23B8EC55B127))
      _id_F63C23B8EC55B127 = [_id_F63C23B8EC55B127];

    foreach(entity in _id_D136CF00DA26018C) {
      foreach(message in _id_F63C23B8EC55B127)
      entity endon(message);
    }
  }

  childthread thread_on_notify_proc(notifystring, function, param1, param2, ent);
}

thread_on_notify_proc(notifystring, function, param1, param2, ent) {
  self waittill(notifystring);

  if(!isDefined(ent))
    ent = self;

  if(isDefined(param2))
    ent thread[[function]](param1, param2);
  else if(isDefined(param1))
    ent thread[[function]](param1);
  else
    ent thread[[function]]();
}

_id_FB7B452E8DD1DDDC(notifystring, function, params, ent, _id_D136CF00DA26018C, _id_F63C23B8EC55B127) {
  self endon("death");

  if(isDefined(_id_D136CF00DA26018C) && isDefined(_id_F63C23B8EC55B127)) {
    if(!isarray(_id_D136CF00DA26018C))
      _id_D136CF00DA26018C = [_id_D136CF00DA26018C];

    if(!isarray(_id_F63C23B8EC55B127))
      _id_F63C23B8EC55B127 = [_id_F63C23B8EC55B127];

    foreach(entity in _id_D136CF00DA26018C) {
      foreach(message in _id_F63C23B8EC55B127)
      entity endon(message);
    }
  }

  childthread _id_399A710B148277AD(notifystring, function, params, ent);
}

_id_399A710B148277AD(notifystring, function, params, ent) {
  self waittill(notifystring);

  if(!isDefined(ent))
    ent = self;

  if(!isDefined(params))
    ent thread[[function]]();

  switch (params.size) {
    case 0:
      ent thread[[function]]();
      break;
    case 1:
      ent thread[[function]](params[0]);
      break;
    case 2:
      ent thread[[function]](params[0], params[1]);
      break;
    case 3:
      ent thread[[function]](params[0], params[1], params[2]);
      break;
    case 4:
      ent thread[[function]](params[0], params[1], params[2], params[3]);
      break;
    case 5:
      ent thread[[function]](params[0], params[1], params[2], params[3], params[4]);
      break;
    case 6:
      ent thread[[function]](params[0], params[1], params[2], params[3], params[4], params[5]);
      break;
    case 7:
      ent thread[[function]](params[0], params[1], params[2], params[3], params[4], params[5], params[6]);
      break;
    default:
      break;
  }
}

delaycall(timer, func, param1, param2, param3, param4, param5, param6, param7, param8, _id_F3CB1651D632A555, _id_5A6A8AFA11882807, _id_5A6A89FA118825D4, _id_5A6A8CFA11882C6D) {
  thread delaycall_proc(func, undefined, timer, param1, param2, param3, param4, param5, param6, param7, param8, _id_F3CB1651D632A555, _id_5A6A8AFA11882807, _id_5A6A89FA118825D4, _id_5A6A8CFA11882C6D);
}

_id_AD9433AAB9FCDF04(timer, _id_92D54E0CCAE3B56D, func, param1, param2, param3, param4, param5, param6, param7, param8, _id_F3CB1651D632A555, _id_5A6A8AFA11882807, _id_5A6A89FA118825D4, _id_5A6A8CFA11882C6D) {
  thread delaycall_proc(func, _id_92D54E0CCAE3B56D, timer, param1, param2, param3, param4, param5, param6, param7, param8, _id_F3CB1651D632A555, _id_5A6A8AFA11882807, _id_5A6A89FA118825D4, _id_5A6A8CFA11882C6D);
}

delaycall_proc(func, _id_92D54E0CCAE3B56D, timer, param1, param2, param3, param4, param5, param6, param7, param8, _id_F3CB1651D632A555, _id_5A6A8AFA11882807, _id_5A6A89FA118825D4, _id_5A6A8CFA11882C6D) {
  if(scripts\common\utility::issp() || scripts\common\utility::iscp()) {
    self endon("death");
    self endon("stop_delay_call");
  }

  if(isDefined(_id_92D54E0CCAE3B56D)) {
    if(!isarray(_id_92D54E0CCAE3B56D))
      _id_92D54E0CCAE3B56D = [_id_92D54E0CCAE3B56D];

    foreach(_id_CB57658B734D4B0C in _id_92D54E0CCAE3B56D)
    self endon(_id_CB57658B734D4B0C);
  }

  wait(timer);

  if(isDefined(_id_5A6A8CFA11882C6D))
    self call[[func]](param1, param2, param3, param4, param5, param6, param7, param8, _id_F3CB1651D632A555, _id_5A6A8AFA11882807, _id_5A6A89FA118825D4, _id_5A6A8CFA11882C6D);
  else if(isDefined(_id_5A6A89FA118825D4))
    self call[[func]](param1, param2, param3, param4, param5, param6, param7, param8, _id_F3CB1651D632A555, _id_5A6A8AFA11882807, _id_5A6A89FA118825D4);
  else if(isDefined(_id_5A6A8AFA11882807))
    self call[[func]](param1, param2, param3, param4, param5, param6, param7, param8, _id_F3CB1651D632A555, _id_5A6A8AFA11882807);
  else if(isDefined(_id_F3CB1651D632A555))
    self call[[func]](param1, param2, param3, param4, param5, param6, param7, param8, _id_F3CB1651D632A555);
  else if(isDefined(param8))
    self call[[func]](param1, param2, param3, param4, param5, param6, param7, param8);
  else if(isDefined(param7))
    self call[[func]](param1, param2, param3, param4, param5, param6, param7);
  else if(isDefined(param6))
    self call[[func]](param1, param2, param3, param4, param5, param6);
  else if(isDefined(param5))
    self call[[func]](param1, param2, param3, param4, param5);
  else if(isDefined(param4))
    self call[[func]](param1, param2, param3, param4);
  else if(isDefined(param3))
    self call[[func]](param1, param2, param3);
  else if(isDefined(param2))
    self call[[func]](param1, param2);
  else if(isDefined(param1))
    self call[[func]](param1);
  else
    self call[[func]]();
}

string_starts_with(string, start) {
  if(string.size < start.size)
    return 0;

  _id_DEC9BCCE93873125 = getsubstr(string, 0, start.size);

  if(_id_DEC9BCCE93873125 == start)
    return 1;

  return 0;
}

_id_996B01CD49D0128D(_id_71648A34FA526B32, _id_53CA40AB574EE9B8) {
  _id_53CA40AB574EE9B8 = _id_53C4C53197386572(_id_53CA40AB574EE9B8, "");
  str = "";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_71648A34FA526B32.size - 1; _id_AC0E594AC96AA3A8++)
    str = str + (_id_71648A34FA526B32[_id_AC0E594AC96AA3A8] + _id_53CA40AB574EE9B8);

  return str + _id_71648A34FA526B32[_id_71648A34FA526B32.size - 1];
}

plot_points(_id_F3D241A00FB7C8A1, r, g, b, timer) {
  _id_B7AB7579B3C791B1 = _id_F3D241A00FB7C8A1[0];

  if(!isDefined(r))
    r = 1;

  if(!isDefined(g))
    g = 1;

  if(!isDefined(b))
    b = 1;

  if(!isDefined(timer))
    timer = 0.05;

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < _id_F3D241A00FB7C8A1.size; _id_AC0E594AC96AA3A8++) {
    thread draw_line_for_time(_id_B7AB7579B3C791B1, _id_F3D241A00FB7C8A1[_id_AC0E594AC96AA3A8], r, g, b, timer);
    _id_B7AB7579B3C791B1 = _id_F3D241A00FB7C8A1[_id_AC0E594AC96AA3A8];
  }
}

draw_line_for_time(_id_6C12713F33727294, org2, r, g, b, timer, notifystring) {
  if(isDefined(notifystring))
    level endon(notifystring);

  timer = gettime() + timer * 1000;

  while(gettime() < timer)
    wait 0.05;
}

draw_circle(center, radius, color, alpha, _id_FFB74DFE2FDAD3BE, duration) {
  _id_851DF4CD0132B5FA = 16;
  _id_7062EA7309FA49C4 = 360 / _id_851DF4CD0132B5FA;
  _id_8AF33769F877B5D6 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_851DF4CD0132B5FA; _id_AC0E594AC96AA3A8++) {
    angle = _id_7062EA7309FA49C4 * _id_AC0E594AC96AA3A8;
    _id_8A9F895755FD607E = cos(angle) * radius;
    _id_D867033AB311670B = sin(angle) * radius;
    x = center[0] + _id_8A9F895755FD607E;
    y = center[1] + _id_D867033AB311670B;
    z = center[2];
    _id_8AF33769F877B5D6[_id_8AF33769F877B5D6.size] = (x, y, z);
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8AF33769F877B5D6.size; _id_AC0E594AC96AA3A8++) {
    start = _id_8AF33769F877B5D6[_id_AC0E594AC96AA3A8];

    if(_id_AC0E594AC96AA3A8 + 1 >= _id_8AF33769F877B5D6.size) {
      end = _id_8AF33769F877B5D6[0];
      continue;
    }

    end = _id_8AF33769F877B5D6[_id_AC0E594AC96AA3A8 + 1];
  }
}

array_add(array, object) {
  array[array.size] = object;
  return array;
}

array_add_safe(array, object) {
  if(!isDefined(object))
    return array;

  if(!isDefined(array))
    array[0] = object;
  else
    array[array.size] = object;

  return array;
}

_id_6D6AF8144A5131F1(array, object) {
  array = _id_53C4C53197386572(array, []);

  if(!array_contains(array, object))
    array[array.size] = object;

  return array;
}

_id_3F20731855B91679(array, _id_010DD7119141CC69, _id_727636354DD7B7D2) {
  temp = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
    if(array[_id_AC0E594AC96AA3A8] == _id_010DD7119141CC69) {
      temp[_id_AC0E594AC96AA3A8] = _id_727636354DD7B7D2;
      continue;
    }

    temp[_id_AC0E594AC96AA3A8] = array[_id_AC0E594AC96AA3A8];
  }

  return temp;
}

array_delete(array) {
  foreach(ent in array) {
    if(isDefined(ent))
      ent delete();
  }
}

array_insert(array, object, index) {
  if(index == array.size) {
    temp = array;
    temp[temp.size] = object;
    return temp;
  }

  temp = [];
  offset = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
    if(_id_AC0E594AC96AA3A8 == index) {
      temp[_id_AC0E594AC96AA3A8] = object;
      offset = 1;
    }

    temp[_id_AC0E594AC96AA3A8 + offset] = array[_id_AC0E594AC96AA3A8];
  }

  return temp;
}

_id_EF4B3DF86351AA00(_id_4F6FF34F222B0271, _id_4F6FF04F222AFBD8, index) {
  _id_AC0E594AC96AA3A8 = _id_4F6FF34F222B0271.size + _id_4F6FF04F222AFBD8.size - 1;

  for(;;) {
    if(_id_AC0E594AC96AA3A8 < index + _id_4F6FF04F222AFBD8.size) {
      for(_id_AC0E5C4AC96AAA41 = _id_4F6FF04F222AFBD8.size - 1; _id_AC0E5C4AC96AAA41 >= 0; _id_AC0E5C4AC96AAA41--) {
        _id_4F6FF34F222B0271[_id_AC0E594AC96AA3A8] = _id_4F6FF04F222AFBD8[_id_AC0E5C4AC96AAA41];
        _id_AC0E594AC96AA3A8--;
      }

      return _id_4F6FF34F222B0271;
    }

    _id_4F6FF34F222B0271[_id_AC0E594AC96AA3A8] = _id_4F6FF34F222B0271[_id_AC0E594AC96AA3A8 - _id_4F6FF04F222AFBD8.size];
    _id_AC0E594AC96AA3A8--;
  }
}

array_combine(_id_4F6FF34F222B0271, _id_4F6FF04F222AFBD8, _id_4F6FF14F222AFE0B, _id_4F6FF64F222B090A, _id_4F6FF74F222B0B3D) {
  array = [];

  if(isDefined(_id_4F6FF34F222B0271)) {
    foreach(item in _id_4F6FF34F222B0271)
    array[array.size] = item;
  }

  if(isDefined(_id_4F6FF04F222AFBD8)) {
    foreach(item in _id_4F6FF04F222AFBD8)
    array[array.size] = item;
  }

  if(isDefined(_id_4F6FF14F222AFE0B)) {
    foreach(item in _id_4F6FF14F222AFE0B)
    array[array.size] = item;
  }

  if(isDefined(_id_4F6FF64F222B090A)) {
    foreach(item in _id_4F6FF64F222B090A)
    array[array.size] = item;
  }

  if(isDefined(_id_4F6FF74F222B0B3D)) {
    foreach(item in _id_4F6FF74F222B0B3D)
    array[array.size] = item;
  }

  return array;
}

array_combine_multiple(_id_C70B9ADBC218860A) {
  _id_C706ACDBC21284C9 = [];

  foreach(_id_8B462903A1F84F9C in _id_C70B9ADBC218860A) {
    foreach(item in _id_8B462903A1F84F9C)
    _id_C706ACDBC21284C9[_id_C706ACDBC21284C9.size] = item;
  }

  return _id_C706ACDBC21284C9;
}

array_combine_unique(_id_4F6FF34F222B0271, _id_4F6FF04F222AFBD8) {
  _id_4F6FF14F222AFE0B = [];

  foreach(item in _id_4F6FF34F222B0271)
  _id_4F6FF14F222AFE0B[_id_4F6FF14F222AFE0B.size] = item;

  foreach(item in _id_4F6FF04F222AFBD8) {
    if(array_contains(_id_4F6FF14F222AFE0B, item)) {
      continue;
    }
    _id_4F6FF14F222AFE0B[_id_4F6FF14F222AFE0B.size] = item;
  }

  return _id_4F6FF14F222AFE0B;
}

array_combine_unique_keys(_id_4F6FF34F222B0271, _id_4F6FF04F222AFBD8) {
  foreach(key, item in _id_4F6FF04F222AFBD8) {
    if(!isDefined(_id_4F6FF34F222B0271[key]))
      _id_4F6FF34F222B0271[key] = item;
  }

  return _id_4F6FF34F222B0271;
}

array_combine_non_integer_indices(_id_4F6FF34F222B0271, _id_4F6FF04F222AFBD8) {
  _id_4F6FF14F222AFE0B = [];

  foreach(index, item in _id_4F6FF34F222B0271)
  _id_4F6FF14F222AFE0B[index] = item;

  foreach(index, item in _id_4F6FF04F222AFBD8)
  _id_4F6FF14F222AFE0B[index] = item;

  return _id_4F6FF14F222AFE0B;
}

array_intersection(_id_4F6FF34F222B0271, _id_4F6FF04F222AFBD8) {
  _id_4F6FF14F222AFE0B = [];

  foreach(item in _id_4F6FF34F222B0271) {
    if(array_contains(_id_4F6FF04F222AFBD8, item))
      _id_4F6FF14F222AFE0B[_id_4F6FF14F222AFE0B.size] = item;
  }

  return _id_4F6FF14F222AFE0B;
}

array_difference(_id_4F6FF34F222B0271, _id_4F6FF04F222AFBD8) {
  _id_4F6FF14F222AFE0B = [];

  foreach(item in _id_4F6FF34F222B0271) {
    if(!array_contains(_id_4F6FF04F222AFBD8, item))
      _id_4F6FF14F222AFE0B[_id_4F6FF14F222AFE0B.size] = item;
  }

  return _id_4F6FF14F222AFE0B;
}

array_convert_keys_to_ints(array) {
  _id_8E3DCCABCE95E353 = [];

  foreach(item in array)
  _id_8E3DCCABCE95E353[_id_8E3DCCABCE95E353.size] = item;

  return _id_8E3DCCABCE95E353;
}

_id_7A2AAA4A09A4D250(array) {
  if(array.size > 0) {
    _id_4FBDB8A4C881D739 = randomint(array.size);
    return array[_id_4FBDB8A4C881D739];
  }

  return undefined;
}

array_randomize(array) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size - 1; _id_AC0E594AC96AA3A8++) {
    _id_AC0E5C4AC96AAA41 = randomintrange(_id_AC0E594AC96AA3A8, array.size);
    temp = array[_id_AC0E594AC96AA3A8];
    array[_id_AC0E594AC96AA3A8] = array[_id_AC0E5C4AC96AAA41];
    array[_id_AC0E5C4AC96AAA41] = temp;
  }

  return array;
}

array_randomize_objects(array) {
  _id_C2C83573883CBB37 = [];

  for(_id_50F783A5617F8940 = array; _id_50F783A5617F8940.size > 0; _id_50F783A5617F8940 = _id_BFC65A378A6D8EFE) {
    _id_610520BE555433B2 = randomintrange(0, _id_50F783A5617F8940.size);
    _id_BFC65A378A6D8EFE = [];
    _id_0D4F588E7361C391 = 0;

    foreach(key, object in _id_50F783A5617F8940) {
      if(_id_0D4F588E7361C391 == _id_610520BE555433B2)
        _id_C2C83573883CBB37[ter_op(isstring(key), key, _id_C2C83573883CBB37.size)] = object;
      else
        _id_BFC65A378A6D8EFE[ter_op(isstring(key), key, _id_BFC65A378A6D8EFE.size)] = object;

      _id_0D4F588E7361C391++;
    }
  }

  return _id_C2C83573883CBB37;
}

array_reverse(array) {
  _id_4F6FF04F222AFBD8 = [];

  for(_id_AC0E594AC96AA3A8 = array.size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--)
    _id_4F6FF04F222AFBD8[_id_4F6FF04F222AFBD8.size] = array[_id_AC0E594AC96AA3A8];

  return _id_4F6FF04F222AFBD8;
}

array_slice(array, _id_2F55781AF96F22F9, _id_8FA62807749C3F5A) {
  if(array.size <= 0)
    return [];

  if(!isDefined(_id_8FA62807749C3F5A) || _id_8FA62807749C3F5A > array.size)
    _id_8FA62807749C3F5A = array.size;

  if(_id_2F55781AF96F22F9 == 0 && _id_8FA62807749C3F5A == array.size)
    return array;

  _id_A8763F33264C3988 = [];

  for(index = _id_2F55781AF96F22F9; index < _id_8FA62807749C3F5A; index++)
    _id_A8763F33264C3988[_id_A8763F33264C3988.size] = array[index];

  return _id_A8763F33264C3988;
}

array_contains(array, compare) {
  if(array.size <= 0)
    return 0;

  foreach(_id_80EF668C09FFB70F in array) {
    if(_id_80EF668C09FFB70F == compare)
      return 1;
  }

  return 0;
}

array_contains_key(array, key) {
  return isDefined(array[key]);
}

array_find(array, item) {
  foreach(_id_FE8F7703F6313ED4, test in array) {
    if(test == item)
      return _id_FE8F7703F6313ED4;
  }

  return undefined;
}

array_remove(ents, _id_F7E215BD10CC45E9) {
  _id_D674D7970EEF9653 = [];

  foreach(ent in ents) {
    if(ent != _id_F7E215BD10CC45E9)
      _id_D674D7970EEF9653[_id_D674D7970EEF9653.size] = ent;
  }

  return _id_D674D7970EEF9653;
}

array_remove_array(ents, _id_8F445B88C8C227A3) {
  foreach(_id_F7E215BD10CC45E9 in _id_8F445B88C8C227A3)
  ents = array_remove(ents, _id_F7E215BD10CC45E9);

  return ents;
}

array_remove_index(array, index, _id_CA8B90CD9C832FD9) {
  _id_BFC65A378A6D8EFE = [];

  foreach(_id_109EBF347B2F2ECE, value in array) {
    if(_id_109EBF347B2F2ECE == index) {
      continue;
    }
    if(istrue(_id_CA8B90CD9C832FD9))
      _id_0C6B1A6D041F1309 = _id_109EBF347B2F2ECE;
    else
      _id_0C6B1A6D041F1309 = _id_BFC65A378A6D8EFE.size;

    _id_BFC65A378A6D8EFE[_id_0C6B1A6D041F1309] = value;
  }

  return _id_BFC65A378A6D8EFE;
}

array_removeundefined(array) {
  _id_BFC65A378A6D8EFE = [];

  foreach(_id_AC0E594AC96AA3A8, item in array) {
    if(!isDefined(item)) {
      continue;
    }
    _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = item;
  }

  return _id_BFC65A378A6D8EFE;
}

_id_FDC9D5557C53078E(array) {
  _id_BFC65A378A6D8EFE = [];

  foreach(_id_80EF668C09FFB70F in array) {
    if(!isDefined(_id_80EF668C09FFB70F) || !isalive(_id_80EF668C09FFB70F)) {
      continue;
    }
    _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = _id_80EF668C09FFB70F;
  }

  return _id_BFC65A378A6D8EFE;
}

array_removedead(array) {
  _id_BFC65A378A6D8EFE = [];

  foreach(_id_80EF668C09FFB70F in array) {
    if(!isalive(_id_80EF668C09FFB70F)) {
      continue;
    }
    _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = _id_80EF668C09FFB70F;
  }

  return _id_BFC65A378A6D8EFE;
}

array_remove_key(array, _id_B3E77F92460BE011) {
  _id_BFC65A378A6D8EFE = [];

  foreach(key, item in array) {
    if(_id_B3E77F92460BE011 == key) {
      continue;
    }
    _id_BFC65A378A6D8EFE[key] = item;
  }

  return _id_BFC65A378A6D8EFE;
}

array_remove_duplicates(array) {
  _id_DE1E630F4EA7F25C = [];

  foreach(item in array) {
    if(!isDefined(item)) {
      continue;
    }
    _id_583A3EE793DCF1C4 = 1;

    foreach(_id_87137DA4020A50A1 in _id_DE1E630F4EA7F25C) {
      if(item == _id_87137DA4020A50A1) {
        _id_583A3EE793DCF1C4 = 0;
        break;
      }
    }

    if(_id_583A3EE793DCF1C4)
      _id_DE1E630F4EA7F25C[_id_DE1E630F4EA7F25C.size] = item;
  }

  return _id_DE1E630F4EA7F25C;
}

array_get_first_item(array) {
  foreach(item in array)
  return item;

  return undefined;
}

_id_350E192B13BEA45C(array) {
  _id_58D9FC7EA764EECD = undefined;

  foreach(item in array)
  _id_58D9FC7EA764EECD = item;

  return _id_58D9FC7EA764EECD;
}

_id_57091B2D67654A14(array, _id_F7E215BD10CC45E9) {
  result = [];
  removed = 0;

  foreach(item in array_reverse(array)) {
    if(!removed && item == _id_F7E215BD10CC45E9) {
      removed = 1;
      continue;
    }

    result[result.size] = item;
  }

  return array_reverse(result);
}

array_levelthread(array, _id_FA89613ACD0EB87E, _id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B) {
  if(isDefined(_id_D2806825E4C8084B)) {
    foreach(ent in array)
    thread[[_id_FA89613ACD0EB87E]](ent, _id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B);

    return;
  }

  if(isDefined(_id_D2806725E4C80618)) {
    foreach(ent in array)
    thread[[_id_FA89613ACD0EB87E]](ent, _id_D2806A25E4C80CB1, _id_D2806725E4C80618);

    return;
  }

  if(isDefined(_id_D2806A25E4C80CB1)) {
    foreach(ent in array)
    thread[[_id_FA89613ACD0EB87E]](ent, _id_D2806A25E4C80CB1);

    return;
  }

  foreach(ent in array)
  thread[[_id_FA89613ACD0EB87E]](ent);
}

array_levelcall(array, _id_FA89613ACD0EB87E, _id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B) {
  if(isDefined(_id_D2806825E4C8084B)) {
    foreach(ent in array)
    call[[_id_FA89613ACD0EB87E]](ent, _id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B);

    return;
  }

  if(isDefined(_id_D2806725E4C80618)) {
    foreach(ent in array)
    call[[_id_FA89613ACD0EB87E]](ent, _id_D2806A25E4C80CB1, _id_D2806725E4C80618);

    return;
  }

  if(isDefined(_id_D2806A25E4C80CB1)) {
    foreach(ent in array)
    call[[_id_FA89613ACD0EB87E]](ent, _id_D2806A25E4C80CB1);

    return;
  }

  foreach(ent in array)
  call[[_id_FA89613ACD0EB87E]](ent);
}

array_sort_with_func(array, _id_D35FC50E2F1F14DF) {
  for(_id_AC0E5C4AC96AAA41 = 1; _id_AC0E5C4AC96AAA41 < array.size; _id_AC0E5C4AC96AAA41++) {
    key = array[_id_AC0E5C4AC96AAA41];

    for(_id_AC0E594AC96AA3A8 = _id_AC0E5C4AC96AAA41 - 1; _id_AC0E594AC96AA3A8 >= 0 && ![[_id_D35FC50E2F1F14DF]](array[_id_AC0E594AC96AA3A8], key); _id_AC0E594AC96AA3A8--)
      array[_id_AC0E594AC96AA3A8 + 1] = array[_id_AC0E594AC96AA3A8];

    array[_id_AC0E594AC96AA3A8 + 1] = key;
  }

  return array;
}

array_sort_by_script_index(array) {
  _id_8201C2D395D279D9 = [];

  for(index = 0; index < array.size; index++) {
    foreach(item in array) {
      if(is_equal(item.script_index, index))
        _id_8201C2D395D279D9 = array_add(_id_8201C2D395D279D9, item);
    }
  }

  _id_DFA02EACCC952A61 = array_remove_array(array, _id_8201C2D395D279D9);
  _id_8201C2D395D279D9 = array_combine(_id_8201C2D395D279D9, _id_DFA02EACCC952A61);
  return _id_8201C2D395D279D9;
}

array_average(array) {
  return array_sum(array) / array.size;
}

array_sum(array) {
  _id_BE66DE030B25508C = 0;

  foreach(item in array)
  _id_BE66DE030B25508C = _id_BE66DE030B25508C + item;

  return _id_BE66DE030B25508C;
}

array_divide(array, _id_F1563935AEEB5199) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++)
    array[_id_AC0E594AC96AA3A8] = array[_id_AC0E594AC96AA3A8] / _id_F1563935AEEB5199;

  return array;
}

create_deck(_id_4E30B77C0EE2F8AC, autoshuffle, _id_85DD38782CCC953E, prevent_redraw) {
  if(!isDefined(_id_4E30B77C0EE2F8AC))
    _id_4E30B77C0EE2F8AC = [];
  else if(!isarray(_id_4E30B77C0EE2F8AC))
    _id_4E30B77C0EE2F8AC = [_id_4E30B77C0EE2F8AC];

  _id_81A329728ABB79E4 = spawnStruct();
  _id_81A329728ABB79E4.items = [];
  _id_81A329728ABB79E4.index = 0;
  _id_81A329728ABB79E4.autoshuffle = !isDefined(autoshuffle) || autoshuffle;
  _id_81A329728ABB79E4.prevent_redraw = !isDefined(prevent_redraw) || prevent_redraw;

  foreach(item in _id_4E30B77C0EE2F8AC)
  _id_81A329728ABB79E4.items[_id_81A329728ABB79E4.items.size] = item;

  if(istrue(_id_85DD38782CCC953E))
    _id_81A329728ABB79E4 deck_shuffle();

  return _id_81A329728ABB79E4;
}

deck_draw() {
  _id_81A329728ABB79E4 = self;

  if(_id_81A329728ABB79E4.items.size == 0)
    return undefined;

  if(_id_81A329728ABB79E4.index >= _id_81A329728ABB79E4.items.size) {
    if(_id_81A329728ABB79E4.autoshuffle)
      _id_81A329728ABB79E4 deck_shuffle();
    else
      _id_81A329728ABB79E4.index = 0;
  }

  _id_34E4E8ECC5DB9E4B = _id_81A329728ABB79E4.items[_id_81A329728ABB79E4.index];
  _id_81A329728ABB79E4.index++;
  return _id_34E4E8ECC5DB9E4B;
}

deck_shuffle() {
  _id_81A329728ABB79E4 = self;

  if(_id_81A329728ABB79E4.index == 0 || !_id_81A329728ABB79E4.prevent_redraw || _id_81A329728ABB79E4.items.size <= 1) {
    _id_81A329728ABB79E4.items = array_randomize(_id_81A329728ABB79E4.items);
    _id_81A329728ABB79E4.index = 0;
    return;
  }

  _id_AC0E5C4AC96AAA41 = randomintrange(0, _id_81A329728ABB79E4.items.size - 1);

  if(_id_AC0E5C4AC96AAA41 == _id_81A329728ABB79E4.index - 1)
    _id_AC0E5C4AC96AAA41++;

  temp = _id_81A329728ABB79E4.items[0];
  _id_81A329728ABB79E4.items[0] = _id_81A329728ABB79E4.items[_id_AC0E5C4AC96AAA41];
  _id_81A329728ABB79E4.items[_id_AC0E5C4AC96AAA41] = temp;

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < _id_81A329728ABB79E4.items.size - 1; _id_AC0E594AC96AA3A8++) {
    _id_AC0E5C4AC96AAA41 = randomintrange(_id_AC0E594AC96AA3A8, _id_81A329728ABB79E4.items.size);
    temp = _id_81A329728ABB79E4.items[_id_AC0E594AC96AA3A8];
    _id_81A329728ABB79E4.items[_id_AC0E594AC96AA3A8] = _id_81A329728ABB79E4.items[_id_AC0E5C4AC96AAA41];
    _id_81A329728ABB79E4.items[_id_AC0E5C4AC96AAA41] = temp;
  }

  _id_81A329728ABB79E4.index = 0;
}

random(array) {
  _id_BFC65A378A6D8EFE = [];

  foreach(index, value in array)
  _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = value;

  if(!_id_BFC65A378A6D8EFE.size)
    return undefined;

  return _id_BFC65A378A6D8EFE[randomint(_id_BFC65A378A6D8EFE.size)];
}

_id_F1164393DAC4665A(array) {
  keys = getarraykeys(array);
  return random(keys);
}

_id_6E4039E57D0A3E7E(array, weights) {
  _id_D4B9E030F49735D5 = 0;

  foreach(value in weights)
  _id_D4B9E030F49735D5 = _id_D4B9E030F49735D5 + value;

  if(_id_D4B9E030F49735D5 == 0)
    return undefined;

  weight = randomint(_id_D4B9E030F49735D5);
  _id_F193D5E311236E6C = undefined;

  foreach(_id_AC0E594AC96AA3A8, value in array) {
    if(weight < weights[_id_AC0E594AC96AA3A8]) {
      _id_F193D5E311236E6C = value;
      break;
    } else
      weight = weight - weights[_id_AC0E594AC96AA3A8];
  }

  return _id_F193D5E311236E6C;
}

random_weight_sorted(array) {
  _id_BFC65A378A6D8EFE = [];

  foreach(index, value in array)
  _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = value;

  if(!_id_BFC65A378A6D8EFE.size)
    return undefined;

  _id_DDCCCBF258180536 = randomint(_id_BFC65A378A6D8EFE.size * _id_BFC65A378A6D8EFE.size);
  return _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size - 1 - int(sqrt(_id_DDCCCBF258180536))];
}

alphabetize(array) {
  if(array.size <= 1)
    return array;

  count = 0;

  for(_id_629422EF86DFD9E1 = array.size - 1; _id_629422EF86DFD9E1 >= 1; _id_629422EF86DFD9E1--) {
    _id_C29E520EFE22BBE7 = array[_id_629422EF86DFD9E1];
    _id_56120302DFEE9EED = _id_629422EF86DFD9E1;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_629422EF86DFD9E1; _id_AC0E594AC96AA3A8++) {
      _id_0E7865AE7BE35347 = array[_id_AC0E594AC96AA3A8];

      if(stricmp(_id_0E7865AE7BE35347, _id_C29E520EFE22BBE7) > 0) {
        _id_C29E520EFE22BBE7 = _id_0E7865AE7BE35347;
        _id_56120302DFEE9EED = _id_AC0E594AC96AA3A8;
      }
    }

    if(_id_56120302DFEE9EED != _id_629422EF86DFD9E1) {
      array[_id_56120302DFEE9EED] = array[_id_629422EF86DFD9E1];
      array[_id_629422EF86DFD9E1] = _id_C29E520EFE22BBE7;
    }
  }

  return array;
}

array_thread_amortized(entities, _id_FA89613ACD0EB87E, _id_B2F6E3841E5273BF, _id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117, _id_D2806125E4C7F8E6, _id_D2806225E4C7FB19) {
  thread _id_D049F2BD4E2B0918(entities, _id_FA89613ACD0EB87E, _id_B2F6E3841E5273BF, _id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117, _id_D2806125E4C7F8E6, _id_D2806225E4C7FB19);
}

_id_D049F2BD4E2B0918(entities, _id_FA89613ACD0EB87E, _id_B2F6E3841E5273BF, _id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117, _id_D2806125E4C7F8E6, _id_D2806225E4C7FB19) {
  if(!isDefined(_id_D2806A25E4C80CB1)) {
    foreach(ent in entities) {
      if(isai(ent) && !isalive(ent) || !isDefined(ent)) {
        continue;
      }
      ent thread[[_id_FA89613ACD0EB87E]]();
      wait(_id_B2F6E3841E5273BF);
    }
  } else {
    if(!isDefined(_id_D2806725E4C80618)) {
      foreach(ent in entities) {
        if(isai(ent) && !isalive(ent) || !isDefined(ent)) {
          continue;
        }
        ent thread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1);
        wait(_id_B2F6E3841E5273BF);
      }

      return;
    }

    if(!isDefined(_id_D2806825E4C8084B)) {
      foreach(ent in entities) {
        if(isai(ent) && !isalive(ent) || !isDefined(ent)) {
          continue;
        }
        ent thread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618);
        wait(_id_B2F6E3841E5273BF);
      }

      return;
    }

    if(!isDefined(_id_D2806D25E4C8134A)) {
      foreach(ent in entities) {
        if(isai(ent) && !isalive(ent) || !isDefined(ent)) {
          continue;
        }
        ent thread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B);
        wait(_id_B2F6E3841E5273BF);
      }

      return;
    }

    if(!isDefined(_id_D2806E25E4C8157D)) {
      foreach(ent in entities) {
        if(isai(ent) && !isalive(ent) || !isDefined(ent)) {
          continue;
        }
        ent thread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A);
        wait(_id_B2F6E3841E5273BF);
      }

      return;
    }

    if(!isDefined(_id_D2806B25E4C80EE4)) {
      foreach(ent in entities) {
        if(isai(ent) && !isalive(ent) || !isDefined(ent)) {
          continue;
        }
        ent thread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D);
        wait(_id_B2F6E3841E5273BF);
      }

      return;
    }

    if(!isDefined(_id_D2806C25E4C81117)) {
      foreach(ent in entities) {
        if(isai(ent) && !isalive(ent) || !isDefined(ent)) {
          continue;
        }
        ent thread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4);
        wait(_id_B2F6E3841E5273BF);
      }

      return;
    }

    if(!isDefined(_id_D2806125E4C7F8E6)) {
      foreach(ent in entities) {
        if(isai(ent) && !isalive(ent) || !isDefined(ent)) {
          continue;
        }
        ent thread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117);
        wait(_id_B2F6E3841E5273BF);
      }

      return;
    }

    if(!isDefined(_id_D2806225E4C7FB19)) {
      foreach(ent in entities) {
        if(isai(ent) && !isalive(ent) || !isDefined(ent)) {
          continue;
        }
        ent thread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117, _id_D2806125E4C7F8E6);
        wait(_id_B2F6E3841E5273BF);
      }

      return;
    }

    foreach(ent in entities) {
      if(isai(ent) && !isalive(ent) || !isDefined(ent)) {
        continue;
      }
      ent thread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117, _id_D2806125E4C7F8E6, _id_D2806225E4C7FB19);
      wait(_id_B2F6E3841E5273BF);
    }
  }
}

array_thread(entities, _id_FA89613ACD0EB87E, _id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117, _id_D2806125E4C7F8E6, _id_D2806225E4C7FB19) {
  if(isDefined(_id_D2806225E4C7FB19)) {
    foreach(ent in entities)
    ent thread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117, _id_D2806125E4C7F8E6, _id_D2806225E4C7FB19);

    return;
  }

  if(isDefined(_id_D2806125E4C7F8E6)) {
    foreach(ent in entities)
    ent thread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117, _id_D2806125E4C7F8E6);

    return;
  }

  if(isDefined(_id_D2806C25E4C81117)) {
    foreach(ent in entities)
    ent thread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117);

    return;
  }

  if(isDefined(_id_D2806B25E4C80EE4)) {
    foreach(ent in entities)
    ent thread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4);

    return;
  }

  if(isDefined(_id_D2806E25E4C8157D)) {
    foreach(ent in entities)
    ent thread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D);

    return;
  }

  if(isDefined(_id_D2806D25E4C8134A)) {
    foreach(ent in entities)
    ent thread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A);

    return;
  }

  if(isDefined(_id_D2806825E4C8084B)) {
    foreach(ent in entities)
    ent thread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B);

    return;
  }

  if(isDefined(_id_D2806725E4C80618)) {
    foreach(ent in entities)
    ent thread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618);

    return;
  }

  if(isDefined(_id_D2806A25E4C80CB1)) {
    foreach(ent in entities)
    ent thread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1);

    return;
  }

  foreach(ent in entities)
  ent thread[[_id_FA89613ACD0EB87E]]();
}

_id_9B971E1BC95BC1DF(entities, _id_FA89613ACD0EB87E, _id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117, _id_D2806125E4C7F8E6, _id_D2806225E4C7FB19) {
  if(isDefined(_id_D2806225E4C7FB19)) {
    foreach(ent in entities)
    ent childthread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117, _id_D2806125E4C7F8E6, _id_D2806225E4C7FB19);

    return;
  }

  if(isDefined(_id_D2806125E4C7F8E6)) {
    foreach(ent in entities)
    ent childthread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117, _id_D2806125E4C7F8E6);

    return;
  }

  if(isDefined(_id_D2806C25E4C81117)) {
    foreach(ent in entities)
    ent childthread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117);

    return;
  }

  if(isDefined(_id_D2806B25E4C80EE4)) {
    foreach(ent in entities)
    ent childthread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4);

    return;
  }

  if(isDefined(_id_D2806E25E4C8157D)) {
    foreach(ent in entities)
    ent childthread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D);

    return;
  }

  if(isDefined(_id_D2806D25E4C8134A)) {
    foreach(ent in entities)
    ent childthread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A);

    return;
  }

  if(isDefined(_id_D2806825E4C8084B)) {
    foreach(ent in entities)
    ent childthread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B);

    return;
  }

  if(isDefined(_id_D2806725E4C80618)) {
    foreach(ent in entities)
    ent childthread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618);

    return;
  }

  if(isDefined(_id_D2806A25E4C80CB1)) {
    foreach(ent in entities)
    ent childthread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1);

    return;
  }

  foreach(ent in entities)
  ent childthread[[_id_FA89613ACD0EB87E]]();
}

array_call(entities, _id_FA89613ACD0EB87E, _id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117, _id_D2806125E4C7F8E6) {
  if(isDefined(_id_D2806125E4C7F8E6)) {
    foreach(ent in entities)
    ent call[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117, _id_D2806125E4C7F8E6);

    return;
  }

  if(isDefined(_id_D2806C25E4C81117)) {
    foreach(ent in entities)
    ent call[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117);

    return;
  }

  if(isDefined(_id_D2806B25E4C80EE4)) {
    foreach(ent in entities)
    ent call[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4);

    return;
  }

  if(isDefined(_id_D2806E25E4C8157D)) {
    foreach(ent in entities)
    ent call[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D);

    return;
  }

  if(isDefined(_id_D2806D25E4C8134A)) {
    foreach(ent in entities)
    ent call[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A);

    return;
  }

  if(isDefined(_id_D2806825E4C8084B)) {
    foreach(ent in entities)
    ent call[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B);

    return;
  }

  if(isDefined(_id_D2806725E4C80618)) {
    foreach(ent in entities)
    ent call[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618);

    return;
  }

  if(isDefined(_id_D2806A25E4C80CB1)) {
    foreach(ent in entities)
    ent call[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1);

    return;
  }

  foreach(ent in entities)
  ent call[[_id_FA89613ACD0EB87E]]();
}

flat_angle(angle) {
  _id_896A9D735CC02614 = (0, angle[1], 0);
  return _id_896A9D735CC02614;
}

flat_origin(org) {
  _id_E2D5C1C592830F55 = (org[0], org[1], 0);
  return _id_E2D5C1C592830F55;
}

flatten_vector(_id_CC24231B0F3F7333, _id_C351A25DB18897AE) {
  if(!isDefined(_id_C351A25DB18897AE))
    _id_C351A25DB18897AE = (0, 0, 1);

  _id_1A5CB4A628237AE7 = vectorNormalize(_id_CC24231B0F3F7333 - vectordot(_id_C351A25DB18897AE, _id_CC24231B0F3F7333) * _id_C351A25DB18897AE);
  return _id_1A5CB4A628237AE7;
}

draw_arrow_time(start, end, color, duration, notifystring) {
  if(isDefined(notifystring))
    level endon(notifystring);

  level endon("newpath");
  _id_B1A9C30302753C02 = [];
  angles = vectortoangles(start - end);
  right = anglestoright(angles);
  forward = anglesToForward(angles);
  up = anglestoup(angles);
  dist = distance(start, end);
  _id_C83AA9DBC3654AFA = [];
  range = 0.1;
  _id_C83AA9DBC3654AFA[0] = start;
  _id_C83AA9DBC3654AFA[1] = start + right * (dist * range) + forward * (dist * -0.1);
  _id_C83AA9DBC3654AFA[2] = end;
  _id_C83AA9DBC3654AFA[3] = start + right * (dist * (-1 * range)) + forward * (dist * -0.1);
  _id_C83AA9DBC3654AFA[4] = start;
  _id_C83AA9DBC3654AFA[5] = start + up * (dist * range) + forward * (dist * -0.1);
  _id_C83AA9DBC3654AFA[6] = end;
  _id_C83AA9DBC3654AFA[7] = start + up * (dist * (-1 * range)) + forward * (dist * -0.1);
  _id_C83AA9DBC3654AFA[8] = start;
  r = color[0];
  g = color[1];
  b = color[2];
  plot_points(_id_C83AA9DBC3654AFA, r, g, b, duration);
}

draw_arrow(start, end, color) {
  level endon("newpath");
  _id_B1A9C30302753C02 = [];
  angles = vectortoangles(start - end);
  right = anglestoright(angles);
  forward = anglesToForward(angles);
  dist = distance(start, end);
  _id_C83AA9DBC3654AFA = [];
  range = 0.05;
  _id_C83AA9DBC3654AFA[0] = start;
  _id_C83AA9DBC3654AFA[1] = start + right * (dist * range) + forward * (dist * -0.2);
  _id_C83AA9DBC3654AFA[2] = end;
  _id_C83AA9DBC3654AFA[3] = start + right * (dist * (-1 * range)) + forward * (dist * -0.2);

  for(_id_AC0E424AC96A7113 = 0; _id_AC0E424AC96A7113 < 4; _id_AC0E424AC96A7113++) {
    nextpoint = _id_AC0E424AC96A7113 + 1;

    if(nextpoint >= 4)
      nextpoint = 0;
  }
}

draw_capsule(pos, radius, height, angles, color, _id_FFB74DFE2FDAD3BE, duration) {
  if(!isDefined(angles))
    angles = (0, 0, 0);

  if(!isDefined(_id_FFB74DFE2FDAD3BE))
    _id_FFB74DFE2FDAD3BE = 0;

  if(!isDefined(duration))
    duration = 1;

  forward = anglesToForward(angles);
  right = anglestoright(angles);
  up = anglestoup(angles);
  _id_7DC73E992D2BA545 = pos + up * radius;
  _id_622E4DC32DD8DABB = pos + up * height;
  _id_622E4DC32DD8DABB = _id_622E4DC32DD8DABB - up * radius;
  _id_0E3E4708F2B15CDC = _id_7DC73E992D2BA545 + forward * radius;
  _id_C082CAFEFE1BE9E0 = _id_622E4DC32DD8DABB + forward * radius;
  _id_35E9E473F5743470 = _id_7DC73E992D2BA545 - forward * radius;
  _id_F06F5503D572A834 = _id_622E4DC32DD8DABB - forward * radius;
  _id_154FC976C8007720 = _id_7DC73E992D2BA545 + right * radius;
  _id_C826CF340204F3E4 = _id_622E4DC32DD8DABB + right * radius;
  _id_29521623860703FA = _id_7DC73E992D2BA545 - right * radius;
  _id_2BC57F4BB1103296 = _id_622E4DC32DD8DABB - right * radius;
}

draw_character_capsule(color, _id_FFB74DFE2FDAD3BE, duration) {
  _id_3AC658A13FFCBFB5 = self physics_getcharactercollisioncapsule();
  draw_capsule(self getorigin(), _id_3AC658A13FFCBFB5["radius"], _id_3AC658A13FFCBFB5["half_height"] * 2, self.angles, color, _id_FFB74DFE2FDAD3BE, duration);
}

draw_player_capsule(color, _id_FFB74DFE2FDAD3BE, duration) {
  _id_3AC658A13FFCBFB5 = self physics_getcharactercollisioncapsule();
  draw_capsule(self getorigin(), _id_3AC658A13FFCBFB5["radius"], _id_3AC658A13FFCBFB5["half_height"] * 2, self getplayerangles(), color, _id_FFB74DFE2FDAD3BE, duration);
}

draw_ent_bone_forever(_id_B9D211537F4F230F, _id_E0B935B0C281315B) {
  self endon("stop_drawing_axis");
  self endon("death");

  for(;;) {
    _id_6768E6A26FFF835E = self gettagorigin(_id_B9D211537F4F230F);
    _id_4D6C1D9AEE8512F4 = self gettagangles(_id_B9D211537F4F230F);
    draw_angles(_id_4D6C1D9AEE8512F4, _id_6768E6A26FFF835E, _id_E0B935B0C281315B);
    waitframe();
  }
}

draw_ent_axis_forever(_id_E0B935B0C281315B, scale) {
  self endon("stop_drawing_axis");
  self endon("death");

  for(;;) {
    draw_ent_axis(_id_E0B935B0C281315B, undefined, scale);
    waitframe();
  }
}

draw_tag_axis_forever(tag, _id_E0B935B0C281315B, scale) {
  self endon("stop_drawing_axis");
  self endon("death");

  for(;;) {
    draw_tag_axis(tag, _id_E0B935B0C281315B, undefined, scale);
    waitframe();
  }
}

draw_ent_axis(_id_E0B935B0C281315B, duration, scale) {
  waittillframeend;

  if(isDefined(self.angles))
    angles = self.angles;
  else
    angles = (0, 0, 0);

  draw_angles(angles, self.origin, _id_E0B935B0C281315B, duration, scale);
}

draw_tag_axis(tag, _id_E0B935B0C281315B, duration, scale) {
  waittillframeend;
  angles = self gettagangles(tag);
  origin = self gettagorigin(tag);
  draw_angles(angles, origin, _id_E0B935B0C281315B, duration, scale);
}

draw_angles(angles, origin, _id_E0B935B0C281315B, duration, scale) {
  waittillframeend;
  forward = anglesToForward(angles);
  right = anglestoright(angles);
  up = anglestoup(angles);

  if(!isDefined(_id_E0B935B0C281315B))
    _id_E0B935B0C281315B = (1, 0, 1);

  if(!isDefined(duration))
    duration = 1;

  if(!isDefined(scale))
    scale = 10;
}

draw_entity_bounds(ent, _id_201CFE915C2EA802, color, _id_5EE177E3A31CA5CA, _id_D88C48911F4BF6A0) {
  if(!isDefined(color))
    color = (0, 1, 0);

  if(!isDefined(_id_5EE177E3A31CA5CA))
    _id_5EE177E3A31CA5CA = 0;

  if(!isDefined(_id_D88C48911F4BF6A0))
    _id_D88C48911F4BF6A0 = level.framedurationseconds;

  if(_id_5EE177E3A31CA5CA)
    _id_4E7F34CEC022D55A = int(_id_D88C48911F4BF6A0 / level.framedurationseconds);
  else
    _id_4E7F34CEC022D55A = int(_id_201CFE915C2EA802 / level.framedurationseconds);

  _id_1D29919376AD4830 = [];
  _id_1D29949376AD4EC9 = [];
  current = gettime();

  for(end = current + _id_201CFE915C2EA802 * 1000; current < end && isDefined(ent); current = gettime()) {
    _id_1D29919376AD4830[0] = ent getpointinbounds(1, 1, 1);
    _id_1D29919376AD4830[1] = ent getpointinbounds(1, 1, -1);
    _id_1D29919376AD4830[2] = ent getpointinbounds(-1, 1, -1);
    _id_1D29919376AD4830[3] = ent getpointinbounds(-1, 1, 1);
    _id_1D29949376AD4EC9[0] = ent getpointinbounds(1, -1, 1);
    _id_1D29949376AD4EC9[1] = ent getpointinbounds(1, -1, -1);
    _id_1D29949376AD4EC9[2] = ent getpointinbounds(-1, -1, -1);
    _id_1D29949376AD4EC9[3] = ent getpointinbounds(-1, -1, 1);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
      _id_AC0E5C4AC96AAA41 = _id_AC0E594AC96AA3A8 + 1;

      if(_id_AC0E5C4AC96AAA41 == 4)
        _id_AC0E5C4AC96AAA41 = 0;
    }

    if(!_id_5EE177E3A31CA5CA) {
      return;
    }
    wait(_id_D88C48911F4BF6A0);
  }
}

getfx(fx) {
  return level._effect[fx];
}

fxexists(fx) {
  return isDefined(level._effect[fx]);
}

playerunlimitedammothread() {}

spawn_tag_origin(org, _id_8BC14603A27FA3E7) {
  if(!isDefined(_id_8BC14603A27FA3E7) && isDefined(self.angles))
    _id_8BC14603A27FA3E7 = self.angles;

  if(!isDefined(org) && isDefined(self.origin))
    org = self.origin;
  else if(!isDefined(org))
    org = (0, 0, 0);

  tag_origin = spawn("script_model", org);
  tag_origin setModel("tag_origin");
  tag_origin hide();

  if(isDefined(_id_8BC14603A27FA3E7))
    tag_origin.angles = _id_8BC14603A27FA3E7;

  return tag_origin;
}

waittill_notify_or_timeout(msg, timer) {
  self endon(msg);
  wait(timer);
}

waittill_notify_or_timeout_return(notifymessage, timer) {
  _id_624F473FE3EE62F1 = spawnStruct();
  thread waittill_notify_proc(_id_624F473FE3EE62F1, notifymessage);
  thread waittill_timeout_proc(_id_624F473FE3EE62F1, timer);
  _id_624F473FE3EE62F1 waittill("waittill_proc", result);
  return result;
}

waittill_notify_proc(_id_624F473FE3EE62F1, notifymessage) {
  _id_624F473FE3EE62F1 endon("waittill_proc");
  self waittill(notifymessage);
  _id_624F473FE3EE62F1 notify("waittill_proc", notifymessage);
}

waittill_timeout_proc(_id_624F473FE3EE62F1, timeout) {
  _id_624F473FE3EE62F1 endon("waittill_proc");
  wait(timeout);
  _id_624F473FE3EE62F1 notify("waittill_proc", "timeout");
}

waittill_notify_and_time(msg, time) {
  starttime = gettime();
  self waittill(msg);
  endtime = starttime + time * 1000;
  _id_8DD9F2EB8215A139 = endtime - starttime;

  if(_id_8DD9F2EB8215A139 > 0) {
    waittime = _id_8DD9F2EB8215A139 / 1000.0;
    wait(waittime);
  }
}

array_wait(array, message, timeout) {
  _id_624F473FE3EE62F1 = spawnStruct();

  if(istrue(timeout)) {
    thread array_wait_timeout_proc(_id_624F473FE3EE62F1, timeout);
    _id_624F473FE3EE62F1 endon("array_wait_timeout");
  }

  foreach(_id_F7806D4CF24AACD3 in array)
  thread array_wait_proc(_id_624F473FE3EE62F1, _id_F7806D4CF24AACD3, message);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++)
    _id_624F473FE3EE62F1 waittill("array_wait_proc");

  _id_624F473FE3EE62F1 notify("array_wait_success");
}

array_wait_proc(_id_624F473FE3EE62F1, _id_F7806D4CF24AACD3, message) {
  _id_624F473FE3EE62F1 endon("array_wait_success");
  _id_F7806D4CF24AACD3 waittill_any_2(message, "death");
  _id_624F473FE3EE62F1 notify("array_wait_proc");
}

array_wait_timeout_proc(_id_624F473FE3EE62F1, timeout) {
  _id_624F473FE3EE62F1 endon("array_wait_success");
  wait(timeout);
  _id_624F473FE3EE62F1 notify("array_wait_timeout");
}

array_any_wait(array, message) {
  _id_624F473FE3EE62F1 = spawnStruct();

  foreach(_id_F7806D4CF24AACD3 in array)
  thread array_any_wait_proc(_id_624F473FE3EE62F1, _id_F7806D4CF24AACD3, message);

  _id_624F473FE3EE62F1 waittill("array_wait_proc", result);
  return result;
}

array_any_wait_timeout(array, message, timeout) {
  _id_624F473FE3EE62F1 = spawnStruct();
  thread array_any_wait_timeout_proc(_id_624F473FE3EE62F1, timeout);

  foreach(_id_F7806D4CF24AACD3 in array)
  thread array_any_wait_proc(_id_624F473FE3EE62F1, _id_F7806D4CF24AACD3, message);

  _id_624F473FE3EE62F1 waittill("array_wait_proc", result);
  return result;
}

array_any_wait_proc(_id_624F473FE3EE62F1, _id_F7806D4CF24AACD3, message) {
  result = _id_F7806D4CF24AACD3 waittill_any_return_no_endon_death(message, "death");
  _id_624F473FE3EE62F1 notify("array_wait_proc", result);
}

array_any_wait_timeout_proc(_id_624F473FE3EE62F1, timeout) {
  _id_624F473FE3EE62F1 endon("array_wait_proc");
  wait(timeout);
  _id_624F473FE3EE62F1 notify("array_wait_proc", "timeout");
}

array_any_wait_return(array, message) {
  _id_624F473FE3EE62F1 = spawnStruct();

  foreach(_id_F7806D4CF24AACD3 in array)
  thread array_any_wait_return_proc(_id_624F473FE3EE62F1, _id_F7806D4CF24AACD3, message);

  _id_624F473FE3EE62F1 waittill("array_wait_proc", _id_F7806D4CF24AACD3);
  return _id_F7806D4CF24AACD3;
}

array_any_wait_return_proc(_id_624F473FE3EE62F1, _id_F7806D4CF24AACD3, message) {
  result = _id_F7806D4CF24AACD3 waittill_any_return_2(message, "death");
  _id_624F473FE3EE62F1 notify("array_wait_proc", _id_F7806D4CF24AACD3);
}

fileprint_launcher_start_file()
{
  level.fileprintlauncher_linecount = 0;
  level. fileprint_launcher = 1;
  fileprint_launcher( "GAMEPRINTSTARTFILE:" );
}

fileprint_launcher( string )
{
  level.fileprintlauncher_linecount++;

  if(level.fileprintlauncher_linecount > 200) {
    wait 0.05;
    level.fileprintlauncher_linecount = 0;
  }
}

fileprint_launcher_end_file( _id_82996F577AF7F7F3, _id_91A1926479DD5E50 )
{
  if(!isDefined(_id_91A1926479DD5E50))
    _id_91A1926479DD5E50 = 0;

  if(_id_91A1926479DD5E50)
    fileprint_launcher( "GAMEPRINTENDFILE:GAMEPRINTP4ENABLED:" + _id_82996F577AF7F7F3 );
  else
    fileprint_launcher( "GAMEPRINTENDFILE:" + _id_82996F577AF7F7F3 );

    timeout = gettime() + 4000;

  while(getdvarint("launcher_print_success") == 0 && getDvar("launcher_print_fail") == "0" && gettime() < timeout)
    wait 0.05;

  if(!(gettime() < timeout)) {
    iprintlnbold("LAUNCHER_PRINT_FAIL:( TIMEOUT ): launcherconflict? restart launcher and try again? ");
    level. fileprint_launcher = undefined;
    return 0;
  }

  _id_BEF98E08AEA7E932 = getDvar("launcher_print_fail");

  if(_id_BEF98E08AEA7E932 != "0") {
    iprintlnbold("LAUNCHER_PRINT_FAIL:( " + _id_BEF98E08AEA7E932 + " ): launcherconflict? restart launcher and try again? ");
    level. fileprint_launcher = undefined;
    return 0;
  }

  iprintlnbold("Launcher write to file successful!");
  level. fileprint_launcher = undefined;
  return 1;
}

launcher_write_clipboard(str) {
  level.fileprintlauncher_linecount = 0;
  fileprint_launcher( "LAUNCHER_CLIP:" + str );
}

activate_individual_exploder() {
  scripts\common\exploder::activate_individual_exploder_proc();
}

get_target_ent(target) {
  if(!isDefined(target))
    target = self.target;

  ent = getEnt(target, "targetname");

  if(isDefined(ent))
    return ent;

  if(scripts\common\utility::issp()) {
    ent = call[[level.getnodefunction]](target, "targetname");

    if(isDefined(ent))
      return ent;

    ent = call[[level.func["getspawner"]]](target, "targetname");

    if(isDefined(ent))
      return ent;
  }

  ent = getStruct(target, "targetname");

  if(isDefined(ent))
    return ent;

  ent = getvehiclenode(target, "targetname");

  if(isDefined(ent))
    return ent;
}

get_links() {
  return strtok(self.script_linkto, " ");
}

get_linked_ents() {
  array = [];

  if(isDefined(self.script_linkto)) {
    _id_B11F91C17FEEAB8F = get_links();

    if(_id_B11F91C17FEEAB8F.size == 1)
      return getEntArray(_id_B11F91C17FEEAB8F[0], "script_linkname");
    else if(_id_B11F91C17FEEAB8F.size > 1)
      return _func_9F9BA8A4756DB8C7(_id_B11F91C17FEEAB8F, "script_linkname");
  }

  return array;
}

get_linked_ent() {
  array = get_linked_ents();
  return array[0];
}

get_linked_nodes() {
  if(isDefined(self.script_linkto)) {
    _id_B11F91C17FEEAB8F = get_links();

    if(_id_B11F91C17FEEAB8F.size == 1)
      return getnodearray(_id_B11F91C17FEEAB8F[0], "script_linkname");
    else if(_id_B11F91C17FEEAB8F.size > 1)
      return _func_36ED24909DABB916(_id_B11F91C17FEEAB8F, "script_linkname");
  }

  return [];
}

do_earthquake(name, origin) {
  eq = level.earthquake[name];
  earthquake(eq["magnitude"], eq["duration"], origin, eq["radius"]);

  if(isDefined(level._id_BC7733FA2BDF5AD0))
    level thread[[level._id_BC7733FA2BDF5AD0]](name, origin, eq["magnitude"], eq["duration"], eq["radius"]);
}

play_loopsound_in_space(alias, origin) {
  org = spawn("script_origin", (0, 0, 0));

  if(!isDefined(origin))
    origin = self.origin;

  org.origin = origin;
  org playLoopSound(alias);
  return org;
}

play_sound_in_space_with_angles(alias, origin, angles, parent) {
  org = spawn("script_origin", (0, 0, 1));

  if(!isDefined(origin))
    origin = self.origin;

  org.origin = origin;
  org.angles = angles;

  if(isDefined(parent))
    org linkTo(parent);

  if(scripts\common\utility::issp()) {
    org playSound(alias, "sounddone");
    org waittill("sounddone");
  } else
    org playSound(alias);

  org delete();
}

play_sound_in_space(alias, origin, parent) {
  play_sound_in_space_with_angles(alias, origin, (0, 0, 0), parent);
}

loop_fx_sound(alias, origin, _id_331418EF0C2252D0, ender, createfx_ent) {
  loop_fx_sound_with_angles(alias, origin, (0, 0, 0), _id_331418EF0C2252D0, ender, createfx_ent);
}

loop_fx_sound_with_angles(alias, origin, angles, _id_331418EF0C2252D0, ender, createfx_ent, _id_ADD316EE840095A2) {
  if(istrue(_id_331418EF0C2252D0)) {
    if(!isDefined(level.first_frame) || level.first_frame == 1)
      spawnloopingsound(alias, origin, angles);
  } else {
    if(level.createfx_enabled && isDefined(createfx_ent.loopsound_ent))
      org = createfx_ent.loopsound_ent;
    else
      org = spawn("script_origin", (0, 0, 0));

    if(isDefined(ender)) {
      thread loop_sound_delete(ender, org);
      self endon(ender);
    }

    org.origin = origin;
    org.angles = angles;
    org playLoopSound(alias);

    if(level.createfx_enabled)
      createfx_ent.loopsound_ent = org;
    else
      org willneverchange();
  }
}

loop_fx_sound_interval(alias, origin, ender, timeout, _id_32115A3890C1269B, _id_31ED5038909895E5) {
  loop_fx_sound_interval_with_angles(alias, origin, (0, 0, 0), ender, timeout, _id_32115A3890C1269B, _id_31ED5038909895E5);
}

loop_fx_sound_interval_with_angles(alias, origin, angles, ender, timeout, _id_32115A3890C1269B, _id_31ED5038909895E5) {
  self.origin = origin;
  self.angles = angles;

  if(isDefined(ender))
    self endon(ender);

  if(_id_32115A3890C1269B >= _id_31ED5038909895E5) {
    for(;;)
      wait 0.05;
  }

  if(!soundexists(alias)) {
    for(;;)
      wait 0.05;
  }

  for(;;) {
    wait(randomfloatrange(_id_32115A3890C1269B, _id_31ED5038909895E5));
    lock("createfx_looper");
    thread play_sound_in_space_with_angles(alias, self.origin, self.angles, undefined);
    unlock("createfx_looper");
  }
}

loop_sound_delete(ender, ent) {
  ent endon("death");
  self waittill(ender);
  ent delete();
}

createloopeffect(_id_8C44BF99399EDF9A) {
  ent = scripts\common\createfx::createeffect("loopfx", _id_8C44BF99399EDF9A);
  ent.v["delay"] = scripts\common\createfx::getloopeffectdelaydefault();
  return ent;
}

createoneshoteffect(_id_8C44BF99399EDF9A) {
  ent = scripts\common\createfx::createeffect("oneshotfx", _id_8C44BF99399EDF9A);
  ent.v["delay"] = scripts\common\createfx::getoneshoteffectdelaydefault();
  return ent;
}

createexploder(_id_8C44BF99399EDF9A, _id_265E032B267ABF38) {
  ent = scripts\common\createfx::createeffect("exploder", _id_8C44BF99399EDF9A, _id_265E032B267ABF38);
  ent.v["delay"] = scripts\common\createfx::getexploderdelaydefault();
  ent.v["exploder_type"] = "normal";
  return ent;
}

play_loop_sound_on_entity(alias, offset) {
  org = spawn("script_origin", (0, 0, 0));
  org endon("death");
  thread delete_on_death(org);

  if(isDefined(offset)) {
    org.origin = self.origin + offset;
    org.angles = self.angles;
    org linkTo(self);
  } else {
    org.origin = self.origin;
    org.angles = self.angles;
    org linkTo(self);
  }

  org playLoopSound(alias);
  self waittill("stop sound" + alias);
  org stoploopsound(alias);
  org delete();
}

stop_loop_sound_on_entity(alias) {
  self notify("stop sound" + alias);
}

delete_on_death(ent) {
  ent endon("death");
  self waittill("death");

  if(isDefined(ent))
    ent delete();
}

delete_on_sounddone() {
  self waittill("sounddone");
  self delete();
}

delete_on_notify(msg) {
  self waittill(msg);
  self delete();
}

_id_B4B04DE87729A6F3(delay) {
  wait(delay);

  if(isDefined(self))
    self delete();
}

error(msg) {}

exploder(num, players, starttime) {
  [[level._fx.exploderfunction]](num, players, starttime);
}

delete_exploder(num) {
  scripts\common\exploder::delete_exploder_proc(num);
}

hide_exploder_models(num) {
  scripts\common\exploder::hide_exploder_models_proc(num);
}

show_exploder_models(num) {
  scripts\common\exploder::show_exploder_models_proc(num);
}

stop_exploder(num, players) {
  scripts\common\exploder::stop_exploder_proc(num, players, 0);
}

kill_exploder(num, players) {
  scripts\common\exploder::stop_exploder_proc(num, players, 1);
}

get_exploder_array(msg) {
  return scripts\common\exploder::get_exploder_array_proc(msg);
}

ter_op(_id_9CB951DE1A571D32, _id_F901CA059B18A27B, _id_A4136D44AE0EF2DE) {
  if(_id_9CB951DE1A571D32)
    return _id_F901CA059B18A27B;

  return _id_A4136D44AE0EF2DE;
}

_id_53C4C53197386572(value, _id_74EC7A474B47B41C) {
  if(!isDefined(value))
    return _id_74EC7A474B47B41C;

  return value;
}

_id_CE51E08DCC037220(value, _id_74EC7A474B47B41C, _id_4F58263B016248F2) {
  if(!isDefined(value)) {
    if(isDefined(_id_4F58263B016248F2)) {}

    return _id_74EC7A474B47B41C;
  }

  return value;
}

create_lock(msg, count) {
  if(!isDefined(count))
    count = 1;

  if(!isDefined(level.lock))
    level.lock = [];

  _id_B6F7DDCE8981F2DA = spawnStruct();
  _id_B6F7DDCE8981F2DA.max_count = count;
  _id_B6F7DDCE8981F2DA.count = 0;
  level.lock[msg] = _id_B6F7DDCE8981F2DA;
}

lock(msg) {
  lock = level.lock[msg];

  while(lock.count >= lock.max_count)
    lock waittill("unlocked");

  lock.count++;
}

unlock(msg) {
  thread unlock_thread(msg);
}

unlock_thread(msg) {
  wait 0.05;
  lock = level.lock[msg];
  lock.count--;
  lock notify("unlocked");
}

unlock_wait(msg) {
  thread unlock_thread(msg);
  wait 0.05;
}

is_player_gamepad_enabled() {
  _id_CE09C6F6A7628F6D = self usinggamepad();

  if(isDefined(_id_CE09C6F6A7628F6D))
    return _id_CE09C6F6A7628F6D;
  else if(self ispcplayer())
    return 0;
  else
    return 1;
}

distance_2d_squared(a, b) {
  return length2dsquared(a - b);
}

get_array_of_farthest(org, array, _id_6342A5CD84590602, max, maxdist, _id_636C8575D7A7768B) {
  _id_09E748FC0532C64D = get_array_of_closest(org, array, _id_6342A5CD84590602, max, maxdist, _id_636C8575D7A7768B);
  _id_09E748FC0532C64D = array_reverse(_id_09E748FC0532C64D);
  return _id_09E748FC0532C64D;
}

get_array_of_closest(org, array, _id_6342A5CD84590602, max, maxdist, _id_636C8575D7A7768B) {
  if(!isDefined(max))
    max = array.size;

  if(!isDefined(_id_6342A5CD84590602))
    _id_6342A5CD84590602 = [];

  _id_C17ED6DB14EBC007 = undefined;

  if(isDefined(maxdist))
    _id_C17ED6DB14EBC007 = maxdist * maxdist;

  _id_72BA88B06C1F883D = 0;

  if(isDefined(_id_636C8575D7A7768B))
    _id_72BA88B06C1F883D = _id_636C8575D7A7768B * _id_636C8575D7A7768B;

  if(_id_6342A5CD84590602.size == 0 && max >= array.size && _id_72BA88B06C1F883D == 0 && !isDefined(_id_C17ED6DB14EBC007))
    return sortbydistance(array, org);

  _id_BFC65A378A6D8EFE = [];

  foreach(ent in array) {
    _id_80BF6212193E8983 = 0;

    foreach(_id_80BF5812193E7385 in _id_6342A5CD84590602) {
      if(ent == _id_80BF5812193E7385) {
        _id_80BF6212193E8983 = 1;
        break;
      }
    }

    if(_id_80BF6212193E8983) {
      continue;
    }
    _id_AF833C45B0E3FCB3 = distancesquared(org, ent.origin);

    if(isDefined(_id_C17ED6DB14EBC007) && _id_AF833C45B0E3FCB3 > _id_C17ED6DB14EBC007) {
      continue;
    }
    if(_id_AF833C45B0E3FCB3 < _id_72BA88B06C1F883D) {
      continue;
    }
    _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = ent;
  }

  _id_BFC65A378A6D8EFE = sortbydistance(_id_BFC65A378A6D8EFE, org);

  if(max >= _id_BFC65A378A6D8EFE.size)
    return _id_BFC65A378A6D8EFE;

  _id_B6FD27FCE7DC4298 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < max; _id_AC0E594AC96AA3A8++)
    _id_B6FD27FCE7DC4298[_id_AC0E594AC96AA3A8] = _id_BFC65A378A6D8EFE[_id_AC0E594AC96AA3A8];

  return _id_B6FD27FCE7DC4298;
}

drop_to_ground(pos, _id_084D0C3E36ADDFA4, _id_191EBD2DD0D5F975, _id_2CF4A7DBEF8201F3, contents) {
  if(!isDefined(_id_084D0C3E36ADDFA4))
    _id_084D0C3E36ADDFA4 = 1500;

  if(!isDefined(_id_191EBD2DD0D5F975))
    _id_191EBD2DD0D5F975 = -12000;

  if(!isDefined(contents))
    contents = scripts\engine\trace::create_solid_ai_contents(1);

  if(isDefined(_id_2CF4A7DBEF8201F3))
    return scripts\engine\trace::ray_trace(pos + _id_084D0C3E36ADDFA4 * _id_2CF4A7DBEF8201F3, pos + _id_191EBD2DD0D5F975 * _id_2CF4A7DBEF8201F3, undefined, contents)["position"];
  else
    return scripts\engine\trace::ray_trace(pos + (0, 0, _id_084D0C3E36ADDFA4), pos + (0, 0, _id_191EBD2DD0D5F975), undefined, contents)["position"];
}

player_drop_to_ground(pos, radius, _id_084D0C3E36ADDFA4, _id_191EBD2DD0D5F975, _id_2CF4A7DBEF8201F3) {
  if(!isDefined(_id_084D0C3E36ADDFA4))
    _id_084D0C3E36ADDFA4 = 1500;

  if(!isDefined(_id_191EBD2DD0D5F975))
    _id_191EBD2DD0D5F975 = -12000;

  contents = scripts\engine\trace::create_solid_ai_contents(1);

  if(isDefined(_id_2CF4A7DBEF8201F3))
    return scripts\engine\trace::sphere_trace(pos + _id_084D0C3E36ADDFA4 * _id_2CF4A7DBEF8201F3, pos + _id_191EBD2DD0D5F975 * _id_2CF4A7DBEF8201F3, radius, undefined, contents)["position"];
  else
    return scripts\engine\trace::sphere_trace(pos + (0, 0, _id_084D0C3E36ADDFA4), pos + (0, 0, _id_191EBD2DD0D5F975), radius, undefined, contents)["position"];
}

within_fov(start_origin, start_angles, end_origin, fov) {
  normal = vectorNormalize(end_origin - start_origin);
  forward = anglesToForward(start_angles);
  dot = vectordot(forward, normal);
  return dot >= fov;
}

ai_3d_sighting_model(_id_F297583B09B3D29C) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["ai_3d_sighting_model"]))
    return self[[level.bot_funcs["ai_3d_sighting_model"]]](_id_F297583B09B3D29C);
}

getclosest(org, array, maxdist) {
  if(array.size == 0)
    return undefined;

  ent = sortbydistance(array, org)[0];

  if(isDefined(maxdist) && distancesquared(org, ent.origin) > squared(maxdist))
    return undefined;

  return ent;
}

_id_4D046F33253E46E0(org, array, maxdist) {
  _id_0DA9D76F5A9B4145 = undefined;
  _id_C1DA30005A22582B = ter_op(isDefined(maxdist), maxdist, undefined);

  foreach(ent in array) {
    if(!isDefined(ent.origin)) {
      continue;
    }
    _id_4EB801042B324702 = distancesquared(ent.origin, org);

    if(!isDefined(_id_C1DA30005A22582B) || _id_4EB801042B324702 < _id_C1DA30005A22582B) {
      _id_0DA9D76F5A9B4145 = ent;
      _id_C1DA30005A22582B = _id_4EB801042B324702;
    }
  }

  return _id_0DA9D76F5A9B4145;
}

missile_settargetandflightmode(target, mode, offset) {
  offset = ter_op(isDefined(offset), offset, (0, 0, 0));
  self missile_settargetEnt(target, offset);

  switch (mode) {
    case "direct":
      self missile_setflightmodedirect();
      break;
    case "top":
      self missile_setflightmodetop();
      break;
  }
}

add_fx(_id_082787F7776408C5, _id_BEF6522A8EC5B12F) {
  if(!isDefined(level._effect))
    level._effect = [];

  level._effect[_id_082787F7776408C5] = loadfx(_id_BEF6522A8EC5B12F);
}

create_func_ref(name, func) {
  if(!isDefined(level.func))
    level.func = [];

  level.func[name] = func;
}

create_empty_func_ref(name) {
  if(!isDefined(level.func))
    level.func = [];

  if(!isDefined(level.func[name]))
    create_func_ref(name, ::empty_init_func);
}

func_ref_exist(name) {
  return isDefined(level.func) && isDefined(level.func[name]);
}

add_init_script(name, _id_11AD17280F2F60F8) {
  if(!isDefined(level.init_script))
    level.init_script = [];

  if(isDefined(level.init_script[name]))
    return 0;

  level.init_script[name] = _id_11AD17280F2F60F8;
  return 1;
}

add_frame_event(event) {
  if(!isDefined(self.frame_events)) {
    self.frame_events = [event];
    thread process_frame_events();
  } else
    self.frame_events[self.frame_events.size] = event;
}

process_frame_events() {
  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    foreach(event in self.frame_events)
    self thread[[event]]();

    waitframe();
  }
}

delaythread(timer, func, param1, param2, param3, param4, param5, param6, param7) {
  thread delaythread_proc(func, undefined, timer, param1, param2, param3, param4, param5, param6, param7);
}

_id_F9A207358D70923C(timer, _id_92D54E0CCAE3B56D, func, param1, param2, param3, param4, param5, param6, param7) {
  thread delaythread_proc(func, _id_92D54E0CCAE3B56D, timer, param1, param2, param3, param4, param5, param6, param7);
}

delaythread_proc(func, _id_92D54E0CCAE3B56D, timer, param1, param2, param3, param4, param5, param6, param7) {
  if(isDefined(self)) {
    self endon("stop_delay_thread");

    if(isent(self) && isPlayer(self))
      self endon("death_or_disconnect");
    else
      self endon("death");

    if(isDefined(_id_92D54E0CCAE3B56D)) {
      if(!isarray(_id_92D54E0CCAE3B56D))
        _id_92D54E0CCAE3B56D = [_id_92D54E0CCAE3B56D];

      foreach(_id_CB57658B734D4B0C in _id_92D54E0CCAE3B56D)
      self endon(_id_CB57658B734D4B0C);
    }
  }

  wait(timer);

  if(isDefined(param7))
    thread[[func]](param1, param2, param3, param4, param5, param6, param7);
  else if(isDefined(param6))
    thread[[func]](param1, param2, param3, param4, param5, param6);
  else if(isDefined(param5))
    thread[[func]](param1, param2, param3, param4, param5);
  else if(isDefined(param4))
    thread[[func]](param1, param2, param3, param4);
  else if(isDefined(param3))
    thread[[func]](param1, param2, param3);
  else if(isDefined(param2))
    thread[[func]](param1, param2);
  else if(isDefined(param1))
    thread[[func]](param1);
  else
    thread[[func]]();
}

damagelocationisany(a, b, c, _id_AC0E564AC96A9D0F, e, f, g, h, _id_AC0E594AC96AA3A8, _id_AC0E5C4AC96AAA41, _id_AC0E5B4AC96AA80E, _id_543567043475F4C2) {
  if(isDefined(self.damagelocation)) {
    if(!isDefined(a))
      return 0;

    if(self.damagelocation == a)
      return 1;

    if(!isDefined(b))
      return 0;

    if(self.damagelocation == b)
      return 1;

    if(!isDefined(c))
      return 0;

    if(self.damagelocation == c)
      return 1;

    if(!isDefined(_id_AC0E564AC96A9D0F))
      return 0;

    if(self.damagelocation == _id_AC0E564AC96A9D0F)
      return 1;

    if(!isDefined(e))
      return 0;

    if(self.damagelocation == e)
      return 1;

    if(!isDefined(f))
      return 0;

    if(self.damagelocation == f)
      return 1;

    if(!isDefined(g))
      return 0;

    if(self.damagelocation == g)
      return 1;

    if(!isDefined(h))
      return 0;

    if(self.damagelocation == h)
      return 1;

    if(!isDefined(_id_AC0E594AC96AA3A8))
      return 0;

    if(self.damagelocation == _id_AC0E594AC96AA3A8)
      return 1;

    if(!isDefined(_id_AC0E5C4AC96AAA41))
      return 0;

    if(self.damagelocation == _id_AC0E5C4AC96AAA41)
      return 1;

    if(!isDefined(_id_AC0E5B4AC96AA80E))
      return 0;

    if(self.damagelocation == _id_AC0E5B4AC96AA80E)
      return 1;
  }

  return damagesubpartlocationisany(a, b, c, _id_AC0E564AC96A9D0F, e, f, g, h, _id_AC0E594AC96AA3A8, _id_AC0E5C4AC96AAA41, _id_AC0E5B4AC96AA80E, _id_543567043475F4C2);
}

damagesubpartlocationisany(a, b, c, _id_AC0E564AC96A9D0F, e, f, g, h, _id_AC0E594AC96AA3A8, _id_AC0E5C4AC96AAA41, _id_AC0E5B4AC96AA80E, _id_543567043475F4C2) {
  if(!isDefined(self.damagedsubpart))
    return 0;

  if(!isDefined(a))
    return 0;

  if(self.damagedsubpart == a)
    return 1;

  if(!isDefined(b))
    return 0;

  if(self.damagedsubpart == b)
    return 1;

  if(!isDefined(c))
    return 0;

  if(self.damagedsubpart == c)
    return 1;

  if(!isDefined(_id_AC0E564AC96A9D0F))
    return 0;

  if(self.damagedsubpart == _id_AC0E564AC96A9D0F)
    return 1;

  if(!isDefined(e))
    return 0;

  if(self.damagedsubpart == e)
    return 1;

  if(!isDefined(f))
    return 0;

  if(self.damagedsubpart == f)
    return 1;

  if(!isDefined(g))
    return 0;

  if(self.damagedsubpart == g)
    return 1;

  if(!isDefined(h))
    return 0;

  if(self.damagedsubpart == h)
    return 1;

  if(!isDefined(_id_AC0E594AC96AA3A8))
    return 0;

  if(self.damagedsubpart == _id_AC0E594AC96AA3A8)
    return 1;

  if(!isDefined(_id_AC0E5C4AC96AAA41))
    return 0;

  if(self.damagedsubpart == _id_AC0E5C4AC96AAA41)
    return 1;

  if(!isDefined(_id_AC0E5B4AC96AA80E))
    return 0;

  if(self.damagedsubpart == _id_AC0E5B4AC96AA80E)
    return 1;

  return 0;
}

isbulletdamage(meansofdeath) {
  if(!isDefined(meansofdeath))
    return 0;

  switch (meansofdeath) {
    case "MOD_HEAD_SHOT":
    case "MOD_PISTOL_BULLET":
    case "MOD_RIFLE_BULLET":
      return 1;
    default:
      return 0;
  }
}

_id_55E3DE6210F3EAC0(meansofdeath) {
  if(!isDefined(meansofdeath))
    return 0;

  return meansofdeath == "MOD_FIRE";
}

_id_F1D312F6935BC2D2(meansofdeath) {
  if(!isDefined(meansofdeath))
    return 0;

  return meansofdeath == "MOD_IMPACT";
}

ismeleedamage(meansofdeath) {
  if(!isDefined(meansofdeath))
    return 0;

  return meansofdeath == "MOD_MELEE";
}

_id_F86569FC5D5DC60F(inflictor, meansofdeath) {
  if(!isDefined(inflictor) || !isDefined(inflictor.vehiclename))
    return 0;

  return meansofdeath == "MOD_CRUSH";
}

isvalidpeekoutdir(dir) {
  node = self;
  _id_13C75DB93110AD97 = node getvalidcoverpeekouts();

  foreach(_id_05B54041CE862B7E in _id_13C75DB93110AD97) {
    if(_id_05B54041CE862B7E == dir)
      return 1;
  }

  return 0;
}

getbestcovermultinodetype(node) {
  _id_A4D325774CC3387D = node getvalidcovermultinodetypes();

  if(_id_A4D325774CC3387D.size <= 0)
    return undefined;

  _id_7B6ABE1895867F3E = 0;

  if(isDefined(self.enemy)) {
    _id_ED81367A7389038A = self.enemy.origin;

    if(issentient(self.enemy) && self lastknowntime(self.enemy) > 0)
      _id_ED81367A7389038A = self lastknownpos(self.enemy);

    _id_72C1BA1A734C19E6 = vectortoangles(_id_ED81367A7389038A - node.origin);
    _id_7B6ABE1895867F3E = angleclamp180(_id_72C1BA1A734C19E6[1] - node.angles[1]);
  }

  foreach(_id_AF80A5E00A28CA34 in _id_A4D325774CC3387D) {
    switch (_id_AF80A5E00A28CA34) {
      case "Cover Stand":
      case "Cover Crouch":
        if(abs(_id_7B6ABE1895867F3E) < 30)
          return _id_AF80A5E00A28CA34;

        break;
      case "Cover Left Crouch":
      case "Cover Left":
        if(_id_7B6ABE1895867F3E > 30)
          return "Cover Left";

        break;
      case "Cover Right Crouch":
      case "Cover Right":
        if(_id_7B6ABE1895867F3E < -30)
          return "Cover Right";

        break;
      default:
    }
  }

  nodetype = _id_A4D325774CC3387D[0];

  switch (nodetype) {
    case "Cover Left Crouch":
      return "Cover Left";
    case "Cover Right Crouch":
      return "Cover Right";
  }

  return nodetype;
}

isnodecoverleft(node) {
  return node.type == "Cover Left";
}

isnodecoverright(node) {
  return node.type == "Cover Right";
}

isnodecovercrouchtype(node, type) {
  if(node.type == "Cover Crouch" && isDefined(self._blackboard.croucharrivaltype))
    return self._blackboard.croucharrivaltype == type;

  return 0;
}

isnode3d(node) {
  return isnodecover3d(node) || isnodeexposed3d(node);
}

isnodecover3d(node) {
  return node.type == "Cover Stand 3D" || node.type == "Cover 3D";
}

isnodeexposed3d(node) {
  return node.type == "Exposed 3D" || node.type == "Path 3D";
}

isnodecovercrouch(node) {
  return node.type == "Cover Crouch" || node.type == "Cover Crouch Window" || node.type == "Conceal Crouch";
}

getaimyawtopoint(point) {
  yaw = getyawtospot(point);
  dist = distance(self.origin, point);

  if(dist > 3) {
    _id_E062B0DFB1625D77 = asin(-3 / dist);
    yaw = yaw - _id_E062B0DFB1625D77;
  }

  yaw = angleclamp180(yaw);
  return yaw;
}

getyawtospot(_id_0C3EA9B1A20FF199) {
  if(actor_is3d()) {
    forward = anglesToForward(self.angles);
    _id_818CDA9BC6B4EA1C = rotatepointaroundvector(forward, _id_0C3EA9B1A20FF199 - self.origin, self.angles[2] * -1);
    _id_0C3EA9B1A20FF199 = _id_818CDA9BC6B4EA1C + self.origin;
  }

  yaw = getyaw(_id_0C3EA9B1A20FF199) - self.angles[1];
  yaw = angleclamp180(yaw);
  return yaw;
}

getyaw(org) {
  return vectortoyaw(org - self.origin);
}

getaimyawtopoint3d(point) {
  yaw = getyawtospot3d(point);
  dist = distance(self.origin, point);

  if(dist > 3) {
    _id_E062B0DFB1625D77 = asin(-3 / dist);
    yaw = yaw - _id_E062B0DFB1625D77;
  }

  yaw = angleclamp180(yaw);
  return yaw;
}

getyawtospot3d(_id_0C3EA9B1A20FF199) {
  _id_2F2845D474ECDDD0 = _id_0C3EA9B1A20FF199 - self.origin;
  _id_11F7D776431EDC42 = rotatevectorinverted(_id_2F2845D474ECDDD0, self.angles);
  yaw = vectortoyaw(_id_11F7D776431EDC42);
  _id_BFB998964A6CA671 = angleclamp180(yaw);
  return _id_BFB998964A6CA671;
}

getaimpitchtopoint3d(point) {
  pitch = getpitchtospot3d(point);
  dist = distance(self.origin, point);

  if(dist > 3) {
    _id_E062B0DFB1625D77 = asin(-3 / dist);
    pitch = pitch - _id_E062B0DFB1625D77;
  }

  pitch = angleclamp180(pitch);
  return pitch;
}

getpitchtospot3d(_id_0C3EA9B1A20FF199) {
  _id_2F2845D474ECDDD0 = _id_0C3EA9B1A20FF199 - self.origin;
  _id_11F7D776431EDC42 = rotatevectorinverted(_id_2F2845D474ECDDD0, self.angles);
  pitch = vectortopitch(_id_11F7D776431EDC42);
  _id_B316FC9FC1FCCC04 = angleclamp180(pitch);
  return _id_B316FC9FC1FCCC04;
}

getplayerpitch(player) {
  _id_3C70A7175FBFA3FC = player getplayerangles();
  return (_id_3C70A7175FBFA3FC[0] + 360) % 360;
}

getplayeryaw(player) {
  _id_3C70A7175FBFA3FC = player getplayerangles();
  return (_id_3C70A7175FBFA3FC[1] + 360) % 360;
}

actor_isspace() {
  return istrue(self.space);
}

actor_is3d() {
  return actor_isspace();
}

getpredictedaimyawtoshootentorpos(time, shootent, shootpos) {
  if(!isDefined(shootent)) {
    if(!isDefined(shootpos))
      return 0;

    return getaimyawtopoint(shootpos);
  }

  v = (0, 0, 0);

  if(isPlayer(shootent))
    v = shootent getvelocity();
  else if(isai(shootent))
    v = shootent.velocity;

  _id_D5F90145B0644757 = shootent.origin + v * time;
  return getaimyawtopoint(_id_D5F90145B0644757);
}

getpredictedaimyawtoshootentorpos3d(time, shootent, shootpos) {
  if(!isDefined(shootent)) {
    if(!isDefined(shootpos))
      return 0;

    return getaimyawtopoint3d(shootpos);
  }

  v = (0, 0, 0);

  if(isPlayer(shootent))
    v = shootent getvelocity();
  else if(isai(shootent))
    v = shootent.velocity;

  _id_D5F90145B0644757 = shootent.origin + v * time;
  return getaimyawtopoint3d(_id_D5F90145B0644757);
}

getpredictedaimpitchtoshootentorpos3d(time, shootent, shootpos) {
  if(!isDefined(shootent)) {
    if(!isDefined(shootpos))
      return 0;

    return getaimpitchtopoint3d(shootpos);
  }

  v = (0, 0, 0);

  if(isPlayer(shootent))
    v = shootent getvelocity();
  else if(isai(shootent))
    v = shootent.velocity;

  _id_D5F90145B0644757 = shootent.origin + v * time;
  return getaimpitchtopoint3d(_id_D5F90145B0644757);
}

is_equal(_id_43481BFD34BAE676, _id_43481AFD34BAE443) {
  return isDefined(_id_43481BFD34BAE676) && isDefined(_id_43481AFD34BAE443) && _id_43481BFD34BAE676 == _id_43481AFD34BAE443;
}

_id_5B7E9A4C946F3A13(_id_8B461603A1F825D3, _id_B6989377114AC328) {
  if(!isDefined(_id_8B461603A1F825D3))
    return 0;

  foreach(value in _id_B6989377114AC328) {
    if(isDefined(value) && _id_8B461603A1F825D3 == value)
      return 1;
  }

  return 0;
}

player_is_in_jackal() {
  return 0;
}

set_createfx_enabled() {
  if(!isDefined(level.createfx_enabled))
    level.createfx_enabled = getDvar("createfx") != "";
}

flag_set_delayed(message, delay, _id_AC9510CD03AF7E12) {
  wait(delay);
  flag_set(message, _id_AC9510CD03AF7E12);
}

noself_array_call(entities, _id_FA89613ACD0EB87E, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A) {
  if(isDefined(_id_D2806D25E4C8134A)) {
    foreach(ent in entities)
    call[[_id_FA89613ACD0EB87E]](ent, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A);

    return;
  }

  if(isDefined(_id_D2806825E4C8084B)) {
    foreach(ent in entities)
    call[[_id_FA89613ACD0EB87E]](ent, _id_D2806725E4C80618, _id_D2806825E4C8084B);

    return;
  }

  if(isDefined(_id_D2806725E4C80618)) {
    foreach(ent in entities)
    call[[_id_FA89613ACD0EB87E]](ent, _id_D2806725E4C80618);

    return;
  }

  foreach(ent in entities)
  call[[_id_FA89613ACD0EB87E]](ent);
}

flag_assert(msg) {}

flag_wait_either(flag1, _id_5228090A1CF6F05B) {
  for(;;) {
    if(flag(flag1)) {
      return;
    }
    if(flag(_id_5228090A1CF6F05B)) {
      return;
    }
    level waittill_either(flag1, _id_5228090A1CF6F05B);
  }
}

flag_wait_either_return(flag1, _id_5228090A1CF6F05B) {
  for(;;) {
    if(flag(flag1))
      return flag1;

    if(flag(_id_5228090A1CF6F05B))
      return _id_5228090A1CF6F05B;

    msg = level waittill_any_return_2(flag1, _id_5228090A1CF6F05B);
    return msg;
  }
}

_id_665D474FF040B446(flags) {
  flags = array_removeundefined(flags);

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < flags.size; _id_AC0E594AC96AA3A8++) {
      if(flag(flags[_id_AC0E594AC96AA3A8]))
        return flags[_id_AC0E594AC96AA3A8];
    }

    level _id_5ADCA43F839A3CCE(flags);
  }
}

_id_51FFC85DD7EBDE09(flags) {
  return _id_665D474FF040B446(flags);
}

flag_wait_any(flag1, _id_5228090A1CF6F05B, _id_5228080A1CF6EE28, _id_52280F0A1CF6FD8D, _id_52280E0A1CF6FB5A, _id_52280D0A1CF6F927) {
  array = [];

  if(isDefined(_id_52280D0A1CF6F927)) {
    array[array.size] = flag1;
    array[array.size] = _id_5228090A1CF6F05B;
    array[array.size] = _id_5228080A1CF6EE28;
    array[array.size] = _id_52280F0A1CF6FD8D;
    array[array.size] = _id_52280E0A1CF6FB5A;
    array[array.size] = _id_52280D0A1CF6F927;
  } else if(isDefined(_id_52280E0A1CF6FB5A)) {
    array[array.size] = flag1;
    array[array.size] = _id_5228090A1CF6F05B;
    array[array.size] = _id_5228080A1CF6EE28;
    array[array.size] = _id_52280F0A1CF6FD8D;
    array[array.size] = _id_52280E0A1CF6FB5A;
  } else if(isDefined(_id_52280F0A1CF6FD8D)) {
    array[array.size] = flag1;
    array[array.size] = _id_5228090A1CF6F05B;
    array[array.size] = _id_5228080A1CF6EE28;
    array[array.size] = _id_52280F0A1CF6FD8D;
  } else if(isDefined(_id_5228080A1CF6EE28)) {
    array[array.size] = flag1;
    array[array.size] = _id_5228090A1CF6F05B;
    array[array.size] = _id_5228080A1CF6EE28;
  } else if(isDefined(_id_5228090A1CF6F05B)) {
    flag_wait_either(flag1, _id_5228090A1CF6F05B);
    return;
  } else
    return;

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
      if(flag(array[_id_AC0E594AC96AA3A8]))
        return;
    }

    level waittill_any(flag1, _id_5228090A1CF6F05B, _id_5228080A1CF6EE28, _id_52280F0A1CF6FD8D, _id_52280E0A1CF6FB5A, _id_52280D0A1CF6F927);
  }
}

flag_wait_any_timeout(timer, flag1, _id_5228090A1CF6F05B, _id_5228080A1CF6EE28, _id_52280F0A1CF6FD8D, _id_52280E0A1CF6FB5A, _id_52280D0A1CF6F927) {
  _id_6FC321A0EB77771E = timer * 1000;
  start_time = gettime();
  array = [];

  if(isDefined(_id_52280D0A1CF6F927)) {
    array[array.size] = flag1;
    array[array.size] = _id_5228090A1CF6F05B;
    array[array.size] = _id_5228080A1CF6EE28;
    array[array.size] = _id_52280F0A1CF6FD8D;
    array[array.size] = _id_52280E0A1CF6FB5A;
    array[array.size] = _id_52280D0A1CF6F927;
  } else if(isDefined(_id_52280E0A1CF6FB5A)) {
    array[array.size] = flag1;
    array[array.size] = _id_5228090A1CF6F05B;
    array[array.size] = _id_5228080A1CF6EE28;
    array[array.size] = _id_52280F0A1CF6FD8D;
    array[array.size] = _id_52280E0A1CF6FB5A;
  } else if(isDefined(_id_52280F0A1CF6FD8D)) {
    array[array.size] = flag1;
    array[array.size] = _id_5228090A1CF6F05B;
    array[array.size] = _id_5228080A1CF6EE28;
    array[array.size] = _id_52280F0A1CF6FD8D;
  } else if(isDefined(_id_5228080A1CF6EE28)) {
    array[array.size] = flag1;
    array[array.size] = _id_5228090A1CF6F05B;
    array[array.size] = _id_5228080A1CF6EE28;
  } else if(isDefined(_id_5228090A1CF6F05B)) {
    array[array.size] = flag1;
    array[array.size] = _id_5228090A1CF6F05B;
  } else
    return;

  for(;;) {
    foreach(_id_F4B4FE5611C0F995 in array) {
      if(flag(_id_F4B4FE5611C0F995))
        return;
    }

    _id_102B5C363701F913 = gettime();

    if(_id_102B5C363701F913 >= start_time + _id_6FC321A0EB77771E) {
      break;
    }

    timeremaining = _id_6FC321A0EB77771E - (_id_102B5C363701F913 - start_time);
    _id_5C0D5BB3CB09262E = timeremaining / 1000;
    internal_wait_for_any_flag_or_time_elapses(array, _id_5C0D5BB3CB09262E);
  }
}

internal_wait_for_any_flag_or_time_elapses(_id_A3F0EF56929FC827, timer) {
  foreach(_id_F4B4FE5611C0F995 in _id_A3F0EF56929FC827)
  level endon(_id_F4B4FE5611C0F995);

  wait(timer);
}

flag_wait_any_return(flag1, _id_5228090A1CF6F05B, _id_5228080A1CF6EE28, _id_52280F0A1CF6FD8D, _id_52280E0A1CF6FB5A) {
  array = [];

  if(isDefined(_id_52280E0A1CF6FB5A)) {
    array[array.size] = flag1;
    array[array.size] = _id_5228090A1CF6F05B;
    array[array.size] = _id_5228080A1CF6EE28;
    array[array.size] = _id_52280F0A1CF6FD8D;
    array[array.size] = _id_52280E0A1CF6FB5A;
  } else if(isDefined(_id_52280F0A1CF6FD8D)) {
    array[array.size] = flag1;
    array[array.size] = _id_5228090A1CF6F05B;
    array[array.size] = _id_5228080A1CF6EE28;
    array[array.size] = _id_52280F0A1CF6FD8D;
  } else if(isDefined(_id_5228080A1CF6EE28)) {
    array[array.size] = flag1;
    array[array.size] = _id_5228090A1CF6F05B;
    array[array.size] = _id_5228080A1CF6EE28;
  } else if(isDefined(_id_5228090A1CF6F05B)) {
    msg = flag_wait_either_return(flag1, _id_5228090A1CF6F05B);
    return msg;
  } else
    return;

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
      if(flag(array[_id_AC0E594AC96AA3A8]))
        return array[_id_AC0E594AC96AA3A8];
    }

    msg = level waittill_any_return_5(flag1, _id_5228090A1CF6F05B, _id_5228080A1CF6EE28, _id_52280F0A1CF6FD8D, _id_52280E0A1CF6FB5A);
    return msg;
  }
}

flag_wait_all(flag1, _id_5228090A1CF6F05B, _id_5228080A1CF6EE28, _id_52280F0A1CF6FD8D) {
  if(isDefined(flag1))
    flag_wait(flag1);

  if(isDefined(_id_5228090A1CF6F05B))
    flag_wait(_id_5228090A1CF6F05B);

  if(isDefined(_id_5228080A1CF6EE28))
    flag_wait(_id_5228080A1CF6EE28);

  if(isDefined(_id_52280F0A1CF6FD8D))
    flag_wait(_id_52280F0A1CF6FD8D);
}

_id_7A252ABAAA15FCD7(flags) {
  flags = array_removeundefined(flags);

  for(;;) {
    foreach(flagname in flags)
    flag_wait(flagname);

    _id_C8C20AD7B4271D20 = 0;

    foreach(flagname in flags) {
      if(flag(flagname))
        _id_C8C20AD7B4271D20++;
    }

    if(_id_C8C20AD7B4271D20 == flags.size) {
      break;
    }
  }
}

flag_waitopen_all_array(flags) {
  flags = array_removeundefined(flags);

  for(;;) {
    foreach(flagname in flags)
    flag_waitopen(flagname);

    _id_DF8BBDA6A16DD1CB = 0;

    foreach(flagname in flags) {
      if(!flag(flagname))
        _id_DF8BBDA6A16DD1CB++;
    }

    if(_id_DF8BBDA6A16DD1CB == flags.size) {
      break;
    }
  }
}

flag_wait_or_timeout(flagname, timer) {
  _id_6FC321A0EB77771E = timer * 1000;
  start_time = gettime();

  for(;;) {
    if(flag(flagname)) {
      break;
    }

    if(gettime() >= start_time + _id_6FC321A0EB77771E) {
      break;
    }

    timeremaining = _id_6FC321A0EB77771E - (gettime() - start_time);
    _id_5C0D5BB3CB09262E = timeremaining / 1000;
    wait_for_flag_or_time_elapses(flagname, _id_5C0D5BB3CB09262E);
  }
}

flag_waitopen_or_timeout(flagname, timer) {
  start_time = gettime();

  for(;;) {
    if(!flag(flagname)) {
      break;
    }

    if(gettime() >= start_time + timer * 1000) {
      break;
    }

    wait_for_flag_or_time_elapses(flagname, timer);
  }
}

wait_for_flag_or_time_elapses(flagname, timer) {
  level endon(flagname);
  wait(timer);
}

noself_delaycall(timer, func, param1, param2, param3, param4, param5, param6, param7, param8) {
  thread noself_delaycall_proc(func, timer, param1, param2, param3, param4, param5, param6, param7, param8);
}

noself_delaycall_proc(func, timer, param1, param2, param3, param4, param5, param6, param7, param8) {
  wait(timer);

  if(isDefined(param8))
    call[[func]](param1, param2, param3, param4, param5, param6, param7, param8);
  else if(isDefined(param7))
    call[[func]](param1, param2, param3, param4, param5, param6, param7);
  else if(isDefined(param6))
    call[[func]](param1, param2, param3, param4, param5, param6);
  else if(isDefined(param5))
    call[[func]](param1, param2, param3, param4, param5);
  else if(isDefined(param4))
    call[[func]](param1, param2, param3, param4);
  else if(isDefined(param3))
    call[[func]](param1, param2, param3);
  else if(isDefined(param2))
    call[[func]](param1, param2);
  else if(isDefined(param1))
    call[[func]](param1);
  else
    call[[func]]();
}

get_target_array(target) {
  if(!isDefined(target))
    target = self.target;

  ents = getEntArray(target, "targetname");

  if(ents.size > 0)
    return ents;

  if(scripts\common\utility::issp()) {
    ents = call[[level.getnodearrayfunction]](target, "targetname");

    if(ents.size > 0)
      return ents;
  }

  ents = getStructArray(target, "targetname");

  if(ents.size > 0)
    return ents;

  ents = getvehiclenodearray(target, "targetname");

  if(ents.size > 0)
    return ents;
}

pauseeffect() {
  scripts\common\createfx::stop_fx_looper();
}

spawn_script_origin(org, _id_8BC14603A27FA3E7) {
  if(!isDefined(_id_8BC14603A27FA3E7) && isDefined(self.angles))
    _id_8BC14603A27FA3E7 = self.angles;

  if(!isDefined(org) && isDefined(self.origin))
    org = self.origin;
  else if(!isDefined(org))
    org = (0, 0, 0);

  script_origin = spawn("script_origin", org);

  if(isDefined(_id_8BC14603A27FA3E7))
    script_origin.angles = _id_8BC14603A27FA3E7;

  return script_origin;
}

get_noteworthy_array(noteworthy) {
  ents = getEntArray(noteworthy, "script_noteworthy");

  if(ents.size > 0)
    return ents;

  if(scripts\common\utility::issp()) {
    ents = call[[level.getnodearrayfunction]](noteworthy, "script_noteworthy");

    if(ents.size > 0)
      return ents;
  }

  ents = getStructArray(noteworthy, "script_noteworthy");

  if(ents.size > 0)
    return ents;

  ents = getvehiclenodearray(noteworthy, "script_noteworthy");

  if(ents.size > 0)
    return ents;
}

get_cumulative_weights(weights) {
  _id_D3B5EA3E9016D6E4 = [];
  _id_BE66DE030B25508C = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < weights.size; _id_AC0E594AC96AA3A8++) {
    _id_BE66DE030B25508C = _id_BE66DE030B25508C + weights[_id_AC0E594AC96AA3A8];
    _id_D3B5EA3E9016D6E4[_id_AC0E594AC96AA3A8] = _id_BE66DE030B25508C;
  }

  return _id_D3B5EA3E9016D6E4;
}

void() {}

getanim(anime) {
  return level.scr_anim[self.animname][anime];
}

hasanim(anime) {
  return isDefined(level.scr_anim[self.animname][anime]);
}

getanim_from_animname(anime, animname) {
  return level.scr_anim[animname][anime];
}

getanim_generic(anime) {
  return level.scr_anim["generic"][anime];
}

hasanim_generic(anime) {
  return isDefined(level.scr_anim["generic"][anime]);
}

_id_6D41AC1C3D718A62(anime, ent) {
  _id_22B4906AFB0ED359 = [];

  if(scripts\common\anim::_id_F1E7EE8DDEECE062(anime)) {
    foreach(animation in level.scr_anim[ent.animname][anime]) {
      _id_4F51EF0BD97A4707 = scripts\common\anim::_id_56BD620E57A834AF(anime, ent.animname, animation);
      scripts\common\anim::anim_first_frame_solo(ent, _id_4F51EF0BD97A4707);
      _id_22B4906AFB0ED359[_id_22B4906AFB0ED359.size] = ent.origin;
    }
  } else {
    scripts\common\anim::anim_first_frame_solo(ent, anime);
    _id_22B4906AFB0ED359[_id_22B4906AFB0ED359.size] = ent.origin;
  }

  return _id_22B4906AFB0ED359;
}

waittill_match_or_timeout(msg, _id_AA9F4C033D62BC8A, timer) {
  ent = spawnStruct();
  ent endon("complete");
  ent delaythread(timer, ::send_notify, "complete");
  self waittillmatch(msg, _id_AA9F4C033D62BC8A);
}

_id_EE012C2DD711A8CE(msg, _id_AA9F4C033D62BC8A, _id_30DD9F6DDD87B138) {
  self endon(_id_30DD9F6DDD87B138);
  self waittillmatch(msg, _id_AA9F4C033D62BC8A);
}

waittill_match_or_timeout_return(msg, _id_AA9F4C033D62BC8A, timer) {
  ent = spawnStruct();
  ent endon("complete");
  ent delaythread(timer, ::send_notify, "complete");
  self waittill(msg, _id_AA9F4C033D62BC8A);
  return _id_AA9F4C033D62BC8A;
}

send_notify(msg, _id_1EF9E61D95CBF8F7) {
  if(isDefined(_id_1EF9E61D95CBF8F7))
    self notify(msg, _id_1EF9E61D95CBF8F7);
  else
    self notify(msg);
}

get_notetrack_time(animation, notetrack) {
  _id_095ACA96EE2618FE = getnotetracktimes(animation, notetrack);
  animlength = getanimlength(animation);
  return _id_095ACA96EE2618FE[0] * animlength;
}

mph_to_ips(_id_360E0B041DF08CAC) {
  return _id_360E0B041DF08CAC * 17.6;
}

ips_to_mph(_id_FEC47A03F66BCA81) {
  return _id_FEC47A03F66BCA81 * 0.056818;
}

_id_DD1C9564BBDDA261(_id_31778F4C079763E8) {
  return _id_31778F4C079763E8 * 20.2537;
}

_id_DE54C0137BBB0D7F(_id_FEC47A03F66BCA81) {
  return _id_FEC47A03F66BCA81 * 0.049374;
}

wrap_text(text, _id_B7977DE916377E7F) {
  _id_4E401DFEBA20836C = strtok(text, " ");
  _id_BD3760DA5DA76918 = "";
  lines = [];
  _id_AC0E594AC96AA3A8 = 0;
  _id_83083665867953DA = 0;

  foreach(_id_33A6B5144EFB9971 in _id_4E401DFEBA20836C) {
    if(_id_83083665867953DA > _id_B7977DE916377E7F) {
      lines[lines.size] = _id_BD3760DA5DA76918;
      _id_BD3760DA5DA76918 = "";
      _id_83083665867953DA = 0;
    }

    _id_83083665867953DA = _id_83083665867953DA + _id_33A6B5144EFB9971.size;
    _id_BD3760DA5DA76918 = _id_BD3760DA5DA76918 + _id_33A6B5144EFB9971;

    if(_id_AC0E594AC96AA3A8 != _id_4E401DFEBA20836C.size - 1)
      _id_BD3760DA5DA76918 = _id_BD3760DA5DA76918 + " ";
    else
      lines[lines.size] = _id_BD3760DA5DA76918;

    _id_AC0E594AC96AA3A8++;
  }

  return lines;
}

closestdistancebetweenlines(p1, p2, p3, p4) {
  _id_B07A03030126F1CF = p1 - p3;
  _id_B0900303013F2502 = p4 - p3;

  if(abs(_id_B0900303013F2502[0]) < 0.000001 && abs(_id_B0900303013F2502[1]) < 0.000001 && abs(_id_B0900303013F2502[2]) < 0.000001)
    return undefined;

  _id_B0757D030121D546 = p2 - p1;

  if(abs(_id_B0757D030121D546[0]) < 0.000001 && abs(_id_B0757D030121D546[1]) < 0.000001 && abs(_id_B0757D030121D546[2]) < 0.000001)
    return undefined;

  _id_408571DE858307BA = _id_B07A03030126F1CF[0] * _id_B0900303013F2502[0] + _id_B07A03030126F1CF[1] * _id_B0900303013F2502[1] + _id_B07A03030126F1CF[2] * _id_B0900303013F2502[2];
  _id_8960DF99C11F9067 = _id_B0900303013F2502[0] * _id_B0757D030121D546[0] + _id_B0900303013F2502[1] * _id_B0757D030121D546[1] + _id_B0900303013F2502[2] * _id_B0757D030121D546[2];
  _id_406AEBDE8565B7FE = _id_B07A03030126F1CF[0] * _id_B0757D030121D546[0] + _id_B07A03030126F1CF[1] * _id_B0757D030121D546[1] + _id_B07A03030126F1CF[2] * _id_B0757D030121D546[2];
  _id_8957D199C11552EF = _id_B0900303013F2502[0] * _id_B0900303013F2502[0] + _id_B0900303013F2502[1] * _id_B0900303013F2502[1] + _id_B0900303013F2502[2] * _id_B0900303013F2502[2];
  _id_E42AE1C5CC95A473 = _id_B0757D030121D546[0] * _id_B0757D030121D546[0] + _id_B0757D030121D546[1] * _id_B0757D030121D546[1] + _id_B0757D030121D546[2] * _id_B0757D030121D546[2];
  _id_19F39AE6916CE0A0 = _id_E42AE1C5CC95A473 * _id_8957D199C11552EF - _id_8960DF99C11F9067 * _id_8960DF99C11F9067;

  if(abs(_id_19F39AE6916CE0A0) < 0.000001)
    return undefined;

  _id_91EE1CC8355A7954 = _id_408571DE858307BA * _id_8960DF99C11F9067 - _id_406AEBDE8565B7FE * _id_8957D199C11552EF;
  _id_360120041DE2A656 = _id_91EE1CC8355A7954 / _id_19F39AE6916CE0A0;
  _id_36011F041DE2A423 = (_id_408571DE858307BA + _id_8960DF99C11F9067 * _id_360120041DE2A656) / _id_8957D199C11552EF;
  _id_CDCD3C78F5177DB6 = p1 + _id_360120041DE2A656 * _id_B0757D030121D546;
  _id_CDCD3B78F5177B83 = p3 + _id_36011F041DE2A423 * _id_B0900303013F2502;
  _id_770E3BEDD2B80D9B = [_id_CDCD3C78F5177DB6, _id_CDCD3B78F5177B83, distance(_id_CDCD3C78F5177DB6, _id_CDCD3B78F5177B83)];
  return _id_770E3BEDD2B80D9B;
}

closestdistancebetweensegments(p1, p2, p3, p4) {
  _id_1475E79F109C6E12 = p2 - p1;
  _id_A551E37FB07571F7 = p4 - p3;
  _id_373E28595F2BDBCC = p1 - p3;
  _id_B1EFC20302C1C93F = vectordot(_id_1475E79F109C6E12, _id_1475E79F109C6E12);
  _id_B1EFC10302C1C70C = vectordot(_id_1475E79F109C6E12, _id_A551E37FB07571F7);
  _id_A020A802F47DEA27 = vectordot(_id_A551E37FB07571F7, _id_A551E37FB07571F7);
  _id_B1EFBF0302C1C2A6 = vectordot(_id_1475E79F109C6E12, _id_373E28595F2BDBCC);
  _id_A020A602F47DE5C1 = vectordot(_id_A551E37FB07571F7, _id_373E28595F2BDBCC);
  _id_70F12A6417224BC8 = _id_B1EFC20302C1C93F * _id_A020A802F47DEA27 - _id_B1EFC10302C1C70C * _id_B1EFC10302C1C70C;
  _id_4A7435B0CF1A9805 = _id_70F12A6417224BC8;
  _id_4A7434B0CF1A95D2 = _id_70F12A6417224BC8;
  _id_06E7F8ED0BF7F4F3 = 0;
  _id_0C3B4364038F5528 = 0;
  _id_06E7F7ED0BF7F2C0 = 0;
  _id_0C3B4464038F575B = 0;

  if(_id_70F12A6417224BC8 < 0.00000001) {
    _id_0C3B4364038F5528 = 0;
    _id_4A7435B0CF1A9805 = 1;
    _id_0C3B4464038F575B = _id_A020A602F47DE5C1;
    _id_4A7434B0CF1A95D2 = _id_A020A802F47DEA27;
  } else {
    _id_0C3B4364038F5528 = _id_B1EFC10302C1C70C * _id_A020A602F47DE5C1 - _id_A020A802F47DEA27 * _id_B1EFBF0302C1C2A6;
    _id_0C3B4464038F575B = _id_B1EFC20302C1C93F * _id_A020A602F47DE5C1 - _id_B1EFC10302C1C70C * _id_B1EFBF0302C1C2A6;

    if(_id_0C3B4364038F5528 < 0.0) {
      _id_0C3B4364038F5528 = 0;
      _id_0C3B4464038F575B = _id_A020A602F47DE5C1;
      _id_4A7434B0CF1A95D2 = _id_A020A802F47DEA27;
    } else if(_id_0C3B4364038F5528 > _id_4A7435B0CF1A9805) {
      _id_0C3B4364038F5528 = _id_4A7435B0CF1A9805;
      _id_0C3B4464038F575B = _id_A020A602F47DE5C1 + _id_B1EFC10302C1C70C;
      _id_4A7434B0CF1A95D2 = _id_A020A802F47DEA27;
    }
  }

  if(_id_0C3B4464038F575B < 0.0) {
    _id_0C3B4464038F575B = 0.0;

    if(_id_B1EFBF0302C1C2A6 * -1 < 0.0)
      _id_0C3B4364038F5528 = 0.0;
    else if(_id_B1EFBF0302C1C2A6 * -1 > _id_B1EFC20302C1C93F)
      _id_0C3B4364038F5528 = _id_4A7435B0CF1A9805;
    else {
      _id_0C3B4364038F5528 = _id_B1EFBF0302C1C2A6 * -1;
      _id_4A7435B0CF1A9805 = _id_B1EFC20302C1C93F;
    }
  } else if(_id_0C3B4464038F575B > _id_4A7434B0CF1A95D2) {
    _id_0C3B4464038F575B = _id_4A7434B0CF1A95D2;

    if(_id_B1EFC10302C1C70C - _id_B1EFBF0302C1C2A6 < 0.0)
      _id_0C3B4364038F5528 = 0;
    else if(_id_B1EFC10302C1C70C - _id_B1EFBF0302C1C2A6 > _id_B1EFC20302C1C93F)
      _id_0C3B4364038F5528 = _id_4A7435B0CF1A9805;
    else {
      _id_0C3B4364038F5528 = _id_B1EFC10302C1C70C - _id_B1EFBF0302C1C2A6;
      _id_4A7435B0CF1A9805 = _id_B1EFC20302C1C93F;
    }
  }

  if(abs(_id_0C3B4364038F5528) > 0.00000001)
    _id_06E7F8ED0BF7F4F3 = _id_0C3B4364038F5528 / _id_4A7435B0CF1A9805;

  if(abs(_id_0C3B4464038F575B) > 0.00000001)
    _id_06E7F7ED0BF7F2C0 = _id_0C3B4464038F575B / _id_4A7434B0CF1A95D2;

  _id_CDCD3C78F5177DB6 = p1 + _id_06E7F8ED0BF7F4F3 * _id_1475E79F109C6E12;
  _id_CDCD3B78F5177B83 = p3 + _id_06E7F7ED0BF7F2C0 * _id_A551E37FB07571F7;
  _id_770E3BEDD2B80D9B = [_id_CDCD3C78F5177DB6, _id_CDCD3B78F5177B83, distance(_id_CDCD3C78F5177DB6, _id_CDCD3B78F5177B83)];
  return _id_770E3BEDD2B80D9B;
}

is_dead_sentient() {
  return issentient(self) && !isalive(self);
}

hastag(model, tag) {
  if(!isDefined(model) || model == "")
    return 0;

  if(!isDefined(level.has_tag))
    level.has_tag = [];

  key = model + "_" + tag;

  if(isDefined(level.has_tag[key]))
    return level.has_tag[key];

  _id_CD148482D2898BE7 = getnumparts(model);

  if(_id_CD148482D2898BE7 > 0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_CD148482D2898BE7; _id_AC0E594AC96AA3A8++) {
      partname = getpartname(model, _id_AC0E594AC96AA3A8);

      if(partname == tolower(tag)) {
        level.has_tag[key] = 1;
        return 1;
      }
    }

    level.has_tag[key] = 0;
  }

  return 0;
}

flashbanggettimeleftsec() {
  _id_5659806E75F89695 = self.flashendtime - gettime();

  if(_id_5659806E75F89695 < 0)
    return 0;

  return _id_5659806E75F89695 * 0.001;
}

flashbangisactive() {
  return flashbanggettimeleftsec() > 0;
}

string(num) {
  return "" + num;
}

playsoundontag(alias, tag, _id_49FDBA4C56715050, _id_B426F32755673BA6, _id_510AF7464E264F89) {
  [[level.fnplaysoundontag]](alias, tag, _id_49FDBA4C56715050, _id_B426F32755673BA6, _id_510AF7464E264F89);
}

playsoundonentity(alias, _id_B426F32755673BA6) {
  [[level.fnplaysoundonentity]](alias, _id_B426F32755673BA6);
}

set_movement_speed(_id_9743A24AC8368484) {
  self._blackboard.requestedspeed = _id_9743A24AC8368484;
  self aisetdesiredspeed(_id_9743A24AC8368484);
}

set_cautious_navigation(enabled) {
  self.cautiousnavigation = enabled;
}

doinglongdeath() {
  return istrue(self.doinglongdeath);
}

is_dead_or_dying(guy) {
  if(!isDefined(guy))
    return 1;

  if(isai(guy))
    return !isalive(guy) || guy doinglongdeath();
  else if(issentient(guy))
    return !isalive(guy);

  return 0;
}

motionwarpwithnotetracks(anime, targetpos, targetangles, _id_546E4411CFCD0D3C, _id_90FEE38B006BE705, duration, _id_46CD2EA5C5A1DA17) {
  if(isDefined(_id_546E4411CFCD0D3C)) {
    _id_67B5A24409D655F0 = getnotetracktimes(anime, _id_546E4411CFCD0D3C)[0];

    if(!isDefined(_id_67B5A24409D655F0))
      _id_67B5A24409D655F0 = 0;
  } else
    _id_67B5A24409D655F0 = 0;

  if(isDefined(_id_90FEE38B006BE705)) {
    _id_47B4BDC915CFF70D = getnotetracktimes(anime, _id_90FEE38B006BE705)[0];

    if(!isDefined(_id_47B4BDC915CFF70D))
      _id_47B4BDC915CFF70D = 1;
  } else
    _id_47B4BDC915CFF70D = 1;

  motionwarpwithtimes(anime, targetpos, targetangles, _id_67B5A24409D655F0, _id_47B4BDC915CFF70D, duration, _id_46CD2EA5C5A1DA17);
}

motionwarpwithtimes(anime, targetpos, targetangles, _id_67B5A24409D655F0, _id_47B4BDC915CFF70D, duration, _id_46CD2EA5C5A1DA17) {
  if(!isDefined(_id_46CD2EA5C5A1DA17))
    _id_46CD2EA5C5A1DA17 = 1;

  _id_993A8F9635E274CF = getangledelta(anime, _id_67B5A24409D655F0, _id_47B4BDC915CFF70D);
  _id_292F5D5519D832BF = getmovedelta(anime, _id_67B5A24409D655F0, _id_47B4BDC915CFF70D);
  _id_292F5D5519D832BF = rotatevector(_id_292F5D5519D832BF, (0, targetangles[1] - _id_993A8F9635E274CF, 0));
  _id_BCF9684C0529009A = targetpos - _id_292F5D5519D832BF;
  _id_417BD54C6700695B = targetangles[1] - _id_993A8F9635E274CF;
  _id_F20BC08C9FC211A0 = (targetangles[0], _id_417BD54C6700695B, targetangles[2]);
  _id_07B60BC0EAB3FD1E = 1.0;
  _id_94FBE2A18E7F59B3 = length(targetpos - self.origin);

  if(_id_46CD2EA5C5A1DA17 && _id_94FBE2A18E7F59B3 > 0) {
    _id_07B60BC0EAB3FD1E = length(_id_292F5D5519D832BF) / _id_94FBE2A18E7F59B3;
    _id_07B60BC0EAB3FD1E = clamp(_id_07B60BC0EAB3FD1E, 0.5, 2.0);
    self aisetanimrate(anime, _id_07B60BC0EAB3FD1E);
  }

  if(!isDefined(duration)) {
    animlength = getanimlength(anime) / _id_07B60BC0EAB3FD1E;
    duration = int((_id_47B4BDC915CFF70D - _id_67B5A24409D655F0) * animlength * 1000);
  }

  if(duration < 50)
    duration = 50;

  self motionwarpwithanim(_id_BCF9684C0529009A, _id_F20BC08C9FC211A0, targetpos, targetangles, duration);
  return _id_07B60BC0EAB3FD1E;
}

_id_DF956D52BAE0B61D(anime, _id_539C2DCC0A467746, tag, _id_AE7383494EA7FEF1, _id_B6C5DE4898B7F63B, _id_67B5A24409D655F0, _id_47B4BDC915CFF70D, duration, _id_46CD2EA5C5A1DA17) {
  if(!isDefined(_id_46CD2EA5C5A1DA17))
    _id_46CD2EA5C5A1DA17 = 1;

  if(isDefined(tag)) {
    _id_88AD5FE1080B1129 = _id_539C2DCC0A467746 gettagorigin(tag);
    _id_90FF9AE0521AC213 = _id_539C2DCC0A467746 gettagangles(tag);
  } else {
    _id_88AD5FE1080B1129 = _id_539C2DCC0A467746.origin;
    _id_90FF9AE0521AC213 = _id_539C2DCC0A467746.angles;
    tag = "";
  }

  _id_5B76633F106FD420 = _id_88AD5FE1080B1129 + rotatevector(_id_AE7383494EA7FEF1, _id_90FF9AE0521AC213);
  _id_8248003E7165C71E = combineangles(_id_B6C5DE4898B7F63B, _id_90FF9AE0521AC213);
  _id_5201FBA058886642 = getangledelta3d(anime, _id_67B5A24409D655F0, _id_47B4BDC915CFF70D);
  _id_D782B8F3A2E29390 = getmovedelta(anime, _id_67B5A24409D655F0, _id_47B4BDC915CFF70D);
  _id_F7BD065066FEBEBF = invertangles(_id_5201FBA058886642);
  _id_F03BD42B04EE3DCA = combineangles(_id_8248003E7165C71E, _id_F7BD065066FEBEBF);
  _id_CA6BE8926624ACBF = rotatevector(-1.0 * _id_D782B8F3A2E29390, _id_F7BD065066FEBEBF);
  _id_CA86ACBC27E4A31C = rotatevector(_id_CA6BE8926624ACBF, _id_8248003E7165C71E);
  _id_C9F74F2BA493D174 = _id_5B76633F106FD420 + _id_CA86ACBC27E4A31C;
  _id_7B1C8FCEBB9C392D = self.origin - _id_88AD5FE1080B1129;
  _id_ED38213B0A9AF604 = invertangles(_id_90FF9AE0521AC213);
  _id_AE7383494EA7FEF1 = rotatevector(_id_7B1C8FCEBB9C392D, _id_ED38213B0A9AF604);
  _id_B6C5DE4898B7F63B = combineangles(self.angles, _id_ED38213B0A9AF604);
  _id_07B60BC0EAB3FD1E = 1.0;
  _id_94FBE2A18E7F59B3 = length(_id_5B76633F106FD420 - self.origin);

  if(_id_46CD2EA5C5A1DA17 && _id_94FBE2A18E7F59B3 > 0) {
    _id_07B60BC0EAB3FD1E = length(_id_D782B8F3A2E29390) / _id_94FBE2A18E7F59B3;
    _id_07B60BC0EAB3FD1E = clamp(_id_07B60BC0EAB3FD1E, 0.5, 2.0);
    self aisetanimrate(anime, _id_07B60BC0EAB3FD1E);
  }

  if(!isDefined(duration)) {
    animlength = getanimlength(anime) / _id_07B60BC0EAB3FD1E;
    duration = int((_id_47B4BDC915CFF70D - _id_67B5A24409D655F0) * animlength * 1000);
  }

  if(duration < 50)
    duration = 50;

  self linktomoveoffset(_id_539C2DCC0A467746, tag, _id_AE7383494EA7FEF1, _id_B6C5DE4898B7F63B);
  self motionwarpwithanim(_id_C9F74F2BA493D174, _id_F03BD42B04EE3DCA, _id_5B76633F106FD420, _id_8248003E7165C71E, duration);
}

waittill_any_ents_or_timeout_return(timeout, _id_6848D0559BA20855, _id_0E7865AE7BE35347, _id_6848CD559BA201BC, _id_0E7866AE7BE3557A, _id_6848CE559BA203EF, _id_0E7867AE7BE357AD, _id_6848CB559BA1FD56, _id_0E7860AE7BE34848, _id_6848CC559BA1FF89, _id_0E7861AE7BE34A7B, _id_6848C9559BA1F8F0, _id_0E7862AE7BE34CAE, _id_6848CA559BA1FB23, _id_0E7863AE7BE34EE1) {
  self endon("death");
  ent = spawnStruct();
  _id_6848D0559BA20855 childthread waittill_string(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_6848CD559BA201BC) && isDefined(_id_0E7866AE7BE3557A))
    _id_6848CD559BA201BC childthread waittill_string(_id_0E7866AE7BE3557A, ent);

  if(isDefined(_id_6848CE559BA203EF) && isDefined(_id_0E7867AE7BE357AD))
    _id_6848CE559BA203EF childthread waittill_string(_id_0E7867AE7BE357AD, ent);

  if(isDefined(_id_6848CB559BA1FD56) && isDefined(_id_0E7860AE7BE34848))
    _id_6848CB559BA1FD56 childthread waittill_string(_id_0E7860AE7BE34848, ent);

  if(isDefined(_id_6848CC559BA1FF89) && isDefined(_id_0E7861AE7BE34A7B))
    _id_6848CC559BA1FF89 childthread waittill_string(_id_0E7861AE7BE34A7B, ent);

  if(isDefined(_id_6848C9559BA1F8F0) && isDefined(_id_0E7862AE7BE34CAE))
    _id_6848C9559BA1F8F0 childthread waittill_string(_id_0E7862AE7BE34CAE, ent);

  if(isDefined(_id_6848CA559BA1FB23) && isDefined(_id_0E7863AE7BE34EE1))
    _id_6848CA559BA1FB23 childthread waittill_string(_id_0E7863AE7BE34EE1, ent);

  ent childthread _id_2C91B6C857AA73CC(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

time_has_passed(timestamp, _id_CC748B6D457627FE) {
  if(!isDefined(timestamp))
    return 0;

  return gettime() - timestamp >= _id_CC748B6D457627FE * 1000;
}

reacttolightifpossible(_id_24CD9408147D26C5) {
  self.lightreaction_lightorigin = _id_24CD9408147D26C5;
  self.lightreaction_requesttime = gettime();
}

setcovercrouchtype(_id_15604D8704252FC4) {
  switch (_id_15604D8704252FC4) {
    case "right":
      self.covercrouchtype = "Cover Right Crouch";
      break;
    case "left":
      self.covercrouchtype = "Cover Left Crouch";
      break;
    case "crouch":
    default:
      self.covercrouchtype = "Cover Crouch";
  }
}

setcornerstepoutsdisabled(disabled) {
  self.cornerstepoutsdisabled = istrue(disabled);
}

getcornerstepoutsdisabled() {
  return istrue(self.cornerstepoutsdisabled);
}

can_trace_to_ai(start, ai, _id_E46614399B985851, contentoverride) {
  if(isent(self) || isai(self))
    _id_B4AF0F77EFF08A06 = [self, ai];
  else
    _id_B4AF0F77EFF08A06 = [ai];

  if(isDefined(_id_E46614399B985851))
    _id_B4AF0F77EFF08A06 = array_combine(_id_B4AF0F77EFF08A06, _id_E46614399B985851);

  _id_C56207BDA09B3A36 = ter_op(isDefined(contentoverride), contentoverride, scripts\engine\trace::create_default_contents());
  return _func_D291656CEA83ED81(ai, start, _id_E46614399B985851, _id_C56207BDA09B3A36);
}

array_removedead_or_dying(array, _id_5C3B6418C0AD64AE) {
  if(!isDefined(_id_5C3B6418C0AD64AE))
    _id_5C3B6418C0AD64AE = 1;

  _id_BFC65A378A6D8EFE = [];

  foreach(_id_80EF668C09FFB70F in array) {
    if(!isalive(_id_80EF668C09FFB70F)) {
      continue;
    }
    if(isai(_id_80EF668C09FFB70F) && _id_5C3B6418C0AD64AE && _id_80EF668C09FFB70F doinglongdeath()) {
      continue;
    }
    _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = _id_80EF668C09FFB70F;
  }

  return _id_BFC65A378A6D8EFE;
}

disable_pain() {
  self.a.disablepain = 1;
  self.allowpain = 0;
}

enable_pain() {
  self.a.disablepain = 0;
  self.allowpain = 1;
}

get_ai_number() {
  if(!isDefined(self.unique_id))
    set_ai_number();

  return self.unique_id;
}

set_ai_number() {
  if(!isDefined(level.ai_number))
    level.ai_number = 0;

  self.unique_id = "ai" + level.ai_number;
  level.ai_number++;
}

_id_82581894F5A1C71C() {
  self._id_8AA9EFE6383C1D5A = "ai" + _func_E777ACC966FBD44D();
  _func_67A97472E5A6C64C();
}

ent_flag_wait(msg) {
  while(isDefined(self) && !ent_flag(msg))
    self waittill(msg);
}

array_ent_flag_wait(entities, flag) {
  _id_624F473FE3EE62F1 = spawnStruct();

  foreach(entity in entities) {
    if(entity ent_flag(flag))
      entities = array_remove(entities, entity);
  }

  array_thread(entities, ::array_ent_flag_wait_proc, _id_624F473FE3EE62F1, flag);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < entities.size; _id_AC0E594AC96AA3A8++)
    _id_624F473FE3EE62F1 waittill("notify");
}

array_ent_flag_wait_proc(_id_624F473FE3EE62F1, flag) {
  ent_flag_wait(flag);
  _id_624F473FE3EE62F1 notify("notify");
}

ent_flag_wait_vehicle_node(msg) {
  while(isDefined(self) && !ent_flag(msg))
    self waittill(msg);
}

ent_flag_wait_either(flag1, _id_5228090A1CF6F05B) {
  while(isDefined(self)) {
    if(ent_flag(flag1)) {
      return;
    }
    if(ent_flag(_id_5228090A1CF6F05B)) {
      return;
    }
    waittill_either(flag1, _id_5228090A1CF6F05B);
  }
}

_id_243C46EE6332C45D(flags) {
  flags = array_removeundefined(flags);

  for(;;) {
    foreach(flagname in flags)
    ent_flag_wait(flagname);

    _id_C8C20AD7B4271D20 = 0;

    foreach(flagname in flags) {
      if(ent_flag(flagname))
        _id_C8C20AD7B4271D20++;
    }

    if(_id_C8C20AD7B4271D20 == flags.size) {
      break;
    }
  }
}

_id_CBA0984334BA3279(flags) {
  flags = array_removeundefined(flags);

  for(;;) {
    foreach(flagname in flags)
    ent_flag_waitopen(flagname);

    _id_E9EDCC859DF58C2E = 0;

    foreach(flagname in flags) {
      if(!ent_flag(flagname))
        _id_E9EDCC859DF58C2E++;
    }

    if(_id_E9EDCC859DF58C2E == flags.size) {
      break;
    }
  }
}

_id_E205428B44D1A83C(flags) {
  flags = array_removeundefined(flags);

  while(isDefined(self)) {
    foreach(flagname in flags) {
      if(!ent_flag(flagname))
        return;
    }

    waittill_any_in_array_return(flags);
  }
}

ent_flag_wait_or_timeout(flagname, timer) {
  start_time = gettime();

  while(isDefined(self)) {
    if(ent_flag(flagname)) {
      break;
    }

    if(gettime() >= start_time + timer * 1000) {
      break;
    }

    ent_wait_for_flag_or_time_elapses(flagname, timer);
  }
}

ent_wait_for_flag_or_time_elapses(flagname, timer) {
  self endon(flagname);
  wait(timer);
}

ent_flag_waitopen(msg) {
  while(isDefined(self) && ent_flag(msg))
    self waittill(msg);
}

ent_flag_assert(msg) {}

ent_flag_waitopen_either(flag1, _id_5228090A1CF6F05B) {
  while(isDefined(self)) {
    if(!ent_flag(flag1)) {
      return;
    }
    if(!ent_flag(_id_5228090A1CF6F05B)) {
      return;
    }
    waittill_either(flag1, _id_5228090A1CF6F05B);
  }
}

ent_flag_init(message) {
  if(!isDefined(self.ent_flag)) {
    self.ent_flag = [];
    self.ent_flags_lock = [];
  }

  self.ent_flag[message] = 0;
}

ent_flag_exist(message) {
  if(isDefined(self.ent_flag) && isDefined(self.ent_flag[message]))
    return 1;

  return 0;
}

ent_flag_set_delayed(message, delay) {
  self endon("death");
  wait(delay);
  ent_flag_set(message);
}

ent_flag_set(message) {
  if(!ent_flag_exist(message))
    ent_flag_init(message);

  self.ent_flag[message] = 1;
  self notify(message);
}

ent_flag_clear(message, _id_91CA07907A589301) {
  if(ent_flag(message)) {
    self.ent_flag[message] = 0;
    self notify(message);
  }

  if(ent_flag_exist(message) && istrue(_id_91CA07907A589301))
    self.ent_flag[message] = undefined;
}

ent_flag_clear_delayed(message, delay) {
  wait(delay);

  if(isDefined(self))
    ent_flag_clear(message);
}

ent_flag(message) {
  return ent_flag_exist(message) && self.ent_flag[message];
}

get_linked_structs() {
  array = [];

  if(isDefined(self.script_linkto)) {
    _id_B11F91C17FEEAB8F = get_links();

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B11F91C17FEEAB8F.size; _id_AC0E594AC96AA3A8++) {
      _id_9E4E1482CB40C9C5 = getStructArray(_id_B11F91C17FEEAB8F[_id_AC0E594AC96AA3A8], "script_linkname");

      if(_id_9E4E1482CB40C9C5.size > 0)
        array = array_combine(array, _id_9E4E1482CB40C9C5);
    }
  }

  return array;
}

ispointinsidecircle(point, circlecenter, circleradius) {
  if(squared(point[0] - circlecenter[0]) + squared(point[1] - circlecenter[1]) <= squared(circleradius))
    return 1;

  return 0;
}

requestgamerprofile(_id_D40DB77FEC61D6A4) {
  level endon("game_ended");
  self endon("disconnect");
  self sendrequestgamerprofilecmd(_id_D40DB77FEC61D6A4);

  for(;;) {
    self waittill("luinotifyserver", _id_7148C1A6F25491F8, value);

    if(_id_7148C1A6F25491F8 == "gamerprofile_request")
      return value;
  }
}

ismountconfigenabled() {
  _id_6C9FE414D3F3D966 = 1;
  _id_CBA848F4746412E0 = 0;

  if(is_player_gamepad_enabled())
    _id_CBA848F4746412E0 = requestgamerprofile("mountButtonConfig");
  else
    _id_CBA848F4746412E0 = requestgamerprofile("mountButtonConfigKBM");

  return _id_CBA848F4746412E0 != _id_6C9FE414D3F3D966;
}

getintorzero(value) {
  if(isnumber(value))
    return int(value);
  else
    return 0;
}

stringtovec3(input) {
  _id_3068716C250A5E58 = (0, 0, 0);
  values = strtok(input, " ");

  if(values.size == 3)
    _id_3068716C250A5E58 = (float(values[0]), float(values[1]), float(values[2]));

  return _id_3068716C250A5E58;
}

_id_79C374AB1CA30CC9(capacity) {
  queue = spawnStruct();
  queue.capacity = capacity;
  queue.array = [];
  queue._id_CFF021654A47B60C = 0;
  queue._id_3CF7BCC5D5B639A7 = -1;
  return queue;
}

_id_6CF786A6CF335CB9(queue, object) {
  if(queue.array.size == queue.capacity)
    return queue;

  if(queue.array.size != queue.capacity && queue._id_3CF7BCC5D5B639A7 + 1 >= queue.capacity)
    queue._id_3CF7BCC5D5B639A7 = 0;
  else
    queue._id_3CF7BCC5D5B639A7++;

  queue.array[queue._id_3CF7BCC5D5B639A7] = object;
  return queue;
}

_id_93DEF91A50927481(queue) {
  if(queue.array.size == 0)
    return queue;

  queue.array[queue._id_CFF021654A47B60C] = undefined;

  if(queue.array.size > 0 && queue._id_CFF021654A47B60C + 1 >= queue.capacity)
    queue._id_CFF021654A47B60C = 0;
  else
    queue._id_CFF021654A47B60C++;

  if(queue.array.size == 0) {
    queue._id_CFF021654A47B60C = 0;
    queue._id_3CF7BCC5D5B639A7 = -1;
  }

  return queue;
}

_id_73D8A9394FC5EDA2(queue) {
  if(queue.array.size == 0)
    return undefined;

  return queue.array[queue._id_CFF021654A47B60C];
}

_id_CEFB274DA21A8368(queue) {
  return queue.array.size;
}

_id_40158914705D536E(queue) {
  queue.array = [];
  queue._id_CFF021654A47B60C = 0;
  queue._id_3CF7BCC5D5B639A7 = -1;
  return queue.array.size;
}

_id_45FAD871D0BEE0F2(queue) {
  return queue.array.size == 0;
}

_id_A6025442A4E1C649(queue, object) {
  if(!isDefined(queue) || !isDefined(object))
    return 0;

  _id_BFDC386F35FB8E5A = 0;

  for(_id_AC0E594AC96AA3A8 = queue._id_CFF021654A47B60C; _id_BFDC386F35FB8E5A < queue.array.size; _id_BFDC386F35FB8E5A++) {
    if(!isDefined(queue.array[_id_AC0E594AC96AA3A8])) {
      continue;
    }
    if(queue.array[_id_AC0E594AC96AA3A8] == object)
      return 1;

    if(_id_AC0E594AC96AA3A8 + 1 >= queue.capacity) {
      _id_AC0E594AC96AA3A8 = 0;
      continue;
    }

    _id_AC0E594AC96AA3A8++;
  }

  return 0;
}

_id_C89ED1840C8D0F0F(_id_5A888D1F754C231F) {
  return _id_5A888D1F754C231F * 0.001;
}

_id_A5B14435E3229BED(_id_CC748B6D457627FE) {
  return _id_CC748B6D457627FE * 1000.0;
}

_id_1938945BF612F9FE(entity, func, _id_1177340D864D95EF) {
  _id_89F7229C272A6A8A(entity, func, undefined, undefined, _id_1177340D864D95EF);
}

_id_8A68123E2BBB5BA4(entity, func, _id_43484BFD34BB5006, _id_1177340D864D95EF) {
  _id_89F7229C272A6A8A(entity, func, _id_43484BFD34BB5006, undefined, _id_1177340D864D95EF);
}

_id_8A68133E2BBB5DD7(entity, func, _id_43484BFD34BB5006, _id_43484AFD34BB4DD3, _id_1177340D864D95EF) {
  _id_89F7229C272A6A8A(entity, func, _id_43484BFD34BB5006, _id_43484AFD34BB4DD3, _id_1177340D864D95EF);
}

_id_89F7229C272A6A8A(entity, func, _id_43484BFD34BB5006, _id_43484AFD34BB4DD3, _id_1177340D864D95EF) {
  _id_1177340D864D95EF = _id_D13634FDB31BEEAF(_id_1177340D864D95EF);

  if(!isfunction(func)) {
    return;
  }
  if(isDefined(_id_43484AFD34BB4DD3)) {
    switch (_id_1177340D864D95EF.size) {
      case 8:
        entity thread[[func]](_id_43484BFD34BB5006, _id_43484AFD34BB4DD3, _id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2], _id_1177340D864D95EF[3], _id_1177340D864D95EF[4], _id_1177340D864D95EF[5], _id_1177340D864D95EF[6], _id_1177340D864D95EF[7]);
        break;
      case 7:
        entity thread[[func]](_id_43484BFD34BB5006, _id_43484AFD34BB4DD3, _id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2], _id_1177340D864D95EF[3], _id_1177340D864D95EF[4], _id_1177340D864D95EF[5], _id_1177340D864D95EF[6]);
        break;
      case 6:
        entity thread[[func]](_id_43484BFD34BB5006, _id_43484AFD34BB4DD3, _id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2], _id_1177340D864D95EF[3], _id_1177340D864D95EF[4], _id_1177340D864D95EF[5]);
        break;
      case 5:
        entity thread[[func]](_id_43484BFD34BB5006, _id_43484AFD34BB4DD3, _id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2], _id_1177340D864D95EF[3], _id_1177340D864D95EF[4]);
        break;
      case 4:
        entity thread[[func]](_id_43484BFD34BB5006, _id_43484AFD34BB4DD3, _id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2], _id_1177340D864D95EF[3]);
        break;
      case 3:
        entity thread[[func]](_id_43484BFD34BB5006, _id_43484AFD34BB4DD3, _id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2]);
        break;
      case 2:
        entity thread[[func]](_id_43484BFD34BB5006, _id_43484AFD34BB4DD3, _id_1177340D864D95EF[0], _id_1177340D864D95EF[1]);
        break;
      case 1:
        entity thread[[func]](_id_43484BFD34BB5006, _id_43484AFD34BB4DD3, _id_1177340D864D95EF[0]);
        break;
      case 0:
        entity thread[[func]](_id_43484BFD34BB5006, _id_43484AFD34BB4DD3);
        break;
      default:
    }
  } else if(isDefined(_id_43484BFD34BB5006)) {
    switch (_id_1177340D864D95EF.size) {
      case 8:
        entity thread[[func]](_id_43484BFD34BB5006, _id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2], _id_1177340D864D95EF[3], _id_1177340D864D95EF[4], _id_1177340D864D95EF[5], _id_1177340D864D95EF[6], _id_1177340D864D95EF[7]);
        break;
      case 7:
        entity thread[[func]](_id_43484BFD34BB5006, _id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2], _id_1177340D864D95EF[3], _id_1177340D864D95EF[4], _id_1177340D864D95EF[5], _id_1177340D864D95EF[6]);
        break;
      case 6:
        entity thread[[func]](_id_43484BFD34BB5006, _id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2], _id_1177340D864D95EF[3], _id_1177340D864D95EF[4], _id_1177340D864D95EF[5]);
        break;
      case 5:
        entity thread[[func]](_id_43484BFD34BB5006, _id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2], _id_1177340D864D95EF[3], _id_1177340D864D95EF[4]);
        break;
      case 4:
        entity thread[[func]](_id_43484BFD34BB5006, _id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2], _id_1177340D864D95EF[3]);
        break;
      case 3:
        entity thread[[func]](_id_43484BFD34BB5006, _id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2]);
        break;
      case 2:
        entity thread[[func]](_id_43484BFD34BB5006, _id_1177340D864D95EF[0], _id_1177340D864D95EF[1]);
        break;
      case 1:
        entity thread[[func]](_id_43484BFD34BB5006, _id_1177340D864D95EF[0]);
        break;
      case 0:
        entity thread[[func]](_id_43484BFD34BB5006);
        break;
      default:
    }
  } else {
    switch (_id_1177340D864D95EF.size) {
      case 8:
        entity thread[[func]](_id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2], _id_1177340D864D95EF[3], _id_1177340D864D95EF[4], _id_1177340D864D95EF[5], _id_1177340D864D95EF[6], _id_1177340D864D95EF[7]);
        break;
      case 7:
        entity thread[[func]](_id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2], _id_1177340D864D95EF[3], _id_1177340D864D95EF[4], _id_1177340D864D95EF[5], _id_1177340D864D95EF[6]);
        break;
      case 6:
        entity thread[[func]](_id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2], _id_1177340D864D95EF[3], _id_1177340D864D95EF[4], _id_1177340D864D95EF[5]);
        break;
      case 5:
        entity thread[[func]](_id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2], _id_1177340D864D95EF[3], _id_1177340D864D95EF[4]);
        break;
      case 4:
        entity thread[[func]](_id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2], _id_1177340D864D95EF[3]);
        break;
      case 3:
        entity thread[[func]](_id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2]);
        break;
      case 2:
        entity thread[[func]](_id_1177340D864D95EF[0], _id_1177340D864D95EF[1]);
        break;
      case 1:
        entity thread[[func]](_id_1177340D864D95EF[0]);
        break;
      case 0:
        entity thread[[func]]();
        break;
      default:
    }
  }
}

_id_4F220ACA2909F184(entity, func, _id_1177340D864D95EF) {
  return _id_0A057E1F7CF74F00(entity, func, _id_1177340D864D95EF);
}

_id_0A057E1F7CF74F00(entity, func, _id_1177340D864D95EF) {
  _id_1177340D864D95EF = _id_D13634FDB31BEEAF(_id_1177340D864D95EF);

  switch (_id_1177340D864D95EF.size) {
    case 8:
      if(isDefined(entity))
        return entity[[func]](_id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2], _id_1177340D864D95EF[3], _id_1177340D864D95EF[4], _id_1177340D864D95EF[5], _id_1177340D864D95EF[6], _id_1177340D864D95EF[7]);
      else
        return [[func]](_id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2], _id_1177340D864D95EF[3], _id_1177340D864D95EF[4], _id_1177340D864D95EF[5], _id_1177340D864D95EF[6], _id_1177340D864D95EF[7]);

      break;
    case 7:
      if(isDefined(entity))
        return entity[[func]](_id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2], _id_1177340D864D95EF[3], _id_1177340D864D95EF[4], _id_1177340D864D95EF[5], _id_1177340D864D95EF[6]);
      else
        return [[func]](_id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2], _id_1177340D864D95EF[3], _id_1177340D864D95EF[4], _id_1177340D864D95EF[5], _id_1177340D864D95EF[6]);

      break;
    case 6:
      if(isDefined(entity))
        return entity[[func]](_id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2], _id_1177340D864D95EF[3], _id_1177340D864D95EF[4], _id_1177340D864D95EF[5]);
      else
        return [[func]](_id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2], _id_1177340D864D95EF[3], _id_1177340D864D95EF[4], _id_1177340D864D95EF[5]);

      break;
    case 5:
      if(isDefined(entity))
        return entity[[func]](_id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2], _id_1177340D864D95EF[3], _id_1177340D864D95EF[4]);
      else
        return [[func]](_id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2], _id_1177340D864D95EF[3], _id_1177340D864D95EF[4]);

      break;
    case 4:
      if(isDefined(entity))
        return entity[[func]](_id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2], _id_1177340D864D95EF[3]);
      else
        return [[func]](_id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2], _id_1177340D864D95EF[3]);

      break;
    case 3:
      if(isDefined(entity))
        return entity[[func]](_id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2]);
      else
        return [[func]](_id_1177340D864D95EF[0], _id_1177340D864D95EF[1], _id_1177340D864D95EF[2]);

      break;
    case 2:
      if(isDefined(entity))
        return entity[[func]](_id_1177340D864D95EF[0], _id_1177340D864D95EF[1]);
      else
        return [[func]](_id_1177340D864D95EF[0], _id_1177340D864D95EF[1]);

      break;
    case 1:
      if(isDefined(entity))
        return entity[[func]](_id_1177340D864D95EF[0]);
      else
        return [[func]](_id_1177340D864D95EF[0]);

      break;
    case 0:
      if(isDefined(entity))
        return entity[[func]]();
      else
        return [[func]]();

      break;
    default:
  }
}

_id_D13634FDB31BEEAF(_id_1177340D864D95EF) {
  _id_D9D0128C23712F95 = -1;

  for(_id_AC0E594AC96AA3A8 = _id_1177340D864D95EF.size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
    if(!isDefined(_id_1177340D864D95EF[_id_AC0E594AC96AA3A8])) {
      _id_D9D0128C23712F95 = _id_AC0E594AC96AA3A8;
      continue;
    }

    break;
  }

  if(_id_D9D0128C23712F95 == -1)
    return _id_1177340D864D95EF;

  _id_4C1B085372D0C223 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D9D0128C23712F95; _id_AC0E594AC96AA3A8++)
    _id_4C1B085372D0C223[_id_AC0E594AC96AA3A8] = _id_1177340D864D95EF[_id_AC0E594AC96AA3A8];

  return _id_4C1B085372D0C223;
}

_id_8DDFB5266DAE13F5(_id_16290C9DDA466BCE) {
  return "(" + int(_id_16290C9DDA466BCE[0]) + " " + int(_id_16290C9DDA466BCE[1]) + " " + int(_id_16290C9DDA466BCE[2]) + ")";
}

_id_F6DABB70E2E79B53(_id_D49B300A0C84B099, value, _id_8CB6CA2F9290B958) {
  if(isDefined(_id_D49B300A0C84B099) == 1)
    return _id_D49B300A0C84B099;

  return value;
}

_id_1874CB875BE9F1D1(_id_7C649EC071EBCC7C) {
  if(_id_7C649EC071EBCC7C >= 0)
    return _id_7C649EC071EBCC7C;
  else
    return -1 * _id_7C649EC071EBCC7C;
}

_id_21A6A1C613B50A28(array, _id_80F993E06B4347CB) {
  _id_2B6807C7DF9A2B2D = spawnStruct();
  _id_2B6807C7DF9A2B2D.array = [];
  _id_2B6807C7DF9A2B2D._id_80F993E06B4347CB = _id_80F993E06B4347CB;
  _id_2B6807C7DF9A2B2D._id_8A659781684B3B1B = int(150000 / (2 * _id_80F993E06B4347CB));
  _id_2B6807C7DF9A2B2D._id_92C2DA89C8CCD3C1 = 0;

  foreach(object in array)
  _id_2B6807C7DF9A2B2D _id_24BBEFB4BEDA630D(object);

  return _id_2B6807C7DF9A2B2D;
}

_id_A291B92E71292628() {
  return isDefined(self) && isDefined(self.array) && isDefined(self._id_80F993E06B4347CB) && isDefined(self._id_8A659781684B3B1B);
}

_id_B8E08B6F83441AA2() {
  if(!_id_A291B92E71292628())
    return undefined;

  return self._id_92C2DA89C8CCD3C1;
}

_id_24BBEFB4BEDA630D(object) {
  [x, y] = _id_5B83B054E7F1C193(object.origin);
  _id_56C8714742FF3C04 = self.array[x];

  if(!isDefined(_id_56C8714742FF3C04)) {
    self.array[x] = [];
    _id_56C8714742FF3C04 = [];
  }

  _id_DD613B6808C13588 = _id_56C8714742FF3C04[y];

  if(!isDefined(_id_DD613B6808C13588)) {
    self.array[x][y] = [];
    _id_F9CE76AD7118B7EC = 0;
  } else
    _id_F9CE76AD7118B7EC = _id_DD613B6808C13588.size;

  self.array[x][y][_id_F9CE76AD7118B7EC] = object;
  self._id_92C2DA89C8CCD3C1++;
}

_id_5B83B054E7F1C193(_id_16290C9DDA466BCE) {
  _id_80F993E06B4347CB = self._id_80F993E06B4347CB;
  _id_8A659781684B3B1B = self._id_8A659781684B3B1B;
  x = int(_id_16290C9DDA466BCE[0] / _id_80F993E06B4347CB) + _id_8A659781684B3B1B;

  if(x < 0)
    x = 0;

  y = int(_id_16290C9DDA466BCE[1] / _id_80F993E06B4347CB) + _id_8A659781684B3B1B;

  if(y < 0)
    y = 0;

  return [x, y];
}

_id_9CD3F5F067AFEA37(object) {
  [x, y] = _id_5B83B054E7F1C193(object.origin);
  _id_56C8714742FF3C04 = self.array[x];

  if(isDefined(_id_56C8714742FF3C04) && isDefined(_id_56C8714742FF3C04[y])) {
    if(array_contains(_id_56C8714742FF3C04[y], object)) {
      self.array[x][y] = array_remove(_id_56C8714742FF3C04[y], object);
      self._id_92C2DA89C8CCD3C1--;
    }

    if(self.array[x][y].size == 0) {
      self.array[x][y] = undefined;

      if(self.array[x].size == 0)
        self.array[x] = undefined;
    }
  }
}

_id_99B7CB4906B8CB4F(_id_16290C9DDA466BCE) {
  [x, y] = _id_5B83B054E7F1C193(_id_16290C9DDA466BCE);
  _id_56C8714742FF3C04 = self.array[x];

  if(isDefined(_id_56C8714742FF3C04)) {
    _id_DD613B6808C13588 = _id_56C8714742FF3C04[y];

    if(isDefined(_id_DD613B6808C13588))
      return _id_DD613B6808C13588;
  }

  return [];
}

_id_0DF633F460888A47(_id_16290C9DDA466BCE) {
  [x, y] = _id_5B83B054E7F1C193(_id_16290C9DDA466BCE);
  _id_01CE68048507D396 = [];

  for(_id_6C05446634714247 = -1; _id_6C05446634714247 <= 1; _id_6C05446634714247++) {
    _id_873AC0EBF49BFA38 = x + _id_6C05446634714247;

    if(_id_873AC0EBF49BFA38 < 0) {
      continue;
    }
    _id_56C8714742FF3C04 = self.array[_id_873AC0EBF49BFA38];

    if(!isDefined(_id_56C8714742FF3C04)) {
      continue;
    }
    for(_id_827F335C2225D1EA = -1; _id_827F335C2225D1EA <= 1; _id_827F335C2225D1EA++) {
      _id_476C8C292AF62045 = y + _id_827F335C2225D1EA;

      if(_id_476C8C292AF62045 < 0) {
        continue;
      }
      _id_DD613B6808C13588 = _id_56C8714742FF3C04[_id_476C8C292AF62045];

      if(!isDefined(_id_DD613B6808C13588)) {
        continue;
      }
      _id_01CE68048507D396[_id_01CE68048507D396.size] = _id_DD613B6808C13588;
    }
  }

  return _id_01CE68048507D396;
}

_id_60DBE20F8385F1B0(_id_16290C9DDA466BCE) {
  [x, y] = _id_5B83B054E7F1C193(_id_16290C9DDA466BCE);
  _id_81EE2ED4300C1692 = undefined;
  _id_84D7DE0B98E2E704 = undefined;

  for(_id_6C05446634714247 = -1; _id_6C05446634714247 <= 1; _id_6C05446634714247++) {
    _id_873AC0EBF49BFA38 = x + _id_6C05446634714247;

    if(_id_873AC0EBF49BFA38 < 0) {
      continue;
    }
    _id_56C8714742FF3C04 = self.array[_id_873AC0EBF49BFA38];

    if(!isDefined(_id_56C8714742FF3C04)) {
      continue;
    }
    for(_id_827F335C2225D1EA = -1; _id_827F335C2225D1EA <= 1; _id_827F335C2225D1EA++) {
      _id_476C8C292AF62045 = y + _id_827F335C2225D1EA;

      if(_id_476C8C292AF62045 < 0) {
        continue;
      }
      _id_DD613B6808C13588 = _id_56C8714742FF3C04[_id_476C8C292AF62045];

      if(!isDefined(_id_DD613B6808C13588)) {
        continue;
      }
      foreach(object in _id_DD613B6808C13588) {
        if(!isDefined(object) || !isDefined(object.origin)) {
          continue;
        }
        _id_2E9902F4AF3AA038 = distancesquared(object.origin, _id_16290C9DDA466BCE);

        if(!isDefined(_id_84D7DE0B98E2E704) || _id_2E9902F4AF3AA038 < _id_84D7DE0B98E2E704) {
          _id_84D7DE0B98E2E704 = _id_2E9902F4AF3AA038;
          _id_81EE2ED4300C1692 = object;
        }
      }
    }
  }

  return _id_81EE2ED4300C1692;
}

_id_A655374A990831D8(_id_6848D0559BA20855, _id_0E7865AE7BE35347, _id_6848CD559BA201BC, _id_0E7866AE7BE3557A, _id_6848CE559BA203EF, _id_0E7867AE7BE357AD, _id_6848CB559BA1FD56, _id_0E7860AE7BE34848, _id_6848CC559BA1FF89, _id_0E7861AE7BE34A7B, _id_6848C9559BA1F8F0, _id_0E7862AE7BE34CAE, _id_6848CA559BA1FB23, _id_0E7863AE7BE34EE1) {
  return _id_AC1863F0DEB8A63E(undefined, _id_6848D0559BA20855, _id_0E7865AE7BE35347, _id_6848CD559BA201BC, _id_0E7866AE7BE3557A, _id_6848CE559BA203EF, _id_0E7867AE7BE357AD, _id_6848CB559BA1FD56, _id_0E7860AE7BE34848, _id_6848CC559BA1FF89, _id_0E7861AE7BE34A7B, _id_6848C9559BA1F8F0, _id_0E7862AE7BE34CAE, _id_6848CA559BA1FB23, _id_0E7863AE7BE34EE1);
}

_id_AC1863F0DEB8A63E(timeout, _id_6848D0559BA20855, _id_0E7865AE7BE35347, _id_6848CD559BA201BC, _id_0E7866AE7BE3557A, _id_6848CE559BA203EF, _id_0E7867AE7BE357AD, _id_6848CB559BA1FD56, _id_0E7860AE7BE34848, _id_6848CC559BA1FF89, _id_0E7861AE7BE34A7B, _id_6848C9559BA1F8F0, _id_0E7862AE7BE34CAE, _id_6848CA559BA1FB23, _id_0E7863AE7BE34EE1) {
  self endon("death");
  context = spawnStruct();
  context._id_A83666B52AB41E0D = 0;
  context._id_9166FB2E27ECB4B1 = isDefined(_id_6848D0559BA20855) && isDefined(_id_0E7865AE7BE35347) && _id_0E7865AE7BE35347 == "death" || isDefined(_id_6848CD559BA201BC) && isDefined(_id_0E7866AE7BE3557A) && _id_0E7866AE7BE3557A == "death" || isDefined(_id_6848CE559BA203EF) && isDefined(_id_0E7867AE7BE357AD) && _id_0E7867AE7BE357AD == "death" || isDefined(_id_6848CB559BA1FD56) && isDefined(_id_0E7860AE7BE34848) && _id_0E7860AE7BE34848 == "death" || isDefined(_id_6848CC559BA1FF89) && isDefined(_id_0E7861AE7BE34A7B) && _id_0E7861AE7BE34A7B == "death" || isDefined(_id_6848C9559BA1F8F0) && isDefined(_id_0E7862AE7BE34CAE) && _id_0E7862AE7BE34CAE == "death" || isDefined(_id_6848CA559BA1FB23) && isDefined(_id_0E7863AE7BE34EE1) && _id_0E7863AE7BE34EE1 == "death";
  _id_24B0694682C6934A(_id_6848D0559BA20855, _id_0E7865AE7BE35347, context);

  if(isDefined(_id_6848CD559BA201BC) && isDefined(_id_0E7866AE7BE3557A))
    _id_24B0694682C6934A(_id_6848CD559BA201BC, _id_0E7866AE7BE3557A, context);

  if(isDefined(_id_6848CE559BA203EF) && isDefined(_id_0E7867AE7BE357AD))
    _id_24B0694682C6934A(_id_6848CE559BA203EF, _id_0E7867AE7BE357AD, context);

  if(isDefined(_id_6848CB559BA1FD56) && isDefined(_id_0E7860AE7BE34848))
    _id_24B0694682C6934A(_id_6848CB559BA1FD56, _id_0E7860AE7BE34848, context);

  if(isDefined(_id_6848CC559BA1FF89) && isDefined(_id_0E7861AE7BE34A7B))
    _id_24B0694682C6934A(_id_6848CC559BA1FF89, _id_0E7861AE7BE34A7B, context);

  if(isDefined(_id_6848C9559BA1F8F0) && isDefined(_id_0E7862AE7BE34CAE))
    _id_24B0694682C6934A(_id_6848C9559BA1F8F0, _id_0E7862AE7BE34CAE, context);

  if(isDefined(_id_6848CA559BA1FB23) && isDefined(_id_0E7863AE7BE34EE1))
    _id_24B0694682C6934A(_id_6848CA559BA1FB23, _id_0E7863AE7BE34EE1, context);

  if(isDefined(timeout))
    context childthread _id_2C91B6C857AA73CC(timeout);

  context waittill("returned", msg);
  context notify("die");
  return msg;
}

_id_24B0694682C6934A(entity, message, context) {
  entity childthread waittill_string(message, context);

  if(!context._id_9166FB2E27ECB4B1) {
    context._id_A83666B52AB41E0D++;
    childthread _id_54258B3847B3BBCA(entity, context);
  }
}

_id_54258B3847B3BBCA(entity, context) {
  context endon("die");
  entity waittill("death");
  context._id_A83666B52AB41E0D--;

  if(context._id_A83666B52AB41E0D == 0)
    context notify("returned", undefined);
}

string_to_bool(_id_65497A86277D7370) {
  _id_EAABF9463637080F = undefined;

  switch (_id_65497A86277D7370) {
    case "true":
    case "1":
      _id_EAABF9463637080F = 1;
      break;
    case "false":
    case "0":
      _id_EAABF9463637080F = 0;
      break;
    default:
      break;
  }

  return _id_EAABF9463637080F;
}

_id_4AF18D467A1F8ADE(_id_338635CE4E1CA9AF) {
  level endon("game_ended");
  self endon("disconnect");
  self _meth_DBFF0D4E9315DD81(_id_338635CE4E1CA9AF);

  for(;;) {
    self waittill("luinotifyserver", _id_7148C1A6F25491F8, value);

    if(_id_7148C1A6F25491F8 == "get_client_dvar")
      return value;
  }
}