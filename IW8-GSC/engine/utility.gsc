/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: engine\utility.gsc
***********************************************/

noself_func(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.func)) {
    return;
  }
  if(!isDefined(level.func[var_0])) {
    return;
  }
  if(!isDefined(var_1)) {
    call[[level.func[var_0]]]();
    return;
  }

  if(!isDefined(var_2)) {
    call[[level.func[var_0]]](var_1);
    return;
  }

  if(!isDefined(var_3)) {
    call[[level.func[var_0]]](var_1, var_2);
    return;
  }

  if(!isDefined(var_4)) {
    call[[level.func[var_0]]](var_1, var_2, var_3);
    return;
  }

  call[[level.func[var_0]]](var_1, var_2, var_3, var_4);
}

noself_func_return(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.func))
    return undefined;

  if(!isDefined(level.func[var_0]))
    return undefined;

  if(!isDefined(var_1))
    return call[[level.func[var_0]]]();

  if(!isDefined(var_2))
    return call[[level.func[var_0]]](var_1);

  if(!isDefined(var_3))
    return call[[level.func[var_0]]](var_1, var_2);

  if(!isDefined(var_4))
    return call[[level.func[var_0]]](var_1, var_2, var_3);

  return call[[level.func[var_0]]](var_1, var_2, var_3, var_4);
}

self_func(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.func[var_0])) {
    return;
  }
  if(!isDefined(var_1)) {
    self call[[level.func[var_0]]]();
    return;
  }

  if(!isDefined(var_2)) {
    self call[[level.func[var_0]]](var_1);
    return;
  }

  if(!isDefined(var_3)) {
    self call[[level.func[var_0]]](var_1, var_2);
    return;
  }

  if(!isDefined(var_4)) {
    self call[[level.func[var_0]]](var_1, var_2, var_3);
    return;
  }

  self call[[level.func[var_0]]](var_1, var_2, var_3, var_4);
}

script_func(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.func[var_0])) {
    return;
  }
  if(!isDefined(var_1))
    return self[[level.func[var_0]]]();
  else if(!isDefined(var_2))
    return self[[level.func[var_0]]](var_1);
  else if(!isDefined(var_3))
    return self[[level.func[var_0]]](var_1, var_2);
  else if(!isDefined(var_4))
    return self[[level.func[var_0]]](var_1, var_2, var_3);

  return self[[level.func[var_0]]](var_1, var_2, var_3, var_4);
}

randomvector(var_0) {
  return (randomfloat(var_0) - var_0 * 0.5, randomfloat(var_0) - var_0 * 0.5, randomfloat(var_0) - var_0 * 0.5);
}

randomvectorrange(var_0, var_1) {
  var_2 = randomfloatrange(var_0, var_1);

  if(randomint(2) == 0)
    var_2 = var_2 * -1;

  var_3 = randomfloatrange(var_0, var_1);

  if(randomint(2) == 0)
    var_3 = var_3 * -1;

  var_4 = randomfloatrange(var_0, var_1);

  if(randomint(2) == 0)
    var_4 = var_4 * -1;

  return (var_2, var_3, var_4);
}

sign(var_0) {
  if(var_0 >= 0)
    return 1;

  return -1;
}

randomonunitsphere() {
  var_0 = randomfloat(180);
  var_1 = randomfloat(360);
  var_2 = cos(var_1) * cos(var_0);
  var_3 = cos(var_1) * sin(var_0);
  var_4 = sin(var_1);
  return (var_2, var_3, var_4);
}

mod(var_0, var_1) {
  var_2 = int(var_0 / var_1);

  if(var_0 * var_1 < 0)
    var_2 = var_2 - 1;

  return var_0 - var_2 * var_1;
}

get_enemy_team(var_0) {
  var_1 = [];
  var_1["_encstr_8E8405EA382B2A"] = "_encstr_9A8507BA4040188D08";
  var_1["_encstr_9A8507BA4040188D08"] = "_encstr_8E8405EA382B2A";
  return var_1[var_0];
}

clear_exception(var_0) {
  self.exception[var_0] = anim.defaultexception;
}

cointoss() {
  return randomint(100) >= 50;
}

choose_from_weighted_array(var_0, var_1) {
  var_2 = randomint(var_1[var_1.size - 1] + 1);

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(var_2 <= var_1[var_3])
      return var_0[var_3];
  }
}

waittill_string(var_0, var_1) {
  if(var_0 != "_encstr_AD75063D571AE108")
    self endon("_encstr_AD75063D571AE108");

  var_1 endon("_encstr_B81804322D2B");
  self waittill(var_0);
  var_1 notify("_encstr_BE3009989F7CABE51AAFDD", var_0);
}

waittillmatch_string(var_0, var_1, var_2) {
  if(var_1 != "_encstr_AD75063D571AE108")
    self endon("_encstr_AD75063D571AE108");

  var_2 endon("_encstr_B81804322D2B");
  self waittillmatch(var_0, var_1);
  var_2 notify("_encstr_BE3009989F7CABE51AAFDD", var_1);
}

waittill_string_no_endon_death(var_0, var_1) {
  var_1 endon("_encstr_B81804322D2B");
  self waittill(var_0);
  var_1 notify("_encstr_BE3009989F7CABE51AAFDD", var_0);
}

waittill_multiple(var_0, var_1, var_2, var_3, var_4) {
  self endon("_encstr_AD75063D571AE108");
  var_5 = spawnStruct();
  var_5.threads = 0;

  if(isDefined(var_0)) {
    childthread waittill_string(var_0, var_5);
    var_5.threads++;
  }

  if(isDefined(var_1)) {
    childthread waittill_string(var_1, var_5);
    var_5.threads++;
  }

  if(isDefined(var_2)) {
    childthread waittill_string(var_2, var_5);
    var_5.threads++;
  }

  if(isDefined(var_3)) {
    childthread waittill_string(var_3, var_5);
    var_5.threads++;
  }

  if(isDefined(var_4)) {
    childthread waittill_string(var_4, var_5);
    var_5.threads++;
  }

  while(var_5.threads) {
    var_5 waittill("_encstr_BE3009989F7CABE51AAFDD");
    var_5.threads--;
  }

  var_5 notify("_encstr_B81804322D2B");
}

_id_1439F(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_2 = spawnStruct();
  var_2.threads = 0;

  if(isDefined(var_0)) {
    childthread waittill_string(var_0, var_2);
    var_2.threads++;
  }

  if(isDefined(var_1)) {
    childthread waittill_string(var_1, var_2);
    var_2.threads++;
  }

  while(var_2.threads) {
    var_2 waittill("_encstr_BE3009989F7CABE51AAFDD");
    var_2.threads--;
  }

  var_2 notify("_encstr_B81804322D2B");
}

waittillmatch_notify(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  self waittillmatch(var_0, var_1);
  self notify(var_2);
}

_id_143AC(var_0) {
  if(!isDefined(var_0) || var_0 != "_encstr_AD75063D571AE108")
    self endon("_encstr_AD75063D571AE108");

  var_1 = spawnStruct();

  if(isDefined(var_0))
    childthread waittill_string(var_0, var_1);

  var_1 waittill("_encstr_BE3009989F7CABE51AAFDD", var_2);
  var_1 notify("_encstr_B81804322D2B");
  return var_2;
}

_id_143AD(var_0, var_1) {
  if((!isDefined(var_0) || var_0 != "_encstr_AD75063D571AE108") && (!isDefined(var_1) || var_1 != "_encstr_AD75063D571AE108"))
    self endon("_encstr_AD75063D571AE108");

  var_2 = spawnStruct();

  if(isDefined(var_0))
    childthread waittill_string(var_0, var_2);

  if(isDefined(var_1))
    childthread waittill_string(var_1, var_2);

  var_2 waittill("_encstr_BE3009989F7CABE51AAFDD", var_3);
  var_2 notify("_encstr_B81804322D2B");
  return var_3;
}

_id_143AE(var_0, var_1, var_2) {
  if((!isDefined(var_0) || var_0 != "_encstr_AD75063D571AE108") && (!isDefined(var_1) || var_1 != "_encstr_AD75063D571AE108") && (!isDefined(var_2) || var_2 != "_encstr_AD75063D571AE108"))
    self endon("_encstr_AD75063D571AE108");

  var_3 = spawnStruct();

  if(isDefined(var_0))
    childthread waittill_string(var_0, var_3);

  if(isDefined(var_1))
    childthread waittill_string(var_1, var_3);

  if(isDefined(var_2))
    childthread waittill_string(var_2, var_3);

  var_3 waittill("_encstr_BE3009989F7CABE51AAFDD", var_4);
  var_3 notify("_encstr_B81804322D2B");
  return var_4;
}

_id_143AF(var_0, var_1, var_2, var_3) {
  if((!isDefined(var_0) || var_0 != "_encstr_AD75063D571AE108") && (!isDefined(var_1) || var_1 != "_encstr_AD75063D571AE108") && (!isDefined(var_2) || var_2 != "_encstr_AD75063D571AE108") && (!isDefined(var_3) || var_3 != "_encstr_AD75063D571AE108"))
    self endon("_encstr_AD75063D571AE108");

  var_4 = spawnStruct();

  if(isDefined(var_0))
    childthread waittill_string(var_0, var_4);

  if(isDefined(var_1))
    childthread waittill_string(var_1, var_4);

  if(isDefined(var_2))
    childthread waittill_string(var_2, var_4);

  if(isDefined(var_3))
    childthread waittill_string(var_3, var_4);

  var_4 waittill("_encstr_BE3009989F7CABE51AAFDD", var_5);
  var_4 notify("_encstr_B81804322D2B");
  return var_5;
}

_id_143B0(var_0, var_1, var_2, var_3, var_4) {
  if((!isDefined(var_0) || var_0 != "_encstr_AD75063D571AE108") && (!isDefined(var_1) || var_1 != "_encstr_AD75063D571AE108") && (!isDefined(var_2) || var_2 != "_encstr_AD75063D571AE108") && (!isDefined(var_3) || var_3 != "_encstr_AD75063D571AE108") && (!isDefined(var_4) || var_4 != "_encstr_AD75063D571AE108"))
    self endon("_encstr_AD75063D571AE108");

  var_5 = spawnStruct();

  if(isDefined(var_0))
    childthread waittill_string(var_0, var_5);

  if(isDefined(var_1))
    childthread waittill_string(var_1, var_5);

  if(isDefined(var_2))
    childthread waittill_string(var_2, var_5);

  if(isDefined(var_3))
    childthread waittill_string(var_3, var_5);

  if(isDefined(var_4))
    childthread waittill_string(var_4, var_5);

  var_5 waittill("_encstr_BE3009989F7CABE51AAFDD", var_6);
  var_5 notify("_encstr_B81804322D2B");
  return var_6;
}

_id_143B1(var_0, var_1, var_2, var_3, var_4, var_5) {
  if((!isDefined(var_0) || var_0 != "_encstr_AD75063D571AE108") && (!isDefined(var_1) || var_1 != "_encstr_AD75063D571AE108") && (!isDefined(var_2) || var_2 != "_encstr_AD75063D571AE108") && (!isDefined(var_3) || var_3 != "_encstr_AD75063D571AE108") && (!isDefined(var_4) || var_4 != "_encstr_AD75063D571AE108") && (!isDefined(var_5) || var_5 != "_encstr_AD75063D571AE108"))
    self endon("_encstr_AD75063D571AE108");

  var_6 = spawnStruct();

  if(isDefined(var_0))
    childthread waittill_string(var_0, var_6);

  if(isDefined(var_1))
    childthread waittill_string(var_1, var_6);

  if(isDefined(var_2))
    childthread waittill_string(var_2, var_6);

  if(isDefined(var_3))
    childthread waittill_string(var_3, var_6);

  if(isDefined(var_4))
    childthread waittill_string(var_4, var_6);

  if(isDefined(var_5))
    childthread waittill_string(var_5, var_6);

  var_6 waittill("_encstr_BE3009989F7CABE51AAFDD", var_7);
  var_6 notify("_encstr_B81804322D2B");
  return var_7;
}

_id_143B2(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if((!isDefined(var_0) || var_0 != "_encstr_AD75063D571AE108") && (!isDefined(var_1) || var_1 != "_encstr_AD75063D571AE108") && (!isDefined(var_2) || var_2 != "_encstr_AD75063D571AE108") && (!isDefined(var_3) || var_3 != "_encstr_AD75063D571AE108") && (!isDefined(var_4) || var_4 != "_encstr_AD75063D571AE108") && (!isDefined(var_5) || var_5 != "_encstr_AD75063D571AE108") && (!isDefined(var_6) || var_6 != "_encstr_AD75063D571AE108"))
    self endon("_encstr_AD75063D571AE108");

  var_7 = spawnStruct();

  if(isDefined(var_0))
    childthread waittill_string(var_0, var_7);

  if(isDefined(var_1))
    childthread waittill_string(var_1, var_7);

  if(isDefined(var_2))
    childthread waittill_string(var_2, var_7);

  if(isDefined(var_3))
    childthread waittill_string(var_3, var_7);

  if(isDefined(var_4))
    childthread waittill_string(var_4, var_7);

  if(isDefined(var_5))
    childthread waittill_string(var_5, var_7);

  if(isDefined(var_6))
    childthread waittill_string(var_6, var_7);

  var_7 waittill("_encstr_BE3009989F7CABE51AAFDD", var_8);
  var_7 notify("_encstr_B81804322D2B");
  return var_8;
}

waittill_any_return(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if((!isDefined(var_0) || var_0 != "_encstr_AD75063D571AE108") && (!isDefined(var_1) || var_1 != "_encstr_AD75063D571AE108") && (!isDefined(var_2) || var_2 != "_encstr_AD75063D571AE108") && (!isDefined(var_3) || var_3 != "_encstr_AD75063D571AE108") && (!isDefined(var_4) || var_4 != "_encstr_AD75063D571AE108") && (!isDefined(var_5) || var_5 != "_encstr_AD75063D571AE108") && (!isDefined(var_6) || var_6 != "_encstr_AD75063D571AE108") && (!isDefined(var_7) || var_7 != "_encstr_AD75063D571AE108"))
    self endon("_encstr_AD75063D571AE108");

  var_8 = spawnStruct();

  if(isDefined(var_0))
    childthread waittill_string(var_0, var_8);

  if(isDefined(var_1))
    childthread waittill_string(var_1, var_8);

  if(isDefined(var_2))
    childthread waittill_string(var_2, var_8);

  if(isDefined(var_3))
    childthread waittill_string(var_3, var_8);

  if(isDefined(var_4))
    childthread waittill_string(var_4, var_8);

  if(isDefined(var_5))
    childthread waittill_string(var_5, var_8);

  if(isDefined(var_6))
    childthread waittill_string(var_6, var_8);

  if(isDefined(var_7))
    childthread waittill_string(var_7, var_8);

  var_8 waittill("_encstr_BE3009989F7CABE51AAFDD", var_9);
  var_8 notify("_encstr_B81804322D2B");
  return var_9;
}

waittillmatch_any_return(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if((!isDefined(var_1) || var_1 != "_encstr_AD75063D571AE108") && (!isDefined(var_2) || var_2 != "_encstr_AD75063D571AE108") && (!isDefined(var_3) || var_3 != "_encstr_AD75063D571AE108") && (!isDefined(var_4) || var_4 != "_encstr_AD75063D571AE108") && (!isDefined(var_5) || var_5 != "_encstr_AD75063D571AE108") && (!isDefined(var_6) || var_6 != "_encstr_AD75063D571AE108"))
    self endon("_encstr_AD75063D571AE108");

  var_7 = spawnStruct();

  if(isDefined(var_1))
    childthread waittillmatch_string(var_0, var_1, var_7);

  if(isDefined(var_2))
    childthread waittillmatch_string(var_0, var_2, var_7);

  if(isDefined(var_3))
    childthread waittillmatch_string(var_0, var_3, var_7);

  if(isDefined(var_4))
    childthread waittillmatch_string(var_0, var_4, var_7);

  if(isDefined(var_5))
    childthread waittillmatch_string(var_0, var_5, var_7);

  if(isDefined(var_6))
    childthread waittillmatch_string(var_0, var_6, var_7);

  var_7 waittill("_encstr_BE3009989F7CABE51AAFDD", var_8);
  var_7 notify("_encstr_B81804322D2B");
  return var_8;
}

_id_143B3(var_0) {
  var_1 = spawnStruct();

  if(isDefined(var_0))
    childthread waittill_string_no_endon_death(var_0, var_1);

  var_1 waittill("_encstr_BE3009989F7CABE51AAFDD", var_2);
  var_1 notify("_encstr_B81804322D2B");
  return var_2;
}

_id_143B4(var_0, var_1) {
  var_2 = spawnStruct();

  if(isDefined(var_0))
    childthread waittill_string_no_endon_death(var_0, var_2);

  if(isDefined(var_1))
    childthread waittill_string_no_endon_death(var_1, var_2);

  var_2 waittill("_encstr_BE3009989F7CABE51AAFDD", var_3);
  var_2 notify("_encstr_B81804322D2B");
  return var_3;
}

