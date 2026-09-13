/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_dev.gsc
***********************************************/

init() {
  _id_0FEA74CA25A69884::init();
}

commandwatcher(_id_338635CE4E1CA9AF, _id_0D4BB121B87421C8) {
  level notify("commandWatcher_" + _func_A1A5654DB94DBB07(_id_338635CE4E1CA9AF));
  level endon("commandWatcher_" + _func_A1A5654DB94DBB07(_id_338635CE4E1CA9AF));
  setDvar(_id_338635CE4E1CA9AF, "");

  for(;;) {
    waitframe();
    _id_6686D1519FD59C8D = getDvar(_id_338635CE4E1CA9AF);

    if(_id_6686D1519FD59C8D == "") {
      continue;
    }
    setDvar(_id_338635CE4E1CA9AF, "");
    _id_67F14F8315CB0F2F = strtok(_id_6686D1519FD59C8D, " ");

    if(!isDefined(_id_67F14F8315CB0F2F) || _id_67F14F8315CB0F2F.size < 1) {
      continue;
    }
    _id_10D8148F3496F8DE = _id_67F14F8315CB0F2F[0];
    _id_33D958E9FE93F83B = scripts\engine\utility::array_slice(_id_67F14F8315CB0F2F, 1);
    [[_id_0D4BB121B87421C8]](_id_10D8148F3496F8DE, _id_33D958E9FE93F83B);
  }
}

handlecommand(_id_10D8148F3496F8DE, _id_434809FD34BABEE0) {
  if(!isDefined(level.handlecommandfuncs)) {
    return;
  }
  foreach(func in level.handlecommandfuncs)[[func]](_id_10D8148F3496F8DE, _id_434809FD34BABEE0);
}

registerhandlecommand(func) {
  if(!isDefined(level.handlecommandfuncs))
    level.handlecommandfuncs = [];

  level.handlecommandfuncs[level.handlecommandfuncs.size] = func;
}