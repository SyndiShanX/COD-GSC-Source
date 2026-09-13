/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_juggernaut.gsc
**************************************************************/

init() {
  _id_7EC7671A1E0C788F = spawnStruct();
  _id_7EC7671A1E0C788F.weight = getdvarfloat("dvar_69FC5A189EE86589", 0);
  _id_7EC7671A1E0C788F.activatefunc = ::activatefunc;
  _id_7EC7671A1E0C788F.validatefunc = ::validatefunc;
  _id_7EC7671A1E0C788F.waitfunc = ::waitfunc;
  _id_7EC7671A1E0C788F._id_C9E871D29702E8CF = ::_id_C9E871D29702E8CF;
  _id_7EC7671A1E0C788F._id_D72A1842C5B57D1D = getdvarint("dvar_77E79A66C45F07F0", 0);
  _id_7EC7671A1E0C788F._id_F0F6529C88A18128 = _id_337BD370F7C5E6F9::_id_4634160166FB7F8B("juggernaut", "00 0 00 0 0 0");
  _id_7EC7671A1E0C788F._id_B9B56551E1ACFEE2 = _id_294DDA4A4B00FFE3::_id_8BE9BAE8228A91F7("juggernaut");
  _id_337BD370F7C5E6F9::registerpublicevent(4, _id_7EC7671A1E0C788F);
}

_id_C9E871D29702E8CF() {
  game["dialog"]["public_events_juggernaut_start"] = "public_events_juggernaut_start";
  _id_E08A748C5DB18C99 = getdvarint("dvar_584AEBD3A63695F9", 0);
  _id_29C32B7117E01180::init_br_jugg_setting("drop_on_death", _id_E08A748C5DB18C99, "public_event");
}

validatefunc() {
  return level.brgametype.name != "jugg";
}

waitfunc() {
  level endon("game_ended");
  level endon("cancel_public_event");
  _id_98489428013A0100 = calculateeventstarttime();
  wait(_id_98489428013A0100);
}

activatefunc() {
  _id_FDFC755D4AA965C6 = _id_29C32B7117E01180::getnumdrops();
  level.juggdroplocations = scripts\engine\utility::array_randomize(level.juggdroplocations);
  droplocations = _id_29C32B7117E01180::showdroplocations(_id_FDFC755D4AA965C6, 0);
  _id_2CEDCC356F1B9FC8::brleaderdialog("public_events_juggernaut_start");
  level _id_29C32B7117E01180::startdeliveries(droplocations, "public_event");
  waitforallcrates();
}

waitforallcrates() {
  for(;;) {
    wait 1;
    _id_D1D10A1EB4A59F38 = 0;

    foreach(crate in level.c130successfulairdrops) {
      if(crate.cratetype == "battle_royale_juggernaut") {
        _id_D1D10A1EB4A59F38 = 1;
        break;
      }
    }

    if(!_id_D1D10A1EB4A59F38) {
      break;
    }
  }
}

calculateeventstarttime() {
  _id_87940078241E4580 = getdvarfloat("dvar_68FDB38445CBED05", 795.0);
  _id_07AF9598177DC2DE = getdvarfloat("dvar_6920BD8445F24ABB", 1110.0);

  if(_id_07AF9598177DC2DE > _id_87940078241E4580)
    return randomfloatrange(_id_87940078241E4580, _id_07AF9598177DC2DE);
  else
    return _id_87940078241E4580;
}