_id_143B5(var_0, var_1, var_2) {
  var_3 = spawnStruct();

  if(isDefined(var_0))
    childthread waittill_string_no_endon_death(var_0, var_3);

  if(isDefined(var_1))
    childthread waittill_string_no_endon_death(var_1, var_3);

  if(isDefined(var_2))
    childthread waittill_string_no_endon_death(var_2, var_3);

  var_3 waittill("_encstr_BE3009989F7CABE51AAFDD", var_4);
  var_3 notify("_encstr_B81804322D2B");
  return var_4;
}

_id_143B6(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();

  if(isDefined(var_0))
    childthread waittill_string_no_endon_death(var_0, var_4);

  if(isDefined(var_1))
    childthread waittill_string_no_endon_death(var_1, var_4);

  if(isDefined(var_2))
    childthread waittill_string_no_endon_death(var_2, var_4);

  if(isDefined(var_3))
    childthread waittill_string_no_endon_death(var_3, var_4);

  var_4 waittill("_encstr_BE3009989F7CABE51AAFDD", var_5);
  var_4 notify("_encstr_B81804322D2B");
  return var_5;
}

_id_143B7(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();

  if(isDefined(var_0))
    childthread waittill_string_no_endon_death(var_0, var_5);

  if(isDefined(var_1))
    childthread waittill_string_no_endon_death(var_1, var_5);

  if(isDefined(var_2))
    childthread waittill_string_no_endon_death(var_2, var_5);

  if(isDefined(var_3))
    childthread waittill_string_no_endon_death(var_3, var_5);

  if(isDefined(var_4))
    childthread waittill_string_no_endon_death(var_4, var_5);

  var_5 waittill("_encstr_BE3009989F7CABE51AAFDD", var_6);
  var_5 notify("_encstr_B81804322D2B");
  return var_6;
}

_id_143B8(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();

  if(isDefined(var_0))
    childthread waittill_string_no_endon_death(var_0, var_6);

  if(isDefined(var_1))
    childthread waittill_string_no_endon_death(var_1, var_6);

  if(isDefined(var_2))
    childthread waittill_string_no_endon_death(var_2, var_6);

  if(isDefined(var_3))
    childthread waittill_string_no_endon_death(var_3, var_6);

  if(isDefined(var_4))
    childthread waittill_string_no_endon_death(var_4, var_6);

  if(isDefined(var_5))
    childthread waittill_string_no_endon_death(var_5, var_6);

  var_6 waittill("_encstr_BE3009989F7CABE51AAFDD", var_7);
  var_6 notify("_encstr_B81804322D2B");
  return var_7;
}

waittill_any_return_no_endon_death(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();

  if(isDefined(var_0))
    childthread waittill_string_no_endon_death(var_0, var_6);

  if(isDefined(var_1))
    childthread waittill_string_no_endon_death(var_1, var_6);

  if(isDefined(var_2))
    childthread waittill_string_no_endon_death(var_2, var_6);

  if(isDefined(var_3))
    childthread waittill_string_no_endon_death(var_3, var_6);

  if(isDefined(var_4))
    childthread waittill_string_no_endon_death(var_4, var_6);

  if(isDefined(var_5))
    childthread waittill_string_no_endon_death(var_5, var_6);

  var_6 waittill("_encstr_BE3009989F7CABE51AAFDD", var_7);
  var_6 notify("_encstr_B81804322D2B");
  return var_7;
}

waittill_any_in_array_return(var_0) {
  var_1 = spawnStruct();
  var_2 = 0;

  foreach(var_4 in var_0) {
    childthread waittill_string(var_4, var_1);

    if(var_4 == "_encstr_AD75063D571AE108")
      var_2 = 1;
  }

  if(!var_2)
    self endon("_encstr_AD75063D571AE108");

  var_1 waittill("_encstr_BE3009989F7CABE51AAFDD", var_6);
  var_1 notify("_encstr_B81804322D2B");
  return var_6;
}

waittill_any_in_array_return_no_endon_death(var_0) {
  var_1 = spawnStruct();

  foreach(var_3 in var_0)
  childthread waittill_string_no_endon_death(var_3, var_1);

  var_1 waittill("_encstr_BE3009989F7CABE51AAFDD", var_5);
  var_1 notify("_encstr_B81804322D2B");
  return var_5;
}

waittill_any_in_array_or_timeout(var_0, var_1) {
  var_2 = spawnStruct();
  var_3 = 0;

  foreach(var_5 in var_0) {
    childthread waittill_string(var_5, var_2);

    if(var_5 == "_encstr_AD75063D571AE108")
      var_3 = 1;
  }

  if(!var_3)
    self endon("_encstr_AD75063D571AE108");

  var_2 childthread _timeout(var_1);
  var_2 waittill("_encstr_BE3009989F7CABE51AAFDD", var_7);
  var_2 notify("_encstr_B81804322D2B");
  return var_7;
}

waittill_any_in_array_or_timeout_no_endon_death(var_0, var_1) {
  var_2 = spawnStruct();

  foreach(var_4 in var_0)
  childthread waittill_string_no_endon_death(var_4, var_2);

  var_2 thread _timeout(var_1);
  var_2 waittill("_encstr_BE3009989F7CABE51AAFDD", var_6);
  var_2 notify("_encstr_B81804322D2B");
  return var_6;
}

waittill_all_in_array(var_0) {
  while(var_0.size) {
    var_1 = waittill_any_in_array_return(var_0);
    var_0 = array_remove(var_0, var_1);
  }
}

_id_143B9(var_0, var_1) {
  if(!isDefined(var_1) || var_1 != "_encstr_AD75063D571AE108")
    self endon("_encstr_AD75063D571AE108");

  var_2 = spawnStruct();

  if(isDefined(var_1))
    childthread waittill_string(var_1, var_2);

  var_2 childthread _timeout(var_0);
  var_2 waittill("_encstr_BE3009989F7CABE51AAFDD", var_3);
  var_2 notify("_encstr_B81804322D2B");
  return var_3;
}

_id_143BA(var_0, var_1, var_2) {
  if((!isDefined(var_1) || var_1 != "_encstr_AD75063D571AE108") && (!isDefined(var_2) || var_2 != "_encstr_AD75063D571AE108"))
    self endon("_encstr_AD75063D571AE108");

  var_3 = spawnStruct();

  if(isDefined(var_1))
    childthread waittill_string(var_1, var_3);

  if(isDefined(var_2))
    childthread waittill_string(var_2, var_3);

  var_3 childthread _timeout(var_0);
  var_3 waittill("_encstr_BE3009989F7CABE51AAFDD", var_4);
  var_3 notify("_encstr_B81804322D2B");
  return var_4;
}

_id_143BB(var_0, var_1, var_2, var_3) {
  if((!isDefined(var_1) || var_1 != "_encstr_AD75063D571AE108") && (!isDefined(var_2) || var_2 != "_encstr_AD75063D571AE108") && (!isDefined(var_3) || var_3 != "_encstr_AD75063D571AE108"))
    self endon("_encstr_AD75063D571AE108");

  var_4 = spawnStruct();

  if(isDefined(var_1))
    childthread waittill_string(var_1, var_4);

  if(isDefined(var_2))
    childthread waittill_string(var_2, var_4);

  if(isDefined(var_3))
    childthread waittill_string(var_3, var_4);

  var_4 childthread _timeout(var_0);
  var_4 waittill("_encstr_BE3009989F7CABE51AAFDD", var_5);
  var_4 notify("_encstr_B81804322D2B");
  return var_5;
}

_id_143BC(var_0, var_1, var_2, var_3, var_4) {
  if((!isDefined(var_1) || var_1 != "_encstr_AD75063D571AE108") && (!isDefined(var_2) || var_2 != "_encstr_AD75063D571AE108") && (!isDefined(var_3) || var_3 != "_encstr_AD75063D571AE108") && (!isDefined(var_4) || var_4 != "_encstr_AD75063D571AE108"))
    self endon("_encstr_AD75063D571AE108");

  var_5 = spawnStruct();

  if(isDefined(var_1))
    childthread waittill_string(var_1, var_5);

  if(isDefined(var_2))
    childthread waittill_string(var_2, var_5);

  if(isDefined(var_3))
    childthread waittill_string(var_3, var_5);

  if(isDefined(var_4))
    childthread waittill_string(var_4, var_5);

  var_5 childthread _timeout(var_0);
  var_5 waittill("_encstr_BE3009989F7CABE51AAFDD", var_6);
  var_5 notify("_encstr_B81804322D2B");
  return var_6;
}

_id_143BD(var_0, var_1, var_2, var_3, var_4, var_5) {
  if((!isDefined(var_1) || var_1 != "_encstr_AD75063D571AE108") && (!isDefined(var_2) || var_2 != "_encstr_AD75063D571AE108") && (!isDefined(var_3) || var_3 != "_encstr_AD75063D571AE108") && (!isDefined(var_4) || var_4 != "_encstr_AD75063D571AE108") && (!isDefined(var_5) || var_5 != "_encstr_AD75063D571AE108"))
    self endon("_encstr_AD75063D571AE108");

  var_6 = spawnStruct();

  if(isDefined(var_1))
    childthread waittill_string(var_1, var_6);

  if(isDefined(var_2))
    childthread waittill_string(var_2, var_6);

  if(isDefined(var_3))
    childthread waittill_string(var_3, var_6);

  if(isDefined(var_4))
    childthread waittill_string(var_4, var_6);

  if(isDefined(var_5))
    childthread waittill_string(var_5, var_6);

  var_6 childthread _timeout(var_0);
  var_6 waittill("_encstr_BE3009989F7CABE51AAFDD", var_7);
  var_6 notify("_encstr_B81804322D2B");
  return var_7;
}

_id_143BE(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if((!isDefined(var_1) || var_1 != "_encstr_AD75063D571AE108") && (!isDefined(var_2) || var_2 != "_encstr_AD75063D571AE108") && (!isDefined(var_3) || var_3 != "_encstr_AD75063D571AE108") && (!isDefined(var_4) || var_4 != "_encstr_AD75063D571AE108") && (!isDefined(var_5) || var_5 != "_encstr_AD75063D571AE108") && (!isDefined(var_6) || var_6 != "_encstr_AD75063D571AE108"))
    self endon("_encstr_AD75063D571AE108");

  var_7 = spawnStruct();

  if(isDefined(var_1))
    childthread waittill_string(var_1, var_7);

  if(isDefined(var_2))
    childthread waittill_string(var_2, var_7);

  if(isDefined(var_3))
    childthread waittill_string(var_3, var_7);

  if(isDefined(var_4))
    childthread waittill_string(var_4, var_7);

  if(isDefined(var_5))
    childthread waittill_string(var_5, var_7);

  if(isDefined(var_6))
    childthread waittill_string(var_6, var_7);

  var_7 childthread _timeout(var_0);
  var_7 waittill("_encstr_BE3009989F7CABE51AAFDD", var_8);
  var_7 notify("_encstr_B81804322D2B");
  return var_8;
}

waittill_any_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if((!isDefined(var_1) || var_1 != "_encstr_AD75063D571AE108") && (!isDefined(var_2) || var_2 != "_encstr_AD75063D571AE108") && (!isDefined(var_3) || var_3 != "_encstr_AD75063D571AE108") && (!isDefined(var_4) || var_4 != "_encstr_AD75063D571AE108") && (!isDefined(var_5) || var_5 != "_encstr_AD75063D571AE108") && (!isDefined(var_6) || var_6 != "_encstr_AD75063D571AE108"))
    self endon("_encstr_AD75063D571AE108");

  var_7 = spawnStruct();

  if(isDefined(var_1))
    childthread waittill_string(var_1, var_7);

  if(isDefined(var_2))
    childthread waittill_string(var_2, var_7);

  if(isDefined(var_3))
    childthread waittill_string(var_3, var_7);

  if(isDefined(var_4))
    childthread waittill_string(var_4, var_7);

  if(isDefined(var_5))
    childthread waittill_string(var_5, var_7);

  if(isDefined(var_6))
    childthread waittill_string(var_6, var_7);

  var_7 childthread _timeout(var_0);
  var_7 waittill("_encstr_BE3009989F7CABE51AAFDD", var_8);
  var_7 notify("_encstr_B81804322D2B");
  return var_8;
}

_timeout(var_0) {
  self endon("_encstr_B81804322D2B");
  wait(var_0);
  self notify("_encstr_BE3009989F7CABE51AAFDD", "_encstr_995408F398012F656821");
}

_id_143BF(var_0, var_1) {
  var_2 = spawnStruct();

  if(isDefined(var_1))
    childthread waittill_string_no_endon_death(var_1, var_2);

  var_2 childthread _timeout(var_0);
  var_2 waittill("_encstr_BE3009989F7CABE51AAFDD", var_3);
  var_2 notify("_encstr_B81804322D2B");
  return var_3;
}

_id_143C0(var_0, var_1, var_2) {
  var_3 = spawnStruct();

  if(isDefined(var_1))
    childthread waittill_string_no_endon_death(var_1, var_3);

  if(isDefined(var_2))
    childthread waittill_string_no_endon_death(var_2, var_3);

  var_3 childthread _timeout(var_0);
  var_3 waittill("_encstr_BE3009989F7CABE51AAFDD", var_4);
  var_3 notify("_encstr_B81804322D2B");
  return var_4;
}

_id_143C1(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();

  if(isDefined(var_1))
    childthread waittill_string_no_endon_death(var_1, var_4);

  if(isDefined(var_2))
    childthread waittill_string_no_endon_death(var_2, var_4);

  if(isDefined(var_3))
    childthread waittill_string_no_endon_death(var_3, var_4);

  var_4 childthread _timeout(var_0);
  var_4 waittill("_encstr_BE3009989F7CABE51AAFDD", var_5);
  var_4 notify("_encstr_B81804322D2B");
  return var_5;
}

_id_143C2(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();

  if(isDefined(var_1))
    childthread waittill_string_no_endon_death(var_1, var_5);

  if(isDefined(var_2))
    childthread waittill_string_no_endon_death(var_2, var_5);

  if(isDefined(var_3))
    childthread waittill_string_no_endon_death(var_3, var_5);

  if(isDefined(var_4))
    childthread waittill_string_no_endon_death(var_4, var_5);

  var_5 childthread _timeout(var_0);
  var_5 waittill("_encstr_BE3009989F7CABE51AAFDD", var_6);
  var_5 notify("_encstr_B81804322D2B");
  return var_6;
}

_id_143C3(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();

  if(isDefined(var_1))
    childthread waittill_string_no_endon_death(var_1, var_6);

  if(isDefined(var_2))
    childthread waittill_string_no_endon_death(var_2, var_6);

  if(isDefined(var_3))
    childthread waittill_string_no_endon_death(var_3, var_6);

  if(isDefined(var_4))
    childthread waittill_string_no_endon_death(var_4, var_6);

  if(isDefined(var_5))
    childthread waittill_string_no_endon_death(var_5, var_6);

  var_6 childthread _timeout(var_0);
  var_6 waittill("_encstr_BE3009989F7CABE51AAFDD", var_7);
  var_6 notify("_encstr_B81804322D2B");
  return var_7;
}

waittill_any_timeout_no_endon_death(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();

  if(isDefined(var_1))
    childthread waittill_string_no_endon_death(var_1, var_6);

  if(isDefined(var_2))
    childthread waittill_string_no_endon_death(var_2, var_6);

  if(isDefined(var_3))
    childthread waittill_string_no_endon_death(var_3, var_6);

  if(isDefined(var_4))
    childthread waittill_string_no_endon_death(var_4, var_6);

  if(isDefined(var_5))
    childthread waittill_string_no_endon_death(var_5, var_6);

  var_6 childthread _timeout(var_0);
  var_6 waittill("_encstr_BE3009989F7CABE51AAFDD", var_7);
  var_6 notify("_encstr_B81804322D2B");
  return var_7;
}

_id_143A5(var_0, var_1) {
  if(isDefined(var_1))
    self endon(var_1);

  self waittill(var_0);
}

_id_143A6(var_0, var_1, var_2) {
  if(isDefined(var_1))
    self endon(var_1);

  if(isDefined(var_2))
    self endon(var_2);

  self waittill(var_0);
}

_id_143A7(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1))
    self endon(var_1);

  if(isDefined(var_2))
    self endon(var_2);

  if(isDefined(var_3))
    self endon(var_3);

  self waittill(var_0);
}

_id_143A8(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_1))
    self endon(var_1);

  if(isDefined(var_2))
    self endon(var_2);

  if(isDefined(var_3))
    self endon(var_3);

  if(isDefined(var_4))
    self endon(var_4);

  self waittill(var_0);
}

_id_143A9(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_1))
    self endon(var_1);

  if(isDefined(var_2))
    self endon(var_2);

  if(isDefined(var_3))
    self endon(var_3);

  if(isDefined(var_4))
    self endon(var_4);

  if(isDefined(var_5))
    self endon(var_5);

  self waittill(var_0);
}

