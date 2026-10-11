/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3ce4651e69c721db.gsc
*************************************************/

#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\overlord;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#namespace ob_intel;

function function_d84b63f3cd2befe() {
  if(getdvarint(@ "hash_1fbc80ee0748782c", 1) > 0) {
    level.var_d97f7ce3bb56f2a3 = [];
    level.var_d97f7ce3bb56f2a3["deadbolt_audio_intel"] = getentitylessscriptablearray("deadbolt_audio_intel", "targetname");
    level.var_d97f7ce3bb56f2a3["deadbolt_radio_intel"] = getentitylessscriptablearray("deadbolt_radio_intel", "targetname");
    level.var_d97f7ce3bb56f2a3["terminus_audio_intel"] = getentitylessscriptablearray("terminus_audio_intel", "targetname");
    level.var_d97f7ce3bb56f2a3["terminus_radio_intel"] = getentitylessscriptablearray("terminus_radio_intel", "targetname");
    var_455fcf129b9a4773 = getStructArray("terminus_audio_intel_warlord", "targetname");
    level.ob.var_3c0bad034d227d02 = var_455fcf129b9a4773;
    level.var_d97f7ce3bb56f2a3["note_intel"] = getentitylessscriptablearray("note_intel", "targetname");
    thread function_bcd3ff1413e1f37a();
    thread handle_intel();
    scripts\engine\scriptable::scriptable_addusedcallback(&function_d49b531543df8201);
  }
}

function private function_bcd3ff1413e1f37a() {
  if(isDefined(level.var_d97f7ce3bb56f2a3) && isDefined(level.var_d97f7ce3bb56f2a3["note_intel"])) {
    foreach(note in level.var_d97f7ce3bb56f2a3["note_intel"]) {
      note setscriptablepartstate("state", note.script_noteworthy);

      note thread function_b3212476aba49bc();
    }
  }
}

function handle_intel() {
  foreach(intel in level.var_d97f7ce3bb56f2a3["deadbolt_audio_intel"]) {
    if(isDefined(intel.script_parameters) && int(intel.script_parameters) > getdvarint(@ "hash_ddc349005b4d9cbb", 5)) {
      intel setscriptablepartstate("state", "hidden");
    }

    intel thread function_6e50624e2c06832b();
  }

  foreach(intel in level.var_d97f7ce3bb56f2a3["deadbolt_radio_intel"]) {
    if(isDefined(intel.script_parameters) && int(intel.script_parameters) > getdvarint(@ "hash_ddc349005b4d9cbb", 5)) {
      intel setscriptablepartstate("state", "hidden");
    }

    intel thread function_6e50624e2c06832b();
  }

  foreach(intel in level.var_d97f7ce3bb56f2a3["terminus_audio_intel"]) {
    if(isDefined(intel.script_parameters) && int(intel.script_parameters) > getdvarint(@ "hash_ddc349005b4d9cbb", 5)) {
      intel setscriptablepartstate("state", "hidden");
    }

    intel thread function_6e50624e2c06832b();
  }

  foreach(intel in level.var_d97f7ce3bb56f2a3["terminus_radio_intel"]) {
    if(isDefined(intel.script_parameters) && int(intel.script_parameters) > getdvarint(@ "hash_ddc349005b4d9cbb", 5)) {
      intel setscriptablepartstate("state", "hidden");
    }

    intel thread function_6e50624e2c06832b();
  }
}

function function_6e50624e2c06832b() {
  while(true) {
    if(getdvarint(@ "debug_intel", 0)) {
      print3d(self.origin + (0, 0, 10), self.script_noteworthy, undefined, undefined, 0.5, undefined, 1);
    }

    waitframe();
  }
}

function function_b3212476aba49bc() {
  while(true) {
    if(getdvarint(@ "debug_intel", 0)) {
      print3d(self.origin + (0, 0, 10), self.script_noteworthy, undefined, undefined, 0.5, undefined, 1);
    }

    waitframe();
  }
}

function function_d49b531543df8201(instance, part, state, player, bautouse, usestring) {
  if(!isDefined(instance) || !issubstr(instance.type, "ob_intel")) {
    return;
  }

  instance setscriptablepartstate("state", "unusable");
  function_ab1fd5a8c819c1bf(instance);
  wait 1;

  if(isDefined(instance.script_noteworthy)) {
    scripts\cp_mp\overlord::playconversation(instance.script_noteworthy, undefined, undefined, 0, instance.origin + (0, 0, 10), "overlord_intel");
  } else if(isDefined(instance.var_84e2ca49013808d2)) {
    scripts\cp_mp\overlord::playconversation(instance.var_84e2ca49013808d2, undefined, undefined, 0, instance.origin + (0, 0, 10), "overlord_intel");
  }

  instance setscriptablepartstate("intel_sfx", "stop");
  instance thread function_9690c337583e3ab2();
}

function private function_9690c337583e3ab2() {
  level endon("game_ended");
  wait 5;
  self setscriptablepartstate("state", "usable");
}

function private function_ab1fd5a8c819c1bf(instance) {
  if(isDefined(instance.script_noteworthy)) {
    switch (instance.script_noteworthy) {
      case #"hash_450ee5bc3bffa66b":
        instance setscriptablepartstate("intel_sfx", "start_mistake");
        break;
      case #"hash_25899687670ee5e6":
        instance setscriptablepartstate("intel_sfx", "start_mobilearmor");
        break;
      case #"hash_b04f01e7240b4bf6":
        instance setscriptablepartstate("intel_sfx", "start_chaosdown");
        break;
      case #"hash_77e01a6cb42f6303":
        instance setscriptablepartstate("intel_sfx", "start_testing");
        break;
      case #"hash_a202261611d5d72":
        instance setscriptablepartstate("intel_sfx", "start_whoisthisguy");
        break;
      default:
        instance setscriptablepartstate("intel_sfx", "start");
        break;
    }

    return;
  }

  if(isDefined(instance.var_84e2ca49013808d2)) {
    switch (instance.var_84e2ca49013808d2) {
      case #"hash_450ee5bc3bffa66b":
        instance setscriptablepartstate("intel_sfx", "start_mistake");
        break;
      case #"hash_25899687670ee5e6":
        instance setscriptablepartstate("intel_sfx", "start_mobilearmor");
        break;
      case #"hash_b04f01e7240b4bf6":
        instance setscriptablepartstate("intel_sfx", "start_chaosdown");
        break;
      case #"hash_77e01a6cb42f6303":
        instance setscriptablepartstate("intel_sfx", "start_testing");
        break;
      case #"hash_a202261611d5d72":
        instance setscriptablepartstate("intel_sfx", "start_whoisthisguy");
        break;
      default:
        instance setscriptablepartstate("intel_sfx", "start");
        break;
    }
  }
}