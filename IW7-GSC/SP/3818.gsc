/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3818.gsc
**************************************/

_id_EF96() {
  level _id_0EFB::_id_FE05();
  level thread _id_0EB0::main();
  level thread _id_0EA2::main();
  level thread _id_0EA4::_id_9767();
  level thread _id_0E9F::_id_9767();
  level thread _id_0ED9::main();
  level thread _id_0E70::_id_B212();
  level thread _id_0E70::_id_B246();
  level thread _id_0E70::_id_B1C4();
  level thread _id_0E70::_id_B193();
  level thread _id_0E70::_id_B1B5();
  level thread _id_0E70::_id_B1BB();
  level thread _id_0E70::_id_B17C();
  level thread _id_0E70::_id_B182();
  level thread _id_0E70::_id_B17B();
  level thread _id_0E70::_id_B178();
  level thread _id_0E70::_id_B179();
  level thread _id_0E70::_id_B17A();
  var_0 = scripts\engine\utility::getStructArray("scs_console", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2._id_EE52) || var_2._id_EE52 != "console")
      var_0 = scripts\engine\utility::array_remove(var_0, var_2);
  }

  foreach(var_2 in var_0) {
    var_5 = strtok(var_2.script_parameters, " ");
    level._id_FD6E._id_454F[var_5[0]] = var_2;
    level._id_FD6E._id_454F[var_5[0]]._id_EE92 = "sitting_console";

    if(isDefined(var_5[1]))
      level._id_FD6E._id_454F[var_5[0]]._id_EE92 = var_5[1];

    level._id_FD6E._id_454F[var_5[0]]._id_ECCE = _id_0EFB::_id_7993("scs_console", "script_noteworthy", var_5[0]);

    foreach(var_7 in level._id_FD6E._id_454F[var_5[0]]._id_ECCE) {
      if(isDefined(var_7.script_noteworthy)) {
        if(getsubstr(var_7.script_noteworthy, 0, 6) != "screen")
          level._id_FD6E._id_454F[var_5[0]]._id_ECCE = scripts\engine\utility::array_remove(level._id_FD6E._id_454F[var_5[0]]._id_ECCE, var_7);

        continue;
      }

      level._id_FD6E._id_454F[var_5[0]]._id_ECCE = scripts\engine\utility::array_remove(level._id_FD6E._id_454F[var_5[0]]._id_ECCE, var_7);
    }

    var_9 = _id_0EFB::_id_799B(level._id_FD6E._id_454F[var_5[0]]._id_ECCE, "screenl");

    if(var_9.size > 1)
      level._id_FD6E._id_454F[var_5[0]] thread _id_EF97(var_9);

    var_10 = _id_0EFB::_id_799B(level._id_FD6E._id_454F[var_5[0]]._id_ECCE, "screenr");

    if(var_10.size > 1)
      level._id_FD6E._id_454F[var_5[0]] thread _id_EF97(var_10);

    var_11 = _id_0EFB::_id_799B(level._id_FD6E._id_454F[var_5[0]]._id_ECCE, "screent");

    if(var_11.size > 1)
      level._id_FD6E._id_454F[var_5[0]] thread _id_EF97(var_11);

    var_12 = _id_0EFB::_id_799B(level._id_FD6E._id_454F[var_5[0]]._id_ECCE, "screenm");

    if(var_12.size > 1)
      level._id_FD6E._id_454F[var_5[0]] thread _id_EF97(var_12);

    var_13 = _id_0EFB::_id_799B(level._id_FD6E._id_454F[var_5[0]]._id_ECCE, "screenb");

    if(var_13.size > 1)
      level._id_FD6E._id_454F[var_5[0]] thread _id_EF97(var_13);
  }
}

_id_EF97(var_0) {
  self endon("death");

  for(;;) {
    scripts\engine\utility::array_call(var_0, ::hide);
    var_0[randomintrange(0, var_0.size)] show();
    wait(randomfloatrange(10, 20));
  }
}

_id_EF95(var_0) {
  if(isDefined(var_0))
    _id_0EFB::_id_EFDB(var_0).script_noteworthy = "";
  else {
    foreach(var_0 in level._id_FD6E._id_454F)
    var_0.script_noteworthy = "";
  }
}