_id_143AA(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_1))
    self endon(var_1);

  if(isDefined(var_2))
    self endon(var_2);

  if(isDefined(var_3))
    self endon(var_3);

  if(isDefined(var_4))
    self endon(var_4);

  if(isDefined(var_5))
    self endon(var_5);

  if(isDefined(var_6))
    self endon(var_6);

  self waittill(var_0);
}

_id_143AB(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_1))
    self endon(var_1);

  if(isDefined(var_2))
    self endon(var_2);

  if(isDefined(var_3))
    self endon(var_3);

  if(isDefined(var_4))
    self endon(var_4);

  if(isDefined(var_5))
    self endon(var_5);

  if(isDefined(var_6))
    self endon(var_6);

  if(isDefined(var_7))
    self endon(var_7);

  self waittill(var_0);
}

waittill_any(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_1))
    self endon(var_1);

  if(isDefined(var_2))
    self endon(var_2);

  if(isDefined(var_3))
    self endon(var_3);

  if(isDefined(var_4))
    self endon(var_4);

  if(isDefined(var_5))
    self endon(var_5);

  if(isDefined(var_6))
    self endon(var_6);

  if(isDefined(var_7))
    self endon(var_7);

  self waittill(var_0);
}

waittill_any_two(var_0, var_1) {
  if(isDefined(var_1))
    self endon(var_1);

  self waittill(var_0);
}

waittill_any_ents(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(isDefined(var_2) && isDefined(var_3))
    var_2 endon(var_3);

  if(isDefined(var_4) && isDefined(var_5))
    var_4 endon(var_5);

  if(isDefined(var_6) && isDefined(var_7))
    var_6 endon(var_7);

  if(isDefined(var_8) && isDefined(var_9))
    var_8 endon(var_9);

  if(isDefined(var_10) && isDefined(var_11))
    var_10 endon(var_11);

  if(isDefined(var_12) && isDefined(var_13))
    var_12 endon(var_13);

  var_0 waittill(var_1);
}

waittill_any_ents_return(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  self endon("_encstr_AD75063D571AE108");
  var_14 = spawnStruct();
  var_0 childthread waittill_string(var_1, var_14);

  if(isDefined(var_2) && isDefined(var_3))
    var_2 childthread waittill_string(var_3, var_14);

  if(isDefined(var_4) && isDefined(var_5))
    var_4 childthread waittill_string(var_5, var_14);

  if(isDefined(var_6) && isDefined(var_7))
    var_6 childthread waittill_string(var_7, var_14);

  if(isDefined(var_8) && isDefined(var_9))
    var_8 childthread waittill_string(var_9, var_14);

  if(isDefined(var_10) && isDefined(var_11))
    var_10 childthread waittill_string(var_11, var_14);

  if(isDefined(var_12) && isDefined(var_13))
    var_12 childthread waittill_string(var_13, var_14);

  var_14 waittill("_encstr_BE3009989F7CABE51AAFDD", var_15);
  var_14 notify("_encstr_B81804322D2B");
  return var_15;
}

waittill_any_ents_array(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  foreach(var_9 in var_0) {
    if(var_9 != var_0[0])
      var_9 endon(var_1);

    if(isDefined(var_2))
      var_9 endon(var_2);

    if(isDefined(var_3))
      var_9 endon(var_3);

    if(isDefined(var_4))
      var_9 endon(var_4);

    if(isDefined(var_5))
      var_9 endon(var_5);

    if(isDefined(var_6))
      var_9 endon(var_6);

    if(isDefined(var_7))
      var_9 endon(var_7);
  }

  var_0[0] waittill(var_1);
}

wait_time_in_ms(var_0) {
  var_1 = gettime() + var_0;

  while(gettime() < var_1)
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
  var_0 = gettime();

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

  return gettime() - var_0;
}

isflashed() {
  if(!isDefined(self.flashendtime))
    return 0;

  return gettime() < self.flashendtime;
}

flag_exist(var_0) {
  if(!isDefined(level.flag))
    return 0;

  return isDefined(level.flag[var_0]);
}

flag(var_0) {
  return level.flag[var_0];
}

flag_init(var_0) {
  if(!isDefined(level.flag))
    scripts\engine\flags::init_flags();

  level.flag[var_0] = 0;
  init_trigger_flags();

  if(!isDefined(level.trigger_flags[var_0]))
    level.trigger_flags[var_0] = [];
}

empty_init_func(var_0) {}

flag_set(var_0, var_1) {
  level.flag[var_0] = 1;
  set_trigger_flag_permissions(var_0);

  if(isDefined(var_1))
    level notify(var_0, var_1);
  else
    level notify(var_0);
}

flag_wait(var_0) {
  var_1 = undefined;

  while(!flag(var_0)) {
    var_1 = undefined;
    level waittill(var_0, var_1);
  }

  if(isDefined(var_1))
    return var_1;
}

flag_clear(var_0) {
  if(!flag(var_0)) {
    return;
  }
  level.flag[var_0] = 0;
  set_trigger_flag_permissions(var_0);
  level notify(var_0);
}

flag_waitopen(var_0) {
  while(flag(var_0))
    level waittill(var_0);
}

waittill_either(var_0, var_1) {
  self endon(var_0);
  self waittill(var_1);
  return var_1;
}

trigger_on(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = getEntArray(var_0, var_1);
    array_thread(var_2, ::trigger_on_proc);
  } else
    trigger_on_proc();
}

trigger_on_proc() {
  self triggerenable();
  self.trigger_off = undefined;
}

trigger_off(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = getEntArray(var_0, var_1);
    array_thread(var_2, ::trigger_off_proc);
  } else
    trigger_off_proc();
}

trigger_off_proc() {
  self triggerdisable();
  self.trigger_off = 1;
  self notify("_encstr_97F70CD1392D3B3BCA93BE7B9933");
}

set_trigger_flag_permissions(var_0) {
  if(!isDefined(level.trigger_flags)) {
    return;
  }
  level.trigger_flags[var_0] = array_removeundefined(level.trigger_flags[var_0]);
  array_thread(level.trigger_flags[var_0], ::update_trigger_based_on_flags);
}

update_trigger_based_on_flags() {
  var_0 = 1;

  if(isDefined(self.script_flag_true)) {
    var_0 = 0;
    var_1 = create_flags_and_return_tokens(self.script_flag_true);

    foreach(var_3 in var_1) {
      if(flag(var_3)) {
        var_0 = 1;
        break;
      }
    }
  }

  var_5 = 1;

  if(isDefined(self.script_flag_false)) {
    var_1 = create_flags_and_return_tokens(self.script_flag_false);

    foreach(var_3 in var_1) {
      if(flag(var_3)) {
        var_5 = 0;
        break;
      }
    }
  }

  [[level.trigger_func[var_0 && var_5]]]();
}

create_flags_and_return_tokens(var_0) {
  var_1 = strtok(var_0, "_encstr_974C0246");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!isDefined(level.flag[var_1[var_2]]))
      flag_init(var_1[var_2]);
  }

  return var_1;
}

init_trigger_flags() {
  if(!add_init_script("_encstr_93BC0E0B03FBCF8F70853716A1885757", ::init_trigger_flags)) {
    return;
  }
  level.trigger_flags = [];
  level.trigger_func[1] = ::trigger_on;
  level.trigger_func[0] = ::trigger_off;
}

getStruct(var_0, var_1) {
  var_2 = level.struct_class_names[var_1][var_0];

  if(!isDefined(var_2))
    return undefined;

  if(var_2.size > 1)
    return undefined;

  return var_2[0];
}

getStructArray(var_0, var_1) {
  var_2 = level.struct_class_names[var_1][var_0];

  if(!isDefined(var_2))
    return [];

  return var_2;
}

add_smartobject_point(var_0) {
  if(!isDefined(anim.smartobjectpoints))
    anim.smartobjectpoints = [];

  anim.smartobjectpoints[anim.smartobjectpoints.size] = var_0;
}

store_linked_smartobjects() {
  if(!isDefined(anim.smartobjectpoints)) {
    return;
  }
  foreach(var_1 in anim.smartobjectpoints) {
    if(isDefined(var_1.script_linkto)) {
      var_2 = var_1 get_linked_structs();

      foreach(var_4 in var_2) {
        if(var_4 == var_1) {
          continue;
        }
        if(!isDefined(var_4.script_smartobject)) {
          continue;
        }
        if(!isDefined(var_1.linkedsmartobjects))
          var_1.linkedsmartobjects = [];

        var_1.linkedsmartobjects[var_1.linkedsmartobjects.size] = var_4;
      }
    }
  }
}

init_struct_class() {
  if(!add_init_script("_encstr_BAE90FEE4B73BB213C3F2050AF537BC3CB", ::init_struct_class)) {
    return;
  }
  level.struct_class_names = [];
  level.struct_class_names["_encstr_A16007A921A23B85E3"] = [];
  level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"] = [];
  level.struct_class_names["_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"] = [];
  level.struct_class_names["_encstr_A29D10371B275A1C47F536969BDAB90BB5B2"] = [];

  foreach(var_3, var_1 in level.struct) {
    if(isDefined(var_1.script_smartobject))
      add_smartobject_point(var_1);

    if(isDefined(var_1.targetname)) {
      if(var_1.targetname == "_encstr_A7EE0FE3BB593A1C48B68DD5AE585F3225") {
        level.struct[var_3] = undefined;
        continue;
      }

      if(isDefined(level.struct_filter)) {
        if(![[level.struct_filter]](var_1)) {
          level.struct[var_3] = undefined;
          continue;
        }
      }

      if(!isDefined(level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"][var_1.targetname]))
        level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"][var_1.targetname] = [];

      var_2 = level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"][var_1.targetname].size;
      level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"][var_1.targetname][var_2] = var_1;
    }

    if(isDefined(var_1.target)) {
      if(!isDefined(level.struct_class_names["_encstr_A16007A921A23B85E3"][var_1.target]))
        level.struct_class_names["_encstr_A16007A921A23B85E3"][var_1.target] = [];

      var_2 = level.struct_class_names["_encstr_A16007A921A23B85E3"][var_1.target].size;
      level.struct_class_names["_encstr_A16007A921A23B85E3"][var_1.target][var_2] = var_1;
    }

    if(isDefined(var_1.script_noteworthy)) {
      if(!isDefined(level.struct_class_names["_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"][var_1.script_noteworthy]))
        level.struct_class_names["_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"][var_1.script_noteworthy] = [];

      var_2 = level.struct_class_names["_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"][var_1.script_noteworthy].size;
      level.struct_class_names["_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"][var_1.script_noteworthy][var_2] = var_1;
    }

    if(isDefined(var_1.script_linkname)) {
      if(!isDefined(level.struct_class_names["_encstr_A29D10371B275A1C47F536969BDAB90BB5B2"][var_1.script_linkname]))
        level.struct_class_names["_encstr_A29D10371B275A1C47F536969BDAB90BB5B2"][var_1.script_linkname] = [];

      var_2 = level.struct_class_names["_encstr_A29D10371B275A1C47F536969BDAB90BB5B2"][var_1.script_linkname].size;
      level.struct_class_names["_encstr_A29D10371B275A1C47F536969BDAB90BB5B2"][var_1.script_linkname][var_2] = var_1;
    }
  }

  store_linked_smartobjects();
}

deletestructarray(var_0, var_1, var_2) {
  var_3 = getStructArray(var_0, var_1);
  deletestructarray_ref(var_3, var_2);
}

deletestruct_ref(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0.script_linkname;

  if(isDefined(var_1) && isDefined(level.struct_class_names["_encstr_A29D10371B275A1C47F536969BDAB90BB5B2"]) && isDefined(level.struct_class_names["_encstr_A29D10371B275A1C47F536969BDAB90BB5B2"][var_1])) {
    foreach(var_4, var_3 in level.struct_class_names["_encstr_A29D10371B275A1C47F536969BDAB90BB5B2"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3)
        level.struct_class_names["_encstr_A29D10371B275A1C47F536969BDAB90BB5B2"][var_1][var_4] = undefined;
    }

    if(level.struct_class_names["_encstr_A29D10371B275A1C47F536969BDAB90BB5B2"][var_1].size == 0)
      level.struct_class_names["_encstr_A29D10371B275A1C47F536969BDAB90BB5B2"][var_1] = undefined;
  }

  var_1 = var_0.script_noteworthy;

  if(isDefined(var_1) && isDefined(level.struct_class_names["_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"]) && isDefined(level.struct_class_names["_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"][var_1])) {
    foreach(var_4, var_3 in level.struct_class_names["_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3)
        level.struct_class_names["_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"][var_1][var_4] = undefined;
    }

    if(level.struct_class_names["_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"][var_1].size == 0)
      level.struct_class_names["_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"][var_1] = undefined;
  }

  var_1 = var_0.target;

  if(isDefined(var_1) && isDefined(level.struct_class_names["_encstr_A16007A921A23B85E3"]) && isDefined(level.struct_class_names["_encstr_A16007A921A23B85E3"][var_1])) {
    foreach(var_4, var_3 in level.struct_class_names["_encstr_A16007A921A23B85E3"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3)
        level.struct_class_names["_encstr_A16007A921A23B85E3"][var_1][var_4] = undefined;
    }

    if(level.struct_class_names["_encstr_A16007A921A23B85E3"][var_1].size == 0)
      level.struct_class_names["_encstr_A16007A921A23B85E3"][var_1] = undefined;
  }

  var_1 = var_0.targetname;

  if(isDefined(var_1) && isDefined(level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"]) && isDefined(level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"][var_1])) {
    foreach(var_4, var_3 in level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3)
        level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"][var_1][var_4] = undefined;
    }

    if(level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"][var_1].size == 0)
      level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"][var_1] = undefined;
  }

  if(isDefined(level.struct)) {
    if(level.struct.size > 5000) {
      var_8 = 2500;
      var_9 = 0;
      var_10 = var_8;
      _id_12C27(var_0, var_9, var_10);

      while(var_10 < level.struct.size) {
        var_9 = var_10 + 1;
        var_10 = ter_op(var_10 + var_8 < level.struct.size, var_10 + var_8, level.struct.size);
        _id_12C27(var_0, var_9, var_10);
      }
    } else
      _id_12C27(var_0, 0, level.struct.size);
  }
}

_id_12C27(var_0, var_1, var_2) {
  for(var_3 = var_1; var_3 <= var_2; var_3++) {
    var_4 = level.struct[var_3];

    if(isDefined(var_4) && var_0 == var_4)
      level.struct[var_3] = undefined;
  }
}

deletestructarray_ref(var_0, var_1) {
  if(!isDefined(var_0) || !isarray(var_0) || var_0.size == 0) {
    return;
  }
  var_1 = ter_op(isDefined(var_1), var_1, 0);
  var_1 = ter_op(var_1 > 0, var_1, 0);

  if(var_1 > 0) {
    foreach(var_3 in var_0) {
      deletestruct_ref(var_3);
      wait(var_1);
    }
  } else {
    foreach(var_3 in var_0)
    deletestruct_ref(var_3);
  }
}

getstruct_delete(var_0, var_1) {
  var_2 = getStruct(var_0, var_1);
  deletestruct_ref(var_2);
  return var_2;
}

getstructarray_delete(var_0, var_1, var_2) {
  var_3 = getStructArray(var_0, var_1);
  deletestructarray_ref(var_3, var_2);
  return var_3;
}

getent_or_struct(var_0, var_1) {
  var_2 = getEnt(var_0, var_1);

  if(isDefined(var_2))
    return var_2;

  return getStruct(var_0, var_1);
}

fileprint_start(var_0) {}

fileprint_map_start() {}

fileprint_map_header(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;
}

fileprint_map_keypairprint(var_0, var_1) {}

fileprint_map_entity_start() {}

fileprint_map_entity_end() {}

fileprint_radiant_vec(var_0) {}

call_on_notify_no_endon_death(var_0, var_1, var_2, var_3) {
  childthread call_on_notify_proc(var_0, var_1, var_2, var_3);
}

call_on_notify(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");
  childthread call_on_notify_proc(var_0, var_1, var_2, var_3);
}

call_on_notify_proc(var_0, var_1, var_2, var_3) {
  self waittill(var_0);

  if(isDefined(var_3))
    self call[[var_1]](var_2, var_3);
  else if(isDefined(var_2))
    self call[[var_1]](var_2);
  else
    self call[[var_1]]();
}

thread_on_notify_no_endon_death(var_0, var_1, var_2, var_3, var_4) {
  childthread thread_on_notify_proc(var_0, var_1, var_2, var_3, var_4);
}

thread_on_notify(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(var_5) && isDefined(var_6)) {
    if(!isarray(var_5))
      var_5 = [var_5];

    if(!isarray(var_6))
      var_6 = [var_6];

    foreach(var_8 in var_5) {
      foreach(var_10 in var_6)
      var_8 endon(var_10);
    }
  }

  childthread thread_on_notify_proc(var_0, var_1, var_2, var_3, var_4);
}

thread_on_notify_proc(var_0, var_1, var_2, var_3, var_4) {
  self waittill(var_0);

  if(!isDefined(var_4))
    var_4 = self;

  if(isDefined(var_3))
    var_4 thread[[var_1]](var_2, var_3);
  else if(isDefined(var_2))
    var_4 thread[[var_1]](var_2);
  else
    var_4 thread[[var_1]]();
}

delaycall(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  thread delaycall_proc(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
}

delaycallwatchself(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  thread delaycall_proc_watchself(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
}

delaycall_proc_watchself(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  delaycall_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
}

delaycall_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(scripts\common\utility::issp()) {
    self endon("_encstr_AD75063D571AE108");
    self endon("_encstr_86E6106FA348D8597905A59E7367D2917068");
  }

  wait(var_1);

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_13))
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
  else if(isDefined(var_12))
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
  else if(isDefined(var_11))
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  else if(isDefined(var_10))
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  else if(isDefined(var_9))
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  else if(isDefined(var_8))
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  else if(isDefined(var_7))
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7);
  else if(isDefined(var_6))
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6);
  else if(isDefined(var_5))
    self call[[var_0]](var_2, var_3, var_4, var_5);
  else if(isDefined(var_4))
    self call[[var_0]](var_2, var_3, var_4);
  else if(isDefined(var_3))
    self call[[var_0]](var_2, var_3);
  else if(isDefined(var_2))
    self call[[var_0]](var_2);
  else
    self call[[var_0]]();
}

string_starts_with(var_0, var_1) {
  if(var_0.size < var_1.size)
    return 0;

  var_2 = getsubstr(var_0, 0, var_1.size);

  if(var_2 == var_1)
    return 1;

  return 0;
}

plot_points(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0[0];

  if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(var_2))
    var_2 = 1;

  if(!isDefined(var_3))
    var_3 = 1;

  if(!isDefined(var_4))
    var_4 = 0.05;

  for(var_6 = 1; var_6 < var_0.size; var_6++) {
    thread draw_line_for_time(var_5, var_0[var_6], var_1, var_2, var_3, var_4);
    var_5 = var_0[var_6];
  }
}

draw_line_for_time(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_5 = gettime() + var_5 * 1000;

  while(gettime() < var_5)
    wait 0.05;
}

draw_circle(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 16;

  if(isDefined(var_6))
    var_7 = var_6;

  var_8 = 360 / var_7;
  var_9 = [];

  for(var_10 = 0; var_10 < var_7; var_10++) {
    var_11 = var_8 * var_10;
    var_12 = cos(var_11) * var_1;
    var_13 = sin(var_11) * var_1;
    var_14 = var_0[0] + var_12;
    var_15 = var_0[1] + var_13;
    var_16 = var_0[2];
    var_9[var_9.size] = (var_14, var_15, var_16);
  }

  for(var_10 = 0; var_10 < var_9.size; var_10++) {
    var_17 = var_9[var_10];

    if(var_10 + 1 >= var_9.size) {
      var_18 = var_9[0];
      continue;
    }

    var_18 = var_9[var_10 + 1];
  }
}

array_add(var_0, var_1) {
  var_0[var_0.size] = var_1;
  return var_0;
}

array_add_safe(var_0, var_1) {
  if(!isDefined(var_1))
    return var_0;

  if(!isDefined(var_0))
    var_0[0] = var_1;
  else
    var_0[var_0.size] = var_1;

  return var_0;
}

array_delete(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 delete();
  }
}

array_insert(var_0, var_1, var_2) {
  if(var_2 == var_0.size) {
    var_3 = var_0;
    var_3[var_3.size] = var_1;
    return var_3;
  }

  var_3 = [];
  var_4 = 0;

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    if(var_5 == var_2) {
      var_3[var_5] = var_1;
      var_4 = 1;
    }

    var_3[var_5 + var_4] = var_0[var_5];
  }

  return var_3;
}

array_combine(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];

  if(isDefined(var_0)) {
    foreach(var_7 in var_0)
    var_5[var_5.size] = var_7;
  }

  if(isDefined(var_1)) {
    foreach(var_7 in var_1)
    var_5[var_5.size] = var_7;
  }

  if(isDefined(var_2)) {
    foreach(var_7 in var_2)
    var_5[var_5.size] = var_7;
  }

  if(isDefined(var_3)) {
    foreach(var_7 in var_3)
    var_5[var_5.size] = var_7;
  }

  if(isDefined(var_4)) {
    foreach(var_7 in var_4)
    var_5[var_5.size] = var_7;
  }

  return var_5;
}

array_combine_multiple(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    foreach(var_5 in var_3)
    var_1[var_1.size] = var_5;
  }

  return var_1;
}

array_combine_unique(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0)
  var_2[var_2.size] = var_4;

  foreach(var_4 in var_1) {
    if(array_contains(var_2, var_4)) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

array_combine_unique_keys(var_0, var_1) {
  foreach(var_4, var_3 in var_1) {
    if(!isDefined(var_0[var_4]))
      var_0[var_4] = var_3;
  }

  return var_0;
}

array_combine_non_integer_indices(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in var_0)
  var_2[var_5] = var_4;

  foreach(var_5, var_4 in var_1)
  var_2[var_5] = var_4;

  return var_2;
}

array_intersection(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(array_contains(var_1, var_4))
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

_encstr_AFF0174ACA3BE6E9C9D8F8174ECB28CD89ED530580D968E088(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(array_contains(var_1, var_3))
      return 1;
  }

  return 0;
}

array_difference(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(!array_contains(var_1, var_4))
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

can_be_shot_again(var_0) {
  var_1 = [];

  foreach(var_3 in var_0)
  var_1[var_1.size] = var_3;

  return var_1;
}

array_randomize(var_0) {
  for(var_1 = 0; var_1 < var_0.size - 1; var_1++) {
    var_2 = randomintrange(var_1, var_0.size);
    var_3 = var_0[var_1];
    var_0[var_1] = var_0[var_2];
    var_0[var_2] = var_3;
  }

  return var_0;
}

array_randomize_objects(var_0) {
  var_1 = [];

  for(var_2 = var_0; var_2.size > 0; var_2 = var_4) {
    var_3 = randomintrange(0, var_2.size);
    var_4 = [];
    var_5 = 0;

    foreach(var_8, var_7 in var_2) {
      if(var_5 == var_3)
        var_1[ter_op(isstring(var_8), var_8, var_1.size)] = var_7;
      else
        var_4[ter_op(isstring(var_8), var_8, var_4.size)] = var_7;

      var_5++;
    }
  }

  return var_1;
}

array_reverse(var_0) {
  var_1 = [];

  for(var_2 = var_0.size - 1; var_2 >= 0; var_2--)
    var_1[var_1.size] = var_0[var_2];

  return var_1;
}

array_slice(var_0, var_1, var_2) {
  if(var_0.size <= 0)
    return [];

  if(!isDefined(var_2) || var_2 > var_0.size)
    var_2 = var_0.size;

  if(var_1 == 0 && var_2 == var_0.size)
    return var_0;

  var_3 = [];

  for(var_4 = var_1; var_4 < var_2; var_4++)
    var_3[var_3.size] = var_0[var_4];

  return var_3;
}

array_contains(var_0, var_1) {
  if(var_0.size <= 0)
    return 0;

  foreach(var_3 in var_0) {
    if(var_3 == var_1)
      return 1;
  }

  return 0;
}

array_contains_key(var_0, var_1) {
  foreach(var_4, var_3 in var_0) {
    if(var_4 == var_1)
      return 1;
  }

  return 0;
}

array_find(var_0, var_1) {
  foreach(var_4, var_3 in var_0) {
    if(var_3 == var_1)
      return var_4;
  }

  return undefined;
}

array_remove(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(var_4 != var_1)
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

array_remove_array(var_0, var_1) {
  foreach(var_3 in var_1)
  var_0 = array_remove(var_0, var_3);

  return var_0;
}

array_remove_index(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_7, var_5 in var_0) {
    if(var_7 == var_1) {
      continue;
    }
    if(istrue(var_2))
      var_6 = var_7;
    else
      var_6 = var_3.size;

    var_3[var_6] = var_5;
  }

  return var_3;
}

can_path_to_target(var_0, var_1) {
  if(var_1 < 0 || var_1 >= var_0.size)
    return var_0;

  for(var_2 = var_1; var_2 < var_0.size - 1; var_2++)
    var_0[var_2] = var_0[var_2 + 1];

  var_0[var_0.size - 1] = undefined;
  return var_0;
}

array_removeundefined(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

array_removedead(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isalive(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

array_remove_key(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in var_0) {
    if(var_1 == var_5) {
      continue;
    }
    var_2[var_5] = var_4;
  }

  return var_2;
}

array_remove_duplicates(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = 1;

    foreach(var_6 in var_1) {
      if(var_3 == var_6) {
        var_4 = 0;
        break;
      }
    }

    if(var_4)
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

array_get_first_item(var_0) {
  foreach(var_2 in var_0)
  return var_2;

  return undefined;
}

array_levelthread(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    foreach(var_6 in var_0)
    thread[[var_1]](var_6, var_2, var_3, var_4);

    return;
  }

  if(isDefined(var_3)) {
    foreach(var_6 in var_0)
    thread[[var_1]](var_6, var_2, var_3);

    return;
  }

  if(isDefined(var_2)) {
    foreach(var_6 in var_0)
    thread[[var_1]](var_6, var_2);

    return;
  }

  foreach(var_6 in var_0)
  thread[[var_1]](var_6);
}

array_levelcall(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    foreach(var_6 in var_0)
    call[[var_1]](var_6, var_2, var_3, var_4);

    return;
  }

  if(isDefined(var_3)) {
    foreach(var_6 in var_0)
    call[[var_1]](var_6, var_2, var_3);

    return;
  }

  if(isDefined(var_2)) {
    foreach(var_6 in var_0)
    call[[var_1]](var_6, var_2);

    return;
  }

  foreach(var_6 in var_0)
  call[[var_1]](var_6);
}

array_sort_with_func(var_0, var_1) {
  for(var_2 = 1; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    for(var_4 = var_2 - 1; var_4 >= 0 && ![[var_1]](var_0[var_4], var_3); var_4--)
      var_0[var_4 + 1] = var_0[var_4];

    var_0[var_4 + 1] = var_3;
  }

  return var_0;
}

array_average(var_0) {
  return array_sum(var_0) / var_0.size;
}

array_sum(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0)
  var_1 = var_1 + var_3;

  return var_1;
}

array_divide(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++)
    var_0[var_2] = var_0[var_2] / var_1;

  return var_0;
}

random(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0)
  var_1[var_1.size] = var_3;

  if(!var_1.size)
    return undefined;

  return var_1[randomint(var_1.size)];
}

random_weight_sorted(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0)
  var_1[var_1.size] = var_3;

  if(!var_1.size)
    return undefined;

  var_5 = randomint(var_1.size * var_1.size);
  return var_1[var_1.size - 1 - int(sqrt(var_5))];
}

alphabetize(var_0) {
  if(var_0.size <= 1)
    return var_0;

  var_1 = 0;

  for(var_2 = var_0.size - 1; var_2 >= 1; var_2--) {
    var_3 = var_0[var_2];
    var_4 = var_2;

    for(var_5 = 0; var_5 < var_2; var_5++) {
      var_6 = var_0[var_5];

      if(stricmp(var_6, var_3) > 0) {
        var_3 = var_6;
        var_4 = var_5;
      }
    }

    if(var_4 != var_2) {
      var_0[var_4] = var_0[var_2];
      var_0[var_2] = var_3;
    }
  }

  return var_0;
}

array_thread_amortized(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(var_3)) {
    foreach(var_13 in var_0) {
      var_13 thread[[var_1]]();
      wait(var_2);
    }
  } else {
    if(!isDefined(var_4)) {
      foreach(var_13 in var_0) {
        var_13 thread[[var_1]](var_3);
        wait(var_2);
      }

      return;
    }

    if(!isDefined(var_5)) {
      foreach(var_13 in var_0) {
        var_13 thread[[var_1]](var_3, var_4);
        wait(var_2);
      }

      return;
    }

    if(!isDefined(var_6)) {
      foreach(var_13 in var_0) {
        var_13 thread[[var_1]](var_3, var_4, var_5);
        wait(var_2);
      }

      return;
    }

    if(!isDefined(var_7)) {
      foreach(var_13 in var_0) {
        var_13 thread[[var_1]](var_3, var_4, var_5, var_6);
        wait(var_2);
      }

      return;
    }

    if(!isDefined(var_8)) {
      foreach(var_13 in var_0) {
        var_13 thread[[var_1]](var_3, var_4, var_5, var_6, var_7);
        wait(var_2);
      }

      return;
    }

    if(!isDefined(var_9)) {
      foreach(var_13 in var_0) {
        var_13 thread[[var_1]](var_3, var_4, var_5, var_6, var_7, var_8);
        wait(var_2);
      }

      return;
    }

    if(!isDefined(var_10)) {
      foreach(var_13 in var_0) {
        var_13 thread[[var_1]](var_3, var_4, var_5, var_6, var_7, var_8, var_9);
        wait(var_2);
      }

      return;
    }

    if(!isDefined(var_11)) {
      foreach(var_13 in var_0) {
        var_13 thread[[var_1]](var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
        wait(var_2);
      }

      return;
    }

    foreach(var_13 in var_0) {
      var_13 thread[[var_1]](var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
      wait(var_2);
    }
  }
}

array_thread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(var_10)) {
    foreach(var_12 in var_0)
    var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    return;
  }

  if(isDefined(var_9)) {
    foreach(var_12 in var_0)
    var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    return;
  }

  if(isDefined(var_8)) {
    foreach(var_12 in var_0)
    var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    return;
  }

  if(isDefined(var_7)) {
    foreach(var_12 in var_0)
    var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7);

    return;
  }

  if(isDefined(var_6)) {
    foreach(var_12 in var_0)
    var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6);

    return;
  }

  if(isDefined(var_5)) {
    foreach(var_12 in var_0)
    var_12 thread[[var_1]](var_2, var_3, var_4, var_5);

    return;
  }

  if(isDefined(var_4)) {
    foreach(var_12 in var_0)
    var_12 thread[[var_1]](var_2, var_3, var_4);

    return;
  }

  if(isDefined(var_3)) {
    foreach(var_12 in var_0)
    var_12 thread[[var_1]](var_2, var_3);

    return;
  }

  if(isDefined(var_2)) {
    foreach(var_12 in var_0)
    var_12 thread[[var_1]](var_2);

    return;
  }

  foreach(var_12 in var_0)
  var_12 thread[[var_1]]();
}

array_call(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_9)) {
    foreach(var_11 in var_0)
    var_11 call[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    return;
  }

  if(isDefined(var_8)) {
    foreach(var_11 in var_0)
    var_11 call[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    return;
  }

  if(isDefined(var_7)) {
    foreach(var_11 in var_0)
    var_11 call[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7);

    return;
  }

  if(isDefined(var_6)) {
    foreach(var_11 in var_0)
    var_11 call[[var_1]](var_2, var_3, var_4, var_5, var_6);

    return;
  }

  if(isDefined(var_5)) {
    foreach(var_11 in var_0)
    var_11 call[[var_1]](var_2, var_3, var_4, var_5);

    return;
  }

  if(isDefined(var_4)) {
    foreach(var_11 in var_0)
    var_11 call[[var_1]](var_2, var_3, var_4);

    return;
  }

  if(isDefined(var_3)) {
    foreach(var_11 in var_0)
    var_11 call[[var_1]](var_2, var_3);

    return;
  }

  if(isDefined(var_2)) {
    foreach(var_11 in var_0)
    var_11 call[[var_1]](var_2);

    return;
  }

  foreach(var_11 in var_0)
  var_11 call[[var_1]]();
}

flat_angle(var_0) {
  var_1 = (0, var_0[1], 0);
  return var_1;
}

flat_origin(var_0) {
  var_1 = (var_0[0], var_0[1], 0);
  return var_1;
}

flatten_vector(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = (0, 0, 1);

  var_2 = vectorNormalize(var_0 - vectordot(var_1, var_0) * var_1);
  return var_2;
}

draw_arrow_time(var_0, var_1, var_2, var_3) {
  level endon("_encstr_87DE08E656DDC158E81A");
  var_4 = [];
  var_5 = vectortoangles(var_0 - var_1);
  var_6 = anglestoright(var_5);
  var_7 = anglesToForward(var_5);
  var_8 = anglestoup(var_5);
  var_9 = distance(var_0, var_1);
  var_10 = [];
  var_11 = 0.1;
  var_10[0] = var_0;
  var_10[1] = var_0 + var_6 * (var_9 * var_11) + var_7 * (var_9 * -0.1);
  var_10[2] = var_1;
  var_10[3] = var_0 + var_6 * (var_9 * (-1 * var_11)) + var_7 * (var_9 * -0.1);
  var_10[4] = var_0;
  var_10[5] = var_0 + var_8 * (var_9 * var_11) + var_7 * (var_9 * -0.1);
  var_10[6] = var_1;
  var_10[7] = var_0 + var_8 * (var_9 * (-1 * var_11)) + var_7 * (var_9 * -0.1);
  var_10[8] = var_0;
  var_12 = var_2[0];
  var_13 = var_2[1];
  var_14 = var_2[2];
  plot_points(var_10, var_12, var_13, var_14, var_3);
}

draw_arrow(var_0, var_1, var_2) {
  level endon("_encstr_87DE08E656DDC158E81A");
  var_3 = [];
  var_4 = vectortoangles(var_0 - var_1);
  var_5 = anglestoright(var_4);
  var_6 = anglesToForward(var_4);
  var_7 = distance(var_0, var_1);
  var_8 = [];
  var_9 = 0.05;
  var_8[0] = var_0;
  var_8[1] = var_0 + var_5 * (var_7 * var_9) + var_6 * (var_7 * -0.2);
  var_8[2] = var_1;
  var_8[3] = var_0 + var_5 * (var_7 * (-1 * var_9)) + var_6 * (var_7 * -0.2);

  for(var_10 = 0; var_10 < 4; var_10++) {
    var_11 = var_10 + 1;

    if(var_11 >= 4)
      var_11 = 0;
  }
}

draw_capsule(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_3))
    var_3 = (0, 0, 0);

  if(!isDefined(var_5))
    var_5 = 0;

  if(!isDefined(var_6))
    var_6 = 1;

  var_7 = anglesToForward(var_3);
  var_8 = anglestoright(var_3);
  var_9 = anglestoup(var_3);
  var_10 = var_0 + var_9 * var_1;
  var_11 = var_0 + var_9 * var_2;
  var_11 = var_11 - var_9 * var_1;
  var_12 = var_10 + var_7 * var_1;
  var_13 = var_11 + var_7 * var_1;
  var_14 = var_10 - var_7 * var_1;
  var_15 = var_11 - var_7 * var_1;
  var_16 = var_10 + var_8 * var_1;
  var_17 = var_11 + var_8 * var_1;
  var_18 = var_10 - var_8 * var_1;
  var_19 = var_11 - var_8 * var_1;
}

draw_character_capsule(var_0, var_1, var_2) {
  var_3 = self physics_getcharactercollisioncapsule();
  draw_capsule(self getorigin(), var_3["_encstr_8D4607ABF0ABE4FB47"], var_3["_encstr_8F0D0C43C21B33EB3456A5D9A11D"] * 2, self.angles, var_0, var_1, var_2);
}

draw_player_capsule(var_0, var_1, var_2) {
  var_3 = self physics_getcharactercollisioncapsule();
  draw_capsule(self getorigin(), var_3["_encstr_8D4607ABF0ABE4FB47"], var_3["_encstr_8F0D0C43C21B33EB3456A5D9A11D"] * 2, self getplayerangles(), var_0, var_1, var_2);
}

draw_ent_bone_forever(var_0, var_1) {
  self endon("_encstr_AFE9129B47F6E0F5C8930BBBA537CE7D583C96DC");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_2 = self gettagorigin(var_0);
    var_3 = self gettagangles(var_0);
    draw_angles(var_3, var_2, var_1);
    waitframe();
  }
}

draw_ent_axis_forever(var_0, var_1) {
  self endon("_encstr_AFE9129B47F6E0F5C8930BBBA537CE7D583C96DC");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    draw_ent_axis(var_0, undefined, var_1);
    waitframe();
  }
}

draw_tag_axis_forever(var_0, var_1, var_2) {
  self endon("_encstr_AFE9129B47F6E0F5C8930BBBA537CE7D583C96DC");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    draw_tag_axis(var_0, var_1, undefined, var_2);
    waitframe();
  }
}

draw_ent_axis(var_0, var_1, var_2) {
  waittillframeend;

  if(isDefined(self.angles))
    var_3 = self.angles;
  else
    var_3 = (0, 0, 0);

  draw_angles(var_3, self.origin, var_0, var_1, var_2);
}

draw_tag_axis(var_0, var_1, var_2, var_3) {
  waittillframeend;
  var_4 = self gettagangles(var_0);
  var_5 = self gettagorigin(var_0);
  draw_angles(var_4, var_5, var_1, var_2, var_3);
}

draw_angles(var_0, var_1, var_2, var_3, var_4) {
  waittillframeend;
  var_5 = anglesToForward(var_0);
  var_6 = anglestoright(var_0);
  var_7 = anglestoup(var_0);

  if(!isDefined(var_2))
    var_2 = (1, 0, 1);

  if(!isDefined(var_3))
    var_3 = 1;

  if(!isDefined(var_4))
    var_4 = 10;
}

draw_entity_bounds(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2))
    var_2 = (0, 1, 0);

  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(var_4))
    var_4 = 0.05;

  if(var_3)
    var_5 = int(var_4 / 0.05);
  else
    var_5 = int(var_1 / 0.05);

  var_6 = [];
  var_7 = [];
  var_8 = gettime();

  for(var_9 = var_8 + var_1 * 1000; var_8 < var_9 && isDefined(var_0); var_8 = gettime()) {
    var_6[0] = var_0 getpointinbounds(1, 1, 1);
    var_6[1] = var_0 getpointinbounds(1, 1, -1);
    var_6[2] = var_0 getpointinbounds(-1, 1, -1);
    var_6[3] = var_0 getpointinbounds(-1, 1, 1);
    var_7[0] = var_0 getpointinbounds(1, -1, 1);
    var_7[1] = var_0 getpointinbounds(1, -1, -1);
    var_7[2] = var_0 getpointinbounds(-1, -1, -1);
    var_7[3] = var_0 getpointinbounds(-1, -1, 1);

    for(var_10 = 0; var_10 < 4; var_10++) {
      var_11 = var_10 + 1;

      if(var_11 == 4)
        var_11 = 0;
    }

    if(!var_3) {
      return;
    }
    wait(var_4);
  }
}

getfx(var_0) {
  return level._effect[var_0];
}

fxexists(var_0) {
  return isDefined(level._effect[var_0]);
}

playerunlimitedammothread() {}

spawn_tag_origin(var_0, var_1) {
  if(!isDefined(var_1) && isDefined(self.angles))
    var_1 = self.angles;

  if(!isDefined(var_0) && isDefined(self.origin))
    var_0 = self.origin;
  else if(!isDefined(var_0))
    var_0 = (0, 0, 0);

  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_2 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2 hide();

  if(isDefined(var_1))
    var_2.angles = var_1;

  return var_2;
}

waittill_notify_or_timeout(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
}

waittill_notify_or_timeout_return(var_0, var_1) {
  var_2 = spawnStruct();
  thread waittill_notify_proc(var_2, var_0);
  thread waittill_timeout_proc(var_2, var_1);
  var_2 waittill("_encstr_9B620E9F2BA0F3234370C2F91B2697EE", var_3);
  return var_3;
}

waittill_notify_proc(var_0, var_1) {
  var_0 endon("_encstr_9B620E9F2BA0F3234370C2F91B2697EE");
  self waittill(var_1);
  var_0 notify("_encstr_9B620E9F2BA0F3234370C2F91B2697EE", var_1);
}

waittill_timeout_proc(var_0, var_1) {
  var_0 endon("_encstr_9B620E9F2BA0F3234370C2F91B2697EE");
  wait(var_1);
  var_0 notify("_encstr_9B620E9F2BA0F3234370C2F91B2697EE", "_encstr_995408F398012F656821");
}

waittill_notify_and_time(var_0, var_1) {
  var_2 = gettime();
  self waittill(var_0);
  var_3 = var_2 + var_1 * 1000;
  var_4 = var_3 - var_2;

  if(var_4 > 0) {
    var_5 = var_4 / 1000.0;
    wait(var_5);
  }
}

array_wait(var_0, var_1, var_2) {
  var_3 = spawnStruct();

  if(istrue(var_2)) {
    thread array_wait_timeout_proc(var_3, var_2);
    var_3 endon("_encstr_AA6E13DB2B7309E2AF2489DB53787BD76860FAABFB");
  }

  foreach(var_5 in var_0)
  thread array_wait_proc(var_3, var_5, var_1);

  for(var_7 = 0; var_7 < var_0.size; var_7++)
    var_3 waittill("_encstr_BEA61038FB4201DBD1C3A7BB1B0911ABB747");

  var_3 notify("_encstr_A202136843FAAB420F0FCF33E4E7CB5B66FAF070CB");
}

array_wait_proc(var_0, var_1, var_2) {
  var_0 endon("_encstr_A202136843FAAB420F0FCF33E4E7CB5B66FAF070CB");
  var_1 _id_143A5(var_2, "_encstr_AD75063D571AE108");
  var_0 notify("_encstr_BEA61038FB4201DBD1C3A7BB1B0911ABB747");
}

array_wait_timeout_proc(var_0, var_1) {
  var_0 endon("_encstr_A202136843FAAB420F0FCF33E4E7CB5B66FAF070CB");
  wait(var_1);
  var_0 notify("_encstr_AA6E13DB2B7309E2AF2489DB53787BD76860FAABFB");
}

array_any_wait(var_0, var_1) {
  var_2 = spawnStruct();

  foreach(var_4 in var_0)
  thread array_any_wait_proc(var_2, var_4, var_1);

  var_2 waittill("_encstr_BEA61038FB4201DBD1C3A7BB1B0911ABB747", var_6);
  return var_6;
}

array_any_wait_timeout(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  thread array_any_wait_timeout_proc(var_3, var_2);

  foreach(var_5 in var_0)
  thread array_any_wait_proc(var_3, var_5, var_1);

  var_3 waittill("_encstr_BEA61038FB4201DBD1C3A7BB1B0911ABB747", var_7);
  return var_7;
}

array_any_wait_proc(var_0, var_1, var_2) {
  var_3 = var_1 waittill_any_return_no_endon_death(var_2, "_encstr_AD75063D571AE108");
  var_0 notify("_encstr_BEA61038FB4201DBD1C3A7BB1B0911ABB747", var_3);
}

array_any_wait_timeout_proc(var_0, var_1) {
  var_0 endon("_encstr_BEA61038FB4201DBD1C3A7BB1B0911ABB747");
  wait(var_1);
  var_0 notify("_encstr_BEA61038FB4201DBD1C3A7BB1B0911ABB747", "_encstr_995408F398012F656821");
}

array_any_wait_return(var_0, var_1) {
  var_2 = spawnStruct();

  foreach(var_4 in var_0)
  thread array_any_wait_return_proc(var_2, var_4, var_1);

  var_2 waittill("_encstr_BEA61038FB4201DBD1C3A7BB1B0911ABB747", var_4);
  return var_4;
}

array_any_wait_return_proc(var_0, var_1, var_2) {
  var_3 = var_1 _id_143AD(var_2, "_encstr_AD75063D571AE108");
  var_0 notify("_encstr_BEA61038FB4201DBD1C3A7BB1B0911ABB747", var_1);
}

fileprint_launcher_start_file()
{
  level.fileprintlauncher_linecount = 0;
  level. fileprint_launcher = 1;
  fileprint_launcher( "_encstr_9648149F35F1BD4137CCC50407E797555BC6B1F1770A" );
}

fileprint_launcher( var_0 )
{
  level.fileprintlauncher_linecount++;

  if(level.fileprintlauncher_linecount > 200) {
    wait 0.05;
    level.fileprintlauncher_linecount = 0;
  }
}

fileprint_launcher_end_file( var_0, var_1 )
{
  if(!isDefined(var_1))
    var_1 = 0;

  if(var_1)
    fileprint_launcher( "_encstr_8BA125A7B11485C16D6B45CB456DB84E3C4127AA694D35D8019E9C75D5B97715A481A3FBC1850A" + var_0 );
  else
    fileprint_launcher( "_encstr_83E2128E82A915054A92C945A29C448CA4C4A8D1" + var_0 );

    var_2 = gettime() + 4000;

  while(getdvarint("_encstr_BE3A17890A55271A095129F5822529C9A8FA6A55A1D0516A35") == 0 && getDvar("_encstr_8B01147CD7A3F9AF5CE8A2AF91B9E88545EE2BEDBFD8") == "_encstr_934C0218" && gettime() < var_2)
    wait 0.05;

  if(!(gettime() < var_2)) {
    iprintlnbold("_encstr_88765404CBE1DD5F73F541997F56AF05010F8691739188BA3FCFC8A025A797CBFA4B0278A190E35BB620025BC97843BF3053D3946F42EA3F669B5AA333E78336AB354B68637826F7807146CB9BA3EAEE3893C99E3F92");
    level. fileprint_launcher = undefined;
    return 0;
  }

  var_3 = getDvar("_encstr_8B01147CD7A3F9AF5CE8A2AF91B9E88545EE2BEDBFD8");

  if(var_3 != "_encstr_934C0218") {
    iprintlnbold("_encstr_9AA11764CD63A5DF7B25B97F3B09887435E19D7F57DB283A1F" + var_3 + "_encstr_923337CA1B5A462C309BB5FE10387ACA583D4B73632ECB4762036FC28BE0A2F387A1DFEFC54652D51861668D61C2EC4B8351672F43FBFAD7B2");
    level. fileprint_launcher = undefined;
    return 0;
  }

  iprintlnbold("_encstr_8A6123C4B057CDB1342B2780DD27961D5901A3F608CCA58DB201B9AE36365937E666AB6348");
  level. fileprint_launcher = undefined;
  return 1;
}

launcher_write_clipboard(var_0) {
  level.fileprintlauncher_linecount = 0;
  fileprint_launcher( "_encstr_A9750F51CF99E8C9908FAF06264C413F87" + var_0 );
}

activate_individual_exploder() {
  scripts\common\exploder::activate_individual_exploder_proc();
}

get_target_ent(var_0) {
  if(!isDefined(var_0))
    var_0 = self.target;

  var_1 = getEnt(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_1))
    return var_1;

  if(scripts\common\utility::issp()) {
    var_1 = call[[level.getnodefunction]](var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_1))
      return var_1;

    var_1 = call[[level.func["_encstr_B87F0BE02F1B42285FA36B8D2E"]]](var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_1))
      return var_1;
  }

  var_1 = getStruct(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_1))
    return var_1;

  var_1 = getvehiclenode(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_1))
    return var_1;
}

get_links() {
  return strtok(self.script_linkto, "_encstr_974C0246");
}

get_linked_ents() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = get_links();

    foreach(var_3 in var_1) {
      var_4 = getEntArray(var_3, "_encstr_A29D10371B275A1C47F536969BDAB90BB5B2");

      if(var_4.size > 0)
        var_0 = array_combine(var_0, var_4);
    }
  }

  return var_0;
}

get_linked_ent() {
  var_0 = get_linked_ents();
  return var_0[0];
}

get_linked_nodes() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = get_links();

    foreach(var_3 in var_1) {
      var_4 = getnodearray(var_3, "_encstr_A29D10371B275A1C47F536969BDAB90BB5B2");

      if(var_4.size > 0)
        var_0 = array_combine(var_0, var_4);
    }
  }

  return var_0;
}

do_earthquake(var_0, var_1) {
  var_2 = level.earthquake[var_0];
  earthquake(var_2["_encstr_B8DB0A1D2F61B51489737902"], var_2["_encstr_A7AC09C857E458475AED37"], var_1, var_2["_encstr_8D4607ABF0ABE4FB47"]);
}

play_loopsound_in_space(var_0, var_1) {
  var_2 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));

  if(!isDefined(var_1))
    var_1 = self.origin;

  var_2.origin = var_1;
  var_2 playLoopSound(var_0);
  return var_2;
}

play_sound_in_space_with_angles(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 1));

  if(!isDefined(var_1))
    var_1 = self.origin;

  var_5.origin = var_1;
  var_5.angles = var_2;

  if(isDefined(var_4))
    var_5 linkTo(var_4);

  if(scripts\common\utility::issp()) {
    var_5 playSound(var_0, "_encstr_95C70A37B8E87540AD27CEA1");
    var_5 waittill("_encstr_95C70A37B8E87540AD27CEA1");
  } else
    var_5 playSound(var_0);

  var_5 delete();
}

play_sound_in_space(var_0, var_1, var_2, var_3) {
  play_sound_in_space_with_angles(var_0, var_1, (0, 0, 0), var_2, var_3);
}

loop_fx_sound(var_0, var_1, var_2, var_3, var_4) {
  loop_fx_sound_with_angles(var_0, var_1, (0, 0, 0), var_2, var_3, var_4);
}

loop_fx_sound_with_angles(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(istrue(var_3)) {
    if(!isDefined(level.first_frame) || level.first_frame == 1)
      spawnloopingsound(var_0, var_1, var_2);
  } else {
    if(level.createfx_enabled && isDefined(var_5.loopsound_ent))
      var_7 = var_5.loopsound_ent;
    else
      var_7 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));

    if(isDefined(var_4)) {
      thread loop_sound_delete(var_4, var_7);
      self endon(var_4);
    }

    var_7.origin = var_1;
    var_7.angles = var_2;
    var_7 playLoopSound(var_0);

    if(level.createfx_enabled)
      var_5.loopsound_ent = var_7;
    else
      var_7 willneverchange();
  }
}

loop_fx_sound_interval(var_0, var_1, var_2, var_3, var_4, var_5) {
  loop_fx_sound_interval_with_angles(var_0, var_1, (0, 0, 0), var_2, var_3, var_4, var_5);
}

loop_fx_sound_interval_with_angles(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self.origin = var_1;
  self.angles = var_2;

  if(isDefined(var_3))
    self endon(var_3);

  if(var_5 >= var_6) {
    for(;;)
      wait 0.05;
  }

  if(!soundexists(var_0)) {
    for(;;)
      wait 0.05;
  }

  for(;;) {
    wait(randomfloatrange(var_5, var_6));
    lock("_encstr_AF76100B3E592BEBB73A537044F018F88D02");
    thread play_sound_in_space_with_angles(var_0, self.origin, self.angles, undefined);
    unlock("_encstr_AF76100B3E592BEBB73A537044F018F88D02");
  }
}

loop_sound_delete(var_0, var_1) {
  var_1 endon("_encstr_AD75063D571AE108");
  self waittill(var_0);
  var_1 delete();
}

createloopeffect(var_0) {
  var_1 = scripts\common\createfx::createeffect("_encstr_BE7F073BF060E0F269", var_0);
  var_1.v["_encstr_96750613A808E91B"] = scripts\common\createfx::getloopeffectdelaydefault();
  return var_1;
}

createoneshoteffect(var_0) {
  var_1 = scripts\common\createfx::createeffect("_encstr_B6480A92880DD02267293B7B", var_0);
  var_1.v["_encstr_96750613A808E91B"] = scripts\common\createfx::getoneshoteffectdelaydefault();
  return var_1;
}

createexploder(var_0, var_1) {
  var_2 = scripts\common\createfx::createeffect("_encstr_A63B09CA3CE01B7B8C2B27", var_0, var_1);
  var_2.v["_encstr_96750613A808E91B"] = scripts\common\createfx::getexploderdelaydefault();
  var_2.v["_encstr_81470E2588617828C789CD1F8B8A438A"] = "_encstr_820E07FAE8780B3A4C";
  return var_2;
}

play_loop_sound_on_entity(var_0, var_1) {
  var_2 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));
  var_2 endon("_encstr_AD75063D571AE108");
  thread delete_on_death(var_2);

  if(isDefined(var_1)) {
    var_2.origin = self.origin + var_1;
    var_2.angles = self.angles;
    var_2 linkTo(self);
  } else {
    var_2.origin = self.origin;
    var_2.angles = self.angles;
    var_2 linkTo(self);
  }

  var_2 playLoopSound(var_0);
  self waittill("_encstr_9B8F0BAE0BE2F1097BBF50807B" + var_0);
  var_2 stoploopsound(var_0);
  var_2 delete();
}

stop_loop_sound_on_entity(var_0) {
  self notify("_encstr_9B8F0BAE0BE2F1097BBF50807B" + var_0);
}

delete_on_death(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(var_0))
    var_0 delete();
}

delete_on_sounddone() {
  self waittill("_encstr_95C70A37B8E87540AD27CEA1");
  self delete();
}

delete_on_notify(var_0) {
  self waittill(var_0);
  self delete();
}

error(var_0) {
  waitframe();
}

exploder(var_0, var_1, var_2) {
  [[level._fx.exploderfunction]](var_0, var_1, var_2);
}

delete_exploder(var_0) {
  scripts\common\exploder::delete_exploder_proc(var_0);
}

hide_exploder_models(var_0) {
  scripts\common\exploder::hide_exploder_models_proc(var_0);
}

show_exploder_models(var_0) {
  scripts\common\exploder::show_exploder_models_proc(var_0);
}

stop_exploder(var_0, var_1) {
  scripts\common\exploder::stop_exploder_proc(var_0, var_1, 0);
}

kill_exploder(var_0, var_1) {
  scripts\common\exploder::stop_exploder_proc(var_0, var_1, 1);
}

get_exploder_array(var_0) {
  return scripts\common\exploder::get_exploder_array_proc(var_0);
}

ter_op(var_0, var_1, var_2) {
  if(var_0)
    return var_1;

  return var_2;
}

create_lock(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(level.lock))
    level.lock = [];

  var_2 = spawnStruct();
  var_2.max_count = var_1;
  var_2.count = 0;
  level.lock[var_0] = var_2;
}

lock(var_0) {
  var_1 = level.lock[var_0];

  while(var_1.count >= var_1.max_count)
    var_1 waittill("_encstr_AA7109F35BB0C8A11A2D8C");

  var_1.count++;
}

unlock(var_0) {
  thread unlock_thread(var_0);
}

unlock_thread(var_0) {
  wait 0.05;
  var_1 = level.lock[var_0];
  var_1.count--;
  var_1 notify("_encstr_AA7109F35BB0C8A11A2D8C");
}

unlock_wait(var_0) {
  thread unlock_thread(var_0);
  wait 0.05;
}

is_player_gamepad_enabled() {
  var_0 = self usinggamepad();

  if(isDefined(var_0))
    return var_0;
  else if(self ispcplayer())
    return 0;
  else
    return 1;
}

distance_2d_squared(var_0, var_1) {
  return length2dsquared(var_0 - var_1);
}

get_array_of_farthest(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = get_array_of_closest(var_0, var_1, var_2, var_3, var_4, var_5);
  var_6 = array_reverse(var_6);
  return var_6;
}

get_array_of_closest(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_3))
    var_3 = var_1.size;

  if(!isDefined(var_2))
    var_2 = [];

  var_6 = undefined;

  if(isDefined(var_4))
    var_6 = var_4 * var_4;

  var_7 = 0;

  if(isDefined(var_5))
    var_7 = var_5 * var_5;

  if(var_2.size == 0 && var_3 >= var_1.size && var_7 == 0 && !isDefined(var_6))
    return sortbydistance(var_1, var_0);

  var_8 = [];

  foreach(var_10 in var_1) {
    var_11 = 0;

    foreach(var_13 in var_2) {
      if(var_10 == var_13) {
        var_11 = 1;
        break;
      }
    }

    if(var_11) {
      continue;
    }
    var_15 = distancesquared(var_0, var_10.origin);

    if(isDefined(var_6) && var_15 > var_6) {
      continue;
    }
    if(var_15 < var_7) {
      continue;
    }
    var_8[var_8.size] = var_10;
  }

  var_8 = sortbydistance(var_8, var_0);

  if(var_3 >= var_8.size)
    return var_8;

  var_17 = [];

  for(var_18 = 0; var_18 < var_3; var_18++)
    var_17[var_18] = var_8[var_18];

  return var_17;
}

drop_to_ground(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1))
    var_1 = 1500;

  if(!isDefined(var_2))
    var_2 = -12000;

  if(!isDefined(var_4))
    var_4 = scripts\engine\trace::create_solid_ai_contents(1);

  if(isDefined(var_3))
    return scripts\engine\trace::ray_trace(var_0 + var_1 * var_3, var_0 + var_2 * var_3, undefined, var_4)["_encstr_BD260953AA97E3F014279D"];
  else
    return scripts\engine\trace::ray_trace(var_0 + (0, 0, var_1), var_0 + (0, 0, var_2), undefined, var_4)["_encstr_BD260953AA97E3F014279D"];
}

player_drop_to_ground(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2))
    var_2 = 1500;

  if(!isDefined(var_3))
    var_3 = -12000;

  var_5 = scripts\engine\trace::create_solid_ai_contents(1);

  if(isDefined(var_4))
    return scripts\engine\trace::sphere_trace(var_0 + var_2 * var_4, var_0 + var_3 * var_4, var_1, undefined, var_5)["_encstr_BD260953AA97E3F014279D"];
  else
    return scripts\engine\trace::sphere_trace(var_0 + (0, 0, var_2), var_0 + (0, 0, var_3), var_1, undefined, var_5)["_encstr_BD260953AA97E3F014279D"];
}

within_fov(var_0, var_1, var_2, var_3) {
  var_4 = vectorNormalize(var_2 - var_0);
  var_5 = anglesToForward(var_1);
  var_6 = vectordot(var_5, var_4);
  return var_6 >= var_3;
}

ai_3d_sighting_model(var_0) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["_encstr_876615B0A5AFCC32FACD4BD9D03AD2DCECD76BDEC856B1"]))
    return self[[level.bot_funcs["_encstr_876615B0A5AFCC32FACD4BD9D03AD2DCECD76BDEC856B1"]]](var_0);
}

getclosest(var_0, var_1, var_2) {
  if(var_1.size == 0)
    return undefined;

  var_3 = sortbydistance(var_1, var_0)[0];

  if(isDefined(var_2) && distancesquared(var_0, var_3.origin) > squared(var_2))
    return undefined;

  return var_3;
}

missile_settargetandflightmode(var_0, var_1, var_2) {
  var_2 = ter_op(isDefined(var_2), var_2, (0, 0, 0));
  self missile_settargetEnt(var_0, var_2);

  switch (var_1) {
    case "_encstr_BE450734FB03DF9EA9":
      self missile_setflightmodedirect();
      break;
    case "_encstr_AC190479FF92":
      self missile_setflightmodetop();
      break;
  }
}

add_fx(var_0, var_1) {
  if(!isDefined(level._effect))
    level._effect = [];

  level._effect[var_0] = loadfx(var_1);
}

create_func_ref(var_0, var_1) {
  if(!isDefined(level.func))
    level.func = [];

  level.func[var_0] = var_1;
}

create_empty_func_ref(var_0) {
  if(!isDefined(level.func))
    level.func = [];

  if(!isDefined(level.func[var_0]))
    create_func_ref(var_0, ::empty_init_func);
}

func_ref_exist(var_0) {
  return isDefined(level.func) && isDefined(level.func[var_0]);
}

add_init_script(var_0, var_1) {
  if(!isDefined(level.init_script))
    level.init_script = [];

  if(isDefined(level.init_script[var_0]))
    return 0;

  level.init_script[var_0] = var_1;
  return 1;
}

add_frame_event(var_0) {
  if(!isDefined(self.frame_events)) {
    self.frame_events = [var_0];
    thread process_frame_events();
  } else
    self.frame_events[self.frame_events.size] = var_0;
}

process_frame_events() {
  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    foreach(var_1 in self.frame_events)
    self thread[[var_1]]();

    waitframe();
  }
}

delaythread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  thread delaythread_proc(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

delaythread_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("_encstr_9A9512DA8B787009C53B5B672B6083D03831D667");

  if(isPlayer(self))
    self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  else
    self endon("_encstr_AD75063D571AE108");

  wait(var_1);

  if(isDefined(var_8))
    thread[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  else if(isDefined(var_7))
    thread[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7);
  else if(isDefined(var_6))
    thread[[var_0]](var_2, var_3, var_4, var_5, var_6);
  else if(isDefined(var_5))
    thread[[var_0]](var_2, var_3, var_4, var_5);
  else if(isDefined(var_4))
    thread[[var_0]](var_2, var_3, var_4);
  else if(isDefined(var_3))
    thread[[var_0]](var_2, var_3);
  else if(isDefined(var_2))
    thread[[var_0]](var_2);
  else
    thread[[var_0]]();
}

damagelocationisany(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(self.damagelocation)) {
    if(!isDefined(var_0))
      return 0;

    if(self.damagelocation == var_0)
      return 1;

    if(!isDefined(var_1))
      return 0;

    if(self.damagelocation == var_1)
      return 1;

    if(!isDefined(var_2))
      return 0;

    if(self.damagelocation == var_2)
      return 1;

    if(!isDefined(var_3))
      return 0;

    if(self.damagelocation == var_3)
      return 1;

    if(!isDefined(var_4))
      return 0;

    if(self.damagelocation == var_4)
      return 1;

    if(!isDefined(var_5))
      return 0;

    if(self.damagelocation == var_5)
      return 1;

    if(!isDefined(var_6))
      return 0;

    if(self.damagelocation == var_6)
      return 1;

    if(!isDefined(var_7))
      return 0;

    if(self.damagelocation == var_7)
      return 1;

    if(!isDefined(var_8))
      return 0;

    if(self.damagelocation == var_8)
      return 1;

    if(!isDefined(var_9))
      return 0;

    if(self.damagelocation == var_9)
      return 1;

    if(!isDefined(var_10))
      return 0;

    if(self.damagelocation == var_10)
      return 1;
  }

  return damagesubpartlocationisany(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

damagesubpartlocationisany(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(self.damagedsubpart))
    return 0;

  if(!isDefined(var_0))
    return 0;

  if(self.damagedsubpart == var_0)
    return 1;

  if(!isDefined(var_1))
    return 0;

  if(self.damagedsubpart == var_1)
    return 1;

  if(!isDefined(var_2))
    return 0;

  if(self.damagedsubpart == var_2)
    return 1;

  if(!isDefined(var_3))
    return 0;

  if(self.damagedsubpart == var_3)
    return 1;

  if(!isDefined(var_4))
    return 0;

  if(self.damagedsubpart == var_4)
    return 1;

  if(!isDefined(var_5))
    return 0;

  if(self.damagedsubpart == var_5)
    return 1;

  if(!isDefined(var_6))
    return 0;

  if(self.damagedsubpart == var_6)
    return 1;

  if(!isDefined(var_7))
    return 0;

  if(self.damagedsubpart == var_7)
    return 1;

  if(!isDefined(var_8))
    return 0;

  if(self.damagedsubpart == var_8)
    return 1;

  if(!isDefined(var_9))
    return 0;

  if(self.damagedsubpart == var_9)
    return 1;

  if(!isDefined(var_10))
    return 0;

  if(self.damagedsubpart == var_10)
    return 1;

  return 0;
}

isbulletdamage(var_0) {
  switch (var_0) {
    case "_encstr_87280E1FB705D168313D1FD197B1A799":
    case "_encstr_950A12A99E887D284AD42A7A31D748AA98C4A215":
    case "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9":
      return 1;
    default:
      return 0;
  }
}

isvalidpeekoutdir(var_0) {
  var_1 = self;
  var_2 = var_1 getvalidcoverpeekouts();

  foreach(var_4 in var_2) {
    if(var_4 == var_0)
      return 1;
  }

  return 0;
}

getbestcovermultinodetype(var_0) {
  var_1 = var_0 getvalidcovermultinodetypes();

  if(var_1.size <= 0)
    return undefined;

  var_2 = 0;

  if(isDefined(self.enemy)) {
    var_3 = self.enemy.origin;

    if(issentient(self.enemy) && self lastknowntime(self.enemy) > 0)
      var_3 = self lastknownpos(self.enemy);

    var_4 = vectortoangles(var_3 - var_0.origin);
    var_2 = angleclamp180(var_4[1] - var_0.angles[1]);
  }

  foreach(var_6 in var_1) {
    switch (var_6) {
      case "_encstr_AFFF0C6E8FE899DDE6174B068510":
      case "_encstr_87AB0D4BD7B857DB077503DA9B8EEB":
        if(abs(var_2) < 30)
          return var_6;

        break;
      case "_encstr_8267124310DE69AADAED119B9B5206A220A572E0":
      case "_encstr_A7760B6710A315533959DF17AD":
        if(var_2 > 30)
          return "_encstr_A7760B6710A315533959DF17AD";

        break;
      case "_encstr_A777136710A315533956DC57A349AEFB8BA8377F40":
      case "_encstr_86A30C90489C3F32B21DA9AF0178":
        if(var_2 < -30)
          return "_encstr_86A30C90489C3F32B21DA9AF0178";

        break;
      default:
    }
  }

  var_8 = var_1[0];

  switch (var_8) {
    case "_encstr_8267124310DE69AADAED119B9B5206A220A572E0":
      return "_encstr_A7760B6710A315533959DF17AD";
    case "_encstr_A777136710A315533956DC57A349AEFB8BA8377F40":
      return "_encstr_86A30C90489C3F32B21DA9AF0178";
  }

  return var_8;
}

isnodecoverleft(var_0) {
  return var_0.type == "_encstr_A7760B6710A315533959DF17AD";
}

isnodecoverright(var_0) {
  return var_0.type == "_encstr_86A30C90489C3F32B21DA9AF0178";
}

isnodecovercrouchtype(var_0, var_1) {
  if(var_0.type == "_encstr_87AB0D4BD7B857DB077503DA9B8EEB" && isDefined(self._blackboard.croucharrivaltype))
    return self._blackboard.croucharrivaltype == var_1;

  return 0;
}

isnode3d(var_0) {
  return isnodecover3d(var_0) || isnodeexposed3d(var_0);
}

isnodecover3d(var_0) {
  return var_0.type == "_encstr_A9700F9D2D8ED0C60647F9DB9B6A27DA14" || var_0.type == "_encstr_BEC809853586D8CEFECE81";
}

isnodeexposed3d(var_0) {
  return var_0.type == "_encstr_87820B3588934FE3ED137AEA7B" || var_0.type == "_encstr_926B08AB070DD449229D";
}

isnodecovercrouch(var_0) {
  return var_0.type == "_encstr_87AB0D4BD7B857DB077503DA9B8EEB" || var_0.type == "_encstr_854714E37F10FF63BFDD9B32636643E641DB764CE7F0" || var_0.type == "_encstr_9A520FAD2525079A4E3292270DBF5B7A9C";
}

absangleclamp180(var_0) {
  return abs(angleclamp180(var_0));
}

getaimyawtopoint(var_0) {
  var_1 = getyawtospot(var_0);
  var_2 = distance(self.origin, var_0);

  if(var_2 > 3) {
    var_3 = asin(-3 / var_2);
    var_1 = var_1 - var_3;
  }

  var_1 = angleclamp180(var_1);
  return var_1;
}

getyawtospot(var_0) {
  if(actor_is3d()) {
    var_1 = anglesToForward(self.angles);
    var_2 = rotatepointaroundvector(var_1, var_0 - self.origin, self.angles[2] * -1);
    var_0 = var_2 + self.origin;
  }

  var_3 = getyaw(var_0) - self.angles[1];
  var_3 = angleclamp180(var_3);
  return var_3;
}

getyaw(var_0) {
  return vectortoyaw(var_0 - self.origin);
}

getaimyawtopoint3d(var_0) {
  var_1 = getyawtospot3d(var_0);
  var_2 = distance(self.origin, var_0);

  if(var_2 > 3) {
    var_3 = asin(-3 / var_2);
    var_1 = var_1 - var_3;
  }

  var_1 = angleclamp180(var_1);
  return var_1;
}

getyawtospot3d(var_0) {
  var_1 = var_0 - self.origin;
  var_2 = rotatevectorinverted(var_1, self.angles);
  var_3 = vectortoyaw(var_2);
  var_4 = angleclamp180(var_3);
  return var_4;
}

getaimpitchtopoint3d(var_0) {
  var_1 = getpitchtospot3d(var_0);
  var_2 = distance(self.origin, var_0);

  if(var_2 > 3) {
    var_3 = asin(-3 / var_2);
    var_1 = var_1 - var_3;
  }

  var_1 = angleclamp180(var_1);
  return var_1;
}

getpitchtospot3d(var_0) {
  var_1 = var_0 - self.origin;
  var_2 = rotatevectorinverted(var_1, self.angles);
  var_3 = vectortopitch(var_2);
  var_4 = angleclamp180(var_3);
  return var_4;
}

getplayerpitch(var_0) {
  var_1 = var_0 getplayerangles();
  return (var_1[0] + 360) % 360;
}

getplayeryaw(var_0) {
  var_1 = var_0 getplayerangles();
  return (var_1[1] + 360) % 360;
}

actor_isspace() {
  return istrue(self.space);
}

actor_is3d() {
  return actor_isspace();
}

getpredictedaimyawtoshootentorpos(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    if(!isDefined(var_2))
      return 0;

    return getaimyawtopoint(var_2);
  }

  var_3 = (0, 0, 0);

  if(isPlayer(var_1))
    var_3 = var_1 getvelocity();
  else if(isai(var_1))
    var_3 = var_1.velocity;

  var_4 = var_1.origin + var_3 * var_0;
  return getaimyawtopoint(var_4);
}

getpredictedaimyawtoshootentorpos3d(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    if(!isDefined(var_2))
      return 0;

    return getaimyawtopoint3d(var_2);
  }

  var_3 = (0, 0, 0);

  if(isPlayer(var_1))
    var_3 = var_1 getvelocity();
  else if(isai(var_1))
    var_3 = var_1.velocity;

  var_4 = var_1.origin + var_3 * var_0;
  return getaimyawtopoint3d(var_4);
}

getpredictedaimpitchtoshootentorpos3d(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    if(!isDefined(var_2))
      return 0;

    return getaimpitchtopoint3d(var_2);
  }

  var_3 = (0, 0, 0);

  if(isPlayer(var_1))
    var_3 = var_1 getvelocity();
  else if(isai(var_1))
    var_3 = var_1.velocity;

  var_4 = var_1.origin + var_3 * var_0;
  return getaimpitchtopoint3d(var_4);
}

is_equal(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1) && var_0 == var_1)
    return 1;

  return 0;
}

player_is_in_jackal() {
  return 0;
}

set_createfx_enabled() {
  if(!isDefined(level.createfx_enabled))
    level.createfx_enabled = getDvar("_encstr_A7A10BE87FB447783F6F314482") != "_encstr_B40101";
}

flag_set_delayed(var_0, var_1, var_2) {
  wait(var_1);
  flag_set(var_0, var_2);
}

noself_array_call(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    foreach(var_6 in var_0)
    call[[var_1]](var_6, var_2, var_3, var_4);

    return;
  }

  if(isDefined(var_3)) {
    foreach(var_6 in var_0)
    call[[var_1]](var_6, var_2, var_3);

    return;
  }

  if(isDefined(var_2)) {
    foreach(var_6 in var_0)
    call[[var_1]](var_6, var_2);

    return;
  }

  foreach(var_6 in var_0)
  call[[var_1]](var_6);
}

flag_assert(var_0) {}

flag_wait_either(var_0, var_1) {
  for(;;) {
    if(flag(var_0)) {
      return;
    }
    if(flag(var_1)) {
      return;
    }
    level waittill_either(var_0, var_1);
  }
}

flag_wait_either_return(var_0, var_1) {
  for(;;) {
    if(flag(var_0))
      return var_0;

    if(flag(var_1))
      return var_1;

    var_2 = level _id_143AD(var_0, var_1);
    return var_2;
  }
}

flag_wait_any(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];

  if(isDefined(var_5)) {
    var_6[var_6.size] = var_0;
    var_6[var_6.size] = var_1;
    var_6[var_6.size] = var_2;
    var_6[var_6.size] = var_3;
    var_6[var_6.size] = var_4;
    var_6[var_6.size] = var_5;
  } else if(isDefined(var_4)) {
    var_6[var_6.size] = var_0;
    var_6[var_6.size] = var_1;
    var_6[var_6.size] = var_2;
    var_6[var_6.size] = var_3;
    var_6[var_6.size] = var_4;
  } else if(isDefined(var_3)) {
    var_6[var_6.size] = var_0;
    var_6[var_6.size] = var_1;
    var_6[var_6.size] = var_2;
    var_6[var_6.size] = var_3;
  } else if(isDefined(var_2)) {
    var_6[var_6.size] = var_0;
    var_6[var_6.size] = var_1;
    var_6[var_6.size] = var_2;
  } else if(isDefined(var_1)) {
    flag_wait_either(var_0, var_1);
    return;
  } else
    return;

  for(;;) {
    for(var_7 = 0; var_7 < var_6.size; var_7++) {
      if(flag(var_6[var_7]))
        return;
    }

    level waittill_any(var_0, var_1, var_2, var_3, var_4, var_5);
  }
}

flag_wait_any_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = var_0 * 1000;
  var_8 = gettime();
  var_9 = [];

  if(isDefined(var_6)) {
    var_9[var_9.size] = var_1;
    var_9[var_9.size] = var_2;
    var_9[var_9.size] = var_3;
    var_9[var_9.size] = var_4;
    var_9[var_9.size] = var_5;
    var_9[var_9.size] = var_6;
  } else if(isDefined(var_5)) {
    var_9[var_9.size] = var_1;
    var_9[var_9.size] = var_2;
    var_9[var_9.size] = var_3;
    var_9[var_9.size] = var_4;
    var_9[var_9.size] = var_5;
  } else if(isDefined(var_4)) {
    var_9[var_9.size] = var_1;
    var_9[var_9.size] = var_2;
    var_9[var_9.size] = var_3;
    var_9[var_9.size] = var_4;
  } else if(isDefined(var_3)) {
    var_9[var_9.size] = var_1;
    var_9[var_9.size] = var_2;
    var_9[var_9.size] = var_3;
  } else if(isDefined(var_2)) {
    var_9[var_9.size] = var_1;
    var_9[var_9.size] = var_2;
  } else
    return;

  for(;;) {
    foreach(var_11 in var_9) {
      if(flag(var_11))
        return;
    }

    var_13 = gettime();

    if(var_13 >= var_8 + var_7) {
      break;
    }

    var_14 = var_7 - (var_13 - var_8);
    var_15 = var_14 / 1000;
    internal_wait_for_any_flag_or_time_elapses(var_9, var_15);
  }
}

internal_wait_for_any_flag_or_time_elapses(var_0, var_1) {
  foreach(var_3 in var_0)
  level endon(var_3);

  wait(var_1);
}

flag_wait_any_return(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];

  if(isDefined(var_4)) {
    var_5[var_5.size] = var_0;
    var_5[var_5.size] = var_1;
    var_5[var_5.size] = var_2;
    var_5[var_5.size] = var_3;
    var_5[var_5.size] = var_4;
  } else if(isDefined(var_3)) {
    var_5[var_5.size] = var_0;
    var_5[var_5.size] = var_1;
    var_5[var_5.size] = var_2;
    var_5[var_5.size] = var_3;
  } else if(isDefined(var_2)) {
    var_5[var_5.size] = var_0;
    var_5[var_5.size] = var_1;
    var_5[var_5.size] = var_2;
  } else if(isDefined(var_1)) {
    var_6 = flag_wait_either_return(var_0, var_1);
    return var_6;
  } else
    return;

  for(;;) {
    for(var_7 = 0; var_7 < var_5.size; var_7++) {
      if(flag(var_5[var_7]))
        return var_5[var_7];
    }

    var_6 = level _id_143B0(var_0, var_1, var_2, var_3, var_4);
    return var_6;
  }
}

flag_wait_all(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0))
    flag_wait(var_0);

  if(isDefined(var_1))
    flag_wait(var_1);

  if(isDefined(var_2))
    flag_wait(var_2);

  if(isDefined(var_3))
    flag_wait(var_3);
}

flag_wait_or_timeout(var_0, var_1) {
  var_2 = var_1 * 1000;
  var_3 = gettime();

  for(;;) {
    if(flag(var_0)) {
      break;
    }

    if(gettime() >= var_3 + var_2) {
      break;
    }

    var_4 = var_2 - (gettime() - var_3);
    var_5 = var_4 / 1000;
    wait_for_flag_or_time_elapses(var_0, var_5);
  }
}

flag_waitopen_or_timeout(var_0, var_1) {
  var_2 = gettime();

  for(;;) {
    if(!flag(var_0)) {
      break;
    }

    if(gettime() >= var_2 + var_1 * 1000) {
      break;
    }

    wait_for_flag_or_time_elapses(var_0, var_1);
  }
}

wait_for_flag_or_time_elapses(var_0, var_1) {
  level endon(var_0);
  wait(var_1);
}

noself_delaycall(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread noself_delaycall_proc(var_1, var_0, var_2, var_3, var_4, var_5);
}

noself_delaycall_proc(var_0, var_1, var_2, var_3, var_4, var_5) {
  wait(var_1);

  if(isDefined(var_5))
    call[[var_0]](var_2, var_3, var_4, var_5);
  else if(isDefined(var_4))
    call[[var_0]](var_2, var_3, var_4);
  else if(isDefined(var_3))
    call[[var_0]](var_2, var_3);
  else if(isDefined(var_2))
    call[[var_0]](var_2);
  else
    call[[var_0]]();
}

get_target_array(var_0) {
  if(!isDefined(var_0))
    var_0 = self.target;

  var_1 = getEntArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_1.size > 0)
    return var_1;

  if(scripts\common\utility::issp()) {
    var_1 = call[[level.getnodearrayfunction]](var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(var_1.size > 0)
      return var_1;
  }

  var_1 = getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_1.size > 0)
    return var_1;

  var_1 = getvehiclenodearray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_1.size > 0)
    return var_1;
}

pauseeffect() {
  scripts\common\createfx::stop_fx_looper();
}

spawn_script_origin(var_0, var_1) {
  if(!isDefined(var_1) && isDefined(self.angles))
    var_1 = self.angles;

  if(!isDefined(var_0) && isDefined(self.origin))
    var_0 = self.origin;
  else if(!isDefined(var_0))
    var_0 = (0, 0, 0);

  var_2 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0);

  if(isDefined(var_1))
    var_2.angles = var_1;

  return var_2;
}

get_noteworthy_array(var_0) {
  var_1 = getEntArray(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(var_1.size > 0)
    return var_1;

  if(scripts\common\utility::issp()) {
    var_1 = call[[level.getnodearrayfunction]](var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

    if(var_1.size > 0)
      return var_1;
  }

  var_1 = getStructArray(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(var_1.size > 0)
    return var_1;

  var_1 = getvehiclenodearray(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(var_1.size > 0)
    return var_1;
}

get_cumulative_weights(var_0) {
  var_1 = [];
  var_2 = 0;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_2 = var_2 + var_0[var_3];
    var_1[var_3] = var_2;
  }

  return var_1;
}

void() {}

getanim(var_0) {
  return level.scr_anim[self.animname][var_0];
}

hasanim(var_0) {
  return isDefined(level.scr_anim[self.animname][var_0]);
}

getanim_from_animname(var_0, var_1) {
  return level.scr_anim[var_1][var_0];
}

getanim_generic(var_0) {
  return level.scr_anim["_encstr_979608DF73C8E70B73A1"][var_0];
}

hasanim_generic(var_0) {
  return isDefined(level.scr_anim["_encstr_979608DF73C8E70B73A1"][var_0]);
}

waittill_match_or_timeout(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3 endon("_encstr_AF9A099E17EA0831658B71");
  var_3 delaythread(var_2, ::send_notify, "_encstr_AF9A099E17EA0831658B71");
  self waittillmatch(var_0, var_1);
}

waittill_match_or_timeout_return(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3 endon("_encstr_AF9A099E17EA0831658B71");
  var_3 delaythread(var_2, ::send_notify, "_encstr_AF9A099E17EA0831658B71");
  self waittill(var_0, var_1);
  return var_1;
}

send_notify(var_0, var_1) {
  if(isDefined(var_1))
    self notify(var_0, var_1);
  else
    self notify(var_0);
}

get_notetrack_time(var_0, var_1) {
  var_2 = getnotetracktimes(var_0, var_1);
  var_3 = getanimlength(var_0);
  return var_2[0] * var_3;
}

mph_to_ips(var_0) {
  return var_0 * 17.6;
}

ips_to_mph(var_0) {
  return var_0 * 0.056818;
}

add_dialogue_line(var_0, var_1, var_2) {
  if(getdvarint("_encstr_B42B0D7B2520389FE10D2818521073", 0)) {
    return;
  }
  if(!isDefined(level.dialogue_huds))
    level.dialogue_huds = [];

  if(level.dialogue_huds.size == 5) {
    var_3 = level.dialogue_huds[0];
    level.dialogue_huds = array_remove_index(level.dialogue_huds, 0);
    update_dialogue_huds();
    var_3 thread destroy_dialogue_hud();
  }

  var_4 = "_encstr_A60703890B";

  if(isDefined(var_2)) {
    switch (var_2) {
      case "_encstr_8419044EB232":
      case "_encstr_844C029C":
        var_4 = "_encstr_B40703A9CB";
        break;
      case "_encstr_932906F74A6F1818":
      case "_encstr_A74C0277":
        var_4 = "_encstr_B20703DE66";
        break;
      case "_encstr_957407BAC223B9F05B":
      case "_encstr_AA4C0279":
        var_4 = "_encstr_A60703890B";
        break;
      case "_encstr_B29B0550F33591":
      case "_encstr_8B4C024C":
        var_4 = "_encstr_8A07037EF7";
        break;
      case "_encstr_8690056688C20D":
      case "_encstr_834C02D8":
        var_4 = "_encstr_840703710E";
        break;
      case "_encstr_97E9070B6083A01213":
      case "_encstr_A64C0223":
        var_4 = "_encstr_AD0703B91A";
        break;
      case "_encstr_998806DD1A96D12B":
      case "_encstr_954C0277":
        var_4 = "_encstr_8507034357";
        break;
      case "_encstr_83AB065EE1391A7B":
      case "_encstr_8307030610":
        var_4 = "_encstr_AA0703CB1C";
        break;
    }
  }

  var_5 = 1;

  if(isDefined(level.dialoguelinescale))
    var_5 = level.dialoguelinescale;

  var_6 = newhudelem();
  var_6.elemtype = "_encstr_9779056EEA2583";
  var_6.font = "_encstr_8B1608EC43B8D647A113";
  var_6.fontscale = var_5;
  var_6.x = 0;
  var_6.y = 0;
  var_6.width = 0;
  var_6.height = int(level.fontheight * var_5);
  var_6.xoffset = 0;
  var_6.yoffset = 0;
  var_7 = level.dialogue_huds.size;
  level.dialogue_huds[var_7] = var_6;
  var_6.foreground = 1;
  var_6.sort = 20;
  var_6.x = 40;
  var_6.y = 260 + var_7 * (12 * var_5);
  var_6.label = "_encstr_B40101" + var_4 + var_0 + "_encstr_8E4C058280DB43" + var_1;
  var_6.alpha = 0;
  var_6 fadeovertime(0.2);
  var_6.alpha = 1;
  var_6 endon("_encstr_AD75063D571AE108");
  wait 8;
  level.dialogue_huds = array_remove(level.dialogue_huds, var_6);
  update_dialogue_huds();
  var_6 thread destroy_dialogue_hud();
}

destroy_dialogue_hud() {
  var_0 = 1;

  if(isDefined(level.dialoguelinescale))
    var_0 = level.dialoguelinescale;

  self endon("_encstr_AD75063D571AE108");
  self fadeovertime(0.2);
  self moveovertime(0.2);
  self.y = self.y - 12 * var_0;
  self.alpha = 0;
  wait 0.2;
  self destroy();
}

update_dialogue_huds() {
  var_0 = 1;

  if(isDefined(level.dialoguelinescale))
    var_0 = level.dialoguelinescale;

  level.dialogue_huds = array_removeundefined(level.dialogue_huds);

  foreach(var_3, var_2 in level.dialogue_huds) {
    var_2 moveovertime(0.2);
    var_2.y = 260 + var_3 * 12 * var_0;
  }
}

closestdistancebetweenlines(var_0, var_1, var_2, var_3) {
  var_4 = var_0 - var_2;
  var_5 = var_3 - var_2;

  if(abs(var_5[0]) < 0.000001 && abs(var_5[1]) < 0.000001 && abs(var_5[2]) < 0.000001)
    return undefined;

  var_6 = var_1 - var_0;

  if(abs(var_6[0]) < 0.000001 && abs(var_6[1]) < 0.000001 && abs(var_6[2]) < 0.000001)
    return undefined;

  var_7 = var_4[0] * var_5[0] + var_4[1] * var_5[1] + var_4[2] * var_5[2];
  var_8 = var_5[0] * var_6[0] + var_5[1] * var_6[1] + var_5[2] * var_6[2];
  var_9 = var_4[0] * var_6[0] + var_4[1] * var_6[1] + var_4[2] * var_6[2];
  var_10 = var_5[0] * var_5[0] + var_5[1] * var_5[1] + var_5[2] * var_5[2];
  var_11 = var_6[0] * var_6[0] + var_6[1] * var_6[1] + var_6[2] * var_6[2];
  var_12 = var_11 * var_10 - var_8 * var_8;

  if(abs(var_12) < 0.000001)
    return undefined;

  var_13 = var_7 * var_8 - var_9 * var_10;
  var_14 = var_13 / var_12;
  var_15 = (var_7 + var_8 * var_14) / var_10;
  var_16 = var_0 + var_14 * var_6;
  var_17 = var_2 + var_15 * var_5;
  var_18 = [var_16, var_17, distance(var_16, var_17)];
  return var_18;
}

closestdistancebetweensegments(var_0, var_1, var_2, var_3) {
  var_4 = var_1 - var_0;
  var_5 = var_3 - var_2;
  var_6 = var_0 - var_2;
  var_7 = vectordot(var_4, var_4);
  var_8 = vectordot(var_4, var_5);
  var_9 = vectordot(var_5, var_5);
  var_10 = vectordot(var_4, var_6);
  var_11 = vectordot(var_5, var_6);
  var_12 = var_7 * var_9 - var_8 * var_8;
  var_13 = var_12;
  var_14 = var_12;
  var_15 = 0;
  var_16 = 0;
  var_17 = 0;
  var_18 = 0;

  if(var_12 < 0.00000001) {
    var_16 = 0;
    var_13 = 1;
    var_18 = var_11;
    var_14 = var_9;
  } else {
    var_16 = var_8 * var_11 - var_9 * var_10;
    var_18 = var_7 * var_11 - var_8 * var_10;

    if(var_16 < 0.0) {
      var_16 = 0;
      var_18 = var_11;
      var_14 = var_9;
    } else if(var_16 > var_13) {
      var_16 = var_13;
      var_18 = var_11 + var_8;
      var_14 = var_9;
    }
  }

  if(var_18 < 0.0) {
    var_18 = 0.0;

    if(var_10 * -1 < 0.0)
      var_16 = 0.0;
    else if(var_10 * -1 > var_7)
      var_16 = var_13;
    else {
      var_16 = var_10 * -1;
      var_13 = var_7;
    }
  } else if(var_18 > var_14) {
    var_18 = var_14;

    if(var_8 - var_10 < 0.0)
      var_16 = 0;
    else if(var_8 - var_10 > var_7)
      var_16 = var_13;
    else {
      var_16 = var_8 - var_10;
      var_13 = var_7;
    }
  }

  if(abs(var_16) > 0.00000001)
    var_15 = var_16 / var_13;

  if(abs(var_18) > 0.00000001)
    var_17 = var_18 / var_14;

  var_19 = var_0 + var_15 * var_4;
  var_20 = var_2 + var_17 * var_5;
  var_21 = [var_19, var_20, distance(var_19, var_20)];
  return var_21;
}

is_dead_sentient() {
  return issentient(self) && !isalive(self);
}

hastag(var_0, var_1) {
  if(!isDefined(var_0) || var_0 == "_encstr_B40101")
    return 0;

  if(!isDefined(level.has_tag))
    level.has_tag = [];

  var_2 = var_0 + "_encstr_BA4C02DF" + var_1;

  if(isDefined(level.has_tag[var_2]))
    return level.has_tag[var_2];

  var_3 = getnumparts(var_0);

  if(var_3 > 0) {
    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = tolower(getpartname(var_0, var_4));

      if(var_5 == tolower(var_1)) {
        level.has_tag[var_2] = 1;
        return 1;
      }
    }

    level.has_tag[var_2] = 0;
  }

  return 0;
}

flashbanggettimeleftsec() {
  var_0 = self.flashendtime - gettime();

  if(var_0 < 0)
    return 0;

  return var_0 * 0.001;
}

flashbangisactive() {
  return flashbanggettimeleftsec() > 0;
}

player_died_recently() {
  return getdvarint("_encstr_82621B831BB02F569CEBC8D2ACC8F59CB2D859CDA3D8E5BE6CEDEAB9E8", "_encstr_934C0218");
}

string(var_0) {
  return "_encstr_B40101" + var_0;
}

playsoundontag(var_0, var_1, var_2, var_3, var_4) {
  [[level.fnplaysoundontag]](var_0, var_1, var_2, var_3, var_4);
}

playsoundonentity(var_0, var_1) {
  [[level.fnplaysoundonentity]](var_0, var_1);
}

set_movement_speed(var_0) {
  self._blackboard.requestedspeed = var_0;
  self aisetdesiredspeed(var_0);
}

set_cautious_navigation(var_0) {
  self.cautiousnavigation = var_0;
}

set_bounding_overwatch(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "_encstr_93F019F62793E1B5817A18C092675B583FEF08F4853BEBDB337218";

  self.boundingoverwatchenabled = var_0;
  self.defaultcoverselector = var_1;
}

doinglongdeath() {
  return isDefined(self.a.doinglongdeath);
}

motionwarpwithnotetracks(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_3)) {
    var_7 = getnotetracktimes(var_0, var_3)[0];

    if(!isDefined(var_7))
      var_7 = 0;
  } else
    var_7 = 0;

  if(isDefined(var_4)) {
    var_8 = getnotetracktimes(var_0, var_4)[0];

    if(!isDefined(var_8))
      var_8 = 1;
  } else
    var_8 = 1;

  motionwarpwithtimes(var_0, var_1, var_2, var_7, var_8, var_5, var_6);
}

motionwarpwithtimes(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_6))
    var_6 = 1;

  var_7 = getangledelta(var_0, var_3, var_4);
  var_8 = getmovedelta(var_0, var_3, var_4);
  var_8 = rotatevector(var_8, (0, var_2[1] - var_7, 0));
  var_9 = var_1 - var_8;
  var_10 = var_2[1] - var_7;
  var_11 = (var_2[0], var_10, var_2[2]);
  var_12 = 1.0;
  var_13 = length(var_1 - self.origin);

  if(var_6 && var_13 > 0) {
    var_12 = length(var_8) / var_13;
    var_12 = clamp(var_12, 0.5, 2.0);
    self aisetanimrate(var_0, var_12);
  }

  if(!isDefined(var_5)) {
    var_14 = getanimlength(var_0) / var_12;
    var_5 = int((var_4 - var_3) * var_14 * 1000);
  }

  if(var_5 < 50)
    var_5 = 50;

  self motionwarpwithanim(var_9, var_11, var_1, var_2, var_5);
  return var_12;
}

waittill_any_ents_or_timeout_return(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  self endon("_encstr_AD75063D571AE108");
  var_15 = spawnStruct();
  var_1 childthread waittill_string(var_2, var_15);

  if(isDefined(var_3) && isDefined(var_4))
    var_3 childthread waittill_string(var_4, var_15);

  if(isDefined(var_5) && isDefined(var_6))
    var_5 childthread waittill_string(var_6, var_15);

  if(isDefined(var_7) && isDefined(var_8))
    var_7 childthread waittill_string(var_8, var_15);

  if(isDefined(var_9) && isDefined(var_10))
    var_9 childthread waittill_string(var_10, var_15);

  if(isDefined(var_11) && isDefined(var_12))
    var_11 childthread waittill_string(var_12, var_15);

  if(isDefined(var_13) && isDefined(var_14))
    var_13 childthread waittill_string(var_14, var_15);

  var_15 childthread _timeout(var_0);
  var_15 waittill("_encstr_BE3009989F7CABE51AAFDD", var_16);
  var_15 notify("_encstr_B81804322D2B");
  return var_16;
}

time_has_passed(var_0, var_1) {
  if(!isDefined(var_0))
    return 0;

  return gettime() - var_0 >= var_1 * 1000;
}

reacttolightifpossible(var_0) {
  self.lightreaction_lightorigin = var_0;
  self.lightreaction_requesttime = gettime();
}

setcovercrouchtype(var_0) {
  switch (var_0) {
    case "_encstr_8253060E2B5FE330":
      self.covercrouchtype = "_encstr_A777136710A315533956DC57A349AEFB8BA8377F40";
      break;
    case "_encstr_A5AD056A019C63":
      self.covercrouchtype = "_encstr_8267124310DE69AADAED119B9B5206A220A572E0";
      break;
    case "_encstr_B13D076BED70539F23":
    default:
      self.covercrouchtype = "_encstr_87AB0D4BD7B857DB077503DA9B8EEB";
  }
}

setcornerstepoutsdisabled(var_0) {
  self.cornerstepoutsdisabled = var_0;
}

getcornerstepoutsdisabled() {
  if(isDefined(self.cornerstepoutsdisabled))
    return self.cornerstepoutsdisabled;

  return 0;
}

can_trace_to_ai(var_0, var_1, var_2, var_3) {
  if(isent(self) || isai(self))
    var_4 = [self, var_1];
  else
    var_4 = [var_1];

  if(isDefined(var_2))
    var_4 = array_combine(var_4, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_0, var_1.origin, var_4, var_3))
    return 1;

  if(scripts\engine\trace::ray_trace_passed(var_0, var_1 gettagorigin("_encstr_8EEC09159F6238030BFA23"), var_4, var_3))
    return 1;

  if(scripts\engine\trace::ray_trace_passed(var_0, var_1 getEye(), var_4, var_3))
    return 1;

  return 0;
}

array_removedead_or_dying(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  var_2 = [];

  foreach(var_4 in var_0) {
    if(!isalive(var_4)) {
      continue;
    }
    if(isai(var_4) && var_1 && var_4 doinglongdeath()) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
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

  self.unique_id = "_encstr_A107039AA0" + level.ai_number;
  level.ai_number++;
}

ent_flag_wait(var_0) {
  while(isDefined(self) && !self.ent_flag[var_0])
    self waittill(var_0);
}

nuke_playmushroombnk(var_0, var_1, var_2, var_3) {
  while(isDefined(self)) {
    if(self.ent_flag[var_0] && self.ent_flag[var_1] && (!isDefined(var_2) || self.ent_flag[var_2]) && (!isDefined(var_3) || self.ent_flag[var_3])) {
      break;
    }

    _id_143A7(var_0, var_1, var_2, var_3);
  }
}

array_ent_flag_wait(var_0, var_1) {
  var_2 = spawnStruct();

  foreach(var_4 in var_0) {
    if(var_4 ent_flag(var_1))
      var_0 = array_remove(var_0, var_4);
  }

  array_thread(var_0, ::array_ent_flag_wait_proc, var_2, var_1);

  for(var_6 = 0; var_6 < var_0.size; var_6++)
    var_2 waittill("_encstr_853D07F580C80102E3");
}

array_ent_flag_wait_proc(var_0, var_1) {
  ent_flag_wait(var_1);
  var_0 notify("_encstr_853D07F580C80102E3");
}

ent_flag_wait_vehicle_node(var_0) {
  while(isDefined(self) && !self.ent_flag[var_0])
    self waittill(var_0);
}

ent_flag_wait_either(var_0, var_1) {
  while(isDefined(self)) {
    if(ent_flag(var_0)) {
      return;
    }
    if(ent_flag(var_1)) {
      return;
    }
    waittill_either(var_0, var_1);
  }
}

ent_flag_wait_or_timeout(var_0, var_1) {
  var_2 = gettime();

  while(isDefined(self)) {
    if(self.ent_flag[var_0]) {
      break;
    }

    if(gettime() >= var_2 + var_1 * 1000) {
      break;
    }

    ent_wait_for_flag_or_time_elapses(var_0, var_1);
  }
}

ent_wait_for_flag_or_time_elapses(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
}

ent_flag_waitopen(var_0) {
  while(isDefined(self) && self.ent_flag[var_0])
    self waittill(var_0);
}

ent_flag_assert(var_0) {}

ent_flag_waitopen_either(var_0, var_1) {
  while(isDefined(self)) {
    if(!ent_flag(var_0)) {
      return;
    }
    if(!ent_flag(var_1)) {
      return;
    }
    waittill_either(var_0, var_1);
  }
}

ent_flag_init(var_0) {
  if(!isDefined(self.ent_flag)) {
    self.ent_flag = [];
    self.ent_flags_lock = [];
  }

  self.ent_flag[var_0] = 0;
}

ent_flag_exist(var_0) {
  if(isDefined(self.ent_flag) && isDefined(self.ent_flag[var_0]))
    return 1;

  return 0;
}

ent_flag_set_delayed(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  wait(var_1);
  ent_flag_set(var_0);
}

ent_flag_set(var_0) {
  self.ent_flag[var_0] = 1;
  self notify(var_0);
}

ent_flag_clear(var_0, var_1) {
  if(self.ent_flag[var_0]) {
    self.ent_flag[var_0] = 0;
    self notify(var_0);
  }

  if(istrue(var_1))
    self.ent_flag[var_0] = undefined;
}

ent_flag_clear_delayed(var_0, var_1) {
  wait(var_1);

  if(isDefined(self))
    ent_flag_clear(var_0);
}

ent_flag(var_0) {
  return self.ent_flag[var_0];
}

get_linked_structs() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = get_links();

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = getStructArray(var_1[var_2], "_encstr_A29D10371B275A1C47F536969BDAB90BB5B2");

      if(var_3.size > 0)
        var_0 = array_combine(var_0, var_3);
    }
  }

  return var_0;
}

updatescrapassistdata(var_0, var_1, var_2) {
  if(squared(var_0[0] - var_1[0]) + squared(var_0[1] - var_1[1]) <= squared(var_2))
    return 1;

  return 0;
}

_id_12C44(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self setpredictedstreamloaddist(var_0);

  for(;;) {
    self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_1, var_2);

    if(var_1 == "_encstr_8BF1150278AB37A36B663736F3B0A7F1FD20EBBBF02FAB")
      return var_2;
  }
}

update_hint_logic_killstreak() {
  var_0 = 1;
  var_1 = 0;

  if(is_player_gamepad_enabled())
    var_1 = _id_12C44("_encstr_8511126B0FE38018829B435B0586E948EA83FBF7");
  else
    var_1 = _id_12C44("_encstr_AD26156A1A7593E305C763A330EBCF62401A1C970A4964");

  return var_1 != var_0;
}

remove_player_rig_laser_panel(var_0) {
  if(isnumber(var_0))
    return int(var_0);
  else
    return 0;
}

_id_13926(var_0) {
  var_1 = (0, 0, 0);
  var_2 = strtok(var_0, "_encstr_974C0246");

  if(var_2.size == 3)
    var_1 = (float(var_2[0]), float(var_2[1]), float(var_2[2]));

  return var_1;
}

_encstr_A60611BAC359A32CD843EAFC53C07507727BE3(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    var_6 = tablelookup(var_5, var_1, var_2, var_3);

    if(isDefined(var_6))
      return var_6;
  }

  return undefined;
}